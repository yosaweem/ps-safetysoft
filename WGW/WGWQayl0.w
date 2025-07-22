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
/* wgwqscb0.w :   Query & Update Add in table  tlt 
  Create  by :   Ranu I. A61-0573 Date 02/04/2019
  Connect    :  sicuw,sicsyac,sic_bran ,brstat  
 ----------------------------------------------------------------------*/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */ 
/* Modify by : Ranu I. A63-0448 date.14/10/2020                            */
/*            เพิ่มการแยกรายงานสาขาเอ็มไพร์ กับอรกานต์                  */
/* Modify by : Ranu I. A65-0115 เพิ่มตัวเลือก dealer code และออกในรายงาน    */ 
/*Modify by   : Ranu I. A67-0162 เพิ่มการเก็บข้อมูลรถไฟฟ้า    */
/*-------------------------------------------------------------------------*/
/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

 Def    var  nv_rectlt    as recid  init  0.
 Def    var  nv_recidtlt  as recid  init  0.
 DEFINE VAR  n_asdat      AS CHAR.
 DEFINE VAR  vAcProc_fil  AS CHAR.
 DEFINE VAR  n_asdat1     AS CHAR. /*A55-0365 */
 DEFINE VAR  vAcProc_fil1 AS CHAR. /*A55-0365 */
 DEF    VAR  nv_72Reciept AS CHAR INIT "" .
 DEFINE stream  ns2.
 DEF VAR nv_row AS INT INIT 0.  /*A60-0118*/
def var n_char        as char format "x(500)" init "" .
def var n_bdate       as char format "x(15)" init "" .
def var nv_campnam    as char format "x(50)" init "" .
def var nv_camp       as char format "x(50)" init "" .
def var nv_comnam     as char format "x(50)" init "" .
def var nv_comcod     as char format "x(50)" init "" .
def var nv_pacg       as char format "x(50)" init "" .
def var nv_pacgnam    as char format "x(50)" init "" .
def var nv_producnam  as char format "x(50)" init "" .
def var nv_produc     as char format "x(50)" init "" .
def var nv_sureng     as char format "x(50)" init "" .
def var nv_nameeng    as char format "x(50)" init "" .
def var nv_titleeng   as char format "x(50)" init "" .
def var nv_surth      as char format "x(50)" init "" .
def var nv_nameth     as char format "x(50)" init "" .
def var nv_titleth    as char format "x(50)" init "" .
def var nv_polocc     as char format "x(50)" init "" .
def var nv_polbdate   as char format "x(15)" init "" .
def var nv_sex        as char format "x(2)" init "" .
def var nv_icno       as char format "x(13)" init "" .
def var nv_line       as char format "x(50)" init "" .
def var nv_mail       as char format "x(50)" init "" .
def var nv_poltel     as char format "x(100)" init "" .
def var nv_driver     as char format ">9"    init "0" .
def var nv_driid1     as char format "x(13)" init "" .
def var nv_drisur1    as char format "x(50)" init "" .
def var nv_drinam1    as char format "x(50)" init "" .
def var nv_dridate1   as char format "x(15)" init "" .
def var nv_drisex1    as char format "x(15)" init "" .
def var nv_driocc1    as char format "x(50)" init "" .
def var nv_driid2     as char format "x(13)" init "" .
def var nv_drisur2    as char format "x(50)" init "" .
def var nv_drinam2    as char format "x(50)" init "" .
def var nv_dridate2   as char format "x(15)" init "" .
def var nv_drisex2    as char format "x(15)" init "" .
def var nv_driocc2    as char format "x(50)" init "" .
def var nv_paytyp     as char format "x(2)" init "" .
def var nv_branch     as char format "x(25)" init "" .
def var nv_paysur     as char format "x(50)" init "" .
def var nv_paynam     as char format "x(50)" init "" .
def var nv_waytyp     as char format "x(50)" init "" .
def var nv_payway     as char format "x(50)" init "" .
def var nv_paymtyp    as char format "x(50)" init "" .
def var nv_paymcod    as char format "x(50)" init "" .
def var nv_bank       as char format "x(50)" init "" .
def var nv_paidsts    as char format "x(10)" init "" .
def var nv_paysts     as char format "x(10)" init "" .
def var nv_paydat     as char format "x(10)" init "" .
def var nv_garcod     as char format "x(2)" init "" .
def var nv_garage     as char format "x(20)" init "" .
def var nv_covdetail  as char format "x(50)" init "" .
def var nv_subcover   as char format "x(50)" init "" .
def var nv_cover      as char format "x(50)" init "" .
def var nv_covcod     as char format "x(50)" init "" .
def var nv_covtyp     as char format "x(50)" init "" .
def var nv_stamp      as char format ">>>,>>>.>9" init "0.00" .
def var nv_vat        as char format ">>>,>>>.>9" init "0.00" .
def var nv_feeltp     as char format ">>>.>9"     init "0.00" .
def var nv_feelt      as char format ">>>,>>>,>9" init "0.00" .
def var nv_ncbp       as char format ">>>.>9"     init "0.00" .
def var nv_ncb        as char format ">>>,>>>,>9" init "0.00" .
def var nv_drip       as char format ">>>.>9"     init "0.00" .
def var nv_dridis     as char format ">>>,>>>,>9" init "0.00" .
def var nv_oth        as char format ">>>.>9"     init "0.00" .
def var nv_othdis     as char format ">>>,>>>,>9" init "0.00" .
def var nv_cctvp      as char format ">>>.>9"     init "0.00" .
def var nv_cctv       as char format ">>>,>>>,>9" init "0.00" .
def var nv_discdetail as char format ">>>.>9"     init "0.00" .
def var nv_discp      as char format ">>>,>>>,>9" init "0.00" .
def var nv_disc       as char format "x(100)" init "" .
DEF VAR nv_province   AS CHAR FORMAT "x(35)" INIT "" .
def var nv_accpric5   as char format ">,>>>,>>>,>9" init "0.00" .
def var nv_accdet5    as char format "x(100)" init "" .
def var nv_accr5      as char format "x(100)" init "" .
def var nv_accpric4   as char format ">,>>>,>>>,>9" init "0.00" .  
def var nv_accdet4    as char format "x(100)" init "" .
def var nv_accr4      as char format "x(100)" init "" .
def var nv_accpric3   as char format ">,>>>,>>>,>9" init "0.00" .  
def var nv_accdet3    as char format "x(100)" init "" .
def var nv_accr3      as char format "x(100)" init "" .
def var nv_accpric2   as char format ">,>>>,>>>,>9" init "0.00" .  
def var nv_accdet2    as char format "x(100)" init "" .
def var nv_accr2      as char format "x(100)" init "" .
def var nv_accpric1   as char format ">,>>>,>>>,>9" init "0.00" .  
def var nv_accdet1    as char format "x(100)" init "" .
def var nv_accr1      as char format "x(100)" init "" .
def var nv_inspres    as char format "x(50)" init "" .
def var nv_inspdet    as char format "x(250)" init "" .
def var nv_brocod     as char format "x(12)" init "" .
def var nv_bronam     as char format "x(70)" init "" .
def var nv_brolincen  as char format "x(20)" init "" .
def var nv_remark     as char format "x(500)" init "" .
def var nv_gift       as char format "x(100)" init "" .
def var nv_remarksend as char format "x(100)" init "" .
def var nv_polsend    as char format "x(100)" init "" .
def var nv_lang       as char format "x(20)" init "" .
def var nv_inspno     as char FORMAT "x(20)" INIT "" .
def var nv_insresult  as char FORMAT "x(250)" INIT "".
DEF VAR nv_output     AS CHAR FORMAT "x(100)" INIT "" .

DEFINE NEW SHARED TEMP-TABLE winsp NO-UNDO
    FIELD RefNo           AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD CusCode         AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD cusName         AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD Surname         AS CHAR FORMAT "x(50)"  INIT ""                       
    FIELD Licence         AS CHAR FORMAT "X(50)"  INIT ""  
    FIELD Chassis         AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD Insp_date       AS CHAR FORMAT "X(15)"  INIT ""  
    FIELD Insp_Code       AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD Insp_Result     AS CHAR FORMAT "X(30)"  INIT ""  
    FIELD Insp_Detail     AS CHAR FORMAT "X(700)" INIT ""  
    FIELD Insp_Remark1    AS CHAR FORMAT "X(700)" INIT ""  
    FIELD Insp_Remark2    AS CHAR FORMAT "X(700)" INIT ""
    FIELD insp_status     AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD insp_no         AS CHAR FORMAT "x(20)"  INIT ""
    FIELD insp_damage     as CHAR format "x(1000)" INIT ""
    FIELD insp_driver     as CHAR format "x(500)" INIT ""
    FIELD Insp_other      as CHAR format "x(500)" INIT ""
    FIELD province        AS CHAR FORMAT "x(3)" INIT "" 
    FIELD br              AS CHAR FORMAT "x(15)" INIT "" . /*a63-0448*/
def var n_record  as int init 0.
def var nv_cnt    as int init 0.
DEF VAR np_title     AS CHAR FORMAT "x(30)"     INIT "" .
DEF VAR np_name      AS CHAR FORMAT "x(40)"     INIT "" .
DEF VAR np_name2     AS CHAR FORMAT "x(40)"     INIT "" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_detail

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_detail                                     */
&Scoped-define FIELDS-IN-QUERY-br_detail tlt.releas tlt.enttim tlt.cha_no ~
tlt.old_cha tlt.nor_noti_ins tlt.rec_addr5 tlt.ins_name tlt.rec_addr3 ~
tlt.nor_coamt 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_detail 
&Scoped-define QUERY-STRING-br_detail FOR EACH tlt NO-LOCK
&Scoped-define OPEN-QUERY-br_detail OPEN QUERY br_detail FOR EACH tlt NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_detail tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_detail tlt


/* Definitions for BROWSE br_tlt                                        */
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas tlt.flag ~
IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN  (tlt.ins_addr1)  ELSE  IF (tlt.flag = "INSPEC" ) THEN (tlt.enttim)  ELSE (tlt.imp) ~
IF (tlt.flag = "INSPEC") THEN (tlt.stat) ELSE  IF (tlt.flag = "V70" OR tlt.flag = "V72") THEN (tlt.policy) ELSE (tlt.comp_pol) ~
IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN  (tlt.nor_noti_ins)  ELSE  IF (tlt.flag = "INSPEC") THEN (tlt.nor_noti_ins)  ELSE (tlt.nor_noti_tlt) ~
IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN   (substr(tlt.ins_name,index(tlt.ins_name,":") + 1 ))  ELSE (tlt.ins_name) ~
tlt.lince1 tlt.cha_no ~
IF (tlt.flag = "V70" OR tlt.flag = "V72"  OR tlt.flag = "INSPEC"  ) THEN (tlt.gendat) ELSE (tlt.nor_effdat) ~
tlt.expodat ~
IF (tlt.flag = "V70" or tlt.flag = "V72" or tlt.flag = "INSPCE") THEN (tlt.nor_coamt) else (tlt.comp_coamt) ~
IF (tlt.flag = "V70" or tlt.flag = "V72" or tlt.flag = "INSPCE") THEN tlt.comp_grprm  ELSE  deci(dri_name2) ~
IF (tlt.flag = "V70" or tlt.flag = "V72" or tlt.flag = "INSPCE") THEN tlt.comp_coamt ELSE  (tlt.nor_grprm) ~
IF (tlt.flag = "V70" or tlt.flag = "V72" or tlt.flag = "INSPCE") THEN tlt.nor_noti_tlt  ELSE  (tlt.old_cha) ~
IF (tlt.flag <> "INSPEC" ) THEN ?  ELSE tlt.datesent tlt.subins 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_detail rs_br tg_file ra_typfile rs_type ~
ra_status fi_trndatfr fi_trndatto bu_ok cb_search bu_oksch br_tlt fi_search ~
bu_update cb_report fi_outfile bu_report bu_exit bu_upyesno fi_datare ~
RECT-332 RECT-338 RECT-339 RECT-341 RECT-386 
&Scoped-Define DISPLAYED-OBJECTS rs_br tg_file ra_typfile rs_type ra_status ~
fi_trndatfr fi_trndatto cb_search fi_search fi_name cb_report fi_outfile ~
fi_datare 

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
     SIZE 7 BY 1.52
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
     SIZE 36.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
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
     SIZE 50.83 BY .95
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
     SIZE 28.5 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE ra_typfile AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "ไฟล์แบบเก่า", 1,
"ไฟล์แบบใหม่", 2
     SIZE 15.17 BY 2
     BGCOLOR 29 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE rs_br AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "All", 1,
