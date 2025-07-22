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
/*Program name : Match Text File Confirm (THANACHAT)                       */
/*create by    : Ranu i. A59-0316   โปรแกรม match file ต่ออายุธนชาต        */
/*               Match file confirm , match policy , match file cancel         */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */
/*---------------------------------------------------------------------------*/
/*Modify by   : Ranu i. A59-0471   ปิด Procedured match policy แก้ไขตัวเลือกเป็น  */
/*              Match file confirm , match file cancel , match No Confirm  */  
/*Modify By   : Ranu I. A60-0383 date. 05/09/2017 เพิ่มการเช็คข้อมูลฝั่งใบเตือน และดึงข้อมูล
                Class และประเภทการใช้งาน จากพารามิเตอร์                     */
/*Modify by : Ranu I. A60-0545 Date: 20/12/2017
            : เปลี่ยน format File แจ้งงานป้ายแดง    */    
/*Modify by : Ranu I. a61-0512 date 02/11/2018 
            : เปลี่ยนฟอร์แมตไฟล์คอนเฟิร์ม และเพิ่มข้อมูลในไฟล์โหลด เพื่อเก็บลงพรีเมียม */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/* Modify by: Ranu I. A64-0205 แก้ไขสาขา และเพิ่มงานต่ออายุ TM */
/* Modify by : Kridtiya i. A66-0160 Date. 15/08/2023 Add color */
/*-------------------------------------------------------------------------*/
DEF VAR gv_id  AS CHAR FORMAT "X(12)" NO-UNDO.  /* A60-0383 */
DEF VAR n_user  AS CHAR FORMAT "X(12)" NO-UNDO.  /* A60-0383 */
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO.  /* A60-0383 */
DEF  stream ns1.
DEFINE VAR  nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR  nv_reccnt      AS  INT  INIT  0.
DEFINE VAR  nv_completecnt AS   INT   INIT  0.
DEFINE VAR  nv_enttim      AS  CHAR          INIT  "".
DEFINE VAR  nv_export      as  date  init  ""  format "99/99/9999".
DEF stream  ns2.
DEFINE VAR nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
{ wgw\wgwtnce2.i }
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
    FIELD engine        AS CHAR FORMAT "X(20)"  INIT ""   /*เลขเครื่อง            */           
    FIELD chassis       AS CHAR FORMAT "X(20)"  INIT ""   /*เลขถัง                */           
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
    FIELD drivename     AS CHAR FORMAT "X"      INIT ""   /*ระบุผู้ขับขี่        */
    FIELD name2         AS CHAR FORMAT "X(50)" INIT ""   /*ชื่อผู้เอาประกันภัย   */
    field comp          as char format "x(2)"   init ""
    field age1          as char format "x(2)"   init ""
    field age2          as char format "x(2)"   init ""
    field Prempa        as char format "x(2)"   init ""
    field class         as char format "x(4)"   init ""
    field Redbook       as char format "x(10)"  init ""
    field opnpol        as char format "x(20)"  init ""
    field bandet        as char format "x(50)"  init ""
    field branch_safe   as char format "x(2)"  init ""
    field vatcode       as char format "x(10)"  init ""
    FIELD pol70         AS CHAR FORMAT "x(15)" INIT ""
    FIELD policy        AS CHAR FORMAT "X(15)"  INIT ""
    FIELD addr1         as char format "x(35)"  init ""                                        
    FIELD addr2         as char format "x(35)"  init ""
    FIELD addr3         as char format "x(35)"  init ""
    FIELD addr4         as char format "x(35)"  init ""
    FIELD pol_title     as char format "x(15)"  init ""
    FIELD pol_fname     as char format "x(50)"  init ""
    FIELD pol_lname     as char format "x(50)"  init ""
    FIELD not_time      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD pol_type      as char format "x(5)"  init ""
    FIELD agent         AS char format "x(10)"  init ""
    FIELD producer      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD finit_code    AS CHAR FORMAT "X(10)"   INIT ""
    FIELD CODE_rebate   AS CHAR FORMAT "x(15)" INIT ""
    field ton           as char format "x(5)" init ""
    field Seat          as char format "x(2)" init ""
    field Body          as char format "x(15)" init ""
    field Vehgrp        as char format "x(2)" init ""
    field comment       as char format "X(30)"  INIT ""
    field pass          as char format "X(2)" INIT "" 
    FIELD campaign      AS CHAR FORMAT "x(20)" INIT ""  
    FIELD ispno         AS CHAR FORMAT "x(20)" INIT ""  /*A61-0512*/ 
    FIELD typ_paid      AS CHAR FORMAT "X(25)" INIT ""  /*A61-0512*/ 
    FIELD paid_date     AS CHAR FORMAT "x(15)" INIT ""  /*A61-0512*/ 
    FIELD conf_date     AS CHAR FORMAT "X(15)" INIT ""   /*A61-0512*/ 
    FIELD ncolor        as char format "x(50)"  init ""  /*A66-0160*/
    FIELD ACCESSORY     as char format "x(250)"  init "". /*A66-0160*/
/* comment by A61-0512 .....
DEFINE NEW SHARED TEMP-TABLE wrec NO-UNDO
    FIELD not_date      AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่รับแจ้ง           */
    FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""    /*เลขที่รับแจ้ง           */
    FIELD Account_no    AS CHAR FORMAT "X(20)"  INIT ""    /*สาขา – เลขที่สัญญา */  
    FIELD not_office    AS CHAR FORMAT "X(35)"  INIT ""    /*ชื่อประกันภัย         *//*ชื่อผู้เอาประกันภัย*/    
    FIELD ctype         AS CHAR FORMAT "X(15)"  INIT ""    /*สมัครใจ/พรบ.            */
    FIELD comdat        AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่เริ่มคุ้มครอง*/      
    FIELD expdat        AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่สิ้นสุด           */
    FIELD prem          AS CHAR FORMAT "X(15)"  INIT ""    /*ค่าเบี้ยประกันภัยรวม*/     
    FIELD paydate       AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่ลูกค้าชำระเบี้ยครั้งสุดท้าย*/
    FIELD prevpol       AS CHAR FORMAT "x(15)"  INIT ""    /*A60-0383*/
    FIELD loss          AS CHAR FORMAT "x(10)"  INIT ""    /*A60-0383*/
    FIELD remark        AS CHAR FORMAT "X(15)"  INIT "" .
    .. end A61-0512.....*/
DEFINE NEW SHARED TEMP-TABLE wcancel NO-UNDO
    FIELD n_no          AS CHAR FORMAT "x(3)" INIT ""     /* ลำดับที่ */            /*A60-0383*/
    FIELD Notify_end     AS CHAR FORMAT "X(18)"  INIT ""  /* เลขที่สลักหลัง    */                   
    FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""   /*เลขที่รับแจ้ง      */                   
    FIELD enddate       AS CHAR FORMAT "X(15)"  INIT ""   /*วันที่ทำสลักหลัง   */ 
    FIELD notidate      AS CHAR FORMAT "x(15)" INIT ""    /*วันที่แจ้งงาน */          /*A60-0383*/  
    FIELD pol_no        AS CHAR FORMAT "X(20)"  INIT ""   /*เลขที่กรมธรรม์/พรบ.*/                   
    FIELD licence       AS CHAR FORMAT "X(11)"  INIT ""   /*ทะเบียน            */                   
    FIELD province      AS CHAR FORMAT "X(30)"  INIT ""   /*จังหวัด            */                   
    FIELD Account_no    AS CHAR FORMAT "X(20)"  INIT ""   /*สาขา-เลขที่สํญญา   */                   
    FIELD ins_name      AS CHAR FORMAT "X(35)"  INIT ""   /*ชื่อผู้เอาประกัน   */                   
    FIELD typ_end       AS CHAR FORMAT "X(15)"  INIT ""   /*หัวข้อที่แก้ไข     */                   
    FIELD ctype         AS CHAR FORMAT "X(15)"  INIT ""   /*ประเภทสลักหลัง     */                   
    FIELD olddata       AS CHAR FORMAT "X(30)"  INIT ""   /*ข้อมูลเดิม         */                   
    FIELD newdata       AS CHAR FORMAT "X(30)"  INIT ""   /*ข้อมูลใหม่         */                   
    FIELD remark_main   AS CHAR FORMAT "X(50)"  INIT ""   /*เหตุผลหลัก         */                   
    FIELD remark_sub    AS CHAR FORMAT "X(50)"  INIT ""   /*เหตุผลย่อย         */                   
    FIELD payby         AS CHAR FORMAT "X(15)"  INIT ""   /*ชำระโดย            */                   
    FIELD nbank         AS CHAR FORMAT "X(15)"  INIT ""   /*ธนาคาร             */                   
    FIELD paydate       AS CHAR FORMAT "X(15)"  INIT ""   /*วันที่ลูกค้ารับชำระเบี้ยครั้งสุดท้าย*/  
    FIELD remark        AS CHAR FORMAT "X(50)"  INIT ""   /*หมายเหตุ           */                   
    FIELD cust_date     AS CHAR FORMAT "X(15)"  INIT ""   /*วันที่รับกรมธรรม์  */ 
    FIELD datastatus    AS CHAR FORMAT "X(15)"  INIT "".
 DEF VAR  ID_NO1        AS CHAR FORMAT "x(15)"  INIT "" /*A57-0262*/ .
DEF VAR  CLIENT_BRANCH AS CHAR FORMAT "x(30)"  INIT "" /*A57-0262*/ .
DEFINE TEMP-TABLE wdetail3 NO-UNDO
    FIELD policyid      AS CHAR FORMAT "x(30)" INIT ""
    FIELD poltyp        AS CHAR FORMAT "x(3)" INIT ""
    FIELD ID_NO1        AS CHAR FORMAT "x(15)"  INIT "" /*A57-0262*/  
    FIELD CLIENT_BRANCH AS CHAR FORMAT "x(30)"  INIT "" /*A57-0262*/ .
DEFINE TEMP-TABLE wdetail2 NO-UNDO
    FIELD nppolicy     AS CHAR FORMAT "x(30)" INIT ""
    FIELD tambon70     AS CHAR FORMAT "x(35)" INIT ""     
    FIELD amper70      AS CHAR FORMAT "x(35)" INIT ""     
    FIELD country70    AS CHAR FORMAT "x(35)" INIT ""     
    FIELD post70       AS CHAR FORMAT "x(5)"  INIT "" 
    FIELD nnproducer   AS CHAR FORMAT "x(30)" INIT ""
    FIELD nnagent      AS CHAR FORMAT "x(30)" INIT ""
    FIELD nnbranch     AS CHAR FORMAT "x(2)"  INIT ""
    FIELD nntyppol     AS CHAR FORMAT "x(20)" INIT ""
    FIELD npRedbook    AS CHAR FORMAT "x(10)" INIT ""          /*A57-0262*/
    FIELD npPrice_Ford AS CHAR FORMAT "x(20)" INIT ""          /*A57-0262*/
    FIELD npYear       AS CHAR FORMAT "x(10)" INIT ""          /*A57-0262*/
    FIELD npBrand_Mo   AS CHAR FORMAT "x(60)" INIT ""          /*A57-0262*/
    FIELD npid70       AS CHAR FORMAT "x(13)" INIT ""          /*A57-0262*/
    FIELD npid70br     AS CHAR FORMAT "x(20)" INIT ""          /*A57-0262*/
    FIELD npid72       AS CHAR FORMAT "x(13)" INIT ""          /*A57-0262*/
    FIELD npid72br     AS CHAR FORMAT "x(20)" INIT ""     .    /*A57-0262*/
DEF VAR tambon70      AS CHAR FORMAT "x(35)" INIT "".     
DEF VAR amper70       AS CHAR FORMAT "x(35)" INIT "" .    
DEF VAR country70     AS CHAR FORMAT "x(35)" INIT "".     
DEF VAR post70        AS CHAR FORMAT "x(5)"  INIT "" .
DEF VAR nnproducer   AS CHAR FORMAT "x(30)" INIT "" .
DEF VAR nnagent      AS CHAR FORMAT "x(30)" INIT "" .
DEF VAR nnbranch     AS CHAR FORMAT "x(2)" INIT "" .
DEF VAR nntyppol     AS CHAR FORMAT "x(20)" INIT "".
DEF VAR npRedbook    AS CHAR FORMAT "x(10)" INIT "".    /*A57-0262*/
DEF VAR npPrice_Ford AS CHAR FORMAT "x(20)" INIT "".    /*A57-0262*/
DEF VAR npYear       AS CHAR FORMAT "x(10)" INIT "".    /*A57-0262*/
DEF VAR npBrand_Mo   AS CHAR FORMAT "x(60)" INIT "".    /*A57-0262*/
DEF VAR npid70       AS CHAR FORMAT "x(13)" INIT "".    /*A57-0262*/
DEF VAR npid70br     AS CHAR FORMAT "x(20)" INIT "".    /*A57-0262*/
DEF VAR npid72       AS CHAR FORMAT "x(13)" INIT "".    /*A57-0262*/
DEF VAR npid72br     AS CHAR FORMAT "x(20)" INIT "".    /*A57-0262*/
/*------------------------------ข้อมูลผู้ขับขี่ -------------------------*/
DEFINE WORKFILE  wdriver NO-UNDO
FIELD RecordID     AS CHAR FORMAT "X(02)"    INIT ""            /*1 Detail Record "D"*/
FIELD Pro_off      AS CHAR FORMAT "X(02)"    INIT ""            /*2 รหัสสาขาที่ผู้เอาประกันเปิดบัญชี    */
FIELD chassis      AS CHAR FORMAT "X(25)"    INIT ""            /*3 หมายเลขตัวถัง    */
FIELD dri_no       AS CHAR FORMAT "X(02)"    INIT ""            /*4 ลำดับที่คนขับ  */
FIELD dri_name     AS CHAR FORMAT "X(40)"    INIT ""            /*5 ชื่อคนขับ   */
FIELD Birthdate    AS CHAR FORMAT "X(8)"     INIT ""            /*6 วันเดือนปีเกิด  */
FIELD occupn       AS CHAR FORMAT "X(75)"    INIT ""            /*7 อาชีพ*/
FIELD position     AS CHAR FORMAT "X(40)"    INIT ""  .         /*8 ตำแหน่งงาน */
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   ind_f1   AS  INTE INIT   0.
DEF VAR nv_messag  AS CHAR  INIT  "".
DEFINE  WORKFILE wcomp NO-UNDO
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
def var n_ic        as char format "x(15)" init "".
DEF VAR nv_oldpol  AS CHAR FORMAT "x(15)" INIT "".
DEF VAR nv_output   AS CHAR FORMAT "x(60)" INIT "".
DEF VAR nv_access  AS CHAR format "x(500)" init "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_matchpol fi_loadname fi_outload bu_file-3 ~
bu_ok bu_exit-2 fi_outload2 fi_outload3 fi_para fi_date RECT-381 RECT-382 ~
RECT-383 RECT-384 
&Scoped-Define DISPLAYED-OBJECTS ra_matchpol fi_loadname fi_outload ~
fi_outload2 fi_outload3 fi_para fi_date 

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

