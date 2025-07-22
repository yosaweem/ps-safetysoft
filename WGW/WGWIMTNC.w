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
wgwqtnc2.w :  Import data file to table  tlt (Thanachat)
Create  by :  Ranu i. A59-0316  On   08/07/2016
              เก็บข้อมูลจากไฟลืแจ้งงานเข้า Table TLT
+++++++++++++++++++++++++++++++++++++++++++++++*/
/*Modify by : Ranu I. A59-0471 07/10/2016 
              เปลี่ยนเงื่อนไขการ Create V72 โดยไม่ต้องเช็คเลขสติ๊กเกอร์     */
/*Modify by : Ranu I. A60-0383 Date : 01/09/2017 เพิ่มการเช็คข้อมูลจากไฟล์แจ้งงาน และใบเตือน (wgwtnchk.p)
             เพิ่มการเช็ค producer code A0M0014 จากช่องหมายเหตุcall1770,เพิ่ม Filed เก็บข้อมูล loss Ratio  */
/*Modify by : Ranu I. A61-0512 date:07/11/2018 แก้ไขการเช็คคำนำหน้าชื่อ และเพิ่ม file เก็บ ISP no. */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/* Modify by: Ranu I. A63-0174 เพิ่มการเก็บข้อมูลงานป้ายแดงในถังพัก    */
/* Modify by : Ranu I. A64-0205 เพิ่มตัวเลือก producer / Agent งานต่ออายุ */
/* Modify by : Ranu I. A64-0278 เปลี่ยน producer / Agent ทั้งหมด */
/* Modify by : Kridtiya i. A66-0160 ตัดเครื่องหมาย 'ออกจาก เลขสติ๊กเกอร์ กธ พรบ เลขที่เลขเครื่องยนต์เลขตัวถัง**/
/*---------------------------------------------------------------------------*/
DEF VAR gv_id  AS CHAR FORMAT "X(12)" NO-UNDO.  /* A60-0383 */
DEF VAR n_user  AS CHAR FORMAT "X(12)" NO-UNDO.  /* A60-0383 */
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO.  /* A60-0383 */
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC  INIT   Yes.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail NO-UNDO
    FIELD Pro_off       AS CHAR FORMAT "X(20)"  INIT ""   /*เลขที่รับแจ้งและสาขา  */           
    FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""   /*เลขที่รับแจ้ง         */           
    FIELD branch        AS CHAR FORMAT "X(4)"   INIT ""   /*สาขา                  */           
    FIELD Account_no    AS CHAR FORMAT "X(12)"  INIT ""   /*เลขที่สัญญา           */           
    FIELD prev_pol      AS CHAR FORMAT "X(15)"  INIT ""   /*เลขที่กรมธรรม์เดิม    */           
    FIELD company       AS CHAR FORMAT "X(50)"  INIT ""   /*บริษัทประกันเก่า      */           
    FIELD name_insur    AS CHAR FORMAT "X(100)" INIT ""   /*ชื่อผู้เอาประกันภัย   */           
    FIELD ben_name      AS CHAR FORMAT "X(50)"  INIT ""   /*ผู้รับผลประโยชน์      */           
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
    FIELD sckno         AS CHAR FORMAT "X(15)"  INIT ""   /*เลขที่สติ๊กเกอร์      */           
    FIELD not_code      AS CHAR FORMAT "X(75)"  INIT ""   /*รหัสผู้แจ้ง           */           
    FIELD remark        AS CHAR FORMAT "X(225)" INIT ""   /*หมายเหตุ              */           
    FIELD not_date      AS CHAR FORMAT "X(15)"  INIT ""   /*วันที่รับแจ้ง         */           
    FIELD not_office    AS CHAR FORMAT "X(35)"  INIT ""   /*ชื่อประกันภัย         */           
    FIELD not_name      AS CHAR FORMAT "X(50)"  INIT ""   /*ผู้แจ้ง               */           
    FIELD brand         AS CHAR FORMAT "X(15)"  INIT ""   /*ยี่ห้อ                */           
    FIELD Brand_Model   AS CHAR FORMAT "X(35)"  INIT ""   /*รุ่น                  */           
    FIELD yrmanu        AS CHAR FORMAT "X(10)"  INIT ""   /*ปี                    */           
    FIELD weight        AS CHAR FORMAT "X(10)"  INIT ""   /*ขนาดเครื่อง           */           
    FIELD engine        AS CHAR FORMAT "X(50)"  INIT ""   /*เลขเครื่อง            */           
    FIELD chassis       AS CHAR FORMAT "X(50)"  INIT ""   /*เลขถัง                */           
    FIELD pattern       AS CHAR FORMAT "X(75)"  INIT ""   /*Pattern Rate          */           
    FIELD covcod        AS CHAR FORMAT "X(3)"   INIT ""   /*ประเภทประกัน          */           
    FIELD vehuse        AS CHAR FORMAT "X(50)"  INIT ""   /*ประเภทรถ              */           
    FIELD garage        AS CHAR FORMAT "X(30)"  INIT ""   /*สถานที่ซ่อม           */           
    FIELD drivename1    AS CHAR FORMAT "X(50)"  INIT ""   /*ระบุผู้ขับขี้1        */           
    FIELD driveid1      AS CHAR FORMAT "X(15)"  INIT ""   /*เลขที่ใบขับขี่1       */           
    FIELD driveic1      AS CHAR FORMAT "X(15)"  INIT ""   /*เลขที่บัตรประชาชน1    */           
    FIELD drivedate1    AS CHAR FORMAT "X(15)"  INIT ""   /*วันเดือนปีเกิด1       */           
    FIELD drivname2     AS CHAR FORMAT "X(50)"  INIT ""   /*ระบุผู้ขับขี้2        */           
    FIELD driveid2      AS CHAR FORMAT "X(15)"  INIT ""   /*เลขที่ใบขับขี่2       */           
    FIELD driveic2      AS CHAR FORMAT "X(15)"  INIT ""   /*เลขที่บัตรประชาชน2    */           
    FIELD drivedate2    AS CHAR FORMAT "X(15)"  INIT ""   /*วันเดือนปีเกิด2       */           
    FIELD cl            AS CHAR FORMAT "X(15)"  INIT ""   /*ส่วนลดประวัติเสีย     */           
    FIELD fleetper      AS CHAR FORMAT "X(15)"  INIT ""   /*ส่วนลดกลุ่ม           */           
    FIELD ncbper        AS CHAR FORMAT "X(15)"  INIT ""   /*ประวัติดี             */           
    FIELD othper        AS CHAR FORMAT "x(15)"  INIT ""   /*อื่น ๆ                */           
    FIELD pol_addr1     as char format "x(150)" init ""   /*ที่อยู่ลูกค้า         */           
    FIELD icno          as char format "x(13)"  init ""   /*IDCARD                */           
    FIELD icno_st       as char format "x(15)"  init ""   /*DateCARD_S            */           
    FIELD icno_ex       as char format "x(15)"  init ""   /*DateCARD_E            */           
    FIELD paid          as char format "x(50)"  init ""   /*Type_Paid_1           */           
    FIELD addr1         as char format "x(35)"  init ""                                        
    FIELD addr2         as char format "x(35)"  init ""
    FIELD addr3         as char format "x(35)"  init ""
    FIELD addr4         as char format "x(35)"  init ""
    FIELD pol_title     as char format "x(15)"  init ""
    FIELD pol_fname     as char format "x(50)"  init ""
    FIELD pol_lname     as char format "x(50)"  init ""
    FIELD not_time      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD loss          AS CHAR FORMAT "x(10)"  INIT ""
    FIELD remark2       AS CHAR FORMAT "x(150)" INIT "" /*A60-0383*/
    /* A63-0174 */
    field mkBR          as char format "x(15)" init "" 
    field lgroup         as char format "x(50)" init "" 
    field notiname      as char format "x(50)" init "" 
    field pol_addr2     as char format "x(100)" init "" 
    field tel           as char format "x(20)" init "" 
    field pol_send1     as char format "x(100)" init "" 
    field pol_send2     as char format "x(100)" init "" 
    field telsend       as char format "x(20)" init "" 
    field netprem       as char format "x(15)" init "" 
    field comprem       as char format "x(15)" init "" 
    field ncolor        as char format "x(15)" init "" 
    field comment       as char format "x(255)" init "" 
    field pol_promo     as char format "x(50)" init "" 
    field comp_promo    as char format "x(50)" init "" 
    field price         as char format "x(15)" init "" 
    field price1        as char format "x(15)" init "" 
    field dealer        as char format "x(50)" init "" 
    field drive         as char format "x(15)" init "" 
    field cartype       as char format "x(30)" init "" 
    field notitype      as char format "x(25)" init "" 
    field vehuse1       as char format "x(50)" init "" 
    field CodeRe        as char format "x(5)" init "" 
    field seat          as char format "x(3)" init "" 
    field taxno         as char format "x(15)" init "" 
    field name2         as char format "x(100)" init "" 
    field typeic        as char format "x(25)" init "" 
    field typetax       as char format "x(50)" init "" 
    field taxbr         as char format "x(5)" init "" .
    /* end A63-0174 */

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
    FIELD remark        AS CHAR FORMAT "x(100)" INIT "".  /*A60-0383 */
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
/* add by A64-0205 */
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

/* end A64-0205 */

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
&Scoped-define FIELDS-IN-QUERY-br_imptxt wtlt.remark wtlt.trndat wtlt.Notify_no wtlt.branch wtlt.Account_no wtlt.prev_pol wtlt.name_insur wtlt.comdat wtlt.expdat wtlt.comdat72 wtlt.expdat72 wtlt.licence wtlt.province wtlt.ins_amt wtlt.prem1 wtlt.comp_prm wtlt.gross_prm wtlt.compno wtlt.not_date wtlt.not_office wtlt.not_name wtlt.brand wtlt.Brand_Model wtlt.yrmanu wtlt.weight wtlt.engine wtlt.chassis   
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
&Scoped-Define ENABLED-OBJECTS br_imptxt rs_comp rs_type fi_loaddat ~
fi_compa fi_producer fi_filename bu_ok bu_exit bu_file bu_hpacno1 fi_agent ~
bu_hpacno-2 RECT-1 RECT-79 RECT-80 RECT-380 
&Scoped-Define DISPLAYED-OBJECTS rs_comp rs_type fi_loaddat fi_compa ~
fi_producer fi_filename fi_proname fi_impcnt fi_completecnt fi_dir_cnt ~
fi_dri_complet fi_agent fi_agname 

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

DEFINE BUTTON bu_hpacno-2 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44.67 BY .91
     BGCOLOR 18 FGCOLOR 2  NO-UNDO.

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

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44.67 BY .91
     BGCOLOR 18 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE rs_comp AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Empire Old", 1,
"Orakan Old", 2
     SIZE 15 BY 1.91
     BGCOLOR 19 FONT 1 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "NEW", 1,
