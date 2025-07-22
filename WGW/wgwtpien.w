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
/************************************************************************
  program id    :  wgwtpien.w
  program name :  Export Text file Endorsement    
  create by    :  Ranu i. A58-0489 19/09/2016  */
  /*Modify by  :  Kridtiya i .A68-0044 Date 02/05/2025  Add Driver 5 Person  */
/************************************************************************/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
def  stream  ns2.                                                                 
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO  
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
   FIELD address                 AS CHAR FORMAT "x(50)"         INIT ""      /*บ้านเลขที่*/
   FIELD build                   AS CHAR FORMAT "x(50)"         INIT ""      /*อาคาร*/
   FIELD mu                      AS CHAR FORMAT "x(50)"         INIT ""      /*หมู่บ้าน*/
   FIELD soi                     AS CHAR FORMAT "x(50)"         INIT ""      /*ซอย*/
   FIELD road                    AS CHAR FORMAT "x(50)"         INIT ""      /*ถนน*/
   FIELD tambon                  AS CHAR FORMAT "x(50)"         INIT ""      /*ตำบล*/
   FIELD amper                   AS CHAR FORMAT "x(50)"         INIT ""      /*อำเภอ*/
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
   FIELD stkno                   AS CHAR FORMAT "x(20)"         INIT ""      /* เลขสติ๊กเกอร์.*/
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
   FIELD mail_hno                AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_build              AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_mu                 AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_soi                AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_road               AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_tambon             AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_amper              AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_country            AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD mail_post               AS CHAR FORMAT "x(50)"         INIT ""      /*ที่อยู่จัดส่ง*/               
   FIELD send_date               AS CHAR FORMAT "x(20)"         INIT ""      /*วันที่จัดส่งกรมธรรม์*/        
   FIELD policy_no               AS CHAR FORMAT "x(20)"         INIT ""      /* เบอร์กรมธรรม์*/              
   FIELD send_data               AS CHAR FORMAT "x(20)"         INIT ""      /*วันที่จัดส่งข้อมูลให้ TPIS*/  
   FIELD REMARK1                 AS CHAR FORMAT "x(200)"        INIT ""      /*หมายเหตุ*/            
   FIELD occup                   AS CHAR FORMAT "x(20)"         INIT ""      /*อาชีพ*/  
   FIELD REC_STATUS              AS CHAR FORMAT "x(20)"   INIT ""           /*  REC_STATUS      */
   FIELD MDF_DTE                 AS CHAR FORMAT "x(10)"   INIT ""           /*  MDF_DTE         */
   FIELD MDF_RCV_DTE             AS CHAR FORMAT "x(10)"   INIT ""           /*  MDF_RCV_DTE     */
   FIELD MDF_RCV_RMK             AS CHAR FORMAT "x(80)"   INIT ""           /*  MDF_RCV_RMK     */
   FIELD IN_pol70                AS CHAR FORMAT "x(16)"   INIT ""                           
   FIELD IN_pol72                AS CHAR FORMAT "x(16)"   INIT ""                           
   FIELD MDF_RCV_RMK_thai       AS CHAR FORMAT "x(80)"   INIT ""     /*  MDF_RCV_RMK_thai  */
   FIELD MDF_RCV_RMK_thai2      AS CHAR FORMAT "x(80)"   INIT ""     /*  MDF_RCV_RMK_thai  */
   FIELD MDF_updata             AS CHAR FORMAT "x(100)"  INIT ""     /*  MDF_RCV_RMK_thai*/ 
   FIELD MDF_updata2            AS CHAR FORMAT "x(100)"  INIT ""     /*  MDF_RCV_RMK_thai*/  
   FIELD Driver1_title          AS CHAR FORMAT "x(60)"   INIT ""   /*A68-0044*/
   FIELD Driver1_name           AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/
   FIELD Driver1_lastname       AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/
   FIELD Driver1_birthdate      AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/
   FIELD Driver1_id_no          AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/
   FIELD Driver1_license_no     AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/
   FIELD Driver1_occupation     AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/
   FIELD Driver2_title          AS CHAR FORMAT "x(60)"   INIT ""   /*A68-0044*/ 
   FIELD Driver2_name           AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/ 
   FIELD Driver2_lastname       AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/ 
   FIELD Driver2_birthdate      AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/ 
   FIELD Driver2_id_no          AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/ 
   FIELD Driver2_license_no     AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/ 
   FIELD Driver2_occupation     AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/ 
   FIELD Driver3_title          AS CHAR FORMAT "x(60)"   INIT ""   /*A68-0044*/
   FIELD Driver3_name           AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/  
   FIELD Driver3_lastname       AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/  
   FIELD Driver3_birthday       AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/  
   FIELD Driver3_id_no          AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/  
   FIELD Driver3_license_no     AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/  
   FIELD Driver3_occupation     AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/  
   FIELD Driver4_title          AS CHAR FORMAT "x(60)"   INIT ""   /*A68-0044*/
   FIELD Driver4_name           AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/
   FIELD Driver4_lastname       AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/
   FIELD Driver4_birthdate      AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/
   FIELD Driver4_id_no          AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/
   FIELD Driver4_license_no     AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/
   FIELD Driver4_occupation     AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/
   FIELD Driver5_title          AS CHAR FORMAT "x(60)"   INIT ""   /*A68-0044*/
   FIELD Driver5_name           AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/
   FIELD Driver5_lastname       AS CHAR FORMAT "x(100)"  INIT ""   /*A68-0044*/
   FIELD Driver5_birthdate      AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/
   FIELD Driver5_id_no          AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/
   FIELD Driver5_license_no     AS CHAR FORMAT "x(30)"   INIT ""   /*A68-0044*/
   FIELD Driver5_occupation     AS CHAR FORMAT "x(100)"  INIT ""  . /*A68-0044*/

