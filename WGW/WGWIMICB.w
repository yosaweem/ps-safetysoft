&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
File: 
Description: 
Input Parameters:<none>
Output Parameters:<none>
Author: 
Created: ------------------------------------------------------------------------*/
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
wgwimtis.w :  Import text file from  ICBCTL  to create new policy Add in table tlt( brstat)  
Program Import Text File    - File detail insured 
                            -  File detail Driver
Create  by   : Ranu i.  [A59-288]  date. 26/09/2016
copy program : wgwimicb.w  
Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW (not connect dbstat)
Modify by    : Ranu I. A60-0263 Date 12/06/2017 เพิ่มการเก็บข้อมูลแคมเปญ จากไฟล์งานป้ายแดง
Modify by    : Ranu I. A62-0082 date 11/02/2019 เพิ่มช่อง  agent 
Modify by    : Krittapoj S. A65-0372  date 16/01/2023 เพิ่มช่อง Colorcode Colordes
+++++++++++++++++++++++++++++++++++++++++++++++*/
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC  INIT   Yes.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD n_no          AS CHAR FORMAT "X(3)"   INIT ""  /*No                   */          
    FIELD Pro_off       AS CHAR FORMAT "X(10)"  INIT ""  /*InsComp              */          
    FIELD branch        AS CHAR FORMAT "X(2)"   INIT ""  /*OffCde               */          
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
    FIELD wht           AS CHAR FORMAT "X(10)"  INIT ""  /*InsuranceWHT         */          
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
    FIELD branch_saf    AS CHAR FORMAT "x(2)" INIT ""
    FIELD comp_prmtotal AS CHAR FORMAT "x(10)" INIT ""
    FIELD producer      AS CHAR FORMAT "x(10)" INIT ""
    FIELD n_class70     AS CHAR FORMAT "x(5)"  INIT ""
    FIELD otherins      AS CHAR FORMAT "x(100)" INIT ""
    FIELD campaign      AS CHAR FORMAT "x(20)" INIT "" /*A60-0263*/
    FIELD colordes      AS CHAR FORMAT "x(20)" INIT "" /*Add by krittapoj S. A65-0372 16/01/2023*/
    FIELD colorcode     AS CHAR FORMAT "x(6)" INIT "". /*Add by Krittapoj S. A65-0372 16/01/2023*/

DEFINE NEW SHARED WORKFILE wtlt NO-UNDO
    FIELD trndat        AS CHAR FORMAT "x(15)"  INIT ""
    FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""   /*เลขที่รับแจ้ง         */           
    FIELD branch        AS CHAR FORMAT "X(4)"   INIT ""   /*สาขา                  */           
    FIELD Account_no    AS CHAR FORMAT "X(12)"  INIT ""   /*เลขที่สัญญา           */           
    FIELD prev_pol      AS CHAR FORMAT "X(15)"  INIT ""   /*เลขที่กรมธรรม์เดิม    */           
    FIELD name_insur    AS CHAR FORMAT "X(100)" INIT ""   /*ชื่อผู้เอาประกันภัย   */           
    FIELD comdat        AS CHAR FORMAT "X(15)"  INIT ""   /*วันที่เริ่มคุ้มครอง   */           
    FIELD expdat        AS CHAR FORMAT "X(15)"  INIT ""   /*วันที่สิ้นสุดคุ้มครอง */           
    FIELD comdat72      AS CHAR FORMAT "X(15)"  INIT ""   /*วันทีเริ่มคุ้มครองพรบ */           
    FIELD expdat72      AS CHAR FORMAT "X(15)"  INIT ""   /*วันที่สิ้นสุดคุ้มครองพรบ*/         
    FIELD licence       AS CHAR FORMAT "X(11)"  INIT ""   /*เลขทะเบียน            */           
    FIELD province      AS CHAR FORMAT "X(30)"  INIT ""   /*จังหวัด               */           
    FIELD ins_amt       AS CHAR FORMAT "X(15)"  INIT ""   /*ทุนประกัน             */           
    FIELD prem1         AS CHAR FORMAT "X(15)"  INIT ""   /*เบี้ยประกันรวม        */           
    FIELD comp_prm      AS CHAR FORMAT "X(15)"  INIT ""   /*เบี้ยพรบรวม           */           
    FIELD gross_prm     AS CHAR FORMAT "X(15)"  INIT ""   /*เบี้ยรวม              */           
    FIELD compno        AS CHAR FORMAT "X(13)"  INIT ""   /*เลขกรมธรรม์พรบ        */           
    FIELD sckno         AS CHAR FORMAT "X(15)"  INIT ""   /*เลขที่สติ๊กเกอร์ */           
    FIELD not_date      AS CHAR FORMAT "X(15)"  INIT ""   /*วันที่รับแจ้ง         */           
    FIELD not_office    AS CHAR FORMAT "X(35)"  INIT ""   /*ชื่อประกันภัย         */           
    FIELD not_name      AS CHAR FORMAT "X(50)"  INIT ""   /*ผู้แจ้ง               */           
    FIELD brand         AS CHAR FORMAT "X(15)"  INIT ""   /*ยี่ห้อ                */           
    FIELD Brand_Model   AS CHAR FORMAT "X(35)"  INIT ""   /*รุ่น                  */           
    FIELD yrmanu        AS CHAR FORMAT "X(10)"  INIT ""   /*ปี                    */           
    FIELD weight        AS CHAR FORMAT "X(10)"  INIT ""   /*ขนาดเครื่อง           */           
    FIELD engine        AS CHAR FORMAT "X(20)"  INIT ""   /*เลขเครื่อง            */           
    FIELD chassis       AS CHAR FORMAT "X(20)"  INIT ""    /*เลขถัง                */
    FIELD camp          AS CHAR FORMAT "x(10)"  INIT ""
    FIELD campaign      AS CHAR FORMAT "x(20)"  INIT ""   /*A60-0263*/
    FIELD colorcode     AS CHAR FORMAT "x(6)"   INIT ""   /*Add by Krittapoj S. A65-0372 16/01/2023*/
    FIELD colordes      AS CHAR FORMAT "x(20)"  INIT "" . /*Add by Krittapoj S. A65-0372 16/01/2023*/
/*------------------------------ข้อมูลผู้ขับขี่ -------------------------*/
/*DEFINE WORKFILE  wdriver NO-UNDO
    FIELD RecordID     AS CHAR FORMAT "X(02)"   INIT ""     /*1 Detail Record "D"*/
    FIELD Pro_off      AS CHAR FORMAT "X(20)"   INIT ""     /*2 รหัสสาขาที่ผู้เอาประกันเปิดบัญชี    */
    FIELD chassis      AS CHAR FORMAT "X(25)"   INIT ""     /*3 หมายเลขตัวถัง    */
    FIELD dri_no       AS CHAR FORMAT "X(02)"   INIT ""     /*4 ลำดับที่คนขับ  */
    FIELD dri_name     AS CHAR FORMAT "X(40)"   INIT ""     /*5 ชื่อคนขับ   */
    FIELD Birthdate    AS CHAR FORMAT "X(10)"   INIT ""     /*6 วันเดือนปีเกิด  */
    FIELD occupn       AS CHAR FORMAT "X(75)"   INIT ""     /*7 อาชีพ*/
    FIELD position     AS CHAR FORMAT "X(40)"   INIT ""  .  /*8 ตำแหน่งงาน */*/
