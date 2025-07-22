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
/*Program name : Match File Confirm ICBC                     */
/*create by    : Kridtiya i. A53-0207                                       */
/*               แปลงเทคเป็นไฟล์excel                                       */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */
/*Modify by : Ranu I. A60-0263 เพิ่มการเก็บข้อมูลแคมเปญ และตรวจสอบเงื่อนไขเพิ่มเติม*/
/*Modify by : Kridtiya i. A63-0419 เพิ่มการแปลงสาขาจากพารามิเตอร์                  */
/*MOdify by : Krittapoj S. A65-0372 16/01/2023 เพิ่มช่องcolor และcolor ออกเป็นชื่อสีรถยน์*/
DEF  stream ns1.
DEFINE VAR  nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR  nv_reccnt      AS  INT  INIT  0.
DEFINE VAR  nv_completecnt AS   INT   INIT  0.
DEFINE VAR  nv_enttim      AS  CHAR          INIT  "".
DEFINE VAR  nv_export      as  date  init  ""  format "99/99/9999".
DEF stream  ns2.
DEFINE VAR nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
 
DEFINE NEW SHARED TEMP-TABLE Texcel       /*A57-0107*/
    FIELD rectype     AS CHAR FORMAT "X(10)"  init ""              /*"ประเภทของ Record"           */                            
    FIELD contno      AS CHAR FORMAT "X(10)"  init ""              /*"เลขที่สัญญาในปีแรก"         */                           
    FIELD id          AS CHAR FORMAT "X(15)"  init ""              /*"เลขที่บัตรประชาชน"          */                           
    FIELD insqno      AS CHAR FORMAT "X(10)"  init ""              /*""                           */                           
    FIELD bkdate      AS CHAR FORMAT "X(8)"   init ""              /*"วันที่ทำสัญญา"              */                           
    FIELD notidate    AS CHAR FORMAT "X(8)"   init ""              /*"วันที่แจ้งประกัน"           */                           
    FIELD inscmp      AS CHAR FORMAT "X(5)"   init ""              /*"รหัสบริษัทประกันภัย"        */
    FIELD instyp      AS CHAR FORMAT "X(2)"   init ""              /*"ประเภทประกันเดิม"           */                           
    FIELD covtyp      AS CHAR FORMAT "X(2)"   init ""              /*"ประเภทความคุ้มครอง"         */                           
    FIELD inslictyp   AS CHAR FORMAT "X(5)"   init ""              /*"Insurance License Type"     */                           
    FIELD insyearno   AS CHAR FORMAT "X(5)"   init ""              /*"ปีประกัน"                  */                           
    FIELD policy      AS CHAR FORMAT "X(20)"  init ""              /*"เลขที่กรมธรรม์"             */                           
    FIELD covamt      AS CHAR FORMAT "X(20)"  init ""              /*"ทุนประกัน"                  */                           
    FIELD covamtthf   AS CHAR FORMAT "X(20)"  init ""              /*"ทุนประกันรถหาย"             */                            
    FIELD netamt      AS CHAR FORMAT "X(20)"  init ""              /*"ค่าเบี้ยสุทธิ"                      */                            
    FIELD groamt      AS CHAR FORMAT "X(20)"  init ""              /*"ค่าเบี้ย"              */                            
    FIELD taxamtins   AS CHAR FORMAT "X(20)"  init ""              /*"หัก ณ ที่จ่ายของค่าเบี้ย"   */                            
    FIELD gropduty    AS CHAR FORMAT "X(20)"  init ""              /*"อากรเบี้ย"                  */                            
    FIELD effdate     AS CHAR FORMAT "X(8)"   init ""              /*"วันที่ประกันภัยมีผล"        */                            
    FIELD expdate     AS CHAR FORMAT "X(8)"   init ""              /*"วันที่หมดอายุ"              */
    FIELD accpolicy   AS CHAR FORMAT "X(35)"  init ""              /*"เลขที่ พรบ."                */                            
    FIELD acccovamt   AS CHAR FORMAT "X(20)"  init ""              /*"ทุนประกัน พรบ."             */                          
    FIELD accnpmamt   AS CHAR FORMAT "X(20)"  init ""              /*"ค่า พรบ. สุทธิ"                   */                          
    FIELD accgpmamt   AS CHAR FORMAT "X(20)"  init ""              /*"ค่า พรบ."             */                          
    FIELD acctaxamt   AS CHAR FORMAT "X(20)"  init ""              /*"หัก ณ ที่จ่าย พรบ."         */                          
    FIELD accgpduty   AS CHAR FORMAT "X(20)"  init ""              /*"อากร พรบ."                  */                          
    FIELD acceffdat   AS CHAR FORMAT "X(8)"   init ""              /*"วันที่ประกันมีผล"           */                      
    FIELD accexpdat   AS CHAR FORMAT "X(8)"   init ""              /*"วันที่หมดอายุ"              */                      
    FIELD dscfamt     AS CHAR FORMAT "X(20)"  init ""              /*"% ส่วนลดหมู่"               */                      
    FIELD dscexpr     AS CHAR FORMAT "X(20)"  init ""              /*"% ส่วนลดประวัติ"            */                      
    FIELD dscdeduc    AS CHAR FORMAT "X(20)"  init ""              /*"ความเสียหายส่วนแรก"         */                      
    FIELD chassno     AS CHAR FORMAT "X(30)"  init ""              /*"เลขตัวถัง"                  */                      
    FIELD enginno     AS CHAR FORMAT "X(30)"  init ""              /*"เลขเครื่องยนต์"             */                      
    FIELD caryear     AS CHAR FORMAT "X(10)"  init ""              /*"ปีรถ"                       */                      
    FIELD regisprov   AS CHAR FORMAT "X(30)"  init ""              /*"จังหวัดที่จดทะเบียน"        */                      
    FIELD licenno     AS CHAR FORMAT "X(10)"  init ""              /*"ทะเบียนรถ"                  */ 
    FIELD cc          AS CHAR FORMAT "X(10)"  init ""              /*"ซีซี"                       */                      
    FIELD brand       AS CHAR FORMAT "X(100)" init ""              /*"ยี่ห้อ"                     */                      
    FIELD model       AS CHAR FORMAT "X(100)" init ""              /*"รุ่น"                       */                      
    FIELD titlen      AS CHAR FORMAT "X(100)" init ""              /*"คำนำหน้าชื่อ"               */                      
    FIELD cname       AS CHAR FORMAT "X(100)" init ""              /*"ชื่อลูกค้า"                 */                      
    FIELD csname      AS CHAR FORMAT "X(100)" init ""              /*"นามสกุล"                    */                      
    FIELD birthday    AS CHAR FORMAT "x(8)"   init ""              /*วันเกิดลูกค้า */ /*Add A56-0071*/
    FIELD occuration  AS CHAR FORMAT "x(100)" init ""              /*อาชีพ */         /*Add A56-0071*/
    FIELD upddte      AS CHAR FORMAT "X(8)"   init ""              /*"วันที่ทำรายการ"             */                      
    FIELD updby       AS CHAR FORMAT "X(30)"  init ""              /*"user ที่ทำรายการ"           */                
    FIELD batchno     AS CHAR FORMAT "X(2)"   init ""              /*"สำหรับตรวจสอบรายการ"        */                      
    FIELD remark      AS CHAR FORMAT "X(250)" init ""              /*"หมายเหตุ"                   */                      
    FIELD notfyby     AS CHAR FORMAT "X(50)"  init ""              /*"ชื่อผู้แจ้งประกัน"                    */                      
    FIELD overamt     AS CHAR FORMAT "X(20)"  init ""              /*"เงินรับ (สามารถออกกรมธรรม์ได้)"       */                      
    FIELD assured     AS CHAR FORMAT "X(50)"  init ""              /*"ระบุ LACL"                            */                      
    FIELD trandte     AS CHAR FORMAT "X(8)"   init ""              /*"วันที่ชำระเงิน"                       */                      
    FIELD claim       AS CHAR FORMAT "X(50)"  init ""              /*"การจัดซ่อม"                           */                      
    FIELD drivers1    AS CHAR FORMAT "X(50)"  init ""              /*"ระบุผู้ขับขี่คนที่ 1"                 */                      
    FIELD id_driv1    AS CHAR FORMAT "X(15)"  init ""              /*"เลขที่บัตรประชาชนผู้ขับขี่คนที่ 1"     */                     
    FIELD bdaydr1     AS CHAR FORMAT "X(8)"   init ""              /*"วันเกิดผู้ขับขี่คนที่ 1"               */     
    FIELD licnodr1    AS CHAR FORMAT "X(15)"  init ""              /*"เลขที่ใบขับขี่คนที่ 1"                 */     
    FIELD drivers2    AS CHAR FORMAT "X(50)"  init ""              /*"ระบุผู้ขับขี่คนที่ 2"                  */     
    FIELD id_driv2    AS CHAR FORMAT "X(15)"  init ""              /*"เลขที่บัตรประชาชนผู้ขับขี่คนที่ 2"     */     
    FIELD bdaydr2     AS CHAR FORMAT "X(8)"   init ""              /*"วันเกิดผู้ขับขี่คนที่ 2"               */     
    FIELD licnodr2    AS CHAR FORMAT "X(15)"  init ""              /*"เลขที่ใบขับขี่คนที่ 2"                 */     
    FIELD namepol     AS CHAR FORMAT "X(50)"  init ""              /*"ชื่อบนหน้ากรมธรรม์"                    */     
    FIELD addpol      AS CHAR FORMAT "X(300)" init ""              /*"ที่อยู่บนหน้ากรมธรรม์"                 */     
    FIELD namsend     AS CHAR FORMAT "X(50)"  init ""              /*"ชื่อที่ส่งเอกสาร"                      */     
    FIELD addsend     AS CHAR FORMAT "X(300)" init ""               /*"ที่อยู่สำหรับส่งเอกสาร"                */     
    FIELD cpcode      AS CHAR FORMAT "X(20)"  init ""              /*"รหัสผลิตกรมธรรม์(รหัสแคมเปน)"          */     
    FIELD dealsub     AS CHAR FORMAT "X(1)"   init ""              /*"flag Dealer แถม"                       */     
    FIELD covpes      AS CHAR FORMAT "X(20)"  init ""              /*"ความรับผิดชอบบุคคลภายนอก/ชีวิตบุคคล"   */     
    FIELD covacc      AS CHAR FORMAT "X(20)"  init ""              /*"ความรับผิดชอบบุคคลภายนอก/ชีวิตร่างกาย" */     
    FIELD covdacc     AS CHAR FORMAT "X(20)"  init ""              /*"ความรับผิดชอบบุคคลภายนอก/ทรัพย์สิน"    */     
    FIELD covaccp     AS CHAR FORMAT "X(20)"  init ""              /*"ความคุ้มครองตามเอกสารแนบท้าย/อุบัติเหตุส่วนบุคคล"   */     
    FIELD covmdp      AS CHAR FORMAT "X(20)"  init ""              /*"ความคุ้มครองตามเอกสารแนบท้าย/ค่ารักษาพยาบาล"        */     
    FIELD covbllb     AS CHAR FORMAT "X(20)"  init ""             /*"ความคุ้มครองตามเอกสารแนบท้าย/ประกันตัวผู้ขับขี่".   */
    FIELD policy72    AS CHAR FORMAT "X(15)" INIT ""
    FIELD policy70    AS CHAR FORMAT "X(15)" INIT ""
    FIELD prepol      AS CHAR FORMAT "X(15)" INIT ""
    FIELD memo        AS CHAR FORMAT "x(50)" INIT ""
    FIELD n_status    AS CHAR FORMAT "x(50)" INIT ""
    FIELD class70     AS CHAR FORMAT "x(5)"  INIT ""
    FIELD producer    AS CHAR FORMAT "x(10)" INIT ""
    FIELD agent       AS CHAR FORMAT "x(10)" INIT ""
    FIELD vatcode     AS CHAR FORMAT "x(10)" INIT ""
    FIELD branch      AS CHAR FORMAT "x(2)"  INIT ""
    FIELD garage      AS CHAR FORMAT "x(2)"  INIT ""
    FIELD campaign    AS CHAR FORMAT "X(20)" INIT ""  /*A60-0263*/
    FIELD colordes    AS CHAR FORMAT "x(20)" INIT "". /*Add by Krittapoj S. A65-0372 16/01/2023*/
    
