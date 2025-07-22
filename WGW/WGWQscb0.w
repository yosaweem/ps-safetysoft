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
/*          This .W file wAS created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which ASsures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
CREATE WIDGET-POOL.
/* ***************************  DefINITions  ************************** */

/* Parameters DefINITions ---                                           */

/* Local Variable DefINITions ---                                       */

/*++++++++++++++++++++++++++++++++++++++++++++++
  wgwqscb0.w :   Query & Update Add in table  tlt 
  Create  by :   Ranu I. A60-0448 Date 16/10/2017
  Connect    :  sicuw,sicsyac,sic_bran ,brstat  
 +++++++++++++++++++++++++++++++++++++++++++++++*/
/*Modify by Kridtiya i. A65-00174 ปรับ รายงาน ให้เป็น ไฟล์โหลด   */
/*Modify by Kridtiya i.  A65-0267 ปรับ รายงาน ให้เป็น ไฟล์โหลด   */
/*Modify by Tontawan S. A66-0006 25/01/2023
            - เพิ่ม Field ชื่อเซล, รหัสเซล, ช่องทางการขาย, รหัสสาขา, 
              แคมเปญ, Per Person(BI), Per Accident, Per Accident(PD),
              411 PA  FOR DRIVER/PASSENGERS, 42 PA MEDICAL, 43 BAIL BOND
            - เพิ่มเงื่อนไขการ Auto Branch to Report             
            - กรณีเป็นงานต่ออายุ   ให้โปรแกรม auto  เป็น  Branch เดิม 
            - กรณีที่เป็น พรบ. ให้ออกงานเป็นสาขาเดียวกับกรมธรรม์หลัก
            - แก้ไข Error Field น้ำหนักที่ขึ้น Error Format
            - กรณีข้อมูลไม่ตรงกับใบเตือนให้มี Massage ขึ้น Error 
              โดยให้เช็คเงื่อนไข  >> วันคุ้มครอง, ทุน, เบี้ย, 
              เงื่อนไขการซ่อมอู่-ห้าง, ทั้ง Line 70 และ 72       
            - เพิ่มเงื่อนไขการหาข้อมูลเลข Prepol ใหม่ของงาน พรบ ให้ข้อมูลออกมาถูกต้อง  */
/* Modify By : Tontawan S. A68-0059 27/03/2025
             : Add 35 Field for support EV                              */
/*****************************************************************/
DEF    VAR nv_rectlt        AS recid  INIT  0.
DEF    VAR nv_recidtlt      AS recid  INIT  0.
DEFINE VAR n_ASdat          AS CHAR.
DEFINE VAR vAcProc_fil      AS CHAR.
DEFINE VAR n_ASdat1         AS CHAR. /*A55-0365 */
DEFINE VAR vAcProc_fil1     AS CHAR. /*A55-0365 */
DEF    VAR nv_72Reciept     AS CHAR INIT "" .
DEFINE STREAM ns2.

DEF VAR nv_row          AS INT INIT 0.  /*A60-0118*/
DEF VAR n_CHAR          AS CHAR FORMAT "x(500)" INIT "" .
DEF VAR n_bdate         AS CHAR FORMAT "x(15)" INIT "" .
DEF VAR nv_campnam      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_camp         AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_comnam       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_comcod       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_pacg         AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_pacgnam      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_producnam    AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_produc       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_sureng       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_nameeng      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_titleeng     AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_surth        AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_nameth       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_titleth      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_polocc       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_polbdate     AS CHAR FORMAT "x(15)" INIT "" .
DEF VAR nv_sex          AS CHAR FORMAT "x(2)" INIT "" .
DEF VAR nv_icno         AS CHAR FORMAT "x(13)" INIT "" .
DEF VAR nv_line         AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_mail         AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_poltel       AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_driver       AS CHAR FORMAT ">9"    INIT "0" .
DEF VAR nv_driid1       AS CHAR FORMAT "x(13)" INIT "" .
DEF VAR nv_drisur1      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_drinam1      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_dridate1     AS CHAR FORMAT "x(15)" INIT "" .
DEF VAR nv_drisex1      AS CHAR FORMAT "x(15)" INIT "" .
DEF VAR nv_driocc1      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_driid2       AS CHAR FORMAT "x(13)" INIT "" .
DEF VAR nv_drisur2      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_drinam2      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_dridate2     AS CHAR FORMAT "x(15)" INIT "" .
DEF VAR nv_drisex2      AS CHAR FORMAT "x(15)" INIT "" .
DEF VAR nv_driocc2      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_paytyp       AS CHAR FORMAT "x(2)" INIT "" .
DEF VAR nv_branch       AS CHAR FORMAT "x(25)" INIT "" .
DEF VAR nv_paysur       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_paynam       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_waytyp       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_payway       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_paymtyp      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_paymcod      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_bank         AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_paidsts      AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_paysts       AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_paydat       AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_garcod       AS CHAR FORMAT "x(2)" INIT "" .
DEF VAR nv_garage       AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR nv_covdetail    AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_subcover     AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_cover        AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_covcod       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_covtyp       AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_stamp        AS CHAR FORMAT ">>>,>>>.>9" INIT "0.00" .
DEF VAR nv_vat          AS CHAR FORMAT ">>>,>>>.>9" INIT "0.00" .
DEF VAR nv_feeltp       AS CHAR FORMAT ">>>.>9"     INIT "0.00" .
DEF VAR nv_feelt        AS CHAR FORMAT ">>>,>>>,>9" INIT "0.00" .
DEF VAR nv_ncbp         AS CHAR FORMAT ">>>.>9"     INIT "0.00" .
DEF VAR nv_ncb          AS CHAR FORMAT ">>>,>>>,>9" INIT "0.00" .
DEF VAR nv_drip         AS CHAR FORMAT ">>>.>9"     INIT "0.00" .
DEF VAR nv_dridis       AS CHAR FORMAT ">>>,>>>,>9" INIT "0.00" .
DEF VAR nv_oth          AS CHAR FORMAT ">>>.>9"     INIT "0.00" .
DEF VAR nv_othdis       AS CHAR FORMAT ">>>,>>>,>9" INIT "0.00" .
DEF VAR nv_cctvp        AS CHAR FORMAT ">>>.>9"     INIT "0.00" .
DEF VAR nv_cctv         AS CHAR FORMAT ">>>,>>>,>9" INIT "0.00" .
DEF VAR nv_discdetail   AS CHAR FORMAT ">>>.>9"     INIT "0.00" .
DEF VAR nv_discp        AS CHAR FORMAT ">>>,>>>,>9" INIT "0.00" .
DEF VAR nv_disc         AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_province     AS CHAR FORMAT "x(35)" INIT "" .
DEF VAR nv_accpric5     AS CHAR FORMAT ">,>>>,>>>,>9" INIT "0.00" .
DEF VAR nv_accdet5      AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_accr5        AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_accpric4     AS CHAR FORMAT ">,>>>,>>>,>9" INIT "0.00" .  
DEF VAR nv_accdet4      AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_accr4        AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_accpric3     AS CHAR FORMAT ">,>>>,>>>,>9" INIT "0.00" .  
DEF VAR nv_accdet3      AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_accr3        AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_accpric2     AS CHAR FORMAT ">,>>>,>>>,>9" INIT "0.00" .  
DEF VAR nv_accdet2      AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_accr2        AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_accpric1     AS CHAR FORMAT ">,>>>,>>>,>9" INIT "0.00" .  
DEF VAR nv_accdet1      AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_accr1        AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_inspres      AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_inspdet      AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_brocod       AS CHAR FORMAT "x(12)" INIT "" .
DEF VAR nv_bronam       AS CHAR FORMAT "x(70)" INIT "" .
DEF VAR nv_brolincen    AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR nv_remark       AS CHAR FORMAT "x(500)" INIT "" .
DEF VAR nv_gift         AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_remarksend   AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_polsend      AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_lang         AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR nv_inspno       AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR nv_insresult    AS CHAR FORMAT "x(250)" INIT "".
DEF VAR nv_prepol       AS CHAR FORMAT "x(20)" INIT "" . /*A65-00174*/
DEF VAR nv_cha_no       AS CHAR FORMAT "x(50)" INIT "" . /*A65-00174*/
DEF VAR nv_yrpol        AS INTE.
DEF VAR nv_yr           AS INTE.

/*-- Tontawan S. A66-0006 --*/
DEF SHARED VAR   n_User    AS CHAR .                   
DEF SHARED VAR   n_PASsWd  AS CHAR .  

DEFINE VAR nv_br        AS CHAR FORMAT "X(10)" INIT "" .  
DEFINE VAR nv_appen     AS CHAR FORMAT "X(20)" INIT "" .  
DEFINE VAR nv_exp       AS DATE .                         
DEFINE VAR nn_prepol    AS CHAR FORMAT "X(20)" INIT "" .
DEFINE VAR gv_id        AS CHAR FORMAT "X(8)"     NO-UNDO. 
DEFINE VAR nv_pwd       AS CHAR FORMAT "x(15)"   NO-UNDO.
DEFINE VAR n_err        AS CHAR FORMAT "X(100)".
DEFINE VAR n_si         AS DECI INIT 0.
DEFINE VAR n_garage     AS CHAR INIT "".
DEFINE VAR n_gapprm     AS DECI INIT 0.
DEFINE VAR n_comdat     AS DATE INIT ?.
DEFINE VAR n_expdat     AS DATE INIT ?.
DEFINE VAR number_sic   AS INTE INIT 0.
DEFINE VAR n_person     AS CHAR FORMAT "X(20)".
DEFINE VAR n_peracc     AS CHAR FORMAT "X(20)".
DEFINE VAR n_pd         AS CHAR FORMAT "X(20)".
DEFINE VAR n_si411      AS CHAR FORMAT "X(20)".
DEFINE VAR n_si412      AS CHAR FORMAT "X(20)".
DEFINE VAR n_si43       AS CHAR FORMAT "X(20)".
DEFINE VAR nv_docno     AS CHAR FORMAT "x(25)".
DEFINE VAR n_engno      AS CHAR FORMAT "X(20)".
DEFINE VAR nv_year      AS CHAR FORMAT "x(5)" . //ใช้ที่ Procedures Inspection 
DEFINE VAR nv_yearf     AS CHAR INIT "".
DEFINE VAR nv_yeart     AS CHAR INIT "".
DEFINE VAR nv_iyrp1     AS INT  INIT 0.
DEFINE VAR nv_iyrp2     AS INT  INIT 0.
DEFINE VAR n_exp        AS DATE.
/*-- Tontawan S. A66-0006 --*/

/*-- Tontawan S. A68-0059 --*/
DEFINE VAR n_drv3_salutation_M  AS CHAR FORMAT "X(20)".     // คนขับ 3 : คำนำหน้า          
DEFINE VAR n_drv3_fname         AS CHAR FORMAT "X(100)".    // คนขับ 3 : ชื่อ              
DEFINE VAR n_drv3_lname         AS CHAR FORMAT "X(100)".    // คนขับ 3 : นามสกุล           
DEFINE VAR n_drv3_nid           AS CHAR FORMAT "X(20)".     // คนขับ 3 : เลขบัตรประชาชน    
DEFINE VAR n_drv3_occupation    AS CHAR FORMAT "X(50)".     // คนขับ 3 : อาชีพ             
DEFINE VAR n_drv3_gender        AS CHAR FORMAT "X(10)".     // คนขับ 3 : เพศ               
DEFINE VAR n_drv3_birthdate     AS CHAR FORMAT "X(10)".     // คนขับ 3 : วันเกิด           
DEFINE VAR n_drv4_salutation_M  AS CHAR FORMAT "X(20)".     // คนขับ 4 : คำนำหน้า          
DEFINE VAR n_drv4_fname         AS CHAR FORMAT "X(100)".    // คนขับ 4 : ชื่อ              
DEFINE VAR n_drv4_lname         AS CHAR FORMAT "X(100)".    // คนขับ 4 : นามสกุล           
DEFINE VAR n_drv4_nid           AS CHAR FORMAT "X(20)".     // คนขับ 4 : เลขบัตรประชาชน    
DEFINE VAR n_drv4_occupation    AS CHAR FORMAT "X(50)".     // คนขับ 4 : อาชีพ             
DEFINE VAR n_drv4_gender        AS CHAR FORMAT "X(10)".     // คนขับ 4 : เพศ               
DEFINE VAR n_drv4_birthdate     AS CHAR FORMAT "X(10)".     // คนขับ 4 : วันเกิด           
DEFINE VAR n_drv5_salutation_M  AS CHAR FORMAT "X(20)".     // คนขับ 5 : คำนำหน้า          
DEFINE VAR n_drv5_fname         AS CHAR FORMAT "X(100)".    // คนขับ 5 : ชื่อ              
DEFINE VAR n_drv5_lname         AS CHAR FORMAT "X(100)".    // คนขับ 5 : นามสกุล           
DEFINE VAR n_drv5_nid           AS CHAR FORMAT "X(20)".     // คนขับ 5 : เลขบัตรประชาชน    
DEFINE VAR n_drv5_occupation    AS CHAR FORMAT "X(50)".     // คนขับ 5 : อาชีพ             
DEFINE VAR n_drv5_gender        AS CHAR FORMAT "X(10)".     // คนขับ 5 : เพศ               
DEFINE VAR n_drv5_birthdate     AS CHAR FORMAT "X(10)".     // คนขับ 5 : วันเกิด           
DEFINE VAR n_drv1_dlicense      AS CHAR FORMAT "X(50)".     // คนขับ 1 : ทะเบียนรถ         
DEFINE VAR n_drv2_dlicense      AS CHAR FORMAT "X(50)".     // คนขับ 2 : ทะเบียนรถ         
DEFINE VAR n_drv3_dlicense      AS CHAR FORMAT "X(50)".     // คนขับ 3 : ทะเบียนรถ         
DEFINE VAR n_drv4_dlicense      AS CHAR FORMAT "X(50)".     // คนขับ 4 : ทะเบียนรถ         
DEFINE VAR n_drv5_dlicense      AS CHAR FORMAT "X(50)".     // คนขับ 5 : ทะเบียนรถ         
DEFINE VAR n_baty_snumber       AS CHAR FORMAT "X(20)".     // Battery : Serial Number     
DEFINE VAR n_batydate           AS CHAR FORMAT "X(10)".     // Battery : Year              
DEFINE VAR n_baty_rsi           AS CHAR FORMAT "X(20)".     // Battery : Replacement SI    
DEFINE VAR n_baty_npremium      AS CHAR FORMAT "X(20)".     // Battery : Net Premium       
DEFINE VAR n_baty_gpremium      AS CHAR FORMAT "X(20)".     // Battery : Gross_Premium     
DEFINE VAR n_wcharge_snumber    AS CHAR FORMAT "X(20)".     // Wall Charge : Serial_Number 
DEFINE VAR n_wcharge_si         AS CHAR FORMAT "X(20)".     // Wall Charge : SI            
DEFINE VAR n_wcharge_npremium   AS CHAR FORMAT "X(20)".     // Wall Charge : Net Premium   
DEFINE VAR n_wcharge_gpremium   AS CHAR FORMAT "X(20)".     // Wall Charge : Gross Premium 
DEFINE VAR n_newtrariff         AS LOGICAL INIT NO.         // Status New Trariff
/*-- Tontawan S. A68-0059 --*/

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
IF (tlt.flag = "INSPEC") THEN (tlt.stat) ELSE (tlt.policy) tlt.nor_noti_ins ~
IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN (substr(tlt.ins_name,index(tlt.ins_name,":") + 1,index(tlt.ins_name,"NameEng") - 9)) ELSE (tlt.ins_name) ~
tlt.lince1 tlt.cha_no tlt.gendat tlt.expodat tlt.nor_coamt tlt.nor_grprm ~
tlt.comp_grprm tlt.comp_coamt ~
IF (tlt.flag = "V70" or tlt.flag = "V72") THEN (substr(tlt.nor_noti_tlt,index(tlt.nor_noti_tlt,":") + 1 , index(tlt.nor_noti_tlt,"InspDe:") - 9  )) ELSE  IF (tlt.flag = "Paid") THEN (tlt.filler2) ELSE (tlt.nor_noti_tlt) ~
tlt.datesent 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_type ra_status fi_trndatfr fi_trndatto ~
bu_ok cb_search bu_oksch br_tlt fi_search bu_update cb_report fi_outfile ~
bu_report bu_exit bu_upyesno fi_datare RECT-332 RECT-338 RECT-339 RECT-341 ~
RECT-386 
&Scoped-Define DISPLAYED-OBJECTS rs_type ra_status fi_trndatfr fi_trndatto ~
cb_search fi_search fi_name cb_report fi_outfile fi_datare 

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
     SIZE 7 BY 1
     BGCOLOR 22 FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 5 BY .95
     BGCOLOR 2 FONT 6.

DEFINE BUTTON bu_report 
     LABEL "OK" 
     SIZE 7 BY .95
     BGCOLOR 5 FONT 6.

DEFINE BUTTON bu_update 
     LABEL "CANCEL" 
     SIZE 14 BY 1.05
     BGCOLOR 6 FONT 6.

DEFINE BUTTON bu_upyesno 
     LABEL "YES/NO" 
     SIZE 14 BY 1.05
     BGCOLOR 2 FONT 6.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 35.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "ชื่อผู้เอาประกัน" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_datare AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 79.33 BY .95
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
     SIZE 28.5 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ข้อมูลการแจ้งงาน", 1,
"ข้อมูลการตรวจสภาพ", 2
     SIZE 63 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.67 BY 23.81
     BGCOLOR 30 FGCOLOR 1 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 59.33 BY 2.52
     BGCOLOR 21 .

