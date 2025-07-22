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
modify by    : Ranu I. A61-0221 date 17/05/2018 เพิ่มคอลัมน์ Family (รุ่นรถ)    
Modigy by    : Ranu I. A62-0445 date 01/10/2019 เพิ่มการสร้างกล่องตรวจสภาพ และเช็ค suspect  
Modify by    : Ranu I. A64-0150 date 26/03/2021 แก้ไข Producer code  
Modify by    : Tontawan S. A66-0139 10/08/2023 แก้ไข Defult Agent Code จาก "B3W0100" ใหม่เป็น "B300316"
+++++++++++++++++++++++++++++++++++++++++++++++*/
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC  INIT   Yes.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail NO-UNDO
    FIELD n_no          AS CHAR FORMAT "X(3)"   INIT ""  /*No                   */          
    FIELD Pro_off       AS CHAR FORMAT "X(10)"  INIT ""  /*InsComp              */          
    FIELD branch        AS CHAR FORMAT "X(20)"   INIT ""  /*OffCde               */          
    FIELD safe_no       AS CHAR FORMAT "X(70)"  INIT ""  /*InsuranceReceivedNo  */          
    FIELD Account_no    AS CHAR FORMAT "X(20)"  INIT ""  /*ApplNo               */          
    FIELD name_insur    AS CHAR FORMAT "X(100)" INIT ""  /*CustName             */          
    FIELD icno          AS CHAR FORMAT "X(13)"  INIT ""  /*IDNo                 */          
    FIELD garage        AS CHAR FORMAT "X(10)"   INIT ""  /*RepairType           */          
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
    FIELD ben_name      AS CHAR FORMAT "X(100)"  INIT ""  /*Beneficiary          */          
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
    FIELD pol_fname     as char format "x(150)"  init ""
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
    FIELD cartyp        as char format "x(50)" init "" 
    FIELD typins        as char format "x(20)" init "" 
    FIELD bdate         as char format "x(15)" init "" 
    FIELD expbdate      as char format "x(15)" init "" 
    FIELD occup         as char format "x(100)" init "" 
    FIELD name2         as char format "x(100)" init "" 
    FIELD pol_addr2     as char format "x(50)" init "" 
    FIELD pol_addr3     as char format "x(50)" init "" 
    FIELD pol_addr4     as char format "x(50)" init "" 
    FIELD pol_addr5     as char format "x(50)" init "" 
    FIELD phone         as char format "x(25)" init "" 
    FIELD drivno        as char format "x(30)" init "" 
    FIELD drivgen1      as char format "x(10)" init "" 
    FIELD drivocc1      as char format "x(50)" init "" 
    FIELD drivgen2      as char format "x(10)" init "" 
    FIELD drivocc2      as char format "x(50)" init "" 
    FIELD stk           as char format "x(15)" init "" 
    FIELD policy        AS CHAR FORMAT "x(15)" INIT ""     /*A62-0445*/
    FIELD appno         AS CHAR FORMAT "x(20)" INIT "" .   /*A62-0445*/

DEFINE NEW SHARED TEMP-TABLE wtlt NO-UNDO
    FIELD trndat        AS CHAR FORMAT "x(15)"  INIT ""
    FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""   /*เลขที่รับแจ้ง         */           
    FIELD branch        AS CHAR FORMAT "X(20)"   INIT ""   /*สาขา                  */           
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
    FIELD campaign      AS CHAR FORMAT "x(20)"  INIT "". /*A60-0263*/
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
DEF VAR nn_remark1  AS CHAR INIT "".  
DEF VAR nn_remark2  AS CHAR INIT "".  
DEF VAR nn_remark3  AS CHAR INIT "".  
DEF VAR nv_len      AS INTE INIT 0.

/* add by A62-0445  */
DEF VAR nv_ispstatus AS CHAR.
DEF VAR chSession       AS COM-HANDLE.
DEF VAR chWorkSpace     AS COM-HANDLE.
DEF VAR chName          AS COM-HANDLE.
DEF VAR chDatabase      AS COM-HANDLE.
DEF VAR chView          AS COM-HANDLE.
DEF VAR chViewEntry     AS COM-HANDLE.
DEF VAR chViewNavigator AS COM-HANDLE.
DEF VAR chDocument      AS COM-HANDLE.
DEF VAR chUIDocument    AS COM-HANDLE.
DEF VAR NotesServer  AS CHAR.
DEF VAR NotesApp     AS CHAR.
DEF VAR NotesView    AS CHAR.
DEF VAR nv_chknotes  AS CHAR.
DEF VAR nv_chkdoc    AS LOG.
DEF VAR nv_year      AS CHAR.
DEF VAR nv_msgbox    AS CHAR.   
DEF VAR nv_name      AS CHAR.
DEF VAR nv_datim     AS CHAR.
DEF VAR nv_branch    AS CHAR.
DEF VAR nv_brname    AS CHAR.
DEF VAR nv_pattern   AS CHAR.
DEF VAR nv_count     AS INT.
DEF VAR nv_text1     AS CHAR.
DEF VAR nv_text2     AS CHAR.
DEF VAR nv_chktext   AS INT.
DEF VAR nv_model     AS CHAR.
DEF VAR nv_modelcode AS CHAR.
DEF VAR nv_makdes    AS CHAR.
DEF VAR nv_licence1  AS CHAR.
DEF VAR nv_licence2  AS CHAR.
/**/
DEF VAR nv_cha_no  AS CHAR.
DEF VAR nv_doc_num AS INT.
DEF VAR nv_licen1  AS CHAR.
DEF VAR nv_licen2  AS CHAR.
DEF VAR nv_key1    AS CHAR.
DEF VAR nv_key2    AS CHAR.
DEF VAR nv_surcl   AS CHAR.
DEF VAR nv_docno   AS CHAR.

DEF VAR nv_brdesc AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_brcode AS CHAR FORMAT "x(3)" INIT "" .
DEF VAR nv_comco AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_producer AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_agent AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_char AS CHAR FORMAT "x(225)" INIT "" .
DEF VAR nv_length AS INT INIT 0.
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
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
Def var nv_acctotal      as char format "x(100)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".  
DEF VAR nv_date          AS CHAR FORMAT "x(15)" .
DEF VAR nv_damdetail     AS LONGCHAR .
DEF VAR nv_sumsi         AS DECI INIT 0 .
DEF VAR n_day AS INT INIT 0.
DEF VAR nv_insi AS DECI INIT 0.
DEF VAR nv_provin AS CHAR FORMAT "x(10)" .
DEF VAR nv_key3 AS CHAR FORMAT "x(35)" .
DEF VAR nv_susupect AS CHAR FORMAT "x(255)" .

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
&Scoped-define FIELDS-IN-QUERY-br_imptxt wtlt.trndat /*wtlt.Notify_no wtlt.branch */ wtlt.Account_no wtlt.prev_pol wtlt.name_insur wtlt.comdat wtlt.expdat wtlt.licence wtlt.province wtlt.ins_amt wtlt.prem1 wtlt.comp_prm wtlt.gross_prm wtlt.compno wtlt.not_date wtlt.not_office wtlt.not_name wtlt.brand wtlt.Brand_Model wtlt.yrmanu wtlt.weight wtlt.engine wtlt.chassis   
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
&Scoped-Define ENABLED-OBJECTS br_imptxt fi_loaddat fi_compa fi_filename ~
bu_ok bu_exit bu_file rs_type fi_camp fi_camp2 fi_camp3 RECT-1 RECT-79 ~
RECT-80 RECT-380 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_compa fi_filename fi_impcnt ~
fi_completecnt fi_dir_cnt fi_dri_complet rs_type fi_camp fi_camp2 fi_camp3 

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

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15.67 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_camp2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_camp3 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY .95
     BGCOLOR 15  NO-UNDO.

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
     SIZE 50.5 BY .95
     BGCOLOR 18 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.81
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 128.5 BY 7.19
     BGCOLOR 3 .

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
      /*wtlt.Notify_no    COLUMN-LABEL "เลขที่รับแจ้ง"       FORMAT "x(20)"
      wtlt.branch       COLUMN-LABEL "สาขา"                FORMAT "XX"  */             
      wtlt.Account_no   COLUMN-LABEL "เลขที่สัญญา"         FORMAT "x(18)"            
      wtlt.prev_pol     COLUMN-LABEL "เลขที่กรมธรรม์เดิม"  FORMAT "x(15)"            
      wtlt.name_insur   COLUMN-LABEL "ชื่อผู้เอาประกันภัย" FORMAT "X(50)"       
      wtlt.comdat       COLUMN-LABEL "วันที่คุ้มครอง"      FORMAT "X(15)"       
      wtlt.expdat       COLUMN-LABEL "วันที่สิ้นสุด"       FORMAT "X(15)"  
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
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128 BY 15.24
         BGCOLOR 19 FGCOLOR 2 FONT 4 ROW-HEIGHT-CHARS .71 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_imptxt AT ROW 9.33 COL 3.17
     fi_loaddat AT ROW 1.52 COL 38 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.52 COL 72 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 4.67 COL 38 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.33 COL 101.5
     bu_exit AT ROW 6.33 COL 110.83
     bu_file AT ROW 4.71 COL 116.33
     fi_impcnt AT ROW 5.81 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 5.81 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_dir_cnt AT ROW 6.91 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_dri_complet AT ROW 6.91 COL 75.17 COLON-ALIGNED NO-LABEL
     rs_type AT ROW 2.62 COL 40 NO-LABEL
     fi_camp AT ROW 3.62 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_camp2 AT ROW 3.62 COL 59.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_camp3 AT ROW 3.62 COL 80.17 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 5.81 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "  รายละเอียดข้อมูล" VIEW-AS TEXT
          SIZE 128.5 BY .81 AT ROW 8.48 COL 2.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                          ประเภทงาน :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 2.57 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                   วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.52 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "        ข้อมูลผู้ขับขี่นำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 6.81 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 6.91 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                       Campaign 1 :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 3.62 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 6.91 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 6.91 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.52 COL 57.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 5.81 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 5.81 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "2.2 :" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 3.62 COL 56.17 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "           กรุณาป้อนชื่อไฟล์นำเข้า :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 4.62 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "3.2 :" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 3.62 COL 76.67 WIDGET-ID 10
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " ข้อมูลแจ้งประกันนำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 5.71 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1 COL 1
     RECT-79 AT ROW 5 COL 98
     RECT-80 AT ROW 5 COL 109.83
     RECT-380 AT ROW 1.19 COL 3
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
         TITLE              = "Hold Data Text file Orico"
         HEIGHT             = 24
         WIDTH              = 132.33
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
/* BROWSE-TAB br_imptxt 1 fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

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
ON END-ERROR OF C-Win /* Hold Data Text file Orico */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Hold Data Text file Orico */
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
    Run  Import_file. 
    /*IF rs_type = 1 THEN Run  Import_New.    /*ป้ายแดง*/
    ELSE IF rs_type = 2 THEN Run  Import_renew. /* ต่ออายุ */*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp C-Win
