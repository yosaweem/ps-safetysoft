&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
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
wgwimtis.w :  Import text file from  Lockton (renew) Add in table tlt( brstat)  
Program Import Text File    - File detail insured 
Create  by   : Ranu i.  [A60-0139]  date. 20/03/2017
copy program : wgwloctn.w  
Connect    : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW (not connect dbstat)*/
/* Modify by : Ranu I. A60-0272 date : 23/06/2017   เพิ่มการเก็บข้อมูล ICNO และเช็ค รย. 50000 */
/*+++++++++++++++++++++++++++++++++++++++++++++++*/
DEF     SHARED VAR n_User    AS CHAR.  /*A60-0118*/
DEF     SHARED VAR n_Passwd  AS CHAR.  /*A60-0118*/
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC  INIT   Yes.
DEFINE BUFFER bftlt FOR brstat.tlt.   
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD RecordID     AS CHAR FORMAT "X(02)"  INIT ""   /*1  Detail Record "D"*/
    FIELD Pro_off      AS CHAR FORMAT "X(10)"  INIT ""   /*2  รหัสสาขาที่ผู้เอาประกันเปิดบัญชี    */
    FIELD cmr_code     AS CHAR FORMAT "X(03)"  INIT ""   /*3  รหัสเจ้าหน้าที่การตลาด    */
    FIELD comp_code    AS CHAR FORMAT "X(03)"  INIT ""   /*4  รหัส บ.ประกันภัย(TLT.COMMENT)   */
    FIELD Notify_no    AS CHAR FORMAT "X(25)"  INIT ""   /*5  เลขที่รับแจ้งประกัน   */
    FIELD yrmanu       AS CHAR FORMAT "X(4)"   INIT ""   /*6  Year of car  */
    FIELD engine       AS CHAR FORMAT "X(25)"  INIT ""   /*7  หมายเลขเครื่องยนต์*/
    FIELD chassis      AS CHAR FORMAT "X(25)"  INIT ""   /*8  หมายเลขตัวถังรถ*/
    FIELD weight       AS CHAR FORMAT "X(05)"  INIT ""   /*9  WEIGHT KG/TON*/
    FIELD Power        AS CHAR FORMAT "X(07)"  INIT ""   /*10 WEIGHT KG/TON*/
    FIELD colorcode    AS CHAR FORMAT "X(10)"  INIT ""   /*11 Color Code*/
    FIELD licence      AS CHAR FORMAT "X(10)"  INIT ""   /*12 หมายเลขทะเบียนรถ */
    FIELD garage       AS CHAR FORMAT "X(01)"  INIT ""   /*13 Claim condition /การซ่อม */
    FIELD fleetper     AS CHAR FORMAT "X(05)"  INIT ""   /*14 Fleet Discount     */
    FIELD ncbper       AS CHAR FORMAT "X(05)"  INIT ""   /*15 Experience Discount /ส่วนลดประวัติดี  */
    FIELD othper       AS CHAR FORMAT "X(05)"  INIT ""   /*16 Other Discount /ส่วนลดอื่น ๆ  */
    FIELD vehuse       AS CHAR FORMAT "X(01)"  INIT ""   /*17 การใช้งานรถ */
    FIELD comdat       AS CHAR FORMAT "X(08)"  INIT ""   /*18 วันทีเริ่มคุ้มครอง */
    FIELD ins_amt      AS CHAR FORMAT "X(11)"  INIT ""   /*19 ทุนประกัน */
    FIELD name_insur   AS CHAR FORMAT "X(15)"  INIT ""   /*20 ชื่อเจ้าหน้าที่ประกัน */
    FIELD Not_office   AS CHAR FORMAT "X(75)"  INIT ""   /*21 รหัสเจ้าหน้าทีแจ้งประกัน(Tisco)  */
    FIELD Not_date     AS CHAR FORMAT "X(08)"  INIT ""   /*22 วันที่แจ้งประกัน */
    FIELD Not_code     AS CHAR FORMAT "X(04)"  INIT ""   /*24 รหัสแจ้งงาน เช่น TF01 */
    FIELD Prem1        AS CHAR FORMAT "X(11)"  INIT ""   /*25 เบี้ยประกันรวม(ค่าเบี้ยป.1 + ภาษี + อากร) */
    FIELD comp_prm     AS CHAR FORMAT "X(09)"  INIT ""   /*26 เบี้ยพรบ.รวม */
    FIELD sckno        AS CHAR FORMAT "X(25)"  INIT ""   /*27 เลขท ี Sticker. */
    FIELD brand        AS CHAR FORMAT "X(50)"  INIT ""   /*28 ยี่ห้อรถ */
    FIELD pol_addr     AS CHAR FORMAT "X(150)" INIT ""  
    FIELD pol_addr1    AS CHAR FORMAT "X(70)"  INIT ""  /*29 ที่อยู่ผู้เอาประกัน1  */
    FIELD pol_addr2    AS CHAR FORMAT "X(70)"  INIT ""   /*30 ที่อยู่ผู้เอาประกัน2 รวมรหัสไปรษณีย์*/
    FIELD pol_title    AS CHAR FORMAT "X(30)"  INIT ""   /*31 คำนำหน้าชื่อผู้เอาประกัน  */
    FIELD pol_fname    AS CHAR FORMAT "X(75)"  INIT ""   /*32 ชื่อผู้เอาประกัน/นิติบุคคล */
    FIELD pol_Lname    AS CHAR FORMAT "X(45)"  INIT ""   /*33 นามสกุลผู้เอาประกัน  */
    FIELD Ben_name     AS CHAR FORMAT "X(65)"  INIT ""   /*34 ชื่อผู้รับประโยชน์  */
    FIELD camp         AS CHAR FORMAT "X(10)" INIT ""    /*35 campaign  */
    FIELD Account_no   AS CHAR FORMAT "X(10)"  INIT ""   /*36 เลขที่สัญญาของผู้เอาประกัน(Tisco)  */
    FIELD Client_no    AS CHAR FORMAT "X(07)"  INIT ""   /*37 รหัสของผู้เอาประกัน  */
    FIELD expdat       AS CHAR FORMAT "X(08)"  INIT ""   /*38 วันทีสิ้นสุดความคุ้มครอง */
    FIELD Gross_prm    AS CHAR FORMAT "X(11)"  INIT ""   /*39 เบี้ย.รวมพรบ. (ทั้งหมด) */
    FIELD Province     AS CHAR FORMAT "X(18)"  INIT ""   /*40 จังหวัดที่จดทะเบียนรถ */
    FIELD Receipt_name AS CHAR FORMAT "X(50)"  INIT ""   /*41 ชื่อที่ใช้ในการพิมพ์ใบเสร็จ */
    FIELD Agent        AS CHAR FORMAT "X(15)"  INIT ""   /*42 Code บริษัท เช่น Tisco,Tisco-pf. */
    FIELD Prev_insur   AS CHAR FORMAT "X(50)"  INIT ""   /*43 ชื่อบริษัทประกันภัยเดิม */
    FIELD Prev_pol     AS CHAR FORMAT "X(25)"  INIT ""   /*44 เลขที่กรมธรรม์เดิม */
    FIELD deduct       AS CHAR FORMAT "X(09)"  INIT ""   /*45 ความเสียหายส่วนแรก */
    FIELD seatenew     AS CHAR FORMAT "x(10)"  INIT ""   /*A57-0017*/
    FIELD pack         AS CHAR FORMAT "X(10)"  INIT ""    /*A55-0184*/
    FIELD tp1          AS CHAR FORMAT "X(20)"  INIT ""   
    FIELD tp2          AS CHAR FORMAT "X(20)"  INIT ""   
    FIELD tp3          AS CHAR FORMAT "X(20)"  INIT ""
    FIELD covcod       AS CHAR FORMAT "X(5)"   INIT ""  
    FIELD producer     AS CHAR FORMAT "X(10)"  INIT ""     
    FIELD agent2       AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD branch       AS CHAR FORMAT "X(2)"   INIT ""
    FIELD new_re       AS CHAR FORMAT "x(20)"  INIT ""
    FIELD Redbook      AS CHAR FORMAT "X(10)"   INIT ""
    FIELD comp_comdat   AS CHAR FORMAT "X(8)"  INIT ""     /*Effective Date Accidential*/           
    FIELD comp_expdat   AS CHAR FORMAT "X(8)"  INIT ""     /*Expiry Date Accidential*/              
    FIELD fi            AS CHAR FORMAT "X(11)" INIT ""     /*Coverage Amount Theft*/                
    FIELD class         AS CHAR FORMAT "X(3)"  INIT ""     /*Car code*/                             
    FIELD usedtype      AS CHAR FORMAT "x(1)"  INIT ""     /*Per Used*/                             
    FIELD driveno1      AS CHAR FORMAT "x(2)"  INIT ""     /*Driver Seq1*/                          
    FIELD drivename1    AS CHAR FORMAT "x(120)" INIT ""     /*Driver Name1*/                         
    /*FIELD bdatedriv1    AS CHAR FORMAT "x(8)"  INIT "" */    /*Birthdate Driver1*/                    
    /*FIELD occupdriv1    AS CHAR FORMAT "x(75)" INIT "" */    /*Occupation Driver1*/                   
    /*FIELD positdriv1    AS CHAR FORMAT "X(40)" INIT "" */    /*Position Driver1 */                    
    FIELD driveno2      AS CHAR FORMAT "x(2)"  INIT ""     /*Driver Seq2*/                          
    FIELD drivename2    AS CHAR FORMAT "x(120)" INIT ""     /*Driver Name2*/                         
    /*FIELD bdatedriv2    AS CHAR FORMAT "x(8)"  INIT "" */    /*Birthdate Driver2*/                    
    /*FIELD occupdriv2    AS CHAR FORMAT "x(75)" INIT "" */    /*Occupation Driver2*/                   
    /*FIELD positdriv2    AS CHAR FORMAT "X(40)" INIT "" */    /*Position Driver2*/                     
    /*FIELD driveno3      AS CHAR FORMAT "x(2)"  INIT "" */    /*Driver Seq3*/                          
    /*FIELD drivename3    AS CHAR FORMAT "x(40)" INIT "" */    /*Driver Name3*/                         
    /*FIELD bdatedriv3    AS CHAR FORMAT "x(8)"  INIT "" */    /*Birthdate Driver3*/                    
    /*FIELD occupdriv3    AS CHAR FORMAT "x(75)" INIT "" */    /*Occupation Driver3*/                   
    /*FIELD positdriv3    AS CHAR FORMAT "X(40)" INIT "" */   /*Position Driver3*/        
    field pd1           as CHAR FORMAT "X(20)" init ""
    field pd2           as CHAR FORMAT "X(20)" init ""
    field pd3           as CHAR FORMAT "X(20)" init ""
    field dspc          as CHAR FORMAT "X(20)" init ""
    field remark1       as CHAR FORMAT "X(100)" init "" 
    field remark2       as CHAR FORMAT "X(100)" init "" 
    field remark3       as CHAR FORMAT "X(100)" init "" 
    field polno         as char format "x(15)" init ""
    field temppol       as char format "x(15)" init ""
    field si            as char format "x(15)" init ""
    field deduct2       as char format "x(15)" init ""
    field compol        as char format "x(15)" init ""
    FIELD icno          AS CHAR FORMAT "x(15)" INIT "" . /*A60-0272*/
