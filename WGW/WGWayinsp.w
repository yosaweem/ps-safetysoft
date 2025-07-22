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

/* ***************************  Definitions  **************************     */
                                                                            
/* Parameters Definitions ---                                               */
/* Local Variable Definitions ---                                           */
/*Program ID    : wgwmayinsp.w                                               */    
/*Program name : Export File Inspection Send to aycal                     */
/*create by    : Ranu i. A61-0573 date 06/04/2019                           */
/*              เรียกรายงานการตรวจสภาพส่ง AYCAL        */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */
/* Modify by : Ranu I. A65-0115 เพิ่มการ Match file inspection AY   */
/* Modify by : Kridtiya i. A66-0235 Date. 04/11/2023 เพิ่ม คอลัมน์การแสดงความเสียหาย*/
/* Modify by : Ranu I. A67-0162 Date. 04/10/2024 เพิ่มเงื่อนไขการเก็บอุปกรณ์เสริม */
/* Modify by : Ranu I. F67-0001 เพิ่มการเก็บข้อมูล อุปกรณ์เสริม และออกในรายงาน */
/*-------------------------------------------------------------------------*/
DEF VAR gv_id  AS CHAR FORMAT "X(12)" NO-UNDO.  
DEF VAR n_user  AS CHAR FORMAT "X(12)" NO-UNDO. 
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO.  
DEF  stream ns1.

DEFINE NEW SHARED TEMP-TABLE winsp NO-UNDO
    FIELD RefNo           AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD CusCode         AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD cusName         AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD Surname         AS CHAR FORMAT "x(50)"  INIT ""                       
    FIELD Licence         AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD Chassis         AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD Insp_date       AS CHAR FORMAT "X(15)"  INIT ""  
    FIELD Insp_Code       AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD Insp_Result     AS CHAR FORMAT "X(30)"  INIT ""  
    FIELD Insp_Detail     AS CHAR FORMAT "X(700)" INIT ""  
    FIELD Insp_Remark1    AS CHAR FORMAT "X(700)" INIT ""  
    FIELD Insp_Remark2    AS CHAR FORMAT "X(700)" INIT ""
    FIELD insp_status     AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD insp_no         AS CHAR FORMAT "x(20)"  INIT ""
    FIELD insp_damage     as CHAR format "x(1000)" INIT ""
    FIELD insp_driver     as CHAR format "x(500)" INIT ""
    FIELD Insp_other      as CHAR format "x(500)" INIT ""
    FIELD province        AS CHAR FORMAT "x(3)"   INIT "" 
    FIELD Insp_Detail_2   AS CHAR FORMAT "X(250)"  INIT ""  /*Kridtiya i. A66-0235 Date. 04/11/2023*/
    FIELD Insp_Remark1_2  AS CHAR FORMAT "X(700)" INIT ""   /*Kridtiya i. A66-0235 Date. 04/11/2023*/
    FIELD accessory       AS CHAR FORMAT "x(1000)" INIT "" /* ranu I. A67-0162 */
    FIELD accessory_2     AS CHAR FORMAT "x(1000)" INIT "" /* ranu I. A67-0162 */
    .  

DEF NEW SHARED TEMP-TABLE winspec NO-UNDO
    field number             as char format "X(3)"  init "" 
    field CustCode           as char format "X(20)"  init "" 
    field CampaignCode       as char format "X(35)"  init "" 
    field Campaign           as char format "X(35)"  init "" 
    field MapProCode         as char format "X(35)"  init "" 
    field ProName            as char format "X(75)"  init "" 
    field PlanCode           as char format "X(5)"  init "" 
    field PlanName           as char format "X(75)"  init "" 
    field XRefNo             as char format "X(25)"  init "" 
    field Cuscode            as char format "X(50)"  init "" 
    field HName              as char format "X(100)"  init "" 
    field HSurname           as char format "X(100)"  init "" 
    field ContMobile         as char format "X(15)"  init "" 
    field TmpContact         as char format "X(15)"  init "" 
    field TmpContact2        as char format "X(15)"  init "" 
    field VMIInsType         as char format "X(45)"  init "" 
    field DateAppInsp        as char format "X(15)"  init "" 
    field TimeAppInsp        as char format "X(15)"  init "" 
    field ContactNameinsp    as char format "X(100)"  init "" 
    field ContactMobileinsp  as char format "X(15)"  init "" 
    field LineID             as char format "X(100)"  init "" 
    field Email              as char format "X(100)"  init "" 
    field Addrinsp           as char format "X(250)"  init "" 
    field Make               as char format "X(35)"  init "" 
    field Model              as char format "X(50)"  init "" 
    field MotorType          as char format "X(5)"  init "" 
    field Seat               as char format "X(2)"  init "" 
    field CC                 as char format "X(5)"  init "" 
    field Weight             as char format "X(5)"  init "" 
    field Province           as char format "X(50)"  init "" 
    field RegisYear          as char format "X(4)"  init "" 
    field Licence            as char format "X(10)"  init "" 
    field ChassisNo          as char format "X(25)"  init "" 
    field EngineNo           as char format "X(25)"  init "" 
    field VMIEffdate         as char format "X(15)"  init "" 
    field VMIExpdate         as char format "X(15)"  init "" 
    field SumInsured         as char format "X(15)"  init "" 
    field Premium            as char format "X(15)"  init "" 
    field ExportCIDate       as char format "X(15)"  init "" 
    field ispno              as char format "X(10)"  init "" 
    field isp_result         as char format "X(100)"  init "" 
    field isp_detail         as char format "X(1000)"  init ""  
    FIELD isp_result2     AS CHAR FORMAT "X(250)"  INIT ""       /*Kridtiya i. A66-0235 Date. 04/11/2023*/   
    FIELD isp_detail2     AS CHAR FORMAT "X(1000)" INIT ""      /*Kridtiya i. A66-0235 Date. 04/11/2023*/
    FIELD acces           AS CHAR FORMAT "x(1000)" INIT "" /* ranu I. A67-0162 */   
    FIELD acces_2         AS CHAR FORMAT "x(1000)" INIT "" . /* ranu I. A67-0162 */   


def var nv_row    as int init 0.
def var nv_column as int init 0.
DEF VAR n_length  AS INT INIT 0.
DEF VAR nv_length AS CHAR INIT "".

Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .
DEF VAR nv_year          AS CHAR FORMAT "x(5)" .
DEF VAR nv_docno         AS CHAR FORMAT "x(25)".
DEF VAR nv_survey        AS CHAR FORMAT "x(25)".
DEF VAR nv_detail        AS CHAR FORMAT "x(30)".
DEF VAR nv_remark1       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2       AS CHAR FORMAT "x(250)".
DEF VAR nv_damlist       AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage        AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam      AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile       AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device        AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1          as char format "x(50)".   
Def var nv_acc2          as char format "x(50)".   
Def var nv_acc3          as char format "x(50)".   
Def var nv_acc4          as char format "x(50)".   
Def var nv_acc5          as char format "x(50)".   
Def var nv_acc6          as char format "x(50)".   
Def var nv_acc7          as char format "x(50)".   
Def var nv_acc8          as char format "x(50)".   
Def var nv_acc9          as char format "x(50)".   
Def var nv_acc10         as char format "x(50)".   
Def var nv_acc11         as char format "x(50)".   
Def var nv_acc12         as char format "x(50)".   
Def var nv_acctotal      as char format "x(250)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".
DEF VAR nv_date          AS CHAR FORMAT "x(15)".
DEF VAR nv_province      AS CHAR FORMAT "x(3)" .
/* add by : A67-0162 */
Def var nv_acc_1          as char format "x(50)". 
Def var nv_acc_2          as char format "x(50)". 
Def var nv_accprice1     as char format "x(10)".   
Def var nv_accprice2     as char format "x(10)".   
Def var nv_accprice3     as char format "x(10)".   
Def var nv_accprice4     as char format "x(10)".   
Def var nv_accprice5     as char format "x(10)".   
Def var nv_accprice6     as char format "x(10)".   
Def var nv_accprice7     as char format "x(10)".   
Def var nv_accprice8     as char format "x(10)".   
Def var nv_accprice9     as char format "x(10)".   
Def var nv_accprice10    as char format "x(10)".   
Def var nv_accprice11    as char format "x(10)".   
Def var nv_accprice12    as char format "x(10)".
DEF VAR nv_device_2      AS CHAR FORMAT "x(1000)" INIT "".
/* end : A67-0162 */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_file fi_outload bu_ok bu_exit-2 fi_year ~
fi_filename bu_file RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS rs_file fi_outload fi_year fi_filename 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit-2 
     LABEL "Exit" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 5 BY .95.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_file AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Match file", 1,