ON LEAVE OF fi_camp IN FRAME fr_main
DO:
    fi_camp =  INPUT  fi_camp.
    Disp  fi_camp   WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp2 C-Win
ON LEAVE OF fi_camp2 IN FRAME fr_main
DO:
    fi_camp2 =  INPUT  fi_camp2.
    Disp  fi_camp2   WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp3 C-Win
ON LEAVE OF fi_camp3 IN FRAME fr_main
DO:
    fi_camp3 =  INPUT  fi_camp3.
    Disp  fi_camp3   WITH Frame  fr_main.                 

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
    IF rs_type = 1 THEN DO:
        ASSIGN fi_camp  = ""
               fi_camp2 = ""
               fi_camp3 = "".
    END.
    ELSE ASSIGN fi_camp  = ""
                fi_camp2 = ""
                fi_camp3 = "".

    /*IF  rs_type  = 1 THEN ASSIGN fi_producer = "A0M0080".
    ELSE IF rs_type  = 2 THEN ASSIGN fi_producer = "A0M0079".*/
    DISP rs_type fi_camp fi_camp2 fi_camp3 /*fi_producer*/ WITH FRAME fr_main.
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
  
  gv_prgid = "wgwimamn".
  gv_prog  = "Hold Text File Amanah".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */

  MESSAGE "TEST01" VIEW-AS ALERT-BOX.
 
  Hide Frame  fr_gen  .
  ASSIGN  
      fi_loaddat  =  today
      fi_compa    = "AMANAH"
      fi_camp  = ""
      fi_camp2 = ""
      fi_camp3 = ""
      rs_type     = 1.
      /*fi_producer = "A0M0080".*/
      /*ra_txttyp   = 1 
      ra_txttyp2  = 1 .*/
  disp  fi_loaddat fi_camp fi_camp2 fi_camp3  fi_compa rs_type with  frame  fr_main.
  
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
  DISPLAY fi_loaddat fi_compa fi_filename fi_impcnt fi_completecnt fi_dir_cnt 
          fi_dri_complet rs_type fi_camp fi_camp2 fi_camp3 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_imptxt fi_loaddat fi_compa fi_filename bu_ok bu_exit bu_file 
         rs_type fi_camp fi_camp2 fi_camp3 RECT-1 RECT-79 RECT-80 RECT-380 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_file C-Win 
PROCEDURE import_file :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FOR EACH  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|"       
            wdetail.n_no            /*ลำดับที่        */                                        
            wdetail.RegisDate       /*วันที่แจ้ง      */                                        
            wdetail.Account_no      /*เลขรับแจ้งงาน   */
            /*wdetail.prevpol         /*เลขกรมธรรม์      */ */ /*ฤ64-0150*/ 
            wdetail.safe_no         /*รหัสบรษัท       */                                        
            wdetail.CMRName         /*ชื่อผู้แจ้ง     */                                        
            wdetail.branch          /*สาขา            */
            wdetail.CovTyp          /*ประเภทประกัน    */      
            wdetail.typins          /*ประเภทรถ        */      
            wdetail.cartyp          /*ประเภทความคุ้มครอง */           
            wdetail.InsTyp          /*ประกัน แถม/ไม่แถม  */                                     
            wdetail.comtyp          /*พรบ. แถม/ไม่แถม  */                                     
            wdetail.comdat          /*วันเริ่มคุ้มครอง*/                                        
            wdetail.expdat          /*วันสิ้นสุดความคุ้มครอง */                                 
            wdetail.pol_title        /*คำนำหน้าชื่อ    */                                        
            wdetail.pol_fname      /*ชื่อผู้เอาประกัน*/                                        
            wdetail.icno            /*เลขที่บัตรประชาชน  */                                     
            wdetail.bdate           /*วันเกิด         */                                        
            wdetail.expbdate        /*วันที่บัตรหมดอายุ  */                                         
            wdetail.occup           /*อาชีพ           */                                        
            wdetail.name2           /*ชื่อกรรมการ     */                                        
            wdetail.pol_addr1       /*บ้านเลขที่      */                                        
            wdetail.pol_addr2       /*ตำบล/แขวง       */                                        
            wdetail.pol_addr3       /*อำเภอ/เขต       */                                        
            wdetail.pol_addr4       /*จังหวัด         */                                        
            wdetail.pol_addr5       /*รหัสไปรษณีย์    */                                        
            wdetail.phone           /*เบอร์โทรศัพท์   */                                        
            wdetail.drivno          /*ระบุผู้ขับขี่/ไม่ระบุผู้ขับขี*/                           
            wdetail.drivname1       /*ผู้ขับขี่คนที่1  */                                       
            wdetail.drivgen1        /*เพศ              */                                       
            wdetail.drivdate1       /*วันเกิด          */                                       
            wdetail.drivocc1        /*อาชัพ            */                                       
            wdetail.drivid1         /*เลขที่ใบขับขี่   */                                       
            wdetail.drivname2       /*ผู้ขับขี่คนที่2  */                                       
            wdetail.drivgen2        /*เพศ              */                                       
            wdetail.drivdate2       /*วันเกิด          */                                       
            wdetail.drivocc2        /*อาชัพ            */                                       
            wdetail.drivid2         /*เลขที่ใบขับขี่   */                                       
            wdetail.brand           /*ชื่อยี่ห้อรถ     */                                       
            wdetail.Brand_Model     /*รุ่นรถ           */                                       
            wdetail.engine          /*เลขเครื่องยนต์   */                                       
            wdetail.chassis         /*เลขตัวถัง        */                                       
            wdetail.CC              /*ซีซี             */                                       
            wdetail.yrmanu          /*ปีรถยนต์         */                                       
            wdetail.RegisNo         /*เลขทะเบียน       */                                       
            wdetail.RegisProv       /*จังหวัดที่จดทะเบียน */                                    
            wdetail.garage          /*การซ่อม          */                                       
            wdetail.SI              /*ทุนประกัน        */                                       
            wdetail.netprem         /*เบี้ยสุทธิ       */                                       
            wdetail.totalprem       /*เบี้ยประกัน      */                                       
            wdetail.comp_prm        /*เบี้ยพรบ.        */                                       
            wdetail.comp_prmtotal   /*เบี้ยรวม พรบ.    */                                       
            wdetail.stk             /*เลขสติ๊กเกอร์    */                                       
            wdetail.taxname         /*ออกใบเสร็จในนาม  */                                       
            wdetail.ben_name        /*ผู้รับผลประโยชน์ */                                       
            wdetail.Remark          /*หมายเหตุ         */
            wdetail.policy          /* เลขกรมธรรม์ */           /*A62-0445*/
            wdetail.inspect         /*เลขตรวจสภาพ      */ 
            wdetail.appno .         /* เลขที่ App */   /*a62-0445*/
        IF INDEX(wdetail.n_no,"แจ้งงาน")    <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.n_no,"ลำดับ") <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.n_no,"ที่")   <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.n_no,"No")    <> 0 THEN  DELETE wdetail.
        ELSE IF  wdetail.n_no               = "" THEN  DELETE wdetail.
    END.  /* repeat  */
    ASSIGN nv_reccnt    = 0
        nv_completecnt  = 0 . 

    Run proc_Create_tlt.
    
    If  nv_completecnt  <>  0  Then do:
        Enable br_imptxt With frame fr_main.
    End. 
    
    fi_completecnt  =  nv_completecnt.
    fi_impcnt       =  nv_reccnt.
    
    Disp fi_completecnt   fi_impcnt with frame  fr_main.
    Message "Load  Data Complete"  View-as alert-box.  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_GETISP C-Win 
