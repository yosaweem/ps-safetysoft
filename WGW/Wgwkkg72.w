&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
/* Connected Databases  sic_test         PROGRESS   */File: 
Description: Input Parameters:<none>Output Parameters:<none>
Author: Created:  --------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
CREATE WIDGET-POOL.
/* ***************************  Definitions  ***************************/
/* Parameters Definitions ---                                          */
/* Local Variable Definitions ---       *//*******************************/                                      
/*programid   : wgwkkgen.w                                             */ 
/*programname : load text file KK to GW                                */ 
/* Copyright  : Safety Insurance Public Company Limited บริษัท ประกันคุ้มภัย จำกัด (มหาชน)       */
/*create by   : Kridtiya i. A53-0097   date . 18/02/2010              
                ปรับโปรแกรมให้รับค่า vatcode จาก table xmm600 field acnoเก็บลงที่ table uwm100 feld bs_cd                      */
/*modify by   : Kridtiya i. A53-0097 date: 01/04/2010  ปรับไม่แสดง ชื่อ name2 และ vatcode ไม่ให้แสดง*/
/*modify by   : Kridtiya i. A54-0049 date: 14/02/2011  ปรับให้รับเลขพรบ.จากไฟล์นำเข้า */
/*modify by   : Kridtiya i. A54-0126 date: 18/05/2011  ปรับให้แสดง ลักษณะรถ ที่นั่ง และไม่ให้แสดง CC*/
/*modify by   : Kridtiya i. A54-0273 ปรับเงื่อนไขการหาเลขสติ๊กเกอร์    */
/*modify by   : Kridtiya i. A56-0212 เพิ่มเลขที่บัตรประชาชน            */
/*modify by   : Kridtiya i. A56-0231 เพิ่มที่อยู่ไฟล์เก่าใช้ที่อยู่สาขา*/
/*Modify by   : Kridtiya i. A56-0309 เพิ่มการแปลงที่อยู่ ตามไฟล์แจ้งงานใหม่ */
/*Modify by   : Kridtiya i. A56-0047  Add check sicsyac.xmm600.clicod   = "IN"             */
/*modify by   : kridtiya i. A57-0434  add body */
/*Modify By : Ranu I. A59-0590 01/12/2016 ปรับเงื่อนไขการเช็คเบอร์กรมธรรม์ */
/*Modify By : Ranu I. A60-0232 01/06/2017 เพิ่มการเก็บข้อมูล F8 */
/*Modify By : Ranu I. A61-0335 10/07/2018 เพิ่มการเก็บข้อมูลเนื่องจากแก้ไขไฟล์แจ้งงาน*/
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
DEF VAR n_index AS INTE INIT 0 .
DEF VAR n_index2 AS INTE INIT 0.
DEF VAR  n_cr2 AS CHAR INIT "" FORMAT "x(20)".
DEF VAR num AS DECI INIT 0.
DEF VAR expyear AS DECI FORMAT "9999" .
DEF NEW SHARED VAR nv_producer AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR nv_agent    AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno. 
DEF VAR  nv_row  as  int  init  0.
DEFINE STREAM  ns1. 
DEFINE STREAM  ns2.
DEFINE STREAM  ns3.
DEF VAR nv_uom1_v AS INTE INIT 0.
DEF VAR nv_uom2_v AS INTE INIT 0.
DEF VAR nv_uom5_v AS INTE INIT 0.
DEF VAR chkred    AS logi INIT NO.
DEF SHARED Var   n_User    As CHAR .
DEF SHARED Var   n_PassWd  As CHAR .    
DEF VAR nv_clmtext AS CHAR INIT  "".
DEF VAR n_renew    AS LOGIC  .
DEF VAR nv_massage AS CHAR .
DEF VAR nv_comper  AS DECI INIT 0.
DEF VAR nv_comacc  AS DECI INIT 0.
DEF VAR NO_prem2   AS INTE INIT 0.
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
DEF NEW  SHARED VAR   nv_cl_cod   AS CHAR       FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_cl_per   AS DECIMAL    FORMAT ">9.99".
DEF New  SHARED VAR   nv_lodclm   AS INTEGER    FORMAT ">>>,>>9.99-".
DEF             VAR   nv_lodclm1  AS INTEGER    FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR   nv_clmvar1  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar2  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar   AS CHAR       FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_stf_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_stf_per  AS DECIMAL   FORMAT ">9.99".
DEF New  SHARED VAR   nv_stf_amt  AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_stfvar1  AS CHAR      FORMAT "X(30)".
DEF New  SHARED VAR   nv_stfvar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_stfvar   AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_dss_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_dss_per  AS DECIMAL   FORMAT ">9.99".
DEF New  SHARED VAR   nv_dsspc    AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_dsspcvar1 AS CHAR     FORMAT "X(30)".
DEF New  SHARED VAR   nv_dsspcvar2 AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_dsspcvar  AS CHAR     FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_ncb_cod  AS CHAR  FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_ncbper   LIKE sicuw.uwm301.ncbper.
DEF New  SHARED VAR   nv_ncb      AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_ncbvar1  AS CHAR  FORMAT "X(30)".
DEF New  SHARED VAR   nv_ncbvar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_ncbvar   AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_flet_cod AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_flet_per AS DECIMAL FORMAT ">>9".
DEF New  SHARED VAR   nv_flet     AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_fletvar1 AS CHAR    FORMAT "X(30)".
DEF New  SHARED VAR   nv_fletvar2 AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_fletvar  AS CHAR    FORMAT "X(60)".
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
/*------------nv_bipcod-------------*/
DEF NEW  SHARED VAR   nv_bipcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_bipprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_bipvar1 AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_bipvar2 AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_bipvar  AS CHAR  FORMAT "X(60)".
/*------------nv_biacod----------*/
DEF NEW  SHARED VAR   nv_biacod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_biaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_biavar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_biavar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_biavar   AS CHAR  FORMAT "X(60)".
/*------------nv_pdacod------------*/
DEF NEW  SHARED VAR   nv_pdacod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_pdaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_pdavar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_pdavar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_pdavar   AS CHAR  FORMAT "X(60)".
/******** usoper **********/
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
/*DEF Var nv_lastno As       Int.*/
/*Def Var nv_seqno  As       Int.*/
DEF VAR sv_xmm600 AS       RECID.
DEF VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.
DEF VAR s_130bp1    AS RECID                            NO-UNDO.
DEF VAR s_130fp1    AS RECID                            NO-UNDO.
DEF VAR nvffptr     AS RECID                            NO-UNDO.
DEF VAR n_rd132     AS RECID                            NO-UNDO.
DEF VAR nv_gap      AS DECIMAL                          NO-UNDO.
DEF VAR nv_fptr     AS RECID.
DEF VAR nv_bptr     AS RECID.
DEF VAR nv_gap2     AS DECIMAL                          NO-UNDO.
DEF VAR nv_prem2    AS DECIMAL                          NO-UNDO.
DEF VAR nv_rstp     AS DECIMAL                          NO-UNDO.
DEF VAR nv_rtax     AS DECIMAL                          NO-UNDO.
DEF VAR nv_key_a    AS DECIMAL INITIAL 0                NO-UNDO.
DEF VAR nv_rec100   AS RECID .
DEF VAR nv_rec120   AS RECID .
DEF VAR nv_rec130   AS RECID .
DEF VAR nv_rec301   AS RECID .
{wgw\wgwkkg72.i}      /*ประกาศตัวแปร*/
DEFINE VAR nv_txt1    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt6    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt7    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt8    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.
DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEF  VAR n_41   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_42   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_43   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEFINE VAR nv_basere   AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0. 
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".
DEFINE VAR nv_maxdes AS CHAR.
DEFINE VAR nv_mindes AS CHAR.
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".
DEFINE VAR nv_simat  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEFINE VAR nv_simat1  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_uwm301trareg    LIKE sic_bran.uwm301.cha_no INIT "".
DEF VAR nv_nptr     AS RECID.

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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.poltyp wdetail.policy wdetail.branch wdetail.renpol wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.iadd1 wdetail.iadd2 wdetail.iadd3 wdetail.iadd4 wdetail.prempa wdetail.subclass wdetail.redbook wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.engno wdetail.chasno wdetail.caryear wdetail.carprovi wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.volprem wdetail.Compprem wdetail.fleet wdetail.ncb wdetail.access wdetail.deductpp wdetail.deductba wdetail.deductpa wdetail.benname wdetail.n_user wdetail.n_IMPORT wdetail.n_export wdetail.drivnam1 wdetail.drivnam wdetail.drivbir1 wdetail.drivbir2 wdetail.drivage1 wdetail.producer wdetail.agent wdetail.comment WDETAIL.WARNING wdetail.cancel   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_load fi_process fi_loaddat fi_pack ~
fi_branch fi_producer fi_bchno fi_agent fi_prevbat fi_bchyr fi_filename ~
bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit ~
br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent fi_outputex RECT-370 RECT-372 ~
RECT-373 RECT-374 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS rs_load fi_process fi_loaddat fi_pack ~
fi_branch fi_producer fi_bchno fi_agent fi_prevbat fi_bchyr fi_filename ~
fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt ~
fi_proname fi_agtname fi_completecnt fi_premtot fi_premsuc fi_outputex 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

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
     SIZE 4 BY .95.

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

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 63.5 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 63.5 BY .95
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
     SIZE 18 BY .95
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

DEFINE VARIABLE fi_outputex AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(18)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 68 BY 1
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 63.5 BY 1
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_load AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Have Sticker no.", 1,
"No Sticker no. ", 2,
"Match Policy ", 3
     SIZE 88.33 BY 1
     BGCOLOR 8 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.43
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 14.29
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 5.48
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 2.67
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 2
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail C-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.poltyp   COLUMN-LABEL "Policy Type"
      wdetail.policy   COLUMN-LABEL "Policy"
      wdetail.branch   COLUMN-LABEL "BR "
      wdetail.renpol   COLUMN-LABEL "Renew Policy"
      wdetail.tiname   COLUMN-LABEL "Title Name"   
      wdetail.insnam   COLUMN-LABEL "Insured Name" 
      wdetail.comdat   COLUMN-LABEL "Comm Date"
      wdetail.expdat   COLUMN-LABEL "Expiry Date"
      wdetail.compul   COLUMN-LABEL "Compulsory"
      wdetail.iadd1    COLUMN-LABEL "Ins Add1"
      wdetail.iadd2    COLUMN-LABEL "Ins Add2"
      wdetail.iadd3    COLUMN-LABEL "Ins Add3"
      wdetail.iadd4    COLUMN-LABEL "Ins Add4"
      wdetail.prempa   COLUMN-LABEL "Premium Package"
      wdetail.subclass COLUMN-LABEL "Sub Class"
      wdetail.redbook  COLUMN-LABEL "RedBook"
      wdetail.brand    COLUMN-LABEL "Brand"
      wdetail.model    COLUMN-LABEL "Model"
      wdetail.cc       COLUMN-LABEL "CC"
      wdetail.weight   COLUMN-LABEL "Weight"
      wdetail.seat     COLUMN-LABEL "Seat"
      wdetail.body     COLUMN-LABEL "Body"
      wdetail.vehreg   COLUMN-LABEL "Vehicle Register"
      wdetail.engno    COLUMN-LABEL "Engine NO."
      wdetail.chasno   COLUMN-LABEL "Chassis NO."
      wdetail.caryear  COLUMN-LABEL "Car Year" 
      wdetail.carprovi COLUMN-LABEL "Car Province"
      wdetail.vehuse   COLUMN-LABEL "Vehicle Use" 
      wdetail.garage   COLUMN-LABEL "Garage"
      wdetail.stk      COLUMN-LABEL "Sticker"
      wdetail.covcod   COLUMN-LABEL "Cover Type"
      wdetail.si       COLUMN-LABEL "Sum Insure"
      wdetail.volprem  COLUMN-LABEL "Voluntory Prem"
      wdetail.Compprem COLUMN-LABEL "Compulsory Prem"
      wdetail.fleet    COLUMN-LABEL "Fleet"
      wdetail.ncb      COLUMN-LABEL "NCB"
      wdetail.access   COLUMN-LABEL "Load Claim"
      wdetail.deductpp COLUMN-LABEL "Deduct TP"
      wdetail.deductba COLUMN-LABEL "Deduct DA"
      wdetail.deductpa COLUMN-LABEL "Deduct PD"
      wdetail.benname  COLUMN-LABEL "Benefit Name" 
      wdetail.n_user   COLUMN-LABEL "User"
      wdetail.n_IMPORT COLUMN-LABEL "Import"
      wdetail.n_export COLUMN-LABEL "Export"
      wdetail.drivnam1 COLUMN-LABEL "Driver Name1"
      wdetail.drivnam  COLUMN-LABEL "Driver Name2"
      wdetail.drivbir1 COLUMN-LABEL "Driver Birth1"
      wdetail.drivbir2 COLUMN-LABEL "Driver Birth2"
      wdetail.drivage1 COLUMN-LABEL "Driver Age1"
      wdetail.producer COLUMN-LABEL "Producer"
      wdetail.agent    COLUMN-LABEL "Agent"
      wdetail.comment  FORMAT "x(35)" COLUMN-BGCOLOR  80 COLUMN-LABEL "Comment"
      WDETAIL.WARNING  COLUMN-LABEL "Warning"
      wdetail.cancel   COLUMN-LABEL "Cancel"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 5
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_load AT ROW 2.71 COL 34.17 NO-LABEL
     fi_process AT ROW 15.57 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_loaddat AT ROW 3.86 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 3.86 COL 62.83 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.91 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.95 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 23.05 COL 13.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agent AT ROW 7 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 8.05 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 8.05 COL 70.17 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.1 COL 31.83 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9.1 COL 94.5
     fi_output1 AT ROW 10.14 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.19 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.24 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 14.52 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 14.52 COL 70.17 NO-LABEL
     buok AT ROW 9.67 COL 105
     bu_exit AT ROW 11.81 COL 105
     fi_brndes AT ROW 4.91 COL 52.33 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 16.95 COL 2
     bu_hpbrn AT ROW 4.91 COL 40.83
     bu_hpacno1 AT ROW 5.95 COL 48.83
     fi_impcnt AT ROW 22.48 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpagent AT ROW 7 COL 48.83
     fi_proname AT ROW 5.95 COL 52.33 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 7 COL 52.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.48 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.48 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.52 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_outputex AT ROW 13.29 COL 31.83 COLON-ALIGNED NO-LABEL
     "                    Branch  :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 4.91 COL 9.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 14.52 COL 88
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 23.05 COL 3
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 22.48 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 10.14 COL 9.33
          BGCOLOR 18 FGCOLOR 1 
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 9.1 COL 9.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 12.24 COL 9.33
          BGCOLOR 18 FGCOLOR 1 
     "          Producer  Code :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 5.95 COL 9.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.48 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 23.48 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 14.52 COL 68.33 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Output Excel File :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 13.29 COL 9.33
          BGCOLOR 5 FGCOLOR 1 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "                Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 3.86 COL 9.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "    IMPORT TEXT FILE MOTOR [ KK-V72 ] พรบ." VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.24 COL 1.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 8.05 COL 69.66 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 23.48 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                Type Load :" VIEW-AS TEXT
          SIZE 22.67 BY 1 AT ROW 2.71 COL 9.5
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 23.48 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Previous Batch No.  :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 8.05 COL 9.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 11.19 COL 9.33
          BGCOLOR 18 FGCOLOR 1 
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 14.52 COL 31.33 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "              Agent Code  :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 7 COL 9.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.48 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 3.86 COL 54.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.43 COL 1
     RECT-373 AT ROW 16.71 COL 1
     RECT-374 AT ROW 22.19 COL 1
     RECT-377 AT ROW 9.24 COL 103.83
     RECT-378 AT ROW 11.38 COL 103.83
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
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Load Text file KK[v72]พรบ."
         HEIGHT             = 23.95
         WIDTH              = 132.67
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
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
IF NOT C-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
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
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.83 BY .95 AT ROW 8.05 COL 69.66 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 23 BY .95 AT ROW 14.52 COL 31.33 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .95 AT ROW 14.52 COL 68.33 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.48 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 22.48 COL 95.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 23.48 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 23.48 COL 96 RIGHT-ALIGNED          */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

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

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Load Text file KK[v72]พรบ. */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Load Text file KK[v72]พรบ. */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_wdetail
&Scoped-define SELF-NAME br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_wdetail C-Win
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
          wdetail.poltyp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.renpol:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
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
          wdetail.carprovi:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.vehuse:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.garage:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.stk:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.covcod:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.si:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
          wdetail.volprem:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.Compprem:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.fleet:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.     
          wdetail.ncb:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.access :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.deductpp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductba:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductpa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductpa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.benname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.n_user:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.n_IMPORT:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_export:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivnam1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivnam :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivbir1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivbir2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivage1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.producer:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.agent:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.comment:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          WDETAIL.CANCEL:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          /*new add*/                 


          /*wdetail.entdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.enttim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trandat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trantim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. *//*a490166*/ 
          wdetail.poltyp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.renpol:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
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
          wdetail.carprovi:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehuse:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.garage:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.stk:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.covcod:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.si:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.volprem:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.Compprem:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.fleet:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.ncb:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.access:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
          wdetail.deductpp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductba:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductpa:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.benname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_user:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_IMPORT:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_export:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivnam1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivnam :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivbir1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivbir2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivage1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.producer:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.agent:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comment:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          WDETAIL.WARNING:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          WDETAIL.CANCEL:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
            /*new add*/
            
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    IF rs_load <> 3 THEN DO: /*A60-0232*/
        ASSIGN fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR        = 2 
            fi_bchno:FGCOLOR          = 2
            fi_completecnt            = 0
            fi_premsuc                = 0
            fi_bchno                  = ""
            fi_premtot                = 0
            fi_impcnt                 = 0
            fi_process                = "Start Load Text file KK- Compulsaly ..." .
        
        DISP  fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
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
        ASSIGN fi_output1  = INPUT fi_output1
            fi_output2  = INPUT fi_output2
            fi_output3  = INPUT fi_output3 
            fi_outputex = INPUT fi_outputex.
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
                nv_batrunno = uzm700.runno.
                FIND LAST uzm701 USE-INDEX uzm70102   WHERE 
                    uzm701.bchyr   = nv_batchyr        AND
                    uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999")  NO-LOCK NO-ERROR.
                IF AVAIL uzm701 THEN  
                    ASSIGN 
                    nv_batcnt   = uzm701.bchcnt  
                    nv_batrunno = nv_batrunno + 1.
            END.
            ELSE  
                ASSIGN
                    nv_batcnt = 1
                    nv_batrunno = 1.
            ASSIGN nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
        END.
        ELSE DO:  
            nv_batprev = INPUT fi_prevbat.
            FIND LAST uzm701 USE-INDEX uzm70102    WHERE 
                uzm701.bchyr   = nv_batchyr        AND
                uzm701.bchno   = CAPS(nv_batprev)  NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL uzm701 THEN DO:
                MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev)
                    + " on file uzm701" .
                APPLY "entry" TO fi_prevbat.
                RETURN NO-APPLY.
            END.
            IF AVAIL uzm701 THEN DO:
                ASSIGN 
                nv_batcnt  = uzm701.bchcnt + 1 
                nv_batchno = CAPS(TRIM(nv_batprev)).
            END.
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
        End.
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
            ELSE  
                DELETE WDETAIL.
        END. /*FOR EACH wdetail: */
        IF  nv_reccnt = 0 THEN DO: 
            MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
            RETURN NO-APPLY.
        END.
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

        RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                               INPUT            nv_batchyr ,     /* INT   */
                               INPUT            fi_producer,     /* CHAR  */ 
                               INPUT            nv_batbrn  ,     /* CHAR  */
                               INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                               INPUT            "WGWKKG72" ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                               INPUT            nv_imppol  ,     /* INT   */
                               INPUT            nv_impprem       /* DECI  */
                               ).
        ASSIGN fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
        DISP  fi_bchno   WITH FRAME fr_main.
        
        RUN proc_chktest1.
        
        FOR EACH wdetail WHERE wdetail.pass = "y"  :
            ASSIGN  nv_completecnt = nv_completecnt + 1
                nv_netprm_s    = nv_netprm_s    + decimal(wdetail.volprem) . 
        END.
        ASSIGN nv_rectot = nv_reccnt     
            nv_recsuc = nv_completecnt. 
        /*IF  nv_imppol <> nv_rectot OR
        nv_imppol <> nv_recsuc OR*/
        IF    nv_rectot <> nv_recsuc   THEN DO:
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
        FIND LAST uzm701 USE-INDEX uzm70102  
            WHERE uzm701.bchyr = nv_batchyr  AND
            uzm701.bchno       = nv_batchno  AND
            uzm701.bchcnt      = nv_batcnt   NO-ERROR.
        IF AVAIL uzm701 THEN DO:
            ASSIGN uzm701.recsuc   = nv_recsuc     
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
        RELEASE sicsyac.xmm106.
        RELEASE sic_bran.uwd132.
        RELEASE brstat.detaitem.
        RELEASE sicsyac.xtm600.
        RELEASE sicsyac.xmm600.
        RELEASE sicsyac.xzm056.
        IF nv_batflg = NO THEN DO:  
            ASSIGN
                fi_process = "Error Load text file kk72...!!!"
                fi_completecnt:FGCOLOR = 6
                fi_premsuc    :FGCOLOR = 6 
                fi_bchno      :FGCOLOR = 6. 
            DISP fi_process fi_completecnt fi_premsuc WITH FRAME fr_main.
            MESSAGE "Batch Year  : " STRING(nv_batchyr)     SKIP
                "Batch No.   : " nv_batchno             SKIP
                "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
                TRIM(nv_txtmsg)                         SKIP
                "Please check Data again."      
                VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".        
        END.
        ELSE IF nv_batflg = YES THEN DO: 
            ASSIGN
                fi_process = "Process Complete OK..."
                fi_completecnt:FGCOLOR = 2
                fi_premsuc:FGCOLOR     = 2 
                fi_bchno:FGCOLOR       = 2.
            MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
        END.
        RUN proc_report1 .  
        RUN PROC_REPORT2 .
        RUN proc_screen  .   
        RUN proc_open.  
        DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
        /*output*/
    END.
    /*A60-0232*/
    ELSE DO:
        RUN proc_assign.
        RUN proc_Matchpol.
    END.
    /* end A60-0232*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
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
         IF rs_load <> 3 THEN DO:
            ASSIGN
               fi_filename  = cvData
               fi_output1  = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
               fi_output2  = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
               fi_output3  = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce"  /*txt*/
               fi_outputex = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  + no_add + ".slk".
         END.
         /*A60-0232*/
         ELSE DO:
             ASSIGN
               fi_filename  = cvData
               fi_output1  = SUBSTRING(cvData,1,(R-INDEX(cvData,"\"))) + "MatchPol72_KK" + no_add + ".slk"  /*.csv*/
               fi_output2  = ""
               fi_output3  = ""
               fi_outputex = "".
         END.
         /* end A60-0232 */
         DISP fi_filename fi_output1 fi_output2 fi_output3 fi_outputex  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
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
            nv_agent   =  fi_agent.             /*note add  08/11/05*/
            
        END. /*end note 10/11/2005*/
    END. /*Then fi_agent <> ""*/
    
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
  fi_loaddat  =  Input  fi_loaddat.
  Disp  fi_loaddat  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack C-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
    
  fi_pack  =  Input  fi_pack.
  Disp  fi_pack  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
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
                nv_producer = fi_producer .             /*note add  08/11/05*/
                
            END.
  END.

  Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrcnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrcnt C-Win
ON LEAVE OF fi_usrcnt IN FRAME fr_main
DO:
  fi_usrcnt = INPUT fi_usrcnt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrprem C-Win
ON LEAVE OF fi_usrprem IN FRAME fr_main
DO:
  fi_usrprem = INPUT fi_usrprem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_load
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_load C-Win
ON VALUE-CHANGED OF rs_load IN FRAME fr_main
DO:
    rs_load = INPUT rs_load.
    DISP rs_load WITH FRAM fr_main.
  
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
  
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.


/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "Wgwkkg72".
  gv_prog  = "Load Text & Generate (KK- V72 พรบ.)".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).   /*28/11/2006*/
  ASSIGN
      fi_pack     = "Z"
      fi_branch   = "M"
      /*fi_producer = "A0M1005" */ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      /*fi_agent    = "B3M0006"*/  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      fi_producer = "B3MLKK0101"   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      fi_agent    = "B3MLKK0100"   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      fi_bchyr    = YEAR(TODAY) 
      rs_load     = 1. /*A59-0590*/
  DISP fi_pack fi_branch fi_producer fi_agent fi_bchyr rs_load WITH FRAME fr_main.
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  DISPLAY rs_load fi_process fi_loaddat fi_pack fi_branch fi_producer fi_bchno 
          fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 
          fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_proname 
          fi_agtname fi_completecnt fi_premtot fi_premsuc fi_outputex 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE rs_load fi_process fi_loaddat fi_pack fi_branch fi_producer fi_bchno 
         fi_agent fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 
         fi_output3 fi_usrcnt fi_usrprem buok bu_exit br_wdetail bu_hpbrn 
         bu_hpacno1 bu_hpagent fi_outputex RECT-370 RECT-372 RECT-373 RECT-374 
         RECT-377 RECT-378 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72 C-Win 
PROCEDURE proc_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    wdetail.compul = "y"
    wdetail.tariff = "9" . 
IF      wdetail.subclass = "110"  THEN wdetail.seat   = "7".   /*A54-0126*/
ELSE IF wdetail.subclass = "140A" THEN wdetail.seat   = "3".   /*A54-0126*/ 
ELSE IF wdetail.subclass = "120A" THEN wdetail.seat   = "12".  /*A54-0126*/ 
IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass            = "N"
        wdetail.OK_GEN          = "N". 
END.
IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk <> "" THEN DO:    
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + trim(wdetail.stk).
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN 
            wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
            wdetail.pass    = ""
            wdetail.OK_GEN  = "N".
    END.
END.
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class  = wdetail.subclass  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN 
    wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
    wdetail.pass    = "N"
    wdetail.OK_GEN  = "N".
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
IF wdetail.branch = ""  THEN
    ASSIGN 
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| สาขาเป็นค่าว่าง  "
        wdetail.OK_GEN  = "N".
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
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
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
END.  */
IF chkred = NO  THEN DO:
    /*FIND LAST sicsyac.xmm102 WHERE 
        /*sicsyac.xmm102.modest = wdetail.brand + wdetail.model AND
        sicsyac.xmm102.engine = INTE(wdetail.cc)              AND 
        sicsyac.xmm102.tons   = INTE(wdetail.weight)          AND
        sicsyac.xmm102.seats  = INTE(wdetail.seat) NO-LOCK NO-ERROR.*/
        sicsyac.xmm102.moddes  = wdetail.brand NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm102  THEN DO:
        /*  MESSAGE "not find on table xmm102".*/
        ASSIGN  
            /* wdetail.pass    = "N"  */
            wdetail.comment = wdetail.comment + "| not find on table xmm102".
        /*wdetail.OK_GEN  = "N".     A52-0172*/
    END.
    ELSE DO:
        ASSIGN 
            wdetail.redbook = sicsyac.xmm102.modcod
            /*wdetail.body    = sicsyac.xmm102.body   */
            wdetail.body    = IF wdetail.subclass = "110" THEN  "SEDAN  " ELSE "PICKUP" .  
            /*wdetail.seat    = string(sicsyac.xmm102.seats)*/   . 
    END. */
    RUN proc_redbook72.
END.  /* chkred = NO ...*/
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
        sicuw.uwm100.trty11 = "M"                             AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999") NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN 
        ASSIGN     /*a490166*/     
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 C-Win 
PROCEDURE proc_722 :
/* ---------------------------------------------  U W M 1 3 0 -------------- */
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND   /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND   /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND   /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr             AND   /*26/10/2006 change field name */
    sic_bran.uwm130.bchno  = nv_batchno             AND   /*26/10/2006 change field name */ 
    sic_bran.uwm130.bchcnt = nv_batcnt                    /*26/10/2006 change field name */            
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
        sic_bran.uwm301.tariff  = wdetail.tariff
        sic_bran.uwm301.covcod  = nv_covcod
        sic_bran.uwm301.cha_no  = trim(wdetail.chasno) 
        sic_bran.uwm301.trareg  = trim(wdetail.chasno)  /*A60-0232*/
        sic_bran.uwm301.eng_no  = wdetail.eng
        sic_bran.uwm301.Tons    = INTEGER(wdetail.weight)
        /*sic_bran.uwm301.engine  = INTEGER(wdetail.cc)*/ /*A54-0126*/
        sic_bran.uwm301.engine  = 0                     /*A54-0126*/
        sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage  = wdetail.garage
        sic_bran.uwm301.body    = wdetail.body
        sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = wdetail.benname
        sic_bran.uwm301.vehreg   = wdetail.vehreg 
        sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model 
        sic_bran.uwm301.modcod   = wdetail.redbook 
        sic_bran.uwm301.sckno    = 0              
        sic_bran.uwm301.itmdel   = NO
        sic_bran.uwm301.bchyr    = nv_batchyr         /* batch Year */      
        sic_bran.uwm301.bchno    = nv_batchno         /* bchno    */      
        sic_bran.uwm301.bchcnt   = nv_batcnt .        /* bchcnt     */  
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
    IF wdetail.redbook <> "" THEN DO:   /*กรณีที่มีการระบุ Code รถมา*/
        FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
            sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102 THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod         = sicsyac.xmm102.modcod
                /*Substring(sic_bran.uwm301.moddes,1,18)   = SUBSTRING(xmm102.modest, 1,18)  /*Thai language*/  
                Substring(sic_bran.uwm301.moddes,19,22)  = SUBSTRING(xmm102.modest,19,22)  /*Thai Language*/*/
                sic_bran.uwm301.Tons           = sicsyac.xmm102.tons
                /*sic_bran.uwm301.engine         = sicsyac.xmm102.engine*//*A54-0126*/
                /*sic_bran.uwm301.moddes         = sicsyac.xmm102.modest*/
                /*sic_bran.uwm301.body           = sicsyac.xmm102.body    /*A54-0126*/*/
                /*sic_bran.uwm301.seats          = sicsyac.xmm102.seats*/
                sic_bran.uwm301.vehgrp         = sicsyac.xmm102.vehgrp
                /*wdetail.weight                 = string(sicsyac.xmm102.tons) */ 
                /*wdetail.cc                     = string(sicsyac.xmm102.engine)*/
                /*wdetail.seat                   = string(sicsyac.xmm102.seats)*/
                wdetail.redbook                = sicsyac.xmm102.modcod
                wdetail.brand                  = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/
                /*wdetail.model                  = SUBSTRING(xmm102.modest,19,22)*/  .  /*Thai*/
        END.
    END.
    ELSE DO:
        ASSIGN
        nv_simat = DECI(wdetail.si) - (DECI(wdetail.si) * 20 / 100 )
        nv_simat1 = DECI(wdetail.si) + (DECI(wdetail.si) * 20 / 100 )  .
        FIND LAST sicsyac.xmm102 WHERE 
            /*sicsyac.xmm102.modest = wdetail.brand + wdetail.model AND*/
            INDEX(sicsyac.xmm102.modest,wdetail.brand) <> 0 AND
            INDEX(sicsyac.xmm102.modest,n_model) <> 0 AND
            /*sicsyac.xmm102.engine = INTE(wdetail.cc) AND */
            /*sicsyac.xmm102.tons   = INTE(wdetail.weight) AND*/
            sicsyac.xmm102.seats  >= INTE(wdetail.seat)
            NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102  THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod         = sicsyac.xmm102.modcod
                /*Substring(sic_bran.uwm301.moddes,1,18)   = SUBSTRING(xmm102.modest, 1,18)  /*Thai language*/  
                Substring(sic_bran.uwm301.moddes,19,22)  = SUBSTRING(xmm102.modest,19,22)  /*Thai Language*/*/
                sic_bran.uwm301.Tons           = sicsyac.xmm102.tons
                /*sic_bran.uwm301.engine         = sicsyac.xmm102.engine*//*A54-0126*/
                /*sic_bran.uwm301.moddes         = sicsyac.xmm102.modest*/
                sic_bran.uwm301.body           = sicsyac.xmm102.body
                /*sic_bran.uwm301.seats          = sicsyac.xmm102.seats*/
                sic_bran.uwm301.vehgrp         = sicsyac.xmm102.vehgrp
                wdetail.weight                 = string(sicsyac.xmm102.tons)  
                wdetail.cc                     = string(sicsyac.xmm102.engine)
                /*wdetail.seat                   = string(sicsyac.xmm102.seats)*/
                wdetail.redbook                = sicsyac.xmm102.modcod
                wdetail.brand                  = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/
                /*wdetail.model                  = SUBSTRING(xmm102.modest,19,22)*/ .  /*Thai*/
        END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_723 C-Win 
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
        sicsyac.xmm107.tariff = wdetail.tariff
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
                sicsyac.xmm105.tariff = wdetail.tariff  AND
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:  /* Malaysia */
                IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.cc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.cc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.weight).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
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
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= 0                AND
                    sicsyac.xmm106.key_b  >= 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
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
                    sicsyac.xmm105.tariff = wdetail.tariff  AND
                    sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
                ELSE   MESSAGE "ไม่พบ Tariff นี้ในระบบ กรุณาใส่ Tariff ใหม่" 
                    "Tariff" wdetail.tariff "Bencod"  xmd107.bencod VIEW-AS ALERT-BOX.
                IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
                    IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.cc).
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.cc).
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.weight).
                    nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff   AND
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
                        sicsyac.xmm106.tariff  = wdetail.tariff           AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.subclass         AND
                        sicsyac.xmm106.covcod  = wdetail.covcod           AND
                        sicsyac.xmm106.key_a  >= 0                        AND
                        sicsyac.xmm106.key_b  >= 0                        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601                  WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff            AND
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
        MESSAGE "ไม่พบ Class " wdetail.subclass " ใน Tariff  " wdetail.tariff  skip
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
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
                IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.cc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.cc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.weight).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff          AND
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
                    sicsyac.xmm106.tariff  = wdetail.tariff      AND 
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod       AND 
                    sicsyac.xmm106.class   = wdetail.subclass    AND 
                    sicsyac.xmm106.covcod  = wdetail.covcod      AND 
                    sicsyac.xmm106.key_a  >= 0                   AND 
                    sicsyac.xmm106.key_b  >= 0                   AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_7231 C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addr72 C-Win 
