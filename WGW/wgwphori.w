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
/*Local Variable Definitions ---                                            */ 
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */ 
/*Program name     : Match Text file Phone to excel file                    */  
/*create by        : Kridtiya il. A55-0046  03/02/2012                      */  
/*                   Match file confirm to file Load Text เป็นไฟล์excel     */  
/*Modify by        : Kridtiya i. A56-0024  เพิ่มคอลัมน์ ดีเลอร์โค๊ต         */
/*Modify by        : Phaiboon W. A59-0488  เพิ่ม Field ตาม Format load text */
/*Modify by       : Ranu I. A62-0219 date 14/05/2019 เพิ่มตัวแปรรับค่าจากไฟล์ */
/*-------------------------------------------------------------------------------*/
DEF  stream  ns1.
DEFINE VAR   nv_daily        AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_reccnt       AS  INT  INIT  0.
DEFINE VAR   nv_completecnt  AS   INT   INIT  0.
DEFINE VAR   nv_enttim       AS  CHAR          INIT  "".
def    var   nv_export       as  date  init  ""  format "99/99/9999".
def  stream  ns2.
DEFINE VAR   nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEF VAR n_poltyp  AS CHAR INIT "".
DEF VAR nv_brnpol AS CHAR INIT "".
DEF VAR n_undyr2  AS CHAR INIT "".
DEF VAR n_brsty   AS CHAR INIT "".
DEF VAR n_br      AS CHAR INIT "" FORMAT "x(5)" .
DEFINE VAR nv_check    AS   CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check70  AS   CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check72  AS   CHARACTER  INITIAL ""  NO-UNDO.
DEF VAR n_name     AS CHAR FORMAT "x(100)" .
DEF VAR n_namefile AS CHAR FORMAT "x(100)" .
DEF VAR n_chk      AS LOGICAL INIT YES.
DEF VAR nv_notno70 AS CHAR FORMAT "x(12)".
DEF VAR nv_notno72 AS CHAR FORMAT "x(12)".
DEF BUFFER bftlt FOR brstat.tlt.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD recno          AS CHAR FORMAT "X(10)"  INIT ""  /*1  ลำดับที่            */
    FIELD Notify_dat     AS CHAR FORMAT "X(10)"  INIT ""  /*2  วันที่รับแจ้ง       */
    FIELD time_notify    AS CHAR FORMAT "X(10)"  INIT ""  /*3  เวลารับแจ้ง         */
    FIELD notifyno       AS CHAR FORMAT "X(50)"  INIT ""  /*4  เลขรับแจ้งงาน       */
    FIELD comp_code      AS CHAR FORMAT "X(20)"  INIT ""  /*5  รหัสบรษัท           */
    FIELD NAME_mkt       AS CHAR FORMAT "X(60)"  INIT ""  /*6  ชื่อเจ้าหน้าที่ MKT */
    FIELD cmbr_no        AS CHAR FORMAT "X(100)" INIT ""  /*7  รหัสสาขา            */
    FIELD cmbr_code      AS CHAR FORMAT "X(45)"  INIT ""  /*8  Code:               */
    FIELD branch         AS CHAR FORMAT "X(10)"  INIT ""  /*9  รหัสสาขา_STY        */
    FIELD producer       AS CHAR FORMAT "X(15)"  INIT ""  /*10 Producer.           */
    FIELD agent          AS CHAR FORMAT "X(15)"  INIT ""  /*11 Agent.              */
    FIELD deler          AS CHAR FORMAT "X(10)"  INIT ""  /*   deler               */
    FIELD campaigno      AS CHAR FORMAT "X(30)"  INIT ""  /*12 Campaign no.        */
    FIELD cov_car        AS CHAR FORMAT "X(20)"  INIT ""  /*13 ประเภทประกัน        */
    FIELD cov_new        AS CHAR FORMAT "X(40)"  INIT ""  /*14 ประเภทรถ            */
    FIELD covcod         AS CHAR FORMAT "X(10)"  INIT ""  /*15 ประเภทความคุ้มครอง  */
    FIELD product        AS CHAR FORMAT "X(30)"  INIT ""  /*16 Product Type        */
    FIELD freeprem       AS CHAR FORMAT "X(20)"  INIT "" /*17 ประกัน แถม/ไม่แถม   */
    FIELD freecomp       AS CHAR FORMAT "X(20)"  INIT ""  /*18 พรบ.   แถม/ไม่แถม   */
    FIELD comdat         AS CHAR FORMAT "X(10)"  INIT ""  /*19 วันเริ่มคุ้มครอง    */
    FIELD expdat         AS CHAR FORMAT "X(10)"  INIT ""  /*20 วันสิ้นสุดความคุ้มครอง */
    FIELD ispno          AS CHAR FORMAT "X(45)"  INIT ""  /*21 เลขตรวจสภาพ            */
    FIELD pol70          AS CHAR FORMAT "X(20)"  INIT ""  /*22 เลขกรมธรรม์70          */
    FIELD pol72          AS CHAR FORMAT "X(20)"  INIT ""  /*  23  เลขกรมธรรม์72          */
    FIELD n_TITLE        AS CHAR FORMAT "X(20)"  INIT ""  /*  24  คำนำหน้าชื่อ           */
    FIELD n_name1        AS CHAR FORMAT "X(80)"  INIT ""  /*  25  ชื่อผู้เอาประกัน       */
    FIELD idno           AS CHAR FORMAT "X(20)"  INIT ""  /*A55-0257*/
    FIELD birthday       AS CHAR FORMAT "X(10)"  INIT ""  /*A55-0257*/
    FIELD birthdayexp    AS CHAR FORMAT "X(10)"  INIT ""  /*A55-0257*/
    FIELD occup          AS CHAR FORMAT "X(50)"  INIT ""  /*A55-0257*/
    FIELD namedirect     AS CHAR FORMAT "X(80)"  INIT ""  /*A55-0257*/
    FIELD ADD_1          AS CHAR FORMAT "X(80)"  INIT ""  /*  26  บ้านเลขที่             */
    FIELD ADD_2          AS CHAR FORMAT "X(50)"  INIT ""  /*  27  ตำบล/แขวง              */
    FIELD ADD_3          AS CHAR FORMAT "X(30)"  INIT ""  /*  28  อำเภอ/เขต              */
    FIELD ADD_4          AS CHAR FORMAT "X(30)"  INIT ""  /*  29  จังหวัด                */
    FIELD ADD_5          AS CHAR FORMAT "X(10)"  INIT ""  /*  30  รหัสไปรษณีย์           */
    FIELD tel            AS CHAR FORMAT "X(35)"  INIT ""  /*  31  เบอร์โทรศัพท์          */
    FIELD typ_driv       AS CHAR FORMAT "X(35)"  INIT ""        
    FIELD drivname1      AS CHAR FORMAT "X(60)"  INIT ""
    FIELD sex1           AS CHAR FORMAT "X(10)"  INIT ""   
    FIELD birthdriv1     AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD occup1         AS CHAR FORMAT "X(50)"  INIT ""
    FIELD drivno1        AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD drivname2      AS CHAR FORMAT "X(60)"  INIT "" 
    FIELD sex2           AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD birthdriv2     AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD occup2         AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD drivno2        AS CHAR FORMAT "X(30)"  INIT ""
    FIELD redbook        AS CHAR FORMAT "X(30)"  INIT ""  /*  32  Redbook  */   
    FIELD brand          AS CHAR FORMAT "X(30)"  INIT ""  /*  32  ชื่อยี่ห้อรถ           */
    FIELD model          AS CHAR FORMAT "X(50)"  INIT ""  /*  33  รุ่นรถ                 */
    FIELD engine         AS CHAR FORMAT "X(30)"  INIT ""  /*  34  เลขเครื่องยนต์         */
    FIELD chassis        AS CHAR FORMAT "X(30)"  INIT ""  /*  35  เลขตัวถัง              */
    FIELD power          AS CHAR FORMAT "X(10)"  INIT ""  /*  36  ซีซี                   */
    FIELD cyear          AS CHAR FORMAT "X(10)"  INIT ""  /*  37  ปีรถยนต์               */
    FIELD licence        AS CHAR FORMAT "X(20)"  INIT ""  /*  38  เลขทะเบียน             */
    FIELD provin         AS CHAR FORMAT "X(40)"  INIT ""  /*  39  จังหวัดที่จดทะเบียน    */
    FIELD subclass       AS CHAR FORMAT "X(10)"  INIT ""  /*  40  แพคเกจ                 */
    FIELD garage         AS CHAR FORMAT "X(10)"  INIT ""  /*  41  การซ่อม                */
    FIELD ins_amt1       AS CHAR FORMAT "X(30)"  INIT ""  /*  42  ทุนประกัน              */
    FIELD fi             AS CHAR FORMAT "X(30)"  INIT ""  /*  42  ทุนสูญหาย              */
    FIELD prem1          AS CHAR FORMAT "X(30)"  INIT ""  /*  43  เบี้ยสุทธิ             */
    FIELD prem2          AS CHAR FORMAT "X(30)"  INIT ""  /*  44  เบี้ยประกัน            */
    FIELD comprem        AS CHAR FORMAT "X(30)"  INIT ""  /*  45  เบี้ยพรบ.              */
    FIELD prem3          AS CHAR FORMAT "X(30)"  INIT ""  /*  46  เบี้ยรวม               */
    FIELD deduct         AS CHAR FORMAT "X(30)"  INIT ""  /*  add kridtiya i. A57-0063   */
    FIELD sck            AS CHAR FORMAT "X(30)"  INIT ""  /*  47  เลขสติ๊กเกอร์          */
    FIELD ref            AS CHAR FORMAT "X(30)"  INIT ""  /*  48  เลขReferance no.       */
    FIELD recivename     AS CHAR FORMAT "X(60)"  INIT ""  /*  49  ออกใบเสร็จในนาม        */
    FIELD vatcode        AS CHAR FORMAT "X(15)"  INIT ""  /*  50  Vatcode                */
    FIELD notiuser       AS CHAR FORMAT "X(60)"  INIT ""  /*  51  ผู้รับแจ้ง             */
    FIELD notbr          AS CHAR FORMAT "x(25)"  INIT ""  /*  สาขาที่รับแจ้ง */ /*A62-0219*/
    FIELD bennam         AS CHAR FORMAT "X(80)"  INIT ""  /*  52  ผู้รับผลประโยชน์       */
    FIELD remak1         AS CHAR FORMAT "X(100)" INIT ""  /*  53  หมายเหตุ               */
    FIELD statusco       AS CHAR FORMAT "X(30)"  INIT ""  /*  54  complete/not complete  */
    FIELD releas         AS CHAR FORMAT "X(10)"  INIT ""  /*  55  Yes/No                 */
    FIELD remak2         AS CHAR FORMAT "X(100)" INIT ""   
    FIELD other1         AS CHAR FORMAT "X(50)"  INIT ""   
    FIELD other2         AS CHAR FORMAT "X(10)"  INIT ""   
    FIELD other3         AS CHAR FORMAT "X(60)"  INIT ""   
    FIELD quotation      AS CHAR FORMAT "X(20)"  INIT ""   
    FIELD ngarage        AS CHAR FORMAT "X(20)"  INIT ""   
    FIELD ispstatus      AS CHAR FORMAT "X(1)"   INIT ""   
    FIELD tp             as char format "x(15)" init "" 
    FIELD ta             as char format "x(15)" init "" 
    FIELD td             as char format "x(15)" init "" 
    FIELD n41            as char format "x(15)" init "" 
    FIELD n42            as char format "x(15)" init "" 
    FIELD n43            as char format "x(15)" init "" 
    FIELD docno          as char format "x(10)" init "" 
    FIELD reinsp         as char format "x(255)" init "" .

DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO
    FIELD n_no          AS CHAR FORMAT "X(3)"   INIT ""  /*No                   */          
    FIELD Pro_off       AS CHAR FORMAT "X(10)"  INIT ""  /*InsComp              */          
    FIELD branch        AS CHAR FORMAT "X(20)"   INIT ""  /*OffCde               */          
    FIELD safe_no       AS CHAR FORMAT "X(18)"  INIT ""  /*InsuranceReceivedNo  */          
    FIELD Account_no    AS CHAR FORMAT "X(12)"  INIT ""  /*ApplNo               */          
    FIELD name_insur    AS CHAR FORMAT "X(100)" INIT ""  /*CustName             */          
    FIELD icno          AS CHAR FORMAT "X(13)"  INIT ""  /*IDNo                 */          
    FIELD garage        AS CHAR FORMAT "X(2)"   INIT ""  /*RepairType           */          
    FIELD CustAge       AS CHAR FORMAT "X(2)"   INIT ""  /*CustAge              */          
    FIELD Category      AS CHAR FORMAT "X(50)"   INIT ""  /*Category             */          
    FIELD CarType       AS CHAR FORMAT "X(30)"   INIT ""  /*CarType              */          
    FIELD brand         AS CHAR FORMAT "X(30)"  INIT ""  /*Brand                */          
    FIELD Brand_Model   AS CHAR FORMAT "X(30)"  INIT ""  /*Model                */          
    FIELD CC            AS CHAR FORMAT "X(10)"  INIT ""  /*CC                   */          
    FIELD yrmanu        AS CHAR FORMAT "X(5)"   INIT ""  /*CarYear              */          
    FIELD RegisDate     AS CHAR FORMAT "X(15)"  INIT ""  /*RegisDate            */          
    FIELD engine        AS CHAR FORMAT "X(15)"  INIT ""  /*EngineNo             */          
    FIELD chassis       AS CHAR FORMAT "X(15)"  INIT ""  /*ChassisNo            */          
    FIELD RegisNo       AS CHAR FORMAT "X(13)"  INIT ""  /*RegisNo              */          
    FIELD RegisProv     AS CHAR FORMAT "X(25)"  INIT ""  /*RegisProv            */          
    FIELD n_class       AS CHAR FORMAT "X(5)"   INIT ""  /*InsLicTyp            */          
    FIELD InsTyp        AS CHAR FORMAT "X(30)"   INIT ""  /*InsTyp               */          
    FIELD CovTyp        AS CHAR FORMAT "X(30)"   INIT ""  /*CovTyp               */          
    FIELD SI            AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceAmt (crash) */          
    FIELD FI            AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceAmt (loss)  */          
    FIELD comdat        AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceStartDate   */          
    FIELD expdat        AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceExpireDate  */          
    FIELD netprem       AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceNetFee      */          
    FIELD totalprem     AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceFee         */          
    FIELD comtyp        AS CHAR FORMAT "X(10)"  INIT ""  /*พรบ. แถม/ไม่แถม      */          
    FIELD ben_name      AS CHAR FORMAT "X(50)"  INIT ""  /*Beneficiary          */          
    FIELD CMRName       AS CHAR FORMAT "X(50)"  INIT ""  /*CMRName              */          
    FIELD sckno         AS CHAR FORMAT "X(13)"  INIT ""  /*InsurancePolicyNo    */          
    FIELD comdat72      AS CHAR FORMAT "X(15)"  INIT ""  /*LawInsStartDate      */          
    FIELD expdat72      AS CHAR FORMAT "X(15)"  INIT ""  /*LawInsEndDate        */          
    FIELD comp_prm      AS CHAR FORMAT "X(10)"  INIT ""  /*LawInsFee            */          
    FIELD Remark        AS CHAR FORMAT "X(255)" INIT ""  /*Other                */          
    FIELD DealerName    AS CHAR FORMAT "X(60)"  INIT ""  /*DealerName           */          
    FIELD CustAddress   AS CHAR FORMAT "X(150)" INIT ""  /*CustAddress          */          
    FIELD CustTel       AS CHAR FORMAT "X(30)"  INIT ""  /*CustTel              */  
    FIELD prevpol       AS CHAR FORMAT "x(13)"  INIT ""
    FIELD cl            AS CHAR FORMAT "X(15)"  INIT ""           /*ส่วนลดประวัติเสีย     */           
    FIELD fleetper      AS CHAR FORMAT "X(15)"  INIT ""           /*ส่วนลดกลุ่ม           */           
    FIELD ncbper        AS CHAR FORMAT "X(15)"  INIT ""           /*ประวัติดี             */           
    FIELD othper        AS CHAR FORMAT "x(15)"  INIT ""           /*อื่น ๆ                */           
    FIELD pol_addr1     as char format "x(150)" init ""           /*ที่อยู่ลูกค้า         */           
    FIELD icno_st       as char format "x(15)"  init ""           /*DateCARD_S            */           
    FIELD icno_ex       as char format "x(15)"  init ""           /*DateCARD_E            */           
    FIELD paid          as char format "x(50)"  init ""           /*Type_Paid_1           */           
    FIELD addr1         as char format "x(35)"  init ""                                        
    FIELD addr2         as char format "x(35)"  init ""
    FIELD addr3         as char format "x(35)"  init ""
    FIELD addr4         as char format "x(35)"  init ""
    FIELD pol_title     as char format "x(15)"  init ""
    FIELD pol_fname     as char format "x(50)"  init ""
    FIELD pol_lname     as char format "x(50)"  init ""
    FIELD not_time      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD branch_saf    AS CHAR FORMAT "x(2)"   INIT ""
    FIELD comp_prmtotal AS CHAR FORMAT "x(10)"  INIT ""
    FIELD producer      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD n_class70     AS CHAR FORMAT "x(5)"   INIT ""
    FIELD otherins      AS CHAR FORMAT "x(100)" INIT ""
    FIELD campaign      AS CHAR FORMAT "x(20)"  INIT ""
    FIELD compno        AS CHAR FORMAT "x(13)"  INIT ""
    FIELD saleid        AS CHAR FORMAT "x(15)"  INIT ""
    FIELD taxname       AS CHAR FORMAT "x(50)"  INIT ""
    FIELD taxno         AS CHAR FORMAT "x(15)"  INIT ""
    FIELD n_color       AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD accsor        as CHAR FORMAT "X(120)" INIT ""
    FIELD accsor_price  as CHAR FORMAT "X(15)"  INIT ""
    FIELD drivname1     as char format "x(60)"  init ""
    FIELD drivdate1     as char format "x(15)"  init ""
    FIELD drivid1       as char format "x(15)"  init ""
    FIELD drivname2     as char format "x(60)"  init ""
    FIELD drivdate2     as char format "x(15)"  init ""
    FIELD drivid2       as char format "x(15)"  init ""
    FIELD pack          AS CHAR FORMAT "x(2)"   INIT ""
    FIELD agent         AS CHAR FORMAT "x(10)"  INIT ""
    FIELD vatcode       AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD inspect       AS CHAR FORMAT "x(15)"  INIT ""
    FIELD comment       AS CHAR FORMAT "x(255)" INIT "" 
    FIELD redbook       AS CHAR FORMAT "x(15)" INIT "" .

DEF VAR   nv_cnt   as  int  init   0.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
DEF VAR   n_producer AS CHAR FORMAT "x(10)" .
def var n_address  as char format "x(50)".
def var n_build    as char format "x(50)".
def var n_mu       as char format "x(50)".
def var n_soi      as char format "x(50)".
def var n_road     as char format "x(50)".
def var n_tambon   as char format "x(50)".
def var n_amper    as char format "x(50)".
def var n_country  as char format "x(50)".
def var n_post     as char format "x(50)".
DEF VAR n_length   AS INT.

DEF VAR n_drive1 AS CHAR FORMAT "x(75)" .     
DEF VAR n_drive2 AS CHAR FORMAT "x(75)" .     
DEF VAR n_sex1   AS CHAR .                      
DEF VAR n_sex2   AS CHAR .                      
DEF VAR n_bdate1 AS CHAR FORMAT "x(15)" .     
DEF VAR n_bdate2 AS CHAR FORMAT "x(15)" .     
DEF VAR n_age1   AS CHAR FORMAT "(3)" .       
DEF VAR n_occ1   AS CHAR FORMAT "x(35)" .     
DEF VAR n_age2   AS CHAR FORMAT "(3)" .       
DEF VAR n_occ2   AS CHAR FORMAT "x(35)" .   
DEF VAR n_quota   AS CHAR.
DEF VAR n_garage  AS CHAR.
DEF VAR n_remark1 AS CHAR.
DEF VAR n_remark2 AS CHAR.
DEF VAR n_other1  AS CHAR.
DEF VAR n_other2  AS CHAR.
DEF VAR n_other3  AS CHAR.
DEF VAR   nv_char     AS   CHAR  FORMAT "x(255)" .
DEF var   nv_tp       As   Char    Format    "x(20)" . 
DEF var   nv_ta       As   Char    Format    "x(20)" .  
DEF var   nv_td       As   Char    Format    "x(20)" .  
DEF var   nv_41        As   Char    Format    "x(20)" .  
DEF var   nv_42        As   Char    Format    "x(20)" .  
DEF var   nv_43        As   Char    Format    "x(20)" .
DEF VAR nv_notify AS CHAR FORMAT "x(12)" .
DEF VAR nv_title AS CHAR FORMAT "x(25)" .



    /* end A62-0219*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_remark rs_match fi_filename fi_outfile ~
bu_ok bu_exit bu_file fi_outfile2 dips RECT-77 
&Scoped-Define DISPLAYED-OBJECTS fi_remark rs_match fi_filename fi_outfile ~
fi_outfile2 

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
     SIZE 61 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_remark AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 57 BY 1
     BGCOLOR 19  NO-UNDO.

DEFINE VARIABLE rs_match AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match Running Policy", 1,
"Match Policy and Update Data Hold", 2
     SIZE 76 BY 1.52
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE dips
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 81.5 BY 13.1
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_remark AT ROW 9.24 COL 13.5 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     rs_match AT ROW 3.38 COL 4.17 NO-LABEL WIDGET-ID 2
     fi_filename AT ROW 5.24 COL 14 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 6.52 COL 16 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 11.62 COL 61.83
     bu_exit AT ROW 11.62 COL 71.5
     bu_file AT ROW 5.24 COL 77.17
     fi_outfile2 AT ROW 7.76 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     "Input File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 5.24 COL 3.67
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "File ORICO :" VIEW-AS TEXT
          SIZE 13.83 BY 1.05 AT ROW 6.52 COL 3.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "  MATCH TEXT FILE ORICO And PHONE" VIEW-AS TEXT
          SIZE 77 BY 1.67 AT ROW 1.48 COL 3.67
          BGCOLOR 18 FGCOLOR 2 FONT 2
     "Load PHONE :" VIEW-AS TEXT
          SIZE 14.33 BY 1.05 AT ROW 7.76 COL 3.5 WIDGET-ID 14
          BGCOLOR 19 FGCOLOR 1 FONT 6
     dips AT ROW 1 COL 1.17
     RECT-77 AT ROW 11.33 COL 60.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 81.67 BY 13.14
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
         TITLE              = "Match Text File Running policy no."
         HEIGHT             = 13.14
         WIDTH              = 82
         MAX-HEIGHT         = 15
         MAX-WIDTH          = 82
         VIRTUAL-HEIGHT     = 15
         VIRTUAL-WIDTH      = 82
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

ASSIGN 
       fi_remark:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match Text File Running policy no. */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match Text File Running policy no. */
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
    DEF VAR no_add AS CHAR FORMAT "x(8)" . 

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    /*"Text Documents" "*.txt",*/
                    "Text Documents" "*.csv",
                            "Data Files (*.*)"     "*.*"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:

        no_add =            STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

        IF rs_match = 1 THEN DO:
         fi_filename  = cvData.
         fi_outfile = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  + "_Match" + NO_add + ".csv" . 
         fi_outfile2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + "_Load" + NO_add  + ".csv".
        END.
        ELSE DO:
         fi_filename  = cvData.
         fi_outfile = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  + "_Upstatus" + NO_add + ".csv" . 


        END.
         DISP fi_filename fi_outfile fi_outfile2  WITH FRAME {&FRAME-NAME}. 
             
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    For each  wdetail2:
        DELETE  wdetail2.
    END.
    IF rs_match = 1  THEN DO:
        RUN Proc_matchrunning.
    END.
    ELSE DO:
     INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
     REPEAT:    
         CREATE wdetail.
         IMPORT DELIMITER "|" 
         wdetail.recno           /* 0   "ลำดับที่"     */
         wdetail.Notify_dat      /* 1   "วันที่รับแจ้ง"*/  
         wdetail.time_notify     /* 3   "เวลารับแจ้ง"  */ 
         wdetail.notifyno        /* 4   เลขรับเเจ้ง */ 
         wdetail.comp_code       /* 5   รายชื่อบริษัทประกันภัย  */ 
         wdetail.NAME_mkt        /* 6   ชื่อเจ้าหน้าที่ MKT */
         wdetail.cmbr_no         /* 7   "รหัสสาขา"    */                                           
         wdetail.cmbr_code       /* 8   "Code: "  */ 
         wdetail.branch          /* 9  "รหัสสาขา_STY "*/  
         wdetail.producer
         wdetail.agent
         wdetail.deler           /*     Add deler kridtiya i. A56-0024  */
         wdetail.campaigno       /* 9   Campaign            */ 
         wdetail.cov_car         /*10   "ประเภทประกัน"      */        
         wdetail.cov_new         /*     "ประเภทรถ"          */            
         wdetail.covcod          /*     "ประเภทความคุ้มครอง"*/  
         wdetail.product
         wdetail.freeprem        /*     "ประกัน แถม/ไม่แถม" */  
         wdetail.freecomp        /*     "พรบ.   แถม/ไม่แถม" */
         wdetail.comdat          /*     "วันเริ่มคุ้มครอง"       */  
         wdetail.expdat          /*     "วันสิ้นสุดความคุ้มครอง" */  
         wdetail.ispno           /*  add  A55-0046          */
         wdetail.pol70           /*    "เลขกรมธรรม์70"*/            
         wdetail.pol72           /*    "เลขกรมธรรม์72"*/            
         wdetail.n_TITLE         /* 12  คำนำหน้าชื่อ    */                                       
         wdetail.n_name1         /* 13  ชื่อผู้เอาประกัน    */ 
         wdetail.idno
         wdetail.birthday
         wdetail.birthdayexp
         wdetail.occup
         wdetail.namedirect
         wdetail.ADD_1           /* 15  บ้านเลขที่  */                                           
         wdetail.ADD_2           /* 21  ตำบล/แขวง   */                                           
         wdetail.ADD_3           /* 22  อำเภอ/เขต   */                                           
         wdetail.ADD_4           /* 23  จังหวัด */                                               
         wdetail.ADD_5           /* 24  รหัสไปรษณีย์    */ 
         wdetail.tel             /* 24  telephone    */ 
         wdetail.typ_driv   
         wdetail.drivname1  
         wdetail.sex1
         wdetail.birthdriv1
         wdetail.occup1     
         wdetail.drivno1    
         wdetail.drivname2  
         wdetail.sex2 
         wdetail.birthdriv2
         wdetail.occup2     
         wdetail.drivno2
         wdetail.redbook        /*a62-0219*/
         wdetail.brand           /* 31  ชื่อยี่ห้อรถ    */                                       
         wdetail.model           /* 32  รุ่นรถ  */                                               
         wdetail.engine          /* 36  เลขเครื่องยนต์  */   
         wdetail.chassis         /* 35  เลขตัวถัง   */ 
         wdetail.power           /* 38  ซีซี    */ 
         wdetail.cyear           /* 37  ปีรถยนต์    */
         wdetail.licence         /* 34  เลขทะเบียน  */ 
         wdetail.provin          /* 34  จังหวัดเลขทะเบียน  */
         wdetail.subclass        /* 29  รหัสรถ  */   
         wdetail.garage          /* 26  ประเภทการซ่อม   */
         wdetail.ins_amt1        /*"ทุนประกัน"*/ 
         wdetail.fi              /* ทุนสูญหายไฟไหม้ */
         wdetail.prem1           /*"เบี้ยประกัน" */ 
         wdetail.prem2  
         wdetail.comprem         /*"เบี้ยพรบ." */                                           
         wdetail.prem3           /*"เบี้ยรวม"*/                   
         wdetail.deduct          /*A57-0063*/
         wdetail.sck             /*"เลขสติ๊กเกอร์" */             
         wdetail.ref             /*"เลขReferance no."*/           
         wdetail.recivename      /*"ออกใบเสร็จในนาม"*/            
         wdetail.vatcode         /*"Vatcode " */                  
         wdetail.notiuser        /*"ผู้รับแจ้ง"             */  
         wdetail.notbr           /* สาขาที่รับแจ้ง */ /*A62-0219*/
         wdetail.bennam          /*"ผู้รับผลประโยชน์"       */                                
         wdetail.remak1          /*"หมายเหตุ"               */ 
         /* Begin by Phaiboon W. [A59-0488] Date 07/11/2016 */
         wdetail.remak2      /*   "หมายเหตุ 2"          */
         wdetail.other1      /*   "อุปกรณ์เสริม         */
         wdetail.other2      /*   "ราคา"                */
         wdetail.other3      /*   "อุปกรณ์เสริม 2"      */
         wdetail.quotation
         wdetail.ngarage
         wdetail.ispstatus
         /* End by Phaiboon W. [A59-0488] Date 07/11/2016 */
         wdetail.tp        /*A62-0219*/ 
         wdetail.ta        /*A62-0219*/ 
         wdetail.td        /*A62-0219*/ 
         wdetail.n41       /*A62-0219*/ 
         wdetail.n42       /*A62-0219*/ 
         wdetail.n43       /*A62-0219*/ 
         wdetail.docno     /*A62-0219*/ 
         wdetail.reinsp    /*A62-0219*/ 
         wdetail.statusco .      /*"complete/not complete"  */
         
     END.    /* repeat  */
     FOR EACH wdetail.
         IF index(wdetail.recno,"ข้อมูล") <> 0 THEN DELETE wdetail.
         ELSE IF index(wdetail.recno,"ลำดับ") <> 0 THEN DELETE wdetail.
         ELSE IF  wdetail.recno  = "" THEN DELETE wdetail.
     END.
     RUN  Pro_matchfile_prem.
     Run  Pro_createfile.
     Message "Export data Complete"  View-as alert-box.
    END.
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


