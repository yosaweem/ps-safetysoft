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
/*Local Variable Definitions ---                                            */   
/*Program name     : Match Text file KK to excel file                       */  
/*create by        : Kridtiya il. A54-0351  01/12/2011                      */  
/*                   Match file confirm to file Load Text เป็นไฟล์excel     */  
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */ 
/*modify by        : Kridtiya i. A55-0029  ปรับคอลัมน์แสดงเลขกรมธรรม์ จากคอลัมน์สุดท้าย
                     ให้แสดงต่อจาก คอลัมน์ เลขกรมธรรม์เดิม */
/*modify by : Kridtiya i. A55-0055  ปรับให้สถานะกรมธรรม์เปลี่ยนเมื่อพบเลขกรมธรรม์เท่านั้น*/
/*Modify by : Ranu I. A61-0335 Date. 10/07/2018  เพิ่มไฟล์ส่งกลับ KK    */
/*Modify by : Kridtiya i. A63-0472 ขยายขนาด ช่องรับไฟล์                 */
/*Modify by : Ranu I. A64-0135 เพิ่มเงื่อนไขการ Match Policy format new */
/*Modify by : Ranu I. A65-0288 เพิ่มข้อมูลตรวจสภาพ                     */
/*Modify by : Kridtiya i. A66-0140 chang index tlt05 to tlt06    */
/*Modify by : Ranu I. A67-0076 เพิ่มเงื่อนไขการเก็บข้อมูลรถไฟฟ้า */
/*--------------------------------------------------------------------------*/
DEF  stream  ns1.
DEFINE VAR   nv_daily        AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_reccnt       AS  INT  INIT  0.
DEFINE VAR   nv_completecnt  AS   INT   INIT  0.
DEFINE VAR   nv_enttim       AS  CHAR          INIT  "".
def    var   nv_export       as  date  init  ""  format "99/99/9999".
def  stream  ns2.
DEFINE VAR   nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.

DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD recodno        AS CHAR FORMAT "X(10)"  INIT ""  /*  0     */     
    FIELD Notify_dat     AS CHAR FORMAT "X(15)"  INIT ""  /*  1  วันที่รับแจ้ง   */                        
    FIELD recive_dat     AS CHAR FORMAT "X(15)"  INIT ""  /*  2  วันที่รับเงินค่าเบิ้ยประกัน */            
    FIELD comp_code      AS CHAR FORMAT "X(60)"  INIT ""  /*  3  รายชื่อบริษัทประกันภัย  */                
    FIELD cedpol         AS CHAR FORMAT "X(20)"  INIT ""  /*  4  เลขที่สัญญาเช่าซื้อ */                    
    FIELD prepol         AS CHAR FORMAT "X(16)"  INIT ""  /*  5  เลขที่กรมธรรม์เดิม  */                    
    FIELD cmbr_no        AS CHAR FORMAT "X(25)"  INIT ""  /*  6  รหัสสาขา    */                            
    FIELD cmbr_code      AS CHAR FORMAT "X(35)"  INIT ""  /*  7  สาขา KK */                                
    FIELD notifyno       AS CHAR FORMAT "X(20)"  INIT ""  /*  8  เลขรับเเจ้ง */                            
    FIELD campaigno      AS CHAR FORMAT "X(30)"  INIT ""  /*  9  Campaign    */                            
    FIELD campaigsub     AS CHAR FORMAT "X(30)"  INIT ""  /*  10 Sub Campaign    */                        
    FIELD typper         AS CHAR FORMAT "X(20)"  INIT ""  /*  11 บุคคล/นิติบุคคล */                        
    FIELD n_TITLE        AS CHAR FORMAT "X(20)"  INIT ""  /*  12 คำนำหน้าชื่อ    */                        
    FIELD n_name1        AS CHAR FORMAT "X(40)"  INIT ""  /*  13 ชื่อผู้เอาประกัน    */                    
    FIELD n_name2        AS CHAR FORMAT "X(40)"  INIT ""  /*  14 นามสกุลผู้เอาประกัน */                    
    FIELD ADD_1          AS CHAR FORMAT "X(100)"  INIT ""  /*  15 บ้านเลขที่  */                            
    FIELD ADD_2          AS CHAR FORMAT "X(35)"  INIT ""   /*  16 หมู่    */                                
    FIELD ADD_3          AS CHAR FORMAT "X(35)"  INIT ""  /*  17 หมู่บ้าน    */                            
    FIELD ADD_4          AS CHAR FORMAT "X(35)"  INIT ""  /*  18 อาคาร   */                                
    FIELD ADD_5          AS CHAR FORMAT "X(35)"  INIT ""  /*  19 ซอย */                                    
    FIELD cover          AS CHAR FORMAT "X(20)"  INIT ""  /*  25 ประเภทความคุ้มครอง  */                    
    FIELD garage         AS CHAR FORMAT "X(20)"  INIT ""  /*  26 ประเภทการซ่อม   */                        
    FIELD comdat         AS CHAR FORMAT "X(15)"  INIT ""  /*  27 วันเริ่มคุ้มครอง    */                    
    FIELD expdat         AS CHAR FORMAT "X(15)"  INIT ""  /*  28 วันสิ้นสุดคุ้มครอง  */                    
    FIELD subclass       AS CHAR FORMAT "X(20)"  INIT ""  /*  29 รหัสรถ  */                                
    FIELD n_43           AS CHAR FORMAT "X(50)"  INIT ""  /*  30 ประเภทประกันภัยรถยนต์   */                
    FIELD brand          AS CHAR FORMAT "X(20)"  INIT ""  /*  31 ชื่อยี่ห้อรถ    */                        
    FIELD model          AS CHAR FORMAT "X(50)"  INIT ""  /*  32 รุ่นรถ  */                                
    FIELD nSTATUS        AS CHAR FORMAT "X(10)"  INIT ""  /*  33 New/Used    */                            
    FIELD licence        AS CHAR FORMAT "X(45)"  INIT ""  /*  34 เลขทะเบียน  */                            
    FIELD chassis        AS CHAR FORMAT "X(30)"  INIT ""  /*  35 เลขตัวถัง   */                            
    FIELD engine         AS CHAR FORMAT "X(30)"  INIT ""  /*  36 เลขเครื่องยนต์  */                        
    FIELD cyear          AS CHAR FORMAT "X(10)"  INIT ""  /*  37 ปีรถยนต์    */                            
    FIELD power          AS CHAR FORMAT "X(10)"  INIT ""  /*  38 ซีซี    */                                
    FIELD weight         AS CHAR FORMAT "X(10)"  INIT ""  /*  39 น้ำหนัก/ตัน */   
    FIELD seat           AS CHAR FORMAT "X(2)"   INIT ""  /*  ที่นั่ง */   
    FIELD ins_amt1       AS CHAR FORMAT "X(20)"  INIT ""  /*  40 ทุนประกันปี 1   */                        
    FIELD prem1          AS CHAR FORMAT "X(20)"  INIT ""  /*  41 เบี้ยรวมภาษีเเละอากรปี 1    */            
    FIELD ins_amt2       AS CHAR FORMAT "X(20)"  INIT ""  /*  42 ทุนประกันปี 2   */                        
    FIELD prem2          AS CHAR FORMAT "X(20)"  INIT ""  /*  43 เบี้ยรวมภาษีเเละอากรปี 2    */ 
    FIELD fi             AS CHAR FORMAT "X(20)"  INIT ""  /*  สูญหายไฟไหม้ A61-0335 */     
    FIELD time_notify    AS CHAR FORMAT "X(10)"  INIT ""  /*  44 เวลารับเเจ้ง    */                        
    FIELD NAME_mkt       AS CHAR FORMAT "X(50)"  INIT ""  /*  45 ชื่อเจ้าหน้าที่ MKT */                    
    /*FIELD bennam         AS CHAR FORMAT "X(50)"  INIT ""  /*  46 หมายเหตุ    */ */  /*kridtiya i.  A55-0240 */
    FIELD bennam         AS CHAR FORMAT "X(350)"  INIT ""  /*  46 หมายเหตุ    */      /*kridtiya i.  A55-0240 */
/*47*/  FIELD drivno1        AS CHAR FORMAT "X(60)"  INIT ""  /*  47 ผู้ขับขี่ที่ 1 เเละวันเกิด  */            
/*48*/  FIELD drivno2        AS CHAR FORMAT "X(60)"  INIT ""  /*  48 ผู้ขับขี่ที่ 2 เเละวันเกิด  */            
/*49*/  FIELD reci_title     AS CHAR FORMAT "X(20)"  INIT ""  /*  49 คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)  */    
/*50*/  FIELD reci_name1     AS CHAR FORMAT "X(40)"  INIT ""  /*  50 ชื่อ (ใบเสร็จ/ใบกำกับภาษี)  */            
/*51*/  FIELD reci_name2     AS CHAR FORMAT "X(40)"  INIT ""  /*  51 นามสกุล (ใบเสร็จ/ใบกำกับภาษี)   */        
/*54*/  FIELD reci_1         AS CHAR FORMAT "X(35)"  INIT ""  /*  54 อาคาร (ใบเสร็จ/ใบกำกับภาษี) */            
/*55*/  FIELD reci_2         AS CHAR FORMAT "X(35)"  INIT ""  /*  55 ซอย (ใบเสร็จ/ใบกำกับภาษี)   */            
/*56*/  FIELD reci_3         AS CHAR FORMAT "X(35)"  INIT ""  /*  56 ถนน (ใบเสร็จ/ใบกำกับภาษี)   */            
/*57*/  FIELD reci_4         AS CHAR FORMAT "X(35)"  INIT ""  /*  57 ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี) */        
/*58*/  FIELD reci_5         AS CHAR FORMAT "X(35)"  INIT ""  /*  58 อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี) */        
/*59*/  FIELD ncb            AS CHAR FORMAT "X(10)"  INIT ""  /*  61 ส่วนลดประวัติดี */                          
        FIELD fleet          AS CHAR FORMAT "X(10)"  INIT ""  /*  62  ส่วนลดงาน Fleet */ 
        /*-- A61-0335 --*/
        field phone         as char format "x(25)" init ""   /*เบอร์ติดต่อ      */
        field icno          as char format "x(15)" init ""   /*เลขที่บัตรประชาชน           */
        FIELD bdate         AS CHAR FORMAT "X(15)" INIT ""   /*วันเดือนปีเกิด              */
        field tax           as char format "x(15)" init ""   /*อาชีพ                       */
        field cstatus       as char format "x(20)" init ""   /*สถานภาพ                     */
        field occup         as char format "x(45)" init ""   /*เลขประจำตัวผู้เสียภาษีอากร  */
        field icno3         as char format "x(15)" init ""   /*คำนำหน้าชื่อ 1              */
        field lname3        as char format "x(45)" init ""   /*ชื่อกรรมการ 1               */
        field cname3        as char format "x(45)" init ""   /*นามสกุลกรรมการ 1            */
        field tname3        as char format "x(20)" init ""   /*เลขที่บัตรประชาชนกรรมการ 1  */
        field icno2         as char format "x(15)" init ""   /*คำนำหน้าชื่อ 2              */
        field lname2        as char format "x(45)" init ""   /*ชื่อกรรมการ 2               */
        field cname2        as char format "x(45)" init ""   /*นามสกุลกรรมการ 2            */
        field tname2        as char format "x(20)" init ""   /*เลขที่บัตรประชาชนกรรมการ 2  */
        field icno1         as char format "x(15)" init ""   /*คำนำหน้าชื่อ 3              */
        field lname1        as char format "x(45)" init ""   /*ชื่อกรรมการ 3               */
        field cname1        as char format "x(45)" init ""   /*นามสกุลกรรมการ 3            */
        field tname1        as char format "x(20)" init ""   /*เลขที่บัตรประชาชนกรรมการ 3  */
        /*field nsend         as char format "x(50)" init ""  -- A64-0135-- */ /*จัดส่งเอกสารที่สาขา         */
        field nsend         as char format "x(150)" init ""   /*จัดส่งเอกสารที่สาขา         */
        field sendname      as char format "x(100)" init ""  /*ชื่อผู้รับเอกสาร            */
        field bennefit      as char format "x(100)" init ""  /*ผู้รับผลประโยชน์            */
        field KKapp         as char format "x(25)" init ""  /*KKApplicationNo.            */
        /*-- end A61-0335 --*/
        FIELD n_policy       AS CHAR FORMAT "x(15)"  INIT "" 
        /* A64-0135 */
        field typpol     as char format "x(35)" init "" 
        field kkflag     as char format "x(25)" init "" 
        field province   as char format "x(45)" init "" 
        field netprem    as char format "x(15)" init ""   
        field drivdat1   as char format "x(15)" init ""  
        field drivid1    as char format "x(15)" init "" 
        field drivdat2   as char format "x(15)" init ""  
        field drivid2    as char format "x(15)" init "" 
        field remak1     as char format "x(225)" init "" 
        field remak2     as char format "x(225)" init "" 
        field dealercd   as char format "x(50)" init "" 
        field packcod    as char format "x(15)" init "" 
        field campOV     as char format "x(15)" init "" 
        field producer   as char format "x(15)" init "" 
        field Agent      as char format "x(15)" init "" 
        field RefNo      as char format "x(25)" init ""        
        field KKQuo      as char format "x(25)" init "" 
        field RiderNo    as char format "x(25)" init "" 
        field releas     as char format "x(25)" init "" 
        field loandat    as char format "x(20)" init "" 
        FIELD Remark     AS CHAR FORMAT "X(200)" INIT ""
        FIELD brtms      AS CHAR FORMAT "x(50)"  INIT ""
        FIELD dealtms    AS CHAR FORMAT "x(10)"  INIT ""
        FIELD vatcode    AS CHAR FORMAT "x(10)"  INIT ""  
        field gender     as char format "x(50)"  init "" 
        field nation     as char format "x(50)"  init "" 
        field email      as char format "x(50)"  init "" 
        /* end A64-0135 */
        /* add by : A65-0288 */
        FIELD polpremium      AS CHAR FORMAT "x(12)" INIT ""
        FIELD probleam        AS CHAR FORMAT "x(255)" INIT "" 
        FIELD Colors          as char format "X(25)" init ""
        FIELD Inspection      as char format "X(2)" init ""
        field Insp_status     as char format "X(2)" init ""
        field Insp_No         as char format "X(15)" init ""
        field Insp_Closed     as char format "X(15)" init ""
        field Insp_Detail     as char format "X(150)" init ""
        field insp_Damage     as char format "X(250)" init ""
        field insp_Accessory  as char format "X(250)" init "" 
     /* A67-0076 */
    field hp            as char init ""   
    field drititle1     as char init ""   
    field drigender1    as char init ""   
    field drioccup1     as char init ""   
    field driToccup1    as char init ""   
    field driTicono1    as char init ""   
    field driICNo1      as char init "" 
    field drilevel1     as char init "" 
    field drititle2     as char init ""   
    field drigender2    as char init ""   
    field drioccup2     as char init ""   
    field driToccup2    as char init ""   
    field driTicono2    as char init ""   
    field driICNo2      as char init "" 
    field drilevel2     as char init "" 
    field drilic3       as char init ""   
    field drititle3     as char init ""   
    field driname3      as char init ""   
    field drivno3       as char init ""   
    field drigender3    as char init ""   
    field drioccup3     as char init ""   
    field driToccup3    as char init ""   
    field driTicono3    as char init ""   
    field driICNo3      as char init "" 
    field drilevel3     as char init "" 
    field drilic4       as char init ""   
    field drititle4     as char init ""   
    field driname4      as char init ""   
    field drivno4       as char init ""   
    field drigender4    as char init ""   
    field drioccup4     as char init ""   
    field driToccup4    as char init ""   
    field driTicono4    as char init ""   
    field driICNo4      as char init "" 
    field drilevel4     as char init "" 
    field drilic5       as char init ""   
    field drititle5     as char init ""   
    field driname5      as char init ""   
    field drivno5       as char init ""   
    field drigender5    as char init ""   
    field drioccup5     as char init ""   
    field driToccup5    as char init ""   
    field driTicono5    as char init ""   
    field driICNo5      as char init "" 
    field drilevel5     as char init "" 
    field dateregis     as char init ""   
    field pay_option    as char init ""   
    field battno        as char init ""   
    field battyr        as char init ""   
    field maksi         as char init ""   
    field chargno       as char init ""   
    field veh_key       as char init "" .