DEFINE VARIABLE fi_date AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loadname AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload2 AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload3 AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_para AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_matchpol AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match File Confirm Receipt ", 1,
"Match File Cancel ", 2,
"Match File No Confirm ", 3
     SIZE 95.5 BY 1
     BGCOLOR 14 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 12.38
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 98.5 BY 1.43
     BGCOLOR 14 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_matchpol AT ROW 4.05 COL 6.33 NO-LABEL
     fi_loadname AT ROW 8.19 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_outload AT ROW 9.33 COL 29.5 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 8.24 COL 92.5
     bu_ok AT ROW 13.33 COL 66.33
     bu_exit-2 AT ROW 13.33 COL 76.5
     fi_outload2 AT ROW 10.43 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_outload3 AT ROW 11.52 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_para AT ROW 5.67 COL 29.67 COLON-ALIGNED NO-LABEL
     fi_date AT ROW 7.1 COL 29.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 9.29 COL 14.83
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "OUTPUT FILE ERROR :" VIEW-AS TEXT
          SIZE 24 BY 1 AT ROW 11.48 COL 7
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 8.19 COL 15.17
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "OUTPUT FILE LOAD :" VIEW-AS TEXT
          SIZE 21.67 BY 1 AT ROW 10.38 COL 8.67
          BGCOLOR 8 FGCOLOR 2 FONT 6
     " MATCH FILE CONFIRM  AND POLICY (THANACHAT) RENEW" VIEW-AS TEXT
          SIZE 105 BY 2.14 AT ROW 1.1 COL 1.17
          BGCOLOR 10 FGCOLOR 4 FONT 2
     "PARAMETER TYPE :" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 5.62 COL 10
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "** พารามิเตอร์ข้อมูลประเภทรถ คลาส และประเภทการใช้งาน**" VIEW-AS TEXT
          SIZE 49 BY 1 AT ROW 5.62 COL 51.83
          BGCOLOR 8 FGCOLOR 0 FONT 1
     "MATCH DATE :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 7.05 COL 15 WIDGET-ID 4
          BGCOLOR 8 FGCOLOR 2 FONT 6
     RECT-381 AT ROW 3.38 COL 1
     RECT-382 AT ROW 12.91 COL 75.17
     RECT-383 AT ROW 12.91 COL 65.17
     RECT-384 AT ROW 3.81 COL 4.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 105.5 BY 14.76
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
         TITLE              = "Match text  File Confirm Recepit (THANACHAT)"
         HEIGHT             = 14.76
         WIDTH              = 105.5
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
ON END-ERROR OF C-Win /* Match text  File Confirm Recepit (THANACHAT) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text  File Confirm Recepit (THANACHAT) */
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
        IF ra_matchpol = 1 THEN ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_receipt" + NO_add
                                       fi_outload2  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Load" + NO_add
                                       fi_outload3  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Error" + NO_add.
        ELSE IF ra_matchpol = 2 THEN ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Cancel" + NO_add.
        ELSE IF ra_matchpol = 3 THEN ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_NoConfirm" + NO_add.
        DISP fi_loadname fi_outload fi_outload2 fi_outload3  WITH FRAME fr_main .     
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
    For each  wdetail:
        DELETE  wdetail.
    END.
    For each  wrec:
        DELETE  wrec.
    END.
    For each  wcancel:
        DELETE  wcancel.
    END.
    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.
    IF ra_matchpol = 1 THEN RUN proc_impmatpol1.      /* ไฟล์ชำระเงิน */
   /* ELSE IF ra_matchpol = 2  THEN RUN proc_impmatpol2.   /* กรมธรรม์ */
    ELSE IF ra_matchpol = 3  THEN RUN proc_impmatpol3.   /* ไฟล์cancel */*/
    ELSE IF ra_matchpol = 2  THEN RUN proc_impmatpol3.   /*ไฟล์cancel */
    ELSE IF ra_matchpol = 3  THEN RUN proc_impmatpol4.   /*ไฟล์No confirm */
    IF CONNECTED("sic_exp") THEN  DISCONNECT sic_exp. 
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_date
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_date C-Win
ON LEAVE OF fi_date IN FRAME fr_main
DO:
   fi_date = INPUT fi_date.
   DISP fi_date WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_outload2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outload2 C-Win
ON LEAVE OF fi_outload2 IN FRAME fr_main
DO:
  fi_outload = INPUT fi_outload.
  DISP fi_outload WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outload3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outload3 C-Win
ON LEAVE OF fi_outload3 IN FRAME fr_main
DO:
  fi_outload = INPUT fi_outload.
  DISP fi_outload WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_para
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_para C-Win
ON LEAVE OF fi_para IN FRAME fr_main
DO:
  fi_para = INPUT fi_para.
  DISP fi_para WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_matchpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_matchpol C-Win
ON VALUE-CHANGED OF ra_matchpol IN FRAME fr_main
DO:
  ra_matchpol = INPUT ra_matchpol .
  DISP ra_matchpol WITH FRAM fr_main.
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
      ra_matchpol       = 1
      /*ra_matpoltyp      = 1*/
      fi_date           = TODAY     /*A61-0512*/
      gv_prgid          = "WGWTNCE2"
      fi_para           = "TNC_TYPE". /*a60-0383*/
    
  gv_prog  = "Match Text File Confirm (THANACHAT)".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  /*RUN proc_createpack.*/
  OPEN QUERY br_comp FOR EACH wcomp.
      DISP ra_matchpol   fi_para   fi_date WITH FRAM fr_main.
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
  DISPLAY ra_matchpol fi_loadname fi_outload fi_outload2 fi_outload3 fi_para 
          fi_date 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE ra_matchpol fi_loadname fi_outload bu_file-3 bu_ok bu_exit-2 
         fi_outload2 fi_outload3 fi_para fi_date RECT-381 RECT-382 RECT-383 
         RECT-384 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ACCESSORY C-Win 
PROCEDURE proc_ACCESSORY :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER nv_prepolacc AS CHAR.
ASSIGN nv_access = "".
IF nv_prepolacc <> "" THEN DO:
    FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
        sicuw.uwm301.policy = TRIM(nv_prepolacc) NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm301 THEN ASSIGN  nv_access = trim(sicuw.uwm301.prmtxt).
END.

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
DEF VAR nv_vehreg AS CHAR FORMAT "x(35)".
DEF VAR nv_cartyp AS CHAR FORMAT "x(50)". /*A60-03838*/
DEF VAR nv_i      AS INT INIT 0.
DEFINE VAR nv_year  AS INTE.
DEFINE VAR nv_day   AS INTE.
DEFINE VAR nv_month AS INTE.
/*FOR EACH wdetail.*/
    ASSIGN nv_vehreg = ""       nv_cartyp = "" /*A60-03838*/
           nv_i      = 0        nv_year   = 0 
           nv_day    = 0        nv_month  = 0 .
          /* wdetail.pass = "".*/ /*A60-0383*/
    nv_i = nv_i + 1.
    wdetail.policy = wdetail.pol_typ + STRING(nv_i) + wdetail.Account_no.

    /*IF wdetail.ben_name = "NB" THEN DO:*/  /*A60-0545*/
    /* Create by A60-0545...*/
    IF trim(wdetail.ben_name) = "NB"          AND 
       (INDEX(wdetail.pol_title,"นาย") <> 0   OR 
       INDEX(wdetail.pol_title,"น.ส")  <> 0   OR 
       INDEX(wdetail.pol_title,"นาง")  <> 0   OR
       INDEX(wdetail.pol_title,"คุณ")  <> 0 ) THEN DO:  /*A60-0545*/
    /*...end A60-0545...*/
         FIND FIRST stat.company WHERE stat.company.compno = wdetail.ben_name NO-LOCK NO-ERROR.
         IF AVAIL stat.company THEN DO:
             ASSIGN wdetail.addr1     = stat.Company.addr1
                    wdetail.addr2     = stat.Company.addr2
                    wdetail.addr3     = stat.Company.addr3
                    wdetail.addr4     = stat.Company.addr4
                    wdetail.ben_name =  stat.Company.Name .
         END.
    END.
   /* ELSE DO: 
        ASSIGN wdetail.addr1    = wdetail.addr1   
               wdetail.addr2    = wdetail.addr2   
               wdetail.addr3    = wdetail.addr3   
               wdetail.addr4    = wdetail.addr4   
               wdetail.ben_name = wdetail.ben_name.
    END.*/
    /*--- หาเลขทะเบียนรถ ---*/
    IF wdetail.licence <> "" AND wdetail.province <> "" THEN DO:
        nv_vehreg = wdetail.province.
        FOR EACH brstat.insure WHERE brstat.Insure.Compno = "999" NO-LOCK:
            IF INDEX(nv_vehreg,brstat.Insure.Fname) <> 0 THEN DO: 
                ASSIGN
                    nv_vehreg = brstat.insure.Lname.
            END.
        END.
        wdetail.licence = wdetail.licence + " " + nv_vehreg.
    END.
    /*---- กรมธรรม์เดิม -----------*/
    IF wdetail.prev_pol <> "" THEN RUN proc_chkoldpol. 
     /*-- สาขา ----*/
    /* comment by : A64-0205 .... 
    IF wdetail.prev_pol <> ""  THEN DO:
        IF INDEX(wdetail.prev_pol,"D") <> 0 THEN wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,2,1). 
        ELSE IF INDEX(wdetail.prev_pol,"I") <> 0 THEN wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,2,1). 
        ELSE wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,1,2).
    END.
    ... end A64-0205...*/ 
    /* add : A64-0205 */
    IF wdetail.prev_pol <> "" AND LENGTH(wdetail.PREV_pol) = 12  THEN DO: /* A64-0205 */
        IF SUBSTR(wdetail.prev_pol,1,1) = "D" THEN wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,2,1). 
        ELSE IF SUBSTR(wdetail.prev_pol,1,1) = "I" THEN wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,2,1).
        ELSE wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,1,2).
        IF wdetail.branch_safe = "MF" THEN wdetail.branch_safe = "ML".  /*A66-0160*/
    END.
    /* end : A64-0205 */
    ELSE DO:
        IF wdetail.covcod = "3" AND wdetail.prev_pol = ""  THEN wdetail.branch_safe = "ML". /*wdetail.branch_safe = "M".*/ /*A64-0205*/
        ELSE DO:
            FIND FIRST stat.Insure WHERE stat.Insure.Compno = "NB" AND
                                         stat.Insure.Insno  = TRIM(wdetail.branch) NO-LOCK NO-ERROR.
            IF AVAIL stat.Insure THEN DO:
                wdetail.branch_safe = stat.Insure.Branch.
            END.
            ELSE wdetail.branch_safe = "".
        END.
        ASSIGN wdetail.bandet = "บริษัทประกันภัยเดิม : " + wdetail.company + " " + "เลขที่ : " + nv_oldpol.
    END.
   /*---- วันที่คุ้มครอง , หมดอายุ ------*/
    IF wdetail.pol_typ = "70" THEN DO:  
         ASSIGN nv_year   = 0 
                nv_day    = 0 
                nv_month  = 0. 
        /*--- Comdate ---*/
        nv_year   = (YEAR(DATE(wdetail.comdat)) - 543).
        nv_day    = DAY(DATE(wdetail.comdat)).
        nv_month  = MONTH(DATE(wdetail.comdat)).
        wdetail.comdat = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
        /*--- Expdate ---*/
        nv_year   = (YEAR(DATE(wdetail.expdat)) - 543).
        nv_day    = DAY(DATE(wdetail.expdat)).
        nv_month  = MONTH(DATE(wdetail.expdat)).
        wdetail.expdat  = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    END.
    ELSE DO:
        ASSIGN nv_year   = 0 
               nv_day    = 0 
               nv_month  = 0.
        /*--- Comdate1 ---*/
        nv_year   = (YEAR(DATE(wdetail.comdat72)) - 543).
        nv_day    = DAY(DATE(wdetail.comdat72)).
        nv_month  = MONTH(DATE(wdetail.comdat72)).
        wdetail.comdat72 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
        /*--- comExpdate ---*/
        nv_year   = (YEAR(DATE(wdetail.expdat72)) - 543).
        nv_day    = DAY(DATE(wdetail.expdat72)).
        nv_month  = MONTH(DATE(wdetail.expdat72)).
        wdetail.expdat72 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    END.
   /*-----ผู้ขับขี่ ----------*/
    IF wdetail.drivename1 <> ""  THEN ASSIGN wdetail.drivename = "Y".
    ELSE ASSIGN wdetail.drivename = "N".
    /*--- Driver Birth Date 1 ---*/
    IF wdetail.drivename1 <> "" AND  wdetail.drivedate1 <> "" THEN DO:
        ASSIGN nv_year   = 0 
               nv_day    = 0 
               nv_month  = 0.
        nv_year    = (YEAR(DATE(wdetail.drivedate1)) - 543).
        nv_day     = DAY(DATE(wdetail.drivedate1)).
        nv_month   = MONTH(DATE(wdetail.drivedate1)).
        wdetail.drivedate1  = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    END.
    /*--- Driver Birth Date 2 ---*/
    IF wdetail.drivname2 <> "" AND  wdetail.drivedate2 <> "" THEN DO:
        ASSIGN nv_year   = 0 
               nv_day    = 0 
               nv_month  = 0.
        nv_year    = (YEAR(DATE(wdetail.drivedate2)) - 543).
        nv_day     = DAY(DATE(wdetail.drivedate2)).
        nv_month   = MONTH(DATE(wdetail.drivedate2)).
        wdetail.drivedate2 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    END.
    /*--- วันที่รับแจ้ง ---*/
   IF wdetail.not_date <> "" THEN DO:
       ASSIGN nv_year   = 0 
              nv_day    = 0 
              nv_month  = 0.
        nv_year  = (YEAR(DATE(wdetail.not_date)) - 543).
        nv_day   = DAY(DATE(wdetail.not_date)).
        nv_month = MONTH(DATE(wdetail.not_date)).
        wdetail.not_date  = STRING(nv_day) + "/" + STRING(nv_month) + "/" + STRING(nv_year).
    END.
    /*--- Class , Pack -----------*/
    IF INDEX(wdetail.vehuse," ")  <> 0 THEN ASSIGN nv_cartyp = REPLACE(wdetail.vehuse," ","") .
    ELSE ASSIGN nv_cartyp = TRIM(wdetail.vehuse).

    FIND LAST brstat.insure USE-INDEX Insure03 WHERE brstat.insure.compno = TRIM(fi_para) AND
                                                     brstat.insure.insno  = TRIM(fi_para) AND 
                                                     brstat.insure.text2  = trim(nv_cartyp) NO-LOCK NO-ERROR.
    IF AVAIL brstat.insure THEN DO:
        ASSIGN wdetail.vehuse = brstat.insure.text1
               wdetail.CLASS  = brstat.insure.text3.
    END.
    ELSE  ASSIGN wdetail.vehuse = ""
                 wdetail.CLASS  = "".

    /* comment by : A60-0383
    IF wdetail.vehuse <> "" THEN DO:
        IF INDEX(wdetail.vehuse,"เก๋ง") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "110"
                   wdetail.vehuse = "1" .
        END.
        ELSE IF INDEX(wdetail.vehuse,"นั่งสอง") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "110"
                   wdetail.vehuse = "1" .
        END.     
        ELSE IF INDEX(wdetail.vehuse,"นั่งสาม") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "110"
                   wdetail.vehuse = "1" .
        END.    
        ELSE IF INDEX(wdetail.vehuse,"บุคคล (รย 1)") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "110"
                   wdetail.vehuse = "1" .
        END.
        ELSE IF INDEX(wdetail.vehuse,"บรรทุก") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "320"
                   wdetail.vehuse = "3" .
        END.
        ELSE IF INDEX(wdetail.vehuse,"ตู้นั่ง") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "210"
                   wdetail.vehuse = "2" .
        END.
        ELSE IF INDEX(wdetail.vehuse,"รถโดยสาร") <> 0  THEN DO:
             ASSIGN wdetail.CLASS = "210"
                   wdetail.vehuse = "2" .
        END.
        ELSE DO:
            ASSIGN wdetail.CLASS = "110"
                   wdetail.vehuse = "1" .
        END.
    END.
    ----- end. A60-0383----*/
    IF wdetail.covcod = "1" OR wdetail.covcod = "2" THEN wdetail.prempa = "G".
    /*ELSE IF wdetail.covcod = "2+" THEN wdetail.prempa = "C".*/  /*A60-0383*/
    /* start : A60-0383*/
    ELSE IF wdetail.covcod = "2+" OR wdetail.covcod = "3+" THEN DO: 
        IF DATE(wdetail.comdat)  < 10/01/2017  THEN ASSIGN wdetail.prempa = "Z". 
        ELSE ASSIGN wdetail.prempa = "C". 
    END.
    /* end : A60-0383*/
    ELSE ASSIGN wdetail.prempa   = "R"  .
                /*wdetail.ben_name = "".*/ /*A60-0383*/ /*--- งานต่ออายุจากที่อื่นคุ้มครอง 3 ไม่มี BenName --*/

    RUN proc_chkredbook.
    RUN proc_chktext.
