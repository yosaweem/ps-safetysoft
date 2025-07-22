&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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

/*++++++++++++++++++++++++++++++++++++++++++++++
program id   : wgwquay1.w
program name : Query & Update Data Aycl
               Import text file from  Aycal to create  new policy Add in table  tlt 
Create  by   : Kridtiya i. [A56-0241]   On   08/08/2013
Connect      : GW_SAFE LD SIC_BRAN, GW_STAT LD BRSTAT ,SICSYAC,SICUW [Not connect : Stat]
modify by    : Kridtiya i. A58-0301 date.21/08/2015 add notify no. for Aycal 
+++++++++++++++++++++++++++++++++++++++++++++++*/
Modify By    : Porntiwa P.  A58-0361  Date ; 25/09/2015
             : ปรับให้สามารถ Load งาน cancel ได้   
Modify By    : Jiraphon P. A59-0451 03/10/2016
             : แก้ไขการนำเข้าข้อมูล ลง Hold Cover              
Modify By    : Sarinya C. A61-0349 23/07/2018
             : แก้ไขปรับเพิ่มรับไฟล์ Format ใหม่               
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

DEFINE  VAR nv_rectlt    as recid init  0.  
DEFINE  VAR nv_recidtlt  as recid init  0.  
DEF  STREAM ns2.                        
DEFINE  VAR nv_cnt       as int   init  1. 
DEFINE  VAR nv_row       as int   init  0. 
DEFINE  VAR n_record     AS INTE  INIT  0. 
DEFINE  VAR n_comname    AS CHAR  INIT  "".
DEFINE  VAR n_asdat      AS CHAR.
DEFINE  VAR vAcProc_fil  AS CHAR.
DEFINE  VAR vAcProc_fil2 AS CHAR.
DEFINE  VAR n_asdat2     AS CHAR.
DEFINE  WORKFILE wdetail NO-UNDO
    FIELD   Seqno          AS CHAR FORMAT "X(10)"  INIT ""   /*  1   Seq.    1   */                                                       
    FIELD   Company        AS CHAR FORMAT "X(10)"  INIT ""   /*  2   Company AYCAL   */                                      
    FIELD   Porduct        AS CHAR FORMAT "X(10)"  INIT ""   /*  3   Porduct HP  */                                             
    FIELD   Branch         AS CHAR FORMAT "X(10)"  INIT ""   /*  4   Branch  11  */                                             
    FIELD   Contract       AS CHAR FORMAT "X(10)"  INIT ""   /*  5   Contract    T053357 */                                  
    FIELD   nTITLE         AS CHAR FORMAT "X(10)"  INIT ""   /*  6   ชื่อ+นามสกุล    นาย */                                                                         
    FIELD   name1          AS CHAR FORMAT "X(10)"  INIT ""   /*  7   กฤตพัฒน์    */                                      
    FIELD   name2          AS CHAR FORMAT "X(10)"  INIT ""   /*  8   ป้อมประยูร  */                                      
    FIELD   addr1          AS CHAR FORMAT "X(10)"  INIT ""   /*  9   ที่อยู่ 78/427 มบ.อินทราวิลล์ ถ.พระยาสุเรนทร์ ซ.19  */  
    FIELD   addr2          AS CHAR FORMAT "X(10)"  INIT ""   /*  10  แขวงบางชัน เขตคลองสามวา */                          
    FIELD   addr3          AS CHAR FORMAT "X(10)"  INIT ""   /*  11  กทม.    */                                          
    FIELD   addr4          AS CHAR FORMAT "X(10)"  INIT ""   /*  12  10510   */                                          
    FIELD   brand          AS CHAR FORMAT "X(10)"  INIT ""   /*  13  ยี่ห้อรถ    TOY */                                      
    FIELD   model          AS CHAR FORMAT "X(10)"  INIT ""   /*  14  รุ่นรถ  ALTIS 1.6E CNG  */                              
    FIELD   coler          AS CHAR FORMAT "X(10)"  INIT ""   /*  15  สี  เทา */                                                           
    FIELD   vehreg         AS CHAR FORMAT "X(10)"  INIT ""   /*  16  เลขทะเบียน  ฎฮ 8828 */                                  
    FIELD   provin         AS CHAR FORMAT "X(10)"  INIT ""   /*  17  จังหวัดที่จดทะเบียน กรุงเทพมหานคร   */                  
    FIELD   caryear        AS CHAR FORMAT "X(10)"  INIT ""   /*  18  ปีรถ    2010    */                                      
    FIELD   cc             AS CHAR FORMAT "X(10)"  INIT ""   /*  19  CC. 1598    */                                          
    FIELD   chassis        AS CHAR FORMAT "X(10)"  INIT ""   /*  20  เลขตัวถัง   MR053ZEE106184578   */                      
    FIELD   engno          AS CHAR FORMAT "X(10)"  INIT ""   /*  21  เลขเครื่อง  3ZZB029121  */                                                
    FIELD   notifyno       AS CHAR FORMAT "X(10)"  INIT ""   /*  22  Code ผู้แจ้ง    1112    */                                                
    FIELD   covcod         AS CHAR FORMAT "X(10)"  INIT ""   /*  23  ประเภท  1   */                                                            
    FIELD   Codecompany    AS CHAR FORMAT "X(10)"  INIT ""   /*  24  Code บ.ประกัน   KPI */                                    
    FIELD   prepol         AS CHAR FORMAT "X(10)"  INIT ""   /*  25  เลขกรมธรรม์เดิม     */                                       
    FIELD   comdat70       AS CHAR FORMAT "X(10)"  INIT ""   /*  26  วันคุ้มครองประกัน   560722  */                                                
    FIELD   expdat70       AS CHAR FORMAT "X(10)"  INIT ""   /*  27  วันหมดประกัน    570722  */                                                    
    FIELD   si             AS CHAR FORMAT "X(10)"  INIT ""   /*  28  ทุนประกัน   54000000    */                                                    
    FIELD   premt          AS CHAR FORMAT "X(10)"  INIT ""   /*  29  ค่าเบี้ยสุทธิ์  1376070 */                                                    
    FIELD   premtnet       AS CHAR FORMAT "X(10)"  INIT ""   /*  30  ค่าเบี้ยรวมภาษีอากร 1478312 */                                                
    FIELD   other          AS CHAR FORMAT "X(10)"  INIT ""   /*  31      0   */                                                                    
    FIELD   renew          AS CHAR FORMAT "X(10)"  INIT ""   /*  32  ปีประกัน    2   */                                                            
    FIELD   policy         AS CHAR FORMAT "X(10)"  INIT ""   /*  33  เลขรับแจ้ง  STAY13-0257 */    
    FIELD   idno           AS CHAR FORMAT "X(15)"  INIT ""   /*  33  id */ 
    FIELD   garage         AS CHAR FORMAT "X(10)"  INIT ""   /*  34      ซ่อมห้าง    */                                                            
    FIELD   notifydate     AS CHAR FORMAT "X(10)"  INIT ""   /*  35  วันที่แจ้ง  560621  */                                                                      
    FIELD   Deduct         AS CHAR FORMAT "X(10)"  INIT ""   /*  36  Deduct      */                                                                              
    FIELD   Codecompa72    AS CHAR FORMAT "X(10)"  INIT ""   /*  37  Code บ.ประกัน พรบ.      */                                                 
    FIELD   comdat72       AS CHAR FORMAT "X(10)"  INIT ""   /*  38  วันคุ้มครองพรบ.     */                                                     
    FIELD   expdat72       AS CHAR FORMAT "X(10)"  INIT ""   /*  39  วันหมดพรบ.      */                                                         
    FIELD   comp           AS CHAR FORMAT "X(10)"  INIT ""   /*  40  ค่าพรบ.     */                                                             
    FIELD   driverno       AS CHAR FORMAT "X(10)"  INIT ""   /*  41  ระบุผู้ขับขี่       */                                                     
    FIELD   access         AS CHAR FORMAT "X(10)"  INIT ""   /*  43  คุ้มครองอุปกรณ์เพิ่มเติม        */                                         
    FIELD   endoresadd     AS CHAR FORMAT "X(10)"  INIT ""   /*  44  แก้ไขที่อยู่        */                                   
    FIELD   remak          AS CHAR FORMAT "X(10)"  INIT ""   /*  45  หมายเหตุ.       */
    FIELD   recivedat      AS CHAR FORMAT "x(10)"  INIT ""
    /* Add By Sarinya C. A61-0349 23/07/2018*/           
    FIELD   AgencyEmployee AS CHAR FORMAT "X(10)"  INIT ""   /*  ชื่อผู้แจ้งงาน */                                    
    FIELD   siIns          AS CHAR FORMAT "X(10)"  INIT ""   /*  เบี้ยประกันรับจากลูกค้า */                                       
    FIELD   InsCTP         AS CHAR FORMAT "X(10)"  INIT ""   /*  INSURER CTP  */                                                
    FIELD   drivername1    AS CHAR FORMAT "X(10)"  INIT ""   /*  ผู้ขับขี่คนที่ 1*/                                                     
    FIELD   driverbrith1   AS CHAR FORMAT "X(10)"  INIT ""   /*  วันเดือนปีเกิด 1 */                                                    
    FIELD   drivericno1    AS CHAR FORMAT "X(10)"  INIT ""   /*  หมายเลขบัตร 1 */                                                       
    FIELD   driverCard1    AS CHAR FORMAT "X(10)"  INIT ""   /*  DRIVER CARD 1 */        
    FIELD   driverexp1     AS CHAR FORMAT "X(10)"  INIT ""   /*  DRIVER CARD EXPIRE 1 */
    FIELD   drivername2    AS CHAR FORMAT "X(10)"  INIT ""   /*  ผู้ขับขี่คนที่ 2 */                                                   
    FIELD   driverbrith2   AS CHAR FORMAT "X(10)"  INIT ""   /*  วันเดือนปีเกิด 2 */                                                    
    FIELD   drivericno2    AS CHAR FORMAT "X(10)"  INIT ""   /*  วันเดือนปีเกิด 2 */                                                    
    FIELD   driverCard2    AS CHAR FORMAT "X(10)"  INIT ""   /*  หมายเลขบัตร 2 */         
    FIELD   driverexp2     AS CHAR FORMAT "X(15)"  INIT ""   /*  DRIVER CARD EXPIRE 2 */
    FIELD   InspectName    AS CHAR FORMAT "X(10)"  INIT ""   /*  ชื่อผู้ตรวจรถ */                                                                                   
    FIELD   InspectPhoneNo AS CHAR FORMAT "X(10)"  INIT ""   /*  เบอร์โทรศัพท์ผู้ตรวจรถ */                                                                  
    FIELD   Benefic        AS CHAR FORMAT "X(10)"  INIT ""   /*  ผู้รับผลประโยชน์ */                                                                        
    FIELD   Plus12         AS CHAR FORMAT "X(10)"  INIT ""   /*  FLAG FOR 12PLUS  */          
    FIELD   ISPNo          AS CHAR FORMAT "X(20)"  INIT ""   /*  Inspection No  */ 
    /* End Add By Sarinya C. A61-0349 23/07/2018*/ 
    .                                                                 
                                                                                            
    
DEF VAR nv_countdata     AS DECI INIT 0.
DEF VAR nv_countcomplete AS DECI INIT 0.
DEF VAR np_addr1     AS CHAR FORMAT "x(256)"    INIT "" .
DEF VAR np_addr2     AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_addr3     AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_addr4     AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_addr5     AS CHAR FORMAT "x(40)"     INIT "" .   /*Add Jiraphon A59-0451*/
DEF VAR nv_prov     AS CHAR FORMAT "x(40)"     INIT "" .    /*Add Jiraphon A59-0451*/
DEF VAR nv_amp      AS CHAR FORMAT "x(40)"     INIT "" .    /*Add Jiraphon A59-0451*/
DEF VAR nv_tum      AS CHAR FORMAT "x(40)"     INIT "" .    /*Add Jiraphon A59-0451*/


DEF VAR np_addrall     AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_title     AS CHAR FORMAT "x(30)"     INIT "" .
DEF VAR np_name      AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_name2     AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR nv_outfile   AS CHAR FORMAT "x(256)"    INIT "" .
/**/
DEF VAR nv_isp       AS CHAR FORMAT "x(20)" INIT "".    /* Add By Sarinya C. A61-0349 */
DEFINE  WORKFILE wdetailUP NO-UNDO
    FIELD        PolicyUP  AS CHAR FORMAT "X(20)"  INIT ""                                                  
    FIELD        Company   AS CHAR FORMAT "X(20)"  INIT "".

/* Add A58-0361 */
DEF VAR putchr      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR textchr     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR nv_trferr   AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.

DEF VAR nv_errfile AS CHAR FORMAT "X(30)"  INIT "" NO-UNDO.
DEF VAR nv_error   AS LOGICAL    INIT NO     NO-UNDO.
DEF NEW SHARED STREAM ns1.

DEFINE VAR n_datesent AS DATE.
DEFINE VAR company AS CHAR FORMAT "X(50)".

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
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas tlt.datesent ~
tlt.nor_noti_tlt tlt.recac tlt.nor_noti_ins tlt.comp_pol tlt.ins_name ~
tlt.safe2 tlt.ins_addr1 tlt.ins_addr2 + " " + tlt.ins_addr3 tlt.ins_addr4 ~
tlt.ins_addr5 tlt.lince1 tlt.lince2 tlt.model tlt.brand tlt.trndat ~
tlt.rec_addr4 tlt.comp_usr_ins tlt.usrid 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH stat.tlt NO-LOCK
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH stat.tlt NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_update bu_upyesno fi_name ra_Typeload ~
fi_loaddate fi_inputfile bu_file bu_imp ra_matkpn fi_trndatfr cb_producer ~
fi_Producer bu_ok fi_trndatto fi_filename2 bu_file-2 bu_reok2 fi_outfile ~
cb_search bu_sch fi_search cb_report fi_reportdata bu_refresh bu_reok ~
bu_exit fi_report fi_filename br_tlt cb_agent-2 fi_Agent-2 RECT-502 ~
RECT-503 RECT-504 RECT-522 RECT-523 RECT-498 RECT-524 RECT-525 RECT-526 ~
RECT-527 RECT-499 RECT-500 RECT-528 RECT-654 RECT-655 RECT-658 RECT-659 
&Scoped-Define DISPLAYED-OBJECTS fi_name ra_Typeload fi_loaddate ~
fi_inputfile ra_matkpn fi_trndatfr cb_producer fi_Producer fi_trndatto ~
fi_filename2 fi_outfile cb_search fi_search cb_report fi_reportdata ~
fi_process fi_report fi_filename cb_agent-2 fi_Agent-2 

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
     SIZE 7.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.1.

DEFINE BUTTON bu_file-2 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_imp 
     LABEL "Import" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON bu_refresh 
     LABEL "Refresh" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON bu_reok 
     LABEL "OK" 
     SIZE 7.5 BY 1
     FONT 6.

DEFINE BUTTON bu_reok2 
     LABEL "OK" 
     SIZE 7.5 BY 1
     FONT 6.

DEFINE BUTTON bu_sch 
     LABEL "Search" 
     SIZE 7.5 BY 1
     FONT 6.

DEFINE BUTTON bu_update 
     LABEL "CANCEL" 
     SIZE 14 BY 1.05.

DEFINE BUTTON bu_upyesno 
     LABEL "YES/NO" 
     SIZE 14 BY 1.05.

DEFINE VARIABLE cb_agent-2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "B3W0100","B3M0039","B300303" 
     DROP-DOWN-LIST
     SIZE 19.83 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE cb_producer AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "A0M0062","A0M0018","A0M0073" 
     DROP-DOWN-LIST
     SIZE 19.83 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "สาขา" 
     DROP-DOWN-LIST
     SIZE 29 BY 1
     BGCOLOR 15 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "ชื่อลูกค้า" 
     DROP-DOWN-LIST
     SIZE 30.33 BY 1
     BGCOLOR 15 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Agent-2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 51.17 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_inputfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 66 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_loaddate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 51.17 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 30.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_report AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 10.83 BY 1
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_reportdata AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 30.33 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_matkpn AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "เลขรับแจ้ง", 1,
"Contract", 2,
"ทะเบียนรถ", 3,
"เลขถัง", 4,
"all", 5,
"Cancel", 6
     SIZE 71 BY 1
     BGCOLOR 8 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_Typeload AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "ไฟล์เดิม", 1,
"ไฟล์ใหม่", 2
     SIZE 10.67 BY 1.91
     BGCOLOR 8 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-498
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.43
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-499
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.43
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-500
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.43
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-502
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 146.83 BY 3.81
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-503
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-504
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.38
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-522
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 54.83 BY 9.43
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-523
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 92.33 BY 5.19
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-524
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17.5 BY 1.43
     BGCOLOR 1 FGCOLOR 7 .

