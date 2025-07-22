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

DEF VAR non_poltyp AS INT INIT 0.
                                             
DEF VAR n_asdat      AS DATE FORMAT "99/99/9999".
DEF VAR n_trndatto   AS DATE FORMAT "99/99/9999".

DEF VAR nv_datfr     AS DATE FORMAT "99/99/9999".
DEF VAR nv_datto     AS DATE FORMAT "99/99/9999".
DEF VAR n_prodat     AS CHAR FORMAT "X(6)".

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
      WHERE acproc_fil.type = "11" NO-LOCK ~
    BY acproc_fil.asdat DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH acproc_fil ~
      WHERE acproc_fil.type = "11" NO-LOCK ~
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
      acproc_fil.usrid FORMAT "X(6)":U
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
     "                                                           DELETE FOR  PREW-FILE" VIEW-AS TEXT
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
     _Where[1]         = "sicfn.acproc_fil.type = ""11"""
     _FldNameList[1]   = sicfn.acproc_fil.asdat
     _FldNameList[2]   > sicfn.acproc_fil.type
"acproc_fil.type" "Type" ? "character" ? ? ? ? ? ? no ? no no "3.5" yes no no "U" "" ""
     _FldNameList[3]   > sicfn.acproc_fil.typdesc
"acproc_fil.typdesc" "Process Desc." ? "character" ? ? ? ? ? ? no ? no no "23.33" yes no no "U" "" ""
     _FldNameList[4]   > sicfn.acproc_fil.trndatfr
"acproc_fil.trndatfr" "Trans.Date From" ? "date" ? ? ? ? ? ? no ? no no "14.83" yes no no "U" "" ""
     _FldNameList[5]   > sicfn.acproc_fil.trndatto
"acproc_fil.trndatto" "Trans.Date To" ? "date" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" ""
     _FldNameList[6]   > sicfn.acproc_fil.entdat
"acproc_fil.entdat" ? ? "date" ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" ""
     _FldNameList[7]   = sicfn.acproc_fil.enttim
     _FldNameList[8]   = sicfn.acproc_fil.usrid
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
    IF NOT CAN-FIND(FIRST acproc_fil WHERE acproc_fil.type = "11") THEN DO:
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

  n_prodat = STRING(YEAR(nv_datto)) + STRING(MONTH(nv_datto),"99").

  MESSAGE "ทำการลบข้อมูล ! " SKIP (1)
          "DELETE OUTSTANDING CLAIM " SKIP(1)
          "วันที่ประมวลผลข้อมูล  : " STRING(n_asdat,"99/99/9999")  SKIP (1)
          "กรมธรรม์ตั้งแต่วันที่ : " STRING(nv_datfr,"99/99/9999") " ถึง " 
           STRING(nv_datto,"99/99/9999") 
  VIEW-AS ALERT-BOX. 
  RUN del_acproc_fil.
  RUN del_ucrein.

  OPEN QUERY BROWSE-1 FOR EACH acproc_fil WHERE acproc_fil.TYPE = "11" NO-LOCK.

  MESSAGE "Deleting Complete" VIEW-AS ALERT-BOX.
  

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

  ASSIGN   fiasdat = acproc_fil.asdat
           fiProcessdate = acproc_fil.entdat
           n_trndatto = acproc_fil.trndatto
           n_asdat = fiasdat
           nv_datfr = acproc_fil.trndatfr
           nv_datto = acproc_fil.trndatto.

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
          (acProc_fil.asdat = n_asdat AND acProc_fil.type = "11") NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
       DISP "Delete"  WITH NO-LABEL TITLE "Delete O/S Claim at acproc_fil" FRAME a
       VIEW-AS DIALOG-BOX.
       DELETE acProc_fil.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE del_ucrein C-Win 
PROCEDURE del_ucrein :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH ucrein USE-INDEX ucrein01 WHERE SUBSTR(UCREIN.POINT,1,6) = n_prodat.
    DELETE ucrein.

    DISP "Deleting PREW-File..." WITH NO-LABEL TITLE "Delete PREW-FILE From UCREIN" FRAME a
    VIEW-AS DIALOG-BOX.
 
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

