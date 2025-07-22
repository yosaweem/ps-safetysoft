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
  program id   : wgwmuayl.w   [Menu Import data By Aycal .....] 
  Create  by   : kridtiya i.  [A56-0241]  date. 02/08/2013
  Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW ,STAT 
  modify by    : Kridtiya i. A58-0301 date.21/08/2015 เพิ่มโปรแกรม แปลงไฟล์เบี้ยรับ
  Modify by    : Ranu I. A61-0573 date. 10/02/2019 เพิ่มเมนูType 70 New format 
                เปลี่ยน Host expiry จาก Alpha4 เป็น TMSTH           
+++++++++++++++++++++++++++++++++++++++++++++++*/

DEF SHARED VAR     n_User      AS CHAR.
DEF SHARED VAR     n_PassWd    AS CHAR.

/*Jiraphon A60-0078*/
DEF  VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO. 
DEF VAR nv_pwd AS CHAR NO-UNDO. 
DEF VAR nv_wname AS CHAR FORMAT "x(50)".
DEF VAR number_sic AS INTE INIT 0.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-343 RECT-349 RECT-519 RECT-520 RECT-521 ~
RECT-523 RECT-524 bu_update-2 bu_update bu_import72 bu_gen-3 bu_gen ~
bu_gen-2 bu_mat-4 bu_mat bu_mat-2 bu_mat-7 bu_mat-3 bu_Ex-2 bu_Ex01 ~
bu_mat-6 bu_exit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_Ex-2 
     LABEL "Export Data Inspection File" 
     SIZE 41 BY 1.52
     FONT 6.

DEFINE BUTTON bu_Ex01 
     LABEL "Export File Cancel [AYCL]" 
     SIZE 41 BY 1.52
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 7 BY 1.1
     FONT 6.

DEFINE BUTTON bu_gen 
     LABEL "Load Text File AYCL" 
     SIZE 41 BY 1.52
     FONT 6.

DEFINE BUTTON bu_gen-2 
     LABEL "Load Text File AYCL Compulsory" 
     SIZE 41 BY 1.52
     FONT 6.

DEFINE BUTTON bu_gen-3 
     LABEL "Query and Update Data" 
     SIZE 41 BY 1.52
     FONT 6.

DEFINE BUTTON bu_import72 
     LABEL "Query && Update [DATA AYCL Compulsory]" 
     SIZE 41 BY 1.52
     FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_mat 
     LABEL "Match Policy GW && Premium [by AYCL]" 
     SIZE 41 BY 1.52
     FONT 6.

DEFINE BUTTON bu_mat-2 
     LABEL "Match Policy GW && AYCL Compulsory" 
     SIZE 41 BY 1.52
     FONT 6.

DEFINE BUTTON bu_mat-3 
     LABEL "Match เบี้ยรับจากลูกค้า && Premium [by AYCL]" 
     SIZE 41 BY 1.52
     FONT 6.

DEFINE BUTTON bu_mat-4 
     LABEL "Match File Confirm Policy and Payment" 
     SIZE 41 BY 1.52
     FONT 6.

DEFINE BUTTON bu_mat-5 
     LABEL "" 
     SIZE 41 BY 1.52
     BGCOLOR 8 FONT 6.

DEFINE BUTTON bu_mat-6 
     LABEL "Report File Excel Send AY" 
     SIZE 39 BY 1.29
     BGCOLOR 10 FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_mat-7 
     LABEL "Load Text file AYCL (New Form)" 
     SIZE 41 BY 1.52
     FONT 6.

DEFINE BUTTON bu_update 
     LABEL "Query && Update [DATA AYCL ]" 
     SIZE 41 BY 1.52
     FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_update-2 
     LABEL "Hold Data Notify && Payment" 
     SIZE 41 BY 1.52
     FGCOLOR 2 FONT 6.

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.17 BY 1.81
     BGCOLOR 6 FGCOLOR 4 .

DEFINE RECTANGLE RECT-349
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 128 BY 1.52
     BGCOLOR 2 FGCOLOR 2 .

DEFINE RECTANGLE RECT-519
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 41 BY 1.43
     BGCOLOR 4 FGCOLOR 7 .

DEFINE RECTANGLE RECT-520
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 41 BY 1.43
     BGCOLOR 4 FGCOLOR 7 .

DEFINE RECTANGLE RECT-521
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 84.33 BY 10
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-523
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43 BY 10
     BGCOLOR 21 .