DEFINE VAR nv_polsend AS CHAR FORMAT "x(20)" .   
DEFINE VAR nv_txtname AS CHAR FORMAT "x(100)".   
DEFINE VAR nv_comdat    AS CHAR INIT "".         
DEFINE VAR nv_expdat    AS CHAR INIT "".         
DEFINE VAR nv_policy72  AS CHAR INIT "".         
DEFINE VAR nv_comdat72  AS CHAR INIT "".         
DEFINE VAR nv_expdat72  AS CHAR INIT "".         
DEFINE BUFFER buwm100   FOR sicuw.uwm100.        
DEF VAR nv_contno72     AS CHAR INIT "" .        
DEF VAR nv_acceffdat72  AS CHAR INIT "" .        
DEF VAR nv_accnpmamt72  AS CHAR INIT "" .        
DEF VAR nv_acno1        AS CHAR INIT "" .        
DEF VAR nv_chkacno1     AS CHAR INIT "" .  
DEFINE NEW SHARED VAR nv_producer   AS INTE INIT 1.
DEFINE NEW SHARED VAR nv_tdatefr    AS DATE FORMAT "99/99/9999".
DEFINE NEW SHARED VAR nv_tdateto    AS DATE FORMAT "99/99/9999".
DEFINE NEW SHARED VAR nv_branfr     AS CHAR FORMAT "X(2)".
DEFINE NEW SHARED VAR nv_branto     AS CHAR FORMAT "X(2)".
DEFINE NEW SHARED VAR nv_type       AS INTE FORMAT ">>9" INIT 1 .
DEFINE NEW SHARED VAR nv_producerfr AS CHAR FORMAT "X(10)".
DEFINE     SHARED VAR nv_recid      AS RECID  NO-UNDO.
DEFINE STREAM ns1.
DEFINE STREAM ns2.
DEFINE VAR nv_row     AS INT  INIT 0.
DEFINE VAR nv_count   AS INT  INIT 0.
DEFINE VAR nv_output  AS CHAR FORMAT "X(45)".
DEFINE VAR nv_output2 AS CHAR FORMAT "X(45)".
DEFINE VAR nv_update      AS CHAR FORMAT "x(10)".
DEFINE VAR nv_updby       AS CHAR FORMAT "x(40)".
DEFINE VAR nv_garage      AS CHAR FORMAT "x(20)".
DEFINE VAR nv_drivname1   AS CHAR FORMAT "x(50)".
DEFINE VAR nv_drivbirt1   AS CHAR FORMAT "x(10)".
DEFINE VAR nv_drivname2   AS CHAR FORMAT "x(50)".
DEFINE VAR nv_drivbirt2   AS CHAR FORMAT "x(10)".
DEFINE VAR nv_delersub    AS CHAR FORMAT "x(60)".
DEFINE VAR nv_policy   AS CHAR FORMAT "X(16)".
DEFINE VAR nv_policy1  AS CHAR FORMAT "X(16)".
DEFINE VAR nv_rencnt   AS INT  FORMAT ">>9".
DEFINE VAR nv_endcnt   AS INT  FORMAT ">>9".
DEFINE VAR nv_riskgp   AS INT  FORMAT "9".
DEFINE VAR nv_riskno   AS INT  FORMAT ">>9".
DEFINE VAR nv_itemno   AS INT  FORMAT ">>9".
DEFINE VAR nv_chkpol   AS CHAR FORMAT "X(30)" INITIAL "" NO-UNDO.
DEFINE VAR nv_trndat   AS CHAR FORMAT "X(8)".
DEFINE VAR nv_cha_no   AS CHAR FORMAT "X(20)".
DEFINE VAR nv_vehreg   AS CHAR FORMAT "X(20)".
DEFINE VAR cr_2pol     AS CHAR FORMAT "X(12)".
DEFINE VAR nv_moddes1  AS CHAR FORMAT "X(18)".
DEFINE VAR nv_moddes2  AS CHAR FORMAT "X(35)".
DEFINE VAR nv_modchk   AS INT.
DEFINE VAR nv_sckno    AS CHAR FORMAT "X(16)". 
DEFINE VAR nv_cedpol   AS CHAR FORMAT "X(16)".
DEFINE VAR nv_tpbiper  AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.     
DEFINE VAR nv_tpbiacc  AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.    
DEFINE VAR nv_tppdacc  AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.    
DEFINE VAR nv_covdacc  AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.
DEFINE VAR nv_sumins   AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.     /*A56-0175*/
DEFINE VAR nv_suminsfi AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.     /*A56-0175*/
DEFINE VAR nv_premgab  AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.     /*A56-0175*/
DEFINE VAR nv_premgabnet  AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.  /*A56-0175*/
DEFINE VAR nv_premgabstm  AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.  /*A56-0175*/
DEFINE VAR nv_deduct   AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.     /*A56-0175*/
DEFINE VAR nv_wth      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.     /*A56-0175*/
DEFINE VAR nv_wthcmp   AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.     /*A56-0175*/
DEFINE VAR nv_411      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.     
DEFINE VAR nv_412      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.    
DEFINE VAR nv_413      AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.    
DEFINE VAR nv_sumprm   AS DECI FORMAT ">>,>>>,>>>,>>9.99-"  INIT 0.00.    
DEFINE VAR nv_rec      AS CHAR FORMAT "x(6)".
DEFINE VAR nv_driver1  AS CHAR FORMAT "X(30)".
DEFINE VAR nv_driver2  AS CHAR FORMAT "X(30)".
DEFINE VAR nv_birdat1  AS CHAR FORMAT "X(8)".  /* DATE FORMAT "99/99/9999".      */
DEFINE VAR nv_birdat2  AS CHAR FORMAT "X(8)".  /* DATE FORMAT "99/99/9999".      */
DEFINE VAR nv_class    AS CHAR FORMAT "X(5)".
DEFINE VAR nv_seatno   AS INT.
DEFINE VAR nv_tons     AS INT.
DEFINE VAR nv_rectyp   AS CHAR FORMAT "X(10)".
DEFINE VAR nv_userid   AS CHAR FORMAT "X(30)".
DEFINE VAR nv_ntitle   AS CHAR FORMAT "X(30)".
DEFINE VAR nv_name1    AS CHAR FORMAT "X(60)".
DEFINE VAR nv_name2    AS CHAR FORMAT "X(60)".
DEFINE VAR nv_Dealer   AS CHAR FORMAT "X(60)".
DEFINE VAR nv_add      AS CHAR FORMAT "X(130)".
DEFINE VAR nv_rgprov   AS CHAR FORMAT "X(30)".
DEFINE VAR nv_weight   AS CHAR FORMAT "X(7)".
DEFINE VAR nv_seat     AS CHAR FORMAT "X(5)".
DEFINE VAR nv_sex1     AS CHAR FORMAT "X(6)".
DEFINE VAR nv_sex2     AS CHAR FORMAT "X(6)".
DEFINE VAR nv_lnumber  AS INT  NO-UNDO.
DEFINE VAR nv_bkdate   AS CHAR.
DEFINE VAR nv_effdate  AS CHAR.
DEFINE VAR nv_expdate  AS CHAR.
DEFINE VAR nv_acceffdat   AS CHAR.
DEFINE VAR nv_accexpdat   AS CHAR.
DEFINE VAR nv_trandte     AS CHAR.
DEFINE VAR nv_birdat11    AS CHAR.    
DEFINE VAR nv_birdat21    AS CHAR. 
/*DEF VAR  CLIENT_BRANCH AS CHAR FORMAT "x(30)"  INIT "" /*A57-0262*/ .*/
DEF VAR   nv_cnt   as  int  init   1.
/*DEF VAR   nv_row   as  int  init   0.*/
DEF VAR   ind_f1   AS  INTE INIT   0.
DEF VAR nv_messag  AS CHAR  INIT  "".
/*DEFINE  WORKFILE wcomp NO-UNDO
/*1*/      FIELD package     AS CHARACTER FORMAT "X(10)"   INITIAL ""
/*2*/      FIELD premcomp    AS DECI FORMAT "->>,>>9.99"    INITIAL 0.
DEF VAR producer_mat AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR agent_mat    AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nnidbr72    AS CHAR FORMAT "x(20)"  INIT "". /*A57-0262*/
DEF VAR nnid72      AS CHAR FORMAT "x(13)"  INIT "". /*A57-0262*/
DEF VAR nnidbr70    AS CHAR FORMAT "x(20)"  INIT "". /*A57-0262*/
DEF VAR nnid70      AS CHAR FORMAT "x(13)"  INIT "". /*A57-0262*/
DEF VAR nv_chaidrep AS CHAR FORMAT "x(100)" INIT "". /*A57-0262*/
DEF VAR nv_type     AS CHAR FORMAT "x(5)" INIT "".
DEF VAR nv_name     AS CHAR FORMAT "x(70)" INIT "".
def var nv_index    as char format "x(3)" init "".
def var n_addr5     as char format "x(100)" init "".
def var n_length    as INT  init 0.
def var n_exp       as char format "x(15)" init "".
def var n_com       as char format "x(15)" init "".
def var n_ic        as char format "x(15)" init "".*/
DEF VAR nv_oldpol  AS CHAR FORMAT "x(15)" INIT "".
/*DEF VAR nv_output   AS CHAR FORMAT "x(60)" INIT "".*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_type fi_process fi_loadname fi_outload ~
bu_file-3 bu_ok bu_exit-2 RECT-381 RECT-382 RECT-383 RECT-387 
&Scoped-Define DISPLAYED-OBJECTS rs_type fi_process fi_loadname fi_outload 

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

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(80)":U 
      VIEW-AS TEXT 
     SIZE 56.83 BY .91
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match file Load ", 1,
"Match Policy ", 2
     SIZE 73 BY 1
     BGCOLOR 28 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 6.67
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 75 BY 1.43
     BGCOLOR 28 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_type AT ROW 3.81 COL 18.33 NO-LABEL
     fi_process AT ROW 7.81 COL 20.5 COLON-ALIGNED NO-LABEL
     fi_loadname AT ROW 5.43 COL 20 COLON-ALIGNED NO-LABEL
     fi_outload AT ROW 6.57 COL 20 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 5.48 COL 83
     bu_ok AT ROW 7.95 COL 85
     bu_exit-2 AT ROW 7.95 COL 95.17
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 6.52 COL 6
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 5.43 COL 6.17
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "**Match file Load ใช้ไฟล์ confirm จาก ICBC  |  Match policy ใช้ไฟล์ Load Data**" VIEW-AS TEXT
          SIZE 64 BY .62 AT ROW 8.91 COL 18.33 WIDGET-ID 2
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "    MATCH FILE CONFIRM (ICBC)" VIEW-AS TEXT
          SIZE 105 BY 2.14 AT ROW 1.1 COL 1.17
          BGCOLOR 29 FGCOLOR 2 FONT 6
     RECT-381 AT ROW 3.33 COL 1.17
     RECT-382 AT ROW 7.52 COL 93.83
     RECT-383 AT ROW 7.52 COL 83.83
     RECT-387 AT ROW 3.62 COL 17.33
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
         TITLE              = "Match text  File Confirm Recepit (ICBC)"
         HEIGHT             = 9
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
ON END-ERROR OF C-Win /* Match text  File Confirm Recepit (ICBC) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text  File Confirm Recepit (ICBC) */
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
        no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        fi_loadname  = cvData.
        nv_output = "".
        IF rs_type = 1 THEN ASSIGN fi_outload  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Load" + NO_add.
        ELSE ASSIGN fi_outload  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_matpol" + NO_add.
       /* ELSE IF ra_matchpol = 3 THEN ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Cancel" + NO_add.*/
        DISP fi_loadname fi_outload WITH FRAME fr_main .     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN 
        nv_reccnt  =  0.
   /* For each  wdetail:
        DELETE  wdetail.
    END.*/
   /* For each  wrec:
        DELETE  wrec.
    END.
    For each  wcancel:
        DELETE  wcancel.
    END.*/
    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.
    RUN proc_matchfile_icbc.
    RELEASE sicuw.uwm100.
    RELEASE sicuw.uwm301.
    RELEASE sicuw.uwm130.
    RELEASE sicuw.uwd132.
    RELEASE stat.mailtxt_fil.
    RELEASE brstat.tlt.
   
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


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type C-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type.
    ASSIGN
        fi_loadname  = ""
        fi_outload   = "".
    DISP rs_type fi_loadname fi_outload  WITH FRAME {&FRAME-NAME}. 
    APPLY "Entry" TO fi_loadname.
    RETURN NO-APPLY.
  
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
      rs_type       = 1
      /*ra_matpoltyp      = 1*/
      gv_prgid          = "WGWICBE2"
     /* fi_producernewf   = "B3M0032" 
      fi_agentnewfo     = "B3M0002" 
      fi_producernewtis = "B3M0003" 
      fi_agentnewtis    = "B3M0002" 
      fi_producerford   = "B3M0033"
      fi_producerno83   = "A0M2008"
      fi_producer83     = "A0M2012"
      fi_agentford      = "B3M0002"
      fi_agentno83      = "B3M0002"
      fi_agent83        = "B3M0002"  .*/
  gv_prog  = "Match Text File Confirm (ICBCTL)"
  fi_process = "Check data file Confirm ICBCTL ....." .
  
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  /*RUN proc_createpack.*/
 /* OPEN QUERY br_comp FOR EACH wcomp.*/
      DISP fi_process  rs_type /*ra_matchpol      fi_producerford   fi_producerno83  fi_producer83   
           fi_agentford     fi_agentno83      fi_agent83       fi_producernewf   
           fi_agentnewfo    fi_producernewtis fi_agentnewtis  ra_matpoltyp*/    WITH FRAM fr_main.
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
  DISPLAY rs_type fi_process fi_loadname fi_outload 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE rs_type fi_process fi_loadname fi_outload bu_file-3 bu_ok bu_exit-2 
         RECT-381 RECT-382 RECT-383 RECT-387 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_match_branch C-Win 