/* end A67-0076 */

DEF VAR nv_camp   AS CHAR FORMAT "x(100)" .
    /* end : A65-288 */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok bu_exit bu_file ~
fi_outfile2 rs_type RECT-76 RECT-77 
&Scoped-Define DISPLAYED-OBJECTS fi_filename fi_outfile fi_outfile2 rs_type 

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
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 80 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 85 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile2 AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 85 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Old format", 1,
"New format", 2
     SIZE 79.83 BY 1.19
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 110 BY 8.33
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 3.95 COL 12.83 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 5.14 COL 12.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 7.76 COL 61.83
     bu_exit AT ROW 7.76 COL 71.5
     bu_file AT ROW 3.95 COL 96.17
     fi_outfile2 AT ROW 6.29 COL 13 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     rs_type AT ROW 2.67 COL 15.17 NO-LABEL WIDGET-ID 12
     "Input File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 3.95 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "Output File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 5.14 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "File Load Renew Match Policy New" VIEW-AS TEXT
          SIZE 30 BY 1.05 AT ROW 7.43 COL 25 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "  Match Text File Load (KK-Renew) to GW and Premium[Policy]" VIEW-AS TEXT
          SIZE 107.5 BY 1.38 AT ROW 1.19 COL 2.5
          BGCOLOR 18 FGCOLOR 2 FONT 2
     "Output KK :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 6.29 COL 2.67 WIDGET-ID 4
          BGCOLOR 29 FGCOLOR 2 FONT 6
     RECT-76 AT ROW 1.1 COL 1.17
     RECT-77 AT ROW 7.52 COL 60.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 111 BY 8.57
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
         TITLE              = "Match Text File Load (KK)"
         HEIGHT             = 8.67
         WIDTH              = 110.5
         MAX-HEIGHT         = 18.76
         MAX-WIDTH          = 172.33
         VIRTUAL-HEIGHT     = 18.76
         VIRTUAL-WIDTH      = 172.33
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
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match Text File Load (KK) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match Text File Load (KK) */
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
    DEF  VAR NO_add AS CHAR FORMAT "x(50)" .

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    /*"Text Documents" "*.txt",*/
                    "Text Documents" "*.csv",
                            "Data Files (*.*)"     "*.*"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fi_filename  = cvData.
         ASSIGN 
         no_add =    STRING(MONTH(TODAY),"99")    + 
                     STRING(DAY(TODAY),"99")      + 
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) 
         fi_outfile  = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + "_Pol" + no_add + ".slk" . /*.csv*/

         IF rs_type = 1 THEN fi_outfile2 = SUBSTRING(cvData,1,R-INDEX(fi_filename,"\")) + "FileSend_KKRenew_" + no_add + ".slk".
         ELSE fi_outfile2 = "" .
    END.
    DISP fi_filename fi_outfile fi_outfile2 WITH FRAME fr_main.



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    IF rs_type = 1 THEN DO: /*A64-0135*/
        INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
        REPEAT:    
            CREATE wdetail.
            IMPORT DELIMITER "|" 
                wdetail.recodno
                wdetail.Notify_dat   /*1  วันที่รับแจ้ง   */                        
                wdetail.recive_dat   /*2  วันที่รับเงินค่าเบิ้ยประกัน */            
                wdetail.comp_code    /*3  รายชื่อบริษัทประกันภัย  */                
                wdetail.cedpol       /*4  เลขที่สัญญาเช่าซื้อ */                    
                wdetail.prepol       /*5  เลขที่กรมธรรม์เดิม  */                    
                wdetail.cmbr_no      /*6  รหัสสาขา    */                            
                wdetail.cmbr_code    /*7  สาขา KK */                                
                wdetail.notifyno     /*8  เลขรับเเจ้ง */                            
                wdetail.campaigno    /*9  Campaign    */                            
                wdetail.campaigsub   /*10 Sub Campaign    */                        
                wdetail.typper       /*11 บุคคล/นิติบุคคล */                        
                wdetail.n_TITLE      /*12 คำนำหน้าชื่อ    */                        
                wdetail.n_name1      /*13 ชื่อผู้เอาประกัน    */                  
                wdetail.n_name2      /*14 นามสกุลผู้เอาประกัน */           
                wdetail.ADD_1        /*15 บ้านเลขที่  */                          
                wdetail.ADD_2        /*21 ตำบล/แขวง*/                     
                wdetail.ADD_3        /*22 อำเภอ/เขต*/                     
                wdetail.ADD_4        /*23 จังหวัด*/                               
                wdetail.ADD_5        /*24 รหัสไปรษณีย์*/                       
                wdetail.cover        /*  25 ประเภทความคุ้มครอง  */                    
                wdetail.garage       /*  26 ประเภทการซ่อม   */                        
                wdetail.comdat       /*  27 วันเริ่มคุ้มครอง    */                    
                wdetail.expdat       /*  28 วันสิ้นสุดคุ้มครอง  */                    
                wdetail.subclass     /*  29 รหัสรถ  */                                
                wdetail.n_43         /*  30 ประเภทประกันภัยรถยนต์   */                
                wdetail.brand        /*  31 ชื่อยี่ห้อรถ    */                        
                wdetail.model        /*  32 รุ่นรถ  */                                
                wdetail.nSTATUS      /*  33 New/Used    */                            
                wdetail.licence      /*  34 เลขทะเบียน  */                            
                wdetail.chassis      /*  35 เลขตัวถัง   */                            
                wdetail.engine       /*  36 เลขเครื่องยนต์  */                        
                wdetail.cyear        /*  37 ปีรถยนต์    */                            
                wdetail.power        /*  38 ซีซี    */                            
                wdetail.weight       /*  39 น้ำหนัก/ตัน */                        
                wdetail.ins_amt1     /*  40 ทุนประกันปี 1   */                    
                wdetail.prem1        /*  41 เบี้ยรวมภาษีเเละอากรปี 1    */        
                wdetail.ins_amt2     /*  42 ทุนประกันปี 2   */                    
                wdetail.prem2        /*  43 เบี้ยรวมภาษีเเละอากรปี 2    */  
                wdetail.fi           /* ทุนสูญหายไฟไหม้ A61-0335 */           
                wdetail.time_notify  /*  44 เวลารับเเจ้ง    */                    
                wdetail.NAME_mkt     /*  45 ชื่อเจ้าหน้าที่ MKT */                
                wdetail.bennam       /*  46 หมายเหตุ    */                        
                wdetail.drivno1      /*  47 ผู้ขับขี่ที่ 1 เเละวันเกิด        */ 
                wdetail.drivno2      /*  48 ผู้ขับขี่ที่ 2 เเละวันเกิด        */ 
                wdetail.reci_title   /*  49 คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)*/ 
                wdetail.reci_name1   /*  50 ชื่อ (ใบเสร็จ/ใบกำกับภาษี)        */ 
                wdetail.reci_name2   /*  51 นามสกุล (ใบเสร็จ/ใบกำกับภาษี)     */ 
                wdetail.reci_1       /*  52 บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)  */
                wdetail.reci_2       /*  57 ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี) */        
                wdetail.reci_3       /*  58 อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี) */        
                wdetail.reci_4       /*  59 จังหวัด (ใบเสร็จ/ใบกำกับภาษี)   */        
                wdetail.reci_5       /*  60 รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี)*/    
                wdetail.ncb          /*  61 ส่วนลดประวัติดี */                          
                wdetail.fleet       /*  62  ส่วนลดงาน Fleet */ 
                /* A61-0335 */
                wdetail.phone         /*เบอร์ติดต่อ                  */ 
                wdetail.icno          /*เลขที่บัตรประชาชน            */ 
                wdetail.bdate         /*วันเดือนปีเกิด               */ 
                wdetail.occup         /*อาชีพ                        */ 
                wdetail.cstatus       /*สถานภาพ                      */ 
                wdetail.tax           /*เลขประจำตัวผู้เสียภาษีอากร   */ 
                wdetail.tname1        /*คำนำหน้าชื่อ 1               */ 
                wdetail.cname1        /*ชื่อกรรมการ 1                */ 
                wdetail.lname1        /*นามสกุลกรรมการ 1             */ 
                wdetail.icno1         /*เลขที่บัตรประชาชนกรรมการ 1   */ 
                wdetail.tname2        /*คำนำหน้าชื่อ 2               */ 
                wdetail.cname2        /*ชื่อกรรมการ 2                */ 
                wdetail.lname2        /*นามสกุลกรรมการ 2             */ 
                wdetail.icno2         /*เลขที่บัตรประชาชนกรรมการ 2   */ 
                wdetail.tname3        /*คำนำหน้าชื่อ 3               */ 
                wdetail.cname3        /*ชื่อกรรมการ 3                */ 
                wdetail.lname3        /*นามสกุลกรรมการ 3             */ 
                wdetail.icno3         /*เลขที่บัตรประชาชนกรรมการ 3   */ 
                wdetail.nsend         /*จัดส่งเอกสารที่สาขา          */ 
                wdetail.sendname      /*ชื่อผู้รับเอกสาร             */ 
                wdetail.bennefit      /*ผู้รับผลประโยชน์             */ 
                wdetail.KKapp .       /*KKApplicationNo.             */ 
               /* end A61-0335 */
        END.    /* repeat  */
    END.
    ELSE DO: 
        RUN proc_assign. /*A64-0135*/
    END.
    FOR EACH wdetail.
        IF index(wdetail.recodno,"บริษัท") <> 0 THEN DELETE wdetail.
        ELSE IF index(wdetail.recodno,"ลำดับ") <> 0 THEN DELETE wdetail.
    END.
    RUN  Pro_matchfile_prem.
    IF rs_type = 1 THEN DO:
        Run  Pro_createfile.
        RUN  pro_createfileKK. /*A61-0335*/
    END.
    ELSE DO:
        RUN proc_filenew .
    END.
    Message "Export data Complete"  View-as alert-box.
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


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile2 C-Win
ON LEAVE OF fi_outfile2 IN FRAME fr_main
DO:
  fi_outfile2  =  Input  fi_outfile2.
  Disp  fi_outfile2 with frame  fr_main.
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
  
      gv_prgid = "WGWMATKK.W".
  gv_prog  = "Import Text && OUTPUT File Confirm (KK) to Excel".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN rs_type =  1.
  DISP rs_type WITH FRAM fr_main.
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assign C-Win 
PROCEDURE 00-proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A64-0135       
------------------------------------------------------------------------------*/
/* comment by : A67-0076 ...
DO:
    INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.recodno        /* ลำดับที่                     */
            wdetail.Notify_dat     /* วันที่รับแจ้ง                */
            wdetail.recive_dat     /* วันที่รับเงินค่าเบิ้ยประกัน  */
            wdetail.comp_code      /* รายชื่อบริษัทประกันภัย       */
            wdetail.cedpol         /* เลขที่สัญญาเช่าซื้อ          */
            wdetail.typpol         /* New/Renew                    */
            wdetail.prepol         /* เลขที่กรมธรรม์เดิม           */
            wdetail.cmbr_no        /* รหัสสาขา                     */
            wdetail.cmbr_code      /* สาขา KK                      */
            wdetail.brtms          /* สาขา TMSTH                  */
            wdetail.notifyno       /* เลขรับเเจ้ง                  */
            wdetail.kkflag         /* KK offer */
            wdetail.campaigno      /* Campaign                     */
            wdetail.campaigsub     /* Sub Campaign                 */
            wdetail.typper         /* บุคคล/นิติบุคคล              */
            wdetail.n_TITLE        /* คำนำหน้าชื่อ                 */
            wdetail.n_name1        /* ชื่อผู้เอาประกัน             */
            wdetail.n_name2        /* นามสกุลผู้เอาประกัน          */
            wdetail.ADD_1          /* บ้านเลขที่                   */
            wdetail.ADD_2          /* ตำบล/แขวง                    */
            wdetail.ADD_3          /* อำเภอ/เขต                    */
            wdetail.ADD_4          /* จังหวัด                      */
            wdetail.ADD_5          /* รหัสไปรษณีย์                 */
            wdetail.cover          /* ประเภทความคุ้มครอง           */
            wdetail.garage         /* ประเภทการซ่อม                */
            wdetail.comdat         /* วันเริ่มคุ้มครอง             */
            wdetail.expdat         /* วันสิ้นสุดคุ้มครอง           */
            wdetail.subclass       /* รหัสรถ                       */
            wdetail.n_43           /* ประเภทประกันภัยรถยนต์        */
            wdetail.brand          /* ชื่อยี่ห้อรถ                 */
            wdetail.model          /* รุ่นรถ                       */
            wdetail.nSTATUS        /* New/Used                     */
            wdetail.licence        /* เลขทะเบียน                   */
            wdetail.province       /* จังหวัดจดทะเบียน             */
            wdetail.chassis        /* เลขตัวถัง                    */
            wdetail.engine         /* เลขเครื่องยนต์              */
            wdetail.cyear          /* ปีรถยนต์                    */
            wdetail.power          /* ซีซี                        */
            wdetail.weight         /* น้ำหนัก/ตัน                 */
            wdetail.seat           /* ที่นั่ง */
            wdetail.ins_amt1       /* ทุนประกันปี 1               */
            wdetail.netprem        /* เบี้ยสุทธิ                  */
            wdetail.prem1          /* เบี้ยรวมภาษีเเละอากรปี 1    */
            wdetail.time_notif     /* เวลารับเเจ้ง                */
            wdetail.NAME_mkt       /* ชื่อเจ้าหน้าที่ MKT         */
            wdetail.bennam         /* หมายเหตุ                    */
            wdetail.drivno1        /* ผู้ขับขี่ที่ 1              */
            wdetail.drivdat1       /* วันเกิดผู้ขับขี่ 1          */
            wdetail.drivid1        /* เลขที่ใบขับขี่ 1            */
            wdetail.drivno2        /* ผู้ขับขี่ที่ 2              */
            wdetail.drivdat2       /* วันเกิดผู้ขับขี่ 2          */
            wdetail.drivid2        /* เลขที่ใบขับขี่ 2            */
            wdetail.reci_title     /* คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี) */
            wdetail.reci_name1     /* ชื่อ (ใบเสร็จ/ใบกำกับภาษี)         */
            wdetail.reci_name2     /* นามสกุล (ใบเสร็จ/ใบกำกับภาษี)      */
            wdetail.reci_1         /* บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)   */
            wdetail.reci_2         /* ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)    */
            wdetail.reci_3         /* อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)    */
            wdetail.reci_4         /* จังหวัด (ใบเสร็จ/ใบกำกับภาษี)      */
            wdetail.reci_5         /* รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี) */
            wdetail.ncb            /* ส่วนลดประวัติดี             */
            wdetail.fleet          /* ส่วนลดงาน Fleet             */
            wdetail.phone          /* เบอร์ติดต่อ                 */
            wdetail.icno           /* เลขที่บัตรประชาชน           */
            wdetail.bdate          /* วันเดือนปีเกิด              */
            wdetail.occup          /* อาชีพ                       */
            wdetail.cstatus        /* สถานภาพ                     */
            wdetail.gender         /* เพศ */
            wdetail.nation         /* สัญชาติ */
            wdetail.email          /* อีเมล์ */
            wdetail.tax            /* เลขประจำตัวผู้เสียภาษีอากร  */
            wdetail.tname1         /* คำนำหน้าชื่อ 1              */
            wdetail.cname1         /* ชื่อกรรมการ 1               */
            wdetail.lname1         /* นามสกุลกรรมการ 1            */
            wdetail.icno1          /* เลขที่บัตรประชาชนกรรมการ 1  */
            wdetail.tname2         /* คำนำหน้าชื่อ 2              */
            wdetail.cname2         /* ชื่อกรรมการ 2               */
            wdetail.lname2         /* นามสกุลกรรมการ 2            */
            wdetail.icno2          /* เลขที่บัตรประชาชนกรรมการ 2  */
            wdetail.tname3         /* คำนำหน้าชื่อ 3              */
            wdetail.cname3         /* ชื่อกรรมการ 3               */
            wdetail.lname3         /* นามสกุลกรรมการ 3            */
            wdetail.icno3          /* เลขที่บัตรประชาชนกรรมการ 3  */
            wdetail.nsend          /* จัดส่งเอกสารที่สาขา         */
            wdetail.sendname       /* ชื่อผู้รับเอกสาร            */
            wdetail.bennefit       /* ผู้รับผลประโยชน์            */
            wdetail.KKapp          /* KK ApplicationNo            */
            wdetail.remak1         /* Remak1                      */
            wdetail.remak2         /* Remak2                      */
            wdetail.dealercd       /* Dealer KK                     */
            wdetail.dealtms        /* dealer TMSTH */
            wdetail.packcod        /* Campaignno TMSTH            */
            wdetail.campOV         /* Campaign OV                 */
            wdetail.producer       /* Producer code      */
            wdetail.Agent          /* Agent code        */
            Wdetail.RefNo          /*ReferenceNo  */
            Wdetail.KKQuo          /* KK Quotation No.*/
            Wdetail.RiderNo        /* Rider  No.  */
            wdetail.releas         /* Release                     */
            wdetail.loandat       /* Loan First Date             */
            /* add by : A65-0288 */
            wdetail.polpremium  
            wdetail.probleam
            wdetail.Colors          /* Color                */  
            wdetail.Inspection      /* Inspection           */  
            wdetail.Insp_status     /* Inspection status    */  
            wdetail.Insp_No         /* Inspection No        */  
            wdetail.Insp_Closed     /* Inspection Closed Date */
            wdetail.Insp_Detail     /* Inspection Detail    */  
            wdetail.insp_Damage     /* inspection Damage    */  
            wdetail.insp_Accessory . /*inspection Accessory */  
           /* end : A65-0288 */
        IF index(wdetail.recodno,"ที่") <> 0 THEN DELETE wdetail.
        ELSE IF INDEX(wdetail.recodno,"คุ้มภัย") <> 0 THEN DELETE wdetail.
        ELSE IF wdetail.recodno = " "  THEN DELETE wdetail.

    END. 
    FOR EACH wdetail. 
        IF      index(wdetail.cover,"1")   <> 0  THEN ASSIGN wdetail.cover = "1" .
        ELSE IF index(wdetail.cover,"2+")  <> 0  THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2 +") <> 0  THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2")   <> 0  AND index(wdetail.cover,"Plus") <> 0 THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2")   <> 0  THEN ASSIGN wdetail.cover = "2" .
        ELSE IF index(wdetail.cover,"3+")  <> 0  THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3 +") <> 0  THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3")   <> 0  AND index(wdetail.cover,"Plus") <> 0 THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3")   <> 0  THEN ASSIGN wdetail.cover = "3" .
        ELSE IF (INDEX(wdetail.cover,"พ.ร.บ.") <> 0 OR INDEX(wdetail.cover,"ภาคบังคับ") <> 0) THEN wdetail.cover = "T" .

      /*  IF index(wdetail.garage,"ห้าง") <> 0 THEN  ASSIGN wdetail.garage = "G" .
        ELSE ASSIGN wdetail.garage = " " . */
    END.