&Scoped-define SELF-NAME fi_outfile2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile2 C-Win
ON LEAVE OF fi_outfile2 IN FRAME fr_main
DO:
  fi_outfile2  =  Input  fi_outfile2.
  Disp  fi_outfile2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_match
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_match C-Win
ON VALUE-CHANGED OF rs_match IN FRAME fr_main
DO:
    rs_match = INPUT rs_match .

    IF rs_match = 1 THEN ASSIGN fi_remark = "Remark : Match Running Use form Notify Orico" .
    ELSE ASSIGN fi_remark = "Remark : Match policy and update data use form Load data to GW " .

    DISP rs_match fi_remark WITH FRAME fr_main.
  
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
  
      gv_prgid = "WGWPHORI.W".
  gv_prog  = "Match Text file Running and Update Policy no.".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  /*ASSIGN ra_report =  1.*/
  /*DISP ra_report WITH FRAM fr_main.*/
  ASSIGN rs_match = 1
         fi_remark = "Remark : Match Running Use form Notify Orico" .

  DISP rs_match fi_remark WITH FRAME fr_main.
  
  
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
  DISPLAY fi_remark rs_match fi_filename fi_outfile fi_outfile2 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_remark rs_match fi_filename fi_outfile bu_ok bu_exit bu_file 
         fi_outfile2 dips RECT-77 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addr C-Win 
PROCEDURE proc_addr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    /*----- ที่อยู่ --------*/
    ASSIGN  n_length   = 0      n_address  = ""
            n_build    = ""     n_road     = ""          
            n_tambon   = ""     n_amper    = ""          
            n_country  = ""     n_post     = ""
            n_address  = TRIM(wdetail2.CustAddress) .      
       
        IF INDEX(n_address,"จ." ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"จ."),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post))
            n_country  =  trim(REPLACE(n_country,"จ.","")).
        END.
        ELSE IF INDEX(n_address,"จังหวัด" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"จังหวัด"),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length)  ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post))
            n_country  =  trim(REPLACE(n_country,"จังหวัด","")).
        END.
        ELSE IF INDEX(n_address,"กทม" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"กทม"),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
        END.
        ELSE IF INDEX(n_address,"กรุงเทพ" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"กรุงเทพ"),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
        END.
        IF INDEX(n_address,"อ." ) <> 0 THEN DO: 
            ASSIGN 
            n_amper  =  SUBSTR(n_address,INDEX(n_address,"อ."),LENGTH(n_address))
            n_length   =  LENGTH(n_amper)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_amper    =  trim(REPLACE(n_amper,"อ.","")).
        END.
        ELSE IF INDEX(n_address,"อำเภอ" ) <> 0 THEN DO: 
            ASSIGN 
            n_amper    =  SUBSTR(n_address,INDEX(n_address,"อำเภอ"),LENGTH(n_address))
            n_length   =  LENGTH(n_amper)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_amper    =  trim(REPLACE(n_amper,"อำเภอ","")).
        END.
        ELSE IF INDEX(n_address,"เขต" ) <> 0 THEN DO: 
            ASSIGN 
            n_amper    =  SUBSTR(n_address,INDEX(n_address,"เขต"),LENGTH(n_address))
            n_length   =  LENGTH(n_amper)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_amper    =  trim(REPLACE(n_amper,"เขต","")).
        END.
        IF INDEX(n_address,"ต." ) <> 0 THEN DO: 
            ASSIGN 
            n_tambon   =  SUBSTR(n_address,INDEX(n_address,"ต."),LENGTH(n_address))
            n_length   =  LENGTH(n_tambon)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_tambon   =  trim(REPLACE(n_tambon,"ต.","")).
        END.
        ELSE IF INDEX(n_address,"ตำบล" ) <> 0 THEN DO: 
            ASSIGN 
            n_tambon   =  SUBSTR(n_address,INDEX(n_address,"ตำบล"),LENGTH(n_address))
            n_length   =  LENGTH(n_tambon)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_tambon   =  trim(REPLACE(n_tambon,"ตำบล","")).
        END.
        ELSE IF INDEX(n_address,"แขวง" ) <> 0 THEN DO: 
            ASSIGN 
            n_tambon   =  SUBSTR(n_address,INDEX(n_address,"แขวง"),LENGTH(n_address))
            n_length   =  LENGTH(n_tambon)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_tambon   =  trim(REPLACE(n_tambon,"แขวง","")).
        END.

        /*ASSIGN  n_build   = trim(n_address).*/

        /*-------------- Driver name ----------------*/
        ASSIGN n_drive1  = ""           n_drive2  = "" 
               n_sex1    = ""           n_sex2    = "" 
               n_bdate1  = ""           n_bdate2  = "" 
               n_age1    = ""           n_occ1    = "" 
               n_age2    = ""           n_occ2    = ""  .

        IF wdetail2.drivname1 <> ""  THEN DO:
            IF  tlt.dri_name1 = "" THEN DO:  /*driver name 1.*/
                ASSIGN n_drive1  = TRIM(wdetail2.drivname1)
                       n_sex1    = "1"
                       n_bdate1  = TRIM(wdetail2.drivdate1)
                       n_age1    = IF TRIM(wdetail2.drivdate1) = "" THEN "0"
                                   ELSE STRING((YEAR(TODAY) + 543) - Year(date(wdetail2.drivdate1))) 
                       n_occ1    = "".
            END.
            ELSE DO:
              ASSIGN  
                    n_drive1 = IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN ""
                               ELSE SUBSTR(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 )
                    n_sex1   = IF trim(substr(tlt.dri_name1,INDEX(tlt.dri_name1,"sex:") + 4,1)) =  "2" THEN "2"
                               ELSE "1" 
                    n_bdate1 = IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN "?"
                               ELSE STRING(date(SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10)),"99/99/9999")
                    n_age1   = IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN "0"
                               ELSE STRING((YEAR(TODAY) + 543) - Year(date(SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10))))  
                    n_occ1   = IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN ""
                               ELSE substr(tlt.dri_name1,INDEX(tlt.dri_name1,"occ:") + 4 ) .
            END.
        END.
        IF wdetail2.drivname2 <> "" THEN DO:
            IF tlt.enttim = "" THEN  do: /*driver 2*/
                 ASSIGN n_drive2  = TRIM(wdetail2.drivname2)
                        n_sex2    = "1"
                        n_bdate2  = TRIM(wdetail2.drivdate2)
                        n_age2    = IF TRIM(wdetail2.drivdate2) = "" THEN "0"
                                    ELSE STRING((YEAR(TODAY) + 543) - Year(date(wdetail2.drivdate2))) 
                        n_occ2    = "".
            END.
            ELSE do: 
                ASSIGN 
                     n_drive2 = IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN ""
                                ELSE SUBSTR(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 )
                     n_sex2   = IF trim(substr(tlt.enttim,INDEX(tlt.enttim,"sex:") + 4,1)) =  "2" THEN "2"
                                ELSE "1" 
                     n_bdate2 = IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN "?"
                                ELSE STRING(date(SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10)),"99/99/9999")
                     n_age2   = IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN "0"
                                ELSE STRING((YEAR(TODAY) + 543) - Year(date(SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10))))  
                     n_occ2   = IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN ""
                                ELSE substr(tlt.enttim,INDEX(tlt.enttim,"occ:") + 4 ).  
            END.
        END.

       /*----------- comdate , expdate ------------ */
        DEF VAR nv_year AS INT INIT 0.
        nv_year = 0 .
        IF YEAR(date(wdetail2.comdat)) <> YEAR(TODAY) THEN DO:
            ASSIGN nv_year = (YEAR(DATE(wdetail2.comdat)) - 543)
                   wdetail2.comdat = STRING(DAY(DATE(wdetail2.comdat)),"99") + "/" +
                                     STRING(MONTH(DATE(wdetail2.comdat)),"99") + "/" +
                                     STRING(nv_year,"9999") .
                 
        END.
        nv_year = 0 .
        IF YEAR(date(wdetail2.expdat)) <> YEAR(TODAY) THEN DO:
            ASSIGN nv_year = (YEAR(DATE(wdetail2.expdat)) - 543)
                   wdetail2.expdat =  STRING(DAY(DATE(wdetail2.expdat)),"99") + "/" +     
                                      STRING(MONTH(DATE(wdetail2.expdat)),"99") + "/" +  
                                      STRING(nv_year,"9999") .
        END.

        /*----------- อุปกรณ์เสริม -----------*/
        ASSIGN n_remark1 = ""
               n_remark2 = ""
               n_other2  = ""
               n_other3  = ""
               n_quota   = ""
               n_other1  = ""
               n_other1  = ""
               n_other2  = ""
               n_other3  = "" .

        IF TRIM(wdetail2.accsor) <> ""  THEN DO:
            ASSIGN 
            n_remark1   = TRIM(SUBSTR(tlt.OLD_cha,INDEX(tlt.old_cha,":") + 1,100 - (INDEX(tlt.old_cha,":") + 1)))           
            n_remark2   = TRIM(SUBSTR(tlt.OLD_cha,101,100))                  
            n_other2    = TRIM(SUBSTR(tlt.OLD_cha,251,10))   
            n_other3    = TRIM(SUBSTR(tlt.OLD_cha,261,60))
            n_quota     = TRIM(SUBSTR(tlt.OLD_cha,321,20))
            n_garage    = TRIM(SUBSTR(tlt.OLD_cha,341,20))
            n_remark1   = IF INDEX(n_remark1,nv_notify) <> 0 THEN TRIM(SUBSTR(tlt.OLD_cha,1,INDEX(tlt.old_cha,":") + 1 )) + " " + n_remark1 
                          ELSE TRIM(SUBSTR(tlt.OLD_cha,1,INDEX(tlt.old_cha,":") + 1 )) + " " + trim(nv_notify) + " " + trim(n_remark1)
            n_other2    = TRIM(wdetail2.accsor_price) 
            n_other3    = TRIM(wdetail2.accsor)
            n_garage    = TRIM(wdetail2.garage).

           IF LENGTH(n_quota) <= 4 THEN DO: 
                n_quota  = "".
                n_garage = "".
           END.
           ELSE DO:
               n_quota  = n_quota + FILL(" ", 20 - LENGTH(n_quota)).
               n_garage = TRIM(wdetail2.garage).
               n_garage = n_garage + FILL(" ", 20 - LENGTH(n_garage)).
           END.
           ASSIGN 
           n_remark1         = n_remark1 + FILL(" ", 100 - LENGTH(n_remark1))
           n_remark2         = n_remark2 + FILL(" ", 100 - LENGTH(n_remark2))
           n_other1          = "อุปกรณ์เสริมคุ้มครองไม่เกิน"
           n_other1          = n_other1 + FILL(" ", 50 - LENGTH(n_other1))
           n_other2          = STRING(n_other2) + FILL(" " , 10 - LENGTH(STRING(n_other2))) 
           n_other3          = STRING(n_other3) + FILL(" " , 60 - LENGTH(STRING(n_other3))) .
        END.
        ELSE DO:
            ASSIGN 
            n_remark1   = TRIM(SUBSTR(tlt.OLD_cha,INDEX(tlt.old_cha,":") + 1, 100 - (INDEX(tlt.old_cha,":") + 1)))           
            n_remark2   = TRIM(SUBSTR(tlt.OLD_cha,101,100))                  
            n_other2    = TRIM(SUBSTR(tlt.OLD_cha,251,10))   
            n_other3    = TRIM(SUBSTR(tlt.OLD_cha,261,60))
            n_quota     = TRIM(SUBSTR(tlt.OLD_cha,321,20))
            n_garage    = TRIM(SUBSTR(tlt.OLD_cha,341,20))
            n_remark1   = IF INDEX(n_remark1,nv_notify) <> 0 THEN TRIM(SUBSTR(tlt.OLD_cha,1,INDEX(tlt.old_cha,":") + 1 )) + " " + n_remark1 
                          ELSE TRIM(SUBSTR(tlt.OLD_cha,1,INDEX(tlt.old_cha,":") + 1 )) + " " + trim(nv_notify) + " " + trim(n_remark1)
            n_garage    = TRIM(wdetail2.garage).

           IF LENGTH(n_quota) <= 4 THEN DO: 
                n_quota  = "".
                n_garage = "".
           END.
           ELSE DO:
               n_quota  = n_quota + FILL(" ", 20 - LENGTH(n_quota)).
               n_garage = TRIM(wdetail2.garage).
               n_garage = n_garage + FILL(" ", 20 - LENGTH(n_garage)).
           END.
           ASSIGN 
           n_remark1         = n_remark1 + FILL(" ", 100 - LENGTH(n_remark1))
           n_remark2         = n_remark2 + FILL(" ", 100 - LENGTH(n_remark2))
           n_other1          = "อุปกรณ์เสริมคุ้มครองไม่เกิน"
           n_other1          = n_other1 + FILL(" ", 50 - LENGTH(n_other1))
           n_other2          = STRING(n_other2) + FILL(" " , 10 - LENGTH(STRING(n_other2))) 
           n_other3          = STRING(n_other3) + FILL(" " , 60 - LENGTH(STRING(n_other3))) .

        END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_fileload C-Win 
