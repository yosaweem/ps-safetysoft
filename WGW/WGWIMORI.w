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
modify by   : Ranu I. A61-0221 date 17/05/2018 เพิ่มคอลัมน์ Family (รุ่นรถ) 
Modify by   : Ranu I. A62-0454 Date 13/10/2019 เพิ่มการนำเข้าข้อมูล พรบ. รายเดี่ยว 
modify by   : Ranu I. A63-0450 date 15/10/2020 แก้ไข format ทะเบียนรถให้ตรงกับกล่องตรวจสภาพ   
modify by   : Kridtiya i. A63-00472 01/01/2021 แก้ไข producer/agentcode 
Modify by  : Ranu I. A64-0244 แก้ไข producer code พรบ. 
modify by  : Kridtiya i. A66-0107 Date.26/05/2023 เก็บข้อมูลความเสียหายแยกออกมา
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
    FIELD tax           AS CHAR FORMAT "x(10)"  INIT ""  /* A62-0454*/
    FIELD vat           AS CHAR FORMAT "x(10)"  INIT ""  /* A62-0454*/
    FIELD carused       AS CHAR FORMAT "x(50)"  INIT ""  /* A62-0454*/
    FIELD docno         AS CHAR FORMAT "x(10)"  INIT "" . /*A62-0454*/
DEFINE NEW SHARED WORKFILE wtlt NO-UNDO
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
DEF VAR nn_remark1  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nn_remark2  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nn_remark3  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nv_len      AS INTE INIT 0.    /*A56-0399*/
/* A62-0219*/
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
def  var nv_extref       as char.
/* add by A62-0445  */
DEF VAR nv_ispstatus AS CHAR.
DEF VAR chSession       AS COM-HANDLE.
DEF VAR chWorkSpace     AS COM-HANDLE.
DEF VAR chName          AS COM-HANDLE.
DEF VAR chDatabase      AS COM-HANDLE.
DEF VAR chView          AS COM-HANDLE.
DEF VAR chViewNavigator AS COM-HANDLE.
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
DEF VAR n_list      AS INT init 0.
DEF VAR n_count     AS INT init 0.

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
&Scoped-define FIELDS-IN-QUERY-br_imptxt wtlt.trndat wtlt.Notify_no wtlt.branch wtlt.Account_no wtlt.prev_pol wtlt.name_insur wtlt.comdat wtlt.expdat wtlt.comdat72 wtlt.expdat72 wtlt.licence wtlt.province wtlt.ins_amt wtlt.prem1 wtlt.comp_prm wtlt.gross_prm wtlt.compno wtlt.not_date wtlt.not_office wtlt.not_name wtlt.brand wtlt.Brand_Model wtlt.yrmanu wtlt.weight wtlt.engine wtlt.chassis   
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
"งานต่ออายุ", 2,
"พรบ. รายเดี่ยว", 3
     SIZE 55.5 BY .95
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
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128 BY 15.48
         BGCOLOR 19 FGCOLOR 2 FONT 4 ROW-HEIGHT-CHARS .71 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_imptxt AT ROW 9.1 COL 3.17
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
     "2.2 :" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 3.62 COL 56.17 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Day : 26/05/2023" VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 1.48 COL 111 WIDGET-ID 12
     "           กรุณาป้อนชื่อไฟล์นำเข้า :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 4.62 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "3.2 :" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 3.62 COL 76.67 WIDGET-ID 10
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " ข้อมูลแจ้งประกันนำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 5.71 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "  รายละเอียดข้อมูล" VIEW-AS TEXT
          SIZE 128.5 BY .81 AT ROW 8.29 COL 2.83
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
     RECT-1 AT ROW 1 COL 1
     RECT-79 AT ROW 5 COL 98
     RECT-80 AT ROW 5 COL 109.83
     RECT-380 AT ROW 1.19 COL 2.83
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
         WIDTH              = 132
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
   /* Run  Import_file. */ /*A62-0454 */
    IF rs_type <> 3 THEN Run Import_file.  /*A62-0454 */
    ELSE  Run  Import_comp. /* พรบ.*/ /*create by A62-0454 */
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
        ASSIGN fi_camp  = "C60/00043"
               fi_camp2 = "C60/00401"
               fi_camp3 = "C60/00322".
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
  
  gv_prgid = "wgwimori".
  gv_prog  = "Hold Text File Orico".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */
 
  Hide Frame  fr_gen  .
  ASSIGN  
      fi_loaddat  =  today
      fi_compa    = "ORICO"
      fi_camp  = "C60/00043"
      fi_camp2 = "C60/00401"
      fi_camp3 = "C60/00322"
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_comp C-Win 
PROCEDURE import_comp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A62-0454        
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"         
            wdetail.n_no                       /*No                     */ 
            wdetail.safe_no                    /*เลขที่กรมธรรม์         */ 
            wdetail.sckno                      /*เลขเครื่องหมาย         */ 
            wdetail.name_insur                 /*ชื่อผู้เอาประกัน       */ 
            wdetail.CustAddress                /*ที่อยู่                */ 
            wdetail.comdat                     /*วันเริ่มคุ้มครอง/เวลา  */ 
            wdetail.expdat                     /*วันสิ้นสุด             */ 
            wdetail.n_class                    /*รหัส                   */ 
            wdetail.Brand_Model                /*รุ่นรถ                 */ 
            wdetail.RegisNo                    /*ทะเบียนรถ              */ 
            wdetail.chassis                    /*เลขตัวถัง              */ 
            wdetail.comtyp                     /*ประเภท                 */ 
            wdetail.CC                         /*ขนาดเครื่องยนต์        */ 
            wdetail.engine                     /*เลขเครื่องยนต์         */ 
            wdetail.yrmanu                     /*ปีจดทะเบียน            */ 
            wdetail.comp_prm                   /*เบี้ยสุทธิ             */ 
            wdetail.tax                        /*อากร                   */ 
            wdetail.vat                        /*ภาษี                   */ 
            wdetail.comp_prmtotal              /*เบี้ยรวมภาษีอากร       */ 
            wdetail.carused                    /*การใช้รถ               */ 
            wdetail.RegisDate                  /*วันออกกรมธรรม์         */ 
            wdetail.account_no                 /*เลขที่สัญญา            */  
            wdetail.icno        .              /*ID Card                */ 
    IF INDEX(wdetail.n_no,"No")   <> 0 THEN  DELETE wdetail.
    ELSE IF  wdetail.n_no         = "" THEN  DELETE wdetail.
