&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-wins 
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
/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/*++++++++++++++++++++++++++++++++++++++++++++++
  wgwqlock.w :  Import text file from  lockton to create  new policy   
                         Add in table  tlt  
                         Query & Update flag detail
  Create  by   :  Ranu i. [A60-0139]   On  10/04/2017
  Connect      :  brstat.tlt
+++++++++++++++++++++++++++++++++++++++++++++++*/
/*Modify by : Ranu I. A60-0272 date : 23/06/2017 เพิ่มคอลัมน์ ICNo ในไฟล์รายงาน */
/*Modify by : Ranu I. A61-0142 date : 13/03/2018 แก้ไขข้อมูลช่อง รย. ในรายงาน  */
/*---------------------------------------------------------------------------*/
 Def    var  nv_rectlt    as recid  init  0.
 Def    var  nv_recidtlt  as recid  init  0.
 DEFINE VAR  n_asdat      AS CHAR.
 DEFINE VAR  vAcProc_fil  AS CHAR.
 DEFINE VAR  n_asdat1     AS CHAR.
 DEFINE VAR  vAcProc_fil1 AS CHAR.
 DEF    VAR  nv_72Reciept AS CHAR INIT "" .
 DEFINE stream  ns2.
 DEF VAR nv_row AS INT INIT 0.  
/*------- create by A60-0118------------*/
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
     FIELD ISP          AS CHAR FORMAT "X(50)"  INIT ""   /*17 เลขที่ตรวจสภาพ */
     FIELD comdat       AS CHAR FORMAT "X(08)"  INIT ""   /*18 วันทีเริ่มคุ้มครอง */
     FIELD ins_amt      AS CHAR FORMAT "X(11)"  INIT ""   /*19 ทุนประกัน */
     FIELD name_insur   AS CHAR FORMAT "X(15)"  INIT ""   /*20 ชื่อเจ้าหน้าที่ประกัน */
     FIELD Not_office   AS CHAR FORMAT "X(75)"  INIT ""   /*21 รหัสเจ้าหน้าทีแจ้งประกัน(Tisco)  */
     FIELD Not_date     AS CHAR FORMAT "X(08)"  INIT ""   /*22 วันที่แจ้งประกัน */
     FIELD Not_time     AS CHAR FORMAT "X(06)"  INIT ""   /*23 เวลาที่แจ้งประกัน */
     FIELD Not_code     AS CHAR FORMAT "X(04)"  INIT ""   /*24 รหัสแจ้งงาน เช่น TF01 */
     FIELD Prem1        AS CHAR FORMAT "X(11)"  INIT ""   /*25 เบี้ยประกันรวม(ค่าเบี้ยป.1 + ภาษี + อากร) */
     FIELD comp_prm     AS CHAR FORMAT "X(09)"  INIT ""   /*26 เบี้ยพรบ.รวม */
     FIELD sckno        AS CHAR FORMAT "X(25)"  INIT ""   /*27 เลขท ี Sticker. */
     FIELD brand        AS CHAR FORMAT "X(50)"  INIT ""   /*28 ยี่ห้อรถ */
     FIELD pol_addr1    AS CHAR FORMAT "X(50)"  INIT ""   /*29 ที่อยู่ผู้เอาประกัน1  */
     FIELD pol_addr2    AS CHAR FORMAT "X(60)"  INIT ""   /*30 ที่อยู่ผู้เอาประกัน2 รวมรหัสไปรษณีย์*/
     FIELD pol_title    AS CHAR FORMAT "X(30)"  INIT ""   /*31 คำนำหน้าชื่อผู้เอาประกัน  */
     FIELD pol_fname    AS CHAR FORMAT "X(75)"  INIT ""   /*32 ชื่อผู้เอาประกัน/นิติบุคคล */
     FIELD pol_Lname    AS CHAR FORMAT "X(45)"  INIT ""   /*33 นามสกุลผู้เอาประกัน  */
     FIELD Ben_name     AS CHAR FORMAT "X(65)"  INIT ""   /*34 ชื่อผู้รับประโยชน์  */
     FIELD Remark       AS CHAR FORMAT "X(150)" INIT ""   /*35 หมายเหตุ  */
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
     FIELD addr1_70     AS CHAR FORMAT "X(50)"  INIT ""  
     FIELD seatenew     AS CHAR FORMAT "x(10)"  INIT ""   /*A57-0017*/
     FIELD addr2_70     AS CHAR FORMAT "X(60)"  INIT ""  
     FIELD nsub_dist70  AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD ndirection70 AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD nprovin70    AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD zipcode70    AS CHAR FORMAT "X(5)"   INIT ""  
     FIELD addr1_72     AS CHAR FORMAT "X(50)"  INIT ""  
     FIELD addr2_72     AS CHAR FORMAT "X(60)"  INIT ""  
     FIELD nsub_dist72  AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD ndirection72 AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD nprovin72    AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD zipcode72    AS CHAR FORMAT "X(5)"   INIT ""  
     FIELD apptyp       AS CHAR FORMAT "X(10)"  INIT ""  
     FIELD appcode      AS CHAR FORMAT "X(2)"   INIT ""  
     FIELD nBLANK       AS CHAR FORMAT "X(9)"   INIT ""   
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
     FIELD Price_Ford   AS CHAR FORMAT "X(20)"   INIT ""
     FIELD Year_fd      AS CHAR FORMAT "X(10)"   INIT ""
     FIELD Brand_Model  AS CHAR FORMAT "X(60)"   INIT ""
     FIELD id_no70      AS CHAR FORMAT "x(13)"  INIT "" 
     FIELD id_nobr70    AS CHAR FORMAT "x(20)"  INIT ""
     FIELD id_no72      AS CHAR FORMAT "x(13)"  INIT ""
     FIELD id_nobr72    AS CHAR FORMAT "x(20)"  INIT ""
     FIELD comp_comdat   AS CHAR FORMAT "X(8)"  INIT ""       
     FIELD comp_expdat   AS CHAR FORMAT "X(8)"  INIT ""       
     FIELD fi            AS CHAR FORMAT "X(11)" INIT ""       
     FIELD class         AS CHAR FORMAT "X(3)"  INIT ""       
     FIELD usedtype      AS CHAR FORMAT "x(1)"  INIT ""       
     FIELD driveno1      AS CHAR FORMAT "x(2)"  INIT ""       
     FIELD drivename1    AS CHAR FORMAT "x(40)" INIT ""       
     FIELD bdatedriv1    AS CHAR FORMAT "x(8)"  INIT ""       
     FIELD occupdriv1    AS CHAR FORMAT "x(75)" INIT ""       
     FIELD positdriv1    AS CHAR FORMAT "X(40)" INIT ""       
     FIELD driveno2      AS CHAR FORMAT "x(2)"  INIT ""       
     FIELD drivename2    AS CHAR FORMAT "x(40)" INIT ""       
     FIELD bdatedriv2    AS CHAR FORMAT "x(8)"  INIT ""       
     FIELD occupdriv2    AS CHAR FORMAT "x(75)" INIT ""       
     FIELD positdriv2    AS CHAR FORMAT "X(40)" INIT ""       
     FIELD driveno3      AS CHAR FORMAT "x(2)"  INIT ""       
     FIELD drivename3    AS CHAR FORMAT "x(40)" INIT ""       
     FIELD bdatedriv3    AS CHAR FORMAT "x(8)"  INIT ""       
     FIELD occupdriv3    AS CHAR FORMAT "x(75)" INIT ""       
     FIELD positdriv3    AS CHAR FORMAT "X(40)" INIT ""
     FIELD receipt72     AS CHAR FORMAT "x(50)" INIT "" . 
 /*----end A60-0118-----------*/