"Empire", 2,
"Orakan", 3
     SIZE 26.17 BY 1 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ข้อมูลการแจ้งงาน", 1,
"ข้อมูลตรวจสภาพ", 2,
"ข้อมูลบัตรเครดิต", 3
     SIZE 63 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.67 BY 23.81
     BGCOLOR 18 FGCOLOR 1 .

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

DEFINE VARIABLE tg_file AS LOGICAL INITIAL no 
     LABEL "ไฟล์ผลการตัดบัตรเครดิต" 
     VIEW-AS TOGGLE-BOX
     SIZE 23 BY .81
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_detail FOR 
      tlt SCROLLING.

DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_detail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_detail c-wins _STRUCTURED
  QUERY br_detail NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "status" FORMAT "X(5)":U
      tlt.enttim COLUMN-LABEL "BR" FORMAT "x(5)":U
      tlt.cha_no COLUMN-LABEL "เลขที่อ้างอิง" FORMAT "x(20)":U
            WIDTH 17.33
      tlt.old_cha COLUMN-LABEL "ธนาคารของบัตร" FORMAT "x(50)":U
            WIDTH 21.67
      tlt.nor_noti_ins COLUMN-LABEL "หมายเลขการชำระ" FORMAT "x(25)":U
            WIDTH 15.5
      tlt.rec_addr5 COLUMN-LABEL "ประเภทการชำระ" FORMAT "x(30)":U
            WIDTH 25.83
      tlt.ins_name COLUMN-LABEL "วิธีชำระ" FORMAT "x(50)":U WIDTH 35.33
      tlt.rec_addr3 COLUMN-LABEL "ชื่อผู้ถือบัตร" FORMAT "x(50)":U
            WIDTH 26.83
      tlt.nor_coamt COLUMN-LABEL "ยอดชำระ" FORMAT "->,>>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.5 BY 13.95
         BGCOLOR 15 FGCOLOR 2  ROW-HEIGHT-CHARS .62.

DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "Status" FORMAT "x(15)":U WIDTH 7.17
      tlt.flag COLUMN-LABEL "Poltype" FORMAT "X(3)":U
      IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN  (tlt.ins_addr1)  ELSE  IF (tlt.flag = "INSPEC" ) THEN (tlt.enttim)  ELSE (tlt.imp) COLUMN-LABEL "BR" FORMAT "X(4)":U
            WIDTH 4.33
      IF (tlt.flag = "INSPEC") THEN (tlt.stat) ELSE  IF (tlt.flag = "V70" OR tlt.flag = "V72") THEN (tlt.policy) ELSE (tlt.comp_pol) COLUMN-LABEL "Send/Poicy" FORMAT "X(12)":U
            WIDTH 14.33
      IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN  (tlt.nor_noti_ins)  ELSE  IF (tlt.flag = "INSPEC") THEN (tlt.nor_noti_ins)  ELSE (tlt.nor_noti_tlt) COLUMN-LABEL "เลขรับแจ้ง" FORMAT "X(20)":U
            WIDTH 14.17
      IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN   (substr(tlt.ins_name,index(tlt.ins_name,":") + 1 ))  ELSE (tlt.ins_name) COLUMN-LABEL "ชื่อ - สกุล" FORMAT "X(50)":U
            WIDTH 21.33
      tlt.lince1 COLUMN-LABEL "ทะเบียน" FORMAT "x(12)":U
      tlt.cha_no FORMAT "x(20)":U WIDTH 20.17
      IF (tlt.flag = "V70" OR tlt.flag = "V72"  OR tlt.flag = "INSPEC"  ) THEN (tlt.gendat) ELSE (tlt.nor_effdat) COLUMN-LABEL "วันที่คุ้มครอง" FORMAT "99/99/9999":U
      tlt.expodat COLUMN-LABEL "วันสิ้นสุด" FORMAT "99/99/9999":U
            WIDTH 9.5
      IF (tlt.flag = "V70" or tlt.flag = "V72" or tlt.flag = "INSPCE") THEN (tlt.nor_coamt) else (tlt.comp_coamt) COLUMN-LABEL "ทุนประกัน" FORMAT "->>,>>>,>>9":U
      IF (tlt.flag = "V70" or tlt.flag = "V72" or tlt.flag = "INSPCE") THEN tlt.comp_grprm  ELSE  deci(dri_name2) COLUMN-LABEL "เบี้ยสุทธิ" FORMAT "->>,>>>,>>9.99":U
      IF (tlt.flag = "V70" or tlt.flag = "V72" or tlt.flag = "INSPCE") THEN tlt.comp_coamt ELSE  (tlt.nor_grprm) COLUMN-LABEL "เบี้ยรวม" FORMAT ">,>>>,>>9.99":U
      IF (tlt.flag = "V70" or tlt.flag = "V72" or tlt.flag = "INSPCE") THEN tlt.nor_noti_tlt  ELSE  (tlt.old_cha) COLUMN-LABEL "หมายเหตุ" FORMAT "X(100)":U
            WIDTH 39.67
      IF (tlt.flag <> "INSPEC" ) THEN ?  ELSE tlt.datesent COLUMN-LABEL "วันที่ส่งข้อมูลกลับ" FORMAT "99/99/9999":U
      tlt.subins COLUMN-LABEL "Producer code" FORMAT "x(10)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.67 BY 14
         BGCOLOR 15 FONT 1 ROW-HEIGHT-CHARS .62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_detail AT ROW 10.38 COL 2.5 WIDGET-ID 100
     rs_br AT ROW 7.71 COL 105.17 NO-LABEL WIDGET-ID 12
     tg_file AT ROW 8.91 COL 108 WIDGET-ID 6
     ra_typfile AT ROW 2.33 COL 92.67 NO-LABEL WIDGET-ID 2
     rs_type AT ROW 2.33 COL 27.5 NO-LABEL
     ra_status AT ROW 8.81 COL 10.83 NO-LABEL
     fi_trndatfr AT ROW 3.52 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 3.52 COL 62.17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 2.91 COL 111.83
     cb_search AT ROW 5.05 COL 17.5 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 6.19 COL 54.67
     br_tlt AT ROW 10.29 COL 2.67
     fi_search AT ROW 6.14 COL 4.33 NO-LABEL
     fi_name AT ROW 6.05 COL 60.67 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 5.95 COL 102.5
     cb_report AT ROW 7.67 COL 13.67 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 8.81 COL 49 NO-LABEL
     bu_report AT ROW 8.86 COL 100
     bu_exit AT ROW 3.1 COL 121.67
     bu_upyesno AT ROW 5.95 COL 117.67
     fi_datare AT ROW 7.71 COL 66.5 NO-LABEL
     "Click for update Flag Cancel":40 VIEW-AS TEXT
          SIZE 29.5 BY .95 AT ROW 5 COL 63
          BGCOLOR 10 FGCOLOR 6 FONT 6
     "    วันที่แจ้งงาน From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 3.52 COL 5
          BGCOLOR 19 FONT 6
     "Branch:" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 7.71 COL 96.5 WIDGET-ID 20
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " Search Data :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 5.05 COL 4.33
          BGCOLOR 21 FGCOLOR 2 FONT 6
     "Export Type :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 7.67 COL 2.67
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Query Data AYCAL" VIEW-AS TEXT
          SIZE 19.5 BY .62 AT ROW 1.43 COL 61.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Report Data :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 7.71 COL 53.17
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Status :" VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 8.76 COL 3
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 3.52 COL 57.33
          BGCOLOR 19 FONT 6
     "Output :" VIEW-AS TEXT
          SIZE 8.33 BY .95 AT ROW 8.81 COL 40.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "           ประเภทข้อมูล :" VIEW-AS TEXT
          SIZE 21.67 BY 1 AT ROW 2.33 COL 4.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     RECT-332 AT ROW 1 COL 1
     RECT-338 AT ROW 4.81 COL 2.17
     RECT-339 AT ROW 4.81 COL 61.5
     RECT-341 AT ROW 2.76 COL 120
     RECT-386 AT ROW 7.43 COL 2.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 19 FGCOLOR 0 .


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
         TITLE              = "Query && Update [AYCAL]"
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
/* BROWSE-TAB br_detail 1 fr_main */
/* BROWSE-TAB br_tlt bu_oksch fr_main */
ASSIGN 
       br_detail:SEPARATOR-FGCOLOR IN FRAME fr_main      = 20.

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

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_detail
/* Query rebuild information for BROWSE br_detail
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" "status" "X(5)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.enttim
"tlt.enttim" "BR" "x(5)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.cha_no
"tlt.cha_no" "เลขที่อ้างอิง" ? "character" ? ? ? ? ? ? no ? no no "17.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.old_cha
"tlt.old_cha" "ธนาคารของบัตร" "x(50)" "character" ? ? ? ? ? ? no ? no no "21.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "หมายเลขการชำระ" ? "character" ? ? ? ? ? ? no ? no no "15.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.rec_addr5
"tlt.rec_addr5" "ประเภทการชำระ" "x(30)" "character" ? ? ? ? ? ? no ? no no "25.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.ins_name
"tlt.ins_name" "วิธีชำระ" ? "character" ? ? ? ? ? ? no ? no no "35.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.rec_addr3
"tlt.rec_addr3" "ชื่อผู้ถือบัตร" "x(50)" "character" ? ? ? ? ? ? no ? no no "26.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "ยอดชำระ" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_detail */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_tlt
/* Query rebuild information for BROWSE br_tlt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" "Status" "x(15)" "character" ? ? ? ? ? ? no ? no no "7.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.flag
"tlt.flag" "Poltype" "X(3)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"IF (tlt.flag = ""V70""  OR  tlt.flag = ""V72"") THEN  (tlt.ins_addr1)  ELSE  IF (tlt.flag = ""INSPEC"" ) THEN (tlt.enttim)  ELSE (tlt.imp)" "BR" "X(4)" ? ? ? ? ? ? ? no ? no no "4.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > "_<CALC>"
"IF (tlt.flag = ""INSPEC"") THEN (tlt.stat) ELSE  IF (tlt.flag = ""V70"" OR tlt.flag = ""V72"") THEN (tlt.policy) ELSE (tlt.comp_pol)" "Send/Poicy" "X(12)" ? ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > "_<CALC>"
"IF (tlt.flag = ""V70""  OR  tlt.flag = ""V72"") THEN  (tlt.nor_noti_ins)  ELSE  IF (tlt.flag = ""INSPEC"") THEN (tlt.nor_noti_ins)  ELSE (tlt.nor_noti_tlt)" "เลขรับแจ้ง" "X(20)" ? ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > "_<CALC>"
"IF (tlt.flag = ""V70""  OR  tlt.flag = ""V72"") THEN   (substr(tlt.ins_name,index(tlt.ins_name,"":"") + 1 ))  ELSE (tlt.ins_name)" "ชื่อ - สกุล" "X(50)" ? ? ? ? ? ? ? no ? no no "21.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.lince1
"tlt.lince1" "ทะเบียน" "x(12)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.cha_no
"tlt.cha_no" ? ? "character" ? ? ? ? ? ? no ? no no "20.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > "_<CALC>"
"IF (tlt.flag = ""V70"" OR tlt.flag = ""V72""  OR tlt.flag = ""INSPEC""  ) THEN (tlt.gendat) ELSE (tlt.nor_effdat)" "วันที่คุ้มครอง" "99/99/9999" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.expodat
"tlt.expodat" "วันสิ้นสุด" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "9.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > "_<CALC>"
"IF (tlt.flag = ""V70"" or tlt.flag = ""V72"" or tlt.flag = ""INSPCE"") THEN (tlt.nor_coamt) else (tlt.comp_coamt)" "ทุนประกัน" "->>,>>>,>>9" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > "_<CALC>"
"IF (tlt.flag = ""V70"" or tlt.flag = ""V72"" or tlt.flag = ""INSPCE"") THEN tlt.comp_grprm  ELSE  deci(dri_name2)" "เบี้ยสุทธิ" "->>,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > "_<CALC>"
"IF (tlt.flag = ""V70"" or tlt.flag = ""V72"" or tlt.flag = ""INSPCE"") THEN tlt.comp_coamt ELSE  (tlt.nor_grprm)" "เบี้ยรวม" ">,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > "_<CALC>"
"IF (tlt.flag = ""V70"" or tlt.flag = ""V72"" or tlt.flag = ""INSPCE"") THEN tlt.nor_noti_tlt  ELSE  (tlt.old_cha)" "หมายเหตุ" "X(100)" ? ? ? ? ? ? ? no ? no no "39.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > "_<CALC>"
"IF (tlt.flag <> ""INSPEC"" ) THEN ?  ELSE tlt.datesent" "วันที่ส่งข้อมูลกลับ" "99/99/9999" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > brstat.tlt.subins
"tlt.subins" "Producer code" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [AYCAL] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [AYCAL] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_detail
&Scoped-define SELF-NAME br_detail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_detail c-wins
ON LEFT-MOUSE-DBLCLICK OF br_detail IN FRAME fr_main
DO:
    IF rs_type = 3 THEN DO:
        Get Current br_detail.
              nv_recidtlt  =  Recid(tlt).
        
        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqpaym(Input  nv_recidtlt).
        
        {&WINDOW-NAME}:hidden  =  No. 

    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_detail c-wins
ON MOUSE-SELECT-CLICK OF br_detail IN FRAME fr_main
DO:
    Get  current  br_detail.
     nv_rectlt =  recid(tlt).
     IF tlt.flag = "Payment"  THEN 
         ASSIGN fi_name = TRIM(tlt.cha_no) .
     disp  fi_name  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_detail c-wins
ON VALUE-CHANGED OF br_detail IN FRAME fr_main
DO:
    Get  current  br_detail.
     nv_rectlt =  recid(tlt).
     IF tlt.flag = "Payment"  THEN 
         ASSIGN fi_name = TRIM(tlt.cha_no) .
     disp  fi_name  with frame  fr_main.
  
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
        
        IF ra_typfile = 2 THEN Run wgw\wgwqay11(Input  nv_recidtlt).
        ELSE Run wgw\wgwquay2(Input  nv_recidtlt).
        
        {&WINDOW-NAME}:hidden  =  No. 
    END.
    ELSE IF rs_type = 2 THEN DO:
        Get Current br_tlt.
              nv_recidtlt  =  Recid(tlt).
        
        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqayins(Input  nv_recidtlt).
        
        {&WINDOW-NAME}:hidden  =  No. 
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON MOUSE-SELECT-CLICK OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN 
         ASSIGN fi_name = (substr(tlt.ins_name,index(tlt.ins_name,":") + 1 /*,index(tlt.ins_name,"NameEng") - 9 */ )). 
     ELSE ASSIGN fi_name = TRIM(tlt.ins_name) .
     disp  fi_name  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN 
         ASSIGN fi_name = (substr(tlt.ins_name,index(tlt.ins_name,":") + 1 /*,index(tlt.ins_name,"NameEng") - 9*/ )). 
     ELSE ASSIGN fi_name = TRIM(tlt.ins_name) .
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

        DISP br_tlt WITH FRAME fr_main.
        HIDE br_detail.

        IF ra_typfile = 2 THEN DO:
            Open Query br_tlt 
             For each tlt Use-index  tlt01  Where
             tlt.trndat  >=   fi_trndatfr   And
             tlt.trndat  <=   fi_trndatto   And
             tlt.genusr   =  "AYCAL"        AND
             (tlt.flag    =   "V70"         OR
             tlt.flag     =   "V72" )      no-lock.  
                 nv_rectlt =  recid(tlt).   
                 Apply "Entry"  to br_tlt.
                 Return no-apply. 
        END.
        ELSE DO:
            Open Query br_tlt 
             For each tlt Use-index  tlt01  Where
             tlt.trndat  >=   fi_trndatfr   And
             tlt.trndat  <=   fi_trndatto   AND 
             tlt.genusr   =  "AYCAL"        AND
             (tlt.flag   <>   "V70"         AND
             tlt.flag    <>   "V72"         AND
             tlt.flag    <>   "INSPEC"      AND
             tlt.flag    <>   "Payment" )   no-lock.  
                 nv_rectlt =  recid(tlt).   
                 Apply "Entry"  to br_tlt.
                 Return no-apply. 
        END.
    END.
    ELSE IF rs_type = 2 THEN DO:

        DISP br_tlt WITH FRAME fr_main.
        HIDE br_detail.

        Open Query br_tlt 
         For each tlt Use-index  tlt01  Where
         tlt.trndat  >=   fi_trndatfr   And
         tlt.trndat  <=   fi_trndatto   And
         tlt.flag     =   "INSPEC"      AND
         tlt.genusr   =   "AYCAL"        no-lock.  
             nv_rectlt =  recid(tlt).   
             Apply "Entry"  to br_tlt.
             Return no-apply. 
    END.
    ELSE IF rs_type = 3 THEN DO:

        DISP br_detail WITH FRAME fr_main.
        HIDE br_tlt.
        
        Open Query br_detail 
         For each tlt Use-index  tlt01  Where
         tlt.trndat  >=   fi_trndatfr   And
         tlt.trndat  <=   fi_trndatto   And
         tlt.flag     =   "Payment"      AND
         tlt.genusr   =   "AYCAL"        no-lock.  
             nv_rectlt =  recid(tlt).   
             Apply "Entry"  to br_tlt.
             Return no-apply. 
        END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_oksch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_oksch c-wins