END.  /* repeat  */
ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 
Run proc_Create_comp.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_file C-Win 
PROCEDURE Import_file :
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
            wdetail.n_no                        /*No.                                 */    
            wdetail.Remark                      /*Marketing                           */    
            wdetail.Account_no                  /*Agreement No.                       */    
            wdetail.RegisDate                   /*วันที่รับแจ้ง                       */ 
            wdetail.CovTyp                      /*ประเภทประกัน                        */
            wdetail.garage                      /*Type of Garage                      */
            wdetail.prevpol                     /*กรมธรรม์ เลขที่                     */    
            wdetail.compno                      /*พรบ.เลขที่                          */    
            wdetail.safe_no                     /*เลขที่รับแจ้ง                       */    
            wdetail.CMRName                     /*ผู้รับแจ้ง                          */    
            wdetail.not_time                    /*เวลาแจ้งงาน                         */    
            wdetail.name_insur                  /*ชื่อผู้เอาประกันภัย                 */    
            wdetail.icno                        /*ID. Card No.                        */    
            wdetail.saleid                      /*เลขทะเบียนการค้า(ภพ.20)             */    
            wdetail.taxname                     /*ออกใบเสร็จ/ใบกำกับภาษีในนาม         */    
            wdetail.taxno                       /*เลขประจำตัวผู้เสียภาษี13หลัก        */    
            wdetail.branch                      /*สาขา                                */    
            wdetail.pol_addr1                   /*ที่อยู่ในการออกใบเสร็จ/ใบกำกับภาษี  */    
            wdetail.CustAddress                 /*ที่อยู่ในการจัดส่งเอกสาร            */    
            wdetail.SI                          /*ทุนประกัน                           */    
            wdetail.netprem                     /*เบี้ยประกันสุทธิ                    */    
            wdetail.totalprem                   /*เบี้ยประกันรวม                      */    
            wdetail.comp_prm                    /*เบี้ยพรบ สุทธิ                      */    
            wdetail.comp_prmtotal               /*เบี้ยพรบ รวม                        */
            wdetail.brand                       /*ยี่ห้อรถ                            */   /*A61-0221 */               
            wdetail.Brand_Model                 /*รุ่น                                */ 
            wdetail.yrmanu                      /*ปี                                  */    
            wdetail.n_color                     /*สี                                  */    
            wdetail.RegisNo                     /*เลขทะเบียน                          */    
            wdetail.RegisProv                   /*จังหวัด                             */    
            wdetail.CC                          /*ขนาดเครื่องยนต์                     */    
            wdetail.engine                      /*เลขเครื่องยนต์                      */    
            wdetail.chassis                     /*เลขตัวถัง                           */    
            wdetail.accsor                      /*อุปกรณ์ตกแต่งเพิ่มเติม              */    
            wdetail.accsor_price                /*อุปกรณ์ตกแต่งเพิ่มเติมราคา          */    
            wdetail.InsTyp                      /*แถม/ไม่แถม ประกันภัย                */    
            wdetail.comtyp                      /*แถม/ไม่แถม พรบ.                     */        
            wdetail.DealerName                  /*ชื่อ Dealer                         */    
            wdetail.drivname1                   /*ชื่อ-นามสกุล ผู้ขับขี่1             */    
            wdetail.drivdate1                   /*วัน/เดือน/ปี เกิด ผู้ขับขี่1        */    
            wdetail.drivid1                     /*เลขที่ใบขับขี่ผู้ขับขี่1            */    
            wdetail.drivname2                   /*ชื่อ-นามสกุล ผู้ขับขี่2             */    
            wdetail.drivdate2                   /*วัน/เดือน/ปี เกิด ผู้ขับขี่2        */    
            wdetail.drivid2                     /*เลขที่ใบขับขี่ ผู้ขับขี่2           */    
            wdetail.comdat                      /*วันที่คุ้มครอง                      */    
            wdetail.expdat                      /*วันสิ้นสุดคุ้มครอง                  */    
            wdetail.ben_name                     /*ผู้รับผลประโยชน์                    */    
            wdetail.n_class .                    /*รหัสรถยนต์                A62-0219 */    
            /*wdetail.pack                       /*Pack                               */    
            wdetail.producer                    /*Producer                            */    
            wdetail.agent                       /*Agent                               */    
            wdetail.branch_saf                  /*Branch                              */    
            wdetail.vatcode                     /*Vat Code                            */    
            wdetail.campaign                    /*Campaign                            */    
            wdetail.inspect.  */                  /*Inspection                          */   
  
    IF INDEX(wdetail.n_no,"No")   <> 0 THEN  DELETE wdetail.
    ELSE IF  wdetail.n_no         = "" THEN  DELETE wdetail.
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
/*FOR EACH  wdetail :
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
            wdetail.Otherins      /* Otherins */ 
            wdetail.campaign .    /* campaign */  /*A60-0263*/

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
Message "Load  Data Complete"  View-as alert-box.  */
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
/*FOR EACH  wdetail :
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
            wdetail.Remark.         /*หมายเหตุ        */ 
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
Message "Load  Data Complete"  View-as alert-box.  */
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

    /*IF index(wdetail.cartype,"ทรัพย์สินใหม่") <> 0  THEN ASSIGN wdetail.producer = "A0M0080".
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
END.*/

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdata C-Win 
PROCEDURE proc_chkdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A62-0454   
------------------------------------------------------------------------------*/
DO:
     /* เช็คเลขที่เอกสาร */
    FIND LAST brstat.tlt USE-INDEX tlt06 WHERE 
              brstat.tlt.cha_no         = trim(wdetail.sckno)     AND   /* stk */
              brstat.tlt.nor_noti_tlt   = trim(wdetail.safe_no)   AND   /* comp no. */
              brstat.tlt.genusr         = trim(wdetail.producer)  NO-WAIT  NO-ERROR .   /* Producer */  
    IF AVAIL brstat.tlt THEN DO:
        IF brstat.tlt.releas = "YES" THEN DO:
            ASSIGN wdetail.remark = "ข้อมูลมีการออกงานไปแล้ว " + trim(brstat.tlt.filler2) .
        END.
        ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0  THEN DO:
            ASSIGN wdetail.remark = "ข้อมูลถูกยกเลิกการใช้งาน " + trim(brstat.tlt.filler2) .
        END.
        ELSE DO:
            ASSIGN wdetail.docno           = trim(brstat.tlt.safe2)
                   brstat.tlt.comp_usr_tlt = "M"
                   brstat.tlt.usrid        = USERID(LDBNAME(1))              /*User Load Data */   
                   brstat.tlt.filler2      = "USED BY:" + trim(wdetail.producer) + "/" + STRING(TODAY,"99/99/9999") .
        END.
    END.
    ELSE IF wdetail.sckno = "" AND TRIM(wdetail.safe_no) <> "" THEN DO:
        FIND LAST brstat.tlt WHERE 
              brstat.tlt.genusr         = trim(wdetail.producer)  AND   /* Producer */  
              brstat.tlt.nor_noti_tlt   = trim(wdetail.safe_no)   NO-WAIT  NO-ERROR .       /* comp no. */
          IF AVAIL brstat.tlt THEN DO:
              IF brstat.tlt.releas = "YES" THEN DO:
                  ASSIGN wdetail.remark = "ข้อมูลมีการออกงานไปแล้ว " + trim(brstat.tlt.filler2) .
              END.
              ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0  THEN DO:
                  ASSIGN wdetail.remark = "ข้อมูลถูกยกเลิกการใช้งาน " + trim(brstat.tlt.filler2) .
              END.
              ELSE DO:
                  ASSIGN wdetail.docno           = trim(brstat.tlt.safe2)
                         wdetail.sckno           = TRIM(brstat.tlt.cha_no)
                         brstat.tlt.comp_usr_tlt = "M"
                         brstat.tlt.usrid        = USERID(LDBNAME(1))              /*User Load Data */   
                         brstat.tlt.filler2      = "USED BY:" + trim(wdetail.producer) + "/" + STRING(TODAY,"99/99/9999") .
              END.
          END.
          ELSE DO:
               ASSIGN wdetail.remark = "ไม่พบข้อมูล " + wdetail.safe_no + "/" + wdetail.sckno + "/" + wdetail.producer  + " ที่พารามิเตอร์ Data Sticker BU3".
          END.
    END.
    ELSE DO:
        ASSIGN wdetail.remark = "ไม่พบข้อมูล " + wdetail.safe_no + "/" + wdetail.sckno + "/" + wdetail.producer  + " ที่พารามิเตอร์ Data Sticker BU3".
    END.

    /* เช็คเบอร์กรมธรรม์เดิม */
    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = TRIM(wdetail.safe_no) NO-LOCK NO-ERROR.
      IF AVAIL sicuw.uwm100 THEN DO:
          ASSIGN wdetail.remark = string(wdetail.safe_no) + " มีกรมธรรม์ในระบบพรีเมียมแล้ว ".
      END.
      ELSE DO:
          FIND LAST sicuw.uwm301 USE-INDEX uwm30103  WHERE
                    sicuw.uwm301.trareg             = trim(wdetail.chassis)  AND 
                    substr(sicuw.uwm301.policy,3,2) = "72"     NO-LOCK  NO-ERROR .
            IF AVAIL sicuw.uwm301  THEN DO:
                 FIND LAST sicuw.uwm100 WHERE sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK NO-ERROR.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        IF sicuw.uwm100.expdat <> DATE(wdetail.comdat) THEN DO:
                            ASSIGN wdetail.prevpol = TRIM(sicuw.uwm100.policy)
                                   wdetail.remark  = trim(wdetail.remark + " " + "วันที่เริ่มต้นจากไฟล์และวันที่สิ้นสุดความคุ้มครองของ กธ. เดิมไม่ตรงกัน").
                        END.
                        ELSE ASSIGN wdetail.prevpol = TRIM(sicuw.uwm100.policy) .
                    END.
            END.
            ELSE DO:
                FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
                    sicuw.uwm301.cha_no             = trim(wdetail.chassis)  AND 
                    substr(sicuw.uwm301.policy,3,2) = "72"     NO-LOCK  NO-ERROR .
                IF AVAIL sicuw.uwm301  THEN DO:
                    FIND LAST sicuw.uwm100 WHERE sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK NO-ERROR.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        IF sicuw.uwm100.expdat <> DATE(wdetail.comdat) THEN DO:
                            ASSIGN wdetail.prevpol = TRIM(sicuw.uwm100.policy)
                                   wdetail.remark  = trim(wdetail.remark + " " + "วันที่เริ่มต้นจากไฟล์และวันที่สิ้นสุดความคุ้มครองของ กธ. เดิมไม่ตรงกัน").
                        END.
                        ELSE ASSIGN wdetail.prevpol = TRIM(sicuw.uwm100.policy) .
                    END.
                
                END.
                ELSE ASSIGN wdetail.prevpol = "" .
            END.
      END.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_comp C-Win 