/*END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkoldpol C-Win 
PROCEDURE proc_chkoldpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_len AS INTE.
ASSIGN  
  nv_oldpol = " "
  nv_oldpol = wdetail.prev_pol.

loop_chko1:
REPEAT:
    IF INDEX(nv_oldpol,"-") <> 0 THEN DO:
        nv_len    = LENGTH(nv_oldpol).
        nv_oldpol = TRIM(SUBSTRING(nv_oldpol,1,INDEX(nv_oldpol,"-") - 1)) +
                    TRIM(SUBSTRING(nv_oldpol,INDEX(nv_oldpol,"-") + 1, nv_len )) .
    END.
    ELSE LEAVE loop_chko1.
END.
loop_chko2:
REPEAT:
    IF INDEX(nv_oldpol,"/") <> 0 THEN DO:
        nv_len = LENGTH(nv_oldpol).
        nv_oldpol = TRIM(SUBSTRING(nv_oldpol,1,INDEX(nv_oldpol,"/") - 1)) +
                    TRIM(SUBSTRING(nv_oldpol,INDEX(nv_oldpol,"/") + 1, nv_len )) .
    END.
    ELSE LEAVE loop_chko2.
END.

/*IF LENGTH(nv_oldpol) <> 12 THEN nv_oldpol = "".
ELSE */
    /*IF INDEX(wdetail.company,"ประกันคุ้มภัย") <> 0 THEN wdetail.prev_pol = nv_oldpol.*/ /*A64-0205 */
    /* Add by : A64-0205 */
    IF INDEX(wdetail.company,"ประกันคุ้มภัย") <> 0 OR INDEX(wdetail.company,"คุ้มภัยโตเกียว") <> 0 OR   
       INDEX(wdetail.company,"โตเกียวมารีน") <> 0 THEN wdetail.prev_pol = nv_oldpol. 
    /* end : A64-0205 */
    ELSE wdetail.prev_pol = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkredbook C-Win 
PROCEDURE proc_chkredbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_model  AS CHAR FORMAT "X(20)".
DEFINE VAR nv_model1 AS CHAR FORMAT "X(20)".

IF wdetail.pol_typ = "70" THEN DO:
    FIND FIRST stat.makdes31 WHERE stat.makdes31.makdes = "X" AND stat.makdes31.moddes = wdetail.Prempa + wdetail.CLASS NO-LOCK NO-ERROR.    
    IF AVAIL stat.makdes31 THEN DO:
       FIND FIRST stat.maktab_fil  WHERE  
                  stat.maktab_fil.makdes = TRIM(wdetail.brand)  AND
                  INDEX(stat.maktab_fil.moddes,TRIM(wdetail.Brand_Model)) <> 0  AND
                  stat.maktab_fil.makyea = INTEGER(wdetail.yrmanu)              AND
                  stat.maktab_fil.engine >= INTEGER(wdetail.weight)             AND
                  stat.maktab_fil.sclass = wdetail.class                        AND
                  (stat.maktab_fil.si - (stat.maktab_fil.si * makdes31.si_theft_p / 100) LE INTE(wdetail.ins_amt) AND
                  stat.maktab_fil.si + (stat.maktab_fil.si * makdes31.Load_p / 100) GE INTE(wdetail.ins_amt))
                  NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL stat.maktab_fil THEN DO:
           ASSIGN
               wdetail.Redbook = stat.maktab_fil.modcod
               wdetail.ton     = STRING(stat.maktab_fil.tons)
               wdetail.Seat    = STRING(stat.maktab_fil.seats)
               wdetail.Body    = stat.maktab_fil.body
               wdetail.Vehgrp  = stat.maktab_fil.prmpac.  /*A59-0070*/
       END.
       ELSE DO:
           ASSIGN
               wdetail.Redbook = ""
               wdetail.ton     = ""
               wdetail.Seat    = "7"
               wdetail.Body    = ""
               wdetail.Vehgrp  = "".  /*A59-0070*/
       END.  
    END.

    IF wdetail.Redbook = "" THEN DO:
        IF INDEX(wdetail.brand_model," ") <> 0 THEN DO:
            nv_model  = SUBSTR(wdetail.Brand_Model,1,INDEX(wdetail.Brand_Model," ")).
            nv_model1 = TRIM(SUBSTR(wdetail.Brand_Model,LENGTH(nv_model) + 1,LENGTH(wdetail.Brand_Model))).
            nv_model1 = SUBSTR(nv_model1,1,INDEX(nv_model1," ")).
        END.
        ELSE nv_model = TRIM(wdetail.brand_model).

        IF TRIM(nv_model) = "HILUX" THEN nv_model = TRIM(nv_model) + " " + TRIM(nv_model1).
        IF INDEX(nv_Model,"D-MAX") <> 0 THEN nv_model = "D-MAX".
        IF INDEX(nv_Model,"YARIS") <> 0 THEN nv_model = "YARIS".

        FOR EACH stat.maktab_fil WHERE
                   stat.maktab_fil.makdes = TRIM(wdetail.brand)      AND
             INDEX(stat.maktab_fil.moddes,TRIM(nv_model)) <> 0 AND
                   stat.maktab_fil.makyea = INTEGER(wdetail.yrmanu)   AND
                   stat.maktab_fil.engine >= INTEGER(wdetail.weight)  AND
                   stat.maktab_fil.sclass = wdetail.CLASS           AND
                  (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100) LE INTE(wdetail.ins_amt) AND
                   stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100) GE INTE(wdetail.ins_amt)) NO-LOCK:
            ASSIGN
               wdetail.Redbook = stat.maktab_fil.modcod
               wdetail.ton     = STRING(stat.maktab_fil.tons)
               wdetail.Seat    = STRING(stat.maktab_fil.seats)
               wdetail.Body    = stat.maktab_fil.body
               wdetail.Vehgrp  = stat.maktab_fil.prmpac.  /*A59-0070*/
    
        END.
        IF wdetail.Redbook = "" THEN DO:
           FOR EACH stat.maktab_fil WHERE
                       stat.maktab_fil.makdes = trim(wdetail.brand)  AND
                 INDEX(stat.maktab_fil.moddes,TRIM(nv_model1)) <> 0  AND
                       stat.maktab_fil.makyea = INTEGER(wdetail.yrmanu) AND
                       stat.maktab_fil.engine >= INTEGER(wdetail.weight) AND
                       stat.maktab_fil.sclass = wdetail.CLASS AND
                      (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100) LE INTE(wdetail.ins_amt) AND
                       stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100) GE INTE(wdetail.ins_amt)) NO-LOCK:
                ASSIGN
                   wdetail.Redbook = stat.maktab_fil.modcod
                   wdetail.ton     = STRING(stat.maktab_fil.tons)
                   wdetail.Seat    = STRING(stat.maktab_fil.seats)
                   wdetail.Body    = stat.maktab_fil.body
                   wdetail.Vehgrp  = stat.maktab_fil.prmpac.  /*A59-0070*/
            END.
        END.
        IF wdetail.Redbook = "" THEN DO:
          FIND FIRST stat.maktab_fil WHERE
                       stat.maktab_fil.makdes = trim(wdetail.brand)    AND
                 INDEX(stat.maktab_fil.moddes,TRIM(nv_model)) <> 0  AND
                       stat.maktab_fil.makyea  = INTEGER(wdetail.yrmanu) AND
                       stat.maktab_fil.engine >= INTEGER(wdetail.weight)  AND
                      (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100) LE INTE(wdetail.ins_amt) AND
                       stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100) GE INTE(wdetail.ins_amt)) NO-LOCK NO-ERROR.
          IF AVAIL stat.maktab_fil THEN DO:
                ASSIGN
                   wdetail.Redbook = stat.maktab_fil.modcod
                   wdetail.ton     = STRING(stat.maktab_fil.tons)
                   wdetail.Seat    = STRING(stat.maktab_fil.seats)
                   wdetail.Body    = stat.maktab_fil.body
                   wdetail.Vehgrp  = stat.maktab_fil.prmpac.  /*A59-0070*/
          END.
        END.
    
    END.
END.
ELSE DO:
    FIND LAST sicsyac.xmm102 WHERE sicsyac.xmm102.modest = trim(wdetail.brand) + " " + trim(wdetail.brand_model) AND 
                             sicsyac.xmm102.engine  >= INTE(wdetail.weight) NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102  THEN DO:
            ASSIGN
                wdetail.ton          = STRING(sicsyac.xmm102.tons)  
                wdetail.seat         = STRING(sicsyac.xmm102.seats)
                wdetail.redbook      = sicsyac.xmm102.modcod
                wdetail.body         = sicsyac.xmm102.body
                wdetail.Vehgrp       = sicsyac.xmm102.vehgrp.
                
        END.
        ELSE DO:
             FIND LAST sicsyac.xmm102 WHERE sicsyac.xmm102.modest = trim(wdetail.brand) AND
                             sicsyac.xmm102.engine  >= INTE(wdetail.weight) NO-LOCK NO-ERROR.
                IF AVAIL sicsyac.xmm102  THEN DO:
                    ASSIGN
                    wdetail.ton          = STRING(sicsyac.xmm102.tons)  
                    wdetail.seat         = STRING(sicsyac.xmm102.seats)
                    wdetail.redbook      = sicsyac.xmm102.modcod
                    wdetail.body         = sicsyac.xmm102.body
                    wdetail.Vehgrp       = sicsyac.xmm102.vehgrp.
                END.
                ELSE DO:
                   ASSIGN
                       wdetail.Redbook = ""
                       wdetail.ton     = ""
                       wdetail.Seat    = "7"
                       wdetail.Body    = ""
                       wdetail.Vehgrp  = "".  
                END.
       END.  
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktext C-Win 
PROCEDURE proc_chktext :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*----- Comment A53-0111 Edit Vol.1 --*/
/*-- ชื่อผู้เอาประกัน --*/
IF wdetail.pol_fname = "" THEN DO:
    ASSIGN wdetail.comment = "| ชื่อผู้เอาประกันเป็นค่าว่าง " 
           wdetail.pass    = "N".
END.
/*-- วันที่เริ่มคุ้มครอง/วันที่สิ้นสุดความคุ้มครอง --*/
IF wdetail.pol_type = "70" THEN DO:
    IF wdetail.Comdat = "" THEN DO:
        ASSIGN wdetail.comment = "| วันที่เริ่มคุ้มครอง กธ.เป็นค่าว่าง " 
               wdetail.pass    = "N".
    END.
    IF wdetail.Expdat = "" THEN DO:
        ASSIGN wdetail.comment = "| วันที่สิ้นสุดความคุ้มครอง กธ.เป็นค่าว่าง " 
               wdetail.pass    = "N".
    END.
END.
ELSE DO:
    IF wdetail.Comdat72 = "" OR wdetail.Expdat72 /*Imexpdate*/ = "" THEN DO:
        ASSIGN wdetail.comment = "| วันที่เริ่มคุ้มครอง พรบ. เป็นค่าว่าง " 
               wdetail.pass    = "N".
    END.
    IF wdetail.Comdat72 = "" OR wdetail.Expdat72 /*Imexpdate*/ = "" THEN DO:
        ASSIGN wdetail.comment = "| วันที่สิ้นสุดความคุ้มครอง พรบ.เป็นค่าว่าง " 
               wdetail.pass    = "N".
    END.

END.
/*-- ยี่ห้อรถ --*/
IF wdetail.Brand = "" THEN DO:
    ASSIGN wdetail.comment = "| ยี่ห้อรถเป็นค่าว่าง "
           wdetail.pass    = "N".
END.
/*-- รุ่นรถ ---*/
IF wdetail.Brand_Model = "" THEN DO:
    ASSIGN wdetail.comment = "| รุ่นรถเป็นค่าว่าง "
           wdetail.pass    = "N".
END.
/*-- ปีที่ผลิต --*/
IF wdetail.yrmanu = "" THEN DO:
    ASSIGN wdetail.comment = "| ปีที่ผลิตเป็นค่าว่าง "
           wdetail.pass    = "N".
END.
/*-- CC --*/
IF /*Imcc*/ wdetail.weight = "" THEN DO:
    ASSIGN wdetail.comment = "| CC เป็นค่าว่าง " 
           wdetail.pass    = "N".
END.
/*-- เลขเครื่อง --*/
IF wdetail.Engine = "" THEN DO:
    ASSIGN wdetail.comment = "| เลขเครื่องยนต์เป็นค่าว่าง " 
           wdetail.pass    = "N" .
END.
/*-- เลขตัวถัง --*/
IF wdetail.chassis = "" THEN DO:
    ASSIGN wdetail.comment = "| เลขตัวถังเป็นค่าว่าง " 
           wdetail.pass    = "N".
END.
/*-- Driver Name ---*/
IF wdetail.drivename = "Y" THEN DO:
    IF (wdetail.drivename1 = "" AND wdetail.drivedate1 = "") THEN
        ASSIGN wdetail.comment = "| ชื่อผู้ขับขี่และวันเกิดเป็นค่าว่าง " 
               wdetail.pass    = "N".
END.
/*-- คำนำหน้าชื่อ --*/
IF wdetail.pol_title = "" THEN DO:
    ASSIGN wdetail.comment = "| คำนำหน้าชื่อเป็นค่าว่าง "
           wdetail.pass    = "N".
END.
/*-- Branch --*/
IF wdetail.Branch_safe = "" THEN DO:
    ASSIGN wdetail.comment = "| Branch เป็นค่าว่าง กรุณาตรวจสอบ Branch"
           wdetail.pass    = "N".
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol1 C-Win 
PROCEDURE proc_impmatpol1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: /* Create by A61-0512 ....*/      
------------------------------------------------------------------------------*/
DO:
    INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wrec.
          IMPORT DELIMITER "|" 
                wrec.Notify_no                  /*เลขที่รับแจ้ง           */     
                wrec.Account_no                 /*เลขที่สัญญา             */     
                wrec.prevpol                   /*เลขที่กรมธรรม์เดิม      */     
                wrec.company                    /*บริษัทประกันเก่า        */     
                wrec.not_office                 /*ชื่อผู้เอาประกันภัย     */     
                wrec.ben_name                   /*ผู้รับผลประโยชน์        */     
                wrec.comdat                     /*วันที่เริ่มคุ้มครอง     */     
                wrec.expdat                     /*วันที่สิ้นสุดคุ้มครอง   */     
                wrec.licence                    /*เลขทะเบียน              */     
                wrec.province                   /*จังหวัด                 */     
                wrec.ctype                      /*สมัครใจ/พรบ.            */     
                wrec.ins_amt                    /*ทุนประกัน               */     
                wrec.prem1                      /*เบี้ยประกันสุทธิ        */     
                wrec.prem                       /*เบี้ยประกันภัยรวม       */     
                wrec.remark                     /*หมายเหตุ                */     
                wrec.not_date                   /*วันที่รับแจ้ง           */     
                wrec.not_name                   /*ชื่อประกันภัย           */     
                wrec.brand                      /*ยี่ห้อ                  */     
                wrec.Brand_Model                /*รุ่น                    */     
                wrec.yrmanu                     /*ปี                      */     
                wrec.weight                     /*ขนาดเครื่อง             */     
                wrec.engine                     /*เลขเครื่อง              */     
                wrec.chassis                    /*เลขถัง                  */     
                wrec.pattern                    /*Pattern Rate            */     
                wrec.covcod                     /*ประเภทประกัน            */     
                wrec.vehuse                     /*ประเภทรถ                */     
                wrec.sclass                     /*รหัสรถ                  */     
                wrec.garage                     /*สถานที่ซ่อม             */     
                wrec.drivename1                 /*ระบุผู้ขับขี่1          */     
                wrec.driveid1                   /*เลขที่ใบขับขี่1         */     
                wrec.driveic1                   /*เลขที่บัตรประชาชน1      */     
                wrec.drivedate1                 /*วันเดือนปีเกิด1         */     
                wrec.drivname2                  /*ระบุผู้ขับขี่2          */     
                wrec.driveid2                   /*เลขที่ใบขับขี่2         */     
                wrec.driveic2                   /*เลขที่บัตรประชาชน2      */     
                wrec.drivedate2                 /*วันเดือนปีเกิด2         */     
                wrec.cl                         /*ส่วนลดประวัติเสีย       */     
                wrec.fleetper                   /*ส่วนลดกลุ่ม             */     
                wrec.ncbper                     /*ประวัติดี               */     
                wrec.othper                     /*อื่น ๆ                  */     
                wrec.pol_addr1                  /*ที่อยู่ลูกค้า           */     
                wrec.icno                       /*IDCARD                  */     
                wrec.icno_st                    /*DateCARD_S              */     
                wrec.icno_ex                    /*DateCARD_E              */     
                wrec.bdate                      /*Birth Date              */     
                wrec.paidtyp                    /*Type_Paid_1             */     
                wrec.paydate                    /*Paid_Date               */     
                wrec.paid                       /*Paid_Amount             */     
                wrec.prndate                    /*วันที่พิมพ์ พรบ.        */     
                wrec.sckno                     /*เลขสติกเกอร์ / เลข กธ.  */ 
                wrec.nCOLOR        /*A66-0160*/
                wrec.mobile        /*A66-0160*/
                wrec.receipaddr    /*A66-0160*/
                wrec.sendaddr      /*A66-0160*/
                wrec.notifycode    /*A66-0160*/
                wrec.salenotify .  /*A66-0160*/
               







          IF INDEX(wrec.NOT_date,"วันที่") <> 0 THEN DELETE wrec.
          ELSE IF wrec.not_date = "" THEN DELETE wrec.
    END.   /* repeat  */
    RUN proc_impmatpol1_01.