END.
..end A67-0076...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_filenew C-Win 
PROCEDURE 00-proc_filenew :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0076 ....
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "ธนาคารเกียรตินาคินภัทร จำกัด (มหาชน) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "ลำดับที่        "                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่รับแจ้ง   "                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "วันที่รับเงินค่าเบิ้ยประกัน "          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "รายชื่อบริษัทประกันภัย "               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "เลขที่สัญญาเช่าซื้อ"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "New/Renew          "                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "Policy No.         "                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "เลขที่กรมธรรม์เดิม "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "รหัสสาขา           "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "สาขา KK            "                   '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "สาขา TMSTH         "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "เลขรับเเจ้ง        "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "KK Offer Flag      "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Campaign           "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "Sub Campaign       "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "บุคคล/นิติบุคคล    "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "คำนำหน้าชื่อ       "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "ชื่อผู้เอาประกัน   "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "นามสกุลผู้เอาประกัน"                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "บ้านเลขที่         "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "ตำบล/แขวง          "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "อำเภอ/เขต          "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "จังหวัด            "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "รหัสไปรษณีย์       "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "ประเภทความคุ้มครอง "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "ประเภทการซ่อม      "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "วันเริ่มคุ้มครอง   "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "วันสิ้นสุดคุ้มครอง "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "รหัสรถ             "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "ประเภทประกันภัยรถยนต์ "                '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "ชื่อยี่ห้อรถ     "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "รุ่นรถ           "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "New/Used         "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "เลขทะเบียน       "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "จังหวัดจดทะเบียน "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "เลขตัวถัง        "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "เลขเครื่องยนต์   "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "ปีรถยนต์         "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "ซีซี             "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "น้ำหนัก/ตัน      "                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "ที่นั่ง    "                           '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "ทุนประกันปี 1    "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "เบี้ยสุทธิ       "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "เบี้ยรวมภาษีเเละอากรปี 1 "             '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "เวลารับเเจ้ง     "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "ชื่อเจ้าหน้าที่ MKT"                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "หมายเหตุ         "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "ผู้ขับขี่ที่ 1   "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "วันเกิดผู้ขับขี่ 1 "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "เลขที่ใบขับขี่ 1 "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "ผู้ขับขี่ที่ 2   "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "วันเกิดผู้ขับขี่ 2 "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "เลขที่ใบขับขี่ 2 "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)"    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "ชื่อ (ใบเสร็จ/ใบกำกับภาษี)        "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "นามสกุล (ใบเสร็จ/ใบกำกับภาษี)     "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)  "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)   "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)   "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' "จังหวัด (ใบเสร็จ/ใบกำกับภาษี)     "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี)"    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "ส่วนลดประวัติดี   "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "ส่วนลดงาน Fleet   "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "เบอร์ติดต่อ       "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "เลขที่บัตรประชาชน "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "วันเดือนปีเกิด    "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "อาชีพ             "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "สถานภาพ           "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "เพศ"                                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "สัญชาติ     "                          '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "อีเมล์      "                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "เลขประจำตัวผู้เสียภาษีอากร"            '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "คำนำหน้าชื่อ 1     "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' "ชื่อกรรมการ 1      "                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' "นามสกุลกรรมการ 1   "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' "เลขที่บัตรประชาชนก รรมการ 1"           '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"' "คำนำหน้าชื่อ 2     "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' "ชื่อกรรมการ 2      "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' "นามสกุลกรรมการ 2   "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' "เลขที่บัตรประชาชนก รรมการ 2"           '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' "คำนำหน้าชื่อ 3     "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' "ชื่อกรรมการ 3      "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' "นามสกุลกรรมการ 3   "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' "เลขที่บัตรประชาชนกรรมการ 3"            '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' "จัดส่งเอกสารที่สาขา    "               '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' "ชื่อผู้รับเอกสาร "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' "ผู้รับผลประโยชน์ "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' "KK ApplicationNo "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' "Remak1     "               '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' "Remak2     "               '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' "Dealer KK    "             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' "Dealer TMSTH     "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' "Campaign no TMSTH"         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' "Campaign OV      "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' "Producer         "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' "Agent            "         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' "Vat code         "         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K"  '"' "ReferenceNo      "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K"  '"' "KK Quotation No. "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"' "Rider  No.       "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"' "Release          "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"' "Loan First Date  "         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"' "Policy Premium   "         '"' SKIP.  /* A65-0288*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"' "Note Problem     "         '"' SKIP.  /* A65-0288*/                                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"' "Color            "         '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"' "Inspection       "         '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"' "Inspection status"         '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"' "Inspection No    "         '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"' "Inspection Closed Date"    '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"' "Inspection Detail  "       '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"' "inspection Damage  "       '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"' "inspection Accessory  "    '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"' "หมายเหตุ  "                '"' SKIP.       