"RENEW", 2
     SIZE 45.5 BY .91
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.71
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 128.5 BY 7.48.

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
      wtlt.remark       COLUMN-LABEL "หมายเหตุ"            FORMAT "X(65)"
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
      wtlt.province     COLUMN-LABEL "จังหวัด"             FORMAT "X(30)"            
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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128 BY 14.76
         BGCOLOR 10 FGCOLOR 2 FONT 4 ROW-HEIGHT-CHARS .86 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_imptxt AT ROW 9.57 COL 3
     rs_comp AT ROW 2.19 COL 109 NO-LABEL WIDGET-ID 16
     rs_type AT ROW 4.29 COL 40.17 NO-LABEL WIDGET-ID 4
     fi_loaddat AT ROW 1.38 COL 38 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.33 COL 72 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 2.38 COL 38 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 5.29 COL 38 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.95 COL 99.5
     bu_exit AT ROW 6.95 COL 110.83
     fi_proname AT ROW 2.33 COL 60.33 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 5.29 COL 116.33
     fi_impcnt AT ROW 6.33 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 6.33 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_dir_cnt AT ROW 7.33 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_dri_complet AT ROW 7.33 COL 75.17 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 2.38 COL 57.83
     fi_agent AT ROW 3.33 COL 38 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_agname AT ROW 3.24 COL 60.33 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     bu_hpacno-2 AT ROW 3.33 COL 57.83 WIDGET-ID 8
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 6.33 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "        ข้อมูลผู้ขับขี่นำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 7.33 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                    รหัส Producer  :" VIEW-AS TEXT
          SIZE 29 BY .91 AT ROW 2.38 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                         รหัส Agent :" VIEW-AS TEXT
          SIZE 29 BY .91 AT ROW 3.33 COL 10.5 WIDGET-ID 14
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                         ประเภทงาน  :" VIEW-AS TEXT
          SIZE 29 BY .91 AT ROW 4.29 COL 10.5 WIDGET-ID 2
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 7.33 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 7.33 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 7.33 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.33 COL 57.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 6.33 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY .91 AT ROW 6.33 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "           กรุณาป้อนชื่อไฟล์นำเข้า :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 5.29 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " ข้อมูลแจ้งประกันนำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY .91 AT ROW 6.33 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "  รายละเอียดข้อมูล" VIEW-AS TEXT
          SIZE 128.5 BY .81 AT ROW 8.76 COL 2.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                   วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.38 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1 COL 1
     RECT-79 AT ROW 6.48 COL 98
     RECT-80 AT ROW 6.48 COL 109.83
     RECT-380 AT ROW 1.14 COL 3
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
         HEIGHT             = 23.91
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
IF NOT C-Win:LOAD-ICON("WIMAGE/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/iconhead.ico"
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

/* SETTINGS FOR FILL-IN fi_agname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dir_cnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dri_complet IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
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


&Scoped-define SELF-NAME bu_hpacno-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno-2 C-Win
ON CHOOSE OF bu_hpacno-2 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,
                                      output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 C-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,
                                      output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

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
   /* FOR EACH wdriver.
        DELETE wdriver.
    END.*/
    IF rs_type = 1 THEN RUN IMPORT_notinew. /*a63-0174 */
    ELSE Run  Import_notification.    /*ไฟล์แจ้งงาน กรมธรรม์*/
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
   /* Run  Import_driver.        /*ไฟล์แจ้งงานชื่อผู้ขับขี่ */*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    /*
    If  Input  fi_producer  =  ""  Then do:
       Message "กรุณาระบุรหัสผู้หางาน "  View-as alert-box.
       Apply "Entry" to fi_producer.
       End.
    */
    If Input  fi_agent  =  ""  Then do:
        Apply "Choose"  to  bu_hpacno1.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
        xmm600.acno  =  Input fi_agent    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" 
            View-as alert-box.
        Apply "Entry" To  fi_agent.
        Return no-apply.
    END.
    ELSE 
        ASSIGN fi_agname =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
    fi_agent =  INPUT  fi_agent.
    Disp  fi_agent  fi_agname  WITH Frame  fr_main.                 

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


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    /*
    If  Input  fi_producer  =  ""  Then do:
       Message "กรุณาระบุรหัสผู้หางาน "  View-as alert-box.
       Apply "Entry" to fi_producer.
       End.
    */
    If Input  fi_producer  =  ""  Then do:
        Apply "Choose"  to  bu_hpacno1.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
        xmm600.acno  =  Input fi_producer    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" 
            View-as alert-box.
        Apply "Entry" To  fi_producer.
        Return no-apply.
    END.
    ELSE 
        ASSIGN fi_proname =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
    fi_producer =  INPUT  fi_producer.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_comp C-Win
ON VALUE-CHANGED OF rs_comp IN FRAME fr_main
DO:
    /*A64-0205*/
    rs_comp = INPUT rs_comp .
    DISP rs_comp WITH FRAME fr_main.

    IF rs_comp = 1 THEN DO:
        ASSIGN /* fi_producer = "B3MLTMB101"   */ /*A64-0278*/ 
               /* fi_agent    = "B3MLTMB100" . */ /*A64-0278*/
               fi_producer = "B3MLTTB101"    /*A64-0278*/ 
               fi_agent    = "B3MLTTB100" .  /*A64-0278*/
    END.
    ELSE DO:
        ASSIGN  /*fi_producer = "B3MLTMB105"   */   /*A64-0278*/  
                /*fi_agent    = "B3MLTMB100" . */   /*A64-0278*/
                 fi_producer = "B3MLTTB105"    /*A64-0278*/ 
                 fi_agent    = "B3MLTTB100" .  /*A64-0278*/
    END.
    DISP fi_producer fi_agent WITH FRAME fr_main.
    /* end A64-0205*/  
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type C-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type.
    DISP rs_type WITH FRAME fr_main.

    IF rs_type = 1 THEN DO:
        DISABLE rs_comp WITH FRAME fr_main.
        ASSIGN /*fi_producer = "A0M0039" .*//*A64-0205*/
               /* fi_producer = "B3MLTMB201"   /* A64-0205 */ */  /*A64-0278*/
               /* fi_agent    = "B3MLTMB200".  /* A64-0205 */ */  /*A64-0278*/
               fi_producer = "B3MLTTB201"   /*A64-0278*/
               fi_agent    = "B3MLTTB200".  /*A64-0278*/
    END.  
    ELSE DO:
        ENABLE rs_comp WITH FRAME fr_main.
        IF rs_comp = 1 THEN DO:
            ASSIGN  /*fi_producer = "A0M0049" .*/ /*A64-0205*/
                /*fi_producer = "B3MLTMB101"    /*A64-0205*/ */ /*A64-0278*/  
                /*fi_agent    = "B3MLTMB100" .  /*A64-0205*/ */ /*A64-0278*/ 
                fi_producer = "B3MLTTB101"   /*A64-0278*/  
                fi_agent    = "B3MLTTB100" . /*A64-0278*/ 

        END.
        ELSE DO:
        ASSIGN  /*fi_producer = "A0M0049" .*/ /*A64-0205*/
                /*fi_producer = "B3MLTMB105"    /*A64-0205*/ */  /*A64-0278*/  
                /*fi_agent    = "B3MLTMB100" .  /*A64-0205*/ */  /*A64-0278*/
                fi_producer = "B3MLTTB105"     /*A64-0278*/  
                fi_agent    = "B3MLTTB100" .   /*A64-0278*/
        END.
    END.
  DISP fi_producer fi_agent WITH FRAME fr_main.
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
  
  gv_prgid = "wgwimtnc".
  gv_prog  = "Hold Text File Thanachat (Renew)".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */
 
  Hide Frame  fr_gen  .
  ASSIGN  
      fi_loaddat  =  today
      fi_compa    = "THANACHAT"
      /*fi_producer = "A0M0049" */    /*A63-0174 */
      /*fi_producer = "A0M0039" */      /*A63-0174 */
      /*fi_producer = "B3MLTMB201"   /*A64-0205*/ */ /*A64-0278*/
      /*fi_agent    = "B3MLTMB200"   /*A64-0205*/ */ /*A64-0278*/
      fi_producer = "B3MLTTB201"    /*A64-0278*/
      fi_agent    = "B3MLTTB200"    /*A64-0278*/
      rs_type     = 1 
      rs_comp     = 1 .
  DISABLE rs_comp WITH FRAME fr_main. /*A64-0205*/
  disp  fi_loaddat  fi_producer fi_agent fi_compa rs_type rs_comp with  frame  fr_main.
  
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
  DISPLAY rs_comp rs_type fi_loaddat fi_compa fi_producer fi_filename fi_proname 
          fi_impcnt fi_completecnt fi_dir_cnt fi_dri_complet fi_agent fi_agname 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_imptxt rs_comp rs_type fi_loaddat fi_compa fi_producer fi_filename 
         bu_ok bu_exit bu_file bu_hpacno1 fi_agent bu_hpacno-2 RECT-1 RECT-79 
         RECT-80 RECT-380 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notification C-Win 
PROCEDURE Import_notification :
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
            wdetail.Pro_off       /*เลขที่รับแจ้งและสาขา       */  
            wdetail.Notify_no     /*เลขที่รับแจ้ง              */  
            wdetail.branch        /*สาขา                       */  
            wdetail.Account_no    /*เลขที่สัญญา                */  
            wdetail.prev_pol      /*เลขที่กรมธรรม์เดิม         */  
            wdetail.company       /*บริษัทประกันเก่า           */  
            wdetail.name_insur    /*ชื่อผู้เอาประกันภัย        */  
            wdetail.ben_name      /*ผู้รับผลประโยชน์           */  
            wdetail.comdat        /*วันที่เริ่มคุ้มครอง        */  
            wdetail.expdat        /*วันที่สิ้นสุดคุ้มครอง      */  
            wdetail.comdat72      /*วันทีเริ่มคุ้มครองพรบ      */  
            wdetail.expdat72      /*วันที่สิ้นสุดคุ้มครองพรบ   */  
            wdetail.licence       /*เลขทะเบียน                 */  
            wdetail.province      /*จังหวัด                    */  
            wdetail.ins_amt       /*ทุนประกัน                  */  
            wdetail.prem1         /*เบี้ยประกันรวม             */  
            wdetail.comp_prm      /*เบี้ยพรบรวม                */  
            wdetail.gross_prm     /*เบี้ยรวม                   */  
            wdetail.compno        /*เลขกรมธรรม์พรบ             */  
            wdetail.sckno         /*เลขที่สติ๊กเกอร์           */  
            wdetail.not_code      /*รหัสผู้แจ้ง                */  
            wdetail.remark        /*หมายเหตุ                   */  
            wdetail.not_date      /*วันที่รับแจ้ง              */  
            wdetail.not_office    /*ชื่อประกันภัย              */  
            wdetail.not_name      /*ผู้แจ้ง                    */  
            wdetail.brand         /*ยี่ห้อ                     */  
            wdetail.Brand_Model   /*รุ่น                       */  
            wdetail.yrmanu        /*ปี                         */  
            wdetail.weight        /*ขนาดเครื่อง                */  
            wdetail.engine        /*เลขเครื่อง                 */  
            wdetail.chassis       /*เลขถัง                     */  
            wdetail.pattern       /*Pattern Rate               */  
            wdetail.covcod        /*ประเภทประกัน               */  
            wdetail.vehuse        /*ประเภทรถ                   */  
            wdetail.garage        /*สถานที่ซ่อม                */  
            wdetail.drivename1    /*ระบุผู้ขับขี้1             */  
            wdetail.driveid1      /*เลขที่ใบขับขี่1            */  
            wdetail.driveic1      /*เลขที่บัตรประชาชน1         */  
            wdetail.drivedate1    /*วันเดือนปีเกิด1            */  
            wdetail.drivname2     /*ระบุผู้ขับขี้2             */  
            wdetail.driveid2      /*เลขที่ใบขับขี่2            */  
            wdetail.driveic2      /*เลขที่บัตรประชาชน2         */  
            wdetail.drivedate2    /*วันเดือนปีเกิด2            */  
            wdetail.cl            /*ส่วนลดประวัติเสีย          */  
            wdetail.fleetper      /*ส่วนลดกลุ่ม                */  
            wdetail.ncbper        /*ประวัติดี                  */  
            wdetail.othper        /*อื่น ๆ                     */  
            wdetail.pol_addr1     /*ที่อยู่ลูกค้า              */  
            wdetail.icno          /*IDCARD                     */  
            wdetail.icno_st       /*DateCARD_S                 */  
            wdetail.icno_ex       /*DateCARD_E                 */  
            wdetail.paid.         /*Type_Paid_1                */ 
    IF INDEX(wdetail.Pro_off,"เลขที่")   <> 0 THEN  DELETE wdetail.
    ELSE IF  wdetail.Pro_off    = "" THEN  DELETE wdetail.
    ELSE IF  index(wdetail.province," ") <> 0 THEN wdetail.province = REPLACE(wdetail.province," ","") .
END.  /* repeat  */
/*start : A60-0383*/
loop_exp:
REPEAT:
    RUN Proc_sic_exp.    
    IF CONNECTED("sic_exp") THEN DO: 
        RUN wgw\wgwtnchk.   
        LEAVE loop_exp.
    END.
    ELSE NEXT loop_exp.
END.
 /*end : A60-0383*/
ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 
Run proc_Create_tlt.
RELEASE brstat.tlt.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_notinew C-Win 
PROCEDURE import_notinew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A63-0174       
------------------------------------------------------------------------------*/

FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"        
        wdetail.not_date   
        wdetail.not_code   
        wdetail.sckno      
        wdetail.compno     
        wdetail.not_office 
        wdetail.Notify_no  
        wdetail.mkBR
        wdetail.branch     
        wdetail.not_name   
        wdetail.lgroup
        wdetail.notiname  
        wdetail.name_insur 
        wdetail.icno       
        wdetail.pol_addr1  
        wdetail.pol_addr2  
        wdetail.tel
        wdetail.pol_send1
        wdetail.pol_send2
        wdetail.telsend  
        wdetail.ins_amt    
        wdetail.netprem
        wdetail.prem1      
        wdetail.comprem
        wdetail.comp_prm   
        wdetail.gross_prm  
        wdetail.Pro_off    
        wdetail.brand      
        wdetail.Brand_Model
        wdetail.yrmanu     
        wdetail.ncolor
        wdetail.licence    
        wdetail.weight     
        wdetail.engine     
        wdetail.chassis    
        wdetail.comment
        wdetail.pol_promo
        wdetail.comp_promo
        wdetail.price
        wdetail.price1
        wdetail.dealer
        wdetail.covcod     
        wdetail.drive
        wdetail.drivename1 
        wdetail.drivedate1
        wdetail.driveid1   
        wdetail.driveic1
        wdetail.drivname2
        wdetail.drivedate2 
        wdetail.driveid2   
        wdetail.driveic2 
        wdetail.comdat     
        wdetail.expdat     
        wdetail.cartype
        wdetail.remark2
        wdetail.notitype
        wdetail.vehuse     
        wdetail.vehuse1     
        wdetail.garage     
        wdetail.CodeRe
        wdetail.remark     
        wdetail.seat
        wdetail.taxno
        wdetail.name2
        wdetail.typeic
        wdetail.typetax
        wdetail.taxbr
        wdetail.ben_name   
        wdetail.Account_no 
        wdetail.pattern  .  
        IF INDEX(wdetail.NOT_date,"วันที่")   <> 0 THEN  DELETE wdetail.
    ELSE IF  wdetail.NOT_date    = "" THEN  DELETE wdetail.
END.  /* repeat  */

ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 
Run proc_Create_tlt_new.
RELEASE brstat.tlt.

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
IF rs_type = 1 THEN DO:
    nv_c = wdetail.Notify_no.
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
        wdetail.Notify_no = nv_c .

END.
ELSE DO:
    nv_c = wdetail.prev_pol.
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
        wdetail.prev_pol = nv_c .
    
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
DO WHILE INDEX(wdetail.pol_addr1,"  ") <> 0 :
    ASSIGN wdetail.pol_addr1 = REPLACE(wdetail.pol_addr1,"  "," ").
END.
ASSIGN wdetail.addr1 = ""
       wdetail.addr2 = ""
       wdetail.addr3 = ""
       wdetail.addr4 = ""
       wdetail.addr1 = TRIM(wdetail.pol_addr1).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt C-Win 
PROCEDURE proc_create_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS INT INIT 0.
LOOP_wdetail:
FOR EACH wdetail.
    IF  wdetail.Pro_off    =  "" THEN  DELETE wdetail.
    ELSE IF wdetail.comdat <> "" AND wdetail.expdat <> "" THEN DO:
    ASSIGN   
            nv_policy    = ""   nv_oldpol    = ""
            nv_comdat    = ?    nv_expdat    = ?  
            /*nv_comdat72  = ?    nv_expdat72  = ?*/    nv_accdat  =  ?
            nv_comchr  = ""     nv_addr    = ""     nv_name1   =  ""     
            nv_ntitle  = ""     nv_titleno = 0      nv_policy  =  ""
            nv_dd      = 0      nv_mm      = 0      nv_yy      =  0
            nv_cpamt1  = 0      nv_cpamt2  = 0      nv_cpamt3  =  0
            nv_coamt1  = 0      nv_coamt2  = 0      nv_coamt3  =  0         
            nv_insamt1 = 0      nv_insamt2 = 0      nv_insamt3 =  0
            nv_premt1  = 0      nv_premt2  = 0      nv_premt3  =  0
            nv_ncb1    = 0      nv_ncb2    = 0      nv_ncb3    =  0
            nv_fleet1  = 0      nv_fleet2  = 0      nv_fleet3  =  0
            nv_oth1    = 0      nv_oth2    = 0      nv_oth3    =  0
            nv_deduct1 = 0      nv_deduct2 = 0      nv_deduct3 =  0
            nv_power1  = 0      nv_power2  = 0      nv_power3  =  0
            nv_newpol  = ""     nv_reccnt  = nv_reccnt + 1
            wdetail.engine = REPLACE(wdetail.engine,"*","").
        IF NOT CONNECTED("sic_exp") THEN ASSIGN wdetail.remark2 = "Expiry Notconnect ไม่สามารถเช็คข้อมูลใบเตือนได้" . /*A60-0383*/
        IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    /* A56-0399 */
        ELSE ASSIGN nn_remark1  = trim(wdetail.remark)
            nn_remark2  = ""
            nn_remark3 = "".
        
        IF ( wdetail.Notify_no = "" ) THEN 
            MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
        ELSE DO:
            /* ------------------------check policy  Duplicate--------------------------------------*/ 
            IF wdetail.prev_pol <> "" THEN RUN pol_cutchar.
                nv_oldpol  =  wdetail.prev_pol.
                
            IF (wdetail.not_date  <> "" ) THEN ASSIGN  nv_notdat  = DATE(wdetail.not_date).
            ELSE ASSIGN  nv_notdat  = ?.

            IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat  = DATE(wdetail.comdat).
            ELSE ASSIGN nv_comdat = ?.

            IF (wdetail.expdat <>  "" ) THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
            ELSE ASSIGN nv_expdat  = ?.
        
           /* IF (wdetail.comdat72 <>  "" ) THEN ASSIGN nv_comdat72  = DATE(wdetail.comdat72). 
            ELSE ASSIGN nv_comdat72 = ?.

            IF (wdetail.expdat72 <>  "" ) THEN ASSIGN nv_expdat72  = DATE(wdetail.expdat72).
            ELSE ASSIGN nv_expdat72 = ?.*/
        
            /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- */
            nv_insamt3 = DECIMAL(wdetail.ins_amt).   /* by: kridtiya i. A54-0061.. */
            /* -------------------------- PREM1 CHR(11)   เบี้ยภาคสมัครใจบวกภาษีบวกอากร --- */
            nv_premt1 = DECIMAL(SUBSTRING(wdetail.prem1,1,9)).
            IF nv_premt1 < 0 THEN
                nv_premt2 = (DECIMAL(SUBSTRING(wdetail.prem1,10,2)) * -1) / 100.
            ELSE
                nv_premt2 = DECIMAL(SUBSTRING(wdetail.prem1,10,2)) / 100.
            nv_premt3 = nv_premt1 + nv_premt2.
            /* --------------------------------------------- COMP_PEM CHR(09)  เบี้ยพรบ.รวม --- */
            nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  
            /* -------------------------- GROSS_PRM CHR(11)   เบี้ยรวมภาคสมัครใจบวกเบี้ยรวม พรบ. --- */
            nv_coamt1 = DECIMAL(SUBSTRING(wdetail.gross_prm,1,9)).
            IF nv_coamt1 < 0 THEN
                nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) * -1) / 100.
            ELSE
                nv_coamt2 = DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) / 100.
            nv_coamt3 = nv_coamt1 + nv_coamt2.
            /* ----------------------FLEET_DISC. ส่วนลดกลุ่ม  / เปอร์เซ็นต์ --- */
            nv_fleet1 = DECIMAL(SUBSTRING(wdetail.fleetper,1,3)).
            IF nv_fleet1 < 0 THEN
                nv_fleet2 = (DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) * -1) / 100.
            ELSE
                nv_fleet2 = DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) / 100.
            nv_fleet3 = nv_fleet1 + nv_fleet2.
            /*Message "fleet"  wdetail.fleetper   nv_fleet3.*/
            /* ----------------------NCB_DISC. ส่วนลดประวัติดี  / เปอร์เซ็นต์ --- */
            nv_ncb1 = DECIMAL(SUBSTRING(wdetail.ncbper,1,3)).
            IF nv_ncb1 < 0 THEN
                nv_ncb2 = (DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) * -1) / 100.
            ELSE
                nv_ncb2 = DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) / 100.
            nv_ncb3 = nv_ncb1 + nv_ncb2.
            /* ----------------------OTH_DISC. ส่วนลดอื่น ๆ  / เปอร์เซ็นต์ --- */
            nv_oth1 = DECIMAL(SUBSTRING(wdetail.othper,1,3)).
            IF nv_oth1 < 0 THEN
                nv_oth2 = (DECIMAL(SUBSTRING(wdetail.othper,4,2)) * -1) / 100.
            ELSE
                nv_oth2 = DECIMAL(SUBSTRING(wdetail.othper,4,2)) / 100.
            nv_oth3 = nv_oth1 + nv_oth2.
            /*-----------------------------------------------------------------*/
            IF LENGTH(trim(wdetail.icno)) < 13 THEN wdetail.remark2 = wdetail.remark2 + " /เลขบัตรประชาชนไม่ครบ 13 หลัก " . /*A60-0383*/
            IF TRIM(wdetail.pol_addr1) <> " "  THEN RUN proc_address.
            IF TRIM(wdetail.name_insur) <> " " THEN DO:
                ASSIGN n = 0
                       wdetail.name_insur = TRIM(wdetail.name_insur)
                       wdetail.pol_title  = IF INDEX(wdetail.name_insur," ") <> 0 THEN SUBSTR(wdetail.name_insur,1,INDEX(wdetail.name_insur," ")) ELSE ""
                       n = LENGTH(wdetail.name_insur) - LENGTH(wdetail.pol_title)                
                       wdetail.pol_fname  = IF INDEX(wdetail.name_insur," ") <> 0 THEN SUBSTR(wdetail.name_insur,INDEX(wdetail.name_insur," "), n + 1 ) 
                                            ELSE wdetail.name_insur.
               /* comment by A61-0512 ....
                /*A60-0383*/
                IF      trim(wdetail.pol_title) = "นาย"     THEN ASSIGN  wdetail.pol_title = "คุณ".
                ELSE IF trim(wdetail.pol_title) = "นาง"     THEN ASSIGN  wdetail.pol_title = "คุณ".
                ELSE IF trim(wdetail.pol_title) = "น.ส."    THEN ASSIGN  wdetail.pol_title = "คุณ".
                ELSE IF trim(wdetail.pol_title) = "นางสาว"  THEN ASSIGN  wdetail.pol_title = "คุณ".
                /* end A60-0383*/
                .. end a61-0512...*/
            END.
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                tlt.cha_no       = trim(wdetail.chassis)   AND
                tlt.eng_no       = TRIM(wdetail.engine)    AND
                tlt.genusr       = fi_compa                AND 
                tlt.nor_noti_tlt = TRIM(wdetail.Notify_no) AND
                tlt.subins       = "V70"                   NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:    /*  kridtiya i. A54-0216 ....*/
               CREATE brstat.tlt.
                    nv_completecnt  =  nv_completecnt + 1.
                ASSIGN                                                 
                    tlt.entdat       =   TODAY                           /* วันที่โหลด */
                    tlt.enttim       =   STRING(TIME,"HH:MM:SS")         /* เวลาโหลด   */
                    tlt.trndat       =   fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */ 
                    tlt.rec_addr3    =   trim(wdetail.Pro_off)           /*เลขที่รับแจ้งและสาขา       */  
                    tlt.nor_noti_tlt =   trim(wdetail.Notify_no)         /*เลขที่รับแจ้ง              */  
                    tlt.exp          =   trim(wdetail.branch)            /*สาขา                       */  
                    tlt.safe2        =   trim(wdetail.Account_no)        /*เลขที่สัญญา                */  
                    tlt.filler1      =   nv_oldpol                       /*เลขที่กรมธรรม์เดิม         */  
                    tlt.rec_addr4    =   trim(wdetail.company)           /*บริษัทประกันเก่า           */
                    tlt.rec_name     =   trim(wdetail.pol_title)         /*คำนำหน้าชื่อผู้เอาประกันภัย */ 
                    tlt.ins_name     =   trim(wdetail.pol_fname)          /*ชื่อผู้เอาประกันภัย        */  
                    tlt.safe1        =   trim(wdetail.ben_name)          /*ผู้รับผลประโยชน์           */  
                    tlt.gendat       =   nv_comdat                       /*วันที่เริ่มคุ้มครอง        */  
                    tlt.expodat      =   nv_expdat                       /*วันที่สิ้นสุดคุ้มครอง      */  
                    /*tlt.comp_effdat  =   nv_comdat72 */                    /*วันทีเริ่มคุ้มครองพรบ      */  
                    /*tlt.nor_effdat   =   nv_expdat72*/                     /*วันที่สิ้นสุดคุ้มครองพรบ   */  
                    tlt.lince1       =   trim(wdetail.licence)           /*เลขทะเบียน                 */  
                    tlt.lince3       =   trim(wdetail.province)          /*จังหวัด                    */  
                    tlt.nor_coamt    =   nv_insamt3                      /*ทุนประกัน                  */  
                    tlt.nor_grprm    =   DECI(wdetail.prem1)             /*เบี้ยประกันรวม             */  
                    /*tlt.comp_grprm   =   DECI(wdetail.comp_prm) */         /*เบี้ยพรบรวม                */  
                    tlt.comp_coamt   =   DECI(wdetail.gross_prm)         /*เบี้ยรวม                   */  
                    /*tlt.comp_pol     =   trim(wdetail.compno)*/            /*เลขกรมธรรม์พรบ             */  
                    tlt.comp_sck     =   trim(wdetail.sckno)             /*เลขที่สติ๊กเกอร์           */  
                    tlt.comp_usr_tlt =   trim(wdetail.not_code)          /*รหัสผู้แจ้ง                */  
                    tlt.filler2      =   trim(wdetail.remark)            /*หมายเหตุ                   */  
                    tlt.datesent     =   nv_notdat                       /*วันที่รับแจ้ง              */  
                    tlt.nor_usr_tlt  =   trim(wdetail.not_office)        /*ชื่อประกันภัย              */  
                    tlt.nor_usr_ins  =   trim(wdetail.not_name)          /*ผู้แจ้ง                    */  
                    tlt.brand        =   trim(wdetail.brand)             /*ยี่ห้อ                     */  
                    tlt.model        =   trim(wdetail.Brand_Model)       /*รุ่น                       */  
                    tlt.lince2       =   trim(wdetail.yrmanu)            /*ปี                         */  
                    tlt.cc_weight    =   INTEGER(wdetail.weight)         /*ขนาดเครื่อง                */  
                    tlt.eng_no       =   trim(wdetail.engine)            /*เลขเครื่อง                 */  
                    tlt.cha_no       =   trim(wdetail.chassis)           /*เลขถัง                     */  
                    tlt.old_cha      =   trim(wdetail.pattern)           /*Pattern Rate               */  
                    tlt.expousr      =   trim(wdetail.covcod)            /*ประเภทประกัน               */  
                    tlt.old_eng      =   trim(wdetail.vehuse)            /*ประเภทรถ                   */  
                    tlt.stat         =   trim(wdetail.garage)            /*สถานที่ซ่อม                */  
                    SUBSTR(tlt.dri_name1,1,60)   =   trim(wdetail.drivename1)        /*ระบุผู้ขับขี้1             */  
                    SUBSTR(tlt.dri_name1,61,20)  =   trim(wdetail.driveid1)          /*เลขที่ใบขับขี่1            */  
                    SUBSTR(tlt.dri_name1,81,20)  =   trim(wdetail.driveic1)          /*เลขที่บัตรประชาชน1         */  
                    tlt.dri_no1                  =   trim(wdetail.drivedate1)        /*วันเดือนปีเกิด1            */  
                    SUBSTR(tlt.dri_name2,1,60)   =   trim(wdetail.drivname2)         /*ระบุผู้ขับขี้2             */  
                    substr(tlt.dri_name2,61,20)  =   trim(wdetail.driveid2)          /*เลขที่ใบขับขี่2            */  
                    substr(tlt.dri_name2,81,20)  =   trim(wdetail.driveic2)          /*เลขที่บัตรประชาชน2         */  
                    tlt.dri_no2         = trim(wdetail.drivedate2)        /*วันเดือนปีเกิด2            */  
                    tlt.endno           = TRIM(wdetail.cl)                /*ส่วนลดประวัติเสีย          */  
                    tlt.lotno           = TRIM(wdetail.fleetper)          /*ส่วนลดกลุ่ม                */  
                    tlt.seqno           = INTEGER(wdetail.ncbper)         /*ประวัติดี                  */  
                    tlt.endcnt          = INTEGER(wdetail.othper)         /*อื่น ๆ                     */  
                    tlt.ins_addr1       = trim(wdetail.addr1)              /*ที่อยู่ลูกค้า              */ 
                    tlt.ins_addr2       = trim(wdetail.addr2) 
                    tlt.ins_addr3       = trim(wdetail.addr3) 
                    tlt.ins_addr4       = trim(wdetail.addr4) 
                    tlt.ins_addr5       = "IC:" + trim(wdetail.icno)  +             /*IDCARD                     */  
                                          " Comm:" + trim(wdetail.icno_st)  +        /*DateCARD_S                 */  
                                          " Exp:" + trim(wdetail.icno_ex)           /*DateCARD_E                 */  
                    tlt.safe3           = trim(wdetail.paid)              /*Type_Paid_1                */  
                    tlt.genusr          = "THANACHAT"                           
                    tlt.usrid           = USERID(LDBNAME(1))                 /*User Load Data */
                    tlt.imp             = "IM"                              /*Import Data*/
                    tlt.releas          = "No"
                    tlt.flag            = "R"
                    tlt.subins          = "V70"
                    tlt.recac           = ""
                    tlt.dat_ins_noti    = ? 
                    /*tlt.comp_sub        = fi_producer*/ /*A60-0383*/
                    /*...A64-0205....
                    tlt.comp_sub        = IF INDEX(wdetail.remark,"call1770") <> 0 OR INDEX(wdetail.remark,"CALL1770") <> 0 OR   /* A60-0383*/
                                             INDEX(wdetail.remark,"Call1770") <> 0    THEN "A0M0014" ELSE trim(fi_producer)     
                     tlt.comp_noti_ins   = "B3M0004"  
                     .... END : A64-0205....*/
                    /*-- A64-0205 --*/
                    tlt.comp_sub        = IF INDEX(wdetail.remark,"call1770") <> 0 OR INDEX(wdetail.remark,"CALL1770") <> 0 OR   
                                             INDEX(wdetail.remark,"Call1770") <> 0    THEN "B3MLTTB102" ELSE  trim(fi_producer)     /*A64-0278*/
                                             /*INDEX(wdetail.remark,"Call1770") <> 0    THEN "B3MLTMB102" ELSE  trim(fi_producer)*/ /*A64-0278*/
                    tlt.comp_noti_ins   = TRIM(fi_agent)  
                    /*-- end : A64-0205 --*/                             
                    tlt.rec_addr1       = TRIM(wdetail.remark2)  /*A60-0383 */
                    tlt.sentcnt         = INT(wdetail.loss)      /*A60-0383*/
                    tlt.rec_addr2       = ""                    /*A60-0382 */ /*campaing*/
                    tlt.rec_addr5       = "" .                  /* a61-0512  ISP no */

                 RUN proc_inspec. /*A64-0205*/

                /*IF wdetail.comdat72 <> "" AND wdetail.expdat72 <> "" AND wdetail.sckno <> "" THEN RUN proc_create_tlt72. --A59-0471--*/
                IF wdetail.comdat72 <> "" AND wdetail.expdat72 <> "" THEN RUN proc_create_tlt72.    /*--A59-0471--*/
            END.
            ELSE DO: 
                nv_completecnt  =  nv_completecnt + 1.
                RUN proc_Create_tlt2.
            END.
        END. 
    END.
    /*ELSE IF wdetail.comdat72 <> "" AND wdetail.expdat72 <> "" AND wdetail.sckno <> "" THEN RUN proc_create_tlt72. --A59-0471--*/
    ELSE IF wdetail.comdat72 <> "" AND wdetail.expdat72 <> "" THEN RUN proc_create_tlt72.  /*--A59-0471--*/