END.

    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol1_01 C-Win 
PROCEDURE proc_impmatpol1_01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_length AS INT.
DEF VAR n_notdate AS DATE INIT ? .
DEF VAR n_year    AS INT .
DO:
  FOR EACH wrec .
    IF wrec.not_date  = "" THEN DELETE wrec.
    ELSE DO:
        ASSIGN   nv_type   = ""     n_length = 0    n_notdate = ?      n_year   = 0.
        IF (YEAR(date(wrec.NOT_date)) = YEAR(TODAY)) OR (YEAR(date(wrec.NOT_date)) = (YEAR(TODAY) - 1)) THEN DO: /*A60-0545*/
            ASSIGN  n_notdate = DATE(STRING(DATE(wrec.NOT_date),"99/99/9999"))
                n_year    = INT(YEAR(n_notdate)) + 543
                wrec.NOT_date = STRING(DAY(n_notdate),"99") + "/" + STRING(MONTH(n_notdate),"99") + "/" + string(n_year,"9999").
        END.
        IF INDEX(wrec.ctype,"พรบ") <> 0 THEN ASSIGN nv_type = "V72".
        ELSE IF INDEX(wrec.ctype,"บังคับ") <> 0 THEN ASSIGN nv_type = "V72". /*A61-0512 */
        ELSE ASSIGN nv_type = "V70".
        /* start : A60-0383*/
        IF wrec.not_office <> "" THEN DO:
            ASSIGN  n_length = LENGTH(wrec.not_office)
                nv_name  = SUBSTR(TRIM(wrec.NOT_office),INDEX(wrec.NOT_office," ") + 1,n_length).
        END.
        /* end : A60-0383*/
        FIND LAST brstat.tlt USE-INDEX tlt04  WHERE   
          brstat.tlt.datesent     = DATE(wrec.not_date)   AND    /*วันที่แจ้งงาน */           
          brstat.tlt.nor_noti_tlt = TRIM(wrec.Notify_no)  AND    /*เลขที่รับแจ้ง */
          /*brstat.tlt.ins_name     = TRIM(nv_name)         AND*/  /*A60-0383 */
          index(wrec.not_office,trim(brstat.tlt.ins_name)) <> 0 AND     /*A60-0383 */ /*ชื่อ -สกุล */
          brstat.tlt.genusr       = "THANACHAT"           AND     
          brstat.tlt.subins       = TRIM(nv_type)         NO-ERROR NO-WAIT.    /* ประเภท V70 ,V72 */   
        IF AVAIL brstat.tlt THEN DO:
          IF brstat.tlt.releas = "NO" THEN DO:
              IF brstat.tlt.recac = "" THEN                             
                  ASSIGN brstat.tlt.recac = "ชำระเบี้ยแล้ว"             
                  /*brstat.tlt.dat_ins_noti =  DATE(wrec.paydate) */ /*A60-0383*/
                  brstat.tlt.dat_ins_noti =  TODAY  /*A60-0383*/
                  wrec.remark = "Complete".                      
              ELSE ASSIGN wrec.remark = "มีการ confirm ไปแล้ว" .
              IF brstat.tlt.subins = "V70" THEN ASSIGN brstat.tlt.nor_grprm = deci(wrec.prem).   /*A60-0383*/
              ELSE ASSIGN brstat.tlt.comp_grprm = deci(wrec.prem).                               /*A60-0383*/
              ASSIGN wrec.prevpol = brstat.tlt.filler1                                           /*A60-0383*/
                  wrec.loss    = string(brstat.tlt.sentcnt) .                                 /*A60-0383*/
              RUN proc_ACCESSORY (INPUT brstat.tlt.filler1).  
              FIND LAST wdetail WHERE wdetail.Notify_no = trim(wrec.Notify_no)  AND 
                  wdetail.not_date  = trim(wrec.not_date)   AND
                  wdetail.pol_typ   = substr(nv_type,2,2) NO-ERROR NO-WAIT.
              IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN
                wdetail.Pro_off     =    brstat.tlt.rec_addr3                                                                    /*เลขที่รับแจ้งและสาขา      */                                                    
                wdetail.Notify_no   =    brstat.tlt.nor_noti_tlt                                                                 /*เลขที่รับแจ้ง             */  
                wdetail.branch      =    brstat.tlt.EXP                                                                          /*สาขา                      */  
                wdetail.Account_no  =    brstat.tlt.safe2                                                                        /*เลขที่สัญญา               */  
                wdetail.prev_pol    =    brstat.tlt.filler1                                                                      /*เลขที่กรมธรรม์เดิม        */  
                wdetail.company     =    brstat.tlt.rec_addr4                                                                    /*บริษัทประกันเก่า          */  
                wdetail.pol_title   =    brstat.tlt.rec_name                                                                     /*คำนำหน้าชื่อ              */  
                wdetail.pol_fname   =    brstat.tlt.ins_name                                                                     /*ชื่อผู้เอาประกันภัย       */  
                /*wdetail.pol_lname   =    ""                                                                                      /*นามสกุล                   */ */ 
                wdetail.ben_name    =    brstat.tlt.safe1                                                                        /*ผู้รับผลประโยชน์          */  
                wdetail.comdat      =    string(brstat.tlt.gendat,"99/99/9999")                                                  /*วันที่เริ่มคุ้มครอง       */            
                wdetail.expdat      =    string(brstat.tlt.expodat,"99/99/9999")                                                 /*วันที่สิ้นสุดคุ้มครอง     */            
                wdetail.comdat72    =    string(brstat.tlt.comp_effdat,"99/99/9999")                                             /*วันทีเริ่มคุ้มครองพรบ     */            
                wdetail.expdat72    =    string(brstat.tlt.nor_effdat,"99/99/9999")                                              /*วันที่สิ้นสุดคุ้มครองพรบ  */            
                wdetail.licence     =    brstat.tlt.lince1                                                                       /*เลขทะเบียน                */  
                wdetail.province    =    brstat.tlt.lince3                                                                       /*จังหวัด                   */  
                wdetail.ins_amt     =    string(brstat.tlt.nor_coamt)                                                            /*ทุนประกัน                 */  
                wdetail.prem1       =    string(brstat.tlt.nor_grprm)                                                            /*เบี้ยประกันรวม            */  
                wdetail.comp_prm    =    string(brstat.tlt.comp_grprm)                                                           /*เบี้ยพรบรวม               */  
                wdetail.gross_prm   =    string(brstat.tlt.comp_coamt)                                                           /*เบี้ยรวม                  */  
                wdetail.compno      =    brstat.tlt.comp_pol                                                                     /*เลขกรมธรรม์พรบ            */  
                wdetail.sckno       =    brstat.tlt.comp_sck                                                                     /*เลขที่สติ๊กเกอร์          */  
                wdetail.not_code    =    brstat.tlt.comp_usr_tlt                                                                 /*รหัสผู้แจ้ง               */  
                wdetail.remark      =    brstat.tlt.filler2                                                                      /*หมายเหตุ                  */  
                wdetail.not_date    =    string(brstat.tlt.datesent,"99/99/9999")                                               /*วันที่รับแจ้ง             */             
                wdetail.not_office  =    brstat.tlt.nor_usr_tlt                                                                  /*ชื่อประกันภัย             */  
                wdetail.not_name    =    brstat.tlt.nor_usr_ins                                                                  /*ผู้แจ้ง                   */  
                wdetail.brand       =    brstat.tlt.brand                                                                        /*ยี่ห้อ                    */  
                wdetail.Brand_Model =    brstat.tlt.model                                                                        /*รุ่น                      */  
                wdetail.yrmanu      =    brstat.tlt.lince2                                                                       /*ปี                        */  
                wdetail.weight      =    string(brstat.tlt.cc_weight)                                                            /*ขนาดเครื่อง               */  
                wdetail.engine      =    brstat.tlt.eng_no                                                                       /*เลขเครื่อง                */  
                wdetail.chassis     =    brstat.tlt.cha_no                                                                       /*เลขถัง                    */  
                wdetail.pattern     =    brstat.tlt.old_cha                                                                      /*Pattern Rate              */  
                wdetail.covcod      =    brstat.tlt.expousr                                                                      /*ประเภทประกัน              */  
                wdetail.vehuse      =    brstat.tlt.old_eng                                                                      /*ประเภทรถ                  */  
                /*wdetail.garage      =    IF trim(brstat.tlt.stat) = "ซ่อมอู่" THEN "G" ELSE ""  */ /*A60-0383*/                /*สถานที่ซ่อม               */  
                wdetail.garage      =    IF trim(brstat.tlt.expousr) = "1" AND trim(brstat.tlt.stat) = "ซ่อมห้าง" THEN "G" ELSE ""       /*A60-0383*/
                wdetail.drivename1  =    IF LENGTH(brstat.tlt.dri_name1) <> 0  THEN SUBSTR(brstat.tlt.dri_name1,1,60)  ELSE ""   /*ระบุผู้ขับขี้1            */  
                wdetail.driveid1    =    IF length(brstat.tlt.dri_name1) > 60 THEN SUBSTR(brstat.tlt.dri_name1,61,20)  ELSE ""   /*เลขที่ใบขับขี่1           */  
                wdetail.driveic1    =    IF length(brstat.tlt.dri_name1) > 80 THEN SUBSTR(brstat.tlt.dri_name1,81,20)  ELSE ""   /*เลขที่บัตรประชาชน1        */  
                wdetail.drivedate1  =    brstat.tlt.dri_no1                                                                      /*วันเดือนปีเกิด1           */      
                wdetail.drivname2   =    IF LENGTH(brstat.tlt.dri_name2) <> 0  THEN SUBSTR(brstat.tlt.dri_name2,1,60)  else ""   /*ระบุผู้ขับขี้2            */  
                wdetail.driveid2    =    IF length(brstat.tlt.dri_name2) > 60 THEN SUBSTR(brstat.tlt.dri_name2,61,20)  else ""   /*เลขที่ใบขับขี่2           */  
                wdetail.driveic2    =    IF length(brstat.tlt.dri_name2) > 80 THEN SUBSTR(brstat.tlt.dri_name2,81,20)  else ""   /*เลขที่บัตรประชาชน2        */  
                wdetail.drivedate2  =    brstat.tlt.dri_no2                                                                      /*วันเดือนปีเกิด2           */      
                wdetail.cl          =    STRING(brstat.tlt.endno)                                                                /*ส่วนลดประวัติเสีย         */  
                wdetail.fleetper    =    STRING(brstat.tlt.lotno)                                                                /*ส่วนลดกลุ่ม               */  
                wdetail.ncbper      =    string(brstat.tlt.seqno)                                                                /*ประวัติดี                 */  
                wdetail.othper      =    string(brstat.tlt.endcnt)                                                               /*อื่น ๆ                    */  
                wdetail.addr1       =    brstat.tlt.ins_addr1                                                                    /*ที่อยู่ลูกค้า             */  
                wdetail.addr2       =    brstat.tlt.ins_addr2                                                                    /*ที่อยู่ลูกค้า             */  
                wdetail.addr3       =    brstat.tlt.ins_addr3                                                                    /*ที่อยู่ลูกค้า             */  
                wdetail.addr4       =    brstat.tlt.ins_addr4                                                                    /*ที่อยู่ลูกค้า             */  
                wdetail.icno        =    "" /*brstat.tlt.ins_addr5*/                                                             /*IDCARD                    */  
                wdetail.icno_st     =    "" /*brstat.tlt.ins_addr5*/                                                             /*DateCARD_S                */  
                wdetail.icno_ex     =    "" /*brstat.tlt.ins_addr5*/                                                             /*DateCARD_E                */  
                wdetail.paid        =    brstat.tlt.safe3                                                                        /*Type_Paid_1               */  
                wdetail.pol_typ     =    substr(brstat.tlt.subins,2,2)                                                                       /*ประเภท กธ.                */  
                wdetail.agent       =    brstat.tlt.comp_noti_ins                                                                /*agent                     */  
                wdetail.producer    =    brstat.tlt.comp_sub                                                                     /*producer                  */
                wdetail.pass        =    "Y"
                wdetail.ACCESSORY   =    nv_access            /*A66-0160*/
                wdetail.ncolor      =    wrec.ncolor           /*A66-0160*/
                wdetail.campaign    =    brstat.tlt.rec_addr2  /*A60-0383*/   /*campaign*/   
                wdetail.ispno       =    brstat.tlt.rec_addr5. /*A61-0512 */ /*ISPNO */
                IF wdetail.icno = "" THEN DO:
                  ASSIGN n_length            = 0
                  n_addr5             = ""
                  n_exp               = ""
                  n_com               = ""
                  n_ic                = ""
                  n_addr5             = TRIM(brstat.tlt.ins_addr5)
                  n_length            = LENGTH(n_addr5)                                   
                  n_exp               = SUBSTR(n_addr5,R-INDEX(n_addr5,"Exp:") + 4,n_length)  
                  n_addr5             = SUBSTR(n_addr5,1,R-INDEX(n_addr5," "))             
                  n_length            = LENGTH(n_addr5)                                     
                  n_com               = SUBSTR(n_addr5,R-INDEX(n_addr5,"Comm:") + 5,n_length)
                  /*n_ic                = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 6) */ /*a60-0383*/
                  n_ic                = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 5)      /*A60-0383*/
                  wdetail.icno        = TRIM(n_ic)
                  wdetail.icno_st     = IF trim(n_com) <> "" THEN SUBSTR(n_com,7,2) + "/" + SUBSTR(n_com,5,2) + "/" + SUBSTR(n_com,1,4) ELSE ""
                  wdetail.icno_ex     = IF trim(n_exp) <> "" THEN SUBSTR(n_exp,7,2) + "/" + SUBSTR(n_exp,5,2) + "/" + SUBSTR(n_exp,1,4) ELSE "".
                END.
                /* comment by A61-0512 ....
                /*A60-0383*/
                IF      trim(wdetail.pol_title) = "นาย"     THEN ASSIGN  wdetail.pol_title = "คุณ".
                ELSE IF trim(wdetail.pol_title) = "นาง"     THEN ASSIGN  wdetail.pol_title = "คุณ".
                ELSE IF trim(wdetail.pol_title) = "น.ส."    THEN ASSIGN  wdetail.pol_title = "คุณ".
                ELSE IF trim(wdetail.pol_title) = "นางสาว"  THEN ASSIGN  wdetail.pol_title = "คุณ".
                /* end A60-0383*/
                ... end A61-0512 */
                /* create : A61-0512 */
                IF trim(wdetail.pol_title) = "คุณ"  THEN  ASSIGN wdetail.pol_title =  SUBSTR(wrec.NOT_office,1,INDEX(wrec.NOT_office," ")) .
                ASSIGN 
                n_year            =  0
                n_year            =  YEAR(fi_date) + 543
                wdetail.typ_paid   =  wrec.paidtyp
                wdetail.paid_date  =  wrec.paydate
                wdetail.conf_date  =  STRING(fi_date,"99/99/9999")
                wdetail.conf_date  = SUBSTR(wdetail.conf_date,1,6) + STRING(n_year,"9999").
              END.
              RUN proc_chkdata.
          END.
          ELSE IF brstat.tlt.releas = "YES" THEN DO:
              IF brstat.tlt.recac = "" THEN ASSIGN brstat.tlt.recac = "ชำระเบี้ยแล้ว"   
              /*brstat.tlt.dat_ins_noti =  DATE(wrec.paydate) */ /*A60-0383*/
              brstat.tlt.dat_ins_noti =  TODAY  /*A60-0383*/
              wrec.remark =  IF brstat.tlt.subins = "V70" THEN wrec.remark + "COMPLETE/ออกกรมธรรม์ไปแล้ว " + brstat.tlt.nor_noti_ins 
              ELSE wrec.remark + "COMPLETE/ออกกรมธรรม์ไปแล้ว " + brstat.tlt.comp_pol. 
              ELSE ASSIGN wrec.remark = IF brstat.tlt.subins = "V70" THEN  wrec.remark + "ออกกรมธรรม์ไปแล้ว " + brstat.tlt.nor_noti_ins 
              ELSE wrec.remark +  "ออกกรมธรรม์ไปแล้ว " + brstat.tlt.comp_pol.
          END.
          ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN wrec.remark = wrec.remark + "มีการยกเลิกเลขที่รับแจ้งนี้แล้ว ".
        END.
        /*ELSE ASSIGN wrec.remark = "Not Complete" .*/
        ELSE ASSIGN wrec.remark = wrec.remark + "ไม่พบข้อมูลในถังพัก " .
        RELEASE brstat.tlt.
    END.
  END.
