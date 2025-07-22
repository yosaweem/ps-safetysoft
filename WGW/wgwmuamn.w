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
     cleanup will occur on deletion of the procedure.                   */
     
CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/*++++++++++++++++++++++++++++++++++++++++++++++
  program id   : wgwmuamn.w   [Menu Import data By Amanh...] 
  Create  by   : kridtiya i.  [A59-0145]  date. 25/04/2016
  Connect      : -
+++++++++++++++++++++++++++++++++++++++++++++++*/

DEF SHARED VAR     n_User      AS CHAR.
DEF SHARED VAR     n_PassWd    AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-329 RECT-342 RECT-343 RECT-346 RECT-349 ~
RECT-347 RECT-344 RECT-348 RECT-350 bu_Hold bu_import72 bu_query bu_gen-2 ~
bu_update bu_mat-2 bu_exit 

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
     SIZE 8 BY 1.24
     FONT 6.

DEFINE BUTTON bu_gen-2 
     LABEL "" 
     SIZE 42 BY 1.24
     FONT 6.

DEFINE BUTTON bu_Hold 
     IMAGE-DOWN FILE "adeicon/admin%.ico":U
     LABEL "IMPORT FILE HOLD" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_import72 
     LABEL "" 
     SIZE 42 BY 1.24
     FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_mat-2 
     LABEL "" 
     SIZE 42 BY 1.24
     FONT 6.

DEFINE BUTTON bu_query 
     LABEL "QUERY AND UPDATE DATA HOLD" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_update 
     LABEL "LOAD TEXT FILE AMANAH" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FGCOLOR 2 FONT 6.

DEFINE RECTANGLE RECT-329
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 97 BY 11.91
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-342
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 20 FGCOLOR 0 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 2.05
     BGCOLOR 4 FGCOLOR 4 .

DEFINE RECTANGLE RECT-344
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 3 FGCOLOR 0 .

DEFINE RECTANGLE RECT-346
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 20 FGCOLOR 10 .

DEFINE RECTANGLE RECT-347
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 20 FGCOLOR 2 .

DEFINE RECTANGLE RECT-348
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 3 FGCOLOR 0 .

DEFINE RECTANGLE RECT-349
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 94.5 BY 2.24
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-350
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 31 FGCOLOR 7 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bu_Hold AT ROW 3.86 COL 5.33
     bu_import72 AT ROW 3.91 COL 51.33
     bu_query AT ROW 6 COL 5.33
     bu_gen-2 AT ROW 6.1 COL 51
     bu_update AT ROW 8.1 COL 5.5
     bu_mat-2 AT ROW 8.19 COL 51
     bu_exit AT ROW 10.76 COL 45.83
     "                                    MENU IMPORT AND EXPORT AMANAH" VIEW-AS TEXT
          SIZE 89.5 BY 1.24 AT ROW 1.57 COL 4.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-329 AT ROW 1 COL 1
     RECT-342 AT ROW 7.76 COL 4
     RECT-343 AT ROW 10.33 COL 44
     RECT-346 AT ROW 3.48 COL 4.17
     RECT-349 AT ROW 1.05 COL 2
     RECT-347 AT ROW 5.62 COL 4.17
     RECT-344 AT ROW 3.57 COL 49.83
     RECT-348 AT ROW 5.67 COL 49.83
     RECT-350 AT ROW 7.81 COL 49.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 97.83 BY 12.05
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
         TITLE              = "Import And Export Data MAXI"
         HEIGHT             = 12
         WIDTH              = 97.33
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
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
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import And Export Data MAXI */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import And Export Data MAXI */
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


&Scoped-define SELF-NAME bu_Hold
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Hold C-Win
ON CHOOSE OF bu_Hold IN FRAME DEFAULT-FRAME /* IMPORT FILE HOLD */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwimamn.  
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_query
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_query C-Win
ON CHOOSE OF bu_query IN FRAME DEFAULT-FRAME /* QUERY AND UPDATE DATA HOLD */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwqamn0.  
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update C-Win
ON CHOOSE OF bu_update IN FRAME DEFAULT-FRAME /* LOAD TEXT FILE AMANAH */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwtamnh.  
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

  gv_prgid = "wgwmuamn.w".
  gv_prog  = "Import And Export Data Amanah".
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
  ENABLE RECT-329 RECT-342 RECT-343 RECT-346 RECT-349 RECT-347 RECT-344 
         RECT-348 RECT-350 bu_Hold bu_import72 bu_query bu_gen-2 bu_update 
         bu_mat-2 bu_exit 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