ON CHOOSE OF bu_oksch IN FRAME fr_main /* OK */
DO:
    Disp fi_search  with frame fr_main.
    IF rs_type <> 3  THEN DO:
        If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
            Open Query br_tlt                                                        
                For each tlt Use-index  tlt01      Where                                     
                tlt.trndat  >=  fi_trndatfr        And                                            
                tlt.trndat  <=  fi_trndatto        And  
                tlt.genusr   =  "AYCAL"            And
                index(tlt.ins_name,fi_search) <> 0 NO-LOCK .  
                IF rs_type = 1 THEN DO: 
                  IF tlt.flag = "INSPEC" THEN NEXT. 
                  IF ra_typfile = 1 THEN DO:
                      IF tlt.flag = "V70" THEN NEXT.
                      IF tlt.flag = "V72" THEN NEXT. 
                  END.
                  ELSE DO:
                      IF tlt.flag <> "V70" THEN NEXT.
                      IF tlt.flag <> "V72"  THEN NEXT.
                  END.
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
                END.
                ELSE DO: 
                  IF tlt.flag <> "INSPEC" THEN NEXT. 
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
                END.
        END.
        ELSE If  cb_search  =  "เบอร์กรมธรรม์ใหม่"  Then do:   /* policy */
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "AYCAL"      And
                index(tlt.policy,fi_search) <> 0  no-lock.

                IF rs_type = 1 THEN DO: 
                  IF tlt.flag = "INSPEC" THEN NEXT. 
                  IF ra_typfile = 1 THEN DO:
                      IF tlt.flag = "V70" THEN NEXT.
                      IF tlt.flag = "V72" THEN NEXT. 
                  END.
                  ELSE DO:
                      IF tlt.flag <> "V70" THEN NEXT.
                      IF tlt.flag <> "V72" THEN NEXT. 
                  END.
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
                END.
                ELSE DO: 
                  IF tlt.flag <> "INSPEC" THEN NEXT. 
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
                END.
        END.
        ELSE If  cb_search  =  "เบอร์กรมธรรม์เดิม"  Then do:   /* policy */
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "AYCAL"      And
                index(tlt.imp,fi_search) <> 0 OR
                index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.

                IF rs_type = 1 THEN DO: 
                  IF tlt.flag = "INSPEC" THEN NEXT. 
                  IF ra_typfile = 1 THEN DO:
                      IF tlt.flag = "V70" THEN NEXT.
                      IF tlt.flag = "V72" THEN NEXT. 
                  END.
                  ELSE DO:
                      IF tlt.flag <> "V70" THEN NEXT.
                      IF tlt.flag <> "V72" THEN NEXT. 
                  END.
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
                END.
                ELSE DO: 
                  IF tlt.flag <> "INSPEC" THEN NEXT. 
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
                tlt.genusr   =  "AYCAL"       And
                INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                IF rs_type = 1 THEN DO: 
                  IF tlt.flag = "INSPEC" THEN NEXT. 

                  IF ra_typfile = 1 THEN DO:
                      IF tlt.flag = "V70" THEN NEXT.
                      IF tlt.flag = "V72" THEN NEXT. 
                  END.
                  ELSE DO:
                      IF tlt.flag <> "V70" THEN NEXT.
                      IF tlt.flag <> "V72" THEN NEXT. 
                  END.
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
                END.
                ELSE DO: 
                  IF tlt.flag <> "INSPEC" THEN NEXT. 
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
                END.           
        END.
        /* add : a65-0115 */
        ELSE IF cb_search = "Producer code" THEN DO:
            Open Query br_tlt
            For each tlt Use-index  tlt06 Where
             tlt.trndat >=  fi_trndatfr    And
             tlt.trndat <=  fi_trndatto    AND 
             tlt.genusr   =  "AYCAL"       And
             INDEX(tlt.subin,trim(fi_search)) <> 0  no-lock.
             IF rs_type = 1 THEN DO: 
               IF tlt.flag = "INSPEC" THEN NEXT. 
         
               IF ra_typfile = 1 THEN DO:
                   IF tlt.flag = "V70" THEN NEXT.
                   IF tlt.flag = "V72" THEN NEXT. 
               END.
               ELSE DO:
                   IF tlt.flag <> "V70" THEN NEXT.
                   IF tlt.flag <> "V72" THEN NEXT. 
               END.
               ASSIGN nv_rectlt =  recid(tlt) .  
               Apply "Entry"  to br_tlt.
               Return no-apply.
             END.
             ELSE DO: 
               IF tlt.flag <> "INSPEC" THEN NEXT. 
               ASSIGN nv_rectlt =  recid(tlt) .  
               Apply "Entry"  to br_tlt.
               Return no-apply.
             END.  
        END.
        /* end A65-0115 */
        ELSE If  cb_search  =  "Status_yes"  Then do:   /* Confirm yes..*/
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat >=  fi_trndatfr     And
                tlt.trndat <=  fi_trndatto     And
                tlt.genusr   =  "AYCAL"        And
                INDEX(tlt.releas,"yes") <> 0   no-lock.

                IF rs_type = 1 THEN DO: 
                  IF tlt.flag = "INSPEC" THEN NEXT. 
                  IF ra_typfile = 1 THEN DO:
                      IF tlt.flag = "V70" THEN NEXT.
                      IF tlt.flag = "V72" THEN NEXT. 
                  END.
                  ELSE DO:
                      IF tlt.flag <>  "V70" THEN NEXT.
                      IF tlt.flag <>  "V72" THEN NEXT. 
                  END.
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
                END.
                ELSE DO: 
                  IF tlt.flag <> "INSPEC" THEN NEXT. 
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
                tlt.genusr   =  "AYCAL"         And
                INDEX(tlt.releas,"no") <> 0     no-lock.

                IF rs_type = 1 THEN DO: 
                  IF tlt.flag = "INSPEC" THEN NEXT. 
                  IF ra_typfile = 1 THEN DO:
                      IF tlt.flag = "V70" THEN NEXT.
                      IF tlt.flag = "V72" THEN NEXT. 
                  END.
                  ELSE DO:
                      IF tlt.flag <>  "V70" THEN NEXT.
                      IF tlt.flag <>  "V72" THEN NEXT.  
                  END.
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
                END.
                ELSE DO: 
                  IF tlt.flag <> "INSPEC" THEN NEXT. 
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
                tlt.genusr   =  "AYCAL"        And
                index(tlt.releas,"CA") > 0     no-lock.
                IF rs_type = 1 THEN DO: 
                  IF tlt.flag = "INSPEC" THEN NEXT. 
                  IF ra_typfile = 1 THEN DO:
                      IF tlt.flag = "V70" THEN NEXT.
                      IF tlt.flag = "V72" THEN NEXT. 
                  END.
                  ELSE DO:
                      IF tlt.flag <> "V70" THEN NEXT.
                      IF tlt.flag <> "V72" THEN NEXT. 
                  END.
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
                END.
                ELSE DO: 
                  IF tlt.flag <> "INSPEC" THEN NEXT. 
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
                END.                                
        END.
        /* A65-0115 */
        ELSE If  cb_search  = "Producer code"  Then do:  /* producer code */
            RUN proc_query02.
        END.
         /* end : A65-0115 */
        Else  do:
            ASSIGN nv_rectlt =  recid(tlt) . 
            Apply "Entry"  to  fi_search.
            Return no-apply.
        END.
    END.
    ELSE DO:
        If  cb_search = "X-Refno"  Then do:              /* name  */                          
            Open Query br_tlt                                                        
                For each tlt Use-index  tlt01      Where                                     
                tlt.trndat  >=  fi_trndatfr        And                                            
                tlt.trndat  <=  fi_trndatto        And
                tlt.flag     = "Payment"           AND
                tlt.genusr   =  "AYCAL"            And
                index(brstat.tlt.cha_no,fi_search) <> 0 no-lock. 
                
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
        END.
        ELSE If  cb_search = "Payment No"  Then do:              /* name  */                          
            Open Query br_tlt                                                        
                For each tlt Use-index  tlt01      Where                                     
                tlt.trndat  >=  fi_trndatfr        And                                            
                tlt.trndat  <=  fi_trndatto        And
                tlt.flag     = "Payment"           AND
                tlt.genusr   =  "AYCAL"            And
                index(brstat.tlt.nor_noti_ins,fi_search) <> 0 no-lock. 
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
        END.
        ELSE If  cb_search = "Crad no"  Then do:              /* name  */                          
            Open Query br_tlt                                                        
                For each tlt Use-index  tlt01      Where                                     
                tlt.trndat  >=  fi_trndatfr        And                                            
                tlt.trndat  <=  fi_trndatto        And
                tlt.flag     = "Payment"           AND
                tlt.genusr   =  "AYCAL"            And
                index(brstat.tlt.rec_name,fi_search) <> 0 no-lock. 
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
        END.
        ELSE If  cb_search = "Crad Name"  Then do:              /* name  */                          
            Open Query br_tlt                                                        
                For each tlt Use-index  tlt01      Where                                     
                tlt.trndat  >=  fi_trndatfr        And                                            
                tlt.trndat  <=  fi_trndatto        And
                tlt.flag     = "Payment"           AND
                tlt.genusr   =  "AYCAL"            And
                index(brstat.tlt.rec_addr3,fi_search) <> 0 no-lock. 
                
                  ASSIGN nv_rectlt =  recid(tlt) .  
                  Apply "Entry"  to br_tlt.
                  Return no-apply.
        END.
        ELSE If  cb_search = "Due Date"  Then do:              /* name  */                          
          Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And
            tlt.flag     = "Payment"           AND
            tlt.genusr   =  "AYCAL"            And
            tlt.gendat   = DATE(fi_search)   no-lock. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
        END.
        ELSE If  cb_search = "Payment Date"  Then do:              /* name  */                          
          Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And
            tlt.flag     = "Payment"           AND
            tlt.genusr   =  "AYCAL"            And
            brstat.tlt.datesent   = DATE(fi_search)   no-lock. 
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
        END.
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
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE DO:
        IF rs_type = 1 THEN DO: 
            IF ra_typfile = 1 THEN RUN pd_reportnoti_old.
            ELSE RUN pd_reportnotify .
        END.
        ELSE IF rs_type = 2 THEN RUN pd_reportinsp.
        ELSE DO:
             IF tg_file = YES THEN RUN pd_resultpayment.
             ELSE RUN pd_reportpayment .
        END.
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
        If  index(tlt.releas,"CA")  =  0  Then do:
            message "ยกเลิกข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "CA" .
            ELSE tlt.releas  =  "CA/" + tlt.releas .
        END.
        Else do:
            message "เรียกข้อมูลกลับมาใช้งาน "  View-as alert-box.
            IF index(tlt.releas,"CA/")  =  0 THEN
                tlt.releas = substr(tlt.releas,index(tlt.releas,"CA") + 7 )   .
            ELSE 
                tlt.releas = TRIM(REPLACE(tlt.releas,"CA/","")).
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply.  
END.

      /*  If  index(tlt.releas,"CA") = 0 THEN DO: 
        ASSIGN tlt.releas =  "CA" + tlt.releas .
            message "ยกเลิกข้อมูลรายการนี้  " tlt.releas  /*FORMAT "x(20)" */
                View-as alert-box.
            

    END.
    ELSE IF index(tlt.releas,"CA") <> 0   THEN DO:
        DISP tlt.releas  FORMAT "x(20)"  index(tlt.releas,"CA").
        tlt.releas =  substr(tlt.releas,INDEX(tlt.releas,"CA") + 6 ) + "/YES".
        DISP tlt.releas  FORMAT "x(20)"  index(tlt.releas,"CA").
    END.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_upyesno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upyesno c-wins