IF NOT CONNECTED("sic_exp")  THEN RUN proc_sic_exp.
/*IF CONNECTED("sic_exp") AND nv_type = "V70" THEN RUN wgw\wgwtnchk1.*/ /*A60-0545*/
IF CONNECTED("sic_exp") THEN RUN wgw\wgwtnchk1. /*A60-0545*/
Run Pro_reportreceipt.
Message "Export data Complete"  View-as alert-box.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol1_old C-Win 
PROCEDURE proc_impmatpol1_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: /* comment by A61-0512 ....*/      
------------------------------------------------------------------------------*/
/*DEF VAR n_length AS INT.
DEF VAR n_notdate AS DATE INIT ? .
DEF VAR n_year    AS INT .
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wrec.
          IMPORT DELIMITER "|" 
                wrec.not_date       /*วันที่รับแจ้ง         */             
                wrec.Notify_no      /*เลขที่รับแจ้ง         */             
                wrec.Account_no     /*สาขา – เลขที่สัญญา    */             
                wrec.not_office     /*ชื่อผู้เอาประกันภัย   */             
                wrec.ctype          /*สมัครใจ/พรบ.          */             
                wrec.comdat         /*วันที่เริ่มคุ้มครอง   */             
                wrec.expdat         /*วันที่สิ้นสุด         */             
                wrec.prem           /* ค่าเบี้ยประกันภัยรวม */             
                wrec.paydate .      /*วันที่ลูกค้าชำระเบี้ยครั้งสุดท้าย*/  
          IF INDEX(wrec.NOT_date,"วันที่") <> 0 THEN DELETE wrec.
          ELSE IF wrec.not_date = "" THEN DELETE wrec.
    END.   /* repeat  */
    FOR EACH wrec .
        IF wrec.not_date  = "" THEN DELETE wrec.
        ELSE DO:
            ASSIGN   nv_type   = ""     n_length = 0    n_notdate = ?      n_year   = 0.
            IF (YEAR(date(wrec.NOT_date)) = YEAR(TODAY)) OR (YEAR(date(wrec.NOT_date)) = (YEAR(TODAY) - 1)) THEN DO: /*A60-0545*/
                ASSIGN  n_notdate = DATE(STRING(DATE(wrec.NOT_date),"99/99/9999"))
                        n_year    = INT(YEAR(n_notdate)) + 543
                        wrec.NOT_date = STRING(DAY(n_notdate),"99") + "/" + STRING(MONTH(n_notdate),"99") + "/" + string(n_year,"9999").
            END.
            IF INDEX(wrec.ctype,"พรบ") <> 0 THEN ASSIGN nv_type = "V72".
            ELSE ASSIGN nv_type = "V70".
            /* start : A60-0383*/
            IF wrec.not_office <> "" THEN DO:
                ASSIGN  n_length = LENGTH(wrec.not_office)
                        nv_name  = SUBSTR(TRIM(wrec.NOT_office),INDEX(wrec.NOT_office," ") + 1,n_length).
            END.
            /* end : A60-0383*/
            FIND LAST brstat.tlt USE-INDEX tlt04  WHERE   
                      brstat.tlt.datesent     = DATE(wrec.not_date)   AND    /*วันที่แจ้งงาน */           
                      brstat.tlt.nor_noti_tlt = TRIM(wrec.Notify_no)  AND    /*เลขที่รับแจ้ง */
                      /*brstat.tlt.ins_name     = TRIM(nv_name)         AND*/  /*A60-0383 */
                      index(wrec.not_office,trim(brstat.tlt.ins_name)) <> 0 AND     /*A60-0383 */ /*ชื่อ -สกุล */
                      brstat.tlt.genusr       = "THANACHAT"           AND     
                      brstat.tlt.subins       = TRIM(nv_type)         NO-ERROR NO-WAIT.    /* ประเภท V70 ,V72 */   
                    IF AVAIL brstat.tlt THEN DO:
                       IF brstat.tlt.releas = "NO" THEN DO:
                         IF brstat.tlt.recac = "" THEN                             
                            ASSIGN brstat.tlt.recac = "ชำระเบี้ยแล้ว"             
                                   /*brstat.tlt.dat_ins_noti =  DATE(wrec.paydate) */ /*A60-0383*/
                                    brstat.tlt.dat_ins_noti =  TODAY  /*A60-0383*/
                                   wrec.remark = "Complete".                      
                         ELSE ASSIGN wrec.remark = "มีการ confirm ไปแล้ว" .
                         
                         IF brstat.tlt.subins = "V70" THEN ASSIGN brstat.tlt.nor_grprm = deci(wrec.prem).   /*A60-0383*/
                         ELSE ASSIGN brstat.tlt.comp_grprm = deci(wrec.prem).                               /*A60-0383*/
                         ASSIGN wrec.prevpol = brstat.tlt.filler1                                           /*A60-0383*/
                                wrec.loss    = string(brstat.tlt.sentcnt) .                                 /*A60-0383*/
                        
                         FIND LAST wdetail WHERE wdetail.Notify_no = trim(wrec.Notify_no)  AND 
                                                 wdetail.not_date  = trim(wrec.not_date)   AND
                                                 wdetail.pol_typ   = substr(nv_type,2,2) NO-ERROR NO-WAIT.
                         IF NOT AVAIL wdetail THEN DO:
                             CREATE wdetail.
                             ASSIGN
                               wdetail.Pro_off     =    brstat.tlt.rec_addr3                                                                    /*เลขที่รับแจ้งและสาขา      */                                                    
                               wdetail.Notify_no   =    brstat.tlt.nor_noti_tlt                                                                 /*เลขที่รับแจ้ง             */  
                               wdetail.branch      =    brstat.tlt.EXP                                                                          /*สาขา                      */  
                               wdetail.Account_no  =    brstat.tlt.safe2                                                                        /*เลขที่สัญญา               */  
                               wdetail.prev_pol    =    brstat.tlt.filler1                                                                      /*เลขที่กรมธรรม์เดิม        */  
                               wdetail.company     =    brstat.tlt.rec_addr4                                                                    /*บริษัทประกันเก่า          */  
                               wdetail.pol_title   =    brstat.tlt.rec_name                                                                     /*คำนำหน้าชื่อ              */  
                               wdetail.pol_fname   =    brstat.tlt.ins_name                                                                     /*ชื่อผู้เอาประกันภัย       */  
                               /*wdetail.pol_lname   =    ""                                                                                      /*นามสกุล                   */ */ 
                               wdetail.ben_name    =    brstat.tlt.safe1                                                                        /*ผู้รับผลประโยชน์          */  
                               wdetail.comdat      =    string(brstat.tlt.gendat,"99/99/9999")                                                  /*วันที่เริ่มคุ้มครอง       */            
                               wdetail.expdat      =    string(brstat.tlt.expodat,"99/99/9999")                                                 /*วันที่สิ้นสุดคุ้มครอง     */            
                               wdetail.comdat72    =    string(brstat.tlt.comp_effdat,"99/99/9999")                                             /*วันทีเริ่มคุ้มครองพรบ     */            
                               wdetail.expdat72    =    string(brstat.tlt.nor_effdat,"99/99/9999")                                              /*วันที่สิ้นสุดคุ้มครองพรบ  */            
                               wdetail.licence     =    brstat.tlt.lince1                                                                       /*เลขทะเบียน                */  
                               wdetail.province    =    brstat.tlt.lince3                                                                       /*จังหวัด                   */  
                               wdetail.ins_amt     =    string(brstat.tlt.nor_coamt)                                                            /*ทุนประกัน                 */  
                               wdetail.prem1       =    string(brstat.tlt.nor_grprm)                                                            /*เบี้ยประกันรวม            */  
                               wdetail.comp_prm    =    string(brstat.tlt.comp_grprm)                                                           /*เบี้ยพรบรวม               */  
                               wdetail.gross_prm   =    string(brstat.tlt.comp_coamt)                                                           /*เบี้ยรวม                  */  
                               wdetail.compno      =    brstat.tlt.comp_pol                                                                     /*เลขกรมธรรม์พรบ            */  
                               wdetail.sckno       =    brstat.tlt.comp_sck                                                                     /*เลขที่สติ๊กเกอร์          */  
                               wdetail.not_code    =    brstat.tlt.comp_usr_tlt                                                                 /*รหัสผู้แจ้ง               */  
                               wdetail.remark      =    brstat.tlt.filler2                                                                      /*หมายเหตุ                  */  
                               wdetail.not_date    =    string(brstat.tlt.datesent,"99/99/9999")                                               /*วันที่รับแจ้ง             */             
                               wdetail.not_office  =    brstat.tlt.nor_usr_tlt                                                                  /*ชื่อประกันภัย             */  
                               wdetail.not_name    =    brstat.tlt.nor_usr_ins                                                                  /*ผู้แจ้ง                   */  
                               wdetail.brand       =    brstat.tlt.brand                                                                        /*ยี่ห้อ                    */  
                               wdetail.Brand_Model =    brstat.tlt.model                                                                        /*รุ่น                      */  
                               wdetail.yrmanu      =    brstat.tlt.lince2                                                                       /*ปี                        */  
                               wdetail.weight      =    string(brstat.tlt.cc_weight)                                                            /*ขนาดเครื่อง               */  
                               wdetail.engine      =    brstat.tlt.eng_no                                                                       /*เลขเครื่อง                */  
                               wdetail.chassis     =    brstat.tlt.cha_no                                                                       /*เลขถัง                    */  
                               wdetail.pattern     =    brstat.tlt.old_cha                                                                      /*Pattern Rate              */  
                               wdetail.covcod      =    brstat.tlt.expousr                                                                      /*ประเภทประกัน              */  
                               wdetail.vehuse      =    brstat.tlt.old_eng                                                                      /*ประเภทรถ                  */  
                               /*wdetail.garage      =    IF trim(brstat.tlt.stat) = "ซ่อมอู่" THEN "G" ELSE ""  */ /*A60-0383*/                /*สถานที่ซ่อม               */  
                               wdetail.garage      =    IF trim(brstat.tlt.expousr) = "1" AND trim(brstat.tlt.stat) = "ซ่อมห้าง" THEN "G" ELSE ""       /*A60-0383*/
                               wdetail.drivename1  =    IF LENGTH(brstat.tlt.dri_name1) <> 0  THEN SUBSTR(brstat.tlt.dri_name1,1,60)  ELSE ""   /*ระบุผู้ขับขี้1            */  
                               wdetail.driveid1    =    IF length(brstat.tlt.dri_name1) > 60 THEN SUBSTR(brstat.tlt.dri_name1,61,20)  ELSE ""   /*เลขที่ใบขับขี่1           */  
                               wdetail.driveic1    =    IF length(brstat.tlt.dri_name1) > 80 THEN SUBSTR(brstat.tlt.dri_name1,81,20)  ELSE ""   /*เลขที่บัตรประชาชน1        */  
                               wdetail.drivedate1  =    brstat.tlt.dri_no1                                                                      /*วันเดือนปีเกิด1           */      
                               wdetail.drivname2   =    IF LENGTH(brstat.tlt.dri_name2) <> 0  THEN SUBSTR(brstat.tlt.dri_name2,1,60)  else ""   /*ระบุผู้ขับขี้2            */  
                               wdetail.driveid2    =    IF length(brstat.tlt.dri_name2) > 60 THEN SUBSTR(brstat.tlt.dri_name2,61,20)  else ""   /*เลขที่ใบขับขี่2           */  
                               wdetail.driveic2    =    IF length(brstat.tlt.dri_name2) > 80 THEN SUBSTR(brstat.tlt.dri_name2,81,20)  else ""   /*เลขที่บัตรประชาชน2        */  
                               wdetail.drivedate2  =    brstat.tlt.dri_no2                                                                      /*วันเดือนปีเกิด2           */      
                               wdetail.cl          =    STRING(brstat.tlt.endno)                                                                /*ส่วนลดประวัติเสีย         */  
                               wdetail.fleetper    =    STRING(brstat.tlt.lotno)                                                                /*ส่วนลดกลุ่ม               */  
                               wdetail.ncbper      =    string(brstat.tlt.seqno)                                                                /*ประวัติดี                 */  
                               wdetail.othper      =    string(brstat.tlt.endcnt)                                                               /*อื่น ๆ                    */  
                               wdetail.addr1       =    brstat.tlt.ins_addr1                                                                    /*ที่อยู่ลูกค้า             */  
                               wdetail.addr2       =    brstat.tlt.ins_addr2                                                                    /*ที่อยู่ลูกค้า             */  
                               wdetail.addr3       =    brstat.tlt.ins_addr3                                                                    /*ที่อยู่ลูกค้า             */  
                               wdetail.addr4       =    brstat.tlt.ins_addr4                                                                    /*ที่อยู่ลูกค้า             */  
                               wdetail.icno        =    "" /*brstat.tlt.ins_addr5*/                                                             /*IDCARD                    */  
                               wdetail.icno_st     =    "" /*brstat.tlt.ins_addr5*/                                                             /*DateCARD_S                */  
                               wdetail.icno_ex     =    "" /*brstat.tlt.ins_addr5*/                                                             /*DateCARD_E                */  
                               wdetail.paid        =    brstat.tlt.safe3                                                                        /*Type_Paid_1               */  
                               wdetail.pol_typ     =    substr(brstat.tlt.subins,2,2)                                                                       /*ประเภท กธ.                */  
                               wdetail.agent       =    brstat.tlt.comp_noti_ins                                                                /*agent                     */  
                               wdetail.producer    =    brstat.tlt.comp_sub                                                                     /*producer                  */
                               wdetail.pass        =    "Y"
                               wdetail.campaign    =    brstat.tlt.rec_addr2. /*A60-0383*/   /*campaign*/                           
                               IF wdetail.icno = "" THEN DO:
                                   ASSIGN n_length            = 0
                                          n_addr5             = ""
                                          n_exp               = ""
                                          n_com               = ""
                                          n_ic                = ""
                                          n_addr5             = TRIM(brstat.tlt.ins_addr5)
                                          n_length            = LENGTH(n_addr5)                                   
                                          n_exp               = SUBSTR(n_addr5,R-INDEX(n_addr5,"Exp:") + 4,n_length)  
                                          n_addr5             = SUBSTR(n_addr5,1,R-INDEX(n_addr5," "))             
                                          n_length            = LENGTH(n_addr5)                                     
                                          n_com               = SUBSTR(n_addr5,R-INDEX(n_addr5,"Comm:") + 5,n_length)
                                          /*n_ic                = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 6) */ /*a60-0383*/
                                          n_ic                = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 5)      /*A60-0383*/
                                          wdetail.icno        = TRIM(n_ic)
                                          wdetail.icno_st     = IF trim(n_com) <> "" THEN SUBSTR(n_com,7,2) + "/" + SUBSTR(n_com,5,2) + "/" + SUBSTR(n_com,1,4) ELSE ""
                                          wdetail.icno_ex     = IF trim(n_exp) <> "" THEN SUBSTR(n_exp,7,2) + "/" + SUBSTR(n_exp,5,2) + "/" + SUBSTR(n_exp,1,4) ELSE "".
                               END.
                               /*A60-0383*/
                                IF      trim(wdetail.pol_title) = "นาย"     THEN ASSIGN  wdetail.pol_title = "คุณ".
                                ELSE IF trim(wdetail.pol_title) = "นาง"     THEN ASSIGN  wdetail.pol_title = "คุณ".
                                ELSE IF trim(wdetail.pol_title) = "น.ส."    THEN ASSIGN  wdetail.pol_title = "คุณ".
                                ELSE IF trim(wdetail.pol_title) = "นางสาว"  THEN ASSIGN  wdetail.pol_title = "คุณ".
                                /* end A60-0383*/
                         END.
                         RUN proc_chkdata. 
                       END.
                       ELSE IF brstat.tlt.releas = "YES" THEN DO:
                            IF brstat.tlt.recac = "" THEN                             
                                ASSIGN brstat.tlt.recac = "ชำระเบี้ยแล้ว"             
                                       /*brstat.tlt.dat_ins_noti =  DATE(wrec.paydate) */ /*A60-0383*/
                                       brstat.tlt.dat_ins_noti =  TODAY  /*A60-0383*/
                                       wrec.remark =  IF brstat.tlt.subins = "V70" THEN wrec.remark + "COMPLETE/ออกกรมธรรม์ไปแล้ว " + brstat.tlt.nor_noti_ins 
                                                      ELSE wrec.remark + "COMPLETE/ออกกรมธรรม์ไปแล้ว " + brstat.tlt.comp_pol. 
                            ELSE ASSIGN wrec.remark = IF brstat.tlt.subins = "V70" THEN  wrec.remark + "ออกกรมธรรม์ไปแล้ว " + brstat.tlt.nor_noti_ins 
                                                      ELSE wrec.remark +  "ออกกรมธรรม์ไปแล้ว " + brstat.tlt.comp_pol.
                       END.
                       ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN wrec.remark = wrec.remark + "มีการยกเลิกเลขที่รับแจ้งนี้แล้ว ".
                    END.
                    /*ELSE ASSIGN wrec.remark = "Not Complete" .*/
                    ELSE ASSIGN wrec.remark = wrec.remark + "ไม่พบข้อมูลในถังพัก " .
                    RELEASE brstat.tlt.
        END.
    END.