PROCEDURE proc_create_comp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A62-0454      
------------------------------------------------------------------------------*/
DEF VAR n AS INT INIT 0.
LOOP_wdetail:
FOR EACH wdetail .
    IF trim(wdetail.safe_no) = ""  THEN DELETE wdetail.  
    ELSE DO:
    ASSIGN  wdetail.safe_no = trim(wdetail.safe_no) 
            nv_policy    = ""     nv_oldpol    = ""
            nv_comdat    = ?      nv_expdat    = ?  
            nv_comdat72  = ?      nv_expdat72  = ?      nv_accdat  =  ?
            nv_comchr    = ""     nv_addr      = ""     nv_name1   =  ""     
            nv_ntitle    = ""     nv_titleno   = 0      nv_policy  =  ""
            nv_dd        = 0      nv_mm        = 0      nv_yy      =  0
            nv_cpamt1    = 0      nv_cpamt2    = 0      nv_cpamt3  =  0
            nv_coamt1    = 0      nv_coamt2    = 0      nv_coamt3  =  0         
            nv_insamt1   = 0      nv_insamt2   = 0      nv_insamt3 =  0
            nv_premt1    = 0      nv_premt2    = 0      nv_premt3  =  0
            nv_newpol    = ""     nv_reccnt    = nv_reccnt + 1
            wdetail.engine = trim(REPLACE(wdetail.engine,"*","")).
        
        IF wdetail.safe_no = "" THEN 
            MESSAGE "เบอร์กรมธรรม์เป็นค่าว่าง..." VIEW-AS ALERT-BOX.
        ELSE DO:
            ASSIGN /*wdetail.producer = "A0M0129"*/  /*A64-0244*/
                   wdetail.producer = "B3MLOAL101"   /*A64-0244*/
                   wdetail.sckno    = TRIM(wdetail.sckno)
                   wdetail.sckno    = IF wdetail.sckno <> "" AND LENGTH(wdetail.sckno) < 13 THEN "0" + wdetail.sckno ELSE wdetail.sckno  .
            RUN proc_chkdata.
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
           
            /*------- check Branch -------------*/
            wdetail.safe_no = trim(wdetail.safe_no) .
            IF trim(wdetail.safe_no) <> ""  AND LENGTH(wdetail.safe_no) = 12 THEN DO:
               wdetail.branch = SUBSTR(wdetail.safe_no,1,1) .
               IF wdetail.branch = "D" THEN wdetail.branch_saf = trim(SUBSTR(wdetail.safe_no,2,1)) .
               ELSE wdetail.branch_saf = trim(SUBSTR(wdetail.safe_no,1,2)) .
            END.
            /*--- ยี่ห้อ รุ่นรถ ----*/
            wdetail.brand_model = TRIM(wdetail.brand_model) .
            IF INDEX(wdetail.brand_model," ") <> 0 THEN DO:
                ASSIGN wdetail.brand       = trim(SUBSTR(wdetail.brand_model,1,INDEX(wdetail.brand_model," ") - 1 ))
                       wdetail.brand_model = trim(REPLACE(wdetail.brand_mode,wdetail.brand,"")).
            END.
            ELSE DO:
                ASSIGN wdetail.brand       = TRIM(wdetail.brand_model)
                       wdetail.brand_model = "" .
            END.
            wdetail.n_class = TRIM(wdetail.n_class).
            IF index(wdetail.n_class,".") <> 0 THEN DO:
                ASSIGN wdetail.n_class = trim(REPLACE(wdetail.n_class,".",""))
                       wdetail.n_class = IF LENGTH(wdetail.n_class) < 3 THEN wdetail.n_class + "0" ELSE wdetail.n_class
                       wdetail.n_class = IF TRIM(wdetail.n_class) = "110" THEN wdetail.n_class ELSE TRIM(wdetail.n_class + "A") .
            END.
            /*----- เช็คทะเบียน -----*/
            wdetail.RegisNo = TRIM(wdetail.RegisNo) .
            IF INDEX(wdetail.RegisNo," ") <> 0 THEN DO:
                ASSIGN wdetail.RegisProv = SUBSTR(wdetail.Regisno,R-INDEX(wdetail.Regisno," ") + 1 ).
                IF TRIM(wdetail.RegisProv) <> "" THEN DO:
                    FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                        brstat.insure.compno = "999" AND 
                        brstat.insure.FName  = TRIM(wdetail.RegisProv) NO-LOCK NO-WAIT NO-ERROR.
                    IF AVAIL brstat.insure THEN DO:  
                        ASSIGN wdetail.RegisProv = brstat.Insure.LName
                               wdetail.RegisNo   = trim(REPLACE(wdetail.RegisNo,brstat.insure.FName,"")).
                    END.
                    ELSE DO:
                        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                        brstat.insure.compno = "999" AND 
                        brstat.Insure.LName  = TRIM(wdetail.RegisProv) NO-LOCK NO-WAIT NO-ERROR.
                        IF AVAIL brstat.insure THEN DO:  
                            ASSIGN wdetail.RegisProv = brstat.Insure.LName
                                   wdetail.RegisNo   = SUBSTR(wdetail.RegisNo,1,R-INDEX(wdetail.RegisNo," ") - 1 ).
                        END.
                        ELSE ASSIGN wdetail.RegisProv = "" .
                    END.
                END. 
            END.
            ELSE ASSIGN wdetail.RegisProv = "" .
            
            /*----------- create Data Comp --------------*/
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                brstat.tlt.cha_no       = trim(wdetail.chassis)   AND
                brstat.tlt.eng_no       = TRIM(wdetail.engine)    AND
                brstat.tlt.genusr       = fi_compa                AND
                brstat.tlt.flag         = "COMP"                   NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:
               CREATE brstat.tlt.
                    nv_completecnt  =  nv_completecnt + 1.
                    ASSIGN                                                 
                        brstat.tlt.entdat       =   TODAY                           /* วันที่โหลด */                          
                        brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")         /* เวลาโหลด   */                          
                        brstat.tlt.trndat       =   fi_loaddat                      /* วันที่จากหน้าจอ*/
                        brstat.tlt.datesent     =   nv_accdat                       /* วันที่ไฟล์แจ้งงาน */
                        brstat.tlt.exp          =   wdetail.branch_saf              /*สาขา                 */   /*A62-0219*/
                        brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)           /*เลขที่รับแจ้ง        */           
                        brstat.tlt.safe2        =   trim(wdetail.Account_no)        /*เลขที่สัญญา          */           
                        brstat.tlt.rec_name     =   trim(wdetail.pol_title)         /*คำนำหน้าชื่อผู้เอาประกันภัย */          
                        brstat.tlt.ins_name     =   trim(wdetail.pol_fname)         /*ชื่อผู้เอาประกันภัย */ 
                        brstat.tlt.ins_addr5    =   trim(wdetail.icno)                /*IDCARD              */  
                        brstat.tlt.flag         =   "COMP"                          /* ประเภทงาน N = งานใหม่ R = ต่ออายุ V72 = พรบ รายเดี่ยว*/   
                        brstat.tlt.brand        =   trim(wdetail.brand)             /*ยี่ห้อ      */          
                        brstat.tlt.model        =   trim(wdetail.Brand_Model)       /*รุ่น        */          
                        brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)             /*ขนาดเครื่อง */          
                        brstat.tlt.lince2       =   trim(wdetail.yrmanu)            /*ปี          */          
                        brstat.tlt.eng_no       =   trim(wdetail.engine)            /*เลขเครื่อง  */          
                        brstat.tlt.cha_no       =   trim(wdetail.chassis)           /*เลขถัง      */  
                        /*brstat.tlt.comp_usr_tlt =   trim(wdetail.carused) */          /*ประเภทประกัน    */
                        brstat.tlt.lince1       =   trim(wdetail.RegisNo)           /*เลขทะเบียน */          
                        brstat.tlt.lince3       =   trim(wdetail.RegisProv)         /*จังหวัด    */  
                        brstat.tlt.safe3        =   trim(wdetail.n_class)           /*pack + class70 */ 
                        brstat.tlt.expousr      =   trim(wdetail.carused)           /* การใช้รถ */ 
                        brstat.tlt.old_eng      =   TRIM(wdetail.comtyp)            /* พรบ . แถม/ไม่แถม */
                        brstat.tlt.gendat       =   nv_comdat                       /*วันที่เริ่มคุ้มครอง  */          
                        brstat.tlt.expodat      =   nv_expdat                       /*วันที่สิ้นสุดคุ้มครอง*/          
                        brstat.tlt.nor_grprm    =   DECI(wdetail.tax)               /* tax */              
                        brstat.tlt.comp_coamt   =   DECI(wdetail.vat)               /* vat  */ 
                        brstat.tlt.rec_addr4    =   string(DECI(wdetail.comp_prm))  /*เบี้ยสุทธิพรบ. */ 
                        brstat.tlt.comp_grprm   =   DECI(Wdetail.comp_prmtotal)     /*เบี้ยรวมพรบ. */ 
                        brstat.tlt.ins_addr1    =   trim(wdetail.addr1)             /*ที่อยู่ลูกค้า */          
                        brstat.tlt.ins_addr2    =   trim(wdetail.addr2)             
                        brstat.tlt.ins_addr3    =   trim(wdetail.addr3)             
                        brstat.tlt.ins_addr4    =   trim(wdetail.addr4)             
                        brstat.tlt.genusr       =   "ORICO"                         
                        brstat.tlt.usrid        =   USERID(LDBNAME(1))              /*User Load Data */                      
                        brstat.tlt.imp          =   "IM"                            /*Import Data*/                          
                        brstat.tlt.releas       =   IF index(wdetail.remark,"มีกรมธรรม์ในระบบพรีเมียมแล้ว") <> 0 THEN "YES" ELSE "No"                            
                        /*brstat.tlt.recac        =   ""        */                      /* อาชีพ */                                                                      
                        /*brstat.tlt.comp_sub     =   "A0M0129"    /* producer code */    */ /*A63-00472*/              
                        brstat.tlt.comp_sub     =   "A0MLOAL101"   /* producer code */       /*A63-00472*/
                        brstat.tlt.comp_noti_ins =  "B3W0100"      /* Agent code */  
                        brstat.tlt.comp_pol     =   trim(wdetail.safe_no)          /*เบอร์ พรบ.  */
                        brstat.tlt.filler1      =   TRIM(wdetail.prevpol)          /*เบอร์ต่ออายุ*/
                        brstat.tlt.dat_ins_noti =   ?                              /*วันที่ออกงาน */
                        brstat.tlt.comp_sck     =   TRIM(wdetail.sckno)            /* เลขที่สติก๊เกอร์ */  
                        brstat.tlt.lotno        =   trim(wdetail.docno)            /*docno */
                        brstat.tlt.filler2      =   trim(wdetail.remark) .         /*หมายเหตุ    */ 
            END.                      
            ELSE DO:                  
                nv_completecnt  =  nv_completecnt + 1.
                RUN proc_Create_comp2.
            END.
            RELEASE brstat.tlt.
        END.
    END.
