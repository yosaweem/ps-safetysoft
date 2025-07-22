&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_bran         PROGRESS
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
program id   : wgwquay5.w
program name : Query & Update Data Aycl
               Import text file from  Aycal 
Create  by   : Kridtiya i. [A58-0301]   On   21/08/2015
Connect      : GW_SAFE LD SIC_BRAN, GW_STAT LD BRSTAT ,SICSYAC,SICUW ; Stat]
+++++++++++++++++++++++++++++++++++++++++++++++*/

/* DEFINE  VAR nv_rectlt    as recid init  0.                                                                                */
/* DEFINE  VAR nv_recidtlt  as recid init  0.                                                                                */
/* DEF  STREAM ns2.                                                                                                          */
/* DEFINE  VAR nv_cnt       as int   init  1.                                                                                */
/* DEFINE  VAR nv_row       as int   init  0.                                                                                */
/* DEFINE  VAR n_record     AS INTE  INIT  0.                                                                                */
/* DEFINE  VAR n_comname    AS CHAR  INIT  "".                                                                               */
/* DEFINE  VAR n_asdat      AS CHAR.                                                                                         */
/* DEFINE  VAR vAcProc_fil  AS CHAR.                                                                                         */
/* DEFINE  VAR vAcProc_fil2 AS CHAR.                                                                                         */
/* DEFINE  VAR n_asdat2     AS CHAR.                                                                                         */

 DEFINE  WORKFILE wdetail NO-UNDO                                                                                         
     FIELD   RecordType           AS CHAR FORMAT "X(1)"  INIT ""   /*1 Record Type */                        
     FIELD   Sequenceno           AS CHAR FORMAT "X(5)"  INIT ""   /*2 Sequence no.    */                    
     FIELD   Company              AS CHAR FORMAT "X(5)"  INIT ""   /*3 Company     */                        
     FIELD   Product              AS CHAR FORMAT "X(20)" INIT ""   /*4 Product */                            
     FIELD   Branch               AS CHAR FORMAT "X(20)" INIT ""   /*5 Branch  */                            
     FIELD   Contractnumber       AS CHAR FORMAT "X(7)"  INIT ""   /*6 Contract number */                    
     FIELD   Dealercode           AS CHAR FORMAT "X(5)"  INIT ""   /*7 Dealer  code    */                    
     FIELD   CustomerTitleName    AS CHAR FORMAT "X(10)" INIT ""   /*8 Customer Title Name */                
     FIELD   CustomerFirstName    AS CHAR FORMAT "X(25)" INIT ""   /*9 Customer First Name / Company Name  */
     FIELD   CustomerLastName     AS CHAR FORMAT "X(65)" INIT ""   /*10    Customer Last Name  */            
     FIELD   CustomerAddress1     AS CHAR FORMAT "X(50)" INIT ""   /*11    Customer Address1   */            
     FIELD   CustomerAddress2     AS CHAR FORMAT "X(50)" INIT ""   /*12    Customer Address2   */            
     FIELD   CustomerAddress3     AS CHAR FORMAT "X(20)" INIT ""   /*13    Customer Address3   */            
     FIELD   ZipCode              AS CHAR FORMAT "X(5)"  INIT ""   /*14    Zip Code    */                    
     FIELD   Flag                 AS CHAR FORMAT "X(5)"  INIT ""   /*15    Flag เปลี่ยนที่อยู่     */        
     FIELD   Brand                AS CHAR FORMAT "X(3)"  INIT ""   /*16    Brand   */                        
     FIELD   Model                AS CHAR FORMAT "X(15)" INIT ""   /*17    Model   */                        
     FIELD   nColor               AS CHAR FORMAT "X(25)" INIT ""   /*18    Color   */                        
     FIELD   LicenceNo            AS CHAR FORMAT "X(10)" INIT ""   /*19    Licence No.     */                
     FIELD   LicenceProvince      AS CHAR FORMAT "X(20)" INIT ""   /*20    Licence (Province)  */            
     FIELD   nYear                AS CHAR FORMAT "X(4)"  INIT ""   /*21    Year    */                        
     FIELD   CC                   AS CHAR FORMAT "X(5)"  INIT ""   /*22    C.C.    */                        
     FIELD   ChassisNo            AS CHAR FORMAT "X(22)" INIT ""   /*23    Chassis No.     */                
     FIELD   EngineNo             AS CHAR FORMAT "X(22)" INIT ""   /*24    Engine No.  */                    
     FIELD   Code_sendby          AS CHAR FORMAT "X(5)"  INIT ""   /*25    Code ผู้แจ้ง    */                
     FIELD   insuranceType        AS CHAR FORMAT "X(1)"  INIT ""   /*26    insurance Type  */                
     FIELD   InsInsurer           AS CHAR FORMAT "X(4)"  INIT ""   /*27    Ins. Insurer    */                
     FIELD   INSPolicyNo          AS CHAR FORMAT "X(20)" INIT ""   /*28    INS. Policy No. */                
     FIELD   comdat               AS CHAR FORMAT "X(8)"  INIT ""   /*29    วันเริ่มคุ้มครอง    */            
     FIELD   expdat               AS CHAR FORMAT "X(8)"  INIT ""   /*30    วันสิ้นสุดคุ้มครอง  */            
     FIELD   SumInsured           AS CHAR FORMAT "X(13)" INIT ""   /*31    Sum Insured */                    
     FIELD   NetINSPrm            AS CHAR FORMAT "X(13)" INIT ""   /*32    Net.INS.Prm */                    
     FIELD   TotalINSPrm          AS CHAR FORMAT "X(13)" INIT ""   /*33    Total.INS.Prm   */                
     FIELD   premiumrecive        AS CHAR FORMAT "X(11)" INIT ""   /*34    เบี้ยรัยจากลูกค้า   */            
     FIELD   yearunwrite          AS CHAR FORMAT "X(1)"  INIT ""   /*35    ปีประกัน    */                    
     FIELD   notifyno             AS CHAR FORMAT "X(15)" INIT ""   /*36    เลขรับแจ้ง  */                    
     FIELD   codejob              AS CHAR FORMAT "X(1)"  INIT ""   /*37    รหัสงาน */                        
     FIELD   firstsentdate        AS CHAR FORMAT "X(8)"  INIT ""   /*38    first sent date */                
     FIELD   InsuranceYearNo      AS CHAR FORMAT "X(50)" INIT ""   /*39    Insurance  Year No. */            
     FIELD   Taxation             AS CHAR FORMAT "X(9)"  INIT "".   /*40    Taxation    */ 
 DEFINE  WORKFILE wdetail2 NO-UNDO           
     FIELD   RecordType           AS CHAR FORMAT "X(1)"  INIT ""   /*1 Record Type */                        
     FIELD   Sequenceno           AS CHAR FORMAT "X(5)"  INIT ""   /*2 Sequence no.    */   
     FIELD   Policy               AS CHAR FORMAT "X(5)"  INIT ""   /*2 Sequence no.    */   
     FIELD   comment1             AS CHAR FORMAT "X(50)" INIT ""   /*1 Record Type */                        
     FIELD   comment2             AS CHAR FORMAT "X(50)" INIT ""   /*2 Sequence no.    */ 
     FIELD   comment3             AS CHAR FORMAT "X(50)" INIT ""   /*2 Sequence no.    */ 
     FIELD   comment4             AS CHAR FORMAT "X(50)" INIT ""   /*2 Sequence no.    */ .
DEF VAR nv_agentgpstmt            AS CHAR FORMAT "X(150)" INIT ""    .
DEF VAR nvTotalINSPrm             AS DECI FORMAT ">>>,>>>,>>9.99" INIT 0.
DEF VAR nvpremiumrecive           AS DECI FORMAT ">>>,>>>,>>9.99" INIT 0.  
DEF VAR nvnetdep                  AS DECI FORMAT ">>>,>>>,>>9.99" INIT 0.  
DEF VAR nvlimit                   AS DECI FORMAT ">>>,>>>,>>9.99" INIT 0.  
DEF VAR nv_checkstatus            AS LOGICAL  INIT NO    .
DEF VAR nv_Policy                 AS CHAR FORMAT "X(40)"  INIT "" .  /*2 Sequence no.    */   
DEF VAR nv_comment1               AS CHAR FORMAT "X(100)" INIT "" .  /*1 Record Type */                        
DEF VAR nv_comment2               AS CHAR FORMAT "X(100)" INIT "" .  /*2 Sequence no.    */ 
DEF VAR nv_comment3               AS CHAR FORMAT "X(100)" INIT "" .  /*2 Sequence no.    */ 
DEF VAR nv_comment4               AS CHAR FORMAT "X(100)" INIT "" .  /*2 Sequence no.    */ 

 
 /* DEF VAR nv_countdata     AS DECI INIT 0.                                                                                  */
