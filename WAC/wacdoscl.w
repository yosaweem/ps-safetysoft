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

/* Modify By   : Chutikarn.S 04/03/2008   [A50-0178]                    
               - ปรับ format branch เพื่อรองรับการขยายสาขา              */  

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEF VAR nv_chkline AS LOGICAL. 
DEF VAR n_txtbr   AS CHAR  FORMAT "X(20)".
DEF VAR nv_reccnt AS INT.
DEF VAR nv_next   AS INT.
DEF VAR n_report  AS INT.
DEF VAR poltyp    AS CHAR FORMAT "X(2)".
DEF VAR n_poltyp  AS CHAR FORMAT "X(2)".

DEF VAR non_poltyp AS INT INIT 0.

DEF VAR n_asdat      AS DATE FORMAT "99/99/9999".
DEF VAR n_trndatto   AS DATE FORMAT "99/99/9999".

DEF VAR nv_datfr     AS DATE FORMAT "99/99/9999".
DEF VAR nv_datto     AS DATE FORMAT "99/99/9999".
/*DEF VAR nv_branfr    AS CHAR FORMAT "X(2)".
DEF VAR nv_branto    AS CHAR FORMAT "X(2)".

DEF VAR nv_nbran     AS CHAR FORMAT "X(50)".
DEF VAR n_nbran      AS CHAR FORMAT "X(50)".

DEF VAR n_ostyp      AS INT INIT 0.
DEF VAR nv_ntype     AS CHAR FORMAT "X(30)".

DEF VAR n_output     AS CHAR FORMAT "X(25)".
DEF VAR nv_output    AS CHAR FORMAT "X(30)".
DEF VAR nv_output2   AS CHAR FORMAT "X(30)".

DEF VAR nv_claim     AS CHAR FORMAT "X(16)".
DEF VAR nv_clmant    AS INT  FORMAT 999.
DEF VAR nv_clitem    AS INT  FORMAT 999.

DEF VAR nv_poldes    AS CHAR FORMAT "X(50)".
DEF VAR nv_name      AS CHAR FORMAT "X(50)".
DEF VAR nv_acno1     AS CHAR FORMAT "X(30)".
DEF VAR nv_cedclm    AS CHAR FORMAT "X(30)".

DEF VAR nv_prodnam   AS CHAR FORMAT "X(30)".
DEF VAR nv_produc    AS CHAR FORMAT "X(30)".
DEF VAR nv_extnam    AS CHAR FORMAT "X(30)".
DEF VAR nv_exter     AS CHAR FORMAT "X(30)".
DEF VAR nv_extref    AS CHAR FORMAT "X(30)".
DEF VAR nv_wextref   AS CHAR FORMAT "X(30)".

DEF VAR nv_adjust    AS CHAR FORMAT "X(30)".
DEF VAR nv_adjusna   AS CHAR FORMAT "X(30)".

DEF VAR nv_police    AS CHAR FORMAT "X(30)".
DEF VAR nv_pacod     AS CHAR FORMAT "X(30)".
DEF VAR nv_pades     AS CHAR FORMAT "X(30)".

DEF VAR n_adjusna  AS CHAR FORMAT "X(50)".
DEF VAR n_adjust   AS CHAR FORMAT "X(45)".

DEF VAR n_tos   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_tpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_tamt  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR nv_bros   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_brpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_bramt  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR n_bros   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_brpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_bramt  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR n_gros   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_grpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gramt  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR n_dos  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_damt AS DECI EXTENT 18.

DEF VAR n_txt  AS CHAR FORMAT "X(20)".

DEF VAR nv_asdat   AS DATE FORMAT "99/99/999".
DEF VAR nv_event   AS CHAR FORMAT "X(16)".
DEF VAR nv_defau   AS CHAR FORMAT "X(25)".
DEF VAR nv_loss1   AS CHAR FORMAT "X(2)".
DEF VAR nv_comdat  AS DATE FORMAT "99/99/9999".
DEF VAR nv_expdat  AS DATE FORMAT "99/99/9999".
DEF VAR nv_renpol  AS CHAR FORMAT "X(16)".
DEF VAR nv_covcod  LIKE uwm301.covcod.

DEF VAR nv_insurnam AS CHAR FORMAT "X(50)".
DEF VAR nv_pdcode  LIKE xmm600.acno.
DEF VAR nv_pdname  LIKE XMM600.name.
DEF VAR nv_nacod   AS CHAR FORMAT "X(2)".
DEF VAR nv_nades   AS CHAR FORMAT "X(40)".
DEF VAR nv_paid    AS DECI FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR n_netl_d   LIKE clm130.netl_d.
DEF VAR n_paiddat  LIKE clm130.trndat.

DEFINE WORKFILE WCZM100
    FIELD wfpoltyp AS CHAR FORMAT "X(2)"
    FIELD wfDI     AS CHAR FORMAT "X"
    FIELD wfpoldes AS CHAR FORMAT "X(35)"
    FIELD wfos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99".

DEFINE WORKFILE WLCZM100
    FIELD wlbran   AS CHAR FORMAT "X(2)"
    FIELD wlpoltyp AS CHAR FORMAT "X(2)"
    FIELD wlos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wlamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99".

DEF WORKFILE wfpoltyp
    FIELD wfpbr     AS CHAR FORMAT "X(2)"
    FIELD wftyp     AS CHAR FORMAT "x(1)"
    FIELD wfline    AS CHAR FORMAT "X(4)"
    FIELD wfpres    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfppaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfpamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcnt     AS INT FORMAT ">>>,>>9".

DEF WORKFILE wfcpoltyp /*Comp*/
    FIELD wfcpbr     AS CHAR FORMAT "X(2)"
    FIELD wfctyp     AS CHAR FORMAT "x(1)"
    FIELD wfcpres    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcppaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcpamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcpcnt    AS INT  FORMAT ">>>,>>9".