END.
Run proc_Open_tlt.                           
                            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_comp2 C-Win 
PROCEDURE proc_create_comp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A62-0454      
------------------------------------------------------------------------------*/
DO:
    ASSIGN                         
            brstat.tlt.entdat       =   TODAY                           /* วันที่โหลด */                          
            brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")         /* เวลาโหลด   */                          
            brstat.tlt.trndat       =   fi_loaddat                      /* วันที่จากหน้าจอ*/
            brstat.tlt.datesent     =   nv_accdat                       /* วันที่ไฟล์แจ้งงาน */
            brstat.tlt.exp          =   wdetail.branch_saf              /*สาขา                 */   /*A62-0219*/
            brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)           /*เลขที่รับแจ้ง        */           
            brstat.tlt.safe2        =   trim(wdetail.Account_no)        /*เลขที่สัญญา          */           
            brstat.tlt.rec_name     =   trim(wdetail.pol_title)         /*คำนำหน้าชื่อผู้เอาประกันภัย */          
            brstat.tlt.ins_name     =   trim(wdetail.pol_fname)         /*ชื่อผู้เอาประกันภัย */ 
            brstat.tlt.ins_addr5    =   trim(wdetail.icno)                /*IDCARD              */  
            brstat.tlt.flag         =   "COMP"                          /* ประเภทงาน N = งานใหม่ R = ต่ออายุ V72 = พรบ รายเดี่ยว*/   
            brstat.tlt.brand        =   trim(wdetail.brand)             /*ยี่ห้อ      */          
            brstat.tlt.model        =   trim(wdetail.Brand_Model)       /*รุ่น        */          
            brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)             /*ขนาดเครื่อง */          
            brstat.tlt.lince2       =   trim(wdetail.yrmanu)            /*ปี          */          
            brstat.tlt.eng_no       =   trim(wdetail.engine)            /*เลขเครื่อง  */          
            brstat.tlt.cha_no       =   trim(wdetail.chassis)           /*เลขถัง      */  
            /*brstat.tlt.comp_usr_tlt =   "" /*trim(wdetail.carused)    */ */      /*ประเภทประกัน    */
            brstat.tlt.lince1       =   trim(wdetail.RegisNo)           /*เลขทะเบียน */          
            brstat.tlt.lince3       =   trim(wdetail.RegisProv)         /*จังหวัด    */  
            brstat.tlt.safe3        =   trim(wdetail.n_class)           /*pack + class70 */ 
            brstat.tlt.expousr      =   trim(wdetail.carused)           /* การใช้รถ */ 
            brstat.tlt.old_eng      =   TRIM(wdetail.comtyp)            /* พรบ . แถม/ไม่แถม */
            brstat.tlt.gendat       =   nv_comdat                       /*วันที่เริ่มคุ้มครอง  */          
            brstat.tlt.expodat      =   nv_expdat                       /*วันที่สิ้นสุดคุ้มครอง*/          
            brstat.tlt.nor_grprm    =   DECI(wdetail.tax)               /* tax */              
            brstat.tlt.comp_coamt   =   DECI(wdetail.vat)               /* vat  */ 
            brstat.tlt.rec_addr4    =   string(DECI(wdetail.comp_prm))  /*เบี้ยสุทธิพรบ. */ 
            brstat.tlt.comp_grprm   =   DECI(Wdetail.comp_prmtotal)     /*เบี้ยรวมพรบ. */ 
            brstat.tlt.ins_addr1    =   trim(wdetail.addr1)             /*ที่อยู่ลูกค้า */          
            brstat.tlt.ins_addr2    =   trim(wdetail.addr2)             
            brstat.tlt.ins_addr3    =   trim(wdetail.addr3)             
            brstat.tlt.ins_addr4    =   trim(wdetail.addr4)             
            brstat.tlt.genusr       =   "ORICO"                         
            brstat.tlt.usrid        =   USERID(LDBNAME(1))              /*User Load Data */                      
            brstat.tlt.imp          =   "IM"                            /*Import Data*/                          
            brstat.tlt.releas       =   IF index(wdetail.remark,"มีกรมธรรม์ในระบบพรีเมียมแล้ว") <> 0 THEN "YES" ELSE "No"                              
            /*brstat.tlt.recac        =   ""        */                      /* อาชีพ */                                                                      
            /*brstat.tlt.comp_sub     =   "A0M0129"  */  /* producer code */  /*A64-0244*/
            brstat.tlt.comp_sub     =   "A0MLOAL101"   /* producer code */    /*A64-0244*/
            brstat.tlt.comp_noti_ins =  "B3W0100"      /* Agent code */  
            brstat.tlt.comp_pol     =   trim(wdetail.safe_no)          /*เบอร์ พรบ.  */
            brstat.tlt.filler1      =   TRIM(wdetail.prevpol)          /*เบอร์ต่ออายุ*/
            brstat.tlt.dat_ins_noti =   ?                              /*วันที่ออกงาน */
            brstat.tlt.comp_sck     =   TRIM(wdetail.sckno)            /* เลขที่สติก๊เกอร์ */  
            brstat.tlt.lotno        =   trim(wdetail.docno)            /*docno */
            brstat.tlt.filler2      =   trim(wdetail.remark) .         /*หมายเหตุ    */ 
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
   /*IF  wdetail.Account_no = "" THEN  DELETE wdetail. */ /*a61-0234*/
    /*IF wdetail.account_no = "" AND deci(wdetail.comp_prm) = 0 THEN DELETE wdetail. */ /*a61-0234*/ /*A62-0219*/
    IF trim(wdetail.safe_no) = ""  THEN DELETE wdetail.  /*A62-0219*/
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

           /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- */
            nv_insamt3 = DECIMAL(wdetail.si).   /* by: kridtiya i. A54-0061.. */
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
            /* add by A62-0219 */
            /*------- check Branch -------------*/
            FIND LAST brstat.insure USE-INDEX insure03 WHERE 
                          insure.compno = "ORICO"   AND
                          insure.branch = TRIM(wdetail.branch) NO-LOCK NO-ERROR .
                IF AVAIL insure THEN DO:
                    ASSIGN wdetail.branch_saf = trim(Insure.FName).
                END.
                ELSE DO:
                    wdetail.branch_saf = "" .
                    MESSAGE "ไม่พบสาขา " + TRIM(wdetail.branch) + "ในระบบพารามิเตอร์ของ ORICO " VIEW-AS ALERT-BOX.
                END.
           /*...end A62-0219...*/

            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                brstat.tlt.cha_no       = trim(wdetail.chassis)   AND
                brstat.tlt.eng_no       = TRIM(wdetail.engine)    AND
                brstat.tlt.genusr       = fi_compa                AND 
                brstat.tlt.flag         <> "COMP"   /*A62-0454*/  NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:
               CREATE brstat.tlt.
                    nv_completecnt  =  nv_completecnt + 1.
                    ASSIGN                                                 
                        brstat.tlt.entdat       =   TODAY                             /* วันที่โหลด */                          
                        brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")           /* เวลาโหลด   */                          
                        brstat.tlt.trndat       =   fi_loaddat                        /* วันที่จากหน้าจอ*/
                        brstat.tlt.datesent     =   nv_accdat                         /* วันที่ไฟล์แจ้งงาน */
                        brstat.tlt.trntim       =   TRIM(wdetail.not_time)            /* เวลาแจ้งงาน*/
                        /*brstat.tlt.exp          =   "M"                    */       /*สาขา                 */   /*A62-0219*/
                        brstat.tlt.exp          =   wdetail.branch_saf               /*สาขา                 */   /*A62-0219*/
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
                        /*brstat.tlt.safe3        =   ""                 *//*A62-0219*/ /*pack + class70 */ 
                        brstat.tlt.safe3        =   trim(wdetail.n_class)              /*A62-0219*/          /*pack + class70 */ 
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
                        brstat.tlt.rec_addr3    =   ""                 /*ตรวจสภาพ*/
                        brstat.tlt.genusr       =   "ORICO"                                                     
                        brstat.tlt.usrid        =   USERID(LDBNAME(1))                  /*User Load Data */                      
                        brstat.tlt.imp          =   "IM"                                /*Import Data*/                          
                        brstat.tlt.releas       =   "No"                                                         
                        brstat.tlt.recac        =   ""                                  /* อาชีพ */                                                                      
                        /*brstat.tlt.comp_sub     =   IF rs_type = 1 THEN "A0M0130" ELSE "A0M0129" */   /*A63-00472*/
                        brstat.tlt.comp_sub     =   IF rs_type = 1 THEN "A0MLOAL102" ELSE "A0MLOAL101"  /*A63-00472*/
                        /*brstat.tlt.comp_noti_ins =  "B300303"  */     /*a62-0219*/
                        /*brstat.tlt.comp_noti_ins =  "B3W0100"            /*A62-0219*/*//*comment by Kridtiya i. A66-0107*/
                        brstat.tlt.comp_noti_ins =  "B300316"            /*comment by Kridtiya i. A66-0107*/
                        /*brstat.tlt.rec_addr1    =   IF INDEX(wdetail.taxname,"โอริโค่") <> 0 OR INDEX(wdetail.taxname,"Orico") <> 0 THEN "MC38462" ELSE "" /* vat code */*//*A63-00472*/  
                        brstat.tlt.rec_addr1    =   IF INDEX(wdetail.taxname,"โอริโค่") <> 0 OR INDEX(wdetail.taxname,"Orico") <> 0 THEN "MC45108" ELSE "" /* vat code */    /*A63-00472*/  
                        brstat.tlt.rec_addr2    =   trim(wdetail.taxname)               /* Recepit name */
                        brstat.tlt.rec_addr5    =   TRIM(Wdetail.pol_addr1)             /*ที่อยู่ออกใบเสร็จ */ 
                        brstat.tlt.dri_name1    =   TRIM(wdetail.drivname1) + " ID1:" + TRIM(wdetail.drivid1)                             
                        brstat.tlt.dri_no1      =   TRIM(wdetail.drivdate1)                             
                        brstat.tlt.dri_name2    =   TRIM(wdetail.drivname2) + " ID2:" + TRIM(wdetail.drivid2)                            
                        brstat.tlt.dri_no2      =   TRIM(wdetail.drivdate2)
                        brstat.tlt.filler1      =   TRIM(wdetail.prevpol)               /*เบอร์ต่ออายุ*/
                        /*brstat.tlt.nor_noti_ins =   TRIM(trim(wdetail.safe_no))*/      /*เบอร์ใหม่ */       /*A62-0219*/
                        brstat.tlt.nor_noti_ins =   "" /*IF rs_type = 1 THEN "" ELSE TRIM(wdetail.safe_no)*/ /*เบอร์ใหม่ */       /*A62-0219*/
                        brstat.tlt.comp_pol     =   trim(wdetail.compno)                /*เบอร์ พรบ.  */  
                        brstat.tlt.dat_ins_noti =   ?                                   /*วันที่ออกงาน */
                        brstat.tlt.lotno        =   IF index(wdetail.CovTyp,"1") <> 0 THEN TRIM(fi_camp) 
                                                    ELSE IF INDEX(wdetail.covtyp,"2+") <> 0 THEN TRIM(fi_camp2) 
                                                    ELSE IF INDEX(wdetail.covtyp,"3+") <> 0 THEN TRIM(fi_camp3)
                                                    ELSE "" .             /*แคมเปญ*/
                       IF index(wdetail.CovTyp,"1") <> 0 OR INDEX(wdetail.covtyp,"2+") <> 0 OR INDEX(wdetail.covtyp,"3+") <> 0 THEN RUN proc_insp. /*A62-0219*/
            END.                      
            ELSE DO:                  
                nv_completecnt  =  nv_completecnt + 1.
                RUN proc_Create_tlt2.
            END.
            RELEASE brstat.tlt.
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
           brstat.tlt.trntim       =   TRIM(wdetail.not_time)            /* เวลาแจ้งงาน*/
           /*brstat.tlt.exp          =   "M"                    */       /*สาขา                 */   /*A62-0219*/
           brstat.tlt.exp          =   wdetail.branch_saf               /*สาขา                 */   /*A62-0219*/        
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
           /*brstat.tlt.safe3        =   ""                 */           /*pack + class70 */  /*A62-0219*/          
           brstat.tlt.safe3        =   trim(wdetail.n_class)             /*pack + class70 */  /*A62-0219*/          
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
           brstat.tlt.rec_addr3    =   ""                                   /*ตรวจสภาพ*/
           brstat.tlt.genusr       =   "ORICO"                                                     
           brstat.tlt.usrid        =   USERID(LDBNAME(1))                  /*User Load Data */                      
           brstat.tlt.imp          =   "IM"                                /*Import Data*/                          
           brstat.tlt.releas       =   "No"                                                         
           brstat.tlt.recac        =   ""                                  /* อาชีพ */                                                                      
           /*brstat.tlt.comp_sub     =   IF rs_type = 1 THEN "A0M0130" ELSE "A0M0129" */   /*A63-00472*/
           brstat.tlt.comp_sub     =   IF rs_type = 1 THEN "A0MLOAL102" ELSE "A0MLOAL101"  /*A63-00472*/
           /*brstat.tlt.comp_noti_ins =  "B300303"  */     /*a62-0219*/
           /*brstat.tlt.comp_noti_ins =  "B3W0100"            /*A62-0219*/        comment by Kridtiya i. A66-0107*/
           brstat.tlt.comp_noti_ins =  "B300316"            /*comment by Kridtiya i. A66-0107*/
           /*brstat.tlt.rec_addr1    =   IF INDEX(wdetail.taxname,"โอริโค่") <> 0 OR INDEX(wdetail.taxname,"Orico") <> 0 THEN "MC38462" ELSE "" *//* vat code *//*A63-00472*/ 
           brstat.tlt.rec_addr1    =   IF INDEX(wdetail.taxname,"โอริโค่") <> 0 OR INDEX(wdetail.taxname,"Orico") <> 0 THEN "MC45108" ELSE "" /* vat code *//*A63-00472*/    
           brstat.tlt.rec_addr2    =   trim(wdetail.taxname)               /* Recepit name */
           brstat.tlt.rec_addr5    =   TRIM(Wdetail.pol_addr1)             /*ที่อยู่ออกใบเสร็จ */ 
           brstat.tlt.dri_name1    =   TRIM(wdetail.drivname1) + " ID1:" + TRIM(wdetail.drivid1)                             
           brstat.tlt.dri_no1      =   TRIM(wdetail.drivdate1)                             
           brstat.tlt.dri_name2    =   TRIM(wdetail.drivname2) + " ID2:" + TRIM(wdetail.drivid2)                            
           brstat.tlt.dri_no2      =   TRIM(wdetail.drivdate2)
           brstat.tlt.filler1      =   TRIM(wdetail.prevpol)               /*เบอร์ต่ออายุ*/
           /*brstat.tlt.nor_noti_ins =   TRIM(trim(wdetail.safe_no))*/      /*เบอร์ใหม่ */       /*A62-0219*/
           brstat.tlt.nor_noti_ins =   "" /*IF rs_type = 1 THEN "" ELSE TRIM(wdetail.safe_no)*/    /*เบอร์ใหม่ */       /*A62-0219*/
           brstat.tlt.comp_pol     =   trim(wdetail.compno)                /*เบอร์ พรบ.  */  
           brstat.tlt.dat_ins_noti =   ?                                   /*วันที่ออกงาน */
           brstat.tlt.lotno        =   IF index(wdetail.CovTyp,"1") <> 0 THEN TRIM(fi_camp) 
                                       ELSE IF INDEX(wdetail.covtyp,"2+") <> 0 THEN TRIM(fi_camp2) 
                                       ELSE IF INDEX(wdetail.covtyp,"3+") <> 0 THEN TRIM(fi_camp3)
                                       ELSE "" .             /*แคมเปญ*/

         IF index(wdetail.CovTyp,"1") <> 0 OR INDEX(wdetail.covtyp,"2+") <> 0 OR INDEX(wdetail.covtyp,"3+") <> 0 THEN RUN proc_insp. /*A62-0219*/
