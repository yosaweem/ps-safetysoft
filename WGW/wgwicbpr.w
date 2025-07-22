&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
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
/************************************************************************
  program id    :  wgwicbpr.w
  program name :  Match เบี้ยประกันภัยตาม Form ICBC    
  create by    :  Ranu i. A59-0288 22/07/2016  */
/************************************************************************/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

def  stream  ns2.  
DEF VAR nv_row   as  int  init 0.
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO  
   FIELD id               AS CHAR FORMAT "x(10)"     INIT ""        
   FIELD camp             AS CHAR FORMAT "x(50)"     INIT ""        /*Campaign                                                  */    
   FIELD termcov          AS CHAR FORMAT "x(2)"      INIT ""        /*Term Coverage                                             */    
   FIELD inscom           AS CHAR FORMAT "x(20)"     INIT ""        /*Insurance Company                                         */    
   FIELD start_date       AS CHAR FORMAT "x(20)"     INIT ""        /*Effective Date From                                       */    
   FIELD Exp_date         AS CHAR FORMAT "x(11)"     INIT ""        /*Effective Date To                                         */    
   FIELD class            AS CHAR FORMAT "x(20)"     INIT ""        /*รหัสรถ                                                    */    
   FIELD car_Group        AS CHAR FORMAT "x(100)"    INIT ""        /*กลุ่มรถ                                                   */    
   FIELD covcod           AS CHAR FORMAT "x(100)"    INIT ""        /*ประเภทความคุ้มครอง                                        */    
   FIELD age_drive        AS CHAR FORMAT "x(1)"      INIT ""        /*อายุผู้ขับขี่                                             */    
   FIELD Garage           AS CHAR FORMAT "x(100)"    INIT ""        /*ประเภทการซ่อม                                             */    
   FIELD age_car          AS CHAR FORMAT "x(20)"     INIT ""        /*อายุรถ (ปี)                                               */    
   FIELD cc               AS CHAR FORMAT "x(50)"     INIT ""        /*ขนาดเครื่องยนต์ / จน.ที่นั่ง / น้ำหนักบรรทุก              */    
   FIELD ins_year         AS CHAR FORMAT "x(50)"     INIT ""        /*ประกันปีที่                                               */    
   FIELD si_st            AS CHAR FORMAT "x(50)"     INIT ""        /*ทุนประกันภัยเริ่มต้น                                      */    
   FIELD si_en            AS CHAR FORMAT "x(50)"     INIT ""        /*ทุนประกันภัยสิ้นสุด                                       */    
   FIELD netprem          AS CHAR FORMAT "x(50)"     INIT ""        /*เบี้ยประกันภัยสุทธิ                                       */    
   FIELD totalpre         AS CHAR FORMAT "x(50)"     INIT ""        /*เบี้ยรวมภาษีและอากร                                       */    
   FIELD wht              AS CHAR FORMAT "x(50)"     INIT ""        /*เบี้ยรวมหักภาษี ณ ที่จ่าย 1% แล้ว (กรณีนิติบุคคล)         */    
   FIELD PD               AS CHAR FORMAT "x(50)"     INIT ""        /*ความคุ้มครอง-ความเสียหายต่อทรัพย์สินบุคคลภายนอก(บาท/ครั้ง)*/    
   FIELD AD               AS CHAR FORMAT "x(50)"     INIT ""        /*ความคุ้มครอง-ค่ารักษาพยาบาลบุคคลภายในรถ(บาท/คน)           */    
   FIELD camp1            AS CHAR FORMAT "x(30)"     INIT ""        /*File name ตารางความคุ้มครอง                               */    
   FIELD comp             AS CHAR FORMAT "x(30)"     INIT ""        /*พรบ                                                       */    
   FIELD Remark           AS CHAR FORMAT "x(20)"     INIT ""       /*เงื่อนไขพิเศษ อื่นๆ                                       */    
   FIELD typecar          AS CHAR FORMAT "x(20)"     INIT "" .     /*ประเภทรถ*/                                                      

DEFINE NEW SHARED WORKFILE wdetail NO-UNDO 
  FIELD  n_class      AS  CHAR FORMAT "X(4)"    INIT ""             /*รหัสรถ                                                     */ 
  FIELD  n_Group      AS  CHAR FORMAT "X(3)"    INIT ""             /*กลุ่มรถ                                                    */ 
  FIELD  n_age_car    AS  CHAR FORMAT "X(3)"    INIT ""             /*อายุรถ (ปี)                                                */ 
  FIELD  n_cc         AS  CHAR FORMAT "X(10)"   INIT ""             /*ขนาดเครื่องยนต์ / จน.ที่นั่ง / น้ำหนักบรรทุก               */ 
  FIELD  n_si_st      AS  CHAR FORMAT "X(20)"   INIT ""             /*ทุนประกันภัยเริ่มต้น                                       */ 
  FIELD  n_si_en      AS  CHAR FORMAT "X(20)"   INIT ""             /*ทุนประกันภัยสิ้นสุด                                        */ 
  FIELD  n_netprem    AS  CHAR FORMAT "X(15)"   INIT ""             /*เบี้ยประกันภัยสุทธิ                                        */ 
  FIELD  n_totalpre   AS  CHAR FORMAT "X(15)"   INIT "".             /*เบี้ยรวมภาษีและอากร                                        */ 
DEFINE NEW SHARED WORKFILE wdetail3 NO-UNDO 
  FIELD  n_class      AS  CHAR FORMAT "X(4)"    INIT ""             /*รหัสรถ                                                     */ 
  FIELD  n_Group      AS  CHAR FORMAT "X(3)"    INIT ""             /*กลุ่มรถ                                                    */ 
  FIELD  n_age_car    AS  CHAR FORMAT "X(3)"    INIT ""             /*อายุรถ (ปี)                                                */ 
  FIELD  n_cc         AS  CHAR FORMAT "X(10)"   INIT ""             /*ขนาดเครื่องยนต์ / จน.ที่นั่ง / น้ำหนักบรรทุก               */ 
  FIELD  n_si_st      AS  CHAR FORMAT "X(20)"   INIT ""             /*ทุนประกันภัยเริ่มต้น                                       */ 
  FIELD  n_si_en      AS  CHAR FORMAT "X(20)"   INIT ""             /*ทุนประกันภัยสิ้นสุด                                        */ 
  FIELD  n_netprem    AS  CHAR FORMAT "X(15)"   INIT ""             /*เบี้ยประกันภัยสุทธิ                                        */ 
  FIELD  n_totalpre   AS  CHAR FORMAT "X(15)"   INIT "".             /*เบี้ยรวมภาษีและอากร                                        */ 
DEF WORKFILE wcampaign NO-UNDO 
    FIELD  campno  AS CHAR FORMAT "x(20)"   INIT ""
    FIELD  id      AS CHAR FORMAT "x(5)"    INIT ""  
    FIELD  cover   AS CHAR FORMAT "x(3)"    INIT ""  
    FIELD  pack    AS CHAR FORMAT "x(3)"    INIT "" 
    FIELD  bi      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd1     AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd2     AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n41     AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD  n42     AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD  n43     AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD  nname   AS CHAR FORMAT "x(25)"  INIT "" .

