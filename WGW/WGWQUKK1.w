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
program id   : wgwqukk1.w
program name : Query & Update flag detail
               Import text file from  KK  to create  new policy Add in table  tlt 
Create  by   : Kridtiya i. [A55-0055]   On   15/02/2012
Connect      : GW_SAFE LD SIC_BRAN, GW_STAT LD BRSTAT ,SICSYAC  [SICUW  not connect Stat]
Modify by    : Kridtiya i. A55-0145 ปรับ คอลัมน์การรับค่าไฟล์ยืนยันออกกรมธรรม์ ตามlayout new
Modify by    : Kridtiya i. A55-0280 ปรับ ค่าเลขตัวถังกรณีแมทไฟล์ยืนยันออกกรมธรรม์ โดยตัดเครื่องหมายที่เลขตัวถังก่อนการค้น
Modify by    : Kridtiya i. A56-0021 เพิ่มคอลัมน์วันเกิดและเลขที่บัตรประชาชนลูกค้า
modify by    : Ranu I. A61-0335 Date : 11/07/2018 เพิ่มการเก็บข้อมูลตามไฟล์ confirm 
+++++++++++++++++++++++++++++++++++++++++++++++*/
DEF VAR     nv_rectlt   AS  recid  init  0.
DEF VAR     nv_recidtlt AS  recid  init  0.
DEF STREAM  ns2.
DEFINE WORKFILE wdetail
    FIELD HC_PAYM_DATE     AS CHAR FORMAT "x(20)"  INIT ""  /* 1  Cust_code       */
    FIELD HCC_CUST_CODE    AS CHAR FORMAT "x(60)"  INIT ""  /* 2  Cust_name       */
    FIELD CUST_NAME        AS CHAR FORMAT "x(20)"  INIT ""  /* 3  fin_no          */
    FIELD HV_INF_NO        AS CHAR FORMAT "x(20)"  INIT ""  /* 4  Ao_code         */
    FIELD HCC_CN_RUNNO_SHOw  AS CHAR FORMAT "x(50)"  INIT ""  /* 5  Ao_name         */
    FIELD HC_CN_BRN        AS CHAR FORMAT "x(20)"  INIT ""  /* 6  Cn_Runno_show   */
    FIELD CA_CONT_ADDR     AS CHAR FORMAT "x(30)"  INIT ""  /* 6  Cn_Runno_show   */
    FIELD CUST_HOUSE_NO    AS CHAR FORMAT "x(4)"   INIT ""  /* 7  Cn_Branch       */
    FIELD CUST_VILLAGE     AS CHAR FORMAT "x(100)" INIT ""  /* 8  Bill_Address1   */
    FIELD CUST_BUILDING    AS CHAR FORMAT "x(40)"  INIT ""  /* 9  Bill_Address2   */
    FIELD CA_FLOOR         AS CHAR FORMAT "x(10)"  INIT ""  /* 9  Bill_Address2   */
    FIELD CUST_MOO         AS CHAR FORMAT "x(40)"  INIT ""  /* 10 Bill_Address3   */
    FIELD CUST_SOI         AS CHAR FORMAT "x(40)"  INIT ""  /* 11 Bill_Address4   */
    FIELD CUST_STREET      AS CHAR FORMAT "x(10)"  INIT ""  /* 12 Bill_Zip        */
    FIELD CUST_TAMBOL      AS CHAR FORMAT "x(10)"  INIT ""  /* 13 Ins_code        */
    FIELD CUST_AMPHUR      AS CHAR FORMAT "x(10)"  INIT ""  /* 14 Cov_amt_F       */
    FIELD CUST_PROVINCE    AS CHAR FORMAT "x(2)"   INIT ""  /* 15 Cov_amt_DigF    */
    FIELD CUST_ZIP         AS CHAR FORMAT "x(10)"  INIT ""  /* 16 Vol_no          */
    FIELD HV_INS_CODE      AS CHAR FORMAT "x(20)"  INIT ""  /* 17 comp_stk        */
    FIELD HV_COV_AMT       AS CHAR FORMAT "x(10)"  INIT ""  /* 18 Eff_Date        */
    FIELD HV_VOL_NO        AS CHAR FORMAT "x(10)"  INIT ""  /* 19 exp_date        */
    FIELD HV_EFF_DATE      AS CHAR FORMAT "x(10)"  INIT ""  /* 20 Paym_due        */
    FIELD HV_EXP_DATE      AS CHAR FORMAT "x(10)"  INIT ""  /* 21 Fixed_class     */
    FIELD HV_VOL_TYPE      AS CHAR FORMAT "x(10)"  INIT ""  /* 22 With_Insure     */
    FIELD HV_BENEFIT_NAME  AS CHAR FORMAT "x(10)"  INIT ""  /* 23 renew_type      */
    FIELD HV_RECEIVE_NAME  AS CHAR FORMAT "x(30)"  INIT ""  /* 24 Vol_no_old      */
    FIELD HV_NET_PREM      AS CHAR FORMAT "x(10)"  INIT ""  /* 25 Vol_Type        */
    FIELD HV_STAMP         AS CHAR FORMAT "x(50)"  INIT ""  /* 26 Drive_Name1     */
    FIELD HV_VAT           AS CHAR FORMAT "x(50)"  INIT ""  /* 27 Drive_Name2     */
    FIELD HV_TAX_AMT       AS CHAR FORMAT "x(30)"  INIT ""  /* 28 Drive_Lic1      */
    FIELD HV_GROSS_PREM    AS CHAR FORMAT "x(30)"  INIT ""  /* 29 Drive_lic2      */
    FIELD BRAND_NAME       AS CHAR FORMAT "x(30)"  INIT ""  /* 30 Drive_hbd1      */
    FIELD MODEL_NAME       AS CHAR FORMAT "x(30)"  INIT ""  /* 31 Drive_hbd2      */
    FIELD HCC_LICENSE_NO   AS CHAR FORMAT "x(10)"  INIT ""  /* 32 Driver_type     */
    FIELD HCC_PROVINCE     AS CHAR FORMAT "x(50)"  INIT ""  /* 33 Benefit_name    */
    FIELD HCC_CHASSIS_NO   AS CHAR FORMAT "x(10)"  INIT ""  /* 34 Type_ins        */
    FIELD HCC_ENGINE_NO    AS CHAR FORMAT "x(100)" INIT ""  /* 35 Receive_name    */
    FIELD HCC_MODEL_YEAR   AS CHAR FORMAT "x(10)"  INIT ""  /* 36 Net_prem        */
    FIELD HCC_CC           AS CHAR FORMAT "x(21)"  INIT ""  /* 37 Net_prem_DigF   */
    FIELD HCC_WEIGHT       AS CHAR FORMAT "x(10)"  INIT ""  /* 38 Stamp           */
    FIELD HV_CAR_FLAG      AS CHAR FORMAT "x(2)"   INIT ""  /* 39 stamp_dig       */
    FIELD BRN_HOUSE_NO     AS CHAR FORMAT "x(10)"  INIT ""  /* 40 vat_amt         */
    FIELD BRN_VILLAGE      AS CHAR FORMAT "x(2)"   INIT ""  /* 41 vat_amt_dig     */
    FIELD BRN_BUILDING     AS CHAR FORMAT "x(10)"  INIT ""  /* 42 Tax_amt         */
    FIELD BRN_MOO          AS CHAR FORMAT "x(2)"   INIT ""  /* 43 Tax_amt_dig     */
    FIELD BRN_SOI          AS CHAR FORMAT "x(10)"  INIT ""  /* 44 Groos_F         */
    FIELD BRN_STREET       AS CHAR FORMAT "x(2)"   INIT ""  /* 45 Groos_DigF      */
    FIELD BRN_TAMBOL       AS CHAR FORMAT "x(10)"  INIT ""  /* 46 Have_Tax        */
    FIELD BRN_AMPHUR       AS CHAR FORMAT "x(30)"  INIT ""  /* 47 Car_Brand       */
    FIELD BRN_PROVINCE     AS CHAR FORMAT "x(50)"  INIT ""  /* 48 Car_Model       */
    FIELD BRN_ZIP          AS CHAR FORMAT "x(8)"   INIT ""  /* 49 License_no      */
    FIELD subCampaign      AS CHAR FORMAT "x(2)"   INIT ""  /* 50 Province        */ 
    FIELD BIRTHDAY         AS CHAR FORMAT "x(10)"  INIT ""  /* 29 Drive_lic2      */
    FIELD CARD_ID          AS CHAR FORMAT "x(15)"  INIT ""  /* 30 Drive_hbd1      */
    FIELD CARD_TYPE        AS CHAR FORMAT "x(30)"  INIT ""  /* 31 Drive_hbd2      */
    FIELD ADDR_CON_ADDR    AS CHAR FORMAT "x(40)"  INIT ""  /* 32 Driver_type     */
    FIELD ADDR_HOUSE       AS CHAR FORMAT "x(15)"  INIT ""  /* 33 Benefit_name    */
    FIELD ADDR_VILLAGE     AS CHAR FORMAT "x(20)"  INIT ""  /* 34 Type_ins        */
    FIELD ADDR_BUILDING    AS CHAR FORMAT "x(30)"  INIT ""  /* 35 Receive_name    */
    FIELD ADDR_FLOOR       AS CHAR FORMAT "x(10)"  INIT ""  /* 36 Net_prem        */
    FIELD ADDR_MOO         AS CHAR FORMAT "x(5)"   INIT ""  /* 37 Net_prem_DigF   */
    FIELD ADDR_SOI         AS CHAR FORMAT "x(30)"  INIT ""  /* 38 Stamp           */
    FIELD ADDR_STREET      AS CHAR FORMAT "x(30)"  INIT ""  /* 39 stamp_dig       */
    FIELD ADDR_TAMBOL      AS CHAR FORMAT "x(40)"  INIT ""  /* 40 vat_amt         */
    FIELD ADDR_AMPHUR      AS CHAR FORMAT "x(40)"  INIT ""  /* 41 vat_amt_dig     */
    FIELD ADDR_PROVINCE    AS CHAR FORMAT "x(30)"  INIT ""  /* 42 Tax_amt         */
    FIELD ADDR_ZIP         AS CHAR FORMAT "x(5)"   INIT ""  /* 43 Tax_amt_dig     */  
    field GENDER           as char format "x(10)"   init "" /* GENDER       */   /*A61-0335*/
    field NATION           as char format "x(25)"   init "" /* NATION       */   /*A61-0335*/
    field STATUS_CODE      as char format "x(10)"   init "" /* STATUS_CODE  */   /*A61-0335*/
    field CAREER           as char format "x(50)"   init "" /* CAREER       */   /*A61-0335*/
    field CUSTTYPE         as char format "x(100)"   init "" /* CUSTTYPE     */   /*A61-0335*/
    field OFFICE_NAME      as char format "x(100)"   init "" /* OFFICE_NAME  */   /*A61-0335*/
    field OFFICEADD        as char format "x(150)"   init "" /* OFFICEADD    */   /*A61-0335*/
    field OFFICETEL        as char format "x(20)"   init "" /* OFFICETEL    */   /*A61-0335*/
    field OFFICEMOBILE     as char format "x(20)"   init "" /* OFFICEMOBILE */   /*A61-0335*/
    field KKapp            as char format "x(20)"   init "". /* KKapp        */   /*A61-0335*/

