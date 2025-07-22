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
/*Program name : Match Text File Confirm (THANACHAT)                                  */
/*create by    : Ranu i. A59-0471   โปรแกรม match file ต่ออายุธนชาตหาเบอร์กรมธรรม์    */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */        
/*Modify by : Ranu I. A60-0013 [09/01/2016] ปรับเงื่อนไขการหากรมธรรม์ใหม่ของงานต่ออายุ
              เพิ่มเงื่อนไขการเช็ควันที่คีย์งานต้องมากกว่าวันที่                      */
/*Modify by : Ranu i. A60-0383 21/09/17 เบอร์กรมธรรม์ใหม่ดึง Class จากพรีเมียม        */
/*Modify by : Ranu I. A60-0545 04/01/2018  แก้ไข Format File Match policy ให้เหมือนไฟล์โหลด */
/*Modify By : Ranu I. A61-0512 07/11/2018 เพิ่ม format ตามไฟล์โหลด           */
/*Modify By : Ranu I. A63-0174 05/05/2020 เพิ่มการ Match file policy new */
/*Modify By : Kridtiya i.A63-0228 Date. 20/05/2020 ปรับส่วนการ อัพเดทเลขกรมธรรม์ ใหม่*/
/*Modify By : Ranu I. A64-0205 Date. 12/05/2021 ปิดเงื่อนไขการอัพเดทเลขที่ตรวจสภาพ */
/*Modify by : Ranu I. A64-0278 แก้ไขชื่อและหรือ เป็น "ธนาคารทหารไทยธนชาต จำกัด (มหาชน)" */
/*Modify by : Kridtiya i. A66-0140 chang index tlt05 to tlt06    */
/*Modify by : Kridtiya i. A66-0160 Date. 15/08/2023 Add color */ 
/*---------------------------------------------------------------------------*/       
DEF  stream ns1.
DEFINE VAR  nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR  nv_reccnt      AS  INT  INIT  0.
DEFINE VAR  nv_completecnt AS   INT   INIT  0.
DEFINE VAR  nv_enttim      AS  CHAR          INIT  "".
DEFINE VAR  nv_export      as  date  init  ""  format "99/99/9999".
DEF stream  ns2.
DEFINE VAR nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
{wgw\wgwtnce3.i}
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
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
    FIELD campaign      AS CHAR FORMAT "x(20)" INIT ""   /*A60-0545*/
    FIELD name3         AS CHAR FORMAT "x(70)" INIT ""   /*A60-0545*/
    field ispno         AS CHAR FORMAT "x(25)" INIT ""   /*A61-0512*/
    field paidtyp       AS CHAR FORMAT "x(30)" INIT ""   /*A61-0512*/
    field paiddat       as char format "x(15)" init ""   /*A61-0512*/
    field matcdat       as char format "x(15)" init ""    /*A61-0512*/
    field occupa        AS CHAR FORMAT "x(80)" INIT ""     /*A66-0160*/
    field ncolor        AS CHAR FORMAT "x(50)" INIT ""     /*A66-0160*/
    FIELD acctext       AS CHAR FORMAT "x(500)" INIT ""  .   /*A66-0160*/


DEF VAR  ID_NO1        AS CHAR FORMAT "x(15)"  INIT "" /*A57-0262*/ .
DEF VAR  CLIENT_BRANCH AS CHAR FORMAT "x(30)"  INIT "" /*A57-0262*/ .
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_type fi_loadname fi_outload bu_file-3 ~
bu_ok bu_exit-2 RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS rs_type fi_loadname fi_outload 

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

DEFINE VARIABLE fi_loadname AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "New", 1,
"Renew", 2
     SIZE 47.5 BY 1.19
     BGCOLOR 8 FONT 2 NO-UNDO.

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
     rs_type AT ROW 3.81 COL 34 NO-LABEL WIDGET-ID 2
     fi_loadname AT ROW 5.29 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_outload AT ROW 6.43 COL 29.5 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 5.33 COL 92.5
     bu_ok AT ROW 8.38 COL 84.33
     bu_exit-2 AT ROW 8.38 COL 94.5
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 6.38 COL 14.83
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 5.29 COL 15
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "ืNew : ใช้ไฟล์แจ้งงาน   Renew : ใช้ไฟล์โหลด" VIEW-AS TEXT
          SIZE 45 BY 1.1 AT ROW 7.67 COL 34 WIDGET-ID 6
          BGCOLOR 8 FGCOLOR 15 
     "                    MATCH FILE POLICY (THANACHAT)" VIEW-AS TEXT
          SIZE 105 BY 2.14 AT ROW 1.1 COL 1.17
          BGCOLOR 10 FGCOLOR 6 FONT 2
     "Date:04/09/2023" VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 9.1 COL 66 WIDGET-ID 8
          BGCOLOR 8 FGCOLOR 2 
     RECT-381 AT ROW 3.38 COL 1.5
     RECT-382 AT ROW 7.95 COL 93.17
     RECT-383 AT ROW 7.95 COL 83.17
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
         TITLE              = "Match text  File Policy (THANACHAT)"
         HEIGHT             = 9.91
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
ON END-ERROR OF C-Win /* Match text  File Policy (THANACHAT) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text  File Policy (THANACHAT) */
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
       ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_policy" + NO_add + ".csv".
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
    For each  wdetail:
        DELETE  wdetail.
    END.
   
    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.
   RUN proc_impmatpol2.   /* กรมธรรม์ */
   
   
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
    DISP rs_type WITH FRAME fr_main.
  
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
     gv_prgid = "WGWTNCE3"
     gv_prog  = "Match Text File Policy (THANACHAT)".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  ASSIGN rs_type = 1 .
  DISP rs_type WITH FRAME fr_main .
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
  DISPLAY rs_type fi_loadname fi_outload 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE rs_type fi_loadname fi_outload bu_file-3 bu_ok bu_exit-2 RECT-381 
         RECT-382 RECT-383 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdCheckPol C-Win 
