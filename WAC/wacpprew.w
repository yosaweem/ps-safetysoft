&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: WACROSCL.W

  Description: Printing Report for Outstanding Claim

  Input Parameters: 
      - Report for Motor / Non motor
      - Policy Type
      - OS Type : OS > 0, 
                  OS All (> 0, = 0, < 0 but CL Status = blank, O, P)
      - File Output for Motor = 2 Files (Detail, Summary)
                    for Non motor = 1 File
  Output Parameters:
      <none>

  Author: By N.Sayamol A49-0173

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEF VAR nv_chkline AS LOGICAL. 
DEF VAR n_txtbr    AS CHAR  FORMAT "X(20)".
DEF VAR nv_reccnt  AS INT.
DEF VAR nv_next    AS INT.
DEF VAR n_report   AS INT.
DEF VAR poltyp     AS CHAR FORMAT "X(2)".
DEF VAR n_poltyp   AS CHAR FORMAT "X(2)".
DEF VAR n_type     AS INT.

DEF VAR non_poltyp AS INT INIT 0.
                                             
DEF VAR n_asdat      AS DATE FORMAT "99/99/9999".
DEF VAR n_trndatto   AS DATE FORMAT "99/99/9999".

DEF VAR nv_datfr     AS DATE FORMAT "99/99/9999".
DEF VAR nv_datto     AS DATE FORMAT "99/99/9999".
DEF VAR n_prodat     AS CHAR FORMAT "X(6)".
DEF VAR nv_output    AS CHAR FORMAT "X(30)".

DEF VAR n_1st      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_stat     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_qs       AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_f1       AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_f2       AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_f3       AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_f4       AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_tfp      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_mps      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_btr      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_otr      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_ftr      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_ret      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_tot      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_netret   AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR n_total    AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".

DEF VAR nl_1st     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_stat    AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_qs      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_f1      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_f2      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_f3      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_f4      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_tfp     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_mps     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_btr     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_otr     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_ftr     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_ret     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_netret  AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nl_total   AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".

DEF VAR nt_1st     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_stat    AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_qs      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_f1      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_f2      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_f3      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_f4      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_tfp     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_mps     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_btr     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_otr     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_ftr     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_ret     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_tot     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_total   AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nt_netret  AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
 
DEF VAR nv_1st     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_stat    AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_qs      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_f1      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_f2      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_f3      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_f4      AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_tfp     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_mps     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_btr     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_otr     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_ftr     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_ret     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv_tot     AS DEC FORMAT "->>,>>>,>>>,>>>,>>9.99".

DEF WORKFILE WFUY
    FIELD poltyp AS CHAR FORMAT "X(2)"
    FIELD yr     AS CHAR FORMAT "X(2)"
    FIELD rico   AS CHAR FORMAT "X(7)"
    FIELD amt    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".

DEF WORKFILE WFVATUY
     FIELD vpoltyp AS CHAR FORMAT "X(2)"
     FIELD vyr     AS CHAR FORMAT "X(2)"
     FIELD vrico   AS CHAR FORMAT "X(7)"
     FIELD vat     AS CHAR FORMAT "X(1)"
     FIELD vamt    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".

DEF VAR ny_line AS CHAR FORMAT "X(2)".
DEF VAR ny_rico AS CHAR FORMAT "X(7)".
DEF VAR ny_yr   AS CHAR FORMAT "X(2)".
DEF VAR ny_vat  AS CHAR FORMAT "X(1)".

DEF VAR ny_1st    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR ny_thaire AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR ny_fo1    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR ny_fo2    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR ny_fo3    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR ny_fo4    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR ny_ftr    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".

DEF VAR nvy_poltyp  AS CHAR FORMAT "X(2)".
DEF VAR nvy_year    AS CHAR FORMAT "X(2)".

DEF VAR nv0y_1st    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv0y_thaire AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv0y_fo1    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv0y_fo2    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".

DEF VAR nv7y_1st    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv7y_thaire AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv7y_fo1    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEF VAR nv7y_fo2    AS DEC  FORMAT "->>,>>>,>>>,>>>,>>9.99".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_transaction

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES acproc_fil

/* Definitions for BROWSE br_transaction                                */
&Scoped-define FIELDS-IN-QUERY-br_transaction acproc_fil.asdat ~
acproc_fil.type acproc_fil.typdesc acproc_fil.trndatfr acproc_fil.trndatto ~
acproc_fil.entdat acproc_fil.enttim acproc_fil.usrid 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_transaction 
&Scoped-define QUERY-STRING-br_transaction FOR EACH acproc_fil ~
      WHERE acproc_fil.type = "11" NO-LOCK ~
    BY acproc_fil.asdat DESCENDING ~
       BY acproc_fil.enttim DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_transaction OPEN QUERY br_transaction FOR EACH acproc_fil ~
      WHERE acproc_fil.type = "11" NO-LOCK ~
    BY acproc_fil.asdat DESCENDING ~
       BY acproc_fil.enttim DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_transaction acproc_fil
&Scoped-define FIRST-TABLE-IN-QUERY-br_transaction acproc_fil


/* Definitions for FRAME frReport                                       */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frReport ~
    ~{&OPEN-QUERY-br_transaction}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-21 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-21
     FILENAME "wimage/logoadd5.bmp":U CONVERT-3D-COLORS
     SIZE 133.5 BY 24.

DEFINE BUTTON buAll 
     LABEL "All" 
     SIZE 6 BY .95
     FONT 6.

DEFINE BUTTON buCancel 
     LABEL "Cancel" 
     SIZE 18.5 BY 2.1
     FONT 6.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 18.5 BY 2.1
     FONT 6.

DEFINE BUTTON bu_find 
     LABEL "Find" 
     SIZE 6.5 BY .95
     FONT 6.

DEFINE VARIABLE fiAsdat AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 12.33 BY .71
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fiinputdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .71
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 12.83 BY .71
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fiTrnDatFR AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 12.33 BY .71
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fiTrnDatTO AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 12.83 BY .71
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 28.33 BY .95
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Policy", 1,
"Endorsment", 2,
"All", 3
     SIZE 48 BY .95
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RecBrowse
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 121.5 BY 14.29
     BGCOLOR 8 .