DEF VAR  n_camp       AS  CHAR FORMAT "X(50)"   INIT "". 
DEF VAR  n_start_date AS  CHAR FORMAT "X(15)"   INIT "". 
DEF VAR  n_Exp_date   AS  CHAR FORMAT "X(15)"   INIT "". 
DEF VAR  n_covcod     AS  CHAR FORMAT "X(3)"    INIT "". 
DEF VAR  n_Garage     AS  CHAR FORMAT "X(35)"   INIT "". 
DEF VAR  n_Group      AS  CHAR FORMAT "X(3)"    INIT "". 
DEF VAR  n_age_car    AS  CHAR FORMAT "X(3)"    INIT "".
DEF VAR  n_Group1     AS  CHAR FORMAT "X(3)"    INIT "". 
DEF VAR  n_age_car1   AS  CHAR FORMAT "X(3)"    INIT "".
DEF VAR  n_class      AS  CHAR FORMAT "X(4)"    INIT "". 
DEF VAR  n_cc         AS  CHAR FORMAT "X(10)"   INIT "". 
DEF VAR  n_typecar    AS  CHAR FORMAT "X(2)"    INIT "". 
DEF VAR  n_age_drive  AS  CHAR FORMAT "X(3)"    INIT "". 
DEF VAR  n_PD         AS  CHAR FORMAT "X(15)"   INIT "". 
DEF VAR  n_AD         AS  CHAR FORMAT "X(15)"   INIT "".
DEF VAR  n_comp       AS  CHAR FORMAT "x(15)"   INIT "".
DEF VAR  n_stam       AS  DECI   INIT 0. 
DEF VAR  n_wht        AS  DECI   INIT 0. 
DEF VAR  n_remark     AS  CHAR FORMAT "X(255)"  INIT "".
DEF VAR  n_remark1    AS  CHAR FORMAT "X(255)"  INIT "".
DEF VAR  n_count      AS INT INIT 0.
DEF VAR  n_yr         AS INT INIT 0.
DEF VAR  nv_wht       AS DECI.
DEF VAR  n_cover      AS CHAR FORMAT "x(3)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_cover

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wcampaign

/* Definitions for BROWSE br_cover                                      */
&Scoped-define FIELDS-IN-QUERY-br_cover wcampaign.id wcampaign.pack wcampaign.bi wcampaign.cover wcampaign.pd2 wcampaign.n43   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_cover   
&Scoped-define SELF-NAME br_cover
&Scoped-define QUERY-STRING-br_cover FOR EACH wcampaign
&Scoped-define OPEN-QUERY-br_cover OPEN QUERY {&SELF-NAME} FOR EACH wcampaign.
&Scoped-define TABLES-IN-QUERY-br_cover wcampaign
&Scoped-define FIRST-TABLE-IN-QUERY-br_cover wcampaign


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_cover}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_process fi_camp fi_stdate fi_endate ~
rs_covcod CB_garage CB_cartyp fi_yr1 fi_yr2 fi_gcar1 fi_gcar2 fi_remark1 ~
fi_remark2 fi_filename bu_file bu_ok bu_exit fi_outfile br_cover RECT-76 ~
RECT-78 RECT-83 RECT-457 RECT-458 RECT-460 
&Scoped-Define DISPLAYED-OBJECTS fi_process fi_camp fi_stdate fi_endate ~
rs_covcod CB_garage CB_cartyp fi_yr1 fi_yr2 fi_gcar1 fi_gcar2 fi_remark1 ~
fi_remark2 fi_filename fi_outfile 

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
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.5 BY 1
     FONT 6.

DEFINE VARIABLE CB_cartyp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 17.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE CB_garage AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 22.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_endate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 71.33 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_gcar1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_gcar2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 6.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 71.83 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 71.5 BY .81
     BGCOLOR 8 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 88.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 88.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_stdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_yr1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_yr2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rs_covcod AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ป.1", 1,
"ป.2", 2,
"ป.2+", 3,
"ป.3", 4
     SIZE 65.83 BY 1
     BGCOLOR 29 FGCOLOR 4 FONT 32 NO-UNDO.

