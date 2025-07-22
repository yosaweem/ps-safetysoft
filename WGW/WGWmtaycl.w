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
/*Program ID   : wgwmtscb3.w                                                */
/*Program name : Match File Load and Update Data TLT                        */
/*create by    : Ranu i. A61-0573  date. 10/02/2019
                โปรแกรม match file สำหรับโหลดเข้า GW และ Match Policy no on TLT */
/*              Match file Load , match policy no                            */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */

/*Modify by        : Kridtiya i. A63-0472 แก้ไข การค้นหาเลขที่สัญญา ด้วย custcode*/
/*Modify by : Ranu I. A65-0115 เพิ่มช่อง Dealer code ในไฟล์โหลด และแก้ไขฟอร์แมตไฟล์ policy ส่งห้องผลิต */
/*Modify by : Kridtiya i. A66-0140 เปลี่ยน index tlt05 >>> index tlt06*/
/*Modify by : Kridtiya i. A66-0160 Date. 15/08/2023 match color */
/*Modify by : Kridtiya i. A66-0197 Date. 08/09/2023 ค้นหาข้อมูลกรมธรรม์ ล่าสุด เพื่อแสดงค่าข้อมูล*/
/*Modify by : Ranu I. A67-0040 Date. 15/02/2024 เพิ่มการพารามิเตอร์ producer code สำหรับดึงข้อมูลกรมธรรม์ส่งกลับ AY */
/*Modify by : Ranu I. A67-0162 แก้ไขไฟล์ Load เพิ่มข้อมูลรถไฟฟ้า   */
/*---------------------------------------------------------------------------*/
DEF VAR gv_id  AS CHAR FORMAT "X(12)" NO-UNDO.      
DEF VAR n_user  AS CHAR FORMAT "X(12)" NO-UNDO.
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO. 
DEF  stream ns1.
DEFINE VAR  nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR  nv_reccnt      AS  INT  INIT  0.
DEFINE VAR  nv_completecnt AS   INT   INIT  0.
DEFINE VAR  nv_enttim      AS  CHAR          INIT  "".
DEFINE VAR  nv_export      as  date  init  ""  format "99/99/9999".
DEF stream  ns2.
DEFINE VAR nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
{wgw/wgwmtaycl.i}
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED TEMP-TABLE wload NO-UNDO
    FIELD poltyp         AS CHAR FORMAT "x(5)" INIT ""                      /* ประเภทกรมธรรม์*/    
    FIELD bray           AS CHAR FORMAT "x(3)" INIT ""
    FIELD contract       AS CHAR FORMAT "x(15)" INIT "" 
    FIELD policy         AS CHAR FORMAT "x(13)" INIT "" 
    FIELD prepol         AS CHAR FORMAT "x(13)" INIT ""                     
    field cedcode        as  CHAR FORMAT "X(20)"  INIT ""                  /* รหัสอ้างอิง   */                           
    field inscode        as  CHAR FORMAT "X(20)"  INIT ""                  /* รหัสลูกค้า    */                           
    FIELD campcode       as  CHAR FORMAT "X(20)"  INIT ""                  /* รหัสแคมเปญ    */                           
    FIELD campname       as  CHAR FORMAT "X(35)"  INIT ""                  /* ชื่อแคมเปญ    */                           
    FIELD procode        as  CHAR FORMAT "X(20)"  INIT ""                  /* รหัสผลิตภัณฑ์ */                           
    FIELD proname        as  CHAR FORMAT "X(35)"  INIT ""                  /* ชื่อผลิตภัณฑ์ */                           
    FIELD packname       as  CHAR FORMAT "X(35)"  INIT ""                  /* ชื่อแพคเก็จ   */                           
    FIELD packcode       as  CHAR FORMAT "X(20)"  INIT ""                  /* รหัสแพคเก็จ   */                           
    FIELD instype        as  CHAR FORMAT "X(1)"   INIT ""                  /* ประเภทผู้เอาประกัน */                      
    FIELD pol_title      as  CHAR FORMAT "X(20)"  INIT ""                  /* คำนำหน้าชื่อ ผู้เอาประกัน */               
    FIELD pol_fname      as  CHAR FORMAT "X(100)" INIT ""                  /* ชื่อ ผู้เอาประกัน         */               
    FIELD pol_title_eng  as  CHAR FORMAT "X(10)"  INIT ""                  /* คำนำหน้าชื่อ ผู้เอาประกัน (Eng) */         
    FIELD pol_fname_eng  as  CHAR FORMAT "X(100)" INIT ""                  /* ชื่อ ผู้เอาประกัน (Eng)*/                  
    FIELD icno           as  CHAR FORMAT "X(13)"  INIT ""                  /* เลขบัตรผู้เอาประกัน */                     
    FIELD bdate          as  CHAR FORMAT "X(15)"  INIT ""                  /* วันเกิดผู้เอาประกัน */                     
    FIELD occup          as  CHAR FORMAT "X(50)"  INIT ""                  /* อาชีพผู้เอาประกัน*/                        
    FIELD tel            as  CHAR FORMAT "X(50)"  INIT ""                  /* เบอร์โทรผู้เอาประกัน*/                     
    FIELD mail           as  CHAR FORMAT "X(50)"  INIT ""                  /* อีเมล์ผู้เอาประกัน  */                     
    FIELD addrpol1       as  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่หน้าตาราง1*/                        
    FIELD addrpol2       as  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่หน้าตาราง2*/                        
    FIELD addrpol3       as  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่หน้าตาราง3*/                        
    FIELD addrpol4       as  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่หน้าตาราง4*/                        
    FIELD addrsend1      as  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่จัดส่ง 1  */                        
    FIELD addrsend2      as  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่จัดส่ง 2  */                        
    FIELD addrsend3      as  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่จัดส่ง 3  */                        
    FIELD addrsend4      as  CHAR FORMAT "X(45)"  INIT ""                  /* ที่อยู่จัดส่ง 4  */                        
    FIELD paytype        as  CHAR FORMAT "X(2)"   INIT ""                  /* ประเภทผู้จ่ายเงิน*/                        
    FIELD paytitle       as  CHAR FORMAT "X(20)"  INIT ""                  /* คำนำหน้าชื่อ ผู้จ่ายเงิน*/                 
    FIELD payname        as  CHAR FORMAT "X(100)" INIT ""                  /* ชื่อ ผู้จ่ายเงิน*/                         
    FIELD icpay          as  CHAR FORMAT "X(50)"  INIT ""                  /* เลขประจำตัวผู้เสียภาษี*/                   
    FIELD addrpay1       as  CHAR FORMAT "X(40)"  INIT ""                  /* ที่อยู่ออกใบเสร็จ1*/                       
    FIELD addrpay2       as  CHAR FORMAT "X(40)"  INIT ""                  /* ที่อยู่ออกใบเสร็จ2*/                       
    FIELD addrpay3       as  CHAR FORMAT "X(40)"  INIT ""                  /* ที่อยู่ออกใบเสร็จ3*/                       
    FIELD addrpay4       as  CHAR FORMAT "X(40)"  INIT ""                  /* ที่อยู่ออกใบเสร็จ4*/                       
    FIELD branch         as  CHAR FORMAT "X(20)"  INIT ""                  /* สาขา*/                                     
    FIELD ben_name       as  CHAR FORMAT "X(100)" INIT ""                  /* ผู้รับผลประโยชน์  */                       
    FIELD pmentcode      as  CHAR FORMAT "X(10)"  INIT ""                  /* รหัสประเภทการจ่าย */                       
    FIELD pmenttyp       as  CHAR FORMAT "X(75)"  INIT ""                  /* ประเภทการจ่าย */                           
    FIELD pmentcode1     as  CHAR FORMAT "X(10)"  INIT ""                  /* รหัสช่องทางการจ่าย*/                       
    FIELD pmentcode2     as  CHAR FORMAT "X(75)"  INIT ""                  /* ช่องทางการจ่าย  */                         
    FIELD pmentbank      as  CHAR FORMAT "X(50)"  INIT ""                  /* ธนาคารที่จ่าย*/                            
    FIELD pmentdate      as  CHAR FORMAT "X(15)"  INIT ""                  /* วันที่จ่าย   */                            
    FIELD pmentsts       as  CHAR FORMAT "X(15)"  INIT ""                  /* สถานะการจ่าย */                            
    field brand          as  char format "x(35)"  init ""                  /* ยี่ห้อ  */                                 
    field Model          as  char format "x(50)"  init ""                  /* รุ่น    */                                 
    field body           as  char format "x(20)"  init ""                  /* แบบตัวถัง*/                                
    field licence        as  char format "x(11)"  init ""                  /* ทะเบียน */                                 
    field province       as  char format "x(25)"  init ""                  /* จังหวัดทะเบียน */                          
    field chassis        as  char format "x(50)"  init ""                  /* เลขตัวถัง*/                                
    field engine         as  char format "x(50)"  init ""                  /* เลขเครื่อง */                              
    field yrmanu         as  char format "x(5)"   init ""                  /* ปีรถ    */                                 
    field seatenew       as  char format "x(5)"   init ""                  /* ที่นั่ง */                                 
    FIELD power          as  CHAR FORMAT "x(15)"  INIT ""                  /* ซีซี    */                                 
    FIELD weight         as  CHAR FORMAT "X(15)"  INIT ""                  /* น้ำหนัก */                                 
    FIELD class          as  char format "x(5)"   init ""                  /* คลาสรถ  */                                                   
    FIELD garage         as  char format "x(35)"  init ""                  /* การซ่อม */                                 
    FIELD colorcode      as  char format "x(35)"  init ""                  /* สี  */                                     
    FIELD covcod         as  char format "x(50)"  init ""                  /* ประเภทการประกัน */                         
    FIELD covtyp         as  char format "x(30)"  init ""                  /* รหัสการประกัน*/                            
    FIELD comdat         as  char format "x(15)"  init ""                  /* วันที่คุ้มครอง  */                         
    FIELD expdat         as  char format "x(15)"  init ""                  /* วันที่หมดอายุ*/                            
    FIELD ins_amt        as  CHAR FORMAT "x(20)"  INIT ""                  /* ทุนประกัน*/                                
    FIELD prem1          as  char format "x(20)"  init ""                  /* เบี้ยสุทธิก่อนหักส่วนลด*/                  
    FIELD gross_prm      as  char format "x(20)"  init ""                  /* เบี้ยสุทธิหลังหักส่วนลด*/                  
    FIELD stamp          as  CHAR FORMAT "x(10)"  INIT ""                  /* สแตมป์  */                                 
    FIELD vat            as  CHAR FORMAT "X(10)"  INIT ""                  /* ภาษี    */                                 
    FIELD premtotal      as  CHAR FORMAT "x(20)"  INIT ""                  /* เบี้ยรวม*/                                 
    field deduct         as  char format "x(10)"  init ""                  /* Deduct  */                                 
    field fleetper       as  char format "x(10)"  init ""                  /* fleet   */                                 
    field ncbper         as  char format "x(10)"  init ""                  /* ncb     */                                 
    field othper         as  char format "X(10)"  INIT ""                  /* other   */                                 
    field cctvper        as  char format "X(10)"  INIT ""                  /* cctv    */                                 
    FIELD driver         as  CHAR FORMAT "X(2)"   INIT ""                  /* ระบุผู้ขับขี่    */                        
    FIELD drivename1     as  CHAR FORMAT "X(70)"  INIT ""                  /* ชื่อผู้ขับขี่1   */                        
    FIELD driveno1       as  CHAR FORMAT "X(15)"  INIT ""                  /* เลขบัตรผู้ขับขี่1*/                        
    FIELD occupdriv1     as  CHAR FORMAT "X(50)"  INIT ""                  /* อาชีพผู้ขับขี่1  */                        
    FIELD sexdriv1       as  CHAR FORMAT "X(10)"  INIT ""                  /* เพศผู้ขับขี่1    */                        
    FIELD bdatedriv1     as  CHAR FORMAT "X(15)"  INIT ""                  /* วันเกิดผู้ขับขี่1*/
    field licenno1       AS  CHAR FORMAT "x(10)"  INIT ""                  /* เลขใบขับขี่      */ /* A67-0162  */
    field licenex1       AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่บัตรหมดอายุ*/ /* A67-0162  */
    FIELD drivename2     as  CHAR FORMAT "x(70)"  INIT ""                  /* ชื่อผู้ขับขี่2   */                        
    FIELD driveno2       as  char format "x(15)"  init ""                  /* เลขบัตรผู้ขับขี่2*/                        
    FIELD occupdriv2     as  char format "x(50)"  init ""                  /* อาชีพผู้ขับขี่2  */                        
    FIELD sexdriv2       as  char format "x(10)"  init ""                  /* เพศผู้ขับขี่2    */                        
    FIELD bdatedriv2     as  char format "x(15)"  init ""                  /* วันเกิดผู้ขับขี่2*/
    field licenno2       AS  CHAR FORMAT "x(10)"  INIT ""                  /* เลขใบขับขี่      */ /* A67-0162  */
    field licenex2       AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่บัตรหมดอายุ*/ /* A67-0162  */
    /* A67-0162 */
    FIELD drivename3     as  CHAR FORMAT "X(70)"  INIT ""                  /* ชื่อผู้ขับขี่1   */                        
    FIELD driveno3       as  CHAR FORMAT "X(15)"  INIT ""                  /* เลขบัตรผู้ขับขี่1*/                        
    FIELD occupdriv3     as  CHAR FORMAT "X(50)"  INIT ""                  /* อาชีพผู้ขับขี่1  */                        
    FIELD sexdriv3       as  CHAR FORMAT "X(10)"  INIT ""                  /* เพศผู้ขับขี่1    */                        
    FIELD bdatedriv3     as  CHAR FORMAT "X(15)"  INIT ""                  /* วันเกิดผู้ขับขี่1*/
    field licenno3       AS  CHAR FORMAT "x(10)"  INIT ""                  /* เลขใบขับขี่      */ /* A67-0162  */
    field licenex3       AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่บัตรหมดอายุ*/ /* A67-0162  */
    FIELD drivename4     as  CHAR FORMAT "x(70)"  INIT ""                  /* ชื่อผู้ขับขี่2   */                        
    FIELD driveno4       as  char format "x(15)"  init ""                  /* เลขบัตรผู้ขับขี่2*/                        
    FIELD occupdriv4     as  char format "x(50)"  init ""                  /* อาชีพผู้ขับขี่2  */                        
    FIELD sexdriv4       as  char format "x(10)"  init ""                  /* เพศผู้ขับขี่2    */                        
    FIELD bdatedriv4     as  char format "x(15)"  init ""                  /* วันเกิดผู้ขับขี่2*/
    field licenno4       AS  CHAR FORMAT "x(10)"  INIT ""                  /* เลขใบขับขี่      */ /* A67-0162  */
    field licenex4       AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่บัตรหมดอายุ*/ /* A67-0162  */
    FIELD drivename5     as  CHAR FORMAT "x(70)"  INIT ""                  /* ชื่อผู้ขับขี่2   */                        
    FIELD driveno5       as  char format "x(15)"  init ""                  /* เลขบัตรผู้ขับขี่2*/                        
    FIELD occupdriv5     as  char format "x(50)"  init ""                  /* อาชีพผู้ขับขี่2  */                        
    FIELD sexdriv5       as  char format "x(10)"  init ""                  /* เพศผู้ขับขี่2    */                        
    FIELD bdatedriv5     as  char format "x(15)"  init ""                  /* วันเกิดผู้ขับขี่2*/
    field licenno5       AS  CHAR FORMAT "x(10)"  INIT ""                  /* เลขใบขับขี่      */ /* A67-0162  */
    field licenex5       AS  CHAR FORMAT "x(15)"  INIT ""                  /* วันที่บัตรหมดอายุ*/ 
    /* end : A67-0162  */
    FIELD fi             AS  CHAR FORMAT "x(15)"  INIT "" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_disp ra_matchpol fi_loadname fi_outload ~
bu_file-3 bu_ok bu_exit-2 fi_outload2 bu_format fi_outfile fi_namefile ~
RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS fi_disp ra_matchpol fi_loadname fi_outload ~
fi_outload2 fi_outfile fi_namefile 

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

DEFINE BUTTON bu_format  NO-CONVERT-3D-COLORS
     LABEL "Export Format 72" 
     SIZE 15.5 BY .91
     BGCOLOR 15 FGCOLOR 2 FONT 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_disp AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 49 BY .91
     BGCOLOR 19 FGCOLOR 6  NO-UNDO.

DEFINE VARIABLE fi_loadname AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_namefile AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 14.83 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(500)":U 
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

DEFINE VARIABLE ra_matchpol AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match File Confirm ", 1,
"Match Policy No V70 (TLT)", 2,
"Match File V72 (TLT)", 3,
"Match Policy Send AYCAL", 4
     SIZE 102.5 BY 1.14
     BGCOLOR 29 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 9.91
     BGCOLOR 19 FGCOLOR 2 .

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
     fi_disp AT ROW 9.71 COL 30 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     ra_matchpol AT ROW 3.67 COL 3 NO-LABEL
     fi_loadname AT ROW 5.19 COL 22.67 COLON-ALIGNED NO-LABEL
     fi_outload AT ROW 6.33 COL 22.67 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 5.24 COL 85.67
     bu_ok AT ROW 10.19 COL 86.33
     bu_exit-2 AT ROW 10.19 COL 96.5
     fi_outload2 AT ROW 7.48 COL 22.67 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     bu_format AT ROW 10.62 COL 50.5 WIDGET-ID 12
     fi_outfile AT ROW 8.57 COL 22.67 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     fi_namefile AT ROW 8.57 COL 7.5 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     "Fileload NEW :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 6.29 COL 12.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 5.19 COL 12
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Output Match :" VIEW-AS TEXT
          SIZE 11.83 BY 1 AT ROW 7.43 COL 12.67 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "     FILE LOAD TO GW , POLICY ON TLT (AYCAL) , FILE SEND AYCAL" VIEW-AS TEXT
          SIZE 105 BY 2.05 AT ROW 1.1 COL 1.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Date. 15/02/2024" VIEW-AS TEXT
          SIZE 15.5 BY 1 AT ROW 10.52 COL 67 WIDGET-ID 22
          BGCOLOR 19 FGCOLOR 1 
     RECT-381 AT ROW 3.24 COL 1.5
     RECT-382 AT ROW 9.76 COL 95.17
     RECT-383 AT ROW 9.76 COL 85.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 106 BY 12.24
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
         TITLE              = "Match text  File AYCAL (New Format)"
         HEIGHT             = 12.29
         WIDTH              = 106.17
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

ASSIGN 
       fi_outload2:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match text  File AYCAL (New Format) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text  File AYCAL (New Format) */
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
          no_add = STRING(MONTH(TODAY),"99")    + 
                   STRING(DAY(TODAY),"99")      + 
                   SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                   SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        fi_loadname  = cvData.
        nv_output = "".
        IF ra_matchpol = 1 THEN DO: 
            ASSIGN fi_outload2  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_receipt_" + NO_add
                   fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Loadnew_" + NO_add
                   fi_outfile   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Loadold_" + NO_add.
            DISP fi_loadname fi_outload fi_outfile fi_outload2  WITH FRAME fr_main .    
        END.
        ELSE IF ra_matchpol = 2 THEN DO: 
            ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_policy".
            DISP fi_loadname fi_outload   WITH FRAME fr_main .    
        END.
        ELSE IF ra_matchpol = 3 THEN DO: 
            ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_policy72".
            DISP fi_loadname fi_outload  WITH FRAME fr_main .    

        END.
        ELSE IF ra_matchpol = 4 THEN DO: 
            ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_SendAYCAL" + 
                                  STRING(DAY(TODAY),"99") + STRING(MONTH(TODAY),"99")  + STRING(YEAR(TODAY),"9999") . /*A65-0115*/
            DISP fi_loadname fi_outload   WITH FRAME fr_main .
        END.
           
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_format
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_format C-Win
ON CHOOSE OF bu_format IN FRAME fr_main /* Export Format 72 */
DO:
    DEF VAR nv_output AS CHAR FORMAT "x(100)" INIT "" .

    nv_output  =  "D:\TEMP\File Match 72.CSV"  .
    OUTPUT TO VALUE(nv_output).
    EXPORT DELIMITER "|" 
     "SEQ  "  
     "INSURANCECODE " 
     "CONTRACTNO "  
     "BRANCHCODE "  
     "BODY   "  
     "ENGINE "  
     "STARTDATE"  
     "ENDDATE " .
    OUTPUT CLOSE.
    MESSAGE " Export format file to : " + nv_output VIEW-AS ALERT-BOX.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN 
        nv_reccnt  =  0.
   
    For each  wload:
        DELETE  wload.
    END.
    For each  wtxt:
        DELETE  wtxt.
    END.


    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.
    /*IF ra_matchpol = 1 THEN RUN proc_impmatpol1.        /* file load */*/ /*A65-0177*/
    IF ra_matchpol = 1 OR ra_matchpol = 4 THEN RUN proc_impmatpol1.        /* file load */ /*A65-0177*/
    ELSE IF ra_matchpol = 2  THEN RUN proc_impmatpol2.  /* match pol no.*/
    ELSE IF ra_matchpol = 3  THEN RUN proc_match72 .   /* Payment  */
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile = INPUT fi_outfile.
  DISP fi_outfile WITH FRAM fr_main.
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


&Scoped-define SELF-NAME ra_matchpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_matchpol C-Win
ON VALUE-CHANGED OF ra_matchpol IN FRAME fr_main
DO:
  ra_matchpol = INPUT ra_matchpol .
  DISP ra_matchpol WITH FRAM fr_main.
    
  IF ra_matchpol = 1  THEN DO:
      ASSIGN fi_disp = "หมายเหตุ: Mach File Confirm ใช้ไฟล์ Confirm ที่AY ส่งมา . " .
      ENABLE fi_outfile fi_namefile  WITH FRAME fr_main.
      DISABLE bu_format  WITH FRAME fr_main.
      HIDE bu_format .
  END.
  ELSE IF ra_matchpol = 2  THEN DO:
      ASSIGN fi_disp = "หมายเหตุ: Mach File Policy 70 ใช้ไฟล์โหลดงาน " .
      DISABLE bu_format WITH FRAME fr_main.
      HIDE bu_format .
      HIDE fi_outfile fi_namefile .
      
  END.
  ELSE IF ra_matchpol = 3 THEN DO:
      ASSIGN fi_disp = "หมายเหตุ: Mach File Policy 72 ใช้ไฟล์แจ้งงานตาม Format72 . " .
      ENABLE bu_format WITH FRAME fr_main.
      HIDE fi_outfile fi_namefile .

  END.
  /* A6-0115 */
  ELSE IF ra_matchpol = 4 THEN DO:
      ASSIGN fi_disp = "หมายเหตุ: Mach File Confirm ใช้ไฟล์ Confirm ที่AY ส่งมา . " .
      HIDE bu_format .
      HIDE fi_outfile fi_namefile.
  END.
  /* end A65-0115*/
  DISP fi_disp WITH FRAME fr_main.

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
      gv_prgid          = "WGWMTAYCL".

  ASSIGN fi_disp = "หมายเหตุ : Mach File Confirm ใช้ไฟล์ Confirm ที่AY ส่งมา . "
         fi_namefile = "Fileload OLD :" .
  DISABLE bu_format WITH FRAME fr_main.
  HIDE bu_format .
      
  gv_prog  = "Match File Policy Send To AYCL".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  /*RUN proc_createpack.*/
  DISP ra_matchpol   fi_disp fi_namefile  WITH FRAM fr_main.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_expfileload C-Win 