DEF VAR nv_ry1     AS CHAR FORMAT "x(15)"  INIT "".
DEF VAR nv_ry2     AS CHAR FORMAT "x(15)"  INIT "".
DEF VAR nv_ry3     AS CHAR FORMAT "x(15)"  INIT "".
DEF VAR remark1    as char format "x(100)" init "".
DEF VAR remark2    as char format "x(100)" init "".
DEF VAR remark3    as char format "x(100)" init "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_tlt

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_tlt                                        */
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas ~
If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew" Else  " " ~
tlt.exp tlt.filler1 tlt.policy tlt.rec_addr5 tlt.ins_name tlt.nor_grprm ~
tlt.comp_grprm tlt.cha_no tlt.gendat tlt.expodat tlt.comp_sck tlt.nor_coamt ~
tlt.comp_coamt substr(tlt.model,1,50) 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_status fi_trndatfr fi_trndatto bu_ok ~
cb_search bu_oksch br_tlt fi_search bu_update cb_report fi_br fi_outfile ~
bu_report bu_exit bu_upyesno fi_prvpol RECT-332 RECT-333 RECT-338 RECT-339 ~
RECT-341 RECT-381 RECT-382 
&Scoped-Define DISPLAYED-OBJECTS ra_status fi_trndatfr fi_trndatto ~
cb_search fi_search fi_name cb_report fi_br fi_outfile fi_prvpol 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.33 BY .71
     FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 5 BY .95
     FONT 6.

DEFINE BUTTON bu_report 
     LABEL "EXPORT" 
     SIZE 9.83 BY .95
     FONT 6.

DEFINE BUTTON bu_update 
     LABEL "CANCEL" 
     SIZE 14 BY 1.05
     FONT 6.

DEFINE BUTTON bu_upyesno 
     LABEL "YES/NO" 
     SIZE 14 BY 1.05
     FONT 6.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 34.83 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "ชื่อผู้เอาประกัน" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prvpol AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_status AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2,
"Cancel", 3,
"All", 4
     SIZE 32.5 BY 1
     BGCOLOR 14 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 7.62
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-333
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.5 BY 1.52
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 58.5 BY 3
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-339
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 71 BY 2.91
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.33 BY 1.76
     BGCOLOR 6 FGCOLOR 4 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.5 BY 1.52
     BGCOLOR 22 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.17 BY 1.43
     BGCOLOR 22 FGCOLOR 4 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "Cancle/Confirm" FORMAT "x(30)":U
            WIDTH 19.33
      If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew"
Else  " " COLUMN-LABEL "New/Renew" FORMAT "x(8)":U
            WIDTH 11.83 LABEL-FGCOLOR 1 LABEL-FONT 6
      tlt.exp COLUMN-LABEL "BR" FORMAT "XXX":U
      tlt.filler1 COLUMN-LABEL "กรมธรรม์เดิม" FORMAT "x(15)":U
            WIDTH 13.67
      tlt.policy COLUMN-LABEL "กรมธรรม์ใหม่" FORMAT "x(16)":U WIDTH 12.83
      tlt.rec_addr5 COLUMN-LABEL "เบอร์พรบ." FORMAT "x(15)":U WIDTH 13.33
      tlt.ins_name FORMAT "x(50)":U WIDTH 26.33
      tlt.nor_grprm COLUMN-LABEL "เบี้ย กธ." FORMAT ">>,>>>,>>9.99":U
            WIDTH 9.17
      tlt.comp_grprm COLUMN-LABEL "เบี้ย พรบ." FORMAT ">>>,>>9.99":U
            WIDTH 11.33
      tlt.cha_no FORMAT "x(20)":U WIDTH 21.83
      tlt.gendat COLUMN-LABEL "Comdate" FORMAT "99/99/9999":U
      tlt.expodat FORMAT "99/99/9999":U WIDTH 9.5
      tlt.comp_sck FORMAT "x(15)":U WIDTH 14.17
      tlt.nor_coamt FORMAT "->,>>>,>>>,>>9.99":U
      tlt.comp_coamt FORMAT "->>,>>>,>>9.99":U
      substr(tlt.model,1,50) COLUMN-LABEL "Model" FORMAT "X(50)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 14.48
         BGCOLOR 15  ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_status AT ROW 7.91 COL 66 NO-LABEL
     fi_trndatfr AT ROW 3.24 COL 22.67 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 3.24 COL 59.17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 3.33 COL 90.67
     cb_search AT ROW 4.95 COL 16 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 6.29 COL 53
     br_tlt AT ROW 10.33 COL 1.5
     fi_search AT ROW 6.19 COL 2.83 NO-LABEL
     fi_name AT ROW 6.05 COL 60.17 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 6.1 COL 102
     cb_report AT ROW 7.86 COL 13.5 COLON-ALIGNED NO-LABEL
     fi_br AT ROW 9.05 COL 38.17 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 9.1 COL 65.67 NO-LABEL
     bu_report AT ROW 8.71 COL 119.67
     bu_exit AT ROW 3.24 COL 121.83
     bu_upyesno AT ROW 6.1 COL 117.17
     fi_prvpol AT ROW 9.05 COL 13.33 COLON-ALIGNED NO-LABEL
     "Click for update Flag Cancel":40 VIEW-AS TEXT
          SIZE 29.5 BY .95 AT ROW 5 COL 62.5
          BGCOLOR 19 FONT 6
     "วันที่ไฟล์แจ้งงาน  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 3.29 COL 2.83
          BGCOLOR 18 FONT 6
     "   Search  By :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 4.95 COL 2.83
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Report BY" VIEW-AS TEXT
          SIZE 12.33 BY .95 AT ROW 7.91 COL 2.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Old policy :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 9 COL 2.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Status type :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 7.91 COL 52
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "QUERY AND UPDATE DATA TLT (LOCKTON)" VIEW-AS TEXT
          SIZE 49 BY 1.19 AT ROW 1.24 COL 46.67
          FGCOLOR 4 FONT 32
     "br" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 9 COL 35.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 3.24 COL 52.17
          BGCOLOR 18 FONT 6
     "Output file name :" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 9 COL 47.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-332 AT ROW 2.67 COL 1.33
     RECT-333 AT ROW 2.95 COL 89.5
     RECT-338 AT ROW 4.71 COL 1.67
     RECT-339 AT ROW 4.76 COL 61
     RECT-341 AT ROW 2.86 COL 120.17
     RECT-381 AT ROW 5.91 COL 51.67
     RECT-382 AT ROW 8.48 COL 118.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 24
         BGCOLOR 10 .


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
  CREATE WINDOW c-wins ASSIGN
         HIDDEN             = YES
         TITLE              = "Query && Update [LOCKTON]"
         HEIGHT             = 24
         WIDTH              = 133.17
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
         FONT               = 6
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-wins:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-wins
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_tlt bu_oksch fr_main */
/* SETTINGS FOR FILL-IN fi_name IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_outfile IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_search IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
THEN c-wins:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_tlt
/* Query rebuild information for BROWSE br_tlt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" "Cancle/Confirm" "x(30)" "character" ? ? ? ? ? ? no ? no no "19.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > "_<CALC>"
"If  tlt.flag  =  ""N""  Then  ""New""  Else If  tlt.flag = ""R"" Then  ""Renew""
Else  "" """ "New/Renew" "x(8)" ? ? ? ? ? 1 6 no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.exp
"tlt.exp" "BR" "XXX" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.filler1
"tlt.filler1" "กรมธรรม์เดิม" "x(15)" "character" ? ? ? ? ? ? no ? no no "13.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.policy
"tlt.policy" "กรมธรรม์ใหม่" ? "character" ? ? ? ? ? ? no ? no no "12.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.rec_addr5
"tlt.rec_addr5" "เบอร์พรบ." "x(15)" "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.ins_name
"tlt.ins_name" ? ? "character" ? ? ? ? ? ? no ? no no "26.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.nor_grprm
"tlt.nor_grprm" "เบี้ย กธ." ">>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" "เบี้ย พรบ." ">>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "11.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.cha_no
"tlt.cha_no" ? ? "character" ? ? ? ? ? ? no ? no no "21.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.gendat
"tlt.gendat" "Comdate" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.expodat
"tlt.expodat" ? "99/99/9999" "date" ? ? ? ? ? ? no ? no no "9.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.comp_sck
"tlt.comp_sck" ? "x(15)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   = brstat.tlt.nor_coamt
     _FldNameList[15]   = brstat.tlt.comp_coamt
     _FldNameList[16]   > "_<CALC>"
"substr(tlt.model,1,50)" "Model" "X(50)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [LOCKTON] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [LOCKTON] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_tlt
&Scoped-define SELF-NAME br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON LEFT-MOUSE-DBLCLICK OF br_tlt IN FRAME fr_main
DO:
    Get Current br_tlt.
          nv_recidtlt  =  Recid(tlt).

    {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\wgwqloc2(Input  nv_recidtlt).

    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-wins
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
   
   Apply "Close" to This-procedure.
   Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    /*If  fi_polfr  =  "0"   Then  fi_polfr  =  "0"  .
    If  fi_polto  =  "Z"   Then  fi_polto  =  "Z".*/
    Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
        /*tlt.policy  >=   fi_polfr     And
        tlt.policy  <=   fi_polto     And*/
        /*tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "LOCKTON"        no-lock.  
            nv_rectlt =  recid(tlt).   /*A55-0184*/
            Apply "Entry"  to br_tlt.
            Return no-apply.                             
            /*------------------------ 
            {&WINDOW-NAME}:hidden  =  Yes. 
            Run  wuw\wuwqtis1(Input  fi_trndatfr,
            fi_trndatto,
            fi_polfr,
            fi_polto,
            fi_producer).
            {&WINDOW-NAME}:hidden  =  No.                                               
            --------------------------*/
        END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_oksch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_oksch c-wins