DEFINE RECTANGLE RECT-525
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 74.33 BY 1.43.

DEFINE RECTANGLE RECT-526
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 92.33 BY 4.29
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-527
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17.5 BY 1.43
     BGCOLOR 1 FGCOLOR 4 .

DEFINE RECTANGLE RECT-528
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 54 BY 1.43
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-654
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 53.83 BY 2.76.

DEFINE RECTANGLE RECT-655
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 53.83 BY 3.33.

DEFINE RECTANGLE RECT-658
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13 BY 1.91
     BGCOLOR 34 .

DEFINE RECTANGLE RECT-659
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 83.5 BY 2.14
     BGCOLOR 34 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas FORMAT "x(16)":U WIDTH 11.33
      tlt.datesent FORMAT "99/99/9999":U WIDTH 10
      tlt.nor_noti_tlt COLUMN-LABEL "เลขรับแจ้งฯ,Aycl" FORMAT "x(20)":U
            WIDTH 19.83
      tlt.recac COLUMN-LABEL "Contract" FORMAT "x(10)":U
      tlt.nor_noti_ins COLUMN-LABEL "เลขกรมธรรม์เดิม" FORMAT "x(20)":U
            WIDTH 14.33
      tlt.comp_pol COLUMN-LABEL "Policy New." FORMAT "x(25)":U
      tlt.ins_name FORMAT "x(60)":U WIDTH 25.83
      tlt.safe2 COLUMN-LABEL "ICno." FORMAT "x(15)":U WIDTH 14.33
      tlt.ins_addr1 FORMAT "x(30)":U WIDTH 17.33
      tlt.ins_addr2 + " " + tlt.ins_addr3 COLUMN-LABEL "ที่อยู่ผู้เอาประกัน 2" FORMAT "x(50)":U
            WIDTH 20.17
      tlt.ins_addr4 COLUMN-LABEL "ที่อยู่ผู้เอาประกัน 3" FORMAT "x(30)":U
            WIDTH 15.33
      tlt.ins_addr5 FORMAT "x(5)":U
      tlt.lince1 FORMAT "x(30)":U
      tlt.lince2 COLUMN-LABEL "ปีรถ" FORMAT "x(5)":U
      tlt.model FORMAT "x(25)":U WIDTH 12.83
      tlt.brand FORMAT "x(3)":U WIDTH 8.83
      tlt.trndat FORMAT "99/99/9999":U
      tlt.rec_addr4 COLUMN-LABEL "agent code" FORMAT "x(10)":U
      tlt.comp_usr_ins COLUMN-LABEL "ผู้รับผลประโยชน์" FORMAT "x(50)":U
      tlt.usrid FORMAT "x(8)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH SEPARATORS SIZE 147 BY 13.33
         BGCOLOR 15 FGCOLOR 0  ROW-HEIGHT-CHARS .62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_update AT ROW 3.33 COL 115 WIDGET-ID 18
     bu_upyesno AT ROW 3.29 COL 131 WIDGET-ID 20
     fi_name AT ROW 3.43 COL 65.67 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     ra_Typeload AT ROW 2.71 COL 50.17 NO-LABEL WIDGET-ID 2
     fi_loaddate AT ROW 1.33 COL 32.67 COLON-ALIGNED NO-LABEL
     fi_inputfile AT ROW 1.33 COL 61.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 1.29 COL 130.5
     bu_imp AT ROW 1.29 COL 137
     ra_matkpn AT ROW 5.05 COL 75.33 NO-LABEL
     fi_trndatfr AT ROW 7.38 COL 7.83 COLON-ALIGNED NO-LABEL
     cb_producer AT ROW 6.43 COL 75.83 COLON-ALIGNED NO-LABEL
     fi_Producer AT ROW 6.43 COL 75.67 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 7.38 COL 47.17
     fi_trndatto AT ROW 7.38 COL 29.17 COLON-ALIGNED NO-LABEL
     fi_filename2 AT ROW 7.57 COL 75.83 COLON-ALIGNED NO-LABEL
     bu_file-2 AT ROW 7.52 COL 129.67
     bu_reok2 AT ROW 7.62 COL 135.5
     fi_outfile AT ROW 8.67 COL 75.83 COLON-ALIGNED NO-LABEL
     cb_search AT ROW 9.48 COL 8.17 NO-LABEL
     bu_sch AT ROW 10.71 COL 43.17
     fi_search AT ROW 10.71 COL 8.17 NO-LABEL
     cb_report AT ROW 10.43 COL 73.17 COLON-ALIGNED NO-LABEL
     fi_reportdata AT ROW 10.48 COL 115.67 COLON-ALIGNED NO-LABEL
     bu_refresh AT ROW 12.71 COL 43.17
     fi_process AT ROW 12.71 COL 7.83 NO-LABEL
     bu_reok AT ROW 11.57 COL 125.67
     bu_exit AT ROW 11.57 COL 135.33
     fi_report AT ROW 10.48 COL 103 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 11.76 COL 73.17 COLON-ALIGNED NO-LABEL
     br_tlt AT ROW 14.29 COL 1
     cb_agent-2 AT ROW 2.81 COL 15.83 NO-LABEL
     fi_Agent-2 AT ROW 2.81 COL 15.67 NO-LABEL
     "File name :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 11.81 COL 63
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "Agent Code :" VIEW-AS TEXT
          SIZE 13.17 BY .95 AT ROW 2.81 COL 2.33
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "รูปแบบไฟล์ :" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 3.14 COL 37.5 WIDGET-ID 6
          BGCOLOR 34 FGCOLOR 4 FONT 6
     "Query File :" VIEW-AS TEXT
          SIZE 12.83 BY .91 AT ROW 4.91 COL 2 WIDGET-ID 10
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Click for update Flag Cancel" VIEW-AS TEXT
          SIZE 28 BY .62 AT ROW 2.67 COL 64 WIDGET-ID 14
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Match file KPI :" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 5.05 COL 56.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " By :" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 9.48 COL 2.5
          BGCOLOR 8 FGCOLOR 4 FONT 6
     " To :" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 7.43 COL 24.83
          BGCOLOR 8 FGCOLOR 4 FONT 6
     " By Trans. Date :" VIEW-AS TEXT
          SIZE 17.33 BY .91 AT ROW 6.33 COL 2.33
          BGCOLOR 8 FGCOLOR 4 FONT 6
     " Import Data to GW :" VIEW-AS TEXT
          SIZE 20.17 BY .91 AT ROW 1.43 COL 1.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Report File :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 10.29 COL 56.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Load Date :" VIEW-AS TEXT
          SIZE 11.83 BY 1 AT ROW 1.33 COL 22.67
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Exp. Running STY58000001 [STY S TY A0M0061 V70 ]" VIEW-AS TEXT
          SIZE 44.5 BY .81 AT ROW 13 COL 63.17
          BGCOLOR 18 FGCOLOR 4 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 147.5 BY 26.67
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Query File :" VIEW-AS TEXT
          SIZE 12.83 BY .91 AT ROW 4.91 COL 2
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Producer Code :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 6.43 COL 61.33
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "       Import KPI :" VIEW-AS TEXT
          SIZE 16.17 BY .95 AT ROW 7.57 COL 60.83
          BGCOLOR 8 FGCOLOR 4 FONT 6
     " Form :" VIEW-AS TEXT
          SIZE 7.17 BY .91 AT ROW 7.43 COL 2.17
          BGCOLOR 8 FGCOLOR 4 FONT 6
     " File Name :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 1.33 COL 49.83
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "       Export KPI :" VIEW-AS TEXT
          SIZE 16.67 BY .95 AT ROW 8.67 COL 60.83
          BGCOLOR 8 FGCOLOR 4 FONT 6
     RECT-502 AT ROW 1 COL 1
     RECT-503 AT ROW 1.05 COL 1.33
     RECT-504 AT ROW 1.1 COL 136.17
     RECT-522 AT ROW 4.86 COL 1
     RECT-523 AT ROW 4.81 COL 55.5
     RECT-498 AT ROW 7.38 COL 134.67
     RECT-524 AT ROW 4.81 COL 55.83
     RECT-525 AT ROW 4.81 COL 73.5
     RECT-526 AT ROW 10 COL 55.5
     RECT-527 AT ROW 10 COL 55.83
     RECT-499 AT ROW 11.33 COL 124.83
     RECT-500 AT ROW 11.33 COL 134.5
     RECT-528 AT ROW 4.81 COL 1.33
     RECT-654 AT ROW 6.14 COL 1.5
     RECT-655 AT ROW 8.91 COL 1.5
     RECT-658 AT ROW 2.67 COL 36.67 WIDGET-ID 8
     RECT-659 AT ROW 2.57 COL 63.67 WIDGET-ID 12
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 147.5 BY 26.67
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
         HEIGHT             = 26.71
         WIDTH              = 147
         MAX-HEIGHT         = 45.81
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.81
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
/* BROWSE-TAB br_tlt fi_filename fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

ASSIGN 
       bu_file-2:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR COMBO-BOX cb_agent-2 IN FRAME fr_main
   ALIGN-L                                                              */
ASSIGN 
       cb_producer:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR COMBO-BOX cb_search IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_Agent-2 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_process IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_search IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
THEN c-wins:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_tlt
/* Query rebuild information for BROWSE br_tlt
     _TblList          = "stat.tlt"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > stat.tlt.releas
"tlt.releas" ? "x(16)" "character" ? ? ? ? ? ? no ? no no "11.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > stat.tlt.datesent
"tlt.datesent" ? ? "date" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > stat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "เลขรับแจ้งฯ,Aycl" "x(20)" "character" ? ? ? ? ? ? no ? no no "19.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > stat.tlt.recac
"tlt.recac" "Contract" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > stat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "เลขกรมธรรม์เดิม" "x(20)" "character" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > stat.tlt.comp_pol
"tlt.comp_pol" "Policy New." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > stat.tlt.ins_name
"tlt.ins_name" ? "x(60)" "character" ? ? ? ? ? ? no ? no no "25.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > stat.tlt.safe2
"tlt.safe2" "ICno." "x(15)" "character" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > stat.tlt.ins_addr1
"tlt.ins_addr1" ? ? "character" ? ? ? ? ? ? no ? no no "17.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > "_<CALC>"
"tlt.ins_addr2 + "" "" + tlt.ins_addr3" "ที่อยู่ผู้เอาประกัน 2" "x(50)" ? ? ? ? ? ? ? no ? no no "20.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > stat.tlt.ins_addr4
"tlt.ins_addr4" "ที่อยู่ผู้เอาประกัน 3" ? "character" ? ? ? ? ? ? no ? no no "15.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   = stat.tlt.ins_addr5
     _FldNameList[13]   > stat.tlt.lince1
"tlt.lince1" ? "x(30)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > stat.tlt.lince2
"tlt.lince2" "ปีรถ" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > stat.tlt.model
"tlt.model" ? ? "character" ? ? ? ? ? ? no ? no no "12.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > stat.tlt.brand
"tlt.brand" ? ? "character" ? ? ? ? ? ? no ? no no "8.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   = stat.tlt.trndat
     _FldNameList[18]   > stat.tlt.rec_addr4
"tlt.rec_addr4" "agent code" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > stat.tlt.comp_usr_ins
"tlt.comp_usr_ins" "ผู้รับผลประโยชน์" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   = stat.tlt.usrid
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
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


&Scoped-define BROWSE-NAME br_tlt
&Scoped-define SELF-NAME br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON LEFT-MOUSE-DBLCLICK OF br_tlt IN FRAME fr_main
DO:
    GET CURRENT br_tlt.
    nv_recidtlt  =  RECID(tlt).
    
    {&WINDOW-NAME}:HIDDEN  =  YES. 
    RUN  wgw\wgwquay2(INPUT  nv_recidtlt).
    {&WINDOW-NAME}:HIDDEN  =  NO.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON ROW-DISPLAY OF br_tlt IN FRAME fr_main
DO:
  IF brstat.tlt.EXP = "CA" THEN DO:
      /*brstat.tlt.releas : FGCOLOR IN BROWSE br_tlt = 5 NO-ERROR. */
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     GET  CURRENT  br_tlt.
     nv_rectlt =  RECID(tlt).
     fi_name   = tlt.ins_name.
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


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-wins
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
        fi_inputfile  = cvData.
        DISP fi_inputfile WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file-2 c-wins
ON CHOOSE OF bu_file-2 IN FRAME fr_main /* ... */
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
        ASSIGN 
            fi_filename2  = cvData
            fi_outfile    = SUBSTR(cvData,1,LENGTH(cvData) - 4 ) + "_" +
                            STRING(DAY(TODAY),"99")      + 
                            STRING(MONTH(TODAY),"99")    + 
                            STRING(YEAR(TODAY),"9999")      + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".csv".
             

        DISP fi_filename2 fi_outfile WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imp c-wins
ON CHOOSE OF bu_imp IN FRAME fr_main /* Import */
DO:
    IF  fi_inputfile = "" THEN DO:
        MESSAGE "please input file name ...........!!!" VIEW-AS ALERT-BOX.
        APPLY "Entry"  TO fi_inputfile.
        RETURN NO-APPLY.
    END.
    ELSE DO: 
        /*-- Add Put File A58-0361  --*/
        nv_errfile   = "C:\GWTRANF\" + "AYCAL" + 
                       SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                       SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".err".

        OUTPUT STREAM ns1 TO VALUE(nv_errfile).

        IF ra_Typeload = 1 THEN RUN Import_notification1.
        ELSE RUN Import_notification2.  /* Add By Sarinya C. A61-0349 23/07/2018*/ 

        OUTPUT STREAM ns1 CLOSE.

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    OPEN QUERY br_tlt 
        FOR EACH tlt USE-INDEX  tlt01  WHERE
                 tlt.trndat  >=  fi_trndatfr   AND
                 tlt.trndat  <=  fi_trndatto   AND
                 tlt.genusr   =  "Aycal"       
        NO-LOCK.  
            APPLY "Entry"  TO br_tlt.
            RETURN NO-APPLY.                             
            
        END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_refresh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_refresh c-wins
ON CHOOSE OF bu_refresh IN FRAME fr_main /* Refresh */
DO:
    /*For each tlt   WHERE 
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
        tlt.genusr   =  "Aycal"        .  
        FIND LAST  sicuw.uwm100 USE-INDEX uwm10002  WHERE
            sicuw.uwm100.cedpol = tlt.recac         AND  
            sicuw.uwm100.poltyp = "V70"             NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100  THEN
            ASSIGN 
            tlt.releas   = "Yes"  
            tlt.policy   = uwm100.policy .
        FIND LAST  sicuw.uwm100 USE-INDEX uwm10002  WHERE
            sicuw.uwm100.cedpol = tlt.recac         AND  
            sicuw.uwm100.poltyp = "V72"             NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100  THEN
            ASSIGN 
            tlt.releas   = "Yes"  
            tlt.comp_pol =  uwm100.policy  .
        ASSIGN fi_process = "Update data Aycal " + tlt.nor_noti_tlt .
        DISP fi_process WITH FRAM fr_main.
    END.
    */
    FOR EACH wdetailUP.
        DELETE wdetailUP.
    END.
    For each tlt NO-LOCK  WHERE 
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
        tlt.genusr   =  "Aycal"        .  
        FIND LAST wdetailUP WHERE wdetailUP.PolicyUP = tlt.recac NO-WAIT NO-ERROR .
        IF NOT AVAIL wdetailUP  THEN DO:
            CREATE wdetailUP .
            ASSIGN 
                wdetailUP.PolicyUP = trim(tlt.recac)
                wdetailUP.Company  = "Aycal"  .
        END.

    END.
    FOR EACH wdetailUP NO-LOCK .
        FIND LAST  sicuw.uwm100 USE-INDEX uwm10002   WHERE
            sicuw.uwm100.cedpol = wdetailUP.PolicyUP AND  
            sicuw.uwm100.poltyp = "V70"              NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100  THEN DO:
            FIND LAST tlt WHERE 
                tlt.genusr   =  wdetailUP.Company    AND
                tlt.recac    =  wdetailUP.PolicyUP   NO-ERROR NO-WAIT .
            IF AVAIL tlt THEN 
                ASSIGN 
                tlt.releas   = "Yes"  
                tlt.policy   = uwm100.policy .
        END.
        RELEASE tlt.
        FIND LAST  sicuw.uwm100 USE-INDEX uwm10002   WHERE
            sicuw.uwm100.cedpol = wdetailUP.PolicyUP AND  
            sicuw.uwm100.poltyp = "V72"              NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100  THEN DO:
            FIND LAST tlt WHERE 
                tlt.genusr   =  wdetailUP.Company    AND
                tlt.recac    =  wdetailUP.PolicyUP   NO-ERROR NO-WAIT .
            IF AVAIL tlt THEN 
                ASSIGN 
                tlt.releas   = "Yes"  
                tlt.comp_pol =  uwm100.policy  .
        END.
        RELEASE tlt.

        ASSIGN fi_process = "Update data Aycal " + wdetailUP.PolicyUP .
        DISP fi_process WITH FRAM fr_main.
    END.
    RELEASE tlt.
    Open Query br_tlt 
        For each tlt Use-index  tlt01  NO-LOCK 
        WHERE tlt.trndat  >=   fi_trndatfr   And
              tlt.trndat  <=   fi_trndatto   And
              tlt.genusr   =  "Aycal"       
        BY tlt.nor_noti_tlt.
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
    ELSE RUN proc_report.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_reok2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_reok2 c-wins
