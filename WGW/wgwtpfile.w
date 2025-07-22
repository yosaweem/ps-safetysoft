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

/* ***************************  Definitions  **************************               */
                                                        
/* Parameters Definitions ---                                                         */
/* Local Variable Definitions ---                                                     */
/*Program name : Match Text File Select Data Empire and Orakan TPIS                   */
/*create by    : Ranu I. A63-0221   โปรแกรมแยกงานเอ็มไพร์และอรกานต์ ดีลเลอร์ตรีเพชร  */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */        
/*---------------------------------------------------------------------------*/       
DEFINE NEW SHARED TEMP-TABLE wdetail2 NO-UNDO  
   FIELD ins_ytyp                AS CHAR FORMAT "x(20)"         INIT ""      /*ประเภทงาน = ต่ออายุงานใหม่*/
   FIELD bus_typ                 AS CHAR FORMAT "x(20)"         INIT ""      /*ประเภทธุรกิจ */
   FIELD TASreceived             AS CHAR FORMAT "x(100)"        INIT ""      /*ผู้ติดต่องาน*/     
   FIELD InsCompany              AS CHAR FORMAT "x(20)"         INIT ""      /*ชื่อบริษัทประกัน*/ 
   FIELD Insurancerefno          AS CHAR FORMAT "x(20)"         INIT ""      /*เลขที่รับแจ้งชั่วคราว*/
   FIELD tpis_no                 AS CHAR FORMAT "x(11)"         INIT ""      /*เลขที่สัญญา*/
   FIELD ntitle                  AS CHAR FORMAT "x(20)"         INIT ""      /*คำนำหน้าชื่อ*/
   FIELD insnam                  AS CHAR FORMAT "x(100)"        INIT ""      /*ชื่อ*/
   FIELD NAME2                   AS CHAR FORMAT "x(100)"        INIT ""      /*สกุล*/   
   FIELD cust_type               AS CHAR FORMAT "x(1)"          INIT ""      /*ประเภทลูกค้า = บุคคล, นิติบุลคล */
   FIELD nDirec                  AS CHAR FORMAT "x(100)"        INIT ""      /*บุคคล = ""  นิติบุลคล <> "" */
   FIELD ICNO                    AS CHAR FORMAT "x(20)"         INIT ""      /*เลขประชาชน*/
   FIELD address                 AS CHAR FORMAT "x(60)"         INIT ""      /*บ้านเลขที่*/
   FIELD build                   AS CHAR FORMAT "x(60)"         INIT ""      /*อาคาร*/
   FIELD mu                      AS CHAR FORMAT "x(60)"         INIT ""      /*หมู่บ้าน*/
   FIELD soi                     AS CHAR FORMAT "x(60)"         INIT ""      /*ซอย*/
   FIELD road                    AS CHAR FORMAT "x(60)"         INIT ""      /*ถนน*/
   FIELD tambon                  AS CHAR FORMAT "x(60)"         INIT ""      /*ตำบล*/
   FIELD amper                   AS CHAR FORMAT "x(60)"         INIT ""      /*อำเภอ*/
   FIELD country                 AS CHAR FORMAT "x(50)"         INIT ""      /*จังหวัด*/
   FIELD post                    AS CHAR FORMAT "x(50)"         INIT ""      /*รหัสไปรษณีย์*/
   FIELD brand                   AS CHAR FORMAT "x(30)"         INIT ""      /*ยี่ห้อ*/
   FIELD model                   AS CHAR FORMAT "x(30)"         INIT ""      /*รุ่นรถ*/
   FIELD class                   AS CHAR FORMAT "x(20)"          INIT ""      /*รหัสบริษัทประกัน*/
   FIELD md_year                 AS CHAR FORMAT "x(20)"          INIT ""      /*ปีรุ่นรถ*/
   FIELD Usage                   AS CHAR FORMAT "x(100)"        INIT ""      /*ประเภทการใช้รถ*/
   FIELD coulor                  AS CHAR FORMAT "x(30)"         INIT ""      /*สีรถ*/
   FIELD cc                      AS CHAR FORMAT "x(20)"          INIT ""      /* น้ำหนัก CC.*/
   FIELD regis_year              AS CHAR FORMAT "x(20)"          INIT ""      /*ข้อมูลรถปี*/
   FIELD engno                   AS CHAR FORMAT "x(40)"         INIT ""      /*เลขตัวถัง*/
   FIELD chasno                  AS CHAR FORMAT "x(25)"         INIT ""      /*เลข Chassis*/
   FIELD Acc_CV                  AS CHAR FORMAT "x(100)"        INIT ""      /*อุปกรณ์เสริม*/
   FIELD Acc_amount              AS CHAR FORMAT "x(100)"         INIT ""      /*ราคาอุปกรณ์*/
   FIELD License                 AS CHAR FORMAT "x(20)"         INIT ""      /*ทะเบียน*/
   FIELD regis_CL                AS CHAR FORMAT "x(100)"         INIT ""      /*จังหวัดที่จดทะเบียน*/
   FIELD campaign                AS CHAR FORMAT "x(100)"         INIT ""      /*ชื่อแคมเปญ*/
   FIELD typ_work                AS CHAR FORMAT "x(20)"         INIT ""      /* กรมธรรม์ 70 ,72*/
   FIELD si                      AS CHAR FORMAT "X(20)"         INIT ""      /* ทุนประกัน */
   FIELD pol_comm_date           AS CHAR FORMAT "X(20)"         INIT ""      /*วันคุ้มครองของ กธ.*/
   FIELD pol_exp_date            AS CHAR FORMAT "x(20)"         INIT ""      /*วันหมดอายุของ กธ.*/
   FIELD LAST_pol                AS CHAR FORMAT "x(20)"         INIT ""      /* กรมธรรม์เดิม */
   FIELD cover                   AS CHAR FORMAT "x(20)"          INIT ""      /*ประเภทความคุ้มครอง ป.1 2 3 2+ 3+*/
   FIELD pol_netprem             AS CHAR FORMAT "X(15)"         INIT ""      /*เบี้ยสุทธิ (กธ.)*/
   FIELD pol_gprem               AS CHAR FORMAT "X(15)"         INIT ""      /*เบียรวม (กธ.)*/
   FIELD pol_stamp               AS CHAR FORMAT "X(15)"         INIT ""      /*แสตมป์ (กธ.)*/
   FIELD pol_vat                 AS CHAR FORMAT "X(15)"         INIT ""      /*Vat (กธ.)*/
   FIELD pol_wht                 AS CHAR FORMAT "X(15)"         INIT ""      /*wht (กธ.)*/
   FIELD com_no                  AS CHAR FORMAT "x(20)"         INIT ""      /* เบอร์ พรบ.*/
   FIELD com_comm_date           AS CHAR FORMAT "X(20)"         INIT ""      /* วันที่คุ้มครอง พรบ.*/
   FIELD com_exp_date            AS CHAR FORMAT "X(20)"         INIT ""      /* วันที่หมดอายุ พรบ.*/
   FIELD com_netprem             AS CHAR FORMAT "x(15)"         INIT ""      /* เบี้ยสุทธิ พรบ.*/
   FIELD com_gprem               AS CHAR FORMAT "x(15)"         INIT ""      /* เบี้ยรวม พรบ.*/
   FIELD com_stamp               AS CHAR FORMAT "x(15)"         INIT ""      /* แสตมป์ พรบ.*/
   FIELD com_vat                 AS CHAR FORMAT "X(15)"         INIT ""      /* vat พรบ.*/
   FIELD com_wht                 AS CHAR FORMAT "x(15)"         INIT ""      /* wht พรบ.*/
   FIELD deler                   AS CHAR FORMAT "x(200)"         INIT ""      /* ตัวแทน */
   FIELD showroom                AS CHAR FORMAT "x(200)"         INIT ""      /* โชว์รูม */
   FIELD typepay                 AS CHAR FORMAT "x(20)"         INIT ""      /*ประเภทการชำระเงิน*/
   FIELD financename             AS CHAR FORMAT "x(200)"         INIT ""      /*ผู้รับผลประโยชน์*/           
   FIELD mail_hno                AS CHAR FORMAT "x(60)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_build              AS CHAR FORMAT "x(60)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_mu                 AS CHAR FORMAT "x(60)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_soi                AS CHAR FORMAT "x(60)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_road               AS CHAR FORMAT "x(60)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_tambon             AS CHAR FORMAT "x(60)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_amper              AS CHAR FORMAT "x(60)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_country            AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_post               AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD send_date               AS CHAR FORMAT "x(20)"         INIT ""      /*วันที่จัดส่งกรมธรรม์*/        
   FIELD policy_no               AS CHAR FORMAT "x(20)"         INIT ""      /* เบอร์กรมธรรม์*/              
   FIELD send_data               AS CHAR FORMAT "x(20)"         INIT ""      /*วันที่จัดส่งข้อมูลให้ TPIS*/  
   FIELD REMARK1                 AS CHAR FORMAT "x(200)"        INIT ""      /*หมายเหตุ*/            
   FIELD occup                   AS CHAR FORMAT "x(20)"         INIT ""      /*อาชีพ*/                       
   FIELD branch                  AS CHAR FORMAT "x(10)"         INIT "" .