PROCEDURE proc_addr72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN wdetail2.ad11  = wdetail2.addr72
    wdetail2.road = ""
    wdetail2.soy  = ""
    wdetail2.ad12 = ""
    wdetail2.ad13 = ""
    wdetail2.ad14 = "".
IF (R-index(wdetail2.ad11,"กทม") <> 0) OR (R-index(wdetail2.ad11,"กรุง") <> 0) THEN DO:
    IF (R-index(wdetail2.ad11,"กทม") <> 0)  THEN
        ASSIGN wdetail2.ad14 = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"กทม")))
               wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"กทม") - 1)).
END.
ELSE DO: /* jungwat */
    IF (R-index(wdetail2.ad11,"จังหวัด") <> 0)  THEN 
        ASSIGN wdetail2.ad14 = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"จังหวัด")))
        wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"จังหวัด") - 1)).
    ELSE IF (R-index(wdetail2.ad11,"จ.") <> 0)  THEN
        ASSIGN wdetail2.ad14 = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"จ.")))
               wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"จ.") - 1)).
END.
IF (R-index(wdetail2.ad11,"อ.") <> 0)  THEN
        ASSIGN wdetail2.ad13 = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"อ.")))
               wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"อ.") - 1)).
ELSE IF (R-index(wdetail2.ad11,"อำเภอ") <> 0)  THEN
        ASSIGN wdetail2.ad13 = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"อำเภอ")))
               wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"อำเภอ") - 1)).
ELSE IF (R-index(wdetail2.ad11,"เขต") <> 0)  THEN
        ASSIGN wdetail2.ad13 = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"เขต")))
               wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"เขต") - 1)).

IF (R-index(wdetail2.ad11,"ต.") <> 0)  THEN
        ASSIGN wdetail2.ad12 = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"ต.")))
               wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"ต.") - 1)).
ELSE IF (R-index(wdetail2.ad11,"ตำบล") <> 0)  THEN
        ASSIGN wdetail2.ad12 = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"ตำบล")))
               wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"ตำบล") - 1)).
ELSE IF (R-index(wdetail2.ad11,"แขวง") <> 0)  THEN
        ASSIGN wdetail2.ad12 = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"แขวง")))
               wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"แขวง") - 1)).

IF LENGTH(wdetail2.ad11) > 35 THEN DO:
    IF (R-index(wdetail2.ad11,"ถ.") <> 0) OR (R-index(wdetail2.ad11,"ถนน") <> 0)  THEN DO:
        IF (R-index(wdetail2.ad11,"ถ.") <> 0) THEN 
            ASSIGN wdetail2.road = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"ถ.")))
            wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"ถ.") - 1)).
        ELSE IF (R-index(wdetail2.ad11,"ถนน") <> 0)  THEN
            ASSIGN wdetail2.road = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"ถนน")))
            wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"ถนน") - 1)).
        IF LENGTH( wdetail2.road + " " + wdetail2.ad12) <= 35 THEN DO:
            ASSIGN wdetail2.ad12 = wdetail2.road + " " + wdetail2.ad12.
            IF LENGTH(wdetail2.ad13 + " " + wdetail2.ad14) <= 35 THEN
                ASSIGN wdetail2.ad13 = wdetail2.ad13 + " " + wdetail2.ad14
                wdetail2.ad14 = "".
        END.
        ELSE IF  LENGTH( wdetail2.ad12 + " " + wdetail2.ad13) <= 35 THEN DO:
            ASSIGN wdetail2.ad13 = wdetail2.ad12 + " " + wdetail2.ad13
                wdetail2.ad12 = wdetail2.road .
        END.
    END.
    ELSE IF (R-index(wdetail2.ad11,"ซ.") <> 0) OR (R-index(wdetail2.ad11,"ซอย") <> 0)  THEN DO:
        IF (R-index(wdetail2.ad11,"ซ.") <> 0) THEN 
            ASSIGN wdetail2.soy = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"ซ.")))
            wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"ซ.") - 1)).
        ELSE IF (R-index(wdetail2.ad11,"ซอย") <> 0)  THEN
            ASSIGN wdetail2.soy = trim(SUBSTR(wdetail2.ad11,R-index(wdetail2.ad11,"ซอย")))
            wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-index(wdetail2.ad11,"ซอย") - 1)).
        IF LENGTH( wdetail2.soy + " " + wdetail2.ad12) <= 35 THEN DO:
            ASSIGN wdetail2.ad12 = wdetail2.soy + " " + wdetail2.ad12.
            IF LENGTH(wdetail2.ad13 + " " + wdetail2.ad14) <= 35 THEN
                ASSIGN wdetail2.ad13 = wdetail2.ad13 + " " + wdetail2.ad14
                wdetail2.ad14 = "".
        END.
        ELSE IF  LENGTH( wdetail2.ad12 + " " + wdetail2.ad13) <= 35 THEN DO:
            ASSIGN wdetail2.ad13 = wdetail2.ad12 + " " + wdetail2.ad13
                wdetail2.ad12 = wdetail2.soy .
        END.
    END.
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
FOR EACH wdetail2:       /*A60-0232 */
    DELETE wdetail2.     /*A60-0232 */
END.                    /*A60-0232 */

INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail2.
    IMPORT DELIMITER "|" 
        /*comment by Kridtiya i. a56-0212....
        wdetail2.id          
        wdetail2.br_nam      
        wdetail2.number      
        wdetail2.polstk      
        wdetail2.recivedat   
        wdetail2.cedpol      
        wdetail2.insurnam    
        wdetail2.vehreg      
        wdetail2.brand       
        wdetail2.model       
        wdetail2.notifyno    
        wdetail2.namnotify   
        wdetail2.chassis     
        wdetail2.comp        
        wdetail2.premt       
        wdetail2.comdat      
        wdetail2.expdat      
        wdetail2.memmo
        wdetail2.addr72  .   /* A55-0240 */
        end..comment by Kridtiya i. a56-0212....*/
        /*Add  by Kridtiya i. a56-0212...*/
        wdetail2.polstk     /* เลขที่กรมธรรม์พ.ร.บ.    */    
        wdetail2.cedpol     /* เลขที่สัญญา */                
        wdetail2.br_nam     /* ชื่อสาขา(ดีเลอร์)   */        
        wdetail2.branch     /* สาขา    */                    
        wdetail2.class      /* คลาสรถ  */                    
        wdetail2.comp       /* เบี้ยพรบ.   */                
        wdetail2.premt      /* เบี้ยรวม    */                
        wdetail2.recivedat  /* วันที่ รับชำระค่าพรบ.   */    
        wdetail2.comdat     /* วันที่เริ่มคุ้มครอง */        
        wdetail2.expdat     /* วันที่สิ้นสุดความคุ้มครอง   */
        wdetail2.namTITLE   /* คำนาม   */                    
        wdetail2.insurnam   /* ชื่อ    */                    
        wdetail2.icno       /* เลขที่บัตรประชาชน   */        
        wdetail2.ad11       /* ที่อยู่1    */                
        wdetail2.ad12       /* ที่อยู่2    */                
        wdetail2.ad13       /* ที่อยู่3    */                
        wdetail2.ad14       /* ที่อยู่4    */                
        wdetail2.brand      /* ยี่ห้อรถ    */                
        wdetail2.model      /* รุ่นรถ  */                    
        wdetail2.vehreg     /* ทะเบียนรถ   */                
        wdetail2.chassis    /* เลขตัวถัง   */                
        wdetail2.number     /* เลขสติ๊กเกอร์   */            
        wdetail2.benname    /* ผู้รับผลประโยชน์    */        
        wdetail2.notifyno   /* เลขที่รับแจ้ง   */            
        wdetail2.namnotify  /* ผู้แจ้ง (Mkt)   */            
        wdetail2.memmo      /* หมายเหตุ/วันที่ออกพรบ.  */ 
        wdetail2.phone      /*A60-0232*/
        wdetail2.tname1     /*A60-0232*/
        wdetail2.cname1     /*A60-0232*/
        wdetail2.lname1     /*A60-0232*/
        wdetail2.icno1      /*A60-0232*/
        wdetail2.tname2     /*A60-0232*/
        wdetail2.cname2     /*A60-0232*/
        wdetail2.lname2     /*A60-0232*/
        wdetail2.icno2      /*A60-0232*/
        wdetail2.tname3     /*A60-0232*/
        wdetail2.cname3     /*A60-0232*/
        wdetail2.lname3     /*A60-0232*/
        wdetail2.icno3      /*A60-0232*/
        wdetail2.nsend      /*A61-0335*/
        wdetail2.sendname   /*A61-0335*/
        wdetail2.kkapp    .  /*A61-0335*/
END.    /*-Repeat-*/
IF rs_load <> 3 THEN DO:  /*A60-0232*/
    RUN proc_assign2.
    RUN proc_reportex.
    RUN proc_assign3.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2 C-Win 
PROCEDURE proc_assign2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_dayno    AS DECI init 0 .
DEF VAR n_brkk_add AS CHAR FORMAT "x(40)" INIT "" .
FOR EACH wdetail2 .
    IF index(wdetail2.polstk,"Text") <> 0  THEN DELETE wdetail2.
    ELSE IF index(wdetail2.polstk,"เลขที่") <> 0  THEN DELETE wdetail2.
    ELSE IF index(wdetail2.polstk,"ลำดับ") <> 0  THEN DELETE wdetail2.
    ELSE DO:
    IF wdetail2.cedpol NE "" THEN DO:
        /*--- A60-0232 ----
        IF INDEX(wdetail2.br_nam,"สาขา") = 0 THEN DO: /* file new */
            ASSIGN 
                n_brkk_add = "" 
                n_brkk_add = IF      INDEX(wdetail2.br_nam,"-")    <> 0 THEN SUBSTR(wdetail2.br_nam,INDEX(wdetail2.br_nam,"-") + 1 ) 
                             ELSE IF INDEX(wdetail2.br_nam,"สาขา") <> 0 THEN SUBSTR(wdetail2.br_nam,INDEX(wdetail2.br_nam,"สาขา") + 4 ) 
                             ELSE wdetail2.br_nam  
                n_brkk_add = REPLACE(n_brkk_add,"สาขา","")
                n_brkk_add = REPLACE(n_brkk_add,"-","").
            FIND FIRST stat.insure USE-INDEX insure03 WHERE 
                stat.insure.compno = "kk"             AND
                stat.insure.fname  = n_brkk_add       NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL insure THEN DO:
                ASSIGN 
                /*wdetail2.branch   = stat.insure.branch */
                wdetail2.ad11 = trim(insure.Addr1)          
                wdetail2.ad12 = trim(insure.Addr2)
                wdetail2.ad13 = trim(insure.Addr3)
                wdetail2.ad14 = trim(insure.Addr4)
                wdetail2.vatcode   = insure.vatcode   .   /*นำ field cc มารับค่า vatcode เนื่องจากเดิมไม่มีค่า*/
            END.
            /*ELSE ASSIGN   
                /*wdetail2.branch = ""*/
                wdetail2.ad11 = trim(wdetail2.ad11) 
                wdetail2.ad12 = trim(wdetail2.ad12) 
                wdetail2.ad13 = trim(wdetail2.ad13) 
                wdetail2.ad14 = trim(wdetail2.ad14) 
                wdetail2.vatcode   = ""  .*/
        END.
        ELSE DO: --End A60-0232---- */ /*address kk by ลูกค้า ตามไฟล์ */
            IF LENGTH(trim(wdetail2.ad11)) > 35 THEN DO:
                ASSIGN 
                    wdetail2.ad12 = trim(SUBSTR(wdetail2.ad11,R-INDEX(wdetail2.ad11," "))) + " " + trim(wdetail2.ad12)
                    wdetail2.ad11 = trim(SUBSTR(wdetail2.ad11,1,R-INDEX(wdetail2.ad11," "))) .
                IF LENGTH(wdetail2.ad12) > 35  THEN DO:
                    ASSIGN 
                    wdetail2.ad13 = trim(SUBSTR(wdetail2.ad12,R-INDEX(wdetail2.ad12," "))) + " " + trim(wdetail2.ad13)
                    wdetail2.ad12 = trim(SUBSTR(wdetail2.ad12,1,R-INDEX(wdetail2.ad12," "))) .
                END.
                IF LENGTH(wdetail2.ad13) > 35  THEN DO:
                    ASSIGN 
                    wdetail2.ad14 = trim(SUBSTR(wdetail2.ad13,R-INDEX(wdetail2.ad13," "))) + " " + trim(wdetail2.ad14)
                    wdetail2.ad13 = trim(SUBSTR(wdetail2.ad13,1,R-INDEX(wdetail2.ad13," "))) .
                END.
            END.
            ELSE DO:
                IF LENGTH(wdetail2.ad12) > 35  THEN DO:
                    ASSIGN 
                    wdetail2.ad13 = trim(SUBSTR(wdetail2.ad12,R-INDEX(wdetail2.ad12," "))) + " " + trim(wdetail2.ad13)
                    wdetail2.ad12 = trim(SUBSTR(wdetail2.ad12,1,R-INDEX(wdetail2.ad12," "))) .
                END.
                IF LENGTH(wdetail2.ad13) > 35  THEN DO:
                    ASSIGN 
                    wdetail2.ad14 = trim(SUBSTR(wdetail2.ad13,R-INDEX(wdetail2.ad13," "))) + " " + trim(wdetail2.ad14)
                    wdetail2.ad13 = trim(SUBSTR(wdetail2.ad13,1,R-INDEX(wdetail2.ad13," "))) .
                END.
            END.
        /*END.*/
    END.  /*IF wdetail2.cedpol NE ""*/
    /*IF wdetail2.addr72 <> "" THEN RUN proc_addr72.   /*A55-0240*/*/
    IF year(date(wdetail2.expdat)) >= (YEAR((TODAY)) + 544)  THEN
        ASSIGN wdetail2.expdat = string(DAY(date(wdetail2.expdat)),"99")   + "/" +
                                  string(MONTH(date(wdetail2.expdat)),"99")  + "/" +
                                  string(year(date(wdetail2.expdat)) - 543 ,"9999") .
    IF year(date(wdetail2.comdat)) >= (YEAR((TODAY)) + 543)  THEN
        ASSIGN wdetail2.comdat =  string(DAY(date(wdetail2.comdat)),"99")   + "/" +
                                  string(MONTH(date(wdetail2.comdat)),"99")  + "/" +
                                  string(year(date(wdetail2.comdat))- 543 ,"9999") .

    IF wdetail2.class = "" THEN DO:
        ASSIGN n_dayno = date(wdetail2.expdat) - date(wdetail2.comdat) 
            n_dayno    = n_dayno / 365.
        IF n_dayno GE 1  THEN DO:  /* 1 ปีขึ้นไป */
            IF deci(wdetail2.comp) < 1100  THEN DO: 
                IF deci(wdetail2.comp) < 900 THEN 
                    ASSIGN wdetail2.class = "110".
                ELSE                               
                    ASSIGN wdetail2.class = "140A" .
            END.
            ELSE ASSIGN wdetail2.class = "120A" .
        END.
        ELSE DO:   /* ไม่ถึง ปี 1 */
            IF deci(wdetail2.comp) LE 1100  THEN DO: 
                IF deci(wdetail2.comp) LE 900 THEN DO: 
                    IF deci(wdetail2.comp) LE 600 THEN 
                        ASSIGN wdetail2.class = "110".
                    ELSE ASSIGN wdetail2.class = "140A".
                END.
                ELSE 
                    ASSIGN wdetail2.class = "120A".
            END.
            ELSE ASSIGN wdetail2.class = "120A".
        END.
    END.
    /*
    RUN proc_cutcharpol.
    /*RUN proc_cutnamtitle.*//* A54-0203 */
    RUN proc_vehmat.*/
    END.