RUN proc_filenew02.
...end A67-0076 ...*/
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_filenew02 C-Win 
PROCEDURE 00-proc_filenew02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0076 ...
FOR EACH wdetail WHERE wdetail.chassis <> "" no-lock.
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt   + 1 
        nv_row   =  nv_row   + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record                  '"' SKIP. /* ลำดับที่                     */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.Notify_dat        '"' SKIP. /* วันที่รับแจ้ง                */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.recive_dat        '"' SKIP. /* วันที่รับเงินค่าเบิ้ยประกัน  */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.comp_code         '"' SKIP. /* รายชื่อบริษัทประกันภัย       */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.cedpol            '"' SKIP. /* เลขที่สัญญาเช่าซื้อ          */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.typpol            '"' SKIP. /* New/Renew                    */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.n_policy          '"' SKIP. /* เลขที่กรมธรรม์ใหม่           */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.prepol            '"' SKIP. /* เลขที่กรมธรรม์เดิม           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.cmbr_no           '"' SKIP. /* รหัสสาขา                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.cmbr_code         '"' SKIP. /* สาขา KK                      */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.brtms             '"' SKIP. /* สาขา TMSTH                  */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.notifyno          '"' SKIP. /* เลขรับเเจ้ง                  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.kkflag            '"' SKIP. /* KK offer */                                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.campaigno         '"' SKIP. /* Campaign                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.campaigsub        '"' SKIP. /* Sub Campaign                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.typper            '"' SKIP. /* บุคคล/นิติบุคคล              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.n_TITLE           '"' SKIP. /* คำนำหน้าชื่อ                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.n_name1           '"' SKIP. /* ชื่อผู้เอาประกัน             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.n_name2           '"' SKIP. /* นามสกุลผู้เอาประกัน          */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.ADD_1             '"' SKIP. /* บ้านเลขที่                   */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.ADD_2             '"' SKIP. /* ตำบล/แขวง                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.ADD_3             '"' SKIP. /* อำเภอ/เขต                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.ADD_4             '"' SKIP. /* จังหวัด                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.ADD_5             '"' SKIP. /* รหัสไปรษณีย์                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.cover             '"' SKIP. /* ประเภทความคุ้มครอง           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.garage            '"' SKIP. /* ประเภทการซ่อม                */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail.comdat            '"' SKIP. /* วันเริ่มคุ้มครอง             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.expdat            '"' SKIP. /* วันสิ้นสุดคุ้มครอง           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail.subclass          '"' SKIP. /* รหัสรถ                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.n_43              '"' SKIP. /* ประเภทประกันภัยรถยนต์        */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.brand             '"' SKIP. /* ชื่อยี่ห้อรถ                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail.model             '"' SKIP. /* รุ่นรถ                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail.nSTATUS           '"' SKIP. /* New/Used                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail.licence           '"' SKIP. /* เลขทะเบียน                   */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.province          '"' SKIP. /* จังหวัดจดทะเบียน             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.chassis           '"' SKIP. /* เลขตัวถัง                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.engine            '"' SKIP. /* เลขเครื่องยนต์              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.cyear             '"' SKIP. /* ปีรถยนต์                    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail.power             '"' SKIP. /* ซีซี                        */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  wdetail.weight            '"' SKIP. /* น้ำหนัก/ตัน                 */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  wdetail.seat              '"' SKIP. /* ที่นั่ง              */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail.ins_amt1          '"' SKIP. /* ทุนประกันปี 1               */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail.netprem           '"' SKIP. /* เบี้ยสุทธิ                  */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail.prem1             '"' SKIP. /* เบี้ยรวมภาษีเเละอากรปี 1    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail.time_notify       '"' SKIP. /* เวลารับเเจ้ง                */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  wdetail.NAME_mkt          '"' SKIP. /* ชื่อเจ้าหน้าที่ MKT         */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'  wdetail.bennam            '"' SKIP. /* หมายเหตุ                    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"'  wdetail.drivno1           '"' SKIP. /* ผู้ขับขี่ที่ 1              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  wdetail.drivdat1          '"' SKIP. /* วันเกิดผู้ขับขี่ 1          */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"'  wdetail.drivid1           '"' SKIP. /* เลขที่ใบขับขี่ 1            */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"'  wdetail.drivno2           '"' SKIP. /* ผู้ขับขี่ที่ 2              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"'  wdetail.drivdat2          '"' SKIP. /* วันเกิดผู้ขับขี่ 2          */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"'  wdetail.drivid2           '"' SKIP. /* เลขที่ใบขับขี่ 2            */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"'  wdetail.reci_title        '"' SKIP. /* คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)*/                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  wdetail.reci_name1        '"' SKIP.  /* ชื่อ (ใบเสร็จ/ใบกำกับภาษี)      */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  wdetail.reci_name2        '"' SKIP.  /* นามสกุล (ใบเสร็จ/ใบกำกับภาษี)   */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  wdetail.reci_1            '"' SKIP.  /* บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)*/                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  wdetail.reci_2            '"' SKIP.  /* ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี) */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  wdetail.reci_3             '"' SKIP. /* อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี) */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  wdetail.reci_4             '"' SKIP. /* จังหวัด (ใบเสร็จ/ใบกำกับภาษี)   */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  wdetail.reci_5             '"' SKIP. /* รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี) */                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  wdetail.ncb                '"' SKIP. /* ส่วนลดประวัติดี             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  wdetail.fleet              '"' SKIP. /* ส่วนลดงาน Fleet             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  wdetail.phone              '"' SKIP. /* เบอร์ติดต่อ                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  wdetail.icno               '"' SKIP. /* เลขที่บัตรประชาชน           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  wdetail.bdate              '"' SKIP. /* วันเดือนปีเกิด              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  wdetail.occup              '"' SKIP. /* อาชีพ                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  wdetail.cstatus            '"' SKIP. /* สถานภาพ                     */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  wdetail.gender             '"' SKIP. /* เพศ */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  wdetail.nation             '"' SKIP. /* สัญชาติ */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  wdetail.email              '"' SKIP. /* อีเมล์  */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  wdetail.tax                '"' SKIP. /* เลขประจำตัวผู้เสียภาษีอากร  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  wdetail.tname1             '"' SKIP. /* คำนำหน้าชื่อ 1              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  wdetail.cname1             '"' SKIP. /* ชื่อกรรมการ 1               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  wdetail.lname1             '"' SKIP. /* นามสกุลกรรมการ 1            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  wdetail.icno1              '"' SKIP. /* เลขที่บัตรประชาชนกรรมการ 1  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  wdetail.tname2             '"' SKIP. /* คำนำหน้าชื่อ 2              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  wdetail.cname2             '"' SKIP. /* ชื่อกรรมการ 2               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"'  wdetail.lname2             '"' SKIP. /* นามสกุลกรรมการ 2            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"'  wdetail.icno2              '"' SKIP. /* เลขที่บัตรประชาชนกรรมการ 2  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"'  wdetail.tname3             '"' SKIP. /* คำนำหน้าชื่อ 3              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"'  wdetail.cname3             '"' SKIP. /* ชื่อกรรมการ 3               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"'  wdetail.lname3             '"' SKIP. /* นามสกุลกรรมการ 3            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"'  wdetail.icno3              '"' SKIP. /* เลขที่บัตรประชาชนกรรมการ 3  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"'  wdetail.nsend              '"' SKIP. /* จัดส่งเอกสารที่สาขา         */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"'  wdetail.sendname           '"' SKIP. /* ชื่อผู้รับเอกสาร            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"'  wdetail.bennefit           '"' SKIP. /* ผู้รับผลประโยชน์            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"'  wdetail.KKapp              '"' SKIP. /* KK ApplicationNo            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"'  wdetail.remak1             '"' SKIP. /* Remak1                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"'  wdetail.remak2             '"' SKIP. /* Remak2                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"'  wdetail.dealercd           '"' SKIP. /* Dealer                      */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"'  wdetail.dealtms            '"' SKIP. /* Dealer TMSTH            */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"'  wdetail.packcod            '"' SKIP. /* Campaignno TMSTH            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"'  wdetail.campOV             '"' SKIP. /* Campaign OV                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"'  wdetail.producer           '"' SKIP. /* Producer code      */                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"'  wdetail.Agent              '"' SKIP. /* Agent code        */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"'  Wdetail.vatcode            '"' SKIP. /*vat code  */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K"  '"'  Wdetail.RefNo              '"' SKIP. /*ReferenceNo  */                                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K"  '"'  Wdetail.KKQuo              '"' SKIP. /* KK Quotation No.*/                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"'  Wdetail.RiderNo            '"' SKIP. /* Rider  No.  */                                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"'  wdetail.releas             '"' SKIP. /* Release                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"'  wdetail.loandat            '"' SKIP. /* Loan First Date             */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"'  wdetail.PolPremium             '"' SKIP.  /*A65-0288*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"'  wdetail.polpremium         '"' SKIP.  /*A65-0288*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"'  wdetail.Colors             '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"'  wdetail.Inspection         '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"'  wdetail.Insp_status        '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"'  wdetail.Insp_No            '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"'  wdetail.Insp_Closed        '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"'  wdetail.Insp_Detail        '"' SKIP.   /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"'  wdetail.insp_Damage        '"' SKIP.   /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"'  wdetail.insp_Accessory     '"' SKIP.   /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"'  wdetail.remark             '"' SKIP.   
END. 
                                                                                     
nv_row  =  nv_row  + 1.                                                              
PUT STREAM ns2 "E".                                                                  
OUTPUT STREAM ns2 CLOSE.                                                             
 ...end A67-0076 ...*/                                                                                    
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
  DISPLAY fi_filename fi_outfile fi_outfile2 rs_type 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok bu_exit bu_file fi_outfile2 rs_type 
         RECT-76 RECT-77 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign C-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A64-0135       