DEF VAR nv_fileerr AS CHAR FORMAT "x(150)" INIT "" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loadname fi_outputtm bu_file-3 bu_ok ~
bu_exit-2 fi_outputsf RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS fi_loadname fi_outputtm fi_outputsf 

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

DEFINE BUTTON bu_file-3 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_loadname AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outputsf AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outputtm AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 7.38
     BGCOLOR 8 .

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
     fi_loadname AT ROW 4.38 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_outputtm AT ROW 5.52 COL 29.5 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 4.43 COL 92.5
     bu_ok AT ROW 8.76 COL 84.33
     bu_exit-2 AT ROW 8.76 COL 94.5
     fi_outputsf AT ROW 6.67 COL 29.5 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     "  OUTPUT EMPIRE :" VIEW-AS TEXT
          SIZE 19.83 BY 1 AT ROW 5.48 COL 11
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 4.38 COL 16
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "OUTPUT ORAKAN :" VIEW-AS TEXT
          SIZE 19.33 BY 1 AT ROW 6.62 COL 11.5 WIDGET-ID 10
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "หมายเหตุ : ใช้ไฟล์แจ้งงานป้ายแดงของตรีเพชรตัวคั่นเป็น ( , )" VIEW-AS TEXT
          SIZE 50.5 BY 1 AT ROW 7.81 COL 32.33 WIDGET-ID 12
          BGCOLOR 8 FGCOLOR 7 FONT 1
     "                   EXTRACT DATA EMPIRE AND ORAKAN TO FILE (TPIS)" VIEW-AS TEXT
          SIZE 105 BY 2.14 AT ROW 1.14 COL 1.17
          BGCOLOR 10 FGCOLOR 6 FONT 2
     RECT-381 AT ROW 3.38 COL 1.5
     RECT-382 AT ROW 8.33 COL 93.17
     RECT-383 AT ROW 8.33 COL 83.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 105.5 BY 13
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
         TITLE              = "Extract File TPIS"
         HEIGHT             = 9.86
         WIDTH              = 105.67
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
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
ASSIGN 
       bu_file-3:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Extract File TPIS */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Extract File TPIS */
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