PROCEDURE 00-proc_expfileload :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by A67-0162...
DEF VAR nv_damdetail AS LONGCHAR .
DEF VAR nv_yrpol AS INT INIT 0.
DEF VAR nv_yr AS INT INIT 0.
DO:
    
    FOR EACH wload WHERE wload.poltyp  = "V70" OR wload.poltyp  = "V72"  NO-LOCK.
        FIND LAST wtxt WHERE wtxt.poltyp  = wload.poltyp  AND
                             wtxt.cedcode = wload.cedcode AND
                             wtxt.inscode = wload.inscode NO-LOCK NO-ERROR .
    
            IF INDEX(wload.CLASS,".") <> 0  THEN wload.CLASS = REPLACE(wload.class,".","") .
            IF LENGTH(wload.class) < 3 THEN wload.class = wload.class + "0" .
            RUN proc_chklicen. /*เช็คทะเบียน */
            RUN proc_cutpolicy.
           /* เช็คข้อมูลตรวจสภาพ */
                   FIND LAST brstat.tlt USE-INDEX tlt06 WHERE tlt.cha_no = wload.chassis AND 
                                                              tlt.eng_no = wload.engine  AND
                                                              tlt.flag   = "INSPEC"      AND 
                                                              tlt.genusr = "AYCAL"       NO-LOCK NO-ERROR.
                   IF AVAIL tlt THEN DO:
                       ASSIGN wtxt.insno       = brstat.tlt.nor_noti_tlt
                              wtxt.resultins   = brstat.tlt.safe1
                              nv_damdetail     = brstat.tlt.safe2
                              wtxt.dataoth     = brstat.tlt.filler2 . 
                        IF nv_damdetail <> "" THEN DO:
                          IF INDEX(nv_damdetail,"21.") <> 0 THEN DO: 
                              ASSIGN wtxt.damage3 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"21.")))
                                     nv_damdetail = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"21.") - 2))
                                     wtxt.damage2 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"11.")))
                                     wtxt.damage1 = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"11.") - 2)).
                          END.
                          ELSE IF INDEX(nv_damdetail,"11.") <> 0 THEN DO:
                              ASSIGN wtxt.damage3 = ""
                                     wtxt.damage2 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"11.")))
                                     wtxt.damage1 = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"11.") - 2)).
                          END.
                          ELSE DO:
                              ASSIGN wtxt.damage3 = "" 
                                     wtxt.damage2 = ""
                                     wtxt.damage1 = TRIM(nv_damdetail) .
                          END.
                        END.
                        ELSE  ASSIGN wtxt.damage3 = "" 
                                     wtxt.damage2 = "" 
                                     wtxt.damage1 = "".
                   END.
                   ELSE ASSIGN wtxt.insno       = ""
                               wtxt.resultins   = ""
                               wtxt.damage1     = ""
                               wtxt.damage2     = ""
                               wtxt.damage3     = ""
                               wtxt.dataoth     = "" .
           /* เช็คเบอร์ต่ออายุ */
            IF wload.chassis <> ""  THEN DO: 
                ASSIGN  nv_yrpol = 0    nv_yr = 0.  
                RUN proc_chassis.
                IF wload.poltyp = "V70" THEN DO:
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30121  WHERE 
                              sicuw.uwm301.cha_no = trim(wload.chassis) AND 
                              sicuw.uwm301.tariff = "X" NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAIL sicuw.uwm301 THEN DO:
                         nv_yrpol = (INT(SUBSTR(sicuw.uwm301.policy,5,2)) + 2500 ).
                         nv_yr    = (YEAR(TODAY) + 543 ) . 
                         nv_yr    = nv_yr - nv_yrpol .
                         IF nv_yr <= 5 THEN ASSIGN wload.prepol = sicuw.uwm301.policy.
                         ELSE ASSIGN wload.prepol = "" .
                     END.
                     ELSE ASSIGN wload.prepol = "" .
                END.
                ELSE DO:
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30121  WHERE 
                              sicuw.uwm301.cha_no = trim(wload.chassis) AND 
                              sicuw.uwm301.tariff = "9" NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAIL sicuw.uwm301 THEN DO:
                        nv_yrpol = (INT(SUBSTR(sicuw.uwm301.policy,5,2)) + 2500 ).
                        nv_yr    = (YEAR(TODAY) + 543 ) . 
                        nv_yr    = nv_yr - nv_yrpol .
                        IF nv_yr <= 5 THEN ASSIGN wload.prepol = sicuw.uwm301.policy.
                        ELSE ASSIGN wload.prepol = "" .
                       
                     END.
                     ELSE ASSIGN wload.prepol = "" .
    
                END.
            END.
            if index(wload.bdatedriv1,"?") <> 0 or wload.bdatedriv1 = ""  then assign wload.bdatedriv1 = "" .
            ELSE ASSIGN wload.bdatedriv1 = STRING(DAY(DATE(wload.bdatedriv1)),"99") + "/" +
                                           STRING(MONTH(DATE(wload.bdatedriv1)),"99") + "/" +  
                                           STRING(YEAR(DATE(wload.bdatedriv1)),"9999").
            if index(wload.bdatedriv2,"?") <> 0 or wload.bdatedriv2 = ""  then assign wload.bdatedriv2 = "" .
            ELSE ASSIGN wload.bdatedriv2 = STRING(DAY(DATE(wload.bdatedriv2)),"99") + "/" +
                                           STRING(MONTH(DATE(wload.bdatedriv2)),"99") + "/" +  
                                           STRING(YEAR(DATE(wload.bdatedriv2)),"9999").
            if index(wload.occupdriv1,"?") <> 0 or wload.occupdriv1 = ""  then assign wload.occupdriv1 = "" .
            if index(wload.sexdriv1,"?")   <> 0 or wload.sexdriv1   = ""  then assign wload.sexdriv1   = "" .
            if index(wload.occupdriv2,"?") <> 0 or wload.occupdriv2 = ""  then assign wload.occupdriv2 = "" .
            if index(wload.sexdriv2,"?")   <> 0 or wload.sexdriv2   = ""  then assign wload.sexdriv2   = "" .
           
        nv_row  =  nv_row + 1.
        EXPORT DELIMITER "|"                            
            wload.poltyp                                /* ประเภทกรมธรรม์*/ 
            wload.bray                                  /* สาขาจากไฟล์ */
            wload.contract                              /* contract */
            wload.cedcode                               /* รหัสอ้างอิง   */               
            wload.inscode                               /* รหัสลูกค้า    */               
            wload.campcode                              /* รหัสแคมเปญ    */               
            wload.campname                              /* ชื่อแคมเปญ    */               
           /* wload.procode */                              /* รหัสผลิตภัณฑ์ */               
            wload.proname                               /* ชื่อผลิตภัณฑ์ */               
           /* wload.packname  */                            /* ชื่อแพคเก็จ   */               
            wload.packcode                              /* รหัสแพคเก็จ   */
            wload.prepol                                /* กธ.เดิม */
            /*wload.instype */                              /* ประเภทผู้เอาประกัน */          
            wload.pol_title                             /* คำนำหน้าชื่อ ผู้เอาประกัน */   
            wload.pol_fname                             /* ชื่อ ผู้เอาประกัน         */   
           /* wload.pol_title_eng                         /* คำนำหน้าชื่อ ผู้เอาประกัน */   
            wload.pol_fname_eng   */                      /* ชื่อ ผู้เอาประกัน*/            
            wload.icno                                  /* เลขบัตรผู้เอาประกัน */         
            wload.bdate                                 /* วันเกิดผู้เอาประกัน */         
           /* wload.occup   */                              /* อาชีพผู้เอาประกัน*/            
            wload.tel                                   /* เบอร์โทรผู้เอาประกัน*/         
          /*  wload.mail                                  /* อีเมล์ผู้เอาประกัน  */         
            wload.addrpol1                              /* ที่อยู่หน้าตาราง1*/            
            wload.addrpol2                              /* ที่อยู่หน้าตาราง2*/            
            wload.addrpol3                              /* ที่อยู่หน้าตาราง3*/            
            wload.addrpol4  */                            /* ที่อยู่หน้าตาราง4*/            
            wload.addrsend1                             /* ที่อยู่จัดส่ง 1  */            
            wload.addrsend2                             /* ที่อยู่จัดส่ง 2  */            
            wload.addrsend3                             /* ที่อยู่จัดส่ง 3  */            
            wload.addrsend4                             /* ที่อยู่จัดส่ง 4  */            
           /* wload.paytype   */                            /* ประเภทผู้จ่ายเงิน*/            
            wload.paytitle                              /* คำนำหน้าชื่อ ผู้จ่ายเงิน*/     
            wload.payname                               /* ชื่อ ผู้จ่ายเงิน*/  
            wload.icpay                                 /* เลขประจำตัวผู้เสียภาษี*/                     
            wload.addrPay1                              /* ที่อยู่ออกใบเสร็จ1*/                         
            wload.addrPay2                              /* ที่อยู่ออกใบเสร็จ2*/                         
            wload.addrPay3                              /* ที่อยู่ออกใบเสร็จ3*/                         
            wload.addrPay4                              /* ที่อยู่ออกใบเสร็จ4*/ 
           /* wload.branch  */                              /* สาขา*/                         
            wload.ben_name                              /* ผู้รับผลประโยชน์  */           
            /*wload.pmentcode*/                             /* รหัสประเภทการจ่าย */           
            wload.pmenttyp                              /* ประเภทการจ่าย */               
           /* wload.pmentcode1*/                            /* รหัสช่องทางการจ่าย*/           
            wload.pmentcode2                            /* ช่องทางการจ่าย  */             
           /* wload.pmentbank                             /* ธนาคารที่จ่าย*/                
            wload.pmentdate                             /* วันที่จ่าย   */                
            wload.pmentsts  */                            /* สถานะการจ่าย */                
            wload.brand                                 /* ยี่ห้อ  */                     
            wload.Model                                 /* รุ่น    */                     
            wload.body                                  /* แบบตัวถัง*/                    
            wload.licence                               /* ทะเบียน */                     
            wload.province                              /* จังหวัดทะเบียน */              
            wload.chassis                               /* เลขตัวถัง*/                    
            wload.engine                                /* เลขเครื่อง */                  
            wload.yrmanu                                /* ปีรถ    */                     
            /*wload.seatenew      */                        /* ที่นั่ง */                     
            wload.power                                 /* ซีซี    */                     
            /*wload.weight    */                            /* น้ำหนัก */                     
            wload.class                                 /* คลาสรถ  */                     
            wload.garage                                /* การซ่อม */                     
            /*wload.colorcode */                            /* สี  */                         
            wload.covcod                                /* ประเภทการประกัน */             
            wload.covtyp                                /* รหัสการประกัน*/                
            wload.comdat                                /* วันที่คุ้มครอง  */             
            wload.expdat                                /* วันที่หมดอายุ*/                
            wload.ins_amt                               /* ทุนประกัน*/
            wload.fi                                    /* ทุนสูญหาย/ไฟไหม้*/
            wload.prem1                                 /* เบี้ยสุทธิก่อนหักส่วนลด*/      
            wload.gross_prm                             /* เบี้ยสุทธิหลังหักส่วนลด*/      
            wload.stamp                                 /* สแตมป์  */                     
            wload.vat                                   /* ภาษี    */                     
            wload.premtotal                             /* เบี้ยรวม*/                     
            wload.deduct                                /* Deduct  */                     
            wload.fleetper                              /* fleet   */                     
            wload.ncbper                                /* ncb     */
            wload.othper                                /* other   */                     
            wload.cctvper                               /* cctv    */ 
            wload.driver                                /* ระบุผู้ขับขี่    */            
            wload.drivename1                            /* ชื่อผู้ขับขี่1   */    
            wload.driveno1                              /* เลขบัตรผู้ขับขี่1*/            
            wload.occupdriv1                            /* อาชีพผู้ขับขี่1  */            
            wload.sexdriv1                              /* เพศผู้ขับขี่1    */            
            wload.bdatedriv1                            /* วันเกิดผู้ขับขี่1*/            
            wload.drivename2                            /* ชื่อผู้ขับขี่2   */                 
            wload.driveno2                              /* เลขบัตรผู้ขับขี่2*/          
            wload.occupdriv2                            /* อาชีพผู้ขับขี่2  */            
            wload.sexdriv2                              /* เพศผู้ขับขี่2    */            
            wload.bdatedriv2                             /* วันเกิดผู้ขับขี่2*/            
            /*wtxt.acc1       */                            /* อุปกรณ์ตกแต่ง1   */            
            wtxt.accdetail1                             /* รายละเอียดอุปกรณ์1*/           
            wtxt.accprice1                              /* ราคาอุปกรณ์1  */               
            /*wtxt.acc2          */                         /* อุปกรณ์ตกแต่ง2*/               
            wtxt.accdetail2                             /* รายละเอียดอุปกรณ์2*/           
            wtxt.accprice2                              /* ราคาอุปกรณ์2  */               
            /*wtxt.acc3           */                        /* อุปกรณ์ตกแต่ง3*/               
            wtxt.accdetail3                             /* รายละเอียดอุปกรณ์3*/           
            wtxt.accprice3                              /* ราคาอุปกรณ์3  */               
            /*wtxt.acc4     */                              /* อุปกรณ์ตกแต่ง4*/               
            wtxt.accdetail4                             /* รายละเอียดอุปกรณ์4*/           
            wtxt.accprice4                              /* ราคาอุปกรณ์4  */               
            /*wtxt.acc5       */                            /* อุปกรณ์ตกแต่ง5*/               
            wtxt.accdetail5                             /* รายละเอียดอุปกรณ์5*/           
            wtxt.accprice5                              /* ราคาอุปกรณ์5  */               
            wtxt.inspdate                               /* วันที่ตรวจสภาพ*/  
            wtxt.brokname                               /* ชื่อตรวจสภาพ */ 
            wtxt.licenBroker                              /* เบอร์โทรตรวจสภาพ */ 
            wtxt.brokcode                             /* สถานที่ตรวจสภาพ*/   
            /*wtxt.inspdate_app    */                       /* วันที่อนุมัติผลการตรวจ*/       
            /*wtxt.inspsts  */                              /* ผลการตรวจสภาพ*/                
            wtxt.inspdetail                             /* รายละเอียดการตรวจสภาพ*/        
            wtxt.not_date                               /* วันที่ขาย*/                    
            wtxt.paydate                                /* วันที่รับชำระเงิน*/            
           /* wtxt.paysts   */                              /* สถานะการจ่าย*/                 
            /* wtxt.lang                                   /* ภาษา        */                 
            wtxt.deli     */                              /* การจัดส่งกรมธรรม์   */         
            wtxt.delidetail                             /* รายละเอียดการจัดส่ง */         
            wtxt.gift                                   /* Agent name  */                     
            wtxt.remark                                 /* หมายเหตุ*/                     
            wtxt.insno                                   /* เลขตรวจสภาพ */      
            wtxt.resultins                               /* ผลการตรวจ */   
            wtxt.damage1                                 /* ความเสียหาย1 */ 
            wtxt.damage2                                 /* ความเสียหาย2 */
            wtxt.damage3                                 /* ความเสียหาย3 */   
            wtxt.dataoth                                 /* ข้อมูลอื่นๆ */  
            wtxt.policy                                   /* policy */
            wtxt.producer
            wtxt.agent
            wtxt.dealer     /*A65-0115*/
            wtxt.hobr
            wtxt.remark2
            wtxt.nCOLOR .  /*A66-0160*/
    
    END. 
END.
...END A67-0162...*/                                                         
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
  DISPLAY fi_disp ra_matchpol fi_loadname fi_outload fi_outload2 fi_outfile 
          fi_namefile 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_disp ra_matchpol fi_loadname fi_outload bu_file-3 bu_ok bu_exit-2 
         fi_outload2 bu_format fi_outfile fi_namefile RECT-381 RECT-382 
         RECT-383 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adddata C-Win 
PROCEDURE proc_adddata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN
         n_campname   = trim(substr(brstat.tlt.lotno,R-INDEX(brstat.tlt.lotno,"CamName:") + 8 ))     /*ชื่อแคมเปญ*/
         n_char       = trim(SUBSTR(brstat.tlt.lotno,1,R-INDEX(brstat.tlt.lotno,"CamName:") - 2 ))
         n_campcode   = trim(substr(n_char,R-INDEX(n_char,"CamCode:") + 8))                   /*รหัสแคมเปญ*/
         n_char       = trim(SUBSTR(n_char,1,R-INDEX(n_char,"CamCode:") - 2))
         n_cmr_code   = trim(substr(n_char,R-INDEX(n_char,"InsCode:") + 8))                   /*รหัสบริษัท*/

         n_packcode   = TRIM(SUBSTR(brstat.tlt.usrsent,R-INDEX(brstat.tlt.usrsent,"PackCod:") + 8))   /*รหัสแพคเกจ    */ 
         n_char       = TRIM(SUBSTR(brstat.tlt.usrsent,1,R-INDEX(brstat.tlt.usrsent,"PackCod:") - 2))
         n_proname    = trim(substr(n_char,R-INDEX(n_char,"proname:") + 8))    /*ชื่อผลิตภัณฑ์ */ 
        
         /*-- ชื่อสกุลลูกค้า ---*/
         n_char      = trim(brstat.tlt.ins_name)
         n_pol_lname = IF n_char <> " "  THEN trim(SUBSTR(n_char,R-INDEX(n_char," ")))                   ELSE ""
         n_char      = IF n_char <> " "  THEN trim(SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(n_pol_lname)))   ELSE ""
         n_pol_fname = IF trim(n_char) <> "NameTha:" THEN trim(SUBSTR(n_char,R-INDEX(n_char,"Nametha:") + 8)) ELSE ""       
         
         /*-- เลขบัตร วันเกิด เพศ อาขีพ --*/
         n_char     = TRIM(brstat.tlt.rec_addr5)
         n_bdate    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Birth:") + 6 ))
         n_char     = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Birth:") - 2 ))
         n_sex      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Sex:") + 4 ))
         n_icno     = TRIM(SUBSTR(n_char,6,R-INDEX(n_char,"Sex:") - 6 )) 
         /*-- เบอร์โทร เมล์ ไลน์ ---*/
         n_tel      = TRIM(SUBSTR(brstat.tlt.ins_addr5,7)) 

         n_driver     = string(brstat.tlt.endcnt) 
         n_driveno1   = TRIM(substr(brstat.tlt.dri_name1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") + 7 ))
         n_char       = TRIM(SUBSTR(brstat.tlt.dri_name1,1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") - 2 ))
         n_drivelname1 = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE ""
         n_char       = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char
         n_drivename1 = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char,"Drinam1:") + 8)) ELSE "" 
         n_bdatedriv1 = TRIM(SUBSTR(brstat.tlt.dri_no1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") + 8 ))
         n_char       = TRIM(SUBSTR(brstat.tlt.dri_no1,1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") - 2))
         n_sexdriv1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex1:") + 8 ))
         n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex1:") - 2))
         n_occupdriv1 = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc1:") + 8))

         n_driveno2   = TRIM(substr(brstat.tlt.dri_name2,R-INDEX(brstat.tlt.dri_name2,"DriID2:") + 7 ))     
         n_char      = TRIM(SUBSTR(brstat.tlt.dri_name2,1,R-INDEX(brstat.tlt.dri_name2,"DriID2:") - 2 ))   
         n_drivelname2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE ""        
         n_char      = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char 
         n_drivename2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,9,R-INDEX(n_char,"Drinam2:") + 8)) ELSE ""  
         n_bdatedriv2 = TRIM(SUBSTR(brstat.tlt.dri_no2,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") + 8))
         n_char      = TRIM(SUBSTR(brstat.tlt.dri_no2,1,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") - 2))
         n_sexdriv2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex2:") + 8 ))
         n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex2:") - 2 ))
         n_occupdriv2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc2:") + 8 )) 
         /*--การชำระเงิน --*/

         n_paylname   = TRIM(substr(brstat.tlt.rec_name,R-INDEX(brstat.tlt.rec_name," ")))
         n_payname   = trim(substr(brstat.tlt.rec_name,1,LENGTH(brstat.tlt.rec_name) - LENGTH(n_paylname)))

         n_pmentcode2   = trim(substr(brstat.tlt.safe2,R-INDEX(brstat.tlt.safe2,"Paymentty:") + 10 ))
         n_char      = TRIM(SUBSTR(brstat.tlt.safe2,1,R-INDEX(brstat.tlt.safe2,"Paymentty:") - 2 ))
         n_pmenttyp  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMDTy:") + 12 ))

         /* garage */
          n_garage    = trim(substr(brstat.tlt.old_cha,7))   

         /* ประเภทความคุ้มครอง */
         n_char       = TRIM(brstat.tlt.rec_addr3)
         n_covcod    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"covtcd:") + 7 ))
         n_covtyp    = TRIM(SUBSTR(n_char,8,INDEX(n_char,"covtcd:") - 8 ))
              /*- แสตมป์ vat --*/
        n_stamp     = string(DECI(SUBSTR(brstat.tlt.stat,5,R-INDEX(brstat.tlt.stat,"Vat:") - 5)))  
        n_vat       = string(DECI(SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"Vat:") + 4 ))) 
        /* ส่วนลด */
       /* n_feelt     = string(DECI(SUBSTR(brstat.tlt.comp_sck,R-INDEX(brstat.tlt.comp_sck ,"felA:") + 5 )))
        n_ncb       = string(DECI(SUBSTR(brstat.tlt.comp_noti_tlt,R-INDEX(brstat.tlt.comp_noti_tlt ,"ncbA:") + 5 )))  
        n_dridis    = string(DECI(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt ,"DriA:") + 5 )))
        n_othdis    = string(DECI(SUBSTR(brstat.tlt.comp_noti_ins,R-INDEX(brstat.tlt.comp_noti_ins ,"OthA:") + 5 )))
        n_cctv      = string(DECI(SUBSTR(brstat.tlt.comp_usr_ins,R-INDEX(brstat.tlt.comp_usr_ins ,"ctvA:") + 5 )))  
        n_discdetail= trim(SUBSTR(brstat.tlt.comp_pol,R-INDEX(brstat.tlt.comp_pol,"Surd:") + 5 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.comp_pol,1,R-INDEX(brstat.tlt.comp_pol,"surd:") - 2 ))
        n_disc      = string(DECI(SUBSTR(n_char,R-INDEX(n_char,"SurA:") + 5 )))*/
       /* อุปกรณ์ตกแต่ง */
        n_accprice5  = string(deci(substr(brstat.tlt.filler1,R-INDEX(brstat.tlt.filler1,"Acp5:") + 5)))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler1,1,R-INDEX(brstat.tlt.filler1,"Acp5:") - 2 ))
        n_accdetail5   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd5:") - 2))
        n_accprice4  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 )))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 ))
        n_accdetail4 = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 ))
        
        n_accprice3   = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 ))) 
        n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))
        n_accdetail3  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 )) 
        
        n_accprice2   = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 ))) 
        n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 ))
        n_accdetail2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 ))
       
        n_accprice1   = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 ))) 
        n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 ))  
        n_accdetail1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 ))

       /* nv_inspdet   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") + 7))*/
        n_brokcode    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bloca:") + 6 ))
        n_char        = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bloca:") - 2 ))
        n_brokname    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))
        n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))
        n_licenBroker = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Bphon:") + 6 ))

        n_remark    = TRIM(SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"Remark:") + 7 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.filler2,1,R-INDEX(brstat.tlt.filler2,"Remark:") - 2 ))

        n_delidetail = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai3:") + 7 ))
        /* Add by : A67-0162 */
        n_tyeeng        = trim(brstat.tlt.note2)         
        n_typMC         = trim(brstat.tlt.note3)         
        n_watt          = trim(string(brstat.tlt.watts))         
        n_evmotor1      = trim(brstat.tlt.note4)         
        n_evmotor2      = trim(brstat.tlt.note5)         
        n_evmotor3      = trim(brstat.tlt.note6)         
        n_evmotor4      = trim(brstat.tlt.note7)         
        n_evmotor5      = trim(brstat.tlt.note8)         
        n_carprice      = trim(string(brstat.tlt.maksi))         
        n_drivlicen1    = trim(brstat.tlt.dri_lic1)      
        n_drivcardexp1  = STRING(brstat.tlt.dri_licenexp1) 
        n_drivlicen2    = trim(brstat.tlt.dri_lic2)      
        n_drivcardexp2  = STRING(brstat.tlt.dri_licenexp2) 
        n_drivetitle3   = trim(brstat.tlt.dri_title3) + " " + trim(brstat.tlt.dri_fname3)
        n_drivelname3   = trim(brstat.tlt.dri_lname3)    
        n_bdatedriv3    = STRING(brstat.tlt.dri_birth3)    
        n_sexdriv3      = trim(brstat.tlt.dri_gender3)  
        n_driveno3      = trim(brstat.tlt.dri_no3 )  
        n_drivlicen3    = trim(brstat.tlt.dri_lic3)  
        n_drivcardexp3  = STRING(brstat.tlt.dri_licenexp3)
        n_occupdriv3    = trim(brstat.tlt.dir_occ3)  
        n_drivetitle4   = trim(brstat.tlt.dri_title4) + " " + trim(brstat.tlt.dri_fname4) 
        n_drivelname4   = trim(brstat.tlt.dri_lname4 )  
        n_bdatedriv4    = STRING(brstat.tlt.dri_birth4 )  
        n_sexdriv4      = trim(brstat.tlt.dri_gender4)  
        n_driveno4      = trim(brstat.tlt.dri_no4 ) 
        n_drivlicen4    = trim(brstat.tlt.dri_lic4) 
        n_drivcardexp4  = STRING(brstat.tlt.dri_licenexp4 )
        n_occupdriv4    = trim(brstat.tlt.dri_occ4)   
        n_drivetitle5   = trim(brstat.tlt.dri_title5) + " " + trim(brstat.tlt.dri_fname5)   
        n_drivelname5   = trim(brstat.tlt.dri_lname5)   
        n_bdatedriv5    = STRING(brstat.tlt.dri_birth5)   
        n_sexdriv5      = trim(brstat.tlt.dri_gender5)
        n_driveno5      = trim(brstat.tlt.dri_no5 )   
        n_drivlicen5    = trim(brstat.tlt.dri_lic5)   
        n_drivcardexp5  = STRING(brstat.tlt.dri_licenexp5)
        n_occupdriv5    = trim(brstat.tlt.dri_occ5) 
        n_battflag      = STRING(brstat.tlt.battflg) 
        n_battyr        = trim(brstat.tlt.battyr)
        n_battdate      = STRING(brstat.tlt.ndate1)
        n_battprice     = STRING(brstat.tlt.battprice)
        n_battno        = trim(brstat.tlt.battno)
        n_battsi        = STRING(brstat.tlt.battsi)
        n_chagreno      = trim(brstat.tlt.chargno) 
        n_chagrebrand   = trim(brstat.tlt.note19) . 

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign C-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wload WHERE wload.covtyp   = trim(n_covtyp)   AND
                       wload.cedcode  = trim(n_cedcode)  AND
                       wload.inscode  = trim(n_inscode)  NO-LOCK NO-ERROR.
    IF NOT AVAIL wload THEN DO:
        CREATE wload.
        ASSIGN                                     
            wload.poltyp         = trim(n_poltyp) 
            wload.bray           = TRIM(n_bray)
            wload.contract       = TRIM(n_contract)
            wload.cedcode        = trim(n_cedcode)                                          
            wload.inscode        = trim(n_inscode)                                          
            wload.campcode       = trim(n_campcode)                                          
            wload.campname       = trim(n_campname)   
            wload.proname        = trim(n_proname)    
            wload.packcode       = trim(n_packcode) 
            wload.prepol         = TRIM(n_prepol)
            wload.pol_title      = trim(n_pol_title)                                          
            wload.pol_fname      = trim(n_pol_fname) 
            wload.icno           = trim(n_icno)                   
            wload.bdate          = trim(n_bdate) 
            wload.tel            = trim(n_tel)  
            wload.addrsend1      = trim(n_addr1_72)                   
            wload.addrsend2      = trim(n_addr2_72)                   
            wload.addrsend3      = trim(n_addr3_72)                   
            wload.addrsend4      = trim(n_addr4_72) 
            wload.paytitle       = trim(n_paytitle)                   
            wload.payname        = trim(n_payname)
            wload.icpay          = trim(n_payicno)  
            wload.addrpay1       = trim(n_payaddr1)  
            wload.addrpay2       = trim(n_payaddr2)  
            wload.addrpay3       = trim(n_payaddr3)  
            wload.addrpay4       = trim(n_payaddr4) 
            wload.ben_name       = trim(n_ben_name)   
            wload.pmenttyp       = trim(n_pmenttyp)  
            wload.pmentcode2     = trim(n_pmentcode2) 
            wload.brand          = trim(n_brand)                                          
            wload.Model          = trim(n_Model)                                          
            wload.body           = trim(n_body)                                          
            wload.licence        = trim(n_licence)                                          
            wload.province       = trim(n_province)                                          
            wload.chassis        = trim(n_chassis)                                          
            wload.engine         = trim(n_engine)                                          
            wload.yrmanu         = trim(n_yrmanu)   
            wload.power          = trim(n_power) 
            wload.class          = trim(n_class)                                          
            wload.garage         = trim(n_garage) 
            wload.covcod         = trim(n_covcod)                                          
            wload.covtyp         = trim(n_covtyp)                                          
            wload.comdat         = trim(n_comdat)                                          
            wload.expdat         = trim(n_expdat)                                          
            wload.ins_amt        = trim(n_ins_amt)
            wload.fi             = TRIM(n_fi)
            wload.prem1          = trim(n_prem1)                                          
            wload.gross_prm      = trim(n_gross_prm)                                          
            wload.stamp          = trim(n_stamp)                                          
            wload.vat            = trim(n_vat)                                          
            wload.premtotal      = trim(n_premtotal)                                          
            wload.deduct         = trim(n_deduct)                                          
            wload.fleetper       = trim(n_fleetper)                                          
            wload.ncbper         = trim(n_ncbper)    
            wload.othper         = trim(n_othper)                                     
            wload.cctvper        = trim(n_cctvper)  
            wload.driver         = trim(n_driver)                                          
            wload.drivename1     = trim(n_drivename1)                                          
            wload.driveno1       = trim(n_driveno1)                                          
            wload.occupdriv1     = trim(n_occupdriv1)                                          
            wload.sexdriv1       = trim(n_sexdriv1)                                          
            wload.bdatedriv1     = trim(n_bdatedriv1)                                          
            wload.drivename2     = trim(n_drivename2)                                          
            wload.driveno2       = trim(n_driveno2)                                          
            wload.occupdriv2     = trim(n_occupdriv2)                                          
            wload.sexdriv2       = trim(n_sexdriv2)                                          
            wload.bdatedriv2     = trim(n_bdatedriv2)
            /* A67-0162 */
            wload.licenno1       = trim(n_drivlicen1)  
            wload.licenex1       = trim(n_drivcardexp1)
            wload.licenno2       = trim(n_drivlicen2)  
            wload.licenex2       = trim(n_drivcardexp2)
            wload.drivename3     = trim(n_drivename3)   
            wload.driveno3       = trim(n_driveno3)     
            wload.occupdriv3     = trim(n_occupdriv3)   
            wload.sexdriv3       = trim(n_sexdriv3)   
            wload.bdatedriv3     = trim(n_bdatedriv3)   
            wload.licenno3       = trim(n_drivlicen3)   
            wload.licenex3       = trim(n_drivcardexp3) 
            wload.drivename4     = trim(n_drivename4)   
            wload.driveno4       = trim(n_driveno4)   
            wload.occupdriv4     = trim(n_occupdriv4)   
            wload.sexdriv4       = trim(n_sexdriv4)   
            wload.bdatedriv4     = trim(n_bdatedriv4)   
            wload.licenno4       = trim(n_drivlicen4)   
            wload.licenex4       = trim(n_drivcardexp4) 
            wload.drivename5     = trim(n_drivename5)   
            wload.driveno5       = trim(n_driveno5)   
            wload.occupdriv5     = trim(n_occupdriv5)   
            wload.sexdriv5       = trim(n_sexdriv5)   
            wload.bdatedriv5     = trim(n_bdatedriv5)   
            wload.licenno5       = trim(n_drivlicen5)   
            wload.licenex5       = trim(n_drivcardexp5) .

        CREATE wtxt.                                                         
        ASSIGN                                                               
            wtxt.poltyp        =  trim(n_poltyp )                                       
            wtxt.cedcode       =  trim(n_cedcode)                                       
            wtxt.inscode       =  trim(n_inscode)                                        
            wtxt.accdetail1    =  trim(n_accdetail1)                                                                                 
            wtxt.accprice1     =  trim(n_accprice1)                   
            wtxt.accdetail2    =  trim(n_accdetail2)                                                                                 
            wtxt.accprice2     =  trim(n_accprice2)                    
            wtxt.accdetail3    =  trim(n_accdetail3)                                                                                 
            wtxt.accprice3     =  trim(n_accprice3)                                                         
            wtxt.accdetail4    =  trim(n_accdetail4)                                                                                 
            wtxt.accprice4     =  trim(n_accprice4)                                                           
            wtxt.accdetail5    =  trim(n_accdetail5)                                                                                 
            wtxt.accprice5     =  trim(n_accprice5)                                                                                 
            wtxt.inspdate      =  trim(n_inspdate)                   
            wtxt.inspdetail    =  trim(n_inspdetail)                                                                                 
            wtxt.not_date      =  trim(n_not_date)                                                                                 
            wtxt.paydate       =  trim(n_paydate)                
            wtxt.licenBroker   =  trim(n_licenBroker)                                               
            wtxt.brokname      =  trim(n_brokname)                                       
            wtxt.brokcode      =  trim(n_brokcode)
            wtxt.delidetail    =  trim(n_delidetail)    
            wtxt.gift          =  trim(n_gift)    
            wtxt.remark        =  trim(n_remark)   
            wtxt.insno         =  trim(n_insno)   
            wtxt.resultins     =  trim(n_resultins)
            wtxt.damage1       =  trim(n_damage1)   
            wtxt.damage2       =  trim(n_damage2)   
            wtxt.damage3       =  trim(n_damage3)   
            wtxt.dataoth       =  trim(n_dataoth)
            wtxt.policy        =  TRIM(n_policy)
            wtxt.producer      =  TRIM(n_producer)
            wtxt.agent         =  TRIM(n_agent)
            wtxt.dealer        =  TRIM(n_dealer)  /*A65-0115*/
            wtxt.hobr          =  TRIM(n_hobr)
             /* add by : A67-0162 */
            wtxt.nCOLOR       = trim(n_color) 
            wtxt.watt         = trim(n_watt )     
            wtxt.evmotor1     = trim(n_evmotor1)  
            wtxt.evmotor2     = trim(n_evmotor2)  
            wtxt.evmotor3     = trim(n_evmotor3)  
            wtxt.evmotor4     = trim(n_evmotor4)  
            wtxt.evmotor5     = trim(n_evmotor5)  
            wtxt.carprice     = trim(n_carprice)  
            wtxt.battflag     = trim(n_battflag)    
            wtxt.battyr       = trim(n_battyr)   
            wtxt.battdate     = trim(n_battdate )   
            wtxt.battprice    = trim(n_battprice)   
            wtxt.battno       = trim(n_battno)   
            wtxt.battsi       = trim(n_battsi)   
            wtxt.chagreno     = trim(n_chagreno)   
            wtxt.chagrebrand  = trim(n_chagrebrand) .
            /*..end A67-0162..*/
    END.                                 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigndata C-Win 