END. 
RELEASE brstat.tlt.
Run proc_Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Create_tlt2 C-Win 
PROCEDURE proc_Create_tlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN                                         
       tlt.entdat       =   TODAY                           /* วันที่โหลด */
       tlt.enttim       =   STRING(TIME,"HH:MM:SS")         /* เวลาโหลด   */
       tlt.trndat       =   fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */ 
       tlt.rec_addr3    =   trim(wdetail.Pro_off)           /*เลขที่รับแจ้งและสาขา       */  
       tlt.nor_noti_tlt =   trim(wdetail.Notify_no)         /*เลขที่รับแจ้ง              */  
       tlt.exp          =   trim(wdetail.branch)            /*สาขา                       */  
       tlt.safe2        =   trim(wdetail.Account_no)        /*เลขที่สัญญา                */  
       tlt.filler1      =   nv_oldpol                       /*เลขที่กรมธรรม์เดิม         */  
       tlt.rec_addr4    =   trim(wdetail.company)           /*บริษัทประกันเก่า           */
       tlt.rec_name     =   trim(wdetail.pol_title)         /*คำนำหน้าชื่อผู้เอาประกันภัย */ 
       tlt.ins_name     =   trim(wdetail.pol_fname)          /*ชื่อผู้เอาประกันภัย        */  
       tlt.safe1        =   trim(wdetail.ben_name)          /*ผู้รับผลประโยชน์           */  
       tlt.gendat       =   nv_comdat                       /*วันที่เริ่มคุ้มครอง        */  
       tlt.expodat      =   nv_expdat                       /*วันที่สิ้นสุดคุ้มครอง      */  
       /*tlt.comp_effdat  =   nv_comdat72  */                   /*วันทีเริ่มคุ้มครองพรบ      */  
       /*Tlt.nor_effdat   =   nv_expdat72 */                    /*วันที่สิ้นสุดคุ้มครองพรบ   */  
       tlt.lince1       =   trim(wdetail.licence)           /*เลขทะเบียน                 */  
       tlt.lince3       =   trim(wdetail.province)          /*จังหวัด                    */  
       tlt.nor_coamt    =   nv_insamt3                      /*ทุนประกัน                  */  
       tlt.nor_grprm    =   DECI(wdetail.prem1)             /*เบี้ยประกันรวม             */  
      /* tlt.comp_grprm   =   DECI(wdetail.comp_prm)          /*เบี้ยพรบรวม                */  */
       tlt.comp_coamt   =   DECI(wdetail.gross_prm)         /*เบี้ยรวม                   */  
       /*tlt.comp_pol     =   trim(wdetail.compno)*/            /*เลขกรมธรรม์พรบ             */  
       tlt.comp_sck     =   trim(wdetail.sckno)             /*เลขที่สติ๊กเกอร์           */  
       tlt.comp_usr_tlt =   trim(wdetail.not_code)          /*รหัสผู้แจ้ง                */  
       tlt.filler2      =   trim(wdetail.remark)            /*หมายเหตุ                   */  
       tlt.datesent     =   nv_notdat                       /*วันที่รับแจ้ง              */  
       tlt.nor_usr_tlt  =   trim(wdetail.not_office)        /*ชื่อประกันภัย              */  
       tlt.nor_usr_ins  =   trim(wdetail.not_name)          /*ผู้แจ้ง                    */  
       tlt.brand        =   trim(wdetail.brand)             /*ยี่ห้อ                     */  
       tlt.model        =   trim(wdetail.Brand_Model)       /*รุ่น                       */  
       tlt.lince2       =   trim(wdetail.yrmanu)            /*ปี                         */  
       tlt.cc_weight    =   INTEGER(wdetail.weight)         /*ขนาดเครื่อง                */  
       tlt.eng_no       =   trim(wdetail.engine)            /*เลขเครื่อง                 */  
       tlt.cha_no       =   trim(wdetail.chassis)           /*เลขถัง                     */  
       tlt.old_cha      =   trim(wdetail.pattern)           /*Pattern Rate               */  
       tlt.expousr      =   trim(wdetail.covcod)            /*ประเภทประกัน               */  
       tlt.old_eng      =   trim(wdetail.vehuse)            /*ประเภทรถ                   */  
       tlt.stat         =   trim(wdetail.garage)            /*สถานที่ซ่อม                */  
       SUBSTR(tlt.dri_name1,1,60)   =   trim(wdetail.drivename1)        /*ระบุผู้ขับขี้1             */  
       SUBSTR(tlt.dri_name1,61,20)  =   trim(wdetail.driveid1)          /*เลขที่ใบขับขี่1            */  
       SUBSTR(tlt.dri_name1,81,20)  =   trim(wdetail.driveic1)          /*เลขที่บัตรประชาชน1         */  
       tlt.dri_no1                  =   trim(wdetail.drivedate1)        /*วันเดือนปีเกิด1            */  
       SUBSTR(tlt.dri_name2,1,60)   =   trim(wdetail.drivname2)         /*ระบุผู้ขับขี้2             */  
       substr(tlt.dri_name2,61,20)  =   trim(wdetail.driveid2)          /*เลขที่ใบขับขี่2            */  
       substr(tlt.dri_name2,81,20)  =   trim(wdetail.driveic2)          /*เลขที่บัตรประชาชน2         */  
       tlt.dri_no2     =   trim(wdetail.drivedate2)        /*วันเดือนปีเกิด2            */  
       tlt.endno       =   TRIM(wdetail.cl)                /*ส่วนลดประวัติเสีย          */  
       tlt.lotno       =   TRIM(wdetail.fleetper)          /*ส่วนลดกลุ่ม                */  
       tlt.seqno       =   INTEGER(wdetail.ncbper)         /*ประวัติดี                  */  
       tlt.endcnt      =   INTEGER(wdetail.othper)         /*อื่น ๆ                     */  
       tlt.ins_addr1   =   trim(wdetail.addr1)             /*ที่อยู่ลูกค้า              */ 
       tlt.ins_addr2   =   trim(wdetail.addr2)             
       tlt.ins_addr3   =   trim(wdetail.addr3)             
       tlt.ins_addr4   =   trim(wdetail.addr4)             
       tlt.ins_addr5   =   "IC:" + trim(wdetail.icno) +      /*IDCARD                     */  
                           " Comm:" + trim(wdetail.icno_st) +  /*DateCARD_S                 */  
                           " Exp:" + trim(wdetail.icno_ex)  /*DateCARD_E                 */  
       tlt.safe3       =   trim(wdetail.paid)              /*Type_Paid_1                */  
       tlt.genusr      =   "THANACHAT"                     
       tlt.usrid       =   USERID(LDBNAME(1))              /*User Load Data */
       tlt.imp         =   "IM"                            /*Import Data*/
       tlt.releas      =   "No"
       tlt.flag        =   "R"
       tlt.subins      =   "V70"
       tlt.recac        = ""  
       tlt.dat_ins_noti =  ?  
       /*tlt.comp_sub    =  fi_producer*/ /*A60-0383*/
       /*...A64-0205....
       tlt.comp_sub        = IF INDEX(wdetail.remark,"call1770") <> 0 OR INDEX(wdetail.remark,"CALL1770") <> 0 OR   /* A60-0383*/
                                INDEX(wdetail.remark,"Call1770") <> 0    THEN "A0M0014" ELSE trim(fi_producer)     
        tlt.comp_noti_ins   = "B3M0004"  
        .... END : A64-0205....*/
       /*-- A64-0205 --*/
       tlt.comp_sub        = IF INDEX(wdetail.remark,"call1770") <> 0 OR INDEX(wdetail.remark,"CALL1770") <> 0 OR 
                                INDEX(wdetail.remark,"Call1770") <> 0    THEN "B3MLTTB102" ELSE  trim(fi_producer)      /*A64-0278*/
                                /*INDEX(wdetail.remark,"Call1770") <> 0    THEN "B3MLTMB102" ELSE  trim(fi_producer)*/  /*A64-0278*/
       tlt.comp_noti_ins   = TRIM(fi_agent)  
       /*-- end : A64-0205 --*/ 
       tlt.rec_addr1     = TRIM(wdetail.remark2)  /*A60-0382 */
       tlt.sentcnt       = INT(wdetail.loss)      /*A60-0383*/
       tlt.rec_addr2     = ""                    /*A60-0382 */ /*campaing*/
       tlt.rec_addr5     = "" .                  /* a61-0512  ISP no */

      RUN proc_inspec. /*A64-0205*/

 /*IF wdetail.comdat72 <> "" AND wdetail.expdat72 <> "" AND wdetail.sckno <> "" THEN RUN proc_create_tlt72.  --A59-0471--*/
 IF wdetail.comdat72 <> "" AND wdetail.expdat72 <> "" THEN RUN proc_create_tlt72.    /*--A59-0471--*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt2_72 C-Win 
PROCEDURE proc_create_tlt2_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN                                                 
         tlt.entdat       =   TODAY                           /* วันที่โหลด */
         tlt.enttim       =   STRING(TIME,"HH:MM:SS")         /* เวลาโหลด   */
         tlt.trndat       =   fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */ 
         tlt.rec_addr3    =   trim(wdetail.Pro_off)           /*เลขที่รับแจ้งและสาขา       */  
         tlt.nor_noti_tlt =   trim(wdetail.Notify_no)         /*เลขที่รับแจ้ง              */  
         tlt.exp          =   trim(wdetail.branch)            /*สาขา                       */  
         tlt.safe2        =   trim(wdetail.Account_no)        /*เลขที่สัญญา                */  
         tlt.filler1      =   nv_oldpol                       /*เลขที่กรมธรรม์เดิม         */  
         tlt.rec_addr4    =   trim(wdetail.company)           /*บริษัทประกันเก่า           */
         tlt.rec_name     =   trim(wdetail.pol_title)         /*คำนำหน้าชื่อผู้เอาประกันภัย */ 
         tlt.ins_name     =   trim(wdetail.pol_fname)          /*ชื่อผู้เอาประกันภัย        */  
         tlt.safe1        =   trim(wdetail.ben_name)          /*ผู้รับผลประโยชน์           */  
         /*tlt.gendat       =   nv_comdat*/                       /*วันที่เริ่มคุ้มครอง        */  
         /*tlt.expodat      =   nv_expdat */                      /*วันที่สิ้นสุดคุ้มครอง      */  
         tlt.comp_effdat  =   nv_comdat72                     /*วันทีเริ่มคุ้มครองพรบ      */  
         tlt.nor_effdat   =   nv_expdat72                     /*วันที่สิ้นสุดคุ้มครองพรบ   */  
         tlt.lince1       =   trim(wdetail.licence)           /*เลขทะเบียน                 */  
         tlt.lince3       =   trim(wdetail.province)          /*จังหวัด                    */  
         /*tlt.nor_coamt    =   nv_insamt3 */                     /*ทุนประกัน                  */  
         /*tlt.nor_grprm    =   DECI(wdetail.prem1) */            /*เบี้ยประกันรวม             */  
         tlt.comp_grprm   =   DECI(wdetail.comp_prm)          /*เบี้ยพรบรวม                */  
         tlt.comp_coamt   =   DECI(wdetail.gross_prm)         /*เบี้ยรวม                   */  
         tlt.comp_pol     =   trim(wdetail.compno)            /*เลขกรมธรรม์พรบ             */  
         tlt.comp_sck     =   trim(wdetail.sckno)             /*เลขที่สติ๊กเกอร์           */  
         tlt.comp_usr_tlt =   trim(wdetail.not_code)          /*รหัสผู้แจ้ง                */  
         tlt.filler2      =   trim(wdetail.remark)            /*หมายเหตุ                   */  
         tlt.datesent     =   nv_notdat                       /*วันที่รับแจ้ง              */  
         tlt.nor_usr_tlt  =   trim(wdetail.not_office)        /*ชื่อประกันภัย              */  
         tlt.nor_usr_ins  =   trim(wdetail.not_name)          /*ผู้แจ้ง                    */  
         tlt.brand        =   trim(wdetail.brand)             /*ยี่ห้อ                     */  
         tlt.model        =   trim(wdetail.Brand_Model)       /*รุ่น                       */  
         tlt.lince2       =   trim(wdetail.yrmanu)            /*ปี                         */  
         tlt.cc_weight    =   INTEGER(wdetail.weight)         /*ขนาดเครื่อง                */  
         tlt.eng_no       =   trim(wdetail.engine)            /*เลขเครื่อง                 */  
         tlt.cha_no       =   trim(wdetail.chassis)           /*เลขถัง                     */  
         tlt.old_cha      =   trim(wdetail.pattern)           /*Pattern Rate               */  
         tlt.expousr      =   trim(wdetail.covcod)            /*ประเภทประกัน               */  
         tlt.old_eng      =   trim(wdetail.vehuse)            /*ประเภทรถ                   */  
         /*tlt.stat         =   trim(wdetail.garage) */           /*สถานที่ซ่อม                */  
         /*SUBSTR(tlt.dri_name1,1,60)   =   trim(wdetail.drivename1)*/        /*ระบุผู้ขับขี้1             */  
         /*SUBSTR(tlt.dri_name1,61,20)  =   trim(wdetail.driveid1)  */        /*เลขที่ใบขับขี่1            */  
         /*SUBSTR(tlt.dri_name1,81,20)  =   trim(wdetail.driveic1)  */        /*เลขที่บัตรประชาชน1         */  
         /*tlt.dri_no1                  =   trim(wdetail.drivedate1)*/        /*วันเดือนปีเกิด1            */  
         /*SUBSTR(tlt.dri_name2,1,60)   =   trim(wdetail.drivname2) */        /*ระบุผู้ขับขี้2             */  
         /*substr(tlt.dri_name2,61,20)  =   trim(wdetail.driveid2)  */        /*เลขที่ใบขับขี่2            */  
         /*substr(tlt.dri_name2,81,20)  =   trim(wdetail.driveic2)  */        /*เลขที่บัตรประชาชน2         */  
         /*tlt.dri_no2     =   trim(wdetail.drivedate2) */       /*วันเดือนปีเกิด2            */  
         /* tlt.endno       =   TRIM(wdetail.cl)        */        /*ส่วนลดประวัติเสีย          */  
         /* tlt.lotno       =   TRIM(wdetail.fleetper)  */        /*ส่วนลดกลุ่ม                */  
         /* tlt.seqno       =   INTEGER(wdetail.ncbper) */        /*ประวัติดี                  */  
         /* tlt.endcnt      =   INTEGER(wdetail.othper) */        /*อื่น ๆ                     */  
         tlt.ins_addr1   =   trim(wdetail.addr1)              /*ที่อยู่ลูกค้า              */ 
         tlt.ins_addr2   =   trim(wdetail.addr2) 
         tlt.ins_addr3   =   trim(wdetail.addr3) 
         tlt.ins_addr4   =   trim(wdetail.addr4) 
         tlt.ins_addr5   =   "IC:" + trim(wdetail.icno)  +             /*IDCARD                     */  
                             " Comm:" + trim(wdetail.icno_st)  +        /*DateCARD_S                 */  
                             " Exp:" + trim(wdetail.icno_ex)           /*DateCARD_E                 */  
         tlt.safe3       =   trim(wdetail.paid)              /*Type_Paid_1                */  
         tlt.genusr      =   "THANACHAT"                           
         tlt.usrid       =   USERID(LDBNAME(1))                 /*User Load Data */
         tlt.imp         =   "IM"                              /*Import Data*/
         tlt.releas      =   "No"
         tlt.flag        =   "R"  /*ต่ออายุ*/
         tlt.subins      =   "V72"
         tlt.recac        = ""  
         tlt.dat_ins_noti =  ?  
         /*tlt.comp_sub    =  fi_producer */ /*A60-0383*/
         /*...A64-0205....
         tlt.comp_sub        = IF INDEX(wdetail.remark,"call1770") <> 0 OR INDEX(wdetail.remark,"CALL1770") <> 0 OR   /* A60-0383*/
                                 INDEX(wdetail.remark,"Call1770") <> 0    THEN "A0M0014" ELSE trim(fi_producer)     
         tlt.comp_noti_ins   = "B3M0004"  
         .... END : A64-0205....*/
         /*-- A64-0205 --*/
         tlt.comp_sub        = IF INDEX(wdetail.remark,"call1770") <> 0 OR INDEX(wdetail.remark,"CALL1770") <> 0 OR  
                                  INDEX(wdetail.remark,"Call1770") <> 0    THEN "B3MLTTB102" ELSE  trim(fi_producer)
                                  /*INDEX(wdetail.remark,"Call1770") <> 0    THEN "B3MLTMB102" ELSE  trim(fi_producer)*/ /*A64-0278*/
         tlt.comp_noti_ins   = TRIM(fi_agent)  
         /*-- end : A64-0205 --*/ 
         tlt.rec_addr1     = TRIM(wdetail.remark2)  /* A60-0383*/
         tlt.sentcnt       = INT(wdetail.loss)      /*A60-0383*/
         tlt.rec_addr2     = ""                    /*A60-0382 */ /*campaing*/
         tlt.rec_addr5     = "" .                  /* a61-0512  ISP no */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt72 C-Win 