PROCEDURE proc_fileload :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

If  substr(fi_outfile2,length(fi_outfile2) - 3,4) <>  ".csv"  THEN 
    fi_outfile2  =  Trim(fi_outfile2) + ".csv"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outfile2). 
EXPORT DELIMITER "|" 
    "ข้อมูลงาน ORICO รับประกันภัยทางโทรศัพท์ ." .
EXPORT DELIMITER "|" 
    "ลำดับที่"   
    "วันที่รับแจ้ง" 
    "เวลารับแจ้ง" 
    "เลขรับแจ้งงาน"  
    "รหัสบรษัท" 
    "ชื่อเจ้าหน้าที่ MKT"  
    "รหัสสาขา" 
    "Code: "
    "รหัสสาขา_STY "
    "Producer."
    "Agent."
    "Deler"
    "Campaign no."                         
    "ประเภทประกัน"                     
    "ประเภทรถ" 
    "ประเภทความคุ้มครอง"  
    "Product Type"
    "ประกัน แถม/ไม่แถม" 
    "พรบ.   แถม/ไม่แถม" 
    "วันเริ่มคุ้มครอง"   
    "วันสิ้นสุดความคุ้มครอง" 
    "เลขตรวจสภาพ"            /*A55-0046*/
    "เลขกรมธรรม์70"          
    "เลขกรมธรรม์72"          
    "คำนำหน้าชื่อ"            
    "ชื่อผู้เอาประกัน"       
    "เลขที่บัตรประชาชน"      /*id no */
    "วันเกิด"                /*birth of date. */
    "วันที่บัตรหมดอายุ"      
    "อาชีพ"                  /*occup */
    "ชื่อกรรมการ"            /*Name drirect */
    "บ้านเลขที่"                    
    "ตำบล/แขวง"                     
    "อำเภอ/เขต"                     
    "จังหวัด"                       
    "รหัสไปรษณีย์"           
    "เบอร์โทรศัพท์"          
    "ระบุผู้ขับขี่/ไม่ระบุผู้ขับขี่" 
    "ผู้ขับขี่คนที่1"        /*drivname  1*/
    "เพศ"                    /*sex       1*/
    "วันเกิด"                /*birth day 1*/
    "อาชัพ"                  /*occup     1*/
    "เลขที่ใบขับขี่"         /*id driv   1*/
    "ผู้ขับขี่คนที่1"        /*drivname  2*/
    "เพศ"                    /*sex       2*/
    "วันเกิด"                /*birth day 2*/
    "อาชัพ"                  /*occup     2*/
    "เลขที่ใบขับขี่"         /*id driv   2*/
    "Redbook "   /*A62-0219*/ 
    "ชื่อยี่ห้อรถ"                     
    "รุ่นรถ" 
    "เลขเครื่องยนต์"
    "เลขตัวถัง" 
    "ซีซี" 
    "ปีรถยนต์"            
    "เลขทะเบียน"  
    "จังหวัดที่จดทะเบียน"
    "แพคเกจ"
    "การซ่อม"
    "ทุนประกัน" 
    "ทุนสูญหาย ไฟไหม้" /*A62-0219*/
    "เบี้ยสุทธิ"
    "เบี้ยประกัน" 
    "เบี้ยพรบ."
    "เบี้ยรวม" 
    "DEDUCT OD"
    "เลขสติ๊กเกอร์"   
    "เลขReferance no." 
    "ออกใบเสร็จในนาม" 
    "Vatcode "  
    "ผู้รับแจ้ง"
    "สาขาที่แจ้ง"   /*A62-0219*/
    "ผู้รับผลประโยชน์" 
    "หมายเหตุ 1" 
    "หมายเหตุ 2"
    "อุปกรณ์เสริม 1"    
    "ราคา"
    "อุปกรณ์เสริม 2"
    "Quotation No."
    "Garage"
    "Ststus เลขตรวจสภาพ"
    "TPBI/Per"
    "TPBI/Acc"
    "TPPD/Acc"
    "41"
    "42"
    "43"
    "เลขที่เอกสาร"
    "ผลการตรวจสภาพ"
    "complete/not complete"
    "Yes/No" .