ON CHOOSE OF bu_oksch IN FRAME fr_main /* OK */
DO:
    Disp fi_search  with frame fr_main.
    If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And  
            tlt.genusr   =  "LOCKTON"            And
            index(tlt.ins_name,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "กรมธรรม์ใหม่"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "LOCKTON"      And
            index(tlt.policy,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "กรมธรรม์เก่า"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "LOCKTON"      And
            index(tlt.filler1,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ป้ายแดง"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "LOCKTON"      And
            tlt.flag      =  "N"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ต่ออายุ"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "LOCKTON"      And
            tlt.flag      =  "R"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "LOCKTON"       And
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Confirm_yes"  Then do:   /* Confirm yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            tlt.genusr   =  "LOCKTON"        And
            INDEX(tlt.releas,"Confirm") <> 0   no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Confirm_no"  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat >=  fi_trndatfr      And
            tlt.trndat <=  fi_trndatto      And
            tlt.genusr   =  "LOCKTON"         And
            INDEX(tlt.releas,"no") <> 0     no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "LOCKTON"        And
            index(tlt.releas,"cancel") > 0     no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "สาขา"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "LOCKTON"        And
            tlt.EXP      = fi_search       no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_report c-wins
ON CHOOSE OF bu_report IN FRAME fr_main /* EXPORT */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE DO:
        RUN pd_reportfiel. 
        Message "Export data Complete"  View-as alert-box.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update c-wins
ON CHOOSE OF bu_update IN FRAME fr_main /* CANCEL */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt .
    If  avail tlt Then do:
        If  index(tlt.releas,"Cancel")  =  0  Then do:
            message "ยกเลิกข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "Cancel" .
            ELSE tlt.releas  =  "Cancel/" + tlt.releas .
        END.
        Else do:
            message "เรียกข้อมูลกลับมาใช้งาน "  View-as alert-box.
            IF index(tlt.releas,"Cancel/")  =  0 THEN
                tlt.releas =  substr(tlt.releas,index(tlt.releas,"Cancel") + 6 ) .
            ELSE 
                tlt.releas =  substr(tlt.releas,index(tlt.releas,"Cancel") + 7 ) .
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply.  
END.

      /*  If  index(tlt.releas,"cancel") = 0 THEN DO: 
        ASSIGN tlt.releas =  "cancel" + tlt.releas .
            message "ยกเลิกข้อมูลรายการนี้  " tlt.releas  /*FORMAT "x(20)" */
                View-as alert-box.
            

    END.
    ELSE IF index(tlt.releas,"cancel") <> 0   THEN DO:
        DISP tlt.releas  FORMAT "x(20)"  index(tlt.releas,"cancel").
        tlt.releas =  substr(tlt.releas,INDEX(tlt.releas,"cancel") + 6 ) + "/YES".
        DISP tlt.releas  FORMAT "x(20)"  index(tlt.releas,"cancel").
    END.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_upyesno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upyesno c-wins
ON CHOOSE OF bu_upyesno IN FRAME fr_main /* YES/NO */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt.
    If  avail tlt Then do:
        IF INDEX(tlt.releas,"NoConfirm") = 0 THEN DO:
            If  index(tlt.releas,"No")  =  0  Then do:  /* yes */
                    message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
                IF tlt.releas = "" THEN tlt.releas  =  "NO" .
                ELSE IF index(tlt.releas,"Cancel")  <> 0 THEN ASSIGN tlt.releas  =  "Cancel/NO".
                ELSE IF index(tlt.releas,"Confirm")  <> 0 THEN ASSIGN tlt.releas  =  "Confirm/No" .
                ELSE ASSIGN tlt.releas  =  "No".
            END.
            Else do:    /* no */
                If  index(tlt.releas,"Yes")  =  0  Then do:  /* yes */
                        message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
                    IF tlt.releas = "" THEN tlt.releas  =  "Yes" .
                    ELSE IF index(tlt.releas,"Cancel")  <> 0 THEN ASSIGN tlt.releas  =  "Cancel/YES".
                    ELSE IF index(tlt.releas,"Confirm")  <> 0 THEN ASSIGN tlt.releas  =  "Confirm/YES".
                    ELSE ASSIGN tlt.releas  =  "Yes" .
                END.
            END.
        END.
        ELSE DO:
            If  index(tlt.releas,"/No")  =  0  Then do:  /* yes */
                    message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
                IF tlt.releas = "" THEN tlt.releas  =  "NO" .
                ELSE IF index(tlt.releas,"Cancel")    <> 0 THEN ASSIGN tlt.releas  =  "Cancel/NO".
                ELSE IF index(tlt.releas,"NoConfirm") <> 0 THEN ASSIGN tlt.releas  =  "No".
                ELSE IF index(tlt.releas,"Confirm")   <> 0 THEN ASSIGN tlt.releas  =  "Confirm/No" .
                
            END.
            Else do:    /* no */
                If  index(tlt.releas,"/Yes")  =  0  Then do:  /* yes */
                        message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
                    IF tlt.releas = "" THEN tlt.releas  =  "Yes" .
                    ELSE IF index(tlt.releas,"Cancel")  <> 0 THEN ASSIGN tlt.releas  =  "Cancel/YES".
                    ELSE IF index(tlt.releas,"NoConfirm") <> 0 THEN ASSIGN tlt.releas  =  "No".
                    ELSE IF index(tlt.releas,"Confirm")  <> 0 THEN ASSIGN tlt.releas  =  "Confirm/YES".
                END.
            END.

        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON LEAVE OF cb_report IN FRAME fr_main
DO:
  /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat1  = INPUT cb_report.

    IF n_asdat1 = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    /*APPLY "ENTRY" TO fi_comdatF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON return OF cb_report IN FRAME fr_main
DO:
  APPLY "LEAVE" TO cb_report.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON VALUE-CHANGED OF cb_report IN FRAME fr_main
DO:
  /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat1 =  (INPUT cb_report).

    IF n_asdat1 = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล การค้น" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    ELSE IF n_asdat1 = "Old Policy" THEN DO:
        APPLY "ENTRY" TO fi_prvpol.
        RETURN NO-APPLY.
    END.
   
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON LEAVE OF cb_search IN FRAME fr_main
DO:
  /*p-------------*/
    cb_search = INPUT cb_search.
    n_asdat = INPUT cb_search.

    IF n_asdat = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    /*APPLY "ENTRY" TO fi_comdatF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON return OF cb_search IN FRAME fr_main
DO:
  APPLY "LEAVE" TO cb_search.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON VALUE-CHANGED OF cb_search IN FRAME fr_main
DO:
  /*p-------------*/
    cb_search = INPUT cb_search.
    n_asdat =  (INPUT cb_search).

    IF n_asdat = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล การค้น" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_br
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_br c-wins
ON LEAVE OF fi_br IN FRAME fr_main
DO:
  fi_br = INPUT fi_br .
  DISP fi_br WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name c-wins
ON LEAVE OF fi_name IN FRAME fr_main
DO:
  /*fi_polfr  =  Input  fi_polfr.
  Disp  fi_polfr  with frame  fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile c-wins
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile = INPUT fi_outfile.
  DISP fi_outfile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prvpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prvpol c-wins
ON LEAVE OF fi_prvpol IN FRAME fr_main
DO:
  fi_prvpol = CAPS(INPUT fi_prvpol) .
  DISP fi_prvpol WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
    DEF VAR  nv_sort   as  int  init 0.
    ASSIGN
        fi_search     =  Input  fi_search.
    /*comment by Kridtiya i. A55-0184...
    Disp fi_search  with frame fr_main.
    /*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*//*kridtiya i. A54-0216 ...*/
    If  ra_choice =  1  Then do:              /* name  */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat  >=  fi_trndatfr And
            tlt.trndat  <=  fi_trndatto And
           /* tlt.policy  >=  fi_polfr    And
            tlt.policy  <=  fi_polto    And*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr   =  "Tisco"     And
            index(tlt.ins_name,fi_search) <> 0   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  2  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto And
            /*/*kridtiya i. A54-0216 ...*/
            tlt.policy   >=  fi_polfr     And
            tlt.policy   <=  fi_polto     And /*kridtiya i. A54-0216 ...*/*/
            /*tlt.policy   >=  fi_polfr     AND  /*kridtiya i. A54-0216 ...*/
            tlt.policy   <=  fi_polto     AND  /*kridtiya i. A54-0216 ...*/*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr    =  "Tisco"      And
            index(tlt.rec_addr5,fi_search) <> 0  no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  ra_choice  =  3  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr  And
            tlt.trndat <=  fi_trndatto And
            /*tlt.policy >=  fi_polfr      And
            tlt.policy <=  fi_polto     And*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr   =  "Tisco"   And
            INDEX(tlt.cha_no,trim(fi_search)) <> 0 
            /*tlt.cha_no  >=  fi_search ) */   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  4  Then do:   /* Confirm yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            /*tlt.policy >=  fi_polfr      And
            tlt.policy <=  fi_polto        And*/
            /*tlt.comp_sub  =  fi_producer And*/
            tlt.genusr   =  "Tisco"        And
            INDEX(tlt.releas,"yes") <> 0   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  5  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat >=  fi_trndatfr      And
            tlt.trndat <=  fi_trndatto      And
            /*tlt.policy >=  fi_polfr       And
            tlt.policy <=  fi_polto         And*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr   =  "Tisco"         And
            INDEX(tlt.releas,"no") <> 0     no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  6  Then do:    /* cancel */
      /*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*/
      Open Query br_tlt 
          For each tlt Use-index  tlt01 Where
          tlt.trndat  >=  fi_trndatfr   And
          tlt.trndat  <=  fi_trndatto   And
          /*tlt.policy  >=  fi_polfr      And
          tlt.policy  <=  fi_polto      And*/
          /*   tlt.comp_sub  =  fi_producer  And*/
          tlt.genusr   =  "Tisco"      And
          index(tlt.releas,"cancel") > 0     no-lock.
              Apply "Entry"  to br_tlt.
              Return no-apply.                             
      END.
      Else  do:
          Apply "Entry"  to  fi_search.
          Return no-apply.
      END. 
      end.......comment by Kridtiya i. A55-0184*/
    /*add A55-0184 */
    Disp fi_search  with frame fr_main.
    If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01  Where                                     
            tlt.trndat  >=  fi_trndatfr         And                                            
            tlt.trndat  <=  fi_trndatto         And  
            tlt.genusr   =  "Tisco"             And
            index(tlt.ins_name,fi_search) <> 0  no-lock.      
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "กรมธรรม์ใหม่"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Tisco"      And
            index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "กรมธรรม์เก่า"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Tisco"      And
            index(tlt.rec_addr5,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ป้ายแดง"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Tisco"      And
            tlt.flag      =  "N"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ต่ออายุ"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr            And 
            tlt.trndat   <=  fi_trndatto            And 
            tlt.genusr    =  "Tisco"                And 
            tlt.flag      =  "R"                    no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt                           
            For each tlt Use-index  tlt06 Where     
            tlt.trndat >=  fi_trndatfr              And 
            tlt.trndat <=  fi_trndatto              AND 
            tlt.genusr   =  "Tisco"                 And 
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  =  "Confirm_yes"  Then do:  /* Confirm yes..*/
        Open Query br_tlt                           
            For each tlt Use-index  tlt01  Where    
            tlt.trndat  >=  fi_trndatfr             And 
            tlt.trndat  <=  fi_trndatto             And 
            tlt.genusr   =  "Tisco"                 And 
            INDEX(tlt.releas,"yes") <> 0            no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.            
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  =  "Confirm_no"  Then do:    /* confirm no...*/
        Open Query br_tlt                           
            For each tlt Use-index  tlt01   Where   
            tlt.trndat  >=  fi_trndatfr             And 
            tlt.trndat  <=  fi_trndatto             And 
            tlt.genusr   =  "Tisco"                 And 
            INDEX(tlt.releas,"no") <> 0             no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .       /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "Tisco"        And
            index(tlt.releas,"cancel") > 0 no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "สาขา"  Then do:          /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "Tisco"        And
            tlt.EXP      =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .             /*add Kridtiya i. A56-0323*/
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
    /*A55-0184*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatfr c-wins
ON LEAVE OF fi_trndatfr IN FRAME fr_main
DO:
  fi_trndatfr  =  Input  fi_trndatfr.
  If  fi_trndatto  =  ?  Then  fi_trndatto  =  fi_trndatfr.
  Disp fi_trndatfr  fi_trndatto  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatto c-wins
ON LEAVE OF fi_trndatto IN FRAME fr_main
DO:
  If  Input  fi_trndatto  <  fi_trndatfr  Then  fi_trndatto  =  fi_trndatfr.
  Else  fi_trndatto =  Input  fi_trndatto  .
  Disp  fi_trndatto  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_status c-wins
ON VALUE-CHANGED OF ra_status IN FRAME fr_main
DO:
  ra_status = INPUT ra_status.
  DISP ra_status WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-wins 


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
  gv_prgid = "wgwqlock".
  gv_prog  = "Query & Update  Detail (Lockton.) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
      vAcProc_fil = vAcProc_fil   + "ชื่อลูกค้า"   + "," 
                                  + "กรมธรรม์ใหม่" + "," 
                                  + "กรมธรรม์เก่า" + "," 
                                  + "ป้ายแดง" + ","
                                  + "ต่ออายุ" + "," 
                                  + "เลขตัวถัง"      + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + "," 
                                  + "Status_cancel"  + ","
                                  + "สาขา"  + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil1 = vAcProc_fil1 
                                  + "All"  + ","
                                  + "New" + "," 
                                  + "Renew" + ","
                                  + "Old Policy" + ","
                                  + "สาขา" + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + "," 
                                  + "Status_cancel"  + ","
                                  + "ออกงานแล้ว" + "," 
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1)
      ra_status = 4  
      fi_outfile = "D:\Report_Lockton" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .
 
  Disp fi_trndatfr  fi_trndatto cb_search cb_report ra_status fi_outfile
      /*fi_polfr 
      fi_polto*/  with frame fr_main.

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  
  Rect-333:Move-to-top().
  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  RECT-381:Move-to-top().
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-wins  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
  THEN DELETE WIDGET c-wins.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-wins  _DEFAULT-ENABLE
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
  DISPLAY ra_status fi_trndatfr fi_trndatto cb_search fi_search fi_name 
          cb_report fi_br fi_outfile fi_prvpol 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE ra_status fi_trndatfr fi_trndatto bu_ok cb_search bu_oksch br_tlt 
         fi_search bu_update cb_report fi_br fi_outfile bu_report bu_exit 
         bu_upyesno fi_prvpol RECT-332 RECT-333 RECT-338 RECT-339 RECT-341 
         RECT-381 RECT-382 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_data_reportnew c-wins 
PROCEDURE pd_data_reportnew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FOR EACH wdetail NO-LOCK.
    IF length(trim(wdetail.province)) <> 2 AND trim(wdetail.province) <> "" THEN RUN proc_province.
    nv_row  =  nv_row + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' wdetail.pro_off   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' wdetail.cmr_code  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' wdetail.comp_code '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' wdetail.notify_no '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' wdetail.yrmanu    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' wdetail.engine    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' wdetail.chassis   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' wdetail.weight    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' wdetail.power FORMAT "x(5)"     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.colorcode '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.licence   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.garage    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail.fleetper    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail.ncbper      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail.othper      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' wdetail.isp    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' wdetail.comdat FORMAT "x(15)"     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' wdetail.ins_amt         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' wdetail.name_insur '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' wdetail.not_office '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' wdetail.not_date FORMAT "x(15)"   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' wdetail.not_time FORMAT "x(15)"   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' wdetail.not_code   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' wdetail.prem1                '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' wdetail.comp_prm             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' wdetail.sckno      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' wdetail.brand      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' wdetail.pol_addr1  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' wdetail.pol_addr2  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' wdetail.pol_title  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' wdetail.pol_fname  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' wdetail.pol_lname  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' wdetail.ben_name   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' wdetail.remark     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' wdetail.account_no FORMAT "x(10)"  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' wdetail.client_no  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' wdetail.expdat FORMAT "x(15)"         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' wdetail.gross_prm               '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' wdetail.province   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' wdetail.receipt_name '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' wdetail.agent        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' wdetail.prev_insur   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' wdetail.prev_pol     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' wdetail.deduct       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' wdetail.addr1_70     '"' SKIP.  /*Add kridtiya i. A54-0062 ...*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' wdetail.addr2_70     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' wdetail.nsub_dist70  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' wdetail.ndirection70 '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' wdetail.nprovin70    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' wdetail.zipcode70    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' wdetail.addr1_72     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' wdetail.addr2_72     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' wdetail.nsub_dist72  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' wdetail.ndirection72 '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' wdetail.nprovin72    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' wdetail.zipcode72    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' wdetail.apptyp       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' wdetail.appcode      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' wdetail.nBLANK       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' wdetail.pack       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' wdetail.seatenew   '"' SKIP.   /*Add A57-0017*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' wdetail.tp1  '"' skip. /*a60-0095*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' wdetail.tp2  '"' skip. /*a60-0095*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' wdetail.tp3  '"' skip. /*a60-0095*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' wdetail.covcod     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' wdetail.producer    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' wdetail.agent       '"' SKIP.  /*Add kridtiya i. A54-0062 ...*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' wdetail.branch     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' wdetail.NEW_re     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x70;K"  '"' wdetail.redbook      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x71;K"  '"' wdetail.price_ford   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x72;K"  '"' wdetail.yrmanu       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x73;K"  '"' wdetail.brand_model        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x74;K"  '"' wdetail.id_no70  '"' SKIP.  /*A57-0262*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x75;K"  '"' wdetail.id_nobr70  '"' SKIP.  /*A57-0262*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x76;K"  '"' wdetail.id_no72  '"' SKIP.  /*A57-0262*/   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x77;K"  '"' wdetail.id_nobr72  '"' SKIP.  /*A57-0262*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' wdetail.comp_comdat  format "x(15)"     '"' SKIP.    /* A59-0178*/             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' wdetail.comp_expdat  format "x(15)"     '"' SKIP.    /* A59-0178*/                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' wdetail.fi                     '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' wdetail.class         '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' wdetail.usedtype      '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' wdetail.driveno1      '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' wdetail.drivename1    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' wdetail.bdatedriv1 FORMAT "x(15)"    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' wdetail.occupdriv1    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' wdetail.positdriv1    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' wdetail.driveno2      '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' wdetail.drivename2    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' wdetail.bdatedriv2 FORMAT "x(15)"    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' wdetail.occupdriv2    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' wdetail.positdriv2    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' wdetail.driveno3      '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' wdetail.drivename3    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' wdetail.bdatedriv3 FORMAT "x(15)"    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' wdetail.occupdriv3    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' wdetail.positdriv3    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x98;K"  '"' wdetail.nBLANK        '"' SKIP.  /*  84  Blank */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x99;K"  '"' wdetail.receipt72     '"' SKIP.  /*  85  72Reciept */ 
End.   /*  end  wdetail  */
PUT STREAM ns2 "E".*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfiel c-wins 
PROCEDURE pd_reportfiel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_driv1   AS CHAR FORMAT "x(70)" INIT "".
DEF VAR n_bdate1  AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_id1     AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_driv2   AS CHAR FORMAT "x(70)" INIT "".
DEF VAR n_bdate2  AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_id2     AS CHAR FORMAT "x(15)" INIT "".

DEF VAR nv_length AS INT INIT 0.
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
/*ASSIGN nv_cnt =  0 */
ASSIGN  nv_row  =  0.
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Repor Lockton " 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    "NO              "
    "RefNo           "
    "ClosingDate     "
    "ClientTitle     "
    "ClientName      "
    "ClientCode      "
    "ClientAddress1  "
    "ClientAddress2  "
    "Brand           "
    "Model           "
    "CarID           "
    "RegisterYear    "
    "ChassisNo       "
    "EngineNo        "
    "CC              "
    "Beneficiary     "
    "OldPolicyNo     "
    "CMIStickerNo    "
    "CMIPolicyNo     "
    "Garage          "
    "InsureType      "
    "Driver1         "
    "Birth Date1"
    "Driver Licen1"
    "Driver2         "
    "Birth Date2"
    "Driver Licen2"
    "VMIStartDate    "
    "VMIEndDate      "
    "CMIStartDate    "
    "CMIEndDate      "
    "SumInsured      "
    "VMITotalPremium "
    "CMITotalPremium "
    "TotalPremium    "
    "FirstOD         "
    "FirstTPPD       "
    "TPBIPerson      "
    "TPBITime        "
    "TPPD            "
    "OD              "
    "FT              "
    "RY01            "
    "RY02            "
    "RY03            "
    "DiscountGroup   "
    "DiscountHistory "
    "DiscountOther   "
    "Seat            "
    "RemarkInsurer1  "
    "RemarkInsurer2  "
    "RemarkInsurer3  "
    "ContractNo      "
    "UserClosing     "
    "PolicyNo        "
    "TempPolicyNo    "
    "Campaign        "
    "ICNO            "  /*A60-0272*/
    "Paid Date       "
    "DN/CN           "
    "Ref # (DN/CN)   "
    "Remark_paid     "
    "Paid  Type      "
    "BR              "
    "Class70         " . 

loop_tlt:
For each brstat.tlt Use-index  tlt01 Where
            brstat.tlt.trndat   >=  fi_trndatfr   And
            brstat.tlt.trndat   <=  fi_trndatto   And
            brstat.tlt.genusr    =  "LOCKTON"       no-lock. 
    IF cb_report = "New" THEN DO:                                              
        IF brstat.tlt.flag      =  "R"  THEN NEXT.
    END.
    ELSE IF   cb_report =  "Renew"  THEN DO:
        IF brstat.tlt.flag      =  "N"  THEN NEXT.
    END.
    ELSE IF cb_report = "สาขา" THEN DO:
        IF brstat.tlt.EXP    <> fi_br  THEN NEXT.
    END.
    ELSE IF cb_report = "Confirm_yes" THEN DO:
        IF INDEX(brstat.tlt.releas,"Confirm") = 0 THEN NEXT.
    END.
    ELSE IF cb_report = "Confirm_No" THEN DO:
        IF INDEX(brstat.tlt.releas,"no") = 0 THEN NEXT.
    END.
    ELSE IF cb_report =   "Status_cancel"   THEN DO:
        IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
    END.
    ELSE IF cb_report =   "ออกงานแล้ว"   THEN DO:
        IF index(brstat.tlt.releas,"yes") = 0 THEN NEXT.
    END.
    ELSE IF cb_report = "Old Policy" THEN DO:
        IF index(tlt.filler1,fi_prvpol) = 0 THEN NEXT.
    END.
    IF (fi_br <> "") THEN DO:
        IF fi_br <> brstat.tlt.EXP THEN NEXT loop_tlt.
    END.
    IF      ra_status = 1 THEN DO: 
        IF INDEX(brstat.tlt.releas,"yes") = 0    THEN NEXT.
    END.
    ELSE IF ra_status = 2 THEN DO: 
        IF INDEX(brstat.tlt.releas,"no") = 0     THEN NEXT.
    END.
    ELSE IF ra_status = 3 THEN DO: 
        IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
    END.
    ASSIGN  nv_length = 0    nv_ry1  = ""     nv_ry2  = ""    nv_ry3  = ""  remark1   = ""    remark2 = ""     remark3 = ""
            n_driv1   = ""   n_bdate1  = ""   n_id1   = ""    n_driv2 = ""  n_bdate2  = ""    n_id2   = ""
           remark1   = IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,1,index(tlt.filler2,"r2:") - 1) ELSE TRIM(tlt.filler2)                                                                       
           remark2   = IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r2:") + 3 ) ELSE ""                                                                                       
           remark2   = IF index(remark2,"r3:")  <> 0 THEN   Substr(remark2,1,index(remark2,"r3:") - 1) ELSE remark2                                                                                
           remark3   = IF index(tlt.filler2,"r3:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r3:") + 3 ) ELSE "" 
           nv_length =  LENGTH(brstat.tlt.comp_usr_tlt)
           nv_ry3    =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt,"PD3:") + 4,nv_length))   /*RY03     */
           nv_length =  LENGTH(nv_ry3)                                                                               
           nv_ry2    =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt,"PD2:") + 4,nv_length))   /*RY02     */
           nv_length =  LENGTH(nv_ry2)                                                                               
           nv_ry1    =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,r-index(brstat.tlt.comp_usr_tlt,"PD1:") + 4,nv_length))    /*RY01    */ 
           n_driv1   =  IF index(brstat.tlt.dri_name1,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name1,1,index(brstat.tlt.dri_name1,"/") - 1)
                        ELSE brstat.tlt.dri_name1                           /*Driver1         */ 
           n_bdate1  =  IF brstat.tlt.dri_no1 <> "" THEN 
                        IF LENGTH(brstat.tlt.dri_no1) < 8 THEN  SUBSTR(brstat.tlt.dri_no1,1,1) + "/" + SUBSTR(brstat.tlt.dri_no1,2,2) + "/" + SUBSTR(brstat.tlt.dri_no1,4,4) 
                        ELSE SUBSTR(brstat.tlt.dri_no1,1,2) + "/" + SUBSTR(brstat.tlt.dri_no1,3,2) + "/" + SUBSTR(brstat.tlt.dri_no1,5,4) ELSE "" 
           n_id1     =  IF index(brstat.tlt.dri_name1,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name1,R-INDEX(brstat.tlt.dri_name1,"/") + 1) ELSE ""
           n_driv2   =  IF index(brstat.tlt.dri_name2,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name2,1,index(brstat.tlt.dri_name2,"/") - 1)
                        ELSE brstat.tlt.dri_name2                                       /*Driver2         */ 
           n_bdate2  =  IF brstat.tlt.dri_no1 <> "" THEN 
                        IF LENGTH(brstat.tlt.dri_no2) < 8 THEN SUBSTR(brstat.tlt.dri_no2,1,1) + "/" + SUBSTR(brstat.tlt.dri_no2,2,2) + "/" + SUBSTR(brstat.tlt.dri_no2,4,4) 
                        ELSE SUBSTR(brstat.tlt.dri_no2,1,2) + "/" + SUBSTR(brstat.tlt.dri_no2,3,2) + "/" + SUBSTR(brstat.tlt.dri_no2,5,4) ELSE ""
           n_id2     =  IF index(brstat.tlt.dri_name2,"/") <> 0 THEN SUBSTR(brstat.tlt.dri_name2,R-INDEX(brstat.tlt.dri_name2,"/") + 1) ELSE "".
           
           if index(nv_ry1,"P") <> 0 then nv_ry1 = REPLACE(nv_ry1,"P","").  /*A61-0142*/
           if index(nv_ry2,"P") <> 0 then nv_ry2 = REPLACE(nv_ry2,"P","").  /*A61-0142*/
           if index(nv_ry3,"P") <> 0 then nv_ry3 = REPLACE(nv_ry3,"P","").  /*A61-0142*/

    nv_row = nv_row + 1.
    EXPORT DELIMITER "|" 
          nv_row
          brstat.tlt.nor_noti_tlt                             /*RefNo           */                                             
          string(brstat.tlt.datesent,"99/99/9999")            /*ClosingDate     */                                             
          brstat.tlt.rec_name                                 /*ClientTitle     */                                             
          brstat.tlt.ins_name                                 /*ClientName      */                                             
          brstat.tlt.safe3                                    /*ClientCode      */                                             
          brstat.tlt.ins_addr1                                /*ClientAddress1  */                                             
          brstat.tlt.ins_addr2                                /*ClientAddress2  */                                             
          brstat.tlt.brand                                    /*Brand           */                                             
          brstat.tlt.model                                    /*Model           */                                             
          brstat.tlt.lince1                                   /*CarID           */                                             
          brstat.tlt.lince2                                   /*RegisterYear    */                                             
          brstat.tlt.cha_no                                   /*ChassisNo       */                                             
          brstat.tlt.eng_no                                   /*EngineNo        */                                             
          string(brstat.tlt.cc_weight)                        /*CC              */                                             
          brstat.tlt.safe1                                    /*Beneficiary     */                                             
          brstat.tlt.filler1                                  /*OldPolicyNo     */                                             
          brstat.tlt.comp_sck                                 /*CMIStickerNo    */                                             
          brstat.tlt.rec_addr5                                /*CMIPolicyNo     */                                             
          brstat.tlt.stat                                     /*Garage          */                                             
          brstat.tlt.expousr                                  /*InsureType      */                                             
          n_driv1                                            /*Driver1         */                                             
          n_bdate1                                          
          n_id1                                             
          n_driv2                                            /*Driver2         */ 
          n_bdate2                                          
          n_id2 
          if brstat.tlt.gendat  <> ? THEN string(brstat.tlt.gendat,"99/99/9999") else ""            /*VMIStartDate    */       
          if brstat.tlt.expodat <> ? THEN string(brstat.tlt.expodat,"99/99/9999") else ""           /*VMIEndDate      */       
          if brstat.tlt.nor_effdat  <> ? then string(brstat.tlt.nor_effdat,"99/99/9999")  ELSE ""   /*CMIStartDate    */       
          if brstat.tlt.comp_effdat <> ? then string(brstat.tlt.comp_effdat,"99/99/9999") ELSE ""   /*CMIEndDate      */       
          string(brstat.tlt.nor_coamt )                        /*SumInsured      */                                             
          string(brstat.tlt.nor_grprm )                        /*VMITotalPremium */                                             
          string(brstat.tlt.comp_grprm)                        /*CMITotalPremium */                                             
          STRING(brstat.tlt.comp_coamt)                        /*TotalPremium    */                                             
          int(brstat.tlt.endno)                                /*FirstOD         */                                             
          int(brstat.tlt.lince3)                               /*FirstTPPD       */                                             
          int(brstat.tlt.old_eng)                              /*TPBIPerson      */                                             
          int(brstat.tlt.old_cha)                              /*TPBITime        */                                             
          int(brstat.tlt.comp_pol)                             /*TPPD            */                                             
          int(brstat.tlt.nor_usr_tlt)                          /*OD              */                                             
          int(brstat.tlt.rec_addr1)                            /*FT              */                                             
          int(nv_ry1)                                          /*  RY01  tlt.comp_usr_tlt  */                                   
          int(nv_ry2)                                         /*  RY02  tlt.comp_usr_tlt  */                                   
          int(nv_ry3)                                         /*  RY03  tlt.comp_usr_tlt  */                                   
          brstat.tlt.rec_addr4                                /*DiscountGroup   */                                             
          brstat.tlt.lotno                                    /*DiscountHistory */                                             
          string(brstat.tlt.endcnt)                           /*DiscountOther   */                                             
          string(brstat.tlt.sentcnt)                          /*Seat            */                                             
          remark1                                             /*RemarkInsurer1  tlt.filler2 */                                 
          remark2                                             /*RemarkInsurer2  tlt.filler2*/                                  
          remark2                                             /*RemarkInsurer3  tlt.filler2*/                                  
          brstat.tlt.safe2                                    /*ContractNo      */                                             
          brstat.tlt.nor_usr_ins                              /*UserClosing     */                                             
          brstat.tlt.policy                                   /*PolicyNo        */                                             
          brstat.tlt.rec_addr3                                /*TempPolicyNo    */                                             
          brstat.tlt.colorcod                                 /*Campaign        */ 
          brstat.tlt.subins                                   /* icno */            /*A60-0272*/
          " " /*Texcel.Paid_Date  */                          /*Paid Date       */                                             
          " " /*Texcel.DNCN_typ   */                          /*DN/CN           */                                             
          " " /*Texcel.DNCN_no    */                          /*Ref # (DN/CN)   */                                             
          " " /*Texcel.Remark     */                          /*Remark_paid     */                                             
          " " /*Texcel.Paid_Type  */                          /*Paid  Type      */                                             
          brstat.tlt.EXP                                                                                                       
          "". 