DEFINE RECTANGLE RECT-524
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 41 BY 1.76
     BGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_update-2 AT ROW 4.52 COL 3 WIDGET-ID 10
     bu_update AT ROW 4.52 COL 46
     bu_import72 AT ROW 4.52 COL 87.5
     bu_gen-3 AT ROW 6.1 COL 3 WIDGET-ID 4
     bu_gen AT ROW 6.1 COL 46
     bu_gen-2 AT ROW 6.1 COL 87.5
     bu_mat-4 AT ROW 7.67 COL 3 WIDGET-ID 6
     bu_mat AT ROW 7.67 COL 46
     bu_mat-2 AT ROW 7.67 COL 87.5
     bu_mat-5 AT ROW 9.19 COL 87.5
     bu_mat-7 AT ROW 9.24 COL 3 WIDGET-ID 8
     bu_mat-3 AT ROW 9.24 COL 46
     bu_Ex-2 AT ROW 10.81 COL 3 WIDGET-ID 2
     bu_Ex01 AT ROW 10.81 COL 46
     bu_mat-6 AT ROW 11 COL 88.33
     bu_exit AT ROW 14.67 COL 121.17
     "MENU IMPORT DATA BY AYCAL" VIEW-AS TEXT
          SIZE 34.33 BY 1 AT ROW 1.38 COL 51
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "       TYPE V70  [NEW FORMAT]" VIEW-AS TEXT
          SIZE 41 BY 1.19 AT ROW 3.14 COL 3.17 WIDGET-ID 14
          BGCOLOR 4 FGCOLOR 7 FONT 6
     "                 TYPE V72 [Comp.]" VIEW-AS TEXT
          SIZE 41 BY 1.19 AT ROW 3.19 COL 87.67
          BGCOLOR 4 FGCOLOR 7 FONT 6
     "               TYPE V70 [Motor]" VIEW-AS TEXT
          SIZE 41 BY 1.19 AT ROW 3.19 COL 46.17
          BGCOLOR 4 FGCOLOR 7 FONT 6
     RECT-343 AT ROW 14.29 COL 120
     RECT-349 AT ROW 1.1 COL 2.17
     RECT-519 AT ROW 3 COL 46
     RECT-520 AT ROW 3 COL 87.5
     RECT-521 AT ROW 2.76 COL 45.17
     RECT-523 AT ROW 2.76 COL 2 WIDGET-ID 16
     RECT-524 AT ROW 10.76 COL 87.33 WIDGET-ID 18
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 130 BY 15.57
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
         TITLE              = "MENU IMPORT DATA AYCL"
         HEIGHT             = 15.57
         WIDTH              = 129.83
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
IF NOT C-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
/* SETTINGS FOR BUTTON bu_mat-5 IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* MENU IMPORT DATA AYCL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* MENU IMPORT DATA AYCL */
DO:
  /* This event will close the window and terminate the procedure.  */
  
  /*
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
  */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Ex-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Ex-2 C-Win
ON CHOOSE OF bu_Ex-2 IN FRAME fr_main /* Export Data Inspection File */
DO:
    {&WINDOW-NAME} :HIDDEN = YES.
    RUN wgw\wgwayinsp.    
    {&WINDOW-NAME} :HIDDEN = NO.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Ex01
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Ex01 C-Win
ON CHOOSE OF bu_Ex01 IN FRAME fr_main /* Export File Cancel [AYCL] */
DO:
    {&WINDOW-NAME} :HIDDEN = YES.
    RUN wgw\wgwayex1.    
    {&WINDOW-NAME} :HIDDEN = NO.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  Apply "Close" To This-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_gen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_gen C-Win