&Scoped-define SELF-NAME bu_file-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file-3 C-Win
ON CHOOSE OF bu_file-3 IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE no_add        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    /*"Text Documents" "*.txt",*/
        "Text Documents" "*.csv",
        "Data Files (*.*)"     "*.*"
        
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        nv_fileerr =  "" .
        no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        fi_loadname  = cvData.
        
       ASSIGN fi_outputsf   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Orakan" + ".csv".
              fi_outputtm   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Empire" + ".csv".
              nv_fileerr    = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Error" +  ".csv".
       DISP fi_loadname fi_outputsf fi_outputtm WITH FRAME fr_main .     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    For each  wdetail2:
        DELETE  wdetail2.
    END.
    
    IF fi_outputtm = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outputtm.
        RETURN NO-APPLY.
    END.
    IF fi_outputsf = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outputsf.
        RETURN NO-APPLY.
    END.
    
   RUN proc_impfile .   /* กรมธรรม์ */
   
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outputsf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outputsf C-Win
ON LEAVE OF fi_outputsf IN FRAME fr_main
DO:
  fi_outputsf = INPUT fi_outputsf.
  DISP fi_outputsf WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outputtm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outputtm C-Win
ON LEAVE OF fi_outputtm IN FRAME fr_main
DO:
  fi_outputtm = INPUT fi_outputtm.
  DISP fi_outputtm WITH FRAM fr_main.
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
     gv_prgid = "WGWTPFILE.W"
     gv_prog  = "Extract Data File TPIS".
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
  DISPLAY fi_loadname fi_outputtm fi_outputsf 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loadname fi_outputtm bu_file-3 bu_ok bu_exit-2 fi_outputsf RECT-381 
         RECT-382 RECT-383 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_ExportError C-Win 