END.
/*RUN proc_assign2_veh. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2addr C-Win 
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

ASSIGN nv_address = trim(np_tambon + " " + np_mail_amper + " " + np_mail_country)  
       nv_postcd  = "".

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2_veh C-Win 
PROCEDURE proc_assign2_veh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2 .
    IF wdetail2.cedpol NE "" THEN DO:
/*1*/   IF wdetail2.veh_country = "กระบี่"        THEN wdetail2.veh_country = "กบ".
/*2*/   IF wdetail2.veh_country = "กรุงเทพมหานคร" THEN wdetail2.veh_country = "กท".
/*3*/   IF wdetail2.veh_country = "กาญจนบุรี"     THEN wdetail2.veh_country = "กจ".
/*4*/   IF wdetail2.veh_country = "กาฬสินธุ์"     THEN wdetail2.veh_country = "กส".
/*5*/   IF wdetail2.veh_country = "กำแพงเพชร"     THEN wdetail2.veh_country = "กพ".
/*6*/   IF wdetail2.veh_country = "ขอนแก่น"       THEN wdetail2.veh_country = "ขก".
/*7*/   IF wdetail2.veh_country = "จันทบุรี"      THEN wdetail2.veh_country = "จท".
/*8*/   IF wdetail2.veh_country = "ฉะเชิงเทรา"    THEN wdetail2.veh_country = "ฉท".
/*9*/   IF wdetail2.veh_country = "ชลบุรี"        THEN wdetail2.veh_country = "ชบ".
/*10*/  IF wdetail2.veh_country = "ชัยนาท"        THEN wdetail2.veh_country = "ชน".
/*11*/  IF wdetail2.veh_country = "ชัยภูมิ"       THEN wdetail2.veh_country = "ชย".
/*12*/  IF wdetail2.veh_country = "ชุมพร"         THEN wdetail2.veh_country = "ชพ".
/*13*/  IF wdetail2.veh_country = "เชียงราย"      THEN wdetail2.veh_country = "ชร".
/*14*/  IF wdetail2.veh_country = "เชียงใหม่"     THEN wdetail2.veh_country = "ชม".
/*15*/  IF wdetail2.veh_country = "ตรัง"          THEN wdetail2.veh_country = "ตง".
/*16*/  IF wdetail2.veh_country = "ตราด"          THEN wdetail2.veh_country = "ตร".
/*17*/  IF wdetail2.veh_country = "ตาก"           THEN wdetail2.veh_country = "ตก".
/*18*/  IF wdetail2.veh_country = "นครนายก"       THEN wdetail2.veh_country = "นย".
/*19*/  IF wdetail2.veh_country = "นครปฐม"        THEN wdetail2.veh_country = "นฐ".
/*20*/  IF wdetail2.veh_country = "นครพนม"        THEN wdetail2.veh_country = "นพ".
/*21*/  IF wdetail2.veh_country = "นครราชสีมา"    THEN wdetail2.veh_country = "นม".
/*22*/  IF wdetail2.veh_country = "นครศรีธรรมราช" THEN wdetail2.veh_country = "นศ".
/*23*/  IF wdetail2.veh_country = "นครสวรรค์"     THEN wdetail2.veh_country = "นว".
/*24*/  IF wdetail2.veh_country = "นนทบุรี"       THEN wdetail2.veh_country = "นบ".
/*25*/  IF wdetail2.veh_country = "นราธวาส"       THEN wdetail2.veh_country = "นธ".
/*26*/  IF wdetail2.veh_country = "น่าน"          THEN wdetail2.veh_country = "นน".
/*27*/  IF wdetail2.veh_country = "บุรีรัมย์"     THEN wdetail2.veh_country = "บร".
/*28*/  IF wdetail2.veh_country = "ปทุมธานี"      THEN wdetail2.veh_country = "ปท".
/*29*/  IF wdetail2.veh_country = "ประจวบคีรีขันธ์" THEN wdetail2.veh_country = "ปข".
/*30*/  IF wdetail2.veh_country = "ปราจีนบุรี"   THEN wdetail2.veh_country = "ปจ".
/*31*/  IF wdetail2.veh_country = "ปัตตานี"      THEN wdetail2.veh_country = "ปน".
/*32*/  IF wdetail2.veh_country = "พระนครศรีอยุธยา" OR wdetail2.veh_country = "อยุธยา" THEN wdetail2.veh_country = "อย".
/*33*/  IF wdetail2.veh_country = "พะเยา"      THEN wdetail2.veh_country = "พย".
/*34*/  IF wdetail2.veh_country = "พังงา"      THEN wdetail2.veh_country = "พง".
/*35*/  IF wdetail2.veh_country = "พัทลุง"     THEN wdetail2.veh_country = "พท".
/*36*/  IF wdetail2.veh_country = "พิจิตร"     THEN wdetail2.veh_country = "พจ".
/*37*/  IF wdetail2.veh_country = "พิษณุโลก"   THEN wdetail2.veh_country = "พล".
/*38*/  IF wdetail2.veh_country = "เพชรบุรี"   THEN wdetail2.veh_country = "พบ".
/*39*/  IF wdetail2.veh_country = "เพชรบูรณ์"  THEN wdetail2.veh_country = "พช".
/*40*/  IF wdetail2.veh_country = "แพร่"       THEN wdetail2.veh_country = "พร".
/*41*/  IF wdetail2.veh_country = "ภูเก็ต"     THEN wdetail2.veh_country = "ภก".
/*42*/  IF wdetail2.veh_country = "มหาสารคาม"  THEN wdetail2.veh_country = "มค".
/*43*/  IF wdetail2.veh_country = "มุกดาหาร"   THEN wdetail2.veh_country = "มห".
/*44*/  IF wdetail2.veh_country = "แม่ฮ่องสอน" THEN wdetail2.veh_country = "มส".
/*45*/  IF wdetail2.veh_country = "ยะลา"       THEN wdetail2.veh_country = "ยล".
/*46*/  IF wdetail2.veh_country = "ร้อยเอ็ด"   THEN wdetail2.veh_country = "รอ".
/*47*/  IF wdetail2.veh_country = "ระนอง"      THEN wdetail2.veh_country = "รน".
/*48*/  IF wdetail2.veh_country = "ระยอง"      THEN wdetail2.veh_country = "รย".
/*49*/  IF wdetail2.veh_country = "ราชบุรี"    THEN wdetail2.veh_country = "รบ".
/*50*/  IF wdetail2.veh_country = "ลพบุรี"     THEN wdetail2.veh_country = "ลบ".
/*51*/  IF wdetail2.veh_country = "ลำปาง"      THEN wdetail2.veh_country = "ลป".
/*52*/  IF wdetail2.veh_country = "ลำพูน"      THEN wdetail2.veh_country = "ลพ".
/*53*/  IF wdetail2.veh_country = "เลย"        THEN wdetail2.veh_country = "ลย".
/*54*/  IF wdetail2.veh_country = "ศรีสะเกษ"   THEN wdetail2.veh_country = "ศก".
/*55*/  IF wdetail2.veh_country = "สกลนคร"     THEN wdetail2.veh_country = "สน".
/*56*/  IF wdetail2.veh_country = "สงขลา"      THEN wdetail2.veh_country = "สข".
/*57*/  IF wdetail2.veh_country = "สระแก้ว"    THEN wdetail2.veh_country = "สก".
/*58*/  IF wdetail2.veh_country = "สระบุรี"    THEN wdetail2.veh_country = "สบ".
/*59*/  IF wdetail2.veh_country = "สิงห์บุรี"  THEN wdetail2.veh_country = "สห".
/*60*/  IF wdetail2.veh_country = "สุโขทัย"    THEN wdetail2.veh_country = "สท".
/*61*/  IF wdetail2.veh_country = "สุพรรณบุรี" THEN wdetail2.veh_country = "สพ".
/*62*/  IF wdetail2.veh_country = "สุราษฎร์ธานี" THEN wdetail2.veh_country = "สฎ".
/*63*/  IF wdetail2.veh_country = "สุรินทร์"    THEN wdetail2.veh_country = "สร".
/*64*/  IF wdetail2.veh_country = "หนองคาย"     THEN wdetail2.veh_country = "นค".
/*65*/  IF wdetail2.veh_country = "หนองบัวลำพู" THEN wdetail2.veh_country = "นล".
/*66*/  IF wdetail2.veh_country = "อ่างทอง"     THEN wdetail2.veh_country = "อท".
/*67*/  IF wdetail2.veh_country = "อำนาจเจริญ"  THEN wdetail2.veh_country = "อจ".
/*68*/  IF wdetail2.veh_country = "อุดรธานี"    THEN wdetail2.veh_country = "อด".
/*69*/  IF wdetail2.veh_country = "อุตรดิตถ์"   THEN wdetail2.veh_country = "อต".
/*70*/  IF wdetail2.veh_country = "อุทัยธานี"   THEN wdetail2.veh_country = "อน".
/*71*/  IF wdetail2.veh_country = "อุบลราชธานี" THEN wdetail2.veh_country = "อบ".
/*72*/  IF wdetail2.veh_country = "ยโสธร"       THEN wdetail2.veh_country = "ยส".
/*73*/  IF wdetail2.veh_country = "สตูล"        THEN wdetail2.veh_country = "สต".
/*74*/  IF wdetail2.veh_country = "สุมทรปราการ" THEN wdetail2.veh_country = "สป".
/*75*/  IF wdetail2.veh_country = "สุมทรสงคราม" THEN wdetail2.veh_country = "สส".
/*76*/  IF wdetail2.veh_country = "สุมทรสาคร"   THEN wdetail2.veh_country = "สค".
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign3 C-Win 
PROCEDURE proc_assign3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_length AS INT.
FOR EACH wdetail2 .
    IF wdetail2.polstk NE "" THEN DO:
        FIND FIRST wdetail WHERE wdetail.policy =  TRIM(wdetail2.polstk)  NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN 
                wdetail.brand       = TRIM(wdetail2.brand)
                /*wdetail.caryear     = wdetail2.caryear*/ 
                wdetail.poltyp      = "72" 
                /*wdetail.policy      = "kk" + wdetail2.polstk*//*kridtiya i. A54-0049*/
                wdetail.policy      = caps(TRIM(wdetail2.polstk)) 
                /*wdetail.comdat      = IF (deci(substr(wdetail2.comdat,1,1)) GE 0) AND (deci(substr(wdetail2.comdat,1,1)) LE 9) THEN wdetail2.comdat ELSE ""  
                wdetail.expdat      = IF (deci(substr(wdetail2.expdat,1,1)) GE 0) AND (deci(substr(wdetail2.expdat,1,1)) LE 9) THEN wdetail2.expdat ELSE ""  */
                wdetail.comdat      = (wdetail2.comdat)
                wdetail.expdat      = (wdetail2.expdat) 
                wdetail.tiname      = IF wdetail2.namTITLE = "" THEN "คุณ" ELSE wdetail2.namTITLE
                wdetail.insnam      = TRIM(wdetail2.insurnam) 
                wdetail.icno        = wdetail2.icno              /* A56-0212 */
                wdetail.iadd1       = IF substr(TRIM(wdetail2.ad11),1,4)  = "บ้าน" THEN                
                                     SUBSTR(TRIM(wdetail2.ad11),5) ELSE  TRIM(wdetail2.ad11)           
                wdetail.iadd2       = TRIM(wdetail2.ad12)                                              
                wdetail.iadd3       = TRIM(wdetail2.ad13)                                              
                wdetail.iadd4       = TRIM(wdetail2.ad14)
                wdetail.subclass    = TRIM(wdetail2.class)
                wdetail.model       = TRIM(wdetail2.model) 
                wdetail.cc          = "0"
                wdetail.vehreg      = TRIM(wdetail2.vehreg)   /*+ " " + wdetail2.veh_country*/
                wdetail.engno       = ""                      /*wdetail2.engno*/
                wdetail.chasno      = TRIM(wdetail2.chassis)
                wdetail.vehuse      = "1"
                wdetail.garage      = ""
                wdetail.stk         = IF wdetail2.number    = "" THEN "" 
                                      ELSE IF SUBSTR(wdetail2.number,1,1) <> "0" THEN "0" + trim(wdetail2.number)
                                      ELSE trim(wdetail2.number)
                wdetail.covcod      = "T"
                wdetail.si          = ""
                wdetail.prempa      = fi_pack
                /*wdetail.branch      = wdetail2.branch *//*kridtiya i. A54-0049*/
                /*wdetail.branch      = caps(wdetail2.branch) */                 /*kridtiya i. A54-0049*/
                wdetail.branch      = caps(trim(wdetail2.branch)) 
                wdetail.benname     = wdetail2.benname  
                wdetail.volprem     = TRIM(wdetail2.comp)
                wdetail.comment     = ""
                wdetail.delerco     = TRIM(wdetail2.vatcode)   /*เก็บค่า vatcode*/
                wdetail.agent       = caps(TRIM(fi_agent))     
                wdetail.producer    = caps(TRIM(fi_producer))  
                wdetail.entdat      = string(TODAY)                /*entry date*/
                wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
                wdetail.trandat     = STRING (TODAY)               /*tran date*/
                wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
                wdetail.n_IMPORT    = "IM"
                wdetail.n_EXPORT    = "" 
                wdetail.cedpol      = TRIM(wdetail2.cedpol)
                wdetail.phone       = Trim(wdetail2.phone)        /*A60-0232*/
                wdetail.tname1      = Trim(wdetail2.tname1)       /*A60-0232*/
                wdetail.cname1      = Trim(wdetail2.cname1)       /*A60-0232*/
                wdetail.lname1      = Trim(wdetail2.lname1)       /*A60-0232*/
                wdetail.icno1       = Trim(wdetail2.icno1)        /*A60-0232*/
                wdetail.tname2      = Trim(wdetail2.tname2)       /*A60-0232*/
                wdetail.cname2      = Trim(wdetail2.cname2)       /*A60-0232*/
                wdetail.lname2      = Trim(wdetail2.lname2)       /*A60-0232*/
                wdetail.icno2       = Trim(wdetail2.icno2)        /*A60-0232*/
                wdetail.tname3      = Trim(wdetail2.tname3)       /*A60-0232*/
                wdetail.cname3      = Trim(wdetail2.cname3)       /*A60-0232*/
                wdetail.lname3      = Trim(wdetail2.lname3)       /*A60-0232*/
                wdetail.icno3       = Trim(wdetail2.icno3)       /*A60-0232*/
                wdetail.namenotify  = TRIM(wdetail2.namnotify)   /*a61-0335*/
                wdetail.nsend       = trim(wdetail2.nsend)        /*a61-0335*/
                wdetail.sendname    = trim(wdetail2.sendname)     /*a61-0335*/
                wdetail.kkapp       = trim(wdetail2.kkapp)        /*a61-0335*/
                wdetail.br_insured  = "00000".                    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 

               /* wdetail.nmember     = IF index(wdetail2.br_nam,"-สาขา") <> 0 THEN "-สาขา" 
                                      ELSE ""*/
                IF rs_load = 1 THEN DO: /* A59-0590 */
                    wdetail.nmember     = (IF index(wdetail2.br_nam,"-สาขา") <> 0 THEN "-สาขา" ELSE "") + 
                                          IF   (TRIM(wdetail2.namTITLE) = "บริษัท")            OR
                                               (TRIM(wdetail2.namTITLE) = "บ.")                OR 
                                               (TRIM(wdetail2.namTITLE) = "บจก.")              OR 
                                               (TRIM(wdetail2.namTITLE) = "หจก.")              OR 
                                               (TRIM(wdetail2.namTITLE) = "หสน.")              OR 
                                               (TRIM(wdetail2.namTITLE) = "บรรษัท")            OR 
                                               (TRIM(wdetail2.namTITLE) = "มูลนิธิ")           OR 
                                               (TRIM(wdetail2.namTITLE) = "ห้าง")              OR 
                                               (TRIM(wdetail2.namTITLE) = "ห้างหุ้นส่วน")      OR 
                                               (TRIM(wdetail2.namTITLE) = "ห้างหุ้นส่วนจำกัด") OR
                                               (TRIM(wdetail2.namTITLE) = "ห้างหุ้นส่วนจำก")   THEN    /*company */
                        " หางพรบ. จัดส่งตามที่อยู่ กรณี นิติบุคคลจัดส่งตามช่องหมายเหตุ: " + wdetail2.memmo      
                        ELSE IF  (TRIM(wdetail2.namTITLE) = "คุณ")   THEN 
                              " หางพรบ. จัดส่งตามที่อยู่ " + wdetail2.br_nam
                        ELSE  " หางพรบ. จัดส่งตามที่อยู่ " + wdetail2.br_nam  + " กรณี นิติบุคคลจัดส่งตามช่องหมายเหตุ: " + wdetail2.memmo .    /*wdetail2.addr72 */ 
                    IF  wdetail2.memmo <> "" THEN
                        ASSIGN wdetail.nmember = " หางพรบ.จัดส่งตามที่อยู่ตามช่องหมายเหตุ: " + wdetail2.memmo.
                END. /* A59-0590 */
                ELSE ASSIGN wdetail.nmember = trim(wdetail2.memmo). /* A59-0590 */
            /*END.*/
        END.  /*if avail*/
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew C-Win 
PROCEDURE proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
FIND LAST sicuw.uwm100  WHERE
                sicuw.uwm100.policy = wdetail.renpol  
    NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sicuw.uwm100 THEN DO:
    FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001     WHERE
    sicuw.uwm120.policy  = sicuw.uwm100.policy  AND
    sicuw.uwm120.rencnt  = sicuw.uwm100.rencnt  AND
    sicuw.uwm120.endcnt  = sicuw.uwm100.endcnt   NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm120 THEN
        ASSIGN 
        wdetail.prempa =  substring(sicuw.uwm120.class,1,1)
        wdetail.subclass = substring(sicuw.uwm120.class,2,3).
    FIND LAST sicuw.uwm301 USE-INDEX uwm30101      WHERE
           sicuw.uwm301.policy = sicuw.uwm100.policy    AND
           sicuw.uwm301.rencnt = sicuw.uwm100.rencnt    AND
           sicuw.uwm301.endcnt = sicuw.uwm100.endcnt    NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm301 THEN
        ASSIGN 
            wdetail.model    = sicuw.uwm301.moddes
            wdetail.redbook  = sicuw.uwm301.modcod              /* redbook  */                                            
            wdetail.cargrp   = sicuw.uwm301.vehgrp              /*กลุ่มรถยนต์*/                                       
            wdetail.chasno   = sicuw.uwm301.cha_no              /*หมายเลขตัวถัง */    
            wdetail.eng      = sicuw.uwm301.eng_no              /*หมายเลขเครื่อง*/                      
            wdetail.vehuse   = sicuw.uwm301.vehuse                                                                           
            wdetail.caryear  = string(sicuw.uwm301.yrmanu )     /*รุ่นปี*/
            wdetail.covcod   = sicuw.uwm301.covcod                                                        
            wdetail.body     = sicuw.uwm301.body                /*แบบตัวถัง*/                                       
            wdetail.seat     = string(sicuw.uwm301.seats )      /*จำนวนที่นั่ง*/                                                                
            wdetail.cc       = string(sicuw.uwm301.engine)      /*ปริมาตรกระบอกสูบ*/                                     
            wdetail.vehreg   = sicuw.uwm301.vehreg   .          /*เลขทะเบียนรถ*/ 
    FOR EACH sicuw.uwd132 USE-INDEX uwd13290  WHERE
                       sicuw.uwd132.policy   = sicuw.uwm301.policy  AND
                       sicuw.uwd132.rencnt   = sicuw.uwm301.rencnt  AND
                       sicuw.uwd132.riskno   = sicuw.uwm301.riskno  AND
                       sicuw.uwd132.itemno   = sicuw.uwm301.itemno  .
        IF sicuw.uwd132.bencod                = "411" THEN
            ASSIGN   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่*/ 
                 n_41   = deci(SUBSTRING(sicuw.uwd132.benvar,31,30)).  
        ELSE IF sicuw.uwd132.bencod           = "42" THEN
            ASSIGN   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง*/   
                n_42   =  deci(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        ELSE IF sicuw.uwd132.bencod                = "43" THEN
            ASSIGN   /*การประกันตัวผู้ขับขี่*/ 
                n_43   =  deci(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        ELSE IF sicuw.uwd132.bencod                = "base" THEN
            ASSIGN   /*การประกันตัวผู้ขับขี่*/ 
                nv_basere = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
    END.
    
END.  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2 C-Win 
PROCEDURE proc_base2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR model   AS CHAR .
DEF VAR aa      AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "v70" THEN DO:
    ASSIGN
        wdetail.drivnam  = "N"     /*ไม่มีผู้ขับขี่*/
        chk = NO
        NO_basemsg = " "
        nv_baseprm = aa
        nv_dss_per = 0 
        nv_drivvar1 = wdetail.drivnam1.
    IF wdetail.drivnam1 <> ""  THEN  nv_drivno = 1.  
    ELSE IF wdetail.drivnam1 = ""  THEN  nv_drivno = 0.   
    If wdetail.drivnam  = "N"  Then 
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
        END.
        RUN proc_usdcod.
        Assign
            nv_drivvar     = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.  /*drivernam...*/
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
    IF wdetail.renpol <> "" THEN  ASSIGN  wdetail.no_41  = STRING(n_41)
                                          wdetail.no_42  = STRING(n_42)
                                          wdetail.no_43  = STRING(n_43).  
    IF wdetail.subclass = "110"  THEN wdetail.seat = "5".
    ELSE IF wdetail.subclass = "210"  THEN wdetail.seat = "12".
    IF wdetail.covcod = "2" THEN
        ASSIGN nv_41 = 50000
        nv_42 = 50000
        nv_43 = 100000
        nv_seat41 =  3    .       /*integer(wdetail.seat)*/ 
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
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
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
     DEF VAR dod0 AS INTEGER.
     DEF VAR dod1 AS INTEGER.
     DEF VAR dod2 AS INTEGER.
     DEF VAR dpd0 AS INTEGER.
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
     nv_flet_per = INTE(wdetail.fleet).
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
     IF wdetail.covcod = "1" THEN WDETAIL.NCB = "0".
     ELSE RUN proc_dsp_ncb.
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

         assign
             nv_dsspcvar   = " ".
         IF  nv_dss_per   = 0  THEN RUN proc_dsp_ncb.  
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
 END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base23 C-Win 
PROCEDURE proc_base23 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
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
    nv_drivvar1 = wdetail.drivnam1.
    IF wdetail.drivnam1 <> ""  THEN  nv_drivno = 1.  
    ELSE IF wdetail.drivnam1 = ""  THEN  nv_drivno = 0.   
    If wdetail.drivnam  = "N"  Then 
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
    IF wdetail.renpol <> "" THEN  ASSIGN  wdetail.no_41  = STRING(n_41)
                                          wdetail.no_42  = STRING(n_42)
                                          wdetail.no_43  = STRING(n_43).  
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
     nv_flet_per = INTE(wdetail.fleet).
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
 END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassic C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 C-Win 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail.vehreg = " " AND wdetail.renpol  = " " THEN DO: 
    ASSIGN
        wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N". 
END.
ELSE DO:
    IF wdetail.renpol = " " THEN DO:     /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
        Def  var  nv_vehreg  as char  init  " ".
        Def  var  s_polno       like sicuw.uwm100.policy   init " ".
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
/*kridtiya i. A53-0018
IF wdetail.drivnam = "y" AND wdetail.drivername1 =  " "   THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
        wdetail.pass    = "N" 
        wdetail.OK_GEN  = "N".*/
IF wdetail.prempa = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
IF wdetail.subclass = " " THEN DO:
    ASSIGN
        wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
END. /*can't block in use*/ 
IF wdetail.brand = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"        
        wdetail.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N".
/*kridtiya i. A53-0018
IF wdetail.cc    = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".*/
IF wdetail.seat  = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
ASSIGN nv_maxsi = 0
    nv_minsi = 0
    nv_si    = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred = NO
    n_model = "". 
IF wdetail.subclass = "110" THEN wdetail.seat = "5".
ELSE IF wdetail.subclass = "210" THEN wdetail.seat = "12".
ELSE IF wdetail.subclass = "320" THEN wdetail.seat = "3".
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE 
        stat.maktab_fil.sclass = wdetail.subclass   AND 
        stat.maktab_fil.modcod = wdetail.redbook    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  nv_modcod    =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            chkred           =  YES                    
            wdetail.brand    =  stat.maktab_fil.makdes
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
            wdetail.cc       =  STRING(stat.maktab_fil.engine)
            wdetail.subclass   =  stat.maktab_fil.sclass   
            /*wdetail.si       =  STRING(stat.maktab_fil.si)*/
            wdetail.redbook =  stat.maktab_fil.modcod                                    
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
            /*IF deci(wdetail.si) > nv_maxSI OR deci(wdetail.si) < nv_minSI THEN DO:
                IF nv_maxSI = nv_minSI THEN DO:
                    IF nv_maxSI = 0 AND nv_minSI = 0 THEN do:
                        /*MESSAGE "Not Found Sum Insure in maktab_fil (Class:"
                            + wdetail.prempa + wdetail.subclass + "   Make/Model:" + wdetail.redbook + " "
                            + wdetail.brand + " " + wdetail.model + "   Year:" + STRING(wdetail.caryear) + ")" .*/
                        ASSIGN
                            wdetail.comment = "Not Found Sum Insure in maktab_fil (Class:"
                            + wdetail.prempa + wdetail.subclass + "   Make/Model:" + wdetail.redbook + " "
                            + wdetail.brand + " " + wdetail.model + "   Year:" + STRING(wdetail.caryear) + ")"
                            wdetail.pass    = "N"    
                            wdetail.OK_GEN  = "N".

                    end.
                    ELSE
                            /*MESSAGE         "Not Found Sum Insured Rates Maintenance in makdes31 (Tariff: X"
                                + "  Class:" + wdetail.prempa + wdetail.subclass  + ")" .*/
                        ASSIGN
                            wdetail.comment = "Not Found Sum Insured Rates Maintenance in makdes31 (Tariff: X"
                            + "  Class:"  + wdetail.prempa + wdetail.subclass + ")"
                            wdetail.pass    = "N"   
                            wdetail.OK_GEN  = "N".
                END.
                ELSE
                    /*MESSAGE  "Sum Insure must " + nv_mindes + " and " + nv_maxdes
                    + " of " + TRIM(STRING(nv_si,">>>,>>>,>>9"))
                    + " (" + TRIM(STRING(nv_minSI,">>>,>>>,>>9"))
                    + " - " + TRIM(STRING(nv_maxSI,">>>,>>>,>>9")) + ")" .*/
                    ASSIGN
                        wdetail.comment = "Sum Insure must " + nv_mindes + " and " + nv_maxdes
                        + " of " + TRIM(STRING(nv_si,">>>,>>>,>>9"))
                        + " (" + TRIM(STRING(nv_minSI,">>>,>>>,>>9"))
                        + " - " + TRIM(STRING(nv_maxSI,">>>,>>>,>>9")) + ")"wdetail.pass    = "N"   
                        wdetail.OK_GEN  = "N".
            END. */
        END.  /***--- End Check Rate SI ---***/
    END.
    ELSE nv_modcod = " ".
END.    /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    ASSIGN
        nv_simat  = (DECI(wdetail.si) * 50 / 100 )
        nv_simat1 = DECI(wdetail.si) + nv_simat .
    Find FIRST stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =     wdetail.brand             And                  
        INDEX(stat.maktab_fil.moddes,wdetail.model) <>  0        AND
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear)  AND
        /*stat.maktab_fil.engine =     Integer(wdetail.cc)      AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass          AND 
        (stat.maktab_fil.si      GE     nv_simat                 OR
         stat.maktab_fil.si      LE     nv_simat1 )   /*AND  
         stat.maktab_fil.seats    >=     inte(wdetail.seat) */         
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN nv_modcod  =  stat.maktab_fil.modcod                                    
        nv_moddes         =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp    =  stat.maktab_fil.prmpac
        wdetail.redbook   =  stat.maktab_fil.modcod 
         
        
        
        .
        /*sic_bran.uwm301.seats   = stat.maktab_fil.seats.*/
    IF nv_modcod = ""  THEN 
        RUN proc_maktab.
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
                wdetail.tariff =   sicsyac.xmm016.tardef
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
     IF inte(wdetail.fleet) <> 0 AND INTE(wdetail.fleet) <> 10 Then 
         ASSIGN
             wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. "
             wdetail.pass    = "N"    
             wdetail.OK_GEN  = "N".
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
     RUN proc_dsp_ncb.
     IF (DECI(wdetail.ncb) = 0 )  OR (DECI(wdetail.ncb) = 20 ) OR
        (DECI(wdetail.ncb) = 30 ) OR (DECI(wdetail.ncb) = 40 ) OR
        (DECI(wdetail.ncb) = 50 )    THEN DO:
     END.
     ELSE 
         ASSIGN
             wdetail.comment = wdetail.comment + "| not on NCB Rates file xmm104."
             wdetail.pass    = "N"   
             wdetail.OK_GEN  = "N".
     
     NV_NCBPER = INTE(WDETAIL.NCB).
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401 Where
             sicsyac.xmm104.tariff = wdetail.tariff                      AND
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1 C-Win 
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
    /*RUN proc_cr_2.*/
    ASSIGN 
        n_rencnt = 0
        n_endcnt = 0.
    /*IF wdetail.renpol <> " " THEN RUN proc_renew.*/
    IF wdetail.poltyp = "v72"  THEN DO:
        /*Add by Kridtiya i. A63-0472*/ 
        RUN proc_assign2addr (INPUT  wdetail.iadd1
                             ,INPUT  wdetail.iadd2
                             ,INPUT  wdetail.iadd3 + " " + wdetail.iadd4
                             ,INPUT  ""              /* wdetail.occup  */ 
                             ,OUTPUT wdetail.codeocc  
                             ,OUTPUT wdetail.codeaddr1
                             ,OUTPUT wdetail.codeaddr2
                             ,OUTPUT wdetail.codeaddr3).
        IF nv_postcd <> ""  THEN DO: 
            wdetail.postcd  = nv_postcd.
            IF      INDEX(wdetail.iadd4,nv_postcd) <> 0 THEN wdetail.iadd4 = trim(REPLACE(wdetail.iadd4,nv_postcd,"")). 
            ELSE IF INDEX(wdetail.iadd3,nv_postcd) <> 0 THEN wdetail.iadd3 = trim(REPLACE(wdetail.iadd3,nv_postcd,"")). 
            ELSE IF INDEX(wdetail.iadd2,nv_postcd) <> 0 THEN wdetail.iadd2 = trim(REPLACE(wdetail.iadd2,nv_postcd,"")). 
            ELSE IF INDEX(wdetail.iadd1,nv_postcd) <> 0 THEN wdetail.iadd1 = trim(REPLACE(wdetail.iadd1,nv_postcd,"")). 
        END.
        RUN proc_matchtypins (INPUT  wdetail.tiname 
                             ,INPUT  wdetail.insnam 
                             ,OUTPUT wdetail.insnamtyp
                             ,OUTPUT wdetail.firstName
                             ,OUTPUT wdetail.lastName).
        IF      fi_producer =  "A0M1005"    AND wdetail.renpol <> "" THEN ASSIGN fi_producer =  "B3MLKK0101"    wdetail.financecd = "FKK" wdetail.campaign_ov = "RENEW".
        ELSE IF fi_producer =  "A0M1005"    THEN ASSIGN  fi_producer =  "B3MLKK0101"    wdetail.financecd = "FKK" wdetail.campaign_ov = "TRANSF".
        ELSE IF fi_producer =  "A0M1050"    THEN ASSIGN  fi_producer =  "B3MLKK0102"    wdetail.financecd = "FKK" wdetail.campaign_ov = "REDPLATE".             
        ELSE IF fi_producer =  "A0M1054"    THEN ASSIGN  fi_producer =  "B3MLKK0103"    wdetail.financecd = "FKK" wdetail.campaign_ov = "VREDPLATE".            
        ELSE IF fi_producer =  "A000190"    THEN ASSIGN  fi_producer =  "B3MLKK0104"    wdetail.financecd = "FKK" wdetail.campaign_ov = "BBREDPLATE".  
        ELSE IF fi_producer =  "B3MLKK0101" AND wdetail.renpol <> "" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "RENEW".
        ELSE IF fi_producer =  "B3MLKK0101" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "TRANSF".
        ELSE IF fi_producer =  "B3MLKK0102" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "REDPLATE".           
        ELSE IF fi_producer =  "B3MLKK0103" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "VREDPLATE".          
        ELSE IF fi_producer =  "B3MLKK0104" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "BBREDPLATE".
        RUN proc_susspect.
        /*Add by Kridtiya i. A63-0472*/ 
        RUN proc_72.
        RUN proc_policy. 
        RUN proc_722.
        RUN proc_723 (INPUT  s_recid1,       
                      INPUT  s_recid2,
                      INPUT  s_recid3,
                      INPUT  s_recid4,
                      INPUT-OUTPUT nv_message).
        /*RUN proc_chktest2.      
        RUN proc_chktest3.      
        RUN proc_chktest4.*/
        NEXT.
    END.
    /*ELSE DO:
        RUN proc_chktest0.
    END.
    RUN proc_policy.    /*ใช้ร่วมกัน 70/72*/
    RUN proc_chktest2.      
    RUN proc_chktest3.      
    RUN proc_chktest4.   */
        
END.     /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2 C-Win 
PROCEDURE proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND            /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND            /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND            /*1*/
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
        sic_bran.uwm130.bchyr = nv_batchyr          /* batch Year */
        sic_bran.uwm130.bchno = nv_batchno          /* bchno      */
        sic_bran.uwm130.bchcnt  = nv_batcnt        /* bchcnt     */
        nv_sclass = wdetail.subclass
        nv_uom6_u  =  "A" .  
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN 
        ASSIGN
        sic_bran.uwm130.uom6_v   = inte(wdetail.si)
        sic_bran.uwm130.uom7_v   = inte(wdetail.si)
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
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    
   
    n_sclass72 = wdetail.subclass .
    
    /*n_sclass72 = wdetail.subclass .*/
    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = wdetail.covcod No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do:                            
        Assign 
            sic_bran.uwm130.uom1_v     = deci(wdetail.deductpp)      /*stat.clastab_fil.uom1_si*/
            sic_bran.uwm130.uom2_v     = deci(wdetail.deductba)      /*stat.clastab_fil.uom2_si*/
            sic_bran.uwm130.uom5_v     = deci(wdetail.deductpa)      /*stat.clastab_fil.uom5_si*/
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
        If  wdetail.garage  =  ""  Then
            Assign 
            wdetail.no_41   =  string(stat.clastab_fil.si_41unp)
            wdetail.no_42   =  string(stat.clastab_fil.si_42)
            wdetail.no_43   =  string(stat.clastab_fil.si_43)
            wdetail.seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
        Else If  wdetail.garage  =  "G"  Then
            Assign wdetail.no_41    = string(stat.clastab_fil.si_41pai)
            wdetail.no_42    =   string(stat.clastab_fil.si_42)    
            wdetail.no_43    =   string(stat.clastab_fil.impsi_43)  
            wdetail.seat41   =   stat.clastab_fil.dri_41 + clastab_fil.pass_41.            
    END.           
    ASSIGN
        nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                         nv_riskno,
                         nv_itemno).
    END.  /* end Do transaction*/
    s_recid3  = RECID(sic_bran.uwm130).
    nv_covcod =   wdetail.covcod.
    nv_makdes  =  wdetail.brand.
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
             sic_bran.uwm301.tariff    = wdetail.tariff    
             sic_bran.uwm301.covcod    = nv_covcod
             sic_bran.uwm301.cha_no    = wdetail.chasno
             sic_bran.uwm301.trareg    = nv_uwm301trareg
             sic_bran.uwm301.eng_no    = wdetail.eng
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
             sic_bran.uwm301.itmdel    = NO
             sic_bran.uwm301.prmtxt    = "".  /*IF wdetail.poltyp = "v70" THEN "คุ้มครองอุปกรณ์ตกแต่งราคาไม่เกิน 20,000 บาท" ELSE "" .*/
             wdetail.tariff            = sic_bran.uwm301.tariff.
         /*IF  wdetail2.drivnam = "Y" THEN DO :         
             DEF VAR no_policy AS CHAR FORMAT "x(20)" .
             DEF VAR no_rencnt AS CHAR FORMAT "99".
             DEF VAR no_endcnt AS CHAR FORMAT "999".
             DEF VAR no_riskno AS CHAR FORMAT "999".
             DEF VAR no_itemno AS CHAR FORMAT "999".
             no_policy = uwm301.policy .
             no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") .
             no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") .
             no_riskno = "001".
             no_itemno = "001".
             nv_drivage1 =  YEAR(TODAY) - INT(SUBSTR(wdetail.dbirth,7,4))  .
             nv_drivage2 =  YEAR(TODAY) - INT(SUBSTR(wdetail.ddbirth,7,4))  .
             IF wdetail.dbirth <> " "  AND wdetail.drivername1 <> " " THEN DO: /*note add & modified*/
                 nv_drivbir1      = STRING(INT(SUBSTR(wdetail.dbirth,7,4)) + 543).
                 wdetail.dbirth = SUBSTR(wdetail.dbirth,1,6) + nv_drivbir1.
             END.
             IF wdetail.ddbirth <>  " " AND wdetail.drivername2 <> " " THEN DO: /*note add & modified */
                 nv_drivbir2      = STRING(INT(SUBSTR(wdetail.ddbirth,7,4)) + 543).
                 wdetail.ddbirth = SUBSTR(wdetail.ddbirth,1,6) + nv_drivbir2.
             END.
             FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                 brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
                 brstat.mailtxt_fil.bchyr = nv_batchyr   AND                                               
                 brstat.mailtxt_fil.bchno = nv_batchno   AND
                 brstat.mailtxt_fil.bchcnt  = nv_batcnt    NO-LOCK  NO-ERROR  NO-WAIT.
             IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.                                                      
             FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                 brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno     AND
                 brstat.mailtxt_fil.lnumber = nv_lnumber    AND
                 brstat.mailtxt_fil.bchyr = nv_batchyr    AND                                               
                 brstat.mailtxt_fil.bchno = nv_batchno    AND
                 brstat.mailtxt_fil.bchcnt  = nv_batcnt     NO-LOCK  NO-ERROR  NO-WAIT.
             IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
                 CREATE brstat.mailtxt_fil.
                 ASSIGN                                           
                     brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                     brstat.mailtxt_fil.lnumber   = nv_lnumber.
                     brstat.mailtxt_fil.ltext     = wdetail.drivername1 + FILL(" ",30 - LENGTH(wdetail.drivername1)). 
                     brstat.mailtxt_fil.ltext2    = wdetail.dbirth + "  " + string(nv_drivage1).
                     nv_drivno                    = 1.
                     ASSIGN 
                     brstat.mailtxt_fil.bchyr = nv_batchyr 
                     brstat.mailtxt_fil.bchno = nv_batchno 
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                     SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
                     SUBSTRING(brstat.mailtxt_fil.ltext,31,6) = "MALE". 
                     IF wdetail.drivername2 <> "" THEN DO:
                         CREATE brstat.mailtxt_fil. 
                         ASSIGN
                             brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                             brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                             brstat.mailtxt_fil.ltext    = wdetail.drivername2 + FILL(" ",30 - LENGTH(wdetail.drivername2)). 
                         brstat.mailtxt_fil.ltext2   = wdetail.ddbirth + "  " + string(nv_drivage2). 
                         nv_drivno                   = 2.
                         ASSIGN 
                             brstat.mailtxt_fil.bchyr = nv_batchyr 
                             brstat.mailtxt_fil.bchno = nv_batchno 
                             brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                             SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
                             SUBSTRING(brstat.mailtxt_fil.ltext,31,6) = "MALE". 
                     END.  /*drivnam2 <> " " */
             END. /*End Avail Brstat*/
             ELSE  DO:
                 CREATE  brstat.mailtxt_fil.
                 ASSIGN  brstat.mailtxt_fil.policy     = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
                     brstat.mailtxt_fil.lnumber    = nv_lnumber.
                 brstat.mailtxt_fil.ltext      = wdetail.drivername1 + FILL(" ",30 - LENGTH(wdetail.drivername1)). 
                 brstat.mailtxt_fil.ltext2     = wdetail.dbirth + "  " +  TRIM(string(nv_drivage1)).
                 IF wdetail.drivername2 <> "" THEN DO:
                     CREATE  brstat.mailtxt_fil.
                     ASSIGN
                         brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                         brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                         brstat.mailtxt_fil.ltext    = wdetail.drivername2 + FILL(" ",30 - LENGTH(wdetail.drivername2)). 
                     brstat.mailtxt_fil.ltext2   = wdetail.ddbirth + "  " + TRIM(string(nv_drivage2)).
                     ASSIGN /*a490166*/
                         brstat.mailtxt_fil.bchyr = nv_batchyr 
                         brstat.mailtxt_fil.bchno = nv_batchno 
                         brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                         SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . 
                 END. /*drivnam2 <> " " */
             END. /*Else DO*/
         END. 
         ***********  end mailtxt   ************************/
         s_recid4         = RECID(sic_bran.uwm301).
         /*-- maktab_fil --*/
         IF wdetail.redbook <> "" AND chkred = YES THEN DO:
             FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass      AND
                 stat.maktab_fil.modcod = wdetail.redbook
                 No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN
                     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                     wdetail.cargrp =  maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.seats   =  stat.maktab_fil.seats. /*A54-0126*/
         END.
         ELSE DO:
             ASSIGN  nv_simat  = 0
                 nv_simat1 = 0
                 nv_simat  = DECI(wdetail.si) * 50 / 100 
                 nv_simat1 = DECI(wdetail.si) + nv_simat .
             Find First stat.maktab_fil Use-index      maktab04          Where
                 stat.maktab_fil.makdes   =     wdetail.brand               And                  
                 index(stat.maktab_fil.moddes,wdetail.model) <> 0             And
                 stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
                 /*stat.maktab_fil.engine   =     Integer(wdetail.cc)   AND*/
                 stat.maktab_fil.sclass   =     wdetail.subclass        AND
                 (stat.maktab_fil.si      GE    nv_simat      OR
                 stat.maktab_fil.si       LE     nv_simat1 )   /*AND  
                 stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)  */        
                 No-lock no-error no-wait.
             If  avail stat.maktab_fil  Then 
                 ASSIGN sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                 sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                 wdetail.cargrp          =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.body    =  stat.maktab_fil.body
                 sic_bran.uwm301.seats   =  stat.maktab_fil.seats.  /*A54-0126*/
                 
         END.
         IF sic_bran.uwm301.modcod = ""  THEN RUN proc_maktab.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest3 C-Win 
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
    nv_pdacod   = "" 
    nv_ncbyrs  =   0    
    nv_ncbper  =   0    
    nv_ncb     =   0
    nv_totsi   =  0 . 