PROCEDURE PD_GETISP :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A62-0445 Date 01/10/2019       
------------------------------------------------------------------------------*/
DEF VAR n_list      AS INT init 0.
DEF VAR n_count     AS INT init 0.
DEF VAR n_agent     AS CHAR FORMAT "x(10)" INIT "".
DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".
DO:
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
              ASSIGN    n_list     = INT(nv_damlist) 
                        nv_damlist = " " + nv_damlist + " รายการ " .
          END.
          IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหายทั้งสิ้น " + nv_totaldam + " บาท " .
          
          IF n_list > 0  THEN DO:
            ASSIGN  n_count = 1 .
            loop_damage:
            REPEAT:
                IF n_count <= n_list THEN DO:
                    ASSIGN  n_dam    = "List"   + STRING(n_count) 
                            n_repair = "Repair" + STRING(n_count) .

                    chitem       = chDocument:Getfirstitem(n_dam).
                    IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                    ELSE nv_damag = "".   
                    chitem       = chDocument:Getfirstitem(n_repair).
                    IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                    ELSE nv_repair = "".

                    IF nv_damag <> "" THEN  
                        ASSIGN nv_damdetail = nv_damdetail + STRING(n_count) + "." + nv_damag + " " + nv_repair + " , " .
                        
                    n_count = n_count + 1.
                END.
                ELSE LEAVE loop_damage.
            END.
          END.
      END.
      /*-- ข้อมูลอื่น ๆ ---*/
      chitem       = chDocument:Getfirstitem("SurveyData").
      IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
      ELSE nv_surdata = "".
      IF trim(nv_surdata) <> "" THEN  nv_surdata = "ข้อมูลอื่นๆ :"  +  nv_surdata .
      
     /*-- อุปกรณ์เสริม --*/  
      chitem       = chDocument:Getfirstitem("device1").
      IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
      ELSE nv_device = "".
      IF nv_device <> "" THEN DO:
          chitem       = chDocument:Getfirstitem("PricesTotal").  /* ราคารวมอุปกรณ์เสริม */
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
          
          nv_device = "" .
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
          nv_device   = " อุปกรณ์เสริม :" + TRIM(nv_device).
          nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " .

      END.

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_INSPEC C-Win 
PROCEDURE PD_INSPEC :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A62-0445 Date 01/10/2019 
------------------------------------------------------------------------------*/
DO:
    ASSIGN              
        nv_year      = STRING(YEAR(TODAY))
        nv_year      = SUBSTR(nv_year,3,2) 
        /* real database */
        NotesServer  = "Safety_NotesServer/Safety"
        NotesApp     = "safety\uw\inspect" + nv_year + ".nsf"
        
        /* test database 
        NotesServer  = ""
        NotesApp     = "D:\Lotus\Notes\Data\ranu\inspect20.nsf" */

        NotesView    = "chassis_no" /* วิวซ่อนของเลขตัวถัง */ 
        nv_chkdoc    = NO             
        nv_msgbox    = ""
        nv_name      = ""
        nv_datim     = ?
        nv_branch    = ""
        nv_brname    = ""
        nv_pattern   = ""
        nv_count     = 0
        nv_text1     = ""
        nv_text2     = ""
        nv_chktext   = 0
        nv_model     = ""
        nv_modelcode = ""
        nv_makdes    = ""
        nv_licence1  = ""
        nv_licence2  = ""
        nv_provin    = "" 
        nv_key1      = "" 
        nv_key2      = "" 
        nv_key3      = "" 
        nv_cha_no    = TRIM(brstat.tlt.cha_no).
                                                                                                                                           
    nv_licence1 = trim(brstat.tlt.lince1).
    
    IF TRIM(nv_licence1) = ""
    OR TRIM(nv_cha_no)   = "" THEN DO:
        MESSAGE "ทะเบียนรถ หรือ เลขตัวถัง เป็นค่าว่าง" SKIP
                "กรุณาระบุข้อมูลให้ครบถ้วน !" 
        VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.

    IF TRIM(brstat.tlt.lince3) <> "" THEN DO:
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(brstat.tlt.lince3) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN nv_provin = brstat.Insure.LName.
            ELSE ASSIGN nv_provin = TRIM(brstat.tlt.lince3).
    END.
    
    nv_licence2 = trim(nv_licence1) + " " + trim(nv_provin) .
    IF trim(nv_licence2) <> "" THEN DO:
       ASSIGN nv_licence2 = REPLACE(nv_licence2," ","").

       IF INDEX("0123456789",SUBSTR(nv_licence2,1,1)) <> 0 THEN DO:
          IF LENGTH(nv_licence2) = 4 THEN 
             ASSIGN nv_Pattern = "y-xx-y-xx"
                    nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,2) + " " + SUBSTR(nv_licence2,4,1).
          ELSE IF LENGTH(nv_licence2) = 5 THEN
              ASSIGN nv_Pattern = "y-xx-yy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,2) + " " + SUBSTR(nv_licence2,4,2).
          ELSE IF LENGTH(nv_licence2) = 6 THEN DO:
              IF INDEX("0123456789",SUBSTR(nv_licence2,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "yy-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4).
              ELSE IF INDEX("0123456789",SUBSTR(nv_licence2,3,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "yx-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4).
              ELSE 
                  ASSIGN nv_Pattern = "y-xx-yyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,2) + " " + SUBSTR(nv_licence2,4,3). 
          END.
          ELSE 
              ASSIGN nv_Pattern = "y-xx-yyyy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,2) + " " + SUBSTR(nv_licence2,4,4).
       END.
       ELSE DO:
           IF LENGTH(nv_licence2) = 3 THEN 
             ASSIGN nv_Pattern = "xx-y-xx"
                    nv_licence2    = SUBSTR(nv_licence2,1,2) + " "  + SUBSTR(nv_licence2,3,1) .
           ELSE IF LENGTH(nv_licence2) = 4 THEN
              ASSIGN nv_Pattern = "xx-yy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,2) .
           ELSE IF LENGTH(nv_licence2) = 6 THEN
              ASSIGN nv_Pattern = "xx-yyyy-xx" 
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4) .
           ELSE IF LENGTH(nv_licence2) = 5 THEN DO:
               IF INDEX("0123456789",SUBSTR(nv_licence2,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "x-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,4).
               ELSE 
                  ASSIGN nv_Pattern = "xx-yyy-xx" 
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,3).
           END.
       END.
    END.
    CREATE "Notes.NotesSession" chSession.                              
    CREATE "Notes.NotesUIWorkSpace" chWorkSpace.    
    chDatabase = chSession:GetDatabase(NotesServer,NotesApp).    
    
    IF chDatabase:isOpen = NO THEN DO: 
        MESSAGE "Can not open Database !" VIEW-AS ALERT-BOX.
        RETURN NO-APPLY.
    END.
    ELSE DO: 
       chName   = chSession:CreateName(chSession:UserName).        
        nv_name  = chName:Abbreviated.
        nv_datim = STRING(TODAY,"99/99/9999") + " " + STRING(TIME,"HH:MM:SS").
       
        /* nv_brname */
        FIND FIRST sicsyac.xmm600                               
             WHERE sicsyac.xmm600.acno = trim(wdetail.producer)  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm600 THEN nv_brname = sicsyac.xmm600.NAME.
        /*----------*/
        
        /* Check Record Duplication */        
        chWorkspace:OpenDatabase(NotesServer,NotesApp,NotesView,"",FALSE,FALSE).
        chView = chDatabase:GetView(NotesView).        

        IF VALID-HANDLE(chView) = NO THEN DO:
            nv_chkdoc = NO.
            nv_msgbox = "Can not Connect View !".
        END.
        ELSE DO:                
            chViewNavigator = chView:CreateViewNavFromCategory(nv_cha_no).            
            nv_doc_num      = chViewNavigator:COUNT.      
                                            
            IF nv_doc_num = 0 THEN DO:                
                nv_chkdoc = YES.
            END.                
            ELSE DO:                                                  
                chViewEntry = chViewNavigator:GetFirstDocument.
                IF VALID-HANDLE(chViewEntry) = NO THEN 
                    nv_chkdoc  = YES.                                                                      
                ELSE chDocument = chViewEntry:Document. 

                loop_chkrecord:
                REPEAT:
                    IF VALID-HANDLE(chDocument) = NO THEN DO:
                        nv_chkdoc = YES.
                        LEAVE loop_chkrecord.
                    END.
                    ELSE DO:                    
                        nv_licen1 = chDocument:GetFirstItem("LicenseNo_1"):TEXT.
                        nv_licen2 = chDocument:GetFirstItem("LicenseNo_2"):TEXT.  
          
                        nv_key1   = nv_licen1 + IF nv_licen2 = "" THEN "" ELSE " " + nv_licen2. /* Notes */
                        nv_key3   = nv_licence1 + " " + nv_provin . /*A62-0219*/          /* PM */

                        IF INDEX(nv_key1," ") <> 0 THEN nv_key1 = REPLACE(nv_key1," ","") .
                        IF INDEX(nv_key3," ") <> 0 THEN nv_key3 = REPLACE(nv_key3," ","") .
                        
                        IF nv_key1 = nv_key3 THEN DO:
                            
                            chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
                            IF chitem <> 0 THEN nv_surcl   = chitem:TEXT. 
                            ELSE nv_surcl  = "".
                           
                            IF nv_surcl = "" THEN DO:                            
                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.
                                nv_chkdoc = NO.
                                nv_msgbox = "มีข้อมูลเลขตัวถังกับเลขทะเบียนในกล่อง ยังไม่ปิดเรื่อง " + nv_docno .
                                LEAVE loop_chkrecord.
                            END.
                            ELSE DO:
                                
                                chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
                                IF chitem <> 0 THEN nv_date = chitem:TEXT. 
                                ELSE nv_date = "".

                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.

                                nv_msgbox = "มีข้อมูลเลขตัวถังกับเลขทะเบียนในกล่อง ปิดเรื่องแล้ว " + nv_docno .
                               
                                nv_chkdoc = NO.
                                LEAVE loop_chkrecord.
                            END.
                        END.
                        ELSE DO:
                            chViewEntry = chViewNavigator:GetNextDocument(chViewEntry). 
                            IF VALID-HANDLE(chViewEntry) = NO THEN DO:                 
                                nv_chkdoc = YES.                                       
                                LEAVE loop_chkrecord.                                  
                            END.                                                       
                            ELSE DO:                                                   
                                chDocument = chViewEntry:Document.                     
                                NEXT loop_chkrecord.                                   
                            END. 
                        END.
                    END. /*  else  */
                END. /* end repeate */
            END.  
            /* End Check */
                
            IF nv_chkdoc = NO THEN DO:
                ASSIGN 
                   nv_surdata  = "" 
                   nv_damlist  = "" 
                   nv_damage   = "" 
                   nv_detail   = "" 
                   nv_device   = "" 
                   nv_acctotal = "" .
                IF nv_surcl <> "" THEN  RUN PD_getisp.
                IF nv_docno <> ""  THEN DO:
                     ASSIGN 
                     brstat.tlt.gentim     = trim(nv_detail + " " + nv_damage + " " + nv_damlist + " " + 
                                              nv_damdetail + " " + nv_surdata + " " + nv_device + " " + nv_acctotal )   /* ผลตรวจสภาพ*/
                     brstat.tlt.rec_addr3  = TRIM(nv_docno) .
                     
                END.
                /*RELEASE brstat.tlt. */       
                
            END.
            ELSE DO:
                chDocument = chDatabase:CreateDocument.
                ASSIGN
                    chDocument:FORM        = "Inspection"                        
                    chDocument:createdBy   = nv_name                             
                    chDocument:createdOn   = nv_datim                            
                    chDocument:dateS       = brstat.tlt.gendat                            
                    chDocument:dateE       = brstat.tlt.expodat                           
                    chDocument:ReqType_sub = "ลูกค้า/ตัวแทน/นายหน้าเป็นผู้ส่งรูปตรวจสภาพ"
                    /*chDocument:BranchReq   = "Business Unit 3"   *//*A64-0150 */ 
                    chDocument:BranchReq   = "Bank & Finance"      /*A64-0150 */ 
                    chDocument:Tname       = "บุคคล"                             
                    chDocument:Fname       = SUBSTR(brstat.tlt.ins_name,1,INDEX(brstat.tlt.ins_name," ") - 1)                         
                    chDocument:Lname       = SUBSTR(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1)                        
                    chDocument:phone1      = TRIM(wdetail.phone)    
                    chDocument:PolicyNo    = ""                          
                    chDocument:agentCode   = trim(wdetail.producer)                         
                    chDocument:agentName   = nv_brname                           
                    chDocument:Premium     = TRIM(wdetail.totalprem)                          
                    chDocument:model       = brstat.tlt.brand   /*nv_model    */                        
                    chDocument:modelCode   = brstat.tlt.model   /*nv_modelcode*/                        
                    chDocument:Year        = brstat.tlt.lince2                            
                    chDocument:carCC       = nv_cha_no                           
                    chDocument:LicenseType = "รถเก๋ง/กระบะ/บรรทุก"               
                    chDocument:PatternLi1  = nv_pattern                          
                    chDocument:LicenseNo_1 = nv_licence1                       
                    chDocument:LicenseNo_2 = nv_provin 
                    chDocument:garage      = trim(wdetail.garage)
                    chDocument:App         = 0                                   
                    chDocument:Chk         = 0                                   
                    chDocument:StList      = 0                                   
                    chDocument:stHide      = 0                                   
                    chDocument:SendTo      = ""                                  
                    chDocument:SendCC      = ""                                  
                    chDocument:SendClose   = ""
                    chDocument:SurveyClose = ""                    
                    chDocument:docno       = "".       
            
                /*chDocument:SAVE(TRUE,FALSE).*/ 
                chDocument:SAVE(TRUE,TRUE).  
                chWorkSpace:ViewRefresh.  
                chUIDocument = chWorkSpace:CurrentDocument.                                         
                chUIDocument = chWorkSpace:EditDocument(FALSE,chDocument) NO-ERROR.
            END.                                        
        END.
    END.

    RELEASE OBJECT chSession       NO-ERROR.
    RELEASE OBJECT chWorkSpace     NO-ERROR.
    RELEASE OBJECT chName          NO-ERROR.
    RELEASE OBJECT chDatabase      NO-ERROR.
    RELEASE OBJECT chView          NO-ERROR.
    RELEASE OBJECT chViewEntry     NO-ERROR.    
    RELEASE OBJECT chViewNavigator NO-ERROR.
    RELEASE OBJECT chDocument      NO-ERROR.
    RELEASE OBJECT chUIDocument    NO-ERROR.    
    
END.

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
/*IF rs_type = 1 THEN DO:  /* ปีแรก */*/
   ASSIGN wdetail.CustAddress = trim(wdetail.pol_addr1) + " " + TRIM(wdetail.pol_addr2) + " " +
                                trim(wdetail.pol_addr3) + " " + TRIM(wdetail.pol_addr4) + " " +
                                trim(wdetail.pol_addr5) .

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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chksuspect C-Win 
PROCEDURE proc_chksuspect :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A62-0445      
------------------------------------------------------------------------------*/
DO:
    ASSIGN nv_susupect = "" .

    IF index(wdetail.pol_fname," ") <> 0 THEN DO: 
        ASSIGN  wdetail.pol_lname = trim(SUBSTR(wdetail.pol_fname,R-INDEX(wdetail.pol_fname," ") + 1))   
                wdetail.pol_fname = trim(SUBSTR(wdetail.pol_fname,1,INDEX(wdetail.pol_fname," ") - 1)) . 
    END.

    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03 WHERE trim(uzsusp.fname)   = trim(wdetail.pol_fname) AND 
                                                    trim(uzsusp.lname)   = trim(wdetail.pol_lname) AND
                                                    (TRIM(uzsusp.suscod) = "25"   OR                        /* ติด คปภ. */
                                                    TRIM(uzsusp.suscod)  = "26" ) NO-LOCK NO-ERROR NO-WAIT. /* ติด คปง. */
            IF AVAIL sicuw.uzsusp THEN DO:
                ASSIGN  nv_susupect = trim(uzsusp.fname) + " " + trim(uzsusp.lname) + " Pol:" + trim(uzsusp.text1) + " " + " Code:" + trim(uzsusp.suscod) + " Remark:" + trim(uzsusp.note) .
            END.                            
            ELSE DO:
                FIND LAST sicuw.uzsusp USE-INDEX uzsusp03 WHERE trim(uzsusp.fname) = trim(wdetail.pol_fname) AND
                                                                trim(uzsusp.lname) = trim(wdetail.pol_lname) AND
                                                                (INDEX(uzsusp.text2,"V70") <> 0   OR
                                                                INDEX(uzsusp.text2,"V72")  <> 0   OR 
                                                                INDEX(uzsusp.text2,"All")  <> 0 ) NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL sicuw.uzsusp THEN DO:
                                ASSIGN  nv_susupect = trim(uzsusp.fname) + " " + trim(uzsusp.lname) + " Pol:" + trim(uzsusp.text1) + " " + " Code:" + trim(uzsusp.suscod) + " Remark:" + trim(uzsusp.note) .
                            END.
            END.

    IF wdetail.chassis <> "" AND nv_susupect = "" THEN DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp05 WHERE uzsusp.cha_no = trim(wdetail.chassis) AND TRIM(uzsusp.text2) <> ""  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uzsusp THEN DO:
                ASSIGN  nv_susupect = trim(uzsusp.fname) + " " + trim(uzsusp.lname) + " Pol:" + trim(uzsusp.text1) + " " + " Code:" + trim(uzsusp.suscod) + " Remark:" + trim(uzsusp.note) .

            END.
    END.

    ASSIGN wdetail.pol_fname = trim(wdetail.pol_fname) + " " + TRIM(wdetail.pol_lname).
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt C-Win 
PROCEDURE proc_create_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS INT INIT 0.
LOOP_wdetail:
FOR EACH wdetail .
    IF wdetail.account_no = ""  THEN DELETE wdetail.  /*a61-0234*/
    ELSE DO:
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
        IF wdetail.chassis = "" THEN 
            MESSAGE "เลขตัวถังเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
        ELSE DO:
            RUN proc_cutchassic.
            RUN proc_cutchar.
            RUN proc_cutpol.
            /* comment by A62-0445..
            IF      index(TRIM(wdetail.typins),"เก๋ง")  <> 0 THEN   ASSIGN wdetail.n_class70 = "110".
            ELSE IF index(TRIM(wdetail.typins),"กระบะ") <> 0 THEN   ASSIGN wdetail.n_class70 = "320".
            ELSE IF index(TRIM(wdetail.typins),"ตู้")   <> 0 THEN   ASSIGN wdetail.n_class70 = "210".
            ELSE ASSIGN wdetail.n_class70 = "110".

            IF INDEX(wdetail.cartyp,"ป้ายแดง") <> 0 THEN ASSIGN wdetail.producer = "A0M0122" .
            ELSE IF INDEX(wdetail.cartyp,"USE") <>  0 THEN ASSIGN wdetail.producer = "A0M0123" .
            ELSE IF INDEX(wdetail.cartyp,"ต่ออายุ") <> 0 THEN ASSIGN wdetail.producer = "A0M0124" .
            ELSE IF index(wdetail.cartyp,"พรบ.") <>  0 THEN ASSIGN wdetail.producer = "A0M0125" .
            ...end A62-0445 ..*/ 
            /* add by a62-0445 */
            IF      index(TRIM(wdetail.cartyp),"เก๋ง")   <> 0 THEN   ASSIGN wdetail.n_class70 = "110".
            ELSE IF index(TRIM(wdetail.cartyp),"กระบะ")  <> 0 THEN   ASSIGN wdetail.n_class70 = "320".
            ELSE IF index(TRIM(wdetail.cartyp),"บรรทุก") <> 0 THEN   ASSIGN wdetail.n_class70 = "320".
            ELSE IF index(TRIM(wdetail.cartyp),"ตู้")    <> 0 THEN   ASSIGN wdetail.n_class70 = "210".
            ELSE IF index(TRIM(wdetail.cartyp),"1")      <> 0 THEN   ASSIGN wdetail.n_class70 = "110".
            ELSE IF index(TRIM(wdetail.cartyp),"2")      <> 0 THEN   ASSIGN wdetail.n_class70 = "210".
            ELSE IF index(TRIM(wdetail.cartyp),"3")      <> 0 THEN   ASSIGN wdetail.n_class70 = "320".
            ELSE ASSIGN wdetail.n_class70 = "110".
            /* comment by : A64-0150...
            IF      INDEX(wdetail.typins,"ป้ายแดง") <> 0 THEN ASSIGN wdetail.producer = "A0M0122" .
            ELSE IF INDEX(wdetail.typins,"USE")     <> 0 THEN ASSIGN wdetail.producer = "A0M0123" .
            ELSE IF INDEX(wdetail.typins,"ต่ออายุ") <> 0 THEN ASSIGN wdetail.producer = "A0M0124" .
            ELSE IF index(wdetail.typins,"พรบ.")    <> 0 THEN ASSIGN wdetail.producer = "A0M0125" .
            /* end a62-0445 */
            ..end A64-0150..*/
            /* add by : A64-0150...*/
            IF      INDEX(wdetail.typins,"ป้ายแดง") <> 0 THEN ASSIGN wdetail.producer = "A0MLAMA101" .
            ELSE IF INDEX(wdetail.typins,"USE")     <> 0 THEN ASSIGN wdetail.producer = "A0MLAMA102" .
            ELSE IF INDEX(wdetail.typins,"ต่ออายุ") <> 0 THEN ASSIGN wdetail.producer = "A0MLAMA103" .
            ELSE IF index(wdetail.typins,"พรบ.")    <> 0 THEN ASSIGN wdetail.producer = "A0MLAMA104" .
            /*..end A64-0150..*/

            /* ------------------------check policy  Duplicate--------------------------------------*/ 
            IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat  = DATE(wdetail.comdat).
            ELSE ASSIGN nv_comdat = ?.

            IF (wdetail.expdat <>  "" ) THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
            ELSE ASSIGN nv_expdat  = ?.
        
            IF (wdetail.regisdate <> "")  THEN ASSIGN nv_accdat = DATE(wdetail.regisdate).
            ELSE ASSIGN nv_accdat = ?.
           /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- */
            IF INDEX(wdetail.si,"ป") <> 0 THEN nv_insamt3 = 0.
            ELSE nv_insamt3 = DECIMAL(wdetail.si).   
           
            RUN proc_address.
            RUN proc_chksuspect . /*A62-0445*/
         
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                brstat.tlt.cha_no       = trim(wdetail.chassis)   AND
                brstat.tlt.eng_no       = TRIM(wdetail.engine)    AND
                brstat.tlt.genusr       = fi_compa                NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:
               CREATE brstat.tlt.
                    nv_completecnt  =  nv_completecnt + 1.
                    ASSIGN                                                 
                        brstat.tlt.entdat       =   TODAY                             /* วันที่โหลด */                          
                        brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")           /* เวลาโหลด   */                          
                        brstat.tlt.trndat       =   fi_loaddat                        /* วันที่จากหน้าจอ*/
                        brstat.tlt.datesent     =   nv_accdat                         /* วันที่ไฟล์แจ้งงาน */
                        /*brstat.tlt.trntim       =   TRIM(wdetail.not_time) */       /* เวลาแจ้งงาน*/
                        brstat.tlt.safe2        =   caps(trim(wdetail.Account_no))          /*เลขที่สัญญา   */ 
                        brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)             /*รหัสบริษัท    */  
                        brstat.tlt.nor_usr_ins  =   trim(wdetail.CMRName)             /*ผู้แจ้ง       */   
                        brstat.tlt.exp          =   TRIM(wdetail.branch)              /*สาขา          */
                        brstat.tlt.colorcod     =   TRIM(wdetail.cartyp)              /*ประเภทรถประกัน*/ 
                        brstat.tlt.old_cha      =   TRIM(wdetail.typins)               /* ประเภทรถ */
                        brstat.tlt.comp_usr_tlt =   trim(wdetail.CovTyp)               /*ประเภทความคุ้มครอง   */          
                        brstat.tlt.expousr      =   trim(wdetail.instyp)               /* ประกันแถม/ไม่แถม*/ 
                        brstat.tlt.old_eng      =   TRIM(wdetail.comtyp)               /* พรบ . แถม/ไม่แถม */
                        brstat.tlt.gendat       =   nv_comdat                          /*วันที่เริ่มคุ้มครอง  */  
                        brstat.tlt.expodat      =   nv_expdat                          /*วันที่สิ้นสุดคุ้มครอง*/  
                        brstat.tlt.rec_name     =   trim(wdetail.pol_title)            /*คำนำหน้าชื่อผู้เอาประกันภัย */          
                        brstat.tlt.ins_name     =   trim(wdetail.pol_fname)            /*ชื่อผู้เอาประกันภัย */           
                        brstat.tlt.ins_addr5    =   "IC:" + trim(wdetail.icno) +       /*IDCARD              */   
                                                    " BD:" + TRIM(wdetail.bdate) +     /*วันเกิด */
                                                    " BE:" + TRIM(wdetail.expbdate) +  /*วันที่บัตรหมด */
                                                    " TE:" + TRIM(wdetail.phone)       /* เบอร์โทร */
                        brstat.tlt.recac        =   TRIM(wdetail.occup)                /* อาชีพ */ 
                        brstat.tlt.nor_usr_tlt  =   TRIM(wdetail.name2)                /* ชื่อกรรมการ */
                        brstat.tlt.ins_addr1    =   trim(wdetail.pol_addr1)                /*ที่อยู่ลูกค้า */          
                        brstat.tlt.ins_addr2    =   trim(wdetail.pol_addr2)                        
                        brstat.tlt.ins_addr3    =   trim(wdetail.pol_addr3)                        
                        brstat.tlt.ins_addr4    =   trim(wdetail.pol_addr4)  + " " + trim(wdetail.pol_addr5) 
                        brstat.tlt.endno        =   TRIM(wdetail.drivno)               /* ระบุผู้ขับขี่ */
                        brstat.tlt.dri_name1    =   TRIM(wdetail.drivname1) +          
                                                    " ID1:" + TRIM(wdetail.drivid1)    /* ผุ้ขับขี่ + ใบขับขี่ 1 */                            
                        brstat.tlt.dri_no1      =   TRIM(wdetail.drivdate1)            /* วันเกิด 1 */
                        brstat.tlt.rec_addr1    =   TRIM(wdetail.drivgen1)  +          
                                                    " OC1:" + TRIM(wdetail.drivocc1)   /* เพศ + อาชีพ 1 */
                        brstat.tlt.dri_name2    =   TRIM(wdetail.drivname2) +          
                                                    " ID2:" + TRIM(wdetail.drivid2)    /* ผุ้ขับขี่ + ใบขับขี่ 2 */                              
                        brstat.tlt.dri_no2      =   TRIM(wdetail.drivdate2)            /* วันเกิด 2 */
                        brstat.tlt.rec_addr2    =   TRIM(wdetail.drivgen2)  +          
                                                    " OC2:" + TRIM(wdetail.drivocc2)   /* เพศ + อาชีพ 2 */
                        brstat.tlt.brand        =   trim(wdetail.brand)               /*ยี่ห้อ      */          
                        brstat.tlt.model        =   trim(wdetail.Brand_Model)         /*รุ่น        */
                        brstat.tlt.eng_no       =   trim(wdetail.engine)              /*เลขเครื่อง  */          
                        brstat.tlt.cha_no       =   trim(wdetail.chassis)             /*เลขถัง      */ 
                        brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)               /*ขนาดเครื่อง */  
                        brstat.tlt.lince2       =   trim(wdetail.yrmanu)              /*ปี          */ 
                        brstat.tlt.lince1       =   trim(wdetail.RegisNo)             /*เลขทะเบียน */          
                        brstat.tlt.lince3       =   trim(wdetail.RegisProv)           /*จังหวัด    */ 
                        brstat.tlt.stat         =   trim(wdetail.garage)              /*สถานที่ซ่อม */ 
                        brstat.tlt.nor_coamt    =   nv_insamt3                        /*ทุนประกัน   */     
                        brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)             /*เบี้ยสุทธิ*/              
                        brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)           /*เบี้ยรวม กธ.  */ 
                        brstat.tlt.rec_addr4    =   IF INDEX(wdetail.comp_prm,"ไม่เอา") = 0 THEN string(DECI(wdetail.comp_prm))  ELSE "0"  /*เบี้ยรวมพรบ. */     
                        brstat.tlt.comp_grprm   =   DECI(Wdetail.comp_prmtotal)       /*เบี้ยรวม กธ. + พรบ. */  
                        brstat.tlt.comp_sck     =   TRIM(wdetail.stk)                 /* สติ๊กเกอร์ */  
                        brstat.tlt.rec_addr5    =   TRIM(Wdetail.taxname)              /*ออกใบเสร็จในนาม */ 
                        brstat.tlt.safe1        =   TRIM(wdetail.ben_name)            /*ผู้รับผลประโยชน์   */ 
                        /*brstat.tlt.filler2      =  trim(wdetail.remark)    A62-0445 */     /*หมายเหตุ    */ 
                        brstat.tlt.filler2      =   trim(wdetail.appno) + "/" + trim(wdetail.remark)   /*หมายเหตุ    */  /*A62-0445*/      
                        brstat.tlt.filler1      =   TRIM(wdetail.prevpol)               /*เบอร์ต่ออายุ*/         
                        brstat.tlt.rec_addr3    =   TRIM(wdetail.inspect)               /*ตรวจสภาพ*/

                        brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"  /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */      
                        /*brstat.tlt.safe3        =   IF index(wdetail.CovTyp,"1") <> 0 AND INDEX(wdetail.garage,"อู่")  <> 0 THEN "G"
                                                    ELSE IF index(wdetail.CovTyp,"1") <> 0 AND INDEX(wdetail.garage,"ห้าง")  <> 0 THEN "F" 
                                                    ELSE IF index(wdetail.CovTyp,"+") <> 0  THEN "Z"  
                                                    ELSE "G" */ /*A64-0150*/                        /*pack + class70 */
                        brstat.tlt.safe3        =   "T"  /*A64-0150*/ 
                        brstat.tlt.safe3        =   brstat.tlt.safe3 + wdetail.n_class70   /*pack + class70 */     
                        brstat.tlt.genusr       =   "AMANAH"                                                     
                        brstat.tlt.usrid        =   USERID(LDBNAME(1))                  /*User Load Data */                      
                        brstat.tlt.imp          =   "IM"                                /*Import Data*/                          
                        brstat.tlt.releas       =   "No"                                      
                        brstat.tlt.comp_sub     =   TRIM(wdetail.producer)      
                      /*brstat.tlt.comp_noti_ins =  "B3W0100"  --- Comment By Tontawan S. A66-0139 10/08/2023 --*/
                        brstat.tlt.comp_noti_ins =  "B300316" /*------ Add By Tontawan S. A66-0139 10/08/2023 --*/
                        brstat.tlt.nor_noti_ins =   "" /*TRIM(trim(wdetail.safe_no))  */       /*เบอร์ใหม่ */            
                        brstat.tlt.comp_pol     =   "" /*trim(wdetail.compno)         */       /*เบอร์ พรบ.  */  
                        brstat.tlt.dat_ins_noti =   ?                                   /*วันที่ออกงาน */
                        brstat.tlt.lotno        =   IF index(wdetail.CovTyp,"1") <> 0 THEN TRIM(fi_camp) 
                                                    ELSE IF INDEX(wdetail.covtyp,"2+") <> 0 THEN TRIM(fi_camp2) 
                                                    ELSE IF INDEX(wdetail.covtyp,"3+") <> 0 THEN TRIM(fi_camp3)
                                                    ELSE ""  /*แคมเปญ*/
                        /* create by A62-0445*/
                        brstat.tlt.gentim       =  ""              /*ผลตรวจสภาพ */
                        brstat.tlt.expotim      =  nv_susupect .   /* suspect */
                        IF brstat.tlt.expotim = "" AND (brstat.tlt.old_cha = "Usedcar" OR brstat.tlt.old_cha = "usecar" ) THEN DO:
                           IF INDEX(brstat.tlt.comp_usr_tlt,"1") <> 0  THEN  RUN  PD_INSPEC.
                           /*IF INDEX(brstat.tlt.comp_usr_tlt,"2+") <> 0 AND brstat.tlt.nor_coamt > 350000 THEN  RUN  PD_INSPEC.*/ /*A64-0150*/
                           IF INDEX(brstat.tlt.comp_usr_tlt,"2+") <> 0 AND brstat.tlt.nor_coamt >= 350000 THEN  RUN  PD_INSPEC. /*A64-0150*/
                        END.
                         /* end A62-0445 */
            END.                      
            ELSE DO:
                nv_completecnt  =  nv_completecnt + 1.                      
                RUN proc_Create_tlt2.
            END.
        END.
    END.