PROCEDURE proc_assigndata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    CREATE  wload .
    ASSIGN 
        wload.poltyp     = brstat.tlt.flag  
        wload.bray       = TRIM(wdetail.branch)
        wload.contract   = TRIM(wdetail.contract)
        wload.cedcode    = brstat.tlt.nor_noti_ins         
        wload.inscode    = brstat.tlt.nor_usr_ins       
        wload.campcode   = trim(n_campcode)        
        wload.campname   = trim(n_campname)        
        /*wload.procode    = trim(n_procode)  */      
        wload.proname    = trim(n_proname)       
        /*wload.packname   = trim(n_packname)*/        
        wload.packcode   = trim(n_packcode)       
        wload.prepol     = TRIM(SUBSTR(brstat.tlt.imp,R-INDEX(brstat.tlt.imp,"Pol:") + 4))      
        wload.instype    = trim(n_instype)  
        wload.pol_title  = trim(n_pol_title)  
        wload.pol_fname  = trim(n_pol_fname) + " " + TRIM(n_pol_lname)        
        /* wload.pol_title_eng =  TRIM(n_pol_title_eng)    
        wload.pol_fname_eng =  TRIM(n_pol_fname_eng) + " " + TRIM(n_pol_lname_eng)  */ 
        wload.icno       = TRIM(n_icno)        
        wload.bdate      = TRIM(n_polbdate)        
        /*wload.occup      = TRIM(n_occup)*/        
        wload.tel        = trim(n_tel)
        /* wload.mail       = trim(n_mail)        
        wload.addrpol1   = trim(n_addr1_70)     
        wload.addrpol2   = trim(n_addr2_70)     
        wload.addrpol3   = trim(n_addr3_70)     
        wload.addrpol4   = trim(n_addr4_70)*/     
        wload.addrsend1  = trim(n_addr1_72)        
        wload.addrsend2  = trim(n_addr2_72)        
        wload.addrsend3  = trim(n_addr3_72)        
        wload.addrsend4  = trim(n_addr4_72)        
        /*wload.paytype    = TRIM(n_paytype)  */     
        wload.paytitle   = TRIM(n_paytitle)
        wload.payname    = trim(n_payname) + " " + TRIM(n_paylname)        
        wload.icpay      = trim(brstat.tlt.comp_sub)           
        wload.addrPay1   = trim(n_payaddr1)         
        wload.addrPay2   = trim(n_payaddr2)         
        wload.addrPay3   = trim(n_payaddr3)         
        wload.addrPay4   = trim(n_payaddr4)         
        /*wload.branch     = TRIM(n_branch)*/        
        wload.ben_name   = TRIM(n_ben_name)       
        /*wload.pmentcode  = trim(n_pmentcode) */         
        wload.pmenttyp   = trim(n_pmenttyp)          
        /* wload.pmentcode1 = trim(n_pmentcode1)  */        
        wload.pmentcode2 = trim(n_pmentcode2)          
        /*  wload.pmentbank  = TRIM(brstat.tlt.safe3)         
        wload.pmentdate  = TRIM(n_pmentdate)       
        wload.pmentsts   = trim(n_pmentsts)*/        
        wload.brand      = trim(brstat.tlt.brand)               
        wload.Model      = trim(brstat.tlt.model)             
        wload.body       = trim(brstat.tlt.expousr)           
        wload.licence    = trim(brstat.tlt.lince1)            
        wload.province   = trim(brstat.tlt.lince2)            
        wload.chassis    = trim(brstat.tlt.cha_no)            
        wload.engine     = trim(brstat.tlt.eng_no)            
        wload.yrmanu     = trim(brstat.tlt.gentim)            
        /* wload.seatenew   = STRING(brstat.tlt.sentcnt)  */               
        wload.power      = STRING(brstat.tlt.rencnt)                  
        /* wload.weight     = string(brstat.tlt.cc_weight)   */            
        wload.class      = trim(brstat.tlt.expotim)           
        wload.garage     = trim(n_garage)        
        wload.colorcode  = TRIM(brstat.tlt.colorcod)        
        wload.covcod     = trim(n_covcod)         
        wload.covtyp     = trim(n_covtyp)         
        wload.comdat     = string(DAY(brstat.tlt.gendat),"99") + "/" +
                           string(MONTH(brstat.tlt.gendat),"99") + "/" +
                           string(YEAR(brstat.tlt.gendat),"9999") 
        wload.expdat     = string(DAY(brstat.tlt.expodat),"99") + "/" +
                           string(MONTH(brstat.tlt.expodat),"99") + "/" +
                           string(YEAR(brstat.tlt.expodat),"9999")  
        wload.ins_amt    = string(brstat.tlt.nor_coamt,">>>,>>>,>>9.99")
        wload.fi         = IF trim(wload.covcod) = "1" THEN string(brstat.tlt.nor_coamt,">>>,>>>,>>9.99") ELSE "0"
        wload.prem1      = string(brstat.tlt.nor_grprm,">>>,>>>,>>9.99")                                                              
        wload.gross_prm  = string(brstat.tlt.comp_grprm,">>>,>>>,>>9.99")                                                            
        wload.stamp      = TRIM(SUBSTR(brstat.tlt.stat,5,R-INDEX(brstat.tlt.stat,"Vat:") - 5))               
        wload.vat        = TRIM(SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"Vat:") + 4 ))                
        wload.premtotal  = STRING(brstat.tlt.comp_coamt,">>>,>>>,>>9.99")                                                             
        wload.deduct     = trim(brstat.tlt.endno)                                                            
        wload.fleetper   = string(DECI(SUBSTR(brstat.tlt.comp_sck,R-INDEX(brstat.tlt.comp_sck ,"felA:") + 5 )))         
        wload.ncbper     = string(DECI(SUBSTR(brstat.tlt.comp_noti_tlt,R-INDEX(brstat.tlt.comp_noti_tlt ,"ncbA:") + 5 )))        
        wload.othper     = string(DECI(SUBSTR(brstat.tlt.comp_noti_ins,R-INDEX(brstat.tlt.comp_noti_ins ,"OthA:") + 5 )))       
        wload.cctvper    = string(DECI(SUBSTR(brstat.tlt.comp_usr_ins,R-INDEX(brstat.tlt.comp_usr_ins ,"ctvA:") + 5 )))
        wload.driver     = STRING(brstat.tlt.endcnt)         
        wload.drivename1 = TRIM(n_drivename1) + " " + trim(n_drivelname1)        
        wload.driveno1   = TRIM(n_driveno1)        
        wload.occupdriv1 = n_occupdriv1       
        wload.sexdriv1   = n_sexdriv1       
        wload.bdatedriv1 = n_bdatedriv1
        wload.licenno1   = n_drivlicen1  
        wload.licenex1   = n_drivcardexp1
        wload.drivename2 = n_drivename2 + " " + n_drivelname2               
        wload.driveno2   = n_driveno2                                       
        wload.occupdriv2 = n_occupdriv2                                     
        wload.sexdriv2   = n_sexdriv2                                       
        wload.bdatedriv2 = n_bdatedriv2 
        wload.licenno2   = n_drivlicen2  
        wload.licenex2   = n_drivcardexp2
        wload.drivename3 = n_drivetitle3 + n_drivelname3
        wload.driveno3   = n_driveno3  
        wload.occupdriv3 = n_occupdriv3     
        wload.sexdriv3   = n_sexdriv3    
        wload.bdatedriv3 = n_bdatedriv3   
        wload.licenno3   = n_drivlicen3 
        wload.licenex3   = n_drivcardexp3   
        wload.drivename4 = n_drivetitle4 + n_drivelname4
        wload.driveno4   = n_driveno4     
        wload.occupdriv4 = n_occupdriv4   
        wload.sexdriv4   = n_sexdriv4     
        wload.bdatedriv4 = n_bdatedriv4   
        wload.licenno4   = n_drivlicen4   
        wload.licenex4   = n_drivcardexp4 
        wload.drivename5 = n_drivetitle5 + n_drivelname5
        wload.driveno5   = n_driveno5      
        wload.occupdriv5 = n_occupdriv5  
        wload.sexdriv5   = n_sexdriv5     
        wload.bdatedriv5 = n_bdatedriv5   
        wload.licenno5   = n_drivlicen5   
        wload.licenex5   = n_drivcardexp5.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassis C-Win 
PROCEDURE proc_chassis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew       AS CHAR.
DEFINE VAR nv_len          AS INTE INIT 0.
DEFINE VAR nv_uwm301trareg AS CHAR INIT "" FORMAT "x(30)".

ASSIGN nv_uwm301trareg = trim(wload.chassis) .     
    loop_chk1:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"-") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"-") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"-") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk1.
    END.
    loop_chk2:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"/") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"/") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"/") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk2.
    END.
    loop_chk3:
    REPEAT:
        IF INDEX(nv_uwm301trareg,";") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,";") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,";") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk3.
    END.
    loop_chk4:
    REPEAT:
        IF INDEX(nv_uwm301trareg,".") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,".") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,".") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk4.
    END.
    loop_chk5:
    REPEAT:
        IF INDEX(nv_uwm301trareg,",") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,",") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,",") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk5.
    END.
    loop_chk6:
    REPEAT:
        IF INDEX(nv_uwm301trareg," ") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg," ") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg," ") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk6.
    END.
    loop_chk7:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"\") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"\") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"\") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk7.
    END.
    loop_chk8:
    REPEAT:
        IF INDEX(nv_uwm301trareg,":") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,":") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,":") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk8.
    END.
    loop_chk9:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"|") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"|") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"|") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk9.
    END.
    loop_chk10:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"+") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"+") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk10.
    END.
    loop_chk11:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"#") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"#") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"#") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk11.
    END.
    loop_chk12:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"[") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"[") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"[") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk12.
    END.
    loop_chk13:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"]") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"]") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"]") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk13.
    END.
    loop_chk14:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"'") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"'") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk14.
    END.
    loop_chk15:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"(") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"(") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"(") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk15.
    END.
    loop_chk16:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"_") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"_") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"_") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk16.
    END.
    loop_chk17:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"*") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"*") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"*") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk17.
    END.
     loop_chk18:
    REPEAT:
        IF INDEX(nv_uwm301trareg,")") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,")") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,")") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk18.
    END.
    loop_chk19:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"=") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"=") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"=") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk19.
    END.
    ASSIGN wload.chassis =   trim(nv_uwm301trareg).     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkaddr C-Win 