DEFINE RECTANGLE RecOK
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 49 BY 3.1
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-108
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 109 BY 4.29.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_transaction FOR 
      acproc_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_transaction
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_transaction C-Win _STRUCTURED
  QUERY br_transaction NO-LOCK DISPLAY
      acproc_fil.asdat FORMAT "99/99/9999":U WIDTH 11.33
      acproc_fil.type COLUMN-LABEL "Type" FORMAT "X(2)":U WIDTH 5
      acproc_fil.typdesc COLUMN-LABEL "Process Desc." FORMAT "X(35)":U
            WIDTH 23.33
      acproc_fil.trndatfr COLUMN-LABEL "Trans.Date From" FORMAT "99/99/9999":U
            WIDTH 15.83
      acproc_fil.trndatto COLUMN-LABEL "Trans.Date To" FORMAT "99/99/9999":U
            WIDTH 13.67
      acproc_fil.entdat FORMAT "99/99/9999":U WIDTH 11.83
      acproc_fil.enttim FORMAT "X(8)":U WIDTH 10.83
      acproc_fil.usrid FORMAT "X(6)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 109.5 BY 6.19
         BGCOLOR 15 FGCOLOR 1  ROW-HEIGHT-CHARS .71 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-21 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.5 BY 24.

DEFINE FRAME frReport
     fiinputdat AT ROW 3.71 COL 38.5 COLON-ALIGNED NO-LABEL
     bu_find AT ROW 3.57 COL 54.5
     buAll AT ROW 3.57 COL 112.5
     br_transaction AT ROW 4.62 COL 9
     ra_type AT ROW 11.38 COL 26 NO-LABEL
     fiTrnDatFR AT ROW 15.43 COL 34.67 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 18.95 COL 39.33 COLON-ALIGNED NO-LABEL
     buOK AT ROW 18.29 COL 78.17
     buCancel AT ROW 18.29 COL 103
     fiAsdat AT ROW 13.14 COL 34.67 COLON-ALIGNED NO-LABEL
     fiProcessDate AT ROW 13.14 COL 86.17 COLON-ALIGNED NO-LABEL
     fiTrnDatTO AT ROW 15.43 COL 86.17 COLON-ALIGNED NO-LABEL
     " Process Date" VIEW-AS TEXT
          SIZE 14 BY .71 AT ROW 13.14 COL 73
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Transaction Date From:" VIEW-AS TEXT
          SIZE 23 BY .71 AT ROW 15.43 COL 12.67
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Transaction Date To:" VIEW-AS TEXT
          SIZE 21 BY .71 AT ROW 15.43 COL 66.17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " PRINT FOR  PREW- FILE" VIEW-AS TEXT
          SIZE 125.17 BY .95 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "Output to :" VIEW-AS TEXT
          SIZE 12 BY .71 AT ROW 19.05 COL 28.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "ข้อมูลที่ต้องการ :" VIEW-AS TEXT
          SIZE 16.67 BY .62 AT ROW 11.48 COL 9.83
          BGCOLOR 8 FGCOLOR 15 FONT 6
     "( วันที่ทำการประมวลผล )" VIEW-AS TEXT
          SIZE 19 BY 1.19 AT ROW 13.86 COL 17.17
          BGCOLOR 8 
     "( วันที่ทำการประมวลผล )" VIEW-AS TEXT
          SIZE 19 BY 1.19 AT ROW 13.86 COL 68.17
          BGCOLOR 8 
     "กรุณาเลือก As of Date ที่ต้องการ :" VIEW-AS TEXT
          SIZE 31.5 BY .62 AT ROW 3.81 COL 9.5
          BGCOLOR 8 FGCOLOR 15 FONT 6
     " As of Date" VIEW-AS TEXT
          SIZE 11.5 BY .71 AT ROW 13.14 COL 24.17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RecBrowse AT ROW 2.91 COL 2.83
     RecOK AT ROW 17.76 COL 75.33
     RECT-108 AT ROW 12.43 COL 9.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 5 ROW 2.91
         SIZE 125.5 BY 20.48
         BGCOLOR 3 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert window title>"
         HEIGHT             = 24.05
         WIDTH              = 133.33
         MAX-HEIGHT         = 35.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 35.33
         VIRTUAL-WIDTH      = 170.67
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frReport:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME frReport
   Custom                                                               */
/* BROWSE-TAB br_transaction buAll frReport */
ASSIGN 
       br_transaction:SEPARATOR-FGCOLOR IN FRAME frReport      = 0.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_transaction
/* Query rebuild information for BROWSE br_transaction
     _TblList          = "sicfn.acproc_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "sicfn.acproc_fil.asdat|no,sicfn.acproc_fil.enttim|no"
     _Where[1]         = "sicfn.acproc_fil.type = ""11"""
     _FldNameList[1]   > sicfn.acproc_fil.asdat
"acproc_fil.asdat" ? ? "date" ? ? ? ? ? ? no ? no no "11.33" yes no no "U" "" ""
     _FldNameList[2]   > sicfn.acproc_fil.type
"acproc_fil.type" "Type" ? "character" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" ""
     _FldNameList[3]   > sicfn.acproc_fil.typdesc
"acproc_fil.typdesc" "Process Desc." ? "character" ? ? ? ? ? ? no ? no no "23.33" yes no no "U" "" ""
     _FldNameList[4]   > sicfn.acproc_fil.trndatfr
"acproc_fil.trndatfr" "Trans.Date From" ? "date" ? ? ? ? ? ? no ? no no "15.83" yes no no "U" "" ""
     _FldNameList[5]   > sicfn.acproc_fil.trndatto
"acproc_fil.trndatto" "Trans.Date To" ? "date" ? ? ? ? ? ? no ? no no "13.67" yes no no "U" "" ""
     _FldNameList[6]   > sicfn.acproc_fil.entdat
"acproc_fil.entdat" ? ? "date" ? ? ? ? ? ? no ? no no "11.83" yes no no "U" "" ""
     _FldNameList[7]   > sicfn.acproc_fil.enttim
"acproc_fil.enttim" ? ? "character" ? ? ? ? ? ? no ? no no "10.83" yes no no "U" "" ""
     _FldNameList[8]   = sicfn.acproc_fil.usrid
     _Query            is OPENED
*/  /* BROWSE br_transaction */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_transaction
&Scoped-define FRAME-NAME frReport
&Scoped-define SELF-NAME br_transaction
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_transaction C-Win
ON VALUE-CHANGED OF br_transaction IN FRAME frReport
DO:
  
  DO WITH FRAME frReport:
    IF NOT CAN-FIND(FIRST acproc_fil WHERE acproc_fil.type = "11" OR acproc_fil.type = "12") THEN DO:
        ASSIGN
            fiasdat = ?
            fiProcessdate = ?
            fiinputdat = ?
            n_trndatto = ?
            n_asdat = fiasdat.
        DISP fiinputdat fiasdat fiProcessdate.
    END.
    ELSE DO:
        FIND CURRENT acproc_fil NO-LOCK.
        ASSIGN
            fiasdat = acproc_fil.asdat
            fiProcessdate = acproc_fil.entdat
            fiinputdat = acproc_fil.entdat
            fiTrnDatFR = acproc_fil.trndatfr
            fiTrnDatTO = acproc_fil.trndatto
            n_trndatto = acproc_fil.trndatto
            n_asdat = fiasdat
            nv_datfr = acproc_fil.trndatfr
            nv_datto = acproc_fil.trndatto.
        DISP fiinputdat fiasdat fiProcessdate fiTrnDatFR fiTrnDatTO.
    END.
  END. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAll
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAll C-Win
ON CHOOSE OF buAll IN FRAME frReport /* All */
DO:

  OPEN  QUERY  br_transaction FOR EACH acproc_fil WHERE 
                     acproc_fil.TYPE   =  "11"   NO-LOCK
     BY acproc_fil.asdat DESCENDING
     BY acproc_fil.enttim DESCENDING.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCancel C-Win