DEFINE RECTANGLE RECT-339
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 71 BY 2.52
     BGCOLOR 10 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.33 BY 1.76
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.33 BY 2.62
     BGCOLOR 3 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "Status" FORMAT "x(20)":U WIDTH 5.5
      IF (tlt.flag = "INSPEC") THEN (tlt.stat) ELSE (tlt.policy) COLUMN-LABEL "Send/Poicy" FORMAT "X(12)":U
            WIDTH 14.33
      tlt.nor_noti_ins COLUMN-LABEL "เลขรับแจ้ง" FORMAT "x(20)":U
            WIDTH 18.33
      IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN (substr(tlt.ins_name,index(tlt.ins_name,":") + 1,index(tlt.ins_name,"NameEng") - 9)) ELSE (tlt.ins_name) COLUMN-LABEL "ชื่อ - สกุล" FORMAT "X(50)":U
            WIDTH 21.33
      tlt.lince1 COLUMN-LABEL "ทะเบียน" FORMAT "x(12)":U
      tlt.cha_no FORMAT "x(20)":U WIDTH 20.17
      tlt.gendat COLUMN-LABEL "วันคุ้มครอง" FORMAT "99/99/9999":U
      tlt.expodat COLUMN-LABEL "วันสิ้นสุด" FORMAT "99/99/9999":U
            WIDTH 9.5
      tlt.nor_coamt COLUMN-LABEL "ทุนประกัน" FORMAT "->,>>>,>>>,>>9.99":U
      tlt.nor_grprm COLUMN-LABEL "เบี้ยก่อนหักส่วนลด" FORMAT ">>,>>>,>>9.99":U
            WIDTH 11.5
      tlt.comp_grprm COLUMN-LABEL "เบี้ยสุทธิ" FORMAT ">>>,>>9.99":U
            WIDTH 9.33
      tlt.comp_coamt COLUMN-LABEL "เบี้ยรวม" FORMAT "->>,>>>,>>9.99":U
      IF (tlt.flag = "V70" or tlt.flag = "V72") THEN (substr(tlt.nor_noti_tlt,index(tlt.nor_noti_tlt,":") + 1 , index(tlt.nor_noti_tlt,"InspDe:") - 9  )) ELSE  IF (tlt.flag = "Paid") THEN (tlt.filler2) ELSE (tlt.nor_noti_tlt) COLUMN-LABEL "หมายเหตุ" FORMAT "X(100)":U
            WIDTH 39.67
      tlt.datesent COLUMN-LABEL "วันที่ส่งข้อมูลกลับ" FORMAT "99/99/9999":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130.5 BY 14.33
         BGCOLOR 15  ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_type AT ROW 2.33 COL 38.33 NO-LABEL
     ra_status AT ROW 7.67 COL 102.5 NO-LABEL
     fi_trndatfr AT ROW 3.43 COL 36.33 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 3.43 COL 72.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 3.43 COL 105
     cb_search AT ROW 5.05 COL 17.5 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 6.19 COL 54.67
     br_tlt AT ROW 10.29 COL 2.33
     fi_search AT ROW 6.14 COL 4.33 NO-LABEL
     fi_name AT ROW 6.05 COL 60.67 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 5.95 COL 102.5
     cb_report AT ROW 7.67 COL 12.83 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 8.81 COL 14.67 NO-LABEL
     bu_report AT ROW 8.86 COL 95
     bu_exit AT ROW 3.1 COL 121.67
     bu_upyesno AT ROW 5.95 COL 117.67
     fi_datare AT ROW 7.71 COL 64.83 NO-LABEL
     "Click for update Flag Cancel":40 VIEW-AS TEXT
          SIZE 29.5 BY .95 AT ROW 5 COL 63
          BGCOLOR 10 FGCOLOR 6 FONT 6
     "Query Data SCB" VIEW-AS TEXT
          SIZE 19.5 BY .62 AT ROW 1.38 COL 61.33
          BGCOLOR 30 FGCOLOR 7 FONT 6
     "Report Data :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 7.71 COL 51.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Status :" VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 7.67 COL 94.67
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 3.43 COL 68.17
          BGCOLOR 19 FONT 6
     "Output :" VIEW-AS TEXT
          SIZE 8.33 BY .95 AT ROW 8.81 COL 6.17
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "           ประเภทข้อมูล :" VIEW-AS TEXT
          SIZE 21.67 BY 1 AT ROW 2.33 COL 15.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "วันที่นำเข้าข้อมูล  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 3.43 COL 15.83
          BGCOLOR 19 FONT 6
     "Date:27/03/2025" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 8.86 COL 114.17 WIDGET-ID 2
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " Search Data :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 5.05 COL 4.33
          BGCOLOR 21 FGCOLOR 2 FONT 6
     "Export File :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 7.67 COL 2.67
          BGCOLOR 3 FGCOLOR 7 FONT 6
     RECT-332 AT ROW 1 COL 1
     RECT-338 AT ROW 4.81 COL 2.17
     RECT-339 AT ROW 4.81 COL 61.5
     RECT-341 AT ROW 2.76 COL 120
     RECT-386 AT ROW 7.43 COL 2.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.83 BY 23.95
         BGCOLOR 18 FGCOLOR 0 .


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
         TITLE              = "Query && Update [SCBPT]"
         HEIGHT             = 23.95
         WIDTH              = 132.83
         MAX-HEIGHT         = 48.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 48.76
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
IF NOT c-wins:LOAD-ICON("WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/safety.ico"
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
/* SETTINGS FOR FILL-IN fi_datare IN FRAME fr_main
   ALIGN-L                                                              */
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
"tlt.releas" "Status" "x(20)" "character" ? ? ? ? ? ? no ? no no "5.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > "_<CALC>"
"IF (tlt.flag = ""INSPEC"") THEN (tlt.stat) ELSE (tlt.policy)" "Send/Poicy" "X(12)" ? ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "เลขรับแจ้ง" "x(20)" "character" ? ? ? ? ? ? no ? no no "18.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > "_<CALC>"
"IF (tlt.flag = ""V70""  OR  tlt.flag = ""V72"") THEN (substr(tlt.ins_name,index(tlt.ins_name,"":"") + 1,index(tlt.ins_name,""NameEng"") - 9)) ELSE (tlt.ins_name)" "ชื่อ - สกุล" "X(50)" ? ? ? ? ? ? ? no ? no no "21.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.lince1
"tlt.lince1" "ทะเบียน" "x(12)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.cha_no
"tlt.cha_no" ? ? "character" ? ? ? ? ? ? no ? no no "20.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.gendat
"tlt.gendat" "วันคุ้มครอง" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.expodat
"tlt.expodat" "วันสิ้นสุด" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "9.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "ทุนประกัน" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.nor_grprm
"tlt.nor_grprm" "เบี้ยก่อนหักส่วนลด" ">>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "11.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" "เบี้ยสุทธิ" ">>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.comp_coamt
"tlt.comp_coamt" "เบี้ยรวม" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > "_<CALC>"
"IF (tlt.flag = ""V70"" or tlt.flag = ""V72"") THEN (substr(tlt.nor_noti_tlt,index(tlt.nor_noti_tlt,"":"") + 1 , index(tlt.nor_noti_tlt,""InspDe:"") - 9  )) ELSE  IF (tlt.flag = ""Paid"") THEN (tlt.filler2) ELSE (tlt.nor_noti_tlt)" "หมายเหตุ" "X(100)" ? ? ? ? ? ? ? no ? no no "39.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > brstat.tlt.datesent
"tlt.datesent" "วันที่ส่งข้อมูลกลับ" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [SCBPT] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [SCBPT] */
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
    IF rs_type = 1 THEN DO:
        Get Current br_tlt.
              nv_recidtlt  =  Recid(tlt).
        
        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqscb11(Input  nv_recidtlt).
        
        {&WINDOW-NAME}:hidden  =  No. 
    END.
    ELSE IF rs_type = 2 THEN DO:
        Get Current br_tlt.
              nv_recidtlt  =  Recid(tlt).
        
        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqscb3(Input  nv_recidtlt).
        
        {&WINDOW-NAME}:hidden  =  No. 

    END.
   /* ELSE IF rs_type = 3 THEN DO:
        Get Current br_tlt.
              nv_recidtlt  =  Recid(tlt).
        
        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqscb2(Input  nv_recidtlt).
        
        {&WINDOW-NAME}:hidden  =  No. 
    END.*/

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
    IF rs_type = 1 THEN DO:
        OPEN QUERY br_tlt FOR EACH tlt USE-INDEX tlt01 WHERE
         tlt.trndat  >=   fi_trndatfr   AND
         tlt.trndat  <=   fi_trndatto   AND
         tlt.flag    >=   "V70"         AND
         tlt.flag    <=   "V72"         AND
         tlt.genusr   =  "SCBPT"        NO-LOCK.  

         nv_rectlt    =  RECID (tlt).
         APPLY "Entry" TO br_tlt.
         RETURN NO-APPLY . 
    END.
    ELSE IF rs_type = 2 THEN DO:
        OPEN QUERY br_tlt FOR EACH tlt USE-INDEX tlt01 WHERE
         tlt.trndat  >=   fi_trndatfr   AND
         tlt.trndat  <=   fi_trndatto   AND
         tlt.flag     =   "INSPEC"      AND
         tlt.genusr   =   "SCBPT"       NO-LOCK.  

         nv_rectlt =  RECID (tlt).
         APPLY "Entry" TO br_tlt.
         RETURN NO-APPLY . 
    END.
   /* ELSE IF rs_type = 3 THEN DO:
        Open Query br_tlt 
         For each tlt Use-index  tlt01  WHERE
         tlt.trndat  >=   fi_trndatfr   AND
         tlt.trndat  <=   fi_trndatto   AND
         tlt.flag     =   "Paid"      AND
         tlt.genusr   =   "SCBPT"        no-lock.  
             nv_rectlt =  recid(tlt).   
             Apply "Entry"  to br_tlt.
             Return no-apply. 
    END.*/
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
            tlt.genusr   =  "SCBPT"            And
            index(tlt.ins_name,fi_search) <> 0 no-lock.  
            IF rs_type = 1 THEN DO: 
              IF tlt.flag = "INSPEC" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.
            ELSE DO: 
              IF tlt.flag = "V70" OR tlt.flag = "V72" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.
    END.
    ELSE If  cb_search  =  "เบอร์กรมธรรม์"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "SCBPT"      And
            index(tlt.policy,fi_search) <> 0  no-lock.
            IF rs_type = 1 THEN DO: 
              IF tlt.flag = "INSPEC" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.
            ELSE DO: 
              IF tlt.flag = "V70" OR tlt.flag = "V72" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.
    END.
    ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "SCBPT"       And
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
            IF rs_type = 1 THEN DO: 
              IF tlt.flag = "INSPEC" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.
            ELSE DO: 
              IF tlt.flag = "V70" OR tlt.flag = "V72" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.           
    END.
    ELSE If  cb_search  =  "Status_yes"  Then do:   /* Confirm yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            tlt.genusr   =  "SCBPT"        And
            INDEX(tlt.releas,"yes") <> 0   no-lock.
            IF rs_type = 1 THEN DO: 
              IF tlt.flag = "INSPEC" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.
            ELSE DO: 
              IF tlt.flag = "V70" OR tlt.flag = "V72" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.        
    END.
    ELSE If  cb_search  =  "Status_no"  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat >=  fi_trndatfr      And
            tlt.trndat <=  fi_trndatto      And
            tlt.genusr   =  "SCBPT"         And
            INDEX(tlt.releas,"no") <> 0     no-lock.
            IF rs_type = 1 THEN DO: 
              IF tlt.flag = "INSPEC" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.
            ELSE DO: 
              IF tlt.flag = "V70" OR tlt.flag = "V72" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.         
    END.
    ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "SCBPT"        And
            index(tlt.releas,"cancel") > 0     no-lock.
            IF rs_type = 1 THEN DO: 
              IF tlt.flag = "INSPEC" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.
            ELSE DO: 
              IF tlt.flag = "V70" OR tlt.flag = "V72" THEN NEXT. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            END.                             
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
ON CHOOSE OF bu_report IN FRAME fr_main /* OK */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        APPLY "Entry"  TO fi_outfile.
        RETURN NO-APPLY. 
    END.
    ELSE DO:
        IF rs_type = 1 THEN RUN pd_reportnotify .
        ELSE RUN pd_reportinsp.
    END.

    IF n_err = "" THEN 
         MESSAGE "Export data Complete" VIEW-AS ALERT-BOX.
    ELSE MESSAGE "Error : " + n_err + ", Please check data record error!!!" VIEW-AS ALERT-BOX WARNING.

    IF CONNECTED("sic_exp") THEN DISCONNECT sic_exp. /*-- Add By Tontawan S. A66-0006 --*/
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


&Scoped-define SELF-NAME fi_datare
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datare c-wins
ON LEAVE OF fi_datare IN FRAME fr_main
DO:
  fi_datare = INPUT fi_datare.
  DISP fi_datare WITH FRAM fr_main.
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
            tlt.genusr   =  "SCBPT"             And
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
            tlt.genusr    =  "SCBPT"      And
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
            tlt.genusr    =  "SCBPT"      And
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
            tlt.genusr    =  "SCBPT"      And
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
            tlt.genusr    =  "SCBPT"                And 
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
            tlt.genusr   =  "SCBPT"                 And 
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
            tlt.genusr   =  "SCBPT"                 And 
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
            tlt.genusr   =  "SCBPT"                 And 
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
            tlt.genusr   =  "SCBPT"        And
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
            tlt.genusr   =  "SCBPT"        And
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


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type c-wins
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type .
    DISP rs_type  WITH FRAME fr_main.


    IF rs_type = 1 THEN DO:
        fi_outfile = "D:\Report_Notify" + 
                 STRING(YEAR(TODAY),"9999") + 
                 STRING(MONTH(TODAY),"99")  + 
                 STRING(DAY(TODAY),"99")    + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .

        ASSIGN vAcProc_fil1 = /*vAcProc_fil1 
                           + */ "All"  + ","
                           + "ประเภทกรมธรรม์" + ","  
                           + "รหัสแคมเปญ"    + ","       
                           + "ประเภทลูกค้า"  + ","
                           + "รหัสประเภทการชำระเบี้ย"  + ","
                           + "รหัสช่องทางการชำระเบี้ย"  + ","
                           + "วันที่ชำระเบี้ย"  + ","
                           + "สถานะการชำระเบี้ย"  + ","
                           + "วันที่ตรวจสภาพ" + ","
                           + "ผลการตรวจสภาพ"  + ","
            cb_report:LIST-ITEMS = vAcProc_fil1
            cb_report = ENTRY(1,vAcProc_fil1) .
    END.
    ELSE DO:
        fi_outfile = "D:\Report_Inspec" + 
                 STRING(YEAR(TODAY),"9999") + 
                 STRING(MONTH(TODAY),"99")  + 
                 STRING(DAY(TODAY),"99")    + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .

        ASSIGN 
        vAcProc_fil1 = "All"  + ","
                       + "วันที่นัดตรวจสภาพ" + ","
                       + "มีความเสียหาย"  + ","
                       + "ไม่มีความเสียหาย " + ","
                       + "ติดปัญหา" + ","
                       + "ส่งข้อมูลแล้ว" + ","
                       + "ยังไม่ส่งข้อมูล" + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1).

    END.
    DISP fi_outfile cb_report WITH FRAME fr_main.
  
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
  gv_prgid = "wgwqscb0".
  gv_prog  = "Query & Update  Detail  (SCBPT  co.,ltd.) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
      rs_type   =  1 
      ra_status =  4 
      vAcProc_fil = vAcProc_fil   + "ชื่อลูกค้า"   + ","
                                  + "เลขที่ใบคำขอ" + ","
                                  + "กรมธรรม์ใหม่" + "," 
                                  + "เลขตัวถัง"    + "," 
                                  + "status_Yes"   + "," 
                                  + "status_No"    + "," 
                                  + "Status_cancel"  + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil) .
       IF rs_type = 1  THEN DO:
            ASSIGN vAcProc_fil1 = vAcProc_fil1 
                           + "All"  + ","
                           + "ประเภทกรมธรรม์" + ","  
                           + "รหัสแคมเปญ"    + ","       
                           + "ประเภทลูกค้า"  + ","
                           + "รหัสประเภทการชำระเบี้ย"  + ","
                           + "รหัสช่องทางการชำระเบี้ย"  + ","
                           + "วันที่ชำระเบี้ย"  + ","
                           + "สถานะการชำระเบี้ย"  + ","
                           + "วันที่ตรวจสภาพ" + ","
                           + "ผลการตรวจสภาพ"  + ","
            cb_report:LIST-ITEMS = vAcProc_fil1
            cb_report = ENTRY(1,vAcProc_fil1) .
       END.
       ELSE DO:
           ASSIGN vAcProc_fil1 = vAcProc_fil1 
                              + "All"  + ","
                              + "วันที่นัดตรวจสภาพ" + ","
                              + "มีความเสียหาย"  + ","
                              + "ไม่มีความเสียหาย " + ","
                              + "ติดปัญหา" + ","
                              + "ส่งข้อมูลแล้ว" + ","
                              + "ยังไม่ส่งข้อมูล" + ","
            cb_report:LIST-ITEMS = vAcProc_fil1
            cb_report = ENTRY(1,vAcProc_fil1).

       END.
      fi_outfile = "D:\Report_Notify" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + "Load.csv" .
  
  Disp fi_trndatfr  fi_trndatto cb_search cb_report ra_status fi_outfile rs_type with frame fr_main.

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  Rect-338:MOVE-TO-TOP().  
  Rect-339:MOVE-TO-TOP(). 
  
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
  DISPLAY rs_type ra_status fi_trndatfr fi_trndatto cb_search fi_search fi_name 
          cb_report fi_outfile fi_datare 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE rs_type ra_status fi_trndatfr fi_trndatto bu_ok cb_search bu_oksch 
         br_tlt fi_search bu_update cb_report fi_outfile bu_report bu_exit 
         bu_upyesno fi_datare RECT-332 RECT-338 RECT-339 RECT-341 RECT-386 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_chkrenew c-wins 
PROCEDURE pd_chkrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add Tontawan S. A66-0006 10/05/2023      
------------------------------------------------------------------------------*/
DEF VAR n_cha_n AS CHAR FORMAT "X(30)".

ASSIGN
    nv_br     = ""
    nv_appen  = ""
    nn_prepol = ""
    nv_exp    = ?
    n_comdat  = ?
    n_si      = 0
    n_gapprm  = 0
    n_person  = ""
    n_peracc  = ""
    n_pd      = ""
    n_si411   = ""
    n_si412   = ""
    n_si43    = ""
    n_err     = "" 
    n_cha_n   = ""
    n_engno   = ""
    .