END.
Run proc_Open_tlt.                           
                            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt-bp C-Win 
PROCEDURE proc_create_tlt-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS INT INIT 0.
LOOP_wdetail:
FOR EACH wdetail .
   /*IF  wdetail.Account_no = "" THEN  DELETE wdetail. */ /*a61-0234*/
    IF wdetail.account_no = "" /*AND deci(wdetail.comp_prm) = 0*/ THEN DELETE wdetail.  /*a61-0234*/
    ELSE DO:
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
        IF wdetail.safe_no = "" THEN 
            MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
        ELSE DO:
            RUN proc_cutchassic.
            RUN proc_cutchar.
            RUN proc_cutpol.
            /* ------------------------check policy  Duplicate--------------------------------------*/ 
            IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat  = DATE(wdetail.comdat).
            ELSE ASSIGN nv_comdat = ?.

            IF (wdetail.expdat <>  "" ) THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
            ELSE ASSIGN nv_expdat  = ?.
        
            IF (wdetail.regisdate <> "")  THEN ASSIGN nv_accdat = DATE(wdetail.regisdate).
            ELSE ASSIGN nv_accdat = ?.

          /* IF (wdetail.comdat72 <>  "" ) THEN ASSIGN nv_comdat72  = DATE(wdetail.comdat72). 
            ELSE ASSIGN nv_comdat72 = ?.
            IF (wdetail.expdat72 <>  "" ) THEN ASSIGN nv_expdat72  = DATE(wdetail.expdat72).
            ELSE ASSIGN nv_expdat72 = ?.*/
           /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- */
            IF INDEX(wdetail.si,"ป") <> 0 THEN nv_insamt3 = 0.
            ELSE nv_insamt3 = DECIMAL(wdetail.si).   
            /* -------------------------- PREM1 CHR(11)   เบี้ยภาคสมัครใจบวกภาษีบวกอากร --- */
            /*nv_premt1 = DECIMAL(SUBSTRING(wdetail.netprem,1,9)).
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
           /*---------------------------------------------------------------------------------------*/*/
            RUN proc_address.
            IF TRIM(wdetail.name_insur) <> " " THEN DO:
                ASSIGN n = 0
                       wdetail.name_insur = TRIM(wdetail.name_insur).
                       IF INDEX(wdetail.name_insur,"นาย") <> 0 THEN
                           ASSIGN wdetail.pol_title = "นาย"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"นาย","")).
                       ELSE IF INDEX(wdetail.name_insur,"นางสาว") <> 0 THEN
                           ASSIGN wdetail.pol_title = "นางสาว"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"นางสาว","")).
                       ELSE IF INDEX(wdetail.name_insur,"นาง") <> 0 THEN
                           ASSIGN wdetail.pol_title = "นาง"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"นาง","")).
                       ELSE IF INDEX(wdetail.name_insur,"น.ส.") <> 0 THEN
                           ASSIGN wdetail.pol_title = "น.ส."
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"น.ส.","")).
                       ELSE IF INDEX(wdetail.name_insur,"คุณ") <> 0 THEN
                           ASSIGN wdetail.pol_title = "คุณ"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"คุณ","")).
                       ELSE IF INDEX(wdetail.name_insur,"บริษัท") <> 0 THEN
                           ASSIGN wdetail.pol_title = "บริษัท"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"บริษัท","")).
                       ELSE IF INDEX(wdetail.name_insur,"บมจ.") <> 0 THEN
                           ASSIGN wdetail.pol_title = "บมจ."
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"บมจ.","")).
                       ELSE IF INDEX(wdetail.name_insur,"ห้างหุ้นส่วน") <> 0 THEN
                           ASSIGN wdetail.pol_title = "ห้างหุ้นส่วน"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"ห้างหุ้นส่วน","")).
                       ELSE IF INDEX(wdetail.name_insur,"หจก.") <> 0 THEN
                           ASSIGN wdetail.pol_title = "หจก."
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"หจก.","")).
                       ELSE IF INDEX(wdetail.name_insur,"มูลนิธิ") <> 0 THEN
                           ASSIGN wdetail.pol_title = "มูลนิธิ"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"มูลนิธิ","")).
                       ELSE IF INDEX(wdetail.name_insur,"โรงเรียน") <> 0 THEN
                           ASSIGN wdetail.pol_title = "โรงเรียน"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"โรงเรียน","")).
                       ELSE IF INDEX(wdetail.name_insur,"โรงพยาบาล") <> 0 THEN
                           ASSIGN wdetail.pol_title = "โรงพยาบาล"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"โรงพยาบาล","")).
                       ELSE ASSIGN wdetail.pol_title = ""
                                  wdetail.pol_fname = trim(wdetail.name_insur).
            END.
           /* comment by Ranu : A61-0221...........
            IF trim(wdetail.Brand_Model) <> ""  THEN DO:
                IF INDEX(wdetail.brand_model," ") <> 0  THEN 
                    ASSIGN wdetail.brand       = trim(SUBSTR(wdetail.brand_model,1,INDEX(wdetail.brand_model," ")))
                           wdetail.brand_model = TRIM(SUBSTR(wdetail.brand_model,INDEX(wdetail.brand_model," "),LENGTH(wdetail.brand_model))).
                ELSE 
                    ASSIGN wdetail.brand       = TRIM(wdetail.brand_model)
                           wdetail.brand_model = "".
            END.*/

            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                brstat.tlt.cha_no       = trim(wdetail.chassis)   AND
                brstat.tlt.eng_no       = TRIM(wdetail.engine)    AND
                brstat.tlt.genusr       = fi_compa                NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:
               CREATE brstat.tlt.
                    nv_completecnt  =  nv_completecnt + 1.
                    ASSIGN                                                 
                        brstat.tlt.entdat       =   TODAY                             /* วันที่โหลด */                          
                        brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")           /* เวลาโหลด   */                          
                        brstat.tlt.trndat       =   fi_loaddat                        /* วันที่จากหน้าจอ*/
                        brstat.tlt.datesent     =   nv_accdat                         /* วันที่ไฟล์แจ้งงาน */
                        brstat.tlt.trntim       =   TRIM(wdetail.not_time)            /* เวลาแจ้งงาน*/
                        brstat.tlt.exp          =   "M"                               /*สาขา                 */           
                        brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)             /*เลขที่รับแจ้ง        */           
                        brstat.tlt.safe2        =   trim(wdetail.Account_no)          /*เลขที่สัญญา          */           
                        brstat.tlt.rec_name     =   trim(wdetail.pol_title)           /*คำนำหน้าชื่อผู้เอาประกันภัย */          
                        brstat.tlt.ins_name     =   trim(wdetail.pol_fname)           /*ชื่อผู้เอาประกันภัย */           
                        brstat.tlt.ins_addr5    =   trim(wdetail.icno)                /*IDCARD              */           
                        brstat.tlt.stat         =   trim(wdetail.garage)              /*สถานที่ซ่อม         */           
                        brstat.tlt.colorcod     =   TRIM(wdetail.n_color)             /*สีรถ            */           
                        brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"  /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */   
                        brstat.tlt.brand        =   trim(wdetail.brand)               /*ยี่ห้อ      */          
                        brstat.tlt.model        =   trim(wdetail.Brand_Model)         /*รุ่น        */          
                        brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)               /*ขนาดเครื่อง */          
                        brstat.tlt.lince2       =   trim(wdetail.yrmanu)              /*ปี          */          
                        brstat.tlt.eng_no       =   trim(wdetail.engine)              /*เลขเครื่อง  */          
                        brstat.tlt.cha_no       =   trim(wdetail.chassis)             /*เลขถัง      */          
                        brstat.tlt.old_cha      =   TRIM(wdetail.accsor) +            /*อุปกรณ์ตกแต่ง */ 
                                                    " PRICE:" +  TRIM(wdetail.accsor_price)   /*ราคาอุปกรณ์ตกแต่ง */ 
                        brstat.tlt.comp_usr_tlt =   trim(wdetail.CovTyp)            /*ประเภทประกัน    */
                        brstat.tlt.lince1       =   trim(wdetail.RegisNo)             /*เลขทะเบียน */          
                        brstat.tlt.lince3       =   trim(wdetail.RegisProv)           /*จังหวัด    */          
                        brstat.tlt.safe3        =   ""                                /*pack + class70 */  
                        brstat.tlt.expousr      =   trim(wdetail.instyp)              /* ประกันแถม/ไม่แถม*/ 
                        brstat.tlt.old_eng      =   TRIM(wdetail.comtyp)              /* พรบ . แถม/ไม่แถม */
                        brstat.tlt.nor_coamt    =   nv_insamt3                        /*ทุนประกัน   */          
                        brstat.tlt.nor_usr_tlt  =   "TAX:" + TRIM(wdetail.Taxno) +    /*เลขที่ผู้เสียภาษี */ 
                                                    " ID:"  + TRIM(wdetail.saleid) +  /*เลขทะเบียนการค้า*/
                                                    " BR:"  + TRIM(wdetail.branch)    
                        brstat.tlt.gendat       =   nv_comdat                         /*วันที่เริ่มคุ้มครอง  */          
                        brstat.tlt.expodat      =   nv_expdat                         /*วันที่สิ้นสุดคุ้มครอง*/          
                        brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)             /*เบี้ยสุทธิ*/              
                        brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)           /*เบี้ยรวม  */  
                        brstat.tlt.safe1        =   TRIM(wdetail.ben_name) + " Delear:" + trim(wdetail.DealerName) /*ดีลเลอร์    */ 
                        brstat.tlt.nor_usr_ins  =   trim(wdetail.CMRName)               /*ผู้แจ้ง           */          
                        brstat.tlt.comp_sck     =   ""                                  
                        /*brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
                        brstat.tlt.nor_effdat   = nv_expdat72                           /*วันที่สิ้นสุดคุ้มครองพรบ   */ */
                        brstat.tlt.rec_addr4    =   string(DECI(wdetail.comp_prm))      /*เบี้ยสุทธิพรบ. */ 
                        brstat.tlt.comp_grprm   =   DECI(Wdetail.comp_prmtotal)         /*เบี้ยรวมพรบ. */ 
                        brstat.tlt.filler2      =   trim(wdetail.remark)                /*หมายเหตุ    */        
                        brstat.tlt.ins_addr1    =   trim(wdetail.addr1)                 /*ที่อยู่ลูกค้า */          
                        brstat.tlt.ins_addr2    =   trim(wdetail.addr2)                        
                        brstat.tlt.ins_addr3    =   trim(wdetail.addr3)                        
                        brstat.tlt.ins_addr4    =   trim(wdetail.addr4)                 
                        brstat.tlt.rec_addr3    =   TRIM(wdetail.inspect)               /*ตรวจสภาพ*/
                        brstat.tlt.genusr       =   "ORICO"                                                     
                        brstat.tlt.usrid        =   USERID(LDBNAME(1))                  /*User Load Data */                      
                        brstat.tlt.imp          =   "IM"                                /*Import Data*/                          
                        brstat.tlt.releas       =   "No"                                                         
                        brstat.tlt.recac        =   ""                                  /* อาชีพ */                                                                      
                        brstat.tlt.comp_sub     =   IF rs_type = 1 THEN "A0M0130" ELSE "A0M0129"               
                        brstat.tlt.comp_noti_ins =  "B300303"                 
                        brstat.tlt.rec_addr1     =  IF INDEX(wdetail.taxname,"โอริโค่") <> 0 THEN "MC38462" ELSE "" /* vat code */
                        brstat.tlt.rec_addr2    =   trim(wdetail.taxname)               /* Recepit name */
                        brstat.tlt.rec_addr5    =   TRIM(Wdetail.pol_addr1)             /*ที่อยู่ออกใบเสร็จ */ 
                        brstat.tlt.dri_name1    =   TRIM(wdetail.drivname1) + " ID1:" + TRIM(wdetail.drivid1)                             
                        brstat.tlt.dri_no1      =   TRIM(wdetail.drivdate1)                             
                        brstat.tlt.dri_name2    =   TRIM(wdetail.drivname2) + " ID2:" + TRIM(wdetail.drivid2)                            
                        brstat.tlt.dri_no2      =   TRIM(wdetail.drivdate2)
                        brstat.tlt.filler1      =   TRIM(wdetail.prevpol)               /*เบอร์ต่ออายุ*/
                        brstat.tlt.nor_noti_ins =   TRIM(trim(wdetail.safe_no))         /*เบอร์ใหม่ */            
                        brstat.tlt.comp_pol     =   trim(wdetail.compno)                /*เบอร์ พรบ.  */  
                        brstat.tlt.dat_ins_noti =   ?                                   /*วันที่ออกงาน */
                        brstat.tlt.lotno        =   IF index(wdetail.CovTyp,"1") <> 0 THEN TRIM(fi_camp) 
                                                    ELSE IF INDEX(wdetail.covtyp,"2+") <> 0 THEN TRIM(fi_camp2) 
                                                    ELSE IF INDEX(wdetail.covtyp,"3+") <> 0 THEN TRIM(fi_camp3)
                                                    ELSE "".             /*แคมเปญ*/
            END.                      
            ELSE DO:                  
                nv_completecnt  =  nv_completecnt + 1.
                RUN proc_Create_tlt2.
            END.
        END.
    END.
