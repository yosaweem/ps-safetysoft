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
  program id   : wgwkkmu1.w   [Import Text File KK[ธนาคารเกียรตินาคิน] 
  Create  by   :  kridtiya i.  [A54-0351]  date. 14/11/2011  
  Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW ,STAT 
+++++++++++++++++++++++++++++++++++++++++++++++*/
/*Modify by : Kridtiya i. A55-0055 date. 13/02/2012 เพิ่มส่วนการทำงานโหลดพักข้อมูลแจ้งประกันงานป้ายแดง    */
/*Modify by : Kridtiya i. A56-0231 date. 17/07/2013 เพิ่มส่วนการทำงานแปลงไฟล์แจ้งงาน พรบ.และให้เลขกรมธรรม์*/
/*Modify By : Ranu I. A61-0335 Date. 10/07/2018 เพิ่มเมนู match policy 72 และ Check document */
/*Modiby by : Ranu i. A63-0230 date . 20/05/2020 เพิ่มเมนู Report Issue Policy   */

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
&Scoped-Define ENABLED-OBJECTS bu_exit bu_imprenew bu_update70 bu_updatere ~
bu_load70 bu_re-2 bu_gennew bu_kk-74 RECT-329 RECT-342 RECT-349 RECT-348 ~
RECT-330 RECT-355 RECT-363 RECT-364 RECT-367 RECT-387 RECT-369 RECT-362 ~
RECT-365 bu_gen70re bu_matchre RECT-366 

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

DEFINE BUTTON bu_gen70re 
     LABEL "Load Text File KK [ต่ออายุ]" 
     SIZE 29 BY 1.24
     FONT 6.

DEFINE BUTTON bu_gennew 
     LABEL "Load Text File KK New Form" 
     SIZE 29 BY 1.24
     FONT 6.

DEFINE BUTTON bu_imprenew 
     LABEL "Hold Text File KK" 
     SIZE 29 BY 1.24
     FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_kk-74 
     LABEL "Check Postdocument" 
     SIZE 28 BY 1.14
     FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_load70 
     LABEL "Load Text File KK[ ป้ายแดง ]" 
     SIZE 29 BY 1.24
     BGCOLOR 8 FGCOLOR 12 FONT 6.

DEFINE BUTTON bu_matchre 
     LABEL "Match File Policy No" 
     SIZE 29 BY 1.24
     FONT 6.

DEFINE BUTTON bu_re-2 
     LABEL "Report Issue Policy" 
     SIZE 28 BY 1.14
     FONT 6.

DEFINE BUTTON bu_update70 
     LABEL "Query && Update ป้ายแดง" 
     SIZE 29 BY 1.24
     FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_updatere 
     LABEL "Query && Update" 
     SIZE 29 BY 1.24
     FGCOLOR 1 FONT 6.

DEFINE RECTANGLE RECT-329
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 35.5 BY 7.1
     BGCOLOR 8 FGCOLOR 15 .

DEFINE RECTANGLE RECT-330
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 35.5 BY 7.1
     BGCOLOR 19 FGCOLOR 15 .

DEFINE RECTANGLE RECT-342
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 32 BY 1.62
     BGCOLOR 2 FGCOLOR 0 .

DEFINE RECTANGLE RECT-348
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 32 BY 1.62
     BGCOLOR 2 FGCOLOR 1 .

DEFINE RECTANGLE RECT-349
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 73 BY 1.43
     BGCOLOR 3 FGCOLOR 3 .

DEFINE RECTANGLE RECT-355
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 72.5 BY 5.67
     BGCOLOR 19 FGCOLOR 15 .

DEFINE RECTANGLE RECT-362
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 31 BY 1.67
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-363
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 31 BY 1.62
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-364
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 31 BY 1.62
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-365
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 32 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-366
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 31 BY 1.62
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-367
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.17 BY 1.57
     BGCOLOR 12 .

DEFINE RECTANGLE RECT-369
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 31 BY 1.62
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 30.5 BY 1.62
     BGCOLOR 5 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bu_exit AT ROW 15.76 COL 65.5
     bu_imprenew AT ROW 4.1 COL 41.83
     bu_update70 AT ROW 4.1 COL 5.33
     bu_updatere AT ROW 5.86 COL 41.83
     bu_load70 AT ROW 5.81 COL 5.5
     bu_re-2 AT ROW 12.67 COL 41.33 WIDGET-ID 32
     bu_gennew AT ROW 7.67 COL 42.17 WIDGET-ID 36
     bu_kk-74 AT ROW 11 COL 5.83 WIDGET-ID 46
     bu_gen70re AT ROW 7.57 COL 5.67 WIDGET-ID 50
     bu_matchre AT ROW 10.91 COL 41 WIDGET-ID 54
     "OLD FORMAT" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 2.81 COL 12.5
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "        IMPORT && EXPORT TEXT FILE KK" VIEW-AS TEXT
          SIZE 49.67 BY 1 AT ROW 1.24 COL 14.83
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "  REPORT KK" VIEW-AS TEXT
          SIZE 14.17 BY .81 AT ROW 9.86 COL 30 WIDGET-ID 22
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "  NEW FORMAT" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 2.76 COL 47.5
          BGCOLOR 19 FGCOLOR 6 FONT 6
     RECT-329 AT ROW 2.48 COL 2
     RECT-342 AT ROW 3.91 COL 4.17
     RECT-349 AT ROW 1 COL 1.5
     RECT-348 AT ROW 5.62 COL 4.17
     RECT-330 AT ROW 2.48 COL 39
     RECT-355 AT ROW 9.67 COL 2
     RECT-363 AT ROW 3.91 COL 41
     RECT-364 AT ROW 5.67 COL 40.83
     RECT-367 AT ROW 15.52 COL 64.83
     RECT-387 AT ROW 12.43 COL 40.33 WIDGET-ID 34
     RECT-369 AT ROW 7.48 COL 41.17 WIDGET-ID 38
     RECT-362 AT ROW 10.76 COL 4.5 WIDGET-ID 48
     RECT-365 AT ROW 7.38 COL 4 WIDGET-ID 52
     RECT-366 AT ROW 10.71 COL 40 WIDGET-ID 56
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.1
         SIZE 75.67 BY 16.38
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
         TITLE              = "Improt text file KK"
         HEIGHT             = 16.48
         WIDTH              = 75.67
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
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
       bu_matchre:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Improt text file KK */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Improt text file KK */
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


&Scoped-define SELF-NAME bu_gen70re
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_gen70re C-Win
ON CHOOSE OF bu_gen70re IN FRAME DEFAULT-FRAME /* Load Text File KK [ต่ออายุ] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwkkren.   
  {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_gennew
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_gennew C-Win
ON CHOOSE OF bu_gennew IN FRAME DEFAULT-FRAME /* Load Text File KK New Form */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
   /*Run  wgw\wgwkkren.   */
    Run  wgw\wgwkkload. 
  {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imprenew
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imprenew C-Win
ON CHOOSE OF bu_imprenew IN FRAME DEFAULT-FRAME /* Hold Text File KK */
DO:
   {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwimkk1.   
   {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_kk-74
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_kk-74 C-Win
ON CHOOSE OF bu_kk-74 IN FRAME DEFAULT-FRAME /* Check Postdocument */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwkkdoc.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_load70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_load70 C-Win
ON CHOOSE OF bu_load70 IN FRAME DEFAULT-FRAME /* Load Text File KK[ ป้ายแดง ] */
DO:
   {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwkkgen.   
   {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_matchre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_matchre C-Win
ON CHOOSE OF bu_matchre IN FRAME DEFAULT-FRAME /* Match File Policy No */
DO:
     {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwmatkk.   
  {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_re-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_re-2 C-Win
ON CHOOSE OF bu_re-2 IN FRAME DEFAULT-FRAME /* Report Issue Policy */
DO:
   {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwkksen.   
   {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update70 C-Win
ON CHOOSE OF bu_update70 IN FRAME DEFAULT-FRAME /* Query  Update ป้ายแดง */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\WGWQUKK1.   
  {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_updatere
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_updatere C-Win
ON CHOOSE OF bu_updatere IN FRAME DEFAULT-FRAME /* Query  Update */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\WGWQUKK0.   
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
  
  gv_prgid = "wgwkkmu1".
  gv_prog  = "Import Text File(KK)".
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
  ENABLE bu_exit bu_imprenew bu_update70 bu_updatere bu_load70 bu_re-2 
         bu_gennew bu_kk-74 RECT-329 RECT-342 RECT-349 RECT-348 RECT-330 
         RECT-355 RECT-363 RECT-364 RECT-367 RECT-387 RECT-369 RECT-362 
         RECT-365 bu_gen70re bu_matchre RECT-366 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