DEF  STREAM nfile.  
DEF VAR nv_accdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_comdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_expdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
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
DEF VAR nv_72comdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.      /*- A59-0178-*/
DEF VAR nv_72expdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.      /*- A59-0178-*/

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
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt tlt.filler1 ~
IF (tlt.flag = "R") THEN ("RENEW") ELSE ("NEW") tlt.ins_name tlt.nor_grprm ~
tlt.comp_grprm tlt.lince1 tlt.cha_no tlt.expodat 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt 
&Scoped-define QUERY-STRING-br_imptxt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY br_imptxt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_imptxt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_compa fi_filename bu_ok ~
br_imptxt bu_exit bu_file RECT-1 RECT-380 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_compa fi_filename fi_impcnt ~
fi_completecnt fi_dir_cnt fi_dri_complet 

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
     LABEL "OK" 
     SIZE 8.5 BY 1
     FONT 6.

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

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.81
     BGCOLOR 1 FGCOLOR 2 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130 BY 5.52
     BGCOLOR 21 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_imptxt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _STRUCTURED
  QUERY br_imptxt NO-LOCK DISPLAY
      tlt.filler1 COLUMN-LABEL "์กรมธรรม์เดิม" FORMAT "x(15)":U
      IF (tlt.flag = "R") THEN ("RENEW") ELSE ("NEW") COLUMN-LABEL "ประเภทงาน" FORMAT "X(10)":U
            WIDTH 9.33
      tlt.ins_name FORMAT "x(50)":U WIDTH 29.83
      tlt.nor_grprm COLUMN-LABEL "เบี้ย กธ." FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.83
      tlt.comp_grprm COLUMN-LABEL "เบี้ย พรบ." FORMAT "->>,>>>,>>9.99":U
            WIDTH 11.83
      tlt.lince1 COLUMN-LABEL "ป้ายทะเบียน" FORMAT "x(12)":U WIDTH 13.33
      tlt.cha_no FORMAT "x(25)":U WIDTH 17.83
      tlt.expodat FORMAT "99/99/99":U WIDTH 14.33
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128.17 BY 17.57
         BGCOLOR 19  ROW-HEIGHT-CHARS .81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 1.81 COL 38 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.81 COL 72 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 2.95 COL 38 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 4.67 COL 99.83
     br_imptxt AT ROW 6.95 COL 3.33
     bu_exit AT ROW 4.67 COL 110.5
     bu_file AT ROW 3 COL 116.33
     fi_impcnt AT ROW 4.1 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 4.1 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_dir_cnt AT ROW 5.19 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_dri_complet AT ROW 5.19 COL 75.17 COLON-ALIGNED NO-LABEL
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 4.1 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 4.1 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "           กรุณาป้อนชื่อไฟล์นำเข้า :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 2.95 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " ข้อมูลแจ้งประกันนำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 4.1 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                   วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.81 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "        ข้อมูลผู้ขับขี่นำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 5.19 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 5.19 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 5.19 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 5.19 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.81 COL 57.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 4.1 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1 COL 1.5
     RECT-380 AT ROW 1.19 COL 2.33
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
         TITLE              = "Hold data Text file Lockton (งานต่ออายุ)"
         HEIGHT             = 24
         WIDTH              = 133
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
/* BROWSE-TAB br_imptxt bu_ok fr_main */
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
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.tlt.filler1
"tlt.filler1" "์กรมธรรม์เดิม" "x(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > "_<CALC>"
"IF (tlt.flag = ""R"") THEN (""RENEW"") ELSE (""NEW"")" "ประเภทงาน" "X(10)" ? ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.ins_name
"tlt.ins_name" ? ? "character" ? ? ? ? ? ? no ? no no "29.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.nor_grprm
"tlt.nor_grprm" "เบี้ย กธ." ? "decimal" ? ? ? ? ? ? no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" "เบี้ย พรบ." ? "decimal" ? ? ? ? ? ? no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.lince1
"tlt.lince1" "ป้ายทะเบียน" "x(12)" "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.cha_no
"tlt.cha_no" ? "x(25)" "character" ? ? ? ? ? ? no ? no no "17.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.expodat
"tlt.expodat" ? ? "date" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Hold data Text file Lockton (งานต่ออายุ) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Hold data Text file Lockton (งานต่ออายุ) */
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
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN 
        nv_daily   =  ""
        nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    Run  Import_notification.    /*ไฟล์แจ้งงาน กรมธรรม์*/
    
    RELEASE brstat.tlt.
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
  
  gv_prgid = "wgwloctn".
  gv_prog  = "Import Data notify in TLT (Lockton) ".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */
  Hide Frame  fr_gen  .
  ASSIGN  
      fi_loaddat  =  today
      fi_compa    = "LOCKTON"
      /*fi_producer = "B3W0020"
      fi_agent    = "B3W0020"*/ .
  disp  fi_loaddat  /*fi_producer fi_agent*/ fi_compa  with  frame  fr_main.
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Create_tlt C-Win 
PROCEDURE Create_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
LOOP_wdetail:
FOR EACH wdetail .
    ASSIGN   
        nv_policy  = ""     nv_oldpol  = ""
        nv_comdat  = ?      nv_expdat  = ?   nv_accdat  =  ?      
        nv_comchr  = ""     nv_addr    = ""  nv_name1   =  ""
        nv_ntitle  = ""     nv_titleno = 0   nv_policy  =  ""
        nv_dd      = 0      nv_mm      = 0   nv_yy      =  0
        nv_cpamt1  = 0      nv_cpamt2  = 0   nv_cpamt3  =  0
        nv_coamt1  = 0      nv_coamt2  = 0   nv_coamt3  =  0         
        nv_insamt1 = 0      nv_insamt2 = 0   nv_insamt3 =  0
        nv_premt1  = 0      nv_premt2  = 0   nv_premt3  =  0
        nv_ncb1    = 0      nv_ncb2    = 0   nv_ncb3    =  0
        nv_fleet1  = 0      nv_fleet2  = 0   nv_fleet3  =  0
        nv_oth1    = 0      nv_oth2    = 0   nv_oth3    =  0
        nv_deduct1 = 0      nv_deduct2 = 0   nv_deduct3 =  0
        nv_power1  = 0      nv_power2  = 0   nv_power3  =  0
        nv_newpol  = ""     nv_72comdat  = ?   nv_72expdat  =  ?        /*-A59-0178-*/

        nv_reccnt  = nv_reccnt + 1
        wdetail.engine = REPLACE(wdetail.engine,"*","").
    IF ( wdetail.Notify_no = "" ) THEN 
        MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
    ELSE DO:
        /* ------------------------check policy  Duplicate--------------------------------------*/ 
        IF wdetail.prev_pol <> "" THEN RUN pol_cutchar.
        nv_oldpol  =  wdetail.prev_pol.
        nv_policy  =  nv_oldpol.         
       IF (wdetail.not_date  <> "" ) AND (wdetail.not_date <> "00000000") THEN  
            ASSIGN           
            nv_notdat  = DATE(wdetail.not_date).                       
        IF (wdetail.comdat <>  "" ) AND ( wdetail.comdat <> "00000000" )   THEN 
            ASSIGN 
            nv_yy = INT(SUBSTR(string(date(wdetail.comdat)),7,4))
            nv_yy = nv_yy - 543
            nv_mm = INT(SUBSTR(string(date(wdetail.comdat)),4,2)) 
            nv_dd = INT(SUBSTR(string(date(wdetail.comdat)),1,2)) 
            nv_comdat  = DATE(nv_mm,nv_dd,nv_yy).

        IF (wdetail.expdat <>  "" ) AND  (wdetail.expdat   <> "00000000")  THEN 
            ASSIGN
            nv_yy = INT(SUBSTR(string(date(wdetail.expdat)),7,4))
            nv_yy = nv_yy - 543
            nv_mm = INT(SUBSTR(string(date(wdetail.expdat)),4,2)) 
            nv_dd = INT(SUBSTR(string(date(wdetail.expdat)),1,2)) 
            nv_expdat  = DATE(nv_mm,nv_dd,nv_yy).
           
        IF (wdetail.comp_expdat <>  "" ) AND  (wdetail.comp_expdat   <> "00000000")  THEN 
            ASSIGN
            nv_yy = INT(SUBSTR(string(date(wdetail.comp_expdat)),7,4))
            nv_yy = nv_yy - 543
            nv_mm = INT(SUBSTR(string(date(wdetail.comp_expdat)),4,2)) 
            nv_dd = INT(SUBSTR(string(date(wdetail.comp_expdat)),1,2))
            nv_72expdat  = DATE(nv_mm,nv_dd,nv_yy).

        IF (wdetail.comp_comdat <>  "" ) AND  (wdetail.comp_comdat   <> "00000000")  THEN 
            ASSIGN
            nv_yy = INT(SUBSTR(string(date(wdetail.comp_comdat)),7,4))
            nv_yy = nv_yy - 543
            nv_mm = INT(SUBSTR(string(date(wdetail.comp_comdat)),4,2)) 
            nv_dd = INT(SUBSTR(string(date(wdetail.comp_comdat)),1,2))
            nv_72comdat  = DATE(nv_mm,nv_dd,nv_yy).

       /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- */
        nv_insamt3 = DECIMAL(wdetail.ins_amt).   /* by: kridtiya i. A54-0061.. */
        /* -------------------------- PREM1 CHR(11)   เบี้ยภาคสมัครใจบวกภาษีบวกอากร --- */
        nv_premt3 = DECIMAL(wdetail.prem1).
        /* --------------------------------------------- COMP_PEM CHR(09)  เบี้ยพรบ.รวม --- */
        nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  /*add kridtiya i. A54-0061..*/
        /* -------------------------- GROSS_PRM CHR(11)   เบี้ยรวมภาคสมัครใจบวกเบี้ยรวม พรบ. --- */
        nv_coamt3 = DECIMAL(wdetail.gross_prm).
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
        /*Message "ncb"   wdetail.ncbper   nv_ncb3.*/
        /* ----------------------OTH_DISC. ส่วนลดอื่น ๆ  / เปอร์เซ็นต์ --- */
        nv_oth1 = DECIMAL(SUBSTRING(wdetail.othper,1,3)).
        IF nv_oth1 < 0 THEN
            nv_oth2 = (DECIMAL(SUBSTRING(wdetail.othper,4,2)) * -1) / 100.
        ELSE
            nv_oth2 = DECIMAL(SUBSTRING(wdetail.othper,4,2)) / 100.
        nv_oth3 = nv_oth1 + nv_oth2.
        /*Message "oth_dis"  wdetail.othper  nv_oth3.*/
        /* ----------------------Deduct  ความเสียหายส่วนแรก  --------------- */
        nv_deduct1 = DECIMAL(SUBSTRING(wdetail.othper,1,7)).
        IF nv_deduct1 < 0 THEN
            nv_deduct2 = (DECIMAL(SUBSTRING(wdetail.deduct,8,2)) * -1) / 100.
        ELSE
            nv_deduct2 = DECIMAL(SUBSTRING(wdetail.deduct,8,2)) / 100.
        nv_deduct3 = nv_deduct1 + nv_deduct2.         
        /* ----------------Power  กำลังเครื่องยนต์------------------------ */
        nv_power1 = DECIMAL(SUBSTRING(wdetail.power,1,5)).
        IF nv_power1 < 0 THEN
            nv_power2 = (DECIMAL(SUBSTRING(wdetail.power,6,2)) * -1) / 100.
        ELSE
            nv_power2 = DECIMAL(SUBSTRING(wdetail.power,6,2)) / 100.
        nv_power3 = nv_power1 + nv_power2.  
        
       IF wdetail.pol_addr <> ""  THEN DO:
           IF INDEX(wdetail.pol_addr,"อ.") <> 0 THEN
            ASSIGN  wdetail.pol_addr1 = SUBSTR(wdetail.pol_addr,1,INDEX(wdetail.pol_addr,"อ.") - 2)
                    wdetail.pol_addr2 = SUBSTR(wdetail.pol_addr,INDEX(wdetail.pol_addr,"อ."),LENGTH(wdetail.pol_addr)).
           ELSE IF INDEX(wdetail.pol_addr,"อำเภอ") <> 0 THEN
            ASSIGN  wdetail.pol_addr1 = SUBSTR(wdetail.pol_addr,1,INDEX(wdetail.pol_addr,"อำเภอ") - 2)
                    wdetail.pol_addr2 = SUBSTR(wdetail.pol_addr,INDEX(wdetail.pol_addr,"อำเภอ"),LENGTH(wdetail.pol_addr)).
           ELSE IF INDEX(wdetail.pol_addr,"เขต") <> 0 THEN
            ASSIGN  wdetail.pol_addr1 = SUBSTR(wdetail.pol_addr,1,INDEX(wdetail.pol_addr,"เขต") - 1)
                    wdetail.pol_addr2 = SUBSTR(wdetail.pol_addr,INDEX(wdetail.pol_addr,"เขต"),LENGTH(wdetail.pol_addr)).
           /* start : A60-0272 */
           ELSE IF INDEX(wdetail.pol_addr,"แขวง") <> 0 THEN
            ASSIGN  wdetail.pol_addr1 = SUBSTR(wdetail.pol_addr,1,INDEX(wdetail.pol_addr,"แขวง") - 2)
                    wdetail.pol_addr2 = SUBSTR(wdetail.pol_addr,INDEX(wdetail.pol_addr,"แขวง"),LENGTH(wdetail.pol_addr)).
           ELSE ASSIGN wdetail.pol_addr1 = SUBSTR(wdetail.pol_addr,1,50)                     
                       wdetail.pol_addr2 = SUBSTR(wdetail.pol_addr,51,LENGTH(wdetail.pol_addr)).  
           /* end : A60-0272 */
       END.
       IF wdetail.pol_fname <> "" THEN DO:
           IF INDEX(wdetail.pol_fname,"คุณ") <> 0 THEN
               ASSIGN wdetail.pol_title = "คุณ"
                      wdetail.pol_fname = REPLACE(wdetail.pol_fname,"คุณ","").
           ELSE IF INDEX(wdetail.pol_fname,"นาย") <> 0 THEN
               ASSIGN wdetail.pol_title = "นาย"
                      wdetail.pol_fname = REPLACE(wdetail.pol_fname,"นาย",""). 
           ELSE IF INDEX(wdetail.pol_fname,"นาง") <> 0 THEN
               ASSIGN wdetail.pol_title = "นาง"
                      wdetail.pol_fname = REPLACE(wdetail.pol_fname,"นาง","").
           ELSE IF INDEX(wdetail.pol_fname,"นางสาว") <> 0 THEN
               ASSIGN wdetail.pol_title = "นางสาว"
                      wdetail.pol_fname = REPLACE(wdetail.pol_fname,"นางสาว","").
           ELSE IF INDEX(wdetail.pol_fname,"น.ส.") <> 0 THEN
               ASSIGN wdetail.pol_title = "น.ส."
                      wdetail.pol_fname = REPLACE(wdetail.pol_fname,"น.ส.","").
           ELSE IF INDEX(wdetail.pol_fname,"บริษัท") <> 0 THEN
               ASSIGN wdetail.pol_title = "บริษัท"
                      wdetail.pol_fname = REPLACE(wdetail.pol_fname,"บริษัท","").
           ELSE IF INDEX(wdetail.pol_fname,"บจก.") <> 0 THEN
               ASSIGN wdetail.pol_title = "บจก."
                      wdetail.pol_fname = REPLACE(wdetail.pol_fname,"บจก.","").
           ELSE IF INDEX(wdetail.pol_fname,"หจก.") <> 0 THEN
               ASSIGN wdetail.pol_title = "หจก."
                      wdetail.pol_fname = REPLACE(wdetail.pol_fname,"หจก.","").
           ELSE IF INDEX(wdetail.pol_fname,"ห้างหุ้นส่วน.") <> 0 THEN
               ASSIGN wdetail.pol_title = "ห้างหุ้นส่วน"
                      wdetail.pol_fname = REPLACE(wdetail.pol_fname,"ห้างหุ้นส่วน","").
       END.
       /* A60-0272 */
       ASSIGN wdetail.pd1 = string(int(wdetail.pd1))
              wdetail.pd2 = string(int(wdetail.pd2))
              wdetail.pd3 = string(int(wdetail.pd3)).
       IF wdetail.pd1 <> "" THEN IF LENGTH(wdetail.pd1) < 6 THEN wdetail.pd1 = TRIM(wdetail.pd1) + ".00". ELSE wdetail.pd1 = TRIM(wdetail.pd1).
       if wdetail.pd2 <> "" then if length(wdetail.pd2) < 6 THEN wdetail.pd2 = TRIM(wdetail.pd2) + ".00". ELSE wdetail.pd2 = TRIM(wdetail.pd2). 
       if wdetail.pd3 <> "" then if length(wdetail.pd3) < 6 THEN wdetail.pd3 = TRIM(wdetail.pd3) + ".00". ELSE wdetail.pd3 = TRIM(wdetail.pd3).
       /* end : A60-0272 */
       FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
            brstat.tlt.cha_no    = trim(wdetail.chassis)  AND
            brstat.tlt.eng_no    = TRIM(wdetail.engine)   AND  
            brstat.tlt.genusr    = fi_compa               NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.tlt THEN DO: 
           /* IF nv_comdat <> ? THEN DO:*/
                CREATE brstat.tlt.
                nv_completecnt  =  nv_completecnt + 1.
                ASSIGN                                                 
                   brstat.tlt.entdat        = TODAY                           /* date  99/99/9999  */
                   brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
                   brstat.tlt.trndat        = fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */    /*date   99/99/9999*/
                   brstat.tlt.trntime       = STRING(TIME,"HH:MM:SS")         /* char   x(8)       */
                   brstat.tlt.nor_noti_tlt  = trim(wdetail.notify_no)                                           /*RefNo           */                        
                   brstat.tlt.datesent      = nv_notdat                                                         /*ClosingDate     */ 
                   brstat.tlt.rec_name      = TRIM(wdetail.pol_title)                                           /*ClientName      */ 
                   brstat.tlt.ins_name      = TRIM(wdetail.pol_fname)                                           /*ClientName      */
                   brstat.tlt.safe3         = trim(wdetail.client_no)                                           /*ClientCode      */ 
                   brstat.tlt.ins_addr1     = trim(wdetail.pol_addr1)                                           /*ClientAddress   */
                   brstat.tlt.ins_addr2     = trim(wdetail.pol_addr2)                                           /*ClientAddress   */
                   brstat.tlt.brand         = SUBSTR(trim(wdetail.brand),1,INDEX(wdetail.brand,"/") - 1 )       /*Brand/Model     */
                   brstat.tlt.model         = SUBSTR(TRIM(wdetail.brand),INDEX(wdetail.brand,"/") + 1)          /*Brand/Model     */
                   brstat.tlt.lince1        = trim(wdetail.licence)                                             /*CarID           */ 
                   brstat.tlt.lince2        = trim(wdetail.yrmanu)                                              /*RegisterYear    */ 
                   brstat.tlt.cha_no        = TRIM(wdetail.chassis)                                             /*ChassisNo       */ 
                   brstat.tlt.eng_no        = trim(wdetail.engine)                                              /*EngineNo        */ 
                   brstat.tlt.cc_weight     = DECI(wdetail.power)                                                /*CC              */ 
                   brstat.tlt.safe1         = trim(wdetail.ben_name)                                            /*Beneficiary     */ 
                   brstat.tlt.filler1       = nv_oldpol                                                         /*OldPolicyNo     */ 
                   brstat.tlt.comp_sck      = trim(wdetail.sckno)                                              /*CMIStickerNo    */ 
                   brstat.tlt.rec_addr5     = TRIM(wdetail.compol)                                             /*CMIPolicyNo     */ 
                   brstat.tlt.stat          = trim(wdetail.garage)                                              /*Garage          */ 
                   brstat.tlt.expousr       = trim(wdetail.covcod)                                              /*InsureType      */ 
                   brstat.tlt.dri_name1     = trim(wdetail.drivename1)                                          /*Driver1         */ 
                   brstat.tlt.dri_name2     = TRIM(wdetail.drivename2)                                          /*Driver2         */ 
                   brstat.tlt.gendat        = nv_comdat                                                         /*VMIStartDate    */
                   brstat.tlt.expodat       = nv_expdat                                                         /*VMIEndDate      */
                   brstat.tlt.nor_effdat    = nv_72comdat                                                      /*CMIStartDate    */
                   brstat.tlt.comp_effdat   = nv_72expdat                                                      /*CMIEndDate      */
                   brstat.tlt.nor_coamt     = nv_insamt3                                                        /*SumInsured      */
                   brstat.tlt.nor_grprm     = nv_premt3                                                         /*VMITotalPremium */
                   brstat.tlt.comp_grprm    = nv_cpamt3                                                         /*CMITotalPremium */
                   brstat.tlt.comp_coamt    = nv_coamt3                                                         /*TotalPremium    */
                   brstat.tlt.endno         = string(DECI(wdetail.deduct))                                      /*FirstOD         */
                   brstat.tlt.lince3        = TRIM(wdetail.deduct2)                                             /*FirstTPPD       */
                   brstat.tlt.old_eng       = trim(wdetail.tp1)                                                 /*TPBIPerson      */
                   brstat.tlt.old_cha       = trim(wdetail.tp2)                                                 /*TPBITime        */
                   brstat.tlt.comp_pol      = trim(wdetail.tp3)                                                 /*TPPD            */
                   brstat.tlt.nor_usr_tlt   = string(deci(wdetail.si))                                          /*OD              */
                   brstat.tlt.rec_addr1     = TRIM(wdetail.fi)                                                  /*FT              */
                   brstat.tlt.comp_usr_tlt  = "PD1:"  + trim(wdetail.pd1)  +                                    /*RY01            */
                                              "PD2:"  + trim(wdetail.pd2)  +                                    /*RY02            */
                                              "PD3:"  + trim(wdetail.pd3)                                       /*RY03            */
                   brstat.tlt.rec_addr4     = STRING(DECI(wdetail.dspc))                                        /*DiscountGroup   */
                   brstat.tlt.lotno         = String(nv_fleet3)                                                 /*DiscountHistory */
                   brstat.tlt.endcnt        = nv_oth3                                                           /*DiscountOther   */
                   brstat.tlt.sentcnt       = int(trim(wdetail.seatenew))                                       /*Seat            */
                   brstat.tlt.filler2       = trim(wdetail.remark1) +                                                        /*RemarkInsurer1  */ 
                                             (IF trim(wdetail.remark2) <> "" THEN " r2:" + trim(wdetail.remark2) ELSE "" ) + /*RemarkInsurer2  */  
                                             (IF trim(wdetail.remark3) <> "" THEN " r3:" + trim(wdetail.remark3) ELSE "" )   /*RemarkInsurer3  */ 
                   brstat.tlt.safe2         = trim(wdetail.account_no)                                         /*ContractNo      */                                      
                   brstat.tlt.nor_usr_ins   = trim(wdetail.name_insur)                                         /*UserClosing     */  
                   brstat.tlt.policy        = TRIM(wdetail.polno)                                              /*PolicyNo        */                       
                   brstat.tlt.rec_addr3     = TRIM(wdetail.temppol)                                            /*TempPolicyNo    */ 
                   brstat.tlt.colorcod      = trim(wdetail.camp)                                               /*Campaign        */ 
                   brstat.tlt.subins        = TRIM(wdetail.icno)       /*A60-0272*/                               /*icno */
                   brstat.tlt.flag          = "R"                                                              /* งานต่ออายุ */
                   brstat.tlt.exp           = caps(trim(wdetail.branch))
                   brstat.tlt.genusr        = "LOCKTON"                                                    
                   brstat.tlt.usrid         = USERID(LDBNAME(1))       
                   brstat.tlt.imp           = "IM"                     
                   brstat.tlt.releas        = "No"  
                   brstat.tlt.recac         = ""
                   brstat.tlt.dri_no1       = ""
                   brstat.tlt.dri_no2       = ""
                   brstat.tlt.dat_ins_noti  = ?
                   brstat.tlt.comp_sub      = IF trim(wdetail.garage) = "G2" THEN "B3W0020" ELSE "B3W0016"     /*producer code*/
                   brstat.tlt.comp_noti_ins = IF trim(wdetail.garage) = "G2" THEN "B3W0020" ELSE "B3W0016" .   /*Agent code*/
       END.
       ELSE DO:
           RUN Create_tlt2.
       END.
    END.  /*wdetail.Notify_no <> "" */