END.         /*- A59-0178 -*/                              
                                             
OUTPUT   CLOSE.                            
                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_province c-wins 
PROCEDURE proc_province :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*       IF INDEX(wdetail.province,".") <> 0 THEN REPLACE(wdetail.province,".","").
/*1*/        IF wdetail.province = "ANG THONG"          THEN wdetail.province = "อท".
        ELSE IF wdetail.province = "ANGTHONG"           THEN wdetail.province = "อท".
        ELSE IF wdetail.province = "ANG-THONG"          THEN wdetail.province = "อท".
/*2*/   ELSE IF wdetail.province = "AYUTTHAYA"          THEN wdetail.province = "อย".
/*3*/   ELSE IF wdetail.province = "BKK"                THEN wdetail.province = "กท". /*-A59-0503-*/ /* open A60-0095*/
/*3*/   ELSE IF wdetail.province = "BANGKOK"            THEN wdetail.province = "กท".
/*4*/   ELSE IF wdetail.province = "BURIRAM"            THEN wdetail.province = "บร".
/*5*/   ELSE IF wdetail.province = "CHAI NAT"           THEN wdetail.province = "ชน".
        ELSE IF wdetail.province = "CHAI-NAT"           THEN wdetail.province = "ชน".
/*6*/   ELSE IF wdetail.province = "CHANTHABURI"        THEN wdetail.province = "จบ".
/*7*/   ELSE IF wdetail.province = "CHIANG MAI"         THEN wdetail.province = "ชม".
        ELSE IF wdetail.province = "CHIANGMAI"          THEN wdetail.province = "ชม".
