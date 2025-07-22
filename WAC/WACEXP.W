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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-1 
&Scoped-Define DISPLAYED-OBJECTS FILL-IN-2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE FILL-IN-2 AS CHARACTER FORMAT "X(256)":U INITIAL " Transaction Date." 
      VIEW-AS TEXT 
     SIZE 106 BY 1
     BGCOLOR 1 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "I:/SAFETY/WALP83/WIMAGE\logoadd5":U
     SIZE 133 BY 24.04.

DEFINE BUTTON bu_cancel 
     LABEL "CANCEL" 
     SIZE 17 BY 1.57.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 17 BY 1.57.

DEFINE VARIABLE Fi_Output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1.04 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 33 BY 1.57
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE Fi_TransFr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1.04 NO-UNDO.

DEFINE VARIABLE Fi_TransTo AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1.04 NO-UNDO.

DEFINE RECTANGLE RECT-89
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 105.5 BY 7.39.

DEFINE RECTANGLE RECT-91
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 24.5 BY 6.26
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-92
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 77 BY 3.91
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-93
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 77 BY 2.09
     BGCOLOR 19 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     FILL-IN-2 AT ROW 8.04 COL 12 COLON-ALIGNED NO-LABEL
     IMAGE-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 24.04.

DEFINE FRAME Fr_Main
     Fi_TransFr AT ROW 2.3 COL 34 COLON-ALIGNED NO-LABEL
     Fi_TransTo AT ROW 3.61 COL 34 COLON-ALIGNED NO-LABEL
     Fi_Output AT ROW 6.22 COL 34 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 3 COL 84.5
     bu_cancel AT ROW 4.7 COL 84.5
     fi_process AT ROW 3.91 COL 33 NO-LABEL
     RECT-89 AT ROW 1 COL 1
     RECT-91 AT ROW 1.52 COL 80.5
     RECT-92 AT ROW 1.52 COL 2.5
     RECT-93 AT ROW 5.7 COL 2.5
     "To :" VIEW-AS TEXT
          SIZE 4.5 BY 1.04 AT ROW 3.61 COL 30.5
          BGCOLOR 19 FONT 6
     "Output To :" VIEW-AS TEXT
          SIZE 10.5 BY 1.04 AT ROW 6.22 COL 23.5
          BGCOLOR 19 FONT 6
     "Trans. Date From :" VIEW-AS TEXT
          SIZE 18 BY 1.04 AT ROW 2.3 COL 17
          BGCOLOR 19 FONT 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 14 ROW 9
         SIZE 106 BY 7.52.


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
         HEIGHT             = 24.04
         WIDTH              = 133.33
         MAX-HEIGHT         = 24.04
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.04
         VIRTUAL-WIDTH      = 133.33
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


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME Fr_Main:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FILL-IN FILL-IN-2 IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME Fr_Main
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_process IN FRAME Fr_Main
   NO-DISPLAY NO-ENABLE ALIGN-L                                         */
ASSIGN 
       fi_process:HIDDEN IN FRAME Fr_Main           = TRUE.

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


&Scoped-define FRAME-NAME Fr_Main
&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel C-Win
ON CHOOSE OF bu_cancel IN FRAME Fr_Main /* CANCEL */
DO:
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME Fr_Main /* OK */
DO:
  
  ENABLE fi_process WITH FRAME fr_main.
  DISP "                 Processing..." @ fi_process WITH FRAME fr_main.
      
  RUN Wac/Wacexp01 (INPUT Fi_TransFr,
                       INPUT Fi_TransTo,
                       INPUT Fi_Output).
                       
    HIDE fi_process.
                          
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Fi_Output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Fi_Output C-Win
ON LEAVE OF Fi_Output IN FRAME Fr_Main
DO:
  assign fi_output.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Fi_TransFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Fi_TransFr C-Win
ON LEAVE OF Fi_TransFr IN FRAME Fr_Main
DO:
     /*
     message "screen : " Fi_TransFr:screen-value skip
                   "buffer  : " Fi_TransFr view-as alert-box.
     assign fi_transfr.                  
     message "screen : " Fi_TransFr:screen-value skip
                   "buffer  : " Fi_TransFr view-as alert-box.
     */
     
     assign fi_transfr.
              
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Fi_TransTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Fi_TransTo C-Win
ON LEAVE OF Fi_TransTo IN FRAME Fr_Main
DO:
  assign fi_transto.
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
   
   RUN wut\wuthead (c-win:handle,"Wacexp","สมุดทะเบียนการต่ออายุกรมธรรม์").
   RUN wut\wutwicen (c-win:handle).
   
  RUN enable_UI.
  
   SESSION:DATA-ENTRY-RETURN=YES.
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win _DEFAULT-ENABLE
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
  DISPLAY FILL-IN-2 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE IMAGE-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY Fi_TransFr Fi_TransTo Fi_Output 
      WITH FRAME Fr_Main IN WINDOW C-Win.
  ENABLE RECT-89 RECT-91 RECT-92 RECT-93 Fi_TransFr Fi_TransTo Fi_Output bu_ok 
         bu_cancel 
      WITH FRAME Fr_Main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-Fr_Main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