ON CHOOSE OF buCancel IN FRAME frReport /* Cancel */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK C-Win
ON CHOOSE OF buOK IN FRAME frReport /* OK */
DO:
  IF nv_output = "" THEN DO:
     MESSAGE "Please enter Output to:...." 
     VIEW-AS ALERT-BOX ERROR.
     APPLY "ENTRY" TO fi_output.
     RETURN NO-APPLY.
  END.

  ASSIGN n_asdat = fiasdat
         n_prodat = STRING(YEAR(nv_datto)) + STRING(MONTH(nv_datto),"99")
         nv_output = nv_output + ".slk".

  
  IF ra_type = 1 THEN RUN pd_PrnPrewPol.   /*Policy*/
  ELSE IF ra_type = 2 THEN RUN pd_PrnPrewEnd.   /*Endorse*/
  ELSE RUN pd_PrnPrew.   /*All*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_find
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_find C-Win
ON CHOOSE OF bu_find IN FRAME frReport /* Find */
DO:
  IF INPUT  fiinputdat <> ? THEN  DO:  /*--- Search By Model Group ---*/
     ASSIGN fiinputdat = INPUT fiinputdat
            n_asdat  = INPUT fiinputdat.
     DISP fiinputdat WITH FRAME frreport.

     FIND  FIRST  acproc_fil USE-INDEX by_type_asdat  WHERE
                  acProc_fil.type  = "11"    AND 
                  acProc_fil.asdat = n_asdat NO-ERROR.
     IF AVAIL acproc_fil THEN DO:
        OPEN  QUERY  br_transaction FOR EACH acproc_fil WHERE 
                     acproc_fil.TYPE   =  "11"    AND 
                     acproc_fil.entdat =  n_asdat.
       
        ASSIGN
            fiasdat = acproc_fil.asdat
            fiProcessdate = acproc_fil.entdat
            fiinputdat = acproc_fil.entdat
            fiTrnDatFR = acproc_fil.trndatfr
            fiTrnDatTO = acproc_fil.trndatto
            n_trndatto = acproc_fil.trndatto
            n_asdat = fiasdat
            nv_datfr = acproc_fil.trndatfr
            nv_datto = acproc_fil.trndatto.
        DISP fiinputdat fiasdat fiProcessdate fiTrnDatFR fiTrnDatTO WITH FRAME frreport.
        APPLY "ENTRY" TO fi_output.
        RETURN NO-APPLY.
     END.
     ELSE DO:
        MESSAGE "ไม่พบข้อมูลที่ต้องการ" VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fiinputdat.
        RETURN NO-APPLY.
     END.
  
 
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiinputdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiinputdat C-Win
ON RETURN OF fiinputdat IN FRAME frReport
DO:
  DO WITH FRAME frReport:
  
      IF INPUT  fiinputdat <> ? THEN  DO:  /*--- Search By Model Group ---*/
         ASSIGN fiinputdat = INPUT fiinputdat
                n_asdat  = INPUT fiinputdat.
         DISP fiinputdat WITH FRAME frreport.
    
         FIND  FIRST  acproc_fil USE-INDEX by_type_asdat  WHERE
                      acProc_fil.type  = "11"    AND 
                      acProc_fil.asdat = n_asdat NO-ERROR.
         IF AVAIL acproc_fil THEN DO:
            OPEN  QUERY  br_transaction FOR EACH acproc_fil WHERE 
                         acproc_fil.TYPE   =  "11"    AND 
                         acproc_fil.entdat =  n_asdat.
            ASSIGN
                fiasdat = acproc_fil.asdat
                fiProcessdate = acproc_fil.entdat
                fiinputdat = acproc_fil.entdat
                fiTrnDatFR = acproc_fil.trndatfr
                fiTrnDatTO = acproc_fil.trndatto
                n_trndatto = acproc_fil.trndatto
                n_asdat = fiasdat
                nv_datfr = acproc_fil.trndatfr
                nv_datto = acproc_fil.trndatto.
            DISP fiinputdat fiasdat fiProcessdate fiTrnDatFR fiTrnDatTO WITH FRAME frreport.

            APPLY "ENTRY" TO fi_output.
            RETURN NO-APPLY.
            
         END.
         ELSE DO:
            MESSAGE "ไม่พบข้อมูลที่ต้องการ" VIEW-AS ALERT-BOX ERROR.
            APPLY "ENTRY" TO fiinputdat.
            RETURN NO-APPLY.
         END.
      
      
      END.
      
  END. /*Do with frame*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME frReport
DO:
  ASSIGN nv_output = INPUT fi_output.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type C-Win
ON VALUE-CHANGED OF ra_type IN FRAME frReport
DO:
  DO WITH FRAME frReport:
        ASSIGN
            ra_type = INPUT ra_type.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.

  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN   ra_type = 3
           fiasdat = acproc_fil.asdat
           fiProcessdate = acproc_fil.entdat
           fiinputdat = acproc_fil.entdat
           fiTrnDatFR = acproc_fil.trndatfr
           fiTrnDatTO = acproc_fil.trndatto
           n_trndatto = acproc_fil.trndatto
           n_asdat = fiasdat
           nv_datfr = acproc_fil.trndatfr
           nv_datto = acproc_fil.trndatto.

  DISP ra_type fiinputdat fiasdat fiProcessdate fiTrnDatFR fiTrnDatTO WITH FRAME frReport.
  
  APPLY "ENTRY" TO fiinputdat.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
     WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  ENABLE IMAGE-21 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fiinputdat ra_type fiTrnDatFR fi_output fiAsdat fiProcessDate 
          fiTrnDatTO 
      WITH FRAME frReport IN WINDOW C-Win.
  ENABLE fiinputdat bu_find buAll br_transaction ra_type fiTrnDatFR fi_output 
         buOK buCancel fiAsdat fiProcessDate fiTrnDatTO RecBrowse RecOK 
         RECT-108 
      WITH FRAME frReport IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frReport}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_prnHeader C-Win 
PROCEDURE pd_prnHeader :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) NO-ECHO.
EXPORT DELIMITER ";" 
     "" "" "" "" "PREW-FILE".
EXPORT DELIMITER ";"
     "AS OF DATE : " TODAY
     "" "" "" "" 
     "PROG. : " "WACPREW.P".
EXPORT DELIMITER ";"
     "TRANS.DATE FROM: " nv_datfr
     "TO: " nv_datto.
EXPORT DELIMITER ";"
     "LINE"
     "1ST SURPLUS"
     "THAI RE"
     "QS"
     "FO1"
     "FO2"
     "FO3"
     "FO4"
     "TFP"
     "MPS"
     "BTR"
     "OTR"
     "FTR"
     "RET"
     "TOTAL"
     "TOTAL_PREM".
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_prnprew C-Win 
PROCEDURE pd_prnprew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

       RUN pd_PrnHeader.

       FOR EACH ucrein NO-LOCK USE-INDEX ucrein01 WHERE SUBSTR(UCREIN.POINT,1,6) = n_prodat
           BREAK BY SUBSTR(STRING(ucrein.endcnt),1,2).
          
         DISPLAY ucrein.point ucrein.endcnt ucrein.cedpol 
         WITH COLOR blue/withe NO-LABEL 
         TITLE "Printing PREW File" WIDTH 60 FRAME amain 
         VIEW-AS DIALOG-BOX.
         PAUSE 0.

         ASSIGN ny_line = SUBSTR(STRING(ucrein.endcnt),1,2)
                ny_yr   = ucrein.cedref.
         
         IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
            SUBSTR(ucrein.cedpol,6,2) = "01"  THEN DO:
            ASSIGN n_1st = n_1st + ucrein.cedsi
                   ny_rico = "1ST"
                   ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
            IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
               RUN pd_wfuy.
               RUN pd_wfvatuy.
            END. 
         END. /* 1ST */

         ELSE IF ucrein.cedpol = "STAT"  THEN DO:
                 ASSIGN n_stat = n_stat + ucrein.cedsi
                        ny_rico = "THAIRE"
                        ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                    RUN pd_wfvatuy.
                 END. 
         END. /* Thai Re (5%)*/

         ELSE IF SUBSTRING(ucrein.cedpol,1,3) = "0RQ" THEN DO:
                 ASSIGN n_qs = n_qs + ucrein.cedsi.
         END. /* QS */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F1"  THEN DO:
                 ASSIGN n_f1 = n_f1 + ucrein.cedsi
                        ny_rico = "FO1"
                        ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                     RUN pd_wfuy.
                     RUN pd_wfvatuy.
                 END.
         END. /* FO1 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F2"  THEN DO:
                 ASSIGN n_f2 = n_f2 + ucrein.cedsi 
                        ny_rico = "FO2"
                        ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                     RUN pd_wfuy.
                     RUN pd_wfvatuy.
                 END.
         END. /* FO2 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F3"  THEN DO:
                 ASSIGN n_f3 = n_f3 + ucrein.cedsi
                        ny_rico = "FO3".
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                 END.
         END. /* FO3 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F4"  THEN DO:
                 ASSIGN n_f4 = n_f4 + ucrein.cedsi
                        ny_rico = "FO4".
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                 END.
         END. /* FO4 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0Q"  THEN DO:
                 ASSIGN n_tfp = n_tfp + ucrein.cedsi.
         END. /* TFP */

         ELSE IF SUBSTR(ucrein.cedpol,1,3) = "0PS"  THEN DO:
                 ASSIGN n_mps = n_mps + ucrein.cedsi.
         END. /* MPS */

         ELSE IF SUBSTR(ucrein.cedpol,1,3) = "0TF" AND
                 SUBSTR(ucrein.cedpol,6,2) = "FB"  THEN DO:
                 ASSIGN n_btr = n_btr + ucrein.cedsi.
         END. /* BTR */

         ELSE IF SUBSTR(ucrein.cedpol,1,3) = "0TF" AND
                 SUBSTR(ucrein.cedpol,6,2) = "FO"  THEN DO:
                 ASSIGN n_otr = n_otr + ucrein.cedsi.
         END. /* OTR */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "FT"  THEN DO:
                 ASSIGN n_ftr = n_ftr + ucrein.cedsi
                        ny_rico = "FTR".
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                 END.
         END. /* FTR */
         
         ELSE IF ucrein.cedpol = "0RET"  THEN DO:
              ASSIGN n_ret = n_ret + ucrein.cedsi.
         END. /* 0RET */

         ELSE IF SUBSTR(ucrein.cedpol,1,9) = "TotalPrem"  THEN DO:
                 ASSIGN n_total = n_total + ucrein.cedsi.
         END. /* Total */
         
        
         IF LAST-OF (SUBSTR(STRING(ucrein.endcnt),1,2)) THEN DO:
            
            n_tot  =  n_1st * (-1)  + n_stat * (-1)  + n_qs * (-1)  + 
                      n_f1  * (-1)  + n_f2   * (-1)  + n_f3 * (-1)  + 
                      n_f4  * (-1)  + n_tfp  * (-1)  + n_mps * (-1) + 
                      n_btr * (-1)  + n_otr  * (-1)  + n_ftr * (-1) + 
                      n_ret.
            
            OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
                SUBSTR(STRING(ucrein.endcnt),1,2)
                n_1st    *  (-1) 
                n_stat   *  (-1) 
                n_qs     *  (-1) 
                n_f1     *  (-1) 
                n_f2     *  (-1) 
                n_f3     *  (-1) 
                n_f4     *  (-1) 
                n_tfp    *  (-1) 
                n_mps    *  (-1) 
                n_btr    *  (-1) 
                n_otr    *  (-1) 
                n_ftr    *  (-1) 
                n_ret    
                n_tot
                n_total.
            OUTPUT CLOSE.
            
         
             /* GrandTotal */
             ASSIGN nt_1st   = nt_1st   +  n_1st
                    nt_stat  = nt_stat  +  n_stat 
                    nt_qs    = nt_qs    +  n_qs   
                    nt_f1    = nt_f1    +  n_f1   
                    nt_f2    = nt_f2    +  n_f2   
                    nt_f3    = nt_f3    +  n_f3   
                    nt_f4    = nt_f4    +  n_f4   
                    nt_tfp   = nt_tfp   +  n_tfp  
                    nt_mps   = nt_mps   +  n_mps  
                    nt_btr   = nt_btr   +  n_btr  
                    nt_otr   = nt_otr   +  n_otr  
                    nt_ftr   = nt_ftr   +  n_ftr  
                    nt_ret   = nt_ret   +  n_ret
                    nt_tot   = nt_tot   +  n_tot
                    nt_total = nt_total +  n_total.
            
             ASSIGN n_1st  = 0    n_stat = 0     n_qs  = 0
                    n_f1   = 0    n_f2   = 0     n_f3  = 0
                    n_f4   = 0    n_tfp  = 0     n_mps = 0
                    n_btr  = 0    n_otr  = 0     n_ftr = 0
                    n_ret  = 0    n_tot  = 0     n_total = 0.  

         END. /*Last-of ucrein.endcnt*/

       END.  /*Each ucrein*/

       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";"
           "GRANDTOTAL"
           nt_1st      *  (-1)  
           nt_stat     *  (-1)  
           nt_qs       *  (-1)  
           nt_f1       *  (-1)  
           nt_f2       *  (-1)  
           nt_f3       *  (-1)  
           nt_f4       *  (-1)  
           nt_tfp      *  (-1)  
           nt_mps      *  (-1)  
           nt_btr      *  (-1)  
           nt_otr      *  (-1)  
           nt_ftr      *  (-1)  
           nt_ret 
           nt_tot
           nt_total.   
       OUTPUT CLOSE.

       RUN pd_prnuy.
       RUN pd_prnvatuy.
     
       MESSAGE "Printing...Complete" VIEW-AS ALERT-BOX.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_prnprewend C-Win 
