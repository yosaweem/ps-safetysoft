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
  wgwqkls0.w :  Query & Update flag detail K-LEASING
 create  by  : Kridtiyai . A66-0108 Add data to table tlt  */ 
/*Modify by  : Kridtiya i. A66-0142 ปรับการแสดง เลขกรมธรรม์ ในรายงานให้ได้กรมล่าสุด */
/*+++++++++++++++++++++++++++++++++++++++++++++++*/
DEFINE VAR  nv_rectlt    as recid  init  0.
DEFINE VAR  nv_recidtlt  as recid  init  0.
DEFINE VAR  n_asdat      AS CHAR.
DEFINE VAR  n_asdat1     AS CHAR.  
DEFINE VAR  vAcProc_fil  AS CHAR.
DEFINE VAR  vAcProc_fil1 AS CHAR.  
DEFINE VAR  nv_filemat   AS CHAR FORMAT "x(60)".
DEFINE temp-table wdetail NO-UNDO
    FIELD branch        AS CHAR FORMAT "x(5)"  /*สาขา              ML*/
    FIELD appno         AS CHAR FORMAT "x(30)" 
    FIELD notifyno      AS CHAR FORMAT "x(30)" 
    FIELD stkno         AS CHAR FORMAT "x(20)" 
    FIELD prepol        AS CHAR FORMAT "x(20)" /*เลขที่กรมธรรม์เดิม */     
    FIELD cover         AS CHAR FORMAT "x(10)" /*ประเภทความคุ้มครอง */          
    FIELD typepol       AS CHAR FORMAT "x(20)" /*ประเภทที่แจ้งงาน          NEW*/
    FIELD n_title       AS CHAR FORMAT "x(50)" /*คำนำหน้าชื่อผู้เอาประกันภัย    */
    FIELD n_names       AS CHAR FORMAT "x(150)" /*ชื่อผู้เอาประกันภัย            */
    FIELD cardef        AS CHAR FORMAT "x(30)" /*ชื่อบริษัทรถประจำตำแหน่ง       */
    FIELD occoup        AS CHAR FORMAT "x(30)" /*Occup./อาชีพ         */ 
    FIELD n_icno        AS CHAR FORMAT "x(20)" /*ID/บัตรประชาชน            1940100152490*/
    FIELD n_address1    AS CHAR FORMAT "x(100)" /*ที่อยู่1          37/324 เคซี3 ซอย11 ถนนหทัยราษฎร์*/
    FIELD n_address2    AS CHAR FORMAT "x(100)" /*ที่อยู่2          แขวงสามวาตะวันตก*/
    FIELD n_address3    AS CHAR FORMAT "x(100)" /*ที่อยู่3          เขตคลองสามวา    */
    FIELD n_address4    AS CHAR FORMAT "x(100)" /*ที่อยู่4         กรุงเทพฯ 10510  */
    FIELD mobile        AS CHAR FORMAT "x(30)" /*เบอร์โทรศัพท์  */ 
    FIELD reciepname    AS CHAR FORMAT "x(100)" /*ชื่อที่ออกใบกำกับภาษี  */ 
    FIELD reciepaddress AS CHAR FORMAT "x(100)" /*ที่อยู่ออกใบกำกับภาษี  */ 
    FIELD dri_name1     AS CHAR FORMAT "x(150)" /*ชื่อ/นามสกุล1 */            
    FIELD dri_brith1    AS CHAR FORMAT "x(20)" /*วัน/เดือน/ปีเกิด 1  */   
    FIELD dri_age1      AS CHAR FORMAT "x(10)" /*อายุ1 */               
    FIELD dri_icno1     AS CHAR FORMAT "x(20)" /*เลขที่บัตรประชาชน 1 */ 
    FIELD dri_licen1    AS CHAR FORMAT "x(20)" /*เลขที่ใบขับขี่1       */    
    FIELD dri_name2     AS CHAR FORMAT "x(150)" /* ชื่อ/นามสกุล 2 */           
    FIELD dri_brith2    AS CHAR FORMAT "x(20)" /* วัน/เดือน/ปีเกิด2 */ 
    FIELD dri_age2      AS CHAR FORMAT "x(10)" /*อายุ2   */                
    FIELD dri_icno2     AS CHAR FORMAT "x(20)" /* เลขที่บัตรประชาชน 2 */ 
    FIELD dri_licen2    AS CHAR FORMAT "x(20)" /* เลขที่ใบขับขี่2 */ 
    FIELD comdat        AS CHAR FORMAT "x(20)" 
    FIELD expodat       AS CHAR FORMAT "x(20)" /*วันที่สิ้นสุด   */   
    FIELD brand         AS CHAR FORMAT "x(50)" /*ยี่ห้อ              */   
    FIELD model         AS CHAR FORMAT "x(150)" /*รุ่น            */
    FIELD caryear       AS CHAR FORMAT "x(10)" /*ปีที่จดทะเบียน  */ 
    FIELD n_vehreg      AS CHAR FORMAT "x(50)" /*ทะเบียนรถ           */  
    FIELD cha_no        AS CHAR FORMAT "x(50)" /*เลขตัวถัง           */
    FIELD eng_no        AS CHAR FORMAT "x(50)" /*เลขเครื่องยนต์  */   
    FIELD ccno          AS CHAR FORMAT "x(20)" /*ขนาดเครื่องยนต์ */   
    FIELD tons          AS CHAR FORMAT "x(20)" /*น้ำหนัก             */
    FIELD n_seat        AS CHAR FORMAT "x(20)" /*จำนวนที่นั่ง    */
    FIELD sumins        AS CHAR FORMAT "x(20)" /*ทุนประกัน         */
    FIELD premnet       AS CHAR FORMAT "x(20)" /*เบี้ยสุทธิ      */
    FIELD premtotle     AS CHAR FORMAT "x(20)" /*เบี้ยรวมภาษีอากร*/
    FIELD compnet       AS CHAR FORMAT "x(20)" /*เบี้ยพรบ            */
    FIELD comptotle     AS CHAR FORMAT "x(20)" /*เบี้ยรวมพรบ     */  
    FIELD garage        AS CHAR FORMAT "x(30)" /*ซ่อม(0:อู่ห้าง 1:อู่ในเครือ)*/  
    FIELD accoryno      AS CHAR FORMAT "x(10)" /*อุปกรณ์เสริม     */ 
    FIELD accodes       AS CHAR FORMAT "x(250)" /*รายละเอียดอุปกรณ์เสริม */  
    FIELD remark        AS CHAR FORMAT "x(250)" /*หมายเหตุ */
    FIELD agentid       AS CHAR FORMAT "x(50)" /*รหัสตัวแทน*/     
    FIELD vehuse        AS CHAR FORMAT "x(20)" /*ลักษณะการใช้งาน */    
    FIELD poltyp        AS CHAR FORMAT "x(10)" /*Pol_Type 70/72/74 */  
    FIELD nv_ppbi       AS CHAR FORMAT "x(20)" /*Per Person (BI)  */
    FIELD nv_pacc       AS CHAR FORMAT "x(20)" /*Per Accident        */
    FIELD nv_papd       AS CHAR FORMAT "x(20)" /*Per Accident(PD) */
    FIELD nv_41         AS CHAR FORMAT "x(20)" /*4.1 SI.         */
    FIELD nv_42         AS CHAR FORMAT "x(20)" /*4.2 Sum         */
    FIELD nv_43         AS CHAR FORMAT "x(20)" /*4.3 Sum         */
    FIELD vatcode       AS CHAR FORMAT "x(20)" /*VATCODE         */
    FIELD ispno         AS CHAR FORMAT "x(20)" /*ISP_NO          */
    FIELD campaign      AS CHAR FORMAT "x(20)" /*Campaign        */
    FIELD benefic       AS CHAR FORMAT "x(150)" /*Beneficiary           */      
    FIELD nv_Producer   AS CHAR FORMAT "x(20)" /*Producer        */
    FIELD nv_Agent      AS CHAR FORMAT "x(20)" /*Agent               */
    FIELD payment       AS CHAR FORMAT "x(20)" /*Payment         */
    FIELD tracking      AS CHAR FORMAT "x(150)" /*Tracking          */
    FIELD promotion     AS CHAR FORMAT "x(50)" /*Promotion        */
    FIELD colorcode     AS CHAR FORMAT "x(100)" .