DEFINE RECTANGLE RECT-457
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.83 BY 1.43
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-458
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.17 BY 1.43
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-460
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 125.17 BY 4.38.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 129 BY 20.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-78
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 128.83 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-83
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 126.83 BY 12.38
     BGCOLOR 29 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_cover FOR 
      wcampaign SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_cover
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_cover C-Win _FREEFORM
  QUERY br_cover DISPLAY
      wcampaign.id      COLUMN-LABEL " No."            FORMAT "x(10)"  
 wcampaign.pack    COLUMN-LABEL " Class"          FORMAT "x(10)"                                        
 wcampaign.bi      COLUMN-LABEL " เบี้ยรวม พรบ."  FORMAT "x(15)"                                    
 wcampaign.cover   COLUMN-LABEL " การประกันภัย"   FORMAT "X(10)"                                    
 wcampaign.pd2     COLUMN-LABEL " ความเสียหายต่อทรัพย์สินบุคคลภายนอก(บาท/ครั้ง)" FORMAT "X(20)"    
 wcampaign.n43     COLUMN-LABEL " ค่ารักษาพยาบาลบุคคลภายในรถ(บาท/คน)"            FORMAT "X(20)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 124.5 BY 4.24
         BGCOLOR 19 FONT 1 ROW-HEIGHT-CHARS .62 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_process AT ROW 13.76 COL 27.5 COLON-ALIGNED NO-LABEL 
     fi_camp AT ROW 3.29 COL 27.67 COLON-ALIGNED NO-LABEL 
     fi_stdate AT ROW 4.38 COL 27.67 COLON-ALIGNED NO-LABEL 
     fi_endate AT ROW 4.38 COL 72 COLON-ALIGNED NO-LABEL 
     rs_covcod AT ROW 5.62 COL 30 NO-LABEL 
     CB_garage AT ROW 6.81 COL 27.67 COLON-ALIGNED NO-LABEL 
     CB_cartyp AT ROW 6.71 COL 72.17 COLON-ALIGNED NO-LABEL 
     fi_yr1 AT ROW 7.95 COL 27.67 COLON-ALIGNED NO-LABEL 
     fi_yr2 AT ROW 7.95 COL 41.17 COLON-ALIGNED NO-LABEL 
     fi_gcar1 AT ROW 7.91 COL 72 COLON-ALIGNED NO-LABEL 
     fi_gcar2 AT ROW 7.91 COL 83.5 COLON-ALIGNED NO-LABEL 
     fi_remark1 AT ROW 9.1 COL 27.33 COLON-ALIGNED NO-LABEL 
     fi_remark2 AT ROW 10.14 COL 27.33 COLON-ALIGNED NO-LABEL 
     fi_filename AT ROW 11.43 COL 27.17 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 11.43 COL 100.5
     bu_ok AT ROW 12.48 COL 107.33
     bu_exit AT ROW 12.48 COL 118.5
     fi_outfile AT ROW 12.52 COL 27.17 COLON-ALIGNED NO-LABEL
     br_cover AT ROW 16.29 COL 3.5 
     " กลุ่มรถ  :" VIEW-AS TEXT
          SIZE 9.33 BY 1 AT ROW 7.91 COL 63.67 
          BGCOLOR 8 FGCOLOR 4 FONT 6
     " หมายเหตุ   :" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 9.1 COL 15.67 
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "  รายละเอียดความคุ้มครอง" VIEW-AS TEXT
          SIZE 125.33 BY 1 AT ROW 15.19 COL 3 
          BGCOLOR 4 FGCOLOR 7 
     "Match เบี้ยประกันภัย ICBC" VIEW-AS TEXT
          SIZE 34 BY 1.43 AT ROW 1.19 COL 49.17
          BGCOLOR 1 FGCOLOR 7 FONT 32
     "Output to excel(.slk)  :" VIEW-AS TEXT
          SIZE 21.67 BY 1.05 AT ROW 12.52 COL 6.83
          BGCOLOR 29 FGCOLOR 2 FONT 6
     " ประเภทรถ  :" VIEW-AS TEXT
          SIZE 12.67 BY 1 AT ROW 6.76 COL 60.67 
          BGCOLOR 8 FGCOLOR 4 FONT 6
     " ถึง" VIEW-AS TEXT
          SIZE 3.5 BY 1 AT ROW 7.91 COL 81 
          BGCOLOR 8 FGCOLOR 4 FONT 6
     " ปี" VIEW-AS TEXT
          SIZE 3.33 BY 1 AT ROW 7.95 COL 51.5 
          BGCOLOR 8 FGCOLOR 4 FONT 6
     " ถึง" VIEW-AS TEXT
          SIZE 3.5 BY 1 AT ROW 7.95 COL 37.83 
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "               Input File :":30 VIEW-AS TEXT
          SIZE 21.17 BY 1.05 AT ROW 11.43 COL 7.33
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "  อายุรถ  :" VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 7.91 COL 18.67 
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "ประเภทการซ่อม  :" VIEW-AS TEXT
          SIZE 16.5 BY 1.1 AT ROW 6.71 COL 11.83 
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "วันที่สิ้นสุด  :" VIEW-AS TEXT
          SIZE 11.67 BY 1 AT ROW 4.43 COL 61.5 
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "วันที่เริ่มใช้  :" VIEW-AS TEXT
          SIZE 11.83 BY 1 AT ROW 4.43 COL 16.5 
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "ชื่อแคมเปญ    :" VIEW-AS TEXT
          SIZE 13.67 BY 1 AT ROW 3.29 COL 14.83 
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "ประเภทความคุ้มครอง   :" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 5.57 COL 6.33 
          BGCOLOR 8 FGCOLOR 4 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 129.33 BY 20.24
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     RECT-76 AT ROW 1 COL 1
     RECT-78 AT ROW 1.1 COL 1.17 
     RECT-83 AT ROW 2.67 COL 2.33 
     RECT-457 AT ROW 12.29 COL 116.67 
     RECT-458 AT ROW 12.29 COL 105.67 
     RECT-460 AT ROW 16.14 COL 3 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 129.33 BY 20.24
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
         TITLE              = "Match เบี้ยส่ง ICBC"
         HEIGHT             = 20.24
         WIDTH              = 129.33
         MAX-HEIGHT         = 33.71
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.71
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
/* BROWSE-TAB br_cover fi_outfile fr_main */
ASSIGN 
       br_cover:SEPARATOR-FGCOLOR IN FRAME fr_main      = 20.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

ASSIGN 
       fi_process:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_cover
/* Query rebuild information for BROWSE br_cover
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wcampaign.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_cover */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match เบี้ยส่ง ICBC */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match เบี้ยส่ง ICBC */
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
  Apply "Close" to this-procedure.
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
        FILTERS    "Text Documents" "*.csv"
        
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
         n_camp          = ""     
         n_start_date    = ""     
         n_Exp_date      = ""     
         n_Garage        = ""     
         n_typecar       = ""     
         n_age_car       = ""     
         n_age_car1      = ""     
         n_group         = ""     
         n_Group1        = ""     
         n_remark        = ""     
         n_remark1       = ""     
         n_covcod        = "" 
         n_cc            = ""
         n_PD            = ""      
         n_AD            = ""
         n_comp          = ""     
         n_stam          = 0 
         n_wht           = 0.
    IF fi_camp = " " THEN DO:
        MESSAGE "กรุณาระบุชื่อแคมเปญ !!!" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_camp.
        RETURN NO-APPLY.
    END.
    IF fi_stdate = ? THEN DO:
        MESSAGE "กรุณาระบุวันที่เริ่มแคมเปญ !!!" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_stdate.
        RETURN NO-APPLY.
    END.
    IF fi_endate = ? THEN DO:
        MESSAGE "กรุณาระบุวันที่สิ้นสุดแคมเปญ !!!" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_endate.
        RETURN NO-APPLY.
    END.
    IF  rs_covcod <> 1 AND fi_yr1 = "" THEN DO:
        MESSAGE "กรุณาระบุปีรถ !!!" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_yr1.
        RETURN NO-APPLY.
    END.
    IF  rs_covcod <> 1 AND fi_yr2 = "" THEN DO:
        MESSAGE "กรุณาระบุปีรถ !!!" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_yr2.
        RETURN NO-APPLY.
    END.
    IF rs_covcod <> 1 AND fi_gcar1 = "" THEN DO:
        MESSAGE "กรุณาระบุกลุ่มรถ !!!" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_gcar1.
        RETURN NO-APPLY.
    END.
    IF rs_covcod <> 1 AND fi_gcar2 = "" THEN DO:
        MESSAGE "กรุณาระบุกลุ่มรถ !!!" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_gcar2.
        RETURN NO-APPLY.
    END.
    IF fi_filename = ""  THEN DO:
        MESSAGE "File in put name is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_filename.
        RETURN NO-APPLY.
    END.
    IF fi_outfile = ""  THEN DO:
        MESSAGE "File out put name is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_outfile.
        RETURN NO-APPLY.
    END.
    ASSIGN 
        fi_filename     = INPUT fi_filename
        fi_outfile      = INPUT fi_outfile
        fi_camp         = INPUT fi_camp   
        fi_stdate       = input fi_stdate 
        fi_endate       = input fi_endate 
        cb_garage       = input cb_garage 
        cb_cartyp       = input cb_cartyp 
        fi_yr1          = input fi_yr1    
        fi_yr2          = INPUT fi_yr2    
        fi_gcar1        = INPUT fi_gcar1  
        fi_gcar2        = INPUT fi_gcar2  
        fi_remark1      = INPUT fi_remark1
        fi_remark2      = INPUT fi_remark2
        n_camp          = INPUT fi_camp  
        n_start_date    = STRING(fi_stdate)
        n_Exp_date      = STRING(fi_endate)
        n_Garage        = IF cb_garage = "'1'" THEN "1" ELSE "2"
        n_typecar       = IF cb_cartyp = "'1'" THEN "N" ELSE "U"
        n_age_car       = fi_yr1
        n_age_car1      = fi_yr2
        n_group         = fi_gcar1
        n_Group1        = fi_gcar2
        n_remark        = fi_remark1
        n_remark1       = fi_remark2.

    IF      rs_covcod = 1 THEN ASSIGN n_covcod = "01".
    ELSE IF rs_covcod = 2 THEN ASSIGN n_covcod = "02".
    ELSE IF rs_covcod = 3 THEN ASSIGN n_covcod = "10".
    ELSE IF rs_covcod = 4 THEN ASSIGN n_covcod = "03".

    For each  wdetail :
        DELETE  wdetail.
    END.
    For each  wdetail3 :
        DELETE  wdetail3.
    END.
    IF rs_covcod = 1 THEN DO:
        INPUT FROM VALUE(fi_FileName).
        REPEAT:
            CREATE wdetail.  
            IMPORT DELIMITER "|" 
             wdetail.n_class 
             wdetail.n_Group           
             wdetail.n_age_car
             wdetail.n_cc              
             wdetail.n_si_st           
             wdetail.n_si_en           
             wdetail.n_netprem         
             wdetail.n_totalpre.
           /* repeat  */
        END.
        FOR EACH wdetail.
            IF INDEX(wdetail.n_class,"รหัส") <> 0 OR INDEX(wdetail.n_class,"Class") <> 0 THEN DELETE  wdetail.
            ELSE IF (wdetail.n_class = ""   ) THEN DELETE wdetail.
        END.
        RUN  Pro_assign.
    END.
    ELSE DO:
        INPUT FROM VALUE(fi_FileName).
        REPEAT:
            CREATE wdetail3.  
            IMPORT DELIMITER "|" 
                wdetail3.n_class 
                wdetail3.n_si_st     
                wdetail3.n_si_en     
                wdetail3.n_netprem   
                wdetail3.n_totalpre.
           /* repeat  */
       END.
       FOR EACH wdetail3.
            IF INDEX(wdetail3.n_class,"รหัส") <> 0 OR INDEX(wdetail3.n_class,"Class") <> 0 THEN DELETE  wdetail3.
            ELSE IF (wdetail3.n_class = ""   ) THEN DELETE wdetail3.
       END.
       RUN Pro_assign1.
       RUN pro_c210.
    END.
    Run  Pro_createfile.
    fi_process = "Match Data to File Complete.......... ".
    DISP fi_process WITH FRAME fr_main.
    RUN pro_clear.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CB_cartyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CB_cartyp C-Win