PROCEDURE pd_prnprewend :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

       RUN pd_PrnHeader.

       FOR EACH ucrein NO-LOCK USE-INDEX ucrein01 WHERE SUBSTR(UCREIN.POINT,1,6) = n_prodat 
                                                    AND UCREIN.CEDCES = "END"
           BREAK BY SUBSTR(STRING(ucrein.endcnt),1,2).
          
         DISPLAY ucrein.point ucrein.endcnt ucrein.cedpol 
         WITH COLOR blue/withe NO-LABEL 
         TITLE "Printing PREW File" WIDTH 60 FRAME amain 
         VIEW-AS DIALOG-BOX.
         PAUSE 0.

         ASSIGN ny_line = SUBSTR(STRING(ucrein.endcnt),1,2)
                ny_yr   = ucrein.cedref.
         
         IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
            SUBSTR(ucrein.cedpol,6,2) = "01"  THEN DO:
            ASSIGN n_1st = n_1st + ucrein.cedsi
                   ny_rico = "1ST"
                   ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
            IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
               RUN pd_wfuy.
               RUN pd_wfvatuy.
            END. 
         END. /* 1ST */

         ELSE IF ucrein.cedpol = "STAT"  THEN DO:
                 ASSIGN n_stat = n_stat + ucrein.cedsi
                        ny_rico = "THAIRE"
                        ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                    RUN pd_wfvatuy.
                 END. 
         END. /* Thai Re (5%)*/

         ELSE IF SUBSTRING(ucrein.cedpol,1,3) = "0RQ" THEN DO:
                 ASSIGN n_qs = n_qs + ucrein.cedsi.
         END. /* QS */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F1"  THEN DO:
                 ASSIGN n_f1 = n_f1 + ucrein.cedsi
                        ny_rico = "FO1"
                        ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                     RUN pd_wfuy.
                     RUN pd_wfvatuy.
                 END.
         END. /* FO1 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F2"  THEN DO:
                 ASSIGN n_f2 = n_f2 + ucrein.cedsi 
                        ny_rico = "FO2"
                        ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                     RUN pd_wfuy.
                     RUN pd_wfvatuy.
                 END.
         END. /* FO2 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F3"  THEN DO:
                 ASSIGN n_f3 = n_f3 + ucrein.cedsi
                        ny_rico = "FO3".
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                 END.
         END. /* FO3 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F4"  THEN DO:
                 ASSIGN n_f4 = n_f4 + ucrein.cedsi
                        ny_rico = "FO4".
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                 END.
         END. /* FO4 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0Q"  THEN DO:
                 ASSIGN n_tfp = n_tfp + ucrein.cedsi.
         END. /* TFP */

         ELSE IF SUBSTR(ucrein.cedpol,1,3) = "0PS"  THEN DO:
                 ASSIGN n_mps = n_mps + ucrein.cedsi.
         END. /* MPS */

         ELSE IF SUBSTR(ucrein.cedpol,1,3) = "0TF" AND
                 SUBSTR(ucrein.cedpol,6,2) = "FB"  THEN DO:
                 ASSIGN n_btr = n_btr + ucrein.cedsi.
         END. /* BTR */

         ELSE IF SUBSTR(ucrein.cedpol,1,3) = "0TF" AND
                 SUBSTR(ucrein.cedpol,6,2) = "FO"  THEN DO:
                 ASSIGN n_otr = n_otr + ucrein.cedsi.
         END. /* OTR */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "FT"  THEN DO:
                 ASSIGN n_ftr = n_ftr + ucrein.cedsi
                        ny_rico = "FTR".
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                 END.
         END. /* FTR */
         
         ELSE IF ucrein.cedpol = "0RET"  THEN DO:
              ASSIGN n_ret = n_ret + ucrein.cedsi.
         END. /* 0RET */

         ELSE IF SUBSTR(ucrein.cedpol,1,9) = "TotalPrem"  THEN DO:
                 ASSIGN n_total = n_total + ucrein.cedsi.
         END. /* Total */
         
        
         IF LAST-OF (SUBSTR(STRING(ucrein.endcnt),1,2)) THEN DO:
            
            n_tot  =  n_1st * (-1)  + n_stat * (-1)  + n_qs * (-1)  + 
                      n_f1  * (-1)  + n_f2   * (-1)  + n_f3 * (-1)  + 
                      n_f4  * (-1)  + n_tfp  * (-1)  + n_mps * (-1) + 
                      n_btr * (-1)  + n_otr  * (-1)  + n_ftr * (-1) + 
                      n_ret.
            
            OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
                SUBSTR(STRING(ucrein.endcnt),1,2)
                n_1st    *  (-1) 
                n_stat   *  (-1) 
                n_qs     *  (-1) 
                n_f1     *  (-1) 
                n_f2     *  (-1) 
                n_f3     *  (-1) 
                n_f4     *  (-1) 
                n_tfp    *  (-1) 
                n_mps    *  (-1) 
                n_btr    *  (-1) 
                n_otr    *  (-1) 
                n_ftr    *  (-1) 
                n_ret    
                n_tot
                n_total.
            OUTPUT CLOSE.
            
         
             /* GrandTotal */
             ASSIGN nt_1st   = nt_1st   +  n_1st
                    nt_stat  = nt_stat  +  n_stat 
                    nt_qs    = nt_qs    +  n_qs   
                    nt_f1    = nt_f1    +  n_f1   
                    nt_f2    = nt_f2    +  n_f2   
                    nt_f3    = nt_f3    +  n_f3   
                    nt_f4    = nt_f4    +  n_f4   
                    nt_tfp   = nt_tfp   +  n_tfp  
                    nt_mps   = nt_mps   +  n_mps  
                    nt_btr   = nt_btr   +  n_btr  
                    nt_otr   = nt_otr   +  n_otr  
                    nt_ftr   = nt_ftr   +  n_ftr  
                    nt_ret   = nt_ret   +  n_ret
                    nt_tot   = nt_tot   +  n_tot
                    nt_total = nt_total +  n_total.
            
             ASSIGN n_1st  = 0    n_stat = 0     n_qs  = 0
                    n_f1   = 0    n_f2   = 0     n_f3  = 0
                    n_f4   = 0    n_tfp  = 0     n_mps = 0
                    n_btr  = 0    n_otr  = 0     n_ftr = 0
                    n_ret  = 0    n_tot  = 0     n_total = 0.  

         END. /*Last-of ucrein.endcnt*/

       END.  /*Each ucrein*/

       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";"
           "GRANDTOTAL"
           nt_1st      *  (-1)  
           nt_stat     *  (-1)  
           nt_qs       *  (-1)  
           nt_f1       *  (-1)  
           nt_f2       *  (-1)  
           nt_f3       *  (-1)  
           nt_f4       *  (-1)  
           nt_tfp      *  (-1)  
           nt_mps      *  (-1)  
           nt_btr      *  (-1)  
           nt_otr      *  (-1)  
           nt_ftr      *  (-1)  
           nt_ret 
           nt_tot
           nt_total.   
       OUTPUT CLOSE.

       RUN pd_prnuy.
       RUN pd_prnvatuy.
     
       MESSAGE "Printing...Complete" VIEW-AS ALERT-BOX.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_prnprewpol C-Win 