DEF VAR   n_add1   AS  CHAR INIT "" FORMAT "x(40)".
DEF VAR   n_add2   AS  CHAR INIT "" FORMAT "x(40)".
DEF VAR   n_add3   AS  CHAR INIT "" FORMAT "x(40)".
DEF VAR   n_add4   AS  CHAR INIT "" FORMAT "x(40)".
DEF VAR   n_add5   AS  CHAR INIT "" FORMAT "x(40)".
DEF VAR   n_add6   AS  CHAR INIT "" FORMAT "x(40)".
DEF VAR   n_add7   AS  CHAR INIT "" FORMAT "x(40)".
DEF VAR   n_rec    AS  INTE INIT 0. 
ASSIGN    n_rec    = 0.

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
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas tlt.expotim ~
tlt.comp_noti_tlt tlt.cha_no tlt.ins_name tlt.nor_effdat tlt.expodat ~
tlt.subins tlt.filler2 tlt.brand tlt.model tlt.filler1 tlt.lince1 ~
tlt.eng_no tlt.lince2 tlt.old_eng tlt.comp_usr_ins tlt.nor_usr_ins 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS cb_type fi_compa fi_trndatfr fi_trndatto ~
bu_ok fi_search bu_sch fi_filename2 bu_file fi_filename3 bu_reok2 ra_report ~
fi_filename bu_reok br_tlt bu_exit RECT-332 RECT-333 RECT-338 RECT-340 ~
RECT-341 RECT-343 RECT-344 RECT-346 
&Scoped-Define DISPLAYED-OBJECTS cb_type fi_compa fi_trndatfr fi_trndatto ~
fi_search fi_filename2 fi_filename3 ra_report fi_filename 

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
     SIZE 6 BY 1.24
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 5 BY 1.24
     FONT 6.

DEFINE BUTTON bu_reok 
     LABEL "OK" 
     SIZE 5 BY 1.

DEFINE BUTTON bu_reok2 
     LABEL "OK" 
     SIZE 5 BY 1.

DEFINE BUTTON bu_sch 
     LABEL "Search" 
     SIZE 7 BY 1.05.