ASSIGN
   n_comdat  = brstat.tlt.gendat  
   n_si      = brstat.tlt.nor_coamt     // SI                       
   //n_gapprm  = brstat.tlt.comp_coamt. //เบี้ยรวม                  
   n_gapprm  = brstat.tlt.nor_grprm.    //เบี้ยสุทธิก่อนหักส่วนลด   

   /*IF brstat.tlt.nor_noti_ins = "T2305003170" AND TRIM(brstat.tlt.flag) = "V70" THEN DO: 
       ASSIGN
        nv_prepol = "D07065000008".
        n_si      = 50000.
   END.*/

IF nv_prepol <> "" THEN DO:
    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = nv_prepol NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
        ASSIGN 
            nn_prepol = sicuw.uwm100.policy.

        IF nn_prepol <> "" THEN DO:
            IF CONNECTED("sic_exp") THEN DO:
                RUN WGW\WGWEXSCB1 ( INPUT  nn_prepol, 
                                    INPUT  n_comdat, 
                                    INPUT  n_si,
                                    INPUT  nv_garcod,
                                    INPUT  n_gapprm,
                                    OUTPUT n_engno,
                                    OUTPUT n_person,
                                    OUTPUT n_peracc,
                                    OUTPUT n_pd,
                                    OUTPUT n_si411,
                                    OUTPUT n_si412,
                                    OUTPUT n_si43,
                                    OUTPUT n_err ).
            END.
        END.

        IF brstat.tlt.flag <> "V72" THEN DO:
            ASSIGN
                nv_br = sicuw.uwm100.branch.
        END.
        ELSE DO:
            ASSIGN
                nv_appen = sicuw.uwm100.cr_2.
            
            IF nv_appen <> "" THEN DO:
                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = nv_appen NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    nv_br = sicuw.uwm100.branch.

                    /*-- Ton 19/07/2023 --*/
                    IF n_engno = "" THEN DO:
                        FIND LAST sicuw.uwm301 USE-INDEX uwm30101           WHERE
                                  sicuw.uwm301.policy = sicuw.uwm100.policy AND
                                  sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                                  sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.   
                        IF AVAIL sicuw.uwm301 THEN DO:
                            ASSIGN
                                n_engno = sicuw.uwm301.eng_no. 
                        END.
                    END.
                    /*-- Ton 19/07/2023 --*/
                END.
            END.
            ELSE nv_br = sicuw.uwm100.branch.
        END.
    END.
END.
ELSE DO: 
    ASSIGN
        nv_br     = "ML"
        nv_appen  = ""
        nn_prepol = ""
        nv_exp    = ?.

    /*IF brstat.tlt.nor_noti_ins = "T2305016922" THEN n_cha_n = "wrhtejtrr".
    ELSE n_cha_n = TRIM(brstat.tlt.cha_no). --- TEST --*/

    FOR EACH sicuw.uwm301 USE-INDEX uwm30121 WHERE sicuw.uwm301.cha_no = TRIM(brstat.tlt.cha_no) /*- TRIM(n_cha_n) -- TEST -*/  NO-LOCK.
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            ASSIGN 
                nn_prepol = sicuw.uwm100.policy.

            IF nn_prepol <> "" THEN DO:                            
                IF CONNECTED("sic_exp") THEN DO:
                    RUN WGW\WGWEXSCB1 ( INPUT nn_prepol, 
                                        INPUT n_comdat, 
                                        INPUT n_si,
                                        INPUT nv_garcod,
                                        INPUT n_gapprm,
                                        OUTPUT n_engno,
                                        OUTPUT n_person,
                                        OUTPUT n_peracc,
                                        OUTPUT n_pd,
                                        OUTPUT n_si411,
                                        OUTPUT n_si412,
                                        OUTPUT n_si43,
                                        OUTPUT n_err ).
                END.
            END.
            ELSE DO:
                ASSIGN
                    n_person = ""
                    n_peracc = ""
                    n_pd     = ""
                    n_si411  = ""
                    n_si412  = ""
                    n_si43   = "".
            END.

            IF nv_exp = ? THEN DO:
                ASSIGN nv_exp = sicuw.uwm100.expdat.
            END.

            IF sicuw.uwm100.expdat >= nv_exp THEN DO:
                IF brstat.tlt.flag <> "V72" THEN DO:
                    ASSIGN
                        nv_br  = sicuw.uwm100.branch
                        nv_exp = sicuw.uwm100.expdat.
                END.
                ELSE DO:
                    ASSIGN
                        nv_exp   = sicuw.uwm100.expdat
                        nv_appen = sicuw.uwm100.cr_2.
        
                    IF nv_appen <> "" THEN DO:
                        ASSIGN
                            nv_br  = sicuw.uwm100.branch.
                    END.          
                END.
            END.
            ELSE DO:
                //nv_br  = nv_br. 
                nv_exp = nv_exp. 
            END.
        END. /*-- UWM100 --*/
    END.   /*---- UWM301 --*/

    /*IF nv_br = "" THEN nv_br = "ML".
  ELSE nv_br = nv_br. --- 18/07/2023 --*/

END. /*-- End Comment ---*/

/*-- 18/07/2023 --*/
     IF nv_br = ""   THEN nv_br = "ML".
ELSE IF nv_br = "MF" THEN nv_br = "ML". /*-- 18/07/2023 --*/
ELSE    nv_br = nv_br.
/*-- 18/07/2023 --*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_cleardata c-wins 
PROCEDURE pd_cleardata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN 
    n_char        = ""  
    n_bdate       = ""  
    nv_campnam    = ""  
    nv_camp       = ""  
    nv_comnam     = ""  
    nv_comcod     = ""  
    nv_pacg       = ""  
    nv_pacgnam    = ""  
    nv_producnam  = ""  
    nv_produc     = ""  
    nv_sureng     = ""  
    nv_nameeng    = ""  
    nv_titleeng   = ""  
    nv_surth      = ""  
    nv_nameth     = ""  
    nv_titleth    = ""  
    nv_polocc     = ""  
    nv_polbdate   = ""  
    nv_sex        = ""  
    nv_icno       = ""  
    nv_line       = ""  
    nv_mail       = ""  
    nv_poltel     = ""  
    nv_driver     = ""  
    nv_driid1     = ""  
    nv_drisur1    = ""  
    nv_drinam1    = ""  
    nv_dridate1   = ""  
    nv_drisex1    = ""  
    nv_driocc1    = ""  
    nv_driid2     = ""  
    nv_drisur2    = ""  
    nv_drinam2    = ""  
    nv_dridate2   = ""  
    nv_drisex2    = ""  
    nv_driocc2    = ""
    nv_province   = ""
    nv_paytyp     = ""  
    nv_branch     = ""  
    nv_paysur     = ""  
    nv_paynam     = ""  
    nv_waytyp     = ""  
    nv_payway     = ""  
    nv_paymtyp    = ""  
    nv_paymcod    = ""  
    nv_bank       = ""  
    nv_paidsts    = ""  
    nv_paysts     = ""  
    nv_paydat     = ""  
    nv_garcod     = ""  
    nv_garage     = ""  
    nv_covdetail  = ""  
    nv_subcover   = ""  
    nv_cover      = ""  
    nv_covcod     = ""  
    nv_covtyp     = ""  
    nv_stamp      = "0.00" 
    nv_vat        = "0.00" 
    nv_feeltp     = "0.00" 
    nv_feelt      = "0.00" 
    nv_ncbp       = "0.00" 
    nv_ncb        = "0.00" 
    nv_drip       = "0.00" 
    nv_dridis     = "0.00" 
    nv_oth        = "0.00" 
    nv_othdis     = "0.00" 
    nv_cctvp      = "0.00" 
    nv_cctv       = "0.00" 
    nv_discdetail = ""
    nv_discp      = "0.00"
    nv_disc       = "0.00"  
    nv_accpric5   = "0.00"  
    nv_accdet5    = ""  
    nv_accr5      = ""  
    nv_accpric4   = "0.00"  
    nv_accdet4    = ""  
    nv_accr4      = ""  
    nv_accpric3   = "0.00"  
    nv_accdet3    = ""  
    nv_accr3      = ""  
    nv_accpric2   = "0.00" 
    nv_accdet2    = ""  
    nv_accr2      = ""  
    nv_accpric1   = "0.00" 
    nv_accdet1    = ""  
    nv_accr1      = ""  
    nv_inspres    = ""  
    nv_inspdet    = ""  
    nv_brocod     = ""  
    nv_bronam     = ""  
    nv_brolincen  = ""  
    nv_remark     = ""  
    nv_gift       = ""  
    nv_remarksend = ""  
    nv_polsend    = ""  
    nv_lang       = "" 
    nv_inspno     = ""
    nv_insresult  = "" 
    nv_prepol     = "" 
    /*-- Add By Tontawan S. A66-0006 ---*/
    nv_docno      = ""
    nv_br         = ""    
    n_person      = "0.00"
    n_peracc      = "0.00"
    n_pd          = "0.00"
    n_si411       = "0.00"
    n_si412       = "0.00"
    n_si43        = "0.00"
    /*-- End By Tontawan S. A66-0006 --*/
    /*-- Add By Tontawan S. A68-0059 --*/
    n_drv3_salutation_M = ""
    n_drv3_fname        = ""
    n_drv3_lname        = ""
    n_drv3_nid          = ""
    n_drv3_occupation   = ""
    n_drv3_gender       = ""
    n_drv3_birthdate    = ""
    n_drv4_salutation_M = ""
    n_drv4_fname        = ""
    n_drv4_lname        = ""
    n_drv4_nid          = ""
    n_drv4_occupation   = ""
    n_drv4_gender       = ""
    n_drv4_birthdate    = ""
    n_drv5_salutation_M = ""
    n_drv5_fname        = ""
    n_drv5_lname        = ""
    n_drv5_nid          = ""
    n_drv5_occupation   = ""
    n_drv5_gender       = ""
    n_drv5_birthdate    = ""
    n_drv1_dlicense     = ""
    n_drv2_dlicense     = ""
    n_drv3_dlicense     = ""
    n_drv4_dlicense     = ""
    n_drv5_dlicense     = ""
    n_baty_snumber      = ""
    n_batydate          = ""
    n_baty_rsi          = "0.00"
    n_baty_npremium     = "0.00"
    n_baty_gpremium     = "0.00"
    n_wcharge_snumber   = "0.00"
    n_wcharge_si        = "0.00"
    n_wcharge_npremium  = "0.00".
    /*-- End By Tontawan S. A68-0059 --*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_createisp c-wins 
PROCEDURE pd_createisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chNotesSession  AS COM-HANDLE.
DEF VAR chNotesDataBase AS COM-HANDLE.
DEF VAR chDocument      AS COM-HANDLE.
DEF VAR chNotesView     AS COM-HANDLE.
DEF VAR chNavView       AS COM-HANDLE.
DEF VAR chViewEntry     AS COM-HANDLE.
DEF VAR chItem          AS COM-HANDLE.
DEF VAR chData          AS COM-HANDLE.
DEF VAR nv_server       AS CHAR.
DEF VAR nv_tmp          AS CHAR.
DEF VAR n_cha_no        AS CHAR. //TEST

ASSIGN 
    nv_docno = ""
    n_cha_no = ""
    nv_year  = ""
    nv_tmp   = ""

    nv_year  = STRING(YEAR(TODAY),"9999").
    nv_tmp   = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf".

/*--------- Server Real ----------*/
nv_server = "Safety_NotesServer/Safety".
nv_tmp    = "safety\uw\" + nv_tmp .
/*-------------------------------*/

    /* IF brstat.tlt.nor_noti_ins = "T2305003170" THEN ASSIGN n_cha_no = "MP1TFR87JTT018354".
ELSE IF brstat.tlt.nor_noti_ins = "T2305016993" THEN ASSIGN n_cha_no = "MR2KC3F3401432984".
ELSE IF brstat.tlt.nor_noti_ins = "T2305017068" THEN ASSIGN n_cha_no = "MR054RU3008014938".*/

/*---------- Server test local ------- //A68-0059 27/03/2025 --
nv_server = "".
nv_tmp    = "D:\Lotus\inspect23.nsf".
/* ----Server test local --------*/*/

CREATE "Notes.NotesSession"  chNotesSession.

chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).
IF chNotesDatabase:IsOpen() = NO THEN  DO:
    MESSAGE "Can not open database" SKIP  
            "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
END.

chNotesView  = chNotesDatabase:GetView("เลขตัวถัง").
chNavView    = chNotesView:CreateViewNavFromCategory(brstat.tlt.cha_no). //MP1TFR87JTT018354, MR2KC3F3401432984, MR054RU3008014938, MRHGN1660NT100278, MR0ZX69G900100167
chViewEntry  = chNavView:GetLastDocument.

IF chViewEntry <> 0 THEN DO: 
    chDocument = chViewEntry:Document.

    IF VALID-HANDLE(chDocument) = YES THEN DO:
        chitem = chDocument:Getfirstitem("docno").      /*เลขตรวจสภาพ*/
        IF chitem <> 0 AND TRIM(brstat.tlt.flag) <> "V72" THEN nv_docno = chitem:TEXT. 
        ELSE nv_docno = "".
    END.
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_data_insp c-wins 
PROCEDURE pd_data_insp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
        nv_campnam   = trim(substr(brstat.tlt.lotno,R-INDEX(tlt.lotno,"CamName:") + 8 ))     /*ชื่อแคมเปญ*/
        n_char       = trim(SUBSTR(brstat.tlt.lotno,1,R-INDEX(tlt.lotno,"CamName:") - 2 ))
        nv_camp      = trim(substr(n_char,R-INDEX(n_char,"CamCode:") + 8))                   /*รหัสแคมเปญ*/

        nv_pacgnam   = TRIM(SUBSTR(brstat.tlt.usrsent,R-INDEX(brstat.tlt.usrsent,"PlanNam:") + 8))   /*ชื่อแผน    */ 
        n_char       = TRIM(SUBSTR(brstat.tlt.usrsent,1,R-INDEX(tlt.usrsent,"PlanNam:") - 2))
        nv_pacg      = trim(substr(n_char,R-INDEX(n_char,"PlanCod:") + 8))   /*รหัสแผน */ 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PlanCod:") - 2)) 
        nv_producnam = trim(substr(n_char,R-INDEX(n_char,"proname:") + 8))   /*ชื่อผลิตภัณฑ์ */ 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"proname:") - 2)) 
        nv_produc    = trim(substr(n_char,R-INDEX(n_char,"procode:") + 8))   /*รหัสผลิตภัณฑ์ */ 


        n_char       = trim(tlt.ins_name)
        nv_surth     = IF n_char <> " "  THEN trim(SUBSTR(n_char,R-INDEX(n_char," ")))                   ELSE ""
        n_char       = IF n_char <> " "  THEN trim(SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(nv_surth)))   ELSE ""
        nv_nameth    = IF n_char <> " "  THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," ")))                 ELSE ""
        n_char       = IF n_char <> " "  THEN trim(SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(nv_nameth)))  ELSE ""
        nv_titleth   = IF n_char <> " "  THEN TRIM(SUBSTR(n_char,1,LENGTH(n_char)))                      ELSE "" 

        nv_mail      = trim(SUBSTR(brstat.tlt.ins_addr2,R-INDEX(brstat.tlt.ins_addr2,"Inspmal:") + 8 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.ins_addr2,1,R-INDEX(brstat.tlt.ins_addr2,"Inspmal:") - 2 ))
        nv_line      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"InspLin:") + 8 ))
        n_char       = TRIM(SUBSTR(n_char,9,R-INDEX(n_char,"InspLin:") - 9))
        nv_poltel    = TRIM(n_char)

             /* อุปกรณ์ตกแต่ง */
        nv_accpric5  = string(deci(substr(brstat.tlt.filler1,R-INDEX(brstat.tlt.filler1,"Acp5:") + 5)))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler1,1,R-INDEX(brstat.tlt.filler1,"Acp5:") - 2 ))
        nv_accdet5   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd5:") - 2))
        nv_accr5     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc5:") - 2 ))
        nv_accpric4  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 )))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 ))
        nv_accdet4   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 ))
        nv_accr4     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc4:") - 2 ))
        nv_accpric3  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 ))) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))
        nv_accdet3   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 )) 
        nv_accr3     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc3:") - 2 ))
        nv_accpric2  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 ))) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 ))
        nv_accdet2   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 ))
        nv_accr2     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc2:") - 2 ))
        nv_accpric1  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 ))) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 ))  
        nv_accdet1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd1:") - 2 ))
        nv_accr1     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc1:") + 5 )) 

        nv_inspno    = TRIM(brstat.tlt.nor_noti_tlt)
        nv_insresult = TRIM(brstat.tlt.safe1).  
       
       

        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_data_noti c-wins 
