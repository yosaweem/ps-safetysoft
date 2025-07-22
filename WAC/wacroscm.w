&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RecOK-3 RecOK-4 RecOK-5 RecOK-6 RecOK-7 ~
bu_procsum bu_postjv bu_prnjv bu_delete bu_exit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_delete 
     LABEL "Delete JV" 
     SIZE 28 BY 1.52
     FONT 2.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 17 BY 1.52
     FONT 2.

DEFINE BUTTON bu_postjv 
     LABEL "Auto Post JV" 
     SIZE 28 BY 1.52
     BGCOLOR 1 FONT 2.

DEFINE BUTTON bu_prnjv 
     LABEL "Print JV" 
     SIZE 28 BY 1.52
     FONT 2.

DEFINE BUTTON bu_procsum 
     LABEL "Report Sum O/S Claim (New)" 
     SIZE 45 BY 1.52
     FONT 2.

DEFINE RECTANGLE RecOK-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 29.5 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RecOK-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 29.5 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RecOK-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18.5 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RecOK-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 29.5 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RecOK-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 46.5 BY 2
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bu_procsum AT ROW 4.05 COL 14
     bu_postjv AT ROW 6.67 COL 22.67
     bu_prnjv AT ROW 9.29 COL 22.67
     bu_delete AT ROW 11.81 COL 22.67
     bu_exit AT ROW 14.33 COL 28
     "                   O/S CLAIM REPORT" VIEW-AS TEXT
          SIZE 71 BY 1.52 AT ROW 1.67 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 2
     RecOK-3 AT ROW 6.43 COL 21.83
     RecOK-4 AT ROW 9.05 COL 21.83
     RecOK-5 AT ROW 14.1 COL 27.17
     RecOK-6 AT ROW 11.57 COL 21.83
     RecOK-7 AT ROW 3.81 COL 13.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 71.17 BY 16.1
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
         HEIGHT             = 16
         WIDTH              = 71
         MAX-HEIGHT         = 17.24
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 17.24
         VIRTUAL-WIDTH      = 80
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
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
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


&Scoped-define SELF-NAME bu_delete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_delete C-Win
ON CHOOSE OF bu_delete IN FRAME DEFAULT-FRAME /* Delete JV */
DO:
  RUN wac\wacrosc5.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME DEFAULT-FRAME /* EXIT */
DO:

  RUN wac\wacdisfn.

  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_postjv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_postjv C-Win
ON CHOOSE OF bu_postjv IN FRAME DEFAULT-FRAME /* Auto Post JV */
DO:
  RUN wac\wacrosc3.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_prnjv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_prnjv C-Win
ON CHOOSE OF bu_prnjv IN FRAME DEFAULT-FRAME /* Print JV */
DO:
  RUN wac\wacrosc4.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_procsum
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_procsum C-Win
ON CHOOSE OF bu_procsum IN FRAME DEFAULT-FRAME /* Report Sum O/S Claim (New) */
DO:
  RUN wac\wacrosc0.
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
  
  DEF VAR gv_prog  AS CHAR FORMAT "x(30)".         
  DEF VAR gv_prgid AS CHAR FORMAT "x(15)".         
                                                   
  gv_prgid = "WACROSCM".                           
  gv_prog  = "O/S Claim Report".                
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
                                                   
  SESSION:DATA-ENTRY-RETURN = YES.    
  RUN wac\wacconfn.
  RUN wac\waccongl.
  RUN enable_UI.

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
  ENABLE RecOK-3 RecOK-4 RecOK-5 RecOK-6 RecOK-7 bu_procsum bu_postjv bu_prnjv 
         bu_delete bu_exit 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