END.                      

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
/*DEF VAR n AS INT INIT 0.
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
                        brstat.tlt.genusr       = "ORICO"                                                                       
                        brstat.tlt.usrid        = USERID(LDBNAME(1))                    /*User Load Data */                      
                        brstat.tlt.imp          = "IM"                                  /*Import Data*/                          
                        brstat.tlt.releas       = "No"                                                                           
                        brstat.tlt.recac        = ""                                                                             
                        brstat.tlt.comp_sub     = trim(wdetail.producer)
                        brstat.tlt.comp_noti_ins = "B300303"
                        brstat.tlt.rec_addr1        = IF trim(wdetail.ben_name) = "ICBCTL" THEN "MC28982" ELSE ""   /* vat code */
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
                        brstat.tlt.lotno        = TRIM(wdetail.campaign). /*A60-0263*/
            END.                      
            ELSE DO:                  
                nv_completecnt  =  nv_completecnt + 1.
                RUN proc_Create_tltnew2.
            END.
        END.
    END.
END.
Run proc_Open_tlt.        */                   
                            
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
/*ASSIGN 
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
     brstat.tlt.comp_noti_ins = "B300303"
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
     brstat.tlt.lotno        = TRIM(wdetail.campaign). /*A60-0263*/*/
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
/*DEF VAR n AS INT INIT 0.
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
                             brstat.tlt.comp_sub     = "A0M0097"
                             brstat.tlt.comp_noti_ins = "B300303"
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
                             brstat.tlt.dat_ins_noti = ?.
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
Run proc_Open_tlt.  */
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
/*IF wdetail.sckno = "" THEN DO:
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
     brstat.tlt.comp_sub     = "A0M0097"
     brstat.tlt.comp_noti_ins = "B300303"
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
     brstat.tlt.dat_ins_noti = ?.
END.
ELSE DO:
    ASSIGN 
    brstat.tlt.comp_sck     = trim(wdetail.sckno)                 /*เลขที่สติ๊กเกอร์  */  
    brstat.tlt.comp_effdat  = nv_comdat72                         /*วันทีเริ่มคุ้มครองพรบ */     
    brstat.tlt.nor_effdat   = nv_expdat72                         /*วันที่สิ้นสุดคุ้มครองพรบ   */
    brstat.tlt.comp_grprm   = DECI(wdetail.comp_prmtotal)         /*เบี้ยรวมพรบ. */      
    brstat.tlt.rec_addr4    = TRIM(wdetail.comp_prm).              /*เบี้ยสุทธิพรบ */      