PROCEDURE pd_match_branch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT        PARAMETER nv_status    AS INTE NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER nv_branchin  AS CHARACTER NO-UNDO.
DEFINE VAR                    nv_branchout AS CHARACTER NO-UNDO.
DEF VAR nv_br   AS CHAR.

IF nv_status = 1 THEN DO:
    IF      INDEX(nv_branchin,"1") <> 0 THEN ASSIGN nv_branchin = "001".   
    else IF INDEX(nv_branchin,"2") <> 0 THEN ASSIGN nv_branchin = "002".   
    else IF INDEX(nv_branchin,"3") <> 0 THEN ASSIGN nv_branchin = "003".   
    else IF INDEX(nv_branchin,"4") <> 0 THEN ASSIGN nv_branchin = "004".   
    else IF INDEX(nv_branchin,"5") <> 0 THEN ASSIGN nv_branchin = "005".   
    else IF INDEX(nv_branchin,"6") <> 0 THEN ASSIGN nv_branchin = "006".   
    else IF INDEX(nv_branchin,"7") <> 0 THEN ASSIGN nv_branchin = "007".   
    else IF INDEX(nv_branchin,"8") <> 0 THEN ASSIGN nv_branchin = "008".  
END.
ELSE IF nv_status = 2 THEN DO:
    IF      INDEX(nv_branchin,"01") <> 0 THEN ASSIGN nv_branchin = "001". 
    ELSE IF INDEX(nv_branchin,"02") <> 0 THEN ASSIGN nv_branchin = "002". 
    ELSE IF INDEX(nv_branchin,"03") <> 0 THEN ASSIGN nv_branchin = "003". 
    ELSE IF INDEX(nv_branchin,"04") <> 0 THEN ASSIGN nv_branchin = "004". 
    ELSE IF INDEX(nv_branchin,"05") <> 0 THEN ASSIGN nv_branchin = "005". 
    ELSE IF INDEX(nv_branchin,"06") <> 0 THEN ASSIGN nv_branchin = "006". 
    ELSE IF INDEX(nv_branchin,"07") <> 0 THEN ASSIGN nv_branchin = "007". 
    ELSE IF INDEX(nv_branchin,"08") <> 0 THEN ASSIGN nv_branchin = "008". 
                                         ELSE ASSIGN nv_branchin = "0" + SUBSTR(nv_branchin,1,2).
END.
ELSE IF nv_status = 3 THEN DO:
    IF      INDEX(nv_branchin,"001") <> 0 THEN ASSIGN nv_branchin = "001".      
    ELSE IF INDEX(nv_branchin,"002") <> 0 THEN ASSIGN nv_branchin = "002".      
    ELSE IF INDEX(nv_branchin,"003") <> 0 THEN ASSIGN nv_branchin = "003".      
    ELSE IF INDEX(nv_branchin,"004") <> 0 THEN ASSIGN nv_branchin = "004".      
    ELSE IF INDEX(nv_branchin,"005") <> 0 THEN ASSIGN nv_branchin = "005".      
    ELSE IF INDEX(nv_branchin,"006") <> 0 THEN ASSIGN nv_branchin = "006".      
    ELSE IF INDEX(nv_branchin,"007") <> 0 THEN ASSIGN nv_branchin = "007".      
    ELSE IF INDEX(nv_branchin,"008") <> 0 THEN ASSIGN nv_branchin = "008". 
                                          ELSE ASSIGN nv_branchin =  SUBSTR(nv_branchin,1,3).
END.
FIND LAST stat.Insure WHERE 
    stat.insure.compno  = "icbc"       AND 
    stat.Insure.InsNo   = nv_branchin  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL stat.Insure THEN  
    nv_branchout =  stat.Insure.Branch   .
ELSE nv_branchout = "".
IF nv_branchout = "" THEN DO:
    ASSIGN nv_br = "00" + SUBSTR(nv_branchin,1,1).
    FIND LAST stat.Insure WHERE 
        stat.insure.compno  = "icbc"       AND 
        stat.Insure.InsNo   =  nv_br  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.Insure THEN  
        nv_branchout =  stat.Insure.Branch   .
    ELSE nv_branchout = "".
END.
IF nv_branchout = "" THEN DO:
    ASSIGN nv_br = "0" + SUBSTR(nv_branchin,1,2).
    FIND LAST stat.Insure WHERE 
        stat.insure.compno  = "icbc"       AND 
        stat.Insure.InsNo   =  nv_br  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.Insure THEN  
        nv_branchout =  stat.Insure.Branch   .
    ELSE nv_branchout = "".
END.
IF nv_branchout = "" THEN DO:
    ASSIGN nv_br =   SUBSTR(nv_branchin,1,3).
    FIND LAST stat.Insure WHERE 
        stat.insure.compno  = "icbc"       AND 
        stat.Insure.InsNo   =  nv_br  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.Insure THEN  
        nv_branchout =  stat.Insure.Branch   .
    ELSE nv_branchout = "".
END.

ASSIGN nv_branchin  = nv_branchout.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdata C-Win 
PROCEDURE proc_chkdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_i     AS INT INIT 0.
DEFINE VAR nv_year  AS INTE.
DEFINE VAR nv_day   AS INTE.
DEFINE VAR nv_month AS INTE.
DEFINE VAR n_length AS INT INIT 0 .
DEFINE VAR n_char   AS CHAR FORMAT "x(100)" init "" .
DEFINE VAR Wht70    AS CHAR FORMAT "x(15)" INIT "".
DEFINE VAR Wht72    AS CHAR FORMAT "x(15)" INIT "".
DEFINE VAR np_expdat     AS CHAR FORMAT "X(15)" INIT "".
DEFINE VAR nv_branchout  AS CHAR INIT "" .  /*Add by Kridtiya i. A63-0419 */
ASSIGN nv_acno1       = "".
FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE xmm600.gpstmt = "A0M0079" NO-LOCK.
    ASSIGN nv_acno1       = nv_acno1  + "," + xmm600.acno.