PROCEDURE proc_create_tlt72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS INT INIT 0.
  ASSIGN   
            nv_comdat72  = ?    nv_expdat72  = ?    nv_accdat  =  ?
            nv_comchr  = ""     nv_addr    = ""     nv_name1   =  ""     
            nv_ntitle  = ""     nv_titleno = 0      nv_policy  =  ""
            nv_dd      = 0      nv_mm      = 0      nv_yy      =  0
            nv_cpamt1  = 0      nv_cpamt2  = 0      nv_cpamt3  =  0
            nv_coamt1  = 0      nv_coamt2  = 0      nv_coamt3  =  0         
            nv_insamt1 = 0      nv_insamt2 = 0      nv_insamt3 =  0
            nv_premt1  = 0      nv_premt2  = 0      nv_premt3  =  0
            nv_ncb1    = 0      nv_ncb2    = 0      nv_ncb3    =  0
            nv_fleet1  = 0      nv_fleet2  = 0      nv_fleet3  =  0
            nv_oth1    = 0      nv_oth2    = 0      nv_oth3    =  0
            nv_deduct1 = 0      nv_deduct2 = 0      nv_deduct3 =  0
            nv_power1  = 0      nv_power2  = 0      nv_power3  =  0
            nv_newpol  = ""     nv_reccnt  = nv_reccnt + 1
            wdetail.engine = REPLACE(wdetail.engine,"*","").
        IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    /* A56-0399 */
        ELSE ASSIGN nn_remark1  = trim(wdetail.remark)
            nn_remark2  = ""
            nn_remark3 = "".
        
        IF ( wdetail.Notify_no = "" ) THEN 
            MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
        ELSE DO:
            /* ------------------------check policy  Duplicate--------------------------------------*/ 
            IF wdetail.prev_pol <> "" THEN RUN pol_cutchar.
                nv_oldpol  =  wdetail.prev_pol.
                
            IF (wdetail.not_date  <> "" ) THEN ASSIGN  nv_notdat  = DATE(wdetail.not_date).
            ELSE ASSIGN  nv_notdat  = ?.

           /* IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat  = DATE(wdetail.comdat).
            ELSE ASSIGN nv_comdat = ?.

            IF (wdetail.expdat <>  "" ) THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
            ELSE ASSIGN nv_expdat  = ?.*/
        
            IF (wdetail.comdat72 <>  "" ) THEN ASSIGN nv_comdat72  = DATE(wdetail.comdat72). 
            ELSE ASSIGN nv_comdat72 = ?.

            IF (wdetail.expdat72 <>  "" ) THEN ASSIGN nv_expdat72  = DATE(wdetail.expdat72).
            ELSE ASSIGN nv_expdat72 = ?.
        
            /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- 
            nv_insamt3 = DECIMAL(wdetail.ins_amt).   /* by: kridtiya i. A54-0061.. */*/
            /* -------------------------- PREM1 CHR(11)   เบี้ยภาคสมัครใจบวกภาษีบวกอากร --- */
            /*nv_premt1 = DECIMAL(SUBSTRING(wdetail.prem1,1,9)).
            IF nv_premt1 < 0 THEN
                nv_premt2 = (DECIMAL(SUBSTRING(wdetail.prem1,10,2)) * -1) / 100.
            ELSE
                nv_premt2 = DECIMAL(SUBSTRING(wdetail.prem1,10,2)) / 100.
            nv_premt3 = nv_premt1 + nv_premt2.*/
            /* --------------------------------------------- COMP_PEM CHR(09)  เบี้ยพรบ.รวม --- */
            nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  
            /* -------------------------- GROSS_PRM CHR(11)   เบี้ยรวมภาคสมัครใจบวกเบี้ยรวม พรบ. --- */
            nv_coamt1 = DECIMAL(SUBSTRING(wdetail.gross_prm,1,9)).
            IF nv_coamt1 < 0 THEN
                nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) * -1) / 100.
            ELSE
                nv_coamt2 = DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) / 100.
            nv_coamt3 = nv_coamt1 + nv_coamt2.
           /* /* ----------------------FLEET_DISC. ส่วนลดกลุ่ม  / เปอร์เซ็นต์ --- */
            nv_fleet1 = DECIMAL(SUBSTRING(wdetail.fleetper,1,3)).
            IF nv_fleet1 < 0 THEN
                nv_fleet2 = (DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) * -1) / 100.
            ELSE
                nv_fleet2 = DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) / 100.
            nv_fleet3 = nv_fleet1 + nv_fleet2.
            /*Message "fleet"  wdetail.fleetper   nv_fleet3.*/
            /* ----------------------NCB_DISC. ส่วนลดประวัติดี  / เปอร์เซ็นต์ --- */
            nv_ncb1 = DECIMAL(SUBSTRING(wdetail.ncbper,1,3)).
            IF nv_ncb1 < 0 THEN
                nv_ncb2 = (DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) * -1) / 100.
            ELSE
                nv_ncb2 = DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) / 100.
            nv_ncb3 = nv_ncb1 + nv_ncb2.
            /* ----------------------OTH_DISC. ส่วนลดอื่น ๆ  / เปอร์เซ็นต์ --- */
            nv_oth1 = DECIMAL(SUBSTRING(wdetail.othper,1,3)).
            IF nv_oth1 < 0 THEN
                nv_oth2 = (DECIMAL(SUBSTRING(wdetail.othper,4,2)) * -1) / 100.
            ELSE
                nv_oth2 = DECIMAL(SUBSTRING(wdetail.othper,4,2)) / 100.
            nv_oth3 = nv_oth1 + nv_oth2.
            /*-----------------------------------------------------------------*/*/
            IF LENGTH(trim(wdetail.icno)) < 13 THEN wdetail.remark2 = wdetail.remark2 + " /เลขบัตรประชาชนไม่ครบ 13 หลัก " . /*A60-0383*/
            IF TRIM(wdetail.pol_addr1) <> " " THEN RUN proc_address.
            IF TRIM(wdetail.name_insur) <> " " THEN DO:
                ASSIGN n = 0
                       wdetail.name_insur = TRIM(wdetail.name_insur)
                       wdetail.pol_title  = IF INDEX(wdetail.name_insur," ") <> 0 THEN SUBSTR(wdetail.name_insur,1,INDEX(wdetail.name_insur," ")) ELSE ""
                       n = LENGTH(wdetail.name_insur) - LENGTH(wdetail.pol_title)                
                       wdetail.pol_fname  = IF INDEX(wdetail.name_insur," ") <> 0 THEN SUBSTR(wdetail.name_insur,INDEX(wdetail.name_insur," "), n + 1 ) 
                                            ELSE wdetail.name_insur.
                /* comment by A61-0512...
                /*A60-0383*/
                IF      trim(wdetail.pol_title) = "นาย"     THEN ASSIGN  wdetail.pol_title = "คุณ".
                ELSE IF trim(wdetail.pol_title) = "นาง"     THEN ASSIGN  wdetail.pol_title = "คุณ".
                ELSE IF trim(wdetail.pol_title) = "น.ส."    THEN ASSIGN  wdetail.pol_title = "คุณ".
                ELSE IF trim(wdetail.pol_title) = "นางสาว"  THEN ASSIGN  wdetail.pol_title = "คุณ".
                /* end A60-0383*/
                ....end a61-0512....*/
            END.
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                tlt.cha_no       = trim(wdetail.chassis)    AND
                tlt.eng_no       = TRIM(wdetail.engine)     AND
                tlt.genusr       = fi_compa                 AND 
                tlt.nor_noti_tlt = TRIM(wdetail.Notify_no)  AND
                tlt.subins       = "V72"      NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:    /*  kridtiya i. A54-0216 ....*/
               CREATE brstat.tlt.
                    nv_completecnt  =  nv_completecnt + 1.
                ASSIGN                                                 
                    tlt.entdat       =   TODAY                           /* วันที่โหลด */
                    tlt.enttim       =   STRING(TIME,"HH:MM:SS")         /* เวลาโหลด   */
                    tlt.trndat       =   fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */ 
                    tlt.rec_addr3    =   trim(wdetail.Pro_off)           /*เลขที่รับแจ้งและสาขา       */  
                    tlt.nor_noti_tlt =   trim(wdetail.Notify_no)         /*เลขที่รับแจ้ง              */  
                    tlt.exp          =   trim(wdetail.branch)            /*สาขา                       */  
                    tlt.safe2        =   trim(wdetail.Account_no)        /*เลขที่สัญญา                */  
                    tlt.filler1      =   nv_oldpol                       /*เลขที่กรมธรรม์เดิม         */  
                    tlt.rec_addr4    =   trim(wdetail.company)           /*บริษัทประกันเก่า           */
                    tlt.rec_name     =   trim(wdetail.pol_title)         /*คำนำหน้าชื่อผู้เอาประกันภัย */ 
                    tlt.ins_name     =   trim(wdetail.pol_fname)          /*ชื่อผู้เอาประกันภัย        */  
                    tlt.safe1        =   trim(wdetail.ben_name)          /*ผู้รับผลประโยชน์           */  
                    /*tlt.gendat       =   nv_comdat*/                       /*วันที่เริ่มคุ้มครอง        */  
                    /*tlt.expodat      =   nv_expdat */                      /*วันที่สิ้นสุดคุ้มครอง      */  
                    tlt.comp_effdat  =   nv_comdat72                     /*วันทีเริ่มคุ้มครองพรบ      */  
                    tlt.nor_effdat   =   nv_expdat72                     /*วันที่สิ้นสุดคุ้มครองพรบ   */  
                    tlt.lince1       =   trim(wdetail.licence)           /*เลขทะเบียน                 */  
                    tlt.lince3       =   trim(wdetail.province)          /*จังหวัด                    */  
                    /*tlt.nor_coamt    =   nv_insamt3 */                     /*ทุนประกัน                  */  
                    /*tlt.nor_grprm    =   DECI(wdetail.prem1) */            /*เบี้ยประกันรวม             */  
                    tlt.comp_grprm   =   DECI(wdetail.comp_prm)          /*เบี้ยพรบรวม                */  
                    tlt.comp_coamt   =   DECI(wdetail.gross_prm)         /*เบี้ยรวม                   */  
                    tlt.comp_pol     =   trim(wdetail.compno)            /*เลขกรมธรรม์พรบ             */  
                    tlt.comp_sck     =   trim(wdetail.sckno)             /*เลขที่สติ๊กเกอร์           */  
                    tlt.comp_usr_tlt =   trim(wdetail.not_code)          /*รหัสผู้แจ้ง                */  
                    tlt.filler2      =   trim(wdetail.remark)            /*หมายเหตุ                   */  
                    tlt.datesent     =   nv_notdat                       /*วันที่รับแจ้ง              */  
                    tlt.nor_usr_tlt  =   trim(wdetail.not_office)        /*ชื่อประกันภัย              */  
                    tlt.nor_usr_ins  =   trim(wdetail.not_name)          /*ผู้แจ้ง                    */  
                    tlt.brand        =   trim(wdetail.brand)             /*ยี่ห้อ                     */  
                    tlt.model        =   trim(wdetail.Brand_Model)       /*รุ่น                       */  
                    tlt.lince2       =   trim(wdetail.yrmanu)            /*ปี                         */  
                    tlt.cc_weight    =   INTEGER(wdetail.weight)         /*ขนาดเครื่อง                */  
                    tlt.eng_no       =   trim(wdetail.engine)            /*เลขเครื่อง                 */  
                    tlt.cha_no       =   trim(wdetail.chassis)           /*เลขถัง                     */  
                    tlt.old_cha      =   trim(wdetail.pattern)           /*Pattern Rate               */  
                    tlt.expousr      =   trim(wdetail.covcod)            /*ประเภทประกัน               */  
                    tlt.old_eng      =   trim(wdetail.vehuse)            /*ประเภทรถ                   */  
                    /*tlt.stat         =   trim(wdetail.garage) */           /*สถานที่ซ่อม                */  
                    /*SUBSTR(tlt.dri_name1,1,60)   =   trim(wdetail.drivename1)*/        /*ระบุผู้ขับขี้1             */  
                    /*SUBSTR(tlt.dri_name1,61,20)  =   trim(wdetail.driveid1)  */        /*เลขที่ใบขับขี่1            */  
                    /*SUBSTR(tlt.dri_name1,81,20)  =   trim(wdetail.driveic1)  */        /*เลขที่บัตรประชาชน1         */  
                    /*tlt.dri_no1                  =   trim(wdetail.drivedate1)*/        /*วันเดือนปีเกิด1            */  
                    /*SUBSTR(tlt.dri_name2,1,60)   =   trim(wdetail.drivname2) */        /*ระบุผู้ขับขี้2             */  
                    /*substr(tlt.dri_name2,61,20)  =   trim(wdetail.driveid2)  */        /*เลขที่ใบขับขี่2            */  
                    /*substr(tlt.dri_name2,81,20)  =   trim(wdetail.driveic2)  */        /*เลขที่บัตรประชาชน2         */  
                    /*tlt.dri_no2     =   trim(wdetail.drivedate2) */       /*วันเดือนปีเกิด2            */  
                    /* tlt.endno       =   TRIM(wdetail.cl)        */        /*ส่วนลดประวัติเสีย          */  
                    /* tlt.lotno       =   TRIM(wdetail.fleetper)  */        /*ส่วนลดกลุ่ม                */  
                    /* tlt.seqno       =   INTEGER(wdetail.ncbper) */        /*ประวัติดี                  */  
                    /* tlt.endcnt      =   INTEGER(wdetail.othper) */        /*อื่น ๆ                     */  
                    tlt.ins_addr1   =   trim(wdetail.addr1)              /*ที่อยู่ลูกค้า              */ 
                    tlt.ins_addr2   =   trim(wdetail.addr2) 
                    tlt.ins_addr3   =   trim(wdetail.addr3) 
                    tlt.ins_addr4   =   trim(wdetail.addr4) 
                    tlt.ins_addr5   =   "IC:" + trim(wdetail.icno)  +             /*IDCARD                     */  
                                        " Comm:" + trim(wdetail.icno_st)  +        /*DateCARD_S                 */  
                                        " Exp:" + trim(wdetail.icno_ex)           /*DateCARD_E                 */  
                    tlt.safe3       =   trim(wdetail.paid)              /*Type_Paid_1                */  
                    tlt.genusr      =   "THANACHAT"                           
                    tlt.usrid       =   USERID(LDBNAME(1))                 /*User Load Data */
                    tlt.imp         =   "IM"                              /*Import Data*/
                    tlt.releas      =   "No"
                    tlt.flag        =   "R" /*ต่ออายุ*/
                    tlt.subins      =   "V72"
                    tlt.recac        = ""  
                    tlt.dat_ins_noti =  ?  
                    /*tlt.comp_sub    =  fi_producer*/  /*A60-0383*/
                    /*...A64-0205....
                    tlt.comp_sub        = IF INDEX(wdetail.remark,"call1770") <> 0 OR INDEX(wdetail.remark,"CALL1770") <> 0 OR   /* A60-0383*/
                                             INDEX(wdetail.remark,"Call1770") <> 0    THEN "A0M0014" ELSE trim(fi_producer)     
                     tlt.comp_noti_ins   = "B3M0004"  
                     .... END : A64-0205....*/
                    /*-- A64-0205 --*/
                    tlt.comp_sub        = IF INDEX(wdetail.remark,"call1770") <> 0 OR INDEX(wdetail.remark,"CALL1770") <> 0 OR
                                             INDEX(wdetail.remark,"Call1770") <> 0    THEN "B3MLTTB102" ELSE  trim(fi_producer)     /*A64-0278*/
                                             /*INDEX(wdetail.remark,"Call1770") <> 0    THEN "B3MLTMB102" ELSE  trim(fi_producer)*/ /*A64-0278*/
                    tlt.comp_noti_ins   = TRIM(fi_agent)  
                    /*-- end : A64-0205 --*/ 
                    tlt.rec_addr1    = TRIM(wdetail.remark2)  /*A60-0383*/
                    tlt.sentcnt      = INT(wdetail.loss)      /*A60-0383*/
                    tlt.rec_addr2    = ""                    /*A60-0382 */ /*campaing*/
                    tlt.rec_addr5    = "" .                  /* a61-0512  ISP no */
            END.
            ELSE DO: 
                nv_completecnt  =  nv_completecnt + 1.
                RUN proc_Create_tlt2_72.
            END.
        END. 
        RELEASE brstat.tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt72N C-Win 
