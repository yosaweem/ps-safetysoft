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
  Modify By    : Ranu I. A63-0221 date : 18/05/2020 à¾ÔèÁàÁ¹Ù Extract File 
  Modify by    : Ranu I. A66-0252 à¾ÔèÁàÁ¹Ù Hold data ,Query and Update
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
&Scoped-Define ENABLED-OBJECTS bu-cv bu_exit bu_kk-77 bu_kk-78 bu_kk-80 ~
bu_kk-83 bu_kk-84 bu_kk-79 bu_kk-81 bu_kk-82 RECT-349 RECT-367 RECT-385 ~
RECT-390 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu-cv 
     LABEL "LOAD TPIS NEW (CV)" 
     SIZE 35 BY 1.52
     BGCOLOR 14 FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 7.67 BY 1.1
     BGCOLOR 7 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_kk-77 
     LABEL "OUREY AND UPDATE [STICKER- TIL]" 
     SIZE 40 BY 1.52
     BGCOLOR 2 FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_kk-78 
     LABEL "CAMPAIGN TPIS" 
     SIZE 40 BY 1.52
     BGCOLOR 2 FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_kk-79 
     LABEL "EXTRACT FILE EMPIRE AND ORAKAN" 
     SIZE 40 BY 1.52
     BGCOLOR 2 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_kk-80 
     LABEL "EXPORT FILE ENDORSEMENT" 
     SIZE 35 BY 1.52
     BGCOLOR 5 FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_kk-81 
     LABEL "IMPORT FILE HOLD" 
     SIZE 35 BY 1.52
     BGCOLOR 7 FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_kk-82 
     LABEL "QUERY && UPDATE DATA HOLD" 
     SIZE 35 BY 1.52
     BGCOLOR 13 FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_kk-83 
     LABEL "LOAD TPIS NEW (LCV)" 
     SIZE 35 BY 1.52
     BGCOLOR 2 FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_kk-84 
     LABEL "LOAD TPIS RENEW / TRANFER" 
     SIZE 35 BY 1.52
     BGCOLOR 4 FGCOLOR 4 FONT 6.

DEFINE RECTANGLE RECT-349
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 90.5 BY 19.05
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-367
     EDGE-PIXELS 1 GRAPHIC-EDGE    ROUNDED 
     SIZE 12.83 BY 1.91
     BGCOLOR 12 FGCOLOR 2 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 43 BY 12.62
     BGCOLOR 29 FGCOLOR 2 .

DEFINE RECTANGLE RECT-390
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 43.5 BY 12.57
     BGCOLOR 29 FGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bu-cv AT ROW 10.38 COL 5.33
     bu_exit AT ROW 17.62 COL 76.17
     bu_kk-77 AT ROW 5.14 COL 48.17
     bu_kk-78 AT ROW 6.95 COL 48.17
     bu_kk-80 AT ROW 14.05 COL 5.5
     bu_kk-83 AT ROW 8.67 COL 5.5
     bu_kk-84 AT ROW 12.14 COL 5.33
     bu_kk-79 AT ROW 8.76 COL 48.17 WIDGET-ID 18
     bu_kk-81 AT ROW 5.1 COL 5.5 WIDGET-ID 22
     bu_kk-82 AT ROW 6.86 COL 5.33 WIDGET-ID 24
     "                             IMPORT TEXT FILE TPIS (µÃÕà¾ªÃÍÕ«Ù«Ø)" VIEW-AS TEXT
          SIZE 89 BY 1.67 AT ROW 1.14 COL 1.5
          BGCOLOR 3 FGCOLOR 7 FONT 23
     "  MENU PARAMERTER" VIEW-AS TEXT
          SIZE 24.17 BY 1 AT ROW 3.43 COL 57.33 WIDGET-ID 2
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  MENU LOAD FILE" VIEW-AS TEXT
          SIZE 19.33 BY 1 AT ROW 3.38 COL 12.17 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 2 FONT 6
     RECT-349 AT ROW 1 COL 1
     RECT-367 AT ROW 17.19 COL 73.5
     RECT-385 AT ROW 3.62 COL 2.5
     RECT-390 AT ROW 3.67 COL 46.5 WIDGET-ID 12
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 90.83 BY 19.29
         BGCOLOR 8 .


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
         TITLE              = "Import Text File(µÃÕà¾ªÃÍÕ«Ù«Ø)"
         HEIGHT             = 19.29
         WIDTH              = 90.83
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
       bu_kk-77:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-78:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-79:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-80:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-81:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-82:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-83:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_kk-84:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import Text File(µÃÕà¾ªÃÍÕ«Ù«Ø) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import Text File(µÃÕà¾ªÃÍÕ«Ù«Ø) */
DO:
  /* This event will close the window and terminate the procedure.  */
  
  /*
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
  */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu-cv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu-cv C-Win
ON CHOOSE OF bu-cv IN FRAME DEFAULT-FRAME /* LOAD TPIS NEW (CV) */
DO:
     {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwncvtp.   
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


&Scoped-define SELF-NAME bu_kk-77
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-77 C-Win
ON CHOOSE OF bu_kk-77 IN FRAME DEFAULT-FRAME /* OUREY AND UPDATE [STICKER- TIL] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwqutp1.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-78
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-78 C-Win
ON CHOOSE OF bu_kk-78 IN FRAME DEFAULT-FRAME /* CAMPAIGN TPIS */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwctpis.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-79
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-79 C-Win
ON CHOOSE OF bu_kk-79 IN FRAME DEFAULT-FRAME /* EXTRACT FILE EMPIRE AND ORAKAN */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwtpfile.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-80
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-80 C-Win
ON CHOOSE OF bu_kk-80 IN FRAME DEFAULT-FRAME /* EXPORT FILE ENDORSEMENT */
DO:
     {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwtpien.   
    {&WINDOW-NAME} :Hidden = No. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-81
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-81 C-Win
ON CHOOSE OF bu_kk-81 IN FRAME DEFAULT-FRAME /* IMPORT FILE HOLD */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwimtpis.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-82
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-82 C-Win
ON CHOOSE OF bu_kk-82 IN FRAME DEFAULT-FRAME /* QUERY  UPDATE DATA HOLD */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwqtpis0.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-83
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-83 C-Win
ON CHOOSE OF bu_kk-83 IN FRAME DEFAULT-FRAME /* LOAD TPIS NEW (LCV) */
DO:
     {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwntpis.   
    {&WINDOW-NAME} :Hidden = No. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-84
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-84 C-Win
ON CHOOSE OF bu_kk-84 IN FRAME DEFAULT-FRAME /* LOAD TPIS RENEW / TRANFER */
DO:
     {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwrtpis.   
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
  
  gv_prgid = "wgwmutil.w".
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
  ENABLE bu-cv bu_exit bu_kk-77 bu_kk-78 bu_kk-80 bu_kk-83 bu_kk-84 bu_kk-79 
         bu_kk-81 bu_kk-82 RECT-349 RECT-367 RECT-385 RECT-390 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

