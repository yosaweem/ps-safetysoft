&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
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

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  program id   : wgwmuscb.w  [IMPORT && EXPORT TEXT FILE SCBPT] 
  Create  by   : Ranu I. A60-0448 Date 16/10/2017 
  Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW ,STAT 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/* Modify By   : Tontawan S. A66-0006 16/06/2023
               : จัดลำดับการเรียงข้อเมนูใหม่
                 1.Hold data Notify / Inspection 
                 2.Query Data Notify / Inspection
                 3.Load Text File SCBPT
                 4.Match File Load and Update Data TLT                          */
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DEF SHARED VAR n_User   AS CHAR.
DEF SHARED VAR n_PassWd AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BUTTON-1 bu_exit bu_kk-74 bu_kk-75 bu_kk-76 ~
bu_kk-81 bu_kk-82 RECT-367 RECT-364 RECT-369 RECT-385 RECT-365 RECT-371 ~
RECT-372 RECT-373 RECT-374 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-1 
     LABEL "Export File Inspection Send to SCBPT" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 7.67 BY 1.1
     FONT 6.

DEFINE BUTTON bu_kk-74 
     LABEL "Load Text File SCBPT" 
     SIZE 42 BY 1.24
     BGCOLOR 8 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_kk-75 
     LABEL "Query Data Notify / Inspection" 
     SIZE 42 BY 1.24
     BGCOLOR 8 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_kk-76 
     LABEL "Hold data Notify / Inspection" 
     SIZE 42 BY 1.24
     BGCOLOR 8 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_kk-81 
     LABEL "Export File Policy Send To SCBPT" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_kk-82 
     LABEL "Match File Load and Update Data TLT" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FGCOLOR 1 FONT 6.

DEFINE RECTANGLE RECT-364
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 52 BY 11.19
     BGCOLOR 29 FGCOLOR 10 .

DEFINE RECTANGLE RECT-365
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 50.5 BY 11.24
     BGCOLOR 29 FGCOLOR 10 .

DEFINE RECTANGLE RECT-367
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.67 BY 1.81
     BGCOLOR 12 .

DEFINE RECTANGLE RECT-369
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 1 FGCOLOR 3 .

DEFINE RECTANGLE RECT-371
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 4 FGCOLOR 5 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 4 FGCOLOR 5 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 4 FGCOLOR 5 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 4 FGCOLOR 5 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     BUTTON-1 AT ROW 4.33 COL 60.83
     bu_exit AT ROW 14.95 COL 99.17
     bu_kk-74 AT ROW 9.43 COL 8.67
     bu_kk-75 AT ROW 6.81 COL 8.17
     bu_kk-76 AT ROW 4.33 COL 8.17
     bu_kk-81 AT ROW 6.81 COL 60.33
     bu_kk-82 AT ROW 11.95 COL 8.67
     "IMPORT TEXT FILE SCBPT" VIEW-AS TEXT
          SIZE 30 BY 1 AT ROW 1.29 COL 39.67
          FGCOLOR 7 FONT 2
     "  Import Data To Table" VIEW-AS TEXT
          SIZE 23.5 BY 1 AT ROW 2.48 COL 16.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "  Match Data To SCBPT" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 2.57 COL 70.5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     RECT-367 AT ROW 14.57 COL 97
     RECT-364 AT ROW 2.91 COL 56
     RECT-369 AT ROW 6.43 COL 59
     RECT-385 AT ROW 3.95 COL 59.17
     RECT-365 AT ROW 2.86 COL 4
     RECT-371 AT ROW 9 COL 7
     RECT-372 AT ROW 6.43 COL 6.83
     RECT-373 AT ROW 3.91 COL 6.83
     RECT-374 AT ROW 11.62 COL 7.17
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 110.33 BY 16
         BGCOLOR 30 FGCOLOR 30 .


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
         TITLE              = "Import Text File(SCBPT)"
         HEIGHT             = 16
         WIDTH              = 110.33
         MAX-HEIGHT         = 45
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 45
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
IF NOT C-Win:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
ASSIGN 
       bu_kk-74:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-75:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-76:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-81:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-82:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import Text File(SCBPT) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import Text File(SCBPT) */
DO:
  /* This event will close the window and terminate the procedure.  */
  
  /*
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
  */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 C-Win
ON CHOOSE OF BUTTON-1 IN FRAME DEFAULT-FRAME /* Export File Inspection Send to SCBPT */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwmtscb1.   
    {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME DEFAULT-FRAME /* EXIT */
DO:
  Apply "Close" To This-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-74
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-74 C-Win
ON CHOOSE OF bu_kk-74 IN FRAME DEFAULT-FRAME /* Load Text File SCBPT */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwtlscb.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-75
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-75 C-Win
ON CHOOSE OF bu_kk-75 IN FRAME DEFAULT-FRAME /* Query Data Notify / Inspection */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwqscb0.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-76
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-76 C-Win
ON CHOOSE OF bu_kk-76 IN FRAME DEFAULT-FRAME /* Hold data Notify / Inspection */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwimscb.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-81
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-81 C-Win
ON CHOOSE OF bu_kk-81 IN FRAME DEFAULT-FRAME /* Export File Policy Send To SCBPT */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwmtscb2.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-82
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-82 C-Win
ON CHOOSE OF bu_kk-82 IN FRAME DEFAULT-FRAME /* Match File Load and Update Data TLT */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwmtscb3.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
  
     /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "wgwmuSCB.w".
  gv_prog  = "Import Text File(SCBPT)".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
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
  ENABLE BUTTON-1 bu_exit bu_kk-74 bu_kk-75 bu_kk-76 bu_kk-81 bu_kk-82 RECT-367 
         RECT-364 RECT-369 RECT-385 RECT-365 RECT-371 RECT-372 RECT-373 
         RECT-374 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