/* DEF VAR nv_countcomplete AS DECI INIT 0.                                                                                  */
/* DEF VAR np_addr1     AS CHAR FORMAT "x(256)"    INIT "" .                                                                 */
/* DEF VAR np_addr2     AS CHAR FORMAT "x(40)"     INIT "" .                                                                 */
/* DEF VAR np_addr3     AS CHAR FORMAT "x(40)"     INIT "" .                                                                 */
/* DEF VAR np_addr4     AS CHAR FORMAT "x(40)"     INIT "" .                                                                 */
/* DEF VAR np_title     AS CHAR FORMAT "x(30)"     INIT "" .                                                                 */
/* DEF VAR np_name      AS CHAR FORMAT "x(40)"     INIT "" .                                                                 */
/* DEF VAR np_name2     AS CHAR FORMAT "x(40)"     INIT "" .                                                                 */
/* DEF VAR nv_outfile   AS CHAR FORMAT "x(256)"    INIT "" .                                                                 */
/* DEFINE  WORKFILE wdetailUP NO-UNDO                                                                                        */
/*     FIELD        PolicyUP  AS CHAR FORMAT "X(20)"  INIT ""                                                                */
/*     FIELD        Company   AS CHAR FORMAT "X(20)"  INIT "".                                                               */
/*                                                                                                                           */
/*                                                                                                                           */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_wdetail

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wdetail

/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.RecordType wdetail.Sequenceno wdetail.Company wdetail.Product wdetail.Branch wdetail.Contractnumber wdetail.Dealercode wdetail.CustomerTitleName wdetail.CustomerFirstName wdetail.CustomerLastName wdetail.CustomerAddress1 wdetail.CustomerAddress2 wdetail.CustomerAddress3 wdetail.ZipCode wdetail.Flag wdetail.Brand wdetail.Model wdetail.nColor wdetail.LicenceNo wdetail.LicenceProvince wdetail.nYear wdetail.CC wdetail.ChassisNo wdetail.EngineNo wdetail.Code_sendby wdetail.insuranceType wdetail.InsInsurer wdetail.INSPolicyNo wdetail.comdat wdetail.expdat wdetail.SumInsured wdetail.NetINSPrm wdetail.TotalINSPrm wdetail.premiumrecive wdetail.yearunwrite wdetail.notifyno wdetail.codejob wdetail.firstsentdate wdetail.InsuranceYearNo wdetail.Taxation   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail NO-LOCK
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_wdetail FOR EACH wdetail NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_wdetail fi_gropro fi_limit fi_process ~
bu_mat ra_customername fi_codejob fi_inputfile fi_outfilename bu_reok ~
bu_file bu_imp ra_chassisno ra_notifyay ra_underwriteyear ra_caseprem ~
bu_exit2 ra_producer fi_producer RECT-494 RECT-499 RECT-503 RECT-504 ~
RECT-505 RECT-506 RECT-507 RECT-508 
&Scoped-Define DISPLAYED-OBJECTS fi_gropro fi_limit fi_process ~
ra_customername fi_codejob fi_inputfile fi_outfilename ra_chassisno ~
ra_notifyay ra_underwriteyear ra_caseprem ra_producer fi_producer 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit2 
     LABEL "EXIT" 
     SIZE 8 BY .95.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_imp 
     LABEL "IMP" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_mat 
     LABEL "MATCH" 
     SIZE 12 BY 1.

DEFINE BUTTON bu_reok 
     LABEL "OK" 
     SIZE 8 BY .95.

DEFINE VARIABLE fi_codejob AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_gropro AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_inputfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 80 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_limit AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfilename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67.67 BY 1
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE ra_caseprem AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "เบี้ย=0", 1,
"เบี้ยรับ=เบี้ยรวม", 2,
"เบี้ยรับ<=เบี้ยรวมไม่เกินLimit", 3,
"All", 4
     SIZE 61.5 BY .95
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_chassisno AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2
     SIZE 15 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_customername AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2
     SIZE 15 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_notifyay AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2
     SIZE 15 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_producer AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Group Code", 1,
"Producer", 2
     SIZE 15 BY 2
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_underwriteyear AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "1", 1,
"> 1", 2
     SIZE 15 BY .95
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-494
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 2
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-499
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 8.5 BY 1.52
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-503
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 10.05
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-504
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 50 BY 3.52.

DEFINE RECTANGLE RECT-505
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 80 BY 3.52.

DEFINE RECTANGLE RECT-506
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 12 BY 1.52
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-507
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 11 BY 1.52
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-508
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 15 BY 1.91
     BGCOLOR 3 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-wins _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.RecordType            COLUMN-LABEL "Record Type"                         
     wdetail.Sequenceno            COLUMN-LABEL "Sequence no."                        
     wdetail.Company               COLUMN-LABEL "Company "                            
     wdetail.Product               COLUMN-LABEL "Product"                             
     wdetail.Branch                COLUMN-LABEL "Branch"                              
     wdetail.Contractnumber        COLUMN-LABEL "Contract number"                     
     wdetail.Dealercode            COLUMN-LABEL "Dealer  code"                        
     wdetail.CustomerTitleName     COLUMN-LABEL "Customer Title Name"                 
     wdetail.CustomerFirstName     COLUMN-LABEL "Customer First Name / Company Name " 
     wdetail.CustomerLastName      COLUMN-LABEL "Customer Last Name "                 
     wdetail.CustomerAddress1      COLUMN-LABEL "Customer Address1"                   
     wdetail.CustomerAddress2      COLUMN-LABEL "Customer Address2"                   
     wdetail.CustomerAddress3      COLUMN-LABEL "Customer Address3"                   
     wdetail.ZipCode               COLUMN-LABEL "Zip Code"                            
     wdetail.Flag                  COLUMN-LABEL "Flag เปลี่ยนที่อยู่ "                
     wdetail.Brand                 COLUMN-LABEL "Brand "                              
     wdetail.Model                 COLUMN-LABEL "Model "                              
     wdetail.nColor                COLUMN-LABEL "Color"                               
     wdetail.LicenceNo             COLUMN-LABEL "Licence No. "                        
     wdetail.LicenceProvince       COLUMN-LABEL "Licence (Province)"                  
     wdetail.nYear                 COLUMN-LABEL "Year "                               
     wdetail.CC                    COLUMN-LABEL "C.C. "                               
     wdetail.ChassisNo             COLUMN-LABEL "Chassis No. "                        
     wdetail.EngineNo              COLUMN-LABEL "Engine No. "                         
     wdetail.Code_sendby           COLUMN-LABEL "Code ผู้แจ้ง"                        
     wdetail.insuranceType         COLUMN-LABEL "insurance Type"                      
     wdetail.InsInsurer            COLUMN-LABEL "Ins. Insurer"                        
     wdetail.INSPolicyNo           COLUMN-LABEL "INS. Policy No."                     
     wdetail.comdat                COLUMN-LABEL "วันเริ่มคุ้มครอง"                    
     wdetail.expdat                COLUMN-LABEL "วันสิ้นสุดคุ้มครอง"                  
     wdetail.SumInsured            COLUMN-LABEL "Sum Insured"                         
     wdetail.NetINSPrm             COLUMN-LABEL "Net.INS.Prm"                         
     wdetail.TotalINSPrm           COLUMN-LABEL "Total.INS.Prm"                       
     wdetail.premiumrecive         COLUMN-LABEL "เบี้ยรัยจากลูกค้า"                   
     wdetail.yearunwrite           COLUMN-LABEL "ปีประกัน"                            
     wdetail.notifyno              COLUMN-LABEL "เลขรับแจ้ง"                          
     wdetail.codejob               COLUMN-LABEL "รหัสงาน"                             
     wdetail.firstsentdate         COLUMN-LABEL "first sent date"                     
     wdetail.InsuranceYearNo       COLUMN-LABEL "Insurance  Year No."                 
     wdetail.Taxation              COLUMN-LABEL "Taxation"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132 BY 11.52
         BGCOLOR 15 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_wdetail AT ROW 13.29 COL 1
     fi_gropro AT ROW 4.43 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_limit AT ROW 8.91 COL 68.67 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 11.62 COL 2.83 NO-LABEL
     bu_mat AT ROW 7.67 COL 36
     ra_customername AT ROW 6.76 COL 16 NO-LABEL
     fi_codejob AT ROW 3.38 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_inputfile AT ROW 1.43 COL 20 COLON-ALIGNED NO-LABEL
     fi_outfilename AT ROW 10.29 COL 68.5 COLON-ALIGNED NO-LABEL
     bu_reok AT ROW 11.76 COL 111.67
     bu_file AT ROW 1.43 COL 102.67
     bu_imp AT ROW 1.43 COL 107.5
     ra_chassisno AT ROW 7.86 COL 16 NO-LABEL
     ra_notifyay AT ROW 8.91 COL 16 NO-LABEL
     ra_underwriteyear AT ROW 6.76 COL 70.5 NO-LABEL
     ra_caseprem AT ROW 7.86 COL 70.5 NO-LABEL
     bu_exit2 AT ROW 11.76 COL 123.67
     ra_producer AT ROW 4.43 COL 2 NO-LABEL
     fi_producer AT ROW 5.43 COL 15.5 COLON-ALIGNED NO-LABEL
     "            ปีประกัน:" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 6.76 COL 54
          BGCOLOR 18 FONT 6
     "  Report By :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 5.52 COL 70
          BGCOLOR 18 FONT 6
     "  เบี้ยรับจากลูกค้า:" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 7.86 COL 54
          BGCOLOR 18 FONT 6
     "               Limit:" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 8.91 COL 54
          BGCOLOR 18 FONT 6
     "           รหัสงาน:" VIEW-AS TEXT
          SIZE 15 BY .91 AT ROW 3.38 COL 2
          BGCOLOR 18 FONT 6
     "     ชื่อลูกค้า:" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 6.76 COL 3.5
          BGCOLOR 18 FONT 6
     "    เลขตัวถัง:" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 7.86 COL 3.5
          BGCOLOR 18 FONT 6
     " Blank = AYCAL, Y = Dealer" VIEW-AS TEXT
          SIZE 26.5 BY .91 AT ROW 3.38 COL 23.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Out Put File :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 10.29 COL 54
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " Import File Name :" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 1.43 COL 2.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "  เลขรับแจ้ง:" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 8.91 COL 3.5
          BGCOLOR 18 FONT 6
     RECT-494 AT ROW 1 COL 1
     RECT-499 AT ROW 8.38 COL 121
     RECT-503 AT ROW 3.1 COL 1
     RECT-504 AT ROW 6.52 COL 2
     RECT-505 AT ROW 6.52 COL 52.83
     RECT-506 AT ROW 11.48 COL 109.5
     RECT-507 AT ROW 11.48 COL 122
     RECT-508 AT ROW 7.19 COL 34.5
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
  CREATE WINDOW c-wins ASSIGN
         HIDDEN             = YES
         TITLE              = "Query && Update [DATA BY AYCL]"
         HEIGHT             = 24.14
         WIDTH              = 133.67
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
IF NOT c-wins:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
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
/* BROWSE-TAB br_wdetail 1 fr_main */
ASSIGN 
       br_wdetail:SEPARATOR-FGCOLOR IN FRAME fr_main      = 15.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_process IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
