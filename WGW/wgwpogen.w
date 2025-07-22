&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME c-win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-win 
/*------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
by this procedure. This is a good default which assures
that this procedure's triggers and internal procedures 
will execute in this procedure's storage, and that proper
cleanup will occur on deletion of the procedure.                                           */
CREATE WIDGET-POOL.   
/*******************************************************************************************/                                      
/*programid   : wgwkkren.w                                                                 */ 
/*programname : load text file KK to GW                                                    */ 
/* Copyright  : Safety Insurance Public Company Limited บริษัท ประกันคุ้มภัย จำกัด (มหาชน) */ 
/*create by   : Kridtiya i. A54-0351  date . 06/12/11                                      */ 
/*              เพิ่มโปรแกรมนำเข้างานต่ออายุ ธนาคารเกียรตินาคิน                            */ 
/*modify by   : Kridtiya i. A55-0008  date . 06/01/12                                      */ 
/*              ปรับส่วนการหาเลขที่สัญญาที่ทำให้ระบบช้า                                    */ 
/*modify by   : Kridtiya i. A55-0016  date . 16/01/12                                      */ 
/*              ปรับส่วนการออกงานสาขาตามไฟล์แจ้งและparameter[Setup Company and deler Code:]*/ 
/*modify by   : Kridtiya i. A55-0046  date . 10/02/12                                      */ 
/*              ปรับส่วนการหา กรมธรรม์ซ้ำในระบบ premium ด้วยเลขที่ กรมธรรม์                */ 
/*modify by   : Kridtiya i. A55-0073..เพิ่ม ฟิล์ด Product Type                             */
/*modify by   : Kridtiya i. A55-0108 ให้ค่าเริ่มต้นที่อยู่เป็นค่าว่าง */
/*modify by   : Kridtiya i. A55-0125 ตัดค่าว่างตัวแปรก่อนให้ค่า  */
/*modify by   : Kridtiya i. A55-0257..เพิ่ม ฟิล์ด เลขบัตรประชาชน,อาชีพ,ชื่อผู้ขับขี่       */
/*modify by   : Kridtiya i. A55-0310..ปิดการแสดงข้อความแจ้งการสร้างรหัสลูกค้า              */
/*Modify by   : Kridtiya i. A56-0047  Add check sicsyac.xmm600.clicod   = "IN"             */
/*Modify by   : Phaiboon W. A59-0488  Date 07/11/2016 Add Field Remark                     */
/*Modify by   : Ranu I. A62-0219 Date:13/05/2019 เพิ่มการเก็บค่าความคุ้มครอง เลขที่เอกสาร ข้อมูลการตรวจสภาพ จากไฟล์          */
/*Modify By   : Porntiwa T. A62-0105  Date : 18/07/2019 : Change Host => TMSth */
/*Modify by   : Ranu I. A62-0345 Date:13/05/2019 เพิ่มเงื่อนไขตัดคำนำหน้าชื่อของผู้แจ้งงาน                                 */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 เพิ่มเงื่อนไขการคำนวณเบี้ยจากโปรแกรมกลาง    */
/*Modify by   : Kridtiya i. A65-0035 comment message error premium not on file */
/* ***************************  Definitions  ***********************************************/
/* Parameters Definitions ---                                                              */
/* Local Variable Definitions ---                                                          */  
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.  
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno.  
DEFINE STREAM  ns1.                   
DEFINE STREAM  ns2.                   
DEFINE STREAM  ns3. 
DEF VAR chk     AS LOGICAL.
DEF VAR model   AS CHAR .
DEF VAR aa      AS DECI.
DEF VAR n_prem  AS DECI.
DEF VAR nv_uom1_v AS INTE INIT 0.     
DEF VAR nv_uom2_v AS INTE INIT 0.     
DEF VAR nv_uom5_v AS INTE INIT 0.
DEF SHARED Var   n_User    As CHAR . 
DEF VAR nv_comper  AS DECI INIT 0.                 
DEF VAR nv_comacc  AS DECI INIT 0.                 
DEF VAR nv_modcod  AS CHAR FORMAT "x(8)" INIT "" .  
DEF NEW SHARED VAR nv_seat41 AS INTEGER FORMAT ">>9".            
DEF NEW SHARED VAR nv_totsi  AS DECIMAL FORMAT ">>,>>>,>>9.99-".   
DEF NEW SHARED VAR nv_polday AS INTE    FORMAT ">>9".             
def New SHARED VAR nv_uom6_u as char.                            
def var nv_chk as  logic.                                         
DEF VAR nv_ncbyrs AS INTE.                                        
DEF NEW  SHARED VAR nv_odcod    AS CHAR     FORMAT "X(4)".                               
DEF NEW  SHARED VAR nv_cons     AS CHAR     FORMAT "X(2)".                               
DEF New  shared VAR nv_prem     AS DECIMAL  FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_baseap   AS DECI     FORMAT ">>,>>>,>>9.99-".                    
DEF New  shared VAR nv_ded      AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_gapprm   AS DECI     FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_pdprm    AS DECI     FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_prvprm   AS DECI     FORMAT ">>,>>>,>>9.99-".                     
DEF NEW  SHARED VAR nv_41prm    AS INTEGER  FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_ded1prm  AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_aded1prm AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO. 
DEF New  SHARED VAR nv_ded2prm  AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_dedod    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_addod    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_dedpd    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_prem1    AS DECIMAL  FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_addprm   AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_totded   AS INTEGER  FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_totdis   AS INTEGER  FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_41cod1   AS CHARACTER    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_41cod2   AS CHARACTER    FORMAT "X(4)".
DEF New  SHARED VAR nv_41       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_411prm   AS DECI         FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR nv_412prm   AS DECI         FORMAT ">,>>>,>>9.99".
DEF New  SHARED VAR nv_411var1  AS CHAR         FORMAT "X(30)".
DEF New  SHARED VAR nv_411var2  AS CHAR         FORMAT "X(30)".
DEF NEW  SHARED VAR nv_411var   AS CHAR         FORMAT "X(60)".
DEF New  SHARED VAR nv_412var1  AS CHAR         FORMAT "X(30)".
DEF NEW  SHARED VAR nv_412var2  AS CHAR         FORMAT "X(30)".
DEF New  SHARED VAR nv_412var   AS CHAR         FORMAT "X(60)".
DEF NEW  SHARED VAR nv_42cod    AS CHARACTER    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_42       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_42prm    AS DECI         FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR nv_42var1   AS CHAR         FORMAT "X(30)".
DEF New  SHARED VAR nv_42var2   AS CHAR         FORMAT "X(30)".
DEF NEW  SHARED VAR nv_42var    AS CHAR         FORMAT "X(60)".
DEF New  SHARED VAR nv_43cod    AS CHARACTER    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_43       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_43prm    AS DECI         FORMAT ">,>>>,>>9.99".
DEF New  SHARED VAR nv_43var1   AS CHAR         FORMAT "X(30)".
DEF NEW  SHARED VAR nv_43var2   AS CHAR         FORMAT "X(30)".
DEF New  SHARED VAR nv_43var    AS CHAR         FORMAT "X(60)".
DEF NEW  SHARED VAR nv_campcod   AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_camprem   AS DECI        FORMAT ">>>9".
DEF New  SHARED VAR nv_campvar1  AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_campvar2  AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_campvar   AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_compcod   AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_compprm   AS DECI        FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR nv_compvar1  AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_compvar2  AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_compvar   AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_basecod   AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_baseprm   AS DECI        FORMAT ">>,>>>,>>9.99-". 
DEF New  SHARED VAR nv_basevar1  AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_basevar2  AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_basevar   AS CHAR        FORMAT "X(60)".
/******** load ***********/
DEF NEW  SHARED VAR   nv_cl_cod   AS CHAR       FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_cl_per   AS DECIMAL    FORMAT ">9.99".
DEF New  SHARED VAR   nv_lodclm   AS INTEGER    FORMAT ">>>,>>9.99-".
DEF             VAR   nv_lodclm1  AS INTEGER    FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR   nv_clmvar1  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar2  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar   AS CHAR       FORMAT "X(60)".
/*********** staff ***********/
DEF NEW  SHARED VAR   nv_stf_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_stf_per  AS DECIMAL   FORMAT ">9.99".
DEF New  SHARED VAR   nv_stf_amt  AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_stfvar1  AS CHAR      FORMAT "X(30)".
DEF New  SHARED VAR   nv_stfvar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_stfvar   AS CHAR      FORMAT "X(60)".
/*********** dsic ***********/
DEF NEW  SHARED VAR   nv_dss_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_dss_per  AS DECIMAL   FORMAT ">9.99".
DEF New  SHARED VAR   nv_dsspc    AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_dsspcvar1 AS CHAR     FORMAT "X(30)".
DEF New  SHARED VAR   nv_dsspcvar2 AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_dsspcvar  AS CHAR     FORMAT "X(60)".
/*********** NCB ***********/
DEF NEW  SHARED VAR   nv_ncb_cod  AS CHAR  FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_ncbper   LIKE sicuw.uwm301.ncbper.
DEF New  SHARED VAR   nv_ncb      AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_ncbvar1  AS CHAR  FORMAT "X(30)".
DEF New  SHARED VAR   nv_ncbvar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_ncbvar   AS CHAR  FORMAT "X(60)".
/***********fleet***********/
DEF NEW  SHARED VAR   nv_flet_cod AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_flet_per AS DECIMAL FORMAT ">>9".
DEF New  SHARED VAR   nv_flet     AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_fletvar1 AS CHAR    FORMAT "X(30)".
DEF New  SHARED VAR   nv_fletvar2 AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_fletvar  AS CHAR    FORMAT "X(60)".
/***********nv_comp***********/
DEF NEW   SHARED VAR  nv_vehuse LIKE sicuw.uwm301.vehuse.                 
DEF NEW   SHARED VAR  nv_grpcod  AS CHARACTER FORMAT "X(4)".
DEF NEW   SHARED VAR  nv_grprm   AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW   SHARED VAR  nv_grpvar1 AS CHAR      FORMAT "X(30)".
DEF NEW   SHARED VAR  nv_grpvar2 AS CHAR      FORMAT "X(30)".
DEF NEW   SHARED VAR  nv_grpvar  AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_othcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_othprm  AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_othvar1 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_othvar2 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_othvar  AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_dedod1_cod AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedod1_prm AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedod1var1 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod1var2 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod1var  AS CHAR   FORMAT "X(60)".            
DEF NEW  SHARED VAR   nv_dedod2_cod AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedod2_prm AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedod2var1 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod2var2 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod2var  AS CHAR   FORMAT "X(60)".            
DEF NEW  SHARED VAR   nv_dedpd_cod  AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedpd_prm  AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedpdvar1  AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedpdvar2  AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedpdvar   AS CHAR   FORMAT "X(60)".            
/*********usfbas************/
DEF NEW SHARED VAR nv_tariff     LIKE sicuw.uwm301.tariff.
DEF NEW SHARED VAR nv_comdat     LIKE sicuw.uwm100.comdat.
DEF NEW SHARED VAR nv_covcod     LIKE sicuw.uwm301.covcod.
DEF NEW SHARED VAR nv_class      AS CHAR    FORMAT "X(4)".
DEF NEW SHARED VAR nv_key_b      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEF NEW SHARED VAR nv_drivno     AS INT       .
DEF NEW SHARED VAR nv_drivcod    AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_drivprm    AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_drivvar1   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_drivvar2   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_drivvar    AS CHAR  FORMAT "X(60)".
/*------usecod--------------------*/
DEF NEW SHARED VAR   nv_usecod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_useprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_usevar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_usevar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_usevar   AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_sicod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_siprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_sivar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_sivar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_sivar   AS CHAR  FORMAT "X(60)".
def New  shared var   nv_uom6_c  as  char.      /* Sum  si*/
def New  shared var   nv_uom7_c  as  char.      /* Fire/Theft*/
DEF NEW  SHARED VAR   nv_bipcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_bipprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_bipvar1 AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_bipvar2 AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_bipvar  AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_biacod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_biaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_biavar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_biavar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_biavar   AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_pdacod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_pdaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_pdavar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_pdavar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_pdavar   AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_engine LIKE sicsyac.xmm102.engine.       
DEF NEW SHARED VAR nv_tons   LIKE sicsyac.xmm102.tons.         
DEF NEW SHARED VAR nv_seats  LIKE sicsyac.xmm102.seats.        
DEF NEW SHARED VAR nv_sclass  AS CHAR FORMAT "x(3)".            
DEF NEW SHARED VAR nv_engcod  AS CHAR FORMAT "x(4)".            
DEF NEW SHARED VAR nv_engprm  AS DECI  FORMAT ">>,>>>,>>9.99-". 
DEF NEW SHARED VAR nv_engvar1 AS CHAR  FORMAT "X(30)".          
DEF NEW SHARED VAR nv_engvar2 AS CHAR  FORMAT "X(30)".          
DEF NEW SHARED VAR nv_engvar  AS CHAR  FORMAT "X(60)".          
DEF VAR  NO_CLASS AS CHAR INIT "".                              
DEF VAR no_tariff AS CHAR INIT "".
def  New  shared var  nv_poltyp   as   char   init  "".
DEF NEW SHARED VAR nv_yrcod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_yrprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_yrvar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar   AS CHAR  FORMAT "X(60)".
DEF New shared VAR nv_caryr   AS INTE  FORMAT ">>>9" .
def var  s_recid1       as RECID .     /* uwm100  */
def var  s_recid2       as recid .     /* uwm120  */
def var  s_recid3       as recid .     /* uwm130  */  
def var  s_recid4       as recid .     /* uwm301  */                                 
def New shared  var nv_dspc      as  deci.
def New shared  var nv_mv1       as  int .
def New shared  var nv_mv1_s     as  int . 
def New shared  var nv_mv2       as  int . 
def New shared  var nv_mv3       as  int . 
def New shared  var nv_comprm    as  int .  
def New shared  var nv_model     as  char.  
DEF VAR nv_lnumber AS   INTE INIT 0.
DEF VAR nv_provi   AS   CHAR INIT "".
DEF VAR n_rencnt   LIKE sicuw.uwm100.rencnt INITIAL "".
def var nv_index   as   int  init  0. 
DEF VAR n_endcnt   LIKE sicuw.uwm100.endcnt INITIAL "".
def var n_comdat   LIKE sicuw.uwm100.comdat  NO-UNDO.
def var n_policy   LIKE sicuw.uwm100.policy  INITIAL "" .
DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEF VAR nv_reccnt   AS  INT  INIT  0.          /*all load record*/
DEF VAR nv_completecnt    AS   INT   INIT  0.  /*complete record */
DEF NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".  /*amparat c. a51-0253*/
def NEW SHARED  var nv_modulo    as int  format "9".
def var s_riskgp    AS INTE FORMAT ">9".
def var s_riskno    AS INTE FORMAT "999".
def var s_itemno    AS INTE FORMAT "999". 
DEF VAR nv_drivage1 AS INTE INIT 0.
DEF VAR nv_drivage2 AS INTE INIT 0.
DEF VAR nv_drivbir1 AS CHAR INIT "".
DEF VAR nv_drivbir2 AS CHAR INIT "".
def var nv_dept     as char format  "X(1)".
def NEW SHARED var  nv_branch     LIKE sicsyac.XMM023.BRANCH.  
def var nv_undyr    as    char  init  ""    format   "X(4)".
def var n_newpol    Like  sicuw.uwm100.policy  init  "".
def var n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.
def New shared  var      nv_makdes    as   char    .
def New shared  var      nv_moddes    as   char.
DEF Var nv_lastno As       Int.
Def Var nv_seqno  As       Int.
DEF VAR sv_xmm600 AS       RECID.
/*--------- 722 --------*/
{wgw\wgwpogen.i}      /*ประกาศตัวแปร*/

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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.comment wdetail.poltyp wdetail.policy wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.iadd1 wdetail.iadd2 wdetail.iadd3 wdetail.iadd4 wdetail.prempa wdetail.subclass wdetail.redbook wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.engno wdetail.chasno wdetail.caryear wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.access wdetail.deductpp wdetail.deductba wdetail.deductpa wdetail.benname wdetail.n_IMPORT wdetail.n_export wdetail.producer wdetail.agent WDETAIL.WARNING wdetail.cancel   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_tpp fi_tba fi_bchno fi_tpa ~
fi_branch fi_producer fi_agent fi_prevbat fi_bchyr fi_filename bu_file ~
fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit ~
br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent fi_pa41 fi_pa42 fi_pa43 RECT-370 ~
RECT-372 RECT-373 RECT-375 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_tpp fi_tba fi_bchno fi_tpa ~
fi_branch fi_producer fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 ~
fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_proname ~
fi_agtname fi_show fi_completecnt fi_premtot fi_premsuc fi_pa41 fi_pa42 ~
fi_pa43 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 5 BY .95.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(19)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 72 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pa41 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_pa42 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_pa43 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_show AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 86 BY .95
     BGCOLOR 3 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tba AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tpa AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tpp AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 13.43
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 5.86
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-375
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 3.1
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 6 FGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.comment FORMAT "x(50)" COLUMN-BGCOLOR  80 
      wdetail.poltyp  COLUMN-LABEL "Policy Type"
      wdetail.policy  COLUMN-LABEL "Policy"
      wdetail.tiname  COLUMN-LABEL "Title Name"   
      wdetail.insnam  COLUMN-LABEL "Insured Name" 
      wdetail.comdat  COLUMN-LABEL "Comm Date"
      wdetail.expdat  COLUMN-LABEL "Expiry Date"
      wdetail.compul  COLUMN-LABEL "Compulsory"
      wdetail.iadd1   COLUMN-LABEL "Ins Add1"
      wdetail.iadd2   COLUMN-LABEL "Ins Add2"
      wdetail.iadd3   COLUMN-LABEL "Ins Add3"
      wdetail.iadd4   COLUMN-LABEL "Ins Add4"
      wdetail.prempa  COLUMN-LABEL "Premium Package"
      wdetail.subclass COLUMN-LABEL "Sub Class"
      wdetail.redbook COLUMN-LABEL "RedBook"
      wdetail.brand   COLUMN-LABEL "Brand"
      wdetail.model   COLUMN-LABEL "Model"
      wdetail.cc      COLUMN-LABEL "CC"
      wdetail.weight  COLUMN-LABEL "Weight"
      wdetail.seat    COLUMN-LABEL "Seat"
      wdetail.body    COLUMN-LABEL "Body"
      wdetail.vehreg  COLUMN-LABEL "Vehicle Register"
      wdetail.engno   COLUMN-LABEL "Engine NO."
      wdetail.chasno  COLUMN-LABEL "Chassis NO."
      wdetail.caryear COLUMN-LABEL "Car Year" 
      wdetail.vehuse  COLUMN-LABEL "Vehicle Use" 
      wdetail.garage  COLUMN-LABEL "Garage"
      wdetail.stk     COLUMN-LABEL "Sticker"
      wdetail.covcod  COLUMN-LABEL "Cover Type"
      wdetail.si      COLUMN-LABEL "Sum Insure"
      wdetail.access COLUMN-LABEL "Load Claim"
      wdetail.deductpp  COLUMN-LABEL "Deduct TP"
      wdetail.deductba   COLUMN-LABEL "Deduct DA"
      wdetail.deductpa   COLUMN-LABEL "Deduct PD"
      wdetail.benname COLUMN-LABEL "Benefit Name" 
      wdetail.n_IMPORT COLUMN-LABEL "Import"
      wdetail.n_export COLUMN-LABEL "Export"
      wdetail.producer COLUMN-LABEL "Producer"
      wdetail.agent    COLUMN-LABEL "Agent"
      WDETAIL.WARNING   COLUMN-LABEL "Warning"
      wdetail.cancel  COLUMN-LABEL "Cancel"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 5.33
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 2.81 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_tpp AT ROW 2.81 COL 60.83 COLON-ALIGNED NO-LABEL
     fi_tba AT ROW 2.81 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.91 COL 17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_tpa AT ROW 2.81 COL 94.67 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 5 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 6.05 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 7.1 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 8.14 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 8.14 COL 67.5 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.19 COL 31.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9.19 COL 94.17
     fi_output1 AT ROW 10.19 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.24 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.29 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 13.52 COL 32 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 13.52 COL 70.17 NO-LABEL
     buok AT ROW 9.24 COL 104.67
     bu_exit AT ROW 11.52 COL 104.67
     fi_brndes AT ROW 5 COL 43.33 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 16.14 COL 1.83
     bu_hpbrn AT ROW 5 COL 40.33
     fi_impcnt AT ROW 22.33 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpacno1 AT ROW 6.05 COL 48.17
     bu_hpagent AT ROW 7.1 COL 48.17
     fi_proname AT ROW 6.05 COL 50.5 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 7.05 COL 50.5 COLON-ALIGNED NO-LABEL
     fi_show AT ROW 14.67 COL 12.5 NO-LABEL
     fi_completecnt AT ROW 23.33 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.33 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.38 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_pa41 AT ROW 3.91 COL 53.67 COLON-ALIGNED NO-LABEL
     fi_pa42 AT ROW 3.91 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_pa43 AT ROW 3.91 COL 96.67 COLON-ALIGNED NO-LABEL
     "                     Branch  :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 5 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 11.24 COL 10
          BGCOLOR 8 FGCOLOR 1 
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 13.52 COL 87.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 13.52 COL 68.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Cov_pack Z :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 2.81 COL 61.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "          Producer  Code :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 6.05 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TieS 4 01/03/2022" VIEW-AS TEXT
          SIZE 18 BY 1.19 AT ROW 14.57 COL 103.83
          BGCOLOR 8 FGCOLOR 2 
     "               Agent Code  :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 7.1 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.33 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Previous Batch No.  :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 8.14 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 23.33 COL 116.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "    IMPORT TEXT FILE MOTOR [BY New Telephone ... ]" VIEW-AS TEXT
          SIZE 120.67 BY .95 AT ROW 1.24 COL 2.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 8.14 COL 68 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 23.33 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.91 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 22.33 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "  Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 9.19 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 2.81 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 23.33 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " รย43 :" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 3.91 COL 97 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " รย41 :" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 3.91 COL 54 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 10.19 COL 10
          BGCOLOR 8 FGCOLOR 1 
     " รย42 :" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 3.91 COL 75.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 22.33 COL 116.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 13.52 COL 32 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 12.29 COL 10
          BGCOLOR 8 FGCOLOR 1 
     RECT-370 AT ROW 1 COL 1.17
     RECT-372 AT ROW 2.52 COL 1.17
     RECT-373 AT ROW 15.91 COL 1.17
     RECT-375 AT ROW 21.76 COL 1.17
     RECT-376 AT ROW 22.1 COL 3.33
     RECT-377 AT ROW 9 COL 103.5
     RECT-378 AT ROW 11.24 COL 103.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.


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
  CREATE WINDOW c-win ASSIGN
         HIDDEN             = YES
         TITLE              = "IMPORT TEXT FILE MOTOR [BY New Telephone ... ]"
         HEIGHT             = 23.95
         WIDTH              = 133.17
         MAX-HEIGHT         = 33.71
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.71
         VIRTUAL-WIDTH      = 170.67
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = 139
         FGCOLOR            = 133
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_wdetail fi_brndes fr_main */
ASSIGN 
       br_wdetail:COLUMN-RESIZABLE IN FRAME fr_main       = TRUE.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agtname IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_bchno:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_brndes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premsuc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premtot IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_show IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "Cov_pack Z :"
          SIZE 13 BY .95 AT ROW 2.81 COL 61.17 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL " รย41 :"
          SIZE 6 BY .95 AT ROW 3.91 COL 54 RIGHT-ALIGNED                */

/* SETTINGS FOR TEXT-LITERAL " รย42 :"
          SIZE 6 BY .95 AT ROW 3.91 COL 75.5 RIGHT-ALIGNED              */

/* SETTINGS FOR TEXT-LITERAL " รย43 :"
          SIZE 6 BY .95 AT ROW 3.91 COL 97 RIGHT-ALIGNED                */

/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.83 BY .95 AT ROW 8.14 COL 68 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "    Policy Import Total :"
          SIZE 23 BY .95 AT ROW 13.52 COL 32 RIGHT-ALIGNED              */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .95 AT ROW 13.52 COL 68.67 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.33 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 22.33 COL 95.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 23.33 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 23.33 COL 96 RIGHT-ALIGNED          */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-win)
THEN c-win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_query FOR EACH wdetail
    .
    /* WHERE wdetail2.policyno = wdetail.policyno.*/
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-win c-win
ON END-ERROR OF c-win /* IMPORT TEXT FILE MOTOR [BY New Telephone ... ] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-win c-win
ON WINDOW-CLOSE OF c-win /* IMPORT TEXT FILE MOTOR [BY New Telephone ... ] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_wdetail
&Scoped-define SELF-NAME br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_wdetail c-win
ON ROW-DISPLAY OF br_wdetail IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    IF WDETAIL.WARNING <> "" THEN DO:

          /*wdetail.entdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.enttim:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.trandat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.trantim:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. *//*a490166*/
          wdetail.comment:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.poltyp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.tiname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.insnam:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.comdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.expdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.compul:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.iadd1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.iadd2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.iadd3:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.iadd4:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.prempa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.subclass:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.redbook:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.brand:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.model:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.cc:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
          wdetail.weight:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.seat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.body:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.vehreg:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.engno:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.chasno:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.caryear:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.vehuse:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.garage:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.stk:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.covcod:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.si:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
          wdetail.access :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.deductpp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductba:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductpa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductpa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.benname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.n_IMPORT:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_export:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.producer:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.agent:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          WDETAIL.CANCEL:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  /*new add*/ 
          

          /*wdetail.entdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.enttim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trandat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trantim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. *//*a490166*/ 
          wdetail.comment:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.poltyp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.tiname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.insnam:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.expdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.    
          wdetail.compul:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  

          wdetail.iadd1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd3:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd4:FGCOLOR IN BROWSE BR_WDETAIL = s  NO-ERROR.  
          wdetail.prempa:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.subclass:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
          wdetail.redbook:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
          wdetail.brand:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.model:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.cc:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.weight:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.seat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.body:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehreg:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.engno:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.chasno:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.caryear:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehuse:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.garage:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.stk:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.covcod:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.si:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.access:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
          wdetail.deductpp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductba:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductpa:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.benname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_IMPORT:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_export:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.producer:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.agent:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          WDETAIL.WARNING:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          WDETAIL.CANCEL:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
         
            
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    ASSIGN
        fi_completecnt:FGCOLOR = 2
        fi_premsuc:FGCOLOR     = 2 
        fi_bchno:FGCOLOR       = 2
        fi_completecnt         = 0
        fi_premsuc             = 0
        fi_bchno               = ""
        fi_premtot             = 0
        fi_impcnt              = 0 .
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
    IF fi_branch = " " THEN DO: 
        MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_branch.
        RETURN NO-APPLY.
    END.
    IF fi_producer = " " THEN DO:
        MESSAGE "Producer code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_producer.
        RETURN NO-APPLY.
    END.
    IF fi_agent = " " THEN DO:
        MESSAGE "Agent code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_Agent.
        RETURN NO-APPLY.
    END.
    IF fi_loaddat = ? THEN DO:
        MESSAGE "Load Date Is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" to fi_loaddat.
        RETURN NO-APPLY.
    END.
    IF fi_bchyr <= 0 THEN DO:
        MESSAGE "Batch Year Can't be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_bchyr.
        RETURN NO-APPLY.
    END.
    /*IF fi_usrcnt <= 0  THEN DO:
        MESSAGE "Policy Count can't Be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_usrcnt.
        RETURN NO-APPLY.
    END.
    IF fi_usrprem <= 0  THEN DO:
        MESSAGE "Total Net Premium can't Be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_usrprem.
        RETURN NO-APPLY.
    END.*/
    ASSIGN  fi_output1 = INPUT fi_output1
        fi_output2 = INPUT fi_output2
        fi_output3 = INPUT fi_output3.
    IF fi_output1 = "" THEN DO:
        MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output1.
        RETURN NO-APPLY.
    END.
    IF fi_output2 = "" THEN DO:
        MESSAGE "Plese Input File Data Not Load...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output2.
        RETURN NO-APPLY.
    END.
    IF fi_output3 = "" THEN DO:
        MESSAGE "Plese Input Batch File Name...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output3.
        RETURN NO-APPLY.
    END.
    ASSIGN nv_batchyr = INPUT fi_bchyr.
    IF nv_batprev = "" THEN DO:  
        FIND LAST uzm700 USE-INDEX uzm70001    WHERE
            uzm700.bchyr   = nv_batchyr        AND
            uzm700.branch  = TRIM(nv_batbrn)   AND
            uzm700.acno    = TRIM(fi_producer) NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:   
            ASSIGN nv_batrunno = uzm700.runno .
            FIND LAST uzm701 USE-INDEX uzm70102   WHERE 
                uzm701.bchyr   = nv_batchyr        AND
                uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN 
                ASSIGN 
                nv_batcnt   = uzm701.bchcnt 
                nv_batrunno = nv_batrunno + 1.
        END.
        ELSE ASSIGN nv_batcnt   = 1
                    nv_batrunno = 1 .
        nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END. 
    ELSE DO:  
        ASSIGN nv_batprev = INPUT fi_prevbat.
        FIND LAST uzm701 USE-INDEX uzm70102  WHERE
            uzm701.bchyr   = nv_batchyr      AND
            uzm701.bchno = CAPS(nv_batprev)  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL uzm701 THEN DO:
            MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev) + " on file uzm701" .
            APPLY "entry" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
        IF AVAIL uzm701 THEN 
            ASSIGN nv_batcnt  = uzm701.bchcnt + 1 
            nv_batchno = CAPS(TRIM(nv_batprev)).
    END.
    ASSIGN
        fi_loaddat   = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
        fi_producer  = INPUT fi_producer    fi_agent        = INPUT fi_agent 
        fi_bchyr     = INPUT fi_bchyr       fi_prevbat      = INPUT fi_prevbat
        fi_usrcnt    = INPUT fi_usrcnt      fi_usrprem      = INPUT fi_usrprem
        nv_imppol    = fi_usrcnt            nv_impprem      = fi_usrprem 
        nv_tmppolrun = 0                    nv_daily        = ""
        nv_reccnt    = 0                    nv_completecnt  = 0
        nv_netprm_t  = 0                    nv_netprm_s     = 0
        nv_batbrn    = fi_branch .
    For each  wdetail :
        DELETE  wdetail.
    End.
    For each  wdetail2 :
        DELETE  wdetail2.
    END.
    RUN proc_assign. 
    /*ASSIGN
       wdetail2.comment  = ""
       wdetail2.agent    = fi_agent
       wdetail2.producer = fi_producer     
       wdetail2.entdat   = string(TODAY)                /*entry date*/
       wdetail2.enttim   = STRING (TIME, "HH:MM:SS")    /*entry time*/
       wdetail2.trandat  = STRING (fi_loaddat)          /*tran date*/
       wdetail2.trantim  = STRING (TIME, "HH:MM:SS")    /*tran time*/
       wdetail2.n_IMPORT = "IM"
       wdetail2.n_EXPORT = "" .   */
    FOR EACH wdetail:    
        IF WDETAIL.POLTYP = "70" OR WDETAIL.POLTYP = "72" THEN DO:
            ASSIGN nv_reccnt      =  nv_reccnt   + 1
                nv_netprm_t    =  nv_netprm_t + decimal(wdetail.volprem)  
                wdetail.pass   = "Y"
                WDETAIL.POLTYP = "V" + WDETAIL.POLTYP.     
        END.
        ELSE DO :    
            DELETE WDETAIL.
        END.
    END.
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    /* comment by : A64-0138...
    /*Add by Kridtiya i. A63-0472*/
    ELSE DO:
        nv_chkerror = "".
        FOR EACH wdetail :
            RUN wgw\wgwchkagpd  (INPUT wdetail.agent  
                                 ,INPUT wdetail.producer
                                 ,INPUT-OUTPUT nv_chkerror).
            IF nv_chkerror <> "" THEN 
                MESSAGE "Error Code Producer/Agent :" nv_chkerror  SKIP
                wdetail.producer SKIP
                wdetail.agent  
                VIEW-AS ALERT-BOX.     
        END.
        IF nv_chkerror <> ""  THEN DO: 
            nv_reccnt = 0.
            MESSAGE "Error Code Producer/Agent :" nv_chkerror VIEW-AS ALERT-BOX.       
            RETURN NO-APPLY.
        END.
    END.
    /*Add by Kridtiya i. A63-0472*/
    ...end A54-0138...*/
    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                           INPUT            nv_batchyr ,     /* INT   */
                           INPUT            fi_producer,     /* CHAR  */ 
                           INPUT            nv_batbrn  ,     /* CHAR  */
                           INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                           INPUT            "WGWPOGEN" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem       /* DECI  */
                           ).
    ASSIGN fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.
    RUN proc_chktest1.
    FOR EACH wdetail WHERE wdetail.pass = "y"  :
        ASSIGN nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + decimal(wdetail.volprem) . 
    END.
    ASSIGN nv_rectot = nv_reccnt
        nv_recsuc = nv_completecnt. 
    IF /*nv_imppol <> nv_rectot OR
       nv_imppol <> nv_recsuc OR*/
       nv_rectot <> nv_recsuc   THEN DO:
        nv_batflg = NO.
        /*MESSAGE "Policy import record is not match to Total record !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE 
    IF /*nv_impprem  <> nv_netprm_t OR
       nv_impprem  <> nv_netprm_s OR*/
       nv_netprm_t <> nv_netprm_s THEN DO:
        nv_batflg = NO.
    /*MESSAGE "Total net premium is not match to Total net premium !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE 
        nv_batflg = YES.
    FIND LAST uzm701 USE-INDEX uzm70102 WHERE
              uzm701.bchyr   = nv_batchyr AND
              uzm701.bchno   = nv_batchno AND
              uzm701.bchcnt  = nv_batcnt NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        ASSIGN
          uzm701.recsuc      = nv_recsuc     
          uzm701.premsuc     = nv_netprm_s   
          uzm701.rectot      = nv_rectot     
          uzm701.premtot     = nv_netprm_t   
          uzm701.impflg      = nv_batflg    
          uzm701.cnfflg      = nv_batflg .   
    END.  
    ASSIGN
    fi_impcnt      = nv_rectot
    fi_premtot     = nv_netprm_t
    fi_completecnt = nv_recsuc
    fi_premsuc     = nv_netprm_s .
    IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.
    RELEASE sicsyac.xzm056.
    RELEASE sicsyac.xmm600.
    RELEASE sicsyac.xtm600.
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno      :FGCOLOR = 6. 
        ASSIGN fi_show = "Please check Data again...ERROR.."  .
        DISP fi_show fi_completecnt fi_premsuc WITH FRAME fr_main.
        MESSAGE "Batch Year  : " STRING(nv_batchyr)     SKIP
                "Batch No.   : " nv_batchno             SKIP
                "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
                TRIM(nv_txtmsg)                         SKIP
                "Please check Data again."      
        VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".        
    END.
    ELSE IF nv_batflg = YES THEN DO: 
        ASSIGN  fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2.
        ASSIGN fi_show = "Process Complete.....".
        DISP fi_show WITH FRAM fr_main.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.
    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    /*output*/
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS    /* "CSV (Comma Delimited)"   "*.csv",
                            "Data Files (*.dat)"     "*.dat",*/
                    "Text Files (*.txt)" "*.csv"
                    
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         /***--- 08/11/2006 ---***/
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

         /***---a490166 ---***/
         ASSIGN
            fi_filename  = cvData
            fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
            fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
            fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/

         DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.

    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 c-win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno, /*a490166 note modi*/ /*28/11/2006*/
                    output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent c-win
ON CHOOSE OF bu_hpagent IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,   /*a490166 note modi*/
                    output  n_agent). 
                                          
     If  n_acno  <>  ""  Then  fi_agent =  n_acno.
     
     disp  fi_agent  with frame  fr_main.

     Apply "Entry"  to  fi_agent.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn c-win
ON CHOOSE OF bu_hpbrn IN FRAME fr_main
DO:
   Run  whp\whpbrn01(Input-output  fi_branch, /*a490166 note modi*/
                     Input-output   fi_brndes).
                                     
   Disp  fi_branch  fi_brndes  with frame  fr_main.                                     
   Apply "Entry"  To  fi_producer.
   Return no-apply.                            
                                        

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent c-win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    ASSIGN fi_agent = "B3M0006".
    fi_agent = INPUT fi_agent.
    IF fi_agent <> ""    THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
         sicsyac.xmm600.acno  =  Input fi_agent  
    NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
             Message  "Not on Name & Address Master File xmm600" 
             View-as alert-box.
             Apply "Entry" To  fi_agent.
             RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO: /*note modi on 10/11/2005*/
            ASSIGN
            fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
            fi_agent   =  caps(INPUT  fi_agent) /*note modi 08/11/05*/
            /*nv_agent   =  fi_agent*/    .             /*note add  08/11/05*/
            
        END. /*end note 10/11/2005*/
    END. /*Then fi_agent <> ""*/
    
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr c-win
ON LEAVE OF fi_bchyr IN FRAME fr_main
DO:
        nv_batchyr = INPUT fi_bchyr.
        IF nv_batchyr <= 0 THEN DO:
           MESSAGE "Batch Year Error...!!!".
           APPLY "entry" TO fi_bchyr.
           RETURN NO-APPLY.
        END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch c-win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
  IF  Input fi_branch  =  ""  Then do:
       Message "กรุณาระบุ Branch Code ." View-as alert-box.
       Apply "Entry"  To  fi_branch.
  END.
  Else do:
  FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
       sicsyac.xmm023.branch   =  Input  fi_branch 
       NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
               Message  "Not on Description Master File xmm023" 
               View-as alert-box.
               Apply "Entry"  To  fi_branch.
               RETURN NO-APPLY.
        END.
  fi_branch  =  CAPS(Input fi_branch) .
  fi_brndes  =  sicsyac.xmm023.bdes.
  End. /*else do:*/

  Disp fi_branch  fi_brndes  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat c-win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
  fi_loaddat  =  Input  fi_loaddat.
  Disp  fi_loaddat  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pa41
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pa41 c-win
ON LEAVE OF fi_pa41 IN FRAME fr_main
DO:
    fi_pa41 = INPUT fi_pa41.
    DISP fi_pa41 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pa42
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pa42 c-win
ON LEAVE OF fi_pa42 IN FRAME fr_main
DO:
    fi_pa42 = INPUT fi_pa42.
    DISP fi_pa42 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pa43
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pa43 c-win
ON LEAVE OF fi_pa43 IN FRAME fr_main
DO:
    fi_pa43 = INPUT fi_pa43.
    DISP fi_pa43 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat c-win
ON LEAVE OF fi_prevbat IN FRAME fr_main
DO:
    fi_prevbat = caps(INPUT fi_prevbat).
    nv_batprev = fi_prevbat.
    IF nv_batprev <> " "  THEN DO:
        IF LENGTH(nv_batprev) <> 13 THEN DO:
             MESSAGE "Length Of Batch no. Must Be 13 Character " SKIP
                     "Please Check Batch No. Again             " view-as alert-box.
             APPLY "entry" TO fi_prevbat.
             RETURN NO-APPLY.
        END.
    END. /*nv_batprev <> " "*/
    
    DISPLAY fi_prevbat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    ASSIGN fi_producer = "A0M1053".
  fi_producer = INPUT fi_producer.
  IF  fi_producer <> " " THEN DO:
  FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
       sicsyac.xmm600.acno  =  Input fi_producer  
  NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicsyac.xmm600 THEN DO:
                Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
                Apply "Entry" To  fi_producer.
                RETURN NO-APPLY. /*note add on 10/11/2005*/
            END.
            ELSE DO:
                ASSIGN
                fi_proname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  caps(INPUT  fi_producer) /*note modi 08/11/05*/
                /*nv_producer = fi_producer*/   .             /*note add  08/11/05*/
                
            END.
  END.

  Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tba
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tba c-win
ON LEAVE OF fi_tba IN FRAME fr_main
DO:
        fi_tba = INPUT fi_tba.
        DISP fi_tba WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tpa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tpa c-win
ON LEAVE OF fi_tpa IN FRAME fr_main
DO:
       fi_tpa = INPUT fi_tpa .
       DISP fi_tpa WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tpp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tpp c-win
ON LEAVE OF fi_tpp IN FRAME fr_main
DO:
        fi_tpp = INPUT fi_tpp.
        DISP fi_tpp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrcnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrcnt c-win
ON LEAVE OF fi_usrcnt IN FRAME fr_main
DO:
  fi_usrcnt = INPUT fi_usrcnt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrprem c-win
ON LEAVE OF fi_usrprem IN FRAME fr_main
DO:
  fi_usrprem = INPUT fi_usrprem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-win 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.
/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
    RUN disable_UI.
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
    ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    RUN enable_UI.
    
/********************  T I T L E   F O R  C - W I N  ****************/
DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)"  NO-UNDO.

ASSIGN gv_prgid = "WGWPOGEN"
    gv_prog  = "IMPORT TEXT FILE MOTOR [BY New Telephone ... ]"
    fi_loaddat = TODAY.
DISP fi_loaddat WITH FRAME fr_main.
RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).    
ASSIGN
    fi_branch   = "M"
    fi_producer = "B3M0009"
    fi_agent    = "B3M0009"
    fi_bchyr    = YEAR(TODAY) 
    fi_tpp      = 300000
    fi_tba      = 10000000
    fi_tpa      = 600000
    fi_pa41     = 50000  
    fi_pa42     = 50000
    fi_pa43     = 200000 
    fi_show     = "IMPORT TEXT FILE MOTOR [BY New Telephone ... ]... ".
DISP fi_branch fi_producer fi_agent fi_bchyr fi_show  fi_tpp fi_tba fi_tpa fi_pa43 fi_pa42 fi_pa41
    WITH FRAME fr_main.
/*********************************************************************/  
RUN  WUT\WUTWICEN (c-win:handle).  
Session:data-Entry-Return = Yes.
IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-win)
  THEN DELETE WIDGET c-win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-win  _DEFAULT-ENABLE
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
  DISPLAY fi_loaddat fi_tpp fi_tba fi_bchno fi_tpa fi_branch fi_producer 
          fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 
          fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_proname 
          fi_agtname fi_show fi_completecnt fi_premtot fi_premsuc fi_pa41 
          fi_pa42 fi_pa43 
      WITH FRAME fr_main IN WINDOW c-win.
  ENABLE fi_loaddat fi_tpp fi_tba fi_bchno fi_tpa fi_branch fi_producer 
         fi_agent fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 
         fi_output3 fi_usrcnt fi_usrprem buok bu_exit br_wdetail bu_hpbrn 
         bu_hpacno1 bu_hpagent fi_pa41 fi_pa42 fi_pa43 RECT-370 RECT-372 
         RECT-373 RECT-375 RECT-376 RECT-377 RECT-378 
      WITH FRAME fr_main IN WINDOW c-win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72 c-win 
PROCEDURE proc_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/************** v72 comp y **********/
ASSIGN
    wdetail.compul = "y"
    /*wdetail.tariff = "9"*/ 
    nv_modcod = " " . 
IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.subclass = "210" THEN wdetail.subclass = "140A".
    ELSE wdetail.subclass = "110".
    IF wdetail.compul <> "y" THEN 
        ASSIGN /*a490166*/
        wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N". 
END.
IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk <> "" THEN DO:    
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN 
                wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
                wdetail.pass    = ""
                wdetail.OK_GEN  = "N".
    END.    
END.
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail.subclass
    NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN 
        wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp  AND
        sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN 
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
            wdetail.OK_GEN  = "N".
END. 
/*---------- covcod ----------*/
wdetail.covcod = CAPS(wdetail.covcod).
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN 
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
        wdetail.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = "9"   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod  NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
        wdetail.OK_GEN = "N".
/*--------- modcod --------------*/
/*chkred = NO.
IF wdetail.redbook <> "" THEN DO:    /*กรณีที่มีการระบุ Code รถมา*/
    FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
        sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm102 THEN DO:
        ASSIGN  
            wdetail.pass    = "N"  
            wdetail.comment = wdetail.comment + "| not find on table xmm102 ไม่พบ Makes/Models นี้ในระบบ"
            wdetail.OK_GEN = "N"
            chkred = NO
            wdetail.redbook = " ".
    END. 
    ELSE DO:
        chkred = YES.
    END.
END.  
IF chkred = NO  THEN DO:
    FIND LAST sicsyac.xmm102 WHERE 
        sicsyac.xmm102.modest = wdetail.brand + wdetail.model AND
        sicsyac.xmm102.engine = INTE(wdetail.engcc)           AND 
        sicsyac.xmm102.tons   = INTE(wdetail.weight)         AND
        sicsyac.xmm102.seats  = INTE(wdetail.seat)
        NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm102  THEN DO:
      /*  MESSAGE "not find on table xmm102".
        ASSIGN /*a490166*/     
            wdetail.pass    = "N"  
            wdetail.comment = wdetail.comment + "| not find on table xmm102"
            wdetail.OK_GEN  = "N".     A52-0172*/
    END.
    ELSE DO:
            wdetail.redbook = sicsyac.xmm102.modcod. 
    END.
END.*/

IF      wdetail.subclass = "110" THEN wdetail.seat = "7".
ELSE IF wdetail.subclass = "210" THEN wdetail.seat = "12".
ELSE IF wdetail.subclass = "320" THEN wdetail.seat = "3".
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE 
        stat.maktab_fil.sclass = wdetail.subclass   AND 
        stat.maktab_fil.modcod = wdetail.redbook    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  
            nv_modcod        =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            /*chkred           =  YES     */               
            wdetail.brand    =  stat.maktab_fil.makdes
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
            wdetail.cc       =  STRING(stat.maktab_fil.engine)
            wdetail.weight   =  STRING(stat.maktab_fil.tons)
            wdetail.subclass =  stat.maktab_fil.sclass   
            wdetail.redbook  =  stat.maktab_fil.modcod                                    
            wdetail.seat     =  STRING(stat.maktab_fil.seats)
            nv_si            = maktab_fil.si.
        IF wdetail.covcod = "1"  THEN DO:
            FIND FIRST stat.makdes31 WHERE 
                stat.makdes31.makdes = "X"  AND     /*Lock X*/
                stat.makdes31.moddes = wdetail.prempa + wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE makdes31 THEN 
                ASSIGN  nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            ELSE 
                ASSIGN  nv_maxSI = nv_si
                    nv_minSI = nv_si.
        END.  /***--- End Check Rate SI ---***/
    END.
    ELSE nv_modcod = " ".
END.    /*red book <> ""*/   
IF nv_modcod = " " THEN DO:
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN 
        nv_simat  = makdes31.si_theft_p   
        nv_simat1 = makdes31.load_p   .    
    ELSE ASSIGN 
        nv_simat  = 0
        nv_simat1 = 0.
    Find LAST stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =   wdetail.brand            And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        nv_modcod       =  stat.maktab_fil.modcod                                    
        nv_moddes       =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp  =  stat.maktab_fil.prmpac
        wdetail.redbook =  stat.maktab_fil.modcod 
        wdetail.weight   =  STRING(stat.maktab_fil.tons)
        wdetail.body    =  stat.maktab_fil.body .
    
END.
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN     
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
        wdetail.OK_GEN  = "N".
ASSIGN
    nv_docno  = " "
    nv_accdat = TODAY.
/***--- Docno ---***/
IF wdetail.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M" AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999")
        NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN 
        
        ASSIGN /*a490166*/     
            wdetail.pass    = "N"  
            wdetail.comment = "Receipt is Dup. on uwm100 :" + string(sicuw.uwm100.policy,"x(16)") +
            STRING(sicuw.uwm100.rencnt,"99")  + "/" +
            STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
            wdetail.OK_GEN  = "N".
    ELSE 
        nv_docno = wdetail.docno.
END.
/***--- Account Date ---***/
IF wdetail.accdat <> " "  THEN nv_accdat = date(wdetail.accdat).
ELSE nv_accdat = TODAY.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 c-win 
PROCEDURE proc_722 :
/* ---------------------------------------------  U W M 1 3 0 -------------- */
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp      AND            /*0*/
    sic_bran.uwm130.riskno = s_riskno      AND            /*1*/
    sic_bran.uwm130.itemno = s_itemno      AND            /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr     AND            /*26/10/2006 change field name */
    sic_bran.uwm130.bchno  = nv_batchno     AND            /*26/10/2006 change field name */ 
    sic_bran.uwm130.bchcnt = nv_batcnt                     /*26/10/2006 change field name */            
    NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno.
    ASSIGN    /*a490166*/
        sic_bran.uwm130.bchyr = nv_batchyr         /* batch Year */
        sic_bran.uwm130.bchno = nv_batchno         /* bchno      */
        sic_bran.uwm130.bchcnt  = nv_batcnt .      /* bchcnt     */
    ASSIGN
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0     /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0     /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0     /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0     /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.    /*Item Endt. Clause*/
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class
        NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN 
        ASSIGN  
            sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
            sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9 
            nv_comper     = deci(sicsyac.xmm016.si_d_t[8]) 
            nv_comacc     = deci(sicsyac.xmm016.si_d_t[9])                                           
            sic_bran.uwm130.uom8_v   = nv_comper   
            sic_bran.uwm130.uom9_v   = nv_comacc  .   
    ASSIGN
        nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy,         /*a490166 Note modi*/
                                nv_riskno,
                                nv_itemno).
    END. /*transaction*/
    s_recid3  = RECID(sic_bran.uwm130).
    /* ---------------------------------------------  U W M 3 0 1 --------------*/ 
    nv_covcod =   wdetail.covcod.
    nv_makdes  =  wdetail.brand.
    nv_moddes  =  wdetail.model.
    /*--Str Amparat C. A51-0253--*/
    nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
    ELSE nv_newsck = wdetail.stk.
    /*--End Amparat C. A51-0253--*/       
    FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
        sic_bran.uwm301.policy = sic_bran.uwm100.policy          AND
        sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt          AND
        sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt          AND
        sic_bran.uwm301.riskgp = s_riskgp                        AND
        sic_bran.uwm301.riskno = s_riskno                        AND
        sic_bran.uwm301.itemno = s_itemno                        AND
        sic_bran.uwm301.bchyr = nv_batchyr                      AND 
        sic_bran.uwm301.bchno = nv_batchno                      AND 
        sic_bran.uwm301.bchcnt  = nv_batcnt                     
        NO-WAIT NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
        DO TRANSACTION:
            CREATE sic_bran.uwm301.
        END. /*transaction*/
    END.                                                          
    Assign            /*a490166 ใช้ร่วมกัน*/
        sic_bran.uwm301.policy  = sic_bran.uwm120.policy                   
        sic_bran.uwm301.rencnt  = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt  = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp  = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno  = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno  = s_itemno
        sic_bran.uwm301.tariff  = IF wdetail.poltyp = "V72" THEN "9" ELSE "X"  /*wdetail.tariff*/
        sic_bran.uwm301.covcod  = nv_covcod
        sic_bran.uwm301.cha_no  = wdetail.chasno
        sic_bran.uwm301.eng_no  = wdetail.eng
        sic_bran.uwm301.Tons    = INTEGER(wdetail.weight)
        sic_bran.uwm301.engine  = INTEGER(wdetail.cc)
        sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage  = ""
        sic_bran.uwm301.body    = wdetail.body
        sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = ""
        sic_bran.uwm301.vehreg   = wdetail.vehreg 
        sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        sic_bran.uwm301.moddes   = wdetail.model     
        sic_bran.uwm301.modcod   = wdetail.redbook 
        sic_bran.uwm301.sckno    = 0              
        sic_bran.uwm301.itmdel   = NO
        sic_bran.uwm301.bchyr    = nv_batchyr         /* batch Year */      
        sic_bran.uwm301.bchno    = nv_batchno         /* bchno    */      
        sic_bran.uwm301.bchcnt   = nv_batcnt.         /* bchcnt     */  
       
        /* Begin by Phaiboon W. [A59-0488] Date 21/11/2016  */                                    
        /* sic_bran.uwm301.prmtxt    = wdetail.prmtxt.  */             
        IF SUBSTR(sic_bran.uwm120.policy,3,2) = "70" THEN sic_bran.uwm301.prmtxt = wdetail.prmtxt.
        ELSE sic_bran.uwm301.prmtxt = "".                              

        sic_bran.uwm301.logbok = wdetail.ispstatus.
        /* End by Phaiboon W. [A59-0488] Date 21/11/2016 */                                       

    /*-----compul-----*/
    IF wdetail.compul = "y" THEN DO:
        sic_bran.uwm301.cert = "".
        IF LENGTH(wdetail.stk) = 11 THEN DO:    
            sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
        END.
        IF LENGTH(wdetail.stk) = 13  THEN DO:
            sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
        END.  
        IF wdetail.stk = ""  THEN DO:
            sic_bran.uwm301.drinam[9] = "".
        END. 
        /*--create detaitem--*/
        FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
            brStat.Detaitem.serailno   = wdetail.stk  AND 
            brstat.detaitem.yearReg    = nv_batchyr   AND
            brstat.detaitem.seqno      = STRING(nv_batchno)  AND
            brstat.detaitem.seqno2     = STRING(nv_batcnt)   NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.Detaitem THEN DO:   
            CREATE brstat.Detaitem.
            /*--STR Amparat C. A51-0253---*/
            ASSIGN                                                            
                brstat.detaitem.policy   = sic_bran.uwm301.policy                 
                brstat.Detaitem.rencnt   = sic_bran.uwm301.rencnt                 
                brstat.Detaitem.endcnt   = sic_bran.uwm301.endcnt                 
                brstat.Detaitem.riskno   = sic_bran.uwm301.riskno                 
                brstat.Detaitem.itemno   = sic_bran.uwm301.itemno                 
                brstat.detaitem.serailno = wdetail.stk
                brstat.detaitem.yearReg  = sic_bran.uwm301.bchyr
                brstat.detaitem.seqno    = STRING(sic_bran.uwm301.bchno)     
                brstat.detaitem.seqno2   = STRING(sic_bran.uwm301.bchcnt).  
            /*--END Amparat C. A51-0253---*/
        END.
    END.
    ELSE 
        sic_bran.uwm301.drinam[9] = "".
    s_recid4  = RECID(sic_bran.uwm301).
    /***--- modi by note a490166 ---***/
    ASSIGN 
    nv_maxsi = 0
    nv_minsi = 0
    nv_si    = 0
    nv_maxdes = ""
    nv_mindes = ""
    /*chkred = NO*/
    n_model = "". 
IF      wdetail.subclass = "110" THEN wdetail.seat = "7".
ELSE IF wdetail.subclass = "210" THEN wdetail.seat = "12".
ELSE IF wdetail.subclass = "320" THEN wdetail.seat = "3".
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE 
        stat.maktab_fil.sclass = wdetail.subclass   AND 
        stat.maktab_fil.modcod = wdetail.redbook    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  
            sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            /*chkred           =  YES     */               
            wdetail.brand    =  stat.maktab_fil.makdes
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
            wdetail.cc       =  STRING(stat.maktab_fil.engine)
            wdetail.weight   =  STRING(stat.maktab_fil.tons)
            wdetail.subclass =  stat.maktab_fil.sclass   
            wdetail.redbook  =  stat.maktab_fil.modcod                                    
            wdetail.seat     =  STRING(stat.maktab_fil.seats)
            nv_si            = maktab_fil.si.

        IF wdetail.covcod = "1"  THEN DO:
            FIND FIRST stat.makdes31 WHERE 
                stat.makdes31.makdes = "X"  AND     /*Lock X*/
                stat.makdes31.moddes = wdetail.prempa + wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE makdes31 THEN 
                ASSIGN  nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            ELSE 
                ASSIGN  nv_maxSI = nv_si
                    nv_minSI = nv_si.
        END.  /***--- End Check Rate SI ---***/
    END.
    ELSE nv_modcod = " ".
END.    /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN 
        nv_simat  = makdes31.si_theft_p   
        nv_simat1 = makdes31.load_p   .    
    ELSE ASSIGN 
        nv_simat  = 0
        nv_simat1 = 0.
    Find LAST stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp  =  stat.maktab_fil.prmpac
        wdetail.redbook =  stat.maktab_fil.modcod 
        wdetail.weight  =  STRING(stat.maktab_fil.tons)
        wdetail.body    =  stat.maktab_fil.body .
END.

    /*add A52-0172*/
    FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
         sic_bran.uwd132.policy = wdetail.policy AND
         sic_bran.uwd132.rencnt = 0                AND
         sic_bran.uwd132.endcnt = 0                AND
         sic_bran.uwd132.riskgp = 0                AND
         sic_bran.uwd132.riskno = 1                AND
         sic_bran.uwd132.itemno = 1                AND
         sic_bran.uwd132.bchyr  = nv_batchyr       AND
         sic_bran.uwd132.bchno  = nv_batchno       AND
         sic_bran.uwd132.bchcnt = nv_batcnt 
    NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
      IF LOCKED sic_bran.uwd132 THEN DO:
        MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wdetail.policy
                "ไม่สามารถ Generage ข้อมูลได้".
        NEXT.
      END.
      CREATE sic_bran.uwd132.
    END.
    ASSIGN
      sic_bran.uwd132.bencod  = "COMP"                   /*Benefit Code*/
      sic_bran.uwd132.benvar  = ""                       /*Benefit Variable*/
      sic_bran.uwd132.rate    = 0                        /*Premium Rate %*/
      sic_bran.uwd132.gap_ae  = NO                       /*GAP A/E Code*/
      sic_bran.uwd132.gap_c   = 0    /*deci(wdetail.premt)  kridtiya i.*/      /*GAP, per Benefit per Item*/
      sic_bran.uwd132.dl1_c   = 0                        /*Disc./Load 1,p. Benefit p.Item*/
      sic_bran.uwd132.dl2_c   = 0                        /*Disc./Load 2,p. Benefit p.Item*/
      sic_bran.uwd132.dl3_c   = 0                        /*Disc./Load 3,p. Benefit p.Item*/
      sic_bran.uwd132.pd_aep  = "E"                      /*Premium Due A/E/P Code*/
      sic_bran.uwd132.prem_c  = 0   /*kridtiya i. deci(wdetail.premt) */     /*PD, per Benefit per Item*/
      sic_bran.uwd132.fptr    = 0                        /*Forward Pointer*/
      sic_bran.uwd132.bptr    = 0                        /*Backward Pointer*/
      sic_bran.uwd132.policy  = wdetail.policy         /*Policy No. - uwm130*/
      sic_bran.uwd132.rencnt  = 0                        /*Renewal Count - uwm130*/
      sic_bran.uwd132.endcnt  = 0                        /*Endorsement Count - uwm130*/
      sic_bran.uwd132.riskgp  = 0                        /*Risk Group - uwm130*/
      sic_bran.uwd132.riskno  = 1                        /*Risk No. - uwm130*/
      sic_bran.uwd132.itemno  = 1                        /*Insured Item No. - uwm130*/
      sic_bran.uwd132.rateae  = NO                       /*Premium Rate % A/E Code*/
      sic_bran.uwm130.fptr03  = RECID(sic_bran.uwd132)   /*First uwd132 Cover & Premium*/
      sic_bran.uwm130.bptr03  = RECID(sic_bran.uwd132)   /*Last  uwd132 Cover & Premium*/
      sic_bran.uwd132.bchyr   = nv_batchyr  
      sic_bran.uwd132.bchno   = nv_batchno  
      sic_bran.uwd132.bchcnt  = nv_batcnt .
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_723 c-win 
PROCEDURE proc_723 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT        PARAMETER  s_recid1   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid2   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid3   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid4   AS   RECID     NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_message AS   CHARACTER NO-UNDO.
nv_rec100 = s_recid1.
nv_rec120 = s_recid2.
nv_rec130 = s_recid3.
nv_rec301 = s_recid4.
nv_message = "".
nv_gap     = 0.
nv_prem    = 0.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = nv_rec301 NO-WAIT NO-ERROR.
IF sic_bran.uwm130.fptr03 = 0 OR sic_bran.uwm130.fptr03 = ? THEN DO:
    FIND sicsyac.xmm107 USE-INDEX xmm10701      WHERE
        sicsyac.xmm107.class  = wdetail.subclass   AND
        sicsyac.xmm107.tariff = "9"
        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xmm107 THEN DO:
        FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmd107 THEN DO:
            CREATE sic_bran.uwd132.
            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                sicsyac.xmm016.class = wdetail.subclass
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm016 THEN 
                ASSIGN sic_bran.uwd132.gap_ae = NO
                sic_bran.uwd132.pd_aep = "E".
            ASSIGN sic_bran.uwd132.bencod = sicsyac.xmd107.bencod   sic_bran.uwd132.policy = wdetail.policy
                sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt  sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp  sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
                sic_bran.uwd132.itemno = sic_bran.uwm130.itemno
                sic_bran.uwd132.bptr   = 0
                sic_bran.uwd132.fptr   = 0          
                nvffptr     = xmd107.fptr
                s_130bp1    = RECID(sic_bran.uwd132)
                s_130fp1    = RECID(sic_bran.uwd132)
                n_rd132     = RECID(sic_bran.uwd132)
                sic_bran.uwd132.bchyr = nv_batchyr         /* batch Year */      
                sic_bran.uwd132.bchno = nv_batchno         /* bchno    */      
                sic_bran.uwd132.bchcnt  = nv_batcnt .        /* bchcnt     */ 
            FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                sicsyac.xmm105.tariff = "9"  AND
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE MESSAGE "ไม่พบ Tariff  " "9"  VIEW-AS ALERT-BOX.
            IF ("9" = "Z") OR ("9" = "X") THEN DO:  /* Malaysia */
                IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.cc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.cc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.weight).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = "9"   AND
                    sicsyac.xmm106.bencod  = uwd132.bencod    AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= nv_key_a         AND
                    sicsyac.xmm106.key_b  >= nv_key_b         AND
                    sicsyac.xmm106.effdat <= uwm100.comdat    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN 
                    ASSIGN sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = "9"   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= 0                AND
                    sicsyac.xmm106.key_b  >= 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = "9"   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a   = 0                AND
                    sicsyac.xmm106.key_b   = 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                        RECID(sic_bran.uwd132),
                                        sic_bran.uwm301.tariff).
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                END.
            END.
            loop_def:
            REPEAT:
                IF nvffptr EQ 0 THEN LEAVE loop_def.
                FIND sicsyac.xmd107 WHERE RECID(sicsyac.xmd107) EQ nvffptr
                    NO-LOCK NO-ERROR NO-WAIT.
                nvffptr   = sicsyac.xmd107.fptr.
                CREATE sic_bran.uwd132.
                ASSIGN sic_bran.uwd132.bencod = sicsyac.xmd107.bencod    sic_bran.uwd132.policy = wdetail.policy
                    sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt   sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                    sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp   sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
                    sic_bran.uwd132.itemno = sic_bran.uwm130.itemno
                    sic_bran.uwd132.fptr   = 0
                    sic_bran.uwd132.bptr   = n_rd132
                    sic_bran.uwd132.bchyr = nv_batchyr      /* batch Year */      
                    sic_bran.uwd132.bchno = nv_batchno      /* bchno    */      
                    sic_bran.uwd132.bchcnt  = nv_batcnt     /* bchcnt     */      
                    n_rd132                 = RECID(sic_bran.uwd132).
                FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                    sicsyac.xmm016.class = wdetail.subclass
                    NO-LOCK NO-ERROR.
                IF AVAIL sicsyac.xmm016 THEN 
                    ASSIGN sic_bran.uwd132.gap_ae = NO
                    sic_bran.uwd132.pd_aep = "E".
                FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                    sicsyac.xmm105.tariff = "9"  AND
                    sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
                ELSE   MESSAGE "ไม่พบ Tariff นี้ในระบบ กรุณาใส่ Tariff ใหม่" 
                    "Tariff" "9" "Bencod"  xmd107.bencod VIEW-AS ALERT-BOX.
                IF "9" = "Z" OR "9" = "X" THEN DO:
                    IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.cc).
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.cc).
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.weight).
                    nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                        sicsyac.xmm106.tariff  = "9"   AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.subclass    AND
                        sicsyac.xmm106.covcod  = wdetail.covcod   AND
                        sicsyac.xmm106.key_a  >= nv_key_a        AND
                        sicsyac.xmm106.key_b  >= nv_key_b        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE sicsyac.xmm106 THEN 
                        ASSIGN
                            sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                            sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                            nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                            nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                END.
                ELSE DO:
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                 WHERE
                        sicsyac.xmm106.tariff  = "9"           AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.subclass         AND
                        sicsyac.xmm106.covcod  = wdetail.covcod           AND
                        sicsyac.xmm106.key_a  >= 0                        AND
                        sicsyac.xmm106.key_b  >= 0                        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601                  WHERE
                        sicsyac.xmm106.tariff  = "9"            AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod    AND
                        sicsyac.xmm106.class   = wdetail.subclass          AND
                        sicsyac.xmm106.covcod  = wdetail.covcod            AND
                        sicsyac.xmm106.key_a   = 0                         AND
                        sicsyac.xmm106.key_b   = 0                         AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE xmm106 THEN DO:
                        sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                        RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                            RECID(sic_bran.uwd132),
                                            sic_bran.uwm301.tariff).
                        nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                    END.
                END.
                FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ s_130bp1 NO-WAIT NO-ERROR.
                sic_bran.uwd132.fptr   = n_rd132.
                FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ n_rd132 NO-WAIT NO-ERROR.
                s_130bp1      = RECID(sic_bran.uwd132).
                NEXT loop_def.
            END.
        END.
    END.
    ELSE DO:   
        ASSIGN s_130fp1 = 0
        s_130bp1 = 0.
        MESSAGE "ไม่พบ Class " wdetail.subclass " ใน Tariff  " "9"  skip
                        "กรุณาใส่ Class หรือ Tariff ใหม่อีกครั้ง" VIEW-AS ALERT-BOX.
    END.
    ASSIGN sic_bran.uwm130.fptr03 = s_130fp1
        sic_bran.uwm130.bptr03 = s_130bp1.
END.
ELSE DO:                              
    s_130fp1 = sic_bran.uwm130.fptr03.
    DO WHILE s_130fp1 <> ? AND s_130fp1 <> 0:
        FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = s_130fp1 NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwd132 THEN DO:
            s_130fp1 = sic_bran.uwd132.fptr.
            IF "9" = "Z" OR "9" = "X" THEN DO:
                IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.cc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.cc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.weight).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                WHERE
                    sicsyac.xmm106.tariff  = "9"          AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod  AND
                    sicsyac.xmm106.class   = wdetail.subclass        AND
                    sicsyac.xmm106.covcod  = wdetail.covcod          AND
                    sicsyac.xmm106.key_a  >= nv_key_a                AND 
                    sicsyac.xmm106.key_b  >= nv_key_b                AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE xmm106 THEN 
                    ASSIGN sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601            WHERE
                    sicsyac.xmm106.tariff  = "9"      AND 
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod       AND 
                    sicsyac.xmm106.class   = wdetail.subclass    AND 
                    sicsyac.xmm106.covcod  = wdetail.covcod      AND 
                    sicsyac.xmm106.key_a  >= 0                   AND 
                    sicsyac.xmm106.key_b  >= 0                   AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                    sicsyac.xmm106.tariff  = "9"   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass    AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a   = 0               AND
                    sicsyac.xmm106.key_b   = 0               AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                        RECID(sic_bran.uwd132),
                                        sic_bran.uwm301.tariff).
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                END.
            END.
        END.
    END.
END.
RUN proc_7231.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_7231 c-win 
PROCEDURE proc_7231 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_stm_per = 0.4
    nv_tax_per = 7.0.
FIND sicsyac.xmm020 USE-INDEX xmm02001     WHERE
    sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
    sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri
    NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN ASSIGN nv_stm_per             = sicsyac.xmm020.rvstam
    nv_tax_per             = sicsyac.xmm020.rvtax
    sic_bran.uwm100.gstrat = sicsyac.xmm020.rvtax.
ELSE sic_bran.uwm100.gstrat = nv_tax_per.
ASSIGN  nv_gap2  = 0
    nv_prem2 = 0
    nv_rstp  = 0
    nv_rtax  = 0
    nv_com1_per = 0
    nv_com1_prm = 0.
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp
    NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sicsyac.xmm031 THEN nv_com1_per = sicsyac.xmm031.comm1.
FOR EACH sic_bran.uwm120 WHERE
    sic_bran.uwm120.policy = wdetail.policy         AND
    sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm120.bchyr = nv_batchyr              AND 
    sic_bran.uwm120.bchno = nv_batchno              AND 
    sic_bran.uwm120.bchcnt  = nv_batcnt             :
    ASSIGN nv_gap  = 0
        nv_prem = 0.
    FOR EACH sic_bran.uwm130 WHERE
        sic_bran.uwm130.policy = wdetail.policy AND
        sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
        sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp AND
        sic_bran.uwm130.riskno = sic_bran.uwm120.riskno AND
        sic_bran.uwm130.bchyr = nv_batchyr            AND 
        sic_bran.uwm130.bchno = nv_batchno            AND 
        sic_bran.uwm130.bchcnt  = nv_batcnt             NO-LOCK:
        nv_fptr = sic_bran.uwm130.fptr03.
        DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
            FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr
                NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAILABLE sic_bran.uwd132 THEN LEAVE.
            nv_fptr = sic_bran.uwd132.fptr.
            nv_gap  = nv_gap  + sic_bran.uwd132.gap_c.
            nv_prem = nv_prem + sic_bran.uwd132.prem_c.
        END.
    END.
    sic_bran.uwm120.gap_r   =  nv_gap.
    sic_bran.uwm120.prem_r  =  nv_prem.
    sic_bran.uwm120.rstp_r  =  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) +
        (IF  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 2) -
         TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) > 0  THEN 1 ELSE 0).
    sic_bran.uwm120.rtax_r = ROUND((sic_bran.uwm120.prem_r + sic_bran.uwm120.rstp_r)  * nv_tax_per  / 100 ,2).
    nv_gap2  = nv_gap2  + nv_gap.
    nv_prem2 = nv_prem2 + nv_prem.
    nv_rstp  = nv_rstp  + sic_bran.uwm120.rstp_r.
    nv_rtax  = nv_rtax  + sic_bran.uwm120.rtax_r.
    IF sic_bran.uwm120.com1ae = NO THEN
        nv_com1_per            = sic_bran.uwm120.com1p.
    IF nv_com1_per <> 0 THEN 
        ASSIGN sic_bran.uwm120.com1ae =  NO
        sic_bran.uwm120.com1p  =  nv_com1_per
        sic_bran.uwm120.com1_r =  (sic_bran.uwm120.prem_r * sic_bran.uwm120.com1p / 100) * 1-
        nv_com1_prm = nv_com1_prm + sic_bran.uwm120.com1_r.
    ELSE DO:
        IF nv_com1_per   = 0  AND sic_bran.uwm120.com1ae = NO THEN 
            ASSIGN
            sic_bran.uwm120.com1p  =  0
            sic_bran.uwm120.com1_r =  0
            sic_bran.uwm120.com1_r =  0
            nv_com1_prm            =  0.
    END.
END.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
ASSIGN
    sic_bran.uwm100.gap_p  =  nv_gap2
    sic_bran.uwm100.prem_t =  nv_prem2
    sic_bran.uwm100.rstp_t =  nv_rstp
    sic_bran.uwm100.rtax_t =  nv_rtax
    sic_bran.uwm100.com1_t =  nv_com1_prm.
RUN proc_chktest4.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addr c-win 
PROCEDURE proc_addr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO: /*----- ที่อยู่ --------*/
    ASSIGN  n_length   = 0      n_address  = ""
            n_build    = ""     n_road     = ""          
            n_tambon   = ""     n_amper    = ""          
            n_country  = ""     n_post     = ""
            n_address  = TRIM(wdetail.recaddr) .      
       
        IF INDEX(n_address,"จ." ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"จ."),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
        END.
        ELSE IF INDEX(n_address,"จังหวัด" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"จังหวัด"),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length)  ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
        END.
        ELSE IF INDEX(n_address,"กทม" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"กทม"),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
        END.
        ELSE IF INDEX(n_address,"กรุงเทพ" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"กรุงเทพ"),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
        END.

        IF INDEX(n_address,"อ." ) <> 0 THEN DO: 
            ASSIGN 
            n_amper  =  SUBSTR(n_address,INDEX(n_address,"อ."),LENGTH(n_address))
            n_length   =  LENGTH(n_amper)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
        ELSE IF INDEX(n_address,"อำเภอ" ) <> 0 THEN DO: 
            ASSIGN 
            n_amper  =  SUBSTR(n_address,INDEX(n_address,"อำเภอ"),LENGTH(n_address))
            n_length   =  LENGTH(n_amper)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
        ELSE IF INDEX(n_address,"เขต" ) <> 0 THEN DO: 
            ASSIGN 
            n_amper  =  SUBSTR(n_address,INDEX(n_address,"เขต"),LENGTH(n_address))
            n_length   =  LENGTH(n_amper)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.

        IF INDEX(n_address,"ต." ) <> 0 THEN DO: 
            ASSIGN 
            n_tambon  =  SUBSTR(n_address,INDEX(n_address,"ต."),LENGTH(n_address))
            n_length   =  LENGTH(n_tambon)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
        ELSE IF INDEX(n_address,"ตำบล" ) <> 0 THEN DO: 
            ASSIGN 
            n_tambon  =  SUBSTR(n_address,INDEX(n_address,"ตำบล"),LENGTH(n_address))
            n_length   =  LENGTH(n_tambon)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
        ELSE IF INDEX(n_address,"แขวง" ) <> 0 THEN DO: 
            ASSIGN 
            n_tambon  =  SUBSTR(n_address,INDEX(n_address,"แขวง"),LENGTH(n_address))
            n_length   =  LENGTH(n_tambon)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.

        IF INDEX(n_address,"ถ." ) <> 0 THEN DO: 
            ASSIGN 
            n_road  =  SUBSTR(n_address,INDEX(n_address,"ถ."),LENGTH(n_address))
            n_length   =  LENGTH(n_road)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
        ELSE IF INDEX(n_address,"ถนน" ) <> 0 THEN DO: 
            ASSIGN 
            n_road  =  SUBSTR(n_address,INDEX(n_address,"ถนน"),LENGTH(n_address))
            n_length   =  LENGTH(n_road)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
       ASSIGN  n_build   = trim(n_address).
      
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132prem c-win 
PROCEDURE proc_adduwd132prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A64-0138       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 .
     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              stat.pmuwd132.campcd    = sic_bran.uwm100.policy AND
              stat.pmuwd132.policy    = sic_bran.uwm100.policy AND
              stat.pmuwd132.rencnt    = sic_bran.uwm100.rencnt AND
              stat.pmuwd132.endcnt    = sic_bran.uwm100.endcnt AND
              stat.pmuwd132.txt1      = STRING(nv_batchyr,"9999") AND
              stat.pmuwd132.txt2      = nv_batchno             .
        FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
             sic_bran.uwd132.policy  = sic_bran.uwm100.policy AND
             sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt AND
             sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt AND
             sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp AND
             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno AND
             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno AND
             sic_bran.uwd132.bchyr   = nv_batchyr             AND
             sic_bran.uwd132.bchno   = nv_batchno             AND
             sic_bran.uwd132.bchcnt  = nv_batcnt              AND 
             sic_bran.uwd132.bencod  = stat.pmuwd132.bencod    NO-ERROR NO-WAIT.

            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.

               ASSIGN fi_show = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
               DISP fi_show WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                  sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                  sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                  sic_bran.uwd132.gap_ae  =  stat.pmuwd132.gap_ae                   
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  stat.pmuwd132.pd_aep                   
                  sic_bran.uwd132.prem_c  =  stat.pmuwd132.prem_c                  
                  sic_bran.uwd132.fptr    =  0                   
                  sic_bran.uwd132.bptr    =  nv_bptr                   
                  sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
                  sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
                  sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
                  sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
                  sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
                  sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
                  sic_bran.uwd132.rateae  =  stat.pmuwd132.rateae                  
                  sic_bran.uwd132.bchyr   =  nv_batchyr                   
                  sic_bran.uwd132.bchno   =  nv_batchno 
                  sic_bran.uwd132.bchcnt  =  nv_batcnt.

                  nv_gapprm = nv_gapprm + stat.pmuwd132.gap_c .
                  nv_pdprm  = nv_pdprm  + stat.pmuwd132.prem_C.
              
               
               IF SUBSTR(sic_bran.uwd132.bencod,1,3) = "GRP" AND wdetail.cargrp <> "" THEN DO:
                   ASSIGN   sic_bran.uwd132.bencod = nv_grpcod
                            sic_bran.uwd132.benvar = nv_grpvar .
               END.
               IF sic_bran.uwd132.bencod = "NCB" THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)). 

               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).

            END. /* end uwd132*/
            /* add : A64-0138*/
            If nv_ncbper  <> 0 Then do:
               Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                   sicsyac.xmm104.tariff = nv_tariff           AND
                   sicsyac.xmm104.class  = nv_class            AND 
                   sicsyac.xmm104.covcod = nv_covcod           AND 
                   sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
               IF not avail  sicsyac.xmm104  Then do:
                   Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                   ASSIGN wdetail.pass    = "N"
                          wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
               END.
               ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                           nv_ncbyrs = xmm104.ncbyrs.
            END.
            Else do:  
               ASSIGN nv_ncbyrs    =   0
                      nv_ncbper    =   0
                      nv_ncb       =   0.
            END.
            ASSIGN   
                sic_bran.uwm301.ncbper   = nv_ncbper
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs .
            
           /* DELETE stat.pmuwd132 .*/  /* end A64-0138 */
    END. /* end pmuwd132 */
    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign c-win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail2.
    IMPORT DELIMITER "|" 
        wdetail2.recno       /*0  "ลำดับที่"     */       /* 1   1   */                      
        wdetail2.Notify_dat  /*1  "วันที่รับแจ้ง"*/       /* 2   01/09/2012  */              
        wdetail2.time_notify /*3  "เวลารับแจ้ง"  */       /* 3   09:56:05    */              
        wdetail2.notifyno    /*4  เลขรับเเจ้ง */          /* 4   DM7055PB0008*/          
        wdetail2.comp_code   /*5  รายชื่อบริษัทประกันภัย*//* 5   SCB */                      
        wdetail2.NAME_mkt    /*6  ชื่อเจ้าหน้าที่ MKT */  /* 6   คุณหนึ่ง    */              
        wdetail2.cmbr_no     /*7  "รหัสสาขา"    */        /* 7   E   */                                                    
        wdetail2.cmbr_code   /*8  "Code: "  */            /* 8   ศรีนครินทร์ */              
        wdetail2.branch      /*9  "รหัสสาขา_STY "*/       /* 9   M   */                      
        wdetail2.producer                       /* 10  B3M0009 */                  
        wdetail2.agent                          /* 11  B3M0009 */     
        wdetail2.deler        /*  A56-0024*/
        wdetail2.campaigno   /*9  Campaign            */  /* 12  C54/00015   */              
        wdetail2.cov_car     /*10 "ประเภทประกัน"      */  /* 13  เก๋ง    */                   
        wdetail2.cov_new     /*   "ประเภทรถ"          */    /* 14  ป้ายแดง */                     
        wdetail2.covcod      /*   "ประเภทความคุ้มครอง"*/    /* 15  1   */                      
        wdetail2.product                           /* 16      */                      
        wdetail2.freeprem    /*   "ประกัน แถม/ไม่แถม" */    /* 17  แถม */                      
        wdetail2.freecomp    /*   "พรบ.   แถม/ไม่แถม" */    /*  18  แถม */                      
        wdetail2.comdat      /*   "วันเริ่มคุ้มครอง"       */ /*  19  01/09/12    */              
        wdetail2.expdat      /*   "วันสิ้นสุดความคุ้มครอง" */ /*  20  01/09/13    */              
        wdetail2.ispno       /*   add  A55-0046          */   /*  21  ISPNO123456789123456    */  
        wdetail2.pol70       /*   "เลขกรมธรรม์70"*/           /*  22  DM7055SB0021    */          
        wdetail2.pol72       /*   "เลขกรมธรรม์72"*/           /*  23  DM7255SB0021    */          
        wdetail2.n_TITLE     /*12 คำนำหน้าชื่อ    */      /*  24  คุณ */                                                    
        wdetail2.n_name1     /*13 ชื่อผู้เอาประกัน*//*  25  กฤติยา อินทจักร์    */ 
        wdetail2.idno        /*26 01234567890     *//*A55-0257*/
        wdetail2.birthday    /*27 15/08/2528      *//*A55-0257*/
        wdetail2.idexpdat    /*38 01/05/2520      *//*A55-0257*/
        wdetail2.occupins    /*28 พนักงานราชการ   *//*A55-0257*/
        wdetail2.namedirect  /*29 ชื่อกรรมการ     *//*A55-0257*/  
        wdetail2.ADD_1       /*15 บ้านเลขที่  */          /*  30  เลขที่ 103/1 หมู่ 4  ซอย123(ซอย_ ถนนพหลโยธิน    */                                 
        wdetail2.ADD_2       /*21 ตำบล/แขวง   */          /*  31  สันทราย */                                                                         
        wdetail2.ADD_3       /*22 อำเภอ/เขต   */          /*  32  แม่จัน  */                                                                         
        wdetail2.ADD_4       /*23 จังหวัด */              /*  33  เชียงราย    */                                                                     
        wdetail2.ADD_5       /*24 รหัสไปรษณีย์ */         /*  34  57110   */                                        
        wdetail2.tel         /*24 telephone    */         /*  35  022578000   */  
        wdetail2.driv_no
        wdetail2.drivname1   /*36 คนขับที่หนึ่ง   *//*A55-0257*/
        wdetail2.sexdri1     /*37 MALE            *//*A55-0257*/
        wdetail2.birthdri1   /*38 01/05/2520      *//*A55-0257*/
        wdetail2.occupdri1   /*39 พนักงานราชการ   *//*A55-0257*/
        wdetail2.idnodri1    /*40 01234567890123  *//*A55-0257*/
        wdetail2.drivname2   /*41 คนขับที่สอง     *//*A55-0257*/
        wdetail2.sexdri2     /*42 MALE            *//*A55-0257*/
        wdetail2.birthdri2   /*43 01/05/2522      *//*A55-0257*/
        wdetail2.occupdri2   /*44 พนักงานเอกชน    *//*A55-0257*/
        wdetail2.idnodri2    /*45 01234567890987  *//*A55-0257*/
        wdetail2.redbook    /*redbook */    /*A62-0219*/
        wdetail2.brand       /*31 ชื่อยี่ห้อรถ    */       /*  46  HONDA   */                                                                              
        wdetail2.model       /*32 รุ่นรถ  */               /*  47  city    */                                                                        
        wdetail2.engine      /*36 เลขเครื่องยนต์  */       /*  48  SERWER F122541  */                               
        wdetail2.chassis     /*35 เลขตัวถัง   */           /*  49  MSDKDFWEI1254125    */                           
        wdetail2.power       /*38 ซีซี    */            /*  50  1500    */                                       
        wdetail2.cyear       /*37 ปีรถยนต์    */        /*  51  2012    */                                       
        wdetail2.licence     /*34 เลขทะเบียน  */        /*  52  ฆน 1234 */                                       
        wdetail2.provin      /*34 จังหวัดเลขทะเบียน  */ /*  53  กรุงเทพมหานคร   */                          
        wdetail2.subclass    /*29 รหัสรถ  */            /*  54  G110    */                                   
        wdetail2.garage      /*26 ประเภทการซ่อม   */    /*  55  G   */                                       
        wdetail2.ins_amt1    /*   "ทุนประกัน"*/              /*  56  560000  */ 
        wdetail2.fi           /* ทุนสูญหาย */  /*A62-0219*/   
        wdetail2.prem1       /*   "เบี้ยประกัน" */           /*  57  18500   */                                   
        wdetail2.prem2                                    /*  58  19874.18    */                               
        wdetail2.comprem     /*   "เบี้ยพรบ." */             /*  59  0   */                                                                   
        wdetail2.prem3       /*   "เบี้ยรวม"*/               /*  60  19874.18    */                                 
        wdetail2.deduct 
        wdetail2.sck         /*   "เลขสติ๊กเกอร์" */         /*  61      */                                         
        wdetail2.ref         /*   "เลขReferance no."*/       /*  62      */                                         
        wdetail2.recivename  /*   "ออกใบเสร็จในนาม"*/        /*  63      */             
        wdetail2.vatcode     /*   "Vatcode " */              /*  64      */             
        wdetail2.notiuser    /*   "ผู้รับแจ้ง"             *//*  65  กฤติยา  */ 
        wdetail2.notbr       /*   สาขาที่รับแจ้ง            */ /*A62-0219*/   
        wdetail2.bennam      /*   "ผู้รับผลประโยชน์"       *//*  66  ธนาคารไทยพาณิชย์ จำกัด (มหาชน)  */     
        wdetail2.remak1      /*   "หมายเหตุ"               *//*  67  cmpin0: */ 
        /* Begin by Phaiboon W. [A59-0488] Date 07/11/2016 */
        wdetail2.remak2      /*   "หมายเหตุ 2"          */
        wdetail2.other1      /*   "อุปกรณ์เสริม         */
        wdetail2.other2      /*   "ราคา"                */
        wdetail2.other3      /*   "อุปกรณ์เสริม 2"      */
        wdetail2.quotation
        wdetail2.ngarage
        wdetail2.ispstatus
        /* End by Phaiboon W. [A59-0488] Date 07/11/2016 */
        /* add by A62-0219 */
        wdetail2.tp
        wdetail2.ta
        wdetail2.td
        wdetail2.n41
        wdetail2.n42
        wdetail2.n43
        wdetail2.docno
        wdetail2.reinsp
        /* end a62-0219*/
        wdetail2.statusco.   /*   "complete/not complete"  *//*  68  complete    */  
END.                       /*-Repeat-*/
ASSIGN fi_show = "Import Text file to GW......".
DISP fi_show WITH FRAM fr_main.
FOR EACH wdetail2.
    IF index(wdetail2.recno,"ข้อมูล") <> 0 THEN DELETE wdetail2.
    ELSE IF index(wdetail2.recno,"ลำดับ") <> 0 THEN DELETE wdetail2.
END.
RUN proc_assign2.
RUN proc_assign3.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2 c-win 
PROCEDURE proc_assign2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_comdate AS  CHAR   INIT "" .
DEF VAR n_banno   AS  CHAR   INIT "" FORMAT "x(35)".
DEF VAR n_banno1  AS  CHAR   INIT "" FORMAT "x(35)".
DEF VAR n_muno    AS  CHAR   INIT "" FORMAT "x(35)".
DEF VAR n_build   AS  CHAR   INIT "" FORMAT "x(50)".
DEF VAR n_road    AS  CHAR   INIT "" FORMAT "x(50)".
DEF VAR n_soy     AS  CHAR   INIT "" FORMAT "x(50)".
FOR EACH wdetail2 .
    ASSIGN n_comdate = ""   /*a55-0108 */
        n_comdate = "" 
        n_banno   = "" 
        n_banno1   = "" 
        n_muno    = "" 
        n_build   = "" 
        n_road    = "" 
        n_soy     = "" .  /*A55-0108 */
    IF wdetail2.pol70 = "" THEN NEXT.
    IF  (index(wdetail2.recno,"ข้อมูล") <> 0 ) OR
        (index(wdetail2.recno,"ลำดับ")  <> 0 ) THEN DELETE wdetail2.
    ELSE DO:
        /* create by :A62-0345 */
        IF INDEX(wdetail2.NAME_mkt,"นางสาว") <> 0 THEN DO:
            ASSIGN  wdetail2.NAME_mkt = trim(REPLACE(wdetail2.NAME_mkt,"นางสาว","")).
        END.
        ELSE IF SUBSTR(wdetail2.NAME_mkt,1,3) = "นาง" THEN DO: 
            ASSIGN  wdetail2.NAME_mkt = trim(SUBSTR(wdetail2.NAME_mkt,4)).
        END.
        ELSE IF SUBSTR(wdetail2.NAME_mkt,1,3) = "นาย" THEN DO: 
            ASSIGN  wdetail2.NAME_mkt = trim(SUBSTR(wdetail2.NAME_mkt,4)).
        END.
        ELSE IF SUBSTR(wdetail2.NAME_mkt,1,4) = "น.ส." THEN DO: 
            ASSIGN  wdetail2.NAME_mkt = trim(SUBSTR(wdetail2.NAME_mkt,5)).
        END.
        /* end : A62-0345 */

        IF trim(wdetail2.ADD_4) = ""  THEN 
            ASSIGN wdetail2.ADD_2 = IF trim(wdetail2.ADD_2) = "" THEN "" ELSE "ตำบล"  + trim(wdetail2.ADD_2)
                wdetail2.ADD_3 = IF trim(wdetail2.ADD_3) = "" THEN "" ELSE "อำเภอ" + trim(wdetail2.ADD_3).
        ELSE DO: 
            IF (INDEX(wdetail2.ADD_4,"กรุงเทพ") <> 0 ) OR (INDEX(wdetail2.ADD_4,"กทม") <> 0) THEN
                ASSIGN wdetail2.ADD_2 = IF trim(wdetail2.ADD_2) = "" THEN "" ELSE "แขวง" + trim(wdetail2.ADD_2)
                    wdetail2.ADD_3 = IF trim(wdetail2.ADD_3) = "" THEN "" ELSE "เขต"  + trim(wdetail2.ADD_3).
            ELSE ASSIGN wdetail2.ADD_2 = IF trim(wdetail2.ADD_2) = "" THEN "" ELSE "ตำบล"  + trim(wdetail2.ADD_2)
                        wdetail2.ADD_3 = IF trim(wdetail2.ADD_3) = "" THEN "" ELSE "อำเภอ" + trim(wdetail2.ADD_3) 
                        wdetail2.ADD_4 = "จังหวัด" + trim(wdetail2.ADD_4) .
        END.
        ASSIGN n_banno  = trim(wdetail2.ADD_1).
        IF INDEX(n_banno,"ถนน") <> 0 THEN DO:
            ASSIGN n_road   = trim(SUBSTR(n_banno,INDEX(n_banno,"ถนน")))
            n_banno         = trim(SUBSTR(n_banno,1,INDEX(n_banno,"ถนน") - 1)).
        END.
        ELSE IF INDEX(n_banno,"ถ.") <> 0 THEN DO:
            ASSIGN n_road   = trim(SUBSTR(n_banno,INDEX(n_banno,"ถ.")))
            n_banno         = trim(SUBSTR(n_banno,1,INDEX(n_banno,"ถ.") - 1)).
        END.
        ELSE n_road = "" .    /*A55-0108*/

        IF INDEX(n_banno,"ซอย") <> 0 THEN DO:
            ASSIGN n_soy    = trim(SUBSTR(n_banno,INDEX(n_banno,"ซอย")))
            n_banno         = trim(SUBSTR(n_banno,1,INDEX(n_banno,"ซอย") - 1 )).
        END.
        ELSE IF INDEX(n_banno,"ซ.") <> 0 THEN DO:
            ASSIGN n_soy    = trim(SUBSTR(n_banno,INDEX(n_banno,"ซ.")))
                   n_banno         = trim(SUBSTR(n_banno,1,INDEX(n_banno,"ซ.") - 1 )).
        END.
        ELSE n_soy = "" .     /*A55-0108*/

        IF INDEX(n_banno,"อาคาร") <> 0 THEN 
            ASSIGN n_build  = trim(SUBSTR(n_banno,INDEX(n_banno,"อาคาร")))
            n_banno         = trim(SUBSTR(n_banno,1,INDEX(n_banno,"อาคาร") - 1)).
        ELSE IF R-INDEX(n_banno,"หมู่บ้าน") <> 0 THEN 
            ASSIGN n_build  = trim(SUBSTR(n_banno,R-INDEX(n_banno,"หมู่บ้าน")))
            n_banno         = trim(SUBSTR(n_banno,1,R-INDEX(n_banno,"หมู่บ้าน") - 1)).
        ELSE IF INDEX(n_banno,"ห้อง") <> 0 THEN 
            ASSIGN n_build  = trim(SUBSTR(n_banno,INDEX(n_banno,"ห้อง")))
            n_banno         = trim(SUBSTR(n_banno,1,INDEX(n_banno,"ห้อง") - 1)).
        ELSE IF INDEX(n_banno,"ชั้น") <> 0 THEN 
            ASSIGN n_build  = trim(SUBSTR(n_banno,INDEX(n_banno,"ชั้น")))
            n_banno         = trim(SUBSTR(n_banno,1,INDEX(n_banno,"ชั้น") - 1)).
        ELSE n_build = "" .  /*A55-0108*/
        IF INDEX(n_banno,"หมู่") <> 0 THEN 
            ASSIGN n_muno   = trim(SUBSTR(n_banno,INDEX(n_banno,"หมู่")))
            n_banno         = trim(SUBSTR(n_banno,1,R-INDEX(n_banno,"หมู่") - 1)).
        ELSE ASSIGN n_muno   = "".
        IF INDEX(n_banno,"เลขที่") <> 0 THEN ASSIGN n_banno = trim(SUBSTR(n_banno,7)).
        ELSE ASSIGN n_banno = trim(n_banno).

        IF n_banno <> "" THEN DO:  /*เลขที่ */
            IF n_muno  <> "" THEN n_banno = trim(n_banno + " " + n_muno). /* หมู่  */
            /*IF n_build <> "" THEN n_banno = trim(n_banno + " " + n_build). *//*A62-0219*/
            /* A62-0219 */
            IF LENGTH(n_banno + n_build) >= 35 THEN 
                n_soy = trim(n_build + " " + n_soy ).
            ELSE n_banno = trim(n_banno + " " + n_build).
             /* end  A62-0219 */
            IF LENGTH(n_banno + n_soy) >= 35 THEN DO:
                IF n_soy   <> "" THEN n_banno1 = trim(n_banno1 + " " + n_soy). 
                IF n_road  <> "" THEN n_banno1 = trim(n_banno1 + " " + n_road). 
            END.
            ELSE DO:
                IF n_soy   <> "" THEN n_banno = trim(n_banno + " " + n_soy). 
                IF  LENGTH(n_banno + n_road) >= 35 THEN DO:
                    IF n_road  <> "" THEN n_banno1 = trim(n_banno1 + " " + n_road). 
                END.
                ELSE IF n_road  <> "" THEN n_banno = trim(n_banno + " " + n_road). 
            END.
        END.
        ELSE DO: /*n_banno <> ""*/
            IF n_muno  <> "" THEN n_banno = n_muno. /* หมู่  */
            /*IF n_build <> "" THEN n_banno = trim(n_banno + " " + n_build). */ /*A62-0219*/
             /* A62-0219 */
            IF LENGTH(n_banno + n_build) >= 35 THEN 
                n_soy = trim(n_build + " " + n_soy ).
            ELSE n_banno = trim(n_banno + " " + n_build).
             /* end  A62-0219 */
            IF LENGTH(n_banno) >= 32 THEN DO:
                IF n_soy   <> "" THEN n_banno1 = trim(n_banno1 + " " + n_soy). 
                IF n_road  <> "" THEN n_banno1 = trim(n_banno1 + " " + n_road). 
            END.
            ELSE DO:
                IF n_soy   <> "" THEN n_banno = trim(n_banno + " " + n_soy). 
                IF n_road  <> "" THEN n_banno = trim(n_banno + " " + n_road). 
            END.
        END.
        /*comment by Kridtiya i. A55-0108...
        IF (LENGTH(n_banno) + LENGTH(n_muno) + LENGTH(n_build) + LENGTH(n_soy))  > 32 THEN  
            ASSIGN wdetail2.ADD_3 = wdetail2.ADD_2 + " " + wdetail2.ADD_3
                   wdetail2.ADD_2 = n_soy + " " + n_road 
                   wdetail2.ADD_1 = n_banno + " " + n_muno + " " + n_build .
        ELSE  ASSIGN   wdetail2.ADD_3 = wdetail2.ADD_3
                       wdetail2.ADD_2 = n_road + " " + wdetail2.ADD_2
                       wdetail2.ADD_1 = n_banno + " " + n_muno + " " + n_build + " " + n_soy.
        end...comment by Kridtiya i. A55-0108...*/
        /*add by Kridtiya i. A55-0108...*/
        IF n_banno1 = "" THEN  
            ASSIGN  wdetail2.ADD_3 = wdetail2.ADD_3
            wdetail2.ADD_2 = wdetail2.ADD_2
            wdetail2.ADD_1 = n_banno.
        ELSE ASSIGN wdetail2.ADD_3 = wdetail2.ADD_2 + " " + wdetail2.ADD_3
            wdetail2.ADD_2 = n_banno1
            wdetail2.ADD_1 = n_banno.
        /*end...comment by Kridtiya i. A55-0108...*/
        /*ASSIGN n_comdate  = string(DAY(date(wdetail2.comdat)),"99")   + "/" +  
        string(MONTH(date(wdetail2.comdat)),"99") + "/" +  
        STRING(YEAR(date(wdetail2.comdat)),"9999") . 
        IF (TODAY - date(n_comdate)) >= 29 THEN DO:          /* 27  วันเริ่มคุ้มครอง    */                                   
        /*MESSAGE "เลขที่สัญญาREKK :" wdetail2.notifyno "วันที่เริ่มคุ้มครองน้อยกว่าวันที่นำเข้า 29 วัน" VIEW-AS ALERT-BOX.*/
        ASSIGN wdetail2.comdat = string(DAY(TODAY),"99")   + "/" +       
                                     string(MONTH(TODAY),"99") + "/" +       
                                     STRING(YEAR(TODAY),"9999")            
                wdetail2.expdat    = string(DAY(TODAY),"99")   + "/" +                    
                                     string(MONTH(TODAY),"99") + "/" +       
                                     STRING(YEAR(TODAY) + 1 ,"9999")   .  /* 28  วันสิ้นสุดคุ้มครอง  */    
            FIND LAST brstat.tlt    WHERE 
                brstat.tlt.comp_noti_tlt  = wdetail2.notifyno  AND
                brstat.tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
            IF AVAIL brstat.tlt THEN 
                ASSIGN 
                brstat.tlt.OLD_cha = brstat.tlt.OLD_cha + "เปลี่ยนวันที่เริ่มคุ้มครอง รอลูกค้าชำระเงิน ".
        END.*/

    END.
END.
RUN proc_assign2_veh.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2addr c-win 
PROCEDURE proc_assign2addr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER  np_tambon        as char init "".
DEFINE INPUT  PARAMETER  np_mail_amper    as char init "".
DEFINE INPUT  PARAMETER  np_mail_country  as char init "".
DEFINE INPUT  PARAMETER  np_occupation    as char init "".
DEFINE OUTPUT PARAMETER  np_codeocc       as char init "".
DEFINE OUTPUT PARAMETER  np_codeaddr1     as char init "".
DEFINE OUTPUT PARAMETER  np_codeaddr2     as char init "".
DEFINE OUTPUT PARAMETER  np_codeaddr3     as char init "".
DEFINE VAR nv_address AS CHAR INIT  "".

ASSIGN nv_address = trim(np_tambon + " " + np_mail_amper + " " + np_mail_country) .

IF      R-INDEX(nv_address,"จ.")       <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จ.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จ.")       - 1 )). 
ELSE IF R-INDEX(nv_address,"จังหวัด.") <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จังหวัด.")   + 8 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จังหวัด.") - 1 )). 
ELSE IF R-INDEX(nv_address,"จังหวัด")  <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จังหวัด")    + 7 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จังหวัด")  - 1 )). 
ELSE IF R-INDEX(nv_address,"กรุงเทพ")  <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"กรุงเทพ"))) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"กรุงเทพ")  - 1 )).
ELSE IF R-INDEX(nv_address,"กทม")      <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"กทม"))) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"กทม")  - 1 )).

IF index(np_mail_country," ") <> 0  THEN 
    ASSIGN 
    nv_postcd       = trim(SUBSTR(np_mail_country,index(np_mail_country," "))) 
    np_mail_country = trim(SUBSTR(np_mail_country,1,index(np_mail_country," ") - 1 )) .
IF      index(np_mail_country,"กรุงเทพ") <> 0 THEN np_mail_country = "กรุงเทพมหานคร".
ELSE IF index(np_mail_country,"กทม")     <> 0 THEN np_mail_country = "กรุงเทพมหานคร".

IF      R-INDEX(nv_address,"อำเภอ.")   <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"อำเภอ.")     + 6 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"อำเภอ.")   - 1 )). 
ELSE IF R-INDEX(nv_address,"อำเภอ")    <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"อำเภอ")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"อำเภอ")    - 1 )).
ELSE IF R-INDEX(nv_address,"อ.")       <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"อ.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"อ.")       - 1 )).
ELSE IF R-INDEX(nv_address,"เขต.")     <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"เขต.")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"เขต.")     - 1 )).
ELSE IF R-INDEX(nv_address,"เขต")      <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"เขต")        + 3 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"เขต")      - 1 )). 

IF      R-INDEX(nv_address,"ต.")       <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"ต.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"ต.")       - 1 )).
ELSE IF R-INDEX(nv_address,"ตำบล.")    <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"ตำบล.")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"ตำบล.")    - 1 )).
ELSE IF R-INDEX(nv_address,"ตำบล")     <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"ตำบล")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"ตำบล")     - 1 )).

ELSE IF R-INDEX(nv_address,"แขวง.")    <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"แขวง.")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"แขวง.")    - 1 )). 
ELSE IF R-INDEX(nv_address,"แขวง")     <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"แขวง")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"แขวง")     - 1 )). 

FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE 
    sicuw.uwm500.prov_d = np_mail_country  NO-LOCK NO-ERROR NO-WAIT.  /*"กาญจนบุรี"*/   /*uwm100.codeaddr1*/
IF AVAIL sicuw.uwm500 THEN DO:  
     /*DISP sicuw.uwm500.prov_n . */
    FIND LAST sicuw.uwm501 USE-INDEX uwm50102   WHERE 
        sicuw.uwm501.prov_n = sicuw.uwm500.prov_n  AND
        index(sicuw.uwm501.dist_d,np_mail_amper) <> 0        NO-LOCK NO-ERROR NO-WAIT. /*"พนมทวน"*/
    IF AVAIL sicuw.uwm501 THEN DO:  
         /*DISP
        sicuw.uwm501.prov_n  /* uwm100.codeaddr1 */
        sicuw.uwm501.dist_n  /* uwm100.codeaddr2 */ 
        . */
         
        FIND LAST sicuw.uwm506 USE-INDEX uwm50601 WHERE 
            sicuw.uwm506.prov_n   = sicuw.uwm501.prov_n and
            sicuw.uwm506.dist_n   = sicuw.uwm501.dist_n and
            sicuw.uwm506.sdist_d  = np_tambon           NO-LOCK NO-ERROR NO-WAIT. /*"รางหวาย"*/
        IF AVAIL sicuw.uwm506 THEN  
            ASSIGN 
            np_codeaddr1 =  sicuw.uwm506.prov_n   /*= uwm100.codeaddr1 */
            np_codeaddr2 =  sicuw.uwm506.dist_n   /*= uwm100.codeaddr2 */
            np_codeaddr3 =  sicuw.uwm506.sdist_n  /*= uwm100.codeaddr3 */
            .  
    END.
END. 
/*occup */
IF np_occupation = "" THEN np_codeocc  = "9999".
ELSE DO:
    FIND FIRST stat.occupdet WHERE 
        stat.occupdet.desocct = np_occupation   /*Thai*/
        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.occupdet THEN DO:
        ASSIGN np_codeocc = stat.occupdet.codeocc .
    END.
    ELSE DO:
        FIND FIRST stat.occupdet WHERE 
            stat.occupdet.desocce = np_occupation   /*Eng*/
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.occupdet THEN DO:
            ASSIGN np_codeocc = stat.occupdet.codeocc .
        END.
        ELSE np_codeocc  = "9999".
    END.
END.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2_veh c-win 
PROCEDURE proc_assign2_veh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_vehpro AS CHAR FORMAT "x(50)" INIT "".
ASSIGN 
    fi_show  = "Match province ......"
    n_vehpro = "" .
DISP fi_show WITH FRAM fr_main.
FOR EACH wdetail2 .
    IF wdetail2.notifyno NE "" THEN DO:
        ASSIGN n_vehpro = "". /*A58-0179*/
        /*A55-0125
        IF (wdetail2.provin = "") OR (wdetail2.licence = "") THEN 
            ASSIGN   wdetail2.licence = "/" + SUBSTRING(trim(wdetail2.chassis),LENGTH(trim(wdetail2.chassis))  - 8 ). 
            A55-0125 ....*/
        /*A55-0125*/
        IF (wdetail2.provin = "") OR (wdetail2.licence = "") THEN DO: 
            IF length(wdetail2.chassis) <= 8  THEN 
                ASSIGN   
                wdetail2.licence = "/" + wdetail2.chassis
                wdetail2.provin  = ""  .  /*A58-0179*/
            ELSE  
                ASSIGN   
                    wdetail2.licence = "/" + SUBSTRING(trim(wdetail2.chassis),LENGTH(trim(wdetail2.chassis))  - 8 ) 
                    wdetail2.provin  = ""  .  /*A58-0179*/
        END.  /*A55-0125*/
        ELSE DO:
            ASSIGN n_vehpro = trim(wdetail2.provin).
            FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*licence  */
                brstat.insure.compno = "999" AND
                index(n_vehpro,brstat.Insure.fName) <> 0 NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  
                ASSIGN 
                n_vehpro        = trim(brstat.insure.LName) 
                wdetail2.provin = n_vehpro .
            ELSE DO:
                IF      index(n_vehpro,"กระบี่")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"กระบี่") - 2 )        + " กบ".  /*1*/ 
                ELSE IF index(n_vehpro,"กรุงเทพมหานคร")    <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"กรุงเทพมหานคร") - 2 ) + " กท".  /*2*/   
                ELSE IF index(n_vehpro,"กาญจนบุรี")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"กาญจนบุรี") - 2 )     + " กจ".  /*3*/ 
                ELSE IF index(n_vehpro,"กาฬสินธุ์")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"กาฬสินธุ์") - 2 )     + " กส".  /*4*/ 
                ELSE IF index(n_vehpro,"กำแพงเพชร")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"กำแพงเพชร") - 2 )     + " กพ".  /*5*/ 
                ELSE IF index(n_vehpro,"ขอนแก่น")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ขอนแก่น") - 2 )       + " ขก".  /*6*/ 
                ELSE IF index(n_vehpro,"จันทบุรี")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"จันทบุรี") - 2 )      + " จท".  /*7*/ 
                ELSE IF index(n_vehpro,"ฉะเชิงเทรา")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ฉะเชิงเทรา") - 2 )    + " ฉท".  /*8*/ 
                ELSE IF index(n_vehpro,"ชลบุรี")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ชลบุรี") - 2 )        + " ชบ".  /*9*/ 
                ELSE IF index(n_vehpro,"ชัยนาท")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ชัยนาท") - 2 )        + " ชน".  /*10*/
                ELSE IF index(n_vehpro,"ชัยภูมิ")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ชัยภูมิ") - 2 )       + " ชย".  /*11*/
                ELSE IF index(n_vehpro,"ชุมพร")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ชุมพร") - 2 )         + " ชพ".  /*12*/
                ELSE IF index(n_vehpro,"เชียงราย")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"เชียงราย") - 2 )      + " ชร".  /*13*/
                ELSE IF index(n_vehpro,"เชียงใหม่")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"เชียงใหม่") - 2 )     + " ชม".  /*14*/
                ELSE IF index(n_vehpro,"ตรัง")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ตรัง") - 2 )          + " ตง".  /*15*/
                ELSE IF index(n_vehpro,"ตราด")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ตราด") - 2 )          + " ตร".  /*16*/
                ELSE IF index(n_vehpro,"ตาก")              <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ตาก") - 2 )           + " ตก".  /*17*/
                ELSE IF index(n_vehpro,"นครนายก")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"นครนายก") - 2 )       + " นย".  /*18*/
                ELSE IF index(n_vehpro,"นครปฐม")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"นครปฐม") - 2 )        + " นฐ".  /*19*/
                ELSE IF index(n_vehpro,"นครพนม")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"นครพนม") - 2 )        + " นพ".  /*20*/
                ELSE IF index(n_vehpro,"นครราชสีมา")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"นครราชสีมา") - 2 )    + " นม".  /*21*/
                ELSE IF index(n_vehpro,"นครศรีธรรมราช")    <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"นครศรีธรรมราช") - 2 ) + " นศ".  /*22*/
                ELSE IF index(n_vehpro,"นครสวรรค์")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"นครสวรรค์") - 2 )     + " นว".  /*23*/
                ELSE IF index(n_vehpro,"นนทบุรี")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"นนทบุรี") - 2 )       + " นบ".  /*24*/
                ELSE IF index(n_vehpro,"นราธิวาส")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"นราธิวาส") - 2 )      + " นธ".  /*25*/
                ELSE IF index(n_vehpro,"น่าน")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"น่าน") - 2 )          + " นน".  /*26*/
                ELSE IF index(n_vehpro,"บุรีรัมย์")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"บุรีรัมย์") - 2 )     + " บร".  /*27*/
                ELSE IF index(n_vehpro,"ปทุมธานี")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ปทุมธานี") - 2 )      + " ปท".  /*28*/
                ELSE IF index(n_vehpro,"ประจวบคีรีขันธ์")  <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ประจวบคีรีขันธ์") - 2 ) + " ปข".  /*29*/
                ELSE IF index(n_vehpro,"ปราจีนบุรี")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ปราจีนบุรี") - 2 )    + " ปจ".  /*30*/
                ELSE IF index(n_vehpro,"ปัตตานี")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ปัตตานี") - 2 )       + " ปน".  /*31*/
                ELSE IF (index(n_vehpro,"พระนครศรีอยุธยา") <> 0 ) THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"พระนครศรีอยุธยา") - 2 ) + " อย".  /*32*/
                ELSE IF (index(n_vehpro,"อยุธยา")          <> 0 ) THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"อยุธยา") - 2 )      + " อย".  /*32*/
                ELSE IF index(n_vehpro,"พะเยา")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"พะเยา") - 2 )         + " พย".      /*33*/
                ELSE IF index(n_vehpro,"พังงา")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"พังงา") - 2 )         + " พง".      /*34*/
                ELSE IF index(n_vehpro,"พัทลุง")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"พัทลุง") - 2 )        + " พท".      /*35*/
                ELSE IF index(n_vehpro,"พิจิตร")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"พิจิตร") - 2 )        + " พจ".      /*36*/
                ELSE IF index(n_vehpro,"พิษณุโลก")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"พิษณุโลก") - 2 )      + " พล".      /*37*/
                ELSE IF index(n_vehpro,"เพชรบุรี")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"เพชรบุรี") - 2 )      + " พบ".      /*38*/
                ELSE IF index(n_vehpro,"เพชรบูรณ์")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"เพชรบูรณ์") - 2 )     + " พช".      /*39*/
                ELSE IF index(n_vehpro,"แพร่")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"แพร่") - 2 )          + " พร".      /*40*/
                ELSE IF index(n_vehpro,"ภูเก็ต")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ภูเก็ต") - 2 )        + " ภก".      /*41*/
                ELSE IF index(n_vehpro,"มหาสารคาม")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"มหาสารคาม") - 2 )     + " มค".      /*42*/
                ELSE IF index(n_vehpro,"มุกดาหาร")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"มุกดาหาร") - 2 )      + " มห".     /*43*/
                ELSE IF index(n_vehpro,"แม่ฮ่องสอน")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"แม่ฮ่องสอน") - 2 )    + " มส".     /*44*/
                ELSE IF index(n_vehpro,"ยะลา")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ยะลา") - 2 )          + " ยล".     /*45*/
                ELSE IF index(n_vehpro,"ร้อยเอ็ด")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ร้อยเอ็ด") - 2 )      + " รอ".     /*46*/
                ELSE IF index(n_vehpro,"ระนอง")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ระนอง") - 2 )         + " รน".     /*47*/
                ELSE IF index(n_vehpro,"ระยอง")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ระยอง") - 2 )         + " รย".     /*48*/
                ELSE IF index(n_vehpro,"ราชบุรี")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ราชบุรี") - 2 )       + " รบ".     /*49*/
                ELSE IF index(n_vehpro,"ลพบุรี")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ลพบุรี") - 2 )        + " ลบ".     /*50*/
                ELSE IF index(n_vehpro,"ลำปาง")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ลำปาง") - 2 )         + " ลป".     /*51*/
                ELSE IF index(n_vehpro,"ลำพูน")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ลำพูน") - 2 )         + " ลพ".     /*52*/
                ELSE IF index(n_vehpro,"เลย")              <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"เลย") - 2 )           + " ลย".     /*53*/
                ELSE IF index(n_vehpro,"ศรีสะเกษ")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ศรีสะเกษ") - 2 )      + " ศก".     /*54*/
                ELSE IF index(n_vehpro,"สกลนคร")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สกลนคร") - 2 )        + " สน".     /*55*/
                ELSE IF index(n_vehpro,"สงขลา")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สงขลา") - 2 )         + " สข".     /*56*/
                ELSE IF index(n_vehpro,"สระแก้ว")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สระแก้ว") - 2 )       + " สก".     /*57*/
                ELSE IF index(n_vehpro,"สระบุรี")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สระบุรี") - 2 )       + " สบ".     /*58*/
                ELSE IF index(n_vehpro,"สิงห์บุรี")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สิงห์บุรี") - 2 )     + " สห".     /*59*/
                ELSE IF index(n_vehpro,"สุโขทัย")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สุโขทัย") - 2 )       + " สท".     /*60*/
                ELSE IF index(n_vehpro,"สุพรรณบุรี")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สุพรรณบุรี") - 2 )    + " สพ".     /*61*/
                ELSE IF index(n_vehpro,"สุราษฎร์ธานี")     <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สุราษฎร์ธานี") - 2 )  + " สฎ".   /*62*/
                ELSE IF index(n_vehpro,"สุรินทร์")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สุรินทร์") - 2 )      + " สร".    /*63*/
                ELSE IF index(n_vehpro,"หนองคาย")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"หนองคาย") - 2 )       + " นค".    /*64*/
                ELSE IF index(n_vehpro,"หนองบัวลำพู")      <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"หนองบัวลำพู") - 2 )   + " นล".    /*65*/
                ELSE IF index(n_vehpro,"อ่างทอง")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"อ่างทอง") - 2 )       + " อท".    /*66*/
                ELSE IF index(n_vehpro,"อำนาจเจริญ")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"อำนาจเจริญ") - 2 )    + " อจ".    /*67*/
                ELSE IF index(n_vehpro,"อุดรธานี")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"อุดรธานี") - 2 )      + " อด".    /*68*/
                ELSE IF index(n_vehpro,"อุตรดิตถ์")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"อุตรดิตถ์") - 2 )     + " อต".    /*69*/
                ELSE IF index(n_vehpro,"อุทัยธานี")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"อุทัยธานี") - 2 )     + " อท".    /*70*/
                ELSE IF index(n_vehpro,"อุบลราชธานี")      <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"อุบลราชธานี") - 2 )   + " อบ".    /*71*/
                ELSE IF index(n_vehpro,"ยโสธร")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ยโสธร") - 2 )         + " ยส".    /*72*/
                ELSE IF index(n_vehpro,"สตูล")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สตูล") - 2 )          + " สต".    /*73*/
                ELSE IF index(n_vehpro,"สุมทรปราการ")      <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สุมทรปราการ") - 2 )   + " สป".    /*74*/
                ELSE IF index(n_vehpro,"สุมทรสงคราม")      <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สุมทรสงคราม") - 2 )   + " สส".    /*75*/
                ELSE IF index(n_vehpro,"สุมทรสาคร")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"สุมทรสาคร") - 2 )     + " สค".    /*76*/
                ELSE n_vehpro = wdetail2.provin.
                     ASSIGN wdetail2.provin = trim(n_vehpro).
                END.
        END.  /* FIND FIRST brstat.insure *//* A57-0179 */
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign3 c-win 
PROCEDURE proc_assign3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_length AS INT.
FOR EACH wdetail2 .
    IF wdetail2.pol70 = "" THEN NEXT.
    IF (wdetail2.notifyno NE "")  THEN DO:
        /*create pol 70 .....*/
        FIND FIRST wdetail WHERE wdetail.policy = wdetail2.pol70 NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN  /*wdetail.policy      = wdetail2.pol70*/  /*A55-0125*/
                wdetail.policy      = trim(wdetail2.pol70)    /*A55-0125*/
                wdetail.brand       = trim(wdetail2.brand)
                /*wdetail.caryear     = wdetail2.cyear */     /*A55-0125*/ 
                wdetail.caryear     = trim(wdetail2.cyear)    /*A55-0125*/ 
                wdetail.poltyp      = "70" 
                wdetail.comdat      = trim(wdetail2.comdat)  
                wdetail.expdat      = trim(wdetail2.expdat) 
                wdetail.ispno       = trim(wdetail2.ispno)
                wdetail.tiname      = trim(wdetail2.n_TITLE)
                wdetail.insnam      = trim(wdetail2.n_name1) 
                wdetail.iadd1       = trim(wdetail2.ADD_1) 
                wdetail.iadd2       = trim(wdetail2.ADD_2)  
                wdetail.iadd3       = trim(wdetail2.ADD_3)  
                wdetail.iadd4       = trim(wdetail2.ADD_4)   + " " +  trim(wdetail2.ADD_5) 
                wdetail.idno        = trim(wdetail2.idno)      
                wdetail.birthday    = IF (trim(string(wdetail2.birthday))  <> "") AND (trim(string(wdetail2.idexpdat)) <> "")  THEN "DOB" + "EXP" + (trim(string(wdetail2.birthday))) + (trim(string(wdetail2.idexpdat)))  
                                 ELSE IF (trim(string(wdetail2.birthday))   = "") AND (trim(string(wdetail2.idexpdat)) <> "")  THEN "EXP" + (trim(string(wdetail2.idexpdat)))  
                                 ELSE IF (trim(string(wdetail2.birthday))  <> "") AND (trim(string(wdetail2.idexpdat))  = "")  THEN "DOB" + (trim(string(wdetail2.birthday)))   
                                 ELSE ""
                wdetail.occupins    = trim(wdetail2.occupins)                         
                wdetail.namedirect  = trim(wdetail2.namedirect)
                wdetail.drivname1   = IF index(trim(wdetail2.driv_no),"ไม่ระบุ") <> 0 THEN ""
                                      ELSE IF trim(wdetail2.drivname1) = "" THEN ""
                                      ELSE   trim(wdetail2.drivname1)
                                      + "sex:"   + trim(wdetail2.sexdri1)  
                                      + "hbd:"   + trim(wdetail2.birthdri1)
                                      + "occup:" + trim(wdetail2.occupdri1)
                wdetail.idnodri1    = IF index(trim(wdetail2.driv_no),"ไม่ระบุ") <> 0 THEN ""
                                      ELSE  trim(wdetail2.idnodri1)
                wdetail.drivname2   = IF index(trim(wdetail2.driv_no),"ไม่ระบุ") <> 0 THEN ""
                                      ELSE IF trim(wdetail2.drivname2) = "" THEN ""
                                      ELSE   trim(wdetail2.drivname2)
                                      + "sex:"   + trim(wdetail2.sexdri2)  
                                      + "hbd:"   + trim(wdetail2.birthdri2)
                                      + "occup:" + trim(wdetail2.occupdri2)
                wdetail.idnodri2    = IF index(trim(wdetail2.driv_no),"ไม่ระบุ") <> 0 THEN ""
                                      ELSE  trim(wdetail2.idnodri2)
                /*A55-0125
                wdetail.prempa      = substr(wdetail2.subclass,1,1) 
                wdetail.subclass    = substr(wdetail2.subclass,2,3) ...A55-0125*/
                wdetail.prempa      = IF wdetail2.subclass = "" THEN "" ELSE substr(wdetail2.subclass,1,1)   /*A55-0125*/
                wdetail.subclass    = IF wdetail2.subclass = "" THEN "" ELSE substr(wdetail2.subclass,2,3)   /*A55-0125*/
                wdetail.model       = trim(wdetail2.model) 
                wdetail.cc          = IF deci(wdetail2.power) = 0 THEN "0"
                                      ELSE string(ROUND((deci(wdetail2.power) / 100 ),0) * 100)
                wdetail.weight      = "0"   
                wdetail.vehreg      = IF wdetail2.provin = "" THEN trim(wdetail2.licence) 
                                      ELSE TRIM(wdetail2.licence + " " + wdetail2.provin)
                wdetail.engno       = trim(wdetail2.engine)
                wdetail.chasno      = trim(wdetail2.chassis)
                wdetail.vehuse      = "1"
                /*  ..A55-0125  wdetail.garage      = wdetail2.garage
                wdetail.stk         = wdetail2.sck 
                wdetail.covcod      = wdetail2.covcod
                wdetail.product     = wdetail2.product
                wdetail.vatcode     = wdetail2.vatcode   
                wdetail.branch      = wdetail2.branch       ....A55-0125*/
                wdetail.garage      = trim(wdetail2.garage)   /*A55-0125*/
                wdetail.stk         = trim(wdetail2.sck)      /*A55-0125*/
                wdetail.covcod      = trim(wdetail2.covcod)   /*A55-0125*/
                wdetail.product     = trim(wdetail2.product)  /*A55-0125*/
                wdetail.si          = trim(wdetail2.ins_amt1) /*A55-0125*/
                wdetail.fi          = TRIM(wdetail2.fi)         /*A62-0219*/
                wdetail.deduct      = IF (wdetail2.deduct  = "" ) OR (deci(wdetail2.deduct) = 0 ) THEN 0 ELSE deci(wdetail2.deduct)
                wdetail.vatcode     = trim(wdetail2.vatcode)  /*A55-0125*/
                wdetail.branch      = trim(wdetail2.branch)   /*A55-0125*/
                wdetail.benname     = TRIM(wdetail2.bennam)
                wdetail.volprem     = trim(wdetail2.prem1) 
                wdetail.typecar     = trim(wdetail2.cov_new)
                wdetail.comment     = ""
                wdetail.producer    = trim(wdetail2.producer)
                wdetail.agent       = trim(wdetail2.agent)  
                wdetail.deler       = trim(wdetail2.deler)     /*A56-0024 */
                /*wdetail.entdat      = string(TODAY)                /*entry date*/
                wdetail.enttim      = STRING(TIME, "HH:MM:SS") */   /*entry time*/
                /*wdetail.trandat     = STRING(TODAY)               /*tran date*/
                wdetail.trantim     = STRING(TIME, "HH:MM:SS") */   /*tran time*/
                wdetail.n_IMPORT    = "IM"
                wdetail.n_EXPORT    = ""  
                wdetail.nmember     = "เลขรับเเจ้ง[phone] : " + trim(wdetail2.notifyno) + 
                                      "  รหัสบรษัท : " + trim(wdetail2.comp_code) 
                wdetail.nmember2    = trim(wdetail2.cmbr_no) + "-:" + trim(wdetail2.cmbr_code) + ":" + trim(wdetail2.NAME_mkt)
                wdetail.campaigno    = IF wdetail2.campaigno = "" THEN "" ELSE 
                                      "Campaign no.:  " + trim(wdetail2.campaigno)
                wdetail.notiuser    = IF wdetail2.notiuser = "" THEN "" ELSE 
                                      "ผู้รับแจ้ง : " + trim(wdetail2.notiuser)
                wdetail.remak1      = IF trim(wdetail2.remak1) = "" THEN "" ELSE 
                                      "หมายเหตุ " + trim(wdetail2.remak1)  

                /* Begin by Phaiboon W. [A59-0488] Date 07/11/2016 */
                wdetail.remak2      = IF trim(wdetail2.remak2) = "" THEN "" ELSE
                                      trim(wdetail2.remak2)
                
                nv_prmtxt1          = TRIM(wdetail2.other1) + " " + TRIM(wdetail2.other2)
                nv_prmtxt1          = nv_prmtxt1 + FILL(" ",60 - LENGTH(nv_prmtxt1))
                
                nv_prmtxt2          = TRIM(wdetail2.other3)
                nv_prmtxt2          = nv_prmtxt2 + FILL(" ",60 - LENGTH(nv_prmtxt2))
                                               
                wdetail.quotation   = IF LENGTH(wdetail2.quotation) <= 4 THEN ""
                                      ELSE TRIM(wdetail2.quotation) + " " + TRIM(wdetail2.ngarage)

                wdetail.ispstatus   = wdetail2.ispstatus
                /* End by Phaiboon W. [A59-0488] Date 07/11/2016 */

                wdetail.notifydat   = "PHONE" + wdetail2.Notify_dat +  wdetail2.time_notify  + " " +  /*A56-0024*/     
                                      "วันที่รับแจ้ง : " + wdetail2.Notify_dat +
                                      " เวลารับแจ้ง : "  + wdetail2.time_notify
                /*wdetail.cedpol      = wdetail2.ref  */      /*A55-0125*/
                wdetail.cedpol      = trim(wdetail2.ref)     /*A55-0125*/
                /* add by  A62-0219 */
                wdetail.deductpp    = if trim(wdetail2.tp)  <> "0" then trim(wdetail2.tp)  else STRING(fi_tpp)
                wdetail.deductba    = if trim(wdetail2.ta)  <> "0" then trim(wdetail2.ta)  else STRING(fi_tba)
                wdetail.deductpa    = if trim(wdetail2.td)  <> "0" then trim(wdetail2.td)  else STRING(fi_tpa)
                wdetail.NO_41       = if trim(wdetail2.n41) <> "0" then trim(wdetail2.n41) else STRING(fi_pa41)
                wdetail.NO_42       = if trim(wdetail2.n42) <> "0" then trim(wdetail2.n42) else STRING(fi_pa42)
                wdetail.NO_43       = if trim(wdetail2.n43) <> "0" then trim(wdetail2.n43) else STRING(fi_pa43)
                wdetail.notbr       = wdetail2.notbr
                wdetail.reinsp      = wdetail2.reinsp
                wdetail.phone       = wdetail2.tel 
                wdetail.redbook     = TRIM(wdetail2.redbook) .
                
                IF trim(wdetail2.comp_code) = "ORICO" THEN DO:
                   IF trim(wdetail2.recivename) <> "" THEN DO:
                    ASSIGN wdetail.recivename = SUBSTR(wdetail2.recivename,1,INDEX(wdetail2.recivename,"ที่อยู่") - 2)
                           wdetail.recaddr    = SUBSTR(wdetail2.recivename,INDEX(wdetail2.recivename,"ที่อยู่") + 8 )
                           wdetail.rectax     = SUBSTR(wdetail.recaddr,R-INDEX(wdetail.recaddr,"เลขที่ผู้เสียภาษี") + 18)
                           wdetail.recaddr    = SUBSTR(wdetail.recaddr,1,LENGTH(wdetail.recaddr) - (LENGTH(wdetail.rectax) + 18)).
                    
                    IF TRIM(wdetail.rectax) = "" AND INDEX(wdetail.recivename,wdetail.insnam) <> 0  THEN ASSIGN wdetail.rectax = trim(wdetail2.idno).
                   END.
                   ELSE ASSIGN wdetail.recivename = trim(wdetail2.recivename).
                END.
                ELSE DO:
                    ASSIGN wdetail.recivename = trim(wdetail2.recivename).
                END.
                /* end A62-0219*/
            END.  /*if avail*/
            ELSE MESSAGE "พบกรมธรรม์นี้ซ้ำในไฟล์เดียวกันเลขกรมธรรม์คือ: " +  wdetail.policy VIEW-AS ALERT-BOX.

            /* Begin by Phaiboon W. [A59-0488] Date 21/11/2016 */
            nv_prmchk = DEC(wdetail2.other2) NO-ERROR.

            IF nv_prmchk <= 0 OR nv_prmchk = ? THEN DO:
                wdetail.prmtxt  = nv_prmtxt2.
                wdetail.prmtxt2 = "".
            END.
            ELSE DO:
                wdetail.prmtxt  = nv_prmtxt1 + nv_prmtxt2.
                wdetail.prmtxt2 = "อุปกรณ์เสริม : คุ้มครองไม่เกิน" + " " + TRIM(wdetail2.other2).
            END.
            
            wdetail.prmtxt3     = nv_prmtxt2.

            IF wdetail.prmtxt2 = "" AND wdetail.prmtxt3 <> "" THEN DO:
                wdetail.prmtxt2 = "อุปกรณ์เสริม : " + wdetail.prmtxt3.
                wdetail.prmtxt3 = "".
            END.
            ELSE IF wdetail.prmtxt2 = "" AND wdetail.prmtxt3 = "" THEN wdetail.prmtxt2 = "อุปกรณ์เสริม : ".
            /* End by Phaiboon W. [A59-0488] Date 21/11/2016 */

            IF wdetail2.pol72 <> "" THEN RUN proc_assign72.
            
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign72 c-win 
PROCEDURE proc_assign72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.policy = trim(wdetail2.pol72) NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN
        /*comment by Kridtiya i. A55-0125
        wdetail.policy      = wdetail2.pol72
        wdetail.brand       = trim(wdetail2.brand)
        wdetail.caryear     = wdetail2.cyear 
        wdetail.poltyp      = "72" 
        wdetail.comdat      = trim(wdetail2.comdat)  
        wdetail.expdat      = trim(wdetail2.expdat) 
        wdetail.tiname      = trim(wdetail2.n_TITLE)
        wdetail.insnam      = trim(wdetail2.n_name1) 
        wdetail.iadd1       = trim(wdetail2.ADD_1) 
        wdetail.iadd2       = trim(wdetail2.ADD_2)  
        wdetail.iadd3       = trim(wdetail2.ADD_3)  
        wdetail.iadd4       = trim(wdetail2.ADD_4)   + " " +  
                              trim(wdetail2.ADD_5) 
        wdetail.prempa      = substr(wdetail2.subclass,1,1) 
        wdetail.subclass    = substr(wdetail2.subclass,2,3)
        wdetail.model       = trim(wdetail2.model) 
        wdetail.cc          = IF deci(wdetail2.power) = 0 THEN "0"
                              ELSE string(ROUND((deci(wdetail2.power) / 100 ),0) * 100)
        wdetail.weight      = trim(wdetail2.power)    
        wdetail.vehreg      = IF wdetail2.provin = "" THEN wdetail2.licence ELSE TRIM(wdetail2.licence + " " + wdetail2.provin)
        wdetail.engno       = trim(wdetail2.engine)
        wdetail.chasno      = trim(wdetail2.chassis)
        wdetail.vehuse      = "1"
        wdetail.garage      = " " 
        wdetail.vatcode     = wdetail2.vatcode
        wdetail.stk         = wdetail2.sck 
        wdetail.covcod      = "T"
        wdetail.si          = trim(wdetail2.ins_amt1)
        wdetail.branch      = wdetail2.branch 
        wdetail.benname     = TRIM(wdetail2.bennam)
        wdetail.volprem     = wdetail2.prem1
        wdetail.typecar     = wdetail2.cov_new
        wdetail.comment     = ""
        wdetail.producer    = wdetail2.producer
        wdetail.agent       = wdetail2.agent   
        wdetail.entdat      = string(TODAY)                /*entry date*/
        wdetail.enttim      = STRING(TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat     = STRING(TODAY)               /*tran date*/
        wdetail.trantim     = STRING(TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT    = "IM"
        wdetail.n_EXPORT    = ""  
        wdetail.nmember     = "เลขรับเเจ้ง[phone] : " + wdetail2.notifyno + 
                              "  รหัสบรษัท : " + wdetail2.comp_code 
        wdetail.nmember2    = wdetail2.cmbr_no + "-:" + wdetail2.cmbr_code + ":" + trim(wdetail2.NAME_mkt)
        wdetail.campaign    = IF wdetail2.campaigno = "" THEN "" ELSE 
                              "Campaign no.:  " + wdetail2.campaigno
        wdetail.notiuser    = IF wdetail2.notiuser = "" THEN "" ELSE 
                              "ผู้รับแจ้ง : " + wdetail2.notiuser
        wdetail.remak1      = IF trim(wdetail2.remak1) = "" THEN "" ELSE 
                              "หมายเหตุ " + trim(wdetail2.remak1)
        wdetail.cedpol      =  wdetail2.ref .         end....comment by Kridtiya i. A55-0125*/
        /*Add A55-0125....*/
        wdetail.policy      = trim(wdetail2.pol72)
        wdetail.brand       = trim(wdetail2.brand)
        wdetail.caryear     = trim(wdetail2.cyear) 
        wdetail.poltyp      = "72" 
        wdetail.comdat      = trim(wdetail2.comdat)  
        wdetail.expdat      = trim(wdetail2.expdat) 
        wdetail.tiname      = trim(wdetail2.n_TITLE)
        wdetail.insnam      = trim(wdetail2.n_name1) 
        wdetail.iadd1       = trim(wdetail2.ADD_1) 
        wdetail.iadd2       = trim(wdetail2.ADD_2)  
        wdetail.iadd3       = trim(wdetail2.ADD_3)  
        wdetail.iadd4       = trim(wdetail2.ADD_4)   + " " +  trim(wdetail2.ADD_5) 
        wdetail.idno        = trim(wdetail2.idno)      
        wdetail.birthday    = IF (trim(string(wdetail2.birthday))  <> "") AND (trim(string(wdetail2.idexpdat)) <> "")  THEN "DOB" + "EXP" + (trim(string(wdetail2.birthday))) + (trim(string(wdetail2.idexpdat)))  
                         ELSE IF (trim(string(wdetail2.birthday))   = "") AND (trim(string(wdetail2.idexpdat)) <> "")  THEN "EXP" + (trim(string(wdetail2.idexpdat)))  
                         ELSE IF (trim(string(wdetail2.birthday))  <> "") AND (trim(string(wdetail2.idexpdat))  = "")  THEN "DOB" + (trim(string(wdetail2.birthday)))   
                         ELSE ""
        wdetail.occupins    = trim(wdetail2.occupins) 
        wdetail.namedirect  = trim(wdetail2.namedirect)
        wdetail.prempa      = IF wdetail2.subclass = "" THEN "" ELSE substr(wdetail2.subclass,1,1) 
        wdetail.subclass    = IF wdetail2.subclass = "" THEN "" ELSE substr(wdetail2.subclass,2,3)
        wdetail.model       = trim(wdetail2.model) 
        wdetail.cc          = IF deci(wdetail2.power) = 0 THEN "0"
                              ELSE string(ROUND((deci(wdetail2.power) / 100 ),0) * 100)
        wdetail.weight      = trim(wdetail2.power)    
        wdetail.vehreg      = IF wdetail2.provin = "" THEN trim(wdetail2.licence) ELSE TRIM(wdetail2.licence + " " + trim(wdetail2.provin))
        wdetail.engno       = trim(wdetail2.engine)
        wdetail.chasno      = trim(wdetail2.chassis)
        wdetail.vehuse      = "1"
        wdetail.garage      = " " 
        wdetail.vatcode     = trim(wdetail2.vatcode)
        wdetail.stk         = trim(wdetail2.sck) 
        wdetail.covcod      = "T"
        wdetail.si          = trim(wdetail2.ins_amt1)
        wdetail.branch      = trim(wdetail2.branch) 
        wdetail.benname     = TRIM(wdetail2.bennam)
        wdetail.volprem     = trim(wdetail2.prem1)
        wdetail.typecar     = trim(wdetail2.cov_new)
        wdetail.comment     = ""
        wdetail.producer    = trim(wdetail2.producer)
        wdetail.agent       = trim(wdetail2.agent)   
        wdetail.deler       = trim(wdetail2.deler)     /*A56-0024 */
       /* wdetail.entdat      = string(TODAY)                /*entry date*/
        wdetail.enttim      = STRING(TIME, "HH:MM:SS") */   /*entry time*/
        /*wdetail.trandat     = STRING(TODAY)               /*tran date*/
        wdetail.trantim     = STRING(TIME, "HH:MM:SS")*/    /*tran time*/
        wdetail.n_IMPORT    = "IM"
        wdetail.n_EXPORT    = ""  
        wdetail.nmember     = "เลขรับเเจ้ง[phone] : " + trim(wdetail2.notifyno) + 
                              "  รหัสบรษัท : " + trim(wdetail2.comp_code) 
        wdetail.nmember2    = wdetail2.cmbr_no + "-:" + trim(wdetail2.cmbr_code) + ":" + trim(wdetail2.NAME_mkt)
        wdetail.campaigno    = IF trim(wdetail2.campaigno) = "" THEN "" ELSE 
                              "Campaign no.:  " + trim(wdetail2.campaigno)
        wdetail.notiuser    = IF trim(wdetail2.notiuser) = "" THEN "" ELSE 
                              "ผู้รับแจ้ง : " + trim(wdetail2.notiuser)
        wdetail.remak1      = IF trim(wdetail2.remak1) = "" THEN "" ELSE 
                              "หมายเหตุ " + trim(wdetail2.remak1)

        /* Begin by Phaiboon W. [A59-0488] Date 07/11/2016 */
        wdetail.remak2      = IF trim(wdetail2.remak2) = "" THEN "" ELSE
                                 trim(wdetail2.remak2)
                
        nv_prmtxt1          = TRIM(wdetail2.other1) + " " + TRIM(wdetail2.other2)
        nv_prmtxt1          = nv_prmtxt1 + FILL(" ",60 - LENGTH(nv_prmtxt1))
        
        nv_prmtxt2          = TRIM(wdetail2.other3)
        nv_prmtxt2          = nv_prmtxt2 + FILL(" ",60 - LENGTH(nv_prmtxt2))       

        wdetail.quotation   = IF LENGTH(wdetail2.quotation) <= 4 THEN ""
                              ELSE TRIM(wdetail2.quotation) + " " + TRIM(wdetail2.ngarage)
        /* End by Phaiboon W. [A59-0488] Date 07/11/2016 */

        wdetail.cedpol      = trim(wdetail2.ref) 
        wdetail.docno       = TRIM(wdetail2.docno)  /*A62-0219*/
        wdetail.notbr       = wdetail2.notbr        /*A62-0219*/
        wdetail.reinsp      = wdetail2.reinsp      /*A62-0219*/
        wdetail.phone       = wdetail2.tel         /*A62-0219*/
        wdetail.redbook     = TRIM(wdetail2.redbook). /*A62-0219*/
        /*IF trim(wdetail2.comp_code) = "ORICO" THEN do: 
            ASSIGN wdetail.nmember2    = trim(wdetail2.cmbr_no) + " " + 
                                         SUBSTR(wdetail2.NAME_mkt,INDEX(wdetail2.NAME_mkt,".") + 2,LENGTH(wdetail2.NAME_mkt)) . /*A62-0219*/
        END.*/

        /* Begin by Phaiboon W. [A59-0488] Date 21/11/2016 */
        nv_prmchk = DEC(wdetail2.other2) NO-ERROR.

        IF nv_prmchk <= 0 OR nv_prmchk = ? THEN DO:
            wdetail.prmtxt  = nv_prmtxt2.
            wdetail.prmtxt2 = "".
        END.
        ELSE DO:
            wdetail.prmtxt  = nv_prmtxt1 + nv_prmtxt2.
            wdetail.prmtxt2 = "อุปกรณ์เสริม : คุ้มครองไม่เกิน" + " " + TRIM(wdetail2.other2).
        END.
        
        wdetail.prmtxt3     = nv_prmtxt2.

        IF wdetail.prmtxt2 = "" AND wdetail.prmtxt3 <> "" THEN DO:
            wdetail.prmtxt2 = "อุปกรณ์เสริม : " + wdetail.prmtxt3.
            wdetail.prmtxt3 = "".
        END.
        ELSE IF wdetail.prmtxt2 = "" AND wdetail.prmtxt3 = "" THEN wdetail.prmtxt2 = "อุปกรณ์เสริม : ".
        /* End by Phaiboon W. [A59-0488] Date 21/11/2016 */

        /*A55-0125 ......*/
END.   /*if avail*/
ELSE MESSAGE "พบกรมธรรม์นี้ซ้ำในไฟล์เดียวกันเลขกรมธรรม์คือ: " + wdetail.policy VIEW-AS ALERT-BOX.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew c-win 
PROCEDURE proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR number_sic AS INTE INIT 0.
DEF VAR Nv_brchk   AS CHAR FORMAT "x(5)" INIT "" .  /*add Kridtiya i. A55-0016....*/
ASSIGN 
    n_firstdat = ""
    nv_basere  = 0  
    n_41 = 0        
    n_42 = 0         
    n_43 = 0         
    /*dod1 = 0         
    dod2 = 0         
    dod0 = 0 */      
    nv_dss_per = 0  
    nv_cl_per  = 0 
    Nv_brchk   = "" . /*add Kridtiya i. A55-0016....*/

ASSIGN fi_show = "Connect Expiry......".
DISP fi_show WITH FRAM fr_main.
IF NOT CONNECTED("sic_exp") THEN DO:
    loop_sic:
    REPEAT:
        number_sic = number_sic + 1 .
        RUN proc_sic_exp2.
        IF  CONNECTED("sic_exp") THEN LEAVE loop_sic.
        ELSE IF number_sic > 3 THEN DO:
            MESSAGE "User not connect system Expiry !!! >>>" number_sic  VIEW-AS ALERT-BOX.
            LEAVE loop_sic.
        END.
    END.
END.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwkkex1
        ( /*INPUT-OUTPUT wdetail.prepol,   /*n_prepol  */ */
         INPUT-OUTPUT nv_brchk,
         INPUT-OUTPUT wdetail.producer, /*Producer  */
         INPUT-OUTPUT wdetail.agent,    /*Agent     */
         INPUT-OUTPUT n_firstdat,       /* First Date: */
         INPUT-OUTPUT wdetail.prempa,   /*n_prempa  */  
         INPUT-OUTPUT wdetail.subclass, /*n_subclass*/  
         INPUT-OUTPUT wdetail.redbook,  /*n_redbook */  
         INPUT-OUTPUT wdetail.brand,    /*n_brand   */  
         INPUT-OUTPUT wdetail.model,    /*n_model   */  
         INPUT-OUTPUT wdetail.caryear,  /*n_caryear */
         INPUT-OUTPUT wdetail.cargrp,   /*n_cargrp  */ 
         INPUT-OUTPUT wdetail.body, 
         INPUT-OUTPUT wdetail.cc,       
         INPUT-OUTPUT wdetail.weight,   
         INPUT-OUTPUT wdetail.seat,     /*n_seat    */     
         INPUT-OUTPUT wdetail.vehuse,   /*n_vehuse  */  
         INPUT-OUTPUT wdetail.covcod,   /*n_covcod  */  
         INPUT-OUTPUT wdetail.garage,   /*n_garage  */
         INPUT-OUTPUT wdetail.deductpp, /*n_tp1     */  
         INPUT-OUTPUT wdetail.deductba, /*n_tp2     */  
         INPUT-OUTPUT wdetail.deductpa, /*n_tp3     */   
         INPUT-OUTPUT nv_basere,        /*nv_basere */
         INPUT-OUTPUT wdetail.seat41,   /* INTE                */    
         INPUT-OUTPUT n_41,             /* INTE     n_41       */  
         INPUT-OUTPUT n_42,             /* DECI     n_42       */  
         INPUT-OUTPUT n_43,             /* DECI     n_43       */  
         INPUT-OUTPUT dod1,             /* DECI     n_dod      */ 
         INPUT-OUTPUT dod2,             /* DECI     n_dod2     */ 
         INPUT-OUTPUT dod0,             /* DECI     n_pd       */ 
        /* INPUT-OUTPUT wdetail.fleet,    /*n DECI    _feet      */  
         INPUT-OUTPUT WDETAIL.NCB,*/      /* DECI     n_ncb      */  
         INPUT-OUTPUT nv_dss_per,       /* DECI     nv_dss_per */  
         INPUT-OUTPUT nv_cl_per,
         INPUT        inte(wdetail.si),
         INPUT        wdetail.vehreg).       /* DECI     n_lcd      */ 
END. 
/*INPUT-OUTPUT wdetail.branch,   /*n_branch  */*//*add Kridtiya i. A55-0016....*/
/*add Kridtiya i. A55-0016....*/
IF wdetail.branch <> nv_brchk THEN 
    ASSIGN 
    wdetail.comment = wdetail.comment + "สาขาจากไฟล์แจ้งงาน ไม่ตรงกับ สาขากรมธรรม์เดิม" + wdetail.branch + "/" +  nv_brchk 
    wdetail.pass    = "Y" .
/*end....Add A55-0016..... */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base02 c-win 
PROCEDURE proc_base02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN WDETAIL.NCB = "0" 
    nv_ncbper = 0
    aa = 0
    nv_dss_per = 0.
IF (wdetail.covcod = "1") THEN DO:
    IF (wdetail.typecar = "use car") THEN 
        ASSIGN WDETAIL.NCB = "20" .
    IF wdetail.prempa = "G" THEN DO: 
        IF wdetail.subclass = "110" THEN aa = 8000.
        ELSE  aa = 13000.
    END.
    ELSE IF wdetail.prempa = "F" THEN DO: 
        IF wdetail.subclass = "110" THEN aa = 9100.
        ELSE  aa = 14500.
    END.
    ELSE IF (wdetail.prempa = "X") OR (wdetail.prempa = "V") OR (wdetail.prempa = "Z") THEN DO: 
        IF wdetail.subclass = "110" THEN aa = 7600.
        ELSE IF wdetail.subclass = "210" THEN aa = 12000.
        ELSE IF wdetail.subclass = "320" THEN aa = 13000.
        ELSE IF wdetail.subclass = "610" THEN ASSIGN aa = 2500  WDETAIL.NCB = "0".
    END.
END.
ELSE IF wdetail.covcod = "2" THEN DO:
    IF (wdetail.subclass = "110") OR (substr(wdetail.subclass,2,3) = "110") THEN DO: 
        IF (deci(wdetail.weight) <= 2000 ) THEN
            ASSIGN aa = 4100.
        ELSE ASSIGN aa = 3500.
    END.
    ELSE IF (wdetail.subclass = "210") OR (substr(wdetail.subclass,2,3) = "210") THEN
        ASSIGN aa = 6000
            WDETAIL.NCB = "20" .
    ELSE IF (wdetail.subclass = "320") OR (substr(wdetail.subclass,2,3) = "320") THEN
            ASSIGN aa = 6000.
END.
ELSE IF (wdetail.covcod = "3") AND (wdetail.prempa = "V") THEN DO:
    IF (wdetail.subclass = "110") OR (substr(wdetail.subclass,2,3) = "110") THEN DO: 
        IF (deci(wdetail.weight) <= 2000 ) THEN
            ASSIGN  aa  = 2635
            nv_dss_per  = 0
            WDETAIL.NCB = "20" .
        ELSE ASSIGN aa = 2646
            nv_dss_per = 0
            WDETAIL.NCB = "30" .
    END.
    ELSE IF (wdetail.subclass = "210") OR (substr(wdetail.subclass,2,3) = "210") THEN
        ASSIGN aa = 3544
        nv_dss_per = 0
        WDETAIL.NCB = "30" .
    ELSE IF (wdetail.subclass = "320") OR (substr(wdetail.subclass,2,3) = "320") THEN
        ASSIGN aa = 4045
        nv_dss_per = 0
        WDETAIL.NCB = "" .
END.
ELSE IF (wdetail.covcod = "3") AND (wdetail.prempa = "R") THEN DO:
        IF (wdetail.subclass = "110") OR (substr(wdetail.subclass,2,3) = "110") THEN DO: 
            IF (deci(wdetail.weight) <= 2000 ) THEN
                ASSIGN  aa  = 2458
                nv_dss_per  = 0
                WDETAIL.NCB = "30" .
            ELSE ASSIGN aa = 2524
                nv_dss_per = 0
                WDETAIL.NCB = "40" .
        END.
        ELSE IF (wdetail.subclass = "210") OR (substr(wdetail.subclass,2,3) = "210") THEN
            ASSIGN aa = 3401
            nv_dss_per = 0
            WDETAIL.NCB = "30" .
        ELSE IF (wdetail.subclass = "320") OR (substr(wdetail.subclass,2,3) = "320") THEN
            ASSIGN aa = 4135
            nv_dss_per = 0
            WDETAIL.NCB = "30" .
    END.
    ELSE IF (wdetail.covcod = "3") AND (wdetail.prempa = "Z") THEN DO:
        IF (wdetail.subclass = "110") OR (substr(wdetail.subclass,2,3) = "110") THEN DO: 
            IF (deci(wdetail.weight) <= 2000 ) THEN
                ASSIGN  aa  = 2691
                nv_dss_per  = 0
                WDETAIL.NCB = "20" .
            ELSE ASSIGN aa = 2341
                nv_dss_per = 0
                WDETAIL.NCB = "20" .
        END.
        ELSE IF (wdetail.subclass = "210") OR (substr(wdetail.subclass,2,3) = "210") THEN
            ASSIGN aa = 3245
            nv_dss_per = 0
            WDETAIL.NCB = "20" .
        ELSE IF (wdetail.subclass = "320") OR (substr(wdetail.subclass,2,3) = "320") THEN
            ASSIGN aa = 3750
            nv_dss_per = 0
            WDETAIL.NCB = "20" .
    END.
IF wdetail.covcod = "5" THEN DO:
        IF (wdetail.subclass = "110") OR (substr(wdetail.subclass,2,3) = "110") THEN DO: 
            IF (deci(wdetail.weight) <= 2000 ) THEN
                ASSIGN aa = 4600
                nv_dss_per = 17.54 .
            ELSE ASSIGN aa = 4000
                nv_dss_per = 17 .
        END.
        ELSE IF (wdetail.subclass = "210") OR (substr(wdetail.subclass,2,3) = "210") THEN
            ASSIGN aa = 6000
            nv_dss_per = 10.06 
            WDETAIL.NCB = "20" .
        ELSE IF (wdetail.subclass = "320") OR (substr(wdetail.subclass,2,3) = "320") THEN
            ASSIGN aa = 6000
            nv_dss_per = 12.79
            WDETAIL.NCB = "" .
END.
ASSIGN nv_ncbper =  deci(WDETAIL.NCB) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2 c-win 
PROCEDURE proc_base2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "v70" THEN DO:
    RUN proc_base02.
    IF aa = 0 THEN DO:
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ASSIGN
        /*wdetail.drivnam  = "N"     /*ไม่มีผู้ขับขี่*/*/
        chk = NO
        NO_basemsg = " "
        nv_baseprm = aa
        nv_drivvar1 = ""    nv_drivvar   = ""  .
    IF wdetail.drivname1 = "" THEN DO: 
         ASSIGN  
            nv_drivno = 0 
            nv_drivvar1  = ""
            nv_drivvar   = " "
            nv_drivcod   = "A000"
            nv_drivvar1  =  "     Unname Driver"
            nv_drivvar2  = "0"
            Substr(nv_drivvar,1,30)   = nv_drivvar1
            Substr(nv_drivvar,31,30)  = nv_drivvar2.
    END.
    ELSE DO:
        IF SUBSTR(wdetail.drivname1,1,INDEX(wdetail.drivname1,"sex") - 1 )  <> "" THEN DO: 
            ASSIGN nv_drivno = 1.  
            IF SUBSTR(wdetail.drivname2,1,INDEX(wdetail.drivname2,"sex") - 1 )  <> ""  THEN nv_drivno = 2.
            IF  nv_drivno  > 2  Then do:
                Message " Driver'S NO. must not over 2. "  View-as alert-box.
                ASSIGN
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
                END.
                RUN proc_usdcod.
                Assign
                    nv_drivvar     = nv_drivcod
                    nv_drivvar1    = "     Driver name person = "
                    nv_drivvar2    = String(nv_drivno)
                    Substr(nv_drivvar,1,30)  = nv_drivvar1
                    Substr(nv_drivvar,31,30) = nv_drivvar2.
                END.
    END.
    
    IF NO_basemsg <> " " THEN 
        wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    Assign  nv_basevar = ""
        nv_prem1   = nv_baseprm
        nv_basecod = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    IF      wdetail.subclass = "110"  THEN wdetail.seat = "7".
    ELSE IF wdetail.subclass = "210"  THEN wdetail.seat = "12".
    ELSE IF wdetail.subclass = "320"  THEN wdetail.seat = "3".
    ASSIGN 
        nv_41     = deci(wdetail.no_41)  
        nv_42     = deci(wdetail.no_42)  
        nv_43     = deci(wdetail.no_43)  
        nv_seat41 = wdetail.seat41  .       /*integer(wdetail.seat)*/ 
    /* comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                    nv_class,
                    nv_key_b,
                    nv_comdat). */
    Assign  nv_411var = " "   nv_412var = " "                                                    
        nv_41cod1   = "411"
        nv_411var1  = "     PA Driver = "
        nv_411var2  =  STRING(nv_41)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(nv_41)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_41
        nv_412prm  = nv_41.
    nv_42var    = " ".     /* -------fi_42---------*/
    Assign
        nv_42cod   = "42".
        nv_42var1  = "     Medical Expense = ".
        nv_42var2  = STRING(nv_42).
        SUBSTRING(nv_42var,1,30)   = nv_42var1.
        SUBSTRING(nv_42var,31,30)  = nv_42var2.
    nv_43var    = " ".     /*---------fi_43--------*/
    Assign
        nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    /* comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat). */     /*  RUN US\USOPER(INPUT nv_tariff,*/
    /*------nv_usecod------------*/
    ASSIGN nv_usevar = " "
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30) = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  wdetail.subclass.       
    RUN wgs\wgsoeng.   
    /*-----nv_yrcod----------------------------*/  
    ASSIGN nv_yrvar = " "
        nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
        nv_yrvar1  = "     Vehicle Year = "
        nv_yrvar2  =  wdetail.caryear
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
            Substr(nv_yrvar,1,30)    = nv_yrvar1
            Substr(nv_yrvar,31,30)   = nv_yrvar2.  
     /*-----nv_sicod----------------------------*/  
    Assign  nv_sivar = " "
         nv_totsi     = 0
         nv_sicod     = "SI"
         nv_sivar1    = "     Own Damage = "
         nv_sivar2    =  wdetail.si
         SUBSTRING(nv_sivar,1,30)  = nv_sivar1
         SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
         nv_totsi     =  DECI(wdetail.si).
     /*----------nv_grpcod--------------------*/
     ASSIGN nv_grpvar = " "
         nv_grpcod      = "GRP" + wdetail.cargrp
         nv_grpvar1     = "     Vehicle Group = "
         nv_grpvar2     = wdetail.cargrp
         Substr(nv_grpvar,1,30)  = nv_grpvar1
         Substr(nv_grpvar,31,30) = nv_grpvar2.
    /*-------------nv_bipcod--------------------*/
     ASSIGN nv_bipvar = " "
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(wdetail.deductpp)
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign nv_biavar = ""
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(wdetail.deductba)
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN nv_pdavar = ""
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         /*nv_pdavar2     = STRING(uwm130.uom5_v)   a52-0172*/
         nv_pdavar2     = string(deci(WDETAIL.deductpa))        /*A52-0172*/
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
     /*DEF VAR dod0 AS INTEGER.
     DEF VAR dod1 AS INTEGER INIT 0 .
     DEF VAR dod2 AS INTEGER.
     DEF VAR dpd0 AS INTEGER.*/
     IF dod0 > 3000 THEN DO:
         FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
             xmm106.tariff = "X"     AND
             xmm106.bencod = "DC01"  AND
             xmm106.class  = wdetail.prempa + wdetail.subclass  AND
             xmm106.effdat LE DATE(wdetail.comdat)             NO-LOCK NO-ERROR NO-WAIT. 
         IF AVAIL xmm106 THEN  
             ASSIGN dod1 = xmm106.baseap 
             dod2 = dod0 - dod1.
         ELSE DO: 
             MESSAGE  " DEDUCTIBLE EXCEED IS NOT SET PARAMETER !!! BY " wdetail.prempa + wdetail.subclass   View-as alert-box.
             ASSIGN dod0 = 0
                 dod1 = 0 
                 dod2 = 0 .
         END.
     END.
     IF dod1 <> 0 THEN DO:
        ASSIGN nv_dedod1var = " "
            nv_odcod    = "DC01"
            nv_prem     =  dod1
            nv_sivar2   = "" . 
        /* comment by : A64-0138...
        RUN Wgs\Wgsmx024( nv_tariff,              
                          nv_odcod,
                          nv_class,
                          nv_key_b,
                          nv_comdat,
                          INPUT-OUTPUT nv_prem,
                          OUTPUT nv_chk ,
                          OUTPUT nv_baseap).*/
        ASSIGN
            nv_ded1prm        = nv_prem
            nv_dedod1_prm     = nv_prem
            nv_dedod1_cod     = "DOD"
            nv_dedod1var1     = "     Deduct OD = "
            nv_dedod1var2     = STRING(dod1)
            SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
            SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
        /*add od*/
        Assign  
            nv_dedod2var   = " "
            nv_cons  = "AD"
            nv_ded   = dod2.
        /* comment by : A64-0138...
        Run  Wgs\Wgsmx025(INPUT  nv_ded,  
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem). */     
        Assign
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   =  STRING(dod2)
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2 .
            /*nv_dedod2_prm   = nv_prem.*/
     END.
     /***** pd *******/
     IF dpd0 <> 0 THEN DO:
        Assign
            nv_dedpdvar  = " "
            nv_cons  = "PD"
            nv_ded   = dpd0.
         /* comment by : A64-0138...
        Run  Wgs\Wgsmx025(INPUT  nv_ded, 
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).
        nv_ded2prm    = nv_prem.
       ...end : A64-0138...*/
        ASSIGN nv_dedpdvar = ""
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(nv_ded)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
            /*nv_dedpd_prm  = nv_prem.*/ /*A64-0138*/
     END.
     /*---------- fleet -------------------*/
     /*nv_flet_per = INTE(wdetail.fleet).*/
     nv_flet_per = 0.
     IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
         Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
         ASSIGN wdetail.pass    = "N"
             wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
     END.
     IF nv_flet_per = 0 Then do:
         ASSIGN nv_flet     = 0
             nv_fletvar  = " ".
     End.
      /* comment by : A64-0138...
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                wdetail.deductpp,
                                wdetail.deductba,
                                wdetail.deductpa).
      ...end : A64-0138...*/
     ELSE 
     ASSIGN
         nv_fletvar     = " "
         nv_fletvar1    = "     Fleet % = "
         nv_fletvar2    =  STRING(nv_flet_per)
         SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
         SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     /*IF wdetail.covcod = "1" THEN WDETAIL.NCB = "0".
     ELSE RUN proc_dsp_ncb.*/
     /*IF (wdetail.covcod = "1") AND (substr(wdetail.subclass,1,1) <> "6" ) THEN WDETAIL.NCB = "20".*/
     ASSIGN  NV_NCBPER = INTE(WDETAIL.NCB).
     nv_ncbvar = " ".
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401 Where
             sicsyac.xmm104.tariff = nv_tariff          AND
             sicsyac.xmm104.class  = nv_class           AND 
             sicsyac.xmm104.covcod = nv_covcod          AND 
             sicsyac.xmm104.ncbper   = INTE(wdetail.ncb)
             No-lock no-error no-wait.
         IF not avail  sicsyac.xmm104  Then do:
             Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
             ASSIGN
                 wdetail.pass    = "N"
                 wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
         End.
         ASSIGN
             nv_ncbper = xmm104.ncbper   
             nv_ncbyrs = xmm104.ncbyrs.
     End.
     Else do:  
         Assign
             nv_ncbyrs  =   0
             nv_ncbper  =   0
             nv_ncb     =   0.
     End. 
      /* comment by : A64-0138...
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                wdetail.deductpp,
                                wdetail.deductba,
                                wdetail.deductpa).
     ... end : A64-0138...*/
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     
     /*------------------ dsspc ---------------*/
     
     /*IF nv_gapprm <> f THEN  DO:
         per = TRUNCATE((nv_gapprm - f ),1).
         per = TRUNCATE((per * 100 ),1).
         per = ROUND((per / nv_gapprm ),2).  
         Assign                
             nv_dss_per = per .  */

         /*assign
             nv_dsspcvar   = " ".
         IF  (wdetail.covcod = "2") AND (nv_dss_per = 0 )  THEN RUN proc_dsp_ncb.  
         IF  nv_dss_per   <> 0  THEN
             Assign
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
         END.
         /*--------------------------*/
         RUN WGS\WGSORPRM.P (INPUT  nv_tariff,  
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         wdetail.deductpp,       
                         wdetail.deductba,       
                         wdetail.deductpa).*/
         /*ASSIGN 
             nv_cl_per = 99
             nv_clmvar  = " ".
            IF nv_cl_per  <> 0  THEN
               Assign 
                      nv_clmvar1   = " Load Claim % = "
                      nv_clmvar2   =  STRING(nv_cl_per)
                      SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
                      SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
             RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                       nv_class,
                                       nv_covcod,
                                       nv_key_b,
                                       nv_comdat,
                                       nv_totsi,
                                       uwm130.uom1_v,
                                       uwm130.uom2_v,
                                       uwm130.uom5_v).
          nv_clmvar    = " ".
            IF nv_cl_per  <> 0  THEN
               Assign 
                      nv_clmvar1   = " Load Claim % = "
                      nv_clmvar2   =  STRING(nv_cl_per)
                      SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
                      SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.*/
         nv_dsspcvar = " " .
         IF (nv_dss_per = 0 ) AND (nv_gapprm > n_prem) AND (n_prem > 0 ) THEN DO:
             nv_dss_per = TRUNCATE(((nv_gapprm  - n_prem ) * 100 ) / nv_gapprm ,3 ) . 
             IF  nv_dss_per   <> 0  THEN
                 Assign
                 nv_dsspcvar1   = "     Discount Special % = "
                 nv_dsspcvar2   =  STRING(nv_dss_per)
                 SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
                 SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
             /*--------------------------*/
              /* comment by : A64-0138...
             RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                 nv_class,
                                 nv_covcod,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_totsi,
                                 nv_uom1_v ,       
                                 nv_uom2_v ,       
                                 nv_uom5_v ). 
             ...end : A64-0138...*/
         END.
             /*IF nv_gapprm <> DECI(wdetail.volprem )  THEN  DO:
             IF (nv_gapprm - DECI(wdetail.volprem )) < 3 THEN DO:
             ASSIGN
             nv_dss_per = nv_dss_per + 0.01.    
             /*--------------------------*/
             RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
             nv_class,
                                     nv_covcod,
                                     nv_key_b,
                                     nv_comdat,
                                     nv_totsi,
                                     nv_uom1_v ,       
                                     nv_uom2_v ,       
                                     nv_uom5_v ). 
                 IF nv_gapprm = DECI(wdetail.volprem ) THEN n_i = 10.
             END.
             nv_baseprm = nv_baseprm + 1.
             n_i = n_i + 1.
         END.
         ELSE  n_i = 10.*/
         END.
               

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base23 c-win 
PROCEDURE proc_base23 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR chk     AS LOGICAL.
DEF VAR model   AS CHAR .
DEF VAR aa      AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "v70" THEN DO:
    IF (wdetail.subclass = "110") OR (wdetail.subclass = "z110") THEN aa = 3000.
    ELSE IF (wdetail.subclass = "210") OR (wdetail.subclass = "z210") OR
        (wdetail.subclass = "320") OR (wdetail.subclass = "z320") THEN aa = 6000.
    ELSE DO: 
            RUN wgs\wgsfbas.
            ASSIGN aa = nv_baseprm.
    END.
ASSIGN
    chk = NO
    NO_basemsg = " "
    nv_baseprm = aa
    nv_dss_per = 0 
    nv_drivvar1 = "".
    IF nv_drivvar1 <> ""  THEN  nv_drivno = 1.  
    ELSE IF nv_drivvar1 = ""  THEN  nv_drivno = 0.   
    IF nv_drivvar1 = ""  Then 
        Assign nv_drivvar   = " "
            nv_drivcod   = "A000"
            nv_drivvar1  =  "     Unname Driver"
            nv_drivvar2  = "0"
            Substr(nv_drivvar,1,30)   = nv_drivvar1
            Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        End.
        RUN proc_usdcod.
        Assign
            nv_drivvar     = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
        /*RUN proc_usdcod. */
    END.
    /*-------nv_baseprm----------*/
    IF NO_basemsg <> " " THEN 
        wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN
        wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    Assign
            nv_prem1   = nv_baseprm
            nv_basecod = "BASE"
            nv_basevar1 = "     Base Premium = "
            nv_basevar2 = STRING(nv_baseprm)
            SUBSTRING(nv_basevar,1,30)   = nv_basevar1
            SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    /*IF wdetail.prepol <> "" THEN  ASSIGN  wdetail.no_41  = STRING(n_41)
                                          wdetail.no_42  = STRING(n_42)
                                          wdetail.no_43  = STRING(n_43).  */
    ASSIGN
            nv_41 =  50000      /*DECI(wdetail.no_41)*/
            nv_42 =  50000      /*DECI(wdetail.no_42)*/
            nv_43 =  100000      /* DECI(wdetail.no_43)*/
            nv_seat41 = integer(wdetail.seat).   /*integer(wdetail.seat41).*/ 
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                    nv_class,
                    nv_key_b,
                    nv_comdat). 
    Assign                                                     
        nv_41cod1   = "411"
        nv_411var1  = "     PA Driver = "
        nv_411var2  =  STRING(nv_41)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(nv_41)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_41
        nv_412prm  = nv_41.
    nv_42var    = " ".     /* -------fi_42---------*/
    Assign
        nv_42cod   = "42".
    nv_42var1  = "     Medical Expense = ".
    nv_42var2  = STRING(nv_42).
    SUBSTRING(nv_42var,1,30)   = nv_42var1.
    SUBSTRING(nv_42var,31,30)  = nv_42var2.
    nv_43var    = " ".     /*---------fi_43--------*/
    Assign
        nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/
    /*------nv_usecod------------*/
    Assign
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30) = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  wdetail.subclass.       
    RUN wgs\wgsoeng.   
    /*-----nv_yrcod----------------------------*/  
    Assign
        nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
        nv_yrvar1  = "     Vehicle Year = "
        nv_yrvar2  =  wdetail.caryear
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) 
            Else "YR99"
            Substr(nv_yrvar,1,30)    = nv_yrvar1
            Substr(nv_yrvar,31,30)   = nv_yrvar2.  
     /*-----nv_sicod----------------------------*/  
     Assign  nv_totsi     = 0
             nv_sicod     = "SI"
             nv_sivar1    = "     Own Damage = "
             nv_sivar2    =  wdetail.si
             SUBSTRING(nv_sivar,1,30)  = nv_sivar1
             SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
             nv_totsi     =  DECI(wdetail.si).
         /*----------nv_grpcod--------------------*/
         Assign
             nv_grpcod      = "GRP" + wdetail.cargrp
             nv_grpvar1     = "     Vehicle Group = "
             nv_grpvar2     = wdetail.cargrp
             Substr(nv_grpvar,1,30)  = nv_grpvar1
             Substr(nv_grpvar,31,30) = nv_grpvar2.
     /*-------------nv_bipcod--------------------*/
     ASSIGN
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(uwm130.uom1_v)
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign 
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(uwm130.uom2_v)
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN 
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         /*nv_pdavar2     = STRING(uwm130.uom5_v)   a52-0172*/
         nv_pdavar2     = string(deci(WDETAIL.deductpa))        /*A52-0172*/
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
     /* caculate deduct OD  */
     DEF VAR dod0 AS INTEGER.
     DEF VAR dod1 AS INTEGER.
     DEF VAR dod2 AS INTEGER.
     DEF VAR dpd0 AS INTEGER.
     /*def  var  nv_chk  as  logic.*/
      /*dod0 = inte(wdetail.deductda).  a52-0172*/
     IF dod0 > 3000 THEN DO:
         dod1 = 3000.
         dod2 = dod0 - dod1.
     END.
     ASSIGN
         nv_odcod    = "DC01"
         nv_prem     =   dod1
         nv_sivar2   = "" .  
     RUN Wgs\Wgsmx024( nv_tariff,              
                       nv_odcod,
                       nv_class,
                       nv_key_b,
                       nv_comdat,
                       INPUT-OUTPUT nv_prem,
                       OUTPUT nv_chk ,
                       OUTPUT nv_baseap).
     IF NOT nv_chk THEN DO:
         MESSAGE  " DEDUCTIBLE EXCEED THE LIMIT " nv_baseap  View-as alert-box.
         ASSIGN
             wdetail.pass    = "N"
             wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
     END.
     ASSIGN
         nv_ded1prm        = nv_prem
         nv_dedod1_prm     = nv_prem
         nv_dedod1_cod     = "DOD"
         nv_dedod1var1     = "     Deduct OD = "
         nv_dedod1var2     = STRING(dod1)
         SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
         SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
     /*add od*/
     Assign  
         nv_dedod2var   = " "
         nv_cons  = "AD"
         nv_ded   = dod2.
     Run  Wgs\Wgsmx025(INPUT  nv_ded,  
                              nv_tariff,
                              nv_class,
                              nv_key_b,
                              nv_comdat,
                              nv_cons,
                       OUTPUT nv_prem).      
     Assign
         nv_aded1prm     = nv_prem
         nv_dedod2_cod   = "DOD2"
         nv_dedod2var1   = "     Add Ded.OD = "
         nv_dedod2var2   =  STRING(dod2)
         SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
         SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
         nv_dedod2_prm   = nv_prem.
     /***** pd *******/
     Assign
         nv_dedpdvar  = " "
         nv_cons  = "PD"
         nv_ded   = dpd0.
     Run  Wgs\Wgsmx025(INPUT  nv_ded, 
                              nv_tariff,
                              nv_class,
                              nv_key_b,
                              nv_comdat,
                              nv_cons,
                       OUTPUT nv_prem).
     nv_ded2prm    = nv_prem.
     ASSIGN
         nv_dedpd_cod   = "DPD"
         nv_dedpdvar1   = "     Deduct PD = "
         nv_dedpdvar2   =  STRING(nv_ded)
         SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
         SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
         nv_dedpd_prm  = nv_prem.
     /*---------- fleet -------------------*/
     /*nv_flet_per = INTE(wdetail.fleet).*/
     nv_flet_per = 0.
     IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
         Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
         ASSIGN
             wdetail.pass    = "N"
             wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
     End.  
     IF nv_flet_per = 0 Then do:
         Assign
             nv_flet     = 0
             nv_fletvar  = " ".
     End.
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).
     ASSIGN
         nv_fletvar     = " "
         nv_fletvar1    = "     Fleet % = "
         nv_fletvar2    =  STRING(nv_flet_per)
         SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
         SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN
         nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     RUN proc_dsp_ncb.
     NV_NCBPER = INTE(WDETAIL.NCB).
     nv_ncbvar = " ".
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401 Where
             sicsyac.xmm104.tariff = nv_tariff          AND
             sicsyac.xmm104.class  = nv_class           AND 
             sicsyac.xmm104.covcod = nv_covcod          AND 
             sicsyac.xmm104.ncbper   = INTE(wdetail.ncb)
             No-lock no-error no-wait.
         IF not avail  sicsyac.xmm104  Then do:
             Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
             ASSIGN
                 wdetail.pass    = "N"
                 wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
         End.
         ASSIGN
             nv_ncbper = xmm104.ncbper   
             nv_ncbyrs = xmm104.ncbyrs.
     End.
     Else do:  
         Assign
             nv_ncbyrs  =   0
             nv_ncbper  =   0
             nv_ncb     =   0.
     End. 
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     
     /*------------------ dsspc ---------------*/
     
     /*IF nv_gapprm <> f THEN  DO:
         per = TRUNCATE((nv_gapprm - f ),1).
         per = TRUNCATE((per * 100 ),1).
         per = ROUND((per / nv_gapprm ),2).  
         Assign                
             nv_dss_per = per .  */
         nv_dsspcvar   = " ".
            
         IF  nv_dss_per   <> 0  THEN
             Assign
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
         END.
         /*--------------------------*/
         RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v ,       
                         nv_uom2_v ,       
                         nv_uom5_v ). 

         /*IF nv_gapprm <> DECI(wdetail.volprem )  THEN  DO:
             IF (nv_gapprm - DECI(wdetail.volprem )) < 3 THEN DO:
                 ASSIGN
                     nv_dss_per = nv_dss_per + 0.01.    
                 /*--------------------------*/
                 RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                     nv_class,
                                     nv_covcod,
                                     nv_key_b,
                                     nv_comdat,
                                     nv_totsi,
                                     nv_uom1_v ,       
                                     nv_uom2_v ,       
                                     nv_uom5_v ). 
                 IF nv_gapprm = DECI(wdetail.volprem ) THEN i = 10.
             END.
             nv_baseprm = nv_baseprm + 1.
             i = i + 1.
             END. 
             ELSE  i = 10.
 END.*/
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2plus c-win 
PROCEDURE proc_base2plus :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF wdetail.poltyp = "v70" THEN DO:
    ASSIGN fi_show = "Create data to base..." + wdetail.policy 
           nv_baseprm    = 0.
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR
       (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN DO: 
            RUN wgs\wgsfbas.
    END.
    DISP fi_show WITH FRAM fr_main.
    IF nv_baseprm = 0  THEN DO: 
        RUN wgs\wgsfbas.
    END.
    ASSIGN chk = NO
        NO_basemsg = " " 
        nv_drivvar1 = ""   .
    IF wdetail.drivname1 = "" THEN DO: 
         ASSIGN 
            nv_drivno = 0 
            nv_drivvar1  = ""
            nv_drivvar   = " "
            nv_drivcod   = "A000"
            nv_drivvar1  =  "     Unname Driver"
            nv_drivvar2  = "0"
            Substr(nv_drivvar,1,30)   = nv_drivvar1
            Substr(nv_drivvar,31,30)  = nv_drivvar2.
    END.
    ELSE DO:
        IF SUBSTR(wdetail.drivname1,1,INDEX(wdetail.drivname1,"sex") - 1 )  <> "" THEN DO: 
            ASSIGN nv_drivno = 1.  
            IF SUBSTR(wdetail.drivname2,1,INDEX(wdetail.drivname2,"sex") - 1 )  <> ""  THEN nv_drivno = 2.
            IF  nv_drivno  > 2  Then do:
                Message " Driver'S NO. must not over 2. "  View-as alert-box.
                ASSIGN
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
                END.
                RUN proc_usdcod.
                ASSIGN nv_drivvar  = ""
                    nv_drivvar     = nv_drivcod
                    nv_drivvar1    = "     Driver name person = "
                    nv_drivvar2    = String(nv_drivno)
                    Substr(nv_drivvar,1,30)  = nv_drivvar1
                    Substr(nv_drivvar,31,30) = nv_drivvar2.
                END.
    END.
    /*-------nv_baseprm----------*/
    nv_basevar = "" .
   IF NO_basemsg <> " " THEN  wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail.pass = "N"
        wdetail.comment      = wdetail.comment + "| Base Premium is Mandatory field. ".  
        ASSIGN  nv_prem1 = nv_baseprm
        nv_basecod  = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    
     /*-------nv_add perils----------*/
   ASSIGN 
        nv_41 =deci(wdetail.no_41) 
        nv_42 =deci(wdetail.no_42) 
        nv_43 =deci(wdetail.no_43) 
        nv_seat41 = wdetail.seat41  .
    IF wdetail.model = "commuter" THEN 
        ASSIGN wdetail.seat = "16"
        nv_seats  =  16
        nv_seat41 =  16.
     /* comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                          nv_class,
                          nv_key_b,
                          nv_comdat).*/
    Assign nv_411var = ""   nv_412var = ""   
        nv_41cod1   = "411"
        nv_411var1  = "     PA Driver = "
        nv_411var2  =  STRING(nv_41)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(nv_41)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_41
        nv_412prm  = nv_41.
    nv_42var    = " ".     /* -------fi_42---------*/
    ASSIGN nv_42var = "" 
        nv_42cod   = "42".
        nv_42var1  = "     Medical Expense = ".
        nv_42var2  = STRING(nv_42).
        SUBSTRING(nv_42var,1,30)   = nv_42var1.
        SUBSTRING(nv_42var,31,30)  = nv_42var2.
    nv_43var    = " ".     /*---------fi_43--------*/
    ASSIGN nv_43var = ""
        nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
     /* comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat).*/      /*  RUN US\USOPER(INPUT nv_tariff,*/     
    /*------nv_usecod------------*/
    ASSIGN nv_usevar = ""
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30)  = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  wdetail.subclass. 
    RUN wgs\wgsoeng.   
    /*-----nv_yrcod----------------------------*/  
    ASSIGN nv_yrvar = ""
        nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
        nv_yrvar1  = "     Vehicle Year = "
        nv_yrvar2  =  wdetail.caryear
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) ELSE "YR99"
        Substr(nv_yrvar,1,30)    = nv_yrvar1
        Substr(nv_yrvar,31,30)   = nv_yrvar2.  
    /*-----nv_sicod----------------------------*/  
    Assign  nv_sivar = ""   nv_totsi = 0
        nv_sicod     = "SI"
        nv_sivar1    = "     Own Damage = "
        nv_sivar2    =  wdetail.si
        SUBSTRING(nv_sivar,1,30)  = nv_sivar1
        SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
        nv_totsi     =  DECI(wdetail.si).
    /*----------nv_grpcod--------------------*/
    Assign  nv_grpvar = ""
        nv_grpcod      = "GRP" + wdetail.cargrp
        nv_grpvar1     = "     Vehicle Group = "
        nv_grpvar2     = wdetail.cargrp
        Substr(nv_grpvar,1,30)  = nv_grpvar1
        Substr(nv_grpvar,31,30) = nv_grpvar2.
    /*-------------nv_bipcod--------------------*/
     ASSIGN nv_bipvar = ""
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(wdetail.deductpp)
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     ASSIGN nv_biavar = "" 
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(wdetail.deductba)
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    
    IF      (wdetail.covcod = "2.1")   THEN assign nv_usecod3 = "U" + TRIM(nv_vehuse) + "21" .
    ELSE IF (wdetail.covcod = "2.2")   THEN assign nv_usecod3 = "U" + TRIM(nv_vehuse) + "22" .
    ELSE IF (wdetail.covcod = "3.1")   THEN assign nv_usecod3 = "U" + TRIM(nv_vehuse) + "31" .
    ELSE ASSIGN nv_usecod3 = "U" + TRIM(nv_vehuse) + "32" .
    ASSIGN   nv_usevar3 = "" 
        nv_usevar4 = "     Vehicle Use = "
        nv_usevar5 =  wdetail.vehuse
        Substring(nv_usevar3,1,30)   = nv_usevar4
        Substring(nv_usevar3,31,30)  = nv_usevar5.

     ASSIGN  nv_basecod3 = IF      (wdetail.covcod = "2.1") THEN "BA21"
                           ELSE IF (wdetail.covcod = "2.2") THEN "BA22" 
                           ELSE IF (wdetail.covcod = "3.1") THEN "BA31"ELSE "BA32".
     FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
         sicsyac.xmm106.tariff = nv_tariff   AND
         sicsyac.xmm106.bencod = nv_basecod3 AND
         sicsyac.xmm106.covcod = nv_covcod   AND
         sicsyac.xmm106.class  = nv_class    AND
         sicsyac.xmm106.key_b  GE nv_key_b   AND
         sicsyac.xmm106.effdat LE nv_comdat  NO-LOCK NO-ERROR NO-WAIT.
     IF AVAIL xmm106 THEN  nv_baseprm3 = xmm106.min_ap.
     ELSE  nv_baseprm3 = 0.
     ASSIGN nv_basevar3 = ""
         nv_basevar4 = "     Base Premium3 = "
         nv_basevar5 = STRING(nv_baseprm3)
         SUBSTRING(nv_basevar3,1,30)   = nv_basevar4
         SUBSTRING(nv_basevar3,31,30)  = nv_basevar5.  
     ASSIGN nv_sivar3 = ""
        nv_sicod3    = IF      (wdetail.covcod = "2.1") THEN "SI21" 
                       ELSE IF (wdetail.covcod = "2.2") THEN "SI22" 
                       ELSE IF (wdetail.covcod = "3.1") THEN "SI31"  ELSE "SI32"     
        nv_sivar4    = "     Own Damage = "                                        
        nv_sivar5    =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  string(deci(wdetail.si)) ELSE string(deci(wdetail.si)) 
        wdetail.si   =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  wdetail.si ELSE  wdetail.si
        SUBSTRING(nv_sivar3,1,30)  = nv_sivar4
        SUBSTRING(nv_sivar3,31,30) = nv_sivar5 .
        nv_totsi     = IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  deci(wdetail.si) ELSE  deci(wdetail.si).
        /*nv_siprm3    = IF wdetail.covcod = "2.1" THEN  deci(wdetail.fi) ELSE DECI(wdetail.si)  .*/ 
    /**/
    /*-------------nv_pdacod--------------------*/
    Assign  nv_pdavar = ""
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     =  STRING(WDETAIL.deductpa)         /*STRING(uwm130.uom5_v)*/
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    /*comment by : A64-0138...
    RUN WGS\WGSORPR1.P (INPUT   nv_tariff,  
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                deci(wdetail.si),
                                deci(wdetail.deductpp),
                                deci(wdetail.deductba),
                                deci(WDETAIL.deductpa)).   /*kridtiya i.*/
    ...end A64-0138...*/
    /*--------------- deduct ----------------*/
    DEF VAR dod0 AS INTEGER.                                        
    DEF VAR dod1 AS INTEGER.                                        
    DEF VAR dod2 AS INTEGER.                                        
    DEF VAR dpd0 AS INTEGER.
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1")  THEN ASSIGN dod1 = 2000 .   /*A57-0126*/
    ELSE DO:
        IF dod0 > 3000 THEN DO:
            dod1 = 3000.
            dod2 = dod0 - dod1.
        END.
    END.
    IF dod1 <> 0 THEN DO:
        ASSIGN nv_odcod = "DC01"
            nv_prem     =  dod1 .        
        RUN Wgs\Wgsmx024( nv_tariff,                    /*a490166 note modi*/
                          nv_odcod,
                          nv_class,
                          nv_key_b,
                          nv_comdat,
                          INPUT-OUTPUT nv_prem,
                          OUTPUT nv_chk ,
                          OUTPUT nv_baseap).
        IF NOT nv_chk THEN DO:
            MESSAGE  " DEDUCTIBLE EXCEED THE LIMIT " nv_baseap  View-as alert-box.
            ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
            /*NEXT.*/
        END.
        ASSIGN nv_dedod1var   = ""
            nv_ded1prm        = nv_prem
            nv_dedod1_prm     = nv_prem
            nv_dedod1_cod     = "DOD"
            nv_dedod1var1     = "     Deduct OD = "
            nv_dedod1var2     = STRING(dod1)
            SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
            SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
        /*add od*/
        Assign  
            nv_dedod2var   = " "
            nv_cons  = "AD"
            nv_ded   = dod2.
        /*comment by : A64-0138...
        Run  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).*/  
        Assign
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   =  STRING(dod2)
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2 .
            /*nv_dedod2_prm   = nv_prem.*/ 
    END.
    /***** pd *******/
    IF dod0 <> 0 THEN DO:
        Assign
            nv_dedpdvar  = " "
            nv_cons  = "PD"
            nv_ded   = dod0   /*a64-0138*/
            /*nv_ded   = dpd0*/ /*a64-0138*/
            /*dod0 = 0*/    .
        /*comment by : A64-0138...
        Run  Wgs\Wgsmx025(INPUT  dod0,  
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).
        nv_ded2prm    = nv_prem.*/
        ASSIGN 
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(dod0)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2.
            /*nv_dedpd_prm  = nv_prem.*/ /*A64-0138*/
    END.
    /*---------- fleet -------------------*/
     nv_flet_per = 0.
     IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
         Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
         ASSIGN wdetail.pass    = "N"
             wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
     END.
     IF nv_flet_per = 0 Then do:
         ASSIGN nv_flet     = 0
             nv_fletvar  = " ".
     End.
     /*comment by : A64-0138...
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                wdetail.deductpp,
                                wdetail.deductba,
                                wdetail.deductpa).*/
     ELSE 
     ASSIGN
         nv_fletvar     = " "
         nv_fletvar1    = "     Fleet % = "
         nv_fletvar2    =  STRING(nv_flet_per)
         SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
         SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN nv_fletvar  = " ".
    /*---------------- NCB -------------------*/
    /*IF wdetail.covcod = "3" THEN WDETAIL.NCB = "30".*/
    ASSIGN 
        NV_NCBPER  = DECI(wdetail.ncb)
        nv_ncb     = DECI(wdetail.ncb)
        nv_ncbvar = " ".
    If nv_ncbper  <> 0 Then do:
        Find first sicsyac.xmm104 Use-index xmm10401 Where
            sicsyac.xmm104.tariff = nv_tariff        AND
            sicsyac.xmm104.class  = nv_class         AND 
            sicsyac.xmm104.covcod = nv_covcod        AND 
            sicsyac.xmm104.ncbper = NV_NCBPER        No-lock no-error no-wait.
        IF not avail  sicsyac.xmm104  Then do:
            Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
            ASSIGN  wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
        END.
        ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                    nv_ncbyrs = xmm104.ncbyrs.
    END.
    Else DO: 
        Assign
            nv_ncbyrs  =   0
            nv_ncbper  =   0
            nv_ncb     =   0.
    END.
    /*comment by : A64-0138...
    RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    DECI(wdetail.si),
                    uwm130.uom1_v,
                    uwm130.uom2_v,
                    uwm130.uom5_v).*/
    nv_ncbvar   = " ".
    IF  nv_ncb <> 0  THEN
        ASSIGN 
        nv_ncbvar1   = "     NCB % = "
        nv_ncbvar2   =  STRING(nv_ncbper)
        SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
        SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
    /*-------------- load claim ---------------------
    /*nv_cl_per  = 0.*/
    nv_clmvar  = " ".
    nv_cl_per  = DECI(nv_cl_per). /*A60-0150*/
    IF nv_cl_per  <> 0  THEN
        Assign 
        nv_clmvar1   = " Load Claim % = "
        nv_clmvar2   =  STRING(nv_cl_per)
        SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
    RUN WGS\WGSORPR1.P  (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    nv_totsi,
                    uwm130.uom1_v,
                    uwm130.uom2_v,
                    uwm130.uom5_v).*/
    /*------------------ dsspc ---------------*/
     IF (nv_dss_per = 0 ) AND (nv_gapprm > n_prem) AND (n_prem > 0 ) THEN DO:
             nv_dss_per = TRUNCATE(((nv_gapprm  - n_prem ) * 100 ) / nv_gapprm ,3 ) . 
             IF  nv_dss_per   <> 0  THEN
                 Assign
                 nv_dsspcvar1   = "     Discount Special % = "
                 nv_dsspcvar2   =  STRING(nv_dss_per)
                 SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
                 SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
             /*--------------------------*/
             /*comment by : A64-0138...
             RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                 nv_class,
                                 nv_covcod,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_totsi,
                                 nv_uom1_v ,       
                                 nv_uom2_v ,       
                                 nv_uom5_v ). */
         END.
    /*------------------ stf ---------------
          nv_stfvar   = " ".
          nv_stf_per     = DECI(nv_stf_per). /*A60-0150*/
      IF  nv_stf_per   <> 0  THEN
           ASSIGN nv_stfvar1   = "     Discount Staff"          
                 nv_stfvar2   =  STRING(nv_stf_per)           
                 SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1    
                 SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2. 
        /*--------------------------*/                        
     RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    nv_totsi,
                    nv_uom1_v ,       
                    nv_uom2_v ,       
                    nv_uom5_v ).*/

    ASSIGN fi_show = "out base" + wdetail.policy.
    DISP fi_show WITH FRAM fr_main.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt c-win 
PROCEDURE proc_calpremt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A64-0138      
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "V70" THEN DO:
    ASSIGN fi_show = "Create data to base..." + wdetail.policy .
    DISP fi_show WITH FRAM fr_main.
    ASSIGN 
         nv_polday  = 0 
         nv_covcod  = ""  
         nv_class   = ""  
         nv_vehuse  = ""  
         nv_cstflg  = ""  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/    
         nv_engcst  = 0   /* ต้องใส่ค่าตาม nv_cstflg  */         
         /*nv_drivno  = 0*/
         nv_driage1 = 0
         nv_driage2 = 0
         nv_pdprm0  = 0  /*เบี้ยส่วนลดผู้ขับขี่*/
         nv_yrmanu  = 0
         nv_totsi   = 0
         nv_totfi   = 0
         nv_vehgrp  = ""
         nv_access  = ""
         nv_supe    = NO
         nv_tpbi1si = 0
         nv_tpbi2si = 0
         nv_tppdsi  = 0   
         nv_411si   = 0
         nv_412si   = 0
         nv_413si   = 0
         nv_414si   = 0  
         nv_42si    = 0
         nv_43si    = 0
         nv_seat41  = 0          
         nv_dedod   = 0
         nv_addod   = 0
         nv_dedpd   = 0        
         nv_ncbp    = 0
         nv_fletp   = 0
         nv_dspcp   = 0
         nv_dstfp   = 0
         nv_clmp    = 0
         nv_netprem = 0     /*เบี้ยสุทธิ */
         nv_gapprm  = 0     /*เบี้ยรวม */
         nv_flagprm = "N"   /* N = เบี้ยสุทธิ, G = เบี้ยรวม */
         nv_effdat  = ?
         nv_ratatt  = 0 
         nv_siatt   = 0 
         nv_netatt  = 0 
         nv_fltatt  = 0 
         nv_ncbatt  = 0 
         nv_dscatt  = 0 
         /*nv_status  = "" */
         nv_fcctv   = NO
         nv_uom1_c  = "" 
         nv_uom2_c  = "" 
         nv_uom5_c  = "" 
         nv_uom6_c  = "" 
         nv_uom7_c  = "" .

    ASSIGN               
         nv_covcod  = wdetail.covcod                                              
         nv_class   = trim(wdetail.prempa) + trim(wdetail.subclass)
         nv_vehuse  = wdetail.vehuse                                    
       /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
         nv_engcst  = 1900*/ /* ต้องใส่ค่าตาม nv_cstflg         
         nv_drivno  = 0   */                                     
         nv_driage1 = nv_drivage1                                 
         nv_driage2 = nv_drivage2                                    
         nv_yrmanu  = INT(wdetail.caryear)                         
         nv_totsi   = sic_bran.uwm130.uom6_v       
         nv_totfi   = sic_bran.uwm130.uom7_v
         nv_vehgrp  = wdetail.cargrp                                                     
         nv_access  = ""                                             
       /*nv_supe    = NO*/                                              
         nv_tpbi1si = sic_bran.uwm130.uom1_v             
         nv_tpbi2si = sic_bran.uwm130.uom2_v             
         nv_tppdsi  = sic_bran.uwm130.uom5_v             
         nv_411si   = nv_41       
         nv_412si   = nv_41       
         nv_413si   = 0           
         nv_414si   = 0           
         nv_42si    = nv_42                
         nv_43si    = nv_43                
         nv_seat41  = IF wdetail.seat41 = 0 THEN inte(wdetail.seat) ELSE wdetail.seat41
         nv_dedod   = dod1      
         nv_addod   = dod2                                
         nv_dedpd   = dod0                                     
         nv_ncbp    = deci(wdetail.ncb)                                     
         nv_fletp   = nv_flet_per                                 
         nv_dspcp   = nv_dss_per                                      
         nv_dstfp   = 0                                                     
         nv_clmp    = 0  
         /*nv_netprem  = TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) + 
                        (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )*/
         nv_netprem  = DECI(wdetail.volprem) /* เบี้ยสุทธิ */                                                
         nv_gapprm  = 0                                                       
         nv_flagprm = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
         nv_effdat  = sic_bran.uwm100.comdat                             
         nv_ratatt  = 0                    
         nv_siatt   = 0                                                   
         nv_netatt  = 0 
         nv_fltatt  = 0 
         nv_ncbatt  = 0 
         nv_dscatt  = 0 
         /*nv_status  = "" */
         nv_fcctv   = NO . 

     FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
           clastab_fil.CLASS  = nv_class     AND
           clastab_fil.covcod = wdetail.covcod    NO-LOCK NO-ERROR.
        IF AVAIL stat.clastab_fil THEN DO:
            IF clastab_fil.unit = "C" THEN DO:
                ASSIGN
                    nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" THEN "W" ELSE clastab_fil.unit
                    nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(wdetail.cc) ELSE INT(wdetail.cc).
            END.
            ELSE IF clastab_fil.unit = "S" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = INT(wdetail.seat).
            END.
            ELSE IF clastab_fil.unit = "T" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = DECI(sic_bran.uwm301.Tons).
            END.
            nv_engcst = nv_engine .
        END.

    IF nv_cstflg = "W" THEN ASSIGN sic_bran.uwm301.watt = nv_engine . /* add  */

    IF wdetail.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            RUN wgw/wgwredbook(input  wdetail.brand ,  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  "X",  
                               input  SUBSTR(nv_class,2,5),   
                               input  wdetail.caryear, 
                               input  nv_engine  ,
                               input  0 , 
                               INPUT-OUTPUT wdetail.redbook) .
        END.
        ELSE DO:
            RUN wgw/wgwredbook(input  wdetail.brand ,  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  "X",  
                               input  SUBSTR(nv_class,2,5),   
                               input  wdetail.caryear, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT wdetail.redbook) .
        END.

        IF wdetail.redbook <> ""  THEN DO: 
            FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
                stat.maktab_fil.sclass = wdetail.subclass  AND
                stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
            If  avail  stat.maktab_fil  Then 
                ASSIGN  
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod   
                wdetail.cargrp          =  stat.maktab_fil.prmpac
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                nv_vehgrp               =  stat.maktab_fil.prmpac.
        END.
        ELSE DO:
            ASSIGN
                wdetail.comment = wdetail.comment + "| " + "Redbook is Null !! "
                wdetail.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ " 
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".
        END.
    END.

    FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  wdetail.brand AND 
                                    maktab_fil.sclass   =  trim(SUBSTR(nv_class,2,4)) NO-LOCK NO-ERROR.
        IF AVAIL stat.maktab_fil THEN nv_supe = maktab_fil.impchg.

    IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
        IF ( DAY(sic_bran.uwm100.comdat)     =  DAY(sic_bran.uwm100.expdat)     AND
           MONTH(sic_bran.uwm100.comdat)     =  MONTH(sic_bran.uwm100.expdat)   AND
            YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
           ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
           MONTH(sic_bran.uwm100.comdat)     =   02                             AND
             DAY(sic_bran.uwm100.expdat)     =   01                             AND
           MONTH(sic_bran.uwm100.expdat)     =   03                             AND
            YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
        THEN DO:
          nv_polday = 365.
        END.
        ELSE DO:
          nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
        END.
    END.
    /* 
    MESSAGE 
    " wdetail.covcod   "  nv_covcod     skip  
    " wdetail.class    "  nv_class      skip  
    " wdetail.vehuse   "  nv_vehuse     skip  
    " nv_cstflg        "  nv_cstflg     skip  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/
    " nv_engine        "  nv_engcst     skip  /* ต้องใส่ค่าตาม nv_cstflg  */
    " nv_drivno        "  nv_drivno     skip  
    " nv_drivage1      "  nv_driage1    skip  
    " nv_drivage2      "  nv_driage2    skip
    " wdetail.caryear  "  nv_yrmanu     skip
    " wdetail.si       "  nv_totsi      skip  
    " wdetail.fi       "  nv_totfi      skip  
    " wdetail.cargrp   "  nv_vehgrp     skip  
    " wdetail.prmtxt   "  nv_access     skip  
    " nv_supe          "  nv_supe       skip  /*  supercar = yes/no  */                  
    " wdetail.uom1_v   "  nv_tpbi1si    skip  
    " wdetail.uom2_v   "  nv_tpbi2si    skip  
    " wdetail.uom5_v   "  nv_tppdsi     skip  
    " nv_411           "  nv_411si      skip  /*nv_411si */    
    " nv_412           "  nv_412si      skip  /*nv_412si */    
    " nv_413           "  nv_413si      skip  /*nv_413si */  
    " nv_414           "  nv_414si      skip  /*nv_414si */ 
    " nv_42            "  nv_42si       skip  
    " nv_43            "  nv_43si       skip  
    " wdetail.seat41   "  nv_seat41     skip  
    " dod1             "  nv_dedod      skip  /*nv_dedod */ 
    " dod2             "  nv_addod      skip  /*nv_addod */  
    " dod0             "  nv_dedpd      skip  /*nv_dedpd */                
    " wdetail.ncb      "  nv_ncbp       skip  
    " wdetail.fleet    "  nv_fletp      skip  
    " wdetail.dspc     "  nv_dspcp      skip  
    " nv_dstfp         "  nv_dstfp      skip  
    " nv_clmp          "  nv_clmp       skip  
    " nv_netprem       "  nv_netprem    skip  
    " nv_gapprm        "  nv_gapprem    skip  
    " nv_flagprm       "  nv_flagprm    skip  
    " wdetail.comdat   "  nv_effdat     skip 
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.   */ 
    RUN WUW\WUWPADP2.P(INPUT sic_bran.uwm100.policy,
                       INPUT sic_bran.uwm100.rencnt,
                       INPUT sic_bran.uwm100.endcnt,
                       INPUT nv_riskno ,  
                       INPUT nv_batchyr, 
                       INPUT nv_batchno, 
                       INPUT nv_polday,
                       INPUT-OUTPUT nv_covcod ,
                       INPUT-OUTPUT nv_class  ,
                       INPUT-OUTPUT nv_vehuse ,
                       INPUT-OUTPUT nv_cstflg ,
                       INPUT-OUTPUT nv_engcst ,
                       INPUT-OUTPUT nv_drivno ,
                       INPUT-OUTPUT nv_driage1,
                       INPUT-OUTPUT nv_driage2,
                       INPUT-OUTPUT nv_pdprm0 , 
                       INPUT-OUTPUT nv_yrmanu ,
                       INPUT-OUTPUT nv_totsi  ,
/*                        INPUT-OUTPUT nv_totfi  , */
                       INPUT-OUTPUT nv_vehgrp,  
                       INPUT-OUTPUT nv_access,  
                       INPUT-OUTPUT nv_supe,                       
                       INPUT-OUTPUT nv_tpbi1si, 
                       INPUT-OUTPUT nv_tpbi2si, 
                       INPUT-OUTPUT nv_tppdsi,                 
                       INPUT-OUTPUT nv_411si,   
                       INPUT-OUTPUT nv_412si,   
                       INPUT-OUTPUT nv_413si,   
                       INPUT-OUTPUT nv_414si,   
                       INPUT-OUTPUT nv_42si,    
                       INPUT-OUTPUT nv_43si,    
                       INPUT-OUTPUT nv_41prmt, /* nv_41prmt */
                       INPUT-OUTPUT nv_42prmt, /* nv_42prmt */
                       INPUT-OUTPUT nv_43prmt, /* nv_43prmt */
                       INPUT-OUTPUT nv_seat41, /* nv_seat41 */             
                       INPUT-OUTPUT nv_dedod,   
                       INPUT-OUTPUT nv_addod,    
                       INPUT-OUTPUT nv_dedpd,                  
                       INPUT-OUTPUT nv_ncbp,      
                       INPUT-OUTPUT nv_fletp,   
                       INPUT-OUTPUT nv_dspcp,   
                       INPUT-OUTPUT nv_dstfp,   
                       INPUT-OUTPUT nv_clmp,                  
                       INPUT-OUTPUT nv_baseprm , /* nv_baseprm  */
                       INPUT-OUTPUT nv_baseprm3, /* nv_baseprm3 */
                       INPUT-OUTPUT nv_pdprem  , /* nv_pdprem   */
                       INPUT-OUTPUT nv_netprem,  /* nv_netprem  */
                       INPUT-OUTPUT nv_gapprm,  
                       INPUT-OUTPUT nv_flagprm,             
                       INPUT-OUTPUT nv_effdat,
                       INPUT-OUTPUT nv_ratatt, 
                       INPUT-OUTPUT nv_siatt ,
                       INPUT-OUTPUT nv_netatt,    
                       INPUT-OUTPUT nv_fltatt, 
                       INPUT-OUTPUT nv_ncbatt, 
                       INPUT-OUTPUT nv_dscatt,
                       INPUT-OUTPUT nv_fcctv , /* cctv = yes/no */
                       OUTPUT nv_uom1_c ,  
                       OUTPUT nv_uom2_c ,  
                       OUTPUT nv_uom5_c ,  
                       OUTPUT nv_uom6_c ,
                       OUTPUT nv_uom7_c ,
                       OUTPUT nv_status, 
                       OUTPUT nv_message). 
    /*IF nv_gapprm <> DECI(wdetail.volprem) THEN DO: */
    IF nv_status = "no" THEN DO:
        /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.volprem +
        nv_message   VIEW-AS ALERT-BOX.
        ASSIGN  wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
                wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.volprem.
                wdetail.pass     = "Y"    
                wdetail.OK_GEN  = "N".  *//*comment by Kridtiya i. A65-0035*/
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . /*  by Kridtiya i. A65-0035*/
        ASSIGN  wdetail.comment = wdetail.comment + "|" + nv_message     /*  by Kridtiya i. A65-0035*/
                wdetail.WARNING = wdetail.WARNING + "|" + nv_message .   /*  by Kridtiya i. A65-0035*/
    END.
    /*by Kridtiya i. A65-0035*/
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate (input DATE(wdetail.comdat),
                        input DATE(wdetail.expdat),
                        input wdetail.poltyp,
                        OUTPUT nv_chkerror ) .
    IF nv_chkerror <> ""  THEN 
        ASSIGN wdetail.comment = wdetail.comment + "|" + nv_chkerror 
               wdetail.pass    = "N"
               wdetail.OK_GEN  = "N".
    /* end : A65-0035 */
    ASSIGN 
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassic c-win 
PROCEDURE proc_chassic :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew AS CHAR.
DEFINE VAR nv_len AS INTE INIT 0.
ASSIGN nv_uwm301trareg = wdetail.chasno.
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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcode c-win 
PROCEDURE proc_chkcode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 /* Add by : A64-0138 */ 
  nv_chkerror = "".
    RUN wgw\wgwchkagpd  (INPUT wdetail.agent ,           
                         INPUT wdetail.producer ,  
                         INPUT-OUTPUT nv_chkerror).
    IF nv_chkerror <> "" THEN DO:
        MESSAGE "Error Code Producer/Agent :" nv_chkerror  SKIP
        wdetail.producer SKIP
        wdetail.agent  VIEW-AS ALERT-BOX. 
        ASSIGN wdetail.comment = wdetail.comment + nv_chkerror 
               wdetail.pass    = "N" 
               wdetail.OK_GEN  = "N".
    END.
    
 
 IF wdetail.deler <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.deler) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Dealer " + wdetail.deler + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code Dealer " + wdetail.deler + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
                wdetail.pass    = "N" 
                wdetail.OK_GEN  = "N".
     END.
 END.
 IF wdetail.financecd <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.financecd) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Finance " + wdetail.financecd + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
      IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
       ASSIGN wdetail.comment = wdetail.comment + "| Code Finance " + wdetail.financecd + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
              wdetail.pass    = "N" 
              wdetail.OK_GEN  = "N".
     END.
 END.
 /*
 IF wdetail.payercod <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.payercod) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Payer " + wdetail.payercod + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
 END.*/
 IF wdetail.vatcode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.vatcode) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Vat " + wdetail.vatcode + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code VAT " + wdetail.vatcode + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
             wdetail.pass    = "N" 
             wdetail.OK_GEN  = "N".
    END.
 END.
 RELEASE sicsyac.xmm600.
  /* end : A64-0138 */ 


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 c-win 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER  INIT  0. 
ASSIGN fi_show = "Check data basic......".
DISP fi_show WITH FRAM fr_main.
 IF wdetail.vehreg = " "   /* AND wdetail.prepol  = " "*/ THEN DO: 
    ASSIGN
        wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N". 
END.             
ELSE DO:
    IF /* wdetail.prepol */ ""  = " " THEN DO:     /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
        Def  var  nv_vehreg  as char  init  " ".
        Def  var  s_polno    like sicuw.uwm100.policy   init " ".
        Find LAST sicuw.uwm301 Use-index uwm30102  Where  
            sicuw.uwm301.vehreg = wdetail.vehreg   No-lock no-error no-wait.
        IF AVAIL sicuw.uwm301 THEN DO:
            If  sicuw.uwm301.policy =  wdetail.policy     and          
                sicuw.uwm301.endcnt = 1  and
                sicuw.uwm301.rencnt = 1  and
                sicuw.uwm301.riskno = 1  and
                sicuw.uwm301.itemno = 1  Then  Leave.
            Find first sicuw.uwm100 Use-index uwm10001     Where
                sicuw.uwm100.policy = sicuw.uwm301.policy    and
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt    and                         
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt    and
                sicuw.uwm100.expdat > date(wdetail.comdat)   No-lock no-error no-wait.
            If avail sicuw.uwm100 Then 
                s_polno     =   sicuw.uwm100.policy.
        END.  /*avil 301*/
    END.      /*จบการ Check ทะเบียนรถ*/
END.          /*note end else*/   /*end note vehreg*/
IF wdetail.cancel = "ca"  THEN  
    ASSIGN
    wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.prempa = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.branch = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| branch เป็นค่าว่าง มีผลต่อการรับประกันภัย"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
ELSE DO: 
        IF (SUBSTR(wdetail.policy,1,1) = "D") THEN DO:
            IF (SUBSTR(wdetail.policy,2,1) <> (TRIM(wdetail.branch))) THEN 
                ASSIGN wdetail.comment = wdetail.comment + "| branch และกรมธรรม์สาขาไม่ถูกต้อง...!!!"
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".
        END.
        ELSE DO:
            IF (SUBSTR(wdetail.policy,1,2) <> (TRIM(wdetail.branch))) THEN 
                ASSIGN wdetail.comment = wdetail.comment + "| branch และกรมธรรม์สาขาไม่ถูกต้อง...!!!"
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".
        END.
END.
IF wdetail.subclass = " " THEN  
    ASSIGN
        wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
IF wdetail.brand = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
/*IF wdetail.model = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N".*/
/*IF wdetail.seat  = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".*/
IF wdetail.caryear = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
IF (year(date(wdetail.comdat)) > year(TODAY))  THEN DO:
    IF (year(date(wdetail.comdat)) - year(TODAY)) > 1 THEN 
        ASSIGN
        wdetail.comment = wdetail.comment + "| กรุณาตรวจสอบปี ของวันที่ความคุ้มครองให้อยู่ในปี ค.ศ..!!!"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".

END.
/*Add Kridtiya i. A55-0257 ...*/
/*IF wdetail.idno <> "" THEN DO:
    IF LENGTH(TRIM(wdetail.idno)) = 13 THEN DO:
        DO WHILE nv_seq <= 12:
            nv_sum = nv_sum + INTEGER(SUBSTR(TRIM(wdetail.idno),nv_seq,1)) * (14 - nv_seq).
            nv_seq = nv_seq + 1.
        END.
        nv_checkdigit = 11 - nv_sum MODULO 11.
        IF nv_checkdigit >= 10 THEN nv_checkdigit = nv_checkdigit - 10.
        IF STRING(nv_checkdigit) <> SUBSTR(TRIM(wdetail.idno),13,1) THEN  
            ASSIGN  wdetail.comment = wdetail.comment + "| WARNING: พบเลขบัตรประชาชนไม่ถูกต้อง"
            wdetail.pass    = "N"  
            WDETAIL.OK_GEN  = "N".
    END.
    ELSE ASSIGN  wdetail.comment = wdetail.comment + "| WARNING: คีย์เลขบัตรประชาชนไม่ถูกต้องไม่เท่ากับ 13 หลัก"
        wdetail.pass    = "N"  
        WDETAIL.OK_GEN  = "N".
END.*/
/*End... Add Kridtiya i. A55-0257 ...*/
ASSIGN 
    nv_maxsi = 0
    nv_minsi = 0
    nv_si    = 0
    nv_maxdes = ""
    nv_mindes = ""
    /*chkred = NO*/
    n_model = "". 
IF      wdetail.subclass = "110" THEN wdetail.seat = "7".
ELSE IF wdetail.subclass = "120" THEN wdetail.seat = "7".   /*A57-0063*/  
ELSE IF wdetail.subclass = "210" THEN wdetail.seat = "12".  
ELSE IF wdetail.subclass = "220" THEN wdetail.seat = "12".  /*A57-0063*/
ELSE IF wdetail.subclass = "320" THEN wdetail.seat = "3".   
ELSE IF wdetail.subclass = "610" THEN wdetail.seat = "2".   /*A57-0063*/
ELSE IF wdetail.subclass = "620" THEN wdetail.seat = "2".   /*A57-0063*/
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE 
        stat.maktab_fil.sclass = wdetail.subclass   AND 
        stat.maktab_fil.modcod = wdetail.redbook    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  nv_modcod        =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            /*chkred           =  YES     */               
            wdetail.brand    =  stat.maktab_fil.makdes
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
            /*wdetail.cc       =  STRING(stat.maktab_fil.engine)*/
            wdetail.weight   =  STRING(stat.maktab_fil.tons)
            wdetail.subclass =  stat.maktab_fil.sclass   
            wdetail.redbook  =  stat.maktab_fil.modcod                                    
            wdetail.seat     =  STRING(stat.maktab_fil.seats)
            nv_si            = maktab_fil.si.
        IF wdetail.covcod = "1"  THEN DO:
            FIND FIRST stat.makdes31 WHERE  stat.makdes31.makdes = "X"  AND     /*Lock X*/
                stat.makdes31.moddes  =  wdetail.prempa + wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE makdes31 THEN 
                ASSIGN  
                nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            ELSE 
                ASSIGN  nv_maxSI = nv_si
                    nv_minSI = nv_si.
        END.   /***--- End Check Rate SI ---***/
    END.
    ELSE nv_modcod = " ".
END.    /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN 
        nv_simat  = makdes31.si_theft_p   
        nv_simat1 = makdes31.load_p   .    
    ELSE ASSIGN 
        nv_simat  = 0
        nv_simat1 = 0.
    IF wdetail.model = "" THEN DO:
        Find LAST stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And 
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN nv_modcod       =  stat.maktab_fil.modcod                                    
        nv_moddes       =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp  =  stat.maktab_fil.prmpac
        wdetail.redbook =  stat.maktab_fil.modcod 
        wdetail.weight  =  STRING(stat.maktab_fil.tons)
        wdetail.body    =  stat.maktab_fil.body .
    END.
    ELSE DO:
    Find LAST stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        nv_modcod       =  stat.maktab_fil.modcod                                    
        nv_moddes       =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp  =  stat.maktab_fil.prmpac
        wdetail.redbook =  stat.maktab_fil.modcod 
        wdetail.weight   =  STRING(stat.maktab_fil.tons)
        wdetail.body    =  stat.maktab_fil.body .
    END.
END.
    ASSIGN                  
        NO_CLASS  = wdetail.prempa + wdetail.subclass 
        nv_poltyp = wdetail.poltyp.
    If no_class  <>  " " Then do:
        FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
            sicsyac.xmd031.poltyp =   nv_poltyp AND
            sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE sicsyac.xmd031 THEN 
            /*MESSAGE   "Not on Business Classes Permitted per Policy Type file xmd031"  
                sicuw.uwm100.poltyp   no_class  View-as alert-box.*/
            ASSIGN
                wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
                wdetail.pass    = "N"   
                wdetail.OK_GEN  = "N".
        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
            sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
        IF NOT AVAILABLE sicsyac.xmm016 THEN 
            ASSIGN
                wdetail.comment = wdetail.comment + "| Not on Business class on xmm016"
                wdetail.pass    = "N"    
                wdetail.OK_GEN  = "N".
        ELSE 
            ASSIGN    
                /*wdetail.tariff =   sicsyac.xmm016.tardef*/
                no_class       =   sicsyac.xmm016.class
                nv_sclass      =   Substr(no_class,2,3).
    END.
    Find sicsyac.sym100 Use-index sym10001       Where
         sicsyac.sym100.tabcod = "u014"          AND 
         sicsyac.sym100.itmcod =  wdetail.vehuse No-lock no-error no-wait.
    IF not avail sicsyac.sym100 Then 
        ASSIGN
            wdetail.comment = wdetail.comment + "| Not on Vehicle Usage Codes table sym100 u014"
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     Find  sicsyac.sym100 Use-index sym10001  Where
         sicsyac.sym100.tabcod = "u013"         And
         sicsyac.sym100.itmcod = wdetail.covcod
         No-lock no-error no-wait.
     IF not avail sicsyac.sym100 Then 
         ASSIGN
             wdetail.comment = wdetail.comment + "| Not on Motor Cover Type Codes table sym100 u013"
             wdetail.pass    = "N"    
             wdetail.OK_GEN  = "N".
     /*---------- fleet -------------------*/
     /*IF inte(wdetail.fleet) <> 0 AND INTE(wdetail.fleet) <> 10 Then 
         ASSIGN
             wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. "
             wdetail.pass    = "N"    
             wdetail.OK_GEN  = "N".*/
     /*----------  access -------------------*//*
     If  wdetail.access  =  "y"  Then do:  
         If  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
             nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
             Then  wdetail.access  =  "y".         
         Else do:
             Message "Class "  nv_sclass "ไม่รับอุปกรณ์เพิ่มพิเศษ"  View-as alert-box.
             ASSIGN
                 wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ"
                 wdetail.pass    = "N"    
                 wdetail.OK_GEN  = "N".
         End.
     END.   -------------A52-0172*/
     /*----------  ncb -------------------*/
     /*IF wdetail.prepol = ""  THEN DO:
         IF wdetail.covcod = "2" THEN RUN proc_dsp_ncb. 
         IF (DECI(wdetail.ncb) = 0 )  OR (DECI(wdetail.ncb) = 20 ) OR
             (DECI(wdetail.ncb) = 30 ) OR (DECI(wdetail.ncb) = 40 ) OR
             (DECI(wdetail.ncb) = 50 )    THEN DO:
         END.
     ELSE 
         ASSIGN
             wdetail.comment = wdetail.comment + "| not on NCB Rates file xmm104."
             wdetail.pass    = "N"   
             wdetail.OK_GEN  = "N".
     END.*/
     
     NV_NCBPER = INTE(WDETAIL.NCB).
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401 Where
             sicsyac.xmm104.tariff = "X"                   AND
             sicsyac.xmm104.class  = no_class  AND
             sicsyac.xmm104.covcod = wdetail.covcod           AND
             sicsyac.xmm104.ncbper = INTE(wdetail.ncb)
             No-lock no-error no-wait.
         IF not avail  sicsyac.xmm104  Then 
             ASSIGN
                 wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
                 wdetail.pass    = "N"     
                 wdetail.OK_GEN  = "N".
     END. /*ncb <> 0*/
     /******* drivernam **********/
     /*nv_sclass = wdetail.subclass. 
     If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
         ASSIGN
             wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
             wdetail.pass    = "N"    
             wdetail.OK_GEN  = "N".*/
     
     /*------------- compul --------------*/ /*comment by kridtiya i. A52-0172
     IF wdetail.compul = "y" THEN DO:
         IF wdetail.stk = " " THEN DO:
             MESSAGE "ซื้อ พรบ ต้องมีหมายเลข Sticker".
             ASSIGN
                 wdetail.comment = wdetail.comment + "| ซื้อ พรบ ต้องมีหมายเลข Sticker"
                 wdetail.pass    = "N"     
                 wdetail.OK_GEN  = "N".
         END.
         /*STR amparat C. A51-0253--*/
         IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
         IF LENGTH(wdetail.stk) < 11 OR LENGTH(wdetail.stk) > 13 THEN DO:
             MESSAGE "เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น" VIEW-AS ALERT-BOX.
             ASSIGN /*a490166*/
                 wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
                 wdetail.pass    = ""
                 wdetail.OK_GEN  = "N".
         END.  /*END amparat C. A51-0253--*/
     END.   -----*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1 c-win 
PROCEDURE proc_chktest1 :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
-----------------------------------------------------------------------------*/
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail:
    IF  wdetail.policy = ""  THEN NEXT.
    /*------------------  renew ---------------------*/
    IF wdetail.redbook = "" THEN RUN proc_findredbook.
    ASSIGN 
        nc_r2 = ""
        n_rencnt = 0
        n_endcnt = 0
        dod1 = 0         
        dod2 = 0         
        dod0 = 0 
        dod0 = wdetail.deduct .
    RUN proc_cr_2. 
    /* IF wdetail.prepol <> " " THEN RUN proc_renew.*/
    /*Add by Kridtiya i. A63-0472*/
    RUN proc_assign2addr (INPUT  wdetail.iadd1            
                         ,INPUT  wdetail.iadd2            
                         ,INPUT  wdetail.iadd3  + " " + wdetail.iadd4            
                         ,INPUT  wdetail.occup   
                         ,OUTPUT wdetail.codeocc  
                         ,OUTPUT wdetail.codeaddr1
                         ,OUTPUT wdetail.codeaddr2
                         ,OUTPUT wdetail.codeaddr3).
    IF nv_postcd <> ""  THEN DO:
        ASSIGN wdetail.postcd = nv_postcd.
        IF      INDEX(wdetail.iadd4,nv_postcd) <> 0 THEN  wdetail.iadd4 = REPLACE(wdetail.iadd4,nv_postcd,"").
        ELSE IF INDEX(wdetail.iadd3,nv_postcd) <> 0 THEN  wdetail.iadd3 = REPLACE(wdetail.iadd3,nv_postcd,"").
        ELSE IF INDEX(wdetail.iadd2,nv_postcd) <> 0 THEN  wdetail.iadd2 = REPLACE(wdetail.iadd2,nv_postcd,"").
        ELSE IF INDEX(wdetail.iadd1,nv_postcd) <> 0 THEN  wdetail.iadd1 = REPLACE(wdetail.iadd1,nv_postcd,"").
    END.
    RUN proc_matchtypins (INPUT  wdetail.tiname
                          ,INPUT  wdetail.insnam
                          ,OUTPUT wdetail.insnamtyp
                          ,OUTPUT wdetail.firstName
                          ,OUTPUT wdetail.lastName).
    wdetail.br_insured = "00000".
    /*IF wdetail.deler <> "" THEN DO:
        RUN wgw\wgwmatov (INPUT        wdetail.poltyp                 
                          ,INPUT        inte(wdetail.caryear)   
                          ,INPUT        wdetail.subclass     
                          ,INPUT        wdetail.covcod         
                          ,INPUT        wdetail.brand               
                          ,INPUT        wdetail.model               
                          ,INPUT        wdetail.deler     
                          ,INPUT        ""      /* wdetail.financecd   */         
                          ,INPUT        inte(wdetail.si)                      
                          ,INPUT        wdetail.agent                                                   
                          ,INPUT-OUTPUT wdetail.campaign_ov) .  
    END.*/
    RUN proc_susspect.
    RUN proc_chkcode . /*A64-0138*/
    /*Add by Kridtiya i. A63-0472*/
    IF wdetail.poltyp = "v72"  THEN DO:
        RUN proc_72.
        RUN proc_policy. 
        RUN proc_722.
        RUN proc_723 (INPUT  s_recid1,       
                      INPUT  s_recid2,
                      INPUT  s_recid3,
                      INPUT  s_recid4,
                      INPUT-OUTPUT nv_message).
        NEXT.
    END.
    ELSE DO:
        RUN proc_chktest0.
    END.
    RUN proc_chktest0.
    RUN proc_policy . 
    RUN proc_chktest2.      
    RUN proc_chktest3.      
    RUN proc_chktest4.   
END.     /*for each*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2 c-win 
PROCEDURE proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_show = "Create data to uwm130..." + wdetail.policy .
DISP fi_show WITH FRAM fr_main.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND  /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND  /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND  /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr             AND 
    sic_bran.uwm130.bchno  = nv_batchno             AND 
    sic_bran.uwm130.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm100.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt  
        sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   
        sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno
        sic_bran.uwm130.bchyr  = nv_batchyr    /* batch Year */
        sic_bran.uwm130.bchno  = nv_batchno    /* bchno      */
        sic_bran.uwm130.bchcnt = nv_batcnt     /* bchcnt     */
        nv_sclass              = wdetail.subclass .

    nv_uom6_u = "".
    /*IF wdetail.acctyp <> "" THEN nv_uom6_u = trim(wdetail.acctyp) . /*A60-0150*/*/
    IF nv_uom6_u  =  "A"  THEN DO:
        IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
            nv_sclass  =  "520"  Or  nv_sclass  =  "540"  Then  nv_uom6_u  =  "A".         
        Else 
            ASSIGN wdetail.pass = "N"
                wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
    END.
    IF  CAPS(nv_uom6_u) = "A"  Then
        Assign  nv_uom6_u          = "A"
        nv_othcod                  = "OTH"
        nv_othvar1                 = "     Accessory  = "
        nv_othvar2                 =  STRING(nv_uom6_u)
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2
        sic_bran.uwm130.uom6_u     = nv_uom6_u.  /*A60-0150*/
    ELSE                           
        ASSIGN  nv_uom6_u              = ""
            nv_othcod                  = ""
            nv_othvar1                 = ""
            nv_othvar2                 = ""
            SUBSTRING(nv_othvar,1,30)  = nv_othvar1
            SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  OR 
        (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR
        (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN 
        ASSIGN 
        sic_bran.uwm130.uom1_v = deci(wdetail.deductpp)   
        sic_bran.uwm130.uom2_v = deci(wdetail.deductba)   
        sic_bran.uwm130.uom5_v = deci(wdetail.deductpa)  
        sic_bran.uwm130.uom6_v = inte(wdetail.si)
        sic_bran.uwm130.uom7_v = inte(wdetail.fi)
        sic_bran.uwm130.fptr01 = 0     sic_bran.uwm130.bptr01 = 0   /*Item Upper text*/
        sic_bran.uwm130.fptr02 = 0     sic_bran.uwm130.bptr02 = 0   /*Item Lower Text*/
        sic_bran.uwm130.fptr03 = 0     sic_bran.uwm130.bptr03 = 0   /*Cover & Premium*/
        sic_bran.uwm130.fptr04 = 0     sic_bran.uwm130.bptr04 = 0   /*Item Endt. Text*/
        sic_bran.uwm130.fptr05 = 0     sic_bran.uwm130.bptr05 = 0.  /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = inte(wdetail.si)
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN sic_bran.uwm130.uom1_v = deci(wdetail.deductpp)  
        sic_bran.uwm130.uom2_v        = deci(wdetail.deductba)  
        sic_bran.uwm130.uom5_v        = deci(wdetail.deductpa)  
        sic_bran.uwm130.uom6_v    = 0   
        sic_bran.uwm130.uom7_v    = 0
        sic_bran.uwm130.fptr01    = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02    = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03    = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04    = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05    = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    /*IF trim(wdetail.CCTV) <> "" THEN sic_bran.uwm130.i_text = "0001" . /*A60-0262*/  */
    IF wdetail.poltyp = "v72" THEN DO: 
        IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN 
             n_sclass72 = "140A".
        ELSE n_sclass72 = "110".
    END.
    ELSE n_sclass72 = wdetail.prempa + wdetail.subclass .

    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do:
        /*IF substr(wdetail.class,1,1) = "Z" THEN*/                                 /*Comment by Kridtiya i. A63/00167*/
        IF substr(n_sclass72,1,1) = "Z" OR substr(n_sclass72,1,1) = "T" THEN  /*Add by Kridtiya i. A63/00167*/
            Assign 
            sic_bran.uwm130.uom1_v     =  deci(wdetail.deductpp)     /*stat.clastab_fil.uom1_si  1000000  */  
            sic_bran.uwm130.uom2_v     =  deci(wdetail.deductba)     /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     =  deci(wdetail.deductpa)     /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  =  deci(wdetail.deductpp)     /*deci(wdetail2.tp_bi)   */ 
            nv_uom2_v                  =  deci(wdetail.deductba)     /*deci(wdetail2.tp_bi2) */  
            nv_uom5_v                  =  deci(wdetail.deductpa).     /*deci(wdetail2.tp_bi3) */ 
        ELSE
            Assign 
            sic_bran.uwm130.uom1_v     =  stat.clastab_fil.uom1_si   
            sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si   
            sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si  
            nv_uom1_v                  =  stat.clastab_fil.uom1_si    
            nv_uom2_v                  =  stat.clastab_fil.uom2_si    
            nv_uom5_v                  =  stat.clastab_fil.uom5_si  .
        ASSIGN 
            /*wdetail.deductpd           =  string(sic_bran.uwm130.uom5_v)*/
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            wdetail.comper             =  string(stat.clastab_fil.uom8_si)                
            wdetail.comacc             =  string(stat.clastab_fil.uom9_si)
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".
        /*IF (wdetail.prepol <> "") OR (substr(wdetail.class,1,1) = "Z") THEN*//*Comment by Kridtiya i. A63/00167*/
        IF substr(n_sclass72,1,1) = "Z" OR substr(n_sclass72,1,1) = "T"  THEN    /*Add by Kridtiya i. A63/00167*/    
            ASSIGN 
            /*nv_41          = deci(wdetail.nv_41) 
              nv_412         = deci(wdetail.nv_412) 
              nv_42          = deci(wdetail.nv_42) 
              nv_43          = deci(wdetail.nv_43) */
              nv_seat41      = IF wdetail.seat41 = 0 THEN deci(wdetail.seat) ELSE wdetail.seat41
                   /*wdetail.seat41 = IF nv_seat41 = 0 THEN deci(wdetail.seat) ELSE nv_seat41 */  .
        ELSE IF  wdetail.garage =  ""  Then
            ASSIGN nv_41   = stat.clastab_fil.si_41unp
            nv_42          = stat.clastab_fil.si_42
            nv_43          = stat.clastab_fil.si_43
            nv_seat41      = stat.clastab_fil.dri_41 + clastab_fil.pass_41
            wdetail.seat41 = stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
        Else If  wdetail.garage  =  "G"  Then
            Assign 
            nv_41          =  stat.clastab_fil.si_41pai
            nv_42          =  stat.clastab_fil.si_42
            nv_43          =  stat.clastab_fil.impsi_43
            nv_seat41      =  stat.clastab_fil.dri_41 + clastab_fil.pass_41
            wdetail.seat41 =  stat.clastab_fil.dri_41 + clastab_fil.pass_41 .  
    END.           
    ASSIGN  nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                         nv_riskno,
                         nv_itemno).
    END.   /* end Do transaction*/
    ASSIGN  s_recid3  = RECID(sic_bran.uwm130)
        nv_covcod =   wdetail.covcod
        nv_newsck  = " ".
    RUN proc_chassic.
    IF SUBSTRING(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
    ELSE nv_newsck =  wdetail.stk.
    FIND sic_bran.uwm301 USE-INDEX uwm30101       WHERE
        sic_bran.uwm301.policy = sic_bran.uwm100.policy    AND
        sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt    AND
        sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt    AND
        sic_bran.uwm301.riskgp = s_riskgp                  AND
        sic_bran.uwm301.riskno = s_riskno                  AND
        sic_bran.uwm301.itemno = s_itemno                  AND
        sic_bran.uwm301.bchyr  = nv_batchyr                AND 
        sic_bran.uwm301.bchno  = nv_batchno                AND 
        sic_bran.uwm301.bchcnt = nv_batcnt                 NO-WAIT NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
        DO TRANSACTION:
            CREATE sic_bran.uwm301.
        END.
    END.
    ASSIGN sic_bran.uwm301.policy = sic_bran.uwm120.policy                 
        sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno    = s_itemno
        sic_bran.uwm301.tariff    = IF wdetail.poltyp = "V72" THEN "9" ELSE "X" 
        sic_bran.uwm301.covcod    = nv_covcod
        sic_bran.uwm301.cha_no    = wdetail.chasno
        sic_bran.uwm301.trareg    = nv_uwm301trareg
        sic_bran.uwm301.eng_no    = wdetail.eng
        sic_bran.uwm301.modcod    = wdetail.redbook
        sic_bran.uwm301.Tons      = INTEGER(wdetail.weight)
        sic_bran.uwm301.engine    = INTEGER(wdetail.cc) 
        sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage    = wdetail.garage
        sic_bran.uwm301.body      = wdetail.body
        sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83  = wdetail.benname
        sic_bran.uwm301.vehreg    = wdetail.vehreg
        sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse    = wdetail.vehuse
        sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
        sic_bran.uwm301.sckno     = 0
        sic_bran.uwm301.itmdel    = NO.
        IF SUBSTR(sic_bran.uwm120.policy,3,2) = "70" THEN sic_bran.uwm301.prmtxt = wdetail.prmtxt.
        ELSE sic_bran.uwm301.prmtxt = "".
        sic_bran.uwm301.logbok = wdetail.ispstatus.
        IF wdetail.drivname1  <> ""   THEN RUN proc_mailtxt.
         s_recid4         = RECID(sic_bran.uwm301).
         /*-- maktab_fil --*/
         IF wdetail.redbook <> "" THEN DO:
             /*AND chkred = YES  THEN DO:*/
             FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass      AND
                 stat.maktab_fil.modcod = wdetail.redbook
                 No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN  sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                     wdetail.cargrp          =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
                     wdetail.body            =  stat.maktab_fil.body .
         END.
         ELSE DO:
             FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
                 makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL makdes31  THEN
                 ASSIGN nv_simat  = makdes31.si_theft_p   
                 nv_simat1 = makdes31.load_p   .    
             ELSE ASSIGN 
                 nv_simat  = 0
                 nv_simat1 = 0.
             Find LAST stat.maktab_fil USE-INDEX maktab04    Where
                 stat.maktab_fil.makdes   =     wdetail.brand            And                  
                 index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                 stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                 stat.maktab_fil.sclass   =     wdetail.subclass        AND
                 (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE  deci(wdetail.si)    OR
                  stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE  deci(wdetail.si) )  AND  
                 stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
                 No-lock no-error no-wait.
             If  avail stat.maktab_fil  Then 
                 Assign
                 wdetail.redbook         =  stat.maktab_fil.modcod
                 wdetail.body            =  stat.maktab_fil.body 
                 wdetail.weight          =  STRING(stat.maktab_fil.tons)
                 sic_bran.uwm301.tons    =  stat.maktab_fil.tons
                 sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                 wdetail.cargrp          =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.body    =  stat.maktab_fil.body
                 sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes.
         END.
         IF sic_bran.uwm301.modcod = ""  THEN RUN proc_maktab.
        
         
        ASSIGN 
            sic_bran.uwm301.bchyr  = nv_batchyr      /* batch Year */
            sic_bran.uwm301.bchno  = nv_batchno      /* bchno      */
            sic_bran.uwm301.bchcnt = nv_batcnt    .  /* bchcnt     */
        s_recid4         = RECID(sic_bran.uwm301) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2bk c-win 
PROCEDURE proc_chktest2bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_show = "Create policy data detail car[uwm301]......".
   /* comment by A62-0219.....  
    wdetail.deductpp     = STRING(fi_tpp)      /*stat.clastab_fil.uom1_si*/
    wdetail.deductba     = STRING(fi_tba)      /*stat.clastab_fil.uom2_si*/
    wdetail.deductpa     = STRING(fi_tpa).
    ... end A62-0219 ...*/
DISP fi_show WITH FRAM fr_main.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND             
    sic_bran.uwm130.riskno = s_riskno               AND            
    sic_bran.uwm130.itemno = s_itemno               AND            
    sic_bran.uwm130.bchyr  = nv_batchyr             AND 
    sic_bran.uwm130.bchno  = nv_batchno             AND 
    sic_bran.uwm130.bchcnt  = nv_batcnt             NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno
        sic_bran.uwm130.bchyr  = nv_batchyr        /* batch Year */
        sic_bran.uwm130.bchno  = nv_batchno        /* bchno      */
        sic_bran.uwm130.bchcnt  = nv_batcnt        /* bchcnt     */
        nv_sclass = wdetail.subclass
        nv_uom6_u  =  "A" .  
    /*IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN */
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR (wdetail.covcod = "2.1") OR (wdetail.covcod = "2.2") OR 
       (wdetail.covcod = "3.1") OR (wdetail.covcod = "3.2")   THEN  /*A62-0219*/
        ASSIGN
        sic_bran.uwm130.uom6_v   = inte(wdetail.si)
        /*sic_bran.uwm130.uom7_v   = inte(wdetail.si)*/ /*a62-0219*/
        sic_bran.uwm130.uom7_v   = inte(wdetail.fi)    /*a62-0219*/
        sic_bran.uwm130.uom1_v   = deci(wdetail.deductpp)  
        sic_bran.uwm130.uom2_v   = deci(wdetail.deductba)  
        sic_bran.uwm130.uom5_v   = deci(wdetail.deductpa)  
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN
        sic_bran.uwm130.uom1_c  = "D1"
        sic_bran.uwm130.uom2_c  = "D2"
        sic_bran.uwm130.uom5_c  = "D5"
        sic_bran.uwm130.uom6_c  = "D6"
        sic_bran.uwm130.uom7_c  = "D7"
        sic_bran.uwm130.uom1_v   = deci(wdetail.deductpp)       
        sic_bran.uwm130.uom2_v   = deci(wdetail.deductba)       
        sic_bran.uwm130.uom5_v   = deci(wdetail.deductpa)       
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = inte(wdetail.si)
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN
        wdetail.benname          = ""
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.poltyp = "v72" THEN DO: 
        IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN 
            n_sclass72 = "140A".
        ELSE n_sclass72 = "110".
    END.
    ELSE n_sclass72 = wdetail.prempa + wdetail.subclass .

    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = wdetail.covcod No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do:   
        IF substr(n_sclass72,1,1) = "Z" THEN
            Assign             
            /*comment by A62-0219....
            wdetail.no_41   =  string(fi_pa41)
            wdetail.no_42   =  string(fi_pa42)
            wdetail.no_43   =  string(fi_pa43)
            wdetail.seat41  =  DECI(wdetail.seat) 
            sic_bran.uwm130.uom1_v     = deci(fi_tpp)      /*stat.clastab_fil.uom1_si*/
            sic_bran.uwm130.uom2_v     = deci(fi_tba)      /*stat.clastab_fil.uom2_si*/
            sic_bran.uwm130.uom5_v     = deci(fi_tpa).
            ... end A62-0219......*/
            wdetail.seat41  =  DECI(wdetail.seat) 
            sic_bran.uwm130.uom1_v     = deci(wdetail.deductpp)      /*stat.clastab_fil.uom1_si*/
            sic_bran.uwm130.uom2_v     = deci(wdetail.deductba)      /*stat.clastab_fil.uom2_si*/
            sic_bran.uwm130.uom5_v     = deci(wdetail.deductpa).
        ELSE DO:
            ASSIGN      /*stat.clastab_fil.uom5_si*/
            sic_bran.uwm130.uom1_v = deci(wdetail.deductpp)          
            sic_bran.uwm130.uom2_v = deci(wdetail.deductba)          
            sic_bran.uwm130.uom5_v = deci(wdetail.deductpa). 
            /* comment by A62-0219.............
            sic_bran.uwm130.uom1_v = stat.clastab_fil.uom1_si        
            sic_bran.uwm130.uom2_v = stat.clastab_fil.uom2_si        
            sic_bran.uwm130.uom5_v = stat.clastab_fil.uom5_si
            wdetail.deductpp       = STRING(stat.clastab_fil.uom1_si)      /*stat.clastab_fil.uom1_si*/
            wdetail.deductba       = STRING(stat.clastab_fil.uom2_si)      /*stat.clastab_fil.uom2_si*/
            wdetail.deductpa       = STRING(stat.clastab_fil.uom5_si).
            ... end A62-0219....*/
            If  wdetail.garage  =  ""  Then
                Assign 
                /* comment by A62-0219....
                wdetail.no_41   =  string(stat.clastab_fil.si_41unp)
                wdetail.no_42   =  string(stat.clastab_fil.si_42)
                wdetail.no_43   =  string(stat.clastab_fil.si_43)
                ... end A62-0219...*/
                wdetail.seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
            Else If  wdetail.garage  =  "G"  Then
                Assign 
              /* comment by A62-0219....
                wdetail.no_41    = string(stat.clastab_fil.si_41pai)
                wdetail.no_42    = string(stat.clastab_fil.si_42)    
                wdetail.no_43    = string(stat.clastab_fil.impsi_43)
                ... end A62-0219...*/
                wdetail.seat41   = stat.clastab_fil.dri_41 + clastab_fil.pass_41.    
        END.
        ASSIGN 
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            nv_uom1_v                  =  sic_bran.uwm130.uom1_v   
            nv_uom2_v                  =  sic_bran.uwm130.uom2_v
            nv_uom5_v                  =  sic_bran.uwm130.uom5_v        
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".
                
    END.           
    ASSIGN
        nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                         nv_riskno,
                         nv_itemno).
    END.  /* end Do transaction*/
    ASSIGN 
    s_recid3  = RECID(sic_bran.uwm130) 
    nv_covcod =   wdetail.covcod 
    nv_makdes =  wdetail.brand 
    nv_newsck = " ".
    RUN proc_chassic.
    IF SUBSTRING(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
    ELSE nv_newsck =  wdetail.stk.
         FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
             sic_bran.uwm301.policy = sic_bran.uwm100.policy    AND
             sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt    AND
             sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt    AND
             sic_bran.uwm301.riskgp = s_riskgp                  AND
             sic_bran.uwm301.riskno = s_riskno                  AND
             sic_bran.uwm301.itemno = s_itemno                  AND
             sic_bran.uwm301.bchyr  = nv_batchyr                AND 
             sic_bran.uwm301.bchno  = nv_batchno                AND 
             sic_bran.uwm301.bchcnt = nv_batcnt                     
             NO-WAIT NO-ERROR.
         IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
             DO TRANSACTION:
                 CREATE sic_bran.uwm301.
             END. 
         END. 
         ASSIGN
             sic_bran.uwm301.bchyr  = nv_batchyr               
             sic_bran.uwm301.bchno  = nv_batchno               
             sic_bran.uwm301.bchcnt = nv_batcnt   
             sic_bran.uwm301.policy    = sic_bran.uwm120.policy                 
             sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
             sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
             sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
             sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
             sic_bran.uwm301.itemno    = s_itemno
             sic_bran.uwm301.tariff    = IF wdetail.poltyp = "V72" THEN "9" ELSE "X" 
             sic_bran.uwm301.covcod    = nv_covcod
             sic_bran.uwm301.cha_no    = wdetail.chasno
             sic_bran.uwm301.trareg    = nv_uwm301trareg
             sic_bran.uwm301.eng_no    = wdetail.eng
             sic_bran.uwm301.modcod    = wdetail.redbook
             sic_bran.uwm301.Tons      = INTEGER(wdetail.weight)
             sic_bran.uwm301.engine    = INTEGER(wdetail.cc) 
             sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
             sic_bran.uwm301.garage    = wdetail.garage
             sic_bran.uwm301.body      = wdetail.body
             sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
             sic_bran.uwm301.mv_ben83  = wdetail.benname
             sic_bran.uwm301.vehreg    = wdetail.vehreg
             sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
             sic_bran.uwm301.vehuse    = wdetail.vehuse
             sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
             sic_bran.uwm301.sckno     = 0
             sic_bran.uwm301.itmdel    = NO.

             /* Begin by Phaiboon W. [A59-0488] Date 21/11/2016  */
             /* sic_bran.uwm301.prmtxt    = wdetail.prmtxt.  */
             IF SUBSTR(sic_bran.uwm120.policy,3,2) = "70" THEN sic_bran.uwm301.prmtxt = wdetail.prmtxt.
             ELSE sic_bran.uwm301.prmtxt = "".

             sic_bran.uwm301.logbok = wdetail.ispstatus.
             /* End by Phaiboon W. [A59-0488] Date 21/11/2016 */

         IF wdetail.drivname1  <> ""   THEN RUN proc_mailtxt.
         s_recid4         = RECID(sic_bran.uwm301).
         /*-- maktab_fil --*/
         IF wdetail.redbook <> "" THEN DO:
             /*AND chkred = YES  THEN DO:*/
             FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass      AND
                 stat.maktab_fil.modcod = wdetail.redbook
                 No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN  sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                     wdetail.cargrp          =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
                     wdetail.body            =  stat.maktab_fil.body .
         END.
         ELSE DO:
             FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
                 makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL makdes31  THEN
                 ASSIGN nv_simat  = makdes31.si_theft_p   
                 nv_simat1 = makdes31.load_p   .    
             ELSE ASSIGN 
                 nv_simat  = 0
                 nv_simat1 = 0.
             Find LAST stat.maktab_fil USE-INDEX maktab04    Where
                 stat.maktab_fil.makdes   =     wdetail.brand            And                  
                 index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                 stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                 stat.maktab_fil.sclass   =     wdetail.subclass        AND
                 (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE  deci(wdetail.si)    OR
                  stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE  deci(wdetail.si) )  AND  
                 stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
                 No-lock no-error no-wait.
             If  avail stat.maktab_fil  Then 
                 Assign
                 wdetail.redbook         =  stat.maktab_fil.modcod
                 wdetail.body            =  stat.maktab_fil.body 
                 wdetail.weight          =  STRING(stat.maktab_fil.tons)
                 sic_bran.uwm301.tons    =  stat.maktab_fil.tons
                 sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                 wdetail.cargrp          =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.body    =  stat.maktab_fil.body
                 sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes.
         END.
         IF sic_bran.uwm301.modcod = ""  THEN RUN proc_maktab.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest3 c-win 
PROCEDURE proc_chktest3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN 
    nv_tariff = sic_bran.uwm301.tariff
    nv_class  = wdetail.prempa +  wdetail.subclass    /*IF wdetail.poltyp = "v72" THEN wdetail.subclass ELSE wdetail.prempa +  wdetail.subclass*/
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = DECI(wdetail.cc)
    nv_tons   = deci(wdetail.weight)
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse
    nv_COMPER = deci(wdetail.comper) 
    nv_comacc = deci(wdetail.comacc) 
    nv_seats  = INTE(wdetail.seat)
    nv_tons   = DECI(wdetail.weight)
    nv_dss_per = 0     
    nv_dsspcvar1   = ""
    nv_dsspcvar2   =  ""
    nv_dsspcvar   = ""
    nv_42cod   = ""
    nv_43cod   = ""
    nv_41cod1 = ""
    nv_41cod2   = ""
    nv_basecod = ""
    nv_usecod  = "" 
    nv_engcod  = "" 
    nv_drivcod = ""
    nv_yrcod   = "" 
    nv_sicod   = "" 
    nv_grpcod  = "" 
    nv_bipcod  = "" 
    nv_biacod  = "" 
    nv_pdacod  = "" 
    nv_ncbyrs  =   0    
    nv_ncbper  =   0    
    nv_ncb     =   0
    nv_totsi   =  0 
 fi_show = "Check data base... premium campaign......" .
DISP fi_show WITH FRAM fr_main.
IF wdetail.compul = "y" THEN DO:
    IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN nv_class  = "140A".
    ELSE nv_class  = "110".
    ASSIGN
        nv_comper     = deci(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc     = deci(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v   = nv_comper   
        sic_bran.uwm130.uom9_v   = nv_comacc  
        nv_vehuse = "0" . 
    RUN wgs\wgscomp. 
    If  nv_comper  =  0  Then   nv_comacc =  0 . 
    Else do:
        IF   nv_comacc  <> 0  Then do:
            ASSIGN
                nv_compcod      = "COMP"
                nv_compvar1     = "     Compulsory  =   "
                nv_compvar2     = STRING(nv_comacc)
                Substr(nv_compvar,1,30)   = nv_compvar1
                Substr(nv_compvar,31,30)  = nv_compvar2.
            IF n_curbil = "bht" THEN
                nv_comacc = Truncate(nv_comacc, 0).
            ELSE 
                nv_comacc = nv_comacc. 
                ASSIGN
                    sic_bran.uwm130.uom8_c  = "D8"
                    sic_bran.uwm130.uom9_c  = "D9". 
        End.
        Else assign          nv_compprm     = 0
            nv_compcod     = " "
            nv_compvar1    = " "
            nv_compvar2    = " "
            nv_compvar     = " ".
        
        If  nv_compprm  =  0  THEN DO:
            ASSIGN nv_vehuse = "0".     
            RUN wgs\wgscomp.       
        END.
        nv_comacc  = nv_comacc .                  
    End.  /* else do */
    If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0. 
END. /*compul y*/
ELSE 
    ASSIGN
        nv_compprm     = 0
        nv_compcod     = " "
        nv_compvar1    = " "
        nv_compvar2    = " "
        nv_compvar     = " "
        nv_COMPER      = 0
        nv_comacc      = 0
        sic_bran.uwm130.uom8_v  =  0               
        sic_bran.uwm130.uom9_v  =  0.
/*RUN proc_base2.*/ /*A62-0219*/
/* add by A62-0219 */
IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR 
   (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" )  THEN RUN proc_base2plus.   /*A58-0271*/
ELSE RUN proc_base2.
/* end A62-0219*/

IF wdetail.poltyp = "v72" THEN DO:
    ASSIGN  nv_baseprm = 0   
      nv_usecod  = "" 
      nv_engcod  = "" 
      nv_drivcod = ""
      nv_yrcod   = "" 
      nv_sicod   = "" 
      nv_grpcod  = "" 
      nv_bipcod  = "" 
      nv_biacod  = "" 
      nv_pdacod   = "" .
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    nv_totsi,
                    nv_uom1_v ,       
                    nv_uom2_v ,       
                    nv_uom5_v ).
END.
/*IF nv_gapprm <> inte(wdetail.premt) THEN  DO:
    MESSAGE "เบี้ยไม่ตรงกับเบี้ยที่คำนวณได้" + wdetail.premt + " <> " + STRING(nv_gapprm) VIEW-AS ALERT-BOX.
    ASSIGN 
        wdetail.WARNING  = "เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้"
        wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้ "
        wdetail.pass    = "N".
END. */ 
RUN proc_calpremt .        /*A64-0138*/
RUN proc_adduwd132prem .   /*A64-0138*/

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN 
     sic_bran.uwm100.prem_t = nv_gapprm
     sic_bran.uwm100.sigr_p = inte(wdetail.si)
     sic_bran.uwm100.gap_p  = nv_gapprm.
     IF wdetail.pass <> "Y" THEN 
         ASSIGN
         sic_bran.uwm100.impflg = NO
         sic_bran.uwm100.imperr = wdetail.comment.    
     
END.
FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
     ASSIGN
     sic_bran.uwm120.gap_r  = nv_gapprm
     sic_bran.uwm120.prem_r = nv_pdprm
     sic_bran.uwm120.sigr   = inte(wdetail.si).

FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN 
    ASSIGN   
      /*  sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs*/
        sic_bran.uwm301.mv41seat = inte(wdetail.seat).
/* comment by : A64-0138...
/* add by A62-0219 */
IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR
   (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" ) THEN DO:     
    RUN WGS\WGSTP132(INPUT S_RECID3,   
                     INPUT S_RECID4).
END. 
/* end A62-0219*/
ELSE RUN WGS\WGSTN132(INPUT S_RECID3, 
                      INPUT S_RECID4).
...end A64-0138..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4 c-win 
PROCEDURE proc_chktest4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR   n_sigr_r     like sic_bran.uwm130.uom6_v.
DEF VAR   n_gap_r      Like sic_bran.uwd132.gap_c . 
DEF VAR   n_prem_r     Like sic_bran.uwd132.prem_c.
DEF VAR   nt_compprm   like sic_bran.uwd132.prem_c.  
DEF VAR   n_gap_t      Like sic_bran.uwm100.gap_p.
DEF VAR   n_prem_t     Like sic_bran.uwm100.prem_t.
DEF VAR   n_sigr_t     Like sic_bran.uwm100.sigr_p.
DEF VAR   nv_policy    like sic_bran.uwm100.policy.
DEF VAR   nv_rencnt    like sic_bran.uwm100.rencnt.
DEF VAR   nv_endcnt    like sic_bran.uwm100.endcnt.
DEF VAR   nv_com1_per  like sicsyac.xmm031.comm1.
DEF VAR   nv_stamp_per like sicsyac.xmm020.rvstam.
DEF VAR nv_com2p        AS DECI INIT 0.00 .
DEF VAR nv_com1p        AS DECI INIT 0.00 .
DEF VAR nv_fi_netprm    AS DECI INIT 0.00.
DEF VAR NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR nv_fi_stamp_per AS DECI INIT 0.00.
DEF VAR nv_fi_rstp_t    AS INTE INIT 0.
DEF VAR nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF VAR nv_fi_com1_t    AS DECI INIT 0.00.
DEF VAR nv_fi_com2_t    AS DECI INIT 0.00.
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1
  no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
      Return.
  End.
  Else  do:
      Assign 
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt.
            FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                     sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
                     sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
                     sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
                     sic_bran.uwm120.bchyr = nv_batchyr               AND 
                     sic_bran.uwm120.bchno = nv_batchno               AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt         .
                     FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                              sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                              sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                              sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                              sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                              sic_bran.uwm130.bchyr = nv_batchyr              AND 
                              sic_bran.uwm130.bchno = nv_batchno              AND 
                              sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                         n_sigr_r                = n_sigr_r + uwm130.uom6_v.
                              FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE 
                                       sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                                       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                                       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                                       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                                       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                                       sic_bran.uwd132.bchyr = nv_batchyr              AND 
                                       sic_bran.uwd132.bchno = nv_batchno              AND 
                                       sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.
                                        IF  sic_bran.uwd132.bencod  = "COMP"   THEN
                                             nt_compprm     = nt_compprm + sic_bran.uwd132.prem_c.
                                         n_gap_r  = sic_bran.uwd132.gap_c  + n_gap_r.
                                         n_prem_r = sic_bran.uwd132.prem_c + n_prem_r.
                                 END.  /* uwd132 */
                          END.  /*uwm130 */
                          ASSIGN
                          n_gap_t      = n_gap_t   + n_gap_r
                          n_prem_t     = n_prem_t  + n_prem_r
                          n_sigr_t     = n_sigr_t  + n_sigr_r
                          n_gap_r      = 0 
                          n_prem_r     = 0  
                          n_sigr_r     = 0.
           END.    /* end uwm120 */
  End.  /*  avail  100   */
  /*-------------------- calprem ---------------------*/
  Find LAST  sic_bran.uwm120  Use-index uwm12001  WHERE          
             sic_bran.uwm120.policy  = sic_bran.uwm100.policy   And
             sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt   And
             sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt   AND 
             sic_bran.uwm120.bchyr = nv_batchyr               AND 
             sic_bran.uwm120.bchno = nv_batchno               AND 
             sic_bran.uwm120.bchcnt  = nv_batcnt                No-error.
  FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
             substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
             SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
             sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
  IF AVAIL   sicsyac.xmm018 THEN 
            Assign     nv_com1p = sicsyac.xmm018.commsp  
                       nv_com2p = 0.
  ELSE DO:
          Find sicsyac.xmm031  Use-index xmm03101  Where  
               sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
          No-lock no-error no-wait.
          IF not  avail sicsyac.xmm031 Then 
            Assign     nv_com1p = 0
                       nv_com2p = 0.
          Else  
            Assign     nv_com1p = sicsyac.xmm031.comm1
                       nv_com2p = 0 .
  END. /* Not Avail Xmm018 */
  /***--- Commmission Rate Line 72 ---***/
  IF wdetail.compul = "y" THEN DO:
      FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
                 sicsyac.xmm018.agent              = sic_bran.uwm100.acno1  AND               
                 substr(sicsyac.xmm018.poltyp,1,5) = "CRV72"                AND               
                 SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch AND               
                 sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR. 
      IF AVAIL   sicsyac.xmm018 THEN 
                 nv_com2p = sicsyac.xmm018.commsp.
      
      ELSE DO:
           Find  sicsyac.xmm031  Use-index xmm03101  Where  
                 sicsyac.xmm031.poltyp    = "v72"
           No-lock no-error no-wait.
                   nv_com2p = sicsyac.xmm031.comm1.  
      END.
  END. /* Wdetail.Compul = "Y"*/
  /*--------- tax -----------*/
  Find sicsyac.xmm020 Use-index xmm02001        Where
       sicsyac.xmm020.branch = sic_bran.uwm100.branch   And
       sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri   No-lock no-error.
  IF avail sicsyac.xmm020 Then do:
           nv_fi_stamp_per      = sicsyac.xmm020.rvstam.
       If    sic_bran.uwm100.gstrat  <>  0  Then  nv_fi_tax_per  =  sic_bran.uwm100.gstrat.
       Else  nv_fi_tax_per  =  sicsyac.xmm020.rvtax.
  End.
  /*----------- stamp ------------*/
  IF sic_bran.uwm120.stmpae  = Yes Then do:                        /* STAMP */
     nv_fi_rstp_t  = Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) +
                     (IF     (sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100)   -
                     Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) > 0
                     Then 1 Else 0).
    
  End.
  sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
     
  IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
      nv_fi_rtax_t  = (sic_bran.uwm100.prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
       /* fi_taxae       = Yes.*/
  End.
  sic_bran.uwm100.rtax_t = nv_fi_rtax_t.
  sic_bran.uwm120.com1ae = YES.
  sic_bran.uwm120.com2ae = YES.
  /*--------- motor commission -----------------*/
  IF sic_bran.uwm120.com1ae   = Yes  Then do:                   /* MOTOR COMMISION */
     If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
           nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.            
         /*fi_com1ae        =  YES.*/
  End.
  /*----------- comp comission ------------*/
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then nv_com2p  = sic_bran.uwm120.com2p.
           nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.              
         /*nv_fi_com2ae        =  YES.*/
  End.
  IF sic_bran.uwm100.pstp <> 0 Then do:
     IF sic_bran.uwm100.no_sch  = 1 Then NV_fi_dup_trip = "D".
     Else If sic_bran.uwm100.no_sch  = 2 Then  NV_fi_dup_trip = "T".
  End.
  Else  NV_fi_dup_trip  =  "".
  nv_fi_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t
               + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.
  Find     sic_bran.uwm100 Where  Recid(sic_bran.uwm100)  =  s_recid1.
  If avail sic_bran.uwm100 Then 
      Assign 
           sic_bran.uwm100.gap_p   = n_gap_t
           sic_bran.uwm100.prem_t  = n_prem_t
           sic_bran.uwm100.sigr_p  = n_sigr_t
           sic_bran.uwm100.instot  = uwm100.instot
           sic_bran.uwm100.com1_t  =  nv_fi_com1_t
           sic_bran.uwm100.com2_t  =  nv_fi_com2_t
           sic_bran.uwm100.pstp    =  0               /*note modified on 25/10/2006*/
           sic_bran.uwm100.rstp_t  =  nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  =  nv_fi_rtax_t          
           sic_bran.uwm100.gstrat  =  nv_fi_tax_per.
  IF wdetail.poltyp = "v72" THEN 
            ASSIGN  
           sic_bran.uwm100.com2_t  = 0 
           sic_bran.uwm100.com1_t  = nv_fi_com2_t.
  Find     sic_bran.uwm120 Where  Recid(sic_bran.uwm120)   =  s_recid2   .
  IF avail sic_bran.uwm120 Then do:
       Assign
           sic_bran.uwm120.gap_r    = n_gap_t   /*n_gap_r */
           sic_bran.uwm120.prem_r   = n_prem_t  /*n_prem_r */
           sic_bran.uwm120.sigr     = n_sigr_T  /* A490166 note modi from n_sigr_r to n_sigr_t 11/10/2006 */
           sic_bran.uwm120.rtax     = nv_fi_rtax_t
           sic_bran.uwm120.taxae    = YES
           sic_bran.uwm120.stmpae   = YES
           sic_bran.uwm120.rstp_r   = nv_fi_rstp_t            
           sic_bran.uwm120.com1ae   = YES
           sic_bran.uwm120.com1p    = nv_com1p
           sic_bran.uwm120.com1_r   = nv_fi_com1_t
           sic_bran.uwm120.com2ae   = YES
           sic_bran.uwm120.com2p    = nv_com2p
           sic_bran.uwm120.com2_r   = nv_fi_com2_t.
        IF wdetail.poltyp = "v72" THEN 
           ASSIGN  
           sic_bran.uwm120.com2_r    = 0 
           sic_bran.uwm120.com1_r    = nv_fi_com2_t
           sic_bran.uwm120.com1p     = nv_com2p
           sic_bran.uwm120.com2p     = 0
           sic_bran.uwm120.rstp_r   = nv_fi_rstp_t 
           sic_bran.uwm120.rtax     = nv_fi_rtax_t.
  End.     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest_4 c-win 
PROCEDURE proc_chktest_4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR   n_sigr_r     like sic_bran.uwm130.uom6_v.
DEF VAR   n_gap_r      Like sic_bran.uwd132.gap_c . 
DEF VAR   n_prem_r     Like sic_bran.uwd132.prem_c.
DEF VAR   nt_compprm   like sic_bran.uwd132.prem_c.  
DEF VAR   n_gap_t      Like sic_bran.uwm100.gap_p.
DEF VAR   n_prem_t     Like sic_bran.uwm100.prem_t.
DEF VAR   n_sigr_t     Like sic_bran.uwm100.sigr_p.
DEF VAR   nv_policy    like sic_bran.uwm100.policy.
DEF VAR   nv_rencnt    like sic_bran.uwm100.rencnt.
DEF VAR   nv_endcnt    like sic_bran.uwm100.endcnt.
DEF VAR   nv_com1_per  like sicsyac.xmm031.comm1.
DEF VAR   nv_stamp_per like sicsyac.xmm020.rvstam.
DEF VAR nv_com2p        AS DECI INIT 0.00 .
DEF VAR nv_com1p        AS DECI INIT 0.00 .
DEF VAR nv_fi_netprm    AS DECI INIT 0.00.
DEF VAR NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR nv_fi_stamp_per AS DECI INIT 0.00.
DEF VAR nv_fi_rstp_t    AS INTE INIT 0.
DEF VAR nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF VAR nv_fi_com1_t    AS DECI INIT 0.00.
DEF VAR nv_fi_com2_t    AS DECI INIT 0.00.
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1
  no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
      Return.
  End.
  Else  do:
      Assign 
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt.
            FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                     sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
                     sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
                     sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
                     sic_bran.uwm120.bchyr = nv_batchyr               AND 
                     sic_bran.uwm120.bchno = nv_batchno               AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt         .
                     FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                              sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                              sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                              sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                              sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                              sic_bran.uwm130.bchyr = nv_batchyr              AND 
                              sic_bran.uwm130.bchno = nv_batchno              AND 
                              sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                         n_sigr_r                = n_sigr_r + uwm130.uom6_v.
                              FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE 
                                       sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                                       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                                       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                                       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                                       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                                       sic_bran.uwd132.bchyr = nv_batchyr              AND 
                                       sic_bran.uwd132.bchno = nv_batchno              AND 
                                       sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.
                                        IF  sic_bran.uwd132.bencod  = "COMP"   THEN
                                             nt_compprm     = nt_compprm + sic_bran.uwd132.prem_c.
                                         n_gap_r  = sic_bran.uwd132.gap_c  + n_gap_r.
                                         n_prem_r = sic_bran.uwd132.prem_c + n_prem_r.
                                 END.  /* uwd132 */
                          END.  /*uwm130 */
                          ASSIGN
                          n_gap_t      = n_gap_t   + n_gap_r
                          n_prem_t     = n_prem_t  + n_prem_r
                          n_sigr_t     = n_sigr_t  + n_sigr_r
                          n_gap_r      = 0 
                          n_prem_r     = 0  
                          n_sigr_r     = 0.
           END.    /* end uwm120 */
  End.  /*  avail  100   */
  /*-------------------- calprem ---------------------*/
  Find LAST  sic_bran.uwm120  Use-index uwm12001  WHERE          
             sic_bran.uwm120.policy  = sic_bran.uwm100.policy   And
             sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt   And
             sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt   AND 
             sic_bran.uwm120.bchyr = nv_batchyr               AND 
             sic_bran.uwm120.bchno = nv_batchno               AND 
             sic_bran.uwm120.bchcnt  = nv_batcnt                No-error.
  FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
             substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
             SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
             sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
  IF AVAIL   sicsyac.xmm018 THEN 
            Assign     nv_com1p = sicsyac.xmm018.commsp  
                       nv_com2p = 0.
  ELSE DO:
          Find sicsyac.xmm031  Use-index xmm03101  Where  
               sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
          No-lock no-error no-wait.
          IF not  avail sicsyac.xmm031 Then 
            Assign     nv_com1p = 0
                       nv_com2p = 0.
          Else  
            Assign     nv_com1p = sicsyac.xmm031.comm1
                       nv_com2p = 0 .
  END. /* Not Avail Xmm018 */
  /***--- Commmission Rate Line 72 ---***/
  IF wdetail.compul = "y" THEN DO:
      FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
                 sicsyac.xmm018.agent              = sic_bran.uwm100.acno1  AND               
                 substr(sicsyac.xmm018.poltyp,1,5) = "CRV72"                AND               
                 SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch AND               
                 sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR. 
      IF AVAIL   sicsyac.xmm018 THEN 
                 nv_com2p = sicsyac.xmm018.commsp.
      
      ELSE DO:
           Find  sicsyac.xmm031  Use-index xmm03101  Where  
                 sicsyac.xmm031.poltyp    = "v72"
           No-lock no-error no-wait.
                   nv_com2p = sicsyac.xmm031.comm1.  
      END.
  END. /* Wdetail.Compul = "Y"*/
  /*--------- tax -----------*/
  Find sicsyac.xmm020 Use-index xmm02001        Where
       sicsyac.xmm020.branch = sic_bran.uwm100.branch   And
       sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri   No-lock no-error.
  IF avail sicsyac.xmm020 Then do:
           nv_fi_stamp_per      = sicsyac.xmm020.rvstam.
       If    sic_bran.uwm100.gstrat  <>  0  Then  nv_fi_tax_per  =  sic_bran.uwm100.gstrat.
       Else  nv_fi_tax_per  =  sicsyac.xmm020.rvtax.
  End.
  /*----------- stamp ------------*/
  IF sic_bran.uwm120.stmpae  = Yes Then do:                        /* STAMP */
     nv_fi_rstp_t  = Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) +
                     (IF     (sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100)   -
                     Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) > 0
                     Then 1 Else 0).
    
  End.
  sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
     
  IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
      nv_fi_rtax_t  = (sic_bran.uwm100.prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
       /* fi_taxae       = Yes.*/
  End.
  sic_bran.uwm100.rtax_t = nv_fi_rtax_t.
  sic_bran.uwm120.com1ae = YES.
  sic_bran.uwm120.com2ae = YES.
  /*--------- motor commission -----------------*/
 
  IF sic_bran.uwm120.com1ae   = Yes  Then do:                   /* MOTOR COMMISION */
     If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
     ASSIGN nv_com1p = 0.00.  /*งาน kk ให้ค่า  com1A = 0.00 */
     nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.            
         /*fi_com1ae        =  YES.*/
  End.
  /*----------- comp comission ------------*/
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then nv_com2p  = sic_bran.uwm120.com2p.
           nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.              
         /*nv_fi_com2ae        =  YES.*/
  End.
  IF sic_bran.uwm100.pstp <> 0 Then do:
     IF sic_bran.uwm100.no_sch  = 1 Then NV_fi_dup_trip = "D".
     Else If sic_bran.uwm100.no_sch  = 2 Then  NV_fi_dup_trip = "T".
  End.
  Else  NV_fi_dup_trip  =  "".
  nv_fi_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t
               + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.
  Find     sic_bran.uwm100 Where  Recid(sic_bran.uwm100)  =  s_recid1.
  If avail sic_bran.uwm100 Then 
      Assign 
           sic_bran.uwm100.gap_p   = n_gap_t
           sic_bran.uwm100.prem_t  = n_prem_t
           sic_bran.uwm100.sigr_p  = n_sigr_t
           sic_bran.uwm100.instot  = uwm100.instot
           sic_bran.uwm100.com1_t  =  nv_fi_com1_t
           sic_bran.uwm100.com2_t  =  nv_fi_com2_t
           sic_bran.uwm100.pstp    =  0               /*note modified on 25/10/2006*/
           sic_bran.uwm100.rstp_t  =  nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  =  nv_fi_rtax_t          
           sic_bran.uwm100.gstrat  =  nv_fi_tax_per.
  IF wdetail.poltyp = "v72" THEN 
            ASSIGN  
           sic_bran.uwm100.com2_t  = 0 
           sic_bran.uwm100.com1_t  = nv_fi_com2_t.
  Find     sic_bran.uwm120 Where  Recid(sic_bran.uwm120)   =  s_recid2   .
  IF avail sic_bran.uwm120 Then do:
       Assign
           sic_bran.uwm120.gap_r    = n_gap_t   /*n_gap_r */
           sic_bran.uwm120.prem_r   = n_prem_t  /*n_prem_r */
           sic_bran.uwm120.sigr     = n_sigr_T  /* A490166 note modi from n_sigr_r to n_sigr_t 11/10/2006 */
           sic_bran.uwm120.rtax     = nv_fi_rtax_t
           sic_bran.uwm120.taxae    = YES
           sic_bran.uwm120.stmpae   = YES
           sic_bran.uwm120.rstp_r   = nv_fi_rstp_t            
           sic_bran.uwm120.com1ae   = YES
           sic_bran.uwm120.com1p    = nv_com1p
           sic_bran.uwm120.com1_r   = nv_fi_com1_t
           sic_bran.uwm120.com2ae   = YES
           sic_bran.uwm120.com2p    = nv_com2p
           sic_bran.uwm120.com2_r   = nv_fi_com2_t.
        IF wdetail.poltyp = "v72" THEN 
           ASSIGN  
           sic_bran.uwm120.com2_r    = 0 
           sic_bran.uwm120.com1_r    = nv_fi_com2_t
           sic_bran.uwm120.com1p     = nv_com2p
           sic_bran.uwm120.com2p     = 0
           sic_bran.uwm120.rstp_r   = nv_fi_rstp_t 
           sic_bran.uwm120.rtax     = nv_fi_rtax_t.
  End.     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create100 c-win 
PROCEDURE proc_create100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Create  sic_bran.uwm100.   /*Create ฝั่ง gateway*/    
ASSIGN                                              
       sic_bran.uwm100.policy =  wdetail.policy
       sic_bran.uwm100.rencnt =  n_rencnt             
       sic_bran.uwm100.renno  =  ""
       sic_bran.uwm100.endcnt =  n_endcnt
       sic_bran.uwm100.bchyr = nv_batchyr 
       sic_bran.uwm100.bchno = nv_batchno 
       sic_bran.uwm100.bchcnt  = nv_batcnt     .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cr_2 c-win 
PROCEDURE proc_cr_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER buwm100 FOR wdetail.
    ASSIGN nc_r2 = "" .
    IF wdetail.cedpol = " "    THEN DO:
        FOR EACH buwm100 WHERE 
            buwm100.insnam  = wdetail.insnam  AND
            buwm100.policy <> wdetail.policy  AND 
            buwm100.poltyp <> wdetail.poltyp NO-LOCK.
            ASSIGN 
                nc_r2 = buwm100.policy.
        END.
    END.
    ELSE DO:
        FOR EACH buwm100 WHERE 
            buwm100.cedpol  = wdetail.cedpol  AND
            buwm100.policy <> wdetail.policy  AND 
            buwm100.poltyp <> wdetail.poltyp NO-LOCK.
            ASSIGN 
                nc_r2 = buwm100.policy.
        END.
    END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchar c-win 
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
nv_c = wdetail.prepol.
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
    ind = INDEX(nv_c," ").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN
    wdetail.prepol = nv_c .
    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dsp_ncb c-win 
PROCEDURE proc_dsp_ncb :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    WDETAIL.NCB = "".
IF wdetail.subclass = "110" THEN DO:
    WDETAIL.NCB = "40".
    IF wdetail.si = "100,000.00"    THEN ASSIGN nv_dss_per = 28.69. 
    IF wdetail.si = "110,000.00"    THEN ASSIGN nv_dss_per = 28.57.  
    IF wdetail.si = "120,000.00"    THEN ASSIGN nv_dss_per = 28.36.  
    IF wdetail.si = "130,000.00"    THEN ASSIGN nv_dss_per = 28.25.  
    IF wdetail.si = "140,000.00"    THEN ASSIGN nv_dss_per = 28.10.  
    IF wdetail.si = "150,000.00"    THEN ASSIGN nv_dss_per = 27.94.  
    IF wdetail.si = "160,000.00"    THEN ASSIGN nv_dss_per = 27.84.  
    IF wdetail.si = "170,000.00"    THEN ASSIGN nv_dss_per = 27.77.  
    IF wdetail.si = "180,000.00"    THEN ASSIGN nv_dss_per = 27.59.  
    IF wdetail.si = "190,000.00"    THEN ASSIGN nv_dss_per = 27.45.  
    IF wdetail.si = "200,000.00"    THEN ASSIGN nv_dss_per = 27.38.  
    IF wdetail.si = "210,000.00"    THEN ASSIGN nv_dss_per = 27.24.  
    IF wdetail.si = "220,000.00"    THEN ASSIGN nv_dss_per = 27.10.  
    IF wdetail.si = "230,000.00"    THEN ASSIGN nv_dss_per = 27.01.  
    IF wdetail.si = "240,000.00"    THEN ASSIGN nv_dss_per = 26.88.  
    IF wdetail.si = "250,000.00"    THEN ASSIGN nv_dss_per = 26.75.  
    IF wdetail.si = "260,000.00"    THEN ASSIGN nv_dss_per = 26.66.  
    IF wdetail.si = "270,000.00"    THEN ASSIGN nv_dss_per = 26.49.  
    IF wdetail.si = "280,000.00"    THEN ASSIGN nv_dss_per = 26.44.  
    IF wdetail.si = "290,000.00"    THEN ASSIGN nv_dss_per = 26.36.  
    IF wdetail.si = "300,000.00"    THEN ASSIGN nv_dss_per = 26.20.  
    IF wdetail.si = "310,000.00"    THEN ASSIGN nv_dss_per = 26.16.  
    IF wdetail.si = "320,000.00"    THEN ASSIGN nv_dss_per = 26.04.  
    IF wdetail.si = "330,000.00"    THEN ASSIGN nv_dss_per = 25.92.  
    IF wdetail.si = "340,000.00"    THEN ASSIGN nv_dss_per = 25.84.  
    IF wdetail.si = "350,000.00"    THEN ASSIGN nv_dss_per = 25.73.  
    IF wdetail.si = "360,000.00"    THEN ASSIGN nv_dss_per = 25.62.  
    IF wdetail.si = "370,000.00"    THEN ASSIGN nv_dss_per = 25.55.  
    IF wdetail.si = "380,000.00"    THEN ASSIGN nv_dss_per = 25.40.  
    IF wdetail.si = "390,000.00"    THEN ASSIGN nv_dss_per = 25.36.  
    IF wdetail.si = "400,000.00"    THEN ASSIGN nv_dss_per = 25.25.  
    IF wdetail.si = "410,000.00"    THEN ASSIGN nv_dss_per = 25.12.
    IF wdetail.si = "420,000.00"    THEN ASSIGN nv_dss_per = 25.08.  
    IF wdetail.si = "430,000.00"    THEN ASSIGN nv_dss_per = 25.02.  
    IF wdetail.si = "440,000.00"    THEN ASSIGN nv_dss_per = 24.92.  
    IF wdetail.si = "450,000.00"    THEN ASSIGN nv_dss_per = 24.85.  
    IF wdetail.si = "460,000.00"    THEN ASSIGN nv_dss_per = 24.76.  
    IF wdetail.si = "470,000.00"    THEN ASSIGN nv_dss_per = 24.66.  
    IF wdetail.si = "480,000.00"    THEN ASSIGN nv_dss_per = 24.56.  
    IF wdetail.si = "490,000.00"    THEN ASSIGN nv_dss_per = 24.51.  
    IF wdetail.si = "500,000.00"    THEN ASSIGN nv_dss_per = 24.44. 
END.
ELSE IF wdetail.subclass = "210" THEN DO:
    WDETAIL.NCB = "50".
    IF wdetail.si = "100,000.00"    THEN ASSIGN nv_dss_per =  52.62  .  
    IF wdetail.si = "110,000.00"    THEN ASSIGN nv_dss_per =  53.03  .  
    IF wdetail.si = "120,000.00"    THEN ASSIGN nv_dss_per =  53.32  .  
    IF wdetail.si = "130,000.00"    THEN ASSIGN nv_dss_per =  53.68  .  
    IF wdetail.si = "140,000.00"    THEN ASSIGN nv_dss_per =  54.00  . 
    IF wdetail.si = "150,000.00"    THEN ASSIGN nv_dss_per =  54.30  .  
    IF wdetail.si = "160,000.00"    THEN ASSIGN nv_dss_per =  54.27  . 
    IF wdetail.si = "170,000.00"    THEN ASSIGN nv_dss_per =  54.23  .  
    IF wdetail.si = "180,000.00"    THEN ASSIGN nv_dss_per =  54.18  .  
    IF wdetail.si = "190,000.00"    THEN ASSIGN nv_dss_per =  54.14  .  
    IF wdetail.si = "200,000.00"    THEN ASSIGN nv_dss_per =  54.11  .  
    IF wdetail.si = "210,000.00"    THEN ASSIGN nv_dss_per =  54.06  .  
    IF wdetail.si = "220,000.00"    THEN ASSIGN nv_dss_per =  54.00  .  
    IF wdetail.si = "230,000.00"    THEN ASSIGN nv_dss_per =  53.97  .  
    IF wdetail.si = "240,000.00"    THEN ASSIGN nv_dss_per =  53.90  .  
    IF wdetail.si = "250,000.00"    THEN ASSIGN nv_dss_per =  53.83  .  
    IF wdetail.si = "260,000.00"    THEN ASSIGN nv_dss_per =  53.81  .  
    IF wdetail.si = "270,000.00"    THEN ASSIGN nv_dss_per =  53.73  .  
    IF wdetail.si = "280,000.00"    THEN ASSIGN nv_dss_per =  53.70  .  
    IF wdetail.si = "290,000.00"    THEN ASSIGN nv_dss_per =  53.68  .  
    IF wdetail.si = "300,000.00"    THEN ASSIGN nv_dss_per =  53.65  .  
    IF wdetail.si = "310,000.00"    THEN ASSIGN nv_dss_per =  53.63  .  
    IF wdetail.si = "320,000.00"    THEN ASSIGN nv_dss_per =  53.56  .  
    IF wdetail.si = "330,000.00"    THEN ASSIGN nv_dss_per =  53.51  .  
    IF wdetail.si = "340,000.00"    THEN ASSIGN nv_dss_per =  53.48  .  
    IF wdetail.si = "350,000.00"    THEN ASSIGN nv_dss_per =  53.46  .  
    IF wdetail.si = "360,000.00"    THEN ASSIGN nv_dss_per =  53.39  .  
    IF wdetail.si = "370,000.00"    THEN ASSIGN nv_dss_per =  53.36  .  
    IF wdetail.si = "380,000.00"    THEN ASSIGN nv_dss_per =  53.30  .  
    IF wdetail.si = "390,000.00"    THEN ASSIGN nv_dss_per =  53.29  .  
    IF wdetail.si = "400,000.00"    THEN ASSIGN nv_dss_per =  53.23  .
    IF wdetail.si = "410,000.00"    THEN ASSIGN nv_dss_per =  53.21  .  
    IF wdetail.si = "420,000.00"    THEN ASSIGN nv_dss_per =  53.19  .  
    IF wdetail.si = "430,000.00"    THEN ASSIGN nv_dss_per =  53.17  .  
    IF wdetail.si = "440,000.00"    THEN ASSIGN nv_dss_per =  53.11  .  
    IF wdetail.si = "450,000.00"    THEN ASSIGN nv_dss_per =  53.09  .  
    IF wdetail.si = "460,000.00"    THEN ASSIGN nv_dss_per =  53.07  .  
    IF wdetail.si = "470,000.00"    THEN ASSIGN nv_dss_per =  53.03  .  
    IF wdetail.si = "480,000.00"    THEN ASSIGN nv_dss_per =  52.96  .  
    IF wdetail.si = "490,000.00"    THEN ASSIGN nv_dss_per =  52.94  .  
    IF wdetail.si = "500,000.00"    THEN ASSIGN nv_dss_per =  52.92  .
END.                 
ELSE IF wdetail.subclass = "320" THEN DO:
    /*WDETAIL.NCB = "50".*/
    WDETAIL.NCB = "40".
    /* comment by kridtiya i. A54-0344...
    IF wdetail.si = "100,000.00"    THEN ASSIGN nv_dss_per = 40.98.  
    IF wdetail.si = "110,000.00"    THEN ASSIGN nv_dss_per = 41.03.  
    IF wdetail.si = "120,000.00"    THEN ASSIGN nv_dss_per = 40.93.  
    IF wdetail.si = "130,000.00"    THEN ASSIGN nv_dss_per = 40.95.  
    IF wdetail.si = "140,000.00"    THEN ASSIGN nv_dss_per = 40.91.  
    IF wdetail.si = "150,000.00"    THEN ASSIGN nv_dss_per = 40.90.  
    IF wdetail.si = "160,000.00"    THEN ASSIGN nv_dss_per = 40.93.  
    IF wdetail.si = "170,000.00"    THEN ASSIGN nv_dss_per = 40.93.  
    IF wdetail.si = "180,000.00"    THEN ASSIGN nv_dss_per = 40.90.  
    IF wdetail.si = "190,000.00"    THEN ASSIGN nv_dss_per = 40.90.  
    IF wdetail.si = "200,000.00"    THEN ASSIGN nv_dss_per = 40.93.  
    IF wdetail.si = "210,000.00"    THEN ASSIGN nv_dss_per = 40.90.  
    IF wdetail.si = "220,000.00"    THEN ASSIGN nv_dss_per = 40.87.  
    IF wdetail.si = "230,000.00"    THEN ASSIGN nv_dss_per = 40.90.  
    IF wdetail.si = "240,000.00"    THEN ASSIGN nv_dss_per = 40.84.  
    IF wdetail.si = "250,000.00"    THEN ASSIGN nv_dss_per = 40.81. 
    IF wdetail.si = "260,000.00"    THEN ASSIGN nv_dss_per = 40.83.  
    IF wdetail.si = "270,000.00"    THEN ASSIGN nv_dss_per = 40.77.  
    IF wdetail.si = "280,000.00"    THEN ASSIGN nv_dss_per = 40.80.  
    IF wdetail.si = "290,000.00"    THEN ASSIGN nv_dss_per = 40.82.  
    IF wdetail.si = "300,000.00"    THEN ASSIGN nv_dss_per = 40.80.  
    IF wdetail.si = "310,000.00"    THEN ASSIGN nv_dss_per = 40.82.  
    IF wdetail.si = "320,000.00"    THEN ASSIGN nv_dss_per = 40.76.  
    IF wdetail.si = "330,000.00"    THEN ASSIGN nv_dss_per = 40.75.  
    IF wdetail.si = "340,000.00"    THEN ASSIGN nv_dss_per = 40.77.  
    IF wdetail.si = "350,000.00"    THEN ASSIGN nv_dss_per = 40.77.  
    IF wdetail.si = "360,000.00"    THEN ASSIGN nv_dss_per = 40.73.  
    IF wdetail.si = "370,000.00"    THEN ASSIGN nv_dss_per = 40.75.  
    IF wdetail.si = "380,000.00"    THEN ASSIGN nv_dss_per = 40.69.  
    IF wdetail.si = "390,000.00"    THEN ASSIGN nv_dss_per = 40.75.  
    IF wdetail.si = "400,000.00"    THEN ASSIGN nv_dss_per = 40.68.
    IF wdetail.si = "410,000.00"    THEN ASSIGN nv_dss_per = 40.70.  
    IF wdetail.si = "420,000.00"    THEN ASSIGN nv_dss_per = 40.71.  
    IF wdetail.si = "430,000.00"    THEN ASSIGN nv_dss_per = 40.73.  
    IF wdetail.si = "440,000.00"    THEN ASSIGN nv_dss_per = 40.68.  
    IF wdetail.si = "450,000.00"    THEN ASSIGN nv_dss_per = 40.69.  
    IF wdetail.si = "460,000.00"    THEN ASSIGN nv_dss_per = 40.70.  
    IF wdetail.si = "470,000.00"    THEN ASSIGN nv_dss_per = 40.70.  
    IF wdetail.si = "480,000.00"    THEN ASSIGN nv_dss_per = 40.65.  
    IF wdetail.si = "490,000.00"    THEN ASSIGN nv_dss_per = 40.65.  
    IF wdetail.si = "500,000.00"    THEN ASSIGN nv_dss_per = 40.68.
    end...comment by kridtiya i. A54-0344....*/
    RUN proc_dsp_ncb2.
END.                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dsp_ncb2 c-win 
PROCEDURE proc_dsp_ncb2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* add by kridtiya i. A54-0344...*/
         IF wdetail.si = "100,000.00"    THEN ASSIGN nv_dss_per = 41.69.  
    /*ELSE IF wdetail.si = "100000"        THEN ASSIGN nv_dss_per = 41.69. */ 
    ELSE IF wdetail.si = "100000"        THEN ASSIGN nv_dss_per = 7.06. 
    ELSE IF wdetail.si = "110,000.00"    THEN ASSIGN nv_dss_per = 41.75.  
    ELSE IF wdetail.si = "120,000.00"    THEN ASSIGN nv_dss_per = 41.67.  
    ELSE IF wdetail.si = "130,000.00"    THEN ASSIGN nv_dss_per = 41.67.  
    ELSE IF wdetail.si = "140,000.00"    THEN ASSIGN nv_dss_per = 41.65.  
    ELSE IF wdetail.si = "150,000.00"    THEN ASSIGN nv_dss_per = 41.63.  
    ELSE IF wdetail.si = "160,000.00"    THEN ASSIGN nv_dss_per = 41.63.  
    ELSE IF wdetail.si = "170,000.00"    THEN ASSIGN nv_dss_per = 41.65.  
    ELSE IF wdetail.si = "180,000.00"    THEN ASSIGN nv_dss_per = 41.63.  
    ELSE IF wdetail.si = "190,000.00"    THEN ASSIGN nv_dss_per = 41.63.  
    ELSE IF wdetail.si = "200,000.00"    THEN ASSIGN nv_dss_per = 41.63.  
    ELSE IF wdetail.si = "210,000.00"    THEN ASSIGN nv_dss_per = 41.61.  
    ELSE IF wdetail.si = "220,000.00"    THEN ASSIGN nv_dss_per = 41.59.  
    ELSE IF wdetail.si = "230,000.00"    THEN ASSIGN nv_dss_per = 41.59.  
    ELSE IF wdetail.si = "240,000.00"    THEN ASSIGN nv_dss_per = 41.57.  
    ELSE IF wdetail.si = "250,000.00"    THEN ASSIGN nv_dss_per = 41.55. 
    ELSE IF wdetail.si = "260,000.00"    THEN ASSIGN nv_dss_per = 41.55.  
    ELSE IF wdetail.si = "270,000.00"    THEN ASSIGN nv_dss_per = 41.51.  
    ELSE IF wdetail.si = "280,000.00"    THEN ASSIGN nv_dss_per = 41.51.  
    ELSE IF wdetail.si = "290,000.00"    THEN ASSIGN nv_dss_per = 41.51.  
    ELSE IF wdetail.si = "300,000.00"    THEN ASSIGN nv_dss_per = 41.53.  
    ELSE IF wdetail.si = "310,000.00"    THEN ASSIGN nv_dss_per = 41.53.  
    ELSE IF wdetail.si = "320,000.00"    THEN ASSIGN nv_dss_per = 41.50.  
    ELSE IF wdetail.si = "330,000.00"    THEN ASSIGN nv_dss_per = 41.47.  
    ELSE IF wdetail.si = "340,000.00"    THEN ASSIGN nv_dss_per = 41.49.  
    ELSE IF wdetail.si = "350,000.00"    THEN ASSIGN nv_dss_per = 41.49.  
    ELSE IF wdetail.si = "360,000.00"    THEN ASSIGN nv_dss_per = 41.47.  
    ELSE IF wdetail.si = "370,000.00"    THEN ASSIGN nv_dss_per = 41.47.  
    ELSE IF wdetail.si = "380,000.00"    THEN ASSIGN nv_dss_per = 41.43.  
    ELSE IF wdetail.si = "390,000.00"    THEN ASSIGN nv_dss_per = 41.45.  
    ELSE IF wdetail.si = "400,000.00"    THEN ASSIGN nv_dss_per = 41.43.
    ELSE IF wdetail.si = "410,000.00"    THEN ASSIGN nv_dss_per = 41.43.  
    ELSE IF wdetail.si = "420,000.00"    THEN ASSIGN nv_dss_per = 41.43.  
    ELSE IF wdetail.si = "430,000.00"    THEN ASSIGN nv_dss_per = 41.43.  
    ELSE IF wdetail.si = "440,000.00"    THEN ASSIGN nv_dss_per = 41.40.  
    ELSE IF wdetail.si = "450,000.00"    THEN ASSIGN nv_dss_per = 41.40.  
    ELSE IF wdetail.si = "460,000.00"    THEN ASSIGN nv_dss_per = 41.42.  
    ELSE IF wdetail.si = "470,000.00"    THEN ASSIGN nv_dss_per = 41.41.  
    ELSE IF wdetail.si = "480,000.00"    THEN ASSIGN nv_dss_per = 41.37.  
    ELSE IF wdetail.si = "490,000.00"    THEN ASSIGN nv_dss_per = 41.37.  
    ELSE IF wdetail.si = "500,000.00"    THEN ASSIGN nv_dss_per = 41.39.
    /*end...add by kridtiya i. A54-0344....*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_findredbook c-win 
PROCEDURE proc_findredbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VAR nv_rsimin  AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_rsimax  AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_si      AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_si1     AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_oldsi   AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_simaxp  AS DECI FORMAT ">>9.99-" INIT 20.
DEFINE VAR nv_siminp  AS DECI FORMAT ">>9.99-" INIT 20.
DEFINE VAR nv_moddes1 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes2 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes3 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes4 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes5 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes6 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_count   AS INTE INIT 0.
DEFINE VAR rm_modcod  AS CHAR.
DEFINE VAR rm_moddes  AS CHAR FORMAT "X(60)".
DEFINE VAR nv_supe    AS LOGICAL .
DEFINE VAR nv_spcflg  AS CHAR.
DEFINE VAR n_tariff   AS CHAR .
DO:
    rm_modcod = "".
    nv_makdes = trim(wdetail.brand).
    nv_moddes = TRIM(wdetail.model).
    nv_si     = INT(wdetail.si).
    n_tariff  = IF wdetail.poltyp = "V70" THEN "X" ELSE "9" .
    FIND FIRST stat.makdes31 WHERE 
           makdes31.makdes = TRIM(n_tariff) AND 
           makdes31.moddes = trim(wdetail.prempa) + trim(wdetail.subclass)
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE makdes31 THEN DO:
    ASSIGN
        nv_simaxp = makdes31.si_theft_p 
        nv_siminp = makdes31.load_p.
    END.
    IF INDEX(nv_moddes," ")  <> 0 THEN nv_moddes1 = TRIM(SUBSTR(nv_moddes,1,R-INDEX(nv_moddes," ") - 1)).
    IF INDEX(nv_moddes1," ") <> 0 THEN nv_moddes2 = TRIM(SUBSTR(nv_moddes1,1,R-INDEX(nv_moddes1," ") - 1)).
    IF INDEX(nv_moddes2," ") <> 0 THEN nv_moddes3 = TRIM(SUBSTR(nv_moddes2,1,R-INDEX(nv_moddes2," ") - 1)).
    IF INDEX(nv_moddes3," ") <> 0 THEN nv_moddes4 = TRIM(SUBSTR(nv_moddes3,1,R-INDEX(nv_moddes3," ") - 1)).
    IF INDEX(nv_moddes4," ") <> 0 THEN nv_moddes5 = TRIM(SUBSTR(nv_moddes4,1,R-INDEX(nv_moddes4," ") - 1)).
    IF INDEX(nv_moddes5," ") <> 0 THEN nv_moddes6 = TRIM(SUBSTR(nv_moddes5,1,R-INDEX(nv_moddes5," ") - 1)).
    
    
    rm_modcod = "".
    nv_count  = 0.
    rm_moddes = nv_moddes.
    
    
    loop_modcod:
    REPEAT:
        nv_count = nv_count + 1.
    
        IF nv_count  = 1 THEN DO: 
            IF nv_moddes <> "" THEN rm_moddes = TRIM(nv_moddes). 
        END.
        ELSE IF nv_count  = 2 THEN DO: 
            IF nv_moddes1 <> "" THEN rm_moddes = TRIM(nv_moddes1).
        END.
        ELSE IF nv_count  = 3 THEN DO: 
            IF nv_moddes2 <> "" THEN rm_moddes = TRIM(nv_moddes2).
        END.
        ELSE IF nv_count  = 4 THEN DO: 
            IF nv_moddes3 <> "" THEN rm_moddes = TRIM(nv_moddes3).
        END.
        ELSE IF nv_count  = 5 THEN DO: 
            IF nv_moddes4 <> "" THEN rm_moddes = TRIM(nv_moddes4).
        END.
        ELSE IF nv_count  = 6 THEN DO: 
            IF nv_moddes5 <> "" THEN rm_moddes = TRIM(nv_moddes5).
        END.
        ELSE IF nv_count  = 7 THEN DO: 
            IF nv_moddes6 <> "" THEN rm_moddes = TRIM(nv_moddes6).
        END.
        ELSE IF nv_count >= 8 THEN LEAVE loop_modcod.
    
        
        FOR EACH stat.maktab_fil USE-INDEX maktab02 WHERE
                 maktab_fil.sclass  = trim(wdetail.subclass) AND
                 maktab_fil.makdes  = nv_makdes            AND
                 INDEX(maktab_fil.moddes,rm_moddes) <> 0   AND
                 maktab_fil.makyea <= INT(wdetail.caryear) AND
                 maktab_fil.engine >= INT(wdetail.cc) NO-LOCK:
    
            nv_rsimax = maktab_fil.si + ((maktab_fil.si * nv_simaxp) / 100).
            nv_rsimin = maktab_fil.si - ((maktab_fil.si * nv_siminp) / 100).
    
            IF nv_rsimin <= nv_si AND nv_rsimax >= nv_si THEN DO:
                IF (maktab_fil.si - nv_si ) > 0 THEN DO:
                   IF (maktab_fil.si) >= nv_si THEN DO:
                        rm_modcod = maktab_fil.modcod.
                        nv_supe   = maktab_fil.impchg.
    
                        IF nv_supe   = YES THEN nv_spcflg = "YES". ELSE nv_spcflg = "NO".
                        IF wdetail.cargrp = ""  THEN wdetail.cargrp = maktab_fil.prmpac.
                    END.
                END.
                ELSE DO:
                    IF (maktab_fil.si) <= nv_si THEN DO:
                        rm_modcod = maktab_fil.modcod.
                        nv_supe   = maktab_fil.impchg.
    
                        IF nv_supe   = YES THEN nv_spcflg = "YES". ELSE nv_spcflg = "NO".
                        IF wdetail.cargrp = ""  THEN wdetail.cargrp = maktab_fil.prmpac.
                    END.
                
                END.
            END.
        END.
    
        IF rm_modcod <> "" THEN LEAVE loop_modcod.
    END.

    wdetail.redbook  = rm_modcod .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam c-win 
PROCEDURE proc_insnam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_insname AS CHAR FORMAT "x(75)" .
DEF VAR n_nametax AS CHAR FORMAT "x(80)" .
DEF VAR n_taxno   AS CHAR FORMAT "x(13)" .

ASSIGN  
    n_insref     = ""       n_insname  = ""  /*A62-0219*/
    nv_messagein = ""       n_nametax  = ""  /*A62-0219*/
    nv_usrid     = ""       n_build    = "" /*A62-0219*/    
    nv_transfer  = NO       n_road     = "" /*A62-0219*/         
    n_check      = ""       n_tambon   = "" /*A62-0219*/    
    nv_insref    = ""       n_amper    = "" /*A62-0219*/         
    putchr       = ""       n_country  = "" /*A62-0219*/    
    putchr1      = ""       n_post     = "" /*A62-0219*/
    nv_typ       = ""  
    nv_usrid     = SUBSTRING(USERID(LDBNAME(1)),3,4) 
    nv_transfer  = YES.

IF wdetail.vatcode = "" AND index(wdetail.nmember,"ORICO") <> 0 THEN DO:
    IF wdetail.recaddr <> "" THEN RUN proc_addr.
    ASSIGN n_nametax =  TRIM(wdetail.recivename)
           n_taxno   =  TRIM(wdetail.rectax)
           n_build   =  TRIM(n_build) 
           n_tambon  =  trim(trim(n_road) + " " + trim(n_tambon))  
           n_amper   =  TRIM(TRIM(n_amper) + " " + trim(n_country))  
           n_post    =  TRIM(n_post).
END.
ELSE DO:
    ASSIGN n_nametax = ""
           n_taxno   = ""
           n_build   = ""
           n_tambon  = ""
           n_amper   = ""
           n_post    = "" .
END.

FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME   = TRIM(wdetail.insnam)  AND 
    /*sicsyac.xmm600.homebr = TRIM(wdetail.branch) NO-ERROR NO-WAIT.*/  /*a56-0047*/
    sicsyac.xmm600.homebr = TRIM(wdetail.branch)  AND                   /*a56-0047*/
    sicsyac.xmm600.clicod = "IN"                  NO-ERROR NO-WAIT.     /*a56-0047*/
IF NOT AVAILABLE sicsyac.xmm600 THEN DO:
    IF LOCKED sicsyac.xmm600 THEN DO:                           
        ASSIGN nv_transfer = NO 
            n_insref = sicsyac.xmm600.acno.
        RETURN.
    END.
    ELSE DO:
        ASSIGN 
            n_check   = "" 
            nv_insref = "".
        IF TRIM(wdetail.tiname) <> " " THEN DO: 
            IF  R-INDEX(TRIM(wdetail.tiname),"จก.")             <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"จำกัด")           <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"(มหาชน)")         <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บริษัท")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บ.")                <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บจก.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"หจก.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"หสน.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บรรษัท")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"มูลนิธิ")           <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้าง")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วน")      <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0  OR
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                INDEX(TRIM(wdetail.tiname),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
            ELSE nv_typ = "0s".   /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/
        END.
        ELSE DO:                  /* ---- Check ด้วย name ---- */
            IF  R-INDEX(TRIM(wdetail.tiname),"จก.")             <> 0  OR              
                R-INDEX(TRIM(wdetail.tiname),"จำกัด")           <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"(มหาชน)")         <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บริษัท")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บ.")                <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บจก.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"หจก.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"หสน.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บรรษัท")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"มูลนิธิ")           <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้าง")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วน")      <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0  OR
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                INDEX(TRIM(wdetail.tiname),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
            ELSE nv_typ = "0s".   /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/
        END.
        RUN proc_insno. 
        IF n_check <> "" THEN DO:
            ASSIGN nv_transfer = NO
                nv_insref   = "".
            RETURN.
        END.
        IF nv_insref <> "" THEN DO:
            loop_runningins:   /* Check Insured */
            REPEAT:
                FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                    sicsyac.xmm600.acno = CAPS(nv_insref)  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm600 THEN DO:
                    RUN proc_insno .
                    IF  n_check <> ""  THEN DO:   
                        ASSIGN nv_transfer = NO 
                            nv_insref   = "".
                        RETURN.
                    END.
                END.
                ELSE LEAVE loop_runningins.
            END.
            IF nv_insref <> "" THEN CREATE sicsyac.xmm600.
        END.
    END.
    n_insref = nv_insref.
END.
ELSE DO:
    IF sicsyac.xmm600.acno <> "" THEN DO: 
        ASSIGN nv_insref           = sicsyac.xmm600.acno 
            n_insref               = nv_insref 
            sicsyac.xmm600.ntitle  = TRIM(wdetail.tiname)  /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname   = ""                    /*First Name    */
            sicsyac.xmm600.name    = TRIM(wdetail.insnam)  /*Name Line 1   */
            sicsyac.xmm600.abname  = TRIM(wdetail.insnam)  /*Abbreviated Name*/
            sicsyac.xmm600.icno    = TRIM(wdetail.idno)    /*IC No.*//*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1   = TRIM(wdetail.iadd1)   /*Address line 1*/
            sicsyac.xmm600.addr2   = TRIM(wdetail.iadd2)   /*Address line 2*/
            sicsyac.xmm600.addr3   = TRIM(wdetail.iadd3)   /*Address line 3*/
            sicsyac.xmm600.addr4   = TRIM(wdetail.iadd4)   
            sicsyac.xmm600.homebr  = TRIM(wdetail.branch) 
            sicsyac.xmm600.usrid   = nv_usrid 
            /* add by A62-0219 */
            sicsyac.xmm600.nphone  = n_nametax 
            sicsyac.xmm600.naddr1  = n_build   
            sicsyac.xmm600.naddr2  = n_tambon  
            sicsyac.xmm600.naddr3  = n_amper   
            sicsyac.xmm600.naddr4  = n_post
            sicsyac.xmm600.anlyc1  = n_taxno  
            /* end A62-0219 */
            nv_transfer            = NO.                   /*-- Add chutikarn A50-0072 --*/
        IF INDEX(wdetail.birthday,"DOBEXP") <> 0 THEN  
            ASSIGN xmm600.dtyp20 = "DOBEXP"
            xmm600.dval20 = trim(substr(wdetail.birthday,7)).
        ELSE IF  (INDEX(wdetail.birthday,"EXP") <> 0) THEN  
            ASSIGN
            xmm600.dtyp20 = "EXP"
            xmm600.dval20 = trim(substr(wdetail.birthday,4)).
        ELSE IF (INDEX(wdetail.birthday,"DOB") <> 0) THEN
            ASSIGN
            xmm600.dtyp20 = "DOB"
            xmm600.dval20 = trim(substr(wdetail.birthday,4)).
        ELSE ASSIGN xmm600.dtyp20 = ""
            xmm600.dval20 = "".
    END.
END.
IF nv_transfer = YES THEN DO:
    ASSIGN
        sicsyac.xmm600.acno     = nv_insref                 /*Account no*/
        sicsyac.xmm600.gpstcs   = nv_insref                 /*Group A/C for statistics*/
        sicsyac.xmm600.gpage    = ""                        /*Group A/C for ageing*/
        sicsyac.xmm600.gpstmt   = ""                        /*Group A/C for Statement*/
        sicsyac.xmm600.or1ref   = ""                        /*OR Agent 1 Ref. No.*/
        sicsyac.xmm600.or2ref   = ""                        /*OR Agent 2 Ref. No.*/
        sicsyac.xmm600.or1com   = 0                         /*OR Agent 1 Comm. %*/
        sicsyac.xmm600.or2com   = 0                         /*OR Agent 2 Comm. %*/
        sicsyac.xmm600.or1gn    = "G"                       /*OR Agent 1 Gross/Net*/
        sicsyac.xmm600.or2gn    = "G"                       /*OR Agent 2 Gross/Net*/
        sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                        /*First Name*/
        sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
        sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
        sicsyac.xmm600.icno     = TRIM(wdetail.idno)        /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)       /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)       /*Address line 3*/
        sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4)       /*Address line 4*/
        sicsyac.xmm600.postcd   = ""                        /*Postal Code*/
        sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
        sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
        sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
        sicsyac.xmm600.opened   = TODAY                     /*Date A/C opened*/
        sicsyac.xmm600.prindr   = 1                         /*No. to print Dr/Cr N., default*/
        sicsyac.xmm600.langug   = ""                        /*Language Code*/
        sicsyac.xmm600.cshdat   = ?                         /*Cash terms wef date*/
        sicsyac.xmm600.legal    = ""                        /*Legal action pending/closed*/
        sicsyac.xmm600.stattp   = "I"                       /*Statement type I/B/N*/
        sicsyac.xmm600.autoap   = NO                        /*Automatic cash matching*/
        sicsyac.xmm600.ltcurr   = "BHT"                     /*Credit limit currency*/
        sicsyac.xmm600.ltamt    = 0                         /*Credit limit amount*/
        sicsyac.xmm600.exec     = ""                        /*Executive responsible*/
        sicsyac.xmm600.cntry    = "TH"                      /*Country code*/
        sicsyac.xmm600.phone    = ""                        /*Phone no.*/
        sicsyac.xmm600.closed   = ?                         /*Date A/C closed*/
        sicsyac.xmm600.crper    = 0                         /*Credit period*/
        sicsyac.xmm600.pvfeq    = 0                         /*PV frequency/Type code*/
        sicsyac.xmm600.comtab   = 1                         /*Commission table no*/
        sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid                 /*Userid*/
        sicsyac.xmm600.regagt   = ""                       /*Registered agent code*/
        sicsyac.xmm600.agtreg   = ""                       /*Agents Registration/Licence No*/
        sicsyac.xmm600.debtyn   = YES                      /*Permit debtor trans Y/N*/
        sicsyac.xmm600.crcon    = NO                       /*Credit Control Report*/
        sicsyac.xmm600.muldeb   = NO                       /*Multiple Debtors Acc.*/
        sicsyac.xmm600.styp20   = ""                       /*Statistic Type Codes (4 x 20)*/
        sicsyac.xmm600.sval20   = ""                       /*Statistic Value Codes (4 x 20)*/
        sicsyac.xmm600.dtyp20   = ""                       /*Type of Date Codes (2 X 20)*/
        sicsyac.xmm600.dval20   = ""                       /*Date Values (8 X 20)*/
        sicsyac.xmm600.iblack   = ""                       /*Insured Black List Code*/
        sicsyac.xmm600.oldic    = ""                       /*Old IC No.*/
        sicsyac.xmm600.cardno   = ""                       /*Credit Card Account No.*/
        sicsyac.xmm600.cshcrd   = ""                       /*Cash(C)/Credit(R) Agent*/
        sicsyac.xmm600.naddr1   = n_build  /*A62-0219*/    /*New address line 1*/
        sicsyac.xmm600.gstreg   = ""                       /*GST Registration No.*/
        sicsyac.xmm600.naddr2   = n_tambon /*A62-0219*/    /*New address line 2*/
        sicsyac.xmm600.fax      = ""                       /*Fax No.*/
        sicsyac.xmm600.naddr3   = n_amper  /*a62-0219*/    /*New address line 3*/
        sicsyac.xmm600.telex    = ""                       /*Telex No.*/
        sicsyac.xmm600.naddr4   = n_post   /*a62-0219*/    /*New address line 4*/
        sicsyac.xmm600.name2    = ""                       /*Name Line 2*/
        sicsyac.xmm600.npostcd  = ""                       /*New postal code*/
        sicsyac.xmm600.name3    = ""                       /*Name Line 3*/
        sicsyac.xmm600.nphone   = n_nametax  /*A62-0219*/  /*New phone no.*/    
        sicsyac.xmm600.nachg    = YES                      /*Change N&A on Renewal/Endt*/
        sicsyac.xmm600.regdate  = ?                        /*Agents registration Date*/
        sicsyac.xmm600.alevel   = 0                        /*Agency Level*/
        sicsyac.xmm600.taxno    = ""                       /*Agent tax no.*/
        sicsyac.xmm600.anlyc1   = n_taxno  /*A62-0219*/    /*Analysis Code 1*/
        sicsyac.xmm600.taxdate  = ?                        /*Agent tax date*/
        sicsyac.xmm600.anlyc5   =  "" .                    /*Analysis Code 5*/
    IF INDEX(wdetail.birthday,"DOBEXP") <> 0 THEN  
            ASSIGN xmm600.dtyp20 = "DOBEXP"
            xmm600.dval20 = trim(substr(wdetail.birthday,7)).
        ELSE IF  (INDEX(wdetail.birthday,"EXP") <> 0) THEN  
            ASSIGN
            xmm600.dtyp20 = "EXP"
            xmm600.dval20 = trim(substr(wdetail.birthday,4)).
        ELSE IF (INDEX(wdetail.birthday,"DOB") <> 0) THEN
            ASSIGN
            xmm600.dtyp20 = "DOB"
            xmm600.dval20 = trim(substr(wdetail.birthday,4)).
        ELSE ASSIGN xmm600.dtyp20 = ""
            xmm600.dval20 = "".
END.
IF sicsyac.xmm600.acno <> "" THEN DO:  
    ASSIGN nv_insref = sicsyac.xmm600.acno 
        nv_transfer = YES.
    FIND sicsyac.xtm600 WHERE
        sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xtm600 THEN DO:
        IF LOCKED sicsyac.xtm600 THEN DO:
            nv_transfer = NO.
            RETURN.
        END.
        ELSE DO:
            CREATE sicsyac.xtm600.
        END.
    END.
END.
IF nv_transfer = YES THEN DO:
    ASSIGN
        sicsyac.xtm600.acno    = nv_insref               /*Account no.*/
        sicsyac.xtm600.name    = TRIM(wdetail.insnam)    /*Name of Insured Line 1*/
        sicsyac.xtm600.abname  = TRIM(wdetail.insnam)    /*Abbreviated Name*/
        sicsyac.xtm600.addr1   = TRIM(wdetail.iadd1)     /*address line 1*/
        sicsyac.xtm600.addr2   = TRIM(wdetail.iadd2)     /*address line 2*/
        sicsyac.xtm600.addr3   = TRIM(wdetail.iadd3)     /*address line 3*/
        sicsyac.xtm600.addr4   = TRIM(wdetail.iadd4)     /*address line 4*/
        sicsyac.xtm600.name2   = ""                      /*Name of Insured Line 2*/
        sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)    /*Title*/
        sicsyac.xtm600.name3   = ""                      /*Name of Insured Line 3*/
        sicsyac.xtm600.fname   = "" .                    /*First Name*/
END.
ASSIGN wdetail.birthday = "".
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
/*RETURN.
HIDE MESSAGE NO-PAUSE.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam2 c-win 
PROCEDURE proc_insnam2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Add by Kridtiya i. A63-0472*/
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno     =  nv_insref   NO-ERROR NO-WAIT.  
IF AVAIL sicsyac.xmm600 THEN
    ASSIGN
    sicsyac.xmm600.acno_typ  = wdetail.insnamtyp   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    sicsyac.xmm600.icno      = trim(wdetail.idno)       
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/   .  
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN
    ASSIGN 
    sicsyac.xtm600.postcd    = trim(wdetail.postcd)        
    sicsyac.xtm600.firstname = trim(wdetail.firstName)     
    sicsyac.xtm600.lastname  = trim(wdetail.lastName)  .   
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xtm600.
/*Add by Kridtiya i. A63-0472*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insno c-win 
PROCEDURE proc_insno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_search   AS LOGICAL INIT YES .
DEF VAR nv_lastno  AS INT. 
DEF VAR nv_seqno   AS INT.  
ASSIGN nv_insref = "" .
FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
    sicsyac.xzm056.seqtyp   =  nv_typ          AND
    sicsyac.xzm056.branch   =  wdetail.branch  NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN  sicsyac.xzm056.seqtyp =  nv_typ
            sicsyac.xzm056.branch     =  wdetail.branch
            sicsyac.xzm056.des        =  "Personal/Start"
            sicsyac.xzm056.lastno     =  1.    
    END.
    ELSE DO:
        ASSIGN
            nv_insref = wdetail.branch + String(1,"999999")
            nv_lastno  =    1.
        RETURN.
    END.
END.
ASSIGN nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 

IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(wdetail.branch) = 2 THEN
            nv_insref = wdetail.branch + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:   
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + wdetail.branch + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       wdetail.branch + STRING(sicsyac.xzm056.lastno + 1 ,"999999").*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.branch) = "A") OR (TRIM(wdetail.branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail.branch) = "A") OR (TRIM(wdetail.branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END. 
        END. 
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  wdetail.branch
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(wdetail.branch) = 2 THEN
            nv_insref = wdetail.branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       wdetail.branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").
        END.   
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  wdetail.branch
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(wdetail.branch) = 2 THEN
            nv_insref = wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       wdetail.branch + STRING(sicsyac.xzm056.lastno,"999999").*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.branch) = "A") OR (TRIM(wdetail.branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail.branch) = "A") OR (TRIM(wdetail.branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.
        END.
    END.
    ELSE DO:
        IF LENGTH(wdetail.branch) = 2 THEN
            nv_insref = wdetail.branch + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.branch + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       wdetail.branch + "C" + String(sicsyac.xzm056.lastno,"99999").
        END.
    END.   
END.
IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno Then Do :
    /*MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
        "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
        "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. */
    ASSIGN n_check = "ERROR".
    RETURN. 
END.         /*lastno > seqno*/                       
ELSE DO :    /*lastno <= seqno */
    IF nv_typ = "0s" THEN DO:
        IF n_search = YES THEN DO:
            CREATE sicsyac.xzm056.
            ASSIGN
                sicsyac.xzm056.seqtyp    =  nv_typ
                sicsyac.xzm056.branch    =  wdetail.branch
                sicsyac.xzm056.des       =  "Personal/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno.   
        END.
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF n_search = YES THEN DO:
            CREATE sicsyac.xzm056.
            ASSIGN
                sicsyac.xzm056.seqtyp    =  nv_typ
                sicsyac.xzm056.branch    =  wdetail.branch
                sicsyac.xzm056.des       =  "Company/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno. 
        END.
    END.
END.        /*lastno <= seqno */                                  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_mailtxt c-win 
PROCEDURE proc_mailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR no_policy   AS CHAR FORMAT "x(12)" .
DEF VAR no_rencnt   AS CHAR FORMAT "99".
DEF VAR no_endcnt   AS CHAR FORMAT "999".
DEF VAR no_riskno   AS CHAR FORMAT "999".
DEF VAR no_itemno   AS CHAR FORMAT "999".
DEF VAR no_dbirth1  AS CHAR .
DEF VAR no_dbirth2  AS CHAR .
DEF VAR NO_NAME01   AS CHAR INIT "" FORMAT "x(50)" .
DEF VAR NO_NAME02   AS CHAR INIT "" FORMAT "x(50)" .
DEF VAR NO_occup01  AS CHAR INIT "" FORMAT "x(50)" .
DEF VAR NO_occup02  AS CHAR INIT "" FORMAT "x(50)" .
DEF VAR NO_sex01    AS CHAR INIT "" FORMAT "x(6)" .
DEF VAR NO_sex02    AS CHAR INIT "" FORMAT "x(6)" .
ASSIGN 
    no_policy   = sic_bran.uwm301.policy 
    no_rencnt   = STRING(sic_bran.uwm301.rencnt,"99")  
    no_endcnt   = STRING(sic_bran.uwm301.endcnt,"999")  
    nv_batchyr  = sic_bran.uwm130.bchyr 
    nv_batchno  = sic_bran.uwm130.bchno 
    nv_batcnt   = sic_bran.uwm130.bchcnt
    no_riskno   = "001" 
    no_itemno   = "001"
    NO_occup01  = ""
    NO_occup02  = ""
    NO_sex01    = ""
    NO_sex02    = ""
    nv_lnumber  =   1
    NO_NAME01   = ""
    NO_NAME02   = ""
    NO_occup01  = ""
    NO_occup02  = ""
    NO_sex01    = ""
    NO_sex02    = ""
    NO_NAME01   =  IF INDEX(wdetail.drivname1,"sex") <> 0 THEN SUBSTRING(wdetail.drivname1,1,INDEX(wdetail.drivname1,"sex") - 1) ELSE ""
    NO_NAME02   =  IF INDEX(wdetail.drivname2,"sex") <> 0 THEN SUBSTRING(wdetail.drivname2,1,INDEX(wdetail.drivname2,"sex") - 1) ELSE ""
    NO_occup01  =  IF INDEX(wdetail.drivname1,"occup:") <> 0 THEN  SUBSTRING(wdetail.drivname1,INDEX(wdetail.drivname1,"occup:") + 6  ) ELSE ""
    NO_occup02  =  IF INDEX(wdetail.drivname2,"occup:") <> 0 THEN SUBSTRING(wdetail.drivname2,INDEX(wdetail.drivname2,"occup:") + 6  )  ELSE ""
    NO_sex01    =  IF INDEX(wdetail.drivname1,"FEMALE") <> 0 THEN "FEMALE" ELSE "MALE"
    NO_sex02    =  IF INDEX(wdetail.drivname2,"FEMALE") <> 0 THEN "FEMALE" ELSE "MALE"  .
                                                                                
  IF wdetail.drivname1 <> " " THEN 
      ASSIGN no_dbirth1      = SUBSTRING(wdetail.drivname1,INDEX(wdetail.drivname1,"hbd:") + 4,10).
  IF wdetail.drivname2 <> " " THEN
      no_dbirth2       = SUBSTRING(wdetail.drivname2,INDEX(wdetail.drivname2,"hbd:") + 4,10).
  ASSIGN 
      nv_drivage1 =  (YEAR(TODAY) + 543 ) - INT(SUBSTR(no_dbirth1,7,4))   
      nv_drivage2 =  (YEAR(TODAY) + 543 ) - INT(SUBSTR(no_dbirth2,7,4)).

  FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
      brstat.mailtxt_fil.policy  = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  +
                                                       string(sic_bran.uwm301.itemno)  AND
      brstat.mailtxt_fil.bchyr   = nv_batchyr   AND                                               
      brstat.mailtxt_fil.bchno   = nv_batchno   AND
      brstat.mailtxt_fil.bchcnt  = nv_batcnt    NO-LOCK  NO-ERROR  NO-WAIT.
  IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.  
  
  FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
      brstat.mailtxt_fil.policy  = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  +
                                                       string(sic_bran.uwm301.itemno)     AND
      brstat.mailtxt_fil.lnumber = nv_lnumber      AND
      brstat.mailtxt_fil.bchyr   = nv_batchyr      AND                                               
      brstat.mailtxt_fil.bchno   = nv_batchno      AND
      brstat.mailtxt_fil.bchcnt  = nv_batcnt         NO-ERROR  NO-WAIT.
  IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
      CREATE brstat.mailtxt_fil.
      ASSIGN 
          brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt + no_riskno + no_itemno 
          brstat.mailtxt_fil.lnumber   = nv_lnumber 
          brstat.mailtxt_fil.ltext     = NO_NAME01 + FILL(" ",50 - LENGTH(NO_NAME01)) + NO_sex01 
          brstat.mailtxt_fil.ltext2    = no_dbirth1 + "  " + string(nv_drivage1) 
          nv_drivno                    = 1
          brstat.mailtxt_fil.bchyr    = nv_batchyr 
          brstat.mailtxt_fil.bchno    = nv_batchno 
          brstat.mailtxt_fil.bchcnt   = nv_batcnt 
          SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = IF NO_occup01 = "" THEN "-" ELSE NO_occup01 .  
                                                                                        
      IF wdetail.drivname2 <> "" THEN DO:
          CREATE brstat.mailtxt_fil. 
          ASSIGN
              brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt + no_riskno + no_itemno
              brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
              brstat.mailtxt_fil.ltext    = NO_NAME02 + FILL(" ",50 - LENGTH(NO_NAME02)) + NO_sex02
              brstat.mailtxt_fil.ltext2   = no_dbirth2 + "  " + string(nv_drivage2) 
              nv_drivno                   = 2
              brstat.mailtxt_fil.bchyr = nv_batchyr 
              brstat.mailtxt_fil.bchno    = nv_batchno 
              brstat.mailtxt_fil.bchcnt   = nv_batcnt 
              SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = IF NO_occup02 = "" THEN "-" ELSE NO_occup02    .  /*note add on 02/11/2006*/ 
      END.   /*drivnam2 <> " " */
  END.
  ELSE  DO:
      CREATE  brstat.mailtxt_fil.
      ASSIGN  brstat.mailtxt_fil.policy     = no_policy + no_rencnt + no_endcnt + no_riskno + no_itemno
          brstat.mailtxt_fil.lnumber    = nv_lnumber
          brstat.mailtxt_fil.ltext      = NO_NAME01 + FILL(" ",50 - LENGTH(NO_NAME01)) + NO_sex01.
          brstat.mailtxt_fil.ltext2     = no_dbirth1 + "  " +  TRIM(string(nv_drivage1)).
      IF wdetail.drivname2 <> "" THEN DO:
          CREATE  brstat.mailtxt_fil.
          ASSIGN
              brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt + no_riskno + no_itemno
              brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
              brstat.mailtxt_fil.ltext    = NO_NAME02 + FILL(" ",50 - LENGTH(NO_NAME02)) + NO_sex02. 
          brstat.mailtxt_fil.ltext2   = no_dbirth2 + "  " + TRIM(string(nv_drivage1)).
          ASSIGN  
              brstat.mailtxt_fil.bchyr = nv_batchyr 
              brstat.mailtxt_fil.bchno = nv_batchno 
              brstat.mailtxt_fil.bchcnt  = nv_batcnt 
              SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = IF NO_occup02 = "" THEN "-" ELSE NO_occup02    . /*note add on 02/11/2006*/
      END.   /*drivnam2 <> " " */
  END.    /*Else DO*/
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab c-win 
PROCEDURE proc_maktab :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_model AS CHAR FORMAT "x(50)" INIT "".
ASSIGN
    nv_model = ""
    nv_model = wdetail.model 
    nv_simat = 0
    nv_simat1 = 0
    nv_simat = (DECI(wdetail.si) * 50 / 100 )
    nv_simat1 = DECI(wdetail.si) + nv_simat .
IF INDEX(wdetail.model," ") <> 0 THEN 
    wdetail.model = SUBSTR(nv_model,1,INDEX(nv_model," ")).

Find FIRST stat.maktab_fil Use-index      maktab04          Where
    stat.maktab_fil.makdes   =     wdetail.brand            And                  
    index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
    /*stat.maktab_fil.engine   =     Integer(wdetail.cc)    AND*/
    stat.maktab_fil.sclass    =     wdetail.subclass        AND
    (stat.maktab_fil.si      >=     nv_simat                OR
     stat.maktab_fil.si      <=     nv_simat1 )             AND  
     stat.maktab_fil.seats    =     INTEGER(wdetail.seat)   
    No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    Assign
        wdetail.redbook         =  stat.maktab_fil.modcod  
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        wdetail.body            =  stat.maktab_fil.body 
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.seats   =  stat.maktab_fil.seats .
IF wdetail.redbook  =  "" THEN DO:
    Find FIRST stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =     wdetail.brand              And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0          And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear)   AND
        /*stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND*/
        /*stat.maktab_fil.sclass   =     wdetail.subclass           AND*/
        (stat.maktab_fil.si       >=     nv_simat                  OR
         stat.maktab_fil.si       <=     nv_simat1 )             AND  
         stat.maktab_fil.seats    =     INTEGER(wdetail.seat)   
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
            wdetail.redbook         =  stat.maktab_fil.modcod  
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp          =  stat.maktab_fil.prmpac
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            wdetail.body            =  stat.maktab_fil.body 
            sic_bran.uwm301.body    =  stat.maktab_fil.body
            sic_bran.uwm301.seats   =  stat.maktab_fil.seats  .
    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchtypins c-win 
PROCEDURE proc_matchtypins :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER  np_title      as char init "".
DEFINE INPUT  PARAMETER  np_name1      as char init "".
DEFINE OUTPUT PARAMETER  np_insnamtyp  as char init "".
DEFINE OUTPUT PARAMETER  np_firstName  as char init "".
DEFINE OUTPUT PARAMETER  np_lastName   as char init "".
DEFINE VAR               np_textname   AS CHAR INIT "".
ASSIGN np_textname = TRIM(np_title) + TRIM(np_name1).
IF  R-INDEX(TRIM(np_textname),"จก.")             <> 0  OR              
    R-INDEX(TRIM(np_textname),"จำกัด")           <> 0  OR  
    R-INDEX(TRIM(np_textname),"(มหาชน)")         <> 0  OR  
    R-INDEX(TRIM(np_textname),"INC.")            <> 0  OR 
    R-INDEX(TRIM(np_textname),"CO.")             <> 0  OR 
    R-INDEX(TRIM(np_textname),"LTD.")            <> 0  OR 
    R-INDEX(TRIM(np_textname),"LIMITED")         <> 0  OR 
    INDEX(TRIM(np_textname),"บริษัท")            <> 0  OR 
    INDEX(TRIM(np_textname),"บ.")                <> 0  OR 
    INDEX(TRIM(np_textname),"บจก.")              <> 0  OR 
    INDEX(TRIM(np_textname),"หจก.")              <> 0  OR 
    INDEX(TRIM(np_textname),"หสน.")              <> 0  OR 
    INDEX(TRIM(np_textname),"บรรษัท")            <> 0  OR 
    INDEX(TRIM(np_textname),"มูลนิธิ")           <> 0  OR 
    INDEX(TRIM(np_textname),"ห้าง")              <> 0  OR 
    INDEX(TRIM(np_textname),"ห้างหุ้นส่วน")      <> 0  OR 
    INDEX(TRIM(np_textname),"ห้างหุ้นส่วนจำกัด") <> 0  OR
    INDEX(TRIM(np_textname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
    INDEX(TRIM(np_textname),"และ/หรือ")          <> 0  THEN DO: 
    /*  Cs = นิติบุคคล */
    ASSIGN
        np_insnamtyp   = "CO"
        np_firstName   = TRIM(np_name1)
        np_lastName    = "".
END.
ELSE DO:
    np_insnamtyp   = "PR".
    IF INDEX(trim(np_name1)," ") <> 0 THEN
        ASSIGN
        np_firstName  = substr(TRIM(np_name1),1,INDEX(trim(np_name1)," ")) 
        np_lastName   = substr(TRIM(np_name1),INDEX(trim(np_name1)," ")) .
    ELSE ASSIGN       
        np_firstName  = TRIM(np_name1)
        np_lastName   = "".          
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open c-win 
PROCEDURE proc_open :
/*OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y".   */
OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policy c-win 
PROCEDURE proc_policy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
DEF VAR nv_stk70    AS CHAR FORMAT "x(15)" INIT "".
DEF VAR nv_vatname  AS CHAR FORMAT "x(60)" INIT "" .
/*DEF VAR n_nameno AS INTE .*/
ASSIGN nv_vatname = ""
    fi_show = "Check data Premium at cedingpol and create policy......" .
DISP fi_show WITH FRAM fr_main.
IF wdetail.poltyp = "v70" THEN 
    ASSIGN nv_stk70 = wdetail.stk
    wdetail.stk = "".
IF wdetail.policy <> "" THEN DO:
    IF wdetail.stk  <>  ""  THEN DO: 
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
           /* sicuw.uwm100.cedpol =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.*//*A55-0046*/
            sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.    /*A55-0046*/
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ((sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ?) OR (sicuw.uwm100.releas = YES)) AND
                (sicuw.uwm100.poltyp =  wdetail.poltyp) THEN 
                ASSIGN wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.
        ASSIGN nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.       /*  wdetail.stk  <>  "" .......  */
    ELSE DO:   /*  sticker = ""                 */ 
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            /* sicuw.uwm100.cedpol =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.*//*A55-0046*/
            sicuw.uwm100.policy = wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.     /*A55-0046*/
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ((sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ?) OR (sicuw.uwm100.releas = YES)) AND
                (sicuw.uwm100.poltyp =  wdetail.poltyp) THEN 
                /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว " VIEW-AS ALERT-BOX.*/ 
                    ASSIGN                               
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            IF wdetail.policy = "" THEN DO:
                RUN proc_temppolicy.
                wdetail.policy  = nv_tmppol.
            END.
            RUN proc_create100. 
        END.   /*policy <> "" & stk = ""*/                 
        ELSE RUN proc_create100.   
    END.
END.
ELSE DO:  /*wdetail.policy = ""*/
    IF wdetail.stk  <>  ""  THEN DO:
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            /* sicuw.uwm100.cedpol =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.*//*A55-0046*/
            sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.     /*A55-0046*/
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ((sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ?) OR (sicuw.uwm100.releas = YES)) AND
                (sicuw.uwm100.poltyp =  wdetail.poltyp) THEN  
                    ASSIGN
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
             
        END.   
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN                               
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
/*      END. /*uwm100*/ kridtiyai  ..*/
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END. /*wdetail.stk  <>  ""*/
    ELSE DO:  /*policy = "" and comp_sck = ""  */       
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.
END.
s_recid1  =  Recid(sic_bran.uwm100).
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = wdetail.poltyp  NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL  sicsyac.xmm031 THEN DO:
     nv_dept = sicsyac.xmm031.dept.
END.
IF wdetail.poltyp = "V70"  AND wdetail.Docno <> ""  THEN 
    ASSIGN 
    nv_docno  = wdetail.Docno
    nv_accdat = TODAY.
ELSE DO:
   IF wdetail.docno  = "" THEN nv_docno  = "".
   IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END. 
IF wdetail.tiname = " " THEN wdetail.tiname = "คุณ".
ELSE DO:
    FIND FIRST brstat.msgcode WHERE 
        brstat.msgcode.compno  = "999" AND
        brstat.msgcode.MsgDesc = wdetail.tiname   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN  wdetail.tiname  =  trim(brstat.msgcode.branch).
    ELSE wdetail.tiname = "คุณ".
END.
IF trim(wdetail.vatcode) <> "" THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
        sicsyac.xmm600.acno  =  trim(wdetail.vatcode)   NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN  ASSIGN nv_vatname = "".
    ELSE  ASSIGN  nv_vatname =  "และ/หรือ " + TRIM(sicsyac.xmm600.ntitle) + " "  + TRIM(sicsyac.xmm600.name).
END.
/*IF wdetail.prepol = "" THEN n_firstdat = wdetail.comdat.*/
IF DECI(substr(wdetail.comdat,7,4)) > (YEAR(TODAY) + 2)  THEN
    wdetail.comdat = substr(wdetail.comdat,1,6) + STRING(DECI(substr(wdetail.comdat,7,4)) - 543).
IF DECI(substr(wdetail.expdat,7,4)) > (YEAR(TODAY) + 3)  THEN
    wdetail.expdat = substr(wdetail.expdat,1,6) + STRING(DECI(substr(wdetail.expdat,7,4)) - 543).
ASSIGN  n_firstdat = wdetail.comdat.

/*comment by kridtiya i. /*A56-0024*/
IF R-INDEX(wdetail.tiname,".") <> 0 THEN 
    wdetail.tiname = SUBSTR(wdetail.tiname,R-INDEX(wdetail.tiname,".")).*/
/*IF      trim(wdetail.branch) = ""  THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0268 ....*/
ELSE IF trim(wdetail.branch) = "A" THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0268 ....*/
ELSE IF trim(wdetail.branch) = "B" THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0268 ....*/
ELSE RUN proc_insnam.   /*Add kridtiya i. A55-0257 ....*/
comment by kridtiya i. /*A56-0024*/ */ 
RUN proc_insnam.       /*A56-0024*/
RUN proc_insnam2 .     /*Add by Kridtiya i. A63-0472*/
DO TRANSACTION:
   ASSIGN
      /*wdetail.comdat =  SUBSTR(wdetail.comdat,1,6) + STRING(INTE(SUBSTR(wdetail.comdat,7,4)) - 543 )
      wdetail.expdat =  SUBSTR(wdetail.expdat,1,6) + STRING(INTE(SUBSTR(wdetail.expdat,7,4)) - 543 )*/
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = wdetail.poltyp
      sic_bran.uwm100.insref = trim(nv_insref)
      /*sic_bran.uwm100.opnpol = ""*/
      sic_bran.uwm100.anam2  = trim(wdetail.idno)       /* ICNO  Cover Note A51-0071 Amparat */
      sic_bran.uwm100.occupn = trim(wdetail.occupins)
      sic_bran.uwm100.ntitle = trim(wdetail.tiname)     /*"คุณ" */ /*kridtiya i. A54-0203    */           
      sic_bran.uwm100.name1  = TRIM(wdetail.insnam)  
      /*sic_bran.uwm100.name2  = ""*/
      sic_bran.uwm100.name2  = IF nv_vatname = "" THEN trim(wdetail.namedirect) 
                               ELSE TRIM(trim(wdetail.namedirect) + " " + nv_vatname)  /*A55-0257*/ 
      sic_bran.uwm100.name3  = "" 
      sic_bran.uwm100.addr1  = trim(wdetail.iadd1)  
      sic_bran.uwm100.addr2  = trim(wdetail.iadd2)  
      sic_bran.uwm100.addr3  = trim(wdetail.iadd3)  
      sic_bran.uwm100.addr4  = trim(wdetail.iadd4)
      sic_bran.uwm100.postcd =  "" 
      sic_bran.uwm100.undyr  = String(Year(today),"9999")   /*   nv_undyr  */
      sic_bran.uwm100.branch = caps(trim(wdetail.branch))   /* nv_branch   */                        
      sic_bran.uwm100.dept   = nv_dept
      sic_bran.uwm100.usrid  = USERID(LDBNAME(1))
      sic_bran.uwm100.fstdat = date(n_firstdat)         
      sic_bran.uwm100.comdat = DATE(wdetail.comdat) 
      sic_bran.uwm100.expdat = date(wdetail.expdat) 
      sic_bran.uwm100.accdat = nv_accdat                    
      sic_bran.uwm100.tranty = "N"                          /*Transaction Type (N/R/E/C/T)*/
      sic_bran.uwm100.langug = "T"
      sic_bran.uwm100.acctim = "00:00"
      sic_bran.uwm100.trty11 = "M"      
      sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")     
      sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")
      sic_bran.uwm100.entdat = TODAY
      sic_bran.uwm100.curbil = "BHT"
      sic_bran.uwm100.curate = 1
      sic_bran.uwm100.instot = 1
      sic_bran.uwm100.prog   = "wgwpogen"
      sic_bran.uwm100.cntry  = "TH"        /*Country where risk is situated*/
      sic_bran.uwm100.insddr = YES         /*Print Insd. Name on DrN       */
      sic_bran.uwm100.no_sch = 0           /*No. to print, Schedule        */
      sic_bran.uwm100.no_dr  = 1           /*No. to print, Dr/Cr Note      */
      sic_bran.uwm100.no_ri  = 0           /*No. to print, RI Appln        */
      sic_bran.uwm100.no_cer = 0           /*No. to print, Certificate     */
      sic_bran.uwm100.li_sch = YES         /*Print Later/Imm., Schedule    */
      sic_bran.uwm100.li_dr  = YES         /*Print Later/Imm., Dr/Cr Note  */
      sic_bran.uwm100.li_ri  = YES         /*Print Later/Imm., RI Appln,   */
      sic_bran.uwm100.li_cer = YES         /*Print Later/Imm., Certificate */
      sic_bran.uwm100.apptax = YES         /*Apply risk level tax (Y/N)    */
      sic_bran.uwm100.recip  = "N"         /*Reciprocal (Y/N/C)            */
      sic_bran.uwm100.short  = NO
      sic_bran.uwm100.acno1  = trim(wdetail.producer)   /*  nv_acno1 */   
      sic_bran.uwm100.agent  = trim(wdetail.agent)      /*nv_agent   */   
      sic_bran.uwm100.insddr = NO
      sic_bran.uwm100.coins  = NO
      sic_bran.uwm100.billco = ""
      sic_bran.uwm100.fptr01 = 0        sic_bran.uwm100.bptr01 = 0
      sic_bran.uwm100.fptr02 = 0        sic_bran.uwm100.bptr02 = 0
      sic_bran.uwm100.fptr03 = 0        sic_bran.uwm100.bptr03 = 0
      sic_bran.uwm100.fptr04 = 0        sic_bran.uwm100.bptr04 = 0
      sic_bran.uwm100.fptr05 = 0        sic_bran.uwm100.bptr05 = 0
      sic_bran.uwm100.fptr06 = 0        sic_bran.uwm100.bptr06 = 0  
      sic_bran.uwm100.styp20 = "NORM"
      sic_bran.uwm100.dir_ri =   YES
      sic_bran.uwm100.drn_p =  NO
      sic_bran.uwm100.sch_p =  NO
      sic_bran.uwm100.cr_2  =  nc_r2
      sic_bran.uwm100.cr_1  =  wdetail.product
      sic_bran.uwm100.bchyr   = nv_batchyr          
      sic_bran.uwm100.bchno   = nv_batchno          
      sic_bran.uwm100.bchcnt  = nv_batcnt           
      sic_bran.uwm100.prvpol  = ""       /*wdetail.prepol */    
      sic_bran.uwm100.cedpol  = trim(wdetail.cedpol)
      sic_bran.uwm100.opnpol  = IF SUBSTR(wdetail.nmember2,1) = "-" THEN SUBSTR(wdetail.nmember2,r-index(wdetail.nmember2,":") + 1)
                                ELSE  SUBSTR(wdetail.nmember2,1,index(wdetail.nmember2,"-") - 1) + " " +
                                      SUBSTR(wdetail.nmember2,R-INDEX(wdetail.nmember2,":") + 1 ) 
      /*sic_bran.uwm100.finint  = trim(wdetail.deler)*/ /*A56-0024 */ /*A62-0219*/
      sic_bran.uwm100.finint     = IF index(wdetail.nmember,"ORICO") <> 0 THEN "" ELSE trim(wdetail.deler)  /*A62-0219*/
      sic_bran.uwm100.dealer     = wdetail.financecd        /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.bs_cd      = trim(wdetail.vatcode)      /*vat code */ /*A55-0046*/
      sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)  /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)   /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.postcd     = trim(wdetail.postcd)     /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.icno       = trim(wdetail.idno)       /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)    /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)   /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)   /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)   /*Add by Kridtiya i. A63-0472*/
      /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*/   /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov).  /*Add by Kridtiya i. A63-0472*/

      IF index(wdetail.nmember,"ORICO") <> 0 AND index(wdetail.nmember2,".") <> 0 THEN DO:
         ASSIGN sic_bran.uwm100.opnpol  = trim(SUBSTR(wdetail.nmember2,1,INDEX(wdetail.nmember2,"-") - 1)) + " " + 
                                          trim(SUBSTR(wdetail.nmember2,r-index(wdetail.nmember2,".") + 2)).
      END.
      
   IF wdetail.pass = "Y" THEN
     sic_bran.uwm100.impflg  = YES.
   ELSE 
     sic_bran.uwm100.impflg  = NO.
   IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN 
      sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
   IF wdetail.cancel = "ca" THEN
      sic_bran.uwm100.polsta = "CA" .
   ELSE  
      sic_bran.uwm100.polsta = "IF".
   IF fi_loaddat <> ? THEN
      sic_bran.uwm100.trndat = fi_loaddat.
   ELSE
      sic_bran.uwm100.trndat = TODAY.
   sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
   nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                     (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                     (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                 ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.                    
END.  /*transaction*/

IF wdetail.poltyp = "v70" THEN DO:
    /*IF wdetail.product <> "" THEN DO:*/ /*A62-0219*/
    IF trim(wdetail.product) <> "" OR trim(wdetail.reinsp) <> ""  THEN DO: /*A62-0219*/
        FIND LAST sicsyac.xcpara49 WHERE  sicsyac.xcpara49.typ[1]  = wdetail.product NO-LOCK NO-ERROR .
        IF AVAIL sicsyac.xcpara49 THEN
            ASSIGN wdetail.product = sicsyac.xcpara49.typ[1] + " " +
            sicsyac.xcpara49.typ[7] + " " +
            sicsyac.xcpara49.typ[9].
        RUN proc_uwd100.  /*A62-0219*/
    END.
    ASSIGN 
        wdetail.stk = nv_stk70
        nv_stk70 = "".

    RUN proc_uwd102. 
    ASSIGN wdetail.product = "".
END.
 /* --------------------U W M 1 2 0 -------------- */
  FIND sic_bran.uwm120 USE-INDEX uwm12001      WHERE
       sic_bran.uwm120.policy  = sic_bran.uwm100.policy AND 
       sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt AND 
       sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND 
       sic_bran.uwm120.riskgp  = s_riskgp               AND 
       sic_bran.uwm120.riskno  = s_riskno               AND       
       sic_bran.uwm120.bchyr   = nv_batchyr               AND 
       sic_bran.uwm120.bchno   = nv_batchno               AND
       sic_bran.uwm120.bchcnt  = nv_batcnt              NO-WAIT NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm120 THEN DO:
       RUN wgw/wgwad120 (INPUT sic_bran.uwm100.policy,   /***--- A490166 Note Modi ---***/
                               sic_bran.uwm100.rencnt,
                               sic_bran.uwm100.endcnt,
                               s_riskgp,
                               s_riskno,
                               OUTPUT  s_recid2).
      FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
    END.   /* end not avail  uwm120 */
    IF AVAILABLE sic_bran.uwm120 THEN DO:  
        ASSIGN
        sic_bran.uwm120.sicurr = "BHT"
        sic_bran.uwm120.siexch = 1  /*not sure*/
        sic_bran.uwm120.fptr01 = 0               
        sic_bran.uwm120.fptr02 = 0               
        sic_bran.uwm120.fptr03 = 0               
        sic_bran.uwm120.fptr04 = 0               
        sic_bran.uwm120.fptr08 = 0               
        sic_bran.uwm120.fptr09 = 0          
        sic_bran.uwm120.com1ae = YES
        sic_bran.uwm120.stmpae = YES
        sic_bran.uwm120.feeae  = YES
        sic_bran.uwm120.taxae  = YES
        sic_bran.uwm120.bptr01 = 0 
        sic_bran.uwm120.bptr02 = 0 
        sic_bran.uwm120.bptr03 = 0 
        sic_bran.uwm120.bptr04 = 0 
        sic_bran.uwm120.bptr08 = 0 
        sic_bran.uwm120.bptr09 = 0 
        sic_bran.uwm120.bchyr = nv_batchyr         /* batch Year */
        sic_bran.uwm120.bchno = nv_batchno         /* bchno    */
        sic_bran.uwm120.bchcnt  = nv_batcnt .      /* bchcnt     */
        IF wdetail.poltyp = "v72" THEN DO:
            ASSIGN
                sic_bran.uwm120.class  =  wdetail.subclass
                s_recid2     = RECID(sic_bran.uwm120).
        END.
        ELSE IF wdetail.poltyp = "v70"  THEN
        ASSIGN
            sic_bran.uwm120.class  = wdetail.prempa  + wdetail.subclass
            s_recid2     = RECID(sic_bran.uwm120).
    END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew c-win 
PROCEDURE proc_renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*****
FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail.prepol   No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF sicuw.uwm100.renpol <> " " THEN DO:
        MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
        ASSIGN  wdetail.prepol = "Already Renew" /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
            wdetail.comment    = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
            wdetail.OK_GEN     = "N"
            wdetail.pass       = "N". 
    END.
    ELSE DO: 
        ASSIGN  
            wdetail.prepol = sicuw.uwm100.policy
            n_rencnt       = sicuw.uwm100.rencnt  +  1
            n_endcnt       = 0
            wdetail.pass   = "Y".

        ASSIGN fi_show = "Import data Expiry ......".
        DISP fi_show WITH FRAM fr_main.
        RUN proc_assignrenew.      /*รับค่า ความคุ้มครองของเก่า */
    END.
END.        /*  avail  uwm100  */
ELSE DO:
    ASSIGN
        n_rencnt        = 0  
        n_Endcnt        = 0
        wdetail.prepol  = ""
        wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".
    /*FIND FIRST brstat.tlt USE-INDEX tlt06 WHERE
        brstat.tlt.cha_no  = wdetail.chasno NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.tlt THEN DO:
        ASSIGN 
            wdetail.seat = "7" .
    END.*/
END.   /*not  avail uwm100*/
/*IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".*/
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 c-win 
PROCEDURE proc_report1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*nv_row  =  1.*/
DEF VAR a AS CHAR FORMAT "x(100)" INIT "".
DEF VAR b AS CHAR FORMAT "x(100)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR NOT_pass AS INTE INIT 0.
FOR EACH wdetail WHERE wdetail.PASS <> "Y"  :
        NOT_pass = NOT_pass + 1.
    
END.
IF NOT_pass > 0 THEN DO:
    OUTPUT STREAM ns1 TO value(fi_output2).
    PUT STREAM ns1
        "branch     "   ","   
        "Redbook    "   ","
        "policy     "   ","      
        "stk        "   ","              
        "poltyp     "   ","         
        "entdat     "   ","              
        "enttim     "   ","              
        "trandat    "   ","        
        "trantim    "   ","             
        "renpol     "   ","             
        "comdat     "   ","             
        "expdat     "   ","             
        "compul     "   ","             
        "tiname     "   ","             
        "insnam     "   ","             
        "iadd1      "   ","             
        "iadd2      "   ","             
        "iadd3      "   ","             
        "iadd4      "   ","             
        "prempa     "   ","             
        "subclass   "   ","  
        "seat       "   ","            
        "body       "   ","            
        "brand      "   ","            
        "model      "   ","            
        "cc         "   ","            
        "weight     "   ","            
        "vehreg     "   ","               
        "engno      "   ","               
        "chasno     "   ","               
        "caryear    "   ","               
        "carprovi   "   ","               
        "vehuse     "   ","               
        "garage     "   ","               
        "covcod     "   ","               
        "si         "   ","       
        "volprem    "   ","        
        "Compprem   "   ","        
        "fleet      "   ","        
        "ncb        "   ","        
        "access     "   ","        
        "deductpp   "   ","        
        "deductba   "   ","        
        "deductpa   "   ","        
        "benname    "   ","        
        "n_user     "   ","        
        "n_IMPORT   "   ","        
        "n_export   "   "," 
        "cancel     "   ","        
        "WARNING    "   ","                
        "comment    "   ","               
        "seat41     "   ","               
        "pass       "   ","               
        "OK_GEN     "   ","               
        "tariff     "   ","               
        "baseprem   "   ","               
        "cargrp     "   ","               
        "producer   "   ","               
        "agent      "   ","               
        "inscod     "   ","               
        "premt      "   ","               
        "base       "   ","               
        "accdat     "   ","               
        "docno      "                   
        SKIP.                                                   
    FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"  :           
        PUT STREAM ns1                                               
            wdetail.branch      ","
            wdetail.redbook     "," 
            wdetail.policy      ","
            wdetail.stk         "," 
            wdetail.poltyp      ","
           /* wdetail.entdat      ","
            wdetail.enttim      ","*/
           /* wdetail.trandat     ","
            wdetail.trantim     ","*/
           
            wdetail.comdat      "," 
            wdetail.expdat      ","
            wdetail.compul      ","
            wdetail.tiname      ","
            wdetail.insnam      "," 
            wdetail.iadd1       ","
            wdetail.iadd2       ","
            wdetail.iadd3       ","
            wdetail.iadd4       ","  
            wdetail.prempa      "," 
            wdetail.subclass    "," 
            wdetail.seat        ","  
            wdetail.body        ","  
            wdetail.brand       ","  
            wdetail.model       ","  
            wdetail.cc          ","  
            wdetail.weight      "," 
            wdetail.vehreg      ","  
            wdetail.engno       "," 
            wdetail.chasno      ","               
            wdetail.caryear     "," 
            wdetail.vehuse      ","               
            wdetail.garage      ","               
            wdetail.covcod      "," 
            wdetail.si          "," 
            wdetail.access      "," 
            wdetail.deductpp    "," 
            wdetail.deductba    "," 
            wdetail.deductpa    "," 
            wdetail.benname     "," 
            wdetail.n_IMPORT    "," 
            wdetail.n_export    "," 
            wdetail.cancel      ","
            wdetail.WARNING     ","
            wdetail.comment     ","
            wdetail.seat41      ","
            wdetail.pass        ","   
            wdetail.OK_GEN      ","   
              
            wdetail.baseprem    ","   
            wdetail.cargrp      ","   
            wdetail.producer    ","   
            wdetail.agent       ","   
            wdetail.premt       ","   
            wdetail.base        ","   
            wdetail.accdat      ","   
            wdetail.docno       ","   
            SKIP.  
    END.
END.                                                                                    
OUTPUT STREAM ns1 CLOSE.                                                       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT2 c-win 
PROCEDURE PROC_REPORT2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
/*nv_row  =  1.*/
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.
FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        pass = pass + 1.

END.
IF pass > 0 THEN DO:
OUTPUT STREAM ns2 TO value(fi_output1).
          PUT STREAM NS2
            "branch   "      "," 
            "redbook   "     ","
            "policy   "      ","
            "entdat   "      ","     
            "enttim   "      ","     
            "trandat  "      ","     
            "trantim  "      ","     
            "poltyp   "      "," 
            "renpol   "      ","     
            "comdat   "      ","     
            "expdat   "      ","     
            "compul   "      ","     
            "tiname   "      ","     
            "insnam   "      ","     
            "iadd1    "      ","     
            "iadd2    "      ","     
            "iadd3    "      ","     
            "iadd4    "      ","     
            "prempa   "      ","     
            "subclass "      ","     
            "seat     "      ","     
            "body     "      ","     
            "brand    "      ","    
            "model    "      ","    
            "cc       "      ","     
            "weight   "      ","     
            "vehreg   "      ","     
            "engno    "      ","     
            "chasno   "      ","     
            "caryear  "      ","     
            "carprovi "      ","     
            "vehuse   "      ","     
            "garage   "      ","     
            "stk      "      ","     
            "covcod   "      ","     
            "si       "      ","     
            "volprem  "      ","     
            "Compprem "      ","     
            "fleet    "      ","     
            "ncb      "      ","     
            "access   "      ","      
            "deductpp "      ","     
            "deductba "      ","     
            "deductpa "      ","     
            "benname  "      ","     
            "n_user   "      ","     
            "n_IMPORT "      ","     
            "n_export "      ","     
            "cancel   "      ","     
            "WARNING  "      ","     
            "comment   "     ","    
            "seat41    "     ","    
            "pass      "     ","    
            "OK_GEN    "     ","    
            "tariff    "     ","    
            "baseprem  "     ","    
            "cargrp    "     ","    
            "producer  "     ","    
            "agent     "     ","    
            "inscod    "     ","    
            "premt     "     ","
            "base      "     ","    
            "accdat    "     ","    
            "docno     "    SKIP.        
    FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
        wdetail.comment      ","
        wdetail.branch       ","
        wdetail.redbook      ","
        wdetail.policy       ","
        /*wdetail.entdat       ","
        wdetail.enttim       ","*/
       /* wdetail.trandat      ","
        wdetail.trantim      ","*/
        wdetail.poltyp       ","
        wdetail.comdat       "," 
        wdetail.expdat       ","
        wdetail.compul       ","
        wdetail.tiname       ","
        wdetail.insnam       "," 
        wdetail.iadd1        ","
        wdetail.iadd2        ","
        wdetail.iadd3        ","
        wdetail.iadd4        ","  
        wdetail.prempa       "," 
        wdetail.subclass     ","  
        wdetail.seat         ","  
        wdetail.body         ","        
        wdetail.brand        ","  
        wdetail.model        ","  
        wdetail.cc           ","  
        wdetail.weight       ","  
        wdetail.vehreg       ","  
        wdetail.engno        "," 
        wdetail.chasno       ","               
        wdetail.caryear      ","
        wdetail.vehuse       ","               
        wdetail.garage       ","               
        wdetail.stk          "," 
        wdetail.covcod       "," 
        wdetail.si           "," 
        wdetail.access       "," 
        wdetail.deductpp     "," 
        wdetail.deductba     "," 
        wdetail.deductpa     "," 
        wdetail.benname      "," 
        wdetail.n_IMPORT     "," 
        wdetail.n_export     "," 
        wdetail.cancel       ","
        wdetail.WARNING      ","
        wdetail.seat41       ","
        wdetail.pass         ","   
        wdetail.OK_GEN       "," 
        wdetail.baseprem     ","   
        wdetail.cargrp       ","   
        wdetail.producer     ","   
        wdetail.agent        ","
        wdetail.premt        ","   
        wdetail.base         ","   
        wdetail.accdat       ","   
        wdetail.docno       SKIP. 
  END.
OUTPUT STREAM ns2 CLOSE.                                                           
END. /*pass > 0*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen c-win 
PROCEDURE proc_screen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM ns3 TO value(fi_output3).
PUT STREAM NS3   
"IMPORT TEXT FILE TAS " SKIP
"             Loaddat : " fi_loaddat    SKIP
"              Branch : " fi_branch     SKIP
"       Producer Code : " fi_producer   SKIP
"          Agent Code : " fi_agent      SKIP
"  Previous Batch No. : " fi_prevbat   " Batch Year : " fi_bchyr  SKIP
"Input File Name Load : " fi_filename   SKIP
"    Output Data Load : " fi_output1    SKIP
"Output Data Not Load : " fi_output1    SKIP
"     Batch File Name : " fi_output1    SKIP
" policy Import Total : " fi_usrcnt    "Total Net Premium Imp : " fi_usrprem " BHT." SKIP
SKIP
SKIP
SKIP
"                             Total Record : " fi_impcnt      "   Total Net Premium : " fi_premtot " BHT." SKIP
"Batch No. : " fi_bchno SKIP
"                           Success Record : " fi_completecnt " Success Net Premium : " fi_premsuc " BHT." .


OUTPUT STREAM ns3 CLOSE.                                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 c-win 
PROCEDURE proc_sic_exp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
    CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.
    /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.  *//*Comment A62-0105*/
    CLEAR FRAME nf00.
    HIDE FRAME nf00.
    RETURN. 
END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_susspect c-win 
PROCEDURE proc_susspect :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_msgstatus  as char.
DEF VAR nn_vehreglist as char.
DEF VAR nn_namelist   as char.
DEF VAR nn_namelist2  as char.
DEF VAR nv_chanolist  as char.
DEF VAR nv_idnolist   as char.
DEF VAR nv_CheckLog   as LOGICAL.   
DEF VAR nv_idnolist2  AS CHAR.
ASSIGN 
    nv_msgstatus   = ""
    nn_vehreglist  = ""
    nn_namelist    = ""
    nn_namelist2   = "" 
    nv_chanolist   = "" 
    nv_idnolist    = "" 
    nv_CheckLog    = YES
    nn_vehreglist  = trim(wdetail.vehreg)  
    nv_chanolist   = trim(wdetail.chasno)  
    nv_idnolist    = trim(wdetail.idno) .
IF R-INDEX(wdetail.insnam," ") <> 0 THEN  
    ASSIGN
    nn_namelist    = trim(SUBSTR(wdetail.insnam,1,R-INDEX(wdetail.insnam," ")))
    nn_namelist2   = trim(SUBSTR(wdetail.insnam,R-INDEX(wdetail.insnam," "))).
ELSE ASSIGN
    nn_namelist    = TRIM(wdetail.insnam) 
    nn_namelist2   = "".
IF wdetail.vehreg <> "" THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp01    WHERE 
        sicuw.uzsusp.vehreg = nn_vehreglist    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wdetail.comment = wdetail.comment + "|รถผู้เอาประกัน ติด suspect ทะเบียน " + nn_vehreglist + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
END.
IF (nv_msgstatus = "") AND (nn_namelist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
        sicuw.uzsusp.fname = nn_namelist           AND 
        sicuw.uzsusp.lname = nn_namelist2          NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wdetail.comment = wdetail.comment + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
    ELSE DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = Trim(nn_namelist  + " " + nn_namelist2)        
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN 
                wdetail.comment = wdetail.comment + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".
        END.
    END.
END.
IF (nv_msgstatus = "") AND (nv_chanolist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp05   WHERE 
        uzsusp.cha_no =  nv_chanolist         NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wdetail.comment = wdetail.comment + "|รถผู้เอาประกัน ติด suspect เลขตัวถัง " + nv_chanolist + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
END.
IF (nv_msgstatus = "") AND (nv_idnolist <> "") THEN DO:
    
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp08    WHERE 
        sicuw.uzsusp.notes = nv_idnolist   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN wdetail.comment = wdetail.comment + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
    IF nv_msgstatus = "" THEN DO:
        ASSIGN 
            nv_idnolist2 = ""
            nv_idnolist  = REPLACE(nv_idnolist,"-","")
            nv_idnolist  = REPLACE(nv_idnolist," ","")
            nv_idnolist2 = substr(nv_idnolist,1,1)  + "-" +
                           substr(nv_idnolist,2,4)  + "-" +
                           substr(nv_idnolist,6,5)  + "-" +
                           substr(nv_idnolist,11,2) + "-" +
                           substr(nv_idnolist,13)   .

        FIND LAST sicuw.uzsusp USE-INDEX uzsusp08  WHERE 
            sicuw.uzsusp.notes = nv_idnolist2         NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN 
                wdetail.comment = wdetail.comment + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".
        END.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_TempPolicy c-win 
PROCEDURE proc_TempPolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
nv_tmppol    = ""
nv_tmppolrun = nv_tmppolrun + 1
nv_tmppol    = nv_batchno + string(nv_tmppolrun, "999") .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_usdcod c-win 
PROCEDURE Proc_usdcod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_age1 AS INT INIT 0.
DEF VAR nv_age2 AS INT INIT 0.
DEFINE  VAR   nv_drivcod1 AS CHARACTER FORMAT "X(4)".
DEFINE  VAR   nv_drivcod2 AS CHARACTER FORMAT "X(4)".
DEF VAR nv_age1rate  LIKE  sicsyac.xmm106.appinc.
DEF VAR nv_age2rate  LIKE  sicsyac.xmm106.appinc.
DEFINE  VAR   nv_drivdate1 AS CHARACTER FORMAT "X(10)" INIT "".
DEFINE  VAR   nv_drivdate2 AS CHARACTER FORMAT "X(10)" INIT "".

IF wdetail.drivname1 <> " " THEN 
    ASSIGN nv_drivdate1      = SUBSTRING(wdetail.drivname1,INDEX(wdetail.drivname1,"hbd:") + 4,10).
IF wdetail.drivname2 <> " " THEN
    nv_drivdate2     = SUBSTRING(wdetail.drivname2,INDEX(wdetail.drivname2,"hbd:") + 4,10).
ASSIGN 
    nv_age1 =  (YEAR(TODAY) + 543 ) - INT(SUBSTR(nv_drivdate1,7,4))   
    nv_age2 =  (YEAR(TODAY) + 543 ) - INT(SUBSTR(nv_drivdate2,7,4)).

nv_drivcod = "A" + STRING(nv_drivno,"9").
  IF nv_drivno = 1 THEN DO:
    IF nv_age1 LE 50 THEN DO:
      IF nv_age1 LE 35 THEN DO:
        IF nv_age1 LE 24 THEN DO:
          nv_drivcod = nv_drivcod + "24".
        END.
        ELSE nv_drivcod = nv_drivcod + "35".
      END.
      ELSE nv_drivcod = nv_drivcod + "50".
    END.
    ELSE nv_drivcod = nv_drivcod + "99".
  END.
  IF  nv_drivno  = 2  THEN DO:
    IF nv_age1 LE 50 THEN DO:
      IF nv_age1 LE 35 THEN DO:
        IF nv_age1 LE 24 THEN DO:
          nv_drivcod1 = nv_drivcod + "24".
        END.
        ELSE nv_drivcod1 = nv_drivcod + "35".
      END.
      ELSE nv_drivcod1 = nv_drivcod + "50".
    END.
    ELSE nv_drivcod1 = nv_drivcod + "99".
    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
               sicsyac.xmm106.tariff = nv_tariff   AND
               sicsyac.xmm106.bencod = nv_drivcod1 AND
               sicsyac.xmm106.class  = nv_class    AND
               sicsyac.xmm106.covcod = nv_covcod   AND
               sicsyac.xmm106.key_b  GE nv_key_b   AND
               sicsyac.xmm106.effdat LE nv_comdat
    NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm106 THEN
       nv_age1rate = sicsyac.xmm106.appinc.
    IF nv_age2 LE 50 THEN DO:
      IF nv_age2 LE 35 THEN DO:
        IF nv_age2 LE 24 THEN DO:
          nv_drivcod2 = nv_drivcod + "24".
        END.
        ELSE nv_drivcod2 = nv_drivcod + "35".
      END.
      ELSE nv_drivcod2 = nv_drivcod + "50".
    END.
    ELSE nv_drivcod2 = nv_drivcod + "99".
         
    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
           sicsyac.xmm106.tariff = nv_tariff   AND
           sicsyac.xmm106.bencod = nv_drivcod2 AND
           sicsyac.xmm106.class  = nv_class    AND
           sicsyac.xmm106.covcod = nv_covcod   AND
           sicsyac.xmm106.key_b  GE nv_key_b   AND
           sicsyac.xmm106.effdat LE nv_comdat
           NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm106 THEN
       nv_age2rate = sicsyac.xmm106.appinc.
    IF   nv_age2rate > nv_age1rate  THEN
         nv_drivcod  = nv_drivcod2.
    ELSE nv_drivcod  = nv_drivcod1.
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 c-win 
PROCEDURE proc_uwd100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*create  text (F17) for Query claim....*/
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF VAR nv_bptr      AS RECID.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    nv_txt5  = ""  
    nv_txt1  = "ProductType : " + wdetail.product
    nv_txt2  = "เลขตรวจสภาพ : " + wdetail.ispno
    nv_txt3  = IF index(wdetail.reinsp,"อุปกรณ์เสริม") <> 0 THEN "ผลการตรวจสภาพ : " + TRIM(SUBSTR(wdetail.reinsp,1,INDEX(wdetail.reinsp,"อุปกรณ์เสริม") - 2))
               ELSE trim(wdetail.reinsp)
    nv_txt4  = IF index(wdetail.reinsp,"อุปกรณ์เสริม") <> 0 THEN "อุปกรณ์เสริม : " + TRIM(SUBSTR(wdetail.reinsp,INDEX(wdetail.reinsp,"อุปกรณ์เสริม") + 13))
               ELSE "" 
    nv_txt5  = "". 
DO WHILE nv_line1 <= 5:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
    nv_line1 = nv_line1 + 1.
END.
FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = wdetail.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt  AND
     sic_bran.uwm100.endcnt  = n_endcnt  AND
     sic_bran.uwm100.bchyr   = nv_batchyr    AND
     sic_bran.uwm100.bchno   = nv_batchno    AND
     sic_bran.uwm100.bchcnt  = nv_batcnt    
 NO-ERROR NO-WAIT.
IF AVAILABLE uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        CREATE sic_bran.uwd100.
        ASSIGN
            sic_bran.uwd100.bptr    = nv_bptr
            sic_bran.uwd100.fptr    = 0
            sic_bran.uwd100.policy  = wdetail.policy
            sic_bran.uwd100.rencnt  = n_rencnt
            sic_bran.uwd100.endcnt  = n_endcnt
            sic_bran.uwd100.ltext   = wuppertxt.txt.
        IF nv_bptr <> 0 THEN DO:
            FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
            wf_uwd100.fptr = RECID(uwd100).
        END.
        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(uwd100).
        nv_bptr = RECID(uwd100).
    END.
END. /*uwm100*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 c-win 
PROCEDURE proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_num1 AS INTE INIT 0.
DEF VAR n_num2 AS INTE INIT 0.
DEF VAR n_num3 AS INTE INIT 1.
DEF VAR i AS INTE INIT 0.
DEF VAR n_text1 AS CHAR FORMAT "x(255)".
ASSIGN nv_fptr = 0
       nv_bptr = 0
       nv_nptr = 0
       nv_line1 = 1
       fi_show = "Create Memo Text....."  .
DISP fi_show WITH FRAM fr_main.
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.

DO WHILE nv_line1 <= 20:   /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
    IF TRIM(wdetail.prmtxt3) = "" THEN DO:  
        IF nv_line1 = 19 THEN DO: 
            nv_line1 = nv_line1 + 1. 
            NEXT.
        END.
        CREATE wuppertxt3.                                                                                 
        wuppertxt3.line = nv_line1.     
        IF nv_line1 = 1  THEN wuppertxt3.txt = trim(wdetail.notifydat).   
        IF nv_line1 = 2  THEN wuppertxt3.txt =  wdetail.nmember .                                          
        IF nv_line1 = 3  THEN wuppertxt3.txt =  "สาขา : "  + SUBSTR(wdetail.nmember2,index(wdetail.nmember2,"-:") + 2,R-INDEX(wdetail.nmember2,":") - index(wdetail.nmember2,"-:") - 2 ) + 
                                                " ชื่อเจ้าหน้าที่ MKT: " + SUBSTR(wdetail.nmember2,r-index(wdetail.nmember2,":") + 1 ).
        IF nv_line1 = 4  THEN wuppertxt3.txt =  wdetail.campaigno .                                         
        IF nv_line1 = 5  THEN wuppertxt3.txt =  wdetail.notiuser + " สาขาที่รับแจ้ง: " + wdetail.notbr. /*A62-0219*/
        IF nv_line1 = 6  THEN wuppertxt3.txt =  "STK : " +  wdetail.stk  .    
        IF nv_line1 = 7  THEN wuppertxt3.txt =  "เลขที่สัญญา : " +  wdetail.cedpol + " " + "เบอร์โทร :" + wdetail.phone .  /*A62-0219*/   
        IF nv_line1 = 8  THEN wuppertxt3.txt =  "เลขที่ตรวจสภาพ : " +  wdetail.ispno.
        IF nv_line1 = 9  THEN wuppertxt3.txt =  "ProductType : " + wdetail.product.
        IF nv_line1 = 10 THEN wuppertxt3.txt =  "Quotation No. : " + wdetail.quotation.  /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
        IF nv_line1 = 11 THEN wuppertxt3.txt =  wdetail.prmtxt2.                         /* add by Phaiboon W. [A59-0488] Date 21/11/2016 */
        IF nv_line1 = 12 THEN wuppertxt3.txt =  TRIM(wdetail.remak1).                    /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
        IF nv_line1 = 13 THEN wuppertxt3.txt =  FILL(" ", INDEX(wdetail.remak1,":") - 1) + TRIM(wdetail.remak2).   /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */ 
       /* add by A62-0219 */
       /* IF nv_line1 = 14 THEN wuppertxt3.txt =  IF trim(wdetail.reinsp) <> "" THEN "ข้อมูลตรวจสภาพ : " + TRIM(wdetail.reinsp)  ELSE "" . */
        IF nv_line1 = 15 THEN wuppertxt3.txt =  IF index(wdetail.reinsp,"อุปกรณ์เสริม") <> 0 THEN "ผลการตรวจสภาพ : " + TRIM(SUBSTR(wdetail.reinsp,1,INDEX(wdetail.reinsp,"อุปกรณ์เสริม") - 2))
                                                ELSE "ผลการตรวจสภาพ : " + trim(wdetail.reinsp).                                                                                                                     
        IF nv_line1 = 16 THEN wuppertxt3.txt =  IF index(wdetail.reinsp,"อุปกรณ์เสริม") <> 0 THEN "อุปกรณ์เสริม : " + TRIM(SUBSTR(wdetail.reinsp,INDEX(wdetail.reinsp,"อุปกรณ์เสริม") + 13))  
                                                ELSE ""   .                                                                                                                                    
        IF nv_line1 = 17 THEN wuppertxt3.txt = IF TRIM(wdetail.deler) <> "" THEN "Dealer : " + TRIM(wdetail.deler) ELSE ""   .
        IF nv_line1 = 18 THEN wuppertxt3.txt = IF trim(wdetail.recivename) <> "" THEN 
                                               trim("ออกใบกำกับภาษี : " + trim(wdetail.recivename) + " " + 
                                               IF wdetail.recaddr <> "" THEN "ที่อยู่: " + wdetail.recaddr ELSE "" + " " +
                                               IF wdetail.rectax <> "" THEN "เลขที่ผู้เสียภาษี: " + wdetail.rectax ELSE "" )
                                               ELSE ""  . 
        /* end A62-0219*/
        nv_line1 = nv_line1 + 1.     
    END.
    ELSE DO:
        CREATE wuppertxt3.                                                                                 
        wuppertxt3.line = nv_line1.     
        IF nv_line1 = 1  THEN wuppertxt3.txt = trim(wdetail.notifydat).   
        IF nv_line1 = 2  THEN wuppertxt3.txt =  wdetail.nmember .                                          
        IF nv_line1 = 3  THEN wuppertxt3.txt =  "สาขา : "  + SUBSTR(wdetail.nmember2,index(wdetail.nmember2,"-:") + 2,R-INDEX(wdetail.nmember2,":") - index(wdetail.nmember2,"-:") - 2 ) + 
                                                " ชื่อเจ้าหน้าที่ MKT: " + SUBSTR(wdetail.nmember2,r-index(wdetail.nmember2,":") + 1 ). 
        IF nv_line1 = 4  THEN wuppertxt3.txt =  wdetail.campaigno .                                         
        IF nv_line1 = 5  THEN wuppertxt3.txt =  wdetail.notiuser  + " สาขาที่รับแจ้ง: " + wdetail.notbr. /*A62-0219*/
        IF nv_line1 = 6  THEN wuppertxt3.txt =  "STK : " +  wdetail.stk  .                                 
        IF nv_line1 = 7  THEN wuppertxt3.txt =  "เลขที่สัญญา : " +  wdetail.cedpol .     
        IF nv_line1 = 8  THEN wuppertxt3.txt =  "เลขที่ตรวจสภาพ : " +  wdetail.ispno.
        IF nv_line1 = 9  THEN wuppertxt3.txt =  "ProductType : " + wdetail.product.
        IF nv_line1 = 10 THEN wuppertxt3.txt =  "Quotation No. : " + wdetail.quotation.  /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
        IF nv_line1 = 11 THEN wuppertxt3.txt =  wdetail.prmtxt2.                         /* add by Phaiboon W. [A59-0488] Date 21/11/2016 */
        /*IF nv_line1 = 12 THEN wuppertxt3.txt =  FILL(" ", INDEX(wdetail.prmtxt2,":") - 3) + wdetail.prmtxt3  .  */     /* add by Phaiboon W. [A59-0488] DAte 21/11/2016 */
        IF nv_line1 = 12 THEN wuppertxt3.txt =  FILL(" ", INDEX(wdetail.prmtxt2,":") - 3) + wdetail.prmtxt3.       /* add by Phaiboon W. [A59-0488] DAte 21/11/2016 */
        IF nv_line1 = 13 THEN wuppertxt3.txt =  TRIM(wdetail.remak1).                    /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
        IF nv_line1 = 14 THEN wuppertxt3.txt =  IF INDEX(wdetail.remak1,":") <> 0 THEN FILL(" ", INDEX(wdetail.remak1,":")) + TRIM(wdetail.remak2) ELSE TRIM(wdetail.remak2) .   /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */ 
        /* add by A62-0219 */
        /*IF nv_line1 = 15 THEN wuppertxt3.txt =  IF trim(wdetail.reinsp) <> "" THEN "ข้อมูลตรวจสภาพ : " + TRIM(wdetail.reinsp)  ELSE "" . */
        IF nv_line1 = 16 THEN wuppertxt3.txt =  IF index(wdetail.reinsp,"อุปกรณ์เสริม") <> 0 THEN "ผลการตรวจสภาพ : " + TRIM(SUBSTR(wdetail.reinsp,1,INDEX(wdetail.reinsp,"อุปกรณ์เสริม") - 2))
                                                ELSE "ผลการตรวจสภาพ : " + trim(wdetail.reinsp)   .                                                                                                                  
        IF nv_line1 = 17 THEN wuppertxt3.txt =  IF index(wdetail.reinsp,"อุปกรณ์เสริม") <> 0 THEN "อุปกรณ์เสริม : " + TRIM(SUBSTR(wdetail.reinsp,INDEX(wdetail.reinsp,"อุปกรณ์เสริม") + 13))  
                                                ELSE "" .                                                                                                                                     
        IF nv_line1 = 18 THEN wuppertxt3.txt = IF TRIM(wdetail.deler) <> "" THEN "Dealer : " + TRIM(wdetail.deler) ELSE ""   .
        IF nv_line1 = 19 THEN wuppertxt3.txt = IF trim(wdetail.recivename) <> "" THEN 
                                               trim("ออกใบกำกับภาษี : " + trim(wdetail.recivename) + " " + 
                                               IF wdetail.recaddr <> "" THEN "ที่อยู่: " + wdetail.recaddr ELSE "" + " " +
                                               IF wdetail.rectax <> "" THEN "เลขที่ผู้เสียภาษี: " + wdetail.rectax ELSE "" )
                                               ELSE ""  . 
        /* end A62-0219*/
        nv_line1 = nv_line1 + 1.
    END.
END.
/* End by Phaiboon W. [A59-0488] Date 22/11/2016 */

IF nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? THEN DO:
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
        FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr
            NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwd102 THEN DO:  
            nv_fptr = sic_bran.uwd102.fptr.
            CREATE sic_bran.uwd102.
            ASSIGN
                sic_bran.uwd102.policy        = sic_bran.uwm100.policy      
                sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt
                sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt      
                sic_bran.uwd102.bptr          = nv_bptr
                sic_bran.uwd102.fptr          = 0
                uwd102.ltext                  = sic_bran.uwd102.ltext.  
            IF nv_bptr <> 0 THEN DO:
                FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_bptr NO-ERROR NO-WAIT.
                sic_bran.uwd102.fptr = RECID(uwd102).
            END.
            IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(sic_bran.uwd102).
            nv_bptr = RECID(sic_bran.uwd102).
        END.
        ELSE DO:    
            HIDE MESSAGE NO-PAUSE.
                MESSAGE "not found " sic_bran.uwd102.policy sic_bran.uwd102.rencnt "/"
                sic_bran.uwd102.endcnt "on file sic_bran.uwd102".
            LEAVE.
        END.
    END.
END.                
ELSE DO:
    Assign            
         nv_fptr = 0 
         nv_bptr = 0  
         nv_nptr = 0. 
    FOR EACH wuppertxt3 NO-LOCK BREAK BY wuppertxt3.line:
                        
        CREATE sic_bran.uwd102.
        ASSIGN
            sic_bran.uwd102.policy        = sic_bran.uwm100.policy        
            sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt 
            sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt        
            sic_bran.uwd102.ltext         = wuppertxt3.txt
            nv_nptr        =     Recid(sic_bran.uwd102).
        If  nv_fptr  = 0  And  nv_bptr = 0 Then      
            Assign        
            sic_bran.uwm100.fptr02  = Recid(sic_bran.uwd102)                   
            sic_bran.uwd102.fptr    = 0  
            sic_bran.uwd102.bptr    = 0                                  
            nv_nptr        =  Recid(sic_bran.uwd102)
            nv_bptr        =  Recid(sic_bran.uwd102).
        ELSE DO:
            Find  First sic_bran.uwd102  Where  Recid(sic_bran.uwd102)  =  nv_bptr No-Error. 
            If  Avail  sic_bran.uwd102   Then    sic_bran.uwd102.fptr   =  nv_nptr.
            Find  First sic_bran.uwd102  Where  Recid(sic_bran.uwd102)  =  nv_nptr No-Error.
            If Avail sic_bran.uwd102 Then Do :
                sic_bran.uwd102.bptr  =      nv_bptr.
                nv_bptr      =      Recid(sic_bran.uwd102).             
           END.
       END.
    END.
    sic_bran.uwm100.bptr02         =       Recid(uwd102).
    sic_bran.uwd102.fptr           =      0.  
    IF nv_bptr = 0 THEN  
         sic_bran.uwm100.fptr02 = RECID(uwd102).
         nv_bptr = RECID(uwd102).
END.
sic_bran.uwm100.bptr02 = nv_bptr.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102-bp c-win 
PROCEDURE proc_uwd102-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by A62-0219...
DEF VAR n_num1 AS INTE INIT 0.
DEF VAR n_num2 AS INTE INIT 0.
DEF VAR n_num3 AS INTE INIT 1.
DEF VAR i AS INTE INIT 0.
DEF VAR n_text1 AS CHAR FORMAT "x(255)".
ASSIGN nv_fptr = 0
       nv_bptr = 0
       nv_nptr = 0
       nv_line1 = 1
       fi_show = "Create Memo Text....."  .
DISP fi_show WITH FRAM fr_main.
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.

/* Begin by Phaiboon W. [A59-0488] Date 22/11/2016 */
/* DO WHILE nv_line1 <= 13: 
    CREATE wuppertxt3.                                                                                 
    wuppertxt3.line = nv_line1.     
    IF nv_line1 = 1  THEN wuppertxt3.txt = trim(wdetail.notifydat).   
    IF nv_line1 = 2  THEN wuppertxt3.txt =  wdetail.nmember .                                          
    IF nv_line1 = 3  THEN wuppertxt3.txt =  "สาขา : "  + SUBSTR(wdetail.nmember2,index(wdetail.nmember2,"-:") + 2,R-INDEX(wdetail.nmember2,":") - index(wdetail.nmember2,"-:") - 2 ) + 
                                            " ชื่อเจ้าหน้าที่ MKT: " + SUBSTR(wdetail.nmember2,r-index(wdetail.nmember2,":") + 1 ). 
    IF nv_line1 = 4  THEN wuppertxt3.txt =  wdetail.campaign .                                         
    IF nv_line1 = 5  THEN wuppertxt3.txt =  wdetail.notiuser  .
    IF nv_line1 = 6  THEN wuppertxt3.txt =  "STK : " +  wdetail.stk  .                                 
    IF nv_line1 = 7  THEN wuppertxt3.txt =  "เลขที่สัญญา : " +  wdetail.cedpol .     
    IF nv_line1 = 8  THEN wuppertxt3.txt =  "เลขที่ตรวจสภาพ : " +  wdetail.ispno.
    IF nv_line1 = 9  THEN wuppertxt3.txt =  "ProductType : " + wdetail.product.
    IF nv_line1 = 10 THEN wuppertxt3.txt =  "Quotation No. : " + wdetail.quotation.  /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
    IF nv_line1 = 11 THEN wuppertxt3.txt =  TRIM(wdetail.remak1).                    /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
    IF nv_line1 = 12 THEN wuppertxt3.txt =  FILL(" ", INDEX(wdetail.remak1,":") - 1) + TRIM(wdetail.remak2).   /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */ 
                                            
    /*IF nv_line1 = 3 THEN wuppertxt3.txt = "Date Confirm_file_name :" + wdetail.remark . */           
    nv_line1 = nv_line1 + 1.                                                                           
END.    */
DO WHILE nv_line1 <= 20:   /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
    IF TRIM(wdetail.prmtxt3) = "" THEN DO:  
        IF nv_line1 = 19 THEN DO: 
            nv_line1 = nv_line1 + 1. 
            NEXT.
        END.
        CREATE wuppertxt3.                                                                                 
        wuppertxt3.line = nv_line1.     
        IF nv_line1 = 1  THEN wuppertxt3.txt = trim(wdetail.notifydat).   
        IF nv_line1 = 2  THEN wuppertxt3.txt =  wdetail.nmember .                                          
        IF nv_line1 = 3  THEN wuppertxt3.txt =  "สาขา : "  + SUBSTR(wdetail.nmember2,index(wdetail.nmember2,"-:") + 2,R-INDEX(wdetail.nmember2,":") - index(wdetail.nmember2,"-:") - 2 ) + 
                                                " ชื่อเจ้าหน้าที่ MKT: " + SUBSTR(wdetail.nmember2,r-index(wdetail.nmember2,":") + 1 ). 
        IF nv_line1 = 4  THEN wuppertxt3.txt =  wdetail.campaign .                                         
        /*IF nv_line1 = 5  THEN wuppertxt3.txt =  wdetail.notiuser  .*/ /*A62-0219*/
        IF nv_line1 = 5  THEN wuppertxt3.txt =  wdetail.notiuser + "สาขาที่รับแจ้ง " + wdetail.notbr. /*A62-0219*/
        IF nv_line1 = 6  THEN wuppertxt3.txt =  "STK : " +  wdetail.stk  .    
        /*IF nv_line1 = 7  THEN wuppertxt3.txt =  "เลขที่สัญญา : " +  wdetail.cedpol. */ /*A62-0219*/
        IF nv_line1 = 7  THEN wuppertxt3.txt =  "เลขที่สัญญา : " +  wdetail.cedpol + " " + "เบอร์โทร :" + wdetail.phone .  /*A62-0219*/   
        IF nv_line1 = 8  THEN wuppertxt3.txt =  "เลขที่ตรวจสภาพ : " +  wdetail.ispno.
        IF nv_line1 = 9  THEN wuppertxt3.txt =  "ProductType : " + wdetail.product.
        IF nv_line1 = 10 THEN wuppertxt3.txt =  "Quotation No. : " + wdetail.quotation.  /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
        IF nv_line1 = 11 THEN wuppertxt3.txt =  wdetail.prmtxt2.                         /* add by Phaiboon W. [A59-0488] Date 21/11/2016 */
        IF nv_line1 = 12 THEN wuppertxt3.txt =  TRIM(wdetail.remak1).                    /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
        /*IF nv_line1 = 13 THEN wuppertxt3.txt =  FILL(" ", INDEX(wdetail.remak1,":") - 1) + TRIM(wdetail.remak2). */  /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */ 
        /*IF nv_line1 = 13 THEN wuppertxt3.txt =  IF INDEX(wdetail.remak1,":") <> 0 THEN FILL(" ", INDEX(wdetail.remak1,":")) + TRIM(wdetail.remak2) ELSE TRIM(wdetail.remak2).
        
        *//* add by A62-0219 */
        IF nv_line1 = 14 THEN wuppertxt3.txt =  IF trim(wdetail.reinsp) <> "" THEN "ข้อมูลตรวจสภาพ : " + TRIM(wdetail.reinsp)  ELSE "" . 
        IF nv_line1 = 15 THEN wuppertxt3.txt =  IF index(wdetail.reinsp,"อุปกรณ์เสริม") <> 0 THEN "ผลการตรวจสภาพ : " + TRIM(SUBSTR(wdetail.reinsp,1,INDEX(wdetail.reinsp,"อุปกรณ์เสริม") - 2))
                                                ELSE trim(wdetail.reinsp).                                                                                                                     
        IF nv_line1 = 16 THEN wuppertxt3.txt =  IF index(wdetail.reinsp,"อุปกรณ์เสริม") <> 0 THEN "อุปกรณ์เสริม : " + TRIM(SUBSTR(wdetail.reinsp,INDEX(wdetail.reinsp,"อุปกรณ์เสริม") + 13))  
                                                ELSE ""   .                                                                                                                                    
        IF nv_line1 = 17 THEN wuppertxt3.txt = IF TRIM(wdetail.deler) <> "" THEN "Dealer : " + TRIM(wdetail.deler) ELSE ""   .
        IF nv_line1 = 18 THEN wuppertxt3.txt = IF trim(wdetail.recivename) <> "" THEN 
                                               trim("ออกใบกำกับภาษี : " + trim(wdetail.recivename) + " " + 
                                               IF wdetail.recaddr <> "" THEN "ที่อยู่: " + wdetail.recaddr ELSE "" + " " +
                                               IF wdetail.rectax <> "" THEN "เลขที่ผู้เสียภาษี: " + wdetail.rectax ELSE "" )
                                               ELSE ""  . 
        /* end A62-0219*/
        nv_line1 = nv_line1 + 1.     
    END.
    ELSE DO:
        CREATE wuppertxt3.                                                                                 
        wuppertxt3.line = nv_line1.     
        IF nv_line1 = 1  THEN wuppertxt3.txt = trim(wdetail.notifydat).   
        IF nv_line1 = 2  THEN wuppertxt3.txt =  wdetail.nmember .                                          
        IF nv_line1 = 3  THEN wuppertxt3.txt =  "สาขา : "  + SUBSTR(wdetail.nmember2,index(wdetail.nmember2,"-:") + 2,R-INDEX(wdetail.nmember2,":") - index(wdetail.nmember2,"-:") - 2 ) + 
                                                " ชื่อเจ้าหน้าที่ MKT: " + SUBSTR(wdetail.nmember2,r-index(wdetail.nmember2,":") + 1 ). 
        IF nv_line1 = 4  THEN wuppertxt3.txt =  wdetail.campaign .                                         
        IF nv_line1 = 5  THEN wuppertxt3.txt =  wdetail.notiuser  .
        IF nv_line1 = 6  THEN wuppertxt3.txt =  "STK : " +  wdetail.stk  .                                 
        IF nv_line1 = 7  THEN wuppertxt3.txt =  "เลขที่สัญญา : " +  wdetail.cedpol .     
        IF nv_line1 = 8  THEN wuppertxt3.txt =  "เลขที่ตรวจสภาพ : " +  wdetail.ispno.
        IF nv_line1 = 9  THEN wuppertxt3.txt =  "ProductType : " + wdetail.product.
        IF nv_line1 = 10 THEN wuppertxt3.txt =  "Quotation No. : " + wdetail.quotation.  /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
        IF nv_line1 = 11 THEN wuppertxt3.txt =  wdetail.prmtxt2.                         /* add by Phaiboon W. [A59-0488] Date 21/11/2016 */
        /*IF nv_line1 = 12 THEN wuppertxt3.txt =  FILL(" ", INDEX(wdetail.prmtxt2,":") - 3) + wdetail.prmtxt3  .  */     /* add by Phaiboon W. [A59-0488] DAte 21/11/2016 */
       /* IF nv_line1 = 12 THEN wuppertxt3.txt =  IF INDEX(wdetail.prmtxt2,":") <> 0 THEN FILL(" ", INDEX(wdetail.prmtxt2,":") - 3) + wdetail.prmtxt3 ELSE wdetail.prmtxt3 .       /* add by Phaiboon W. [A59-0488] DAte 21/11/2016 */
        IF nv_line1 = 13 THEN wuppertxt3.txt =  TRIM(wdetail.remak1).                    /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */
        IF nv_line1 = 14 THEN wuppertxt3.txt =  IF INDEX(wdetail.remak1,":") <> 0 THEN FILL(" ", INDEX(wdetail.remak1,":")) + TRIM(wdetail.remak2) ELSE TRIM(wdetail.remak2) .   /* add by Phaiboon W. [A59-0488] Date 07/11/2016 */ 
        */ /* add by A62-0219 */
        IF nv_line1 = 15 THEN wuppertxt3.txt =  IF trim(wdetail.reinsp) <> "" THEN "ข้อมูลตรวจสภาพ : " + TRIM(wdetail.reinsp)  ELSE "" . 
        IF nv_line1 = 16 THEN wuppertxt3.txt =  IF index(wdetail.reinsp,"อุปกรณ์เสริม") <> 0 THEN "ผลการตรวจสภาพ : " + TRIM(SUBSTR(wdetail.reinsp,1,INDEX(wdetail.reinsp,"อุปกรณ์เสริม") - 2))
                                                ELSE trim(wdetail.reinsp)   .                                                                                                                  
        IF nv_line1 = 17 THEN wuppertxt3.txt =  IF index(wdetail.reinsp,"อุปกรณ์เสริม") <> 0 THEN "อุปกรณ์เสริม : " + TRIM(SUBSTR(wdetail.reinsp,INDEX(wdetail.reinsp,"อุปกรณ์เสริม") + 13))  
                                                ELSE "" .                                                                                                                                     
        IF nv_line1 = 18 THEN wuppertxt3.txt = IF TRIM(wdetail.deler) <> "" THEN "Dealer : " + TRIM(wdetail.deler) ELSE ""   .
        IF nv_line1 = 19 THEN wuppertxt3.txt = IF trim(wdetail.recivename) <> "" THEN 
                                               trim("ออกใบกำกับภาษี : " + trim(wdetail.recivename) + " " + 
                                               IF wdetail.recaddr <> "" THEN "ที่อยู่: " + wdetail.recaddr ELSE "" + " " +
                                               IF wdetail.rectax <> "" THEN "เลขที่ผู้เสียภาษี: " + wdetail.rectax ELSE "" )
                                               ELSE ""  . 
        /* end A62-0219*/
        nv_line1 = nv_line1 + 1.
    END.
END.
/* End by Phaiboon W. [A59-0488] Date 22/11/2016 */

IF nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? THEN DO:
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
        FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr
            NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwd102 THEN DO:  
            nv_fptr = sic_bran.uwd102.fptr.
            CREATE sic_bran.uwd102.
            ASSIGN
                sic_bran.uwd102.policy        = sic_bran.uwm100.policy      
                sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt
                sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt      
                sic_bran.uwd102.bptr          = nv_bptr
                sic_bran.uwd102.fptr          = 0
                uwd102.ltext                  = sic_bran.uwd102.ltext.  
            IF nv_bptr <> 0 THEN DO:
                FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_bptr NO-ERROR NO-WAIT.
                sic_bran.uwd102.fptr = RECID(uwd102).
            END.
            IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(sic_bran.uwd102).
            nv_bptr = RECID(sic_bran.uwd102).
        END.
        ELSE DO:    
            HIDE MESSAGE NO-PAUSE.
                MESSAGE "not found " sic_bran.uwd102.policy sic_bran.uwd102.rencnt "/"
                sic_bran.uwd102.endcnt "on file sic_bran.uwd102".
            LEAVE.
        END.
    END.
END.                
ELSE DO:
    Assign            
         nv_fptr = 0 
         nv_bptr = 0  
         nv_nptr = 0. 
    FOR EACH wuppertxt3 NO-LOCK BREAK BY wuppertxt3.line:
                        
        CREATE sic_bran.uwd102.
        ASSIGN
            sic_bran.uwd102.policy        = sic_bran.uwm100.policy        
            sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt 
            sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt        
            sic_bran.uwd102.ltext         = wuppertxt3.txt
            nv_nptr        =     Recid(sic_bran.uwd102).
        If  nv_fptr  = 0  And  nv_bptr = 0 Then      
            Assign        
            sic_bran.uwm100.fptr02  = Recid(sic_bran.uwd102)                   
            sic_bran.uwd102.fptr    = 0  
            sic_bran.uwd102.bptr    = 0                                  
            nv_nptr        =  Recid(sic_bran.uwd102)
            nv_bptr        =  Recid(sic_bran.uwd102).
        ELSE DO:
            Find  First sic_bran.uwd102  Where  Recid(sic_bran.uwd102)  =  nv_bptr No-Error. 
            If  Avail  sic_bran.uwd102   Then    sic_bran.uwd102.fptr   =  nv_nptr.
            Find  First sic_bran.uwd102  Where  Recid(sic_bran.uwd102)  =  nv_nptr No-Error.
            If Avail sic_bran.uwd102 Then Do :
                sic_bran.uwd102.bptr  =      nv_bptr.
                nv_bptr      =      Recid(sic_bran.uwd102).             
           END.
       END.
    END.
    sic_bran.uwm100.bptr02         =       Recid(uwd102).
    sic_bran.uwd102.fptr           =      0.  
    IF nv_bptr = 0 THEN  
         sic_bran.uwm100.fptr02 = RECID(uwd102).
         nv_bptr = RECID(uwd102).
END.
sic_bran.uwm100.bptr02 = nv_bptr.
... end A62-0219.......*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm100 c-win 
PROCEDURE proc_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*กรณี ต้องการ ให้ได้เบี้ย ตามไฟล์ */
/*IF (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) >= 365 ) AND
   (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) <= 366 ) THEN DO:
    ASSIGN 
    nv_gapprm  =  IF wdetail.volprem = "" THEN nv_gapprm ELSE DECI(wdetail.volprem)
    nv_pdprm   =  IF wdetail.volprem = "" THEN nv_pdprm  ELSE DECI(wdetail.volprem).
END.
ELSE DO:  /*เบี้ย ไม่เต็มปี หรือ เกินปี */
        ASSIGN nv_pdprm   =  IF wdetail.volprem = "" THEN nv_pdprm  ELSE DECI(wdetail.volprem).
END.

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN  
         /*sic_bran.uwm100.prem_t = nv_gapprm*/     /* A57-0426 */
         sic_bran.uwm100.prem_t = nv_pdprm          /* A57-0426 *//*เบี้ย ไม่เต็มปี หรือ เกินปี */
         sic_bran.uwm100.sigr_p = inte(wdetail.si)
         sic_bran.uwm100.gap_p  = nv_gapprm.

     IF wdetail.pass <> "Y" THEN 
         ASSIGN
         sic_bran.uwm100.impflg = NO
         sic_bran.uwm100.imperr = wdetail.comment.    
     
END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var c-win 
PROCEDURE proc_var :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    /* nv_camptyp =  "NORM"*/
    s_riskgp   =   0                     s_riskno       =  1
    s_itemno   =   1                     nv_undyr       =    String(Year(today),"9999")   
    n_rencnt   =   0                     n_endcnt       =  0.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wgw72013 c-win 
PROCEDURE proc_wgw72013 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT        PARAMETER  nv_rec100  AS RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  nv_red132  AS RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  nvtariff   AS CHARACTER NO-UNDO.
DEF            VAR n_dcover   AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_dyear    AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR nvyear     AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_day1     AS   INT FORMAT "99"    INITIAL[31].
DEF            VAR n_mon1     AS   INT FORMAT "99"    INITIAL[12].
DEF            VAR n_ddyr     AS   INT FORMAT "9999"  INITIAL[0].
DEF            VAR n_ddyr1    AS   INT FORMAT "9999"  INITIAL[0].
DEF            VAR n_dmonth   AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_orgnap   LIKE sic_bran.uwd132.gap_c  NO-UNDO.
DEF            VAR s_curbil   LIKE sic_bran.uwm100.curbil NO-UNDO.
def              var  n_total   as deci  no-undo.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) EQ nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ nv_red132 NO-WAIT NO-ERROR.
s_curbil = sic_bran.uwm100.curbil.
n_orgnap = sic_bran.uwd132.gap_c.
IF sic_bran.uwm100.expdat EQ ? OR  sic_bran.uwm100.comdat EQ ? THEN sic_bran.uwd132.prem_c = n_orgnap.
IF nvtariff = "Z" OR nvtariff = "X" THEN DO:
   sic_bran.uwd132.prem_c = n_orgnap.
END.
ELSE DO:
  IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
    ASSIGN n_dcover = 0
           n_dyear  = 0
           nvyear   = 0
           n_dmonth = 0.
                IF ( DAY(sic_bran.uwm100.comdat)     =   DAY(sic_bran.uwm100.expdat)    AND
                   MONTH(sic_bran.uwm100.comdat)     = MONTH(sic_bran.uwm100.expdat)    AND
                    YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
                   ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
                   MONTH(sic_bran.uwm100.comdat)     =   02                             AND
                     DAY(sic_bran.uwm100.expdat)     =   01                             AND
                   MONTH(sic_bran.uwm100.expdat)     =   03                             AND
                    YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
                THEN DO:
                  n_dcover = 365.
                END.
                ELSE DO:
                  n_dcover = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
                END.
    FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE
         sicsyac.xmm031.poltyp EQ sic_bran.uwm100.poltyp
    NO-LOCK NO-ERROR.
    IF AVAILABLE sicsyac.xmm031 THEN DO:
       IF n_dcover = 365  THEN   
      n_ddyr   = YEAR(TODAY).
      n_ddyr1  = n_ddyr + 1.
      n_dyear  = 365.   
      FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
           sicsyac.xmm105.tariff EQ nvtariff      AND
           sicsyac.xmm105.bencod EQ sic_bran.uwd132.bencod
      NO-LOCK NO-ERROR.
      IF  sic_bran.uwm100.short = NO OR sicsyac.xmm105.shorta = NO THEN DO:
          sic_bran.uwd132.prem_c = (n_orgnap * n_dcover) / n_dyear .  
      END.
      ELSE DO:
        FIND FIRST sicsyac.xmm127 USE-INDEX xmm12701     WHERE
                   sicsyac.xmm127.poltyp =  sic_bran.uwm100.poltyp AND
                   sicsyac.xmm127.daymth =  YES                    AND
                   sicsyac.xmm127.nodays GE n_dcover
        NO-LOCK NO-ERROR.
        IF AVAILABLE sicsyac.xmm127 THEN DO:
           sic_bran.uwd132.prem_c =  (n_orgnap * sicsyac.xmm127.short) / 100 .
        END.
        ELSE DO:
          IF YEAR(sic_bran.uwm100.expdat) <> YEAR(sic_bran.uwm100.comdat) THEN DO:
            nvyear = YEAR(sic_bran.uwm100.expdat) - YEAR(sic_bran.uwm100.comdat).
            IF nvyear > 1 THEN
               n_dmonth = (12 - MONTH(sic_bran.uwm100.comdat) +
                                MONTH(sic_bran.uwm100.expdat) + 1) + ((nvyear - 1) * 12).
            ELSE
               n_dmonth =  12 - MONTH(sic_bran.uwm100.comdat) +
                                MONTH(sic_bran.uwm100.expdat) + 1.
          END.
          ELSE n_dmonth = MONTH(sic_bran.uwm100.expdat) - MONTH(sic_bran.uwm100.comdat) + 1.
          FIND FIRST sicsyac.xmm127 USE-INDEX xmm12701      WHERE
                     sicsyac.xmm127.poltyp =  sic_bran.uwm100.poltyp AND
                     sicsyac.xmm127.daymth =  NO            AND
                     sicsyac.xmm127.nodays GE n_dmonth
          NO-LOCK NO-ERROR.
          IF AVAILABLE xmm127 THEN DO:
             sic_bran.uwd132.prem_c = (n_orgnap * sicsyac.xmm127.short) / 100.
             HIDE MESSAGE NO-PAUSE.
             
             PAUSE.
          END.
          ELSE DO:
             sic_bran.uwd132.prem_c =  (n_orgnap * n_dcover) / n_dyear.
          END.

        END.
      END.
      IF s_curbil = "BHT" THEN  sic_bran.uwd132.prem_c = sic_bran.uwd132.prem_c.
    END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

