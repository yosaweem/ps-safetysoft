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
  wgwtismu.w   :  Import text file from  Tisco  to GW 
  Create  by   :  kridtiya i.  [A53-0207]   On   06/09/2010
  Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW ,STAT 
+++++++++++++++++++++++++++++++++++++++++++++++*/
/*Modity by : Kridtiya i. A58-0014  เพิ่มโปรแกรม เมนูเก็บส่วนการทำงาน Load Nissan*/
/*Modify by : Ranu I. A60-0139 Date:22/03/2017 เพิ่มโปรแกรมสำหรับงานต่ออายุ */
/*Modify by : Kridtiya i. A61-0482 Date. 08/10/2018 เพิ่ม โปรแกรม เรีกยรายงาน ประจำวัน */
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
&Scoped-Define ENABLED-OBJECTS RECT-349 RECT-380 RECT-381 RECT-382 RECT-383 ~
RECT-384 RECT-386 RECT-387 RECT-388 RECT-389 RECT-390 RECT-391 RECT-394 ~
RECT-392 bu_excel bu_import-5 bu_import-2 bu_query bu_import BUTTON-2 ~
bu_import-4 button3 bu_excel-2 bu_excel-4 bu_excel-3 bu_exit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-2 
     LABEL "Match File Confirm LOCKTON" 
     SIZE 38 BY 1.14
     FONT 6.

DEFINE BUTTON button3 
     LABEL "Load Text File Renew (LOCKTON)" 
     SIZE 38.5 BY 1.14
     FONT 6.

DEFINE BUTTON bu_excel 
     LABEL "1.  Load Text file NISSAN (Old)" 
     SIZE 39 BY 1.24
     FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_excel-2 
     LABEL "5.Transfer Lockton GWTo Premium" 
     SIZE 38 BY 1.24
     FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_excel-3 
     LABEL "   6.Set Package Model TISCO" 
     SIZE 38 BY 1.24
     FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_excel-4 
     LABEL "Report File and Export PDF" 
     SIZE 38 BY 1.24
     FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 38 BY 1.24
     FONT 6.

DEFINE BUTTON bu_import 
     LABEL "3.Load NISSAN ON WEB [พรบ.]" 
     SIZE 39 BY 1.24
     BGCOLOR 8 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_import-2 
     LABEL "2. Load NISSAN ON WEB SERVICES" 
     SIZE 39 BY 1.24
     FONT 6.

DEFINE BUTTON bu_import-4 
     LABEL "4.Queue Copy file pdf to Directory" 
     SIZE 39 BY 1.24
     BGCOLOR 8 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_import-5 
     LABEL "Import Data Notify to TLT" 
     SIZE 39 BY 1.24
     BGCOLOR 8 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_query 
     LABEL "Ouery and Update Data (TLT)" 
     SIZE 38.5 BY 1.14
     FONT 6.

DEFINE RECTANGLE RECT-349
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 93 BY 2
     BGCOLOR 4 FGCOLOR 2 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-388
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-389
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-390
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-391
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-392
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-394
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 93 BY 13.81
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bu_excel AT ROW 3.76 COL 5
     bu_import-5 AT ROW 3.76 COL 49
     bu_import-2 AT ROW 5.95 COL 5
     bu_query AT ROW 6 COL 49.17
     bu_import AT ROW 8.14 COL 5
     BUTTON-2 AT ROW 8.19 COL 49.5
     bu_import-4 AT ROW 10.38 COL 5
     button3 AT ROW 10.48 COL 49
     bu_excel-2 AT ROW 12.62 COL 5.33
     bu_excel-4 AT ROW 12.62 COL 49 WIDGET-ID 6
     bu_excel-3 AT ROW 14.76 COL 5.33 WIDGET-ID 2
     bu_exit AT ROW 14.81 COL 49.5
     "                                             IMPORT FILE NEW NISSAN" VIEW-AS TEXT
          SIZE 90 BY 1.24 AT ROW 1.43 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     RECT-349 AT ROW 1 COL 1
     RECT-380 AT ROW 3.38 COL 3
     RECT-381 AT ROW 5.57 COL 3
     RECT-382 AT ROW 7.76 COL 3
     RECT-383 AT ROW 10 COL 3
     RECT-384 AT ROW 3.38 COL 47
     RECT-386 AT ROW 12.24 COL 2.83
     RECT-387 AT ROW 14.43 COL 47
     RECT-388 AT ROW 5.57 COL 47
     RECT-389 AT ROW 7.76 COL 47
     RECT-390 AT ROW 10 COL 47
     RECT-391 AT ROW 12.19 COL 47
     RECT-394 AT ROW 3.14 COL 1
     RECT-392 AT ROW 14.38 COL 2.83 WIDGET-ID 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 93.67 BY 16.29
         BGCOLOR 3 
         DEFAULT-BUTTON bu_excel.


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
         TITLE              = "MENU IMPORT AND EXPORT TISCO"
         HEIGHT             = 16.14
         WIDTH              = 93.5
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
ASSIGN 
       bu_excel:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_excel-2:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_excel-3:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       bu_excel-4:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* MENU IMPORT AND EXPORT TISCO */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* MENU IMPORT AND EXPORT TISCO */