THEN c-wins:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_wdetail FOR EACH wdetail NO-LOCK.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [DATA BY AYCL] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [DATA BY AYCL] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_wdetail
&Scoped-define SELF-NAME br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_wdetail c-wins
ON ROW-DISPLAY OF br_wdetail IN FRAME fr_main
DO:
  DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    
        wdetail.RecordType       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.Sequenceno       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.Company          :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.Product          :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.Branch           :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.Contractnumber   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.Dealercode       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.CustomerTitleName:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.CustomerFirstName:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.CustomerLastName :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.CustomerAddress1 :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.CustomerAddress2 :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.CustomerAddress3 :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.ZipCode          :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.Flag             :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.Brand            :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.Model            :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.nColor           :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.LicenceNo        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.LicenceProvince  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.nYear            :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.CC               :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.ChassisNo        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.EngineNo         :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.Code_sendby      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.insuranceType    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.InsInsurer       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.INSPolicyNo      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.comdat           :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.expdat           :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.SumInsured       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.NetINSPrm        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.TotalINSPrm      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.premiumrecive    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.yearunwrite      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.notifyno         :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.codejob          :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.firstsentdate    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.InsuranceYearNo  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.Taxation         :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 



        
        wdetail.RecordType       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.Sequenceno       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.Company          :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.Product          :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.Branch           :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.Contractnumber   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.Dealercode       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.CustomerTitleName:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.CustomerFirstName:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.CustomerLastName :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.CustomerAddress1 :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.CustomerAddress2 :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.CustomerAddress3 :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.ZipCode          :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.Flag             :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.Brand            :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.Model            :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.nColor           :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.LicenceNo        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.LicenceProvince  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.nYear            :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.CC               :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.ChassisNo        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.EngineNo         :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.Code_sendby      :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.insuranceType    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.InsInsurer       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.INSPolicyNo      :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.comdat           :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.expdat           :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.SumInsured       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.NetINSPrm        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.TotalINSPrm      :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.premiumrecive    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.yearunwrite      :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.notifyno         :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.codejob          :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.firstsentdate    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.InsuranceYearNo  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.Taxation         :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit2 c-wins
ON CHOOSE OF bu_exit2 IN FRAME fr_main /* EXIT */
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
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Documents" "*.txt"
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        fi_inputfile  = cvData.
        DISP fi_inputfile WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imp c-wins
ON CHOOSE OF bu_imp IN FRAME fr_main /* IMP */
DO:
    IF  fi_inputfile = "" THEN DO:
        MESSAGE "please input file name ...........!!!" VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_inputfile.
        Return no-apply.
    END.
    ELSE DO:
        FOR EACH  wdetail :
            DELETE  wdetail.
        END.
        INPUT FROM VALUE(fi_inputfile).
        REPEAT:
            CREATE wdetail.
            IMPORT DELIMITER "|" 
                wdetail.RecordType
                wdetail.Sequenceno       
                wdetail.Company          
                wdetail.Product          
                wdetail.Branch           
                wdetail.Contractnumber   
                wdetail.Dealercode       
                wdetail.CustomerTitleName
                wdetail.CustomerFirstName
                wdetail.CustomerLastName 
                wdetail.CustomerAddress1 
                wdetail.CustomerAddress2 
                wdetail.CustomerAddress3 
                wdetail.ZipCode          
                wdetail.Flag             
                wdetail.Brand            
                wdetail.Model            
                wdetail.nColor           
                wdetail.LicenceNo        
                wdetail.LicenceProvince  
                wdetail.nYear            
                wdetail.CC               
                wdetail.ChassisNo        
                wdetail.EngineNo         
                wdetail.Code_sendby      
                wdetail.insuranceType    
                wdetail.InsInsurer       
                wdetail.INSPolicyNo      
                wdetail.comdat           
                wdetail.expdat           
                wdetail.SumInsured       
                wdetail.NetINSPrm        
                wdetail.TotalINSPrm      
                wdetail.premiumrecive    
                wdetail.yearunwrite      
                wdetail.notifyno         
                wdetail.codejob          
                wdetail.firstsentdate    
                wdetail.InsuranceYearNo  
                wdetail.Taxation  . 
            ASSIGN fi_process = "Create Data ..." + wdetail.Sequenceno + " " + wdetail.notifyno  .
            DISP fi_process WITH FRAM fr_main.
        END.  /* REPEAT: */
        RUN proc_cutpolicy .
        ASSIGN fi_process = "Load  Data Complete".
        DISP fi_process WITH FRAM fr_main.
        Run Open_tlt.
        Message "Load  Data Complete "  SKIP
            /*
            "จำนวนข้อมูลทั้งหมด  "  nv_countdata    SKIP
            "จำนวนข้อมูลที่นำเข้า  "  nv_countcomplete*/     View-as alert-box.  
    END.
    RUN Pro_openQuery.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_mat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_mat c-wins