DEF  STREAM nfile.  
DEF VAR nv_accdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_comdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_expdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_comdat72   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_expdat72   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_notdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_nottim   AS Char   Format "X(8)"         no-undo.
DEF VAR nv_comchr   AS CHAR   . 
DEF VAR nv_dd       AS INT    FORMAT "99".
DEF VAR nv_mm       AS INT    FORMAT "99".
DEF VAR nv_yy       AS INT    FORMAT "9999".
DEF VAR nv_cpamt1   AS DECI   INIT 0.
DEF VAR nv_cpamt2   AS DECI   INIT 0.
DEF VAR nv_cpamt3   AS DECI   INIT 0   format  ">,>>>,>>9.99".
DEF VAR nv_coamt1   AS DECI   INIT 0.  
DEF VAR nv_coamt2   AS DECI   INIT 0.  
DEF VAR nv_coamt3   AS DECI   INIT 0   format ">,>>>,>>9.99".
DEF VAR nv_insamt1  AS DECI   INIT 0.  
DEF VAR nv_insamt2  AS DECI   INIT 0.  
DEF VAR nv_insamt3  AS DECI   INIT 0   Format  ">>,>>>,>>9.99".
DEF VAR nv_premt1   AS DECI   INIT 0.  
DEF VAR nv_premt2   AS DECI   INIT 0.  
DEF VAR nv_premt3   AS DECI   INIT 0   Format ">,>>>,>>9.99".
DEF VAR nv_fleet1   AS DECI   INIT 0.  
DEF VAR nv_fleet2   AS DECI   INIT 0.  
DEF VAR nv_fleet3   AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_ncb1     AS DECI   INIT 0.  
DEF VAR nv_ncb2     AS DECI   INIT 0.  
DEF VAR nv_ncb3     AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_oth1     AS DECI   INIT 0.  
DEF VAR nv_oth2     AS DECI   INIT 0.  
DEF VAR nv_oth3     AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_deduct1  AS DECI   INIT 0.  
DEF VAR nv_deduct2  AS DECI   INIT 0.  
DEF VAR nv_deduct3  AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_power1   AS DECI   INIT 0.  
DEF VAR nv_power2   AS DECI   INIT 0.  
DEF VAR nv_power3   AS DECI   INIT 0   Format ">,>>9.99".
DEF VAR nv_name1    AS CHAR   INIT  ""  Format "X(50)".
DEF VAR nv_ntitle   AS CHAR   INIT  ""  Format  "X(10)". 
DEF VAR nv_titleno  AS INT    INIT  0   .  
DEF VAR nv_policy   AS CHAR   INIT  ""  Format  "X(12)".
DEF VAR nv_oldpol   AS CHAR   INIT  ""  .
def var nv_source   as char   FORMAT  "X(35)".
def var nv_indexno  as int    init  0.
def var nv_indexno1 as int    init  0.
def var nv_cnt      as int    init  1.
def var nv_addr     as char   extent 4  format "X(35)".
def var nv_pol      as char   init  "".
def var nv_newpol   as char   init  "".
DEF VAR nn_remark1  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nn_remark2  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nn_remark3  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nv_len      AS INTE INIT 0.    /*A56-0399*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_imptxt

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wtlt

/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt wtlt.trndat wtlt.Notify_no wtlt.branch wtlt.Account_no wtlt.prev_pol wtlt.name_insur wtlt.comdat wtlt.expdat wtlt.comdat72 wtlt.expdat72 wtlt.licence wtlt.province wtlt.ins_amt wtlt.prem1 wtlt.comp_prm wtlt.gross_prm wtlt.compno wtlt.not_date wtlt.not_office wtlt.not_name wtlt.brand wtlt.Brand_Model wtlt.yrmanu wtlt.weight wtlt.engine wtlt.chassis wtlt.colordes /*Add by Krittapoj S. A65-0372 16/01/2023*/ wtlt.colorcode /*Add by Krittapoj S. A65-0372 16/01/2023*/   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt   
&Scoped-define SELF-NAME br_imptxt
&Scoped-define QUERY-STRING-br_imptxt FOR EACH wtlt NO-LOCK
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY {&SELF-NAME} FOR EACH wtlt NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_imptxt wtlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt wtlt


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_imptxt}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_compa fi_agent fi_filename ~
bu_file bu_ok bu_exit br_imptxt rs_type RECT-1 RECT-79 RECT-80 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_compa fi_agent fi_filename ~
fi_impcnt fi_completecnt fi_dir_cnt fi_dri_complet rs_type fi_agentname 

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
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agentname AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 39 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dir_cnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dri_complet AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 76 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "งานป้ายแดง", 1,
"งานต่ออายุ", 2
     SIZE 56 BY .95
     BGCOLOR 28 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.81
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-79
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-80
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.91
     BGCOLOR 4 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_imptxt FOR 
      wtlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _FREEFORM
  QUERY br_imptxt NO-LOCK DISPLAY
      wtlt.trndat       COLUMN-LABEL "วันที่โหลดข้อมูล"    FORMAT "x(15)"
      wtlt.Notify_no    COLUMN-LABEL "เลขที่รับแจ้ง"       FORMAT "x(20)"
      wtlt.branch       COLUMN-LABEL "สาขา"                FORMAT "XX"               
      wtlt.Account_no   COLUMN-LABEL "เลขที่สัญญา"         FORMAT "x(18)"            
      wtlt.prev_pol     COLUMN-LABEL "เลขที่กรมธรรม์เดิม"  FORMAT "x(15)"            
      wtlt.name_insur   COLUMN-LABEL "ชื่อผู้เอาประกันภัย" FORMAT "X(50)"       
      wtlt.comdat       COLUMN-LABEL "วันที่คุ้มครอง"      FORMAT "X(15)"       
      wtlt.expdat       COLUMN-LABEL "วันที่สิ้นสุด"       FORMAT "X(15)"       
      wtlt.comdat72     COLUMN-LABEL "วันทีคุ้มครอง พรบ"   FORMAT "X(15)"       
      wtlt.expdat72     COLUMN-LABEL "วันที่สิ้นสุด พรบ"   FORMAT "X(15)"       
      wtlt.licence      COLUMN-LABEL "เลขทะเบียน"          FORMAT "x(25)"            
      wtlt.province     COLUMN-LABEL "จังหวัด"             FORMAT "X(20)"            
      wtlt.ins_amt      COLUMN-LABEL "ทุนประกัน"           FORMAT "X(15)"                     
      wtlt.prem1        COLUMN-LABEL "เบี้ยประกันรวม"      FORMAT "X(15)"                              
      wtlt.comp_prm     COLUMN-LABEL "เบี้ยพรบรวม"         FORMAT "X(15)"                 
      wtlt.gross_prm    COLUMN-LABEL "เบี้ยรวม"            FORMAT "X(15)"                    
      wtlt.compno       COLUMN-LABEL "เลขกรมธรรม์พรบ"      FORMAT "x(15)"  
      wtlt.not_date     COLUMN-LABEL "วันที่รับแจ้ง"       FORMAT "x(15)"   
      wtlt.not_office   COLUMN-LABEL "ชื่อประกันภัย"       FORMAT "x(20)"     
      wtlt.not_name     COLUMN-LABEL "ผู้แจ้ง"             FORMAT "x(30)"      
      wtlt.brand        COLUMN-LABEL "ยี่ห้อ"              FORMAT "x(20)"                    
      wtlt.Brand_Model  COLUMN-LABEL "รุ่น"                FORMAT "x(20)"                        
      wtlt.yrmanu       COLUMN-LABEL "ปี"                  FORMAT "X(4)"          
      wtlt.weight       COLUMN-LABEL "ขนาดเครื่อง"         FORMAT "X(10)"       
      wtlt.engine       COLUMN-LABEL "เลขเครื่อง"          FORMAT "x(20)"                                                                               
      wtlt.chassis      COLUMN-LABEL "เลขถัง"              FORMAT "x(20)"
      wtlt.colordes     COLUMN-LABEL "สีรถ"                FORMAT "x(20)"  /*Add by Krittapoj S. A65-0372 16/01/2023*/
      wtlt.colorcode    COLUMN-LABEL "รหัสสี"              FORMAT "x(6)"   /*Add by Krittapoj S. A65-0372 16/01/2023*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128 BY 14.52
         BGCOLOR 19 FGCOLOR 2 FONT 4 ROW-HEIGHT-CHARS .71 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 1.52 COL 38 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.52 COL 72 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.76 COL 38 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     fi_filename AT ROW 4.91 COL 38 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 4.95 COL 116.33
     bu_ok AT ROW 6.62 COL 99.5
     bu_exit AT ROW 6.62 COL 110.83
     br_imptxt AT ROW 9.57 COL 3.17
     fi_impcnt AT ROW 6.1 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 6.1 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_dir_cnt AT ROW 7.19 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_dri_complet AT ROW 7.19 COL 75.17 COLON-ALIGNED NO-LABEL
     rs_type AT ROW 2.62 COL 40 NO-LABEL
     fi_agentname AT ROW 3.76 COL 55.67 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 6.1 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 6.1 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "           กรุณาป้อนชื่อไฟล์นำเข้า :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 4.86 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " ข้อมูลแจ้งประกันนำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 6 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "  รายละเอียดข้อมูล" VIEW-AS TEXT
          SIZE 128.5 BY .81 AT ROW 8.71 COL 2.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                        ประเภทงาน :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 2.57 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                   วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.52 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "        ข้อมูลผู้ขับขี่นำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 7.1 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                      Agent Code  :" VIEW-AS TEXT
          SIZE 28.83 BY 1 AT ROW 3.71 COL 10.5 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 7.19 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 7.19 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 7.19 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.52 COL 57.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 6.1 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1 COL 1
     RECT-79 AT ROW 6.24 COL 98
     RECT-80 AT ROW 6.24 COL 109.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
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
         TITLE              = "Hold Data Text file Thanachat (Renew)"
         HEIGHT             = 24
         WIDTH              = 132
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
IF NOT C-Win:LOAD-ICON("I:/Safety/WALP10/WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: I:/Safety/WALP10/WIMAGE/safety.ico"
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
/* BROWSE-TAB br_imptxt bu_exit fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agentname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dir_cnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dri_complet IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_imptxt
/* Query rebuild information for BROWSE br_imptxt
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wtlt NO-LOCK.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Hold Data Text file Thanachat (Renew) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Hold Data Text file Thanachat (Renew) */
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
  Apply "Close" To  This-procedure.
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
        /*      FILTERS    "Text Documents" "*.txt"    */
        FILTERS    /* "Text Documents"   "*.txt",
        "Data Files (*.*)"     "*.*"*/
        "Text Documents" "*.csv"
        
        
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
    ASSIGN 
        nv_daily   =  ""
        nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    For each  wtlt:
        DELETE  wtlt.
    END.
    IF fi_Agent = ""  THEN DO:
        MESSAGE "กรุณาระบุ Agent Code " VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_agent .
        RETURN NO-APPLY .
    END.
    IF rs_type = 1 THEN Run  Import_New.    /*ป้ายแดง*/
    ELSE IF rs_type = 2 THEN Run  Import_renew. /* ต่ออายุ */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent =  INPUT  fi_agent.
    fi_agent =  TRIM(fi_agent) .

    FIND LAST sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_agent  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_agent.
            RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO:
            ASSIGN
                fi_agentname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_agent =  trim(caps(INPUT fi_agent)). 
        END.
   Disp  fi_agent fi_agentname  WITH Frame  fr_main.   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compa C-Win