ON CHOOSE OF bu_reok2 IN FRAME fr_main /* OK */
DO:
    IF fi_outfile = ""  THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        APPLY "Entry"  TO fi_outfile.
        RETURN NO-APPLY.
    END.
    ELSE DO: 
        IF ra_matkpn <> 6 THEN RUN Import_notificationkpi.
                          ELSE RUN Import_Cancel. /* Add A58-0361 */
    END.

    IF ra_matkpn <> 6 THEN DO: 
        RUN proc_reportmat.

        MESSAGE "Load  Data Complete "  SKIP
                "จำนวนข้อมูลทั้งหมด  "  nv_countdata SKIP
                "จำนวนข้อมูลที่นำเข้า  "  nv_countcomplete VIEW-AS ALERT-BOX INFORMATION.
    END. 
    ELSE DO: /* Add A58-0361 */

        OPEN QUERY br_tlt                      
            FOR EACH tlt WHERE
                     tlt.genusr    =  "Aycal"      AND
                     tlt.releas    =  "CA"         NO-LOCK.  

        MESSAGE "Match Data Cancel " SKIP
                "Total Record : " nv_countdata SKIP
                "Total Match  : " nv_countcomplete VIEW-AS ALERT-BOX INFORMATION.
    END.  /* End Add A58-0361 */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_sch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_sch c-wins