ON CHOOSE OF bu_mat IN FRAME fr_main /* MATCH */
DO:
    ASSIGN nv_agentgpstmt = "".
    IF ra_producer = 1 THEN DO:
        FOR EACH  sicsyac.xmm600 USE-INDEX xmm60009    WHERE 
            sicsyac.xmm600.gpstmt = TRIM(fi_gropro)    NO-LOCK .
            ASSIGN nv_agentgpstmt = nv_agentgpstmt  + sicsyac.xmm600.acno + " " . 
        END.
    END.
    ELSE nv_agentgpstmt = trim(fi_producer) .

    FOR EACH wdetail WHERE 
        wdetail.RecordType  = "D"               AND 
        wdetail.INSPolicyNo = ""                AND
        wdetail.codejob     = trim(fi_codejob)  NO-LOCK .
        ASSIGN 
            nv_checkstatus  = NO 
            fi_process      = "Match Data ..." + wdetail.Sequenceno + " " + wdetail.notifyno  .
        DISP fi_process WITH FRAM fr_main.
        IF   wdetail.notifyno <> "" THEN DO:  /* case มีเลขรับแจ้ง */ 
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                sicuw.uwm100.policy =  wdetail.notifyno   AND 
                sicuw.uwm100.poltyp = "V70"               NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                ASSIGN nv_checkstatus = YES.
                FIND LAST wdetail2 WHERE 
                    wdetail2.RecordType = wdetail.RecordType  AND 
                    wdetail2.Sequenceno = wdetail.Sequenceno  NO-ERROR NO-WAIT.
                IF NOT AVAIL wdetail2 THEN DO:
                    CREATE wdetail2.
                    ASSIGN 
                        wdetail2.RecordType = wdetail.RecordType  
                        wdetail2.Sequenceno = wdetail.Sequenceno  
                        wdetail2.Policy     = sicuw.uwm100.policy   .
                    IF INDEX(nv_agentgpstmt,TRIM(sicuw.uwm100.acno1)) = 0 THEN  
                        ASSIGN wdetail2.comment2   = "รหัส Code ไม่ตรง:" + sicuw.uwm100.acno1 .  
                    ELSE DO:
                        IF sicuw.uwm100.releas  = NO THEN ASSIGN wdetail2.comment1   = "Policy Not Release"    .
                        IF trim(sicuw.uwm100.name1)  = trim(wdetail.CustomerFirstName) + " " + TRIM(wdetail.CustomerLastName) THEN ASSIGN wdetail2.comment3   = "ชื่อไม่ตรง".
                        FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE
                            sicuw.uwm301.policy     = sicuw.uwm100.policy NO-LOCK NO-WAIT NO-ERROR.
                        IF  AVAIL sicuw.uwm301  THEN DO:
                            IF sicuw.uwm301.cha_no <> trim(wdetail.ChassisNo) THEN
                                ASSIGN wdetail2.comment4   = "เลขตัวถังไม่ตรง" .
                        END.
                    END.
                END.
                ELSE DO: 
                    ASSIGN wdetail2.Policy  = trim(wdetail2.Policy + " " + sicuw.uwm100.policy)  .
                    IF INDEX(nv_agentgpstmt,TRIM(sicuw.uwm100.acno1)) = 0 THEN  
                        ASSIGN wdetail2.comment2   = "รหัส Code ไม่ตรง:" + sicuw.uwm100.acno1 .  
                    ELSE DO:
                        IF sicuw.uwm100.releas  = NO THEN ASSIGN wdetail2.comment1   = "Policy Not Release"    .
                        IF trim(sicuw.uwm100.name1)  = trim(wdetail.CustomerFirstName) + " " + TRIM(wdetail.CustomerLastName) THEN ASSIGN wdetail2.comment3   = "ชื่อไม่ตรง".
                        FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE
                            sicuw.uwm301.policy     = sicuw.uwm100.policy NO-LOCK NO-WAIT NO-ERROR.
                        IF  AVAIL sicuw.uwm301  THEN DO:
                            IF sicuw.uwm301.cha_no <> trim(wdetail.ChassisNo) THEN
                                ASSIGN wdetail2.comment4   = "เลขตัวถังไม่ตรง" .
                        END.
                    END.
                END.
            END.
        END.
        IF nv_checkstatus = NO THEN DO:
            /*ชื่อลูกค้า*/
            IF ra_customername = 1 THEN DO:
                FIND LAST sicuw.uwm100 USE-INDEX uwm10006 WHERE 
                    trim(sicuw.uwm100.name1)  = trim(trim(wdetail.CustomerFirstName) + " " + TRIM(wdetail.CustomerLastName)) AND 
                    sicuw.uwm100.poltyp = "V70"  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    FIND LAST wdetail2 WHERE 
                        wdetail2.RecordType = wdetail.RecordType  AND 
                        wdetail2.Sequenceno = wdetail.Sequenceno  NO-ERROR NO-WAIT.
                    IF NOT AVAIL wdetail2 THEN DO:
                        CREATE wdetail2.
                        ASSIGN 
                            wdetail2.RecordType = wdetail.RecordType  
                            wdetail2.Sequenceno = wdetail.Sequenceno  
                            wdetail2.Policy     = sicuw.uwm100.policy    
                            wdetail2.comment1   = ""    
                            wdetail2.comment2   = ""   
                            wdetail2.comment3   = ""    . 
                        IF INDEX(nv_agentgpstmt,TRIM(sicuw.uwm100.acno1)) = 0 THEN ASSIGN wdetail2.comment2   = "รหัส Code ไม่ตรง:" + sicuw.uwm100.acno1 .  
                        ELSE DO:
                            IF sicuw.uwm100.releas  = NO THEN ASSIGN wdetail2.comment1   = "Policy Not Release"    .
                        END.
                    END.
                    ELSE DO: 
                        ASSIGN wdetail2.Policy  = trim(wdetail2.Policy + " " + sicuw.uwm100.policy)  .
                        IF INDEX(nv_agentgpstmt,TRIM(sicuw.uwm100.acno1)) = 0 THEN ASSIGN wdetail2.comment2   = "รหัส Code ไม่ตรง:" + sicuw.uwm100.acno1 .  
                        ELSE DO:
                            IF sicuw.uwm100.releas  = NO THEN ASSIGN wdetail2.comment1   = "Policy Not Release"    .
                        END.
                    END.
                END.  
            END.
            IF ra_chassisno = 1 THEN DO:  /* chassis */
                FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE
                    sicuw.uwm301.trareg = trim(wdetail.ChassisNo)  AND
                    SUBSTR(sicuw.uwm301.policy,3,2) = "70"         NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL sicuw.uwm301  THEN DO:
                    FIND LAST wdetail2 WHERE 
                        wdetail2.RecordType = wdetail.RecordType  AND 
                        wdetail2.Sequenceno = wdetail.Sequenceno  NO-ERROR NO-WAIT.
                    IF NOT AVAIL wdetail2 THEN DO:
                        CREATE wdetail2.
                        ASSIGN 
                            wdetail2.RecordType = wdetail.RecordType  
                            wdetail2.Sequenceno = wdetail.Sequenceno  
                            wdetail2.Policy     = sicuw.uwm301.policy    
                            wdetail2.comment1   = ""    
                            wdetail2.comment2   = ""   
                            wdetail2.comment3   = ""    . 
                        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                            sicuw.uwm100.policy =  sicuw.uwm301.policy  NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL sicuw.uwm100 THEN DO:
                            IF INDEX(nv_agentgpstmt,TRIM(sicuw.uwm100.acno1)) = 0 THEN 
                                ASSIGN wdetail2.comment2   = "รหัส Code ไม่ตรง:" + sicuw.uwm100.acno1 .  
                            ELSE DO:
                                IF trim(sicuw.uwm100.name1) = trim(wdetail.CustomerFirstName) + " " + TRIM(wdetail.CustomerLastName) THEN 
                                    ASSIGN wdetail2.comment3   = "ชื่อไม่ตรง".
                                IF sicuw.uwm100.releas      = NO THEN ASSIGN wdetail2.comment1   = "Policy Not Release" .
                            END.
                        END. 
                    END.
                    ELSE DO: 
                        ASSIGN wdetail2.Policy  = trim(wdetail2.Policy + " " + sicuw.uwm301.policy)  .
                        IF INDEX(nv_agentgpstmt,TRIM(sicuw.uwm100.acno1)) = 0 THEN 
                            ASSIGN wdetail2.comment2   = "รหัส Code ไม่ตรง:" + sicuw.uwm100.acno1 .  
                        ELSE DO:
                            IF trim(sicuw.uwm100.name1) = trim(wdetail.CustomerFirstName) + " " + TRIM(wdetail.CustomerLastName) THEN 
                                    ASSIGN wdetail2.comment3   = "ชื่อไม่ตรง".
                            IF sicuw.uwm100.releas  = NO THEN ASSIGN wdetail2.comment1   = "Policy Not Release" .
                        END.
                    END.
                END.
            END.
            IF ra_notifyay = 1 THEN DO:
                IF TRIM(wdetail.notifyno) <> "" THEN DO:
                    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                        sicuw.uwm100.policy  =  TRIM(wdetail.notifyno)  NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        FIND LAST wdetail2 WHERE 
                            wdetail2.RecordType = wdetail.RecordType  AND 
                            wdetail2.Sequenceno = wdetail.Sequenceno  NO-ERROR NO-WAIT.
                        IF NOT AVAIL wdetail2 THEN DO:
                            CREATE wdetail2.
                            ASSIGN 
                                wdetail2.RecordType = wdetail.RecordType  
                                wdetail2.Sequenceno = wdetail.Sequenceno  
                                wdetail2.Policy     = sicuw.uwm100.policy   
                                wdetail2.comment1   = ""    
                                wdetail2.comment2   = ""   
                                wdetail2.comment3   = ""    .  
                            IF INDEX(nv_agentgpstmt,TRIM(sicuw.uwm100.acno1)) = 0 THEN DO: 
                                ASSIGN wdetail2.comment2   = "รหัส Code ไม่ตรง:" + sicuw.uwm100.acno1 .  
                            END.
                            ELSE DO:
                                IF trim(sicuw.uwm100.name1) = trim(wdetail.CustomerFirstName) + " " + TRIM(wdetail.CustomerLastName) THEN 
                                    ASSIGN wdetail2.comment3   = "ชื่อไม่ตรง".
                                IF sicuw.uwm100.releas  = NO THEN ASSIGN wdetail2.comment1   = "Policy Not Release"    .
                            END.
                        END.
                        ELSE do:
                            ASSIGN wdetail2.Policy  = trim(wdetail2.Policy + " " + sicuw.uwm100.policy)  .
                            IF INDEX(nv_agentgpstmt,TRIM(sicuw.uwm100.acno1)) = 0 THEN DO: 
                                ASSIGN wdetail2.comment2   = "รหัส Code ไม่ตรง:" + sicuw.uwm100.acno1 .  
                            END.
                            ELSE DO:
                                IF trim(sicuw.uwm100.name1) = trim(wdetail.CustomerFirstName) + " " + TRIM(wdetail.CustomerLastName) THEN 
                                    ASSIGN wdetail2.comment3   = "ชื่อไม่ตรง".
                                IF sicuw.uwm100.releas  = NO THEN ASSIGN wdetail2.comment1   = "Policy Not Release"    .
                            END.
                        END.
                    END.
                END.
            END.
        END.     /*wdetail.notifyno = "" */
    END.
    ASSIGN fi_process = "Match Data Complete....".
    DISP fi_process WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_reok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_reok c-wins
