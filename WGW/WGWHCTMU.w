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
  WGWHCTMU.w   :  Menu Honda
  Create  by   :  Kridtiya i. A61-0481 เพิ่มโปรแกรม เมนูเก็บส่วนการทำงาน Load Honda 
  Connect      : -
  modify by    : Kridtiya i. Date 18/04/2021 A64-0185 เพิ่มเมนู การแปลงไฟล์แยกสาขา
  modify by    : kridtiya i. Date.26/11/2021 A64-414  เพิ่มเมนู Import file

+++++++++++++++++++++++++++++++++++++++++++++++*/ 
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
&Scoped-Define ENABLED-OBJECTS RECT-349 RECT-380 RECT-381 RECT-383 RECT-384 ~
RECT-387 RECT-390 RECT-395 RECT-481 RECT-385 RECT-382 RECT-386 RECT-482 ~
RECT-483 RECT-484 bu_excel bu_excel-2 bu_import-2 bu_import-5 bu_import ~
bu_import-3 bu_import-4 button3 bu_exit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON button3 
     LABEL "8.Company Code and Dealer Code" 
     SIZE 40 BY 1.14
     FONT 6.

DEFINE BUTTON bu_excel 
     LABEL "1.  Export Text File HCT To Excel" 
     SIZE 40 BY 1.24
     FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_excel-2 
     LABEL "5.  Import Text File HCT Save IN STORE" 
     SIZE 40 BY 1.24
     FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10.5 BY 1.52
     FONT 6.

DEFINE BUTTON bu_import 
     LABEL "3.Export Text File HCT [Cancel]" 
     SIZE 40 BY 1.24
     BGCOLOR 8 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_import-2 
     LABEL "2. Export Text File HCT [Endores]" 
     SIZE 40 BY 1.24
     FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_import-3 
     LABEL "4.Export Text File HCT To TEXT[DM-BR]" 
     SIZE 40 BY 1.24
     BGCOLOR 8 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_import-4 
     LABEL "7.Load Text file Motor [HCT]" 
     SIZE 40 BY 1.24
     BGCOLOR 8 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_import-5 
     LABEL "6. Query && Update [HCT]" 
     SIZE 40 BY 1.24
     FGCOLOR 7 FONT 6.

DEFINE RECTANGLE RECT-349
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 87 BY 18.57
     BGCOLOR 8 FGCOLOR 2 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 42 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 42 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 42 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 42 BY 2
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 42 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 42 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 42 BY 2
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15 BY 2.52
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-390
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 42 BY 2
     BGCOLOR 31 .

DEFINE RECTANGLE RECT-395
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 82.5 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-481
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 18 BY 1.19.

DEFINE RECTANGLE RECT-482
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 23 BY 1.19.

DEFINE RECTANGLE RECT-483
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 15 BY 1.19.