ON VALUE-CHANGED OF CB_cartyp IN FRAME fr_main
DO:
    cb_cartyp  =  INPUT cb_cartyp.
    Disp  cb_cartyp  with frame  fr_main.
        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CB_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CB_garage C-Win
ON VALUE-CHANGED OF CB_garage IN FRAME fr_main
DO:
    cb_garage  =  INPUT cb_garage.
    Disp  cb_garage  with frame  fr_main.
        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp C-Win
ON LEAVE OF fi_camp IN FRAME fr_main
DO:
    fi_camp  =  INPUT  fi_camp.
    Disp  fi_camp  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_endate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_endate C-Win
ON LEAVE OF fi_endate IN FRAME fr_main
DO:
    fi_endate  =  INPUT  fi_endate.
    Disp  fi_endate  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
    fi_filename  =  Input  fi_filename.
    Disp  fi_filename  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gcar1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gcar1 C-Win
ON LEAVE OF fi_gcar1 IN FRAME fr_main
DO:
    fi_gcar1  =  INPUT  fi_gcar1.
    Disp  fi_gcar1  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gcar2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gcar2 C-Win
ON LEAVE OF fi_gcar2 IN FRAME fr_main
DO:
    fi_gcar2  =  INPUT  fi_gcar2.
    Disp  fi_gcar2  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
    fi_outfile  =  Input  fi_outfile.
    Disp  fi_outfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stdate C-Win
ON LEAVE OF fi_stdate IN FRAME fr_main
DO:
    fi_stdate  =  INPUT  fi_stdate.
    Disp  fi_stdate  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_yr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_yr1 C-Win
ON LEAVE OF fi_yr1 IN FRAME fr_main
DO:
    fi_yr1  =  INPUT  fi_yr1.
    Disp  fi_yr1  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_yr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_yr2 C-Win
ON LEAVE OF fi_yr2 IN FRAME fr_main
DO:
    fi_yr2  =  INPUT  fi_yr2.
    Disp  fi_yr2  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_covcod C-Win
ON VALUE-CHANGED OF rs_covcod IN FRAME fr_main
DO:
    rs_covcod  =  INPUT  rs_covcod.
   
    IF rs_covcod = 1 THEN DO:
        ASSIGN 
            fi_yr1:SENSITIVE = NO
            fi_yr2:SENSITIVE = NO 
            fi_gcar1:SENSITIVE = NO  
            fi_gcar2:SENSITIVE = NO 
            fi_yr1:BGCOLOR = 8
            fi_yr2:BGCOLOR = 8
            fi_gcar1:BGCOLOR = 8
            fi_gcar2:BGCOLOR = 8.
    END.
    ELSE DO:
        ASSIGN 
            fi_yr1:SENSITIVE = YES
            fi_yr2:SENSITIVE = YES
            fi_gcar1:SENSITIVE = YES 
            fi_gcar2:SENSITIVE = YES
            fi_yr1:BGCOLOR = 15
            fi_yr2:BGCOLOR = 15
            fi_gcar1:BGCOLOR = 15
            fi_gcar2:BGCOLOR = 15.
    END.
    Disp  rs_covcod fi_yr1 fi_yr2 fi_gcar1 fi_gcar2 with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_cover
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
  
  gv_prgid = "wgwicbpr".
  gv_prog  = "Match เบี้ยส่ง ICBC ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.

  RUN pro_clear.
  ASSIGN 
      fi_process = "Put data Send to ICBC......"
      cb_cartyp = '"1"'
      cb_cartyp:LIST-ITEM-PAIRS = 'ป้ายแดง,"1",Used Car,"2"'
      cb_garage = '"1"'
      cb_garage:LIST-ITEM-PAIRS = 'ซ่อมห้าง,"1",ซ่อมอู่,"2"'
      /*n_typecar = cb_cartyp*/
      fi_camp   = "ระบุชื่อแคมเปญ "
      fi_stdate = (TODAY)
      fi_endate = (TODAY)
      rs_covcod = 1
      fi_yr1    = "2"
      fi_yr2    = "15"
      fi_gcar1 = "2"
      fi_gcar2 = "5".
      RUN pro_cover.
      OPEN QUERY br_cover FOR EACH wcampaign.
      IF rs_covcod = 1 THEN DO:
        ASSIGN 
            fi_yr1:SENSITIVE = NO
            fi_yr2:SENSITIVE = NO 
            fi_gcar1:SENSITIVE = NO  
            fi_gcar2:SENSITIVE = NO 
            fi_yr1:BGCOLOR = 8
            fi_yr2:BGCOLOR = 8
            fi_gcar1:BGCOLOR = 8
            fi_gcar2:BGCOLOR = 8.
      END.
      ELSE DO:
        ASSIGN 
            fi_yr1:SENSITIVE = YES
            fi_yr2:SENSITIVE = YES
            fi_gcar1:SENSITIVE = YES 
            fi_gcar2:SENSITIVE = YES
            fi_yr1:BGCOLOR = 15
            fi_yr2:BGCOLOR = 15
            fi_gcar1:BGCOLOR = 15
            fi_gcar2:BGCOLOR = 15.
      END.
      DISP cb_cartyp fi_camp fi_stdate fi_endate rs_covcod  cb_garage fi_yr1 fi_yr2   
           fi_gcar1 fi_gcar2 fi_process WITH FRAME fr_main.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win 
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
  DISPLAY fi_process fi_camp fi_stdate fi_endate rs_covcod CB_garage CB_cartyp 
          fi_yr1 fi_yr2 fi_gcar1 fi_gcar2 fi_remark1 fi_remark2 fi_filename 
          fi_outfile 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_process fi_camp fi_stdate fi_endate rs_covcod CB_garage CB_cartyp 
         fi_yr1 fi_yr2 fi_gcar1 fi_gcar2 fi_remark1 fi_remark2 fi_filename 
         bu_file bu_ok bu_exit fi_outfile br_cover RECT-76 RECT-78 RECT-83 
         RECT-457 RECT-458 RECT-460 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_assign C-Win 