FOR EACH wdetail2 WHERE wdetail2.prevpol <> "" AND wdetail2.comment = "COMPLETE" NO-LOCK.
    FIND LAST  tlt Use-index  tlt06  Where
    brstat.tlt.cha_no  = trim(wdetail2.chassis)  and
    brstat.tlt.eng_no  = trim(wdetail2.engine)   and
    brstat.tlt.lotno   = "ORICO"     AND
    brstat.tlt.genusr  = "PHONE"     AND  
    brstat.tlt.releas  = "NO"        AND 
    brstat.tlt.endcnt  = 1           NO-LOCK NO-ERROR.

    IF AVAIL brstat.tlt THEN DO:
        /* เพิ่มความคุ้มครอง */
        ASSIGN nv_td   = ""   nv_43  = "" 
               nv_char = ""   nv_42  = "" 
               nv_ta   = ""   nv_41  = "" 
               nv_tp   = ""  .
        
        IF tlt.rec_addr2 <> ""  THEN DO:
            ASSIGN 
                nv_td       = TRIM(SUBSTR(tlt.rec_addr2,R-INDEX(tlt.rec_addr2,"TPD:") + 4 ))
                nv_char     = SUBSTR(tlt.rec_addr2,1,INDEX(tlt.rec_addr2,"TPD:") - 2 )
                nv_ta       = TRIM(SUBSTR(nv_char,R-INDEX(nv_char,"TPA:") + 4 ))
                nv_tp       = trim(SUBSTR(nv_char,5,INDEX(nv_char,"TPA:") - 5 )) . 
        END.
        ELSE DO:
            ASSIGN nv_td       = "0"
                   nv_ta       = "0"
                   nv_tp       = "0" .
                  
        END.
        IF tlt.rec_addr3 <> ""  THEN DO:
            ASSIGN 
                nv_43       = TRIM(SUBSTR(tlt.rec_addr3,R-INDEX(tlt.rec_addr3,"43:") + 3 ))
                nv_char     = SUBSTR(tlt.rec_addr3,1,INDEX(tlt.rec_addr3,"43:") - 2 ) 
                nv_42       = trim(SUBSTR(nv_char,R-INDEX(nv_char,"42:") + 3 )) 
                nv_41       = TRIM(SUBSTR(nv_char,4,INDEX(nv_char,"42:") - 4)) .
        END.
        ELSE DO:
            ASSIGN nv_43       = "0"
                   nv_42       = "0"
                   nv_41       = "0" .
        END.
        n_name = "" .
        IF INDEX(tlt.ins_name,"และหรือ") = 0 THEN do: 
            n_name = trim(substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1)) .
        END.
        ELSE DO:
            n_name = trim(substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1,R-INDEX(trim(tlt.ins_name),"และหรือ") - 9)).
        END.
        ASSIGN 
            n_record =  n_record + 1.
        EXPORT DELIMITER "|" 
        n_record                                        /*"ลำดับที่"      */            
        string(tlt.trndat,"99/99/9999") FORMAT "x(10)"  /*"วันที่รับแจ้ง" */        
        string(tlt.trntime)             FORMAT "x(10)"  /*"เวลารับแจ้ง"   */         
        TRIM(wdetail2.safe_no)          FORMAT "x(50)"  /*"เลขรับแจ้งงาน" */       
        trim(tlt.lotno)                 FORMAT "x(20)"  /*"รหัสบรษัท" */           
        trim(tlt.nor_usr_ins)           FORMAT "x(40)"  /*"ชื่อเจ้าหน้าที่ MKT"*/ 
        trim(tlt.nor_usr_tlt)           FORMAT "x(10)"  /*"รหัสสาขา"             */             
        trim(tlt.nor_noti_ins)          FORMAT "x(35)"  /*"Code: "               */                       
        trim(tlt.colorcod)              FORMAT "x(20)"  /*"รหัสสาขา_STY "*/               
        trim(tlt.comp_sub)              FORMAT "x(30)"  /*"Producer." */           
        trim(tlt.recac)                 FORMAT "x(30)"  /*"Agent." */              
        TRIM(tlt.rec_addr4)             FORMAT "x(20)"  /*Deler *//* add A56-0024 */
        trim(tlt.subins)                FORMAT "x(30)"  /* "Campaign no." */ 
        tlt.safe1                                       /*"ประเภทประกัน"*/
        tlt.safe2                                       /*"ประเภทรถ"*/          
        tlt.safe3                                       /*"ประเภทความคุ้มครอง"*/
        tlt.stat
        trim(wdetail2.InsTyp) /*tlt.filler1 */  /*"ประกัน แถม/ไม่แถม"*/ 
        trim(wdetail2.comtyp) /*tlt.filler2 */  /*"พรบ.   แถม/ไม่แถม"*/
        tlt.nor_effdat            /*"วันเริ่มคุ้มครอง"       */
        tlt.expodat               /*"วันสิ้นสุดความคุ้มครอง" */
        TRIM(SUBSTR(tlt.dri_no2,1,50)) /* add by Phaiboon W. [A59-0488] Date 30/11/2016 */
        tlt.policy                /*"เลขกรมธรรม์70"*/    
        tlt.comp_pol              /*"เลขกรมธรรม์72"*/   
        trim(substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 )) FORMAT "x(20)"       /*"คำนำหน้าชื่อ"*/     
        n_name /*ชื่อลูกค้า */
        trim(tlt.endno)            /*id no */                                               
        IF tlt.dat_ins_noti = ? THEN "" ELSE trim(string(tlt.dat_ins_noti))  /*birth of date. */
        IF tlt.entdat = ?       THEN "" ELSE TRIM(STRING(tlt.entdat))        /*birth of date. */
        trim(tlt.flag)            /*occup */
        trim(tlt.usrsent)         /*Name drirect */
        trim(tlt.ins_addr1)       /*"บ้านเลขที่" */      
        trim(tlt.ins_addr2)       /*"ตำบล/แขวง" */
        trim(tlt.ins_addr3)       /*"อำเภอ/เขต"*/        
        trim(tlt.ins_addr4)       /*"จังหวัด" */
        trim(tlt.ins_addr5)       /*"รหัสไปรษณีย์"*/  
        TRIM(SUBSTR(tlt.comp_noti_ins,1,20)) 
        IF tlt.dri_name1 = "" THEN "ไม่ระบุผู้ขับขี่" ELSE "ระบุผู้ขับขี่"
        IF tlt.dri_name1 = "" THEN  "" ELSE SUBSTR(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 )                                            /*drivname 1*/ 
        IF tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(tlt.dri_name1,INDEX(tlt.dri_name1,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"   /*sex      1*/ 
        IF tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10))                                         /*birth day1*/ 
        IF tlt.dri_name1 = "" THEN  "" ELSE substr(tlt.dri_name1,INDEX(tlt.dri_name1,"occ:") + 4 )                                              /*occup    1*/ 
        IF tlt.dri_name1 = "" THEN  "" ELSE trim(tlt.dri_no1)                                                                                   /*id driv  1*/ 
        IF tlt.dri_name1 = "" THEN  "" ELSE  SUBSTR(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 )                                                 /*drivname 2*/ 
        IF tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(tlt.enttim,INDEX(tlt.enttim,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"         /*sex      2*/ 
        IF tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10))                                               /*birth day2*/ 
        IF tlt.dri_name1 = "" THEN  "" ELSE substr(tlt.enttim,INDEX(tlt.enttim,"occ:") + 4 )                                                    /*occup    2*/ 
        IF tlt.dri_name1 = "" THEN  "" ELSE trim(tlt.expotim)                                                                                   /*id driv  2*/ 
        /* tlt.brand                 /*"ชื่อยี่ห้อรถ"*/  */ /*a62-0219*/  
        IF index(tlt.brand,"RB:") <> 0 THEN SUBSTR(tlt.brand,R-INDEX(tlt.brand,"RB:") + 3) ELSE ""                 /* Redbook */  /*a62-0219*/ 
        IF index(tlt.brand,"RB:") <> 0 THEN SUBSTR(tlt.brand,1,INDEX(tlt.brand,"RB:") - 2) ELSE tlt.brand      /*"ชื่อยี่ห้อรถ"*/  /*a62-0219*/   
        tlt.model                 /*"รุ่นรถ" */              
        tlt.eng_no                /*"เลขเครื่องยนต์" */
        tlt.cha_no                /*"เลขตัวถัง" */           
        tlt.cc_weight             /*"ซีซี" */               
        tlt.lince2                /*"ปีรถยนต์"*/            
        /*substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1) FORMAT "x(7)"  /*"เลขทะเบียน"  */*//*A54-0112*/ 
        substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1) FORMAT "x(8)"  /*"เลขทะเบียน"  *//*A54-0112*/
        substr(tlt.lince1,R-INDEX(tlt.lince1," ") + 1) FORMAT "x(30)"    /*"จังหวัดที่จดทะเบียน"*/ 
        tlt.lince3                /*"แพคเกจ"*/
        tlt.exp                   /*"การซ่อม" */                                 
        tlt.nor_coamt             /*"ทุนประกัน"*/ 
        STRING(tlt.sentcnt,"->>>,>>>,>>9.99")    /* ทุนสูญหาย */ /*A62-0219*/ 
        tlt.dri_name2  FORMAT "x(30)"
        tlt.nor_grprm             /*"เบี้ยประกัน" */                             
        tlt.comp_coamt            /*"เบี้ยพรบ." */      
        tlt.comp_grprm            /*"เบี้ยรวม"*/        
        tlt.rec_addr5             /* deduct */
        /*tlt.comp_sck */             /*"เลขสติ๊กเกอร์" */      /*A62-0219*/            
        IF index(tlt.comp_sck,"DOC:") <> 0 THEN SUBSTR(tlt.comp_sck,5,INDEX(tlt.comp_sck,"DOC:") - 5) ELSE tlt.comp_sck /*a62-0219 */
        tlt.comp_noti_tlt         /*"เลขReferance no."*/
        tlt.rec_name + " ที่อยู่: " + TRIM(wdetail2.pol_addr1) + " เลขที่ผู้เสียภาษี: " + trim(wdetail2.taxno)             /*"ออกใบเสร็จในนาม"*/ 
        tlt.comp_usr_tlt          /*"Vatcode " */
        /*tlt.expousr   */            /*"ผู้รับแจ้ง"             */ /*A62-0219*/
        IF INDEX(tlt.expousr,"USER:") <> 0 THEN SUBSTR(tlt.expousr,R-INDEX(tlt.expousr,"USER:") + 5) ELSE tlt.expousr    /*A62-0219*/
        IF INDEX(tlt.expousr,"BR:") <> 0 THEN SUBSTR(tlt.expousr,4,INDEX(tlt.expousr," ") + 1) ELSE ""                   /*A62-0219*/
        tlt.comp_usr_ins          /*"ผู้รับผลประโยชน์"       */
        TRIM(SUBSTR(tlt.OLD_cha,1,100))  
        TRIM(SUBSTR(tlt.OLD_cha,101,100))
        TRIM(SUBSTR(tlt.OLD_cha,201,50)) 
        TRIM(SUBSTR(tlt.OLD_cha,251,10)) 
        TRIM(SUBSTR(tlt.OLD_cha,261,60)) 
        TRIM(SUBSTR(tlt.OLD_cha,321,20)) 
        TRIM(SUBSTR(tlt.OLD_cha,341,20)) 
        TRIM(SUBSTR(tlt.dri_no2,51,1))
        nv_tp
        nv_ta
        nv_td
        nv_41
        nv_42
        nv_43
        IF index(tlt.comp_sck,"DOC:") <> 0 THEN SUBSTR(tlt.comp_sck,R-INDEX(tlt.comp_sck,"DOC:") + 4 ) ELSE ""
        tlt.gentim
        tlt.OLD_eng      
        tlt.releas. 
    END.
END.                 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_fileorico C-Win 
PROCEDURE proc_fileorico :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN 
        fi_outfile  =  Trim(fi_outfile) + ".slk"  .
    
    ASSIGN n_record = 0    nv_cnt   =  0   nv_row   =  1 .
    
    OUTPUT TO VALUE(fi_outfile). 
    EXPORT DELIMITER "|" 
        "Data Match File Orico " .
    EXPORT DELIMITER "|" 
    "No.                       " 
    "Marketing                 " 
    "Agreement No.             " 
    "Inform Date               " 
    "Type of Ins.              " 
    "Type of Repair Vehicle    " 
    "Voluntary No.             " 
    "Compulsory No.            " 
    "Inform No.                " 
    "Inform By                 " 
    "Inform Time               " 
    "The Insured               "            
    "ID. Card No.              " 
    "Company affidavit No.     " 
    "Name of Receipt / Tax inv." 
    "Tax Payer ID No.          " 
    "Branch                    " 
    "Receipt / Tax inv. Address" 
    "Bill to                   " 
    "Sum Insure.               " 
    "Voluntary Premium         " 
    "Total Premium             " 
    "Compulsory Premium        " 
    "Total Premium             " 
    "Maker                     " 
    "Family                    " 
    "Year of Manufacture       " 
    "Colour                    " 
    "Plate No.                 " 
    "Province                  " 
    " CC.                      " 
    "Engine No.                " 
    "Chassis No.               " 
    "Accessories               " 
    "Accessories Price         " 
    "แถม/ไม่แถม ประกันภัย      " 
    "แถม/ไม่แถม พรบ.           " 
    "Dealer Name               " 
    "Driver 1                  " 
    "Date of birth             " 
    "Driver Licence No.        " 
    "Driver 2                  " 
    "Date of birth             " 
    "Driver Licence No.        " 
    "Period Insured From       " 
    "Period Insured to         " 
    "Beneficiary Name          " 
    "Remark                    " SKIP.
    
    FOR EACH wdetail2  NO-LOCK  .
       EXPORT DELIMITER "|" 
         wdetail2.n_no          
         wdetail2.Remark        
         wdetail2.Account_no    
         wdetail2.RegisDate     
         wdetail2.CovTyp        
         wdetail2.garage        
         wdetail2.prevpol              
         wdetail2.compno               
         wdetail2.safe_no              
         wdetail2.CMRName               
         wdetail2.not_time              
         wdetail2.name_insur      /*  Add deler kridtiya i. A56-0024  */       
         wdetail2.icno                  
         wdetail2.saleid                
         wdetail2.taxname               
         wdetail2.taxno                 
         wdetail2.branch                 
         wdetail2.pol_addr1             
         wdetail2.CustAddress           
         wdetail2.SI                    
         wdetail2.netprem               
         wdetail2.totalprem             
         wdetail2.comp_prm              
         wdetail2.comp_prmtotal         
         wdetail2.brand          
         wdetail2.Brand_Model   
         wdetail2.yrmanu        
         wdetail2.n_color       
         wdetail2.RegisNo       
         wdetail2.RegisProv     
         wdetail2.CC                    
         wdetail2.engine                
         wdetail2.chassis               
         wdetail2.accsor           
         wdetail2.accsor_price     
         wdetail2.InsTyp         
         wdetail2.comtyp         
         wdetail2.DealerName                  
         wdetail2.drivname1                               
         wdetail2.drivdate1                             
         wdetail2.drivid1                           
         wdetail2.drivname2              
         wdetail2.drivdate2                   
         wdetail2.drivid2                  
         wdetail2.comdat                    
         wdetail2.expdat                                      
         wdetail2.ben_name              
         wdetail2.comment  SKIP.     
    END.    /*  end  wdetail2  */
    nv_row  =  nv_row  + 1. 
    OUTPUT CLOSE.  
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchrunning C-Win 
PROCEDURE proc_matchrunning :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FOR EACH  wdetail2 :
        DELETE  wdetail2.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail2.
        IMPORT DELIMITER "|"         
                wdetail2.n_no                        /*No.                                 */    
                wdetail2.Remark                      /*Marketing                           */    
                wdetail2.Account_no                  /*Agreement No.                       */    
                wdetail2.RegisDate                   /*วันที่รับแจ้ง                       */ 
                wdetail2.CovTyp                      /*ประเภทประกัน                        */
                wdetail2.garage                      /*Type of Garage                      */
                wdetail2.prevpol                     /*กรมธรรม์ เลขที่                     */    
                wdetail2.compno                      /*พรบ.เลขที่                          */    
                wdetail2.safe_no                     /*เลขที่รับแจ้ง                       */    
                wdetail2.CMRName                     /*ผู้รับแจ้ง                          */    
                wdetail2.not_time                    /*เวลาแจ้งงาน                         */    
                wdetail2.name_insur                  /*ชื่อผู้เอาประกันภัย                 */    
                wdetail2.icno                        /*ID. Card No.                        */    
                wdetail2.saleid                      /*เลขทะเบียนการค้า(ภพ.20)             */    
                wdetail2.taxname                     /*ออกใบเสร็จ/ใบกำกับภาษีในนาม         */    
                wdetail2.taxno                       /*เลขประจำตัวผู้เสียภาษี13หลัก        */    
                wdetail2.branch                      /*สาขา                                */    
                wdetail2.pol_addr1                   /*ที่อยู่ในการออกใบเสร็จ/ใบกำกับภาษี  */    
                wdetail2.CustAddress                 /*ที่อยู่ในการจัดส่งเอกสาร            */    
                wdetail2.SI                          /*ทุนประกัน                           */    
                wdetail2.netprem                     /*เบี้ยประกันสุทธิ                    */    
                wdetail2.totalprem                   /*เบี้ยประกันรวม                      */    
                wdetail2.comp_prm                    /*เบี้ยพรบ สุทธิ                      */    
                wdetail2.comp_prmtotal               /*เบี้ยพรบ รวม                        */
                wdetail2.brand                       /*ยี่ห้อรถ                            */   /*A61-0221 */               
                wdetail2.Brand_Model                 /*รุ่น                                */ 
                wdetail2.yrmanu                      /*ปี                                  */    
                wdetail2.n_color                     /*สี                                  */    
                wdetail2.RegisNo                     /*เลขทะเบียน                          */    
                wdetail2.RegisProv                   /*จังหวัด                             */    
                wdetail2.CC                          /*ขนาดเครื่องยนต์                     */    
                wdetail2.engine                      /*เลขเครื่องยนต์                      */    
                wdetail2.chassis                     /*เลขตัวถัง                           */    
                wdetail2.accsor                      /*อุปกรณ์ตกแต่งเพิ่มเติม              */    
                wdetail2.accsor_price                /*อุปกรณ์ตกแต่งเพิ่มเติมราคา          */    
                wdetail2.InsTyp                      /*แถม/ไม่แถม ประกันภัย                */    
                wdetail2.comtyp                      /*แถม/ไม่แถม พรบ.                     */        
                wdetail2.DealerName                  /*ชื่อ Dealer                         */    
                wdetail2.drivname1                   /*ชื่อ-นามสกุล ผู้ขับขี่1             */    
                wdetail2.drivdate1                   /*วัน/เดือน/ปี เกิด ผู้ขับขี่1        */    
                wdetail2.drivid1                     /*เลขที่ใบขับขี่ผู้ขับขี่1            */    
                wdetail2.drivname2                   /*ชื่อ-นามสกุล ผู้ขับขี่2             */    
                wdetail2.drivdate2                   /*วัน/เดือน/ปี เกิด ผู้ขับขี่2        */    
                wdetail2.drivid2                     /*เลขที่ใบขับขี่ ผู้ขับขี่2           */    
                wdetail2.comdat                      /*วันที่คุ้มครอง                      */    
                wdetail2.expdat                      /*วันสิ้นสุดคุ้มครอง                  */    
                wdetail2.ben_name .                    /*ผู้รับผลประโยชน์                    */    
        IF INDEX(wdetail2.n_no,"No")   <> 0 THEN  DELETE wdetail2.
        ELSE IF  wdetail2.n_no         = "" THEN  DELETE wdetail2.
    END.  /* repeat  */
    RUN proc_polrunning .

    fi_remark =  "Export data To Report Match file Orico." . 
    DISP fi_remark WITH FRAME fr_main.
    RUN proc_fileorico.

    fi_remark =  "Export data to file Load." . 
    DISP fi_remark WITH FRAME fr_main.
    RUN proc_fileload.

    fi_remark =  "Match file Running policy complete ." . 
    DISP fi_remark WITH FRAME fr_main.

    MESSAGE "Match Running Complete " VIEW-AS ALERT-BOX.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_polrunning C-Win 