PROCEDURE pd_data_noti :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF R-INDEX(tlt.lotno,"CamName:") <> 0 THEN nv_campnam = trim(substr(brstat.tlt.lotno,R-INDEX(tlt.lotno,"CamName:") + 8 )) .    /*ชื่อแคมเปญ*/
    IF R-INDEX(tlt.lotno,"CamName:") <> 0 THEN n_char     = trim(SUBSTR(brstat.tlt.lotno,1,R-INDEX(tlt.lotno,"CamName:") - 2 )).
    IF R-INDEX(n_char,"CamCode:")    <> 0 THEN nv_camp    = trim(substr(n_char,R-INDEX(n_char,"CamCode:") + 8)).                   /*รหัสแคมเปญ*/
    IF R-INDEX(n_char,"CamCode:")    <> 0 THEN n_char     = trim(SUBSTR(n_char,1,R-INDEX(n_char,"CamCode:") - 2)).
    IF R-INDEX(n_char,"insname:")    <> 0 THEN nv_comnam  = trim(substr(n_char,R-INDEX(n_char,"insname:") + 8)) .                  /*ชื่อบริษัท */
    IF R-INDEX(n_char,"insname:")    <> 0 THEN n_char     = trim(SUBSTR(n_char,1,R-INDEX(n_char,"insname:") - 2)).
    IF R-INDEX(n_char,"InsCode:")    <> 0 THEN nv_comcod  = trim(substr(n_char,R-INDEX(n_char,"InsCode:") + 8)) .                  /*รหัสบริษัท*/
    IF R-INDEX(brstat.tlt.usrsent,"packcod:") <> 0 THEN       nv_pacg      = TRIM(SUBSTR(brstat.tlt.usrsent,R-INDEX(brstat.tlt.usrsent,"packcod:") + 8)) .  /*รหัสแพคเกจ    */ 
    IF R-INDEX(tlt.usrsent,"packcod:")        <> 0 THEN       n_char       = TRIM(SUBSTR(brstat.tlt.usrsent,1,R-INDEX(tlt.usrsent,"packcod:") - 2)).
    IF R-INDEX(n_char,"packnam:") <> 0 THEN nv_pacgnam   = trim(substr(n_char,R-INDEX(n_char,"packnam:") + 8)).    /*ชื่อแพคเกจ    */ 
    IF R-INDEX(n_char,"packnam:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"packnam:") - 2)).
    IF R-INDEX(n_char,"proname:") <> 0 THEN nv_producnam = trim(substr(n_char,R-INDEX(n_char,"proname:") + 8)) .   /*ชื่อผลิตภัณฑ์ */ 
    IF R-INDEX(n_char,"proname:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"proname:") - 2)).
    IF R-INDEX(n_char,"procode:") <> 0 THEN nv_produc    = trim(substr(n_char,R-INDEX(n_char,"procode:") + 8)).     /*รหัสผลิตภัณฑ์ */ 
    /*-- ชื่อสกุลลูกค้า ---*/
    IF R-INDEX(tlt.ins_name,"nameeng:") <> 0 THEN  n_char       = trim(SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name,"nameeng:") + 8 )).
    IF R-INDEX(n_char," ") <> 0 THEN nv_sureng  = TRIM(SUBSTR(n_char,R-INDEX(n_char," "))) .
    n_char       = IF n_char <> " "  THEN trim(SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(nv_sureng)))  ELSE "".
    nv_nameeng   = IF n_char <> " "  then trim(SUBSTR(n_char,r-INDEX(n_char," ")))                   ELSE "" .
    n_char       = IF n_char <> " "  THEN trim(SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(nv_nameeng))) ELSE "" .
    nv_titleeng  = TRIM(n_char).
    IF INDEX(tlt.ins_name,"nameeng:") <> 0 THEN n_char       = trim(SUBSTR(tlt.ins_name,1,INDEX(tlt.ins_name,"nameeng:") - 2)).
    IF R-INDEX(n_char," ") <> 0 THEN 
        ASSIGN nv_surth     =  trim(SUBSTR(n_char,R-INDEX(n_char," ")))   
        n_char       =  trim(SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(nv_surth)))  .
    IF R-INDEX(n_char," ") <> 0  THEN
        ASSIGN nv_nameth    =  trim(SUBSTR(n_char,R-INDEX(n_char," ")))             
        n_char       =  trim(SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(nv_nameth)))  
        nv_titleth   =  TRIM(SUBSTR(n_char,9,LENGTH(n_char)))                     .
    /*-- เลขบัตร วันเกิด เพศ อาขีพ --*/
    IF R-INDEX(tlt.rec_addr5,"occup:")        <> 0 THEN    nv_polocc    = trim(SUBSTR(brstat.tlt.rec_addr5,R-INDEX(tlt.rec_addr5,"occup:") + 6 )).
    IF R-INDEX(tlt.rec_addr5,"Occup:")        <> 0 THEN    n_char       = TRIM(SUBSTR(brstat.tlt.rec_addr5,1,R-INDEX(tlt.rec_addr5,"Occup:") - 2 )).
    IF R-INDEX(n_char,"Birth:")               <> 0 THEN    nv_polbdate  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Birth:") + 6 )).
    IF R-INDEX(n_char,"Birth:")               <> 0 THEN    n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Birth:") - 2 )).
    IF R-INDEX(n_char,"Sex:")                 <> 0 THEN    nv_sex       = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Sex:") + 4 )).
    IF R-INDEX(n_char,"Sex:")                 <> 0 THEN    nv_icno      = TRIM(SUBSTR(n_char,6,R-INDEX(n_char,"Sex:") - 6 )) .
    /*-- เบอร์โทร เมล์ ไลน์ ---*/             
    IF R-INDEX(brstat.tlt.ins_addr5,"Linid:") <> 0 THEN    nv_line     = trim(SUBSTR(brstat.tlt.ins_addr5,R-INDEX(brstat.tlt.ins_addr5,"Linid:") + 6 )).
    IF R-INDEX(brstat.tlt.ins_addr5,"Linid:") <> 0 THEN    n_char      = TRIM(SUBSTR(brstat.tlt.ins_addr5,1,R-INDEX(brstat.tlt.ins_addr5,"Linid:") - 2 )).
    IF R-INDEX(n_char,"Email:")               <> 0 THEN    nv_mail     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Email:") + 6 )).
    IF R-INDEX(n_char,"Email:")               <> 0 THEN    nv_poltel   = TRIM(SUBSTR(n_char,7,R-INDEX(n_char,"Email:") - 7 )) .
        

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_data_noti1 c-wins 
PROCEDURE pd_data_noti1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    /*--ผู้ขับขี่ ---*/
    nv_driver   = string(brstat.tlt.endcnt). 
    IF R-INDEX(brstat.tlt.dri_name1,"DriID1:") <> 0 THEN nv_driid1   = TRIM(substr(brstat.tlt.dri_name1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") + 7 )).
    IF R-INDEX(brstat.tlt.dri_name1,"DriID1:") <> 0 THEN n_char      = TRIM(SUBSTR(brstat.tlt.dri_name1,1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") - 2 )).
    nv_drisur1  = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE "".
    n_char      = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char.
    nv_drinam1  = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char,"Drinam1:") + 8)) ELSE "" .

    IF R-INDEX(brstat.tlt.dri_no1,"Dribir1:") <> 0 then nv_dridate1 = TRIM(SUBSTR(brstat.tlt.dri_no1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") + 8 )).
    IF R-INDEX(brstat.tlt.dri_no1,"Dribir1:")  <> 0 then n_char      = TRIM(SUBSTR(brstat.tlt.dri_no1,1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") - 2)).
    IF R-INDEX(n_char,"drisex1:") <> 0 then nv_drisex1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex1:") + 8 )).
    IF R-INDEX(n_char,"drisex1:") <> 0 then n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex1:") - 2)).
    IF R-INDEX(n_char,"DriOcc1:") <> 0 then nv_driocc1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc1:") + 8)).
    IF R-INDEX(brstat.tlt.dri_name2,"DriID2:") <> 0 then nv_driid2   = TRIM(substr(brstat.tlt.dri_name2,R-INDEX(brstat.tlt.dri_name2,"DriID2:") + 7 ))  .   
    IF R-INDEX(brstat.tlt.dri_name2,"DriID2:") <> 0 then n_char      = TRIM(SUBSTR(brstat.tlt.dri_name2,1,R-INDEX(brstat.tlt.dri_name2,"DriID2:") - 2 ))  . 
    nv_drisur2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE ""    .    
    n_char      = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char .
    nv_drinam2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,9,R-INDEX(n_char,"Drinam2:") + 8)) ELSE ""  .
    IF R-INDEX(brstat.tlt.dri_no2,"Dribir2:") <> 0 then nv_dridate2 = TRIM(SUBSTR(brstat.tlt.dri_no2,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") + 8)).
    IF R-INDEX(brstat.tlt.dri_no2,"Dribir2:") <> 0 then n_char      = TRIM(SUBSTR(brstat.tlt.dri_no2,1,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") - 2)).
    IF R-INDEX(n_char,"drisex2:") <> 0 then nv_drisex2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex2:") + 8 )).
    IF R-INDEX(n_char,"drisex2:") <> 0 then n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex2:") - 2 )).
    IF R-INDEX(n_char,"DriOcc2:") <> 0 then nv_driocc2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc2:") + 8 )) .
    

    /*--การชำระเงิน --*/
    IF R-INDEX(brstat.tlt.EXP,"Branch:") <> 0 THEN     nv_branch   = TRIM(SUBSTR(brstat.tlt.EXP,R-INDEX(brstat.tlt.EXP,"Branch:") + 7 )).
    IF R-INDEX(brstat.tlt.EXP,"Branch:") <> 0 THEN          n_char      = trim(substr(brstat.tlt.EXP,1,R-INDEX(brstat.tlt.EXP,"Branch:") - 2 )).
    IF LENGTH(n_char)  > 7 THEN       nv_paytyp   = trim(substr(n_char,8,LENGTH(n_char))). 
    IF R-INDEX(brstat.tlt.rec_name," ") <> 0 THEN          nv_paysur   = TRIM(substr(brstat.tlt.rec_name,R-INDEX(brstat.tlt.rec_name," "))).
    nv_paynam   = trim(substr(brstat.tlt.rec_name,1,LENGTH(brstat.tlt.rec_name) - LENGTH(nv_paysur))).
    IF R-INDEX(brstat.tlt.safe2,"Paymentty:") <> 0 THEN     nv_waytyp   = trim(substr(brstat.tlt.safe2,R-INDEX(brstat.tlt.safe2,"Paymentty:") + 10 )).
    IF R-INDEX(brstat.tlt.safe2,"Paymentty:") <> 0 THEN     n_char      = TRIM(SUBSTR(brstat.tlt.safe2,1,R-INDEX(brstat.tlt.safe2,"Paymentty:") - 2 )).
    IF R-INDEX(n_char,"PaymentTyCd:") <> 0 THEN     nv_payway   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentTyCd:") + 12 ))  .
    IF R-INDEX(n_char,"PaymentTyCd:") <> 0 THEN     n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PaymentTyCd:") - 2 )) .
    IF R-INDEX(n_char,"PaymentMDTy:") <> 0 THEN     nv_paymtyp  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMDTy:") + 12 ))  .
    IF R-INDEX(n_char,"PaymentMDTy:") <> 0 THEN     n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PaymentMDTy:") - 2 )) .
    IF R-INDEX(n_char,"PaymentMD:")   <> 0 THEN     nv_paymcod  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMD:") + 10 ))    .
    nv_bank     = TRIM(brstat.tlt.safe3) .
    IF R-INDEX(brstat.tlt.rec_addr4,"Paid:") <> 0 THEN     nv_paidsts  = TRIM(SUBSTR(brstat.tlt.rec_addr4,R-INDEX(brstat.tlt.rec_addr4,"Paid:") + 5 )).
    IF R-INDEX(brstat.tlt.rec_addr4,"Paid:")<> 0 THEN     n_char      = TRIM(SUBSTR(brstat.tlt.rec_addr4,1,R-INDEX(brstat.tlt.rec_addr4,"Paid:") - 2 )).
    IF R-INDEX(n_char,"paysts:") <> 0 THEN     nv_paysts   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"paysts:") + 7 )).
    IF R-INDEX(n_char,"paysts:") <> 0 THEN     n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"paysts:") - 2 )).
    IF R-INDEX(n_char,"Paydat:") <> 0 THEN     nv_paydat   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Paydat:") + 7 )).
    /* garage */
    IF R-INDEX(tlt.old_cha,"garty:") <> 0 THEN nv_garage    = TRIM(SUBSTR(brstat.tlt.old_cha,R-INDEX(tlt.old_cha,"garty:") + 6 )).
    IF R-INDEX(tlt.old_cha,"garty:") <> 0 THEN n_char       = TRIM(SUBSTR(brstat.tlt.old_cha,1,R-INDEX(tlt.old_cha,"garty:") - 2 )).
    nv_garcod    = trim(substr(n_char,7,LENGTH(n_char))).
    /* ประเภทความคุ้มครอง */
    IF R-INDEX(brstat.tlt.rec_addr3,"covty2:") <> 0 THEN nv_covdetail = TRIM(SUBSTR(brstat.tlt.rec_addr3,R-INDEX(brstat.tlt.rec_addr3,"covty2:") + 7 )).
    IF R-INDEX(brstat.tlt.rec_addr3,"Covty2:") <> 0 THEN n_char       = TRIM(SUBSTR(brstat.tlt.rec_addr3,1,R-INDEX(brstat.tlt.rec_addr3,"Covty2:") - 2 )).
    IF R-INDEX(n_char,"covty1:")    <> 0 THEN nv_subcover  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"covty1:") + 7 )).
    IF R-INDEX(n_char,"covty1:")    <> 0 THEN n_char    = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"covty1:") - 2 )).
    IF R-INDEX(n_char,"covtyp:")    <> 0 THEN nv_cover  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"covtyp:") + 7 )).
    IF R-INDEX(n_char,"covtyp:")    <> 0 THEN n_char    = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"covtyp:") - 2 )).
    IF R-INDEX(n_char,"covtcd:")    <> 0 THEN nv_covcod = TRIM(SUBSTR(n_char,R-INDEX(n_char,"covtcd:") + 7 )).
    IF INDEX(n_char,"covtcd:")      <> 0 THEN nv_covtyp = TRIM(SUBSTR(n_char,8,INDEX(n_char,"covtcd:") - 8 )).
    IF      index(nv_covtyp,"2+")   <> 0 THEN nv_covtyp = "2.2".
    ELSE IF index(nv_covtyp,"3+")   <> 0 THEN nv_covtyp = "3.2".
    ELSE IF index(nv_covtyp,"3")    <> 0 THEN nv_covtyp = "3".
    ELSE IF index(nv_covtyp,"2")    <> 0 THEN nv_covtyp = "2".
    ELSE IF index(nv_covtyp,"1")    <> 0 THEN nv_covtyp = "1" .
    IF      INDEX(nv_garcod,"ห้าง") <> 0 THEN nv_garcod = "G". ELSE  nv_garcod = "".
 END.                                    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_data_noti2 c-wins 
PROCEDURE pd_data_noti2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 DO:
     /*- แสตมป์ vat --*/
     IF R-INDEX(brstat.tlt.stat,"Vat:")  <> 0 THEN nv_stamp     = string(DECI(SUBSTR(brstat.tlt.stat,5,R-INDEX(brstat.tlt.stat,"Vat:") - 5))) . 
     IF R-INDEX(brstat.tlt.stat,"Vat:") <> 0 THEN nv_vat       = string(DECI(SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"Vat:") + 4 ))). 
     /* ส่วนลด */
     IF R-INDEX(brstat.tlt.comp_sck,"felA:")       <> 0 THEN nv_feeltp = string(DECI(SUBSTR(brstat.tlt.comp_sck,6,R-INDEX(brstat.tlt.comp_sck,"felA:") - 6))) .  
     IF R-INDEX(brstat.tlt.comp_sck ,"felA:")      <> 0 THEN nv_feelt  = string(DECI(SUBSTR(brstat.tlt.comp_sck,R-INDEX(brstat.tlt.comp_sck ,"felA:") + 5 ))) . 
     IF R-INDEX(brstat.tlt.comp_noti_tlt,"ncbA:")  <> 0 THEN nv_ncbp   = string(DECI(SUBSTR(brstat.tlt.comp_noti_tlt,6,R-INDEX(brstat.tlt.comp_noti_tlt,"ncbA:") - 6))) .        
     IF R-INDEX(brstat.tlt.comp_noti_tlt ,"ncbA:") <> 0 THEN nv_ncb    = string(DECI(SUBSTR(brstat.tlt.comp_noti_tlt,R-INDEX(brstat.tlt.comp_noti_tlt ,"ncbA:") + 5 ))) .    
     IF R-INDEX(brstat.tlt.comp_usr_tlt,"DriA:")   <> 0 THEN nv_drip   = string(DECI(SUBSTR(brstat.tlt.comp_usr_tlt,6,R-INDEX(brstat.tlt.comp_usr_tlt,"DriA:") - 6))) .       
     IF R-INDEX(brstat.tlt.comp_usr_tlt ,"DriA:")  <> 0 THEN nv_dridis = string(DECI(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt ,"DriA:") + 5 ))) .     
     IF R-INDEX(brstat.tlt.comp_noti_ins,"OthA:")  <> 0 THEN nv_oth    = string(DECI(SUBSTR(brstat.tlt.comp_noti_ins,6,R-INDEX(brstat.tlt.comp_noti_ins,"OthA:") - 6))).        
     IF R-INDEX(brstat.tlt.comp_noti_ins ,"OthA:") <> 0 THEN nv_othdis = string(DECI(SUBSTR(brstat.tlt.comp_noti_ins,R-INDEX(brstat.tlt.comp_noti_ins ,"OthA:") + 5 ))).      
     IF R-INDEX(brstat.tlt.comp_usr_ins,"ctvA:")   <> 0 THEN nv_cctvp  = string(DECI(SUBSTR(brstat.tlt.comp_usr_ins,6,R-INDEX(brstat.tlt.comp_usr_ins,"ctvA:") - 6))) .        
     IF R-INDEX(brstat.tlt.comp_usr_ins ,"ctvA:")  <> 0 THEN nv_cctv   = string(DECI(SUBSTR(brstat.tlt.comp_usr_ins,R-INDEX(brstat.tlt.comp_usr_ins ,"ctvA:") + 5 ))) . 
     IF R-INDEX(brstat.tlt.comp_pol,"Surd:")       <> 0 THEN nv_discdetail = trim(SUBSTR(brstat.tlt.comp_pol,R-INDEX(brstat.tlt.comp_pol,"Surd:") + 5 )).
     IF R-INDEX(brstat.tlt.comp_pol,"surd:")       <> 0 THEN n_char    = TRIM(SUBSTR(brstat.tlt.comp_pol,1,R-INDEX(brstat.tlt.comp_pol,"surd:") - 2 )).
     IF R-INDEX(n_char,"SurA:") <> 0 THEN nv_discp = string(DECI(SUBSTR(n_char,6,R-INDEX(n_char,"SurA:") - 6)))  .      
     IF R-INDEX(n_char,"SurA:") <> 0 THEN nv_disc  = string(DECI(SUBSTR(n_char,R-INDEX(n_char,"SurA:") + 5 ))).
     /* อุปกรณ์ตกแต่ง */
     IF R-INDEX(brstat.tlt.filler1,"Acp5:") <> 0 THEN nv_accpric5  = string(deci(substr(brstat.tlt.filler1,R-INDEX(brstat.tlt.filler1,"Acp5:") + 5))).
     IF R-INDEX(brstat.tlt.filler1,"Acp5:") <> 0 THEN n_char       = TRIM(SUBSTR(brstat.tlt.filler1,1,R-INDEX(brstat.tlt.filler1,"Acp5:") - 2 )).
     IF R-INDEX(n_char,"Acd5:") <> 0 THEN nv_accdet5   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd5:") + 5 ))   .
     IF R-INDEX(n_char,"Acd5:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd5:") - 2))  .
     IF R-INDEX(n_char,"Acc5:") <> 0 THEN nv_accr5     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc5:") + 5 ))   .
     IF R-INDEX(n_char,"Acc5:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc5:") - 2 )) .
     IF R-INDEX(n_char,"Acp4:") <> 0 THEN nv_accpric4  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 ))).
     IF R-INDEX(n_char,"Acp4:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 )) .
     IF R-INDEX(n_char,"Acd4:") <> 0 THEN nv_accdet4   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))   .
     IF R-INDEX(n_char,"Acd4:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 )) .
     IF R-INDEX(n_char,"Acc4:") <> 0 THEN nv_accr4     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc4:") + 5 ))   .
     IF R-INDEX(n_char,"Acc4:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc4:") - 2 )) .
     IF R-INDEX(n_char,"Acp3:") <> 0 THEN nv_accpric3  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 ))) .
     IF R-INDEX(n_char,"Acp3:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))  .
     IF R-INDEX(n_char,"Acd3:") <> 0 THEN nv_accdet3   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 ))    .
     IF R-INDEX(n_char,"Acd3:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 ))  .
     IF R-INDEX(n_char,"Acc3:") <> 0 THEN nv_accr3     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc3:") + 5 ))    .
     IF R-INDEX(n_char,"Acc3:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc3:") - 2 ))  .
     IF R-INDEX(n_char,"Acp2:") <> 0 THEN nv_accpric2  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 ))) .
     IF R-INDEX(n_char,"Acp2:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 )) .
     IF R-INDEX(n_char,"Acd2:") <> 0 THEN nv_accdet2   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 ))   .
     IF R-INDEX(n_char,"Acd2:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 )) .
     IF R-INDEX(n_char,"Acc2:") <> 0 THEN nv_accr2     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc2:") + 5 ))   .
     IF R-INDEX(n_char,"Acc2:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc2:") - 2 )) .
     IF R-INDEX(n_char,"Acp1:") <> 0 THEN nv_accpric1  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 ))) .
     IF R-INDEX(n_char,"Acp1:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 )) . 
     IF R-INDEX(n_char,"Acd1:") <> 0 THEN nv_accdet1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 ))        .
     IF R-INDEX(n_char,"Acd1:") <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd1:") - 2 ))      .
     IF R-INDEX(n_char,"Acc1:") <> 0 THEN nv_accr1     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc1:") + 5 ))       .
       
 END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_data_noti3 c-wins 