PROCEDURE pd_prnprewpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


       RUN pd_PrnHeader.

       FOR EACH ucrein NO-LOCK USE-INDEX ucrein01 WHERE SUBSTR(UCREIN.POINT,1,6) = n_prodat 
                                                    AND UCREIN.CEDCES = "POL"
           BREAK BY SUBSTR(STRING(ucrein.endcnt),1,2).
          
         DISPLAY ucrein.point ucrein.endcnt ucrein.cedpol 
         WITH COLOR blue/withe NO-LABEL 
         TITLE "Printing PREW File" WIDTH 60 FRAME amain 
         VIEW-AS DIALOG-BOX.
         PAUSE 0.

         ASSIGN ny_line = SUBSTR(STRING(ucrein.endcnt),1,2)
                ny_yr   = ucrein.cedref.
         
         IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
            SUBSTR(ucrein.cedpol,6,2) = "01"  THEN DO:
            ASSIGN n_1st = n_1st + ucrein.cedsi
                   ny_rico = "1ST"
                   ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
            IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
               RUN pd_wfuy.
               RUN pd_wfvatuy.
            END. 
         END. /* 1ST */

         ELSE IF ucrein.cedpol = "STAT"  THEN DO:
                 ASSIGN n_stat = n_stat + ucrein.cedsi
                        ny_rico = "THAIRE"
                        ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                    RUN pd_wfvatuy.
                 END. 
         END. /* Thai Re (5%)*/

         ELSE IF SUBSTRING(ucrein.cedpol,1,3) = "0RQ" THEN DO:
                 ASSIGN n_qs = n_qs + ucrein.cedsi.
         END. /* QS */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F1"  THEN DO:
                 ASSIGN n_f1 = n_f1 + ucrein.cedsi
                        ny_rico = "FO1"
                        ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                     RUN pd_wfuy.
                     RUN pd_wfvatuy.
                 END.
         END. /* FO1 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F2"  THEN DO:
                 ASSIGN n_f2 = n_f2 + ucrein.cedsi 
                        ny_rico = "FO2"
                        ny_vat  = SUBSTR(STRING(ucrein.endcnt),3,1).
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                     RUN pd_wfuy.
                     RUN pd_wfvatuy.
                 END.
         END. /* FO2 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F3"  THEN DO:
                 ASSIGN n_f3 = n_f3 + ucrein.cedsi
                        ny_rico = "FO3".
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                 END.
         END. /* FO3 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "F4"  THEN DO:
                 ASSIGN n_f4 = n_f4 + ucrein.cedsi
                        ny_rico = "FO4".
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                 END.
         END. /* FO4 */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0Q"  THEN DO:
                 ASSIGN n_tfp = n_tfp + ucrein.cedsi.
         END. /* TFP */

         ELSE IF SUBSTR(ucrein.cedpol,1,3) = "0PS"  THEN DO:
                 ASSIGN n_mps = n_mps + ucrein.cedsi.
         END. /* MPS */

         ELSE IF SUBSTR(ucrein.cedpol,1,3) = "0TF" AND
                 SUBSTR(ucrein.cedpol,6,2) = "FB"  THEN DO:
                 ASSIGN n_btr = n_btr + ucrein.cedsi.
         END. /* BTR */

         ELSE IF SUBSTR(ucrein.cedpol,1,3) = "0TF" AND
                 SUBSTR(ucrein.cedpol,6,2) = "FO"  THEN DO:
                 ASSIGN n_otr = n_otr + ucrein.cedsi.
         END. /* OTR */

         ELSE IF SUBSTR(ucrein.cedpol,1,2) = "0T"  AND
                 SUBSTR(ucrein.cedpol,6,2) = "FT"  THEN DO:
                 ASSIGN n_ftr = n_ftr + ucrein.cedsi
                        ny_rico = "FTR".
                 IF LOOKUP(ny_line,"13,20,32,35,36,39,80,81,82,83,84,85,31,90,92") <> 0 THEN DO:
                    RUN pd_wfuy.
                 END.
         END. /* FTR */
         
         ELSE IF ucrein.cedpol = "0RET"  THEN DO:
              ASSIGN n_ret = n_ret + ucrein.cedsi.
         END. /* 0RET */

         ELSE IF SUBSTR(ucrein.cedpol,1,9) = "TotalPrem"  THEN DO:
                 ASSIGN n_total = n_total + ucrein.cedsi.
         END. /* Total */
         
        
         IF LAST-OF (SUBSTR(STRING(ucrein.endcnt),1,2)) THEN DO:
            
            n_tot  =  n_1st * (-1)  + n_stat * (-1)  + n_qs * (-1)  + 
                      n_f1  * (-1)  + n_f2   * (-1)  + n_f3 * (-1)  + 
                      n_f4  * (-1)  + n_tfp  * (-1)  + n_mps * (-1) + 
                      n_btr * (-1)  + n_otr  * (-1)  + n_ftr * (-1) + 
                      n_ret.
            
            OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
                SUBSTR(STRING(ucrein.endcnt),1,2)
                n_1st    *  (-1) 
                n_stat   *  (-1) 
                n_qs     *  (-1) 
                n_f1     *  (-1) 
                n_f2     *  (-1) 
                n_f3     *  (-1) 
                n_f4     *  (-1) 
                n_tfp    *  (-1) 
                n_mps    *  (-1) 
                n_btr    *  (-1) 
                n_otr    *  (-1) 
                n_ftr    *  (-1) 
                n_ret    
                n_tot
                n_total.
            OUTPUT CLOSE.
            
         
             /* GrandTotal */
             ASSIGN nt_1st   = nt_1st   +  n_1st
                    nt_stat  = nt_stat  +  n_stat 
                    nt_qs    = nt_qs    +  n_qs   
                    nt_f1    = nt_f1    +  n_f1   
                    nt_f2    = nt_f2    +  n_f2   
                    nt_f3    = nt_f3    +  n_f3   
                    nt_f4    = nt_f4    +  n_f4   
                    nt_tfp   = nt_tfp   +  n_tfp  
                    nt_mps   = nt_mps   +  n_mps  
                    nt_btr   = nt_btr   +  n_btr  
                    nt_otr   = nt_otr   +  n_otr  
                    nt_ftr   = nt_ftr   +  n_ftr  
                    nt_ret   = nt_ret   +  n_ret
                    nt_tot   = nt_tot   +  n_tot
                    nt_total = nt_total +  n_total.
            
             ASSIGN n_1st  = 0    n_stat = 0     n_qs  = 0
                    n_f1   = 0    n_f2   = 0     n_f3  = 0
                    n_f4   = 0    n_tfp  = 0     n_mps = 0
                    n_btr  = 0    n_otr  = 0     n_ftr = 0
                    n_ret  = 0    n_tot  = 0     n_total = 0.  

         END. /*Last-of ucrein.endcnt*/

       END.  /*Each ucrein*/

       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";"
           "GRANDTOTAL"
           nt_1st      *  (-1)  
           nt_stat     *  (-1)  
           nt_qs       *  (-1)  
           nt_f1       *  (-1)  
           nt_f2       *  (-1)  
           nt_f3       *  (-1)  
           nt_f4       *  (-1)  
           nt_tfp      *  (-1)  
           nt_mps      *  (-1)  
           nt_btr      *  (-1)  
           nt_otr      *  (-1)  
           nt_ftr      *  (-1)  
           nt_ret 
           nt_tot
           nt_total.   
       OUTPUT CLOSE.

       RUN pd_prnuy.
       RUN pd_prnvatuy.
     
       MESSAGE "Printing...Complete" VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_prnUY C-Win 