"Export Report", 2
     SIZE 16.83 BY 1.76
     FGCOLOR 34 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 7.24
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_file AT ROW 3.43 COL 80.67 NO-LABEL WIDGET-ID 8
     fi_outload AT ROW 6.67 COL 28.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 8.38 COL 82.83
     bu_exit-2 AT ROW 8.38 COL 92.67
     fi_year AT ROW 4.19 COL 29 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 5.52 COL 28.5 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     bu_file AT ROW 5.52 COL 90.83 WIDGET-ID 2
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 6.62 COL 14.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Export Data Inspection Send to AYCAL" VIEW-AS TEXT
          SIZE 105 BY 2.14 AT ROW 1.1 COL 1.17
          BGCOLOR 18 FGCOLOR 2 FONT 2
     " FILE MATCH AYCAL :" VIEW-AS TEXT
          SIZE 21.83 BY .95 AT ROW 5.52 COL 7.83 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "INSPECTION YEAR :" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 4.14 COL 10
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "** ปีของกล่องตรวจสภาพ**" VIEW-AS TEXT
          SIZE 21.17 BY 1 AT ROW 4.14 COL 49.5
          BGCOLOR 10 FGCOLOR 12 FONT 1
     RECT-381 AT ROW 3.29 COL 1.17
     RECT-382 AT ROW 7.95 COL 91.33
     RECT-383 AT ROW 7.95 COL 81.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 105.5 BY 9.67
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
         TITLE              = "Match text  File Inspection (AYCAL)"
         HEIGHT             = 9.62
         WIDTH              = 105.67
         MAX-HEIGHT         = 29.81
         MAX-WIDTH          = 123.67
         VIRTUAL-HEIGHT     = 29.81
         VIRTUAL-WIDTH      = 123.67
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
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match text  File Inspection (AYCAL) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text  File Inspection (AYCAL) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit-2 C-Win
ON CHOOSE OF bu_exit-2 IN FRAME fr_main /* Exit */
DO:
  Apply "Close" to this-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS    /* "Text Documents" "*.csv"*/
       "CSV (Comma Delimited)"   "*.csv"   /*,
                            "Data Files (*.dat)"     "*.dat",
                    "Text Files (*.txt)" "*.txt"*/
                    
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         /***--- 08/11/2006 ---***/
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

         /***---a490166 ---***/
         ASSIGN
            fi_filename  = cvData
            fi_outload = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  + "_SUCCESS" + no_add + ".XLS" .

         DISP fi_filename fi_outload  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_outload.
         RETURN NO-APPLY.
    END.

    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    FOR EACH winsp :
        DELETE winsp.
    END.

    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.
    /* A65-0115*/
    IF rs_file = 1 THEN DO: 
        IF fi_filename = "" THEN DO:
            MESSAGE "Input file match not Empty..!!!" SKIP
                    "Insert file Match...!!!"      VIEW-AS ALERT-BOX.
            APPLY "Entry" TO fi_filename.
            RETURN NO-APPLY.
        END.
        ELSE RUN proc_impfile.
    END.
    /* end A65-0115*/
    ELSE RUN proc_chkdata. 
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outload C-Win
ON LEAVE OF fi_outload IN FRAME fr_main
DO:
  fi_outload = INPUT fi_outload.
  DISP fi_outload WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year.
  DISP fi_year WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_file C-Win
ON VALUE-CHANGED OF rs_file IN FRAME fr_main
DO:
    rs_file = INPUT rs_file .
    DISP rs_file WITH FRAME fr_main .
  
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
  ASSIGN 
      gv_prgid          = "WGWAYINSP"
      fi_year           = STRING(YEAR(TODAY),"9999")
      rs_file           = 1.
      /* a65-0115...
      fi_outload        = "D:\Inspection_AYCAL_" + 
                           STRING(YEAR(TODAY),"9999") + 
                           STRING(MONTH(TODAY),"99")  + 
                           STRING(DAY(TODAY),"99")    + 
                           SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                           SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .*/
    
  gv_prog  = "Export Data Inspection Send to AYCAL".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  
  DISP fi_year fi_outload rs_file WITH FRAM fr_main.
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
  DISPLAY rs_file fi_outload fi_year fi_filename 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE rs_file fi_outload bu_ok bu_exit-2 fi_year fi_filename bu_file 
         RECT-381 RECT-382 RECT-383 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdata C-Win 
PROCEDURE proc_chkdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A59-0471     
------------------------------------------------------------------------------*/
DEF VAR nv_Code    as char format "x(2)" INIT "" .
DEF VAR nv_Result  as char format "x(25)" INIT "" .

FOR EACH brstat.tlt USE-INDEX tlt04         WHERE   
   brstat.tlt.genusr       = "AYCAL"        AND 
   brstat.tlt.flag         = "INSPEC"       AND 
   brstat.tlt.stat         = "NO"           NO-LOCK.
    
      IF brstat.tlt.releas = "NO" THEN DO:
          RUN proc_datainsp .
      END.
      ELSE DO:

          nv_province = "" .
          IF brstat.tlt.lince2 = "กทม"    THEN nv_province = "กท".  
          ELSE DO:
             FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                  brstat.insure.compno = "999" AND 
                  brstat.insure.FName  = TRIM(brstat.tlt.lince2) NO-LOCK NO-WAIT NO-ERROR.
              IF AVAIL brstat.insure THEN  ASSIGN nv_province = trim(brstat.Insure.LName).
          END.

          CREATE winsp.
          ASSIGN winsp.RefNo        = brstat.tlt.nor_noti_ins
                 winsp.CusCode      = brstat.tlt.nor_usr_ins 
                 winsp.Surname      = TRIM(SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name," ")))
                 winsp.cusName      = TRIM(SUBSTR(brstat.tlt.ins_name,1,LENGTH(tlt.ins_name) - LENGTH(winsp.surname)))
                 winsp.Licence      = trim(brstat.tlt.lince1) + " " + TRIM(nv_province)   
                 winsp.Chassis      = trim(brstat.tlt.cha_no)
                 winsp.Insp_date    = string(brstat.tlt.datesent,"99/99/9999")
                 winsp.Insp_Code    = ""
                 winsp.Insp_Result  = "" 
                 winsp.Insp_Detail  = TRIM(brstat.tlt.safe1)
                 winsp.Insp_Remark1 = TRIM(brstat.tlt.safe2)
                 winsp.Insp_Remark2 = IF TRIM(brstat.tlt.safe3) <> "" THEN "อุปกรณ์เสริม : " + TRIM(brstat.tlt.safe3) ELSE ""
                 winsp.insp_remark2 = IF trim(brstat.tlt.filler2) <> "" THEN winsp.insp_remark2 + " ข้อมูลอื่น ๆ : " + TRIM(brstat.tlt.filler2) ELSE
                                      winsp.insp_remark2
                 winsp.insp_status  = brstat.tlt.releas.

             IF INDEX(brstat.tlt.safe1,"ไม่มีความเสียหาย") <> 0 THEN DO:
                 ASSIGN winsp.Insp_Code   = "01"
                        winsp.Insp_Result = "AU-Approve".
              END.
              ELSE IF INDEX(brstat.tlt.safe1,"มีความเสียหาย") <> 0 THEN DO:
                  ASSIGN winsp.Insp_Code   = "03"
                         winsp.Insp_Result = "AC-Approved with Condition".  
              END.
              ELSE IF INDEX(brstat.tlt.safe1,"ติดปัญหา") <> 0 THEN DO:
                  ASSIGN winsp.Insp_Code   = "04"
                         winsp.Insp_Result = "RI-Request More Info".  
              END.
      END.
