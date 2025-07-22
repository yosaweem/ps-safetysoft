&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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
/*Modify by : Ranu I. A59-0471  เพิ่มเมนู Match File text to Policy     */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-534 RECT-535 RECT-536 RECT-537 RECT-538 ~
RECT-539 RECT-540 RECT-541 RECT-542 RECT-543 RECT-544 RECT-546 RECT-547 ~
bu_tran bu_tran-2 bu_load bu_tran-3 bu_Export bu_tran-5 bu_Campaign ~
bu_matpol bu_exit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_Campaign 
     LABEL "4. Set Campaign Thanachat" 
     SIZE 35.5 BY 1.52
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 16 BY 1.52
     FONT 6.

DEFINE BUTTON bu_Export 
     LABEL "3. Export File Thanachat" 
     SIZE 35.5 BY 1.52
     FONT 6.

DEFINE BUTTON bu_load 
     LABEL "2. Load File Thanachat To GW" 
     SIZE 35.5 BY 1.52
     FONT 6.

DEFINE BUTTON bu_matpol 
     LABEL "Match File Text To Policy (Thanachat)" 
     SIZE 45 BY 1.52
     FGCOLOR 0 FONT 6.

DEFINE BUTTON bu_tran 
     LABEL "1.Translation File Thanachat" 
     SIZE 35.5 BY 1.52
     FONT 6.

DEFINE BUTTON bu_tran-2 
     LABEL "Import File HOLD Data Thanachat ( Renew )" 
     SIZE 44.5 BY 1.52
     FONT 6.

DEFINE BUTTON bu_tran-3 
     LABEL "Query / Update Data HOLD" 
     SIZE 44.5 BY 1.52
     FONT 6.

DEFINE BUTTON bu_tran-5 
     LABEL "Match File Confirm / Cancel / No Confirm" 
     SIZE 45.17 BY 1.52
     FONT 6.

DEFINE RECTANGLE RECT-534
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 104 BY 18.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-535
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 104 BY 2.14
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-536
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18.5 BY 2.05
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-537
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 48.5 BY 12.38
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-538
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 53 BY 12.38
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-539
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 41.5 BY 2.38
     BGCOLOR 4 FGCOLOR 0 .

DEFINE RECTANGLE RECT-540
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 41.5 BY 2.38
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-541
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 41.5 BY 2.38
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-542
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 41.5 BY 2.38
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-543
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 49 BY 2.38
     BGCOLOR 3 FGCOLOR 0 .

DEFINE RECTANGLE RECT-544
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 49 BY 2.38
     BGCOLOR 3 FGCOLOR 0 .

DEFINE RECTANGLE RECT-546
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 49 BY 2.38
     BGCOLOR 3 FGCOLOR 0 .

DEFINE RECTANGLE RECT-547
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 49 BY 2.38
     BGCOLOR 3 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bu_tran AT ROW 5.38 COL 9.83
     bu_tran-2 AT ROW 5.43 COL 56.67
     bu_load AT ROW 8.14 COL 9.83
     bu_tran-3 AT ROW 8.19 COL 56.5
     bu_Export AT ROW 10.91 COL 9.83
     bu_tran-5 AT ROW 10.91 COL 56
     bu_Campaign AT ROW 13.62 COL 9.83
     bu_matpol AT ROW 13.62 COL 56
     bu_exit AT ROW 17 COL 44.83
     "ข้อเมนูใหม่ ( งานต่ออายุ )" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 3.91 COL 66.67
          BGCOLOR 14 FGCOLOR 2 FONT 6
     "LOAD TEXT FILE THANACHAT" VIEW-AS TEXT
          SIZE 30.5 BY 1.67 AT ROW 1.24 COL 41
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "ข้อเมนูเดิม" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 3.86 COL 23.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-534 AT ROW 1 COL 1.5
     RECT-535 AT ROW 1 COL 1.5
     RECT-536 AT ROW 16.71 COL 43.5
     RECT-537 AT ROW 3.62 COL 3
     RECT-538 AT ROW 3.62 COL 52.17
     RECT-539 AT ROW 4.95 COL 7.33
     RECT-540 AT ROW 7.71 COL 7.33
     RECT-541 AT ROW 10.43 COL 7.17
     RECT-542 AT ROW 13.19 COL 7
     RECT-543 AT ROW 5.05 COL 54.17
     RECT-544 AT ROW 7.76 COL 54
     RECT-546 AT ROW 10.48 COL 54
     RECT-547 AT ROW 13.19 COL 54.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 104.5 BY 18.62.


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
         HEIGHT             = 18.62
         WIDTH              = 104.5
         MAX-HEIGHT         = 19
         MAX-WIDTH          = 105
         VIRTUAL-HEIGHT     = 19
         VIRTUAL-WIDTH      = 105
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