PROCEDURE pd_data_noti3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    /* remark  */
    IF R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") <> 0 THEN nv_inspres   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,8,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") - 8)).
    IF R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") <> 0 THEN nv_inspdet   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") + 7))  .
    IF R-INDEX(brstat.tlt.old_eng,"Bcode:")       <> 0 THEN nv_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bcode:") + 6 ))            .
    IF R-INDEX(brstat.tlt.old_eng,"Bcode:")       <> 0 THEN n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bcode:") - 2 ))          .
    IF R-INDEX(n_char,"bname:")                   <> 0 THEN nv_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))                                    .
    IF R-INDEX(n_char,"bname:")                   <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))                                  .
    IF R-INDEX(n_char,"Blice:")                   <> 0 THEN nv_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Blice:") + 6 ))                                    .
    IF R-INDEX(brstat.tlt.filler2,"Remark:")      <> 0 THEN nv_remark    = TRIM(SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"Remark:") + 7 ))           .
    IF R-INDEX(brstat.tlt.filler2,"Remark:")      <> 0 THEN n_char       = TRIM(SUBSTR(brstat.tlt.filler2,1,R-INDEX(brstat.tlt.filler2,"Remark:") - 2 ))         .
    IF R-INDEX(n_char,"Detai4:")                  <> 0 THEN nv_gift      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai4:") + 7 ))                                   .
    IF R-INDEX(n_char,"Detai4:")                  <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Detai4:") - 2 ))                                 .
    IF R-INDEX(n_char,"Detai3:")                  <> 0 THEN nv_remarksend = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai3:") + 7 ))                                  .
    IF R-INDEX(n_char,"detai3:")                  <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"detai3:") - 2 ))                                 .
    IF R-INDEX(n_char,"Detai2:")                  <> 0 THEN nv_polsend   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai2:") + 7 ))                                   .
    IF R-INDEX(n_char,"detai2:")                  <> 0 THEN n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"detai2:") - 2 ))                                 .
    IF R-INDEX(n_char,"Detai1:")                  <> 0 THEN nv_lang      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai1:") + 7 )) .                              
                                                                                                          
    /*-- Add By Tontawan S. A68-0059 --*/
    n_drv3_salutation_M = TRIM(brstat.tlt.dri_title3). 
    n_drv3_fname        = TRIM(brstat.tlt.dri_fname3).   
    n_drv3_lname        = TRIM(brstat.tlt.dri_lname3).   
    n_drv3_nid          = TRIM(brstat.tlt.dri_ic3).   
    n_drv3_occupation   = TRIM(brstat.tlt.dir_occ3).   
    n_drv3_gender       = TRIM(brstat.tlt.dri_gender3).
    n_drv3_birthdate    = TRIM(STRING(brstat.tlt.dri_birth3)).  
    n_drv4_salutation_M = TRIM(brstat.tlt.dri_title4).  
    n_drv4_fname        = TRIM(brstat.tlt.dri_fname4).  
    n_drv4_lname        = TRIM(brstat.tlt.dri_lname4).  
    n_drv4_nid          = TRIM(brstat.tlt.dri_ic4).  
    n_drv4_occupation   = TRIM(brstat.tlt.dri_occ4).  
    n_drv4_gender       = TRIM(brstat.tlt.dri_gender4).
    n_drv4_birthdate    = TRIM(STRING(brstat.tlt.dri_birth4)).  
    n_drv5_salutation_M = TRIM(brstat.tlt.dri_title5).  
    n_drv5_fname        = TRIM(brstat.tlt.dri_fname5).  
    n_drv5_lname        = TRIM(brstat.tlt.dri_lname5).  
    n_drv5_nid          = TRIM(brstat.tlt.dri_ic5).  
    n_drv5_occupation   = TRIM(brstat.tlt.dri_occ5).  
    n_drv5_gender       = TRIM(brstat.tlt.dri_gender5).
    n_drv5_birthdate    = TRIM(STRING(brstat.tlt.dri_birth5)).
    n_drv1_dlicense     = TRIM(brstat.tlt.dri_lic1).
    n_drv2_dlicense     = TRIM(brstat.tlt.dri_lic2).
    n_drv3_dlicense     = TRIM(brstat.tlt.dri_lic3).
    n_drv4_dlicense     = TRIM(brstat.tlt.dri_lic4).
    n_drv5_dlicense     = TRIM(brstat.tlt.dri_lic5).
    n_baty_snumber      = TRIM(brstat.tlt.battno).   
    n_batydate          = TRIM(brstat.tlt.battyr).   
    n_baty_rsi          = TRIM(STRING(brstat.tlt.battsi)).   
    n_baty_npremium     = TRIM(STRING(brstat.tlt.battprem)).
    n_baty_gpremium     = TRIM(STRING(brstat.tlt.ndeci1)).
    n_wcharge_snumber   = TRIM(STRING(brstat.tlt.chargno)).   
    n_wcharge_si        = TRIM(STRING(brstat.tlt.chargsi)).   
    n_wcharge_npremium  = TRIM(STRING(brstat.tlt.chargprem)).
    n_wcharge_gpremium  = TRIM(STRING(brstat.tlt.ndeci2)).
    /*-- Add By Tontawan S. A68-0059 --*/

    FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
               brstat.insure.compno = "999"       AND 
               brstat.insure.FName  = trim(brstat.tlt.lince2) NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN   
         ASSIGN nv_province = Insure.LName.
    ELSE ASSIGN nv_province = trim(brstat.tlt.lince2).

    ASSIGN 
        nv_cha_no  = "" 
        nv_cha_no  =    trim(brstat.tlt.cha_no)  .
     
    ASSIGN  
        nv_yrpol = 0    nv_yr = 0  nv_prepol = "" .   
        nv_cha_no =  trim(brstat.tlt.cha_no).

    RUN proc_chassis.

    IF TRIM(brstat.tlt.flag) = "V70" THEN DO:
        FIND LAST sicuw.uwm301 USE-INDEX uwm30121  WHERE 
                  sicuw.uwm301.cha_no = TRIM(nv_cha_no) AND 
                  sicuw.uwm301.tariff = "X" NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL sicuw.uwm301 THEN DO:
              
             nv_yrpol = (INT(SUBSTR(sicuw.uwm301.policy,5,2)) + 2500 ).
             nv_yr    = (YEAR(TODAY) + 543 ) . 
             nv_yr    = nv_yr - nv_yrpol .
             IF nv_yr <= 5 THEN ASSIGN nv_prepol = sicuw.uwm301.policy.
             ELSE ASSIGN nv_prepol = "" .
             
         END.
         ELSE ASSIGN nv_prepol = "" .
    END.
    ELSE DO:
        /*FIND LAST sicuw.uwm301 USE-INDEX uwm30121  WHERE 
                  sicuw.uwm301.cha_no = TRIM(nv_cha_no) AND
                  sicuw.uwm301.tariff = "9" NO-LOCK NO-ERROR NO-WAIT. -- Comment By Tontawan S. A65-0141 --*/
        /*-- Add By Tontawan S. A65-0141 --*/
        FIND LAST sicuw.uwm301 USE-INDEX uwm30121  WHERE 
                  sicuw.uwm301.cha_no = TRIM(nv_cha_no) AND 
           SUBSTR(sicuw.uwm301.policy,1,1)   <> "Q"     AND
           SUBSTR(sicuw.uwm301.policy,1,1)   <> "C"     AND
           SUBSTR(sicuw.uwm301.policy,1,1)   <> "R"     AND
                  sicuw.uwm301.tariff = "9" NO-LOCK NO-ERROR NO-WAIT.
        /*-- End By Tontawan S. A65-0141 --*/
        IF AVAIL sicuw.uwm301 THEN DO:
           nv_yrpol = (INT(SUBSTR(sicuw.uwm301.policy,5,2)) + 2500 ).
           nv_yr    = (YEAR(TODAY) + 543 ) . 
           nv_yr    = nv_yr - nv_yrpol .
           IF nv_yr <= 5 THEN 
                ASSIGN nv_prepol = sicuw.uwm301.policy.
           ELSE ASSIGN nv_prepol = "" .
        END.
        ELSE ASSIGN nv_prepol = "" .

        /*-- Add By Tontawan S. A65-0141 --*/
        IF LENGTH(nv_prepol) <> 12 AND nv_prepol <> "" THEN DO:
            FOR EACH sicuw.uwm301 WHERE  
                     sicuw.uwm301.cha_no = TRIM(nv_cha_no)     AND 
                     sicuw.uwm301.tariff = "9"                 AND 
                     SUBSTR(sicuw.uwm301.policy,1,1)   <> "Q"  AND
                     SUBSTR(sicuw.uwm301.policy,1,1)   <> "C"  AND
                     SUBSTR(sicuw.uwm301.policy,1,1)   <> "R"  AND
                     SUBSTR(sicuw.uwm301.policy,3,4)   >= "72" + nv_yearf  AND
                     SUBSTR(sicuw.uwm301.policy,3,4)   <= "72" + nv_yeart  NO-LOCK BY SUBSTR(sicuw.uwm301.policy,3,4) DESC:
            
                    IF nv_prepol <> "" THEN DO:
                        IF nv_prepol > sicuw.uwm301.policy THEN DO:
                            ASSIGN
                                nv_iyrp1 = 0
                                nv_iyrp2 = 0
                                nv_iyrp1 = int(SUBSTR(nv_prepol,5,2)          )    /*D07266000001*/  /*D07266000001*/   /*D07266000001*/   
                                nv_iyrp2 = int(SUBSTR(sicuw.uwm301.policy,5,2)).   /*DW7266000001*/  /*DW7265000001*/   /*DW7264000001*/   
                            IF nv_iyrp1 > nv_iyrp2 + 2 THEN DO:                    /*66 > 67     */  /*66 > 66     */   /*66 > 65     */   
                                LEAVE.
                            END.
                        END.    
                    END.
            
                    FIND sicuw.uwm100 USE-INDEX uwm10001 WHERE
                         sicuw.uwm100.policy = sicuw.uwm301.policy AND
                         sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                         sicuw.uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        IF sicuw.uwm100.expdat = ? THEN NEXT.
                        IF n_exp = ? OR n_exp < sicuw.uwm100.expdat THEN DO:
                            ASSIGN
                                n_exp     = sicuw.uwm100.expdat
                                nv_prepol = sicuw.uwm100.policy. 
                        END.
                    END.
            END.    
        END.
        /*-- Add By Tontawan S. A65-0141 --*/
    END.

    /*-- Add Tontawan S. A68-0059 --*/
    IF INDEX(TRIM(brstat.tlt.expotim),"E") <> 0 THEN ASSIGN n_newtrariff = NO.
    ELSE DO:
       IF INDEX(TRIM(brstat.tlt.expotim),"11") = 0 AND 
          INDEX(TRIM(brstat.tlt.expotim),"21") = 0 AND 
          INDEX(TRIM(brstat.tlt.expotim),"61") = 0 THEN DO:

            IF TODAY < 01/05/2025 THEN ASSIGN n_newtrariff = NO.
            ELSE ASSIGN n_newtrariff = YES.
        END.
    END.
    /*-- End Tontawan S. A68-0059 --*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportinsp c-wins 
PROCEDURE pd_reportinsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_count AS INT.
DEF VAR nv_data AS CHAR FORMAT "x(50)" INIT "".
If  SUBSTR(fi_outfile,LENGTH(fi_outfile) - 3,4) <>  ".slk" THEN 
    fi_outfile  =  TRIM(fi_outfile) + ".slk"  .
ASSIGN nv_count = 0 
       nv_data  = "" .
    /*nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Report SCBPT :" STRING(TODAY,"99/99/9999")   .
EXPORT DELIMITER "|" 
   "ลำดับที่       "                    /*1   */                                   
   "เลขที่ Prospect"                    /*2   */ 
   "รหัสแคมเปญ     "                    /*3   */ 
   "ชื่อแคมเปญ     "                    /*4   */ 
   "รหัสผลิตภัณฑ์  "                    /*5   */ 
   "ชื่อผลิตภัณฑ์  "                    /*6   */ 
   "รหัสย่อยผลิตภัณฑ์    "              /*7   */ 
   "ชื่อรหัสย่อยผลิตภัณฑ์"              /*8   */ 
   "เลขที่ใบคำขอ   "                    /*9   */ 
   "ชื่อผู้เอาประกัน     "              /*10  */ 
   "นามสกุลผู้เอาประกัน  "              /*11  */ 
   "เบอร์โทรศัพท์ผู้เอาประกัน"          /*12  */ 
   "ประเภทผู้เอาประกัน   "              /*13  */ 
   "วันทีนัดตรวจสภาพรถยนต์   "          /*14  */ 
   "เวลาที่นัดตรวจสภาพรถยนต์ "          /*15  */ 
   "ชื่อผู้ที่ติดต่อ     "              /*16  */ 
   "เบอร์โทรศัพท์ผู้ติดต่อ   "          /*17  */ 
   "Line ID        "                    /*18  */ 
   "email-ผู้ติดต่อ"                    /*19  */ 
   "ที่อยู่ในการตรวจสภาพรถยนต์ "        /*20  */ 
   "ยี่ห้อรถ       "                    /*21  */ 
   "รหัสรุ่นรถ     "                    /*22  */ 
   "รหัสรถ (MotorCode)"                 /*23  */ 
   "จำนวนที่นั่ง   "                    /*24  */ 
   "ขนาด ซี ซี     "                    /*25  */ 
   "น้ำหนัก        "                    /*26  */ 
   "จังหวัดที่จดทะเบียน "               /*27  */ 
   "ปีที่จดทะเบียน "                    /*28  */ 
   "ทะเบียนรถ      "                    /*29  */ 
   "หมายเลขตัวถัง  "                    /*30  */ 
   "หมายเลขเครื่อง "                    /*31  */ 
   "วันที่เริ่มคุ้มครอง  "              /*32  */ 
   "วันที่สิ้นสุดคุ้มครอง"              /*33  */ 
   "ทุนประกันภัย      "                 /*34  */  
   "ค่าเบี้ยประกันภัย "                 /*35  */ 
   "รหัสอุปกรณ์ส่วนเพิ่ม 01   "         /*36  */ 
   "รายละเอียดอุปกรณ์เสริม 01 "          /*37  */
   "ราคาของอุปกรณ์ส่วนเพิ่ม 01"         /*38  */ 
   "รหัสอุปกรณ์ส่วนเพิ่ม 02   "         /*39  */ 
   "รายละเอียดอุปกรณ์เสริม 02 "         /*40  */ 
   "ราคาของอุปกรณ์ส่วนเพิ่ม 02"         /*41  */ 
   "รหัสอุปกรณ์ส่วนเพิ่ม 03   "         /*42  */ 
   "รายละเอียดอุปกรณ์เสริม 03 "         /*43  */ 
   "ราคาของอุปกรณ์ส่วนเพิ่ม 03"         /*44  */ 
   "รหัสอุปกรณ์ส่วนเพิ่ม 04   "         /*45  */ 
   "รายละเอียดอุปกรณ์เสริม 04 "         /*46  */ 
   "ราคาของอุปกรณ์ส่วนเพิ่ม 04"         /*47  */ 
   "รหัสอุปกรณ์ส่วนเพิ่ม 05    "        /*48  */ 
   "รายละเอียดอุปกรณ์เสริม 05 "         /*49  */ 
   "ราคาของอุปกรณ์ส่วนเพิ่ม 05 "        /*50  */
   "สถานะการตรวจสภาพ "                  /*51  */
   "เลขที่ตรวจสภาพ"                     /*52  */ 
   "ข้อมูลการตรวจสภาพ"                  /*53  */ 
   "รายละเอียดอุปกรเสริม"               /*54  */ 
   "สถานะการส่งข้อมูล"                  /*55  */ 
   "วันที่ส่งข้อมูล".                   /*56*/ 
   
 nv_data = trim(fi_datare).
 loop_tlt:
 For each brstat.tlt Use-index  tlt01 Where
          brstat.tlt.trndat   >=  fi_trndatfr   And
          brstat.tlt.trndat   <=  fi_trndatto   And
          brstat.tlt.genusr    =  "SCBPT"       AND 
          brstat.tlt.flag      =  "INSPEC"      no-lock.
     
     IF cb_report = "วันที่นัดตรวจสภาพ" THEN DO:
         IF STRING(brstat.tlt.nor_effdat,"99/99/9999") <> nv_data THEN NEXT.
     END.
     ELSE IF cb_report = "ไม่มีความเสียหาย" THEN DO:
         IF INDEX(brstat.tlt.safe1,"ไม่มีความเสียหาย") = 0 THEN NEXT.
     END.
     ELSE IF cb_report = "มีความเสียหาย"   THEN DO:
         IF INDEX(brstat.tlt.safe1,"มีความเสียหาย") = 0 THEN NEXT.
         IF INDEX(brstat.tlt.safe1,"ไม่มีความเสียหาย") <> 0 THEN NEXT.
     END.
     ELSE IF cb_report = "ติดปัญหา"   THEN DO:
         IF INDEX(brstat.tlt.safe1,"ติดปัญหา") = 0 THEN NEXT.
     END.
     ELSE IF cb_report = "ส่งข้อมูลแล้ว"   THEN DO:
         IF TRIM(brstat.tlt.stat) <> "YES" THEN NEXT.
     END.
     ELSE IF cb_report = "ยังไม่ส่งข้อมูล"   THEN DO:
         IF TRIM(brstat.tlt.stat) <> "NO" THEN NEXT.
     END.

     IF      ra_status = 1 THEN DO: 
         IF brstat.tlt.releas <> "yes"  THEN NEXT.
     END.
     ELSE IF ra_status = 2 THEN DO: 
         IF brstat.tlt.releas <> "no"   THEN NEXT.
     END.
     ELSE IF ra_status = 3 THEN DO: 
         IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
     END.
     RUN pd_cleardata.
     RUN pd_data_insp.
     nv_count = nv_count + 1 .
     EXPORT DELIMITER "|"
         nv_count                                                     /*1   */ 
         trim(brstat.tlt.nor_usr_ins)                                /*2   */ 
         nv_camp                                                     /*3   */ 
         nv_campnam                                                  /*4   */ 
         nv_produc                                                   /*5   */ 
         nv_producnam                                                /*6   */ 
         nv_pacg                                                     /*7   */ 
         nv_pacgnam                                                  /*8   */ 
         trim(brstat.tlt.nor_noti_ins)                               /*9   */ 
         nv_titleth + nv_nameth                                      /*10  */
         nv_surth                                                    /*11  */   
         trim(brstat.tlt.ins_addr5)                                  /*12  */   
         trim(brstat.tlt.imp)                                        /*13  */   
         string(brstat.tlt.nor_effdat,"99/99/9999")                  /*14  */   
         trim(brstat.tlt.old_eng)                                    /*15  */   
         trim(brstat.tlt.ins_addr1)                                  /*16  */   
         nv_poltel                                                   /*17  */   
         nv_line                                                     /*18  */   
         nv_mail                                                     /*19  */   
         trim(brstat.tlt.ins_addr3)                                  /*20  */   
         trim(brstat.tlt.brand)                                      /*21  */   
         trim(brstat.tlt.model)                                      /*22  */   
         trim(brstat.tlt.expotim)                                    /*23  */   
         brstat.tlt.sentcnt                                          /*24  */   
         brstat.tlt.rencnt                                           /*25  */   
         brstat.tlt.cc_weight                                        /*26  */   
         trim(brstat.tlt.lince2)                                     /*27  */   
         trim(brstat.tlt.gentim)                                     /*28  */   
         trim(brstat.tlt.lince1)                                     /*29  */   
         trim(brstat.tlt.cha_no)                                     /*30  */   
         trim(brstat.tlt.eng_no)                                     /*31  */   
         string(brstat.tlt.gendat,"99/99/9999")                      /*32  */   
         string(brstat.tlt.expodat,"99/99/9999")                     /*33  */   
         string(deci(brstat.tlt.nor_coamt))                          /*34  */   
         string(deci(brstat.tlt.comp_coamt))                         /*35  */   
         nv_accr1                                                    /*36  */   
         nv_accdet1                                                   /*37  */  
         INT(nv_accpric1)                                            /*38  */   
         nv_accr2                                                    /*39  */   
         nv_accdet2                                                  /*40  */   
         int(nv_accpric2)                                            /*41  */   
         nv_accr3                                                    /*42  */   
         nv_accdet3                                                  /*43  */   
         int(nv_accpric3)                                            /*44  */   
         nv_accr4                                                    /*45  */   
         nv_accdet4                                                  /*46  */   
         int(nv_accpric4)                                            /*47  */   
         nv_accr5                                                    /*48  */   
         nv_accdet5                                                  /*49  */   
         int(nv_accpric5)                                            /*50  */   
         brstat.tlt.releas                                           /*51  */   
         nv_inspno                                                   /*52  */   
         nv_insresult                                                /*53  */   
         brstat.tlt.filler2                                          /*54  */   
         brstat.tlt.stat                                             /*55  */   
         brstat.tlt.entdat.                                          /*56*/     
                                                                     
 END.
 OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportnotify c-wins 