IF NOT CONNECTED("sic_exp")  THEN RUN proc_sic_exp.
/*IF CONNECTED("sic_exp") AND nv_type = "V70" THEN RUN wgw\wgwtnchk1.*/ /*A60-0545*/
IF CONNECTED("sic_exp") THEN RUN wgw\wgwtnchk1. /*A60-0545*/
Run Pro_reportreceipt.
Message "Export data Complete"  View-as alert-box.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol2 C-Win 
PROCEDURE proc_impmatpol2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by A59-0471
DEF VAR np_expdat AS CHAR FORMAT "x(15)".
DEF VAR np_year AS INT INIT 0.
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|"        
           wdetail.pol_typ          
           wdetail.policy           
           wdetail.Account_no       
           wdetail.prev_pol         
           wdetail.comp             
           wdetail.comdat           
           wdetail.expdat           
           wdetail.pol_title        
           wdetail.pol_fname        
           wdetail.name2            
           wdetail.addr1            
           wdetail.addr2            
           wdetail.addr3            
           wdetail.addr4            
           wdetail.Prempa           
           wdetail.class            
           wdetail.Brand            
           wdetail.brand_Model      
           wdetail.Weight           
           wdetail.ton              
           wdetail.vehgrp           
           wdetail.Seat             
           wdetail.Body             
           wdetail.licence          
           wdetail.province         
           wdetail.engine           
           wdetail.chassis          
           wdetail.yrmanu           
           wdetail.vehuse           
           wdetail.garage           
           wdetail.sckno            
           wdetail.covcod           
           wdetail.ins_amt          
           wdetail.prem1            
           wdetail.comp_prm         
           wdetail.gross_prm        
           wdetail.ben_name         
           wdetail.drivename        
           wdetail.drivename1       
           wdetail.drivedate1       
           wdetail.age1             
           wdetail.drivname2        
           wdetail.drivedate2       
           wdetail.age1             
           wdetail.redbook          
           wdetail.not_name         
           wdetail.bandet           
           wdetail.not_date         
           wdetail.pattern          
           wdetail.branch_safe      
           wdetail.vatcode          
           wdetail.Pro_off          
           wdetail.remark           
           wdetail.icno 
           wdetail.Finit_code                  
           wdetail.CODE_Rebate.
        IF INDEX(wdetail.pol_typ,"Type")   <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.pol_typ,"เลขที่") <> 0 THEN  DELETE wdetail.
        ELSE IF  wdetail.pol_typ   = "" THEN  DELETE wdetail.
    END.
    FOR EACH wdetail .
       IF wdetail.pol_typ  = "" THEN DELETE wdetail.
       ELSE DO:
           IF wdetail.pol_typ = "70" THEN DO:
               /* ASSIGN np_year   = 0
                       np_year   = (YEAR(DATE(wdetail.expdat)) - 543 )
                       wdetail.expdat = SUBSTR(wdetail.expdat,1,R-INDEX(wdetail.expdat,"/")) + STRING(np_year).*/
                FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.Account_no) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING.
                  IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
                  ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
                  ELSE DO:
                    ASSIGN np_expdat = ""
                           np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").
                          IF DATE(np_expdat) = DATE(wdetail.expdat) THEN DO:
                              ASSIGN  wdetail.policy  = sicuw.uwm100.policy.
                              FIND LAST brstat.tlt USE-INDEX tlt05  WHERE   
                                  brstat.tlt.cha_no  =  trim(wdetail.chassis) AND              
                                  brstat.tlt.genusr  =  "THANACHAT"           AND
                                  brstat.tlt.subins  =  "V70"                 /*AND
                                  brstat.tlt.releas  =  "NO"   */               NO-ERROR NO-WAIT.     
                                  IF AVAIL brstat.tlt THEN DO:
                                      ASSIGN brstat.tlt.releas = "YES".
                                      IF brstat.tlt.nor_noti_ins = ""  THEN ASSIGN brstat.tlt.nor_noti_ins = wdetail.policy.
                                  END.
                                  RELEASE brstat.tlt.
                          END.
                          ELSE ASSIGN wdetail.policy  = "".
                  END.
               END.
               RELEASE sicuw.uwm100.
           END.
           IF wdetail.pol_typ = "72" THEN DO:
                 /* ASSIGN np_year  = 0
                         np_year  = (YEAR(DATE(wdetail.expdat)) - 543 )
                         wdetail.expdat = SUBSTR(wdetail.expdat,1,R-INDEX(wdetail.expdat,"/")) + STRING(np_year).*/
                  FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.Account_no) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING. 
                        IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
                        ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
                        ELSE DO:
                            ASSIGN np_expdat = ""
                                   np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").
                            IF DATE(np_expdat) = DATE(wdetail.expdat) THEN DO:
                                ASSIGN  wdetail.policy  = sicuw.uwm100.policy.
                                FIND LAST brstat.tlt USE-INDEX tlt05  WHERE   
                                    brstat.tlt.cha_no  =  trim(wdetail.chassis) AND              
                                    brstat.tlt.genusr  =  "THANACHAT"           AND
                                    brstat.tlt.subins  =  "V72"                 /*AND
                                    brstat.tlt.releas  =  "NO" */                 NO-ERROR NO-WAIT.     
                                    IF AVAIL brstat.tlt THEN DO:
                                        ASSIGN brstat.tlt.releas = "YES".
                                        IF brstat.tlt.comp_pol     = ""  THEN ASSIGN brstat.tlt.comp_pol  = wdetail.policy.
                                    END.
                                    RELEASE brstat.tlt.
                            END.
                            ELSE ASSIGN wdetail.policy = "".
                        END.
                 END.
                 RELEASE sicuw.uwm100.
           END.
       END. /* else do */
    END. /*wdetail */
Run Pro_reportpolicy.
Message "Export data Complete"  View-as alert-box.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol3 C-Win 
PROCEDURE proc_impmatpol3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_branch AS CHAR.                   /*A60-0383*/
DEF VAR n_accno  AS CHAR FORMAT "x(15)".    /*A60-0383*/
DEF VAR n_length AS INT.
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wcancel.
          IMPORT DELIMITER "|" 
               wcancel.n_no                 /*ลำดับ */                  /*A60-0383*/
               wcancel.Notify_end         /* เลขที่สลักหลัง    */                     
               wcancel.Notify_no          /*เลขที่รับแจ้ง      */                     
               wcancel.enddate           /*วันที่ทำสลักหลัง   */ 
               wcancel.notidate           /*วันที่แจ้งงาน */             /*a60-0383*/
               wcancel.pol_no             /*เลขที่กรมธรรม์/พรบ.*/                     
               wcancel.licence            /*ทะเบียน            */                     
               wcancel.province           /*จังหวัด            */                     
               wcancel.Account_no         /*สาขา-เลขที่สํญญา   */                     
               wcancel.ins_name           /*ชื่อผู้เอาประกัน   */                     
               wcancel.typ_end            /*หัวข้อที่แก้ไข     */                     
               wcancel.ctype              /*ประเภทสลักหลัง     */                     
               wcancel.olddata            /*ข้อมูลเดิม         */                     
               wcancel.newdata            /*ข้อมูลใหม่         */                     
               wcancel.remark_main        /*เหตุผลหลัก         */                     
               wcancel.remark_sub         /*เหตุผลย่อย         */                     
               wcancel.payby              /*ชำระโดย            */                     
               wcancel.nbank              /*ธนาคาร             */                     
               wcancel.paydate            /*วันที่ลูกค้ารับชำระเบี้ยครั้งสุดท้าย*/    
               wcancel.remark             /*หมายเหตุ           */                     
               wcancel.cust_date   .      /*วันที่รับกรมธรรม์  */                    
          IF INDEX(wcancel.Notify_end,"เลขที่") <> 0 THEN DELETE wcancel.
          ELSE IF INDEX(wcancel.Notify_end,"ลำดับ") <> 0 THEN DELETE wcancel. /*60-0383*/
          ELSE IF wcancel.Notify_end = "" THEN DELETE wcancel.
    END.   /* repeat  */
    FOR EACH wcancel .
        IF wcancel.Notify_end  = "" THEN DELETE wcancel.
        ELSE DO:
            ASSIGN   nv_type   = ""     n_length = 0
                     n_branch  = ""     n_accno  = "" . /*A60-0383*/

            IF INDEX(wcancel.ctype,"พรบ") <> 0 THEN ASSIGN nv_type = "V72".
            ELSE ASSIGN nv_type = "V70".
            /* Create by A60-0383 */
            IF wcancel.Account_no <> "" THEN DO:
               IF INDEX(wcancel.account_no,"-") <> 0 THEN ASSIGN n_accno  = REPLACE(wcancel.account_no,"-","").
               ELSE ASSIGN n_accno  = TRIM(wcancel.account_no).
            END.
            /* comment by A59-0471.....
            IF wcancel.ins_name <> "" THEN DO:
                ASSIGN  n_length = LENGTH(wcancel.ins_name)
                        nv_name  = SUBSTR(TRIM(wcancel.ins_name),INDEX(wcancel.ins_name," ") + 1,n_length).
            END.
            ...end A59-0471...*/
            /* comment by A60-0383 ..........
            IF wcancel.pol_no <> "" THEN DO:
                IF INDEX(wcancel.pol_no,"-") <> 0 THEN ASSIGN wcancel.pol_no = REPLACE(wcancel.pol_no,"-","").
                IF INDEX(wcancel.pol_no,"/") <> 0 THEN ASSIGN wcancel.pol_no = REPLACE(wcancel.pol_no,"/","").
            END.
            .... end A60-0383...*/
            FIND LAST brstat.tlt USE-INDEX tlt04  WHERE   
                      brstat.tlt.datesent     <> ?   AND              
                      brstat.tlt.nor_noti_tlt = TRIM(wcancel.Notify_no)  AND  /*เลขรับแจ้ง*/ 
                      /*brstat.tlt.ins_name   = TRIM(nv_name)            AND  /*ชื่อ */ --A59-0471--*/
                      brstat.tlt.genusr       = "THANACHAT"              AND 
                      brstat.tlt.subins       = TRIM(nv_type)            AND  /*type*/
                      brstat.tlt.safe2        = trim(n_accno)            NO-ERROR NO-WAIT.  /*A60-0383*/
                      /*(brstat.tlt.nor_noti_ins = TRIM(wcancel.pol_no)     OR*/                              /*a60-0383*/
                      /* brstat.tlt.comp_pol     = TRIM(wcancel.pol_no)) NO-ERROR NO-WAIT.*/   /*เบอร์กรม*/   /*a60-0383*/
                    IF AVAIL brstat.tlt THEN DO:
                       IF brstat.tlt.releas = "NO" THEN 
                           ASSIGN brstat.tlt.releas = "Cancel/No"
                                  brstat.tlt.filler2 =  brstat.tlt.filler2 + "/" + wcancel.typ_end + " " + wcancel.enddate + " " + 
                                                        wcancel.licence + " " + wcancel.province + " " + wcancel.remark_main + " " +
                                                        wcancel.remark_sub + " " + wcancel.remark                                 
                                  wcancel.datastatus = "Complete".
                       ELSE IF brstat.tlt.releas = "YES" THEN 
                           ASSIGN brstat.tlt.releas = "Cancel/Yes"
                                  brstat.tlt.filler2 =  brstat.tlt.filler2 + "/" + wcancel.typ_end + " " + wcancel.enddate + " " + 
                                                        wcancel.licence + " " + wcancel.province + " " + wcancel.remark_main + " " + 
                                                        wcancel.remark_sub + " " + wcancel.remark 
                                  wcancel.datastatus = "Complete".
                       ELSE IF index(brstat.tlt.releas,"Cancel") <> 0  THEN
                           ASSIGN wcancel.datastatus = "มีการยกเลิกไปแล้ว".
                       /*-- A59-0471 ---*/
                       ELSE IF INDEX(brstat.tlt.releas,"No_Confirm") <> 0 THEN
                           ASSIGN wcancel.datastatus = "มีการ Match No_Confirm แล้ว"
                                  brstat.tlt.filler2 =  brstat.tlt.filler2 + "/" + wcancel.typ_end + " " + wcancel.enddate + " " +       /*A60-0383*/
                                                        wcancel.licence + " " + wcancel.province + " " + wcancel.remark_main + " " +     /*A60-0383*/
                                                        wcancel.remark_sub + " " + wcancel.remark .                                      /*A60-0383*/
                       /*-- end. A59-0471 ---*/
                    END.
                    ELSE ASSIGN wcancel.datastatus = "ไม่พบข้อมูล".
                    RELEASE brstat.tlt.
        END.
    END.
    RUN proc_reportcancel.
    Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol4 C-Win 