END.
RELEASE brstat.tlt.
RUN proc_updatetlt.
RUN proc_reportinsp.

Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_datainsp C-Win 
PROCEDURE proc_datainsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 DO:   
    DEF VAR n_list      AS INT init 0.
    DEF VAR n_count     AS INT init 0.
    DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_repair2    AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
    DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_repair2   AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_damdetail AS LONGCHAR  INIT "". 
    DEF VAR nv_damdetail2 AS LONGCHAR  INIT "". 
    DEF VAR n_agent      AS CHAR FORMAT "x(12)" INIT "".
     ASSIGN  nv_year     = ""     nv_docno  = ""      nv_survey   = ""    nv_detail  = ""     nv_remark1 = ""     nv_remark2  = ""
             nv_damlist  = ""     nv_damage = ""      nv_totaldam = ""    nv_attfile = ""     nv_device  = ""     nv_acc1     = ""
             nv_acc2     = ""     nv_acc3   = ""      nv_acc4     = ""    nv_acc5    = ""     nv_acc6    = ""     nv_acc7     = ""
             nv_acc8     = ""     nv_acc9   = ""      nv_acc10    = ""    nv_acc11   = ""     nv_acc12   = ""     nv_acctotal = "" nv_damdetail2 = ""
             nv_surdata  = ""     nv_tmp    = ""      nv_date     = ""    n_agent    = ""     nv_province = ""    n_repair2   = "" nv_repair2 = ""
             nv_accprice1  = ""      nv_accprice2  = ""      nv_accprice3  = ""      nv_accprice4  = ""    nv_device_2 = "" /* A67-0162 */
             nv_accprice5  = ""      nv_accprice6  = ""      nv_accprice7  = ""      nv_accprice8  = ""  /* A67-0162 */
             nv_accprice9  = ""      nv_accprice10 = ""      nv_accprice11 = ""      nv_accprice12 = ""  /* A67-0162 */   
             nv_year     = TRIM(fi_year)      nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf".
    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\uw\" + nv_tmp .
    /*-------------------------------*/
    /*---------- Server test local -------
    nv_server = "".
    nv_tmp    = "D:\Lotus\Notes\Data\ranui\" + nv_tmp .
    -----------------------------*/
    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).

      IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
         MESSAGE "Can not open database" SKIP  
                 "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
      END.
      chNotesView    = chNotesDatabase:GetView("chassis_no").
      chNavView      = chNotesView:CreateViewNavFromCategory(brstat.tlt.cha_no).
      chViewEntry    = chNavView:GetLastDocument.
      IF VALID-HANDLE(chviewentry) = YES  THEN chDocument  = chViewEntry:Document.  /*A65-0115*/
      ELSE chDocument  = 0.  /*A65-0115*/
      IF VALID-HANDLE(chDocument) = YES THEN DO:
          chitem       = chDocument:Getfirstitem("LicenseNo_2"). /* ตัวย่อทะเบียน */
          IF chitem <> 0 THEN nv_province = chitem:TEXT. 
          ELSE nv_province = "".

          chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
          IF chitem <> 0 THEN nv_date = chitem:TEXT. 
          ELSE nv_date = "".

          chitem       = chDocument:Getfirstitem("docno").      /*เลขตรวจสภาพ*/
          IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
          ELSE nv_docno = "".
          
          chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
          IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
          ELSE nv_survey = "".
          
          chitem       = chDocument:Getfirstitem("SurveyResult").  /*ผลการตรวจ*/
          IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
          ELSE nv_detail = "".
          
          IF nv_detail = "ติดปัญหา" THEN DO:
              chitem       = chDocument:Getfirstitem("DamageC").    /*ข้อมูลการติดปัญหา */
              IF chitem <> 0 THEN nv_damage    = chitem:TEXT.
              ELSE nv_damage = "".
          END.
          IF nv_detail = "มีความเสียหาย"  THEN DO:
              chitem       = chDocument:Getfirstitem("DamageList").  /* รายการความเสียหาย */
              IF chitem <> 0 THEN nv_damlist  = chitem:TEXT.
              ELSE nv_damlist = "".
              chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
              IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
              ELSE nv_totaldam = "".
             
              IF nv_damlist <> "" THEN DO: 
                  ASSIGN n_list     = INT(nv_damlist)
                         nv_damlist = "จำนวนความเสียหาย " + nv_damlist + " รายการ " .
              END.
              IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหายทั้งสิ้น " + nv_totaldam + " บาท " .
              IF n_list > 0  THEN DO:
                ASSIGN  n_count = 1 .
                loop_damage:
                REPEAT:
                    IF n_count <= n_list THEN DO:
                        ASSIGN  n_dam     = "List"   + STRING(n_count) 
                                n_repair  = "Repair" + STRING(n_count)  
                                n_repair2 = "Damage" + STRING(n_count) .
                        
                        chitem       = chDocument:Getfirstitem(n_dam).
                        IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                        ELSE nv_damag = "".  
                        
                        chitem       = chDocument:Getfirstitem(n_repair).
                        IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                        ELSE nv_repair = "".

                        chitem       = chDocument:Getfirstitem(n_repair2).
                        IF chitem <> 0 THEN  nv_repair2 = chitem:TEXT. 
                        ELSE nv_repair2 = "".
                            
                        IF nv_damag <> "" THEN  
                            ASSIGN 
                            nv_damdetail  = nv_damdetail  + string(n_count) + "." + nv_damag + " " + nv_repair + " , " 
                            nv_damdetail2 = nv_damdetail2 + string(n_count) + "." + nv_damag + " แผล " + nv_repair2 + " , " .
                        n_count = n_count + 1.
                    END.
                    ELSE LEAVE loop_damage.
                END.
            END.
          END. /* end ความเสียหาย */
          /*-- ข้อมูลอื่น ๆ ---*/
          chitem       = chDocument:Getfirstitem("SurveyData").
          IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
          ELSE nv_surdata = "".
          IF trim(nv_surdata) <> "" THEN  nv_surdata = "ข้อมูลอื่นๆ :"  +  nv_surdata.
          /*agentCode*/
          chitem       = chDocument:Getfirstitem("agentCode").      
          IF chitem <> 0 THEN n_agent = chitem:TEXT. 
          ELSE n_agent = "".
          IF TRIM(n_agent) <> "" THEN ASSIGN nv_surdata = nv_surdata + " โค้ดตัวแทน: " + n_agent.

          /*-- อุปกรณ์เสริม --*/  
          chitem       = chDocument:Getfirstitem("device1").
          IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
          ELSE nv_device = "".
          IF nv_device <> "" THEN DO:
              chitem       = chDocument:Getfirstitem("pricesTotal").  /* ราคารวมอุปกรณ์เสริม */
              IF chitem <> 0 THEN  nv_acctotal = chitem:TEXT. 
              ELSE nv_acctotal = "".
              chitem       = chDocument:Getfirstitem("DType1").
              IF chitem <> 0 THEN  nv_acc1 = chitem:TEXT. 
              ELSE nv_acc1 = "".
              chitem       = chDocument:Getfirstitem("DType2").
              IF chitem <> 0 THEN  nv_acc2 = chitem:TEXT. 
              ELSE nv_acc2 = "".
              chitem       = chDocument:Getfirstitem("DType3").
              IF chitem <> 0 THEN  nv_acc3 = chitem:TEXT. 
              ELSE nv_acc3 = "".
              chitem       = chDocument:Getfirstitem("DType4").
              IF chitem <> 0 THEN  nv_acc4 = chitem:TEXT. 
              ELSE nv_acc4 = "".
              chitem       = chDocument:Getfirstitem("DType5").
              IF chitem <> 0 THEN  nv_acc5 = chitem:TEXT. 
              ELSE nv_acc5 = "".
              chitem       = chDocument:Getfirstitem("DType6").
              IF chitem <> 0 THEN  nv_acc6 = chitem:TEXT. 
              ELSE nv_acc6 = "".
              chitem       = chDocument:Getfirstitem("DType7").
              IF chitem <> 0 THEN  nv_acc7 = chitem:TEXT. 
              ELSE nv_acc7 = "".
              chitem       = chDocument:Getfirstitem("DType8").
              IF chitem <> 0 THEN  nv_acc8 = chitem:TEXT. 
              ELSE nv_acc8 = "".
              chitem       = chDocument:Getfirstitem("DType9").
              IF chitem <> 0 THEN  nv_acc9 = chitem:TEXT. 
              ELSE nv_acc9 = "".
              chitem       = chDocument:Getfirstitem("DType10").
              IF chitem <> 0 THEN  nv_acc10 = chitem:TEXT. 
              ELSE nv_acc10 = "".
              chitem       = chDocument:Getfirstitem("DType11").
              IF chitem <> 0 THEN  nv_acc11 = chitem:TEXT. 
              ELSE nv_acc11 = "".
              chitem       = chDocument:Getfirstitem("DType12").
              IF chitem <> 0 THEN  nv_acc12 = chitem:TEXT. 
              ELSE nv_acc12 = "".
            /* A67-0162 : ราคาอุปกรณ์เสริม  */
             chitem       = chDocument:Getfirstitem("pricesD_1").
             IF chitem <> 0 THEN  nv_accprice1 = chitem:TEXT.   ELSE nv_accprice1 = "".
             chitem       = chDocument:Getfirstitem("pricesD_2").
             IF chitem <> 0 THEN  nv_accprice2 = chitem:TEXT.   ELSE nv_accprice2 = "".
             chitem       = chDocument:Getfirstitem("pricesD_3").
             IF chitem <> 0 THEN  nv_accprice3 = chitem:TEXT.   ELSE nv_accprice3 = "".
             chitem       = chDocument:Getfirstitem("pricesD_4").
             IF chitem <> 0 THEN  nv_accprice4 = chitem:TEXT.   ELSE nv_accprice4 = "".
             chitem       = chDocument:Getfirstitem("pricesD_5").
             IF chitem <> 0 THEN  nv_accprice5 = chitem:TEXT.   ELSE nv_accprice5 = "".
             chitem       = chDocument:Getfirstitem("pricesD_6").
             IF chitem <> 0 THEN  nv_accprice6 = chitem:TEXT.   ELSE nv_accprice6 = "".
             chitem       = chDocument:Getfirstitem("pricesD_7").
             IF chitem <> 0 THEN  nv_accprice7 = chitem:TEXT.   ELSE nv_accprice7 = "".
             chitem       = chDocument:Getfirstitem("pricesD_8").
             IF chitem <> 0 THEN  nv_accprice8 = chitem:TEXT.   ELSE nv_accprice8 = "".
             chitem       = chDocument:Getfirstitem("pricesD_9").
             IF chitem <> 0 THEN  nv_accprice9 = chitem:TEXT.   ELSE nv_accprice9 = "".
             chitem       = chDocument:Getfirstitem("pricesD_10").
             IF chitem <> 0 THEN  nv_accprice10 = chitem:TEXT.  ELSE nv_accprice10 = "".
             chitem       = chDocument:Getfirstitem("pricesD_11").
             IF chitem <> 0 THEN  nv_accprice11 = chitem:TEXT.  ELSE nv_accprice11 = "". 
             chitem       = chDocument:Getfirstitem("pricesD_12").
             IF chitem <> 0 THEN  nv_accprice12 = chitem:TEXT.  ELSE nv_accprice12 = "".
             /* end A67-0162 */
              ASSIGN nv_device = "อุปกรณ์เสริม : " .
              IF TRIM(nv_acc1)  <> "" THEN nv_device = nv_device + TRIM(nv_acc1).
              IF TRIM(nv_acc2)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc2).
              IF TRIM(nv_acc3)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc3).
              IF TRIM(nv_acc4)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc4).
              IF TRIM(nv_acc5)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc5).
              IF TRIM(nv_acc6)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc6).
              IF TRIM(nv_acc7)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc7).
              IF TRIM(nv_acc8)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc8).
              IF TRIM(nv_acc9)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc9).
              IF TRIM(nv_acc10) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc10).
              IF TRIM(nv_acc11) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc11).
              IF TRIM(nv_acc12) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc12) .
             /* Add by : A67-0162 */   
              ASSIGN nv_device_2 = "อุปกรณ์เสริม : " .
              IF TRIM(nv_acc1)  <> "" THEN nv_device_2  = nv_device_2         + TRIM(nv_acc1) + " " + nv_accprice1 .
              IF TRIM(nv_acc2)  <> "" THEN nv_device_2  = nv_device_2 + " , " + TRIM(nv_acc2) + " " + nv_accprice2 .
              IF TRIM(nv_acc3)  <> "" THEN nv_device_2  = nv_device_2 + " , " + TRIM(nv_acc3) + " " + nv_accprice3 .
              IF TRIM(nv_acc4)  <> "" THEN nv_device_2  = nv_device_2 + " , " + TRIM(nv_acc4) + " " + nv_accprice4 .
              IF TRIM(nv_acc5)  <> "" THEN nv_device_2  = nv_device_2 + " , " + TRIM(nv_acc5) + " " + nv_accprice5 .
              IF TRIM(nv_acc6)  <> "" THEN nv_device_2  = nv_device_2 + " , " + TRIM(nv_acc6) + " " + nv_accprice6 .
              IF TRIM(nv_acc7)  <> "" THEN nv_device_2  = nv_device_2 + " , " + TRIM(nv_acc7) + " " + nv_accprice7 .
              IF TRIM(nv_acc8)  <> "" THEN nv_device_2  = nv_device_2 + " , " + TRIM(nv_acc8) + " " + nv_accprice8 .
              IF TRIM(nv_acc9)  <> "" THEN nv_device_2  = nv_device_2 + " , " + TRIM(nv_acc9) + " " + nv_accprice9 .
              IF TRIM(nv_acc10) <> "" THEN nv_device_2  = nv_device_2 + " , " + TRIM(nv_acc10) + " " + nv_accprice10 .
              IF TRIM(nv_acc11) <> "" THEN nv_device_2  = nv_device_2 + " , " + TRIM(nv_acc11) + " " + nv_accprice11 .
              IF TRIM(nv_acc12) <> "" THEN nv_device_2  = nv_device_2 + " , " + TRIM(nv_acc12) + " " + nv_accprice12 .
             /* end A67-0162 */
              nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " .
          END.
          IF nv_docno <> ""  THEN DO:
              CREATE winsp.
              ASSIGN winsp.RefNo        = brstat.tlt.nor_noti_ins
                     winsp.CusCode      = brstat.tlt.nor_usr_ins 
                     winsp.Surname      = TRIM(SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name," ")))
                     winsp.cusName      = TRIM(SUBSTR(brstat.tlt.ins_name,1,LENGTH(tlt.ins_name) - LENGTH(winsp.surname)))
                     winsp.Licence      = trim(brstat.tlt.lince1) + " " + TRIM(nv_province)    
                     winsp.Chassis      = trim(brstat.tlt.cha_no) .
              IF nv_survey <> "" THEN DO:
                  IF nv_detail = "ติดปัญหา" THEN DO:
                     ASSIGN  winsp.Insp_date      = nv_date
                        winsp.Insp_Code      = "04"
                        winsp.Insp_Result    = "RI-Request More Info"
                        winsp.Insp_Detail    = nv_detail + " : " + nv_damage    /* ความเสียหาย */ 
                        winsp.Insp_Remark1   = nv_device + nv_acctotal
                        winsp.insp_remark2   = nv_surdata
                        winsp.insp_no        = nv_docno                      /*เลขที่ตรวจสภาพ */              
                        winsp.insp_damage    = nv_damdetail                  /*รายการความเสียหาย */           
                        winsp.insp_driver    = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */      
                        winsp.Insp_other     = nv_surdata                    /*รายละเอียดอื่นๆ */
                        winsp.insp_status    = "YES" 
                        winsp.Insp_Detail_2   = nv_detail + " : " + nv_damage    /* ความเสียหาย */ 
                        winsp.Insp_Remark1_2  = nv_damdetail
                        winsp.accessory       = nv_device                     /*A67-0162*/
                        winsp.accessory_2     = nv_device_2  + nv_acctotal .  /*A67-0162*/
                  END.
                  ELSE IF nv_detail = "มีความเสียหาย"  THEN DO:
                    ASSIGN  winsp.Insp_date     = nv_date
                        winsp.Insp_Code     = "03"
                        winsp.Insp_Result   = "AC-Approved with Condition"
                        winsp.Insp_Detail   = nv_detail + " : " + nv_damlist + nv_totaldam  /* ความเสียหาย */ 
                        winsp.Insp_Remark1  = nv_damdetail
                        winsp.insp_remark2  = nv_device + nv_acctotal + nv_surdata
                        winsp.insp_no       = nv_docno                      /*เลขที่ตรวจสภาพ */              
                        winsp.insp_damage   = nv_damdetail                  /*รายการความเสียหาย */           
                        winsp.insp_driver   = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */      
                        winsp.Insp_other    = nv_surdata                    /*รายละเอียดอื่นๆ */
                        winsp.insp_status   = "YES"  
                        winsp.Insp_Detail_2   = nv_detail + " : " + nv_damlist 
                        winsp.Insp_Remark1_2  = nv_damdetail2  
                        winsp.accessory       = nv_device                     /*A67-0162*/
                        winsp.accessory_2     = nv_device_2  + nv_acctotal .  /*A67-0162*/
                  END.
                  ELSE DO: 
                    ASSIGN  winsp.Insp_date     = nv_date
                        winsp.Insp_Code     = "01"
                        winsp.Insp_Result   = "AU-Approve"
                        winsp.Insp_Detail   = nv_detail
                        winsp.Insp_Remark1  = nv_device + nv_acctotal
                        winsp.insp_remark2  = nv_surdata
                        winsp.insp_no       = nv_docno                      /*เลขที่ตรวจสภาพ */              
                        winsp.insp_damage   = ""                            /*รายการความเสียหาย */           
                        winsp.insp_driver   = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */      
                        winsp.Insp_other    = nv_surdata                    /*รายละเอียดอื่นๆ */
                        winsp.insp_status   = "YES" 
                        winsp.Insp_Detail_2   = nv_detail  
                        winsp.Insp_Remark1_2  = ""  
                        winsp.accessory       = nv_device                     /*A67-0162*/
                        winsp.accessory_2     = nv_device_2  + nv_acctotal .  /*A67-0162*/
                  END.
              END.
              ELSE DO:
                ASSIGN  winsp.insp_no      = nv_docno       
                  winsp.insp_status  = "NO"          
                  winsp.Insp_Detail  = ""
                  winsp.insp_damage  = ""                           /*รายการความเสียหาย */       
                  winsp.insp_driver  = nv_device + nv_acctotal      /*รายละเอียดอุปกรณ์เสริม */  
                  winsp.Insp_other   = nv_surdata                  /*รายละเอียดอื่นๆ */  
                  winsp.accessory    = nv_device                     /*A67-0162*/
                  winsp.accessory_2  = nv_device_2  + nv_acctotal .  /*A67-0162*/
              END.
          END.
          RELEASE  OBJECT chitem          NO-ERROR.
          RELEASE  OBJECT chDocument      NO-ERROR.          
          RELEASE  OBJECT chNotesDataBase NO-ERROR.     
          RELEASE  OBJECT chNotesSession  NO-ERROR.
      END.
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_detailtxt C-Win 
PROCEDURE proc_detailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A65-0115      
------------------------------------------------------------------------------*/
DO:
    nv_column = 1.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "หมายเหตุ  :  ระดับความเสียหาย " '"' SKIP.    nv_row = nv_row + 1. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "A - ขีดข่วน ถลอก คลูด บุบ โดยมีความกว้าง+ยาวไม่เกิน 6 นิ้ว หรือเสียหายไม่เกิน 10% ของเนื้อที่ทั้งหมด  " '"' SKIP.    nv_row = nv_row + 1. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "B - ขีดข่วน ถลอก คลูด บุบ โดยมีความกว้าง+ยาวไม่เกิน 18 นิ้ว หรือเสียหายไม่เกิน 30% ของเนื้อที่ทั้งหมด " '"' SKIP.    nv_row = nv_row + 1. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "C - ขีดข่วน ถลอก คลูด บุบ โดยมีความกว้าง+ยาวเกิน 18 นิ้ว หรือเสียหายเกิน 30% ของเนื้อที่ทั้งหมด       " '"' SKIP.    nv_row = nv_row + 1. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "D - ต้องประกอบ เคาะ พ่นสี หรือเปลี่ยนอะไหล่ไปเลย (ไม่สามารถซ่อมได้)                                   " '"' SKIP.    nv_row = nv_row + 1. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "** กรณี ลุกค้าติดอุปกรณ์เสริม ** " '"' SKIP.    nv_row = nv_row + 1.  /*A67-0162 */
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "หากจะลูกค้ามีความประสงค์ให้คุ้มครองอุปกรณ์เสริมดังกล่าว รบกวนโทรหรือส่งเมล์มาเช็คค่าเบี้ยประกันใหม่อีกครั้งด้วยค่ะ " '"' SKIP.    nv_row = nv_row + 1.  /*A67-0162 */
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "** กรณี ลุกค้ามีแผลก่อนทำประกัน ** " '"' SKIP.    nv_row = nv_row + 1.  /*A67-0162 */
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'  "ซึ่งความเสียหายดังกล่าวเกิดขึ้นก่อนการรับประกันภัย ดังนั้น ความเสียหายตามรายการข้างต้น ไม่อยู่ในเงื่อนไขของการรับประกันภัยของบริษัทฯ " '"' SKIP.    nv_row = nv_row + 1. /*A67-0162 */
  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impfile C-Win 