PROCEDURE proc_polrunning :
DEF VAR n_branch AS CHAR .
DO:
    FOR EACH wdetail2 .
        IF      wdetail2.chassis = ""  THEN DELETE wdetail2.
        ELSE IF wdetail2.engine  = ""  THEN DELETE wdetail2.
        ELSE IF wdetail2.prevpol <> "" THEN DO: 
            ASSIGN wdetail2.comment = "COMPLETE" .
        END.
        ELSE DO:
            IF      index(wdetail2.chassis,"-") <> 0 THEN ASSIGN wdetail2.chassis = REPLACE(wdetail2.chassis,"-","").
            ELSE IF index(wdetail2.chassis,"/") <> 0 THEN ASSIGN wdetail2.chassis = REPLACE(wdetail2.chassis,"/","").
            ELSE IF index(wdetail2.chassis," ") <> 0 THEN ASSIGN wdetail2.chassis = REPLACE(wdetail2.chassis," ","").

            IF      index(wdetail2.engine,"-") <> 0  THEN ASSIGN wdetail2.engine = REPLACE(wdetail2.engine,"-","").
            ELSE IF index(wdetail2.engine,"/") <> 0  THEN ASSIGN wdetail2.engine = REPLACE(wdetail2.engine,"/","").
            ELSE IF index(wdetail2.engine," ") <> 0  THEN ASSIGN wdetail2.engine = REPLACE(wdetail2.engine," ","").
            
            fi_remark =  "Check Data... " +  wdetail2.safe_no . 
            DISP fi_remark WITH FRAME fr_main.

            FOR EACH  brstat.tlt USE-INDEX tlt06 WHERE 
                brstat.tlt.cha_no        = trim(wdetail2.chassis)  and
                brstat.tlt.eng_no        = trim(wdetail2.engine)   and 
                brstat.tlt.genusr        = "Phone"                 AND 
                brstat.tlt.lotno         = "ORICO"                 AND
                brstat.tlt.releas        = "NO"  .

                ASSIGN n_name    = ""       n_namefile  = ""    n_chk      = YES    
                       n_br      = ""       nv_notno70  = ""    nv_notno72 = "" 
                       n_poltyp  = ""       nv_brnpol   = ""    n_undyr2   = "" 
                       n_brsty   = ""       nv_check    = ""    nv_check70 = ""
                       n_producer = ""      nv_title    = ""    n_branch   = "" 
                       n_name     = TRIM(REPLACE(tlt.ins_name," ",""))
                       n_namefile = TRIM(REPLACE(wdetail2.name_insur," ",""))
                       n_producer = TRIM(brstat.tlt.comp_sub) .
                /* เช็คชื่อในระบบ กับ ในไฟล์ */
                IF INDEX(n_namefile,n_name) = 0 THEN DO:
                    ASSIGN wdetail2.comment = "ชื่อผู้เอาประกันในไฟล์ ไม่ตรงกัน " .
                    NEXT.
                END.

                /*IF INDEX(n_namefile,"และหรือ") <> 0  THEN nv_title = "" .*/
                IF INDEX(n_namefile,"นางสาว") <> 0 THEN DO:
                    ASSIGN  nv_title = "นางสาว" 
                            wdetail2.NAME_insur = REPLACE(wdetail2.NAME_insur,nv_title,"")
                            wdetail2.NAME_insur = nv_title + " " + trim(wdetail2.NAME_insur).
                END.
                ELSE IF SUBSTR(n_namefile,1,3) = "นาง" THEN DO: 
                    ASSIGN  nv_title = "นาง" 
                            wdetail2.NAME_insur = trim(SUBSTR(wdetail2.NAME_insur,4))
                            wdetail2.NAME_insur = nv_title + " " + trim(wdetail2.NAME_insur).
                END.
                ELSE IF SUBSTR(n_namefile,1,3) = "นาย" THEN DO: 
                    ASSIGN  nv_title = "นาย" 
                            wdetail2.NAME_insur = trim(SUBSTR(wdetail2.NAME_insur,4))
                            wdetail2.NAME_insur = nv_title + " " + trim(wdetail2.NAME_insur).
                END.
                ELSE DO:
                    FIND LAST brstat.msgcode WHERE brstat.msgcode.compno   = "999" AND
                                                   index(n_namefile,brstat.msgcode.MsgDesc) <> 0  NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL brstat.msgcode THEN DO:  
                        ASSIGN nv_title  =  trim(brstat.msgcode.branch).
                    END.
                    IF nv_title <> ""  THEN DO:
                        ASSIGN 
                            wdetail2.NAME_insur = REPLACE(wdetail2.NAME_insur,nv_title,"")
                            wdetail2.NAME_insur = nv_title + " " + trim(wdetail2.NAME_insur).
                    END.
                END.
                
                /*------- check Branch -------------*/
                FIND LAST brstat.insure USE-INDEX insure03 WHERE 
                              insure.compno = "ORICO"   AND
                              insure.branch = TRIM(wdetail2.branch) NO-LOCK NO-ERROR .
                    IF AVAIL insure THEN DO:
                        ASSIGN n_brsty  = trim(Insure.FName)
                               n_branch = trim(Insure.FName)
                               n_branch = IF LENGTH(n_branch) = 1 THEN "D" + TRIM(n_branch) ELSE TRIM(n_branch) .
                    END.
                    ELSE DO:
                        MESSAGE "ไม่พบสาขา " + TRIM(wdetail2.branch) + "ในระบบพารามิเตอร์ของ ORICO " VIEW-AS ALERT-BOX.
                        ASSIGN wdetail2.comment = wdetail2.comment + "|" + "กรุณาตรวจสอบข้อมูลสาขาในไฟล์แจ้งงานอีกครั้ง".
                        NEXT.
                    END.

                IF deci(tlt.dri_name2) <> DECI(wdetail2.netprem) THEN DO:
                     ASSIGN wdetail2.comment = wdetail2.comment + "|" + wdetail2.safe_no + "เบี้ยในไฟล์ และในระบบไม่ตรงกัน ".
                     NEXT.
                END.

                /* เช็คเบอร์กรมธรรม์ในระบบ กับไฟล์ */
                IF brstat.tlt.policy <> "" THEN DO:
                    nv_check70 = trim(SUBSTR(brstat.tlt.policy,1,2)).
                    IF trim(nv_check70) = trim(n_branch) THEN DO:    /* สาขากับเบอร์ตรงกัน */
                        FIND LAST sicsyac.xmm023  USE-INDEX xmm02301 WHERE 
                                 (xmm023.branch         = nv_check70) OR 
                                 (("D" + xmm023.branch) = nv_check70) NO-LOCK NO-ERROR.
                        IF AVAIL sicsyac.xmm023 THEN DO:
                            IF brstat.tlt.policy = wdetail2.safe_no THEN DO: 
                                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                          sicuw.uwm100.policy = trim(wdetail2.safe_no) NO-LOCK NO-ERROR.
                                IF NOT AVAIL sicuw.uwm100 THEN DO: 
                                    FIND LAST  bftlt  WHERE 
                                        bftlt.genusr        = "ORICO"  AND
                                        bftlt.nor_noti_ins  = trim(wdetail2.safe_no) NO-LOCK NO-ERROR NO-WAIT.
                                    IF NOT AVAIL bftlt THEN DO:  
                                        ASSIGN wdetail2.prevpol  = brstat.tlt.policy
                                               wdetail2.comment  = "COMPLETE"
                                               brstat.tlt.endcnt = 1. /* status load */
                                    END.
                                    ELSE DO:
                                        ASSIGN wdetail2.comment = wdetail2.comment + "|" + wdetail2.safe_no + " มีข้อมูลในถังพักของ ORICO แล้ว".
                                        NEXT.
                                    END.
                                END.
                                ELSE DO:
                                    ASSIGN wdetail2.comment = wdetail2.comment + "|" + wdetail2.safe_no + " มีข้อมูลในระบบพรีเมียมแล้ว".
                                    NEXT.
                                END.
                            END.
                            ELSE DO: 
                                ASSIGN wdetail2.comment = wdetail2.comment + "|" + "กรุณาตรวจสอบข้อมูลเบอร์กรมธรรม์ในระบบและไฟล์แจ้งงานอีกครั้ง".
                                NEXT.
                            END.
                        END.
                    END.
                    ELSE DO:
                         FIND LAST  bftlt  WHERE 
                               bftlt.genusr        = "ORICO"  AND
                               bftlt.nor_noti_tlt  = trim(wdetail2.safe_no) AND 
                               bftlt.releas        = "yes"  NO-LOCK NO-ERROR NO-WAIT.
                           IF NOT AVAIL bftlt THEN DO:  
                               ASSIGN wdetail2.prevpol  = "". /* status load */
                           END.
                           ELSE DO:
                               ASSIGN wdetail2.comment = wdetail2.comment + "|" + wdetail2.safe_no + " มีข้อมูลในถังพักของ ORICO Status Release แล้ว".
                               NEXT.
                           END.
                    END.
                END.
                IF wdetail2.safe_no <> ""  THEN DO:
                    nv_check70 = SUBSTR(wdetail2.safe_no,1,2).
                    IF trim(nv_check70) = trim(n_branch) THEN DO:  /* สาขากับเบอร์ตรงกัน */
                        FIND LAST sicsyac.xmm023  USE-INDEX xmm02301 WHERE 
                                 (xmm023.branch         = nv_check70) OR 
                                 (("D" + xmm023.branch) = nv_check70) NO-LOCK NO-ERROR.
                        IF AVAIL sicsyac.xmm023 THEN DO:
                            IF brstat.tlt.policy = wdetail2.safe_no THEN DO: 
                                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                          sicuw.uwm100.policy = trim(wdetail2.safe_no) NO-LOCK NO-ERROR.
                                IF NOT AVAIL sicuw.uwm100 THEN DO: 
                                    FIND LAST  bftlt   WHERE 
                                        bftlt.genusr        = "ORICO"   AND
                                        bftlt.nor_noti_ins  = trim(wdetail2.safe_no) NO-LOCK NO-ERROR NO-WAIT.
                                    IF NOT AVAIL bftlt THEN DO:  
                                        ASSIGN wdetail2.prevpol  = brstat.tlt.policy
                                               wdetail2.comment  = "COMPLETE"
                                               brstat.tlt.endcnt = 1. /* status load */
                                    END.
                                    ELSE DO:
                                        ASSIGN wdetail2.comment = wdetail2.comment + "|" + wdetail2.safe_no + " มีข้อมูลในถังพักของ ORICO แล้ว".
                                        NEXT.
                                    END.
                                END.
                                ELSE DO:
                                    ASSIGN wdetail2.comment = wdetail2.comment + "|" + wdetail2.safe_no + " มีข้อมูลในระบบพรีเมียมแล้ว".
                                    NEXT.
                                END.
                            END.
                            ELSE DO: 
                                ASSIGN wdetail2.comment = wdetail2.comment + "|" + "กรุณาตรวจสอบข้อมูลเบอร์กรมธรรม์ในระบบและไฟล์แจ้งงานอีกครั้ง".
                                NEXT.
                            END.
                        END.
                    END.
                END.
                /* running policy no */
                IF wdetail2.prevpol = " "  THEN DO:
                    ASSIGN n_br    = "".
                    FIND FIRST brstat.company WHERE Company.CompNo = "ORICO" NO-LOCK NO-ERROR NO-WAIT.
                    IF NOT AVAIL company THEN 
                        MESSAGE "Not fond Company code[n_br ไม่พบอักษรหลังปี]...!!!" "ORICO"      SKIP
                        "Plese Set up Company code. !!!"  VIEW-AS ALERT-BOX.
                    ELSE DO:
                        ASSIGN  
                            n_br   = Company.AbName 
                            nv_notno70 = ""
                            n_poltyp   = "V70"
                            nv_brnpol  = n_brsty + n_br
                            n_undyr2   = string(YEAR(TODAY)) .
                        running_polno:    /*--Running 70 */
                        REPEAT:
                            RUN  wgw\wgwpon03(INPUT    YES,  
                                              INPUT    n_poltyp,
                                              INPUT    nv_brnpol,
                                              INPUT    string(n_undyr2),
                                              INPUT    n_producer,
                                              INPUT-OUTPUT nv_notno70,
                                              INPUT-OUTPUT nv_check).
                            IF nv_notno70 = "" THEN LEAVE running_polno.
                            ELSE DO:
                                FIND LAST  bftlt    WHERE 
                                   (bftlt.genusr   = "Phone"  OR 
                                    bftlt.genusr   = "FAX" )  AND
                                    bftlt.policy   = caps(nv_notno70)  NO-LOCK NO-ERROR NO-WAIT.
                                IF NOT AVAIL bftlt THEN DO:  
                                    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                        sicuw.uwm100.policy = nv_notno70 NO-LOCK NO-ERROR.
                                    IF NOT AVAIL sicuw.uwm100 THEN DO: 
                                        LEAVE running_polno.
                                    END.
                                    ELSE NEXT running_polno.
                                END.
                                ELSE DO: 
                                    NEXT running_polno.
                                END.
                                RELEASE bftlt.
                            END.
                            LEAVE running_polno.
                        END.
                        wdetail2.prevpol = nv_notno70 .
                    END. /* end else */
                END. /* wdetail2.prevpol */

                /*  running V72 */
                IF deci(wdetail2.comp_prm) <>  0 THEN DO:
                   IF brstat.tlt.comp_pol <> "" THEN DO: 
                      nv_check72 = SUBSTR(brstat.tlt.comp_pol,1,2).
                      IF trim(nv_check70) = trim(n_branch) THEN DO:  /* สาขากับเบอร์ตรงกัน */
                        FIND LAST sicsyac.xmm023 WHERE 
                                 ("D" + xmm023.branch = nv_check72) OR 
                                 (xmm023.branch       = nv_check72) NO-LOCK NO-ERROR.
                         IF AVAIL sicsyac.xmm023 THEN DO:
                             FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                       sicuw.uwm100.policy = trim(brstat.tlt.comp_pol) NO-LOCK NO-ERROR.
                             IF NOT AVAIL sicuw.uwm100 THEN DO: 
                                 ASSIGN wdetail2.compno = brstat.tlt.comp_pol.
                             END.
                             ELSE DO:
                                 ASSIGN wdetail2.comment = wdetail2.comment + "|" + brstat.tlt.comp_pol + " มีข้อมูลในระบบพรีเมียมแล้ว".
                                 NEXT.
                             END.
                         END.
                      END.
                   END.

                   IF wdetail2.compno = "" THEN DO:
                       ASSIGN
                            nv_notno72 = ""
                            n_poltyp   = "V72"
                            nv_brnpol  = n_brsty + n_br
                            n_undyr2   = string(YEAR(TODAY)) .
                        running_polno2:   /*--Running Line 72--*/
                        REPEAT:
                            RUN  wgw\wgwpon03(INPUT        YES,  
                                              INPUT        n_poltyp,
                                              INPUT        nv_brnpol,
                                              INPUT        string(n_undyr2),
                                              INPUT        n_producer,
                                              INPUT-OUTPUT nv_notno72,
                                              INPUT-OUTPUT nv_check). 
                            IF nv_notno72 = "" THEN LEAVE running_polno2 .
                            ELSE DO:   /*LEAVE running_polno2 .*/
                                FIND LAST  bftlt    WHERE
                                    (bftlt.genusr     = "Phone"    OR
                                     bftlt.genusr     = "FAX"  )   AND
                                     bftlt.comp_pol   = trim(nv_notno72) NO-LOCK NO-ERROR NO-WAIT.
                                IF NOT AVAIL tlt THEN DO:
                                    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                        sicuw.uwm100.policy = CAPS(nv_notno72) NO-LOCK NO-ERROR.
                                    IF AVAIL sicuw.uwm100 THEN  NEXT running_polno2.
                                    ELSE DO:
                                        ASSIGN
                                            nv_notno72 = CAPS(nv_notno72).
                                        LEAVE running_polno2 .
                                    END.
                                END.
                                ELSE NEXT running_polno2.
                            END. 
                            LEAVE running_polno2 .
                        END.
                        wdetail2.compno = CAPS(nv_notno72).
                   END.
                END. /* wdetail2. comp_pre <>  0 */ 
                ASSIGN wdetail2.comment = "COMPLETE" .
                IF wdetail2.prevpol <> "" AND wdetail2.comment = "COMPLETE" THEN DO: 
                    RUN proc_updatetlt.
                END.
            END. /* end for each tlt */
            IF wdetail2.comment = "" THEN ASSIGN wdetail2.comment = "ไม่มีข้อมูลในระบบ Phone " .
        END. /* end else */
    END. /* end wdetail2. */
    RELEASE brstat.tlt.
    RELEASE wdetail2.
    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportdetail C-Win 