DEFINE RECTANGLE RECT-484
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 15 BY 1.19.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bu_excel AT ROW 5 COL 3.5
     bu_excel-2 AT ROW 5 COL 46.5 WIDGET-ID 24
     bu_import-2 AT ROW 7.19 COL 3.5
     bu_import-5 AT ROW 7.19 COL 46.5 WIDGET-ID 26
     bu_import AT ROW 9.1 COL 3.5
     bu_import-3 AT ROW 11.33 COL 3.5 WIDGET-ID 18
     bu_import-4 AT ROW 11.38 COL 46.5
     button3 AT ROW 14.81 COL 46.5
     bu_exit AT ROW 17.24 COL 73.5
     "SETUP DEALER" VIEW-AS TEXT
          SIZE 16 BY .81 AT ROW 13.24 COL 46 WIDGET-ID 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "LOAD DATA TO GW" VIEW-AS TEXT
          SIZE 20 BY .81 AT ROW 9.86 COL 46.67 WIDGET-ID 8
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "       IMPORT AND EXPORT HONDA" VIEW-AS TEXT
          SIZE 80 BY 1.52 AT ROW 1.43 COL 3
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Export Text" VIEW-AS TEXT
          SIZE 13 BY .81 AT ROW 3.52 COL 3.83 WIDGET-ID 32
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Import Text" VIEW-AS TEXT
          SIZE 13 BY .81 AT ROW 3.57 COL 46.17 WIDGET-ID 38
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-349 AT ROW 1 COL 1.33
     RECT-380 AT ROW 4.62 COL 2.5
     RECT-381 AT ROW 6.67 COL 2.5
     RECT-383 AT ROW 10.95 COL 45
     RECT-384 AT ROW 8.71 COL 2.5
     RECT-387 AT ROW 16.71 COL 71
     RECT-390 AT ROW 14.33 COL 45
     RECT-395 AT ROW 1.24 COL 2 WIDGET-ID 12
     RECT-481 AT ROW 13 COL 45 WIDGET-ID 16
     RECT-385 AT ROW 10.95 COL 2.5 WIDGET-ID 20
     RECT-382 AT ROW 4.62 COL 45 WIDGET-ID 22
     RECT-386 AT ROW 6.67 COL 45 WIDGET-ID 28
     RECT-482 AT ROW 9.62 COL 45 WIDGET-ID 30
     RECT-483 AT ROW 3.33 COL 2.5 WIDGET-ID 34
     RECT-484 AT ROW 3.38 COL 45 WIDGET-ID 36
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 88 BY 18.9
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
         TITLE              = "MENU IMPORT AND EXPORT HONDA"
         HEIGHT             = 18.81
         WIDTH              = 87.83
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

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* MENU IMPORT AND EXPORT HONDA */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* MENU IMPORT AND EXPORT HONDA */
DO:
  /* This event will close the window and terminate the procedure.  */
  
  /*
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
  */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME button3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL button3 C-Win
ON CHOOSE OF button3 IN FRAME DEFAULT-FRAME /* 8.Company Code and Dealer Code */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
   Run  wgw\wgwcodel.   
   {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_excel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_excel C-Win
ON CHOOSE OF bu_excel IN FRAME DEFAULT-FRAME /* 1.  Export Text File HCT To Excel */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wuw\wuwhctex.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_excel-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_excel-2 C-Win
ON CHOOSE OF bu_excel-2 IN FRAME DEFAULT-FRAME /* 5.  Import Text File HCT Save IN STORE */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwimhct.   
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
ON CHOOSE OF bu_import IN FRAME DEFAULT-FRAME /* 3.Export Text File HCT [Cancel] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wuw\wuwhctca.   
    {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import-2 C-Win
ON CHOOSE OF bu_import-2 IN FRAME DEFAULT-FRAME /* 2. Export Text File HCT [Endores] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wuw\wuwhc2ex.   
    {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import-3 C-Win
ON CHOOSE OF bu_import-3 IN FRAME DEFAULT-FRAME /* 4.Export Text File HCT To TEXT[DM-BR] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wuw\WUWHCTEX2.   
    {&WINDOW-NAME} :Hidden = No.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import-4 C-Win
ON CHOOSE OF bu_import-4 IN FRAME DEFAULT-FRAME /* 7.Load Text file Motor [HCT] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwhcgen. 
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import-5 C-Win
ON CHOOSE OF bu_import-5 IN FRAME DEFAULT-FRAME /* 6. Query  Update [HCT] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwqhct0.   
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
  
  gv_prgid = "wgwhctmu".
  gv_prog  = "MENU HONDA".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  RECT-380:Move-to-top().
  RECT-381:Move-to-top().
  
  RECT-383:Move-to-top().
  RECT-384:Move-to-top().
     
  RECT-387:Move-to-top().
  

  RECT-390:Move-to-top().
  
  
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
  ENABLE RECT-349 RECT-380 RECT-381 RECT-383 RECT-384 RECT-387 RECT-390 
         RECT-395 RECT-481 RECT-385 RECT-382 RECT-386 RECT-482 RECT-483 
         RECT-484 bu_excel bu_excel-2 bu_import-2 bu_import-5 bu_import 
         bu_import-3 bu_import-4 button3 bu_exit 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