ON LEAVE OF fi_compa IN FRAME fr_main
DO:
    fi_compa =  INPUT  fi_compa.
    Disp  fi_compa   WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename .
  Disp  fi_filename with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp fi_loaddat  with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type C-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type.
    /* A62-0082*/
    IF  rs_type  = 1 THEN ASSIGN  fi_agent = "" .
    ELSE IF rs_type  = 2 THEN ASSIGN   fi_agent = "".
    /* end A62-0082 */
    DISP rs_type  fi_agent WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_imptxt
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
  
  gv_prgid = "wgwimicb".
  gv_prog  = "Hold Text File ICBC".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */
 
  Hide Frame  fr_gen  .
  ASSIGN  
      fi_loaddat  =  today
      fi_compa    = "ICBCTL"
      rs_type     = 1
      fi_agent    = "" . /*A62-0082*/
      /*ra_txttyp   = 1 
      ra_txttyp2  = 1 .*/
  disp  fi_loaddat  fi_agent fi_compa rs_type with  frame  fr_main.
  
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
  DISPLAY fi_loaddat fi_compa fi_agent fi_filename fi_impcnt fi_completecnt 
          fi_dir_cnt fi_dri_complet rs_type fi_agentname 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loaddat fi_compa fi_agent fi_filename bu_file bu_ok bu_exit 
         br_imptxt rs_type RECT-1 RECT-79 RECT-80 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_New C-Win 
PROCEDURE Import_New :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR   nv_ncb  as  char  init  "" format "X(5)".*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"         
            wdetail.n_no          /*No                   */  
            wdetail.Pro_off       /*InsComp              */  
            wdetail.branch        /*OffCde               */  
            wdetail.safe_no       /*InsuranceReceivedNo  */  
            wdetail.Account_no    /*ApplNo               */  
            wdetail.name_insur    /*CustName             */  
            wdetail.icno          /*IDNo                 */  
            wdetail.garage        /*RepairType           */  
            wdetail.CustAge       /*CustAge              */  
            wdetail.Category      /*Category             */  
            wdetail.CarType       /*CarType              */  
            wdetail.brand         /*Brand                */  
            wdetail.Brand_Model   /*Model                */  
            wdetail.CC            /*CC                   */  
            wdetail.yrmanu        /*CarYear              */  
            wdetail.RegisDate     /*RegisDate            */  
            wdetail.engine        /*EngineNo             */  
            wdetail.chassis       /*ChassisNo            */  
            wdetail.RegisNo       /*RegisNo              */  
            wdetail.RegisProv     /*RegisProv            */  
            wdetail.n_class       /*InsLicTyp            */  
            wdetail.InsTyp        /*InsTyp               */  
            wdetail.CovTyp        /*CovTyp               */  
            wdetail.SI            /*InsuranceAmt (crash) */  
            wdetail.FI            /*InsuranceAmt (loss)  */  
            wdetail.comdat        /*InsuranceStartDate   */  
            wdetail.expdat        /*InsuranceExpireDate  */  
            wdetail.netprem       /*InsuranceNetFee      */  
            wdetail.totalprem     /*InsuranceFee         */  
            wdetail.wht           /*InsuranceWHT         */  
            wdetail.ben_name      /*Beneficiary          */  
            wdetail.CMRName       /*CMRName              */  
            wdetail.sckno         /*InsurancePolicyNo    */  
            wdetail.comdat72      /*LawInsStartDate      */  
            wdetail.expdat72      /*LawInsEndDate        */  
            wdetail.comp_prm      /*LawInsFee            */  
            wdetail.Remark        /*Other                */  
            wdetail.DealerName    /*DealerName           */  
            wdetail.CustAddress   /*CustAddress          */  
            wdetail.CustTel       /*CustTel              */
            wdetail.Otherins      /* Otherins            */ 
            wdetail.campaign      /* campaign            */  /*A60-0263*/
            wdetail.colordes      /*color name           */  /*Add by Krittapoj S. A65-0372 16/01/2023*/
            wdetail.colorcode.    /*color code           */  /*Add by Krittapoj S. A65-0372 16/01/2023*/
            

    IF INDEX(wdetail.n_no,"No")   <> 0 THEN  DELETE wdetail.
    ELSE IF  wdetail.n_no         = "" THEN  DELETE wdetail.
END.  /* repeat  */
ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 
Run proc_Create_tltnew.
If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt With frame fr_main.
End. 
fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Complete"  View-as alert-box.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_Renew C-Win 
PROCEDURE import_Renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"        
            wdetail.Pro_off         /*ชื่อบริษัทประกัน*/ 
            wdetail.safe_no         /*เลขรับแจ้ง      */ 
            wdetail.Prevpol         /*เลขกธ.เดิม      */ 
            wdetail.Account_no      /*เลขสัญญา        */ 
            wdetail.name_insur      /*ชื่อลูกค้า      */ 
            wdetail.icno            /*ID              */ 
            wdetail.CarType         /*ประเภทรถยนต์    */ 
            wdetail.brand           /*ยี่ห้อ          */ 
            wdetail.Brand_Model     /*รุ่นรถ          */ 
            wdetail.CC              /*cc              */ 
            wdetail.yrmanu          /*ปีรถ            */ 
            wdetail.engine          /*เลขเครื่อง      */ 
            wdetail.chassis         /*เลขถัง          */ 
            wdetail.RegisNo         /*ทะเบียน         */ 
            wdetail.RegisProv       /*จังหวัด         */ 
            wdetail.n_class         /*ประเภทจดทะเบียน */ 
            wdetail.CovTyp          /*ความคุ้มครอง    */ 
            wdetail.SI              /*ทุนชน           */ 
            wdetail.FI              /*ทุนหาย          */ 
            wdetail.comdat          /*วันคุ้มครอง     */ 
            wdetail.expdat          /*วันหมดอายุ      */ 
            wdetail.netprem         /*เบี้ยสุทธิ      */ 
            wdetail.totalprem       /*เบี้ยรวม        */ 
            wdetail.CMRName         /*ผู้แจ้ง(ปีต่อ)  */ 
            wdetail.sckno           /*เลขบาร์โค๊ต     */ 
            wdetail.ben_name        /*ผู้รับผลประโยขน์*/ 
            wdetail.Remark          /*หมายเหตุ        */ 
            wdetail.colordes        /*สีรถ            */   /*Add by Krittapoj S. A65-0372 16/01/2023*/
            wdetail.colorcode.      /*รหัสสี รถ       */   /*Add by Krittapoj S. A65-0372 16/01/2023*/           
    IF      INDEX(wdetail.Pro_off,"งาน")    <> 0 THEN  DELETE wdetail.
    ELSE IF INDEX(wdetail.Pro_off,"ชื่อ")   <> 0 THEN  DELETE wdetail.
    ELSE IF  wdetail.Pro_off           = "" THEN  DELETE wdetail.
END.  /* repeat  */
ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 
Run proc_Create_tltrenew.
If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt With frame fr_main.
End. 
fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Complete"  View-as alert-box.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pol_cutchar C-Win 
PROCEDURE pol_cutchar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
nv_c = wdetail.prevpol.
nv_i = 0.
nv_l = LENGTH(nv_c).
DO WHILE nv_i <= nv_l:
    ind = 0.
    ind = INDEX(nv_c,"/").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"\").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"-").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"*").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"#").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c," ").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN
    wdetail.prevpol = nv_c .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_address C-Win 
PROCEDURE proc_address :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
  
------------------------------------------------------------------------------*/
IF rs_type = 1 THEN DO:  /* ปีแรก */
    IF TRIM(wdetail.CustAddress) <> " " THEN DO:
        DO WHILE INDEX(wdetail.CustAddress,"  ") <> 0 :
            ASSIGN wdetail.CustAddress = REPLACE(wdetail.CustAddress,"  "," ").
        END.
        ASSIGN wdetail.addr1 = ""
               wdetail.addr2 = ""
               wdetail.addr3 = ""
               wdetail.addr4 = ""
               wdetail.addr1 = TRIM(wdetail.CustAddress).
    END.
    
    IF index(wdetail.cartype,"ทรัพย์สินใหม่") <> 0  THEN ASSIGN wdetail.producer = "A0M0080".
    ELSE ASSIGN wdetail.producer = "A0M0079".
    
    
    IF wdetail.Category <> "" THEN DO:
     IF index(wdetail.Category," ") <> 0 THEN ASSIGN wdetail.Category = REPLACE(wdetail.Category," ","").
     ELSE ASSIGN wdetail.Category = TRIM(wdetail.Category).
    END.

    IF wdetail.covtyp <> "" THEN DO:
         IF index(wdetail.covtyp," ") <> 0 THEN ASSIGN wdetail.covtyp = REPLACE(wdetail.covtyp," ","").
         ELSE ASSIGN wdetail.covtyp = TRIM(wdetail.covtyp).
    END.
    
    IF wdetail.producer = "A0M0080" AND (TRIM(wdetail.brand) = "ISUZU" OR TRIM(wdetail.brand) = "อีซูซุ" ) THEN DO:
        ASSIGN wdetail.n_class70 = IF INDEX(wdetail.covtyp,"1")       <> 0 THEN "Z210"     
                                   ELSE IF INDEX(wdetail.covtyp,"2")  <> 0 THEN "Y210" 
                                   ELSE IF INDEX(wdetail.covtyp,"3")  <> 0 THEN "R210" 
                                   ELSE IF INDEX(wdetail.covtyp,"2+") <> 0 THEN "C210" 
                                   ELSE IF INDEX(wdetail.covtyp,"3+") <> 0 THEN "C210"
                                   ELSE "B210".
    END.
    ELSE DO:
        FIND FIRST brstat.insure WHERE brstat.insure.compno = "ICBC_PACK" AND
                                       index(brstat.insure.text2,TRIM(wdetail.Category)) <> 0 AND
                                       brstat.insure.text1  = TRIM(wdetail.covtyp) NO-LOCK NO-ERROR.
        IF AVAIL brstat.insure THEN DO:
            ASSIGN wdetail.n_class70 = trim(brstat.insure.text3) + trim(brstat.insure.text4).
        END.
        ELSE 
            ASSIGN wdetail.n_class70 = "".
    END.