PROCEDURE PdCheckPol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wImport.
    IF wImport.poltyp = "70" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE
                  sicuw.uwm100.cedPol = wImport.cedpol AND
                  sicuw.uwm100.poltyp = "V" + wImport.poltyp  NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN DO:
            ASSIGN
                wImport.policy = sicuw.uwm100.policy
                wImport.Compol = sicuw.uwm100.cr_2
                wImport.Renpol = sicuw.uwm100.cr_1. /*A60*0545*/

            FIND sicuw.uwm120 USE-INDEX uwm12001 WHERE 
                     sicuw.uwm120.policy = sicuw.uwm100.policy AND
                     sicuw.uwm120.rencnt = sicuw.uwm100.rencnt AND
                     sicuw.uwm120.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm120 THEN DO:
                    ASSIGN  wImport.Prempa = SUBSTR(sicuw.uwm120.CLASS,1,1)
                            wImport.class  = substr(sicuw.uwm120.CLASS,2,3).

                    FIND sicuw.uwm301 WHERE sicuw.uwm301.policy = sicuw.uwm120.policy AND                
                                            sicuw.uwm301.rencnt = sicuw.uwm120.rencnt AND                
                                            sicuw.uwm301.endcnt = sicuw.uwm120.endcnt AND 
                                            sicuw.uwm301.riskno = sicuw.uwm120.riskno AND 
                                            sicuw.uwm301.itemno = 1  NO-LOCK NO-ERROR.
                        IF AVAIL sicuw.uwm301 THEN 
                            ASSIGN wimport.redbook =  TRIM(sicuw.uwm301.modcod)
                                   wImport.Weight  =  string(sicuw.uwm301.tons)
                                   wImport.Seat    =  string(sicuw.uwm301.seat)
                                   wImport.Body    =  sicuw.uwm301.body 
                                   wImport.acctxt  =  trim(sicuw.uwm301.prmtxt) .
                END.
             FIND LAST brstat.tlt USE-INDEX tlt06  WHERE   
                       brstat.tlt.cha_no  =  trim(wImport.Chano) AND          /*เลขตัวถัง*/           
                       brstat.tlt.genusr  =  "THANACHAT"           AND
                       brstat.tlt.subins  =  "V70"                 AND 
                       index(trim(wImport.cedpol),brstat.tlt.nor_noti_tlt) <> 0 AND /*เลขรับแจ้ง */
                       brstat.tlt.flag    =  "N"               NO-ERROR NO-WAIT.     
                 IF AVAIL brstat.tlt THEN DO:
                     ASSIGN brstat.tlt.releas = "YES"
                            tlt.dat_ins_noti  = TODAY.
                     IF brstat.tlt.policy    = ""  THEN ASSIGN brstat.tlt.policy   = sicuw.uwm100.policy.
                     /*IF brstat.tlt.comp_pol  = ""  THEN ASSIGN brstat.tlt.comp_pol = sicuw.uwm100.cr_2.*//*comment by kridtiya i. A63-0228 */
                 END.
                 RELEASE brstat.tlt.

              FIND LAST brstat.tlt USE-INDEX tlt06  WHERE   
                       brstat.tlt.cha_no  =  trim(wImport.Chano) AND          /*เลขตัวถัง*/           
                       brstat.tlt.genusr  =  "THANACHAT"           AND
                       brstat.tlt.subins  =  "V72"                 AND 
                       index(trim(wImport.cedpol),brstat.tlt.nor_noti_tlt) <> 0 AND /*เลขรับแจ้ง */
                       brstat.tlt.flag    =  "N"               NO-ERROR NO-WAIT.     
                 IF AVAIL brstat.tlt THEN DO:
                     ASSIGN brstat.tlt.releas = "YES"
                            tlt.dat_ins_noti  = TODAY.
                     /*IF brstat.tlt.policy    = ""  THEN ASSIGN brstat.tlt.policy   = sicuw.uwm100.policy . *//*comment by kridtiya i. A63-0228 */
                     IF substr(brstat.tlt.comp_pol,1,2)  = "02" OR substr(brstat.tlt.comp_pol,1,1)  = "2" OR 
                        brstat.tlt.comp_pol = ""  THEN ASSIGN brstat.tlt.comp_pol = sicuw.uwm100.cr_2 .
                         
                 END.
                 RELEASE brstat.tlt.


        END.
    END.
    ELSE IF wImport.poltyp = "72" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE
                  sicuw.uwm100.cedpol = wImport.cedpol AND
                  sicuw.uwm100.poltyp = "V" + wImport.poltyp NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.cr_2 = "" THEN DO:
                ASSIGN
                    wImport.policy = sicuw.uwm100.cr_2
                    wImport.Compol = sicuw.uwm100.policy
                    wImport.Renpol = sicuw.uwm100.cr_1. /*A60-0545*/

                FIND sicuw.uwm120 USE-INDEX uwm12001 WHERE 
                     sicuw.uwm120.policy = sicuw.uwm100.policy AND
                     sicuw.uwm120.rencnt = sicuw.uwm100.rencnt AND
                     sicuw.uwm120.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm120 THEN DO:
                    ASSIGN  wImport.Prempa = SUBSTR(sicuw.uwm120.CLASS,1,1)
                            wImport.class  = substr(sicuw.uwm120.CLASS,2,3).

                    FIND sicuw.uwm301 WHERE sicuw.uwm301.policy = sicuw.uwm120.policy AND                
                                            sicuw.uwm301.rencnt = sicuw.uwm120.rencnt AND                
                                            sicuw.uwm301.endcnt = sicuw.uwm120.endcnt AND 
                                            sicuw.uwm301.riskno = sicuw.uwm120.riskno AND 
                                            sicuw.uwm301.itemno = 1  NO-LOCK NO-ERROR.
                        IF AVAIL sicuw.uwm301 THEN ASSIGN wimport.redbook =  TRIM(sicuw.uwm301.modcod) .
                END.
                 FIND LAST brstat.tlt USE-INDEX tlt06  WHERE   
                       brstat.tlt.cha_no  =  trim(wImport.Chano) AND          /*เลขตัวถัง*/           
                       brstat.tlt.genusr  =  "THANACHAT"           AND
                       brstat.tlt.subins  =  "V72"                 AND 
                       index(wImport.cedpol,brstat.tlt.nor_noti_tlt) <> 0 AND /*เลขรับแจ้ง */
                       brstat.tlt.flag    =  "N"               NO-ERROR NO-WAIT.     
                 IF AVAIL brstat.tlt THEN DO:
                     ASSIGN brstat.tlt.releas = "YES"
                            tlt.dat_ins_noti  = TODAY.
                     /*IF brstat.tlt.policy    = ""  THEN ASSIGN brstat.tlt.policy   = sicuw.uwm100.cr_2 .*//*comment by kridtiya i. A63-0228 */
                     IF substr(brstat.tlt.comp_pol,1,2)  = "02" OR substr(brstat.tlt.comp_pol,1,1)  = "2" THEN 
                        ASSIGN brstat.tlt.comp_pol = sicuw.uwm100.policy.
                 END.
                 RELEASE brstat.tlt.

            END.
            ELSE DO:
                ASSIGN
                    wImport.policy = ""
                    wImport.Compol = ""
                    wImport.poltyp = ""
                    wImport.Renpol = ""    /*A60-0545*/
                    wImport.name72 = wImport.name72.
            END.
        END.
    END.