PROCEDURE proc_impfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A65-0115       
------------------------------------------------------------------------------*/
For each  winspec :
    DELETE  winspec.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE winspec .
    IMPORT DELIMITER "|" 
        number               
        CustCode             
        CampaignCode         
        Campaign             
        MapProCode           
        ProName              
        PlanCode             
        PlanName             
        XRefNo               
        Cuscode              
        HName                
        HSurname             
        ContMobile           
        TmpContact           
        TmpContact2          
        VMIInsType           
        DateAppInsp          
        TimeAppInsp          
        ContactNameinsp      
        ContactMobileinsp    
        LineID               
        Email                
        Addrinsp             
        Make                 
        Model                
        MotorType            
        Seat                 
        CC                   
        Weight               
        Province             
        RegisYear            
        Licence              
        ChassisNo            
        EngineNo             
        VMIEffdate           
        VMIExpdate           
        SumInsured           
        Premium              
        ExportCIDate         
        ispno                
        isp_result           
        isp_detail    .
   IF index(winspec.CustCode,"code") <> 0 THEN DELETE winspec.
   ELSE IF index(winspec.CustCode,"No") <> 0 THEN DELETE winspec. 
   ELSE IF winspec.CustCode  = "" THEN DELETE winspec.
END.
FOR EACH winspec WHERE winspec.ChassisNo <> "" .
    RUN proc_matchinsp.