def var nv_row   as  int  init 0.
DEF VAR nv_name2 AS CHAR FORMAT "x(60)" INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok bu_file bu_exit ~
RECT-76 RECT-77 
&Scoped-Define DISPLAYED-OBJECTS fi_filename fi_outfile 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 94 BY 8.33
     BGCOLOR 10 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 3.76 COL 22.83 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 5.29 COL 22.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.95 COL 73
     bu_file AT ROW 3.76 COL 88.5
     bu_exit AT ROW 6.95 COL 83
     "               Input File :":30 VIEW-AS TEXT
          SIZE 21.67 BY 1.05 AT ROW 3.76 COL 3
          BGCOLOR 10 FGCOLOR 2 FONT 6
     "Output to excel(.slk)  :" VIEW-AS TEXT
          SIZE 21.67 BY 1.05 AT ROW 5.29 COL 3
          BGCOLOR 10 FGCOLOR 2 FONT 6
     "                                       Export Text file Endorsement (New format)" VIEW-AS TEXT
          SIZE 89.17 BY 1.43 AT ROW 1.76 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 32
     RECT-76 AT ROW 1 COL 1
     RECT-77 AT ROW 6.71 COL 72
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 94.5 BY 8.48
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
         TITLE              = "Endorsement file  to TPIS (New format)"
         HEIGHT             = 8.48
         WIDTH              = 94.5
         MAX-HEIGHT         = 33.71
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.71
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
ON END-ERROR OF C-Win /* Endorsement file  to TPIS (New format) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Endorsement file  to TPIS (New format) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
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
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Documents" "*.csv"
        
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        fi_filename  = cvData.
        DISP fi_filename WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    IF fi_filename = ""  THEN DO:
        MESSAGE "File in put name is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_filename.
        RETURN NO-APPLY.
    END.
    IF fi_outfile = ""  THEN DO:
        MESSAGE "File out put name is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_outfile.
        RETURN NO-APPLY.
    END.
    For each  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.ins_ytyp                      /*Ins. Year type               */   
            wdetail.bus_typ                       /*Business type                */ 
            wdetail.TASreceived                   /*TAS received by              */ 
            wdetail.InsCompany                    /*Ins company                  */ 
            wdetail.Insurancerefno                /*Insurance ref no.            */ 
            wdetail.tpis_no                       /*TPIS Contract No.            */ 
            wdetail.ntitle                        /*Title name                   */ 
            wdetail.insnam                        /*customer name                */ 
            wdetail.NAME2                         /*customer lastname            */ 
            wdetail.cust_type                     /*Customer type                */ 
            wdetail.nDirec                        /*Director Name                */ 
            wdetail.ICNO                          /*ID number                    */ 
            wdetail.address                       /*House no.                    */ 
            wdetail.build                         /*Building                     */ 
            wdetail.mu                            /*Village name/no.             */ 
            wdetail.soi                           /*Soi                          */ 
            wdetail.road                          /*Road                         */ 
            wdetail.tambon                        /*Sub-district                 */ 
            wdetail.amper                         /*District                     */ 
            wdetail.country                       /*Province                     */ 
            wdetail.post                          /*Postcode                     */ 
            wdetail.brand                         /*Brand                        */ 
            wdetail.model                         /*Car model                    */ 
            wdetail.class                         /*Insurance Code               */ 
            wdetail.md_year                       /*Model Year                   */ 
            wdetail.Usage                         /*Usage Type                   */ 
            wdetail.coulor                        /*Colour                       */ 
            wdetail.cc                            /*Car Weight (CC.)             */ 
            wdetail.regis_year                    /*Year                         */ 
            wdetail.engno                         /*Engine No.                   */ 
            wdetail.chasno                        /*Chassis No.                  */ 
            wdetail.Acc_CV                        /*Accessories (for CV)         */ 
            wdetail.Acc_amount                    /*Accessories amount           */ 
            wdetail.License                       /*License No.                  */ 
            wdetail.regis_CL                      /*Registered Car License       */ 
            wdetail.campaign                      /*Campaign                     */ 
            wdetail.typ_work                      /*Type of work                 */ 
            wdetail.si                            /*Insurance amount             */ 
            wdetail.pol_comm_date                 /*Insurance Date ( Voluntary ) */ 
            wdetail.pol_exp_date                  /*Expiry Date ( Voluntary)     */ 
            wdetail.LAST_pol                      /*Last Policy No. (Voluntary)  */ 
            wdetail.cover                         /*Insurance Type               */ 
            wdetail.pol_netprem                   /*Net premium (Voluntary)      */ 
            wdetail.pol_gprem                     /*Gross premium (Voluntary)    */ 
            wdetail.pol_stamp                     /*Stamp                        */ 
            wdetail.pol_vat                       /*VAT                          */ 
            wdetail.pol_wht                       /*WHT                          */ 
            wdetail.com_no                        /*Compulsory No.               */ 
            wdetail.com_comm_date                 /*Insurance Date ( Compulsory )*/ 
            wdetail.com_exp_date                  /*Expiry Date ( Compulsory)    */ 
            wdetail.com_netprem                   /*Net premium (Compulsory)     */ 
            wdetail.com_gprem                     /*Gross premium (Compulsory)   */ 
            wdetail.com_stamp                     /*Stamp                        */ 
            wdetail.com_vat                       /*VAT                          */ 
            wdetail.com_wht                       /*WHT                          */ 
            wdetail.deler                         /*Dealer                       */ 
            wdetail.showroom                      /*Showroom                     */ 
            wdetail.typepay                       /*Payment Type                 */ 
            wdetail.financename                   /*Beneficiery                  */ 
            wdetail.mail_hno                      /*Mailing House no.            */ 
            wdetail.mail_build                    /*Mailing  Building            */ 
            wdetail.mail_mu                       /*Mailing  Village name/no.    */ 
            wdetail.mail_soi                      /*Mailing Soi                  */ 
            wdetail.mail_road                     /*Mailing  Road                */ 
            wdetail.mail_tambon                   /*Mailing  Sub-district        */ 
            wdetail.mail_amper                    /*Mailing  District            */ 
            wdetail.mail_country                  /*Mailing Province             */ 
            wdetail.mail_post                     /*Mailing Postcode             */ 
            wdetail.send_date                     /*Policy no. to customer date  */ 
            wdetail.policy_no                     /*New policy no                */ 
            wdetail.send_data                     /*Insurer Stamp Date           */ 
            wdetail.REMARK1                       /*Remark                       */ 
            wdetail.occup                         /*Occupation code              */ 
            wdetail.REC_STATUS                    /*Record Status                */ 
            wdetail.MDF_DTE                       /*Modified Date                */ 
            wdetail.MDF_RCV_DTE                   /*Modify Received Date         */ 
            wdetail.MDF_RCV_RMK              /*Modify Received Remark       */
            wdetail.Driver1_title            /*A68-0044 */    
            wdetail.Driver1_name             /*A68-0044 */    
            wdetail.Driver1_lastname         /*A68-0044 */    
            wdetail.Driver1_birthdate        /*A68-0044 */    
            wdetail.Driver1_id_no            /*A68-0044 */    
            wdetail.Driver1_license_no       /*A68-0044 */    
            wdetail.Driver1_occupation       /*A68-0044 */    
            wdetail.Driver2_title            /*A68-0044 */      
            wdetail.Driver2_name             /*A68-0044 */      
            wdetail.Driver2_lastname         /*A68-0044 */      
            wdetail.Driver2_birthdate        /*A68-0044 */      
            wdetail.Driver2_id_no            /*A68-0044 */      
            wdetail.Driver2_license_no       /*A68-0044 */      
            wdetail.Driver2_occupation       /*A68-0044 */      
            wdetail.Driver3_title            /*A68-0044 */     
            wdetail.Driver3_name             /*A68-0044 */       
            wdetail.Driver3_lastname         /*A68-0044 */       
            wdetail.Driver3_birthday         /*A68-0044 */       
            wdetail.Driver3_id_no            /*A68-0044 */       
            wdetail.Driver3_license_no       /*A68-0044 */       
            wdetail.Driver3_occupation       /*A68-0044 */       
            wdetail.Driver4_title            /*A68-0044 */     
            wdetail.Driver4_name             /*A68-0044 */     
            wdetail.Driver4_lastname         /*A68-0044 */     
            wdetail.Driver4_birthdate        /*A68-0044 */     
            wdetail.Driver4_id_no            /*A68-0044 */     
            wdetail.Driver4_license_no       /*A68-0044 */     
            wdetail.Driver4_occupation       /*A68-0044 */     
            wdetail.Driver5_title            /*A68-0044 */     
            wdetail.Driver5_name             /*A68-0044 */     
            wdetail.Driver5_lastname         /*A68-0044 */     
            wdetail.Driver5_birthdate        /*A68-0044 */     
            wdetail.Driver5_id_no            /*A68-0044 */     
            wdetail.Driver5_license_no       /*A68-0044 */     
            wdetail.Driver5_occupation .      /*A68-0044 */  
    END.   /* repeat  */
    RUN  Pro_assign.
    Run  Pro_createfile.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
    fi_filename  =  Input  fi_filename.
    Disp  fi_filename  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
    fi_outfile  =  Input  fi_outfile.
    Disp  fi_outfile with frame  fr_main.
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
  
  gv_prgid = "wgwtpien".
  gv_prog  = "Export Text file Endorsement (new format) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  /*ASSIGN 
      ra_fileout   = 1.
  DISP ra_reptyp ra_fileout WITH FRAM fr_main.*/

  
  
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
  DISPLAY fi_filename fi_outfile 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok bu_file bu_exit RECT-76 RECT-77 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chk_text C-Win 