PROCEDURE proc_create_tlt72N :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A63-0174      
------------------------------------------------------------------------------*/
DEF VAR n AS INT INIT 0.
  ASSIGN   
            nv_comdat72  = ?    nv_expdat72  = ?    nv_accdat  =  ?
            nv_comchr  = ""     nv_addr    = ""     nv_name1   =  ""     
            nv_ntitle  = ""     nv_titleno = 0      nv_policy  =  ""
            nv_dd      = 0      nv_mm      = 0      nv_yy      =  0
            nv_cpamt1  = 0      nv_cpamt2  = 0      nv_cpamt3  =  0
            nv_coamt1  = 0      nv_coamt2  = 0      nv_coamt3  =  0         
            nv_insamt1 = 0      nv_insamt2 = 0      nv_insamt3 =  0
            nv_premt1  = 0      nv_premt2  = 0      nv_premt3  =  0
            nv_ncb1    = 0      nv_ncb2    = 0      nv_ncb3    =  0
            nv_fleet1  = 0      nv_fleet2  = 0      nv_fleet3  =  0
            nv_oth1    = 0      nv_oth2    = 0      nv_oth3    =  0
            nv_deduct1 = 0      nv_deduct2 = 0      nv_deduct3 =  0
            nv_power1  = 0      nv_power2  = 0      nv_power3  =  0
            nv_newpol  = ""     nv_reccnt  = nv_reccnt + 1
            wdetail.engine = REPLACE(wdetail.engine,"*","").
        IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    /* A56-0399 */
        ELSE ASSIGN nn_remark1  = trim(wdetail.remark)
            nn_remark2  = ""
            nn_remark3 = "".

        IF ( wdetail.Notify_no = "" ) THEN 
            MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
        ELSE DO:
            /* ------------------------check policy  Duplicate--------------------------------------*/ 
            RUN pol_cutchar.

            IF (wdetail.not_date  <> "" ) THEN ASSIGN  nv_notdat  = DATE(wdetail.not_date).
            ELSE ASSIGN  nv_notdat  = ?.

            IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat72  = DATE(wdetail.comdat).
            ELSE ASSIGN nv_comdat72 = ?.

            IF (wdetail.expdat <>  "" ) THEN ASSIGN nv_expdat72  = DATE(wdetail.expdat).
            ELSE ASSIGN nv_expdat72  = ?.
           /*-----------------------------------------------------------------*/
            IF LENGTH(trim(wdetail.icno)) < 13 THEN wdetail.remark2 = wdetail.remark2 + " /เลขบัตรประชาชนไม่ครบ 13 หลัก " . /*A60-0383*/
            /*IF TRIM(wdetail.pol_addr1) <> " " THEN RUN proc_address.*/
            IF TRIM(wdetail.name_insur) <> " " THEN DO:
                ASSIGN n = 0
                       wdetail.name_insur = TRIM(wdetail.name_insur)
                       wdetail.pol_title  = IF INDEX(wdetail.name_insur," ") <> 0 THEN 
                                               trim(SUBSTR(wdetail.name_insur,1,INDEX(wdetail.name_insur," "))) ELSE ""
                       n = LENGTH(wdetail.name_insur) - LENGTH(wdetail.pol_title)                
                       wdetail.pol_lname  = IF INDEX(wdetail.name_insur," ") <> 0 THEN 
                                               trim(SUBSTR(wdetail.name_insur,INDEX(wdetail.name_insur," "), n + 1 )) 
                                            ELSE trim(wdetail.name_insur).
            END.
            IF INDEX(wdetail.pol_title," ") = 0 THEN DO:
                FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno  = "999" AND
                           INDEX(trim(wdetail.pol_title),brstat.msgcode.MsgDesc) <> 0   NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAIL brstat.msgcode THEN DO:  
                         ASSIGN  wdetail.pol_fname  =  REPLACE(wdetail.pol_title,brstat.msgcode.MsgDesc,"")
                                 wdetail.pol_title  =  trim(brstat.msgcode.branch).
                                
                     END.
                     ELSE  ASSIGN wdetail.pol_fname  = TRIM(wdetail.pol_title) .
            END.
            ASSIGN wdetail.pol_fname = TRIM(wdetail.pol_fname) + " " + TRIM(wdetail.pol_lname) .

            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE        
                      tlt.cha_no       = trim(wdetail.chassis)    AND
                      tlt.eng_no       = TRIM(wdetail.engine)     AND
                      tlt.genusr       = fi_compa                 AND 
                      tlt.nor_noti_tlt = TRIM(wdetail.Notify_no)  AND
                      tlt.flag         = "N"                      AND 
                      tlt.subins       = "V72"      NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:    
               CREATE brstat.tlt.
                    nv_completecnt  =  nv_completecnt + 1.
               ASSIGN                                                 
                    tlt.entdat       =   TODAY                           /* วันที่โหลด */
                    tlt.enttim       =   STRING(TIME,"HH:MM:SS")         /* เวลาโหลด   */
                    tlt.trndat       =   fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */ 
                    tlt.datesent     =   nv_notdat                       /*วันที่รับแจ้ง    */  
                    tlt.comp_usr_tlt =   trim(wdetail.not_code)          /* Code ประกันภัย  */  
                    tlt.comp_sck     =   trim(wdetail.sckno)             /*เลขที่สติ๊กเกอร์ */  
                    tlt.comp_pol     =   trim(wdetail.compno)            /*เลขกรมธรรม์พรบ   */  
                    tlt.nor_usr_tlt  =   trim(wdetail.not_office)        /*ชื่อประกันภัย    */  
                    tlt.nor_noti_tlt =   trim(wdetail.Notify_no)         /*เลขที่รับแจ้ง    */  
                    tlt.exp          =   "BR:" + trim(wdetail.branch) +  /*โค้ดตลาดสาขา     */  
                                         " MK:" + trim(wdetail.mkBR)     /*ตลาดสาขา*/       
                    tlt.nor_usr_ins  =   trim(wdetail.not_name)          /*ผู้แจ้ง          */  
                    tlt.filler1      =   TRIM(wdetail.lgroup)            /* กลุ่ม         */  
                    tlt.rec_addr4    =   trim(wdetail.notiname)          /*ผู้รับแจ้ง         */
                    tlt.rec_name     =   trim(wdetail.pol_title)         /*คำนำหน้าชื่อผู้เอาประกันภัย */                       
                    tlt.ins_name     =   trim(wdetail.pol_fname)         /*ชื่อผู้เอาประกันภัย */  
                    tlt.ins_addr5    =   trim(wdetail.icno)              /*เลขบัตร           */  
                    tlt.ins_addr1    =   trim(wdetail.pol_addr1)         /*ที่อยู่ลูกค้า   */  
                    tlt.ins_addr2    =   trim(wdetail.pol_addr2) +       /*ที่อยู่ลูกค้า   */  
                                         " TEL:" + TRIM(wdetail.tel)     /*เบอร์โทร        */  
                    tlt.ins_addr3    =   trim(wdetail.pol_send1)         /*ที่อยู่จัดส่ง   */
                    tlt.ins_addr4    =   trim(wdetail.pol_send2) +       /*ที่อยู่จัดส่ง   */
                                         " TEL:" + TRIM(wdetail.tel)     /*เบอร์โทร        */
                   /* tlt.nor_coamt    =   nv_insamt3               */       /*ทุนประกัน            */
                   /* tlt.comp_grprm   =   DECI(wdetail.netprem)    */       /*เบี้ยสุทธิ           */  
                   /* tlt.nor_grprm    =   DECI(wdetail.prem1)      */       /*เบี้ยประกันรวม       */ 
                    tlt.comp_grprm   =   DECI(wdetail.comprem)      /*เบี้ย พรบ. สุทธิ     */  
                    tlt.nor_grprm    =   DECI(wdetail.comp_prm)     /*เบี้ยพรบรวม          */  
                    tlt.comp_coamt   =   DECI(wdetail.gross_prm)         /*เบี้ยรวม             */ 
                    tlt.rec_addr3    =   trim(wdetail.Pro_off)           /*เลขคุ้มครองชั่วคราว  */
                    tlt.brand        =   trim(wdetail.brand)             /*ยี่ห้อ               */  
                    tlt.model        =   trim(wdetail.Brand_Model)       /*รุ่น                 */  
                    tlt.lince2       =   trim(wdetail.yrmanu)            /*ปี                   */ 
                    tlt.colorcod     =   TRIM(wdetail.ncolor)            /* สี */
                    tlt.lince1       =   trim(wdetail.licence)           /*เลขทะเบียน                 */ 
                    tlt.cc_weight    =   INTEGER(wdetail.weight)         /*ขนาดเครื่อง                */  
                    tlt.eng_no       =   trim(wdetail.engine)            /*เลขเครื่อง                 */  
                    tlt.cha_no       =   trim(wdetail.chassis)           /*เลขถัง                     */  
                    tlt.old_cha      =   trim(wdetail.comment)           /*เหตุผลกรณี เลขเครื่องซ้ำ    */  
                    tlt.safe3        =   trim(wdetail.pol_promo)         /*ภาคสมัครใจ แถม/ไม่แถม       */ 
                    tlt.lince3       =   trim(wdetail.comp_promo)        /*ภาคบังคับ แถม/ไม่แถม       */
                    tlt.endcnt       =   INTEGER(wdetail.price)         /*ราคารถ                 */ 
                    tlt.seqno        =   INTEGER(wdetail.price1)         /*ราคากลาง                 */ 
                    tlt.lotno        =   TRIM(wdetail.Dealer)           /*ดีลเลอร์              */ 
                    tlt.expousr      =   trim(wdetail.covcod)           /*ประเภทประกัน               */  
                    /*tlt.endno        =   TRIM(wdetail.drive)            /*ผู้ขับขี่         */  
                    tlt.dri_name1    =   "DN1:"  + trim(wdetail.drivename1) +  /*ระบุผู้ขับขี้1             */  
                                         " ID1:" + trim(wdetail.driveid1)  +   /*เลขที่ใบขับขี่1            */  
                                         " IC1:" + trim(wdetail.driveic1)      /*เลขที่บัตรประชาชน1         */  
                    tlt.dri_no1      =   trim(wdetail.drivedate1)              /*วันเดือนปีเกิด1            */  
                    tlt.dri_name2    =   "DN1:"  + trim(wdetail.drivname2) +   /*ระบุผู้ขับขี้2             */  
                                         " ID1:" + trim(wdetail.driveid2)  +   /*เลขที่ใบขับขี่2            */  
                                         " IC1:" + trim(wdetail.driveic2)      /*เลขที่บัตรประชาชน2         */  
                    tlt.dri_no2         = trim(wdetail.drivedate2)             /*วันเดือนปีเกิด2            */ 
                    tlt.gendat       =   nv_comdat                             /*วันที่เริ่มคุ้มครอง        */  
                    tlt.expodat      =   nv_expdat  */                           /*วันที่สิ้นสุดคุ้มครอง      */ 
                    tlt.comp_effdat  =   nv_comdat72                      /*วันทีเริ่มคุ้มครองพรบ      */  
                    tlt.nor_effdat   =   nv_expdat72                      /*วันที่สิ้นสุดคุ้มครองพรบ   */  
                    tlt.usrsent      =   TRIM(wdetail.cartype)                 /* ประเภทการใช้รถ*/
                    tlt.rec_addr1    =   TRIM(wdetail.remark2)                 /*หมายเหตุอื่นๆ */
                    tlt.recac        =   TRIM(wdetail.notitype)                /*ชนิดรถ */           
                    tlt.old_eng      =   "Veh:" + trim(wdetail.vehuse) +       /*ประเภทรถ            */ 
                                         " Veh1:" + trim(wdetail.vehuse1)      /*ประเภทรถอื่นๆ       */ 
                    tlt.stat         =   "GR:" + trim(wdetail.garage) +        /*สถานที่ซ่อม         */ 
                                         " CD:" + trim(wdetail.codere)         /* code rebate */ 
                    tlt.filler2      =   trim(wdetail.remark)                  /*หมายเหตุ                   */  
                    tlt.sentcnt      =   INT(wdetail.seat)                     /*จำนวนที่นั่ง*/
                    tlt.rec_addr2    =   Trim(wdetail.taxno)                   /*เลขประจำตัวผู้เสียภาษี */
                    tlt.rec_addr5    =   Trim(wdetail.name2)                   /*ชื่อกรรมการ */
                    tlt.nor_noti_ins =   TRIM(wdetail.typeic)                  /* ประเภทเอกสาร */
                    tlt.comp_noti_tlt =  TRIM(wdetail.typetax)                 /*จดทะเบียนภาษี */
                    tlt.gentim        =  TRIM(wdetail.taxbr)                   /*สาขาที่*/
                    tlt.safe1        =   trim(wdetail.ben_name)                /*ผู้รับผลประโยชน์           */ 
                    tlt.safe2        =   trim(wdetail.Account_no)              /*เลขที่ใบคำขอ              */ 
                    tlt.comp_usr_ins =   TRIM(wdetail.pattern)                /* รุ่นยอ่ย */
                     
                    tlt.genusr          = "THANACHAT"                           
                    tlt.usrid           = USERID(LDBNAME(1))                 /*User Load Data */
                    tlt.imp             = "IM"                              /*Import Data*/
                    tlt.releas          = "No"
                    tlt.flag            = "N"
                    tlt.subins          = "V72"
                    tlt.dat_ins_noti    = ? 
                    tlt.comp_sub        = trim(fi_producer)      
                    /*tlt.comp_noti_ins   = "B3M0055" */   /*A64-0205*/
                    tlt.comp_noti_ins   = TRIM(fi_agent) . /*A64-0205*/
            END.
            ELSE DO: 
                nv_completecnt  =  nv_completecnt + 1.
                RUN proc_Create_tlt72N_2.
            END.
        END. 
        RELEASE brstat.tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt72N_2 C-Win 