PROCEDURE proc_chkaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FIND LAST brstat.msgcode WHERE brstat.msgcode.compno   = "999" AND
                                    INDEX(n_pol_fname,brstat.msgcode.MsgDesc) <> 0   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL brstat.msgcode THEN DO:  
             ASSIGN n_pol_title =  trim(brstat.msgcode.branch).
                    n_pol_fname =  REPLACE(n_pol_fname,n_pol_title,"") .
        END.
        ELSE DO:
            ASSIGN  n_pol_title = IF index(n_pol_fname," ") <> 0 THEN trim(SUBSTR(n_pol_fname,1,INDEX(n_pol_fname," ") - 1 )) ELSE "" 
                    n_pol_fname = IF index(n_pol_fname," ") <> 0 THEN trim(SUBSTR(n_pol_fname,R-INDEX(n_pol_fname," ") + 1 )) ELSE n_pol_fname .
        END.
        IF n_pol_title = "น.ส."  THEN ASSIGN n_pol_title = "นางสาว" .

    /*FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno   = "999" AND
                                    INDEX(n_pol_fname_eng,brstat.msgcode.MsgDesc) <> 0   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL brstat.msgcode THEN DO:  
             ASSIGN n_pol_title_eng       =  trim(brstat.msgcode.branch).
                    n_pol_fname_eng    =  REPLACE(n_pol_fname_eng,n_pol_title_eng,"") .
        END.
        ELSE DO:
            ASSIGN n_pol_title_eng = IF index(n_pol_fname_eng," ") <> 0 THEN trim(SUBSTR(n_pol_fname_eng,1,INDEX(n_pol_fname_eng," ") - 1 )) ELSE "" 
                   n_pol_fname_eng = IF index(n_pol_fname_eng," ") <> 0 THEN trim(SUBSTR(n_pol_fname_eng,R-INDEX(n_pol_fname_eng," ") + 1 )) ELSE n_pol_fname_eng .
        END.*/

     IF n_payname <> "" THEN DO:
         FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno   = "999" AND
                                    INDEX(n_payname,brstat.msgcode.MsgDesc) <> 0   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL brstat.msgcode THEN DO:  
             ASSIGN n_paytitle =  trim(brstat.msgcode.branch).
                    n_payname =  REPLACE(n_payname,n_paytitle,"") .
        END.
        ELSE DO:
            ASSIGN  n_paytitle = IF index(n_payname," ") <> 0 THEN trim(SUBSTR(n_payname,1,INDEX(n_payname," ") - 1 )) ELSE "" 
                    n_payname = IF index(n_payname," ") <> 0 THEN trim(SUBSTR(n_payname,R-INDEX(n_payname," ") + 1 )) ELSE n_payname .
        END.

        IF trim(n_paytitle) = "น.ส."  THEN ASSIGN n_paytitle = "นางสาว" .

     END.

   
    /* ทีอ่ยู่จัดส่ง */
    n_addr1_72 = TRIM(brstat.tlt.ins_addr3) + " " + TRIM(brstat.tlt.ins_addr4).
    DO WHILE INDEX(n_addr1_72,"  ") <> 0 :
        ASSIGN n_addr1_72 = REPLACE(n_addr1_72,"  "," ").
    END.
    IF LENGTH(n_addr1_72) > 35  THEN DO:
        loop_add01:
        DO WHILE LENGTH(n_addr1_72) > 35 :
            IF r-INDEX(n_addr1_72," ") <> 0 THEN DO:
                ASSIGN 
                    n_addr2_72  = trim(SUBSTR(n_addr1_72,r-INDEX(n_addr1_72," "))) + " " + n_addr2_72
                    n_addr1_72 = trim(SUBSTR(n_addr1_72,1,r-INDEX(n_addr1_72," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        loop_add02:
        DO WHILE LENGTH(n_addr2_72) > 35 :
            IF r-INDEX(n_addr2_72," ") <> 0 THEN DO:
                ASSIGN 
                    n_addr3_72   = trim(SUBSTR(n_addr2_72,r-INDEX(n_addr2_72," "))) + " " + n_addr3_72
                    n_addr2_72  = trim(SUBSTR(n_addr2_72,1,r-INDEX(n_addr2_72," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
        loop_add03:
        DO WHILE LENGTH(n_addr3_72) > 35 :
            IF r-INDEX(n_addr3_72," ") <> 0 THEN DO:
                ASSIGN 
                    n_addr4_72   = trim(SUBSTR(n_addr3_72,r-INDEX(n_addr3_72," "))) + " " + n_addr4_72
                    n_addr3_72  = trim(SUBSTR(n_addr3_72,1,r-INDEX(n_addr3_72," "))).
            END.
            ELSE LEAVE loop_add03.
        END.
    END.

    /* ที่อยู่ผู้ชำระเงิน */
    n_payaddr1  = trim(brstat.tlt.rec_addr1) + " " + trim(brstat.tlt.rec_addr2) .

    DO WHILE INDEX(n_payaddr1,"  ") <> 0 :
        ASSIGN n_payaddr1 = REPLACE(n_payaddr1,"  "," ").
    END.
    IF LENGTH(n_payaddr1) > 35  THEN DO:
        loop_add01:
        DO WHILE LENGTH(n_payaddr1) > 35 :
            IF r-INDEX(n_payaddr1," ") <> 0 THEN DO:
                ASSIGN 
                    n_payaddr2  = trim(SUBSTR(n_payaddr1,r-INDEX(n_payaddr1," "))) + " " + n_payaddr2
                    n_payaddr1 = trim(SUBSTR(n_payaddr1,1,r-INDEX(n_payaddr1," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        loop_add02:
        DO WHILE LENGTH(n_payaddr2) > 35 :
            IF r-INDEX(n_payaddr2," ") <> 0 THEN DO:
                ASSIGN 
                    n_payaddr3   = trim(SUBSTR(n_payaddr2,r-INDEX(n_payaddr2," "))) + " " + n_payaddr3
                    n_payaddr2  = trim(SUBSTR(n_payaddr2,1,r-INDEX(n_payaddr2," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
        loop_add03:
        DO WHILE LENGTH(n_payaddr3) > 35 :
            IF r-INDEX(n_payaddr3," ") <> 0 THEN DO:
                ASSIGN 
                    n_payaddr4   = trim(SUBSTR(n_payaddr3,r-INDEX(n_payaddr3," "))) + " " + n_payaddr4
                    n_payaddr3  = trim(SUBSTR(n_payaddr3,1,r-INDEX(n_payaddr3," "))).
            END.
            ELSE LEAVE loop_add03.
        END.
    END.

     /* อักษรย่อจังหวัด */
    FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
        brstat.insure.compno = "999" AND 
        brstat.insure.FName  = trim(n_province) NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN DO:  
        ASSIGN n_province = Insure.LName.
    END.
    /* add : A65-0115 */
    /* หาสาขาของ STY */
    IF brstat.tlt.ins_addr1 <> ""  THEN DO: 
        IF (brstat.tlt.ins_addr1 <> "ORA") AND (brstat.tlt.ins_addr1 <> "EMP") THEN DO:
            ASSIGN n_hobr = trim(brstat.tlt.ins_addr1) . 
        END.
        ELSE  RUN proc_chkexp. /* ไปเช็คข้อมูลที่ใบเตือน */
    END.
    IF n_hobr = "" THEN DO:
      FIND LAST stat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
             stat.insure.compno = "AYCAL" AND 
             stat.insure.insno  = trim(wdetail.branch)  NO-LOCK NO-WAIT NO-ERROR.
         IF AVAIL stat.insure THEN DO:  
             ASSIGN n_hobr               = stat.Insure.branch.
         END.
    END.
    /* end : a65-0015*/


    /*-- ความคุ้มครอง ----*/
    IF index(n_covtyp,"1") <> 0 THEN n_covcod = "1" .
    ELSE IF index(n_covtyp,"2+") <> 0 THEN DO: 
        IF deci(brstat.tlt.endno) > 0 THEN n_covcod = "2.1" .
        ELSE n_covcod = "2.2" .
    END.
    ELSE IF index(n_covtyp,"3+") <> 0 THEN DO: 
        IF deci(brstat.tlt.endno) > 0 THEN n_covcod = "3.1" .
        ELSE n_covcod = "3.2" .
    END.
    ELSE IF index(n_covtyp,"2") <> 0 THEN n_covcod = "2" .
    ELSE IF index(n_covtyp,"3") <> 0 THEN n_covcod = "3" .
    ELSE IF index(n_covtyp,"CMI") <> 0 THEN n_covcod = "T" .

    IF index(n_garage,"ซ่อมห้าง") <> 0  THEN ASSIGN n_garage = "G".
    ELSE ASSIGN n_garage = "".


    

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkexp C-Win 
PROCEDURE proc_chkexp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by : A65-0115      
------------------------------------------------------------------------------*/

IF NOT CONNECTED("sic_exp") THEN DO:
    loop_conexp:
    REPEAT:
        FORM
            gv_id  LABEL " User Id " colon 35 SKIP
            nv_pwd LABEL " Password" colon 35 BLANK
            WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY width 80
            TITLE   " Connect DB Expiry System"  . 
        
        /*HIDE ALL NO-PAUSE.*//*note block*/
        STATUS INPUT OFF.
        /*
        {s0/s0sf1.i}
        */
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
              CONNECT expiry -H TMSTH -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.         /*HO*/ 
             /*CONNECT expiry -H devserver -S expiry  -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/ /*db test.*/  
             
              CLEAR FRAME nf00.
              HIDE FRAME nf00.
              /*RETURN.*/ 
              IF NOT CONNECTED("sic_exp") THEN NEXT loop_conexp.
              ELSE DO:
                   LEAVE loop_conexp.
                   RETURN.
              END.
           END.
           IF FRAME-FIELD = "gv_id" OR FRAME-FIELD = "nv_pwd" AND LASTKEY = KEYCODE("F4") THEN DO:
                CLEAR FRAME nf00.
                HIDE FRAME nf00.
                LEAVE loop_conexp.
                RETURN.
           END.
        END.
    END.
END.

ASSIGN  n_prepol   = "" 
        n_hobr     = "" 
        n_producer = "" 
        n_dealer   = ""
        n_prepol   = TRIM(SUBSTR(brstat.tlt.imp,R-INDEX(brstat.tlt.imp,"Pol:") + 4)) .
IF n_prepol <> ""  THEN DO:
    FIND LAST sicuw.uwm100 WHERE uwm100.policy = n_prepol NO-LOCK NO-ERROR .
        IF AVAIL sicuw.uwm100 THEN DO:
            IF CONNECTED("sic_exp") THEN 
                RUN wgw/wgwexchkay (INPUT  n_prepol,
                                    OUTPUT n_hobr ,
                                    OUTPUT n_producer,
                                    OUTPUT n_dealer ).
            IF index(n_pmenttyp,"Cash Advance") <> 0 AND index(n_pmentcode2,"Cash Advance") <> 0  THEN ASSIGN n_producer = "B3MLAY0108" .
            ELSE IF TRIM(n_producer) = "B3MLAY0106"  THEN ASSIGN n_producer = "B3MLAY0107" .
            ELSE IF INDEX(n_producer,"B3MLAY") = 0   THEN ASSIGN n_producer = "B3MLAY0101" .

            IF n_hobr = "MF" THEN ASSIGN n_hobr = "ML".
            ELSE IF n_hobr = "M" THEN ASSIGN n_hobr = "ML".
            
        END.
        ELSE DO:
            IF INDEX(n_pmenttyp,"Cash Advance") <> 0  AND index(n_pmentcode2,"Cash Advance") <> 0  THEN ASSIGN n_producer = "B3MLAY0108" .
            ELSE ASSIGN  n_producer = "B3MLAY0107" .
        END.
END.
ELSE DO:
    IF index(n_pmenttyp,"Cash Advance") <> 0  AND  index(n_pmentcode2,"Cash Advance") <> 0  THEN ASSIGN n_producer = "B3MLAY0108" .
    ELSE ASSIGN n_producer = "B3MLAY0107" .
END.

/* end A65-0115 */ 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chklicen C-Win 
PROCEDURE proc_chklicen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_licen AS CHAR FORMAT "x(11)" INIT "" .

IF trim(wload.licence) <> ""  AND trim(wload.licence) <> "ป้ายแดง" THEN DO:
   ASSIGN nv_licen = REPLACE(wload.licence," ","").
   IF INDEX("0123456789",SUBSTR(wload.licence,1,1)) <> 0 THEN DO:
       IF LENGTH(nv_licen) = 4 THEN 
          ASSIGN nv_licen    = SUBSTR(nv_licen,1,1) + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,1).
       ELSE IF LENGTH(nv_licen) = 5 THEN
           ASSIGN nv_licen    = SUBSTR(nv_licen,1,1) + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,2).
       ELSE IF LENGTH(nv_licen) = 6 THEN DO:
           IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
               ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE 
               ASSIGN nv_licen    = SUBSTR(nv_licen,1,1) + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,3). 
       END.
       ELSE 
           ASSIGN nv_licen    = SUBSTR(nv_licen,1,1) + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,4).
    END.
    ELSE DO:
        IF LENGTH(nv_licen) = 3 THEN 
          ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " "  + SUBSTR(nv_licen,3,1) .
        ELSE IF LENGTH(nv_licen) = 4 THEN
           ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,2) .
        ELSE IF LENGTH(nv_licen) = 6 THEN
           ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
        ELSE IF LENGTH(nv_licen) = 5 THEN DO:
            IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,4).
            ELSE 
               ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,3).
        END.
    END.
    ASSIGN wload.licence = nv_licen .
END.
ELSE DO: 
    IF LENGTH(wload.chassis) < 8 THEN ASSIGN wload.licence = "/" + TRIM(wload.chassis) .
    ELSE ASSIGN wload.licence = "/" + SUBSTR(wload.chassis,LENGTH(wload.chassis) - 8,LENGTH(wload.chassis)).
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpol C-Win 
PROCEDURE proc_chkpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Comment by Kridtiya i. A66-0197 backup Producer proc_chkpol เดิม ปรับเพิ่ม ลูปการ ค้นหาเลขกรมธรรม์ใหม่ */
DEF VAR n_count     AS INT .
DEF VAR n_name      AS CHAR .
DEF VAR n_comdat    AS DATE.
DEF VAR n_totalprem AS DECI .
DEF BUFFER bftlt FOR brstat.tlt .
DEF VAR n_chk AS CHAR FORMAT "x(50)" .
DEF VAR nv_acno AS CHAR INIT "" .
DEF VAR n_prem_t  AS DECI.


FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE xmm600.gpstmt = "B3MLAY0100" NO-LOCK.
    ASSIGN nv_acno = nv_acno + ", " + xmm600.acno .
END.
/*ASSIGN nv_acno = nv_acno + ", " + "A0MF29TLT0" + ", " + "B3M4410273" . /* producer code ที่ออกงานเพิ่ม*/*/ /* ranu : A67-0040*/
/* Add by  : A67-0040*/
FOR EACH stat.insure WHERE stat.insure.compno = "AYCL" NO-LOCK.
    ASSIGN nv_acno = nv_acno + ", " + TRIM(stat.insure.fname) .
END.
/* end : A67-0040*/

RUN proc_querypol.

FOR EACH wdetail  .
  IF wdetail.chassis = "BODY" THEN DELETE wdetail .
  ELSE IF wdetail.chassis = ""  THEN DELETE wdetail .
  ELSE DO:
    ASSIGN  n_name      = ""
            n_comdat    = ?
            n_totalprem = 0
            n_prem_t    = 0
            n_comdat = DATE(SUBSTR(TRIM(wdetail.comdat70),5,2) + "/" +
                       SUBSTR(TRIM(wdetail.comdat70),3,2) + "/" +
                       STRING(DECI("25" + SUBSTR(TRIM(wdetail.comdat70),1,2)) - 543)).  /* 27  วันคุ้มครองกธ.  */ 

      /*  ตรวจสอบความถูกต้องของการทำประกัน เงินเบี้ย ทุนประกัน วันคุ้มครอง ถูกต้องตรงก้นหรือไม่     */                
      IF wdetail.chassis <> ""   THEN DO:
          n_count = n_count + 1.
          fi_disp = string(n_count) + " Check Data Chassic no." + wdetail.chassis + "......." .
          DISP fi_disp WITH FRAME fr_main.

          IF wdetail.polno <> "" THEN DO:
           
            FOR EACH   sicuw.uwm100 Use-index uwm10001 Where
                sicuw.uwm100.policy = wdetail.polno NO-LOCK.
                ASSIGN 
                    n_prem_t    = n_prem_t    + sicuw.uwm100.prem_t
                    n_totalprem = n_totalprem + DECI(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t) . 
            END.
            Find LAST sicuw.uwm100 Use-index uwm10001       Where
                sicuw.uwm100.policy = wdetail.polno   AND 
                sicuw.uwm100.poltyp = "V70"                 No-lock no-error no-wait.
            If avail sicuw.uwm100 Then DO:
                n_name      = TRIM(sicuw.uwm100.firstname + " " + sicuw.uwm100.lastname) .
                IF DATE(sicuw.uwm100.comdat) <> date(n_comdat) THEN DO:
                    /*IF DATE(sicuw.uwm100.comdat) <> date(wdetail.polcomdat) THEN DO:*/
                    ASSIGN    wdetail.comment = wdetail.comment + "|วันที่คุ้มครองในไฟล์กับระบบไม่ตรงกัน" .
                END.
                IF n_totalprem <> DECI(wdetail.premtnet) THEN DO:
                    /*IF sicuw.uwm100.prem_t <> deci(wdetail.polnetprm) THEN DO:*/
                    ASSIGN wdetail.comment = wdetail.comment + "|เบี้ยรวมในไฟล์กับในระบบไม่ตรงกัน" .  
                END.
                IF INDEX(nv_acno,sicuw.uwm100.acno1) = 0 THEN DO:
                    ASSIGN wdetail.comment = wdetail.comment + "|กรุณาตรวจสอบ Producer code :" + sicuw.uwm100.acno1. 
                END.
                IF wdetail.comment = ""  THEN DO:
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                        sicuw.uwm301.policy  = sicuw.uwm100.policy NO-LOCK NO-ERROR.
                    IF AVAIL sicuw.uwm301 THEN  DO:
                        IF sicuw.uwm301.vehreg <> "" THEN DO: 
                            IF R-INDEX(sicuw.uwm301.vehreg," ") <> 0 THEN
                                 wdetail.vehreg    = trim(SUBSTR(sicuw.uwm301.vehreg,1,R-INDEX(sicuw.uwm301.vehreg," "))).
                            ELSE wdetail.vehreg    = trim(sicuw.uwm301.vehreg).
                        END.
                    END.
                    FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE
                        sicuw.uwm130.policy  = sicuw.uwm100.policy AND
                        sicuw.uwm130.rencnt  = sicuw.uwm100.rencnt AND
                        sicuw.uwm130.endcnt  = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR.
                    IF AVAIL sicuw.uwm130  THEN DO:
                        IF sicuw.uwm100.polsta = "CA"  THEN ASSIGN   wdetail.comment = wdetail.comment + "|ยกเลิกกรมธรรม์" .
                        ELSE IF sicuw.uwm100.releas = YES THEN DO:
                            ASSIGN wdetail.polno     = sicuw.uwm100.policy 
                                wdetail.polsi        = IF sicuw.uwm130.uom6_v <> 0 THEN string(DECI(sicuw.uwm130.uom6_v),"->>,>>>,>>>,>>9.99") 
                                                       ELSE STRING(DECI(sicuw.uwm130.uom7_v),"->>,>>>,>>>,>>9.99")
                                wdetail.polcomdat    = string(sicuw.uwm100.comdat,"99/99/9999")
                                wdetail.polexpdat    = string(sicuw.uwm100.expdat,"99/99/9999")
                                wdetail.polnetprm    =  string(deci(n_prem_t),"->>,>>>,>>>,>>9.99")      /*string(deci(sicuw.uwm100.prem_t),"->>,>>>,>>>,>>9.99") */
                                wdetail.poltotalprm  =  string(deci(n_totalprem),"->>,>>>,>>>,>>9.99")  .
                        END.
                        ELSE DO:
                            ASSIGN   wdetail.comment = wdetail.comment + "|อยู่ระหว่างดำเนินการ (not release)" .
                        END.
                    END.
                END.
            END.
            ELSE ASSIGN wdetail.comment  = wdetail.comment + "|อยู่ระหว่างการตรวจสอบข้อมูล".
          END.
          ELSE ASSIGN wdetail.comment  = wdetail.comment + "|อยู่ระหว่างการตรวจสอบข้อมูล".
      END.
  END.
END.
RELEASE sicuw.uwm301.
RELEASE sicuw.uwm100.
RELEASE sicuw.uwm130.
  
RUN proc_report_policy.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpol_bk C-Win 
PROCEDURE proc_chkpol_bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  add by : A65-0115     
------------------------------------------------------------------------------*/
DEF VAR n_count     AS INT .
DEF VAR n_name      AS CHAR .
DEF VAR n_comdat    AS DATE.
DEF VAR n_totalprem AS DECI .
DEF BUFFER bftlt FOR brstat.tlt .
DEF VAR n_chk AS CHAR FORMAT "x(50)" .
DEF VAR nv_acno AS CHAR INIT "" .

FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE xmm600.gpstmt = "B3MLAY0100" NO-LOCK.
    ASSIGN nv_acno = nv_acno + ", " + xmm600.acno .
END.
ASSIGN nv_acno = nv_acno + ", " + "A0MF29TLT0" + ", " + "B3M4410273" . /* producer code ที่ออกงานเพิ่ม*/

FOR EACH wdetail  .
  IF wdetail.chassis = "BODY" THEN DELETE wdetail .
  ELSE IF wdetail.chassis = ""  THEN DELETE wdetail .
  ELSE DO:
    ASSIGN  n_name      = ""
            n_comdat    = ?
            n_totalprem = 0
            n_comdat = DATE(SUBSTR(TRIM(wdetail.comdat70),5,2) + "/" +
                       SUBSTR(TRIM(wdetail.comdat70),3,2) + "/" +
                       STRING(DECI("25" + SUBSTR(TRIM(wdetail.comdat70),1,2)) - 543)).  /* 27  วันคุ้มครองกธ.  */ 

      /*  ตรวจสอบความถูกต้องของการทำประกัน เงินเบี้ย ทุนประกัน วันคุ้มครอง ถูกต้องตรงก้นหรือไม่     */                
      IF wdetail.chassis <> ""   THEN DO:
          n_count = n_count + 1.
          fi_disp = string(n_count) + " Check Data Chassic no." + wdetail.chassis + "......." .
          DISP fi_disp WITH FRAME fr_main.

         FIND LAST sicuw.uwm301 Use-index uwm30121 Where 
                   sicuw.uwm301.cha_no = trim(wdetail.chassis) AND 
                   SUBSTR(sicuw.uwm301.policy,3,2) = "70"  No-lock no-error no-wait.
         If avail sicuw.uwm301 Then DO:
               /*ASSIGN wdetail.polno = sicuw.uwm301.policy .*/
               Find LAST sicuw.uwm100 Use-index uwm10001       Where
                   sicuw.uwm100.policy = sicuw.uwm301.policy   and
                   sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                   sicuw.uwm100.endcnt = sicuw.uwm301.endcnt   AND
                   sicuw.uwm100.poltyp = "V70"                 No-lock no-error no-wait.
               If avail sicuw.uwm100 Then DO:
                   
                   n_totalprem = DECI(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t) .
                   n_name      = TRIM(sicuw.uwm100.firstname + " " + sicuw.uwm100.lastname) .
                   /* 
                   IF INDEX(wdetail.name1,n_name) = 0 THEN DO:
                       ASSIGN  wdetail.comment = wdetail.comment + "|ชื่อลูกค้าในไฟล์กับในระบบไม่ตรงกัน" .
                   END.*/

                   IF DATE(sicuw.uwm100.comdat) <> date(n_comdat) THEN DO:
                   /*IF DATE(sicuw.uwm100.comdat) <> date(wdetail.polcomdat) THEN DO:*/
                      ASSIGN    wdetail.comment = wdetail.comment + "|วันที่คุ้มครองในไฟล์กับระบบไม่ตรงกัน" .
                   END.
                   IF n_totalprem <> DECI(wdetail.premtnet) THEN DO:
                   /*IF sicuw.uwm100.prem_t <> deci(wdetail.polnetprm) THEN DO:*/
                       ASSIGN wdetail.comment = wdetail.comment + "|เบี้ยรวมในไฟล์กับในระบบไม่ตรงกัน" .  
                   END.
                   IF INDEX(nv_acno,sicuw.uwm100.acno1) = 0 THEN DO:
                       ASSIGN wdetail.comment = wdetail.comment + "|กรุณาตรวจสอบ Producer code :" + sicuw.uwm100.acno1. 
                   END.
                   IF wdetail.comment = ""  THEN DO:
                       FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE
                                 sicuw.uwm130.policy  = sicuw.uwm100.policy AND
                                 sicuw.uwm130.rencnt  = sicuw.uwm100.rencnt AND
                                 sicuw.uwm130.endcnt  = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR.
                           IF AVAIL sicuw.uwm130  THEN DO:
                               IF sicuw.uwm100.releas = YES THEN DO:
                                   ASSIGN wdetail.polno        = sicuw.uwm100.policy 
                                          wdetail.polsi        = IF sicuw.uwm130.uom6_v <> 0 THEN string(DECI(sicuw.uwm130.uom6_v),"->>,>>>,>>>,>>9.99") 
                                                                 ELSE STRING(DECI(sicuw.uwm130.uom7_v),"->>,>>>,>>>,>>9.99")
                                          wdetail.polcomdat    = string(sicuw.uwm100.comdat,"99/99/9999")
                                          wdetail.polexpdat    = string(sicuw.uwm100.expdat,"99/99/9999")
                                          wdetail.polnetprm    = string(deci(sicuw.uwm100.prem_t),"->>,>>>,>>>,>>9.99")
                                          wdetail.poltotalprm  = string(deci(n_totalprem),"->>,>>>,>>>,>>9.99") .
                               END.
                               ELSE DO:
                                   ASSIGN   wdetail.comment = wdetail.comment + "|อยู่ระหว่างดำเนินการ" .
                               END.
                           END.
                   END.
               END. /* uwm100 */
               ELSE ASSIGN wdetail.comment  = wdetail.comment + "|อยู่ระหว่างการตรวจสอบข้อมูล".
         END.        /*avil 301*/
         ELSE DO:
               FIND LAST sicuw.uwm301 Use-index uwm30103 Where 
                         sicuw.uwm301.trareg = trim(wdetail.chassis) AND 
                         SUBSTR(sicuw.uwm301.policy,3,2) = "70" No-lock no-error no-wait.
                If avail sicuw.uwm301 Then DO:
                    /*ASSIGN wdetail.polno = sicuw.uwm301.policy .*/
                      Find LAST sicuw.uwm100 Use-index uwm10001       Where
                          sicuw.uwm100.policy = sicuw.uwm301.policy   and
                          sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                          sicuw.uwm100.endcnt = sicuw.uwm301.endcnt   AND
                          sicuw.uwm100.poltyp = "V70"                 No-lock no-error no-wait.
                      If avail sicuw.uwm100 Then DO:
                          
                          n_totalprem = DECI(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t) .
                          n_name      = TRIM(sicuw.uwm100.firstname + " " + sicuw.uwm100.lastname) .
                
                          /*IF INDEX(wdetail.name1,n_name) = 0 THEN DO:
                              ASSIGN   wdetail.comment = wdetail.comment + "|ชื่อลูกค้าในไฟล์กับในระบบไม่ตรงกัน" .
                          END.*/

                          IF DATE(sicuw.uwm100.comdat) <> date(n_comdat) THEN DO:
                          /*IF DATE(sicuw.uwm100.comdat) <> date(wdetail.polcomdat) THEN DO:*/
                             ASSIGN    wdetail.comment = wdetail.comment + "|วันที่คุ้มครองในไฟล์กับระบบไม่ตรงกัน" .
                          END.
                          IF n_totalprem <> DECI(wdetail.premtnet) THEN DO:
                          /*IF sicuw.uwm100.prem_t <> deci(wdetail.polnetprm) THEN DO:*/
                              ASSIGN wdetail.comment = wdetail.comment + "|เบี้ยรวมในไฟล์กับในระบบไม่ตรงกัน" .  
                          END.

                          IF INDEX(nv_acno,sicuw.uwm100.acno1) = 0 THEN DO:
                              ASSIGN wdetail.comment = wdetail.comment + "|กรุณาตรวจสอบ Producer code :" + sicuw.uwm100.acno1. 
                          END.

                          IF wdetail.comment = "" THEN DO:
                              FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE
                                        sicuw.uwm130.policy  = sicuw.uwm100.policy AND
                                        sicuw.uwm130.rencnt  = sicuw.uwm100.rencnt AND
                                        sicuw.uwm130.endcnt  = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR.
                                  IF AVAIL sicuw.uwm130  THEN DO:
                                      IF sicuw.uwm100.releas = YES THEN DO:
                                          ASSIGN wdetail.polno        = sicuw.uwm100.policy 
                                                 wdetail.polsi        = IF sicuw.uwm130.uom6_v <> 0 THEN string(DECI(sicuw.uwm130.uom6_v),"->>,>>>,>>>,>>9.99") 
                                                                        ELSE STRING(DECI(sicuw.uwm130.uom7_v),"->>,>>>,>>>,>>9.99")
                                                 wdetail.polcomdat    = string(sicuw.uwm100.comdat,"99/99/9999")
                                                 wdetail.polexpdat    = string(sicuw.uwm100.expdat,"99/99/9999")
                                                 wdetail.polnetprm    = string(deci(sicuw.uwm100.prem_t),"->>,>>>,>>>,>>9.99")
                                                 wdetail.poltotalprm  = string(deci(n_totalprem),"->>,>>>,>>>,>>9.99") .
                                      END.
                                      ELSE DO:
                                          ASSIGN   wdetail.comment = wdetail.comment + "|อยู่ระหว่างดำเนินการ" .
                                      END.
                                  END.
                          END.
                      END. /* uwm100 */
                      ELSE ASSIGN wdetail.comment  = wdetail.comment + "|อยู่ระหว่างการตรวจสอบข้อมูล".
                END.        /*avil 301*/
                ELSE ASSIGN wdetail.comment  = wdetail.comment + "|อยู่ระหว่างการตรวจสอบข้อมูล". 
         END.
         RELEASE sicuw.uwm301.
         RELEASE sicuw.uwm100.
         RELEASE sicuw.uwm130.
      END.
  END.
END.
RUN proc_report_policy.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cleardata C-Win 
PROCEDURE proc_cleardata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN n_cmr_code         = ""         
       n_comp_code        = ""         
       n_campcode         = ""         
       n_campname         = ""         
       n_procode          = ""         
       n_proname          = ""         
       n_packname         = ""         
       n_packcode         = "" 
       n_prepol           = ""
       n_instype          = ""         
       n_pol_title        = ""         
       n_pol_fname        = ""         
       n_pol_lname        = ""         
       n_pol_title_eng    = ""         
       n_pol_fname_eng    = ""         
       n_pol_lname_eng    = ""         
       n_icno             = ""         
       n_sex              = ""         
       n_bdate            = ""         
       n_occup            = ""         
       n_tel              = ""         
       n_phone            = ""         
       n_teloffic         = ""         
       n_telext           = ""         
       n_moblie           = ""         
       n_mobliech         = ""         
       n_mail             = ""         
       n_lineid           = ""         
       n_addr1_70         = ""         
       n_addr2_70         = ""         
       n_addr3_70         = ""         
       n_addr4_70         = ""         
       n_addr5_70         = ""         
       n_nsub_dist70      = ""         
       n_ndirection70     = ""         
       n_nprovin70        = ""         
       n_zipcode70        = ""         
       n_addr1_72         = ""         
       n_addr2_72         = ""         
       n_addr3_72         = ""         
       n_addr4_72         = ""         
       n_addr5_72         = ""         
       n_nsub_dist72      = ""         
       n_ndirection72     = ""         
       n_nprovin72        = ""         
       n_zipcode72        = ""         
       n_paytype          = ""         
       n_paytitle         = ""         
       n_payname          = ""         
       n_paylname         = ""         
       n_payicno          = ""         
       n_payaddr1         = ""         
       n_payaddr2         = ""         
       n_payaddr3         = ""         
       n_payaddr4         = ""         
       n_payaddr5         = ""         
       n_payaddr6         = ""         
       n_payaddr7         = ""         
       n_payaddr8         = ""         
       n_payaddr9         = ""         
       n_branch           = ""         
       n_ben_title        = ""         
       n_ben_name         = ""         
       n_ben_lname        = ""         
       n_pmentcode        = ""         
       n_pmenttyp         = ""         
       n_pmentcode1       = ""         
       n_pmentcode2       = ""         
       n_pmentbank        = ""         
       n_pmentdate        = ""         
       n_pmentsts         = ""         
       n_driver           = ""         
       n_drivetitle1      = ""         
       n_drivename1       = ""         
       n_drivelname1      = ""         
       n_driveno1         = ""         
       n_occupdriv1       = ""         
       n_sexdriv1         = ""         
       n_bdatedriv1       = ""         
       n_drivetitle2      = ""         
       n_drivename2       = ""         
       n_drivelname2      = ""         
       n_driveno2         = ""         
       n_occupdriv2       = ""         
       n_sexdriv2         = ""         
       n_bdatedriv2       = ""         
       n_brand            = ""         
       n_brand_cd         = ""         
       n_Model            = ""         
       n_Model_cd         = ""         
       n_body             = ""         
       n_body_cd          = ""         
       n_licence          = ""         
       n_province         = ""         
       n_chassis          = ""         
       n_engine           = ""         
       n_yrmanu           = ""         
       n_seatenew         = ""         
       n_power            = ""         
       n_weight           = ""         
       n_class            = ""         
       n_garage_cd        = ""         
       n_garage           = ""         
       n_colorcode        = ""         
       n_covcod           = ""         
       n_covtyp           = ""         
       n_covtyp1          = ""         
       n_covtyp2          = ""         
       n_covtyp3          = ""         
       n_comdat           = ""         
       n_expdat           = ""         
       n_ins_amt          = ""         
       n_prem1            = ""         
       n_gross_prm        = ""         
       n_stamp            = ""         
       n_vat              = ""         
       n_premtotal        = ""         
       n_deduct           = ""         
       n_fleetper         = ""         
       n_fleet            = ""         
       n_ncbper           = ""         
       n_ncb              = ""         
       n_drivper          = ""         
       n_drivdis          = ""         
       n_othper           = ""         
       n_oth              = ""         
       n_cctvper          = ""         
       n_cctv             = ""         
       n_Surcharper       = ""         
       n_Surchar          = ""         
       n_Surchardetail    = ""         
       n_acc1             = ""         
       n_accdetail1       = ""         
       n_accprice1        = ""         
       n_acc2             = ""         
       n_accdetail2       = ""         
       n_accprice2        = ""         
       n_acc3             = ""         
       n_accdetail3       = ""         
       n_accprice3        = ""         
       n_acc4             = ""         
       n_accdetail4       = ""         
       n_accprice4        = ""         
       n_acc5             = ""         
       n_accdetail5       = ""         
       n_accprice5        = ""         
       n_inspdate         = ""         
       n_inspdate_app     = ""         
       n_inspsts          = ""         
       n_inspdetail       = ""         
       n_not_date         = ""         
       n_paydate          = ""         
       n_paysts           = ""         
       n_licenBroker      = ""         
       n_brokname         = ""         
       n_brokcode         = ""         
       n_lang             = ""         
       n_deli             = ""         
       n_delidetail       = ""         
       n_gift             = ""         
       n_cedcode          = ""         
       n_inscode          = ""         
       n_remark           = "" 
       n_poltyp           = ""
       n_insno            = ""
       n_resultins        = "" 
       n_damage1          = ""
       n_damage2          = ""
       n_damage3          = ""
       n_dataoth          = "" 
       n_policy           = "" 
       n_char             = ""
       n_fi               = "" 
       n_dealer           = ""  /*A65-0115*/
       n_hobr             = ""  /*A65-0115*/
       n_producer         = ""  /*A65-0115*/ 
      /* add by : A67-0162 */
       n_tyeeng         = "" 
       n_typMC          = "" 
       n_watt           = "" 
       n_evmotor1       = "" 
       n_evmotor2       = "" 
       n_evmotor3       = "" 
       n_evmotor4       = "" 
       n_evmotor5       = "" 
       n_carprice       = "" 
       n_drivlicen1     = "" 
       n_drivcardexp1   = "" 
       n_drivlicen2     = "" 
       n_drivcardexp2   = "" 
       n_drivetitle3    = "" 
       n_drivename3     = "" 
       n_drivelname3    = "" 
       n_bdatedriv3     = "" 
       n_sexdriv3       = "" 
       n_driveno3       = "" 
       n_drivlicen3     = "" 
       n_drivcardexp3   = "" 
       n_occupdriv3     = "" 
       n_drivetitle4    = "" 
       n_drivename4     = "" 
       n_drivelname4    = "" 
       n_bdatedriv4     = "" 
       n_sexdriv4       = "" 
       n_driveno4       = "" 
       n_drivlicen4     = "" 
       n_drivcardexp4   = "" 
       n_occupdriv4     = "" 
       n_drivetitle5    = "" 
       n_drivename5     = "" 
       n_drivelname5    = "" 
       n_bdatedriv5     = "" 
       n_sexdriv5       = "" 
       n_driveno5       = "" 
       n_drivlicen5     = "" 
       n_drivcardexp5   = "" 
       n_occupdriv5     = "" 
       n_battflag       = "" 
       n_battyr         = "" 
       n_battdate       = "" 
       n_battprice      = "" 
       n_battno         = "" 
       n_battsi         = "" 
       n_chagreno       = "" 
       n_chagrebrand    = "" .
   /* end : A67-0162 */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create C-Win 
PROCEDURE proc_create :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF index(n_covtyp,"Insur") <> 0 OR INDEX(n_covtyp,"ประกันภัย") <> 0 THEN NEXT.
ELSE DO:
    FIND FIRST wload WHERE wload.covtyp   = trim(n_covtyp)   AND
                           wload.cedcode  = trim(n_cedcode)  AND
                           wload.inscode  = trim(n_inscode)  NO-LOCK NO-ERROR.
    IF NOT AVAIL wload THEN DO:
        RUN proc_chkaddr.
        CREATE wload.
        ASSIGN 
            wload.poltyp         = IF trim(n_covtyp) = "CMI" THEN "V72" ELSE "V70"
            wload.cedcode        = trim(n_cedcode)    
            wload.inscode        = trim(n_inscode)    
            wload.campcode       = trim(n_procode)
            wload.campname       = trim(n_proname)
            wload.procode        = trim(n_campcode)    
            wload.proname        = trim(n_campname)    
            wload.packname       = trim(n_packname)
            wload.packcode       = trim(n_packcode)
            wload.instype        = trim(n_instype)
            wload.pol_title      = trim(n_pol_title)
            wload.pol_fname      = trim(n_pol_fname) + " " + TRIM(n_pol_lname) 
            wload.pol_title_eng  = trim(n_pol_title_eng)
            wload.pol_fname_eng  = trim(n_pol_fname_eng) + " " + trim(n_pol_lname_eng)
            wload.icno           = trim(n_icno)
            wload.bdate          = IF trim(n_bdate) <> "" THEN STRING(DATE(n_bdate),"99/99/9999") ELSE ""
            wload.occup          = trim(n_occup)
            wload.tel            = trim(n_tel) + "," + trim(n_moblie) + "," + trim(n_mobliech)
            wload.mail           = trim(n_mail)
            wload.addrpol1       = trim(n_addr1_70) + " " +
                                   trim(n_addr2_70) + " " +
                                   trim(n_addr3_70)
            wload.addrpol2       = trim(n_addr4_70) + " " + trim(n_addr5_70) 
            wload.addrpol3       = trim(n_nsub_dist70) + " " + trim(n_ndirection70)
            wload.addrpol4       = trim(n_nprovin70) + " " + trim(n_zipcode70)
            wload.addrsend1      = trim(n_addr1_72) + " " +
                                   trim(n_addr2_72) + " " + 
                                   trim(n_addr3_72)
            wload.addrsend2      = trim(n_addr4_72) + " " + trim(n_addr5_72)
            wload.addrsend3      = trim(n_nsub_dist72) + " " + trim(n_ndirection72)
            wload.addrsend4      = trim(n_nprovin72) + " " + trim(n_zipcode72)
            wload.paytype        = trim(n_paytype)
            wload.paytitle       = trim(n_paytitle)
            wload.payname        = trim(n_payname) + " " + trim(n_paylname)
            wload.icpay          = trim(n_payicno)
            wload.addrpay1       = trim(n_payaddr1) + " " +
                                   TRIM(n_payaddr2) + " " + 
                                   TRIM(n_payaddr3)
            wload.addrpay2       = trim(n_payaddr4) + " "  + TRIM(n_payaddr5)
            wload.addrpay3       = trim(n_payaddr6) + " "  + TRIM(n_payaddr7)
            wload.addrpay4       = trim(n_payaddr8) + " "  + TRIM(n_payaddr9)
            wload.branch         = trim(n_branch)
            wload.ben_name       = trim(n_ben_title) + trim(n_ben_name) + " " + trim(n_ben_lname)
            wload.pmentcode      = trim(n_pmentcode)
            wload.pmenttyp       = trim(n_pmenttyp)
            wload.pmentcode1     = trim(n_pmentcode1)
            wload.pmentcode2     = trim(n_pmentcode2)
            wload.pmentbank      = trim(n_pmentbank)
            wload.pmentdate      = IF trim(n_pmentdate) <> "" THEN STRING(DATE(n_pmentdate),"99/99/9999") ELSE ""
            wload.pmentsts       = trim(n_pmentsts)
            wload.brand          = trim(n_brand)
            wload.Model          = trim(n_Model)
            wload.body           = trim(n_body)
            wload.licence        = trim(n_licence)
            wload.province       = trim(n_province)
            wload.chassis        = CAPS(trim(n_chassis))
            wload.engine         = CAPS(trim(n_engine))
            wload.yrmanu         = trim(n_yrmanu)
            wload.seatenew       = trim(n_seatenew)
            wload.power          = trim(n_power)
            wload.weight         = trim(n_weight)
            wload.class          = trim(n_class)
            wload.garage         = trim(n_garage)
            wload.colorcode      = trim(n_colorcode)
            wload.covcod         = trim(n_covcod)
            wload.covtyp         = trim(n_covtyp)
            wload.comdat         = trim(n_comdat)
            wload.expdat         = trim(n_expdat)
            wload.ins_amt        = trim(n_ins_amt)
            wload.prem1          = trim(n_prem1)
            wload.gross_prm      = trim(n_gross_prm)
            wload.stamp          = trim(n_stamp)
            wload.vat            = trim(n_vat)
            wload.premtotal      = trim(n_premtotal)
            wload.deduct         = trim(n_deduct)
            wload.fleetper       = IF INDEX(n_fleetper,"%") <> 0 THEN REPLACE(n_fleetper,"%","") ELSE trim(n_fleetper)      
            wload.ncbper         = IF INDEX(n_ncbper,"%") <> 0 THEN REPLACE(n_ncbper,"%","") ELSE trim(n_ncbper)  
            wload.othper         = IF INDEX(n_othper,"%") <> 0 THEN REPLACE(n_othper,"%","") ELSE trim(n_othper)            
            wload.cctvper        = IF INDEX(n_cctvper,"%") <> 0 THEN REPLACE(n_cctvper,"%","") ELSE trim(n_cctvper)
            wload.driver         = trim(n_driver)
            wload.drivename1     = trim(n_drivetitle1) + trim(n_drivename1) + " " + trim(n_drivelname1)
            wload.driveno1       = trim(n_driveno1)
            wload.occupdriv1     = trim(n_occupdriv1)
            wload.sexdriv1       = trim(n_sexdriv1)
            wload.bdatedriv1     = IF trim(n_bdatedriv1) <> "" THEN STRING(DATE(n_bdatedriv1),"99/99/9999") ELSE ""
            wload.drivename2     = trim(n_drivetitle2) + trim(n_drivename2) + " " + trim(n_drivelname2)
            wload.driveno2       = trim(n_driveno2)
            wload.occupdriv2     = trim(n_occupdriv2)
            wload.sexdriv2       = trim(n_sexdriv2)
            wload.bdatedriv2     = IF trim(n_bdatedriv2) <> "" THEN string(DATE(n_bdatedriv2),"99/99/9999") ELSE "" .
        CREATE wtxt.
        ASSIGN 
            wtxt.poltyp        = IF trim(n_covtyp) = "CMI" THEN "V72" ELSE "V70"
            wtxt.cedcode       = trim(n_cedcode)    
            wtxt.inscode       = trim(n_inscode)    
            wtxt.acc1          = trim(n_acc1)                                                                             
            wtxt.accdetail1    = trim(n_accdetail1)                                                                       
            wtxt.accprice1     = trim(n_accprice1)                                                                        
            wtxt.acc2          = trim(n_acc2)                                                                             
            wtxt.accdetail2    = trim(n_accdetail2)                                                                       
            wtxt.accprice2     = trim(n_accprice2)                                                                        
            wtxt.acc3          = trim(n_acc3)                                                                             
            wtxt.accdetail3    = trim(n_accdetail3)                                                                       
            wtxt.accprice3     = trim(n_accprice3)                                                                        
            wtxt.acc4          = trim(n_acc4)                                                                             
            wtxt.accdetail4    = trim(n_accdetail4)                                                                       
            wtxt.accprice4     = trim(n_accprice4)                                                                        
            wtxt.acc5          = trim(n_acc5)                                                                             
            wtxt.accdetail5    = trim(n_accdetail5)                                                                       
            wtxt.accprice5     = trim(n_accprice5)                                                                        
            wtxt.inspdate      = if trim(n_inspdate) <> "" THEN STRING(DATE(n_inspdate),"99/99/9999") ELSE ""                                                        
            wtxt.inspdate_app  = if trim(n_inspdate_app) <> "" THEN STRING(DATE(n_inspdate_app),"99/99/9999") ELSE ""                                                
            wtxt.inspsts       = trim(n_inspsts)                                                                          
            wtxt.inspdetail    = trim(n_inspdetail)                                                                       
            wtxt.not_date      = if trim(n_not_date) <> "" then string(DATE(n_not_date),"99/99/9999") else ""                                                    
            wtxt.paydate       = if trim(n_paydate) <> "" then string(DATE(n_paydate),"99/99/9999")  else ""                                                    
            wtxt.paysts        = trim(n_paysts)                                                                           
            wtxt.licenBroker   = trim(n_licenBroker)
            wtxt.brokname      = trim(n_brokname)   
            wtxt.brokcode      = trim(n_brokcode)   
            wtxt.lang          = trim(n_lang)       
            wtxt.deli          = trim(n_deli)       
            wtxt.delidetail    = trim(n_delidetail) 
            wtxt.gift          = trim(n_gift)       
            wtxt.remark        = trim(n_remark)
            wtxt.policy        = TRIM(n_policy) .
    END.
    
END.     */                                 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpolicy C-Win 
PROCEDURE proc_cutpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT .
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
ASSIGN 
    nv_c = trim(wload.policy)
    nv_i = 0
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
    ind = INDEX(nv_c,"_").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,".").
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
    wload.policy  = nv_c . 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_detailpolicy C-Win 
PROCEDURE proc_detailpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wload NO-LOCK.
    FIND LAST wtxt WHERE wtxt.poltyp  = wload.poltyp  AND
                         wtxt.cedcode = wload.cedcode AND
                         wtxt.inscode = wload.inscode NO-LOCK NO-ERROR .
    nv_row  =  nv_row + 1.
    EXPORT DELIMITER "|"                            
        wload.poltyp                                /* ประเภทกรมธรรม์*/ 
        wtxt.policy    /* A65-0115*/               /* policy AY */
        wtxt.not_date  /* A65-0115*/                /* วันที่ขาย*/                    
        wtxt.paydate   /* A65-0115*/                /* วันที่รับชำระเงิน*/  
        wload.policy                                /* policy no. */
        wtxt.producer      /*A65-0115*/          
        wtxt.agent         /*A65-0115*/ 
        wtxt.dealer        /*A65-0115*/ 
        wload.cedcode                               /* รหัสอ้างอิง   */               
        wload.inscode                               /* รหัสลูกค้า    */               
        wload.campcode                              /* รหัสแคมเปญ    */               
        wload.campname                              /* ชื่อแคมเปญ    */               
        /*wload.procode  */                             /* รหัสผลิตภัณฑ์ */               
        wload.proname                               /* ชื่อผลิตภัณฑ์ */               
        /*wload.packname */                             /* ชื่อแพคเก็จ   */               
        wload.packcode                              /* รหัสแพคเก็จ   */
        wload.prepol                                /* กธ.เดิม */
       /* wload.instype */                              /* ประเภทผู้เอาประกัน */          
        wload.pol_title                             /* คำนำหน้าชื่อ ผู้เอาประกัน */   
        wload.pol_fname                             /* ชื่อ ผู้เอาประกัน         */   
       /* wload.pol_title_eng                         /* คำนำหน้าชื่อ ผู้เอาประกัน */   
        wload.pol_fname_eng                         /* ชื่อ ผู้เอาประกัน*/ */           
        wload.icno                                  /* เลขบัตรผู้เอาประกัน */         
        wload.bdate                                 /* วันเกิดผู้เอาประกัน */         
        /*wload.occup                                 /* อาชีพผู้เอาประกัน*/ */           
        IF index(wload.tel,",,") <> 0 THEN REPLACE(wload.tel,",,","") ELSE TRIM(wload.tel)  /* เบอร์โทรผู้เอาประกัน*/         
        /*wload.mail                                  /* อีเมล์ผู้เอาประกัน  */         
        wload.addrpol1                              /* ที่อยู่หน้าตาราง1*/            
        wload.addrpol2                              /* ที่อยู่หน้าตาราง2*/            
        wload.addrpol3                              /* ที่อยู่หน้าตาราง3*/            
        wload.addrpol4 */                             /* ที่อยู่หน้าตาราง4*/            
        wload.addrsend1                             /* ที่อยู่จัดส่ง 1  */            
        wload.addrsend2                             /* ที่อยู่จัดส่ง 2  */            
        wload.addrsend3                             /* ที่อยู่จัดส่ง 3  */            
        wload.addrsend4                             /* ที่อยู่จัดส่ง 4  */            
        /*wload.paytype*/                               /* ประเภทผู้จ่ายเงิน*/            
        wload.paytitle                              /* คำนำหน้าชื่อ ผู้จ่ายเงิน*/     
        wload.payname                               /* ชื่อ ผู้จ่ายเงิน*/   
        wload.icpay                                 /* เลขประจำตัวผู้เสียภาษี*/    
        wload.addrPay1                              /* ที่อยู่ออกใบเสร็จ1*/        
        wload.addrPay2                              /* ที่อยู่ออกใบเสร็จ2*/        
        wload.addrPay3                              /* ที่อยู่ออกใบเสร็จ3*/        
        wload.addrPay4                              /* ที่อยู่ออกใบเสร็จ4*/        
        /*wload.branch */                               /* สาขา*/                         
        wload.ben_name                              /* ผู้รับผลประโยชน์  */           
       /* wload.pmentcode   */                          /* รหัสประเภทการจ่าย */           
        wload.pmenttyp                              /* ประเภทการจ่าย */               
        /*wload.pmentcode1 */                           /* รหัสช่องทางการจ่าย*/           
        wload.pmentcode2                            /* ช่องทางการจ่าย  */             
       /* wload.pmentbank                             /* ธนาคารที่จ่าย*/                
        wload.pmentdate                             /* วันที่จ่าย   */                
        wload.pmentsts */                             /* สถานะการจ่าย */                
        wload.brand                                 /* ยี่ห้อ  */                     
        wload.Model                                 /* รุ่น    */                     
        wload.body                                  /* แบบตัวถัง*/                    
        wload.licence                               /* ทะเบียน */                     
        wload.province                              /* จังหวัดทะเบียน */              
        wload.chassis                               /* เลขตัวถัง*/                    
        wload.engine                                /* เลขเครื่อง */                  
        wload.yrmanu                                /* ปีรถ    */                     
       /* wload.seatenew    */                          /* ที่นั่ง */                     
        wload.power                                 /* ซีซี    */                     
        /*wload.weight    */                            /* น้ำหนัก */                     
        wload.class                                 /* คลาสรถ  */                     
        wload.garage                                /* การซ่อม */                     
        /*wload.colorcode */                            /* สี  */                         
        wload.covcod                                /* ประเภทการประกัน */             
        wload.covtyp                                /* รหัสการประกัน*/                
        wload.comdat                                /* วันที่คุ้มครอง  */             
        wload.expdat                                /* วันที่หมดอายุ*/                
        wload.ins_amt                               /* ทุนประกัน*/ 
        wload.fi                                    /* ทุนสูญหาย/ไฟไหม้ */
        wload.prem1                                 /* เบี้ยสุทธิก่อนหักส่วนลด*/      
        wload.gross_prm                             /* เบี้ยสุทธิหลังหักส่วนลด*/      
        wload.stamp                                 /* สแตมป์  */                     
        wload.vat                                   /* ภาษี    */                     
        wload.premtotal                             /* เบี้ยรวม*/                     
        wload.deduct                                /* Deduct  */                     
        wload.fleetper                              /* fleet   */                     
        wload.ncbper                                /* ncb     */ 
        wload.othper                                /* other   */                     
        wload.cctvper                               /* cctv    */ 
        wload.driver                                /* ระบุผู้ขับขี่    */            
        wload.drivename1                            /* ชื่อผู้ขับขี่1   */    
        wload.driveno1                              /* เลขบัตรผู้ขับขี่1*/            
        wload.occupdriv1                            /* อาชีพผู้ขับขี่1  */            
        wload.sexdriv1                              /* เพศผู้ขับขี่1    */            
        IF wload.bdatedriv1 <> ? THEN STRING(DATE(wload.bdatedriv1),"99/99/9999") ELSE "" /* วันเกิดผู้ขับขี่1*/            
        wload.drivename2                            /* ชื่อผู้ขับขี่2   */                 
        wload.driveno2                              /* เลขบัตรผู้ขับขี่2*/          
        wload.occupdriv2                            /* อาชีพผู้ขับขี่2  */            
        wload.sexdriv2                              /* เพศผู้ขับขี่2    */            
        IF wload.bdatedriv2 <> ? THEN STRING(DATE(wload.bdatedriv2),"99/99/9999") ELSE "" /* วันเกิดผู้ขับขี่2*/  
        wtxt.accdetail1                             /* รายละเอียดอุปกรณ์1*/           
        wtxt.accprice1                              /* ราคาอุปกรณ์1  */               
        wtxt.accdetail2                             /* รายละเอียดอุปกรณ์2*/           
        wtxt.accprice2                              /* ราคาอุปกรณ์2  */                 
        wtxt.accdetail3                             /* รายละเอียดอุปกรณ์3*/           
        wtxt.accprice3                              /* ราคาอุปกรณ์3  */                
        wtxt.accdetail4                             /* รายละเอียดอุปกรณ์4*/           
        wtxt.accprice4                              /* ราคาอุปกรณ์4  */              
        wtxt.accdetail5                             /* รายละเอียดอุปกรณ์5*/           
        wtxt.accprice5                              /* ราคาอุปกรณ์5  */               
        IF wtxt.inspdate <> ? THEN string(date(wtxt.inspdate),"99/99/9999") ELSE ""   /* วันที่ตรวจสภาพ*/    
        wtxt.brokname                               /* ชื่อนายหน้า */ 
        wtxt.licenBroker                            /* เลขที่ใบอนุญาตนายหน้า*/ 
        wtxt.brokcode                               /* รหัสนายหน้า */
        wtxt.inspdetail                             /* รายละเอียดการตรวจสภาพ*/
       /* wtxt.not_date */ /*A65-0115*/              /* วันที่ขาย*/                    
       /* wtxt.paydate  */ /*A65-0115*/              /* วันที่รับชำระเงิน*/            
        /*wtxt.paysts      */                           /* สถานะการจ่าย*/  
       /* wtxt.lang                                   /* ภาษา        */                 
        wtxt.deli    */                               /* การจัดส่งกรมธรรม์   */         
        wtxt.delidetail                             /* รายละเอียดการจัดส่ง */         
        wtxt.gift                                   /* ของแถม  */                     
        wtxt.remark                                 /* หมายเหตุ*/
        wtxt.insno                                   /* เลขตรวจสภาพ */  
        wtxt.resultins                               /* ผลการตรวจ */    
        wtxt.damage1                                 /* ความเสียหาย1 */ 
        wtxt.damage2                                 /* ความเสียหาย2 */ 
        wtxt.damage3                                 /* ความเสียหาย3 */ 
        wtxt.dataoth                                 /* ข้อมูลอื่นๆ */ 
       /* wtxt.policy   */     /*A65-0115*/          /* policy AY */
       /* wtxt.producer */     /*A65-0115*/          
       /* wtxt.agent    */     /*A65-0115*/          
        wtxt.hobr  .                                 
                
END.                                                      

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_detailreport C-Win 
PROCEDURE proc_detailreport :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_comdat AS DATE.
DEF BUFFER bftlt FOR brstat.tlt .
DEF VAR n_chk AS CHAR FORMAT "x(50)" .
FOR EACH wdetail  .
  IF wdetail.chassis = "BODY" THEN DELETE wdetail .
  ELSE IF wdetail.chassis = ""  THEN DELETE wdetail .
  ELSE DO:
    ASSIGN  n_record = 0
            n_comdat = DATE(SUBSTR(TRIM(wdetail.comdat70),5,2) + "/" +
                       SUBSTR(TRIM(wdetail.comdat70),3,2) + "/" +
                       STRING(DECI("25" + SUBSTR(TRIM(wdetail.comdat70),1,2)) - 543)).  /* 27  วันคุ้มครองกธ.  */ 
    FOR EACH brstat.tlt   USE-INDEX tlt06 WHERE
        brstat.tlt.cha_no     = TRIM(wdetail.chassis)  AND 
        brstat.tlt.eng_no     = TRIM(wdetail.engno)    AND
        brstat.tlt.flag       <> "INSPEC"              AND 
        brstat.tlt.genusr     = "AYCAL"                NO-LOCK  . 
        IF index(brstat.tlt.releas,"CA") <> 0  THEN ASSIGN wdetail.remark = wdetail.remark + " |" + " ยกเลิกข้อมูลแล้ว ".
        IF INDEX(brstat.tlt.releas,"Yes") <> 0 THEN ASSIGN wdetail.remark = wdetail.remark + " |" + " ออกงานแล้ว " + tlt.policy .
        ELSE DO:
            IF tlt.flag <> "V70" AND  tlt.flag <> "V72" THEN DO: /* ข้อมูลไฟล์แจ้งงานแบบเก่า */
                IF tlt.nor_effdat <> n_comdat THEN DO: 
                    ASSIGN wdetail.remark = wdetail.remark + " |" + "วันที่เริ่มคุ้มครองในไฟล์ " + 
                        STRING(n_comdat,"99/99/9999") + " ไม่เท่ากับในระบบ " + STRING(tlt.nor_effdat,"99/99/9999") .
                    NEXT.
                END.
                ELSE DO:
                    n_record  =  n_record  + 1.
                    RUN proc_reportmat_old.
                END.
            END.
            ELSE IF tlt.flag = "V70" OR tlt.flag = "V72" THEN DO:  /*ข้อมูลไฟล์แจ้งงานใหม่ */
                IF tlt.gendat <> n_comdat  THEN DO: 
                    ASSIGN wdetail.remark =  "วันที่เริ่มคุ้มครองในไฟล์ " + STRING(n_comdat,"99/99/9999") + 
                        " ไม่เท่ากับในระบบ " + STRING(tlt.gendat,"99/99/9999").
                    NEXT.
                END.
                RUN proc_cleardata.
                RUN proc_adddata . 
                RUN proc_chkaddr. 
                /* วันที่ชำระเงิน */
                ASSIGN n_paydate = ""
                    n_paydate =  SUBSTR(wdetail.recivedat,5,2) + "/" +  
                    SUBSTR(wdetail.recivedat,3,2) + "/" +  
                    "25" + SUBSTR(wdetail.recivedat,1,2).  
                n_ben_name = "" .
                n_ben_name = brstat.tlt.safe1 .
                IF INDEX(n_ben_name,"บมจ.") <> 0 AND INDEX(n_ben_name,"บริษัท") <> 0 THEN DO:
                    n_ben_name = REPLACE(n_ben_name,"บริษัท","") .
                    IF INDEX(n_ben_name,"  ") <> 0 THEN n_ben_name  = TRIM(REPLACE(n_ben_name,"  "," ")).
                END.
                IF INDEX(n_ben_name,"บมจ.") <> 0 AND INDEX(n_ben_name,"ธนาคาร") <> 0 THEN DO:
                    n_ben_name = trim(REPLACE(n_ben_name,"บมจ.","")) .
                END.
                FIND LAST bftlt WHERE 
                    bftlt.cha_no       = tlt.cha_no   AND             /* เลขถัง */         
                    bftlt.eng_no       = tlt.eng_no   AND             /* เลขเครื่อง */     
                    bftlt.nor_noti_ins = tlt.nor_noti_ins  and        /* เลขที่อ้างอิง*/   
                    bftlt.nor_usr_ins  = tlt.nor_usr_ins   and        /* เลขที่ลูกค้า */   
                    bftlt.flag         = tlt.flag   AND               /* ประเภท 70 ,72 */ 
                    bftlt.genusr       = tlt.genusr     NO-ERROR NO-WAIT  . 
                IF AVAIL bftlt THEN DO:
                    ASSIGN brstat.tlt.dat_ins_noti  = DATE(n_paydate) 
                        brstat.tlt.colorcod      = "CON:" + trim(wdetail.Contract) + " " +
                                                   "BR:" + TRIM(wdetail.branch).
                    /* Add :  A65-0115 */
                    IF brstat.tlt.ins_addr1 <> "ORA" AND brstat.tlt.ins_addr1 <> "EMP" THEN DO:
                        brstat.tlt.ins_addr1      = TRIM(n_hobr).  /* A65-0115 */
                    END.
                    ELSE DO:
                        ASSIGN 
                        brstat.tlt.ins_addr1 = TRIM(n_hobr)
                        brstat.tlt.subins    = TRIM(n_producer)
                        brstat.tlt.dealer    = TRIM(n_dealer)    .
                    END.
                    /* end A65-0115*/
                    /* producer code  */
                    /*brstat.tlt.subins     = IF      INDEX(fi_loadname,"Plus")   <> 0 THEN "A0M0062"
                                           ELSE IF INDEX(fi_loadname,"MC_KPI") <> 0 THEN "A0M0073"  
                                           ELSE "A0M0018".*/   /*A63-00472*/
                    /* comment by : a65-0115 ..
                    brstat.tlt.subins    =  IF INDEX(fi_loadname,"Plus")   <> 0 THEN "A0M0062"
                                           ELSE IF INDEX(fi_loadname,"MC_KPI") <> 0 THEN "B3MLAY0105"
                                           ELSE "B3MLAY0101".
                    ...end : A65-0115...*/
                END.
                RELEASE bftlt.
                ASSIGN  n_chk = "" .
                IF brstat.tlt.comp_coamt <> deci(wdetail.premtnet) THEN DO:
                    ASSIGN  wdetail.remark = ""
                        wdetail.remark = wdetail.remark + " |" + "เบี้ย " + wdetail.premtnet + " ไม่เท่าในระบบ " + STRING(brstat.tlt.comp_coamt) 
                        n_chk  = "เบี้ย " + wdetail.premtnet + " ไม่เท่าในระบบ " + STRING(brstat.tlt.comp_coamt) .
                END.
                FIND FIRST wload WHERE wload.covtyp   = trim(brstat.tlt.flag)   AND
                    wload.cedcode  = trim(brstat.tlt.nor_noti_ins)  AND
                    wload.inscode  = trim(brstat.tlt.nor_usr_ins )  NO-LOCK NO-ERROR.
                IF NOT AVAIL wload THEN DO:
                    RUN proc_assigndata.
                    /*CREATE  wload .
                    ASSIGN 
                        wload.poltyp     = brstat.tlt.flag  
                        wload.bray       = TRIM(wdetail.branch)
                        wload.contract   = TRIM(wdetail.contract)
                        wload.cedcode    = brstat.tlt.nor_noti_ins         
                        wload.inscode    = brstat.tlt.nor_usr_ins       
                        wload.campcode   = trim(n_campcode)        
                        wload.campname   = trim(n_campname)        
                        /*wload.procode    = trim(n_procode)  */      
                        wload.proname    = trim(n_proname)       
                        /*wload.packname   = trim(n_packname)*/        
                        wload.packcode   = trim(n_packcode)       
                        wload.prepol     = TRIM(SUBSTR(brstat.tlt.imp,R-INDEX(brstat.tlt.imp,"Pol:") + 4))      
                        wload.instype    = trim(n_instype)  
                        wload.pol_title  = trim(n_pol_title)  
                        wload.pol_fname  = trim(n_pol_fname) + " " + TRIM(n_pol_lname)        
                        /* wload.pol_title_eng =  TRIM(n_pol_title_eng)    
                        wload.pol_fname_eng =  TRIM(n_pol_fname_eng) + " " + TRIM(n_pol_lname_eng)  */ 
                        wload.icno       = TRIM(n_icno)        
                        wload.bdate      = TRIM(n_polbdate)        
                        /*wload.occup      = TRIM(n_occup)*/        
                        wload.tel        = trim(n_tel)
                        /* wload.mail       = trim(n_mail)        
                        wload.addrpol1   = trim(n_addr1_70)     
                        wload.addrpol2   = trim(n_addr2_70)     
                        wload.addrpol3   = trim(n_addr3_70)     
                        wload.addrpol4   = trim(n_addr4_70)*/     
                        wload.addrsend1  = trim(n_addr1_72)        
                        wload.addrsend2  = trim(n_addr2_72)        
                        wload.addrsend3  = trim(n_addr3_72)        
                        wload.addrsend4  = trim(n_addr4_72)        
                        /*wload.paytype    = TRIM(n_paytype)  */     
                        wload.paytitle   = TRIM(n_paytitle)
                        wload.payname    = trim(n_payname) + " " + TRIM(n_paylname)        
                        wload.icpay      = trim(brstat.tlt.comp_sub)           
                        wload.addrPay1   = trim(n_payaddr1)         
                        wload.addrPay2   = trim(n_payaddr2)         
                        wload.addrPay3   = trim(n_payaddr3)         
                        wload.addrPay4   = trim(n_payaddr4)         
                        /*wload.branch     = TRIM(n_branch)*/        
                        wload.ben_name   = TRIM(n_ben_name)       
                        /*wload.pmentcode  = trim(n_pmentcode) */         
                        wload.pmenttyp   = trim(n_pmenttyp)          
                        /* wload.pmentcode1 = trim(n_pmentcode1)  */        
                        wload.pmentcode2 = trim(n_pmentcode2)          
                        /*  wload.pmentbank  = TRIM(brstat.tlt.safe3)         
                        wload.pmentdate  = TRIM(n_pmentdate)       
                        wload.pmentsts   = trim(n_pmentsts)*/        
                        wload.brand      = trim(brstat.tlt.brand)               
                        wload.Model      = trim(brstat.tlt.model)             
                        wload.body       = trim(brstat.tlt.expousr)           
                        wload.licence    = trim(brstat.tlt.lince1)            
                        wload.province   = trim(brstat.tlt.lince2)            
                        wload.chassis    = trim(brstat.tlt.cha_no)            
                        wload.engine     = trim(brstat.tlt.eng_no)            
                        wload.yrmanu     = trim(brstat.tlt.gentim)            
                        /* wload.seatenew   = STRING(brstat.tlt.sentcnt)  */               
                        wload.power      = STRING(brstat.tlt.rencnt)                  
                        /* wload.weight     = string(brstat.tlt.cc_weight)   */            
                        wload.class      = trim(brstat.tlt.expotim)           
                        wload.garage     = trim(n_garage)        
                        wload.colorcode  = TRIM(brstat.tlt.colorcod)        
                        wload.covcod     = trim(n_covcod)         
                        wload.covtyp     = trim(n_covtyp)         
                        wload.comdat     = string(DAY(brstat.tlt.gendat),"99") + "/" +
                        string(MONTH(brstat.tlt.gendat),"99") + "/" +
                        string(YEAR(brstat.tlt.gendat),"9999") 
                        wload.expdat     = string(DAY(brstat.tlt.expodat),"99") + "/" +
                        string(MONTH(brstat.tlt.expodat),"99") + "/" +
                        string(YEAR(brstat.tlt.expodat),"9999")  
                        wload.ins_amt    = string(brstat.tlt.nor_coamt,">>>,>>>,>>9.99")
                        wload.fi         = IF trim(wload.covcod) = "1" THEN string(brstat.tlt.nor_coamt,">>>,>>>,>>9.99") ELSE "0"
                        wload.prem1      = string(brstat.tlt.nor_grprm,">>>,>>>,>>9.99")                                                              
                        wload.gross_prm  = string(brstat.tlt.comp_grprm,">>>,>>>,>>9.99")                                                            
                        wload.stamp      = TRIM(SUBSTR(brstat.tlt.stat,5,R-INDEX(brstat.tlt.stat,"Vat:") - 5))               
                        wload.vat        = TRIM(SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"Vat:") + 4 ))                
                        wload.premtotal  = STRING(brstat.tlt.comp_coamt,">>>,>>>,>>9.99")                                                             
                        wload.deduct     = trim(brstat.tlt.endno)                                                            
                        wload.fleetper   = string(DECI(SUBSTR(brstat.tlt.comp_sck,R-INDEX(brstat.tlt.comp_sck ,"felA:") + 5 )))         
                        wload.ncbper     = string(DECI(SUBSTR(brstat.tlt.comp_noti_tlt,R-INDEX(brstat.tlt.comp_noti_tlt ,"ncbA:") + 5 )))        
                        wload.othper     = string(DECI(SUBSTR(brstat.tlt.comp_noti_ins,R-INDEX(brstat.tlt.comp_noti_ins ,"OthA:") + 5 )))       
                        wload.cctvper    = string(DECI(SUBSTR(brstat.tlt.comp_usr_ins,R-INDEX(brstat.tlt.comp_usr_ins ,"ctvA:") + 5 )))
                        wload.driver     = STRING(brstat.tlt.endcnt)         
                        wload.drivename1 = TRIM(n_drivename1) + " " + trim(n_drivelname1)        
                        wload.driveno1   = TRIM(n_driveno1)        
                        wload.occupdriv1 = n_occupdriv1       
                        wload.sexdriv1   = n_sexdriv1       
                        wload.bdatedriv1 = n_bdatedriv1
                        wload.drivename2 = n_drivename2 + " " + n_drivelname2               
                        wload.driveno2   = n_driveno2                                       
                        wload.occupdriv2 = n_occupdriv2                                     
                        wload.sexdriv2   = n_sexdriv2                                       
                        wload.bdatedriv2 = n_bdatedriv2 . */
                        CREATE wtxt.
                        ASSIGN 
                        wtxt.poltyp       = wload.poltyp 
                        wtxt.cedcode      = wload.cedcode
                        wtxt.inscode      = wload.inscode
                        /*wtxt.acc1         = n_acc1   */             
                        wtxt.accdetail1   = n_accdetail1          
                        wtxt.accprice1    = n_accprice1           
                        /* wtxt.acc2         = n_acc2  */              
                        wtxt.accdetail2   = n_accdetail2          
                        wtxt.accprice2    = n_accprice2           
                        /* wtxt.acc3         = n_acc3    */            
                        wtxt.accdetail3   = n_accdetail3          
                        wtxt.accprice3    = n_accprice3           
                        /* wtxt.acc4         = n_acc4    */            
                        wtxt.accdetail4   = n_accdetail4          
                        wtxt.accprice4    = n_accprice4           
                        /* wtxt.acc5         = n_acc5   */             
                        wtxt.accdetail5   = n_accdetail5          
                        wtxt.accprice5    = n_accprice5           
                        wtxt.inspdate     = IF brstat.tlt.nor_effdat <> ? THEN 
                                               STRING(DAY(brstat.tlt.nor_effdat),"99") + "/" +
                                               STRING(MONTH(brstat.tlt.nor_effdat),"99") + "/" +
                                               STRING(YEAR(brstat.tlt.nor_effdat),"9999") 
                                            ELSE ""
                        wtxt.inspdetail   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") + 7))      
                        wtxt.not_date     = STRING(DAY(brstat.tlt.datesent),"99") + "/" +
                        STRING(MONTH(brstat.tlt.datesent),"99") + "/" +
                        STRING(YEAR(brstat.tlt.datesent),"9999")       
                        wtxt.paydate      = IF brstat.tlt.dat_ins_noti <> ? THEN  
                        STRING(DAY(brstat.tlt.dat_ins_noti),"99") + "/" +
                        STRING(MONTH(brstat.tlt.dat_ins_noti),"99") + "/" +
                        STRING(YEAR(brstat.tlt.dat_ins_noti) - 543,"9999")  
                        ELSE ""           
                        /* wtxt.paysts       = trim(n_paysts)  */         
                        wtxt.licenBroker  = trim(n_licenBroker)  /* เบอร์โทรตรวจสภาพ */        
                        wtxt.brokname     = trim(n_brokname)  /* ชื่อตรวจสภาพ */         
                        wtxt.brokcode     = trim(n_brokcode)   /* สถานที่ตรวจสภาพ*/        
                        /* wtxt.lang         = trim(n_lang)                 
                        wtxt.deli         = trim(n_deli)  */                
                        wtxt.delidetail   = trim(n_delidetail)            
                        wtxt.gift         = trim(brstat.tlt.EXP)           
                        wtxt.remark       = trim(n_remark)              
                        wtxt.insno        = "" /* ข้อมูลตรวจสภาพ */               
                        wtxt.resultins    = "" /* ข้อมูลตรวจสภาพ */                 
                        wtxt.damage1      = "" /* ข้อมูลตรวจสภาพ */        
                        wtxt.damage2      = "" /* ข้อมูลตรวจสภาพ */        
                        wtxt.damage3      = "" /* ข้อมูลตรวจสภาพ */        
                        wtxt.dataoth      = "" /* ข้อมูลตรวจสภาพ */ 
                        wtxt.policy       = TRIM(SUBSTR(brstat.tlt.imp,R-INDEX(brstat.tlt.imp,"Pol:") + 4))
                        wtxt.producer     = trim(brstat.tlt.subins)
                        /*wtxt.agent        = trim(brstat.tlt.recac) *//*A63-00476*/
                        wtxt.agent        = "B3MLAY0100"     /*trim(brstat.tlt.recac) *//*A63-00476*/
                        wtxt.hobr         = TRIM(n_hobr)
                        wtxt.dealer       = trim(brstat.tlt.dealer) /*A65-0115*/ 
                        wtxt.remark2      = n_chk 
                        wtxt.nCOLOR       = trim(brstat.tlt.note1)    /*A66-0160*/
                        /* add by : A67-0162 */
                        wtxt.tyeeng       = n_tyeeng    
                        wtxt.typMC        = n_typMC     
                        wtxt.watt         = n_watt      
                        wtxt.evmotor1     = n_evmotor1  
                        wtxt.evmotor2     = n_evmotor2  
                        wtxt.evmotor3     = n_evmotor3  
                        wtxt.evmotor4     = n_evmotor4  
                        wtxt.evmotor5     = n_evmotor5  
                        wtxt.carprice     = n_carprice  
                        wtxt.battflag     = n_battflag    
                        wtxt.battyr       = n_battyr      
                        wtxt.battdate     = n_battdate    
                        wtxt.battprice    = n_battprice   
                        wtxt.battno       = n_battno      
                        wtxt.battsi       = n_battsi      
                        wtxt.chagreno     = n_chagreno    
                        wtxt.chagrebrand  = n_chagrebrand .
                        /*..end A67-0162..*/
                END.
                ASSIGN wdetail.remark = wdetail.remark + " |" + "Confirm Complete " .
            END.   /* else do: */  
        END.  /* else do: */  
    END.  /* for tlt */
    IF wdetail.remark = "" THEN ASSIGN wdetail.remark = "Not Found Data " .
  END.  /*end else do: */
END.    /* end wdetail */
OUTPUT CLOSE.
RUN proc_reportloadgw_new.
RUN proc_expfilematch.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_expfileload C-Win 
PROCEDURE proc_expfileload :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_damdetail AS LONGCHAR .
DEF VAR nv_yrpol AS INT INIT 0.
DEF VAR nv_yr AS INT INIT 0.
DO:
    
    FOR EACH wload WHERE wload.poltyp  = "V70" OR wload.poltyp  = "V72"  NO-LOCK.
        FIND LAST wtxt WHERE wtxt.poltyp  = wload.poltyp  AND
                             wtxt.cedcode = wload.cedcode AND
                             wtxt.inscode = wload.inscode NO-LOCK NO-ERROR .
    
            IF INDEX(wload.CLASS,".") <> 0  THEN wload.CLASS = REPLACE(wload.class,".","") .
            IF LENGTH(wload.class) < 3 THEN wload.class = wload.class + "0" .
            RUN proc_chklicen. /*เช็คทะเบียน */
            RUN proc_cutpolicy.
           /* เช็คข้อมูลตรวจสภาพ */
                   FIND LAST brstat.tlt USE-INDEX tlt06 WHERE tlt.cha_no = wload.chassis AND 
                                                              tlt.eng_no = wload.engine  AND
                                                              tlt.flag   = "INSPEC"      AND 
                                                              tlt.genusr = "AYCAL"       NO-LOCK NO-ERROR.
                   IF AVAIL tlt THEN DO:
                       ASSIGN wtxt.insno       = brstat.tlt.nor_noti_tlt
                              wtxt.resultins   = brstat.tlt.safe1
                              nv_damdetail     = brstat.tlt.safe2
                              wtxt.dataoth     = brstat.tlt.filler2 . 
                        IF nv_damdetail <> "" THEN DO:
                          IF INDEX(nv_damdetail,"21.") <> 0 THEN DO: 
                              ASSIGN wtxt.damage3 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"21.")))
                                     nv_damdetail = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"21.") - 2))
                                     wtxt.damage2 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"11.")))
                                     wtxt.damage1 = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"11.") - 2)).
                          END.
                          ELSE IF INDEX(nv_damdetail,"11.") <> 0 THEN DO:
                              ASSIGN wtxt.damage3 = ""
                                     wtxt.damage2 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"11.")))
                                     wtxt.damage1 = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"11.") - 2)).
                          END.
                          ELSE DO:
                              ASSIGN wtxt.damage3 = "" 
                                     wtxt.damage2 = ""
                                     wtxt.damage1 = TRIM(nv_damdetail) .
                          END.
                        END.
                        ELSE  ASSIGN wtxt.damage3 = "" 
                                     wtxt.damage2 = "" 
                                     wtxt.damage1 = "".
                   END.
                   ELSE ASSIGN wtxt.insno       = ""
                               wtxt.resultins   = ""
                               wtxt.damage1     = ""
                               wtxt.damage2     = ""
                               wtxt.damage3     = ""
                               wtxt.dataoth     = "" .
           /* เช็คเบอร์ต่ออายุ */
            IF wload.chassis <> ""  THEN DO: 
                ASSIGN  nv_yrpol = 0    nv_yr = 0.  
                RUN proc_chassis.
                IF wload.poltyp = "V70" THEN DO:
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30121  WHERE 
                              sicuw.uwm301.cha_no = trim(wload.chassis) AND 
                              sicuw.uwm301.tariff = "X" NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAIL sicuw.uwm301 THEN DO:
                         nv_yrpol = (INT(SUBSTR(sicuw.uwm301.policy,5,2)) + 2500 ).
                         nv_yr    = (YEAR(TODAY) + 543 ) . 
                         nv_yr    = nv_yr - nv_yrpol .
                         IF nv_yr <= 5 THEN ASSIGN wload.prepol = sicuw.uwm301.policy.
                         ELSE ASSIGN wload.prepol = "" .
                     END.
                     ELSE ASSIGN wload.prepol = "" .
                END.
                ELSE DO:
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30121  WHERE 
                              sicuw.uwm301.cha_no = trim(wload.chassis) AND 
                              sicuw.uwm301.tariff = "9" NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAIL sicuw.uwm301 THEN DO:
                        nv_yrpol = (INT(SUBSTR(sicuw.uwm301.policy,5,2)) + 2500 ).
                        nv_yr    = (YEAR(TODAY) + 543 ) . 
                        nv_yr    = nv_yr - nv_yrpol .
                        IF nv_yr <= 5 THEN ASSIGN wload.prepol = sicuw.uwm301.policy.
                        ELSE ASSIGN wload.prepol = "" .
                       
                     END.
                     ELSE ASSIGN wload.prepol = "" .
    
                END.
            END.
            if index(wload.bdatedriv1,"?") <> 0 or wload.bdatedriv1 = ""  then assign wload.bdatedriv1 = "" .
            ELSE ASSIGN wload.bdatedriv1 = STRING(DAY(DATE(wload.bdatedriv1)),"99") + "/" +
                                           STRING(MONTH(DATE(wload.bdatedriv1)),"99") + "/" +  
                                           STRING(YEAR(DATE(wload.bdatedriv1)),"9999").
            if index(wload.bdatedriv2,"?") <> 0 or wload.bdatedriv2 = ""  then assign wload.bdatedriv2 = "" .
            ELSE ASSIGN wload.bdatedriv2 = STRING(DAY(DATE(wload.bdatedriv2)),"99") + "/" +
                                           STRING(MONTH(DATE(wload.bdatedriv2)),"99") + "/" +  
                                           STRING(YEAR(DATE(wload.bdatedriv2)),"9999").
            /* A67-0162 */
            IF INDEX( wload.bdatedriv3,"?") <> 0 OR  wload.bdatedriv3 = ""  THEN assign wload.bdatedriv3 = "" .
            ELSE ASSIGN wload.bdatedriv3 = STRING(DAY(DATE(wload.bdatedriv3)),"99") + "/" +
                                           STRING(MONTH(DATE(wload.bdatedriv3)),"99") + "/" +  
                                           STRING(YEAR(DATE(wload.bdatedriv3)),"9999").
            IF INDEX( wload.bdatedriv4,"?") <> 0 OR  wload.bdatedriv4 = ""  THEN assign wload.bdatedriv4 = "" .
            ELSE ASSIGN wload.bdatedriv4 = STRING(DAY(DATE(wload.bdatedriv4)),"99") + "/" +
                                           STRING(MONTH(DATE(wload.bdatedriv4)),"99") + "/" +  
                                           STRING(YEAR(DATE(wload.bdatedriv4)),"9999").
            IF INDEX( wload.bdatedriv5,"?") <> 0 OR  wload.bdatedriv5 = ""  THEN  assign wload.bdatedriv5 = "" .
            ELSE ASSIGN wload.bdatedriv5 = STRING(DAY(DATE(wload.bdatedriv5)),"99") + "/" +
                                           STRING(MONTH(DATE(wload.bdatedriv5)),"99") + "/" +  
                                           STRING(YEAR(DATE(wload.bdatedriv5)),"9999").
            IF index(wtxt.battdate,"?") <> 0 OR wtxt.battdate = "" THEN ASSIGN wtxt.battdate = "" .
            ELSE ASSIGN wtxt.battdate = STRING(DAY(DATE(wtxt.battdate)),"99") + "/" +   
                                        STRING(MONTH(DATE(wtxt.battdate)),"99") + "/" + 
                                        STRING(YEAR(DATE(wtxt.battdate)),"9999"). 
            IF wtxt.nCOLOR <> "" AND index(wtxt.nCOLOR,"สีรถ") <> 0 THEN wtxt.nCOLOR = trim(REPLACE(wtxt.nCOLOR,"สีรถ:","")).
            /* end : A67-0162 */
            if index(wload.occupdriv1,"?") <> 0 or wload.occupdriv1 = ""  then assign wload.occupdriv1 = "" .
            if index(wload.sexdriv1,"?")   <> 0 or wload.sexdriv1   = ""  then assign wload.sexdriv1   = "" .
            if index(wload.occupdriv2,"?") <> 0 or wload.occupdriv2 = ""  then assign wload.occupdriv2 = "" .
            if index(wload.sexdriv2,"?")   <> 0 or wload.sexdriv2   = ""  then assign wload.sexdriv2   = "" .
           
        nv_row  =  nv_row + 1.
        EXPORT DELIMITER "|"                            
            wload.poltyp                                /* ประเภทกรมธรรม์*/ 
            wload.bray                                  /* สาขาจากไฟล์ */
            wload.contract                              /* contract */
            wload.cedcode                               /* รหัสอ้างอิง   */               
            wload.inscode                               /* รหัสลูกค้า    */               
            wload.campcode                              /* รหัสแคมเปญ    */               
            wload.campname                              /* ชื่อแคมเปญ    */
            wload.proname                               /* ชื่อผลิตภัณฑ์ */ 
            wload.packcode                              /* รหัสแพคเก็จ   */
            wload.prepol                                /* กธ.เดิม */
            wload.pol_title                             /* คำนำหน้าชื่อ ผู้เอาประกัน */   
            wload.pol_fname                             /* ชื่อ ผู้เอาประกัน         */ 
            wload.icno                                  /* เลขบัตรผู้เอาประกัน */         
            wload.bdate                                 /* วันเกิดผู้เอาประกัน */ 
            wload.tel                                   /* เบอร์โทรผู้เอาประกัน*/ 
            wload.addrsend1                             /* ที่อยู่จัดส่ง 1  */            
            wload.addrsend2                             /* ที่อยู่จัดส่ง 2  */            
            wload.addrsend3                             /* ที่อยู่จัดส่ง 3  */            
            wload.addrsend4                             /* ที่อยู่จัดส่ง 4  */ 
            wload.paytitle                              /* คำนำหน้าชื่อ ผู้จ่ายเงิน*/     
            wload.payname                               /* ชื่อ ผู้จ่ายเงิน*/  
            wload.icpay                                 /* เลขประจำตัวผู้เสียภาษี*/                     
            wload.addrPay1                              /* ที่อยู่ออกใบเสร็จ1*/                         
            wload.addrPay2                              /* ที่อยู่ออกใบเสร็จ2*/                         
            wload.addrPay3                              /* ที่อยู่ออกใบเสร็จ3*/                         
            wload.addrPay4                              /* ที่อยู่ออกใบเสร็จ4*/ 
            wload.ben_name                              /* ผู้รับผลประโยชน์  */
            wload.pmenttyp                              /* ประเภทการจ่าย */  
            wload.pmentcode2                            /* ช่องทางการจ่าย  */
            wload.brand                                 /* ยี่ห้อ  */                     
            wload.Model                                 /* รุ่น    */                     
            wload.body                                  /* แบบตัวถัง*/                    
            wload.licence                               /* ทะเบียน */                     
            wload.province                              /* จังหวัดทะเบียน */              
            wload.chassis                               /* เลขตัวถัง*/                    
            wload.engine                                /* เลขเครื่อง */                  
            wload.yrmanu                                /* ปีรถ    */ 
            wload.power                                 /* ซีซี    */                     
            wload.class                                 /* คลาสรถ  */                     
            wload.garage                                /* การซ่อม */                         
            wload.covcod                                /* ประเภทการประกัน */             
            wload.covtyp                                /* รหัสการประกัน*/                
            wload.comdat                                /* วันที่คุ้มครอง  */             
            wload.expdat                                /* วันที่หมดอายุ*/                
            wload.ins_amt                               /* ทุนประกัน*/
            wload.fi                                    /* ทุนสูญหาย/ไฟไหม้*/
            wload.prem1                                 /* เบี้ยสุทธิก่อนหักส่วนลด*/      
            wload.gross_prm                             /* เบี้ยสุทธิหลังหักส่วนลด*/      
            wload.stamp                                 /* สแตมป์  */                     
            wload.vat                                   /* ภาษี    */                     
            wload.premtotal                             /* เบี้ยรวม*/                     
            wload.deduct                                /* Deduct  */                     
            wload.fleetper                              /* fleet   */                     
            wload.ncbper                                /* ncb     */
            wload.othper                                /* other   */                     
            wload.cctvper                               /* cctv    */ 
            wload.driver                                /* ระบุผู้ขับขี่    */            
            wload.drivename1                            /* ชื่อผู้ขับขี่1   */    
            wload.driveno1                              /* เลขบัตรผู้ขับขี่1*/            
            wload.occupdriv1                            /* อาชีพผู้ขับขี่1  */            
            wload.sexdriv1                              /* เพศผู้ขับขี่1    */            
            wload.bdatedriv1                            /* วันเกิดผู้ขับขี่1*/  
            wload.licenno1                              /* A67-0162 */
            wload.licenex1                              /* A67-0162 */
            wload.drivename2                            /* ชื่อผู้ขับขี่2   */                 
            wload.driveno2                              /* เลขบัตรผู้ขับขี่2*/          
            wload.occupdriv2                            /* อาชีพผู้ขับขี่2  */            
            wload.sexdriv2                              /* เพศผู้ขับขี่2    */            
            wload.bdatedriv2                             /* วันเกิดผู้ขับขี่2*/
            wload.licenno2                             /* A67-0162 */  
            wload.licenex2                             /* A67-0162 */ 
            /* A67-0162 */
            wload.drivename3                           /* ชื่อผู้ขับขี่2   */                 
            wload.driveno3                             /* เลขบัตรผู้ขับขี่2*/          
            wload.occupdriv3                           /* อาชีพผู้ขับขี่2  */            
            wload.sexdriv3                             /* เพศผู้ขับขี่2    */            
            wload.bdatedriv3                           /* วันเกิดผู้ขับขี่2*/
            wload.licenno3                             /* A67-0162 */  
            wload.licenex3                             /* A67-0162 */
            wload.drivename4                           /* ชื่อผู้ขับขี่2   */                 
            wload.driveno4                             /* เลขบัตรผู้ขับขี่2*/          
            wload.occupdriv4                           /* อาชีพผู้ขับขี่2  */            
            wload.sexdriv4                             /* เพศผู้ขับขี่2    */            
            wload.bdatedriv4                           /* วันเกิดผู้ขับขี่2*/
            wload.licenno4                             /* A67-0162 */  
            wload.licenex4                             /* A67-0162 */
            wload.drivename5                           /* ชื่อผู้ขับขี่2   */                 
            wload.driveno5                             /* เลขบัตรผู้ขับขี่2*/          
            wload.occupdriv5                           /* อาชีพผู้ขับขี่2  */            
            wload.sexdriv5                             /* เพศผู้ขับขี่2    */            
            wload.bdatedriv5                           /* วันเกิดผู้ขับขี่2*/
            wload.licenno5                             /* A67-0162 */  
            wload.licenex5                             /* A67-0162 */
            wtxt.accdetail1                             /* รายละเอียดอุปกรณ์1*/           
            wtxt.accprice1                              /* ราคาอุปกรณ์1  */                 
            wtxt.accdetail2                             /* รายละเอียดอุปกรณ์2*/           
            wtxt.accprice2                              /* ราคาอุปกรณ์2  */                
            wtxt.accdetail3                             /* รายละเอียดอุปกรณ์3*/           
            wtxt.accprice3                              /* ราคาอุปกรณ์3  */                
            wtxt.accdetail4                             /* รายละเอียดอุปกรณ์4*/           
            wtxt.accprice4                              /* ราคาอุปกรณ์4  */ 
            wtxt.accdetail5                             /* รายละเอียดอุปกรณ์5*/           
            wtxt.accprice5                              /* ราคาอุปกรณ์5  */               
            wtxt.inspdate                               /* วันที่ตรวจสภาพ*/  
            wtxt.brokname                               /* ชื่อตรวจสภาพ */ 
            wtxt.licenBroker                              /* เบอร์โทรตรวจสภาพ */ 
            wtxt.brokcode                             /* สถานที่ตรวจสภาพ*/  
            wtxt.inspdetail                             /* รายละเอียดการตรวจสภาพ*/        
            wtxt.not_date                               /* วันที่ขาย*/                    
            wtxt.paydate                                /* วันที่รับชำระเงิน*/  
            wtxt.delidetail                             /* รายละเอียดการจัดส่ง */         
            wtxt.gift                                   /* Agent name  */                     
            wtxt.remark                                 /* หมายเหตุ*/                     
            wtxt.insno                                   /* เลขตรวจสภาพ */      
            wtxt.resultins                               /* ผลการตรวจ */   
            wtxt.damage1                                 /* ความเสียหาย1 */ 
            wtxt.damage2                                 /* ความเสียหาย2 */
            wtxt.damage3                                 /* ความเสียหาย3 */   
            wtxt.dataoth                                 /* ข้อมูลอื่นๆ */  
            wtxt.policy                                   /* policy */
            wtxt.producer
            wtxt.agent
            wtxt.dealer     /*A65-0115*/
            wtxt.hobr
            wtxt.remark2
            wtxt.nCOLOR   /*A66-0160*/
            /* A67-0162 */ 
            wtxt.watt       
            wtxt.evmotor1   
            wtxt.evmotor2   
            wtxt.evmotor3   
            wtxt.evmotor4   
            wtxt.evmotor5   
            wtxt.carprice   
            wtxt.battflag   
            wtxt.battyr     
            wtxt.battdate   
            wtxt.battprice  
            wtxt.battno     
            wtxt.battsi     
            wtxt.chagreno   
            wtxt.chagrebrand .
            /* end : A67-0162 */
    
    END. 