END.
RUN proc_reinsp_match.
MESSAGE " Match file inspection complete " VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchinsp C-Win 
PROCEDURE proc_matchinsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A65-0115       
------------------------------------------------------------------------------*/
 DO:   
    DEF VAR n_list        AS INT init 0.
    DEF VAR n_count       AS INT init 0.
    DEF VAR n_repair      AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_repair2     AS CHAR FORMAT "x(10)" init "".       /*Kridtiya i. A66-0235 Date. 04/11/2023*/
    DEF VAR nv_repair2    AS CHAR.                               /*Kridtiya i. A66-0235 Date. 04/11/2023*/
    DEF VAR n_dam         AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_deatil      AS CHAR FORMAT "x(60)" init "".
    DEF VAR nv_damag      AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_repair     AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_damdetail  AS LONGCHAR  INIT "". 
    DEF VAR n_agent       AS CHAR FORMAT "x(12)" INIT "".
    def var nv_chk        as char format "x(75)" init "" .
    def var nv_commt      as char format "x(75)" init "" .
    DEF VAR nv_damdetail2 as char format "x(150)" init "" .    /*Kridtiya i. A66-0235 Date. 04/11/2023*/

     ASSIGN  nv_year     = ""     nv_docno  = ""      nv_survey   = ""    nv_detail  = ""     nv_remark1 = ""     nv_remark2  = ""
             nv_damlist  = ""     nv_damage = ""      nv_totaldam = ""    nv_attfile = ""     nv_device  = ""     nv_acc1     = ""
             nv_acc2     = ""     nv_acc3   = ""      nv_acc4     = ""    nv_acc5    = ""     nv_acc6    = ""     nv_acc7     = ""
             nv_acc8     = ""     nv_acc9   = ""      nv_acc10    = ""    nv_acc11   = ""     nv_acc12   = ""     nv_acctotal = ""
             nv_surdata  = ""     nv_tmp    = ""      nv_date     = ""    n_agent    = ""     nv_province = ""    nv_damdetail2 = ""
             nv_year     = TRIM(fi_year)              nv_chk      = ""    nv_commt   = ""     n_repair2  = ""  nv_repair2 = ""
             nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf"
             nv_acc_1    = ""        nv_acc_2   = ""        nv_device_2 = ""  /* A67-0162 */
             nv_accprice1  = ""      nv_accprice2  = ""      nv_accprice3  = ""      nv_accprice4  = ""  /* A67-0162 */
             nv_accprice5  = ""      nv_accprice6  = ""      nv_accprice7  = ""      nv_accprice8  = ""  /* A67-0162 */
             nv_accprice9  = ""      nv_accprice10 = ""      nv_accprice11 = ""      nv_accprice12 = ""  /* A67-0162 */  .
    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\uw\" + nv_tmp .
    /*-------------------------------*/
    /*---------- Server test local -------
    nv_server = "".
    nv_tmp    = "D:\Lotus\Notes\Data\ranui\" + nv_tmp .
    -----------------------------*/
    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).

      IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
         MESSAGE "Can not open database" SKIP  
                 "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
      END.
      chNotesView    = chNotesDatabase:GetView("chassis_no").
      chNavView      = chNotesView:CreateViewNavFromCategory(winspec.ChassisNo).
      chViewEntry    = chNavView:GetLastDocument.
      IF VALID-HANDLE(chviewentry) = YES  THEN chDocument  = chViewEntry:Document. 
      ELSE chDocument  = 0.
      IF VALID-HANDLE(chDocument) = YES THEN DO:
          /*
          chitem       = chDocument:Getfirstitem("LicenseNo_2"). /* ตัวย่อทะเบียน */
          IF chitem <> 0 THEN nv_province = chitem:TEXT. 
          ELSE nv_province = "".*/

          chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
          IF chitem <> 0 THEN nv_date = chitem:TEXT. 
          ELSE nv_date = "".

          chitem       = chDocument:Getfirstitem("docno").      /*เลขตรวจสภาพ*/
          IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
          ELSE nv_docno = "".
          
          chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
          IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
          ELSE nv_survey = "".
          
          chitem       = chDocument:Getfirstitem("SurveyResult").  /*ผลการตรวจ*/
          IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
          ELSE nv_detail = "".

          chitem       = chDocument:Getfirstitem("chkby1").  /*รายละเอียดการตรวจ*/
          IF chitem <> 0 THEN  nv_remark1 = chitem:TEXT. 
          ELSE nv_remark1 = "".

          IF nv_remark1 <> "" THEN DO:
                ASSIGN  n_count = 1 .
                loop_comment:
                REPEAT:
                    IF n_count <= 7 THEN DO:
                        ASSIGN  nv_chk    = "Chkby"  + STRING(n_count) 
                                nv_commt  = "commentIns" + STRING(n_count) .
                        
                        chitem       = chDocument:Getfirstitem(nv_chk).
                        IF chitem <> 0 THEN  nv_acc1  = chitem:TEXT. 
                        ELSE nv_acc1 = "".  
                        
                        chitem       = chDocument:Getfirstitem(nv_commt).
                        IF chitem <> 0 THEN  nv_acc2 = chitem:TEXT. 
                        ELSE nv_acc2 = "".
                            
                        IF nv_acc1 <> "" THEN  ASSIGN nv_remark2 = nv_acc2 .
                            
                        n_count = n_count + 1.
                    END.
                    ELSE LEAVE loop_comment.
                END.
          END.
          
          IF nv_detail = "ติดปัญหา" THEN DO:
              chitem       = chDocument:Getfirstitem("DamageC").    /*ข้อมูลการติดปัญหา */
              IF chitem <> 0 THEN nv_damage    = chitem:TEXT.
              ELSE nv_damage = "".
          END.
          IF nv_detail = "มีความเสียหาย"  THEN DO:
              chitem       = chDocument:Getfirstitem("DamageList").  /* รายการความเสียหาย */
              IF chitem <> 0 THEN nv_damlist  = chitem:TEXT.
              ELSE nv_damlist = "".
              chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
              IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
              ELSE nv_totaldam = "".
             
              IF nv_damlist <> "" THEN DO: 
                  ASSIGN n_list     = INT(nv_damlist)
                         nv_damlist = nv_damlist + " รายการ " .
              END.
              IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหายทั้งสิ้น " + nv_totaldam + " บาท " .

              IF n_list > 0  THEN DO:
                ASSIGN  n_count = 1 .
                loop_damage:
                REPEAT:
                    IF n_count <= n_list THEN DO:
                        ASSIGN  n_dam     = "List"   + STRING(n_count) 
                               /* n_repair  = "Damage" + STRING(n_count) */
                                n_repair  = "Repair" + STRING(n_count) 
                                n_repair2 = "Damage" + STRING(n_count) . 
                        
                        chitem       = chDocument:Getfirstitem(n_dam).
                        IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                        ELSE nv_damag = "".  
                        
                        chitem       = chDocument:Getfirstitem(n_repair).
                        IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                        ELSE nv_repair = "".

                        chitem       = chDocument:Getfirstitem(n_repair2).
                        IF chitem <> 0 THEN  nv_repair2 = chitem:TEXT. 
                        ELSE nv_repair2 = "".
                            
                        IF nv_damag <> "" THEN  
                            ASSIGN nv_damdetail  = nv_damdetail  + string(n_count) + "." + nv_damag + " แผล " + nv_repair + " , "
                                   nv_damdetail2 = nv_damdetail2 + string(n_count) + "." + nv_damag + " แผล " + nv_repair2 + " , " .   /*Kridtiya i. A66-0235 Date. 04/11/2023*/
                            
                        n_count = n_count + 1.
                    END.
                    ELSE LEAVE loop_damage.
                END.
            END.
          END. /* end ความเสียหาย */

          /*-- A67-0162 : อุปกรณ์เสริม --*/  
          chitem       = chDocument:Getfirstitem("device1").
          IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
          ELSE nv_device = "".

          IF nv_device <> "" THEN DO:
              chitem       = chDocument:Getfirstitem("pricesTotal").  /* ราคารวมอุปกรณ์เสริม */
              IF chitem <> 0 THEN  nv_acctotal = chitem:TEXT. 
              ELSE nv_acctotal = "".

              chitem       = chDocument:Getfirstitem("DType1").
              IF chitem <> 0 THEN  nv_acc_1 = chitem:TEXT. 
              ELSE nv_acc_1 = "".
              chitem       = chDocument:Getfirstitem("DType2").
              IF chitem <> 0 THEN  nv_acc_2 = chitem:TEXT. 
              ELSE nv_acc_2 = "".
              chitem       = chDocument:Getfirstitem("DType3").
              IF chitem <> 0 THEN  nv_acc3 = chitem:TEXT. 
              ELSE nv_acc3 = "".
              chitem       = chDocument:Getfirstitem("DType4").
              IF chitem <> 0 THEN  nv_acc4 = chitem:TEXT. 
              ELSE nv_acc4 = "".
              chitem       = chDocument:Getfirstitem("DType5").
              IF chitem <> 0 THEN  nv_acc5 = chitem:TEXT. 
              ELSE nv_acc5 = "".
              chitem       = chDocument:Getfirstitem("DType6").
              IF chitem <> 0 THEN  nv_acc6 = chitem:TEXT. 
              ELSE nv_acc6 = "".
              chitem       = chDocument:Getfirstitem("DType7").
              IF chitem <> 0 THEN  nv_acc7 = chitem:TEXT. 
              ELSE nv_acc7 = "".
              chitem       = chDocument:Getfirstitem("DType8").
              IF chitem <> 0 THEN  nv_acc8 = chitem:TEXT. 
              ELSE nv_acc8 = "".
              chitem       = chDocument:Getfirstitem("DType9").
              IF chitem <> 0 THEN  nv_acc9 = chitem:TEXT. 
              ELSE nv_acc9 = "".
              chitem       = chDocument:Getfirstitem("DType10").
              IF chitem <> 0 THEN  nv_acc10 = chitem:TEXT. 
              ELSE nv_acc10 = "".
              chitem       = chDocument:Getfirstitem("DType11").
              IF chitem <> 0 THEN  nv_acc11 = chitem:TEXT. 
              ELSE nv_acc11 = "".
              chitem       = chDocument:Getfirstitem("DType12").
              IF chitem <> 0 THEN  nv_acc12 = chitem:TEXT. 
              ELSE nv_acc12 = "".

             chitem       = chDocument:Getfirstitem("pricesD_1").
             IF chitem <> 0 THEN  nv_accprice1 = chitem:TEXT. 
             ELSE nv_accprice1 = "".
             chitem       = chDocument:Getfirstitem("pricesD_2").
             IF chitem <> 0 THEN  nv_accprice2 = chitem:TEXT. 
             ELSE nv_accprice2 = "".
             chitem       = chDocument:Getfirstitem("pricesD_3").
             IF chitem <> 0 THEN  nv_accprice3 = chitem:TEXT. 
             ELSE nv_accprice3 = "".
             chitem       = chDocument:Getfirstitem("pricesD_4").
             IF chitem <> 0 THEN  nv_accprice4 = chitem:TEXT. 
             ELSE nv_accprice4 = "".
             chitem       = chDocument:Getfirstitem("pricesD_5").
             IF chitem <> 0 THEN  nv_accprice5 = chitem:TEXT. 
             ELSE nv_accprice5 = "".
             chitem       = chDocument:Getfirstitem("pricesD_6").
             IF chitem <> 0 THEN  nv_accprice6 = chitem:TEXT. 
             ELSE nv_accprice6 = "".
             chitem       = chDocument:Getfirstitem("pricesD_7").
             IF chitem <> 0 THEN  nv_accprice7 = chitem:TEXT. 
             ELSE nv_accprice7 = "".
             chitem       = chDocument:Getfirstitem("pricesD_8").
             IF chitem <> 0 THEN  nv_accprice8 = chitem:TEXT. 
             ELSE nv_accprice8 = "".
             chitem       = chDocument:Getfirstitem("pricesD_9").
             IF chitem <> 0 THEN  nv_accprice9 = chitem:TEXT. 
             ELSE nv_accprice9 = "".
             chitem       = chDocument:Getfirstitem("pricesD_10").
             IF chitem <> 0 THEN  nv_accprice10 = chitem:TEXT. 
             ELSE nv_accprice10 = "".
             chitem       = chDocument:Getfirstitem("pricesD_11").
             IF chitem <> 0 THEN  nv_accprice11 = chitem:TEXT. 
             ELSE nv_accprice11 = "".
             chitem       = chDocument:Getfirstitem("pricesD_12").
             IF chitem <> 0 THEN  nv_accprice12 = chitem:TEXT. 
             ELSE nv_accprice12 = "".
            
              ASSIGN nv_device = "อุปกรณ์เสริม : " .
              IF TRIM(nv_acc_1)  <> "" THEN nv_device = nv_device + TRIM(nv_acc_1).
              IF TRIM(nv_acc_2)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc_2).
              IF TRIM(nv_acc3)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc3).
              IF TRIM(nv_acc4)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc4).
              IF TRIM(nv_acc5)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc5).
              IF TRIM(nv_acc6)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc6).
              IF TRIM(nv_acc7)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc7).
              IF TRIM(nv_acc8)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc8).
              IF TRIM(nv_acc9)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc9).
              IF TRIM(nv_acc10) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc10).
              IF TRIM(nv_acc11) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc11).
              IF TRIM(nv_acc12) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc12) .

              ASSIGN nv_device_2 = "อุปกรณ์เสริม : " .
              IF TRIM(nv_acc_1)  <> "" THEN nv_device_2 = nv_device_2         + TRIM(nv_acc_1)  + " " + trim(nv_accprice1)  .
              IF TRIM(nv_acc_2)  <> "" THEN nv_device_2 = nv_device_2 + " , " + TRIM(nv_acc_2)  + " " + trim(nv_accprice2)  .
              IF TRIM(nv_acc3)  <> "" THEN nv_device_2 = nv_device_2 + " , " + TRIM(nv_acc3)  + " " + trim(nv_accprice3)  .
              IF TRIM(nv_acc4)  <> "" THEN nv_device_2 = nv_device_2 + " , " + TRIM(nv_acc4)  + " " + trim(nv_accprice4)  .
              IF TRIM(nv_acc5)  <> "" THEN nv_device_2 = nv_device_2 + " , " + TRIM(nv_acc5)  + " " + trim(nv_accprice5)  .
              IF TRIM(nv_acc6)  <> "" THEN nv_device_2 = nv_device_2 + " , " + TRIM(nv_acc6)  + " " + trim(nv_accprice6)  .
              IF TRIM(nv_acc7)  <> "" THEN nv_device_2 = nv_device_2 + " , " + TRIM(nv_acc7)  + " " + trim(nv_accprice7)  .
              IF TRIM(nv_acc8)  <> "" THEN nv_device_2 = nv_device_2 + " , " + TRIM(nv_acc8)  + " " + trim(nv_accprice8)  .
              IF TRIM(nv_acc9)  <> "" THEN nv_device_2 = nv_device_2 + " , " + TRIM(nv_acc9)  + " " + trim(nv_accprice9)  .
              IF TRIM(nv_acc10) <> "" THEN nv_device_2 = nv_device_2 + " , " + TRIM(nv_acc10) + " " + trim(nv_accprice10) .
              IF TRIM(nv_acc11) <> "" THEN nv_device_2 = nv_device_2 + " , " + TRIM(nv_acc11) + " " + trim(nv_accprice11) .
              IF TRIM(nv_acc12) <> "" THEN nv_device_2 = nv_device_2 + " , " + TRIM(nv_acc12) + " " + trim(nv_accprice12) .

              nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " .
          END.
           /* end A67-0162 */

          IF nv_docno <> ""  THEN DO:
            IF nv_detail = "ติดปัญหา" THEN DO:
                ASSIGN  winspec.ispno        = nv_docno                         /*เลขที่ตรวจสภาพ */ 
                        winspec.isp_result   = nv_detail + " : " + nv_damage    /* ความเสียหาย */ 
                        winspec.isp_detail   = nv_damdetail                     /*รายการความเสียหาย */   
                        winspec.isp_result2  = nv_detail + " : " + nv_damage    /*Kridtiya i. A66-0235 Date. 04/11/2023*/
                        winspec.isp_detail2  = nv_damdetail                    /*Kridtiya i. A66-0235 Date. 04/11/2023*/
                        winspec.acces        = nv_device     /*A67-0162 */
                        winspec.acces_2      = nv_device_2 + nv_acctotal . /*A67-0162 */
            END.                                                                
            ELSE IF nv_detail = "มีความเสียหาย"  THEN DO:                       
                ASSIGN  winspec.ispno       = nv_docno                          
                        /*winspec.isp_result  = nv_detail + " : " + nv_damlist  /* ความเสียหาย */ */
                        winspec.isp_result   = nv_detail + " : " + nv_damlist + nv_totaldam  /* ความเสียหาย */
                        winspec.isp_detail   = nv_damdetail                     
                        winspec.isp_result2  = nv_detail + " : " + nv_damlist   /*Kridtiya i. A66-0235 Date. 04/11/2023*/ 
                        winspec.isp_detail2  = nv_damdetail2                   /*Kridtiya i. A66-0235 Date. 04/11/2023*/ 
                        winspec.acces        = nv_device     /*A67-0162 */
                        winspec.acces_2      = nv_device_2 + nv_acctotal . /*A67-0162 */
            END.
            ELSE DO: 
                ASSIGN  winspec.ispno       = nv_docno                      /*เลขที่ตรวจสภาพ */  
                        winspec.isp_result  = nv_detail 
                        winspec.isp_detail  = IF nv_date <> "" THEN nv_damdetail ELSE nv_remark2  
                        winspec.isp_result2 = nv_detail                          /*Kridtiya i. A66-0235 Date. 04/11/2023*/ 
                        winspec.isp_detail2 = ""                                 /*Kridtiya i. A66-0235 Date. 04/11/2023*/ 
                        winspec.acces        = nv_device     /*A67-0162 */
                        winspec.acces_2      = nv_device_2 + nv_acctotal . /*A67-0162 */

            END.
          END.
          ELSE DO:
              ASSIGN  winspec.ispno       = nv_docno                      /*เลขที่ตรวจสภาพ */  
                      winspec.isp_result  = nv_detail 
                      winspec.isp_detail  = nv_remark2  
                      winspec.isp_result2 = nv_detail                            /*Kridtiya i. A66-0235 Date. 04/11/2023*/  
                      winspec.isp_detail2 = ""                                  /*Kridtiya i. A66-0235 Date. 04/11/2023*/ 
                      winspec.acces       = nv_device     /*A67-0162 */
                      winspec.acces_2     = nv_device_2 + nv_acctotal . /*A67-0162 */

          END.

          RELEASE  OBJECT chitem          NO-ERROR.
          RELEASE  OBJECT chDocument      NO-ERROR.          
          RELEASE  OBJECT chNotesDataBase NO-ERROR.     
          RELEASE  OBJECT chNotesSession  NO-ERROR.
      END.
 END.
      

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reinsp_Head C-Win 
PROCEDURE proc_reinsp_Head :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "LineNumber      "       '"' SKIP.     nv_column = nv_column + 1.      /*1 */ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CustCode        "       '"' SKIP.     nv_column = nv_column + 1.      /*2 */ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CampaignCode    "       '"' SKIP.     nv_column = nv_column + 1.      /*3 */ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Campaign        "       '"' SKIP.     nv_column = nv_column + 1.      /*4 */ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "MapProductCode  "       '"' SKIP.     nv_column = nv_column + 1.      /*5 */ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ProductName     "       '"' SKIP.     nv_column = nv_column + 1.      /*6 */ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PlanCode        "       '"' SKIP.     nv_column = nv_column + 1.      /*7 */ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PlanName        "       '"' SKIP.     nv_column = nv_column + 1.      /*8 */ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "XRefNo          "       '"' SKIP.     nv_column = nv_column + 1.      /*9 */ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CustomerCode    "       '"' SKIP.     nv_column = nv_column + 1.      /*10*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "HolderName      "       '"' SKIP.     nv_column = nv_column + 1.      /*11*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "HolderSurname   "       '"' SKIP.     nv_column = nv_column + 1.      /*12*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ContMobile      "       '"' SKIP.     nv_column = nv_column + 1.      /*13*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "TmpContact      "       '"' SKIP.     nv_column = nv_column + 1.      /*14*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "TmpContact1     "       '"' SKIP.     nv_column = nv_column + 1.      /*15*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "VMIInsuranceType"       '"' SKIP.     nv_column = nv_column + 1.      /*16*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "DateAppointmentCarInspection"   '"' SKIP.     nv_column = nv_column + 1.      /*17*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "TimeAppointmentCarInspection"   '"' SKIP.     nv_column = nv_column + 1.      /*18*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ContactNameCarInspection    "   '"' SKIP.     nv_column = nv_column + 1.      /*19*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ContactMobileCarInspection  "   '"' SKIP.     nv_column = nv_column + 1.      /*20*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "LineID              "    '"' SKIP.    nv_column = nv_column + 1.      /*21*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Email               "    '"' SKIP.    nv_column = nv_column + 1.      /*22*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "AddressCarInspection"    '"' SKIP.    nv_column = nv_column + 1.      /*23*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Make                "    '"' SKIP.    nv_column = nv_column + 1.      /*24*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Model               "    '"' SKIP.    nv_column = nv_column + 1.      /*25*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "MotorType           "    '"' SKIP.    nv_column = nv_column + 1.      /*26*/ 
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Seat                "    '"' SKIP.    nv_column = nv_column + 1.      /*27*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CC                  "    '"' SKIP.    nv_column = nv_column + 1.      /*28*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Weight              "    '"' SKIP.    nv_column = nv_column + 1.      /*29*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "RegisProvince       "    '"' SKIP.    nv_column = nv_column + 1.      /*30*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "RegisYear           "    '"' SKIP.    nv_column = nv_column + 1.      /*31*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "LicencePlateNo      "    '"' SKIP.    nv_column = nv_column + 1.      /*32*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ChassisNo           "    '"' SKIP.    nv_column = nv_column + 1.      /*33*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "EngineNo            "    '"' SKIP.    nv_column = nv_column + 1.      /*34*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "VMIEffectivedate    "    '"' SKIP.    nv_column = nv_column + 1.      /*35*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "VMIExpiredate       "    '"' SKIP.    nv_column = nv_column + 1.      /*36*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "SumInsured          "    '"' SKIP.    nv_column = nv_column + 1.      /*37*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "VMITotalPremium     "    '"' SKIP.    nv_column = nv_column + 1.      /*38*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ExportCIDate        "    '"' SKIP.    nv_column = nv_column + 1.      /*39*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Inspection No.      "    '"' SKIP.    nv_column = nv_column + 1.      /*40*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Inspection Result   "    '"' SKIP.    nv_column = nv_column + 1.      /*41*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Inspection Damage   "    '"' SKIP.    nv_column = nv_column + 1.      /*42*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Accessory           "    '"' SKIP.    nv_column = nv_column + 1.      /*43*/ /*A67-0162*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Inspection Result2  "    '"' SKIP.    nv_column = nv_column + 1.      /*44*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Inspection Damage2  "    '"' SKIP.    nv_column = nv_column + 1.      /*45*/
   PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "Accessory 2         "    '"' SKIP.    nv_column = nv_column + 1.      /*46*/ /*A67-0162*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reinsp_match C-Win 
PROCEDURE proc_reinsp_match :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A65-0115       
------------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".XLS"  THEN fi_outload  =  Trim(fi_outload) + ".XLS"  .
ASSIGN nv_row    =  0 
       nv_column =  0 .
OUTPUT STREAM ns1 TO VALUE(fi_outload) .
   PUT STREAM ns1 "ID;PND" SKIP.        
   ASSIGN nv_row    = nv_row + 1.
   nv_column = nv_column + 1.
   RUN proc_reinsp_Head.
                                                                                                 
FOR EACH winspec no-lock.
    ASSIGN nv_column = 0            nv_column = nv_column + 1 
           nv_row = nv_row  + 1     n_length  = 0       nv_length = "" .
    IF trim(number) <> "" THEN n_length  = LENGTH(number). ELSE n_length = 0.
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(number) FORMAT "x(" + string(n_length) + ")"  '"' SKIP.   /*1 */ 
    nv_column = nv_column + 1. 
      
    IF trim(CustCode) <> "" THEN n_length  = LENGTH(CustCode) . ELSE n_length = 0.    
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(CustCode) FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*2 */
    nv_column = nv_column + 1. 

    IF trim(CampaignCode) <> "" THEN n_length  = LENGTH(CampaignCode) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(CampaignCode)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*3 */
    nv_column = nv_column + 1. 
           
    IF trim(Campaign) <> "" THEN n_length  = LENGTH(Campaign) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Campaign)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*4 */
    nv_column = nv_column + 1.
    
    IF trim(MapProCode) <> "" THEN n_length  = LENGTH(MapProCode) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(MapProCode)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*5 */
    nv_column = nv_column + 1.
    
    IF trim(ProName) <> "" THEN n_length  = LENGTH(ProName) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ProName)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*6 */
    nv_column = nv_column + 1.
      
    IF trim(PlanCode) <> "" THEN n_length  = LENGTH(PlanCode) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PlanCode)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*7*/
    nv_column = nv_column + 1.

    IF trim(PlanName) <> "" THEN n_length  = LENGTH(PlanName) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(PlanName)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*8 */
    nv_column = nv_column + 1.

    IF trim(XRefNo) <> "" THEN n_length  = LENGTH(XRefNo) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(XRefNo)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*9 */
    nv_column = nv_column + 1.
         
    IF trim(Cuscode) <> "" THEN n_length  = LENGTH(Cuscode) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Cuscode)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*10 */
    nv_column = nv_column + 1.

    IF trim(HName) <> "" THEN n_length  = LENGTH(HName) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(HName)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*11 */
    nv_column = nv_column + 1.

    IF trim(HSurname) <> "" THEN n_length  = LENGTH(HSurname) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(HSurname)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*12 */
    nv_column = nv_column + 1.

    IF trim(ContMobile) <> "" THEN n_length  = LENGTH(ContMobile) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ContMobile)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*13 */
    nv_column = nv_column + 1.

    IF trim(TmpContact) <> "" THEN n_length  = LENGTH(TmpContact) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(TmpContact)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*14 */
    nv_column = nv_column + 1.

    IF trim(TmpContact2) <> "" THEN n_length  = LENGTH(TmpContact2) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(TmpContact2)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*15 */
    nv_column = nv_column + 1.

    IF trim(VMIInsType) <> "" THEN n_length  = LENGTH(VMIInsType) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(VMIInsType)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*16 */
    nv_column = nv_column + 1.

    IF trim(DateAppInsp) <> "" THEN n_length  = LENGTH(DateAppInsp) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(DateAppInsp)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*17 */
    nv_column = nv_column + 1.

    IF trim(TimeAppInsp) <> "" THEN n_length  = LENGTH(TimeAppInsp) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(TimeAppInsp)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*18 */
    nv_column = nv_column + 1.

    IF trim(ContactNameinsp) <> "" THEN n_length  = LENGTH(ContactNameinsp) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ContactNameinsp)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*19 */
    nv_column = nv_column + 1.

    IF trim(ContactMobileinsp) <> "" THEN n_length  = LENGTH(ContactMobileinsp) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ContactMobileinsp)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*20 */
    nv_column = nv_column + 1.

    IF trim(LineID) <> "" THEN n_length  = LENGTH(LineID) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(LineID)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*21 */
    nv_column = nv_column + 1.

    IF trim(Email) <> "" THEN n_length  = LENGTH(Email) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Email)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*22 */
    nv_column = nv_column + 1.

    IF trim(Addrinsp) <> "" THEN n_length  = LENGTH(Addrinsp) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Addrinsp)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*23 */
    nv_column = nv_column + 1.

    IF trim(Make) <> "" THEN n_length  = LENGTH(Make) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Make)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*24 */
    nv_column = nv_column + 1.

    IF trim(Model) <> "" THEN n_length  = LENGTH(Model) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Model)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*25 */
    nv_column = nv_column + 1.
      
    IF trim(MotorType) <> "" THEN n_length  = LENGTH(MotorType) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(MotorType)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*26 */
    nv_column = nv_column + 1.
    
    IF trim(Seat) <> "" THEN n_length  = LENGTH(Seat) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Seat)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*27 */
    nv_column = nv_column + 1.
    
    IF trim(CC) <> "" THEN n_length  = LENGTH(CC) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(CC)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*28 */
    nv_column = nv_column + 1.
      
    IF trim(Weight) <> "" THEN n_length  = LENGTH(Weight) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Weight)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*29 */
    nv_column = nv_column + 1.
        
    IF trim(Province) <> "" THEN n_length  = LENGTH(Province) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Province)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*30 */
    nv_column = nv_column + 1.
    
    IF trim(RegisYear) <> "" THEN n_length  = LENGTH(RegisYear) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(RegisYear)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*31 */
    nv_column = nv_column + 1.
      
    IF trim(Licence) <> "" THEN n_length  = LENGTH(Licence) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Licence)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*32 */
    nv_column = nv_column + 1.

    IF trim(ChassisNo) <> "" THEN n_length  = LENGTH(ChassisNo) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ChassisNo)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*33 */
    nv_column = nv_column + 1.
     
    IF trim(EngineNo) <> "" THEN n_length  = LENGTH(EngineNo) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(EngineNo)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*34 */
    nv_column = nv_column + 1.
    
    IF trim(VMIEffdate) <> "" THEN n_length  = LENGTH(VMIEffdate) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(VMIEffdate)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*35 */
    nv_column = nv_column + 1.

    IF trim(VMIExpdate) <> "" THEN n_length  = LENGTH(VMIExpdate) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(VMIExpdate)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*36 */
    nv_column = nv_column + 1.

    IF trim(SumInsured) <> "" THEN n_length  = LENGTH(SumInsured) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(SumInsured)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*37*/
    nv_column = nv_column + 1.
     
    IF trim(Premium) <> "" THEN n_length  = LENGTH(Premium) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(Premium)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*38 */
    nv_column = nv_column + 1.
     
    IF trim(ExportCIDate) <> "" THEN n_length  = LENGTH(ExportCIDate) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ExportCIDate)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*39 */
    nv_column = nv_column + 1.
    
    IF trim(ispno) <> "" THEN n_length  = LENGTH(ispno) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(ispno)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*40 */
    nv_column = nv_column + 1.

    IF trim(isp_result) <> "" THEN n_length  = LENGTH(isp_result) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(isp_result)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*41*/
    nv_column = nv_column + 1.

    IF trim(isp_detail) <> "" THEN n_length  = LENGTH(isp_detail) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(isp_detail)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*42 */
    nv_column = nv_column + 1.

    IF trim(acces) <> "" THEN n_length  = LENGTH(acces) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(acces)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*43 */
    nv_column = nv_column + 1.
    
    IF trim(isp_result2) <> "" THEN n_length  = LENGTH(isp_result2) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(isp_result2)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*44 */
    nv_column = nv_column + 1.
   
    IF trim(isp_detail2) <> "" THEN n_length  = LENGTH(isp_detail2) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(isp_detail2)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*45 */
    nv_column = nv_column + 1.

    IF trim(acces_2) <> "" THEN n_length  = LENGTH(acces_2) . ELSE n_length = 0.      
    IF n_length > 0 THEN PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' trim(acces_2)  FORMAT "x(" + STRING(n_length) + ")"    '"' SKIP.  /*46*/
    nv_column = nv_column + 1.