ON CHOOSE OF bu_upyesno IN FRAME fr_main /* YES/NO */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt.
    If  avail tlt Then do:
        If  index(tlt.releas,"NO")  =  0  Then do:  /* yes */
            message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "NO" .
            ELSE IF index(tlt.releas,"CA/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "CA/NO" .
            ELSE ASSIGN tlt.releas  =  "NO" .
        END.
        Else do:    /* no */
            If  index(tlt.releas,"YES")  =  0  Then do:  /* yes */
            message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "YES" .
            ELSE IF index(tlt.releas,"CA/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "CA/YES" .
            ELSE ASSIGN tlt.releas  =  "YES" .
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
    /*If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01  Where                                     
            tlt.trndat  >=  fi_trndatfr         And                                            
            tlt.trndat  <=  fi_trndatto         And  
            tlt.genusr   =  "AYCAL"             And
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
            tlt.genusr    =  "AYCAL"      And
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
            tlt.genusr    =  "AYCAL"      And
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
            tlt.genusr    =  "AYCAL"      And
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
            tlt.genusr    =  "AYCAL"                And 
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
            tlt.genusr   =  "AYCAL"                 And 
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
            tlt.genusr   =  "AYCAL"                 And 
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
            tlt.genusr   =  "AYCAL"                 And 
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
            tlt.genusr   =  "AYCAL"        And
            index(tlt.releas,"CA") > 0 no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "สาขา"  Then do:          /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "AYCAL"        And
            tlt.EXP      =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .             /*add Kridtiya i. A56-0323*/
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.*/
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


&Scoped-define SELF-NAME ra_typfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typfile c-wins
ON VALUE-CHANGED OF ra_typfile IN FRAME fr_main
DO:
    ra_typfile = INPUT ra_typfile.
    DISP ra_typfile WITH FRAME fr_main.


    IF ra_typfile = 2  THEN DO:
        ASSIGN vAcProc_fil1 = ""
            vAcProc_fil1 = vAcProc_fil1 
                       + "All"  + ","
                       + "ประเภทกรมธรรม์" + ","  
                       + "รหัสแคมเปญ"    + ","       
                       + "ประเภทการชำระเบี้ย"  + ","
                       + "วันที่ตรวจสภาพ" + ","
                       + "ผลการตรวจสภาพ"  + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1) .
    END.
    ELSE DO:
       ASSIGN  vAcProc_fil1 = ""
       vAcProc_fil1 = vAcProc_fil1 + "สาขา" + ","    
                      + "ประเภทความคุ้มครอง"+ ","    
                      + "Complete"     + ","
                      + "Not complete" + "," 
                      + "Release Yes"  + "," 
                      + "Release No"   + ","
                      + "All"          + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1).

    END.
    DISP cb_report WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_br
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_br c-wins
ON VALUE-CHANGED OF rs_br IN FRAME fr_main
DO:
    rs_br = INPUT rs_br.
    DISP rs_br WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type c-wins
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type .
    DISP rs_type  WITH FRAME fr_main.
       
    RUN pro_openquery. /*a63-0448*/

    IF rs_type = 1 THEN DO:
        fi_outfile = "D:\Report_Notify" + 
                 STRING(YEAR(TODAY),"9999") + 
                 STRING(MONTH(TODAY),"99")  + 
                 STRING(DAY(TODAY),"99")    + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .
        /* Report  */
        IF ra_typfile = 2  THEN DO:
            ASSIGN vAcProc_fil1 = ""
                vAcProc_fil1 = vAcProc_fil1 
                           + "All"  + ","
                           + "ประเภทกรมธรรม์" + ","  
                           + "รหัสแคมเปญ"    + ","       
                           + "ประเภทการชำระเบี้ย"  + ","
                           + "วันที่ตรวจสภาพ" + ","
                           + "ผลการตรวจสภาพ"  + ","
            cb_report:LIST-ITEMS = vAcProc_fil1
            cb_report = ENTRY(1,vAcProc_fil1) .
        END.
        ELSE DO:
           ASSIGN vAcProc_fil1 = ""
           vAcProc_fil1 = vAcProc_fil1 + "สาขา" + ","    
                          + "ประเภทความคุ้มครอง"+ ","    
                          + "Complete"     + ","
                          + "Not complete" + "," 
                          + "Release Yes"  + "," 
                          + "Release No"   + ","
                          + "All"          + ","
            cb_report:LIST-ITEMS = vAcProc_fil1
            cb_report = ENTRY(1,vAcProc_fil1).
        
        END.
        /*serach */
        ASSIGN vAcProc_fil =  "ชื่อลูกค้า"   + ","
                              + "เลขที่ใบคำขอ" + ","
                              + "กรมธรรม์ใหม่" + "," 
                              + "เลขตัวถัง"    + ","
                              + "Empire_Branch" + ","  /*A63-0448*/                   
                              + "Orakan_Branch" + ","  /*A63-0448*/  
                              + "status_Yes"   + "," 
                              + "status_No"    + "," 
                              + "Status_cancel"  + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil) .
        HIDE tg_file.
        HIDE br_detail.
        DISP br_tlt cb_report cb_search ra_typfile WITH FRAME fr_main.
    END.
    ELSE IF rs_type = 2 THEN DO:
        
        fi_outfile = "D:\Report_inspec" + 
                 STRING(YEAR(TODAY),"9999") + 
                 STRING(MONTH(TODAY),"99")  + 
                 STRING(DAY(TODAY),"99")    + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2)  .
        nv_output = fi_outfile + "_Formins.csv" .

        ASSIGN vAcProc_fil1 = ""
        vAcProc_fil1 = "All"  + ","
                       + "วันที่นัดตรวจสภาพ" + ","
                       + "มีความเสียหาย"  + ","
                       + "ไม่มีความเสียหาย " + ","
                       + "ติดปัญหา" + ","
                       + "ส่งข้อมูลแล้ว" + ","
                       + "ยังไม่ส่งข้อมูล" + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1).

        /*serach */
        ASSIGN vAcProc_fil = ""
               vAcProc_fil = "ชื่อลูกค้า"   + ","
                                  + "เลขที่ใบคำขอ" + ","
                                  + "กรมธรรม์ใหม่" + "," 
                                  + "เลขตัวถัง"    + ","
                                  + "Empire_Branch" + ","  /*A63-0448*/  
                                  + "Orakan_Branch" + ","  /*A63-0448*/  
                                  + "status_Yes"   + "," 
                                  + "status_No"    + "," 
                                  + "Status_cancel"  + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil) .
        HIDE tg_file.
        HIDE ra_typfile.
        HIDE br_detail.
        DISP br_tlt cb_report cb_search WITH FRAME fr_main.

    END.
    ELSE DO:
        
        fi_outfile = "D:\Data_Payment" + 
                 STRING(YEAR(TODAY),"9999") + 
                 STRING(MONTH(TODAY),"99")  + 
                 STRING(DAY(TODAY),"99")    + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .
        ASSIGN vAcProc_fil1 = ""
               vAcProc_fil1 = "All"  + ","
                           + "Payment date"  + ","
                           + "Due Date" + ","
                           + "Status Reject" + ","
                           + "Status Approve" + ","
            cb_report:LIST-ITEMS = vAcProc_fil1
            cb_report = ENTRY(1,vAcProc_fil1) .

         ASSIGN vAcProc_fil = ""
             vAcProc_fil = "X-Refno" + ","
                              + "Payment No"  + ","
                              + "Crad no" + ","
                              + "Crad Name" + ","
                              + "Due Date" + ","
                              + "Payment Date" + ","
            cb_search:LIST-ITEMS = vAcProc_fil
            cb_search = ENTRY(1,vAcProc_fil) .
        HIDE ra_typfile.
        HIDE br_tlt .
        DISP br_detail cb_report cb_search tg_file WITH FRAME fr_main.

    END.
    DISP fi_outfile cb_report cb_search WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tg_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tg_file c-wins