IF wdetail.compul = "y" THEN DO:
    ASSIGN
        nv_class      = wdetail.subclass  
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
            ASSIGN nv_vehuse = "0".     /*A52-0172 ให้ค่า0 เนื่องจากต้องการส่งค่าให้ key.b = 0 */
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
RUN proc_base2.
/*****A52-0172
If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0.
/*-----nv_drivcod---------------------*/
nv_drivvar1 = wdetail.drivername1.
nv_drivvar2 = wdetail.drivername2.
IF wdetail.drivername1 <> ""   THEN DO:  
    ASSIGN nv_drivno = 1
    wdetail.drivnam  = "y".
END.
ELSE wdetail.drivnam  = "N".
IF wdetail.drivername2 <> ""   THEN  nv_drivno = 2.  /*A52-0172*/
ELSE IF wdetail.drivername1 = "" AND wdetail.drivername2 = "" THEN  nv_drivno = 0.   /*A52-0172*/
If wdetail.drivnam  = "N"  Then do:
    Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
END.
ELSE DO:
IF  nv_drivno  > 2  Then do:
           Message " Driver'S NO. must not over 2. "  View-as alert-box.
           ASSIGN
           wdetail.pass    = "N"
           wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".
           End.
  Assign
          nv_drivvar     = " "
          nv_drivvar1    = "     Driver name person = "
          nv_drivvar2    = String(nv_drivno)
          Substr(nv_drivvar,1,30)  = nv_drivvar1
          Substr(nv_drivvar,31,30) = nv_drivvar2.
  RUN proc_usdcod.  
END.  /*-------nv_baseprm----------*/
RUN wgs\wgsfbas.  /*25/09/2006 add condition base in range*/
IF NO_basemsg <> " " THEN 
    wdetail.WARNING = no_basemsg.
IF nv_baseprm = 0  Then do:
      Message  " Base Premium is Mandatory field. "  View-as alert-box.
      ASSIGN
      wdetail.pass    = "N"
      wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".
End.
Assign
     nv_prem1   = nv_baseprm
     nv_basecod = "BASE"
     nv_basevar1 = "     Base Premium = "
     nv_basevar2 = STRING(nv_baseprm)
     SUBSTRING(nv_basevar,1,30)   = nv_basevar1
     SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