END.
Run proc_Open_tlt.                           
                            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt2 C-Win 
PROCEDURE proc_create_tlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN                                                 
                        brstat.tlt.entdat       =   TODAY                             /* วันที่โหลด */                          
                        brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")           /* เวลาโหลด   */                          
                        brstat.tlt.trndat       =   fi_loaddat                        /* วันที่จากหน้าจอ*/
                        brstat.tlt.datesent     =   nv_accdat                         /* วันที่ไฟล์แจ้งงาน */
                        /*brstat.tlt.trntim       =   TRIM(wdetail.not_time) */       /* เวลาแจ้งงาน*/
                        brstat.tlt.safe2        =   CAPS(trim(wdetail.Account_no))          /*เลขที่สัญญา   */ 
                        brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)             /*รหัสบริษัท    */  
                        brstat.tlt.nor_usr_ins  =   trim(wdetail.CMRName)             /*ผู้แจ้ง       */   
                        brstat.tlt.exp          =   TRIM(wdetail.branch)              /*สาขา          */
                        brstat.tlt.colorcod     =   TRIM(wdetail.cartyp)              /*ประเภทรถประกัน*/ 
                        brstat.tlt.old_cha      =   TRIM(wdetail.typins)               /* ประเภทรถ */
                        brstat.tlt.comp_usr_tlt =   trim(wdetail.CovTyp)               /*ประเภทความคุ้มครอง   */          
                        brstat.tlt.expousr      =   trim(wdetail.instyp)               /* ประกันแถม/ไม่แถม*/ 
                        brstat.tlt.old_eng      =   TRIM(wdetail.comtyp)               /* พรบ . แถม/ไม่แถม */
                        brstat.tlt.gendat       =   nv_comdat                          /*วันที่เริ่มคุ้มครอง  */  
                        brstat.tlt.expodat      =   nv_expdat                          /*วันที่สิ้นสุดคุ้มครอง*/  
                        brstat.tlt.rec_name     =   trim(wdetail.pol_title)            /*คำนำหน้าชื่อผู้เอาประกันภัย */          
                        brstat.tlt.ins_name     =   trim(wdetail.pol_fname)            /*ชื่อผู้เอาประกันภัย */           
                        brstat.tlt.ins_addr5    =   "IC:" + trim(wdetail.icno) +       /*IDCARD              */   
                                                    " BD:" + TRIM(wdetail.bdate) +     /*วันเกิด */
                                                    " BE:" + TRIM(wdetail.expbdate) +  /*วันที่บัตรหมด */
                                                    " TE:" + TRIM(wdetail.phone)       /* เบอร์โทร */
                        brstat.tlt.recac        =   TRIM(wdetail.occup)                /* อาชีพ */ 
                        brstat.tlt.nor_usr_tlt  =   TRIM(wdetail.name2)                /* ชื่อกรรมการ */
                        brstat.tlt.ins_addr1    =   trim(wdetail.pol_addr1)            /*ที่อยู่ลูกค้า */          
                        brstat.tlt.ins_addr2    =   trim(wdetail.pol_addr2)                                                         
                        brstat.tlt.ins_addr3    =   trim(wdetail.pol_addr3)                                                         
                        brstat.tlt.ins_addr4    =   trim(wdetail.pol_addr4)  + " " + trim(wdetail.pol_addr5)       
                        brstat.tlt.endno        =   TRIM(wdetail.drivno)               /* ระบุผู้ขับขี่ */
                        brstat.tlt.dri_name1    =   TRIM(wdetail.drivname1) +          
                                                    " ID1:" + TRIM(wdetail.drivid1)    /* ผุ้ขับขี่ + ใบขับขี่ 1 */                            
                        brstat.tlt.dri_no1      =   TRIM(wdetail.drivdate1)            /* วันเกิด 1 */
                        brstat.tlt.rec_addr1    =   TRIM(wdetail.drivgen1)  +          
                                                    " OC1:" + TRIM(wdetail.drivocc1)   /* เพศ + อาชีพ 1 */
                        brstat.tlt.dri_name2    =   TRIM(wdetail.drivname2) +          
                                                    " ID2:" + TRIM(wdetail.drivid2)    /* ผุ้ขับขี่ + ใบขับขี่ 2 */                              
                        brstat.tlt.dri_no2      =   TRIM(wdetail.drivdate2)            /* วันเกิด 2 */
                        brstat.tlt.rec_addr2    =   TRIM(wdetail.drivgen2)  +          
                                                    " OC2:" + TRIM(wdetail.drivocc2)   /* เพศ + อาชีพ 2 */
                        brstat.tlt.brand        =   trim(wdetail.brand)               /*ยี่ห้อ      */          
                        brstat.tlt.model        =   trim(wdetail.Brand_Model)         /*รุ่น        */
                        brstat.tlt.eng_no       =   trim(wdetail.engine)              /*เลขเครื่อง  */          
                        brstat.tlt.cha_no       =   trim(wdetail.chassis)             /*เลขถัง      */ 
                        brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)               /*ขนาดเครื่อง */  
                        brstat.tlt.lince2       =   trim(wdetail.yrmanu)              /*ปี          */ 
                        brstat.tlt.lince1       =   trim(wdetail.RegisNo)             /*เลขทะเบียน */          
                        brstat.tlt.lince3       =   trim(wdetail.RegisProv)           /*จังหวัด    */ 
                        brstat.tlt.stat         =   trim(wdetail.garage)              /*สถานที่ซ่อม */ 
                        brstat.tlt.nor_coamt    =   nv_insamt3                        /*ทุนประกัน   */     
                        brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)             /*เบี้ยสุทธิ*/              
                        brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)           /*เบี้ยรวม กธ.  */ 
                        brstat.tlt.rec_addr4    =   IF INDEX(wdetail.comp_prm,"ไม่เอา") = 0 THEN string(DECI(wdetail.comp_prm))  ELSE "0"  /*เบี้ยรวมพรบ. */     
                        brstat.tlt.comp_grprm   =   DECI(Wdetail.comp_prmtotal)       /*เบี้ยรวม กธ. + พรบ. */  
                        brstat.tlt.comp_sck     =   TRIM(wdetail.stk)                 /* สติ๊กเกอร์ */  
                        brstat.tlt.rec_addr5    =   TRIM(Wdetail.taxname)              /*ออกใบเสร็จในนาม */ 
                        brstat.tlt.safe1        =   TRIM(wdetail.ben_name)            /*ผู้รับผลประโยชน์   */ 
                        /*brstat.tlt.filler2      =  trim(wdetail.remark)    A62-0445 */     /*หมายเหตุ    */ 
                        brstat.tlt.filler2      =   trim(wdetail.appno) + "/" + trim(wdetail.remark)   /*หมายเหตุ    */  /*A62-0445*/   
                        brstat.tlt.filler1      =   TRIM(wdetail.prevpol)               /*เบอร์ต่ออายุ*/         
                        brstat.tlt.rec_addr3    =   TRIM(wdetail.inspect)               /*ตรวจสภาพ*/

                        brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"  /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */      
                        /*brstat.tlt.safe3        =   IF index(wdetail.CovTyp,"1") <> 0 AND INDEX(wdetail.garage,"อู่")  <> 0 THEN "G"
                                                    ELSE IF index(wdetail.CovTyp,"1") <> 0 AND INDEX(wdetail.garage,"ห้าง")  <> 0 THEN "F" 
                                                    ELSE IF index(wdetail.CovTyp,"+") <> 0  THEN "Z"  
                                                    ELSE "G" */ /*A64-0150*/                        /*pack + class70 */
                        brstat.tlt.safe3        =   "T"  /*A64-0150*/
                        brstat.tlt.safe3        =   brstat.tlt.safe3 + wdetail.n_class70   /*pack + class70 */ 
                        brstat.tlt.genusr       =   "AMANAH"                                                     
                        brstat.tlt.usrid        =   USERID(LDBNAME(1))                  /*User Load Data */                      
                        brstat.tlt.imp          =   "IM"                                /*Import Data*/                          
                        brstat.tlt.releas       =   "No"                                      
                        brstat.tlt.comp_sub     =   TRIM(wdetail.producer)               
                      /*brstat.tlt.comp_noti_ins =  "B3W0100" ---- Comment By Tontawan S. A66-0139 10/08/2023 --*/        
                        brstat.tlt.comp_noti_ins =  "B300316" /*------ Add By Tontawan S. A66-0139 10/08/2023 --*/
                        brstat.tlt.nor_noti_ins =   "" /*TRIM(trim(wdetail.safe_no))  */       /*เบอร์ใหม่ */            
                        brstat.tlt.comp_pol     =   "" /*trim(wdetail.compno)         */       /*เบอร์ พรบ.  */  
                        brstat.tlt.dat_ins_noti =   ?                                   /*วันที่ออกงาน */
                        brstat.tlt.lotno        =   IF index(wdetail.CovTyp,"1") <> 0 THEN TRIM(fi_camp) 
                                                    ELSE IF INDEX(wdetail.covtyp,"2+") <> 0 THEN TRIM(fi_camp2) 
                                                    ELSE IF INDEX(wdetail.covtyp,"3+") <> 0 THEN TRIM(fi_camp3)
                                                    ELSE ""               /*แคมเปญ*/
                        /* A62-0445 */
                        brstat.tlt.gentim       =  ""              /*ผลตรวจสภาพ */
                        brstat.tlt.expotim      =  nv_susupect .   /* suspect */
                        IF brstat.tlt.expotim = "" AND (brstat.tlt.old_cha ="Usedcar" OR brstat.tlt.old_cha = "usecar" ) THEN DO:
                           IF INDEX(brstat.tlt.comp_usr_tlt,"1") <> 0  THEN  RUN  PD_INSPEC.
                           /*IF INDEX(brstat.tlt.comp_usr_tlt,"2+") <> 0 AND brstat.tlt.nor_coamt > 350000 THEN  RUN  PD_INSPEC.*//*A64-0150*/
                           IF INDEX(brstat.tlt.comp_usr_tlt,"2+") <> 0 AND brstat.tlt.nor_coamt >= 350000 THEN  RUN  PD_INSPEC.  /*A64-0150*/
                        END.
                         /* end A62-0445 */

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt2-bp C-Win 
PROCEDURE proc_create_tlt2-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN                                   
          brstat.tlt.entdat       =   TODAY                             /* วันที่โหลด */                          
          brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")           /* เวลาโหลด   */                          
          brstat.tlt.trndat       =   fi_loaddat                        /* วันที่จากหน้าจอ*/
          brstat.tlt.datesent     =   nv_accdat                         /* วันที่ไฟล์แจ้งงาน */
          brstat.tlt.trntim       =   TRIM(wdetail.not_time)            /* เวลาแจ้งงาน*/
          brstat.tlt.exp          =   "M"                               /*สาขา                 */           
          brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)             /*เลขที่รับแจ้ง        */           
          brstat.tlt.safe2        =   trim(wdetail.Account_no)          /*เลขที่สัญญา          */           
          brstat.tlt.rec_name     =   trim(wdetail.pol_title)           /*คำนำหน้าชื่อผู้เอาประกันภัย */          
          brstat.tlt.ins_name     =   trim(wdetail.pol_fname)           /*ชื่อผู้เอาประกันภัย */           
          brstat.tlt.ins_addr5    =   trim(wdetail.icno)                /*IDCARD              */           
          brstat.tlt.stat         =   trim(wdetail.garage)              /*สถานที่ซ่อม         */           
          brstat.tlt.colorcod     =   TRIM(wdetail.n_color)             /*สีรถ            */           
          brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"  /* ประเภทงาน N = งานใหม่ R = ต่ออายุ */   
          brstat.tlt.brand        =   trim(wdetail.brand)               /*ยี่ห้อ      */          
          brstat.tlt.model        =   trim(wdetail.Brand_Model)         /*รุ่น        */          
          brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)               /*ขนาดเครื่อง */          
          brstat.tlt.lince2       =   trim(wdetail.yrmanu)              /*ปี          */          
          brstat.tlt.eng_no       =   trim(wdetail.engine)              /*เลขเครื่อง  */          
          brstat.tlt.cha_no       =   trim(wdetail.chassis)             /*เลขถัง      */          
          brstat.tlt.old_cha      =   TRIM(wdetail.accsor) +            /*อุปกรณ์ตกแต่ง */ 
                                      " PRICE:" +  TRIM(wdetail.accsor_price)   /*ราคาอุปกรณ์ตกแต่ง */ 
          brstat.tlt.comp_usr_tlt =   trim(wdetail.CovTyp)            /*ประเภทประกัน    */
          brstat.tlt.lince1       =   trim(wdetail.RegisNo)             /*เลขทะเบียน */          
          brstat.tlt.lince3       =   trim(wdetail.RegisProv)           /*จังหวัด    */          
          brstat.tlt.safe3        =   ""                                /*pack + class70 */  
          brstat.tlt.expousr      =   trim(wdetail.instyp)              /* ประกันแถม/ไม่แถม*/  
          brstat.tlt.old_eng      =   TRIM(wdetail.comtyp)              /* พรบ . แถม/ไม่แถม */
          brstat.tlt.nor_coamt    =   nv_insamt3                        /*ทุนประกัน   */          
          brstat.tlt.nor_usr_tlt  =   "TAX:" + TRIM(wdetail.Taxno) +    /*เลขที่ผู้เสียภาษี */ 
                                      " ID:"  + TRIM(wdetail.saleid) +  /*เลขทะเบียนการค้า*/
                                      " BR:"  + TRIM(wdetail.branch)    
          brstat.tlt.gendat       =   nv_comdat                         /*วันที่เริ่มคุ้มครอง  */          
          brstat.tlt.expodat      =   nv_expdat                         /*วันที่สิ้นสุดคุ้มครอง*/          
          brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)             /*เบี้ยสุทธิ*/              
          brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)           /*เบี้ยรวม  */  
          brstat.tlt.safe1        =   TRIM(wdetail.ben_name) + " Delear:" + trim(wdetail.DealerName) /*ดีลเลอร์    */ 
          brstat.tlt.nor_usr_ins  =   trim(wdetail.CMRName)               /*ผู้แจ้ง           */          
          brstat.tlt.comp_sck     =   ""                                  
          /*brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
          brstat.tlt.nor_effdat   = nv_expdat72                           /*วันที่สิ้นสุดคุ้มครองพรบ   */ */
          brstat.tlt.rec_addr4    =   string(DECI(wdetail.comp_prm))      /*เบี้ยสุทธิพรบ. */ 
          brstat.tlt.comp_grprm   =   DECI(Wdetail.comp_prmtotal)         /*เบี้ยรวมพรบ. */ 
          brstat.tlt.filler2      =   trim(wdetail.remark)                /*หมายเหตุ    */        
          brstat.tlt.ins_addr1    =   trim(wdetail.addr1)                 /*ที่อยู่ลูกค้า */          
          brstat.tlt.ins_addr2    =   trim(wdetail.addr2)                        
          brstat.tlt.ins_addr3    =   trim(wdetail.addr3)                        
          brstat.tlt.ins_addr4    =   trim(wdetail.addr4)                 
          brstat.tlt.rec_addr3    =   TRIM(wdetail.inspect)               /*ตรวจสภาพ*/
          brstat.tlt.genusr       =   "ORICO"                                                     
          brstat.tlt.usrid        =   USERID(LDBNAME(1))                  /*User Load Data */                      
          brstat.tlt.imp          =   "IM"                                /*Import Data*/                          
          brstat.tlt.releas       =   "No"                                                         
          brstat.tlt.recac        =   ""                                   /* อาชีพ */                                                                    
          brstat.tlt.comp_sub     =   IF rs_type = 1 THEN "A0M0130" ELSE "A0M0129"               
          brstat.tlt.comp_noti_ins =  "B300303"                 
          brstat.tlt.rec_addr1     =  IF INDEX(wdetail.taxname,"โอริโค่") <> 0 THEN "MC38462" ELSE "" /* vat code */
          brstat.tlt.rec_addr2    =   trim(wdetail.taxname)               /* Recepit name */
          brstat.tlt.rec_addr5    =   TRIM(Wdetail.pol_addr1)             /*ที่อยู่ออกใบเสร็จ */ 
          brstat.tlt.dri_name1    =   TRIM(wdetail.drivname1) + " ID1:" + TRIM(wdetail.drivid1)                             
          brstat.tlt.dri_no1      =   TRIM(wdetail.drivdate1)                             
          brstat.tlt.dri_name2    =   TRIM(wdetail.drivname2) + " ID2:" + TRIM(wdetail.drivid2)                            
          brstat.tlt.dri_no2      =   TRIM(wdetail.drivdate2)
          brstat.tlt.filler1      =   TRIM(wdetail.prevpol)               /*เบอร์ต่ออายุ*/
          brstat.tlt.nor_noti_ins =   TRIM(trim(wdetail.safe_no))         /*เบอร์ใหม่ */            
          brstat.tlt.comp_pol     =   trim(wdetail.compno)                /*เบอร์ พรบ.  */  
          brstat.tlt.dat_ins_noti =   ?                                   /*วันที่ออกงาน */
           brstat.tlt.lotno        =  IF index(wdetail.CovTyp,"1") <> 0 THEN TRIM(fi_camp) 
                                      ELSE IF INDEX(wdetail.covtyp,"2+") <> 0 THEN TRIM(fi_camp2) 
                                      ELSE IF INDEX(wdetail.covtyp,"3+") <> 0 THEN TRIM(fi_camp3)
                                      ELSE "".             /*แคมเปญ*/