PROCEDURE proc_chk_text :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-- ตัด and ออกแล้ว ---*/
IF  INDEX(wdetail.MDF_RCV_RMK,"Change Insurance Amount") <> 0  THEN DO:
    ASSIGN                                           
    wdetail.MDF_RCV_RMK_thai = "แก้ไขทุนประกัน"  +  wdetail.MDF_RCV_RMK_thai2     
    wdetail.MDF_updata       =  TRIM(wdetail.si) +  wdetail.MDF_updata2.          
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change effective date") <> 0 THEN DO:
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "แก้ไขวันคุ้มครอง"    +  wdetail.MDF_RCV_RMK_thai2     
    wdetail.MDF_updata       =  trim(wdetail.pol_comm_date) +  " - " + TRIM(wdetail.pol_exp_date)  +  wdetail.MDF_updata2. 
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change prefix") <> 0 THEN DO:
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "เปลี่ยนคำนำหน้า" +  wdetail.MDF_RCV_RMK_thai2    
    wdetail.MDF_updata       = TRIM(wdetail.ntitle) + " " + trim(wdetail.insnam) + " " + TRIM(wdetail.NAME2)  
                               +  wdetail.MDF_updata2. 
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Add director") <> 0  THEN DO: 
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "เพิ่มชื่อกรรมการ"   +  wdetail.MDF_RCV_RMK_thai2 
    wdetail.MDF_updata       = trim(wdetail.nDirec) +  wdetail.MDF_updata2.      
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change director") <> 0   THEN DO:
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "เปลี่ยนชื่อกรรมการ"  +  wdetail.MDF_RCV_RMK_thai2 
    wdetail.MDF_updata       =  trim(wdetail.nDirec) +  wdetail.MDF_updata2.  
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change Engine") <> 0  THEN DO:
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "แก้ไขเลขเครื่อง" +  wdetail.MDF_RCV_RMK_thai2 
    wdetail.MDF_updata       = "เลขเครื่อง : " + trim(wdetail.engno) +  wdetail.MDF_updata2. 
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change Chassis") <> 0 THEN DO:
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "แก้ไขเลขเลขถัง" +  wdetail.MDF_RCV_RMK_thai2 
    wdetail.MDF_updata       = "เลขถัง : " + trim(wdetail.chasno) +  wdetail.MDF_updata2.      
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change finance") <> 0 THEN DO:
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "แก้ไขผู้รับผลประโยชน์"   +  wdetail.MDF_RCV_RMK_thai2 
    wdetail.MDF_updata       = trim(wdetail.financename) +  wdetail.MDF_updata2.      
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change customer name") <> 0 THEN DO:
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "แก้ไขชื่อผู้เอาประกัน"  +  wdetail.MDF_RCV_RMK_thai2   
    wdetail.MDF_updata       = trim(wdetail.insnam)  + " " + trim(wdetail.NAME2) + " " + nv_name2 +  wdetail.MDF_updata2.
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change customer surname") <> 0 THEN DO:
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "แก้ไขนามสกุล"  +  wdetail.MDF_RCV_RMK_thai2 
    wdetail.MDF_updata       = trim(wdetail.insnam) + " " + TRIM(wdetail.NAME2) + " " + nv_name2 +  wdetail.MDF_updata2.
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change customer address") <> 0  THEN DO:
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "เปลี่ยนที่อยู่ในการจัดส่งกรมธรรม์"  +  wdetail.MDF_RCV_RMK_thai2  .
    wdetail.MDF_updata   = IF trim(wdetail.mail_hno)    <> "" THEN trim(wdetail.mail_hno)    + " " ELSE "" .
    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_build)    <> "" THEN trim(wdetail.mail_build)  + " "  ELSE "" ). 
    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_mu)       <> "" THEN trim(wdetail.mail_mu)     + " "  ELSE "" ). 
    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_soi)      <> "" THEN trim(wdetail.mail_soi)    + " "  ELSE "" ).           
    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_road)     <> "" THEN trim(wdetail.mail_road)   + " "  ELSE "" ). 
    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_tambon)   <> "" THEN trim(wdetail.mail_tambon) + " "  ELSE "" ). 
    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_amper)    <> "" THEN trim(wdetail.mail_amper)  + " "  ELSE "" ). 
    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_country)  <> "" THEN trim(wdetail.mail_country) + " "  ELSE "").  
    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_post)     <> "" THEN trim(wdetail.mail_post) ELSE "" ) +  wdetail.MDF_updata2.
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Cancelles due to Ins.Company") <> 0  THEN DO:
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "ยกเลิกเนื่องจากเปลี่ยนบริษัท" +  wdetail.MDF_RCV_RMK_thai2       
    wdetail.MDF_updata       = "" +  wdetail.MDF_updata2.            
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Cancelled by dealer" ) <> 0   THEN DO:
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "ยกเลิก" +  wdetail.MDF_RCV_RMK_thai2       
    wdetail.MDF_updata       = "" +  wdetail.MDF_updata2.            