PROCEDURE pd_reportnotify :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_data AS CHAR FORMAT "x(50)" INIT "".

IF SUBSTR(fi_outfile,LENGTH(fi_outfile) - 3,4) <> ".csv" THEN 
   fi_outfile = TRIM(fi_outfile) + ".csv"  .

ASSIGN 
    nv_data = ""
    n_err   = "".

RUN proc_chkprepol.   /*--- Add By Tontawan S. A66-0006 22/05/2023 ---*/

OUTPUT TO VALUE(fi_outfile).
/*EXPORT DELIMITER "|" "Report SCBPT :" STRING(TODAY,"99/99/9999").---*/
EXPORT DELIMITER "|" 
    "ประเภทกรมธรรม์"
    "รหัสอ้างอิง"  
    "รหัสลูกค้า  "  
    "รหัสแคมเปญ "   
    "ชื่อแคมเปญ "   
    "รหัสผลิตภัณฑ์ "
    "ชื่อผลิตภัณฑ์ "
    "ชื่อแพคเก็จ"   
    "รหัสแพคเก็จ"   
    "กรมธรรม์เดิม " 
    "ประเภทผู้เอาประกัน" 
    "คำนำหน้าชื่อ ผู้เอาประกัน" 
    "ชื่อ ผู้เอาประกัน"         
    "คำนำหน้าชื่อ ผู้เอาประกัน (Eng) "
    "ชื่อ ผู้เอาประกัน (Eng)"
    "เลขบัตรผู้เอาประกัน "
    "วันเกิดผู้เอาประกัน" 
    "อาชีพผู้เอาประกัน"
    "เบอร์โทรผู้เอาประกัน"
    "อีเมล์ผู้เอาประกัน " 
    "ที่อยู่หน้าตาราง1"
    "ที่อยู่หน้าตาราง2"
    "ที่อยู่หน้าตาราง3"
    "ที่อยู่หน้าตาราง4"
    "ที่อยู่จัดส่ง 1"
    "ที่อยู่จัดส่ง 2"
    "ที่อยู่จัดส่ง 3"
    "ที่อยู่จัดส่ง 4"
    "ประเภทผู้จ่ายเงิน"
    "คำนำหน้าชื่อ ผู้จ่ายเงิน"
    "ชื่อ ผู้จ่ายเงิน"
    "เลขประจำตัวผู้เสียภาษี"
    "ที่อยู่ออกใบเสร็จ1"
    "ที่อยู่ออกใบเสร็จ2"
    "ที่อยู่ออกใบเสร็จ3"
    "ที่อยู่ออกใบเสร็จ4"
    "สาขา"
    "ผู้รับผลประโยชน์"  
    "รหัสประเภทการจ่าย "
    "ประเภทการจ่าย" 
    "รหัสช่องทางการจ่าย"
    "ช่องทางการจ่าย " 
    "ธนาคารที่จ่าย"
    "วันที่จ่าย"   
    "สถานะการจ่าย "
    "ยี่ห้อ " 
    "รุ่น "   
    "แบบตัวถัง"
    "ทะเบียน "
    "จังหวัดทะเบียน "
    "เลขตัวถัง"
    "เลขเครื่อง "
    "ปีรถ "   
    "ที่นั่ง "
    "ซีซี "   
    "น้ำหนัก "
    "คลาสรถ" 
    "การซ่อม "
    "สี"  
    "ประเภทการประกัน "
    "รหัสการประกัน"
    "วันที่คุ้มครอง"  
    "วันที่หมดอายุ"
    "ทุนประกัน"
    "เบี้ยสุทธิก่อนหักส่วนลด"
    "เบี้ยสุทธิหลังหักส่วนลด"
    "สแตมป์ " 
    "ภาษี"    
    "เบี้ยรวม"
    "Deduct"  
    "fleet"   
    "ncb"     
    "other"   
    "cctv"    
    "ระบุผู้ขับขี่ "   
    "ชื่อผู้ขับขี่1"   
    "เลขบัตร ปชช 1"
    "อาชีพผู้ขับขี่1"  
    "เพศผู้ขับขี่1"    
    "วันเกิดผู้ขับขี่1"
    "ชื่อผู้ขับขี่2"   
    "เลขบัตร ปชช 2"
    "อาชีพผู้ขับขี่2"  
    "เพศผู้ขับขี่2"    
    "วันเกิดผู้ขับขี่2"
    "อุปกรณ์ตกแต่ง1"   
    "รายละเอียดอุปกรณ์1"
    "ราคาอุปกรณ์1 " 
    "อุปกรณ์ตกแต่ง2"
    "รายละเอียดอุปกรณ์2"
    "ราคาอุปกรณ์2"  
    "อุปกรณ์ตกแต่ง3"
    "รายละเอียดอุปกรณ์3"
    "ราคาอุปกรณ์3"  
    "อุปกรณ์ตกแต่ง4"
    "รายละเอียดอุปกรณ์4"
    "ราคาอุปกรณ์4 " 
    "อุปกรณ์ตกแต่ง5"
    "รายละเอียดอุปกรณ์5"
    "ราคาอุปกรณ์5"  
    "วันที่ตรวจสภาพ"
    "วันที่อนุมัติผลการตรวจ"
    "เลขตรวจรถ" /*--- Add By Tontawan S 26/05/2023 A66-0006 -- เลข ISP --*/
    "ผลการตรวจสภาพ"
    "รายละเอียดการตรวจสภาพ"
    "วันที่ขาย"
    "วันที่รับชำระเงิน"
    "สถานะการจ่าย"
    "เลขที่ใบอนุญาตนายหน้า"
    "ชื่อนายหน้า" 
    "รหัสนายหน้า" 
    "ภาษา"        
    "การจัดส่งกรมธรรม์"   
    "รายละเอียดการจัดส่ง" 
    "ของแถม"
    "หมายเหตุ"
    "เลขตรวจสภาพ"
    "ผลการตรวจ"
    "ความเสียหาย1" 
    "ความเสียหาย2" 
    "ความเสียหาย3" 
    "ข้อมูลอื่นๆ" 
    /*--- Add By Tontawan S. A66-0006 25/01/2023 ---*/
    "รหัสเซล"      
    "ชื่อเซล"      
    "ช่องทางการขาย"   
    "รหัสสาขา"
    "แคมเปญ"
    "Per Person (BI)"
    "Per Accident"
    "Per Accident(PD)"
    "4.1 SI."
    "4.2 Sum"
    "4.3 Sum"
    /*--- Add By Tontawan S. A66-0006 25/01/2023 ---*/
    /*--- Add By Tontawan S. A68-0059 ---*/
    "คำนำหน้าชื่อ ผู้ขับขี่ 3"
    "ชื่อผู้ขับขี่3"   
    "นามสกุล ผู้ขับขี่ 3"
    "เลขบัตร ปชช 3"
    "อาชีพผู้ขับขี่3"  
    "เพศผู้ขับขี่3"    
    "วันเกิดผู้ขับขี่3"
    "คำนำหน้าชื่อ ผู้ขับขี่ 4"
    "ชื่อผู้ขับขี่4"   
    "นามสกุล ผู้ขับขี่ 4"  
    "เลขบัตร ปชช 4"
    "อาชีพผู้ขับขี่4"  
    "เพศผู้ขับขี่4"    
    "วันเกิดผู้ขับขี่4"
    "คำนำหน้าชื่อ ผู้ขับขี่ 5"
    "ชื่อผู้ขับขี่5"   
    "นามสกุล ผู้ขับขี่ 5" 
    "เลขบัตร ปชช 5"
    "อาชีพผู้ขับขี่5"  
    "เพศผู้ขับขี่5"    
    "วันเกิดผู้ขับขี่5"
    "เลขที่ใบขับขี่ ผู้ขับขี่ 1"                             
    "เลขที่ใบขับขี่ ผู้ขับขี่ 2"                             
    "เลขที่ใบขับขี่ ผู้ขับขี่ 3"                             
    "เลขที่ใบขับขี่ ผู้ขับขี่ 4"                             
    "เลขที่ใบขับขี่ ผู้ขับขี่ 5"                             
    "เลข serial ของแบตเตอรี่"                                
    "วันที่ของแบตเตอรี่"                                     
    "ทุนประกันภัยของแบตเตอรี่ที่ซื้อเพิ่ม"                   
    "เบี้ยประกันภัยสุทธิของแบตเตอรี่"                        
    "เบี้ยประกันภัยรวมของแบตเตอรี่"                        
    "เลข serial ของเครื่องชาร์จรถยนต์ไฟฟ้าแบบติดผนัง"        
    "ทุนประกันภัยของเครื่องชาร์จรถยนต์ไฟฟ้าแบบติดผนัง"       
    "เบี้ยประกันภัยสุทธิของเครื่องชาร์จรถยนต์ไฟฟ้าแบบติดผนัง"
    "เบี้ยประกันภัยรวมของเครื่องชาร์จรถยนต์ไฟฟ้าแบบติดผนัง"
    "New Trariff".
    /*--- Add By Tontawan S. A68-0059 ---*/

 nv_data = TRIM(fi_datare) .
 loop_tlt:
 FOR EACH brstat.tlt USE-INDEX tlt01 WHERE 
          brstat.tlt.trndat   >=  fi_trndatfr  AND 
          brstat.tlt.trndat   <=  fi_trndatto  AND 
          brstat.tlt.genusr    =  "SCBPT"      AND 
         (brstat.tlt.flag      =  "V70"        OR 
          brstat.tlt.flag      =  "V72")       NO-LOCK.

     IF cb_report = "ประเภทกรมธรรม์" THEN DO:
        IF brstat.tlt.flag <> nv_data THEN NEXT.
     END.

     IF cb_report = "รหัสแคมเปญ" THEN DO:
         IF INDEX(brstat.tlt.lotno,nv_data) = 0 THEN NEXT.
     END.

     IF cb_report = "ประเภทลูกค้า"   THEN DO:
         IF brstat.tlt.imp <> nv_data THEN NEXT.
     END.

     IF cb_report = "รหัสประเภทการชำระเบี้ย"   THEN DO:
         IF INDEX(brstat.tlt.safe2,"PaymentMD:" + nv_data) = 0 THEN NEXT.
     END.

     IF cb_report = "รหัสช่องทางการชำระเบี้ย"   THEN DO:
        IF INDEX(brstat.tlt.safe2,"PaymentTyCd:" + nv_data) = 0 THEN NEXT.
     END.

     IF cb_report = "วันที่ชำระเบี้ย"   THEN DO:
         IF INDEX(brstat.tlt.rec_addr4,"Paydat:" + nv_data) = 0 THEN NEXT.
     END.

     IF cb_report = "สถานะการชำระเบี้ย"   THEN DO:
         IF INDEX(brstat.tlt.rec_addr4,"PaySts:" + nv_data) = 0 THEN NEXT.
     END.
     IF cb_report = "วันที่ตรวจสภาพ"   THEN DO:
         IF DATE(brstat.tlt.nor_effdat) = DATE(nv_data) THEN NEXT.
     END.

     IF cb_report = "ผลการตรวจสภาพ"   THEN DO:
         IF INDEX(brstat.tlt.nor_noti_tlt,"InspSt:" + nv_data) = 0 THEN NEXT.
     END.

     IF ra_status = 1 THEN DO: 
         IF brstat.tlt.releas <> "yes" THEN NEXT.
     END.
     ELSE IF ra_status = 2 THEN DO: 
         IF brstat.tlt.releas <> "no"  THEN NEXT.
     END.
     ELSE IF ra_status = 3 THEN DO: 
         IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
     END.

     /*RUN pd_cleardata .*/
     RUN pd_data_noti .
     RUN pd_data_noti1.
     RUN pd_data_noti2.
     RUN pd_data_noti3.
     RUN pd_chkrenew.   /*-- Add By Tontawan S. A66-0006 22/05/2023 --*/
     RUN pd_createisp.  /*-- Add By Tontawan S. A66-0006 22/05/2023 --*/

     EXPORT DELIMITER "|"
         /*TRIM(brstat.tlt.flag) --- Comment By Tontawan S. A66-0006 22/05/2023 --*/
         IF n_err <> "" THEN n_err ELSE TRIM(brstat.tlt.flag) /*--- Ton 18/07/2023 --*/
         brstat.tlt.nor_noti_ins       /*-- brstat.tlt.agent --*/
         brstat.tlt.nor_noti_ins       /*-- brstat.tlt.agent --*/
         nv_produc                     
         nv_producnam  
         nv_camp                       
         nv_campnam                    
         nv_pacgnam                    
         nv_pacg                       
         nv_prepol
         TRIM(brstat.tlt.imp)          
         nv_titleth                    
         TRIM(nv_nameth + " " + nv_surth)
         nv_titleeng                   
         TRIM(nv_nameeng  + " " + nv_sureng) 
         nv_icno 
         STRING(DATE(nv_polbdate),"99/99/9999")
         nv_polocc                     
         nv_poltel                     
         nv_mail  
         TRIM(brstat.tlt.ins_addr1)  
         TRIM(brstat.tlt.ins_addr2)  
         ""  /*TRIM(brstat.tlt.ins_addr3) */  
         ""  /*TRIM(brstat.tlt.ins_addr4) */
         TRIM(brstat.tlt.ins_addr1)  
         TRIM(brstat.tlt.ins_addr2)  
         ""  /*TRIM(brstat.tlt.ins_addr3) */ 
         ""  /*TRIM(brstat.tlt.ins_addr4) */ 
         nv_paytyp                              /*27  */  
         nv_paynam                              /*28  */  
         nv_paysur                              /*29  */  
         TRIM(brstat.tlt.comp_sub)              /*30  */  
         TRIM(brstat.tlt.rec_addr1)             /*31  */  
         TRIM(brstat.tlt.rec_addr2) 
         ""
         "" 
         nv_branch                     
         TRIM(brstat.tlt.safe1)        
         nv_paymcod                    
         nv_paymtyp  
         nv_payway                     
         nv_waytyp                     
         TRIM(brstat.tlt.safe3)        
         STRING(DATE(nv_paydat),"99/99/9999")  
         nv_paysts  
         TRIM(brstat.tlt.brand)        
         TRIM(brstat.tlt.model)        
         TRIM(brstat.tlt.expousr)      
         TRIM(brstat.tlt.lince1)       
         nv_province                   
         TRIM(brstat.tlt.cha_no)       
         /*TRIM(brstat.tlt.eng_no) -- Comment By Tontawan S. --*/ 
         IF n_engno <> "" THEN n_engno ELSE TRIM(brstat.tlt.eng_no)     
         TRIM(brstat.tlt.gentim)       
         brstat.tlt.sentcnt            
         brstat.tlt.rencnt             
         brstat.tlt.cc_weight          
         TRIM(brstat.tlt.expotim)    
         //nv_garcod -- Comment By Tontawan S. 19/07/2023 --*/
         IF TRIM(brstat.tlt.flag) <> "V72" THEN nv_garcod ELSE "" /*-- Add Ton 19/07/2023 --*/
         TRIM(brstat.tlt.colorcod)     
         nv_covtyp                     
         nv_covcod  
         STRING(brstat.tlt.gendat,"99/99/9999")   
         STRING(brstat.tlt.expodat,"99/99/9999")  
         //STRING(DECI(brstat.tlt.nor_coamt))                 /*77  */  -- A68-0059
         IF TRIM(brstat.tlt.flag) <> "V70" THEN "" ELSE STRING(DECI(brstat.tlt.nor_coamt))
         STRING(DECI(brstat.tlt.nor_grprm))                   /*78  */  
         STRING(DECI(brstat.tlt.comp_grprm))                  /*79  */  
         STRING(DECI(nv_stamp))                               /*80  */  
         STRING(DECI(nv_vat))                                 /*81  */  
         brstat.tlt.comp_coamt                  
         STRING(DECI(brstat.tlt.endno)) 
         STRING(DECI(nv_feeltp))  
         STRING(DECI(nv_ncbp))                  /*86  */  
         STRING(DECI(nv_oth))                   /*90  */  
         STRING(DECI(nv_cctvp))                 /*92  */  
         brstat.tlt.endcnt 
         TRIM(nv_drinam1)  + " " + TRIM(nv_drisur1)                 
         TRIM(nv_driid1)                            
         IF TRIM(nv_driocc1)  = ? or TRIM(nv_driocc2)  = "" THEN "" ELSE TRIM(nv_driocc1)  
         IF TRIM(nv_drisex1)  = ? or TRIM(nv_drisex2)  = "" THEN "" ELSE TRIM(nv_drisex1)                           /*47  */  
         IF TRIM(nv_dridate1) = ? or TRIM(nv_dridate2) = "" THEN "" ELSE STRING(DATE(nv_dridate1),"99/99/9999")     /*48  */  
         TRIM(nv_drinam2)  + " " +   TRIM(nv_drisur2)                                                               
         TRIM(nv_driid2)                                                                                            
         IF TRIM(nv_driocc2)  = ? or TRIM(nv_driocc2)  = "" THEN "" ELSE TRIM(nv_driocc2)                           /*52  */  
         IF TRIM(nv_drisex2)  = ? or TRIM(nv_drisex2)  = "" THEN "" ELSE TRIM(nv_drisex2)                           /*53  */  
         IF TRIM(nv_dridate2) = ? or TRIM(nv_dridate2) = "" THEN "" ELSE STRING(DATE(nv_dridate2),"99/99/9999")     /*54  */  
         nv_accr1                               /*97  */  
         nv_accdet1                             /*98  */  
         INT(nv_accpric1)                       /*99  */  
         nv_accr2                               /*100 */  
         nv_accdet2                             /*101 */  
         INT(nv_accpric2)                       /*102 */  
         nv_accr3                               /*103 */  
         nv_accdet3                             /*104 */  
         INT(nv_accpric3)                       /*105 */  
         nv_accr4                               /*106 */  
         nv_accdet4                             /*107 */  
         INT(nv_accpric4)                       /*108 */  
         nv_accr5                               /*109 */  
         nv_accdet5                             /*110 */  
         INT(nv_accpric5)       
       IF brstat.tlt.nor_effdat  <> ? THEN STRING(brstat.tlt.nor_effdat,"99/99/9999")  ELSE ""               /*112 */  
       IF brstat.tlt.comp_effdat <> ? THEN STRING(brstat.tlt.comp_effdat,"99/99/9999") ELSE ""               /*113 */  
       nv_docno                                 /* เลขตรวจรถ -- Add By Tontawan S. A66-0006 26/05/2023 */
       nv_inspres                                     /*114 */                                               
       nv_inspdet                                     /*115 */                                               
       IF tlt.datesent     <> ? THEN STRING(brstat.tlt.datesent,"99/99/9999")          ELSE ""               /*116 */  
       IF tlt.dat_ins_noti <> ? THEN STRING(brstat.tlt.dat_ins_noti,"99/99/9999")      ELSE ""               /*117 */  
       nv_paidsts                             /*118 */  
       nv_brolincen                           /*119 */  
       nv_bronam                              /*120 */  
       nv_brocod                              /*121 */  
       nv_lang                                /*122 */  
       nv_polsend                             /*123 */  
       nv_remarksend                          /*124 */  
       nv_gIFt                                /*125 */  
       brstat.tlt.nor_noti_ins                /*126 */  
       brstat.tlt.nor_usr_ins                 /*127 */  
       nv_remark                              /*128 */
       /*--- Add By Tontawan S. A66-0006 25/01/2023 ---*/  
       ""   
       ""
       ""
       ""
       brstat.tlt.agent                                /* Agent Code รหัสเซล */ 
       brstat.tlt.note1                                /* ชื่อ เซล */
       brstat.tlt.note3                                /* Selling Channel */
       nv_br                                           /* Branch Code : User Manual Load File */
       ""                                              /* Campaign : User Manual Load File */
       IF n_person <> "" THEN n_person ELSE "0.00"     /* Per Person (BI) */  
       IF n_peracc <> "" THEN n_peracc ELSE "0.00"     /* Per Accident */     
       IF n_pd     <> "" THEN n_pd     ELSE "0.00"     /* Per Accident(PD) */ 
       IF n_si411  <> "" THEN n_si411  ELSE "0.00"     /* 4.1 SI. */          
       IF n_si412  <> "" THEN n_si412  ELSE "0.00"     /* 4.2 Sum */          
       IF n_si43   <> "" THEN n_si43   ELSE "0.00"     /* 4.3 Sum */          
       /*--- Add By Tontawan S. A66-0006 25/01/2023 ---*/  
       /*--- Add By Tontawan S. A68-0059 ---*/
       n_drv3_salutation_M 
       n_drv3_fname
       n_drv3_lname
       n_drv3_nid                                                            
       n_drv3_occupation                                                     
       n_drv3_gender                                                         
       IF TRIM(n_drv3_birthdate) = ? OR TRIM(n_drv3_birthdate) = "" THEN "" ELSE STRING(DATE(n_drv3_birthdate),"99/99/9999")
       n_drv4_salutation_M
       n_drv4_fname
       n_drv4_lname 
       n_drv4_nid                                                    
       n_drv4_occupation                                             
       n_drv4_gender                                                 
       IF TRIM(n_drv4_birthdate) = ? OR TRIM(n_drv4_birthdate) = "" THEN "" ELSE STRING(DATE(n_drv4_birthdate),"99/99/9999")                                          
       n_drv5_salutation_M
       n_drv5_fname
       n_drv5_lname 
       n_drv5_nid                                                    
       n_drv5_occupation                                                     
       n_drv5_gender                                                         
       IF TRIM(n_drv5_birthdate) = ? OR TRIM(n_drv5_birthdate) = "" THEN "" ELSE STRING(DATE(n_drv5_birthdate),"99/99/9999")
       n_drv1_dlicense
       n_drv2_dlicense
       n_drv3_dlicense
       n_drv4_dlicense
       n_drv5_dlicense
       n_baty_snumber 
       n_batydate     
       IF n_baty_rsi         <> "" THEN n_baty_rsi         ELSE "0.00"  
       IF n_baty_npremium    <> "" THEN n_baty_npremium    ELSE "0.00"
       IF n_baty_gpremium    <> "" THEN n_baty_gpremium    ELSE "0.00"
       IF n_wcharge_snumber  <> "" THEN n_wcharge_snumber  ELSE "0.00"
       IF n_wcharge_si       <> "" THEN n_wcharge_si       ELSE "0.00"
       IF n_wcharge_npremium <> "" THEN n_wcharge_npremium ELSE "0.00"
       IF n_wcharge_gpremium <> "" THEN n_wcharge_gpremium ELSE "0.00"
       n_newtrariff.
       /*--- End By Tontawan S. A68-0059 ---*/