ON CHOOSE OF bu_reok IN FRAME fr_main /* OK */
DO:
    IF fi_outfilename = ""  THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfilename .
        Return no-apply.
    END.
    ELSE DO:
        If  substr(fi_outfilename,length(fi_outfilename) - 3,4) <>  ".csv"  THEN 
            fi_outfilename  =  Trim(fi_outfilename) + ".csv"  .
        
        OUTPUT TO VALUE(fi_outfilename). 
        FOR EACH wdetail WHERE 
            wdetail.RecordType = "H" NO-LOCK .
            EXPORT DELIMITER "|" 
                wdetail.RecordType
                wdetail.Sequenceno       
                wdetail.Company          
                wdetail.Product          
                wdetail.Branch    .
        END.
        EXPORT DELIMITER "|" 
            "Record Type"                        
            "Sequence no."                       
            "Company "                           
            "Product"                            
            "Branch"                             
            "Contract number"                    
            "Dealer  code"                       
            "Customer Title Name"                
            "Customer First Name / Company Name "
            "Customer Last Name "                
            "Customer Address1"                  
            "Customer Address2"                  
            "Customer Address3"                  
            "Zip Code"                           
            "Flag เปลี่ยนที่อยู่ "               
            "Brand "                             
            "Model "                             
            "Color"                              
            "Licence No. "                       
            "Licence (Province)"                 
            "Year "                              
            "C.C. "                              
            "Chassis No. "                       
            "Engine No. "                        
            "Code ผู้แจ้ง"                       
            "insurance Type"                     
            "Ins. Insurer"                       
            "INS. Policy No."                    
            "วันเริ่มคุ้มครอง"                   
            "วันสิ้นสุดคุ้มครอง"                 
            "Sum Insured"                        
            "Net.INS.Prm"                        
            "Total.INS.Prm"                      
            "เบี้ยรัยจากลูกค้า"                  
            "ปีประกัน"                           
            "เลขรับแจ้ง"                         
            "รหัสงาน"                            
            "first sent date"                    
            "Insurance  Year No."                
            "Taxation" 
            "เลขกรมธรรม์-Premium"
            "check 1"
            "check 2"
            "check 3"
            "check 4"  .

        IF ra_underwriteyear = 1 THEN RUN proc_reportyear1.
        ELSE RUN proc_reportyear2.
        FOR EACH wdetail WHERE 
            wdetail.RecordType = "T" NO-LOCK .
            EXPORT DELIMITER "|" 
                wdetail.RecordType
                wdetail.Sequenceno       
                wdetail.Company          
                wdetail.Product          
                wdetail.Branch    .
        END.
        Message "Export data Complete"  View-as alert-box.
    END.

    /*ELSE RUN proc_report.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_codejob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_codejob c-wins
ON LEAVE OF fi_codejob IN FRAME fr_main
DO:
    fi_codejob = INPUT fi_codejob .
    DISP fi_codejob WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gropro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gropro c-wins
ON LEAVE OF fi_gropro IN FRAME fr_main
DO:
    fi_gropro = INPUT fi_gropro.
    DISP fi_gropro WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inputfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inputfile c-wins
ON LEAVE OF fi_inputfile IN FRAME fr_main
DO:
    fi_inputfile  =  Input  fi_inputfile .
    Disp  fi_inputfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_limit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_limit c-wins
ON LEAVE OF fi_limit IN FRAME fr_main
DO:
  fi_limit = INPUT fi_limit .
  nvlimit   = INPUT fi_limit .
  DISP fi_limit WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfilename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfilename c-wins
ON LEAVE OF fi_outfilename IN FRAME fr_main
DO:
    fi_outfilename = INPUT fi_outfilename.
    DISP fi_outfilename WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-wins
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer.
  DISP fi_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_caseprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_caseprem c-wins
ON VALUE-CHANGED OF ra_caseprem IN FRAME fr_main
DO:
    ra_caseprem = INPUT ra_caseprem .
    DISP ra_caseprem WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_chassisno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_chassisno c-wins
ON VALUE-CHANGED OF ra_chassisno IN FRAME fr_main
DO:
  ra_chassisno = INPUT ra_chassisno.
  DISP ra_chassisno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_customername
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_customername c-wins
ON VALUE-CHANGED OF ra_customername IN FRAME fr_main
DO:
  ra_customername = INPUT ra_customername .
  DISP ra_customername WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_notifyay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_notifyay c-wins
ON VALUE-CHANGED OF ra_notifyay IN FRAME fr_main
DO:
  ra_notifyay = INPUT ra_notifyay .
  DISP ra_notifyay WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_producer c-wins
ON VALUE-CHANGED OF ra_producer IN FRAME fr_main
DO:
    ra_producer = INPUT ra_producer .
    DISP ra_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_underwriteyear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_underwriteyear c-wins
ON VALUE-CHANGED OF ra_underwriteyear IN FRAME fr_main
DO:
  ra_underwriteyear = INPUT ra_underwriteyear .
  DISP ra_underwriteyear WITH FRAM fr_main.
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
    gv_prgid = "wgwquay1".
    gv_prog  = "Query DATA  By AYCAL...".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    ASSIGN 
        fi_codejob   = ""
        ra_chassisno = 1
        ra_chassisno = 1
        ra_notifyay  = 1
        ra_producer  = 1
        fi_gropro   = "A0M0061"
        fi_producer = "A0M0018,A0M0019,A0M0061,A0M1011"
        ra_underwriteyear = 1
        ra_caseprem  = 1
        fi_limit     = 2000
        nvlimit      = 2000
        fi_process = "Import Text file AYCAL...." .
    /*RUN Open_tlt.*/
    Disp fi_process
        fi_codejob
        ra_chassisno
        ra_chassisno
        ra_producer
        fi_gropro  
        fi_producer
        ra_notifyay
        ra_underwriteyear
        ra_caseprem
        fi_limit
        with frame fr_main.
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    /*RECT-346:Move-to-top(). */
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
  DISPLAY fi_gropro fi_limit fi_process ra_customername fi_codejob fi_inputfile 
          fi_outfilename ra_chassisno ra_notifyay ra_underwriteyear ra_caseprem 
          ra_producer fi_producer 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE br_wdetail fi_gropro fi_limit fi_process bu_mat ra_customername 
         fi_codejob fi_inputfile fi_outfilename bu_reok bu_file bu_imp 
         ra_chassisno ra_notifyay ra_underwriteyear ra_caseprem bu_exit2 
         ra_producer fi_producer RECT-494 RECT-499 RECT-503 RECT-504 RECT-505 
         RECT-506 RECT-507 RECT-508 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Open_tlt c-wins 