ON CHOOSE OF bu_sch IN FRAME fr_main /* Search */
DO:
    IF  cb_search =  "ชื่อลูกค้า"  THEN DO:               /* name  */
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01 WHERE
                     tlt.trndat   >=  fi_trndatfr  AND
                     tlt.trndat   <=  fi_trndatto  AND
                     tlt.genusr    =  "Aycal"      AND
                     tlt.releas   <>  "CA"         AND
               INDEX(tlt.ins_name,TRIM(fi_search)) <> 0 NO-LOCK.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                APPLY "Entry"  TO br_tlt.
                RETURN NO-APPLY.            
    END.
    ELSE IF  cb_search  = "Contract/เลขที่สัญญา"  THEN DO:
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01 WHERE
                     tlt.trndat   >=  fi_trndatfr  AND 
                     tlt.trndat   <=  fi_trndatto  AND 
                     tlt.genusr    =  "Aycal"      AND 
                     tlt.releas   <>  "CA"         AND
                     tlt.recac    = TRIM(fi_search)  NO-LOCK.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  TO br_tlt.      
                RETURN NO-APPLY.  
    END.
    ELSE If  cb_search  =  "เลขรับแจ้ง"  THEN DO:        /* cedpol */  
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01 WHERE
            tlt.trndat   >=  fi_trndatfr  AND 
            tlt.trndat   <=  fi_trndatto  AND 
            tlt.genusr    =  "Aycal"      AND 
            tlt.releas   <>  "CA"         AND
            tlt.nor_noti_tlt    = TRIM(fi_search) NO-LOCK.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                APPLY "Entry"  TO br_tlt.      
                RETURN NO-APPLY.               
    END. 
    ELSE IF  cb_search  =  "กรมธรรม์เดิม"  THEN DO:        /* prepol */  
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01 WHERE
            tlt.trndat   >=  fi_trndatfr  AND 
            tlt.trndat   <=  fi_trndatto  AND 
            tlt.genusr    =  "Aycal"      AND 
            tlt.releas   <>  "CA"         AND
            tlt.nor_noti_ins    = TRIM(fi_search) NO-LOCK.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                APPLY "Entry"  TO br_tlt.      
                RETURN NO-APPLY.               
    END. 
    ELSE IF  cb_search  =  "สาขา"  THEN DO:             /* "สาขา" */
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01 WHERE
            tlt.trndat   >=  fi_trndatfr  AND 
            tlt.trndat   <=  fi_trndatto  AND 
            tlt.genusr    =  "Aycal"      AND 
            tlt.releas   <>  "CA"         AND
            tlt.comp_usr_tlt =  TRIM(fi_search) NO-LOCK.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                APPLY "Entry"  TO br_tlt.      
                RETURN NO-APPLY.               
    END.  
    ELSE IF  cb_search  =  "ทะเบียนรถ"  THEN DO:         /* "ทะเบียนรถ" */
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01 WHERE
            tlt.trndat   >=  fi_trndatfr  AND 
            tlt.trndat   <=  fi_trndatto  AND 
            tlt.genusr    =  "Aycal"      AND 
            tlt.releas   <>  "CA"         AND
            INDEX(tlt.lince1,TRIM(fi_search)) <> 0 NO-LOCK.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                APPLY "Entry"  TO br_tlt.      
                RETURN NO-APPLY.               
    END.  
    ELSE IF  cb_search  =  "Chassis"  THEN DO:         /* chassis...*/
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01 WHERE
            tlt.trndat   >=  fi_trndatfr  AND
            tlt.trndat   <=  fi_trndatto  AND
            tlt.genusr    =  "Aycal"      AND
            tlt.releas   <>  "CA"         AND
            tlt.cha_no    =  TRIM(fi_search) NO-LOCK.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                APPLY "Entry"  TO br_tlt.  
                RETURN NO-APPLY.           
    END.                                   
    ELSE IF  cb_search  =  "Complete"  THEN DO:         /* complete..*/
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01 WHERE
            tlt.trndat   >=  fi_trndatfr  AND
            tlt.trndat   <=  fi_trndatto  AND
            tlt.genusr    =  "Aycal"      AND
            tlt.releas   <>  "CA"         AND
            INDEX(tlt.OLD_eng,"not") = 0  NO-LOCK.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                APPLY "Entry"  TO br_tlt.      
                RETURN NO-APPLY.               
    END.                                       
    ELSE IF  cb_search  =  "Not complete"  THEN DO:         /* not ..complete... */
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01  WHERE
            tlt.trndat   >=  fi_trndatfr   AND
            tlt.trndat   <=  fi_trndatto   AND
            tlt.genusr    =  "Aycal"       AND
            tlt.releas   <>  "CA"          AND
            INDEX(tlt.OLD_eng,"not")  <> 0 NO-LOCK.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                APPLY "Entry"  TO br_tlt.
                RETURN NO-APPLY.                             
    END.  
    ELSE IF  cb_search  =  "Release Yes" THEN DO:         /* not ..complete... */
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01 WHERE
            tlt.trndat  >=  fi_trndatfr   AND
            tlt.trndat  <=  fi_trndatto   AND
            tlt.genusr   =   "Aycal"      AND
            tlt.releas  =   "Yes"         NO-LOCK.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                APPLY "Entry"  TO br_tlt.
                RETURN NO-APPLY.                             
    END.
    ELSE IF  cb_search  =  "Release No"  THEN DO:         /* not ..complete... */
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01 WHERE
            tlt.trndat   >=  fi_trndatfr  AND
            tlt.trndat   <=  fi_trndatto  AND
            tlt.genusr    =  "Aycal"      AND
            tlt.releas    =  "No"         NO-LOCK.
                APPLY "Entry"  TO br_tlt.
                RETURN NO-APPLY.                             
    END.   
    ELSE IF cb_search = "Cancel" THEN DO:                /* File Cancel */ /*Add A58-0361*/
        OPEN QUERY br_tlt                      
            FOR EACH tlt USE-INDEX  tlt01 WHERE
            tlt.trndat   >=  fi_trndatfr  AND
            tlt.trndat   <=  fi_trndatto  AND
            tlt.genusr    =  "Aycal"      AND
            tlt.releas    =  "CA"         NO-LOCK.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                APPLY "Entry"  TO br_tlt.
                RETURN NO-APPLY.   
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_upyesno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upyesno c-wins
ON CHOOSE OF bu_upyesno IN FRAME fr_main /* YES/NO */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt.
    If  avail tlt Then do:
        If  index(tlt.releas,"No")  =  0  Then do:  /* yes */
            message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "NO" .
            ELSE IF index(tlt.releas,"Cancel/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "Cancel/no" .
            ELSE ASSIGN tlt.releas  =  "no" .
        END.
        Else do:    /* no */
            If  index(tlt.releas,"Yes")  =  0  Then do:  /* yes */
            message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "Yes" .
            ELSE IF index(tlt.releas,"Cancel/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "Cancel/Yes" .
            ELSE ASSIGN tlt.releas  =  "Yes" .
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


&Scoped-define SELF-NAME cb_agent-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_agent-2 c-wins
ON VALUE-CHANGED OF cb_agent-2 IN FRAME fr_main
DO:
  cb_agent-2 = INPUT cb_agent-2.
  fi_agent-2 = INPUT cb_agent-2.
  DISP fi_agent-2 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_producer c-wins
ON VALUE-CHANGED OF cb_producer IN FRAME fr_main
DO:
  cb_producer = INPUT cb_producer.
  fi_producer = INPUT cb_producer.
  DISP fi_producer WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON LEAVE OF cb_report IN FRAME fr_main
DO:
  
  
    /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat2 = INPUT cb_report.

    IF n_asdat2 = "" THEN DO:
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
    n_asdat2 =  (INPUT cb_report).
    IF      cb_report = "สาขา"               THEN DO:  
        ASSIGN fi_report = " ระบุสาขา"  .  
        DISP fi_report WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_reportdata .
        RETURN NO-APPLY.
    END.
    ELSE IF cb_report = "ประเภทความคุ้มครอง" THEN DO:  
        ASSIGN fi_report = " ระบุประเภท" .   
        DISP fi_report WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_reportdata .
        RETURN NO-APPLY.
    END.    
    ELSE DO:
        ASSIGN fi_report = ""
               fi_reportdata = "" .   
        DISP fi_report WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_filename .
        RETURN NO-APPLY.
    END.  
    IF n_asdat2 = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล การค้น" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
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


&Scoped-define SELF-NAME fi_Agent-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Agent-2 c-wins
ON LEAVE OF fi_Agent-2 IN FRAME fr_main
DO:
  fi_agent-2 = INPUT fi_agent-2.
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
    fi_filename2 = INPUT fi_filename2.
    DISP fi_filename2 WITH FRAM fr_main.

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


&Scoped-define SELF-NAME fi_loaddate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddate c-wins
ON LEAVE OF fi_loaddate IN FRAME fr_main
DO:
    fi_loaddate  =  Input  fi_loaddate.
    Disp fi_loaddate  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile c-wins
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
    fi_outfile = INPUT fi_outfile.
    DISP fi_outfile  WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Producer c-wins
ON LEAVE OF fi_Producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_reportdata
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_reportdata c-wins
ON LEAVE OF fi_reportdata IN FRAME fr_main
DO:
    fi_reportdata = trim( INPUT fi_reportdata ).
    Disp  fi_reportdata  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
    fi_search     =  Input  fi_search .
    Disp fi_search  with frame fr_main.
    If  cb_search =  "ชื่อลูกค้า"  Then do:               /* name  */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Aycal"       And
            index(tlt.ins_name,trim(fi_search)) <> 0 no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE IF  cb_search  = "Contract/เลขที่สัญญา"  THEN DO:
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And 
            tlt.trndat   <=  fi_trndatto  And 
            tlt.genusr    =  "Aycal"       And 
            tlt.recac    = trim(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  to br_tlt.      
                Return no-apply.  
    END.
    ELSE If  cb_search  =  "เลขรับแจ้ง"  Then do:        /* cedpol */  
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And 
            tlt.trndat   <=  fi_trndatto  And 
            tlt.genusr    =  "Aycal"       And 
            tlt.nor_noti_tlt    = trim(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END. 
    ELSE If  cb_search  =  "กรมธรรม์เดิม"  Then do:        /* prepol */  
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And 
            tlt.trndat   <=  fi_trndatto  And 
            tlt.genusr    =  "Aycal"       And 
            tlt.nor_noti_ins    = trim(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END. 
    ELSE If  cb_search  =  "สาขา"  Then do:             /* "สาขา" */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And 
            tlt.trndat   <=  fi_trndatto  And 
            tlt.genusr   =  "Aycal"        And 
            tlt.comp_usr_tlt =  trim(fi_search)    no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END.  
    ELSE If  cb_search  =  "ทะเบียนรถ"  Then do:         /* "ทะเบียนรถ" */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And 
            tlt.trndat   <=  fi_trndatto  And 
            tlt.genusr    =  "Aycal"       And 
            index(tlt.lince1,trim(fi_search)) <> 0     no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END.  
    ELSE If  cb_search  =  "Chassis"  Then do:         /* chassis...*/
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr   =  "Aycal"        And
            tlt.cha_no   =  trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.                                   
    ELSE If  cb_search  =  "Complete"  Then do:         /* complete..*/
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr   =  "Aycal"       And
            INDEX(tlt.OLD_eng,"not") = 0       no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END.                                       
    ELSE If  cb_search  =  "Not complete"  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr   =  "Aycal"      And
            INDEX(tlt.OLD_eng,"not")  <> 0     no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.  
    ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
           tlt.genusr   =  "Aycal"       And
            tlt.releas          =  "Yes"       no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr   =  "Aycal"       And
            tlt.releas          =  "No"       no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Sarinya C A61-0349*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.                   
     
               
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


&Scoped-define SELF-NAME ra_matkpn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_matkpn c-wins
ON VALUE-CHANGED OF ra_matkpn IN FRAME fr_main
DO:
  ra_matkpn = INPUT ra_matkpn.
  DISP ra_matkpn WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_Typeload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_Typeload c-wins
ON VALUE-CHANGED OF ra_Typeload IN FRAME fr_main
DO:
  ra_Typeload = INPUT ra_Typeload.
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
    /*RECT-346:Move-to-top(). */
    /********************  T I T L E   F O R  C - W I N  ****************/
    DEF  VAR  gv_prgid   AS   CHAR.
    DEF  VAR  gv_prog    AS   CHAR.
    gv_prgid = "wgwquay1".
    gv_prog  = "Query & Update DATA Detail By AYCAL...".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

    ASSIGN 
        fi_loaddate = TODAY
        fi_trndatfr = TODAY
        fi_trndatto = TODAY
        vAcProc_fil = vAcProc_fil   + "ชื่อลูกค้า"   + "," 
                                    + "Contract/เลขที่สัญญา" + "," 
                                    + "เลขรับแจ้ง" + "," 
                                    + "กรมธรรม์เดิม" + "," 
                                    + "สาขา"         + ","   
                                    + "ทะเบียนรถ"    + ","   
                                    + "Chassis"      + "," 
                                    + "Complete"     + "," 
                                    + "Not complete" + "," 
                                    + "Release Yes"  + "," 
                                    + "Release No"   + "," 
                                    + "Cancel"       + ","
                                    
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil2 = vAcProc_fil2 + "สาขา"         + ","    
                                    + "ประเภทความคุ้มครอง"    + ","    
                                    + "Complete"     + "," 
                                    + "Not complete" + "," 
                                    + "Release Yes"  + "," 
                                    + "Release No"   + ","
                                    + "All"          + ","
        cb_report:LIST-ITEMS = vAcProc_fil2
        cb_report = ENTRY(1,vAcProc_fil2)
        fi_report =  " ระบุสาขา"   
        ra_matkpn = 1
        /*fi_agent-2  = "B300303"  /*A59-0451*/*/ /*A61-0349*/
        fi_Agent-2    = "B3W0100" /*A61-0349*/
        /*fi_agent  = "B300303".  /*A58-0384*/-Comment Jiraphon A59-0451*/
        fi_producer  = "A0M0062"  /*A59-0451*/
        ra_Typeload  = 1     .     /*A61-0349*/


    RUN Open_tlt.

    /*
        fi_inputfile = "D:\AYCL\AYCAL V70\New folder\KPI 28-09-59 จำนวน 5 คัน-1.csv".
        DISP fi_inputfile WITH FRAME fr_main.

    /*  pui */*/


    DISP ra_matkpn fi_loaddate cb_search cb_report fi_trndatfr  fi_trndatto fi_report fi_agent-2 fi_producer ra_Typeload WITH FRAME fr_main.
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
  DISPLAY fi_name ra_Typeload fi_loaddate fi_inputfile ra_matkpn fi_trndatfr 
          cb_producer fi_Producer fi_trndatto fi_filename2 fi_outfile cb_search 
          fi_search cb_report fi_reportdata fi_process fi_report fi_filename 
          cb_agent-2 fi_Agent-2 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE bu_update bu_upyesno fi_name ra_Typeload fi_loaddate fi_inputfile 
         bu_file bu_imp ra_matkpn fi_trndatfr cb_producer fi_Producer bu_ok 
         fi_trndatto fi_filename2 bu_file-2 bu_reok2 fi_outfile cb_search 
         bu_sch fi_search cb_report fi_reportdata bu_refresh bu_reok bu_exit 
         fi_report fi_filename br_tlt cb_agent-2 fi_Agent-2 RECT-502 RECT-503 
         RECT-504 RECT-522 RECT-523 RECT-498 RECT-524 RECT-525 RECT-526 
         RECT-527 RECT-499 RECT-500 RECT-528 RECT-654 RECT-655 RECT-658 
         RECT-659 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_Cancel c-wins 
PROCEDURE Import_Cancel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Add A58-0361    
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
ASSIGN
    nv_countdata     = 0
    nv_countcomplete = 0.

INPUT FROM VALUE(fi_filename2).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.renew         /*  1.ลำดับ       */
        wdetail.Branch        /*  2.Branch      */
        wdetail.Contract      /*  3.เลขสัญญา    */
        wdetail.Codecompany   /*  4.บริษัท      */
        wdetail.vehreg        /*  5.ทะเบียน     */ 
        wdetail.chassis       /*  6.เลขตัวถัง   */
        wdetail.policy        /*  7.เลขรับแจ้ง  */ 
        wdetail.name1         /*  8.NAME        */
        wdetail.comdat70      /*  9.วันคุ้มครอง */
        wdetail.remak         /*  10.เหตุผล     */
        wdetail.provin.       /*  11.หมายเหตุ   */
END.

/*--
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|"
    "ลำดับ"
    "Branch"
    "เลขสัญญา"
    "บริษัท"
    "ทะเบียนรถ"
    "เลขตัวถัง"
    "เลขรับแจ้ง"
    "ชื่อ"
    "วันคุ้มครอง"
    "เหตุผล"
    "หมายเหตุ".*/

FOR EACH wdetail.

    IF wdetail.chassis <> "" THEN DO: 
        nv_countdata = nv_countdata + 1.

        RUN proc_cutpolicy.
    
       /* MESSAGE 
            wdetail.renew      
            wdetail.Branch     
            wdetail.Contract   
            wdetail.Codecompany
            wdetail.vehreg     
            wdetail.chassis    
            wdetail.policy     
            wdetail.name1      
            wdetail.comdat70   
            wdetail.remak      
            wdetail.provin.  */
        FIND FIRST brstat.tlt USE-INDEX tlt06 WHERE 
                   brstat.tlt.cha_no = TRIM(wdetail.chassis) AND
                   brstat.tlt.genusr = "aycal" NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
            ASSIGN 
                brstat.tlt.releas  = "CA"
                brstat.tlt.OLD_cha = tlt.OLD_cha + "|" + wdetail.remak
                brstat.tlt.EXP     = "ยกเลิกเลขรับแจ้งแล้ว"
                wdetail.provin     = "CANCEL : ยกเลิกเลขรับแจ้งแล้ว".
    
            nv_countcomplete = nv_countcomplete + 1.
        END.
        ELSE DO:
            wdetail.provin = "Not Complete".
        END.
    END.

END.

OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|"
    "ลำดับ"
    "Branch"
    "เลขสัญญา"
    "บริษัท"
    "ทะเบียนรถ"
    "เลขตัวถัง"
    "เลขรับแจ้ง"
    "ชื่อ"
    "วันคุ้มครอง"
    "เหตุผล"
    "หมายเหตุ".

FOR EACH wdetail WHERE wdetail.provin = "Not Complete" :
    EXPORT DELIMITER "|"
        wdetail.renew       
        wdetail.Branch      
        wdetail.Contract    
        wdetail.Codecompany 
        wdetail.vehreg      
        wdetail.chassis     
        wdetail.policy      
        wdetail.name1       
        wdetail.comdat70    
        wdetail.remak       
        wdetail.provin  .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notification1 c-wins 
PROCEDURE Import_notification1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR n_undyr     AS CHARACTER FORMAT "X(4)"  NO-UNDO.
DEFINE VAR n_notifyno  AS CHARACTER FORMAT "X(20)" NO-UNDO.
DEFINE VAR nv_message  AS CHARACTER                NO-UNDO.
DEFINE VAR n_running   AS INTE.
DEFINE VAR n_polno     AS CHAR FORMAT "X(8)".
DEFINE VAR nv_err      AS LOGICAL.
DEFINE VAR nv_complete AS INTE.
DEFINE VAR nv_ncomplete AS INTE.

FOR EACH wdetail:
    DELETE wdetail.
END.

INPUT FROM VALUE(fi_inputfile).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"
        wdetail.Seqno         /*  1   Seq.    1   */                                  
        wdetail.Company       /*  2   Company AYCAL   */                          
        wdetail.Porduct       /*  3   Porduct HP  */                                  
        wdetail.Branch        /*  4   Branch  17  */                                  
        wdetail.Contract      /*  5   Contract    TU03590 */                   
        wdetail.nTITLE        /*  6   ชื่อ+นามสกุล    นาย */                                                   
        wdetail.name1         /*  7   สมชาย   */                     
        wdetail.name2         /*  8   พลไกร   */                     
        wdetail.addr1         /*  9   ที่อยู่ 17/2 ม.2    */                   
        wdetail.addr2         /*  10  ต.ขุนศรี อ.ไทรน้อย  */ 
        wdetail.addr3         /*  11  นนทบุรี */                                          
        wdetail.addr4         /*  12  11150   */                        
        wdetail.brand         /*  13  ยี่ห้อรถ    TOY */                          
        wdetail.model         /*  14  รุ่นรถ  FORTUNER TRD    */                  
        wdetail.coler         /*  15  สี  ขาว */                                          
        wdetail.vehreg        /*  16  เลขทะเบียน  ฎฉ 9525 */                      
        wdetail.provin        /*  17  จังหวัดที่จดทะเบียน กรุงเทพมหานคร   */      
        wdetail.caryear       /*  18  ปีรถ    2009    */                          
        wdetail.cc            /*  19  CC. 2982    */                              
        wdetail.chassis       /*  20  เลขตัวถัง   MR0YZ59G200090615   */          
        wdetail.engno         /*  21  เลขเครื่อง  1KD6400738  */                  
        wdetail.notifyno      /*  22  Code ผู้แจ้ง    1716    */                  
        wdetail.covcod        /*  23  ประเภท  1   */                              
        wdetail.Codecompany   /*  24  Code บ.ประกัน   KPI */                      
        wdetail.prepol        /*  25  เลขกรมธรรม์เดิม DM7055023011    */          
        wdetail.comdat70      /*  26  วันคุ้มครองประกัน   561019  */              
        wdetail.expdat70      /*  27  วันหมดประกัน    571019  */                      
        wdetail.si            /*  28  ทุนประกัน   38000000    */                  
        wdetail.premt         /*  29  ค่าเบี้ยสุทธิ์  1505151 */                  
        wdetail.premtnet      /*  30  ค่าเบี้ยรวมภาษีอากร 1616884 */ 
        wdetail.other         /*  31  539000  */                                                             
        wdetail.renew         /*  32  ปีประกัน    5   */                                       
        wdetail.policy        /*  33  เลขรับแจ้ง  STAY13-0349 */        
        wdetail.idno          /*  34  เลขบัตรประชาชน */                                                                   
        wdetail.remak         /*  35  หมายเหตุ. */                                                                               
        wdetail.notifydate    /*  36  วันที่แจ้ง  560821  */                                              
        wdetail.Deduct        /*  37  Deduct */                                                          
        wdetail.Codecompa72   /*  38  Code บ.ประกัน พรบ. */                                                  
        wdetail.comdat72      /*  39  วันคุ้มครองพรบ.*/                                                          
        wdetail.expdat72      /*  40  วันหมดพรบ. */                                                      
        wdetail.comp          /*  41  ค่าพรบ.*/                                                              
        wdetail.driverno      /*  42  ระบุผู้ขับขี่ */                                             
        wdetail.garage        /*  43  ซ่อมห้าง */                                                      
        wdetail.access        /*  44  คุ้มครองอุปกรณ์เพิ่มเติม */
        wdetail.endoresadd .  /*  45  แก้ไขที่อยู่  */
    
END.

ASSIGN
    nv_countdata     = 0
    nv_countcomplete = 0
    nv_ncomplete     = 0
    nv_complete      = 0.

FOR EACH wdetail.

    nv_err = NO.

    IF INDEX(wdetail.seqno,"seq") <> 0 THEN DELETE wdetail.
    ELSE IF wdetail.seqno <> "" THEN DO:

        IF wdetail.nTITLE = "น.ส." THEN wdetail.nTITLE = "นางสาว"   . /*Add By Sarinya A61-0371*/

        ASSIGN putchr  = ""
               putchr1 = ""
               textchr = STRING(TRIM(wdetail.Contract),"X(16)") + " " +
                         TRIM(wdetail.nTITLE) + " " +  
                         TRIM(wdetail.name1)  + " " + 
                         TRIM(wdetail.name2).

        ASSIGN
            np_addr1  = "" 
            np_addr2  = "" 
            np_addr3  = "" 
            np_addr4  = "" 
            np_addr5  = ""   /*Add Jiraphon A59-0451*/
            nv_prov   = ""  
            nv_amp    = ""
            nv_tum    = ""

            nv_countdata = nv_countdata  + 1 
            np_addrall     = TRIM(wdetail.addr1) + " " +                      
                           TRIM(wdetail.addr2) + " " +                       
                           TRIM(wdetail.addr3) + " " +
                           TRIM(wdetail.addr4) .

        RUN proc_cutaddr.

        RUN proc_cutpolicy.

        RUN proc_chkdatesent.  /*A58-00384*/

        FIND FIRST tlt WHERE tlt.cha_no   = TRIM(wdetail.chassis) AND
                             tlt.datesent = n_datesent            AND  /*A58-00384*/
                             tlt.genusr   = "aycal"               NO-ERROR NO-WAIT.
        IF NOT AVAIL tlt THEN DO:
            ASSIGN
                nv_countcomplete = nv_countcomplete + 1
                n_undyr          = STRING(YEAR(TODAY) + 543 ,"9999")
                nv_message       = "" .

            running_polno: /*-- Running --*/
            REPEAT:
                n_running = n_running + 1.

                RUN wgw\wgwpolay (INPUT        YES,
                                  INPUT        "V70", 
                                  INPUT        "STY", 
                                  INPUT        n_undyr,
                                  INPUT        "A0M0061",
                                  INPUT-OUTPUT n_notifyno,   
                                  INPUT-OUTPUT nv_message). 
                IF nv_message <> "" THEN DO:
                    /*Put Text MESSAGE nv_message VIEW-AS ALERT-BOX.*/
                    IF n_running > 10 THEN DO: 
                        n_notifyno = "".
                        LEAVE running_polno.
                    END.
                END.

                FIND LAST tlt WHERE tlt.genusr       = "aycal"    AND
                                    tlt.nor_noti_tlt = n_notifyno NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAIL tlt THEN LEAVE running_polno.
            END.

            /*-- Check Running No.A58-0361 --*/
            IF n_notifyno = "" THEN DO:
                n_polno    = SUBSTR(wdetail.Contract,1,8).
                n_notifyno = "STY" + SUBSTR(STRING(YEAR(TODAY)),3,2) + STRING(n_polno,"99999999").

                FIND LAST tlt WHERE tlt.genusr       = "aycal"    AND
                                    tlt.nor_noti_tlt = n_notifyno NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL tlt THEN DO:
                    /*Put Text "Avail Notify No. Not Transfer to System" */
                    ASSIGN
                        putchr1 = "Avail Notify No. Not Transfer to System"
                        putchr  = textchr  + "  " + TRIM(putchr1).
        
                    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                    nv_message = putchr1.
                    nv_err     = YES.
                    nv_ncomplete = nv_ncomplete + 1.
                END.
            END.
            /*-- End A58-0361 --*/
           
            IF nv_err = NO THEN DO: 
                CREATE tlt.
                ASSIGN
                    tlt.entdat         = TODAY
                    tlt.enttim         = STRING(TIME,"HH:MM:SS")
                    tlt.trntime        = STRING(TIME,"HH:MM:SS")
                    tlt.trndat         = TODAY
                    tlt.genusr         = "aycal"                       /* 2  Company   */
                    tlt.flag           = TRIM(wdetail.Porduct)         /* 3  Porduct   */ 
                    tlt.comp_usr_tlt   = TRIM(wdetail.Branch)          /* 4  Branch    */ 
                    tlt.recac          = TRIM(wdetail.Contract)        /* 5  Contract  */ 
                    tlt.ins_name       = TRIM(wdetail.nTITLE) + " " +  /* 6  คำนำหน้าชื่อ    */ 
                                         TRIM(wdetail.name1)  + " " +  /* 7  ชื่อผู้เอาประกัน    */                  
                                         TRIM(wdetail.name2)           /* 8  นามสกุลผู้เอาประกัน */
                    tlt.ins_addr1      = TRIM(np_addr1)                /* 9  บ้านเลขที่  */                          
                    tlt.ins_addr2      = TRIM(np_addr2)                /*10  ตำบล/แขวง*/                     
                    tlt.ins_addr3      = TRIM(np_addr3)                /*11  อำเภอ/เขต*/                     
                    tlt.ins_addr4      = TRIM(np_addr4)                /*12  จังหวัด*/                               
                    tlt.ins_addr5      = TRIM(np_addr5)           /*    รหัสไปรษณีย์*/   
      
                    tlt.brand          = TRIM(wdetail.brand)           /*13  ยี่ห้อรถ*/                             
                    tlt.model          = TRIM(wdetail.model)           /*14  รุ่นรถ  */                                 
                                                                       /*15  สี  wdetail.coler*/
                    tlt.lince1         = TRIM(wdetail.vehreg) + " " +  /*16  เลขทะเบียน  */        
                                         TRIM(wdetail.provin)          /*17  จังหวัดที่จดทะเบียน */
                    tlt.lince2         = TRIM(wdetail.caryear)         /*18  ปีรถ*/             
                    tlt.cc_weight      = DECI(wdetail.cc)              /*19  CC.*/                 
                    tlt.cha_no         = TRIM(wdetail.chassis)         /*20  เลขตัวถัง*/                      
                    tlt.eng_no         = TRIM(wdetail.engno)           /*21  เลขเครื่อง*/
                    tlt.comp_noti_tlt  = TRIM(wdetail.notifyno)        /*22 Code ผู้แจ้ง*/
                    tlt.safe3          = TRIM(wdetail.covcod)          /*23  ประเภท*/            
                    tlt.nor_usr_ins    = TRIM(wdetail.Codecompany)     /*24  Code บ.ประกัน*/      
                    tlt.nor_noti_ins   = TRIM(wdetail.prepol)          /*25  เลขกรมธรรม์เดิม*/             
                    tlt.nor_effdat     = DATE(SUBSTR(TRIM(wdetail.comdat70),5,2) + "/" +
                                         SUBSTR(TRIM(wdetail.comdat70),3,2) + "/" +
                                         STRING(DECI("25" + SUBSTR(TRIM(wdetail.comdat70),1,2)) - 543))   /*26  วันคุ้มครองประกัน*/         
                    tlt.expodat        = DATE(SUBSTR(TRIM(wdetail.expdat70),5,2) + "/" +
                                         SUBSTR(TRIM(wdetail.expdat70),3,2) + "/" +
                                         STRING(DECI("25" + SUBSTR(TRIM(wdetail.expdat70),1,2)) - 543))   /*27  วันหมดประกัน*/ 
                    tlt.comp_coamt     = IF DECI(wdetail.si) = 0 THEN 0 ELSE DECI(wdetail.si) / 100       /*28  ทุนประกัน*/                 
                    tlt.dri_name2      = STRING(DECI(wdetail.premt) / 100 )                               /*29  ค่าเบี้ยสุทธิ์*/ 
                    tlt.nor_grprm      = DECI(wdetail.premtnet) / 100                                     /*30  ค่าเบี้ยรวมภาษีอากร */ 
                    tlt.rencnt         = DECI(wdetail.renew)           /*31  ปีประกัน*/                                    
                                                                       /*32  เลขรับแจ้ง   tlt.nor_noti_tlt   = trim(wdetail.policy) */                                    
                    tlt.nor_noti_tlt   =  n_notifyno
                    tlt.safe2          = TRIM(wdetail.idno)
                    tlt.datesent       = IF TRIM(wdetail.notifydate) = "" THEN ? 
                                         ELSE DATE(SUBSTR(TRIM(wdetail.notifydate),5,2) + "/" +     /*33  วันที่แจ้ง*/                                                                     
                                         SUBSTR(TRIM(wdetail.notifydate),3,2) + "/" +
                                         STRING(DECI("25" + SUBSTR(TRIM(wdetail.notifydate),1,2)) - 543))
                    tlt.seqno          = DECI(wdetail.Deduct)          /*34  Deduct*/                                                                                 
                    tlt.nor_usr_tlt    = TRIM(wdetail.Codecompa72)     /*35  Code บ.ประกัน พรบ.*/                                        
                    tlt.comp_effdat    = IF wdetail.comdat72 = "" THEN ? 
                                         ELSE DATE(SUBSTR(TRIM(wdetail.comdat72),5,2) + "/" +   /*36  วันคุ้มครองพรบ.*/ 
                                         SUBSTR(TRIM(wdetail.comdat72),3,2) + "/" +
                                         STRING(DECI("25" + SUBSTR(TRIM(wdetail.comdat72),1,2)) - 543))
                    tlt.dat_ins_noti   = IF wdetail.expdat72 = "" THEN ? 
                                         ELSE DATE(SUBSTR(TRIM(wdetail.expdat72),5,2) + "/" +      /*37  วันหมดพรบ.*/ 
                                         SUBSTR(TRIM(wdetail.expdat72),3,2) + "/" +
                                         STRING(DECI("25" + SUBSTR(TRIM(wdetail.expdat72),1,2)) - 543))
                    tlt.dri_no1        = TRIM(wdetail.comp)             /*38  ค่าพรบ. */                                                              
                    tlt.dri_name1      = IF TRIM(wdetail.driverno) = "" THEN "2" ELSE "1"        /*39  ระบุผู้ขับขี่*/
                    tlt.stat           = TRIM(wdetail.garage)           /*40  ซ่อมห้าง*/                                                        
                    tlt.safe1          = TRIM(wdetail.access)           /*41  คุ้มครองอุปกรณ์เพิ่มเติม*/                                   
                    tlt.filler1        = TRIM(wdetail.endoresadd)       /*42  แก้ไขที่อยู่ */                                                
                    tlt.filler2        = TRIM(wdetail.remak)            /*43  หมายเหตุ*/          
                    tlt.OLD_eng        =  "complete"    
                    tlt.endno          = USERID(LDBNAME(1))   /*User Load Data */
                    tlt.imp            = "IM"                 /*Import Data    */
                    tlt.releas         = "No"    
                    /*Add Jiraphon A59-0451*/
                    tlt.rec_addr4       = fi_agent-2  /*Agent code*/
                    company    = wdetail.Company.
                        IF company = "AYCAL" THEN ASSIGN tlt.comp_usr_ins = "อยุธยา แคปปิตอล ออโต้ลิส จำกัด (มหาชน)" .
                        ELSE IF company = "BAY" THEN ASSIGN tlt.comp_usr_ins = "ธนาคารกรุงศรีอยุธยา จำกัด (มหาชน)" .
                        ELSE tlt.comp_usr_ins = "ยกเลิก 8.3" .
                    /*End Jiraphon A59-0451*/

               nv_complete = nv_complete + 1.
            END.

        END.
        ELSE DO:

            RUN import_update. /*Jiraphon A59-0451*/
            nv_ncomplete = nv_ncomplete + 1.
            ASSIGN
                putchr1 = "พบข้อมูลดังกล่าวในระบบแล้ว"
                putchr  = textchr  + "  " + TRIM(putchr1).

            PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
            nv_message = putchr1.
        END.
    END.
END.

RUN Open_tlt.

/*-- Add A58-0384 --*/
IF nv_ncomplete = 0 THEN DO:
    nv_errfile = "".
END.

MESSAGE 
    "==========================" SKIP
    "Load  Data Total  : " nv_countdata SKIP
    "==========================" SKIP 
    "            Complete : " nv_complete  SKIP
    "     Not Complete : " nv_ncomplete SKIP 
    "==========================" SKIP(1)
    "File Not Load : " nv_errfile      SKIP
VIEW-AS ALERT-BOX INFORMATION.
/*-- End A58-0384 --*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notification2 c-wins 
PROCEDURE Import_notification2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR n_undyr      AS CHARACTER FORMAT "X(4)"  NO-UNDO.
DEFINE VAR n_notifyno   AS CHARACTER FORMAT "X(20)" NO-UNDO.
DEFINE VAR nv_message   AS CHARACTER                NO-UNDO.
DEFINE VAR n_running    AS INTE.
DEFINE VAR n_polno      AS CHAR FORMAT "X(8)".
DEFINE VAR nv_err       AS LOGICAL.
DEFINE VAR nv_complete  AS INTE.
DEFINE VAR nv_ncomplete AS INTE.
DEFINE VAR Choice       AS LOGICAL   INIT NO NO-UNDO.
DEFINE VAR nv_update    AS LOGICAL INIT NO.
FOR EACH wdetail: DELETE wdetail. END.
INPUT FROM VALUE(fi_inputfile).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"
        wdetail.Company            /* 1   COMPANY CODE              */                   
        wdetail.Porduct            /* 2   PRODUCT CODE              */  
        wdetail.Branch             /* 3   BRANCH CODE               */  
        wdetail.Contract           /* 4   CONTRACT NO.              */  
        wdetail.nTITLE             /* 5   CUSTOMER THAI TITLE       */  
        wdetail.name1              /* 6   FIRST NAME - THAI         */  
        wdetail.name2              /* 7   LAST NAME  - THAI         */  
        wdetail.idno               /* 8   CARD NO.                  */  
        wdetail.addr1              /* 9   REGISTER ADDRESS LINE 1   */  
        wdetail.addr2              /* 10  REGISTER ADDRESS LINE 2   */  
        wdetail.addr3              /* 11  REGISTER ADDRESS LINE 3   */  
        wdetail.addr4              /* 12  REGISTER ZIP.CODE         */  
        wdetail.brand              /* 13  ยี่ห้อ                    */  
        wdetail.model              /* 14  รุ่น                      */  
        wdetail.coler              /* 15  สีรถ                      */  
        wdetail.vehreg             /* 16  ทะเบียนรถ                 */  
        wdetail.provin             /* 17  จังหวัด                   */  
        wdetail.caryear            /* 18  ปีรถ                      */  
        wdetail.cc                 /* 19  CC                        */  
        wdetail.chassis            /* 20  เลขตัวถัง                 */  
        wdetail.engno              /* 21  เลขเครื่อง                */  
        wdetail.notifyno           /* 22  CODE ผู้แจ้ง              */  
        Wdetail.AgencyEmployee     /* 23  ชื่อผู้แจ้งงาน            */  
        wdetail.covcod             /* 24  INSURANCE TYPE            */  
        wdetail.Codecompany        /* 25  INSURANCE CODE            */  
        wdetail.prepol             /* 26  เลขกรมธรรม์เก่า           */  
        wdetail.comdat70           /* 27  วันคุ้มครองกธ.            */  
        wdetail.expdat70           /* 28  วันหมดอายุกธ.             */  
        wdetail.si                 /* 29  ทุนประกัน                 */  
        wdetail.siIns              /* 30  เบี้ยประกันรับจากลูกค้า   */  
        wdetail.premt              /* 31  เบี้ยสุทธิ                */  
        wdetail.premtnet           /* 32  เบี้ยรวมภาษี              */  
        wdetail.renew              /* 33  ปีประกัน                  */  
        wdetail.policy             /* 34  เลขที่รับแจ้ง             */  
        wdetail.notifydate         /* 35  วันแจ้งงาน                */  
        wdetail.Deduct             /* 36  DEDUCT AMOUNT             */  
        wdetail.InsCTP             /* 37  INSURER CTP               */  
        wdetail.comdat72           /* 38  วันที่คุ้มครอง พรบ        */  
        wdetail.expdat72           /* 39  วันที่หมด พรบ             */  
        wdetail.comp               /* 40  ค่าเบี้ย พรบ.             */  
        wdetail.driverno           /* 41  ระบุผู้ขับขี่ทั้งหมด      */  
        wdetail.drivername1        /* 42  ผู้ขับขี่คนที่ 1          */  
        wdetail.driverbrith1       /* 43  วันเดือนปีเกิด 1          */  
        wdetail.drivericno1        /* 44  หมายเลขบัตร 1             */
        wdetail.driverCard1        /* 45  DRIVER CARD 1             */
        wdetail.driverexp1         /* 46  DRIVER CARD EXPIRE 1      */  
        wdetail.drivername2        /* 47  ผู้ขับขี่คนที่ 2          */  
        wdetail.driverbrith2       /* 48  วันเดือนปีเกิด 2          */  
        wdetail.drivericno2        /* 49  หมายเลขบัตร 2             */ 
        wdetail.driverCard2        /* 50  DRIVER CARD 2             */
        wdetail.driverexp2         /* 51  DRIVER CARD EXPIRE 2      */  
        wdetail.garage             /* 52  ซ่อมห้าง                  */  
        wdetail.InspectName        /* 53  ชื่อผู้ตรวจรถ             */  
        wdetail.InspectPhoneNo     /* 54  เบอร์โทรศัพท์ผู้ตรวจรถ    */  
        wdetail.access             /* 55  คุ้มครองอุปกรณ์เพิ่มเติม  */  
        wdetail.Benefic            /* 56  ผู้รับผลประโยชน์          */  
        wdetail.Plus12             /* 57  FLAG FOR 12PLUS           */  .

END.
ASSIGN
    nv_countdata     = 0    nv_ncomplete     = 0    nv_countcomplete = 0    nv_complete      = 0.   
FOR EACH wdetail.
    nv_err = NO.
    IF wdetail.nTITLE = "น.ส." THEN wdetail.nTITLE = "นางสาว"   . /*Add By Sarinya A61-0371*/
    IF INDEX(wdetail.Company,"COMPANY") <> 0 THEN DELETE wdetail.
    ELSE IF wdetail.Company <> "" THEN DO:
        ASSIGN putchr  = ""     putchr1 = ""
               textchr = STRING(TRIM(wdetail.Contract),"X(16)") + " " + TRIM(wdetail.nTITLE) + " " + TRIM(wdetail.name1)  + " " + TRIM(wdetail.name2).
        ASSIGN
            np_addr1  = ""  np_addr5  = ""   np_addr2  = ""  nv_prov   = ""   np_addr3  = ""  nv_amp    = ""   np_addr4  = ""  nv_tum    = ""  
            nv_countdata = nv_countdata  + 1 
            np_addrall     = TRIM(wdetail.addr1) + " " + TRIM(wdetail.addr2) + " " + TRIM(wdetail.addr3) + " " + TRIM(wdetail.addr4) .
        RUN proc_cutaddr.
        RUN proc_cutpolicy.
        RUN proc_chkdatesent.
        FIND FIRST tlt WHERE tlt.cha_no   = TRIM(wdetail.chassis) AND
                             tlt.datesent = n_datesent            AND  
                             tlt.genusr   = "aycal"               NO-ERROR NO-WAIT.
        IF NOT AVAIL tlt THEN DO:
            ASSIGN
                nv_countcomplete = nv_countcomplete + 1
                n_undyr          = STRING(YEAR(TODAY) + 543 ,"9999")
                nv_message       = "" .
            running_polno: /*-- Running --*/
            REPEAT:
                n_running = n_running + 1.
                RUN wgw\wgwpolay (INPUT        YES,
                                  INPUT        "V70", 
                                  INPUT        "STY", 
                                  INPUT        n_undyr,
                                  INPUT        "A0M0061",
                                  INPUT-OUTPUT n_notifyno,   
                                  INPUT-OUTPUT nv_message). 
                IF nv_message <> "" THEN DO:
                    IF n_running > 10 THEN DO: 
                        n_notifyno = "".
                        LEAVE running_polno.
                    END.
                END.
                FIND LAST tlt WHERE tlt.genusr       = "aycal"    AND
                                    tlt.nor_noti_tlt = n_notifyno NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAIL tlt THEN LEAVE running_polno.
            END.    
            IF n_notifyno = "" THEN DO:
                n_polno    = SUBSTR(wdetail.Contract,1,8).
                n_notifyno = "STY" + SUBSTR(STRING(YEAR(TODAY)),3,2) + STRING(n_polno,"99999999").

                FIND LAST tlt WHERE tlt.genusr       = "aycal"    AND
                                    tlt.nor_noti_tlt = n_notifyno NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL tlt THEN DO:
                    ASSIGN
                        putchr1 = "Avail Notify No. Not Transfer to System"
                        putchr  = textchr  + "  " + TRIM(putchr1).  
                    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                    nv_message = putchr1.
                    nv_err     = YES.
                    nv_ncomplete = nv_ncomplete + 1.
                END.
            END.
           IF nv_err = NO THEN DO: 
                CREATE tlt.
                ASSIGN
                    tlt.entdat            = TODAY                                                  
                    tlt.enttim            = STRING(TIME,"HH:MM:SS")                            
                    tlt.trntime           = STRING(TIME,"HH:MM:SS")                            
                    tlt.trndat            = TODAY                   
                    tlt.genusr            = "aycal"                       /* 1   COMPANY CODE              */                   
                    tlt.flag              = trim(wdetail.Porduct)         /* 2   PRODUCT CODE              */  
                    tlt.comp_usr_tlt      = trim(wdetail.Branch)          /* 3   BRANCH CODE               */  
                    tlt.recac             = trim(wdetail.Contract)        /* 4   CONTRACT NO.              */  
                    tlt.ins_name          = trim(wdetail.nTITLE) + " " +  /* 5   CUSTOMER THAI TITLE       */  
                                            trim(wdetail.name1)  + " " +  /* 6   FIRST NAME - THAI         */  
                                            trim(wdetail.name2)           /* 7   LAST NAME  - THAI         */  
                    tlt.safe2             = trim(wdetail.idno)            /* 8   CARD NO.                  */  
                    tlt.ins_addr1         = TRIM(np_addr1)                /* 9   REGISTER ADDRESS LINE 1   */  
                    tlt.ins_addr2         = TRIM(np_addr2)                /* 10  REGISTER ADDRESS LINE 2   */  
                    tlt.ins_addr3         = TRIM(np_addr3)                /* 11  REGISTER ADDRESS LINE 3   */  
                    tlt.ins_addr4         = TRIM(np_addr4)                /* 12  REGISTER ADDRESS LINE 4   */  
                    tlt.ins_addr5         = TRIM(np_addr5)                /* 12  REGISTER ZIP.CODE         */ 
                    tlt.brand             = TRIM(wdetail.brand)           /* 13  ยี่ห้อ                    */  
                    tlt.model             = TRIM(wdetail.model)           /* 14  รุ่น                      */  
                    tlt.lince1            = TRIM(wdetail.vehreg) + " " +  /* 16  ทะเบียนรถ                 */  
                                            TRIM(wdetail.provin)          /* 17  จังหวัด                   */  
                    tlt.lince2            = TRIM(wdetail.caryear)         /* 18  ปีรถ                      */  
                    tlt.cc_weight         = DECI(wdetail.cc)              /* 19  CC                        */  
                    tlt.cha_no            = TRIM(wdetail.chassis)         /* 20  เลขตัวถัง                 */  
                    tlt.eng_no            = TRIM(wdetail.engno)           /* 21  เลขเครื่อง                */  
                    tlt.comp_noti_tlt     = TRIM(wdetail.notifyno)        /* 22  CODE ผู้แจ้ง              */  
                    tlt.safe3             = TRIM(wdetail.covcod)          /* 24  INSURANCE TYPE            */  
                    tlt.nor_usr_ins       = TRIM(wdetail.Codecompany)     /* 25  INSURANCE CODE            */  
                    tlt.nor_noti_ins      = TRIM(wdetail.prepol)          /* 26  เลขกรมธรรม์เก่า           */     
                    tlt.nor_effdat        = DATE(SUBSTR(TRIM(wdetail.comdat70),5,2) + "/" +
                                            SUBSTR(TRIM(wdetail.comdat70),3,2) + "/" +
                                            STRING(DECI("25" + SUBSTR(TRIM(wdetail.comdat70),1,2)) - 543))  /* 27  วันคุ้มครองกธ.  */  
                    tlt.expodat           = DATE(SUBSTR(TRIM(wdetail.expdat70),5,2) + "/" +                                        
                                            SUBSTR(TRIM(wdetail.expdat70),3,2) + "/" +                                             
                                            STRING(DECI("25" + SUBSTR(TRIM(wdetail.expdat70),1,2)) - 543))  /* 28  วันหมดอายุกธ.   */  
                    tlt.comp_coamt        = IF DECI(wdetail.si) = 0 THEN 0 ELSE DECI(wdetail.si)     /* 29  ทุนประกัน       */ 
                    tlt.sentcnt           = DECI(wdetail.siIns)         /* 30  เบี้ยประกันรับจากลูกค้า */                            
                    tlt.dri_name2         = STRING(DECI(wdetail.premt)) /* 31  เบี้ยสุทธิ              */  
                    tlt.nor_grprm         = DECI(wdetail.premtnet)      /* 32  เบี้ยรวมภาษี            */  
                    tlt.rencnt            = DECI(wdetail.renew)         /* 33  ปีประกัน                */  
                                                                        /* 32  เลขรับแจ้ง   tlt.nor_noti_tlt   = trim(wdetail.policy) */ 
                    tlt.nor_noti_tlt      = n_notifyno
                    tlt.datesent          = IF TRIM(wdetail.notifydate) = "" THEN ? 
                                            ELSE DATE(SUBSTR(TRIM(wdetail.notifydate),5,2) + "/" +         /*33  วันที่แจ้ง*/                                                                     
                                            SUBSTR(TRIM(wdetail.notifydate),3,2) + "/" +
                                            STRING(DECI("25" + SUBSTR(TRIM(wdetail.notifydate),1,2)) - 543))  
                    tlt.seqno             = DECI(wdetail.Deduct)          /* 36  DEDUCT AMOUNT             */  
                    tlt.comp_effdat       = IF wdetail.comdat72 = "" THEN ? 
                                            ELSE IF wdetail.comdat72 = "0" THEN ?
                                            ELSE DATE(SUBSTR(TRIM(wdetail.comdat72),5,2) + "/" +         /*36  วันคุ้มครองพรบ.*/ 
                                            SUBSTR(TRIM(wdetail.comdat72),3,2) + "/" +
                                            STRING(DECI("25" + SUBSTR(TRIM(wdetail.comdat72),1,2)) - 543))
                    tlt.dat_ins_noti      = IF wdetail.expdat72 = "" THEN ? 
                                            ELSE IF wdetail.expdat72 = "0" THEN ?
                                            ELSE DATE(SUBSTR(TRIM(wdetail.expdat72),5,2) + "/" +        /*37  วันหมดพรบ.*/ 
                                            SUBSTR(TRIM(wdetail.expdat72),3,2) + "/" +
                                            STRING(DECI("25" + SUBSTR(TRIM(wdetail.expdat72),1,2)) - 543))
                    tlt.dri_no1           = TRIM(wdetail.comp)            /* 40  ค่าเบี้ย พรบ.             */  
                    tlt.dri_name1         = IF TRIM(wdetail.driverno) = "" THEN "1" ELSE "2" /* 41  ระบุผู้ขับขี่ทั้งหมด      */  
                    tlt.dri_no2           = "N1:"  + trim(wdetail.drivername1)  + " " +       /* 42 ผู้ขับขี่คนที่ 1     */    
                                            "B1:"  + trim(wdetail.driverbrith1) + " " +       /* 43 วันเดือนปีเกิด 1     */    
                                            "IC1:" + trim(wdetail.drivericno1)  + " " +       /* 44 หมายเลขบัตร 1        */   
                                            "DC1:" + trim(wdetail.driverCard1)  + " " +       /* 45 DRIVER CARD 1        */   
                                            "EP1:" + trim(wdetail.driverexp1)   + " " +       /* 46 DRIVER CARD EXPIRE 1 */    
                                            "N2:"  + trim(wdetail.drivername2)  + " " +       /* 47 ผู้ขับขี่คนที่ 2     */    
                                            "B2:"  + trim(wdetail.driverbrith2) + " " +       /* 48 วันเดือนปีเกิด 2     */    
                                            "IC2:" + trim(wdetail.drivericno2)  + " " +       /* 49 หมายเลขบัตร 1        */    
                                            "DC2:" + trim(wdetail.driverCard2)  + " " +       /* 50 DRIVER CARD 2        */ 
                                            "EP2:" + trim(wdetail.driverexp2)   + " " +       /* 51 DRIVER CARD EXPIRE 2 */     
                                            "AG:"  + TRIM(Wdetail.AgencyEmployee) + " " +     /* 23  ชื่อผู้แจ้งงาน      */                     
                                            "CTP:" + TRIM(wdetail.InsCTP)                    /* 37  INSURER CTP         */ 
                    tlt.stat               = TRIM(wdetail.garage)                            /* 52  ซ่อมห้าง            */  
                    tlt.usrsent            = "IN:"  + trim(wdetail.InspectName)  + " " +      /* 53  ชื่อผู้ตรวจรถ       */  
                                             "IP:"  + trim(wdetail.InspectPhoneNo)            /* 54  เบอร์โทรศัพท์ผู้ตรวจรถ */    
                    tlt.safe1              = TRIM(wdetail.access) /* 53  คุ้มครองอุปกรณ์เพิ่มเติม  */  
                    tlt.filler2            = trim(wdetail.Plus12) /* 55  FLAG FOR 12PLUS           */  
                    tlt.OLD_eng            = "complete"           
                    tlt.endno              = USERID(LDBNAME(1))   /*User Load Data */
                    tlt.imp                = "IM"                 /*Import Data    */
                    tlt.releas             = "NO"                 
                    tlt.rec_addr4          = fi_agent-2           /*Agent code*/   
                    tlt.usrid              = ""                   /*User Edit Data*/ /*add By Sarinya C A61-0349 23/07/2018*/

                    company    = wdetail.Company.
                        IF company = "AYCAL" THEN ASSIGN tlt.comp_usr_ins = "บมจ.อยุธยา แคปปิตอล ออโต้ ลีส" .
                        ELSE IF company = "BAY" THEN ASSIGN tlt.comp_usr_ins = "ธนาคารกรุงศรีอยุธยา จำกัด (มหาชน)" .
                        ELSE tlt.comp_usr_ins = "ยกเลิก 8.3" .
               nv_complete = nv_complete + 1.
            END.        
        END.
        ELSE DO:
            nv_update = NO.
            IF tlt.releas <> "Yes" THEN DO:
                MESSAGE "พบข้อมูลเลขอ้างอิง" + " " + tlt.recac + " " + "ในระบบ ต้องงการ Update ข้อมูลไหม" 
                    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "" UPDATE Choice.
                IF Choice THEN nv_update = YES. 
                IF nv_update = YES THEN do:
                    RUN import_update2.
                    nv_complete = nv_complete + 1.
                END.
                ELSE DO:
                    nv_ncomplete = nv_ncomplete + 1.
                    ASSIGN
                        putchr1 = "พบข้อมูลดังกล่าวในระบบแล้ว"
                        putchr  = textchr  + "  " + TRIM(putchr1).
                    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                    nv_message = putchr1.
                END.
            END.
            ELSE
                ASSIGN 
                    nv_ncomplete = nv_ncomplete + 1
                    putchr1 = "พบข้อมูลดังกล่าวในระบบมีสถานะเป็น YES แล้ว ไม่สามารถ Update ข้อมูลได้"  
                    putchr  = textchr  + "  " + TRIM(putchr1).
                PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                    nv_message = putchr1.                     
        END.
    END.                                                      
END.                                                          
RUN Open_tlt.               
IF nv_ncomplete = 0 THEN DO:
    nv_errfile = "".
END.                                                          
MESSAGE 
    "==========================" SKIP
    "Load  Data Total  : " nv_countdata SKIP
    "==========================" SKIP 
    "            Complete : " nv_complete  SKIP
    "     Not Complete : " nv_ncomplete SKIP 
    "==========================" SKIP(1)
    "File Not Load : " nv_errfile      SKIP
VIEW-AS ALERT-BOX INFORMATION.                                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notificationkpi c-wins 
PROCEDURE Import_notificationkpi :
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
        wdetail.Codecompany   /*  INSURANCE   */
        wdetail.renew         /*  YEAR        */
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
FOR EACH wdetail.
    RUN proc_cutpolicy.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_update c-wins 
PROCEDURE import_update :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF tlt.releas <> "Yes" THEN DO:
    IF brstat.tlt.cha_no = wdetail.chassis THEN DO: 
ASSIGN
                    tlt.entdat         = TODAY
                    tlt.enttim         = STRING(TIME,"HH:MM:SS")
                    tlt.trntime        = STRING(TIME,"HH:MM:SS")
                    tlt.trndat         = TODAY
                    tlt.genusr         = "aycal"                       /* 2  Company   */
                    tlt.flag           = TRIM(wdetail.Porduct)         /* 3  Porduct   */ 
                    tlt.comp_usr_tlt   = TRIM(wdetail.Branch)          /* 4  Branch    */ 
                    tlt.recac          = TRIM(wdetail.Contract)        /* 5  Contract  */ 
                    tlt.ins_name       = TRIM(wdetail.nTITLE) + " " +  /* 6  คำนำหน้าชื่อ    */ 
                                         TRIM(wdetail.name1)  + " " +  /* 7  ชื่อผู้เอาประกัน    */                  
                                         TRIM(wdetail.name2)           /* 8  นามสกุลผู้เอาประกัน */
                    tlt.ins_addr1      = TRIM(np_addr1)                /* 9  บ้านเลขที่  */                          
                    tlt.ins_addr2      = TRIM(np_addr2)                /*10  ตำบล/แขวง*/                     
                    tlt.ins_addr3      = TRIM(np_addr3)                /*11  อำเภอ/เขต*/                     
                    tlt.ins_addr4      = TRIM(np_addr4)                /*12  จังหวัด*/                               
                    tlt.ins_addr5      = TRIM(np_addr5)
                    
                    tlt.brand          = TRIM(wdetail.brand)           /*13  ยี่ห้อรถ*/                             
                    tlt.model          = TRIM(wdetail.model)           /*14  รุ่นรถ  */                                 
                                                                       /*15  สี  wdetail.coler*/
                    tlt.lince1         = TRIM(wdetail.vehreg) + " " +  /*16  เลขทะเบียน  */        
                                         TRIM(wdetail.provin)          /*17  จังหวัดที่จดทะเบียน */
                    tlt.lince2         = TRIM(wdetail.caryear)         /*18  ปีรถ*/             
                    tlt.cc_weight      = DECI(wdetail.cc)              /*19  CC.*/                 
                    tlt.cha_no         = TRIM(wdetail.chassis)         /*20  เลขตัวถัง*/                      
                    tlt.eng_no         = TRIM(wdetail.engno)           /*21  เลขเครื่อง*/
                    tlt.comp_noti_tlt  = TRIM(wdetail.notifyno)        /*22 Code ผู้แจ้ง*/
                    tlt.safe3          = TRIM(wdetail.covcod)          /*23  ประเภท*/            
                    tlt.nor_usr_ins    = TRIM(wdetail.Codecompany)     /*24  Code บ.ประกัน*/      
                    tlt.nor_noti_ins   = TRIM(wdetail.prepol)          /*25  เลขกรมธรรม์เดิม*/             
                    tlt.nor_effdat     = DATE(SUBSTR(TRIM(wdetail.comdat70),5,2) + "/" +
                                         SUBSTR(TRIM(wdetail.comdat70),3,2) + "/" +
                                         STRING(DECI("25" + SUBSTR(TRIM(wdetail.comdat70),1,2)) - 543))   /*26  วันคุ้มครองประกัน*/         
                    tlt.expodat        = DATE(SUBSTR(TRIM(wdetail.expdat70),5,2) + "/" +
                                         SUBSTR(TRIM(wdetail.expdat70),3,2) + "/" +
                                         STRING(DECI("25" + SUBSTR(TRIM(wdetail.expdat70),1,2)) - 543))   /*27  วันหมดประกัน*/ 
                    tlt.comp_coamt     = IF DECI(wdetail.si) = 0 THEN 0 ELSE DECI(wdetail.si) / 100       /*28  ทุนประกัน*/                 
                    tlt.dri_name2      = STRING(DECI(wdetail.premt) / 100 )                               /*29  ค่าเบี้ยสุทธิ์*/ 
                    tlt.nor_grprm      = DECI(wdetail.premtnet) / 100                                     /*30  ค่าเบี้ยรวมภาษีอากร */ 
                    tlt.rencnt         = DECI(wdetail.renew)           /*31  ปีประกัน*/                                    
                                                                       /*32  เลขรับแจ้ง   tlt.nor_noti_tlt   = trim(wdetail.policy) */                                    
                    /*tlt.nor_noti_tlt   =  n_notifyno*/
                    tlt.safe2          = TRIM(wdetail.idno)
                    tlt.datesent       = IF TRIM(wdetail.notifydate) = "" THEN ? 
                                         ELSE DATE(SUBSTR(TRIM(wdetail.notifydate),5,2) + "/" +     /*33  วันที่แจ้ง*/                                                                     
                                         SUBSTR(TRIM(wdetail.notifydate),3,2) + "/" +
                                         STRING(DECI("25" + SUBSTR(TRIM(wdetail.notifydate),1,2)) - 543))
                    tlt.seqno          = DECI(wdetail.Deduct)          /*34  Deduct*/                                                                                 
                    tlt.nor_usr_tlt    = TRIM(wdetail.Codecompa72)     /*35  Code บ.ประกัน พรบ.*/                                        
                    tlt.comp_effdat    = IF wdetail.comdat72 = "" THEN ? 
                                         ELSE DATE(SUBSTR(TRIM(wdetail.comdat72),5,2) + "/" +   /*36  วันคุ้มครองพรบ.*/ 
                                         SUBSTR(TRIM(wdetail.comdat72),3,2) + "/" +
                                         STRING(DECI("25" + SUBSTR(TRIM(wdetail.comdat72),1,2)) - 543))
                    tlt.dat_ins_noti   = IF wdetail.expdat72 = "" THEN ? 
                                         ELSE DATE(SUBSTR(TRIM(wdetail.expdat72),5,2) + "/" +      /*37  วันหมดพรบ.*/ 
                                         SUBSTR(TRIM(wdetail.expdat72),3,2) + "/" +
                                         STRING(DECI("25" + SUBSTR(TRIM(wdetail.expdat72),1,2)) - 543))
                    tlt.dri_no1        = TRIM(wdetail.comp)             /*38  ค่าพรบ. */                                                              
                    tlt.dri_name1      = IF TRIM(wdetail.driverno) = "" THEN "2" ELSE "1"        /*39  ระบุผู้ขับขี่*/
                    tlt.stat           = TRIM(wdetail.garage)           /*40  ซ่อมห้าง*/                                                        
                    tlt.safe1          = TRIM(wdetail.access)           /*41  คุ้มครองอุปกรณ์เพิ่มเติม*/                                   
                    tlt.filler1        = TRIM(wdetail.endoresadd)       /*42  แก้ไขที่อยู่ */                                                
                    tlt.filler2        = TRIM(wdetail.remak)            /*43  หมายเหตุ*/          
                    tlt.OLD_eng        =  "complete"    
                    tlt.endno          = USERID(LDBNAME(1))   /*User Load Data */
                    tlt.imp            = "IM"                 /*Import Data    */
                    tlt.releas         = "No"   
                    /*Add Jiraphon A59-0451*/
                    tlt.rec_addr4       = fi_agent-2
                    company    = wdetail.Company.
                        IF company = "AYCAL" THEN ASSIGN tlt.comp_usr_ins = "อยุธยา แคปปิตอล ออโต้ลิส จำกัด (มหาชน)" .
                        ELSE IF company = "BAY" THEN ASSIGN tlt.comp_usr_ins = "ธนาคารกรุงศรีอยุธยา จำกัด (มหาชน)" .
                        ELSE tlt.comp_usr_ins = "ยกเลิก8.3" .
                    /*End Jiraphon A59-0451*/
                             
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_update2 c-wins 
PROCEDURE import_update2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF tlt.releas <> "Yes" THEN DO:
    IF brstat.tlt.cha_no = wdetail.chassis THEN DO: 
ASSIGN
                    tlt.entdat            = TODAY                                                  
                    tlt.enttim            = STRING(TIME,"HH:MM:SS")                            
                    tlt.trntime           = STRING(TIME,"HH:MM:SS")                            
                    tlt.trndat            = TODAY                   
                    tlt.genusr            = "aycal"                       /* 1   COMPANY CODE              */                   
                    tlt.flag              = trim(wdetail.Porduct)         /* 2   PRODUCT CODE              */  
                    tlt.comp_usr_tlt      = trim(wdetail.Branch)          /* 3   BRANCH CODE               */  
                    tlt.recac             = trim(wdetail.Contract)        /* 4   CONTRACT NO.              */  
                    tlt.ins_name          = trim(wdetail.nTITLE) + " " +  /* 5   CUSTOMER THAI TITLE       */  
                                            trim(wdetail.name1)  + " " +  /* 6   FIRST NAME - THAI         */  
                                            trim(wdetail.name2)           /* 7   LAST NAME  - THAI         */  
                    tlt.safe2             = trim(wdetail.idno)            /* 8   CARD NO.                  */  
                    tlt.ins_addr1         = TRIM(np_addr1)                /* 9   REGISTER ADDRESS LINE 1   */  
                    tlt.ins_addr2         = TRIM(np_addr2)                /* 10  REGISTER ADDRESS LINE 2   */  
                    tlt.ins_addr3         = TRIM(np_addr3)                /* 11  REGISTER ADDRESS LINE 3   */  
                    tlt.ins_addr4         = TRIM(np_addr4)                /* 12  REGISTER ADDRESS LINE 4   */  
                    tlt.ins_addr5         = TRIM(np_addr5)                /* 12  REGISTER ZIP.CODE         */ 
                    tlt.brand             = TRIM(wdetail.brand)           /* 13  ยี่ห้อ                    */  
                    tlt.model             = TRIM(wdetail.model)           /* 14  รุ่น                      */  
                    /*tlt.colorcod          = wdetail.coler*/             /* 15  สีรถ                      */  
                    tlt.lince1            = TRIM(wdetail.vehreg) + " " +  /* 16  ทะเบียนรถ                 */  
                                            TRIM(wdetail.provin)          /* 17  จังหวัด                   */  
                    tlt.lince2            = TRIM(wdetail.caryear)         /* 18  ปีรถ                      */  
                    tlt.cc_weight         = DECI(wdetail.cc)              /* 19  CC                        */  
                    tlt.cha_no            = TRIM(wdetail.chassis)         /* 20  เลขตัวถัง                 */  
                    tlt.eng_no            = TRIM(wdetail.engno)           /* 21  เลขเครื่อง                */  
                    tlt.comp_noti_tlt     = TRIM(wdetail.notifyno)        /* 22  CODE ผู้แจ้ง              */  
                    tlt.safe3             = TRIM(wdetail.covcod)          /* 24  INSURANCE TYPE            */  
                    tlt.nor_usr_ins       = TRIM(wdetail.Codecompany)     /* 25  INSURANCE CODE            */  
                    tlt.nor_noti_ins      = TRIM(wdetail.prepol)          /* 26  เลขกรมธรรม์เก่า           */     
                    tlt.nor_effdat        = DATE(SUBSTR(TRIM(wdetail.comdat70),5,2) + "/" +
                                            SUBSTR(TRIM(wdetail.comdat70),3,2) + "/" +
                                            STRING(DECI("25" + SUBSTR(TRIM(wdetail.comdat70),1,2)) - 543))  /* 27  วันคุ้มครองกธ.  */  
                    tlt.expodat           = DATE(SUBSTR(TRIM(wdetail.expdat70),5,2) + "/" +                                        
                                            SUBSTR(TRIM(wdetail.expdat70),3,2) + "/" +                                             
                                            STRING(DECI("25" + SUBSTR(TRIM(wdetail.expdat70),1,2)) - 543))  /* 28  วันหมดอายุกธ.   */  
                    tlt.comp_coamt        = IF DECI(wdetail.si) = 0 THEN 0 ELSE DECI(wdetail.si)            /* 29  ทุนประกัน       */  
                    tlt.sentcnt           = DECI(wdetail.siIns)         /* 30  เบี้ยประกันรับจากลูกค้า   */                            
                    tlt.dri_name2         = STRING(DECI(wdetail.premt)) /* 31  เบี้ยสุทธิ           */  
                    tlt.nor_grprm         = DECI(wdetail.premtnet)      /* 32  เบี้ยรวมภาษี              */  
                    tlt.rencnt            = DECI(wdetail.renew)         /* 33  ปีประกัน                  */  
                                                                        /*32  เลขรับแจ้ง   tlt.nor_noti_tlt   = trim(wdetail.policy) */ 
                    /*tlt.nor_noti_tlt      = n_notifyno*/
                    tlt.datesent          = IF TRIM(wdetail.notifydate) = "" THEN ? 
                                            ELSE DATE(SUBSTR(TRIM(wdetail.notifydate),5,2) + "/" +         /*33  วันที่แจ้ง*/                                                                     
                                            SUBSTR(TRIM(wdetail.notifydate),3,2) + "/" +
                                            STRING(DECI("25" + SUBSTR(TRIM(wdetail.notifydate),1,2)) - 543))  
                    tlt.seqno             = DECI(wdetail.Deduct)          /* 36  DEDUCT AMOUNT             */  
                    tlt.comp_effdat       = IF wdetail.comdat72 = "" THEN ? 
                                            ELSE IF wdetail.comdat72 = "0" THEN ?
                                            ELSE DATE(SUBSTR(TRIM(wdetail.comdat72),5,2) + "/" +         /*36  วันคุ้มครองพรบ.*/ 
                                            SUBSTR(TRIM(wdetail.comdat72),3,2) + "/" +
                                            STRING(DECI("25" + SUBSTR(TRIM(wdetail.comdat72),1,2)) - 543))
                    tlt.dat_ins_noti      = IF wdetail.expdat72 = "" THEN ? 
                                            ELSE IF wdetail.expdat72 = "0" THEN ? 
                                            ELSE DATE(SUBSTR(TRIM(wdetail.expdat72),5,2) + "/" +        /*37  วันหมดพรบ.*/ 
                                            SUBSTR(TRIM(wdetail.expdat72),3,2) + "/" +
                                            STRING(DECI("25" + SUBSTR(TRIM(wdetail.expdat72),1,2)) - 543))
                    tlt.dri_no1           = TRIM(wdetail.comp)            /* 40  ค่าเบี้ย พรบ.             */  
                    tlt.dri_name1         = IF TRIM(wdetail.driverno) = "" THEN "1" ELSE "2"  /* 41 ระบุผู้ขับขี่ทั้งหมด */  
                    tlt.dri_no2           = "N1:"  + trim(wdetail.drivername1)  + " " +       /* 42 ผู้ขับขี่คนที่ 1     */    
                                            "B1:"  + trim(wdetail.driverbrith1) + " " +       /* 43 วันเดือนปีเกิด 1     */    
                                            "IC1:" + trim(wdetail.drivericno1)  + " " +       /* 44 หมายเลขบัตร 1        */   
                                            "DC1:" + trim(wdetail.driverCard1)  + " " +       /* 45 DRIVER CARD 1        */   
                                            "EP1:" + trim(wdetail.driverexp1)   + " " +       /* 46 DRIVER CARD EXPIRE 1 */    
                                            "N2:"  + trim(wdetail.drivername2)  + " " +       /* 47 ผู้ขับขี่คนที่ 2     */    
                                            "B2:"  + trim(wdetail.driverbrith2) + " " +       /* 48 วันเดือนปีเกิด 2     */    
                                            "IC2:" + trim(wdetail.drivericno2)  + " " +       /* 49 หมายเลขบัตร 1        */    
                                            "DC2:" + trim(wdetail.driverCard2)  + " " +       /* 50 DRIVER CARD 2        */ 
                                            "EP2:" + trim(wdetail.driverexp2)   + " " +       /* 51 DRIVER CARD EXPIRE 2 */       
                                            "AG:"  + TRIM(Wdetail.AgencyEmployee) + " " +      /* 23 ชื่อผู้แจ้งงาน       */ 
                                            "CTP:"  + TRIM(wdetail.InsCTP)                     /* 37 INSURER CTP          */               

                    tlt.stat               = TRIM(wdetail.garage)                          /* 52  ซ่อมห้าง              */  
                    tlt.usrsent            = "IN:"  + trim(wdetail.InspectName)  + " " +    /* 53  ชื่อผู้ตรวจรถ          */  
                                             "IP:"  + trim(wdetail.InspectPhoneNo)          /* 54  เบอร์โทรศัพท์ผู้ตรวจรถ */  
                    tlt.safe1              = TRIM(wdetail.access)         /* 53  คุ้มครองอุปกรณ์เพิ่มเติม  */  
                    tlt.comp_usr_ins       = trim(wdetail.Benefic)        /* 54  ผู้รับผลประโยชน์          */  
                    tlt.filler2            = trim(wdetail.Plus12)         /* 55  FLAG FOR 12PLUS           */  
                    tlt.OLD_eng            = "complete"                   
                    tlt.endno              = USERID(LDBNAME(1))           /*User Load Data */
                    tlt.imp                = "IM"                         /*Import Data    */
                    tlt.releas             = "NO"                         
                    tlt.rec_addr4          = fi_agent-2                   /*Agent code*/   
                    tlt.usrid              = USERID(LDBNAME(1))   /*User Edit Data*/ /*add By Sarinya C A61-0349 23/07/2018*/

                      .       
    END.
END.
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
Open Query br_tlt  For each tlt  NO-LOCK
     WHERE tlt.trndat     =  TODAY       and
           tlt.genusr     =  "aycal"  
    BY tlt.nor_noti_tlt  .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_text c-wins 
PROCEDURE pd_text :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail NO-LOCK.
MESSAGE 
    wdetail.Company                  SKIP
    wdetail.Porduct                  skip
    wdetail.Branch                   skip
    wdetail.Contract                 skip
    wdetail.nTITLE                   skip
    wdetail.name1                    skip
    wdetail.name2                    skip
    wdetail.idno                     skip
    wdetail.addr1                    skip
    wdetail.addr2                    skip
    wdetail.addr3                    skip
    wdetail.addr4                    skip
    wdetail.brand                    skip
    wdetail.model                    skip
    wdetail.coler                    skip
    wdetail.vehreg                   skip
    wdetail.provin                   skip
    wdetail.caryear                  skip
    wdetail.cc                       skip
    wdetail.chassis                  skip
    wdetail.engno                    skip
    wdetail.notifyno                 skip
    Wdetail.AgencyEmployee           skip
    wdetail.covcod                   skip
    wdetail.Codecompany              skip
    wdetail.prepol                   skip
    wdetail.comdat70                 skip
    wdetail.expdat70                 skip
    wdetail.si                       skip
    wdetail.siIns                    skip
    wdetail.premt                    skip
    wdetail.premtnet                 skip
    wdetail.renew                    skip
    wdetail.policy                   skip
    wdetail.notifydate               skip
    wdetail.Deduct                   skip
    wdetail.InsCTP                   skip
    wdetail.comdat72                 skip
    wdetail.expdat72                 skip
    wdetail.comp                     skip
    wdetail.driverno                 skip
    wdetail.drivername1              skip
    wdetail.driverbrith1             skip
    wdetail.drivericno1              skip
    wdetail.driverexp1               skip
    wdetail.drivername2              skip
    wdetail.driverbrith2             skip
    wdetail.drivericno2              skip
    wdetail.driverexp2               skip
    wdetail.garage                   skip
    wdetail.InspectName              skip
    wdetail.InspectPhoneNo           skip
    wdetail.access                   skip
    wdetail.Benefic                  skip
    wdetail.Plus12                   SKIP VIEW-AS ALERT-BOX.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdatesent c-wins 
PROCEDURE proc_chkdatesent :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF TRIM(wdetail.notifydate) = "" THEN n_datesent = ?.
ELSE DO:
    n_datesent = DATE(SUBSTR(TRIM(wdetail.notifydate),5,2) + "/" +
                      SUBSTR(TRIM(wdetail.notifydate),3,2) + "/" +
                      STRING(DECI("25" + SUBSTR(TRIM(wdetail.notifydate),1,2)) - 543)).
END.

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
    
    IF (R-INDEX(np_addrall,"กทม")  <> 0 ) THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"กทม") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"กทม") - 1 )).
    END.
    ELSE IF (R-INDEX(np_addrall,"กรุง")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"กรุง") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"กรุง") - 1 )).
    END.
    ELSE IF (R-INDEX(np_addrall,"จ.")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"จ.") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"จ.") - 1 )).
    END.
    ELSE IF (R-INDEX(np_addrall,"จังหวัด")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"จังหวัด") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"จังหวัด") - 1 )).
    END.
    IF (R-INDEX(np_addrall,"เขต")  <> 0 )  THEN DO:
        ASSIGN nv_amp  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"เขต") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"เขต") - 1 )).
    END.
    IF (R-INDEX(np_addrall,"อำเภอ")  <> 0 )  THEN DO:
        ASSIGN nv_amp  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"อำเภอ") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"อำเภอ") - 1 )).
    END.
    /*Add Jiraphon A59-0451*/
    IF (R-INDEX(np_addrall,"อ.")  <> 0 )  THEN DO:
        ASSIGN nv_amp  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"อ.") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"อ.") - 1 )).
    END.
    /*End Jiraphon A59-0451*/
    IF (R-INDEX(np_addrall,"แขวง")  <> 0 )  THEN DO:
        ASSIGN nv_tum  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"แขวง") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"แขวง") - 1 )).
    END.
    IF (R-INDEX(np_addrall,"ตำบล")  <> 0 )  THEN DO:
        ASSIGN nv_tum  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"ตำบล") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"ตำบล") - 1 )).
    END.
   /*Add Jiraphon A59-0451*/    
    IF (R-INDEX(np_addrall,"ต.")  <> 0 )  THEN DO:
        ASSIGN nv_tum  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"ต.") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"ต.") - 1 )).
    END.
    
