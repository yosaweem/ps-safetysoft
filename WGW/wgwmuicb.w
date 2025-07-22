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
  program id   : wgwmutil.w   [IMPORT && EXPORT TEXT FILE ºÃÔÉÑ·µÃÕà¾ªÃÍÕ«Ù«Ø TAS,TIL,NON-TIL,TPIB,TPIS] 
  Create  by   : kridtiya i.  [A57-0260]  date. 16/07/2014 
  Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW ,STAT 
  modify by    : ranu i.   A57-0242  add program camapign
  modify by    : Kridtiya i. A57-0417 date. 17/11/2014 add program Export Text file Endorsement 
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
&Scoped-Define ENABLED-OBJECTS BUTTON-1 bu_exit bu_kk-73 bu_kk-74 bu_kk-75 ~
bu_kk-76 bu_kk-77 bu_kk-81 RECT-349 RECT-360 RECT-367 RECT-361 RECT-362 ~
RECT-363 RECT-364 RECT-369 RECT-384 RECT-385 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-1 
     LABEL "4.MATCH FILE CONFIRM / FILE LOAD ICBC" 
     SIZE 45 BY 1.14
     FGCOLOR 0 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 7.67 BY 1.1
     FONT 6.

DEFINE BUTTON bu_kk-73 
     LABEL "IMPORT TEXT FILE ICBC [OLD]" 
     SIZE 44 BY 1.24
     FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_kk-74 
     LABEL "5.LOAD TEXT FILE ICBC [ NEW/RENEW ]" 
     SIZE 44 BY 1.24
     FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_kk-75 
     LABEL "3.QUERY AND UPDATE DATA HOLD" 
     SIZE 45.33 BY 1.24
     FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_kk-76 
     LABEL "2.IMPORT FILE HOLD ICBC [NEW/RENEW]" 
     SIZE 45.33 BY 1.24
     FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_kk-77 
     LABEL "1.MATCH CAMPAIGN ( ËÂÍ´àºÕéÂ )" 
     SIZE 44 BY 1.24
     FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_kk-81 
     LABEL "6.MATCH DATA SEND ICBCTL" 
     SIZE 44 BY 1.24
     FGCOLOR 4 FONT 6.

DEFINE RECTANGLE RECT-349
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 110 BY 2
     BGCOLOR 10 FGCOLOR 4 .

DEFINE RECTANGLE RECT-360
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 50 BY 2.19
     BGCOLOR 21 FGCOLOR 5 .

DEFINE RECTANGLE RECT-361
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 50 BY 2.19
     BGCOLOR 29 FGCOLOR 5 .

DEFINE RECTANGLE RECT-362
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 50 BY 2.19
     BGCOLOR 29 FGCOLOR 5 .

DEFINE RECTANGLE RECT-363
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 50 BY 2.19
     BGCOLOR 29 FGCOLOR 5 .

DEFINE RECTANGLE RECT-364
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 50 BY 2.19
     BGCOLOR 29 FGCOLOR 10 .

DEFINE RECTANGLE RECT-367
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.17 BY 2.05
     BGCOLOR 12 .

DEFINE RECTANGLE RECT-369
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 50 BY 2.19
     BGCOLOR 29 FGCOLOR 5 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 108.5 BY 11.67
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 49.5 BY 2.19
     BGCOLOR 29 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     BUTTON-1 AT ROW 7.24 COL 61.33 
     bu_exit AT ROW 16.71 COL 96.5
     bu_kk-73 AT ROW 4.71 COL 31.33
     bu_kk-74 AT ROW 9.91 COL 61.67
     bu_kk-75 AT ROW 12.43 COL 5.17
     bu_kk-76 AT ROW 9.81 COL 5.17
     bu_kk-77 AT ROW 7.19 COL 6
     bu_kk-81 AT ROW 12.38 COL 61.67
     "IMPORT TEXT FILE ICBCTL" VIEW-AS TEXT
          SIZE 32 BY 1 AT ROW 1.48 COL 44.5
          BGCOLOR 10 FGCOLOR 2 FONT 6
     " MENU LOAD TEXT ICBC" VIEW-AS TEXT
          SIZE 25.5 BY .62 AT ROW 3.33 COL 41 
          FGCOLOR 7 FONT 6
     RECT-349 AT ROW 1 COL 1
     RECT-360 AT ROW 4.19 COL 28.5
     RECT-367 AT ROW 16.24 COL 94
     RECT-361 AT ROW 9.33 COL 3.33
     RECT-362 AT ROW 9.38 COL 59.5
     RECT-363 AT ROW 11.91 COL 3.5
     RECT-364 AT ROW 6.71 COL 3.33
     RECT-369 AT ROW 11.91 COL 59.5
     RECT-384 AT ROW 3.62 COL 2 
     RECT-385 AT ROW 6.71 COL 59.5 
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 110.33 BY 17.62
         BGCOLOR 18 .


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
         TITLE              = "Import Text File(ICBCTL)"
         HEIGHT             = 17.62
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
       bu_kk-73:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-74:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-75:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-76:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-77:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-81:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import Text File(ICBCTL) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import Text File(ICBCTL) */
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
ON CHOOSE OF BUTTON-1 IN FRAME DEFAULT-FRAME /* 4.MATCH FILE CONFIRM / FILE LOAD ICBC */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwicbe2.   
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


&Scoped-define SELF-NAME bu_kk-73
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-73 C-Win
ON CHOOSE OF bu_kk-73 IN FRAME DEFAULT-FRAME /* IMPORT TEXT FILE ICBC [OLD] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwticbc.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-74
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-74 C-Win
ON CHOOSE OF bu_kk-74 IN FRAME DEFAULT-FRAME /* 5.LOAD TEXT FILE ICBC [ NEW/RENEW ] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwlicbc.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-75
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-75 C-Win
ON CHOOSE OF bu_kk-75 IN FRAME DEFAULT-FRAME /* 3.QUERY AND UPDATE DATA HOLD */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwqicb0.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-76
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-76 C-Win
ON CHOOSE OF bu_kk-76 IN FRAME DEFAULT-FRAME /* 2.IMPORT FILE HOLD ICBC [NEW/RENEW] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwimicb.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-77
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-77 C-Win
ON CHOOSE OF bu_kk-77 IN FRAME DEFAULT-FRAME /* 1.MATCH CAMPAIGN ( ËÂÍ´àºÕéÂ ) */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwicbpr.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-81
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-81 C-Win
ON CHOOSE OF bu_kk-81 IN FRAME DEFAULT-FRAME /* 6.MATCH DATA SEND ICBCTL */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwmatic.   
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
  
  gv_prgid = "wgwmuicb.w".
  gv_prog  = "Import Text File(µÃÕà¾ªÃÍÕ«Ù«Ø)".
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
  ENABLE BUTTON-1 bu_exit bu_kk-73 bu_kk-74 bu_kk-75 bu_kk-76 bu_kk-77 bu_kk-81 
         RECT-349 RECT-360 RECT-367 RECT-361 RECT-362 RECT-363 RECT-364 
         RECT-369 RECT-384 RECT-385 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

