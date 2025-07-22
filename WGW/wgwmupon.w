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
  program id   : wgwmupon.w   [Import data By Telephone .....] 
  Create  by   :  kridtiya i.  [A55-0015]  date. 10/01/2012
  Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW ,STAT 
+++++++++++++++++++++++++++++++++++++++++++++++*/
/*modify by    : Kridtiya i. A55-0257 date. 30/08/2012 เพิ่มโปรแกรมให้ค่าเลขรับแจ้ง */
/*Modify by    : Ranu I. A62-0219 date.08/05/2019 เพิ่มเมนู Parameter company code */

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
&Scoped-Define ENABLED-OBJECTS RECT-329 RECT-342 RECT-343 RECT-344 RECT-346 ~
RECT-347 RECT-348 RECT-330 RECT-350 RECT-351 RECT-352 bu_import bu_mat-2 ~
bu_update bu_mat-3 bu_mat-4 bu_gen bu_mat bu_para bu_exit 

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
     SIZE 7 BY 1.1
     FONT 6.

DEFINE BUTTON bu_gen 
     LABEL "Load Text File [ by phone]" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FONT 6.

DEFINE BUTTON bu_import 
     LABEL "Running Notify by PHONE.." 
     SIZE 42 BY 1.24
     BGCOLOR 10 FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_mat 
     LABEL "Match Policy GW && Premium [by phone]" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FONT 6.

DEFINE BUTTON bu_mat-2 
     LABEL "Match File ORICO" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FONT 6.

DEFINE BUTTON bu_mat-3 
     LABEL "Match File CIMB" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FONT 6.

DEFINE BUTTON bu_mat-4 
     LABEL "Post Document Send To CIMB" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FONT 6.

DEFINE BUTTON bu_para 
     LABEL "Parameter Company Code" 
     SIZE 42 BY 1.24
     FONT 6.

DEFINE BUTTON bu_update 
     LABEL "Query && Update [DATA Phone ]" 
     SIZE 42 BY 1.24
     BGCOLOR 10 FGCOLOR 1 FONT 6.

DEFINE RECTANGLE RECT-329
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 50.5 BY 12.62
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-330
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 49.17 BY 12.62
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-342
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 5 FGCOLOR 2 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.52
     BGCOLOR 4 FGCOLOR 4 .

DEFINE RECTANGLE RECT-344
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 5 FGCOLOR 1 .

DEFINE RECTANGLE RECT-346
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 5 FGCOLOR 0 .

DEFINE RECTANGLE RECT-347
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 5 FGCOLOR 1 .

DEFINE RECTANGLE RECT-348
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 5 FGCOLOR 7 .

DEFINE RECTANGLE RECT-350
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 2
     BGCOLOR 5 FGCOLOR 1 .

DEFINE RECTANGLE RECT-351
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 1.91
     BGCOLOR 5 FGCOLOR 1 .

DEFINE RECTANGLE RECT-352
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45 BY 1.91
     BGCOLOR 5 FGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bu_import AT ROW 3.19 COL 4
     bu_mat-2 AT ROW 3.29 COL 54.17 WIDGET-ID 10
     bu_update AT ROW 5.29 COL 4
     bu_mat-3 AT ROW 5.33 COL 54.17 WIDGET-ID 14
     bu_mat-4 AT ROW 7.33 COL 54.17 WIDGET-ID 18
     bu_gen AT ROW 7.48 COL 3.67
     bu_mat AT ROW 9.57 COL 3.67
     bu_para AT ROW 11.67 COL 3.67 WIDGET-ID 2
     bu_exit AT ROW 14.14 COL 47.67
     "       IMPORT DATA BY TELEPHONE" VIEW-AS TEXT
          SIZE 42 BY 1 AT ROW 1.48 COL 4.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "       MATCH FILE AND DATA TELEPHONE" VIEW-AS TEXT
          SIZE 44.5 BY 1 AT ROW 1.48 COL 53 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 2 FONT 6
     RECT-329 AT ROW 1.24 COL 1
     RECT-342 AT ROW 4.95 COL 2.5
     RECT-343 AT ROW 13.91 COL 46
     RECT-344 AT ROW 2.91 COL 2.5
     RECT-346 AT ROW 7.05 COL 2.5
     RECT-347 AT ROW 9.19 COL 2.5
     RECT-348 AT ROW 11.29 COL 2.5 WIDGET-ID 4
     RECT-330 AT ROW 1.24 COL 51.67 WIDGET-ID 6
     RECT-350 AT ROW 2.91 COL 53 WIDGET-ID 12
     RECT-351 AT ROW 5 COL 53 WIDGET-ID 16
     RECT-352 AT ROW 7 COL 53 WIDGET-ID 20
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 100.17 BY 14.57
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
         TITLE              = "IMPORT DATA TELEPHONE"
         HEIGHT             = 14.57
         WIDTH              = 100
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* IMPORT DATA TELEPHONE */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* IMPORT DATA TELEPHONE */
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


&Scoped-define SELF-NAME bu_gen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_gen C-Win
ON CHOOSE OF bu_gen IN FRAME DEFAULT-FRAME /* Load Text File [ by phone] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwpogen.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import C-Win
ON CHOOSE OF bu_import IN FRAME DEFAULT-FRAME /* Running Notify by PHONE.. */
DO:
   {&WINDOW-NAME} :Hidden = Yes.
   /*Run  wgw\wgwimpon.   */ /* A55-0257 */
   Run  wgw\wgwimnot.        /* A55-0257 */
   {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat C-Win
ON CHOOSE OF bu_mat IN FRAME DEFAULT-FRAME /* Match Policy GW  Premium [by phone] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwmatpo.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat-2 C-Win
ON CHOOSE OF bu_mat-2 IN FRAME DEFAULT-FRAME /* Match File ORICO */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwphori.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat-3 C-Win
ON CHOOSE OF bu_mat-3 IN FRAME DEFAULT-FRAME /* Match File CIMB */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwmtcimb.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat-4 C-Win
ON CHOOSE OF bu_mat-4 IN FRAME DEFAULT-FRAME /* Post Document Send To CIMB */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wuw\wuwrcimb.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_para
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_para C-Win
ON CHOOSE OF bu_para IN FRAME DEFAULT-FRAME /* Parameter Company Code */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwsetcom.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update C-Win
ON CHOOSE OF bu_update IN FRAME DEFAULT-FRAME /* Query  Update [DATA Phone ] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\WGWQUPON.   
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

  gv_prgid = "wgwmupon".
  gv_prog  = "Import Data by Telephone...".
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
  ENABLE RECT-329 RECT-342 RECT-343 RECT-344 RECT-346 RECT-347 RECT-348 
         RECT-330 RECT-350 RECT-351 RECT-352 bu_import bu_mat-2 bu_update 
         bu_mat-3 bu_mat-4 bu_gen bu_mat bu_para bu_exit 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