PROCEDURE PD_ExportError :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_count AS INT INIT 0 .

OUTPUT TO VALUE(nv_fileerr).
EXPORT DELIMITER "," 
   "Ins. Year type"   
    "Business type "   
    "TAS received by " 
    "Ins company   " 
    "Insurance ref no."
    "TPIS Contract No."
    "Title name    "  
    "customer name "  
    "customer lastname"
    "Customer type " 
    "Director Name " 
    "ID number     " 
    "House no.     " 
    "Building      " 
    "Village name/no." 
    "Soi           " 
    "Road          " 
    "Sub-district  " 
    "District      " 
    "Province      " 
    "Postcode      " 
    "Brand         " 
    "Car model     " 
    "Insurance Code" 
    "Model Year    " 
    "Usage Type    " 
    "Colour        " 
    "Car Weight (CC.)" 
    "Year          "   
    "Engine No.    "   
    "Chassis No.   "   
    "Accessories (for CV)" 
    "Accessories amount  " 
    "License No.   " 
    "Registered Car License"   
    "Campaign     "        
    "Type of work "        
    "Insurance amount "   
    "Insurance Date( Voluntary )"  
    "Expiry Date (Voluntary)    "  
    "Last Policy No.(Voluntary) "  
    "Insurance Type   "  
    "Net premium (Voluntary)    "  
    "Gross premium(Voluntary)   "  
    "Stamp  "  
    "VAT    "  
    "WHT    "  
    "Compulsory No. "
    "Insurance Date ( Compulsory )"
    "Expiry Date (Compulsory) "
    "Net premium (Compulsory) "
    "Gross premium(Compulsory)"
    "Stamp        "
    "VAT          "
    "WHT          "
    "Dealer       "
    "Showroom     "
    "Payment Type "
    "Beneficiery  "
    "Mailing House no."
    "Mailing  Building"
    "Mailing  Village name/no."
    "Mailing Soi      "       
    "Mailing  Road    "       
    "Mailing  Sub-district "
    "Mailing  District"       
    "Mailing Province "       
    "Mailing Postcode "       
    "Policy no. to customer date "
    "New policy no     "   
    "Insurer Stamp Date"   
    "Remark            "   
    "Occupation code   " SKIP.