END.
RELEASE sicsyac.xmm600.
FOR EACH Texcel .
  IF INDEX(Texcel.rectype,"Rec") <> 0 THEN DELETE texcel.
  ELSE IF  Texcel.rectype = "" THEN DELETE texcel.
  ELSE DO:
    RUN proc_init.
    ASSIGN Texcel.rectyp = nv_rec
        n_char = ""
        Wht70  = ""
        Wht72  = "".
    fi_process = "Check Data from file confirm...." .
    DISP fi_process WITH FRAME fr_main.
    IF (trim(Texcel.insqno) = "") AND (trim(Texcel.contno) = "")  THEN RUN proc_reportloadgw.  /* 1.not found */
    ELSE IF (trim(Texcel.contno) <> "")  THEN DO:   /* seach by cedpol .. */
      IF Texcel.effdate <> "" THEN DO: /*หาข้อมูลกรมธรรม์ปีปัจจุบัน V70 */
          FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol  = trim(Texcel.contno) NO-LOCK
              BREAK BY sicuw.uwm100.expdat DESCENDING.
              IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
              ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY) THEN NEXT.
              ELSE IF INDEX(nv_acno1,trim(uwm100.acno1)) = 0  THEN NEXT.
              ELSE IF YEAR(sicuw.uwm100.expdat) > YEAR(TODAY) THEN DO:
                ASSIGN np_expdat = ""
                    np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999")
                    nv_expdat = (SUBSTR(Texcel.expdate,7,2) + "/" + SUBSTR(Texcel.expdate,5,2) + "/" + SUBSTR(Texcel.expdate,1,4)).
                IF YEAR(DATE(np_expdat)) = YEAR(DATE(nv_expdat)) THEN DO:
                    ASSIGN  texcel.policy70  = sicuw.uwm100.policy
                        texcel.prepol    = sicuw.uwm100.prvpol
                        Texcel.dealsub = IF INDEX(uwm100.name2,"และ/หรือ") = 0 THEN "N" ELSE "Y".
                    /*  A60-0263 : หา class รถ */
                    FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                      sicuw.uwm120.policy  = sicuw.uwm100.policy   AND
                      sicuw.uwm120.rencnt  = sicuw.uwm100.rencnt   AND
                      sicuw.uwm120.endcnt  = sicuw.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm120 THEN ASSIGN texcel.Class70  =  TRIM(sicuw.uwm120.class) .  /* end A60-0263*/
                END.
                ELSE ASSIGN texcel.policy70 = ""  texcel.prepol = "".
              END.
              ELSE IF YEAR(sicuw.uwm100.expdat) = YEAR(TODAY) THEN ASSIGN texcel.prepol = sicuw.uwm100.policy.
              ELSE ASSIGN texcel.policy70 = ""  texcel.prepol = "".
          END.
          fi_process = "Check Data 70 " + trim(Texcel.contno) + " on sicuw_uwm100...." .
          DISP fi_process WITH FRAME fr_main.
      END.
      /*Add by krittapoj S. A65-0372 16/01/2023*/
     IF Texcel.colordes <> "" THEN DO:
      FIND FIRST brstat.tlt WHERE brstat.tlt.colordes = TRIM(Texcel.colordes) NO-LOCK NO-ERROR.
           IF AVAIL brstat.tlt THEN DO:
               Texcel.colordes = brstat.tlt.colordes.
           END.
      END.
      ELSE Texcel.colordes = "หลายสี".
      /*End by krittapoj S. A65-0372 16/01/2023*/
      IF Texcel.acceffdat <> "" THEN DO:
        FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol  = trim(Texcel.contno) NO-LOCK 
            BREAK BY sicuw.uwm100.expdat DESCENDING.
            IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
            ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY) THEN NEXT.
            ELSE IF INDEX(nv_acno1,trim(uwm100.acno1)) = 0  THEN NEXT.
            ELSE IF YEAR(sicuw.uwm100.expdat) > YEAR(TODAY) THEN DO:
                ASSIGN np_expdat = ""
                    np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999")
                    nv_expdat = (SUBSTR(Texcel.accexpdat,7,2) + "/" + SUBSTR(Texcel.accexpdat,5,2) + "/" + SUBSTR(Texcel.accexpdat,1,4)).
                IF YEAR(DATE(np_expdat)) = YEAR(DATE(nv_expdat)) THEN DO:
                    ASSIGN texcel.policy72 = sicuw.uwm100.policy. 
                END.
                ELSE ASSIGN texcel.policy72 = "".
            END.
        END.
        fi_process = "Check Data 72 " + trim(Texcel.contno) + " on sicuw_uwm100....".
        DISP fi_process WITH FRAME fr_main.
      END.
    END. /* if 70 */
    ELSE IF Texcel.insqno <> "" THEN DO:
      RUN proc_cutchar.
      FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy  = trim(Texcel.insqno) NO-LOCK NO-ERROR.
      IF AVAIL sicuw.uwm100 THEN   
          ASSIGN texcel.policy70 = sicuw.uwm100.policy .
      ELSE ASSIGN texcel.policy70 = "" .
      RELEASE sicuw.uwm100.
      fi_process = "Check Data by pol " + trim(Texcel.insqno) + " on sicuw_uwm100...." .
      DISP fi_process WITH FRAME fr_main.
    END.
    FIND LAST brstat.tlt USE-INDEX tlt05  WHERE   
        trim(brstat.tlt.cha_no)  =  trim(Texcel.chassno) AND              
        brstat.tlt.genusr        =  "ICBCTL"             NO-ERROR NO-WAIT.     
    IF AVAIL brstat.tlt THEN DO:
      IF texcel.policy70 <> "" THEN DO:
        ASSIGN brstat.tlt.releas = "YES"
            brstat.tlt.nor_noti_ins = texcel.policy70
            brstat.tlt.nor_usr_tlt  = "FI " + TRIM(Texcel.covamtthf) +  " Wht70 " + TRIM(Texcel.taxamtins) + " Wht72 " + TRIM(Texcel.acctaxamt)
            brstat.tlt.recac        = "Confirm แล้ว"
            brstat.tlt.dat_ins_noti = IF brstat.tlt.dat_ins_noti = ? THEN TODAY ELSE brstat.tlt.dat_ins_noti
            texcel.n_status         = "ออกกรมธรรม์70 แล้ว ".
        IF TRIM(Texcel.drivers1) <> "" THEN DO:
            ASSIGN tlt.dri_name1 = TRIM(Texcel.drivers1) +
                                   " ID1 " + trim(Texcel.id_driv1) +
                                   " Licen1 " + trim(Texcel.licnodr1)
            tlt.dri_no1   = trim(Texcel.bdaydr1).
        END.
        IF trim(Texcel.drivers2) <> "" THEN DO:
            ASSIGN tlt.dri_name2  = trim(Texcel.drivers2) +
                " ID2 " + trim(Texcel.id_driv2) +
                " Licen2 " + trim(Texcel.licnodr2) 
                tlt.dri_no2  = TRIM(Texcel.bdaydr2) .
        END.
        IF TRIM(Texcel.namepol) <> "" THEN ASSIGN brstat.tlt.rec_addr2 =   TRIM(Texcel.namepol).
        IF TRIM(Texcel.addpol) <> ""  THEN ASSIGN brstat.tlt.rec_addr5 = TRIM(Texcel.addpol).
        IF texcel.policy72 <> "" THEN DO:
          ASSIGN brstat.tlt.comp_pol = texcel.policy72
              brstat.tlt.recac        = IF brstat.tlt.recac = "" THEN "Confirm แล้ว" ELSE brstat.tlt.recac  
              brstat.tlt.dat_ins_noti = IF brstat.tlt.dat_ins_noti = ? THEN TODAY ELSE brstat.tlt.dat_ins_noti
              texcel.n_status         = IF texcel.n_status = "" THEN "ออกกรมธรรม์ 72 แล้ว" ELSE texcel.n_status + "/ออกกรมธรรม์ 72 แล้ว ".
        END.
      END.
      ELSE DO: 
        ASSIGN brstat.tlt.recac   = "Confirm แล้ว" 
          brstat.tlt.dat_ins_noti = IF brstat.tlt.dat_ins_noti = ? THEN TODAY ELSE brstat.tlt.dat_ins_noti
          texcel.prepol    = trim(brstat.tlt.filler1) 
          Texcel.notidate  = string(YEAR(brstat.tlt.trndat),"9999") + 
                             string(MONTH(brstat.tlt.trndat),"99") +
                             string(DAY(brstat.tlt.trndat),"99")
          texcel.class70   = trim(substr(brstat.tlt.safe3,R-INDEX(brstat.tlt.safe3,"class70") + 8,LENGTH(brstat.tlt.safe3)))
          texcel.remark    = IF trim(texcel.remark) <> "" THEN trim(texcel.remark) + " " + trim(brstat.tlt.filler2) 
                             ELSE trim(brstat.tlt.filler2)
          texcel.producer  = brstat.tlt.comp_sub      
          texcel.agent     = brstat.tlt.comp_noti_ins 
          texcel.vatcode   = brstat.tlt.rec_addr1  
          texcel.branch    = STRING(brstat.tlt.EXP)
          /*texcel.garage    = IF index(brstat.tlt.stat,"inspace:") <> 0 THEN 
          SUBSTR(brstat.tlt.stat,1,INDEX(brstat.tlt.stat,"inspace:") - 8 ) ELSE TRIM(brstat.tlt.stat) --A60-0263--*/
          Texcel.notfyby   = trim(brstat.tlt.nor_usr_ins) 
          /*texcel.memo      = IF index(brstat.tlt.stat,"inspace") <> 0 THEN 
          SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"inspace:") + 8 ,LENGTH(brstat.tlt.stat)) ELSE "" --A60-0263--*/
          /*-- A60-0263--*/
          texcel.memo      = IF index(brstat.tlt.stat,"Inspace:") <> 0 THEN SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"Inspace:") + 8 ,LENGTH(brstat.tlt.stat))
                             ELSE ""  
          texcel.garage    = IF index(brstat.tlt.stat,"Inspace:") <> 0 THEN SUBSTR(brstat.tlt.stat,1,LENGTH(brstat.tlt.stat) - (LENGTH(Texcel.memo) + 8)) 
                             ELSE TRIM(brstat.tlt.stat)
          /*-- end : A60-0263--*/
          texcel.n_status  = IF texcel.n_status <> "" THEN texcel.n_status + "/ Confirm Complete" ELSE "Confirm Complete".
          IF brstat.tlt.comp_effdat <> ? AND Texcel.acceffdat = ""  THEN 
          ASSIGN texcel.n_status = texcel.n_status + "/ไม่พบข้อมูล พรบ. ในไฟล์ confirm ".
          IF TRIM(Texcel.drivers1) <> "" THEN DO: 
              ASSIGN tlt.dri_name1 = TRIM(Texcel.drivers1) +
                                 " ID1 " + trim(Texcel.id_driv1) +
                                 " Licen1 " + trim(Texcel.licnodr1)
              tlt.dri_no1   = trim(Texcel.bdaydr1).
          END.
          ELSE DO:
            IF brstat.tlt.dri_name1 <> "" THEN 
              ASSIGN
                n_char            = trim(brstat.tlt.dri_name1) /* ผู้ขับขี่ 1 */
                n_length          = LENGTH(n_char)
                Texcel.licnodr1   = Trim(SUBSTR(n_char,R-INDEX(n_char,"Licen1") + 7,n_length)) /* เลขบัตรผู้ขับขี่1 */
                n_char            = Trim(SUBSTR(n_char,1,R-INDEX(n_char,"Licen1") - 1))
                n_length          = LENGTH(n_char)
                Texcel.drivers1   = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID1") - 2))         /*ระบุผู้ขับขี้1    */  
                Texcel.id_driv1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID1") + 3,n_length))  /*เลขที่ใบขับขี่1   */ 
                Texcel.bdaydr1    = TRIM(brstat.tlt.dri_no1) .   /*วันเดือนปีเกิด1   */ 
          END.
          IF trim(Texcel.drivers2) <> "" THEN DO:
              ASSIGN tlt.dri_name2  = trim(Texcel.drivers2) +
                                      " ID2 " + trim(Texcel.id_driv2) +
                                      " Licen2 " + trim(Texcel.licnodr2) 
                  tlt.dri_no2  = TRIM(Texcel.bdaydr2) .
          END.
          ELSE DO:
            IF brstat.tlt.dri_name2 <> "" THEN 
              ASSIGN  n_char       = trim(brstat.tlt.dri_name2)  /*ผู้ขับขี่ 2*/ 
                n_length           = LENGTH(n_char)
                Texcel.licnodr2    = Trim(SUBSTR(n_char,R-INDEX(n_char,"Licen2") + 7,n_length)) /* เลขบัตรผู้ขับขี่2*/
                n_char             = Trim(SUBSTR(n_char,1,R-INDEX(n_char,"Licen2") - 1))
                n_length           = LENGTH(n_char)
                Texcel.drivers2    = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID2") - 2))          /*ระบุผู้ขับขี้2      */  
                Texcel.id_driv2    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID2") + 3,n_length))   /*เลขที่ใบขับขี่2     */ 
                Texcel.bdaydr2     = TRIM(brstat.tlt.dri_no2) . /*วันเดือนปีเกิด2*/
          END.
          IF TRIM(Texcel.namepol) <> "" THEN ASSIGN brstat.tlt.rec_addr2 =   TRIM(Texcel.namepol).
          IF TRIM(Texcel.addpol) <> ""  THEN ASSIGN brstat.tlt.rec_addr5 = TRIM(Texcel.addpol).
          IF trim(Texcel.accnpmamt) <> "" THEN DO:
              ASSIGN brstat.tlt.rec_addr4 = string(deci(trim(Texcel.accnpmamt))) .
          END.
          IF trim(Texcel.acctaxamt) <> "" THEN DO:
              IF INDEX(brstat.tlt.nor_usr_tlt,"Wht72") <> 0 THEN
                  ASSIGN SUBSTR(brstat.tlt.nor_usr_tlt,R-INDEX(brstat.tlt.nor_usr_tlt,"Wht72") + 6,10) = trim(Texcel.acctaxamt).
              ELSE 
                  ASSIGN brstat.tlt.nor_usr_tlt = brstat.tlt.nor_usr_tlt + " Wht72 " + trim(Texcel.acctaxamt).
          END.
      END.
      ASSIGN texcel.campaign   = TRIM(brstat.tlt.lotno) . /*a60-0263*/
      fi_process = "Check Data " + trim(Texcel.chassno) + " from table tlt " .
      DISP fi_process WITH FRAME fr_main.
    END. /* avail tlt */
    /* check bran */
    fi_process = "Check Branch " + trim(Texcel.contno) + " ....." .
    DISP fi_process WITH FRAME fr_main.
    nv_branchout = "" .  /*Add by Kridtiya i. A63-0419 */
    IF texcel.branch <> "" THEN DO:
        RUN pd_match_branch (INPUT  1
                            ,INPUT-OUTPUT texcel.branch ) .
    END.
    ELSE DO: 
        IF Texcel.rectyp = "INS-RE"  THEN DO:
            IF trim(texcel.prepol) <> "" AND LENGTH(TRIM(texcel.prepol)) = 12 THEN DO:
                IF SUBSTR(texcel.prepol,1,1) = "D" THEN
                    ASSIGN texcel.branch = SUBSTR(texcel.prepol,2,1).
                ELSE DO: 
                    IF INDEX("0123456789",TRIM(texcel.prepol)) <> 0 THEN
                        ASSIGN texcel.branch = SUBSTR(texcel.prepol,1,2).
                    ELSE ASSIGN texcel.branch = "M".
                END.
            END.
            ELSE ASSIGN texcel.branch = "M".
        END.
        ELSE DO:
            ASSIGN  Texcel.contno = trim(Texcel.contno)
                texcel.branch     = SUBSTR(Texcel.contno,1,2).
            IF texcel.branch <> "00" THEN DO:
                RUN pd_match_branch (INPUT 2
                                    ,INPUT-OUTPUT texcel.branch ) .
            END.
            ELSE DO:
                ASSIGN texcel.branch = SUBSTR(Texcel.contno,1,3).
                
                RUN pd_match_branch (INPUT 3
                                    ,INPUT-OUTPUT texcel.branch ) .
            END.
        END.
    END.
  END.       /* els do */
  fi_process = "Check data complete ....." .
  DISP fi_process WITH FRAME fr_main.