END.                      

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchar C-Win 
PROCEDURE proc_cutchar :
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchassic C-Win 
PROCEDURE proc_cutchassic :
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
IF wdetail.chassis <> "" THEN DO:
    nv_c = wdetail.chassis.
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
        wdetail.chassis = nv_c .
    IF trim(wdetail.chassis) <> "" THEN DO:  
         FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail.chassis)) AND 
                                                          sicuw.uwm301.tariff = "X" NO-LOCK  NO-ERROR NO-WAIT.
              IF AVAIL sicuw.uwm301 THEN DO:
                  ASSIGN wdetail.prevpol   = sicuw.uwm301.policy .
              END.
     END.
    RELEASE sicuw.uwm301.
END.

IF wdetail.engine <> ""  THEN DO:
    nv_c = wdetail.engine.
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
        wdetail.engine = nv_c .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpol C-Win 
PROCEDURE proc_cutpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
IF wdetail.safe_no <> ""  THEN DO:  /* 70*/
    nv_c = wdetail.safe_no.
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
        wdetail.safe_no = nv_c .
END.

IF wdetail.compno <> ""  THEN DO:  /*72*/
    nv_c = wdetail.compno.
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
        wdetail.compno = nv_c .

END.*/



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
      /* wtlt.Notify_no   =   tlt.nor_noti_tlt
       wtlt.branch      =   tlt.exp     */
       wtlt.Account_no  =   tlt.safe2   
       wtlt.prev_pol    =   tlt.filler1 
       wtlt.name_insur  =   tlt.rec_name + " " + tlt.ins_name
       wtlt.comdat      =   IF tlt.gendat       <> ? THEN string(tlt.gendat,"99/99/9999")       ELSE ""    
       wtlt.expdat      =   IF tlt.expodat      <> ? THEN string(tlt.expodat,"99/99/9999")      ELSE ""     
      /* wtlt.comdat72    =   IF tlt.comp_effdat  <> ? THEN string(tlt.comp_effdat,"99/99/9999")  ELSE ""
       wtlt.expdat72    =   IF tlt.nor_effdat   <> ? THEN string(Tlt.nor_effdat,"99/99/9999")   ELSE ""  */
       wtlt.licence     =   tlt.lince1 
       wtlt.province    =   tlt.lince3 
       wtlt.ins_amt     =   string(tlt.nor_coamt) 
       wtlt.prem1       =   string(tlt.nor_grprm) 
       wtlt.comp_prm    =   tlt.rec_addr4
       wtlt.gross_prm   =   STRING(tlt.comp_grprm)
       wtlt.compno      =   tlt.comp_pol  
       wtlt.not_date    =   STRING(tlt.datesent)   
       wtlt.not_office  =   tlt.nor_noti_tlt
       wtlt.not_name    =   tlt.nor_usr_ins
       wtlt.brand       =   tlt.brand      
       wtlt.Brand_Model =   tlt.model      
       wtlt.yrmanu      =   tlt.lince2   
       wtlt.weight      =   STRING(tlt.cc_weight)  
       wtlt.engine      =   tlt.eng_no    
       wtlt.chassis     =   tlt.cha_no 
       wtlt.camp        =   tlt.genusr.
END.
OPEN QUERY br_imptxt FOR EACH wtlt NO-LOCK.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