FOR EACH wdetail2 WHERE trim(wdetail2.branch) = ""  no-lock.
    nv_count = nv_count + 1 .
  EXPORT DELIMITER "," 
     Wdetail2.ins_ytyp          
     wdetail2.bus_typ           
     wdetail2.TASreceived          
     wdetail2.InsCompany           
     wdetail2.Insurancerefno       
     wdetail2.tpis_no
     wdetail2.ntitle             
     wdetail2.insnam               
     wdetail2.NAME2                
     wdetail2.cust_type
     wdetail2.nDirec               
     wdetail2.ICNO                 
     wdetail2.address              
     wdetail2.build
     wdetail2.mu                   
     wdetail2.soi                  
     wdetail2.road                 
     wdetail2.tambon               
     wdetail2.amper                
     wdetail2.country              
     wdetail2.post                 
     wdetail2.brand             
     wdetail2.model                
     wdetail2.class
     wdetail2.md_year
     wdetail2.Usage              
     wdetail2.coulor               
     wdetail2.cc                   
     wdetail2.regis_year     
     wdetail2.engno                
     wdetail2.chasno               
     Wdetail2.Acc_CV            
     Wdetail2.Acc_amount        
     wdetail2.License
     wdetail2.regis_CL
     wdetail2.campaign
     wdetail2.typ_work
     wdetail2.si                   
     wdetail2.pol_comm_date     
     wdetail2.pol_exp_date     
     wdetail2.last_pol
     wdetail2.cover
     wdetail2.pol_netprem
     wdetail2.pol_gprem
     wdetail2.pol_stamp
     wdetail2.pol_vat
     wdetail2.pol_wht
     wdetail2.com_no
     wdetail2.com_comm_date
     wdetail2.com_exp_date
     wdetail2.com_netprem
     wdetail2.com_gprem
     wdetail2.com_stamp
     wdetail2.com_vat
     wdetail2.com_wht
     wdetail2.deler                
     wdetail2.showroom             
     wdetail2.typepay              
     wdetail2.financename          
     wdetail2.mail_hno
     wdetail2.mail_build
     wdetail2.mail_mu                   
     wdetail2.mail_soi                  
     wdetail2.mail_road                 
     wdetail2.mail_tambon               
     wdetail2.mail_amper                
     wdetail2.mail_country              
     wdetail2.mail_post                 
     wdetail2.send_date
     wdetail2.policy_no
     wdetail2.send_data
     wdetail2.REMARK1              
     wdetail2.occup.
END.
OUTPUT CLOSE .

IF nv_count <> 0  THEN MESSAGE "Data Branch Error " nv_count  " Record " VIEW-AS ALERT-BOX.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_ExportSF C-Win 
PROCEDURE PD_ExportSF :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE(fi_outputsf).
EXPORT DELIMITER "|" 
    "Ins. Year type"   
    "Business type "   
    "TAS received by " 
    "Ins company   " 
    "Insurance ref no."
    "TPIS Contract No."
    "Title name    "  
    "customer name "  
    "customer lastname"
    "Customer type " 
    "Director Name " 
    "ID number     " 
    "House no.     " 
    "Building      " 
    "Village name/no." 
    "Soi           " 
    "Road          " 
    "Sub-district  " 
    "District      " 
    "Province      " 
    "Postcode      " 
    "Brand         " 
    "Car model     " 
    "Insurance Code" 
    "Model Year    " 
    "Usage Type    " 
    "Colour        " 
    "Car Weight (CC.)" 
    "Year          "   
    "Engine No.    "   
    "Chassis No.   "   
    "Accessories (for CV)" 
    "Accessories amount  " 
    "License No.   " 
    "Registered Car License"   
    "Campaign     "        
    "Type of work "        
    "Insurance amount "   
    "Insurance Date( Voluntary )"  
    "Expiry Date (Voluntary)    "  
    "Last Policy No.(Voluntary) "  
    "Insurance Type   "  
    "Net premium (Voluntary)    "  
    "Gross premium(Voluntary)   "  
    "Stamp  "  
    "VAT    "  
    "WHT    "  
    "Compulsory No. "
    "Insurance Date ( Compulsory )"
    "Expiry Date (Compulsory) "
    "Net premium (Compulsory) "
    "Gross premium(Compulsory)"
    "Stamp        "
    "VAT          "
    "WHT          "
    "Dealer       "
    "Showroom     "
    "Payment Type "
    "Beneficiery  "
    "Mailing House no."
    "Mailing  Building"
    "Mailing  Village name/no."
    "Mailing Soi      "       
    "Mailing  Road    "       
    "Mailing  Sub-district "
    "Mailing  District"       
    "Mailing Province "       
    "Mailing Postcode "       
    "Policy no. to customer date "
    "New policy no     "   
    "Insurer Stamp Date"   
    "Remark            "   
    "Occupation code   " SKIP.