PROCEDURE proc_impmatpol4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A59-0471     
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|"  
            wdetail.pol_typ
            wdetail.Pro_off
            wdetail.notify_no 
            wdetail.branch
            wdetail.Account_no
            wdetail.prev_pol
            wdetail.policy
            wdetail.comp
            wdetail.pol_title
            wdetail.pol_fname
            wdetail.ben_name
            wdetail.comdat
            wdetail.expdat
            wdetail.comdat72
            wdetail.expdat72
            wdetail.licence
            wdetail.province
            wdetail.ins_amt
            wdetail.prem1
            wdetail.comp_prm
            wdetail.gross_prm
            wdetail.compno
            wdetail.sckno
            wdetail.not_code
            wdetail.remark
            wdetail.not_date
            wdetail.company
            wdetail.not_name
            wdetail.Brand
            wdetail.brand_Model
            wdetail.yrmanu
            wdetail.Weight
            wdetail.engine
            wdetail.chassis
            wdetail.pattern
            wdetail.covcod
            wdetail.vehuse
            wdetail.garage
            wdetail.drivename1
            wdetail.driveid1   
            wdetail.driveic1   
            wdetail.drivedate1 
            wdetail.drivname2  
            wdetail.driveid2   
            wdetail.driveic2   
            wdetail.drivedate2 
            wdetail.cl        
            wdetail.fleetper  
            wdetail.ncbper    
            wdetail.othper    
            wdetail.addr1
            wdetail.addr2
            wdetail.addr3
            wdetail.addr4
            wdetail.icno     
            wdetail.icno_st  
            wdetail.icno_ex  
            wdetail.paid.     
        IF INDEX(wdetail.pol_typ,"Export")   <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.pol_typ,"ประเภท") <> 0 THEN  DELETE wdetail.
        ELSE IF  wdetail.pol_typ   = "" THEN  DELETE wdetail.
    END.
    FOR EACH wdetail .
       IF wdetail.pol_typ  = "" THEN DELETE wdetail.
       ELSE DO:
         /*IF wdetail.pol_fname <> "" THEN DO:
            ASSIGN  n_length = LENGTH(wdetail.pol_fname)
                    nv_name  = SUBSTR(TRIM(wdetail.pol_fname),INDEX(wdetail.pol_fname," ") + 1,n_length).
         END.*/
         
         FIND LAST brstat.tlt USE-INDEX tlt04  WHERE   
                   brstat.tlt.datesent     <> ?   AND              
                   brstat.tlt.nor_noti_tlt = TRIM(wdetail.notify_no)  AND  /*เลขรับแจ้ง*/ 
                   brstat.tlt.ins_name     = TRIM(wdetail.pol_fname)            AND  /*ชื่อ */
                   brstat.tlt.genusr       = "THANACHAT"              AND 
                   brstat.tlt.subins       = TRIM(wdetail.pol_typ)    /*type*/
                   NO-ERROR NO-WAIT.   /*เบอร์กรม*/  
                   IF AVAIL brstat.tlt THEN DO:
                      IF brstat.tlt.releas = "NO" THEN 
                          ASSIGN brstat.tlt.releas = "No_Confirm/No"
                                 /*brstat.tlt.filler2 =  brstat.tlt.filler2 + "/" + wcancel.typ_end + " " + wcancel.enddate + " " + 
                                                       wcancel.licence + " " + wcancel.province + " " + wcancel.remark_main + " " + wcancel.remark  */                               
                                 wdetail.comment = "Complete".
                      ELSE IF brstat.tlt.releas = "YES" THEN 
                          ASSIGN brstat.tlt.releas = "No_Confirm/Yes"
                                 /*brstat.tlt.filler2 =  brstat.tlt.filler2 + "/" + wcancel.typ_end + " " + wcancel.enddate + " " + 
                                                       wcancel.licence + " " + wcancel.province + " " + wcancel.remark_main + " " + wcancel.remark  */
                                 wdetail.comment = "Complete".
                      ELSE IF index(brstat.tlt.releas,"Cancel") <> 0  THEN
                          ASSIGN wdetail.comment = "มีการ Cancel ไปแล้ว".
                      ELSE IF index(brstat.tlt.releas,"No_Confirm") <> 0  THEN
                          ASSIGN wdetail.comment = "มีแก้ไข Status No_Confirm ไปแล้ว".

                   END.
                   ELSE ASSIGN wdetail.comment = "ไม่พบข้อมูล".
                   RELEASE brstat.tlt.
                   END.
              
    END. /*wdetail */
Run Pro_reportnocon.
Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportcancel C-Win 
PROCEDURE proc_reportcancel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
ASSIGN nv_cnt =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "Report Cancel Thanachat Date : " string(TODAY)   .
EXPORT DELIMITER "|"  
     " ลำดับ                "           /*A60-03838*/
     " เลขที่สลักหลัง        "                        
     " เลขที่รับแจ้ง         "                        
     " วันที่ทำสลักหลัง      " 
     " วันที่แจ้งงาน         "          /*A60-03838*/
     " เลขที่กรมธรรม์/พรบ.   "                        
     " ทะเบียน               "                        
     " จังหวัด               "                        
     " สาขา-เลขที่สัญญา      "                        
     " ชื่อผู้เอาประกัน      "                        
     " หัวข้อที่แก้ไข        "                        
     " ประเภทสลักหลัง        "                        
     " ข้อมูลเดิม            "                        
     " ข้อมูลใหม่            "                        
     " เหตุผลหลัก            "                        
     " เหตุผลย่อย            "                        
     " ชำระโดย               "                        
     " ธนาคาร                "                        
     " วันที่ลูกค้ารับชำระเบี้ยครั้งสุดท้าย "       
     " หมายเหตุ           "                        
     " วันที่รับกรมธรรม์  " 
     " ข้อมูลการยกเลิก "  .
FOR EACH wcancel   no-lock.
    EXPORT DELIMITER "|" 
        wcancel.n_no            /*A60-03838*/
        wcancel.Notify_end           
        wcancel.Notify_no            
        wcancel.enddate 
        wcancel.notidate        /*A60-03838*/
        wcancel.pol_no               
        wcancel.licence              
        wcancel.province             
        wcancel.Account_no           
        wcancel.ins_name             
        wcancel.typ_end              
        wcancel.ctype                
        wcancel.olddata              
        wcancel.newdata              
        wcancel.remark_main          
        wcancel.remark_sub           
        wcancel.payby                
        wcancel.nbank                
        wcancel.paydate              
        wcancel.remark               
        wcancel.cust_date           
        wcancel.datastatus.
END. 
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reporterror C-Win 
PROCEDURE proc_reporterror :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
DEF VAR nv_row AS INTE INIT 1.
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.

FOR EACH wdetail WHERE 
        wdetail.PASS = "N" NO-LOCK:
        pass = pass + 1.
END.
IF pass > 0 THEN DO:
If  substr(fi_outload3,length(fi_outload3) - 3,4) <>  ".SLK"  THEN 
    fi_outload3  =  Trim(fi_outload3) + ".SLK"  .
    OUTPUT TO VALUE(fi_outload3).
        EXPORT DELIMITER "|"
            "Type of Policy"                                     /*1. Policy Type (70/72)*/                                                                                       
            "เลขที่กรมธรรม์"                                     /*2. เลขที่กรมธรรม์ (70)*/                     
            "เลขที่สัญญา"                                        /*3. เลขที่สัญญา (มาจากเลขที่รับแจ้ง)*/        
            "เลขกรมธรรม์ต่ออายุ"                                 /*4. เลขที่กรมธรรม์ต่ออายุ*/                   
            "Compulsory"                                         /*5. Check (Y/N) พ่วง 72 หรือไม่*/             
            "วันที่เริ่มคุ้มครอง"                                /*6. วันที่เริ่มคุ้มครอง*/                     
            "วันที่สิ้นสุดความคุ้มครอง"                          /*7. วันที่สิ้นสุดความคุ้มครอง*/               
            "คำนำหน้าชื่อ"                                       /*8. คำนำหน้าชื่อ*/                            
            "ชื่อผู้เอาประกัน"                                   /*9. ชื่อผู้เอาประกันภัย*/                     
            "และ/หรือ"                                           /*10. และ/หรือ*/                               
            "ที่อยู่ 1"                                          /*11. ที่อยู่ 1*/                              
            "ที่อยู่ 2"                                          /*12. ที่อยู่ 2*/                              
            "ที่อยู่ 3"                                          /*13. ที่อยู่ 4*/                              
            "ที่อยู่ 4"                                          /*14. ที่อยู่ 5*/                              
            "Pack"                                               /*15. Premium Pack*/                           
            "Class"                                              /*16. Class (110)*/                            
            "Brand"                                              /*17. ยี่ห้อรถ*/                               
            "Model"                                              /*18. รุ่นรถ*/                                 
            "CC"                                                 /*19. ขนาดเครื่องยนต์*/                        
            "Weight"                                             /*20. น้ำหนักรถ*/                              
            "vehgrp"                                               /* กลุ่ม */                                    
            "Seat"                                               /*21. ที่นั่ง*/                                
            "Body"                                               /*22. */                                       
            "ทะเบียนรถ"                                          /*23. เลขทะเบียนรถ*/                           
            "จังหวัด"                                            /*24. จังหวัด*/                                
            "เลขเครื่องยนต์"                                     /*25. เลขเครื่องยนต์*/                         
            "เลขตัวถัง"                                          /*26. เลขตัวถัง*/                              
            "ปีที่ผลิต"                                          /*27. ปีที่ผลิต*/                              
            "ประเภทการใช้"                                       /*28. ประเภท*/                                 
            "ซ่อมอู่ห้าง/ธรรมดา"                                 /*29. ซ่อมอู่ ห้าง(G)/ธรรมดา(H)*/              
            "เลขที่สติกเกอร์"                                    /*30. เลขสติกเกอร์*/                           
            "ประเภทความคุ้มครอง"                                 /*31. ประเภทความคุ้มครอง*/                     
            "ทุนประกันภัย"                                       /*32. ทุนประกันภัน*/                           
            "เบี้ยประกันรวม"                                     /*33. เบี้ยรวม*/                               
            "เบี้ย พรบ. รวม"                                     /*34. เบี้ย พรบ. รวม*/                         
            "เบี้ยรวม + พรบ."                                    /*35. เบี้ยรวม พรบ.*/                          
            "ผู้รับผลประโยชน์"                                   /*36. ผู้รับผลประโยชน์*/                       
            "ระบุผู้ขับขี่"                                      /*37. ระบุผุ้ขับขี่ (Y/N)*/                    
            "ชื่อผู้ขับขี่ 1"                                    /*38. ชื่อผุ้ขับขี่ 1*/                        
            "วัน/เดือน/ปีเกิด1"                                  /*39. วันเกิดผู้ขับขี่ 1*/                     
            "อายุ 1"                                             /*40. อายุผู้ขับขี่ 1*/                        
            "ชื่อผู้ขับขี่ 2"                                    /*38. ชื่อผุ้ขับขี่ 2*/                        
            "วัน/เดือน/ปีเกิด2"                                  /*39. วันเกิดผู้ขับขี่ 2*/                     
            "อายุ 2"                                             /*40. อายุผู้ขับขี่ 2*/                        
            "Redbook"                                            /*41. รหัส redbook*/                           
            "ผู้แจ้ง"                                            /*42. ชื่อผุ้แจ้ง*/                            
            "สาขาตลาด"                                           /*43. ตลาดสาขา*/                               
            "วันที่รับแจ้ง"                                      /*44. วันที่รับแจ้ง*/                          
            "ATTERN RATE"                                        /*45. Attrate*/                                
            "Branch"                                             /*46. Branch*/                                 
            "Vat Code"                                           /*47. Vat Code*/                               
            "Text1"                                              /*48. Text ถังแก๊ส*/                           
            "Text2"                                              /*49. Text ตรวจสภาพ*/                          
            "ICNO"                                               /*50. เลขที่บัตรประชาชน*/                      
            "Comment"  .                                         /* Error */ 
        FOR EACH wdetail WHERE wdetail.pass = "N" NO-LOCK.
          EXPORT DELIMITER "|"                                              
                  wdetail.pol_typ                                                                /*1. Policy Type (70/72)*/                                 
                  wdetail.policy                                                                 /*2. เลขที่กรมธรรม์ (70)*/                                 
                  wdetail.Account_no                                                             /*3. เลขที่สัญญา (มาจากเลขที่รับแจ้ง)*/                    
                  wdetail.prev_pol                                                               /*4. เลขที่กรมธรรม์ต่ออายุ*/                               
                  "N"                                                                            /*5. Check (Y/N) พ่วง 72 หรือไม่*/                         
                  IF wdetail.pol_typ = "70" THEN wdetail.comdat  ELSE wdetail.comdat72           /*6. วันที่เริ่มคุ้มครอง*/                                 
                  IF wdetail.pol_typ = "70" THEN wdetail.expdat  ELSE wdetail.expdat72           /*7. วันที่สิ้นสุดความคุ้มครอง*/                           
                  wdetail.pol_title                                                              /*8. คำนำหน้าชื่อ*/                                        
                  wdetail.pol_fname                                                              /*9. ชื่อผู้เอาประกันภัย*/                                 
                  ""                                                                             /*10. และ/หรือ*/                                           
                  wdetail.addr1                                                                  /*11. ที่อยู่ 1*/                                          
                  wdetail.addr2                                                                  /*12. ที่อยู่ 2*/                                          
                  wdetail.addr3                                                                  /*13. ที่อยู่ 4*/                                          
                  wdetail.addr4                                                                  /*14. ที่อยู่ 5*/                                          
                  wdetail.Prempa                                                                 /*15. Premium Pack*/                                       
                  wdetail.class                                                                  /*16. Class (110)*/                                        
                  wdetail.Brand                                                                  /*17. ยี่ห้อรถ*/                                           
                  wdetail.brand_Model                                                            /*18. รุ่นรถ*/                                             
                  wdetail.Weight                                                                 /*19. ขนาดเครื่องยนต์*/                                    
                  wdetail.ton                                                                    /*20. น้ำหนักรถ*/                                          
                  wdetail.vehgrp                                                                 /* กลุ่ม */                       
                  wdetail.Seat                                                                   /*21. ที่นั่ง*/                                            
                  wdetail.Body                                                                   /*22. */                                                   
                  wdetail.licence                                                                /*23. เลขทะเบียนรถ*/                                       
                  wdetail.province                                                               /*24. จังหวัด*/                                            
                  wdetail.engine                                                                 /*25. เลขเครื่องยนต์*/                                     
                  wdetail.chassis                                                                /*26. เลขตัวถัง*/                                          
                  wdetail.yrmanu                                                                 /*27. ปีที่ผลิต*/                                          
                  wdetail.vehuse                                                                 /*28. ประเภท*/                                             
                  wdetail.garage                                                                 /*29. ซ่อมอู่ ห้าง(G)/ธรรมดา(H)*/                          
                  wdetail.sckno                                                                  /*30. เลขสติกเกอร์*/                                       
                  wdetail.covcod                                                                 /*31. ประเภทความคุ้มครอง*/                                 
                  wdetail.ins_amt                                                                /*32. ทุนประกันภัน*/                                       
                  wdetail.prem1                                                                  /*33. เบี้ยรวม*/                                           
                  wdetail.comp_prm                                                               /*34. เบี้ย พรบ. รวม*/                                     
                  wdetail.gross_prm                                                              /*35. เบี้ยรวม พรบ.*/                                      
                  wdetail.ben_name                                                               /*36. ผู้รับผลประโยชน์*/                                   
                  wdetail.drivename                                                              /*37. ระบุผุ้ขับขี่ (Y/N)*/                                
                  wdetail.drivename1                                                             /*38. ชื่อผุ้ขับขี่ 1*/                                    
                  wdetail.drivedate1                                                             /*39. วันเกิดผู้ขับขี่ 1*/                                 
                  ""                                                                             /*40. อายุผู้ขับขี่ 1*/                                    
                  wdetail.drivname2                                                              /*38. ชื่อผุ้ขับขี่ 2*/                                    
                  wdetail.drivedate2                                                             /*39. วันเกิดผู้ขับขี่ 2*/                                 
                  ""                                                                             /*40. อายุผู้ขับขี่ 2*/                                    
                  wdetail.redbook                                                                /*41. รหัส redbook*/                                       
                  wdetail.not_name                                                               /*42. ชื่อผุ้แจ้ง*/                                        
                  wdetail.bandet                                                                 /*43. ตลาดสาขา*/                                           
                  wdetail.not_date                                                               /*44. วันที่รับแจ้ง*/                                      
                  wdetail.pattern                                                                /*45. Attrate*/                                            
                  wdetail.branch_safe                                                            /*46. Branch*/                                             
                  wdetail.vatcode                                                                /*47. Vat Code*/                                           
                  wdetail.Pro_off                                                                /*48. Text ถังแก๊ส*/                                       
                  wdetail.remark                                                                 /*49. Text ตรวจสภาพ*/                                      
                  wdetail.icno                                                                   /*50. เลขที่บัตรประชาชน*/           
                  wdetail.comment.                                                               /* Error */
        END.
    OUTPUT CLOSE.
END. /*pass > 0*/
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
If  substr(fi_outload2,length(fi_outload2) - 3,4) <>  ".CSV"  THEN 
    fi_outload2  =  Trim(fi_outload2) + ".CSV"  .