RELEASE sicuw.uwm100.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkbranch C-Win 
PROCEDURE PDChkbranch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A63-0174       
------------------------------------------------------------------------------*/
DEFINE VAR nv_choice AS CHAR FORMAT "X(3)".
DO:
    nv_Choice = "".

    IF LENGTH(Imcedpol) = 17 THEN nv_choice = SUBSTRING(Imcedpol,16,2). /*TBSTYN10-04311-21*/
    ELSE IF LENGTH(Imcedpol) = 18 THEN nv_choice = SUBSTRING(Imcedpol,17,2) . /*TBSTYN10-004311-21*/ 

    FIND FIRST stat.Insure WHERE stat.Insure.Compno = "NB" AND
                                 stat.Insure.Insno  = nv_choice NO-LOCK NO-ERROR.
    IF AVAIL stat.Insure THEN DO:
        Imbranch = stat.Insure.Branch.
    END.
    ELSE Imbranch = "".

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkdata C-Win 
PROCEDURE PDChkdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A63-0174       
------------------------------------------------------------------------------*/
RUN PDChkBranch.
    /*--- cedpol ---*/
    IF Imcedpol <> " " THEN DO:
        /*--- Add A53-0111 Edit Vol.1 ---*/
        ASSIGN  
          nv_cedpol = " "
          nv_cedpol = Imcedpol.
        loop_chkcedpol:
        REPEAT:
            IF INDEX(nv_cedpol,"-") <> 0 THEN DO:
                nv_len    = LENGTH(nv_cedpol).
                nv_cedpol = TRIM(SUBSTRING(nv_cedpol,1,INDEX(nv_cedpol,"-") - 1)) +
                            TRIM(SUBSTRING(nv_cedpol,INDEX(nv_cedpol,"-") + 1, nv_len )) .
            END.
            ELSE LEAVE loop_chkcedpol.
        END.
        Imcedpol = nv_cedpol.
        /*--- End Add A53-0111 ---*/
    END.
    ELSE Imcedpol = Imcedpol.

    
    IF deci(Imprem) = 0 AND deci(Imnetprem) = 0 THEN nv_poltyp = "72".
    ELSE nv_poltyp = "70".
    nv_policy = nv_poltyp + Imidno.

    /*---- vghgrp (drivnam) ---*/
    IF trim(Imvghgrp1) = "ไม่ระบุ" THEN nv_drivnam = "N" .
    ELSE nv_drivnam = "Y" .
    /*--- Add A56-0250 ---*/
    IF nv_poltyp = "70" THEN DO:
        /** และ/หรือ Line 70 **/
        nv_name2 = "".
        nv_name70 = "" .
        /* comment by : A64-0278..
        IF      INDEX(Imother1,"Dealer") <> 0  THEN ASSIGN nv_name2  = "และ/หรือ" + " " + Imdealernam
                                                           nv_name70 = "ใบเสร็จออกในนามดีลเลอร์".
        ELSE IF INDEX(Imother1,"Tbank")  <> 0  THEN ASSIGN nv_name2  = "และ/หรือ" + " " + "ธนาคาร ธนชาต จำกัด (มหาชน)"
                                                           nv_name70 = "ใบเสร็จออกในนามธนาคาร". 
        ....end : A64-0278.... */
        /* Add by : A64-0278 */
        IF (INDEX(Imother1,"Dealer") <> 0 OR INDEX(Imother1,"ดีลเลอร์") <> 0 ) THEN 
            ASSIGN nv_name2  = "และ/หรือ" + " " + Imdealernam
                   nv_name70 = "ใบเสร็จออกในนามดีลเลอร์".
        ELSE IF (INDEX(Imother1,"Tbank")  <> 0  OR INDEX(Imother1,"TTB") <> 0 OR 
                 INDEX(Imother1,"ธนาคารแถม")  <> 0 ) THEN DO: 
           FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
              IF AVAIL stat.Company THEN
                  ASSIGN nv_name2 = "และ/หรือ" + " " + stat.Company.NAME
                         nv_name70 = "ใบเสร็จออกในนามธนาคาร". 
        END.
        /* end A64-0278 */
        ELSE IF INDEX(Imother1,"ไม่แถม") <> 0  THEN ASSIGN nv_name2  = " "
                                                           nv_name70 = "ใบเสร็จออกในนามลูกค้า".                                                 
        ELSE ASSIGN nv_name2 = ""   nv_name70 = "ใบเสร็จออกในนามลูกค้า".
    END.
    IF deci(Imcomp) <> 0 THEN DO:
        nv_name72 = "".
        /*IF      INDEX(Imother2,"Dealer")  <> 0  THEN ASSIGN nv_name72 =  "ใบเสร็จออกในนามดีลเลอร์". /*A64-0278*/
        ELSE IF INDEX(Imother2,"Tbank")   <> 0  THEN ASSIGN nv_name72 =  "ใบเสร็จออกในนามธนาคาร". */ /*A64-0278*/
        IF      (INDEX(Imother2,"Dealer") <> 0 OR INDEX(Imother2,"ดีลเลอร์")  <> 0 ) THEN ASSIGN nv_name72 =  "ใบเสร็จออกในนามดีลเลอร์". /*A64-0278*/
        ELSE IF (INDEX(Imother2,"Tbank")  <> 0 OR INDEX(Imother2,"TTB") <> 0 OR INDEX(Imother2,"ธนาคารแถม") <> 0 ) THEN ASSIGN nv_name72 =  "ใบเสร็จออกในนามธนาคาร".  /*A64-0278*/
        ELSE IF INDEX(Imother2,"ไม่ซื้อ") <> 0 THEN ASSIGN nv_name72 =  "ใบเสร็จออกในนามลูกค้า". 
        ELSE ASSIGN nv_name72 = "ใบเสร็จออกในนามลูกค้า". 
    END.
    /*----- Garage ดูจากช่องป้ายแดง ------*/
    IF TRIM(Imdetrge1) = "ป้ายแดง" OR TRIM(Imdetrge1) = "New Car" THEN Imgarage1 = "G". 
    ELSE Imgarage1 = " ".

    /*----- vehuse ----*/
    IF      INDEX(Imvehuse1,"ส่วนบุคคล")       <> 0 THEN ASSIGN Imothvehuse = "1"  n_vehuse = "10". 
    ELSE IF INDEX(Imvehuse1,"เพื่อการพาณิชย์พิเศษ") <> 0 THEN ASSIGN Imothvehuse = "3"  n_vehuse = "40". 
    ELSE IF INDEX(Imvehuse1,"เพื่อการพาณิชย์") <> 0 THEN ASSIGN Imothvehuse = "2"  n_vehuse = "20". 
    ELSE IF INDEX(Imvehuse1,"รับจ้างสาธารณะ")  <> 0 THEN ASSIGN Imothvehuse = "4"  n_vehuse = "30". 
    ELSE IF INDEX(Imvehuse1,"อื่นๆ")           <> 0 THEN ASSIGN Imothvehuse = "5"  n_vehuse = "10".

    /*---- Subclass ----*/
    n_body = "1".
    IF INDEX(Imbody1,"เก๋ง")        <> 0  THEN n_body = "1".
    ELSE IF INDEX(Imbody1,"กระบะ")  <> 0  THEN n_body = "3".
    ELSE IF INDEX(Imbody1,"ตู้")    <> 0  THEN n_body = "2".
    ELSE IF INDEX(imbody1,"บรรทุก") <> 0  THEN n_body = "2".
    ELSE IF INDEX(Imbody1,"อื่นๆ")  <> 0  THEN n_body = "1".

    IF INDEX(Imbody1,"กระบะ") <> 0 THEN Imcodecar = "320".
    ELSE Imcodecar = TRIM(n_body) + TRIM(n_vehuse). /*wdetail.subclass*/

    ASSIGN n_body = ""  n_vehuse = "".
     /*---- Address ----*/
   
    IF trim(Imiadd1) <> "" AND trim(Imiadd2) <> "" THEN DO: 
    END.
    ELSE DO:
        IF TRIM(immadd1) = "" AND TRIM(immadd2) = ""  THEN DO: 
            FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
            IF AVAIL stat.Company THEN DO:
                ASSIGN Imiadd1  = stat.Company.Addr1
                       Imiadd2  = stat.Company.Addr2
                       Imiadd3  = stat.Company.Addr3
                       Imiadd4  = stat.Company.Addr4
                       Imbennam = stat.Company.NAME.
            END.
            ELSE DO:
                ASSIGN Imiadd1  = "444 อาคารเอ็มบีเคทาวเวอร์"
                       Imiadd2  = "ถนนพญาไท แขวงวังใหม่"
                       Imiadd3  = "เขตปทุมวัน  กรุงเทพฯ 10330"
                       Imbennam = "ธนาคารทหารไทยธนชาต จำกัด (มหาชน)". /*A64-0278*/
                       /*Imbennam = "ธนาคาร ธนชาต จำกัด (มหาชน)".*/   /*A64-0278*/
            END.
        END.
        ELSE DO:
            ASSIGN Imiadd1  = TRIM(immadd1)
                   Imiadd2  = TRIM(immadd2)
                   Imiadd3  = TRIM(immadd3)
                   Imbennam = "ธนาคารทหารไทยธนชาต จำกัด (มหาชน)". /*A64-0278*/
                  /*Imbennam = "ธนาคาร ธนชาต จำกัด (มหาชน)".*/   /*A64-0278*/
        END.
    END.
    /*--- Name ---*/
    nv_tinam = "".
    IF Iminsnam <> "" THEN RUN PdChkName.

     /*----- vehreg ----*/
    nv_carpro = "".
    IF TRIM(Imdetrge1) <> "ป้ายแดง" AND TRIM(Imdetrge1) <> "New Car" THEN DO:
        nv_vehreg  = TRIM(Imvehreg).
        
        FOR EACH brstat.insure WHERE brstat.Insure.Compno = "999" NO-LOCK:
            IF INDEX(nv_vehreg,brstat.Insure.Fname) <> 0 THEN DO: 
                ASSIGN
                    nv_vehreg = brstat.insure.Lname
                    nv_carpro = brstat.insure.Fname. 
            END.
        END.
        nv_vehreg1 = SUBSTRING(Imvehreg,1,INDEX(Imvehreg,nv_carpro) - 1).
        IF INDEX(nv_vehreg1,"-") <> 0 THEN DO:
            nv_vehreg1 = SUBSTRING(nv_vehreg1,1,INDEX(nv_vehreg1,"-") - 1) + " "
                         + SUBSTRING(nv_vehreg1,INDEX(nv_vehreg1,"-") + 1,LENGTH(nv_vehreg1)).
        END.
        Imvehreg = nv_vehreg1 + nv_vehreg.
    END.
    ELSE ASSIGN nv_vehreg = " "
                Imvehreg  = IF length(imchasno) > 9 THEN "/" + trim(SUBSTRING(ImChasno,(LENGTH(ImChasno) - 9) + 1,LENGTH(ImChasno))) 
                            ELSE "/" + TRIM(ImChasno).  /*ป้ายแดง*/


    RUN PdChkDate.

    IF INDEX(ImEngno,"'")  <> 0  THEN ImEngno  = trim(REPLACE(ImEngno,"'","")).
    IF INDEX(ImChasno,"'") <> 0  THEN ImChasno = trim(REPLACE(ImChasno,"'","")).
    IF INDEX(ImChasno,"-") <> 0  THEN ImChasno = trim(REPLACE(ImChasno,"-","")).
    
    /*-- Check ICNO --*/
   IF INDEX(imICNo,"'") <> 0 THEN ImICNo = TRIM(REPLACE(ImICNo,"'","")).
   
    RUN PDCreateNew.

    IF  nv_poltyp = "70" AND Imstkno <> "" THEN DO:
        nv_poltyp = "72".
        nv_policy = nv_poltyp + Imidno.

        /*--- Add A56-0250 ---*/
        /** และ/หรือ Line 72 **/
        nv_name2 = "".
        nv_name2 = "".
        /* comment by : A64-0278...
        IF      INDEX(Imother2,"Dealer")  <> 0  THEN nv_name2 = "และ/หรือ" + " " + Imdealernam.
        ELSE IF INDEX(Imother2,"Tbank")  <> 0  THEN ASSIGN nv_name2  = "และ/หรือ" + " " + "ธนาคาร ธนชาต จำกัด (มหาชน)" .  
        .. end : A64-0278... */
        /* Add by : A64-0278 */
        IF      (INDEX(Imother2,"Dealer") <> 0 OR INDEX(Imother2,"ดีลเลอร์") <> 0 ) THEN nv_name2 = "และ/หรือ" + " " + Imdealernam.
        ELSE IF (INDEX(Imother2,"Tbank")  <> 0  OR INDEX(Imother2,"TTB") <> 0 OR 
                 INDEX(Imother2,"ธนาคารแถม")  <> 0 ) THEN DO: 
           FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
              IF AVAIL stat.Company THEN
                  ASSIGN nv_name2 = "และ/หรือ" + " " + stat.Company.NAME.
        END.
        /* end A64-0278 */
        ELSE IF INDEX(Imother2,"ไม่ซื้อ") <> 0  THEN nv_name2 = " ".
        ELSE nv_name2 = " ".
     
        RUN PdCreateNew.
    END.
    ELSE NEXT.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkdate C-Win 