ON VALUE-CHANGED OF tg_file IN FRAME fr_main /* ไฟล์ผลการตัดบัตรเครดิต */
DO:
    tg_file = INPUT tg_file.
    
    DISP tg_file WITH FRAME fr_main.

    IF tg_file = YES  THEN DO:
        fi_outfile =  "D:\Result_Payment" + 
                      STRING(YEAR(TODAY),"9999") + 
                      STRING(MONTH(TODAY),"99")  + 
                      STRING(DAY(TODAY),"99")    + 
                      SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                      SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .
    END.
    ELSE DO:
        fi_outfile = "D:\Data_Payment" + 
                 STRING(YEAR(TODAY),"9999") + 
                 STRING(MONTH(TODAY),"99")  + 
                 STRING(DAY(TODAY),"99")    + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .
    END.
    DISP fi_outfile WITH FRAME fr_main.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_detail
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
  gv_prgid = "wgwqayl0".
  gv_prog  = "Query & Update  Detail  (AYCAL  co.,ltd.) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
      rs_type   =  1 
      ra_status =  4 
      ra_typfile =  2
      rs_br      = 1    /*A63-0448*/
      tg_file    = NO
      vAcProc_fil = vAcProc_fil   + "ชื่อลูกค้า"   + ","
                                  + "เบอร์กรมธรรม์เดิม" + ","
                                  + "กรมธรรม์ใหม่" + "," 
                                  + "เลขตัวถัง"    + ","
                                 /* + "Empire_Branch" + ","  /*A63-0448*/  */ /*A65-00115*/
                                 /* + "Orakan_Branch" + ","  /*A63-0448*/  */ /*A65-0115 */
                                  + "Producer code" + ","  /*A65-0115 */
                                  + "status_Yes"   + "," 
                                  + "status_No"    + "," 
                                  + "Status_cancel"  + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil) .
      

       IF rs_type = 1  THEN DO:
           IF ra_typfile = 2  THEN DO:
                ASSIGN vAcProc_fil1 = vAcProc_fil1 
                               + "All"  + ","
                               + "Producer code" + ","  /*A65-0115*/
                               + "ประเภทกรมธรรม์" + ","  
                               + "รหัสแคมเปญ"    + ","       
                               + "ประเภทการชำระเบี้ย"  + ","
                               + "วันที่ตรวจสภาพ" + ","
                               + "ผลการตรวจสภาพ"  + ","
                cb_report:LIST-ITEMS = vAcProc_fil1
                cb_report = ENTRY(1,vAcProc_fil1) .
           END.
           ELSE DO:
               ASSIGN vAcProc_fil1 = vAcProc_fil1 + "สาขา" + ","    
                              + "ประเภทความคุ้มครอง"    + ","    
                              + "Complete"     + "," 
                              + "Not complete" + "," 
                              + "Release Yes"  + "," 
                              + "Release No"   + ","
                              + "All"          + ","
                cb_report:LIST-ITEMS = vAcProc_fil1
                cb_report = ENTRY(1,vAcProc_fil1).
           END.
       END.
       ELSE IF rs_type = 2 THEN  DO:
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
       ELSE DO:
           ASSIGN vAcProc_fil1 = vAcProc_fil1 
                              + "All"  + ","
                              + "X-Refno" + ","
                              + "Payment No"  + ","
                              + "Crad no" + ","
                              + "Crad Name" + ","
                              + "Due Date" + ","
            cb_report:LIST-ITEMS = vAcProc_fil1
            cb_report = ENTRY(1,vAcProc_fil1).
       
       END.
      fi_outfile = "D:\Report_Notify" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .
      HIDE tg_file .
  
  Disp fi_trndatfr  fi_trndatto cb_search cb_report ra_status fi_outfile rs_type ra_typfile rs_br with frame fr_main.

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  
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
  DISPLAY rs_br tg_file ra_typfile rs_type ra_status fi_trndatfr fi_trndatto 
          cb_search fi_search fi_name cb_report fi_outfile fi_datare 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE br_detail rs_br tg_file ra_typfile rs_type ra_status fi_trndatfr 
         fi_trndatto bu_ok cb_search bu_oksch br_tlt fi_search bu_update 
         cb_report fi_outfile bu_report bu_exit bu_upyesno fi_datare RECT-332 
         RECT-338 RECT-339 RECT-341 RECT-386 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
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
    nv_insresult  = "" .
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
    ASSIGN
         nv_campnam   = trim(substr(brstat.tlt.lotno,R-INDEX(tlt.lotno,"CamName:") + 8 ))     /*ชื่อแคมเปญ*/
         n_char       = trim(SUBSTR(brstat.tlt.lotno,1,R-INDEX(tlt.lotno,"CamName:") - 2 ))
         nv_camp      = trim(substr(n_char,R-INDEX(n_char,"CamCode:") + 8))                   /*รหัสแคมเปญ*/
         n_char       = trim(SUBSTR(n_char,1,R-INDEX(n_char,"CamCode:") - 2))
         nv_comcod    = trim(substr(n_char,R-INDEX(n_char,"InsCode:") + 8))                   /*รหัสบริษัท*/

         nv_pacg      = TRIM(SUBSTR(brstat.tlt.usrsent,R-INDEX(brstat.tlt.usrsent,"packcod:") + 8))   /*รหัสแพคเกจ    */ 
         n_char       = TRIM(SUBSTR(brstat.tlt.usrsent,1,R-INDEX(tlt.usrsent,"packcod:") - 2))
         nv_producnam = trim(substr(n_char,R-INDEX(n_char,"proname:") + 8))    /*ชื่อผลิตภัณฑ์ */ 
        
         /*-- ชื่อสกุลลูกค้า ---*/
         n_char       = trim(tlt.ins_name)
         nv_surth     = IF n_char <> " "  THEN trim(SUBSTR(n_char,R-INDEX(n_char," ")))                   ELSE ""
         n_char       = IF n_char <> " "  THEN trim(SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(nv_surth)))   ELSE ""
         nv_nameth    = IF n_char <> " "  THEN trim(SUBSTR(n_char,R-INDEX(n_char," ")))                   ELSE ""
         n_char       = IF n_char <> " "  THEN trim(SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(nv_nameth)))  ELSE ""
         nv_titleth   = IF n_char <> " "  THEN TRIM(SUBSTR(n_char,9,LENGTH(n_char)))                      ELSE "" 
         /*-- เลขบัตร วันเกิด เพศ อาขีพ --*/
         n_char       = TRIM(brstat.tlt.rec_addr5)
         nv_polbdate  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Birth:") + 6 ))
         n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Birth:") - 2 ))
         nv_sex       = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Sex:") + 4 ))
         nv_icno      = TRIM(SUBSTR(n_char,6,R-INDEX(n_char,"Sex:") - 6 )) 
         /*-- เบอร์โทร เมล์ ไลน์ ---*/
         nv_poltel   = TRIM(SUBSTR(brstat.tlt.ins_addr5,7)) 

         nv_driver   = string(brstat.tlt.endcnt) 
         nv_driid1   = TRIM(substr(brstat.tlt.dri_name1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") + 7 ))
         n_char      = TRIM(SUBSTR(brstat.tlt.dri_name1,1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") - 2 ))
         nv_drisur1  = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE ""
         n_char      = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char
         nv_drinam1  = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char,"Drinam1:") + 8)) ELSE "" 
         nv_dridate1 = TRIM(SUBSTR(brstat.tlt.dri_no1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") + 8 ))
         n_char      = TRIM(SUBSTR(brstat.tlt.dri_no1,1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") - 2))
         nv_drisex1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex1:") + 8 ))
         n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex1:") - 2))
         nv_driocc1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc1:") + 8))
         nv_driid2   = TRIM(substr(brstat.tlt.dri_name2,R-INDEX(brstat.tlt.dri_name2,"DriID2:") + 7 ))     
         n_char      = TRIM(SUBSTR(brstat.tlt.dri_name2,1,R-INDEX(brstat.tlt.dri_name2,"DriID2:") - 2 ))   
         nv_drisur2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE ""        
         n_char      = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char 
         nv_drinam2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,9,R-INDEX(n_char,"Drinam2:") + 8)) ELSE ""  
         nv_dridate2 = TRIM(SUBSTR(brstat.tlt.dri_no2,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") + 8))
         n_char      = TRIM(SUBSTR(brstat.tlt.dri_no2,1,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") - 2))
         nv_drisex2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex2:") + 8 ))
         n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex2:") - 2 ))
         nv_driocc2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc2:") + 8 )) 
         /*--การชำระเงิน --*/
         nv_paysur   = TRIM(substr(brstat.tlt.rec_name,R-INDEX(brstat.tlt.rec_name," ")))
         nv_paynam   = trim(substr(brstat.tlt.rec_name,1,LENGTH(brstat.tlt.rec_name) - LENGTH(nv_paysur)))

         nv_waytyp   = trim(substr(brstat.tlt.safe2,R-INDEX(brstat.tlt.safe2,"Paymentty:") + 10 ))
         n_char      = TRIM(SUBSTR(brstat.tlt.safe2,1,R-INDEX(brstat.tlt.safe2,"Paymentty:") - 2 ))
         nv_paymtyp  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMDTy:") + 12 ))

         /* garage */
         nv_garage    = trim(substr(brstat.tlt.old_cha,7))

         /* ประเภทความคุ้มครอง */
         n_char       = TRIM(brstat.tlt.rec_addr3)
         nv_covcod    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"covtcd:") + 7 ))
         nv_covtyp    = TRIM(SUBSTR(n_char,8,INDEX(n_char,"covtcd:") - 8 ))
              /*- แสตมป์ vat --*/
        nv_stamp     = string(DECI(SUBSTR(brstat.tlt.stat,5,R-INDEX(brstat.tlt.stat,"Vat:") - 5)))  
        nv_vat       = string(DECI(SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"Vat:") + 4 ))) 
        /* ส่วนลด */
        nv_feelt     = string(DECI(SUBSTR(brstat.tlt.comp_sck,R-INDEX(brstat.tlt.comp_sck ,"felA:") + 5 )))
        nv_ncb       = string(DECI(SUBSTR(brstat.tlt.comp_noti_tlt,R-INDEX(brstat.tlt.comp_noti_tlt ,"ncbA:") + 5 )))  
        nv_dridis    = string(DECI(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt ,"DriA:") + 5 )))
        nv_othdis    = string(DECI(SUBSTR(brstat.tlt.comp_noti_ins,R-INDEX(brstat.tlt.comp_noti_ins ,"OthA:") + 5 )))
        nv_cctv      = string(DECI(SUBSTR(brstat.tlt.comp_usr_ins,R-INDEX(brstat.tlt.comp_usr_ins ,"ctvA:") + 5 )))  
        nv_discdetail= trim(SUBSTR(brstat.tlt.comp_pol,R-INDEX(brstat.tlt.comp_pol,"Surd:") + 5 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.comp_pol,1,R-INDEX(brstat.tlt.comp_pol,"surd:") - 2 ))
        nv_disc      = string(DECI(SUBSTR(n_char,R-INDEX(n_char,"SurA:") + 5 )))
       /* อุปกรณ์ตกแต่ง */
        nv_accpric5  = string(deci(substr(brstat.tlt.filler1,R-INDEX(brstat.tlt.filler1,"Acp5:") + 5)))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler1,1,R-INDEX(brstat.tlt.filler1,"Acp5:") - 2 ))
        nv_accdet5   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd5:") - 2))
        nv_accpric4  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 )))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 ))
        nv_accdet4   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 ))
        
        nv_accpric3  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 ))) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))
        nv_accdet3   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 )) 
        
        nv_accpric2  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 ))) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 ))
        nv_accdet2   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 ))
       
        nv_accpric1  = STRING(DECI(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 ))) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 ))  
        nv_accdet1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 ))

        nv_inspdet   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") + 7))
        nv_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bloca:") + 6 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bloca:") - 2 ))
        nv_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))
        nv_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Bphon:") + 6 ))

        nv_remark    = TRIM(SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"Remark:") + 7 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler2,1,R-INDEX(brstat.tlt.filler2,"Remark:") - 2 ))

        nv_remarksend = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai3:") + 7 )).

       

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportdata_old c-wins 
PROCEDURE pd_reportdata_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: ไฟล์แจ้งงานแบบเก่า      
------------------------------------------------------------------------------*/
FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   AND
    (tlt.flag           <>  "V70"        AND 
    tlt.flag           <>  "V72"         AND 
    tlt.flag           <>  "INSPEC"      AND
    tlt.flag           <>  "Payment" )   AND
    tlt.genusr   =  "aycal"              no-lock. 
    
    IF rs_br = 2 AND tlt.imp <> "EMP" THEN NEXT. /* A63-0448 */
    IF rs_br = 3 AND tlt.imp = "EMP"  THEN NEXT. /* A63-0448 */

    IF      (cb_report = "สาขา" ) AND (tlt.comp_usr_tlt <> trim(fi_datare))       THEN NEXT.
    ELSE IF (cb_report = "ประเภทความคุ้มครอง") AND (tlt.safe3 <> trim(fi_datare)) THEN NEXT.
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
        IF trim(tlt.stat) = "Y" THEN "G" ELSE ""            /*  35 ซ่อมห้าง     */           
        tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
        tlt.filler1         /*  37 แก้ไขที่อยู่    */        
        tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
        tlt.OLD_cha         /*  39 หมายเหตุ */               
        tlt.OLD_eng         /*  40 complete/not complete */  
        tlt.releas          /*  41 Yes/No . */ 
        IF index(tlt.releas,"CA") <> 0  THEN  "เหตุผลยกเลิก : " + tlt.lotno ELSE "" 
        IF tlt.imp = "EMP" THEN "Empire" ELSE "Orakan" . /*A63-0448*/
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
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN nv_count = 0 
       nv_data  = "" .
    /*nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Report AYCAL :" string(TODAY,"99/99/9999")   .
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
   "วันที่ส่งข้อมูล"                    /*56*/ 
   "งานสาขา"  . /*a63-0448*/
   
 nv_data = trim(fi_datare).
 loop_tlt:
 For each brstat.tlt Use-index  tlt01 Where
          brstat.tlt.trndat   >=  fi_trndatfr   And
          brstat.tlt.trndat   <=  fi_trndatto   And
          brstat.tlt.genusr    =  "AYCAL"       AND 
          brstat.tlt.flag      =  "INSPEC"      no-lock.

     IF rs_br = 2 AND brstat.tlt.enttim <> "EMP" THEN NEXT. /*A63-0448*/
     IF rs_br = 3 AND brstat.tlt.enttim  = "EMP" THEN NEXT. /*A63-0448*/

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
         IF index(brstat.tlt.releas,"CA") = 0 THEN NEXT.
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
         brstat.tlt.entdat                                          /*56*/ 
         IF brstat.tlt.enttim = "EMP" THEN "Empire" ELSE "Orakan" . /*A63-0448*/

                                                                     
 END.
 OUTPUT CLOSE.
 RUN pd_reportinsp2.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportinsp2 c-wins 