/*-------nv_add perils----------*/
 ASSIGN
   nv_41 =  deci(wdetail.no_41)  
   nv_42 =  deci(wdetail.no_42)  
   nv_43 =  deci(wdetail.no_43) 
   nv_seat41 = integer(wdetail.seat41).
  RUN WGS\WGSOPER(INPUT nv_tariff, 
                                nv_class,
                                nv_key_b,
                                nv_comdat).  
  Assign                                                     /*---------fi_41---------*/
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
 nv_42var    = " ".                                     /* -------fi_42---------*/
        Assign
            nv_42cod   = "42".
            nv_42var1  = "     Medical Expense = ".
            nv_42var2  = STRING(nv_42).
            SUBSTRING(nv_42var,1,30)   = nv_42var1.
            SUBSTRING(nv_42var,31,30)  = nv_42var2.
   nv_43var    = " ".                                   /*---------fi_43--------------*/
   Assign
               nv_43prm = nv_43
               nv_43cod   = "43"
               nv_43var1  = "     Airfrieght = "
               nv_43var2  =  STRING(nv_43)
               SUBSTRING(nv_43var,1,30)   = nv_43var1
               SUBSTRING(nv_43var,31,30)  = nv_43var2.
   RUN WGS\WGSOPER(INPUT nv_tariff, /*pass*/ /*a490166 note modi*/
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
RUN wgs\wgsoeng.  /*a490166 note modi*/
/*-----nv_yrcod----------------------------*/  
Assign
   nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
   nv_yrvar1  = "     Vehicle Year = "
   nv_yrvar2  =  String(wdetail.caryear)
   nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr)
                         Else "YR99"
   Substr(nv_yrvar,1,30)    = nv_yrvar1
   Substr(nv_yrvar,31,30)   = nv_yrvar2.
 /*-----nv_sicod----------------------------*/ 
      Assign            
            nv_sicod     = "SI"
            nv_sivar1    = "     Own Damage = "
            nv_sivar2    =  STRING(wdetail.si)
            SUBSTRING(nv_sivar,1,30)  = nv_sivar1
            SUBSTRING(nv_sivar,31,30) = nv_sivar2
            nv_totsi     =  inte(wdetail.si).
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
 Assign
       nv_pdacod      = "PD"
       nv_pdavar1     = "     PD per Accident = "
       nv_pdavar2     = STRING(uwm130.uom5_v)
       SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
       SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
 /*--------------- deduct ----------------*/
  DEF VAR dod0 AS INTEGER.
  DEF VAR dod1 AS INTEGER.
  DEF VAR dod2 AS INTEGER.
  DEF VAR dpd0 AS INTEGER.
  dod0 = inte(wdetail.deductda).
  IF dod0 > 3000 THEN DO:
      dod1 = 3000.
      dod2 = dod0 - dod1.
  END.
      ASSIGN
         nv_odcod    = "DC01"
         nv_prem     =   dod1. 
 RUN Wgs\Wgsmx024( nv_tariff,/*a490166 note modi*/
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
  Assign  
      nv_dedod2var   = " "
               nv_cons  = "AD"
               nv_ded   = dod2.
  Run  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */
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
          dpd0     = inte(wdetail.deductpd) 
          nv_cons  = "PD"
          nv_ded   = dpd0.
    Run  Wgs\Wgsmx025(INPUT  nv_ded, /*a490166 note modi*/
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
  /*---------- fleet -------------------*//*A52-0172
 nv_flet_per = INTE(wdetail.fleet).
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
           nv_fletvar  = " ".         --------------- A52-0172*/
/*---------------- NCB -------------------*/
DEF VAR nv_ncbyrs AS INTE.
NV_NCBPER = INTE(WDETAIL.NCB).
nv_ncbvar = " ".
If nv_ncbper  <> 0 Then do:
    Find first sicsyac.xmm104 Use-index xmm10401 Where
        sicsyac.xmm104.tariff = nv_tariff      AND
        sicsyac.xmm104.class  = nv_class       AND
        sicsyac.xmm104.covcod = nv_covcod      AND
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
/*-------------- load claim ---------------------*//***A52-0172
        nv_cl_per  = deci(wdetail.loadclm).
        nv_clmvar  = " ".
        IF nv_cl_per  <> 0  THEN
           Assign 
                  nv_clmvar1   = " Load Claim % = "
                  nv_clmvar2   =  STRING(nv_cl_per)
                  SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
                  SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
         RUN WGS\WGSORPRM.P (INPUT  nv_tariff, 
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
                  SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.  ***A52-0172*/
    /*------------------ dsspc ---------------*/
nv_dsspcvar   = " ".
IF  nv_dss_per   <> 0  THEN
    Assign
    nv_dsspcvar1   = "     Discount Special % = "
    nv_dsspcvar2   =  STRING(nv_dss_per)
    SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
    SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.    --A52-0172*/
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
        sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs
        sic_bran.uwm301.mv41seat = inte(wdetail.seat).
  
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4 C-Win 
PROCEDURE proc_chktest4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Def  var   n_sigr_r     like sic_bran.uwm130.uom6_v.
Def  var   n_gap_r      Like sic_bran.uwd132.gap_c . 
Def  var   n_prem_r     Like sic_bran.uwd132.prem_c.
Def  var   nt_compprm   like sic_bran.uwd132.prem_c.  
Def  var   n_gap_t      Like sic_bran.uwm100.gap_p.
Def  var   n_prem_t     Like sic_bran.uwm100.prem_t.
Def   var  n_sigr_t     Like sic_bran.uwm100.sigr_p.

def  var   nv_policy    like sic_bran.uwm100.policy.
def  var   nv_rencnt    like sic_bran.uwm100.rencnt.
def  var   nv_endcnt    like sic_bran.uwm100.endcnt.

def  var   nv_com1_per  like sicsyac.xmm031.comm1.
def  var   nv_stamp_per like sicsyac.xmm020.rvstam.

/*-------  note add ------*/
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

/*------------------------*/
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1
  no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      Message "not found (uwm100./wuwrep02.p)" View-as alert-box.
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
                     /*a490166*/                                             
                     sic_bran.uwm120.bchyr = nv_batchyr               AND 
                     sic_bran.uwm120.bchno = nv_batchno               AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt                     .

                     FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                              sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                              sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                              sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                              sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                              /*a490166*/                                             
                              sic_bran.uwm130.bchyr = nv_batchyr              AND 
                              sic_bran.uwm130.bchno = nv_batchno              AND 
                              sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                          

                              n_sigr_r                = n_sigr_r + uwm130.uom6_v.
                              FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE /*a490166 แก้ Index จาก 09 เป็น 01*/
                                       sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                                       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                                       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                                       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                                       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                                       /*a490166*/                                             
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
  Find LAST  sic_bran.uwm120  Use-index uwm12001  WHERE          /***--- a490166 change first to last ---***/
             sic_bran.uwm120.policy  = sic_bran.uwm100.policy   And
             sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt   And
             sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt   AND 
             /*a490166*/                                             
             sic_bran.uwm120.bchyr = nv_batchyr               AND 
             sic_bran.uwm120.bchno = nv_batchno               AND 
             sic_bran.uwm120.bchcnt  = nv_batcnt                No-error.

  /***--- A50-0097 Shukiat T. 26/04/2007 ---***/
  /***--- เปลี่ยนรูปแบบการค้น Commission Rate ใหม่ ---***/
  /***--- A49-0206 Shukiat T. 15/01/2006 ---***/
  /***--- Commmission Rate Line 70 ---***/
  /***--- A50-0144 Shukiat T. 05/06/2007 ---***/
  /***--- เปลี่ยนเงื่อนไขการ Find เงื่อนไขใน Table Xmm018 ---***/
  FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
             substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
             SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
             sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
  IF AVAIL   sicsyac.xmm018 THEN DO:
            Assign     nv_com1p = sicsyac.xmm018.commsp  
                       nv_com2p = 0.
  END. /* Avail Xmm018 */
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
                     /*nv_com2p = sicsyac.xmm031.comm2.*//*A490206*/
  END. /* Not Avail Xmm018 */
  
  /***--- Commmission Rate Line 72 ---***/
  IF wdetail.compul = "y" THEN DO:
      FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
                 sicsyac.xmm018.agent              = sic_bran.uwm100.acno1  AND               /*แยกงานตาม Code Producer*/   
                 substr(sicsyac.xmm018.poltyp,1,5) = "CRV72"                AND               /*Shukiat T. modi on 25/04/2007*/
                 SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
                 sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
      IF AVAIL   sicsyac.xmm018 THEN DO:
                 nv_com2p = sicsyac.xmm018.commsp.
      END.
      ELSE DO:
           Find  sicsyac.xmm031  Use-index xmm03101  Where  
                 sicsyac.xmm031.poltyp    = "v72"
           No-lock no-error no-wait.
                 /*nv_com2p = sicsyac.xmm018.commsp.*//***--- Shukiat T. 26/01/2007 ---***/
                   nv_com2p = sicsyac.xmm031.comm1.   /***--- Shukiat T. 26/01/2007 ---***/
      END.
  END. /* Wdetail.Compul = "Y"*/
  /***--- End a490206 15/01/2007 ---***/


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
                     (IF  Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,2)   -
                     Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) > 0
                     Then 1 Else 0).
  End.
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else  do:
           /*nv_fi_stmpae    = NO. /*a / e*/*/
  End.
  ---***//***---End Note Block ---***/  
  
  sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
     
  IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
      nv_fi_rtax_t  = (sic_bran.uwm100.prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
       /* fi_taxae       = Yes.*/
  End.
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else do:
        /*fi_taxae     = no.*/
  end.
  ---***//***---End Note Block ---***/  
    
  sic_bran.uwm100.rtax_t = nv_fi_rtax_t.

  /*-a490206-*/
  sic_bran.uwm120.com1ae = YES.
  sic_bran.uwm120.com2ae = YES.
  
  /*--------- motor commission -----------------*/
  IF sic_bran.uwm120.com1ae   = Yes  Then do:                   /* MOTOR COMMISION */
     If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
         /*nv_fi_com1_t   =  - TRUNCATE ((sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100,0).*/ /*A490166 Shukiat T. Block on 24/10/2006*/
           nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.             /*A490166 Shukiat T. Modi on 24/10/2006*/
         /*fi_com1ae        =  YES.*/
  End.
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else do:
         /*fi_com1ae     = NO.*/
  End.
  ---***//***---End Note Block ---***/  

  /*----------- comp comission ------------*/
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then nv_com2p  = sic_bran.uwm120.com2p.
         /*nv_fi_com2_t   =  - TRUNCATE ( nt_compprm  *  nv_com2p / 100,0).*/   /*A490166 Shukiat T. Block on 24/10/2006*/
           nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.              /*A490166 Shukiat T. Modi on 24/10/2006*/
         /*nv_fi_com2ae        =  YES.*/
  End.
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else do:
       /*  fi_com2ae     = NO.*/
  End.
  ---***//***---End Note Block ---***/  

  IF sic_bran.uwm100.pstp <> 0 Then do:
     IF sic_bran.uwm100.no_sch  = 1 Then NV_fi_dup_trip = "D".
     Else If sic_bran.uwm100.no_sch  = 2 Then  NV_fi_dup_trip = "T".
  End.
  Else  NV_fi_dup_trip  =  "".

  nv_fi_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t
               + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.

  /*---------------------------*/
  
  Find     sic_bran.uwm100 Where  Recid(sic_bran.uwm100)  =  s_recid1.
  If avail sic_bran.uwm100 Then do:
      Assign 
           sic_bran.uwm100.gap_p   = n_gap_t
           sic_bran.uwm100.prem_t  = n_prem_t
           sic_bran.uwm100.sigr_p  = n_sigr_t
           sic_bran.uwm100.instot  = uwm100.instot
           sic_bran.uwm100.com1_t  =  nv_fi_com1_t
           sic_bran.uwm100.com2_t  =  nv_fi_com2_t
         /*sic_bran.uwm100.pstp    =  nv_fi_stamp_per /*note Block on 25/10/2006*/*/
           sic_bran.uwm100.pstp    =  0               /*note modified on 25/10/2006*/
           sic_bran.uwm100.rstp_t  =  nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  =  nv_fi_rtax_t
           sic_bran.uwm100.gstrat  =  nv_fi_tax_per.
  End.
  IF wdetail.poltyp = "v72" THEN DO:
            ASSIGN  
           sic_bran.uwm100.com2_t  = 0 
           sic_bran.uwm100.com1_t  = nv_fi_com2_t.
  END.

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
       
        IF wdetail.poltyp = "v72" THEN DO:
           ASSIGN  
           sic_bran.uwm120.com2_r    = 0 
           sic_bran.uwm120.com1_r    = nv_fi_com2_t
           /*-a490206-*/
           sic_bran.uwm120.com1p     = nv_com2p
           sic_bran.uwm120.com2p     = 0.
        END.
  End.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest41 C-Win 
PROCEDURE proc_chktest41 :
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
                              FOR EACH sicuw.uwd132  /*USE-INDEX uwd13201*/ WHERE 
                                       sicuw.uwd132.policy  = sic_bran.uwm130.policy  AND
                                       sicuw.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                                       sicuw.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                                       sicuw.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                                       sicuw.uwd132.itemno  = sic_bran.uwm130.itemno  /*AND
                                       sicuw.uwd132.bchyr = nv_batchyr              AND 
                                       sicuw.uwd132.bchno = nv_batchno              AND 
                                       sicuw.uwd132.bchcnt  = nv_batcnt  */             NO-LOCK.
                                        IF  sicuw.uwd132.bencod  = "COMP"   THEN
                                             nt_compprm     = nt_compprm + sicuw.uwd132.prem_c.
                                         n_gap_r  = sicuw.uwd132.gap_c  + n_gap_r.
                                         n_prem_r = sicuw.uwd132.prem_c + n_prem_r.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create100 C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cr_2 C-Win 
PROCEDURE proc_cr_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR len AS INTE.
DEF BUFFER buwm100 FOR wdetail.
    ASSIGN
    len = LENGTH(wdetail.policy)
    len = len - 1    .
    FOR EACH buwm100 WHERE 
        substr(buwm100.policy,2,len) = SUBSTR(wdetail.policy,2,len) AND
                buwm100.policy    <> wdetail.policy  NO-LOCK.
        ASSIGN 
            n_cr2 = buwm100.policy.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchar C-Win 
PROCEDURE proc_cutchar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
nv_c = wdetail.renpol.
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
    wdetail.renpol = nv_c .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutcharpol C-Win 
PROCEDURE proc_cutcharpol :
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
    nv_c = trim(wdetail2.number) 
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
    wdetail2.number = nv_c .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutnamtitle C-Win 
PROCEDURE proc_cutnamtitle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/ 
DEF VAR nv_i AS CHAR.
DEF VAR nv_c AS CHAR FORMAT "x(50)".
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
ASSIGN nv_c = trim(wdetail2.insurnam)
    nv_i = ""
    nv_l = LENGTH(nv_c)
    ind = 0.
IF INDEX(nv_c,"คุณ") NE  0 THEN 
    ASSIGN  ind = 4 
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"นาย") NE  0 THEN 
    ASSIGN  ind = 4 
    nv_i = "นาย"
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"น.ส.") NE  0 THEN 
    ASSIGN  ind = 5 
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"นางสาว ") NE 0  THEN 
    ASSIGN  ind = 7
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"นาง") NE 0  THEN 
    ASSIGN  ind = 4
    wdetail2.insurnam = TRIM(SUBSTR(nv_c,ind,nv_l)).      
nv_c = "". 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dsp_ncb C-Win 
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
    IF wdetail.si = "100,000.00"    THEN ASSIGN nv_dss_per = 50.12.  
    IF wdetail.si = "110,000.00"    THEN ASSIGN nv_dss_per = 50.55.  
    IF wdetail.si = "120,000.00"    THEN ASSIGN nv_dss_per = 50.90.  
    IF wdetail.si = "130,000.00"    THEN ASSIGN nv_dss_per = 51.30.  
    IF wdetail.si = "140,000.00"    THEN ASSIGN nv_dss_per = 51.67.  
    IF wdetail.si = "150,000.00"    THEN ASSIGN nv_dss_per = 52.02.  
    IF wdetail.si = "160,000.00"    THEN ASSIGN nv_dss_per = 52.00.  
    IF wdetail.si = "170,000.00"    THEN ASSIGN nv_dss_per = 51.99.  
    IF wdetail.si = "180,000.00"    THEN ASSIGN nv_dss_per = 51.95.  
    IF wdetail.si = "190,000.00"    THEN ASSIGN nv_dss_per = 51.91.  
    IF wdetail.si = "200,000.00"    THEN ASSIGN nv_dss_per = 51.90.  
    IF wdetail.si = "210,000.00"    THEN ASSIGN nv_dss_per = 51.86.  
    IF wdetail.si = "220,000.00"    THEN ASSIGN nv_dss_per = 51.82.  
    IF wdetail.si = "230,000.00"    THEN ASSIGN nv_dss_per = 51.82.  
    IF wdetail.si = "240,000.00"    THEN ASSIGN nv_dss_per = 51.78.  
    IF wdetail.si = "250,000.00"    THEN ASSIGN nv_dss_per = 51.74.  
    IF wdetail.si = "260,000.00"    THEN ASSIGN nv_dss_per = 51.73.  
    IF wdetail.si = "270,000.00"    THEN ASSIGN nv_dss_per = 51.67.  
    IF wdetail.si = "280,000.00"    THEN ASSIGN nv_dss_per = 51.66.  
    IF wdetail.si = "290,000.00"    THEN ASSIGN nv_dss_per = 51.65.  
    IF wdetail.si = "300,000.00"    THEN ASSIGN nv_dss_per = 51.62.  
    IF wdetail.si = "310,000.00"    THEN ASSIGN nv_dss_per = 51.60.  
    IF wdetail.si = "320,000.00"    THEN ASSIGN nv_dss_per = 51.57.  
    IF wdetail.si = "330,000.00"    THEN ASSIGN nv_dss_per = 51.54.  
    IF wdetail.si = "340,000.00"    THEN ASSIGN nv_dss_per = 51.54.  
    IF wdetail.si = "350,000.00"    THEN ASSIGN nv_dss_per = 51.51.  
    IF wdetail.si = "360,000.00"    THEN ASSIGN nv_dss_per = 51.47.  
    IF wdetail.si = "370,000.00"    THEN ASSIGN nv_dss_per = 51.46.  
    IF wdetail.si = "380,000.00"    THEN ASSIGN nv_dss_per = 51.41.  
    IF wdetail.si = "390,000.00"    THEN ASSIGN nv_dss_per = 51.40.  
    IF wdetail.si = "400,000.00"    THEN ASSIGN nv_dss_per = 51.37.
    IF wdetail.si = "410,000.00"    THEN ASSIGN nv_dss_per = 51.34.  
    IF wdetail.si = "420,000.00"    THEN ASSIGN nv_dss_per = 51.33.  
    IF wdetail.si = "430,000.00"    THEN ASSIGN nv_dss_per = 51.32.  
    IF wdetail.si = "440,000.00"    THEN ASSIGN nv_dss_per = 51.30.  
    IF wdetail.si = "450,000.00"    THEN ASSIGN nv_dss_per = 51.30.  
    IF wdetail.si = "460,000.00"    THEN ASSIGN nv_dss_per = 51.27.  
    IF wdetail.si = "470,000.00"    THEN ASSIGN nv_dss_per = 51.24.  
    IF wdetail.si = "480,000.00"    THEN ASSIGN nv_dss_per = 51.21.  
    IF wdetail.si = "490,000.00"    THEN ASSIGN nv_dss_per = 51.21.  
    IF wdetail.si = "500,000.00"    THEN ASSIGN nv_dss_per = 51.18.
END.                 
ELSE IF wdetail.subclass = "320" THEN DO:
    WDETAIL.NCB = "50".
    IF wdetail.si = "100,000.00"    THEN ASSIGN nv_dss_per = 41.55.  
    IF wdetail.si = "110,000.00"    THEN ASSIGN nv_dss_per = 41.56.  
    IF wdetail.si = "120,000.00"    THEN ASSIGN nv_dss_per = 41.50.  
    IF wdetail.si = "130,000.00"    THEN ASSIGN nv_dss_per = 41.52.  
    IF wdetail.si = "140,000.00"    THEN ASSIGN nv_dss_per = 41.48.  
    IF wdetail.si = "150,000.00"    THEN ASSIGN nv_dss_per = 41.46.  
    IF wdetail.si = "160,000.00"    THEN ASSIGN nv_dss_per = 41.47.  
    IF wdetail.si = "170,000.00"    THEN ASSIGN nv_dss_per = 41.48.  
    IF wdetail.si = "180,000.00"    THEN ASSIGN nv_dss_per = 41.46.  
    IF wdetail.si = "190,000.00"    THEN ASSIGN nv_dss_per = 41.44.  
    IF wdetail.si = "200,000.00"    THEN ASSIGN nv_dss_per = 41.46.  
    IF wdetail.si = "210,000.00"    THEN ASSIGN nv_dss_per = 41.44.  
    IF wdetail.si = "220,000.00"    THEN ASSIGN nv_dss_per = 41.42.  
    IF wdetail.si = "230,000.00"    THEN ASSIGN nv_dss_per = 41.43.  
    IF wdetail.si = "240,000.00"    THEN ASSIGN nv_dss_per = 41.41.  
    IF wdetail.si = "250,000.00"    THEN ASSIGN nv_dss_per = 41.40. 
    IF wdetail.si = "260,000.00"    THEN ASSIGN nv_dss_per = 41.41.  
    IF wdetail.si = "270,000.00"    THEN ASSIGN nv_dss_per = 41.35.  
    IF wdetail.si = "280,000.00"    THEN ASSIGN nv_dss_per = 41.36.  
    IF wdetail.si = "290,000.00"    THEN ASSIGN nv_dss_per = 41.37.  
    IF wdetail.si = "300,000.00"    THEN ASSIGN nv_dss_per = 41.35.  
    IF wdetail.si = "310,000.00"    THEN ASSIGN nv_dss_per = 41.36.  
    IF wdetail.si = "320,000.00"    THEN ASSIGN nv_dss_per = 41.35.  
    IF wdetail.si = "330,000.00"    THEN ASSIGN nv_dss_per = 41.33.  
    IF wdetail.si = "340,000.00"    THEN ASSIGN nv_dss_per = 41.34.  
    IF wdetail.si = "350,000.00"    THEN ASSIGN nv_dss_per = 41.33.  
    IF wdetail.si = "360,000.00"    THEN ASSIGN nv_dss_per = 41.31.  
    IF wdetail.si = "370,000.00"    THEN ASSIGN nv_dss_per = 41.32.  
    IF wdetail.si = "380,000.00"    THEN ASSIGN nv_dss_per = 41.28.  
    IF wdetail.si = "390,000.00"    THEN ASSIGN nv_dss_per = 41.28.  
    IF wdetail.si = "400,000.00"    THEN ASSIGN nv_dss_per = 41.26.
    IF wdetail.si = "410,000.00"    THEN ASSIGN nv_dss_per = 41.25.  
    IF wdetail.si = "420,000.00"    THEN ASSIGN nv_dss_per = 41.26.  
    IF wdetail.si = "430,000.00"    THEN ASSIGN nv_dss_per = 41.27.  
    IF wdetail.si = "440,000.00"    THEN ASSIGN nv_dss_per = 41.26.  
    IF wdetail.si = "450,000.00"    THEN ASSIGN nv_dss_per = 41.27.  
    IF wdetail.si = "460,000.00"    THEN ASSIGN nv_dss_per = 41.26.  
    IF wdetail.si = "470,000.00"    THEN ASSIGN nv_dss_per = 41.24.  
    IF wdetail.si = "480,000.00"    THEN ASSIGN nv_dss_per = 41.23.  
    IF wdetail.si = "490,000.00"    THEN ASSIGN nv_dss_per = 41.24.  
    IF wdetail.si = "500,000.00"    THEN ASSIGN nv_dss_per = 41.23.
END.                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam C-Win 
PROCEDURE proc_insnam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  
    n_insref      = ""  
    nv_usrid      = "" 
    nv_transfer   = NO
    n_check       = ""
    nv_insref     = ""
    putchr        = ""
    putchr1       = ""
    nv_typ        = ""
    nv_usrid      = SUBSTRING(USERID(LDBNAME(1)),3,4) 
    nv_transfer   = YES.
/*comment by Kridtiya i. A56-0047...
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME     = TRIM(wdetail.insnam)   NO-ERROR NO-WAIT.  end.. by Kridtiya i. A56-0047...*/ 
/*add A56-0047....*/
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME     = TRIM(wdetail.insnam)   AND 
    sicsyac.xmm600.homebr   = TRIM(wdetail.branch)   AND 
    sicsyac.xmm600.clicod   = "IN"                   NO-ERROR NO-WAIT.  /*end..add A56-0047 */ 
IF NOT AVAILABLE sicsyac.xmm600 THEN DO: 
    IF LOCKED sicsyac.xmm600 THEN DO:   
        ASSIGN nv_transfer = NO 
               n_insref    = sicsyac.xmm600.acno.
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
        ELSE DO:  /* ---- Check ด้วย name ---- */
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
            ELSE nv_typ = "0s".         /*0s= บุคคลธรรมดา Cs = นิติบุคคล  */
        END. 
        RUN proc_insno .
        IF n_check <> "" THEN DO: 
            ASSIGN nv_transfer = NO
                nv_insref   = "".
            RETURN.
        END.
        IF nv_insref <> "" THEN DO:
            loop_runningins:                /*Check Insured  */
            REPEAT:
                FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                    sicsyac.xmm600.acno = CAPS(nv_insref)  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm600 THEN DO:
                    RUN proc_insno .
                    IF n_check <> "" THEN DO: 
                        ASSIGN nv_transfer = NO
                            nv_insref   = "".
                        RETURN.
                    END.
                END.
                ELSE LEAVE loop_runningins.
            END.
        END.
        IF nv_insref <> "" THEN CREATE sicsyac.xmm600.
        ELSE DO:
            ASSIGN 
                wdetail.pass = "N"  
                wdetail.comment = wdetail.comment + "| รหัสลูกค้าเป็นค่าว่างไม่สามารถนำเข้าระบบได้ค่ะ" 
                WDETAIL.OK_GEN  = "N"
                nv_transfer = NO.
        END.    /**/
    END.
    n_insref = nv_insref.
END.
ELSE DO:
    IF sicsyac.xmm600.acno <> "" THEN DO:
        ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            n_insref                = caps(trim(nv_insref)) 
            nv_transfer             = NO 
            sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname    = ""                        /*First Name*/
            sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
            sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
            sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1    = wdetail.iadd1             /*Address line 1*/
            sicsyac.xmm600.addr2    = wdetail.iadd2             /*Address line 2*/
            sicsyac.xmm600.addr3    = wdetail.iadd3             /*Address line 3*/
            sicsyac.xmm600.addr4    = wdetail.iadd4             
            sicsyac.xmm600.homebr   = TRIM(wdetail.branch)   /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                     
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid  
            sicsyac.xmm600.dtyp20   = ""
            sicsyac.xmm600.dval20   = ""   .     
        /*RETURN.*/
    END.
END.
IF nv_transfer = YES THEN DO:     
    ASSIGN  sicsyac.xmm600.acno = nv_insref                 /*Account no*/
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
        sicsyac.xmm600.name     = TRIM(wdetail.insnam)       /*Name Line 1*/
        sicsyac.xmm600.abname   = TRIM(wdetail.insnam)       /*Abbreviated Name*/
        sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*/     /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = wdetail.iadd1             /*Address line 1*/
        sicsyac.xmm600.addr2    = wdetail.iadd2             /*Address line 2*/
        sicsyac.xmm600.addr3    = wdetail.iadd3             /*Address line 3*/
        sicsyac.xmm600.addr4    = wdetail.iadd4             /*Address line 4*/
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
        sicsyac.xmm600.naddr1   = ""                       /*New address line 1*/
        sicsyac.xmm600.gstreg   = ""                       /*GST Registration No.*/
        sicsyac.xmm600.naddr2   = ""                       /*New address line 2*/
        sicsyac.xmm600.fax      = ""                       /*Fax No.*/
        sicsyac.xmm600.naddr3   = ""                       /*New address line 3*/
        sicsyac.xmm600.telex    = ""                       /*Telex No.*/
        sicsyac.xmm600.naddr4   = ""                       /*New address line 4*/
        sicsyac.xmm600.name2    = ""                       /*Name Line 2*/
        sicsyac.xmm600.npostcd  = ""                       /*New postal code*/
        sicsyac.xmm600.name3    = ""                       /*Name Line 3*/
        sicsyac.xmm600.nphone   = ""                       /*New phone no.*/    
        sicsyac.xmm600.nachg    = YES                      /*Change N&A on Renewal/Endt*/
        sicsyac.xmm600.regdate  = ?                        /*Agents registration Date*/
        sicsyac.xmm600.alevel   = 0                        /*Agency Level*/
        sicsyac.xmm600.taxno    = ""                       /*Agent tax no.*/
        sicsyac.xmm600.anlyc1   = ""                       /*Analysis Code 1*/
        sicsyac.xmm600.taxdate  = ?                        /*Agent tax date*/
        sicsyac.xmm600.anlyc5   =  ""                      /*Analysis Code 5*/
        sicsyac.xmm600.dtyp20   = ""
        sicsyac.xmm600.dval20   = "".
END.
IF sicsyac.xmm600.acno <> "" THEN DO:              /*A55-0268 add chk nv_insref = "" */
    ASSIGN nv_insref = trim(sicsyac.xmm600.acno)
        nv_transfer  = YES.
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
    IF nv_transfer = YES THEN DO:
        ASSIGN
            sicsyac.xtm600.acno    = nv_insref               /*Account no.*/
            sicsyac.xtm600.name    = TRIM(wdetail.insnam)    /*Name of Insured Line 1*/
            sicsyac.xtm600.abname  = TRIM(wdetail.insnam)    /*Abbreviated Name*/
            sicsyac.xtm600.addr1   = wdetail.iadd1           /*address line 1*/
            sicsyac.xtm600.addr2   = wdetail.iadd2           /*address line 2*/
            sicsyac.xtm600.addr3   = wdetail.iadd3           /*address line 3*/
            sicsyac.xtm600.addr4   = wdetail.iadd4           /*address line 4*/
            sicsyac.xtm600.name2   = ""                                                 /*Name of Insured Line 2*/ 
            sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)                               /*Title*/
            sicsyac.xtm600.name3   = ""                                                 /*Name of Insured Line 3*/
            sicsyac.xtm600.fname   = "" .                                               /*First Name*/
    END.
END.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
/*RETURN.
HIDE MESSAGE NO-PAUSE.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam2 C-Win 
PROCEDURE proc_insnam2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Add by Kridtiya i. A63-0472*/
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno     =  n_insref   NO-ERROR NO-WAIT.  
IF AVAIL sicsyac.xmm600 THEN
    ASSIGN
    sicsyac.xmm600.acno_typ  = wdetail.insnamtyp   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    sicsyac.xmm600.icno      = trim(wdetail.icno)       
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/     .  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insno C-Win 
PROCEDURE proc_insno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  nv_insref = "" .
FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
    sicsyac.xzm056.seqtyp   =  nv_typ        AND
    sicsyac.xzm056.branch   =  TRIM(wdetail.branch)    NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN sicsyac.xzm056.seqtyp =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref = TRIM(wdetail.branch)  + String(1,"999999")
            nv_lastno = 1.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(TRIM(wdetail.branch)) = 2 THEN
            nv_insref = TRIM(wdetail.branch) + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:   
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno + 1 ,"999999").
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(TRIM(wdetail.branch)) = 2 THEN
            nv_insref = TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").
        END.   
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.branch)
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(TRIM(wdetail.branch)) = 2 THEN
            nv_insref = TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"999999").
        END.
    END.
    ELSE DO:
        IF LENGTH(TRIM(wdetail.branch)) = 2 THEN
            nv_insref = TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno,"99999").
        END.
    END.   
END.
IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno Then Do :
    /*MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
        "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
        "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. */
    n_check = "ERROR".
    RETURN. 
END.         /*lastno > seqno*/                       
ELSE DO :    /*lastno <= seqno */
    IF nv_typ = "0s" THEN DO:
        IF n_search = YES THEN DO:
            CREATE sicsyac.xzm056.
            ASSIGN
                sicsyac.xzm056.seqtyp    =  nv_typ
                sicsyac.xzm056.branch    =  TRIM(wdetail.branch)
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
                sicsyac.xzm056.branch    =  TRIM(wdetail.branch)
                sicsyac.xzm056.des       =  "Company/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno. 
        END.
    END.