END.                                                                   
OUTPUT CLOSE.     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportnotify_old c-wins 
PROCEDURE pd_reportnotify_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_data AS CHAR FORMAT "x(50)" INIT "".

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN nv_data =  "".

OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Report SCBPT :" string(TODAY,"99/99/9999")   .
EXPORT DELIMITER "|" 
   " ประเภทกรมธรรม์      "
   " เบอร์กรมธรรม์       "
   " รหัสบริษัทประกันภัย "                  /*1   */                                   
   " ชื่อบริษัทประกันภัย "                  /*2   */ 
   " รหัสแคมเปญ          "                  /*3   */ 
   " ชื่อแคมเปญ          "                  /*4   */ 
   " รหัสผลิตภัณฑ์       "                  /*5   */ 
   " ชื่อผลิตภัณฑ์       "                  /*6   */ 
   " ชื่อแพคเกจ          "                  /*7   */ 
   " รหัสแพคเกจ          "                  /*8   */ 
   " ประเภทผู้ถือกรมธรรม์"                  /*9   */ 
   " คำนำหน้าชื่อ        "                  /*10  */ 
   " ชื่อผู้เอาประกัน    "                  /*11  */ 
   " นามสกุลผู้เอาประกัน "                  /*12  */ 
   " คำนำหน้าชื่อ ภาษาอังกฤษ "              /*13  */ 
   " ชื่อภาษา อังกฤษ     "                  /*14  */ 
   " นามสกุลภาษา อังกฤษ  "                  /*15  */ 
   " เลขที่บัตรประชาชนผู้เอาประกัน"         /*16  */ 
   " เพศ                 "                  /*17  */ 
   " วันเดือนปีเกิด      "                  /*18  */ 
   " อาชีพ               "                  /*19  */ 
   " โทรศัพท์            "                  /*20  */ 
   " email               "                  /*21  */ 
   " Line_ID             "                  /*22  */ 
   " ที่อยู่ผู้ถือกรมธรรม์   "              /*23  */ 
   " ที่อยู่ผู้ถือกรมธรรม์   "              /*24  */ 
   " ที่อยู่ในการจัดส่งเอกสาร"              /*25  */ 
   " ที่อยู่ในการจัดส่งเอกสาร"              /*26  */ 
   " ประเภทผู้จ่ายเงิน   "                  /*27  */ 
   " ชื่อผู้จ่ายเงิน     "                  /*28  */ 
   " นามสกุลผู้จ่ายเงิน  "                  /*29  */ 
   " เลขที่บัตรประชาชน   "                  /*30  */ 
   " ที่อยู่ ผู้ชำระเงิน "                  /*31  */ 
   " ที่อยู่ผู้ชำระเงิน  "                  /*32  */ 
   " สาขา                "                  /*33  */ 
   " ชื่อผู้รับผลประโยชน์"                  /*34  */  
   " รหัสประเภทการชำระเบี้ยประกัน "         /*35  */ 
   " ประเภทการชำระเบี้ยประกัน     "         /*36  */ 
   " รหัสช่องทางที่ชำระเบี้ย      "          /*37  */
   " ช่องทางที่ชำระค่าเบี้ย       "         /*38  */ 
   " ธนาคารที่ชำระเบี้ย  "                  /*39  */ 
   " วันที่ชำระค่าเบี้ย  "                  /*40  */ 
   " สถานะการชำระเบี้ย   "                  /*41  */ 
   " การระบุชื่อผู้ขับ   "                  /*42  */ 
   " ชื่อผู้ขับขี่ 1     "                  /*43  */ 
   " นามสกุล ผู้ขับขี่ 1 "                  /*44  */ 
   " เลขที่บัตรประชาชนผู้ขับขี่1"           /*45  */ 
   " Driver1Occupation   "                  /*46  */ 
   " เพศ ผู้ขับขี่ 1     "                  /*47  */ 
   " วันเดือนปีเกิดผู้ขับขี่1"              /*48  */ 
   " ชื่อผู้ขับขี่ 2     "                  /*49  */ 
   " นามสกุล ผู้ขับขี่ 2 "                  /*50  */ 
   " เลขที่บัตรประชาชนผู้ขับขี่2"           /*51  */ 
   " Driver2Occupation   "                  /*52  */ 
   " เพศ ผู้ขับขี่ 2         "              /*53  */ 
   " วันเดือนปีเกิดผู้ขับขี่2"              /*54  */ 
   " ชื่อรถยนต์          "                  /*55  */ 
   " ชื่อรุ่นรถยนต์      "                  /*56  */ 
   " แบบตัวถัง           "                  /*57  */ 
   " ทะเบียนรถ           "                  /*58  */ 
   " จังหวัดที่จดทะเบียน "                  /*59  */ 
   " เลขตัวถัง           "                  /*60  */ 
   " เลขเครื่องยนต์      "                  /*61  */ 
   " ปีจดทะเบียนรถ       "                  /*62  */ 
   " จำนวนที่นั่ง        "                  /*63  */ 
   " ขนาดเครื่องยนต์     "                  /*64  */ 
   " น้ำหนัก             "                  /*65  */ 
   " รหัสการใช้รถยนต์    "                  /*66  */ 
   " รหัสการซ่อม         "                  /*67  */ 
   " ประเภทการซ่อม       "                  /*68  */ 
   " สีรถยนต์            "                  /*69  */ 
   " ประเภทของประกันภัย  "                  /*70  */ 
   " รหัสประเภทของประกันภัย   "             /*71  */ 
   " ประเภทของความคุ้มครอง    "             /*72  */ 
   " ประเภทย่อยของความคุ้มครอง"             /*73  */ 
   " รายละเอียดประเภทย่อยของความคุ้มครอง "  /*74  */ 
   " วันเริ่มความคุ้มครอง     "             /*75  */ 
   " วันที่สิ้นสุดความคุ้มครอง"             /*76  */ 
   " ทุนประกัน                "             /*77  */ 
   " เบี้ยประกันก่อนหักส่วนลด "             /*78  */ 
   " เบี้ยสุทธิหลังหักส่วนลด  "             /*79  */ 
   " จำนวนอากรสแตมป์          "             /*80  */ 
   " จำนวนภาษี SBT/Vat        "             /*81  */ 
   " เบี้ยรวม ภาษี-อากร       "             /*82  */ 
   " ค่าความเสียหายส่วนแรก    "             /*83  */ 
   " % ส่วนลดกลุ่ม            "             /*84  */ 
   " จำนวนส่วนลดกลุ่ม         "             /*85  */ 
   " % ส่วนลดประวัติดี        "             /*86  */ 
   " จำนวนส่วนลดประวัติดี     "             /*87  */ 
   " % ส่วนลดกรณีระบุชื่อผู้ขับขี่   "      /*88  */ 
   " จำนวนส่วนลดกรณีระบุชื่อผู้ขับขี่"      /*89  */ 
   " %สวนลดอื่นๆ              "             /*90  */ 
   " จำนวนส่วนลดอื่นๆ         "             /*91  */ 
   " %สวนลดกล้อง              "             /*92  */ 
   " จำนวนส่วนลดกล้อง         "             /*93  */ 
   " %ส่วนลดเพิ่ม             "             /*94  */ 
   " จำนวนส่วนลดเพิ่ม         "             /*95  */ 
   " รายละเอียดส่วนเพิ่ม      "             /*96  */ 
   " รหัส อุปกรณ์ เพิ่มเติม 1 "             /*97  */ 
   " รายละเอียดเพิ่มเติม 1    "             /*98  */ 
   " ราคาอุปกรณ์ เพิ่มเติม 1 "              /*99  */ 
   " รหัส อุปกรณ์ เพิ่มเติม 2 "             /*100 */ 
   " รายละเอียดเพิ่มเติม 2    "             /*101 */ 
   " ราคาอุปกรณ์ เพิ่มเติม 2 "              /*102 */ 
   " รหัส อุปกรณ์ เพิ่มเติม 3 "             /*103 */ 
   " รายละเอียดเพิ่มเติม 3    "             /*104 */ 
   " ราคาอุปกรณ์ เพิ่มเติม 3 "              /*105 */ 
   " รหัส อุปกรณ์ เพิ่มเติม 4 "             /*106 */ 
   " รายละเอียดเพิ่มเติม 4    "             /*107 */ 
   " ราคาอุปกรณ์ เพิ่มเติม 4 "              /*108 */ 
   " รหัส อุปกรณ์ เพิ่มเติม 5 "             /*109 */ 
   " รายละเอียดเพิ่มเติม 5    "             /*110 */ 
   " ราคาอุปกรณ์ เพิ่มเติม 5 "              /*111 */ 
   " วันที่ตรวจสภาพรถ     "                 /*112 */ 
   " วันที่อนุมัติผลการตรวจสภาพรถ"          /*113 */ 
   " ผลการตรวจสภาพรถ      "                 /*114 */ 
   " รายละเอียดการตรวจสภาพรถ "              /*115 */ 
   " วันที่ขาย            "                 /*116 */ 
   " วันที่รับชำระเงิน    "                 /*117 */ 
   " สถานะการจ่ายเงิน     "                 /*118 */ 
   " เลขที่ใบอนุญาตนายหน้า(SCBPT)"          /*119 */ 
   " ชื่อบริษัทนายหน้า (SCBPT) "            /*120 */ 
   " รหัสโบรคเกอร์        "                 /*121 */ 
   " ภาษาในการออกกรมธรรม์ "                 /*122 */ 
   " ช่องทางการจัดส่ง     "                 /*123 */ 
   " หมายเหตุการจัดส่ง    "                 /*124 */ 
   " ของแถม               "                 /*125 */ 
   " เลขที่อ้างอิง ความคุ้มครอง  "          /*126 */ 
   " Cust.Code No  "                        /*127 */ 
   " หมายเหตุ  "                            /*128 */ 
   " Producer "                             /*129 */ 
   " Agent "   .                             /*130 */ 

 nv_data = TRIM(fi_datare) .
 loop_tlt:
 For each brstat.tlt Use-index  tlt01 Where
          brstat.tlt.trndat   >=  fi_trndatfr   And
          brstat.tlt.trndat   <=  fi_trndatto   And
          brstat.tlt.genusr    =  "SCBPT"       AND 
         (brstat.tlt.flag      =  "V70"         OR 
          brstat.tlt.flag      =  "V72")        no-lock.

     IF cb_report = "ประเภทกรมธรรม์" THEN DO:
        IF brstat.tlt.flag <> nv_data THEN NEXT.
     END.
     IF cb_report = "รหัสแคมเปญ" THEN DO:
         IF INDEX(brstat.tlt.lotno,nv_data) = 0 THEN NEXT.
     END.
     IF cb_report = "ประเภทลูกค้า"   THEN DO:
         IF brstat.tlt.imp <> nv_data THEN NEXT.
     END.
     IF cb_report = "รหัสประเภทการชำระเบี้ย"   THEN DO:
         IF INDEX(brstat.tlt.safe2,"PaymentMD:" + nv_data) = 0 THEN NEXT.
     END.
     IF cb_report = "รหัสช่องทางการชำระเบี้ย"   THEN DO:
        IF INDEX(brstat.tlt.safe2,"PaymentTyCd:" + nv_data) = 0 THEN NEXT.
     END.
     IF cb_report = "วันที่ชำระเบี้ย"   THEN DO:
         IF INDEX(brstat.tlt.rec_addr4,"Paydat:" + nv_data) = 0 THEN NEXT.
     END.
     IF cb_report = "สถานะการชำระเบี้ย"   THEN DO:
         IF INDEX(brstat.tlt.rec_addr4,"PaySts:" + nv_data) = 0 THEN NEXT.
     END.
     IF cb_report = "วันที่ตรวจสภาพ"   THEN DO:
         IF DATE(brstat.tlt.nor_effdat) = DATE(nv_data) THEN NEXT.
     END.
     IF cb_report = "ผลการตรวจสภาพ"   THEN DO:
         IF INDEX(brstat.tlt.nor_noti_tlt,"InspSt:" + nv_data) = 0 THEN NEXT.
     END.

     IF      ra_status = 1 THEN DO: 
         IF brstat.tlt.releas <> "yes"  THEN NEXT.
     END.
     ELSE IF ra_status = 2 THEN DO: 
         IF brstat.tlt.releas <> "no"   THEN NEXT.
     END.
     ELSE IF ra_status = 3 THEN DO: 
         IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
     END.

     RUN pd_cleardata .
     RUN pd_data_noti .
     RUN pd_data_noti1.
     RUN pd_data_noti2.
     RUN pd_data_noti3.
     
     EXPORT DELIMITER "|" 
         trim(brstat.tlt.flag)
         TRIM(brstat.tlt.policy)
         nv_comcod                              /*1   */  
         nv_comnam                              /*2   */  
         nv_camp                                /*3   */  
         nv_campnam                             /*4   */  
         nv_produc                              /*5   */  
         nv_producnam                           /*6   */  
         nv_pacgnam                             /*7   */  
         nv_pacg                                /*8   */  
         trim(brstat.tlt.imp)                   /*9   */  
         nv_titleth                             /*10  */  
         nv_nameth                              /*11  */  
         nv_surth                               /*12  */  
         nv_titleeng                            /*13  */  
         nv_nameeng                             /*14  */  
         nv_sureng                              /*15  */  
         nv_icno                                /*16  */  
         nv_sex                                 /*17  */  
         STRING(DATE(nv_polbdate),"99/99/9999") /*18  */  
         nv_polocc                              /*19  */  
         nv_poltel                              /*20  */  
         nv_mail                                /*21  */  
         nv_line                                /*22  */  
         trim(brstat.tlt.ins_addr1)             /*23  */  
         trim(brstat.tlt.ins_addr2)             /*24  */  
         trim(brstat.tlt.ins_addr3)             /*25  */  
         trim(brstat.tlt.ins_addr4)             /*26  */  
         nv_paytyp                              /*27  */  
         nv_paynam                              /*28  */  
         nv_paysur                              /*29  */  
         trim(brstat.tlt.comp_sub)              /*30  */  
         trim(brstat.tlt.rec_addr1)             /*31  */  
         trim(brstat.tlt.rec_addr2)             /*32  */  
         nv_branch                              /*33  */  
         trim(brstat.tlt.safe1)                 /*34  */  
         nv_paymcod                             /*35  */  
         nv_paymtyp                             /*36  */  
         nv_payway                               /*37  */ 
         nv_waytyp                              /*38  */  
         TRIM(brstat.tlt.safe3)                 /*39  */  
         STRING(DATE(nv_paydat),"99/99/9999")   /*40  */  
         nv_paysts                              /*41  */  
         brstat.tlt.endcnt                      /*42  */  
         trim(nv_drinam1)                            /*43  */  
         trim(nv_drisur1)                            /*44  */  
         trim(nv_driid1)                            /*45  */  
         if trim(nv_driocc1)  = ? or trim(nv_driocc2)  = "" then "" else trim(nv_driocc1)                           /*46  */  
         if trim(nv_drisex1)  = ? or trim(nv_drisex2)  = "" then "" else trim(nv_drisex1)                           /*47  */  
         if trim(nv_dridate1) = ? or trim(nv_dridate2) = "" then "" else STRING(DATE(nv_dridate1),"99/99/9999")     /*48  */  
         trim(nv_drinam2)                            /*49  */                              
         trim(nv_drisur2)                            /*50  */                              
         trim(nv_driid2)                            /*51  */                               
         if trim(nv_driocc2)  = ? or trim(nv_driocc2)  = "" then "" else trim(nv_driocc2)                            /*52  */  
         if trim(nv_drisex2)  = ? or trim(nv_drisex2)  = "" then "" else trim(nv_drisex2)                            /*53  */  
         if trim(nv_dridate2) = ? or trim(nv_dridate2) = "" then "" else STRING(DATE(nv_dridate2),"99/99/9999")      /*54  */  
         trim(brstat.tlt.brand)                 /*55  */  
         trim(brstat.tlt.model)                 /*56  */  
         trim(brstat.tlt.expousr)               /*57  */  
         trim(brstat.tlt.lince1)                /*58  */  
         nv_province                            /*59  */  
         trim(brstat.tlt.cha_no)                /*60  */  
         trim(brstat.tlt.eng_no)                /*61  */  
         trim(brstat.tlt.gentim)                /*62  */  
         brstat.tlt.sentcnt                     /*63  */  
         brstat.tlt.rencnt                      /*64  */  
         brstat.tlt.cc_weight                   /*65  */  
         trim(brstat.tlt.expotim)               /*66  */  
         nv_garcod                              /*67  */  
         nv_garage                              /*68  */  
         TRIM(brstat.tlt.colorcod)              /*69  */  
         nv_covtyp                              /*70  */  
         nv_covcod                              /*71  */  
         nv_cover                               /*72  */  
         nv_subcover                            /*73  */  
         nv_covdetail                           /*74  */  
         string(brstat.tlt.gendat,"99/99/9999")                      /*75  */  
         string(brstat.tlt.expodat,"99/99/9999")                     /*76  */  
         string(deci(brstat.tlt.nor_coamt))                   /*77  */  
         string(deci(brstat.tlt.nor_grprm))                   /*78  */  
         string(deci(brstat.tlt.comp_grprm))                  /*79  */  
         string(deci(nv_stamp))                               /*80  */  
         string(deci(nv_vat))                                 /*81  */  
         brstat.tlt.comp_coamt                  /*82  */  
         string(deci(brstat.tlt.endno))         /*83  */  
         string(deci(nv_feeltp))                /*84  */  
         string(deci(nv_feelt))                 /*85  */  
         string(deci(nv_ncbp))                  /*86  */  
         string(deci(nv_ncb))                   /*87  */  
         string(deci(nv_drip))                  /*88  */  
         string(deci(nv_dridis))                /*89  */  
         string(deci(nv_oth))                   /*90  */  
         string(deci(nv_othdis))                /*91  */  
         string(deci(nv_cctvp))                 /*92  */  
         string(deci(nv_cctv))                  /*93  */ 
         string(deci(nv_disc))                  /*94  */  
         string(deci(nv_discp))                 /*95  */  
         nv_discdetail                          /*96  */  
         nv_accr1                               /*97  */  
         nv_accdet1                             /*98  */  
         INT(nv_accpric1)                       /*99  */  
         nv_accr2                               /*100 */  
         nv_accdet2                             /*101 */  
         int(nv_accpric2)                       /*102 */  
         nv_accr3                               /*103 */  
         nv_accdet3                             /*104 */  
         int(nv_accpric3)                       /*105 */  
         nv_accr4                               /*106 */  
         nv_accdet4                             /*107 */  
         int(nv_accpric4)                       /*108 */  
         nv_accr5                               /*109 */  
         nv_accdet5                             /*110 */  
         int(nv_accpric5)                            /*111 */  
         IF brstat.tlt.nor_effdat  <> ? THEN string(brstat.tlt.nor_effdat,"99/99/9999")  else ""                /*112 */  
         IF brstat.tlt.comp_effdat <> ? THEN string(brstat.tlt.comp_effdat,"99/99/9999") else ""                /*113 */  
         nv_inspres                                     /*114 */  
         nv_inspdet                                     /*115 */  
         IF tlt.datesent     <> ? THEN String(brstat.tlt.datesent,"99/99/9999")          ELSE ""                 /*116 */  
         IF tlt.dat_ins_noti <> ? THEN String(brstat.tlt.dat_ins_noti,"99/99/9999")      ELSE ""               /*117 */  
         nv_paidsts                             /*118 */  
         nv_brolincen                           /*119 */  
         nv_bronam                              /*120 */  
         nv_brocod                              /*121 */  
         nv_lang                                /*122 */  
         nv_polsend                             /*123 */  
         nv_remarksend                          /*124 */  
         nv_gift                                /*125 */  
         brstat.tlt.nor_noti_ins                /*126 */  
         brstat.tlt.nor_usr_ins                 /*127 */  
         nv_remark                              /*128 */  
         brstat.tlt.subins                      /*129 */  
         brstat.tlt.recac .                      /*130 */ 
 END.
                                             