FOR EACH wdetail2 WHERE wdetail2.branch <> "TM" AND trim(wdetail2.branch) <> ""  no-lock.
  EXPORT DELIMITER "|" 
     Wdetail2.ins_ytyp          
            wdetail2.bus_typ           
            wdetail2.TASreceived          
            wdetail2.InsCompany           
            wdetail2.Insurancerefno       
            wdetail2.tpis_no
            wdetail2.ntitle             
            wdetail2.insnam               
            wdetail2.NAME2                
            wdetail2.cust_type
            wdetail2.nDirec               
            wdetail2.ICNO                 
            wdetail2.address              
            wdetail2.build
            wdetail2.mu                   
            wdetail2.soi                  
            wdetail2.road                 
            wdetail2.tambon               
            wdetail2.amper                
            wdetail2.country              
            wdetail2.post                 
            wdetail2.brand             
            wdetail2.model                
            wdetail2.class
            wdetail2.md_year
            wdetail2.Usage              
            wdetail2.coulor               
            wdetail2.cc                   
            wdetail2.regis_year     
            wdetail2.engno                
            wdetail2.chasno               
            Wdetail2.Acc_CV            
            Wdetail2.Acc_amount        
            wdetail2.License
            wdetail2.regis_CL
            wdetail2.campaign
            wdetail2.typ_work
            wdetail2.si                   
            wdetail2.pol_comm_date     
            wdetail2.pol_exp_date     
            wdetail2.last_pol
            wdetail2.cover
            wdetail2.pol_netprem
            wdetail2.pol_gprem
            wdetail2.pol_stamp
            wdetail2.pol_vat
            wdetail2.pol_wht
            wdetail2.com_no
            wdetail2.com_comm_date
            wdetail2.com_exp_date
            wdetail2.com_netprem
            wdetail2.com_gprem
            wdetail2.com_stamp
            wdetail2.com_vat
            wdetail2.com_wht
            wdetail2.deler                
            wdetail2.showroom             
            wdetail2.typepay              
            wdetail2.financename          
            wdetail2.mail_hno
            wdetail2.mail_build
            wdetail2.mail_mu                   
            wdetail2.mail_soi                  
            wdetail2.mail_road                 
            wdetail2.mail_tambon               
            wdetail2.mail_amper                
            wdetail2.mail_country              
            wdetail2.mail_post                 
            wdetail2.send_date
            wdetail2.policy_no
            wdetail2.send_data
            wdetail2.REMARK1              
            wdetail2.occup.