END.
ELSE DO: /*ต่ออายุ */
    IF TRIM(wdetail.remark) <> " " THEN DO:
        DO WHILE INDEX(wdetail.remark,"  ") <> 0 :
            ASSIGN wdetail.remark = REPLACE(wdetail.remark,"  "," ").
        END.
        IF INDEX(wdetail.remark,"ตำบล") <> 0 OR INDEX(wdetail.remark,"แขวง") <> 0 OR
           INDEX(wdetail.remark,"อำเภอ") <> 0 OR INDEX(wdetail.remark,"เขต") <> 0 THEN
            ASSIGN wdetail.addr1 = ""
                   wdetail.addr2 = ""
                   wdetail.addr3 = ""
                   wdetail.addr4 = ""
                   wdetail.addr1 = TRIM(wdetail.remark).
        ELSE 
            ASSIGN wdetail.addr1 = ""                    
                   wdetail.addr2 = ""                    
                   wdetail.addr3 = ""                    
                   wdetail.addr4 = ""                    
                   wdetail.addr1 = "". 
    END.
        
    IF wdetail.cartype <> "" THEN DO:
      IF index(wdetail.cartype," ") <> 0 THEN ASSIGN wdetail.cartype = REPLACE(wdetail.cartype," ","").
      ELSE ASSIGN wdetail.cartype = TRIM(wdetail.cartype).
    END.
    IF wdetail.covtyp <> "" THEN DO:
         IF index(wdetail.covtyp," ") <> 0 THEN ASSIGN wdetail.covtyp = REPLACE(wdetail.covtyp," ","").
         ELSE ASSIGN wdetail.covtyp = TRIM(wdetail.covtyp).
    END.
    
    FIND FIRST brstat.insure WHERE brstat.insure.compno = "ICBC_PACK" AND
                                   index(brstat.insure.text2,TRIM(wdetail.cartype)) <> 0 AND
                                   brstat.insure.text1  = TRIM(wdetail.covtyp) NO-LOCK NO-ERROR.
    IF AVAIL brstat.insure THEN DO:
        ASSIGN wdetail.n_class70 = trim(brstat.insure.text3) + trim(brstat.insure.text4).
    END.
    ELSE 
        ASSIGN wdetail.n_class70 = "".
END.

IF LENGTH(wdetail.addr1) > 35  THEN DO:
    loop_add01:
    DO WHILE LENGTH(wdetail.addr1) > 35 :
        IF r-INDEX(wdetail.addr1," ") <> 0 THEN DO:
            ASSIGN 
                wdetail.addr2  = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1," "))) + " " + wdetail.addr2
                wdetail.addr1  = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1," "))).
        END.
        ELSE LEAVE loop_add01.
    END.
    loop_add02:
    DO WHILE LENGTH(wdetail.addr2) > 35 :
        IF r-INDEX(wdetail.addr2," ") <> 0 THEN DO:
            ASSIGN 
                wdetail.addr3  = trim(SUBSTR(wdetail.addr2,r-INDEX(wdetail.addr2," "))) + " " + wdetail.addr3
                wdetail.addr2  = trim(SUBSTR(wdetail.addr2,1,r-INDEX(wdetail.addr2," "))).
        END.
        ELSE LEAVE loop_add02.
    END.
    loop_add03:
    DO WHILE LENGTH(wdetail.addr3) > 35 :
        IF r-INDEX(wdetail.addr3 ," ") <> 0 THEN DO:
            ASSIGN 
                wdetail.addr4 = trim(SUBSTR(wdetail.addr3,r-INDEX(wdetail.addr3," "))) + " " + wdetail.addr4
                wdetail.addr3 = trim(SUBSTR(wdetail.addr3,1,r-INDEX(wdetail.addr3," "))).
        END.
        ELSE LEAVE loop_add03.
    END.
END.

/*
IF index(wdetail.cartype,"ทรัพย์สินใหม่") <> 0  THEN ASSIGN wdetail.producer = "A0M0080".
ELSE ASSIGN wdetail.producer = "A0M0079".

MESSAGE " 1" wdetail.category wdetail.covtyp VIEW-AS ALERT-BOX.
IF wdetail.Category <> "" THEN DO:
 IF index(wdetail.Category," ") <> 0 THEN ASSIGN wdetail.Category = REPLACE(wdetail.Category," ","").
 ELSE ASSIGN wdetail.Category = TRIM(wdetail.Category).
END.
IF wdetail.covtyp <> "" THEN DO:
     IF index(wdetail.covtyp," ") <> 0 THEN ASSIGN wdetail.covtyp = REPLACE(wdetail.covtyp," ","").
     ELSE ASSIGN wdetail.covtyp = TRIM(wdetail.covtyp).
END.

MESSAGE "2 " wdetail.category wdetail.covtyp VIEW-AS ALERT-BOX.
FIND FIRST brstat.insure WHERE brstat.insure.compno = "ICBC_PACK" AND
                               index(brstat.insure.text2,TRIM(wdetail.Category)) <> 0 AND
                               brstat.insure.text1  = TRIM(wdetail.covtyp) NO-LOCK NO-ERROR.
IF AVAIL brstat.insure THEN
    ASSIGN wdetail.n_class70 = brstat.insure.text3 + brstat.insure.text4.
ELSE 
    ASSIGN wdetail.n_class70 = "".
*/