PROCEDURE pd_reportinsp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: ไฟล์ตรวจสภาพ       
------------------------------------------------------------------------------*/
DEF VAR nv_count AS INT.
DEF VAR nv_data AS CHAR FORMAT "x(50)" INIT "".
If  substr(nv_output,length(nv_output) - 3,4) <>  ".slk"  THEN 
    nv_output  =  Trim(nv_output) + ".slk"  .
/*ASSIGN nv_cnt  =  0
       nv_row  =  1.*/
OUTPUT TO VALUE(nv_output).
EXPORT DELIMITER "|"  
     "X-Ref.No               " 
     "Customer Code          " 
     "HolderName             " 
     "HolderSurname          " 
     "LicencePlateNo         " 
     "ChassisNo              " 
     "Date of Car Inspection " 
     "Car Inspection Code    " 
     "Car Inspection Result  " 
     "Car Inspection Detail  " 
     "Car Inspection Remark 1" 
     "Car Inspection Remark 2"
     "Branch "  . /*A63-0448*/

 nv_data = trim(fi_datare).
 loop_tlt:
 For each brstat.tlt Use-index  tlt01 Where
          brstat.tlt.trndat   >=  fi_trndatfr   And
          brstat.tlt.trndat   <=  fi_trndatto   And
          brstat.tlt.genusr    =  "AYCAL"       AND 
          brstat.tlt.flag      =  "INSPEC"      no-lock.

     IF rs_br = 2 AND brstat.tlt.enttim <> "EMP" THEN NEXT. /*A63-0448*/
     IF rs_br = 3 AND brstat.tlt.enttim  = "EMP" THEN NEXT. /*A63-0448*/

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
         IF index(brstat.tlt.releas,"CA") = 0 THEN NEXT.
     END.
     

      nv_province = "" .
      IF brstat.tlt.lince2 = "กทม"    THEN nv_province = "กท".  
      ELSE DO:
         FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
              brstat.insure.compno = "999" AND 
              brstat.insure.FName  = TRIM(brstat.tlt.lince2) NO-LOCK NO-WAIT NO-ERROR.
          IF AVAIL brstat.insure THEN  ASSIGN nv_province = trim(brstat.Insure.LName).
      END.

      CREATE winsp.
      ASSIGN winsp.RefNo        = brstat.tlt.nor_noti_ins
             winsp.CusCode      = brstat.tlt.nor_usr_ins 
             winsp.Surname      = TRIM(SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name," ")))
             winsp.cusName      = TRIM(SUBSTR(brstat.tlt.ins_name,1,LENGTH(tlt.ins_name) - LENGTH(winsp.surname)))
             winsp.Licence      = trim(brstat.tlt.lince1) + " " + TRIM(nv_province)   
             winsp.Chassis      = trim(brstat.tlt.cha_no)
             winsp.Insp_date    = string(brstat.tlt.datesent,"99/99/9999")
             winsp.Insp_Code    = ""
             winsp.Insp_Result  = "" 
             winsp.Insp_Detail  = TRIM(brstat.tlt.safe1)
             winsp.Insp_Remark1 = TRIM(brstat.tlt.safe2)
             winsp.Insp_Remark2 = IF TRIM(brstat.tlt.safe3) <> "" THEN "อุปกรณ์เสริม : " + TRIM(brstat.tlt.safe3) ELSE ""
             winsp.insp_remark2 = IF trim(brstat.tlt.filler2) <> "" THEN winsp.insp_remark2 + " ข้อมูลอื่น ๆ : " + TRIM(brstat.tlt.filler2) ELSE
                                  winsp.insp_remark2
             winsp.insp_status  = brstat.tlt.releas
             winsp.br           = IF brstat.tlt.enttim = "EMP" THEN "Empire" ELSE "Orakan" . /*A63-0448*/

         IF INDEX(brstat.tlt.safe1,"ไม่มีความเสียหาย") <> 0 THEN DO:
             ASSIGN winsp.Insp_Code   = "01"
                    winsp.Insp_Result = "AU-Approve".
          END.
          ELSE IF INDEX(brstat.tlt.safe1,"มีความเสียหาย") <> 0 THEN DO:
              ASSIGN winsp.Insp_Code   = "03"
                     winsp.Insp_Result = "AC-Approved with Condition".  
          END.
          ELSE IF INDEX(brstat.tlt.safe1,"ติดปัญหา") <> 0 THEN DO:
              ASSIGN winsp.Insp_Code   = "04"
                     winsp.Insp_Result = "RI-Request More Info".  
          END.
  END.
  FOR EACH winsp no-lock.
        EXPORT DELIMITER "|" 
        winsp.RefNo         
        winsp.CusCode       
        winsp.cusName       
        winsp.Surname      
        winsp.Licence       
        winsp.Chassis       
        winsp.Insp_date            
        winsp.Insp_Code            
        winsp.Insp_Result          
        winsp.Insp_Detail          
        winsp.Insp_Remark1         
        winsp.Insp_Remark2 
        winsp.br . /*A63-0448*/
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

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN nv_data =  "".

OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Report AYCAL :" string(TODAY,"99/99/9999")   .
EXPORT DELIMITER "|" 
    "ประเภทกรมธรรม์"   
    "เบอร์กรมธรรม์ "   
    "InsuranceCode" 
    "CampaignCode " 
    "CampaignName " 
    "ProductName  " 
    "ProspectID   " 
    "Holder_title " 
    "Holder_fname_thai "
    "Holder_sname_thai "
    "Holder_id/Company "
    "Holder_sex        "
    "Holder_birth_date "
    "Holder_mobile     "
    "Holder_Billing_address_line1 "
    "Holder_Billing_address_line2 "
    "Payer_fname       "
    "Payer_sname       "
    "Payer_id_code     "
    "Holder_address_line1 "
    "Holder_address_line2 "
    "Beneficiary_name "
    "payment_mode_Desc "
    "payment_Channel   "
    "Drivee_Status     "
    "Driver1_fname     "
    "Driver1_lname     "
    "Driver1_id_code   "
    "Driver1_Occupation"
    "Driver1_Gender    "
    "Driver1_birth_date"
    "Driver2_fname     "
    "Driver2_fname     "
    "Driver2_id_code   "
    "Driver2_Occupation"
    "Driver2_Gender    "
    "Driver2_birth_date"
    "Brand             "
    "Model             "
    "BodyType          "
    "License_Plate     "
    "License_Prov_Code "
    "Chassis_No  "
    "Engine No.  "
    "Model_Year  "
    "CC          "
    "Use Car Type"
    "Garage_Code "
    "Insurance_Type"
    "term_Date_From"
    "term_Date_To  "
    "Sum_Insured   "
    "Premium rate for Main Coveragtes"
    "Net Premium "
    "stamp_vmi   "
    "tax_amt_vmi "
    "total_prem_vmi"
    "Deduct_own_damage"
    "Amount Fleet Discount"
    "Amount No Claim Bonus"
    "Amount Discount for Driver"
    "Amount Other Discount"
    "Amount Car DashCam Discount"
    "Amount Surcharge  "
    "Surcharge Detail  "
    "accessory_remarks_01"
    "accessory_suminsured_01"
    "accessory_remarks_02   "
    "accessory_suminsured_02"
    "accessory_remarks_03   "
    "accessory_suminsured_03"
    "accessory_remarks_04   "
    "accessory_suminsured_04"
    "accessory_remarks_05   "
    "accessory_suminsured_05"
    "Car Inspection Date "
    "Car Inspection Name "
    "Car Inspection Phone"
    "Car Inspection Location"
    "Detail Car Inspection"
    "Sale Date"
    "Delivery Remark Varchar"
    "X-RefNo from Midas"
    "Cust.Code No "
    "Policy No"
    "AgentName"
    /* Add by : A67-0162 */
    "EngineTypeGroup"
    "MCAutoTypeGroup"
    "WATT"
    "EVMotorNo1 "
    "EVMotorNo2 "
    "EVMotorNo3 "
    "EVMotorNo4 "
    "EVMotorNo5 "
    "EVMotorNo6 "
    "EVMotorNo7 "
    "EVMotorNo8 "
    "EVMotorNo9 "
    "EVMotorNo10"
    "EVMotorNo11"
    "EVMotorNo12"
    "EVMotorNo13"
    "EVMotorNo14"
    "EVMotorNo15"
    "carPrice   "
    "Driver1_DrivingLicenseNo "
    "driver1_CardExpiryDate "
    "driver1_CardType  "
    "Driver2_DrivingLicenseNo "
    "driver2_CardExpiryDate   "
    "driver2_CardType  "
    "Driver3_title_code"
    "Driver3_fname "
    "Driver3_sname "
    "Driver3_birth_date"
    "Driver3_Gender"
    "driver3_CardType"  
    "Driver3_id_code "  
    "Driver3_DrivingLicenseNo "
    "driver3_CardExpiryDate   "
    "driver3_Occupation "   
    "Driver4_title_code "   
    "Driver4_fname "   
    "Driver4_sname "   
    "Driver4_birth_date "   
    "Driver4_Gender"   
    "driver4_CardType"   
    "Driver4_id_code "   
    "Driver4_DrivingLicenseNo "
    "driver4_CardExpiryDate   "
    "driver4_Occupation"
    "Driver5_title_code"
    "Driver5_fname  "   
    "Driver5_sname  "   
    "Driver5_birth_date"
    "Driver5_Gender "   
    "driver5_CardType"
    "Driver5_id_code "
    "Driver5_DrivingLicenseNo "
    "driver5_CardExpiryDate   "
    "driver5_Occupation"
    "ChangeBattFlag"
    "BattYear      "
    "BattPurchaseDate  "
    "BattPrice     "
    "BattSerialNo  "
    "BattRepSumInsured "
    "WallChargeNo   "
    "WallChargeBrand"
    /* end : A67-0162*/
    "Remark "
    "Producer "                             
    "Agent " 
    "dealer "  /* A65-0115*/
    "Branch "  /*A63-0448*/ 
    "status" . /*A63-0448*/

 nv_data = TRIM(fi_datare) .
 loop_tlt:
 For each brstat.tlt Use-index  tlt01 Where
          brstat.tlt.trndat   >=  fi_trndatfr   And
          brstat.tlt.trndat   <=  fi_trndatto   And
          brstat.tlt.genusr    =  "AYCAL"       AND 
         (brstat.tlt.flag      =  "V70"         OR 
          brstat.tlt.flag      =  "V72")        no-lock.

     IF rs_br = 2 AND tlt.ins_addr1 <> "EMP" THEN NEXT. /* A63-0448 */
     IF rs_br = 3 AND tlt.ins_addr1 =  "EMP" THEN NEXT. /* A63-0448 */

     IF cb_report = "ประเภทกรมธรรม์" THEN DO:
        IF brstat.tlt.flag <> nv_data THEN NEXT.
     END.
     IF cb_report = "รหัสแคมเปญ" THEN DO:
         IF INDEX(brstat.tlt.lotno,nv_data) = 0 THEN NEXT.
     END.
     IF cb_report = "ประเภทการชำระเบี้ย"   THEN DO:
         IF INDEX(brstat.tlt.safe2,"PaymentMDTy:" + nv_data) = 0 THEN NEXT.
     END.
     
     IF cb_report = "วันที่ตรวจสภาพ"   THEN DO:
         IF DATE(brstat.tlt.nor_effdat) = DATE(nv_data) THEN NEXT.
     END.
     IF cb_report = "ผลการตรวจสภาพ"   THEN DO:
         IF INDEX(brstat.tlt.nor_noti_tlt,"InspSt:" + nv_data) = 0 THEN NEXT.
     END.
     /* A65-0115 */
     IF cb_report = "Producer code"  THEN DO:
         IF TRIM(brstat.tlt.subins) <> nv_data THEN NEXT .
     END.
     /* end : A65-0115*/
     IF      ra_status = 1 THEN DO: 
         IF brstat.tlt.releas <> "yes"  THEN NEXT.
     END.
     ELSE IF ra_status = 2 THEN DO: 
         IF brstat.tlt.releas <> "no"   THEN NEXT.
     END.
     ELSE IF ra_status = 3 THEN DO: 
         IF index(brstat.tlt.releas,"CA") = 0 THEN NEXT.
     END.

     RUN pd_cleardata .
     RUN pd_data_noti .
    /* RUN pd_data_noti1.
     RUN pd_data_noti2.
     RUN pd_data_noti3.*/
     EXPORT DELIMITER "|" 
         trim(brstat.tlt.flag)
         TRIM(brstat.tlt.policy)
         nv_comcod                              /*1   */
         nv_camp                                /*3   */  
         nv_campnam                             /*4   */ 
         nv_producnam                           /*6   */ 
         nv_pacg                                /*8   */  
         /*trim(brstat.tlt.imp) */                  /*9   */  
         nv_titleth                             /*10  */  
         nv_nameth                              /*11  */  
         nv_surth                               /*12  */  
         nv_icno                                /*16  */  
         nv_sex                                 /*17  */  
         STRING(DATE(nv_polbdate),"99/99/9999") /*18  */  
         nv_poltel                              /*20  */  
         trim(brstat.tlt.ins_addr3)             /*25  */  
         trim(brstat.tlt.ins_addr4)             /*26  */  
         nv_paynam                              /*28  */  
         nv_paysur                              /*29  */  
         trim(brstat.tlt.comp_sub)              /*30  */  
         trim(brstat.tlt.rec_addr1)             /*31  */  
         trim(brstat.tlt.rec_addr2)             /*32  */  
         trim(brstat.tlt.safe1)                 /*34  */ 
         nv_paymtyp                             /*36  */
         nv_waytyp                              /*38  */  
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
         trim(brstat.tlt.lince2)                /*59  */  
         trim(brstat.tlt.cha_no)                /*60  */  
         trim(brstat.tlt.eng_no)                /*61  */  
         trim(brstat.tlt.gentim)                /*62  */ 
         brstat.tlt.rencnt                      /*64  */  
         trim(brstat.tlt.expotim)               /*66  */  
         nv_garage                              /*68  */  
         nv_covtyp                              /*70  */ 
         string(brstat.tlt.gendat,"99/99/9999")                      /*75  */  
         string(brstat.tlt.expodat,"99/99/9999")                     /*76  */  
         string(deci(brstat.tlt.nor_coamt))                   /*77  */  
         string(deci(brstat.tlt.nor_grprm))                   /*78  */  
         string(deci(brstat.tlt.comp_grprm))                  /*79  */  
         string(deci(nv_stamp))                               /*80  */  
         string(deci(nv_vat))                                 /*81  */  
         brstat.tlt.comp_coamt                  /*82  */  
         string(deci(brstat.tlt.endno))         /*83  */  
         string(deci(nv_feelt))                /*85  */  
         string(deci(nv_ncb))                   /*87  */
         string(deci(nv_dridis))                /*89  */
         string(deci(nv_othdis))                /*91  */
         string(deci(nv_cctv))                  /*93  */  
         string(deci(nv_disc))                  /*94  */ 
         nv_discdetail                          /*96  */  
         nv_accdet1                             /*98  */  
         INT(nv_accpric1)                       /*99  */  
         nv_accdet2                             /*101 */  
         int(nv_accpric2)                       /*102 */  
         nv_accdet3                             /*104 */  
         int(nv_accpric3)                       /*105 */  
         nv_accdet4                             /*107 */  
         int(nv_accpric4)                       /*108 */  
         nv_accdet5                             /*110 */  
         int(nv_accpric5)                            /*111 */  
         IF brstat.tlt.nor_effdat  <> ? THEN string(brstat.tlt.nor_effdat,"99/99/9999")  else ""                /*112 */  
         /*IF brstat.tlt.comp_effdat <> ? THEN string(brstat.tlt.comp_effdat,"99/99/9999") else "" */               /*113 */
         nv_bronam                              /*120 */
         nv_brolincen                           /*119 */
         nv_brocod                              /*121 */ 
         nv_inspdet                                     /*115 */ 
         IF tlt.datesent     <> ? THEN String(brstat.tlt.datesent,"99/99/9999")          ELSE ""                /*116 */  
         /*IF tlt.dat_ins_noti <> ? THEN String(brstat.tlt.dat_ins_noti,"99/99/9999")      ELSE ""    */           /*117 */  
         /*nv_paidsts                             /*118 */  */
         nv_remarksend                          /*124 */ 
         brstat.tlt.nor_noti_ins                /*126 */  
         brstat.tlt.nor_usr_ins                 /*127 */
         IF INDEX(brstat.tlt.imp,"Pol:") <> 0 THEN SUBSTR(brstat.tlt.imp,5) ELSE trim(brstat.tlt.imp)
         TRIM(brstat.tlt.EXP)
         /* Add by : A67-0162  */
         trim(brstat.tlt.note2)           
         trim(brstat.tlt.note3)        
         brstat.tlt.watts        
         trim(brstat.tlt.note4)        
         trim(brstat.tlt.note5)        
         trim(brstat.tlt.note6)        
         trim(brstat.tlt.note7)        
         trim(brstat.tlt.note8)        
         trim(brstat.tlt.note9)        
         trim(brstat.tlt.note10)       
         trim(brstat.tlt.note11)       
         trim(brstat.tlt.note12)       
         trim(brstat.tlt.note13)       
         trim(brstat.tlt.note14)       
         trim(brstat.tlt.note15)       
         trim(brstat.tlt.note16)       
         trim(brstat.tlt.note17)       
         trim(brstat.tlt.note18)       
         brstat.tlt.maksi        
         trim(brstat.tlt.dri_lic1)     
         trim(brstat.tlt.dri_licenexp1)
         trim(brstat.tlt.dri_ic1 )     
         trim(brstat.tlt.dri_lic2)     
         trim(brstat.tlt.dri_licenexp2)
         trim(brstat.tlt.dri_ic2)      
         trim(brstat.tlt.dri_title3)   
         trim(brstat.tlt.dri_fname3)   
         trim(brstat.tlt.dri_lname3)   
         trim(brstat.tlt.dri_birth3)   
         trim(brstat.tlt.dri_gender3)  
         trim(brstat.tlt.dri_ic3 )  
         trim(brstat.tlt.dri_no3 )  
         trim(brstat.tlt.dri_lic3)  
         trim(brstat.tlt.dri_licenexp3)
         trim(brstat.tlt.dir_occ3   )  
         trim(brstat.tlt.dri_title4 )  
         trim(brstat.tlt.dri_fname4 )  
         trim(brstat.tlt.dri_lname4 )  
         trim(brstat.tlt.dri_birth4 )  
         trim(brstat.tlt.dri_gender4)  
         trim(brstat.tlt.dri_ic4)     
         trim(brstat.tlt.dri_no4)     
         trim(brstat.tlt.dri_lic4)     
         trim(brstat.tlt.dri_licenexp4)
         trim(brstat.tlt.dri_occ4)
         trim(brstat.tlt.dri_title5)
         trim(brstat.tlt.dri_fname5)
         trim(brstat.tlt.dri_lname5)
         trim(brstat.tlt.dri_birth5)
         trim(brstat.tlt.dri_gender5)
         trim(brstat.tlt.dri_ic5)  
         trim(brstat.tlt.dri_no5)  
         trim(brstat.tlt.dri_lic5)  
         trim(brstat.tlt.dri_licenexp5)
         trim(brstat.tlt.dri_occ5)     
         brstat.tlt.battflg      
         trim(brstat.tlt.battyr)       
         brstat.tlt.ndate1       
         brstat.tlt.battprice    
         trim(brstat.tlt.battno)      
         brstat.tlt.battsi       
         trim(brstat.tlt.chargno)      
         trim(brstat.tlt.note19)  
         /* end : A67-0162 */
         nv_remark                              /*128 */  
         brstat.tlt.subins                      /*129 */  
         brstat.tlt.recac                        /*130 */ 
         brstat.tlt.dealer                      /* dealer code A65-0115*/
         brstat.tlt.ins_addr1           /* br tmsth A65-0115 */
         brstat.tlt.releas . 
         /*IF tlt.ins_addr1 = "EMP" THEN "Empire" ELSE "Orakan" . /*a63-0448*/  a65-0115*/
 END.
OUTPUT   CLOSE.                            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportnoti_old c-wins 
PROCEDURE pd_reportnoti_old :
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
    fi_outfile  =  Trim(fi_outfile) + ".csv"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outfile). 
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
    "Yes/No"
    "Remark "     /*a63-0448*/
    "Branch "  .  /*a63-0448*/
RUN pd_reportdata_old.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportpayment c-wins 
PROCEDURE pd_reportpayment :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_count AS INT.
DEF VAR nv_data AS CHAR FORMAT "x(50)" INIT "".
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN nv_count = 0 
       nv_data  = "" .
    /*nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Report AYCAL :" string(TODAY,"99/99/9999")   .
EXPORT DELIMITER "|" 
   "ลำดับที่       "                /*1   */                                      
   "InsuranceCode    "              /*2   */    
   "InsuranceName    "              /*3   */    
   "X-RefNo          "              /*4   */    
   "Payment No.      "              /*5   */    
   "TransType        "              /*6   */    
   "Payment mode Desc"              /*7   */    
   "Payment Type Desc"              /*8   */    
   "Credit Card No.  "              /*9   */    
   "Credit Type      "              /*10  */    
   "Credit Card Expire Date"        /*11  */    
   "Card Holder Name  "             /*12  */    
   "Credit Card Bank  "             /*13  */    
   "Payment Due Date  "             /*14  */    
   "Due Amount        "             /*15  */    
   "รหัสส่งเสริมการขาย"             /*16  */    
   "รหัสสินค้า        "             /*17  */    
   "เบอร์กรมธรรม์   "               /*18  */    
   "ผลการตัดบัตร "                  /*19  */    
   "หมายเลขการตัดบัตร"              /*20  */    
   "วันที่ตัดบัตร "                 /*21  */    
   "ยอดที่ตัดบัตร "                 /*22  */ 
   "หมายเหตุ     "                  /*23  */
   "สถานะข้อมูล "                /*24  */
   "งานสาขา " . /*A63-0448*/
      
   
 nv_data = trim(fi_datare).
 loop_tlt:
 For each brstat.tlt Use-index  tlt01 Where
          brstat.tlt.trndat   >=  fi_trndatfr   And
          brstat.tlt.trndat   <=  fi_trndatto   And
          brstat.tlt.genusr    =  "AYCAL"       AND 
          brstat.tlt.flag      =  "Payment"      no-lock.

     IF rs_br = 2 AND brstat.tlt.enttim <> "EMP" THEN NEXT. /*A63-0448*/
     IF rs_br = 3 AND brstat.tlt.enttim  = "EMP" THEN NEXT. /*A63-0448*/

     IF cb_report = "Payment Date" THEN DO:
         IF STRING(brstat.tlt.datesent,"99/99/9999") <> nv_data THEN NEXT.
     END.
     IF cb_report = "Due Date" THEN DO:
         IF STRING(brstat.tlt.gendat,"99/99/9999") <> nv_data THEN NEXT.
     END.
     ELSE IF cb_report = "Status Reject"   THEN DO:
         IF INDEX(brstat.tlt.safe1,"Reject") = 0 THEN NEXT.
     END.
     ELSE IF cb_report = "Status Approve"   THEN DO:
         IF INDEX(brstat.tlt.safe1,"Approve") = 0 THEN NEXT.
     END.

     IF      ra_status = 1 THEN DO: 
         IF brstat.tlt.releas <> "yes"  THEN NEXT.
     END.
     ELSE IF ra_status = 2 THEN DO: 
         IF brstat.tlt.releas <> "no"   THEN NEXT.
     END.
     ELSE IF ra_status = 3 THEN DO: 
         IF index(brstat.tlt.releas,"CA") = 0 THEN NEXT.
     END.
     
     nv_count = nv_count + 1 .
     EXPORT DELIMITER "|"
         nv_count                  /*1   */ 
         brstat.tlt.nor_usr_ins    /*2   */ 
         brstat.tlt.lotno          /*3   */ 
         brstat.tlt.cha_no         /*4   */ 
         brstat.tlt.nor_noti_ins   /*5   */ 
         brstat.tlt.rec_addr2      /*6   */ 
         brstat.tlt.rec_addr5      /*7   */ 
         brstat.tlt.ins_name       /*8   */ 
         brstat.tlt.rec_name       /*9   */ 
         brstat.tlt.lince1         /*10  */
         brstat.tlt.rec_addr1      /*11  */   
         brstat.tlt.rec_addr3      /*12  */   
         brstat.tlt.old_cha        /*13  */   
         brstat.tlt.gendat         /*14  */   
         brstat.tlt.nor_coamt      /*15  */   
         brstat.tlt.safe3          /*16  */   
         brstat.tlt.safe2          /*17  */   
         brstat.tlt.policy         /*18  */   
         brstat.tlt.safe1          /*19  */   
         brstat.tlt.comp_sub       /*20  */   
         brstat.tlt.datesent       /*21  */   
         brstat.tlt.exp            /*22  */
         brstat.tlt.filler1         /*23  */  
         brstat.tlt.releas          /*24 */ 
         IF brstat.tlt.enttim = "EMP"  THEN "Empire" ELSE "Orakan" . /*A63-0448*/
 END.
 OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_resultpayment c-wins 