PROCEDURE PDChkdate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A63-0174        
------------------------------------------------------------------------------*/
DEFINE VAR nv_year AS INTE.
DEFINE VAR nv_day AS INTE.
DEFINE VAR nv_month AS INTE.

DO:
    /*--- Comdate ---*/
    nv_year   = (YEAR(DATE(Imcomdate)) - 543).
    nv_day    = DAY(DATE(Imcomdate)).
    nv_month  = MONTH(DATE(Imcomdate)).
    Imcomdate = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    /*--- Expdate ---*/
    nv_year   = (YEAR(DATE(Imexpdate)) - 543).
    nv_day    = DAY(DATE(Imexpdate)).
    nv_month  = MONTH(DATE(Imexpdate)).
    Imexpdate = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    /*---- Add A54-0076 พรบ.---*/
    /*--- Comdate1 ---*/
    nv_year   = (YEAR(DATE(Imcomdat1)) - 543).
    nv_day    = DAY(DATE(Imcomdat1)).
    nv_month  = MONTH(DATE(Imcomdat1)).
    Imcomdat1 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    /*--- Expdate1 ---*/
    nv_year   = (YEAR(DATE(Imexpdat1)) - 543).
    nv_day    = DAY(DATE(Imexpdat1)).
    nv_month  = MONTH(DATE(Imexpdat1)).
    Imexpdat1 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    /*--- End Add A54-0076 ----*/
    /*--- A54-0112 ออกเป็น พ.ศ. ---*/
    /*--- Driver Birth Date 1 ---*/
    nv_year    = YEAR(DATE(Imdrivbir1)).
    nv_day     = DAY(DATE(Imdrivbir1)).
    nv_month   = MONTH(DATE(Imdrivbir1)).
    Imdrivbir1 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    /*--- Driver Birth Date 2 ---*/
    nv_year    = YEAR(DATE(Imdrivbir2)).
    nv_day     = DAY(DATE(Imdrivbir2)).
    nv_month   = MONTH(DATE(Imdrivbir2)).
    Imdrivbir2 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    /*--- End A54-0112 ออกเป็น พ.ศ. ---*/
    /*--- วันที่รับแจ้ง ---*/
    IF rs_type <> 2 THEN DO:
        nv_year  = (YEAR(DATE(Imtltdat)) - 543).
        nv_day   = DAY(DATE(Imtltdat)).
        nv_month = MONTH(DATE(Imtltdat)).
        Imtltdat = STRING(nv_day) + "/" + STRING(nv_month) + "/" + STRING(nv_year).
    END.

    IF Imcomdate  = ? THEN Imcomdate  = "".
    IF Imexpdate  = ? THEN Imexpdate  = "".
    IF Imdrivbir1 = ? THEN Imdrivbir1 = "".
    IF Imdrivbir2 = ? THEN Imdrivbir2 = "".
    IF Imtltdat   = ? THEN Imtltdat   = "".
    IF Imcomdat1  = ? THEN Imcomdat1  = "".
    IF Imexpdat1  = ? THEN Imexpdat1  = "".
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkname C-Win 
PROCEDURE PDChkname :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A63-0174        
------------------------------------------------------------------------------*/
DEFINE VAR nv_insname AS CHAR FORMAT "X(40)" INIT "".
DO:
    /*--- Check Name ----*/
    IF INDEX(ImInsnam,"(") <> 0  THEN DO:
        nv_insname = TRIM(SUBSTRING(Iminsnam,INDEX(ImInsnam,"("),40)).
        ImInsnam = SUBSTRING(ImInsnam,1,INDEX(ImInsnam,"(") - 1).
    END.
    
    nv_Tinam = "".
    nv_Title1 = Iminsnam.
    
    FIND FIRST brstat.msgcode WHERE 
               brstat.msgcode.compno = "999" AND
               INDEX(nv_insname,brstat.msgcode.msgdesc) <> 0 NO-LOCK NO-ERROR.
    IF AVAIL brstat.msgcode THEN DO:
        nv_insname = "".
    END.
    
    FIND FIRST brstat.msgcode WHERE
               brstat.msgcode.compno = "999" AND
               INDEX(iminsnam,msgcode.msgdesc) <> 0 NO-LOCK NO-ERROR.
    IF AVAIL brstat.msgcode THEN DO:
        nv_tinam = msgcode.branch.
        iminsnam = TRIM(SUBSTRING(Iminsnam,LENGTH(MsgCode.MsgDesc) + 1,LENGTH(Iminsnam)) + " " + nv_insname).
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdCreateNew C-Win 
PROCEDURE PdCreateNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A63-0174         
------------------------------------------------------------------------------*/
FIND FIRST wImport WHERE wImport.Policy = nv_policy NO-ERROR NO-WAIT. 
    IF NOT AVAIL wImport THEN DO:
        CREATE wImport.
        ASSIGN               
            wImport.Poltyp    =  nv_poltyp    
            wImport.Policy    =  nv_policy 
            wImport.CedPol    =  Imcedpol  
            wImport.Renpol    =  ""  
            wImport.Compol    =  IF Imstkno <> "" THEN "Y" ELSE "N"  
            wImport.Comdat    =  Imcomdate  
            wImport.Expdat    =  ImExpdate  
            wImport.Tiname    =  nv_tinam  
            wImport.Insnam    =  ImInsnam 
            wimport.name3     =  TRIM(imname2)     
            wimport.dealer    =  TRIM(Imdealernam) 
            wImport.name2     =  nv_name2 
            wImport.name70    =  nv_name70
            wImport.name72    =  nv_name72
            wImport.iaddr1    =  Imiadd1  
            wImport.iaddr2    =  Imiadd2  
            wImport.iaddr3    =  Imiadd3   
            wImport.iaddr4    =  Imiadd4 
            wImport.Prempa    =  ""
            wImport.class     =  Imcodecar  
            wImport.Brand     =  ImBrand  
            wImport.Model     =  ImModel  
            wImport.CC        =  Imcc  
            wImport.Weight    =  ""  
            wImport.Seat      =  ""  
            wImport.Body      =  ""
            wImport.Vehreg    =  TRIM(Imvehreg)  
            wImport.CarPro    =  nv_carpro
            wImport.Engno     =  ImEngno  
            wImport.Chano     =  ImChasno  
            wImport.yrmanu    =  Imyrmanu  
            wImport.Vehuse    =  Imothvehuse 
            wImport.garage    =  Imgarage1 
            wImport.stkno     =  Imstkno  
            wImport.covcod    =  Imcovcod  
            wImport.si        =  Imsi
            wImport.Prem_t    =  deci(ImPrem)      
            wImport.Prem_c    =  deci(Imcomp)      
            wImport.Prem_r    =  deci(ImPremtot)   
            wImport.Bennam    =  Imbennam  
            wImport.drivnam   =  nv_drivnam 
            wImport.drivnam1  =  Imdrivnam1 
            wImport.drivbir1  =  Imdrivbir1 
            wImport.drivic1   =  TRIM(Imidno1)   
            wImport.drivid1   =  TRIM(Imlicen1)  
            wImport.drivage1  =  ""  
            wImport.drivnam2  =  Imdrivnam2  
            wImport.drivbir2  =  Imdrivbir2 
            wImport.drivic2   =  TRIM(Imidno2)   
            wImport.drivid2   =  TRIM(Imlicen2)  
            wImport.drivage2  =  ""  
            wImport.Redbook   =  ""  
            wImport.opnpol    =  Imopnpol  
            wImport.bandet    =  Imbandet  
            wImport.tltdat    =  Imtltdat  
            wImport.attrate   =  Imattrate
            wImport.branch    =  Imbranch
            wImport.vatcode   =  ImVatCode 
            wImport.Text1     =  Imcomment 
            wImport.Text2     =  ImRemark1 
            wImport.finit     =  ImFinint  
            wImport.icno      =  Imicno    
            wImport.Rebate    =  Imcodereb
            wImport.ncolor    =  Imcarcol.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDExport C-Win 