END.
RELEASE sicuw.uwm100.
RELEASE brstat.tlt.
RUN proc_reportloadgw.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdata_backup C-Win 
PROCEDURE proc_chkdata_backup :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by Kridtiya i. A63-0419
DEF VAR nv_i      AS INT INIT 0.
DEFINE VAR nv_year  AS INTE.
DEFINE VAR nv_day   AS INTE.
DEFINE VAR nv_month AS INTE.
DEF VAR n_length  AS INT INIT 0 .
DEF VAR n_char    AS CHAR FORMAT "x(100)" init "" .
DEF VAR Wht70 AS CHAR FORMAT "x(15)" INIT "".
DEF VAR Wht72 AS CHAR FORMAT "x(15)" INIT "".
DEF VAR np_expdat AS CHAR FORMAT "X(15)" INIT "".
ASSIGN nv_acno1       = "".
FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE xmm600.gpstmt = "A0M0079" NO-LOCK.
        ASSIGN nv_acno1       = nv_acno1  + "," + xmm600.acno.
END.
RELEASE sicsyac.xmm600.
FOR EACH Texcel .
    IF INDEX(Texcel.rectype,"Rec") <> 0 THEN DELETE texcel.
    ELSE IF  Texcel.rectype = "" THEN DELETE texcel.
    ELSE DO:
        RUN proc_init.
        ASSIGN Texcel.rectyp = nv_rec
               n_char = ""
               Wht70  = ""
               Wht72  = "".
        fi_process = "Check Data from file confirm...." .
        DISP fi_process WITH FRAME fr_main.
        IF (trim(Texcel.insqno) = "") AND (trim(Texcel.contno) = "")  THEN RUN proc_reportloadgw.  /* 1.not found */
        ELSE IF (trim(Texcel.contno) <> "")  THEN DO:   /* seach by cedpol .. */
            IF Texcel.effdate <> "" THEN DO: /*หาข้อมูลกรมธรรม์ปีปัจจุบัน V70 */
               FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol  = trim(Texcel.contno) NO-LOCK 
                                      BREAK BY sicuw.uwm100.expdat DESCENDING.
                  IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
                  ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY) THEN NEXT.
                  ELSE IF INDEX(nv_acno1,trim(uwm100.acno1)) = 0  THEN NEXT.
                  ELSE IF YEAR(sicuw.uwm100.expdat) > YEAR(TODAY) THEN DO:
                    ASSIGN np_expdat = ""
                           np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999")
                           nv_expdat = (SUBSTR(Texcel.expdate,7,2) + "/" + SUBSTR(Texcel.expdate,5,2) + "/" + SUBSTR(Texcel.expdate,1,4)).
                          IF YEAR(DATE(np_expdat)) = YEAR(DATE(nv_expdat)) THEN DO:
                              ASSIGN  texcel.policy70  = sicuw.uwm100.policy
                                      texcel.prepol    = sicuw.uwm100.prvpol
                                      Texcel.dealsub = IF INDEX(uwm100.name2,"และ/หรือ") = 0 THEN "N" ELSE "Y".
                              /*  A60-0263 : หา class รถ */
                              FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                                          sicuw.uwm120.policy  = sicuw.uwm100.policy   AND
                                          sicuw.uwm120.rencnt  = sicuw.uwm100.rencnt   AND
                                          sicuw.uwm120.endcnt  = sicuw.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
                              IF AVAIL sicuw.uwm120 THEN
                                  ASSIGN texcel.Class70  =  TRIM(sicuw.uwm120.class) . 
                              /* end A60-0263*/
                          END.
                          ELSE ASSIGN texcel.policy70 = ""  texcel.prepol = "".
                  END.               
                  ELSE IF YEAR(sicuw.uwm100.expdat) = YEAR(TODAY) THEN ASSIGN texcel.prepol = sicuw.uwm100.policy.
                  ELSE ASSIGN texcel.policy70 = ""  texcel.prepol = "".
               END.
               fi_process = "Check Data 70 " + trim(Texcel.contno) + " on sicuw_uwm100...." .
               DISP fi_process WITH FRAME fr_main.
            END.
            IF Texcel.acceffdat <> "" THEN DO:
                 FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol  = trim(Texcel.contno) NO-LOCK 
                                                          BREAK BY sicuw.uwm100.expdat DESCENDING.
                    IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
                    ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY) THEN NEXT.
                    ELSE IF INDEX(nv_acno1,trim(uwm100.acno1)) = 0  THEN NEXT.
                    ELSE IF YEAR(sicuw.uwm100.expdat) > YEAR(TODAY) THEN DO:
                      ASSIGN np_expdat = ""
                             np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999")
                             nv_expdat = (SUBSTR(Texcel.accexpdat,7,2) + "/" + SUBSTR(Texcel.accexpdat,5,2) + "/" + SUBSTR(Texcel.accexpdat,1,4)).
                            IF YEAR(DATE(np_expdat)) = YEAR(DATE(nv_expdat)) THEN DO:
                                ASSIGN texcel.policy72 = sicuw.uwm100.policy. 
                            END.
                            ELSE ASSIGN texcel.policy72 = "".
                    END.
                 END.
                 fi_process = "Check Data 72 " + trim(Texcel.contno) + " on sicuw_uwm100...." .
                 DISP fi_process WITH FRAME fr_main.
             END.
        END. /* if 70 */
        ELSE IF Texcel.insqno <> "" THEN DO:
             RUN proc_cutchar.
             FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy  = trim(Texcel.insqno) NO-LOCK NO-ERROR.
             IF AVAIL sicuw.uwm100 THEN   
                 ASSIGN texcel.policy70 = sicuw.uwm100.policy .
             ELSE ASSIGN texcel.policy70 = "" .
             RELEASE sicuw.uwm100.
             fi_process = "Check Data by pol " + trim(Texcel.insqno) + " on sicuw_uwm100...." .
             DISP fi_process WITH FRAME fr_main.
       END.

       FIND LAST brstat.tlt USE-INDEX tlt05  WHERE   
                 trim(brstat.tlt.cha_no)  =  trim(Texcel.chassno) AND              
                 brstat.tlt.genusr        =  "ICBCTL"             NO-ERROR NO-WAIT.     
                 IF AVAIL brstat.tlt THEN DO:
                    IF texcel.policy70 <> "" THEN DO:
                        ASSIGN brstat.tlt.releas = "YES"
                               brstat.tlt.nor_noti_ins = texcel.policy70
                               brstat.tlt.nor_usr_tlt = "FI " + TRIM(Texcel.covamtthf) +  " Wht70 " + TRIM(Texcel.taxamtins) + " Wht72 " + TRIM(Texcel.acctaxamt)
                               brstat.tlt.recac        = "Confirm แล้ว"
                               brstat.tlt.dat_ins_noti = IF brstat.tlt.dat_ins_noti = ? THEN TODAY ELSE brstat.tlt.dat_ins_noti
                               texcel.n_status         = "ออกกรมธรรม์70 แล้ว ".
                               
                       IF TRIM(Texcel.drivers1) <> "" THEN DO:
                           ASSIGN tlt.dri_name1 = TRIM(Texcel.drivers1) +
                                                 " ID1 " + trim(Texcel.id_driv1) +
                                                 " Licen1 " + trim(Texcel.licnodr1)
                                  tlt.dri_no1   = trim(Texcel.bdaydr1).
                       END.
                       IF trim(Texcel.drivers2) <> "" THEN DO:
                           ASSIGN tlt.dri_name2  = trim(Texcel.drivers2) +
                                                   " ID2 " + trim(Texcel.id_driv2) +
                                                   " Licen2 " + trim(Texcel.licnodr2) 
                                  tlt.dri_no2  = TRIM(Texcel.bdaydr2) .
                       END.
                       IF TRIM(Texcel.namepol) <> "" THEN 
                           ASSIGN brstat.tlt.rec_addr2 =   TRIM(Texcel.namepol).
                       IF TRIM(Texcel.addpol) <> ""  THEN
                           ASSIGN brstat.tlt.rec_addr5 = TRIM(Texcel.addpol).

                       IF texcel.policy72 <> "" THEN DO:
                        ASSIGN brstat.tlt.comp_pol = texcel.policy72
                               brstat.tlt.recac        = IF brstat.tlt.recac = "" THEN "Confirm แล้ว" ELSE brstat.tlt.recac  
                               brstat.tlt.dat_ins_noti = IF brstat.tlt.dat_ins_noti = ? THEN TODAY ELSE brstat.tlt.dat_ins_noti
                               texcel.n_status         = IF texcel.n_status = "" THEN "ออกกรมธรรม์ 72 แล้ว" ELSE texcel.n_status + "/ออกกรมธรรม์ 72 แล้ว ".
                        END.
                    END.
                    ELSE DO: 
                        ASSIGN brstat.tlt.recac = "Confirm แล้ว" 
                               brstat.tlt.dat_ins_noti = IF brstat.tlt.dat_ins_noti = ? THEN TODAY ELSE brstat.tlt.dat_ins_noti
                               texcel.prepol    = trim(brstat.tlt.filler1) 
                               Texcel.notidate  = string(YEAR(brstat.tlt.trndat),"9999") + 
                                                  string(MONTH(brstat.tlt.trndat),"99") +
                                                  string(DAY(brstat.tlt.trndat),"99")
                               texcel.class70   = trim(substr(brstat.tlt.safe3,R-INDEX(brstat.tlt.safe3,"class70") + 8,LENGTH(brstat.tlt.safe3)))
                               texcel.remark    = IF trim(texcel.remark) <> "" THEN trim(texcel.remark) + " " + trim(brstat.tlt.filler2) 
                                                  ELSE trim(brstat.tlt.filler2)
                               texcel.producer  = brstat.tlt.comp_sub      
                               texcel.agent     = brstat.tlt.comp_noti_ins 
                               texcel.vatcode   = brstat.tlt.rec_addr1  
                               texcel.branch    = STRING(brstat.tlt.EXP)
                               /*texcel.garage    = IF index(brstat.tlt.stat,"inspace:") <> 0 THEN 
                                                  SUBSTR(brstat.tlt.stat,1,INDEX(brstat.tlt.stat,"inspace:") - 8 ) ELSE TRIM(brstat.tlt.stat) --A60-0263--*/
                               Texcel.notfyby   = trim(brstat.tlt.nor_usr_ins) 
                               /*texcel.memo      = IF index(brstat.tlt.stat,"inspace") <> 0 THEN 
                                                  SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"inspace:") + 8 ,LENGTH(brstat.tlt.stat)) ELSE "" --A60-0263--*/
                               /*-- A60-0263--*/
                               texcel.memo      = IF index(brstat.tlt.stat,"Inspace:") <> 0 THEN SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"Inspace:") + 8 ,LENGTH(brstat.tlt.stat))
                                                  ELSE ""  
                               texcel.garage    = IF index(brstat.tlt.stat,"Inspace:") <> 0 THEN SUBSTR(brstat.tlt.stat,1,LENGTH(brstat.tlt.stat) - (LENGTH(Texcel.memo) + 8)) 
                                                  ELSE TRIM(brstat.tlt.stat)
                                /*-- end : A60-0263--*/
                               texcel.n_status  = IF texcel.n_status <> "" THEN texcel.n_status + "/ Confirm Complete" ELSE "Confirm Complete".
                        IF brstat.tlt.comp_effdat <> ? AND Texcel.acceffdat = ""  THEN 
                            ASSIGN texcel.n_status = texcel.n_status + "/ไม่พบข้อมูล พรบ. ในไฟล์ confirm ".
                        IF TRIM(Texcel.drivers1) <> "" THEN DO: 
                           ASSIGN tlt.dri_name1 = TRIM(Texcel.drivers1) +
                                                 " ID1 " + trim(Texcel.id_driv1) +
                                                 " Licen1 " + trim(Texcel.licnodr1)
                                  tlt.dri_no1   = trim(Texcel.bdaydr1).
                        END.
                        ELSE DO:
                            IF brstat.tlt.dri_name1 <> "" THEN 
                              ASSIGN
                                n_char            = trim(brstat.tlt.dri_name1) /* ผู้ขับขี่ 1 */
                                n_length          = LENGTH(n_char)
                                Texcel.licnodr1   = Trim(SUBSTR(n_char,R-INDEX(n_char,"Licen1") + 7,n_length)) /* เลขบัตรผู้ขับขี่1 */
                                n_char            = Trim(SUBSTR(n_char,1,R-INDEX(n_char,"Licen1") - 1))
                                n_length          = LENGTH(n_char)
                                Texcel.drivers1   = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID1") - 2))         /*ระบุผู้ขับขี้1    */  
                                Texcel.id_driv1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID1") + 3,n_length))  /*เลขที่ใบขับขี่1   */ 
                                Texcel.bdaydr1    = TRIM(brstat.tlt.dri_no1) .   /*วันเดือนปีเกิด1   */ 
                        END.
                        IF trim(Texcel.drivers2) <> "" THEN DO:
                           ASSIGN tlt.dri_name2  = trim(Texcel.drivers2) +
                                                   " ID2 " + trim(Texcel.id_driv2) +
                                                   " Licen2 " + trim(Texcel.licnodr2) 
                                  tlt.dri_no2  = TRIM(Texcel.bdaydr2) .
                        END.
                        ELSE DO:
                           IF brstat.tlt.dri_name2 <> "" THEN 
                              ASSIGN 
                                n_char             = trim(brstat.tlt.dri_name2)  /*ผู้ขับขี่ 2*/ 
                                n_length           = LENGTH(n_char)
                                Texcel.licnodr2    = Trim(SUBSTR(n_char,R-INDEX(n_char,"Licen2") + 7,n_length)) /* เลขบัตรผู้ขับขี่2*/
                                n_char             = Trim(SUBSTR(n_char,1,R-INDEX(n_char,"Licen2") - 1))
                                n_length           = LENGTH(n_char)
                                Texcel.drivers2    = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID2") - 2))          /*ระบุผู้ขับขี้2      */  
                                Texcel.id_driv2    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID2") + 3,n_length))   /*เลขที่ใบขับขี่2     */ 
                                Texcel.bdaydr2     = TRIM(brstat.tlt.dri_no2) . /*วันเดือนปีเกิด2*/
                        END.
                        IF TRIM(Texcel.namepol) <> "" THEN 
                           ASSIGN brstat.tlt.rec_addr2 =   TRIM(Texcel.namepol).
                        IF TRIM(Texcel.addpol) <> ""  THEN
                           ASSIGN brstat.tlt.rec_addr5 = TRIM(Texcel.addpol).

                        IF trim(Texcel.accnpmamt) <> "" THEN DO:
                           ASSIGN brstat.tlt.rec_addr4 = string(deci(trim(Texcel.accnpmamt))) .
                        END.
                        IF trim(Texcel.acctaxamt) <> "" THEN DO:
                            IF INDEX(brstat.tlt.nor_usr_tlt,"Wht72") <> 0 THEN
                                ASSIGN SUBSTR(brstat.tlt.nor_usr_tlt,R-INDEX(brstat.tlt.nor_usr_tlt,"Wht72") + 6,10) = trim(Texcel.acctaxamt).
                            ELSE 
                                ASSIGN brstat.tlt.nor_usr_tlt = brstat.tlt.nor_usr_tlt + " Wht72 " + trim(Texcel.acctaxamt).
                        END.
                    END.
                    ASSIGN texcel.campaign   = TRIM(brstat.tlt.lotno) . /*a60-0263*/
                    fi_process = "Check Data " + trim(Texcel.chassno) + " from table tlt " .
                    DISP fi_process WITH FRAME fr_main.
                 END. /* avail tlt */
                 /* check bran */
                 fi_process = "Check Branch " + trim(Texcel.contno) + " ....." .
                 DISP fi_process WITH FRAME fr_main.
                 IF texcel.branch <> "" THEN DO:
                   IF INDEX(texcel.branch,"1") <> 0 THEN ASSIGN texcel.branch = "M".
                   else IF INDEX(texcel.branch,"2") <> 0 THEN ASSIGN texcel.branch = "U".
                   else IF INDEX(texcel.branch,"3") <> 0 THEN ASSIGN texcel.branch = "37".
                   else IF INDEX(texcel.branch,"4") <> 0 THEN ASSIGN texcel.branch = "6".
                   else IF INDEX(texcel.branch,"5") <> 0 THEN ASSIGN texcel.branch = "P".
                   else IF INDEX(texcel.branch,"6") <> 0 THEN ASSIGN texcel.branch = "2".
                   else IF INDEX(texcel.branch,"7") <> 0 THEN ASSIGN texcel.branch = "H".
                   else IF INDEX(texcel.branch,"8") <> 0 THEN ASSIGN texcel.branch = "3".
                 END.
                 ELSE DO: 
                   IF Texcel.rectyp = "INS-RE"  THEN DO:
                       IF trim(texcel.prepol) <> "" AND LENGTH(TRIM(texcel.prepol)) = 12 THEN DO:
                           IF SUBSTR(texcel.prepol,1,1) = "D" THEN
                              ASSIGN texcel.branch = SUBSTR(texcel.prepol,2,1).
                           ELSE DO: 
                               IF INDEX("0123456789",TRIM(texcel.prepol)) <> 0 THEN
                                  ASSIGN texcel.branch = SUBSTR(texcel.prepol,1,2).
                               ELSE ASSIGN texcel.branch = "M".
                           END.
                       END.
                       ELSE ASSIGN texcel.branch = "M".
                   END.
                   ELSE DO:
                       ASSIGN  Texcel.contno = trim(Texcel.contno)
                               texcel.branch = SUBSTR(Texcel.contno,1,2).
                       IF texcel.branch <> "00" THEN DO:
                           IF INDEX(texcel.branch,"01") <> 0 THEN ASSIGN texcel.branch = "M".
                           ELSE IF INDEX(texcel.branch,"02") <> 0 THEN ASSIGN texcel.branch = "U".
                           ELSE IF INDEX(texcel.branch,"03") <> 0 THEN ASSIGN texcel.branch = "37".
                           ELSE IF INDEX(texcel.branch,"04") <> 0 THEN ASSIGN texcel.branch = "6".
                           ELSE IF INDEX(texcel.branch,"05") <> 0 THEN ASSIGN texcel.branch = "P".
                           ELSE IF INDEX(texcel.branch,"06") <> 0 THEN ASSIGN texcel.branch = "2".
                           ELSE IF INDEX(texcel.branch,"07") <> 0 THEN ASSIGN texcel.branch = "H".
                           ELSE IF INDEX(texcel.branch,"08") <> 0 THEN ASSIGN texcel.branch = "3".
                       END.
                       ELSE DO:
                           ASSIGN texcel.branch = SUBSTR(Texcel.contno,1,3).
                            IF INDEX(texcel.branch,"001") <> 0 THEN ASSIGN texcel.branch = "M".
                            ELSE IF INDEX(texcel.branch,"002") <> 0 THEN ASSIGN texcel.branch = "U".
                            ELSE IF INDEX(texcel.branch,"003") <> 0 THEN ASSIGN texcel.branch = "37".
                            ELSE IF INDEX(texcel.branch,"004") <> 0 THEN ASSIGN texcel.branch = "6".
                            ELSE IF INDEX(texcel.branch,"005") <> 0 THEN ASSIGN texcel.branch = "P".
                            ELSE IF INDEX(texcel.branch,"006") <> 0 THEN ASSIGN texcel.branch = "2".
                            ELSE IF INDEX(texcel.branch,"007") <> 0 THEN ASSIGN texcel.branch = "H".
                            ELSE IF INDEX(texcel.branch,"008") <> 0 THEN ASSIGN texcel.branch = "3".
                       END.
                   END.
                 END.
    END. /* els do */
    fi_process = "Check data complete ....." .
    DISP fi_process WITH FRAME fr_main.
