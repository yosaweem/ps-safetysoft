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

/*++++++++++++++++++++++++++++++++++++++++++++++
  program id   : WGWMEWEB.w   Menu Gen Policy and Query Policy
  Create  by   : Kridtiya i. A64-0187 Date. 19/04/2021
  Connect      : not connect
 +++++++++++++++++++++++++++++++++++++++++++++++*/
Def  shared  Var   n_User      As    Char.
Def  Shared  Var   n_PassWd    As    Char.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_exit bu_kk-75 bu_kk-76 RECT-349 RECT-367 ~
RECT-361 RECT-364 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 8 BY 1.1
     FONT 6.

DEFINE BUTTON bu_kk-75 
     LABEL "QUERY Policy" 
     SIZE 45 BY 1.24
     BGCOLOR 15 FGCOLOR 0 FONT 6.

DEFINE BUTTON bu_kk-76 
     LABEL "Gen Policy" 
     SIZE 45 BY 1.24
     BGCOLOR 15 FGCOLOR 0 FONT 6.

DEFINE RECTANGLE RECT-349
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 60 BY 2
     BGCOLOR 3 FGCOLOR 0 .

DEFINE RECTANGLE RECT-361
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 60 BY 2
     BGCOLOR 1 FGCOLOR 2 .

DEFINE RECTANGLE RECT-364
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 60 BY 2
     BGCOLOR 1 FGCOLOR 2 .

DEFINE RECTANGLE RECT-367
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12 BY 1.91
     BGCOLOR 12 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bu_exit AT ROW 8.29 COL 51.5
     bu_kk-75 AT ROW 5.86 COL 8
     bu_kk-76 AT ROW 3.86 COL 8
     "Gen Policy and Query Policy" VIEW-AS TEXT
          SIZE 32 BY 1 AT ROW 1.48 COL 18.17
          BGCOLOR 3 FGCOLOR 7 FONT 6
     RECT-349 AT ROW 1.14 COL 2
     RECT-367 AT ROW 7.91 COL 49.5
     RECT-361 AT ROW 5.52 COL 2
     RECT-364 AT ROW 3.52 COL 2
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 62.33 BY 9.24
         BGCOLOR 19 .


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
         TITLE              = "WGWMEWEB.w Gen Policy Web Service and Query"
         HEIGHT             = 9.38
         WIDTH              = 62.67
         MAX-HEIGHT         = 18.1
         MAX-WIDTH          = 64
         VIRTUAL-HEIGHT     = 18.1
         VIRTUAL-WIDTH      = 64
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
       bu_kk-75:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-76:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* WGWMEWEB.w Gen Policy Web Service and Query */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* WGWMEWEB.w Gen Policy Web Service and Query */
DO:
  /* This event will close the window and terminate the procedure.  */
  
  /*
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
  */
  
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


&Scoped-define SELF-NAME bu_kk-75
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-75 C-Win
ON CHOOSE OF bu_kk-75 IN FRAME DEFAULT-FRAME /* QUERY Policy */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\Wgwqryp1.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-76
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-76 C-Win
ON CHOOSE OF bu_kk-76 IN FRAME DEFAULT-FRAME /* Gen Policy */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\Wgwrpol1.   
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
  
  gv_prgid = "WGWMEWEB.w".
  gv_prog  = "Gen Policy Number And Query Policy".
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
  ENABLE bu_exit bu_kk-75 bu_kk-76 RECT-349 RECT-367 RECT-361 RECT-364 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