------------------------------------------------------------------------------*/
DO:
    INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.recodno         /* ลำดับที่                     */                  
            wdetail.Notify_dat    /* วันที่รับแจ้ง                */                  
            wdetail.recive_dat    /* วันที่รับเงินค่าเบิ้ยประกัน  */                  
            wdetail.comp_code     /* รายชื่อบริษัทประกันภัย       */                  
            wdetail.cedpol        /* เลขที่สัญญาเช่าซื้อ          */                  
            wdetail.typpol        /* New/Renew                    */                  
            wdetail.prepol        /* เลขที่กรมธรรม์เดิม           */                  
            wdetail.cmbr_no       /* รหัสสาขา                     */                  
            wdetail.cmbr_code     /* สาขา KK                      */                  
            wdetail.brtms         /* สาขา TMSTH                   */                  
            wdetail.notifyno      /* เลขรับเเจ้ง                  */                  
            wdetail.kkflag        /* KK offer */                                      
            wdetail.campaigno     /* Campaign                     */                  
            wdetail.campaigsub    /* Sub Campaign                 */                  
            wdetail.typper        /* บุคคล/นิติบุคคล              */                  
            wdetail.n_TITLE       /* คำนำหน้าชื่อ                 */                  
            wdetail.n_name1       /* ชื่อผู้เอาประกัน             */                  
            wdetail.n_name2       /* นามสกุลผู้เอาประกัน          */                  
            wdetail.ADD_1         /* บ้านเลขที่                   */                  
            wdetail.ADD_2         /* ตำบล/แขวง                    */                  
            wdetail.ADD_3         /* อำเภอ/เขต                    */                  
            wdetail.ADD_4         /* จังหวัด                      */                  
            wdetail.ADD_5         /* รหัสไปรษณีย์                 */                  
            wdetail.cover         /* ประเภทความคุ้มครอง           */                  
            wdetail.garage        /* ประเภทการซ่อม                */                  
            wdetail.comdat        /* วันเริ่มคุ้มครอง             */                  
            wdetail.expdat        /* วันสิ้นสุดคุ้มครอง           */                  
            wdetail.subclass      /* รหัสรถ                       */                  
            wdetail.n_43          /* ประเภทประกันภัยรถยนต์        */                  
            wdetail.brand         /* ชื่อยี่ห้อรถ                 */                  
            wdetail.model         /* รุ่นรถ                       */                  
            wdetail.nSTATUS       /* New/Used                     */                  
            wdetail.licence       /* เลขทะเบียน                   */                  
            wdetail.province       /* จังหวัดจดทะเบียน             */                 
            wdetail.chassis       /* เลขตัวถัง                    */                  
            wdetail.engine        /* เลขเครื่องยนต์              */                   
            wdetail.cyear         /* ปีรถยนต์                    */                   
            wdetail.power         /* ซีซี                        */                   
            wdetail.hp            /* แรงม้า */                         /* A67-0076 */ 
            wdetail.weight        /* น้ำหนัก/ตัน                 */                   
            wdetail.seat          /* ที่นั่ง */                                       
            wdetail.ins_amt1      /* ทุนประกันปี 1               */                   
            wdetail.netprem       /* เบี้ยสุทธิ                  */                   
            wdetail.prem1         /* เบี้ยรวมภาษีเเละอากรปี 1    */                   
            wdetail.time_notify   /* เวลารับเเจ้ง                */                   
            wdetail.NAME_mkt      /* ชื่อเจ้าหน้าที่ MKT         */                   
            wdetail.bennam        /* หมายเหตุ                    */                   
            wdetail.drititle1     /* คำนำหน้าชื่อ */             /* A67-0076 */       
            wdetail.drivno1       /* ผู้ขับขี่ที่ 1              */                   
            wdetail.drivdat1      /* วันเกิดผู้ขับขี่ 1          */                   
            wdetail.drivid1       /* เลขที่ใบขับขี่ 1            */                   
            wdetail.drigender1     /* A67-0076 */                                     
            wdetail.drioccup1      /* A67-0076 */                                     
            wdetail.driICNo1       /* A67-0076 */                                     
            wdetail.drilevel1      /* A67-0076 */                                     
            wdetail.drititle2      /* A67-0076 */                                     
            wdetail.drivno2       /* ผู้ขับขี่ที่ 2              */                   
            wdetail.drivdat2      /* วันเกิดผู้ขับขี่ 2          */                   
            wdetail.drivid2       /* เลขที่ใบขับขี่ 2            */                   
            /* add : A67-0076 */                                                       
            wdetail.drigender2                                                        
            wdetail.drioccup2                                                         
            wdetail.driICNo2                                                          
            wdetail.drilevel2                                                         
            wdetail.drilic3                                                           
            wdetail.drititle3                                                         
            wdetail.driname3                                                          
            wdetail.drivno3                                                           
            wdetail.drigender3                                                        
            wdetail.drioccup3                                                         
            wdetail.driICNo3                                                          
            wdetail.drilevel3                                                         
            wdetail.drilic4                                                           
            wdetail.drititle4                                                         
            wdetail.driname4                                                          
            wdetail.drivno4                                                           
            wdetail.drigender4                                                        
            wdetail.drioccup4                                                         
            wdetail.driICNo4                                                          
            wdetail.drilevel4                                                         
            wdetail.drilic5                                                           
            wdetail.drititle5                                                         
            wdetail.driname5                                                          
            wdetail.drivno5                                                           
            wdetail.drigender5                                                        
            wdetail.drioccup5                                                         
            wdetail.driICNo5                                                          
            wdetail.drilevel5                                                         
            /* end : A67-0076 */                                                       
            wdetail.reci_title    /* คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี) */            
            wdetail.reci_name1    /* ชื่อ (ใบเสร็จ/ใบกำกับภาษี)         */            
            wdetail.reci_name2    /* นามสกุล (ใบเสร็จ/ใบกำกับภาษี)      */            
            wdetail.reci_1        /* บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)   */            
            wdetail.reci_2        /* ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)    */            
            wdetail.reci_3        /* อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)    */            
            wdetail.reci_4        /* จังหวัด (ใบเสร็จ/ใบกำกับภาษี)      */            
            wdetail.reci_5        /* รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี) */            
            wdetail.ncb           /* ส่วนลดประวัติดี             */                   
            wdetail.fleet         /* ส่วนลดงาน Fleet             */                   
            wdetail.phone         /* เบอร์ติดต่อ                 */                   
            wdetail.icno          /* เลขที่บัตรประชาชน           */                   
            wdetail.bdate         /* วันเดือนปีเกิด              */                   
            wdetail.occup         /* อาชีพ                       */                   
            wdetail.cstatus       /* สถานภาพ                     */                   
            wdetail.gender        /* เพศ   */                                         
            wdetail.nation        /* สัญชาติ   */                                     
            wdetail.email         /* เมล์   */                                        
            wdetail.tax           /* เลขประจำตัวผู้เสียภาษีอากร  */                   
            wdetail.tname1        /* คำนำหน้าชื่อ 1              */                   
            wdetail.cname1        /* ชื่อกรรมการ 1               */                   
            wdetail.lname1        /* นามสกุลกรรมการ 1            */                   
            wdetail.icno1         /* เลขที่บัตรประชาชนกรรมการ 1  */                   
            wdetail.tname2        /* คำนำหน้าชื่อ 2              */                   
            wdetail.cname2        /* ชื่อกรรมการ 2               */                   
            wdetail.lname2        /* นามสกุลกรรมการ 2            */                   
            wdetail.icno2         /* เลขที่บัตรประชาชนกรรมการ 2  */                   
            wdetail.tname3        /* คำนำหน้าชื่อ 3              */                   
            wdetail.cname3        /* ชื่อกรรมการ 3               */                   
            wdetail.lname3        /* นามสกุลกรรมการ 3            */                   
            wdetail.icno3         /* เลขที่บัตรประชาชนกรรมการ 3  */                   
            wdetail.nsend         /* จัดส่งเอกสารที่สาขา         */                   
            wdetail.sendname      /* ชื่อผู้รับเอกสาร            */                   
            wdetail.bennefit      /* ผู้รับผลประโยชน์            */                   
            wdetail.KKapp         /* KK ApplicationNo            */                   
            wdetail.remak1        /* Remak1                      */                   
            wdetail.remak2        /* Remak2                      */                   
            wdetail.dealercd      /* Dealer KK                    */                  
            wdetail.dealtms       /* Dealer TMSTH                  */                 
            wdetail.packcod       /* Campaignno TMSTH            */                   
            wdetail.campOV        /* Campaign OV                 */                   
            wdetail.producer      /* Producer code      */                            
            wdetail.Agent         /* Agent code        */                             
            wdetail.RefNo         /*ReferenceNo  */                                   
            wdetail.KKQuo         /* KK Quotation No.*/                               
            wdetail.RiderNo       /* Rider  No.  */                                   
            wdetail.releas        /* Release                     */                   
            wdetail.loandat       /* Loan First Date             */                   
            /* add by : A65-0288 */                                                    
            wdetail.PolPrem           /*Policy Premium   */                           
            wdetail.probleam     /*Note Un Problem  */                               
            wdetail.colors        /* color  */ 
            wdetail.Inspection    /* ตรวจสภาพ */           
            wdetail.Insp_status   /* สถานะกล่องตรวจสภาพ*/  
            wdetail.Insp_No       /* เลขกล่อง*/            
            wdetail.Insp_Closed   /* วันที่ปิดเรื่อง*/     
            wdetail.Insp_Detail   /* ผลตรวจสภาพ*/          
            wdetail.insp_Damage   /* รายการความเสียหาย*/   
            wdetail.insp_Accessory /* อุปกรณ์เสริม */   
            /* end : A65-0288 */                                                       
            /* A67-0076 */                                                             
            wdetail.dateregis                                                         
            wdetail.pay_option                                                        
            wdetail.battno                                                            
            wdetail.battyr                                                            
            wdetail.maksi                                                             
            wdetail.chargno                                                           
            wdetail.veh_key .                                                         
            /*  end : A67-0076 */     
        IF index(wdetail.recodno,"ที่") <> 0 THEN DELETE wdetail.
        ELSE IF INDEX(wdetail.recodno,"คุ้มภัย") <> 0 THEN DELETE wdetail.
        ELSE IF wdetail.recodno = " "  THEN DELETE wdetail.

    END. 
    FOR EACH wdetail. 
        IF      index(wdetail.cover,"1")   <> 0  THEN ASSIGN wdetail.cover = "1" .
        ELSE IF index(wdetail.cover,"2+")  <> 0  THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2 +") <> 0  THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2")   <> 0  AND index(wdetail.cover,"Plus") <> 0 THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2")   <> 0  THEN ASSIGN wdetail.cover = "2" .
        ELSE IF index(wdetail.cover,"3+")  <> 0  THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3 +") <> 0  THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3")   <> 0  AND index(wdetail.cover,"Plus") <> 0 THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3")   <> 0  THEN ASSIGN wdetail.cover = "3" .
        ELSE IF (INDEX(wdetail.cover,"พ.ร.บ.") <> 0 OR INDEX(wdetail.cover,"ภาคบังคับ") <> 0) THEN wdetail.cover = "T" .

      /*  IF index(wdetail.garage,"ห้าง") <> 0 THEN  ASSIGN wdetail.garage = "G" .
        ELSE ASSIGN wdetail.garage = " " . */
    END.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_filenew C-Win 