END.
RELEASE sicuw.uwm100.
RELEASE brstat.tlt.
RUN proc_reportloadgw.   comment by Kridtiya i. A63-0419*/
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

DEFINE VAR nv_len AS INTE.
ASSIGN  
  nv_polsend = " "
  nv_polsend = trim(Texcel.insqno).
loop_chko1:
REPEAT:
    IF INDEX(nv_polsend,"-") <> 0 THEN DO:
        nv_len    = LENGTH(nv_polsend).
        nv_polsend = TRIM(SUBSTRING(nv_polsend,1,INDEX(nv_polsend,"-") - 1)) +
                    TRIM(SUBSTRING(nv_polsend,INDEX(nv_polsend,"-") + 1, nv_len )) .
    END.
    ELSE LEAVE loop_chko1.
END.
loop_chko2:
REPEAT:
    IF INDEX(nv_polsend,"/") <> 0 THEN DO:
        nv_len = LENGTH(nv_polsend).
        nv_polsend = TRIM(SUBSTRING(nv_polsend,1,INDEX(nv_polsend,"/") - 1)) +
                    TRIM(SUBSTRING(nv_polsend,INDEX(nv_polsend,"/") + 1, nv_len )) .
    END.
    ELSE LEAVE loop_chko2.
END.

IF LENGTH(nv_polsend) <> 12 THEN nv_polsend = SUBSTR(nv_polsend,1,12).
ELSE nv_polsend = nv_polsend.
    


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_init C-Win 
PROCEDURE proc_init :
IF rs_type = 1 THEN /*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_polsend = ""
    nv_polsend    = ""
    nv_update     = ""
    nv_updby      = ""
    nv_garage     = ""
    nv_drivname1  = ""
    nv_drivbirt1  = ""
    nv_drivname2  = ""
    nv_drivbirt2  = ""
    nv_delersub   = ""
    nv_tpbiper    = 0.00    
    nv_tpbiacc    = 0.00   
    nv_tppdacc    = 0.00   
    nv_411        = 0.00     
    nv_412        = 0.00    
    nv_413        = 0.00
    nv_sumins     = 0.00 
    nv_suminsfi   = 0.00
    nv_deduct     = 0.00
    nv_premgab    = 0.00  
    nv_wth        = 0.00 
    nv_wthcmp     = 0.00
    nv_premgabnet = 0.00
    nv_premgabstm = 0.00
    nv_txtname    = "" 
    nv_comdat     = ""  
    nv_expdat     = ""  
    nv_policy72   = ""  
    nv_comdat72   = ""  
    nv_expdat72   = ""
    nv_contno72   = ""   /*a57-0107*/
    nv_acceffdat72 = ""  /*A57-0107*/
    nv_chkacno1    = "no"
    nv_accnpmamt72 = ""
    nv_polsend     = ""
    nv_update      =  ?
    nv_delersub    = ""
    nv_updby       = "" 
    nv_txtname     = trim(Texcel.titlen) + " " + trim(Texcel.cname)  + " " + trim(Texcel.csname)
    nv_comdat      = Texcel.effdate
    nv_expdat      = Texcel.expdate 
    nv_policy72    = Texcel.accpolicy 
    nv_comdat72    = Texcel.acceffdat
    nv_expdat72    = Texcel.accexpdat
    nv_contno72    = trim(Texcel.contno)      
    nv_accnpmamt72 = trim(Texcel.accnpmamt)   
    nv_acceffdat72 = TRIM(Texcel.acceffdat).    
    IF rs_type = 1 THEN DO:
        ASSIGN nv_rec = IF (trim(Texcel.rectype) = "icbc-C") OR  (trim(Texcel.rectype) = "INS_RE") OR 
                        (trim(Texcel.rectype) = "icbc-CA") THEN "INS-RE"  ELSE "INS-R" .           
    END.
    ELSE DO:
        ASSIGN  nv_rec = trim(Texcel.rectype).
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfile_icbc C-Win 
PROCEDURE proc_matchfile_icbc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    For each  Texcel :                             
        DELETE  Texcel.                            
    END.
    IF rs_type = 1 THEN DO:
        INPUT FROM VALUE (fi_loadname) .                                   
        REPEAT: 
            CREATE Texcel.          /*create Texcel....fi_filename2 file pov..... */
            IMPORT DELIMITER "|" 
                Texcel.rectype      /*RecordType       */  
                Texcel.contno       /*contno           */  
                Texcel.id           /*id               */  
                Texcel.insqno       /*insquotationno   */  
                Texcel.bkdate       /*Bookingdate      */  
                Texcel.notidate     /*notifydate       */                                              
                Texcel.inscmp       /*inscmp           */                   
                Texcel.instyp       /*instyp           */                                 
                Texcel.covtyp       /*covtyp           */                                
                Texcel.inslictyp    /*inslictyp        */                                
                Texcel.insyearno    /*insyearno        */                                
                Texcel.policy       /*policy           */                                
                Texcel.covamt       /*covamt           */                                
                Texcel.covamtthf    /*covamttheft      */                                
                Texcel.netamt       /*netpremamt       */                                
                Texcel.groamt       /*gropremamt       */  
                Texcel.taxamtins    /*whtaxamtins      */  
                Texcel.gropduty     /*gropremduty      */                                
                Texcel.effdate      /*effdate          */                                
                Texcel.expdate      /*expiredate       */                                
                Texcel.accpolicy    /*accpolicy        */                                
                Texcel.acccovamt    /*acccovamt        */                                
                Texcel.accnpmamt    /*accnetpremamt    */  
                Texcel.accgpmamt    /*accgropremamt    */                    
                Texcel.acctaxamt    /*accwhtaxamt      */                    
                Texcel.accgpduty    /*accgropremduty   */                    
                Texcel.acceffdat    /*acceffdate       */                  
                Texcel.accexpdat    /*accexpiredate    */                   
                Texcel.dscfamt      /*dscfleetamt      */                         
                Texcel.dscexpr      /*dscexpr&         */                   
                Texcel.dscdeduc     /*dscdeductdeble   */                   
                Texcel.chassno      /*chassino         */                   
                Texcel.enginno      /*EngineNo         */  
                Texcel.caryear      /*Caryear          */                                  
                Texcel.regisprov    /*RegisProv        */                                 
                Texcel.licenno      /*LicenceNo        */                                 
                Texcel.cc           /*CC               */  
                Texcel.brand        /*Brand            */  
                Texcel.model        /*Model&           */  
                Texcel.titlen       /*Title            */  
                Texcel.cname        /*Cname            */  
                Texcel.csname       /*CSname           */  
                Texcel.birthday     /*Bithdte          */  
                Texcel.occuration   /*Occuration       */  
                Texcel.upddte       /*upddte           */  
                Texcel.updby        /*updby            */  
                Texcel.batchno      /*batchno          */  
                Texcel.remark       /*remark           */  
                Texcel.notfyby      /*notifyby         */  
                Texcel.overamt      /*OverAmount       */  
                Texcel.assured      /*Assured          */  
                Texcel.trandte      /*Trandte          */  
                Texcel.claim        /*Claim            */  
                Texcel.drivers1     /*Drivers1         */  
                Texcel.id_driv1     /*id_Driver1       */  
                Texcel.bdaydr1      /*BirthdayDriver1  */  
                Texcel.licnodr1     /*LicenceNoDriver1 */  
                Texcel.drivers2     /*Drivers2         */  
                Texcel.id_driv2     /*id_Driver2       */  
                Texcel.bdaydr2      /*BirthdayDriver2  */  
                Texcel.licnodr2     /*LicenceNoDriver2 */  
                Texcel.namepol      /*Name_policy      */  
                Texcel.addpol       /*Address_policy   */  
                Texcel.namsend      /*Name_send        */  
                Texcel.addsend      /*Address_send     */  
                Texcel.cpcode       /*CampaignCode     */  
                Texcel.dealsub      /*DEALER-SUB       */  
                Texcel.covpes       /*covinjperson     */  
                Texcel.covacc       /*covinjacc        */  
                Texcel.covdacc      /*covdamacc        */  
                Texcel.covaccp      /*covaccperson     */  
                Texcel.covmdp       /*covmedexpen      */  
                Texcel.covbllb      /*covballbond      */  
                Texcel.colordes.    /*Color            */ /*Add by Krittapoj S. A65-0372 16/01/2023*/
        END.  
        RUN proc_chkdata.       /* เช็คกรมธรรม์ file load */ 
    END.
    ELSE DO:
        INPUT FROM VALUE (fi_loadname) .                                   
        REPEAT: 
            CREATE Texcel.          /*create Texcel....fi_filename2 file pov..... */
            IMPORT DELIMITER "|" 
                Texcel.rectype     /*RecordType        */  
                Texcel.contno      /*contno            */  
                Texcel.id          /*id                */
                Texcel.insqno      /*insquotationno    */  
                texcel.prepol      /*prepol            */  
                texcel.policy70    /*policy70          */  
                texcel.policy72    /*policy72          */ 
                Texcel.bkdate      /*Bookingdate       */  
                Texcel.notidate    /*notifydate        */                                      
                Texcel.inscmp      /*inscmp            */           
                Texcel.instyp      /*instyp            */                         
                Texcel.covtyp      /*covtyp            */                        
                Texcel.inslictyp   /*inslictyp         */                        
                Texcel.insyearno   /*insyearno         */  
                Texcel.covamt      /*covamt            */                        
                Texcel.covamtthf   /*covamttheft       */                        
                Texcel.netamt      /*gropremamt        */                        
                Texcel.groamt      /*netpremamt        */  
                Texcel.taxamtins   /*whtaxamtins       */  
                Texcel.gropduty    /*gropremduty       */                        
                Texcel.effdate     /*effdate           */                        
                Texcel.expdate     /*expiredate        */                        
                Texcel.accpolicy   /*accpolicy         */                        
                Texcel.acccovamt   /*acccovamt         */                        
                Texcel.accnpmamt   /*accnetpremamt     */  
                Texcel.accgpmamt   /*accgropremamt     */            
                Texcel.acctaxamt   /*accwhtaxamt       */            
                Texcel.accgpduty   /*accgropremduty    */            
                Texcel.acceffdat   /*acceffdate        */          
                Texcel.accexpdat   /*accexpiredate     */           
                Texcel.dscfamt     /*dscfleetamt       */                 
                Texcel.dscexpr     /*dscexpr           */           
                Texcel.dscdeduc    /*dscdeductdeble    */           
                Texcel.chassno     /*Chassino          */           
                Texcel.enginno     /*EngineNo          */  
                Texcel.caryear     /*Caryear           */                          
                Texcel.regisprov   /*RegisProv         */                         
                Texcel.licenno     /*LicenceNo         */                         
                Texcel.cc          /*CC                */  
                Texcel.brand       /*Brand             */  
                Texcel.model       /*Model             */  
                Texcel.titlen      /*Title             */  
                Texcel.cname       /*Cname             */  
                Texcel.csname      /*CSname            */  
                Texcel.birthday    /*birdthday         */  
                Texcel.occuration  /*occup             */  
                Texcel.upddte      /*upddte            */  
                Texcel.updby       /*updby             */  
                Texcel.batchno     /*batchno           */  
                Texcel.remark      /*remark            */  
                Texcel.notfyby     /*notifyby          */  
                Texcel.overamt     /*OverAmount        */  
                Texcel.assured     /*Assured           */  
                Texcel.trandte     /*Trandte           */  
                Texcel.claim       /*Claim             */  
                Texcel.drivers1    /*Drivers1          */  
                Texcel.id_driv1    /*id_Driver1        */  
                Texcel.bdaydr1     /*BirthdayDriver1   */  
                Texcel.licnodr1    /*LicenceNoDriver1  */  
                Texcel.drivers2    /*Drivers2          */  
                Texcel.id_driv2    /*id_Driver2        */  
                Texcel.bdaydr2     /*BirthdayDriver2   */  
                Texcel.licnodr2    /*LicenceNoDriver2  */  
                Texcel.namepol     /*Name_policy       */  
                Texcel.addpol      /*Address_policy    */  
                Texcel.namsend     /*Name_send         */  
                Texcel.addsend     /*Address_send      */  
                Texcel.cpcode      /*CampaignCode      */  
                Texcel.dealsub     /*Dealer _Sub       */  
                Texcel.covpes      /*covinjperson      */  
                Texcel.covacc      /*covinjacc         */  
                Texcel.covdacc     /*covdamacc         */  
                Texcel.covaccp     /*covaccperson      */  
                Texcel.covmdp      /*covmedexpen       */  
                Texcel.covbllb     /*covbailbond       */  
                texcel.memo        /*Memo..txt         */  
                texcel.Class70     /*Class70           */  
                texcel.Producer    /*Producer          */  
                texcel.Agent       /*Agent             */  
                texcel.VatCode     /*Vat Code          */  
                texcel.Branch      /*Branch            */  
                texcel.Garage      /*Garage            */  
                texcel.n_status    /*Status            */
                Texcel.colordes.   /*Color             */ /*Add by Krittapoj S. A65-0372 16/01/2023*/
        END.
        RUN proc_chkdata.       /* เช็คกรมธรรม์ file load */ 
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportloadgw C-Win 
PROCEDURE proc_reportloadgw :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".CSV"  THEN 
    fi_outload  =  Trim(fi_outload) + ".CSV"  .