END.
                                                         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_expfilematch C-Win 
PROCEDURE proc_expfilematch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    If  substr(fi_outload2,length(fi_outload2) - 3,4) <>  ".CSV"  THEN 
        fi_outload2  =  Trim(fi_outload2) + ".CSV"  .
    ASSIGN nv_cnt =  0
           nv_row  =  1.
    OUTPUT TO VALUE(fi_outload2).
        EXPORT DELIMITER "|" 
            "INSURANCE  " 
            "YEAR       " 
            "BRANCH     " 
            "CONTRACT   " 
            "NAME       " 
            "เลขรับแจ้ง " 
            "ทะเบียน    " 
            "จังหวัด    " 
            "BODY       " 
            "ENGINE     " 
            "วันคุ้มครอง" 
            "เบี้ยรวม   " 
            "ชำระล่าสุด " .
        FOR EACH wdetail NO-LOCK.
            nv_row = nv_row + 1 .
            EXPORT DELIMITER "|"
                wdetail.Codecompany 
                wdetail.renew       
                wdetail.Branch      
                wdetail.Contract    
                wdetail.name1       
                wdetail.policy      
                wdetail.vehreg      
                wdetail.provin      
                wdetail.chassis     
                wdetail.engno       
                wdetail.comdat70    
                wdetail.premtnet    
                wdetail.recivedat
                wdetail.remark SKIP .
        END.
    OUTPUT CLOSE.