PROCEDURE proc_filenew :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes: A67-0076       
------------------------------------------------------------------------------*/
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "ธนาคารเกียรตินาคินภัทร จำกัด (มหาชน) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "ลำดับที่      "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่รับแจ้ง "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "วันที่รับเงินค่าเบิ้ยประกัน " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "รายชื่อบริษัทประกันภัย " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "เลขที่สัญญาเช่าซื้อ"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "New/Renew          "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "Policy no        " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "เลขที่กรมธรรม์เดิม "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "รหัสสาขา           "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "สาขา KK            "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "สาขา TMSTH         "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "เลขรับเเจ้ง        "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "KK Offer Flag      "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Campaign           "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "Sub Campaign       "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "บุคคล/นิติบุคคล    "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "คำนำหน้าชื่อ       "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "ชื่อผู้เอาประกัน   "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "นามสกุลผู้เอาประกัน"   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "บ้านเลขที่         "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "ตำบล/แขวง          "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "อำเภอ/เขต          "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "จังหวัด            "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "รหัสไปรษณีย์       "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "ประเภทความคุ้มครอง "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "ประเภทการซ่อม      "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "วันเริ่มคุ้มครอง   "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "วันสิ้นสุดคุ้มครอง "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "รหัสรถ             "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "ประเภทประกันภัยรถยนต์ "'"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "ชื่อยี่ห้อรถ     "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "รุ่นรถ           "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "New/Used         "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "เลขทะเบียน       "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "จังหวัดจดทะเบียน "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "เลขตัวถัง        "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "เลขเครื่องยนต์   "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "ปีรถยนต์         "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "ซีซี             "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "แรงม้า           "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "น้ำหนัก/ตัน      "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "ที่นั่ง          "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "ทุนประกันปี 1    "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "เบี้ยสุทธิ       "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "เบี้ยรวมภาษีเเละอากรปี 1" '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "เวลารับเเจ้ง       "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "ชื่อเจ้าหน้าที่ MKT"  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "หมายเหตุ           "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "คำนำหน้าชื่อ 1     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "ผู้ขับขี่ที่ 1     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "วันเกิดผู้ขับขี่ 1 "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "เลขที่ใบขับขี่ 1   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "เพศ 1              "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "อาชีพ 1            "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "ID NO/Passport 1   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "ระดับผู้ขับขี่ 1   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "คำนำหน้าชื่อ 2     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "ผู้ขับขี่ที่ 2     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "วันเกิดผู้ขับขี่ 2 "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' "เลขที่ใบขับขี่ 2   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "เพศ 2              "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "อาชีพ 2            "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "ID NO/Passport 2   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "ระดับผู้ขับขี่ 2   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "คำนำหน้าชื่อ 3     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "ผู้ขับขี่ที่ 3     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "วันเกิดผู้ขับขี่ 3 "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "เลขที่ใบขับขี่ 3   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "เพศ 3              "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "อาชีพ 3            "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "ID NO/Passport 3   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "ระดับผู้ขับขี่ 3   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "คำนำหน้าชื่อ 4     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' "ผู้ขับขี่ที่ 4     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' "วันเกิดผู้ขับขี่ 4 "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' "เลขที่ใบขับขี่ 4   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"' "เพศ 4              "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' "อาชีพ 4            "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' "ID NO/Passport 4   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' "ระดับผู้ขับขี่ 4   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' "คำนำหน้าชื่อ 5     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' "ผู้ขับขี่ที่ 5     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' "วันเกิดผู้ขับขี่ 5 "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' "เลขที่ใบขับขี่ 5   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' "เพศ 5              "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' "อาชีพ 5            "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' "ID NO/Passport 5   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' "ระดับผู้ขับขี่5    "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' "คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)"  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' "ชื่อ (ใบเสร็จ/ใบกำกับภาษี)    "      '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' "นามสกุล (ใบเสร็จ/ใบกำกับภาษี) "      '"' SKIP.          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' "บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)  "  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' "ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)   "  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' "อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)   "  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' "จังหวัด (ใบเสร็จ/ใบกำกับภาษี) "      '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' "รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี)"  '"' SKIP.          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' "ส่วนลดประวัติดี   "   '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K"  '"' "ส่วนลดงาน Fleet   "   '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K"  '"' "เบอร์ติดต่อ       "   '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"' "เลขที่บัตรประชาชน "   '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"' "วันเดือนปีเกิด    "   '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"' "อาชีพ    "            '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"' "สถานภาพ  "            '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"' "เพศ      "            '"' SKIP.  /* A65-0288*/                                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"' "สัญชาติ  "            '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"' "อีเมลล์  "            '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"' "เลขประจำตัวผู้เสียภาษีอากร "  '"' SKIP.  /* A65-0288*/  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"' "คำนำหน้าชื่อ 1    "   '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"' "ชื่อกรรมการ 1     "   '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"' "นามสกุลกรรมการ 1  "   '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"' "เลขที่บัตรประชาชนกรรมการ 1 "  '"' SKIP.  /* A65-0288*/  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"' "คำนำหน้าชื่อ 2    "   '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"' "ชื่อกรรมการ 2     "   '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X114;K" '"' "นามสกุลกรรมการ 2  "   '"' SKIP.                                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X115;K" '"' "เลขที่บัตรประชาชนกรรมการ 2 "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X116;K" '"' "คำนำหน้าชื่อ 3    "           '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X117;K" '"' "ชื่อกรรมการ 3     "           '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X118;K" '"' "นามสกุลกรรมการ 3  "           '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X119;K" '"' "เลขที่บัตรประชาชนกรรมการ 3 "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X120;K" '"' "จัดส่งเอกสารที่สาขา"          '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X121;K" '"' "ชื่อผู้รับเอกสาร"             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X122;K" '"' "ผู้รับผลประโยชน์"             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X123;K" '"' "KK ApplicationNo"             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X124;K" '"' "Remak1          "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X125;K" '"' "Remak2          "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X126;K" '"' "Dealer KK       "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X127;K" '"' "Dealer TMSTH    "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X128;K" '"' "Campaign no TMSTH  "          '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X129;K" '"' "Campaign OV     "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X130;K" '"' "Producer code   "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X131;K" '"' "Agent Code      "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X132;K" '"' "Vat code "                    '"' SKIP.                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X133;K" '"' "ReferenceNo     "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X134;K" '"' "KK Quotation No."             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X135;K" '"' "Rider  No.      "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X136;K" '"' "Release         "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X137;K" '"' "Loan First Date "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X138;K" '"' "Policy Premium  "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X139;K" '"' "Note Un Problem "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X140;K" '"' "Color           "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X141;K" '"' "Inspection      "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X142;K" '"' "Inspection status  "          '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X143;K" '"' "Inspection No   "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X144;K" '"' "Inspection Closed Date"       '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X145;K" '"' "Inspection Detail     "       '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X146;K" '"' "inspection Damage     "       '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X147;K" '"' "inspection Accessory  "       '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X148;K" '"' "วันที่จดทะเบียนครั้งแรก  "    '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X149;K" '"' "Payment option  "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X151;K" '"' "Battery Serial Number"        '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X152;K" '"' "Battery Year    "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X153;K" '"' "Market value price   "        '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X154;K" '"' "Wall Charge Serial Number"    '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X155;K" '"' "Vehicle_Key     "             '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X156;K" '"' "หมายเหตุ "                    '"' SKIP. 
RUN proc_filenew02. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_filenew02 C-Win 
PROCEDURE proc_filenew02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  add by A67-0076     
------------------------------------------------------------------------------*/
FOR EACH wdetail WHERE wdetail.chassis <> "" no-lock.
    
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt   + 1 
        nv_row   =  nv_row   + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' n_record            '"' SKIP. /* ลำดับที่                     */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' wdetail.Notify_dat  '"' SKIP. /* วันที่รับแจ้ง                */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' wdetail.recive_dat  '"' SKIP. /* วันที่รับเงินค่าเบิ้ยประกัน  */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' wdetail.comp_code   '"' SKIP. /* รายชื่อบริษัทประกันภัย       */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' wdetail.cedpol      '"' SKIP. /* เลขที่สัญญาเช่าซื้อ          */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' wdetail.typpol      '"' SKIP. /* New/Renew                    */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' wdetail.n_policy    '"' SKIP. /* เลขที่กรมธรรม์ใหม่           */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' wdetail.prepol      '"' SKIP. /* เลขที่กรมธรรม์เดิม           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' wdetail.cmbr_no     '"' SKIP. /* รหัสสาขา                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.cmbr_code   '"' SKIP. /* สาขา KK                      */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.brtms       '"' SKIP. /* สาขา TMSTH                  */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.notifyno    '"' SKIP. /* เลขรับเเจ้ง                  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail.kkflag      '"' SKIP. /* KK offer */                                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail.campaigno   '"' SKIP. /* Campaign                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail.campaigsub  '"' SKIP. /* Sub Campaign                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' wdetail.typper      '"' SKIP. /* บุคคล/นิติบุคคล              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' wdetail.n_TITLE     '"' SKIP. /* คำนำหน้าชื่อ                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' wdetail.n_name1     '"' SKIP. /* ชื่อผู้เอาประกัน             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' wdetail.n_name2     '"' SKIP. /* นามสกุลผู้เอาประกัน          */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' wdetail.ADD_1       '"' SKIP. /* บ้านเลขที่                   */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' wdetail.ADD_2       '"' SKIP. /* ตำบล/แขวง                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' wdetail.ADD_3       '"' SKIP. /* อำเภอ/เขต                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' wdetail.ADD_4       '"' SKIP. /* จังหวัด                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' wdetail.ADD_5       '"' SKIP. /* รหัสไปรษณีย์                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' wdetail.cover       '"' SKIP. /* ประเภทความคุ้มครอง           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' wdetail.garage      '"' SKIP. /* ประเภทการซ่อม                */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' wdetail.comdat      '"' SKIP. /* วันเริ่มคุ้มครอง             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' wdetail.expdat      '"' SKIP. /* วันสิ้นสุดคุ้มครอง           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' wdetail.subclass    '"' SKIP. /* รหัสรถ                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' wdetail.n_43        '"' SKIP. /* ประเภทประกันภัยรถยนต์        */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' wdetail.brand       '"' SKIP. /* ชื่อยี่ห้อรถ                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' wdetail.model       '"' SKIP. /* รุ่นรถ                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' wdetail.nSTATUS     '"' SKIP. /* New/Used                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' wdetail.licence     '"' SKIP. /* เลขทะเบียน                   */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' wdetail.province    '"' SKIP. /* จังหวัดจดทะเบียน             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' wdetail.chassis     '"' SKIP. /* เลขตัวถัง                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' wdetail.engine      '"' SKIP. /* เลขเครื่องยนต์              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' wdetail.cyear       '"' SKIP. /* ปีรถยนต์                    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' wdetail.power       '"' SKIP. /* ซีซี                        */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' wdetail.hp          '"' SKIP. /* น้ำหนัก/ตัน                 */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' wdetail.weight      '"' SKIP. /* ที่นั่ง              */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' wdetail.seat        '"' SKIP. /* ทุนประกันปี 1               */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' wdetail.ins_amt1    '"' SKIP. /* เบี้ยสุทธิ                  */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' wdetail.netprem     '"' SKIP. /* เบี้ยรวมภาษีเเละอากรปี 1    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' wdetail.prem1       '"' SKIP. /* เวลารับเเจ้ง                */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' wdetail.time_notify '"' SKIP. /* ชื่อเจ้าหน้าที่ MKT         */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' wdetail.NAME_mkt    '"' SKIP. /* หมายเหตุ                    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' wdetail.bennam      '"' SKIP. /* ผู้ขับขี่ที่ 1              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' wdetail.drititle1   '"' SKIP. /* วันเกิดผู้ขับขี่ 1          */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' wdetail.drivno1     '"' SKIP. /* เลขที่ใบขับขี่ 1            */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' wdetail.drivdat1    '"' SKIP. /* ผู้ขับขี่ที่ 2              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' wdetail.drivid1     '"' SKIP. /* วันเกิดผู้ขับขี่ 2          */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' wdetail.drigender1  '"' SKIP. /* เลขที่ใบขับขี่ 2            */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' wdetail.drioccup1   '"' SKIP. /* คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)*/                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' wdetail.driICNo1    '"' SKIP. /** ชื่อ (ใบเสร็จ/ใบกำกับภาษี)      */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' wdetail.drilevel1   '"' SKIP.  /* นามสกุล (ใบเสร็จ/ใบกำกับภาษี)   */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' wdetail.drititle2   '"' SKIP.  /* บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)*/                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' wdetail.drivno2     '"' SKIP.  /* ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี) */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' wdetail.drivdat2    '"' SKIP.  /* อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี) */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' wdetail.drivid2     '"' SKIP. /* จังหวัด (ใบเสร็จ/ใบกำกับภาษี)   */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' wdetail.drigender2  '"' SKIP. /* รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี) */                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' wdetail.drioccup2   '"' SKIP. /* ส่วนลดประวัติดี             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' wdetail.driICNo2    '"' SKIP. /* ส่วนลดงาน Fleet             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' wdetail.drilevel2   '"' SKIP. /* เบอร์ติดต่อ                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' wdetail.drilic3     '"' SKIP. /* เลขที่บัตรประชาชน           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' wdetail.drititle3   '"' SKIP. /* วันเดือนปีเกิด              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' wdetail.driname3    '"' SKIP. /* อาชีพ                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' wdetail.drivno3     '"' SKIP. /* สถานภาพ                     */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' wdetail.drigender3  '"' SKIP. /* เพศ */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' wdetail.drioccup3   '"' SKIP. /* สัญชาติ */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' wdetail.driICNo3    '"' SKIP. /* อีเมล์  */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' wdetail.drilevel3   '"' SKIP. /* เลขประจำตัวผู้เสียภาษีอากร  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' wdetail.drilic4     '"' SKIP. /* คำนำหน้าชื่อ 1              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' wdetail.drititle4   '"' SKIP. /* ชื่อกรรมการ 1               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' wdetail.driname4    '"' SKIP. /* นามสกุลกรรมการ 1            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' wdetail.drivno4     '"' SKIP. /* เลขที่บัตรประชาชนกรรมการ 1  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"' wdetail.drigender4  '"' SKIP. /* คำนำหน้าชื่อ 2              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' wdetail.drioccup4   '"' SKIP. /* ชื่อกรรมการ 2               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' wdetail.driICNo4    '"' SKIP. /* นามสกุลกรรมการ 2            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' wdetail.drilevel4   '"' SKIP. /* เลขที่บัตรประชาชนกรรมการ 2  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' wdetail.drilic5     '"' SKIP. /* คำนำหน้าชื่อ 3              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' wdetail.drititle5   '"' SKIP. /* ชื่อกรรมการ 3               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' wdetail.driname5    '"' SKIP. /* นามสกุลกรรมการ 3            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' wdetail.drivno5     '"' SKIP. /* เลขที่บัตรประชาชนกรรมการ 3  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' wdetail.drigender5  '"' SKIP. /* จัดส่งเอกสารที่สาขา         */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' wdetail.drioccup5   '"' SKIP. /* ชื่อผู้รับเอกสาร            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' wdetail.driICNo5    '"' SKIP. /* ผู้รับผลประโยชน์            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' wdetail.drilevel5   '"' SKIP. /* KK ApplicationNo            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' wdetail.reci_title  '"' SKIP. /* Remak1                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' wdetail.reci_name1  '"' SKIP. /* Remak2                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' wdetail.reci_name2  '"' SKIP. /* Dealer                      */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' wdetail.reci_1      '"' SKIP. /* Dealer TMSTH            */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' wdetail.reci_2      '"' SKIP. /* Campaignno TMSTH            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' wdetail.reci_3      '"' SKIP. /* Campaign OV                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' wdetail.reci_4      '"' SKIP. /* Producer code      */                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' wdetail.reci_5      '"' SKIP. /* Agent code        */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' wdetail.ncb         '"' SKIP. /*vat code  */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K"  '"' wdetail.fleet       '"' SKIP. /*ReferenceNo  */                                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K"  '"' wdetail.phone       '"' SKIP. /* KK Quotation No.*/                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"' wdetail.icno        '"' SKIP. /* Rider  No.  */                                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"' wdetail.bdate       '"' SKIP. /* Release                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"' wdetail.occup       '"' SKIP. /* Loan First Date             */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"' wdetail.cstatus     '"' SKIP. /**A65-0288*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"' wdetail.gender      '"' SKIP.  /*A65-0288*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"' wdetail.nation      '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"' wdetail.email       '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"' wdetail.tax         '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"' wdetail.tname1      '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"' wdetail.cname1      '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"' wdetail.lname1      '"' SKIP.  //*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"' wdetail.icno1       '"' SKIP.   /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"' wdetail.tname2      '"' SKIP.   /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"' wdetail.cname2      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X114;K" '"' wdetail.lname2      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X115;K" '"' wdetail.icno2       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X116;K" '"' wdetail.tname3      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X117;K" '"' wdetail.cname3      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X118;K" '"' wdetail.lname3      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X119;K" '"' wdetail.icno3       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X120;K" '"' wdetail.nsend       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X121;K" '"' wdetail.sendname    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X122;K" '"' wdetail.bennefit    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X123;K" '"' wdetail.KKapp       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X124;K" '"' wdetail.remak1      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X125;K" '"' wdetail.remak2      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X126;K" '"' wdetail.dealercd    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X127;K" '"' wdetail.dealtms     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X128;K" '"' wdetail.packcod     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X129;K" '"' wdetail.campOV      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X130;K" '"' wdetail.producer    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X131;K" '"' wdetail.Agent       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X132;K" '"' wdetail.vatcode     '"' SKIP .
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X133;K" '"' wdetail.RefNo       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X134;K" '"' wdetail.KKQuo       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X135;K" '"' wdetail.RiderNo     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X136;K" '"' wdetail.releas      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X137;K" '"' wdetail.loandat     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X138;K" '"' wdetail.PolPrem     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X139;K" '"' wdetail.probleam    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X140;K" '"' wdetail.colors      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X141;K" '"' wdetail.Inspection  '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X142;K" '"' wdetail.Insp_status '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X143;K" '"' wdetail.Insp_No     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X144;K" '"' wdetail.Insp_Closed '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X145;K" '"' wdetail.Insp_Detail '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X146;K" '"' wdetail.insp_Damage '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X147;K" '"' wdetail.insp_Accessory '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X148;K" '"' wdetail.dateregis   '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X149;K" '"' wdetail.pay_option  '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X151;K" '"' wdetail.battno      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X152;K" '"' wdetail.battyr      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X153;K" '"' wdetail.maksi       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X154;K" '"' wdetail.chargno     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X155;K" '"' wdetail.veh_key     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X156;K" '"' wdetail.remark      '"' SKIP.   
END.                                                  
nv_row  =  nv_row  + 1.                                                              
PUT STREAM ns2 "E".                                                                  
OUTPUT STREAM ns2 CLOSE.                                                             
/* ...end A67-0076 ...*/                                                                                    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 C-Win 
PROCEDURE proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nvw_fptr  AS RECID.
DEF Var nv_fptr   As RECID   Initial    0.
DEF Var nv_bptr   As RECID   Initial    0.

DEF VAR nv_txt8   AS CHAR FORMAT "x(750)".
DEF VAR nv_f8     AS CHAR FORMAT "x(750)".