ASSIGN nv_cnt =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "RecordType"       
    "contno"           
    "id"               
    "insquotationno"   
    "prepol"           
    "policy70"         
    "policy72"         
    "Bookingdate"      
    "notifydate"       
    "inscmp"           
    "instyp"           
    "covtyp"           
    "inslictyp"        
    "insyearno"        
    "covamt"           
    "covamttheft"      
    "gropremamt"       
    "netpremamt"       
    "whtaxamtins"      
    "gropremduty"      
    "effdate"          
    "expiredate"       
    "accpolicy"        
    "acccovamt"        
    "accnetpremamt"    
    "accgropremamt"    
    "accwhtaxamt"      
    "accgropremduty"   
    "acceffdate"       
    "accexpiredate"    
    "dscfleetamt"      
    "dscexpr"          
    "dscdeductdeble"   
    "Chassino"         
    "EngineNo"         
    "Caryear "         
    "RegisProv"        
    "LicenceNo"        
    "CC"               
    "Brand"            
    "Model"            
    "Title"            
    "Cname"            
    "CSname"           
    "birdthday"        
    "occup"            
    "upddte"           
    "updby"            
    "batchno"          
    "remark"           
    "notifyby"         
    "OverAmount"       
    "Assured"          
    "Trandte"          
    "Claim"            
    "Drivers1"         
    "id_Driver1"       
    "BirthdayDriver1"  
    "LicenceNoDriver1" 
    "Drivers2"         
    "id_Driver2"       
    "BirthdayDriver2"  
    "LicenceNoDriver2" 
    "Name_policy"      
    "Address_policy"   
    "Name_send"        
    "Address_send"     
    "CampaignCode"     
    "Dealer _Sub "     
    "covinjperson"     
    "covinjacc"        
    "covdamacc"        
    "covaccperson"     
    "covmedexpen"      
    "covbailbond"      
    "Memo..txt"
    "Class70"
    "Producer"
    "Agent"
    "Vat Code"
    "Branch "
    "Garage "
    "Campaign" /*A60-0263*/
    "Status"
    "Color ". /*Add by Krittapoj S. A65-0372 16/01/2023*/