/*
    IF R-INDEX(np_addrall,"จ.") = 0 THEN DO:
    np_addr4 = SUBSTR(np_addrall,INDEX(np_addrall,np_addr3)).
    np_addr4 = SUBSTR(np_addr4,R-INDEX(np_addr4," ")).
    END.
*/
    

    
    np_addr2 = SUBSTR(nv_tum,1,INDEX(nv_tum, " ")).
    np_addr3 = SUBSTR(nv_amp,1,INDEX(nv_amp, " ")).
    
    
    nv_prov = trim(SUBSTR(np_addrall,INDEX(np_addrall,np_addr3) + LENGTH(np_addr3),20)).
    np_addr4 = trim(SUBSTR(nv_prov,1,INDEX(nv_prov," "))).
    np_addr5 = trim(SUBSTR(nv_prov,R-INDEX(nv_prov, " "))).

    /*End Jiraphon A59-0451*/
   
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
ASSIGN 
    nv_c = trim(wdetail.policy)
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
    wdetail.policy  = nv_c . 

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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 c-wins 
PROCEDURE proc_report1 :
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
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_filename).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "บริษัทเงินทุน ธนาคารเกียรตินาคิน จำกัด (มหาชน) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "ลำดับที่"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่รับแจ้ง"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "วันที่รับเงินค่าเบิ้ยประกัน"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "รายชื่อบริษัทประกันภัย"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "เลขที่สัญญาเช่าซื้อ"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "เลขที่กรมธรรม์เดิม"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "รหัสสาขา"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "สาขา KK"                            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "เลขรับเเจ้ง"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Campaign"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Sub Campaign"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "บุคคล/นิติบุคคล"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "คำนำหน้าชื่อ"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ชื่อผู้เอาประกัน"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "นามสกุลผู้เอาประกัน"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "บ้านเลขที่"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "ตำบล/แขวง"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "อำเภอ/เขต"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "จังหวัด"                            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "รหัสไปรษณีย์"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "ประเภทความคุ้มครอง"                 '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "ประเภทการซ่อม"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "วันเริ่มคุ้มครอง"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "วันสิ้นสุดคุ้มครอง"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "รหัสรถ"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "ประเภทประกันภัยรถยนต์"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "ชื่อยี่ห้อรถ"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "รุ่นรถ"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "New/Used"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "เลขทะเบียน"                         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "เลขตัวถัง"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "เลขเครื่องยนต์"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "ปีรถยนต์"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "ซีซี"                               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "น้ำหนัก/ตัน"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "ทุนประกันปี 1 "                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "เบี้ยรวมภาษีเเละอากรปี 1"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "ทุนประกันปี 2"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "เบี้ยรวมภาษีเเละอากรปี 2"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "เวลารับเเจ้ง"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "ชื่อเจ้าหน้าที่ MKT"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "หมายเหตุ"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "ผู้ขับขี่ที่ 1 เเละวันเกิด"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "ผู้ขับขี่ที่ 2 เเละวันเกิด"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "ชื่อ (ใบเสร็จ/ใบกำกับภาษี)"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "นามสกุล (ใบเสร็จ/ใบกำกับภาษี)"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "จังหวัด (ใบเสร็จ/ใบกำกับภาษี)"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี)" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "ส่วนลดประวัติดี"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "ส่วนลดงาน Fleet"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "Remak1"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "Remak2"                             '"' SKIP.