PROCEDURE proc_create_tlt72N_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A63-0174       
------------------------------------------------------------------------------*/
ASSIGN                                     
        tlt.entdat       =   TODAY                           /* วันที่โหลด */
        tlt.enttim       =   STRING(TIME,"HH:MM:SS")         /* เวลาโหลด   */
        tlt.trndat       =   fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */ 
        tlt.datesent     =   nv_notdat                       /*วันที่รับแจ้ง    */  
        tlt.comp_usr_tlt =   trim(wdetail.not_code)          /* Code ประกันภัย  */  
        tlt.comp_sck     =   trim(wdetail.sckno)             /*เลขที่สติ๊กเกอร์ */  
        tlt.comp_pol     =   trim(wdetail.compno)            /*เลขกรมธรรม์พรบ   */  
        tlt.nor_usr_tlt  =   trim(wdetail.not_office)        /*ชื่อประกันภัย    */  
        tlt.nor_noti_tlt =   trim(wdetail.Notify_no)         /*เลขที่รับแจ้ง    */  
        tlt.exp          =   "BR:" + trim(wdetail.branch) +  /*โค้ดตลาดสาขา     */  
                             " MK:" + trim(wdetail.mkBR)     /*ตลาดสาขา*/       
        tlt.nor_usr_ins  =   trim(wdetail.not_name)          /*ผู้แจ้ง          */  
        tlt.filler1      =   TRIM(wdetail.lgroup)            /* กลุ่ม         */  
        tlt.rec_addr4    =   trim(wdetail.notiname)          /*ผู้รับแจ้ง         */
        tlt.rec_name     =   trim(wdetail.pol_title)         /*คำนำหน้าชื่อผู้เอาประกันภัย */                       
        tlt.ins_name     =   trim(wdetail.pol_fname)         /*ชื่อผู้เอาประกันภัย */  
        tlt.ins_addr5    =   trim(wdetail.icno)              /*เลขบัตร           */  
        tlt.ins_addr1    =   trim(wdetail.pol_addr1)         /*ที่อยู่ลูกค้า   */  
        tlt.ins_addr2    =   trim(wdetail.pol_addr2) +       /*ที่อยู่ลูกค้า   */  
                             " TEL:" + TRIM(wdetail.tel)     /*เบอร์โทร        */  
        tlt.ins_addr3    =   trim(wdetail.pol_send1)         /*ที่อยู่จัดส่ง   */
        tlt.ins_addr4    =   trim(wdetail.pol_send2) +       /*ที่อยู่จัดส่ง   */
                             " TEL:" + TRIM(wdetail.tel)     /*เบอร์โทร        */
        /* tlt.nor_coamt    =   nv_insamt3               */       /*ทุนประกัน            */
        /* tlt.comp_grprm   =   DECI(wdetail.netprem)    */       /*เบี้ยสุทธิ           */  
        /* tlt.nor_grprm    =   DECI(wdetail.prem1)      */       /*เบี้ยประกันรวม       */ 
        tlt.comp_grprm   =   DECI(wdetail.comprem)           /*เบี้ย พรบ. สุทธิ     */  
        tlt.nor_grprm    =   DECI(wdetail.comp_prm)          /*เบี้ยพรบรวม          */  
        tlt.comp_coamt   =   DECI(wdetail.gross_prm)         /*เบี้ยรวม             */ 
        tlt.rec_addr3    =   trim(wdetail.Pro_off)           /*เลขคุ้มครองชั่วคราว  */
        tlt.brand        =   trim(wdetail.brand)             /*ยี่ห้อ               */  
        tlt.model        =   trim(wdetail.Brand_Model)       /*รุ่น                 */  
        tlt.lince2       =   trim(wdetail.yrmanu)            /*ปี                   */ 
        tlt.colorcod     =   TRIM(wdetail.ncolor)            /* สี */
        tlt.lince1       =   trim(wdetail.licence)           /*เลขทะเบียน                 */ 
        tlt.cc_weight    =   INTEGER(wdetail.weight)         /*ขนาดเครื่อง                */  
        tlt.eng_no       =   trim(wdetail.engine)            /*เลขเครื่อง                 */  
        tlt.cha_no       =   trim(wdetail.chassis)           /*เลขถัง                     */  
        tlt.old_cha      =   trim(wdetail.comment)           /*เหตุผลกรณี เลขเครื่องซ้ำ    */  
        tlt.safe3        =   trim(wdetail.pol_promo)         /*ภาคสมัครใจ แถม/ไม่แถม       */ 
        tlt.lince3       =   trim(wdetail.comp_promo)        /*ภาคบังคับ แถม/ไม่แถม       */
        tlt.endcnt       =   INTEGER(wdetail.price)         /*ราคารถ                 */ 
        tlt.seqno        =   INTEGER(wdetail.price1)         /*ราคากลาง                 */ 
        tlt.lotno        =   TRIM(wdetail.Dealer)           /*ดีลเลอร์              */ 
        tlt.expousr      =   trim(wdetail.covcod)           /*ประเภทประกัน               */  
        /*tlt.endno        =   TRIM(wdetail.drive)            /*ผู้ขับขี่         */  
        tlt.dri_name1    =   "DN1:"  + trim(wdetail.drivename1) +  /*ระบุผู้ขับขี้1             */  
                             " ID1:" + trim(wdetail.driveid1)  +   /*เลขที่ใบขับขี่1            */  
                             " IC1:" + trim(wdetail.driveic1)      /*เลขที่บัตรประชาชน1         */  
        tlt.dri_no1      =   trim(wdetail.drivedate1)              /*วันเดือนปีเกิด1            */  
        tlt.dri_name2    =   "DN1:"  + trim(wdetail.drivname2) +   /*ระบุผู้ขับขี้2             */  
                             " ID1:" + trim(wdetail.driveid2)  +   /*เลขที่ใบขับขี่2            */  
                             " IC1:" + trim(wdetail.driveic2)      /*เลขที่บัตรประชาชน2         */  
        tlt.dri_no2         = trim(wdetail.drivedate2)             /*วันเดือนปีเกิด2            */ 
        tlt.gendat       =   nv_comdat                             /*วันที่เริ่มคุ้มครอง        */  
        tlt.expodat      =   nv_expdat  */                           /*วันที่สิ้นสุดคุ้มครอง      */ 
        tlt.comp_effdat  =   nv_comdat72                      /*วันทีเริ่มคุ้มครองพรบ      */  
        tlt.nor_effdat   =   nv_expdat72                      /*วันที่สิ้นสุดคุ้มครองพรบ   */  
        tlt.usrsent      =   TRIM(wdetail.cartype)                 /* ประเภทการใช้รถ*/
        tlt.rec_addr1    =   TRIM(wdetail.remark2)                 /*หมายเหตุอื่นๆ */
        tlt.recac        =   TRIM(wdetail.notitype)                /*ชนิดรถ */           
        tlt.old_eng      =   "Veh:" + trim(wdetail.vehuse) +       /*ประเภทรถ            */ 
                             " Veh1:" + trim(wdetail.vehuse1)      /*ประเภทรถอื่นๆ       */ 
        tlt.stat         =   "GR:" + trim(wdetail.garage) +        /*สถานที่ซ่อม         */ 
                             " CD:" + trim(wdetail.codere)         /* code rebate */ 
        tlt.filler2      =   trim(wdetail.remark)                  /*หมายเหตุ                   */  
        tlt.sentcnt      =   INT(wdetail.seat)                     /*จำนวนที่นั่ง*/
        tlt.rec_addr2    =   Trim(wdetail.taxno)                   /*เลขประจำตัวผู้เสียภาษี */
        tlt.rec_addr5    =   Trim(wdetail.name2)                   /*ชื่อกรรมการ */
        tlt.nor_noti_ins =   TRIM(wdetail.typeic)                  /* ประเภทเอกสาร */
        tlt.comp_noti_tlt =  TRIM(wdetail.typetax)                 /*จดทะเบียนภาษี */
        tlt.gentim        =  TRIM(wdetail.taxbr)                   /*สาขาที่*/
        tlt.safe1        =   trim(wdetail.ben_name)                /*ผู้รับผลประโยชน์           */ 
        tlt.safe2        =   trim(wdetail.Account_no)              /*เลขที่ใบคำขอ              */ 
        tlt.comp_usr_ins =   TRIM(wdetail.pattern)                /* รุ่นยอ่ย */
        tlt.genusr          = "THANACHAT"                           
        tlt.usrid           = USERID(LDBNAME(1))                 /*User Load Data */
        tlt.imp             = "IM"                              /*Import Data*/
        tlt.releas          = "No"
        tlt.flag            = "N"
        tlt.subins          = "V72"
        tlt.dat_ins_noti    = ? 
        tlt.comp_sub        = trim(fi_producer)      
        /*tlt.comp_noti_ins   = "B3M0055" */    /*A64-0205*/
        tlt.comp_noti_ins   = TRIM(fi_agent) .  /*A64-0205*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt_new C-Win 
PROCEDURE proc_create_tlt_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A63-0174        
------------------------------------------------------------------------------*/
DEF VAR n AS INT INIT 0.
LOOP_wdetail:
FOR EACH wdetail.
    IF  wdetail.NOT_date    =  "" THEN  DELETE wdetail.
    ELSE IF wdetail.comdat <> "" AND wdetail.expdat <> "" THEN DO:
    ASSIGN   
            nv_policy    = ""   nv_oldpol    = ""
            nv_comdat    = ?    nv_expdat    = ?  
            /*nv_comdat72  = ?    nv_expdat72  = ?*/    nv_accdat  =  ?
            nv_comchr  = ""     nv_addr    = ""     nv_name1   =  ""     
            nv_ntitle  = ""     nv_titleno = 0      nv_policy  =  ""
            nv_dd      = 0      nv_mm      = 0      nv_yy      =  0
            nv_cpamt1  = 0      nv_cpamt2  = 0      nv_cpamt3  =  0
            nv_coamt1  = 0      nv_coamt2  = 0      nv_coamt3  =  0         
            nv_insamt1 = 0      nv_insamt2 = 0      nv_insamt3 =  0
            nv_premt1  = 0      nv_premt2  = 0      nv_premt3  =  0
            nv_ncb1    = 0      nv_ncb2    = 0      nv_ncb3    =  0
            nv_fleet1  = 0      nv_fleet2  = 0      nv_fleet3  =  0
            nv_oth1    = 0      nv_oth2    = 0      nv_oth3    =  0
            nv_deduct1 = 0      nv_deduct2 = 0      nv_deduct3 =  0
            nv_power1  = 0      nv_power2  = 0      nv_power3  =  0
            nv_newpol  = ""     nv_reccnt  = nv_reccnt + 1
            wdetail.engine = REPLACE(wdetail.engine,"*","") 
            wdetail.sckno   = trim(REPLACE(wdetail.sckno,"'",""))      /*A66-0160*/
            wdetail.compno  = trim(REPLACE(wdetail.compno,"'",""))     /*A66-0160*/
            wdetail.engine  = trim(REPLACE(wdetail.engine ,"'",""))    /*A66-0160*/
            wdetail.chassis = trim(REPLACE(wdetail.chassis ,"'","")).  /*A66-0160*/
        
        IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    /* A56-0399 */
        ELSE ASSIGN nn_remark1  = trim(wdetail.remark)
            nn_remark2  = ""
            nn_remark3 = "".
        
        IF ( wdetail.Notify_no = "" ) THEN 
            MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
        ELSE DO:
            /* ------------------------check policy  Duplicate--------------------------------------*/ 
             RUN pol_cutchar.
             
            IF (wdetail.not_date  <> "" ) THEN ASSIGN  nv_notdat  = DATE(wdetail.not_date).
            ELSE ASSIGN  nv_notdat  = ?.

            IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat  = DATE(wdetail.comdat).
            ELSE ASSIGN nv_comdat = ?.

            IF (wdetail.expdat <>  "" ) THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
            ELSE ASSIGN nv_expdat  = ?.
        
           /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- */
            nv_insamt3 = DECIMAL(wdetail.ins_amt).   /* by: kridtiya i. A54-0061.. */
            /* -------------------------- PREM1 CHR(11)   เบี้ยภาคสมัครใจบวกภาษีบวกอากร --- */
            nv_premt1 = DECIMAL(SUBSTRING(wdetail.prem1,1,9)).
            IF nv_premt1 < 0 THEN
                nv_premt2 = (DECIMAL(SUBSTRING(wdetail.prem1,10,2)) * -1) / 100.
            ELSE
                nv_premt2 = DECIMAL(SUBSTRING(wdetail.prem1,10,2)) / 100.
            nv_premt3 = nv_premt1 + nv_premt2.
            /* --------------------------------------------- COMP_PEM CHR(09)  เบี้ยพรบ.รวม --- */
            nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  
            /* -------------------------- GROSS_PRM CHR(11)   เบี้ยรวมภาคสมัครใจบวกเบี้ยรวม พรบ. --- */
            nv_coamt1 = DECIMAL(SUBSTRING(wdetail.gross_prm,1,9)).
            IF nv_coamt1 < 0 THEN
                nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) * -1) / 100.
            ELSE
                nv_coamt2 = DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) / 100.
            nv_coamt3 = nv_coamt1 + nv_coamt2.
            /*-----------------------------------------------------------------*/
            IF LENGTH(trim(wdetail.icno)) < 13 THEN wdetail.remark2 = wdetail.remark2 + " /เลขบัตรประชาชนไม่ครบ 13 หลัก " . /*A60-0383*/
            /*IF TRIM(wdetail.pol_addr1) <> " "  THEN RUN proc_address.*/
            IF TRIM(wdetail.name_insur) <> " " THEN DO:
                ASSIGN n = 0
                       wdetail.name_insur = TRIM(wdetail.name_insur)
                       wdetail.pol_title  = IF INDEX(wdetail.name_insur," ") <> 0 THEN 
                                               trim(SUBSTR(wdetail.name_insur,1,INDEX(wdetail.name_insur," "))) ELSE ""
                       n = LENGTH(wdetail.name_insur) - LENGTH(wdetail.pol_title)                
                       wdetail.pol_lname  = IF INDEX(wdetail.name_insur," ") <> 0 THEN 
                                               trim(SUBSTR(wdetail.name_insur,INDEX(wdetail.name_insur," "), n + 1 )) 
                                            ELSE trim(wdetail.name_insur).
            END.
            IF INDEX(wdetail.pol_title," ") = 0 THEN DO:
                FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno  = "999" AND
                           INDEX(trim(wdetail.pol_title),brstat.msgcode.MsgDesc) <> 0   NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAIL brstat.msgcode THEN DO:  
                         ASSIGN  wdetail.pol_fname  =  REPLACE(wdetail.pol_title,brstat.msgcode.MsgDesc,"")
                                 wdetail.pol_title  =  trim(brstat.msgcode.branch).
                                
                     END.
                     ELSE  ASSIGN wdetail.pol_fname  = TRIM(wdetail.pol_title) .
            END.
            ASSIGN wdetail.pol_fname = TRIM(wdetail.pol_fname) + " " + TRIM(wdetail.pol_lname) .
            
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                tlt.cha_no       = trim(wdetail.chassis)   AND
                tlt.eng_no       = TRIM(wdetail.engine)    AND
                tlt.genusr       = fi_compa                AND 
                tlt.nor_noti_tlt = TRIM(wdetail.Notify_no) AND
                tlt.flag         = "N"                      AND 
                tlt.subins       = "V70"                   NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:    /*  kridtiya i. A54-0216 ....*/
               CREATE brstat.tlt.
                    nv_completecnt  =  nv_completecnt + 1.
                ASSIGN                                                 
                    tlt.entdat       =   TODAY                           /* วันที่โหลด */
                    tlt.enttim       =   STRING(TIME,"HH:MM:SS")         /* เวลาโหลด   */
                    tlt.trndat       =   fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */ 
                    tlt.datesent     =   nv_notdat                       /*วันที่รับแจ้ง    */  
                    tlt.comp_usr_tlt =   trim(wdetail.not_code)          /* Code ประกันภัย  */  
                    tlt.comp_sck     =   trim(wdetail.sckno)             /*เลขที่สติ๊กเกอร์ */  
                    /*tlt.comp_pol   =   trim(wdetail.compno)*/          /*เลขกรมธรรม์พรบ   */  
                    tlt.nor_usr_tlt  =   trim(wdetail.not_office)        /*ชื่อประกันภัย    */  
                    tlt.nor_noti_tlt =   trim(wdetail.Notify_no)         /*เลขที่รับแจ้ง    */  
                    tlt.exp          =   "BR:" + trim(wdetail.branch) +  /*โค้ดตลาดสาขา     */  
                                         " MK:" + trim(wdetail.mkBR)     /*ตลาดสาขา*/       
                    tlt.nor_usr_ins  =   trim(wdetail.not_name)          /*ผู้แจ้ง          */  
                    tlt.filler1      =   TRIM(wdetail.lgroup)            /* กลุ่ม         */  
                    tlt.rec_addr4    =   trim(wdetail.notiname)          /*ผู้รับแจ้ง         */
                    tlt.rec_name     =   trim(wdetail.pol_title)         /*คำนำหน้าชื่อผู้เอาประกันภัย */                       
                    tlt.ins_name     =   trim(wdetail.pol_fname)         /*ชื่อผู้เอาประกันภัย */  
                    tlt.ins_addr5    =   trim(wdetail.icno)              /*เลขบัตร           */  
                    tlt.ins_addr1    =   trim(wdetail.pol_addr1)         /*ที่อยู่ลูกค้า   */  
                    tlt.ins_addr2    =   trim(wdetail.pol_addr2) +       /*ที่อยู่ลูกค้า   */  
                                         " TEL:" + TRIM(wdetail.tel)     /*เบอร์โทร        */  
                    tlt.ins_addr3    =   trim(wdetail.pol_send1)         /*ที่อยู่จัดส่ง   */
                    tlt.ins_addr4    =   trim(wdetail.pol_send2) +       /*ที่อยู่จัดส่ง   */
                                         " TEL:" + TRIM(wdetail.tel)     /*เบอร์โทร        */
                    tlt.nor_coamt    =   nv_insamt3                      /*ทุนประกัน            */
                    tlt.comp_grprm   =   DECI(wdetail.netprem)           /*เบี้ยสุทธิ           */  
                    tlt.nor_grprm    =   DECI(wdetail.prem1)             /*เบี้ยประกันรวม       */ 
                    /*tlt.comp_grprm   =   DECI(wdetail.comprem) */      /*เบี้ย พรบ. สุทธิ     */  
                    /*tlt.comp_grprm   =   DECI(wdetail.comp_prm) */     /*เบี้ยพรบรวม          */  
                    tlt.comp_coamt   =   DECI(wdetail.gross_prm)         /*เบี้ยรวม             */ 
                    tlt.rec_addr3    =   trim(wdetail.Pro_off)           /*เลขคุ้มครองชั่วคราว  */
                    tlt.brand        =   trim(wdetail.brand)             /*ยี่ห้อ               */  
                    tlt.model        =   trim(wdetail.Brand_Model)       /*รุ่น                 */  
                    tlt.lince2       =   trim(wdetail.yrmanu)            /*ปี                   */ 
                    tlt.colorcod     =   TRIM(wdetail.ncolor)            /* สี */
                    tlt.lince1       =   trim(wdetail.licence)           /*เลขทะเบียน                 */ 
                    tlt.cc_weight    =   INTEGER(wdetail.weight)         /*ขนาดเครื่อง                */  
                    tlt.eng_no       =   trim(wdetail.engine)            /*เลขเครื่อง                 */  
                    tlt.cha_no       =   trim(wdetail.chassis)           /*เลขถัง                     */  
                    tlt.old_cha      =   trim(wdetail.comment)           /*เหตุผลกรณี เลขเครื่องซ้ำ    */  
                    tlt.safe3        =   trim(wdetail.pol_promo)         /*ภาคสมัครใจ แถม/ไม่แถม       */ 
                    tlt.lince3       =   trim(wdetail.comp_promo)        /*ภาคบังคับ แถม/ไม่แถม       */
                    tlt.endcnt       =   INTEGER(wdetail.price)         /*ราคารถ                 */ 
                    tlt.seqno        =   INTEGER(wdetail.price1)         /*ราคากลาง                 */ 
                    tlt.lotno        =   TRIM(wdetail.Dealer)           /*ดีลเลอร์              */ 
                    tlt.expousr      =   trim(wdetail.covcod)           /*ประเภทประกัน               */  
                    tlt.endno        =   TRIM(wdetail.drive)            /*ผู้ขับขี่         */  
                    tlt.dri_name1    =   "DN1:"  + trim(wdetail.drivename1) +  /*ระบุผู้ขับขี้1             */  
                                         " ID1:" + trim(wdetail.driveid1)  +   /*เลขที่ใบขับขี่1            */  
                                         " IC1:" + trim(wdetail.driveic1)      /*เลขที่บัตรประชาชน1         */  
                    tlt.dri_no1      =   trim(wdetail.drivedate1)              /*วันเดือนปีเกิด1            */  
                    tlt.dri_name2    =   "DN2:"  + trim(wdetail.drivname2) +   /*ระบุผู้ขับขี้2             */  
                                         " ID2:" + trim(wdetail.driveid2)  +   /*เลขที่ใบขับขี่2            */  
                                         " IC2:" + trim(wdetail.driveic2)      /*เลขที่บัตรประชาชน2         */  
                    tlt.dri_no2         = trim(wdetail.drivedate2)             /*วันเดือนปีเกิด2            */ 
                    tlt.gendat       =   nv_comdat                             /*วันที่เริ่มคุ้มครอง        */  
                    tlt.expodat      =   nv_expdat                             /*วันที่สิ้นสุดคุ้มครอง      */ 
                    /*tlt.comp_effdat  =   nv_comdat72 */                      /*วันทีเริ่มคุ้มครองพรบ      */  
                    /*tlt.nor_effdat   =   nv_expdat72*/                       /*วันที่สิ้นสุดคุ้มครองพรบ   */  
                    tlt.usrsent      =   TRIM(wdetail.cartype)                 /* ประเภทการใช้รถ*/
                    tlt.rec_addr1    =   TRIM(wdetail.remark2)                 /*หมายเหตุอื่นๆ */
                    tlt.recac        =   TRIM(wdetail.notitype)                /*ชนิดรถ */           
                    tlt.old_eng      =   "Veh:" + trim(wdetail.vehuse) +       /*ประเภทรถ            */ 
                                         " Veh1:" + trim(wdetail.vehuse1)      /*ประเภทรถอื่นๆ       */ 
                    tlt.stat         =   "GR:" + trim(wdetail.garage) +        /*สถานที่ซ่อม         */ 
                                         " CD:" + trim(wdetail.codere)         /* code rebate */ 
                    tlt.filler2      =   trim(wdetail.remark)                  /*หมายเหตุ                   */  
                    tlt.sentcnt      =   INT(wdetail.seat)                     /*จำนวนที่นั่ง*/
                    tlt.rec_addr2    =   Trim(wdetail.taxno)                   /*เลขประจำตัวผู้เสียภาษี */
                    tlt.rec_addr5    =   Trim(wdetail.name2)                   /*ชื่อกรรมการ */
                    tlt.nor_noti_ins =   TRIM(wdetail.typeic)                  /* ประเภทเอกสาร */ 
                    tlt.comp_noti_tlt =  TRIM(wdetail.typetax)                 /*จดทะเบียนภาษี */
                    tlt.gentim        =  TRIM(wdetail.taxbr)                   /*สาขาที่*/
                    tlt.safe1        =   trim(wdetail.ben_name)                /*ผู้รับผลประโยชน์           */ 
                    tlt.safe2        =   trim(wdetail.Account_no)              /*เลขที่ใบคำขอ              */ 
                    tlt.comp_usr_ins =   TRIM(wdetail.pattern)                /* รุ่นยอ่ย */
                    tlt.genusr          = "THANACHAT"                           
                    tlt.usrid           = USERID(LDBNAME(1))                 /*User Load Data */
                    tlt.imp             = "IM"                              /*Import Data*/
                    tlt.releas          = "No"
                    tlt.flag            = "N"
                    tlt.subins          = "V70"
                    tlt.policy          =  ""                 /* policy new */
                    tlt.dat_ins_noti    = ?                   /* วันที่ออกงาน */
                    tlt.comp_sub        = trim(fi_producer)      
                    /*tlt.comp_noti_ins   = "B3M0055" */   /*A64-0205*/
                    tlt.comp_noti_ins   = TRIM(fi_agent) . /*A64-0205*/
                    
                IF DECI(wdetail.comprem) <> 0 AND DECI(wdetail.comp_prm) <> 0 THEN RUN proc_create_tlt72N.   
            END.
            ELSE DO: 
                nv_completecnt  =  nv_completecnt + 1.
                RUN proc_Create_tlt_new2.
            END.
        END. 
    END.
    ELSE IF DECI(wdetail.comprem) <> 0 AND DECI(wdetail.comp_prm) <> 0 THEN RUN proc_create_tlt72N.  