/*
FIND FIRST stat.insure USE-INDEX insure01  WHERE 
       stat.Insure.compno   = "ICBC_BR"          AND
       stat.insure.insno    = TRIM(wdetail.branch)  NO-LOCK  NO-ERROR.
   IF AVAIL stat.insure THEN  
       ASSIGN  wdetail.branch_saf = stat.insure.branch.
   ELSE wdetail.branch_saf = "M".
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tltnew C-Win 
PROCEDURE proc_create_tltnew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS INT INIT 0.
LOOP_wdetail:
FOR EACH wdetail .
    IF  wdetail.Pro_off    = "" THEN  DELETE wdetail.
    ELSE /*IF wdetail.comdat <> "" AND wdetail.expdat <> "" THEN*/ DO:
    ASSIGN   
            nv_policy    = ""   nv_oldpol    = ""
            nv_comdat    = ?    nv_expdat    = ?  
            nv_comdat72  = ?    nv_expdat72  = ?    nv_accdat  =  ?
            nv_comchr  = ""     nv_addr    = ""     nv_name1   =  ""     
            nv_ntitle  = ""     nv_titleno = 0      nv_policy  =  ""
            nv_dd      = 0      nv_mm      = 0      nv_yy      =  0
            nv_cpamt1  = 0      nv_cpamt2  = 0      nv_cpamt3  =  0
            nv_coamt1  = 0      nv_coamt2  = 0      nv_coamt3  =  0         
            nv_insamt1 = 0      nv_insamt2 = 0      nv_insamt3 =  0
            nv_premt1  = 0      nv_premt2  = 0      nv_premt3  =  0
            nv_newpol  = ""     nv_reccnt  = nv_reccnt + 1
            wdetail.engine = REPLACE(wdetail.engine,"*","").
        IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    /* A56-0399 */
        ELSE ASSIGN nn_remark1  = trim(wdetail.remark)
            nn_remark2  = ""
            nn_remark3 = "".
        
        IF ( wdetail.safe_no = "" ) THEN 
            MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
        ELSE DO:
            /* ------------------------check policy  Duplicate--------------------------------------*/ 
            IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat  = DATE(wdetail.comdat).
            ELSE ASSIGN nv_comdat = ?.

            IF (wdetail.expdat <>  "" ) THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
            ELSE ASSIGN nv_expdat  = ?.
        
           IF (wdetail.comdat72 <>  "" ) THEN ASSIGN nv_comdat72  = DATE(wdetail.comdat72). 
            ELSE ASSIGN nv_comdat72 = ?.

            IF (wdetail.expdat72 <>  "" ) THEN ASSIGN nv_expdat72  = DATE(wdetail.expdat72).
            ELSE ASSIGN nv_expdat72 = ?.
        
            /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- */
            nv_insamt3 = DECIMAL(wdetail.si).   /* by: kridtiya i. A54-0061.. */
            /* -------------------------- PREM1 CHR(11)   เบี้ยภาคสมัครใจบวกภาษีบวกอากร --- */
            nv_premt1 = DECIMAL(SUBSTRING(wdetail.netprem,1,9)).
            IF nv_premt1 < 0 THEN
                nv_premt2 = (DECIMAL(SUBSTRING(wdetail.netprem,10,2)) * -1) / 100.
            ELSE
                nv_premt2 = DECIMAL(SUBSTRING(wdetail.netprem,10,2)) / 100.
            nv_premt3 = nv_premt1 + nv_premt2.
            /* --------------------------------------------- COMP_PEM CHR(09)  เบี้ยพรบ.รวม --- */
            nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  
            /* -------------------------- GROSS_PRM CHR(11)   เบี้ยรวมภาคสมัครใจบวกเบี้ยรวม พรบ. --- */
            nv_coamt1 = DECIMAL(SUBSTRING(wdetail.totalprem,1,9)).
            IF nv_coamt1 < 0 THEN
                nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.totalprem,10,2)) * -1) / 100.
            ELSE
                nv_coamt2 = DECIMAL(SUBSTRING(wdetail.totalprem,10,2)) / 100.
            nv_coamt3 = nv_coamt1 + nv_coamt2.
           /*--------------------------------------Chk_Color_Code-------------------------------------------------*/
            /*Add by Krittapoj S. A65-0372 16/01/2023*/
            IF wdetail.colordes = "" THEN wdetail.colordes = "หลายสี".
            IF wdetail.colordes <> "" THEN DO: 
                 RUN wgw\wgwfcolor (INPUT        wdetail.colordes ,
                                    INPUT-OUTPUT wdetail.colorcode).
            END.
            ELSE wdetail.colorcode = "CL016". 
            /*End by Krittapoj S. A65-0372 16/01/2023*/
             /*---------------------------------------------------------------------------------------*/
            RUN proc_address.
            IF TRIM(wdetail.name_insur) <> " " THEN DO:
                ASSIGN n = 0
                       wdetail.name_insur = TRIM(wdetail.name_insur)
                       wdetail.pol_title  = SUBSTR(wdetail.name_insur,1,INDEX(wdetail.name_insur," "))
                       n = LENGTH(wdetail.name_insur) - LENGTH(wdetail.pol_title)                
                       wdetail.pol_fname  = SUBSTR(wdetail.name_insur,INDEX(wdetail.name_insur," "), n + 1 ).
            END.
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                brstat.tlt.cha_no       = trim(wdetail.chassis)   AND
                brstat.tlt.eng_no       = TRIM(wdetail.engine)    AND
                brstat.tlt.genusr       = fi_compa                NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:
               CREATE brstat.tlt.
                    nv_completecnt  =  nv_completecnt + 1.
                    ASSIGN                                                 
                        brstat.tlt.entdat       =   TODAY                              /* วันที่โหลด */                          
                        brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")            /* เวลาโหลด   */                          
                        brstat.tlt.trndat       =   fi_loaddat                         /* วันที่ไฟล์แจ้งงาน */                   
                        brstat.tlt.rec_addr3    =   trim(wdetail.Pro_off)              /*เลขที่รับแจ้งและสาขา */           
                        brstat.tlt.exp          =   trim(wdetail.branch)               /*สาขา                 */           
                        brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)              /*เลขที่รับแจ้ง        */           
                        brstat.tlt.safe2        =   trim(wdetail.Account_no)           /*เลขที่สัญญา          */           
                        brstat.tlt.rec_name     =   trim(wdetail.pol_title)            /*คำนำหน้าชื่อผู้เอาประกันภัย */          
                        brstat.tlt.ins_name     =   trim(wdetail.pol_fname)            /*ชื่อผู้เอาประกันภัย */           
                        brstat.tlt.ins_addr5    =   "ICNO " + trim(wdetail.icno)       /*IDCARD              */           
                        brstat.tlt.stat         =   IF trim(wdetail.garage) = "1" THEN "ซ่อมอู่" ELSE "ซ่อมห้าง"              /*สถานที่ซ่อม         */           
                        brstat.tlt.comp_usr_tlt =   trim(wdetail.custage)              /*ระบุผู้ขับขี่       */         
                        brstat.tlt.old_eng      =   trim(wdetail.Category)             /*ประเภทรถ            */           
                        brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"   /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */   
                        brstat.tlt.brand        =   trim(wdetail.brand)                /*ยี่ห้อ      */          
                        brstat.tlt.model        =   trim(wdetail.Brand_Model)          /*รุ่น        */          
                        brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)                /*ขนาดเครื่อง */          
                        brstat.tlt.lince2       =   trim(wdetail.yrmanu)               /*ปี          */          
                        brstat.tlt.eng_no       =   trim(wdetail.engine)               /*เลขเครื่อง  */          
                        brstat.tlt.cha_no       =   trim(wdetail.chassis)              /*เลขถัง      */          
                        brstat.tlt.old_cha      =   trim(wdetail.regisdate)            /*วันที่จดทะเบียน */                     
                        brstat.tlt.lince1       =   trim(wdetail.RegisNo)              /*เลขทะเบียน */          
                        brstat.tlt.lince3       =   trim(wdetail.RegisProv)            /*จังหวัด    */          
                        brstat.tlt.safe3        =   "Class72 " + TRIM(wdetail.n_class)  +  /*class72 */
                                                  " Class70 " + TRIM(wdetail.n_class70)   /*class70 */  
                        brstat.tlt.expousr      = "inttyp " + trim(wdetail.instyp) +   /*ประเภทประกัน */          
                                                  " covtyp " +  TRIM(wdetail.covtyp)    /*ความคุ้มครอง */                        
                        brstat.tlt.nor_coamt    =   nv_insamt3                         /*ทุนประกัน   */          
                        brstat.tlt.nor_usr_tlt  =  "FI " + TRIM(wdetail.fi) +     /*ทุนชนหาย */ 
                                                   " wht70 " + TRIM(wdetail.wht) +     /* wht70 */
                                                   " wht72 " + "0"      /* wht72 */
                        brstat.tlt.gendat       =   nv_comdat                          /*วันที่เริ่มคุ้มครอง  */          
                        brstat.tlt.expodat      =   nv_expdat                          /*วันที่สิ้นสุดคุ้มครอง*/          
                        brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)              /*เบี้ยสุทธิ*/              
                        brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)            /*เบี้ยรวม  */  
                        brstat.tlt.safe1        =   IF trim(wdetail.ben_name) = "ICBCTL" THEN "บริษัท ลีสซิ่งไอซีบีซี (ไทย) จำกัด" + " Delear " + trim(wdetail.dealer) /*ผู้รับผลประโยชน์  */          
                                                    ELSE TRIM(wdetail.ben_name) + " Delear " + trim(wdetail.dealer) /*ดีลเลอร์    */ 
                        brstat.tlt.nor_usr_ins  = trim(wdetail.CMRName)               /*ผู้แจ้ง           */          
                        brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */          
                        brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
                        brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */ 
                        brstat.tlt.rec_addr4    = "0"                                    /*เบี้ยสุทธิพรบ. */ 
                        brstat.tlt.comp_grprm   = DECI(wdetail.comp_prm)              /*เบี้ยรวมพรบ. */ 
                        brstat.tlt.filler2      = trim(wdetail.remark) + " " + trim(wdetail.Otherins)  /*หมายเหตุ    */        
                        brstat.tlt.ins_addr1    = trim(wdetail.addr1)                    /*ที่อยู่ลูกค้า */          
                        brstat.tlt.ins_addr2    = trim(wdetail.addr2)                                                            
                        brstat.tlt.ins_addr3    = trim(wdetail.addr3)                                                            
                        brstat.tlt.ins_addr4    = trim(wdetail.addr4) +                                                          
                                                " Tel:" + TRIM(wdetail.custtel)                                                 
                        brstat.tlt.genusr       = "ICBCTL"                                                                       
                        brstat.tlt.usrid        = USERID(LDBNAME(1))                    /*User Load Data */                      
                        brstat.tlt.imp          = "IM"                                  /*Import Data*/                          
                        brstat.tlt.releas       = "No"                                                                           
                        brstat.tlt.recac        = ""                                                                             
                        brstat.tlt.comp_sub     = trim(wdetail.producer)   
                       /* brstat.tlt.comp_noti_ins = "B300303"   */        /*A62-0082*/
                        brstat.tlt.comp_noti_ins = TRIM(fi_agent)          /*A62-0082*/
                        brstat.tlt.rec_addr1     = IF trim(wdetail.ben_name) = "ICBCTL" THEN "MC28982" ELSE ""   /* vat code */
                        brstat.tlt.rec_addr2    = ""        /* Recepit name */
                        brstat.tlt.rec_addr5    = ""        /* Recepit address */
                        brstat.tlt.dri_name1    = ""                             
                        brstat.tlt.dri_no1      = ""                             
                        brstat.tlt.dri_name2    = ""                            
                        brstat.tlt.dri_no2      = ""
                        brstat.tlt.filler1      = ""
                        brstat.tlt.nor_noti_ins = ""
                        brstat.tlt.comp_pol     = ""
                        brstat.tlt.dat_ins_noti = ?
                        brstat.tlt.lotno        = TRIM(wdetail.campaign)    /*A60-0263*/
                        brstat.tlt.colorcode    = trim(wdetail.colorcode)   /*Add by Krittapoj S. A65-0372 16/01/2023*/
                        brstat.tlt.colordes     = trim(wdetail.colordes).   /*Add by Krittapoj S. A65-0372 16/01/2023*/
            END.                      
            ELSE DO:                  
                nv_completecnt  =  nv_completecnt + 1.
                RUN proc_Create_tltnew2.
            END.
        END.
    END.
END.
Run proc_Open_tlt.                           
                            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tltnew2 C-Win 