END.        /*lastno <= seqno */  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_mailtxt C-Win 
PROCEDURE proc_mailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
IF  wdetail.drivnam = "Y" THEN DO :      /*note add 07/11/2005*/
 
 DEF VAR no_policy AS CHAR FORMAT "x(20)" .
 DEF VAR no_rencnt AS CHAR FORMAT "99".
 DEF VAR no_endcnt AS CHAR FORMAT "999".
 
 DEF VAR no_riskno AS CHAR FORMAT "999".
 DEF VAR no_itemno AS CHAR FORMAT "999".

  no_policy = sic_bran.uwm301.policy .
  no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") .
  no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") .

  no_riskno = "001".
  no_itemno = "001".
  
  nv_drivage1 =  YEAR(TODAY) - INT(SUBSTR(wdetail.dbirth,7,4))  .
  nv_drivage2 =  YEAR(TODAY) - INT(SUBSTR(wdetail.ddbirth,7,4))  .

  IF wdetail.dbirth <> " "  AND wdetail.drivername1 <> " " THEN DO: /*note add & modified*/
     nv_drivbir1      = STRING(INT(SUBSTR(wdetail.dbirth,7,4)) + 543).
     wdetail.dbirth = SUBSTR(wdetail.dbirth,1,6) + nv_drivbir1.
  END.

  IF wdetail.ddbirth <>  " " AND wdetail.drivername2 <> " " THEN DO: /*note add & modified */
     nv_drivbir2      = STRING(INT(SUBSTR(wdetail.ddbirth,7,4)) + 543).
     wdetail.ddbirth = SUBSTR(wdetail.ddbirth,1,6) + nv_drivbir2.
  END.
  
  FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
               brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
               brstat.mailtxt_fil.bchyr = nv_batchyr   AND                                               
               brstat.mailtxt_fil.bchno = nv_batchno   AND
               brstat.mailtxt_fil.bchcnt  = nv_batcnt    NO-LOCK  NO-ERROR  NO-WAIT.
        IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.                                                      


        FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                     brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno     AND
                     brstat.mailtxt_fil.lnumber = nv_lnumber    AND
                     brstat.mailtxt_fil.bchyr = nv_batchyr    AND                                               
                     brstat.mailtxt_fil.bchno = nv_batchno    AND
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt     NO-LOCK  NO-ERROR  NO-WAIT.
                     
        IF NOT AVAIL brstat.mailtxt_fil   THEN DO:

              CREATE brstat.mailtxt_fil.
              ASSIGN                                           
                     brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                     brstat.mailtxt_fil.lnumber   = nv_lnumber.
                     brstat.mailtxt_fil.ltext     = wdetail.drivername1 + FILL(" ",30 - LENGTH(wdetail.drivername1)). 
                     brstat.mailtxt_fil.ltext2    = wdetail.dbirth + "  " 
                                                  + string(nv_drivage1).
                     nv_drivno                    = 1.
                     ASSIGN /*a490166*/
                     brstat.mailtxt_fil.bchyr = nv_batchyr 
                     brstat.mailtxt_fil.bchno = nv_batchno 
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                     SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/
              IF wdetail.drivername2 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil. 
                    ASSIGN
                        brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                        brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                        brstat.mailtxt_fil.ltext    = wdetail.drivername2 + FILL(" ",30 - LENGTH(wdetail.drivername2)). 
                        brstat.mailtxt_fil.ltext2   = wdetail.ddbirth + "  "
                                                    + string(nv_drivage2). 
                        nv_drivno                   = 2.
                        ASSIGN /*a490166*/
                        brstat.mailtxt_fil.bchyr = nv_batchyr 
                        brstat.mailtxt_fil.bchno = nv_batchno 
                        brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                        SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/    .
              END.  /*drivnam2 <> " " */
        END. /*End Avail Brstat*/
        ELSE  DO:
              CREATE  brstat.mailtxt_fil.
              ASSIGN  brstat.mailtxt_fil.policy     = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
                      brstat.mailtxt_fil.lnumber    = nv_lnumber.
                      brstat.mailtxt_fil.ltext      = wdetail.drivername1 + FILL(" ",30 - LENGTH(wdetail.drivername1)). 
                      brstat.mailtxt_fil.ltext2     = wdetail.dbirth + "  "
                                                    +  TRIM(string(nv_drivage1)).

                      IF wdetail.drivername2 <> "" THEN DO:
                            CREATE  brstat.mailtxt_fil.
                                ASSIGN
                                brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                                brstat.mailtxt_fil.ltext    = wdetail.drivername2 + FILL(" ",30 - LENGTH(wdetail.drivername2)). 
                                brstat.mailtxt_fil.ltext2   = wdetail.ddbirth + "  "
                                                            + TRIM(string(nv_drivage1)).
                                ASSIGN /*a490166*/
                                brstat.mailtxt_fil.bchyr = nv_batchyr 
                                brstat.mailtxt_fil.bchno = nv_batchno 
                                brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/
                      END. /*drivnam2 <> " " */
        END. /*Else DO*/
 END. /*note add for mailtxt 07/11/2005*/*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab C-Win 
PROCEDURE proc_maktab :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_simat = 0
    nv_simat1 = 0
    nv_simat = (DECI(wdetail.si) * 50 / 100 )
    nv_simat1 = DECI(wdetail.si) + nv_simat .
Find FIRST stat.maktab_fil Use-index      maktab04          Where
    stat.maktab_fil.makdes   =     wdetail.brand              And                  
    index(stat.maktab_fil.moddes,wdetail.model) <> 0          And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear)   AND
    /*stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND*/
    stat.maktab_fil.sclass   =     "****"                     AND
    (stat.maktab_fil.si      >=     nv_simat                  OR
     stat.maktab_fil.si       <=     nv_simat1 )             /*AND  
     stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)  */ 
    No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    Assign
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.seats   =  stat.maktab_fil.seats .
ELSE MESSAGE "not found stat.maktab_fil" .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchpol C-Win 
PROCEDURE proc_matchpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A60-0232      
------------------------------------------------------------------------------*/
FOR EACH wdetail2 .
    IF index(wdetail2.polstk,"TEXT")        <> 0  THEN DELETE wdetail2.
    ELSE IF INDEX(wdetail2.polstk,"เลขที่") <> 0  THEN DELETE wdetail2.
    ELSE IF TRIM(wdetail2.polstk) = " "  THEN DELETE wdetail2.
    ELSE DO:
        IF wdetail2.cedpol <> "" THEN DO:
            /* A59-0590 : หากรมธรรม์ 72 */
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                /*sicuw.uwm100.cedpol = trim(wdetail2.cedpol) AND   */ /*A63-00472*/
                sicuw.uwm100.cedpol = trim(wdetail2.kkapp)  AND        /*A63-00472*/
                sicuw.uwm100.poltyp = "V72"                 AND
                YEAR(sicuw.uwm100.expdat) > YEAR(DATE(wdetail2.comdat)) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                    ASSIGN  wdetail2.polstk = sicuw.uwm100.policy .
            END.
            ELSE DO: 
                ASSIGN wdetail2.polstk = "".
            END.
            /* End A59-0590*/
        END. 
        IF wdetail2.polstk = "" THEN DO:
            FIND LAST sicuw.uwm301 USE-INDEX uwm30121  WHERE 
                sicuw.uwm301.cha_no = trim(wdetail2.chassis) AND 
                sicuw.uwm301.tariff = "9" NO-LOCK NO-ERROR NO-WAIT.    /*A63-00472*/
                                                             /*sicuw.uwm301.tariff = "T" NO-LOCK NO-ERROR NO-WAIT.*//*A63-00472*/
                 IF AVAIL sicuw.uwm301 THEN DO:
                     ASSIGN wdetail2.polstk = sicuw.uwm301.policy.
                     FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE  
                            sicuw.uwm100.policy = trim(wdetail2.polstk) AND 
                            sicuw.uwm100.poltyp = "V72"    NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL sicuw.uwm100 THEN DO:
                            IF YEAR(sicuw.uwm100.expdat) > YEAR(date(wdetail2.comdat)) THEN 
                                ASSIGN  wdetail2.polstk = sicuw.uwm100.policy .
                            ELSE 
                                 ASSIGN  wdetail2.polstk = "" .
                        END.
                        ELSE DO: 
                            ASSIGN wdetail2.polstk = "".
                        END.
                 END.
                 ELSE  ASSIGN  wdetail2.polstk = "" .
        END.
    END.
END.      /* wdetail2*/
RUN proc_reportpol.
MESSAGE "Match policy Complete" VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchtypins C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open C-Win 
PROCEDURE proc_open :
/*OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y".   */
OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policy C-Win 
PROCEDURE proc_policy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
DEF VAR nv_text AS CHAR FORMAT "x(150)".
DEF VAR n_nameno AS INTE.
IF wdetail.policy <> "" THEN DO:
  IF wdetail.stk  <>  ""  THEN DO: 
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
    ELSE chr_sticker = wdetail.stk.
    chk_sticker = chr_sticker.
    RUN wuz\wuzchmod.
    IF chk_sticker  <>  chr_sticker  Then 
      /*MESSAGE "Sticker Number"  wdetail.stk "ใช้ Generate ไม่ได้ เนื่องจาก Modulo Error"  VIEW-AS ALERT-BOX.*/
      ASSIGN wdetail.pass = "N"
      wdetail.comment     = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
    FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
      sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF sicuw.uwm100.releas = YES THEN
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกโอนไปบัญชีแล้ว "
        wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
      /*IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN ..*//*kridtiya i. A54-0049*/
      IF (sicuw.uwm100.name1 <> "") AND (sicuw.uwm100.comdat <> ?) THEN 
          /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
        wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.
    /*ELSE  MESSAGE "ไม่พบ หมายเลขกรมธรรม์นี้ในระบบ  " wdetail.policy  VIEW-AS ALERT-BOX. */ /*-A59-0590-*/
    ELSE  IF rs_load = 1 THEN  MESSAGE "ไม่พบ หมายเลขกรมธรรม์นี้ในระบบ  " wdetail.policy  VIEW-AS ALERT-BOX. /*-A59-0590-*/
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002  WHERE
      sicuw.uwm100.cedpol =  wdetail.cedpol   AND
      sicuw.uwm100.poltyp =  "v72"            NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF (sicuw.uwm100.expdat > DATE(wdetail.comdat)) THEN 
        /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| พบเลขที่สัญญานี้ยังไม่หมดอายุ" + wdetail.cedpol
        wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.
    nv_newsck = " ".
    IF rs_load = 1 THEN DO: /* A59-0590 */
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + trim(wdetail.stk).
    END.   /* A59-0590 */
    ELSE wdetail.stk = "". /* A59-0590 */
    /***
    FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
    stat.detaitem.serailno = wdetail.stk      NO-LOCK NO-ERROR.
    IF AVAIL stat.detaitem THEN DO: 
    /*MESSAGE "หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้วโดยเลขที่กรมธรรม์ ." stat.Detaitem.policy VIEW-AS ALERT-BOX.*/
    IF stat.detaitem.policy <> wdetail.policy THEN
    ASSIGN wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้วด้วยกรมธรรม์อื่น"
    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.
    ELSE ASSIGN wdetail.pass = "N"
    wdetail.comment      = wdetail.comment + "| ไม่พบเลข Sticker เบอร์นี้ในระบบ"
    wdetail.warning      = "Program Running Policy No. ให้ชั่วคราว".
    ***/
    IF wdetail.policy = "" THEN DO:
      RUN proc_temppolicy.
      wdetail.policy  = nv_tmppol.
    END.
    RUN proc_create100.
  END.       /*wdetail.stk  <>  ""*/
  ELSE DO:  /*sticker = ""*/
      /*comment by Kridtiya i. A55-0212...
      ASSIGN wdetail.pass    = "N"
      wdetail.comment = wdetail.comment + "| ไม่พบหมายเลข Sticker(ค่าว่าง) ไม่สามารถนำเข้าระบบได้"
      wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
      end...comment by Kridtiya i. A55-0212...*/
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002  WHERE
      sicuw.uwm100.cedpol =  wdetail.cedpol     AND
      sicuw.uwm100.poltyp =  "v72"            NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF (sicuw.uwm100.expdat > DATE(wdetail.comdat)) THEN  
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| พบเลขที่สัญญานี้ยังไม่หมดอายุ" + wdetail.cedpol
        wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.
    FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
      sicuw.uwm100.policy = wdetail.policy   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF sicuw.uwm100.releas = YES THEN
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกโอนไปบัญชีแล้ว "
        wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
      /*IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN ..*//*kridtiya i. A54-0049*/
      IF (sicuw.uwm100.name1 <> "") AND (sicuw.uwm100.comdat <> ?) THEN 
          /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
          ASSIGN  wdetail.pass    = "N"
          wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
          wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
      IF wdetail.policy = "" THEN DO:
          RUN proc_temppolicy.
          wdetail.policy  = nv_tmppol.
      END.
      RUN proc_create100. 
    END.  /*policy <> "" & stk = ""*/                 
    ELSE DO: 
        IF rs_load = 1 THEN DO: /*A59-0590*/
            MESSAGE "ไม่พบ หมายเลขกรมธรรม์นี้ในระบบ  " wdetail.policy  VIEW-AS ALERT-BOX. 
            RUN proc_create100.  /*add A52-0172*/
        END.  /*A59-0590*/
        ELSE RUN proc_create100. /*A59-0590*/
    END.
  END.
END.
ELSE DO:  /*wdetail.policy = ""*/
  IF wdetail.stk  <>  ""  THEN DO:
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
    ELSE chr_sticker = wdetail.stk.
    chk_sticker = chr_sticker.
    RUN wuz\wuzchmod.
    IF chk_sticker  <>  chr_sticker  Then 
        /*MESSAGE "Sticker Number"  wdetail.stk "ใช้ Generate ไม่ได้ เนื่องจาก Modulo Error"  VIEW-AS ALERT-BOX.*/
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
    FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
      sicuw.uwm100.policy =  wdetail.policy NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF (sicuw.uwm100.name1 <> "" AND sicuw.uwm100.comdat <> ? ) OR sicuw.uwm100.releas = YES THEN 
        ASSIGN  wdetail.pass    = "N"
          wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
          wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.    /*add kridtiya i..*/
    /*ELSE  MESSAGE "ไม่พบ หมายเลขกรมธรรม์นี้ในระบบ  " wdetail.policy  VIEW-AS ALERT-BOX. */ /*A59-0590*/
    ELSE IF rs_load = 1 THEN MESSAGE "ไม่พบ หมายเลขกรมธรรม์นี้ในระบบ  " wdetail.policy  VIEW-AS ALERT-BOX. /*A59-0590 */
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002  WHERE
        sicuw.uwm100.cedpol =  wdetail.cedpol   AND
        sicuw.uwm100.poltyp =  "v72"            NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
        IF (sicuw.uwm100.expdat > DATE(wdetail.comdat)) THEN 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| พบเลขที่สัญญานี้ยังไม่หมดอายุ" + wdetail.cedpol
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.
    nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
    ELSE wdetail.stk = wdetail.stk.
         /*FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN DO:
            /*MESSAGE "หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้วโดยเลขที่กรมธรรม์ ." stat.Detaitem.policy VIEW-AS ALERT-BOX.*/
            IF trim(stat.detaitem.policy) <> trim(wdetail.policy) THEN 
                ASSIGN wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้วด้วยกรมธรรม์อื่น"
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".  
        END.
        ELSE ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| ไม่พบเลข Sticker เบอร์นี้ในระบบ"
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".*/
/*      END. /*uwm100*/ kridtiyai  ..*/
    IF wdetail.policy = "" THEN DO:
        RUN proc_temppolicy.
        wdetail.policy  = nv_tmppol.
    END.
    RUN proc_create100.
  END.  /*wdetail.stk  <>  ""*/
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
  ASSIGN nv_docno  = wdetail.Docno
  nv_accdat = TODAY.
ELSE DO:
    IF wdetail.docno  = "" THEN nv_docno  = "".
    IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