FOR EACH Texcel  NO-LOCK.
     nv_row  =  nv_row + 1.
    EXPORT DELIMITER "|" 
       trim(Texcel.rectype)                /*RecordType*/       
       trim(Texcel.contno)  FORMAT "X(10)" /*contno*/           
       trim(Texcel.id)                     /*id*/               
       trim(Texcel.insqno)                 /*insquotationno*/   
       trim(texcel.prepol)                 /*prepol*/           
       trim(texcel.policy70)               /*policy70*/         
       trim(texcel.policy72)               /*policy72*/         
       trim(Texcel.bkdate)                 /*Bookingdate*/      
       trim(Texcel.notidate)               /*notifydate*/       
       trim(Texcel.inscmp)                 /*inscmp*/           
       trim(Texcel.instyp)                 /*instyp*/           
       trim(Texcel.covtyp)                 /*covtyp*/           
       trim(Texcel.inslictyp)              /*inslictyp*/        
       trim(Texcel.insyearno)              /*insyearno*/        
       trim(Texcel.covamt)                 /*covamt*/           
       trim(Texcel.covamtthf)              /*covamttheft*/      
       trim(Texcel.netamt)                 /*gropremamt*/       
       trim(Texcel.groamt)                 /*netpremamt*/       
       trim(Texcel.taxamtins)              /*whtaxamtins*/      
       trim(Texcel.gropduty)               /*gropremduty*/                                                 
       trim(texcel.effdate)   /*SUBSTR(Texcel.effdate,7,2) + "/" + SUBSTR(Texcel.effdate,5,2) + "/" + SUBSTR(Texcel.effdate,1,4)*/       /*effdate*/          
       trim(texcel.expdate)   /*SUBSTR(Texcel.expdate,7,2) + "/" + SUBSTR(Texcel.expdate,5,2) + "/" + SUBSTR(Texcel.expdate,1,4)*/       /*expiredate*/       
       TRIM(Texcel.accpolicy)                       /*accpolicy*/                                                   
       TRIM(Texcel.acccovamt)                       /*acccovamt*/                                                   
       TRIM(Texcel.accnpmamt)                       /*accnetpremamt*/                                               
       TRIM(Texcel.accgpmamt)                       /*accgropremamt*/                                               
       trim(Texcel.acctaxamt)                 /*accwhtaxamt*/                                                 
       trim(Texcel.accgpduty)                 /*accgropremduty*/                                              
       trim(Texcel.acceffdat)    /*SUBSTR(Texcel.acceffdat,7,2) + "/" + SUBSTR(Texcel.acceffdat,5,2) + "/" + SUBSTR(Texcel.acceffdat,1,4) /*acceffdate*/    */   
       trim(Texcel.accexpdat)    /*SUBSTR(Texcel.accexpdat,7,2) + "/" + SUBSTR(Texcel.accexpdat,5,2) + "/" + SUBSTR(Texcel.accexpdat,1,4) /*accexpiredate*/ */   
       trim(Texcel.dscfamt)                        /*dscfleetamt*/                                                 
       trim(Texcel.dscexpr)                        /*dscexpr*/          
       trim(Texcel.dscdeduc)                        /*dscdeductdeble*/   
       trim(Texcel.chassno)                         /*Chassino*/         
       trim(Texcel.enginno)                         /*EngineNo*/         
       trim(Texcel.caryear)                         /*Caryear */         
       trim(Texcel.regisprov)                       /*RegisProv*/        
       trim(Texcel.licenno)                         /*LicenceNo*/        
       trim(Texcel.cc)                              /*CC*/               
       trim(Texcel.brand)                           /*Brand*/            
       trim(Texcel.model)                           /*Model*/            
       trim(Texcel.titlen)                          /*Title*/            
       trim(Texcel.cname)                           /*Cname*/            
       trim(Texcel.csname)                          /*CSname*/           
       trim(Texcel.birthday)                        /*birdthday*/        
       trim(Texcel.occuration)                      /*occup*/            
       TRIM(Texcel.upddte)    /*SUBSTR(Texcel.upddte,7,2) + "/" + SUBSTR(Texcel.upddte,5,2) + "/" + SUBSTR(Texcel.upddte,1,4)*/      /*upddte*/           
       trim(Texcel.updby)                            /*updby*/            
       trim(Texcel.batchno)                         /*batchno*/          
       trim(Texcel.remark)                          /*remark*/           
       trim(Texcel.notfyby)                         /*notifyby*/         
       trim(Texcel.overamt)                         /*OverAmount*/       
       trim(Texcel.assured)                         /*Assured*/          
       trim(Texcel.trandte)                         /*Trandte*/          
       trim(Texcel.claim)                           /*Claim = Garage */            
       trim(Texcel.drivers1)                         /*Drivers1*/         
       trim(Texcel.id_driv1)                         /*id_Driver1*/       
       trim(Texcel.bdaydr1)     /*SUBSTR(Texcel.bdaydr1,7,2) + "/" + SUBSTR(Texcel.bdaydr1,5,2) + "/" + SUBSTR(Texcel.bdaydr1,1,4)*/   /*BirthdayDriver1*/  
       trim(Texcel.licnodr1)                    /*LicenceNoDriver1*/ 
       trim(Texcel.drivers2)                    /*Drivers2*/         
       trim(Texcel.id_driv2)                    /*id_Driver2*/       
       TRIM(Texcel.bdaydr2)                     /*BirthdayDriver2*/  
       trim(Texcel.licnodr2)                    /*LicenceNoDriver2*/ 
       trim(Texcel.namepol)                     /*Name_policy*/      
       trim(Texcel.addpol)                      /*Address_policy*/   
       trim(Texcel.namsend)                     /*Name_send*/        
       trim(Texcel.addsend)                     /*Address_send*/     
       trim(Texcel.cpcode)                      /*CampaignCode*/     
       trim(Texcel.dealsub)                     /*Dealer _Sub */     
       trim(Texcel.covpes)                      /*covinjperson*/     
       trim(Texcel.covacc)                      /*covinjacc*/        
       trim(Texcel.covdacc)                     /*covdamacc*/        
       trim(Texcel.covaccp)                     /*covaccperson*/     
       trim(Texcel.covmdp)                      /*covmedexpen*/      
       trim(Texcel.covbllb)                     /*covbailbond*/      
       TRIM(texcel.memo)                        /*Memo..txt*/
       trim(texcel.Class70)
       trim(texcel.Producer)
       trim(texcel.Agent)
       trim(texcel.VatCode)
       trim(texcel.Branch)
       IF trim(texcel.Garage) = "ซ่อมห้าง" THEN "G" ELSE ""
       TRIM(texcel.campaign)
       IF rs_type = 1 THEN TRIM(texcel.n_status) ELSE ""
       TRIM(texcel.colordes).                    /*Add by Krittapoj S. A65-0372 16/01/2023*/
END.
OUTPUT CLOSE.
MESSAGE "Export data complete " VIEW-AS ALERT-BOX.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