DEF VAR  nv_ppbi     as char init "".   /*Per Person (BI)  */   
DEF VAR  nv_pacc     as char init "".   /*Per Accident        */
DEF VAR  nv_papd     as char init "".   /*Per Accident(PD) */   
DEF VAR  nv_41       as char init "".   /*4.1 SI.         */    
DEF VAR  nv_42       as char init "".   /*4.2 Sum         */    
DEF VAR  nv_43       as char init "".   /*4.3 Sum         */ 
DEF VAR  nv_Producer as char init "". 
DEF VAR  nv_Agent    as char init "". 
DEF VAR  nv_branch        AS CHAR FORMAT "x(5)"  .  /*สาขา              ML*/
DEF VAR  nv_appno         AS CHAR FORMAT "x(30)" .  
DEF VAR  nv_notifyno      AS CHAR FORMAT "x(30)" .  
DEF VAR  nv_stkno         AS CHAR FORMAT "x(20)" .  
DEF VAR  nv_prepol        AS CHAR FORMAT "x(20)" .  /*เลขที่กรมธรรม์เดิม */     
DEF VAR  nv_cover         AS CHAR FORMAT "x(10)" .  /*ประเภทความคุ้มครอง */          
DEF VAR  nv_typepol       AS CHAR FORMAT "x(20)" .  /*ประเภทที่แจ้งงาน          NEW*/
DEF VAR  nv_n_title       AS CHAR FORMAT "x(50)" .  /*คำนำหน้าชื่อผู้เอาประกันภัย    */
DEF VAR  nv_n_names       AS CHAR FORMAT "x(150)".   /*ชื่อผู้เอาประกันภัย            */
DEF VAR  nv_cardef        AS CHAR FORMAT "x(30)" .  /*ชื่อบริษัทรถประจำตำแหน่ง       */
DEF VAR  nv_occoup        AS CHAR FORMAT "x(30)" .  /*Occup./อาชีพ         */ 
DEF VAR  nv_n_icno        AS CHAR FORMAT "x(20)" .  /*ID/บัตรประชาชน            1940100152490*/
DEF VAR  nv_n_address1    AS CHAR FORMAT "x(100)".   /*ที่อยู่1          37/324 เคซี3 ซอย11 ถนนหทัยราษฎร์*/
DEF VAR  nv_n_address2    AS CHAR FORMAT "x(100)".   /*ที่อยู่2          แขวงสามวาตะวันตก*/
DEF VAR  nv_n_address3    AS CHAR FORMAT "x(100)".   /*ที่อยู่3          เขตคลองสามวา    */
DEF VAR  nv_n_address4    AS CHAR FORMAT "x(100)".   /*ที่อยู่4         กรุงเทพฯ 10510  */
DEF VAR  nv_mobile        AS CHAR FORMAT "x(30)" .  /*เบอร์โทรศัพท์  */ 
DEF VAR  nv_reciepname    AS CHAR FORMAT "x(100)".   /*ชื่อที่ออกใบกำกับภาษี  */ 
DEF VAR  nv_reciepaddress AS CHAR FORMAT "x(100)".   /*ที่อยู่ออกใบกำกับภาษี  */ 
DEF VAR  nv_dri_name1     AS CHAR FORMAT "x(150)".   /*ชื่อ/นามสกุล1 */            
DEF VAR  nv_dri_brith1    AS CHAR FORMAT "x(20)" .  /*วัน/เดือน/ปีเกิด 1  */   
DEF VAR  nv_dri_age1      AS CHAR FORMAT "x(10)" .  /*อายุ1 */               
DEF VAR  nv_dri_icno1     AS CHAR FORMAT "x(20)" .  /*เลขที่บัตรประชาชน 1 */ 
DEF VAR  nv_dri_licen1    AS CHAR FORMAT "x(20)" .  /*เลขที่ใบขับขี่1       */    
DEF VAR  nv_dri_name2     AS CHAR FORMAT "x(150)".   /* ชื่อ/นามสกุล 2 */           
DEF VAR  nv_dri_brith2    AS CHAR FORMAT "x(20)" .  /* วัน/เดือน/ปีเกิด2 */ 
DEF VAR  nv_dri_age2      AS CHAR FORMAT "x(10)" .  /*อายุ2   */                
DEF VAR  nv_dri_icno2     AS CHAR FORMAT "x(20)" .  /* เลขที่บัตรประชาชน 2 */ 
DEF VAR  nv_dri_licen2    AS CHAR FORMAT "x(20)" .  /* เลขที่ใบขับขี่2 */ 
DEF VAR  nv_comdat        AS CHAR FORMAT "x(20)" .  
DEF VAR  nv_expodat       AS CHAR FORMAT "x(20)" .  /*วันที่สิ้นสุด   */   
DEF VAR  nv_brand         AS CHAR FORMAT "x(50)" .  /*ยี่ห้อ              */   
DEF VAR  nv_model         AS CHAR FORMAT "x(150)".   /*รุ่น            */
DEF VAR  nv_caryear       AS CHAR FORMAT "x(10)" .  /*ปีที่จดทะเบียน  */ 
DEF VAR  nv_n_vehreg      AS CHAR FORMAT "x(50)" .  /*ทะเบียนรถ           */  
DEF VAR  nv_cha_no        AS CHAR FORMAT "x(50)" .  /*เลขตัวถัง           */
DEF VAR  nv_eng_no        AS CHAR FORMAT "x(50)" .  /*เลขเครื่องยนต์  */   
DEF VAR  nv_ccno          AS CHAR FORMAT "x(20)" .  /*ขนาดเครื่องยนต์ */   
DEF VAR  nv_tons          AS CHAR FORMAT "x(20)" .  /*น้ำหนัก             */
DEF VAR  nv_n_seat        AS CHAR FORMAT "x(20)" .  /*จำนวนที่นั่ง    */
DEF VAR  nv_sumins        AS CHAR FORMAT "x(20)" .  /*ทุนประกัน         */
DEF VAR  nv_premnet       AS CHAR FORMAT "x(20)" .  /*เบี้ยสุทธิ      */
DEF VAR  nv_premtotle     AS CHAR FORMAT "x(20)" .  /*เบี้ยรวมภาษีอากร*/
DEF VAR  nv_compnet       AS CHAR FORMAT "x(20)" .  /*เบี้ยพรบ            */
DEF VAR  nv_comptotle     AS CHAR FORMAT "x(20)" .  /*เบี้ยรวมพรบ     */  
DEF VAR  nv_garage        AS CHAR FORMAT "x(30)" .  /*ซ่อม(0:อู่ห้าง 1:อู่ในเครือ)*/  
DEF VAR  nv_accoryno      AS CHAR FORMAT "x(10)" .  /*อุปกรณ์เสริม     */ 
DEF VAR  nv_accodes       AS CHAR FORMAT "x(250)".   /*รายละเอียดอุปกรณ์เสริม */  
DEF VAR  nv_remark        AS CHAR FORMAT "x(250)".   /*หมายเหตุ */
DEF VAR  nv_agentid       AS CHAR FORMAT "x(50)" .  /*รหัสตัวแทน*/     
DEF VAR  nv_vehuse        AS CHAR FORMAT "x(20)" .  /*ลักษณะการใช้งาน */    
DEF VAR  nv_poltyp        AS CHAR FORMAT "x(10)" .  /*Pol_Type 70/72/74 */  
DEF VAR  nv_vatcode       AS CHAR FORMAT "x(20)" .  /*VATCODE         */
DEF VAR  nv_ispno         AS CHAR FORMAT "x(20)" .  /*ISP_NO          */
DEF VAR  nv_campaign      AS CHAR FORMAT "x(20)" .  /*Campaign        */
DEF VAR  nv_benefic       AS CHAR FORMAT "x(150)".   /*Beneficiary           */      
DEF VAR  nv_payment       AS CHAR FORMAT "x(20)" .  /*Payment         */
DEF VAR  nv_tracking      AS CHAR FORMAT "x(150)".   /*Tracking          */
DEF VAR  nv_promotion     AS CHAR FORMAT "x(50)" .  /*Promotion        */
DEF VAR  nv_colorcode     AS CHAR FORMAT "x(100)" .
DEF VAR n_title         AS CHAR.
DEF VAR n_names         AS CHAR.
DEF VAR n_address       AS CHAR.
DEF VAR n_vehreg        AS CHAR.
DEF VAR n_vehregprovin  AS CHAR.
DEF VAR n_seat          AS INTE.
DEF VAR n_tombon        AS CHAR FORMAT "x(100)" .
DEF VAR n_amper         AS CHAR FORMAT "x(100)" .
DEF VAR n_provin        AS CHAR FORMAT "x(100)" .
DEF VAR n_branch        AS CHAR INIT "".
DEF VAR nv_prepol72     AS CHAR FORMAT "x(20)" .
DEF VAR n_branch72      AS CHAR INIT "".
DEF VAR n_chkexpdat     AS DATE INIT ?.

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
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.flag tlt.releas tlt.nor_noti_tlt ~
tlt.lotno tlt.safe2 tlt.gendat tlt.expodat tlt.ins_name tlt.ins_icno ~
tlt.pack tlt.packnme tlt.brand tlt.model tlt.cha_no tlt.eng_no tlt.lince1 ~
tlt.lince2 tlt.lince3 tlt.vehuse tlt.note1 tlt.cc_weight tlt.note2 ~
tlt.nor_coamt tlt.note5 tlt.note6 tlt.note7 tlt.note8 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_typpolicy bu_exit ra_status fi_trndatfr ~
fi_trndatto bu_ok cb_search bu_oksch br_tlt fi_search bu_update cb_report ~
fi_br fi_outfile bu_report bu_upyesno RECT-332 RECT-338 RECT-339 RECT-340 ~
RECT-341 RECT-381 RECT-342 RECT-387 
&Scoped-Define DISPLAYED-OBJECTS ra_typpolicy ra_status fi_trndatfr ~
fi_trndatto cb_search fi_search fi_name cb_report fi_br fi_outfile 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 5 BY .95
     FONT 6.

DEFINE BUTTON bu_report 
     LABEL "REPORT FILE" 
     SIZE 15.5 BY .95.

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
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "ชื่อผู้เอาประกัน" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 75 BY .95
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
     SIZE 31 BY 1
     BGCOLOR 10 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_typpolicy AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "New", 1,
"Renew", 2,
"All", 3
     SIZE 23 BY 1
     BGCOLOR 3 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 8.48
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 58.5 BY 2.91
     BGCOLOR 21 .

DEFINE RECTANGLE RECT-339
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 71 BY 2.91
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.5 BY 1.67
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 14 BY 1.43
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-342
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12 BY 1.43
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.5 BY 1.52
     BGCOLOR 2 FGCOLOR 2 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17.67 BY 1.52
     BGCOLOR 21 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.flag COLUMN-LABEL "N/R" FORMAT "x":U
      tlt.releas COLUMN-LABEL "YES/NO" FORMAT "x(20)":U WIDTH 11
      tlt.nor_noti_tlt COLUMN-LABEL "เลขรับแจ้ง" FORMAT "x(25)":U
      tlt.lotno COLUMN-LABEL "APPLICATION_ID" FORMAT "x(20)":U
      tlt.safe2 COLUMN-LABEL "CONTRACT" FORMAT "x(20)":U
      tlt.gendat COLUMN-LABEL "EFFECTIVE_DATE" FORMAT "99/99/9999":U
      tlt.expodat COLUMN-LABEL "EXPIRED_DATE" FORMAT "99/99/99":U
      tlt.ins_name COLUMN-LABEL "CUSTOMER_NAME" FORMAT "x(60)":U
      tlt.ins_icno COLUMN-LABEL "Icno." FORMAT "x(20)":U
      tlt.pack COLUMN-LABEL "GARAGE" FORMAT "x(20)":U
      tlt.packnme COLUMN-LABEL "TYPE_INSURANCE" FORMAT "x(20)":U
      tlt.brand COLUMN-LABEL "Brand" FORMAT "x(20)":U
      tlt.model FORMAT "x(25)":U
      tlt.cha_no FORMAT "x(20)":U
      tlt.eng_no FORMAT "x(20)":U
      tlt.lince1 FORMAT "x(2)":U
      tlt.lince2 FORMAT "x(5)":U
      tlt.lince3 FORMAT "x(2)":U
      tlt.vehuse FORMAT "x(5)":U
      tlt.note1 COLUMN-LABEL "SEAT" FORMAT "x(10)":U
      tlt.cc_weight FORMAT ">>,>>9":U
      tlt.note2 COLUMN-LABEL "WEIGHT" FORMAT "x(20)":U
      tlt.nor_coamt COLUMN-LABEL "SUMINSURED" FORMAT "->,>>>,>>>,>>9.99":U
      tlt.note5 COLUMN-LABEL "NET_PREMIUM" FORMAT "x(20)":U
      tlt.note6 COLUMN-LABEL "STAMP" FORMAT "x(20)":U
      tlt.note7 COLUMN-LABEL "VAT" FORMAT "x(20)":U
      tlt.note8 COLUMN-LABEL "TOTAL_PREMIUM" FORMAT "x(20)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 15
         BGCOLOR 15 FGCOLOR 1 FONT 1 ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_typpolicy AT ROW 7.19 COL 91.33 NO-LABEL WIDGET-ID 6
     bu_exit AT ROW 1.57 COL 106.67
     ra_status AT ROW 6.05 COL 91.17 NO-LABEL
     fi_trndatfr AT ROW 1.67 COL 25.33 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 1.67 COL 61.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.57 COL 94.17
     cb_search AT ROW 3.19 COL 16.83 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 4.52 COL 53.33
     br_tlt AT ROW 9.81 COL 1.33
     fi_search AT ROW 4.43 COL 3.67 NO-LABEL
     fi_name AT ROW 4.43 COL 61 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 4.48 COL 102.83
     cb_report AT ROW 6.1 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_br AT ROW 6.1 COL 67.33 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 8.33 COL 27.5 NO-LABEL
     bu_report AT ROW 8.1 COL 115.83
     bu_upyesno AT ROW 4.48 COL 118
     "CLICK FOR UPDATE DATA FLAG CANCEL":40 VIEW-AS TEXT
          SIZE 41.5 BY .95 AT ROW 3.19 COL 63.33
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "REPORT BY :" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 6.14 COL 3.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " STATUS FLAG :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 6.05 COL 73.17
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "BRANCH :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 6.1 COL 58.67
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 1.67 COL 55
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " OUTPUT FILE NAME :" VIEW-AS TEXT
          SIZE 23.33 BY .95 AT ROW 8.33 COL 3.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "วันที่ไฟล์แจ้งงาน  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.67 COL 4.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "SEARCH BY :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 3.19 COL 4.33
          BGCOLOR 21 FGCOLOR 0 FONT 6
     RECT-332 AT ROW 1.1 COL 1.33
     RECT-338 AT ROW 2.95 COL 2.5
     RECT-339 AT ROW 2.95 COL 61.83
     RECT-340 AT ROW 1.24 COL 2.33
     RECT-341 AT ROW 1.33 COL 104.83
     RECT-381 AT ROW 4.24 COL 52.17
     RECT-342 AT ROW 1.33 COL 92.67
     RECT-387 AT ROW 7.86 COL 115 WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 24
         BGCOLOR 1 .


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
         TITLE              = "Query && Update [K-Leasing]"
         HEIGHT             = 24
         WIDTH              = 133.17
         MAX-HEIGHT         = 48.43
         MAX-WIDTH          = 320
         VIRTUAL-HEIGHT     = 48.43
         VIRTUAL-WIDTH      = 320
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
     _FldNameList[1]   > brstat.tlt.flag
"tlt.flag" "N/R" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.releas
"tlt.releas" "YES/NO" "x(20)" "character" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "เลขรับแจ้ง" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.lotno
"tlt.lotno" "APPLICATION_ID" "x(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.safe2
"tlt.safe2" "CONTRACT" "x(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.gendat
"tlt.gendat" "EFFECTIVE_DATE" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.expodat
"tlt.expodat" "EXPIRED_DATE" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.ins_name
"tlt.ins_name" "CUSTOMER_NAME" "x(60)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.ins_icno
"tlt.ins_icno" "Icno." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.pack
"tlt.pack" "GARAGE" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.packnme
"tlt.packnme" "TYPE_INSURANCE" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.brand
"tlt.brand" "Brand" "x(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   = brstat.tlt.model
     _FldNameList[14]   = brstat.tlt.cha_no
     _FldNameList[15]   = brstat.tlt.eng_no
     _FldNameList[16]   = brstat.tlt.lince1
     _FldNameList[17]   = brstat.tlt.lince2
     _FldNameList[18]   = brstat.tlt.lince3
     _FldNameList[19]   = brstat.tlt.vehuse
     _FldNameList[20]   > brstat.tlt.note1
"tlt.note1" "SEAT" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   = brstat.tlt.cc_weight
     _FldNameList[22]   > brstat.tlt.note2