END.*/
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
DEF VAR nv_i AS INT.
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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insp C-Win 
PROCEDURE proc_insp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A62-0219      
------------------------------------------------------------------------------*/
DO:
    DEF VAR nv_acc    AS CHAR FORMAT "x(255)" .
    DEF VAR nv_accpri AS CHAR FORMAT "x(15)" .
    DEF VAR nv_nameT AS CHAR FORMAT "X(50)".
    DEF VAR nv_agentname AS CHAR FORMAT "X(60)".
    DEF VAR nv_brand AS CHAR FORMAT "X(50)". 
    DEF VAR nv_model AS CHAR FORMAT "X(50)". 
    DEF VAR nv_licentyp AS CHAR FORMAT "X(50)".
    DEF VAR nv_licen    AS CHAR FORMAT "X(20)". 
    DEF VAR nv_pattern1 AS CHAR FORMAT "X(20)".  
    DEF VAR nv_pattern4 AS CHAR FORMAT "X(20)".  
    DEF VAR nv_today  AS CHAR init "" .
    DEF VAR nv_time   AS CHAR init "" .
    DEF VAR nv_docno  AS CHAR FORMAT "x(25)".
    DEF VAR nv_survey AS CHAR FORMAT "x(25)".
    DEF VAR nv_detail AS CHAR FORMAT "x(30)".
    DEF VAR n_dam     AS CHAR FORMAT "x(10)" init "".  /*A66-0107*/
    DEF VAR n_repair  AS CHAR FORMAT "x(10)" init "".  /*A66-0107*/
    DEF VAR nv_damag  AS CHAR FORMAT "x(30)" init "".  /*A66-0107*/
    DEF VAR nv_repair AS CHAR FORMAT "x(30)" init "".  /*A66-0107*/
    
    ASSIGN  nv_docno    = ""    nv_nameT     = ""       nv_brand    = ""        nv_model     = ""   n_dam     = "" /*A66-0107*/
            nv_licentyp = ""    nv_tmp       = ""       nv_pattern1 = ""        nv_pattern4  = ""   n_repair  = "" /*A66-0107*/
            nv_licen    = ""    nv_agentname = ""       nv_survey   = ""        nv_detail    = ""   nv_damag  = "" /*A66-0107*/
            nv_acc      = ""                                                                        nv_repair = "" /*A66-0107*/
            nv_accpri   = ""
            nv_tmp      = "Inspect" + SUBSTR(STRING(YEAR(TODAY),"9999"),3,2) + ".nsf" 
            nv_today    = STRING(DAY(TODAY),"99") + "/" + STRING(MONTH(TODAY),"99") + "/" + STRING(YEAR(TODAY),"9999")
            nv_time     = STRING(TIME,"HH:MM:SS").
    
    IF INDEX(wdetail.pol_title,"คุณ")               <> 0 THEN ASSIGN nv_nameT = "บุคคล".
    ELSE IF INDEX(wdetail.pol_title,"นาย")          <> 0 THEN ASSIGN nv_nameT = "บุคคล".
    ELSE IF INDEX(wdetail.pol_title,"นาง")          <> 0 THEN ASSIGN nv_nameT = "บุคคล".
    ELSE IF INDEX(wdetail.pol_title,"น.ส.")         <> 0 THEN ASSIGN nv_nameT = "บุคคล".
    ELSE IF INDEX(wdetail.pol_title,"นางสาว")       <> 0 THEN ASSIGN nv_nameT = "บุคคล".
    ELSE IF INDEX(wdetail.pol_title,"ห้างหุ้นส่วน") <> 0 THEN ASSIGN nv_nameT = "ห้างหุ้นส่วนจำกัด / ห้างหุ้นส่วน".
    ELSE IF INDEX(wdetail.pol_title,"หจก")          <> 0 THEN ASSIGN nv_nameT = "ห้างหุ้นส่วนจำกัด / ห้างหุ้นส่วน".
    ELSE IF INDEX(wdetail.pol_title,"บริษัท")       <> 0 THEN ASSIGN nv_nameT = "บริษัท".
    ELSE IF INDEX(wdetail.pol_title,"บจก")          <> 0 THEN ASSIGN nv_nameT = "บริษัท".
    ELSE IF INDEX(wdetail.pol_title,"มูลนิธิ")      <> 0 THEN ASSIGN nv_nameT = "มูลนิธิ".
    ELSE IF INDEX(wdetail.pol_title,"โรงแรม")       <> 0 THEN ASSIGN nv_nameT = "โรงแรม".
    ELSE IF INDEX(wdetail.pol_title,"โรงเรียน")     <> 0 THEN ASSIGN nv_nameT = "โรงเรียน".
    ELSE IF INDEX(wdetail.pol_title,"ร.ร.")         <> 0 THEN ASSIGN nv_nameT = "โรงเรียน".
    ELSE IF INDEX(wdetail.pol_title,"โรงพยาบาล")    <> 0 THEN ASSIGN nv_nameT = "โรงพยาบาล".
    ELSE IF INDEX(wdetail.pol_title,"นิติบุคคลอาคารชุด") <> 0 THEN ASSIGN nv_nameT = "นิติบุคคลอาคารชุด".
    ELSE ASSIGN nv_nameT = "อื่นๆ".
    
   /* ASSIGN nv_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) ELSE trim(wdetail.brand)
           nv_model =   IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,LENGTH(nv_brand) + 1,LENGTH(wdetail.brand))) ELSE "".*/
   ASSIGN nv_acc    = if TRIM(wdetail.accsor) <> "" THEN "อุปกรณ์: " + TRIM(wdetail.accsor) ELSE ""
          nv_accpri = if TRIM(wdetail.accsor_price) <> "" THEN "ราคา:" + TRIM(wdetail.accsor_price) + " .-" ELSE ""  
          nv_brand =   wdetail.brand       
          nv_model =   wdetail.Brand_Model .

    IF INDEX(brstat.tlt.ins_name," ") <> 0 THEN DO:
        ASSIGN wdetail.pol_fname = SUBSTR(brstat.tlt.ins_name,1,INDEX(brstat.tlt.ins_name," "))
               wdetail.pol_lname = SUBSTR(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ")).
    END.
    IF trim(wdetail.RegisNo) <> "" AND trim(wdetail.RegisProv) <> "" THEN DO:
        ASSIGN nv_licentyp = "รถเก๋ง/กระบะ/บรรทุก".

        IF TRIM(wdetail.RegisProv) <> "" THEN DO:
            FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(wdetail.RegisProv) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN wdetail.RegisProv = brstat.Insure.LName.
        END.
        
    END.
    ELSE DO: 
        ASSIGN nv_licentyp = "รถที่ยังไม่มีทะเบียน"
               nv_pattern4 = "/ZZZZZZZZZ" 
               wdetail.RegisNo = "/" + SUBSTR(wdetail.RegisNo,LENGTH(wdetail.RegisNo) - 8,LENGTH(wdetail.RegisNo)) 
               wdetail.RegisProv = "".
    END.
    IF trim(brstat.tlt.comp_sub) <> "" THEN DO:
     FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
          xmm600.acno  =  trim(brstat.tlt.comp_sub) NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            FIND sicsyac.xtm600 USE-INDEX xtm60001  WHERE xtm600.acno  =  trim(brstat.tlt.comp_sub) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL xtm600 THEN 
                ASSIGN nv_agentname = TRIM(sicsyac.xtm600.ntitle) + "  "  + TRIM(sicsyac.xtm600.name) .
            ELSE 
                ASSIGN nv_agentname = "".
        END.
        ELSE 
            ASSIGN nv_agentname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
    END.
    
    IF wdetail.RegisNo <> "" THEN DO:
       ASSIGN nv_licen = REPLACE(wdetail.RegisNo," ","").
       IF INDEX("0123456789",SUBSTR(wdetail.RegisNo,1,1)) <> 0 THEN DO:
           IF LENGTH(nv_licen) = 4 THEN 
             /* ASSIGN nv_Pattern1 = "y-xx-y-xx"                                                                    */ /*A63-0448*/
             /*        nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,1).*/ /*A63-0448*/
               ASSIGN nv_Pattern1 = "yxx-y-xx"                                         /*A63-0448*/                             
                     nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,1).  /*A63-0448*/
           ELSE IF LENGTH(nv_licen) = 5 THEN
               /*ASSIGN nv_Pattern1 = "y-xx-yy-xx"                                                                   */ /*A63-0448*/
               /*       nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,2).*/ /*A63-0448*/
               ASSIGN nv_Pattern1 = "yxx-yy-xx"                                                 /*A63-0448*/
                          nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,2).      /*A63-0448*/
           ELSE IF LENGTH(nv_licen) = 6 THEN DO:
               IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
                   ASSIGN nv_Pattern1 = "yy-yyyy-xx"
                          nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
               ELSE IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
                   ASSIGN nv_Pattern1 = "yx-yyyy-xx"
                          nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
               ELSE 
                  /* ASSIGN nv_Pattern1 = "y-xx-yyy-xx"                                                                  */  /*A63-0448*/
                  /*        nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,3).*/  /*A63-0448*/
                   ASSIGN nv_Pattern1 = "yxx-yyy-xx"                                       /*A63-0448*/                           
                          nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,3). /*A63-0448*/
           END.
           ELSE /*ASSIGN nv_Pattern1 = "y-xx-yyyy-xx"                                                                 */  /*A63-0448*/
                /*       nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,4).*/  /*A63-0448*/
                ASSIGN nv_Pattern1 = "yxx-yyyy-xx"                                        /*A63-0448*/              
                       nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,4).   /*A63-0448*/
        END.
        ELSE DO:
            IF LENGTH(nv_licen) = 3 THEN 
              ASSIGN nv_Pattern1 = "xx-y-xx"
                     nv_licen    = SUBSTR(nv_licen,1,2) + " "  + SUBSTR(nv_licen,3,1) .
            ELSE IF LENGTH(nv_licen) = 4 THEN
               ASSIGN nv_Pattern1 = "xx-yy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,2) .
            ELSE IF LENGTH(nv_licen) = 6 THEN
               ASSIGN nv_Pattern1 = "xx-yyyy-xx" 
                      nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
            ELSE IF LENGTH(nv_licen) = 5 THEN DO:
                IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
                   ASSIGN nv_Pattern1 = "x-yyyy-xx"
                          nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,4).
                ELSE 
                   ASSIGN nv_Pattern1 = "xx-yyy-xx" 
                          nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,3).
            END.
            ELSE ASSIGN nv_Pattern1 = "xxx-yyy-xx"                                         /*A63-0448*/
                          nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,3). /*A63-0448*/
        END.
    END.
    
    /*--------- Server Real ---------- */
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\uw\" + nv_tmp .
    /* -----------------------------*/
    /*---------- Server test local ------- 
    nv_server = "".
    nv_tmp    = "D:\Lotus\Notes\Data\" + nv_tmp .
     -----------------------------*/
    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).
                 
      IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
         MESSAGE "Can not open database" SKIP  
                 "Please Check database and server" VIEW-AS  ALERT-BOX ERROR.
      END.
      ELSE DO:
        chNotesView    = chNotesDatabase:GetView("chassis_no").
        chNavView      = chNotesView:CreateViewNav.
        chDocument     = chNotesView:GetDocumentByKey(trim(wdetail.chassis)).
        
        IF VALID-HANDLE(chDocument) = YES THEN DO:
        
            chitem       = chDocument:Getfirstitem("docno"). 
            IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
            ELSE nv_docno = "".
        
            chitem       = chDocument:Getfirstitem("SurveyClose").
            IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
            ELSE nv_survey = "".
        
            chitem       = chDocument:Getfirstitem("SurveyResult").
            IF chitem <> 0 THEN  nv_detail = chitem:TEXT.
            ELSE nv_detail = "" .
            /* A62-0454 */
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
              IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมทั้งสิ้น " + nv_totaldam + " บาท " .
              /*A66-0107*/
              IF n_list > 0  THEN DO:
                  ASSIGN  n_count = 1 .
                  loop_damage:
                  REPEAT:
                      IF n_count <= n_list THEN DO:
                          ASSIGN  n_dam     = "List"   + STRING(n_count) 
                              n_repair  = "Repair" + STRING(n_count) .
                          chitem       = chDocument:Getfirstitem(n_dam).
                          IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                          ELSE nv_damag = "".  
                          chitem       = chDocument:Getfirstitem(n_repair).
                          IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                          ELSE nv_repair = "".
                          IF nv_damag <> "" THEN  
                              ASSIGN nv_damdetail  = nv_damdetail  + string(n_count) + "." + nv_damag + " "     + nv_repair + " , "   .
                          n_count = n_count + 1.
                      END.
                      ELSE LEAVE loop_damage.
                  END.
              END.
              /*A66-0107*/
            END.
            /* end A62-0454 */
            IF nv_docno <> ""  THEN DO:
                IF nv_survey <> "" THEN DO:
                  ASSIGN  brstat.tlt.rec_addr3 =  nv_docno  
                          /*brstat.tlt.filler2   =  brstat.tlt.filler2 + " " + trim(nv_detail + " " + nv_damlist + " " + nv_totaldam). /*A62-0454*/*//*comment by kridtiya i. A66-0107*/
                          brstat.tlt.filler2   =  brstat.tlt.filler2                                          /*Add by kridtiya i. A66-0107*/
                          brstat.tlt.note1     =  trim(nv_detail + " " + nv_damlist + " " + nv_damdetail).    /*Add by kridtiya i. A66-0107*/
                END.
                ELSE DO:
                  ASSIGN  brstat.tlt.rec_addr3 =  nv_docno.
                END.
            END.
            ELSE ASSIGN  brstat.tlt.rec_addr3 = "" .
        
        
            RELEASE  OBJECT chitem          NO-ERROR.
            RELEASE  OBJECT chDocument      NO-ERROR.          
            RELEASE  OBJECT chNotesDataBase NO-ERROR.     
            RELEASE  OBJECT chNotesSession  NO-ERROR.
        END.
        
      END.
END.
    
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
       wtlt.camp        =   tlt.genusr.
END.
OPEN QUERY br_imptxt FOR EACH wtlt NO-LOCK.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

