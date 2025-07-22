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
  
/*++++++++++++++++++++++++++++++++++++++++++++++
  WGWMUTGB.W   : Menu form Tesco Lotus   
  Create  by   : kridtiya i.  [A60-0495]   On   11/12/2017
  Connect      : not connect
+++++++++++++++++++++++++++++++++++++++++++++++**************************/
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
DEF  shared  Var   n_User     As    Char.
DEF  Shared  Var   n_PassWd   As    Char.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-349 RECT-396 bu_load1 bu_tran bu_tran-3 ~
bu_imppdf bu_tran-4 bu_tran-2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_imppdf 
     LABEL "4.Queue Copy file pdf to Directory" 
     SIZE 45 BY 1.52
     BGCOLOR 3 FGCOLOR 3 FONT 6.

DEFINE BUTTON bu_load1 
     LABEL "1.LOAD TEXT TESCO LOTUS" 
     SIZE 45 BY 1.52
     BGCOLOR 3 FGCOLOR 3 FONT 6.

DEFINE BUTTON bu_tran 
     LABEL "2.TRANSFER GW TO PREMIUM(CMI) พรบ." 
     SIZE 45 BY 1.52
     BGCOLOR 3 FGCOLOR 3 FONT 6.

DEFINE BUTTON bu_tran-2 
     LABEL "EXIT" 
     SIZE 45 BY 1.52
     BGCOLOR 3 FGCOLOR 3 FONT 6.

DEFINE BUTTON bu_tran-3 
     LABEL "3.TRANSFER GW TO PREMIUM (VMI) ประเภท" 
     SIZE 45 BY 1.52
     BGCOLOR 3 FGCOLOR 3 FONT 6.

DEFINE BUTTON bu_tran-4 
     LABEL "" 
     SIZE 45 BY 1.52
     BGCOLOR 3 FGCOLOR 3 FONT 6.

DEFINE RECTANGLE RECT-349
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 50 BY 2
     BGCOLOR 2 FGCOLOR 2 .

DEFINE RECTANGLE RECT-395
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 50 BY 12.48
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-396
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 47 BY 2.38
     BGCOLOR 6 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bu_load1 AT ROW 3.52 COL 3 WIDGET-ID 6
     bu_tran AT ROW 5.19 COL 3 WIDGET-ID 10
     bu_tran-3 AT ROW 6.91 COL 3 WIDGET-ID 20
     bu_imppdf AT ROW 8.62 COL 3 WIDGET-ID 16
     bu_tran-4 AT ROW 10.33 COL 3 WIDGET-ID 18
     bu_tran-2 AT ROW 12.48 COL 3 WIDGET-ID 12
     "            IMPORT FILE NEW TESCO LOTUS" VIEW-AS TEXT
          SIZE 48 BY 1.24 AT ROW 1.43 COL 2.5
          BGCOLOR 18 FGCOLOR 7 FONT 6
     RECT-349 AT ROW 1 COL 1.5
     RECT-395 AT ROW 3.05 COL 1.5 WIDGET-ID 2
     RECT-396 AT ROW 12.05 COL 2 WIDGET-ID 14
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 52 BY 14.91
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
         TITLE              = "[WGWMUTGB.W] MENU IMPORT AND EXPORT TESCO LOTUS"
         HEIGHT             = 14.86
         WIDTH              = 51.5
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
   FRAME-NAME                                                           */
/* SETTINGS FOR RECTANGLE RECT-395 IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* [WGWMUTGB.W] MENU IMPORT AND EXPORT TESCO LOTUS */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* [WGWMUTGB.W] MENU IMPORT AND EXPORT TESCO LOTUS */
DO:
  /* This event will close the window and terminate the procedure.  */
  
  /*
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
  */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imppdf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imppdf C-Win
ON CHOOSE OF bu_imppdf IN FRAME DEFAULT-FRAME /* 4.Queue Copy file pdf to Directory */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwlgin2.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_load1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_load1 C-Win
ON CHOOSE OF bu_load1 IN FRAME DEFAULT-FRAME /* 1.LOAD TEXT TESCO LOTUS */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwtltgb.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_tran
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_tran C-Win
ON CHOOSE OF bu_tran IN FRAME DEFAULT-FRAME /* 2.TRANSFER GW TO PREMIUM(CMI) พรบ. */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    /*Run  wgw\wgwtrtgb.   */
    Run  wgw\wgwtrn70.  
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_tran-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_tran-2 C-Win
ON CHOOSE OF bu_tran-2 IN FRAME DEFAULT-FRAME /* EXIT */
DO:
    Apply "Close" To This-procedure.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_tran-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_tran-3 C-Win
ON CHOOSE OF bu_tran-3 IN FRAME DEFAULT-FRAME /* 3.TRANSFER GW TO PREMIUM (VMI) ประเภท */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    /*Run  wgw\wgwtrtgb.   */
    Run  wgw\wgwtim70.  
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_tran-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_tran-4 C-Win
ON CHOOSE OF bu_tran-4 IN FRAME DEFAULT-FRAME
DO:
    /*
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\ .   
    {&WINDOW-NAME} :Hidden = No.*/
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
  
  gv_prgid = "WGWMUTGB".
  gv_prog  = "MENU IMPORT FILE TESCO LOTUS".
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
  ENABLE RECT-349 RECT-396 bu_load1 bu_tran bu_tran-3 bu_imppdf bu_tran-4 
         bu_tran-2 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