PROCEDURE proc_reportdetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A62-0219      
------------------------------------------------------------------------------*/
DO:
    FOR EACH wdetail  NO-LOCK  .
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.Notify_dat   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.time_notify  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.notifyno     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.comp_code    '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.NAME_mkt     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.cmbr_no      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.cmbr_code    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.branch       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.producer     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.agent        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.deler        '"' SKIP.   /*  Add deler kridtiya i. A56-0024  */       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.campaigno    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.cov_car      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.cov_new      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.covcod       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.product      '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.freeprem     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.freecomp     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.comdat       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.expdat       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.ispno        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.pol70        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.pol72        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.n_TITLE      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.n_name1      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail.idno         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.birthday     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail.birthdayexp  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.occup        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.namedirect   '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail.ADD_1        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail.ADD_2        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail.ADD_3        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.ADD_4        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.ADD_5        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.tel          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.typ_driv     '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail.drivname1    '"' SKIP.                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  wdetail.sex1         '"' SKIP.                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  wdetail.birthdriv1   '"' SKIP.                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail.occup1       '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail.drivno1      '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail.drivname2    '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail.sex2         '"' SKIP.             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  wdetail.birthdriv2   '"' SKIP.                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'  wdetail.occup2       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"'  wdetail.drivno2      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  wdetail.redbook      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"'  wdetail.brand        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"'  wdetail.model        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"'  wdetail.engine       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"'  wdetail.chassis      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"'  wdetail.power        '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  wdetail.cyear        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  wdetail.licence      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  wdetail.provin       '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  wdetail.subclass     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  wdetail.garage       '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  wdetail.ins_amt1     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  wdetail.fi           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  wdetail.prem1        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  wdetail.prem2        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  wdetail.comprem      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  wdetail.prem3        '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  wdetail.deduct       '"' SKIP.  /*A57-0063*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  wdetail.sck          '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  wdetail.ref          '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  wdetail.recivename   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  wdetail.vatcode      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  wdetail.notiuser     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  wdetail.notbr        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  wdetail.bennam       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  wdetail.remak1       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  wdetail.remak2       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  wdetail.other1       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  wdetail.other2       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  wdetail.other3       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"'  wdetail.quotation    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"'  wdetail.ngarage      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"'  wdetail.ispstatus    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"'  wdetail.ta           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"'  wdetail.tp           '"' SKIP.                                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"'  wdetail.td           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"'  wdetail.n41          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"'  wdetail.n42          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"'  wdetail.n43          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"'  wdetail.docno        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"'  wdetail.reinsp       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"'  wdetail.statusco     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"'  wdetail.releas       '"' SKIP.  
    /* End by Phaiboon W. [A59-0488] Date 01/12/2016 */