PROCEDURE PDExport :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  add by A63-0174       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (fi_outload) NO-ECHO APPEND.
        EXPORT DELIMITER "|"
            "Policy [V70]"
            "Policy [V72]"
            "เลขที่สัญญา"
            "Campaign"
            "Policy Type"
            "Com. Date"
            "Exp. Date"
            "Title Name"
            "Insure name"
            "และ/หรือ"
            "ชื่อกรรมการ "   
            "ชื่อดีลเลอร์"   
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
            "Net Premium"    
            "Net Compulsory" 
            "Total"
            "Bennifit Name"
            "Driver Name [Y/N]"
            "Driver Name1"
            "Birthday1"
            "Driver Icno1" 
            "DriverLicen1" 
            "Age1"
            "Driver Name2"
            "Birthday2"
            "Driver Icno1" 
            "DriverLicen1" 
            "Age2"
            "Redbook No."
            "Opnpol"
            "Branch Market"
            "Date"
            "Branch"
            "Vat Code"
            "Text1"
            "Text2"
            "ICNO"
            "Finit Code"
            "Code Rebate"
            "รุ่นย่อย"
            "ncolor "
            "acctext" .

        FOR EACH wImport WHERE wImport.poltyp <> "" NO-LOCK:
          EXPORT DELIMITER "|"     
              /*1*/   wImport.Policy        /*1. เลขที่กรมธรรม์ (70)*/                      
              /*2*/   wImport.Compol        /*2. เลขที่กรมธรรม์ (72)*/                       
              /*3*/   wImport.CedPol        /*3. เลขที่สัญญา (มาจากเลขที่รับแจ้ง)*/          
              /*4*/   wImport.Renpol        /*4. เลขที่กรมธรรม์ต่ออายุ*/                     
              /*5*/   wImport.Poltyp        /*5. Policy Type (70/72)*/                       
              /*6*/   wImport.Comdat        /*6. วันที่เริ่มคุ้มครอง*/                       
              /*7*/   wImport.Expdat        /*7. วันที่สิ้นสุดความคุ้มครอง*/                 
              /*8*/   wImport.Tiname        /*8. คำนำหน้าชื่อ*/                              
              /*9*/   wImport.Insnam        /*9. ชื่อผู้เอาประกันภัย*/                       
              /*10*/  wImport.name2         /*10. และ/หรือ*/  
              /*11*/  wimport.name3         /* ชื่อกรรมการ A60-0545*/
                      wimport.dealer        /* ชื่อดีลเลอร์ */
              /*12*/  wImport.name70        /*11. ใบเสร็จประกัน*/ 
              /*13*/  wImport.name72        /*12. ใบเสร็จ พรบ.*/
              /*14*/  wImport.iaddr1        /*13. ที่อยู่ 1*/                                
              /*15*/  wImport.iaddr2        /*14. ที่อยู่ 2*/                                
              /*16*/  wImport.iaddr3        /*15. ที่อยู่ 3*/                                
              /*17*/  wImport.iaddr4        /*16. ที่อยู่ 4*/                                
              /*18*/  wImport.Prempa        /*17. Premium Pack*/                             
              /*19*/  wImport.class         /*18. Class (110)*/                              
              /*20*/  wImport.Brand         /*19. ยี่ห้อรถ*/                                 
              /*21*/  wImport.Model         /*20. รุ่นรถ*/                                   
              /*22*/  wImport.CC            /*21. ขนาดเครื่องยนต์*/                          
              /*23*/  wImport.Weight        /*22. น้ำหนักรถ*/                                
              /*24*/  wImport.Seat          /*23. ที่นั่ง*/                                  
              /*25*/  wImport.Body          /*24. ตัวถัง*/                                   
              /*26*/  wImport.Vehreg        /*25. เลขทะเบียนรถ*/                             
              /*27*/  wImport.CarPro        /*26. จังหวัด*/                                  
              /*28*/  wImport.Engno         /*27. เลขเครื่องยนต์*/                           
              /*29*/  wImport.Chano         /*28. เลขตัวถัง*/                                
              /*30*/  wImport.yrmanu        /*29. ปีที่ผลิต*/                                
              /*31*/  wImport.Vehuse        /*30. ประเภท*/                                   
              /*32*/  wImport.garage        /*31. ซ่อมอู่ ห้าง(G)/ธรรมดา(H)*/                
              /*33*/  wImport.stkno         /*32. เลขสติกเกอร์*/                             
              /*34*/  wImport.covcod        /*33. ประเภทความคุ้มครอง*/                       
              /*35*/  wImport.si            /*34. ทุนประกันภัน*/                             
              /*36*/  wImport.Prem_t        /*35. เบี้ยสุทธิ*/                                 
              /*37*/  wImport.Prem_c        /*36. เบี้ย พรบ.สุทธิ*/                           
              /*38*/  wImport.Prem_r        /*37. เบี้ยรวม + พรบ.*/                            
              /*39*/  wImport.Bennam        /*38. ผู้รับผลประโยชน์*/                         
              /*40*/  wImport.drivnam       /*39. ระบุผุ้ขับขี่ (Y/N)*/                      
              /*41*/  wImport.drivnam1      /*40. ชื่อผุ้ขับขี่ 1*/                          
              /*42*/  wImport.drivbir1      /*41. วันเกิดผู้ขับขี่ 1*/ 
              /*43*/  wImport.drivic1       /*เลขบัตร ปปช.*/             
              /*44*/  wImport.drivid1       /*เลขที่ใบขับขี่*/           
              /*45*/  wImport.drivage1      /*42. อายุผู้ขับขี่ 1*/        
              /*46*/  wImport.drivnam2      /*43. ชื่อผุ้ขับขี่ 2*/        
              /*47*/  wImport.drivbir2      /*44. วันเกิดผู้ขับขี่ 2*/  
              /*48*/  wImport.drivic2       /*เลขบัตร ปปช.*/             
              /*49*/  wImport.drivid2       /*เลขที่ใบขับขี่*/           
              /*50*/  wImport.drivage2      /*45. อายุผู้ขับขี่ 2*/                          
              /*51*/  wImport.Redbook       /*46. รหัส redbook*/                             
              /*52*/  wImport.opnpol        /*47. ชื่อผุ้แจ้ง*/                              
              /*53*/  wImport.bandet        /*48. ตลาดสาขา*/                                 
              /*54*/  wImport.tltdat        /*49. วันที่รับแจ้ง*/                            
              /*55*/  wImport.branch        /*51. Branch*/                                               
              /*56*/  wImport.vatcode       /*52. Vat Code*/                                 
              /*57*/  wImport.Text1         /*53. Text ถังแก๊ส*/                             
              /*58*/  wImport.Text2         /*54. Text ตรวจสภาพ*/                            
              /*59*/  wImport.icno          /*55. เลขที่บัตรประชาชน*/                        
              /*60*/  wImport.finit         /*56. ...*/                                      
              /*61*/  wImport.Rebate         /*57. ...*/                                     
              /*62*/  wImport.attrate       /* รุ่นย่อย */  
                      wImport.ncolor
                      wImport.acctxt.
                      
        END.
    OUTPUT CLOSE.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatnew C-Win 