END.                                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_ExportTM C-Win 
PROCEDURE PD_ExportTM :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE(fi_outputtm).
EXPORT DELIMITER "," 
   "Ins. Year type"   
    "Business type "   
    "TAS received by " 
    "Ins company   " 
    "Insurance ref no."
    "TPIS Contract No."
    "Title name    "  
    "customer name "  
    "customer lastname"
    "Customer type " 
    "Director Name " 
    "ID number     " 
    "House no.     " 
    "Building      " 
    "Village name/no." 
    "Soi           " 
    "Road          " 
    "Sub-district  " 
    "District      " 
    "Province      " 
    "Postcode      " 
    "Brand         " 
    "Car model     " 
    "Insurance Code" 
    "Model Year    " 
    "Usage Type    " 
    "Colour        " 
    "Car Weight (CC.)" 
    "Year          "   
    "Engine No.    "   
    "Chassis No.   "   
    "Accessories (for CV)" 
    "Accessories amount  " 
    "License No.   " 
    "Registered Car License"   
    "Campaign     "        
    "Type of work "        
    "Insurance amount "   
    "Insurance Date( Voluntary )"  
    "Expiry Date (Voluntary)    "  
    "Last Policy No.(Voluntary) "  
    "Insurance Type   "  
    "Net premium (Voluntary)    "  
    "Gross premium(Voluntary)   "  
    "Stamp  "  
    "VAT    "  
    "WHT    "  
    "Compulsory No. "
    "Insurance Date ( Compulsory )"
    "Expiry Date (Compulsory) "
    "Net premium (Compulsory) "
    "Gross premium(Compulsory)"
    "Stamp        "
    "VAT          "
    "WHT          "
    "Dealer       "
    "Showroom     "
    "Payment Type "
    "Beneficiery  "
    "Mailing House no."
    "Mailing  Building"
    "Mailing  Village name/no."
    "Mailing Soi      "       
    "Mailing  Road    "       
    "Mailing  Sub-district "
    "Mailing  District"       
    "Mailing Province "       
    "Mailing Postcode "       
    "Policy no. to customer date "
    "New policy no     "   
    "Insurer Stamp Date"   
    "Remark            "   
    "Occupation code   " SKIP.

FOR EACH wdetail2 WHERE trim(wdetail2.branch) = "TM"  no-lock.
  EXPORT DELIMITER "," 
     Wdetail2.ins_ytyp          
            wdetail2.bus_typ           
            wdetail2.TASreceived          
            wdetail2.InsCompany           
            wdetail2.Insurancerefno       
            wdetail2.tpis_no
            wdetail2.ntitle             
            wdetail2.insnam               
            wdetail2.NAME2                
            wdetail2.cust_type
            wdetail2.nDirec               
            wdetail2.ICNO                 
            wdetail2.address              
            wdetail2.build
            wdetail2.mu                   
            wdetail2.soi                  
            wdetail2.road                 
            wdetail2.tambon               
            wdetail2.amper                
            wdetail2.country              
            wdetail2.post                 
            wdetail2.brand             
            wdetail2.model                
            wdetail2.class
            wdetail2.md_year
            wdetail2.Usage              
            wdetail2.coulor               
            wdetail2.cc                   
            wdetail2.regis_year     
            wdetail2.engno                
            wdetail2.chasno               
            Wdetail2.Acc_CV            
            Wdetail2.Acc_amount        
            wdetail2.License
            wdetail2.regis_CL
            wdetail2.campaign
            wdetail2.typ_work
            wdetail2.si                   
            wdetail2.pol_comm_date     
            wdetail2.pol_exp_date     
            wdetail2.last_pol
            wdetail2.cover
            wdetail2.pol_netprem
            wdetail2.pol_gprem
            wdetail2.pol_stamp
            wdetail2.pol_vat
            wdetail2.pol_wht
            wdetail2.com_no
            wdetail2.com_comm_date
            wdetail2.com_exp_date
            wdetail2.com_netprem
            wdetail2.com_gprem
            wdetail2.com_stamp
            wdetail2.com_vat
            wdetail2.com_wht
            wdetail2.deler                
            wdetail2.showroom             
            wdetail2.typepay              
            wdetail2.financename          
            wdetail2.mail_hno
            wdetail2.mail_build
            wdetail2.mail_mu                   
            wdetail2.mail_soi                  
            wdetail2.mail_road                 
            wdetail2.mail_tambon               
            wdetail2.mail_amper                
            wdetail2.mail_country              
            wdetail2.mail_post                 
            wdetail2.send_date
            wdetail2.policy_no
            wdetail2.send_data
            wdetail2.REMARK1              
            wdetail2.occup.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impfile C-Win 