END.
ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change PRB.no.") <> 0  THEN DO: 
    ASSIGN 
    wdetail.MDF_RCV_RMK_thai = "แก้ไขเลขสติ๊กเกอร์" +  wdetail.MDF_RCV_RMK_thai2       
    wdetail.MDF_updata       = trim(wdetail.com_no) +  wdetail.MDF_updata2.            
END.
ELSE DO: 
    ASSIGN wdetail.MDF_RCV_RMK_thai = trim(wdetail.MDF_RCV_RMK) +  wdetail.MDF_RCV_RMK_thai2       
           wdetail.MDF_updata       = "" + wdetail.MDF_updata2.            
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_assign C-Win 
PROCEDURE pro_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_length AS INT INIT 0.
DEF VAR n_revday AS CHAR FORMAT "X(20)" INIT "".
FOR EACH wdetail.
    ASSIGN nv_name2  = ""       
           n_revday  = ""      
           n_length  = 0.

    IF      (INDEX(wdetail.ins_ytyp,"Ins") <> 0 OR INDEX(wdetail.ins_ytyp,"ins") <> 0 ) THEN DELETE wdetail.
    ELSE IF (wdetail.tpis_NO = ""   ) THEN DELETE wdetail.
    ELSE DO:
            IF INDEX(wdetail.typ_work,"V") <> 0 THEN DO:         
                FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                    sicuw.uwm100.cedpol = trim(wdetail.tpis_NO)  AND
                    sicuw.uwm100.poltyp = "V70"                     NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm100  THEN 
                    ASSIGN wdetail.IN_pol70 = sicuw.uwm100.policy 
                           nv_name2         = sicuw.uwm100.name2.
                ELSE ASSIGN wdetail.IN_pol70 = "".
            END.
            IF INDEX(wdetail.typ_work,"C") <> 0 THEN DO: 
                FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                    sicuw.uwm100.cedpol = trim(wdetail.tpis_NO) AND
                    sicuw.uwm100.poltyp = "V72" NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm100  THEN ASSIGN wdetail.IN_pol72 = sicuw.uwm100.policy .
                ELSE ASSIGN wdetail.IN_pol72 = "".
            END.
            
            IF INDEX(wdetail.financename,"cash") <> 0 OR INDEX(wdetail.financename,"CASH") <> 0 THEN ASSIGN wdetail.financename = "".
            IF wdetail.financename <> "" THEN DO:
                FIND FIRST stat.insure WHERE stat.insure.compno = "TPIS-LEAS"       AND 
                                         stat.insure.fname = wdetail.financename   OR
                                         stat.insure.lname = wdetail.financename   NO-LOCK NO-ERROR . 
                 IF AVAIL stat.insure THEN
                     ASSIGN wdetail.financename = stat.insure.addr1 + stat.insure.addr2.
                 ELSE 
                     ASSIGN wdetail.financename = wdetail.financename.
            END.
            IF INDEX(wdetail.MDF_RCV_RMK,"And") = 0  THEN DO: /* ไม่มี and */
                IF  INDEX(wdetail.MDF_RCV_RMK,"Change Insurance Amount") <> 0  THEN DO:
                    ASSIGN                                           
                    wdetail.MDF_RCV_RMK_thai = "แก้ไขทุนประกัน"      
                    wdetail.MDF_updata       =  TRIM(wdetail.si).    
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change effective date") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "แก้ไขวันคุ้มครอง" 
                    wdetail.MDF_updata       =  trim(wdetail.pol_comm_date) +  " - " + TRIM(wdetail.pol_exp_date) .
                END.                              
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change prefix") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "เปลี่ยนคำนำหน้า"
                    wdetail.MDF_updata       = TRIM(wdetail.ntitle) + " " + trim(wdetail.insnam) + " " + TRIM(wdetail.NAME2)  . 
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Add director") <> 0  THEN DO: 
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "เพิ่มชื่อกรรมการ" 
                    wdetail.MDF_updata       = trim(wdetail.nDirec).
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change director") <> 0   THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "เปลี่ยนชื่อกรรมการ" 
                    wdetail.MDF_updata       =  trim(wdetail.nDirec) .
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change Engine") <> 0  THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "แก้ไขเลขเครื่อง"
                    wdetail.MDF_updata       = "เลขเครื่อง : " + trim(wdetail.engno) .
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change Chassis") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "แก้ไขเลขเลขถัง"
                    wdetail.MDF_updata       = "เลขถัง : " + trim(wdetail.chasno) .
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change finance") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "แก้ไขผู้รับผลประโยชน์"
                    wdetail.MDF_updata       = trim(wdetail.financename).
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change customer name") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "แก้ไขชื่อผู้เอาประกัน" 
                    wdetail.MDF_updata       = trim(wdetail.insnam)  + " " + trim(wdetail.NAME2) + " " + nv_name2  .
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change customer surname") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "แก้ไขนามสกุล"
                    wdetail.MDF_updata       = trim(wdetail.insnam) + " " + TRIM(wdetail.NAME2) + " " + nv_name2 .
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change customer address") <> 0  THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "เปลี่ยนที่อยู่ในการจัดส่งกรมธรรม์".
                    wdetail.MDF_updata   = IF trim(wdetail.mail_hno)    <> "" THEN trim(wdetail.mail_hno)    + " " ELSE "" .
                    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_build)    <> "" THEN trim(wdetail.mail_build)  + " "  ELSE "" ). 
                    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_mu)       <> "" THEN trim(wdetail.mail_mu)     + " "  ELSE "" ). 
                    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_soi)      <> "" THEN trim(wdetail.mail_soi)    + " "  ELSE "" ).           
                    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_road)     <> "" THEN trim(wdetail.mail_road)   + " "  ELSE "" ). 
                    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_tambon)   <> "" THEN trim(wdetail.mail_tambon) + " "  ELSE "" ). 
                    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_amper)    <> "" THEN trim(wdetail.mail_amper)  + " "  ELSE "" ). 
                    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_country)  <> "" THEN trim(wdetail.mail_country) + " "  ELSE "").  
                    wdetail.MDF_updata   = wdetail.MDF_updata + (IF trim(wdetail.mail_post)     <> "" THEN trim(wdetail.mail_post) ELSE "" ).
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Cancelles due to Ins.Company") <> 0  THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "ยกเลิกเนื่องจากเปลี่ยนบริษัท" 
                    wdetail.MDF_updata       = "".
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Cancelled by dealer" ) <> 0   THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "ยกเลิก"
                    wdetail.MDF_updata       = "".
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"Change PRB.no.") <> 0  THEN DO: 
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai = "แก้ไขเลขสติ๊กเกอร์"
                    wdetail.MDF_updata       = trim(wdetail.com_no).
                END.
                ELSE DO: 
                    ASSIGN wdetail.MDF_RCV_RMK_thai = trim(wdetail.MDF_RCV_RMK)
                           wdetail.MDF_updata       = "".
                END.
            END.
            ELSE DO:    /*----- ถ้ามี and -----*/
                IF  INDEX(wdetail.MDF_RCV_RMK,"And Change Insurance Amount") <> 0  THEN DO:
                    ASSIGN                                           
                    wdetail.MDF_RCV_RMK_thai2 =  " / " + "แก้ไขทุนประกัน"      
                    wdetail.MDF_updata2       =  " / " + TRIM(wdetail.si)
                    wdetail.MDF_RCV_RMK       =  REPLACE(wdetail.MDF_RCV_RMK,"And Change Insurance Amount","").    
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Change effective date") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 = " / " + "แก้ไขวันคุ้มครอง" 
                    wdetail.MDF_updata2       = " / " + trim(wdetail.pol_comm_date) +  " - " + TRIM(wdetail.pol_exp_date)  
                    wdetail.MDF_RCV_RMK       = REPLACE(wdetail.MDF_RCV_RMK,"And Change effective date","").
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Change prefix") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 = " / " + "เปลี่ยนคำนำหน้า"
                    wdetail.MDF_updata2       = " / " + TRIM(wdetail.ntitle) + " " + trim(wdetail.insnam) + " " + TRIM(wdetail.NAME2)  
                    wdetail.MDF_RCV_RMK      = REPLACE(wdetail.MDF_RCV_RMK,"And Change prefix",""). 
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Add director") <> 0  THEN DO: 
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 = " / " + "เพิ่มชื่อกรรมการ" 
                    wdetail.MDF_updata2       = " / " +  trim(wdetail.nDirec) 
                    wdetail.MDF_RCV_RMK      = REPLACE(wdetail.MDF_RCV_RMK,"And Add director","").
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Change director") <> 0   THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 =  " / " + "เปลี่ยนชื่อกรรมการ" 
                    wdetail.MDF_updata2       =  " / " +  trim(wdetail.nDirec) 
                    wdetail.MDF_RCV_RMK       = REPLACE(wdetail.MDF_RCV_RMK,"And Change director","").
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Change Engine") <> 0  THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 = " / " + "แก้ไขเลขเครื่อง"
                    wdetail.MDF_updata2       = " / " + "เลขเครื่อง : " + trim(wdetail.engno) 
                    wdetail.MDF_RCV_RMK       = REPLACE(wdetail.MDF_RCV_RMK,"And Change Engine","").
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Change Chassis") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 = " / " + "แก้ไขเลขเลขถัง"
                    wdetail.MDF_updata2       = " / " + "เลขถัง : " + trim(wdetail.chasno) 
                    wdetail.MDF_RCV_RMK       = REPLACE(wdetail.MDF_RCV_RMK,"And Change Chassis","").
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Change finance") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 = " / " + "แก้ไขผู้รับผลประโยชน์"
                    wdetail.MDF_updata2       = " / " + trim(wdetail.financename)
                    wdetail.MDF_RCV_RMK       = REPLACE(wdetail.MDF_RCV_RMK,"And Change finance","").
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Change customer name") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 = " / " + "แก้ไขชื่อผู้เอาประกัน" 
                    wdetail.MDF_updata2       = " / " + trim(wdetail.insnam)  + " " + trim(wdetail.NAME2) + " " + nv_name2 
                    wdetail.MDF_RCV_RMK       = REPLACE(wdetail.MDF_RCV_RMK,"And Change customer name","").
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Change customer surname") <> 0 THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 = " / " + "แก้ไขนามสกุล"
                    wdetail.MDF_updata2       = " / " + trim(wdetail.insnam) + " " + TRIM(wdetail.NAME2) + " " + nv_name2 
                    wdetail.MDF_RCV_RMK      = REPLACE(wdetail.MDF_RCV_RMK,"And Change customer surname","").
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Change customer address") <> 0  THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 =  " / " + "เปลี่ยนที่อยู่ในการจัดส่งกรมธรรม์".
                    wdetail.MDF_updata2  = " / " + (IF trim(wdetail.mail_hno)    <> "" THEN trim(wdetail.mail_hno)    + " " ELSE "" ) .
                    wdetail.MDF_updata2  = wdetail.MDF_updata2 + (IF trim(wdetail.mail_build)    <> "" THEN trim(wdetail.mail_build)  + " "  ELSE "" ). 
                    wdetail.MDF_updata2  = wdetail.MDF_updata2 + (IF trim(wdetail.mail_mu)       <> "" THEN trim(wdetail.mail_mu)     + " "  ELSE "" ). 
                    wdetail.MDF_updata2  = wdetail.MDF_updata2 + (IF trim(wdetail.mail_soi)      <> "" THEN trim(wdetail.mail_soi)    + " "  ELSE "" ).           
                    wdetail.MDF_updata2  = wdetail.MDF_updata2 + (IF trim(wdetail.mail_road)     <> "" THEN trim(wdetail.mail_road)   + " "  ELSE "" ). 
                    wdetail.MDF_updata2  = wdetail.MDF_updata2 + (IF trim(wdetail.mail_tambon)   <> "" THEN trim(wdetail.mail_tambon) + " "  ELSE "" ). 
                    wdetail.MDF_updata2  = wdetail.MDF_updata2 + (IF trim(wdetail.mail_amper)    <> "" THEN trim(wdetail.mail_amper)  + " "  ELSE "" ). 
                    wdetail.MDF_updata2  = wdetail.MDF_updata2 + (IF trim(wdetail.mail_country)  <> "" THEN trim(wdetail.mail_country) + " "  ELSE "").  
                    wdetail.MDF_updata2  = wdetail.MDF_updata2 + (IF trim(wdetail.mail_post)     <> "" THEN trim(wdetail.mail_post) ELSE "" ).
                    wdetail.MDF_RCV_RMK  = REPLACE(wdetail.MDF_RCV_RMK,"And Change customer address","").
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Cancelles due to Ins.Company") <> 0  THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 = "  / " + "ยกเลิกเนื่องจากเปลี่ยนบริษัท" 
                    wdetail.MDF_updata2       = " / " + " "
                    wdetail.MDF_RCV_RMK      = REPLACE(wdetail.MDF_RCV_RMK,"And Cancelles due to Ins.Company","").
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Cancelled by dealer") <> 0   THEN DO:
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 =  " / " + "ยกเลิก"
                    wdetail.MDF_updata2       =  " / " + ""
                    wdetail.MDF_RCV_RMK      = REPLACE(wdetail.MDF_RCV_RMK,"And Cancelled by dealer","").
                
                END.
                ELSE IF INDEX(wdetail.MDF_RCV_RMK,"And Change PRB.no.") <> 0  THEN DO: 
                    ASSIGN 
                    wdetail.MDF_RCV_RMK_thai2 = " / " + "แก้ไขเลขสติ๊กเกอร์"
                    wdetail.MDF_updata2       = " / " + trim(wdetail.com_no)
                    wdetail.MDF_RCV_RMK      = REPLACE(wdetail.MDF_RCV_RMK,"And Change PRB.no.","").
                END.
                ELSE DO: 
                    ASSIGN wdetail.MDF_RCV_RMK_thai2 = " / " + trim(wdetail.MDF_RCV_RMK)
                           wdetail.MDF_updata2       = " / " + "".
                END.
                RUN proc_chk_text.
            END. /* if and */
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile C-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  Then
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN nv_row   =  1 .
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   "Ins. Year type               "    '"' SKIP. /*  ID              */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   "Business type                "    '"' SKIP. /*  TAS_RCV_DAY     */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   "TAS received by              "    '"' SKIP. /*  TAS_RCV_MONTH   */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   "Ins company                  "    '"' SKIP. /*  TAS_RCV_YEAR    */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   "Insurance ref no.            "    '"' SKIP. /*  TAS_RUN_NO      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   "TPIS Contract No.            "    '"' SKIP. /*  TAS_RCV_BY      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   "Title name                   "    '"' SKIP. /*  INSURACE_COM1   */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   "customer name                "    '"' SKIP. /*  INS_REF_NO      */  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   "customer lastname            "    '"' SKIP. /*  INF_INS_DAY     */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   "Customer type                "    '"' SKIP. /*  INF_INS_MONTH   */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   "Director Name                "    '"' SKIP. /*  INF_INS_YEAR    */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   "ID number                    "    '"' SKIP. /*  CUST_FNM        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   "House no.                    "    '"' SKIP. /*  CUST_LNM        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   "Building                     "    '"' SKIP. /*  ID_NUM          */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   "Village name/no.             "    '"' SKIP. /*  ADDRESS1        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   "Soi                          "    '"' SKIP. /*  ADDRESS2        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   "Road                         "    '"' SKIP. /*  SOI             */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   "Sub-district                 "    '"' SKIP. /*  ROAD            */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   "District                     "    '"' SKIP. /*  SUB_DISTRICT    */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   "Province                     "    '"' SKIP. /*  DISTRICT        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   "Postcode                     "    '"' SKIP. /*  PROVINCE        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   "Brand                        "    '"' SKIP. /*  ZIP_CD          */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   "Car model                    "    '"' SKIP. /*  TELEPHONE       */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   "Insurance Code               "    '"' SKIP. /*  SALES_MODEL     */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   "Model Year                   "    '"' SKIP. /*  USAGE_TYPE      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   "Usage Type                   "    '"' SKIP. /*  COLOR_THAI      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   "Colour                       "    '"' SKIP. /*  CC              */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   "Car Weight (CC.)             "    '"' SKIP. /*  EGN_NO          */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   "Year                         "    '"' SKIP. /*  CHASSIS_NO      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   "Engine No.                   "    '"' SKIP. /*  INSURANCE_COM2  */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   "Chassis No.                  "    '"' SKIP. /*  COVER_INS_DAY   */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   "Accessories (for CV)         "    '"' SKIP. /*  COVER_INS_MONTH */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   "Accessories amount           "    '"' SKIP. /*  COVER_INS_YEAR  */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'   "License No.                  "    '"' SKIP. /*  INS_FUND        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'   "Registered Car License       "    '"' SKIP. /*  INS_FEE         */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'   "Campaign                     "    '"' SKIP. /*  INS_NO          */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'   "Type of work                 "    '"' SKIP. /*  TIS_DEALER      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'   "Insurance amount             "    '"' SKIP. /*  SHOWROOM        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'   "Insurance Date (Voluntary ) "     '"' SKIP. /*  PURCHASE_TYPE   */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'   "Expiry Date ( Voluntary)     "    '"' SKIP. /*  FINANCE_COMP    */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'   "Last Policy No. (Voluntary)  "    '"' SKIP. /*  INF_FNM         */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'   "Insurance Type               "    '"' SKIP. /*  INF_LNM         */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'   "Net premium (Voluntary)      "    '"' SKIP. /*  INF_PHONE       */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'   "Gross premium (Voluntary)    "    '"' SKIP. /*  INF_POSITION    */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'   "Stamp                        "    '"' SKIP. /*  INF_REMARK      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'   "VAT                          "    '"' SKIP. /*  CHECK_ENG       */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'   "WHT                          "    '"' SKIP. /*  REC_STATUS      */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'   "Compulsory No.               "    '"' SKIP. /*  MDF_DTE         */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'   "Insurance Date (Compulsory)"      '"' SKIP. /*  MDF_RCV_DTE     */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'   "Expiry Date ( Compulsory)    "    '"' SKIP. /*  MDF_RCV_RMK     */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'   "Net premium (Compulsory)     "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'   "Gross premium (Compulsory)   "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'   "Stamp                        "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'   "VAT                          "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'   "WHT                          "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'   "Dealer                       "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'   "Showroom                     "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'   "Payment Type                 "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'   "Beneficiery                  "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'   "Mailing House no.            "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"'   "Mailing  Building            "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"'   "Mailing  Village name/no.    "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"'   "Mailing Soi                  "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"'   "Mailing  Road                "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"'   "Mailing  Sub-district        "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"'   "Mailing  District            "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"'   "Mailing Province             "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"'   "Mailing Postcode             "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"'   "Policy no. to customer date  "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"'   "New policy no                "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"'   "Insurer Stamp Date           "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"'   "Remark                       "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"'   "Record Status                "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"'   "Modified Date                "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"'   "Modify Received Date         "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"'   "Modify Received Remark       "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"'   "Policy No. (70)"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"'   "Policy No. (72)"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"'   "MDF_RCV_RMK (Thail)"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"'   "แก้ไขข้อมูลจากเดิมเป็น"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"'   "Driver1_title  "       '"' SKIP.  /*A68-0044 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"'   "Driver1_name      "    '"' SKIP.  /*A68-0044 */    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"'   "Driver1_lastname  "    '"' SKIP.  /*A68-0044 */    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"'   "Driver1_birthdate "    '"' SKIP.  /*A68-0044 */    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"'   "Driver1_id_no     "    '"' SKIP.  /*A68-0044 */    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"'   "Driver1_license_no"    '"' SKIP.  /*A68-0044 */    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"'   "Driver1_occupation"    '"' SKIP.  /*A68-0044 */    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"'   "Driver2_title     "    '"' SKIP.  /*A68-0044 */      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"'   "Driver2_name      "    '"' SKIP.  /*A68-0044 */      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"'   "Driver2_lastname  "    '"' SKIP.  /*A68-0044 */      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"'   "Driver2_birthdate "    '"' SKIP.  /*A68-0044 */      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"'   "Driver2_id_no     "    '"' SKIP.  /*A68-0044 */      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"'   "Driver2_license_no"    '"' SKIP.  /*A68-0044 */      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"'   "Driver2_occupation"    '"' SKIP.  /*A68-0044 */      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K" '"'   "Driver3_title     "    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K" '"'   "Driver3_name      "    '"' SKIP.  /*A68-0044 */       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K" '"'   "Driver3_lastname  "    '"' SKIP.  /*A68-0044 */       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K" '"'   "Driver3_birthday  "    '"' SKIP.  /*A68-0044 */       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K" '"'   "Driver3_id_no     "    '"' SKIP.  /*A68-0044 */       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"'  "Driver3_license_no"    '"' SKIP.  /*A68-0044 */       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"'  "Driver3_occupation"    '"' SKIP.  /*A68-0044 */       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"'  "Driver4_title     "    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"'  "Driver4_name      "    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"'  "Driver4_lastname  "    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"'  "Driver4_birthdate "    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"'  "Driver4_id_no     "    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"'  "Driver4_license_no"    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"'  "Driver4_occupation"    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"'  "Driver5_title     "    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"'  "Driver5_name      "    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"'  "Driver5_lastname  "    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"'  "Driver5_birthdate "    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"'  "Driver5_id_no     "    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X114;K" '"'  "Driver5_license_no"    '"' SKIP.  /*A68-0044 */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X115;K" '"'  "Driver5_occupation"    '"' SKIP.  /*A68-0044 */  
RUN Pro_createfile22.
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
message "Export File  Complete"  view-as alert-box.
/*---------------------------------------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile22 C-Win 
PROCEDURE Pro_createfile22 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail NO-LOCK .  
    ASSIGN nv_row  =  nv_row + 1.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetail.ins_ytyp          '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetail.bus_typ           '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetail.TASreceived       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail.InsCompany        '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail.Insurancerefno    '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetail.tpis_no           '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetail.ntitle            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail.insnam            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail.NAME2             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'  wdetail.cust_type         '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'  wdetail.nDirec            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'  wdetail.ICNO              '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'  wdetail.address           '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'  wdetail.build             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'  wdetail.mu                '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'  wdetail.soi               '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'  wdetail.road              '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'  wdetail.tambon            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'  wdetail.amper             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'  wdetail.country           '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'  wdetail.post              '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'  wdetail.brand             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'  wdetail.model             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'  wdetail.class             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'  wdetail.md_year           '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'  wdetail.Usage             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'  wdetail.coulor            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'  wdetail.cc                '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'  wdetail.regis_year        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'  wdetail.engno             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'  wdetail.chasno            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'  wdetail.Acc_CV            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'  wdetail.Acc_amount        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'  wdetail.License           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'  wdetail.regis_CL          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'  wdetail.campaign          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'  wdetail.typ_work          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'  wdetail.si                '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'  wdetail.pol_comm_date     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'  wdetail.pol_exp_date      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'  wdetail.LAST_pol          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'  wdetail.cover             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'  wdetail.pol_netprem       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'  wdetail.pol_gprem         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'  wdetail.pol_stamp         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'  wdetail.pol_vat           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'  wdetail.pol_wht           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'  wdetail.com_no            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'  wdetail.com_comm_date     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'  wdetail.com_exp_date      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'  wdetail.com_netprem       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'  wdetail.com_gprem         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'  wdetail.com_stamp         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'  wdetail.com_vat           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'  wdetail.com_wht           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'  wdetail.deler             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'  wdetail.showroom          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'  wdetail.typepay           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'  wdetail.financename       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'  wdetail.mail_hno          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"'  wdetail.mail_build        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"'  wdetail.mail_mu           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"'  wdetail.mail_soi          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"'  wdetail.mail_road         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"'  wdetail.mail_tambon       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"'  wdetail.mail_amper        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"'  wdetail.mail_country      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"'  wdetail.mail_post         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"'  wdetail.send_date         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"'  wdetail.policy_no         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"'  wdetail.send_data         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"'  wdetail.REMARK1           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"'  wdetail.REC_STATUS        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"'  wdetail.MDF_DTE           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"'  wdetail.MDF_RCV_DTE       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"'  wdetail.MDF_RCV_RMK       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"'  wdetail.IN_pol70          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"'  wdetail.IN_pol72          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"'  wdetail.MDF_RCV_RMK_thai FORMAT "x(100)" '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"'  wdetail.MDF_updata       FORMAT "X(150)"    '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"'  wdetail.Driver1_title        '"' SKIP.   /*A68-0044 */    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"'  wdetail.Driver1_name         '"' SKIP.   /*A68-0044 */    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"'  wdetail.Driver1_lastname     '"' SKIP.   /*A68-0044 */    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"'  wdetail.Driver1_birthdate    '"' SKIP.   /*A68-0044 */    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"'  wdetail.Driver1_id_no        '"' SKIP.   /*A68-0044 */    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"'  wdetail.Driver1_license_no   '"' SKIP.   /*A68-0044 */    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"'  wdetail.Driver1_occupation   '"' SKIP.   /*A68-0044 */    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"'  wdetail.Driver2_title        '"' SKIP.   /*A68-0044 */      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"'  wdetail.Driver2_name         '"' SKIP.   /*A68-0044 */      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"'  wdetail.Driver2_lastname     '"' SKIP.   /*A68-0044 */      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"'  wdetail.Driver2_birthdate    '"' SKIP.   /*A68-0044 */      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"'  wdetail.Driver2_id_no        '"' SKIP.   /*A68-0044 */      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"'  wdetail.Driver2_license_no   '"' SKIP.   /*A68-0044 */      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"'  wdetail.Driver2_occupation   '"' SKIP.   /*A68-0044 */      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K" '"'  wdetail.Driver3_title        '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K" '"'  wdetail.Driver3_name         '"' SKIP.   /*A68-0044 */       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K" '"'  wdetail.Driver3_lastname     '"' SKIP.   /*A68-0044 */       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K" '"'  wdetail.Driver3_birthday     '"' SKIP.   /*A68-0044 */       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K" '"'  wdetail.Driver3_id_no        '"' SKIP.   /*A68-0044 */       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"' wdetail.Driver3_license_no   '"' SKIP.   /*A68-0044 */       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"' wdetail.Driver3_occupation   '"' SKIP.   /*A68-0044 */       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"' wdetail.Driver4_title        '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"' wdetail.Driver4_name         '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"' wdetail.Driver4_lastname     '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"' wdetail.Driver4_birthdate    '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"' wdetail.Driver4_id_no        '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"' wdetail.Driver4_license_no   '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"' wdetail.Driver4_occupation   '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"' wdetail.Driver5_title        '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"' wdetail.Driver5_name         '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"' wdetail.Driver5_lastname     '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"' wdetail.Driver5_birthdate    '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"' wdetail.Driver5_id_no        '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X114;K" '"' wdetail.Driver5_license_no   '"' SKIP.   /*A68-0044 */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X115;K" '"' wdetail.Driver5_occupation   '"' SKIP.   /*A68-0044 */  
                                                                                      
END.    /*  end  wdetail  */                                                          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