PROCEDURE proc_create_tltnew2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
     brstat.tlt.entdat       = TODAY                              /* วันที่โหลด */                          
     brstat.tlt.enttim       = STRING(TIME,"HH:MM:SS")            /* เวลาโหลด   */                          
     brstat.tlt.trndat       = fi_loaddat                         /* วันที่ไฟล์แจ้งงาน */                   
     brstat.tlt.rec_addr3    = trim(wdetail.Pro_off)              /*เลขที่รับแจ้งและสาขา */           
     brstat.tlt.exp          = trim(wdetail.branch)               /*สาขา                 */           
     brstat.tlt.nor_noti_tlt = trim(wdetail.safe_no)              /*เลขที่รับแจ้ง        */           
     brstat.tlt.safe2        = trim(wdetail.Account_no)           /*เลขที่สัญญา          */           
     brstat.tlt.rec_name     = trim(wdetail.pol_title)            /*คำนำหน้าชื่อผู้เอาประกันภัย */          
     brstat.tlt.ins_name     = trim(wdetail.pol_fname)            /*ชื่อผู้เอาประกันภัย */           
     brstat.tlt.ins_addr5    = "ICNO " + trim(wdetail.icno)       /*IDCARD              */           
     brstat.tlt.stat         = IF trim(wdetail.garage) = "1" THEN "ซ่อมอู่" ELSE "ซ่อมห้าง"              /*สถานที่ซ่อม         */           
     brstat.tlt.comp_usr_tlt = trim(wdetail.custage)              /*ระบุผู้ขับขี่       */         
     brstat.tlt.old_eng      = trim(wdetail.Category)             /*ประเภทรถ            */           
     brstat.tlt.flag         = IF rs_type = 1 THEN "N" ELSE "R"   /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */   
     brstat.tlt.brand        = trim(wdetail.brand)                /*ยี่ห้อ      */          
     brstat.tlt.model        = trim(wdetail.Brand_Model)          /*รุ่น        */          
     brstat.tlt.cc_weight    = INTEGER(wdetail.cc)                /*ขนาดเครื่อง */          
     brstat.tlt.lince2       = trim(wdetail.yrmanu)               /*ปี          */          
     brstat.tlt.eng_no       = trim(wdetail.engine)               /*เลขเครื่อง  */          
     brstat.tlt.cha_no       = trim(wdetail.chassis)              /*เลขถัง      */          
     brstat.tlt.old_cha      = trim(wdetail.regisdate)            /*วันที่จดทะเบียน */                     
     brstat.tlt.lince1       = trim(wdetail.RegisNo)              /*เลขทะเบียน */          
     brstat.tlt.lince3       = trim(wdetail.RegisProv)            /*จังหวัด    */          
     brstat.tlt.safe3        = "Class72 " + TRIM(wdetail.n_class)  +  /*class72 */
                               " Class70 " + TRIM(wdetail.n_class70)   /*class70 */  
     brstat.tlt.expousr      = "inttyp " + trim(wdetail.instyp) +   /*ประเภทประกัน */          
                               " covtyp " +  TRIM(wdetail.covtyp)    /*ความคุ้มครอง */                        
     brstat.tlt.nor_coamt    = nv_insamt3                         /*ทุนประกัน   */          
     brstat.tlt.nor_usr_tlt  = "FI " + TRIM(wdetail.fi) +     /*ทุนชนหาย */ 
                               " wht70 " + TRIM(wdetail.wht) +     /* wht70 */ 
                               " wht72 " + "0"      /* wht72 */
     brstat.tlt.gendat       = nv_comdat                          /*วันที่เริ่มคุ้มครอง  */          
     brstat.tlt.expodat      = nv_expdat                          /*วันที่สิ้นสุดคุ้มครอง*/          
     brstat.tlt.nor_grprm    = DECI(wdetail.netprem)              /*เบี้ยสุทธิ*/              
     brstat.tlt.comp_coamt   = DECI(wdetail.totalprem)            /*เบี้ยรวม  */  
     brstat.tlt.safe1        = IF trim(wdetail.ben_name) = "ICBCTL" THEN "บริษัท ลีสซิ่งไอซีบีซี (ไทย) จำกัด" + " Delear " + trim(wdetail.dealer) /*ผู้รับผลประโยชน์  */          
                               ELSE TRIM(wdetail.ben_name) + " Delear " + trim(wdetail.dealer) /*ดีลเลอร์    */ 
     brstat.tlt.nor_usr_ins  = trim(wdetail.CMRName)               /*ผู้แจ้ง           */          
     brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */          
     brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
     brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */ 
     brstat.tlt.rec_addr4    = "0"                                  /*เบี้ยสุทธิพรบ. */ 
     brstat.tlt.comp_grprm   = DECI(wdetail.comp_prm)              /*เบี้ยรวมพรบ. */ 
     brstat.tlt.filler2      = trim(wdetail.remark) + " " + trim(wdetail.Otherins)           /*หมายเหตุ    */        
     brstat.tlt.ins_addr1    = trim(wdetail.addr1)                    /*ที่อยู่ลูกค้า */          
     brstat.tlt.ins_addr2    = trim(wdetail.addr2)                                                            
     brstat.tlt.ins_addr3    = trim(wdetail.addr3)                                                            
     brstat.tlt.ins_addr4    = trim(wdetail.addr4) +                                                          
                               " Tel:" + TRIM(wdetail.custtel)                                                 
     brstat.tlt.genusr       = "ICBCTL"                                                                       
     brstat.tlt.usrid        = USERID(LDBNAME(1))                    /*User Load Data */                      
     brstat.tlt.imp          = "IM"                                  /*Import Data*/                          
     brstat.tlt.releas       = "No"                                                                           
     brstat.tlt.recac        = ""                                                                             
     brstat.tlt.comp_sub     = trim(wdetail.producer)    
     /*brstat.tlt.comp_noti_ins = "B300303"              */   /*A62-0082*/
     brstat.tlt.comp_noti_ins = trim(fi_agent)                /*A62-0082*/
     brstat.tlt.rec_addr1    = IF trim(wdetail.ben_name) = "ICBCTL" THEN "MC28982" ELSE ""   /* vat code */
     brstat.tlt.rec_addr2    = ""        /* Recepit name */         
     brstat.tlt.rec_addr5    = ""        /* Recepit address */
     brstat.tlt.dri_name1    = ""                             
     brstat.tlt.dri_no1      = ""                             
     brstat.tlt.dri_name2    = ""                            
     brstat.tlt.dri_no2      = ""
     brstat.tlt.filler1      = "" 
     brstat.tlt.nor_noti_ins = "" 
     brstat.tlt.comp_pol     = "" 
     brstat.tlt.dat_ins_noti = ?
     brstat.tlt.lotno        = TRIM(wdetail.campaign) /*A60-0263*/
     brstat.tlt.colorcode    = trim(wdetail.colorcode) /*Add by krittapoj S. A65-0372 16/01/2023*/
     brstat.tlt.colordes     = trim(wdetail.colordes). /*Add by Krittapoj S. A65-0372 16/01/2023*/        

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tltrenew C-Win 
PROCEDURE proc_create_tltrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS INT INIT 0.
LOOP_wdetail:
FOR EACH wdetail .
    IF  wdetail.Pro_off    = "" THEN  DELETE wdetail.
    ELSE  DO:
    ASSIGN   
            nv_policy    = ""   nv_oldpol    = ""
            nv_comdat    = ?    nv_expdat    = ?  
            nv_comdat72  = ?    nv_expdat72  = ?    nv_accdat  =  ?
            nv_comchr  = ""     nv_addr    = ""     nv_name1   =  ""     
            nv_ntitle  = ""     nv_titleno = 0      nv_policy  =  ""
            nv_dd      = 0      nv_mm      = 0      nv_yy      =  0
            nv_cpamt1  = 0      nv_cpamt2  = 0      nv_cpamt3  =  0
            nv_coamt1  = 0      nv_coamt2  = 0      nv_coamt3  =  0         
            nv_insamt1 = 0      nv_insamt2 = 0      nv_insamt3 =  0
            nv_premt1  = 0      nv_premt2  = 0      nv_premt3  =  0
            nv_newpol  = ""     nv_reccnt  = nv_reccnt + 1
            wdetail.engine = REPLACE(wdetail.engine,"*","").
        IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    /* A56-0399 */
        ELSE ASSIGN nn_remark1  = trim(wdetail.remark)
            nn_remark2  = ""
            nn_remark3 = "".
       /* IF ( wdetail.safe_no = "" ) THEN 
            MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
        ELSE DO:*/
            IF wdetail.prevpol <> "" THEN DO: 
                RUN pol_cutchar.
                nv_oldpol  =  wdetail.prevpol.
            END.
            /* ------------------------check policy  Duplicate--------------------------------------*/
            IF INDEX(wdetail.covtyp,"พรบ") = 0  THEN DO:
                IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat  = DATE(wdetail.comdat).
                ELSE ASSIGN nv_comdat = ?.
                IF (wdetail.expdat <>  "" ) THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
                ELSE ASSIGN nv_expdat  = ?.
            END.
            ELSE DO:
                ASSIGN wdetail.comdat72      = trim(wdetail.comdat)
                       wdetail.expdat72      = trim(wdetail.expdat)
                       wdetail.comp_prm      = trim(wdetail.netprem)       
                       wdetail.comp_prmtotal = trim(wdetail.totalprem).
                IF (wdetail.comdat72 <>  "" ) THEN ASSIGN nv_comdat72  = DATE(wdetail.comdat72). 
                ELSE ASSIGN nv_comdat72 = ?.
                IF (wdetail.expdat72 <>  "" ) THEN ASSIGN nv_expdat72  = DATE(wdetail.expdat72).
                ELSE ASSIGN nv_expdat72 = ?.
            END.
        
            /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- */
            nv_insamt3 = DECIMAL(wdetail.si).   /* by: kridtiya i. A54-0061.. */
            /* -------------------------- PREM1 CHR(11)   เบี้ยภาคสมัครใจบวกภาษีบวกอากร --- */
            nv_premt1 = DECIMAL(SUBSTRING(wdetail.netprem,1,9)).
            IF nv_premt1 < 0 THEN
                nv_premt2 = (DECIMAL(SUBSTRING(wdetail.netprem,10,2)) * -1) / 100.
            ELSE
                nv_premt2 = DECIMAL(SUBSTRING(wdetail.netprem,10,2)) / 100.
            nv_premt3 = nv_premt1 + nv_premt2.
            /* --------------------------------------------- COMP_PEM CHR(09)  เบี้ยพรบ.รวม --- */
            nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  
            /* -------------------------- GROSS_PRM CHR(11)   เบี้ยรวมภาคสมัครใจบวกเบี้ยรวม พรบ. --- */
            nv_coamt1 = DECIMAL(SUBSTRING(wdetail.totalprem,1,9)).
            IF nv_coamt1 < 0 THEN
                nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.totalprem,10,2)) * -1) / 100.
            ELSE
                nv_coamt2 = DECIMAL(SUBSTRING(wdetail.totalprem,10,2)) / 100.
            nv_coamt3 = nv_coamt1 + nv_coamt2.
           /*---------------------------------------------------------------------------------------*/
            /*Add by Krittapoj S. A65-0372 16/01/2023*/
            IF wdetail.colordes = "" THEN wdetail.colordes = "หลายสี".
            IF wdetail.colordes <> "" THEN DO:                                                           
                RUN wgw\wgwfcolor (INPUT        wdetail.colordes ,                                       
                                   INPUT-OUTPUT wdetail.colorcode).                                      
            END.
            ELSE wdetail.colorcode = "CL016".
            /*End by Krittapoj S. A65-0372 16/01/2023*/
             /*---------------------------------------------------------------------------------------*/ 
         RUN proc_address.
          IF TRIM(wdetail.name_insur) <> " " THEN DO:
                ASSIGN n = 0
                       wdetail.name_insur = TRIM(wdetail.name_insur)
                       wdetail.pol_title  = SUBSTR(wdetail.name_insur,1,INDEX(wdetail.name_insur," "))
                       n = LENGTH(wdetail.name_insur) - LENGTH(wdetail.pol_title)                
                       wdetail.pol_fname  = SUBSTR(wdetail.name_insur,INDEX(wdetail.name_insur," "), n + 1 ).
            END.
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                    brstat.tlt.cha_no       = trim(wdetail.chassis)   AND
                    brstat.tlt.eng_no       = TRIM(wdetail.engine)    AND
                    brstat.tlt.genusr       = fi_compa                NO-ERROR NO-WAIT .
                IF NOT AVAIL brstat.tlt THEN DO:
                   CREATE brstat.tlt.
                   IF wdetail.sck = "" THEN DO:
                        nv_completecnt  =  nv_completecnt + 1.
                        ASSIGN   
                             brstat.tlt.entdat       =   TODAY                              /* วันที่โหลด */                          
                             brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")            /* เวลาโหลด   */                          
                             brstat.tlt.trndat       =   fi_loaddat                         /* วันที่ไฟล์แจ้งงาน */                   
                             brstat.tlt.rec_addr3    =   trim(wdetail.Pro_off)              /* ชื่อบริษัท */           
                             brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)              /*เลขที่รับแจ้ง        */ 
                             brstat.tlt.filler1      =   nv_oldpol                          /*เลขที่กรมธรรม์เดิม   */
                             brstat.tlt.safe2        =   trim(wdetail.Account_no)           /*เลขที่สัญญา          */           
                             brstat.tlt.rec_name     =   trim(wdetail.pol_title)            /*คำนำหน้าชื่อผู้เอาประกันภัย */          
                             brstat.tlt.ins_name     =   trim(wdetail.pol_fname)            /*ชื่อผู้เอาประกันภัย */           
                             brstat.tlt.ins_addr5    =   "ICNO " + trim(wdetail.icno)                 /*IDCARD            */  
                             brstat.tlt.old_eng      =   trim(wdetail.CarType)               /*ประเภทรถ            */           
                             brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"   /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */   
                             brstat.tlt.brand        =   trim(wdetail.brand)                 /*ยี่ห้อ      */          
                             brstat.tlt.model        =   trim(wdetail.Brand_Model)           /*รุ่น        */          
                             brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)             /*ขนาดเครื่อง */          
                             brstat.tlt.lince2       =   trim(wdetail.yrmanu)                /*ปี          */          
                             brstat.tlt.eng_no       =   trim(wdetail.engine)                /*เลขเครื่อง  */          
                             brstat.tlt.cha_no       =   trim(wdetail.chassis)               /*เลขถัง      */          
                             brstat.tlt.lince1       =   trim(wdetail.RegisNo)               /*เลขทะเบียน */          
                             brstat.tlt.lince3       =   trim(wdetail.RegisProv)             /*จังหวัด    */          
                             brstat.tlt.safe3        =   "Class72 " + TRIM(wdetail.n_class)  +              /*class */ 
                                                         " Class70 " + TRIM(wdetail.n_class70)   /*class70 */ 
                             brstat.tlt.expousr      =   " Covtyp " + TRIM(wdetail.covtyp)    /*ความคุ้มครอง */                     
                             brstat.tlt.nor_coamt    =   nv_insamt3                          /*ทุนประกัน   */          
                             brstat.tlt.nor_usr_tlt  =   "FI " + TRIM(wdetail.fi) +      /*ทุนชนหาย */ 
                                                         " wht70 " + "0" +    /* wht70 */ 
                                                         " wht72 " + "0"      /* wht72 */
                             brstat.tlt.gendat       =   nv_comdat                           /*วันที่เริ่มคุ้มครอง  */          
                             brstat.tlt.expodat      =   nv_expdat                           /*วันที่สิ้นสุดคุ้มครอง*/          
                             brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)               /*เบี้ยสุทธิ*/              
                             brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)             /*เบี้ยรวม  */          
                             brstat.tlt.safe1        =  IF INDEX(wdetail.ben_name,"ติด8.3") <> 0 THEN "บริษัท ลีสซิ่งไอซีบีซี (ไทย) จำกัด " /*ผู้รับผลประโยชน์  */          
                                                        ELSE TRIM(wdetail.ben_name)
                             brstat.tlt.nor_usr_ins  = trim(wdetail.CMRName)               /*ผู้แจ้ง           */          
                             /*brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */          
                             brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
                             brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */
                             brstat.tlt.comp_grprm   = DECI(wdetail.comp_prm)              /*เบี้ยสุทธิพรบ */ 
                             brstat.tlt.rec_addr4    = trim(wdetail.comp_prmtotal)         /*เบี้ยรวมพรบ. */  */
                             brstat.tlt.filler2      = trim(wdetail.remark)                /*หมายเหตุ    */          
                             brstat.tlt.ins_addr1    = trim(wdetail.addr1)                    /*ที่อยู่ลูกค้า */          
                             brstat.tlt.ins_addr2    = trim(wdetail.addr2)                                                            
                             brstat.tlt.ins_addr3    = trim(wdetail.addr3)                                                            
                             brstat.tlt.ins_addr4    = trim(wdetail.addr4)                                                           
                             brstat.tlt.genusr       = "ICBCTL"                                                                       
                             brstat.tlt.usrid        = USERID(LDBNAME(1))                    /*User Load Data */                      
                             brstat.tlt.imp          = "IM"                                  /*Import Data*/                          
                             brstat.tlt.releas       = "No"                                                                           
                             brstat.tlt.recac        = ""                                                                             
                             brstat.tlt.comp_sub      = "A0M0097"              
                             /*brstat.tlt.comp_noti_ins = "B300303"    */      /*A62-0082*/
                             brstat.tlt.comp_noti_ins = trim(fi_agent)         /*A62-0082*/
                             brstat.tlt.rec_addr1    = ""   /* vat code */
                             brstat.tlt.rec_addr2    = ""   /* Recepit name */
                             brstat.tlt.rec_addr5    = ""   /* Recepit address */
                             brstat.tlt.dri_name1    = ""                             
                             brstat.tlt.dri_no1      = ""                             
                             brstat.tlt.dri_name2    = ""                            
                             brstat.tlt.dri_no2      = ""
                             brstat.tlt.nor_noti_ins = "" 
                             brstat.tlt.comp_pol     = "" 
                             brstat.tlt.stat         = ""    /*a60-0263*/          /*สถานที่ซ่อม ,inspacetion  */ 
                             brstat.tlt.dat_ins_noti = ?
                             brstat.tlt.colorcode    = trim(wdetail.colorcode)  /*Add by Krittapoj S. A65-0372 16/01/2023*/
                             brstat.tlt.colordes     = trim(wdetail.colordes).  /*add by Krittapoj S. A65-0372 16/01/2023*/

                        END.
                        ELSE DO:
                            ASSIGN 
                            brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */  
                            brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
                            brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */
                            brstat.tlt.comp_grprm   = DECI(wdetail.comp_prmtotal)         /*เบี้ยรวมพรบ. */      
                            brstat.tlt.rec_addr4    = TRIM(wdetail.comp_prm).              /*เบี้ยสุทธิพรบ */      
                        END.
                END.
                ELSE DO: 
                    nv_completecnt  =  nv_completecnt + 1.
                    RUN proc_Create_tltrenew2.
                END.
    END.