END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol1 C-Win 
PROCEDURE proc_impmatpol1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_loadname).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.Codecompany   /*  INSURANCE   */
        wdetail.renew         /*  YEAR        */
        wdetail.product       /*  product code */ /*A65-0115*/
        wdetail.Branch        /*  BRANCH      */
        wdetail.Contract      /*  CONTRACT    */
        wdetail.name1         /*  NAME        */
        wdetail.policy        /*  เลขรับแจ้ง  */
        wdetail.vehreg        /*  ทะเบียน     */      
        wdetail.provin        /*  จังหวัด     */   
        wdetail.chassis       /*  BODY        */      
        wdetail.engno         /*  ENGINE      */
        wdetail.comdat70      /*  วันคุ้มครอง */
        wdetail.premtnet      /*  เบี้ยรวม    */
        wdetail.recivedat.    /*  ชำระล่าสุด  */
END.
IF ra_matchpol = 1 THEN RUN proc_reportloadgw_old.
ELSE IF ra_matchpol = 4 THEN RUN proc_chkpol.

Message "Export data Complete"  View-as alert-box.

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
DEF BUFFER bftlt FOR brstat.tlt.
DEF VAR np_expdat AS CHAR FORMAT "x(15)".
DEF VAR np_year AS INT INIT 0.
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wload.
        CREATE wtxt.
        IMPORT DELIMITER "|" 
            n_poltyp 
            n_bray
            n_contract
            n_cedcode                                                                                               
            n_inscode                                                                                               
            n_campcode                                                                                              
            n_campname                                                                               
            n_proname                                                                                 
            n_packcode
            n_prepol                                                                                    
            n_pol_title                                                                                             
            n_pol_fname                                           
            n_icno                                                                                                  
            n_bdate                                                                                       
            n_tel                                                            
            n_addr1_72                                                                                     
            n_addr2_72                                                                                     
            n_addr3_72                                                                                              
            n_addr4_72                                                                                  
            n_paytitle                                                                                              
            n_payname
            n_payicno  
            n_payaddr1 
            n_payaddr2 
            n_payaddr3 
            n_payaddr4                                                                               
            n_ben_name                                                                                
            n_pmenttyp                                                                         
            n_pmentcode2                                                                              
            n_brand                                                                                                 
            n_Model                                                                                                 
            n_body                                                                                                  
            n_licence                                                                                               
            n_province                                                                                              
            n_chassis                                                                                               
            n_engine                                                                                                
            n_yrmanu                                                                                
            n_power                                                                                                 
            n_class                                                                                                 
            n_garage                                                                                    
            n_covcod                                                                                                
            n_covtyp                                                                                                
            n_comdat                                                                                                
            n_expdat                                                                                                
            n_ins_amt
            n_fi
            n_prem1                                                                                                 
            n_gross_prm                                                                                             
            n_stamp                                                                                                 
            n_vat                                                                                                   
            n_premtotal                                                                                             
            n_deduct                                                                                                
            n_fleetper                           
            n_ncbper                
            n_othper                                 
            n_cctvper                                                                              
            n_driver                                                                                         
            n_drivename1                                       
            n_driveno1                                                                                              
            n_occupdriv1                                                                                            
            n_sexdriv1                                                                                              
            n_bdatedriv1
            n_drivlicen1     /*A67-0162*/
            n_drivcardexp1   /*A67-0162*/
            n_drivename2                                   
            n_driveno2                                                                                              
            n_occupdriv2                                                                                            
            n_sexdriv2                                                                                              
            n_bdatedriv2
            n_drivlicen2      /*A67-0162*/   
            n_drivcardexp2    /*A67-0162*/ 
            /* A67-0162 */
            n_drivename3                                   
            n_driveno3                                                                                              
            n_occupdriv3                                                                                            
            n_sexdriv3                                                                                              
            n_bdatedriv3
            n_drivlicen3     
            n_drivcardexp3  
            n_drivename4                   
            n_driveno4                                                                              
            n_occupdriv4                                                                            
            n_sexdriv4                                                                              
            n_bdatedriv4
            n_drivlicen4     
            n_drivcardexp4  
            n_drivename5    
            n_driveno5      
            n_occupdriv5    
            n_sexdriv5      
            n_bdatedriv5    
            n_drivlicen5    
            n_drivcardexp5
            /* end A67-0162 */
            n_accdetail1                                                                                              
            n_accprice1                                                                                               
            n_accdetail2                                                                                              
            n_accprice2                                                                                               
            n_accdetail3                                                                                              
            n_accprice3                                                                                               
            n_accdetail4                                                                                              
            n_accprice4                                                                                              
            n_accdetail5                                                                                              
            n_accprice5                                                                                               
            n_inspdate 
            n_brokname
            n_licenBroker                                                                                 
            n_brokcode 
            n_inspdetail                                                                                              
            n_not_date                                                                      
            n_paydate 
            n_delidetail                                                                                              
            n_gift                                                                                                    
            n_remark
            n_insno    
            n_resultins
            n_damage1  
            n_damage2  
            n_damage3  
            n_dataoth
            n_policy
            n_producer 
            n_agent
            n_dealer  /*A64-0115*/
            n_hobr
            n_remark2  
            /* A67-0162 */
            n_color
            n_watt       
            n_evmotor1   
            n_evmotor2   
            n_evmotor3   
            n_evmotor4   
            n_evmotor5   
            n_carprice 
            n_battflag   
            n_battyr     
            n_battdate   
            n_battprice  
            n_battno     
            n_battsi     
            n_chagreno   
            n_chagrebrand .
           /* end A67-0162 */
        IF INDEX(n_poltyp,"ประเภท")   <> 0 THEN  NEXT.
        ELSE IF n_poltyp = "" THEN  NEXT.
        ELSE DO: 
            RUN proc_assign.
            RUN proc_cleardata.
        END.
    END.
    FOR EACH wload .
       IF wload.poltyp  = "" THEN DELETE wload.
       ELSE DO:
           IF wload.poltyp = "V70" THEN DO:
               FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wload.contract) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING.
                  IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
                  ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
                  ELSE DO:
                    ASSIGN np_expdat = ""
                           np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").
                          IF DATE(np_expdat) = DATE(wload.expdat) THEN DO:
                              ASSIGN  wload.policy  = sicuw.uwm100.policy.
                              /*FIND LAST brstat.tlt USE-INDEX tlt05  WHERE*/  /*kridtiya i. A66-0140*/
                              FIND LAST brstat.tlt USE-INDEX tlt06  WHERE      /*kridtiya i. A66-0140*/
                                  brstat.tlt.cha_no       =  trim(wload.chassis) AND 
                                  brstat.tlt.nor_noti_ins =  TRIM(wload.cedcode)  AND
                                  brstat.tlt.genusr  =  "AYCAL"             AND 
                                  brstat.tlt.flag    =  "V70"               NO-ERROR NO-WAIT.   
                              IF AVAIL brstat.tlt THEN DO:
                                  
                                  ASSIGN brstat.tlt.releas = "YES".
                                  IF brstat.tlt.policy = ""  THEN ASSIGN brstat.tlt.policy = wload.policy.
                                  /*FIND LAST bftlt USE-INDEX tlt05  WHERE  */  /*kridtiya i. A66-0140*/
                                  FIND LAST bftlt USE-INDEX tlt06  WHERE        /*kridtiya i. A66-0140*/
                                      bftlt.cha_no  =  trim(brstat.tlt.nor_noti_ins)  AND              
                                      bftlt.genusr  =  "AYCAL"                        AND 
                                      bftlt.flag    =  "Payment"                     NO-ERROR NO-WAIT.     
                                  IF AVAIL bftlt THEN DO:
                                      IF bftlt.policy = ""  THEN ASSIGN bftlt.policy = wload.policy.
                                      
                                  END.
                                  RELEASE bftlt.
                                  /*FIND LAST bftlt USE-INDEX tlt05  WHERE */ /*kridtiya i. A66-0140*/   
                                  FIND LAST bftlt USE-INDEX tlt06  WHERE      /*kridtiya i. A66-0140*/   
                                      bftlt.cha_no         =  trim(brstat.tlt.cha_no)       AND 
                                      bftlt.nor_noti_ins   =  trim(brstat.tlt.nor_noti_ins) AND
                                      bftlt.genusr         =  "AYCAL"                 AND 
                                      bftlt.flag           =  "INSPEC"  NO-ERROR NO-WAIT.     
                                  IF AVAIL bftlt THEN DO:
                                      IF bftlt.policy = ""  THEN ASSIGN bftlt.policy = wload.policy.
                                      
                                  END.
                                  RELEASE bftlt.

                              END.
                              
                              RELEASE brstat.tlt.
                          END.
                          ELSE ASSIGN wload.policy  = "".
                  END.
               END.
               RELEASE sicuw.uwm100.
           END.
           IF wload.poltyp = "V72" THEN DO:
                  FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wload.contract) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING. 
                        IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
                        ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
                        ELSE DO:
                            ASSIGN np_expdat = ""
                                   np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").
                           
                            IF DATE(np_expdat) = DATE(wload.expdat) THEN DO:
                                ASSIGN  wload.policy  = sicuw.uwm100.policy.
                                /*FIND LAST brstat.tlt USE-INDEX tlt05  WHERE */  /*kridtiya i. A66-0140*/  
                                FIND LAST brstat.tlt USE-INDEX tlt06  WHERE       /*kridtiya i. A66-0140*/  
                                    brstat.tlt.cha_no  =  trim(wload.chassis) AND              
                                    brstat.tlt.genusr  =  "AYCAL"             AND
                                    brstat.tlt.flag    =  "V72"      NO-ERROR NO-WAIT. 
                                IF AVAIL brstat.tlt THEN DO:
                                    
                                    ASSIGN brstat.tlt.releas = "YES".
                                    IF brstat.tlt.policy     = ""  THEN ASSIGN brstat.tlt.policy  = wload.policy.
                                    /*FIND LAST bftlt USE-INDEX tlt05  WHERE */ /*kridtiya i. A66-0140*/ 
                                    FIND LAST bftlt USE-INDEX tlt06  WHERE      /*kridtiya i. A66-0140*/ 
                                        bftlt.cha_no  =  trim(brstat.tlt.nor_noti_ins)  AND              
                                        bftlt.genusr        =  "AYCAL"                 AND 
                                        bftlt.flag          =  "Payment"               NO-ERROR NO-WAIT.     
                                    IF AVAIL bftlt THEN DO:
                                        IF bftlt.policy = ""  THEN ASSIGN bftlt.policy = wload.policy.
                                    END.
                                    RELEASE bftlt.
                                END.
                                
                                RELEASE brstat.tlt.
                            END.
                            ELSE ASSIGN wload.policy = "".
                        END.
                 END.
                 RELEASE sicuw.uwm100.
           END.
       END. /* else do */
    END. /*wload */