FOR EACH tlt Use-index  tlt01  Where
        tlt.trndat        >=   fi_trndatfr   And
        tlt.trndat        <=   fi_trndatto   And
        /*tlt.comp_noti_tlt >=   fi_polfr      And
        tlt.comp_noti_tlt <=   fi_polto      And*/
        tlt.genusr   =  "phone"                no-lock.  
    /*IF      (ra_report = 1) AND (tlt.lotno <> fi_comname ) THEN NEXT.
    ELSE IF (ra_report = 2) AND (index(tlt.OLD_eng,"not")  <> 0 ) THEN NEXT.
    ELSE IF (ra_report = 3) AND (index(tlt.OLD_eng,"not") = 0 )   THEN NEXT.*/
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' n_record                                            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' string(tlt.trndat,"99/99/9999")      FORMAT "x(10)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' string(tlt.dat_ins_not,"99/99/9999") FORMAT "x(10)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' trim(tlt.nor_usr_ins)                FORMAT "x(50)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' trim(tlt.nor_noti_tlt)               FORMAT "x(20)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' trim(tlt.nor_noti_ins)               FORMAT "x(20)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' trim(tlt.nor_usr_tlt)                FORMAT "x(10)" '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' trim(tlt.comp_usr_tl)                FORMAT "x(35)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' trim(tlt.comp_noti_tlt)              FORMAT "x(20)" '"' SKIP.                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' trim(tlt.dri_no1)                    FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' trim(tlt.dri_no2)                    FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' trim(tlt.safe2)                      FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 )         FORMAT "x(20)" '"' SKIP.                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1,r-INDEX(trim(tlt.ins_name)," ") - INDEX(trim(tlt.ins_name)," "))  FORMAT "x(35)" '"' SKIP.                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' substr(trim(tlt.ins_name),r-INDEX(trim(tlt.ins_name)," ") + 1 )         FORMAT "x(35)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' trim(tlt.ins_addr1)                 FORMAT "x(80)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' trim(tlt.ins_addr2)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' trim(tlt.ins_addr3)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' trim(tlt.ins_addr4)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' trim(tlt.ins_addr5)                 FORMAT "x(15)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' trim(tlt.safe3)                                    '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' trim(tlt.stat)                      FORMAT "x(30)" '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' string(tlt.expodat,"99/99/9999")    FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' trim(tlt.subins)                    FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' trim(tlt.filler2)                   FORMAT "x(40)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' trim(tlt.brand)                     FORMAT "x(30)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' trim(tlt.model)                     FORMAT "x(45)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' trim(tlt.filler1)                   FORMAT "x(20)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' trim(tlt.lince1)                    FORMAT "x(30)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' trim(tlt.cha_no)                    FORMAT "x(30)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' trim(tlt.eng_no)                    FORMAT "x(30)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' trim(tlt.lince2)                    FORMAT "x(10)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' string(tlt.cc_weight)               FORMAT "x(10)" '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' trim(tlt.colorcod)                  FORMAT "x(10)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' string(tlt.comp_coamt)              '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' string(tlt.comp_grprm)              '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' string(tlt.nor_coamt)               '"' SKIP.                                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' string(tlt.nor_grprm)               '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' string(tlt.gentim)                  FORMAT "x(10)"     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' trim(tlt.comp_usr_in)               FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' trim(tlt.safe1)                     FORMAT "x(100)"     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' trim(tlt.dri_name1)                 FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' trim(tlt.dri_name2)                 FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' trim(tlt.rec_name)             '"' SKIP.                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' ""                             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' ""                             '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' trim(tlt.rec_addr1)            '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' trim(tlt.rec_addr2)            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' trim(tlt.rec_addr3)            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' trim(tlt.rec_addr4)            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' trim(tlt.rec_addr5)            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' string(tlt.seqno)              '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' tlt.lotno                      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' trim(tlt.OLD_eng)       FORMAT "x(100)"  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' trim(tlt.OLD_cha)       FORMAT "x(100)"  '"' SKIP.
END.   /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".