END. 
RUN proc_detailtxt.
PUT STREAM ns1 "E" SKIP.
OUTPUT STREAM ns1 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportinsp C-Win 
PROCEDURE proc_reportinsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
/*ASSIGN nv_cnt  =  0
       nv_row  =  1.*/
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|"  
     "X-Ref.No               " 
     "Customer Code          " 
     "HolderName             " 
     "HolderSurname          " 
     "LicencePlateNo         " 
     "ChassisNo              " 
     "Date of Car Inspection " 
     "Car Inspection Code    " 
     "Car Inspection Result  " 
     "Car Inspection Detail  " 
     "Car Inspection Remark 1" 
     "Car Inspection Remark 2" 
     "Car Inspection Detail-N"  /*Kridtiya i. A66-0235 Date. 04/11/2023*/ 
     "Car Inspection Remark-N"  /*Kridtiya i. A66-0235 Date. 04/11/2023*/ 
     "Accessory   "   /*A67-0162*/  
     "Accessory 2 " .  /*A67-0162*/ 

FOR EACH winsp WHERE winsp.insp_status = "YES" no-lock.
    EXPORT DELIMITER "|" 
        winsp.RefNo         
        winsp.CusCode       
        winsp.cusName       
        winsp.Surname      
        winsp.Licence       
        winsp.Chassis       
        winsp.Insp_date            
        winsp.Insp_Code            
        winsp.Insp_Result          
        winsp.Insp_Detail          
        winsp.Insp_Remark1         
        winsp.Insp_Remark2 
        winsp.Insp_Detail_2    /*Kridtiya i. A66-0235 Date. 04/11/2023*/ 
        winsp.Insp_Remark1_2   /*Kridtiya i. A66-0235 Date. 04/11/2023*/ 
        winsp.accessory      /*A67-0162*/
        winsp.accessory_2 .   /*A67-0162*/ 