OUTPUT   CLOSE.                            
                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassis c-wins 
PROCEDURE proc_chassis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew       AS CHAR.
DEFINE VAR nv_len          AS INTE INIT 0.
DEFINE VAR nv_uwm301trareg AS CHAR INIT "" FORMAT "x(30)".

ASSIGN nv_uwm301trareg = trim(nv_cha_no) .     
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
    ASSIGN nv_cha_no =   trim(nv_uwm301trareg). 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkprepol c-wins 
PROCEDURE proc_chkprepol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add By Tontawan S. A66-0006 22/05/2023      
------------------------------------------------------------------------------*/
FOR EACH brstat.tlt USE-INDEX tlt01         WHERE 
         brstat.tlt.trndat >=  fi_trndatfr  AND 
         brstat.tlt.trndat <=  fi_trndatto  AND 
         brstat.tlt.genusr  =  "SCBPT"      AND 
        (brstat.tlt.flag    =  "V70"        OR 
         brstat.tlt.flag    =  "V72")       NO-LOCK.

    IF TRIM(brstat.tlt.flag) = "V70" THEN DO:
        FIND LAST sicuw.uwm301 USE-INDEX uwm30121       WHERE 
                sicuw.uwm301.cha_no = TRIM(nv_cha_no)   AND 
                sicuw.uwm301.tariff = "X" NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL sicuw.uwm301 THEN DO:
            ASSIGN nv_prepol = sicuw.uwm301.policy.
       END.
       ELSE ASSIGN nv_prepol = "" .
    END.
    ELSE DO:
       FIND LAST sicuw.uwm301 USE-INDEX uwm30121        WHERE 
                 sicuw.uwm301.cha_no = TRIM(nv_cha_no)  AND 
                 sicuw.uwm301.tariff = "9" NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL  sicuw.uwm301 THEN DO:
            ASSIGN nv_prepol = sicuw.uwm301.policy.        
       END.
       ELSE ASSIGN nv_prepol = "" .
    END.
END.



IF nv_prepol <> "" THEN DO:
    /*--- Connect sic_Exp ---*/
    IF NOT CONNECTED("sic_exp") THEN DO:
        loop_sic:
        REPEAT:
            number_sic = number_sic + 1 .
            RUN proc_sic_exp2.
            IF CONNECTED("sic_exp") THEN LEAVE loop_sic.
            ELSE IF number_sic > 3 THEN DO:
                MESSAGE "User not connect system Expiry !!! >>>" number_sic  VIEW-AS ALERT-BOX.
                LEAVE loop_sic.
            END.
        END.
    END.
END.
              
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
FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
        brstat.insure.compno = "999" AND 
        brstat.insure.FName  = trim(brstat.tlt.lince2) NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN   
        ASSIGN nv_province = Insure.LName.
    ELSE 
        ASSIGN nv_province = trim(brstat.tlt.lince2).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 c-wins 
PROCEDURE proc_sic_exp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add By Tontawan S. A66-0006 22/05/2023      
------------------------------------------------------------------------------*/
FORM
    gv_id  LABEL " User Id " COLON 35 SKIP
    nv_pwd LABEL " Password" COLON 35 BLANK
    WITH FRAME nf1 CENTERED ROW 10 SIDE-LABELS OVERLAY WIDTH 80
    TITLE " Connect DB Expiry System.".
STATUS INPUT OFF.

gv_prgid = "GWNEXP03".
REPEAT:
    PAUSE 0.
    STATUS DEFAULT "F4=EXIT".
    ASSIGN 
        gv_id  = ""
        n_user = "".

    UPDATE gv_id nv_pwd GO-ON(F1 F4) WITH FRAME nf1
    EDITING:
        READKEY.
        IF FRAME-FIELD = "gv_id" AND LASTKEY = KEYCODE("ENTER") OR LASTKEY = KEYCODE("F1") THEN DO:
            IF INPUT gv_id = "" THEN DO:
                MESSAGE "User ID. Is not blank!!".
                NEXT-PROMPT gv_id WITH FRAME nf1.
                NEXT. 
            END.
            gv_id = INPUT gv_id.

        END.
        IF FRAME-FIELD = "n_pwd" AND LASTKEY = KEYCODE("ENTER") OR LASTKEY = KEYCODE ("F1") THEN DO:
            nv_pwd = INPUT nv_pwd.
        END.
        APPLY LASTKEY.

    END.
    ASSIGN
        n_user = gv_id.

    IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
        CONNECT expiry   -H tmsth   -S expiry   -ld sic_exp   -N tcp   -U VALUE(gv_id)   -P VALUE(nv_pwd) NO-ERROR. /*------- Production --*/
        //CONNECT expiry   -ld sic_exp   -H 10.35.176.37   -S 9060   -N TCP   -U VALUE(gv_id)   -P VALUE(nv_pwd) NO-ERROR.   // A68-0059 27/03/2025 - UAT --*/
         
        CLEAR FRAME nf1.
        HIDE  FRAME nf1.
        RETURN.
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
/*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*/
Open Query br_tlt 
    For each tlt Use-index  tlt01 Where
        tlt.trndat  >=  fi_trndatfr  And
        tlt.trndat  <=  fi_trndatto  And
        /*tlt.policy >=  fi_polfr      And
        tlt.policy <=  fi_polto     And*/
        /*  tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "SCBPT"      no-lock.
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
OPEN QUERY br_tlt 
    /*For each tlt Use-index  tlt01 Where
                             tlt.trndat  >=  fi_trndatfr  And
                             tlt.trndat  <=  fi_trndatto  And
                             /*tlt.policy >=  fi_polfr      And
                             tlt.policy <=  fi_polto     And*/
                           /*  tlt.comp_sub  =  fi_producer  And*/
                             recid(tlt) = nv_rectlt        AND 
                             tlt.genusr   =  "SCBPT"      no-lock.*/
    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt).   /*A57-0017*/
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