Run Proc_reportpolicy.
Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_match72 C-Win 
PROCEDURE proc_match72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR np_expdat AS CHAR FORMAT "x(15)".
DEF VAR np_year AS INT INIT 0.
DEF BUFFER bftlt FOR brstat.tlt.

FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_loadname).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"
        wdetail.renew         /* seq */
        wdetail.Codecompany   /*  INSURANCE   */
        wdetail.Contract      /*  CONTRACT    */
        wdetail.Branch        /*  BRANCH      */
        wdetail.chassis       /*  BODY        */      
        wdetail.engno         /*  ENGINE      */
        wdetail.comdat70      /*  Startdate */
        wdetail.recivedat .    /* Enddate  */
END.
FOR EACH wdetail .
   IF wdetail.chassis  = "" THEN DELETE wdetail.
   ELSE IF wdetail.chassis = "BODY" THEN DELETE wdetail.
   ELSE DO:
       ASSIGN np_year          = INT(SUBSTR(wdetail.comdat70,1,2)) + 2500
              wdetail.comdat70 = SUBSTR(wdetail.comdat70,5,2) + "/" + SUBSTR(wdetail.comdat70,3,2) + "/" + STRING(np_year - 543)
              wdetail.comdat70 = string(DATE(wdetail.comdat70),"99/99/9999")

              np_year          = INT(SUBSTR(wdetail.recivedat,1,2)) + 2500
              wdetail.recivedat = SUBSTR(wdetail.recivedat,5,2) + "/" + SUBSTR(wdetail.recivedat,3,2) + "/" + STRING(np_year - 543)
              wdetail.recivedat = STRING(DATE(wdetail.recivedat),"99/99/9999").

      
       FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.contract) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING. 
             IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
             ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
             ELSE DO:
                 ASSIGN np_expdat = ""
                        np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").
                
                 IF DATE(np_expdat) = DATE(wdetail.recivedat) THEN DO:
                     ASSIGN  wdetail.policy  = sicuw.uwm100.policy.
                     /*FIND LAST brstat.tlt USE-INDEX tlt05  WHERE*//*kridtiya i. A66-0140*/
                     FIND LAST brstat.tlt USE-INDEX tlt06  WHERE    /*kridtiya i. A66-0140*/
                         brstat.tlt.cha_no  =  trim(wdetail.chassis) AND              
                         brstat.tlt.genusr  =  "AYCAL"             AND
                         brstat.tlt.flag    =  "V72"      NO-ERROR NO-WAIT. 
                         IF AVAIL brstat.tlt THEN DO:
                             ASSIGN brstat.tlt.releas = "YES".
                             IF brstat.tlt.policy     = ""  THEN 
                                 ASSIGN brstat.tlt.policy  = wdetail.policy
                                        wdetail.remark     = brstat.tlt.releas.

                            FIND LAST bftlt WHERE 
                                bftlt.cha_no       = tlt.cha_no   AND             /* เลขถัง */         
                                bftlt.eng_no       = tlt.eng_no   AND             /* เลขเครื่อง */     
                                bftlt.nor_noti_ins = tlt.nor_noti_ins  and        /* เลขที่อ้างอิง*/   
                                bftlt.nor_usr_ins  = tlt.nor_usr_ins   and        /* เลขที่ลูกค้า */   
                                bftlt.flag         = tlt.flag   AND               /* ประเภท 70 ,72 */  
                                bftlt.genusr       = tlt.genusr     NO-ERROR NO-WAIT  . 
                            IF AVAIL bftlt THEN DO:
                                ASSIGN brstat.tlt.colorcod  = "CON:" + trim(wdetail.Contract) + " " +
                                                              "BR:" + TRIM(wdetail.branch) .
                            END.
                            RELEASE bftlt.
                         END.
                         RELEASE brstat.tlt.
                 END.
                 ELSE ASSIGN wdetail.policy = ""  wdetail.remark  = "กรุณาตรวจสอบข้อมูลอีกครั้ง ".
             END.
       END.
       RELEASE sicuw.uwm100.
   END. /* else do */
END. /*wdetail */
RUN proc_report72.
Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_querypol C-Win 
PROCEDURE proc_querypol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_polnock  AS CHAR FORMAT "x(20)" INIT "".
DEF VAR n_chkexpdat AS DATE INIT ?.

FOR EACH wdetail  .
    IF wdetail.chassis = "BODY" THEN DELETE wdetail .
    ELSE IF wdetail.chassis = ""  THEN DELETE wdetail .
    ELSE DO:
        IF wdetail.chassis <> ""   THEN DO:
            fi_disp =  " Check Data Chassic no." + wdetail.chassis + "......." .
            DISP fi_disp WITH FRAME fr_main.
            nv_polnock = "".
            n_chkexpdat = ?.
            FOR EACH sicuw.uwm301 Use-index uwm30121 Where 
                sicuw.uwm301.cha_no = trim(wdetail.chassis) AND 
                SUBSTR(sicuw.uwm301.policy,3,2) = "70"  NO-LOCK .
                IF LENGTH(sicuw.uwm301.policy) > 10 THEN DO:
                    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                        sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                        sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND 
                        sicuw.uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR .
                    IF AVAIL sicuw.uwm100 THEN DO:
                        IF nv_polnock = "" THEN 
                            ASSIGN 
                            nv_polnock  = trim(sicuw.uwm100.policy) 
                            n_chkexpdat = sicuw.uwm100.expdat .
                        ELSE IF n_chkexpdat < sicuw.uwm100.expdat  THEN
                            ASSIGN 
                            nv_polnock  = trim(sicuw.uwm100.policy) 
                            n_chkexpdat = sicuw.uwm100.expdat .
                    END.
                END.
            END.
            IF nv_polnock <> ""  THEN wdetail.polno = nv_polnock.
            ELSE DO:
                nv_polnock = "".
                n_chkexpdat = ?.
                FOR EACH sicuw.uwm301 Use-index uwm30103 Where 
                    sicuw.uwm301.trareg = trim(wdetail.chassis) AND 
                    SUBSTR(sicuw.uwm301.policy,3,2) = "70"   NO-LOCK .
                    IF LENGTH(sicuw.uwm301.policy) > 10 THEN DO:
                        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                            sicuw.uwm100.policy = sicuw.uwm301.policy AND 
                            sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND 
                            sicuw.uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR .
                        IF AVAIL sicuw.uwm100 THEN DO:
                            IF nv_polnock = "" THEN 
                                ASSIGN 
                                nv_polnock  = trim(sicuw.uwm100.policy) 
                                n_chkexpdat = sicuw.uwm100.expdat .
                            ELSE IF n_chkexpdat < sicuw.uwm100.expdat  THEN
                                ASSIGN 
                                nv_polnock  = trim(sicuw.uwm100.policy) 
                                n_chkexpdat = sicuw.uwm100.expdat .
                        END.
                    END.
                END.
                IF nv_polnock <> ""  THEN wdetail.polno = nv_polnock.
            END.
        END.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report72 C-Win 
PROCEDURE proc_report72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".CSV"  THEN 
        fi_outload  =  Trim(fi_outload) + ".CSV"  .
    OUTPUT TO VALUE(fi_outload).
    EXPORT DELIMITER "|" 
        " seq         "             
        " INSURANCE   "    
        " CONTRACT    "    
        " BRANCH      "    
        " BODY        "    
        " ENGINE      "    
        " Startdate   "      
        " Enddate     " 
        " policy      " .

    nv_row = 0.
    FOR EACH wdetail NO-LOCK.
        nv_row = nv_row + 1 .
        EXPORT DELIMITER "|"
            wdetail.renew  
            wdetail.Codecompany 
            wdetail.Contract
            wdetail.Branch
            wdetail.chassis
            wdetail.engno 
            wdetail.comdat70  
            wdetail.recivedat
            wdetail.policy
            wdetail.remark SKIP .
    END.
    OUTPUT CLOSE.
END.
    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportloadgw_new C-Win 
PROCEDURE proc_reportloadgw_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: ไฟล์โหลดงานแบบใหม่      
------------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".CSV"  THEN 
    fi_outload  =  Trim(fi_outload) + ".CSV"  .