PROCEDURE pd_prnUY :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
    EXPORT DELIMITER ";" "".
    EXPORT DELIMITER ";" "".
    EXPORT DELIMITER ";" 
        "" "" "" "UY-FILE".
    EXPORT DELIMITER ";"
        "Line" 
        "YEAR" 
        "1ST" 
        "THAI RE" 
        "FO1" 
        "FO2" 
        "FO3" 
        "FO4" 
        "FTR".
OUTPUT CLOSE.

FOR EACH wfuy NO-LOCK 
BREAK BY wfuy.poltyp
      BY wfuy.yr:

    IF wfuy.rico = "1ST" THEN ny_1st = wfuy.amt.
    ELSE IF wfuy.rico = "THAIRE" THEN ny_thaire = wfuy.amt.
    ELSE IF wfuy.rico = "FO1" THEN ny_fo1 = wfuy.amt.
    ELSE IF wfuy.rico = "FO2" THEN ny_fo2 = wfuy.amt.
    ELSE IF wfuy.rico = "FO3" THEN ny_fo3 = wfuy.amt.
    ELSE IF wfuy.rico = "FO4" THEN ny_fo4 = wfuy.amt.
    ELSE IF wfuy.rico = "FTR" THEN ny_ftr = wfuy.amt.
    
    IF LAST-OF (wfuy.yr) THEN DO:
       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";"
           wfuy.poltyp 
           wfuy.yr 
           ny_1st     *  (-1)
           ny_thaire  *  (-1)
           ny_fo1     *  (-1)
           ny_fo2     *  (-1)
           ny_fo3     *  (-1)
           ny_fo4     *  (-1)
           ny_ftr     *  (-1).
       OUTPUT CLOSE.
       
       ASSIGN ny_1st = 0     ny_thaire = 0
              ny_fo1 = 0     ny_fo2    = 0
              ny_fo3 = 0     ny_fo4    = 0
              ny_ftr = 0.

    END. /*LAST-OF (wfuy.poltyp)*/

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_prnVatUY C-Win 
PROCEDURE pd_prnVatUY :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
    EXPORT DELIMITER ";" "".
    EXPORT DELIMITER ";" "".
    EXPORT DELIMITER ";" 
        "" "" "" "VATUY-FILE FOR LINE 90, 92".
    EXPORT DELIMITER ";"
        "Line" 
        "YEAR" 
        "1ST-0%"
        "1ST-7%"
        "THAI RE-0%" 
        "THAI RE-7%"
        "FO1-0%" 
        "FO1-7%"
        "FO2-0%"
        "FO2-7%".
    