DO:
 ASSIGN  nv_txt8 = ""       nv_camp = ""  
         nv_f8   = ""
         nv_fptr = 0
         nv_bptr = 0
         nv_fptr = sicuw.uwm100.fptr02
         nv_bptr = sicuw.uwm100.bptr02.
         IF nv_fptr <> 0 Or nv_fptr <> ? THEN DO:   
             DO WHILE nv_fptr  <>  0 :
               
                FIND sicuw.uwd102  WHERE RECID(uwd102) = nv_fptr NO-LOCK NO-ERROR .
                IF AVAIL sicuw.uwd102 THEN DO:
                    nv_f8 = trim(SUBSTRING(uwd102.ltext,1,LENGTH(uwd102.ltext))). 
                    nv_fptr  =  uwd102.fptr.
                    IF nv_f8 = ? THEN nv_f8 = "" .
                END.
                ELSE DO: 
                    nv_fptr  = 0.
                END.
                nv_txt8 =  nv_txt8 + nv_f8.
                IF nv_fptr = 0 THEN LEAVE.
             END.
         END.
     RELEASE sicuw.uwd102.
     IF INDEX(nv_txt8,"Campaign") <> 0 THEN nv_camp = SUBSTR(nv_txt8,R-INDEX(nv_txt8,"Campaign")) .
     IF nv_camp <> "" THEN wdetail.remark = wdetail.remark + " " + nv_camp .
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
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "บริษัทเงินทุน ธนาคารเกียรตินาคิน จำกัด (มหาชน) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "ลำดับที่ "                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่รับแจ้ง "                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "วันที่รับเงินค่าเบิ้ยประกัน"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "รายชื่อบริษัทประกันภัย "             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "เลขที่สัญญาเช่าซื้อ "                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "เลขที่กรมธรรม์ใหม่"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "เลขที่กรมธรรม์เดิม "                 '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "รหัสสาขา "                           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "สาขา KK "                            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "เลขรับเเจ้ง "                        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Campaign "                           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Sub Campaign "                       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "บุคคล/นิติบุคคล "                    '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "คำนำหน้าชื่อ "                       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "ชื่อผู้เอาประกัน "                   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "นามสกุลผู้เอาประกัน "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "บ้านเลขที่"                          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "ตำบล/แขวง "                          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "อำเภอ/เขต "                          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "จังหวัด "                            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "รหัสไปรษณีย์ "                       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "ประเภทความคุ้มครอง "                 '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "ประเภทการซ่อม "                      '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "วันเริ่มคุ้มครอง "                   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "วันสิ้นสุดคุ้มครอง "                 '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "รหัสรถ "                             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "ประเภทประกันภัยรถยนต์ "              '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "ชื่อยี่ห้อรถ "                       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "รุ่นรถ "                             '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "New/Used "                           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "เลขทะเบียน "                         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "เลขตัวถัง "                          '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "เลขเครื่องยนต์ "                     '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "ปีรถยนต์ "                           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "ซีซี "                               '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "น้ำหนัก/ตัน "                        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "ทุนประกันปี 1 "                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "เบี้ยรวมภาษีเเละอากรปี 1 "           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "ทุนประกันปี 2 "                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "เบี้ยรวมภาษีเเละอากรปี 2 "           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "ทุนสูญหาย/ไฟไหม้"                   '"' SKIP.  /*a61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "เวลารับเเจ้ง "                       '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "ชื่อเจ้าหน้าที่ MKT "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "หมายเหตุ "                           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "ผู้ขับขี่ที่ 1 เเละวันเกิด "         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "ผู้ขับขี่ที่ 2 เเละวันเกิด "         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี) " '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "ชื่อ (ใบเสร็จ/ใบกำกับภาษี) "         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "นามสกุล (ใบเสร็จ/ใบกำกับภาษี) "      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี) "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี) "    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี) "    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "จังหวัด (ใบเสร็จ/ใบกำกับภาษี) "      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี) " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "ส่วนลดประวัติดี "                    '"' SKIP.  /*A55-0029*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "ส่วนลดงาน Fleet "                    '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  "เบอร์ติดต่อ      "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  "เลขที่บัตรประชาชน"                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  "วันเดือนปีเกิด   "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  "อาชีพ            "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  "สถานภาพ          "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  "เลขประจำตัวผู้เสียภาษีอากร "        '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  "คำนำหน้าชื่อ 1   "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  "ชื่อกรรมการ 1    "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  "นามสกุลกรรมการ 1 "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  "เลขที่บัตรประชาชนกรรมการ 1 "        '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  "คำนำหน้าชื่อ 2   "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  "ชื่อกรรมการ 2    "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  "นามสกุลกรรมการ 2 "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  "เลขที่บัตรประชาชนกรรมการ 2 "        '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  "คำนำหน้าชื่อ 3   "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  "ชื่อกรรมการ 3    "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  "นามสกุลกรรมการ 3 "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  "เลขที่บัตรประชาชนกรรมการ 3 "        '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  "จัดส่งเอกสารที่สาขา  "              '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  "ชื่อผู้รับเอกสาร "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  "ผู้รับผลประโยชน์ "                  '"' SKIP.  /*A61-0335*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  "KK Applicationno."                                '"' SKIP.  /*A61-0335*/

FOR EACH wdetail WHERE wdetail.chassis <> "" no-lock.
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record               '"' SKIP. /*ลำดับที่ */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.Notify_dat     '"' SKIP. /*วันที่รับแจ้ง */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.recive_dat     '"' SKIP. /*วันที่รับเงินค่าเบิ้ยประกัน*/      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.comp_code      '"' SKIP. /*รายชื่อบริษัทประกันภัย */          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.cedpol         '"' SKIP. /*เลขที่สัญญาเช่าซื้อ */             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.n_policy       '"' SKIP. /*เลขที่กรมธรรม์ใหม่*/               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.prepol         '"' SKIP. /*เลขที่กรมธรรม์เดิม */                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.cmbr_no        '"' SKIP. /*รหัสสาขา */                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.cmbr_code      '"' SKIP. /*สาขา KK */                                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.notifyno       '"' SKIP. /*เลขรับเเจ้ง */                             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.campaigno      '"' SKIP. /*Campaign */                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.campaigsub     '"' SKIP. /*Sub Campaign */                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.typper         '"' SKIP. /*บุคคล/นิติบุคคล */                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.n_TITLE        '"' SKIP. /*คำนำหน้าชื่อ */                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.n_name1        '"' SKIP. /*ชื่อผู้เอาประกัน */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.n_name2        '"' SKIP. /*นามสกุลผู้เอาประกัน */                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.ADD_1          '"' SKIP. /*บ้านเลขที่*/                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.ADD_2          '"' SKIP. /*ตำบล/แขวง */                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.ADD_3          '"' SKIP. /*อำเภอ/เขต */                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.ADD_4          '"' SKIP. /*จังหวัด */                                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.ADD_5          '"' SKIP. /*รหัสไปรษณีย์ */                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.cover          '"' SKIP. /*ประเภทความคุ้มครอง */                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.garage         '"' SKIP. /*ประเภทการซ่อม */                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.comdat         '"' SKIP. /*วันเริ่มคุ้มครอง */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.expdat         '"' SKIP. /*วันสิ้นสุดคุ้มครอง */                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.subclass       '"' SKIP. /*รหัสรถ */                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail.n_43           '"' SKIP. /*ประเภทประกันภัยรถยนต์ */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.brand          '"' SKIP. /*ชื่อยี่ห้อรถ */                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail.model          '"' SKIP. /*รุ่นรถ */                             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.nSTATUS        '"' SKIP. /*New/Used */                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.licence        '"' SKIP. /*เลขทะเบียน */                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail.chassis        '"' SKIP. /*เลขตัวถัง */                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail.engine         '"' SKIP. /*เลขเครื่องยนต์ */                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail.cyear          '"' SKIP. /*ปีรถยนต์ */                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.power          '"' SKIP. /*ซีซี */                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.weight         '"' SKIP. /*น้ำหนัก/ตัน */                             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.ins_amt1       '"' SKIP. /*ทุนประกันปี 1 */                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.prem1          '"' SKIP. /*เบี้ยรวมภาษีเเละอากรปี 1 */                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail.ins_amt2       '"' SKIP. /*ทุนประกันปี 2 */                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  wdetail.prem2          '"' SKIP. /*เบี้ยรวมภาษีเเละอากรปี 2 */           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  wdetail.fi             '"' SKIP. /*ทุนไฟไหม้ */              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail.time_notify    '"' SKIP.  /*เวลารับเเจ้ง */                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail.NAME_mkt       '"' SKIP.  /*ชื่อเจ้าหน้าที่ MKT */               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail.bennam         '"' SKIP.  /*หมายเหตุ */             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail.drivno1        '"' SKIP.                              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  wdetail.drivno2        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'  wdetail.reci_title     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"'  wdetail.reci_name1     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  wdetail.reci_name2     '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"'  wdetail.reci_1         '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"'  wdetail.reci_2         '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"'  wdetail.reci_3         '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"'  wdetail.reci_4         '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"'  wdetail.reci_5         '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  wdetail.ncb            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  wdetail.fleet           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  wdetail.phone           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  wdetail.icno            '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  wdetail.bdate           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  wdetail.occup           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  wdetail.cstatus         '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  wdetail.tax             '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  wdetail.tname1          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  wdetail.cname1          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  wdetail.lname1          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  wdetail.icno1           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  wdetail.tname2          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  wdetail.cname2          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  wdetail.lname2          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  wdetail.icno2           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  wdetail.tname3          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  wdetail.cname3          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  wdetail.lname3          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  wdetail.icno3           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  wdetail.nsend           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  wdetail.sendname        '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  wdetail.bennefit        '"' SKIP.  /*A61-0335*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  wdetail.KKapp           '"' SKIP.  /*A61-0335*/

END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createfileKK C-Win 
PROCEDURE pro_createfileKK :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_outfile2,length(fi_outfile2) - 3,4) <>  ".slk"  THEN 
    fi_outfile2  =  Trim(fi_outfile2) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile2).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "บริษัทเงินทุน ธนาคารเกียรตินาคิน จำกัด (มหาชน) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "ลำดับที่       "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "บริษัทประกัน   "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "เลขที่กรมธรรม์ "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "รหัสสาขา       "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "สาขา KK        "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "เลขที่สัญญา    "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "คำนำหน้าชื่อ   "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "ชื่อผู้เอาประกัน"           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "นามสกุลผู้เอาประกัน"        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "เลขที่รับแจ้ง  "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "วันที่ออกเลขที่รับแจ้ง"     '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "เลขทะเบียน     "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "ยี่ห้อรถ       "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "เลขตัวรถ       "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "เจ้าหน้าที่ MKT"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "เจ้าหน้าที่ที่ขอ"           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "ประเภทความคุ้มครอง "        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "ประเภทการซ่อม  "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "ทุนประกัน      "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "เบี้ยรวมภาษีและอากร"        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "วันเริ่มต้น พรบ"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "วันสิ้นสุด พรบ "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "ชื่อผู้รับ "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "บ้านเลขที่ "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "หมู่       "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "หมู่บ้าน   "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "อาคาร      "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "ซอย        "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "ถนน        "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "ตำบล/แขวง  "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "อำเภอ/เขต  "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "จังหวัด    "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "รหัสไปรษณีย์  "             '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "หมายเหตุ   "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "เบอร์ติดต่อ"                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "จัดส่งเอกสารที่สาขา"        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "ชื่อผู้รับเอกสาร   "        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "KK ApplicationNo.  "        '"' SKIP. 

FOR EACH wdetail WHERE wdetail.chassis <> "" no-lock.
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.


    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.comp_code   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.n_policy    '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.cmbr_no     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.cmbr_code   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.cedpol      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.n_TITLE     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.n_name1     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.n_name2     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.notifyno    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.Notify_dat  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.licence     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.brand       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.chassis     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.NAME_mkt    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  ""                  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.cover       '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.garage      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.ins_amt2    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.prem2       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.comdat      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.expdat      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.sendname    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  " "                 '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  " "                 '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  " "                 '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.phone       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.nsend       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.sendname    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.KKapp       '"' SKIP.         
    
END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_matchfile_prem C-Win 
PROCEDURE pro_matchfile_prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  n_poltyp AS CHAR . 
DEF VAR  n_status AS CHAR.
FOR EACH wdetail .
    n_poltyp = "" .
    n_status = "no" .
    IF rs_type = 1 THEN n_poltyp = "V70".
    ELSE DO:
        IF trim(wdetail.cover) = "T" THEN n_poltyp = "V72".
        ELSE n_poltyp = "V70" .
    END.
    IF trim(wdetail.kkapp) <> "" THEN DO:
        
        FIND LAST brstat.tlt USE-INDEX tlt06 WHERE 
            brstat.tlt.cha_no   = trim(wdetail.chassis)  AND   /*Modify by      : Kridtiya i. A66-0140 chang index tlt05 to tlt06    */
            brstat.tlt.expotim  = trim(wdetail.kkapp) AND         
            brstat.tlt.genusr   =  "kk"                NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
            
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002      WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.kkapp)  AND 
                sicuw.uwm100.comdat <> ?                   AND
                sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  
            IF AVAIL sicuw.uwm100 THEN DO: 
                
                IF index(brstat.tlt.releas,"YES") <> 0 THEN ASSIGN brstat.tlt.releas  = brstat.tlt.releas .
                ELSE IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas  = "YES".
                ELSE ASSIGN brstat.tlt.releas  = "YES/CA".
                ASSIGN brstat.tlt.policy       = sicuw.uwm100.policy 
                    wdetail.n_policy = sicuw.uwm100.policy
                    wdetail.brtms    = sicuw.uwm100.branch 
                    wdetail.vatcode  = sicuw.uwm100.bs_cd  
                    wdetail.remark   = tlt.releas
                    n_status = "yes"   .
                IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
                ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                RUN proc_uwd102. 
            END.
            ELSE ASSIGN wdetail.n_policy = " "
                wdetail.remark   = "ไม่มีข้อมูลในถังพัก".
            /*Modify by      : Kridtiya i. A66-0140 chang index tlt05 to tlt06    */
            IF wdetail.n_policy = "" THEN DO:
                FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                    sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                    sicuw.uwm100.comdat <> ?                   AND
                    sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
                    sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR. 
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF index(brstat.tlt.releas,"YES") <> 0 THEN ASSIGN brstat.tlt.releas  = brstat.tlt.releas .
                    ELSE IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas  = "YES".
                    ELSE ASSIGN brstat.tlt.releas  = "YES/CA".
                    ASSIGN  brstat.tlt.policy       = sicuw.uwm100.policy  
                        wdetail.n_policy = sicuw.uwm100.policy 
                        wdetail.brtms    = sicuw.uwm100.branch 
                        wdetail.vatcode  = sicuw.uwm100.bs_cd  
                        wdetail.remark   = brstat.tlt.releas
                        n_status = "yes"  .
                    IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
                    ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                    RUN proc_uwd102. 
                END.
                ELSE ASSIGN wdetail.n_policy = " "
                    wdetail.remark   = wdetail.remark + "/ไม่พบกรมธรรม์ ".
            END.   /*wdetail.n_policy = ""*/
        END.  /* brstat.tlt */
    END.   /*trim(wdetail.kkapp) <> ""*/
    /*Modify by      : Kridtiya i. A66-0140 chang index tlt05 to tlt06    */
    IF n_status = "no"  THEN DO:
     
        IF trim(wdetail.cedpol) <> "" THEN DO:
        FIND LAST brstat.tlt  WHERE       
            brstat.tlt.nor_noti_tlt   =  trim(wdetail.cedpol) AND   /* A64-0135*/ 
            brstat.tlt.genusr         =  "kk"             NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
            
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND
                sicuw.uwm100.comdat <> ?                   AND
                sicuw.uwm100.comdat = date(wdetail.comdat) AND
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR. 
            IF AVAIL sicuw.uwm100 THEN DO:
                
                IF index(brstat.tlt.releas,"YES") <> 0 THEN ASSIGN brstat.tlt.releas  = brstat.tlt.releas .
                ELSE IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas  = "YES".
                ELSE ASSIGN brstat.tlt.releas  = "YES/CA".
                ASSIGN  brstat.tlt.policy = sicuw.uwm100.policy 
                    wdetail.n_policy  = sicuw.uwm100.policy 
                    wdetail.brtms     = sicuw.uwm100.branch 
                    wdetail.vatcode   = sicuw.uwm100.bs_cd  
                    wdetail.remark    = brstat.tlt.releas.
                IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
                ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                RUN proc_uwd102. /* A65-0288 */
            END.
            ELSE ASSIGN wdetail.n_policy = " "
                wdetail.remark   = "ไม่มีข้อมูลในถังพัก".
        END.
       
        IF wdetail.n_policy = ""  THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND 
                sicuw.uwm100.comdat <> ?                   AND
                sicuw.uwm100.comdat = date(wdetail.comdat) AND
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                    ASSIGN  wdetail.n_policy = sicuw.uwm100.policy 
                        wdetail.brtms    = sicuw.uwm100.branch 
                        wdetail.vatcode  = sicuw.uwm100.bs_cd  
                        wdetail.remark   = "ไม่พบข้อมูลในถังพัก" .
                    IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
                    ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                         RUN proc_uwd102. /* A65-0288 */
                END.
            END.
            ELSE ASSIGN wdetail.n_policy = " "
                wdetail.remark   = wdetail.remark + "/ไม่พบกรมธรรม์ ".
        END.
    END.
    END.  /*Modify by      : Kridtiya i. A66-0140 chang index tlt05 to tlt06    */