PROCEDURE proc_impmatnew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A63-0174       
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fi_loadname).
    REPEAT:
        IMPORT DELIMITER "|"
            Imtltdat            /*วันที่รับแจ้ง         */                
            Imcomcod            /*Code ประกันภัย        */                
            Imstkno             /*เลขสติ๊กเกอร์         */                
            Impolcomp           /*กธ พรบ เลขที่         */                
            Imcomnam            /*ชื่อประกันภัย         */                
            Imcedpol            /*เลขที่รับแจ้ง         */                
            Imbandet            /*ตลาดสาขา              */                
            Imbancode           /*Code ตลาดสาขา         */                
            Imopnpol            /*ผู้แจ้ง               */                
            Imcodgrp            /*กลุ่ม                 */                
            Imtiname            /*ผู้รับแจ้ง            */                
            Iminsnam            /*ชื่อผู้เอาประกันภัย   */                
            ImICNo              /*เลขที่บัตร            */                
            Imiadd1             /*ที่อยุ่ปัจจุบัน/ภพ.20 */                
            Imiadd2             /*ที่อยุ่ปัจจุบัน/ภพ.20 */                
            Imiadd3             /*เบอร์โทร              */                
            Immadd1             /*ที่อยู่ส่งเอกสาร      */                
            Immadd2             /*ที่อยู่ส่งเอกสาร1     */                
            Immadd3             /*เบอร์โทร1             */                
            Imsi                /*ทุนประกัน             */                
            Imprem              /*เบี้ยประกันสุทธิ      */                
            Imnetprem           /*เบี้ยประกันรวม        */                
            Imcomp              /*เบี้ยพรบ สุทธิ        */                
            Imnetcomp           /*เบี้ยพรบ รวม          */                
            Impremtot           /*เบี้ยประกัน+พรบ       */                
            imnotino            /*เลขคุ้มครองชั่วคราว   */                
            Imbrand             /*ยี่ห้อ                */                
            Immodel             /*รุ่น                  */                
            Imyrmanu            /*ปี                    */                
            Imcarcol            /*สี                    */                
            Imvehreg            /*เลขทะเบียน            */                
            Imcc                /*ขนาดเครื่องยนต์       */                
            Imengno             /*เลขเครื่องยนต์        */                
            Imchasno            /*เลขตัวถัง             */                
            ImRemark1           /*เหตุผลกรณี เลขเครื่อง/เลขถังซ้ำ*/       
            Imother1            /*ภาคสมัครใจ แถม/ไม่แถม*/                 
            Imother2            /*ภาคบังคับ แถม/ไม่แถม */                 
            /*Imattrate  */         /*PATTERN RATE         */                 
            Imcarpri            /*ราคารถ               */                 
            Imgrossi            /*ราคากลาง             */                 
            Imdealernam         /*ชื่อ Dealer          */                 
            Imcovcod            /*ประเภทการประกันภัย   */                 
            Imvghgrp1           /*ผู้ขับขี่            */                 
            Imdrivnam1          /*ชื่อ 1               */                 
            Imdrivbir1          /*วัน/เดือน/ปีเกิด1    */                 
            Imidno1             /*เลขที่ ID1           */                 
            Imlicen1            /*ใบขับขี่ 1 เลขที่    */                 
            Imdrivnam2          /*ชื่อ 2               */                 
            Imdrivbir2          /*วัน/เดือน/ปีเกิด2    */                 
            Imidno2             /*เลขที่ ID2           */                 
            Imlicen2            /*ใบขับขี่ 2 เลขที่    */                 
            Imcomdate           /*วันที่คุ้มครอง       */                 
            Imexpdate           /*วันสิ้นสุดคุ้มครอง   */                 
            Imvehuse1           /*ประเภทการใช้รถ       */                 
            Imothvehuse         /*หมายเหตุอื่นๆ        */                 
            /*Imcodecar   */        /*รหัส                 */                 
            Imdetrge1           /*ชนิดรถ               */                 
            Imbody1             /*ประเภทรถ             */                 
            Imothbody           /*ประเภทรถอื่นๆ        */                 
            Imgarage1           /*ประเภทการซ่อม        */                 
            Imcodereb           /*Code Rebate          */                 
            Imcomment           /*หมายเหตุ             */                 
            Imseat              /*จำนวนที่นั่ง         */                 
            Imicno1             /*เลขประจำตัวผู้เสียภาษี */               
            imname2             /*ชื่อกรรมการบริษัท      */               
            Imdoctyp            /*ประเภทเอกสาร           */               
            Imdocdetail         /*จดทะเบียนภาษีมูลค่าเพิ่มหรือไม่*/       
            Imbranins           /*สาขาที่              */                 
            Imbennam            /*ผู้รับผลประโยชน์     */                 
            Imidno              /*เลขที่ใบคำขอเช่าซื้อ */ 
            Imattrate  .        /*รุ่นย่อย */     
        IF index(Imtltdat,"วันที่") <> 0  THEN NEXT.
        ELSE IF TRIM(Imtltdat) = ""  THEN NEXT.
        ELSE DO:
            RUN PdChkData.
        END.
    END.
INPUT CLOSE.
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
DEF VAR nv_pol AS CHAR FORMAT "x(15)" .
DEF VAR np_expdat AS CHAR FORMAT "x(15)".
DEF VAR np_trndat AS CHAR FORMAT "x(15)". /*A60-0013*/
DEF VAR np_year AS INT INIT 0.
/* a63-0174*/
IF rs_type = 1 THEN DO:
    RUN proc_impmatnew.
    RUN PdCheckPol.
    RUN PdExport.