&Scoped-define SELF-NAME bu_Campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Campaign C-Win
ON CHOOSE OF bu_Campaign IN FRAME DEFAULT-FRAME /* 4. Set Campaign Thanachat */
DO:
  {&WINDOW-NAME}:HIDDEN = yes.
  RUN wgw/wgwtacam.
  {&WINDOW-NAME}:HIDDEN = no.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME DEFAULT-FRAME /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Export
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Export C-Win
ON CHOOSE OF bu_Export IN FRAME DEFAULT-FRAME /* 3. Export File Thanachat */
DO:
  {&WINDOW-NAME}:HIDDEN = yes.
  RUN wgw/wgwtta01.
  {&WINDOW-NAME}:HIDDEN = no.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_load
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_load C-Win
ON CHOOSE OF bu_load IN FRAME DEFAULT-FRAME /* 2. Load File Thanachat To GW */
DO:
  {&WINDOW-NAME}:HIDDEN = yes.
  RUN wgw/wgwtagen.
  {&WINDOW-NAME}:HIDDEN = no.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_matpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_matpol C-Win
ON CHOOSE OF bu_matpol IN FRAME DEFAULT-FRAME /* Match File Text To Policy (Thanachat) */
DO:
    {&WINDOW-NAME}:HIDDEN = yes.
  RUN wgw/wgwtnce3.
  {&WINDOW-NAME}:HIDDEN = no.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_tran
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_tran C-Win
ON CHOOSE OF bu_tran IN FRAME DEFAULT-FRAME /* 1.Translation File Thanachat */
DO:
  {&WINDOW-NAME}:HIDDEN = yes.
  RUN wgw/wgwtaimp.
  {&WINDOW-NAME}:HIDDEN = no.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_tran-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_tran-2 C-Win
ON CHOOSE OF bu_tran-2 IN FRAME DEFAULT-FRAME /* Import File HOLD Data Thanachat ( Renew ) */
DO:
  {&WINDOW-NAME}:HIDDEN = yes.
  RUN wgw/wgwimtnc.
  {&WINDOW-NAME}:HIDDEN = no.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_tran-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_tran-3 C-Win
ON CHOOSE OF bu_tran-3 IN FRAME DEFAULT-FRAME /* Query / Update Data HOLD */
DO:
  {&WINDOW-NAME}:HIDDEN = yes.
  RUN wgw/wgwqtnc0.
  {&WINDOW-NAME}:HIDDEN = no.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_tran-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_tran-5 C-Win
ON CHOOSE OF bu_tran-5 IN FRAME DEFAULT-FRAME /* Match File Confirm / Cancel / No Confirm */
DO:
  {&WINDOW-NAME}:HIDDEN = yes.
  RUN wgw/wgwtnce2.
  {&WINDOW-NAME}:HIDDEN = no.
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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "WGWTAMEN".
  IF gv_prgid  = "WGWTAMEN" THEN gv_prog  = "Menu Load Excel For Thanachat".
  ELSE gv_prog  = "Menu Load Excel For Thanachat".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
  RUN  WUT\WUTWICEN (c-win:HANDLE).
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
  ENABLE RECT-534 RECT-535 RECT-536 RECT-537 RECT-538 RECT-539 RECT-540 
         RECT-541 RECT-542 RECT-543 RECT-544 RECT-546 RECT-547 bu_tran 
         bu_tran-2 bu_load bu_tran-3 bu_Export bu_tran-5 bu_Campaign bu_matpol 
         bu_exit 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