/*8*/   ELSE IF wdetail.province = "CHONBURI"           THEN wdetail.province = "ชบ".
/*9*/   ELSE IF wdetail.province = "KALASIN"            THEN wdetail.province = "กส".
/*10*/  ELSE IF wdetail.province = "KANCHANABURI"       THEN wdetail.province = "กจ".
/*11*/  ELSE IF wdetail.province = "KHON KAEN"          THEN wdetail.province = "ขก".
        ELSE IF wdetail.province = "KHONKAEN"           THEN wdetail.province = "ขก".
/*12*/  ELSE IF wdetail.province = "KRABI"              THEN wdetail.province = "กบ".
/*13*/  ELSE IF wdetail.province = "LOPBURI"            THEN wdetail.province = "ลบ".
/*14*/  ELSE IF wdetail.province = "NAKHON NAYOK"       THEN wdetail.province = "นย".
        ELSE IF wdetail.province = "NAKHONNAYOK"        THEN wdetail.province = "นย".
/*15*/  ELSE IF wdetail.province = "NAKHON PATHOM"      THEN wdetail.province = "นฐ".
        ELSE IF wdetail.province = "NAKHONPATHOM"       THEN wdetail.province = "นฐ".
/*16*/  ELSE IF wdetail.province = "NAKHON RATCHASIMA"  THEN wdetail.province = "นม".
        ELSE IF wdetail.province = "NAKHONRATCHASIMA"   THEN wdetail.province = "นม".