DEF WORKFILE wfbranch
    FIELD wfbr     AS CHAR FORMAT "X(2)"
    FIELD wfbline  AS CHAR FORMAT "X(2)"
    FIELD wfbres   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfbpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfbpamt  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfbcnt   AS INT  FORMAT ">>,>>9".

DEF WORKFILE wfcbranch /*Comp*/
    FIELD wfcbr     AS CHAR FORMAT "X(2)"
    FIELD wfcbline  AS CHAR FORMAT "X(2)"
    FIELD wfcbres   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcbpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcbpamt   AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcbcnt   AS INT  FORMAT ">>,>>9".

DEF WORKFILE wftbranch
    FIELD wftbr     AS CHAR FORMAT "X(2)"
    FIELD wftbres   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wftbpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wftbpamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wftbcnt   AS INT  FORMAT ">>,>>9".
 
DEF WORKFILE wfctbranch /*Comp*/
    FIELD wfctbr     AS CHAR FORMAT "X(2)"
    FIELD wfctbres   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfctbpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfctbamt   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfctbcnt   AS INT  FORMAT ">>,>>9".

DEF WORKFILE wfnon
    FIELD wfnbran   AS CHAR FORMAT "X(2)"
    FIELD wfnpoltyp AS CHAR FORMAT "X(2)"
    FIELD wfnDI     AS CHAR FORMAT "X"
    FIELD wfnos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfnpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfnamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99".

DEF WORKFILE wfcnon
    FIELD wfcnbran   AS CHAR FORMAT "X(2)"
    FIELD wfcnpoltyp AS CHAR FORMAT "X(2)"
    FIELD wfcnDI     AS CHAR FORMAT "X"
    FIELD wfcnos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcnpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcnamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99".

DEF WORKFILE wfcnt  
    FIELD cntbranch AS CHAR FORMAT "X(2)"
    FIELD reccnt   AS INT  FORMAT ">>>,>>9" INIT 0.

DEF WORKFILE wflcnt  
    FIELD cntline  AS CHAR FORMAT "X(2)"
    FIELD reclcnt   AS INT  FORMAT ">>>,>>9" INIT 0.

DEF WORKFILE wfcntLine 
    FIELD cline  AS CHAR FORMAT "X(2)"
    FIELD reccntline AS INT FORMAT ">>>,>>9" INIT 0.

DEF VAR n_sosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_spaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_bosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_bpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_bcnt   AS INT FORMAT ">>,>>9".
DEF VAR n_tosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR nv_sumpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_sumos   AS DECI FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR n_os     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_paid   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_cnt     AS   INT   FORMAT ">>,>>9".

DEF VAR n_compos AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_comppaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_compcnt     AS   INT   FORMAT ">>,>>9".

DEF VAR n_cosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_cpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_ccnt   AS INT FORMAT ">>,>>>,>>9".

DEF VAR n_tcosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_tcpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_tcnt   AS INT FORMAT ">>,>>9".

DEF VAR n_gcosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gcpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gccnt   AS INT FORMAT ">>,>>9".

DEF VAR i AS INT INIT 0.

DEF VAR wt_cnt    AS   INT   FORMAT ">>,>>9".
DEF VAR w_cnt    AS   INT   FORMAT ">>,>>9".
DEF VAR wg_cnt    AS   INT   FORMAT ">>>,>>9".
DEF VAR n_claim   AS   CHAR  FORMAT "X(16)".
DEF VAR nt_cnt    AS   INT   FORMAT ">>,>>9".