END.
Run proc_Open_tlt.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tltrenew2 C-Win 
PROCEDURE proc_create_tltrenew2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail.sckno = "" THEN DO:
    ASSIGN   
     brstat.tlt.entdat       =   TODAY                              /* วันที่โหลด */                          
     brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")            /* เวลาโหลด   */                          
     brstat.tlt.trndat       =   fi_loaddat                         /* วันที่ไฟล์แจ้งงาน */                   
     brstat.tlt.rec_addr3    =   trim(wdetail.Pro_off)              /* ชื่อบริษัท */           
     brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)              /*เลขที่รับแจ้ง        */ 
     brstat.tlt.filler1      =   nv_oldpol                          /*เลขที่กรมธรรม์เดิม   */
     brstat.tlt.safe2        =   trim(wdetail.Account_no)           /*เลขที่สัญญา          */           
     brstat.tlt.rec_name     =   trim(wdetail.pol_title)            /*คำนำหน้าชื่อผู้เอาประกันภัย */          
     brstat.tlt.ins_name     =   trim(wdetail.pol_fname)            /*ชื่อผู้เอาประกันภัย */           
     brstat.tlt.ins_addr5    =   "ICNO " + trim(wdetail.icno)                 /*IDCARD            */  
     brstat.tlt.old_eng      =   trim(wdetail.CarType)               /*ประเภทรถ            */           
     brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"   /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */   
     brstat.tlt.brand        =   trim(wdetail.brand)                 /*ยี่ห้อ      */          
     brstat.tlt.model        =   trim(wdetail.Brand_Model)           /*รุ่น        */          
     brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)             /*ขนาดเครื่อง */          
     brstat.tlt.lince2       =   trim(wdetail.yrmanu)                /*ปี          */          
     brstat.tlt.eng_no       =   trim(wdetail.engine)                /*เลขเครื่อง  */          
     brstat.tlt.cha_no       =   trim(wdetail.chassis)               /*เลขถัง      */          
     brstat.tlt.lince1       =   trim(wdetail.RegisNo)               /*เลขทะเบียน */          
     brstat.tlt.lince3       =   trim(wdetail.RegisProv)             /*จังหวัด    */          
     brstat.tlt.safe3        =   "Class72 " + TRIM(wdetail.n_class)  +              /*class */ 
                                 " Class70 " + TRIM(wdetail.n_class70)   /*class70 */ 
     brstat.tlt.expousr      =   " Covtyp " + TRIM(wdetail.covtyp)    /*ความคุ้มครอง */                     
     brstat.tlt.nor_coamt    =   nv_insamt3                          /*ทุนประกัน   */          
     brstat.tlt.nor_usr_tlt  =   "FI " + TRIM(wdetail.fi) +       /*ทุนชนหาย */
                                 " wht70 " + "0" +    /* wht70 */ 
                                 " wht72 " + "0"      /* wht72 */
     brstat.tlt.gendat       =   nv_comdat                           /*วันที่เริ่มคุ้มครอง  */          
     brstat.tlt.expodat      =   nv_expdat                           /*วันที่สิ้นสุดคุ้มครอง*/          
     brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)               /*เบี้ยสุทธิ*/              
     brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)             /*เบี้ยรวม  */          
     brstat.tlt.safe1        =  IF INDEX(wdetail.ben_name,"ติด8.3") <> 0 THEN "บริษัท ลีสซิ่งไอซีบีซี (ไทย) จำกัด " /*ผู้รับผลประโยชน์  */          
                                ELSE TRIM(wdetail.ben_name)
     brstat.tlt.nor_usr_ins  = trim(wdetail.CMRName)               /*ผู้แจ้ง           */          
     /*brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */          
     brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
     brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */
     brstat.tlt.comp_grprm   = DECI(wdetail.comp_prm)              /*เบี้ยสุทธิพรบ */ 
     brstat.tlt.rec_addr4    = trim(wdetail.comp_prmtotal)         /*เบี้ยรวมพรบ. */  */
     brstat.tlt.filler2      = trim(wdetail.remark)                /*หมายเหตุ    */          
     brstat.tlt.ins_addr1    = trim(wdetail.addr1)                    /*ที่อยู่ลูกค้า */          
     brstat.tlt.ins_addr2    = trim(wdetail.addr2)                                                            
     brstat.tlt.ins_addr3    = trim(wdetail.addr3)                                                            
     brstat.tlt.ins_addr4    = trim(wdetail.addr4)                                                           
     brstat.tlt.genusr       = "ICBCTL"                                                                       
     brstat.tlt.usrid        = USERID(LDBNAME(1))                    /*User Load Data */                      
     brstat.tlt.imp          = "IM"                                  /*Import Data*/                          
     brstat.tlt.releas       = "No"                                                                           
     brstat.tlt.recac        = ""                                                                             
     brstat.tlt.comp_sub      = "A0M0097"               
     /*brstat.tlt.comp_noti_ins = "B300303"    */            /*A62-0082*/
     brstat.tlt.comp_noti_ins = trim(fi_agent)                /*A62-0082*/
     brstat.tlt.rec_addr1    = ""   /* vat code */
     brstat.tlt.rec_addr2    = ""   /* Recepit name */
     brstat.tlt.rec_addr5    = ""   /* Recepit address */
     brstat.tlt.dri_name1    = ""                             
     brstat.tlt.dri_no1      = ""                             
     brstat.tlt.dri_name2    = ""                            
     brstat.tlt.dri_no2      = ""
     brstat.tlt.nor_noti_ins = "" 
     brstat.tlt.comp_pol     = "" 
     brstat.tlt.stat         = ""    /*a60-0263*/          /*สถานที่ซ่อม ,inspacetion  */ 
     brstat.tlt.dat_ins_noti = ?
     brstat.tlt.colorcode    = trim(wdetail.colorcode) /*Add by Krittapoj S. A65-0372 16/01/2023*/
     brstat.tlt.colordes     = trim(wdetail.colordes). /*Add by Krittapoj S. A65-0372 16/01/2023*/