/*17*/  ELSE IF wdetail.province = "NAKHON SITHAMMARAT" THEN wdetail.province = "นศ".
        ELSE IF wdetail.province = "NAKHONSITHAMMARAT"  THEN wdetail.province = "นศ".
/*18*/  ELSE IF wdetail.province = "NONTHABURI"         THEN wdetail.province = "นบ".
/*19*/  ELSE IF wdetail.province = "PHETCHABURI"        THEN wdetail.province = "พบ".
/*20*/  ELSE IF wdetail.province = "PHUKET"             THEN wdetail.province = "ภก".
/*21*/  ELSE IF wdetail.province = "PHITSANULOK"        THEN wdetail.province = "พล".
/*22*/  ELSE IF wdetail.province = "PRACHINBURI"        THEN wdetail.province = "ปจ".
/*23*/  ELSE IF wdetail.province = "RATCHABURI"         THEN wdetail.province = "รบ".
/*24*/  ELSE IF wdetail.province = "RAYONG"             THEN wdetail.province = "รย".
/*25*/  ELSE IF wdetail.province = "ROI ET"             THEN wdetail.province = "รอ".
        ELSE IF wdetail.province = "ROI-ET"             THEN wdetail.province = "รอ".
        ELSE IF wdetail.province = "ROIET"              THEN wdetail.province = "รอ".