PROCEDURE pro_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_count AS INT INIT 0.
IF n_covcod = "01"  THEN DO:
    FOR EACH wdetail.
        FIND LAST brstat.insure USE-INDEX insure03 WHERE brstat.Insure.CompNo  = "ICB_COVER" AND 
                                                     brstat.insure.vatcode     = "1"    AND
                                                     brstat.insure.text3       = TRIM(wdetail.n_class) NO-LOCK NO-ERROR.
        IF AVAIL brstat.insure THEN DO:
            ASSIGN n_PD     =  brstat.insure.addr2  
                   n_AD     =  brstat.insure.telno 
                   n_comp   =  brstat.insure.text5.
        END.
        IF wdetail.n_class = "110" THEN DO:
            IF ( TRIM(wdetail.n_cc) = "<2,000" ) OR ( TRIM(wdetail.n_cc) = "<2000" ) THEN  n_cc = "11".
            ELSE IF ( TRIM(wdetail.n_cc) = ">2,000" ) OR ( TRIM(wdetail.n_cc) = ">2000" ) THEN  n_cc = "12".
        END.
        ELSE IF wdetail.n_class = "210" THEN  n_cc = "21".
        ELSE IF wdetail.n_class = "320" THEN  n_cc = "32".

        fi_process = "Create data Cover1 Class " + wdetail.n_class + " Group " + TRIM(wdetail.n_Group) + " Year " + TRIM(wdetail.n_age_car).
        DISP fi_process WITH FRAME fr_main.

        CREATE wdetail2.
        ASSIGN 
            wdetail2.camp       =  n_camp  
            wdetail2.termcov    =  "1" 
            wdetail2.inscom     =  " " 
            wdetail2.start_date =  n_start_date 
            wdetail2.Exp_date   =  n_Exp_date   
            wdetail2.class      =  TRIM(wdetail.n_class) 
            wdetail2.car_Group  =  IF TRIM(wdetail.n_Group) <> "" THEN TRIM(wdetail.n_group) ELSE "-"    
            wdetail2.covcod     =  n_covcod 
            wdetail2.age_drive  =  "N" 
            wdetail2.Garage     =  n_garage 
            wdetail2.age_car    =  TRIM(wdetail.n_age_car)   
            wdetail2.cc         =  n_cc   
            wdetail2.ins_year   =  "1" 
            wdetail2.si_st      =  TRIM(wdetail.n_si_st)     
            wdetail2.si_en      =  trim(wdetail.n_si_en)     
            wdetail2.netprem    =  trim(wdetail.n_netprem)   
            wdetail2.totalpre   =  trim(wdetail.n_totalpre)  
            wdetail2.wht        =  "0" 
            wdetail2.PD         =  n_PD    
            wdetail2.AD         =  n_AD    
            wdetail2.camp1      =  n_camp  
            wdetail2.comp       =  n_comp 
            wdetail2.Remark     =  n_remark + " " + n_remark1 
            wdetail2.typecar    =  n_typecar. 
        IF wdetail2.netprem <> "" THEN
            ASSIGN n_stam       =  ROUND(DECI(wdetail2.netprem) * 0.004 , 0 )
                   n_wht        =  (DECI(wdetail2.netprem) + n_stam ) * 0.01
                   wdetail2.wht =  STRING(DECI(wdetail2.totalpre) - n_wht ).
       
    END. /* for */