END.
ELSE DO:
    ASSIGN 
    brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */  
    brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
    brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */
    brstat.tlt.comp_grprm   = DECI(wdetail.comp_prmtotal)         /*เบี้ยรวมพรบ. */      
    brstat.tlt.rec_addr4    = TRIM(wdetail.comp_prm).              /*เบี้ยสุทธิพรบ */      
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutremak C-Win 
PROCEDURE proc_cutremak :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*wdetail.remark*/ 
ASSIGN  nn_remark1 = ""
        nn_remark2 = ""
        nn_remark3 = "".
IF      R-INDEX(wdetail.remark,"/บริษัท") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/บริษัท"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/บริษัท") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 85 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,86 )) 
            nn_remark2 = trim(substr(nn_remark2,1,85)).
    END.
END.
ELSE IF      R-INDEX(wdetail.remark,"/บจก") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/บจก"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/บจก") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 110 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,111 )) 
            nn_remark2 = trim(substr(nn_remark2,1,110)).
    END.
END.
ELSE IF      R-INDEX(wdetail.remark,"/ห้าง") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/ห้าง"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/ห้าง") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 110 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,111 )) 
            nn_remark2 = trim(substr(nn_remark2,1,110)).
    END.
END.
ELSE DO:
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark," "))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark," ") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".  
    loop_chk0:
    REPEAT:
        IF LENGTH(nn_remark1) > 110 THEN DO:
            IF R-INDEX(nn_remark1," ") <> 0  THEN
                ASSIGN  
                nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
                nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
            ELSE ASSIGN 
                nn_remark2 = trim(substr(nn_remark1,111)) + " " + nn_remark2
                nn_remark1 = trim(substr(nn_remark1,1,110)) .
        END.
        ELSE IF LENGTH(nn_remark2) > 85 THEN DO:
            IF R-INDEX(nn_remark2," ") <> 0  THEN
                ASSIGN  
                nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," "))) 
                nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
            ELSE ASSIGN 
                nn_remark3 = trim(substr(nn_remark2,86)) 
                nn_remark2 = trim(substr(nn_remark2,1,85)).
        END.
        ELSE LEAVE loop_chk0.
    END.
END.
loop_chk1:
REPEAT:
    IF INDEX(nn_remark1,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark1).
        nn_remark1 = SUBSTRING(nn_remark1,1,INDEX(nn_remark1,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark1,INDEX(nn_remark1,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk1.
END.
loop_chk2:
REPEAT:
    IF INDEX(nn_remark2,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark2).
        nn_remark2 = SUBSTRING(nn_remark2,1,INDEX(nn_remark2,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark2,INDEX(nn_remark2,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk2.
END.
loop_chk3:
REPEAT:
    IF INDEX(nn_remark3,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark3).
        nn_remark3 = SUBSTRING(nn_remark3,1,INDEX(nn_remark3,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark3,INDEX(nn_remark3,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk3.
END.
IF LENGTH(nn_remark2 + " " + nn_remark3 ) <= 85 THEN 
    ASSIGN nn_remark2 = nn_remark2 + " " + nn_remark3  
           nn_remark3 = "".
IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
    ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
           nn_remark2 = "".
/*
DISP LENGTH(nn_remark1)
     nn_remark1 FORMAT "x(65)"
     nn_remark2 FORMAT "x(65)"  
     nn_remark3 FORMAT "x(65)" .*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Open_tlt C-Win 
PROCEDURE proc_Open_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each brstat.tlt  Use-index tlt01         where
         brstat.tlt.trndat   =  fi_loaddat   and
         brstat.tlt.genusr   =  fi_compa     NO-LOCK .
    CREATE wtlt.
    ASSIGN 
       wtlt.trndat      =   STRING(tlt.trndat,"99/99/9999")    
       wtlt.Notify_no   =   tlt.nor_noti_tlt
       wtlt.branch      =   tlt.exp     
       wtlt.Account_no  =   tlt.safe2   
       wtlt.prev_pol    =   tlt.filler1 
       wtlt.name_insur  =   tlt.rec_name + " " + tlt.ins_name
       wtlt.comdat      =   IF tlt.gendat       <> ? THEN string(tlt.gendat,"99/99/9999")       ELSE ""    
       wtlt.expdat      =   IF tlt.expodat      <> ? THEN string(tlt.expodat,"99/99/9999")      ELSE ""     
       wtlt.comdat72    =   IF tlt.comp_effdat  <> ? THEN string(tlt.comp_effdat,"99/99/9999")  ELSE ""
       wtlt.expdat72    =   IF tlt.nor_effdat   <> ? THEN string(Tlt.nor_effdat,"99/99/9999")   ELSE ""  
       wtlt.licence     =   tlt.lince1 
       wtlt.province    =   tlt.lince3 
       wtlt.ins_amt     =   string(tlt.nor_coamt) 
       wtlt.prem1       =   string(tlt.nor_grprm) 
       wtlt.comp_prm    =   string(tlt.comp_grprm)
       wtlt.gross_prm   =   STRING(tlt.comp_coamt)
       wtlt.compno      =   tlt.comp_pol  
       wtlt.not_date    =   STRING(tlt.datesent)   
       wtlt.not_office  =   tlt.nor_usr_tlt
       wtlt.not_name    =   tlt.nor_usr_ins
       wtlt.brand       =   tlt.brand      
       wtlt.Brand_Model =   tlt.model      
       wtlt.yrmanu      =   tlt.lince2   
       wtlt.weight      =   STRING(tlt.cc_weight)  
       wtlt.engine      =   tlt.eng_no    
       wtlt.chassis     =   tlt.cha_no 
       wtlt.camp        =   tlt.genusr
       wtlt.colordes    =   tlt.colordes   /*Add by Krittapoj S. A65-0372 16/01/2023*/
       wtlt.colorcode   =   tlt.colorcode.   /*Add by Krittapoj S. A65-0372 16/01/2023*/
       
END.
OPEN QUERY br_imptxt FOR EACH wtlt NO-LOCK.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