PROCEDURE pd_resultpayment :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_count AS INT.
DEF VAR nv_data AS CHAR FORMAT "x(50)" INIT "".
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN nv_count = 0 
       nv_data  = "" .
    /*nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Result Payment AYCAL :" string(TODAY,"99/99/9999")   .
EXPORT DELIMITER "|" 
                                 
   "InsuranceCode    "       /*2   */ 
   "X-RefNo          "       /*4   */    
   "Payment No.      "       /*5   */    
   "Payment Trans    "       /*6   */
   "Payment Date     "       /*21  */    
   "Payment amount   "       /*22  */ 
   "Result           "       /*19  */    
   "Approvalcode     "       /*20  */
   "สถานะข้อมูล / เลขที่ใบรับเงิน "           /*23  */ 
   "งานสาขา " . /*A63-0448*/

 nv_data = trim(fi_datare).
 loop_tlt:
 For each brstat.tlt Use-index  tlt01 Where
          brstat.tlt.trndat   >=  fi_trndatfr   And
          brstat.tlt.trndat   <=  fi_trndatto   And
          brstat.tlt.genusr    =  "AYCAL"       AND 
          brstat.tlt.flag      =  "Payment"      no-lock.

     IF rs_br = 2 AND brstat.tlt.enttim <> "EMP" THEN NEXT.   /*a63-0448*/
     IF rs_br = 3 AND brstat.tlt.enttim  = "EMP" THEN NEXT.   /*a63-0448*/
     
     IF cb_report = "Payment Date" THEN DO:
         IF STRING(brstat.tlt.datesent,"99/99/9999") <> nv_data THEN NEXT.
     END.
     IF cb_report = "Due Date" THEN DO:
         IF STRING(brstat.tlt.gendat,"99/99/9999") <> nv_data THEN NEXT.
     END.
     ELSE IF cb_report = "Status Reject"   THEN DO:
         IF INDEX(brstat.tlt.safe1,"Reject") = 0 THEN NEXT.
     END.
     ELSE IF cb_report = "Status Approve"   THEN DO:
         IF INDEX(brstat.tlt.safe1,"Approve") = 0 THEN NEXT.
     END.

     IF      ra_status = 1 THEN DO: 
         IF brstat.tlt.releas <> "yes"  THEN NEXT.
     END.
     ELSE IF ra_status = 2 THEN DO: 
         IF brstat.tlt.releas <> "no"   THEN NEXT.
     END.
     ELSE IF ra_status = 3 THEN DO: 
         IF index(brstat.tlt.releas,"CA") = 0 THEN NEXT.
     END.
     
     nv_count = nv_count + 1 .
     EXPORT DELIMITER "|"
         brstat.tlt.nor_usr_ins    /*2   */ 
         brstat.tlt.cha_no         /*4   */ 
         brstat.tlt.nor_noti_ins   /*5   */ 
         brstat.tlt.rec_addr2      /*6   */
         brstat.tlt.datesent       /*21  */   
         brstat.tlt.exp            /*22  */ 
         brstat.tlt.safe1          /*19  */   
         " "                       /*20  */ 
         brstat.tlt.RELEAS + "/ " + brstat.tlt.comp_sub 
         IF brstat.tlt.enttim = "EMP" THEN "Empire" ELSE "Orakan" . /*a63-0448*/
 END.
 OUTPUT CLOSE.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_query02 c-wins 
PROCEDURE proc_query02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment : Ranu I. A63-0448 
    ELSE If  cb_search  = "Empire_Branch"  Then do:  /* งานเอ็มไพร์ */
        IF rs_type = 1 THEN DO: 
           /* Open Query br_tlt 
               For each tlt Use-index  tlt06 Where
               tlt.trndat   >=  fi_trndatfr And
               tlt.trndat   <=  fi_trndatto AND 
               tlt.genusr    =  "AYCAL"     and
               tlt.flag      <> "INSPEC"    AND
               tlt.imp       = "EMP"        OR
               tlt.ins_addr1 = "EMP"        NO-LOCK.*/
              IF ra_typfile = 1 THEN DO:
                  Open Query br_tlt 
                  For each tlt Use-index  tlt06 Where
                  tlt.trndat   >=  fi_trndatfr And
                  tlt.trndat   <=  fi_trndatto AND 
                  tlt.genusr    =  "AYCAL"     and
                  tlt.imp       = "EMP"        AND      
                  (tlt.flag     <> "V70"       OR 
                  tlt.flag      <> "V72" )     AND
                  tlt.flag      <> "INSPEC"    NO-LOCK.
              END.
              ELSE DO:
                  Open Query br_tlt 
                  For each tlt Use-index  tlt06 Where
                  tlt.trndat   >=  fi_trndatfr And
                  tlt.trndat   <=  fi_trndatto AND 
                  tlt.genusr    =  "AYCAL"     and
                  tlt.ins_addr1 = "EMP"        AND
                  (tlt.flag     = "V70"       OR 
                  tlt.flag      = "V72"  )     AND
                  tlt.flag      <> "INSPEC"    NO-LOCK.
              END.
              ASSIGN nv_rectlt =  recid(tlt) . 
              Apply "Entry"  to br_tlt.
              Return no-apply.
        END.
        ELSE DO: 
            Open Query br_tlt 
             For each tlt Use-index  tlt06 Where
             tlt.trndat   >=  fi_trndatfr And
             tlt.trndat   <=  fi_trndatto AND 
             tlt.genusr    =  "AYCAL"     AND
            (tlt.flag      =  "INSPEC"    AND
             tlt.enttim    =   "EMP" )    no-lock.
          ASSIGN nv_rectlt =  recid(tlt) .  
          Apply "Entry"  to br_tlt.
          Return no-apply.
        END.           
    END.
    ELSE If  cb_search  = "Orakan_Branch"  Then do:  /* งานอรกานต์ */
       IF rs_type = 1 THEN DO:
           /*Open Query br_tlt
           For each tlt Use-index  tlt06 Where
           tlt.trndat   >=  fi_trndatfr And
           tlt.trndat   <=  fi_trndatto AND 
           tlt.genusr    =  "AYCAL"     and
           tlt.flag      <> "INSPEC"    AND
           (tlt.imp       =  "ORA"      OR  
           tlt.imp        =  "IM"       OR  
           tlt.ins_addr1  =  "ORA"      OR  
           tlt.ins_addr1  =  ""  )      NO-LOCK.*/
           IF ra_typfile = 1 THEN DO:
             Open Query br_tlt
               For each tlt Use-index  tlt06 Where
               tlt.trndat   >=  fi_trndatfr And
               tlt.trndat   <=  fi_trndatto AND 
               tlt.genusr    =  "AYCAL"     and
               (tlt.flag     <> "V70"       OR 
               tlt.flag      <> "V72" )     AND
               tlt.flag      <> "INSPEC"    AND
               (tlt.imp       =  "ORA"       OR  
               tlt.imp       =  "IM"  )     NO-LOCK.
            /* IF tlt.flag = "V70" OR tlt.flag = "V72" THEN NEXT.
             IF tlt.imp  <> "ORA" OR tlt.imp <> "IM" THEN NEXT.*/
           END.
           ELSE DO:
               Open Query br_tlt
               For each tlt Use-index  tlt06 Where
               tlt.trndat   >=  fi_trndatfr And
               tlt.trndat   <=  fi_trndatto AND 
               tlt.genusr    =  "AYCAL"     and
               (tlt.flag     =  "V70"       OR 
               tlt.flag      =  "V72" )     AND
               tlt.flag      <> "INSPEC"    AND
               (tlt.ins_addr1 =  "ORA"      OR  
               tlt.ins_addr1  =  ""  )      NO-LOCK.

            /* IF tlt.ins_addr1 <> "ORA" AND tlt.ins_addr1 <> "" THEN NEXT.
             IF tlt.flag <> "V70" OR tlt.flag <> "V72" THEN NEXT.*/
             
           END.
           ASSIGN nv_rectlt =  recid(tlt) .  
           Apply "Entry"  to br_tlt.
           Return no-apply.
       END.
       ELSE DO: 
         Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat   >=  fi_trndatfr And
            tlt.trndat   <=  fi_trndatto AND 
            tlt.genusr    =  "AYCAL"     AND
           (tlt.flag      =  "INSPEC"    AND
            tlt.enttim    <> "EMP" )    no-lock.
         ASSIGN nv_rectlt =  recid(tlt) .  
         Apply "Entry"  to br_tlt.
         Return no-apply.
       END.          
    END.
    /* end A63-0448 */
 ...end A65-0115 */
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
IF rs_type = 1 THEN DO:
    DISP br_tlt WITH FRAME fr_main.
    HIDE br_detail.
    Open Query br_tlt 
        For each tlt Use-index  tlt01 Where
            tlt.trndat  >=  fi_trndatfr  And
            tlt.trndat  <=  fi_trndatto  And
            tlt.flag     =  "V70"        OR
            tlt.flag     =  "V72"        AND 
            tlt.genusr   =  "AYCAL"      no-lock.
            ASSIGN
                nv_rectlt =  recid(tlt).  
       
END.
ELSE IF rs_type = 2 THEN DO:
    DISP br_tlt WITH FRAME fr_main.
    HIDE br_detail.
    Open Query br_tlt 
        For each tlt Use-index  tlt01 Where
            tlt.trndat  >=  fi_trndatfr  And
            tlt.trndat  <=  fi_trndatto  And
            tlt.flag     =  "INSPEC"     AND 
            tlt.genusr   =  "AYCAL"      no-lock.
            ASSIGN
                nv_rectlt =  recid(tlt).  

END.
ELSE DO:
    DISP br_detail WITH FRAME fr_main.
    HIDE br_tlt.
    Open Query br_detail 
        For each tlt Use-index  tlt01 Where
            tlt.trndat  >=  fi_trndatfr  And
            tlt.trndat  <=  fi_trndatto  And
            tlt.flag     =  "Payment"     AND 
            tlt.genusr   =  "AYCAL"      no-lock.
            ASSIGN
                nv_rectlt =  recid(tlt).  

END.
                             

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

IF rs_type <> 3 THEN DO:
    DISP br_tlt WITH FRAME fr_main.
    HIDE br_detail.
    Open Query br_tlt 
    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt).  
       
END.
ELSE DO:
    DISP br_detail WITH FRAME fr_main.
    HIDE br_tlt.
    Open Query br_detail
    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt).
END.
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