OUTPUT CLOSE.

FOR EACH wfvatuy NO-LOCK 
BREAK BY wfvatuy.vpoltyp
      BY wfvatuy.vyr:

    IF wfvatuy.vpoltyp = "90" THEN DO:
       ASSIGN nvy_poltyp = "90"
              nvy_year = wfvatuy.vyr.

       IF wfvatuy.vrico = "1ST" THEN DO: 
          IF wfvatuy.vat = "0" THEN nv0y_1st = wfvatuy.vamt.          
          ELSE nv7y_1st = wfvatuy.vamt.
       END.
       ELSE IF wfvatuy.vrico = "THAIRE" THEN DO:
            IF wfvatuy.vat = "0" THEN nv0y_thaire = wfvatuy.vamt.
            ELSE nv7y_thaire = wfvatuy.vamt.
       END.
       ELSE IF wfvatuy.vrico = "FO1" THEN DO:
            IF wfvatuy.vat = "0" THEN nv0y_fo1 = wfvatuy.vamt.
            ELSE nv7y_fo1 = wfvatuy.vamt.
       END.
       ELSE IF wfvatuy.vrico = "FO2" THEN DO:
            IF wfvatuy.vat = "0" THEN nv0y_fo2 = wfvatuy.vamt.
            ELSE nv7y_fo2 = wfvatuy.vamt.
       END.
        
    END. /*"90"*/
    ELSE DO: /*92*/
       ASSIGN nvy_poltyp = "92"
              nvy_year = wfvatuy.vyr.

       IF wfvatuy.vrico = "1ST" THEN DO: 
          IF wfvatuy.vat = "0" THEN nv0y_1st = wfvatuy.vamt.          
          ELSE nv7y_1st = wfvatuy.vamt.
       END.
       ELSE IF wfvatuy.vrico = "THAIRE" THEN DO:
            IF wfvatuy.vat = "0" THEN nv0y_thaire = wfvatuy.vamt.
            ELSE nv7y_thaire = wfvatuy.vamt.
       END.
       ELSE IF wfvatuy.vrico = "FO1" THEN DO:
            IF wfvatuy.vat = "0" THEN nv0y_fo1 = wfvatuy.vamt.
            ELSE nv7y_fo1 = wfvatuy.vamt.
       END.
       ELSE IF wfvatuy.vrico = "FO2" THEN DO:
            IF wfvatuy.vat = "0" THEN nv0y_fo2 = wfvatuy.vamt.
            ELSE nv7y_fo2 = wfvatuy.vamt.
       END.

    END. /*92*/

    IF LAST-OF (wfvatuy.vyr) THEN DO:
       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";"
           nvy_poltyp
           nvy_year
           nv0y_1st      *  (-1)
           nv7y_1st      *  (-1)
           nv0y_thaire   *  (-1)
           nv7y_thaire   *  (-1)
           nv0y_fo1      *  (-1)
           nv7y_fo1      *  (-1)
           nv0y_fo2      *  (-1)
           nv7y_fo2      *  (-1).
       OUTPUT CLOSE.
    
       ASSIGN nvy_poltyp  = ""     nvy_year    = ""
              nv0y_1st    = 0      nv7y_1st    = 0
              nv0y_thaire = 0      nv7y_thaire = 0
              nv0y_fo1    = 0      nv7y_fo1    = 0
              nv0y_fo2    = 0      nv7y_fo2    = 0.

    END. /*IF LAST-OF (wfvatuy.vpoltyp)*/