PROCEDURE Open_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
Open Query br_tlt  For each tlt  NO-LOCK
     WHERE tlt.trndat     =  TODAY       and
           tlt.genusr     =  "aycal"  
    BY tlt.nor_noti_tlt  .
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutaddr c-wins 
PROCEDURE proc_cutaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
    IF (R-INDEX(np_addr1,"กทม")  <> 0 ) THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"กทม") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"กทม") - 1 )).

    END.
    ELSE IF (R-INDEX(np_addr1,"กรุง")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"กรุง") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"กรุง") - 1 )).
    END.
    ELSE IF (R-INDEX(np_addr1,"จ.")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"จ.") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"จ.") - 1 )).
    END.
    ELSE IF (R-INDEX(np_addr1,"จังหวัด")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"จังหวัด") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"จังหวัด") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"เขต")  <> 0 )  THEN DO:
        ASSIGN np_addr3  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"เขต") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"เขต") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"อำเภอ")  <> 0 )  THEN DO:
        ASSIGN np_addr3  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"อำเภอ") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"อำเภอ") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"แขวง")  <> 0 )  THEN DO:
        ASSIGN np_addr2  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"แขวง") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"แขวง") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"ตำบล")  <> 0 )  THEN DO:
        ASSIGN np_addr2  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"ตำบล") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"ตำบล") - 1 )).
    END.
    */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpolicy c-wins 
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
FOR EACH  wdetail WHERE 
    wdetail.RecordType    = "D" AND 
    wdetail.notifyno      <> "" .
    ASSIGN 
        nv_c = trim(wdetail.notifyno)
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
        wdetail.notifyno  = trim(nv_c) . 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ficomname1 c-wins 