ASSIGN nv_cnt =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outload2).
EXPORT DELIMITER "|" 
    "Type of Policy"     
    "เลขที่กรมธรรม์"     
    "เลขที่สัญญา"        
    "เลขกรมธรรม์ต่ออายุ" 
    "Compulsory"         
    "วันที่เริ่มคุ้มครอง"
    "วันที่สิ้นสุดความคุ้มครอง"
    "คำนำหน้าชื่อ"       
    "ชื่อผู้เอาประกัน"   
    "และ/หรือ"           
    "ที่อยู่ 1"          
    "ที่อยู่ 2"          
    "ที่อยู่ 3"          
    "ที่อยู่ 4"          
    "Pack"               
    "Class"              
    "Brand"              
    "Model"              
    "CC"                 
    "Weight"             
    "vehgrp"             
    "Seat"               
    "Body"               
    "ทะเบียนรถ"          
    "จังหวัด"            
    "เลขเครื่องยนต์"     
    "เลขตัวถัง"          
    "ปีที่ผลิต"          
    "ประเภทการใช้"       
    "ซ่อมอู่ห้าง/ธรรมดา" 
    "เลขที่สติกเกอร์"    
    "ประเภทความคุ้มครอง" 
    "ทุนประกันภัย"       
    "เบี้ยประกันรวม"     
    "เบี้ย พรบ. รวม"     
    "เบี้ยรวม + พรบ."    
    "ผู้รับผลประโยชน์"   
    "ระบุผู้ขับขี่"      
    "ชื่อผู้ขับขี่ 1"    
    "วัน/เดือน/ปีเกิด1" 
    "เลขที่บัตร ปปช. 1 "  /*A60-0545*/
    "เลขที่ใบขับขี่ 1 "   /*A60-0545*/
    "อายุ 1"             
    "ชื่อผู้ขับขี่ 2"    
    "วัน/เดือน/ปีเกิด2" 
    "เลขที่บัตร ปปช. 2 " /*A60-0545*/ 
    "เลขที่ใบขับขี่ 2 "  /*A60-0545*/ 
    "อายุ 2"             
    "Redbook"            
    "ผู้แจ้ง"            
    "สาขาตลาด"           
    "วันที่รับแจ้ง"      
    "ATTERN RATE"        
    "Branch"             
    "Vat Code"           
    "Text1"              
    "Text2"              
    "ICNO" 
    "Finit Code"                  
    "Code Rebate"
    "Agent    "          /*A60-0383*/
    "Producer "          /*A60-0383*/
    "Campaign "         /*A60-0383*/
    "ชื่อกรรมการ"       /*A60-0545*/
    "เลขที่ตรวจสภาพ"                 /* A61-0512*/ 
    "ประเภทการจ่าย "                 /* A61-0512*/ 
    "วันที่จ่าย"                     /* A61-0512*/ 
    "วันที่ส่งไฟล์ชำระเงินครบ"       /* A61-0512*/ 
    "อาชีพ"       /*A66-0160*/
    "สีรถ"        /*A66-0160*/
    "ACCESSORY" .

FOR EACH wdetail WHERE wdetail.pass <> "N" NO-LOCK.
     nv_row  =  nv_row + 1.
    EXPORT DELIMITER "|" 
     wdetail.pol_typ                                                                         
     wdetail.policy                                                                          
     wdetail.Account_no                                                                      
     wdetail.prev_pol                                                                        
     IF wdetail.pol_typ = "70" THEN "N"   ELSE "Y"                                                                                          
     IF wdetail.pol_typ = "70" THEN wdetail.comdat  ELSE wdetail.comdat72                            
     IF wdetail.pol_typ = "70" THEN wdetail.expdat  ELSE wdetail.expdat72                            
     wdetail.pol_title                                                                               
     wdetail.pol_fname                                                                               
     ""                                                                                              
     wdetail.addr1                                                                                   
     wdetail.addr2                                                                                   
     wdetail.addr3                                                                                   
     wdetail.addr4                                                                                   
     wdetail.Prempa                                                                                  
     wdetail.class                                                                                   
     wdetail.Brand                                                                                   
     wdetail.brand_Model                                                                             
     wdetail.Weight                                                                                  
     wdetail.ton                                                                                     
     wdetail.vehgrp                                                                                  
     wdetail.Seat                                                                                    
     wdetail.Body                                                                                    
     wdetail.licence                                                                                 
     wdetail.province                                                                                
     wdetail.engine                                                                                  
     wdetail.chassis                                                                                 
     wdetail.yrmanu                                                                                  
     wdetail.vehuse                                                                                  
     wdetail.garage                                                                                  
     wdetail.sckno                                                                                   
     wdetail.covcod                                                                                  
     wdetail.ins_amt                                                                                 
     wdetail.prem1                                                                                   
     wdetail.comp_prm                                                                                
     wdetail.gross_prm                                                                               
     wdetail.ben_name                                                                                
     wdetail.drivename                                                                               
     wdetail.drivename1                                                                              
     wdetail.drivedate1 
     wdetail.driveic1   /*A60-0545*/
     wdetail.driveid1   /*A60-0545*/
     ""                                                                                              
     wdetail.drivname2                                                                               
     wdetail.drivedate2 
     wdetail.driveic2   /*A60-0545*/ 
     wdetail.driveid2   /*A60-0545*/ 
     ""                                                                                              
     wdetail.redbook                                                                                 
     wdetail.not_name                                                                                
     wdetail.bandet                                                                                  
     wdetail.not_date                                                                                
     wdetail.pattern                                                                                 
     wdetail.branch_safe                                                                             
     wdetail.vatcode                                                                                 
     wdetail.Pro_off                                                                                 
     wdetail.remark                                                                                  
     wdetail.icno 
     ""
     ""
     wdetail.agent      /*A60-0383*/
     wdetail.producer   /*A60-0383*/
     wdetail.campaign  /*A60-0383*/   
     ""
     wdetail.ispno      /* A61-0512*/
     wdetail.typ_paid   /* A61-0512*/
     wdetail.paid_date  /* A61-0512*/
     wdetail.conf_date  /* A61-0512*/
     ""                 /*A66-0160*/
     wdetail.ncolor     /*A66-0160*/
     wdetail.ACCESSORY.
END.
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp C-Win 
PROCEDURE proc_sic_exp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by Ranu i. A60-0383     
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
     /* CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*//*Comment A62-0105*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile C-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_cnt    =   0
    nv_row    =  1
    ind_f1    = r-index(nv_file1,"\") + 1
    nv_file1  = SUBSTR(nv_file1,ind_f1)
    nv_file1  = SUBSTR(nv_file1,1,R-INDEX(nv_file1,".") - 1 )
    ind_f1    = r-index(nv_file2,"\") + 1
    nv_file2 = SUBSTR(nv_file2,ind_f1) 
    nv_file2 = SUBSTR(nv_file1,1,R-INDEX(nv_file2,".") - 1 ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_reportnocon C-Win 
PROCEDURE pro_reportnocon :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A59-0471     
------------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
ASSIGN nv_cnt =  0
    nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "Report Match File No Confirm Thanachat Date: "  string(TODAY)   .
EXPORT DELIMITER "|" 
   " ประเภทกรมธรรม์          "
   " เลขที่รับแจ้งและสาขา    "
   " เลขที่รับแจ้ง           "
   " สาขา                    "
   " เลขที่สัญญา             "
   " เลขที่กรมธรรม์เดิม      "
   " เลขที่กรมธรรม์ใหม่      "
   " บริษัทประกันเก่า        "
   " คำนำหน้าชื่อ            "
   " ชื่อผู้เอาประกันภัย     "
   " ผู้รับผลประโยชน์        "
   " วันที่เริ่มคุ้มครอง     "
   " วันที่สิ้นสุดคุ้มครอง   "
   " วันทีเริ่มคุ้มครองพรบ   "
   " วันที่สิ้นสุดคุ้มครองพรบ"
   " เลขทะเบียน              "
   " จังหวัด                 "
   " ทุนประกัน               "
   " เบี้ยประกันรวม          "
   " เบี้ยพรบรวม             "
   " เบี้ยรวม                "
   " เลขกรมธรรม์พรบ          "
   " เลขที่สติ๊กเกอร์        "
   " รหัสผู้แจ้ง             "
   " หมายเหตุ                "
   " วันที่รับแจ้ง           "
   " ชื่อประกันภัย           "
   " ผู้แจ้ง                 "
   " ยี่ห้อ                  "
   " รุ่น                    "
   " ปี                      "
   " ขนาดเครื่อง             "
   " เลขเครื่อง              "
   " เลขถัง                  "
   " Pattern Rate            "
   " ประเภทประกัน            "
   " ประเภทรถ                "
   " สถานที่ซ่อม             "
   " หมายเหตุ                ".
FOR EACH wdetail no-lock.
  EXPORT DELIMITER "|" 
      wdetail.pol_typ          
      wdetail.Pro_off        
      wdetail.notify_no      
      wdetail.branch         
      wdetail.Account_no     
      wdetail.prev_pol       
      wdetail.policy         
      wdetail.comp           
      wdetail.pol_title      
      wdetail.pol_fname      
      wdetail.ben_name       
      wdetail.comdat         
      wdetail.expdat         
      wdetail.comdat72       
      wdetail.expdat72       
      wdetail.licence        
      wdetail.province       
      wdetail.ins_amt        
      wdetail.prem1          
      wdetail.comp_prm       
      wdetail.gross_prm      
      wdetail.compno         
      wdetail.sckno          
      wdetail.not_code       
      wdetail.remark         
      wdetail.not_date       
      wdetail.company        
      wdetail.not_name       
      wdetail.Brand          
      wdetail.brand_Model    
      wdetail.yrmanu         
      wdetail.Weight         
      wdetail.engine         
      wdetail.chassis        
      wdetail.pattern        
      wdetail.covcod         
      wdetail.vehuse         
      wdetail.garage 
      wdetail.comment.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_reportpolicy C-Win 
PROCEDURE Pro_reportpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A59-0471
DEF VAR pol72 AS CHAR FORMAT "x(12)" INIT "" .   /*A56-0323*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
ASSIGN nv_cnt =  0
    nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "Report Match policy Thanachat(RENEW) Date: "  string(TODAY)   .
EXPORT DELIMITER "|" 
      "Policy NEW "             
      "เลขที่สัญญา"                     
      "Policy Renew"                    
      "Policy Type"                 
      "Com. Date"                   
      "Exp. Date"                       
      "Title Name"                      
      "Insure name"                     
      "และ/หรือ"                        
      "ใบเสร็จประกัน"                   
      "ใบเสร็จ พรบ."                    
      "Address1"                        
      "Address2"                        
      "Address3"                        
      "Address4"                        
      "Package"                         
      "Class"                           
      "Brand"                       
      "Model"                           
      "CC"                              
      "Weigth"                          
      "Seat"                            
      "Body"                            
      "เลขทะเบียนรถ"                    
      "จังหวัด"                         
      "Engine No."                      
      "Chaiss No."                      
      "Car Year"                        
      "Veh.Use"                         
      "Garage"                          
      "Sticker"                         
      "Cover Code"                      
      "IS"                              
      "Premium Total"                   
      "Premium Compulsory"              
      "Total"                           
      "Bennifit Name"                   
      "Driver Name [Y/N]"               
      "Driver Name1"                    
      "Birthday1"                       
      "Age1"                            
      "Driver Name2"                    
      "Birthday2"                       
      "Age2"                            
      "Redbook No."                     
      "Opnpol"                          
      "Branch Market"                   
      "Date"                            
      "Att.Rate"                        
      "Branch"                          
      "Vat Code"                        
      "Text1"                       
      "Text2"                       
      "ICNO"                        
      "Finit Code"                  
      "Code Rebate".     
FOR EACH wdetail no-lock.
  EXPORT DELIMITER "|" 
      wdetail.policy                    /*Policy NEW */   
      wdetail.Account_no                /*เลขที่สัญญา  */                                                           
      wdetail.prev_pol                  /*Policy Renew */                                                           
      wdetail.pol_typ                   /*Policy Type  */                                                           
      wdetail.comdat                    /*Com. Date    */     
      wdetail.expdat                    /*Exp. Date    */             
      wdetail.pol_title                 /*Title Name   */                                                                   
      wdetail.pol_fname                 /*Insure name  */                                                                   
      wdetail.name2                     /*และ/หรือ     */     
      ""                                /*ใบเสร็จประกัน*/     
      ""                                /*ใบเสร็จ พรบ. */     
      wdetail.addr1                     /*Address1     */                                                                   
      wdetail.addr2                     /*Address2     */                                                                   
      wdetail.addr3                     /*Address3     */                                                                   
      wdetail.addr4                     /*Address4     */                                                                   
      wdetail.Prempa                    /*Package      */                                                                   
      wdetail.class                     /*Class        */                                                                   
      wdetail.Brand                     /*Brand        */                                                                   
      wdetail.brand_Model               /*Model        */                                                                   
      wdetail.Weight                    /*CC           */                                                                   
      wdetail.ton                       /*Weigth       */                                                                   
      wdetail.Seat                      /*Seat         */                                                                   
      wdetail.Body                      /*Body         */                                                                   
      wdetail.licence                   /*เลขทะเบียนรถ */                                                                   
      wdetail.province                  /*จังหวัด      */                                                                   
      wdetail.engine                    /*Engine No.   */                                                                   
      wdetail.chassis                   /*Chaiss No.   */                                                                   
      wdetail.yrmanu                    /*Car Year     */                                                                   
      wdetail.vehuse                    /*Veh.Use      */                                                                   
      wdetail.garage                    /*Garage       */                                                                   
      wdetail.sckno                     /*Sticker      */                                                                   
      wdetail.covcod                    /*Cover Code   */                                                                   
      wdetail.ins_amt                   /*IS           */                                                                   
      wdetail.prem1                     /*Premium Total*/                                                                   
      wdetail.comp_prm                  /*Premium Compulsory*/                                                              
      wdetail.gross_prm                 /*Total             */                                                              
      wdetail.ben_name                  /*Bennifit Name     */                                                              
      wdetail.drivename                 /*Driver Name [Y/N] */                                                              
      wdetail.drivename1                /*Driver Name1      */                                                              
      wdetail.drivedate1                /*Birthday1         */                                                              
      wdetail.age1                      /*Age1              */
      wdetail.drivname2                 /*Driver Name2      */                                                              
      wdetail.drivedate2                /*Birthday2         */                                                              
      wdetail.age2                      /*Age2              */
      wdetail.redbook                   /*Redbook No.       */                                                              
      wdetail.not_name                  /*Opnpol            */                                                              
      wdetail.bandet                    /*Branch Market     */                                                              
      wdetail.not_date                  /*Date              */                                                              
      wdetail.pattern                   /*Att.Rate          */                                                              
      wdetail.branch_safe               /*Branch            */                                                              
      wdetail.vatcode                   /*Vat Code          */                                                              
      wdetail.Pro_off                   /*Text1             */                                                              
      wdetail.remark                    /*Text2             */                                                              
      wdetail.icno                      /*ICNO              */                                                              
      ""                                /*Finit Code        */
      ""    .                            /*Code Rebate       */

END.  */
                              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_reportreceipt C-Win 
PROCEDURE Pro_reportreceipt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
ASSIGN nv_cnt =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "Report Match Recepit Thanachat Date : " string(TODAY)   .
EXPORT DELIMITER "|" 
    " วันที่รับแจ้ง        "            
    " เลขที่รับแจ้ง        "            
    " สาขา – เลขที่สัญญา   "
    " เบอร์กรมธรรม์เดิม    "  /*A60-0383*/
    " ชื่อผู้เอาประกันภัย  "            
    " สมัครใจ/พรบ.         "            
    " วันที่เริ่มคุ้มครอง  "            
    " วันที่สิ้นสุด        "            
    " ค่าเบี้ยประกันภัยรวม "          
    " วันที่ลูกค้าชำระเบี้ยครั้งสุดท้าย "
    " หมายเหตุ "
    " เบี้ยสุทธิ".
FOR EACH wrec   no-lock.
    EXPORT DELIMITER "|" 
         wrec.not_date       /*วันที่รับแจ้ง         */                 
         wrec.Notify_no      /*เลขที่รับแจ้ง         */                 
         wrec.Account_no     /*สาขา – เลขที่สัญญา    */ 
         wrec.prevpol        /*เบอร์ต่ออายุ */
         wrec.not_office     /*ชื่อผู้เอาประกันภัย   */                 
         wrec.ctype          /*สมัครใจ/พรบ.          */                 
         wrec.comdat         /*วันที่เริ่มคุ้มครอง   */                 
         wrec.expdat         /*วันที่สิ้นสุด         */                 
         wrec.prem           /* ค่าเบี้ยประกันภัยรวม */                 
         wrec.paydate        /*วันที่ลูกค้าชำระเบี้ยครั้งสุดท้าย*/ 
         wrec.remark 
         wrec.prem1 .
END. 
OUTPUT CLOSE.
RUN proc_reportloadgw.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