/*26*/  ELSE IF wdetail.province = "SARABURI"           THEN wdetail.province = "สบ".
/*27*/  ELSE IF wdetail.province = "SRISAKET"           THEN wdetail.province = "ศก".
/*28*/  ELSE IF wdetail.province = "SONGKHLA"           THEN wdetail.province = "สข".
/*29*/  ELSE IF wdetail.province = "SA KAEO"            THEN wdetail.province = "สก".
        ELSE IF wdetail.province = "SAKAEO"             THEN wdetail.province = "สก".
/*30*/  ELSE IF wdetail.province = "SUPHANBURI"         THEN wdetail.province = "สพ".
/*31*/  ELSE IF wdetail.province = "SURAT THANI"        THEN wdetail.province = "สฏ".
        ELSE IF wdetail.province = "SURATTHANI"         THEN wdetail.province = "สฏ".
/*32*/  ELSE IF wdetail.province = "TRANG"              THEN wdetail.province = "ตง".
/*33*/  ELSE IF wdetail.province = "UBON RATCHATHANI"   THEN wdetail.province = "อบ".
        ELSE IF wdetail.province = "UBONRATCHATHANI"    THEN wdetail.province = "อบ".
/*34*/  ELSE IF wdetail.province = "UDON THANI"         THEN wdetail.province = "อด".
        ELSE IF wdetail.province = "UDONTHANI"          THEN wdetail.province = "อด".
/*35*/  ELSE IF wdetail.province = "AMNAT CHAROEN"      THEN wdetail.province = "อจ".
        ELSE IF wdetail.province = "AMNATCHAROEN"       THEN wdetail.province = "อจ".