PROCEDURE proc_ficomname1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.genusr   =  "aycal"               no-lock. 
    IF      (cb_report = "สาขา" ) AND (tlt.colorcod <> trim(fi_reportdata))           THEN NEXT.
    ELSE IF (cb_report = "ประเภทความคุ้มครอง") AND (tlt.safe3 <> trim(fi_reportdata)) THEN NEXT.
    ELSE IF (cb_report = "Complete" ) AND (index(tlt.OLD_eng,"not") = 0 )  THEN NEXT.
    ELSE IF (cb_report = "Not complete") AND (tlt.releas = "No" )          THEN NEXT.
    ELSE IF (cb_report = "Release Yes" ) AND (tlt.releas = "No" )          THEN NEXT.
    ELSE IF (cb_report = "Release No"  ) AND (tlt.releas = "Yes" )         THEN NEXT. 
    ASSIGN 
        n_record =  n_record + 1
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name .  
    EXPORT DELIMITER "|" 
        n_record                                           /*  1  ลำดับที่     */             
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
        tlt.brand               /*  13 ยี่ห้อรถ     */           
        tlt.model               /*  14 รุ่นรถ       */           
        tlt.lince1              /*  15 เลขทะเบียน   */           
        tlt.lince2              /*  16 ปีรถ         */           
        tlt.cc_weight           /*  17 CC.          */           
        tlt.cha_no              /*  18 เลขตัวถัง    */           
        tlt.eng_no              /*  19 เลขเครื่อง   */           
        tlt.comp_noti_tlt       /*  20 Code ผู้แจ้ง */           
        tlt.safe3               /*  21 ประเภท       */           
        tlt.nor_usr_ins         /*  22 Code บ.ประกัน        */  
        tlt.nor_noti_ins        /*  23 เลขกรมธรรม์เดิม      */ 
        IF tlt.nor_effdat = ? THEN "" ELSE string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 วันคุ้มครองประกัน    */
        IF tlt.expodat    = ? THEN "" ELSE string(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 วันหมดประกัน         */   
        tlt.comp_coamt         /*  26 ทุนประกัน    */           
        DECI(tlt.dri_name2)    /*  27 ค่าเบี้ยสุทธิ์ */         
        tlt.nor_grprm          /*  28 ค่าเบี้ยรวมภาษีอากร */    
        tlt.seqno              /*  29 Deduct       */           
        tlt.nor_usr_tlt        /*  30 Code บ.ประกัน พรบ.   */   
        IF tlt.comp_effdat  = ? THEN "" ELSE string(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 วันคุ้มครองพรบ.*/   
        IF tlt.dat_ins_noti = ? THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 วันหมดพรบ.   */           
        deci(tlt.dri_no1)   /*  33 ค่าพรบ.      */           
        tlt.dri_name1       /*  34 ระบุผู้ขับขี่        */   
        tlt.stat            /*  35 ซ่อมห้าง     */           
        tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
        tlt.filler1         /*  37 แก้ไขที่อยู่    */        
        tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
        tlt.OLD_cha         /*  39 หมายเหตุ */               
        tlt.OLD_eng         /*  40 complete/not complete */  
        tlt.releas   .      /*  41 Yes/No . */ 
END.      
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ficomname2 c-wins 
PROCEDURE proc_ficomname2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*

FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.lotno          =   n_comname   AND
    tlt.genusr         =  "phone"              no-lock.  
        /*IF (ra_report = 2) AND (index(tlt.OLD_eng,"not")  <> 0 )  THEN NEXT.
        ELSE IF (ra_report = 3) AND (index(tlt.OLD_eng,"not") = 0 )   THEN NEXT.
        ELSE IF (ra_report = 4) AND (tlt.releas        = "No" )       THEN NEXT.
        ELSE IF (ra_report = 5) AND (tlt.releas        = "Yes" )     THEN NEXT.*/
    IF      (cb_report = "สาขา" ) AND (tlt.colorcod <> trim(fi_reportdata))           THEN NEXT.
    ELSE IF (cb_report = "ประเภทความคุ้มครอง") AND (tlt.safe3 <> trim(fi_reportdata)) THEN NEXT.
    ELSE IF (cb_report = "Complete" ) AND (index(tlt.OLD_eng,"not") = 0 )  THEN NEXT.
    ELSE IF (cb_report = "Not complete") AND (tlt.releas = "No" )          THEN NEXT.
    /*ELSE IF (cb_report = "Release Yes" ) AND (tlt.releas = "Yes" )         THEN NEXT.
    ELSE IF (cb_report = "Release No"  ) AND (tlt.releas = "No" )          THEN NEXT. */
    ELSE IF (cb_report = "Release Yes" ) AND (tlt.releas = "No" )          THEN NEXT.
    ELSE IF (cb_report = "Release No"  ) AND (tlt.releas = "Yes")          THEN NEXT. 
    ASSIGN 
        n_record =  n_record + 1.
     /*   nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.*/
    EXPORT DELIMITER "|" 
    n_record                                        /*"ลำดับที่"      */            
    string(tlt.trndat,"99/99/9999") FORMAT "x(10)"  /*"วันที่รับแจ้ง" */        
    string(tlt.trntime)             FORMAT "x(10)"  /*"เวลารับแจ้ง"   */         
    trim(tlt.nor_noti_tlt)          FORMAT "x(50)"  /*"เลขรับแจ้งงาน" */       
    trim(tlt.lotno)                 FORMAT "x(20)"  /*"รหัสบรษัท" */           
    trim(tlt.nor_usr_ins)           FORMAT "x(40)"  /*"ชื่อเจ้าหน้าที่ MKT"*/ 
    trim(tlt.nor_usr_tlt)           FORMAT "x(10)"  /*"รหัสสาขา"             */             
    trim(tlt.nor_noti_ins)          FORMAT "x(35)"  /*"Code: "               */                       
    trim(tlt.colorcod)              FORMAT "x(20)"  /*"รหัสสาขา_STY "*/               
    trim(tlt.comp_sub)              FORMAT "x(30)"  /*"Producer." */           
    trim(tlt.recac)                 FORMAT "x(30)"  /*"Agent." */              
    trim(tlt.subins)                FORMAT "x(30)"  /* "Campaign no." */ 
    tlt.safe1                                       /*"ประเภทประกัน"*/
    tlt.safe2                                       /*"ประเภทรถ"*/          
    tlt.safe3                                       /*"ประเภทความคุ้มครอง"*/
    tlt.stat
    tlt.filler1                                     /*"ประกัน แถม/ไม่แถม"*/ 
    tlt.filler2                                     /*"พรบ.   แถม/ไม่แถม"*/
    tlt.nor_effdat            /*"วันเริ่มคุ้มครอง"       */
    tlt.expodat               /*"วันสิ้นสุดความคุ้มครอง" */
    tlt.dri_no2               /*  A55-0046.....*/
    tlt.policy                /*"เลขกรมธรรม์70"*/    
    tlt.comp_pol              /*"เลขกรมธรรม์72"*/   
    substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 ) FORMAT "x(20)"       /*"คำนำหน้าชื่อ"*/     
    substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1 )  FORMAT "x(35)"        /*"ชื่อผู้เอาประกัน"*/ 
    trim(tlt.endno)            /*id no */                                               
    IF tlt.dat_ins_noti = ? THEN "" ELSE trim(string(tlt.dat_ins_noti))  /*birth of date. */
    IF tlt.entdat = ?       THEN "" ELSE TRIM(STRING(tlt.entdat))        /*birth of date. */
    trim(tlt.flag)            /*occup */
    trim(tlt.usrsent)         /*Name drirect */
    trim(tlt.ins_addr1)       /*"บ้านเลขที่" */      
    trim(tlt.ins_addr2)       /*"ตำบล/แขวง" */
    trim(tlt.ins_addr3)       /*"อำเภอ/เขต"*/        
    trim(tlt.ins_addr4)       /*"จังหวัด" */
    trim(tlt.ins_addr5)       /*"รหัสไปรษณีย์"*/         
    tlt.comp_noti_ins         /*"เบอร์โทรศัพท์" */  
    IF tlt.dri_name1 = "" THEN "ไม่ระบุผู้ขับขี่" ELSE "ระบุผู้ขับขี่"
     /*drivname  "ผู้ขับขี่คนที่1"1*/    IF tlt.dri_name1 = "" THEN  "" ELSE SUBSTR(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 )
     /*sex       "เพศ"            1*/    IF tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(tlt.dri_name1,INDEX(tlt.dri_name1,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day "วันเกิด"        1*/    IF tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10))
     /*occup     "อาชัพ"          1*/    IF tlt.dri_name1 = "" THEN  "" ELSE substr(tlt.dri_name1,INDEX(tlt.dri_name1,"occ:") + 4 )   
     /*id driv   "เลขที่ใบขับขี่" 1*/    IF tlt.dri_name1 = "" THEN  "" ELSE trim(tlt.dri_no1)
     /*drivname "ผู้ขับขี่คนที่2" 2*/    IF tlt.dri_name1 = "" THEN  "" ELSE  SUBSTR(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 )
     /*sex      "เพศ"             2*/    IF tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(tlt.enttim,INDEX(tlt.enttim,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day"วันเกิด"         2*/    IF tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10)) 
     /*occup    "อาชัพ"           2*/    IF tlt.dri_name1 = "" THEN  "" ELSE substr(tlt.enttim,INDEX(tlt.enttim,"occ:") + 4 )   
     /*id driv  "เลขที่ใบขับขี่"  2*/    IF tlt.dri_name1 = "" THEN  "" ELSE trim(tlt.expotim)   

     /*/*drivname  "ผู้ขับขี่คนที่1"1*/    IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN "" ELSE SUBSTR(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 )
     /*sex       "เพศ"            1*/    IF trim(substr(tlt.dri_name1,INDEX(tlt.dri_name1,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day "วันเกิด"        1*/    IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN "" ELSE (SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10))
     /*occup     "อาชัพ"          1*/    IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN "" ELSE substr(tlt.dri_name1,INDEX(tlt.dri_name1,"occ:") + 4 )   
     /*id driv   "เลขที่ใบขับขี่" 1*/    trim(tlt.dri_no1)
        
     /*drivname "ผู้ขับขี่คนที่2" 2*/    IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN "" ELSE SUBSTR(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 )
     /*sex      "เพศ"             2*/    IF trim(substr(tlt.enttim,INDEX(tlt.enttim,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day"วันเกิด"         2*/    IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN "" ELSE (SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10)) 
     /*occup    "อาชัพ"           2*/    IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN "" ELSE substr(tlt.enttim,INDEX(tlt.enttim,"occ:") + 4 )   
     /*id driv  "เลขที่ใบขับขี่"  2*/    trim(tlt.expotim)  */
    tlt.brand                 /*"ชื่อยี่ห้อรถ"*/         
    tlt.model                 /*"รุ่นรถ" */              
    tlt.eng_no                /*"เลขเครื่องยนต์" */
    tlt.cha_no                /*"เลขตัวถัง" */           
    tlt.cc_weight             /*"ซีซี" */               
    tlt.lince2                /*"ปีรถยนต์"*/            
    /*substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1) FORMAT "x(7)"  /*"เลขทะเบียน"  */*//*A54-0112*/ 
    substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1) FORMAT "x(8)"  /*"เลขทะเบียน"  *//*A54-0112*/
    substr(tlt.lince1,R-INDEX(tlt.lince1," ") + 1) FORMAT "x(30)"    /*"จังหวัดที่จดทะเบียน"*/ 
    tlt.lince3                /*"แพคเกจ"*/
    tlt.exp                   /*"การซ่อม" */                                 
    tlt.nor_coamt             /*"ทุนประกัน"*/  
    tlt.dri_name2  FORMAT "x(30)"
    tlt.nor_grprm             /*"เบี้ยประกัน" */                             
    tlt.comp_coamt            /*"เบี้ยพรบ." */      
    tlt.comp_grprm            /*"เบี้ยรวม"*/        
    tlt.comp_sck              /*"เลขสติ๊กเกอร์" */  
    tlt.comp_noti_tlt         /*"เลขReferance no."*/
    tlt.rec_name              /*"ออกใบเสร็จในนาม"*/ 
    tlt.comp_usr_tlt          /*"Vatcode " */
    tlt.expousr               /*"ผู้รับแจ้ง"             */
    tlt.comp_usr_ins          /*"ผู้รับผลประโยชน์"       */
    tlt.OLD_cha               /*"หมายเหตุ"               */
    tlt.OLD_eng              /*"complete/not complete"  */ 
    tlt.releas. 
END.                   /*  end  wdetail  */
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report c-wins 
PROCEDURE proc_report :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_filename). 
EXPORT DELIMITER "|" 
    "ข้อมูลงานรับประกันภัย AYCL" .
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
    "วันคุ้มครองประกัน  "
    "วันหมดประกัน       "
    "ทุนประกัน  "
    "ค่าเบี้ยสุทธิ์     "
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
    "Yes/No" .  
RUN proc_ficomname1.

Message "Export data Complete"  View-as alert-box.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportyear1 c-wins 
PROCEDURE proc_reportyear1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail WHERE 
    wdetail.RecordType         = "D"              AND 
    deci(wdetail.yearunwrite) <= 1                AND       
    wdetail.codejob            = trim(fi_codejob) NO-LOCK .
    ASSIGN 
        nv_Policy   = ""
        nv_comment1 = ""
        nv_comment2 = ""
        nv_comment3 = ""
        nv_comment4 = ""
        nvTotalINSPrm   = 0 
        nvpremiumrecive = 0
        nvnetdep        = 0 
        nvTotalINSPrm   = deci(wdetail.TotalINSPrm)  / 100     
        nvpremiumrecive = deci(wdetail.premiumrecive) / 100.
    IF (nvTotalINSPrm - nvpremiumrecive) >= 0 THEN nvnetdep        = nvTotalINSPrm - nvpremiumrecive .
    ELSE nvnetdep  = nvlimit + 1.
    IF      (ra_caseprem = 1 ) AND ( nvpremiumrecive > 0 ) THEN  NEXT.  /*เบี้ยรับ = 0*/
    ELSE IF (ra_caseprem = 2 ) AND ( nvpremiumrecive <> nvTotalINSPrm )  THEN  NEXT.  /*เบี้ยรับ = เบี้ยรวม*/
    ELSE IF (ra_caseprem = 3 ) AND ( nvnetdep > nvlimit ) AND ( nvpremiumrecive = 0 ) THEN  NEXT.  /*เบี้ยรับ < เบี้ยรวม <=limit */
    IF ((ra_caseprem = 2 ) OR (ra_caseprem = 3 )) AND ( nvpremiumrecive <= 0 )  THEN  NEXT.  /*เบี้ยรับ = เบี้ยรวม*/
    FIND LAST wdetail2 WHERE 
        wdetail2.RecordType = wdetail.RecordType  AND 
        wdetail2.Sequenceno = wdetail.Sequenceno  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wdetail2 THEN  
        ASSIGN 
        nv_Policy   = wdetail2.Policy      
        nv_comment1 = wdetail2.comment1   
        nv_comment2 = wdetail2.comment2   
        nv_comment3 = wdetail2.comment3   
        nv_comment4 = wdetail2.comment4   .
    EXPORT DELIMITER "|" 
        wdetail.RecordType
        wdetail.Sequenceno       
        wdetail.Company          
        wdetail.Product          
        wdetail.Branch           
        wdetail.Contractnumber   
        wdetail.Dealercode       
        wdetail.CustomerTitleName
        wdetail.CustomerFirstName
        wdetail.CustomerLastName 
        wdetail.CustomerAddress1 
        wdetail.CustomerAddress2 
        wdetail.CustomerAddress3 
        wdetail.ZipCode          
        wdetail.Flag             
        wdetail.Brand            
        wdetail.Model            
        wdetail.nColor           
        wdetail.LicenceNo        
        wdetail.LicenceProvince  
        wdetail.nYear            
        deci(wdetail.CC)               
        wdetail.ChassisNo        
        wdetail.EngineNo         
        wdetail.Code_sendby      
        wdetail.insuranceType    
        wdetail.InsInsurer       
        wdetail.INSPolicyNo      
        substr(wdetail.comdat,5,2) + "/" +  substr(wdetail.comdat,3,2) + "/" +  substr(wdetail.comdat,1,2)   
        substr(wdetail.expdat,5,2) + "/" +  substr(wdetail.expdat,3,2) + "/" +  substr(wdetail.expdat,1,2)  
        string(deci(wdetail.SumInsured) / 100 ,">>>,>>>,>>>")     
        string(deci(wdetail.NetINSPrm) / 100  ,">>>,>>>,>>9.99")     
        string(deci(wdetail.TotalINSPrm) / 100 ,">>>,>>>,>>9.99")   
        string(deci(wdetail.premiumrecive) / 100 ,">>>,>>>,>>9.99")  
        wdetail.yearunwrite      
        wdetail.notifyno         
        wdetail.codejob          
        wdetail.firstsentdate    
        wdetail.InsuranceYearNo  
        wdetail.Taxation 
        nv_Policy  
        nv_comment1
        nv_comment2
        nv_comment3
        nv_comment4 .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportyear2 c-wins 
PROCEDURE proc_reportyear2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail WHERE 
    wdetail.RecordType         = "D"              AND 
    deci(wdetail.yearunwrite) > 1                 AND       
    wdetail.codejob            = trim(fi_codejob) NO-LOCK .
    ASSIGN 
        nv_Policy   = ""
        nv_comment1 = ""
        nv_comment2 = ""
        nv_comment3 = ""
        nv_comment4 = ""
        nvTotalINSPrm   = 0 
        nvpremiumrecive = 0
        nvnetdep        = 0 
        nvTotalINSPrm   = deci(wdetail.TotalINSPrm)  / 100     
        nvpremiumrecive = deci(wdetail.premiumrecive) / 100.
    IF (nvTotalINSPrm - nvpremiumrecive) >= 0 THEN nvnetdep        = nvTotalINSPrm - nvpremiumrecive .
    ELSE nvnetdep  = nvlimit + 1.
    IF      (ra_caseprem = 1 ) AND ( nvpremiumrecive > 0 )  THEN  NEXT.
    ELSE IF (ra_caseprem = 2 ) AND ( nvpremiumrecive <> nvTotalINSPrm )  THEN  NEXT.
    ELSE IF (ra_caseprem = 3 ) AND ( nvnetdep > nvlimit )   THEN  NEXT.
    IF ((ra_caseprem = 2 ) OR (ra_caseprem = 3 )) AND ( nvpremiumrecive <= 0 )  THEN  NEXT.  /*เบี้ยรับ = เบี้ยรวม*/
    FIND LAST wdetail2 WHERE 
        wdetail2.RecordType = wdetail.RecordType  AND 
        wdetail2.Sequenceno = wdetail.Sequenceno  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wdetail2 THEN  
        ASSIGN 
        nv_Policy   = wdetail2.Policy      
        nv_comment1 = wdetail2.comment1   
        nv_comment2 = wdetail2.comment2   
        nv_comment3 = wdetail2.comment3   
        nv_comment4 = wdetail2.comment4   .

    EXPORT DELIMITER "|" 
        wdetail.RecordType
        wdetail.Sequenceno       
        wdetail.Company          
        wdetail.Product          
        wdetail.Branch           
        wdetail.Contractnumber   
        wdetail.Dealercode       
        wdetail.CustomerTitleName
        wdetail.CustomerFirstName
        wdetail.CustomerLastName 
        wdetail.CustomerAddress1 
        wdetail.CustomerAddress2 
        wdetail.CustomerAddress3 
        wdetail.ZipCode          
        wdetail.Flag             
        wdetail.Brand            
        wdetail.Model            
        wdetail.nColor           
        wdetail.LicenceNo        
        wdetail.LicenceProvince  
        wdetail.nYear            
        deci(wdetail.CC)               
        wdetail.ChassisNo        
        wdetail.EngineNo         
        wdetail.Code_sendby      
        wdetail.insuranceType    
        wdetail.InsInsurer       
        wdetail.INSPolicyNo      
        substr(wdetail.comdat,5,2) + "/" +  substr(wdetail.comdat,3,2) + "/" +  substr(wdetail.comdat,1,2)   
        substr(wdetail.expdat,5,2) + "/" +  substr(wdetail.expdat,3,2) + "/" +  substr(wdetail.expdat,1,2)  
        string(deci(wdetail.SumInsured) / 100 ,">>>,>>>,>>>")     
        string(deci(wdetail.NetINSPrm) / 100  ,">>>,>>>,>>9.99")     
        string(deci(wdetail.TotalINSPrm) / 100 ,">>>,>>>,>>9.99")   
        string(deci(wdetail.premiumrecive) / 100 ,">>>,>>>,>>9.99")    
        wdetail.yearunwrite      
        wdetail.notifyno         
        wdetail.codejob          
        wdetail.firstsentdate    
        wdetail.InsuranceYearNo  
        wdetail.Taxation  
        nv_Policy  
        nv_comment1
        nv_comment2
        nv_comment3
        nv_comment4.
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
OPEN QUERY br_wdetail FOR EACH wdetail NO-LOCK.

/*
Open Query br_tlt 
    For each tlt Use-index  tlt01 NO-LOCK 
    WHERE 
    tlt.trndat         >=  fi_trndatfr   And
    tlt.trndat         <=  fi_trndatto   And
    tlt.genusr   =  "phone"         .
        */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