END.
ELSE DO:
/* end a63-0174 */
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|"        
           wdetail.pol_typ                      /*Type of Policy     */                     
           wdetail.policy                       /*เลขที่กรมธรรม์     */                 
           wdetail.Account_no                   /*เลขที่สัญญา        */                 
           wdetail.prev_pol                     /*เลขกรมธรรม์ต่ออายุ */                 
           wdetail.comp                         /*Compulsory         */                 
           wdetail.comdat                       /*วันที่เริ่มคุ้มครอง*/                 
           wdetail.expdat                       /*วันที่สิ้นสุดความคุ้มครอง*/           
           wdetail.pol_title                    /*คำนำหน้าชื่อ     */                   
           wdetail.pol_fname                    /*ชื่อผู้เอาประกัน */                   
           wdetail.name2                        /*และ/หรือ         */                   
           wdetail.addr1                        /*ที่อยู่ 1        */                   
           wdetail.addr2                        /*ที่อยู่ 2        */                   
           wdetail.addr3                        /*ที่อยู่ 3        */                   
           wdetail.addr4                        /*ที่อยู่ 4        */                   
           wdetail.Prempa                       /*Pack             */                   
           wdetail.class                        /*Class            */                   
           wdetail.Brand                        /*Brand            */                   
           wdetail.brand_Model                  /*Model            */                   
           wdetail.Weight                       /*CC               */                   
           wdetail.ton                          /*Weight           */                   
           wdetail.vehgrp                       /*vehgrp           */                   
           wdetail.Seat                         /*Seat             */                   
           wdetail.Body                         /*Body             */                   
           wdetail.licence                      /*ทะเบียนรถ        */                   
           wdetail.province                     /*จังหวัด          */                   
           wdetail.engine                       /*เลขเครื่องยนต์   */                   
           wdetail.chassis                      /*เลขตัวถัง        */                   
           wdetail.yrmanu                       /*ปีที่ผลิต        */                   
           wdetail.vehuse                       /*ประเภทการใช้     */                   
           wdetail.garage                       /*ซ่อมอู่ห้าง/ธรรมดา */                 
           wdetail.sckno                        /*เลขที่สติกเกอร์    */                 
           wdetail.covcod                       /*ประเภทความคุ้มครอง */                 
           wdetail.ins_amt                      /*ทุนประกันภัย       */                 
           wdetail.prem1                        /*เบี้ยประกันรวม     */                 
           wdetail.comp_prm                     /*เบี้ย พรบ. รวม     */                 
           wdetail.gross_prm                    /*เบี้ยรวม + พรบ.    */                 
           wdetail.ben_name                     /*ผู้รับผลประโยชน์   */                 
           wdetail.drivename                    /*ระบุผู้ขับขี่      */                 
           wdetail.drivename1                  /*ชื่อผู้ขับขี่ 1    */                 
           wdetail.drivedate1                  /*วัน/เดือน/ปีเกิด1  */
           wdetail.driveic1    /*A60-0545*/    /*เลขบัตร ปชช 1 */
           wdetail.driveid1    /*A60-0545*/    /*เลขที่ใบขับขี่ 1 */
           wdetail.age1                        /*อายุ 1             */                 
           wdetail.drivname2                   /*ชื่อผู้ขับขี่ 2    */                 
           wdetail.drivedate2                  /*วัน/เดือน/ปีเกิด2  */  
           wdetail.driveic2    /*A60-0545*/    /*เลขบัตร ปชช 1 */   
           wdetail.driveid2    /*A60-0545*/    /*เลขที่ใบขับขี่ 1 */
           wdetail.age1                        /*อายุ 2        */                      
           wdetail.redbook                      /*Redbook       */                      
           wdetail.not_name                     /*ผู้แจ้ง       */                      
           wdetail.bandet                       /*สาขาตลาด      */                      
           wdetail.not_date                     /*วันที่รับแจ้ง */                      
           wdetail.pattern                      /*ATTERN RATE   */                      
           wdetail.branch_safe                  /*Branch        */                      
           wdetail.vatcode                      /*Vat Code      */                      
           wdetail.Pro_off                      /*Text1         */                      
           wdetail.remark                       /*Text2         */                      
           wdetail.icno                         /*ICNO          */                      
           wdetail.Finit_code                   /*Finit Code    */                      
           wdetail.CODE_Rebate                  /*Code Rebate   */                      
           wdetail.agent        /*A60-0383*/    /*Agent         */                      
           wdetail.producer    /*A60-0383*/    /*Producer      */                      
           wdetail.campaign    /*A60-0545*/    /*Campaign      */ 
           wdetail.name3       /*A60-0545*/    /*ชื่อกรรมการ */
           wdetail.ispno      /*A61-0512*/    /*เลขที่ตรวจสภาพ */
           wdetail.paidtyp    /*A61-0512*/    /*ประเภทการจ่าย */
           wdetail.paiddat    /*A61-0512*/    /*วันที่จ่าย */
           wdetail.matcdat    /*A61-0512*/    /*วันที่ match file  */
           wdetail.occupa     /*A66-0160*/
           wdetail.ncolor .   /*A66-0160*/

        IF INDEX(wdetail.pol_typ,"Type")   <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.pol_typ,"เลขที่") <> 0 THEN  DELETE wdetail.
        ELSE IF  wdetail.pol_typ   = "" THEN  DELETE wdetail.
    END.
    FOR EACH wdetail .
       IF wdetail.pol_typ  = "" THEN DELETE wdetail.
       ELSE DO:
           IF wdetail.pol_typ = "70" THEN DO:
               
           FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.Account_no) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING.
                  IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
                  /*ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.*/ /*A60-0013*/
                  ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY)  THEN NEXT. /*A60-0013*/
                  ELSE DO:
                      ASSIGN  nv_pol    = ""    /*A63-0174*/
                              np_expdat = ""                                                           
                              np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").                    
                      IF YEAR(DATE(np_expdat)) <> YEAR(DATE(wdetail.expdat)) THEN NEXT. /*A60-0013*/   
                      ELSE DO: 
                            /*add by A60-0013*/
                            ASSIGN np_trndat = ""           
                                   np_trndat = STRING(sicuw.uwm100.trndat,"99/99/9999").
                            IF DATE(np_trndat) < date(wdetail.not_date) THEN NEXT. /*วันที่คีย์งาน < วันที่แจ้งงาน*/
                            /* end A60-0013*/
                            ELSE DO: 
                                IF DATE(np_expdat) = DATE(wdetail.expdat) THEN DO:
                                    ASSIGN  wdetail.policy  = sicuw.uwm100.policy
                                            nv_pol          = sicuw.uwm100.cr_2.  /* a63-0174 */
                                    /* A60-0383*/
                                    FIND sicuw.uwm120 USE-INDEX uwm12001 WHERE 
                                         sicuw.uwm120.policy = sicuw.uwm100.policy AND
                                         sicuw.uwm120.rencnt = sicuw.uwm100.rencnt AND
                                         sicuw.uwm120.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
                                    IF AVAIL sicuw.uwm120 THEN DO:
                                        ASSIGN  wdetail.Prempa = SUBSTR(sicuw.uwm120.CLASS,1,1)
                                                wdetail.class  = substr(sicuw.uwm120.CLASS,2,3).
                                        FIND sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                                            sicuw.uwm301.policy = sicuw.uwm120.policy AND                
                                            sicuw.uwm301.rencnt = sicuw.uwm120.rencnt AND                
                                            sicuw.uwm301.endcnt = sicuw.uwm120.endcnt AND 
                                            sicuw.uwm301.riskno = sicuw.uwm120.riskno AND 
                                            sicuw.uwm301.itemno = 1  NO-LOCK NO-ERROR.
                                        IF AVAIL sicuw.uwm301 THEN ASSIGN wdetail.acctext  =  trim(sicuw.uwm301.prmtxt) .
                                    END.
                                    /* end A60-0383*/
                                    /*FIND LAST brstat.tlt USE-INDEX tlt05  WHERE   */ /*Kridtiya i. A66-0140 Date.13/07/2023 */
                                    FIND LAST brstat.tlt USE-INDEX tlt06  WHERE        /*Kridtiya i. A66-0140 Date.13/07/2023 */
                                              brstat.tlt.cha_no  =  trim(wdetail.chassis) AND          /*เลขตัวถัง*/           
                                              brstat.tlt.genusr  =  "THANACHAT"           AND
                                              brstat.tlt.subins  =  "V70"                 AND 
                                              index(wdetail.Pro_off,brstat.tlt.nor_noti_tlt) <> 0 AND /*เลขรับแจ้ง */
                                              /*brstat.tlt.releas  =  "R"                NO-ERROR NO-WAIT.  /*A63-0174*/  *//*comment by kridtiya i. A63-0228 */
                                              brstat.tlt.flag    =  "R"                NO-ERROR NO-WAIT.                    /*Add by kridtiya i. A63-0228 */
                                    IF AVAIL brstat.tlt THEN DO:
                                        ASSIGN brstat.tlt.releas = "YES" .
                                        /* brstat.tlt.rec_addr5 = TRIM(wdetail.ispno) . /*A61-0412*/* A64-0205 */
                                        IF brstat.tlt.nor_noti_ins = ""  THEN ASSIGN brstat.tlt.nor_noti_ins = wdetail.policy.
                                        
                                    END.
                                    
                                    RELEASE brstat.tlt.
                                END.
                                ELSE ASSIGN wdetail.policy  = "". 
                            END.  /*วันที่คีย์งาน > วันที่แจ้งงาน*/
                      END. /* end year(expdat) = year(wexpdat) */
                  END. /* else year(expdat) > today */
               END. /* for each */
               RELEASE sicuw.uwm100.
           END. /*if 70 */
           IF wdetail.pol_typ = "72" THEN DO:
                 FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.Account_no) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING. 
                        IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
                        /*ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.*/ /*A60-0013*/
                        ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY)  THEN NEXT. /*A60-0013*/
                        ELSE DO:
                            ASSIGN nv_pol    = ""   /*a63-0174*/
                                   np_expdat = ""
                                   np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").
                            IF YEAR(DATE(np_expdat)) <> YEAR(DATE(wdetail.expdat)) THEN NEXT. /* เช็คปีหมดอายุ A60-0013*/
                            ELSE DO:
                                /*add by A60-0013*/
                                ASSIGN np_trndat = ""           
                                       np_trndat = STRING(sicuw.uwm100.trndat,"99/99/9999").
                                IF DATE(np_trndat) < DATE(wdetail.not_date) THEN NEXT. /*วันที่คีย์งาน < วันที่แจ้งงาน*/
                                /* end A60-0013*/
                                ELSE DO:
                                    IF DATE(np_expdat) = DATE(wdetail.expdat) THEN DO:
                                        ASSIGN  wdetail.policy  = sicuw.uwm100.policy
                                                nv_pol          = sicuw.uwm100.cr_2.  /* a63-0174 */
                                         /* A60-0383*/
                                        FIND sicuw.uwm120 USE-INDEX uwm12001 WHERE 
                                             sicuw.uwm120.policy = sicuw.uwm100.policy AND
                                             sicuw.uwm120.rencnt = sicuw.uwm100.rencnt AND
                                             sicuw.uwm120.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR.
                                        IF AVAIL sicuw.uwm120 THEN DO:
                                            ASSIGN
                                                wdetail.class  = sicuw.uwm120.CLASS
                                                wdetail.Prempa = "" .
                                        END.
                                        /* end A60-0383*/
                                        /*FIND LAST brstat.tlt USE-INDEX tlt05  WHERE *//*kridtiyai. A66-0140 Date 13/07/2023*/
                                        FIND LAST brstat.tlt USE-INDEX tlt06  WHERE     /*kridtiyai. A66-0140 Date 13/07/2023*/
                                            brstat.tlt.cha_no  =  trim(wdetail.chassis) AND              
                                            brstat.tlt.genusr  =  "THANACHAT"           AND
                                            brstat.tlt.subins  =  "V72"                 and
                                            index(wdetail.Pro_off,brstat.tlt.nor_noti_tlt) <> 0 AND
                                            brstat.tlt.flag    =  "R"                   NO-ERROR NO-WAIT.   /*A63-0174*/  
                                            IF AVAIL brstat.tlt THEN DO:
                                                ASSIGN brstat.tlt.releas    = "YES" .
                                                       /*brstat.tlt.rec_addr5 = TRIM(wdetail.ispno) . /*A61-0412*/*/ /*A64-0205*/
                                    
                                                IF brstat.tlt.comp_pol     = ""  THEN ASSIGN brstat.tlt.comp_pol  = wdetail.policy.
                                                
                                            END.
                                           
                                            RELEASE brstat.tlt.
                                    END.
                                    ELSE ASSIGN wdetail.policy = "".
                                END.
                            END.
                        END.
                 END.
                 RELEASE sicuw.uwm100.
           END.
       END. /* else do */
    END. /*wdetail */
    Run Pro_reportpolicy.