DO:
  /* This event will close the window and terminate the procedure.  */
  
  /*
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
  */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-2 C-Win
ON CHOOSE OF BUTTON-2 IN FRAME DEFAULT-FRAME /* Match File Confirm LOCKTON */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwloccf.   
   {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME button3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL button3 C-Win
ON CHOOSE OF button3 IN FRAME DEFAULT-FRAME /* Load Text File Renew (LOCKTON) */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwnsren.   
   {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_excel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_excel C-Win
ON CHOOSE OF bu_excel IN FRAME DEFAULT-FRAME /* 1.  Load Text file NISSAN (Old) */
DO:
     {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwnsgen.   
  {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_excel-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_excel-2 C-Win
ON CHOOSE OF bu_excel-2 IN FRAME DEFAULT-FRAME /* 5.Transfer Lockton GWTo Premium */
DO:
     {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwtrnlt.    
  {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_excel-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_excel-3 C-Win
ON CHOOSE OF bu_excel-3 IN FRAME DEFAULT-FRAME /*    6.Set Package Model TISCO */
DO:
     {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwnismo.   
  {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_excel-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_excel-4 C-Win
ON CHOOSE OF bu_excel-4 IN FRAME DEFAULT-FRAME /* Report File and Export PDF */
DO:
     {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwlgint2.   
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


&Scoped-define SELF-NAME bu_import
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import C-Win
ON CHOOSE OF bu_import IN FRAME DEFAULT-FRAME /* 3.Load NISSAN ON WEB [พรบ.] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwnsge2.   
    {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import-2 C-Win
ON CHOOSE OF bu_import-2 IN FRAME DEFAULT-FRAME /* 2. Load NISSAN ON WEB SERVICES */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwnsge1.   
    {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import-4 C-Win
ON CHOOSE OF bu_import-4 IN FRAME DEFAULT-FRAME /* 4.Queue Copy file pdf to Directory */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwlgint. 
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import-5 C-Win
ON CHOOSE OF bu_import-5 IN FRAME DEFAULT-FRAME /* Import Data Notify to TLT */
DO:
   {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwloctn.   
   {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_query
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_query C-Win
ON CHOOSE OF bu_query IN FRAME DEFAULT-FRAME /* Ouery and Update Data (TLT) */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwqlock.   
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
  
  gv_prgid = "wgwnismu".
  gv_prog  = "MENU IMPORT FILE NISSAN".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  RECT-380:Move-to-top().
  RECT-381:Move-to-top().
  RECT-382:Move-to-top().
  RECT-383:Move-to-top().
  RECT-384:Move-to-top().
  RECT-386:Move-to-top().
  RECT-387:Move-to-top().
  RECT-388:Move-to-top().
  RECT-389:Move-to-top().
  RECT-390:Move-to-top().
  RECT-391:Move-to-top().
  
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
  ENABLE RECT-349 RECT-380 RECT-381 RECT-382 RECT-383 RECT-384 RECT-386 
         RECT-387 RECT-388 RECT-389 RECT-390 RECT-391 RECT-394 RECT-392 
         bu_excel bu_import-5 bu_import-2 bu_query bu_import BUTTON-2 
         bu_import-4 button3 bu_excel-2 bu_excel-4 bu_excel-3 bu_exit 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