END. 
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_updatetlt C-Win 
PROCEDURE proc_updatetlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH winsp NO-LOCK.
    FIND LAST  brstat.tlt USE-INDEX tlt04       WHERE 
               brstat.tlt.cha_no       = winsp.chassis  AND
               brstat.tlt.genusr       = "AYCAL"        AND 
               brstat.tlt.flag         = "INSPEC"       AND 
               brstat.tlt.stat         = "NO"           NO-ERROR  NO-WAIT.

        IF AVAIL brstat.tlt THEN DO:
            IF brstat.tlt.releas = "NO" THEN DO:
                ASSIGN brstat.tlt.releas       = winsp.insp_status                                                           
                       brstat.tlt.nor_noti_tlt = winsp.insp_no 
                       brstat.tlt.safe1        = winsp.Insp_Detail 
                       brstat.tlt.safe2        = winsp.insp_damage
                       brstat.tlt.safe3        = winsp.insp_driver
                       brstat.tlt.filler2      = winsp.Insp_other                          
                       brstat.tlt.datesent     = DATE(winsp.Insp_date) 
                       brstat.tlt.stat         = IF winsp.insp_status = "NO" THEN "NO" ELSE "YES"
                       brstat.tlt.entdat       = IF winsp.insp_status = "NO" THEN ?    ELSE TODAY  .
            END.
            ELSE DO:
                ASSIGN brstat.tlt.stat         = IF winsp.insp_status = "NO" THEN "NO" ELSE "YES"
                       brstat.tlt.entdat       = IF winsp.insp_status = "NO" THEN ?    ELSE TODAY  .
            END.
        END.
END.
RELEASE brstat.tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