*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES acproc_fil

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 acproc_fil.asdat acproc_fil.type ~
acproc_fil.typdesc acproc_fil.trndatfr acproc_fil.trndatto ~
acproc_fil.entdat acproc_fil.enttim acproc_fil.usrid 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH acproc_fil ~
      WHERE acproc_fil.type = "10" NO-LOCK ~
    BY acproc_fil.asdat DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH acproc_fil ~
      WHERE acproc_fil.type = "10" NO-LOCK ~
    BY acproc_fil.asdat DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 acproc_fil
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 acproc_fil


/* Definitions for FRAME frReport                                       */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frReport ~
    ~{&OPEN-QUERY-BROWSE-1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-21 IMAGE-23 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-21
     FILENAME "wimage/wallpape.bmp":U CONVERT-3D-COLORS
     SIZE 131.5 BY 16.57.

DEFINE IMAGE IMAGE-23
     FILENAME "wimage/bgc01.bmp":U CONVERT-3D-COLORS
     SIZE 117 BY 14.29.

DEFINE BUTTON buCancel 
     LABEL "Cancel" 
     SIZE 18.5 BY 2.1
     FONT 6.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 18.5 BY 2.1
     FONT 6.

DEFINE VARIABLE fiAsdat AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 14 BY .71
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 14 BY .71
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE RECTANGLE RecBrowse
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 106.5 BY 6.19
     BGCOLOR 8 .

DEFINE RECTANGLE RecOK
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 49 BY 3.1
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      acproc_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 C-Win _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      acproc_fil.asdat FORMAT "99/99/9999":U
      acproc_fil.type COLUMN-LABEL "Type" FORMAT "X(2)":U WIDTH 3.5
      acproc_fil.typdesc COLUMN-LABEL "Process Desc." FORMAT "X(35)":U
            WIDTH 23.33
      acproc_fil.trndatfr COLUMN-LABEL "Trans.Date From" FORMAT "99/99/9999":U
            WIDTH 14.83
      acproc_fil.trndatto COLUMN-LABEL "Trans.Date To" FORMAT "99/99/9999":U
            WIDTH 14.33
      acproc_fil.entdat FORMAT "99/99/9999":U WIDTH 9.33
      acproc_fil.enttim FORMAT "X(8)":U
      acproc_fil.usrid FORMAT "X(7)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 102.83 BY 4.05
         BGCOLOR 15  EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-21 AT ROW 1 COL 1
     IMAGE-23 AT ROW 1.95 COL 8.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 131.5 BY 16.67.

DEFINE FRAME frReport
     BROWSE-1 AT ROW 4 COL 4
     buOK AT ROW 10.1 COL 36.17
     buCancel AT ROW 10.1 COL 60.67
     fiAsdat AT ROW 2.86 COL 18.33 COLON-ALIGNED NO-LABEL
     fiProcessDate AT ROW 2.86 COL 69.5 COLON-ALIGNED NO-LABEL
     " Process Date" VIEW-AS TEXT
          SIZE 14 BY .71 AT ROW 2.86 COL 57
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "( วันที่ทำการประมวลผล )" VIEW-AS TEXT
          SIZE 19 BY 1.19 AT ROW 2.62 COL 34.67
          BGCOLOR 8 
     "( วันที่ทำการประมวลผล )" VIEW-AS TEXT
          SIZE 19 BY 1.19 AT ROW 2.67 COL 86
          BGCOLOR 8 
     " As of Date" VIEW-AS TEXT
          SIZE 11.5 BY .71 AT ROW 2.86 COL 8.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                                                   DELETE FOR  OUTSTANDING CLAIM" VIEW-AS TEXT
          SIZE 110 BY .95 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     RecBrowse AT ROW 2.29 COL 2.67
     RecOK AT ROW 9.57 COL 33
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 12 ROW 2.76
         SIZE 110.5 BY 12.52
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
         HEIGHT             = 16.67
         WIDTH              = 131.5
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

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
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
/* BROWSE-TAB BROWSE-1 1 frReport */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "sicfn.acproc_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "sicfn.acproc_fil.asdat|no"
     _Where[1]         = "sicfn.acproc_fil.type = ""10"""
     _FldNameList[1]   = sicfn.acproc_fil.asdat
     _FldNameList[2]   > sicfn.acproc_fil.type
"type" "Type" ? "character" ? ? ? ? ? ? no ? no no "3.5" yes no no "U" "" ""
     _FldNameList[3]   > sicfn.acproc_fil.typdesc
"typdesc" "Process Desc." ? "character" ? ? ? ? ? ? no ? no no "23.33" yes no no "U" "" ""
     _FldNameList[4]   > sicfn.acproc_fil.trndatfr
"trndatfr" "Trans.Date From" ? "date" ? ? ? ? ? ? no ? no no "14.83" yes no no "U" "" ""
     _FldNameList[5]   > sicfn.acproc_fil.trndatto
"trndatto" "Trans.Date To" ? "date" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" ""
     _FldNameList[6]   > sicfn.acproc_fil.entdat
"entdat" ? ? "date" ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" ""
     _FldNameList[7]   = sicfn.acproc_fil.enttim
     _FldNameList[8]   > sicfn.acproc_fil.usrid
"usrid" ? "X(7)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
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


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define FRAME-NAME frReport
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 C-Win
ON VALUE-CHANGED OF BROWSE-1 IN FRAME frReport
DO:
  
  DO WITH FRAME frReport:
    IF NOT CAN-FIND(FIRST acproc_fil WHERE acproc_fil.type = "10") THEN DO:
        ASSIGN
            fiasdat = ?
            fiProcessdate = ?
            n_trndatto = ?
            n_asdat = fiasdat.
        DISP fiasdat fiProcessdate.
    END.
    ELSE DO:
        FIND CURRENT acproc_fil NO-LOCK.
        ASSIGN
            fiasdat = acproc_fil.asdat
            fiProcessdate = acproc_fil.entdat
            n_trndatto = acproc_fil.trndatto
            n_asdat = fiasdat
            nv_datfr = acproc_fil.trndatfr
            nv_datto = acproc_fil.trndatto.
        DISP fiasdat fiProcessdate.
    END.
  END. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCancel C-Win
ON CHOOSE OF buCancel IN FRAME frReport /* Cancel */
DO:
    RUN wac\wacdisc9.
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK C-Win
ON CHOOSE OF buOK IN FRAME frReport /* OK */
DO:
  n_asdat = fiasdat.
  MESSAGE "ทำการลบข้อมูล ! " SKIP (1)
          "DELETE OUTSTANDING CLAIM " SKIP(1)
          "วันที่ประมวลผลข้อมูล  : " STRING(n_asdat,"99/99/9999")  SKIP (1)
          "กรมธรรม์ตั้งแต่วันที่ : " STRING(nv_datfr,"99/99/9999") " ถึง " 
           STRING(nv_datto,"99/99/9999") 
           VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO
   
   UPDATE CHOICE AS LOGICAL. 

   CASE CHOICE:
        WHEN TRUE THEN DO:
             RUN del_acproc_fil.
             RUN del_czm100.
             RUN DEL_czd101.
            
             OPEN QUERY BROWSE-1 FOR EACH acproc_fil WHERE acproc_fil.TYPE = "10" NO-LOCK.
            
             MESSAGE "Deleting Complete" VIEW-AS ALERT-BOX.
        END.
        WHEN FALSE THEN DO:
             RETURN NO-APPLY.    
        END.
   END CASE.
  

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

  ASSIGN   fiasdat       = acproc_fil.asdat
           fiProcessdate = acproc_fil.entdat
           n_trndatto    = acproc_fil.trndatto
           n_asdat       = fiasdat
           nv_datfr      = acproc_fil.trndatfr
           nv_datto      = acproc_fil.trndatto.

  DISP fiasdat fiProcessdate WITH FRAME frReport.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
     WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE del_acproc_fil C-Win 
PROCEDURE del_acproc_fil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
          (acProc_fil.asdat = n_asdat AND acProc_fil.type = "10") NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
       DISP "Delete"  WITH NO-LABEL TITLE "Delete O/S Claim at acproc_fil" FRAME a
       VIEW-AS DIALOG-BOX.
       DELETE acProc_fil.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE del_czd101 C-Win 
PROCEDURE del_czd101 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH czd101  USE-INDEX czd10101 WHERE
         czd101.asdat = n_asdat:
   DISP "Deleting czd101..." WITH NO-LABEL TITLE "Delete O/S Claim at CZD101" FRAME a
        VIEW-AS DIALOG-BOX.
   DELETE czd101.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE del_czm100 C-Win 
PROCEDURE del_czm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH czm100 USE-INDEX czm10001 WHERE
         czm100.asdat = n_asdat: 
   DISP "Deleting czm100..." WITH NO-LABEL TITLE "Delete O/S Claim at CZM100" FRAME a
        VIEW-AS DIALOG-BOX.
   DELETE czm100.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  ENABLE IMAGE-21 IMAGE-23 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fiAsdat fiProcessDate 
      WITH FRAME frReport IN WINDOW C-Win.
  ENABLE BROWSE-1 buOK buCancel fiAsdat fiProcessDate RecBrowse RecOK 
      WITH FRAME frReport IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frReport}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