DEFINE VARIABLE cb_type AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Name","Name",
                     "SKKI","SKKI",
                     "KK-APP","KK-APP",
                     "Chassis","Chassis",
                     "YES","YES",
                     "NO","NO",
                     "CANCEL","CANCEL"
     DROP-DOWN-LIST
     SIZE 35 BY 1
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 34.5 BY 1.05
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1.05
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1.05
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 50.17 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_report AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2,
"CA", 3,
"All", 4
     SIZE 34.33 BY 1
     BGCOLOR 11 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 6.81
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-333
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8 BY 2.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 62 BY 3.24
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 51.5 BY 2.62
     BGCOLOR 31 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 3.24
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 56.67 BY 3.24
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-344
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7 BY 2.29
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-346
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.33 BY 2.29
     BGCOLOR 2 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas FORMAT "x(8)":U WIDTH 7.83
      tlt.expotim COLUMN-LABEL "KK App" FORMAT "x(25)":U WIDTH 16.33
      tlt.comp_noti_tlt COLUMN-LABEL "เลขที่รับแจ้งฯ KK" FORMAT "x(30)":U
            WIDTH 15
      tlt.cha_no FORMAT "x(25)":U WIDTH 21
      tlt.ins_name FORMAT "x(50)":U WIDTH 22
      tlt.nor_effdat COLUMN-LABEL "Comdate." FORMAT "99/99/9999":U
            WIDTH 11.5
      tlt.expodat COLUMN-LABEL "Expydate." FORMAT "99/99/9999":U
            WIDTH 11.5
      tlt.subins COLUMN-LABEL "รหัส" FORMAT "x(4)":U
      tlt.filler2 COLUMN-LABEL "ประเภทรถ" FORMAT "x(35)":U WIDTH 18
      tlt.brand COLUMN-LABEL "Car Brand" FORMAT "x(20)":U WIDTH 12
      tlt.model FORMAT "x(55)":U WIDTH 18
      tlt.filler1 COLUMN-LABEL "Type" FORMAT "x(20)":U WIDTH 8
      tlt.lince1 COLUMN-LABEL "ทะเบียน" FORMAT "x(35)":U WIDTH 15
      tlt.eng_no FORMAT "x(20)":U WIDTH 17.5
      tlt.lince2 COLUMN-LABEL "ปีรถ" FORMAT "x(5)":U
      tlt.old_eng COLUMN-LABEL "SYSTEM" FORMAT "x(20)":U WIDTH 15
      tlt.comp_usr_ins COLUMN-LABEL "ชื่อผู้แจ้งของบ.ประกันภัย" FORMAT "x(50)":U
            WIDTH 23.5
      tlt.nor_usr_ins FORMAT "x(50)":U WIDTH 23.83
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 16.14
         BGCOLOR 15  ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     cb_type AT ROW 4.81 COL 14.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_compa AT ROW 1.48 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_trndatfr AT ROW 2.57 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 2.57 COL 35.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.95 COL 55.17
     fi_search AT ROW 6.14 COL 2.83 NO-LABEL
     bu_sch AT ROW 5.48 COL 54.67
     fi_filename2 AT ROW 1.48 COL 79.17 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 1.48 COL 126.33
     fi_filename3 AT ROW 2.67 COL 79.17 COLON-ALIGNED NO-LABEL
     bu_reok2 AT ROW 2.67 COL 126.33
     ra_report AT ROW 4.91 COL 77.17 NO-LABEL
     fi_filename AT ROW 6.05 COL 75 COLON-ALIGNED NO-LABEL
     bu_reok AT ROW 5.48 COL 113.33
     br_tlt AT ROW 7.86 COL 1
     bu_exit AT ROW 5.24 COL 124
     "Report By:" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 4.86 COL 65.67
          BGCOLOR 5 FGCOLOR 2 FONT 6
     "    Company no :" VIEW-AS TEXT
          SIZE 15.83 BY 1 AT ROW 1.48 COL 2.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "File name :" VIEW-AS TEXT
          SIZE 11 BY 1.05 AT ROW 6 COL 65.83
          BGCOLOR 5 FGCOLOR 2 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4 BY 1 AT ROW 2.57 COL 33.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Transdate From :" VIEW-AS TEXT
          SIZE 15.83 BY 1 AT ROW 2.57 COL 2.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "File_out_Confirm:" VIEW-AS TEXT
          SIZE 16.5 BY 1.05 AT ROW 2.62 COL 64.33
          BGCOLOR 18 FONT 6
     "File_in_Confirm :" VIEW-AS TEXT
          SIZE 16.5 BY 1.05 AT ROW 1.43 COL 64.33
          BGCOLOR 18 FONT 6
     "Search  By :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 4.76 COL 3
          BGCOLOR 5 FONT 6
     RECT-332 AT ROW 1 COL 1
     RECT-333 AT ROW 1.24 COL 53.83
     RECT-338 AT ROW 4.19 COL 2
     RECT-340 AT ROW 1.24 COL 2
     RECT-341 AT ROW 4.19 COL 121.83
     RECT-343 AT ROW 4.19 COL 64.33
     RECT-344 AT ROW 4.86 COL 112.33
     RECT-346 AT ROW 4.91 COL 53.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.29
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
  CREATE WINDOW c-wins ASSIGN
         HIDDEN             = YES
         TITLE              = "Query && Update [KK-ป้ายแดง]"
         HEIGHT             = 23.1
         WIDTH              = 132.67
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
/* BROWSE-TAB br_tlt bu_reok fr_main */
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
     _Options          = "NO-LOCK"
     _OrdList          = "brstat.tlt.comp_noti_tlt|yes"
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" ? "x(8)" "character" ? ? ? ? ? ? no ? no no "7.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.expotim
"tlt.expotim" "KK App" "x(25)" "character" ? ? ? ? ? ? no ? no no "16.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"tlt.comp_noti_tlt" "เลขที่รับแจ้งฯ KK" "x(30)" ? ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.cha_no
"tlt.cha_no" ? "x(25)" "character" ? ? ? ? ? ? no ? no no "21" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.ins_name
"tlt.ins_name" ? ? "character" ? ? ? ? ? ? no ? no no "22" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.nor_effdat
"tlt.nor_effdat" "Comdate." ? "date" ? ? ? ? ? ? no ? no no "11.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.expodat
"tlt.expodat" "Expydate." "99/99/9999" "date" ? ? ? ? ? ? no ? no no "11.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.subins
"tlt.subins" "รหัส" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.filler2
"tlt.filler2" "ประเภทรถ" "x(35)" "character" ? ? ? ? ? ? no ? no no "18" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.brand
"tlt.brand" "Car Brand" "x(20)" "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.model
"tlt.model" ? "x(55)" "character" ? ? ? ? ? ? no ? no no "18" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.filler1
"tlt.filler1" "Type" "x(20)" "character" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.lince1
"tlt.lince1" "ทะเบียน" "x(35)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > brstat.tlt.eng_no
"tlt.eng_no" ? ? "character" ? ? ? ? ? ? no ? no no "17.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > brstat.tlt.lince2
"tlt.lince2" "ปีรถ" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > brstat.tlt.old_eng
"tlt.old_eng" "SYSTEM" ? "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > brstat.tlt.comp_usr_ins
"tlt.comp_usr_ins" "ชื่อผู้แจ้งของบ.ประกันภัย" ? "character" ? ? ? ? ? ? no ? no no "23.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > brstat.tlt.nor_usr_ins
"tlt.nor_usr_ins" ? ? "character" ? ? ? ? ? ? no ? no no "23.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [KK-ป้ายแดง] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [KK-ป้ายแดง] */
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
    
    Run  wgw\wgwqukk3(Input  nv_recidtlt).

    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     /*fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.*/
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


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-wins
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    DEF  VAR NO_add AS CHAR FORMAT "x(50)" .

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
        fi_filename2  = cvData.
        ASSIGN 
            no_add      =   STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) 
            fi_filename3  = SUBSTRING(cvData,1,R-INDEX(fi_filename2,"\")) + "filenew_Confirm" + no_add + ".CSV".

        DISP fi_filename2 fi_filename3 WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
        tlt.genusr   =   fi_compa      no-lock.  
            Apply "Entry"  to br_tlt.
            Return no-apply.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_reok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_reok c-wins
ON CHOOSE OF bu_reok IN FRAME fr_main /* OK */
DO:
    IF fi_filename = ""  THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_filename.
        Return no-apply.
    END.
    ELSE RUN proc_report2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_reok2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_reok2 c-wins
ON CHOOSE OF bu_reok2 IN FRAME fr_main /* OK */
DO:
    IF fi_filename3 = ""  THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_filename3.
        Return no-apply.
    END.
    ELSE DO: 
        RUN proc_import.
        RUN proc_report3. 
    END.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_sch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_sch c-wins
ON CHOOSE OF bu_sch IN FRAME fr_main /* Search */
DO:
    /*Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
/*         tlt.policy  >=   fi_polfr     And */
/*         tlt.policy  <=   fi_polto     And */
        /*tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  fi_compa        no-lock.  
            Apply "Entry"  to br_tlt.
            Return no-apply. */                            
            /*------------------------ 
            {&WINDOW-NAME}:hidden  =  Yes. 
            Run  wuw\wuwqtis1(Input  fi_trndatfr,
            fi_trndatto,
            fi_polfr,
            fi_polto,
            fi_producer).
            {&WINDOW-NAME}:hidden  =  No.                                               
            --------------------------*/
    If  cb_type =  "Name"  Then do:              /* name  */
        Open Query br_tlt 
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  fi_compa        And
            index(tlt.ins_name,fi_search) <> 0 no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_type  =  "SKKI"  Then do:   /* skki */
        Open Query br_tlt 
            For each tlt Use-index  tlt01     Where
            tlt.trndat        >=  fi_trndatfr And 
            tlt.trndat        <=  fi_trndatto And 
            tlt.genusr         =  fi_compa    And 
            tlt.comp_noti_tlt  =  fi_search   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_type  =  "KK-APP"  Then do:     /* KK app */
        Open Query br_tlt 
            For each tlt Use-index  tlt06       Where
            tlt.trndat         >=  fi_trndatfr  And
            tlt.trndat         <=  fi_trndatto  And
            tlt.genusr          =  fi_compa     And
            tlt.expotim         =  fi_search    no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_type  =  "Chassis"  Then do:     /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06       Where
            tlt.trndat         >=  fi_trndatfr  And
            tlt.trndat         <=  fi_trndatto  And
            tlt.genusr          =  fi_compa     And
            tlt.cha_no          =  fi_search    no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_type  =  "YES"  Then do:     /*   yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  fi_compa    And
            tlt.releas          =  "yes"       no-lock.
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.                                   
    ELSE If  cb_type  =  "NO"  Then do:     /*   no...*/
        Open Query br_tlt                  
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  fi_compa    And
            tlt.releas          =  "no"        no-lock.
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.   
    ELSE If  cb_type  =  "CANCEL"  Then do:     /*   CA...*/
        Open Query br_tlt                  
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  fi_compa    And
            index(tlt.releas,"CA") <> 0     no-lock.
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.  
    Else DO:
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_type c-wins
ON VALUE-CHANGED OF cb_type IN FRAME fr_main
DO:
    cb_type = INPUT cb_type.
    DISP cb_type WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compa c-wins
ON LEAVE OF fi_compa IN FRAME fr_main
DO:
    fi_compa = CAPS( INPUT fi_compa).
    DISP fi_compa WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename c-wins
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
    fi_filename = INPUT fi_filename.
    DISP fi_filename WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename2 c-wins
ON LEAVE OF fi_filename2 IN FRAME fr_main
DO:
    fi_filename2     = INPUT fi_filename2.
    DISP fi_filename2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename3 c-wins
ON LEAVE OF fi_filename3 IN FRAME fr_main
DO:
    fi_filename3 = INPUT fi_filename3.
    DISP fi_filename3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
    fi_search     =  Input  fi_search.
    Disp fi_search  with frame fr_main.

  /* comment by A61-0335 ................
    If  ra_choice =  1  Then do:              /* name  */
        Open Query br_tlt 
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  fi_compa        And
            index(tlt.ins_name,fi_search) <> 0 no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  2  Then do:    /* skki */
        Open Query br_tlt 
            For each tlt Use-index  tlt01     Where
            tlt.trndat        >=  fi_trndatfr And 
            tlt.trndat        <=  fi_trndatto And 
            tlt.genusr         =  fi_compa    And 
            tlt.comp_noti_tlt  =  fi_search   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  ra_choice  =  3  Then do:     /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06       Where
            tlt.trndat         >=  fi_trndatfr  And
            tlt.trndat         <=  fi_trndatto  And
            tlt.genusr          =  fi_compa     And
            tlt.cha_no          =  fi_search    no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  4  Then do:     /*   yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  fi_compa    And
            tlt.releas          =  "yes"       no-lock.
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.                                   
    ELSE If  ra_choice  =  5  Then do:     /*   no...*/
        Open Query br_tlt                  
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  fi_compa    And
            tlt.releas          =  "no"        no-lock.
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.  
    ... end A61-0335.......*/
    /* create by A61-0335 */
    If  cb_type =  "Name"  Then do:              /* name  */
        Open Query br_tlt 
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  fi_compa        And
            index(tlt.ins_name,fi_search) <> 0 no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_type  =  "SKKI"  Then do:   /* skki */
        Open Query br_tlt 
            For each tlt Use-index  tlt01     Where
            tlt.trndat        >=  fi_trndatfr And 
            tlt.trndat        <=  fi_trndatto And 
            tlt.genusr         =  fi_compa    And 
            tlt.comp_noti_tlt  =  fi_search   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_type  =  "KK-APP"  Then do:     /* KK app */
        Open Query br_tlt 
            For each tlt Use-index  tlt06       Where
            tlt.trndat         >=  fi_trndatfr  And
            tlt.trndat         <=  fi_trndatto  And
            tlt.genusr          =  fi_compa     And
            tlt.expotim         =  fi_search    no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_type  =  "Chassis"  Then do:     /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06       Where
            tlt.trndat         >=  fi_trndatfr  And
            tlt.trndat         <=  fi_trndatto  And
            tlt.genusr          =  fi_compa     And
            tlt.cha_no          =  fi_search    no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_type  =  "YES"  Then do:     /*   yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  fi_compa    And
            tlt.releas          =  "yes"       no-lock.
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.                                   
    ELSE If  cb_type  =  "NO"  Then do:     /*   no...*/
        Open Query br_tlt                  
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  fi_compa    And
            tlt.releas          =  "no"        no-lock.
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.   
    ELSE If  cb_type  =  "CANCEL"  Then do:     /*   CA...*/
        Open Query br_tlt                  
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  fi_compa    And
            index(tlt.releas,"CA") <> 0     no-lock.
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.  
    /* end A61-0335 */
    Else DO:
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatfr c-wins
ON LEAVE OF fi_trndatfr IN FRAME fr_main
DO:
    fi_trndatfr      =  Input  fi_trndatfr.
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


&Scoped-define SELF-NAME ra_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_report c-wins
ON VALUE-CHANGED OF ra_report IN FRAME fr_main
DO:
  ra_report = INPUT ra_report.
  DISP ra_report WITH FRAM fr_main.
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
    gv_prgid = "wgwqukk1".
    gv_prog  = "Query & Update (KK-NEW co.,ltd.) ".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    ASSIGN 
        fi_compa    = "KK-NEW"
        fi_trndatfr = TODAY
        fi_trndatto = TODAY
        /*ra_choice   =  1 */ /*a61-0335*/
        cb_type     = "Name"  /*A61-0335*/
        ra_report   = 1.
    FOR EACH brstat.tlt WHERE 
        brstat.tlt.genusr    = fi_compa    AND
        brstat.tlt.rec_addr5 = ""          AND 
        brstat.tlt.ins_name  = "" .
        DELETE brstat.tlt.
    END.
    Disp fi_compa fi_trndatfr  fi_trndatto /*ra_choice */ cb_type /*a61-0335*/
          ra_report  with frame fr_main.
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    
    Rect-333:Move-to-top().
    Rect-338:Move-to-top().  
    RECT-346:Move-to-top(). 
   /* Rect-339:Move-to-top().   */ 
    
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
  DISPLAY cb_type fi_compa fi_trndatfr fi_trndatto fi_search fi_filename2 
          fi_filename3 ra_report fi_filename 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE cb_type fi_compa fi_trndatfr fi_trndatto bu_ok fi_search bu_sch 
         fi_filename2 bu_file fi_filename3 bu_reok2 ra_report fi_filename 
         bu_reok br_tlt bu_exit RECT-332 RECT-333 RECT-338 RECT-340 RECT-341 
         RECT-343 RECT-344 RECT-346 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cha_no c-wins 
PROCEDURE proc_cha_no :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEF VAR nv_chassis AS CHAR FORMAT "x(40)" INIT "".
DEF VAR nv_i             AS INTE INIT 0.
DEF VAR nv_l             AS INTE INIT 0.
DEF VAR ind              AS INTE INIT 0.

ASSIGN 
    nv_chassis = trim(wdetail.HCC_CHASSIS_NO)  
    nv_i = 0 
    ind  = 0
    nv_l = LENGTH(nv_chassis).
DO WHILE nv_i <= nv_l:
    ind = 0.
    ind = INDEX(nv_chassis,"/").
    IF ind <> 0 THEN DO:
        nv_chassis = TRIM (SUBSTRING(nv_chassis,1,ind - 1) + SUBSTRING(nv_chassis,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_chassis,"\").
    IF ind <> 0 THEN DO:
        nv_chassis = TRIM (SUBSTRING(nv_chassis,1,ind - 1) + SUBSTRING(nv_chassis,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_chassis,"-").
    IF ind <> 0 THEN DO:
        nv_chassis = TRIM (SUBSTRING(nv_chassis,1,ind - 1) + SUBSTRING(nv_chassis,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_chassis,".").
    IF ind <> 0 THEN DO:
        nv_chassis = TRIM (SUBSTRING(nv_chassis,1,ind - 1) + SUBSTRING(nv_chassis,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_chassis," ").
    IF ind <> 0 THEN DO:
        nv_chassis = TRIM (SUBSTRING(nv_chassis,1,ind - 1) + SUBSTRING(nv_chassis,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN 
    wdetail.HCC_CHASSIS_NO = nv_chassis.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_import c-wins 
PROCEDURE proc_import :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_filename2).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        /*comment by Kridtiya i. A55-0145 .
        wdetail.Cust_code      
        wdetail.Cust_name      
        wdetail.fin_no         
        wdetail.Ao_code        
        wdetail.Ao_name        
        wdetail.Cn_Runno_show  
        wdetail.Cn_Branch      
        wdetail.Bill_Address1  
        wdetail.Bill_Address2  
        wdetail.Bill_Address3  
        wdetail.Bill_Address4  
        wdetail.Bill_Zip       
        wdetail.Ins_code       
        wdetail.Cov_amt_F      
        wdetail.Cov_amt_DigF   
        wdetail.Vol_no         
        wdetail.comp_stk       
        wdetail.Eff_Date       
        wdetail.exp_date       
        wdetail.Paym_due       
        wdetail.Fixed_class    
        wdetail.With_Insure    
        wdetail.renew_type     
        wdetail.Vol_no_old     
        wdetail.Vol_Type       
        wdetail.Drive_Name1    
        wdetail.Drive_Name2    
        wdetail.Drive_Lic1     
        wdetail.Drive_lic2     
        wdetail.Drive_hbd1     
        wdetail.Drive_hbd2     
        wdetail.Driver_type    
        wdetail.Benefit_name   
        wdetail.Type_ins       
        wdetail.Receive_name   
        wdetail.Net_prem       
        wdetail.Net_prem_DigF  
        wdetail.Stamp          
        wdetail.stamp_dig      
        wdetail.vat_amt        
        wdetail.vat_amt_dig    
        wdetail.Tax_amt        
        wdetail.Tax_amt_dig    
        wdetail.Groos_F        
        wdetail.Groos_DigF     
        wdetail.Have_Tax       
        wdetail.Car_Brand      
        wdetail.Car_Model      
        wdetail.License_no     
        wdetail.Province       
        wdetail.Chasis_No      
        wdetail.Engin_No       
        wdetail.Car_Year       
        wdetail.Car_CC         
        wdetail.Car_weight     
        wdetail.Cov_1          
        wdetail.Cov_2          
        wdetail.Cov_3          
        wdetail.Cov_4          
        wdetail.Cov_5          
        wdetail.Cov_6          
        wdetail.Cov_7          
        wdetail.Cov_8          
        wdetail.Cov_9          
        wdetail.Cov_10         
        wdetail.Cov_11         
        wdetail.Cov_12         
        wdetail.Cov_13         
        wdetail.Cov_14         
        wdetail.Cov_15         
        wdetail.Cov_16         
        wdetail.Cov_17         
        wdetail.Cov_18         
        wdetail.Lot_no         
        wdetail.flag_insurance 
        wdetail.flag_free  .
        end...comment by Kridtiya i. A55-0145 ....*/
        wdetail.HC_PAYM_DATE        /*  HC_PAYM_DATE        25550327    */                                     
        wdetail.HCC_CUST_CODE       /*  HCC_CUST_CODE       0616690 */                                         
        wdetail.CUST_NAME           /*  CUST_NAME           นางวันดี ชีวา   */                                 
        wdetail.HV_INF_NO           /*  HV_INF_NO           KKIVT/12/04299  */                                 
        wdetail.HCC_CN_RUNNO_SHOW   /*  HCC_CN_RUNNO_SHOW   001555001045    */                                 
        wdetail.HC_CN_BRN           /*  HC_CN_BRN           0015    */                                         
        wdetail.CA_CONT_ADDR
        wdetail.CUST_HOUSE_NO       /*  CUST_HOUSE_NO       83  */                                             
        wdetail.CUST_VILLAGE        /*  CUST_VILLAGE        */                                                 
        wdetail.CUST_BUILDING       /*  CUST_BUILDING       */ 
        wdetail.CA_FLOOR
        wdetail.CUST_MOO            /*  CUST_MOO            1   */                                             
        wdetail.CUST_SOI            /*  CUST_SOI            */                                                 
        wdetail.CUST_STREET         /*  CUST_STREET         */                                                 
        wdetail.CUST_TAMBOL         /*  CUST_TAMBOL         สันทรายหลวง */                                     
        wdetail.CUST_AMPHUR         /*  CUST_AMPHUR         สันทราย */                                         
        wdetail.CUST_PROVINCE       /*  CUST_PROVINCE       เชียงใหม่   */                                     
        wdetail.CUST_ZIP            /*  CUST_ZIP            50210   */                                         
        wdetail.HV_INS_CODE         /*  HV_INS_CODE         B04 */                                             
        wdetail.HV_COV_AMT          /*  HV_COV_AMT          180000.00   */                                     
        wdetail.HV_VOL_NO           /*  HV_VOL_NO           */                                                 
        wdetail.HV_EFF_DATE         /*  HV_EFF_DATE         25550327    */                                     
        wdetail.HV_EXP_DATE         /*  HV_EXP_DATE         25560327    */                                     
        wdetail.HV_VOL_TYPE         /*  HV_VOL_TYPE         2   */                                             
        wdetail.HV_BENEFIT_NAME     /*  HV_BENEFIT_NAME     */                                                 
        wdetail.HV_RECEIVE_NAME     /*  HV_RECEIVE_NAME     ธนาคารเกียรตินาคิน จำกัด (มหาชน)(นางวันดี ชีวา) */ 
        wdetail.HV_NET_PREM         /*  HV_NET_PREM         1873.47 */                                         
        wdetail.HV_STAMP            /*  HV_STAMP            8.00    */                                         
        wdetail.HV_VAT              /*  HV_VAT              131.70  */                                         
        wdetail.HV_TAX_AMT          /*  HV_TAX_AMT          18.81   */                                         
        wdetail.HV_GROSS_PREM       /*  HV_GROSS_PREM       1994.36 */                                         
        wdetail.BRAND_NAME          /*  BRAND_NAME          Toyota  */                                         
        wdetail.MODEL_NAME          /*  MODEL_NAME                  */                                         
        wdetail.HCC_LICENSE_NO      /*  HCC_LICENSE_NO      บห 6197 */                                         
        wdetail.HCC_PROVINCE        /*  HCC_PROVINCE        เชียงใหม่   */                                     
        wdetail.HCC_CHASSIS_NO      /*  HCC_CHASSIS_NO      MR032LNF-005024937  */                             
        wdetail.HCC_ENGINE_NO       /*  HCC_ENGINE_NO       2L-9715182  */                                     
        wdetail.HCC_MODEL_YEAR      /*  HCC_MODEL_YEAR      2002    */                                         
        wdetail.HCC_CC              /*  HCC_CC              2400    */                                         
        wdetail.HCC_WEIGHT          /*  HCC_WEIGHT          0   */                                             
        wdetail.HV_CAR_FLAG         /*  HV_CAR_FLAG         F   */                                             
        wdetail.BRN_HOUSE_NO        /*  BRN_HOUSE_NO        33  */                                             
        wdetail.BRN_VILLAGE         /*  BRN_VILLAGE         */                                                 
        wdetail.BRN_BUILDING        /*  BRN_BUILDING        */                                                 
        wdetail.BRN_MOO             /*  BRN_MOO             */                                                 
        wdetail.BRN_SOI             /*  BRN_SOI             */                                                 
        wdetail.BRN_STREET          /*  BRN_STREET          เชียงใหม่-ลำปาง */                                 
        wdetail.BRN_TAMBOL          /*  BRN_TAMBOL          ช้างเผือก   */                                     
        wdetail.BRN_AMPHUR          /*  BRN_AMPHUR          เมืองเชียงใหม่  */                                 
        wdetail.BRN_PROVINCE        /*  BRN_PROVINCE        เชียงใหม่   */                                     
        wdetail.BRN_ZIP             /*  BRN_ZIP             50300       */                                                 
        wdetail.subCampaign         /*  subCampaign         K00     */ 
        wdetail.BIRTHDAY            /*Kridtiya i. A56-0021*/
        wdetail.CARD_ID             /*Kridtiya i. A56-0021*/
        wdetail.CARD_TYPE           /*Kridtiya i. A56-0021*/
        wdetail.ADDR_CON_ADDR       /*Kridtiya i. A56-0021*/
        wdetail.ADDR_HOUSE          /*Kridtiya i. A56-0021*/
        wdetail.ADDR_VILLAGE        /*Kridtiya i. A56-0021*/
        wdetail.ADDR_BUILDING       /*Kridtiya i. A56-0021*/
        wdetail.ADDR_FLOOR          /*Kridtiya i. A56-0021*/
        wdetail.ADDR_MOO            /*Kridtiya i. A56-0021*/
        wdetail.ADDR_SOI            /*Kridtiya i. A56-0021*/
        wdetail.ADDR_STREET         /*Kridtiya i. A56-0021*/
        wdetail.ADDR_TAMBOL         /*Kridtiya i. A56-0021*/
        wdetail.ADDR_AMPHUR         /*Kridtiya i. A56-0021*/
        wdetail.ADDR_PROVINCE       /*Kridtiya i. A56-0021*/
        wdetail.ADDR_ZIP            /*Kridtiya i. A56-0021*/
        wdetail.GENDER              /*A61-0335*/
        wdetail.NATION              /*A61-0335*/
        wdetail.STATUS_CODE         /*A61-0335*/
        wdetail.CAREER              /*A61-0335*/
        wdetail.CUSTTYPE            /*A61-0335*/
        wdetail.OFFICE_NAME         /*A61-0335*/
        wdetail.OFFICEADD           /*A61-0335*/
        wdetail.OFFICETEL           /*A61-0335*/
        wdetail.OFFICEMOBILE        /*A61-0335*/
        wdetail.KKapp.              /*A61-0335*/
END.            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report2 c-wins 
PROCEDURE proc_report2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR   n_record AS  INTE INIT   0.
DEF VAR   n_add1   AS  CHAR INIT  "" .
DEF VAR   n_add2   AS  CHAR INIT  "" .
DEF VAR   n_add3   AS  CHAR INIT  "" .
DEF VAR   n_add4   AS  CHAR INIT  "" .
DEF VAR   n_add5   AS  CHAR INIT  "" .
ASSIGN 
    n_record = 0 .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

OUTPUT TO VALUE(fi_filename). 
EXPORT DELIMITER "|" 
    "บริษัทเงินทุน ธนาคารเกียรตินาคิน จำกัด (มหาชน) ." .
EXPORT DELIMITER "|" 
    "วันที่รับแจ้ง   "              
    "วันที่รับเงินค่าเบิ้ยประกัน "    
    "รายชื่อบริษัทประกันภัย  "          
    "รหัสสาขา   "                    
    "สาขา KK "                        
    "เลขที่สัญญาเช่าซื้อ "            
    "เลขที่กรมธรรม์เดิม  "              
    "เลขรับเเจ้ง "                      
    "Campaign    "                      
    "Sub Campaign "                     
    "ประเภทการแถม "                  
    "บุคคล/นิติบุคคล"               
    "คำนำหน้าชื่อ"               
    "ชื่อผู้เอาประกัน"           
    "นามสกุลผู้เอาประกัน"
    "บ้านเลขที่         "
    "หมู่ที่            "
    "อาคาร/หมู่บ้าน     "
    "ซอย                "
    "ถนน                "
    "ตำบล/แขวง          "                                   
    "อำเภอ/ เขต         "                                   
    "จังหวัด            "                                   
    "รหัสไปรษณีย์       "                                   
    "ประเภทความคุ้มครอง "                                 
    "ประเภทการซ่อม      "                           
    "วันเริ่มคุ้มครอง       "                            
    "วันสิ้นสุดคุ้มครอง     "                            
    "รหัสรถ                 "                              
    "ประเภทประกันภัยรถยนต์  "                               
    "ชื่อยี่ห้อรถ           "                              
    "รุ่นรถ                 "
    "New/Used        "               
    "เลขทะเบียน      "                
    "จังหวัดที่ออกเลขทะเบียน"       
    "เลขที่ตัวถัง           "        
    "เลขที่เครื่องยนต์      "        
    "ปีรถยนต์               "        
    "ซีซี                   "        
    "น้ำหนัก/      ตัน     "           
    "ทุนประกันปี 1 /ต่ออายุ"           
    "เบี้ยรวมภาษีและอากรปี 1/ต่ออายุ"
    "ทุนประกันปี 2                    "
    "เบี้ยรวมภาษีและอากรปี 2           "
    "เวลารับแจ้ง                "    
    "เลขเครื่องหมายตาม พ.ร.บ.        "
    "วันคุ้มครอง(พ.ร.บ)เริ่มต้น      "
    "วันคุ้มครอง(พ.ร.บ)สิ้นสุด       "
    "เบี้ยรวมภาษีและอากร (พ.ร.บ)     "  
    "ชื่อเจ้าหน้าที่รับแจ้ง          "
    "หมายเหตุ / เบี้ยแถมชื่อดิลเลอร์ "
    "ผู้ขับขี่ที่ 1                  "
    "วันเกิดผู้ขับขี่ที่ 1           "
    "ผู้ขับขี่ที่ 2                  "
    "วันเกิดผู้ขับขี่ที่ 2           "
    "ชื่อ - สกุล (ใบเสร็จ/ใบกำกับภาษี)"
    "ที่อยู่ (ใบเสร็จ/ใบกำกับภาษี)"    
    ""                                      
    "ข้อมูลจากระบบ"  
    "KK Application "    /*a61-0335*/  
    "Status Release " .  /*a61-0335*/

FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.genusr         = fi_compa        no-lock.  
    IF      (ra_report = 1) AND (tlt.releas = "no") THEN NEXT.
    ELSE IF (ra_report = 2) AND (tlt.releas = "yes") THEN NEXT.
    ELSE IF (ra_report = 3) AND INDEX(tlt.releas,"CA") = 0 THEN NEXT. /*a61-0335*/

    ASSIGN n_add1 =  tlt.ins_addr1.
    IF index(n_add1,"ถนน") <> 0 THEN DO:
        ASSIGN n_add5 = trim(substr(n_add1,index(n_add1,"ถนน") + 3 )) 
               n_add1 = substr(n_add1,1,index(n_add1,"ถนน") - 1 ).
    END.
    ELSE ASSIGN n_add5 = "".

    IF index(n_add1,"ซอย") <> 0 THEN DO:
        ASSIGN n_add4 = trim(substr(n_add1,index(n_add1,"ซอย") + 3)) 
               n_add1 = substr(n_add1,1,index(n_add1,"ซอย") - 1 ).
    END.
    ELSE ASSIGN n_add4 = "".

    IF index(n_add1,"หมู่บ้าน") <> 0 THEN DO:
        ASSIGN n_add3 = trim(substr(n_add1,index(n_add1,"หมู่บ้าน") + 8)) 
               n_add1 = substr(n_add1,1,index(n_add1,"หมู่บ้าน") - 1 ).
    END.
    ELSE ASSIGN n_add3 = "".

    IF index(n_add1,"หมู่") <> 0 THEN DO:
        ASSIGN n_add2 = trim(substr(n_add1,index(n_add1,"หมู่") + 4)) 
               n_add1 = substr(n_add1,1,index(n_add1,"หมู่") - 1 ).
    END.
    ELSE ASSIGN n_add2 = "".

    IF index(n_add1,"เลขที่") <> 0 THEN DO:
        ASSIGN n_add1 = trim(substr(n_add1,index(n_add1,"เลขที่") + 6)).
    END.
    ELSE ASSIGN n_add1 = "".

    ASSIGN n_record = n_record + 1.
    EXPORT DELIMITER "|" 
        string(tlt.datesent,"99/99/9999")       FORMAT "x(10)"    /*1  วันที่รับแจ้ง   */                        
        IF (string(tlt.dat_ins_noti) = "") OR (tlt.dat_ins_noti = ? ) THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(15)"   /*2  วันที่รับเงินค่าเบิ้ยประกัน */            
        tlt.nor_usr_ins    FORMAT "x(50)"    /*3  รายชื่อบริษัทประกันภัย  */ 
        tlt.nor_usr_tlt    FORMAT "x(10)"    /*6  รหัสสาขา    */                            
        tlt.comp_usr_tlt   FORMAT "x(40)"    /*7  สาขา KK */ 
        tlt.nor_noti_tlt   FORMAT "x(25)"    /*4  เลขที่สัญญาเช่าซื้อ */                    
        tlt.nor_noti_ins   FORMAT "x(20)"    /*5  เลขที่กรมธรรม์เดิม  */
        tlt.comp_noti_tlt  FORMAT "x(10)"    /*8  เลขรับเเจ้ง */                            
        tlt.lotno          FORMAT "x(10)"    /*9  Campaign    */
        tlt.lince3         FORMAT "x(10)"    /*10 Sub Campaign */
        tlt.comp_pol       FORMAT "x(10)"    /*11 ประเภทการแถม */
        tlt.safe2          FORMAT "x(10)"    /*11 บุคคล/นิติบุคคล */                        
        IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,1,INDEX(tlt.ins_name," ") - 1)  ELSE tlt.ins_name    /*12 คำนำหน้าชื่อ    */                        
        IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1,R-INDEX(tlt.ins_name," ") - INDEX(tlt.ins_name," ") - 1 ) ELSE tlt.ins_name  
        IF INDEX(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,r-INDEX(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name         /*14 นามสกุลผู้เอาประกัน */  
        n_add1
        n_add2
        n_add3
        n_add4
        n_add5
        tlt.ins_addr2      /*21 ตำบล/แขวง    */                   
        tlt.ins_addr3      /*22 อำเภอ/ เขต   */                   
        tlt.ins_addr4      /*23 จังหวัด      */                         
        tlt.ins_addr5      /*24 รหัสไปรษณีย์ */
        tlt.safe3          /*25 ประเภทความคุ้มครอง   */   
        tlt.stat           /*26 ประเภทการซ่อม   */                        
        tlt.nor_effdat     /*27 วันเริ่มคุ้มครอง    */                    
        tlt.expodat        /*28 วันสิ้นสุดคุ้มครอง  */                    
        tlt.subins         /*29 รหัสรถ  */                                
        tlt.filler2        /*30 ประเภทประกันภัยรถยนต์   */                
        tlt.brand          /*31 ชื่อยี่ห้อรถ    */                        
        tlt.model          /*32 รุ่นรถ  */
        tlt.filler1  FORMAT "x(50)"       /*33 New/Used        */                            
        IF INDEX(trim(tlt.lince1)," ") <> 0 THEN  substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1 )  ELSE tlt.lince1       /*34 เลขทะเบียน      */ 
        IF INDEX(trim(tlt.lince1)," ") <> 0 THEN  substr(tlt.lince1,R-INDEX(tlt.lince1," ") + 1 )    ELSE tlt.lince1          /*35  จังหวัดที่ออกเลขทะเบียน*/ 
        tlt.cha_no         /*36  เลขที่ตัวถัง          */                         
        tlt.eng_no         /*37  เลขที่เครื่องยนต์     */                     
        tlt.lince2         /*38  ปีรถยนต์              */                         
        tlt.cc_weight      /*39  ซีซี                  */                         
        tlt.colorcod       /*40  น้ำหนัก/      ตัน     */                     
        tlt.comp_coamt     /*41  ทุนประกันปี 1 /ต่ออายุ*/                 
        tlt.comp_grprm     /*42  เบี้ยรวมภาษีและอากรปี 1 /ต่ออายุ*/       
        tlt.nor_coamt      /*43  ทุนประกันปี 2                   */       
        tlt.nor_grprm      /*44  เบี้ยรวมภาษีและอากรปี 2         */
        tlt.gentim FORMAT "x(15)"        /*45  เวลารับแจ้ง                 */    
        tlt.comp_sck       /*46  เลขเครื่องหมายตาม พ.ร.บ.        */
        IF (string(tlt.comp_effdat) = "?") OR (tlt.comp_effdat = ? ) THEN "" ELSE string(tlt.comp_effdat,"99/99/9999") FORMAT "x(15)"   /*47  วันคุ้มครอง(พ.ร.บ)เริ่มต้น      */             
        IF (string(tlt.gendat) = "?") OR (tlt.gendat = ? ) THEN "" ELSE string(tlt.gendat,"99/99/9999") FORMAT "x(15)"         /*48  วันคุ้มครอง(พ.ร.บ)สิ้นสุด       */
        tlt.comp_noti_ins  /*49  เบี้ยรวมภาษีและอากร (พ.ร.บ)   */               
        tlt.comp_usr_ins   /*50  ชื่อเจ้าหน้าที่รับแจ้ง          */             
        tlt.old_cha        /*51  หมายเหตุ / เบี้ยแถมชื่อดิลเลอร์ */             
        tlt.dri_name1      /*52  ผู้ขับขี่ที่ 1                  */             
        tlt.dri_no1        /*53  วันเกิดผู้ขับขี่ที่ 1           */             
        tlt.dri_name2      /*54  ผู้ขับขี่ที่ 2                  */             
        tlt.dri_no1        /*55  วันเกิดผู้ขับขี่ที่ 2           */             
        tlt.rec_name       /*56  ชื่อ - สกุล (ใบเสร็จ/ใบกำกับภาษี)*/            
        tlt.rec_addr1      /*57  ที่อยู่ (ใบเสร็จ/ใบกำกับภาษี)    */ 
        tlt.safe1          
        tlt.OLD_eng        /*58 ข้อมูลจากระบบ  */ 
        tlt.expotim FORMAT "x(20)"        /* kkapp */ /*A61-0335*/
        tlt.releas .         /*A61-0335*/

END.   /*  end  wdetail  */
Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report3 c-wins 
PROCEDURE proc_report3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_filename3,length(fi_filename3) - 3,4) <>  ".csv"  THEN 
    fi_filename3  =  Trim(fi_filename3) + ".csv"  .

OUTPUT TO VALUE(fi_filename3). 
EXPORT DELIMITER "|" 
    "บริษัทเงินทุน ธนาคารเกียรตินาคิน จำกัด (มหาชน) ." .
EXPORT DELIMITER "|"
    "Create Date "  
    "Create Date "  
    "รายชื่อบริษัทประกันภัย"
    "รหัสสาขา KK "         
    "สาขา KK     "         
    "เลขที่สัญญาเช่าซื้อ"   
    "เลขที่กรมธรรม์เดิม "   
    "เลขที่รับแจ้ง  "   
    "Campaign       "   
    "Sub Campaign   "   
    "ประเภทการแถม   "   
    "บุคคล/นิติบุคคล"   
    "คำนำหน้าชื่อผู้เอาประกัน  "
    "ชื่อผู้เอาประกัน     " 
    "นามสกุลผู้เอาประกัน  " 
    "บ้านเลขที่     "   
    "หมู่ที่        "   
    "อาคาร/หมู่บ้าน "   
    "ซอย            "   
    "ถนน            "   
    "ตำบล/แขวง      "   
    "อำเภอ/เขต      "   
    "จังหวัด        "   
    "รหัสไปรษณีย์   "   
    "ประเภทความคุ้มครอง     "   
    "ประเภทการซ่อม   "      
    "วันที่คุ้มครองเริ่มต้น "   
    "วันที่คุ้มครองสิ้นสุด  "   
    "รหัสรถ          "      
    "ประเภทประกันภัยรถยนต์  "   
    "ชื่อยี่ห้อรถ    "      
    "รุ่นรถ          "      
    "New/Used        "      
    "เลขทะเบียน      "      
    "จังหวัดที่ออกเลขทะเบียน"   
    "เลขที่ตัวถัง     " 
    "เลขที่เครื่องยนต์" 
    "ปีรถยนต์         " 
    "ซีซี             " 
    "น้ำหนัก/ตัน      " 
    "ทุนประกันปี 1 /ต่ออายุ    "
    "เบี้ยรวมภาษีและอากรปี 1 /ต่ออายุ"
    "ทุนประกันปี 2            " 
    "เบี้ยรวมภาษีและอากรปี 2  " 
    "เวลารับแจ้ง              " 
    "เลขเครื่องหมายตาม พ.ร.บ. " 
    "วันคุ้มครอง(พ.ร.บ)เริ่มต้น "   
    "วันคุ้มครอง(พ.ร.บ)สิ้นสุด  "   
    "เบี้ยรวมภาษีและอากร (พ.ร.บ)"   
    "ชื่อเจ้าหน้าที่รับแจ้ง"   
    "หมายเหตุ              "   
    "ผู้ขับขี่ที่ 1        "   
    "วันเกิดผู้ขับขี่ที่ 1 "   
    "ผู้ขับขี่ที่ 2        "   
    "วันเกิดผู้ขับขี่ที่ 2 "   
    "ชื่อ - สกุล (ใบเสร็จ/ใบกำกับภาษี)"
    "ที่อยู่ (ใบเสร็จ/ใบกำกับภาษี)    "
    ""
    "ข้อมูลจากระบบ "
    "BIRTHDAY      "
    "CARD_ID       "
    "CARD_TYPE     "
    "ADDR_CON_ADDR "
    "ADDR_HOUSE    "
    "ADDR_VILLAGE  "
    "ADDR_BUILDING "
    "ADDR_FLOOR    "
    "ADDR_MOO      "
    "ADDR_SOI      "
    "ADDR_STREET   "
    "ADDR_TAMBOL   "
    "ADDR_AMPHUR   "
    "ADDR_PROVINCE "
    "ADDR_ZIP      "
    "KKapp.        ".

ASSIGN n_rec = 0 .
FOR EACH wdetail NO-LOCK.
    IF wdetail.HCC_CHASSIS_NO = ""  THEN NEXT.
    ELSE RUN proc_cha_no.
    FIND LAST tlt Use-index  tlt06  Where
        tlt.cha_no =   wdetail.HCC_CHASSIS_NO  AND
        tlt.genusr =   fi_compa           NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL tlt THEN DO:
        n_rec = 1 . /*A61-0335 */
        /* comment by A61-0335..
        IF n_rec = 0  THEN DO:
            If  substr(fi_filename3,length(fi_filename3) - 3,4) <>  ".csv"  THEN 
                fi_filename3  =  Trim(fi_filename3) + ".csv"  .
            OUTPUT TO VALUE(fi_filename3). 
            n_rec = 1.
        END.
        ... end A61-0335 ...*/
       /*comment by Kridtiya i. A55-0095 ...........
        ASSIGN n_add1 =  tlt.ins_addr1.
        IF index(n_add1,"ถนน") <> 0 THEN 
            ASSIGN n_add5 = trim(substr(n_add1,index(n_add1,"ถนน") + 3 )) 
            n_add1 = substr(n_add1,1,index(n_add1,"ถนน") - 1 ). 
        ELSE ASSIGN n_add5 = "".
        IF index(n_add1,"ซอย") <> 0 THEN 
            ASSIGN n_add4 = trim(substr(n_add1,index(n_add1,"ซอย") + 3)) 
            n_add1 = substr(n_add1,1,index(n_add1,"ซอย") - 1 ).
        ELSE ASSIGN n_add4 = "".
        IF index(n_add1,"หมู่บ้าน") <> 0 THEN 
            ASSIGN n_add3 = trim(substr(n_add1,index(n_add1,"หมู่บ้าน") + 8)) 
            n_add1 = substr(n_add1,1,index(n_add1,"หมู่บ้าน") - 1 ).
        ELSE ASSIGN n_add3 = "".
        IF index(n_add1,"หมู่") <> 0 THEN 
            ASSIGN n_add2 = trim(substr(n_add1,index(n_add1,"หมู่") + 4)) 
            n_add1 = substr(n_add1,1,index(n_add1,"หมู่") - 1 ).
        ELSE ASSIGN n_add2 = "".
        IF index(n_add1,"เลขที่") <> 0 THEN 
            ASSIGN n_add1 = trim(substr(n_add1,index(n_add1,"เลขที่") + 6)).
        ELSE ASSIGN n_add1 = "". 
        by Kridtiya i. A55-0095 ........... */
        /*Add by Kridtiya i. A55-0095 ...........*/
        /*      CUST_HOUSE_NO       83  */
        /*      CUST_VILLAGE            */
        /*      CUST_BUILDING           */
        /*      CUST_MOO                1          */
        /*      CUST_SOI                   */
        /*      CUST_STREET                */
        /*      CUST_TAMBOL             สันทรายหลวง     */
        /*      CUST_AMPHUR             สันทราย */
        /*      CUST_PROVINCE       เชียงใหม่   */
        /*      CUST_ZIP                50210   */


        ASSIGN 
            n_add1 = ""
            /*Add  by Kridtiya i. A55-0145 .*/
           /* comment by A61-0335..........
            n_add1 = IF trim(wdetail.CUST_VILLAGE) = "" THEN trim(wdetail.CUST_BUILDING)
                     ELSE trim(wdetail.CUST_VILLAGE) 
            n_add1 = IF trim(wdetail.CUST_BUILDING ) = "" THEN ""
                     ELSE  n_add1 + " อาคาร" + trim(wdetail.CUST_BUILDING ) 
            n_add1 = IF TRIM(wdetail.CA_FLOOR) = "" THEN n_add1
                     ELSE  trim(n_add1) + " "   + TRIM(wdetail.CA_FLOOR) . 
           ... end A61-0335*/ 
            /* create by A61-0335*/
            n_add1 = IF trim(wdetail.CUST_VILLAGE) = "" THEN ""
                     ELSE "หมู่บ้าน" + trim(wdetail.CUST_VILLAGE) .
            n_add1 = IF trim(wdetail.CUST_BUILDING ) = "" THEN  n_add1 
                     ELSE  n_add1 + " อาคาร" + trim(wdetail.CUST_BUILDING ) .
            n_add1 = IF TRIM(wdetail.CA_FLOOR) = "" THEN n_add1
                     ELSE  trim(n_add1) + " ชั้น " + TRIM(wdetail.CA_FLOOR) .
            /* end A61-0335*/

        /*Add  by Kridtiya i. A55-0145 .*/
        /*comment by Kridtiya i. A55-0145 .
        n_add2 = ""
        n_add3 = ""
        n_add4 = ""
        n_add5 = ""
        n_add6 = ""
        n_add7 = ""
        end...comment by Kridtiya i. A55-0145 .*/
             
       /* IF wdetail.Bill_Address1 = ""  THEN
            ASSIGN wdetail.Bill_Address1 = wdetail.Bill_Address2 + " " + 
                                           wdetail.Bill_Address3.
        ASSIGN n_add1 = wdetail.Bill_Address1.
        IF index(n_add1,"อำเภอ") <> 0 THEN 
            ASSIGN n_add7 = trim(substr(n_add1,index(n_add1,"อำเภอ") + 5 )) 
            n_add1 = substr(n_add1,1,index(n_add1,"อำเภอ") - 1 ).
        ELSE IF index(n_add1,"อ.") <> 0 THEN 
            ASSIGN n_add7 = trim(substr(n_add1,index(n_add1,"อ.") + 2 )) 
            n_add1 = substr(n_add1,1,index(n_add1,"อ.") - 1 ).
        ELSE ASSIGN n_add7 = "".

        IF r-index(n_add1,"ต.") <> 0 THEN 
            ASSIGN n_add6 = trim(substr(n_add1,R-INDEX(n_add1,"ต.") + 2 )) 
            n_add1 = substr(n_add1,1,r-index(n_add1,"ต.") - 1 ). 
        ELSE IF R-INDEX(n_add1,"ตำบล") <> 0 THEN 
            ASSIGN n_add6 = trim(substr(n_add1,r-index(n_add1,"ตำบล") + 4 )) 
            n_add1 = substr(n_add1,1,r-index(n_add1,"ตำบล") - 1 ).
        ELSE ASSIGN n_add6 = "".

        IF index(n_add1,"ถนน") <> 0 THEN 
            ASSIGN n_add5 = trim(substr(n_add1,index(n_add1,"ถนน") + 3 )) 
            n_add1 = substr(n_add1,1,index(n_add1,"ถนน") - 1 ).
        ELSE IF index(n_add1,"ถ.") <> 0 THEN 
            ASSIGN n_add5 = trim(substr(n_add1,index(n_add1,"ถ.") + 2 )) 
            n_add1 = substr(n_add1,1,index(n_add1,"ถ.") - 1 ). 
        ELSE ASSIGN n_add5 = "".
        IF index(n_add1,"ซอย") <> 0 THEN 
            ASSIGN n_add4 = trim(substr(n_add1,index(n_add1,"ซอย") + 3)) 
            n_add1 = substr(n_add1,1,index(n_add1,"ซอย") - 1 ).
        ELSE IF index(n_add1,"ซ.") <> 0 THEN 
            ASSIGN n_add4 = trim(substr(n_add1,index(n_add1,"ซ.") + 3)) 
            n_add1 = substr(n_add1,1,index(n_add1,"ซ.") - 1 ).
        ELSE ASSIGN n_add4 = "".

        IF index(n_add1,"บ้าน") <> 0 THEN 
            ASSIGN n_add3 = trim(substr(n_add1,index(n_add1,"บ้าน") + 4)) 
            n_add1 = substr(n_add1,1,index(n_add1,"บ้าน") - 1 ).
        ELSE IF index(n_add1,"อาคาร") <> 0 THEN 
            ASSIGN n_add3 = trim(substr(n_add1,index(n_add1,"อาคาร") + 5)) 
            n_add1 = substr(n_add1,1,index(n_add1,"อาคาร") - 1 ).
        ELSE ASSIGN n_add3 = "".

       IF index(n_add1,"หมู่") <> 0 THEN 
            ASSIGN n_add2 = trim(substr(n_add1,index(n_add1,"หมู่") + 4)) 
            n_add1 = substr(n_add1,1,index(n_add1,"หมู่") - 1 ).
       ELSE IF index(n_add1,"ม.") <> 0 THEN 
           ASSIGN n_add2 = trim(substr(n_add1,index(n_add1,"ม.") + 2)) 
            n_add1 = substr(n_add1,1,index(n_add1,"ม.") - 1 ).
       ELSE ASSIGN n_add2 = "".

       IF index(n_add1,"เลขที่") <> 0 THEN 
           ASSIGN n_add1 = trim(substr(n_add1,index(n_add1,"เลขที่") + 6)).*/

        EXPORT DELIMITER "|" 
            string(tlt.datesent,"99/99/9999")       FORMAT "x(10)"    /*1  วันที่รับแจ้ง   */                        
            IF (string(tlt.dat_ins_noti) = "") OR (tlt.dat_ins_noti = ? ) THEN "" ELSE string(date(tlt.dat_ins_noti),"99/99/9999") FORMAT "x(15)"   /*2  วันที่รับเงินค่าเบิ้ยประกัน */            
            tlt.nor_usr_ins    FORMAT "x(50)"    /*3  รายชื่อบริษัทประกันภัย  */ 
            tlt.nor_usr_tlt    FORMAT "x(10)"    /*6  รหัสสาขา    */                            
            tlt.comp_usr_tlt   FORMAT "x(40)"    /*7  สาขา KK */ 
            wdetail.HCC_CN_RUNNO_SHOW   FORMAT "x(25)"    /*4  เลขที่สัญญาเช่าซื้อ */                    
            tlt.nor_noti_ins   FORMAT "x(20)"    /*5  เลขที่กรมธรรม์เดิม  */
            tlt.comp_noti_tlt  FORMAT "x(25)"    /*8  เลขรับเเจ้ง */                            
            tlt.lotno          FORMAT "x(10)"    /*9  Campaign    */
            tlt.lince3         FORMAT "x(10)"    /*10 Sub Campaign */
            tlt.comp_pol       FORMAT "x(10)"    /*11 ประเภทการแถม */
            tlt.safe2          FORMAT "x(10)"    /*11 บุคคล/นิติบุคคล */                        
            IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,1,INDEX(tlt.ins_name," ") - 1)  ELSE tlt.ins_name    /*12 คำนำหน้าชื่อ    */                        
            IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1,R-INDEX(tlt.ins_name," ") - INDEX(tlt.ins_name," ") - 1 ) ELSE tlt.ins_name  
            IF INDEX(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,r-INDEX(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name         /*14 นามสกุลผู้เอาประกัน */  
            /*A55-0145
            n_add1 
            n_add2 
            n_add3 
            n_add4 
            n_add5
            n_add6
            n_add7
            wdetail.Bill_Address4
            wdetail.Bill_Zip  
            A55-0145 */
            /*A55-0145*/
            wdetail.CUST_HOUSE_NO
            n_add1
            wdetail.CUST_MOO      
            wdetail.CUST_SOI      
            wdetail.CUST_STREET                        
            wdetail.CUST_TAMBOL                        
            wdetail.CUST_AMPHUR                              
            wdetail.CUST_PROVINCE      
            wdetail.CUST_ZIP
            /*A55-0145*/
            tlt.safe3          /*25 ประเภทความคุ้มครอง   */   
            tlt.stat           /*26 ประเภทการซ่อม   */                        
            string(tlt.nor_effdat,"99/99/9999")     /*27 วันเริ่มคุ้มครอง    */                    
            string(tlt.expodat,"99/99/9999")        /*28 วันสิ้นสุดคุ้มครอง  */                   
            tlt.subins         /*29 รหัสรถ  */                                
            tlt.filler2        /*30 ประเภทประกันภัยรถยนต์   */                
            tlt.brand          /*31 ชื่อยี่ห้อรถ    */                        
            tlt.model          /*32 รุ่นรถ  */
            tlt.filler1  FORMAT "x(50)"       /*33 New/Used        */                            
            IF INDEX(trim(tlt.lince1)," ") <> 0 THEN  substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1 )  ELSE tlt.lince1       /*34 เลขทะเบียน      */ 
            IF INDEX(trim(tlt.lince1)," ") <> 0 THEN  substr(tlt.lince1,R-INDEX(tlt.lince1," ") + 1 )    ELSE tlt.lince1          /*35  จังหวัดที่ออกเลขทะเบียน*/ 
            tlt.cha_no         /*36  เลขที่ตัวถัง          */                         
            tlt.eng_no         /*37  เลขที่เครื่องยนต์     */                     
            tlt.lince2         /*38  ปีรถยนต์              */                         
            tlt.cc_weight      /*39  ซีซี                  */                         
            tlt.colorcod       /*40  น้ำหนัก/      ตัน     */                     
            tlt.comp_coamt     /*41  ทุนประกันปี 1 /ต่ออายุ*/                 
            tlt.comp_grprm     /*42  เบี้ยรวมภาษีและอากรปี 1 /ต่ออายุ*/       
            tlt.nor_coamt      /*43  ทุนประกันปี 2                   */       
            tlt.nor_grprm      /*44  เบี้ยรวมภาษีและอากรปี 2         */
            tlt.gentim FORMAT "x(15)"         /*45  เวลารับแจ้ง                 */    
            tlt.comp_sck       /*46  เลขเครื่องหมายตาม พ.ร.บ.        */
            IF (string(tlt.comp_effdat) = "?") OR (tlt.comp_effdat = ? ) THEN "" ELSE string(DATE(tlt.comp_effdat),"99/99/9999") FORMAT "x(15)"   /*47  วันคุ้มครอง(พ.ร.บ)เริ่มต้น      */             
            IF (string(tlt.gendat) = "?") OR (tlt.gendat = ? ) THEN "" ELSE string(DATE(tlt.gendat),"99/99/9999") FORMAT "x(15)"         /*48  วันคุ้มครอง(พ.ร.บ)สิ้นสุด       */
            tlt.comp_noti_ins  /*49  เบี้ยรวมภาษีและอากร (พ.ร.บ)   */               
            tlt.comp_usr_ins   /*50  ชื่อเจ้าหน้าที่รับแจ้ง          */             
            tlt.old_cha        /*51  หมายเหตุ / เบี้ยแถมชื่อดิลเลอร์ */             
            tlt.dri_name1      /*52  ผู้ขับขี่ที่ 1                  */             
            tlt.dri_no1        /*53  วันเกิดผู้ขับขี่ที่ 1           */             
            tlt.dri_name2      /*54  ผู้ขับขี่ที่ 2                  */             
            tlt.dri_no1        /*55  วันเกิดผู้ขับขี่ที่ 2           */             
            tlt.rec_name       /*56  ชื่อ - สกุล (ใบเสร็จ/ใบกำกับภาษี)*/            
            tlt.rec_addr1      /*57  ที่อยู่ (ใบเสร็จ/ใบกำกับภาษี)    */ 
            tlt.safe1          
            tlt.OLD_eng  
            wdetail.BIRTHDAY         /*Kridtiya i. A56-0021*/    
            wdetail.CARD_ID          /*Kridtiya i. A56-0021*/ 
            wdetail.CARD_TYPE        /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_CON_ADDR    /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_HOUSE       /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_VILLAGE     /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_BUILDING    /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_FLOOR       /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_MOO         /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_SOI         /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_STREET      /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_TAMBOL      /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_AMPHUR      /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_PROVINCE    /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_ZIP        /*58 ข้อมูลจากระบบ  */ /*Kridtiya i. A56-0021*/
            IF tlt.expotim = "" THEN trim(wdetail.KKapp) ELSE tlt.expotim .    /*A61-0335*/

    END.    /*  end  wdetail  */
    ELSE RUN proc_report4. 
END.        /*wdetail         */
IF n_rec = 0  THEN  Message "Not found data Match File is Emty !!! "  View-as alert-box.
ELSE Message "Export data Match File Complete "  View-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report4 c-wins 
PROCEDURE proc_report4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FIND LAST tlt Use-index  tlt05        Where
    index(wdetail.CUST_NAME,substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1 )) <> 0 AND 
    tlt.genusr   =  fi_compa          NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL tlt THEN DO:
        /* comment by A61-0335
        IF n_rec = 0  THEN DO:
            If  substr(fi_filename3,length(fi_filename3) - 3,4) <>  ".csv"  THEN 
                fi_filename3  =  Trim(fi_filename3) + ".csv"  .
            OUTPUT TO VALUE(fi_filename3). 
            n_rec = 1.
        END.
        .. end A61-0335*/
        n_rec = 1.
        ASSIGN 
            n_add1 = ""
            /* comment by A61-0335....
            n_add1 = IF trim(wdetail.CUST_VILLAGE) = "" THEN trim(wdetail.CUST_BUILDING)
                     ELSE trim(wdetail.CUST_VILLAGE) 
            n_add1 = IF trim(wdetail.CUST_BUILDING ) = "" THEN ""
                     ELSE  n_add1 + " อาคาร" + trim(wdetail.CUST_BUILDING )
            end A61-0335.... .*/
             /* create by A61-0335*/
            n_add1 = IF trim(wdetail.CUST_VILLAGE) = "" THEN ""
                     ELSE "หมู่บ้าน" + trim(wdetail.CUST_VILLAGE) .
            n_add1 = IF trim(wdetail.CUST_BUILDING ) = "" THEN  n_add1 
                     ELSE  n_add1 + " อาคาร" + trim(wdetail.CUST_BUILDING ) .
            n_add1 = IF TRIM(wdetail.CA_FLOOR) = "" THEN n_add1
                     ELSE  trim(n_add1) + " ชั้น " + TRIM(wdetail.CA_FLOOR) .
            /* end A61-0335*/
    
        EXPORT DELIMITER "|" 
            string(tlt.datesent,"99/99/9999")       FORMAT "x(10)"    /*1  วันที่รับแจ้ง   */                        
            IF (string(tlt.dat_ins_noti) = "") OR (tlt.dat_ins_noti = ? ) THEN "" ELSE string(date(tlt.dat_ins_noti),"99/99/9999") FORMAT "x(15)"   /*2  วันที่รับเงินค่าเบิ้ยประกัน */            
            tlt.nor_usr_ins    FORMAT "x(50)"    /*3  รายชื่อบริษัทประกันภัย  */ 
            tlt.nor_usr_tlt    FORMAT "x(10)"    /*6  รหัสสาขา    */                            
            tlt.comp_usr_tlt   FORMAT "x(40)"    /*7  สาขา KK */ 
            wdetail.HCC_CN_RUNNO_SHOW   FORMAT "x(25)"    /*4  เลขที่สัญญาเช่าซื้อ */                    
            tlt.nor_noti_ins   FORMAT "x(20)"    /*5  เลขที่กรมธรรม์เดิม  */
            tlt.comp_noti_tlt  FORMAT "x(25)"    /*8  เลขรับเเจ้ง */                            
            tlt.lotno          FORMAT "x(10)"    /*9  Campaign    */
            tlt.lince3         FORMAT "x(10)"    /*10 Sub Campaign */
            tlt.comp_pol       FORMAT "x(10)"    /*11 ประเภทการแถม */
            tlt.safe2          FORMAT "x(10)"    /*11 บุคคล/นิติบุคคล */                        
            IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,1,INDEX(tlt.ins_name," ") - 1)  ELSE tlt.ins_name    /*12 คำนำหน้าชื่อ    */                        
            IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1,R-INDEX(tlt.ins_name," ") - INDEX(tlt.ins_name," ") - 1 ) ELSE tlt.ins_name  
            IF INDEX(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,r-INDEX(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name         /*14 นามสกุลผู้เอาประกัน */  
            wdetail.CUST_HOUSE_NO
            n_add1
            wdetail.CUST_MOO      
            wdetail.CUST_SOI      
            wdetail.CUST_STREET                        
            wdetail.CUST_TAMBOL                        
            wdetail.CUST_AMPHUR                              
            wdetail.CUST_PROVINCE      
            wdetail.CUST_ZIP
            /*A55-0145*/
            tlt.safe3          /*25 ประเภทความคุ้มครอง   */   
            tlt.stat           /*26 ประเภทการซ่อม   */                        
            string(tlt.nor_effdat,"99/99/9999")     /*27 วันเริ่มคุ้มครอง    */                    
            string(tlt.expodat,"99/99/9999")        /*28 วันสิ้นสุดคุ้มครอง  */                    
            tlt.subins         /*29 รหัสรถ  */                                
            tlt.filler2        /*30 ประเภทประกันภัยรถยนต์   */                
            tlt.brand          /*31 ชื่อยี่ห้อรถ    */                        
            tlt.model          /*32 รุ่นรถ  */
            tlt.filler1  FORMAT "x(50)"       /*33 New/Used        */                            
            IF INDEX(trim(tlt.lince1)," ") <> 0 THEN  substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1 )  ELSE tlt.lince1       /*34 เลขทะเบียน      */ 
            IF INDEX(trim(tlt.lince1)," ") <> 0 THEN  substr(tlt.lince1,R-INDEX(tlt.lince1," ") + 1 )    ELSE tlt.lince1          /*35  จังหวัดที่ออกเลขทะเบียน*/ 
            tlt.cha_no         /*36  เลขที่ตัวถัง          */                         
            tlt.eng_no         /*37  เลขที่เครื่องยนต์     */                     
            tlt.lince2         /*38  ปีรถยนต์              */                         
            tlt.cc_weight      /*39  ซีซี                  */                         
            tlt.colorcod       /*40  น้ำหนัก/      ตัน     */                     
            tlt.comp_coamt     /*41  ทุนประกันปี 1 /ต่ออายุ*/                 
            tlt.comp_grprm     /*42  เบี้ยรวมภาษีและอากรปี 1 /ต่ออายุ*/       
            tlt.nor_coamt      /*43  ทุนประกันปี 2                   */       
            tlt.nor_grprm      /*44  เบี้ยรวมภาษีและอากรปี 2         */
            tlt.gentim FORMAT "x(15)"         /*45  เวลารับแจ้ง                 */    
            tlt.comp_sck       /*46  เลขเครื่องหมายตาม พ.ร.บ.        */
            IF (string(tlt.comp_effdat) = "?") OR (tlt.comp_effdat = ? ) THEN "" ELSE string(date(tlt.comp_effdat),"99/99/9999") FORMAT "x(15)"   /*47  วันคุ้มครอง(พ.ร.บ)เริ่มต้น      */             
            IF (string(tlt.gendat) = "?") OR (tlt.gendat = ? ) THEN "" ELSE string(date(tlt.gendat),"99/99/9999") FORMAT "x(15)"         /*48  วันคุ้มครอง(พ.ร.บ)สิ้นสุด       */
            tlt.comp_noti_ins  /*49  เบี้ยรวมภาษีและอากร (พ.ร.บ)   */               
            tlt.comp_usr_ins   /*50  ชื่อเจ้าหน้าที่รับแจ้ง          */             
            tlt.old_cha        /*51  หมายเหตุ / เบี้ยแถมชื่อดิลเลอร์ */             
            tlt.dri_name1      /*52  ผู้ขับขี่ที่ 1                  */             
            tlt.dri_no1        /*53  วันเกิดผู้ขับขี่ที่ 1           */             
            tlt.dri_name2      /*54  ผู้ขับขี่ที่ 2                  */             
            tlt.dri_no1        /*55  วันเกิดผู้ขับขี่ที่ 2           */             
            tlt.rec_name       /*56  ชื่อ - สกุล (ใบเสร็จ/ใบกำกับภาษี)*/            
            tlt.rec_addr1      /*57  ที่อยู่ (ใบเสร็จ/ใบกำกับภาษี)    */ 
            tlt.safe1          
            tlt.OLD_eng        /*58 ข้อมูลจากระบบ  */ 
            wdetail.BIRTHDAY         /*Kridtiya i. A56-0021*/    
            wdetail.CARD_ID          /*Kridtiya i. A56-0021*/ 
            wdetail.CARD_TYPE        /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_CON_ADDR    /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_HOUSE       /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_VILLAGE     /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_BUILDING    /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_FLOOR       /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_MOO         /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_SOI         /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_STREET      /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_TAMBOL      /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_AMPHUR      /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_PROVINCE    /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_ZIP        /*58 ข้อมูลจากระบบ  */ /*Kridtiya i. A56-0021*/
            IF tlt.expotim = "" THEN trim(wdetail.KKapp) ELSE tlt.expotim .    /*A61-0335*/
    
    END.    /*  end  wdetail  */
    ELSE RUN proc_report5. 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report5 c-wins 
PROCEDURE proc_report5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF wdetail.HV_INF_NO <> ""  THEN DO:
        FIND LAST tlt Use-index  tlt05        Where
            tlt.comp_noti_tlt = TRIM(wdetail.HV_INF_NO)  AND
            tlt.genusr       =  fi_compa          NO-LOCK NO-ERROR NO-WAIT. 
    END.
    ELSE DO:
        FIND LAST tlt  Where
            tlt.expotim = TRIM(wdetail.kkapp )  AND
            tlt.genusr       =  fi_compa         NO-LOCK NO-ERROR NO-WAIT. 
    END.
    IF AVAIL tlt THEN DO:
        IF n_rec = 0  THEN DO:
            If  substr(fi_filename3,length(fi_filename3) - 3,4) <>  ".csv"  THEN 
                fi_filename3  =  Trim(fi_filename3) + ".csv"  .
            OUTPUT TO VALUE(fi_filename3). 
            n_rec = 1.
        END.
        ASSIGN 
            n_add1 = ""
            /* comment by A61-0335....
            n_add1 = IF trim(wdetail.CUST_VILLAGE) = "" THEN trim(wdetail.CUST_BUILDING)
                     ELSE trim(wdetail.CUST_VILLAGE) 
            n_add1 = IF trim(wdetail.CUST_BUILDING ) = "" THEN ""
                     ELSE  n_add1 + " อาคาร" + trim(wdetail.CUST_BUILDING )
            end A61-0335.... .*/
             /* create by A61-0335*/
            n_add1 = IF trim(wdetail.CUST_VILLAGE) = "" THEN ""
                     ELSE "หมู่บ้าน" + trim(wdetail.CUST_VILLAGE) .
            n_add1 = IF trim(wdetail.CUST_BUILDING ) = "" THEN  n_add1 
                     ELSE  n_add1 + " อาคาร" + trim(wdetail.CUST_BUILDING ) .
            n_add1 = IF TRIM(wdetail.CA_FLOOR) = "" THEN n_add1
                     ELSE  trim(n_add1) + " ชั้น " + TRIM(wdetail.CA_FLOOR) .
            /* end A61-0335*/ 
        EXPORT DELIMITER "|" 
            string(tlt.datesent,"99/99/9999")       FORMAT "x(10)"    /*1  วันที่รับแจ้ง   */                        
            IF (string(tlt.dat_ins_noti) = "") OR (tlt.dat_ins_noti = ? ) THEN "" ELSE string(date(tlt.dat_ins_noti),"99/99/9999") FORMAT "x(15)"   /*2  วันที่รับเงินค่าเบิ้ยประกัน */            
            tlt.nor_usr_ins    FORMAT "x(50)"    /*3  รายชื่อบริษัทประกันภัย  */ 
            tlt.nor_usr_tlt    FORMAT "x(10)"    /*6  รหัสสาขา    */                            
            tlt.comp_usr_tlt   FORMAT "x(40)"    /*7  สาขา KK */ 
            wdetail.HCC_CN_RUNNO_SHOW   FORMAT "x(25)"    /*4  เลขที่สัญญาเช่าซื้อ */                    
            tlt.nor_noti_ins   FORMAT "x(20)"    /*5  เลขที่กรมธรรม์เดิม  */
            tlt.comp_noti_tlt  FORMAT "x(25)"    /*8  เลขรับเเจ้ง */                            
            tlt.lotno          FORMAT "x(10)"    /*9  Campaign    */
            tlt.lince3         FORMAT "x(10)"    /*10 Sub Campaign */
            tlt.comp_pol       FORMAT "x(10)"    /*11 ประเภทการแถม */
            tlt.safe2          FORMAT "x(10)"    /*11 บุคคล/นิติบุคคล */                        
            IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,1,INDEX(tlt.ins_name," ") - 1)  ELSE tlt.ins_name    /*12 คำนำหน้าชื่อ    */                        
            IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1,R-INDEX(tlt.ins_name," ") - INDEX(tlt.ins_name," ") - 1 ) ELSE tlt.ins_name  
            IF INDEX(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,r-INDEX(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name         /*14 นามสกุลผู้เอาประกัน */  
            wdetail.CUST_HOUSE_NO
            n_add1
            wdetail.CUST_MOO      
            wdetail.CUST_SOI      
            wdetail.CUST_STREET                        
            wdetail.CUST_TAMBOL                        
            wdetail.CUST_AMPHUR                              
            wdetail.CUST_PROVINCE      
            wdetail.CUST_ZIP
            /*A55-0145*/
            tlt.safe3          /*25 ประเภทความคุ้มครอง   */   
            tlt.stat           /*26 ประเภทการซ่อม   */                        
            string(tlt.nor_effdat,"99/99/9999")     /*27 วันเริ่มคุ้มครอง    */                    
            string(tlt.expodat,"99/99/9999")        /*28 วันสิ้นสุดคุ้มครอง  */                     
            tlt.subins         /*29 รหัสรถ  */                                
            tlt.filler2        /*30 ประเภทประกันภัยรถยนต์   */                
            tlt.brand          /*31 ชื่อยี่ห้อรถ    */                        
            tlt.model          /*32 รุ่นรถ  */
            tlt.filler1  FORMAT "x(50)"       /*33 New/Used        */                            
            IF INDEX(trim(tlt.lince1)," ") <> 0 THEN  substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1 )  ELSE tlt.lince1       /*34 เลขทะเบียน      */ 
            IF INDEX(trim(tlt.lince1)," ") <> 0 THEN  substr(tlt.lince1,R-INDEX(tlt.lince1," ") + 1 )    ELSE tlt.lince1          /*35  จังหวัดที่ออกเลขทะเบียน*/ 
            tlt.cha_no         /*36  เลขที่ตัวถัง          */                         
            tlt.eng_no         /*37  เลขที่เครื่องยนต์     */                     
            tlt.lince2         /*38  ปีรถยนต์              */                         
            tlt.cc_weight      /*39  ซีซี                  */                         
            tlt.colorcod       /*40  น้ำหนัก/      ตัน     */                     
            tlt.comp_coamt     /*41  ทุนประกันปี 1 /ต่ออายุ*/                 
            tlt.comp_grprm     /*42  เบี้ยรวมภาษีและอากรปี 1 /ต่ออายุ*/       
            tlt.nor_coamt      /*43  ทุนประกันปี 2                   */       
            tlt.nor_grprm      /*44  เบี้ยรวมภาษีและอากรปี 2         */
            tlt.gentim FORMAT "x(15)"         /*45  เวลารับแจ้ง                 */    
            tlt.comp_sck       /*46  เลขเครื่องหมายตาม พ.ร.บ.        */
            IF (string(tlt.comp_effdat) = "?") OR (tlt.comp_effdat = ? ) THEN "" ELSE string(date(tlt.comp_effdat),"99/99/9999") FORMAT "x(15)"   /*47  วันคุ้มครอง(พ.ร.บ)เริ่มต้น      */             
            IF (string(tlt.gendat) = "?") OR (tlt.gendat = ? ) THEN "" ELSE string(date(tlt.gendat),"99/99/9999") FORMAT "x(15)"         /*48  วันคุ้มครอง(พ.ร.บ)สิ้นสุด       */
            tlt.comp_noti_ins  /*49  เบี้ยรวมภาษีและอากร (พ.ร.บ)   */               
            tlt.comp_usr_ins   /*50  ชื่อเจ้าหน้าที่รับแจ้ง          */             
            tlt.old_cha        /*51  หมายเหตุ / เบี้ยแถมชื่อดิลเลอร์ */             
            tlt.dri_name1      /*52  ผู้ขับขี่ที่ 1                  */             
            tlt.dri_no1        /*53  วันเกิดผู้ขับขี่ที่ 1           */             
            tlt.dri_name2      /*54  ผู้ขับขี่ที่ 2                  */             
            tlt.dri_no1        /*55  วันเกิดผู้ขับขี่ที่ 2           */             
            tlt.rec_name       /*56  ชื่อ - สกุล (ใบเสร็จ/ใบกำกับภาษี)*/            
            tlt.rec_addr1      /*57  ที่อยู่ (ใบเสร็จ/ใบกำกับภาษี)    */ 
            tlt.safe1          
            tlt.OLD_eng       /*58 ข้อมูลจากระบบ  */ 
            wdetail.BIRTHDAY         /*Kridtiya i. A56-0021*/    
            wdetail.CARD_ID          /*Kridtiya i. A56-0021*/ 
            wdetail.CARD_TYPE        /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_CON_ADDR    /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_HOUSE       /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_VILLAGE     /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_BUILDING    /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_FLOOR       /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_MOO         /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_SOI         /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_STREET      /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_TAMBOL      /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_AMPHUR      /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_PROVINCE    /*Kridtiya i. A56-0021*/ 
            wdetail.ADDR_ZIP        /*58 ข้อมูลจากระบบ  */ /*Kridtiya i. A56-0021*/
            IF tlt.expotim = "" THEN trim(wdetail.KKapp) ELSE tlt.expotim .    /*A61-0335*/
    
    END.    /*  end  wdetail  */
END.
    
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
Open Query br_tlt 
    For each tlt Use-index  tlt01 NO-LOCK 
    WHERE 
    tlt.trndat   >=  fi_trndatfr   And
    tlt.trndat   <=  fi_trndatto   And
    tlt.genusr   =   fi_compa    .
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

