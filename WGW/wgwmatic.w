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
/*Program name : Match file confirm to policy send ICBC                      */
/*create by    : Ranu I. A59-0288  Match file หาเบอร์กรมธรรม์ส่งกลับ ICBCTL  */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */
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
    FIELD memo        AS CHAR FORMAT "x(50)"    INIT "".
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
&Scoped-Define ENABLED-OBJECTS fi_loadname fi_outload bu_file-3 bu_ok ~
bu_exit-2 RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS fi_loadname fi_outload 

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

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 6.19
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
     fi_loadname AT ROW 4.14 COL 26.67 COLON-ALIGNED NO-LABEL
     fi_outload AT ROW 5.29 COL 26.67 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 4.19 COL 89.67
     bu_ok AT ROW 7.62 COL 64.67
     bu_exit-2 AT ROW 7.62 COL 74.83
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 5.24 COL 12
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 4.14 COL 12.17
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "                                                 MATCH FILE SEND TO ICBCTL" VIEW-AS TEXT
          SIZE 105 BY 2.14 AT ROW 1.1 COL 1.17
          BGCOLOR 10 FGCOLOR 6 FONT 32
     RECT-381 AT ROW 3.38 COL 1.17
     RECT-382 AT ROW 7.19 COL 73.5
     RECT-383 AT ROW 7.19 COL 63.5
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
         TITLE              = "Match File Send to ICBCTL"
         HEIGHT             = 8.52
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
       bu_file-3:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match File Send to ICBCTL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match File Send to ICBCTL */
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
        ASSIGN fi_outload  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Match" + NO_add.
        DISP fi_loadname fi_outload   WITH FRAME fr_main .     
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
     /* ra_matchpol       = 1*/
      /*ra_matpoltyp      = 1*/
      gv_prgid          = "WGWMATIC"
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
  gv_prog  = "Match Text File Confirm (ICBCTL)".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  /*RUN proc_createpack.*/
 /* OPEN QUERY br_comp FOR EACH wcomp.*/
      DISP /*ra_matchpol  **/    /*fi_producerford   fi_producerno83  fi_producer83   
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
  DISPLAY fi_loadname fi_outload 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loadname fi_outload bu_file-3 bu_ok bu_exit-2 RECT-381 RECT-382 
         RECT-383 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exportfile_ic C-Win 
PROCEDURE proc_exportfile_ic :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_expdatuw AS CHAR FORMAT "x(15)".
DEF VAR nv_expdat AS CHAR FORMAT "x(15)".
DEF VAR nv_expfile AS CHAR FORMAT "x(15)".
ASSIGN nv_acno1  = "".
FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE xmm600.gpstmt = "A0M0079" NO-LOCK.
        ASSIGN nv_acno1  = nv_acno1  + "," + xmm600.acno.
END.
RELEASE sicsyac.xmm600.
FOR EACH texcel.
    IF  Texcel.rectype = "" THEN DELETE texcel.
    ELSE DO:
        RUN proc_init.
        IF texcel.contno <> "" THEN DO:
            IF deci(Texcel.netamt) <> 0 THEN DO:
              FOR EACH sicuw.uwm100 USE-INDEX uwm10002  WHERE sicuw.uwm100.cedpol = trim(Texcel.contno) NO-LOCK .
                IF sicuw.uwm100.poltyp  <> "V70"  THEN NEXT.
                ELSE IF sicuw.uwm100.releas  <> YES    THEN NEXT.
                ELSE IF index(nv_acno1,trim(sicuw.uwm100.acno1)) = 0 THEN NEXT.
                ELSE IF sicuw.uwm100.expdat <= TODAY THEN NEXT.
                ELSE DO:
                    ASSIGN nv_expdat  = ""      nv_expfile  = ""    
                           nv_expdat  = STRING(sicuw.uwm100.expdat,"99/99/9999")
                           nv_expfile = SUBSTR(Texcel.expdate,7,2) + "/" + SUBSTR(Texcel.expdate,5,2) + "/" + SUBSTR(Texcel.expdate,1,4).
                    IF YEAR(DATE(nv_expdat)) =  YEAR(DATE(nv_expfile)) THEN DO:
                            ASSIGN 
                                Texcel.policy70  = sicuw.uwm100.policy 
                                Texcel.upddte  = string(year(sicuw.uwm100.trndat),"9999") + STRING(MONTH(sicuw.uwm100.trndat),"99") + STRING(DAY(sicuw.uwm100.trndat),"99")
                                Texcel.dealsub = IF INDEX(sicuw.uwm100.name2,"และ/หรือ") = 0 THEN "N" ELSE "Y"
                                Texcel.effdate = string(YEAR(sicuw.uwm100.comdat),"9999") + string(MONTH(sicuw.uwm100.comdat),"99") + string(DAY(sicuw.uwm100.comdat),"99") 
                                Texcel.expdate = string(YEAR(sicuw.uwm100.expdat),"9999") + string(MONTH(sicuw.uwm100.expdat),"99") + string(DAY(sicuw.uwm100.expdat),"99").
                           
                           FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE sicuw.uwm301.policy = sicuw.uwm100.policy  NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL sicuw.uwm301 THEN DO:
                                ASSIGN Texcel.claim  = IF sicuw.uwm301.garage = "G" THEN "อู่ห้าง" ELSE "อุ่ประกัน".
                                FOR EACH sicuw.uwd132 USE-INDEX uwd13290  WHERE sicuw.uwd132.policy   = sicuw.uwm301.policy  AND
                                    sicuw.uwd132.rencnt   = sicuw.uwm301.rencnt  AND
                                    sicuw.uwd132.endcnt   = sicuw.uwm301.endcnt  AND
                                    sicuw.uwd132.riskno   = sicuw.uwm301.riskno  AND
                                    sicuw.uwd132.itemno   = sicuw.uwm301.itemno  NO-LOCK .
                                    IF      sicuw.uwd132.bencod = "411"  THEN ASSIGN Texcel.covaccp    = String(deci(SUBSTRING(sicuw.uwd132.benvar,31,30))).  
                                    ELSE IF sicuw.uwd132.bencod = "42"   THEN ASSIGN Texcel.covmdp     = String(deci(SUBSTRING(sicuw.uwd132.benvar,31,30))).
                                    ELSE IF sicuw.uwd132.bencod = "43"   THEN ASSIGN Texcel.covbllb    = String(deci(SUBSTRING(sicuw.uwd132.benvar,31,30))).
                                    ELSE IF sicuw.uwd132.bencod = "DOD"  THEN ASSIGN Texcel.dscdeduc   = String(DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))).
                                    ELSE IF sicuw.uwd132.bencod = "DOD2" THEN ASSIGN Texcel.dscdeduc   = string(DECI(Texcel.dscdeduc) +  DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))).
                                    ELSE IF sicuw.uwd132.bencod = "DPD"  THEN ASSIGN Texcel.dscdeduc   = string(DECI(Texcel.dscdeduc) +  DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))).
                                    ASSIGN nv_premgab = nv_premgab + sicuw.uwd132.gap_c
                                           Texcel.netamt = STRING(nv_premgab).
                                END.
                            END.
                            ELSE Texcel.claim = "".
                            FIND  FIRST  stat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                                stat.mailtxt_fil.policy  = sicuw.uwm100.policy + STRING(sicuw.uwm100.rencnt,"99")  + STRING(sicuw.uwm100.endcnt,"999") + "001" + "001"  NO-LOCK  NO-ERROR  NO-WAIT.
                            IF AVAIL stat.mailtxt_fil THEN DO:
                                ASSIGN Texcel.drivers1 = substr(stat.mailtxt_fil.ltext,1,50)
                                       Texcel.bdaydr1  = string(deci(substr(stat.mailtxt_fil.ltext2,7,4)) - 543 , "9999") +
                                                         substr(stat.mailtxt_fil.ltext2,4,2) + substr(stat.mailtxt_fil.ltext2,1,2).
                                FIND  NEXT  stat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                                    stat.mailtxt_fil.policy  = sicuw.uwm100.policy + STRING(sicuw.uwm100.rencnt,"99")  + STRING(sicuw.uwm100.endcnt,"999") + "001" + "001"  NO-LOCK  NO-ERROR  NO-WAIT.
                                IF AVAIL stat.mailtxt_fil THEN  
                                    ASSIGN Texcel.drivers2 =  substr(stat.mailtxt_fil.ltext,1,50)
                                           Texcel.bdaydr2  =  string(deci(substr(stat.mailtxt_fil.ltext2,7,4)) - 543 , "9999") +
                                                              substr(stat.mailtxt_fil.ltext2,4,2) + substr(stat.mailtxt_fil.ltext2,1,2).
                            END.
                            FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE sicuw.uwm130.policy = sicuw.uwm100.policy AND
                                sicuw.uwm130.rencnt = sicuw.uwm100.rencnt AND
                                sicuw.uwm130.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL sicuw.uwm130 THEN
                                ASSIGN  nv_tpbiper  = sicuw.uwm130.uom1_v     nv_tpbiacc  = sicuw.uwm130.uom2_v
                                        nv_tppdacc  = sicuw.uwm130.uom5_v     nv_sumins   = sicuw.uwm130.uom6_v 
                                        nv_suminsfi = sicuw.uwm130.uom7_v       
                                        Texcel.covpes  = string(nv_tpbiper)  
                                        Texcel.covacc  = string(nv_tpbiacc)  
                                        Texcel.covdacc = string(nv_tppdacc)  
                                        Texcel.covamt    = string(nv_sumins)   
                                        Texcel.covamtthf = string(nv_suminsfi).
                            ELSE ASSIGN nv_tpbiper  = 0.00      nv_tpbiacc  = 0.00
                                        nv_tppdacc  = 0.00      nv_sumins   = 0.00
                                        nv_suminsfi = 0.00
                                        Texcel.covpes  = string(nv_tpbiper)    
                                        Texcel.covacc  = string(nv_tpbiacc)    
                                        Texcel.covdacc = string(nv_tppdacc)    
                                        Texcel.covamt    = string(nv_sumins)   
                                        Texcel.covamtthf = string(nv_suminsfi).

                            IF  (R-INDEX(TRIM(nv_txtname),"จก.")     <> 0 ) OR (R-INDEX(TRIM(nv_txtname),"จำกัด") <> 0 ) OR
                                (R-INDEX(TRIM(nv_txtname),"(มหาชน)") <> 0 ) OR (R-INDEX(TRIM(nv_txtname),"INC.")  <> 0 ) OR 
                                (R-INDEX(TRIM(nv_txtname),"CO.")     <> 0 ) OR (R-INDEX(TRIM(nv_txtname),"LTD.")  <> 0 ) OR 
                                (R-INDEX(TRIM(nv_txtname),"LIMITED") <> 0 ) OR (INDEX(TRIM(nv_txtname),"บริษัท")  <> 0 ) OR 
                                (INDEX(TRIM(nv_txtname),"บ.")        <> 0 ) OR (INDEX(TRIM(nv_txtname),"บจก.")    <> 0 ) OR 
                                (INDEX(TRIM(nv_txtname),"หจก.")      <> 0 ) OR (INDEX(TRIM(nv_txtname),"หสน.")    <> 0 ) OR 
                                (INDEX(TRIM(nv_txtname),"บรรษัท")    <> 0 ) OR (INDEX(TRIM(nv_txtname),"มูลนิธิ") <> 0 ) OR 
                                (INDEX(TRIM(nv_txtname),"ห้าง")      <> 0 ) OR (INDEX(TRIM(nv_txtname),"ห้างหุ้นส่วน") <> 0 )  OR 
                                (INDEX(TRIM(nv_txtname),"ห้างหุ้นส่วนจำกัด") <> 0 )  OR (INDEX(TRIM(nv_txtname),"ห้างหุ้นส่วนจำก")   <> 0 )  OR  
                                (INDEX(TRIM(nv_txtname),"และ/หรือ")          <> 0 )  THEN DO: 
                                IF (((nv_premgab * 0.4 )/ 100 ) - (TRUNCATE((nv_premgab * 0.4 )/ 100 ,0))) > 0   THEN    /*A56-0401*/
                                    ASSIGN nv_wth  = ((nv_premgab + (TRUNCATE((nv_premgab * 0.4 )/ 100 ,0)) + 1 ) * 1) / 100 
                                           Texcel.taxamtins = string(nv_wth).
                                ELSE ASSIGN nv_wth = ((nv_premgab + (TRUNCATE((nv_premgab * 0.4 )/ 100 ,0))) * 1) / 100 
                                            Texcel.taxamtins = string(nv_wth).
                            END.
                            ELSE ASSIGN nv_wth = 0.00   Texcel.taxamtins = STRING(nv_wth).
                                        
                            ASSIGN nv_premgabstm   = IF (((nv_premgab * 0.4 )/ 100 ) - TRUNCATE((nv_premgab * 0.4 )/ 100 ,0)) > 0 THEN (TRUNCATE((nv_premgab * 0.4 )/ 100 ,0) + 1 )
                                                     ELSE (TRUNCATE((nv_premgab * 0.4 )/ 100 ,0))
                                   nv_premgabnet   = nv_premgab + nv_premgabstm + (((nv_premgab + nv_premgabstm) * 7) / 100 ) 
                                   Texcel.gropduty = string(nv_premgabstm)                    
                                   Texcel.groamt   = string(nv_premgabnet) .
                        END.  /* year exp = year today */
                    END.    /* year exp > year today */
                END. /* for each */
            END. /* netamt <> ""*/
            /*---V72 --*/
            IF deci(Texcel.accnpmamt) <> 0   THEN DO: 
                 FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE uwm100.cedpol  = trim(Texcel.contno) NO-LOCK.
                    IF uwm100.poltyp  <> "v72" THEN NEXT.
                    IF uwm100.releas  <> YES   THEN NEXT.
                    IF index(nv_acno1,trim(uwm100.acno1)) = 0  THEN NEXT.
                    IF uwm100.expdat <= TODAY THEN NEXT.
                    ELSE DO:
                        ASSIGN nv_expdatuw = ""     nv_expfile = ""
                               nv_expdatuw = STRING(uwm100.expdat,"99/99/9999")
                               nv_expfile  = SUBSTR(Texcel.accexpdat,7,2) + "/" + SUBSTR(Texcel.accexpdat,5,2) + "/" + SUBSTR(Texcel.accexpdat,1,4).
                        IF YEAR(DATE(nv_expdatuw)) = YEAR(DATE(nv_expfile)) THEN DO:
                            ASSIGN Texcel.accpolicy = uwm100.policy  
                                   Texcel.acceffdat = string(YEAR(uwm100.comdat),"9999") + string(MONTH(uwm100.comdat),"99") + string(DAY(uwm100.comdat),"99") 
                                   Texcel.accexpdat = string(YEAR(uwm100.expdat),"9999") + string(MONTH(uwm100.expdat),"99") + string(DAY(uwm100.expdat),"99") .
                            IF  R-INDEX(TRIM(nv_txtname),"จก.")        <> 0  OR R-INDEX(TRIM(nv_txtname),"จำกัด")   <> 0  OR  
                                R-INDEX(TRIM(nv_txtname),"(มหาชน)")    <> 0  OR  R-INDEX(TRIM(nv_txtname),"INC.")   <> 0  OR 
                                R-INDEX(TRIM(nv_txtname),"CO.")        <> 0  OR R-INDEX(TRIM(nv_txtname),"LTD.")    <> 0  OR 
                                R-INDEX(TRIM(nv_txtname),"LIMITED")    <> 0  OR INDEX(TRIM(nv_txtname),"บริษัท")    <> 0  OR 
                                INDEX(TRIM(nv_txtname),"บ.")           <> 0  OR INDEX(TRIM(nv_txtname),"บจก.")      <> 0  OR 
                                INDEX(TRIM(nv_txtname),"หจก.")         <> 0  OR INDEX(TRIM(nv_txtname),"หสน.")      <> 0  OR 
                                INDEX(TRIM(nv_txtname),"บรรษัท")       <> 0  OR INDEX(TRIM(nv_txtname),"มูลนิธิ")   <> 0  OR 
                                INDEX(TRIM(nv_txtname),"ห้าง")         <> 0  OR INDEX(TRIM(nv_txtname),"ห้างหุ้นส่วน")      <> 0  OR 
                                INDEX(TRIM(nv_txtname),"ห้างหุ้นส่วนจำกัด") <> 0  OR INDEX(TRIM(nv_txtname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                                INDEX(TRIM(nv_txtname),"และ/หรือ")          <> 0  THEN DO: 
                                IF  (((deci(nv_accnpmamt72) * 0.4 )/ 100 ) -  TRUNCATE((deci(nv_accnpmamt72) * 0.4 )/ 100 ,0)) > 0 THEN
                                     ASSIGN nv_wthcmp =   ((deci(nv_accnpmamt72) + (TRUNCATE((deci(nv_accnpmamt72) * 0.4 )/ 100 ,0) + 1)) * 1) / 100   
                                            Texcel.acctaxamt  = string(nv_wthcmp).
                                ELSE ASSIGN nv_wthcmp =   ((deci(nv_accnpmamt72) + TRUNCATE((deci(nv_accnpmamt72) * 0.4 )/ 100 ,0)) * 1) / 100   
                                            Texcel.acctaxamt  = string(nv_wthcmp).
                            END.
                            ELSE ASSIGN nv_wthcmp  = 0.00   Texcel.acctaxamt  = string(nv_wthcmp).
                        END.
                    END.
                END.
            END.
            /*--- end V72 --*/
        END.
    END.
END.
RUN proc_outputfile.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_init C-Win 
PROCEDURE proc_init :
/*------------------------------------------------------------------------------
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
    nv_contno72    = trim(Texcel.contno)       /*A57-0107*/
    nv_accnpmamt72 = trim(Texcel.accnpmamt)    /*A57-0107*/
    nv_acceffdat72 = TRIM(Texcel.acceffdat)    /*A57-0107*/
    nv_rec         = IF (trim(Texcel.rectype) = "icbc-C") OR  (trim(Texcel.rectype) = "INS_RE") OR
                        (trim(Texcel.rectype) = "icbc-CA") THEN "INS-RE"  
                     ELSE "INS-R" .          /*A56-0401*/
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
            Texcel.covbllb .    /*covballbond      */
         IF INDEX(Texcel.rectype,"Rec") <> 0 THEN DELETE texcel.
         ELSE IF  Texcel.rectype = "" THEN DELETE texcel.
    END.  
    RUN proc_exportfile_ic. /* ไฟล์ส่ง ICBC */             
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_outputfile C-Win 
PROCEDURE proc_outputfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF INDEX(fi_outload,".csv") = 0  THEN  nv_output = fi_outload + ".CSV".
OUTPUT TO VALUE(nv_output).      /*out put file full policy */
PUT UNFORMATTED 
    "RecordType"                 "|"       /*1*/                 
    "contno"                     "|"       /*2*/       
    "id"                         "|"       /*3*/       
    "insquotationno"             "|"       /*4*/       
    "Bookingdate"                "|"       /*5*/       
    "notifydate"                 "|"       /*6*/        
    "inscmp"                     "|"       /*7*/        
    "instyp"                     "|"       /*8*/        
    "covtyp"                     "|"       /*9*/        
    "inslictyp"                  "|"       /*10*/       
    "insyearno"                  "|"       /*11*/        
    "policy"                     "|"       /*12*/  
    "covamt "                    "|"  
    "covamttheft"                "|"  
    "netpremamt"                 "|"       /*13*/       
    "gropremamt"                 "|"       /*14*/       
    "whtaxamtins"                "|"       /*15*/       
    "gropremduty"                "|"       /*16*/       
    "effdate"                    "|"       /*17*/       
    "expiredate"                 "|"       /*18*/       
    "accpolicy"                  "|"       /*19*/       
    "acccovamt "                 "|"       /*20*/      
    "accnetpremamt"              "|"       /*21*/    
    "accgropremamt"              "|"       /*22*/    
    "accwhtaxamt"                "|"       /*23*/    
    "accgropremduty"             "|"       /*24*/    
    "acceffdate"                 "|"       /*25*/    
    "accexpiredate"              "|"       /*26*/    
    "dscfleetamt"                "|"       /*27*/    
    "dscexpr& "                  "|"       /*28*/    
    "dscdeductdeble"             "|"       /*29*/    
    "chassino"                   "|"       /*30*/   
    "EngineNo"                   "|"       /*31*/    
    "Caryear"                    "|"       /*32*/        
    "RegisProv"                  "|"       /*33*/        
    "LicenceNo"                  "|"       /*34*/        
    "CC"                         "|"       /*35*/
    "Brand"                      "|"       /*38*/ 
    "Model& "                    "|"       /*39*/    
    "Title"                      "|"       /*40*/    
    "Cname"                      "|"       /*41*/   
    "CSname"                     "|"       /*42*/    
    "Bithdte"                    "|"       /*43*/    
    "Occuration"                 "|"       /*44*/ 
    "upddte"                     "|"       
    "updby"                      "|"       
    "batchno"                    "|"       /*45*/    
    "remark"                     "|"       /*46*/    
    "notifyby"                   "|"       /*47*/    
    "OverAmount"                 "|"       /*48*/    
    "Assured "                   "|"       /*49*/ 
    "Trandte"                    "|"       /*51*/    
    "Claim"                      "|"       /*52*/    
    "Drivers1"                   "|"       /*53*/    
    "id_Driver1"                 "|"       /*54*/     
    "BirthdayDriver1"            "|"       /*55*/     
    "LicenceNoDriver1"           "|"       /*56*/     
    "Drivers2"                   "|"       /*57*/    
    "id_Driver2"                 "|"       /*58*/    
    "BirthdayDriver2"            "|"       /*59*/         
    "LicenceNoDriver2 "          "|"       /*60*/      
    "Name_policy"                "|"       /*61*/      
    "Address_policy"             "|"       /*62*/      
    "Name_send"                  "|"       /*63*/      
    "Address_send"               "|"       /*64*/      
    "CampaignCode"               "|"       /*65*/      
    "DEALER-SUB"                 "|"       /*66*/      
    "covinjperson"               "|"       /*67*/      
    "covinjacc"                  "|"       /*68*/      
    "covdamacc"                  "|"       /*69*/      
    "covaccperson"               "|"       /*70*/      
    "covmedexpen"                "|"       /*71*/      
    "covbailbond"                SKIP.     /*74*/ 
FOR EACH Texcel  NO-LOCK.
    PUT UNFORMATTED 
        Texcel.rectype         "|"     /*  1  RecordType    */      
        Texcel.contno          "|"     /*  2  contno        */      
        Texcel.id              "|"     /*  3  id            */      
        Texcel.insqno          "|"     /*  4  insquotationno*/      
        Texcel.bkdate          "|"     /*  5  Bookingdate   */      
        Texcel.notidate        "|"     /*  6  notifydate    */      
        Texcel.inscmp          "|"     /*  7  inscmp        */      
        Texcel.instyp          "|"     /*  8  instyp covcod @ premium*/ /*         */              
        Texcel.covtyp          "|"     /*  9  covtyp        */      
        Texcel.inslictyp       "|"     /*  10 inslictyp class math..seat.*//*       */  
        Texcel.insyearno       "|"      
        Texcel.policy70        "|"     /*  policy no */                                                       
        Texcel.covamt          "|"     /*  13 covamt        */
        Texcel.covamtthf       "|"     /*  14 covamttheft   */                                                                                
        Texcel.netamt          "|"     /*  15 netpremamt    */                                                                                
        Texcel.groamt          "|"     /*  16 gropremamt    */   /*Texcel.groamt */                 
        Texcel.taxamtins       "|"     /*  17 whtaxamtins   */                  
        Texcel.gropduty        "|"     /*  18 gropremduty   */                                                                                
        Texcel.effdate         "|"     /*  19 effdate       */                                                                                
        Texcel.expdate         "|"     /*  20 expiredate    */                                              
        IF texcel.policy72 <> "" THEN texcel.policy72 ELSE Texcel.accpolicy       "|"     /*  21 accpolicy     */                                                                
        Texcel.acccovamt       "|"     /*  22 acccovamt     */                                                           
        Texcel.accnpmamt       "|"     /*  23 accnetpremamt */                                
        Texcel.accgpmamt       "|"     /*  24 accgropremamt */                                               
        Texcel.acctaxamt       "|"     /*  25  accwhtaxamt  */                                               
        Texcel.accgpduty       "|"     /*  26  accgropremduty*/                                              
        Texcel.acceffdat       "|"     /*  27  acceffdate    */                                            
        Texcel.accexpdat       "|"     /*  28  accexpiredate */                                             
        Texcel.dscfamt         "|"     /*  29  dscfleetamt   */                                            
        Texcel.dscexpr         "|"     /*  30  dscexpr       */                                      
        Texcel.dscdeduc        "|"     /*  31  dscdeductdeble*/                                      
        Texcel.chassno         "|"     /*  32  Chassino      */                                      
        Texcel.enginno         "|"     /*  33  EngineNo      */                        
        Texcel.caryear         "|"     /*  34  Caryear       */                                                     
        Texcel.regisprov       "|"     /*  35  RegisProv     */                                                    
        Texcel.licenno         "|"     /*  38  LicenceNo     */                                                    
        Texcel.cc              "|"     /*  41  Model       */                          
        Texcel.brand           "|"     /*  42  Title       */                          
        Texcel.model           "|"     /*  43  Cname       */                          
        Texcel.titlen          "|"     /*  44  CSname      */                          
        Texcel.cname           "|"     /*  45  วันเกิดของผู้เอาประกัน */               
        Texcel.csname          "|"     /*  46  อาชีพ       */                                                             
        Texcel.birthday        "|"     /*  45  upddte      */                          
        Texcel.occuration      "|"     /*  46  updby       */                          
        Texcel.upddte          "|"     /*  47  batchno     */                          
        Texcel.updby           "|"     /*  48  remark      */                          
        Texcel.batchno         "|"     /*  49  notifyby    */                          
        Texcel.remark          "|"     /*  51  OverAmount      */                      
        Texcel.notfyby         "|"     /*  52  Assured         */                      
        Texcel.overamt         "|"     /*  53  Trandte         */                      
        Texcel.assured         "|"     /*  54  Claim           */                      
        Texcel.trandte         "|"     /*  55  Drivers1        */                      
        Texcel.claim           "|"     /*  56  id_Driver1      */                      
        Texcel.drivers1        "|"     /*  57  BirthdayDriver1 */                      
        Texcel.id_driv1        "|"     /*  58  LicenceNoDriver1*/                      
        Texcel.bdaydr1         "|"     /*  59  Drivers2        */                      
        Texcel.licnodr1        "|"     /*  60  id_Driver2      */                      
        Texcel.drivers2        "|"     /*  61  BirthdayDriver2 */                      
        Texcel.id_driv2        "|"     /*  62  LicenceNoDriver2*/                      
        Texcel.bdaydr2         "|"     /*  63  Name_policy     */                      
        Texcel.licnodr2        "|"     /*  64  Address_policy  */                      
        Texcel.namepol         "|"     /*  65  Name_send       */                      
        Texcel.addpol          "|"     /*  66  Address_send    */                      
        Texcel.namsend         "|"     /*  67  CampaignCode    */                      
        Texcel.addsend         "|"     /*  68  Dealer _Sub     */                      
        Texcel.cpcode          "|"     /*  69  covinjperson    */                      
        Texcel.dealsub         "|"     /*  70  covinjacc       */                      
        Texcel.covpes          "|"     /*  71  covdamacc       */                      
        Texcel.covacc          "|"     /*  72  covaccperson    */                      
        Texcel.covdacc         "|"     /*  73  covmedexpen     */                      
        Texcel.covaccp         "|"                                                     
        Texcel.covmdp          "|"                                                     
        Texcel.covbllb         SKIP. 
END.
OUTPUT  CLOSE.
MESSAGE "Export data complete " VIEW-AS ALERT-BOX.    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