PROCEDURE proc_impfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail2.
        IMPORT DELIMITER ","        
            Wdetail2.ins_ytyp          
            wdetail2.bus_typ           
            wdetail2.TASreceived          
            wdetail2.InsCompany           
            wdetail2.Insurancerefno       
            wdetail2.tpis_no
            wdetail2.ntitle             
            wdetail2.insnam               
            wdetail2.NAME2                
            wdetail2.cust_type
            wdetail2.nDirec               
            wdetail2.ICNO                 
            wdetail2.address              
            wdetail2.build
            wdetail2.mu                   
            wdetail2.soi                  
            wdetail2.road                 
            wdetail2.tambon               
            wdetail2.amper                
            wdetail2.country              
            wdetail2.post                 
            wdetail2.brand             
            wdetail2.model                
            wdetail2.class
            wdetail2.md_year
            wdetail2.Usage              
            wdetail2.coulor               
            wdetail2.cc                   
            wdetail2.regis_year     
            wdetail2.engno                
            wdetail2.chasno               
            Wdetail2.Acc_CV            
            Wdetail2.Acc_amount        
            wdetail2.License
            wdetail2.regis_CL
            wdetail2.campaign
            wdetail2.typ_work
            wdetail2.si                   
            wdetail2.pol_comm_date     
            wdetail2.pol_exp_date     
            wdetail2.last_pol
            wdetail2.cover
            wdetail2.pol_netprem
            wdetail2.pol_gprem
            wdetail2.pol_stamp
            wdetail2.pol_vat
            wdetail2.pol_wht
            wdetail2.com_no
            wdetail2.com_comm_date
            wdetail2.com_exp_date
            wdetail2.com_netprem
            wdetail2.com_gprem
            wdetail2.com_stamp
            wdetail2.com_vat
            wdetail2.com_wht
            wdetail2.deler                
            wdetail2.showroom             
            wdetail2.typepay              
            wdetail2.financename          
            wdetail2.mail_hno
            wdetail2.mail_build
            wdetail2.mail_mu                   
            wdetail2.mail_soi                  
            wdetail2.mail_road                 
            wdetail2.mail_tambon               
            wdetail2.mail_amper                
            wdetail2.mail_country              
            wdetail2.mail_post                 
            wdetail2.send_date
            wdetail2.policy_no
            wdetail2.send_data
            wdetail2.REMARK1              
            wdetail2.occup .

        IF INDEX(wdetail2.ins_ytyp,"Type")   <> 0 THEN  DELETE wdetail2.
        ELSE IF  wdetail2.ins_ytyp   = "" THEN  DELETE wdetail2.
    END. /* end repeat */
    FOR EACH wdetail2 .
         /*---------- สาขา ---------------*/
        IF TRIM(wdetail2.showroom) <> "" THEN DO:
            FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno       = "TPIS"                   AND         
                TRIM(stat.insure.fname)  = TRIM(wdetail2.deler)     AND
                TRIM(stat.insure.lname)  = TRIM(wdetail2.showroom)  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL stat.insure THEN DO:
                    ASSIGN  wdetail2.branch     = stat.insure.branch.
                END.
                ELSE DO: 
                    ASSIGN wdetail2.branch   = ""  . 
                END.  
        END.
        ELSE DO:
          FIND FIRST stat.insure USE-INDEX insure01 WHERE stat.insure.compno       = "TPIS"     AND       
                                                          TRIM(stat.insure.fname)  = TRIM(wdetail2.deler) NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL stat.insure THEN DO:
                    ASSIGN  wdetail2.branch  = stat.insure.branch.  
                END.
                ELSE DO:                                       
                    ASSIGN wdetail2.branch   = "" .  
                END.  
        END.
   
    END. /*wdetail */
    Run PD_ExportTM.
    RUN PD_ExportSF.
    RUN PD_ExportError.
END.
Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