OUTPUT STREAM ns2 CLOSE.  

Message "Export data Complete"  View-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat c-wins 
PROCEDURE proc_reportmat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN 
    fi_outfile  =  Trim(fi_outfile) + "_mat.csv"  .

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
    "Yes/No" 
    "เบี้ยรวม"
    "ชำระล่าสุด" 
    "Producer Code"
    "Agent Code"
    "ISP".

         IF ra_matkpn = 1 THEN RUN proc_reportmat1.
    ELSE IF ra_matkpn = 2 THEN RUN proc_reportmat2.
    ELSE IF ra_matkpn = 3 THEN RUN proc_reportmat3.
    ELSE IF ra_matkpn = 4 THEN RUN proc_reportmat4.
    ELSE IF ra_matkpn = 5 THEN RUN proc_reportmat5.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat1 c-wins 
PROCEDURE proc_reportmat1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.

FOR EACH wdetail  NO-LOCK .

    IF wdetail.policy <> "" THEN ASSIGN nv_countdata     = nv_countdata  + 1 .

    FIND LAST tlt   WHERE
        tlt.nor_noti_tlt   = TRIM(wdetail.policy)   AND 
        tlt.genusr         =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN 
            nv_countcomplete = nv_countcomplete + 1 
            n_record =  n_record + 1 
            np_title = IF INDEX(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,INDEX(tlt.ins_name," ") - 1 )  ELSE "คุณ"
            np_name  = IF INDEX(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,INDEX(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
            np_name2 = IF INDEX(np_name," ") <> 0 THEN SUBSTR(np_name,INDEX(np_name," ") + 1 )   ELSE tlt.ins_name
            np_name  = IF INDEX(np_name," ") <> 0 THEN SUBSTR(np_name,1,INDEX(np_name," ") - 1 )  ELSE tlt.ins_name.
            IF np_title = "น.ส." OR np_title = "น.ส" OR np_title = "นส." THEN np_title = "นางสาว".  /*Add By Sarinya A61-0349*/
            nv_isp   = IF INDEX(tlt.OLD_cha,"ISP:") <> 0 THEN Substr(tlt.OLD_cha,index(tlt.OLD_cha,"ISP:"),index(tlt.OLD_cha,"Detail:")   - 1 ) ELSE "". /*Add By Sarinya A61-0349*/
        
        EXPORT DELIMITER "|" 
            n_record                                                        /*  1  ลำดับที่     */             
            STRING(tlt.datesent,"99/99/9999") FORMAT "x(10)"                /*  2  วันที่แจ้ง   */            
            tlt.nor_noti_tlt                                                /*  3  เลขรับแจ้ง   */           
            CAPS(TRIM(tlt.comp_usr_tlt))                                    /*  4  Branch       */           
            TRIM(tlt.recac)                                                 /*  5  Contract     */           
            TRIM(np_title)                                                  /*  6  คำนำหน้าชื่อ */           
            TRIM(np_name)                                                   /*  7  ชื่อ         */           
            TRIM(np_name2)                                                  /*  8  นามสกุล      */           
            TRIM(tlt.ins_addr1)               FORMAT "x(50)"                /*  9  ที่อยู่ 1    */           
            TRIM(tlt.ins_addr2)               FORMAT "x(40)"                /*  10 ที่อยู่ 2    */           
            TRIM(tlt.ins_addr3)               FORMAT "x(40)"                /*  11 ที่อยู่ 3    */           
            TRIM(tlt.ins_addr4) + " " + TRIM(tlt.ins_addr5) FORMAT "x(40)"  /*  12 ที่อยู่ 4    */           
            tlt.brand                                                       /*  13 ยี่ห้อรถ     */           
            tlt.model                                                       /*  14 รุ่นรถ       */           
            tlt.lince1                                                      /*  15 เลขทะเบียน   */           
            tlt.lince2                                                      /*  16 ปีรถ         */           
            tlt.cc_weight                                                   /*  17 CC.          */           
            tlt.cha_no                                                      /*  18 เลขตัวถัง    */           
            tlt.eng_no                                                      /*  19 เลขเครื่อง   */           
            tlt.comp_noti_tlt                                               /*  20 Code ผู้แจ้ง */           
            tlt.safe3                                                       /*  21 ประเภท       */           
            tlt.nor_usr_ins                                                 /*  22 Code บ.ประกัน        */  
            tlt.nor_noti_ins                                                /*  23 เลขกรมธรรม์เดิม      */ 
            tlt.safe2
            IF tlt.nor_effdat = ? THEN "" ELSE STRING(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 วันคุ้มครองประกัน    */
            IF tlt.expodat    = ? THEN "" ELSE STRING(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 วันหมดประกัน         */   
            tlt.comp_coamt                                                  /*  26 ทุนประกัน    */           
            DECI(tlt.dri_name2)                                             /*  27 ค่าเบี้ยสุทธิ์ */         
            tlt.nor_grprm                                                   /*  28 ค่าเบี้ยรวมภาษีอากร */    
            tlt.seqno                                                       /*  29 Deduct       */           
            tlt.nor_usr_tlt                                                 /*  30 Code บ.ประกัน พรบ.   */   
            IF tlt.comp_effdat  = ? THEN "" ELSE STRING(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 วันคุ้มครองพรบ.*/   
            IF tlt.dat_ins_noti = ? THEN "" ELSE STRING(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 วันหมดพรบ.   */           
            DECI(tlt.dri_no1)                                               /*  33 ค่าพรบ.      */           
            tlt.dri_name1                                                   /*  34 ระบุผู้ขับขี่        */   
            tlt.stat                                                        /*  35 ซ่อมห้าง     */           
            tlt.safe1                                                       /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
            tlt.filler1                                                     /*  37 แก้ไขที่อยู่    */        
            tlt.comp_usr_ins                                                /*  38 ผู้รับผลประโยชน์ */       
            tlt.OLD_cha                                                     /*  39 หมายเหตุ */               
            tlt.OLD_eng                                                     /*  40 complete/not complete */  
            tlt.releas                                                      /*  41 Yes/No . */ 
            wdetail.premtnet                                                /*  เบี้ยรวม    */
            wdetail.recivedat                                               /*  ชำระล่าสุด  */
            fi_Producer                                                     /*  Producer Code */
            /*fi_agent.                                                       /*  Agent Code */--Comment Jiraphon A59-0451*/
            tlt.rec_addr4                                                   /* Agent Code */ /*Add Jiraphon A59-0451*/
            nv_isp             /*Add By Sarinya C A61-0349*/ 
            .

            
    END.


END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat2 c-wins 
PROCEDURE proc_reportmat2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK:

    IF wdetail.Contract <> "" THEN ASSIGN nv_countdata     = nv_countdata  + 1 .

    FIND LAST tlt   Where
        tlt.recac    = trim(wdetail.Contract)  AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN nv_countcomplete = nv_countcomplete + 1
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        IF np_title = "น.ส." OR np_title = "น.ส" OR np_title = "นส." THEN np_title = "นางสาว".  /*Add By Sarinya A61-0349*/        nv_isp   = IF INDEX(tlt.OLD_cha,"ISP:") <> 0 THEN Substr(tlt.OLD_cha,index(tlt.OLD_cha,"ISP:"),index(tlt.OLD_cha,"Detail:")   - 1 ) ELSE "". /*Add By Sarinya A61-0349*/
        
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
            tlt.safe2
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
            tlt.dri_name1       /*  34 ระบุผู้ขับขี่        */   
            tlt.stat            /*  35 ซ่อมห้าง     */           
            tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
            tlt.filler1         /*  37 แก้ไขที่อยู่    */        
            tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
            tlt.OLD_cha         /*  39 หมายเหตุ */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas          /*  41 Yes/No . */ 
            wdetail.premtnet      /*  เบี้ยรวม    */
            wdetail.recivedat     /*  ชำระล่าสุด  */
            fi_Producer           /*  Producer Code */
            /*fi_agent.             /*  Agent Code */--Comment Jiraphon A59-0451*/
            tlt.rec_addr4           /* Agent Code */ /*Add Jiraphon A59-0451*/
            nv_isp             /*Add By Sarinya C A61-0349*/ 
            .
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat3 c-wins 
PROCEDURE proc_reportmat3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .

    IF TRIM(wdetail.vehreg) + " " +  TRIM(wdetail.provin) <> "" THEN ASSIGN nv_countdata = nv_countdata  + 1 .

    FIND LAST tlt   Where
        tlt.lince1   = trim(wdetail.vehreg) + " " +  trim(wdetail.provin) AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN nv_countcomplete = nv_countcomplete + 1
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name. 
        IF np_title = "น.ส." OR np_title = "น.ส" OR np_title = "นส." THEN np_title = "นางสาว".  /*Add By Sarinya A61-0349*/
        nv_isp   = IF INDEX(tlt.OLD_cha,"ISP:") <> 0 THEN Substr(tlt.OLD_cha,index(tlt.OLD_cha,"ISP:"),index(tlt.OLD_cha,"Detail:")   - 1 ) ELSE "". /*Add By Sarinya A61-0349*/
        
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
            tlt.safe2
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
            tlt.dri_name1       /*  34 ระบุผู้ขับขี่        */   
            tlt.stat            /*  35 ซ่อมห้าง     */           
            tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
            tlt.filler1         /*  37 แก้ไขที่อยู่    */        
            tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
            tlt.OLD_cha         /*  39 หมายเหตุ */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas         /*  41 Yes/No . */ 
            wdetail.premtnet      /*  เบี้ยรวม    */
            wdetail.recivedat     /*  ชำระล่าสุด  */
            fi_Producer           /*  Producer Code */
            /*fi_agent.             /*  Agent Code */ --Comment Jiraphon A59-0451*/
            tlt.rec_addr4           /* Agent Code */ /*Add Jiraphon A59-0451*/
            nv_isp             /*Add By Sarinya C A61-0349*/ 
            .
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat4 c-wins 
PROCEDURE proc_reportmat4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .

    FIND LAST tlt   Where
        tlt.cha_no   = trim(wdetail.chassis)  AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN nv_countcomplete = nv_countcomplete + 1
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        IF np_title = "น.ส." OR np_title = "น.ส" OR np_title = "นส." THEN np_title = "นางสาว".  /*Add By Sarinya A61-0349*/
        nv_isp   = IF INDEX(tlt.OLD_cha,"ISP:") <> 0 THEN Substr(tlt.OLD_cha,index(tlt.OLD_cha,"ISP:"),index(tlt.OLD_cha,"Detail:")   - 1 ) ELSE "". /*Add By Sarinya A61-0349*/
        
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
            tlt.safe2
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
            tlt.dri_name1       /*  34 ระบุผู้ขับขี่        */   
            tlt.stat            /*  35 ซ่อมห้าง     */           
            tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
            tlt.filler1         /*  37 แก้ไขที่อยู่    */        
            tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
            tlt.OLD_cha         /*  39 หมายเหตุ */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas          /*  41 Yes/No . */ 
            wdetail.premtnet      /*  เบี้ยรวม    */
            wdetail.recivedat    /*  ชำระล่าสุด  */
            fi_Producer           /*  Producer Code */
            /*fi_agent.             /*  Agent Code */--Comment Jiraphon A59-0451*/
            tlt.rec_addr4          /* Agent Code */ /*Add Jiraphon A59-0451*/
            nv_isp             /*Add By Sarinya C A61-0349*/ 
            .

    END.
    
    IF wdetail.chassis <> "" THEN ASSIGN nv_countdata     = nv_countdata  + 1.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat5 c-wins 
PROCEDURE proc_reportmat5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .

    IF wdetail.chassis <> "" THEN ASSIGN nv_countdata     = nv_countdata  + 1.

    FIND LAST tlt   Where
       (tlt.recac        = trim(wdetail.Contract)  OR
        tlt.nor_noti_tlt = trim(wdetail.policy)    OR
        tlt.lince1       = trim(wdetail.vehreg) + " " +  trim(wdetail.provin) OR
        tlt.cha_no       = trim(wdetail.chassis)  ) AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN nv_countcomplete = nv_countcomplete + 1
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        IF np_title = "น.ส." OR np_title = "น.ส" OR np_title = "นส." THEN np_title = "นางสาว".  /*Add By Sarinya A61-0349*/
        nv_isp   = IF INDEX(tlt.OLD_cha,"ISP:") <> 0 THEN Substr(tlt.OLD_cha,index(tlt.OLD_cha,"ISP:"),index(tlt.OLD_cha,"Detail:")   - 1 ) ELSE "". /*Add By Sarinya A61-0349*/
        
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
            tlt.safe2
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
            tlt.dri_name1       /*  34 ระบุผู้ขับขี่        */   
            tlt.stat            /*  35 ซ่อมห้าง     */           
            tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
            tlt.filler1         /*  37 แก้ไขที่อยู่    */        
            tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
            tlt.OLD_cha         /*  39 หมายเหตุ */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas          /*  41 Yes/No . */ 
            wdetail.premtnet      /*  เบี้ยรวม    */
            wdetail.recivedat    /*  ชำระล่าสุด  */
            fi_Producer          /*  Producer Code */
            /*fi_agent.            /*  Agent Code */--Comment A59-0451*/
            tlt.rec_addr4          /* Agent Code */ /*Add Jiraphon A59-0451*/
            nv_isp             /*Add By Sarinya C A61-0349*/ 
            .
    END.
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
    tlt.trndat         >=  fi_trndatfr   And
    tlt.trndat         <=  fi_trndatto   And
    tlt.genusr   =  "phone"         .
        
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

    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt). 
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