END. 
RELEASE brstat.tlt.
Run proc_Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt_new2 C-Win 
PROCEDURE proc_create_tlt_new2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A63-0174        
------------------------------------------------------------------------------*/
ASSIGN                                     
        tlt.entdat       =   TODAY                           /* วันที่โหลด */
        tlt.enttim       =   STRING(TIME,"HH:MM:SS")         /* เวลาโหลด   */
        tlt.trndat       =   fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */ 
        tlt.datesent     =   nv_notdat                       /*วันที่รับแจ้ง    */  
        tlt.comp_usr_tlt =   trim(wdetail.not_code)          /* Code ประกันภัย  */  
        tlt.comp_sck     =   trim(wdetail.sckno)             /*เลขที่สติ๊กเกอร์ */  
        /*tlt.comp_pol   =   trim(wdetail.compno)*/          /*เลขกรมธรรม์พรบ   */  
        tlt.nor_usr_tlt  =   trim(wdetail.not_office)        /*ชื่อประกันภัย    */  
        tlt.nor_noti_tlt =   trim(wdetail.Notify_no)         /*เลขที่รับแจ้ง    */  
        tlt.exp          =   "BR:" + trim(wdetail.branch) +  /*โค้ดตลาดสาขา     */  
                             " MK:" + trim(wdetail.mkBR)     /*ตลาดสาขา*/       
        tlt.nor_usr_ins  =   trim(wdetail.not_name)          /*ผู้แจ้ง          */  
        tlt.filler1      =   TRIM(wdetail.lgroup)            /* กลุ่ม         */  
        tlt.rec_addr4    =   trim(wdetail.notiname)          /*ผู้รับแจ้ง         */
        tlt.rec_name     =   trim(wdetail.pol_title)         /*คำนำหน้าชื่อผู้เอาประกันภัย */                       
        tlt.ins_name     =   trim(wdetail.pol_fname)         /*ชื่อผู้เอาประกันภัย */  
        tlt.ins_addr5    =   trim(wdetail.icno)              /*เลขบัตร           */  
        tlt.ins_addr1    =   trim(wdetail.pol_addr1)         /*ที่อยู่ลูกค้า   */  
        tlt.ins_addr2    =   trim(wdetail.pol_addr2) +       /*ที่อยู่ลูกค้า   */  
                             " TEL:" + TRIM(wdetail.tel)     /*เบอร์โทร        */  
        tlt.ins_addr3    =   trim(wdetail.pol_send1)         /*ที่อยู่จัดส่ง   */
        tlt.ins_addr4    =   trim(wdetail.pol_send2) +       /*ที่อยู่จัดส่ง   */
                             " TEL:" + TRIM(wdetail.tel)     /*เบอร์โทร        */
        tlt.nor_coamt    =   nv_insamt3                      /*ทุนประกัน            */
        tlt.comp_grprm   =   DECI(wdetail.netprem)           /*เบี้ยสุทธิ           */  
        tlt.nor_grprm    =   DECI(wdetail.prem1)             /*เบี้ยประกันรวม       */ 
        /*tlt.comp_grprm   =   DECI(wdetail.comprem) */      /*เบี้ย พรบ. สุทธิ     */  
        /*tlt.comp_grprm   =   DECI(wdetail.comp_prm) */     /*เบี้ยพรบรวม          */  
        tlt.comp_coamt   =   DECI(wdetail.gross_prm)         /*เบี้ยรวม             */ 
        tlt.rec_addr3    =   trim(wdetail.Pro_off)           /*เลขคุ้มครองชั่วคราว  */
        tlt.brand        =   trim(wdetail.brand)             /*ยี่ห้อ               */  
        tlt.model        =   trim(wdetail.Brand_Model)       /*รุ่น                 */  
        tlt.lince2       =   trim(wdetail.yrmanu)            /*ปี                   */ 
        tlt.colorcod     =   TRIM(wdetail.ncolor)            /* สี */
        tlt.lince1       =   trim(wdetail.licence)           /*เลขทะเบียน                 */ 
        tlt.cc_weight    =   INTEGER(wdetail.weight)         /*ขนาดเครื่อง                */  
        tlt.eng_no       =   trim(wdetail.engine)            /*เลขเครื่อง                 */  
        tlt.cha_no       =   trim(wdetail.chassis)           /*เลขถัง                     */  
        tlt.old_cha      =   trim(wdetail.comment)           /*เหตุผลกรณี เลขเครื่องซ้ำ    */  
        tlt.safe3        =   trim(wdetail.pol_promo)         /*ภาคสมัครใจ แถม/ไม่แถม       */ 
        tlt.lince3       =   trim(wdetail.comp_promo)        /*ภาคบังคับ แถม/ไม่แถม       */
        tlt.endcnt       =   INTEGER(wdetail.price)         /*ราคารถ                 */ 
        tlt.seqno        =   INTEGER(wdetail.price1)         /*ราคากลาง                 */ 
        tlt.lotno        =   TRIM(wdetail.Dealer)           /*ดีลเลอร์              */ 
        tlt.expousr      =   trim(wdetail.covcod)           /*ประเภทประกัน               */  
        tlt.endno        =   TRIM(wdetail.drive)            /*ผู้ขับขี่         */  
        tlt.dri_name1    =   "DN1:"  + trim(wdetail.drivename1) +  /*ระบุผู้ขับขี้1             */  
                             " ID1:" + trim(wdetail.driveid1)  +   /*เลขที่ใบขับขี่1            */  
                             " IC1:" + trim(wdetail.driveic1)      /*เลขที่บัตรประชาชน1         */  
        tlt.dri_no1      =   trim(wdetail.drivedate1)              /*วันเดือนปีเกิด1            */  
        tlt.dri_name2    =   "DN2:"  + trim(wdetail.drivname2) +   /*ระบุผู้ขับขี้2             */  
                             " ID2:" + trim(wdetail.driveid2)  +   /*เลขที่ใบขับขี่2            */  
                             " IC2:" + trim(wdetail.driveic2)      /*เลขที่บัตรประชาชน2         */  
        tlt.dri_no2         = trim(wdetail.drivedate2)             /*วันเดือนปีเกิด2            */ 
        tlt.gendat       =   nv_comdat                             /*วันที่เริ่มคุ้มครอง        */  
        tlt.expodat      =   nv_expdat                             /*วันที่สิ้นสุดคุ้มครอง      */ 
        /*tlt.comp_effdat  =   nv_comdat72 */                      /*วันทีเริ่มคุ้มครองพรบ      */  
        /*tlt.nor_effdat   =   nv_expdat72*/                       /*วันที่สิ้นสุดคุ้มครองพรบ   */  
        tlt.usrsent      =   TRIM(wdetail.cartype)                 /* ประเภทการใช้รถ*/
        tlt.rec_addr1    =   TRIM(wdetail.remark2)                 /*หมายเหตุอื่นๆ */
        tlt.recac        =   TRIM(wdetail.notitype)                /*ชนิดรถ */           
        tlt.old_eng      =   "Veh:" + trim(wdetail.vehuse) +       /*ประเภทรถ            */ 
                             " Veh1:" + trim(wdetail.vehuse1)      /*ประเภทรถอื่นๆ       */ 
        tlt.stat         =   "GR:" + trim(wdetail.garage) +        /*สถานที่ซ่อม         */ 
                             " CD:" + trim(wdetail.codere)         /* code rebate */ 
        tlt.filler2      =   trim(wdetail.remark)                  /*หมายเหตุ                   */  
        tlt.sentcnt      =   INT(wdetail.seat)                     /*จำนวนที่นั่ง*/
        tlt.rec_addr2    =   Trim(wdetail.taxno)                   /*เลขประจำตัวผู้เสียภาษี */
        tlt.rec_addr5    =   Trim(wdetail.name2)                   /*ชื่อกรรมการ */
        tlt.nor_noti_ins =   TRIM(wdetail.typeic)                  /* ประเภทเอกสาร */
        tlt.comp_noti_tlt =  TRIM(wdetail.typetax)                 /*จดทะเบียนภาษี */
        tlt.gentim        =  TRIM(wdetail.taxbr)                   /*สาขาที่*/
        tlt.safe1        =   trim(wdetail.ben_name)                /*ผู้รับผลประโยชน์           */ 
        tlt.safe2        =   trim(wdetail.Account_no)              /*เลขที่ใบคำขอ              */ 
        tlt.comp_usr_ins =   TRIM(wdetail.pattern)                /* รุ่นยอ่ย */
        tlt.genusr          = "THANACHAT"                           
        tlt.usrid           = USERID(LDBNAME(1))                 /*User Load Data */
        tlt.imp             = "IM"                              /*Import Data*/
        tlt.releas          = "No"
        tlt.flag            = "N"
        tlt.subins          = "V70"
        tlt.policy          = ""        /* policy new*/
        tlt.dat_ins_noti    = ?         /* วันทีออกงาน */
        tlt.comp_sub        = trim(fi_producer)      
        /*tlt.comp_noti_ins   = "B3M0055" */   /*A64-0205*/
        tlt.comp_noti_ins   = TRIM(fi_agent) . /*A64-0205*/
    IF DECI(wdetail.comprem) <> 0 AND DECI(wdetail.comp_prm) <> 0 THEN RUN proc_create_tlt72N.   

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
        /*nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark," "))) */            /*A60-0383*/
        /*nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark," ") - 1 )) .   */ /*A60-0383*/
        nn_remark2 = IF INDEX(wdetail.remark," ") <> 0 THEN trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark," "))) ELSE ""        /*A60-0383*/
        nn_remark1 = IF INDEX(wdetail.remark," ") <> 0 THEN trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark," ") - 1 )) ELSE TRIM(wdetail.remark) . /*A60-0383*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_getisp C-Win 
PROCEDURE proc_getisp :
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_inspec C-Win 
PROCEDURE proc_inspec :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A62-0445 Date 01/10/2019 
------------------------------------------------------------------------------*/
DEF VAR nv_expdat AS CHAR FORMAT "x(15)".
DEF VAR nv_fname  AS CHAR FORMAT "x(50)" .
DEF VAR nv_lname  AS CHAR FORMAT "x(50)".
DO:
    ASSIGN              
        nv_year      = STRING(YEAR(TODAY))
        nv_year      = SUBSTR(nv_year,3,2) 
        /* real database */
        NotesServer  = "Safety_NotesServer/Safety"
        NotesApp     = "safety\uw\inspect" + nv_year + ".nsf"
        /**/
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
       /* nv_fname     = ""
        nv_lname     = ""
        nv_expdat    = ""
        nv_lname     = trim(SUBSTR(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1))
        nv_fname     = trim(SUBSTR(brstat.tlt.ins_name,1,LENGTH(brstat.tlt.ins_name) - LENGTH(nv_lname) - 1 ))
        nv_fname     = trim(SUBSTR(nv_fname,R-INDEX(nv_fname," ")))
        nv_expdat    = STRING(brstat.tlt.gendat,"99/99/9999")
        nv_expdat    = SUBSTR(nv_expdat,1,6) + STRING(INT(SUBSTR(nv_expdat,7,4)) + 1) */
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
    
    nv_licence2 = trim(nv_licence1) .
    IF trim(nv_licence2) <> "" THEN DO:
       ASSIGN nv_licence2 = REPLACE(nv_licence2," ","").

       IF INDEX("0123456789",SUBSTR(nv_licence2,1,1)) <> 0 THEN DO:
          IF LENGTH(nv_licence2) = 4 THEN 
             ASSIGN nv_Pattern = "yxx-y-xx"
                    nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,1).
          ELSE IF LENGTH(nv_licence2) = 5 THEN
              ASSIGN nv_Pattern = "yxx-yy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,2).
          ELSE IF LENGTH(nv_licence2) = 6 THEN DO:
              IF INDEX("0123456789",SUBSTR(nv_licence2,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "yy-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4).
              ELSE IF INDEX("0123456789",SUBSTR(nv_licence2,3,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "yx-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4).
              ELSE 
                  ASSIGN nv_Pattern = "yxx-yyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,3). 
          END.
          ELSE 
              ASSIGN nv_Pattern = "yxx-yyyy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,4).
       END.
       ELSE DO:
           IF LENGTH(nv_licence2) = 3 THEN 
             ASSIGN nv_Pattern = "xx-y-xx"
                    nv_licence2    = SUBSTR(nv_licence2,1,2) + " "  + SUBSTR(nv_licence2,3,1) .
           ELSE IF LENGTH(nv_licence2) = 4 THEN
              ASSIGN nv_Pattern = "xx-yy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,2) .
           ELSE IF LENGTH(nv_licence2) = 6 THEN
              IF INDEX("0123456789",SUBSTR(nv_licence2,3,1)) <> 0 THEN
              ASSIGN nv_Pattern = "xx-yyyy-xx" 
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4) .
              ELSE ASSIGN nv_Pattern = "xxx-yyy-xx" 
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
                        nv_key3   = nv_licence1 + " " + nv_provin .          /* PM */

                        IF INDEX(nv_key1," ") <> 0 THEN nv_key1 = REPLACE(nv_key1," ","") .
                        IF INDEX(nv_key3," ") <> 0 THEN nv_key3 = REPLACE(nv_key3," ","") .
                        
                        IF nv_key1 = nv_key3 THEN DO:
                            
                            chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
                            IF chitem <> 0 THEN nv_surcl   = chitem:TEXT. 
                            ELSE nv_surcl  = "".
                           
                            IF nv_surcl = "" THEN DO:                            
                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.
                                nv_chkdoc = NO.
                                /*nv_msgbox = "มีข้อมูลเลขตัวถังกับเลขทะเบียนในกล่อง ยังไม่ปิดเรื่อง " + nv_docno .*/
                                LEAVE loop_chkrecord.
                            END.
                            ELSE DO:
                                
                                chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
                                IF chitem <> 0 THEN nv_date = chitem:TEXT. 
                                ELSE nv_date = "".
                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.
                                /*nv_msgbox = "มีข้อมูลเลขตัวถังกับเลขทะเบียนในกล่อง ปิดเรื่องแล้ว " + nv_docno .*/
                               
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
                                /*chDocument = chViewEntry:Document.  */                   
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
                   nv_acctotal = ""
                   nv_damdetail = ""   .
                IF nv_surcl <> "" THEN  RUN proc_getisp.
                IF nv_docno <> ""  THEN DO:
                     ASSIGN 
                         brstat.tlt.rec_addr5  = "ISP:" + trim(nv_docno) + " " +
                                                 "RES:" + trim(nv_detail + " " + nv_damage + " " + nv_damlist + " " + nv_damdetail + " " + nv_device) .
                                                       /*+ " " + nv_surdata + " " + nv_device + " " + nv_acctotal*/   /* ผลตรวจสภาพ*/
                    END.
                    /*RELEASE brstat.tlt. */       

                END.
               /* ELSE DO:

                    chDocument = chDatabase:CreateDocument.
                    ASSIGN
                        chDocument:FORM        = "Inspection"                        
                        chDocument:createdBy   = nv_name                             
                        chDocument:createdOn   = nv_datim                            
                        chDocument:dateS       = brstat.tlt.gendat                            
                        chDocument:dateE       = nv_expdat                           
                        chDocument:ReqType_sub = "ลูกค้า/ตัวแทน/นายหน้าเป็นผู้ส่งรูปตรวจสภาพ"
                        chDocument:BranchReq   = "Business Unit 3"                           
                        chDocument:Tname       = "บุคคล"                             
                        chDocument:Fname       = nv_fname                         
                        chDocument:Lname       = nv_lname                        
                        chDocument:phone1      = ""    
                        chDocument:PolicyNo    = ""                          
                        chDocument:agentCode   = trim(brstat.tlt.comp_sub)                         
                        chDocument:agentName   = nv_brname                           
                        chDocument:Premium     = brstat.tlt.comp_coamt                          
                        chDocument:model       = brstat.tlt.model                       
                        chDocument:modelCode   = ""                         
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
                END.  */                                      
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
       /*wtlt.branch      =   tlt.exp    */ /*A63-0174*/
       wtlt.branch      =   IF rs_type = 1 THEN SUBSTR(tlt.exp,4,INDEX(tlt.EXP,"MK:") - 4) ELSE tlt.EXP    /*A63-0174*/
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
       wtlt.remark      =   tlt.filler2
       wtlt.camp        =   tlt.genusr
       wtlt.remark      =   tlt.rec_addr1. /*A60-0383 */
END.
RELEASE brstat.tlt.
OPEN QUERY br_imptxt FOR EACH wtlt NO-LOCK .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp C-Win 
PROCEDURE proc_sic_exp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A60-0383     
------------------------------------------------------------------------------*/
FORM
    gv_id  LABEL " User Id " colon 35 SKIP
    nv_pwd LABEL " Password" colon 35 BLANK
    WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY width 80
    TITLE   " Connect DB Expiry System"  . 
STATUS INPUT OFF.
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
      CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.
     /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*//*Comment A62-0105*/
      /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/
      /*CONNECT expiry -H 18.10.100.5 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/

      IF NOT CONNECTED("sic_exp") THEN DO:
         MESSAGE "Not Connect DB Expiry ld sic_exp".
         NEXT-PROMPT gv_id WITH FRAME nf00.
         NEXT.
      END.
      CLEAR FRAME nf00.
      HIDE FRAME nf00.

      RETURN. 
    
   END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