/*add kridtiya i. A54-0203 */
/* comment by A59-0590..............
    FIND FIRST brstat.msgcode WHERE 
        brstat.msgcode.compno = "999"   AND
        brstat.msgcode.MsgDesc  = wdetail.tiname   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN  
        ASSIGN wdetail.tiname  =  trim(brstat.msgcode.branch).
    ELSE wdetail.tiname = "คุณ".
..............END A59-0590*/
RUN proc_insnam.
RUN proc_insnam2 . /*Add by Kridtiya i. A63-0472*/
/*End...add kridtiya i. A54-0203 */
DO TRANSACTION:
  ASSIGN sic_bran.uwm100.renno  = ""
  sic_bran.uwm100.endno  = ""
  sic_bran.uwm100.poltyp = wdetail.poltyp
  /*sic_bran.uwm100.insref = IF wdetail.poltyp = "V72" THEN "COMP" ELSE ""*//*A56-0309*/
  sic_bran.uwm100.insref =  trim(nv_insref)                                       /*A56-0309*/
  sic_bran.uwm100.opnpol = ""
  sic_bran.uwm100.anam2  = trim(wdetail.Icno)     /* ICNO  Cover Note A51-0071 Amparat */
  sic_bran.uwm100.ntitle = trim(wdetail.tiname)   /*"คุณ"   */          
  sic_bran.uwm100.name1  = trim(wdetail.insnam)   /*TRIM(wdetail.insnam)  */
  /*sic_bran.uwm100.name2  = "และ/หรือ ธนาคาร เกียรตินาคิน จำกัด (มหาชน)" *//*kridtiya i. A53-0097 01/04/2010*/
  sic_bran.uwm100.name2  = ""      /*kridtiya i. A53-0097 01/04/2010*/
  sic_bran.uwm100.name3  = ""                 
  sic_bran.uwm100.addr1  = wdetail.iadd1  
  sic_bran.uwm100.addr2  = wdetail.iadd2  
  sic_bran.uwm100.addr3  = wdetail.iadd3  
  sic_bran.uwm100.addr4  = wdetail.iadd4
  sic_bran.uwm100.postcd =  "" 
  sic_bran.uwm100.undyr  = String(Year(today),"9999")   /*   nv_undyr  */
  sic_bran.uwm100.branch = caps(trim(wdetail.branch))                  /* nv_branch  */                        
  sic_bran.uwm100.dept   = nv_dept
  sic_bran.uwm100.usrid  = USERID(LDBNAME(1))
  sic_bran.uwm100.fstdat = DATE(wdetail.comdat)         /*TODAY */
  sic_bran.uwm100.comdat = DATE(wdetail.comdat)
  sic_bran.uwm100.expdat = DATE(wdetail.expdat)
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
  sic_bran.uwm100.prog   = "wgwkkg72"
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
  sic_bran.uwm100.acno1  = fi_producer  /*  nv_acno1 */
  sic_bran.uwm100.agent  = fi_agent     /*nv_agent   */
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
  sic_bran.uwm100.drn_p  =  NO
  sic_bran.uwm100.sch_p  =  NO
  sic_bran.uwm100.cr_2   =  n_cr2
  sic_bran.uwm100.bchyr  = nv_batchyr          /*Batch Year */  
  sic_bran.uwm100.bchno  = nv_batchno          /*Batch No.  */  
  sic_bran.uwm100.bchcnt = nv_batcnt           /*Batch Count*/  
  sic_bran.uwm100.prvpol = ""                  /*wdetail.renpol*/      /*A52-0172*/
  /*sic_bran.uwm100.cedpol = trim(wdetail.cedpol)*/ /*a61-0335*/
  sic_bran.uwm100.cedpol = IF trim(wdetail.kkapp) <> "" THEN trim(wdetail.kkapp) ELSE trim(wdetail.cedpol) /*a61-0335*/
  /*sic_bran.uwm100.finint  = wdetail.finint*/
  /*sic_bran.uwm100.bs_cd  = "".  */                  /*comment by kridtiya i. A53-0018 เพิ่ม Vatcode*/
  /*sic_bran.uwm100.bs_cd   = wdetail.delerco   .  /*add kridtiya i. A53-0018 เพิ่ม Vatcode*/*//*comment kridtiya i. A53-0097 01042010*/
  sic_bran.uwm100.bs_cd   = ""      /*comment kridtiya i. A53-0097 01042010*/
  sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)    /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)     /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.postcd     = trim(wdetail.postcd)       /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.icno       = trim(wdetail.icno)         /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)      /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)    /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)    /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)    /*Add by Kridtiya i. A63-0472*/
  /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)   /*Add by Kridtiya i. A63-0472*/*/
  sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov)  /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.dealer     = wdetail.financecd .        /*Add by Kridtiya i. A63-0472*/ 

  IF wdetail.renpol <> " " THEN DO:
    IF wdetail.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = ""  sic_bran.uwm100.tranty  = "R".  
    ELSE ASSIGN sic_bran.uwm100.prvpol  = wdetail.renpol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
        sic_bran.uwm100.tranty  = "R".               /*Transaction Type (N/R/E/C/T)*/
  END.
  IF wdetail.pass = "Y" THEN sic_bran.uwm100.impflg  = YES.
  ELSE sic_bran.uwm100.impflg  = NO.
  IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.   
  IF wdetail.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
  ELSE  sic_bran.uwm100.polsta = "IF".
  IF fi_loaddat <> ? THEN  sic_bran.uwm100.trndat = fi_loaddat.
  ELSE sic_bran.uwm100.trndat = TODAY.
  sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
  nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                    (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                    (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat. 
END.   /*transaction*/
/* create : A60-0232*/
ASSIGN  nv_text = ""
        nv_text = wdetail.phone  + wdetail.tname1 + wdetail.cname1 + wdetail.lname1 + wdetail.icno1  + wdetail.tname2 + 
                  wdetail.cname2 + wdetail.lname2 + wdetail.icno2  + wdetail.tname3 + wdetail.cname3 + wdetail.lname3 + wdetail.icno3 +
                  wdetail.namenotify + wdetail.cedpol . /*A61-0335*/
IF trim(nv_text) <> " " THEN RUN proc_uwd100.  
/* end : A60-0232*/
/* --------------------U W M 1 2 0 -------------- */
/*IF INDEX(wdetail.nmember,"-สาขา") <> 0 THEN  RUN   proc_uwd102new.   /* Add A56-0231 */*//* Add A57-0434 */ 
IF trim(wdetail.nmember) <> "" THEN  RUN   proc_uwd102new.   /* Add A57-0434 */ 
FIND sic_bran.uwm120 USE-INDEX uwm12001      WHERE
    sic_bran.uwm120.policy  = sic_bran.uwm100.policy AND 
    sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt AND 
    sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND 
    sic_bran.uwm120.riskgp  = s_riskgp               AND 
    sic_bran.uwm120.riskno  = s_riskno               AND       
    sic_bran.uwm120.bchyr   = nv_batchyr             AND 
    sic_bran.uwm120.bchno   = nv_batchno             AND
    sic_bran.uwm120.bchcnt  = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm120 THEN DO:
  RUN wgw/wgwad120 (INPUT sic_bran.uwm100.policy,   /***--- A490166 Note Modi ---***/
                    sic_bran.uwm100.rencnt,
                    sic_bran.uwm100.endcnt,
                    s_riskgp,
                    s_riskno,
                    OUTPUT  s_recid2).
  FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
END.     /* end not avail  uwm120 */
IF AVAILABLE sic_bran.uwm120 THEN DO:  
  ASSIGN sic_bran.uwm120.sicurr = "BHT"
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
  sic_bran.uwm120.bchyr  = nv_batchyr       /* batch Year */
  sic_bran.uwm120.bchno  = nv_batchno       /* bchno      */
  sic_bran.uwm120.bchcnt = nv_batcnt .      /* bchcnt     */
  IF wdetail.poltyp = "v72" THEN DO:
      ASSIGN sic_bran.uwm120.class  =  CAPS(wdetail.subclass)
      s_recid2     = RECID(sic_bran.uwm120).
  END.
  ELSE IF wdetail.poltyp = "v70"  THEN ASSIGN sic_bran.uwm120.class  = CAPS(wdetail.prempa)  + wdetail.subclass
    s_recid2     = RECID(sic_bran.uwm120).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_redbook72 C-Win 
PROCEDURE proc_redbook72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_classmat  AS CHAR INIT "".
DEF VAR nv_modelmat  AS CHAR INIT "".

IF      wdetail.subclass = "110"  THEN nv_classmat  = "110".    
ELSE IF wdetail.subclass = "140A" THEN nv_classmat  = "320".   
ELSE IF wdetail.subclass = "120A" THEN nv_classmat  = "210".  
ASSIGN nv_modelmat = IF INDEX(wdetail.model," ") <> 0 THEN SUBSTR(wdetail.model,1,INDEX(wdetail.model," ")) ELSE wdetail.model.

Find First stat.maktab_fil USE-INDEX maktab04    Where
    stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
    index(stat.maktab_fil.moddes,nv_modelmat) <> 0              And
    stat.maktab_fil.sclass   =  nv_classmat               No-lock no-error no-wait.
If  avail stat.maktab_fil  THEN DO:
    ASSIGN  
    /*wdetail.redbook  =  stat.maktab_fil.modcod*/
    wdetail.body     =  stat.maktab_fil.body .
    FIND LAST sicsyac.xmm102 WHERE 
        sicsyac.xmm102.moddes  = wdetail.brand NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm102  THEN DO:
        ASSIGN  
            wdetail.comment = wdetail.comment + "| not find on table xmm102".
    END.
    ELSE DO:
        ASSIGN 
            wdetail.redbook = sicsyac.xmm102.modcod.
        IF wdetail.body = "" THEN 
            ASSIGN 
            wdetail.body    = IF wdetail.subclass = "110" THEN  "SEDAN  " ELSE "PICKUP" . 
    END.
END.
ELSE DO:
    FIND LAST sicsyac.xmm102 WHERE 
        sicsyac.xmm102.moddes  = wdetail.brand NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm102  THEN DO:
        ASSIGN  
            wdetail.comment = wdetail.comment + "| not find on table xmm102".
    END.
    ELSE DO:
        ASSIGN 
            wdetail.redbook = sicsyac.xmm102.modcod
            wdetail.body    = IF wdetail.subclass = "110" THEN  "SEDAN  " ELSE "PICKUP" .
            
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew C-Win 
PROCEDURE proc_renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
       sicuw.uwm100.policy = wdetail.renpol
       No-lock No-error no-wait.
   IF AVAIL sicuw.uwm100  THEN DO:
       IF sicuw.uwm100.renpol <> " " THEN DO:
           MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
           ASSIGN
               wdetail.renpol  = "Already Renew" /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
               wdetail.comment = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
               wdetail.OK_GEN  = "N"
               wdetail.pass    = "N". 
       END.
       ELSE DO: 
           ASSIGN
               n_rencnt  =  sicuw.uwm100.rencnt  +  1
               n_endcnt  =  0
               wdetail.pass  = "Y".
           RUN proc_assignrenew.
       END.
   End.   /*  avail  buwm100  */
   Else do:  
       n_rencnt  =  0.
       n_Endcnt  =  0.
       /*Message    "เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  "   View-as alert-box.*/
       ASSIGN
           wdetail.renpol   = ""
           wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".
         
   END.  /*not  avail uwm100*/
   IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".
     /*RUN wexp\wexpdisc.*//*a490166 note Block ชั่วคราว*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 C-Win 
PROCEDURE proc_report1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_row  =  1.
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
        "stk        "   ","              
        "poltyp     "   ","              
        "policy     "   ","              
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
        "redbook    "   ","
        "brand      "   ","            
        "model      "   ","            
        "cc         "   ","            
        "weight     "   ","            
        "seat       "   ","            
        "body       "   ","            
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
        "drivnam    "   ","        
        "drivnam1   "   ","        
        "drivbir1   "   ","        
        "drivbir2   "   ","        
        "drivage1   "   ","        
        "cancel     "   ","        
        "WARNING    "   ","                
        "comment    "   ","               
        "seat41     "   ","               
        "pass       "   ","               
        "OK_GEN     "   ","               
        "comper     "   ","               
        "comacc     "   ","               
        "NO_41      "   ","               
        "NO_42      "   ","               
        "NO_43      "   ","               
        "tariff     "   ","               
        "baseprem   "   ","               
        "cargrp     "   ","               
        "producer   "   ","               
        "agent      "   ","               
        "inscod     "   ","               
        "premt      "   ","               
        "base       "   ","               
        "accdat     "   ","               
        "docno      "   ","               
        "ICNO       "   ","               
        "CoverNote  "                     
        SKIP.                                                   
    FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"  :           
        PUT STREAM ns1                                               
            wdetail.branch      ","
            wdetail.stk         "," 
            wdetail.poltyp      ","
            wdetail.policy      ","
            wdetail.entdat      ","
            wdetail.enttim      ","
            wdetail.trandat     ","
            wdetail.trantim     ","
            wdetail.renpol      ","
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
            wdetail.redbook     "," 
            wdetail.brand       ","  
            wdetail.model       ","  
            wdetail.cc          ","  
            wdetail.weight      ","  
            wdetail.seat        ","  
            wdetail.body        ","        
            wdetail.vehreg      ","  
            wdetail.engno       "," 
            wdetail.chasno      ","               
            wdetail.caryear     ","               
            wdetail.carprovi    ","               
            wdetail.vehuse      ","               
            wdetail.garage      ","               
            wdetail.covcod      "," 
            wdetail.si          "," 
            wdetail.volprem     "," 
            wdetail.Compprem    "," 
            wdetail.fleet       "," 
            wdetail.ncb         "," 
            wdetail.access      "," 
            wdetail.deductpp    "," 
            wdetail.deductba    "," 
            wdetail.deductpa    "," 
            wdetail.benname     "," 
            wdetail.n_user      "," 
            wdetail.n_IMPORT    "," 
            wdetail.n_export    "," 
            wdetail.drivnam     "," 
            wdetail.drivnam1    "," 
            wdetail.drivbir1    "," 
            wdetail.drivbir2    "," 
            wdetail.drivage1    "," 
            wdetail.cancel      ","
            wdetail.WARNING     ","
            wdetail.comment     ","
            wdetail.seat41      ","
            wdetail.pass        ","   
            wdetail.OK_GEN      ","   
            wdetail.comper      ","   
            wdetail.comacc      ","   
            wdetail.NO_41       ","   
            wdetail.NO_42       ","   
            wdetail.NO_43       ","   
            wdetail.tariff      ","   
            wdetail.baseprem    ","   
            wdetail.cargrp      ","   
            wdetail.producer    ","   
            wdetail.agent       ","   
            wdetail.inscod      ","   
            wdetail.premt       ","   
            wdetail.base        ","   
            wdetail.accdat      ","   
            wdetail.docno       ","   
            wdetail.ICNO        ","   
            wdetail.CoverNote   ","  
            SKIP.  
    END.
END.                                                                                    
OUTPUT STREAM ns1 CLOSE.                                                       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT2 C-Win 
PROCEDURE PROC_REPORT2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
nv_row  =  1.
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
              "policy   "      "," 
              "redbook   "     ","  
              "brand    "      ","  
              "model    "      ","  
              "body     "      ","
              "branch   "      ","     
              "entdat   "      ","     
            "enttim   "      ","     
            "trandat  "      ","     
            "trantim  "      ","     
            "poltyp   "      ","     
            "policy   "      ","     
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
            "cc       "      ","     
            "weight   "      ","     
            "seat     "      ","     
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
            "drivnam  "      ","     
            "drivnam1 "      ","     
            "drivbir1 "      ","     
            "drivbir2 "      ","     
            "drivage1 "      ","     
            "cancel   "      ","     
            "WARNING  "      ","     
            "comment   "     ","    
            "seat41    "     ","    
            "pass      "     ","    
            "OK_GEN    "     ","    
            "comper    "     ","    
            "comacc    "     ","    
            "NO_41     "     ","    
            "NO_42     "     ","    
            "NO_43     "     ","    
            "tariff    "     ","    
            "baseprem  "     ","    
            "cargrp    "     ","    
            "producer  "     ","    
            "agent     "     ","    
            "inscod    "     ","    
            "premt     "     ","    
            "base      "     ","    
            "accdat    "     ","    
            "docno     "     ","    
            "ICNO      "     ","    
            "CoverNote "    
            
        SKIP.        
    FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
            wdetail.policy       ","
            wdetail.brand        ","  
            wdetail.model        ","  
            wdetail.body         "," 
            wdetail.branch       ","
        wdetail.entdat       ","
        wdetail.enttim       ","
        wdetail.trandat      ","
        wdetail.trantim      ","
        wdetail.poltyp       ","
        wdetail.renpol       ","
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
        wdetail.redbook      ","
        wdetail.cc           ","  
        wdetail.weight       ","  
        wdetail.seat         ","  
        wdetail.vehreg       ","  
        wdetail.engno        "," 
        wdetail.chasno       ","               
        wdetail.caryear      ","               
        wdetail.carprovi     ","               
        wdetail.vehuse       ","               
        wdetail.garage       ","               
        wdetail.stk          "," 
        wdetail.covcod       "," 
        wdetail.si           "," 
        wdetail.volprem      "," 
        wdetail.Compprem     "," 
        wdetail.fleet        "," 
        wdetail.ncb          "," 
        wdetail.access       "," 
        wdetail.deductpp     "," 
        wdetail.deductba     "," 
        wdetail.deductpa     "," 
        wdetail.benname      "," 
        wdetail.n_user       "," 
        wdetail.n_IMPORT     "," 
        wdetail.n_export     "," 
        wdetail.drivnam      "," 
        wdetail.drivnam1     "," 
        wdetail.drivbir1     "," 
        wdetail.drivbir2     "," 
        wdetail.drivage1     "," 
        wdetail.cancel       ","
        wdetail.WARNING      ","
        wdetail.comment      ","
        wdetail.seat41       ","
        wdetail.pass         ","   
        wdetail.OK_GEN       ","   
        wdetail.comper       ","   
        wdetail.comacc       ","   
        wdetail.NO_41        ","   
        wdetail.NO_42        ","   
        wdetail.NO_43        ","   
        wdetail.tariff       ","   
        wdetail.baseprem     ","   
        wdetail.cargrp       ","   
        wdetail.producer     ","   
        wdetail.agent        ","   
        wdetail.inscod       ","   
        wdetail.premt        ","    
        wdetail.base         ","   
        wdetail.accdat       ","   
        wdetail.docno        ","   
        wdetail.ICNO         ","   
        wdetail.CoverNote    
    SKIP.  
  
  END.
OUTPUT STREAM ns2 CLOSE.                                                           
END. /*pass > 0*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportex C-Win 
PROCEDURE proc_reportex :
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
If  substr(fi_outputex,length(fi_outputex) - 3,4) <>  ".slk"  THEN 
    fi_outputex  =  Trim(fi_outputex) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outputex).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "บริษัทเงินทุน ธนาคารเกียรตินาคิน จำกัด (มหาชน) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "id        "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "br_nam    "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "number    "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "polstk    "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "recivedat "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "cedpol    "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "insurnam  "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "vehreg    "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "brand     "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "model     "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "notifyno  "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "namnotify "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "chassis   "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "comp      "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "premt     "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "comdat    "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "expdat    "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "memmo    "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "KK app   "       '"' SKIP.   /*a61-0335*/

FOR EACH wdetail2  no-lock.
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetail2.id            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail2.br_nam        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail2.number        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail2.polstk        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail2.recivedat     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail2.cedpol        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail2.insurnam      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail2.vehreg        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail2.brand         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail2.model         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail2.notifyno      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail2.namnotify     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail2.chassis       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail2.comp          '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail2.premt         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail2.comdat        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail2.expdat        '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail2.memmo         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail2.kkapp         '"' SKIP. /*A61-0335*/
END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportpol C-Win 
PROCEDURE proc_reportpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A60-0232   
------------------------------------------------------------------------------*/
nv_row  =  0.
DEF VAR a AS CHAR FORMAT "x(100)" INIT "".
DEF VAR b AS CHAR FORMAT "x(100)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR NOT_pass AS INTE INIT 0.

OUTPUT STREAM ns1 TO value(fi_output1).
PUT STREAM ns1
    "เลขที่กรมธรรม์พ.ร.บ.      "    "|"              
    "เลขที่สัญญา               "    "|"              
    "ชื่อสาขา(ดีเลอร์)         "    "|"              
    "สาขา                      "    "|"              
    "คลาสรถ                    "    "|"              
    "เบี้ยพรบ.                 "    "|"              
    "เบี้ยรวม                  "    "|"        
    "วันที่ รับชำระค่าพรบ.     "    "|"             
    "วันที่เริ่มคุ้มครอง       "    "|"             
    "วันที่สิ้นสุดความคุ้มครอง "    "|"             
    "คำนาม                     "    "|"             
    "ชื่อ                      "    "|"             
    "เลขที่บัตรประชาชน         "    "|"             
    "ที่อยู่1                  "    "|"             
    "ที่อยู่2                  "    "|"             
    "ที่อยู่3                  "    "|"             
    "ที่อยู่4                  "    "|"             
    "ยี่ห้อรถ                  "    "|"             
    "รุ่นรถ                    "    "|"             
    "ทะเบียนรถ                 "    "|"
    "เลขตัวถัง                 "    "|"
    "เลขสติ๊กเกอร์             "    "|"            
    "ผู้รับผลประโยชน์          "    "|"            
    "เลขที่รับแจ้ง             "    "|"            
    "ผู้แจ้ง (Mkt)             "    "|"            
    "หมายเหตุ/วันที่ออกพรบ.    "    "|"            
    "เบอร์ติดต่อ               "    "|"            
    "คำนำหน้าชื่อ 1            "    "|"               
    "ชื่อกรรมการ 1             "    "|"               
    "นามสกุลกรรมการ 1          "    "|"               
    "เลขที่บัตรประชาชนกรรมการ 1"    "|"               
    "คำนำหน้าชื่อ 2            "    "|"               
    "ชื่อกรรมการ 2             "    "|"               
    "นามสกุลกรรมการ 2          "    "|"               
    "เลขที่บัตรประชาชนกรรมการ 2"    "|"               
    "คำนำหน้าชื่อ 3            "    "|"       
    "ชื่อกรรมการ 3             "    "|"        
    "นามสกุลกรรมการ 3          "    "|"
    "เลขที่บัตรประชาชนกรรมการ 3"    "|"
    "จัดส่งเอกสารที่สาขา       "    "|"   /*a61-0335*/    
    "ชื่อผู้รับเอกสาร"              "|"   /*a61-0335*/    
    "KK App "                       SKIP.     /*a61-0335*/    
                                                     
FOR EACH  wdetail2 WHERE  NO-LOCK. 
    PUT STREAM ns1 
        wdetail2.polstk     "|"
        wdetail2.cedpol     "|" 
        wdetail2.br_nam     "|"
        wdetail2.branch     "|"
        wdetail2.class      "|"
        wdetail2.comp       "|"
        wdetail2.premt      "|"
        wdetail2.recivedat  "|"
        wdetail2.comdat     "|"
        wdetail2.expdat     "|" 
        wdetail2.namTITLE   "|"
        wdetail2.insurnam   "|"
        wdetail2.icno       "|"
        wdetail2.ad11       "|" 
        wdetail2.ad12       "|"
        wdetail2.ad13       "|"
        wdetail2.ad14       "|"
        wdetail2.brand      "|"  
        wdetail2.model      "|" 
        wdetail2.vehreg     "|" 
        wdetail2.chassis    "|" 
        wdetail2.number     "|"  
        wdetail2.benname    "|"  
        wdetail2.notifyno   "|"  
        wdetail2.namnotify  "|"  
        wdetail2.memmo      "|"  
        wdetail2.phone      "|"        
        wdetail2.tname1     "|"  
        wdetail2.cname1     "|" 
        wdetail2.lname1     "|"               
        wdetail2.icno1      "|"               
        wdetail2.tname2     "|"               
        wdetail2.cname2     "|"               
        wdetail2.lname2     "|"               
        wdetail2.icno2      "|" 
        wdetail2.tname3     "|" 
        wdetail2.cname3     "|" 
        wdetail2.lname3     "|" 
        wdetail2.icno3      "|"
        wdetail2.nsend      "|"    /*A61-0335*/
        wdetail2.sendname   "|"    /*A61-0335*/
        wdetail2.kkapp      SKIP.  /*A61-0335*/
END.
OUTPUT STREAM ns1 CLOSE.                                                       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_susspect C-Win 
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
    nv_idnolist    = trim(wdetail.icno) .
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_TempPolicy C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_usdcod C-Win 
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
ASSIGN
  nv_age1  = INTEGER(nv_drivage1)
  nv_age2  = INTEGER(nv_drivage2).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 C-Win 
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
    /*nv_txt1  = "ขยายอุปกรณ์ตกแต่งเพิ่มเติมไม่เกิน 20,000.00 บาท" */     /*A60-0232*/
    /*nv_txt2  = "วันที่แจ้งงาน SAFE : " + wdetail.revday */              /*A60-0232*/
    /* create by A60-0232*/
    /*nv_txt1  = " เบอร์โทร :" + wdetail.phone    */ /*A61-0335*/
    nv_txt1  = "ชื่อผู้แจ้งงาน : " + wdetail.namenotify + " เบอร์โทร :" + wdetail.phone    /*A61-0335*/       
    nv_txt2  = "ชื่อกรรมการ1 : " + wdetail.tname1 + " " + wdetail.cname1 + " " + wdetail.lname1 + " "
               + "เลขบัตรประชาชน1 : " + wdetail.icno1
    nv_txt3  = "ชื่อกรรมการ2 : " + wdetail.tname2 + " " + wdetail.cname2 + " " + wdetail.lname2 + " " 
               + "เลขบัตรประชาชน2 : " + wdetail.icno2
    nv_txt4  = "ชื่อกรรมการ3 : " + wdetail.tname3 + " " + wdetail.cname3 + " " + wdetail.lname3 + " "
               + "เลขบัตรประชาชน3 : " + wdetail.icno3
   /* nv_txt5  = "" */    /*A61-0335*/
    nv_txt5  = "เลขที่สัญญา : " + wdetail.cedpol .  /*a61-0335*/
    /* end : A60-0232 */
/*DO WHILE nv_line1 <= 5:*/ /*a61-0335*/
DO WHILE nv_line1 <= 7: /*a61-0335*/
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
    IF nv_line1 = 6  THEN wuppertxt.txt = IF wdetail.nsend <> "" THEN "จัดส่งเอกสารที่สาขา: " + wdetail.nsend + 
                                                                      " ชื่อผู้รับเอกสาร: " + wdetail.sendname ELSE "" .

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 C-Win 
PROCEDURE proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
/*C52/00205
เดือนดาว ฐานวิเศษ แจ้งงาน 09/03/2009
เบี้ยปกติDealerแถมประกัน + พรบ. */
DEF VAR n_num1 AS INTE INIT 0.
DEF VAR n_num2 AS INTE INIT 0.
DEF VAR n_num3 AS INTE INIT 1.
DEF VAR i AS INTE INIT 0.
DEF VAR n_text1 AS CHAR FORMAT "x(255)".

nv_fptr = 0.
nv_bptr = 0.
nv_fptr = sic_bran.uwm100.fptr02.
/*IF wdetail2.memmo       <> "" THEN  wdetail2.memmo   .   */
/*IF wdetail2.ac_date     <> "" THEN  wdetail2.ac_date    = ",วันที่:"        + wdetail2.ac_date . 
IF wdetail2.ac_amount   <> "" THEN  wdetail2.ac_amount  = ",จำนวนเงิน:"     + wdetail2.ac_amount.
IF wdetail2.ac_pay      <> "" THEN  wdetail2.ac_pay     = ",ประเภทการจ่าย:" + wdetail2.ac_pay .  
IF wdetail2.ac_agent    <> "" THEN  wdetail2.ac_agent   = ",เลขที่ตัวแทน:"  + wdetail2.ac_agent .
IF wdetail.appenno      <> "" THEN  wdetail.appenno     = ",เลขที่รับแจ้ง:" + wdetail.appenno. 
IF wdetail.bysave       <> "" THEN  wdetail.bysave      = ",ชื่อผู้บันทึก:" + wdetail.bysave. */
IF nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? THEN DO:
DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
   FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr
   NO-ERROR NO-WAIT.
   IF AVAILABLE sic_bran.uwd102 THEN DO: /*sombat */
     nv_fptr = sic_bran.uwd102.fptr.
     CREATE sic_bran.uwd102.
     ASSIGN
       sic_bran.uwd102.policy        = sic_bran.uwm100.policy             /* NEW POLICY */
       sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt
       sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt               /* New Endorsement */
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
   ELSE DO:    /*sombat*/
     HIDE MESSAGE NO-PAUSE.
     MESSAGE "not found " sic_bran.uwd102.policy sic_bran.uwd102.rencnt "/"
              sic_bran.uwd102.endcnt "on file sic_bran.uwd102".
     LEAVE.
   END.

END.                /* End DO nv_fptr */
END.
ELSE DO:
     ASSIGN n_text1 = wdetail.nmember
            n_num1 = LENGTH(n_text1)  
            n_num2 = n_num1 / 65       
            nv_fptr = 0.                
                                       
     CREATE sic_bran.uwd102.
     ASSIGN
      sic_bran.uwd102.policy        = sic_bran.uwm100.policy            /* NEW POLICY */
      sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt 
      sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt            /* New Endorsement */
      sic_bran.uwd102.bptr          = nv_bptr
      sic_bran.uwd102.fptr          = 0
      sic_bran.uwd102.ltext         = n_text1 .
     IF nv_bptr <> 0 THEN DO:
       FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_bptr NO-ERROR NO-WAIT.
       sic_bran.uwd102.fptr = RECID(uwd102).
     END.
     IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(uwd102).
     nv_bptr = RECID(uwd102).
END.
sic_bran.uwm100.bptr02 = nv_bptr.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102new C-Win 
PROCEDURE proc_uwd102new :
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
DEF VAR n_text11 AS CHAR FORMAT "x(65)".
DEF VAR n_text12 AS CHAR FORMAT "x(65)".
DEF VAR n_text13 AS CHAR FORMAT "x(65)".
DEF VAR n_text14 AS CHAR FORMAT "x(65)".
DEF VAR n_text15 AS CHAR FORMAT "x(65)".

ASSIGN nv_fptr    = 0
       nv_bptr    = 0
       nv_nptr    = 0
       nv_line1   = 1
       n_text1    = ""
       n_text11   = ""
       n_text12   = ""
       n_text13   = ""
       n_text14   = ""
       n_text15   = ""
       n_text1    = IF INDEX(wdetail.nmember,"-สาขา") <> 0 THEN 
                       trim(substr(wdetail.nmember,INDEX(wdetail.nmember,"-สาขา") + 5 ))
                    ELSE " " +  TRIM(wdetail.nmember)
       fi_process = "Create Memo Text....."  .
                         
DISP fi_process WITH FRAM fr_main.
IF LENGTH(n_text1) > 60  THEN DO:
    loop_chk1:
    REPEAT:
        IF LENGTH(trim(n_text11 + " " + SUBSTR(n_text1,1,INDEX(n_text1," ")))) <= 60 THEN DO:
            IF INDEX(n_text1," ") <> 0  THEN DO:
                ASSIGN 
                    n_text11 = trim(n_text11 + " " + SUBSTR(n_text1,1,INDEX(n_text1," ")))
                    n_text1  = trim(SUBSTR(n_text1,INDEX(n_text1," "))).
            END.
            ELSE 
                ASSIGN 
                    n_text11 = trim(n_text11 + " " + SUBSTR(n_text1,1,60))
                    n_text1  = trim(SUBSTR(n_text1,61)).
            IF LENGTH(n_text1) <= 60 THEN DO:
                ASSIGN 
                    n_text12 = n_text1
                    n_text1 = "".
                LEAVE loop_chk1.
            END.
        END.
        ELSE LEAVE loop_chk1.
    END.
    IF LENGTH(n_text1) > 60 THEN DO:
        loop_chk2:
        REPEAT:
            IF LENGTH(trim(n_text12 + " " + SUBSTR(n_text1,1,INDEX(n_text1," ")))) <= 60 THEN DO:
                IF INDEX(n_text1," ") <> 0  THEN DO:
                    ASSIGN 
                        n_text12 = trim(n_text12 + " " + SUBSTR(n_text1,1,INDEX(n_text1," ")))
                        n_text1  = trim(SUBSTR(n_text1,INDEX(n_text1," "))).
                END.
                ELSE 
                    ASSIGN 
                        n_text12 = trim(n_text12 + " " + SUBSTR(n_text1,1,60))
                        n_text1  = trim(SUBSTR(n_text1,61)).
                IF LENGTH(n_text1) <= 60 THEN DO:
                    ASSIGN 
                        n_text13 = n_text1
                        n_text1 = "".
                    LEAVE loop_chk2.
                END.
            END.
            ELSE LEAVE loop_chk2.
        END.
    END.
    IF LENGTH(n_text1) > 60 THEN DO:
        loop_chk3:
        REPEAT:
            IF LENGTH(trim(n_text13 + " " + SUBSTR(n_text1,1,INDEX(n_text1," ")))) <= 60 THEN DO:
                IF INDEX(n_text1," ") <> 0  THEN DO:
                    ASSIGN 
                        n_text13 = trim(n_text13 + " " + SUBSTR(n_text1,1,INDEX(n_text1," ")))
                        n_text1  = trim(SUBSTR(n_text1,INDEX(n_text1," "))).
                END.
                ELSE 
                    ASSIGN 
                        n_text13 = trim(n_text13 + " " + SUBSTR(n_text1,1,60))
                        n_text1  = trim(SUBSTR(n_text1,61)).
                IF LENGTH(n_text1) <= 60 THEN DO:
                    ASSIGN 
                        n_text14 = n_text1
                        n_text1 = "".
                    LEAVE loop_chk3.
                END.
            END.
            ELSE LEAVE loop_chk3.
        END.
    END.
    IF LENGTH(n_text1) > 60 THEN DO:
        loop_chk4:
        REPEAT:
            IF LENGTH(trim(n_text14 + " " + SUBSTR(n_text1,1,INDEX(n_text1," ")))) <= 60 THEN DO:
                IF INDEX(n_text1," ") <> 0  THEN DO:
                    ASSIGN 
                        n_text14 = trim(n_text14 + " " + SUBSTR(n_text1,1,INDEX(n_text1," ")))
                        n_text1  = trim(SUBSTR(n_text1,INDEX(n_text1," "))).
                END.
                ELSE 
                    ASSIGN 
                        n_text14 = trim(n_text14 + " " + SUBSTR(n_text1,1,60))
                        n_text1  = trim(SUBSTR(n_text1,61)).
                IF LENGTH(n_text1) <= 60 THEN DO:
                    ASSIGN 
                        n_text15 = n_text1
                        n_text1 = "".
                    LEAVE loop_chk4.
                END.
            END.
            ELSE LEAVE loop_chk4.
        END.
    END.
END.
ASSIGN n_text11 = TRIM(n_text1)  .

FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
DO WHILE nv_line1 <= 7:
    CREATE wuppertxt3.                                                                                 
    wuppertxt3.line = nv_line1.     
    IF nv_line1 = 1  THEN wuppertxt3.txt = "".   
    IF nv_line1 = 2  THEN wuppertxt3.txt =  n_text11. 
    IF nv_line1 = 3  THEN wuppertxt3.txt =  n_text12. 
    IF nv_line1 = 4  THEN wuppertxt3.txt =  n_text13. 
    IF nv_line1 = 5  THEN wuppertxt3.txt =  n_text14. 
    IF nv_line1 = 6  THEN wuppertxt3.txt =  n_text15. 
    /*
    IF nv_line1 = 3  THEN wuppertxt3.txt =  "สาขา : "  + SUBSTR(wdetail.nmember2,index(wdetail.nmember2,"-:") + 2,R-INDEX(wdetail.nmember2,":") - index(wdetail.nmember2,"-:") - 2 ) + 
                                            " ชื่อเจ้าหน้าที่ MKT: " + SUBSTR(wdetail.nmember2,r-index(wdetail.nmember2,":") + 1 ). 
    IF nv_line1 = 4  THEN wuppertxt3.txt =  wdetail.campaign .                                         
    IF nv_line1 = 5  THEN wuppertxt3.txt =  wdetail.notiuser  .
    IF nv_line1 = 6  THEN wuppertxt3.txt =  "STK : " +  wdetail.stk  .                                 
    IF nv_line1 = 7  THEN wuppertxt3.txt =  "เลขที่สัญญา : " +  wdetail.cedpol .     
    IF nv_line1 = 8  THEN wuppertxt3.txt =  "เลขที่ตรวจสภาพ : " +  wdetail.ispno.
    IF nv_line1 = 9  THEN wuppertxt3.txt =  "ProductType : " + wdetail.product.
    IF nv_line1 = 10 THEN wuppertxt3.txt =  trim(wdetail.remak1) .*/
                                            
    /*IF nv_line1 = 3 THEN wuppertxt3.txt = "Date Confirm_file_name :" + wdetail.remark . */           
    nv_line1 = nv_line1 + 1.                                                                           
END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_vehmat C-Win 
PROCEDURE proc_vehmat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_vehnew AS CHAR FORMAT "x(40)" INIT " " .
IF SUBSTR(wdetail2.vehreg,1,1) = "/" THEN NEXT.
ELSE DO:
    ASSIGN n_vehnew = trim(wdetail2.vehreg) .
         IF index(n_vehnew,"กรุงเทพมหานคร")   <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"กรุงเทพมหานคร") - 1 )) + " กท".      
    ELSE IF index(n_vehnew,"กรุงเทพ")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"กรุงเทพ") - 1 ))       + " กท". 
    ELSE IF index(n_vehnew,"กท")              <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"กท") - 1 ))            + " กท".    
    ELSE IF index(n_vehnew,"กระบี่")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"กระบี่") - 1 ))        + " กบ". /*1*/
    ELSE IF index(n_vehnew,"กาญจนบุรี")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"กาญจนบุรี") - 1 ))     + " กจ". /*3*/   
    ELSE IF index(n_vehnew,"กาฬสินธุ์")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"กาฬสินธุ์") - 1 ))     + " กส". /*4*/   
    ELSE IF index(n_vehnew,"กำแพงเพชร")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"กำแพงเพชร") - 1 ))     + " กพ". /*5*/   
    ELSE IF index(n_vehnew,"ขอนแก่น")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ขอนแก่น") - 1 ))       + " ขก". /*6*/   
    ELSE IF index(n_vehnew,"จันทบุรี")        <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"จันทบุรี") - 1 ))      + " จท". /*7*/   
    ELSE IF index(n_vehnew,"ฉะเชิงเทรา")      <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ฉะเชิงเทรา") - 1 ))    + " ฉท". /*8*/   
    ELSE IF index(n_vehnew,"ชลบุรี")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ชลบุรี") - 1  ))       + " ชบ". /*9*/   
    ELSE IF index(n_vehnew,"ชัยนาท")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ชัยนาท") - 1  ))       + " ชน". /*10*/  
    ELSE IF index(n_vehnew,"ชัยภูมิ")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ชัยภูมิ") - 1 ))       + " ชย". /*11*/  
    ELSE IF index(n_vehnew,"ชุมพร")           <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ชุมพร") - 1 ))         + " ชพ". /*12*/  
    ELSE IF index(n_vehnew,"เชียงราย")        <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"เชียงราย") - 1  ))     + " ชร". /*13*/  
    ELSE IF index(n_vehnew,"เชียงใหม่")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"เชียงใหม่") - 1 ))     + " ชม". /*14*/  
    ELSE IF index(n_vehnew,"ตรัง")            <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ตรัง") - 1  ))         + " ตง". /*15*/  
    ELSE IF index(n_vehnew,"ตราด")            <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ตราด") - 1  ))         + " ตร". /*16*/  
    ELSE IF index(n_vehnew,"ตาก")             <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ตาก") - 1  ))          + " ตก". /*17*/  
    ELSE IF index(n_vehnew,"นครนายก")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"นครนายก") - 1  ))      + " นย". /*18*/  
    ELSE IF index(n_vehnew,"นครปฐม")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"นครปฐม") - 1 ))        + " นฐ". /*19*/  
    ELSE IF index(n_vehnew,"นครพนม")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"นครพนม") - 1  ))       + " นพ". /*20*/  
    ELSE IF index(n_vehnew,"นครราชสีมา")      <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"นครราชสีมา") - 1  ))   + " นม".  /*21*/  
    ELSE IF index(n_vehnew,"นครศรี")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"นครศรี") - 1  ))       + " นศ".  /*22*/ 
    ELSE IF index(n_vehnew,"นครสวรรค์")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"นครสวรรค์") - 1  ))    + " นว".  /*23*/
    ELSE IF index(n_vehnew,"นนทบุรี")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"นนทบุรี") - 1  ))      + " นบ".  /*24*/
    ELSE IF index(n_vehnew,"นราธวาส")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"นราธวาส") - 1  ))      + " นธ".  /*25*/
    ELSE IF index(n_vehnew,"น่าน")            <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"น่าน") - 1  ))         + " นน".  /*26*/
    ELSE IF index(n_vehnew,"บุรีรัมย์")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"บุรีรัมย์") - 1  ))    + " บร".  /*27*/
    ELSE IF index(n_vehnew,"ปทุมธานี")        <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ปทุมธานี") - 1  ))     + " ปท".  /*28*/
    ELSE IF index(n_vehnew,"ประจวบคีรีขันธ์") <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ประจวบคีรีขันธ์") - 1 )) + " ปข". /*29*/
    ELSE IF index(n_vehnew,"ปราจีนบุรี")      <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ปราจีนบุรี") - 1  ))  + " ปจ".   /*30*/
    ELSE IF index(n_vehnew,"ปัตตานี")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ปัตตานี") - 1  ))     + " ปน".   /*31*/
    ELSE IF index(n_vehnew,"อยุธยา")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"อยุธยา") - 1  ))      + " อย".   /*32*/
    ELSE IF index(n_vehnew,"พะเยา")           <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"พะเยา") - 1  ))       + " พย".   /*33*/
    ELSE IF index(n_vehnew,"พังงา")           <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"พังงา") - 1  ))       + " พง".   /*34*/
    ELSE IF index(n_vehnew,"พัทลุง")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"พัทลุง") - 1  ))      + " พท".   /*35*/
    ELSE IF index(n_vehnew,"พิจิตร")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"พิจิตร") - 1  ))      + " พจ".   /*36*/
    ELSE IF index(n_vehnew,"พิษณุโลก")        <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"พิษณุโลก") - 1  ))    + " พล".   /*37*/
    ELSE IF index(n_vehnew,"เพชรบุรี")        <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"เพชรบุรี") - 1  ))    + " พบ".   /*38*/
    ELSE IF index(n_vehnew,"เพชรบูรณ์")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"เพชรบูรณ์") - 1 ))    + " พช".   /*39*/
    ELSE IF index(n_vehnew,"แพร่")            <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"แพร่") - 1  ))        + " พร".   /*40*/
    ELSE IF index(n_vehnew,"ภูเก็ต")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ภูเก็ต") - 1  ))      + " ภก".   /*41*/
    ELSE IF index(n_vehnew,"มหาสารคาม")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"มหาสารคาม") - 1  ))   + " มค".   /*42*/
    ELSE IF index(n_vehnew,"มุกดาหาร")        <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"มุกดาหาร") - 1  ))    + " มห".   /*43*/
    ELSE IF index(n_vehnew,"แม่ฮ่องสอน")      <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"แม่ฮ่องสอน") - 1  ))  + " มส".   /*44*/
    ELSE IF index(n_vehnew,"ยะลา")            <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ยะลา") - 1  ))        + " ยล".   /*45*/
    ELSE IF index(n_vehnew,"ร้อยเอ็ด")        <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ร้อยเอ็ด") - 1  ))    + " รอ".   /*46*/
    ELSE IF index(n_vehnew,"ระนอง")           <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ระนอง") - 1 ))        + " รน".   /*47*/
    ELSE IF index(n_vehnew,"ระยอง")           <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ระยอง") - 1 ))        + " รย".   /*48*/
    ELSE IF index(n_vehnew,"ราชบุรี")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ราชบุรี") - 1  ))     + " รบ".   /*49*/
    ELSE IF index(n_vehnew,"ลพบุรี")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ลพบุรี") - 1 ))       + " ลบ".   /*50*/
    ELSE IF index(n_vehnew,"ลำปาง")           <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ลำปาง") - 1  ))       + " ลป".   /*51*/
    ELSE IF index(n_vehnew,"ลำพูน")           <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ลำพูน") - 1  ))       + " ลพ".   /*52*/
    ELSE IF index(n_vehnew,"เลย")             <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"เลย") - 1  ))         + " ลย".   /*53*/
    ELSE IF index(n_vehnew,"ศรีสะเกษ")        <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ศรีสะเกษ") - 1  ))    + " ศก".   /*54*/
    ELSE IF index(n_vehnew,"สกลนคร")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สกลนคร") - 1  ))      + " สน".   /*55*/
    ELSE IF index(n_vehnew,"สงขลา")           <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สงขลา") - 1  ))       + " สข".   /*56*/
    ELSE IF index(n_vehnew,"สระแก้ว")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สระแก้ว") - 1  ))     + " สก".   /*57*/
    ELSE IF index(n_vehnew,"สระบุรี")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สระบุรี") - 1  ))     + " สบ".   /*58*/
    ELSE IF index(n_vehnew,"สิงห์บุรี")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สิงห์บุรี") - 1  ))   + " สห".   /*59*/
    ELSE IF index(n_vehnew,"สุโขทัย")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สุโขทัย") - 1  ))     + " สท".   /*60*/
    ELSE IF index(n_vehnew,"สุพรรณบุรี")      <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สุพรรณบุรี") - 1  ))  + " สพ".   /*61*/
    ELSE IF index(n_vehnew,"สุราษฎร์")        <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สุราษฎร์") - 1 ))     + " สฎ".   
    ELSE IF index(n_vehnew,"สุรินทร์")        <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สุรินทร์") - 1  ))    + " สร".   /*63*/
    ELSE IF index(n_vehnew,"หนองคาย")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"หนองคาย") - 1  ))     + " นค".   /*64*/
    ELSE IF index(n_vehnew,"หนองบัวลำภู")     <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"หนองบัวลำภู") - 1  )) + " นล".   /*65*/
    ELSE IF index(n_vehnew,"อ่างทอง")         <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"อ่างทอง") - 1  ))     + " อท".   /*66*/
    ELSE IF index(n_vehnew,"อำนาจเจริญ")      <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"อำนาจเจริญ") - 1  ))  + " อจ".   /*67*/
    ELSE IF index(n_vehnew,"อุดรธานี")        <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"อุดรธานี") - 1  ))    + " อด".   /*68*/
    ELSE IF index(n_vehnew,"อุตรดิตถ์")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"อุตรดิตถ์") - 1  ))   + " อต".   /*69*/
    ELSE IF index(n_vehnew,"อุทัยธานี")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"อุทัยธานี") - 1  ))   + " อท".   /*70*/
    ELSE IF index(n_vehnew,"อุบลราชธานี")     <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"อุบลราชธานี") - 1  )) + " อบ".   /*71*/
    ELSE IF index(n_vehnew,"ยโสธร")           <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"ยโสธร") - 1  ))       + " ยส".   /*72*/
    ELSE IF index(n_vehnew,"สตูล")            <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สตูล") - 1  ))        + " สต".   /*73*/
    ELSE IF index(n_vehnew,"สุมทรปราการ")     <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สุมทรปราการ") - 1  )) + " สป".   /*74*/
    ELSE IF index(n_vehnew,"สุมทรสงคราม")     <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สุมทรสงคราม") - 1  )) + " สส".   /*75*/
    ELSE IF index(n_vehnew,"สุมทรสาคร")       <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"สุมทรสาคร") - 1  ))   + " สค".   /*76*/
    ELSE IF index(n_vehnew,"บึงกาฬ")          <> 0  THEN wdetail2.vehreg = trim(substr(n_vehnew,1,index(n_vehnew,"บึงกาฬ") - 1 ))       + " บก".   /*76*/
    