END. /* if cover */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_assign1 C-Win 
PROCEDURE pro_assign1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
loop_main:
REPEAT:
    IF int(n_group) <= INT(n_group1) THEN DO:
       ASSIGN n_yr = 0.
              n_yr = INT(n_age_car).
      loop_group:
      REPEAT:
          IF n_yr <= INT(n_age_car1) THEN DO:
            FOR EACH wdetail3.
                 ASSIGN n_PD    = ""     
                        n_AD    = ""
                        n_comp  = ""      
                        n_cover = ""
                        n_stam  = 0
                        n_wht   = 0
                        nv_wht  = 0.
                 IF      n_covcod = "02" THEN n_cover = "2".
                 ELSE IF n_covcod = "10" THEN n_cover = "2+".
                 ELSE IF n_covcod = "03" THEN n_cover = "3".
                 FIND LAST brstat.insure USE-INDEX insure03 WHERE brstat.Insure.CompNo  = "ICB_COVER" AND 
                                                              brstat.insure.vatcode     = n_cover     AND
                                                              brstat.insure.text3       = TRIM(wdetail3.n_class) NO-LOCK NO-ERROR.
                 IF AVAIL brstat.insure THEN DO:
                     ASSIGN n_PD     =  brstat.insure.addr2  
                            n_AD     =  brstat.insure.telno 
                            n_comp   =  brstat.insure.text5.
                 END.
                fi_process = "Create data Cover" + n_cover + " Class " + wdetail3.n_class + " Group " + STRING(n_group) + " Year " + STRING(n_yr) .
                DISP fi_process WITH FRAME fr_main.
                 IF TRIM(wdetail3.n_class) = "110" THEN DO:
                       IF wdetail3.n_cc = " "  THEN DO:
                         ASSIGN  n_cc   = "11".
                         FIND LAST wdetail2 WHERE wdetail2.CLASS     = trim(wdetail3.n_class)    AND
                                                  wdetail2.cc        = n_cc                      AND
                                                  wdetail2.car_Group = n_group                   AND
                                                  wdetail2.age_car   = STRING(n_yr)              AND
                                                  wdetail2.si_st     = trim(wdetail3.n_si_st)    AND 
                                                  wdetail2.netprem   = trim(wdetail3.n_netprem)  AND  
                                                  wdetail2.totalpre  = trim(wdetail3.n_totalpre) NO-LOCK NO-ERROR.
                                IF NOT AVAIL wdetail2 THEN DO:
                                    CREATE wdetail2.
                                    ASSIGN 
                                        wdetail2.camp       =  n_camp  
                                        wdetail2.termcov    =  "1" 
                                        wdetail2.inscom     =  " " 
                                        wdetail2.start_date =  n_start_date 
                                        wdetail2.Exp_date   =  n_Exp_date   
                                        wdetail2.class      =  TRIM(wdetail3.n_class) 
                                        wdetail2.car_Group  =  n_group   
                                        wdetail2.covcod     =  n_covcod 
                                        wdetail2.age_drive  =  "N" 
                                        wdetail2.Garage     =  n_garage
                                        wdetail2.age_car    =  STRING(n_yr) 
                                        wdetail2.cc         =  n_cc  
                                        wdetail2.ins_year   =  "1" 
                                        wdetail2.si_st      =  TRIM(wdetail3.n_si_st)     
                                        wdetail2.si_en      =  trim(wdetail3.n_si_en)     
                                        wdetail2.netprem    =  trim(wdetail3.n_netprem)   
                                        wdetail2.totalpre   =  trim(wdetail3.n_totalpre)  
                                        wdetail2.wht        =  "0" 
                                        wdetail2.PD         =  n_PD    
                                        wdetail2.AD         =  n_AD    
                                        wdetail2.camp1      =  n_camp  
                                        wdetail2.comp       =  n_comp 
                                        wdetail2.Remark     =  n_remark + " " + n_remark1 
                                        wdetail2.typecar    =  n_typecar. 
                                    IF wdetail2.netprem <> "" THEN 
                                         ASSIGN n_stam   =  ROUND(DECI(wdetail2.netprem) * 0.004 , 0 )
                                                n_wht    =  (DECI(wdetail2.netprem) + n_stam ) * 0.01
                                                wdetail2.wht  =  STRING(DECI(wdetail2.totalpre) - n_wht ).
                               END. /* CC */
                       END. /* <= 2000 */
                       IF TRIM(wdetail3.n_cc) <> "12" THEN DO:
                         ASSIGN n_cc     = "12".
                         FIND LAST wdetail2 WHERE wdetail2.CLASS   = TRIM(wdetail3.n_class)    AND
                                                wdetail2.cc        = string(n_cc)              AND
                                                wdetail2.car_Group = n_group                   AND
                                                wdetail2.age_car   = STRING(n_yr)              AND
                                                wdetail2.si_st     = trim(wdetail3.n_si_st)    AND 
                                                wdetail2.netprem   = trim(wdetail3.n_netprem)  AND  
                                                wdetail2.totalpre  = trim(wdetail3.n_totalpre) NO-LOCK NO-ERROR.
                              IF NOT AVAIL wdetail2 THEN DO:
                                  CREATE wdetail2.
                                  ASSIGN 
                                      wdetail2.camp       =  n_camp  
                                      wdetail2.termcov    =  "1" 
                                      wdetail2.inscom     =  " " 
                                      wdetail2.start_date =  n_start_date 
                                      wdetail2.Exp_date   =  n_Exp_date   
                                      wdetail2.class      =  TRIM(wdetail3.n_class) 
                                      wdetail2.car_Group  =  n_group 
                                      wdetail2.covcod     =  n_covcod 
                                      wdetail2.age_drive  =  "N" 
                                      wdetail2.Garage     =  n_garage
                                      wdetail2.age_car    =  STRING(n_yr)
                                      wdetail2.cc         =  n_cc   
                                      wdetail2.ins_year   =  "1" 
                                      wdetail2.si_st      =  TRIM(wdetail3.n_si_st)     
                                      wdetail2.si_en      =  trim(wdetail3.n_si_en)     
                                      wdetail2.netprem    =  trim(wdetail3.n_netprem)   
                                      wdetail2.totalpre   =  trim(wdetail3.n_totalpre)  
                                      wdetail2.wht        =  "0" 
                                      wdetail2.PD         =  n_PD    
                                      wdetail2.AD         =  n_AD    
                                      wdetail2.camp1      =  n_camp  
                                      wdetail2.comp       =  n_comp 
                                      wdetail2.Remark     =  n_remark + " " + n_remark1 
                                      wdetail2.typecar    =  n_typecar. 
                                  IF wdetail2.netprem <> "" THEN 
                                       ASSIGN n_stam   =  ROUND(DECI(wdetail2.netprem) * 0.004 , 0 )
                                              n_wht    =  (DECI(wdetail2.netprem) + n_stam ) * 0.01
                                              wdetail2.wht  =  STRING(DECI(wdetail2.totalpre) - n_wht ).
                                  
                              END. /*if not*/
                       END. /*>2000*/
                END. /* class */
             END. /* for */
             n_yr = n_yr + 1 .
             IF INT(n_yr) <= INT(n_age_car1) THEN NEXT loop_group.
             ELSE  LEAVE loop_group.
          END. /* group */
          ELSE  LEAVE loop_group.
      END. /* repeat group */
      n_group = STRING(INT(n_group) + 1 ).           
      IF INT(n_group) <= INT(n_group1) THEN NEXT loop_main.    
      ELSE LEAVE loop_main.  
    END.
    ELSE LEAVE loop_main.
END. /* repeat */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_c210 C-Win 
PROCEDURE pro_c210 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN n_yr = 0.
       n_yr = INT(n_age_car).