END.
Message "Export data Complete"  View-as alert-box.
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
      "Producer"      /*A60-0383*/ 
      "Agent"         /*A60-0383*/   
      "Campaign"      /*A60-0545*/   
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
      "ICNO1"       /*A60-0545*/
      "IDNO1"       /*A60-0545*/
      "Age1"                            
      "Driver Name2"                    
      "Birthday2" 
      "ICNO2"       /*A60-0545*/    
      "IDNO2"       /*A60-0545*/    
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
      "Code Rebate"
      "ชื่อกรรมการ"  /*A60-0545*/
      "เลขที่ตรวจสภาพ"                  /* A61-0512 */
      "ประเภทการจ่าย "                  /* A61-0512 */
      "วันที่จ่าย        "                  /* A61-0512 */
      "วันที่ส่งไฟล์ชำระเงินครบ"        /* A61-0512 */
      "อาชีพ"   /*A66-0160*/
      "สีรถ"     /*A66-0160*/
      "acctext ".

FOR EACH wdetail no-lock.
  EXPORT DELIMITER "|" 
      wdetail.policy                    /*Policy NEW */   
      wdetail.Account_no                /*เลขที่สัญญา  */ 
      wdetail.producer   /*A60-0383*/   /*producer */
      wdetail.agent      /*A60-0383*/   /*Agent     */
      wdetail.campaign   /*A60-0545*/   /*Campaign      */ 
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
      wdetail.driveic1    /*A60-0545*/  /*เลขบัตร ปชช 1 */     
      wdetail.driveid1    /*A60-0545*/  /*เลขที่ใบขับขี่ 1 */  
      wdetail.age1                      /*Age1              */
      wdetail.drivname2                 /*Driver Name2      */                                                              
      wdetail.drivedate2                /*Birthday2         */ 
      wdetail.driveic2    /*A60-0545*/  /*เลขบัตร ปชช 1 */     
      wdetail.driveid2    /*A60-0545*/  /*เลขที่ใบขับขี่ 1 */  
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
      ""                                /*Code Rebate       */
      wdetail.name3          /*A60-0545*/    /*ชื่อกรรมการ */   
      wdetail.ispno      /*A61-0512*/    /*เลขที่ตรวจสภาพ */          
      wdetail.paidtyp    /*A61-0512*/    /*ประเภทการจ่าย */           
      wdetail.paiddat    /*A61-0512*/    /*วันที่จ่าย */              
      wdetail.matcdat    /*A61-0512*/    /*วันที่ match file  */    
      wdetail.occupa     /*A66-0160*/
      wdetail.ncolor      /*A66-0160*/
      wdetail.acctext .

END.                                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