END.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_matchfile_prem-01 C-Win 
PROCEDURE Pro_matchfile_prem-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by Kridtiya i. A55-0055
FOR EACH wdetail .
    FIND LAST brstat.tlt  WHERE       
        brstat.tlt.comp_noti_tlt   =  wdetail.notifyno AND 
        tlt.genusr                 =  "kk"             NO-ERROR NO-WAIT.
    IF AVAIL brstat.tlt THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
            sicuw.uwm100.cedpol = trim(wdetail.cedpol) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.poltyp = "V70"  THEN  
                ASSIGN  
                wdetail.n_policy = sicuw.uwm100.policy
                tlt.releas =  "yes". 
        END.
        ELSE 
            ASSIGN tlt.releas =  "No".
                wdetail.n_policy = "".

        /*IF INDEX(tlt.releas,"yes") = 0 THEN DO: 
            IF tlt.releas = "" THEN
                ASSIGN tlt.releas =  "yes".
            ELSE DO:  
                IF INDEX(tlt.releas,"cancel") = 0 THEN 
                    ASSIGN tlt.releas = "yes".
                ELSE ASSIGN tlt.releas = "cancel/yes".
            END.
        END.*/
    END.
END.      /* wdetail*/
end...comment by Kridtiya i. A55-0055*/
/*
DEF VAR  n_poltyp AS CHAR .  /* A64-0135 */
/*Add by Kridtiya i. A55-0055*/
FOR EACH wdetail .
    /* A64-0135 */
    n_poltyp = "" .
    IF rs_type = 1 THEN n_poltyp = "V70".
    ELSE DO:
        IF trim(wdetail.cover) = "T" THEN n_poltyp = "V72".
        ELSE n_poltyp = "V70" .
    END.
    /* end A64-0135 */
    FIND LAST brstat.tlt  WHERE       
        /*brstat.tlt.comp_noti_tlt   =  wdetail.notifyno AND */ /* A64-0135*/
        brstat.tlt.expotim  =  trim(wdetail.kkapp) AND         /* A64-0135 */
        brstat.tlt.genusr   =  "kk"             NO-ERROR NO-WAIT.
    IF AVAIL brstat.tlt THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002      WHERE  
            sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND 
            sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
            /*sicuw.uwm100.poltyp = "V70"              */       /*A64-0135*/
            sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
        IF AVAIL sicuw.uwm100 THEN DO: 
            IF index(tlt.releas,"YES") <> 0 THEN ASSIGN tlt.releas  = tlt.releas .
            ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas  = "YES".
            ELSE ASSIGN tlt.releas  = "YES/CA".
            ASSIGN tlt.policy       = sicuw.uwm100.policy /*A64-0135*/
                   wdetail.n_policy = sicuw.uwm100.policy
                   wdetail.brtms    = sicuw.uwm100.branch /*A64-0135*/
                   wdetail.vatcode  = sicuw.uwm100.bs_cd  /*A64-0135*/
                   wdetail.remark   = tlt.releas .
            IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
            ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
        END.
        ELSE DO:
            /* create by A61-0335*/
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
                /*sicuw.uwm100.poltyp = "V70"              */       /*A64-0135*/
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
            IF AVAIL sicuw.uwm100 THEN DO:
               IF index(tlt.releas,"YES") <> 0 THEN ASSIGN tlt.releas  = tlt.releas .
               ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas  = "YES".
               ELSE ASSIGN tlt.releas  = "YES/CA".
               ASSIGN  tlt.policy       = sicuw.uwm100.policy /*A64-0135*/
                       wdetail.n_policy = sicuw.uwm100.policy 
                       wdetail.brtms    = sicuw.uwm100.branch /*A64-0135*/
                       wdetail.vatcode  = sicuw.uwm100.bs_cd  /*A64-0135*/
                       wdetail.remark   = tlt.releas.

            IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
            ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
               
            END.
            /*end A61-0335*/
            ELSE ASSIGN wdetail.n_policy = " "
                        wdetail.remark   = "ไม่พบกรมธรรม์ ".
        END.
    END.
    /* add by : A64-0135 */
    ELSE DO:
        FIND LAST brstat.tlt  WHERE       
            brstat.tlt.nor_noti_tlt   =  trim(wdetail.cedpol) AND   /* A64-0135*/ 
            brstat.tlt.genusr         =  "kk"             NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
             FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                    sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND
                    sicuw.uwm100.comdat = date(wdetail.comdat) AND
                    sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR. 
                IF AVAIL sicuw.uwm100 THEN DO:
                   IF index(brstat.tlt.releas,"YES") <> 0 THEN ASSIGN brstat.tlt.releas  = brstat.tlt.releas .
                   ELSE IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas  = "YES".
                   ELSE ASSIGN brstat.tlt.releas  = "YES/CA".
                   ASSIGN  brstat.tlt.policy = sicuw.uwm100.policy 
                           wdetail.n_policy  = sicuw.uwm100.policy 
                           wdetail.brtms     = sicuw.uwm100.branch 
                           wdetail.vatcode   = sicuw.uwm100.bs_cd  
                           wdetail.remark    = brstat.tlt.releas.
                   IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
                   ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                END.
                ELSE ASSIGN wdetail.n_policy = " "
                            wdetail.remark   = "ไม่พบกรมธรรม์ ".
        END.
        ELSE DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                      sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                      sicuw.uwm100.comdat = date(wdetail.comdat) AND
                      sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                        ASSIGN  wdetail.n_policy = sicuw.uwm100.policy 
                                wdetail.brtms    = sicuw.uwm100.branch 
                                wdetail.vatcode  = sicuw.uwm100.bs_cd  
                                wdetail.remark   = "ไม่พบข้อมูลในถังพัก" .
                        IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
                        ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                    END.
                END.
                ELSE ASSIGN wdetail.n_policy = ""  
                            wdetail.remark = "ไม่พบกรมธรรม์/ ไม่พบข้อมูลในถังพัก" .
        END.
    END.
    /* end: A64-0135 */
END. */ /* wdetail*/
/*Add by Kridtiya i. A55-0055*/
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_matchfile_prem_bk C-Win 
PROCEDURE pro_matchfile_prem_bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  n_poltyp AS CHAR .  /* A64-0135 */
/*Add by Kridtiya i. A55-0055*/
FOR EACH wdetail .
    /* A64-0135 */
    n_poltyp = "" .
    IF rs_type = 1 THEN n_poltyp = "V70".
    ELSE DO:
        IF trim(wdetail.cover) = "T" THEN n_poltyp = "V72".
        ELSE n_poltyp = "V70" .
    END.
    /* end A64-0135 */
    IF trim(wdetail.kkapp) <> "" THEN DO:
        FIND LAST brstat.tlt  WHERE       
            brstat.tlt.expotim  =  trim(wdetail.kkapp) AND         
            brstat.tlt.genusr   =  "kk"             NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002      WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                sicuw.uwm100.comdat <> ?                   AND
                sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
            IF AVAIL sicuw.uwm100 THEN DO: 
                IF index(tlt.releas,"YES") <> 0 THEN ASSIGN tlt.releas  = tlt.releas .
                ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas  = "YES".
                ELSE ASSIGN tlt.releas  = "YES/CA".
                ASSIGN tlt.policy       = sicuw.uwm100.policy /*A64-0135*/
                       wdetail.n_policy = sicuw.uwm100.policy
                       wdetail.brtms    = sicuw.uwm100.branch /*A64-0135*/
                       wdetail.vatcode  = sicuw.uwm100.bs_cd  /*A64-0135*/
                       wdetail.remark   = tlt.releas .
                IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
                ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                RUN proc_uwd102. /* A65-0288 */
            END.
            ELSE ASSIGN wdetail.n_policy = " "
                        wdetail.remark   = "ไม่มีข้อมูลในถังพัก".
        END.
        IF wdetail.n_policy = "" THEN DO:
            /* create by A61-0335*/
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                sicuw.uwm100.comdat <> ?                   AND
                sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR. 
            IF AVAIL sicuw.uwm100 THEN DO:
               IF index(tlt.releas,"YES") <> 0 THEN ASSIGN tlt.releas  = tlt.releas .
               ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas  = "YES".
               ELSE ASSIGN tlt.releas  = "YES/CA".
               ASSIGN  tlt.policy       = sicuw.uwm100.policy /*A64-0135*/
                       wdetail.n_policy = sicuw.uwm100.policy 
                       wdetail.brtms    = sicuw.uwm100.branch /*A64-0135*/
                       wdetail.vatcode  = sicuw.uwm100.bs_cd  /*A64-0135*/
                       wdetail.remark   = tlt.releas.

               IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
               ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
               RUN proc_uwd102. /* A65-0288 */
               
            END.
            /*end A61-0335*/
            ELSE ASSIGN wdetail.n_policy = " "
                        wdetail.remark   = wdetail.remark + "/ไม่พบกรมธรรม์ ".
        END.
    END.
    /* add by : A64-0135 */
    ELSE IF trim(wdetail.cedpol) <> "" THEN DO:
        FIND LAST brstat.tlt  WHERE       
            brstat.tlt.nor_noti_tlt   =  trim(wdetail.cedpol) AND   /* A64-0135*/ 
            brstat.tlt.genusr         =  "kk"             NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
             FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                    sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND
                    sicuw.uwm100.comdat <> ?                   AND
                    sicuw.uwm100.comdat = date(wdetail.comdat) AND
                    sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR. 
                IF AVAIL sicuw.uwm100 THEN DO:
                   IF index(brstat.tlt.releas,"YES") <> 0 THEN ASSIGN brstat.tlt.releas  = brstat.tlt.releas .
                   ELSE IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas  = "YES".
                   ELSE ASSIGN brstat.tlt.releas  = "YES/CA".
                   ASSIGN  brstat.tlt.policy = sicuw.uwm100.policy 
                           wdetail.n_policy  = sicuw.uwm100.policy 
                           wdetail.brtms     = sicuw.uwm100.branch 
                           wdetail.vatcode   = sicuw.uwm100.bs_cd  
                           wdetail.remark    = brstat.tlt.releas.
                   IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
                   ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                   RUN proc_uwd102. /* A65-0288 */

                END.
                ELSE ASSIGN wdetail.n_policy = " "
                            wdetail.remark   = "ไม่มีข้อมูลในถังพัก".
        END.
        IF wdetail.n_policy = ""  THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                      sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND 
                      sicuw.uwm100.comdat <> ?                   AND
                      sicuw.uwm100.comdat = date(wdetail.comdat) AND
                      sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                        ASSIGN  wdetail.n_policy = sicuw.uwm100.policy 
                                wdetail.brtms    = sicuw.uwm100.branch 
                                wdetail.vatcode  = sicuw.uwm100.bs_cd  
                                wdetail.remark   = "ไม่พบข้อมูลในถังพัก" .
                        IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/เบี้ยตรง".
                        ELSE wdetail.remark = wdetail.remark + "/เบี้ยไม่ตรง " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                        RUN proc_uwd102. /* A65-0288 */
                    END.
                END.
                ELSE ASSIGN wdetail.n_policy = " "
                            wdetail.remark   = wdetail.remark + "/ไม่พบกรมธรรม์ ".
        END.
    END.
    /* end: A64-0135 */
END.  /* wdetail*/
/*Add by Kridtiya i. A55-0055*/
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