/*36*/  ELSE IF wdetail.province = "CHAIYAPHUM"         THEN wdetail.province = "ชย".
/*37*/  ELSE IF wdetail.province = "CHIANG RAI"         THEN wdetail.province = "ชร".
        ELSE IF wdetail.province = "CHIANGRAI"          THEN wdetail.province = "ชร".
/*38*/  ELSE IF wdetail.province = "CHUMPHON"           THEN wdetail.province = "ชพ".
/*39*/  ELSE IF wdetail.province = "KAMPHAENG PHET"     THEN wdetail.province = "กพ".
        ELSE IF wdetail.province = "KAMPHAENGPHET"      THEN wdetail.province = "กพ".
/*40*/  ELSE IF wdetail.province = "LAMPANG"            THEN wdetail.province = "ลป".
/*41*/  ELSE IF wdetail.province = "LAMPHUN"            THEN wdetail.province = "ลพ".
/*42*/  ELSE IF wdetail.province = "NAKHON SAWAN"       THEN wdetail.province = "นว".
        ELSE IF wdetail.province = "NAKHONSAWAN"        THEN wdetail.province = "นว".
/*43*/  ELSE IF wdetail.province = "NONG KHAI"          THEN wdetail.province = "นค".
        ELSE IF wdetail.province = "NONGKHAI"           THEN wdetail.province = "นค".
/*44*/  ELSE IF wdetail.province = "PATHUM THANI"       THEN wdetail.province = "ปท".
        ELSE IF wdetail.province = "PATHUMTHANI"        THEN wdetail.province = "ปท".
/*45*/  ELSE IF wdetail.province = "PATTANI"            THEN wdetail.province = "ปน".
/*46*/  ELSE IF wdetail.province = "PHATTHALUNG"        THEN wdetail.province = "พท".
/*47*/  ELSE IF wdetail.province = "PHETCHABUN"         THEN wdetail.province = "พช".
/*48*/  ELSE IF wdetail.province = "SAKON NAKHON"       THEN wdetail.province = "สน".
/*49*/  ELSE IF wdetail.province = "SING BURI"          THEN wdetail.province = "สห".
        ELSE IF wdetail.province = "SINGBURI"           THEN wdetail.province = "สห".
/*50*/  ELSE IF wdetail.province = "SURIN"              THEN wdetail.province = "สร".
/*51*/  ELSE IF wdetail.province = "YASOTHON"           THEN wdetail.province = "ยส".
/*52*/  ELSE IF wdetail.province = "YALA"               THEN wdetail.province = "ยล".
/*53*/  ELSE IF wdetail.province = "BAYTONG"            THEN wdetail.province = "บต".
/*54*/  ELSE IF wdetail.province = "CHACHOENGSAO"       THEN wdetail.province = "ฉช".
/*55*/  ELSE IF wdetail.province = "LOEI"               THEN wdetail.province = "ลย".
/*56*/  ELSE IF wdetail.province = "MAE HONG SON"       THEN wdetail.province = "มส".
        ELSE IF wdetail.province = "MAEHONGSON"         THEN wdetail.province = "มส".
/*57*/  ELSE IF wdetail.province = "MAHA SARAKHAM"      THEN wdetail.province = "มค".
        ELSE IF wdetail.province = "MAHASARAKHAM"       THEN wdetail.province = "มค".
/*58*/  ELSE IF wdetail.province = "MUKDAHAN"           THEN wdetail.province = "มห".
/*59*/  ELSE IF wdetail.province = "NAN"                THEN wdetail.province = "นน".
/*60*/  ELSE IF wdetail.province = "NARATHIWAT"         THEN wdetail.province = "นธ".
/*61*/  ELSE IF wdetail.province = "NONG BUA LAMPHU"    THEN wdetail.province = "นภ".
        ELSE IF wdetail.province = "NONGBUALAMPHU"      THEN wdetail.province = "นภ".
/*62*/  ELSE IF wdetail.province = "PHAYAO"             THEN wdetail.province = "พย".  
/*63*/  ELSE IF wdetail.province = "PHANG NGA"          THEN wdetail.province = "พง".
        ELSE IF wdetail.province = "PHANGNGA"           THEN wdetail.province = "พง".
/*64*/  ELSE IF wdetail.province = "PHRAE"              THEN wdetail.province = "พร".
/*65*/  ELSE IF wdetail.province = "PHICHIT"            THEN wdetail.province = "พจ".
/*66*/  ELSE IF wdetail.province = "PRACHUAP KHIRIKHAN" THEN wdetail.province = "ปข".
        ELSE IF wdetail.province = "PRACHUAPKHIRIKHAN"  THEN wdetail.province = "ปข".
/*67*/  ELSE IF wdetail.province = "RANONG"             THEN wdetail.province = "รน".
/*68*/  ELSE IF wdetail.province = "SAMUT PRAKAN"       THEN wdetail.province = "สป".
/*69*/  ELSE IF wdetail.province = "SAMUT SAKHON"       THEN wdetail.province = "สค". 
/*70*/  ELSE IF wdetail.province = "SAMUT SONGKHRAM"    THEN wdetail.province = "สส".
        ELSE IF wdetail.province = "SAMUTPRAKAN"        THEN wdetail.province = "สป".  
        ELSE IF wdetail.province = "SAMUTSAKHON"        THEN wdetail.province = "สค".  
        ELSE IF wdetail.province = "SAMUTSONGKHRAM"     THEN wdetail.province = "สส".  
/*71*/  ELSE IF wdetail.province = "SATUN"              THEN wdetail.province = "สต".
/*72*/  ELSE IF wdetail.province = "SUKHOTHAI"          THEN wdetail.province = "สท".
/*73*/  ELSE IF wdetail.province = "TAK"                THEN wdetail.province = "ตก".
/*74*/  ELSE IF wdetail.province = "TRAT"               THEN wdetail.province = "ตร".
/*75*/  ELSE IF wdetail.province = "UTHAI THANI"        THEN wdetail.province = "อน".
        ELSE IF wdetail.province = "UTHAITHANI"         THEN wdetail.province = "อน".
/*76*/  ELSE IF wdetail.province = "UTTARADIT"          THEN wdetail.province = "อต".
/*77*/  ELSE IF wdetail.province = "NAKHON PHANOM"      THEN wdetail.province = "นพ". 
        ELSE IF wdetail.province = "NAKHONPHANOM"       THEN wdetail.province = "นพ". 
/*78*/  ELSE IF wdetail.province = "BUENG KAN"          THEN wdetail.province = "บก".
        ELSE IF wdetail.province = "BUENGKAN"           THEN wdetail.province = "บก". 
        ELSE IF wdetail.province = "กทม"                THEN wdetail.province = "กท".  /*a60-0095*/
        ELSE DO:
           FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(wdetail.province) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN   
                ASSIGN wdetail.province = Insure.LName.
       END. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_openQuery c-wins 
PROCEDURE Pro_openQuery :
/*------------------------------------------------------------------------------
  Purpose:
       
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*/
Open Query br_tlt 
    For each tlt Use-index  tlt01 Where
        tlt.trndat  >=  fi_trndatfr  And
        tlt.trndat  <=  fi_trndatto  And
        /*tlt.policy >=  fi_polfr      And
        tlt.policy <=  fi_polto     And*/
        /*  tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "Tisco"      no-lock.
        ASSIGN
            nv_rectlt =  recid(tlt).   /*A55-0184*/
                             

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_openQuery2 c-wins 
PROCEDURE Pro_openQuery2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Open Query br_tlt 
    /*For each tlt Use-index  tlt01 Where
                             tlt.trndat  >=  fi_trndatfr  And
                             tlt.trndat  <=  fi_trndatto  And
                             /*tlt.policy >=  fi_polfr      And
                             tlt.policy <=  fi_polto     And*/
                           /*  tlt.comp_sub  =  fi_producer  And*/
                             recid(tlt) = nv_rectlt        AND 
                             tlt.genusr   =  "Tisco"      no-lock.*/
    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt).   /*A57-0017*/
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