END.   /* FOR EACH wdetail NO-LOCK: */
Run Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Create_tlt2 C-Win 
PROCEDURE Create_tlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_completecnt  =  nv_completecnt + 1.
ASSIGN                                                 
         brstat.tlt.entdat        = TODAY                          /* date  99/99/9999  */
         brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")        /* char  x(8)        */
         brstat.tlt.trndat        = fi_loaddat                     /* วันที่ไฟล์แจ้งงาน */    /*date   99/99/9999*/
         brstat.tlt.trntime       = STRING(TIME,"HH:MM:SS")        /* char   x(8)       */
         brstat.tlt.nor_noti_tlt  = trim(wdetail.notify_no)                                           /*RefNo           */                        
         brstat.tlt.datesent      = nv_notdat                                                     /*ClosingDate     */ 
         brstat.tlt.rec_name      = TRIM(wdetail.pol_title)                                           /*ClientName      */ 
         brstat.tlt.ins_name      = TRIM(wdetail.pol_fname)                                           /*ClientName      */
         brstat.tlt.safe3         = trim(wdetail.client_no)                                           /*ClientCode      */ 
         brstat.tlt.ins_addr1     = trim(wdetail.pol_addr1)                                           /*ClientAddress   */
         brstat.tlt.ins_addr2     = trim(wdetail.pol_addr2)                                           /*ClientAddress   */
         brstat.tlt.brand         = SUBSTR(trim(wdetail.brand),1,INDEX(wdetail.brand,"/") - 1 )       /*Brand/Model     */
         brstat.tlt.model         = SUBSTR(TRIM(wdetail.brand),INDEX(wdetail.brand,"/") + 1)          /*Brand/Model     */
         brstat.tlt.lince1        = trim(wdetail.licence)                                             /*CarID           */ 
         brstat.tlt.lince2        = trim(wdetail.yrmanu)                                              /*RegisterYear    */ 
         brstat.tlt.cha_no        = TRIM(wdetail.chassis)                                             /*ChassisNo       */ 
         brstat.tlt.eng_no        = trim(wdetail.engine)                                              /*EngineNo        */ 
         brstat.tlt.cc_weight     = INT(wdetail.power)                                                /*CC              */ 
         brstat.tlt.safe1         = trim(wdetail.ben_name)                                            /*Beneficiary     */ 
         brstat.tlt.filler1       = nv_oldpol                                                         /*OldPolicyNo     */ 
         brstat.tlt.comp_sck      = trim(wdetail.sckno)                                               /*CMIStickerNo    */ 
         brstat.tlt.rec_addr5     = TRIM(wdetail.compol)                                              /*CMIPolicyNo     */ 
         brstat.tlt.stat          = trim(wdetail.garage)                                              /*Garage          */ 
         brstat.tlt.expousr       = trim(wdetail.covcod)                                              /*InsureType      */ 
         brstat.tlt.dri_name1     = trim(wdetail.drivename1)                                          /*Driver1         */ 
         brstat.tlt.dri_name2     = TRIM(wdetail.drivename2)                                          /*Driver2         */ 
         brstat.tlt.gendat        = nv_comdat                                                       /*VMIStartDate    */
         brstat.tlt.expodat       = nv_expdat                                                         /*VMIEndDate      */
         brstat.tlt.nor_effdat    = nv_72comdat                                                       /*CMIStartDate    */
         brstat.tlt.comp_effdat   = nv_72expdat                                                       /*CMIEndDate      */
         brstat.tlt.nor_coamt     = nv_insamt3                                                        /*SumInsured      */
         brstat.tlt.nor_grprm     = nv_premt3                                                         /*VMITotalPremium */
         brstat.tlt.comp_grprm    = nv_cpamt3                                                       /*CMITotalPremium */
         brstat.tlt.comp_coamt    = nv_coamt3                                                         /*TotalPremium    */
         brstat.tlt.endno         = string(DECI(wdetail.deduct))                                      /*FirstOD         */
         brstat.tlt.lince3        = TRIM(wdetail.deduct2)                                             /*FirstTPPD       */
         brstat.tlt.old_eng       = trim(wdetail.tp1)                                                 /*TPBIPerson      */
         brstat.tlt.old_cha       = trim(wdetail.tp2)                                                 /*TPBITime        */
         brstat.tlt.comp_pol      = trim(wdetail.tp3)                                                 /*TPPD            */
         brstat.tlt.nor_usr_tlt   = string(deci(wdetail.si))                                          /*OD              */
         brstat.tlt.rec_addr1     = TRIM(wdetail.fi)                                                  /*FT              */
         brstat.tlt.comp_usr_tlt  = "PD1:"  + trim(wdetail.pd1)  +                                    /*RY01            */
                                    "PD2:"  + trim(wdetail.pd2)  +                                    /*RY02            */
                                    "PD3:"  + trim(wdetail.pd3)                                       /*RY03            */
         brstat.tlt.rec_addr4     = STRING(DECI(wdetail.dspc))                                        /*DiscountGroup   */
         brstat.tlt.lotno         = String(nv_fleet3)                                                 /*DiscountHistory */
         brstat.tlt.endcnt        = nv_oth3                                                           /*DiscountOther   */
         brstat.tlt.sentcnt       = int(trim(wdetail.seatenew))                                       /*Seat            */
         brstat.tlt.filler2       = trim(wdetail.remark1) +                                                        /*RemarkInsurer1  */ 
                                   (IF trim(wdetail.remark2) <> "" THEN " r2:" + trim(wdetail.remark2) ELSE "" ) + /*RemarkInsurer2  */  
                                   (IF trim(wdetail.remark3) <> "" THEN " r3:" + trim(wdetail.remark3) ELSE "" )   /*RemarkInsurer3  */ 
         brstat.tlt.safe2         = trim(wdetail.account_no)                                         /*ContractNo      */                                      
         brstat.tlt.nor_usr_ins   = trim(wdetail.name_insur)                                         /*UserClosing     */  
         brstat.tlt.policy        = TRIM(wdetail.polno)                                              /*PolicyNo        */                       
         brstat.tlt.rec_addr3     = TRIM(wdetail.temppol)                                            /*TempPolicyNo    */ 
         brstat.tlt.colorcod      = trim(wdetail.camp)                                               /*Campaign        */ 
         brstat.tlt.subins        = TRIM(wdetail.icno)  /*A60-0272*/                                               /*icno*/
         brstat.tlt.flag          = "R"                                                              /* งานต่ออายุ */
         brstat.tlt.exp           = caps(trim(wdetail.branch))
         brstat.tlt.genusr        = "LOCKTON"                                                    
         brstat.tlt.usrid         = USERID(LDBNAME(1))       
         brstat.tlt.imp           = "IM"                     
         brstat.tlt.releas        = "No"  
         brstat.tlt.recac         = ""
         brstat.tlt.dri_no1       = ""
         brstat.tlt.dri_no2       = ""
         brstat.tlt.dat_ins_noti  = ?
         brstat.tlt.comp_sub      = IF trim(wdetail.garage) = "G2" THEN "B3W0020" ELSE "B3W0016"     /*producer code*/
         brstat.tlt.comp_noti_ins = IF trim(wdetail.garage) = "G2" THEN "B3W0020" ELSE "B3W0016" .   /*Agent code*/
        
 /*----- end : A60-0095 -----------*/ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
          fi_dri_complet 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loaddat fi_compa fi_filename bu_ok br_imptxt bu_exit bu_file RECT-1 
         RECT-380 
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
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"
        wdetail.RecordID        
        wdetail.Notify_no       
        wdetail.not_date        
        wdetail.pol_fname       
        wdetail.client_no       
        wdetail.pol_addr   
        wdetail.brand           
        wdetail.licence         
        wdetail.yrmanu          
        wdetail.chassis         
        wdetail.engine          
        wdetail.power           
        wdetail.ben_name        
        wdetail.prev_pol        
        wdetail.sckno           
        wdetail.compol          
        wdetail.garage          
        wdetail.covcod          
        wdetail.drivename1      
        wdetail.drivename2      
        wdetail.comdat          
        wdetail.expdat          
        wdetail.comp_comdat     
        wdetail.comp_expdat     
        wdetail.ins_amt         
        wdetail.prem1           
        wdetail.comp_prm        
        wdetail.gross_prm       
        wdetail.deduct          
        wdetail.deduct2         
        wdetail.tp1             
        wdetail.tp2             
        wdetail.tp3             
        wdetail.si              
        wdetail.fi              
        wdetail.pd1             
        wdetail.pd2             
        wdetail.pd3             
        wdetail.dspc            
        wdetail.fleetper        
        wdetail.othper          
        wdetail.seatenew        
        wdetail.remark1         
        wdetail.remark2         
        wdetail.remark3         
        wdetail.Account_no      
        wdetail.name_insur      
        wdetail.polno           
        wdetail.temppol         
        wdetail.camp
        wdetail.icno. /*A60-0272*/
END.  
FOR EACH wdetail .
    IF      INDEX(wdetail.RecordID,"Clos")    <> 0 THEN  DELETE wdetail.
    ELSE IF INDEX(wdetail.RecordID,"No")      <> 0 THEN  DELETE wdetail.
    ELSE IF INDEX(wdetail.RecordID,"บริษัท")  <> 0 THEN  DELETE wdetail.
    ELSE IF INDEX(wdetail.RecordID,"Grand")   <> 0 THEN  DELETE wdetail.
    ELSE IF  wdetail.RecordID    = "" THEN  DELETE wdetail.
END.
    
ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 
RUN CREATE_tlt.
If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.
End. 
fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Complete"  View-as alert-box.  
Run Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Open_tlt C-Win 
PROCEDURE Open_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Open Query br_imptxt  For each tlt  Use-index tlt01  where
           tlt.trndat     =  fi_loaddat   and
           tlt.genusr     =  "LOCKTON"     NO-LOCK .
         

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

nv_p = SUBSTR(nv_c,1,1). 
IF INDEX("1234567890",nv_p) <> 0 THEN
    ASSIGN wdetail.branch = SUBSTR(nv_c,1,2).
ELSE 
    ASSIGN wdetail.branch = SUBSTR(nv_c,2,1).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