ON CHOOSE OF bu_gen IN FRAME fr_main /* Load Text File AYCL */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwtaygn.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_gen-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_gen-2 C-Win
ON CHOOSE OF bu_gen-2 IN FRAME fr_main /* Load Text File AYCL Compulsory */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwtay72.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_gen-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_gen-3 C-Win
ON CHOOSE OF bu_gen-3 IN FRAME fr_main /* Query and Update Data */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwqayl0.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import72 C-Win
ON CHOOSE OF bu_import72 IN FRAME fr_main /* Query  Update [DATA AYCL Compulsory] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwquay3.  
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat C-Win
ON CHOOSE OF bu_mat IN FRAME fr_main /* Match Policy GW  Premium [by AYCL] */
DO:
   /* {&WINDOW-NAME} :Hidden = Yes.*/
     /*Jiraphon A60-0078*/
     IF NOT CONNECTED("sic_exp") THEN DO:
             loop_sic:
             REPEAT:
                 number_sic = number_sic + 1 .
                 RUN sic_exp.
                 IF  CONNECTED("sic_exp") THEN LEAVE loop_sic.
                 ELSE IF number_sic > 3 THEN DO:
                     MESSAGE "User not connect system Expiry !!! >>>" number_sic  VIEW-AS ALERT-BOX.
                     LEAVE loop_sic.
                 END.
             END.
     END.
      /*Jiraphon A60-0078*/
     
     IF CONNECTED("sic_exp") THEN DO:  /*Jiraphon A60-0078*/
         c-win:Hidden = Yes.
         Run  wgw\wgwmatay.
         c-win:Hidden = No.
    END.
   /* {&WINDOW-NAME} :Hidden = No.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat-2 C-Win
ON CHOOSE OF bu_mat-2 IN FRAME fr_main /* Match Policy GW  AYCL Compulsory */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwmata2.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat-3 C-Win
ON CHOOSE OF bu_mat-3 IN FRAME fr_main /* Match เบี้ยรับจากลูกค้า  Premium [by AYCL] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\WGWQUay5.    /*A58-0301*/
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat-4 C-Win
ON CHOOSE OF bu_mat-4 IN FRAME fr_main /* Match File Confirm Policy and Payment */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwmtaycl. 
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat-5 C-Win
ON CHOOSE OF bu_mat-5 IN FRAME fr_main
DO:
    /*{&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwmata2.   
    {&WINDOW-NAME} :Hidden = No.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat-6 C-Win
ON CHOOSE OF bu_mat-6 IN FRAME fr_main /* Report File Excel Send AY */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwreaycl.   
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat-7 C-Win
ON CHOOSE OF bu_mat-7 IN FRAME fr_main /* Load Text file AYCL (New Form) */
DO:
    c-win :Hidden = Yes.
    Run  wgw\WGWntlay.    
    c-win :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update C-Win
ON CHOOSE OF bu_update IN FRAME fr_main /* Query  Update [DATA AYCL ] */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwquay1.  
    {&WINDOW-NAME} :Hidden = No.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update-2 C-Win
ON CHOOSE OF bu_update-2 IN FRAME fr_main /* Hold Data Notify  Payment */
DO:
    {&WINDOW-NAME} :Hidden = Yes.
    Run  wgw\wgwimpay.  
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

  gv_prgid = "wgwmuayl".
  gv_prog  = "Import Data by AYCAL".
  
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
  ENABLE RECT-343 RECT-349 RECT-519 RECT-520 RECT-521 RECT-523 RECT-524 
         bu_update-2 bu_update bu_import72 bu_gen-3 bu_gen bu_gen-2 bu_mat-4 
         bu_mat bu_mat-2 bu_mat-7 bu_mat-3 bu_Ex-2 bu_Ex01 bu_mat-6 bu_exit 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE sic_exp C-Win 
PROCEDURE sic_exp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FORM
    gv_id  LABEL " User Id " colon 20 SKIP
    nv_pwd LABEL " Password" colon 20 BLANK 
    WITH FRAME nf00  ROW 8 SIDE-LABELS OVERLAY width 50
    TITLE   " Connect DB Expiry System"  . 
/*HIDE ALL NO-PAUSE.*//*note block*/
STATUS INPUT OFF.
/*
{s0/s0sf1.i}
*/
gv_prgid = "GWNEXP02".

REPEAT:
    pause 0.
    STATUS DEFAULT "F4=EXIT".
    ASSIGN
        gv_id     = ""
        n_user    = "".
    UPDATE gv_id nv_pwd GO-ON(F1 F4) WITH FRAME nf00
    EDITING:
    READKEY.
        IF FRAME-FIELD = "gv_id" AND 
            LASTKEY = KEYCODE("ENTER") OR 
            LASTKEY = KEYCODE("f1") THEN DO:
            
            IF INPUT gv_id = "" THEN DO:
                MESSAGE "User ID. IS NOT BLANK".
                NEXT-PROMPT gv_id WITH FRAME nf00.
                NEXT.
            END.
            gv_id = INPUT gv_id.
        END.
        IF FRAME-FIELD = "nv_pwd" AND 
            LASTKEY = KEYCODE("ENTER") OR 
            LASTKEY = KEYCODE("f1") THEN DO:
            nv_pwd = INPUT nv_pwd.
        END.
        APPLY LASTKEY.
    END.
    ASSIGN n_user = gv_id.
    IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
          /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/  /*ของจริง เดิม*/ /*A61-0573 */
          CONNECT expiry -H TMSTH -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.  /*ของจริงใหม่*/ /*A61-0573 */
          /*CONNECT expiry -H devserver -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. */ /*ของเทส*/
        
        CLEAR FRAME nf00.
        HIDE FRAME nf00.
        RETURN. 
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