"tlt.note2" "WEIGHT" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[23]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "SUMINSURED" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[24]   > brstat.tlt.note5
"tlt.note5" "NET_PREMIUM" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[25]   > brstat.tlt.note6
"tlt.note6" "STAMP" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[26]   > brstat.tlt.note7
"tlt.note7" "VAT" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[27]   > brstat.tlt.note8
"tlt.note8" "TOTAL_PREMIUM" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [K-Leasing] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [K-Leasing] */
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
            Run  wgw\WGWQKLS1(Input  nv_recidtlt).
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
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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
        tlt.trndat  <=   fi_trndatto   AND  
        tlt.genusr   =  "K-LEASING"        no-lock.  
            nv_rectlt =  recid(tlt).    
            Apply "Entry"  to br_tlt.
            Return no-apply.  
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
            tlt.genusr   =  "K-LEASING"            And
            index(tlt.ins_name,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "เลขที่รับแจ้ง"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "K-LEASING"      And
            index(tlt.nor_noti_tlt,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "เลขที่สัญญา"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "K-LEASING"      And
            index(tlt.safe2,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "กรมธรรม์ใหม่"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "K-LEASING"      And
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
            tlt.genusr    =  "K-LEASING"      And
            index(brstat.tlt.filler1,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ป้ายแดง"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "K-LEASING"      And
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
            tlt.genusr    =  "K-LEASING"      And
            tlt.flag      =  "R"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    /* create by a62-0454*/ 
    ELSE If  cb_search  =  "พรบ."  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "K-LEASING"      And
            tlt.flag      =  "COMP"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    /* end a62-0454*/
    ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "K-LEASING"       And
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
            tlt.genusr   =  "K-LEASING"        And
            INDEX(tlt.releas,"yes") <> 0   no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Confirm_no"  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat >=  fi_trndatfr      And
            tlt.trndat <=  fi_trndatto      And
            tlt.genusr   =  "K-LEASING"         And
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
            tlt.genusr   =  "K-LEASING"        And
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
            tlt.genusr   =  "K-LEASING"        And
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
ON CHOOSE OF bu_report IN FRAME fr_main /* REPORT FILE */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE DO:
        FOR EACH wdetail.
            DELETE wdetail.
        END.
        RUN pd_createdata.
        IF      ra_typpolicy = 1 THEN RUN pd_reportfiel.    /* New*/
        ELSE IF ra_typpolicy = 2 THEN RUN pd_reportfielre.  /* Re-New*/
        ELSE RUN pd_reportfielall.  /* All */ 
        
       /*  nv_message = "Export File Data Policy   " . */

        /*MESSAGE nv_message VIEW-AS ALERT-BOX QUESTION 
        BUTTON YES-NO TITLE "Match file Load " UPDATE Ichoice AS LOGICAL.
        CASE Ichoice:
            WHEN TRUE THEN  DO: /* Yes */ 
                 RUN pd_reportfiel. /* v70 */
            END.    
            WHEN FALSE THEN  DO:    /* No */  
                APPLY "Entry" TO fi_outfile .     
                RETURN NO-APPLY.   
            END.
        END CASE. */

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


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
    DEF VAR  nv_sort   as  int  init 0.
    ASSIGN
        fi_search     =  Input  fi_search.
     
    Disp fi_search  with frame fr_main.
    If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01  Where                                     
            tlt.trndat  >=  fi_trndatfr         And                                            
            tlt.trndat  <=  fi_trndatto         And  
            tlt.genusr   =  "K-LEASING"             And
            index(tlt.ins_name,fi_search) <> 0  no-lock.      
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
     ELSE If  cb_search  =  "เลขที่รับแจ้ง"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "K-LEASING"      And
            index(tlt.nor_noti_tlt,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "เลขที่สัญญา"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "K-LEASING"      And
            index(tlt.safe2,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "กรมธรรม์ใหม่"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "K-LEASING"      And
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
            tlt.genusr    =  "K-LEASING"      And
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
            tlt.genusr    =  "K-LEASING"      And
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
            tlt.genusr    =  "K-LEASING"                And 
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
            tlt.genusr   =  "K-LEASING"                 And 
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
            tlt.genusr   =  "K-LEASING"                 And 
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
            tlt.genusr   =  "K-LEASING"                 And 
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
            tlt.genusr   =  "K-LEASING"        And
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
            tlt.genusr   =  "K-LEASING"        And
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


&Scoped-define SELF-NAME ra_typpolicy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typpolicy c-wins
ON VALUE-CHANGED OF ra_typpolicy IN FRAME fr_main
DO:
  ra_typpolicy = INPUT ra_typpolicy.

  DISP ra_typpolicy WITH FRAM fr_main.
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
  gv_prgid = "wgwqkls0".
  gv_prog  = "Query & Update  Detail  (K-LEASING) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  SESSION:DATA-ENTRY-RETURN = YES.


  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  RECT-381:Move-to-top().

  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
      
      vAcProc_fil = vAcProc_fil   + "ชื่อลูกค้า"   + "," 
                                  + "กรมธรรม์ใหม่" + "," 
                                  + "เลขที่รับแจ้ง" + "," 
                                  + "เลขที่สัญญา" + "," 
                                  + "กรมธรรม์เก่า" + "," 
                                  + "ป้ายแดง" + ","
                                  + "ต่ออายุ" + "," 
                                  + "พรบ." + ","   /*A62-0454*/
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
                                  + "สาขา" + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + "," 
                                  + "Status_cancel"  + ","
                                  + "Confirm แล้ว"  + ","
                                  + "ยังไม่ Confirm"  + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1)
      ra_status = 4  
      fi_outfile = "D:\Report_K-LEASING" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".csv" .
  ra_typpolicy = 1.
   
  Disp fi_trndatfr  fi_trndatto cb_search cb_report ra_status fi_outfile ra_typpolicy
         with frame fr_main.

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/


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
  DISPLAY ra_typpolicy ra_status fi_trndatfr fi_trndatto cb_search fi_search 
          fi_name cb_report fi_br fi_outfile 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE ra_typpolicy bu_exit ra_status fi_trndatfr fi_trndatto bu_ok cb_search 
         bu_oksch br_tlt fi_search bu_update cb_report fi_br fi_outfile 
         bu_report bu_upyesno RECT-332 RECT-338 RECT-339 RECT-340 RECT-341 
         RECT-381 RECT-342 RECT-387 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_assign01 c-wins 
PROCEDURE pd_assign01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
CREATE wdetail.
ASSIGN 
 wdetail.branch        = nv_branch          
 wdetail.appno         = nv_appno           
 wdetail.notifyno      = nv_notifyno        
 wdetail.stkno         = IF nv_poltyp = "V70" THEN "" ELSE nv_stkno           
 wdetail.prepol        = nv_prepol          
 wdetail.cover         = nv_cover           
 wdetail.typepol       = nv_typepol         
 wdetail.n_title       = nv_n_title           
 wdetail.n_names       = nv_n_names           
 wdetail.cardef        = nv_cardef            
 wdetail.occoup        = nv_occoup            
 wdetail.n_icno        = nv_n_icno            
 wdetail.n_address1    = nv_n_address1        
 wdetail.n_address2    = nv_n_address2        
 wdetail.n_address3    = nv_n_address3        
 wdetail.n_address4    = nv_n_address4        
 wdetail.mobile        = nv_mobile            
 wdetail.reciepname    = nv_reciepname     
 wdetail.reciepaddress = nv_reciepaddress  
 wdetail.dri_name1     = nv_dri_name1      
 wdetail.dri_brith1    = nv_dri_brith1     
 wdetail.dri_age1      = nv_dri_age1       
 wdetail.dri_icno1     = nv_dri_icno1      
 wdetail.dri_licen1    = nv_dri_licen1     
 wdetail.dri_name2     = nv_dri_name2      
 wdetail.dri_brith2    = nv_dri_brith2     
 wdetail.dri_age2      = nv_dri_age2        
 wdetail.dri_icno2     = nv_dri_icno2      
 wdetail.dri_licen2    = nv_dri_licen2     
 wdetail.comdat        = nv_comdat         
 wdetail.expodat       = nv_expodat        
 wdetail.brand         = nv_brand          
 wdetail.model         = nv_model          
 wdetail.caryear       = nv_caryear        
 wdetail.n_vehreg      = nv_n_vehreg           
 wdetail.cha_no        = nv_cha_no       
 wdetail.eng_no        = nv_eng_no       
 wdetail.ccno          = nv_ccno         
 wdetail.tons          = nv_tons         
 wdetail.n_seat        = nv_n_seat       
 wdetail.sumins        = nv_sumins          
 wdetail.premnet       = nv_premnet         
 wdetail.premtotle     = nv_premtotle       
 wdetail.compnet       = nv_compnet         
 wdetail.comptotle     = nv_comptotle       
 wdetail.garage        = nv_garage          
 wdetail.accoryno      = nv_accoryno        
 wdetail.accodes       = nv_accodes         
 wdetail.remark        = nv_remark          
 wdetail.agentid       = nv_agentid         
 wdetail.vehuse        = nv_vehuse          
 wdetail.poltyp        = nv_poltyp          
 wdetail.nv_ppbi       = nv_ppbi              
 wdetail.nv_pacc       = nv_pacc              
 wdetail.nv_papd       = nv_papd              
 wdetail.nv_41         = nv_41             
 wdetail.nv_42         = nv_42             
 wdetail.nv_43         = nv_43         
 wdetail.vatcode       = nv_vatcode    
 wdetail.ispno         = nv_ispno      
 /*wdetail.campaign      = nv_campaign */  
 wdetail.benefic       = IF index(nv_benefic,"ไม่ติด8.3")  <>  0 OR 
                            index(nv_benefic,"ไม่ติด 8.3") <>  0 THEN "" ELSE nv_benefic  
 wdetail.nv_Producer   = nv_Producer   
 wdetail.nv_Agent      = nv_Agent      
 wdetail.payment       = nv_payment    
 wdetail.tracking      = nv_tracking   
 wdetail.promotion     = nv_promotion  
 wdetail.colorcode     = nv_colorcode  .
 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_clearinit c-wins 
PROCEDURE pd_clearinit :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_ppbi     = ""
    nv_pacc           = ""
    nv_papd           = ""
    nv_41             = ""
    nv_42             = ""
    nv_43             = ""
    nv_Producer       = ""
    nv_Agent          = ""
    nv_branch         = ""
    nv_appno          = ""
    nv_notifyno       = ""
    nv_stkno          = ""
    nv_prepol         = ""
    nv_cover          = ""
    nv_typepol        = ""
    nv_n_title        = ""
    nv_n_names        = ""
    nv_cardef         = ""
    nv_occoup         = ""
    nv_n_icno         = ""
    nv_n_address1     = ""
    nv_n_address2     = ""
    nv_n_address3     = ""
    nv_n_address4     = ""
    nv_mobile         = ""
    nv_reciepname     = ""
    nv_reciepaddress  = ""
    nv_dri_name1      = ""
    nv_dri_brith1     = ""
    nv_dri_age1       = ""
    nv_dri_icno1      = ""
    nv_dri_licen1     = ""
    nv_dri_name2      = ""
    nv_dri_brith2     = ""
    nv_dri_age2       = ""
    nv_dri_icno2      = ""
    nv_dri_licen2     = ""
    nv_comdat         = ""
    nv_expodat        = ""
    nv_brand          = ""
    nv_model          = ""
    nv_caryear        = ""
    nv_n_vehreg       = ""
    nv_cha_no         = ""
    nv_eng_no      = "" 
    nv_ccno        = "" 
    nv_tons        = "" 
    nv_n_seat      = "" 
    nv_sumins      = "" 
    nv_premnet     = "" 
    nv_premtotle   = "" 
    nv_compnet     = "" 
    nv_comptotle   = "" 
    nv_garage      = "" 
    nv_accoryno    = "" 
    nv_accodes     = "" 
    nv_remark      = "" 
    nv_agentid     = "" 
    nv_vehuse      = "" 
    nv_poltyp      = "" 
    nv_vatcode     = "" 
    nv_ispno       = "" 
    nv_campaign    = "" 
    nv_benefic     = "" 
    nv_payment     = "" 
    nv_tracking    = "" 
    nv_promotion   = "" 
    nv_colorcode   = "" 
    n_title        = "" 
    n_names        = "" 
    n_address      = "" 
    n_vehreg       = "" 
    n_vehregprovin = "" 
    n_seat         = 0
    n_tombon  = ""
    n_amper   = ""
    n_provin  = "" 
    nv_prepol72 = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_createdata c-wins 
PROCEDURE pd_createdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each tlt Use-index  tlt01 Where
  tlt.trndat   >=  fi_trndatfr   And
  tlt.trndat   <=  fi_trndatto   And
  tlt.genusr    =  "K-LEASING"    no-lock. 
  RUN pd_clearinit.
  ASSIGN n_title   = "" 
      n_address = "" 
      n_branch   = "" 
      n_branch72 = "" .  /*A66-0142*/
  IF INDEX(tlt.ins_name," ") <> 0 THEN ASSIGN n_title = trim(SUBSTR(tlt.ins_name,1,INDEX(tlt.ins_name," ")))
      n_names = trim(SUBSTR(tlt.ins_name,INDEX(tlt.ins_name," "))).
  ELSE ASSIGN n_title = ""
      n_names = TRIM(tlt.ins_name).
  IF index(n_title,"น.ส.") <> 0  THEN n_title = "นางสาว".
  n_address = "".
  IF tlt.hrg_vill   <> "" THEN ASSIGN n_address =   trim(tlt.hrg_vill) .   
  IF tlt.hrg_room   <> "" THEN ASSIGN n_address = trim(n_address +  " ห้อง" + trim(tlt.hrg_room))  .  
  IF tlt.hrg_no     <> "" THEN ASSIGN n_address = trim(n_address +  " "     + trim(tlt.hrg_no))  .  
  IF tlt.hrg_moo    <> "" THEN ASSIGN n_address = trim(n_address +  " ม."   + trim(tlt.hrg_moo))  .  
  IF tlt.hrg_soi    <> "" THEN ASSIGN n_address = trim(n_address +  " ซ."   + trim(tlt.hrg_soi))  .  
  IF tlt.hrg_street <> "" THEN ASSIGN n_address = trim(n_address +  " ถ."   + trim(tlt.hrg_street)). 
  IF  INDEX(tlt.hrg_prov,"กรุง")    <> 0 OR INDEX(tlt.hrg_prov,"กทม")     <> 0 OR INDEX(tlt.hrg_prov,"กรุงเทพ") <> 0    THEN
      ASSIGN n_tombon = "แขวง" +   trim(tlt.hrg_subdistrict)  
      n_amper  = "เขต"  +   trim(tlt.hrg_district)     
      n_provin = ""     +   trim(tlt.hrg_prov).         
  ELSE ASSIGN n_tombon = "ต."  +   trim(tlt.hrg_subdistrict)  
      n_amper  = "อ."  +   trim(tlt.hrg_district)     
      n_provin = "จ."  +   trim(tlt.hrg_prov).
  n_vehreg       = "".
  n_vehregprovin = "".
  n_vehreg       = trim(tlt.lince1).  
  n_vehregprovin = trim(tlt.lince2) .
  n_vehreg = REPLACE(n_vehreg," ","").
  IF n_vehreg <> ""  THEN DO:
      IF  INDEX("123456789",SUBSTR(n_vehreg,1,1)) <> 0  THEN DO:  /*1กก 123*/
          IF  INDEX("123456789",SUBSTR(n_vehreg,2,1)) <> 0  THEN  /*80 123*/
              ASSIGN n_vehreg = trim(SUBSTR(n_vehreg,1,2) + " " + SUBSTR(n_vehreg,3)).
          ELSE DO: /*1กก 123*/
              IF  INDEX("123456789",SUBSTR(n_vehreg,3,1)) <> 0  THEN ASSIGN n_vehreg = trim(SUBSTR(n_vehreg,1,2) + " " + SUBSTR(n_vehreg,3)).  /*1ก123*/
              ELSE ASSIGN n_vehreg = trim(SUBSTR(n_vehreg,1,3) + " " + SUBSTR(n_vehreg,4)).
          END.
      END.
      ELSE DO:  /*กก 123*/
          IF  INDEX("123456789",SUBSTR(n_vehreg,2,1)) <> 0  THEN  ASSIGN n_vehreg = trim(SUBSTR(n_vehreg,1,1) + " " + SUBSTR(n_vehreg,2)). /*80 123*/
          ELSE ASSIGN n_vehreg = trim(SUBSTR(n_vehreg,1,2) + " " + SUBSTR(n_vehreg,3)).
      END.
  END.
  ASSIGN n_seat  = 0
      n_seat  = INTE(tlt.note1).
  IF n_seat = 0 THEN DO: 
      IF      tlt.vehuse = "110" THEN n_seat  = 7.
      ELSE IF tlt.vehuse = "210" THEN n_seat  = 12. 
      ELSE IF tlt.vehuse = "310" OR tlt.vehuse = "320" THEN n_seat  = 3.
  END.
  FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
      brstat.insure.compno = "999" AND 
      brstat.insure.FName  = n_vehregprovin NO-LOCK NO-WAIT NO-ERROR.
  IF AVAIL brstat.insure THEN ASSIGN n_vehregprovin =  trim(brstat.insure.LName) .
  IF tlt.packnme   = "VMI" OR tlt.packnme   = "VCI" THEN DO:
      IF index(tlt.pack,"อู่ห้าง") <> 0 AND trim(tlt.flag)   = "new" THEN DO:  /*Garage = G */
          IF      tlt.vehuse = "110" THEN ASSIGN nv_ppbi = "1000000" nv_pacc = "10000000" nv_papd = "5000000" nv_41   = "100000" nv_42   = "100000" nv_43   = "300000".
          ELSE IF tlt.vehuse = "210" THEN ASSIGN nv_ppbi = "500000"  nv_pacc = "10000000" nv_papd = "1000000" nv_41   = "100000" nv_42   = "100000" nv_43   = "200000".
          ELSE IF tlt.vehuse = "320" THEN ASSIGN nv_ppbi = "500000"  nv_pacc = "10000000" nv_papd = "1000000" nv_41   = "100000" nv_42   = "100000" nv_43   = "200000".
      END.
      ELSE ASSIGN nv_ppbi = "500000" nv_pacc = "10000000" nv_papd = "1000000" nv_41   = "50000" nv_42   = "50000" nv_43   = "200000".
  END.
  /*-------- หากรมธรรม์เดิม --------------*/
  IF trim(tlt.flag) = "renew" AND tlt.packnme  <> "CMI" THEN DO:
      n_chkexpdat = ?.
      nv_prepol = "".
      FOR EACH sicuw.uwm301 USE-INDEX uwm30121 WHERE 
        sicuw.uwm301.cha_no = trim(tlt.cha_no)   AND 
        sicuw.uwm301.tariff = "X" NO-LOCK .
        IF LENGTH(sicuw.uwm301.policy) > 10 THEN DO:
          FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
              sicuw.uwm100.policy = sicuw.uwm301.policy AND 
              sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND 
              sicuw.uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR .
          IF AVAIL sicuw.uwm100 THEN DO:
              IF nv_prepol = "" THEN 
                  ASSIGN nv_prepol = trim(sicuw.uwm100.policy) 
                  n_branch    = trim(sicuw.uwm100.branch)
                  nv_cover    = trim(sicuw.uwm301.covcod) 
                  n_chkexpdat = sicuw.uwm100.expdat .
              ELSE IF n_chkexpdat < sicuw.uwm100.expdat  THEN
                  ASSIGN nv_prepol = trim(sicuw.uwm100.policy) 
                  n_branch  = trim(sicuw.uwm100.branch)
                  nv_cover = trim(sicuw.uwm301.covcod) 
                  n_chkexpdat = sicuw.uwm100.expdat .
          END.
        END.
      END.
      IF nv_prepol = "" THEN DO:
          n_chkexpdat = ?.
          FOR EACH  sicuw.uwm301 USE-INDEX uwm30102 WHERE 
            sicuw.uwm301.vehreg = trim(n_vehreg) + " " + trim(n_vehregprovin) AND 
            sicuw.uwm301.tariff = "X" NO-LOCK .
              IF LENGTH(sicuw.uwm301.policy) > 10 THEN DO:
                  FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                      sicuw.uwm100.policy = sicuw.uwm301.policy  AND 
                      sicuw.uwm100.rencnt = sicuw.uwm301.rencnt  AND 
                      sicuw.uwm100.endcnt = sicuw.uwm301.endcnt  NO-LOCK NO-ERROR .
                  IF AVAIL sicuw.uwm100 THEN DO:
                      IF nv_prepol = "" THEN 
                          ASSIGN nv_prepol = trim(sicuw.uwm100.policy) 
                          n_branch    = trim(sicuw.uwm100.branch)
                          nv_cover    = trim(sicuw.uwm301.covcod) 
                          n_chkexpdat = sicuw.uwm100.expdat .
                      ELSE IF n_chkexpdat < sicuw.uwm100.expdat  THEN
                          ASSIGN nv_prepol = trim(sicuw.uwm100.policy) 
                          n_branch  = trim(sicuw.uwm100.branch)
                          nv_cover = trim(sicuw.uwm301.covcod) 
                          n_chkexpdat = sicuw.uwm100.expdat .
                  END.
              END.
          END.
      END.
        /*ELSE ASSIGN WCREATE2.im2bran  = ""   WCREATE2.E2oldpol = "".*/
     
  END.
  IF tlt.packnme  = "CMI" OR tlt.packnme = "VCI" THEN RUN proc_pol72old (INPUT trim(tlt.cha_no)  
                                                                        ,INPUT trim(n_vehreg) + " " + trim(n_vehregprovin)
                                                                        ,INPUT-OUTPUT nv_prepol72 
                                                                        ,INPUT-OUTPUT n_branch72 ).
    /*IF wcreate2.e2typins = "CMI" AND wcreate2.E2oldpol <> "" AND WCREATE2.E2CVMI = "610" THEN WCREATE2.E2CVMI = "130D". /*Big bike V74 */
    */
    /* อายุผู้ขับขี่  
    IF WCREATE2.E2drinam1 <> " "  AND WCREATE2.E2dribht1 <> " " THEN DO: 
        ASSIGN  WCREATE2.E2driyer1 = STRING(INT(SUBSTR(WCREATE2.E2dribht1,7,4)) - 543)
                WCREATE2.E2driage1 = STRING(YEAR(TODAY) - INT(WCREATE2.E2driyer1)).
    END.
    IF WCREATE2.E2drinam2 <>  " " AND WCREATE2.E2dribht2 <> " " THEN DO: 
        ASSIGN  WCREATE2.E2driyer2 = STRING(INT(SUBSTR(WCREATE2.E2dribht2,7,4)) - 543)
                WCREATE2.E2driage2 = STRING(YEAR(TODAY) - INT(WCREATE2.E2driyer2)).*/
    /* renew */
  IF nv_prepol <> ""  OR nv_prepol72 <> "" THEN DO: 
      IF nv_prepol <> "" THEN RUN proc_uom.  
      IF SUBSTR(nv_prepol,7,1) = "U" OR SUBSTR(nv_prepol72,7,1) = "U" THEN ASSIGN nv_Producer = "B3MLKL0106"         /*A66-0160*/
          nv_Agent    = "B3MLKL0100".          /*A66-0160*/
      ELSE  ASSIGN nv_Producer = "B3MLKL0102"       /*A66-0160*/
                   nv_Agent    = "B3MLKL0100".      /*A66-0160*/
        /*n_branch = SUBSTRING(TRIM(nv_prepol),1,2).  /*1*/*/
      IF n_branch = "MF" THEN n_branch = "ML".      /*2*/
  END.
  ELSE IF (trim(n_vehreg) + " " + trim(n_vehregprovin)) <> "" THEN n_branch =  "ML" . 
  ELSE n_branch = "".
  IF nv_prepol   <> "" AND n_branch = "MF" THEN n_branch = "ML".
  IF nv_prepol72 <> "" AND n_branch72 = "MF" THEN n_branch72 = "ML".  
  IF trim(tlt.flag)   = "new" THEN DO: 
      IF n_vehreg <> "" THEN ASSIGN nv_Producer = "B3MLKL0101" nv_Agent    = "B3MLKL0100".   /*A66-0160*/
      ELSE IF trim(tlt.lince3) = "" THEN ASSIGN nv_Producer = "B3MLKL0103" nv_Agent    = "B3MLKL0100".   /*A66-0160*/
  END.
  ELSE DO:
      IF tlt.packnme  = "VMI" AND nv_prepol = "" THEN ASSIGN nv_Producer = "B3MLKL0101" nv_Agent    = "B3MLKL0100".   /*A66-0160*/
      ELSE IF (tlt.packnme  = "CMI" OR tlt.packnme = "VCI") AND nv_prepol72 = "" THEN ASSIGN nv_Producer = "B3MLKL0101" nv_Agent    = "B3MLKL0100".   /*A66-0160*/
  END.
  IF tlt.vehuse = "610" OR tlt.vehuse = "T610" THEN ASSIGN nv_Producer = "B3MLKL0105" nv_Agent  = "B3MLKL0100". 
  ELSE IF INDEX(tlt.brand,"benz") <> 0         THEN ASSIGN nv_Producer = "B3MLKL0104" nv_Agent  = "B3MLKL0100". 
  ASSIGN 
        /*nv_branch        = IF n_vehreg = "" THEN "" ELSE "ML"  /*สาขา  ML*/   */                                   
        nv_branch        = IF n_branch  = "" THEN n_branch72 ELSE n_branch
        nv_appno         = trim(tlt.lotno)                                                                        
        nv_notifyno      = trim(tlt.nor_noti_tlt)                                                                 
        nv_stkno         = trim(tlt.comp_sck)                                                                     
        nv_prepol        = IF tlt.packnme = "CMI" THEN nv_prepol72  ELSE  nv_prepol                         /*เลขที่กรมธรรม์เดิม */                                  
        nv_cover         = IF nv_cover <> "" THEN nv_cover ELSE IF tlt.packnme   = "CMI"   THEN "T" ELSE "1"   /*ประเภทความคุ้มครอง */                                  
        nv_typepol       = trim(tlt.flag)                       /*ประเภทที่แจ้งงาน          NEW*/                        
        nv_n_title       = trim(n_title)                        /*คำนำหน้าชื่อผู้เอาประกันภัย    */                      
        nv_n_names       = trim(n_names)                        /*ชื่อผู้เอาประกันภัย            */                      
        nv_cardef        = ""                                   /*ชื่อบริษัทรถประจำตำแหน่ง       */                      
        nv_occoup        = ""                                   /*Occup./อาชีพ         */                                
        nv_n_icno        = trim(tlt.ins_icno)                   /*ID/บัตรประชาชน  1940100152490*/              
        nv_n_address1    = trim(n_address)                      /*ที่อยู่1        37/324 เคซี3 ซอย11 ถนนหทัยราษฎร์*/   
        nv_n_address2    = n_tombon                             /*ที่อยู่2        แขวงสามวาตะวันตก*/                   
        nv_n_address3    = n_amper                              /*ที่อยู่3        เขตคลองสามวา    */                   
        nv_n_address4    = n_provin  + " " + trim(tlt.hrg_postcd)  /*ที่อยู่4         กรุงเทพฯ 10510  */      
        nv_mobile        = ""                                    /*เบอร์โทรศัพท์  */                                    
        nv_reciepname    = IF trim(tlt.flag)   = "Renew" THEN "" ELSE trim(n_title) + trim(n_names)                                       /*ชื่อที่ออกใบกำกับภาษี  */                            
        nv_reciepaddress = IF trim(tlt.flag)   = "Renew" THEN "" ELSE trim(n_address)  + " " +  n_tombon    + " " + n_amper  + " " +  n_provin  + " " + trim(tlt.hrg_postcd)                            /*ที่อยู่ออกใบกำกับภาษี  */                            
           
        nv_dri_name1     = trim(tlt.dri_name1)                   /*ชื่อ/นามสกุล1 */                                     
        nv_dri_brith1    = trim(tlt.dri_no1)                     /*วัน/เดือน/ปีเกิด 1  */                               
        nv_dri_age1      = ""                                    /*อายุ1 */                                             
        nv_dri_icno1     = trim(tlt.dri_ic1)                     /*เลขที่บัตรประชาชน 1 */                               
        nv_dri_licen1    = trim(tlt.dri_lic1)                    /*เลขที่ใบขับขี่1       */                             
        nv_dri_name2     = trim(tlt.dri_name2)                   /* ชื่อ/นามสกุล 2 */                                   
        nv_dri_brith2    = trim(tlt.dri_no2)                     /* วัน/เดือน/ปีเกิด2 */                                
        nv_dri_age2      = ""                                    /*อายุ2   */                                           
        nv_dri_icno2     = trim(tlt.dri_ic2)                     /* เลขที่บัตรประชาชน 2 */                              
        nv_dri_licen2    = trim(tlt.dri_lic2)                    /* เลขที่ใบขับขี่2 */                                  
        nv_comdat        = string(tlt.gendat,"99/99/9999")       /*วันที่เริ่มคุ้มครอง*/                                
        nv_expodat       = string(tlt.expodat,"99/99/9999")       /*วันที่สิ้นสุด   */                                   
        nv_brand         = trim(tlt.brand)                       /*ยี่ห้อ              */                               
        nv_model         = trim(tlt.model)                       /*รุ่น            */                                   
        nv_caryear       = trim(tlt.lince3)                      /*ปีที่จดทะเบียน  */                                   
        nv_n_vehreg      = trim(n_vehreg) + " " + trim(n_vehregprovin)  /*ทะเบียนรถ           */                        
        nv_cha_no        = trim(tlt.cha_no)                             /*เลขตัวถัง           */                        
        nv_eng_no        = trim(tlt.eng_no)                             /*เลขเครื่องยนต์  */                            
        nv_ccno          = string(tlt.cc_weight)                        /*ขนาดเครื่องยนต์ */                            
        nv_tons          = IF DECI(tlt.note2) = 0 THEN  string(tlt.cc_weight) ELSE trim(tlt.note2)    /*น้ำหนัก             */                        
        nv_n_seat        = string(n_seat)                                    /*จำนวนที่นั่ง */                            
        nv_sumins        = IF tlt.packnme   = "CMI" THEN "0" ELSE string(tlt.nor_coamt)  /*ทุนประกัน    */              
        nv_premnet       = IF tlt.packnme   = "CMI" THEN "0" ELSE  tlt.note5             /*เบี้ยสุทธิ       70 */                
        nv_premtotle     = IF tlt.packnme   = "CMI" THEN "0" ELSE  tlt.note8             /*เบี้ยรวมภาษีอากร 70 */                
        nv_compnet       = IF tlt.packnme   = "CMI" THEN tlt.note10 ELSE "0"             /*เบี้ยพรบ         72   */            
        nv_comptotle     = IF tlt.packnme   = "CMI" THEN tlt.note13 ELSE "0"             /*เบี้ยรวมพรบ      72 */                
        nv_garage        = IF tlt.packnme   = "CMI" THEN "" 
                           ELSE IF tlt.pack = "อู่ในเครือ" THEN "" 
                           ELSE IF  index(tlt.pack,"อู่ห้าง") <> 0 THEN "G" ELSE ""             /*ซ่อม(0:อู่ห้าง 1:อู่ในเครือ)*/    
        nv_accoryno      = trim(tlt.note3)                                          /*อุปกรณ์เสริม     */               
        nv_accodes       = trim(tlt.note4)                                          /*รายละเอียดอุปกรณ์เสริม */         
        nv_remark        = trim(tlt.note15)                                         /*หมายเหตุ */                       
        nv_agentid       = ""                                                       /*รหัสตัวแทน*/                      
        nv_vehuse        = IF      tlt.packnme   = "CMI" AND deci(tlt.note10) = 600  THEN "110"
                           ELSE IF tlt.packnme   = "CMI" AND deci(tlt.note10) = 900  THEN "140A"
                           ELSE IF tlt.packnme   = "CMI" AND deci(tlt.note10) = 1100 THEN "120A"
                           ELSE IF tlt.vehuse = "310" THEN "T320"
                           ELSE IF tlt.vehuse <> "" THEN "T" + trim(tlt.vehuse) 
                           ELSE   tlt.vehuse        
        nv_poltyp        = IF tlt.packnme   = "CMI" THEN "V72" ELSE "V70"   /*Pol_Type 70/72/74 */   
        nv_ppbi          = nv_ppbi                                  /*Per Person (BI)  */    
        nv_pacc          = nv_pacc                                  /*Per Accident        */ 
        nv_papd          = nv_papd                                  /*Per Accident(PD) */    
        nv_41            = nv_41                                    /*4.1 SI.         */     
        nv_42            = nv_42                                    /*4.2 Sum         */     
        nv_43            = nv_43                                   /*4.3 Sum         */     
        nv_vatcode       = ""                                                        /*VATCODE         */  
        nv_ispno         = trim(tlt.rec_addr3)                                                /*ISP_NO          */        
        nv_campaign      = nv_Producer                               /*Campaign        */              
        nv_benefic       = IF tlt.packnme   = "CMI" THEN "" ELSE  trim(tlt.ben83)             /*Beneficiary           */  
        nv_Producer      = nv_Producer                                                      /*Producer        */       
        nv_Agent         = nv_Agent                                                         /*Agent               */   
        nv_payment       = tlt.note20                                                         /*Payment         */        
        nv_tracking      = IF trim(tlt.flag)   = "Renew" THEN tlt.note21 ELSE  "จัดส่งสำเนาตามหน้าตาราง"   /*Tracking          */      
        /*nv_promotion     = IF (tlt.packnme   = "VMI" OR tlt.packnme   = "VCI") AND trim(tlt.flag)   = "new" THEN "K-CAR"   ELSE ""  */ 
        nv_promotion     = IF (tlt.packnme   = "VMI" OR tlt.packnme   = "VCI") AND trim(tlt.flag)   = "new" THEN "Used Car"   ELSE ""     /*Promotion        */       
        nv_colorcode     = trim(tlt.colorcode) .
    RUN pd_assign01.
    IF tlt.packnme = "VCI" THEN DO:
        ASSIGN
        nv_notifyno = "1" + SUBSTR(nv_appno,3)  
        nv_prepol =  nv_prepol72  
        nv_cover  = "T" 
        nv_vehuse = IF tlt.vehuse = "110" THEN "110" ELSE IF tlt.vehuse = "210" THEN "120A" ELSE "140A" 
        nv_poltyp = "V72"
        nv_ppbi   = ""
        nv_pacc   = ""
        nv_papd   = ""
        nv_41     = ""
        nv_42     = ""
        nv_43     = ""
        nv_sumins    = ""
        nv_premnet   = ""
        nv_premtotle = ""  
        nv_compnet       =  tlt.note10  
        nv_comptotle     =  tlt.note13  
        nv_promotion = ""
        nv_garage = "" 
        nv_accoryno = ""  
        nv_accodes  = ""  
        nv_benefic = "" .
        RUN pd_assign01.  /*v72*/
    END.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_createdata_bk c-wins 
PROCEDURE pd_createdata_bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

For each tlt Use-index  tlt01 Where
    tlt.trndat   >=  fi_trndatfr   And
    tlt.trndat   <=  fi_trndatto   And
    tlt.genusr    =  "K-LEASING"    no-lock. 
    RUN pd_clearinit.
    ASSIGN 
        n_title   = "" 
        n_address = "" 
        n_branch = "".
    IF INDEX(tlt.ins_name," ") <> 0 THEN 
        ASSIGN 
        n_title = trim(SUBSTR(tlt.ins_name,1,INDEX(tlt.ins_name," ")))
        n_names = trim(SUBSTR(tlt.ins_name,INDEX(tlt.ins_name," "))).
    ELSE ASSIGN 
        n_title = ""
        n_names = TRIM(tlt.ins_name).
    IF index(n_title,"น.ส.") <> 0  THEN n_title = "นางสาว".
    n_address = "".
    /*IF tlt.hrg_vill   <> "" THEN ASSIGN n_address = "มบ." + trim(tlt.hrg_vill) .  */
    IF tlt.hrg_vill   <> "" THEN ASSIGN n_address =   trim(tlt.hrg_vill) .   
    IF tlt.hrg_room   <> "" THEN ASSIGN n_address = trim(n_address +  " ห้อง" + trim(tlt.hrg_room))  .  
    IF tlt.hrg_no     <> "" THEN ASSIGN n_address = trim(n_address +  " "     + trim(tlt.hrg_no))  .  
    IF tlt.hrg_moo    <> "" THEN ASSIGN n_address = trim(n_address +  " ม."   + trim(tlt.hrg_moo))  .  
    IF tlt.hrg_soi    <> "" THEN ASSIGN n_address = trim(n_address +  " ซ."   + trim(tlt.hrg_soi))  .  
    IF tlt.hrg_street <> "" THEN ASSIGN n_address = trim(n_address +  " ถ."   + trim(tlt.hrg_street)). 
    IF  INDEX(tlt.hrg_prov,"กรุง")    <> 0 OR INDEX(tlt.hrg_prov,"กทม")     <> 0 OR INDEX(tlt.hrg_prov,"กรุงเทพ") <> 0    THEN  
        ASSIGN
        n_tombon = "แขวง" +   trim(tlt.hrg_subdistrict)  
        n_amper  = "เขต"  +   trim(tlt.hrg_district)     
        n_provin = ""     +   trim(tlt.hrg_prov).         
    ELSE 
        ASSIGN
            n_tombon = "ต."  +   trim(tlt.hrg_subdistrict)  
            n_amper  = "อ."  +   trim(tlt.hrg_district)     
            n_provin = "จ."  +   trim(tlt.hrg_prov).

    n_vehreg       = "".
    n_vehregprovin = "".
    n_vehreg       = trim(tlt.lince1).  
    n_vehregprovin = trim(tlt.lince2) .
    n_vehreg = REPLACE(n_vehreg," ","").
    IF n_vehreg <> ""  THEN DO:
        /*1กก 123*/
        IF  INDEX("123456789",SUBSTR(n_vehreg,1,1)) <> 0  THEN DO:
            IF  INDEX("123456789",SUBSTR(n_vehreg,2,1)) <> 0  THEN  /*80 123*/
                ASSIGN n_vehreg = trim(SUBSTR(n_vehreg,1,2) + " " + SUBSTR(n_vehreg,3)).
            ELSE DO: /*1กก 123*/
                IF  INDEX("123456789",SUBSTR(n_vehreg,3,1)) <> 0  THEN  /*1ก123*/
                    ASSIGN n_vehreg = trim(SUBSTR(n_vehreg,1,2) + " " + SUBSTR(n_vehreg,3)).
                ELSE ASSIGN n_vehreg = trim(SUBSTR(n_vehreg,1,3) + " " + SUBSTR(n_vehreg,4)).
            END.
        END.
        ELSE DO:  /*กก 123*/
            IF  INDEX("123456789",SUBSTR(n_vehreg,2,1)) <> 0  THEN  /*80 123*/
                ASSIGN n_vehreg = trim(SUBSTR(n_vehreg,1,1) + " " + SUBSTR(n_vehreg,2)).
            ELSE ASSIGN n_vehreg = trim(SUBSTR(n_vehreg,1,2) + " " + SUBSTR(n_vehreg,3)).
        END.
    END.
    ASSIGN n_seat  = 0
        n_seat  = INTE(tlt.note1).
    IF n_seat = 0 THEN DO: 
        IF      tlt.vehuse = "110" THEN n_seat  = 7.
        ELSE IF tlt.vehuse = "210" THEN n_seat  = 12. 
        ELSE IF tlt.vehuse = "310" OR tlt.vehuse = "320" THEN n_seat  = 3.
    END.
    FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
        brstat.insure.compno = "999" AND 
        brstat.insure.FName  = n_vehregprovin NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN ASSIGN n_vehregprovin =  trim(brstat.insure.LName) .
    IF tlt.packnme   = "VMI" OR tlt.packnme   = "VCI" THEN DO:
        IF index(tlt.pack,"อู่ห้าง") <> 0 AND trim(tlt.flag)   = "new" THEN DO:  /*Garage = G */
            IF      tlt.vehuse = "110" THEN ASSIGN nv_ppbi = "1000000" nv_pacc = "10000000" nv_papd = "5000000" nv_41   = "100000" nv_42   = "100000" nv_43   = "300000".
            ELSE IF tlt.vehuse = "210" THEN ASSIGN nv_ppbi = "500000"  nv_pacc = "10000000" nv_papd = "1000000" nv_41   = "100000" nv_42   = "100000" nv_43   = "200000".
            ELSE IF tlt.vehuse = "320" THEN ASSIGN nv_ppbi = "500000"  nv_pacc = "10000000" nv_papd = "1000000" nv_41   = "100000" nv_42   = "100000" nv_43   = "200000".
        END.
        ELSE ASSIGN nv_ppbi = "500000" nv_pacc = "10000000" nv_papd = "1000000" nv_41   = "50000" nv_42   = "50000" nv_43   = "200000".
        
    END.
    /*IF      INTE(tlt.lince3) = YEAR(TODAY) AND INDEX(tlt.brand,"BEN") <> 0  THEN ASSIGN nv_Producer = "B3MLKL0104" nv_Agent  = "B3MLKL0100". 
    ELSE IF INTE(tlt.lince3) = YEAR(TODAY)                                  THEN ASSIGN nv_Producer = "B3MLKL0103" nv_Agent  = "B3MLKL0100". 
    ELSE  ASSIGN nv_Producer = "B3MLKL0102" nv_Agent  = "B3MLKL0100".*/ 
    
    /*-------- หากรมธรรม์เดิม --------------*/
    IF trim(tlt.flag) = "renew" AND tlt.packnme  <> "CMI" THEN DO:
        
    FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE 
        sicuw.uwm301.cha_no = trim(tlt.cha_no)   AND 
        sicuw.uwm301.tariff = "X"  NO-LOCK  NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm301 THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
            sicuw.uwm100.policy = sicuw.uwm301.policy AND 
            sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND 
            sicuw.uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR .
        IF AVAIL sicuw.uwm100 THEN DO:
            ASSIGN nv_prepol = sicuw.uwm100.policy 
                   n_branch  = sicuw.uwm100.branch
                   nv_cover = sicuw.uwm301.covcod.


            /*FIND LAST sicuw.uwm120  USE-INDEX uwm12001  WHERE 
                uwm120.policy = uwm100.policy AND                
                uwm120.rencnt = uwm100.rencnt AND 
                uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.  
            IF AVAIL sicuw.uwm120 THEN ASSIGN WCREATE2.E2CVMI = uwm120.CLASS.   */                            
        END.
        /*ELSE ASSIGN WCREATE2.im2bran  = ""   WCREATE2.E2oldpol = "".*/
    END.
    ELSE DO:
        FIND LAST sicuw.uwm301 USE-INDEX uwm30102 WHERE 
            sicuw.uwm301.vehreg = trim(n_vehreg) + " " + trim(n_vehregprovin) AND 
            sicuw.uwm301.tariff = "X" NO-LOCK  NO-ERROR.
        IF AVAIL sicuw.uwm301 THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                sicuw.uwm100.policy = sicuw.uwm301.policy  AND 
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt  AND 
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt  NO-LOCK NO-ERROR .
            IF AVAIL sicuw.uwm100 THEN DO:
                ASSIGN  nv_prepol = sicuw.uwm100.policy 
                        n_branch  = sicuw.uwm100.branch
                        nv_cover = sicuw.uwm301.covcod.
                /*FIND LAST sicuw.uwm120  USE-INDEX uwm12001  WHERE 
                    uwm120.policy = uwm100.policy AND                
                    uwm120.rencnt = uwm100.rencnt AND 
                    uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.  
                IF AVAIL sicuw.uwm120 THEN ASSIGN WCREATE2.E2CVMI = uwm120.CLASS.  */                             
            END.
            /*ELSE ASSIGN WCREATE2.im2bran  = ""   WCREATE2.E2oldpol = "".*/
        END.
        /*ELSE ASSIGN WCREATE2.im2bran  = ""   WCREATE2.E2oldpol = "".*/
    END.
    END.
    /*IF wcreate2.e2typins = "CMI" AND wcreate2.E2oldpol <> "" AND WCREATE2.E2CVMI = "610" THEN WCREATE2.E2CVMI = "130D". /*Big bike V74 */
    */
    /* อายุผู้ขับขี่  
    IF WCREATE2.E2drinam1 <> " "  AND WCREATE2.E2dribht1 <> " " THEN DO: 
        ASSIGN  WCREATE2.E2driyer1 = STRING(INT(SUBSTR(WCREATE2.E2dribht1,7,4)) - 543)
                WCREATE2.E2driage1 = STRING(YEAR(TODAY) - INT(WCREATE2.E2driyer1)).
    END.
    IF WCREATE2.E2drinam2 <>  " " AND WCREATE2.E2dribht2 <> " " THEN DO: 
        ASSIGN  WCREATE2.E2driyer2 = STRING(INT(SUBSTR(WCREATE2.E2dribht2,7,4)) - 543)
                WCREATE2.E2driage2 = STRING(YEAR(TODAY) - INT(WCREATE2.E2driyer2)).
                */
    
    /* renew */
    IF nv_prepol <> ""  THEN DO: 
        IF SUBSTR(nv_prepol,7,1) = "U" THEN
        ASSIGN nv_Producer = "B3MLKL0106"           /*A66-0160*/
               nv_Agent    = "B3MLKL0100".          /*A66-0160*/
        ELSE  ASSIGN nv_Producer = "B3MLKL0102"           /*A66-0160*/
                     nv_Agent    = "B3MLKL0100".          /*A66-0160*/
        /*n_branch = SUBSTRING(TRIM(nv_prepol),1,2).  /*1*/*/
        IF n_branch = "MF" THEN n_branch = "ML".      /*2*/
    END.
    ELSE IF (trim(n_vehreg) + " " + trim(n_vehregprovin)) <> "" THEN n_branch =  "ML" . 
    ELSE n_branch = "".

    IF trim(tlt.flag)   = "new" THEN DO: 
        IF n_vehreg <> "" THEN ASSIGN nv_Producer = "B3MLKL0101" nv_Agent    = "B3MLKL0100".   /*A66-0160*/
        ELSE IF trim(tlt.lince3) = "" THEN ASSIGN nv_Producer = "B3MLKL0103" nv_Agent    = "B3MLKL0100".   /*A66-0160*/
    END.
    ELSE DO:
        IF nv_prepol = "" THEN ASSIGN nv_Producer = "B3MLKL0101" nv_Agent    = "B3MLKL0100".   /*A66-0160*/
    END.
    IF tlt.vehuse = "610" OR tlt.vehuse = "T610" THEN ASSIGN nv_Producer = "B3MLKL0105" nv_Agent  = "B3MLKL0100". 
    ELSE IF INDEX(tlt.brand,"benz") <> 0         THEN ASSIGN nv_Producer = "B3MLKL0104" nv_Agent  = "B3MLKL0100". 


    ASSIGN 
        /*nv_branch        = IF n_vehreg = "" THEN "" ELSE "ML"  /*สาขา  ML*/   */                                   
        nv_branch        = n_branch  
        nv_appno         = trim(tlt.lotno)                                                                        
        nv_notifyno      = trim(tlt.nor_noti_tlt)                                                                 
        nv_stkno         = trim(tlt.comp_sck)                                                                     
        nv_prepol        = nv_prepol                            /*เลขที่กรมธรรม์เดิม */                                  
        nv_cover         = IF nv_cover <> "" THEN nv_cover ELSE IF tlt.packnme   = "CMI"   THEN "T" ELSE "1"   /*ประเภทความคุ้มครอง */                                  
        nv_typepol       = trim(tlt.flag)                       /*ประเภทที่แจ้งงาน          NEW*/                        
        nv_n_title       = trim(n_title)                        /*คำนำหน้าชื่อผู้เอาประกันภัย    */                      
        nv_n_names       = trim(n_names)                        /*ชื่อผู้เอาประกันภัย            */                      
        nv_cardef        = ""                                   /*ชื่อบริษัทรถประจำตำแหน่ง       */                      
        nv_occoup        = ""                                   /*Occup./อาชีพ         */                                
        nv_n_icno        = trim(tlt.ins_icno)                   /*ID/บัตรประชาชน  1940100152490*/              
        nv_n_address1    = trim(n_address)                      /*ที่อยู่1        37/324 เคซี3 ซอย11 ถนนหทัยราษฎร์*/   
        nv_n_address2    = n_tombon                             /*ที่อยู่2        แขวงสามวาตะวันตก*/                   
        nv_n_address3    = n_amper                              /*ที่อยู่3        เขตคลองสามวา    */                   
        nv_n_address4    = n_provin  + " " + trim(tlt.hrg_postcd)  /*ที่อยู่4         กรุงเทพฯ 10510  */      
        nv_mobile        = ""                                    /*เบอร์โทรศัพท์  */                                    
        nv_reciepname    = IF trim(tlt.flag)   = "Renew" THEN "" ELSE trim(n_title) + trim(n_names)                                       /*ชื่อที่ออกใบกำกับภาษี  */                            
        nv_reciepaddress = IF trim(tlt.flag)   = "Renew" THEN "" ELSE trim(n_address)  + " " +  n_tombon    + " " + n_amper  + " " +  n_provin  + " " + trim(tlt.hrg_postcd)                            /*ที่อยู่ออกใบกำกับภาษี  */                            
           
        nv_dri_name1     = trim(tlt.dri_name1)                   /*ชื่อ/นามสกุล1 */                                     
        nv_dri_brith1    = trim(tlt.dri_no1)                     /*วัน/เดือน/ปีเกิด 1  */                               
        nv_dri_age1      = ""                                    /*อายุ1 */                                             
        nv_dri_icno1     = trim(tlt.dri_ic1)                     /*เลขที่บัตรประชาชน 1 */                               
        nv_dri_licen1    = trim(tlt.dri_lic1)                    /*เลขที่ใบขับขี่1       */                             
        nv_dri_name2     = trim(tlt.dri_name2)                   /* ชื่อ/นามสกุล 2 */                                   
        nv_dri_brith2    = trim(tlt.dri_no2)                     /* วัน/เดือน/ปีเกิด2 */                                
        nv_dri_age2      = ""                                    /*อายุ2   */                                           
        nv_dri_icno2     = trim(tlt.dri_ic2)                     /* เลขที่บัตรประชาชน 2 */                              
        nv_dri_licen2    = trim(tlt.dri_lic2)                    /* เลขที่ใบขับขี่2 */                                  
        nv_comdat        = string(tlt.gendat,"99/99/9999")       /*วันที่เริ่มคุ้มครอง*/                                
        nv_expodat       = string(tlt.expodat,"99/99/9999")       /*วันที่สิ้นสุด   */                                   
        nv_brand         = trim(tlt.brand)                       /*ยี่ห้อ              */                               
        nv_model         = trim(tlt.model)                       /*รุ่น            */                                   
        nv_caryear       = trim(tlt.lince3)                      /*ปีที่จดทะเบียน  */                                   
        nv_n_vehreg      = trim(n_vehreg) + " " + trim(n_vehregprovin)  /*ทะเบียนรถ           */                        
        nv_cha_no        = trim(tlt.cha_no)                             /*เลขตัวถัง           */                        
        nv_eng_no        = trim(tlt.eng_no)                             /*เลขเครื่องยนต์  */                            
        nv_ccno          = string(tlt.cc_weight)                        /*ขนาดเครื่องยนต์ */                            
        nv_tons          = IF DECI(tlt.note2) = 0 THEN  string(tlt.cc_weight) ELSE trim(tlt.note2)    /*น้ำหนัก             */                        
        nv_n_seat        = string(n_seat)                                    /*จำนวนที่นั่ง */                            
        nv_sumins        = IF tlt.packnme   = "CMI" THEN "0" ELSE string(tlt.nor_coamt)  /*ทุนประกัน    */              
        nv_premnet       = IF tlt.packnme   = "CMI" THEN "0" ELSE  tlt.note5             /*เบี้ยสุทธิ       70 */                
        nv_premtotle     = IF tlt.packnme   = "CMI" THEN "0" ELSE  tlt.note8             /*เบี้ยรวมภาษีอากร 70 */                
        nv_compnet       = IF tlt.packnme   = "CMI" THEN tlt.note10 ELSE "0"             /*เบี้ยพรบ         72   */            
        nv_comptotle     = IF tlt.packnme   = "CMI" THEN tlt.note13 ELSE "0"             /*เบี้ยรวมพรบ      72 */                
        nv_garage        = IF tlt.packnme   = "CMI" THEN "" 
                           ELSE IF tlt.pack = "อู่ในเครือ" THEN "" ELSE "G"             /*ซ่อม(0:อู่ห้าง 1:อู่ในเครือ)*/    
        nv_accoryno      = trim(tlt.note3)                                          /*อุปกรณ์เสริม     */               
        nv_accodes       = trim(tlt.note4)                                          /*รายละเอียดอุปกรณ์เสริม */         
        nv_remark        = trim(tlt.note15)                                         /*หมายเหตุ */                       
        nv_agentid       = ""                                                       /*รหัสตัวแทน*/                      
        nv_vehuse        = IF      tlt.packnme   = "CMI" AND deci(tlt.note10) = 600  THEN "110"
                           ELSE IF tlt.packnme   = "CMI" AND deci(tlt.note10) = 900  THEN "140A"
                           ELSE IF tlt.packnme   = "CMI" AND deci(tlt.note10) = 1100 THEN "120A"
                           ELSE IF tlt.vehuse = "310" THEN "T320"
                           ELSE IF tlt.vehuse <> "" THEN "T" + trim(tlt.vehuse) 
                           ELSE   tlt.vehuse        
        nv_poltyp        = IF tlt.packnme   = "CMI" THEN "V72" ELSE "V70"   /*Pol_Type 70/72/74 */   
        nv_ppbi          = nv_ppbi                                  /*Per Person (BI)  */    
        nv_pacc          = nv_pacc                                  /*Per Accident        */ 
        nv_papd          = nv_papd                                  /*Per Accident(PD) */    
        nv_41            = nv_41                                    /*4.1 SI.         */     
        nv_42            = nv_42                                    /*4.2 Sum         */     
        nv_43            = nv_43                                   /*4.3 Sum         */     
        nv_vatcode       = ""                                                        /*VATCODE         */  
        nv_ispno         = trim(tlt.rec_addr3)                                                /*ISP_NO          */        
        nv_campaign      = nv_Producer                               /*Campaign        */              
        nv_benefic       = IF tlt.packnme   = "CMI" THEN "" ELSE  trim(tlt.ben83)             /*Beneficiary           */  
        nv_Producer      = nv_Producer                                                      /*Producer        */       
        nv_Agent         = nv_Agent                                                         /*Agent               */   
        nv_payment       = tlt.note20                                                         /*Payment         */        
        nv_tracking      = IF trim(tlt.flag)   = "Renew" THEN tlt.note21 ELSE  "จัดส่งสำเนาตามหน้าตาราง"   /*Tracking          */      
        /*nv_promotion     = IF (tlt.packnme   = "VMI" OR tlt.packnme   = "VCI") AND trim(tlt.flag)   = "new" THEN "K-CAR"   ELSE ""  */ 
        nv_promotion     = IF (tlt.packnme   = "VMI" OR tlt.packnme   = "VCI") AND trim(tlt.flag)   = "Used Car" THEN "K-CAR"   ELSE ""                                /*Promotion        */       
        nv_colorcode     = trim(tlt.colorcode) .
    RUN pd_assign01.
    IF tlt.packnme = "VCI" THEN DO:
        ASSIGN
        nv_notifyno = "1" + SUBSTR(nv_appno,3)  
        nv_prepol = ""   
        nv_cover  = "T" 
        nv_vehuse = IF tlt.vehuse = "110" THEN "110" ELSE IF tlt.vehuse = "210" THEN "120A" ELSE "140A" 
        nv_poltyp = "V72"
        nv_ppbi   = ""
        nv_pacc   = ""
        nv_papd   = ""
        nv_41     = ""
        nv_42     = ""
        nv_43     = ""
        nv_sumins    = ""
        nv_premnet   = ""
        nv_premtotle = ""  
        nv_compnet       =  tlt.note10  
        nv_comptotle     =  tlt.note13  
        nv_garage = "" 
        nv_accoryno = ""  
        nv_accodes  = ""  
        nv_benefic = "" .
        RUN pd_assign01.  /*v72*/
    END.
END. 
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
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN fi_outfile  =  Trim(fi_outfile) + ".csv"  .
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "สาขา"
    "เลขที่ใบคำขอ"
    "เลขที่รับแจ้ง"
    "เลขที่สติ๊กเกอร์"
    "เลขที่กรมธรรม์เดิม"
    "ประเภทความคุ้มครอง"
    "ประเภทที่แจ้งงาน"
    "คำนำหน้าชื่อผู้เอาประกันภัย"
    "ชื่อผู้เอาประกันภัย"
    "ชื่อบริษัทรถประจำตำแหน่ง"
    "Occup./อาชีพ"
    "ID/บัตรประชาชน"
    "ที่อยู่1"
    "ที่อยู่2"
    "ที่อยู่3"
    "ที่อยู่4"
    "เบอร์โทรศัพท์"
    "ชื่อที่ออกใบกำกับภาษี"
    "ที่อยู่ออกใบกำกับภาษี"
    "ชื่อ/นามสกุล1"
    "วัน/เดือน/ปีเกิด 1"
    "อายุ1"
    "เลขที่บัตรประชาชน 1"
    "เลขที่ใบขับขี่1"
    "ชื่อ/นามสกุล 2"
    "วัน/เดือน/ปีเกิด2"
    "อายุ2"
    "เลขที่บัตรประชาชน 2"
    "เลขที่ใบขับขี่2"
    "วันที่เริ่มคุ้มครอง"
    "วันที่สิ้นสุด"
    "ยี่ห้อ"
    "รุ่น "
    "ปีที่จดทะเบียน"
    "ทะเบียนรถ"
    "เลขตัวถัง"
    "เลขเครื่องยนต์"
    "ขนาดเครื่องยนต์"
    "น้ำหนัก"
    "จำนวนที่นั่ง"
    "ทุนประกัน"
    "เบี้ยสุทธิ"
    "เบี้ยรวมภาษีอากร"
    "เบี้ยพรบ"
    "เบี้ยรวมพรบ"
    "การซ่อม(0:อู่ห้าง 1:อู่ในเครือ)"
    "อุปกรณ์เสริม"
    "รายละเอียดอุปกรณ์เสริม"
    "หมายเหตุ"
    "รหัสตัวแทน"
    "ลักษณะการใช้งาน"
    "Pol_Type 70/72/74"
    "Per Person (BI)"
    "Per Accident"
    "Per Accident(PD)"
    "4.1 SI." 
    "4.2 Sum" 
    "4.3 Sum" 
    "VATCODE" 
    "ISP_NO" 
    "Campaign" 
    "Beneficiary"
    "Producer" 
    "Agent" 
    "Payment" 
    "Tracking" 
    "Promotion" 
    "color" .

FOR EACH wdetail WHERE  
    wdetail.typepol = "new" NO-LOCK.

    EXPORT DELIMITER "|"  
        wdetail.branch       
        wdetail.appno        
        wdetail.notifyno     
        wdetail.stkno        
        wdetail.prepol       
        wdetail.cover        
        wdetail.typepol      
        wdetail.n_title      
        wdetail.n_names      
        wdetail.cardef       
        wdetail.occoup       
        wdetail.n_icno       
        wdetail.n_address1   
        wdetail.n_address2   
        wdetail.n_address3   
        wdetail.n_address4   
        wdetail.mobile       
        wdetail.reciepname   
        wdetail.reciepaddress
        wdetail.dri_name1    
        wdetail.dri_brith1   
        wdetail.dri_age1     
        wdetail.dri_icno1    
        wdetail.dri_licen1   
        wdetail.dri_name2    
        wdetail.dri_brith2   
        wdetail.dri_age2     
        wdetail.dri_icno2     
        wdetail.dri_licen2    
        wdetail.comdat        
        wdetail.expodat       
        wdetail.brand         
        wdetail.model         
        wdetail.caryear       
        wdetail.n_vehreg      
        wdetail.cha_no        
        wdetail.eng_no        
        wdetail.ccno          
        wdetail.tons          
        wdetail.n_seat        
        wdetail.sumins        
        wdetail.premnet       
        wdetail.premtotle     
        wdetail.compnet       
        wdetail.comptotle     
        wdetail.garage        
        wdetail.accoryno      
        wdetail.accodes       
        wdetail.remark        
        wdetail.agentid       
        wdetail.vehuse        
        wdetail.poltyp        
        wdetail.nv_ppbi       
        wdetail.nv_pacc       
        wdetail.nv_papd       
        wdetail.nv_41         
        wdetail.nv_42         
        wdetail.nv_43         
        wdetail.vatcode       
        wdetail.ispno         
        wdetail.campaign      
        wdetail.benefic       
        wdetail.nv_Producer   
        wdetail.nv_Agent      
        wdetail.payment       
        wdetail.tracking      
        wdetail.promotion     
        wdetail.colorcode  .
END.
OUTPUT   CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielall c-wins 
PROCEDURE pd_reportfielall :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".csv"  .
/*ASSIGN nv_cnt =  0
    nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "สาขา"
    "เลขที่ใบคำขอ"
    "เลขที่รับแจ้ง"
    "เลขที่สติ๊กเกอร์"
    "เลขที่กรมธรรม์เดิม"
    "ประเภทความคุ้มครอง"
    "ประเภทที่แจ้งงาน"
    "คำนำหน้าชื่อผู้เอาประกันภัย"
    "ชื่อผู้เอาประกันภัย"
    "ชื่อบริษัทรถประจำตำแหน่ง"
    "Occup./อาชีพ"
    "ID/บัตรประชาชน"
    "ที่อยู่1"
    "ที่อยู่2"
    "ที่อยู่3"
    "ที่อยู่4"
    "เบอร์โทรศัพท์"
    "ชื่อที่ออกใบกำกับภาษี"
    "ที่อยู่ออกใบกำกับภาษี"
    "ชื่อ/นามสกุล1"
    "วัน/เดือน/ปีเกิด 1"
    "อายุ1"
    "เลขที่บัตรประชาชน 1"
    "เลขที่ใบขับขี่1"
    "ชื่อ/นามสกุล 2"
    "วัน/เดือน/ปีเกิด2"
    "อายุ2"
    "เลขที่บัตรประชาชน 2"
    "เลขที่ใบขับขี่2"
    "วันที่เริ่มคุ้มครอง"
    "วันที่สิ้นสุด"
    "ยี่ห้อ"
    "รุ่น "
    "ปีที่จดทะเบียน"
    "ทะเบียนรถ"
    "เลขตัวถัง"
    "เลขเครื่องยนต์"
    "ขนาดเครื่องยนต์"
    "น้ำหนัก"
    "จำนวนที่นั่ง"
    "ทุนประกัน"
    "เบี้ยสุทธิ"
    "เบี้ยรวมภาษีอากร"
    "เบี้ยพรบ"
    "เบี้ยรวมพรบ"
    "การซ่อม(0:อู่ห้าง 1:อู่ในเครือ)"
    "อุปกรณ์เสริม"
    "รายละเอียดอุปกรณ์เสริม"
    "หมายเหตุ"
    "รหัสตัวแทน"
    "ลักษณะการใช้งาน"
    "Pol_Type 70/72/74"
    "Per Person (BI)"
    "Per Accident"
    "Per Accident(PD)"
    "4.1 SI." 
    "4.2 Sum" 
    "4.3 Sum" 
    "VATCODE" 
    "ISP_NO" 
    "Campaign" 
    "Beneficiary"
    "Producer" 
    "Agent" 
    "Payment" 
    "Tracking" 
    "Promotion" 
    "color" .

FOR EACH wdetail   NO-LOCK.

    EXPORT DELIMITER "|"  
        wdetail.branch       
        wdetail.appno        
        wdetail.notifyno     
        wdetail.stkno        
        wdetail.prepol       
        wdetail.cover        
        wdetail.typepol      
        wdetail.n_title      
        wdetail.n_names      
        wdetail.cardef       
        wdetail.occoup       
        wdetail.n_icno       
        wdetail.n_address1   
        wdetail.n_address2   
        wdetail.n_address3   
        wdetail.n_address4   
        wdetail.mobile       
        wdetail.reciepname   
        wdetail.reciepaddress
        wdetail.dri_name1    
        wdetail.dri_brith1   
        wdetail.dri_age1     
        wdetail.dri_icno1    
        wdetail.dri_licen1   
        wdetail.dri_name2    
        wdetail.dri_brith2   
        wdetail.dri_age2     
        wdetail.dri_icno2     
        wdetail.dri_licen2    
        wdetail.comdat        
        wdetail.expodat       
        wdetail.brand         
        wdetail.model         
        wdetail.caryear       
        wdetail.n_vehreg      
        wdetail.cha_no        
        wdetail.eng_no        
        wdetail.ccno          
        wdetail.tons          
        wdetail.n_seat        
        wdetail.sumins        
        wdetail.premnet       
        wdetail.premtotle     
        wdetail.compnet       
        wdetail.comptotle     
        wdetail.garage        
        wdetail.accoryno      
        wdetail.accodes       
        wdetail.remark        
        wdetail.agentid       
        wdetail.vehuse        
        wdetail.poltyp        
        wdetail.nv_ppbi       
        wdetail.nv_pacc       
        wdetail.nv_papd       
        wdetail.nv_41         
        wdetail.nv_42         
        wdetail.nv_43         
        wdetail.vatcode       
        wdetail.ispno         
        wdetail.campaign      
        wdetail.benefic       
        wdetail.nv_Producer   
        wdetail.nv_Agent      
        wdetail.payment       
        wdetail.tracking      
        wdetail.promotion     
        wdetail.colorcode  .
END.
OUTPUT   CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfielre c-wins 
PROCEDURE pd_reportfielre :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN fi_outfile  =  Trim(fi_outfile) + ".csv"  .
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "สาขา"
    "เลขที่ใบคำขอ"
    "เลขที่รับแจ้ง"
    "เลขที่สติ๊กเกอร์"
    "เลขที่กรมธรรม์เดิม"
    "ประเภทความคุ้มครอง"
    "ประเภทที่แจ้งงาน"
    "คำนำหน้าชื่อผู้เอาประกันภัย"
    "ชื่อผู้เอาประกันภัย"
    "ชื่อบริษัทรถประจำตำแหน่ง"
    "Occup./อาชีพ"
    "ID/บัตรประชาชน"
    "ที่อยู่1"
    "ที่อยู่2"
    "ที่อยู่3"
    "ที่อยู่4"
    "เบอร์โทรศัพท์"
    "ชื่อที่ออกใบกำกับภาษี"
    "ที่อยู่ออกใบกำกับภาษี"
    "ชื่อ/นามสกุล1"
    "วัน/เดือน/ปีเกิด 1"
    "อายุ1"
    "เลขที่บัตรประชาชน 1"
    "เลขที่ใบขับขี่1"
    "ชื่อ/นามสกุล 2"
    "วัน/เดือน/ปีเกิด2"
    "อายุ2"
    "เลขที่บัตรประชาชน 2"
    "เลขที่ใบขับขี่2"
    "วันที่เริ่มคุ้มครอง"
    "วันที่สิ้นสุด"
    "ยี่ห้อ"
    "รุ่น "
    "ปีที่จดทะเบียน"
    "ทะเบียนรถ"
    "เลขตัวถัง"
    "เลขเครื่องยนต์"
    "ขนาดเครื่องยนต์"
    "น้ำหนัก"
    "จำนวนที่นั่ง"
    "ทุนประกัน"
    "เบี้ยสุทธิ"
    "เบี้ยรวมภาษีอากร"
    "เบี้ยพรบ"
    "เบี้ยรวมพรบ"
    "การซ่อม(0:อู่ห้าง 1:อู่ในเครือ)"
    "อุปกรณ์เสริม"
    "รายละเอียดอุปกรณ์เสริม"
    "หมายเหตุ"
    "รหัสตัวแทน"
    "ลักษณะการใช้งาน"
    "Pol_Type 70/72/74"
    "Per Person (BI)"
    "Per Accident"
    "Per Accident(PD)"
    "4.1 SI." 
    "4.2 Sum" 
    "4.3 Sum" 
    "VATCODE" 
    "ISP_NO" 
    "Campaign" 
    "Beneficiary"
    "Producer" 
    "Agent" 
    "Payment" 
    "Tracking" 
    "Promotion" 
    "color" .
FOR EACH wdetail WHERE  
    wdetail.typepol = "renew" NO-LOCK.

    EXPORT DELIMITER "|"  
        wdetail.branch       
        wdetail.appno        
        wdetail.notifyno     
        wdetail.stkno        
        wdetail.prepol       
        wdetail.cover        
        wdetail.typepol      
        wdetail.n_title      
        wdetail.n_names      
        wdetail.cardef       
        wdetail.occoup       
        wdetail.n_icno       
        wdetail.n_address1   
        wdetail.n_address2   
        wdetail.n_address3   
        wdetail.n_address4   
        wdetail.mobile       
        wdetail.reciepname   
        wdetail.reciepaddress
        wdetail.dri_name1    
        wdetail.dri_brith1   
        wdetail.dri_age1     
        wdetail.dri_icno1    
        wdetail.dri_licen1   
        wdetail.dri_name2    
        wdetail.dri_brith2   
        wdetail.dri_age2     
        wdetail.dri_icno2     
        wdetail.dri_licen2    
        wdetail.comdat        
        wdetail.expodat       
        wdetail.brand         
        wdetail.model         
        wdetail.caryear       
        wdetail.n_vehreg      
        wdetail.cha_no        
        wdetail.eng_no        
        wdetail.ccno          
        wdetail.tons          
        wdetail.n_seat        
        wdetail.sumins        
        wdetail.premnet       
        wdetail.premtotle     
        wdetail.compnet       
        wdetail.comptotle     
        wdetail.garage        
        wdetail.accoryno      
        wdetail.accodes       
        wdetail.remark        
        wdetail.agentid       
        wdetail.vehuse        
        wdetail.poltyp        
        wdetail.nv_ppbi       
        wdetail.nv_pacc       
        wdetail.nv_papd       
        wdetail.nv_41         
        wdetail.nv_42         
        wdetail.nv_43         
        wdetail.vatcode       
        wdetail.ispno         
        wdetail.campaign      
        wdetail.benefic       
        wdetail.nv_Producer   
        wdetail.nv_Agent      
        wdetail.payment       
        wdetail.tracking      
        wdetail.promotion     
        wdetail.colorcode  .
END.
OUTPUT   CLOSE.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchar c-wins 
PROCEDURE proc_cutchar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
IF wdetail.chassis <> "" THEN DO:
    nv_c = wdetail.chassis.
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
        wdetail.chassis = nv_c .
END.

IF wdetail.engine <> ""  THEN DO:
    nv_c = wdetail.engine.
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
        wdetail.engine = nv_c .

END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpol c-wins 
PROCEDURE proc_cutpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.

IF wdetail.safe_no <> ""  THEN DO:  /* 70*/
    nv_c = wdetail.safe_no.
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
        wdetail.safe_no = nv_c .
END.

IF wdetail.compno <> ""  THEN DO:  /*72*/
    nv_c = wdetail.compno.
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
        wdetail.compno = nv_c .
END.

IF wdetail.prevpol <> "" THEN DO:
    nv_c = wdetail.prevpol.
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
        wdetail.prevpol = nv_c .
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_pol72old c-wins 
PROCEDURE proc_pol72old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER         npp_cha_no  as char no-undo.                           
DEF INPUT PARAMETER         npp_vehreg  as char no-undo.
DEF INPUT-OUTPUT PARAMETER  nv_pre72    as char no-undo. 
DEF INPUT-OUTPUT PARAMETER  nv_br72    as char no-undo. 
DEF VAR nv_expidatck  AS DATE INIT ?.
ASSIGN 
    nv_pre72   = ""
    n_branch72 = "" 
    nv_expidatck = ?.

FOR EACH  sicuw.uwm301 USE-INDEX uwm30121 WHERE 
    sicuw.uwm301.cha_no = trim(npp_cha_no)   AND 
    sicuw.uwm301.tariff = "9"  NO-LOCK  .
    IF LENGTH(sicuw.uwm301.policy) > 10 THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
            sicuw.uwm100.policy = sicuw.uwm301.policy AND 
            sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND 
            sicuw.uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR .
        IF AVAIL sicuw.uwm100 THEN DO:
            IF nv_pre72 = "" THEN
                ASSIGN 
                nv_pre72 = trim(sicuw.uwm100.policy)
                nv_br72   = trim(sicuw.uwm100.branch) 
                nv_expidatck = sicuw.uwm100.expdat  .
            ELSE IF nv_expidatck < sicuw.uwm100.expdat THEN
                ASSIGN 
                nv_pre72     = trim(sicuw.uwm100.policy)
                nv_br72      = trim(sicuw.uwm100.branch)  
                nv_expidatck = sicuw.uwm100.expdat  .
        END.
    END.
END.
IF nv_pre72 = "" THEN DO:
    nv_expidatck = ? .

    FOR EACH sicuw.uwm301 USE-INDEX uwm30102 WHERE 
        sicuw.uwm301.vehreg = trim(npp_vehreg) AND 
        sicuw.uwm301.tariff = "9" NO-LOCK  .
        IF LENGTH(sicuw.uwm301.policy) > 10 THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                sicuw.uwm100.policy = sicuw.uwm301.policy  AND 
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt  AND 
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt  NO-LOCK NO-ERROR .
            IF AVAIL sicuw.uwm100 THEN DO:
                IF nv_pre72 = "" THEN
                    ASSIGN 
                    nv_pre72 = trim(sicuw.uwm100.policy)
                    nv_br72   = trim(sicuw.uwm100.branch) 
                    nv_expidatck = sicuw.uwm100.expdat  .
                ELSE IF nv_expidatck < sicuw.uwm100.expdat THEN
                    ASSIGN 
                    nv_pre72     = trim(sicuw.uwm100.policy)
                    nv_br72      = trim(sicuw.uwm100.branch)  
                    nv_expidatck = sicuw.uwm100.expdat  .
            END.
        END.
    END.
        
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uom c-wins 
PROCEDURE proc_uom :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
    sicuw.uwm100.policy = nv_prepol  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sicuw.uwm100 THEN DO:
    FIND LAST  sicuw.uwm130 USE-INDEX uwm13001      WHERE 
        sicuw.uwm130.policy  = sicuw.uwm100.policy  AND 
        sicuw.uwm130.rencnt  = sicuw.uwm100.rencnt  AND 
        sicuw.uwm130.endcnt  = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm130 THEN
        ASSIGN 
        nv_ppbi  = "0" 
        nv_pacc  = "0"
        nv_papd  = "0" 
        nv_ppbi  = string(sicuw.uwm130.uom1_v)   
        nv_pacc  = string(sicuw.uwm130.uom2_v)   
        nv_papd  = string(sicuw.uwm130.uom5_v). 
    FIND LAST sicuw.uwm301 USE-INDEX uwm30101         WHERE
        sicuw.uwm301.policy = sicuw.uwm100.policy   AND
        sicuw.uwm301.rencnt = sicuw.uwm100.rencnt   AND
        sicuw.uwm301.endcnt = sicuw.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm301 THEN DO: 
        FOR EACH sicuw.uwd132 USE-INDEX uwd13290  WHERE
            sicuw.uwd132.policy   = sicuw.uwm301.policy  AND
            sicuw.uwd132.rencnt   = sicuw.uwm301.rencnt  AND
            sicuw.uwd132.endcnt   = sicuw.uwm301.endcnt  AND
            sicuw.uwd132.riskno   = sicuw.uwm301.riskno  AND
            sicuw.uwd132.itemno   = sicuw.uwm301.itemno  NO-LOCK .
            IF sicuw.uwd132.bencod                = "411" THEN 
                ASSIGN   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่*/ 
                nv_41   = TRIM(SUBSTRING(sicuw.uwd132.benvar,31,30)).  
            ELSE IF sicuw.uwd132.bencod           = "42" THEN
                ASSIGN   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง*/   
                nv_42   =  TRIM(SUBSTRING(sicuw.uwd132.benvar,31,30)).
            ELSE IF sicuw.uwd132.bencod                = "43" THEN
                ASSIGN   /*การประกันตัวผู้ขับขี่*/ 
                nv_43   =  TRIM(SUBSTRING(sicuw.uwd132.benvar,31,30)). 
        END.
         
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
        tlt.genusr   =  "K-LEASING" NO-LOCK .
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
                             tlt.genusr   =  "ICBCTL"      no-lock.*/
    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt).   /*A57-0017*/
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