END.                                                                       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_vehmat1 C-Win 
PROCEDURE proc_vehmat1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by Kridtiya i. A54-0273
DEF VAR n_vehnew AS CHAR FORMAT "x(30)".
IF SUBSTR(wdetail2.vehreg,1,1) = "/" THEN NEXT.
ASSIGN n_vehnew = ""
    n_vehnew = trim(wdetail2.vehreg) .

IF (SUBSTR(n_vehnew,7,1) >= "0") AND (SUBSTR(n_vehnew,7,1) <= "9") THEN  
    ASSIGN  wdetail2.vehreg = substr(wdetail2.vehreg,1,7)          /*4*/
                    n_vehnew = trim(substr(n_vehnew,8)).
ELSE IF (SUBSTR(n_vehnew,6,1) >= "0") AND (SUBSTR(n_vehnew,6,1) <= "9") THEN   
    ASSIGN  wdetail2.vehreg = substr(wdetail2.vehreg,1,6)          /*3*/
                    n_vehnew = trim(substr(n_vehnew,7)).
ELSE IF (SUBSTR(n_vehnew,5,1) >= "0") AND (SUBSTR(n_vehnew,5,1) <= "9") THEN 
            ASSIGN  wdetail2.vehreg = substr(wdetail2.vehreg,1,5)  /*2*/
                    n_vehnew = trim(substr(n_vehnew,6)).
ELSE ASSIGN  wdetail2.vehreg = substr(wdetail2.vehreg,1,4)         /*1*/
                    n_vehnew = trim(substr(n_vehnew,5)).

IF SUBSTR(n_vehnew,1,1) = "-" THEN n_vehnew = SUBSTR(n_vehnew,2,30).

/*1*/   IF n_vehnew = "กระบี่"          OR n_vehnew = "กบ."   THEN n_vehnew = "กบ".
/*2*/   ELSE IF n_vehnew = "กรุงเทพมหานคร" OR n_vehnew = "กรุงเทพ"  OR n_vehnew = "กทม."   THEN n_vehnew = "กท".
/*3*/   ELSE IF n_vehnew = "กาญจนบุรี"       OR n_vehnew = "กจ."   THEN n_vehnew = "กจ".
/*4*/   ELSE IF n_vehnew = "กาฬสินธุ์"       OR n_vehnew = "กส."   THEN n_vehnew = "กส".
/*5*/   ELSE IF (n_vehnew = "กำแพงเพชร") OR (n_vehnew = "กพ.")   THEN n_vehnew = "กพ".
/*6*/   ELSE IF n_vehnew = "ขอนแก่น"         OR n_vehnew = "ขก."   THEN n_vehnew = "ขก".
/*7*/   ELSE IF n_vehnew = "จันทบุรี"        OR n_vehnew = "จท."   THEN n_vehnew = "จท".
/*8*/   ELSE IF n_vehnew = "ฉะเชิงเทรา"      OR n_vehnew = "ฉท."   THEN n_vehnew = "ฉท".
/*9*/   ELSE IF n_vehnew = "ชลบุรี"          OR n_vehnew = "ชบ."   THEN n_vehnew = "ชบ".
/*10*/  ELSE IF n_vehnew = "ชัยนาท"          OR n_vehnew = "ชน."   THEN n_vehnew = "ชน".
/*11*/  ELSE IF n_vehnew = "ชัยภูมิ"         OR n_vehnew = "ชย."   THEN n_vehnew = "ชย".
/*12*/  ELSE IF n_vehnew = "ชุมพร"           OR n_vehnew = "ชพ."   THEN n_vehnew = "ชพ".
/*13*/  ELSE IF n_vehnew = "เชียงราย"        OR n_vehnew = "ชร."   THEN n_vehnew = "ชร".
/*14*/  ELSE IF n_vehnew = "เชียงใหม่"       OR n_vehnew = "ชม."   THEN n_vehnew = "ชม".
/*15*/  ELSE IF n_vehnew = "ตรัง"            OR n_vehnew = "ตง."   THEN n_vehnew = "ตง".
/*16*/  ELSE IF n_vehnew = "ตราด"            OR n_vehnew = "ตร."   THEN n_vehnew = "ตร".
/*17*/  ELSE IF n_vehnew = "ตาก"             OR n_vehnew = "ตก."   THEN n_vehnew = "ตก".
/*18*/  ELSE IF n_vehnew = "นครนายก"         OR n_vehnew = "นย."   THEN n_vehnew = "นย".
/*19*/  ELSE IF n_vehnew = "นครปฐม"          OR n_vehnew = "นฐ."  THEN n_vehnew = "นฐ".
/*20*/  ELSE IF n_vehnew = "นครพนม"          OR n_vehnew = "นพ."  THEN n_vehnew = "นพ".
/*21*/  ELSE IF n_vehnew = "นครราชสีมา"      OR n_vehnew = "นม."  THEN n_vehnew = "นม".
/*22*/  ELSE IF n_vehnew = "นครศรีธรรมราช" OR n_vehnew = "นครศรีฯ"   OR n_vehnew = "นศ."  THEN n_vehnew = "นศ".
/*23*/  ELSE IF (n_vehnew = "นครสวรรค์" ) OR (n_vehnew = "นว.")  THEN n_vehnew = "นว".
/*24*/  ELSE IF n_vehnew = "นนทบุรี"         OR n_vehnew = "นบ."  THEN n_vehnew = "นบ".
/*25*/  ELSE IF n_vehnew = "นราธวาส"         OR n_vehnew = "นธ."  THEN n_vehnew = "นธ".
/*26*/  ELSE IF n_vehnew = "น่าน"            OR n_vehnew = "นน."  THEN n_vehnew = "นน".
/*27*/  ELSE IF n_vehnew = "บุรีรัมย์"       OR n_vehnew = "บร."  THEN n_vehnew = "บร".
/*28*/  ELSE IF n_vehnew = "ปทุมธานี"        OR n_vehnew = "ปท."  THEN n_vehnew = "ปท".
/*29*/  ELSE IF n_vehnew = "ประจวบคีรีขันธ์" OR n_vehnew = "ปข." THEN n_vehnew = "ปข".
/*30*/  ELSE IF n_vehnew = "ปราจีนบุรี"      OR n_vehnew = "ปจ." THEN n_vehnew = "ปจ".
/*31*/  ELSE IF n_vehnew = "ปัตตานี"         OR n_vehnew = "ปน." THEN n_vehnew = "ปน".
/*32*/  ELSE IF n_vehnew = "พระนครศรีอยุธยา" OR n_vehnew = "อยุธยา" THEN n_vehnew = "อย".
/*33*/  ELSE IF n_vehnew = "พะเยา"     OR n_vehnew = "พย."   THEN n_vehnew = "พย".
/*34*/  ELSE IF n_vehnew = "พังงา"     OR n_vehnew = "พง."   THEN n_vehnew = "พง".
/*35*/  ELSE IF n_vehnew = "พัทลุง"    OR n_vehnew = "พท."   THEN n_vehnew = "พท".
/*36*/  ELSE IF n_vehnew = "พิจิตร"    OR n_vehnew = "พจ."   THEN n_vehnew = "พจ".
/*37*/  ELSE IF n_vehnew = "พิษณุโลก"  OR n_vehnew = "พล."   THEN n_vehnew = "พล".
/*38*/  ELSE IF n_vehnew = "เพชรบุรี"  OR n_vehnew = "พบ."   THEN n_vehnew = "พบ".
/*39*/  ELSE IF n_vehnew = "เพชรบูรณ์" OR n_vehnew = "พช."   THEN n_vehnew = "พช".
/*40*/  ELSE IF n_vehnew = "แพร่"      OR n_vehnew = "พร."   THEN n_vehnew = "พร".
/*41*/  ELSE IF n_vehnew = "ภูเก็ต"    OR n_vehnew = "ภก."   THEN n_vehnew = "ภก".
/*42*/  ELSE IF n_vehnew = "มหาสารคาม" OR n_vehnew = "มค."   THEN n_vehnew = "มค".
/*43*/  ELSE IF n_vehnew = "มุกดาหาร"   OR  n_vehnew = "มห."   THEN n_vehnew = "มห".
/*44*/  ELSE IF n_vehnew = "แม่ฮ่องสอน" OR  n_vehnew = "มส."   THEN n_vehnew = "มส".
/*45*/  ELSE IF n_vehnew = "ยะลา"       OR  n_vehnew = "ยล."   THEN n_vehnew = "ยล".
/*46*/  ELSE IF n_vehnew = "ร้อยเอ็ด"   OR  n_vehnew = "รอ."   THEN n_vehnew = "รอ".
/*47*/  ELSE IF n_vehnew = "ระนอง"      OR  n_vehnew = "รน."   THEN n_vehnew = "รน".
/*48*/  ELSE IF n_vehnew = "ระยอง"      OR  n_vehnew = "รย."  THEN n_vehnew = "รย".
/*49*/  ELSE IF n_vehnew = "ราชบุรี"    OR  n_vehnew = "รบ."  THEN n_vehnew = "รบ".
/*50*/  ELSE IF n_vehnew = "ลพบุรี"     OR  n_vehnew = "ลบ."  THEN n_vehnew = "ลบ".
/*51*/  ELSE IF n_vehnew = "ลำปาง"      OR  n_vehnew = "ลป."  THEN n_vehnew = "ลป".
/*52*/  ELSE IF n_vehnew = "ลำพูน"      OR  n_vehnew = "ลพ."  THEN n_vehnew = "ลพ".
/*53*/  ELSE IF n_vehnew = "เลย"        OR  n_vehnew = "ลย."  THEN n_vehnew = "ลย".
/*54*/  ELSE IF n_vehnew = "ศรีสะเกษ"   OR  n_vehnew = "ศก."  THEN n_vehnew = "ศก".
/*55*/  ELSE IF n_vehnew = "สกลนคร"     OR  n_vehnew = "สน."  THEN n_vehnew = "สน".
/*56*/  ELSE IF n_vehnew = "สงขลา"      OR  n_vehnew = "สข."  THEN n_vehnew = "สข".
/*57*/  ELSE IF n_vehnew = "สระแก้ว"    OR  n_vehnew = "สก."  THEN n_vehnew = "สก".
/*58*/  ELSE IF n_vehnew = "สระบุรี"    OR  n_vehnew = "สบ."  THEN n_vehnew = "สบ".
/*59*/  ELSE IF n_vehnew = "สิงห์บุรี"  OR  n_vehnew = "สห."  THEN n_vehnew = "สห".
/*60*/  ELSE IF n_vehnew = "สุโขทัย"    OR  n_vehnew = "สท"  THEN n_vehnew = "สท".
/*61*/  ELSE IF n_vehnew = "สุพรรณบุรี" OR  n_vehnew = "สพ."  THEN n_vehnew = "สพ".
/*62*/  ELSE IF n_vehnew = "สุราษฎร์ธานี" OR n_vehnew = "สุราษฏร์" OR
     n_vehnew = "สฎ." OR  n_vehnew = "สุราษฏร์ธานี" THEN n_vehnew = "สฎ".
/*63*/  ELSE IF n_vehnew = "สุรินทร์"     OR n_vehnew = "สร."  THEN n_vehnew = "สร".
/*64*/  ELSE IF n_vehnew = "หนองคาย"      OR n_vehnew = "นค."  THEN n_vehnew = "นค".
/*65*/  ELSE IF n_vehnew = "หนองบัวลำภู"  OR n_vehnew = "นล."  THEN n_vehnew = "นล".
/*66*/  ELSE IF n_vehnew = "อ่างทอง"      OR n_vehnew = "อท."  THEN n_vehnew = "อท".
/*67*/  ELSE IF n_vehnew = "อำนาจเจริญ"   OR n_vehnew = "อจ."  THEN n_vehnew = "อจ".
/*68*/  ELSE IF n_vehnew = "อุดรธานี"     OR n_vehnew = "อด."  THEN n_vehnew = "อด".
/*69*/  ELSE IF n_vehnew = "อุตรดิตถ์"    OR n_vehnew = "อต."  THEN n_vehnew = "อต".
/*70*/  ELSE IF n_vehnew = "อุทัยธานี"    OR n_vehnew = "อท."  THEN n_vehnew = "อท".
/*71*/  ELSE IF n_vehnew = "อุบลราชธานี"  OR n_vehnew = "อบ."  THEN n_vehnew = "อบ".
/*72*/  ELSE IF n_vehnew = "ยโสธร"        OR n_vehnew = "ยส."  THEN n_vehnew = "ยส".
/*73*/  ELSE IF n_vehnew = "สตูล"         OR n_vehnew = "สต."  THEN n_vehnew = "สต".
/*74*/  ELSE IF n_vehnew = "สุมทรปราการ"  OR n_vehnew = "สป."  THEN n_vehnew = "สป".
/*75*/  ELSE IF n_vehnew = "สุมทรสงคราม"  OR n_vehnew = "สส."  THEN n_vehnew = "สส".
/*76*/  ELSE IF n_vehnew = "สุมทรสาคร"    OR n_vehnew = "สค."  THEN n_vehnew = "สค".
ASSIGN 
wdetail2.vehreg = trim(wdetail2.vehreg) + " " + n_vehnew .
end. ....comment by Kridtiya i. A54-0273*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wgw72013 C-Win 
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