ASSIGN nv_cnt =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
   " ประเภทกรมธรรม์" 
   " สาขา AY       "
   " Contract no   "
   " รหัสอ้างอิง   "
   " รหัสลูกค้า    "
   " รหัสแคมเปญ    "
   " ชื่อแคมเปญ    "
   " ชื่อผลิตภัณฑ์ "
   " ProspectID " 
   " กรมธรรม์เดิม  "
   " คำนำหน้าชื่อ ผู้เอาประกัน "
   " ชื่อ ผู้เอาประกัน         "
   " เลขบัตรผู้เอาประกัน "
   " วันเกิดผู้เอาประกัน "
   " เบอร์โทรผู้เอาประกัน"
   " ที่อยู่จัดส่ง 1  " 
   " ที่อยู่จัดส่ง 2  " 
   " ที่อยู่จัดส่ง 3  " 
   " ที่อยู่จัดส่ง 4  " 
   " คำนำหน้าชื่อ ผู้จ่ายเงิน"
   " ชื่อ ผู้จ่ายเงิน"
   " เลขประจำตัวผู้เสียภาษี"
   " ที่อยู่ออกใบเสร็จ1"
   " ที่อยู่ออกใบเสร็จ2"
   " ที่อยู่ออกใบเสร็จ3"
   " ที่อยู่ออกใบเสร็จ4"
   " ผู้รับผลประโยชน์  "
   " ประเภทการจ่าย "
   " ช่องทางการจ่าย  "
   " ยี่ห้อ  "  
   " รุ่น    "  
   " แบบตัวถัง" 
   " ทะเบียน "
   " จังหวัดทะเบียน "
   " เลขตัวถัง" 
   " เลขเครื่อง " 
   " ปีรถ    "  
   " ซีซี    "  
   " คลาสรถ  "  
   " การซ่อม "  
   " ประเภทการประกัน "
   " รหัสการประกัน" 
   " วันที่คุ้มครอง  "
   " วันที่หมดอายุ" 
   " ทุนประกัน"
   " ทุนสูญหาย/ไฟไหม้ "
   " เบี้ยสุทธิก่อนหักส่วนลด"
   " เบี้ยสุทธิหลังหักส่วนลด"
   " สแตมป์  "
   " ภาษี    "
   " เบี้ยรวม"
   " Deduct  "
   " fleet   " 
   " ncb     " 
   " other   "   
   " cctv    "
   " ระบุผู้ขับขี่    " 
   " ชื่อผู้ขับขี่1   " 
   " เลขบัตรผู้ขับขี่1" 
   " อาชีพผู้ขับขี่1  " 
   " เพศผู้ขับขี่1    " 
   " วันเกิดผู้ขับขี่1"
   " เลขใบขับขี่1"              /*A67-0162*/
   " วันที่ใบขับขี่หมดอายุ1"    /*A67-0162*/
   " ชื่อผู้ขับขี่2   " 
   " เลขบัตรผู้ขับขี่2" 
   " อาชีพผู้ขับขี่2  " 
   " เพศผู้ขับขี่2    " 
   " วันเกิดผู้ขับขี่2" 
   " เลขใบขับขี่2"              /*A67-0162*/
   " วันที่ใบขับขี่หมดอายุ2"    /*A67-0162*/
   /*A67-0162*/
    " ชื่อผู้ขับขี่3   " 
   " เลขบัตรผู้ขับขี่3" 
   " อาชีพผู้ขับขี่3  " 
   " เพศผู้ขับขี่3    " 
   " วันเกิดผู้ขับขี่3" 
   " เลขใบขับขี่3"             
   " วันที่ใบขับขี่หมดอายุ3"   
    " ชื่อผู้ขับขี่4   " 
   " เลขบัตรผู้ขับขี่4" 
   " อาชีพผู้ขับขี่4  " 
   " เพศผู้ขับขี่4    " 
   " วันเกิดผู้ขับขี่4" 
   " เลขใบขับขี่4"             
   " วันที่ใบขับขี่หมดอายุ4"   
    " ชื่อผู้ขับขี่5   " 
   " เลขบัตรผู้ขับขี่5" 
   " อาชีพผู้ขับขี่5  " 
   " เพศผู้ขับขี่5    " 
   " วันเกิดผู้ขับขี่5" 
   " เลขใบขับขี่5"             
   " วันที่ใบขับขี่หมดอายุ5" 
    /* end A67-0162*/
   " รายละเอียดอุปกรณ์1"
   " ราคาอุปกรณ์1  "
   " รายละเอียดอุปกรณ์2"
   " ราคาอุปกรณ์2  "
   " รายละเอียดอุปกรณ์3"
   " ราคาอุปกรณ์3  "
   " รายละเอียดอุปกรณ์4"
   " ราคาอุปกรณ์4  "
   " รายละเอียดอุปกรณ์5"
   " ราคาอุปกรณ์5  "
   " วันที่ตรวจสภาพ"
   " ชื่อผู้ตรวจสภาพ "
   " เบอร์โทรตรวจสภาพ "
   " สถานที่ตรวจสภาพ "
   " รายละเอียดการตรวจสภาพ"
   " วันที่ขาย"
   " วันที่รับชำระเงิน" 
   " รายละเอียดการจัดส่ง "
   " Agent name "
   " หมายเหตุ" 
   " เลขตรวจสภาพ "
   " ผลการตรวจ "
   " ความเสียหาย1 "
   " ความเสียหาย2 "
   " ความเสียหาย3 "
   " ข้อมูลอื่นๆ "
   " เบอร์กรมธรรม์ "
   " Producer "
   " Agent " 
   " Dealer"  /*A65-0115*/
   " สาขา STY" 
   " Remark 2 "
   " สีรถ"   /*A66-0160*/
    /* A67-0162*/
   " WATT"
   " EVMotorNo1"
   " EVMotorNo2"
   " EVMotorNo3"
   " EVMotorNo4"
   " EVMotorNo5"
   " CarPrice  "
   " ChangeBattFlag   "
   " BattYear         "
   " BattPurchaseDate "
   " BattPrice        "
   " BattSerialNo     "
   " BattRepSumInsured"
   " WallChargeNo     "
   " WallChargeBrand  " .
   /* end : A67-0162*/ 
   RUN proc_expfileload.

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportloadgw_old C-Win 
PROCEDURE proc_reportloadgw_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: ไฟล์โหลดงานแบบเดิม      
------------------------------------------------------------------------------*/
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".csv"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outfile). 
EXPORT DELIMITER "|" 
    "Match file KPN_Aycal" .
EXPORT DELIMITER "|" 
    "ลำดับที่"  
    "วันที่แจ้ง "
    "เลขรับแจ้ง "
    "Branch     "
    "Contract   "
    "คำนำหน้าชื่อ"
    "ชื่อ"  
    "นามสกุล"  
    "ที่อยู่ 1   "
    "ที่อยู่ 2   "  
    "ที่อยู่ 3   "  
    "ที่อยู่ 4   "  
    "ยี่ห้อรถ   "
    "รุ่นรถ     "
    "เลขทะเบียน "
    "ปีรถ       "
    "CC.        "
    "เลขตัวถัง  "
    "เลขเครื่อง "
    "Code ผู้แจ้ง       "
    "ประเภท     "
    "Code บ.ประกัน      "
    "เลขกรมธรรม์เดิม    "
    "เลขบัตรประชาชน   "
    "วันคุ้มครองประกัน  "
    "วันหมดประกัน       "
    "ทุนประกัน  "
    "ค่าเบี้ยสุทธิ    "
    "ค่าเบี้ยรวมภาษีอากร        "   
    "Deduct     "
    "Code บ.ประกัน พรบ. "
    "วันคุ้มครองพรบ.    "
    "วันหมดพรบ. "
    "ค่าพรบ.    "
    "ระบุผู้ขับขี่      "
    "ซ่อมห้าง   "
    "คุ้มครองอุปกรณ์เพิ่มเติม   "
    "แก้ไขที่อยู่       "
    "ผู้รับผลประโยชน์" 
    "หมายเหตุ"                           
    "complete/not complete"
    "Yes/No" 
    "เบี้ยรวม"
    "ชำระล่าสุด" 
    "Producer Code"
    "Agent Code"
    "ISP"
    "Dealer". /*A65-0115*/
    
    RUN Proc_detailreport.
  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat_old C-Win 
PROCEDURE proc_reportmat_old :
DEF VAR n_comdat AS DATE.
DEF BUFFER bftlt FOR brstat.tlt .
DEF VAR n_chk AS CHAR FORMAT "x(50)" .
DO:
        wdetail.remark = "" .
   
        IF brstat.tlt.nor_grprm <> deci(wdetail.premtnet) THEN DO:
            ASSIGN wdetail.remark = wdetail.remark + " |" + "เบี้ย " + wdetail.premtnet + " ไม่เท่าในระบบ " + STRING(brstat.tlt.nor_grprm) .
        END.
        
        ASSIGN 
            np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
            np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
            np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
            np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name
            nv_isp   = IF INDEX(tlt.OLD_cha,"ISP:") <> 0 THEN Substr(tlt.OLD_cha,index(tlt.OLD_cha,"ISP:"),index(tlt.OLD_cha,"Detail:")   - 1 ) ELSE "". /*Add By Sarinya A61-0349*/
            IF np_title = "น.ส." OR np_title = "น.ส" OR np_title = "นส." THEN np_title = "นางสาว".  /*Add By Sarinya A61-0349*/
            wdetail.remark = TRIM(wdetail.remark) + "|" + "COMPLETE" . 
               EXPORT DELIMITER "|"
                n_record                                     /*  1  ลำดับที่     */             
                string(tlt.datesent,"99/99/9999") FORMAT "x(10)"   /*  2  วันที่แจ้ง   */            
                tlt.nor_noti_tlt               /*  3  เลขรับแจ้ง   */           
                caps(TRIM(tlt.comp_usr_tlt))   /*  4  Branch       */           
                trim(tlt.recac)                /*  5  Contract     */           
                trim(np_title)                 /*  6  คำนำหน้าชื่อ */           
                trim(np_name)                  /*  7  ชื่อ         */           
                trim(np_name2)                 /*  8  นามสกุล      */           
                trim(tlt.ins_addr1)               FORMAT "x(50)"                /*  9  ที่อยู่ 1    */           
                trim(tlt.ins_addr2)               FORMAT "x(40)"                /*  10 ที่อยู่ 2    */           
                trim(tlt.ins_addr3)               FORMAT "x(40)"                /*  11 ที่อยู่ 3    */           
                trim(tlt.ins_addr4) + " " + trim(tlt.ins_addr5) FORMAT "x(40)"  /*  12 ที่อยู่ 4    */           
                brstat.tlt.brand               /*  13 ยี่ห้อรถ     */           
                brstat.tlt.model               /*  14 รุ่นรถ       */           
                brstat.tlt.lince1              /*  15 เลขทะเบียน   */           
                brstat.tlt.lince2              /*  16 ปีรถ         */           
                brstat.tlt.cc_weight           /*  17 CC.          */           
                brstat.tlt.cha_no              /*  18 เลขตัวถัง    */           
                brstat.tlt.eng_no              /*  19 เลขเครื่อง   */           
                brstat.tlt.comp_noti_tlt       /*  20 Code ผู้แจ้ง */           
                brstat.tlt.safe3               /*  21 ประเภท       */           
                brstat.tlt.nor_usr_ins         /*  22 Code บ.ประกัน        */  
                brstat.tlt.nor_noti_ins        /*  23 เลขกรมธรรม์เดิม      */ 
                brstat.tlt.safe2
                IF tlt.nor_effdat = ? THEN "" ELSE string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 วันคุ้มครองประกัน    */
                IF tlt.expodat = ? THEN "" ELSE string(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 วันหมดประกัน         */   
                tlt.comp_coamt         /*  26 ทุนประกัน    */           
                DECI(tlt.dri_name2)    /*  27 ค่าเบี้ยสุทธิ์ */         
                tlt.nor_grprm          /*  28 ค่าเบี้ยรวมภาษีอากร */    
                tlt.seqno              /*  29 Deduct       */           
                tlt.nor_usr_tlt        /*  30 Code บ.ประกัน พรบ.   */   
                IF tlt.comp_effdat = ? THEN "" ELSE string(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 วันคุ้มครองพรบ.*/   
                IF tlt.dat_ins_noti = ? THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 วันหมดพรบ.   */           
                deci(tlt.dri_no1)   /*  33 ค่าพรบ.      */           
                brstat.tlt.dri_name1       /*  34 ระบุผู้ขับขี่        */   
                IF trim(brstat.tlt.stat) = "Y" THEN "G" ELSE ""           /*  35 ซ่อมห้าง     */           
                brstat.tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
                brstat.tlt.filler1         /*  37 แก้ไขที่อยู่    */        
                brstat.tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
                brstat.tlt.OLD_cha         /*  39 หมายเหตุ */               
                brstat.tlt.OLD_eng         /*  40 complete/not complete */  
                brstat.tlt.releas          /*  41 Yes/No . */ 
                wdetail.premtnet      /*  เบี้ยรวม    */
                wdetail.recivedat    /*  ชำระล่าสุด  */
                /*IF INDEX(fi_loadname,"Plus") <> 0 THEN  "A0M0062" ELSE IF INDEX(fi_loadname,"MC_KPI") <> 0 THEN "A0M0073" ELSE "A0M0018"     /*  Producer Code */*/
                /*IF INDEX(fi_loadname,"Plus") <> 0 THEN  "A0M0062" ELSE IF INDEX(fi_loadname,"MC_KPI") <> 0 THEN "B3MLAY0105" ELSE "B3MLAY0101" /*A63-00472*/*/
                IF INDEX(fi_loadname,"Plus") <> 0 THEN  "A0M0062" ELSE IF INDEX(fi_loadname,"MC_KPI") <> 0 THEN "B3MLAY0105" ELSE "B3MLAY0101"   /*A63-00472*/
                /*fi_agent.          /*  Agent Code */--Comment Jiraphon A59-0451*/
                tlt.rec_addr4        /* Agent Code */ /*Add Jiraphon A59-0451*/
                nv_isp               /*Add By Sarinya C A61-0349*/ 
                wdetail.remark   .

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportpolicy C-Win 
PROCEDURE proc_reportpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".CSV"  THEN 
    fi_outload  =  Trim(fi_outload) + ".CSV"  .
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
 /* comment by : A65-0115..
  " ประเภทกรมธรรม์" 
   " เบอร์กรมธรรม์ "
   " รหัสอ้างอิง   "
   " รหัสลูกค้า    "
   " รหัสแคมเปญ    "
   " ชื่อแคมเปญ    "
   " ชื่อผลิตภัณฑ์ "
   " ProspectID   "
   " กรมธรรม์เดิม  "
   " คำนำหน้าชื่อ ผู้เอาประกัน "
   " ชื่อ ผู้เอาประกัน         "
   " เลขบัตรผู้เอาประกัน "
   " วันเกิดผู้เอาประกัน "
   " เบอร์โทรผู้เอาประกัน"
   " ที่อยู่จัดส่ง 1  " 
   " ที่อยู่จัดส่ง 2  " 
   " ที่อยู่จัดส่ง 3  " 
   " ที่อยู่จัดส่ง 4  " 
   " คำนำหน้าชื่อ ผู้จ่ายเงิน"
   " ชื่อ ผู้จ่ายเงิน"
   " เลขประจำตัวผู้เสียภาษี"
   " ที่อยู่ออกใบเสร็จ1"
   " ที่อยู่ออกใบเสร็จ2"
   " ที่อยู่ออกใบเสร็จ3"
   " ที่อยู่ออกใบเสร็จ4"
   " ผู้รับผลประโยชน์  "
   " ประเภทการจ่าย "
   " ช่องทางการจ่าย  "
   " ยี่ห้อ  "  
   " รุ่น    "  
   " แบบตัวถัง" 
   " ทะเบียน "
   " จังหวัดทะเบียน "
   " เลขตัวถัง" 
   " เลขเครื่อง " 
   " ปีรถ    "  
   " ซีซี    "  
   " คลาสรถ  "  
   " การซ่อม "  
   " ประเภทการประกัน "
   " รหัสการประกัน" 
   " วันที่คุ้มครอง  "
   " วันที่หมดอายุ" 
   " ทุนประกัน"
   " ทุนสูญหาย/ไฟไหม้ "
   " เบี้ยสุทธิก่อนหักส่วนลด"
   " เบี้ยสุทธิหลังหักส่วนลด"
   " สแตมป์  "
   " ภาษี    "
   " เบี้ยรวม"
   " Deduct  "
   " fleet   " 
   " ncb     " 
   " other   "   
   " cctv    "
   " ระบุผู้ขับขี่    " 
   " ชื่อผู้ขับขี่1   " 
   " เลขบัตรผู้ขับขี่1" 
   " อาชีพผู้ขับขี่1  " 
   " เพศผู้ขับขี่1    " 
   " วันเกิดผู้ขับขี่1" 
   " ชื่อผู้ขับขี่2   " 
   " เลขบัตรผู้ขับขี่2" 
   " อาชีพผู้ขับขี่2  " 
   " เพศผู้ขับขี่2    " 
   " วันเกิดผู้ขับขี่2" 
   " รายละเอียดอุปกรณ์1"
   " ราคาอุปกรณ์1  "
   " รายละเอียดอุปกรณ์2"
   " ราคาอุปกรณ์2  "
   " รายละเอียดอุปกรณ์3"
   " ราคาอุปกรณ์3  "
   " รายละเอียดอุปกรณ์4"
   " ราคาอุปกรณ์4  "
   " รายละเอียดอุปกรณ์5"
   " ราคาอุปกรณ์5  "
   " วันที่ตรวจสภาพ"
   " ชื่อผู้ตรวจสภาพ "
   " เบอร์โทรตรวจสภาพ "
   " สถานที่ตรวจสภาพ "
   " รายละเอียดการตรวจสภาพ"
   " วันที่ขาย"
   " วันที่รับชำระเงิน"
   " รายละเอียดการจัดส่ง "
   " Agent name  "
   " หมายเหตุ" 
   " เลขตรวจสภาพ "
   " ผลการตรวจ "
   " ความเสียหาย1 "
   " ความเสียหาย2 "
   " ความเสียหาย3 "
   " ข้อมูลอื่นๆ " 
   " กธ. จาก AY "
   " Producer code "
   " Agent Code "
   " Branch STY " .
 ..end A65-0115...*/ 
/*add by : A65-0115*/
   " ประเภทกรมธรรม์" 
   " กธ. จาก AY "
   " วันที่ขาย"
   " วันที่รับชำระเงิน"
   " เบอร์กรมธรรม์ "
   " Producer code "
   " Agent Code "
   " Dealer code " 
   " รหัสอ้างอิง   "
   " รหัสลูกค้า    "
   " รหัสแคมเปญ    "
   " ชื่อแคมเปญ    "
   " ชื่อผลิตภัณฑ์ "
   " ProspectID   "
   " กรมธรรม์เดิม  "
   " คำนำหน้าชื่อ ผู้เอาประกัน "
   " ชื่อ ผู้เอาประกัน         "
   " เลขบัตรผู้เอาประกัน "
   " วันเกิดผู้เอาประกัน "
   " เบอร์โทรผู้เอาประกัน"
   " ที่อยู่จัดส่ง 1  " 
   " ที่อยู่จัดส่ง 2  " 
   " ที่อยู่จัดส่ง 3  " 
   " ที่อยู่จัดส่ง 4  " 
   " คำนำหน้าชื่อ ผู้จ่ายเงิน"
   " ชื่อ ผู้จ่ายเงิน"
   " เลขประจำตัวผู้เสียภาษี"
   " ที่อยู่ออกใบเสร็จ1"
   " ที่อยู่ออกใบเสร็จ2"
   " ที่อยู่ออกใบเสร็จ3"
   " ที่อยู่ออกใบเสร็จ4"
   " ผู้รับผลประโยชน์  "
   " ประเภทการจ่าย "
   " ช่องทางการจ่าย  "
   " ยี่ห้อ  "  
   " รุ่น    "  
   " แบบตัวถัง" 
   " ทะเบียน "
   " จังหวัดทะเบียน "
   " เลขตัวถัง" 
   " เลขเครื่อง " 
   " ปีรถ    "  
   " ซีซี    "  
   " คลาสรถ  "  
   " การซ่อม "  
   " ประเภทการประกัน "
   " รหัสการประกัน" 
   " วันที่คุ้มครอง  "
   " วันที่หมดอายุ" 
   " ทุนประกัน"
   " ทุนสูญหาย/ไฟไหม้ "
   " เบี้ยสุทธิก่อนหักส่วนลด"
   " เบี้ยสุทธิหลังหักส่วนลด"
   " สแตมป์  "
   " ภาษี    "
   " เบี้ยรวม"
   " Deduct  "
   " fleet   " 
   " ncb     " 
   " other   "   
   " cctv    "
   " ระบุผู้ขับขี่    " 
   " ชื่อผู้ขับขี่1   " 
   " เลขบัตรผู้ขับขี่1" 
   " อาชีพผู้ขับขี่1  " 
   " เพศผู้ขับขี่1    " 
   " วันเกิดผู้ขับขี่1" 

   " ชื่อผู้ขับขี่2   " 
   " เลขบัตรผู้ขับขี่2" 
   " อาชีพผู้ขับขี่2  " 
   " เพศผู้ขับขี่2    " 
   " วันเกิดผู้ขับขี่2" 

   " รายละเอียดอุปกรณ์1"
   " ราคาอุปกรณ์1  "
   " รายละเอียดอุปกรณ์2"
   " ราคาอุปกรณ์2  "
   " รายละเอียดอุปกรณ์3"
   " ราคาอุปกรณ์3  "
   " รายละเอียดอุปกรณ์4"
   " ราคาอุปกรณ์4  "
   " รายละเอียดอุปกรณ์5"
   " ราคาอุปกรณ์5  "
   " วันที่ตรวจสภาพ"
   " ชื่อผู้ตรวจสภาพ "
   " เบอร์โทรตรวจสภาพ "
   " สถานที่ตรวจสภาพ "
   " รายละเอียดการตรวจสภาพ"
   " รายละเอียดการจัดส่ง "
   " Agent name  "
   " หมายเหตุ" 
   " เลขตรวจสภาพ "
   " ผลการตรวจ "
   " ความเสียหาย1 "
   " ความเสียหาย2 "
   " ความเสียหาย3 "
   " ข้อมูลอื่นๆ " 
   " Branch STY " .
 /*..end A65-0115...*/
   RUN proc_detailpolicy.

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report_policy C-Win 
PROCEDURE proc_report_policy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Add by : A65-0115     
------------------------------------------------------------------------------*/
def var nv_row     as int init 0 .
def var nv_column  as int init 0 .

DO:
   If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".XLS"  THEN fi_outload  =  Trim(fi_outload) + ".XLS"  .

  nv_row    =  0.
  nv_column =  0.
  OUTPUT STREAM ns1 TO VALUE(fi_outload) .
       PUT STREAM ns1 "ID;PND" SKIP.        
       ASSIGN 
           nv_row    = nv_row    + 1.
           nv_column = nv_column + 1.
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "INSURANCE "                  '"' SKIP.     nv_column = nv_column + 1.      /*1 */                               
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "YEAR      "                  '"' SKIP.     nv_column = nv_column + 1.      /*2 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "PRODUCT   "                  '"' SKIP.     nv_column = nv_column + 1.      /*3 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "BRANCH    "                  '"' SKIP.     nv_column = nv_column + 1.      /*4 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "CONTRACT  "                  '"' SKIP.     nv_column = nv_column + 1.      /*5 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "NAME      "                  '"' SKIP.     nv_column = nv_column + 1.      /*6 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "เลขรับแจ้ง"                  '"' SKIP.     nv_column = nv_column + 1.      /*7 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ทะเบียน"                     '"' SKIP.     nv_column = nv_column + 1.      /*8 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "จังหวัด"                     '"' SKIP.     nv_column = nv_column + 1.      /*9 */                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "BODY  "                      '"' SKIP.     nv_column = nv_column + 1.      /*10*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ENGINE"                      '"' SKIP.     nv_column = nv_column + 1.      /*11*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "วันคุ้มครอง"                 '"' SKIP.     nv_column = nv_column + 1.      /*12*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "เบี้ยรวม"                    '"' SKIP.     nv_column = nv_column + 1.      /*13*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ชำระล่าสุด"                  '"' SKIP.     nv_column = nv_column + 1.      /*14*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "เลขกรมธรรม์"                 '"' SKIP.     nv_column = nv_column + 1.      /*15*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "ทุนประกัน  "                 '"' SKIP.     nv_column = nv_column + 1.      /*16*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "วันคุ้มครอง"                 '"' SKIP.     nv_column = nv_column + 1.      /*17*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "วันสิ้นสุด "                 '"' SKIP.     nv_column = nv_column + 1.      /*18*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "เบี้ยสุทธิ "                 '"' SKIP.     nv_column = nv_column + 1.      /*19*/                             
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "เบี้ยรวม   "                 '"' SKIP.     nv_column = nv_column + 1.      /*20*/ 
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"' "เหตุผลที่ยังไม่ออกกรมธรรม์"  '"' SKIP.     nv_column = nv_column + 1.      /*21*/      
        
        FOR EACH wdetail NO-LOCK.
            ASSIGN nv_column = 0
                   nv_column = nv_column + 1 
                   nv_row    = nv_row  + 1.
            
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.Codecompany   '"' SKIP.     nv_column = nv_column + 1.      /*1 */     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.renew         '"' SKIP.     nv_column = nv_column + 1.      /*2 */     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.product       '"' SKIP.     nv_column = nv_column + 1.      /*3 */     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.Branch        '"' SKIP.     nv_column = nv_column + 1.      /*4 */     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.Contract      '"' SKIP.     nv_column = nv_column + 1.      /*5 */     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.name1         '"' SKIP.     nv_column = nv_column + 1.      /*6 */     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.policy        '"' SKIP.     nv_column = nv_column + 1.      /*7 */     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.vehreg        '"' SKIP.     nv_column = nv_column + 1.      /*8 */     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.provin        '"' SKIP.     nv_column = nv_column + 1.      /*9 */     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.chassis       '"' SKIP.     nv_column = nv_column + 1.      /*10*/     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.engno         '"' SKIP.     nv_column = nv_column + 1.      /*11*/     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.comdat70      '"' SKIP.     nv_column = nv_column + 1.      /*12*/     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.premtnet      '"' SKIP.     nv_column = nv_column + 1.      /*13*/     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.recivedat     '"' SKIP.     nv_column = nv_column + 1.      /*14*/     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.polno         '"' SKIP.     nv_column = nv_column + 1.      /*15*/     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.polsi         '"' SKIP.     nv_column = nv_column + 1.      /*16*/     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.polcomdat     '"' SKIP.     nv_column = nv_column + 1.      /*17*/     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.polexpdat     '"' SKIP.     nv_column = nv_column + 1.      /*18*/     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.polnetprm     '"' SKIP.     nv_column = nv_column + 1.      /*19*/     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.poltotalprm   '"' SKIP.     nv_column = nv_column + 1.      /*20*/     
            PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_column) ";K" '"'   wdetail.comment       '"' SKIP.     nv_column = nv_column + 1.      /*21*/                                                                                                                                 
        END.
    PUT STREAM ns1 "E" SKIP.
    OUTPUT STREAM ns1 CLOSE.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