END. /*Each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_wfUY C-Win 
PROCEDURE pd_wfUY :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wfuy WHERE wfuy.poltyp = ny_line AND
                      wfuy.yr     = ny_yr   AND
                      wfuy.rico   = ny_rico NO-ERROR.
IF NOT AVAIL wfuy THEN DO:
   CREATE wfuy.
   ASSIGN wfuy.poltyp = ny_line
          wfuy.yr     = ny_yr
          wfuy.rico   = ny_rico .
END.

ASSIGN wfuy.amt = wfuy.amt + ucrein.cedsi.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_wfVatUY C-Win 
PROCEDURE pd_wfVatUY :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF ny_line = "90" OR ny_line = "92" THEN DO:
   FIND FIRST wfvatuy WHERE wfvatuy.vpoltyp = ny_line AND
                            wfvatuy.vyr     = ny_yr   AND
                            wfvatuy.vrico   = ny_rico AND
                            wfvatuy.vat     = ny_vat  NO-ERROR.
   IF NOT AVAIL wfvatuy THEN DO:
      CREATE wfvatuy.
      ASSIGN wfvatuy.vpoltyp = ny_line
             wfvatuy.vyr     = ny_yr
             wfvatuy.vrico   = ny_rico
             wfvatuy.vat     = ny_vat.
   END.                               

   wfvatuy.vamt = wfvatuy.vamt + ucrein.cedsi.

END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