END.    /*  end  wdetail  */
END.

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
DO:
    fi_remark =  "Update tlt... " +  wdetail2.prevpol . 
    DISP fi_remark WITH FRAME fr_main.

    ASSIGN  nv_notify = "" 
            nv_notify = "เลขรับแจ้ง " + trim(tlt.policy) .
    RUN proc_addr.
    ASSIGN 
       tlt.nor_usr_ins   = trim(wdetail2.Remark)
       tlt.nor_noti_ins  = trim(wdetail2.branch) 
       /*tlt.nor_usr_tlt   = trim(SUBSTR(wdetail2.prevpol,1,2))*/
       tlt.safe3         = IF index(wdetail2.CovTyp,"1") <> 0 THEN "1" 
                           ELSE IF index(wdetail2.CovTyp,"2+") <> 0 THEN "2.2" 
                           ELSE IF index(wdetail2.CovTyp,"3+") <> 0 THEN "3.2"
                           ELSE IF index(wdetail2.CovTyp,"2")  <> 0 THEN "2" ELSE "3"  
       tlt.filler1       = IF wdetail2.InsTyp = "แถม" THEN "แถม" ELSE "ไม่แถม"
       tlt.filler2       = IF wdetail2.comtyp = "แถม" THEN "แถม"
                           ELSE IF wdetail2.comtyp = "ไม่แถม" THEN "ไม่แถม"  
                           ELSE "ไม่เอาพรบ."
       tlt.rec_addr4     = TRIM(wdetail2.DealerName)         /*A56-0024*/
       tlt.colorcod      = IF TRIM(n_brsty) <> "" THEN TRIM(n_brsty) ELSE tlt.colorcod
       tlt.policy        = TRIM(wdetail2.prevpol)       
       tlt.comp_pol      = trim(wdetail2.compno)
       tlt.ins_name      = TRIM(wdetail2.name_insur)
       tlt.endno         = trim(wdetail2.icno)
       tlt.ins_addr1     = TRIM(n_address)  
       tlt.ins_addr2     = trim(n_tambon) 
       tlt.ins_addr3     = TRIM(n_amper)  
       tlt.ins_addr4     = TRIM(n_country)
       tlt.ins_addr5     = TRIM(n_post)   
       tlt.dri_name1     = IF TRIM(wdetail2.drivname1) <> "" THEN trim(n_drive1) + "sex:" + trim(n_sex1)  + "hbd:" + TRIM(n_bdate1) + "age:" +  TRIM(n_age1) + "occ:" + trim(n_occ1) 
                           ELSE "" /*tlt.dri_name1 */
       tlt.dri_no1       = trim(wdetail2.drivid1) 
       tlt.enttim        = IF TRIM(wdetail2.drivname1) <> "" THEN trim(n_drive2) + "sex:" + trim(n_sex2)  + "hbd:" + TRIM(n_bdate2) + "age:" +  TRIM(n_age1) + "occ:" + trim(n_occ1)
                           ELSE ""  /*tlt.enttim*/
       tlt.expotim       = trim(wdetail2.drivid2)
       tlt.nor_effdat    = DATE(wdetail2.comdat)         
       tlt.expodat       = DATE(wdetail2.expdat)
       wdetail2.redbook  = IF INDEX(tlt.brand,"RB:") <> 0 THEN SUBSTR(tlt.brand,R-INDEX(tlt.brand,"RB:") + 3) ELSE "" 
       tlt.brand         = IF trim(wdetail2.redbook) <> "" THEN TRIM(wdetail2.brand) + " RB:" + TRIM(wdetail2.redbook) ELSE TRIM(wdetail2.brand)          
       tlt.model         = trim(wdetail2.Brand_Model)
       tlt.lince2        = trim(wdetail2.yrmanu) 
       tlt.cc_weight     = INT(wdetail2.CC)
       tlt.lince1        = TRIM(wdetail2.RegisNo) + " " + trim(wdetail2.RegisProv)
       tlt.exp           = IF TRIM(wdetail2.garage) = "ซ่อมอู่" THEN "" ELSE "G"      
       tlt.nor_coamt     = DECI(wdetail2.SI)       /*ทุนประกันภัย */
       tlt.sentcnt       = IF tlt.safe3 = "1" THEN DECI(wdetail2.SI) ELSE tlt.sentcnt     /*ทุนสูญหาย ไฟไหม้ */  /*A62-0219*/
       tlt.dri_name2     = TRIM(wdetail2.netprem)
       tlt.nor_grprm     = DECI(wdetail2.totalprem)  
       tlt.comp_coamt    = DECI(wdetail2.comp_prm)  
       tlt.comp_grprm    = DECI(wdetail2.totalprem) + DECI(wdetail2.comp_prmtotal)
       tlt.comp_noti_tlt = trim(wdetail2.Account_no)         
       tlt.rec_name      = trim(wdetail2.taxname)  
       tlt.comp_usr_tlt  = IF INDEX(wdetail2.taxname,"โอริโค่ ออโต้ ลีสซิ่ง") <> 0 THEN "MC38462" ELSE tlt.comp_usr_tlt 
       tlt.comp_usr_ins  = trim(wdetail2.ben_name)
       tlt.OLD_cha       = n_remark1 + n_remark2 + n_other1 + n_other2 +  n_other3 + n_quota + n_garage 
       tlt.endcnt        = 1.

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
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN n_record = 0    nv_cnt   =  0   nv_row   =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Export data by Phone ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "ลำดับที่"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่รับแจ้ง"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "เวลารับแจ้ง"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "เลขรับแจ้งงาน"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "รหัสบรษัท"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "ชื่อเจ้าหน้าที่ MKT"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "รหัสสาขา"                    '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "Code: "                     '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "รหัสสาขา_STY "              '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Producer."                  '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Agent."                     '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Deler"                      '"' SKIP.   /*  Add deler kridtiya i. A56-0024  */              
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "Campaign no."               '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ประเภทประกัน"               '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "ประเภทรถ"                   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "ประเภทความคุ้มครอง"         '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "Product Type"               '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "ประกัน แถม/ไม่แถม"          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "พรบ.   แถม/ไม่แถม"          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "วันเริ่มคุ้มครอง"           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "วันสิ้นสุดความคุ้มครอง"     '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "เลขตรวจสภาพ"                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "เลขกรมธรรม์70"              '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "เลขกรมธรรม์72"              '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "คำนำหน้าชื่อ"               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "ชื่อผู้เอาประกัน"           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "เลขที่บัตรประชาชน"          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "วันเกิด"                    '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "วันที่บัตรหมดอายุ"          '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "อาชีพ"                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "ชื่อกรรมการ"                    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "บ้านเลขที่"                     '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "ตำบล/แขวง"                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "อำเภอ/เขต"                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "จังหวัด"                        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "รหัสไปรษณีย์"                   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "เบอร์โทรศัพท์"                  '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "ระบุผู้ขับขี่/ไม่ระบุผู้ขับขี่" '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "ผู้ขับขี่คนที่1"                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "เพศ"                         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "วันเกิด"                     '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "อาชัพ"                       '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "เลขที่ใบขับขี่"              '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "ผู้ขับขี่คนที่2"             '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "เพศ "                        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "วันเกิด"                     '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "อาชัพ   "                    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "เลขที่ใบขับขี่"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "Redbook       "              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"'  "ชื่อยี่ห้อรถ"               '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"'  "รุ่นรถ"                     '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"'  "เลขเครื่องยนต์"             '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"'  "เลขตัวถัง"                  '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"'  "ซีซี"                       '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  "ปีรถยนต์"                   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  "เลขทะเบียน"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  "จังหวัดที่จดทะเบียน"        '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  "แพคเกจ"                     '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  "การซ่อม"                    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  "ทุนประกัน"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  "ทุนสูญหาย ไฟไหม้"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  "เบี้ยสุทธิ"                 '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  "เบี้ยประกัน"                '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  "เบี้ยพรบ."                  '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  "เบี้ยรวม"                   '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  "DEDUCT"                     '"' SKIP.  /*A57-0063*/   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  "เลขสติ๊กเกอร์"              '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  "เลขReferance no."           '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  "ออกใบเสร็จในนาม"            '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"   '"'  "Vatcode "                   '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"   '"'  "ผู้รับแจ้ง"                 '"' SKIP.  
/* comment by A62-0219 .............
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  "ผู้รับผลประโยชน์"            '"' SKIP.
/* Begin by Phaiboon W. [A59-0488] Date 01/12/2016 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  "หมายเหตุ"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  "complete/not complete"       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  "Yes/No"                      '"' SKIP. */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  "หมายเหตุ 1"                   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  "หมายเหตุ 2"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  "อุปกรณ์เสริม 1"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  "ราคา"                         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  "อุปกรณ์เสริม 2"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  "Quotation No."                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  "Garage"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  "Ststus เลขตรวจสภาพ"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"'  "complete/not complete"        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"'  "Yes/No"                       '"' SKIP.
/* End by Phaiboon W. [A59-0488] Date 01/12/2016 */
.....end a62-0219...*/
/* add A62-0219 */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  "สาขาที่รับแจ้ง"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  "ผู้รับผลประโยชน์"       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  "หมายเหตุ 1"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  "หมายเหตุ 2"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  "อุปกรณ์เสริม 1"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  "ราคา"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  "อุปกรณ์เสริม 2"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"'  "Quotation No."          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"'  "Garage"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"'  "Ststus เลขตรวจสภาพ"     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"'  "TPBI/PER"               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"'  "TPBI/ACC"               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"'  "TPPD/ACC"               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"'  "41"                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"'  "42"                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"'  "43"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"'  "Doc No"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"'  "ผลการตรวจสภาพ"          '"' SKIP.                                                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"'  "complete/not complete"  '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"'  "Yes/No"                 '"' SKIP.
/* end A62-0219 */
RUN proc_reportdetail . /*A62-0219 */
/* comment by A62-0219...
FOR EACH wdetail  NO-LOCK  .
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.Notify_dat   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.time_notify  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.notifyno     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.comp_code    '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.NAME_mkt     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.cmbr_no      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.cmbr_code    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.branch       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.producer     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.agent        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.deler        '"' SKIP.   /*  Add deler kridtiya i. A56-0024  */       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.campaigno    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.cov_car      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.cov_new      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.covcod       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.product      '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.freeprem     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.freecomp     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.comdat       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.expdat       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.ispno        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.pol70        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.pol72        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.n_TITLE      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.n_name1      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail.idno         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.birthday     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail.birthdayexp  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.occup        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.namedirect   '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail.ADD_1        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail.ADD_2        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail.ADD_3        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.ADD_4        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.ADD_5        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.tel          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.typ_driv     '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail.drivname1    '"' SKIP.                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  wdetail.sex1         '"' SKIP.                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  wdetail.birthdriv1   '"' SKIP.                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail.occup1       '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail.drivno1      '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail.drivname2    '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail.sex2         '"' SKIP.             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  wdetail.birthdriv2   '"' SKIP.                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'  wdetail.occup2       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"'  wdetail.drivno2      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  wdetail.brand        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"'  wdetail.model        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"'  wdetail.engine       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"'  wdetail.chassis      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"'  wdetail.power        '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"'  wdetail.cyear        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  wdetail.licence      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  wdetail.provin       '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  wdetail.subclass     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  wdetail.garage       '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  wdetail.ins_amt1     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  wdetail.prem1        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  wdetail.prem2        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  wdetail.comprem      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  wdetail.prem3        '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  wdetail.deduct       '"' SKIP.  /*A57-0063*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  wdetail.sck          '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  wdetail.ref          '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  wdetail.recivename   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  wdetail.vatcode      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  wdetail.notiuser     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  wdetail.bennam       '"' SKIP.  
    
    /* Begin by Phaiboon W. [A59-0488] Date 01/12/2016 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  wdetail.remak1       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  wdetail.statusco     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  wdetail.releas       '"' SKIP.
    */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  wdetail.remak1       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  wdetail.remak2       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  wdetail.other1       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  wdetail.other2       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  wdetail.other3       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  wdetail.quotation    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  wdetail.ngarage      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  wdetail.ispstatus    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"'  wdetail.statusco     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"'  wdetail.releas       '"' SKIP.       
    /* End by Phaiboon W. [A59-0488] Date 01/12/2016 */
END.    /*  end  wdetail  */
....end A62-0219.... */

nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_matchfile_prem C-Win 
PROCEDURE Pro_matchfile_prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail .
    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE  
        sicuw.uwm100.policy =  trim(wdetail.pol70)  NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN DO: 
        IF ((sicuw.uwm100.name1 = "") OR (sicuw.uwm100.comdat = ?)) THEN ASSIGN wdetail.releas = "No" .
        ELSE DO:
            FIND LAST brstat.tlt USE-INDEX tlt06 WHERE 
                brstat.tlt.cha_no        =  trim(wdetail.chassis)     AND 
                /*brstat.tlt.nor_noti_tlt  =  trim(wdetail.notifyno)    AND */
                brstat.tlt.policy        =  trim(wdetail.pol70)       AND
                brstat.tlt.genusr        =  "phone"                   AND 
                brstat.tlt.lotno         =  "ORICO"                   NO-ERROR NO-WAIT.
            IF AVAIL brstat.tlt THEN 
                ASSIGN tlt.releas         =  "yes"
                       wdetail.releas     =  "YES" .
            ELSE ASSIGN wdetail.releas =  "No"  .
            RELEASE brstat.tlt.


             FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                       brstat.tlt.cha_no       = trim(wdetail.chassis)    AND
                       brstat.tlt.nor_noti_tlt = trim(wdetail.notifyno)   AND
                       brstat.tlt.genusr       = "ORICO"                  NO-ERROR NO-WAIT .
            IF AVAIL brstat.tlt THEN 
                ASSIGN brstat.tlt.dat_ins_noti =   TODAY
                       brstat.tlt.nor_noti_ins =   TRIM(wdetail.pol70)
                       brstat.tlt.comp_pol     =   TRIM(wdetail.pol72)
                       brstat.tlt.filler2      =   brstat.tlt.filler2 + " " + trim(wdetail.reinsp)
                       brstat.tlt.rec_addr3    =   TRIM(wdetail.ispno)
                       brstat.tlt.releas       =   "YES"
                       wdetail.releas          =   "YES" .
            ELSE ASSIGN wdetail.RELEAS = "NO" .

            RELEASE brstat.tlt.


        END.
    END.
    ELSE ASSIGN wdetail.releas = "No" .   /*not found ....*/
END.      /* wdetail*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