loop_group1:
REPEAT:
    IF n_yr <= INT(n_age_car1) THEN DO:
      FOR EACH wdetail3.
           ASSIGN n_PD    = ""     
                  n_AD    = ""
                  n_comp  = ""      
                  n_cover = ""
                  n_stam  = 0
                  n_wht   = 0
                  nv_wht  = 0.
           IF      n_covcod = "02" THEN n_cover = "2".
           ELSE IF n_covcod = "10" THEN n_cover = "2+".
           ELSE IF n_covcod = "03" THEN n_cover = "3".
           FIND LAST brstat.insure USE-INDEX insure03 WHERE brstat.Insure.CompNo  = "ICB_COVER" AND 
                                                        brstat.insure.vatcode     = n_cover     AND
                                                        brstat.insure.text3       = TRIM(wdetail3.n_class) NO-LOCK NO-ERROR.
           IF AVAIL brstat.insure THEN DO:
               ASSIGN n_PD     =  brstat.insure.addr2  
                      n_AD     =  brstat.insure.telno 
                      n_comp   =  brstat.insure.text5.
           END.
          fi_process = "Create data Cover " + n_cover + " Class " + wdetail3.n_class + " Year " + STRING(n_yr) .
          DISP fi_process WITH FRAME fr_main.
          IF TRIM(wdetail3.n_class) = "210" THEN DO:
             IF wdetail3.n_cc = " "  THEN DO:
               ASSIGN  n_cc   = "21".
               FIND LAST wdetail2 WHERE wdetail2.CLASS     = trim(wdetail3.n_class)    AND
                                        wdetail2.cc        = n_cc                      AND
                                        wdetail2.car_Group = "-"  /*n_group */         AND
                                        wdetail2.age_car   = STRING(n_yr)              AND
                                        wdetail2.si_st     = trim(wdetail3.n_si_st)    AND 
                                        wdetail2.netprem   = trim(wdetail3.n_netprem)  AND  
                                        wdetail2.totalpre  = trim(wdetail3.n_totalpre) NO-LOCK NO-ERROR.
                      IF NOT AVAIL wdetail2 THEN DO:
                          CREATE wdetail2.
                          ASSIGN 
                              wdetail2.camp       =  n_camp  
                              wdetail2.termcov    =  "1" 
                              wdetail2.inscom     =  " " 
                              wdetail2.start_date =  n_start_date 
                              wdetail2.Exp_date   =  n_Exp_date   
                              wdetail2.class      =  TRIM(wdetail3.n_class) 
                              wdetail2.car_Group  =  "-" /*n_group  */ 
                              wdetail2.covcod     =  n_covcod 
                              wdetail2.age_drive  =  "N" 
                              wdetail2.Garage     =  n_garage
                              wdetail2.age_car    =  STRING(n_yr) 
                              wdetail2.cc         =  n_cc  
                              wdetail2.ins_year   =  "1" 
                              wdetail2.si_st      =  TRIM(wdetail3.n_si_st)     
                              wdetail2.si_en      =  trim(wdetail3.n_si_en)     
                              wdetail2.netprem    =  trim(wdetail3.n_netprem)   
                              wdetail2.totalpre   =  trim(wdetail3.n_totalpre)  
                              wdetail2.wht        =  "0" 
                              wdetail2.PD         =  n_PD    
                              wdetail2.AD         =  n_AD    
                              wdetail2.camp1      =  n_camp  
                              wdetail2.comp       =  n_comp 
                              wdetail2.Remark     =  n_remark + " " + n_remark1 
                              wdetail2.typecar    =  n_typecar. 
                          IF wdetail2.netprem <> "" THEN 
                               ASSIGN n_stam   =  ROUND(DECI(wdetail2.netprem) * 0.004 , 0 )
                                      n_wht    =  (DECI(wdetail2.netprem) + n_stam ) * 0.01
                                      wdetail2.wht  =  STRING(DECI(wdetail2.totalpre) - n_wht ).
                     END. /* CC */
             END. /* 3 */
            /* IF TRIM(wdetail2.cc) <> "12" THEN DO:
               ASSIGN n_cc   = "12".
               FIND LAST wdetail2 WHERE wdetail2.CLASS   = TRIM(wdetail3.n_class)    AND
                                      wdetail2.cc        = string(n_cc)              AND
                                      wdetail2.car_Group = "-" /*n_group*/           AND
                                      wdetail2.age_car   = STRING(n_yr)              AND
                                      wdetail2.si_st     = trim(wdetail3.n_si_st)    AND 
                                      wdetail2.netprem   = trim(wdetail3.n_netprem)  AND  
                                      wdetail2.totalpre  = trim(wdetail3.n_totalpre) NO-LOCK NO-ERROR.
                    IF NOT AVAIL wdetail2 THEN DO:
                        CREATE wdetail2.
                        ASSIGN 
                            wdetail2.camp       =  n_camp  
                            wdetail2.termcov    =  "1" 
                            wdetail2.inscom     =  " " 
                            wdetail2.start_date =  n_start_date 
                            wdetail2.Exp_date   =  n_Exp_date   
                            wdetail2.class      =  TRIM(wdetail3.n_class) 
                            wdetail2.car_Group  =  "-" /*n_group */ 
                            wdetail2.covcod     =  n_covcod 
                            wdetail2.age_drive  =  "N" 
                            wdetail2.Garage     =  n_garage
                            wdetail2.age_car    =  STRING(n_yr)
                            wdetail2.cc         =  n_cc   
                            wdetail2.ins_year   =  "1" 
                            wdetail2.si_st      =  TRIM(wdetail3.n_si_st)     
                            wdetail2.si_en      =  trim(wdetail3.n_si_en)     
                            wdetail2.netprem    =  trim(wdetail3.n_netprem)   
                            wdetail2.totalpre   =  trim(wdetail3.n_totalpre)  
                            wdetail2.wht        =  "0" 
                            wdetail2.PD         =  n_PD    
                            wdetail2.AD         =  n_AD    
                            wdetail2.camp1      =  n_camp  
                            wdetail2.comp       =  n_comp 
                            wdetail2.Remark     =  trim(n_remark) + " " + TRIM(n_remark1) 
                            wdetail2.typecar    =  n_typecar. 
                        IF wdetail2.netprem <> "" THEN 
                             ASSIGN n_stam        =  ROUND(DECI(wdetail2.netprem) * 0.004 , 0 )
                                    n_wht         =  (DECI(wdetail2.netprem) + n_stam ) * 0.01
                                    wdetail2.wht  =  STRING(DECI(wdetail2.totalpre) - n_wht ).
                        
                   END. /*if not*/
             END. /*12*/*/
          END. /* class */
          IF trim(wdetail3.n_class) = "320" THEN DO:
               IF wdetail3.n_cc = " "  THEN DO:
                 ASSIGN  n_cc   = "32".
                 FIND LAST wdetail2 WHERE wdetail2.CLASS     = trim(wdetail3.n_class)    AND
                                          wdetail2.cc        = n_cc                      AND
                                          wdetail2.car_Group = "-"  /*n_group*/          AND
                                          wdetail2.age_car   = STRING(n_yr)              AND
                                          wdetail2.si_st     = trim(wdetail3.n_si_st)    AND 
                                          wdetail2.netprem   = trim(wdetail3.n_netprem)  AND  
                                          wdetail2.totalpre  = trim(wdetail3.n_totalpre) NO-LOCK NO-ERROR.
                        IF NOT AVAIL wdetail2 THEN DO:
                            CREATE wdetail2.
                            ASSIGN 
                                wdetail2.camp       =  n_camp  
                                wdetail2.termcov    =  "1" 
                                wdetail2.inscom     =  " " 
                                wdetail2.start_date =  n_start_date 
                                wdetail2.Exp_date   =  n_Exp_date   
                                wdetail2.class      =  TRIM(wdetail3.n_class) 
                                wdetail2.car_Group  =  "-" /*n_group*/   
                                wdetail2.covcod     =  n_covcod 
                                wdetail2.age_drive  =  "N" 
                                wdetail2.Garage     =  n_garage
                                wdetail2.age_car    =  STRING(n_yr) 
                                wdetail2.cc         =  n_cc  
                                wdetail2.ins_year   =  "1" 
                                wdetail2.si_st      =  TRIM(wdetail3.n_si_st)     
                                wdetail2.si_en      =  trim(wdetail3.n_si_en)     
                                wdetail2.netprem    =  trim(wdetail3.n_netprem)   
                                wdetail2.totalpre   =  trim(wdetail3.n_totalpre)  
                                wdetail2.wht        =  "0" 
                                wdetail2.PD         =  n_PD    
                                wdetail2.AD         =  n_AD    
                                wdetail2.camp1      =  n_camp  
                                wdetail2.comp       =  n_comp 
                                wdetail2.Remark     =  n_remark + " " + n_remark1 
                                wdetail2.typecar    =  n_typecar. 
                            IF wdetail2.netprem <> "" THEN 
                                 ASSIGN n_stam        =  ROUND(DECI(wdetail2.netprem) * 0.004 , 0 )
                                        n_wht         =  (DECI(wdetail2.netprem) + n_stam ) * 0.01
                                        wdetail2.wht  =  STRING(DECI(wdetail2.totalpre) - n_wht ).
                       END. /* CC */
               END. /* 3 */
          END.
       END. /* for */
       n_yr = n_yr + 1 .
       IF INT(n_yr) <= INT(n_age_car1) THEN NEXT loop_group1.
       ELSE  LEAVE loop_group1.
    END. /* year */
    ELSE  LEAVE loop_group1.
END. /* repeat group */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_clear C-Win 
PROCEDURE pro_clear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_row        = 0
    n_camp       = ""
    n_start_date = ""
    n_Exp_date   = ""
    n_covcod     = ""
    n_Garage     = ""
    n_Group      = ""
    n_age_car    = ""
    n_Group1     = ""
    n_age_car1   = ""
    n_class      = ""
    n_cc         = ""
    n_typecar    = ""
    n_age_drive  = ""
    n_PD         = ""
    n_AD         = ""
    n_wht        = 0
    n_stam       = 0
    n_remark     = ""
    n_remark1    = ""
    n_count     = 0
    n_yr        = 0
    nv_wht      = 0
    n_cover     = "".

FOR EACH wdetail:
    DELETE wdetail.
END.
FOR EACH wdetail2:
    DELETE wdetail2.
END.
FOR EACH wdetail3:
    DELETE wdetail3.
END.
FOR EACH wcampaign:
    DELETE wcampaign.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_cover C-Win 
PROCEDURE pro_cover :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wcampaign.   
    DELETE wcampaign.   
END.
/*FIND LAST wcampaign WHERE wcampaign.campno =  brstat.Insure.insno  NO-ERROR NO-WAIT.
    IF NOT AVAIL wcampaign THEN DO:*/
   FOR EACH brstat.insure USE-INDEX insure03 WHERE brstat.Insure.CompNo = "ICB_COVER"  NO-LOCK.
        CREATE wcampaign.
        ASSIGN
            wcampaign.campno = brstat.insure.insno 
            wcampaign.id     = brstat.insure.Fname
            wcampaign.cover  = brstat.insure.vatcode 
            wcampaign.pack   = brstat.insure.text3   
            wcampaign.bi     = brstat.insure.text5  
           /*wcampaign.pd1    = brstat.insure.addr1 */  
            wcampaign.pd2    = brstat.insure.addr2  
            /*wcampaign.n41    = brstat.insure.addr3   
            wcampaign.n42    = brstat.insure.addr4  */
            wcampaign.n43    = brstat.insure.telno .
            /*wcampaign.nname  = brstat.insure.compno.*/
        
    END.
    RELEASE brstat.insure.
    


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
DEF VAR n_count AS INT INIT 0.
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  Then
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN nv_row   =  1    n_count = 1.
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "ชื่อไฟล์ : " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' n_camp '"'        SKIP.
nv_row = nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "วันที่ส่งข้อมูล  : "         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' STRING(TODAY,"99/99/9999") FORMAT "x(15)"    '"' SKIP.
nv_row = nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Update Version  : "  '"' SKIP.
nv_row = nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "จำนวนรวมของ Record : " '"' SKIP.
nv_row = nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "จำนวนรวมของเบี้ย :  "  '"' SKIP.
nv_row = nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   "Campaign                                                        "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   "Term Coverage                                                   "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   "Insurance Company                                               "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   "Effective Date From                                             "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   "Effective Date To                                               "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   "รหัสรถ                                                          "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   "กลุ่มรถ                                                         "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   "ประเภทความคุ้มครอง                                              "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   "อายุผู้ขับขี่                                                   "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   "ประเภทการซ่อม                                                   "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   "อายุรถ (ปี)                                                     "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   "ขนาดเครื่องยนต์ / จน.ที่นั่ง / น้ำหนักบรรทุก                    "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   "ประกันปีที่                                                     "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   "ทุนประกันภัยเริ่มต้น                                            "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   "ทุนประกันภัยสิ้นสุด                                             "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   "เบี้ยประกันภัยสุทธิ                                             "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   "เบี้ยรวมภาษีและอากร                                             "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   "เบี้ยรวมหักภาษี ณ ที่จ่าย 1% แล้ว (กรณีนิติบุคคล)               "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   "ความคุ้มครอง-ความเสียหายต่อทรัพย์สินบุคคลภายนอก(บาท/ครั้ง)      "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   "ความคุ้มครอง-ค่ารักษาพยาบาลบุคคลภายในรถ(บาท/คน)                 "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   "File name ตารางความคุ้มครอง                                     "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   "พรบ                                                             "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   "เงื่อนไขพิเศษ อื่นๆ                                             "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   "ประเภทรถ                                                        "    '"' SKIP. 

FOR EACH wdetail2  BREAK BY wdetail2.CLASS
                         BY wdetail2.cc
                         BY wdetail2.car_group
                         BY wdetail2.age_car.
    ASSIGN  nv_row  = nv_row + 1.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' wdetail2.camp FORMAT "x(60)" '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' wdetail2.termcov        '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' wdetail2.inscom         '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdetail2.start_date     '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' wdetail2.Exp_date       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' wdetail2.class          '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' wdetail2.car_Group      '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' wdetail2.covcod         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' wdetail2.age_drive      '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' wdetail2.Garage         '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' wdetail2.age_car        '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' wdetail2.cc             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' wdetail2.ins_year       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' wdetail2.si_st          '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' wdetail2.si_en          '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' wdetail2.netprem        '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' wdetail2.totalpre       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' wdetail2.wht            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' wdetail2.PD             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' wdetail2.AD             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' wdetail2.camp1          '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' wdetail2.comp           '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' wdetail2.Remark FORMAT "x(150)"  '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' wdetail2.typecar        '"' SKIP.
    ASSIGN n_count = n_count + 1.
END.    /*  end  wdetail  */  
nv_row = nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K" '"' "จำนวน Record : "  n_count  '"' SKIP. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
message "Export File  Complete"  view-as alert-box.
/*---------------------------------------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

