&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
File:  
program name : wgwntpis.w
Author:  Created: Ranu I A58-0489 Date 20/09/2016  
Description: Program Load text TPIS to GW New format 
copy rigth : wgwtsgen.w 
Input Parameters:  <none> 
Output Parameters:  <none>  */

/*Modify by  : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by  : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by  : Kridtiya i. A65-0035 comment message error premium not on file */
/***************************************************************************/     
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/*proc definition */
DEF VAR nv_nptr   AS RECID.
DEF VAR n_index   AS INTE INIT 0 .
DEF VAR n_index2  AS INTE INIT 0.
DEF VAR n_cr2    AS CHAR INIT "" FORMAT "x(20)".
DEF VAR num       AS DECI INIT 0.
DEF VAR aa        AS DECI.
DEF VAR expyear   AS DECI FORMAT "9999" .
DEF NEW SHARED VAR nv_producer AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR nv_agent    AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno. 
def  var  nv_row  as  int  init  0.
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
{wgw\wgwntpis.i}      /*ประกาศตัวแปร*/
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
DEFINE WORKFILE wuppertxt2 NO-UNDO
    FIELD policydup    AS CHAR   FORMAT "x(20)" 
    FIELD stk          AS CHARACTER FORMAT "X(25)"   INITIAL "". 
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
DEFINE VAR n_insref     AS CHARACTER FORMAT "X(10)" .              /*A56-0353*/
DEF    VAR nv_insref    AS CHAR      FORMAT "x(10)" INIT "" .      /*A56-0353*/
DEFINE VAR nv_typ       AS CHAR      FORMAT "X(2)".                /*A56-0353*/
DEFINE VAR n_check      AS CHARACTER .                             /*A56-0353*/
DEFINE WORKFILE wno30txt NO-UNDO
    FIELD policy AS CHAR FORMAT "x(20)"
    FIELD text30 AS CHAR FORMAT "x(60)".

DEF VAR n_revday AS CHAR FORMAT "x(20)" INIT "".
DEF VAR n_rev  AS INT INIT 0.
DEF VAR nv_memo1  AS CHAR Format "x(255)" init "".
DEF VAR nv_memo2  AS CHAR Format "x(255)" init "".
DEF VAR nv_memo3  AS CHAR Format "x(255)" init "".
DEF VAR nv_polmaster AS CHAR FORMAT "x(60)".
DEF VAR nv_chkerror  AS CHAR FORMAT "x(60)" INIT "" .  /*Add by Kridtiya i. A63-0472*/

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
&Scoped-define FIELDS-IN-QUERY-br_wdetail WDETAIL.WARNING wdetail.redbook wdetail.poltyp wdetail.policy wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.iadd1 wdetail.iadd2 wdetail.iadd3 wdetail.iadd4 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.engno wdetail.chasno wdetail.caryear wdetail.carprovi wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.volprem wdetail.Compprem wdetail.fleet wdetail.ncb wdetail.access wdetail.deductpp wdetail.deductba wdetail.deductpa wdetail.benname wdetail.n_user wdetail.n_IMPORT wdetail.n_export wdetail.drivnam1 wdetail.drivnam wdetail.drivbir1 wdetail.producer wdetail.agent wdetail.comment wdetail.cancel   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS tg_fileload ra_typeload fi_loaddat fi_pack ~
fi_campens fi_mocode fi_branch fi_memotext fi_producer fi_agent fi_vatcode ~
fi_bchno fi_name2 fi_prevbat fi_bchyr fi_filename bu_file fi_output1 ~
fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit br_wdetail bu_hpbrn ~
bu_hpacno1 bu_hpagent fi_process fi_fileexp buexp RECT-370 RECT-372 ~
RECT-373 RECT-374 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS tg_fileload ra_typeload fi_loaddat fi_pack ~
fi_campens fi_mocode fi_branch fi_memotext fi_producer fi_agent fi_vatcode ~
fi_bchno fi_name2 fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 ~
fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname fi_impcnt ~
fi_process fi_completecnt fi_premtot fi_premsuc fi_fileexp 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buexp 
     LABEL "Export file" 
     SIZE 12 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6.

DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 12 BY 1.14
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 12 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 3.5 BY .91.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 63.5 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(19)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_campens AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_fileexp AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 59.67 BY .91
     BGCOLOR 10 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_memotext AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 36 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_mocode AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 59 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.17 BY .91
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 63.5 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE ra_typeload AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Load To GW", 1,
"Match file Policy", 2,
"Match file Recipt", 3,
"Match Policy Send TPIS", 4
     SIZE 103.5 BY .91
     BGCOLOR 29 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.43
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 14.52
     BGCOLOR 29 FGCOLOR 2 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 5
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 2.86
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 23 BY 1.1
     BGCOLOR 19 .

DEFINE VARIABLE tg_fileload AS LOGICAL INITIAL no 
     LABEL "ไฟล์แจ้งงานใหม่" 
     VIEW-AS TOGGLE-BOX
     SIZE 20.67 BY .81
     BGCOLOR 19 FGCOLOR 0  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail C-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      WDETAIL.WARNING   COLUMN-LABEL "Warning"
        wdetail.redbook   COLUMN-LABEL "RedBook"
        wdetail.poltyp    COLUMN-LABEL "Policy Type"
        wdetail.policy    COLUMN-LABEL "Policy"
        wdetail.tiname    COLUMN-LABEL "Title Name"   
        wdetail.insnam    COLUMN-LABEL "Insured Name" 
        wdetail.comdat    COLUMN-LABEL "Comm Date"
        wdetail.expdat    COLUMN-LABEL "Expiry Date"
        wdetail.iadd1     COLUMN-LABEL "Ins Add1"
        wdetail.iadd2     COLUMN-LABEL "Ins Add2"
        wdetail.iadd3     COLUMN-LABEL "Ins Add3"
        wdetail.iadd4     COLUMN-LABEL "Ins Add4"
        wdetail.prempa    COLUMN-LABEL "Premium Package"
        wdetail.subclass  COLUMN-LABEL "Sub Class"
        wdetail.brand     COLUMN-LABEL "Brand"
        wdetail.model     COLUMN-LABEL "Model"
        wdetail.cc        COLUMN-LABEL "CC"
        wdetail.weight    COLUMN-LABEL "Weight"
        wdetail.seat      COLUMN-LABEL "Seat"
        wdetail.body      COLUMN-LABEL "Body"
        wdetail.vehreg    COLUMN-LABEL "Vehicle Register"
        wdetail.engno     COLUMN-LABEL "Engine NO."
        wdetail.chasno    COLUMN-LABEL "Chassis NO."
        wdetail.caryear   COLUMN-LABEL "Car Year" 
        wdetail.carprovi  COLUMN-LABEL "Car Province"
        wdetail.vehuse    COLUMN-LABEL "Vehicle Use" 
        wdetail.garage    COLUMN-LABEL "Garage"
        wdetail.stk       COLUMN-LABEL "Sticker"
        wdetail.covcod    COLUMN-LABEL "Cover Type"
        wdetail.si        COLUMN-LABEL "Sum Insure"
        wdetail.volprem   COLUMN-LABEL "Voluntory Prem"
        wdetail.Compprem  COLUMN-LABEL "Compulsory Prem"
        wdetail.fleet     COLUMN-LABEL "Fleet"
        wdetail.ncb       COLUMN-LABEL "NCB"
        wdetail.access    COLUMN-LABEL "Load Claim"
        wdetail.deductpp  COLUMN-LABEL "Deduct TP"
        wdetail.deductba  COLUMN-LABEL "Deduct DA"
        wdetail.deductpa  COLUMN-LABEL "Deduct PD"
        wdetail.benname   COLUMN-LABEL "Benefit Name" 
        wdetail.n_user    COLUMN-LABEL "User"
        wdetail.n_IMPORT  COLUMN-LABEL "Import"
        wdetail.n_export  COLUMN-LABEL "Export"
        wdetail.drivnam1  COLUMN-LABEL "Driver Name1"
        wdetail.drivnam   COLUMN-LABEL "Driver Name2"
        wdetail.drivbir1  COLUMN-LABEL "Driver Birth1"
        wdetail.producer  COLUMN-LABEL "Producer"
        wdetail.agent     COLUMN-LABEL "Agent"
        wdetail.comment   FORMAT "x(35)" COLUMN-BGCOLOR  80 COLUMN-LABEL "Comment"
        wdetail.cancel    COLUMN-LABEL "Cancel"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 4.52
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     tg_fileload AT ROW 2.71 COL 7.33 WIDGET-ID 16
     ra_typeload AT ROW 2.67 COL 29.17 NO-LABEL
     fi_loaddat AT ROW 3.76 COL 27 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 3.76 COL 52.33 COLON-ALIGNED NO-LABEL
     fi_campens AT ROW 3.76 COL 74.33 COLON-ALIGNED NO-LABEL
     fi_mocode AT ROW 3.76 COL 93.17 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.71 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_memotext AT ROW 4.71 COL 81.83 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.71 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6.71 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_vatcode AT ROW 7.71 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.95 COL 15.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_name2 AT ROW 7.71 COL 50.67 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 9.62 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 9.62 COL 59.17 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 10.62 COL 26.83 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 10.62 COL 89.5
     fi_output1 AT ROW 11.62 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 12.62 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 13.62 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 14.57 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 14.57 COL 65.17 NO-LABEL
     buok AT ROW 11.19 COL 98
     bu_exit AT ROW 13.05 COL 98
     fi_brndes AT ROW 4.71 COL 36.83 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 17.14 COL 2
     bu_hpbrn AT ROW 4.71 COL 34.5
     bu_hpacno1 AT ROW 5.71 COL 43.5
     bu_hpagent AT ROW 6.71 COL 43.5
     fi_proname AT ROW 5.71 COL 46 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6.71 COL 46 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 22.38 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 15.76 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.38 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.38 COL 97 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.43 COL 95 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_fileexp AT ROW 8.67 COL 26.83 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     buexp AT ROW 8.62 COL 88.83 WIDGET-ID 10
     "                      Branch :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 4.71 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 9.62 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 23.38 COL 94.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 14.57 COL 82.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 23.38 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.38 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 14.57 COL 27.5 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 12.62 COL 5.5
          BGCOLOR 18 FGCOLOR 1 
     "TieS 4 01/03/2022" VIEW-AS TEXT
          SIZE 23.5 BY .91 AT ROW 15.71 COL 96.83 WIDGET-ID 20
          BGCOLOR 29 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.67 BY 23.86
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 13.62 COL 5.5
          BGCOLOR 18 FGCOLOR 1 
     "      NO-MN30 : By Status Dealer" VIEW-AS TEXT
          SIZE 35 BY .91 AT ROW 9.62 COL 76.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.38 COL 57.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 10.62 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "               Agent Code :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 6.71 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Model :" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 3.76 COL 87
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "                 Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 3.76 COL 5.5
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .91 AT ROW 14.57 COL 63.67 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Format File Load :" VIEW-AS TEXT
          SIZE 18 BY .91 AT ROW 8.67 COL 10.5 WIDGET-ID 14
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 23.29 COL 57.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " IMPORT TEXT FILE MOTOR [TPIS] รถเล็ก LCV" VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.24 COL 2.5
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "F18:" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 4.71 COL 78.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "         Producer  Code :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 5.71 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .91 AT ROW 9.62 COL 59.66 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.95 COL 5.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 3.76 COL 43.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Paramerter new :" VIEW-AS TEXT
          SIZE 16.5 BY .91 AT ROW 3.76 COL 59.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Name 2 :" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 7.71 COL 43.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 22.38 COL 94.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "         Vat Code[TPIS] :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 7.71 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 11.62 COL 5.5
          BGCOLOR 18 FGCOLOR 1 
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.43 COL 1
     RECT-373 AT ROW 16.91 COL 1
     RECT-374 AT ROW 21.95 COL 1
     RECT-376 AT ROW 22.14 COL 4.17
     RECT-377 AT ROW 10.71 COL 96.5
     RECT-378 AT ROW 12.67 COL 96.5
     RECT-380 AT ROW 2.57 COL 5.5 WIDGET-ID 18
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.67 BY 23.86
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
         TITLE              = "LOAD TEXT FILE TPIS (NEW) TO GW"
         HEIGHT             = 23.86
         WIDTH              = 132.67
         MAX-HEIGHT         = 48.43
         MAX-WIDTH          = 320
         VIRTUAL-HEIGHT     = 48.43
         VIRTUAL-WIDTH      = 320
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
/* SETTINGS FOR RECTANGLE RECT-380 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.83 BY .91 AT ROW 9.62 COL 59.66 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "    Policy Import Total :"
          SIZE 23 BY .91 AT ROW 14.57 COL 27.5 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .91 AT ROW 14.57 COL 63.67 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.38 COL 57.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 22.38 COL 94.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 23.29 COL 57.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 23.38 COL 94.83 RIGHT-ALIGNED       */

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
ON END-ERROR OF C-Win /* LOAD TEXT FILE TPIS (NEW) TO GW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* LOAD TEXT FILE TPIS (NEW) TO GW */
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
        WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
        wdetail.redbook:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
        wdetail.poltyp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.tiname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.insnam:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.comdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.expdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.iadd1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.iadd2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.iadd3:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.iadd4:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.prempa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.subclass:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
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
        wdetail.benname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
        wdetail.n_user:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
        wdetail.n_IMPORT:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
        wdetail.n_export:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
        wdetail.drivnam1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
        wdetail.drivnam :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
        wdetail.drivbir1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.producer:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
        wdetail.agent:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                       
        wdetail.comment:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        WDETAIL.CANCEL:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
                                       
           /*new add*/                 


          /*wdetail.entdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.enttim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trandat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trantim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. *//*a490166*/ 
          WDETAIL.WARNING:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
          wdetail.redbook:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
          wdetail.poltyp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.tiname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.insnam:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.expdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.    
          wdetail.iadd1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd3:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd4:FGCOLOR IN BROWSE BR_WDETAIL = s  NO-ERROR.  
          wdetail.prempa:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.subclass:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
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
          wdetail.producer:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.agent:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comment:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          WDETAIL.CANCEL:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
            /*new add*/
            
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buexp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buexp C-Win
ON CHOOSE OF buexp IN FRAME fr_main /* Export file */
DO:
     IF fi_fileexp = " " THEN DO: 
            MESSAGE "Output file is Mandatory" VIEW-AS ALERT-BOX .
            APPLY "entry" TO fi_fileexp.
            RETURN NO-APPLY.
      END.
      ELSE DO:
          fi_fileexp = fi_fileexp + ".CSV" .
          OUTPUT STREAM ns2 TO value(fi_fileexp).
          PUT STREAM ns2
           " E-mail " SKIP.
          PUT STREAM ns2
              " Ins. Year type       "   "|"
              " Business type        "   "|"
              " TAS received by      "   "|"
              " Ins company          "   "|"
              " Insurance ref no.    "   "|"
              " TPIS Contract No.    "   "|"
              " Title name           "   "|"
              " customer name        "   "|"
              " customer lastname    "   "|"
              " Customer type        "   "|"
              " Director Name        "   "|"
              " ID number            "   "|"
              " House no.            "   "|"
              " Building             "   "|"
              " Village name/no.     "   "|"
              " Soi                  "   "|"
              " Road                 "   "|"
              " Sub-district         "   "|"
              " District             "   "|"
              " Province             "   "|"
              " Postcode             "   "|"
              " Brand                "   "|"
              " Car model            "   "|"
              " Insurance Code       "   "|"
              " Model Year           "   "|"
              " Usage Type           "   "|"
              " Colour               "   "|"
              " Car Weight (CC.)     "   "|"
              " Year                 "   "|"
              " Engine No.           "   "|"
              " Chassis No.          "   "|"
              " Accessories (for CV) "   "|"
              " Accessories amount   "   "|"
              " License No.          "   "|"
              " Registered Car License"  "|"
              " Campaign        "        "|"
              " Type of work    "        "|"
              " Insurance amount"        "|"
              " Insurance Date ( Voluntary) "  "|"
              " Expiry Date ( Voluntary)    "  "|"
              " Last Policy No. (Voluntary) "  "|"
              " Insurance Type              "  "|"
              " Net premium (Voluntary)     "  "|"
              " Gross premium (Voluntary)   "  "|"
              " Stamp                       "  "|"
              " VAT                         "  "|"
              " WHT                         "  "|"
              " Compulsory No.              "  "|"
              " Insurance Date ( Compulsory) " "|"
              " Expiry Date ( Compulsory)   "  "|"
              " Net premium (Compulsory)    "  "|"
              " Gross premium (Compulsory)  "  "|"
              " Stamp                       "  "|"
              " VAT                         "  "|"
              " WHT                         "  "|"
              " Dealer                      "  "|"
              " Showroom                    "  "|"
              " Payment Type                "  "|"
              " Beneficiery                 "  "|"
              " Mailing House no.           "  "|"
              " Mailing  Building           "  "|"
              " Mailing  Village name/no.   "  "|"
              " Mailing Soi                 "  "|"
              " Mailing  Road               "  "|"
              " Mailing  Sub-district       "  "|"
              " Mailing  District           "  "|"
              " Mailing Province            "  "|"
              " Mailing Postcode            "  "|"
              " Policy no. to customer date "  "|"
              " New policy no               "  "|"
              " Insurer Stamp Date          "  "|"
              " Remark                      "  "|"
              " Occupation code             "  "|"
              " Memo      "                    "|"   
              " regis_no "                     "|"            
              " Prom.(claimdi)  "              "|"  /*A63-0209*/  
              " Product   "                    "|"  /*A63-0209*/ 
              " Campaign OV   "                "|"  /*Add by Kridtiya i. A63-0472*/
              SKIP.

          OUTPUT STREAM ns2 CLOSE.                                                       
      END.
      MESSAGE "Export File complete " VIEW-AS ALERT-BOX.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    IF ra_typeload = 1 THEN DO:  /*  Load GW*/
        ASSIGN
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2
            fi_completecnt         = 0
            fi_premsuc             = 0
            fi_bchno               = ""
            fi_premtot             = 0
            fi_impcnt              = 0
            fi_process  = "Import data TPIS.......[ISUZU]" .   /*a55-0051*/ 
        DISP fi_process  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
        IF fi_branch = " " THEN DO: 
            MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
            APPLY "entry" TO fi_branch.
            RETURN NO-APPLY.
        END.
        /*IF fi_producer = " " THEN DO:
            MESSAGE "Producer code is Mandatory" VIEW-AS ALERT-BOX .
            APPLY "entry" TO fi_producer.
            RETURN NO-APPLY.
        END.
        IF fi_agent = " " THEN DO:
            MESSAGE "Agent code is Mandatory" VIEW-AS ALERT-BOX .
            APPLY "entry" TO fi_Agent.
            RETURN NO-APPLY.
        END.*/
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
        ASSIGN
            fi_output1 = INPUT fi_output1
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
            FIND LAST uzm700 USE-INDEX uzm70001
                WHERE uzm700.bchyr   = nv_batchyr        AND
                uzm700.branch  = TRIM(nv_batbrn)   AND
                uzm700.acno    = TRIM(fi_producer) NO-LOCK NO-ERROR .
            IF AVAIL uzm700 THEN DO:   
                nv_batrunno = uzm700.runno.
                FIND LAST uzm701 USE-INDEX uzm70102 
                    WHERE uzm701.bchyr = nv_batchyr        AND
                          uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999")  NO-LOCK NO-ERROR.
                IF AVAIL uzm701 THEN DO:
                    nv_batcnt = uzm701.bchcnt .
                    nv_batrunno = nv_batrunno + 1.
                END.
            END.
            ELSE DO:  
                ASSIGN
                    nv_batcnt = 1
                    nv_batrunno = 1.
            END.
            nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
        END.
        ELSE DO:  
            nv_batprev = INPUT fi_prevbat.
            FIND LAST uzm701 USE-INDEX uzm70102 
                WHERE uzm701.bchyr = nv_batchyr        AND
                      uzm701.bchno = CAPS(nv_batprev)  NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL uzm701 THEN DO:
                MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev)
                    + " on file uzm701" .
                APPLY "entry" TO fi_prevbat.
                RETURN NO-APPLY.
            END.
            IF AVAIL uzm701 THEN DO:
                nv_batcnt  = uzm701.bchcnt + 1.
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
        END.
        For each  wdetail2 :
            DELETE  wdetail2.
        END.
        FOR EACH wno30txt.
            DELETE wno30txt.
        END.
        IF tg_fileload = YES THEN RUN proc_assignnew . /* A62-0422*/
        ELSE RUN proc_assign.  
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
                ASSIGN
                    nv_reccnt      =  nv_reccnt   + 1
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
        /* comment by : ranu I. a64-0344...
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
        ..end A64-0344...*/
        RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                               INPUT            nv_batchyr ,     /* INT   */
                               INPUT            fi_producer,     /* CHAR  */ 
                               INPUT            nv_batbrn  ,     /* CHAR  */
                               INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                               INPUT            "WGWNTPIS" ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                               INPUT            nv_imppol  ,     /* INT   */
                               INPUT            nv_impprem       /* DECI  */
                               ).
        ASSIGN
            fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
        DISP  fi_bchno   WITH FRAME fr_main.
        RUN proc_chktest1.
        FOR EACH wdetail WHERE wdetail.pass = "y"  :
            ASSIGN
                nv_completecnt = nv_completecnt + 1
                nv_netprm_s    = nv_netprm_s    + decimal(wdetail.volprem) . 
        END.
        nv_rectot = nv_reccnt.      
        nv_recsuc = nv_completecnt. 
        IF /*nv_imppol <> nv_rectot OR  nv_imppol <> nv_recsuc OR*/
            nv_rectot <> nv_recsuc   THEN DO:
            nv_batflg = NO.
            /*MESSAGE "Policy import record is not match to Total record !!!" VIEW-AS ALERT-BOX.*/
        END.
        ELSE IF /*nv_impprem  <> nv_netprm_t OR nv_impprem  <> nv_netprm_s OR*/
            nv_netprm_t <> nv_netprm_s THEN DO:
            nv_batflg = NO.
            /*MESSAGE "Total net premium is not match to Total net premium !!!" VIEW-AS ALERT-BOX.*/
        END.
        ELSE nv_batflg = YES.
        FIND LAST uzm701 USE-INDEX uzm70102  WHERE 
            uzm701.bchyr   = nv_batchyr  AND
            uzm701.bchno   = nv_batchno  AND
            uzm701.bchcnt  = nv_batcnt   NO-ERROR.
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
        /*add a55-0051*/
        RELEASE uzm700.
        RELEASE uzm701.
        RELEASE sic_bran.uwm100.
        RELEASE sic_bran.uwm120.
        RELEASE sic_bran.uwm130.
        RELEASE sic_bran.uwm301.
        RELEASE sic_bran.uwd132.
        RELEASE brstat.detaitem.
        RELEASE brstat.insure.
        RELEASE sicsyac.xtm600.
        RELEASE sicsyac.xmm600.
        RELEASE sicsyac.xzm056.
        RELEASE sicsyac.sym100.
        RELEASE sicsyac.xmd031.
        RELEASE sicsyac.xmm016.
        RELEASE sicsyac.xmm104.
        RELEASE sicsyac.xmm031.
        RELEASE sicsyac.xmm020.
        RELEASE sicsyac.xmm018.
        RELEASE sicuw.uwm100. 
        RELEASE sicuw.uwm130. 
        RELEASE sicuw.uwm301.
        RELEASE stat.maktab_fil.
        RELEASE stat.makdes31.
        RELEASE stat.insure.
        IF nv_batflg = NO THEN DO:  
            ASSIGN
                fi_completecnt:FGCOLOR = 6
                fi_premsuc    :FGCOLOR = 6 
                fi_bchno    :FGCOLOR = 6 
                fi_process  = "Data Error............ TPIS.......[ISUZU]" .  /*a55-0051*/
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
                fi_completecnt:FGCOLOR = 2
                fi_premsuc:FGCOLOR     = 2 
                fi_bchno:FGCOLOR       = 2
                fi_process  = "Process Data compleate TPIS.......[ISUZU]" .  /*a55-0051*/
            DISP  fi_process WITH FRAM fr_main.
            MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
        END.
        RUN   proc_open.
        ASSIGN fi_process = "Load Text file TPIS.......[ISUZU]" . 
        /*end add... a55-0051*/
        DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
        /*output*/
        RUN proc_report1 .   
        RUN PROC_REPORT2 .
        RUN proc_screen  .  
    END.
    ELSE RUN proc_matchfilechk .  /*match file chkerr, match file policy no.,match file receipt */
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
    /*DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/*/

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
         
         IF ra_typeload = 1 THEN /*load */
             ASSIGN
             fi_filename  = cvData
             fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
             fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
             fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
         ELSE IF ra_typeload = 2 THEN /*Match pol HO*/
             ASSIGN
                  fi_filename  = cvData
                  fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add +  "_matpol.csv" /*.csv*/
                  fi_output2 = ""
                  fi_output3 = "".
         ELSE IF ra_typeload = 3 THEN /*match receipt */
             ASSIGN
                  fi_filename  = cvData
                  fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add +  "_matrep.csv" /*.csv*/
                  fi_output2 = ""
                  fi_output3 = "".
         ELSE IF ra_typeload = 4 THEN /*Match pol send to tpis*/
           ASSIGN
                fi_filename  = cvData
                fi_output1 = SUBSTRING(cvData,1,R-INDEX(cvdata,"\")) + "INFORM_FIRST_SAFE_xx.csv" /*.csv*/
                fi_output2 = SUBSTRING(cvData,1,R-INDEX(cvdata,"\")) + "Send_TPIS_NEW" + no_add + ".slk"
                fi_output3 = "".
         
         DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
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
        END.  /*end note 10/11/2005*/
    END.  /* Then fi_agent <> ""*/
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


&Scoped-define SELF-NAME fi_campens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campens C-Win
ON LEAVE OF fi_campens IN FRAME fr_main
DO:
    fi_campens  =  Input fi_campens.
    Disp  fi_campens  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_fileexp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_fileexp C-Win
ON LEAVE OF fi_fileexp IN FRAME fr_main
DO:
    fi_fileexp = INPUT fi_fileexp.
    DISP fi_fileexp WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_memotext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_memotext C-Win
ON LEAVE OF fi_memotext IN FRAME fr_main
DO:
    fi_memotext  =  Input fi_memotext.
    Disp  fi_memotext  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_mocode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_mocode C-Win
ON LEAVE OF fi_mocode IN FRAME fr_main
DO:
    fi_mocode  =  Input fi_mocode.
    Disp  fi_mocode  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name2 C-Win
ON LEAVE OF fi_name2 IN FRAME fr_main
DO:
    fi_name2 = INPUT fi_name2.
    Disp  fi_name2   WITH Frame  fr_main.                 
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
    /*IF nv_batprev <> " "  THEN DO:
        IF LENGTH(nv_batprev) <> 13 THEN DO:
             MESSAGE "Length Of Batch no. Must Be 13 Character " SKIP
                     "Please Check Batch No. Again             " view-as alert-box.
             APPLY "entry" TO fi_prevbat.
             RETURN NO-APPLY.
        END.
    END. /*nv_batprev <> " "*/*/
    
    DISPLAY fi_prevbat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer.
    IF  fi_producer <> " " THEN DO:
        IF fi_producer = "B3M0031" THEN DO:
            ASSIGN fi_memotext = ""
                   fi_name2    = "" 
                   fi_vatcode  = "" .
            Disp fi_memotext  fi_name2 fi_vatcode  WITH Frame  fr_main. 
        END.
        IF  fi_producer = "B3M0018" THEN DO:
            ASSIGN fi_memotext = ""
                fi_name2    = "" 
                fi_memotext = "TPIS Topping Interest Rate"
                fi_vatcode  = "MC21364"
                fi_name2    = "และ/หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด" . 
        END.
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
  Disp  fi_producer  fi_proname fi_memotext  fi_name2 fi_vatcode WITH Frame  fr_main. 
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


&Scoped-define SELF-NAME fi_vatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcode C-Win
ON LEAVE OF fi_vatcode IN FRAME fr_main
DO:  
    fi_vatcode = INPUT fi_vatcode.
    IF fi_vatcode <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_vatcode  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_vatcode.
            RETURN NO-APPLY.  
        END.
        ELSE DO:  
            ASSIGN
                fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_vatcode =  caps(INPUT  fi_vatcode)  
                nv_agent   =  fi_vatcode.                
        END.  
    END.  
    Disp  fi_vatcode    WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typeload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typeload C-Win
ON VALUE-CHANGED OF ra_typeload IN FRAME fr_main
DO:
    ra_typeload = INPUT ra_typeload .
    no_add      = STRING(MONTH(TODAY),"99")    + 
        STRING(DAY(TODAY),"99")      + 
        SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
        SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
    IF fi_filename = "" THEN DO:
        APPLY "Entry" TO fi_filename.
         RETURN NO-APPLY.
    END.
    ELSE DO:
        IF ra_typeload = 1 THEN /*load */
            ASSIGN
            fi_filename  = cvData
            fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
            fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
            fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
        ELSE IF ra_typeload = 2 THEN /*Match pol HO*/
            ASSIGN
                 fi_filename  = cvData
                 fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add +  "_matpol.csv" /*.csv*/
                 fi_output2 = ""
                 fi_output3 = "".
        ELSE IF ra_typeload = 3 THEN /*match receipt */
            ASSIGN
                 fi_filename  = cvData
                 fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add +  "_matrep.csv" /*.csv*/
                 fi_output2 = ""
                 fi_output3 = "".
        ELSE IF ra_typeload = 4 THEN /*Match pol send to tpis*/
          ASSIGN
               fi_filename  = cvData
               fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add +  "_sendtpis.csv" /*.csv*/
               fi_output2 = ""
               fi_output3 = "".

         DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.
    DISP ra_typeload WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tg_fileload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tg_fileload C-Win
ON VALUE-CHANGED OF tg_fileload IN FRAME fr_main /* ไฟล์แจ้งงานใหม่ */
DO:
    tg_fileload = INPUT tg_fileload .
    DISP tg_fileload WITH FRAME fr_main.
  
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
  
  gv_prgid = "Wgwntpis".
  gv_prog  = "Load Text & Generate TPIS NEW".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
     /* ra_compatyp = 2*/
      tg_fileload = NO   /*A62-0422*/
      ra_typeload = 1
      /*fi_pack     = "V"*/ /*A65-0156*/
      fi_pack     = "T"  /*A65-0156*/
      fi_branch   = "M"
      fi_mocode   = "Model"        /*add Kridtiya i. A55-0107*/
      
      /*fi_vatcode  = ""*/ /*A57-0415*/
      fi_vatcode  = "MC21364"   /*A57-0415*/
      fi_memotext = ""
      fi_name2    = "และ/หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด" 
      fi_campens  = "TPIS"      
      fi_producer = "B3M0018"
      fi_agent    = "B3M0018"
      fi_memotext = "TPIS Topping Interest Rate"
      fi_bchyr    = YEAR(TODAY)
      fi_process  = "Load Text file TPIS.......[ISUZU]" .  /*a55-0051*/
  /*A58-0092*/
 /* FIND FIRST brstat.insure USE-INDEX insure01      WHERE 
      index(brstat.insure.compno,"TPIB_C") <> 0    AND  
      insure.ICAddr2 =  fi_producer   NO-LOCK  NO-WAIT NO-ERROR.
  IF AVAIL brstat.insure  THEN  
      ASSIGN fi_campens = trim(substr(brstat.insure.compno,6))  .*/
  /*A58-0092*/
  DISP fi_mocode  ra_typeload /*ra_compatyp*/ fi_pack  fi_branch   fi_campens fi_producer fi_agent 
       fi_process fi_vatcode  fi_name2    fi_bchyr fi_memotext tg_fileload    WITH FRAME fr_main.
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_adduwd132cam C-Win 
PROCEDURE 00-proc_adduwd132cam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0344  ไม่มีการเรียกใช้งาน ....
DEF VAR nv_campaign AS CHAR FORMAT "x(20)" INIT "" . /*A62-0493*/

DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
   
    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0
           nv_campaign = ""  .
                         
     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              stat.pmuwd132.campcd        = wdetail.campens           AND  
              TRIM(stat.pmuwd132.policy)  = TRIM(nv_polmaster)     NO-LOCK.

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
             sic_bran.uwd132.bencod  = stat.pmuwd132.bencod      NO-ERROR NO-WAIT.
   
            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.

               ASSIGN fi_process = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
               DISP fi_process WITH FRAM fr_main. 
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
              
               IF sic_bran.uwd132.bencod = "SI"  THEN ASSIGN sic_bran.uwd132.benvar = nv_sivar .
               IF sic_bran.uwd132.bencod = "BI1" THEN ASSIGN sic_bran.uwd132.benvar = nv_bipvar.
               IF sic_bran.uwd132.bencod = "BI2" THEN ASSIGN sic_bran.uwd132.benvar = nv_biavar.
               IF sic_bran.uwd132.bencod = "PD"  THEN ASSIGN sic_bran.uwd132.benvar = nv_pdavar.
               IF sic_bran.uwd132.bencod = "411" THEN ASSIGN sic_bran.uwd132.benvar = nv_411var.
               IF sic_bran.uwd132.bencod = "412" THEN ASSIGN sic_bran.uwd132.benvar = nv_412var.
               IF sic_bran.uwd132.bencod = "42"  THEN ASSIGN sic_bran.uwd132.benvar = nv_42var .
               IF sic_bran.uwd132.bencod = "43"  THEN ASSIGN sic_bran.uwd132.benvar = nv_43var .
               IF sic_bran.uwd132.bencod = "dspc" THEN ASSIGN nv_dss_per  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
               IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
               
               If nv_ncbper  <> 0 Then do:
                   Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                       sicsyac.xmm104.tariff = nv_tariff           AND
                       sicsyac.xmm104.class  = nv_class            AND 
                       sicsyac.xmm104.covcod = nv_covcod           AND 
                       sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
                   IF not avail  sicsyac.xmm104  Then do:
                       /*Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.*/
                       ASSIGN 
                           wdetail.pass    = "N"
                           wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
                   END.
                   ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                               nv_ncbyrs = xmm104.ncbyrs.
               END.
               Else do:  
                   ASSIGN nv_ncbyrs =   0
                       nv_ncbper    =   0
                       nv_ncb       =   0.
               END.
               ASSIGN   
                sic_bran.uwm301.ncbper   = nv_ncbper
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs .

               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).

            END.
        END.

    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.

END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_adduwd132camplus C-Win 
PROCEDURE 00-proc_adduwd132camplus :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0344  ไม่มีการเรียกใช้งาน ....
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
   
    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0.

     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              stat.pmuwd132.campcd        = wdetail.campens       AND
              TRIM(stat.pmuwd132.policy)  = TRIM(nv_polmaster)  NO-LOCK.
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
             sic_bran.uwd132.bencod  = stat.pmuwd132.bencod      NO-ERROR NO-WAIT.
   
            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.

               ASSIGN fi_process = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
               DISP fi_process WITH FRAM fr_main. 
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
              
               IF sic_bran.uwd132.bencod = "SI"  THEN ASSIGN sic_bran.uwd132.benvar = nv_sivar .
               IF sic_bran.uwd132.bencod = "BI1" THEN ASSIGN sic_bran.uwd132.benvar = nv_bipvar.
               IF sic_bran.uwd132.bencod = "BI2" THEN ASSIGN sic_bran.uwd132.benvar = nv_biavar.
               IF sic_bran.uwd132.bencod = "PD"  THEN ASSIGN sic_bran.uwd132.benvar = nv_pdavar.
               IF sic_bran.uwd132.bencod = "411" THEN ASSIGN sic_bran.uwd132.benvar = nv_411var.
               IF sic_bran.uwd132.bencod = "412" THEN ASSIGN sic_bran.uwd132.benvar = nv_412var.
               IF sic_bran.uwd132.bencod = "42"  THEN ASSIGN sic_bran.uwd132.benvar = nv_42var .
               IF sic_bran.uwd132.bencod = "43"  THEN ASSIGN sic_bran.uwd132.benvar = nv_43var .
               IF sic_bran.uwd132.bencod = "dspc" THEN ASSIGN nv_dss_per  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
               IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
               
               If nv_ncbper  <> 0 Then do:
                   Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                       sicsyac.xmm104.tariff = nv_tariff           AND
                       sicsyac.xmm104.class  = nv_class            AND 
                       sicsyac.xmm104.covcod = nv_covcod           AND 
                       sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
                   IF not avail  sicsyac.xmm104  Then do:
                       /*Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.*/
                       ASSIGN 
                           wdetail.pass    = "N"
                           wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
                   END.
                   ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                               nv_ncbyrs = xmm104.ncbyrs.
               END.
               Else do:  
                   ASSIGN nv_ncbyrs =   0
                       nv_ncbper    =   0
                       nv_ncb       =   0.
               END.
               ASSIGN   
                sic_bran.uwm301.ncbper   = nv_ncbper
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs .

               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).

            END.
        END.

    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assign3 C-Win 
PROCEDURE 00-proc_assign3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: comment by A66-0252      
------------------------------------------------------------------------------*/
/*DEFINE VAR n_len_c AS INTE INIT 0.                   /*kridtiya i. A53-0317...*/
DEFINE VAR n_cha_no AS CHAR FORMAT "x(25)" INIT "".  /*kridtiya i. A53-0317...*/
DEF VAR np_70 AS CHAR FORMAT "x(15)" INIT "".       /*A58-0489*/
DEF VAR np_72 AS CHAR FORMAT "x(15)" INIT "".       /*A58-0489*/
ASSIGN fi_process  = "Create data to wdetail TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
FOR EACH wdetail2 .
  ASSIGN np_70 = ""   np_72 = ""  .     
  IF wdetail2.typ_work = "V"      THEN ASSIGN np_70 =  "V" + wdetail2.tpis_no      np_72 =  "" .
  ELSE IF wdetail2.typ_work = "C" THEN ASSIGN np_72 =  "C" + wdetail2.tpis_no      np_70 =  "" .
  ELSE IF wdetail2.typ_work = "V+C"   THEN ASSIGN np_70 =  "V" + wdetail2.tpis_no  np_72 =  "C" + wdetail2.tpis_no.
  ELSE ASSIGN np_70 =  ""   np_72 =  "" .
  ASSIGN n_rev = LENGTH(fi_filename)
    n_revday = SUBSTR(fi_filename,R-INDEX(fi_filename,"\"),n_rev).
  IF INDEX(n_revday,".csv") <> 0 THEN n_revday = trim(REPLACE(n_revday,".csv","")).
  IF INDEX(n_revday,"\") <> 0    THEN n_revday = trim(REPLACE(n_revday,"\","")).
  IF (R-INDEX(TRIM(n_titlenam),"จก.")          <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"จำกัด")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (R-INDEX(TRIM(n_titlenam),"(มหาชน)") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (R-INDEX(TRIM(n_titlenam),"INC.")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"CO.")     <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"LTD.")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"LIMITED") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"บริษัท")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"บ.")        <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"บจก.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (INDEX(TRIM(n_titlenam),"หจก.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"หสน.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (INDEX(TRIM(n_titlenam),"บรรษัท")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (INDEX(TRIM(n_titlenam),"มูลนิธิ")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้าง")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วน")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วนจำกัด") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วนจำก")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".   
  ELSE IF (INDEX(TRIM(n_titlenam),"และ/หรือ")          <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno        = "999" AND
      trim(brstat.msgcode.MsgDesc) = trim(wdetail2.ntitle)   NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL brstat.msgcode THEN ASSIGN wdetail2.ntitle  =  trim(brstat.msgcode.branch).
  ELSE DO:
      IF wdetail2.ntitle = ""  THEN ASSIGN wdetail2.ntitle = "คุณ" .
      ELSE ASSIGN  wdetail2.ntitle = TRIM(wdetail2.ntitle) .
  END.
  wdetail2.icno = TRIM(wdetail2.icno) .  
  IF trim(wdetail2.cust_type) = "J"  AND LENGTH(wdetail2.icno) < 13 THEN ASSIGN wdetail2.icno = "0" + TRIM(wdetail2.icno) . /*A61-0152*/
  IF np_70 <> "" THEN DO:
      FIND FIRST wdetail WHERE wdetail.policy = np_70 NO-ERROR NO-WAIT.
      IF NOT AVAIL wdetail THEN DO:
          CREATE wdetail.
          CREATE wuppertxt2. 
          ASSIGN                 /*policy line : 70       */
            n_len_c             = 0   /*kridtiya i. A53-0317...*/
            n_cha_no            = ""  /*kridtiya i. A53-0317...*/
            n_len_c             = length(trim(wdetail2.chasno))  /*kridtiya i. A53-0317...*/
            wdetail.seat        = IF wdetail2.class = "110" THEN "7" ELSE IF wdetail2.class = "210" THEN "5" ELSE "3"    /*IF TRIM(wdetail2.Usage) = "เก๋ง" THEN "7" ELSE "5"*/
            wdetail.seat41      = int(wdetail.seat)  /*A65-0156*/
            wdetail.brand       = TRIM(wdetail2.brand)
            /*wdetail.caryear     = TRIM(wdetail2.md_year)  */  /*ปีรถ*/   /*A66-0252*/
            wdetail.caryear     = TRIM(wdetail2.regis_year)    /*ปีรถ*/    /*A66-0252*/
            wdetail.poltyp      = "70"
            wdetail.policy      = np_70 
            wdetail.comdat      = TRIM(wdetail2.pol_comm_date) 
            wdetail.expdat      = TRIM(wdetail2.pol_exp_date)  
            wdetail.tiname      = trim(wdetail2.ntitle)                                
            wdetail.insnam      = trim(wdetail2.insnam)  + " " + TRIM(wdetail2.NAME2) 
            wdetail.insnamtyp   = trim(wdetail2.insnamtyp)     /*Add by Kridtiya i. A63-0472*/
            wdetail.firstName   = trim(wdetail2.firstName)     /*Add by Kridtiya i. A63-0472*/
            wdetail.lastName    = trim(wdetail2.lastName)      /*Add by Kridtiya i. A63-0472*/
            wdetail.postcd      = trim(wdetail2.mail_post)     /*Add by Kridtiya i. A63-0472*/
            wdetail.codeocc     = trim(wdetail2.codeocc)       /*Add by Kridtiya i. A63-0472*/
            wdetail.codeaddr1   = trim(wdetail2.codeaddr1)     /*Add by Kridtiya i. A63-0472*/
            wdetail.codeaddr2   = trim(wdetail2.codeaddr2)     /*Add by Kridtiya i. A63-0472*/
            wdetail.codeaddr3   = trim(wdetail2.codeaddr3)     /*Add by Kridtiya i. A63-0472*/
            wdetail.br_insured  = "00000"                      /*Add by Kridtiya i. A63-0472*/
            wdetail.campaign_ov = trim(wdetail2.campaign_ov)   /*Add by Kridtiya i. A63-0472*/
            wdetail.ICNO        = trim(wdetail2.ICNO)          /*A56-0211*/
            wdetail.name2       = wdetail2.dealer_name2 
            wdetail.iadd1       = wdetail2.mail_hno 
            wdetail.iadd2       = wdetail2.mail_tambon 
            wdetail.iadd3       = wdetail2.mail_amper  
            wdetail.iadd4       = wdetail2.mail_country 
            /*Add by Kridtiya i. A63-0472*/
            /*wdetail.subclass    = TRIM(wdetail2.class)           */ /*A66-0252*/
            /*wdetail.prempa      = wdetail2.prempa   /*A61-0152*/ */ /*A66-0252*/
            wdetail.subclass    = if length(wdetail2.class) > 3 THEN TRIM(substr(wdetail2.CLASS,2,3)) ELSE TRIM(wdetail2.CLASS)    /*A66-0252*/
            wdetail.prempa      = if length(wdetail2.class) > 3 THEN TRIM(substr(wdetail2.CLASS,1,1)) ELSE TRIM(wdetail2.prempa)   /*A66-0252*/
            wdetail.body        = ""  /*TRIM(wdetail2.vehuse)*/     /*A58-0489*/
            wdetail.model       = TRIM(wdetail2.model) 
            wdetail.cc          = TRIM(wdetail2.cc)
            wdetail.ton         = TRIM(wdetail2.ton) /*A61-0152*/
            wdetail.weight      = IF wdetail2.class = "320" THEN TRIM(wdetail2.cc) ELSE TRIM(wdetail2.ton)
            wdetail.chasno      = trim(wdetail2.chasno) 
            wdetail.vehreg      = IF LENGTH(wdetail2.chasno)  > 8 THEN "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 ) 
                                  ELSE "/" + trim(wdetail2.chasno)  /*A56-0245*/
            /*wdetail.engno       = substr(wdetail2.engno,1,2) + " " + substr(wdetail2.engno,3,LENGTH(wdetail2.engno))*/ /*A58-0489*/
            wdetail.engno       = TRIM(wdetail2.engno)  /*A58-0489*/
            /*wdetail.vehuse      = "1"*/ /*A65-0156*/
            wdetail.vehuse      = IF wdetail2.class = "320" THEN "2" ELSE "1" /*A65-0156*/
            wdetail.cargrp      = "3"   /*A61-0152*/
            /*wdetail.garage      = "G"   */ /*a62-0422 */
            wdetail.garage      = IF wdetail2.garage = "" THEN "G" ELSE IF index(wdetail2.garage,"ห้าง") <> 0 THEN "G" 
                                  ELSE IF index(wdetail2.garage,"อะไหล่แท้") <> 0 THEN "P" ELSE ""  /*a62-0422 */
            wdetail.accdata     = TRIM(Wdetail2.Acc_CV)      
            wdetail.accamount   = TRIM(Wdetail2.Acc_amount)  
            wdetail.stk         = trim(wdetail2.com_no)
            wdetail.covcod      = TRIM(wdetail2.cover)
            wdetail.si          = TRIM(wdetail2.si)
            wdetail.branch      = wdetail2.branch 
            wdetail.benname     = wdetail2.financename
            wdetail.volprem     = trim(wdetail2.pol_netprem)
            wdetail.comment     = ""
            wdetail.finint      = wdetail2.delerco
            wdetail.financecd   = wdetail2.financecd       /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
            wdetail.agent       = wdetail2.agent     
            wdetail.producer    = wdetail2.producer 
            wdetail.entdat      = string(TODAY)      /*entry date*/
            wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
            wdetail.trandat     = STRING (TODAY)     /*tran date*/
            wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
            wdetail.n_IMPORT    = "IM"
            wdetail.n_EXPORT    = "" 
            wdetail.inscod      = TRIM(wdetail2.typepay)    /*add Kridtiya i. A53-0183 ...vatcode*/
            wdetail.cedpol      = TRIM(wdetail2.tpis_no)    /*A58-0489*/
            wdetail.remark1     = TRIM(wdetail2.remark1)           /*A58-0489*/
            wdetail.occupn      = TRIM(wdetail2.occup)           /*A58-0489*/
            wdetail.revday      = TRIM(n_revday) 
            wdetail.memo        = TRIM(wdetail2.np_f18line1) /*A61-0152*/
            wdetail.campens     = TRIM(wdetail2.campens)   /*A61-0152*/
            /*wdetail.campens     = IF INDEX(wdetail2.campens,"/") <> 0 THEN TRIM(REPLACE(wdetail2.campens,"/","_")) ELSE TRIM(wdetail2.campens) /*A61-0152*/ */ /*A65-0156*/ 
            wdetail.memotext    = TRIM(wdetail2.memotext)
            wdetail.vatcode     = TRIM(wdetail2.vatcode)
            wdetail.name02      = TRIM(wdetail2.name02)
            wdetail.baseprem    = DECI(wdetail2.baseprm)
            wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE "" 
            wdetail.promotion   = IF wdetail2.producer = "B3M0018" OR wdetail2.producer = "B3M0031" THEN wdetail2.claimdi ELSE ""   /*A63-0209*/
            wdetail.product     = IF wdetail2.producer = "B3M0018" OR wdetail2.producer = "B3M0031" THEN wdetail2.product ELSE ""   /*A63-0209*/
            wdetail.colors      = wdetail2.coulor  /*A66-0252*/
            wdetail.memo2       = if wdetail2.np_f18line3 <> "" then wdetail2.np_f18line3 else nv_memo1  /*A66-0252*/
            wdetail.memo3       = if wdetail2.np_f18line4 <> "" then wdetail2.np_f18line4 else nv_memo2  /*A66-0252*/
            wdetail.memo4       = if wdetail2.np_f18line5 <> "" then wdetail2.np_f18line5 else nv_memo3 . /*A66-0252*/ 
          IF wdetail.occup <> "" THEN DO:
            FIND FIRST stat.msgcode USE-INDEX MsgCode01 WHERE stat.msgcode.CompNo = "999" AND 
                stat.msgcode.MsgNo  = wdetail.occupn NO-LOCK NO-ERROR.
            IF AVAIL stat.msgcode THEN
                ASSIGN wdetail.occupn = stat.msgcode.MsgDesc.
            ELSE ASSIGN wdetail.occupn = "".
          END.
          IF trim(wdetail2.chasno) <> "" AND INDEX(wdetail2.typ_work,"V") <> 0 THEN DO:  
            FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail2.chasno)) AND 
              sicuw.uwm301.tariff = "X" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                ASSIGN  wdetail.WARNING  = "มีกรมธรรม์ในระบบแล้ว "  
                    wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เคยมีการออกงานแล้ว " + sicuw.uwm301.policy
                    wdetail.pass     = "Y".
            END.
          END.
      END.
  END.
  IF np_72 <> "" THEN DO:           
    FIND FIRST wdetail WHERE wdetail.policy = np_72 NO-ERROR NO-WAIT.
    IF NOT AVAIL wdetail THEN DO:
      CREATE wdetail.
      CREATE wuppertxt2.
      ASSIGN
        n_len_c             = 0   /*kridtiya i. A53-0317...*/
        n_cha_no            = ""  /*kridtiya i. A53-0317...*/
        n_len_c             = length(trim(wdetail2.chasno))  /*kridtiya i. A53-0317...*/
        wdetail.seat        = IF wdetail2.class = "110" THEN "7" ELSE IF wdetail2.class = "210" THEN "5" ELSE "3"  /*IF wdetail2.vehuse = "เก๋ง" THEN "7" ELSE "5"*/
        wdetail.seat41      = INT(wdetail.seat)  /*A65-0156*/
        wdetail.brand       = TRIM(wdetail2.brand)
        /*wdetail.caryear     = TRIM(wdetail2.md_year)  */  /*ปีรถ*/   /*A66-0252*/
        wdetail.caryear     = TRIM(wdetail2.regis_year)    /*ปีรถ*/    /*A66-0252*/
        wdetail.poltyp      = "72"   
        wdetail.policy      = np_72
        wuppertxt2.policydup = np_72
        wdetail.comdat      = TRIM(wdetail2.com_comm_date)     
        wdetail.expdat      = TRIM(wdetail2.com_exp_date)   
        wdetail.tiname      = trim(wdetail2.ntitle)       /*A57-0159*/
        wdetail.insnam      = trim(wdetail2.insnam)  + " " + trim(wdetail2.NAME2)  /*A54-0200*/
        wdetail.insnamtyp   = trim(wdetail2.insnamtyp)     /*Add by Kridtiya i. A63-0472*/
        wdetail.firstName   = trim(wdetail2.firstName)     /*Add by Kridtiya i. A63-0472*/
        wdetail.lastName    = trim(wdetail2.lastName)      /*Add by Kridtiya i. A63-0472*/
        wdetail.postcd      = trim(wdetail2.mail_post)     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeocc     = trim(wdetail2.codeocc)       /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr1   = trim(wdetail2.codeaddr1)     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr2   = trim(wdetail2.codeaddr2)     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr3   = trim(wdetail2.codeaddr3)     /*Add by Kridtiya i. A63-0472*/
        wdetail.br_insured  = "00000"                      /*Add by Kridtiya i. A63-0472*/
        wdetail.campaign_ov = trim(wdetail2.campaign_ov)   /*Add by Kridtiya i. A63-0472*/
        wdetail.ICNO        = TRIM(wdetail2.ICNO)         /*A56-0211*/
        wdetail.name2       = wdetail2.dealer_name2 
        wdetail.iadd1       = wdetail2.mail_hno 
        wdetail.iadd2       = wdetail2.mail_tambon 
        wdetail.iadd3       = wdetail2.mail_amper  
        wdetail.iadd4       = wdetail2.mail_country 
        /*wdetail.subclass    = TRIM(wdetail2.class)*/
        wdetail.subclass    = IF deci(wdetail2.com_netprem) = 600 THEN "110" ELSE IF deci(wdetail2.com_netprem) = 900 THEN "210" ELSE "320" /*A63-00336*/
        wdetail.body        = "" /*TRIM(wdetail2.vehuse)*/     
        wdetail.model       = trim(wdetail2.model)
        wdetail.cc          = TRIM(wdetail2.cc)
        wdetail.ton         = TRIM(wdetail2.ton) /*A61-0152*/
        wdetail.chasno      = trim(wdetail2.chasno)  
        wdetail.vehreg      = IF LENGTH(wdetail2.chasno)  > 8 THEN "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 ) 
                              ELSE "/" + trim(wdetail2.chasno)  
        wdetail.engno       = TRIM(wdetail2.engno)  
        /*wdetail.vehuse      = "1"*/ /*A65-0156*/
        wdetail.vehuse      = IF wdetail.subclass = "320" THEN "2" ELSE "1"  /*A65-0156*/
        wdetail.garage      = ""
        wdetail.cargrp      = "3"   /*A61-0152*/
        wdetail.covcod      = "T"
        wdetail.stk         = trim(wdetail2.com_no)
        wuppertxt2.stk      = trim(wdetail2.com_no)
        wdetail.si          = wdetail2.si
        /*wdetail.prempa      = fi_pack */ /*A61-0152*/
        wdetail.prempa      = wdetail2.prempa   /*A61-0152*/
        wdetail.branch      = wdetail2.branch 
        wdetail.benname     = ""
        wdetail.volprem     = trim(wdetail2.com_netprem)
        wdetail.comment     = ""
        wdetail.finint      = wdetail2.delerco
        wdetail.financecd   = wdetail2.financecd  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.agent       = wdetail2.agent
        wdetail.producer    = wdetail2.producer 
        wdetail.entdat      = string(TODAY)      /*entry date*/
        wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat     = STRING (TODAY)     /*tran date*/
        wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT    = "IM"
        wdetail.n_EXPORT    = "" 
        wdetail.inscod      = wdetail2.typepay    /*add Kridtiya i. A53-0183 ...vatcode*/
        wdetail.cedpol      = TRIM(wdetail2.tpis_no)    /*A58-0489*/
        /*wdetail.remark1     = TRIM(wdetail2.remark1)   A58-0489*/
        wdetail.occupn      = TRIM(wdetail2.occup)     /*A58-0489*/
        wdetail.revday      = TRIM(n_revday) 
        wdetail.memo        = TRIM(wdetail2.np_f18line1) /*A61-0152*/
        /*wdetail.campens     = TRIM(wdetail2.campens) */ /*A61-0152*/
        wdetail.campens     = IF INDEX(wdetail2.campens,"/") <> 0 THEN TRIM(REPLACE(wdetail2.campens,"/","_")) ELSE TRIM(wdetail2.campens) /*A61-0152*/      
        wdetail.memotext    = TRIM(wdetail2.memotext)     
        wdetail.vatcode     = TRIM(wdetail2.vatcode)      
        wdetail.name02      = TRIM(wdetail2.name02)
        wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE "" 
        wdetail.colors      = wdetail2.coulor  /*A66-0252*/
        wdetail.memo2       = if wdetail2.np_f18line3 <> "" then wdetail2.np_f18line3 else nv_memo1  /*A66-0252*/
        wdetail.memo3       = if wdetail2.np_f18line4 <> "" then wdetail2.np_f18line4 else nv_memo2  /*A66-0252*/
        wdetail.memo4       = if wdetail2.np_f18line5 <> "" then wdetail2.np_f18line5 else nv_memo3 . /*A66-0252*/ 

      IF wdetail.occup <> "" THEN DO:
        FIND FIRST stat.msgcode USE-INDEX MsgCode01 WHERE stat.msgcode.CompNo = "999"         AND 
          stat.msgcode.MsgNo  = wdetail.occupn NO-LOCK NO-ERROR.
        IF AVAIL stat.msgcode THEN
            ASSIGN wdetail.occupn = stat.msgcode.MsgDesc.
        ELSE ASSIGN wdetail.occupn = "".
      END.
      IF trim(wdetail2.chasno) <> "" AND INDEX(wdetail2.typ_work,"C") <> 0 THEN DO:  
          FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail2.chasno)) AND 
              sicuw.uwm301.tariff = "9" NO-LOCK  NO-ERROR NO-WAIT.
          IF AVAIL sicuw.uwm301 THEN DO:
              ASSIGN  wdetail.WARNING  = "มีกรมธรรม์ พรบ.ในระบบแล้ว "  
                  wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เคยมีการออกงานแล้ว " + sicuw.uwm301.policy
                  wdetail.pass     = "Y".
          END.
      END.
    END.   /*avail 1*/  
  END.  
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assign3_bp C-Win 
PROCEDURE 00-proc_assign3_bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by Ranu i. A58-0489       
------------------------------------------------------------------------------*/
/*comment by : Kridtiya i. A63-0472...
DEFINE VAR n_len_c AS INTE INIT 0.                   /*kridtiya i. A53-0317...*/
DEFINE VAR n_cha_no AS CHAR FORMAT "x(25)" INIT "".  /*kridtiya i. A53-0317...*/
DEF VAR np_70 AS CHAR FORMAT "x(15)" INIT "".       /*A58-0489*/
DEF VAR np_72 AS CHAR FORMAT "x(15)" INIT "".       /*A58-0489*/
ASSIGN fi_process  = "Create data to wdetail TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
FOR EACH wdetail2 .
       ASSIGN np_70 = ""   np_72 = ""  .     
       IF wdetail2.typ_work = "V"      THEN ASSIGN np_70 =  "V" + wdetail2.tpis_no      np_72 =  "" .
       ELSE IF wdetail2.typ_work = "C" THEN ASSIGN np_72 =  "C" + wdetail2.tpis_no      np_70 =  "" .
       ELSE IF wdetail2.typ_work = "V+C"   THEN ASSIGN np_70 =  "V" + wdetail2.tpis_no  np_72 =  "C" + wdetail2.tpis_no.
       ELSE ASSIGN np_70 =  ""   np_72 =  "" .
       ASSIGN 
           n_rev    = LENGTH(fi_filename)
           n_revday = SUBSTR(fi_filename,R-INDEX(fi_filename,"\"),n_rev).
       IF INDEX(n_revday,".csv") <> 0 THEN DO: 
           n_revday = trim(REPLACE(n_revday,".csv","")).
       END.
       IF INDEX(n_revday,"\") <> 0 THEN DO:
           n_revday = trim(REPLACE(n_revday,"\","")).
       END.
        IF (R-INDEX(TRIM(n_titlenam),"จก.")          <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
        ELSE IF (R-INDEX(TRIM(n_titlenam),"จำกัด")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
        ELSE IF (R-INDEX(TRIM(n_titlenam),"(มหาชน)") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
        ELSE IF (R-INDEX(TRIM(n_titlenam),"INC.")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
        ELSE IF (R-INDEX(TRIM(n_titlenam),"CO.")     <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
        ELSE IF (R-INDEX(TRIM(n_titlenam),"LTD.")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
        ELSE IF (R-INDEX(TRIM(n_titlenam),"LIMITED") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
        ELSE IF (INDEX(TRIM(n_titlenam),"บริษัท")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
        ELSE IF (INDEX(TRIM(n_titlenam),"บ.")        <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
        ELSE IF (INDEX(TRIM(n_titlenam),"บจก.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
        ELSE IF (INDEX(TRIM(n_titlenam),"หจก.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
        ELSE IF (INDEX(TRIM(n_titlenam),"หสน.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
        ELSE IF (INDEX(TRIM(n_titlenam),"บรรษัท")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
        ELSE IF (INDEX(TRIM(n_titlenam),"มูลนิธิ")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
        ELSE IF (INDEX(TRIM(n_titlenam),"ห้าง")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
        ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วน")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
        ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วนจำกัด") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
        ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วนจำก")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".   
        ELSE IF (INDEX(TRIM(n_titlenam),"และ/หรือ")          <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
       /* comment by : Ranu A61-0416 ....                                                             
        IF trim(wdetail2.ntitle)      = "นาย"    THEN ASSIGN wdetail2.ntitle = "คุณ".
        ELSE IF trim(wdetail2.ntitle) = "นาง"    THEN ASSIGN wdetail2.ntitle = "คุณ".
        ELSE IF trim(wdetail2.ntitle) = "นางสาว" THEN ASSIGN wdetail2.ntitle = "คุณ". 
        ELSE IF trim(wdetail2.ntitle) = "น.ส."   THEN ASSIGN wdetail2.ntitle = "คุณ".
        ELSE IF trim(wdetail2.ntitle) = "น.ส"    THEN ASSIGN wdetail2.ntitle = "คุณ".
        ELSE ASSIGN wdetail2.ntitle = trim(wdetail2.ntitle). .... end Ranu .....*/
        /* ranu A61-0416 */
        FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno        = "999" AND
                                        trim(brstat.msgcode.MsgDesc) = trim(wdetail2.ntitle)   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL brstat.msgcode THEN DO:  
            ASSIGN wdetail2.ntitle  =  trim(brstat.msgcode.branch).
        END.
        ELSE DO:
            IF wdetail2.ntitle = ""  THEN ASSIGN wdetail2.ntitle = "คุณ" .
            ELSE ASSIGN  wdetail2.ntitle = TRIM(wdetail2.ntitle) .
        END.
         /* end : ranu A61-0416 */
        wdetail2.icno = TRIM(wdetail2.icno) . /*A61-0152*/
        IF trim(wdetail2.cust_type) = "J"  AND LENGTH(wdetail2.icno) < 13 THEN ASSIGN wdetail2.icno = "0" + TRIM(wdetail2.icno) . /*A61-0152*/
        IF np_70 <> "" THEN DO:
            FIND FIRST wdetail WHERE wdetail.policy = np_70 NO-ERROR NO-WAIT.
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                CREATE wuppertxt2.
                /* comment by : ranu A61-0416 ...
                FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno  = "999" AND
                          index(trim(wdetail2.insnam),brstat.msgcode.MsgDesc) > 0    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.msgcode THEN  ASSIGN wdetail2.ntitle  =  trim(brstat.msgcode.branch).
                ELSE wdetail.tiname = "คุณ".
                ...end : ranu A61-0416 */
                ASSIGN                        /*policy line : 70       */
                    n_len_c             = 0   /*kridtiya i. A53-0317...*/
                    n_cha_no            = ""  /*kridtiya i. A53-0317...*/
                    n_len_c             = length(trim(wdetail2.chasno))  /*kridtiya i. A53-0317...*/
                    wdetail.seat        = IF wdetail2.class = "110" THEN "7" ELSE IF wdetail2.class = "210" THEN "5" ELSE "3"    /*IF TRIM(wdetail2.Usage) = "เก๋ง" THEN "7" ELSE "5"*/
                    wdetail.brand       = TRIM(wdetail2.brand)
                    wdetail.caryear     = TRIM(wdetail2.md_year)    /*ปีรถ*/
                    wdetail.poltyp      = "70"
                    wdetail.policy      = np_70 
                    wdetail.comdat      = TRIM(wdetail2.pol_comm_date) 
                    wdetail.expdat      = TRIM(wdetail2.pol_exp_date)  
                    wdetail.tiname      = trim(wdetail2.ntitle)                                
                    wdetail.insnam      = trim(wdetail2.insnam)  + " " + TRIM(wdetail2.NAME2) 
                    wdetail.ICNO        = trim(wdetail2.ICNO)         /*A56-0211*/
                    wdetail.name2       = wdetail2.dealer_name2 
                    /*wdetail.iadd1       = wdetail2.address
                    wdetail.iadd2       = wdetail2.tambon  
                    wdetail.iadd3       = wdetail2.amper   
                    wdetail.iadd4       = wdetail2.country + " " + wdetail2.post  /*Kridtiya i. A53-0180*/*/
                    wdetail.iadd1       = wdetail2.mail_hno 
                    wdetail.iadd2       = wdetail2.mail_tambon 
                    wdetail.iadd3       = wdetail2.mail_amper  
                    wdetail.iadd4       = wdetail2.mail_country + " " + wdetail2.mail_post
                    wdetail.subclass    = TRIM(wdetail2.class)
                    wdetail.body        = ""  /*TRIM(wdetail2.vehuse)*/     /*A58-0489*/
                    wdetail.model       = TRIM(wdetail2.model) 
                    wdetail.cc          = TRIM(wdetail2.cc)
                    wdetail.ton         = TRIM(wdetail2.ton) /*A61-0152*/
                    wdetail.weight      = IF wdetail2.class = "320" THEN TRIM(wdetail2.cc) ELSE TRIM(wdetail2.ton)
                    wdetail.chasno      = trim(wdetail2.chasno) 
                    wdetail.vehreg      = IF LENGTH(wdetail2.chasno)  > 8 THEN "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 ) 
                                          ELSE "/" + trim(wdetail2.chasno)  /*A56-0245*/
                    /*wdetail.engno       = substr(wdetail2.engno,1,2) + " " + substr(wdetail2.engno,3,LENGTH(wdetail2.engno))*/ /*A58-0489*/
                    wdetail.engno       = TRIM(wdetail2.engno)  /*A58-0489*/
                    wdetail.vehuse      = "1"
                    wdetail.cargrp      = "3"   /*A61-0152*/
                    /*wdetail.garage      = "G"   */ /*a62-0422 */
                    wdetail.garage      = IF wdetail2.garage = "" THEN "G" ELSE IF index(wdetail2.garage,"ห้าง") <> 0 THEN "G" 
                                          ELSE IF index(wdetail2.garage,"อะไหล่แท้") <> 0 THEN "P" ELSE ""  /*a62-0422 */
                    wdetail.accdata     = TRIM(Wdetail2.Acc_CV)      
                    wdetail.accamount   = TRIM(Wdetail2.Acc_amount)  
                    wdetail.stk         = trim(wdetail2.com_no)
                    wdetail.covcod      = TRIM(wdetail2.cover)
                    wdetail.si          = TRIM(wdetail2.si)
                    /*wdetail.prempa      = fi_pack */ /*A61-0152*/
                    wdetail.prempa      = wdetail2.prempa   /*A61-0152*/
                    wdetail.branch      = wdetail2.branch 
                    wdetail.benname     = wdetail2.financename
                    wdetail.volprem     = trim(wdetail2.pol_netprem)
                    wdetail.comment     = ""
                    wdetail.finint      = wdetail2.delerco
                    wdetail.agent       = wdetail2.agent     
                    wdetail.producer    = wdetail2.producer 
                    wdetail.entdat      = string(TODAY)      /*entry date*/
                    wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
                    wdetail.trandat     = STRING (TODAY)     /*tran date*/
                    wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
                    wdetail.n_IMPORT    = "IM"
                    wdetail.n_EXPORT    = "" 
                    wdetail.inscod      = TRIM(wdetail2.typepay)    /*add Kridtiya i. A53-0183 ...vatcode*/
                    wdetail.cedpol      = TRIM(wdetail2.tpis_no)    /*A58-0489*/
                    wdetail.remark1     = TRIM(wdetail2.remark1)           /*A58-0489*/
                    wdetail.occupn      = TRIM(wdetail2.occup)           /*A58-0489*/
                    wdetail.revday      = TRIM(n_revday) 
                    wdetail.memo        = TRIM(wdetail2.np_f18line1) /*A61-0152*/
                    /*wdetail.campens     = TRIM(wdetail2.campens) */ /*A61-0152*/
                    wdetail.campens     = IF INDEX(wdetail2.campens,"/") <> 0 THEN TRIM(REPLACE(wdetail2.campens,"/","_")) ELSE TRIM(wdetail2.campens) /*A61-0152*/  
                    wdetail.memotext    = TRIM(wdetail2.memotext)
                    wdetail.vatcode     = TRIM(wdetail2.vatcode)
                    wdetail.name02      = TRIM(wdetail2.name02)
                    wdetail.baseprem    = DECI(wdetail2.baseprm)
                    wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE "" 
                    wdetail.promotion   = IF wdetail2.producer = "B3M0018" OR wdetail2.producer = "B3M0031" THEN wdetail2.claimdi ELSE ""  /*A63-0209*/
                    wdetail.product     = IF wdetail2.producer = "B3M0018" OR wdetail2.producer = "B3M0031" THEN wdetail2.product ELSE ""  /*A63-0209*/
                        .
                   IF wdetail.occup <> "" THEN DO:
                        FIND FIRST stat.msgcode USE-INDEX MsgCode01 WHERE stat.msgcode.CompNo = "999" AND 
                                                                          stat.msgcode.MsgNo  = wdetail.occupn NO-LOCK NO-ERROR.
                        IF AVAIL stat.msgcode THEN
                            ASSIGN wdetail.occupn = stat.msgcode.MsgDesc.
                        ELSE ASSIGN wdetail.occupn = "".
                   END.
                   IF trim(wdetail2.chasno) <> "" AND INDEX(wdetail2.typ_work,"V") <> 0 THEN DO:  
                      FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail2.chasno)) AND 
                                                                       sicuw.uwm301.tariff = "X" NO-LOCK  NO-ERROR NO-WAIT.
                           IF AVAIL sicuw.uwm301 THEN DO:
                               ASSIGN  wdetail.WARNING  = "มีกรมธรรม์ในระบบแล้ว "  
                                       wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เคยมีการออกงานแล้ว " + sicuw.uwm301.policy
                                       wdetail.pass     = "Y".
                           END.
                   END.
            END.
        END.                              
        IF np_72 <> "" THEN DO:           
            FIND FIRST wdetail WHERE wdetail.policy = np_72 NO-ERROR NO-WAIT.
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                CREATE wuppertxt2.
                ASSIGN
                    n_len_c             = 0   /*kridtiya i. A53-0317...*/
                    n_cha_no            = ""  /*kridtiya i. A53-0317...*/
                    n_len_c             = length(trim(wdetail2.chasno))  /*kridtiya i. A53-0317...*/
                    wdetail.seat        = IF wdetail2.class = "110" THEN "7" ELSE IF wdetail2.class = "210" THEN "5" ELSE "3"  /*IF wdetail2.vehuse = "เก๋ง" THEN "7" ELSE "5"*/
                    wdetail.brand       = TRIM(wdetail2.brand)
                    wdetail.caryear     = TRIM(wdetail2.md_year)      /*ปีรถปัจจุบัน*/
                    wdetail.poltyp      = "72"   
                    wdetail.policy      = np_72
                    wuppertxt2.policydup = np_72
                    wdetail.comdat      = TRIM(wdetail2.com_comm_date)     
                    wdetail.expdat      = TRIM(wdetail2.com_exp_date)   
                    wdetail.tiname      = trim(wdetail2.ntitle)       /*A57-0159*/
                    wdetail.insnam      = trim(wdetail2.insnam)  + " " + trim(wdetail2.NAME2)  /*A54-0200*/
                    wdetail.ICNO        = TRIM(wdetail2.ICNO)         /*A56-0211*/
                    wdetail.name2       = wdetail2.dealer_name2 
                    wdetail.iadd1       = wdetail2.mail_hno 
                    wdetail.iadd2       = wdetail2.mail_tambon 
                    wdetail.iadd3       = wdetail2.mail_amper  
                    wdetail.iadd4       = wdetail2.mail_country + " " + wdetail2.mail_post
                    /*wdetail.subclass    = TRIM(wdetail2.class)*/
                    wdetail.subclass    = IF deci(wdetail2.com_netprem) = 600 THEN "110" ELSE IF deci(wdetail2.com_netprem) = 900 THEN "210" ELSE "320" /*A63-00336*/
                    wdetail.body        = "" /*TRIM(wdetail2.vehuse)*/     
                    wdetail.model       = trim(wdetail2.model)
                    wdetail.cc          = TRIM(wdetail2.cc)
                    wdetail.ton         = TRIM(wdetail2.ton) /*A61-0152*/
                    wdetail.chasno      = trim(wdetail2.chasno)  
                    wdetail.vehreg      = IF LENGTH(wdetail2.chasno)  > 8 THEN "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 ) 
                                          ELSE "/" + trim(wdetail2.chasno)  
                    wdetail.engno       = TRIM(wdetail2.engno)  
                    wdetail.vehuse      = "1"
                    wdetail.garage      = ""
                    wdetail.cargrp      = "3"   /*A61-0152*/
                    wdetail.covcod      = "T"
                    wdetail.stk         = trim(wdetail2.com_no)
                    wuppertxt2.stk      = trim(wdetail2.com_no)
                    wdetail.si          = wdetail2.si
                    /*wdetail.prempa      = fi_pack */ /*A61-0152*/
                    wdetail.prempa      = wdetail2.prempa   /*A61-0152*/
                    wdetail.branch      = wdetail2.branch 
                    wdetail.benname     = ""
                    wdetail.volprem     = trim(wdetail2.com_netprem)
                    wdetail.comment     = ""
                    wdetail.finint      = wdetail2.delerco
                    wdetail.agent       = wdetail2.agent
                    wdetail.producer    = wdetail2.producer 
                    wdetail.entdat      = string(TODAY)      /*entry date*/
                    wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
                    wdetail.trandat     = STRING (TODAY)     /*tran date*/
                    wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
                    wdetail.n_IMPORT    = "IM"
                    wdetail.n_EXPORT    = "" 
                    wdetail.inscod      = wdetail2.typepay    /*add Kridtiya i. A53-0183 ...vatcode*/
                    wdetail.cedpol      = TRIM(wdetail2.tpis_no)    /*A58-0489*/
                    /*wdetail.remark1     = TRIM(wdetail2.remark1)   A58-0489*/
                    wdetail.occupn      = TRIM(wdetail2.occup)     /*A58-0489*/
                    wdetail.revday      = TRIM(n_revday) 
                    wdetail.memo        = TRIM(wdetail2.np_f18line1) /*A61-0152*/
                    /*wdetail.campens     = TRIM(wdetail2.campens) */ /*A61-0152*/
                    wdetail.campens     = IF INDEX(wdetail2.campens,"/") <> 0 THEN TRIM(REPLACE(wdetail2.campens,"/","_")) ELSE TRIM(wdetail2.campens) /*A61-0152*/      
                    wdetail.memotext    = TRIM(wdetail2.memotext)     
                    wdetail.vatcode     = TRIM(wdetail2.vatcode)      
                    wdetail.name02      = TRIM(wdetail2.name02)
                    wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE "". 
                    IF wdetail.occup <> "" THEN DO:
                        FIND FIRST stat.msgcode USE-INDEX MsgCode01 WHERE stat.msgcode.CompNo = "999"         AND 
                                                                          stat.msgcode.MsgNo  = wdetail.occupn NO-LOCK NO-ERROR.
                        IF AVAIL stat.msgcode THEN
                            ASSIGN wdetail.occupn = stat.msgcode.MsgDesc.
                        ELSE ASSIGN wdetail.occupn = "".
                   END.
                   IF trim(wdetail2.chasno) <> "" AND INDEX(wdetail2.typ_work,"C") <> 0 THEN DO:  
                      FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail2.chasno)) AND 
                                                                       sicuw.uwm301.tariff = "9" NO-LOCK  NO-ERROR NO-WAIT.
                           IF AVAIL sicuw.uwm301 THEN DO:
                               ASSIGN  wdetail.WARNING  = "มีกรมธรรม์ พรบ.ในระบบแล้ว "  
                                       wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เคยมีการออกงานแล้ว " + sicuw.uwm301.policy
                                       wdetail.pass     = "Y".
                           END.
                   END.
            END.  /*avail 1*/  
        END. 
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_base2-bp C-Win 
PROCEDURE 00-proc_base2-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0344 ย้ายไปคำนวณเบี้ยที่ โปรแกรมกลาง...
DEF VAR i       AS INTE.    
DEF VAR per     AS DECI.    
DEF VAR f       AS DECI.    
DEF VAR chk     AS LOGICAL.
DEF VAR model   AS CHAR .
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN fi_process  = "Create data base_ TAS/TPIB.......[ISUZU]   " + wdetail.policy  .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
IF wdetail.poltyp = "v70" THEN DO:
    aa = 0 .
    IF wdetail.baseprem <> 0  THEN ASSIGN aa = wdetail.baseprem .
    ELSE DO: 
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ASSIGN  chk     = NO
        f = DECI(wdetail.volprem)
        i = 1
        NO_basemsg  = " "
        nv_baseprm  = aa
        wdetail.drivnam  = "N"
        nv_dss_per  =  deci(wdetail.dspc)
        nv_drivvar1 =  wdetail.drivnam1.
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
            Message
                 " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        End.
        RUN proc_usdcod.
        ASSIGN nv_drivvar  = ""
            nv_drivvar     = "A000"     /*nv_drivcod*/
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
    Assign  nv_basevar = ""
            nv_prem1   = nv_baseprm
            nv_basecod = "BASE"
            nv_basevar1 = "     Base Premium = "
            nv_basevar2 = STRING(nv_baseprm)
            SUBSTRING(nv_basevar,1,30)   = nv_basevar1
            SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    ASSIGN  nv_41  = 0      nv_42 = 0   nv_43 =  0
            nv_41  = DECI(wdetail.no_411)
            nv_42  = DECI(wdetail.no_42)
            nv_43  = DECI(wdetail.no_43)
            nv_seat41 = integer(wdetail.seat41). 
     /* -------fi_41---------*/
    nv_411var = "" .    nv_412var = "".
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
        SUBSTRING(nv_412var,31,30)  = nv_412var2.
    /* -------fi_42---------*/   
    Assign  nv_42var    = " " 
            nv_42cod   = "42"
    nv_42var1  = "     Medical Expense = "
    nv_42var2  = STRING(nv_42)
    SUBSTRING(nv_42var,1,30)   = nv_42var1
    SUBSTRING(nv_42var,31,30)  = nv_42var2.
    /*---------fi_43--------*/
    nv_43var    = " ".     
    Assign
        nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.

     RUN WGS\WGSOPER(INPUT nv_tariff,   
                          nv_class,
                          nv_key_b,
                          nv_comdat).
  /*------nv_usecod------------*/
    Assign  nv_usevar = ""
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30) = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  wdetail.subclass.       
    RUN wgs\wgsoeng.   
    /*-----nv_yrcod----------------------------*/  
    ASSIGN nv_yrvar = ""
        nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
        nv_yrvar1  = "     Vehicle Year = "
        nv_yrvar2  =  wdetail.caryear
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
            Substr(nv_yrvar,1,30)    = nv_yrvar1
            Substr(nv_yrvar,31,30)   = nv_yrvar2.  
     /*-----nv_sicod----------------------------*/ 
     nv_sivar = "" .
     Assign  nv_totsi     = 0
             nv_sicod     = "SI"
             nv_sivar1    = "     Own Damage = "
             nv_sivar2    =  wdetail.si
             SUBSTRING(nv_sivar,1,30)  = nv_sivar1
             SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
             nv_totsi     =  DECI(wdetail.si).
       /*----------nv_grpcod--------------------*/
       Assign   nv_grpvar = ""
           nv_grpcod      = "GRP" + wdetail.cargrp
           nv_grpvar1     = "     Vehicle Group = "
           nv_grpvar2     = wdetail.cargrp
           Substr(nv_grpvar,1,30)  = nv_grpvar1
           Substr(nv_grpvar,31,30) = nv_grpvar2.
     /*-------------nv_bipcod--------------------*/
     nv_bipvar = "" .
     ASSIGN
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(deci(wdetail.deductpp))
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     nv_biavar = "" .
     Assign 
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(deci(wdetail.deductba))
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
    nv_pdavar = "" .
     ASSIGN 
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         nv_pdavar2     = string(deci(WDETAIL.deductpa))   
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     
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
     /*------------------ dsspc ---------------*/
     IF nv_gapprm > f THEN  DO:
         /* A61-0324*/
         IF nv_dss_per =  0 THEN DO:
            IF nv_gapprm > f THEN 
                ASSIGN per = TRUNCATE((nv_gapprm - f ),1).
            ELSE ASSIGN per = 0.
         END.
         ELSE ASSIGN per = nv_dss_per.
        
         per = TRUNCATE((per * 100 ),1).
         per = ROUND((per / nv_gapprm ),2). 
         per = IF per <= 33 THEN per ELSE 33 .
         per = IF per <= (-1) THEN 0 ELSE per.
         nv_dsspcvar   = " ".
         Assign  nv_dss_per =  per . 
         nv_dsspcvar   = " ".                                  
         IF  nv_dss_per   <> 0  THEN                          
            Assign                                           
            nv_dsspcvar1   = "     Discount Special % = "    
            nv_dsspcvar2   =  STRING(nv_dss_per)             
            SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1    
            SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.   
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
   
END.
IF wdetail.polmaster <> "" THEN RUN proc_adduwd132.
... end A64-0344...*/   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest1_bk2 C-Win 
PROCEDURE 00-proc_chktest1_bk2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
DEF VAR nv_cc AS INT INIT 0.
DEF VAR nv_si AS INT INIT 0.
DEF VAR nv_carmodel AS CHAR INIT "" . /*a62-0422*/
RUN proc_var.                             
LOOP_WDETAIL:
FOR EACH wdetail:

        IF  wdetail.policy = ""  THEN NEXT.
        /*------------------  renew ---------------------*/
        RUN proc_cr_2.
        ASSIGN 
            n_rencnt = 0
            n_endcnt = 0.
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
            ASSIGN  nv_carmodel = "" . /*a62-0422*/
            /* add a62-0422 */
            IF INDEX(wdetail.model," ") <> 0 THEN DO:
               ASSIGN nv_carmodel   = trim(wdetail.model)  
                      wdetail.model = SUBSTR(nv_carmodel,1,INDEX(nv_carmodel," ") - 1 ) .
            END.
            ELSE DO: 
                ASSIGN nv_carmodel = TRIM(wdetail.model) .
            END.
            /* end A62-0422 */

            FIND LAST brstat.insure USE-INDEX insure03 WHERE 
                      brstat.insure.compno        = "TPIS"  AND
                      brstat.insure.text4         = trim(wdetail.prempa) + trim(wdetail.subclass)AND
                      deci(brstat.insure.text5)   = DECI(wdetail.volprem)   NO-LOCK NO-ERROR .
                    IF AVAIL brstat.insure THEN DO:
                        ASSIGN 
                         wdetail.deductpp  =  brstat.insure.lname
                         wdetail.deductba  =  brstat.insure.addr1  
                         wdetail.deductpa  =  brstat.insure.addr2 
                          /* add by A63-0113 */
                         wdetail.NO_411    = brstat.insure.addr3    
                         wdetail.NO_412    = brstat.insure.addr3 
                         wdetail.NO_42     = brstat.insure.addr4  
                         wdetail.NO_43     = brstat.insure.telno  .
                        /* end A63-0113 */
                    END.

             /*comment by kridtiya i. A63-0324 09/07/2020....
             /* add by A63-0113 */
             IF date(wdetail.comdat) >= 04/01/2020  THEN DO:
                 ASSIGN wdetail.prempa = "T" .
             END.
             ELSE DO:
            /* end A63-0113 */
             END BY kridtiya i. A63-0324 09/07/2020 */
                IF trim(wdetail.subclass) = "110" OR trim(wdetail.subclass) = "210" OR trim(wdetail.subclass) = "320" THEN DO:  
                    IF wdetail.subclass = "110" THEN DO: /* 110 */
                        IF INT(wdetail.si) <= 1000000 THEN DO:
                            IF INT(wdetail.CC) <= 2000  THEN DO: 
                                 FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                                  stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                                  stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                                  stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                                  stat.campaign_fil.vehgrp  = "3" and   /* group car */
                                  stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                                  stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                                  stat.campaign_fil.engine  <= 2000 and   /* CC */
                                  stat.campaign_fil.simax  = deci(wdetail.si) and  /* ทุน */
                                  stat.campaign_fil.moddes = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
                            END.
                            ELSE DO:
                                FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                                 stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                                 stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                                 stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                                 stat.campaign_fil.vehgrp  = "3" and   /* group car */
                                 stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                                 stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                                 stat.campaign_fil.engine  > 2000  and   /* CC */
                                 stat.campaign_fil.simax   = deci(wdetail.si) and  /* ทุน */
                                 stat.campaign_fil.moddes  = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
                            END.
                            IF AVAIL stat.campaign_fil THEN DO:
                             ASSIGN wdetail.polmaster  = stat.campaign_fil.polmst
                                    wdetail.NO_411     = string(stat.campaign_fil.mv411) 
                                    wdetail.NO_412     = string(stat.campaign_fil.mv412) 
                                    wdetail.NO_42      = string(stat.campaign_fil.mv42) 
                                    wdetail.NO_43      = string(stat.campaign_fil.mv43)
                                    /*wdetail.NO_44      = campaign_fil.mv44*/
                                    wdetail.fleet      = string(stat.campaign_fil.fletper)
                                    wdetail.ncb        = string(stat.campaign_fil.ncbper)
                                    wdetail.dspc       = string(stat.campaign_fil.dspcper)
                                    wdetail.loadclm    = string(stat.campaign_fil.clmper)
                                    wdetail.baseprem   = stat.campaign_fil.baseprm 
                                    wdetail.base3      = string(stat.campaign_fil.baseprm3)
                                    wdetail.netprem    = string(stat.campaign_fil.netprm)
                                    wdetail.seat       = string(stat.campaign_fil.seats)
                                    /*wdetail.seat41     = campaign_fil.seats     /*kridtiya i. A63-0324 09/07/2020 */*/
                                    wdetail.seat41     = stat.campaign_fil.seat41   .  /*kridtiya i. A63-0324 09/07/2020 */
                            END.
                            ELSE 
                             ASSIGN wdetail.polmaster  = ""
                                    wdetail.NO_411     = "0"
                                    wdetail.NO_412     = "0"
                                    wdetail.NO_42      = "0"
                                    wdetail.NO_43      = "0"
                                    wdetail.fleet      = "0"
                                    wdetail.ncb        = "0"
                                    wdetail.dspc       = "0"
                                    wdetail.loadclm    = "0"
                                    wdetail.baseprem   = 0
                                    wdetail.base3      = "0" 
                                    wdetail.netprem    = "0"
                                    wdetail.seat       = "0"
                                    wdetail.seat41     = 0 .
                        END.
                        ELSE DO:
                            nv_si = 0.
                            nv_si = (INT(wdetail.si) + 40000 ) .
                
                            IF INT(wdetail.CC) <= 2000  THEN DO: 
                                 FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                                  stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                                  stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                                  stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                                  stat.campaign_fil.vehgrp  = "3" and   /* group car */
                                  stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                                  stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                                  stat.campaign_fil.engine  <= 2000 and   /* CC */
                                  stat.campaign_fil.simax   >= deci(wdetail.si) and  /* ทุน */
                                  stat.campaign_fil.simax   <= nv_si            AND
                                  stat.campaign_fil.moddes  = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
                            END.
                            ELSE DO:
                                FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                                 stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                                 stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                                 stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                                 stat.campaign_fil.vehgrp  = "3" and   /* group car */
                                 stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                                 stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                                 stat.campaign_fil.engine  > 2000  and   /* CC */
                                 stat.campaign_fil.simax   >= deci(wdetail.si) and  /* ทุน */
                                 stat.campaign_fil.simax   <= nv_si            AND
                                 stat.campaign_fil.moddes  = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
                            END.
                            IF AVAIL stat.campaign_fil THEN DO:
                             ASSIGN wdetail.polmaster  = stat.campaign_fil.polmst
                                    wdetail.NO_411     = string(stat.campaign_fil.mv411) 
                                    wdetail.NO_412     = string(stat.campaign_fil.mv412) 
                                    wdetail.NO_42      = string(stat.campaign_fil.mv42) 
                                    wdetail.NO_43      = string(stat.campaign_fil.mv43)
                                    /*wdetail.NO_44      = campaign_fil.mv44*/
                                    wdetail.fleet      = string(stat.campaign_fil.fletper)
                                    wdetail.ncb        = string(stat.campaign_fil.ncbper)
                                    wdetail.dspc       = string(stat.campaign_fil.dspcper)
                                    wdetail.loadclm    = string(stat.campaign_fil.clmper)
                                    wdetail.baseprem   = stat.campaign_fil.baseprm 
                                    wdetail.base3      = string(stat.campaign_fil.baseprm3)
                                    wdetail.netprem    = string(stat.campaign_fil.netprm)
                                    wdetail.seat       = string(stat.campaign_fil.seats)
                                    /*wdetail.seat41     = campaign_fil.seats */    /*kridtiya i. A63-0324 09/07/2020 */
                                    wdetail.seat41     = stat.campaign_fil.seat41   .    /*kridtiya i. A63-0324 09/07/2020 */
                            END.
                            ELSE 
                             ASSIGN wdetail.polmaster  = ""
                                    wdetail.NO_411     = "0"
                                    wdetail.NO_412     = "0"
                                    wdetail.NO_42      = "0"
                                    wdetail.NO_43      = "0"
                                    wdetail.fleet      = "0"
                                    wdetail.ncb        = "0"
                                    wdetail.dspc       = "0"
                                    wdetail.loadclm    = "0"
                                    wdetail.baseprem   = 0
                                    wdetail.base3      = "0" 
                                    wdetail.netprem    = "0"
                                    wdetail.seat       = "0"
                                    wdetail.seat41     = 0 .
                        END.
                    END. /* end 110 */
                    ELSE IF wdetail.subclass = "210" THEN DO:  /* 210  320*/
                        FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                                  stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                                  stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                                  stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                                  stat.campaign_fil.vehgrp  = "3" and   /* group car */
                                  stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                                  stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                                  stat.campaign_fil.engine  <= 2000 and   /* CC */
                                  stat.campaign_fil.seats   = 5     and   /* ที่นั่ง */
                                  stat.campaign_fil.simax   = deci(wdetail.si) and  /* ทุน */
                                  stat.campaign_fil.moddes  = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
                         IF AVAIL stat.campaign_fil THEN DO:
                             ASSIGN wdetail.polmaster  = stat.campaign_fil.polmst
                                    wdetail.NO_411     = string(stat.campaign_fil.mv411) 
                                    wdetail.NO_412     = string(stat.campaign_fil.mv412) 
                                    wdetail.NO_42      = string(stat.campaign_fil.mv42) 
                                    wdetail.NO_43      = string(stat.campaign_fil.mv43)
                                    /*wdetail.NO_44      = campaign_fil.mv44*/
                                    wdetail.fleet      = string(stat.campaign_fil.fletper)
                                    wdetail.ncb        = string(stat.campaign_fil.ncbper)
                                    wdetail.dspc       = string(stat.campaign_fil.dspcper)
                                    wdetail.loadclm    = string(stat.campaign_fil.clmper)
                                    wdetail.baseprem   = stat.campaign_fil.baseprm 
                                    wdetail.base3      = string(stat.campaign_fil.baseprm3)
                                    wdetail.netprem    = string(stat.campaign_fil.netprm)
                                    wdetail.seat       = string(stat.campaign_fil.seats)
                                    /*wdetail.seat41     = campaign_fil.seats */    /*kridtiya i. A63-0324 09/07/2020 */
                                    wdetail.seat41     = stat.campaign_fil.seat41   .    /*kridtiya i. A63-0324 09/07/2020 */
                         END.
                         ELSE DO:
                             FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                                  stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                                  stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                                  stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                                  stat.campaign_fil.vehgrp  = "3" and   /* group car */
                                  stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                                  stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                                  stat.campaign_fil.engine  > 2000 and   /* CC */
                                  stat.campaign_fil.seats   = 5 AND
                                  stat.campaign_fil.simax   = deci(wdetail.si) and  /* ทุน */
                                  stat.campaign_fil.moddes  = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
                               IF AVAIL stat.campaign_fil THEN DO:
                                   ASSIGN wdetail.polmaster  = stat.campaign_fil.polmst
                                          wdetail.NO_411     = string(stat.campaign_fil.mv411) 
                                          wdetail.NO_412     = string(stat.campaign_fil.mv412) 
                                          wdetail.NO_42      = string(stat.campaign_fil.mv42) 
                                          wdetail.NO_43      = string(stat.campaign_fil.mv43)
                                          /*wdetail.NO_44      = campaign_fil.mv44*/
                                          wdetail.fleet      = string(stat.campaign_fil.fletper)
                                          wdetail.ncb        = string(stat.campaign_fil.ncbper)
                                          wdetail.dspc       = string(stat.campaign_fil.dspcper)
                                          wdetail.loadclm    = string(stat.campaign_fil.clmper)
                                          wdetail.baseprem   = stat.campaign_fil.baseprm 
                                          wdetail.base3      = string(stat.campaign_fil.baseprm3)
                                          wdetail.netprem    = string(stat.campaign_fil.netprm)
                                          wdetail.seat       = string(stat.campaign_fil.seats)
                                          /*wdetail.seat41     = campaign_fil.seats */    /*kridtiya i. A63-0324 09/07/2020  */
                                          wdetail.seat41     = stat.campaign_fil.seat41   .    /*kridtiya i. A63-0324 09/07/2020  */
                               END.
                               ELSE 
                                   ASSIGN wdetail.polmaster  = ""
                                    wdetail.NO_411     = "0"
                                    wdetail.NO_412     = "0"
                                    wdetail.NO_42      = "0"
                                    wdetail.NO_43      = "0"
                                    wdetail.fleet      = "0"
                                    wdetail.ncb        = "0"
                                    wdetail.dspc       = "0"
                                    wdetail.loadclm    = "0"
                                    wdetail.baseprem   = 0
                                    wdetail.base3      = "0" 
                                    wdetail.netprem    = "0"
                                    wdetail.seat       = "0"
                                    wdetail.seat41     = 0 .
                         END.
                
                    END.
                    
                END.
             /*END. /*... end A63-0113..*/*/ /*comment kridtiya i. A63-0324 09/07/2020*/
            wdetail.model = nv_carmodel . /*a62-0422*/
          
            RUN proc_chktest0.
        END.
        RUN proc_policy . 
        RUN proc_chktest2.
        RUN proc_chktest3.
        RUN proc_chktest4.  

        /* RELEASE stat.campaign_fil.  a63-0113 */
END.  /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest1_bp C-Win 
PROCEDURE 00-proc_chktest1_bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
/* comment by Ranu : A61-0152 04/04/2018 ............
ASSIGN fi_process  = "Process data  TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.

RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail:
        IF  wdetail.policy = ""  THEN NEXT.
        /*------------------  renew ---------------------*/
        RUN proc_cr_2.
        ASSIGN 
            n_rencnt = 0
            n_endcnt = 0.
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
        RUN proc_policy . 
        RUN proc_chktest2.
        RUN proc_chktest3.
        RUN proc_chktest4.   
END.     /*for each*/
... end A61-052...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest2_bp C-Win 
PROCEDURE 00-proc_chktest2_bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by Ranu : A61-0152............
ASSIGN fi_process  = "Create data sic_bran.uwm120,uwm130,uwm301 TPIS.......[ISUZU]  " + wdetail.policy  .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
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
IF NOT AVAILABLE sic_bran.uwm130 THEN                        
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
        ASSIGN  sic_bran.uwm130.uom6_v   = inte(wdetail.si)
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
        ASSIGN  sic_bran.uwm130.uom1_c  = "D1"
        sic_bran.uwm130.uom2_c  = "D2"
        sic_bran.uwm130.uom5_c  = "D5"
        sic_bran.uwm130.uom6_c  = "D6"
        sic_bran.uwm130.uom7_c  = "D7"
        sic_bran.uwm130.uom1_v  = deci(wdetail.deductpp)       
        sic_bran.uwm130.uom2_v  = deci(wdetail.deductba)       
        sic_bran.uwm130.uom5_v  = deci(wdetail.deductpa)       
        sic_bran.uwm130.uom6_v  = 0 
        sic_bran.uwm130.uom7_v  = inte(wdetail.si)
        sic_bran.uwm130.fptr01  = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02  = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03  = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04  = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05  = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN  sic_bran.uwm130.uom6_v   = 0
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
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do:                            
        Assign  sic_bran.uwm130.uom1_v = deci(wdetail.deductpp)      /*stat.clastab_fil.uom1_si*/
            sic_bran.uwm130.uom2_v     = deci(wdetail.deductba)      /*stat.clastab_fil.uom2_si*/
            sic_bran.uwm130.uom5_v     = deci(wdetail.deductpa)      /*stat.clastab_fil.uom5_si*/
            sic_bran.uwm130.uom8_v     = stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     = stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     = 0 
            sic_bran.uwm130.uom4_v     = 0 
            nv_uom1_v                  = sic_bran.uwm130.uom1_v   
            nv_uom2_v                  = sic_bran.uwm130.uom2_v
            nv_uom5_v                  = sic_bran.uwm130.uom5_v        
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
            Assign 
            wdetail.no_41    = string(stat.clastab_fil.si_41pai)
            wdetail.no_42    = string(stat.clastab_fil.si_42)    
            wdetail.no_43    = string(stat.clastab_fil.impsi_43)  
            wdetail.seat41   = stat.clastab_fil.dri_41 + clastab_fil.pass_41. 
        IF n_sclass72 = "v210" THEN wdetail.seat41 = 5.
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
             sic_bran.uwm301.bchcnt = nv_batcnt    NO-WAIT NO-ERROR.
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
             sic_bran.uwm301.body      = IF wdetail.model = "MU-X" THEN "WANGON" ELSE IF wdetail.model = "D-MAX" THEN "PICKUP" ELSE "TRUCK"
             sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
             sic_bran.uwm301.mv_ben83  = wdetail.benname
             sic_bran.uwm301.vehreg    = wdetail.vehreg
             sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
             sic_bran.uwm301.vehuse    = wdetail.vehuse
             sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
             sic_bran.uwm301.sckno     = 0
             sic_bran.uwm301.itmdel    = NO.
             sic_bran.uwm301.prmtxt    = IF wdetail.poltyp = "v70" THEN "คุ้มครองอุปกรณ์ตกแต่งราคาไม่เกิน 20,000 บาท" ELSE "" .
             wdetail.tariff            = sic_bran.uwm301.tariff.
             IF wdetail.poltyp = "v70" AND (wdetail.accdata <> "" ) THEN DO: 
                 RUN proc_prmtxt. 
             END.
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
                 ASSIGN   brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                     brstat.mailtxt_fil.lnumber   = nv_lnumber.
                     brstat.mailtxt_fil.ltext     = wdetail.drivername1 + FILL(" ",30 - LENGTH(wdetail.drivername1)). 
                     brstat.mailtxt_fil.ltext2    = wdetail.dbirth + "  " + string(nv_drivage1).
                     nv_drivno                    = 1.
                     ASSIGN brstat.mailtxt_fil.bchyr = nv_batchyr 
                     brstat.mailtxt_fil.bchno = nv_batchno 
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                     SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
                     SUBSTRING(brstat.mailtxt_fil.ltext,31,6) = "MALE". 
                     IF wdetail.drivername2 <> "" THEN DO:
                         CREATE brstat.mailtxt_fil. 
                         ASSIGN  brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                             brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                             brstat.mailtxt_fil.ltext    = wdetail.drivername2 + FILL(" ",30 - LENGTH(wdetail.drivername2)). 
                         brstat.mailtxt_fil.ltext2   = wdetail.ddbirth + "  " + string(nv_drivage2). 
                         nv_drivno                   = 2.
                         ASSIGN  brstat.mailtxt_fil.bchyr = nv_batchyr 
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
                     ASSIGN  brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
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
         END. ***********  end mailtxt   ************************/
         s_recid4         = RECID(sic_bran.uwm301).
         /*-- maktab_fil --*/
         IF wdetail.redbook NE "" AND chkred = YES THEN DO:
             FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass  AND
                 stat.maktab_fil.modcod = wdetail.redbook         No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN
                     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                     wdetail.cargrp          =  maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body.
         END.
         ELSE DO:
             IF wdetail.poltyp = "v72" THEN DO:
                 IF wdetail.subclass = "210" THEN wdetail.subclass = "140A".
                 ELSE wdetail.subclass = "110".
             END.
             FIND FIRST stat.insure USE-INDEX insure01  WHERE   
                 stat.insure.compno = fi_mocode         AND          
                 stat.insure.fname  = wdetail.model     NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL insure THEN  ASSIGN n_model =  stat.insure.lname   .
             ELSE ASSIGN n_model =  wdetail.model .
             /* Add A55-0107 */
            FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
                 stat.makdes31.moddes =  TRIM(wdetail.prempa) + wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL makdes31  THEN
                 ASSIGN nv_simat  = stat.makdes31.si_theft_p   
                 nv_simat1 = stat.makdes31.load_p   .    
             ELSE ASSIGN  nv_simat  = 0
                 nv_simat1 = 0.
             FIND FIRST stat.maktab_fil Use-index      maktab04          Where
                 stat.maktab_fil.makdes   =     wdetail.brand            And                  
                 INDEX(stat.maktab_fil.moddes,n_model) <>  0             AND
                 stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
                 stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND
                 stat.maktab_fil.sclass   =     wdetail.subclass         AND 
                 (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
                 stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1  / 100 ) GE deci(wdetail.si) )  AND  
                 stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)       No-lock no-error no-wait.
             If  avail stat.maktab_fil  Then 
                 ASSIGN 
                     wdetail.redbook         =  stat.maktab_fil.modcod       
                     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                     wdetail.cargrp          =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body.
             
         END.
         IF sic_bran.uwm301.modcod = ""  THEN RUN proc_maktab.
         ASSIGN sic_bran.uwm301.modcod = wdetail.redbook.
               
         IF wdetail.poltyp = "v72" THEN DO:
                 IF wdetail.subclass = "210" THEN wdetail.subclass = "140A".
         END.
      */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest3_bp C-Win 
PROCEDURE 00-proc_chktest3_bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by Ranu : A61-0152..............
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
ASSIGN fi_process  = "Create data base_premium... TPIS.......[ISUZU]   " + wdetail.policy  .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
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
        sic_bran.uwm301.mv41seat = wdetail.seat41.
  
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_matchfilechk6-1 C-Win 
PROCEDURE 00-proc_matchfilechk6-1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*If  substr(fi_output1,length(fi_output1) - 3,4) <>  ".slk"  Then
    fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_cnt   =  0
       nv_row   =  0 .
OUTPUT STREAM ns2 TO VALUE(fi_output1).
 nv_row  =  nv_row + 1.
 PUT STREAM ns2 "ID;PND" SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "จังหวัด"           '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "สาขา"              '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "ภูมิภาค"           '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "สาขากรมธรรม์ "     '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "รหัสดีเลอร์  "     '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Poltype"             '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "Ins. Year type"      '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "Business type"       '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "TAS received by"     '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "Ins company "        '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "New policy no  "     '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "Compulsory No."      '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "Insurance ref no."   '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "TPIS Contract No."   '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "Title name "         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "customer name"       '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "customer lastname "  '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Customer type"       '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "Director Name"       '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "ID number"           '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "House no."           '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Building "           '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "Village name/no."    '"' SKIP.                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Soi"                 '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Road "               '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "Sub-district"        '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "District"            '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Province"            '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Postcode"            '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Brand"               '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Car model "          '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Insurance Code"      '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Model Year"          '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "Usage Type"          '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "Colour "             '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "Car Weight"          '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "Year      "          '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "Engine No."          '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "Chassis No."                      '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "Accessories (for CV)"             '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "Accessories amount"               '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "License No."                      '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "Registered Car License"           '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "Campaign"                         '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "Type of work "                    '"' SKIP.                                                
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "Insurance amount"                 '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "Insurance Date (Voluntary) "      '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "Expiry Date (Voluntary)    "      '"' SKIP.                    
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Last Policy No.(Voluntary) "      '"' SKIP. */                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Insurance Type"                    '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "Net premium (Voluntary)    "      '"' SKIP.              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "Gross premium (Voluntary)  "      '"' SKIP.              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "Stamp "                           '"' SKIP.              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "VAT   "                           '"' SKIP.                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "WHT   "                           '"' SKIP.    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "Sticker No.                  "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "Insurance Date ( Compulsory )"    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "Expiry Date ( Compulsory)    "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "Net premium (Compulsory)     "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "Gross premium (Compulsory)   "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "Stamp "                           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "VAT"                              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "WHT "                             '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "Dealer "                          '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "Showroom  "                       '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "Payment Type "                    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "Beneficiery"                      '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "Mailing House no."                '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "Mailing  Building "               '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "Mailing  Village name/no."        '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "Mailing Soi           "           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "Mailing  Road         "           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "Mailing  Sub-district "           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "Mailing  District     "           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "Mailing Province      "           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' "Mailing Postcode      "           '"' SKIP. 
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "Policy no. to customer date  "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "Insurer Stamp Date "              '"' SKIP.*/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "Remark             "              '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "Occupation code    "              '"' SKIP.
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' "Register NO.       "              '"' SKIP.*/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "Producer code      "              '"' SKIP.
 RUN proc_matchfilechk7.
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
For each  wdetail2 :
    DELETE  wdetail2.
END.
For each  wdetail :
    DELETE  wdetail.
END.
message "Export File  Complete"  view-as alert-box.
RELEASE sicuw.uwm100.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_matchfilechk7-1 C-Win 
PROCEDURE 00-proc_matchfilechk7-1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR n_pol       AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_recnt     AS INT INIT 0.
DEF VAR n_encnt     AS INT INIT 0.
for each wdetail2 WHERE INDEX(wdetail2.typ_work,"V") <> 0 . 
    IF wdetail2.ins_ytyp = "" THEN DELETE wdetail2.
    ELSE DO:
          FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE
              sicuw.uwm100.cedpol = wdetail2.tpis_no    AND 
              sicuw.uwm100.poltyp = "V70"                     NO-LOCK NO-ERROR.
              IF AVAIL sicuw.uwm100  THEN DO: 
                  ASSIGN 
                      wdetail2.policy_no = sicuw.uwm100.policy 
                      wdetail2.agent     = sicuw.uwm100.acno1 
                      wdetail2.branch    = sicuw.uwm100.branch 
                      wdetail2.delerco   = sicuw.uwm100.finint
                      wdetail2.pol_typ   = sicuw.uwm100.poltyp. 
              END.
              ELSE DO:
                  ASSIGN  wdetail2.policy_no  = ""
                          wdetail2.agent      = ""
                          wdetail2.branch     = ""
                          wdetail2.delerco    = "" 
                          wdetail2.pol_typ    = "".
              END.
              IF (trim(wdetail2.financename) = "CASH") OR 
                 (trim(wdetail2.financename) = "Cash") OR 
                 (trim(wdetail2.financename) = "cash") THEN ASSIGN wdetail2.financename  = "".
              ELSE IF trim(wdetail2.financename) <> "" THEN DO:
                  FIND FIRST stat.insure USE-INDEX insure01 WHERE stat.insure.compno = "TPIS-LEAS" AND 
                                       stat.insure.fname = wdetail2.financename   OR
                                       stat.insure.lname = wdetail2.financename   NO-LOCK NO-ERROR . 
                     IF AVAIL stat.insure THEN
                         ASSIGN wdetail2.financename  = stat.insure.addr1 + stat.insure.addr2.
                     ELSE 
                          ASSIGN wdetail2.financename = "error : " + wdetail2.financename.
              END.
              RUN proc_matchbranch.
    END.
END.
RUN proc_matchfilechk70.
for each wdetail2 WHERE INDEX(wdetail2.typ_work,"C") <> 0 .
    IF wdetail2.ins_ytyp = "" THEN DELETE wdetail2.
    ELSE DO:
         FIND LAST sicuw.uwm100 USE-INDEX uwm10002  WHERE
              sicuw.uwm100.cedpol = TRIM(wdetail2.tpis_no)    AND 
              sicuw.uwm100.poltyp = "V72"   NO-LOCK NO-ERROR .
              IF AVAIL sicuw.uwm100  THEN DO: 
                  ASSIGN 
                      wdetail2.stkno   = wdetail2.com_no
                      wdetail2.com_no  = sicuw.uwm100.policy 
                      wdetail2.policy  = sicuw.uwm100.policy
                      wdetail2.agent   = sicuw.uwm100.acno1
                      wdetail2.branch  = sicuw.uwm100.branch 
                      wdetail2.delerco = sicuw.uwm100.finint
                      wdetail2.pol_typ = sicuw.uwm100.poltyp.
              END.
              ELSE DO:
                  ASSIGN  wdetail2.com_no  = ""
                          wdetail2.agent   = ""
                          wdetail2.stkno   = ""
                          wdetail2.branch  = ""
                          wdetail2.delerco = "" 
                          wdetail2.pol_typ = "". 
              END.
            RUN proc_matchbranch.
    END.
END.
RUN proc_matchfilechk72.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-Pro_assign3 C-Win 
PROCEDURE 00-Pro_assign3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS CHAR INIT "".
FOR EACH wdetail2 .
    /*---------- สาขา , Deler code , vat code ------------------*/
    IF TRIM(wdetail2.showroom) <> "" THEN DO:
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno       = "TPIS"                   AND         
            TRIM(stat.insure.fname)  = TRIM(wdetail2.deler)     AND
            TRIM(stat.insure.lname)  = TRIM(wdetail2.showroom)  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.insure THEN DO:
                ASSIGN  /*wdetail2.branch     = stat.insure.branch*/ /*A66-05252*/
                        wdetail2.branch     = IF trim(wdetail2.branch) = "" THEN  stat.insure.branch ELSE TRIM(wdetail2.branch)  /*A66-05252*/
                        wdetail2.delerco    = stat.insure.insno  
                        wdetail2.financecd  = stat.Insure.Text3     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                        wdetail2.typepay    = stat.insure.vatcode.   /* kridtiya i. A53-0183*/ 
                /*---------- ภัยก่อการร้าย----------------*/
                IF TRIM(stat.insure.Addr3) <> "" THEN DO:
                    IF INDEX(wdetail2.typ_work,"V") <> 0   THEN DO:        /*A58-0489*/
                    /*FIND LAST wno30txt  WHERE wno30txt.policy = "0" + wdetail2.tpis_no   NO-ERROR NO-WAIT.*/ /*A58-0489*/
                        FIND LAST wno30txt  WHERE wno30txt.policy = "V" + wdetail2.tpis_no   NO-ERROR NO-WAIT. /*A58-0489*/
                        IF NOT AVAIL wno30txt THEN DO:
                            CREATE wno30txt.
                            ASSIGN 
                                /*wno30txt.policy  = "0" + wdetail2.tpis_no */ /*A58-0489*/
                                wno30txt.policy  = "V" + wdetail2.tpis_no   /*A58-0489*/
                                wno30txt.text30  = stat.Insure.Addr3.
                        END.
                    END.
                    ELSE IF INDEX(wdetail2.typ_work,"C") <> 0   THEN  DO:
                        FIND LAST wno30txt  WHERE wno30txt.policy = "C" + wdetail2.tpis_no   NO-ERROR NO-WAIT. /*A58-0489*/
                        IF NOT AVAIL wno30txt THEN DO:
                            CREATE wno30txt.
                            ASSIGN 
                                wno30txt.policy  = "C" + wdetail2.tpis_no   /*A58-0489*/
                                wno30txt.text30  = stat.Insure.Addr3.
                        END.
        
                    END.             
                END. /* ก่อการร้าย */
                /*----------ออกใบเสร็จในนามดีลเลอร์ ----------------*/
                IF INDEX(wdetail2.remark1,"Issue tax invoice") <> 0 THEN DO: 
                    IF trim(stat.insure.addr1) <> " " THEN DO:
                        ASSIGN wdetail2.dealer_name2  = "และ/หรือ " + trim(stat.insure.addr1) + 
                                                        IF TRIM(stat.insure.addr2) <> "" THEN " " + trim(stat.insure.addr2) ELSE "". 
                   END.
                   ELSE DO:
                       FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = trim(wdetail2.typepay) NO-LOCK NO-ERROR .
                            IF AVAIL sicsyac.xmm600 THEN 
                                ASSIGN wdetail2.dealer_name2  = "และ/หรือ " + trim(sicsyac.xmm600.ntitle) + " " + trim(sicsyac.xmm600.NAME).    
                   END.
                END.
                ELSE DO:
                     ASSIGN  wdetail2.dealer_name2  = "".
                END.
                /*---end a58-0489----*/
            END.
            ELSE DO:                                       
                ASSIGN /*wdetail2.branch   = ""  */ /*A66-0252*/            
                       wdetail2.delerco  = ""  
                       wdetail2.financecd  = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                       wdetail2.typepay  = ""              
                       wdetail2.dealer_name2      = "" .   
            END.  
    END.
    ELSE DO:
      FIND FIRST stat.insure USE-INDEX insure01 WHERE stat.insure.compno       = "TPIS"     AND       
                                                      TRIM(stat.insure.fname)  = TRIM(wdetail2.deler) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.insure THEN DO:
                ASSIGN  /*wdetail2.branch     = stat.insure.branch*/ /*A66-05252*/
                        wdetail2.branch     = IF trim(wdetail2.branch) = "" THEN  stat.insure.branch ELSE TRIM(wdetail2.branch)  /*A66-05252*/
                        wdetail2.delerco    = stat.insure.insno 
                        wdetail2.financecd  = stat.Insure.Text3     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                        wdetail2.typepay    = stat.insure.vatcode.   /* kridtiya i. A53-0183*/ 
                IF TRIM(stat.insure.Addr3) <> "" THEN DO:
                    IF INDEX(wdetail2.typ_work,"V") <> 0   THEN DO:        /*A58-0489*/
                    /*FIND LAST wno30txt  WHERE wno30txt.policy = "0" + wdetail2.tpis_no   NO-ERROR NO-WAIT.*/ /*A58-0489*/
                        FIND LAST wno30txt  WHERE wno30txt.policy = "V" + wdetail2.tpis_no   NO-ERROR NO-WAIT. /*A58-0489*/
                        IF NOT AVAIL wno30txt THEN DO:
                            CREATE wno30txt.
                            ASSIGN 
                                /*wno30txt.policy  = "0" + wdetail2.tpis_no */ /*A58-0489*/
                                wno30txt.policy  = "V" + wdetail2.tpis_no   /*A58-0489*/
                                wno30txt.text30  = stat.Insure.Addr3.
                        END.
                    END.
                    ELSE IF INDEX(wdetail2.typ_work,"C") <> 0   THEN  DO:
                        FIND LAST wno30txt  WHERE wno30txt.policy = "C" + wdetail2.tpis_no   NO-ERROR NO-WAIT. /*A58-0489*/
                        IF NOT AVAIL wno30txt THEN DO:
                            CREATE wno30txt.
                            ASSIGN 
                                wno30txt.policy  = "C" + wdetail2.tpis_no   /*A58-0489*/
                                wno30txt.text30  = stat.Insure.Addr3.
                        END.
                    END.             
                END.
                /*----------ออกใบเสร็จในนามดีลเลอร์ ----------------*/
                IF INDEX(wdetail2.remark1,"Issue tax invoice") <> 0 THEN DO: 
                    IF trim(stat.insure.addr1) <> " " THEN DO:
                        ASSIGN wdetail2.dealer_name2  = "และ/หรือ " + trim(stat.insure.addr1) + 
                                                        IF TRIM(stat.insure.addr2) <> "" THEN " " + trim(stat.insure.addr2) ELSE "". 
                   END.
                   ELSE DO:
                       FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = trim(wdetail2.typepay) NO-LOCK NO-ERROR .
                            IF AVAIL sicsyac.xmm600 THEN 
                                ASSIGN wdetail2.dealer_name2  = "และ/หรือ " + trim(sicsyac.xmm600.ntitle) + " " + trim(sicsyac.xmm600.NAME).    
                   END.
                END.
                ELSE DO:
                     ASSIGN  wdetail2.dealer_name2  = "".
                END.
                /*---end a58-0489----*/
            END.
            ELSE DO:                                       
                ASSIGN /*wdetail2.branch    = ""    */ /*A66-0252*/          
                       wdetail2.delerco   = ""  
                       wdetail2.financecd = ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                       wdetail2.typepay   = "".            
            END.  
    END.
    /*---------------------------------------------------------------------*/
    /*comment by kridtiya i. A57-0260....
    IF INDEX(wdetail2.REMARK1,"ออกใบเสร็จ") = 0 THEN ASSIGN  dealer_name2    = "".
    ELSE ASSIGN dealer_name2     = "และ/หรือ " + trim(stat.insure.addr1).    /* dealer name         */*//*A57-0260*/
    /*IF INDEX(wdetail2.staus,"ออกใบเสร็จ") = 0 THEN ASSIGN  wdetail2.dealer_name2    = "".    /*A57-0260*/
    ELSE DO: 
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
            sicsyac.xmm600.acno = trim(wdetail2.typepay) NO-LOCK NO-ERROR .
        IF AVAIL sicsyac.xmm600 THEN 
            ASSIGN wdetail2.dealer_name2     = "และ/หรือ " + trim(sicsyac.xmm600.ntitle) + " " + 
                                           trim(sicsyac.xmm600.NAME).    /*A57-0415*/
    END.*/
    /*------------- ที่อยู่ -----------------------------------*/
    IF wdetail2.mail_build   <> ""  THEN DO: 
        /*IF INDEX(wdetail2.mail_build,"อาคาร") <> 0 THEN
            ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build). 
        ELSE IF INDEX(wdetail2.mail_build,"หมู่บ้าน") <> 0 THEN
            ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build). 
        ELSE IF INDEX(wdetail2.mail_build,"บจก.") <> 0 THEN
            ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build). 
        ELSE IF INDEX(wdetail2.mail_build,"บริษัท") <> 0 THEN
            ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build). 
        ELSE 
            ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " อาคาร" + trim(wdetail2.mail_build).*/
        ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
    END.
    IF wdetail2.mail_mu <> ""  THEN DO: 
        IF INDEX(wdetail2.mail_mu,"หมู่") <> 0   OR INDEX(wdetail2.mail_mu,"ม.") <> 0 OR 
           INDEX(wdetail2.mail_mu,"บ้าน") <> 0   OR INDEX(wdetail2.mail_mu,"หมู่บ้าน") <> 0 THEN DO:
            ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_mu).
        END.
        ELSE DO:
        ASSIGN  n = ""  
                n = SUBSTR(TRIM(wdetail2.mail_mu),1,1).
                IF INDEX("0123456789",n) <> 0 THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ม." + trim(wdetail2.mail_mu).
                ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " หมู่บ้าน" + trim(wdetail2.mail_mu).
        END.
    END.
    IF wdetail2.mail_soi <> ""  THEN DO:
        IF INDEX(wdetail2.mail_soi,"ซ.") <> 0 OR INDEX(wdetail2.mail_soi,"ซอย") <> 0 THEN 
             wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_soi) .
        ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ซอย" + trim(wdetail2.mail_soi) .
    END.
    IF wdetail2.mail_road <> ""  THEN DO: 
        IF INDEX(wdetail2.mail_road,"ถ.") <> 0 OR INDEX(wdetail2.mail_road,"ถนน") <> 0 THEN
             wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_road) .
        ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ถนน" + trim(wdetail2.mail_road) .
    END.
    IF trim(wdetail2.mail_country) <> ""  THEN DO:
        IF (index(wdetail2.mail_country,"กทม") <> 0 ) OR (index(wdetail2.mail_country,"กรุงเทพ") <> 0 ) THEN 
            ASSIGN 
            wdetail2.mail_tambon  = "แขวง"  + trim(wdetail2.mail_tambon) 
            wdetail2.mail_amper   = "เขต"   + trim(wdetail2.mail_amper)
          /*wdetail2.mail_country = trim(wdetail2.mail_country) + " " + trim(wdetail2.post)  /*Comment by Kridtiya i. A63-0472*/
            wdetail2.mail_post    = "" . */                                                  /*Comment by Kridtiya i. A63-0472*/
            wdetail2.mail_country = trim(wdetail2.mail_country)                              /*Add by Kridtiya i. A63-0472*/
            wdetail2.mail_post    = trim(wdetail2.post)  .                                   /*Add by Kridtiya i. A63-0472*/

        ELSE ASSIGN 
            wdetail2.mail_tambon  = "ตำบล"  +   trim(wdetail2.mail_tambon) 
            wdetail2.mail_amper   = "อำเภอ" +   trim(wdetail2.mail_amper)
            /*wdetail2.mail_country = "จังหวัด" + trim(wdetail2.mail_country) + " " + trim(wdetail2.mail_post)/*Comment by Kridtiya i. A63-0472*/
            wdetail2.mail_post    = "" . */                                                                   /*Comment by Kridtiya i. A63-0472*/
            wdetail2.mail_country = "จังหวัด" + trim(wdetail2.mail_country)                                   /*Add by Kridtiya i. A63-0472*/    
            wdetail2.mail_post    =  trim(wdetail2.mail_post) .                                               /*Add by Kridtiya i. A63-0472*/    
    END.
    /*--------- A58-0489-----------------*/
    DO WHILE INDEX(wdetail2.mail_hno,"  ") <> 0 :
        ASSIGN wdetail2.mail_hno = REPLACE(wdetail2.mail_hno,"  "," ").
    END.
    /*IF LENGTH(wdetail2.mail_hno) > 35  THEN DO:*/ /*A66-0252*/
    IF LENGTH(wdetail2.mail_hno) > 50  THEN DO: /*A66-0252*/
        loop_add01:
        /*DO WHILE LENGTH(wdetail2.mail_hno) > 35 :*/ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.mail_hno) > 50 : /*A66-0252*/
            IF r-INDEX(wdetail2.mail_hno," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.mail_tambon  = trim(SUBSTR(wdetail2.mail_hno,r-INDEX(wdetail2.mail_hno," "))) + " " + wdetail2.mail_tambon
                    wdetail2.mail_hno = trim(SUBSTR(wdetail2.mail_hno,1,r-INDEX(wdetail2.mail_hno," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        loop_add02:
        /*DO WHILE LENGTH(wdetail2.mail_tambon) > 35 :*/ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.mail_tambon) > 50 :  /*A66-0252*/
            IF r-INDEX(wdetail2.mail_tambon," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.mail_amper   = trim(SUBSTR(wdetail2.mail_tambon,r-INDEX(wdetail2.mail_tambon," "))) + " " + wdetail2.mail_amper
                    wdetail2.mail_tambon  = trim(SUBSTR(wdetail2.mail_tambon,1,r-INDEX(wdetail2.mail_tambon," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
    END.
    /*IF LENGTH(wdetail2.mail_tambon + " " + wdetail2.mail_amper) <= 35 THEN*/ /*A66-0252*/
    IF LENGTH(wdetail2.mail_tambon + " " + wdetail2.mail_amper) <= 50 THEN DO: /*A66-0252*/
        ASSIGN 
        wdetail2.mail_tambon  =  wdetail2.mail_tambon + " " + wdetail2.mail_amper   
        wdetail2.mail_amper   =  wdetail2.mail_country 
        wdetail2.mail_country =  "" .
    END.
    /*IF LENGTH(wdetail2.mail_amper + " " + wdetail2.mail_country ) <= 35 THEN*/ /*A66-0252*/
    IF LENGTH(wdetail2.mail_amper + " " + wdetail2.mail_country ) <= 50 THEN DO: /*A66-0252*/
        ASSIGN 
        wdetail2.mail_amper   =  trim(wdetail2.mail_amper) + " " + TRIM(wdetail2.mail_country) 
        wdetail2.mail_country =  "" .
    END.
    /*IF LENGTH(wdetail2.mail_country) > 20 THEN DO:*/ /*A66-0252*/
    IF LENGTH(wdetail2.mail_country) > 35 THEN DO: /*A66-0252*/
        IF INDEX(wdetail2.mail_country,"จังหวัด") <> 0 THEN 
            ASSIGN wdetail2.mail_country = REPLACE(wdetail2.mail_country,"จังหวัด","จ.").
    END.
END.
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
  DISPLAY tg_fileload ra_typeload fi_loaddat fi_pack fi_campens fi_mocode 
          fi_branch fi_memotext fi_producer fi_agent fi_vatcode fi_bchno 
          fi_name2 fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 
          fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname 
          fi_impcnt fi_process fi_completecnt fi_premtot fi_premsuc fi_fileexp 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE tg_fileload ra_typeload fi_loaddat fi_pack fi_campens fi_mocode 
         fi_branch fi_memotext fi_producer fi_agent fi_vatcode fi_bchno 
         fi_name2 fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 
         fi_output3 fi_usrcnt fi_usrprem buok bu_exit br_wdetail bu_hpbrn 
         bu_hpacno1 bu_hpagent fi_process fi_fileexp buexp RECT-370 RECT-372 
         RECT-373 RECT-374 RECT-376 RECT-377 RECT-378 
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
/************** v72 comp y **********/
ASSIGN
    wdetail.compul = "y"
    wdetail.tariff = "9" . 
/*RUN proc_stkfinddup.*/ /*F67-0001*/
IF wdetail.stk <> "" THEN  RUN proc_stkfinddup.  /*F67-0001*/

IF wdetail.poltyp = "v72" THEN DO:
    IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN wdetail.subclass = "140A".
    ELSE wdetail.subclass = "110".
    IF wdetail.compul <> "y" THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N". 
END.
IF wdetail.compul = "y" THEN DO:
    /*--Str amparat C. A51-0253--*/
    IF wdetail.stk <> "" THEN DO:  
        ASSIGN wdetail.stk = REPLACE(wdetail.stk,"'","").
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN 
                wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
                wdetail.pass    = ""
                wdetail.OK_GEN  = "N".
            /*--end amparat C. A51-0253--*/
    END.
END.
/*Kridtiy i. A54-0271 เช็คสาขาก่อนนำเข้า*/
IF wdetail.branch = " " THEN
    ASSIGN
        wdetail.comment = wdetail.comment + "| สาขา( Branch )เป็นค่าว่างกรุณาตรวจสอบสาขา"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
/*Kridtiy i. A54-0271 */
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail.subclass  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN 
        wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp   AND
        sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
        wdetail.OK_GEN  = "N".
END. 
/*---------- covcod ----------*/
wdetail.covcod = CAPS(wdetail.covcod).
FIND sicsyac.sym100 USE-INDEX sym10001     WHERE
    sicsyac.sym100.tabcod = "U013"         AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
    wdetail.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"          AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod  NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN   wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
    wdetail.OK_GEN = "N".
/*--------- modcod --------------*/
chkred = NO.   /*
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
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
    wdetail.OK_GEN  = "N".
ASSIGN  nv_docno  = " "
    nv_accdat = TODAY.
/***--- Docno ---***/
IF wdetail.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M" AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999")  NO-LOCK NO-ERROR .
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 C-Win 
PROCEDURE proc_722 :
/* ---------------------------------------------  U W M 1 3 0 -------------- */
DEF VAR n_class AS CHAR FORMAT "x(4)".
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp      AND            /*0*/
    sic_bran.uwm130.riskno = s_riskno      AND            /*1*/
    sic_bran.uwm130.itemno = s_itemno      AND            /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr    AND            /*26/10/2006 change field name */
    sic_bran.uwm130.bchno  = nv_batchno    AND            /*26/10/2006 change field name */ 
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
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class  NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN 
        ASSIGN  
        sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
        sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9 
        nv_comper              = deci(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc              = deci(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v = nv_comper   
        sic_bran.uwm130.uom9_v = nv_comacc  .   
    ASSIGN
        nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy,         /*a490166 Note modi*/
                                nv_riskno,
                                nv_itemno).
    END.   /* do transaction*/
    ASSIGN s_recid3  = RECID(sic_bran.uwm130) 
        /* ---------------------------------------------  U W M 3 0 1 --------------*/ 
        nv_covcod  =  wdetail.covcod 
        nv_makdes  =  wdetail.brand 
        nv_moddes  =  wdetail.model 
        /*--Str Amparat C. A51-0253--*/
        nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
    ELSE nv_newsck = wdetail.stk.
    /*--End Amparat C. A51-0253--*/  
    RUN proc_chassic. /*F67-0001*/
    FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
        sic_bran.uwm301.policy = sic_bran.uwm100.policy  AND
        sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt  AND
        sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt  AND
        sic_bran.uwm301.riskgp = s_riskgp                AND
        sic_bran.uwm301.riskno = s_riskno                AND
        sic_bran.uwm301.itemno = s_itemno                AND
        sic_bran.uwm301.bchyr  = nv_batchyr              AND 
        sic_bran.uwm301.bchno  = nv_batchno              AND 
        sic_bran.uwm301.bchcnt = nv_batcnt               NO-WAIT NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
        DO TRANSACTION:
            CREATE sic_bran.uwm301.
        END. /*transaction*/
    END.                                                          
    Assign            /*a490166 ใช้ร่วมกัน*/
        sic_bran.uwm301.policy   = sic_bran.uwm120.policy                   
        sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno   = s_itemno
        sic_bran.uwm301.tariff   = wdetail.tariff
        sic_bran.uwm301.covcod   = nv_covcod
        sic_bran.uwm301.cha_no   = wdetail.chasno
        sic_bran.uwm301.trareg   = nv_uwm301trareg /* Ranu I. :F67-0001*/
        sic_bran.uwm301.eng_no   = wdetail.eng
        /*sic_bran.uwm301.Tons     = INTEGER(wdetail.weight)*/ /*A63-00336*/
        sic_bran.uwm301.Tons     = INTEGER(wdetail.ton)        /*A63-00336*/
        sic_bran.uwm301.engine   = INTEGER(wdetail.cc)
        sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage   = wdetail.garage
        sic_bran.uwm301.body     = wdetail.body
        sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = wdetail.benname
        sic_bran.uwm301.vehreg   = wdetail.vehreg 
        sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        /*sic_bran.uwm301.moddes   = wdetail.model   */ /*A61-0152*/
        sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model   /*A61-0152*/
        sic_bran.uwm301.modcod   = wdetail.redbook 
        sic_bran.uwm301.car_color = trim(wdetail.colors)  /* A66-0252 */
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
        FIND FIRST brStat.Detaitem USE-INDEX detaitem11      WHERE
            brStat.Detaitem.serailno   = wdetail.stk         AND 
            brstat.detaitem.yearReg    = nv_batchyr          AND
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
    ELSE  sic_bran.uwm301.drinam[9] = "".
    s_recid4  = RECID(sic_bran.uwm301).
    /***--- modi by note a490166 ---***/
    IF wdetail.redbook NE "" THEN DO:   /*กรณีที่มีการระบุ Code รถมา*/
        FIND sicsyac.xmm102 USE-INDEX xmm10201  WHERE
            sicsyac.xmm102.modcod = wdetail.redbook  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102 THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod         = sicsyac.xmm102.modcod
               /* Substring(sic_bran.uwm301.moddes,1,18)   = SUBSTRING(xmm102.modest, 1,18)  /*Thai language*/  *//*A61-0152*/
               /* Substring(sic_bran.uwm301.moddes,19,22)  = SUBSTRING(xmm102.modest,19,22)  /*Thai Language*/  *//*A61-0152*/
                sic_bran.uwm301.Tons           = IF sicsyac.xmm102.tons = 0 THEN sicsyac.xmm102.engine ELSE sicsyac.xmm102.tons
                sic_bran.uwm301.engine         = sicsyac.xmm102.engine
                /*sic_bran.uwm301.moddes         = sicsyac.xmm102.modest*/ /*A61-0152*/
                sic_bran.uwm301.seats          = sicsyac.xmm102.seats
                sic_bran.uwm301.vehgrp         = sicsyac.xmm102.vehgrp
                wdetail.weight                 = string(sicsyac.xmm102.tons)  
                wdetail.cc                     = string(sicsyac.xmm102.engine)
                wdetail.seat                   = string(sicsyac.xmm102.seats)
                wdetail.redbook                = sicsyac.xmm102.modcod
                wdetail.brand                  = SUBSTRING(xmm102.modest, 1,18)    /*Thai*/
                wdetail.model                  = SUBSTRING(xmm102.modest,19,22) .  /*Thai*/
        END.
    END.
    ELSE DO:
        IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN 
            ASSIGN n_class = "210"
            wdetail.subclass = "140A".
        ELSE ASSIGN n_class = "110"
            wdetail.subclass = "110".
        /*A54-0271 add parameter.....
        ASSIGN nv_simat  = DECI(wdetail.si) - (DECI(wdetail.si) * 50 / 100 )
            nv_simat1 = DECI(wdetail.si) + (DECI(wdetail.si) * 50 / 100 )  .   A54-0271 .....*/
        /*IF wdetail.model = "cab4"  THEN n_model = "Hi-Lander".
        IF wdetail.model = "CAB4 HILANDER"  THEN n_model = "Hi-Lander".
        IF (wdetail.model = "CAB4 RODEO") OR (wdetail.model = "RODEO")  THEN n_model = "RODEO".
        IF wdetail.model = "MU7"  THEN n_model = "MU-7".
        IF wdetail.model = "SPACECAB HILANDER"  THEN n_model = "Extended Cab SX".
        IF wdetail.model = "SPACECAB"  THEN n_model = "Extended Cab SX".
        IF wdetail.model = "SPARK"  THEN n_model = "Single Cab EXL".*/
        /* Add A55-0107 */
        ASSIGN nv_modcod  = "".  
        FIND FIRST stat.insure USE-INDEX insure01  WHERE   
            stat.insure.compno = fi_mocode         AND          
            stat.insure.fname  = wdetail.model     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL insure THEN  ASSIGN n_model =  stat.insure.lname   .
        ELSE ASSIGN n_model =  wdetail.model .
        /* Add A55-0107 */
        FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
            makdes31.moddes =  TRIM(fi_pack) + n_class NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL makdes31  THEN
            ASSIGN nv_simat  = makdes31.si_theft_p   
            nv_simat1 = makdes31.load_p   .    
        ELSE ASSIGN  nv_simat  = 0
                     nv_simat1 = 0.
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =     wdetail.brand            And                  
            index(stat.maktab_fil.moddes,n_model) <> 0              And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
            stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND
            stat.maktab_fil.sclass   =     n_class                  AND
           (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
            stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
            stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)       No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN
            ASSIGN  nv_modcod       =  stat.maktab_fil.modcod    
            wdetail.redbook         =  stat.maktab_fil.modcod    
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                   
            /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/ /*A61-0152*/
            wdetail.cargrp          =  stat.maktab_fil.prmpac
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body    =  stat.maktab_fil.body   
            wdetail.weight          =  string(stat.maktab_fil.tons)  
            wdetail.cc              =  string(stat.maktab_fil.engine) .
        ELSE ASSIGN nv_modcod = "".                 /* Add A55-0107 */
        IF nv_modcod   = ""  THEN RUN proc_maktab.  /* Add A55-0107 */
    END.  /*add A52-0172*/
    FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
         sic_bran.uwd132.policy = wdetail.policy AND
         sic_bran.uwd132.rencnt = 0                AND
         sic_bran.uwd132.endcnt = 0                AND
         sic_bran.uwd132.riskgp = 0                AND
         sic_bran.uwd132.riskno = 1                AND
         sic_bran.uwd132.itemno = 1                AND
         sic_bran.uwd132.bchyr  = nv_batchyr       AND
         sic_bran.uwd132.bchno  = nv_batchno       AND
         sic_bran.uwd132.bchcnt = nv_batcnt        NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
      IF LOCKED sic_bran.uwd132 THEN DO:
        MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wdetail.policy
                "ไม่สามารถ Generage ข้อมูลได้".
        NEXT.
      END.
      CREATE sic_bran.uwd132.
    END.
    ASSIGN  sic_bran.uwd132.bencod  = "COMP"               /*Benefit Code*/
        sic_bran.uwd132.benvar  = ""                       /*Benefit Variable*/
        sic_bran.uwd132.rate    = 0                        /*Premium Rate %*/
        sic_bran.uwd132.gap_ae  = NO                       /*GAP A/E Code*/
        sic_bran.uwd132.gap_c   = 0    /*deci(wdetail.premt)  kridtiya i.*/      /*GAP, per Benefit per Item*/
        sic_bran.uwd132.dl1_c   = 0                        /*Disc./Load 1,p. Benefit p.Item*/
        sic_bran.uwd132.dl2_c   = 0                        /*Disc./Load 2,p. Benefit p.Item*/
        sic_bran.uwd132.dl3_c   = 0                        /*Disc./Load 3,p. Benefit p.Item*/
        sic_bran.uwd132.pd_aep  = "E"                      /*Premium Due A/E/P Code*/
        sic_bran.uwd132.prem_c  = 0    /*kridtiya i. deci(wdetail.premt) */     /*PD, per Benefit per Item*/
        sic_bran.uwd132.fptr    = 0                       /*Forward Pointer*/
        sic_bran.uwd132.bptr    = 0                       /*Backward Pointer*/
        sic_bran.uwd132.policy  = wdetail.policy          /*Policy No. - uwm130*/
        sic_bran.uwd132.rencnt  = 0                       /*Renewal Count - uwm130*/
        sic_bran.uwd132.endcnt  = 0                       /*Endorsement Count - uwm130*/
        sic_bran.uwd132.riskgp  = 0                       /*Risk Group - uwm130*/
        sic_bran.uwd132.riskno  = 1                       /*Risk No. - uwm130*/
        sic_bran.uwd132.itemno  = 1                       /*Insured Item No. - uwm130*/
        sic_bran.uwd132.rateae  = NO                      /*Premium Rate % A/E Code*/
        sic_bran.uwm130.fptr03  = RECID(sic_bran.uwd132)  /*First uwd132 Cover & Premium*/
        sic_bran.uwm130.bptr03  = RECID(sic_bran.uwd132)  /*Last  uwd132 Cover & Premium*/
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
    FIND sicsyac.xmm107 USE-INDEX xmm10701        WHERE
        sicsyac.xmm107.class  = wdetail.subclass  AND
        sicsyac.xmm107.tariff = wdetail.tariff    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xmm107 THEN DO:
        FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmd107 THEN DO:
            CREATE sic_bran.uwd132.
            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                sicsyac.xmm016.class = wdetail.subclass  NO-LOCK NO-ERROR NO-WAIT.
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
            ELSE 
                MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
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
                        /*MESSAGE sic_bran.uwd132.gap_c "1 / " nv_gap nv_prem   VIEW-AS ALERT-BOX.*/
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
    sicsyac.xmm020.branch = sic_bran.uwm100.branch  AND
    sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri  NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN 
    ASSIGN nv_stm_per      = sicsyac.xmm020.rvstam
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
         sic_bran.uwm120.gap_r  =  nv_gap.
         sic_bran.uwm120.prem_r =  nv_prem.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132 C-Win 
PROCEDURE proc_adduwd132 :
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
/* add by : A64-0344*/
DEF VAR nv_412    AS DECIMAL.
DEF VAR nv_411t   AS DECIMAL.   
DEF VAR nv_412t   AS DECIMAL.   
DEF VAR nv_42t    AS DECIMAL.   
DEF VAR nv_43t    AS DECIMAL.   
DEF VAR nv_comment   AS CHAR FORMAT "x(250)" .
DEF VAR nv_warning   AS CHAR FORMAT "x(250)" .
DEF VAR nv_pass      AS CHAR .
/* end : A64-0344*/
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
   
    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0
           /* A64-0344 */ 
           nv_411t = 0      nv_412t = 0         nv_42t  = 0      nv_43t  = 0
           nv_comment = ""  nv_warning  = ""    nv_pass = "" .
          /* end : A64-0344 */ 


     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              stat.pmuwd132.campcd        = trim(wdetail.campens)  AND
              TRIM(stat.pmuwd132.policy)  = TRIM(wdetail.polmaster)  NO-LOCK.

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
             sic_bran.uwd132.bencod  = stat.pmuwd132.bencod      NO-ERROR NO-WAIT.
   
            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.

               ASSIGN fi_process = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
               DISP fi_process WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                  sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                  sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                  sic_bran.uwd132.gap_ae  =  NO /*stat.pmuwd132.gap_ae  A64-0344 */                  
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  "E" /*stat.pmuwd132.pd_aep A64-0344 */                  
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
              
               IF sic_bran.uwd132.bencod = "SI"  THEN ASSIGN sic_bran.uwd132.benvar = nv_sivar .
               IF sic_bran.uwd132.bencod = "BI1" THEN ASSIGN sic_bran.uwd132.benvar = nv_bipvar.
               IF sic_bran.uwd132.bencod = "BI2" THEN ASSIGN sic_bran.uwd132.benvar = nv_biavar.
               IF sic_bran.uwd132.bencod = "PD"  THEN ASSIGN sic_bran.uwd132.benvar = nv_pdavar.
               IF sic_bran.uwd132.bencod = "411" THEN ASSIGN sic_bran.uwd132.benvar = nv_411var.
               IF sic_bran.uwd132.bencod = "412" THEN ASSIGN sic_bran.uwd132.benvar = nv_412var.
               IF sic_bran.uwd132.bencod = "42"  THEN ASSIGN sic_bran.uwd132.benvar = nv_42var .
               IF sic_bran.uwd132.bencod = "43"  THEN ASSIGN sic_bran.uwd132.benvar = nv_43var .
               /* add by : Ranu I. A64-0344 */
               IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN  nv_ncbper  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)). 
               IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  .  
               IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  . 
               IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  .  
               IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  .   
               
               IF sic_bran.uwd132.bencod = "FLET" AND TRIM(stat.pmuwd132.benvar) = "" THEN DO:
                   ASSIGN sic_bran.uwd132.benvar = "     Fleet Discount %  =      10 " .
               END.
               /* end : A64-0344 */
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
                   ASSIGN nv_ncbyrs =   0
                       nv_ncbper    =   0
                       nv_ncb       =   0.
               END.
               ASSIGN   
                sic_bran.uwm301.ncbper   = nv_ncbper
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs .
               /* end A64-0344*/

               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).
            END.
        END.
         /* add by : A64-0344 */
        RUN wgw\wgwchkpadd 
            (input        sic_bran.uwm100.comdat, 
             input        sic_bran.uwm100.expdat, 
             input        wdetail.subclass, /* 110 ,210 ,320 */
             input        int(wdetail.no_411),  
             input        int(wdetail.no_411),             
             input        int(wdetail.no_42) , 
             input        int(wdetail.no_43) ,  
             input        int(wdetail.seat41),  
             input        nv_411t,  
             input        nv_412t,  
             input        nv_42t ,  
             input        nv_43t ,  
             input        wdetail.polmaster,
             input        wdetail.campens,
             input-output nv_comment  ,
             input-output nv_warning  ,
             input-output nv_pass    ). 
        if nv_comment <> "" then assign wdetail.comment  = wdetail.comment + "|" + trim(nv_comment) .
        if nv_warning <> "" then assign wdetail.warning  = wdetail.warning + "|" + trim(nv_warning) .
        ASSIGN wdetail.pass = IF wdetail.pass = "N" THEN "N" ELSE nv_pass .  

        IF nv_pdprm <> DECI(wdetail.volprem) THEN DO:
           ASSIGN
           wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
           wdetail.WARNING = wdetail.WARNING + "เบี้ยจากระบบ " + string(nv_pdprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.volprem
           wdetail.pass    = IF wdetail.pass <> "N" THEN "Y" ELSE "N"  
           wdetail.OK_GEN  = "N".
        END.
        /* end A64-0328 */

    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132prem C-Win 
PROCEDURE proc_adduwd132prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A64-0344       
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

               ASSIGN fi_process = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
               DISP fi_process WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                  sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                  sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                  sic_bran.uwd132.gap_ae  =  NO                   
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  "E"                   
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
              
               
               IF sic_bran.uwd132.bencod = "NCB" THEN ASSIGN nv_ncbper  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)). 

               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).

            END. /* end uwd132*/
           
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
            
           DELETE stat.pmuwd132 .
    END. /* end pmuwd132 */
    IF nv_pdprm <> DECI(wdetail.volprem) THEN DO:
       ASSIGN
           wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
           wdetail.WARNING = wdetail.WARNING + "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.volprem
           wdetail.pass    = IF wdetail.pass <> "N" THEN "Y" ELSE "N"  
           wdetail.OK_GEN  = "N".
    END.
    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign C-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A58-0489 (form new)      
------------------------------------------------------------------------------*/
DEF BUFFER bfwdetail2 FOR wdetail2. /*A62-0422*/
ASSIGN fi_process  = "Create data to workfile TAS/TPIB.......[ISUZU]" .  
DISP  fi_process WITH FRAM fr_main.
/*A61-0152*/
ASSIGN nv_memo1 = ""
       nv_memo2 = ""
       nv_memo3 = "" .
/* end A61-0152*/
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail2.
    IMPORT DELIMITER "|"    
        Wdetail2.ins_ytyp          
        wdetail2.bus_typ           
        wdetail2.TASreceived          
        wdetail2.InsCompany           
        wdetail2.Insurancerefno       
        wdetail2.tpis_no
        wdetail2.ntitle             
        wdetail2.insnam               
        wdetail2.NAME2                
        wdetail2.cust_type
        wdetail2.nDirec               
        wdetail2.ICNO                 
        wdetail2.address              
        wdetail2.build
        wdetail2.mu                   
        wdetail2.soi                  
        wdetail2.road                 
        wdetail2.tambon               
        wdetail2.amper                
        wdetail2.country              
        wdetail2.post                 
        wdetail2.brand             
        wdetail2.model                
        wdetail2.class
        wdetail2.md_year
        wdetail2.Usage              
        wdetail2.coulor               
        wdetail2.cc                   
        wdetail2.regis_year     
        wdetail2.engno                
        wdetail2.chasno               
        Wdetail2.Acc_CV            
        Wdetail2.Acc_amount        
        wdetail2.License
        wdetail2.regis_CL
        wdetail2.campaign
        wdetail2.typ_work
        wdetail2.si                   
        wdetail2.pol_comm_date     
        wdetail2.pol_exp_date     
        wdetail2.last_pol
        wdetail2.cover
        wdetail2.pol_netprem
        wdetail2.pol_gprem
        wdetail2.pol_stamp
        wdetail2.pol_vat
        wdetail2.pol_wht
        wdetail2.com_no
        wdetail2.com_comm_date
        wdetail2.com_exp_date
        wdetail2.com_netprem
        wdetail2.com_gprem
        wdetail2.com_stamp
        wdetail2.com_vat
        wdetail2.com_wht
        wdetail2.deler                
        wdetail2.showroom             
        wdetail2.typepay              
        wdetail2.financename          
        wdetail2.mail_hno
        wdetail2.mail_build
        wdetail2.mail_mu                   
        wdetail2.mail_soi                  
        wdetail2.mail_road                 
        wdetail2.mail_tambon               
        wdetail2.mail_amper                
        wdetail2.mail_country              
        wdetail2.mail_post                 
        wdetail2.send_date
        wdetail2.policy_no
        wdetail2.send_data
        wdetail2.REMARK1              
        wdetail2.occup
        wdetail2.np_f18line1  /*A61-0152*/
        wdetail2.regis_no     
        wdetail2.claimdi      /*A63-0209*/
        wdetail2.product     /*A63-0209*/
        /* A66-0252 */
        wdetail2.np_f18line3
        wdetail2.np_f18line4
        wdetail2.np_f18line5
        wdetail2.producer
        wdetail2.agent
        wdetail2.branch
        wdetail2.campens  /* end :A66-0252*/
        wdetail2.txterr           
        wdetail2.Driver1_title          
        wdetail2.Driver1_name           
        wdetail2.Driver1_lastname       
        wdetail2.Driver1_birthdate      
        wdetail2.Driver1_id_no          
        wdetail2.Driver1_license_no     
        wdetail2.Driver1_occupation     
        wdetail2.Driver2_title          
        wdetail2.Driver2_name           
        wdetail2.Driver2_lastname       
        wdetail2.Driver2_birthdate      
        wdetail2.Driver2_id_no          
        wdetail2.Driver2_license_no     
        wdetail2.Driver2_occupation     
        wdetail2.Driver3_title          
        wdetail2.Driver3_name           
        wdetail2.Driver3_lastname       
        wdetail2.Driver3_birthday       
        wdetail2.Driver3_id_no          
        wdetail2.Driver3_license_no     
        wdetail2.Driver3_occupation     
        wdetail2.Driver4_title          
        wdetail2.Driver4_name           
        wdetail2.Driver4_lastname       
        wdetail2.Driver4_birthdate      
        wdetail2.Driver4_id_no          
        wdetail2.Driver4_license_no     
        wdetail2.Driver4_occupation     
        wdetail2.Driver5_title          
        wdetail2.Driver5_name           
        wdetail2.Driver5_lastname       
        wdetail2.Driver5_birthdate      
        wdetail2.Driver5_id_no          
        wdetail2.Driver5_license_no     
        wdetail2.Driver5_occupation  .  
    /* A61-0152*/
    IF INDEX(wdetail2.ins_ytyp,"mail") <> 0 THEN DO:
      ASSIGN nv_memo1 = wdetail2.bus_typ 
             nv_memo2 = wdetail2.TASreceived  
             nv_memo3 = wdetail2.InsCompany.
    END. 
    /* end A61-0152*/
    ELSE IF INDEX(wdetail2.ins_ytyp,"Ins") <> 0 THEN DELETE wdetail2.               
    ELSE IF INDEX(wdetail2.ins_ytyp,"ins")  <> 0 THEN DELETE wdetail2. 
    ELSE IF INDEX(wdetail2.ins_ytyp,"Renew") <> 0 THEN DELETE wdetail2. 
    ELSE IF INDEX(wdetail2.ins_ytyp,"renew")  <> 0 THEN DELETE wdetail2.
    ELSE IF TRIM(wdetail2.bus_typ) <> "LCV"  THEN DELETE wdetail2. 
    ELSE IF wdetail2.tpis_no = "" THEN  DELETE wdetail2.
    ELSE RUN proc_colorcode. 
END. /*-Repeat-*/ 
/* A62-0422 */
RELEASE wdetail2. 

FIND FIRST bfwdetail2 WHERE bfwdetail2.tpis_no <> "" AND INDEX(bfwdetail2.si,"ซ่อม") <> 0 NO-ERROR NO-WAIT .
 IF AVAIL bfwdetail2 THEN DO:
     MESSAGE "กรุณาเลือกไฟล์แจ้งงานแบบเดิม ! " VIEW-AS ALERT-BOX.
     FOR EACH wdetail2 .
        DELETE wdetail2.
     END.
 END.
 /* end A62-0422 */

RUN proc_assign2.
RUN proc_assign3.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2 C-Win 
PROCEDURE proc_assign2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A58-0489      
------------------------------------------------------------------------------*/
DEF VAR n_benname   AS CHAR INIT "" FORMAT "x(50)".  /*A55-0051*/
ASSIGN fi_process  = "Match benifitcode data to workfile TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
FOR EACH wdetail2 .
    IF wdetail2.tpis_no = "" THEN  DELETE wdetail2.
    ELSE DO:
        ASSIGN wdetail2.CLASS = TRIM(wdetail2.class) . /*A66-0252*/
        /*------  หาแคมเปญ ------------*/
        IF wdetail2.campaign = "" THEN DO:
            IF wdetail2.bus_typ = "LCV" THEN DO:
                ASSIGN wdetail2.campaign = "*"  
                       wdetail2.model    = trim(wdetail2.model).
               /* IF /*INT(wdetail2.cc) = 0 AND*/ wdetail2.chasno <> "" THEN DO:
                    n_cc = trim(SUBSTR(wdetail2.chasno,7,2)).
                    IF n_cc = "85"  THEN wdetail2.cc = "3000".
                    ELSE IF n_cc = "86" THEN wdetail2.cc = "2500".
                    ELSE wdetail2.cc = "1900" .
                END.*/
            END.
            /* comment by Ranui A61-0152.....
            ELSE  
                ASSIGN wdetail2.campaign = "-" .
                       wdetail2.model    = IF INDEX(wdetail2.model,"TRAILER") <> 0  THEN "TRAILER" ELSE SUBSTR(trim(wdetail2.model),1,6).
            ...end A61-0152....*/
           
        END.
        ELSE DO: 
            /* comment by ranu : A61-0152.....
            IF TRIM(wdetail2.campaign) = "MUX01" THEN ASSIGN wdetail2.model  = "MU-X" .
            ELSE ASSIGN wdetail2.model  = "D-MAX".
            ...end A61-0152.*/
            /* create by A61-0152*/
            n_model = "" .
            IF trim(wdetail2.chasno) <> ""  THEN DO:
                n_model = trim(SUBSTR(wdetail2.chasno,9,1)) .
                IF n_model = "G" THEN wdetail2.model = "MU-X".
                ELSE DO:
                    n_model = "" .
                    n_model = TRIM(SUBSTR(wdetail2.model,6,1)).
                    IF n_model = "G" THEN wdetail2.model = "MU-X".
                    ELSE wdetail2.model = "D-MAX" .
                END.
            END.
            IF wdetail2.CLASS = "" THEN DO:
               IF deci(wdetail2.com_netprem) = 0 THEN wdetail2.CLASS = "" .
               ELSE IF deci(wdetail2.com_netprem) = 600 THEN wdetail2.CLASS = "110" .
               ELSE wdetail2.CLASS = "210" .
            END.
            /*Add by Kridtiya i. Date 14/07/2020 A63-00336  เพิ่ม รหัส 320*/
            IF wdetail2.campaign = "2TD03" OR wdetail2.campaign = "2TD04" OR
               wdetail2.campaign = "2TD29" THEN DO:
                ASSIGN 
                    wdetail2.CLASS  = "320" 
                    wdetail2.model  = "D-MAX Single" 
                    wdetail2.ton    = wdetail2.cc .
            END.
            /*Add by Kridtiya i. Date 14/07/2020 A63-00336  เพิ่ม รหัส 320*/
        END.
        
        /* end : A61-0152*/
        FIND FIRST brstat.insure USE-INDEX insure01 WHERE brstat.insure.compno    = "TPIS"            AND
                                                          brstat.insure.fname     = trim(wdetail2.campaign) AND
                                                          brstat.insure.vatcode   = trim(wdetail2.bus_typ)  NO-LOCK NO-ERROR.
        IF AVAIL brstat.insure THEN DO:
            ASSIGN
             /*wdetail2.campens  =  brstat.insure.text1   */  /*A66-0252*/ 
             /*wdetail2.producer =  brstat.insure.icaddr2 */  /*A66-0252*/
             /*wdetail2.agent    =  "B3M0018"*/               /*A66-0252*/
             wdetail2.campens  =  if trim(wdetail2.campens ) = "" then brstat.insure.text1   else trim(wdetail2.campens ) /*A66-0252*/   
             wdetail2.producer =  if trim(wdetail2.producer) = "" then brstat.insure.icaddr2 else trim(wdetail2.producer) /*A66-0252*/   
             wdetail2.agent    =  if trim(wdetail2.agent   ) = "" then "B3M0018"             else trim(wdetail2.agent   ) /*A66-0252*/
             wdetail2.memotext =  brstat.insure.text2
             wdetail2.vatcode  =  brstat.insure.text4
             wdetail2.prempa   =  brstat.insure.Text3  /*A61-0152*/
             wdetail2.name02   =  IF wdetail2.vatcode <> "" THEN "และ/หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด" ELSE "" .
        END.
        ELSE DO:
            ASSIGN                                                                                            
              /*wdetail2.campens   =  ""   */   /*A66-0252*/
              /*wdetail2.producer  =  ""   */   /*A66-0252*/
              /*wdetail2.agent     =  ""    */  /*A66-0252*/
              wdetail2.memotext  =  ""      
              wdetail2.vatcode   =  "" 
              wdetail2.prempa    =  ""
              wdetail2.name02    =  ""  .
        END.
        /*-- ผู้รับผลประโยชน์ ----*/
        IF INDEX(wdetail2.financename,"cash") <> 0 THEN ASSIGN wdetail2.financename = "".
        IF wdetail2.financename <> "" THEN DO:
            FIND FIRST stat.insure USE-INDEX insure01  WHERE stat.insure.compno = "TPIS-LEAS"  AND 
                                     stat.insure.fname = wdetail2.financename   OR
                                     stat.insure.lname = wdetail2.financename   NO-LOCK NO-ERROR . 
             IF AVAIL stat.insure THEN
                 ASSIGN wdetail2.financename = stat.insure.addr1 + stat.insure.addr2.
             ELSE 
                 ASSIGN wdetail2.financename = "error : " + wdetail2.financename.
        END.
         /*Add by Kridtiya i. A63-0472*/
        /*IF TRIM(wdetail2.cust_type) = "J" THEN DO: /*A66-0252*/*/ /* ranu : 15/03/2024 */
        IF TRIM(wdetail2.cust_type) = "I" THEN DO:  /* ranu : 15/03/2024 */
          RUN proc_assign2addr (INPUT  wdetail2.mail_tambon   
                               ,INPUT  wdetail2.mail_amper   
                               ,INPUT  wdetail2.mail_country   
                               ,INPUT  wdetail2.occup   
                               ,OUTPUT wdetail2.codeocc  
                               ,OUTPUT wdetail2.codeaddr1
                               ,OUTPUT wdetail2.codeaddr2
                               ,OUTPUT wdetail2.codeaddr3).
         /* add by :A66-0252*/
        END.
        ELSE DO:
            RUN proc_assign2addr (INPUT  wdetail2.tambon  
                                 ,INPUT  wdetail2.amper  
                                 ,INPUT  wdetail2.country  
                                 ,INPUT  wdetail2.occup   
                                 ,OUTPUT wdetail2.codeocc  
                                 ,OUTPUT wdetail2.codeaddr1
                                 ,OUTPUT wdetail2.codeaddr2
                                 ,OUTPUT wdetail2.codeaddr3).

        END.
        /* end : A66-0252 */
        RUN proc_matchtypins (INPUT  trim(wdetail2.ntitle)                              
                             ,INPUT  trim(wdetail2.insnam)  + " " + TRIM(wdetail2.NAME2)
                             ,OUTPUT wdetail2.insnamtyp
                             ,OUTPUT wdetail2.firstName
                             ,OUTPUT wdetail2.lastName).

        
       /* comment by A61-0152.............
       IF wdetail2.CLASS = "210" THEN DO:
           wdetail2.baseprm = "14924".
        END.
        ELSE IF wdetail2.CLASS = "110" THEN DO:
            IF wdetail2.campaign = "MUX01" THEN DO:
                IF      (deci(wdetail2.si) >= 820000  ) AND (deci(wdetail2.si) <= 1000000 ) THEN  wdetail2.baseprm = "18900".
                ELSE IF (deci(wdetail2.si) >= 1100000 ) AND (deci(wdetail2.si) <= 1300000 ) THEN  wdetail2.baseprm = "19550".
            END.
            ELSE DO:
                wdetail2.baseprm = "15224".
            END.
        END.
        .... end A61-0152..........*/
    END.
END.
RUN Pro_assign3.
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

/*MESSAGE " assign2addr "  wdetail2.cust_type
        " cust = I " SKIP
        " mail_tambon  " wdetail2.mail_tambon   
        " mail_amper   " wdetail2.mail_amper   
        " mail_country " wdetail2.mail_country   
        " occup        " wdetail2.occup   
        " codeocc      " wdetail2.codeocc  
        " codeaddr1    " wdetail2.codeaddr1
        " codeaddr2    " wdetail2.codeaddr2
        " codeaddr3    " wdetail2.codeaddr3 SKIP
        " cust = J " SKIP
        " tambon       " wdetail2.tambon  
        " amper        " wdetail2.amper  
        " country      " wdetail2.country  
        " occup        " wdetail2.occup   
        " codeocc      " wdetail2.codeocc  
        " codeaddr1    " wdetail2.codeaddr1
        " codeaddr2    " wdetail2.codeaddr2
        " codeaddr3    " wdetail2.codeaddr3 SKIP
        " np_tambon      "  np_tambon       
        " np_mail_amper  "  np_mail_amper   
        " np_mail_country"  np_mail_country VIEW-AS ALERT-BOX.*/

/* A66-0252 */
IF      index(np_mail_country,"กรุงเทพ")   <> 0 THEN np_mail_country = "กรุงเทพมหานคร".
ELSE IF INDEX(np_mail_country,"กทม")       <> 0 THEN np_mail_country = "กรุงเทพมหานคร".
ELSE IF INDEX(np_mail_country,"อุบลฯ")     <> 0 THEN np_mail_country = "อุบลราชธานี".
ELSE IF INDEX(np_mail_country,"อุดรฯ")     <> 0 THEN np_mail_country = "อุดรธานี".
ELSE IF INDEX(np_mail_country,"ประจวบฯ")   <> 0 THEN np_mail_country = "ประจวบคีรีขันธ์".
ELSE IF INDEX(np_mail_country,"สุราษฯ")    <> 0 THEN np_mail_country = "สุราษฎร์ธานี".
ELSE IF INDEX(np_mail_country,"นครศรีฯ")   <> 0 THEN np_mail_country = "นครศรีธรรมราช".
ELSE IF INDEX(np_mail_country,"อยุธยา")    <> 0 THEN np_mail_country = "พระนครศรีอยุธยา".

FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE 
    INDEX(sicuw.uwm500.prov_d,np_mail_country) <> 0  OR /*A64-0035*/
    index(np_mail_country,sicuw.uwm500.prov_d) <> 0  NO-LOCK NO-ERROR.
IF AVAIL sicuw.uwm500 THEN DO: 
    ASSIGN np_codeaddr1 = trim(sicuw.uwm500.prov_n) .

    FIND LAST sicuw.uwm501 USE-INDEX uwm50102 WHERE 
              sicuw.uwm501.prov_n = sicuw.uwm500.prov_n AND 
              (INDEX(sicuw.uwm501.dist_d,np_mail_amper) <> 0  OR /*A65-0035*/
               INDEX(np_mail_amper,sicuw.uwm501.dist_d) <> 0  )  NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm501 THEN DO: 
        ASSIGN np_codeaddr2 = trim(sicuw.uwm501.dist_n) .

        FIND LAST sicuw.uwm506 USE-INDEX uwm50601 WHERE 
                  uwm506.prov_n = uwm500.prov_n AND
                  uwm506.dist_n = uwm501.dist_n AND 
                  (INDEX(trim(uwm506.sdist_d),np_tambon) <> 0  OR  /*A65-0035*/
                   INDEX(np_tambon,trim(uwm506.sdist_d)) <> 0  ) NO-LOCK NO-ERROR.
        IF AVAIL uwm506 THEN ASSIGN np_codeaddr3 = uwm506.sdist_n .
    END.
END.
/* end : A66-0252*/

/* comment by : A66-0252..
FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE 
    sicuw.uwm500.prov_d = np_mail_country  NO-LOCK NO-ERROR NO-WAIT.  /*"กาญจนบุรี"*/   /*uwm100.codeaddr1*/
IF AVAIL sicuw.uwm500 THEN DO:  
    /*DISP sicuw.uwm500.prov_n .*/
    ASSIGN np_codeaddr1 =  sicuw.uwm500.prov_n .  /*= uwm100.codeaddr1 */
            
    FIND LAST sicuw.uwm501 USE-INDEX uwm50102   WHERE 
        sicuw.uwm501.prov_n = sicuw.uwm500.prov_n  AND
        sicuw.uwm501.dist_d = np_mail_amper        NO-LOCK NO-ERROR NO-WAIT. /*"พนมทวน"*/
    IF AVAIL sicuw.uwm501 THEN DO:  
        ASSIGN np_codeaddr2 =  sicuw.uwm501.dist_n  . /*= uwm100.codeaddr2 */
        /*DISP
        sicuw.uwm501.prov_n  /* uwm100.codeaddr1 */
        sicuw.uwm501.dist_n  /* uwm100.codeaddr2 */ 
        . */
        FIND LAST sicuw.uwm506 USE-INDEX uwm50601 WHERE 
            sicuw.uwm506.prov_n   = sicuw.uwm501.prov_n and
            sicuw.uwm506.dist_n   = sicuw.uwm501.dist_n and
            sicuw.uwm506.sdist_d  = np_tambon           NO-LOCK NO-ERROR NO-WAIT. /*"รางหวาย"*/
        IF AVAIL sicuw.uwm506 THEN DO: 
            ASSIGN 
            np_codeaddr1 =  sicuw.uwm506.prov_n   /*= uwm100.codeaddr1 */
            np_codeaddr2 =  sicuw.uwm506.dist_n   /*= uwm100.codeaddr2 */
            np_codeaddr3 =  sicuw.uwm506.sdist_n . /*= uwm100.codeaddr3 */
        END.  
    END.
END.
..end A66-0252..*/
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
ASSIGN fi_process  = "Create data to wdetail TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
FOR EACH wdetail2 .
  ASSIGN np_70 = ""   np_72 = ""   n_len_c = 0     n_cha_no = ""     .     
  IF wdetail2.typ_work = "V"      THEN ASSIGN np_70 =  "V" + wdetail2.tpis_no      np_72 =  "" .
  ELSE IF wdetail2.typ_work = "C" THEN ASSIGN np_72 =  "C" + wdetail2.tpis_no      np_70 =  "" .
  ELSE IF wdetail2.typ_work = "V+C"   THEN ASSIGN np_70 =  "V" + wdetail2.tpis_no  np_72 =  "C" + wdetail2.tpis_no.
  ELSE ASSIGN np_70 =  ""   np_72 =  "" .
  ASSIGN n_rev = LENGTH(fi_filename)
    n_revday = SUBSTR(fi_filename,R-INDEX(fi_filename,"\"),n_rev).
  IF INDEX(n_revday,".csv") <> 0 THEN n_revday = trim(REPLACE(n_revday,".csv","")).
  IF INDEX(n_revday,"\") <> 0    THEN n_revday = trim(REPLACE(n_revday,"\","")).
  IF (R-INDEX(TRIM(n_titlenam),"จก.")          <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"จำกัด")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (R-INDEX(TRIM(n_titlenam),"(มหาชน)") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (R-INDEX(TRIM(n_titlenam),"INC.")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"CO.")     <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"LTD.")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"LIMITED") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"บริษัท")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"บ.")        <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"บจก.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (INDEX(TRIM(n_titlenam),"หจก.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"หสน.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (INDEX(TRIM(n_titlenam),"บรรษัท")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (INDEX(TRIM(n_titlenam),"มูลนิธิ")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้าง")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วน")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วนจำกัด") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วนจำก")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".   
  ELSE IF (INDEX(TRIM(n_titlenam),"และ/หรือ")          <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno        = "999" AND
      trim(brstat.msgcode.MsgDesc) = trim(wdetail2.ntitle)   NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL brstat.msgcode THEN ASSIGN wdetail2.ntitle  =  trim(brstat.msgcode.branch).
  ELSE DO:
      IF wdetail2.ntitle = ""  THEN ASSIGN wdetail2.ntitle = "คุณ" .
      ELSE ASSIGN  wdetail2.ntitle = TRIM(wdetail2.ntitle) .
  END.
  wdetail2.icno = TRIM(wdetail2.icno) .  
  IF trim(wdetail2.cust_type) = "J"  AND LENGTH(wdetail2.icno) < 13 THEN ASSIGN wdetail2.icno = "0" + TRIM(wdetail2.icno) . /*A61-0152*/
  IF np_70 <> "" THEN DO:
      FIND FIRST wdetail WHERE wdetail.policy = np_70 NO-ERROR NO-WAIT.
      IF NOT AVAIL wdetail THEN DO:
          CREATE wdetail.
          CREATE wuppertxt2. 
          ASSIGN                      /*policy line : 70       */
            n_len_c             = 0   
            n_cha_no            = ""  
            n_len_c             = length(trim(wdetail2.chasno))  
            wdetail.seat        = IF wdetail2.class = "110" THEN "7" ELSE IF wdetail2.class = "210" THEN "5" ELSE "3"  
            wdetail.seat41      = int(wdetail.seat)  /*A65-0156*/
            wdetail.brand       = TRIM(wdetail2.brand)
            wdetail.caryear     = TRIM(wdetail2.regis_year)    /*ปีรถ*/    /*A66-0252*/
            wdetail.poltyp      = "70"
            wdetail.policy      = np_70 
            wdetail.comdat      = TRIM(wdetail2.pol_comm_date) 
            wdetail.expdat      = TRIM(wdetail2.pol_exp_date)  
            wdetail.tiname      = trim(wdetail2.ntitle)                                
            wdetail.insnam      = trim(wdetail2.insnam)  + " " + TRIM(wdetail2.NAME2) 
            wdetail.insnamtyp   = trim(wdetail2.insnamtyp)    
            wdetail.firstName   = trim(wdetail2.firstName)    
            wdetail.lastName    = trim(wdetail2.lastName)     
            wdetail.codeocc     = trim(wdetail2.codeocc)      
            wdetail.codeaddr1   = trim(wdetail2.codeaddr1)    
            wdetail.codeaddr2   = trim(wdetail2.codeaddr2)    
            wdetail.codeaddr3   = trim(wdetail2.codeaddr3)    
            wdetail.br_insured  = "00000"                     
            wdetail.campaign_ov = trim(wdetail2.campaign_ov)  
            wdetail.ICNO        = trim(wdetail2.ICNO)         
            wdetail.name2       = wdetail2.dealer_name2 
            wdetail.iadd1       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.address)    else trim(wdetail2.mail_hno    )
            wdetail.iadd2       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.tambon )    else trim(wdetail2.mail_tambon )
            wdetail.iadd3       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.amper  )    else trim(wdetail2.mail_amper  )
            wdetail.iadd4       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.country)    else trim(wdetail2.mail_country)
            wdetail.postcd      = IF trim(wdetail2.cust_type) = "J" THEN trim(wdetail2.post)       ELSE trim(wdetail2.mail_post) 
            wdetail.subclass    = if length(wdetail2.class) > 3 THEN TRIM(substr(wdetail2.CLASS,2,3)) ELSE TRIM(wdetail2.CLASS)    /*A66-0252*/
            wdetail.prempa      = if length(wdetail2.class) > 3 THEN TRIM(substr(wdetail2.CLASS,1,1)) ELSE TRIM(wdetail2.prempa)   /*A66-0252*/
            wdetail.body        = ""  
            wdetail.model       = TRIM(wdetail2.model) 
            wdetail.cc          = TRIM(wdetail2.cc)
            wdetail.ton         = TRIM(wdetail2.ton) /*A61-0152*/
            wdetail.weight      = IF wdetail2.class = "320" THEN TRIM(wdetail2.cc) ELSE TRIM(wdetail2.ton)
            wdetail.chasno      = trim(wdetail2.chasno) 
            wdetail.vehreg      = IF LENGTH(wdetail2.chasno)  > 8 THEN "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 ) 
                                  ELSE "/" + trim(wdetail2.chasno)  /*A56-0245*/
            wdetail.engno       = TRIM(wdetail2.engno)  /*A58-0489*/
            wdetail.vehuse      = IF wdetail2.class = "320" THEN "2" ELSE "1" /*A65-0156*/
            wdetail.cargrp      = "3"   /*A61-0152*/
            wdetail.garage      = IF wdetail2.garage = "" THEN "G" ELSE IF index(wdetail2.garage,"ห้าง") <> 0 THEN "G" 
                                  ELSE IF index(wdetail2.garage,"อะไหล่แท้") <> 0 THEN "P" ELSE ""  /*a62-0422 */
            wdetail.accdata     = TRIM(Wdetail2.Acc_CV)      
            wdetail.accamount   = TRIM(Wdetail2.Acc_amount)  
            wdetail.stk         = trim(wdetail2.com_no)
            wdetail.covcod      = TRIM(wdetail2.cover)
            wdetail.si          = TRIM(wdetail2.si)
            wdetail.branch      = wdetail2.branch 
            wdetail.benname     = wdetail2.financename
            wdetail.volprem     = trim(wdetail2.pol_netprem)
            wdetail.comment     = ""
            wdetail.finint      = wdetail2.delerco
            wdetail.financecd   = wdetail2.financecd       /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
            wdetail.agent       = wdetail2.agent     
            wdetail.producer    = wdetail2.producer 
            wdetail.entdat      = string(TODAY)      /*entry date*/
            wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
            wdetail.trandat     = STRING (TODAY)     /*tran date*/
            wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
            wdetail.n_IMPORT    = "IM"
            wdetail.n_EXPORT    = "" 
            wdetail.inscod      = TRIM(wdetail2.typepay)    /*add Kridtiya i. A53-0183 ...vatcode*/
            wdetail.cedpol      = TRIM(wdetail2.tpis_no)    /*A58-0489*/
            wdetail.remark1     = TRIM(wdetail2.remark1)           /*A58-0489*/
            wdetail.occupn      = TRIM(wdetail2.occup)           /*A58-0489*/
            wdetail.revday      = TRIM(n_revday) 
            wdetail.memo        = TRIM(wdetail2.np_f18line1) /*A61-0152*/
            wdetail.campens     = TRIM(wdetail2.campens)   /*A61-0152*/
            /*wdetail.campens     = IF INDEX(wdetail2.campens,"/") <> 0 THEN TRIM(REPLACE(wdetail2.campens,"/","_")) ELSE TRIM(wdetail2.campens) /*A61-0152*/ */ /*A65-0156*/ 
            wdetail.memotext    = TRIM(wdetail2.memotext)
            wdetail.vatcode     = TRIM(wdetail2.vatcode)
            wdetail.name02      = TRIM(wdetail2.name02)
            wdetail.baseprem    = DECI(wdetail2.baseprm)
            wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE "" 
            wdetail.promotion   = IF wdetail2.producer = "B3M0018" OR wdetail2.producer = "B3M0031" THEN wdetail2.claimdi ELSE ""   /*A63-0209*/
            wdetail.product     = IF wdetail2.producer = "B3M0018" OR wdetail2.producer = "B3M0031" THEN wdetail2.product ELSE ""   /*A63-0209*/
            wdetail.colors      = wdetail2.coulor  /*A66-0252*/
            wdetail.memo2       = if wdetail2.np_f18line3 <> "" then wdetail2.np_f18line3 else nv_memo1  /*A66-0252*/
            wdetail.memo3       = if wdetail2.np_f18line4 <> "" then wdetail2.np_f18line4 else nv_memo2  /*A66-0252*/
            wdetail.memo4       = if wdetail2.np_f18line5 <> "" then wdetail2.np_f18line5 else nv_memo3   /*A66-0252*/ 
            wdetail.Driver1_title        =   wdetail2.Driver1_title          
            wdetail.Driver1_name         =   wdetail2.Driver1_name           
            wdetail.Driver1_lastname     =   wdetail2.Driver1_lastname       
            wdetail.Driver1_birthdate    =   wdetail2.Driver1_birthdate      
            wdetail.Driver1_id_no        =   wdetail2.Driver1_id_no          
            wdetail.Driver1_license_no   =   wdetail2.Driver1_license_no     
            wdetail.Driver1_occupation   =   wdetail2.Driver1_occupation     
            wdetail.Driver2_title        =   wdetail2.Driver2_title          
            wdetail.Driver2_name         =   wdetail2.Driver2_name           
            wdetail.Driver2_lastname     =   wdetail2.Driver2_lastname       
            wdetail.Driver2_birthdate    =   wdetail2.Driver2_birthdate      
            wdetail.Driver2_id_no        =   wdetail2.Driver2_id_no          
            wdetail.Driver2_license_no   =   wdetail2.Driver2_license_no     
            wdetail.Driver2_occupation   =   wdetail2.Driver2_occupation     
            wdetail.Driver3_title        =   wdetail2.Driver3_title          
            wdetail.Driver3_name         =   wdetail2.Driver3_name           
            wdetail.Driver3_lastname     =   wdetail2.Driver3_lastname       
            wdetail.Driver3_birthdate     =   wdetail2.Driver3_birthday       
            wdetail.Driver3_id_no        =   wdetail2.Driver3_id_no          
            wdetail.Driver3_license_no   =   wdetail2.Driver3_license_no     
            wdetail.Driver3_occupation   =   wdetail2.Driver3_occupation     
            wdetail.Driver4_title        =   wdetail2.Driver4_title          
            wdetail.Driver4_name         =   wdetail2.Driver4_name           
            wdetail.Driver4_lastname     =   wdetail2.Driver4_lastname       
            wdetail.Driver4_birthdate    =   wdetail2.Driver4_birthdate      
            wdetail.Driver4_id_no        =   wdetail2.Driver4_id_no          
            wdetail.Driver4_license_no   =   wdetail2.Driver4_license_no     
            wdetail.Driver4_occupation   =   wdetail2.Driver4_occupation     
            wdetail.Driver5_title        =   wdetail2.Driver5_title          
            wdetail.Driver5_name         =   wdetail2.Driver5_name           
            wdetail.Driver5_lastname     =   wdetail2.Driver5_lastname       
            wdetail.Driver5_birthdate    =   wdetail2.Driver5_birthdate      
            wdetail.Driver5_id_no        =   wdetail2.Driver5_id_no          
            wdetail.Driver5_license_no   =   wdetail2.Driver5_license_no     
            wdetail.Driver5_occupation   =   wdetail2.Driver5_occupation . 

          IF wdetail.occup <> "" THEN DO:
            FIND FIRST stat.msgcode USE-INDEX MsgCode01 WHERE stat.msgcode.CompNo = "999" AND 
                stat.msgcode.MsgNo  = wdetail.occupn NO-LOCK NO-ERROR.
            IF AVAIL stat.msgcode THEN
                ASSIGN wdetail.occupn = stat.msgcode.MsgDesc.
            ELSE ASSIGN wdetail.occupn = "".
          END.
          IF trim(wdetail2.chasno) <> "" AND INDEX(wdetail2.typ_work,"V") <> 0 THEN DO:  
            FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail2.chasno)) AND 
              sicuw.uwm301.tariff = "X" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                ASSIGN  wdetail.WARNING  = "มีกรมธรรม์ในระบบแล้ว "  
                    wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เคยมีการออกงานแล้ว " + sicuw.uwm301.policy
                    wdetail.pass     = "Y".
            END.
          END.
      END.
  END.
  IF np_72 <> "" THEN DO:  
      RUN proc_assign3_np72.
  END.  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign3bk C-Win 
PROCEDURE proc_assign3bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A66-0252      
----------------------------------------------------*/
/*
DEFINE VAR n_len_c AS INTE INIT 0.                  
DEFINE VAR n_cha_no AS CHAR FORMAT "x(25)" INIT "". 
DEF VAR np_70 AS CHAR FORMAT "x(15)" INIT "".       
DEF VAR np_72 AS CHAR FORMAT "x(15)" INIT "".       
ASSIGN fi_process  = "Create data to wdetail TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
FOR EACH wdetail2 .
  ASSIGN np_70 = ""   np_72 = ""  .     
  IF wdetail2.typ_work = "V"      THEN ASSIGN np_70 =  "V" + wdetail2.tpis_no      np_72 =  "" .
  ELSE IF wdetail2.typ_work = "C" THEN ASSIGN np_72 =  "C" + wdetail2.tpis_no      np_70 =  "" .
  ELSE IF wdetail2.typ_work = "V+C"   THEN ASSIGN np_70 =  "V" + wdetail2.tpis_no  np_72 =  "C" + wdetail2.tpis_no.
  ELSE ASSIGN np_70 =  ""   np_72 =  "" .
  ASSIGN n_rev = LENGTH(fi_filename)
    n_revday = SUBSTR(fi_filename,R-INDEX(fi_filename,"\"),n_rev).
  IF INDEX(n_revday,".csv") <> 0 THEN n_revday = trim(REPLACE(n_revday,".csv","")).
  IF INDEX(n_revday,"\") <> 0    THEN n_revday = trim(REPLACE(n_revday,"\","")).
  IF (R-INDEX(TRIM(n_titlenam),"จก.")          <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"จำกัด")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (R-INDEX(TRIM(n_titlenam),"(มหาชน)") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (R-INDEX(TRIM(n_titlenam),"INC.")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"CO.")     <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"LTD.")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (R-INDEX(TRIM(n_titlenam),"LIMITED") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"บริษัท")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"บ.")        <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"บจก.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (INDEX(TRIM(n_titlenam),"หจก.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"หสน.")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (INDEX(TRIM(n_titlenam),"บรรษัท")    <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (INDEX(TRIM(n_titlenam),"มูลนิธิ")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้าง")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วน")      <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".  
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วนจำกัด") <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")". 
  ELSE IF (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วนจำก")   <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".   
  ELSE IF (INDEX(TRIM(n_titlenam),"และ/หรือ")          <> 0 ) THEN ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".
  FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno        = "999" AND
      trim(brstat.msgcode.MsgDesc) = trim(wdetail2.ntitle)   NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL brstat.msgcode THEN ASSIGN wdetail2.ntitle  =  trim(brstat.msgcode.branch).
  ELSE DO:
      IF wdetail2.ntitle = ""  THEN ASSIGN wdetail2.ntitle = "คุณ" .
      ELSE ASSIGN  wdetail2.ntitle = TRIM(wdetail2.ntitle) .
  END.
  wdetail2.icno = TRIM(wdetail2.icno) .  
  IF trim(wdetail2.cust_type) = "J"  AND LENGTH(wdetail2.icno) < 13 THEN ASSIGN wdetail2.icno = "0" + TRIM(wdetail2.icno) . /*A61-0152*/
  IF np_70 <> "" THEN DO:
      FIND FIRST wdetail WHERE wdetail.policy = np_70 NO-ERROR NO-WAIT.
      IF NOT AVAIL wdetail THEN DO:
          CREATE wdetail.
          CREATE wuppertxt2. 
          ASSIGN                      /*policy line : 70       */
            n_len_c             = 0   
            n_cha_no            = ""  
            n_len_c             = length(trim(wdetail2.chasno))  
            wdetail.seat        = IF wdetail2.class = "110" THEN "7" ELSE IF wdetail2.class = "210" THEN "5" ELSE "3"  
            wdetail.seat41      = int(wdetail.seat)  /*A65-0156*/
            wdetail.brand       = TRIM(wdetail2.brand)
            wdetail.caryear     = TRIM(wdetail2.regis_year)    /*ปีรถ*/    /*A66-0252*/
            wdetail.poltyp      = "70"
            wdetail.policy      = np_70 
            wdetail.comdat      = TRIM(wdetail2.pol_comm_date) 
            wdetail.expdat      = TRIM(wdetail2.pol_exp_date)  
            wdetail.tiname      = trim(wdetail2.ntitle)                                
            wdetail.insnam      = trim(wdetail2.insnam)  + " " + TRIM(wdetail2.NAME2) 
            wdetail.insnamtyp   = trim(wdetail2.insnamtyp)    
            wdetail.firstName   = trim(wdetail2.firstName)    
            wdetail.lastName    = trim(wdetail2.lastName)     
            wdetail.codeocc     = trim(wdetail2.codeocc)      
            wdetail.codeaddr1   = trim(wdetail2.codeaddr1)    
            wdetail.codeaddr2   = trim(wdetail2.codeaddr2)    
            wdetail.codeaddr3   = trim(wdetail2.codeaddr3)    
            wdetail.br_insured  = "00000"                     
            wdetail.campaign_ov = trim(wdetail2.campaign_ov)  
            wdetail.ICNO        = trim(wdetail2.ICNO)         
            wdetail.name2       = wdetail2.dealer_name2 
            wdetail.iadd1       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.address)    else trim(wdetail2.mail_hno    )
            wdetail.iadd2       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.tambon )    else trim(wdetail2.mail_tambon )
            wdetail.iadd3       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.amper  )    else trim(wdetail2.mail_amper  )
            wdetail.iadd4       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.country)    else trim(wdetail2.mail_country)
            wdetail.postcd      = IF trim(wdetail2.cust_type) = "J" THEN trim(wdetail2.post)       ELSE trim(wdetail2.mail_post) 
            wdetail.subclass    = if length(wdetail2.class) > 3 THEN TRIM(substr(wdetail2.CLASS,2,3)) ELSE TRIM(wdetail2.CLASS)    /*A66-0252*/
            wdetail.prempa      = if length(wdetail2.class) > 3 THEN TRIM(substr(wdetail2.CLASS,1,1)) ELSE TRIM(wdetail2.prempa)   /*A66-0252*/
            wdetail.body        = ""  
            wdetail.model       = TRIM(wdetail2.model) 
            wdetail.cc          = TRIM(wdetail2.cc)
            wdetail.ton         = TRIM(wdetail2.ton) /*A61-0152*/
            wdetail.weight      = IF wdetail2.class = "320" THEN TRIM(wdetail2.cc) ELSE TRIM(wdetail2.ton)
            wdetail.chasno      = trim(wdetail2.chasno) 
            wdetail.vehreg      = IF LENGTH(wdetail2.chasno)  > 8 THEN "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 ) 
                                  ELSE "/" + trim(wdetail2.chasno)  /*A56-0245*/
            wdetail.engno       = TRIM(wdetail2.engno)  /*A58-0489*/
            wdetail.vehuse      = IF wdetail2.class = "320" THEN "2" ELSE "1" /*A65-0156*/
            wdetail.cargrp      = "3"   /*A61-0152*/
            wdetail.garage      = IF wdetail2.garage = "" THEN "G" ELSE IF index(wdetail2.garage,"ห้าง") <> 0 THEN "G" 
                                  ELSE IF index(wdetail2.garage,"อะไหล่แท้") <> 0 THEN "P" ELSE ""  /*a62-0422 */
            wdetail.accdata     = TRIM(Wdetail2.Acc_CV)      
            wdetail.accamount   = TRIM(Wdetail2.Acc_amount)  
            wdetail.stk         = trim(wdetail2.com_no)
            wdetail.covcod      = TRIM(wdetail2.cover)
            wdetail.si          = TRIM(wdetail2.si)
            wdetail.branch      = wdetail2.branch 
            wdetail.benname     = wdetail2.financename
            wdetail.volprem     = trim(wdetail2.pol_netprem)
            wdetail.comment     = ""
            wdetail.finint      = wdetail2.delerco
            wdetail.financecd   = wdetail2.financecd       /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
            wdetail.agent       = wdetail2.agent     
            wdetail.producer    = wdetail2.producer 
            wdetail.entdat      = string(TODAY)      /*entry date*/
            wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
            wdetail.trandat     = STRING (TODAY)     /*tran date*/
            wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
            wdetail.n_IMPORT    = "IM"
            wdetail.n_EXPORT    = "" 
            wdetail.inscod      = TRIM(wdetail2.typepay)    /*add Kridtiya i. A53-0183 ...vatcode*/
            wdetail.cedpol      = TRIM(wdetail2.tpis_no)    /*A58-0489*/
            wdetail.remark1     = TRIM(wdetail2.remark1)           /*A58-0489*/
            wdetail.occupn      = TRIM(wdetail2.occup)           /*A58-0489*/
            wdetail.revday      = TRIM(n_revday) 
            wdetail.memo        = TRIM(wdetail2.np_f18line1) /*A61-0152*/
            wdetail.campens     = TRIM(wdetail2.campens)   /*A61-0152*/
            /*wdetail.campens     = IF INDEX(wdetail2.campens,"/") <> 0 THEN TRIM(REPLACE(wdetail2.campens,"/","_")) ELSE TRIM(wdetail2.campens) /*A61-0152*/ */ /*A65-0156*/ 
            wdetail.memotext    = TRIM(wdetail2.memotext)
            wdetail.vatcode     = TRIM(wdetail2.vatcode)
            wdetail.name02      = TRIM(wdetail2.name02)
            wdetail.baseprem    = DECI(wdetail2.baseprm)
            wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE "" 
            wdetail.promotion   = IF wdetail2.producer = "B3M0018" OR wdetail2.producer = "B3M0031" THEN wdetail2.claimdi ELSE ""   /*A63-0209*/
            wdetail.product     = IF wdetail2.producer = "B3M0018" OR wdetail2.producer = "B3M0031" THEN wdetail2.product ELSE ""   /*A63-0209*/
            wdetail.colors      = wdetail2.coulor  /*A66-0252*/
            wdetail.memo2       = if wdetail2.np_f18line3 <> "" then wdetail2.np_f18line3 else nv_memo1  /*A66-0252*/
            wdetail.memo3       = if wdetail2.np_f18line4 <> "" then wdetail2.np_f18line4 else nv_memo2  /*A66-0252*/
            wdetail.memo4       = if wdetail2.np_f18line5 <> "" then wdetail2.np_f18line5 else nv_memo3 .  /*A66-0252*/ 

          IF wdetail.occup <> "" THEN DO:
            FIND FIRST stat.msgcode USE-INDEX MsgCode01 WHERE stat.msgcode.CompNo = "999" AND 
                stat.msgcode.MsgNo  = wdetail.occupn NO-LOCK NO-ERROR.
            IF AVAIL stat.msgcode THEN
                ASSIGN wdetail.occupn = stat.msgcode.MsgDesc.
            ELSE ASSIGN wdetail.occupn = "".
          END.
          IF trim(wdetail2.chasno) <> "" AND INDEX(wdetail2.typ_work,"V") <> 0 THEN DO:  
            FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail2.chasno)) AND 
              sicuw.uwm301.tariff = "X" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                ASSIGN  wdetail.WARNING  = "มีกรมธรรม์ในระบบแล้ว "  
                    wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เคยมีการออกงานแล้ว " + sicuw.uwm301.policy
                    wdetail.pass     = "Y".
            END.
          END.
      END.
  END.
  IF np_72 <> "" THEN DO:           
    FIND FIRST wdetail WHERE wdetail.policy = np_72 NO-ERROR NO-WAIT.
    IF NOT AVAIL wdetail THEN DO:
      CREATE wdetail.
      CREATE wuppertxt2.
      ASSIGN
        n_len_c             = 0   /*kridtiya i. A53-0317...*/
        n_cha_no            = ""  /*kridtiya i. A53-0317...*/
        n_len_c             = length(trim(wdetail2.chasno))  /*kridtiya i. A53-0317...*/
        wdetail.seat        = IF wdetail2.class = "110" THEN "7" ELSE IF wdetail2.class = "210" THEN "5" ELSE "3"  /*IF wdetail2.vehuse = "เก๋ง" THEN "7" ELSE "5"*/
        wdetail.seat41      = INT(wdetail.seat)  /*A65-0156*/
        wdetail.brand       = TRIM(wdetail2.brand)
        /*wdetail.caryear     = TRIM(wdetail2.md_year)  */  /*ปีรถ*/   /*A66-0252*/
        wdetail.caryear     = TRIM(wdetail2.regis_year)    /*ปีรถ*/    /*A66-0252*/
        wdetail.poltyp      = "72"   
        wdetail.policy      = np_72
        wuppertxt2.policydup = np_72
        wdetail.comdat      = TRIM(wdetail2.com_comm_date)     
        wdetail.expdat      = TRIM(wdetail2.com_exp_date)   
        wdetail.tiname      = trim(wdetail2.ntitle)       /*A57-0159*/
        wdetail.insnam      = trim(wdetail2.insnam)  + " " + trim(wdetail2.NAME2)  /*A54-0200*/
        wdetail.insnamtyp   = trim(wdetail2.insnamtyp)     /*Add by Kridtiya i. A63-0472*/
        wdetail.firstName   = trim(wdetail2.firstName)     /*Add by Kridtiya i. A63-0472*/
        wdetail.lastName    = trim(wdetail2.lastName)      /*Add by Kridtiya i. A63-0472*/
        /*wdetail.postcd      = trim(wdetail2.mail_post)*/     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeocc     = trim(wdetail2.codeocc)       /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr1   = trim(wdetail2.codeaddr1)     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr2   = trim(wdetail2.codeaddr2)     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr3   = trim(wdetail2.codeaddr3)     /*Add by Kridtiya i. A63-0472*/
        wdetail.br_insured  = "00000"                      /*Add by Kridtiya i. A63-0472*/
        wdetail.campaign_ov = trim(wdetail2.campaign_ov)   /*Add by Kridtiya i. A63-0472*/
        wdetail.ICNO        = TRIM(wdetail2.ICNO)         /*A56-0211*/
        wdetail.name2       = wdetail2.dealer_name2 
        wdetail.iadd1       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.address)    else trim(wdetail2.mail_hno    )
        wdetail.iadd2       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.tambon )    else trim(wdetail2.mail_tambon )
        wdetail.iadd3       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.amper  )    else trim(wdetail2.mail_amper  )
        wdetail.iadd4       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.country)    else trim(wdetail2.mail_country)
        wdetail.postcd      = IF trim(wdetail2.cust_type) = "J" THEN trim(wdetail2.post)       ELSE trim(wdetail2.mail_post) 
        /*wdetail.subclass    = TRIM(wdetail2.class)*/
        wdetail.subclass    = IF deci(wdetail2.com_netprem) = 600 THEN "110" ELSE IF deci(wdetail2.com_netprem) = 900 THEN "210" ELSE "320" /*A63-00336*/
        wdetail.body        = "" /*TRIM(wdetail2.vehuse)*/     
        wdetail.model       = trim(wdetail2.model)
        wdetail.cc          = TRIM(wdetail2.cc)
        wdetail.ton         = TRIM(wdetail2.ton) /*A61-0152*/
        wdetail.chasno      = trim(wdetail2.chasno)  
        wdetail.vehreg      = IF LENGTH(wdetail2.chasno)  > 8 THEN "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 ) 
                              ELSE "/" + trim(wdetail2.chasno)  
        wdetail.engno       = TRIM(wdetail2.engno)  
        /*wdetail.vehuse      = "1"*/ /*A65-0156*/
        wdetail.vehuse      = IF wdetail.subclass = "320" THEN "2" ELSE "1"  /*A65-0156*/
        wdetail.garage      = ""
        wdetail.cargrp      = "3"   /*A61-0152*/
        wdetail.covcod      = "T"
        wdetail.stk         = trim(wdetail2.com_no)
        wuppertxt2.stk      = trim(wdetail2.com_no)
        wdetail.si          = wdetail2.si
        /*wdetail.prempa      = fi_pack */ /*A61-0152*/
        wdetail.prempa      = wdetail2.prempa   /*A61-0152*/
        wdetail.branch      = wdetail2.branch 
        wdetail.benname     = ""
        wdetail.volprem     = trim(wdetail2.com_netprem)
        wdetail.comment     = ""
        wdetail.finint      = wdetail2.delerco
        wdetail.financecd   = wdetail2.financecd  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.agent       = wdetail2.agent
        wdetail.producer    = wdetail2.producer 
        wdetail.entdat      = string(TODAY)      /*entry date*/
        wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat     = STRING (TODAY)     /*tran date*/
        wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT    = "IM"
        wdetail.n_EXPORT    = "" 
        wdetail.inscod      = wdetail2.typepay    /*add Kridtiya i. A53-0183 ...vatcode*/
        wdetail.cedpol      = TRIM(wdetail2.tpis_no)    /*A58-0489*/
        /*wdetail.remark1     = TRIM(wdetail2.remark1)   A58-0489*/
        wdetail.occupn      = TRIM(wdetail2.occup)     /*A58-0489*/
        wdetail.revday      = TRIM(n_revday) 
        wdetail.memo        = TRIM(wdetail2.np_f18line1) /*A61-0152*/
        /*wdetail.campens     = TRIM(wdetail2.campens) */ /*A61-0152*/
        wdetail.campens     = IF INDEX(wdetail2.campens,"/") <> 0 THEN TRIM(REPLACE(wdetail2.campens,"/","_")) ELSE TRIM(wdetail2.campens) /*A61-0152*/      
        wdetail.memotext    = TRIM(wdetail2.memotext)     
        wdetail.vatcode     = TRIM(wdetail2.vatcode)      
        wdetail.name02      = TRIM(wdetail2.name02)
        wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE "" 
        wdetail.colors      = wdetail2.coulor  /*A66-0252*/
        wdetail.memo2       = if wdetail2.np_f18line3 <> "" then wdetail2.np_f18line3 else nv_memo1  /*A66-0252*/
        wdetail.memo3       = if wdetail2.np_f18line4 <> "" then wdetail2.np_f18line4 else nv_memo2  /*A66-0252*/
        wdetail.memo4       = if wdetail2.np_f18line5 <> "" then wdetail2.np_f18line5 else nv_memo3 . /*A66-0252*/ 

      IF wdetail.occup <> "" THEN DO:
        FIND FIRST stat.msgcode USE-INDEX MsgCode01 WHERE stat.msgcode.CompNo = "999"         AND 
          stat.msgcode.MsgNo  = wdetail.occupn NO-LOCK NO-ERROR.
        IF AVAIL stat.msgcode THEN
            ASSIGN wdetail.occupn = stat.msgcode.MsgDesc.
        ELSE ASSIGN wdetail.occupn = "".
      END.
      IF trim(wdetail2.chasno) <> "" AND INDEX(wdetail2.typ_work,"C") <> 0 THEN DO:  
          FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail2.chasno)) AND 
              sicuw.uwm301.tariff = "9" NO-LOCK  NO-ERROR NO-WAIT.
          IF AVAIL sicuw.uwm301 THEN DO:
              ASSIGN  wdetail.WARNING  = "มีกรมธรรม์ พรบ.ในระบบแล้ว "  
                  wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เคยมีการออกงานแล้ว " + sicuw.uwm301.policy
                  wdetail.pass     = "Y".
          END.
      END.
    END.   /*avail 1*/  
  END.  
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign3_np72 C-Win 
PROCEDURE proc_assign3_np72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.policy = np_72 NO-ERROR NO-WAIT.
    IF NOT AVAIL wdetail THEN DO:
      CREATE wdetail.
      CREATE wuppertxt2.
      ASSIGN
        n_len_c             = 0   /*kridtiya i. A53-0317...*/
        n_cha_no            = ""  /*kridtiya i. A53-0317...*/
        n_len_c             = length(trim(wdetail2.chasno))  /*kridtiya i. A53-0317...*/
        wdetail.seat        = IF wdetail2.class = "110" THEN "7" ELSE IF wdetail2.class = "210" THEN "5" ELSE "3"  /*IF wdetail2.vehuse = "เก๋ง" THEN "7" ELSE "5"*/
        wdetail.seat41      = INT(wdetail.seat)  /*A65-0156*/
        wdetail.brand       = TRIM(wdetail2.brand)
        /*wdetail.caryear     = TRIM(wdetail2.md_year)  */  /*ปีรถ*/   /*A66-0252*/
        wdetail.caryear     = TRIM(wdetail2.regis_year)    /*ปีรถ*/    /*A66-0252*/
        wdetail.poltyp      = "72"   
        wdetail.policy      = np_72
        wuppertxt2.policydup = np_72
        wdetail.comdat      = TRIM(wdetail2.com_comm_date)     
        wdetail.expdat      = TRIM(wdetail2.com_exp_date)   
        wdetail.tiname      = trim(wdetail2.ntitle)       /*A57-0159*/
        wdetail.insnam      = trim(wdetail2.insnam)  + " " + trim(wdetail2.NAME2)  /*A54-0200*/
        wdetail.insnamtyp   = trim(wdetail2.insnamtyp)     /*Add by Kridtiya i. A63-0472*/
        wdetail.firstName   = trim(wdetail2.firstName)     /*Add by Kridtiya i. A63-0472*/
        wdetail.lastName    = trim(wdetail2.lastName)      /*Add by Kridtiya i. A63-0472*/
        /*wdetail.postcd      = trim(wdetail2.mail_post)*/     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeocc     = trim(wdetail2.codeocc)       /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr1   = trim(wdetail2.codeaddr1)     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr2   = trim(wdetail2.codeaddr2)     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr3   = trim(wdetail2.codeaddr3)     /*Add by Kridtiya i. A63-0472*/
        wdetail.br_insured  = "00000"                      /*Add by Kridtiya i. A63-0472*/
        wdetail.campaign_ov = trim(wdetail2.campaign_ov)   /*Add by Kridtiya i. A63-0472*/
        wdetail.ICNO        = TRIM(wdetail2.ICNO)         /*A56-0211*/
        wdetail.name2       = wdetail2.dealer_name2 
        wdetail.iadd1       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.address)    else trim(wdetail2.mail_hno    )
        wdetail.iadd2       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.tambon )    else trim(wdetail2.mail_tambon )
        wdetail.iadd3       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.amper  )    else trim(wdetail2.mail_amper  )
        wdetail.iadd4       = if trim(wdetail2.cust_type) = "J" then trim(wdetail2.country)    else trim(wdetail2.mail_country)
        wdetail.postcd      = IF trim(wdetail2.cust_type) = "J" THEN trim(wdetail2.post)       ELSE trim(wdetail2.mail_post) 
        /*wdetail.subclass    = TRIM(wdetail2.class)*/
        wdetail.subclass    = IF deci(wdetail2.com_netprem) = 600 THEN "110" ELSE IF deci(wdetail2.com_netprem) = 900 THEN "210" ELSE "320" /*A63-00336*/
        wdetail.body        = "" /*TRIM(wdetail2.vehuse)*/     
        wdetail.model       = trim(wdetail2.model)
        wdetail.cc          = TRIM(wdetail2.cc)
        wdetail.ton         = TRIM(wdetail2.ton) /*A61-0152*/
        wdetail.chasno      = trim(wdetail2.chasno)  
        wdetail.vehreg      = IF LENGTH(wdetail2.chasno)  > 8 THEN "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 ) 
                              ELSE "/" + trim(wdetail2.chasno)  
        wdetail.engno       = TRIM(wdetail2.engno)  
        /*wdetail.vehuse      = "1"*/ /*A65-0156*/
        wdetail.vehuse      = IF wdetail.subclass = "320" THEN "2" ELSE "1"  /*A65-0156*/
        wdetail.garage      = ""
        wdetail.cargrp      = "3"   /*A61-0152*/
        wdetail.covcod      = "T"
        wdetail.stk         = trim(wdetail2.com_no)
        wuppertxt2.stk      = trim(wdetail2.com_no)
        wdetail.si          = wdetail2.si
        /*wdetail.prempa      = fi_pack */ /*A61-0152*/
        wdetail.prempa      = wdetail2.prempa   /*A61-0152*/
        wdetail.branch      = wdetail2.branch 
        wdetail.benname     = ""
        wdetail.volprem     = trim(wdetail2.com_netprem)
        wdetail.comment     = ""
        wdetail.finint      = wdetail2.delerco
        wdetail.financecd   = wdetail2.financecd  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.agent       = wdetail2.agent
        wdetail.producer    = wdetail2.producer 
        wdetail.entdat      = string(TODAY)      /*entry date*/
        wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat     = STRING (TODAY)     /*tran date*/
        wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT    = "IM"
        wdetail.n_EXPORT    = "" 
        wdetail.inscod      = wdetail2.typepay    /*add Kridtiya i. A53-0183 ...vatcode*/
        wdetail.cedpol      = TRIM(wdetail2.tpis_no)    /*A58-0489*/
        /*wdetail.remark1     = TRIM(wdetail2.remark1)   A58-0489*/
        wdetail.occupn      = TRIM(wdetail2.occup)     /*A58-0489*/
        wdetail.revday      = TRIM(n_revday) 
        wdetail.memo        = TRIM(wdetail2.np_f18line1) /*A61-0152*/
        /*wdetail.campens     = TRIM(wdetail2.campens) */ /*A61-0152*/
        wdetail.campens     = IF INDEX(wdetail2.campens,"/") <> 0 THEN TRIM(REPLACE(wdetail2.campens,"/","_")) ELSE TRIM(wdetail2.campens) /*A61-0152*/      
        wdetail.memotext    = TRIM(wdetail2.memotext)     
        wdetail.vatcode     = TRIM(wdetail2.vatcode)      
        wdetail.name02      = TRIM(wdetail2.name02)
        wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE "" 
        wdetail.colors      = wdetail2.coulor  /*A66-0252*/
        wdetail.memo2       = if wdetail2.np_f18line3 <> "" then wdetail2.np_f18line3 else nv_memo1  /*A66-0252*/
        wdetail.memo3       = if wdetail2.np_f18line4 <> "" then wdetail2.np_f18line4 else nv_memo2  /*A66-0252*/
        wdetail.memo4       = if wdetail2.np_f18line5 <> "" then wdetail2.np_f18line5 else nv_memo3 . /*A66-0252*/ 

      IF wdetail.occup <> "" THEN DO:
        FIND FIRST stat.msgcode USE-INDEX MsgCode01 WHERE stat.msgcode.CompNo = "999"         AND 
          stat.msgcode.MsgNo  = wdetail.occupn NO-LOCK NO-ERROR.
        IF AVAIL stat.msgcode THEN
            ASSIGN wdetail.occupn = stat.msgcode.MsgDesc.
        ELSE ASSIGN wdetail.occupn = "".
      END.
      IF trim(wdetail2.chasno) <> "" AND INDEX(wdetail2.typ_work,"C") <> 0 THEN DO:  
          FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail2.chasno)) AND 
              sicuw.uwm301.tariff = "9" NO-LOCK  NO-ERROR NO-WAIT.
          IF AVAIL sicuw.uwm301 THEN DO:
              ASSIGN  wdetail.WARNING  = "มีกรมธรรม์ พรบ.ในระบบแล้ว "  
                  wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เคยมีการออกงานแล้ว " + sicuw.uwm301.policy
                  wdetail.pass     = "Y".
          END.
      END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignnew C-Win 
PROCEDURE proc_assignnew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A62-0422 (form new)      
------------------------------------------------------------------------------*/
DEF BUFFER bfwdetail2 FOR wdetail2. /*A62-0422*/
ASSIGN fi_process  = "Create data to workfile TAS/TPIB.......[ISUZU]" .  
DISP  fi_process WITH FRAM fr_main.

ASSIGN nv_memo1 = ""
       nv_memo2 = ""
       nv_memo3 = "" .

INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail2.
    IMPORT DELIMITER "|"    
        Wdetail2.ins_ytyp          
        wdetail2.bus_typ           
        wdetail2.TASreceived          
        wdetail2.InsCompany           
        wdetail2.Insurancerefno       
        wdetail2.tpis_no
        wdetail2.ntitle             
        wdetail2.insnam               
        wdetail2.NAME2                
        wdetail2.cust_type
        wdetail2.nDirec               
        wdetail2.ICNO                 
        wdetail2.address              
        wdetail2.build
        wdetail2.mu                   
        wdetail2.soi                  
        wdetail2.road                 
        wdetail2.tambon               
        wdetail2.amper                
        wdetail2.country              
        wdetail2.post                 
        wdetail2.brand             
        wdetail2.model                
        wdetail2.class
        wdetail2.md_year
        wdetail2.Usage              
        wdetail2.coulor               
        wdetail2.cc                   
        wdetail2.regis_year     
        wdetail2.engno                
        wdetail2.chasno               
        Wdetail2.Acc_CV            
        Wdetail2.Acc_amount        
        wdetail2.License
        wdetail2.regis_CL
        wdetail2.campaign
        wdetail2.typ_work
        wdetail2.garage     /*a62-0422*/
        wdetail2.desmodel   /*a62-0422*/
        wdetail2.si                   
        wdetail2.pol_comm_date     
        wdetail2.pol_exp_date     
        wdetail2.last_pol
        wdetail2.cover
        wdetail2.pol_netprem
        wdetail2.pol_gprem
        wdetail2.pol_stamp
        wdetail2.pol_vat
        wdetail2.pol_wht
        wdetail2.com_no
        wdetail2.com_comm_date
        wdetail2.com_exp_date
        wdetail2.com_netprem
        wdetail2.com_gprem
        wdetail2.com_stamp
        wdetail2.com_vat
        wdetail2.com_wht
        wdetail2.deler                
        wdetail2.showroom             
        wdetail2.typepay              
        wdetail2.financename          
        wdetail2.mail_hno
        wdetail2.mail_build
        wdetail2.mail_mu                   
        wdetail2.mail_soi                  
        wdetail2.mail_road                 
        wdetail2.mail_tambon               
        wdetail2.mail_amper                
        wdetail2.mail_country              
        wdetail2.mail_post                 
        wdetail2.send_date
        wdetail2.policy_no
        wdetail2.send_data
        wdetail2.REMARK1              
        wdetail2.occup
        wdetail2.np_f18line1 
        wdetail2.regis_no.
    
    IF INDEX(wdetail2.ins_ytyp,"mail") <> 0 THEN DO:
      ASSIGN nv_memo1 = wdetail2.bus_typ 
             nv_memo2 = wdetail2.TASreceived  
             nv_memo3 = wdetail2.InsCompany.
    END. 
    ELSE IF INDEX(wdetail2.ins_ytyp,"Ins") <> 0 THEN DELETE wdetail2.               
    ELSE IF INDEX(wdetail2.ins_ytyp,"ins") <> 0 THEN DELETE wdetail2. 
    ELSE IF INDEX(wdetail2.ins_ytyp,"Renew") <> 0 THEN DELETE wdetail2. 
    ELSE IF INDEX(wdetail2.ins_ytyp,"renew") <> 0 THEN DELETE wdetail2.
    ELSE IF trim(Wdetail2.ins_ytyp ) = ""         THEN DELETE wdetail2. 
    ELSE IF TRIM(wdetail2.bus_typ) <> "LCV"  THEN DELETE wdetail2. 
    
END. /*-Repeat-*/ 
RELEASE wdetail2.

FIND FIRST bfwdetail2 WHERE bfwdetail2.tpis_no <> "" AND INDEX(bfwdetail2.garage,"ซ่อม") = 0 NO-ERROR NO-WAIT .
 IF AVAIL bfwdetail2 THEN DO:
     MESSAGE "กรุณาเลือกไฟล์แจ้งงานแบบใหม่! " VIEW-AS ALERT-BOX.
     FOR EACH wdetail2 .
        DELETE wdetail2.
     END.
 END.

RUN proc_assign2.
RUN proc_assign3.
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
DEF VAR model   AS CHAR .
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN fi_process  = "Create data base_ TAS/TPIB.......[ISUZU]   " + wdetail.policy  .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
IF wdetail.poltyp = "v70" THEN DO:
    aa = 0 .
    IF wdetail.baseprem <> 0  THEN ASSIGN aa = wdetail.baseprem .
    ELSE DO: 
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ASSIGN  
        NO_basemsg  = " "
        nv_baseprm  = aa
        wdetail.drivnam  = "N"
        nv_dss_per  =  deci(wdetail.dspc)
        /*nv_drivvar1 =  wdetail.drivnam1*/        .
    /*--------A68-0044
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
            Message
                 " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        End.
        RUN proc_usdcod.
        ASSIGN nv_drivvar  = ""
            nv_drivvar     = "A000"     /*nv_drivcod*/
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
        /*RUN proc_usdcod. */
    END.
    --------A68-0044-------------------*/
    /*-------nv_baseprm----------*/
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
    ASSIGN  nv_41  = 0      nv_42 = 0   nv_43 =  0
            nv_41  = DECI(wdetail.no_411)
            nv_42  = DECI(wdetail.no_42)
            nv_43  = DECI(wdetail.no_43)
            nv_seat41 = integer(wdetail.seat41). 
     /* -------fi_41---------*/
    nv_411var = "" .    nv_412var = "".
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
        SUBSTRING(nv_412var,31,30)  = nv_412var2.
    /* -------fi_42---------*/   
    Assign  nv_42var    = " " 
            nv_42cod   = "42"
    nv_42var1  = "     Medical Expense = "
    nv_42var2  = STRING(nv_42)
    SUBSTRING(nv_42var,1,30)   = nv_42var1
    SUBSTRING(nv_42var,31,30)  = nv_42var2.
    /*---------fi_43--------*/
    nv_43var    = " ".     
    Assign
        nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    
  /*------nv_usecod------------*/
    Assign  nv_usevar = ""
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30) = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  wdetail.subclass.       
    RUN wgs\wgsoeng.   
    /*-----nv_yrcod----------------------------*/  
    ASSIGN nv_yrvar = ""
        nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
        nv_yrvar1  = "     Vehicle Year = "
        nv_yrvar2  =  wdetail.caryear
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
            Substr(nv_yrvar,1,30)    = nv_yrvar1
            Substr(nv_yrvar,31,30)   = nv_yrvar2.  
     /*-----nv_sicod----------------------------*/ 
     nv_sivar = "" .
     Assign  nv_totsi     = 0
             nv_sicod     = "SI"
             nv_sivar1    = "     Own Damage = "
             nv_sivar2    =  wdetail.si
             SUBSTRING(nv_sivar,1,30)  = nv_sivar1
             SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
             nv_totsi     =  DECI(wdetail.si).
       /*----------nv_grpcod--------------------*/
       Assign   nv_grpvar = ""
           nv_grpcod      = "GRP" + wdetail.cargrp
           nv_grpvar1     = "     Vehicle Group = "
           nv_grpvar2     = wdetail.cargrp
           Substr(nv_grpvar,1,30)  = nv_grpvar1
           Substr(nv_grpvar,31,30) = nv_grpvar2.
     /*-------------nv_bipcod--------------------*/
     nv_bipvar = "" .
     ASSIGN
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(deci(wdetail.deductpp))
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     nv_biavar = "" .
     Assign 
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(deci(wdetail.deductba))
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
    nv_pdavar = "" .
     ASSIGN 
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         nv_pdavar2     = string(deci(WDETAIL.deductpa))   
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     
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
    
     IF nv_flet_per <> 0 THEN
        ASSIGN
            nv_fletvar     = " "
            nv_fletvar1    = "     Fleet % = "
            nv_fletvar2    =  STRING(nv_flet_per)
            SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
            SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.

     IF nv_flet   = 0  THEN nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     
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
   
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN DO:
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     END.

     nv_dsspcvar   = " ".                                  
     IF  nv_dss_per   <> 0  THEN                          
      Assign                                           
      nv_dsspcvar1   = "     Discount Special % = "    
      nv_dsspcvar2   =  STRING(nv_dss_per)             
      SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1    
      SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2. 
   
END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt C-Win 
PROCEDURE proc_calpremt :
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
IF wdetail.poltyp = "V70" THEN DO:
    ASSIGN fi_process = "Create data to base..." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
    ASSIGN 
         nv_polday  = 0 
         nv_covcod  = ""  
         nv_class   = ""  
         nv_vehuse  = ""  
         nv_cstflg  = ""  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/    
         nv_engcst  = 0   /* ต้องใส่ค่าตาม nv_cstflg  */         
         /*nv_drivno  = 0
         nv_driage1 = 0
         nv_driage2 = 0*/
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
         nv_411si   = deci(wdetail.no_411)       
         nv_412si   = deci(wdetail.no_411)       
         nv_413si   = 0                       
         nv_414si   = 0                       
         nv_42si    = deci(wdetail.no_42)               
         nv_43si    = deci(wdetail.no_43)               
         nv_seat41  = INT(wdetail.seat41)   
         nv_dedod   = 0    
         nv_addod   = 0                              
         nv_dedpd   = 0                                  
         nv_ncbp    = deci(wdetail.ncb)                                     
         nv_fletp   = deci(wdetail.fleet)                                  
         nv_dspcp   = nv_dss_per                                      
         nv_dstfp   = 0                                                     
         nv_clmp    = 0                                                     
         nv_netprem = DECI(wdetail.volprem) /* เบี้ยสุทธิ */                                                
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
           clastab_fil.CLASS  = nv_class          AND
           clastab_fil.covcod = wdetail.covcod    NO-LOCK NO-ERROR.
        IF AVAIL stat.clastab_fil THEN DO:
            IF clastab_fil.unit = "C" THEN DO:
                ASSIGN nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" THEN "W" ELSE clastab_fil.unit
                       nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(wdetail.cc) ELSE INT(wdetail.cc).
            END.
            ELSE IF clastab_fil.unit = "S" THEN DO:
                ASSIGN nv_cstflg = clastab_fil.unit
                       nv_engine = INT(wdetail.seat).
            END.
            ELSE IF clastab_fil.unit = "T" THEN DO:
                ASSIGN nv_cstflg = clastab_fil.unit
                       nv_engine = DECI(sic_bran.uwm301.Tons).
            END.
            nv_engcst = nv_engine .
        END.
    IF nv_cstflg = "W" THEN ASSIGN sic_bran.uwm301.watt = nv_engine . /* add  */
    IF wdetail.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            RUN wgw/wgwredbk1(input  wdetail.brand ,  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail.tariff,  
                               input  wdetail.subclass,   
                               input  wdetail.caryear, 
                               input  nv_engine  ,
                               input  0 , 
                               INPUT-OUTPUT wdetail.redbook) .
        END.
        ELSE DO:
            RUN wgw/wgwredbk1(input  wdetail.brand ,  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail.tariff,  
                               input  wdetail.subclass,   
                               input  wdetail.caryear, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT wdetail.redbook) .
        END.
        IF wdetail.redbook <> ""  THEN DO:  
            FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass  AND
                 stat.maktab_fil.modcod = wdetail.redbook         No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     wdetail.cargrp          =  maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     nv_vehgrp               =  stat.maktab_fil.prmpac.
        END.
        ELSE DO:
         ASSIGN wdetail.comment = wdetail.comment + "| " + "Redbook is Null !! "
                wdetail.WARNING = "Redbook เป็นค่าว่าง " 
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
    /* add */
    IF nv_polday < 365 THEN DO:
        nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat).
        nv_netprem = TRUNCATE((nv_netprem / nv_polday ) * 365 ,0) +
                     (IF ((nv_netprem / nv_polday ) * 365 ) - Truncate((nv_netprem / nv_polday ) * 365,0) > 0 Then 1 
                      Else 0). 
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
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.     
*/ 
    /*RUN WUW\WUWPADP1.P(INPUT sic_bran.uwm100.policy,*/
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
                       /*INPUT-OUTPUT nv_totfi  ,*/
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
                       OUTPUT  nv_status, 
                       OUTPUT  nv_message).
    IF nv_status = "no" THEN DO:
        /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt + 
        nv_message   VIEW-AS ALERT-BOX. 
        ASSIGN   wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
            wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt.
                 wdetail.pass    = "Y"     
                wdetail.OK_GEN  = "N".*//*comment Kridtiya i. A65-0035*/
        /*  by Kridtiya i. A65-0035*/
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN  wdetail.comment = wdetail.comment + "|" + nv_message
                wdetail.WARNING = wdetail.WARNING + "|" + nv_message .
        /*  by Kridtiya i. A65-0035 */
    END.
    /*  by Kridtiya i. A65-0035 */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt_EV C-Win 
PROCEDURE proc_calpremt_EV :
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
IF wdetail.poltyp = "V70" THEN DO:
        ASSIGN fi_process = "Create data to base..." + wdetail.policy .
        DISP fi_process WITH FRAM fr_main.
        RUN proc_initcal.
        ASSIGN 
            nv_covcod  = wdetail.covcod                                             
            nv_class   = trim(wdetail.prempa) + trim(wdetail.subclass)                                   
            nv_vehuse  = wdetail.vehuse       
            nv_driage1 = nv_drivage1                                 
            nv_driage2 = nv_drivage2                                    
            nv_yrmanu  = INT(wdetail.caryear)             
            nv_totsi   = sic_bran.uwm130.uom6_v
            nv_totfi   = sic_bran.uwm130.uom7_v
            nv_vehgrp  = wdetail.cargrp                                               
            nv_access  = ""  
            nv_tpbi1si = sic_bran.uwm130.uom1_v           
            nv_tpbi2si = sic_bran.uwm130.uom2_v           
            nv_tppdsi  = sic_bran.uwm130.uom5_v           
            nv_411si   = deci(wdetail.no_411)      
            nv_412si   = deci(wdetail.no_411)       
            nv_413si   = 0                                           
            nv_414si   = 0                                       
            nv_42si    = deci(wdetail.no_42)                  
            nv_43si    = deci(wdetail.no_43)  
            nv_41prmt  = 0 
            /*nv_412prmt = 0  */
            /*nv_413prmt = 0  */
            /*nv_414prmt = 0*/
            nv_42prmt  = 0
            nv_43prmt  = 0   
            nv_seat41  = INT(wdetail.seat41) 
            nv_dedod   =  0                  
            nv_addod   =  0                               
            nv_dedpd   =  0                                                
            nv_ncbp    =  deci(wdetail.ncb)                                 
            nv_fletp   =  deci(wdetail.fleet)                              
            nv_dspcp   =  nv_dss_per                                          
            nv_dstfp   =  0                                                                 
            nv_clmp    =  0 
            nv_pdprem   = DECI(wdetail.volprem)  /* เบี้ยสุทธิ เบี้ยเต็มปี */  
            nv_gapprem  = DECI(wdetail.volprem)  
            nv_flagprm = "N"  /* N = เบี้ยสุทธิ, G = เบี้ยรวม */  
            nv_effdat = sic_bran.uwm100.comdat
            nv_ratatt  = 0
            nv_siatt    = 0
            nv_netatt   = 0       
            nv_fltatt   = 0      
            nv_ncbatt   = 0      
            nv_dscatt   = 0
            nv_adjpaprm = NO

            /*nv_mainprm  = 0 
            nv_dodamt   = 0  /* ระบุเบี้ย DOD */   
            nv_dadamt   = 0  /* ระบุเบี้ย DOD1 */  
            nv_dpdamt   = 0  /* ระบุเบี้ย DPD */   
            nv_ncbamt   = 0  /* ระบุเบี้ย NCB PREMIUM */           
            nv_fletamt  = 0  /* ระบุเบี้ย FLEET PREMIUM */          
            nv_dspcamt  = 0 /* ระบุเบี้ย DSPC PREMIUM */           
            nv_dstfamt  = 0 /* ระบุเบี้ย DSTF PREMIUM */           
            nv_clmamt   = 0   /* ระบุเบี้ย LOAD CLAIM PREMIUM */    
            nv_baseprm  = deci(wdetail.base)
            nv_baseprm3 = deci(wdetail.baseplus) 
            nv_pdprem   = DECI(wdetail.premt) /* เบี้ยสุทธิ เบี้ยเต็มปี */
            nv_gapprem  = DECI(wdetail.premt)
            nv_attgap   = deci(wdetail.dgatt) 
            nv_atfltgap = deci(wdetail.dgfeetprm)
            nv_atncbgap = deci(wdetail.dgncbprm)
            nv_atdscgap = deci(wdetail.dgdiscprm) 
            nv_packatt  = trim(wdetail.dgpackge)
            nv_flgsht   = IF wdetail.srate = "Y" THEN "S" ELSE "P"  */
            nv_fcctv    = NO 
            nv_garage   = TRIM( wdetail.garage) 
            nv_level    = INTE(wdetail.drilevel)   
            nv_levper   = nv_dlevper 
            nv_tariff   = wdetail.tariff 
            nv_flag     = IF TRIM( wdetail.garage)  = "G" THEN YES ELSE NO

            /*/* A67-0029*/
            
            nv_adjpaprm   = IF nv_41prmt <> 0 OR nv_412prmt <> 0 OR nv_413prmt <> 0 OR nv_414prmt <> 0 OR nv_42prmt <> 0 OR nv_43prmt <> 0 THEN YES ELSE NO
            nv_flgpol     =   "NR"                
            /*nv_flgclm     = IF nv_clmp <> 0 THEN "WC" ELSE "NC"  /*NC=NO CLAIM , WC=With Claim*/  */
            nv_chgflg     = IF DECI(wdetail.chargprm) <> 0 THEN YES ELSE NO    
            nv_chgrate    = DECI(wdetail.chargrate)                     
            nv_chgsi      = INTE(wdetail.chargsi)                                     
            nv_chgpdprm   = DECI(wdetail.chargprm)                                     
            nv_chggapprm  = 0                                     
            nv_battflg    = IF DECI(wdetail.battprm) <> 0 THEN YES ELSE NO                                    
            nv_battrate   = DECI(wdetail.battrate)                                    
            nv_battsi     = INTE(wdetail.battsi)                                     
            nv_battprice  = INTE(wdetail.battprice)                     
            nv_battpdprm  = DECI(wdetail.battprm)                                     
            nv_battgapprm = 0                                                                                                                     
            nv_battyr     = INTE(wdetail.battyr)    
            nv_battper    = DECI(wdetail.battper)
            nv_evflg      = IF index(wdetail.subclass,"E") <> 0 THEN YES ELSE NO  
            nv_compprm    = 0       nv_uom9_v     = 0 
            /* end A67-0029*/
            nv_flag     = IF index(wdetail.subclass,"E") <> 0 THEN NO ELSE tg_flag  /*A68-0044*/   
            
            nv_31prmt   = DECI(wdetail.prmt31)    /*A68-0044*/
            nv_31rate   = DECI(wdetail.rate31)*/  .  /*A68-0044*/

         FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE clastab_fil.CLASS  = nv_class  AND clastab_fil.covcod = wdetail.covcod NO-LOCK NO-ERROR.
            IF AVAIL stat.clastab_fil THEN DO:
                IF clastab_fil.unit = "C" THEN DO:
                    ASSIGN nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" OR SUBSTR(nv_class,2,1) = "E" THEN "H" ELSE clastab_fil.unit
                           nv_engine = IF SUBSTR(nv_class,5,1) = "E" OR SUBSTR(nv_class,2,1) = "E" THEN DECI(wdetail.watt) ELSE INT(wdetail.cc).
                END.
                ELSE IF clastab_fil.unit = "S" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = INT(wdetail.seat).
                END.
                ELSE IF clastab_fil.unit = "T" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = DECI(sic_bran.uwm301.Tons).
                END.
                ELSE IF clastab_fil.unit = "H" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = DECI(wdetail.watt). 
                END.
                nv_engcst = nv_engine .
            END.
        IF wdetail.redbook = ""  THEN DO:
            /*IF nv_cstflg = "W" OR nv_cstflg = "H" THEN DO:
                 RUN wgw/wgwredbev(input  wdetail.brand       , input  wdetail.model  ,  
                                   input  INT(wdetail.si)     , INPUT  wdetail.tariff ,  
                                   input  SUBSTR(nv_class,2,5), input  wdetail.caryear, 
                                   input  nv_engine ,input  0 , 
                                   INPUT-OUTPUT wdetail.maksi ,
                                   INPUT-OUTPUT wdetail.redbook) .
            END. */
            IF nv_cstflg <> "T" THEN DO:
                RUN wgw/wgwredbk1(input  wdetail.brand ,       /*A65=0079*/
                               input  wdetail.model ,  
                               input  nv_totsi      ,  
                               INPUT  wdetail.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  wdetail.caryear, 
                               input  nv_engine  ,
                               input  0 , 
                               INPUT-OUTPUT wdetail.redbook) .
            END.
            ELSE DO:
                 RUN wgw/wgwredbk1(input  wdetail.brand ,       /*A65=0079*/  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  wdetail.caryear, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT wdetail.redbook) .
            END.
            IF wdetail.redbook <> "" THEN RUN proc_chkredbook. /* A68-0044*/
            ELSE DO:
             ASSIGN wdetail.comment = wdetail.comment + "| " + "Redbook is Null !! "
                    wdetail.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ "  .
                    wdetail.pass    = "N". /*A65-0079*/
            END.
        END.
        FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  wdetail.brand AND maktab_fil.sclass   =  trim(SUBSTR(nv_class,2,4)) NO-LOCK NO-ERROR.
            IF AVAIL stat.maktab_fil THEN nv_supe = maktab_fil.impchg.
        IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
            IF ( DAY(sic_bran.uwm100.comdat)     =  DAY(sic_bran.uwm100.expdat)     AND
               MONTH(sic_bran.uwm100.comdat)     =  MONTH(sic_bran.uwm100.expdat)   AND
                YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
               ( DAY(sic_bran.uwm100.comdat)     =   29      AND
               MONTH(sic_bran.uwm100.comdat)     =   02      AND
                 DAY(sic_bran.uwm100.expdat)     =   01      AND
               MONTH(sic_bran.uwm100.expdat)     =   03      AND
                YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
            THEN DO:
              nv_polday = 365.
            END.
            ELSE DO:
              nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
            END.
        END.
        IF nv_polday < 365 THEN DO:
            nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat) + 1. /*F67-0001*/
        END.
        nv_campcd  = sic_bran.uwm100.policy.
        RUN proc_messagedata.
   /* RUN WUW\WUWMCP01.P(INPUT sic_bran.uwm100.policy, */ /*A68-0044*/
 RUN WUW\WUWMCP02.P (INPUT sic_bran.uwm100.policy,              /*A68-0044*/
                     INPUT nv_campcd ,                         
                     INPUT sic_bran.uwm100.rencnt,           
                     INPUT sic_bran.uwm100.endcnt,           
                     INPUT 0  , /*nv_riskgp*/            
                     INPUT nv_riskno ,                   
                     INPUT nv_itemno ,                   
                     INPUT nv_batchyr,                   
                     INPUT nv_batchno,                   
                     INPUT nv_batcnt ,                   
                     INPUT nv_polday ,                   
                     INPUT nv_usrid  ,                   
                     INPUT "wgwloadem"  ,                
                     INPUT 3, /*nv_diffprm*/             
                     INPUT nv_tariff,   
                     INPUT nv_covcod,   
                     INPUT nv_class ,   
                     INPUT nv_vehuse,   
                     INPUT nv_cstflg,   
                     INPUT nv_engcst,   
                     INPUT nv_drivno,   
                     INPUT nv_driage1,  
                     INPUT nv_driage2,  
                     INPUT nv_level  ,  
                     INPUT nv_levper ,  
                     INPUT nv_yrmanu,   
                     INPUT nv_totsi ,   
                     INPUT nv_totfi ,   
                     INPUT nv_vehgrp,    
                     INPUT nv_access,    
                     INPUT nv_supe,      
                     INPUT nv_tpbi1si,   
                     INPUT nv_tpbi2si,   
                     INPUT nv_tppdsi,    
                     INPUT nv_411si,     
                     INPUT nv_412si,     
                     INPUT nv_413si,     
                     INPUT nv_414si,     
                     INPUT nv_42si,      
                     INPUT nv_43si,      
                     INPUT nv_41prmt,    
                     INPUT nv_412prmt,   
                     INPUT nv_413prmt,   
                     INPUT nv_414prmt,   
                     INPUT nv_42prmt,    
                     INPUT nv_43prmt,    
                     INPUT nv_seat41,    
                     INPUT nv_dedod,
                     INPUT nv_addod,
                     INPUT nv_dedpd,
                     INPUT nv_dodamt,   
                     INPUT nv_dadamt,   
                     INPUT nv_dpdamt,   
                     INPUT nv_pdprem,
                     INPUT nv_gapprem,
                     INPUT nv_flagprm,
                     INPUT nv_effdat,
                     INPUT nv_adjpaprm,      /* yes/ No*/
                     INPUT YES ,             /* nv_adjprem yes/ No*/
                     INPUT nv_flgpol ,      /*NR=New RedPlate, NU=New Used Car, RN=Renew*/                   
                     INPUT nv_flgclm ,      /*NC=NO CLAIM , WC=With Claim*/                                  
                     INPUT 10,              /*cv_lfletper  = Limit Fleet % 10%*/                                                                                                                          
                     INPUT cv_lncbper ,     /*50,*/ /*  = Limit NCB %  50%*/                                                                                                                           
                     INPUT 35,                /*cv_ldssper  = Limit DSPC % กรณีป้ายแดง 110  ส่ง 45%  นอกนั้นส่ง 30% 35%*/                                                                                  
                     INPUT 0 ,                /*cv_lclmper  = Limit Claim % กรณีให้ Load Claim ได้ New 0% or 50% , Renew 0% or 20 - 50%  0%*/                                                              
                     INPUT 0 ,                /*cv_ldstfper = Limit DSTF % 0%*/                                                                                                                            
                     INPUT NO,                  /*nv_reflag   = กรณีไม่ต้องการ Re-Calculate ใส่ Yes*/                                                                                                        
                     INPUT-OUTPUT nv_ncbyrs ,                                                                                                                                                                 
                     INPUT-OUTPUT nv_ncbp,
                     INPUT-OUTPUT nv_fletp,
                     INPUT-OUTPUT nv_dspcp,
                     INPUT-OUTPUT nv_dstfp,
                     INPUT-OUTPUT nv_clmp,
                     INPUT-OUTPUT nv_pdprm0,
                     INPUT-OUTPUT nv_ncbamt ,  
                     INPUT-OUTPUT nv_fletamt, 
                     INPUT-OUTPUT nv_dspcamt,  /*  DSPC PREMIUM */
                     INPUT-OUTPUT nv_dstfamt,  /*  DSTF PREMIUM */
                     INPUT-OUTPUT nv_clmamt ,  /*  LOAD CLAIM PREMIUM */
                     INPUT-OUTPUT nv_baseprm,
                     INPUT-OUTPUT nv_baseprm3,
                     INPUT-OUTPUT nv_mainprm,  /* Main Premium Name/Unname Premium (HG) */
                     INPUT-OUTPUT nv_ratatt,
                     INPUT-OUTPUT nv_siatt ,
                     INPUT-OUTPUT nv_netatt,
                     INPUT-OUTPUT nv_fltatt,
                     INPUT-OUTPUT nv_ncbatt,
                     INPUT-OUTPUT nv_dscatt,
                     INPUT-OUTPUT nv_attgap ,   /*a65-0079*/
                     INPUT-OUTPUT nv_atfltgap,  /*a65-0079*/
                     INPUT-OUTPUT nv_atncbgap,  /*a65-0079*/
                     INPUT-OUTPUT nv_atdscgap,  /*a65-0079*/
                     INPUT-OUTPUT nv_packatt ,  /*a65-0079*/
                     INPUT-OUTPUT nv_chgflg     ,
                     INPUT-OUTPUT nv_chgrate    ,
                     INPUT-OUTPUT nv_chgsi      ,
                     INPUT-OUTPUT nv_chgpdprm   ,
                     INPUT-OUTPUT nv_chggapprm  ,
                     INPUT-OUTPUT nv_battflg    ,
                     INPUT-OUTPUT nv_battrate   ,
                     INPUT-OUTPUT nv_battsi     ,
                     INPUT-OUTPUT nv_battprice  ,
                     INPUT-OUTPUT nv_battpdprm  ,
                     INPUT-OUTPUT nv_battgapprm ,
                     INPUT-OUTPUT nv_battyr     ,
                     INPUT-OUTPUT nv_battper    ,
                     INPUT-OUTPUT nv_flag,    /* tariff flag = yes/no A68-0044*/ 
                     INPUT-OUTPUT nv_garage ,  /* A68-0044*/                      
                     INPUT-OUTPUT nv_31rate ,  /*a68-0044*/                       
                     INPUT-OUTPUT nv_31prmt ,   /* A68-0044*/                      
                     INPUT-OUTPUT nv_compprm ,
                     INPUT-OUTPUT nv_uom9_v  ,
                     INPUT-OUTPUT nv_fcctv ,  /* cctv = yes/no */
                     INPUT-OUTPUT nv_flgsht , /* Short rate = "S" , Pro rate = "P" */
                     INPUT-OUTPUT nv_evflg ,  /* EV = yes/no */
                     OUTPUT nv_uom1_c,
                     OUTPUT nv_uom2_c,
                     OUTPUT nv_uom5_c,
                     OUTPUT nv_uom6_c,
                     OUTPUT nv_uom7_c,
                     output nv_gapprm,
                     output nv_pdprm ,
                     OUTPUT nv_status,
                     OUTPUT nv_message).
    RUN proc_messagedata.
    OUTPUT CLOSE.
    ASSIGN sic_bran.uwm130.uom1_c  = nv_uom1_c      sic_bran.uwm130.uom2_c  = nv_uom2_c
           sic_bran.uwm130.uom5_c  = nv_uom5_c      sic_bran.uwm130.uom6_c  = nv_uom6_c
           sic_bran.uwm130.uom7_c  = nv_uom7_c .
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
    ASSIGN sic_bran.uwm130.chr3 = IF nv_adjpaprm = YES THEN "YES" ELSE "NO" .   /*F68-0001*/
    IF nv_message <> "" THEN DO:   /*A65-0079*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN wdetail.pass  = "N". /*A65-0043*/
        ASSIGN  wdetail.comment = wdetail.comment + "|" + nv_message
                wdetail.WARNING = wdetail.WARNING + "|" + nv_message.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_campaignov C-Win 
PROCEDURE proc_campaignov :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT  PARAMETER inv_producer   AS CHAR .
DEF INPUT  PARAMETER inv_line       AS CHAR .
DEF INPUT  PARAMETER inv_br         AS CHAR .
DEF INPUT  PARAMETER ibv_comdat     AS DATE .
DEF OUTPUT PARAMETER inv_campaignov AS CHAR INIT "".
FIND LAST campaign_acno WHERE 
    campaign_acno.acno   =  inv_producer
    NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL campaign_acno THEN DO: 

    FIND LAST campaign_poltyp WHERE 
        campaign_poltyp.campcode = campaign_acno.campcode AND
        campaign_poltyp.poltyp   = inv_line 
        NO-LOCK NO-ERROR NO-WAIT.
    IF   AVAIL campaign_poltyp THEN DO:
        FIND LAST campaign_br WHERE 
            campaign_br.campcode = campaign_poltyp.campcode AND
            campaign_br.branch   = inv_br 
            NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL campaign_br THEN DO:
             FIND LAST campaign_master WHERE 
                 campaign_master.campcode  = campaign_br.campcode 
                 NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL campaign_master THEN DO:
                 IF campaign_master.effdat  > nv_comdat THEN 
                    MESSAGE "วันที่ความคุ้มครองน้อยกว่า วันที่เริ่มใช้แคมเปญ : " campaign_master.campcode  VIEW-AS ALERT-BOX.
                ELSE IF  campaign_master.enddat < nv_comdat THEN
                    MESSAGE "วันที่ความคุ้มครองมากกว่า วันที่สิ้นสุดการใช้แคมเปญ : " campaign_master.campcode VIEW-AS ALERT-BOX.
                ELSE inv_campaignov = trim(campaign_master.campcode) .
             END.
             ELSE MESSAGE "ไม่พบแคมเปญ" VIEW-AS ALERT-BOX.
         END.
    END.
END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcode C-Win 
PROCEDURE proc_chkcode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A64-0138      
------------------------------------------------------------------------------*/
DO:
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
 
 IF wdetail.finint <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.finint) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Dealer " + wdetail.finint + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code Dealer " + wdetail.finint + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
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

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdrive C-Win 
PROCEDURE proc_chkdrive :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_count   = 0.
nv_drivno = 0.
IF wdetail.subclass = "110" OR   wdetail.subclass = "210" OR  wdetail.subclass = "610" THEN DO:
  IF wdetail.Driver1_name  <> "" AND  wdetail.Driver1_lastname  <> "" THEN DO: 
    ASSIGN no_policy    = ""            nv_drivage1  = 0        nv_drivbir1  = ""    
    no_rencnt    = ""            nv_drivage2  = 0        nv_drivbir2  = ""    
    no_endcnt    = ""            nv_drivage3  = 0        nv_drivbir3  = ""    
    no_riskno    = ""            nv_drivage4  = 0        nv_drivbir4  = ""    
    no_itemno    = ""            nv_drivage5  = 0        nv_drivbir5  = "" 
    nv_dribirth  = ""            nv_dlevel    = 0        nv_dlevper   = 0
    nv_dconsent  = ""
    no_policy = sic_bran.uwm301.policy 
    no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") 
    no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") 
    no_riskno = "001"
    no_itemno = "001"
    n_count   = 0.
    /*wdetail.Driver1_birthdate    25210930  */
    IF wdetail.Driver1_birthdate <> ""  THEN 
      wdetail.Driver1_birthdate = trim(string(SUBSTR(wdetail.Driver1_birthdate,7,2),"99") + "/" + 
                                   string(SUBSTR(wdetail.Driver1_birthdate,5,2),"99") + "/" + 
                                   string(INT(SUBSTR(wdetail.Driver1_birthdate,1,4)) - 543 ,"9999")). 
    IF wdetail.Driver2_birthdate <> ""  THEN 
      wdetail.Driver2_birthdate = trim(string(SUBSTR(wdetail.Driver2_birthdate,7,2),"99") + "/" + 
                                       string(SUBSTR(wdetail.Driver2_birthdate,5,2),"99") + "/" + 
                                       string(INT(SUBSTR(wdetail.Driver2_birthdate,1,4)) - 543 ,"9999")). 
    IF wdetail.Driver3_birthdate <> ""  THEN 
      wdetail.Driver3_birthdate = trim(string(SUBSTR(wdetail.Driver3_birthdate,7,2),"99") + "/" + 
                                       string(SUBSTR(wdetail.Driver3_birthdate,5,2),"99") + "/" + 
                                       string(INT(SUBSTR(wdetail.Driver3_birthdate,1,4)) - 543 ,"9999")). 
    IF wdetail.Driver4_birthdate <> ""  THEN 
      wdetail.Driver4_birthdate = trim(string(SUBSTR(wdetail.Driver4_birthdate,7,2),"99") + "/" + 
                                  string(SUBSTR(wdetail.Driver4_birthdate,5,2),"99") + "/" + 
                                  string(INT(SUBSTR(wdetail.Driver4_birthdate,1,4)) - 543 ,"9999")).
    IF wdetail.Driver5_birthdate <> ""  THEN 
      wdetail.Driver5_birthdate = trim(string(SUBSTR(wdetail.Driver5_birthdate,7,2),"99") + "/" + 
                                       string(SUBSTR(wdetail.Driver5_birthdate,5,2),"99") + "/" + 
                                       string(INT(SUBSTR(wdetail.Driver5_birthdate,1,4)) - 543 ,"9999")). 
    /*wdetail.Driver1_birthdate    30/10/1978  */
    ASSIGN  nv_drivage1 = IF TRIM(wdetail.Driver1_birthdate) <> "?" THEN  INT(SUBSTR(wdetail.Driver1_birthdate,7,4)) ELSE 0
    nv_drivage2       = IF TRIM(wdetail.Driver2_birthdate) <> "?" THEN  INT(SUBSTR(wdetail.Driver2_birthdate,7,4)) ELSE 0
    nv_drivage3       = IF TRIM(wdetail.Driver3_birthdate) <> "?" THEN  INT(SUBSTR(wdetail.Driver3_birthdate,7,4)) ELSE 0
    nv_drivage4       = IF TRIM(wdetail.Driver4_birthdate) <> "?" THEN  INT(SUBSTR(wdetail.Driver4_birthdate,7,4)) ELSE 0
    nv_drivage5       = IF TRIM(wdetail.Driver5_birthdate) <> "?" THEN  INT(SUBSTR(wdetail.Driver5_birthdate,7,4)) ELSE 0 .
    IF wdetail.Driver1_birthdate <> " "  AND wdetail.Driver1_name <> " " THEN DO: 
      RUN proc_clearmailtxt .
      IF nv_drivage1 < year(today) then do:
         nv_drivage1 =  YEAR(TODAY) - nv_drivage1  .
         ASSIGN nv_dribirth           = STRING(DATE(wdetail.Driver1_birthdate),"99/99/9999")  /* ค.ศ. */
         nv_drivbir1              = STRING(INT(SUBSTR(wdetail.Driver1_birthdate,7,4))  + 543 )
         wdetail.Driver1_birthdate = SUBSTR(wdetail.Driver1_birthdate,1,6) + nv_drivbir1
         wdetail.Driver1_birthdate = STRING(DATE(wdetail.Driver1_birthdate),"99/99/9999") . /* พ.ศ. */
      END.
      ELSE DO:
          nv_drivage1 =  YEAR(TODAY) - (nv_drivage1 - 543).
          ASSIGN nv_drivbir1           = STRING(INT(SUBSTR(wdetail.Driver1_birthdate,7,4)))
          nv_dribirth              = SUBSTR(wdetail.Driver1_birthdate,1,6) + STRING((INTE(nv_drivbir1) - 543),"9999")  /* ค.ศ. */
          wdetail.Driver1_birthdate = SUBSTR(wdetail.Driver1_birthdate,1,6) + nv_drivbir1   
          wdetail.Driver1_birthdate = STRING(DATE(wdetail.Driver1_birthdate),"99/99/9999")  . /* พ.ศ. */
      END.
      ASSIGN  n_count = 1
      nv_ntitle   = trim(wdetail.Driver1_title)  
      nv_name     = trim(wdetail.Driver1_name)  
      nv_lname    = trim(wdetail.Driver1_lastname) 
      nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
      nv_dicno    = trim(wdetail.Driver1_id_no)  
      nv_dgender  = IF INDEX(nv_drinam,"นาย") <> 0 THEN "MALE" ELSE "FEMALE"
      nv_dbirth   = trim(wdetail.Driver1_birthdate)
      nv_dage     = nv_drivage1 
      nv_doccup   = trim(wdetail.Driver1_occupation) 
      nv_ddriveno = trim(wdetail.Driver1_license_no) 
      nv_drivexp  = ""
      nv_dconsent = "no"
      nv_dlevel   = 1  
      wdetail.drilevel = STRING(nv_dlevel) 
      nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
      ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
      RUN proc_mailtxt.
      IF wdetail.Driver2_birthdate <> " "  AND wdetail.Driver2_name  <> " " THEN DO: 
        RUN proc_clearmailtxt .
        if nv_drivage2 < year(today) then do:
         nv_drivage2 =  YEAR(TODAY) - nv_drivage2  .
         ASSIGN nv_dribirth    = STRING(DATE(wdetail.Driver2_birthdate),"99/99/9999") /* ค.ศ. */
         nv_drivbir2    = STRING(INT(SUBSTR(wdetail.Driver2_birthdate,7,4))  + 543 )
         wdetail.Driver2_birthdate = SUBSTR(wdetail.Driver2_birthdate,1,6) + nv_drivbir2
         wdetail.Driver2_birthdate = STRING(DATE(wdetail.Driver2_birthdate),"99/99/9999") . /* พ.ศ. */
        END.
        ELSE DO:
        nv_drivage2 =  YEAR(TODAY) - (nv_drivage2 - 543).
        ASSIGN nv_drivbir2    = STRING(INT(SUBSTR(wdetail.Driver2_birthdate,7,4)))
        nv_dribirth    = SUBSTR(wdetail.Driver2_birthdate,1,6) + STRING((INTE(nv_drivbir2) - 543),"9999")  /* ค.ศ. */
        wdetail.Driver2_birthdate = SUBSTR(wdetail.Driver2_birthdate,1,6) + nv_drivbir2   
        wdetail.Driver2_birthdate = STRING(DATE(wdetail.Driver2_birthdate),"99/99/9999")  . /* พ.ศ. */
        END.
        ASSIGN  n_count        = 2
        nv_ntitle   = trim(wdetail.Driver2_title)  
        nv_name     = trim(wdetail.Driver2_name )  
        nv_lname    = trim(wdetail.Driver2_lastname)
        nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
        nv_dicno    = trim(wdetail.Driver2_id_no)  
        nv_dgender  = IF INDEX(nv_drinam,"นาย") <> 0 THEN "MALE" ELSE "FEMALE"
        nv_dbirth   = trim(wdetail.Driver2_birthdate)
        nv_dage     = nv_drivage2
        nv_doccup   = trim(wdetail.Driver2_occupation) 
        nv_ddriveno = trim(wdetail.Driver2_license_no) 
        nv_drivexp  = ""  /*trim(wdetail.drivexp2)*/
        nv_dconsent = "no" /*TRIM(wdetail.dconsen2)*/
        nv_dlevel   = 1 
        wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
        nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                    ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
        RUN proc_mailtxt.
        IF wdetail.Driver3_birthdate <> " "  AND wdetail.Driver3_name <> " " THEN DO:
          RUN proc_clearmailtxt .
          if nv_drivage3 < year(today) then do:
              nv_drivage3 =  YEAR(TODAY) - nv_drivage3  .
              ASSIGN nv_dribirth    = STRING(DATE(wdetail.Driver3_birthdate),"99/99/9999") /* ค.ศ. */
              nv_drivbir3    = STRING(INT(SUBSTR(wdetail.Driver3_birthdate,7,4))  + 543 )
              wdetail.Driver3_birthdate = SUBSTR(wdetail.Driver3_birthdate,1,6) + nv_drivbir3
              wdetail.Driver3_birthdate = STRING(DATE(wdetail.Driver3_birthdate),"99/99/9999") . /* พ.ศ. */
          END.
          ELSE DO:
              nv_drivage3 =  YEAR(TODAY) - (nv_drivage3 - 543).
              ASSIGN nv_drivbir3    = STRING(INT(SUBSTR(wdetail.Driver3_birthdate,7,4)))
              nv_dribirth    = SUBSTR(wdetail.Driver3_birthdate,1,6) + STRING((INTE(nv_drivbir3) - 543),"9999")  /* ค.ศ. */
              wdetail.Driver3_birthdate = SUBSTR(wdetail.Driver3_birthdate,1,6) + nv_drivbir3   
              wdetail.Driver3_birthdate = STRING(DATE(wdetail.Driver3_birthdate),"99/99/9999")  . /* พ.ศ. */
          END.
          ASSIGN  n_count        = 3
          nv_ntitle   = trim(wdetail.Driver3_title)                  
          nv_name     = trim(wdetail.Driver3_name )                  
          nv_lname    = trim(wdetail.Driver3_lastname)               
          nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname  
          nv_dicno    = trim(wdetail.Driver3_id_no)                  
          nv_dgender  = IF INDEX(nv_drinam,"นาย") <> 0 THEN "MALE" ELSE "FEMALE"                                   
          nv_dbirth   = trim(wdetail.Driver3_birthdate)              
          nv_dage     = nv_drivage3                                  
          nv_doccup   = trim(wdetail.Driver3_occupation)             
          nv_ddriveno = trim(wdetail.Driver3_license_no)             
          nv_drivexp  = ""  /*trim(wdetail.drivexp2)*/               
          nv_dconsent = "no" /*TRIM(wdetail.dconsen2)*/              
          nv_dlevel   = 1                                            
          wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
          nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                        ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
          RUN proc_mailtxt.
          IF wdetail.Driver4_birthdate <> " "  AND wdetail.Driver4_name <> " " THEN DO: 
              RUN proc_clearmailtxt .
              if nv_drivage4 < year(today) then do:
                nv_drivage4 =  YEAR(TODAY) - nv_drivage4  .
                ASSIGN nv_dribirth    = STRING(DATE(wdetail.Driver4_birthdate),"99/99/9999") /* ค.ศ. */
                nv_drivbir4    = STRING(INT(SUBSTR(wdetail.Driver4_birthdate,7,4))  + 543 )
                wdetail.Driver4_birthdate = SUBSTR(wdetail.Driver4_birthdate,1,6) + nv_drivbir4
                wdetail.Driver4_birthdate = STRING(DATE(wdetail.Driver4_birthdate),"99/99/9999") . /* พ.ศ. */
              END.
              ELSE DO:
                  nv_drivage4 =  YEAR(TODAY) - (nv_drivage4 - 543).
                  ASSIGN nv_drivbir4    = STRING(INT(SUBSTR(wdetail.Driver4_birthdate,7,4)))
                      nv_dribirth    = SUBSTR(wdetail.Driver4_birthdate,1,6) + STRING((INTE(nv_drivbir4) - 543),"9999")  /* ค.ศ. */
                      wdetail.Driver4_birthdate = SUBSTR(wdetail.Driver4_birthdate,1,6) + nv_drivbir4   
                      wdetail.Driver4_birthdate = STRING(DATE(wdetail.Driver4_birthdate),"99/99/9999")  . /* พ.ศ. */
              END.
              ASSIGN  n_count        = 4
              nv_ntitle   = trim(wdetail.Driver4_title)                  
              nv_name     = trim(wdetail.Driver4_name )                  
              nv_lname    = trim(wdetail.Driver4_lastname)               
              nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname  
              nv_dicno    = trim(wdetail.Driver4_id_no)                  
              nv_dgender  = IF INDEX(nv_drinam,"นาย") <> 0 THEN "MALE" ELSE "FEMALE"                                      
              nv_dbirth   = trim(wdetail.Driver4_birthdate)              
              nv_dage     = nv_drivage4                                  
              nv_doccup   = trim(wdetail.Driver4_occupation)             
              nv_ddriveno = trim(wdetail.Driver4_license_no)             
              nv_drivexp  = ""  /*trim(wdetail.drivexp2)*/               
              nv_dconsent = "no" /*TRIM(wdetail.dconsen2)*/              
              nv_dlevel   = 1                                            
              wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
              nv_dlevper       = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                                 ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
              RUN proc_mailtxt.
              IF wdetail.Driver5_birthdate <> " "  AND wdetail.Driver5_name <> " " THEN DO:
                  RUN proc_clearmailtxt .
                  if nv_drivage5 < year(today) then do:
                      nv_drivage5 =  YEAR(TODAY) - nv_drivage5  .
                      ASSIGN nv_dribirth    = STRING(DATE(wdetail.Driver5_birthdate),"99/99/9999") /* ค.ศ. */
                          nv_drivbir5    = STRING(INT(SUBSTR(wdetail.Driver5_birthdate,7,4))  + 543 )
                          wdetail.Driver5_birthdate = SUBSTR(wdetail.Driver5_birthdate,1,6) + nv_drivbir5
                          wdetail.Driver5_birthdate = STRING(DATE(wdetail.Driver5_birthdate),"99/99/9999") . /* พ.ศ. */
                  END.
                  ELSE DO:
                      nv_drivage5 =  YEAR(TODAY) - (nv_drivage5 - 543).
                      ASSIGN nv_drivbir5    = STRING(INT(SUBSTR(wdetail.Driver5_birthdate,7,4)))
                          nv_dribirth    = SUBSTR(wdetail.Driver5_birthdate,1,6) + STRING((INTE(nv_drivbir5) - 543),"9999")  /* ค.ศ. */
                          wdetail.Driver5_birthdate = SUBSTR(wdetail.Driver5_birthdate,1,6) + nv_drivbir5   
                          wdetail.Driver5_birthdate = STRING(DATE(wdetail.Driver5_birthdate),"99/99/9999")  . /* พ.ศ. */
                  END.
                  ASSIGN  n_count        = 5
                  nv_ntitle   = trim(wdetail.Driver5_title)                 
                  nv_name     = trim(wdetail.Driver5_name )                 
                  nv_lname    = trim(wdetail.Driver5_lastname)              
                  nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname 
                  nv_dicno    = trim(wdetail.Driver5_id_no)                 
                  nv_dgender  = IF INDEX(nv_drinam,"นาย") <> 0 THEN "MALE" ELSE "FEMALE"                                  
                  nv_dbirth   = trim(wdetail.Driver5_birthdate)             
                  nv_dage     = nv_drivage5                                 
                  nv_doccup   = trim(wdetail.Driver5_occupation)            
                  nv_ddriveno = trim(wdetail.Driver5_license_no)            
                  nv_drivexp  = ""  /*trim(wdetail.drivexp2)*/              
                  nv_dconsent = "no" /*TRIM(wdetail.dconsen2)*/             
                  nv_dlevel   = 1
                  wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
                  nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                                ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
                  RUN proc_mailtxt.
              END. /*dri 5*/
          END.  /*dri 4*/
        END.   /*dri 3*/
      END.     /*dri 2*/
    END.       /*dri 1*/
    nv_drivno =  n_count   .
  END.   /*note add for mailtxt 07/11/2005*/
  ELSE nv_drivno = 0 .
END.
/*-----nv_drivcod---------------------*/
ASSIGN nv_drivcod = ""
       nv_drivvar = ""
       nv_drivvar1 = "".
       nv_drivvar2 = "".
IF n_count = 0 THEN ASSIGN  nv_drivno = 0
    wdetail.drivnam = "N".
ELSE ASSIGN  nv_drivno = n_count
    wdetail.drivnam = "Y" . 
IF nv_drivno = 0 Then DO:
    Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
END.
ELSE DO:
       /* IF tg_flag = NO THEN DO: /*A68-0044*/
            /*IF  nv_drivno  > 2 AND wdetail.subclass <> "E11" Then do:*/ /*A68-0044*/
            IF  nv_drivno  > 2 AND wdetail.subclass <> "E11" AND wdetail.subclass <> "E21"  AND wdetail.subclass <> "E61" Then do: /*A68-0044*/
                Message " Driver'S NO. must not over 2. "  View-as alert-box.
                ASSIGN wdetail.pass    = "N"
                       wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
            END.
            /*IF SUBSTR(wdetail.subclass,1,1) <> "E" THEN DO:*/ /*A68-0044*/ 
            IF  wdetail.subclass <> "E11" AND wdetail.subclass <> "E21"  AND wdetail.subclass <> "E61" THEN DO:
                RUN proc_usdcod.
            END.
            ELSE DO:
                ASSIGN nv_drivcod = "AL0" + TRIM(wdetail.drilevel).
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                           xmm106.tariff = wdetail.tariff  AND
                           xmm106.bencod = nv_drivcod   AND
                           xmm106.CLASS  = wdetail.subclass   AND
                           xmm106.covcod = wdetail.covcod  AND
                           xmm106.KEY_a  = 0          AND
                           xmm106.KEY_b  = 0          AND
                           xmm106.effdat <= wdetail.comdat NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL xmm106 THEN DO:
                    nv_dlevper = xmm106.appinc.
                END.
                ELSE ASSIGN nv_dlevper = 0.
            END.
        END.
        /* Add by : A68-0044 */
        ELSE DO:*/

            IF INDEX(wdetail.subclass,"11") = 0 AND INDEX(wdetail.subclass,"21") = 0 AND INDEX(wdetail.subclass,"61") = 0  THEN DO:  
                RUN proc_usdcod.
            END.
            ELSE DO:
                ASSIGN nv_drivcod = "AL0" + TRIM(wdetail.drilevel).
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                           xmm106.tariff = wdetail.tariff  AND
                           xmm106.bencod = nv_drivcod   AND
                           xmm106.CLASS  = wdetail.subclass   AND
                           xmm106.covcod = wdetail.covcod  AND
                           xmm106.KEY_a  = 0          AND
                           xmm106.KEY_b  = 0          AND
                           xmm106.effdat <= date(wdetail.comdat)   NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL xmm106 THEN DO:
                    nv_dlevper = xmm106.appinc.
                END.
                ELSE ASSIGN nv_dlevper = 0.
            END.
       /* END.----------------*/
        /* end : A68-0044 */
        Assign  nv_drivvar  = ""
        nv_drivvar     = nv_drivcod
        nv_drivvar1    = "     Driver name person = "
        nv_drivvar2    = String(nv_drivno)
        Substr(nv_drivvar,1,30)  = nv_drivvar1 
        Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkredbook C-Win 
PROCEDURE proc_chkredbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE 
               stat.maktab_fil.sclass = wdetail.subclass AND 
               stat.maktab_fil.modcod = wdetail.redbook  No-lock no-error no-wait.
     If  avail  stat.maktab_fil  Then DO:
         ASSIGN sic_bran.uwm301.modcod = wdetail.redbook .
         IF sic_bran.uwm301.maksi = 0 AND trim(wdetail.covcod) <> "3" THEN sic_bran.uwm301.maksi = stat.maktab_fil.maksi. 
     END.

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
ASSIGN fi_process  = "Check data to TAS/TPIB.......[ISUZU]  " + wdetail.policy .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
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
        Find LAST sicuw.uwm301 Use-index uwm30102 Where  
            sicuw.uwm301.vehreg              = wdetail.vehreg  AND
            substr(sicuw.uwm301.policy,3,2)  = substr(wdetail.poltyp,2,2)  No-lock no-error no-wait.
        IF AVAIL sicuw.uwm301 THEN DO:
            If  sicuw.uwm301.policy =  wdetail.policy     and          
                sicuw.uwm301.endcnt = 1  and
                sicuw.uwm301.rencnt = 1  and
                sicuw.uwm301.riskno = 1  and
                sicuw.uwm301.itemno = 1  Then  Leave.
            Find first sicuw.uwm100 Use-index uwm10001     Where
                sicuw.uwm100.policy = sicuw.uwm301.policy  and
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt  and                         
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt  and
                sicuw.uwm100.expdat > date(wdetail.comdat) No-lock no-error no-wait.
            If avail sicuw.uwm100 Then 
                s_polno     =   sicuw.uwm100.policy.
        END.        /*avil 301*/
    END.            /*จบการ Check ทะเบียนรถ*/
END.                /*note end else*/   /*end note vehreg*/
IF wdetail.cancel = "ca"  THEN  
    ASSIGN
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| cancel"
        wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรุณาใส่ชื่อผู้เอาประกัน"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
/*Kridtiy i. A54-0271 */
IF wdetail.branch = " " THEN
    ASSIGN
        wdetail.comment = wdetail.comment + "| สาขา( Branch )เป็นค่าว่างกรุณาตรวจสอบสาขา"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
/*Kridtiy i. A54-0271 */
/*kridtiya i. 
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
IF wdetail.cc    = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
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
IF index(wdetail.benname,"error") <> 0 THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| รหัสผู้รับผลประโยชน์ไม่ถูกต้อง " + wdetail.benname 
        wdetail.benname = ""
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
/* a61-0152*/
IF trim(wdetail.producer) = "" THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Producer Code เป็นค่าว่าง  " 
        wdetail.producer = ""
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".

IF TRIM(wdetail.agent) = "" THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Agent code เป็นค่าว่าง " 
        wdetail.agent  = ""
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
/* end A61-0152*/
/*ASSIGN
    nv_maxsi = 0
    nv_minsi = 0
    nv_si    = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred = NO
    n_model = ""
    nv_modcod = "" .     
IF wdetail.redbook NE "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
        stat.maktab_fil.sclass = wdetail.subclass  AND 
        stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  nv_modcod    =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            chkred           =  YES                     /*note chk found redbook*/
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
                ASSIGN
                    nv_maxSI = nv_si
                    nv_minSI = nv_si.
            /*IF deci(wdetail.si) > nv_maxSI OR deci(wdetail.si) < nv_minSI THEN DO:
                IF nv_maxSI = nv_minSI THEN DO:
                    IF nv_maxSI = 0 AND nv_minSI = 0 THEN do:
                        /*MESSAGE "Not Found Sum Insure in maktab_fil (Class:"
                            + wdetail.prempa + wdetail.subclass + "   Make/Model:" + wdetail.redbook + " "
                            + wdetail.brand + " " + wdetail.model + "   Year:" + STRING(wdetail.caryear) + ")" .*/
                        ASSIGN  wdetail.comment = "Not Found Sum Insure in maktab_fil (Class:"
                            + wdetail.prempa + wdetail.subclass + "   Make/Model:" + wdetail.redbook + " "
                            + wdetail.brand + " " + wdetail.model + "   Year:" + STRING(wdetail.caryear) + ")"
                            wdetail.pass    = "N"    
                            wdetail.OK_GEN  = "N".
                    end.
                    ELSE  /*MESSAGE         "Not Found Sum Insured Rates Maintenance in makdes31 (Tariff: X"
                                + "  Class:" + wdetail.prempa + wdetail.subclass  + ")" .*/
                        ASSIGN
                            wdetail.comment = "Not Found Sum Insured Rates Maintenance in makdes31 (Tariff: X"
                            + "  Class:"  + wdetail.prempa + wdetail.subclass + ")"
                            wdetail.pass    = "N"   
                            wdetail.OK_GEN  = "N".
                END.
                ELSE  /*MESSAGE  "Sum Insure must " + nv_mindes + " and " + nv_maxdes
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
    End.          
    ELSE nv_modcod = " ".
END. /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    FIND FIRST stat.insure USE-INDEX insure01  WHERE   
        stat.insure.compno  = fi_mocode        AND          
        stat.insure.fname   = wdetail.model    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL insure THEN  
         ASSIGN n_model =  stat.insure.lname   .
    ELSE ASSIGN n_model =  wdetail.model .
    /*Add A55-0107 ...*/
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  TRIM(wdetail.prempa) + wdetail.subclass  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN nv_simat  = makdes31.si_theft_p   
        nv_simat1 = makdes31.load_p   .    
    ELSE ASSIGN nv_simat  = 0
                nv_simat1 = 0.
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,n_model) <> 0              And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND
        stat.maktab_fil.sclass   =     wdetail.subclass         AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)     OR
        stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1  / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)  No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN nv_modcod =  stat.maktab_fil.modcod                                    
        nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.redbook  =  stat.maktab_fil.modcod  .
    ELSE ASSIGN nv_modcod = "".
    IF nv_modcod = ""  THEN  RUN proc_maktab.
END. */

ASSIGN                  
        NO_CLASS  = wdetail.prempa + wdetail.subclass 
        nv_poltyp = wdetail.poltyp.
    If no_class  <>  " " Then do:
        FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
            sicsyac.xmd031.poltyp =   nv_poltyp         AND 
            sicsyac.xmd031.class  =   no_class          NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE sicsyac.xmd031 THEN 
            ASSIGN wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
                wdetail.pass    = "N"   
                wdetail.OK_GEN  = "N".
        FIND sicsyac.xmm016 USE-INDEX xmm01601  WHERE 
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
     Find  sicsyac.sym100 Use-index sym10001     Where
         sicsyac.sym100.tabcod = "u013"          And
         sicsyac.sym100.itmcod = wdetail.covcod  No-lock no-error no-wait.
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
     /*--- comment by : A58-0489-----------------------
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
         Find first sicsyac.xmm104 Use-index xmm10401   Where
             sicsyac.xmm104.tariff = wdetail.tariff     AND 
             sicsyac.xmm104.class  = no_class           AND 
             sicsyac.xmm104.covcod = wdetail.covcod     AND 
             sicsyac.xmm104.ncbper = INTE(wdetail.ncb)  No-lock no-error no-wait.
         IF not avail  sicsyac.xmm104  Then 
             ASSIGN
                 wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
                 wdetail.pass    = "N"     
                 wdetail.OK_GEN  = "N".
     END. /*ncb <> 0*/ 
     --------------- A58-0489 ---------------*/
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
------------------------------------------------------------------------------*/
DEF VAR nv_cc AS INT INIT 0.
DEF VAR nv_si AS INT INIT 0.
DEF VAR nv_carmodel AS CHAR INIT "" .  
RUN proc_var.                             
LOOP_WDETAIL:
FOR EACH wdetail:
    IF  wdetail.policy = ""  THEN NEXT.
    /*------------------  renew ---------------------*/
    RUN proc_cr_2.
    ASSIGN n_rencnt = 0
           n_endcnt = 0.
    ASSIGN wdetail.campaign_ov = trim(wdetail.producer) .  /*Version 3*/
    RUN proc_susspect.
    RUN proc_chkcode . /*A64-0344*/
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
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
        ASSIGN  nv_carmodel = "" .  
        IF INDEX(wdetail.model," ") <> 0 THEN  
            ASSIGN nv_carmodel   = trim(wdetail.model)  
            wdetail.model = SUBSTR(nv_carmodel,1,INDEX(nv_carmodel," ") - 1 ) .
        ELSE ASSIGN nv_carmodel = TRIM(wdetail.model) .
        IF TRIM(wdetail.campens) <> ""  THEN DO:
            FIND LAST brstat.insure USE-INDEX insure03 WHERE                                     
                brstat.insure.compno   = "TPIS"  AND                                        
                brstat.insure.text4    = trim(wdetail.prempa) + trim(wdetail.subclass) AND  
                brstat.insure.text1    = TRIM(wdetail.campens) AND 
                deci(brstat.insure.text5)   = DECI(wdetail.volprem)   NO-LOCK NO-ERROR . /*A67-0101*/
        END.
        ELSE DO:
            FIND LAST brstat.insure USE-INDEX insure03 WHERE                                     
                brstat.insure.compno        = "TPIS"  AND                                        
                brstat.insure.text4         = trim(wdetail.prempa) + trim(wdetail.subclass) AND  
                deci(brstat.insure.text5)   = DECI(wdetail.volprem)   NO-LOCK NO-ERROR .         
        END.
        IF AVAIL brstat.insure THEN DO:
            ASSIGN 
                wdetail.deductpp  =  brstat.insure.lname
                wdetail.deductba  =  brstat.insure.addr1  
                wdetail.deductpa  =  brstat.insure.addr2 
                wdetail.NO_411    =  brstat.insure.addr3    
                wdetail.NO_412    =  brstat.insure.addr3 
                wdetail.NO_42     =  brstat.insure.addr4  
                wdetail.NO_43     =  brstat.insure.telno  .
            /* add by : A65-0156 */
            IF wdetail.subclass = "320" THEN DO:
                ASSIGN 
                wdetail.campens =  if wdetail.campens = "" then brstat.insure.text1 else wdetail.campens  
                wdetail.product =  if wdetail.product = "" then brstat.insure.text3 else wdetail.product. 
            END.
            /* end : A65-0156 */
        END.
        IF wdetail.subclass = "110" THEN DO: /* 110 */
            IF INT(wdetail.si) <= 1000000 THEN DO:
                IF INT(wdetail.CC) <= 2000  THEN DO: 
                    FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                        stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                        stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                        stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                        stat.campaign_fil.vehgrp  = "3" and   /* group car */
                        stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                        stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                        stat.campaign_fil.engine  <= 2000 and   /* CC */
                        stat.campaign_fil.simax  = deci(wdetail.si) and  /* ทุน */
                        stat.campaign_fil.moddes = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
                END.
                ELSE DO:
                    FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                        stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                        stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                        stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                        stat.campaign_fil.vehgrp  = "3" and   /* group car */
                        stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                        stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                        stat.campaign_fil.engine  > 2000  and   /* CC */
                        stat.campaign_fil.simax   = deci(wdetail.si) and  /* ทุน */
                        stat.campaign_fil.moddes  = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
                END.
                IF AVAIL stat.campaign_fil THEN DO:
                    ASSIGN wdetail.polmaster  = stat.campaign_fil.polmst
                        wdetail.NO_411     = string(stat.campaign_fil.mv411) 
                        wdetail.NO_412     = string(stat.campaign_fil.mv412) 
                        wdetail.NO_42      = string(stat.campaign_fil.mv42) 
                        wdetail.NO_43      = string(stat.campaign_fil.mv43)
                        wdetail.fleet      = string(stat.campaign_fil.fletper)
                        wdetail.ncb        = string(stat.campaign_fil.ncbper)
                        wdetail.dspc       = string(stat.campaign_fil.dspcper)
                        wdetail.loadclm    = string(stat.campaign_fil.clmper)
                        wdetail.baseprem   = stat.campaign_fil.baseprm 
                        wdetail.base3      = string(stat.campaign_fil.baseprm3)
                        wdetail.netprem    = string(stat.campaign_fil.netprm)
                        wdetail.seat       = string(stat.campaign_fil.seats)
                        /*wdetail.seat41     = campaign_fil.seats     /*kridtiya i. A63-0324 09/07/2020 */*/
                        wdetail.seat41     = stat.campaign_fil.seat41   .  /*kridtiya i. A63-0324 09/07/2020 */
                END.
            END.
            ELSE DO:
                nv_si = 0.
                nv_si = (INT(wdetail.si) + 40000 ) .
                IF INT(wdetail.CC) <= 2000  THEN DO: 
                    FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                        stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                        stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                        stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                        stat.campaign_fil.vehgrp  = "3" and   /* group car */
                        stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                        stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                        stat.campaign_fil.engine  <= 2000 and   /* CC */
                        stat.campaign_fil.simax   >= deci(wdetail.si) and  /* ทุน */
                        stat.campaign_fil.simax   <= nv_si            AND
                        stat.campaign_fil.moddes  = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
                END.
                ELSE DO:
                    FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                        stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                        stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                        stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                        stat.campaign_fil.vehgrp  = "3" and   /* group car */
                        stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                        stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                        stat.campaign_fil.engine  > 2000  and   /* CC */
                        stat.campaign_fil.simax   >= deci(wdetail.si) and  /* ทุน */
                        stat.campaign_fil.simax   <= nv_si            AND
                        stat.campaign_fil.moddes  = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
                END.
                IF AVAIL stat.campaign_fil THEN DO:
                    ASSIGN wdetail.polmaster  = stat.campaign_fil.polmst
                        wdetail.NO_411     = string(stat.campaign_fil.mv411) 
                        wdetail.NO_412     = string(stat.campaign_fil.mv412) 
                        wdetail.NO_42      = string(stat.campaign_fil.mv42) 
                        wdetail.NO_43      = string(stat.campaign_fil.mv43)
                        wdetail.fleet      = string(stat.campaign_fil.fletper)
                        wdetail.ncb        = string(stat.campaign_fil.ncbper)
                        wdetail.dspc       = string(stat.campaign_fil.dspcper)
                        wdetail.loadclm    = string(stat.campaign_fil.clmper)
                        wdetail.baseprem   = stat.campaign_fil.baseprm 
                        wdetail.base3      = string(stat.campaign_fil.baseprm3)
                        wdetail.netprem    = string(stat.campaign_fil.netprm)
                        wdetail.seat       = string(stat.campaign_fil.seats)
                        /*wdetail.seat41     = campaign_fil.seats */    /*kridtiya i. A63-0324 09/07/2020 */
                        wdetail.seat41     = stat.campaign_fil.seat41   .    /*kridtiya i. A63-0324 09/07/2020 */
                END.
            END.
        END.  /* end 110 */
        ELSE IF wdetail.subclass = "210" THEN DO:  /* 210  320*/
            FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.vehgrp  = "3" and   /* group car */
                stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                stat.campaign_fil.engine  <= 2000 and   /* CC */
                stat.campaign_fil.seats   = 5     and   /* ที่นั่ง */
                stat.campaign_fil.simax   = deci(wdetail.si) and  /* ทุน */
                stat.campaign_fil.moddes  = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
            IF AVAIL stat.campaign_fil THEN DO:
                ASSIGN wdetail.polmaster  = stat.campaign_fil.polmst
                    wdetail.NO_411     = string(stat.campaign_fil.mv411) 
                    wdetail.NO_412     = string(stat.campaign_fil.mv412) 
                    wdetail.NO_42      = string(stat.campaign_fil.mv42) 
                    wdetail.NO_43      = string(stat.campaign_fil.mv43)
                    wdetail.fleet      = string(stat.campaign_fil.fletper)
                    wdetail.ncb        = string(stat.campaign_fil.ncbper)
                    wdetail.dspc       = string(stat.campaign_fil.dspcper)
                    wdetail.loadclm    = string(stat.campaign_fil.clmper)
                    wdetail.baseprem   = stat.campaign_fil.baseprm 
                    wdetail.base3      = string(stat.campaign_fil.baseprm3)
                    wdetail.netprem    = string(stat.campaign_fil.netprm)
                    wdetail.seat       = string(stat.campaign_fil.seats)
                    wdetail.seat41     = campaign_fil.seats    /*--A65-0156--*/     /*kridtiya i. A63-0324 09/07/2020 */
                    /*wdetail.seat41     = stat.campaign_fil.seat41 */  /*--A65-0156--*/  .    /*kridtiya i. A63-0324 09/07/2020 */
            END.
            ELSE DO:
                FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                    stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                    stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                    stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                    stat.campaign_fil.vehgrp  = "3" and   /* group car */
                    stat.campaign_fil.vehuse  = "1" and   /* ประเภทการใช้รถ */
                    stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                    stat.campaign_fil.engine  > 2000 and   /* CC */
                    stat.campaign_fil.seats   = 5 AND
                    stat.campaign_fil.simax   = deci(wdetail.si) and  /* ทุน */
                    stat.campaign_fil.moddes  = trim(wdetail.model) NO-LOCK NO-ERROR.   /* Model */
                IF AVAIL stat.campaign_fil THEN DO:
                    ASSIGN wdetail.polmaster  = stat.campaign_fil.polmst
                        wdetail.NO_411     = string(stat.campaign_fil.mv411) 
                        wdetail.NO_412     = string(stat.campaign_fil.mv412) 
                        wdetail.NO_42      = string(stat.campaign_fil.mv42) 
                        wdetail.NO_43      = string(stat.campaign_fil.mv43)
                        wdetail.fleet      = string(stat.campaign_fil.fletper)
                        wdetail.ncb        = string(stat.campaign_fil.ncbper)
                        wdetail.dspc       = string(stat.campaign_fil.dspcper)
                        wdetail.loadclm    = string(stat.campaign_fil.clmper)
                        wdetail.baseprem   = stat.campaign_fil.baseprm 
                        wdetail.base3      = string(stat.campaign_fil.baseprm3)
                        wdetail.netprem    = string(stat.campaign_fil.netprm)
                        wdetail.seat       = string(stat.campaign_fil.seats)
                        wdetail.seat41     = campaign_fil.seats    /*--A65-0156--*/     /*kridtiya i. A63-0324 09/07/2020 */
                        /*wdetail.seat41     = stat.campaign_fil.seat41 */  /*--A65-0156--*/  .    /*kridtiya i. A63-0324 09/07/2020 */
                END.
            END.
        END.
        ELSE DO:  /* wdetail.subclass = "320" */
            /*IF deci(wdetail.volprem) = 31833 THEN wdetail.campens = "C63_00110A".*/ /*A65-0156*/
           FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
                stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                /*campaign_fil.vehgrp  = "3" and   /* group car */*/
                /*stat.campaign_fil.vehuse  = "1" and */  /* ประเภทการใช้รถ */ /*A65-0156*/
                stat.campaign_fil.vehuse  = "2" and     /* ประเภทการใช้รถ */ /*A65-0156*/
                stat.campaign_fil.garage  = wdetail.garage and    /* การซ่อม */
                stat.campaign_fil.seats   = inte(wdetail.seat)     and    /* ที่นั่ง */
                stat.campaign_fil.simax   = deci(wdetail.si)    /* ทุน */   
                NO-LOCK NO-ERROR.   
            IF AVAIL stat.campaign_fil THEN DO:
                ASSIGN wdetail.polmaster  = stat.campaign_fil.polmst
                    wdetail.NO_411     = string(stat.campaign_fil.mv411) 
                    wdetail.NO_412     = string(stat.campaign_fil.mv412) 
                    wdetail.NO_42      = string(stat.campaign_fil.mv42) 
                    wdetail.NO_43      = string(stat.campaign_fil.mv43)
                    /*wdetail.NO_44      = campaign_fil.mv44*/
                    wdetail.fleet      = string(stat.campaign_fil.fletper)
                    wdetail.ncb        = string(stat.campaign_fil.ncbper)
                    wdetail.dspc       = string(stat.campaign_fil.dspcper)
                    wdetail.loadclm    = string(stat.campaign_fil.clmper)
                    wdetail.baseprem   = stat.campaign_fil.baseprm 
                    wdetail.base3      = string(stat.campaign_fil.baseprm3)
                    wdetail.netprem    = string(stat.campaign_fil.netprm)
                    wdetail.seat       = string(stat.campaign_fil.seats)
                    /*wdetail.seat41     = campaign_fil.seats */    /*kridtiya i. A63-0324 09/07/2020 */
                    wdetail.seat41     = stat.campaign_fil.seat41   .    /*kridtiya i. A63-0324 09/07/2020 */
               /* comment by :A65-0156 ..
                IF      stat.campaign_fil.netprm = 24812  THEN wdetail.product = "P1". /*kridtiya i. A63-0324 09/07/2020  product*/
                ELSE IF stat.campaign_fil.netprm = 31833  THEN wdetail.product = "P4". /*kridtiya i. A63-0324 09/07/2020  product*/ */
            END.
        END.
        OUTPUT TO LinkLogOS_LoadTPIS_New.TXT APPEND.
        PUT
            TODAY    FORMAT "99/99/9999"  " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3) SKIP
            "wdetail.policy  :"  wdetail.policy     FORMAT "X(20)"     skip  
            "wdetail.campens :"  wdetail.campens    FORMAT "X(20)"     skip                                                
            "wdetail.subclass:"  wdetail.subclass   FORMAT "X(5)"      skip                                                
            "wdetail.covcod  :"  wdetail.covcod     FORMAT "X(5)"      skip                                                
            "wdetail.garage  :"  wdetail.garage     FORMAT "X(3)"      skip                                                
            "wdetail.seat    :"  wdetail.seat       FORMAT "X(5)"      skip                                                
            "wdetail.si      :"  wdetail.si         FORMAT "X(20)"     skip 
            "wdetail.polmaster:" wdetail.polmaster  FORMAT "X(20)"     skip  .
        OUTPUT CLOSE.
        /*END. /*... end A63-0113..*/*/ /*comment kridtiya i. A63-0324 09/07/2020*/
        wdetail.model = nv_carmodel . /*a62-0422*/
        RUN proc_chktest0.
    END.
    RUN proc_policy . 
    RUN proc_chktest2.
    RUN proc_chktest3.
    RUN proc_chktest4.  
        /* RELEASE stat.campaign_fil.  a63-0113 */
END.  /*for each*/
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
ASSIGN fi_process  = "Create data sic_bran.uwm120,uwm130,uwm301 TPIS.......[ISUZU]  " + wdetail.policy  .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
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
IF NOT AVAILABLE sic_bran.uwm130 THEN                        
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
        ASSIGN  sic_bran.uwm130.uom6_v   = inte(wdetail.si)
        sic_bran.uwm130.uom7_v   = inte(wdetail.si)
        sic_bran.uwm130.uom1_v   = 0 /*deci(wdetail.deductpp) */ 
        sic_bran.uwm130.uom2_v   = 0 /*deci(wdetail.deductba) */ 
        sic_bran.uwm130.uom5_v   = 0 /*deci(wdetail.deductpa) */ 
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/

    IF wdetail.covcod = "2"  THEN 
        ASSIGN  sic_bran.uwm130.uom1_c  = "D1"
        sic_bran.uwm130.uom2_c  = "D2"
        sic_bran.uwm130.uom5_c  = "D5"
        sic_bran.uwm130.uom6_c  = "D6"
        sic_bran.uwm130.uom7_c  = "D7"
        sic_bran.uwm130.uom1_v  = 0 /*deci(wdetail.deductpp)*/       
        sic_bran.uwm130.uom2_v  = 0 /*deci(wdetail.deductba)*/       
        sic_bran.uwm130.uom5_v  = 0 /*deci(wdetail.deductpa)*/       
        sic_bran.uwm130.uom6_v  = 0 
        sic_bran.uwm130.uom7_v  = inte(wdetail.si)
        sic_bran.uwm130.fptr01  = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02  = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03  = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04  = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05  = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN  sic_bran.uwm130.uom6_v   = 0
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
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do:                            
        Assign  
            sic_bran.uwm130.uom1_v  = if deci(wdetail.deductpp) = 0 then stat.clastab_fil.uom1_si else deci(wdetail.deductpp)
            sic_bran.uwm130.uom2_v  = if deci(wdetail.deductba) = 0 then stat.clastab_fil.uom2_si else deci(wdetail.deductba)
            sic_bran.uwm130.uom5_v  = if deci(wdetail.deductpa) = 0 then stat.clastab_fil.uom5_si else deci(wdetail.deductpa)
            sic_bran.uwm130.uom8_v  = stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v  = stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v  = 0 
            sic_bran.uwm130.uom4_v  = 0 
            nv_uom1_v               = sic_bran.uwm130.uom1_v   
            nv_uom2_v               = sic_bran.uwm130.uom2_v
            nv_uom5_v               = sic_bran.uwm130.uom5_v        
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".

        If  wdetail.garage  =  ""  Then
            Assign 
            wdetail.no_411   =  if deci(wdetail.no_411) = 0 then  string(stat.clastab_fil.si_41unp) else wdetail.no_411 
            wdetail.no_42    =  if deci(wdetail.no_42)  = 0 then  string(stat.clastab_fil.si_42)    else wdetail.no_42 
            wdetail.no_43    =  if deci(wdetail.no_43)  = 0 then  string(stat.clastab_fil.si_43)    else wdetail.no_43 
            wdetail.seat41   =  if wdetail.seat41 = 0       then  stat.clastab_fil.dri_41 + clastab_fil.pass_41 ELSE wdetail.seat41 .
        Else If  wdetail.garage  =  "G"  Then
            Assign 
            wdetail.no_411   = if deci(wdetail.no_411) = 0 then  string(stat.clastab_fil.si_41pai) else wdetail.no_411  
            wdetail.no_42    = if deci(wdetail.no_42)  = 0 then  string(stat.clastab_fil.si_42)    else wdetail.no_42   
            wdetail.no_43    = if deci(wdetail.no_43)  = 0 then  string(stat.clastab_fil.impsi_43) else wdetail.no_43    
            wdetail.seat41   = if wdetail.seat41 = 0       then  stat.clastab_fil.dri_41 + clastab_fil.pass_41 ELSE wdetail.seat41 .
        /*IF n_sclass72 = "v210" THEN wdetail.seat41 = 5.*/
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
             sic_bran.uwm301.bchcnt = nv_batcnt    NO-WAIT NO-ERROR.
         IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
             DO TRANSACTION:
                 CREATE sic_bran.uwm301.
             END. 
         END. 
         ASSIGN
             sic_bran.uwm301.bchyr     = nv_batchyr               
             sic_bran.uwm301.bchno     = nv_batchno               
             sic_bran.uwm301.bchcnt    = nv_batcnt   
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
             sic_bran.uwm301.Tons      = INTEGER(wdetail.weight)   /*a63-0113*/
            /* sic_bran.uwm301.Tons      = IF date(wdetail.comdat) >= 04/01/2020 AND wdetail.subCLASS = "320" THEN (INTEGER(wdetail.weight) * 1000 ) 
                                         ELSE INTEGER(wdetail.weight)  /*a63-0113*/*/
             sic_bran.uwm301.engine    = INTEGER(wdetail.cc)
             sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
             sic_bran.uwm301.garage    = wdetail.garage
             sic_bran.uwm301.body      = IF wdetail.model = "MU-X" THEN "WANGON" ELSE IF wdetail.model = "D-MAX" THEN "PICKUP" ELSE "TRUCK"
             sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
             sic_bran.uwm301.mv_ben83  = wdetail.benname
             sic_bran.uwm301.vehreg    = wdetail.vehreg
             sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
             sic_bran.uwm301.vehuse    = wdetail.vehuse
             sic_bran.uwm301.vehgrp    = wdetail.cargrp  /*A61-0152*/
             sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
             sic_bran.uwm301.sckno     = 0
             sic_bran.uwm301.itmdel    = NO
             sic_bran.uwm301.car_color = trim(wdetail.colors) . /* A66-0252 */

             /*sic_bran.uwm301.prmtxt    = IF wdetail.poltyp = "v70" THEN "คุ้มครองอุปกรณ์ตกแต่งราคาไม่เกิน 20,000 บาท" ELSE "". */ /*A65-0156*/
             wdetail.tariff            = sic_bran.uwm301.tariff.
             /*IF wdetail.poltyp = "v70" AND (wdetail.accdata <> "" ) THEN DO: */ /*A65-0156*/
             IF wdetail.poltyp = "v70"  THEN DO:  /*A65-0156*/
                 RUN proc_prmtxt. 
             END.
             s_recid4         = RECID(sic_bran.uwm301).
         /*-- maktab_fil --*/
         IF wdetail.redbook NE "" AND chkred = YES THEN DO:
             FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass  AND
                 stat.maktab_fil.modcod = wdetail.redbook         No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN
                     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes */ /*A61-0152*/
                     wdetail.cargrp          =  maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body.
         END.
         ELSE DO:
             IF wdetail.poltyp = "v72" THEN DO:
                 IF wdetail.subclass = "210" THEN wdetail.subclass = "140A".
                 ELSE wdetail.subclass = "110".
             END.
             FIND FIRST stat.insure USE-INDEX insure01  WHERE   
                 stat.insure.compno = fi_mocode         AND          
                 stat.insure.fname  = wdetail.model     NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL insure THEN  ASSIGN n_model =  stat.insure.lname   .
             ELSE ASSIGN n_model =  wdetail.model .
             /* Add A55-0107 */
            FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
                 stat.makdes31.moddes =  TRIM(wdetail.prempa) + wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL makdes31  THEN
                 ASSIGN nv_simat  = stat.makdes31.si_theft_p   
                 nv_simat1 = stat.makdes31.load_p   .    
             ELSE ASSIGN  nv_simat  = 0
                 nv_simat1 = 0.
             FIND LAST stat.maktab_fil Use-index      maktab04          Where
                 stat.maktab_fil.makdes   =     wdetail.brand            And                  
                 INDEX(stat.maktab_fil.moddes,n_model) <>  0             AND
                 stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
                 stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND
                 stat.maktab_fil.sclass   =     wdetail.subclass         AND 
                 (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
                  stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1  / 100 ) GE deci(wdetail.si) )  AND  
                 stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)       No-lock no-error no-wait.
             If  avail stat.maktab_fil  Then 
                 ASSIGN 
                     wdetail.redbook         =  stat.maktab_fil.modcod       
                     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes */ /*A61-0152*/
                     wdetail.cargrp          =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body.
             
         END.
         IF sic_bran.uwm301.modcod = "" OR wdetail.redbook = "" THEN RUN proc_maktab.
         ASSIGN sic_bran.uwm301.modcod = wdetail.redbook.
               
         IF wdetail.poltyp = "v72" THEN DO:
                 IF wdetail.subclass = "210" THEN wdetail.subclass = "140A".
         END.
         RUN proc_chkdrive.


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
DO:
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
    ASSIGN fi_process  = "Create data base_premium... TPIS.......[ISUZU]   " + wdetail.policy  .  /*a55-0051*/
    DISP  fi_process WITH FRAM fr_main.
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
    
 
/* coment by A63-0113 ...
    IF INTE(wdetail.netprem) <> inte(wdetail.volprem) THEN  DO:
        MESSAGE "เบี้ยไม่ตรงกับเบี้ยแคมเปญ" + wdetail.volprem + " <> " + STRING(wdetail.netprem) VIEW-AS ALERT-BOX.
        ASSIGN 
            nv_gapprm       = deci(wdetail.netprem)
            nv_pdprm        = deci(wdetail.netprem)
            wdetail.WARNING  = wdetail.WARNING + "เบี้ยในไฟล์ไม่ตรงกับแคมเปญ"
            wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้เบี้ยไม่ตรงกับไฟล์ "
            wdetail.pass     = IF wdetail.pass <> "N" THEN "Y" ELSE "N".
    END. 
    ELSE DO:
        ASSIGN nv_gapprm = DECI(wdetail.volprem)
               nv_pdprm  = DECI(wdetail.volprem).
    END.
  ..end A63-0113..*/ 
    /* comment by : Ranu I. A64-0344
    IF wdetail.polmaster <> "" THEN 
        ASSIGN nv_gapprm = DECI(wdetail.volprem)   /*A63-0370*/
               nv_pdprm  = DECI(wdetail.volprem).  /*A63-0370*/
    ...end A64-0344..*/           

   /*A64-0344 */
    IF wdetail.polmaster <> "" THEN RUN proc_adduwd132.  
    ELSE DO:
        /*RUN proc_calpremt .*/
        RUN proc_calpremt_EV.
        RUN proc_adduwd132prem.
    END.
    /* end A64-0344*/

    FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
    IF AVAIL  sic_bran.uwm100 THEN DO:
         ASSIGN 
         sic_bran.uwm100.prem_t = nv_pdprm     
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
            sic_bran.uwm301.mv41seat = wdetail.seat41
             /* A63-0113 */
            sic_bran.uwm301.tons     = IF sic_bran.uwm301.tons = 0 THEN 0 
                                       ELSE IF sic_bran.uwm301.tons < 100 THEN (sic_bran.uwm301.tons * 1000) 
                                       ELSE sic_bran.uwm301.tons.

    IF (SUBSTR(wdetail.subclass,1,1) = "3" OR SUBSTR(wdetail.subclass,1,1) = "4" OR
       SUBSTR(wdetail.subclass,1,1)  = "5" OR TRIM(wdetail.subclass) = "803"     OR
       TRIM(wdetail.subclass)  = "804"     OR TRIM(wdetail.subclass) = "805" )   and
       wdetail.prempa = "T"    AND sic_bran.uwm301.tons < 100  THEN DO:

       MESSAGE  wdetail.subclass + "ระบุน้ำหนักรถไม่ถูกต้อง " VIEW-AS ALERT-BOX.
       ASSIGN 
           wdetail.comment = wdetail.comment + "|Class " + wdetail.subclass + " น้ำหนักรถไม่ถูกต้อง " 
           wdetail.pass    = "N".
    END.
   /* end A63-0113 */
    /*
     nv_polmaster = wdetail.polmaster.

    IF nv_polmaster <> "" AND (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN RUN proc_adduwd132camPlus.  /*A63-0241 */
    ELSE IF nv_polmaster <> "" THEN RUN proc_adduwd132cam. */
                                             
    /* comment by : Ranu I. A64-0344
    ELSE IF wdetail.polmaster = "" THEN RUN WGS\WGSTN132(INPUT S_RECID3, 
                                                    INPUT S_RECID4).
   ..end A64-0344 ..*/                                                 

END.

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
DEF VAR nv_comiss       AS DECI INIT 0.00. /*A61-0416*/

ASSIGN fi_process  = "Create data to premium,stamp,vat TAS/TPIS.......[ISUZU]" .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
/*
/* A61-0416 */
IF deci(wdetail.dspc) <> 0  THEN DO:
    nv_comiss = 33 - DECI(wdetail.dspc) .
    IF nv_comiss <= 18 THEN nv_comiss = nv_comiss .
    ELSE nv_comiss = 18 .
END.
/* end A61-0416 */ */
nv_comiss = 18 .
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1   no-error no-wait.
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
                     sic_bran.uwm120.bchyr   = nv_batchyr              AND 
                     sic_bran.uwm120.bchno   = nv_batchno              AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt         .
                     FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                              sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                              sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                              sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                              sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                              sic_bran.uwm130.bchyr   = nv_batchyr              AND 
                              sic_bran.uwm130.bchno   = nv_batchno              AND 
                              sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                         n_sigr_r                = n_sigr_r + uwm130.uom6_v.
                              FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE 
                                       sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                                       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                                       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                                       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                                       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                                       sic_bran.uwd132.bchyr = nv_batchyr                AND 
                                       sic_bran.uwd132.bchno = nv_batchno                AND 
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
             sic_bran.uwm120.bchyr   = nv_batchyr               AND 
             sic_bran.uwm120.bchno   = nv_batchno               AND 
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
  IF deci(wdetail.dspc) <> 0  THEN  nv_com1p =  nv_comiss . /*A61-0416*/

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
          IF deci(wdetail.dspc) <> 0  THEN  nv_com1p =  nv_comiss . /*A61-0416*/
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
           sic_bran.uwm100.com1_t  = nv_fi_com1_t
           sic_bran.uwm100.com2_t  = nv_fi_com2_t
           sic_bran.uwm100.pstp    = 0               /*note modified on 25/10/2006*/
           sic_bran.uwm100.rstp_t  = nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  = nv_fi_rtax_t          
           sic_bran.uwm100.gstrat  = nv_fi_tax_per.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_clearmailtxt C-Win 
PROCEDURE proc_clearmailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_ntitle    = ""
       nv_name      = ""
       nv_lname     = ""
       nv_drinam    = ""
       nv_dicno     = ""
       nv_dgender   = ""
       nv_dribirth  = "" 
       nv_dbirth    = ""
       nv_dage      = 0
       nv_doccup    = ""
       nv_ddriveno  = ""
       nv_drivexp   = ""
       nv_dlevel    = 0 
       nv_dconsent   = "" 
       nv_dlevper   = 0 .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_colorcode C-Win 
PROCEDURE proc_colorcode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
     sym100.tabcod = "U118"  AND 
     sym100.itmdes = trim(wdetail2.coulor) 
     NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL sym100 THEN ASSIGN wdetail2.coulor = TRIM(sym100.itmcod).
       ELSE DO:
          FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
              sym100.tabcod = "U119"  AND 
              sym100.itmdes = trim(wdetail2.coulor)  
              NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL sym100 THEN ASSIGN wdetail2.coulor = TRIM(sym100.itmcod).
          ELSE DO: 
              ASSIGN wdetail2.coulor = "99999" .
          END.
       END.
END.

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
        n_cr2 = ""
        len = LENGTH(wdetail.policy)
        len = len - 1    .
    
    FIND FIRST buwm100 WHERE substr(buwm100.policy,2,len) = SUBSTR(wdetail.policy,2,len) AND
               buwm100.policy <> wdetail.policy  NO-LOCK NO-ERROR.
    IF AVAIL buwm100 THEN  n_cr2 = buwm100.policy.
    ELSE n_cr2 = "".
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_definition C-Win 
PROCEDURE Proc_definition :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */  
/*programid   : wgwntpis.w                                              */ 
/*programname : load text file tpis to GW ป้ายแดง                       */ 
/* Copyright    : Safety Insurance Public Company Limited  บริษัท ประกันคุ้มภัย จำกัด (มหาชน) */  
/* Modify by : Ranu I. A61-0152 date 14/03/2018 เปลี่ยนแปลงเงื่อนไขการเช็คข้อมูล CC และยี่ห้อรถใหม่ 
               เช็คเบี้ยไม่ตรงตามแคมเปญ                                                            */
/* Modify by : Ranu I. A61-0416  date 04/09/2018 แก้ไขคำนำหน้าชื่อให้ดึงตามพารามิเตอร์  ค่าคอมมิชชั่น  */
/* Modify by : Ranu I. A62-0422 date: 10/09/2019  เพิ่มประเภทไฟล์แจ้งงานใหม่ และเพิ่มการรับข้อมูลจากไฟล์แจ้งงานแบบใหม่*/
/* modify by : Ranu I. A63-0113 เพิ่มเงื่อนไขการเช็คงานที่เริ่มคุ้มครอง 01/04/2020 ให้ใช้ Pack T */
/* modify by : Kridtiya i. A63-0209 Date. 13/05/2020 เพิ่ม ข้อมูลช่อง Promotion , Product        */
/* modify by : Kridtiya i. A63-0241 Date. 25/05/2020 เพิ่ม การใช้ข้อมูลตามแคมเปญ C62/00260    */
/* modify by : Kridtiya i. A63-0324 Date. 09/07/2020 เพิ่ม การใช้ข้อมูลตามแคมเปญ C62/00260 แก้ไข ที่นั่งไม่ถุกต้อง   */
/* modify by : Kridtiya i. A63-0336 Date. 14/07/2020 เพิ่มแคมเปญ C63/00110 */
/* modify by : Kridtiya i. A63-0370 Date. 08/08/2020 เพิ่ม การให้ค่าเบี้ยรวม กรณี พบเบี้ยตามแคมเปญ */
/* Modify by : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/* Modify by : Ranu I. A64-0344  เพิ่มการเช็คสาขา ภูมิภาคจากพารามิเตอร์ เพิ่มการคำนวณเบี้ยจากโปรแกรมกลาง เช็คการคำนวณเบี้ย รย.ของพารามิเตอร์ campaign */
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/* Modify by  : Kridtiya i. A65-0035 แก้ไข message error */
/* Modify by  : Ranu i. A65-0156 แก้ไขที่นั่ง 210 , เพิ่มการเช็ค product จากเบี้ย และเพิ่มเงื่อนไขการเก็บอุปกรณ์เสริม */
/*Modify by   : Ranu I. A66-0084 แก้ไขการเก็บชื่อ-สกุล , แก้ไขการระบุ ชื่อกรรมการ และ/หรือ */
/*Modify by : Ranu I. A66-0252 เพิ่มสีรถ , เพิ่ม Memotext 72 ,เพิ่มการเช็ค Redbook 72 */
/*Modify by : Ranu I. A67-0101 date : 10/06/2024  แก้ไขที่อยู่ ให้ถูกต้อง และ match policy */
/*Modify by : Ranu I. F67-0001 date : 11/07/2024 เพิ่มการเก็บข้อมูล sic_bran.uwm301.trareg ของงาน พรบ. */
/*Modify by : Ranu I. F67-0001 date : 08/08/2024 แก้ไขการเช็คข้อมูลเลขสติ๊กเกอร์ */
/*Modify by : Ranu I. F67-0001 date : 06/11/2024  แก้ไขตัวเลือก match file Receipt ทะเบียนป้ายแดง และใส่ข้อมูล name 3 ในรายงาน*/
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
IF index(wdetail.model,"MU-X") <> 0 THEN DO:      /* 1900 cc  OK */
         IF deci(wdetail.si) = 820000   THEN ASSIGN nv_dss_per = 13.10   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 830000   THEN ASSIGN nv_dss_per = 13.10   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 840000   THEN ASSIGN nv_dss_per = 13.72   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 850000   THEN ASSIGN nv_dss_per = 14.36   aa = 7802.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 860000   THEN ASSIGN nv_dss_per = 14.96   aa = 7802.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 870000   THEN ASSIGN nv_dss_per = 15.54   aa = 7801.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 880000   THEN ASSIGN nv_dss_per = 16.12   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 890000   THEN ASSIGN nv_dss_per = 16.70   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 900000   THEN ASSIGN nv_dss_per = 17.28   aa = 7801.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 910000   THEN ASSIGN nv_dss_per = 17.83   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 920000   THEN ASSIGN nv_dss_per = 18.44   aa = 7805.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 930000   THEN ASSIGN nv_dss_per = 18.93   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 940000   THEN ASSIGN nv_dss_per = 7.97    aa = 7800.00    WDETAIL.NCB = "30.00".
    ELSE IF deci(wdetail.si) = 950000   THEN ASSIGN nv_dss_per = 8.58    aa = 7800.00    WDETAIL.NCB = "30.00".
    ELSE IF deci(wdetail.si) = 960000   THEN ASSIGN nv_dss_per = 9.18    aa = 7800.00    WDETAIL.NCB = "30.00".
    ELSE IF deci(wdetail.si) = 970000   THEN ASSIGN nv_dss_per = 9.81    aa = 7803.00    WDETAIL.NCB = "30.00".
    ELSE IF deci(wdetail.si) = 980000   THEN ASSIGN nv_dss_per = 10.41   aa = 7804.00    WDETAIL.NCB = "30.00".
    ELSE IF deci(wdetail.si) = 990000   THEN ASSIGN nv_dss_per = 10.98   aa = 7804.00    WDETAIL.NCB = "30.00".
    ELSE IF deci(wdetail.si) = 1000000  THEN ASSIGN nv_dss_per = 11.52   aa = 7801.00    WDETAIL.NCB = "30.00".
    ELSE IF deci(wdetail.si) = 1050000  THEN ASSIGN nv_dss_per = 14.58   aa = 7805.00    WDETAIL.NCB = "30.00".
    ELSE IF deci(wdetail.si) = 1100000  THEN ASSIGN nv_dss_per = 14.55   aa = 7805.00    WDETAIL.NCB = "30.00".
    ELSE IF deci(wdetail.si) = 1150000  THEN ASSIGN nv_dss_per = 15.08   aa = 7602.00    WDETAIL.NCB = "30.00".
    ELSE IF deci(wdetail.si) = 1200000  THEN ASSIGN nv_dss_per = 17.68   aa = 7600.00    WDETAIL.NCB = "30.00".
    ELSE IF deci(wdetail.si) = 1250000  THEN ASSIGN nv_dss_per = 6.85    aa = 7601.00    WDETAIL.NCB = "40.00".
    ELSE IF deci(wdetail.si) = 1300000  THEN ASSIGN nv_dss_per = 9.56    aa = 7601.00    WDETAIL.NCB = "40.00".
END.   /* add A56-0353 */
ELSE DO:
    IF wdetail.subclass = "110" THEN DO: 
       IF INT(wdetail.cc) <= 2000  THEN DO: /*1900*/
            IF deci(wdetail.si) = 450000      THEN ASSIGN nv_dss_per =  9.31   aa = 7600.00 .
            ELSE IF deci(wdetail.si) = 460000 THEN ASSIGN nv_dss_per = 10.71   aa = 7604.00 .
            ELSE IF deci(wdetail.si) = 470000 THEN ASSIGN nv_dss_per = 11.98   aa = 7600.00 .
            ELSE IF deci(wdetail.si) = 480000 THEN ASSIGN nv_dss_per = 13.26   aa = 7600.00 .
            ELSE IF deci(wdetail.si) = 490000 THEN ASSIGN nv_dss_per = 14.52   aa = 7601.00 .
            ELSE IF deci(wdetail.si) = 500000 THEN ASSIGN nv_dss_per = 15.75   aa = 7603.00 .   
            ELSE IF deci(wdetail.si) = 510000 THEN ASSIGN nv_dss_per = 16.50   aa = 7600.00 .          
            ELSE IF deci(wdetail.si) = 520000 THEN ASSIGN nv_dss_per = 17.27   aa = 7600.00 .         
            ELSE IF deci(wdetail.si) = 530000 THEN ASSIGN nv_dss_per = 18.03   aa = 7600.00 .
            ELSE IF deci(wdetail.si) = 540000 THEN ASSIGN nv_dss_per = 18.84   aa = 7606.00 .   
            ELSE IF deci(wdetail.si) = 550000 THEN ASSIGN nv_dss_per = 19.54   aa = 7603.00 .   
            ELSE IF deci(wdetail.si) = 560000 THEN ASSIGN nv_dss_per = 20.22   aa = 7600.00 .   
            ELSE IF deci(wdetail.si) = 570000 THEN ASSIGN nv_dss_per = 20.93   aa = 7600.00 .            
            ELSE IF deci(wdetail.si) = 580000 THEN ASSIGN nv_dss_per = 21.62   aa = 7600.00 .   
            ELSE IF deci(wdetail.si) = 590000 THEN ASSIGN nv_dss_per = 22.30   aa = 7600.00 .  
            ELSE IF deci(wdetail.si) = 600000 THEN ASSIGN nv_dss_per = 1.66    aa = 7601.00    WDETAIL.NCB = "30.00".    /*-เคาะแล้ว 1900 cc-*/
            ELSE IF deci(wdetail.si) = 610000 THEN ASSIGN nv_dss_per = 2.48    aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 620000 THEN ASSIGN nv_dss_per = 3.31    aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 630000 THEN ASSIGN nv_dss_per = 4.13    aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 640000 THEN ASSIGN nv_dss_per = 4.95    aa = 7602.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 650000 THEN ASSIGN nv_dss_per = 5.71    aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 660000 THEN ASSIGN nv_dss_per = 6.48    aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 670000 THEN ASSIGN nv_dss_per = 7.24    aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 680000 THEN ASSIGN nv_dss_per = 7.99    aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 690000 THEN ASSIGN nv_dss_per = 8.74    aa = 7601.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 700000 THEN ASSIGN nv_dss_per = 9.45    aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 710000 THEN ASSIGN nv_dss_per = 10.16   aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 720000 THEN ASSIGN nv_dss_per = 10.92   aa = 7605.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 730000 THEN ASSIGN nv_dss_per = 11.58   aa = 7602.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 740000 THEN ASSIGN nv_dss_per = 12.28   aa = 7604.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 750000 THEN ASSIGN nv_dss_per = 12.93   aa = 7602.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 760000 THEN ASSIGN nv_dss_per = 13.56   aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 770000 THEN ASSIGN nv_dss_per = 14.21   aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 780000 THEN ASSIGN nv_dss_per = 14.85   aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 790000 THEN ASSIGN nv_dss_per = 15.48   aa = 7600.00    WDETAIL.NCB = "30.00".
            ELSE IF deci(wdetail.si) = 800000 THEN ASSIGN nv_dss_per = 2.15    aa = 7602.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 810000 THEN ASSIGN nv_dss_per = 2.86    aa = 7602.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 820000 THEN ASSIGN nv_dss_per = 3.56    aa = 7601.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 830000 THEN ASSIGN nv_dss_per = 4.25    aa = 7601.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 840000 THEN ASSIGN nv_dss_per = 4.93    aa = 7601.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 850000 THEN ASSIGN nv_dss_per = 5.6     aa = 7601.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 860000 THEN ASSIGN nv_dss_per = 6.27    aa = 7601.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 870000 THEN ASSIGN nv_dss_per = 6.8     aa = 7601.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 880000 THEN ASSIGN nv_dss_per = 7.57    aa = 7601.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 890000 THEN ASSIGN nv_dss_per = 8.21    aa = 7601.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 900000 THEN ASSIGN nv_dss_per = 8.86    aa = 7603.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 910000 THEN ASSIGN nv_dss_per = 9.48    aa = 7603.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 920000 THEN ASSIGN nv_dss_per = 10.09   aa = 7603.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 930000 THEN ASSIGN nv_dss_per = 10.69   aa = 7603.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 940000 THEN ASSIGN nv_dss_per = 11.29   aa = 7603.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 950000 THEN ASSIGN nv_dss_per = 11.88   aa = 7603.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 960000 THEN ASSIGN nv_dss_per = 12.46   aa = 7603.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 970000 THEN ASSIGN nv_dss_per = 13.03   aa = 7603.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 980000 THEN ASSIGN nv_dss_per = 13.59   aa = 7603.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 990000 THEN ASSIGN nv_dss_per = 14.15   aa = 7603.00    WDETAIL.NCB = "40.00".
            ELSE IF deci(wdetail.si) = 1000000 THEN ASSIGN nv_dss_per = 14.7   aa = 7603.00    WDETAIL.NCB = "40.00".
        END.
        ELSE DO: /* 3000 */
            IF deci(wdetail.si) = 450000      THEN ASSIGN nv_dss_per = 9.31    aa = 7600  .
            ELSE IF deci(wdetail.si) = 460000 THEN ASSIGN nv_dss_per = 10.71   aa = 7604  .
            ELSE IF deci(wdetail.si) = 470000 THEN ASSIGN nv_dss_per = 11.98   aa = 7600  .
            ELSE IF deci(wdetail.si) = 480000 THEN ASSIGN nv_dss_per = 13.26   aa = 7600  .
            ELSE IF deci(wdetail.si) = 490000 THEN ASSIGN nv_dss_per = 14.52   aa = 7601  .
            ELSE IF deci(wdetail.si) = 500000 THEN ASSIGN nv_dss_per = 15.75   aa = 7603  .   
            ELSE IF deci(wdetail.si) = 510000 THEN ASSIGN nv_dss_per = 16.50   aa = 7600  .          
            ELSE IF deci(wdetail.si) = 520000 THEN ASSIGN nv_dss_per = 17.27   aa = 7600  .         
            ELSE IF deci(wdetail.si) = 530000 THEN ASSIGN nv_dss_per = 2.64    aa = 8002  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 540000 THEN ASSIGN nv_dss_per = 3.51    aa = 8001  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 550000 THEN ASSIGN nv_dss_per = 4.36    aa = 8000  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 560000 THEN ASSIGN nv_dss_per = 5.23    aa = 8001  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 570000 THEN ASSIGN nv_dss_per = 6.05    aa = 8000  WDETAIL.NCB = "20.00" .      
            ELSE IF deci(wdetail.si) = 580000 THEN ASSIGN nv_dss_per = 6.88    aa = 8000  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 590000 THEN ASSIGN nv_dss_per = 7.69    aa = 8000  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 600000 THEN ASSIGN nv_dss_per = 8.49    aa = 8001  WDETAIL.NCB = "20.00" .    
            ELSE IF deci(wdetail.si) = 610000 THEN ASSIGN nv_dss_per = 9.30    aa = 8003  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 620000 THEN ASSIGN nv_dss_per = 10.03   aa = 8000  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 630000 THEN ASSIGN nv_dss_per = 10.80   aa = 8001  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 640000 THEN ASSIGN nv_dss_per = 11.53   aa = 8000  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 650000 THEN ASSIGN nv_dss_per = 12.26   aa = 8000  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 660000 THEN ASSIGN nv_dss_per = 12.98   aa = 8000  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 670000 THEN ASSIGN nv_dss_per = 13.70   aa = 8001  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 680000 THEN ASSIGN nv_dss_per = 14.38   aa = 8000  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 690000 THEN ASSIGN nv_dss_per = 15.10   aa = 8003  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 700000 THEN ASSIGN nv_dss_per = 15.75   aa = 8001  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 710000 THEN ASSIGN nv_dss_per = 16.43   aa = 8003  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 720000 THEN ASSIGN nv_dss_per = 17.08   aa = 8002  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 730000 THEN ASSIGN nv_dss_per = 17.70   aa = 8000  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 740000 THEN ASSIGN nv_dss_per = 14.07   aa = 7600  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 750000 THEN ASSIGN nv_dss_per = 14.74   aa = 7601  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 760000 THEN ASSIGN nv_dss_per = 15.37   aa = 7600  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 770000 THEN ASSIGN nv_dss_per = 16.02   aa = 7601  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 780000 THEN ASSIGN nv_dss_per = 16.63   aa = 7600  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 790000 THEN ASSIGN nv_dss_per = 17.25   aa = 7600  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 800000 THEN ASSIGN nv_dss_per = 17.86   aa = 7600  WDETAIL.NCB = "20.00" .
            ELSE IF deci(wdetail.si) = 810000 THEN ASSIGN nv_dss_per = 6.81    aa = 7600  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 820000 THEN ASSIGN nv_dss_per = 7.52    aa = 7603  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 830000 THEN ASSIGN nv_dss_per = 8.15    aa = 7600  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 840000 THEN ASSIGN nv_dss_per = 8.83    aa = 7602  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 850000 THEN ASSIGN nv_dss_per = 9.45    aa = 7600  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 860000 THEN ASSIGN nv_dss_per = 10.11   aa = 7602  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 870000 THEN ASSIGN nv_dss_per = 10.71   aa = 7600  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 880000 THEN ASSIGN nv_dss_per = 11.33   aa = 7600  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 890000 THEN ASSIGN nv_dss_per = 11.94   aa = 7600  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 900000 THEN ASSIGN nv_dss_per = 12.57   aa = 7602  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 910000 THEN ASSIGN nv_dss_per = 13.14   aa = 7600  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 920000 THEN ASSIGN nv_dss_per = 13.74   aa = 7601  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 930000 THEN ASSIGN nv_dss_per = 14.35   aa = 7604  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 940000 THEN ASSIGN nv_dss_per = 14.91   aa = 7603  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 950000 THEN ASSIGN nv_dss_per = 15.44   aa = 7600  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 960000 THEN ASSIGN nv_dss_per = 16.02   aa = 7602  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 970000 THEN ASSIGN nv_dss_per = 16.54   aa = 7600  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 980000 THEN ASSIGN nv_dss_per = 17.13   aa = 7604  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 990000 THEN ASSIGN nv_dss_per = 17.62   aa = 7600  WDETAIL.NCB = "30.00" .
            ELSE IF deci(wdetail.si) = 1000000 THEN ASSIGN nv_dss_per = 4.50   aa = 7600  WDETAIL.NCB = "40.00" .
        END.                                                               
    END.                                                                        
    ELSE DO:  /*210 */ 
        RUN proc_dsp_ncb_210 .
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dsp_ncb1 C-Win 
PROCEDURE proc_dsp_ncb1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Add kridtiya i. A54-0271 ..ปรับเพิ่มช่วงทุน ...*/
ASSIGN 
    WDETAIL.NCB = "".
IF wdetail.subclass = "110" THEN DO:
    IF (wdetail.model <> "MU7") AND (wdetail.model <> "MU-7") THEN DO:
             IF wdetail.si = "470000" THEN ASSIGN nv_dss_per = 20.07   aa = 7602.00.
        ELSE IF wdetail.si = "480000" THEN ASSIGN nv_dss_per = 21.24   aa = 7602.00.
        ELSE IF wdetail.si = "490000" THEN ASSIGN nv_dss_per = 22.42   aa = 7607.00.
        ELSE IF wdetail.si = "500000" THEN ASSIGN nv_dss_per = 23.45   aa = 7601.00.
        ELSE IF wdetail.si = "510000" THEN ASSIGN nv_dss_per = 24.16 .          
        ELSE IF wdetail.si = "520000" THEN ASSIGN nv_dss_per = 24.86 .         
        ELSE IF wdetail.si = "530000" THEN ASSIGN nv_dss_per = 25.60   aa = 7606.00.
        ELSE IF wdetail.si = "540000" THEN ASSIGN nv_dss_per = 26.22 .  
        ELSE IF wdetail.si = "550000" THEN ASSIGN nv_dss_per = 26.95   aa = 7607.00.
        ELSE IF wdetail.si = "560000" THEN ASSIGN nv_dss_per = 27.55   aa = 7601.00.
        ELSE IF wdetail.si = "570000" THEN ASSIGN nv_dss_per = 28.18 .            
        ELSE IF wdetail.si = "580000" THEN ASSIGN nv_dss_per = 28.81 . 
        ELSE IF wdetail.si = "590000" THEN ASSIGN nv_dss_per = 29.45   aa = 7603.00.
        ELSE IF wdetail.si = "600000" THEN ASSIGN nv_dss_per = 30.05   aa = 7602.00.
        ELSE IF wdetail.si = "610000" THEN ASSIGN nv_dss_per = 30.63   .          
        ELSE IF wdetail.si = "620000" THEN ASSIGN nv_dss_per = 31.26   aa = 7605.00.
        ELSE IF wdetail.si = "630000" THEN ASSIGN nv_dss_per = 31.82   aa = 7603.00.
        ELSE IF wdetail.si = "640000" THEN ASSIGN nv_dss_per = 32.37   aa = 7601.00.
        ELSE IF wdetail.si = "650000" THEN ASSIGN nv_dss_per = 32.92 . 
        ELSE IF wdetail.si = "660000" THEN ASSIGN nv_dss_per = 31.23 .  
        ELSE IF wdetail.si = "670000" THEN ASSIGN nv_dss_per = 31.81   aa = 7603 .  
        ELSE IF wdetail.si = "680000" THEN ASSIGN nv_dss_per = 32.36   aa = 7603 .  
        ELSE IF wdetail.si = "690000" THEN ASSIGN nv_dss_per = 32.91   aa = 7604 .  
        ELSE IF wdetail.si = "700000" THEN ASSIGN nv_dss_per = 16.76                WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "710000" THEN ASSIGN nv_dss_per = 17.45   aa = 7603    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "720000" THEN ASSIGN nv_dss_per = 18.06                WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "730000" THEN ASSIGN nv_dss_per = 18.75   aa = 7605    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "740000" THEN ASSIGN nv_dss_per = 19.32                WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "750000" THEN ASSIGN nv_dss_per = 19.97   aa = 7603    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "760000" THEN ASSIGN nv_dss_per = 20.54                WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "770000" THEN ASSIGN nv_dss_per = 21.15   aa = 7601    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "780000" THEN ASSIGN nv_dss_per = 21.72                WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "790000" THEN ASSIGN nv_dss_per = 22.32   aa = 7601    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "800000" THEN ASSIGN nv_dss_per = 22.89   aa = 7601    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "810000" THEN ASSIGN nv_dss_per = 23.45   aa = 7601    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "820000" THEN ASSIGN nv_dss_per = 23.99                WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "830000" THEN ASSIGN nv_dss_per = 24.55   aa = 7601    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "840000" THEN ASSIGN nv_dss_per = 25.10   aa = 7602    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "850000" THEN ASSIGN nv_dss_per = 25.63   aa = 7602    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "860000" THEN ASSIGN nv_dss_per = 26.13                WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "870000" THEN ASSIGN nv_dss_per = 26.72   aa = 7608    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "880000" THEN ASSIGN nv_dss_per = 27.18   aa = 7603    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "890000" THEN ASSIGN nv_dss_per = 27.71   aa = 7606    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "900000" THEN ASSIGN nv_dss_per = 28.15                WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "910000" THEN ASSIGN nv_dss_per = 28.64                WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "920000" THEN ASSIGN nv_dss_per = 29.12                WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "930000" THEN ASSIGN nv_dss_per = 29.60                WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "940000" THEN ASSIGN nv_dss_per = 30.10   aa = 7604    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "950000" THEN ASSIGN nv_dss_per = 30.53                WDETAIL.NCB = "20.00".
    END.
    ELSE DO:  /*mu 7 */
             IF wdetail.si = "750000"   THEN ASSIGN nv_dss_per = 27.66    aa =  7606.00 . 
        ELSE IF wdetail.si = "760000"   THEN ASSIGN nv_dss_per = 28.20    aa =  7605.00 . 
        ELSE IF wdetail.si = "770000"   THEN ASSIGN nv_dss_per = 28.72    aa =  7603.00 .         
        ELSE IF wdetail.si = "780000"   THEN ASSIGN nv_dss_per = 29.26    aa =  7604.00 .        
        ELSE IF wdetail.si = "790000"   THEN ASSIGN nv_dss_per = 29.75    .             
        ELSE IF wdetail.si = "800000"   THEN ASSIGN nv_dss_per = 30.31    aa =  7605.00 .        
        ELSE IF wdetail.si = "810000"   THEN ASSIGN nv_dss_per = 30.79    aa =  7602.00 .         
        ELSE IF wdetail.si = "820000"   THEN ASSIGN nv_dss_per = 31.30    aa =  7603.00 .         
        ELSE IF wdetail.si = "830000"   THEN ASSIGN nv_dss_per = 31.77    .             
        ELSE IF wdetail.si = "840000"   THEN ASSIGN nv_dss_per = 32.29    aa =  7604.00 .         
        ELSE IF wdetail.si = "850000"   THEN ASSIGN nv_dss_per = 32.77    aa =  7604.00 .         
        ELSE IF wdetail.si = "860000"   THEN ASSIGN nv_dss_per = 29.36     .             
        ELSE IF wdetail.si = "870000"   THEN ASSIGN nv_dss_per = 29.87    aa =  7602.00 .         
        ELSE IF wdetail.si = "880000"   THEN ASSIGN nv_dss_per = 30.34                .             
        ELSE IF wdetail.si = "890000"   THEN ASSIGN nv_dss_per = 30.82           .             
        ELSE IF wdetail.si = "900000"   THEN ASSIGN nv_dss_per = 31.30    aa =  7601.00 .         
        ELSE IF wdetail.si = "910000"   THEN ASSIGN nv_dss_per = 31.76       .             
        ELSE IF wdetail.si = "920000"   THEN ASSIGN nv_dss_per = 32.22       .             
        ELSE IF wdetail.si = "930000"   THEN ASSIGN nv_dss_per = 32.69    aa =   7602.00 .         
        ELSE IF wdetail.si = "940000"   THEN ASSIGN nv_dss_per = 16.43    aa =   7602.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "950000"   THEN ASSIGN nv_dss_per = 16.96                      WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "960000"   THEN ASSIGN nv_dss_per = 17.57    aa =   7606.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "970000"   THEN ASSIGN nv_dss_per = 18.05    aa =   7601.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "980000"   THEN ASSIGN nv_dss_per = 18.64    aa =   7606.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "990000"   THEN ASSIGN nv_dss_per = 19.10                      WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "1000000"  THEN ASSIGN nv_dss_per = 19.63    aa =   7601.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "1050000"  THEN ASSIGN nv_dss_per = 22.37    aa =   7602.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "1100000"  THEN ASSIGN nv_dss_per = 24.92    aa =   7601.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "1150000"  THEN ASSIGN nv_dss_per = 27.30                      WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "1200000"  THEN ASSIGN nv_dss_per = 29.56    aa =   7602.00    WDETAIL.NCB = "20.00".
    END.
END.
ELSE DO:
         IF wdetail.si = "340000" THEN ASSIGN nv_dss_per = 15.71  . 
    ELSE IF wdetail.si = "350000" THEN ASSIGN nv_dss_per = 16.84   aa =  12002.00 . 
    ELSE IF wdetail.si = "360000" THEN ASSIGN nv_dss_per = 17.91  . 
    ELSE IF wdetail.si = "370000" THEN ASSIGN nv_dss_per = 18.97  . 
    ELSE IF wdetail.si = "380000" THEN ASSIGN nv_dss_per = 20.00  . 
    ELSE IF wdetail.si = "390000" THEN ASSIGN nv_dss_per = 21.00  . 
    ELSE IF wdetail.si = "400000" THEN ASSIGN nv_dss_per = 21.98  . 
    ELSE IF wdetail.si = "410000" THEN ASSIGN nv_dss_per = 22.94  . 
    ELSE IF wdetail.si = "420000" THEN ASSIGN nv_dss_per = 23.87  . 
    ELSE IF wdetail.si = "430000" THEN ASSIGN nv_dss_per = 24.78  . 
    ELSE IF wdetail.si = "440000" THEN ASSIGN nv_dss_per = 25.67  . 
    ELSE IF wdetail.si = "450000" THEN ASSIGN nv_dss_per = 26.54  aa =  12001.00 . 
    ELSE IF wdetail.si = "460000" THEN ASSIGN nv_dss_per = 27.38  . 
    ELSE IF wdetail.si = "470000" THEN ASSIGN nv_dss_per = 28.21  . 
    ELSE IF wdetail.si = "480000" THEN ASSIGN nv_dss_per = 29.02  . 
    ELSE IF wdetail.si = "490000" THEN ASSIGN nv_dss_per = 29.81  . 
    ELSE IF wdetail.si = "500000" THEN ASSIGN nv_dss_per = 30.61  aa = 12004 . 
    ELSE IF wdetail.si = "510000" THEN ASSIGN nv_dss_per = 31.35  aa = 12001 .
    ELSE IF wdetail.si = "520000" THEN ASSIGN nv_dss_per = 32.09  aa = 12001 .
    ELSE IF wdetail.si = "530000" THEN ASSIGN nv_dss_per = 32.81  . 
    ELSE IF wdetail.si = "540000" THEN ASSIGN nv_dss_per = 31.23  . 
    ELSE IF wdetail.si = "550000" THEN ASSIGN nv_dss_per = 31.95  . 
    ELSE IF wdetail.si = "560000" THEN ASSIGN nv_dss_per = 32.65  . 
    ELSE IF wdetail.si = "570000" THEN ASSIGN nv_dss_per = 33.34  . 
    ELSE IF wdetail.si = "580000" THEN ASSIGN nv_dss_per = 17.52                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "590000" THEN ASSIGN nv_dss_per = 18.35                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "600000" THEN ASSIGN nv_dss_per = 19.16                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "610000" THEN ASSIGN nv_dss_per = 19.97  aa =  12002   WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "620000" THEN ASSIGN nv_dss_per = 20.75  aa =  12002   WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "630000" THEN ASSIGN nv_dss_per = 21.50                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "640000" THEN ASSIGN nv_dss_per = 22.25                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "650000" THEN ASSIGN nv_dss_per = 23     aa=   12002   WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "660000" THEN ASSIGN nv_dss_per = 23.71                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "670000" THEN ASSIGN nv_dss_per = 24.44  aa =  12004   WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "680000" THEN ASSIGN nv_dss_per = 25.11                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "690000" THEN ASSIGN nv_dss_per = 25.79                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "700000" THEN ASSIGN nv_dss_per = 26.46                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "710000" THEN ASSIGN nv_dss_per = 27.12                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "720000" THEN ASSIGN nv_dss_per = 27.77                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "730000" THEN ASSIGN nv_dss_per = 28.41  aa = 12001    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "740000" THEN ASSIGN nv_dss_per = 29.03                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "750000" THEN ASSIGN nv_dss_per = 29.64                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "760000" THEN ASSIGN nv_dss_per = 30.25  aa = 12001    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "770000" THEN ASSIGN nv_dss_per = 30.84                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "780000" THEN ASSIGN nv_dss_per = 31.42                WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "790000" THEN ASSIGN nv_dss_per = 32.00  aa = 12001    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "800000" THEN ASSIGN nv_dss_per = 32.57  aa = 12002    WDETAIL.NCB = "20.00".
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dsp_ncb2 C-Win 
PROCEDURE proc_dsp_ncb2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Add kridtiya i. A54-0335 ..ปรับเพิ่มช่วงทุน ...*/
ASSIGN 
    WDETAIL.NCB = "".
IF index(wdetail.model,"mu-x") <> 0 THEN DO:      /* add A56-0353 */
         IF wdetail.si = "820000"   THEN ASSIGN nv_dss_per = 2.08    aa = 7802.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "830000"   THEN ASSIGN nv_dss_per = 2.76    aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "840000"   THEN ASSIGN nv_dss_per = 3.49    aa = 7803.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "850000"   THEN ASSIGN nv_dss_per = 4.16    aa = 7802.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "860000"   THEN ASSIGN nv_dss_per = 4.81    aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "870000"   THEN ASSIGN nv_dss_per = 5.49    aa = 7801.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "880000"   THEN ASSIGN nv_dss_per = 6.13    aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "890000"   THEN ASSIGN nv_dss_per = 6.78    aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "900000"   THEN ASSIGN nv_dss_per = 7.43    aa = 7801.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "910000"   THEN ASSIGN nv_dss_per = 8.06    aa = 7801.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "920000"   THEN ASSIGN nv_dss_per = 8.68    aa = 7801.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "930000"   THEN ASSIGN nv_dss_per = 9.29    aa = 7801.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "940000"   THEN ASSIGN nv_dss_per = 9.88    aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "950000"   THEN ASSIGN nv_dss_per = 10.48   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "960000"   THEN ASSIGN nv_dss_per = 11.07   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "970000"   THEN ASSIGN nv_dss_per = 11.65   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "980000"   THEN ASSIGN nv_dss_per = 12.22   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "990000"   THEN ASSIGN nv_dss_per = 12.79   aa = 7800.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "1000000"  THEN ASSIGN nv_dss_per = 13.37   aa = 7802.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "1050000"  THEN ASSIGN nv_dss_per = 13.45   aa = 7803.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "1100000"  THEN ASSIGN nv_dss_per = 16.31   aa = 7804.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "1150000"  THEN ASSIGN nv_dss_per = 16.88   aa = 7606.00    WDETAIL.NCB = "20.00".
    ELSE IF wdetail.si = "1200000"  THEN ASSIGN nv_dss_per = 7.87    aa = 7600.00    WDETAIL.NCB = "30.00".
    ELSE IF wdetail.si = "1250000"  THEN ASSIGN nv_dss_per = 10.66   aa = 7603.00    WDETAIL.NCB = "30.00".
    ELSE IF wdetail.si = "1300000"  THEN ASSIGN nv_dss_per = 13.26   aa = 7603.00    WDETAIL.NCB = "30.00".
END.   /* add A56-0353 */
ELSE DO:
    IF wdetail.subclass = "110" THEN DO:
        IF wdetail.si = "450000" THEN ASSIGN nv_dss_per =  9.31   aa = 7600.00 .
        ELSE IF wdetail.si = "460000" THEN ASSIGN nv_dss_per = 10.71   aa = 7604.00 .
        ELSE IF wdetail.si = "470000" THEN ASSIGN nv_dss_per = 11.98   aa = 7600.00 .
        ELSE IF wdetail.si = "480000" THEN ASSIGN nv_dss_per = 13.26   aa = 7600.00 .
        ELSE IF wdetail.si = "490000" THEN ASSIGN nv_dss_per = 14.52   aa = 7601.00 .
        ELSE IF wdetail.si = "500000" THEN ASSIGN nv_dss_per = 15.75   aa = 7603.00 .   
        ELSE IF wdetail.si = "510000" THEN ASSIGN nv_dss_per = 16.50   aa = 7600.00 .          
        ELSE IF wdetail.si = "520000" THEN ASSIGN nv_dss_per = 17.27   aa = 7600.00 .         
        ELSE IF wdetail.si = "530000" THEN ASSIGN nv_dss_per = 18.03   aa = 7600.00 .
        ELSE IF wdetail.si = "540000" THEN ASSIGN nv_dss_per = 18.84   aa = 7606.00 .   
        ELSE IF wdetail.si = "550000" THEN ASSIGN nv_dss_per = 19.54   aa = 7603.00 .   
        ELSE IF wdetail.si = "560000" THEN ASSIGN nv_dss_per = 20.22   aa = 7600.00 .   
        ELSE IF wdetail.si = "570000" THEN ASSIGN nv_dss_per = 20.93   aa = 7600.00 .            
        ELSE IF wdetail.si = "580000" THEN ASSIGN nv_dss_per = 21.62   aa = 7600.00 .   
        ELSE IF wdetail.si = "590000" THEN ASSIGN nv_dss_per = 22.30   aa = 7600.00 .  
        ELSE IF wdetail.si = "600000" THEN ASSIGN nv_dss_per = 22.97   aa = 7600.00 .
        ELSE IF wdetail.si = "610000" THEN ASSIGN nv_dss_per = 23.64   aa = 7601.00 .      
        ELSE IF wdetail.si = "620000" THEN ASSIGN nv_dss_per = 24.29   aa = 7602.00 .
        ELSE IF wdetail.si = "630000" THEN ASSIGN nv_dss_per = 24.92   aa = 7601.00 .   
        ELSE IF wdetail.si = "640000" THEN ASSIGN nv_dss_per = 25.56   aa = 7603.00 .   
        ELSE IF wdetail.si = "650000" THEN ASSIGN nv_dss_per = 26.15   aa = 7600.00 .   
        ELSE IF wdetail.si = "660000" THEN ASSIGN nv_dss_per = 26.76   aa = 7601.00 .   
        ELSE IF wdetail.si = "670000" THEN ASSIGN nv_dss_per = 27.35   aa = 7600.00 .  
        ELSE IF wdetail.si = "680000" THEN ASSIGN nv_dss_per = 27.96   aa = 7603.00 .  
        ELSE IF wdetail.si = "690000" THEN ASSIGN nv_dss_per = 28.51   aa = 7600.00 .  
        ELSE IF wdetail.si = "700000" THEN ASSIGN nv_dss_per = 11.36   aa = 7601.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "710000" THEN ASSIGN nv_dss_per = 12.08   aa = 7603.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "720000" THEN ASSIGN nv_dss_per = 12.73   aa = 7600.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "730000" THEN ASSIGN nv_dss_per = 13.42   aa = 7601.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "740000" THEN ASSIGN nv_dss_per = 14.07   aa = 7600.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "750000" THEN ASSIGN nv_dss_per = 14.74   aa = 7601.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "760000" THEN ASSIGN nv_dss_per = 15.37   aa = 7600.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "770000" THEN ASSIGN nv_dss_per = 16.02   aa = 7601.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "780000" THEN ASSIGN nv_dss_per = 16.63   aa = 7600.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "790000" THEN ASSIGN nv_dss_per = 17.25   aa = 7600.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "800000" THEN ASSIGN nv_dss_per = 17.86   aa = 7600.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "810000" THEN ASSIGN nv_dss_per = 18.47   aa = 7601.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "820000" THEN ASSIGN nv_dss_per = 19.06   aa = 7601.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "830000" THEN ASSIGN nv_dss_per = 19.64   aa = 7601.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "840000" THEN ASSIGN nv_dss_per = 20.20   aa = 7600.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "850000" THEN ASSIGN nv_dss_per = 20.79   aa = 7602.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "860000" THEN ASSIGN nv_dss_per = 21.38   aa = 7606.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "870000" THEN ASSIGN nv_dss_per = 22.04   aa = 7616.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "880000" THEN ASSIGN nv_dss_per = 22.47   aa = 7605.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "890000" THEN ASSIGN nv_dss_per = 22.95   aa = 7600.00    WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "900000" THEN ASSIGN nv_dss_per = 23.50   aa = 7602.00    WDETAIL.NCB = "20.00".
    END.
    ELSE DO:  /*210 */                                                
        IF     (wdetail.si >= "375000" ) AND (wdetail.si < "380000") THEN ASSIGN nv_dss_per = 11.74   aa = 12000.00 .
        ELSE IF wdetail.si = "380000"  THEN ASSIGN nv_dss_per = 11.74   aa = 12000.00 .
        ELSE IF wdetail.si = "390000"  THEN ASSIGN nv_dss_per = 12.85   aa = 12000.00 .        
        ELSE IF wdetail.si = "400000"  THEN ASSIGN nv_dss_per = 13.93   aa = 12000.00 .       
        ELSE IF wdetail.si = "410000"  THEN ASSIGN nv_dss_per = 14.99   aa = 12001.00 .
        ELSE IF wdetail.si = "420000"  THEN ASSIGN nv_dss_per = 16.02   aa = 12001.00 .       
        ELSE IF wdetail.si = "430000"  THEN ASSIGN nv_dss_per = 17.02   aa = 12000.00 .        
        ELSE IF wdetail.si = "440000"  THEN ASSIGN nv_dss_per = 18.00   aa = 12000.00 .        
        ELSE IF wdetail.si = "450000"  THEN ASSIGN nv_dss_per = 18.96   aa = 12001.00 .
        ELSE IF wdetail.si = "460000"  THEN ASSIGN nv_dss_per = 19.88   aa = 12000.00 .        
        ELSE IF wdetail.si = "470000"  THEN ASSIGN nv_dss_per = 20.80   aa = 12000.00 .        
        ELSE IF wdetail.si = "520000"  THEN ASSIGN nv_dss_per = 25.10   aa = 12004.00 .
        ELSE IF wdetail.si = "530000"  THEN ASSIGN nv_dss_per = 25.87   aa = 12000.00 .        
        ELSE IF wdetail.si = "540000"  THEN ASSIGN nv_dss_per = 26.66   aa = 12000.00 .          
        ELSE IF wdetail.si = "550000"  THEN ASSIGN nv_dss_per = 27.42   aa = 12000.00 .     
        ELSE IF wdetail.si = "560000"  THEN ASSIGN nv_dss_per = 28.17   aa = 12000.00 .        
        ELSE IF wdetail.si = "570000"  THEN ASSIGN nv_dss_per = 28.91   aa = 12000.00 . 
        ELSE IF wdetail.si = "580000"  THEN ASSIGN nv_dss_per = 29.63   aa = 12000.00 . 
        ELSE IF wdetail.si = "590000"  THEN ASSIGN nv_dss_per = 12.93   aa = 12001.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "600000"  THEN ASSIGN nv_dss_per = 13.80   aa = 12002.00   WDETAIL.NCB = "20.00".      
        ELSE IF wdetail.si = "610000"  THEN ASSIGN nv_dss_per = 14.65   aa = 12002.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "620000"  THEN ASSIGN nv_dss_per = 15.48   aa = 12002.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "630000"  THEN ASSIGN nv_dss_per = 16.28   aa = 12000.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "640000"  THEN ASSIGN nv_dss_per = 17.09   aa = 12001.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "650000"  THEN ASSIGN nv_dss_per = 17.87   aa = 12000.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "660000"  THEN ASSIGN nv_dss_per = 18.64   aa = 12000.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "670000"  THEN ASSIGN nv_dss_per = 29.01   aa = 12000.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "670000"  THEN ASSIGN nv_dss_per = 19.43   aa = 12006.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "680000"  THEN ASSIGN nv_dss_per = 20.14   aa = 12001.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "690000"  THEN ASSIGN nv_dss_per = 20.86   aa = 12000.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "700000"  THEN ASSIGN nv_dss_per = 21.61   aa = 12005.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "700000"  THEN ASSIGN nv_dss_per = 21.57   aa = 12000.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "710000"  THEN ASSIGN nv_dss_per = 22.28   aa = 12000.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "720000"  THEN ASSIGN nv_dss_per = 22.97   aa = 12000.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "730000"  THEN ASSIGN nv_dss_per = 23.69   aa = 12007.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "740000"  THEN ASSIGN nv_dss_per = 24.31   aa = 12000.00   WDETAIL.NCB = "20.00".
        ELSE IF wdetail.si = "750000"  THEN ASSIGN nv_dss_per = 24.99   aa = 12004.00   WDETAIL.NCB = "20.00".
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dsp_ncb_210 C-Win 
PROCEDURE proc_dsp_ncb_210 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   IF deci(wdetail.si) = 340000       THEN ASSIGN nv_dss_per = 7.01   aa = 12000 . 
    ELSE IF deci(wdetail.si) = 350000 THEN ASSIGN nv_dss_per = 8.24   aa = 12000 .
    ELSE IF deci(wdetail.si) = 360000 THEN ASSIGN nv_dss_per = 9.44   aa = 12000 .
    ELSE IF deci(wdetail.si) = 370000 THEN ASSIGN nv_dss_per = 10.62  aa = 12002 .
    ELSE IF deci(wdetail.si) = 380000 THEN ASSIGN nv_dss_per = 11.74  aa = 12000 .
    ELSE IF deci(wdetail.si) = 390000 THEN ASSIGN nv_dss_per = 12.85  aa = 12000 .
    ELSE IF deci(wdetail.si) = 400000 THEN ASSIGN nv_dss_per = 13.93  aa = 12000 .
    ELSE IF deci(wdetail.si) = 410000 THEN ASSIGN nv_dss_per = 14.99  aa = 12001 .
    ELSE IF deci(wdetail.si) = 420000 THEN ASSIGN nv_dss_per = 16.02  aa = 12001 .
    ELSE IF deci(wdetail.si) = 430000 THEN ASSIGN nv_dss_per = 17.02  aa = 12001 .
    ELSE IF deci(wdetail.si) = 440000 THEN ASSIGN nv_dss_per = 18.00  aa = 12001 .
    ELSE IF deci(wdetail.si) = 450000 THEN ASSIGN nv_dss_per = 2.72   aa = 12501  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 460000 THEN ASSIGN nv_dss_per = 3.86   aa = 12503  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 470000 THEN ASSIGN nv_dss_per = 4.95   aa = 12502  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 480000 THEN ASSIGN nv_dss_per = 6.03   aa = 12503  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 490000 THEN ASSIGN nv_dss_per = 7.07   aa = 12502  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 500000 THEN ASSIGN nv_dss_per = 8.09   aa = 12501  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 510000 THEN ASSIGN nv_dss_per = 9.09   aa = 12501  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 520000 THEN ASSIGN nv_dss_per = 10.07  aa = 12501  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 530000 THEN ASSIGN nv_dss_per = 11.03  aa = 12501  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 540000 THEN ASSIGN nv_dss_per = 11.97  aa = 12501  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 550000 THEN ASSIGN nv_dss_per = 12.89  aa = 12501  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 560000 THEN ASSIGN nv_dss_per = 13.8   aa = 12502  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 570000 THEN ASSIGN nv_dss_per = 14.67  aa = 12500  wdetail.ncb = "20.00" .
    ELSE IF deci(wdetail.si) = 580000 THEN ASSIGN nv_dss_per = 15.55  aa = 12502  WDETAIL.NCB = "20.00" .
    ELSE IF deci(wdetail.si) = 590000 THEN ASSIGN nv_dss_per = 16.39  aa = 12501  WDETAIL.NCB = "20.00" .
    ELSE IF deci(wdetail.si) = 600000 THEN ASSIGN nv_dss_per = 17.22  aa = 12501  WDETAIL.NCB = "20.00" .
    ELSE IF deci(wdetail.si) = 610000 THEN ASSIGN nv_dss_per = 14.65  aa = 12002  WDETAIL.NCB = "20.00" .
    ELSE IF deci(wdetail.si) = 620000 THEN ASSIGN nv_dss_per = 15.48  aa = 12002  WDETAIL.NCB = "20.00" .
    ELSE IF deci(wdetail.si) = 630000 THEN ASSIGN nv_dss_per = 16.28  aa = 12000  WDETAIL.NCB = "20.00" .
    ELSE IF deci(wdetail.si) = 640000 THEN ASSIGN nv_dss_per = 17.08  aa = 12000  WDETAIL.NCB = "20.00" .
    ELSE IF deci(wdetail.si) = 650000 THEN ASSIGN nv_dss_per = 17.87  aa = 12000  WDETAIL.NCB = "20.00" .
    ELSE IF deci(wdetail.si) = 660000 THEN ASSIGN nv_dss_per = 7.01   aa = 12000  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 670000 THEN ASSIGN nv_dss_per = 7.88   aa = 12000  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 680000 THEN ASSIGN nv_dss_per = 8.73   aa = 12001  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 690000 THEN ASSIGN nv_dss_per = 9.57   aa = 12002  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 700000 THEN ASSIGN nv_dss_per = 10.38  aa = 12001  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 710000 THEN ASSIGN nv_dss_per = 11.19  aa = 12002  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 720000 THEN ASSIGN nv_dss_per = 11.97  aa = 12001  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 730000 THEN ASSIGN nv_dss_per = 12.75  aa = 12001  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 740000 THEN ASSIGN nv_dss_per = 13.5   aa = 12000  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 750000 THEN ASSIGN nv_dss_per = 14.25  aa = 12000  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 760000 THEN ASSIGN nv_dss_per = 14.99  aa = 12001  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 770000 THEN ASSIGN nv_dss_per = 15.72  aa = 12002  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 780000 THEN ASSIGN nv_dss_per = 16.42  aa = 12000  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 790000 THEN ASSIGN nv_dss_per = 17.13  aa = 12002  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 800000 THEN ASSIGN nv_dss_per = 17.80  aa = 12000  WDETAIL.NCB = "30.00" .
    ELSE IF deci(wdetail.si) = 810000 THEN ASSIGN nv_dss_per = 4.90   aa = 12001  WDETAIL.NCB = "40.00" .
    ELSE IF deci(wdetail.si) = 820000 THEN ASSIGN nv_dss_per = 5.67   aa = 12001  WDETAIL.NCB = "40.00" .
    ELSE IF deci(wdetail.si) = 830000 THEN ASSIGN nv_dss_per = 6.44   aa = 12002  WDETAIL.NCB = "40.00" .
    ELSE IF deci(wdetail.si) = 840000 THEN ASSIGN nv_dss_per = 7.19   aa = 12002  WDETAIL.NCB = "40.00" .
    ELSE IF deci(wdetail.si) = 850000 THEN ASSIGN nv_dss_per = 7.93   aa = 12002  WDETAIL.NCB = "40.00" .

/*210*/
/*IF INT(wdetail.cc) <= 2000  THEN DO: /*1900*/
    IF     (deci(wdetail.si) >= 375000 ) AND (deci(wdetail.si) < 380000) THEN ASSIGN nv_dss_per = 11.74   aa = 12000.00 .
    ELSE IF deci(wdetail.si) = 380000  THEN ASSIGN nv_dss_per = 11.74   aa = 12000.00 .
    ELSE IF deci(wdetail.si) = 390000  THEN ASSIGN nv_dss_per = 12.85   aa = 12000.00 .        
    ELSE IF deci(wdetail.si) = 400000  THEN ASSIGN nv_dss_per = 13.93   aa = 12000.00 .       
    ELSE IF deci(wdetail.si) = 410000  THEN ASSIGN nv_dss_per = 14.99   aa = 12001.00 .
    ELSE IF deci(wdetail.si) = 420000  THEN ASSIGN nv_dss_per = 16.02   aa = 12001.00 .       
    ELSE IF deci(wdetail.si) = 430000  THEN ASSIGN nv_dss_per = 17.02   aa = 12000.00 .        
    ELSE IF deci(wdetail.si) = 440000  THEN ASSIGN nv_dss_per = 18.00   aa = 12000.00 .        
    ELSE IF deci(wdetail.si) = 450000  THEN ASSIGN nv_dss_per = 18.96   aa = 12001.00 .
    ELSE IF deci(wdetail.si) = 460000  THEN ASSIGN nv_dss_per = 19.88   aa = 12000.00 .        
    ELSE IF deci(wdetail.si) = 470000  THEN ASSIGN nv_dss_per = 20.80   aa = 12000.00 .
    ELSE IF deci(wdetail.si) = 480000  THEN ASSIGN nv_dss_per = 2.13    aa = 12001.00   WDETAIL.NCB = "20.00".  
    ELSE IF deci(wdetail.si) = 490000  THEN ASSIGN nv_dss_per = 3.22    aa = 12001.00   WDETAIL.NCB = "20.00". 
    ELSE IF deci(wdetail.si) = 500000  THEN ASSIGN nv_dss_per = 4.28    aa = 12000.00   WDETAIL.NCB = "20.00". 
    ELSE IF deci(wdetail.si) = 510000  THEN ASSIGN nv_dss_per = 5.33    aa = 12001.00   WDETAIL.NCB = "20.00". 
    ELSE IF deci(wdetail.si) = 520000  THEN ASSIGN nv_dss_per = 6.35    aa = 12000.00   WDETAIL.NCB = "20.00". 
    ELSE IF deci(wdetail.si) = 530000  THEN ASSIGN nv_dss_per = 7.35    aa = 12000.00   WDETAIL.NCB = "20.00".         
    ELSE IF deci(wdetail.si) = 540000  THEN ASSIGN nv_dss_per = 8.33    aa = 12001.00   WDETAIL.NCB = "20.00".          
    ELSE IF deci(wdetail.si) = 550000  THEN ASSIGN nv_dss_per = 9.29    aa = 12001.00   WDETAIL.NCB = "20.00".      
    ELSE IF deci(wdetail.si) = 560000  THEN ASSIGN nv_dss_per = 10.23   aa = 12001.00   WDETAIL.NCB = "20.00".               
    ELSE IF deci(wdetail.si) = 570000  THEN ASSIGN nv_dss_per = 11.15   aa = 12001.00   WDETAIL.NCB = "20.00".      
    ELSE IF deci(wdetail.si) = 580000  THEN ASSIGN nv_dss_per = 12.04   aa = 12000.00   WDETAIL.NCB = "20.00". 
    ELSE IF deci(wdetail.si) = 590000  THEN ASSIGN nv_dss_per = 12.93   aa = 12001.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 600000  THEN ASSIGN nv_dss_per = 13.80   aa = 12002.00   WDETAIL.NCB = "20.00".      
    ELSE IF deci(wdetail.si) = 610000  THEN ASSIGN nv_dss_per = 14.65   aa = 12002.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 620000  THEN ASSIGN nv_dss_per = 15.48   aa = 12002.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 630000  THEN ASSIGN nv_dss_per = 16.28   aa = 12000.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 640000  THEN ASSIGN nv_dss_per = 17.09   aa = 12001.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 650000  THEN ASSIGN nv_dss_per = 17.87   aa = 12000.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 660000  THEN ASSIGN nv_dss_per = 18.64   aa = 12000.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 670000  THEN ASSIGN nv_dss_per = 19.43   aa = 12006.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 680000  THEN ASSIGN nv_dss_per = 20.14   aa = 12001.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 690000  THEN ASSIGN nv_dss_per = 20.86   aa = 12000.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 700000  THEN ASSIGN nv_dss_per = 21.61   aa = 12005.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 710000  THEN ASSIGN nv_dss_per = 22.28   aa = 12000.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 720000  THEN ASSIGN nv_dss_per = 22.97   aa = 12000.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 730000  THEN ASSIGN nv_dss_per = 23.69   aa = 12007.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 740000  THEN ASSIGN nv_dss_per = 24.31   aa = 12000.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 750000  THEN ASSIGN nv_dss_per = 24.99   aa = 12004.00   WDETAIL.NCB = "20.00".
    ELSE IF deci(wdetail.si) = 760000  THEN ASSIGN nv_dss_per = 14.99   aa = 12001.00   WDETAIL.NCB = "30.00". 
    ELSE IF deci(wdetail.si) = 770000  THEN ASSIGN nv_dss_per = 15.72   aa = 12002.00   WDETAIL.NCB = "30.00". 
    ELSE IF deci(wdetail.si) = 780000  THEN ASSIGN nv_dss_per = 16.42   aa = 12000.00   WDETAIL.NCB = "30.00". 
    ELSE IF deci(wdetail.si) = 790000  THEN ASSIGN nv_dss_per = 17.13   aa = 12002.00   WDETAIL.NCB = "30.00". 
    ELSE IF deci(wdetail.si) = 800000  THEN ASSIGN nv_dss_per = 17.80   aa = 12000.00   WDETAIL.NCB = "30.00". 
    ELSE IF deci(wdetail.si) = 810000  THEN ASSIGN nv_dss_per = 4.90    aa = 12001.00   WDETAIL.NCB = "40.00". 
    ELSE IF deci(wdetail.si) = 820000  THEN ASSIGN nv_dss_per = 5.67    aa = 12001.00   WDETAIL.NCB = "40.00". 
    ELSE IF deci(wdetail.si) = 830000  THEN ASSIGN nv_dss_per = 6.44    aa = 12002.00   WDETAIL.NCB = "40.00". 
    ELSE IF deci(wdetail.si) = 840000  THEN ASSIGN nv_dss_per = 7.19    aa = 12002.00   WDETAIL.NCB = "40.00". 
    ELSE IF deci(wdetail.si) = 850000  THEN ASSIGN nv_dss_per = 7.93    aa = 12002.00   WDETAIL.NCB = "40.00".
END.
ELSE DO: /*3000*/*/
    
/*END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exportNote C-Win 
PROCEDURE proc_exportNote :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chNotesSession  As Com-Handle.
DEF VAR chNotesDataBase As Com-Handle.
DEF VAR chDocument      As Com-Handle.
DEF VAR chNotesView     As Com-Handle .
DEF VAR chDocument1     As Com-Handle.
DEF VAR chNotesView1    As Com-Handle .
DEF VAR chnotecollection    AS COM-HANDLE.
DEF VAR chItem          As Com-Handle .
DEF VAR chData          As Com-Handle .
DEF VAR nv_server       As Char.
DEF VAR nv_tmp          As char .
DEF VAR nv_extref       as char.
DEF VAR n_year          AS CHAR FORMAT "x(4)" .
DEF VAR n_day           AS CHAR FORMAT "x(15)" .
DEF VAR n_date          AS CHAR FORMAT "99/99/9999".
DEF VAR nv_name         AS CHAR FORMAT "x(25)".
DEF VAR n_pol           AS CHAR FORMAT "x(13)".
DEF VAR n_ems           AS CHAR FORMAT "x(14)".
DEF VAR nt_name         AS CHAR FORMAT "x(25)".
DEF VAR nt_policyno     AS CHAR FORMAT "x(12)".    
DEF VAR nt_date         AS DATE FORMAT "99/99/9999".     
DEF VAR nt_ems          AS CHAR FORMAT "x(14)".
DEF VAR n_snote         AS CHAR FORMAT "X(25)".

ASSIGN n_day       = STRING(TODAY,"99/99/9999")
       n_year      = SUBSTR(n_day,9,2)
       n_snote     = "postdocument" + n_year + ".nsf"
       nv_name      = "บ. ตรีเพชรฯ"      
       n_pol        = ""
       n_pol        = sicuw.uwm100.policy      
       nt_policyno  = ""                 
       nt_ems       = ""                 
       n_ems        = ""
       n_date       = ""
       nt_date      = ?.

       CREATE "Notes.NotesSession"  chNotesSession. 
       /*--------- Lotus Server Real ----------*/
       nv_tmp    = "safety\fi\" + n_snote.
       chNotesDatabase = chNotesSession:GetDatabase ("Safety_NotesServer/Safety",nv_tmp).
       /*-------------------------------------*/
       /*--------- Lotus Server test ----------
       nv_tmp    = "U:\Lotus\Notes\Data\" + n_snote.
       chNotesDatabase = chNotesSession:GetDatabase ("",nv_tmp).
       -------------------------------*/
       IF chNotesDatabase:IsOpen() = NO  THEN  DO:
          MESSAGE "Can not open database" SKIP  
                  "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
       END.
       chNotesView = chNotesDatabase:GetView("ByPol").
       chnotecollection = chNotesView:GetallDocumentsByKey(n_pol).
       chDocument  =  chnotecollection:GetlastDocument.
       IF VALID-HANDLE(chDocument) = YES THEN DO:
            
            chitem       = chDocument:Getfirstitem("PolicyNo"). 
            nt_policyno  = chitem:TEXT.                      
            chitem       = chDocument:Getfirstitem("EmsNo").     
            nt_ems       = chitem:TEXT.
            chitem       = chDocument:Getfirstitem("Date").     
            nt_date      = chitem:TEXT.                
           
        IF nt_ems <> "" THEN DO:
            ASSIGN wdetail2.regis_no   = TRIM(nt_ems)
                   wdetail2.SEND_date  = STRING(nt_date,"99/99/9999")
                   wdetail2.send_data  = STRING(TODAY,"99/99/9999").
        END.
        ELSE DO: 
            ASSIGN wdetail2.regis_no   = "-"
                   wdetail2.SEND_date  = "-"
                   wdetail2.send_data  = "-".
        END.
      END.
      RELEASE  OBJECT chNotesSession NO-ERROR.  
      RELEASE  OBJECT chNotesDataBase NO-ERROR. 
      RELEASE  OBJECT chDocument NO-ERROR.      
      RELEASE  OBJECT chNotesView NO-ERROR.     
      RELEASE  OBJECT chDocument1 NO-ERROR.     
      RELEASE  OBJECT chNotesView1 NO-ERROR.    
      RELEASE  OBJECT chnotecollection NO-ERROR.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_filetil_txt C-Win 
PROCEDURE proc_filetil_txt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: a62-0422 date 12/09/2019 format new       
------------------------------------------------------------------------------*/
If  substr(fi_output1,length(fi_output1) - 3,4) <>  ".CSV"  Then
    fi_output1  =  Trim(fi_output1) + ".CSV"  .
OUTPUT TO VALUE(fi_output1).
EXPORT DELIMITER ","
"Ins. Year type "                       /*1  */            
"Business type"                         /*2  */   
"TAS received by"                       /*3  */     
"Ins company"                           /*4  */ 
"Insurance ref no."                     /*5  */       
"TPIS Contract No."                     /*6  */       
"Title name"                            /*7  */
"customer name"                         /*8  */   
"customer lastname"                     /*9  */       
"Customer type"                         /*10 */
"Director Name"                         /*11 */
"ID number"                             /*12 */
"House no."                             /*13 */
"Building"                              /*14 */
"Village name/no."                      /*15 */
"Soi "                                  /*16 */
"Road"                                  /*17 */ 
"Sub-district"                          /*18 */
"District"                              /*19 */
"Province"                              /*20 */
"Postcode"                              /*21 */
"Brand "                                /*22 */
"Car model"                             /*23 */
"Insurance Code"                        /*24 */
"Model Year "                           /*25 */
"Usage Type "                           /*26 */
"Colour"                                /*27 */
"Car Weight "                           /*28 */
"Year"                                  /*29 */
"Engine No. "                           /*30 */
"Chassis No."                           /*31 */
"Accessories (for CV)"                  /*32 */
"Accessories amount"                    /*33 */                       
"License No."                           /*34 */    
"Registered Car License"                /*35 */    
"Campaign"                              /*36 */
"Type of work"                          /*37 */
"Garage Repair "                        /*38 */ 
"Model Description "                    /*39 */ 
"Insurance amount "                     /*40 */ 
"Insurance Date ( Voluntary )"          /*41 */                                      
"Expiry Date ( Voluntary) "             /*42 */                         
"Last Policy No. (Voluntary) "          /*43 */          
"Insurance Type "                       /*44 */ 
"Net premium (Voluntary)"               /*45 */     
"Gross premium (Voluntary)"             /*46 */                          
"Stamp"                                 /*47 */ 
"VAT"                                   /*48 */ 
"WHT"                                   /*49 */ 
"Compulsory No."                        /*50 */              
"Insurance Date ( Compulsory )"         /*51 */           
"Expiry Date ( Compulsory)"             /*52 */       
"Net premium (Compulsory)"              /*53 */      
"Gross premium (Compulsory)"            /*54 */        
"Stamp"                                 /*55 */ 
"VAT"                                   /*56 */ 
"WHT"                                   /*57 */ 
"Dealer"                                /*58 */ 
"Showroom"                              /*59 */ 
"Payment Type"                          /*60 */ 
"Beneficiery"                           /*61 */ 
"Mailing House no."                     /*62 */ 
"Mailing Building"                      /*63 */ 
"Mailing Village name/no."              /*64 */ 
"Mailing Soi"                           /*65 */ 
"Mailing Road"                          /*66 */ 
"Mailing Sub-district"                  /*67 */ 
"Mailing District"                      /*68 */ 
"Mailing Province"                      /*69 */ 
"Mailing Postcode"                      /*70 */ 
"Policy no. to customer date"           /*71 */ 
"New policy no"                         /*72 */ 
"Insurer Stamp Date"                    /*73 */ 
"Remark"                                /*74 */
"Occupation code".                      /*75 */
FOR EACH wdetail2 NO-LOCK.             
EXPORT DELIMITER ","
trim(Wdetail2.ins_ytyp)                                                                                 /*1  */
trim(wdetail2.bus_typ)                                                                                  /*2  */
trim(wdetail2.TASreceived)                                                                              /*3  */
trim(wdetail2.InsCompany)                                                                               /*4  */
trim(wdetail2.Insurancerefno)                                                                           /*5  */
trim(wdetail2.tpis_no)                                                                                  /*6  */
trim(wdetail2.ntitle)                                                                                   /*7  */
TRIM(wdetail2.insnam)                                                                                   /*8  */
TRIM(wdetail2.NAME2)                                                                                    /*9  */
trim(wdetail2.cust_type)                  /*จากไฟล์ */                                                  /*10 */
trim(wdetail2.nDirec)                                                                                   /*11 */
trim(wdetail2.ICNO)                                                                                     /*12 */
trim(wdetail2.address)                                                                                  /*13 */
trim(wdetail2.build)                                                                                    /*14 */
trim(wdetail2.mu)                                                                                       /*15 */
trim(wdetail2.soi)                                                                                      /*16 */
trim(wdetail2.road)                                                                                     /*17 */
trim(wdetail2.tambon)                                                                                   /*18 */
trim(wdetail2.amper)                                                                                    /*19 */
trim(wdetail2.country)                                                                                  /*20 */
trim(wdetail2.post)                                                                                     /*21 */
trim(wdetail2.brand)                      /*จากไฟล์*/                                                   /*22 */
trim(wdetail2.model)                      /*จากไฟล์*/                                                   /*23 */
trim(wdetail2.class)                                                                                    /*24 */
trim(wdetail2.md_year)                    /*จากไฟล์*/                                                   /*25 */
trim(wdetail2.Usage)                      /*จากไฟล์*/                                                   /*26 */
trim(wdetail2.coulor)                     /*จากไฟล์*/                                                   /*27 */
trim(wdetail2.cc)                         /*จากไฟล์*/                                                   /*28 */
trim(wdetail2.regis_year)                 /*จากไฟล์*/                                                   /*29 */
trim(wdetail2.engno)                                                                                    /*30 */
trim(wdetail2.chasno)                                                                                   /*31 */
trim(Wdetail2.Acc_CV)                    /*จากไฟล์*/                                                    /*32 */
trim(Wdetail2.Acc_amount) /*จากไฟล์*/                                                                   /*33 */
trim(wdetail2.License)                                                                                  /*34 */
trim(wdetail2.regis_CL)                                                                                 /*35 */
trim(wdetail2.campaign)                                                                                 /*36 */
trim(wdetail2.typ_work)                                                                                 /*37 */
trim(wdetail2.garage)             /*จากไฟล์*/                                                           /*38 */ 
trim(wdetail2.desmodel)           /*จากไฟล์*/                                                           /*39 */ 
TRIM(wdetail2.si)                                                                                       /*40 */ 
IF wdetail2.pol_comm_date <> "" THEN string(date(wdetail2.pol_comm_date),"99/99/9999") ELSE ""          /*41 */ 
IF wdetail2.pol_exp_date <> "" THEN string(date(wdetail2.pol_exp_date),"99/99/9999") ELSE ""            /*42 */ 
trim(wdetail2.LAST_pol)                                                                                 /*43 */ 
trim(wdetail2.cover)                                                                                    /*44 */ 
trim(wdetail2.pol_netprem)                                                                              /*45 */ 
trim(wdetail2.pol_gprem)                                                                                /*46 */ 
trim(wdetail2.pol_stamp)                                                                                /*47 */ 
trim(wdetail2.pol_vat)                                                                                  /*48 */ 
trim(wdetail2.pol_wht)               /*จากไฟล์ */                                                       /*49 */ 
trim(wdetail2.com_no)                                                                                   /*50 */ 
if wdetail2.com_comm_date <> "" THEN string(date(wdetail2.com_comm_date),"99/99/9999") ELSE ""          /*51 */ 
if wdetail2.com_exp_date <> "" THEN string(date(wdetail2.com_exp_date),"99/99/9999")  ELSE ""           /*52 */ 
trim(wdetail2.com_netprem)                                                                              /*53 */ 
trim(wdetail2.com_gprem)                                                                                /*54 */ 
trim(wdetail2.com_stamp)                                                                                /*55 */ 
trim(wdetail2.com_vat)               /*จากไฟล์*/                                                        /*56 */ 
trim(wdetail2.com_wht)               /*จากไฟล์*/                                                        /*57 */ 
trim(wdetail2.deler)                 /*จากไฟล์*/                                                        /*58 */ 
trim(wdetail2.showroom)              /*จากไฟล์*/                                                        /*59 */ 
trim(wdetail2.typepay)               /*จากไฟล์*/                                                        /*60 */ 
trim(wdetail2.financename)           /*จากไฟล์*/                                                        /*61 */ 
trim(wdetail2.mail_hno)              /*จากไฟล์*/                                                        /*62 */ 
trim(wdetail2.mail_build)            /*จากไฟล์*/                                                        /*63 */ 
trim(wdetail2.mail_mu)               /*จากไฟล์*/                                                        /*64 */ 
trim(wdetail2.mail_soi)              /*จากไฟล์*/                                                        /*65 */ 
trim(wdetail2.mail_road)             /*จากไฟล์*/                                                        /*66 */ 
trim(wdetail2.mail_tambon)           /*จากไฟล์*/                                                        /*67 */ 
trim(wdetail2.mail_amper)            /*จากไฟล์*/                                                        /*68 */ 
trim(wdetail2.mail_country)          /*จากไฟล์*/                                                        /*69 */ 
trim(wdetail2.mail_post)                                                                                /*70 */ 
trim(wdetail2.send_date)                                                                                /*71 */ 
trim(wdetail2.policy_no)                                                                                /*72 */ 
trim(wdetail2.send_data)                                                                                /*73 */ 
trim(wdetail2.REMARK1)                                                                                  /*74 */
trim(wdetail2.occup).                                                                                   /*75*/
END.                                                                                                   
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initcal C-Win 
PROCEDURE proc_initcal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
     nv_polday  = 0                nv_flag    =  NO   /*A68-0044*/
     nv_covcod  = ""               nv_garage  =  ""   /*A68-0044*/
     nv_class   = ""               nv_31prmt  =  0    /*A68-0044*/
     nv_vehuse  = ""               nv_31rate  =  0    /*A68-0044*/
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
     nv_41prmt  = 0
     nv_412prmt = 0  /*A65-0079*/
     nv_413prmt = 0  /*A65-0079*/
     nv_414prmt = 0  /*A65-0079*/
     nv_42prmt  = 0
     nv_43prmt  = 0
     nv_seat41  = 0          
     nv_dedod   = 0
     nv_addod   = 0
     nv_dedpd   = 0        
     nv_ncbp    = 0
     nv_fletp   = 0
     nv_dspcp   = 0
     nv_dstfp   = 0
     nv_clmp    = 0
     /* A65-0079*/
     nv_mainprm = 0 
     nv_ncbamt  = 0 
     nv_fletamt = 0 
     nv_dspcamt = 0 
     nv_dstfamt = 0 
     nv_clmamt  = 0 
     /* end : A65-0079 */
     nv_baseprm  = 0
     nv_baseprm3 = 0
     nv_pdprem   = 0
     nv_netprem  = 0    /*เบี้ยสุทธิ */
     nv_gapprm   = 0    /*เบี้ยรวม */
     nv_flagprm  = "N"  /* N = เบี้ยสุทธิ, G = เบี้ยรวม */
     nv_effdat   = ?    
     nv_ratatt   = 0    
     nv_siatt    = 0    
     nv_netatt   = 0    
     nv_fltatt   = 0    
     nv_ncbatt   = 0    
     nv_dscatt   = 0    
     nv_atfltgap = 0   /*A65-0079*/
     nv_atncbgap = 0   /*A65-0079*/
     nv_atdscgap = 0   /*A65-0079*/
     nv_packatt  = ""  /*A65-0079*/
     nv_flgsht   = ""  /*A65-0079*/
     nv_status   = "" 
     nv_fcctv    = NO
     nv_uom1_c   = "" 
     nv_uom2_c   = "" 
     nv_uom5_c   = "" 
     nv_uom6_c   = "" 
     nv_uom7_c   = ""
     nv_message  = "" 
     /* A67-0029*/
     nv_level    = 0 
     nv_levper   = 0
     nv_tariff   = ""
     nv_adjpaprm   = NO
     nv_flgpol     = ""
     nv_flgclm     = ""
     /*nv_ncbyrs     = 0*/
     nv_chgflg     = NO    
     nv_chgrate    = 0    
     nv_chgsi      = 0    
     nv_chgpdprm   = 0    
     nv_chggapprm  = 0    
     nv_battflg    = NO    
     nv_battrate   = 0    
     nv_battsi     = 0    
     nv_battprice  = 0    
     nv_battpdprm  = 0    
     nv_battgapprm = 0    
     nv_battyr     = 0    
     nv_battper    = 0
     nv_evflg      = NO .
 /* end A67-0029*/
 /* add by : A68-0061 */
 IF index(wdetail.subclass,"E") <> 0 THEN ASSIGN cv_lncbper = 40.
 /*ELSE IF wdetail.prepol <> ""  THEN ASSIGN cv_lncbper = 50.*/
 ELSE ASSIGN cv_lncbper = 40.
 /* end : A68-0061 */

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
DEFINE VAR nv_transfer  AS LOGICAL   .
DEF  VAR nv_insname AS CHAR .
ASSIGN  nv_insname = ""
    n_insref      = ""  
    n_check       = ""
    nv_insref     = "" 
    nv_transfer   = YES
    nv_insname    = TRIM(TRIM(wdetail.firstname) + " " + TRIM(wdetail.lastname)) . 
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    /*sicsyac.xmm600.NAME   = TRIM(wdetail.insnam)   AND */ /*A66-0084*/
    sicsyac.xmm600.NAME     =  nv_insname AND       /*A66-0084*/
    /*sicsyac.xmm600.homebr = TRIM(wdetail.branch)   NO-ERROR NO-WAIT. *//*A56-0047*/
    sicsyac.xmm600.homebr   = TRIM(wdetail.branch)   AND                   /*A56-0047*/
    sicsyac.xmm600.clicod   = "IN"                   NO-ERROR NO-WAIT.     /*A56-0047*/
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
            /*sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/        A66-0084*/
            /*sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/   A66-0084*/
            sicsyac.xmm600.name     = nv_insname /*Name Line 1*/        /*A66-0084*/   
            sicsyac.xmm600.abname   = nv_insname /*Abbreviated Name*/   /*A66-0084*/   
            sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1    = wdetail.iadd1             /*Address line 1*/
            sicsyac.xmm600.addr2    = wdetail.iadd2             /*Address line 2*/
            sicsyac.xmm600.addr3    = wdetail.iadd3             /*Address line 3*/
            sicsyac.xmm600.addr4    = wdetail.iadd4             /*Address line 4*/           
            sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                     
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4) 
            sicsyac.xmm600.dtyp20   = ""
            sicsyac.xmm600.dval20   = ""  .
    END.
END.
IF nv_transfer = YES THEN DO:     
    ASSIGN  sicsyac.xmm600.acno = nv_insref                /*Account no*/
        sicsyac.xmm600.gpstcs   = nv_insref                /*Group A/C for statistics*/
        sicsyac.xmm600.gpage    = ""                       /*Group A/C for ageing*/
        sicsyac.xmm600.gpstmt   = ""                       /*Group A/C for Statement*/
        sicsyac.xmm600.or1ref   = ""                       /*OR Agent 1 Ref. No.*/
        sicsyac.xmm600.or2ref   = ""                       /*OR Agent 2 Ref. No.*/
        sicsyac.xmm600.or1com   = 0                        /*OR Agent 1 Comm. %*/
        sicsyac.xmm600.or2com   = 0                        /*OR Agent 2 Comm. %*/
        sicsyac.xmm600.or1gn    = "G"                      /*OR Agent 1 Gross/Net*/
        sicsyac.xmm600.or2gn    = "G"                      /*OR Agent 2 Gross/Net*/
        sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)     /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                       /*First Name*/
        /*sicsyac.xmm600.name     = TRIM(wdetail.insnam)     /*Name Line 1*/       */ /*A66-0084*/
        /*sicsyac.xmm600.abname   = TRIM(wdetail.insnam)     /*Abbreviated Name*/  */ /*A66-0084*/
        sicsyac.xmm600.name     = nv_insname   /*Name Line 1*/       /*A66-0084*/
        sicsyac.xmm600.abname   = nv_insname   /*Abbreviated Name*/  /*A66-0084*/
        sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)       /*IC No.*/     /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = wdetail.iadd1            /*Address line 3*/            /*Address line 1*/
        sicsyac.xmm600.addr2    = wdetail.iadd2            /*Address line 2*/
        sicsyac.xmm600.addr3    = wdetail.iadd3            /*Address line 3*/
        sicsyac.xmm600.addr4    = wdetail.iadd4            /*Address line 4*/
        sicsyac.xmm600.postcd   = ""                       /*Postal Code*/
        sicsyac.xmm600.clicod   = "IN"                     /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                     /*Account type code*/
        sicsyac.xmm600.relate   = ""                       /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                       /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                       /*Notes line 2*/
        sicsyac.xmm600.homebr   = TRIM(wdetail.branch)     /*Home branch*/
        sicsyac.xmm600.opened   = TODAY                    /*Date A/C opened*/
        sicsyac.xmm600.prindr   = 1                        /*No. to print Dr/Cr N., default*/
        sicsyac.xmm600.langug   = ""                       /*Language Code*/
        sicsyac.xmm600.cshdat   = ?                        /*Cash terms wef date*/
        sicsyac.xmm600.legal    = ""                       /*Legal action pending/closed*/
        sicsyac.xmm600.stattp   = "I"                      /*Statement type I/B/N*/
        sicsyac.xmm600.autoap   = NO                       /*Automatic cash matching*/
        sicsyac.xmm600.ltcurr   = "BHT"                    /*Credit limit currency*/
        sicsyac.xmm600.ltamt    = 0                        /*Credit limit amount*/
        sicsyac.xmm600.exec     = ""                       /*Executive responsible*/
        sicsyac.xmm600.cntry    = "TH"                     /*Country code*/
        sicsyac.xmm600.phone    = ""                       /*Phone no.*/
        sicsyac.xmm600.closed   = ?                        /*Date A/C closed*/
        sicsyac.xmm600.crper    = 0                        /*Credit period*/
        sicsyac.xmm600.pvfeq    = 0                        /*PV frequency/Type code*/
        sicsyac.xmm600.comtab   = 1                        /*Commission table no*/
        sicsyac.xmm600.chgpol   = YES                      /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                    /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")  /*Entry time*/
        sicsyac.xmm600.usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4)               /*Userid*/
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
        sicsyac.xmm600.naddr1   = ""                      /*New address line 1*/
        sicsyac.xmm600.gstreg   = ""                       /*GST Registration No.*/
        sicsyac.xmm600.naddr2   = ""                     /*New address line 2*/
        sicsyac.xmm600.fax      = ""                       /*Fax No.*/
        sicsyac.xmm600.naddr3   = ""                      /*New address line 3*/
        sicsyac.xmm600.telex    = ""                       /*Telex No.*/
        sicsyac.xmm600.naddr4   = ""                      /*New address line 4*/
        sicsyac.xmm600.name2    = ""                       /*Name Line 2*/
        sicsyac.xmm600.npostcd  = ""                       /*New postal code*/
        sicsyac.xmm600.name3    = ""                       /*Name Line 3*/
        sicsyac.xmm600.nphone   = ""                        /*New phone no.*/    
        sicsyac.xmm600.nachg    = YES                      /*Change N&A on Renewal/Endt*/
        sicsyac.xmm600.regdate  = ?                        /*Agents registration Date*/
        sicsyac.xmm600.alevel   = 0                        /*Agency Level*/
        sicsyac.xmm600.taxno    = ""                       /*Agent tax no.*/
        sicsyac.xmm600.anlyc1   = ""                       /*Analysis Code 1*/
        sicsyac.xmm600.taxdate  = ?                        /*Agent tax date*/
        sicsyac.xmm600.anlyc5   =  ""                      /*Analysis Code 5*/
        sicsyac.xmm600.dtyp20   = ""
        sicsyac.xmm600.dval20   = "".
    IF wdetail.inscod = "" THEN
        ASSIGN /* comment by : A66-0084...
            sicsyac.xmm600.nphone   = IF R-INDEX(TRIM(wdetail.insnam),"(") <> 0 THEN 
                                             TRIM(wdetail.tiname) + " " + trim(SUBSTR(TRIM(wdetail.insnam),1,r-INDEX(TRIM(wdetail.insnam),"(") - 1 )) 
                                         /*ELSE TRIM(wdetail.insnam) /*New phone no.*/ *//*A58-0092*/
            ELSE TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam)   /*New phone no.*/  /*A58-0092*/
            ...end A66-0084...*/
            sicsyac.xmm600.nphone   = trim(TRIM(wdetail.tiname) + " " + nv_insname)  /*A66-0084*/
            sicsyac.xmm600.naddr1   = wdetail.iadd1    
            sicsyac.xmm600.naddr2   = wdetail.iadd2        /*New address line 2*/
            sicsyac.xmm600.naddr3   = wdetail.iadd3        /*New address line 3*/
            sicsyac.xmm600.naddr4   = wdetail.iadd4  .      /*New address line 4*/
        
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
            sicsyac.xtm600.acno      = nv_insref             /*Account no.*/
            /*sicsyac.xtm600.name      = TRIM(wdetail.insnam)  /*Name of Insured Line 1*/*/  /*A66-0084*/
            /*sicsyac.xtm600.abname    = TRIM(wdetail.insnam)  /*Abbreviated Name*/*/        /*A66-0084*/
            sicsyac.xtm600.name      = nv_insname  /*Name of Insured Line 1*/  /*A66-0084*/  
            sicsyac.xtm600.abname    = nv_insname  /*Abbreviated Name*/        /*A66-0084*/  
            sicsyac.xtm600.addr1     = wdetail.iadd1         /*address line 1*/
            sicsyac.xtm600.addr2     = wdetail.iadd2         /*address line 2*/
            sicsyac.xtm600.addr3     = wdetail.iadd3         /*address line 3*/
            sicsyac.xtm600.addr4     = wdetail.iadd4         /*address line 4*/
            sicsyac.xtm600.name2     = ""                    /*Name of Insured Line 2*/ 
            sicsyac.xtm600.ntitle    = TRIM(wdetail.tiname)  /*Title*/
            sicsyac.xtm600.name3     = ""                    /*Name of Insured Line 3*/
            sicsyac.xtm600.fname     = ""   .                /*First Name*/
            
    END.
END.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
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
    sicsyac.xmm600.acno     =  nv_insref   NO-ERROR NO-WAIT.  
IF AVAIL sicsyac.xmm600 THEN
    ASSIGN
    sicsyac.xmm600.acno_typ  = trim(wdetail.insnamtyp)   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    sicsyac.xmm600.icno      = trim(wdetail.icno)       
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/    .  

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
DEF VAR n_search   AS LOGICAL INIT YES .                          
DEF VAR nv_lastno  AS INT INIT 0.                                  
DEF VAR nv_seqno   AS INT INIT 0.                                  

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
            sicsyac.xzm056.branch    =  TRIM(wdetail.branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(TRIM(wdetail.branch)) = 2 THEN
            nv_insref = TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.branch) = "A") OR (TRIM(wdetail.branch) = "B") THEN DO:
                     nv_insref = "7" + TRIM(wdetail.branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail.branch) = "A") OR (TRIM(wdetail.branch) = "B") THEN DO:
                     nv_insref = "7" + TRIM(wdetail.branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref =       TRIM(wdetail.branch) + "C" + STRING(sicsyac.xzm056.lastno,"99999").
            END.
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
        IF LENGTH(TRIM(wdetail.branch)) = 2 THEN
            nv_insref = TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.branch) = "A") OR (TRIM(wdetail.branch) = "B") THEN DO:
                     nv_insref = "7" + TRIM(wdetail.branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail.branch) = "A") OR (TRIM(wdetail.branch) = "B") THEN DO:
                     nv_insref = "7" + TRIM(wdetail.branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref =       TRIM(wdetail.branch) + "C" + STRING(sicsyac.xzm056.lastno,"99999").
            END.
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
FIND  LAST brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
           brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
           brstat.mailtxt_fil.bchyr   = nv_batchyr   AND                                               
           brstat.mailtxt_fil.bchno   = nv_batchno   AND
           brstat.mailtxt_fil.bchcnt  = nv_batcnt    AND 
           brstat.mailtxt_fil.lnumber = n_count      NO-ERROR  NO-WAIT.
    IF NOT AVAIL brstat.mailtxt_fil THEN DO:  
          nv_lnumber =  n_count.  
          CREATE brstat.mailtxt_fil.
          ASSIGN                                           
                 brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                 brstat.mailtxt_fil.bchyr   = nv_batchyr   
                 brstat.mailtxt_fil.bchno   = nv_batchno   
                 brstat.mailtxt_fil.bchcnt  = nv_batcnt 

                 brstat.mailtxt_fil.lnumber   = nv_lnumber
                 brstat.mailtxt_fil.ltext     = nv_drinam + FILL(" ",50 - LENGTH(nv_drinam)) + nv_dgender  
                 brstat.mailtxt_fil.ltext2    = nv_dbirth + "  " + string(nv_dage)  /* พ.ศ. */
                 SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)   =  IF nv_doccup  = "" THEN "-" ELSE nv_doccup 
                 SUBSTRING(brstat.mailtxt_fil.ltext2,101,50)  =  nv_dicno
                 SUBSTRING(brstat.mailtxt_fil.ltext2,151,50)  =  nv_ddriveno 
                 SUBSTRING(brstat.mailtxt_fil.ltext2,201,4)   =  "" 
                 brstat.mailtxt_fil.titlenam   = nv_ntitle
                 brstat.mailtxt_fil.firstnam   = nv_name  
                 brstat.mailtxt_fil.lastnam    = nv_lname 
                 brstat.mailtxt_fil.drivbirth  = IF trim(nv_dribirth) <> "" THEN date(nv_dribirth) ELSE ? /* ค.ศ */
                 brstat.mailtxt_fil.drivage    = nv_dage
                 brstat.mailtxt_fil.occupcod   = "-" 
                 brstat.mailtxt_fil.drividno   = nv_dicno
                 brstat.mailtxt_fil.licenno    = nv_ddriveno
                 brstat.mailtxt_fil.gender     = nv_dgender
                 brstat.mailtxt_fil.drivlevel  = nv_dlevel
                 brstat.mailtxt_fil.levelper   = deci(nv_dlevper)
                 brstat.mailtxt_fil.licenexp   = IF trim(nv_drivexp) <> "" THEN DATE(nv_drivexp) ELSE ?
                 brstat.mailtxt_fil.dconsen    = IF nv_dconsent = "N" THEN NO ELSE YES 
                 brstat.mailtxt_fil.occupdes   = IF nv_doccup  = "" THEN "-" ELSE nv_doccup
                 brstat.mailtxt_fil.cardflg    = "" .
    END. /*End Avail Brstat*/
    ELSE DO:
        nv_lnumber =  n_count. 
        ASSIGN                                           
             brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
             brstat.mailtxt_fil.bchyr   = nv_batchyr   
             brstat.mailtxt_fil.bchno   = nv_batchno   
             brstat.mailtxt_fil.bchcnt  = nv_batcnt 
        
             brstat.mailtxt_fil.lnumber   = nv_lnumber
             brstat.mailtxt_fil.ltext     = nv_drinam + FILL(" ",50 - LENGTH(nv_drinam)) + nv_dgender  
             brstat.mailtxt_fil.ltext2    = nv_dbirth + "  " + string(nv_dage)  /* พ.ศ. */
             SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)   =  IF nv_doccup  = "" THEN "-" ELSE nv_doccup 
             SUBSTRING(brstat.mailtxt_fil.ltext2,101,50)  =  nv_dicno
             SUBSTRING(brstat.mailtxt_fil.ltext2,151,50)  =  nv_ddriveno 
             SUBSTRING(brstat.mailtxt_fil.ltext2,201,4)   =  "" 
             brstat.mailtxt_fil.titlenam   = nv_ntitle
             brstat.mailtxt_fil.firstnam   = nv_name  
             brstat.mailtxt_fil.lastnam    = nv_lname 
             brstat.mailtxt_fil.drivbirth  = IF trim(nv_dribirth) <> "" THEN date(nv_dribirth) ELSE ? /* ค.ศ. */
             brstat.mailtxt_fil.drivage    = nv_dage
             brstat.mailtxt_fil.occupcod   = "-"  
             brstat.mailtxt_fil.drividno   = nv_dicno
             brstat.mailtxt_fil.licenno    = nv_ddriveno
             brstat.mailtxt_fil.gender     = nv_dgender
             brstat.mailtxt_fil.drivlevel  = nv_dlevel
             brstat.mailtxt_fil.levelper   = deci(nv_dlevper)
             brstat.mailtxt_fil.licenexp   = IF trim(nv_drivexp) <> "" THEN DATE(nv_drivexp) ELSE ?
             brstat.mailtxt_fil.dconsen    = IF nv_dconsent = "N" THEN NO ELSE YES 
             brstat.mailtxt_fil.occupdes   = IF nv_doccup  = "" THEN "-" ELSE nv_doccup
             brstat.mailtxt_fil.cardflg    = "" .
    END.
    RELEASE brstat.mailtxt_fil .

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

    FIND LAST stat.insure USE-INDEX insure01  WHERE   
    stat.insure.compno = fi_mocode               AND          
    stat.insure.fname  = wdetail.model         NO-ERROR NO-WAIT.
    IF AVAIL insure THEN  
        ASSIGN n_model =  stat.insure.lname   .
    ELSE ASSIGN n_model =  wdetail.model .
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,n_model) <> 0              And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        /*stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass                AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
         stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1  / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)       No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then DO:
        ASSIGN  
        nv_modcod              =  stat.maktab_fil.modcod                                    
        /*nv_moddes              =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes */ /*A61-0152*/
        wdetail.cargrp         =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp = stat.maktab_fil.prmpac             /*A61-0152*/
        wdetail.redbook        =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod .
    END. /*Add A55-0107 ...*/
    /* add by : A66-0252 */
    ELSE IF wdetail.poltyp = "V72" THEN DO:
        ASSIGN n_model = ""
               n_model = TRIM(TRIM(wdetail.brand) + " " + TRIM(wdetail.model)).
        FIND LAST sicsyac.xmm102 WHERE index(n_model,xmm102.moddes) <> 0 NO-LOCK NO-ERROR.
        IF AVAIL xmm102 THEN DO:
         ASSIGN wdetail.redbook         = xmm102.modcod 
                sic_bran.uwm301.vehgrp  = sicsyac.xmm102.vehgrp
                sic_bran.uwm301.modcod  = sicsyac.xmm102.modcod.
        END.
        ELSE DO:
             FIND LAST sicsyac.xmm102 WHERE index(xmm102.moddes,wdetail.brand) <> 0 NO-LOCK NO-ERROR.
                IF AVAIL xmm102 THEN DO:
                 ASSIGN wdetail.redbook         = xmm102.modcod 
                        sic_bran.uwm301.vehgrp  = sicsyac.xmm102.vehgrp
                        sic_bran.uwm301.modcod  = sicsyac.xmm102.modcod.
                END.
        END.
    END.
    /* end : A66-0252 */
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchbranch C-Win 
PROCEDURE proc_matchbranch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /* comment by : A64-0344...
 IF      trim(wdetail2.branch) = "14"  THEN ASSIGN wdetail2.bran_name  = "กรุงเทพ"                   wdetail2.bran_name2 = "ปริมณฑล" wdetail2.region = "ปริมณฑล".
 ELSE IF trim(wdetail2.branch) = "12"  THEN ASSIGN wdetail2.bran_name  = "กรุงเทพ"                   wdetail2.bran_name2 = "ปริมณฑล" wdetail2.region = "ปริมณฑล".
 ELSE IF trim(wdetail2.branch) = "T"   THEN ASSIGN wdetail2.bran_name  = "สมุทรปราการ(เทพารักษ์)"    wdetail2.bran_name2 = "ปริมณฑล" wdetail2.region = "ปริมณฑล".
 ELSE IF trim(wdetail2.branch) = "R"   THEN ASSIGN wdetail2.bran_name  = "ราชพฤกษ์"                  wdetail2.bran_name2 = "สาขา"    wdetail2.region = "กรุงเทพและปริมณฑล".
 ELSE IF trim(wdetail2.branch) = "91"  THEN ASSIGN wdetail2.bran_name  = "ถนนเพชรบุรีตัดใหม่"        wdetail2.bran_name2 = "สาขา"    wdetail2.region = "กรุงเทพและปริมณฑล".
 ELSE IF trim(wdetail2.branch) = "92"  THEN ASSIGN wdetail2.bran_name  = "ถนนเพชรบุรีตัดใหม่"        wdetail2.bran_name2 = "สาขา"    wdetail2.region = "กรุงเทพและปริมณฑล".
 ELSE IF trim(wdetail2.branch) = "93"  THEN ASSIGN wdetail2.bran_name  = "ถนนเพชรบุรีตัดใหม่"        wdetail2.bran_name2 = "สาขา"    wdetail2.region = "กรุงเทพและปริมณฑล".
 ELSE IF trim(wdetail2.branch) = "94"  THEN ASSIGN wdetail2.bran_name  = "ถนนเพชรบุรีตัดใหม่"        wdetail2.bran_name2 = "สาขา"    wdetail2.region = "กรุงเทพและปริมณฑล".
 ELSE IF trim(wdetail2.branch) = "95"  THEN ASSIGN wdetail2.bran_name  = "ถนนเพชรบุรีตัดใหม่"        wdetail2.bran_name2 = "สาขา"    wdetail2.region = "กรุงเทพและปริมณฑล".
 ELSE IF trim(wdetail2.branch) = "96"  THEN ASSIGN wdetail2.bran_name  = "ถนนเพชรบุรีตัดใหม่"        wdetail2.bran_name2 = "สาขา"    wdetail2.region = "กรุงเทพและปริมณฑล".  
 ELSE IF trim(wdetail2.branch) = "97"  THEN ASSIGN wdetail2.bran_name  = "ถนนเพชรบุรีตัดใหม่"        wdetail2.bran_name2 = "สาขา"    wdetail2.region = "กรุงเทพและปริมณฑล".  
 ELSE IF trim(wdetail2.branch) = "98"  THEN ASSIGN wdetail2.bran_name  = "ถนนเพชรบุรีตัดใหม่"        wdetail2.bran_name2 = "สาขา"    wdetail2.region = "กรุงเทพและปริมณฑล".  
 ELSE IF trim(wdetail2.branch) = "11"  THEN ASSIGN wdetail2.bran_name  = "รังสิต"                    wdetail2.bran_name2 = "สาขา"    wdetail2.region = "กรุงเทพและปริมณฑล".  
 ELSE IF trim(wdetail2.branch) = "0"   THEN ASSIGN wdetail2.bran_name  = "การตลาด-นายหน้าในประเทศ"   wdetail2.bran_name2 = "M1"      wdetail2.region = "M1".  
 ELSE IF trim(wdetail2.branch) = "W"   THEN ASSIGN wdetail2.bran_name  = "การตลาด-นายหน้าต่างประเทศ" wdetail2.bran_name2 = "M2"      wdetail2.region = "M2".  
 ELSE IF trim(wdetail2.branch) = "M"   THEN ASSIGN wdetail2.bran_name  = "กรุงเทพ"                   wdetail2.bran_name2 = "M3"      wdetail2.region = "M3".  
 ELSE IF trim(wdetail2.branch) = "L"   THEN ASSIGN wdetail2.bran_name  = "การตลาด-ตัวแทน"            wdetail2.bran_name2 = "M2"      wdetail2.region = "M2".  
 ELSE IF trim(wdetail2.branch) = "19"  THEN ASSIGN wdetail2.bran_name  = ""                  wdetail2.bran_name2 = ""        wdetail2.region = "กรุงเทพและปริมณฑล".  
 ELSE IF trim(wdetail2.branch) = "Y"   THEN ASSIGN wdetail2.bran_name  = ""                  wdetail2.bran_name2 = ""        wdetail2.region = "กรุงเทพและปริมณฑล".  
 ELSE IF trim(wdetail2.branch) = "X"   THEN ASSIGN wdetail2.bran_name  = ""                  wdetail2.bran_name2 = ""        wdetail2.region = "กรุงเทพและปริมณฑล".  
 ELSE IF trim(wdetail2.branch) = "V"   THEN ASSIGN wdetail2.bran_name  = ""                  wdetail2.bran_name2 = ""        wdetail2.region = "กรุงเทพและปริมณฑล".  
 ELSE IF trim(wdetail2.branch) = "15"  THEN ASSIGN wdetail2.bran_name  = "อ่อนนุช"           wdetail2.bran_name2 = "ปริมณฑล" wdetail2.region = "กรุงเทพและปริมณฑล".  
 ELSE IF trim(wdetail2.branch) = "43"  THEN ASSIGN wdetail2.bran_name  = "กาญจนาภิเษก"       wdetail2.bran_name2 = "ปริมณฑล" wdetail2.region = "กรุงเทพและปริมณฑล".  
 ELSE IF trim(wdetail2.branch) = "32"  THEN ASSIGN wdetail2.bran_name  = "สุพรรณบุรี"        wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง" .             
 ELSE IF trim(wdetail2.branch) = "34"  THEN ASSIGN wdetail2.bran_name  = "อยุธยา"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง" .  
 ELSE IF trim(wdetail2.branch) = "33"  THEN ASSIGN wdetail2.bran_name  = "ราชบุรี"           wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง" .  
 ELSE IF trim(wdetail2.branch) = "U"   THEN ASSIGN wdetail2.bran_name  = "นครปฐม"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง" .  
 ELSE IF trim(wdetail2.branch) = "35"  THEN ASSIGN wdetail2.bran_name  = "ฉะเชิงเทรา"        wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง" .  
 ELSE IF trim(wdetail2.branch) = "A"   THEN ASSIGN wdetail2.bran_name  = "ประจวบคีรีขันธ์"   wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง" .  
 ELSE IF trim(wdetail2.branch) = "5"   THEN ASSIGN wdetail2.bran_name  = "พัทยา"             wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง" .  
 ELSE IF trim(wdetail2.branch) = "J"   THEN ASSIGN wdetail2.bran_name  = "สระบุรี"           wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง" .  
 ELSE IF trim(wdetail2.branch) = "F"   THEN ASSIGN wdetail2.bran_name  = "สมุทรสาคร"         wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง".  
 ELSE IF trim(wdetail2.branch) = "I"   THEN ASSIGN wdetail2.bran_name  = "เพชรบุรี"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง".  
 ELSE IF trim(wdetail2.branch) = "36"  THEN ASSIGN wdetail2.bran_name  = "ระยอง"             wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง".  
 ELSE IF trim(wdetail2.branch) = "31"  THEN ASSIGN wdetail2.bran_name  = "กาญจนบุรี"         wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง".  
 ELSE IF trim(wdetail2.branch) = "P"   THEN ASSIGN wdetail2.bran_name  = "ชลบุรี"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง".  
 ELSE IF trim(wdetail2.branch) = "39"  THEN ASSIGN wdetail2.bran_name  = "จันทบุรี"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง".  
 ELSE IF trim(wdetail2.branch) = "38"  THEN ASSIGN wdetail2.bran_name  = "ปราจีนบุรี"        wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง".  
 ELSE IF trim(wdetail2.branch) = "37"  THEN ASSIGN wdetail2.bran_name  = "ลพบุรี"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง".  
 ELSE IF trim(wdetail2.branch) = "41"  THEN ASSIGN wdetail2.bran_name  = "หัวหิน"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง".
 ELSE IF trim(wdetail2.branch) = "42"  THEN ASSIGN wdetail2.bran_name  = "สมุทรสงคราม"       wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง".
 ELSE IF trim(wdetail2.branch) = "44"  THEN ASSIGN wdetail2.bran_name  = "บางสะพาน"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคกลาง".
 /*ELSE IF trim(wdetail2.branch) = "74"  THEN ASSIGN wdetail2.bran_name  = "ศรีสะเกษ"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "3"   THEN ASSIGN wdetail2.bran_name  = "ขอนแก่น"           wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "6"   THEN ASSIGN wdetail2.bran_name  = "โคราช"             wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "72"  THEN ASSIGN wdetail2.bran_name  = "สุรินทร์"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "K"   THEN ASSIGN wdetail2.bran_name  = "อุบลราชธานี"       wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "S"   THEN ASSIGN wdetail2.bran_name  = "อุดรธานี"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "71"  THEN ASSIGN wdetail2.bran_name  = "ร้อยเอ็ด"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "75"  THEN ASSIGN wdetail2.bran_name  = "มุกดาหาร"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "73"  THEN ASSIGN wdetail2.bran_name  = "สกลนคร"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "76"  THEN ASSIGN wdetail2.bran_name  = "กาฬสินธุ์"         wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "77"  THEN ASSIGN wdetail2.bran_name  = "ชัยภูมิ"           wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "79"  THEN ASSIGN wdetail2.bran_name  = "หนองคาย"           wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "78"  THEN ASSIGN wdetail2.bran_name  = "มหาสารคาม"         wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  
 ELSE IF trim(wdetail2.branch) = "45"  THEN ASSIGN wdetail2.bran_name  = "ชลบุรี"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออกเฉียงเหนือ".  */
 ELSE IF trim(wdetail2.branch) = "74"  THEN ASSIGN wdetail2.bran_name  = "ศรีสะเกษ"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "3"   THEN ASSIGN wdetail2.bran_name  = "ขอนแก่น"           wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "6"   THEN ASSIGN wdetail2.bran_name  = "โคราช"             wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "72"  THEN ASSIGN wdetail2.bran_name  = "สุรินทร์"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "K"   THEN ASSIGN wdetail2.bran_name  = "อุบลราชธานี"       wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "S"   THEN ASSIGN wdetail2.bran_name  = "อุดรธานี"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "71"  THEN ASSIGN wdetail2.bran_name  = "ร้อยเอ็ด"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "75"  THEN ASSIGN wdetail2.bran_name  = "มุกดาหาร"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "73"  THEN ASSIGN wdetail2.bran_name  = "สกลนคร"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "76"  THEN ASSIGN wdetail2.bran_name  = "กาฬสินธุ์"         wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "77"  THEN ASSIGN wdetail2.bran_name  = "ชัยภูมิ"           wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "79"  THEN ASSIGN wdetail2.bran_name  = "หนองคาย"           wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "78"  THEN ASSIGN wdetail2.bran_name  = "มหาสารคาม"         wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคอีสาน".  
 ELSE IF trim(wdetail2.branch) = "45"  THEN ASSIGN wdetail2.bran_name  = "ชลบุรี"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคตะวันออก". 
 ELSE IF trim(wdetail2.branch) = "1"   THEN ASSIGN wdetail2.bran_name  = "นครสวรรค์"         wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคเหนือ" .                
 ELSE IF trim(wdetail2.branch) = "2"   THEN ASSIGN wdetail2.bran_name  = "เชียงใหม่"         wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคเหนือ" .               
 ELSE IF trim(wdetail2.branch) = "61"  THEN ASSIGN wdetail2.bran_name  = "ลำปาง"             wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคเหนือ" .               
 ELSE IF trim(wdetail2.branch) = "H"   THEN ASSIGN wdetail2.bran_name  = "พิษณุโลก"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคเหนือ" .  
 ELSE IF trim(wdetail2.branch) = "G"   THEN ASSIGN wdetail2.bran_name  = "เชียงราย"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคเหนือ" .  
 ELSE IF trim(wdetail2.branch) = "62"  THEN ASSIGN wdetail2.bran_name  = "อุตรดิตถ์"         wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคเหนือ" .  
 ELSE IF trim(wdetail2.branch) = "63"  THEN ASSIGN wdetail2.bran_name  = "ตาก"               wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคเหนือ" .  
 ELSE IF trim(wdetail2.branch) = "64"  THEN ASSIGN wdetail2.bran_name  = "แพร่"              wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคเหนือ" .  
 ELSE IF trim(wdetail2.branch) = "65"  THEN ASSIGN wdetail2.bran_name  = "กำแพงเพชร"         wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคเหนือ".
 ELSE IF trim(wdetail2.branch) = "86"  THEN ASSIGN wdetail2.bran_name  = "สตูล"              wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "N"   THEN ASSIGN wdetail2.bran_name  = "นครศรีธรรมราช"     wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "81"  THEN ASSIGN wdetail2.bran_name  = "เวียงสระ"          wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "84"  THEN ASSIGN wdetail2.bran_name  = "ตะกั่วป่า"         wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "82"  THEN ASSIGN wdetail2.bran_name  = "ทุ่งสง"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "7"   THEN ASSIGN wdetail2.bran_name  = "สุราษฏร์ธานี"      wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "E"   THEN ASSIGN wdetail2.bran_name  = "ตรัง"              wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "C"   THEN ASSIGN wdetail2.bran_name  = "กระบี่"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "B"   THEN ASSIGN wdetail2.bran_name  = "ชุมพร"             wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "85"  THEN ASSIGN wdetail2.bran_name  = "พัทลุง"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "83"  THEN ASSIGN wdetail2.bran_name  = "ระนอง"             wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "8"   THEN ASSIGN wdetail2.bran_name  = "ภูเก็ต"            wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "D"   THEN ASSIGN wdetail2.bran_name  = "ปัตตานี"           wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "4"   THEN ASSIGN wdetail2.bran_name  = "หาดใหญ่"           wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE IF trim(wdetail2.branch) = "9"   THEN ASSIGN wdetail2.bran_name  = "สมุย"              wdetail2.bran_name2 = "สาขา"    wdetail2.region = "ภาคใต้".  
 ELSE   ASSIGN wdetail2.bran_name  = ""        wdetail2.bran_name2 = ""    wdetail2.region = "".
 ...end A64-0344 ..*/
  /* add by : A64-0344 */
 FIND LAST stat.insure USE-INDEX insure01 WHERE 
          stat.insure.compno  = "TPIS-BR"     AND 
          stat.insure.branch  = trim(wdetail2.branch) NO-LOCK NO-ERROR .
 IF AVAIL stat.insure THEN DO:
    ASSIGN wdetail2.bran_name  = stat.insure.fname    /* ชื่อสาขา */    
           wdetail2.bran_name2 = stat.insure.lname    /* สาขา */    
           wdetail2.region     = stat.Insure.Addr3.   /* ภูมิภาค */ 
 END.
/* end A64-0344 */ 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchchktil C-Win 
PROCEDURE proc_matchchktil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: ไฟล์ส่งตรีเพชร      
------------------------------------------------------------------------------*/
DEF VAR n_status AS LOGICAL.
DEF VAR n_stpol  AS CHAR.
DEF VAR n_stcom  AS CHAR.
DEF VAR n_rencnt AS INT.
DEF VAR n_endcnt AS INT.
DEF VAR n_length AS INT.
DEF VAR n_policyuwm100 AS CHAR FORMAT "x(20)" INIT "".
for each wdetail2.
   IF wdetail2.ins_ytyp = "" THEN DELETE wdetail2.
   ELSE DO:
      ASSIGN nv_cnt   =  nv_cnt  + 1                      
              nv_row  =  nv_row  + 1
              n_stpol  = ""
              n_stcom  = ""
              n_length = 0
              wdetail2.policy_no   = ""  
              wdetail2.delerco     = "" 
              wdetail2.financecd   = "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
      /*FIND FIRST sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail2.tpis_no) AND sicuw.uwm100.poltyp = "V70"  NO-LOCK NO-ERROR .*/
      FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail2.tpis_no) NO-LOCK.
          IF      sicuw.uwm100.poltyp <> "V70"  THEN NEXT.
          ELSE IF sicuw.uwm100.expdat <= TODAY  THEN DO:
              ASSIGN wdetail2.policy         = ""  
                      n_stpol                = ""     
                      wdetail2.pol_comm_date = ""     
                      wdetail2.pol_exp_date  = "".
          END.
          ELSE DO:
                 ASSIGN 
                    wdetail2.policy_no     = sicuw.uwm100.policy
                    /*wdetail2.occup         = sicuw.uwm100.occupn*/ 
                    wdetail2.pol_comm_date = string(sicuw.uwm100.comdat) 
                    wdetail2.pol_exp_date  = string(sicuw.uwm100.expdat) 
                    wdetail2.ntitle        = sicuw.uwm100.ntitle                                                 
                    wdetail2.ICNO          = sicuw.uwm100.anam2
                    wdetail2.pol_netprem   = STRING(sicuw.uwm100.prem_t)
                    wdetail2.pol_gprem     = string(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t)
                    wdetail2.pol_stamp     = string(sicuw.uwm100.rstp_t)    
                    wdetail2.pol_vat       = string(sicuw.uwm100.rtax_t)
                    wdetail2.pol_wht       = STRING((DECI(wdetail2.pol_netprem) + DECI(wdetail2.pol_stamp)) * 0.01 )
                    n_status               = sicuw.uwm100.releas
                    n_stpol                = STRING(n_status)
                    wdetail2.insnam        = trim(sicuw.uwm100.firstname)  /* F67-0001 Ranu I. */
                    wdetail2.NAME2         = trim(sicuw.uwm100.lastname)   /* F67-0001 Ranu I. */
                    wdetail2.nDire         = IF wdetail2.cust_type = "J" THEN trim(sicuw.uwm100.name2) ELSE "".    /* F67-0001 Ranu I. */
                /* Comment by : F67-0001 Ranu I. .....
                 IF wdetail2.cust_type = "J" THEN DO:
                     IF INDEX(uwm100.name1,"จำกัด") <> 0 THEN DO:
                         ASSIGN wdetail2.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"จำกัด") + 5 )
                                wdetail2.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail2.NAME2   = "".
                     END.
                     ELSE IF INDEX(uwm100.name1,"มหาชน") <> 0 THEN
                         ASSIGN wdetail2.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"มหาชน") + 5 )
                                wdetail2.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail2.NAME2   = "".
                  END.
                  ELSE DO:
                      IF INDEX(sicuw.uwm100.ntitle,"มูลนิธิ") = 0 THEN DO:
                          ASSIGN  wdetail2.insnam = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1," ")) 
                                  n_length        = LENGTH(uwm100.NAME1) - LENGTH(wdetail2.insnam)
                                  wdetail2.NAME2  = SUBSTR(uwm100.name1,INDEX(uwm100.name1," "),n_length + 1).
                      END.
                      ELSE DO:
                          ASSIGN wdetail2.insnam = sicuw.uwm100.name1
                                 wdetail2.insnam = TRIM(wdetail2.insnam) + TRIM(sicuw.uwm100.name2)
                                 wdetail2.NAME2  = "".
                      END.
                  END.
                  ...end F67-0001....*/
                FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                    sicuw.uwm301.policy = sicuw.uwm100.policy AND 
                    sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                    sicuw.uwm301.endcnt = sicuw.uwm100.endcnt AND 
                    sicuw.uwm301.riskno = 1                   AND
                    sicuw.uwm301.itemno = 1                   NO-LOCK NO-ERROR.
      
                 IF AVAIL sicuw.uwm301 THEN DO:
                   ASSIGN wdetail2.License     = sicuw.uwm301.vehreg
                          wdetail2.engno       = sicuw.uwm301.eng_no
                          wdetail2.chasno      = sicuw.uwm301.cha_no.
                          
                          FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                              sicuw.uwm130.policy = sicuw.uwm100.policy AND 
                              sicuw.uwm130.rencnt = sicuw.uwm100.rencnt AND
                              sicuw.uwm130.endcnt = sicuw.uwm100.endcnt AND 
                              sicuw.uwm130.riskno = 1                   AND
                              sicuw.uwm130.itemno = 1                   NO-LOCK NO-ERROR.
                          IF AVAIL sicuw.uwm130 THEN 
                             ASSIGN wdetail2.si   = IF sicuw.uwm301.covcod = "1" THEN STRING(sicuw.uwm130.uom6_v) ELSE STRING(sicuw.uwm130.uom7_v).
                          ELSE
                             ASSIGN wdetail2.si   = "".
                 END.
                 ELSE DO:
                     ASSIGN wdetail2.License   = ""
                          wdetail2.engno       = ""
                          wdetail2.chasno      = "".
                 END.
                 RUN proc_exportNote.
           END.
      END.
      IF wdetail2.com_no <> "" THEN DO:
       /*FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol =  trim(wdetail2.tpis_no) AND sicuw.uwm100.poltyp = "V72" NO-LOCK NO-ERROR .*/
         FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol =  trim(wdetail2.tpis_no) NO-LOCK.
             IF sicuw.uwm100.poltyp <> "V72"  THEN NEXT.
             ELSE IF sicuw.uwm100.expdat <= TODAY THEN DO:
                 ASSIGN wdetail2.com_no    = "" 
                   n_stcom                 = ""           
                   wdetail2.com_comm_date  = ""   
                   wdetail2.com_exp_date   = "".
            END.
            ELSE DO:
              ASSIGN 
                  wdetail2.com_no        = sicuw.uwm100.policy 
                  /*wdetail2.occup         = sicuw.uwm100.occupn*/
                  wdetail2.com_comm_date = STRING(sicuw.uwm100.comdat)
                  wdetail2.com_exp_date  = STRING(sicuw.uwm100.expdat)
                  wdetail2.ntitle        = sicuw.uwm100.ntitle                                                          
                  wdetail2.ICNO          = sicuw.uwm100.anam2                                                           
                  wdetail2.com_netprem   = STRING(sicuw.uwm100.prem_t)                                                  
                  wdetail2.com_gprem     = string(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t)      
                  wdetail2.com_stamp     = string(sicuw.uwm100.rstp_t)                                                  
                  wdetail2.com_vat       = string(sicuw.uwm100.rtax_t)
                  wdetail2.com_wht       = STRING((DECI(wdetail2.com_netprem) + DECI(wdetail2.com_stamp)) * 0.01 ) 
                  n_status               = sicuw.uwm100.releas
                  n_stcom                = STRING(n_status)
                  wdetail2.insnam        = trim(sicuw.uwm100.firstname)  /* F67-0001 Ranu I. */
                  wdetail2.NAME2         = trim(sicuw.uwm100.lastname)   /* F67-0001 Ranu I. */
                  wdetail2.nDire         = IF wdetail2.cust_type = "J" THEN trim(sicuw.uwm100.name2) ELSE "".    /* F67-0001 Ranu I. */  
                /* Comment by : F67-0001 Ranu I. .....
                 IF wdetail2.cust_type = "J" THEN DO:
                     IF INDEX(uwm100.name1,"จำกัด") <> 0 THEN DO:
                         ASSIGN wdetail2.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"จำกัด") + 5 )
                                wdetail2.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail2.NAME2   = "".
                     END.
                     ELSE IF INDEX(uwm100.name1,"มหาชน") <> 0 THEN
                         ASSIGN wdetail2.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"จำกัด") + 5 )
                                wdetail2.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail2.NAME2   = "".
                 END.
                 ELSE DO:
                    IF INDEX(sicuw.uwm100.ntitle,"มูลนิธิ") = 0 THEN DO:
                        ASSIGN  wdetail2.insnam = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1," ")) 
                                n_length        = LENGTH(uwm100.NAME1) - LENGTH(wdetail2.insnam)
                                wdetail2.NAME2  = SUBSTR(uwm100.name1,INDEX(uwm100.name1," "),n_length + 1).
                    END.
                    ELSE DO:
                        ASSIGN wdetail2.insnam = sicuw.uwm100.name1
                               wdetail2.insnam = TRIM(wdetail2.insnam) + TRIM(sicuw.uwm100.name2)
                               wdetail2.NAME2  = "".
                    END.
                 END.
                 ...end : F67-0001....*/
                 FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                            sicuw.uwm301.policy = sicuw.uwm100.policy AND 
                            sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                            sicuw.uwm301.endcnt = sicuw.uwm100.endcnt AND 
                            sicuw.uwm301.riskno = 1                   AND 
                            sicuw.uwm301.itemno = 1                   NO-LOCK NO-ERROR.
             
                     IF AVAIL sicuw.uwm301 THEN
                       ASSIGN wdetail2.License = sicuw.uwm301.vehreg
                              wdetail2.engno   = sicuw.uwm301.eng_no  
                              wdetail2.chasno  = sicuw.uwm301.cha_no.
                     ELSE
                       ASSIGN wdetail2.License  = ""
                              wdetail2.engno    = ""
                              wdetail2.chasno   = "".
                 RUN proc_ExportNote.
             END.
        END.
       END.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   Wdetail2.ins_ytyp             '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail2.bus_typ              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail2.TASreceived          '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail2.InsCompany           '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail2.Insurancerefno       '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail2.tpis_no              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail2.ntitle               '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   TRIM(wdetail2.insnam) FORMAT "X(50)"  '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   TRIM(wdetail2.NAME2)  FORMAT "X(50)"  '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetail2.cust_type            '"' SKIP.         /*จากไฟล์ */        
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetail2.nDirec               '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetail2.ICNO                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetail2.address              '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   wdetail2.build                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   wdetail2.mu                   '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   wdetail2.soi                  '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   wdetail2.road                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   wdetail2.tambon               '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   wdetail2.amper                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   wdetail2.country              '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   wdetail2.post                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   wdetail2.brand                '"' SKIP.         /*จากไฟล์*/   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   wdetail2.model                '"' SKIP.         /*จากไฟล์*/     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   wdetail2.class                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   wdetail2.md_year              '"' SKIP.         /*จากไฟล์*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   wdetail2.Usage                '"' SKIP.         /*จากไฟล์*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   wdetail2.coulor               '"' SKIP.         /*จากไฟล์*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   wdetail2.cc                   '"' SKIP.         /*จากไฟล์*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   wdetail2.regis_year           '"' SKIP.         /*จากไฟล์*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   wdetail2.engno                '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   wdetail2.chasno               '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   Wdetail2.Acc_CV  FORMAT "x(60)"   '"' SKIP.                                              /*จากไฟล์*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   IF Wdetail2.Acc_amount = "" THEN "" ELSE STRING(DECI(Wdetail2.Acc_amount)) '"' SKIP. /*จากไฟล์*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'   wdetail2.License  FORMAT "x(20)"     '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'   wdetail2.regis_CL             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'   wdetail2.campaign             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'   wdetail2.typ_work             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'   DECI(wdetail2.si) FORMAT ">>,>>>,>>9.99"               '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'   DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'   DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'   wdetail2.LAST_pol             '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'   wdetail2.cover                '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'   DECI(wdetail2.pol_netprem)    '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'   DECI(wdetail2.pol_gprem)      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'   DECI(wdetail2.pol_stamp)      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'   DECI(wdetail2.pol_vat)        '"' SKIP.           
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'   DECI(wdetail2.pol_wht)        '"' SKIP.          /*จากไฟล์ */
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'   wdetail2.com_no               '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'   DATE(wdetail2.com_comm_date) FORMAT "99/99/9999"   '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'   DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999"   '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'   DECI(wdetail2.com_netprem)    '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'   DECI(wdetail2.com_gprem)      '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'   DECI(wdetail2.com_stamp)      '"' SKIP.     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'   DECI(wdetail2.com_vat)        '"' SKIP.          /*จากไฟล์*/     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'   DECI(wdetail2.com_wht)        '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'   wdetail2.deler                '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'   wdetail2.showroom             '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'   wdetail2.typepay              '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'   wdetail2.financename          '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'   wdetail2.mail_hno             '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"'   wdetail2.mail_build           '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"'   wdetail2.mail_mu              '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"'   wdetail2.mail_soi             '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"'   wdetail2.mail_road            '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"'   wdetail2.mail_tambon          '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"'   wdetail2.mail_amper           '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"'   wdetail2.mail_country         '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"'   wdetail2.mail_post            '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"'   wdetail2.send_date            '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"'   wdetail2.policy_no            '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"'   wdetail2.send_data            '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"'   wdetail2.REMARK1              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"'   wdetail2.occup                '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"'   wdetail2.regis_no             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"'   n_stpol                       '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"'   n_stcom                       '"' SKIP.
   END.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk C-Win 
PROCEDURE proc_matchfilechk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*a62-0422 */
IF tg_fileload = YES  THEN DO: 
    RUN proc_matchfilechk_new .
END.
ELSE DO:
/* end : a62-0422 */
   DEF BUFFER bfwdetail2 FOR wdetail2. /*A62-0422*/
   For each  wdetail2 :
       DELETE  wdetail2.
   END.
   For each  wdetail :
       DELETE  wdetail.
   END.
   IF ra_typeload <> 2  THEN DO:  /* A66-0252 */
      INPUT FROM VALUE(fi_FileName).
      REPEAT:
          CREATE wdetail2.
          IMPORT DELIMITER "|"     
              wdetail2.ins_ytyp          
              wdetail2.bus_typ           
              wdetail2.TASreceived          
              wdetail2.InsCompany           
              wdetail2.Insurancerefno       
              wdetail2.tpis_no
              wdetail2.ntitle             
              wdetail2.insnam               
              wdetail2.NAME2                
              wdetail2.cust_type
              wdetail2.nDirec               
              wdetail2.ICNO                 
              wdetail2.address              
              wdetail2.build
              wdetail2.mu                   
              wdetail2.soi                  
              wdetail2.road                 
              wdetail2.tambon               
              wdetail2.amper                
              wdetail2.country              
              wdetail2.post                 
              wdetail2.brand             
              wdetail2.model                
              wdetail2.class
              wdetail2.md_year
              wdetail2.Usage               
              wdetail2.coulor               
              wdetail2.cc                   
              wdetail2.regis_year     
              wdetail2.engno                
              wdetail2.chasno               
              Wdetail2.Acc_CV            
              Wdetail2.Acc_amount        
              wdetail2.License
              wdetail2.regis_CL
              wdetail2.campaign
              wdetail2.typ_work
              wdetail2.si                   
              wdetail2.pol_comm_date     
              wdetail2.pol_exp_date     
              wdetail2.last_pol
              wdetail2.cover
              wdetail2.pol_netprem
              wdetail2.pol_gprem
              wdetail2.pol_stamp
              wdetail2.pol_vat
              wdetail2.pol_wht
              wdetail2.com_no
              wdetail2.com_comm_date
              wdetail2.com_exp_date
              wdetail2.com_netprem
              wdetail2.com_gprem
              wdetail2.com_stamp
              wdetail2.com_vat
              wdetail2.com_wht
              wdetail2.deler                
              wdetail2.showroom             
              wdetail2.typepay              
              wdetail2.financename          
              wdetail2.mail_hno
              wdetail2.mail_build
              wdetail2.mail_mu                   
              wdetail2.mail_soi                  
              wdetail2.mail_road                 
              wdetail2.mail_tambon               
              wdetail2.mail_amper                
              wdetail2.mail_country              
              wdetail2.mail_post                 
              wdetail2.send_date
              wdetail2.policy_no
              wdetail2.send_data
              wdetail2.REMARK1              
              wdetail2.occup
              wdetail2.memotext /*A61-0152*/
              wdetail2.regis_no 
              wdetail2.claimdi      /*Add by Kridtiya i. A63-0472*/   
              wdetail2.product      /*Add by Kridtiya i. A63-0472*/
              wdetail2.campaign_ov. /*Add by Kridtiya i. A63-0472*/
      
          IF INDEX(wdetail2.ins_ytyp,"Ins") <> 0 THEN DELETE wdetail2.               
          ELSE IF INDEX(wdetail2.ins_ytyp,"ins")  <> 0 THEN DELETE wdetail2. 
          ELSE IF INDEX(wdetail2.ins_ytyp,"Renew") <> 0 THEN DELETE wdetail2. 
          ELSE IF INDEX(wdetail2.ins_ytyp,"renew")  <> 0 THEN DELETE wdetail2. 
          ELSE IF wdetail2.ins_ytyp = "" THEN DELETE wdetail2. 
      END.   /* repeat  */
      /* A62-0422 */
      RELEASE wdetail2. 
   END.
   /* A66-0252 */
   ELSE DO:
       RUN proc_matchfilechk0.
   END.
    /* end :A66-0252 */ 

   FIND FIRST bfwdetail2 WHERE bfwdetail2.tpis_no <> "" AND INDEX(bfwdetail2.si,"ซ่อม") <> 0 NO-ERROR NO-WAIT .
    IF AVAIL bfwdetail2 THEN DO:
        MESSAGE "กรุณาเลือกไฟล์แจ้งงานแบบเดิม ! " VIEW-AS ALERT-BOX.
        FOR EACH wdetail2 .
           DELETE wdetail2.
        END.
    END.
    /* end A62-0422 */

   /*IF   ra_typeload = 1 THEN Run  proc_matchfilechk4.*/
   IF   ra_typeload = 2 THEN Run  proc_matchfilechk6.  /* File to HO */
   IF   ra_typeload = 4 THEN RUN  proc_matchfiletil.   /* file to TPIS*/
   RUN  proc_matchfilechk1.
   RUN  proc_matchfilechk3.
   IF ra_typeload = 3 THEN Run  proc_matchfilechk8.  /* recipt */
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk0 C-Win 
PROCEDURE proc_matchfilechk0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  add by : A66-0252      
------------------------------------------------------------------------------*/
DO:
    INPUT FROM VALUE(fi_FileName).
      REPEAT:
          CREATE wdetail2.
          IMPORT DELIMITER "|"     
              wdetail2.ins_ytyp          
              wdetail2.bus_typ           
              wdetail2.TASreceived          
              wdetail2.InsCompany           
              wdetail2.Insurancerefno       
              wdetail2.tpis_no
              wdetail2.ntitle             
              wdetail2.insnam               
              wdetail2.NAME2                
              wdetail2.cust_type
              wdetail2.nDirec               
              wdetail2.ICNO                 
              wdetail2.address              
              wdetail2.build
              wdetail2.mu                   
              wdetail2.soi                  
              wdetail2.road                 
              wdetail2.tambon               
              wdetail2.amper                
              wdetail2.country              
              wdetail2.post                 
              wdetail2.brand             
              wdetail2.model                
              wdetail2.class
              wdetail2.md_year
              wdetail2.Usage               
              wdetail2.coulor               
              wdetail2.cc                   
              wdetail2.regis_year     
              wdetail2.engno                
              wdetail2.chasno               
              Wdetail2.Acc_CV            
              Wdetail2.Acc_amount        
              wdetail2.License
              wdetail2.regis_CL
              wdetail2.campaign
              wdetail2.typ_work
              wdetail2.si                   
              wdetail2.pol_comm_date     
              wdetail2.pol_exp_date     
              wdetail2.last_pol
              wdetail2.cover
              wdetail2.pol_netprem
              wdetail2.pol_gprem
              wdetail2.pol_stamp
              wdetail2.pol_vat
              wdetail2.pol_wht
              wdetail2.com_no
              wdetail2.com_comm_date
              wdetail2.com_exp_date
              wdetail2.com_netprem
              wdetail2.com_gprem
              wdetail2.com_stamp
              wdetail2.com_vat
              wdetail2.com_wht
              wdetail2.deler                
              wdetail2.showroom             
              wdetail2.typepay              
              wdetail2.financename          
              wdetail2.mail_hno
              wdetail2.mail_build
              wdetail2.mail_mu                   
              wdetail2.mail_soi                  
              wdetail2.mail_road                 
              wdetail2.mail_tambon               
              wdetail2.mail_amper                
              wdetail2.mail_country              
              wdetail2.mail_post                 
              wdetail2.send_date
              wdetail2.policy_no
              wdetail2.send_data
              wdetail2.REMARK1              
              wdetail2.occup
              wdetail2.memotext 
              wdetail2.regis_no 
              wdetail2.claimdi        
              wdetail2.product
              /* A66-0252 */
              wdetail2.np_f18line3
              wdetail2.np_f18line4
              wdetail2.np_f18line5
              wdetail2.producer
              wdetail2.agent
              wdetail2.branch
              wdetail2.campens
             /* end :A66-0252*/
              wdetail2.campaign_ov  /*Add by Kridtiya i. A63-0472*/
        wdetail2.Driver1_title          
        wdetail2.Driver1_name           
        wdetail2.Driver1_lastname       
        wdetail2.Driver1_birthdate      
        wdetail2.Driver1_id_no          
        wdetail2.Driver1_license_no     
        wdetail2.Driver1_occupation     
        wdetail2.Driver2_title          
        wdetail2.Driver2_name           
        wdetail2.Driver2_lastname       
        wdetail2.Driver2_birthdate      
        wdetail2.Driver2_id_no          
        wdetail2.Driver2_license_no     
        wdetail2.Driver2_occupation     
        wdetail2.Driver3_title          
        wdetail2.Driver3_name           
        wdetail2.Driver3_lastname       
        wdetail2.Driver3_birthday       
        wdetail2.Driver3_id_no          
        wdetail2.Driver3_license_no     
        wdetail2.Driver3_occupation     
        wdetail2.Driver4_title          
        wdetail2.Driver4_name           
        wdetail2.Driver4_lastname       
        wdetail2.Driver4_birthdate      
        wdetail2.Driver4_id_no          
        wdetail2.Driver4_license_no     
        wdetail2.Driver4_occupation     
        wdetail2.Driver5_title          
        wdetail2.Driver5_name           
        wdetail2.Driver5_lastname       
        wdetail2.Driver5_birthdate      
        wdetail2.Driver5_id_no          
        wdetail2.Driver5_license_no     
        wdetail2.Driver5_occupation  .  
      
          IF INDEX(wdetail2.ins_ytyp,"Ins") <> 0 THEN DELETE wdetail2.               
          ELSE IF INDEX(wdetail2.ins_ytyp,"ins")  <> 0 THEN DELETE wdetail2. 
          ELSE IF INDEX(wdetail2.ins_ytyp,"Renew") <> 0 THEN DELETE wdetail2. 
          ELSE IF INDEX(wdetail2.ins_ytyp,"renew")  <> 0 THEN DELETE wdetail2. 
          ELSE IF wdetail2.ins_ytyp = "" THEN DELETE wdetail2. 
      END.   /* repeat  */
      /* A62-0422 */
      RELEASE wdetail2. 
   
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk1 C-Win 
PROCEDURE proc_matchfilechk1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS CHAR INIT "".
FOR EACH wdetail2 .
    IF INDEX(wdetail2.ins_ytyp,"Ins") <> 0 OR INDEX(wdetail2.ins_ytyp,"ins") <> 0 THEN DELETE wdetail2.  /*--A58-0489--*/
    ELSE IF INDEX(wdetail2.ins_ytyp,"Renew") <> 0 OR INDEX(wdetail2.ins_ytyp,"renew") <> 0 THEN DELETE wdetail2.  /*--A58-0489--*/
    ELSE IF wdetail2.tpis_no <> "" THEN DO:     /*--A58-0489--*/
         /*--------- ผู้รับผลประโยชน์---------------*/
       IF (trim(wdetail2.financename) = "CASH") OR 
                 (trim(wdetail2.financename) = "Cash") OR 
                 (trim(wdetail2.financename) = "cash") THEN ASSIGN wdetail2.financename  = " ".
       IF trim(wdetail2.financename) <> " " THEN DO:
        FIND FIRST stat.insure USE-INDEX insure01 WHERE stat.insure.compno = "TPIS-LEAS" AND 
                             stat.insure.fname = wdetail2.financename   OR
                             stat.insure.lname = wdetail2.financename   NO-LOCK NO-ERROR . 
           IF AVAIL stat.insure THEN
               ASSIGN wdetail2.financename  = stat.insure.addr1 + stat.insure.addr2.
           ELSE 
                ASSIGN wdetail2.financename = "error : " + wdetail2.financename.
        END.
        /*--สาขา ---*/
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno = "TPIS"             AND    
            stat.insure.fname  = wdetail2.deler     AND
            stat.insure.lname  = wdetail2.showroom  NO-ERROR NO-WAIT.
        IF AVAIL stat.insure THEN
            ASSIGN wdetail2.branch     = stat.insure.branch
                   wdetail2.delerco    = stat.insure.insno  
                   wdetail2.financecd  = stat.Insure.Text3.  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
        ELSE ASSIGN wdetail2.branch  = ""
            wdetail2.delerco    = ""  
            wdetail2.financecd  = "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
        /*--- ที่อยู่ แรก ----*/
       /* IF wdetail2.build   <> ""  THEN DO: 
            IF INDEX(wdetail2.build,"อาคาร") <> 0 OR INDEX(wdetail2.build,"อ.") <> 0 THEN
                ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build). 
            ELSE 
                ASSIGN wdetail2.address = trim(wdetail2.address) + " อาคาร" + trim(wdetail2.build).
        END.
        IF wdetail2.mu <> ""  THEN DO: 
            IF INDEX(wdetail2.mu,"หมู่") <> 0   OR INDEX(wdetail2.mu,"ม.") <> 0 OR 
               INDEX(wdetail2.mu,"บ้าน") <> 0   OR INDEX(wdetail2.mu,"หมู่บ้าน") <> 0 THEN
                wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu).
            ELSE 
            ASSIGN  n = ""  
                    n = SUBSTR(TRIM(wdetail2.mu),1,1).
                    IF INDEX("0123456789",n) <> 0 THEN wdetail2.address = trim(wdetail2.address) + " หมู่ " + trim(wdetail2.mu).
                    ELSE wdetail2.address = trim(wdetail2.address) + " หมู่บ้าน" + trim(wdetail2.mu).
        END.
        IF wdetail2.soi <> ""  THEN DO:
            IF INDEX(wdetail2.soi,"ซ.") <> 0 OR INDEX(wdetail2.soi,"ซอย") <> 0 THEN 
                 wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.soi) .
            ELSE wdetail2.address = trim(wdetail2.address) + " ซอย " + trim(wdetail2.soi) .
        END.
        IF wdetail2.road <> ""  THEN DO: 
            IF INDEX(wdetail2.road,"ถ.") <> 0 OR INDEX(wdetail2.road,"ถนน") <> 0 THEN
                 wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.road) .
            ELSE wdetail2.address = trim(wdetail2.address) + " ถนน " + trim(wdetail2.road) .
        END.  
        IF wdetail2.country <> ""  THEN DO:
            IF (index(wdetail2.country,"กทม") <> 0 ) OR (index(wdetail2.country,"กรุงเทพ") <> 0 ) THEN 
                ASSIGN 
                wdetail2.tambon  = "แขวง"  + trim(wdetail2.tambon) 
                wdetail2.amper   = "เขต"   + trim(wdetail2.amper)
                wdetail2.country = trim(wdetail2.country) + " " + trim(wdetail2.post)
                wdetail2.post    = "" . 
            ELSE ASSIGN 
                wdetail2.tambon  = "ตำบล"  +   trim(wdetail2.tambon) 
                wdetail2.amper   = "อำเภอ" +   trim(wdetail2.amper)
                wdetail2.country = "จังหวัด" + trim(wdetail2.country) + " " + trim(wdetail2.post)
                wdetail2.post    = "" . 
        END.
        DO WHILE INDEX(wdetail2.address,"  ") <> 0 :
            ASSIGN wdetail2.address = REPLACE(wdetail2.address,"  "," ").
        END.
        IF LENGTH(wdetail2.address) > 35  THEN DO:
            loop_add01:
            DO WHILE LENGTH(wdetail2.address) > 35 :
                IF r-INDEX(wdetail2.address," ") <> 0 THEN DO:
                    ASSIGN 
                        wdetail2.tambon  = trim(SUBSTR(wdetail2.address,r-INDEX(wdetail2.address," "))) + " " + wdetail2.tambon
                        wdetail2.address = trim(SUBSTR(wdetail2.address,1,r-INDEX(wdetail2.address," "))).
                END.
                ELSE LEAVE loop_add01.
            END.
            loop_add02:
            DO WHILE LENGTH(wdetail2.tambon) > 35 :
                IF r-INDEX(wdetail2.tambon," ") <> 0 THEN DO:
                    ASSIGN 
                        wdetail2.amper   = trim(SUBSTR(wdetail2.tambon,r-INDEX(wdetail2.tambon," "))) + " " + wdetail2.amper
                        wdetail2.tambon  = trim(SUBSTR(wdetail2.tambon,1,r-INDEX(wdetail2.tambon," "))).
                END.
                ELSE LEAVE loop_add02.
            END.
        END.
        IF LENGTH(wdetail2.tambon + " " + wdetail2.amper) <= 35 THEN
            ASSIGN 
            wdetail2.tambon  =  wdetail2.tambon + " " + wdetail2.amper   
            wdetail2.amper   =  wdetail2.country 
            wdetail2.country =  "" .
        IF LENGTH(wdetail2.amper + " " + wdetail2.country ) <= 35 THEN
            ASSIGN 
            wdetail2.amper   =  trim(wdetail2.amper) + " " + TRIM(wdetail2.country) 
            wdetail2.country =  "" .
        IF LENGTH(wdetail2.country) > 20 THEN DO:
            IF INDEX(wdetail2.country,"จังหวัด") <> 0 THEN 
                ASSIGN wdetail2.country = REPLACE(wdetail2.country,"จังหวัด","จ.").
        END.*/

         /*------------- ที่อยู่ จัดส่ง-----------------------*/
        IF wdetail2.mail_build   <> ""  THEN DO: 
            IF INDEX(wdetail2.mail_build,"อาคาร") <> 0 OR INDEX(wdetail2.mail_build,"อ.") <> 0 THEN
                ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build). 
            ELSE 
                ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " อาคาร" + trim(wdetail2.mail_build).
        END.
        IF wdetail2.mail_mu <> ""  THEN DO: 
            IF INDEX(wdetail2.mail_mu,"หมู่") <> 0   OR INDEX(wdetail2.mail_mu,"ม.") <> 0 OR 
               INDEX(wdetail2.mail_mu,"บ้าน") <> 0   OR INDEX(wdetail2.mail_mu,"หมู่บ้าน") <> 0 THEN
                wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_mu).
            ELSE 
            ASSIGN  n = ""  
                    n = SUBSTR(TRIM(wdetail2.mail_mu),1,1).
                    IF INDEX("0123456789",n) <> 0 THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ม." + trim(wdetail2.mail_mu).
                    ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " หมู่บ้าน" + trim(wdetail2.mail_mu).
        END.
        IF wdetail2.mail_soi <> ""  THEN DO:
            IF INDEX(wdetail2.mail_soi,"ซ.") <> 0 OR INDEX(wdetail2.mail_soi,"ซอย") <> 0 THEN 
                 wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_soi) .
            ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ซอย" + trim(wdetail2.mail_soi) .
        END.
        IF wdetail2.mail_road <> ""  THEN DO: 
            IF INDEX(wdetail2.mail_road,"ถ.") <> 0 OR INDEX(wdetail2.mail_road,"ถนน") <> 0 THEN
                 wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_road) .
            ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ถนน" + trim(wdetail2.mail_road) .
        END.
        IF trim(wdetail2.mail_country) <> ""  THEN DO:
            IF (index(wdetail2.mail_country,"กทม") <> 0 ) OR (index(wdetail2.mail_country,"กรุงเทพ") <> 0 ) THEN 
                ASSIGN 
                wdetail2.mail_tambon  = "แขวง"  + trim(wdetail2.mail_tambon) 
                wdetail2.mail_amper   = "เขต"   + trim(wdetail2.mail_amper)
                wdetail2.mail_country = trim(wdetail2.mail_country) + " " + trim(wdetail2.post)
                wdetail2.mail_post    = "" . 
            ELSE ASSIGN 
                wdetail2.mail_tambon  = "ตำบล"  +   trim(wdetail2.mail_tambon) 
                wdetail2.mail_amper   = "อำเภอ" +   trim(wdetail2.mail_amper)
                wdetail2.mail_country = "จังหวัด" + trim(wdetail2.mail_country) + " " + trim(wdetail2.mail_post)
                wdetail2.mail_post    = "" . 
        END.
        /*--------- A58-0489-----------------*/
        DO WHILE INDEX(wdetail2.mail_hno,"  ") <> 0 :
            ASSIGN wdetail2.mail_hno = REPLACE(wdetail2.mail_hno,"  "," ").
        END.
        IF LENGTH(wdetail2.mail_hno) > 35  THEN DO:
            loop_add01:
            DO WHILE LENGTH(wdetail2.mail_hno) > 35 :
                IF r-INDEX(wdetail2.mail_hno," ") <> 0 THEN DO:
                    ASSIGN 
                        wdetail2.mail_tambon  = trim(SUBSTR(wdetail2.mail_hno,r-INDEX(wdetail2.mail_hno," "))) + " " + wdetail2.mail_tambon
                        wdetail2.mail_hno = trim(SUBSTR(wdetail2.mail_hno,1,r-INDEX(wdetail2.mail_hno," "))).
                END.
                ELSE LEAVE loop_add01.
            END.
            loop_add02:
            DO WHILE LENGTH(wdetail2.mail_tambon) > 35 :
                IF r-INDEX(wdetail2.mail_tambon," ") <> 0 THEN DO:
                    ASSIGN 
                        wdetail2.mail_amper   = trim(SUBSTR(wdetail2.mail_tambon,r-INDEX(wdetail2.mail_tambon," "))) + " " + wdetail2.mail_amper
                        wdetail2.mail_tambon  = trim(SUBSTR(wdetail2.mail_tambon,1,r-INDEX(wdetail2.mail_tambon," "))).
                END.
                ELSE LEAVE loop_add02.
            END.
        END.
        IF LENGTH(wdetail2.mail_tambon + " " + wdetail2.mail_amper) <= 35 THEN
            ASSIGN 
            wdetail2.mail_tambon  =  wdetail2.mail_tambon + " " + wdetail2.mail_amper   
            wdetail2.mail_amper   =  wdetail2.mail_country 
            wdetail2.mail_country =  "" .
        IF LENGTH(wdetail2.mail_amper + " " + wdetail2.mail_country ) <= 35 THEN
            ASSIGN 
            wdetail2.mail_amper   =  trim(wdetail2.mail_amper) + " " + TRIM(wdetail2.mail_country) 
            wdetail2.mail_country =  "" .
        IF LENGTH(wdetail2.mail_country) > 20 THEN DO:
            IF INDEX(wdetail2.mail_country,"จังหวัด") <> 0 THEN 
                ASSIGN wdetail2.mail_country = REPLACE(wdetail2.mail_country,"จังหวัด","จ.").
        END.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk3 C-Win 
PROCEDURE proc_matchfilechk3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-------comment by Ranu i. A58-0489---------------------------*/
DEF VAR np_70 AS CHAR FORMAT "x(15)" INIT "".       /*A58-0489*/
DEF VAR np_72 AS CHAR FORMAT "x(15)" INIT "".       /*A58-0489*/
ASSIGN num = 1.
/*---------- comment by : A58-0489---------------
FOR EACH wdetail2 .
    IF wdetail2.Insurancerefno = "" THEN DELETE wdetail2.
    ELSE DO:
        ASSIGN 
            wdetail2.id = string(num)
            wdetail2.policy = "0" + TRIM(wdetail2.Insurancerefno)   
            num = num + 1.
    END.
END.
------------- end : A58-0489---------------------*/
FOR EACH wdetail2 .
    ASSIGN np_70 = ""   np_72 = "".
    IF wdetail2.typ_work = "V"     THEN DO: 
        ASSIGN np_70 =  "V" + wdetail2.tpis_no   np_72 = "".     /*A58-0489*/
    END.
    ELSE IF wdetail2.typ_work = "C"   THEN DO: 
        ASSIGN np_72 =  "C" + wdetail2.tpis_no   np_70 = "".     /*A58-0489*/
    END.
    ELSE IF wdetail2.typ_work = "V+C"   THEN DO: 
        ASSIGN np_70 =  "V" + wdetail2.tpis_no   np_72 =  "C" + wdetail2.tpis_no.  /*A58-0489*/
    END.
    ELSE DO: ASSIGN np_70 = ""   np_72 = "".
    END.
    /*IF wdetail2.id <> "0" THEN DO:     --A58-0489--*/
       /* ASSIGN  expyear = deci(wdetail2.comyear) + 1 .      --- A58-0489 ---*/
        /*FIND FIRST wdetail WHERE wdetail.policy = wdetail2.policy NO-ERROR NO-WAIT.  --A58-0489--*/
    IF np_70 <> "" THEN DO:
        FIND FIRST wdetail WHERE wdetail.policy = np_70 NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN
                /*wdetail.poltyp      = IF substr(wdetail2.policy,1,1) = "0" THEN "70" ELSE "72"                   --A58-0489--*/
                /*wdetail.policy      = wdetail2.policy                                                            --A58-0489--*/
                /*wdetail.comdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + wdetail2.comyear         --A58-0489--*/    
                /*wdetail.expdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + STRING(expyear)          --A58-0489--*/ 
                /*wdetail.insnam      = wdetail2.insnam + " " + wdetail2.NAME2                                     --A58-0489--*/
                wdetail.poltyp      = "70"                                                                         /*--A58-0489--*/ 
                wdetail.policy      = np_70                                                                        /*--A58-0489--*/ 
                wdetail.comdat      = TRIM(wdetail2.pol_comm_date)                                                 /*--A58-0489--*/ 
                wdetail.expdat      = TRIM(wdetail2.pol_exp_date)                                                  /*--A58-0489--*/ 
                wdetail.insnam      = trim(wdetail2.ntitle) + TRIM(wdetail2.insnam) + " " + TRIM(wdetail2.NAME2)   /*--A58-0489--*/ 
                wdetail.icno        = wdetail2.icno  
                wdetail.iadd1       = wdetail2.mail_hno                                         /*wdetail2.address*/
                wdetail.iadd2       = wdetail2.mail_tambon                                      /*wdetail2.tambon*/  
                wdetail.iadd3       = wdetail2.mail_amper                                       /*wdetail2.amper */  
                wdetail.iadd4       = wdetail2.mail_country + " " + wdetail2.mail_post           /*wdetail2.country + " " + wdetail2.post */
                /*wdetail.subclass    = IF wdetail2.vehuse = "เก๋ง" THEN "110" ELSE "210"                           --A58-0489--*/
                wdetail.subclass    = TRIM(wdetail2.class)                                                         /*--A58-0489--*/ 
                wdetail.model       = wdetail2.model 
                wdetail.cc          = wdetail2.cc
                wdetail.chasno      = trim(wdetail2.chasno)   
                /*wdetail.vehreg      = "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 7,2) + " " + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 5) /*kridtiya i. A53-0317*/ F67-0001 */ 
                wdetail.vehreg      = IF LENGTH(wdetail2.chasno)  > 8 THEN "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 ) 
                                      ELSE "/" + trim(wdetail2.chasno)  /* F67-0001 */
                wdetail.engno       = wdetail2.engno
                wdetail.vehuse      = "1"
                wdetail.garage      = ""
                wdetail.stk         = ""                
                /*wdetail.covcod      = "1"                                     -- A58-0489--*/
                wdetail.covcod      = TRIM(wdetail2.cover)                     /*--A58-0489--*/
                wdetail.si          = wdetail2.si
                wdetail.prempa      = "V"
                wdetail.branch      = wdetail2.branch 
                wdetail.benname     = wdetail2.financename
                /*wdetail.volprem     = wdetail2.baseprm                       --A58-0489--*/
                wdetail.volprem     = wdetail2.pol_netprem                     /*--A58-0489--*/
                wdetail.comment     = wdetail2.typepay     
                wdetail.agent       = ""
                wdetail.producer    = "" 
                wdetail.entdat      = string(TODAY)      
                wdetail.enttim      = STRING (TIME, "HH:MM:SS")   
                wdetail.trandat     = STRING (TODAY)     
                wdetail.trantim     = STRING (TIME, "HH:MM:SS")   
                wdetail.n_IMPORT    = "IM"
                wdetail.n_EXPORT    = "" 
                wdetail.deler       = wdetail2.deler    
                wdetail.n_telreq    = wdetail2.showroom  
                wdetail.delerco     = wdetail2.delerco 
                wdetail.financecd   = wdetail2.financecd  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
                /*wdetail.CoverNote   = wdetail2.staus                          -- A58-0489--*/
                /*wdetail.nmember     = wdetail2.REMARK  .                      -- A58-0489--*/
                wdetail.nmember     = wdetail2.REMARK1   /*-- A58-0489--*/ 
                                          wdetail.Driver1_title        =   wdetail2.Driver1_title          
            wdetail.Driver1_name         =   wdetail2.Driver1_name           
            wdetail.Driver1_lastname     =   wdetail2.Driver1_lastname       
            wdetail.Driver1_birthdate    =   wdetail2.Driver1_birthdate      
            wdetail.Driver1_id_no        =   wdetail2.Driver1_id_no          
            wdetail.Driver1_license_no   =   wdetail2.Driver1_license_no     
            wdetail.Driver1_occupation   =   wdetail2.Driver1_occupation     
            wdetail.Driver2_title        =   wdetail2.Driver2_title          
            wdetail.Driver2_name         =   wdetail2.Driver2_name           
            wdetail.Driver2_lastname     =   wdetail2.Driver2_lastname       
            wdetail.Driver2_birthdate    =   wdetail2.Driver2_birthdate      
            wdetail.Driver2_id_no        =   wdetail2.Driver2_id_no          
            wdetail.Driver2_license_no   =   wdetail2.Driver2_license_no     
            wdetail.Driver2_occupation   =   wdetail2.Driver2_occupation     
            wdetail.Driver3_title        =   wdetail2.Driver3_title          
            wdetail.Driver3_name         =   wdetail2.Driver3_name           
            wdetail.Driver3_lastname     =   wdetail2.Driver3_lastname       
            wdetail.Driver3_birthdate     =   wdetail2.Driver3_birthday       
            wdetail.Driver3_id_no        =   wdetail2.Driver3_id_no          
            wdetail.Driver3_license_no   =   wdetail2.Driver3_license_no     
            wdetail.Driver3_occupation   =   wdetail2.Driver3_occupation     
            wdetail.Driver4_title        =   wdetail2.Driver4_title          
            wdetail.Driver4_name         =   wdetail2.Driver4_name           
            wdetail.Driver4_lastname     =   wdetail2.Driver4_lastname       
            wdetail.Driver4_birthdate    =   wdetail2.Driver4_birthdate      
            wdetail.Driver4_id_no        =   wdetail2.Driver4_id_no          
            wdetail.Driver4_license_no   =   wdetail2.Driver4_license_no     
            wdetail.Driver4_occupation   =   wdetail2.Driver4_occupation     
            wdetail.Driver5_title        =   wdetail2.Driver5_title          
            wdetail.Driver5_name         =   wdetail2.Driver5_name           
            wdetail.Driver5_lastname     =   wdetail2.Driver5_lastname       
            wdetail.Driver5_birthdate    =   wdetail2.Driver5_birthdate      
            wdetail.Driver5_id_no        =   wdetail2.Driver5_id_no          
            wdetail.Driver5_license_no   =   wdetail2.Driver5_license_no     
            wdetail.Driver5_occupation   =   wdetail2.Driver5_occupation . 
        END.
    END.
            /*IF wdetail2.stk <> ""  THEN DO:                                   -- A58-0489--*/
    IF np_72 <> ""  THEN DO:
    /*ASSIGN 
            wdetail2.policy = "1" + substr(wdetail2.policy,2).         -- A58-0489--*/
        FIND FIRST wdetail WHERE wdetail.policy = np_72 NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN
                /*wdetail.poltyp      = IF substr(wdetail2.policy,1,1) = "0" THEN "70" ELSE "72"                    --A58-0489--*/ 
                /*wdetail.policy      = wdetail2.policy                                                             --A58-0489--*/ 
                /*wdetail.comdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + wdetail2.comyear          --A58-0489--*/ 
                /*wdetail.expdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + STRING(expyear)           --A58-0489--*/ 
                /*wdetail.insnam      = wdetail2.insnam + " " + wdetail2.NAME2                                      --A58-0489--*/ 
                wdetail.poltyp      = "72"                                                                         /*--A58-0489--*/ 
                wdetail.policy      = np_72                                                                        /*--A58-0489--*/ 
                wdetail.comdat      = TRIM(wdetail2.com_comm_date)                                                 /*--A58-0489--*/ 
                wdetail.expdat      = TRIM(wdetail2.com_exp_date)                                                  /*--A58-0489--*/ 
                wdetail.insnam      = trim(wdetail2.ntitle) + TRIM(wdetail2.insnam) + " " + TRIM(wdetail2.NAME2)   /*--A58-0489--*/
                wdetail.icno        = wdetail2.icno                                                                                         
                wdetail.iadd1       = wdetail2.mail_hno                                         /*wdetail2.address*/                        
                wdetail.iadd2       = wdetail2.mail_tambon                                      /*wdetail2.tambon*/                         
                wdetail.iadd3       = wdetail2.mail_amper                                       /*wdetail2.amper */                         
                wdetail.iadd4       = wdetail2.mail_country + " " + wdetail2.mail_post           /*wdetail2.country + " " + wdetail2.post */ 
                /*wdetail.subclass    = IF wdetail2.vehuse = "เก๋ง" THEN "110" ELSE "210"                           --A58-0489--*/
                wdetail.subclass    = TRIM(wdetail2.class)                                                         /*--A58-0489--*/ 
                wdetail.model       = wdetail2.model 
                wdetail.cc          = wdetail2.cc
                wdetail.engno       = wdetail2.engno
                wdetail.chasno      = trim(wdetail2.chasno)   
                 /*wdetail.vehreg      = "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 7,2) + " " + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 5) /*kridtiya i. A53-0317*/ F67-0001 */ 
                wdetail.vehreg      = IF LENGTH(wdetail2.chasno)  > 8 THEN "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 ) 
                                      ELSE "/" + trim(wdetail2.chasno)  /* F67-0001 */
                wdetail.vehuse      = "1"
                wdetail.garage      = ""
                /*wdetail.stk         = wdetail2.stk                             -- A58-0489--*/ 
                wdetail.stk         = trim(wdetail2.com_no)                     /*--A58-0489--*/ 
                /*wdetail.covcod      = "1"                                     -- A58-0489--*/
                wdetail.covcod      = "T"                                      /*--A58-0489--*/
                wdetail.si          = "" /*wdetail2.si*/
                wdetail.prempa      = "V"
                wdetail.branch      = wdetail2.branch 
                wdetail.benname     = wdetail2.financename
                /*wdetail.volprem     = wdetail2.baseprm                       --A58-0489--*/
                wdetail.volprem     = wdetail2.com_netprem                     /*--A58-0489--*/
                wdetail.comment     = wdetail2.typepay     
                wdetail.agent       = ""
                wdetail.producer    = ""   
                /*wdetail.CoverNote   = wdetail2.staus                         --A58-0489--*/ 
                /*wdetail.nmember     = wdetail2.REMARK                        --A58-0489--*/ 
                wdetail.nmember     = wdetail2.REMARK1                        /*--A58-0489--*/ 
                wdetail.entdat      = string(TODAY)               /*entry date*/
                wdetail.enttim      = STRING(TIME, "HH:MM:SS")    /*entry time*/
                wdetail.trandat     = STRING(TODAY)               /*tran date*/
                wdetail.trantim     = STRING(TIME, "HH:MM:SS")    /*tran time*/
                wdetail.n_IMPORT    = "IM"  
                wdetail.n_EXPORT    = ""
                wdetail.deler       = wdetail2.deler    
                wdetail.n_telreq    = wdetail2.showroom  
                wdetail.delerco     = wdetail2.delerco 
                wdetail.financecd   = wdetail2.financecd .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
        END.  /*if avail*/
    END.      /*stk <> ""*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk4 C-Win 
PROCEDURE proc_matchfilechk4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*If  substr(fi_output1,length(fi_output1) - 3,4) <>  ".slk"  Then
    fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_cnt   =  0
       nv_row   =  0 .
OUTPUT STREAM ns2 TO VALUE(fi_output1).
/*PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "TEXT FILE FROM TIL(บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด)"  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  "สาขา"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  "รหัสดีเลอร์"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  "Type"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  "Policy"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  "Comdate"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  "expidate"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  "ชื่อลูกค้า"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  "เลขที่บัตรประชาชน"   '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  "ที่อยู่"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'  "ถนน"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'  "แขวง"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'  "เขต"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'  "คลาส"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'  "รุ่นรถ"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'  "ขนาดเครื่อง"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'  "ทะเบียนรถ"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'  "เลขเครื่อง"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'  "เลขตัวถัง"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'  "ลักษณะการใช้"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'  "การซ่อม"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'  "สติ๊กเกอร์ "         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'  "ชื่อดีเลอร์"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'  "โชว์รูม"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'  "ทุนประกัยภัย"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'  "package"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'  "ความคุ้มครอง"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'  "ผู้รับผลประโยชน์"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'  "เบี้ยสุทธิ"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'  "การจ่าย"             '"' SKIP.*/
 nv_row  =  nv_row + 1.
 PUT STREAM ns2 "ID;PND" SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "Ins. Year type"    '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Business type"      '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "TAS received by"    '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "Ins company "       '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Insurance ref no."  '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "TPIS Contract No."  '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "Title name "        '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "customer name"      '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "customer lastname " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "Customer type"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "Director Name"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "ID number"          '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "House no."          '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Building "          '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "Village name/no."   '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "Soi"                '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "Road "              '"' SKIP.                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Sub-district"       '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "District"            '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Province"            '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Postcode"            '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Brand"               '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "Car model "          '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Insurance Code"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Model Year"          '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "Usage Type"          '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Colour "             '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Car Weight"          '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Year      "          '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Engine No."          '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Chassis No."         '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Accessories (for CV)"    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Accessories amount"      '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "License No."             '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "Registered Car License"  '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "Campaign"                '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "Type of work "           '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "Insurance amount"        '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "Insurance Date (Voluntary) "   '"' SKIP.                                                
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "Expiry Date (Voluntary)    "   '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "Last Policy No.(Voluntary) "   '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "Insurance Type             "   '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "Net premium (Voluntary)    "   '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "Gross premium (Voluntary)  "   '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "Stamp "                        '"' SKIP.              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "VAT   "                        '"' SKIP.              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "WHT   "                        '"' SKIP.              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "Compulsory No."                '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Insurance Date (Compulsory)"   '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "Expiry Date ( Compulsory)  "   '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "Net premium (Compulsory)   "   '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "Gross premium (Compulsory) "   '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "Stamp   "                      '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "VAT     "                      '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "WHT     "                      '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "Dealer  "                      '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "Showroom   "                   '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "Payment Type "                 '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "Beneficiery  "                 '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "Mailing House no."             '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "Mailing  Building"             '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "Mailing  Village name/no. "    '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "Mailing  Soi  "                '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "Mailing  Road "                '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "Mailing  Sub-district"         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "Mailing  District "            '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "Mailing Province  "            '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "Mailing Postcode  "            '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "Policy no. to customer date"   '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "New policy no      "         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "Insurer Stamp Date "         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "Remark             "         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "Occupation code    "         '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "Register NO.       "         '"' SKIP.
 RUN proc_matchfilechk5.
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
For each  wdetail2 :
    DELETE  wdetail2.
END.
For each  wdetail :
    DELETE  wdetail.
END.
message "Export File  Complete"  view-as alert-box.*/

/*---------------------------------------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk5 C-Win 
PROCEDURE proc_matchfilechk5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FOR EACH wdetail.*/ /*A58-0489*/
/*----- create by A58-0489--*/
/*DEF VAR n_pol       AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_recnt     AS INT INIT 0.
DEF VAR n_encnt     AS INT INIT 0.
for each wdetail2. 
    IF INDEX(wdetail2.ins_ytyp,"Ins") <> 0 OR INDEX(wdetail2.ins_ytyp,"ins") <> 0 THEN DELETE wdetail2.  
    ELSE IF INDEX(wdetail2.ins_ytyp,"Renew") <> 0 OR INDEX(wdetail2.ins_ytyp,"renew") <> 0 THEN DELETE wdetail2.  /*--A58-0489--*/
    ELSE IF wdetail2.tpis_no <> "" THEN DO: 
   
    IF wdetail2.campaign = "" THEN DO:
        IF wdetail2.bus_typ = "LCV" THEN ASSIGN wdetail2.campaign = "*".
        ELSE ASSIGN wdetail2.campaign = "-".
    END.
    IF INDEX(wdetail2.financename,"cash") <> 0 THEN ASSIGN wdetail2.financename = "".
    IF wdetail2.financename <> "" THEN DO:
        FIND FIRST stat.insure WHERE stat.insure.compno = "TPIS-LEAS"        AND 
                                 stat.insure.fname = wdetail2.financename   OR
                                 stat.insure.lname = wdetail2.financename   NO-LOCK NO-ERROR . 
         IF AVAIL stat.insure THEN
             ASSIGN wdetail2.financename = stat.insure.addr1 + stat.insure.addr2.
         ELSE 
             ASSIGN wdetail2.financename = "error : " + wdetail2.financename.
    END.
    ASSIGN 
        nv_cnt  =  nv_cnt  + 1                      
        nv_row  =  nv_row + 1.
    /*------ comment by : A58-0489---------------
    IF wdetail.poltyp  = "72" THEN DO:
        IF wdetail.subclass = "110" THEN wdetail.volprem = "600".
        ELSE IF wdetail.subclass = "210" THEN wdetail.volprem = "900".
    END.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetail.branch    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetail.delerco   '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetail.poltyp    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail.policy    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail.comdat    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetail.expdat    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetail.insnam    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail.icno      '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail.iadd1     '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.iadd2     '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.iadd3     '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.iadd4     '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail.subclass  '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail.model     '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail.cc        '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' wdetail.vehreg    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' wdetail.engno     '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' wdetail.chasno    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' wdetail.vehuse    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' wdetail.garage    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' wdetail.stk       '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' wdetail.deler     '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' wdetail.n_telreq  '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' wdetail.si        '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' wdetail.prempa    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' wdetail.covcod    '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' wdetail.benname   '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' wdetail.volprem   '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' wdetail.comment   '"' SKIP. 
    ------------- end : A58-0489---------------*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   Wdetail2.ins_ytyp             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail2.bus_typ              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail2.TASreceived          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail2.InsCompany           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail2.Insurancerefno       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail2.tpis_no              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail2.ntitle               '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail2.insnam               '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail2.NAME2                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetail2.cust_type            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetail2.nDirec               '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetail2.ICNO                 '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetail2.address              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   wdetail2.build                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   wdetail2.mu                   '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   wdetail2.soi                  '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   wdetail2.road                 '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   wdetail2.tambon               '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   wdetail2.amper                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   wdetail2.country              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   wdetail2.post                 '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   wdetail2.brand                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   wdetail2.model                '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   wdetail2.class                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   wdetail2.md_year              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   wdetail2.Usage                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   wdetail2.coulor               '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   wdetail2.cc                   '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   wdetail2.regis_year           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   wdetail2.engno                '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   wdetail2.chasno               '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   Wdetail2.Acc_CV               '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   IF Wdetail2.Acc_amount = "" THEN "" ELSE STRING(DECI(Wdetail2.Acc_amount)) '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'   wdetail2.License              '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'   wdetail2.regis_CL             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'   wdetail2.campaign             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'   wdetail2.typ_work             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'   DECI(wdetail2.si)                   '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'   DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'   DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'   wdetail2.LAST_pol               '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'   wdetail2.cover                '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'   DECI(wdetail2.pol_netprem)          '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'   DECI(wdetail2.pol_gprem)            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'   DECI(wdetail2.pol_stamp)            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'   DECI(wdetail2.pol_vat)              '"' SKIP.           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'   DECI(wdetail2.pol_wht)              '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'   wdetail2.com_no               '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'   DATE(wdetail2.com_comm_date) FORMAT "99/99/9999"   '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'   DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999"   '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'   DECI(wdetail2.com_netprem)          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'   DECI(wdetail2.com_gprem)            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'   DECI(wdetail2.com_stamp)            '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'   DECI(wdetail2.com_vat)              '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'   DECI(wdetail2.com_wht)              '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'   wdetail2.deler                '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'   wdetail2.showroom             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'   wdetail2.typepay              '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'   wdetail2.financename          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'   wdetail2.mail_hno             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"'   wdetail2.mail_build           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"'   wdetail2.mail_mu              '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"'   wdetail2.mail_soi             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"'   wdetail2.mail_road            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"'   wdetail2.mail_tambon          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"'   wdetail2.mail_amper           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"'   wdetail2.mail_country         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"'   wdetail2.mail_post            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"'   wdetail2.send_date            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"'   wdetail2.policy               '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"'   wdetail2.send_data            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"'   wdetail2.REMARK1              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"'   wdetail2.occup                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"'   wdetail2.regis_no             '"' SKIP.
    END.
END.   /*  end  wdetail2  */  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_matchfilechk6 C-Win 
PROCEDURE Proc_matchfilechk6 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_output1,length(fi_output1) - 3,4) <>  ".slk"  Then
    fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_cnt   =  0
       nv_row   =  0 .
OUTPUT STREAM ns2 TO VALUE(fi_output1).
 nv_row  =  nv_row + 1.
 PUT STREAM ns2 "ID;PND" SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "จังหวัด"        '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "สาขา"           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "ภูมิภาค"        '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "สาขากรมธรรม์"        '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "รหัสดีเลอร์"        '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Ins. Year type"      '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "Business type"       '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "TAS received by"     '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "Ins company "        '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "New policy no  "     '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "Compulsory No."      '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "Insurance ref no."   '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "TPIS Contract No."   '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Title name "         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "customer name"       '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "customer lastname "  '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "Customer type"       '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Director Name"       '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "ID number"           '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "House no."           '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Building "           '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Village name/no."    '"' SKIP.                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "Soi"                 '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Road "               '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Sub-district"        '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "District"            '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Province"            '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Postcode"            '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Brand"               '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Car model "          '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Insurance Code"      '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Model Year"          '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Usage Type"          '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "Colour "             '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "Car Weight"          '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "Year      "          '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "Engine No."          '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "Chassis No."                      '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "Accessories (for CV)"             '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "Accessories amount"               '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "License No."                      '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "Registered Car License"           '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "Campaign"                         '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "Type of work "                    '"' SKIP.                                                
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "Insurance amount"                 '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "Insurance Date (Voluntary) "      '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "Expiry Date (Voluntary)    "      '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "Last Policy No.(Voluntary) "      '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Insurance Type"                    '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "Net premium (Voluntary)    "      '"' SKIP.              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "Gross premium (Voluntary)  "      '"' SKIP.              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "Stamp "                           '"' SKIP.              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "VAT   "                           '"' SKIP.                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "Stamp HO "                        '"' SKIP. /* A61-0152*/   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "VAT HO  "                         '"' SKIP. /* A61-0152*/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "WHT   "                           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "Sticker No.                  "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "Insurance Date ( Compulsory )"    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "Expiry Date ( Compulsory)    "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "Net premium (Compulsory)     "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "Gross premium (Compulsory)   "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "Stamp "                           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "VAT"                              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "WHT "                             '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "Dealer "                          '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "Showroom  "                       '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "Payment Type "                    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "Beneficiery"                      '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "Mailing House no."                '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "Mailing  Building "               '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "Mailing  Village name/no."        '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "Mailing Soi           "           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "Mailing  Road         "           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "Mailing  Sub-district "           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' "Mailing  District     "           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "Mailing Province      "           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "Mailing Postcode      "           '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "Policy no. to customer date  "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' "Insurer Stamp Date "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' "Remark             "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' "Occupation code    "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' "Memo Text          "              '"' SKIP.  /*A61-0152*/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' "Register NO.       "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' "Producer code      "              '"' SKIP. 
/* A66-0252 */
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' "Promo                  "              '"' SKIP.    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' "Product                "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' "f18line1               "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' "f18line2               "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' "f18line3           "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"' "Campaign TMSTH     "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"' "Driver1_title       "              '"' SKIP.       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"' "Driver1_name        "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"' "Driver1_lastname    "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"' "Driver1_birthdate   "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K" '"' "Driver1_id_no       "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K" '"' "Driver1_license_no  "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K" '"' "Driver1_occupation   "              '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K" '"' "Driver2_title        "              '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K" '"' "Driver2_name         "              '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"' "Driver2_lastname    "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"' "Driver2_birthdate   "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"' "Driver2_id_no       "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"' "Driver2_license_no  "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"' "Driver2_occupation  "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"' "Driver3_title       "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"' "Driver3_name        "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"' "Driver3_lastname    "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"' "Driver3_birthdate   "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"' "Driver3_id_no       "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"' "Driver3_license_no  "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"' "Driver3_occupation  "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"' "Driver4_title       "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"' "Driver4_name        "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X114;K" '"' "Driver4_lastname    "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X115;K" '"' "Driver4_birthdate   "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X116;K" '"' "Driver4_id_no       "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X117;K" '"' "Driver4_license_no  "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X118;K" '"' "Driver4_occupation  "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X119;K" '"' "Driver5_title       "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X120;K" '"' "Driver5_name        "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X121;K" '"' "Driver5_lastname    "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X122;K" '"' "Driver5_birthdate   "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X123;K" '"' "Driver5_id_no       "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X124;K" '"' "Driver5_license_no  "              '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X125;K" '"' "Driver5_occupation  "              '"' SKIP. 
 /* end A66-0252*/                                                      

 RUN proc_matchfilechk7.
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
For each  wdetail2 :
    DELETE  wdetail2.
END.
For each  wdetail :
    DELETE  wdetail.
END.
message "Export File  Complete"  view-as alert-box.
RELEASE sicuw.uwm100.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk7 C-Win 
PROCEDURE proc_matchfilechk7 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_pol       AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_recnt     AS INT INIT 0.
DEF VAR n_encnt     AS INT INIT 0.
for each wdetail2.
    IF wdetail2.ins_ytyp = "" THEN DELETE wdetail2.
    ELSE DO:
       IF INDEX(wdetail2.typ_work,"V") <> 0 THEN DO:
          FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE
              sicuw.uwm100.cedpol = wdetail2.tpis_no    AND 
              sicuw.uwm100.poltyp = "V70"                     NO-LOCK NO-ERROR.
              IF AVAIL sicuw.uwm100  THEN DO: 
                  ASSIGN 
                      wdetail2.comment = IF  deci(wdetail2.pol_netprem) <> deci(sicuw.uwm100.prem_t) THEN 
                                             wdetail2.comment + "เบี้ยในไฟล์ " + string(wdetail2.pol_netprem) + " ไม่เท่ากับพรีเมียม " + STRING(sicuw.uwm100.prem_t)  
                                         ELSE wdetail2.comment /* A65-0156 */
                      wdetail2.policy_no   = sicuw.uwm100.policy 
                      /*wdetail2.agent       = sicuw.uwm100.acno1 */ /*A67-0101*/
                      wdetail2.producer    = sicuw.uwm100.acno1  /*A67-0101*/
                      wdetail2.branch      = sicuw.uwm100.branch 
                      wdetail2.delerco     = sicuw.uwm100.finint
                      wdetail2.financecd   = sicuw.uwm100.dealer   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/    
                      wdetail2.np_f18line1 = string(sicuw.uwm100.rstp_t)    /*A61-0152*/      
                      wdetail2.np_f18line2 = string(sicuw.uwm100.rtax_t) .  /*A61-0152*/    
              END.
              ELSE DO:
                  ASSIGN  wdetail2.policy_no  = ""
                          /*wdetail2.agent      = "" */ /* A67-0101 */
                          wdetail2.producer    = "" /*A67-0101*/
                          wdetail2.branch     = ""
                          wdetail2.delerco    = ""
                          wdetail2.financecd   = ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
                          wdetail2.np_f18line1 = ""    /*A61-0152*/
                          wdetail2.np_f18line2 = "" .  /*A61-0152*/
              END.
              IF (trim(wdetail2.financename) = "CASH") OR 
                 (trim(wdetail2.financename) = "Cash") OR 
                 (trim(wdetail2.financename) = "cash") THEN ASSIGN wdetail2.financename  = "".
              ELSE IF trim(wdetail2.financename) <> "" THEN DO:
                  FIND FIRST stat.insure USE-INDEX insure01 WHERE stat.insure.compno = "TPIS-LEAS" AND 
                                       stat.insure.fname = wdetail2.financename   OR
                                       stat.insure.lname = wdetail2.financename   NO-LOCK NO-ERROR . 
                     IF AVAIL stat.insure THEN
                         ASSIGN wdetail2.financename  = stat.insure.addr1 + stat.insure.addr2.
                     ELSE 
                          ASSIGN wdetail2.financename = "error : " + wdetail2.financename.
              END.
              RUN proc_matchbranch.
       END.
       IF INDEX(wdetail2.typ_work,"C") <> 0 THEN DO:
         FIND LAST sicuw.uwm100 USE-INDEX uwm10002  WHERE
              sicuw.uwm100.cedpol = TRIM(wdetail2.tpis_no)    AND 
              sicuw.uwm100.poltyp = "V72"   NO-LOCK NO-ERROR .
             IF AVAIL sicuw.uwm100  THEN DO: 
                  ASSIGN 
                      wdetail2.stkno     = wdetail2.com_no
                      wdetail2.com_no    = sicuw.uwm100.policy 
                      /*wdetail2.agent     = IF wdetail2.agent     = "" THEN sicuw.uwm100.acno1  ELSE wdetail2.agent */   /*A67-0101*/
                      wdetail2.producer  = IF wdetail2.producer  = "" THEN sicuw.uwm100.acno1  ELSE wdetail2.producer  /*A67-0101*/
                      wdetail2.branch    = IF wdetail2.branch    = "" THEN sicuw.uwm100.branch ELSE wdetail2.branch
                      wdetail2.delerco   = IF wdetail2.delerco   = "" THEN sicuw.uwm100.finint ELSE wdetail2.delerco
                      wdetail2.financecd = IF wdetail2.financecd = "" THEN sicuw.uwm100.dealer ELSE wdetail2.financecd .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
                     
              END.
              ELSE DO:
                  ASSIGN  wdetail2.com_no  = ""
                          wdetail2.stkno   = ""
                          /*wdetail2.agent   = ""*/ /* A67-0101*/
                          wdetail2.producer = ""  /* A67-0101*/
                          wdetail2.branch  = ""
                          wdetail2.delerco = "" 
                          wdetail2.financecd = "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
                         /* wdetail2.pol_typ = "". */
              END.
       END.
       RUN proc_matchbranch.
    END.
END.
RUN proc_matchfilechk73.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk70 C-Win 
PROCEDURE proc_matchfilechk70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FOR EACH wdetail2 WHERE INDEX(wdetail2.typ_work,"V") <> 0 BREAK BY wdetail2.agent.
    ASSIGN 
        nv_cnt  =  nv_cnt  + 1                      
        nv_row  =  nv_row  + 1.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetail2.bran_name       '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetail2.bran_name2      '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetail2.Region          '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail2.branch          '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail2.delerco         '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetail2.pol_typ         '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  Wdetail2.ins_ytyp        '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail2.bus_typ         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail2.TASreceived     '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail2.InsCompany     '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail2.policy_no      '"' SKIP.            
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail2.com_no         '"' SKIP.*/                             
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail2.Insurancerefno '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail2.tpis_no        '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail2.ntitle         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail2.insnam         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail2.NAME2          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail2.cust_type      '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail2.nDirec         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail2.ICNO           '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail2.address        '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail2.build          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail2.mu             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail2.soi            '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail2.road           '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail2.tambon         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail2.amper          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail2.country        '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail2.post           '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail2.brand          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail2.model          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail2.class          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail2.md_year        '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail2.Usage          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail2.coulor         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail2.cc             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail2.regis_year     '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail2.engno          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail2.chasno         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  Wdetail2.Acc_CV         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  IF Wdetail2.Acc_amount = "" THEN "" ELSE STRING(DECI(Wdetail2.Acc_amount)) '"' SKIP.            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail2.License              '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail2.regis_CL             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail2.campaign             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail2.typ_work             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  DECI(wdetail2.si) FORMAT ">>,>>>,>>9.99"     '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'  DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.                                
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"'  DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.                                
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  wdetail2.LAST_pol               '"' SKIP. */                                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'  wdetail2.cover                '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'  DECI(wdetail2.pol_netprem)          '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'  DECI(wdetail2.pol_gprem)            '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'  DECI(wdetail2.pol_stamp)            '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'  DECI(wdetail2.pol_vat)              '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'  DECI(wdetail2.pol_wht)              '"' SKIP.                                                   
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  wdetail2.stkno     '"' SKIP.                                                                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  DATE(wdetail2.com_comm_date) FORMAT "99/99/9999"   '"' SKIP.                                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999"   '"' SKIP.                                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  DECI(wdetail2.com_netprem)          '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  DECI(wdetail2.com_gprem)            '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  DECI(wdetail2.com_stamp)            '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  DECI(wdetail2.com_vat)              '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  DECI(wdetail2.com_wht)              '"' SKIP. */                                                  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  wdetail2.deler                '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  wdetail2.showroom             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  wdetail2.typepay              '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  wdetail2.financename          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  wdetail2.mail_hno             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  wdetail2.mail_build           '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  wdetail2.mail_mu              '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  wdetail2.mail_soi             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  wdetail2.mail_road            '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  wdetail2.mail_tambon          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  wdetail2.mail_amper           '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  wdetail2.mail_country         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  wdetail2.mail_post            '"' SKIP.                                                         
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  wdetail2.send_date            '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  wdetail2.send_data            '"' SKIP. */                                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  wdetail2.REMARK1              '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  wdetail2.occup                '"' SKIP.                                                         
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"'  wdetail2.regis_no             '"' SKIP.*/                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  wdetail2.agent              '"' SKIP.                                                         
END. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk72 C-Win 
PROCEDURE proc_matchfilechk72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FOR EACH wdetail2 WHERE INDEX(wdetail2.typ_work,"C") <> 0 BREAK BY wdetail2.agent.
    ASSIGN 
        nv_cnt  =  nv_cnt  + 1                      
        nv_row  =  nv_row  + 1.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  wdetail2.bran_name       '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  wdetail2.bran_name2      '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  wdetail2.Region          '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  wdetail2.branch          '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  wdetail2.delerco         '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  wdetail2.pol_typ         '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  Wdetail2.ins_ytyp        '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  wdetail2.bus_typ         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  wdetail2.TASreceived     '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail2.InsCompany     '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail2.policy_no      '"' SKIP.            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail2.com_no         '"' SKIP.                             
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail2.Insurancerefno '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail2.tpis_no        '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail2.ntitle         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail2.insnam         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail2.NAME2          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail2.cust_type      '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail2.nDirec         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail2.ICNO           '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail2.address        '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail2.build          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail2.mu             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail2.soi            '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail2.road           '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail2.tambon         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail2.amper          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail2.country        '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail2.post           '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail2.brand          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail2.model          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail2.class          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail2.md_year        '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail2.Usage          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail2.coulor         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail2.cc             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail2.regis_year     '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail2.engno          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail2.chasno         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  Wdetail2.Acc_CV         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  IF Wdetail2.Acc_amount = "" THEN "" ELSE STRING(DECI(Wdetail2.Acc_amount)) '"' SKIP.            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail2.License              '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail2.regis_CL             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail2.campaign             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail2.typ_work             '"' SKIP.                                                         
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  DECI(wdetail2.si) FORMAT ">>,>>>,>>9.99"     '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'  DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.                                
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"'  DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.                                
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  wdetail2.LAST_pol               '"' SKIP.*/                                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  wdetail2.cover                '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"'  DECI(wdetail2.pol_netprem)          '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"'  DECI(wdetail2.pol_gprem)            '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"'  DECI(wdetail2.pol_stamp)            '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"'  DECI(wdetail2.pol_vat)              '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"'  DECI(wdetail2.pol_wht)              '"' SKIP. */                                                  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  wdetail2.stkno     '"' SKIP.                                                                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  DATE(wdetail2.com_comm_date) FORMAT "99/99/9999"   '"' SKIP.                                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999"   '"' SKIP.                                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  DECI(wdetail2.com_netprem)          '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  DECI(wdetail2.com_gprem)            '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  DECI(wdetail2.com_stamp)            '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  DECI(wdetail2.com_vat)              '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  DECI(wdetail2.com_wht)              '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  wdetail2.deler                '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  wdetail2.showroom             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  wdetail2.typepay              '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  wdetail2.financename          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  wdetail2.mail_hno             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  wdetail2.mail_build           '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  wdetail2.mail_mu              '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  wdetail2.mail_soi             '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  wdetail2.mail_road            '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  wdetail2.mail_tambon          '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  wdetail2.mail_amper           '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  wdetail2.mail_country         '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  wdetail2.mail_post            '"' SKIP.                                                         
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  wdetail2.send_date            '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  wdetail2.send_data            '"' SKIP.*/                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  wdetail2.REMARK1              '"' SKIP.                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  wdetail2.occup                '"' SKIP.                                                         
 /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"'  wdetail2.regis_no             '"' SKIP.*/                                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  wdetail2.agent              '"' SKIP.                                                         
END. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk73 C-Win 
PROCEDURE proc_matchfilechk73 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH wdetail2 BREAK BY wdetail2.producer. /*wdetail2.agent*/ /*A67-0101*/
    ASSIGN 
        nv_cnt  =  nv_cnt  + 1                      
        nv_row  =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  Wdetail2.bran_name            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  Wdetail2.bran_name2           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  Wdetail2.region               '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail2.branch               '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail2.delerco              '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  Wdetail2.ins_ytyp             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetail2.bus_typ              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail2.TASreceived          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail2.InsCompany           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'  wdetail2.policy_no            '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'  wdetail2.com_no               '"' SKIP.                             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'  wdetail2.Insurancerefno       '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'  wdetail2.tpis_no              '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'  wdetail2.ntitle               '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'  wdetail2.insnam               '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'  wdetail2.NAME2                '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'  wdetail2.cust_type            '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'  wdetail2.nDirec               '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'  wdetail2.ICNO                 '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'  wdetail2.address              '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'  wdetail2.build                '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'  wdetail2.mu                   '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'  wdetail2.soi                  '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'  wdetail2.road                 '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'  wdetail2.tambon               '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'  wdetail2.amper                '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'  wdetail2.country              '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'  wdetail2.post                 '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'  wdetail2.brand                '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'  wdetail2.model                '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'  wdetail2.class                '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'  wdetail2.md_year              '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'  wdetail2.Usage                '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'  wdetail2.coulor               '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'  wdetail2.cc                   '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'  wdetail2.regis_year           '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'  wdetail2.engno                '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'  wdetail2.chasno               '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'  Wdetail2.Acc_CV               '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'  IF Wdetail2.Acc_amount = "" THEN "" ELSE STRING(DECI(Wdetail2.Acc_amount)) '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'  wdetail2.License              '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'  wdetail2.regis_CL             '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'  wdetail2.campaign             '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'  wdetail2.typ_work             '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'  DECI(wdetail2.si) FORMAT ">>,>>>,>>9.99"     '"' SKIP.                                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'  DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'  DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'  wdetail2.LAST_pol               '"' SKIP.                                                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'  wdetail2.cover                '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'  DECI(wdetail2.pol_netprem)          '"' SKIP.                                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'  DECI(wdetail2.pol_gprem)            '"' SKIP.                                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'  DECI(wdetail2.pol_stamp)            '"' SKIP.                                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'  DECI(wdetail2.pol_vat)              '"' SKIP.                                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'  wdetail2.np_f18line1                '"' SKIP.   /*A61-0152*/    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'  wdetail2.np_f18line2                '"' SKIP.   /*A61-0152*/    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'  DECI(wdetail2.pol_wht)              '"' SKIP.                                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'  wdetail2.stkno     '"' SKIP.                                                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'  DATE(wdetail2.com_comm_date) FORMAT "99/99/9999"   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'  DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999"   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'  DECI(wdetail2.com_netprem)          '"' SKIP.                                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"'  DECI(wdetail2.com_gprem)            '"' SKIP.                                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"'  DECI(wdetail2.com_stamp)            '"' SKIP.                                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"'  DECI(wdetail2.com_vat)              '"' SKIP.                                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"'  DECI(wdetail2.com_wht)              '"' SKIP.                                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"'  wdetail2.deler                '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"'  wdetail2.showroom             '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"'  wdetail2.typepay              '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"'  wdetail2.financename          '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"'  wdetail2.mail_hno             '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"'  wdetail2.mail_build           '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"'  wdetail2.mail_mu              '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"'  wdetail2.mail_soi             '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"'  wdetail2.mail_road            '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"'  wdetail2.mail_tambon          '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"'  wdetail2.mail_amper           '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"'  wdetail2.mail_country         '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"'  wdetail2.mail_post            '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"'  wdetail2.send_date            '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"'  wdetail2.send_data            '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"'  wdetail2.REMARK1              '"' SKIP.                                                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"'  wdetail2.occup                '"' SKIP.                                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"'  wdetail2.memotext             '"' SKIP.  /*A61-0152*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"'  wdetail2.regis_no             '"' SKIP.                                    
    /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"'  wdetail2.agent                '"' SKIP.*/ /* A67-0101*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"'  wdetail2.producer                '"' SKIP. /* A67-0101*/
    /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"'  wdetail2.comment              '"' SKIP.*/ /*A66-0252*/
    /* A66-0252 */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"'  wdetail2.claimdi              '"' skip.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"'  wdetail2.product              '"' skip.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"'  wdetail2.np_f18line3          '"' skip.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"'  wdetail2.np_f18line4          '"' skip.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"'  wdetail2.np_f18line5          '"' skip.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"'  wdetail2.campens              '"' skip. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"'  wdetail2.comment              '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"'  wdetail2.Driver1_title         '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"'  wdetail2.Driver1_name          '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"'  wdetail2.Driver1_lastname      '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"'  wdetail2.Driver1_birthdate     '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K" '"'  wdetail2.Driver1_id_no         '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K" '"'  wdetail2.Driver1_license_no    '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K" '"'  wdetail2.Driver1_occupation    '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K" '"'  wdetail2.Driver2_title          '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K" '"'  wdetail2.Driver2_name           '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"'  wdetail2.Driver2_lastname      '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"'  wdetail2.Driver2_birthdate     '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"'  wdetail2.Driver2_id_no         '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"'  wdetail2.Driver2_license_no    '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"'  wdetail2.Driver2_occupation    '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"'  wdetail2.Driver3_title       '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"'  wdetail2.Driver3_name        '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"'  wdetail2.Driver3_lastname    '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"'  wdetail2.Driver3_birthday    '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"'  wdetail2.Driver3_id_no       '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"'  wdetail2.Driver3_license_no  '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"'  wdetail2.Driver3_occupation  '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"'  wdetail2.Driver4_title       '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"'  wdetail2.Driver4_name        '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X114;K" '"'  wdetail2.Driver4_lastname    '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X115;K" '"'  wdetail2.Driver4_birthdate   '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X116;K" '"'  wdetail2.Driver4_id_no       '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X117;K" '"'  wdetail2.Driver4_license_no  '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X118;K" '"'  wdetail2.Driver4_occupation  '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X119;K" '"'  wdetail2.Driver5_title       '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X120;K" '"'  wdetail2.Driver5_name        '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X121;K" '"'  wdetail2.Driver5_lastname    '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X122;K" '"'  wdetail2.Driver5_birthdate   '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X123;K" '"'  wdetail2.Driver5_id_no       '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X124;K" '"'  wdetail2.Driver5_license_no  '"' skip.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X125;K" '"'  wdetail2.Driver5_occupation  '"' SKIP.      
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk8 C-Win 
PROCEDURE proc_matchfilechk8 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------ Comment by : A58-0489 ------------------------------*/
If  substr(fi_output1,length(fi_output1) - 3,4) <>  ".slk"  Then
    fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_cnt   =  0
       nv_row   =  1 .
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "TEXT FILE FROM TIL(บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด)"  '"' SKIP. 
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  "ออกใบเสร็จในนาม  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  "Policy"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  "สาขา"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  "รหัสดีเลอร์"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  "Type"               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  "Cedpol"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  "Comdate"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  "expidate"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  "ชื่อลูกค้า"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  "เลขที่บัตรประชาชน"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  "ที่อยู่"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  "ถนน"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  "แขวง"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  "เขต"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  "คลาส"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  "รุ่นรถ"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  "ขนาดเครื่อง"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  "ทะเบียนรถ"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  "เลขเครื่อง"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  "เลขตัวถัง"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  "ลักษณะการใช้"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  "การซ่อม"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  "สติ๊กเกอร์ "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  "ชื่อดีเลอร์"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  "โชว์รูม"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  "ทุนประกัยภัย"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  "package"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  "ความคุ้มครอง"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  "ผู้รับผลประโยชน์"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  "เบี้ยสุทธิ"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  "การจ่าย"            '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  "REMARK"             '"' SKIP.  
RUN proc_matchfilechk9. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
For each  wdetail2 :
    DELETE  wdetail2.
END.
For each  wdetail :
    DELETE  wdetail.
END.
message "Export File  Complete"  view-as alert-box. 
RELEASE sicuw.uwm100.
/*-------------end : A58-0489 --------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk9 C-Win 
PROCEDURE proc_matchfilechk9 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_policyuwm100 AS CHAR FORMAT "x(20)" INIT "".

FOR each wdetail .  
    /*IF   wdetail.CoverNote <> ""  THEN DO: */ /*A58-0489*/
    IF wdetail.nmember <> ""  THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002  WHERE
            sicuw.uwm100.cedpol = trim(substr(wdetail.policy,2))     AND 
            sicuw.uwm100.poltyp = "V" + wdetail.poltyp  NO-LOCK   NO-ERROR .
        IF AVAIL sicuw.uwm100 THEN  
            /*wdetail.nmember   = sicuw.uwm100.name2. */ /* F67-0001 */
            ASSIGN wdetail.nmember   = trim(trim(sicuw.uwm100.name2) + " " + TRIM(sicuw.uwm100.name3))  /* F67-0001 */
                   wdetail.branch   = if trim(wdetail.branch) = "" then sicuw.uwm100.branch else trim(wdetail.branch) /* F67-0001 */
                   wdetail.deler    = if trim(wdetail.deler)  = "" then sicuw.uwm100.finint else trim(wdetail.deler) . /* F67-0001 */
    END.
    ELSE DELETE wdetail. 
END.

FOR each wdetail 
    BY wdetail.nmember . /*A58-0489*/
    FIND LAST wdetail2 WHERE TRIM(wdetail2.tpis_no)  = trim(substr(wdetail.policy,2)) NO-LOCK NO-ERROR.  /*A58-0489*/
    IF AVAIL wdetail2 THEN DO:
     ASSIGN 
         n_policyuwm100 = ""    
         nv_cnt  =  nv_cnt  + 1                      
         nv_row  =  nv_row + 1.   
         FIND LAST sicuw.uwm100 USE-INDEX uwm10002  WHERE
             sicuw.uwm100.cedpol = trim(substr(wdetail.policy,2))     AND 
             sicuw.uwm100.poltyp = "V" + wdetail.poltyp  NO-LOCK   NO-ERROR .
             IF AVAIL sicuw.uwm100  THEN n_policyuwm100  = sicuw.uwm100.policy .
    END.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' wdetail.nmember   FORMAT "x(60)"   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' n_policyuwm100    FORMAT "x(20)"   '"' SKIP.                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' wdetail.branch    FORMAT "x(2)"     '"' SKIP.                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdetail.deler                     '"' SKIP.                             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "V" + wdetail.poltyp                 '"' SKIP.                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' trim(substr(wdetail.policy,2))  FORMAT "x(20)"    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' wdetail.comdat    '"' SKIP.                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' wdetail.expdat    '"' SKIP.                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' wdetail.insnam    '"' SKIP.                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' wdetail.icno       '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' wdetail.iadd1      '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' wdetail.iadd2      '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' wdetail.iadd3      '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' wdetail.iadd4      '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' wdetail.subclass   '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' wdetail.model      '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' wdetail.cc         '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' wdetail.vehreg     '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' wdetail.engno      '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' wdetail.chasno     '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' wdetail.vehuse     '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' wdetail.garage     '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' wdetail.stk        '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' trim(wdetail2.deler)     FORMAT "x(100)"      '"' SKIP.                                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' trim(wdetail2.showroom)  FORMAT "x(100)"     '"' SKIP.                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' wdetail.si         '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' wdetail.prempa     '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' wdetail.covcod     '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' wdetail.benname    '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' wdetail.volprem    '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' wdetail.comment   FORMAT "x(60)"     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' wdetail2.remark1   FORMAT "x(200)"    '"' SKIP.  

END.  /*  end  wdetail  */  
/*------------ end : A58-0489 ------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk_new C-Win 
PROCEDURE proc_matchfilechk_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A62-0422 เพิ่มการรับค่า Garage Desmodel       
------------------------------------------------------------------------------*/
DEF BUFFER bfwdetail2 FOR wdetail2. /*A62-0422*/
For each  wdetail2 :
    DELETE  wdetail2.
END.
For each  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail2.
    IMPORT DELIMITER "|"     
        wdetail2.ins_ytyp          
        wdetail2.bus_typ           
        wdetail2.TASreceived          
        wdetail2.InsCompany           
        wdetail2.Insurancerefno       
        wdetail2.tpis_no
        wdetail2.ntitle             
        wdetail2.insnam               
        wdetail2.NAME2                
        wdetail2.cust_type
        wdetail2.nDirec               
        wdetail2.ICNO                 
        wdetail2.address              
        wdetail2.build
        wdetail2.mu                   
        wdetail2.soi                  
        wdetail2.road                 
        wdetail2.tambon               
        wdetail2.amper                
        wdetail2.country              
        wdetail2.post                 
        wdetail2.brand             
        wdetail2.model                
        wdetail2.class
        wdetail2.md_year
        wdetail2.Usage               
        wdetail2.coulor               
        wdetail2.cc                   
        wdetail2.regis_year     
        wdetail2.engno                
        wdetail2.chasno               
        Wdetail2.Acc_CV            
        Wdetail2.Acc_amount        
        wdetail2.License
        wdetail2.regis_CL
        wdetail2.campaign
        wdetail2.typ_work
        wdetail2.garage      /*A62-0422*/
        wdetail2.desmodel    /*A62-0422*/
        wdetail2.si                   
        wdetail2.pol_comm_date     
        wdetail2.pol_exp_date     
        wdetail2.last_pol
        wdetail2.cover
        wdetail2.pol_netprem
        wdetail2.pol_gprem
        wdetail2.pol_stamp
        wdetail2.pol_vat
        wdetail2.pol_wht
        wdetail2.com_no
        wdetail2.com_comm_date
        wdetail2.com_exp_date
        wdetail2.com_netprem
        wdetail2.com_gprem
        wdetail2.com_stamp
        wdetail2.com_vat
        wdetail2.com_wht
        wdetail2.deler                
        wdetail2.showroom             
        wdetail2.typepay              
        wdetail2.financename          
        wdetail2.mail_hno
        wdetail2.mail_build
        wdetail2.mail_mu                   
        wdetail2.mail_soi                  
        wdetail2.mail_road                 
        wdetail2.mail_tambon               
        wdetail2.mail_amper                
        wdetail2.mail_country              
        wdetail2.mail_post                 
        wdetail2.send_date
        wdetail2.policy_no
        wdetail2.send_data
        wdetail2.REMARK1              
        wdetail2.occup
        wdetail2.memotext /*A61-0152*/
        wdetail2.regis_no.
    IF INDEX(wdetail2.ins_ytyp,"Ins") <> 0 THEN DELETE wdetail2.               
    ELSE IF INDEX(wdetail2.ins_ytyp,"ins")  <> 0 THEN DELETE wdetail2. 
    ELSE IF INDEX(wdetail2.ins_ytyp,"Renew") <> 0 THEN DELETE wdetail2. 
    ELSE IF INDEX(wdetail2.ins_ytyp,"renew")  <> 0 THEN DELETE wdetail2. 
    ELSE IF wdetail2.ins_ytyp = "" THEN DELETE wdetail2. 
END.   /* repeat  */
RELEASE wdetail2.

FIND FIRST bfwdetail2 WHERE bfwdetail2.tpis_no <> "" AND INDEX(bfwdetail2.garage,"ซ่อม") = 0 NO-ERROR NO-WAIT .
 IF AVAIL bfwdetail2 THEN DO:
     MESSAGE "กรุณาเลือกไฟล์แจ้งงานแบบใหม่! " VIEW-AS ALERT-BOX.
     FOR EACH wdetail2 .
        DELETE wdetail2.
     END.
 END.

IF   ra_typeload = 2 THEN Run  proc_matchfilechk6.  /* File to HO */
IF   ra_typeload = 4 THEN RUN  proc_matchfiletil_new.   /* file to TPIS*/
RUN  proc_matchfilechk1.
RUN  proc_matchfilechk3.
IF ra_typeload = 3 THEN Run  proc_matchfilechk8.  /* recipt */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfiletil C-Win 
PROCEDURE proc_matchfiletil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  ไฟล์ส่งตรีเพชร     
------------------------------------------------------------------------------*/
/*--------------- Create by : A58-0489-------------------------------------*/
If  substr(fi_output2,length(fi_output2) - 3,4) <>  ".SLK"  Then
    fi_output2  =  Trim(fi_output2) + ".SLK"  .
ASSIGN nv_cnt   =  0
       nv_row   =  0 .
OUTPUT STREAM ns2 TO VALUE(fi_output2).
PUT STREAM ns2 "ID;PND" SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "Ins. Year type               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "Business type                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "TAS received by              "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "Ins company                  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "Insurance ref no.            "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "TPIS Contract No.            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "Title name                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "customer name                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "customer lastname            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Customer type                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Director Name                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "ID number                    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "House no.                    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Building                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "Village name/no.             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "Soi                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "Road                         "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "Sub-district                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "District                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "Province                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "Postcode                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "Brand                        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "Car model                    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "Insurance Code               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "Model Year                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "Usage Type                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "Colour                       "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "Car Weight (CC.)             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "Year                         "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "Engine No.                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "Chassis No.                  "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "Accessories (for CV)         "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "Accessories amount           "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "License No.                  "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "Registered Car License       "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "Campaign                     "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "Type of work                 "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "Insurance amount             "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "Insurance Date ( Voluntary ) "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "Expiry Date ( Voluntary)     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "Last Policy No. (Voluntary)  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "Insurance Type               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "Net premium (Voluntary)      "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "Gross premium (Voluntary)    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "Stamp                        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "VAT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "WHT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "Compulsory No.               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "Insurance Date ( Compulsory )"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "Expiry Date ( Compulsory)    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "Net premium (Compulsory)     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "Gross premium (Compulsory)   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "Stamp                        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "VAT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "WHT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "Dealer                       "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "Showroom                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "Payment Type                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "Beneficiery                  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' "Mailing House no.            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "Mailing  Building            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "Mailing  Village name/no.    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "Mailing Soi                  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "Mailing  Road                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "Mailing  Sub-district        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "Mailing  District            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "Mailing Province             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "Mailing Postcode             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "Policy no. to customer date  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "New policy no                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "Insurer Stamp Date           "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "Remark                       "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "Occupation code              "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' "Register NO.                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' "Status Policy                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' "Status Compulsory            "    '"' SKIP.
RUN proc_matchchktil. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
RUN proc_matchfiletil_txt.
For each  wdetail2 :
    DELETE  wdetail2.
END.
For each  wdetail :
    DELETE  wdetail.
END.
message "Export File  Complete"  view-as alert-box.

RELEASE sicuw.uwm100.
RELEASE sicuw.uwm130.
RELEASE sicuw.uwm301.
/*---------------------------------------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfiletil_new C-Win 
PROCEDURE proc_matchfiletil_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  ไฟล์ส่งตรีเพชร  A62-0422 12/09/2019 format new   
------------------------------------------------------------------------------*/
If  substr(fi_output2,length(fi_output2) - 3,4) <>  ".SLK"  Then
    fi_output2  =  Trim(fi_output2) + ".SLK"  .
ASSIGN nv_cnt   =  0
       nv_row   =  0 .
OUTPUT STREAM ns2 TO VALUE(fi_output2).
PUT STREAM ns2 "ID;PND" SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "Ins. Year type               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "Business type                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "TAS received by              "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "Ins company                  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "Insurance ref no.            "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "TPIS Contract No.            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "Title name                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "customer name                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "customer lastname            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Customer type                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Director Name                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "ID number                    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "House no.                    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Building                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "Village name/no.             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "Soi                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "Road                         "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "Sub-district                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "District                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "Province                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "Postcode                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "Brand                        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "Car model                    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "Insurance Code               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "Model Year                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "Usage Type                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "Colour                       "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "Car Weight (CC.)             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "Year                         "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "Engine No.                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "Chassis No.                  "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "Accessories (for CV)         "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "Accessories amount           "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "License No.                  "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "Registered Car License       "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "Campaign                     "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "Type of work                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "Garage Repair                "    '"' SKIP.  /* a62-0422*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "Model Description            "    '"' SKIP.  /* a62-0422*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "Insurance amount             "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "Insurance Date ( Voluntary ) "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "Expiry Date ( Voluntary)     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "Last Policy No. (Voluntary)  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "Insurance Type               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "Net premium (Voluntary)      "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "Gross premium (Voluntary)    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "Stamp                        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "VAT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "WHT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "Compulsory No.               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "Insurance Date ( Compulsory )"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "Expiry Date ( Compulsory)    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "Net premium (Compulsory)     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "Gross premium (Compulsory)   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "Stamp                        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "VAT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "WHT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "Dealer                       "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "Showroom                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' "Payment Type                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "Beneficiery                  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "Mailing House no.            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "Mailing  Building            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "Mailing  Village name/no.    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "Mailing Soi                  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "Mailing  Road                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "Mailing  Sub-district        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "Mailing  District            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "Mailing Province             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "Mailing Postcode             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "Policy no. to customer date  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "New policy no                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "Insurer Stamp Date           "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' "Remark                       "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' "Occupation code              "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' "Register NO.                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"' "Status Policy                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' "Status Compulsory            "    '"' SKIP.
RUN proc_matchktil_new. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
RUN proc_filetil_txt.
For each  wdetail2 :
    DELETE  wdetail2.
END.
For each  wdetail :
    DELETE  wdetail.
END.
message "Export File  Complete"  view-as alert-box.

RELEASE sicuw.uwm100.
RELEASE sicuw.uwm130.
RELEASE sicuw.uwm301.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfiletil_txt C-Win 
PROCEDURE proc_matchfiletil_txt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_output1,length(fi_output1) - 3,4) <>  ".CSV"  Then
    fi_output1  =  Trim(fi_output1) + ".CSV"  .
OUTPUT TO VALUE(fi_output1).
EXPORT DELIMITER ","
"Ins. Year type "                       /*1  */            
"Business type"                         /*2  */   
"TAS received by"                       /*3  */     
"Ins company"                           /*4  */ 
"Insurance ref no."                     /*5  */       
"TPIS Contract No."                     /*6  */       
"Title name"                            /*7  */
"customer name"                         /*8  */   
"customer lastname"                     /*9  */       
"Customer type"                         /*10 */
"Director Name"                         /*11 */
"ID number"                             /*12 */
"House no."                             /*13 */
"Building"                              /*14 */
"Village name/no."                      /*15 */
"Soi "                                  /*16 */
"Road"                                  /*17 */ 
"Sub-district"                          /*18 */
"District"                              /*19 */
"Province"                              /*20 */
"Postcode"                              /*21 */
"Brand "                                /*22 */
"Car model"                             /*23 */
"Insurance Code"                        /*24 */
"Model Year "                           /*25 */
"Usage Type "                           /*26 */
"Colour"                                /*27 */
"Car Weight "                           /*28 */
"Year"                                  /*29 */
"Engine No. "                           /*30 */
"Chassis No."                           /*31 */
"Accessories (for CV)"                  /*32 */
"Accessories amount"                    /*33 */                       
"License No."                           /*34 */    
"Registered Car License"                /*35 */    
"Campaign"                              /*36 */
"Type of work"                          /*37 */
"Insurance amount "                     /*38 */
"Insurance Date ( Voluntary )"          /*39 */                                      
"Expiry Date ( Voluntary) "             /*40 */                         
"Last Policy No. (Voluntary) "          /*41 */          
"Insurance Type "                       /*42 */
"Net premium (Voluntary)"               /*43 */     
"Gross premium (Voluntary)"             /*44 */                          
"Stamp"                                 /*45 */
"VAT"                                   /*46 */
"WHT"                                   /*47 */
"Compulsory No."                        /*48 */              
"Insurance Date ( Compulsory )"         /*49 */           
"Expiry Date ( Compulsory)"             /*50 */       
"Net premium (Compulsory)"              /*51 */      
"Gross premium (Compulsory)"            /*52 */        
"Stamp"                                 /*53 */
"VAT"                                   /*54 */
"WHT"                                   /*55 */
"Dealer"                                /*56 */
"Showroom"                              /*57 */
"Payment Type"                          /*58 */
"Beneficiery"                           /*59 */
"Mailing House no."                     /*60 */
"Mailing Building"                      /*61 */
"Mailing Village name/no."              /*62 */
"Mailing Soi"                           /*63 */
"Mailing Road"                          /*64 */
"Mailing Sub-district"                  /*65 */
"Mailing District"                      /*66 */
"Mailing Province"                      /*67 */
"Mailing Postcode"                      /*68 */
"Policy no. to customer date"           /*69 */
"New policy no"                         /*70 */
"Insurer Stamp Date"                    /*71 */
"Remark"                                /*72 */
"Occupation code".                      /*73 */
FOR EACH wdetail2 NO-LOCK.             
EXPORT DELIMITER ","
trim(Wdetail2.ins_ytyp)                                                                                 /*1  */
trim(wdetail2.bus_typ)                                                                                  /*2  */
trim(wdetail2.TASreceived)                                                                              /*3  */
trim(wdetail2.InsCompany)                                                                               /*4  */
trim(wdetail2.Insurancerefno)                                                                           /*5  */
trim(wdetail2.tpis_no)                                                                                  /*6  */
trim(wdetail2.ntitle)                                                                                   /*7  */
TRIM(wdetail2.insnam)                                                                                   /*8  */
TRIM(wdetail2.NAME2)                                                                                    /*9  */
trim(wdetail2.cust_type)                  /*จากไฟล์ */                                                  /*10 */
trim(wdetail2.nDirec)                                                                                   /*11 */
trim(wdetail2.ICNO)                                                                                     /*12 */
trim(wdetail2.address)                                                                                  /*13 */
trim(wdetail2.build)                                                                                    /*14 */
trim(wdetail2.mu)                                                                                       /*15 */
trim(wdetail2.soi)                                                                                      /*16 */
trim(wdetail2.road)                                                                                     /*17 */
trim(wdetail2.tambon)                                                                                   /*18 */
trim(wdetail2.amper)                                                                                    /*19 */
trim(wdetail2.country)                                                                                  /*20 */
trim(wdetail2.post)                                                                                     /*21 */
trim(wdetail2.brand)                      /*จากไฟล์*/                                                   /*22 */
trim(wdetail2.model)                      /*จากไฟล์*/                                                   /*23 */
trim(wdetail2.class)                                                                                    /*24 */
trim(wdetail2.md_year)                    /*จากไฟล์*/                                                   /*25 */
trim(wdetail2.Usage)                      /*จากไฟล์*/                                                   /*26 */
trim(wdetail2.coulor)                     /*จากไฟล์*/                                                   /*27 */
trim(wdetail2.cc)                         /*จากไฟล์*/                                                   /*28 */
trim(wdetail2.regis_year)                 /*จากไฟล์*/                                                   /*29 */
trim(wdetail2.engno)                                                                                    /*30 */
trim(wdetail2.chasno)                                                                                   /*31 */
trim(Wdetail2.Acc_CV)                    /*จากไฟล์*/                                                    /*32 */
trim(Wdetail2.Acc_amount) /*จากไฟล์*/                                                                   /*33 */
trim(wdetail2.License)                                                                                  /*34 */
trim(wdetail2.regis_CL)                                                                                 /*35 */
trim(wdetail2.campaign)                                                                                 /*36 */
trim(wdetail2.typ_work)                                                                                 /*37 */
TRIM(wdetail2.si)                                                                                       /*38 */
IF wdetail2.pol_comm_date <> "" THEN string(date(wdetail2.pol_comm_date),"99/99/9999") ELSE ""          /*39 */
IF wdetail2.pol_exp_date <> "" THEN string(date(wdetail2.pol_exp_date),"99/99/9999") ELSE ""            /*40 */
trim(wdetail2.LAST_pol)                                                                                 /*41 */
trim(wdetail2.cover)                                                                                    /*42 */
trim(wdetail2.pol_netprem)                                                                              /*43 */
trim(wdetail2.pol_gprem)                                                                                /*44 */
trim(wdetail2.pol_stamp)                                                                                /*45 */
trim(wdetail2.pol_vat)                                                                                  /*46 */
trim(wdetail2.pol_wht)               /*จากไฟล์ */                                                       /*47 */
trim(wdetail2.com_no)                                                                                   /*48 */
if wdetail2.com_comm_date <> "" THEN string(date(wdetail2.com_comm_date),"99/99/9999") ELSE ""          /*49 */
if wdetail2.com_exp_date <> "" THEN string(date(wdetail2.com_exp_date),"99/99/9999")  ELSE ""           /*50 */
trim(wdetail2.com_netprem)                                                                              /*51 */
trim(wdetail2.com_gprem)                                                                                /*52 */
trim(wdetail2.com_stamp)                                                                                /*53 */
trim(wdetail2.com_vat)               /*จากไฟล์*/                                                        /*54 */
trim(wdetail2.com_wht)               /*จากไฟล์*/                                                        /*55 */
trim(wdetail2.deler)                 /*จากไฟล์*/                                                        /*56 */
trim(wdetail2.showroom)              /*จากไฟล์*/                                                        /*57 */
trim(wdetail2.typepay)               /*จากไฟล์*/                                                        /*58 */
trim(wdetail2.financename)           /*จากไฟล์*/                                                        /*59 */
trim(wdetail2.mail_hno)              /*จากไฟล์*/                                                        /*60 */
trim(wdetail2.mail_build)            /*จากไฟล์*/                                                        /*61 */
trim(wdetail2.mail_mu)               /*จากไฟล์*/                                                        /*62 */
trim(wdetail2.mail_soi)              /*จากไฟล์*/                                                        /*63 */
trim(wdetail2.mail_road)             /*จากไฟล์*/                                                        /*64 */
trim(wdetail2.mail_tambon)           /*จากไฟล์*/                                                        /*65 */
trim(wdetail2.mail_amper)            /*จากไฟล์*/                                                        /*66 */
trim(wdetail2.mail_country)          /*จากไฟล์*/                                                        /*67 */
trim(wdetail2.mail_post)                                                                                /*68 */
trim(wdetail2.send_date)                                                                                /*69 */
trim(wdetail2.policy_no)                                                                                /*70 */
trim(wdetail2.send_data)                                                                                /*71 */
trim(wdetail2.REMARK1)                                                                                  /*72 */
trim(wdetail2.occup).                                                                                   /*73 */
END.                                                                                                   
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchktil_new C-Win 
PROCEDURE proc_matchktil_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: ไฟล์ส่งตรีเพชร  A62-0422 date 12/09/2019 format new    
------------------------------------------------------------------------------*/
DEF VAR n_status AS LOGICAL.
DEF VAR n_stpol  AS CHAR.
DEF VAR n_stcom  AS CHAR.
DEF VAR n_rencnt AS INT.
DEF VAR n_endcnt AS INT.
DEF VAR n_length AS INT.
DEF VAR n_policyuwm100 AS CHAR FORMAT "x(20)" INIT "".
for each wdetail2.
   IF wdetail2.ins_ytyp = "" THEN DELETE wdetail2.
   ELSE DO:
      ASSIGN nv_cnt   =  nv_cnt  + 1                      
              nv_row  =  nv_row  + 1
              n_stpol  = ""
              n_stcom  = ""
              n_length = 0
              wdetail2.policy_no   = ""  
              wdetail2.delerco     = ""
              wdetail2.financecd   = "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
       FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail2.tpis_no) NO-LOCK.
          IF      sicuw.uwm100.poltyp <> "V70"  THEN NEXT.
          ELSE IF sicuw.uwm100.expdat <= TODAY  THEN DO:
              ASSIGN wdetail2.policy         = ""  
                      n_stpol                = ""     
                      wdetail2.pol_comm_date = ""     
                      wdetail2.pol_exp_date  = "".
          END.
          ELSE DO:
                 ASSIGN 
                    wdetail2.policy_no     = sicuw.uwm100.policy
                    /*wdetail2.occup         = sicuw.uwm100.occupn*/ 
                    wdetail2.pol_comm_date = string(sicuw.uwm100.comdat) 
                    wdetail2.pol_exp_date  = string(sicuw.uwm100.expdat) 
                    wdetail2.ntitle        = sicuw.uwm100.ntitle                                                 
                    wdetail2.ICNO          = sicuw.uwm100.anam2
                    wdetail2.pol_netprem   = STRING(sicuw.uwm100.prem_t)
                    wdetail2.pol_gprem     = string(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t)
                    wdetail2.pol_stamp     = string(sicuw.uwm100.rstp_t)    
                    wdetail2.pol_vat       = string(sicuw.uwm100.rtax_t)
                    wdetail2.pol_wht       = STRING((DECI(wdetail2.pol_netprem) + DECI(wdetail2.pol_stamp)) * 0.01 )
                    n_status               = sicuw.uwm100.releas
                    n_stpol                = STRING(n_status).
      
                 IF wdetail2.cust_type = "J" THEN DO:
                     IF INDEX(uwm100.name1,"จำกัด") <> 0 THEN DO:
                         ASSIGN wdetail2.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"จำกัด") + 5 )
                                wdetail2.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail2.NAME2   = "".
                     END.
                     ELSE IF INDEX(uwm100.name1,"มหาชน") <> 0 THEN
                         ASSIGN wdetail2.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"มหาชน") + 5 )
                                wdetail2.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail2.NAME2   = "".
                  END.
                  ELSE DO:
                      IF INDEX(sicuw.uwm100.ntitle,"มูลนิธิ") = 0 THEN DO:
                          ASSIGN  wdetail2.insnam = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1," ")) 
                                  n_length        = LENGTH(uwm100.NAME1) - LENGTH(wdetail2.insnam)
                                  wdetail2.NAME2  = SUBSTR(uwm100.name1,INDEX(uwm100.name1," "),n_length + 1).
                      END.
                      ELSE DO:
                          ASSIGN wdetail2.insnam = sicuw.uwm100.name1
                                 wdetail2.insnam = TRIM(wdetail2.insnam) + TRIM(sicuw.uwm100.name2)
                                 wdetail2.NAME2  = "".
                      END.
                  END.
                FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                    sicuw.uwm301.policy = sicuw.uwm100.policy AND 
                    sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                    sicuw.uwm301.endcnt = sicuw.uwm100.endcnt AND 
                    sicuw.uwm301.riskno = 1                   AND
                    sicuw.uwm301.itemno = 1                   NO-LOCK NO-ERROR.
      
                 IF AVAIL sicuw.uwm301 THEN DO:
                   ASSIGN wdetail2.License     = sicuw.uwm301.vehreg
                          wdetail2.engno       = sicuw.uwm301.eng_no
                          wdetail2.chasno      = sicuw.uwm301.cha_no.
                           
                          FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                              sicuw.uwm130.policy = sicuw.uwm100.policy AND 
                              sicuw.uwm130.rencnt = sicuw.uwm100.rencnt AND
                              sicuw.uwm130.endcnt = sicuw.uwm100.endcnt AND 
                              sicuw.uwm130.riskno = 1                   AND
                              sicuw.uwm130.itemno = 1                   NO-LOCK NO-ERROR.
                          IF AVAIL sicuw.uwm130 THEN 
                             ASSIGN wdetail2.si   = IF sicuw.uwm301.covcod = "1" THEN STRING(sicuw.uwm130.uom6_v) ELSE STRING(sicuw.uwm130.uom7_v).
                          ELSE
                             ASSIGN wdetail2.si   = "".
                 END.
                 ELSE DO:
                     ASSIGN wdetail2.License   = ""
                          wdetail2.engno       = ""
                          wdetail2.chasno      = "".
                 END.
                 RUN proc_exportNote.
           END.
      END.
      IF wdetail2.com_no <> "" THEN DO:
         FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol =  trim(wdetail2.tpis_no) NO-LOCK.
             IF sicuw.uwm100.poltyp <> "V72"  THEN NEXT.
             ELSE IF sicuw.uwm100.expdat <= TODAY THEN DO:
                 ASSIGN wdetail2.com_no    = "" 
                   n_stcom                 = ""           
                   wdetail2.com_comm_date  = ""   
                   wdetail2.com_exp_date   = "".
            END.
            ELSE DO:
              ASSIGN 
                  wdetail2.com_no        = sicuw.uwm100.policy 
                  wdetail2.com_comm_date = STRING(sicuw.uwm100.comdat)
                  wdetail2.com_exp_date  = STRING(sicuw.uwm100.expdat)
                  wdetail2.ntitle        = sicuw.uwm100.ntitle                                                          
                  wdetail2.ICNO          = sicuw.uwm100.anam2                                                           
                  wdetail2.com_netprem   = STRING(sicuw.uwm100.prem_t)                                                  
                  wdetail2.com_gprem     = string(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t)      
                  wdetail2.com_stamp     = string(sicuw.uwm100.rstp_t)                                                  
                  wdetail2.com_vat       = string(sicuw.uwm100.rtax_t)
                  wdetail2.com_wht       = STRING((DECI(wdetail2.com_netprem) + DECI(wdetail2.com_stamp)) * 0.01 ) 
                  n_status               = sicuw.uwm100.releas
                  n_stcom                = STRING(n_status).
             
                 IF wdetail2.cust_type = "J" THEN DO:
                     IF INDEX(uwm100.name1,"จำกัด") <> 0 THEN DO:
                         ASSIGN wdetail2.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"จำกัด") + 5 )
                                wdetail2.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail2.NAME2   = "".
                     END.
                     ELSE IF INDEX(uwm100.name1,"มหาชน") <> 0 THEN
                         ASSIGN wdetail2.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"จำกัด") + 5 )
                                wdetail2.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail2.NAME2   = "".
                 END.
                 ELSE DO:
                    IF INDEX(sicuw.uwm100.ntitle,"มูลนิธิ") = 0 THEN DO:
                        ASSIGN  wdetail2.insnam = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1," ")) 
                                n_length        = LENGTH(uwm100.NAME1) - LENGTH(wdetail2.insnam)
                                wdetail2.NAME2  = SUBSTR(uwm100.name1,INDEX(uwm100.name1," "),n_length + 1).
                    END.
                    ELSE DO:
                        ASSIGN wdetail2.insnam = sicuw.uwm100.name1
                               wdetail2.insnam = TRIM(wdetail2.insnam) + TRIM(sicuw.uwm100.name2)
                               wdetail2.NAME2  = "".
                    END.
                 END.
                 
                 FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                            sicuw.uwm301.policy = sicuw.uwm100.policy AND 
                            sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                            sicuw.uwm301.endcnt = sicuw.uwm100.endcnt AND 
                            sicuw.uwm301.riskno = 1                   AND 
                            sicuw.uwm301.itemno = 1                   NO-LOCK NO-ERROR.
             
                     IF AVAIL sicuw.uwm301 THEN
                       ASSIGN wdetail2.License = sicuw.uwm301.vehreg
                              wdetail2.engno   = sicuw.uwm301.eng_no  
                              wdetail2.chasno  = sicuw.uwm301.cha_no.
                     ELSE
                       ASSIGN wdetail2.License  = ""
                              wdetail2.engno    = ""
                              wdetail2.chasno   = "".
                 RUN proc_ExportNote.
             END.
        END.
       END.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   Wdetail2.ins_ytyp             '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail2.bus_typ              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail2.TASreceived          '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail2.InsCompany           '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail2.Insurancerefno       '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail2.tpis_no              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail2.ntitle               '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   TRIM(wdetail2.insnam) FORMAT "X(50)"  '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   TRIM(wdetail2.NAME2)  FORMAT "X(50)"  '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetail2.cust_type            '"' SKIP.         /*จากไฟล์ */        
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetail2.nDirec               '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetail2.ICNO                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetail2.address              '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   wdetail2.build                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   wdetail2.mu                   '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   wdetail2.soi                  '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   wdetail2.road                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   wdetail2.tambon               '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   wdetail2.amper                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   wdetail2.country              '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   wdetail2.post                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   wdetail2.brand                '"' SKIP.         /*จากไฟล์*/   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   wdetail2.model                '"' SKIP.         /*จากไฟล์*/     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   wdetail2.class                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   wdetail2.md_year              '"' SKIP.         /*จากไฟล์*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   wdetail2.Usage                '"' SKIP.         /*จากไฟล์*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   wdetail2.coulor               '"' SKIP.         /*จากไฟล์*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   wdetail2.cc                   '"' SKIP.         /*จากไฟล์*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   wdetail2.regis_year           '"' SKIP.         /*จากไฟล์*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   wdetail2.engno                '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   wdetail2.chasno               '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   Wdetail2.Acc_CV  FORMAT "x(60)"   '"' SKIP.                                              /*จากไฟล์*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   IF Wdetail2.Acc_amount = "" THEN "" ELSE STRING(DECI(Wdetail2.Acc_amount)) '"' SKIP. /*จากไฟล์*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'   wdetail2.License  FORMAT "x(20)"     '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'   wdetail2.regis_CL             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'   wdetail2.campaign             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'   wdetail2.typ_work             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'   wdetail2.garage               '"' SKIP.  /*A62-0422*/   /*จากไฟล์ */ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'   wdetail2.desmodel             '"' SKIP.  /*A62-0422*/   /*จากไฟล์ */ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'   DECI(wdetail2.si) FORMAT ">>,>>>,>>9.99"               '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'   DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'   DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'   wdetail2.LAST_pol             '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'   wdetail2.cover                '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'   DECI(wdetail2.pol_netprem)    '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'   DECI(wdetail2.pol_gprem)      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'   DECI(wdetail2.pol_stamp)      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'   DECI(wdetail2.pol_vat)        '"' SKIP.           
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'   DECI(wdetail2.pol_wht)        '"' SKIP.          /*จากไฟล์ */
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'   wdetail2.com_no               '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'   DATE(wdetail2.com_comm_date) FORMAT "99/99/9999"   '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'   DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999"   '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'   DECI(wdetail2.com_netprem)    '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'   DECI(wdetail2.com_gprem)      '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'   DECI(wdetail2.com_stamp)      '"' SKIP.     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'   DECI(wdetail2.com_vat)        '"' SKIP.          /*จากไฟล์*/     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'   DECI(wdetail2.com_wht)        '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'   wdetail2.deler                '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'   wdetail2.showroom             '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'   wdetail2.typepay              '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"'   wdetail2.financename          '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"'   wdetail2.mail_hno             '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"'   wdetail2.mail_build           '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"'   wdetail2.mail_mu              '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"'   wdetail2.mail_soi             '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"'   wdetail2.mail_road            '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"'   wdetail2.mail_tambon          '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"'   wdetail2.mail_amper           '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"'   wdetail2.mail_country         '"' SKIP.          /*จากไฟล์*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"'   wdetail2.mail_post            '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"'   wdetail2.send_date            '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"'   wdetail2.policy_no            '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"'   wdetail2.send_data            '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"'   wdetail2.REMARK1              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"'   wdetail2.occup                '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"'   wdetail2.regis_no             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"'   n_stpol                       '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"'   n_stcom                       '"' SKIP.
   END.
END. 
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

    IF R-INDEX(np_name1,".") <> 0 THEN np_name1 = SUBSTR(np_name1,R-INDEX(np_name1,".")). /*A66-0084*/

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_messagedata C-Win 
PROCEDURE proc_messagedata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO "d:\data_load2.csv"  APPEND.
EXPORT DELIMITER "|"

  sic_bran.uwm100.policy                
  nv_campcd                          
  sic_bran.uwm100.rencnt          
  sic_bran.uwm100.endcnt          
  0           
  nv_riskno                
  nv_itemno                
  nv_batchyr               
  nv_batchno               
  nv_batcnt                
  nv_polday                
  nv_usrid                 
  "wgwloadem"                
  3         
  nv_tariff   
  nv_covcod   
  nv_class    
  nv_vehuse   
  nv_cstflg   
  nv_engcst   
  nv_drivno   
  nv_driage1  
  nv_driage2  
  nv_level    
  nv_levper   
  nv_yrmanu   
  nv_totsi    
  nv_totfi    
  nv_vehgrp    
  nv_access    
  nv_supe      
  nv_tpbi1si   
  nv_tpbi2si   
  nv_tppdsi    
  nv_411si        
  nv_412si        
  nv_413si        
  nv_414si        
  nv_42si         
  nv_43si         
  nv_41prmt   
  nv_412prmt      
  nv_413prmt      
  nv_414prmt      
  nv_42prmt       
  nv_43prmt       
  nv_seat41       
  nv_dedod
  nv_addod
  nv_dedpd
  nv_dodamt   
  nv_dadamt   
  nv_dpdamt   
  nv_pdprem
  nv_gapprem
  nv_flagprm
  nv_effdat
  nv_adjpaprm  
  YES        
  nv_flgpol                   
  nv_flgclm                    
  10                                                                                                             
  cv_lncbper                                                                                                                        
  35                                                                 
  0                                                                 
  0                                                                  
  NO                                                                
  nv_ncbyrs                                                                                                                                                                  
  nv_ncbp
  nv_fletp
  nv_dspcp
  nv_dstfp
  nv_clmp
  nv_pdprm0
  nv_ncbamt   
  nv_fletamt 
  nv_dspcamt  
  nv_dstfamt 
  nv_clmamt  
  nv_baseprm
  nv_baseprm3
  nv_mainprm 
  nv_ratatt
  nv_siatt 
  nv_netatt
  nv_fltatt
  nv_ncbatt
  nv_dscatt
  nv_attgap  
  nv_atfltgap
  nv_atncbgap
  nv_atdscgap
  nv_packatt 
  nv_chgflg  
  nv_chgrate    
  nv_chgsi      
  nv_chgpdprm   
  nv_chggapprm  
  nv_battflg    
  nv_battrate   
  nv_battsi     
  nv_battprice  
  nv_battpdprm  
  nv_battgapprm 
  nv_battyr     
  nv_battper    
  nv_flag    
  nv_garage  
  nv_31rate  
  nv_31prmt  
  nv_compprm 
  nv_uom9_v  
  nv_fcctv   
  nv_flgsht  
  nv_evflg   
  nv_uom1_c
  nv_uom2_c
  nv_uom5_c
  nv_uom6_c
  nv_uom7_c
  nv_gapprm
  nv_pdprm 
  nv_status
  nv_message SKIP.



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
DEF VAR n_stkk      AS CHAR FORMAT "x(15)" INIT "".
DEF VAR chk_sticker AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_nameno    AS INTE INIT 0 .
DEF VAR n_titlename AS CHAR FORMAT "x(10)" INIT "".
IF wdetail.policy <> "" THEN DO:
    /*kridtiya i. A54-0026*/
    IF wdetail.poltyp = "v70" THEN
        ASSIGN n_stkk = wdetail.stk
        wdetail.stk = "".
    /*kridtiya i. A54-0026*/
    IF wdetail.stk  <>  ""  THEN DO: 
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            /*MESSAGE "Sticker Number"  wdetail.stk "ใช้ Generate ไม่ได้ เนื่องจาก Modulo Error"  VIEW-AS ALERT-BOX.*/
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        /*FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE                      /*A56-0211*/
             sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.*/ /*A56-0211*/
       FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE                        /*A56-0211*/
            sicuw.uwm100.cedpol  = wdetail.cedpol  AND
            sicuw.uwm100.poltyp  = wdetail.poltyp  NO-LOCK NO-ERROR NO-WAIT.    /*A56-0211*/
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
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
            /*MESSAGE "หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้วโดยเลขที่กรมธรรม์ ." stat.Detaitem.policy VIEW-AS ALERT-BOX.*/
            ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END. /*wdetail.stk  <>  ""*/
    ELSE DO: /*sticker = ""*/ 
        /*FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE                      /*A56-0211*/ 
            sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.*/            /*A56-0211*/ 
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE                        /*A56-0211*/
            sicuw.uwm100.cedpol  = wdetail.cedpol  AND
            sicuw.uwm100.poltyp  = wdetail.poltyp  NO-LOCK NO-ERROR NO-WAIT.   /*A56-0211*/
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES THEN 
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
        END. /*policy <> "" & stk = ""*/                 
        ELSE RUN proc_create100.  /*add A52-0172*/
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
            ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        /*FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE                      /*A56-0211*/ 
            sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.*/            /*A56-0211*/ 
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE                        /*A56-0211*/
            sicuw.uwm100.cedpol  = wdetail.cedpol  AND
            sicuw.uwm100.poltyp  = wdetail.poltyp  NO-LOCK NO-ERROR NO-WAIT.   /*A56-0211*/
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
                ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.   /*add kridtiya i..*/
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            /*MESSAGE "หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้วโดยเลขที่กรมธรรม์ ." stat.Detaitem.policy VIEW-AS ALERT-BOX.*/
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
/*add kridtiya i. A54-0200 */
ASSIGN n_titlename = "" .
/*FIND FIRST brstat.msgcode WHERE 
    brstat.msgcode.compno = "999" AND
    index(substr(wdetail.insnam,1,20),brstat.msgcode.MsgDesc) > 0    NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL brstat.msgcode THEN DO: 
    ASSIGN wdetail.tiname  =  trim(brstat.msgcode.branch)
        wdetail.insnam     =  trim(SUBSTR(wdetail.insnam,LENGTH(brstat.msgcode.MsgDesc) + 1)).
END.
ELSE wdetail.tiname = "คุณ".*/
/*end...add kridtiya i. A54-0200 */
/*comment by kridtiya i.A54-0200 
IF R-INDEX(wdetail.insnam,".") <> 0 THEN 
    wdetail.insnam = SUBSTR(wdetail.insnam,R-INDEX(wdetail.insnam,".")).
end...comment by kridtiya i.A54-0200 */
/*IF ra_compatyp = 2 THEN wdetail.inscod = fi_vatcode.  /* kridtiya i. A54-0364 */*//*A56-0245*/
/*IF fi_name2 = ""  THEN ASSIGN wdetail.inscod = "" .    /*A56-0245*/*/           /*A57-0260*/
IF (wdetail.name02 = "") AND (wdetail.name2 = "")  THEN ASSIGN wdetail.inscod = "" .    /*A57-0260*/
RUN proc_insnam .
RUN proc_insnam2 . /*Add by Kridtiya i. A63-0472*/
/*RUN proc_policyname4.  /*A63-0241*/*/
IF nv_insref = ""  THEN DO:
  ASSIGN   wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| รหัสลูกค้าเป็นค่าว่าง ตรวจสอบรันนิ่งโค้ดลูกค้า สาขา " + wdetail.branch 
    wdetail.warning = wdetail.WARNING + "| รหัสลูกค้าเป็นค่าว่าง ".
END.
DO TRANSACTION:
   ASSIGN
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = wdetail.poltyp
      sic_bran.uwm100.insref = nv_insref
      sic_bran.uwm100.opnpol = ""
      sic_bran.uwm100.anam2  = wdetail.Icno       /* ICNO  Cover Note A51-0071 Amparat */
      sic_bran.uwm100.ntitle = wdetail.tiname     /*A54-0200*/ /*"คุณ"   */       
      /*sic_bran.uwm100.name1  = TRIM(wdetail.insnam)*/  /*A58-0489*/
      /*sic_bran.uwm100.name1  = IF wdetail.nDirec <> " "  THEN TRIM(wdetail.insnam)  + " (" + wdetail.nDirec + ")" ELSE TRIM(wdetail.insnam) /*A58-0489*/*//*A66-0084*/
      sic_bran.uwm100.name1  = trim(TRIM(wdetail.firstName) + " " + TRIM(wdetail.lastName)) /*A66-0084*/
      /*sic_bran.uwm100.name2  = "และ/หรือ บริษัท ไทยออโต้เซลส์ จำกัด" *//*comment by kridtiya i. A53-0156*/
      /*sic_bran.uwm100.name2  = "และ/หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด" /*Add by kridtiya i. A53-0156*/*//*Kridtiya i. A54-0364*/
      /*sic_bran.uwm100.name2  = IF wdetail.name02 = " " THEN wdetail.name2  ELSE trim(wdetail.name02)   /*Kridtiya i. A54-0364*/*/ /*A66-0084*/
      /*sic_bran.uwm100.name3  = "" */ /*A66-0084*/
      sic_bran.uwm100.name2  = IF wdetail.nDirec <> "" THEN "(" + wdetail.nDirec + ")" ELSE IF wdetail.name02 <> "" THEN wdetail.name02  ELSE IF trim(wdetail.name2) <> "" THEN  trim(wdetail.name2) ELSE "" /*A66-0084*/
      sic_bran.uwm100.name3  = IF wdetail.nDirec <> "" AND wdetail.name02 <> "" THEN wdetail.name02 ELSE IF trim(wdetail.name2) <> "" AND sic_bran.uwm100.name2 <> trim(wdetail.name2) THEN  wdetail.name2 ELSE "" /*A66-0084*/                
      sic_bran.uwm100.addr1  = wdetail.iadd1      
      sic_bran.uwm100.addr2  = wdetail.iadd2     
      sic_bran.uwm100.addr3  = wdetail.iadd3     
      sic_bran.uwm100.addr4  = wdetail.iadd4  
      sic_bran.uwm100.postcd  =  "" 
      sic_bran.uwm100.undyr  = String(Year(today),"9999")   /*   nv_undyr  */
      sic_bran.uwm100.branch = trim(wdetail.branch)         /* nv_branch   */                        
      sic_bran.uwm100.dept   = nv_dept                      
      sic_bran.uwm100.usrid  = USERID(LDBNAME(1))           
      sic_bran.uwm100.fstdat = DATE(wdetail.comdat)         /*TODAY*/ /*TODAY */
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
      sic_bran.uwm100.prog   = "wgwtsgen"
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
      /*sic_bran.uwm100.acno1  = fi_producer /*  nv_acno1 */*/  /*A58-0489*/
      /*sic_bran.uwm100.agent  = fi_agent    /*nv_agent   */*/  /*A58-0489*/
      sic_bran.uwm100.acno1  = wdetail.producer                 /*A58-0489*/
      sic_bran.uwm100.agent  = wdetail.agent                    /*A58-0489*/
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
      sic_bran.uwm100.cr_1   =   wdetail.product      /*A63-0209 Product  */
      sic_bran.uwm100.opnpol =   wdetail.promotion    /*A63-0209 Promotion*/
      sic_bran.uwm100.cr_2  =  n_cr2
      sic_bran.uwm100.bchyr   = nv_batchyr          /*Batch Year */  
      sic_bran.uwm100.bchno   = nv_batchno          /*Batch No.  */  
      sic_bran.uwm100.bchcnt  = nv_batcnt           /*Batch Count*/  
      sic_bran.uwm100.prvpol  = wdetail.renpol      /*A52-0172*/
      sic_bran.uwm100.cedpol  = wdetail.cedpol
      sic_bran.uwm100.finint  = wdetail.finint
      sic_bran.uwm100.dealer  = wdetail.financecd    /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.occupn  = wdetail.occupn
      sic_bran.uwm100.fgtariff   = IF wdetail.poltyp = "V70" THEN YES ELSE NO
      sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)  /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)   /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.postcd     = trim(wdetail.postcd)     /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.icno       = trim(wdetail.icno)       /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)    /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)   /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)   /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)   /*Add by Kridtiya i. A63-0472*/
      /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*/  /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov) /*Add by Kridtiya i. A63-0472*/
      /*sic_bran.uwm100.bs_cd  = "MC16182".*/     /* Kridtiya i. A53-0183 .............*/
      /*sic_bran.uwm100.bs_cd   =  wdetail.inscod.   /*add Kridtiya i. A53-0183 ...vatcode*/ */        /*A57-0415*/  
      sic_bran.uwm100.bs_cd   = IF wdetail.vatcode <> "" THEN caps(trim(wdetail.vatcode)) ELSE  wdetail.inscod.  /*A57-0415*/   
      IF wdetail.renpol <> " " THEN DO:
          IF wdetail.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = "" sic_bran.uwm100.tranty  = "R".  
          ELSE 
              ASSIGN
                  sic_bran.uwm100.prvpol  = wdetail.renpol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                  sic_bran.uwm100.tranty  = "R".               /*Transaction Type (N/R/E/C/T)*/
      END.
      IF wdetail.pass = "Y" THEN sic_bran.uwm100.impflg  = YES.
      ELSE sic_bran.uwm100.impflg  = NO.
      IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN 
         sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
      IF wdetail.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
      ELSE sic_bran.uwm100.polsta = "IF".
      IF fi_loaddat <> ? THEN sic_bran.uwm100.trndat = fi_loaddat.
      ELSE sic_bran.uwm100.trndat = TODAY.
      sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
      nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                    ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.                    
END.  /*transaction*/
/*RUN proc_uwd100.*/ /*A58-0489*/
IF wdetail.poltyp = "v70" THEN RUN proc_uwd100.  /*A58-0489*/
/*kridtiya i. A54-0026*/
IF wdetail.poltyp = "v70" THEN DO:
    ASSIGN wdetail.stk =  n_stkk.
    /*RUN proc_uwd102.*/ /*A66-0252*/
END.  /*kridtiya i. A54-0026*/
RUN proc_uwd102. /*A66-0252*/
/*kridtiya i. A54-0026*/
IF wdetail.poltyp = "v70" THEN  wdetail.stk = ""   .
/*kridtiya i. A54-0026*/
/*kridtiya i. A52-0293.....*/
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
            ASSIGN sic_bran.uwm120.class  =  wdetail.subclass
                s_recid2     = RECID(sic_bran.uwm120).
        END.
        ELSE IF wdetail.poltyp = "v70"  THEN
        ASSIGN sic_bran.uwm120.class  = wdetail.prempa  + wdetail.subclass
            s_recid2     = RECID(sic_bran.uwm120).
    END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policyname4 C-Win 
PROCEDURE proc_policyname4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_year AS INTE.
IF wdetail.poltyp = "V70" AND wdetail.campens <> ""  THEN DO:
    ASSIGN 
        nv_year = ( YEAR(TODAY) - INTEGER(wdetail.caryear) ) + 1.

    FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
        stat.campaign_fil.camcod    = wdetail.campens                  AND  /* campaign triple pack */
        stat.campaign_fil.sclass    = trim(wdetail.subclass)       AND /* class 110 210 320 */
        stat.campaign_fil.covcod    = trim(wdetail.covcod)         AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
        /*campaign_fil.vehgrp    = trim(wdetail.cargrp)         AND /* group car */*/
        stat.campaign_fil.vehuse    = wdetail.vehuse               AND /* ประเภทการใช้รถ */
        stat.campaign_fil.garage    = wdetail.garage               AND /* การซ่อม */
        stat.campaign_fil.maxyea    = nv_year                      AND /* อายุรถ */                            
        stat.campaign_fil.simax     = deci(wdetail.si)             AND                                            
        stat.campaign_fil.netprm    = DECI(wdetail.volprem)        AND                                               
        /*campaign_fil.grossprm  =  DECI(wdetail.prem_r)      AND  */                                                              
        stat.campaign_fil.moddes    = trim(wdetail.model)    NO-LOCK NO-ERROR NO-WAIT.   /* Model */              
    IF AVAIL stat.campaign_fil THEN 
         ASSIGN nv_polmaster = stat.campaign_fil.polmst.
    ELSE ASSIGN nv_polmaster = "" .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_prmtxt C-Win 
PROCEDURE proc_prmtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Add by : A65-0156 */
IF wdetail.accdata =  "" THEN DO:
    IF wdetail.product = "P2.1" THEN DO:
        ASSIGN 
          SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "คอก(ไม่ใช่คอกซิ่ง), ตู้แห้ง, ตู้อลูมิเนียม,ตู้โครงหลังคาทึบ" 
          SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = " ,ตู้เย็น (ไม่คุ้มครองเครื่องทำความเย็น)"  
          SUBSTRING(sic_bran.uwm301.prmtxt,121,60) = " ราคาตามจริงไม่เกิน 100,000 บาท" .
    END.
    ELSE IF  wdetail.product = "P2.2" THEN DO:
        ASSIGN
            SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "คอก(ไม่ใช่คอกซิ่ง), ตู้แห้ง, ตู้อลูมิเนียม,ตู้โครงหลังคาทึบ"
            SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = ", ตู้เย็น (ไม่คุ้มครองเครื่องทำความเย็น)"
            SUBSTRING(sic_bran.uwm301.prmtxt,121,60) = " ราคาตามจริงตั้งแต่ 100,001 - 200,000 บาท" .
    END.
    ELSE IF wdetail.product = "P3" THEN DO:
        ASSIGN
            SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "ตู้เย็น" .
    END.
    ELSE IF wdetail.product = "P4" THEN DO:
        ASSIGN
            SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "คอกซิ่ง" .
    END.
    ELSE DO:
        ASSIGN 
          sic_bran.uwm301.prmtxt   =  "คุ้มครองอุปกรณ์ตกแต่งไม่เกิน 20,000 บาท" . 
    END.
END.
/* end : A65-0156 */
ELSE DO:
 nv_acc5 = "" . /*A65-0156*/

 IF wdetail.accdata   <> ""  THEN ASSIGN nv_acc5 = TRIM(wdetail.accdata) .
 /*IF wdetail.accamount <> ""  THEN ASSIGN nv_acc5 = trim(nv_acc5 + " " + "ราคารวมอุปกรณ์เสริม " + TRIM(wdetail.accamount) + " บาท") .*/ /*A66-0252*/
 IF wdetail.accamount <> "" AND wdetail.accamount <> "0"  THEN ASSIGN nv_acc5 = trim(nv_acc5 + " " + "คุ้มครองรวมในทุนประกันภัยไม่เกิน " + TRIM(wdetail.accamount) + " บาท") . /*A66-0252*/

 ASSIGN   nv_acc1 = ""
          nv_acc2 = ""
          nv_acc3 = ""
          nv_acc4 = "".
     
      loop_chk1:
      REPEAT:
          IF (INDEX(nv_acc5," ") <> 0 ) AND LENGTH(nv_acc1 + TRIM(SUBSTR(nv_acc5,1,INDEX(nv_acc5," ")))) <= 60 THEN 
              ASSIGN  nv_acc1 = trim(nv_acc1 + " " + TRIM(SUBSTR(nv_acc5,1,INDEX(nv_acc5," "))))
              nv_acc5 = TRIM(SUBSTR(nv_acc5,INDEX(nv_acc5," "))).
          ELSE LEAVE loop_chk1.
      END.
      /*IF nv_acc5 <> "" THEN*/ /*a65-0156*/
      loop_chk2:
      REPEAT:
          IF (INDEX(nv_acc5," ") <> 0 ) AND LENGTH(nv_acc2 + TRIM(SUBSTR(nv_acc5,1,INDEX(nv_acc5," ")))) <= 60 THEN 
              ASSIGN  nv_acc2 = trim(nv_acc2  + " " + TRIM(SUBSTR(nv_acc5,1,INDEX(nv_acc5," "))))
              nv_acc5 = TRIM(SUBSTR(nv_acc5,INDEX(nv_acc5," "))).
          ELSE LEAVE loop_chk2.
      END.
      loop_chk3:
      REPEAT:
          IF (INDEX(nv_acc5," ") <> 0 ) AND LENGTH(nv_acc3 + TRIM(SUBSTR(nv_acc5,1,INDEX(nv_acc5," ")))) <= 60 THEN 
              ASSIGN  nv_acc3 = trim(nv_acc3  + " " + TRIM(SUBSTR(nv_acc5,1,INDEX(nv_acc5," "))))
              nv_acc5 = TRIM(SUBSTR(nv_acc5,INDEX(nv_acc5," "))).
          ELSE LEAVE loop_chk3.
      END.
      loop_chk4:
      REPEAT:
          IF (INDEX(nv_acc5," ") <> 0 ) AND LENGTH(nv_acc4 + TRIM(SUBSTR(nv_acc5,1,INDEX(nv_acc5," ")))) <= 60 THEN 
              ASSIGN  nv_acc4 = trim(nv_acc4  + " " + TRIM(SUBSTR(nv_acc5,1,INDEX(nv_acc5," "))))
              nv_acc5 = TRIM(SUBSTR(nv_acc5,INDEX(nv_acc5," "))).
          ELSE LEAVE loop_chk4.
      END.
      
      IF (nv_acc4 <> "") AND (length(nv_acc4 + " " + nv_acc5 ) <= 60 ) THEN DO:
          ASSIGN nv_acc4 = nv_acc4  + " " + nv_acc5 
          nv_acc5 = "" .
      END.
      ELSE IF (nv_acc3 <> "") AND (length(nv_acc3 + " " + nv_acc5 ) <= 60 ) THEN DO:
          ASSIGN nv_acc3 = nv_acc3  + " " + nv_acc5
          nv_acc5 = "" .
      END.
      ELSE IF (nv_acc2 <> "") AND (length(nv_acc2 + " " + nv_acc5 ) <= 60 ) THEN DO:
          ASSIGN nv_acc2 = nv_acc2  + " " + nv_acc5
          nv_acc5 = "" .
      END.
      ELSE IF (nv_acc1 <> "") AND (length(nv_acc1 + " " + nv_acc5 ) <= 60 ) THEN DO:
          ASSIGN  nv_acc1 = nv_acc1  + " " + nv_acc5
          nv_acc5 = "" .
      END.
    /* comment by : A65-0156...
     ASSIGN 
      SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  nv_acc1 
      SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  nv_acc2 
      SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  nv_acc3 
      SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  nv_acc4  
      SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  nv_acc5. 
     .... end : A65-0156....*/
      IF trim(nv_acc1) = "" AND trim(nv_acc2) = "" AND trim(nv_acc3) = "" AND trim(nv_acc4) = "" THEN DO: 
          ASSIGN 
            SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = substr(nv_acc5,1,60)   
            SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = substr(nv_acc5,61,60)  
            SUBSTRING(sic_bran.uwm301.prmtxt,121,60) = substr(nv_acc5,121,60) 
            SUBSTRING(sic_bran.uwm301.prmtxt,181,60) = substr(nv_acc5,181,60) 
            SUBSTRING(sic_bran.uwm301.prmtxt,241,60) = substr(nv_acc5,241,60) .
      END.
      ELSE DO:
          ASSIGN 
            SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = nv_acc1
            SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = nv_acc2
            SUBSTRING(sic_bran.uwm301.prmtxt,121,60) = nv_acc3 
            SUBSTRING(sic_bran.uwm301.prmtxt,181,60) = nv_acc4 
            SUBSTRING(sic_bran.uwm301.prmtxt,241,60) = nv_acc5.
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

   FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE 
       sicuw.uwm100.policy = wdetail.renpol NO-LOCK NO-ERROR NO-WAIT.
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
       "redbook   "     ","    
            "branch   "      ","     
            "tiname   "      ","     
            "insnam   "      ","     
            "poltyp   "      ","     
            "policy   "      ","     
            /*"entdat   "      ","     
            "enttim   "      ","  */   
            "trandat  "      ","     
           /* "trantim  "      ","     
            "renpol   "      "," */    
            "comdat   "      ","     
            "expdat   "      ","     
            "compul   "      ","     
            "iadd1    "      ","     
            "iadd2    "      ","     
            "iadd3    "      ","     
            "iadd4    "      ","     
            "prempa   "      ","     
            "subclass "      ","     
            "brand    "      ","    
            "model    "      ","    
            "cc       "      ","     
            "weight   "      ","     
            "seat     "      ","     
            "body     "      ","     
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
           /* "drivnam  "      ","     
            "drivnam1 "      ","     
            "drivbir1 "      ","     
            "drivbir2 "      ","     
            "drivage1 "      ","  */   
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
           /* "inscod    "     ","    
            "premt     "     ","    
            
            "base      "     ","    
            "accdat    "     ","    
            "docno     "     ","    
            "ICNO      "     ","  */  
            "CoverNote "    
        SKIP.                                                   
    FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"  :           
        PUT STREAM ns1 
        wdetail.redbook      ","   
        wdetail.branch       ","
        wdetail.tiname       ","
        wdetail.insnam       "," 
        wdetail.poltyp       ","
        wdetail.policy       ","
        /*wdetail.entdat       ","
        wdetail.enttim       "," */
        wdetail.trandat      ","
        /*wdetail.trantim      ","*/
        /*wdetail.renpol       ","*/
        wdetail.comdat       "," 
        wdetail.expdat       ","
        wdetail.compul       ","
        wdetail.iadd1        ","
        wdetail.iadd2        ","
        wdetail.iadd3        ","
        wdetail.iadd4        ","  
        wdetail.prempa       "," 
        wdetail.subclass     ","  
        wdetail.brand        ","  
        wdetail.model        ","  
        wdetail.cc           ","  
        wdetail.weight       ","  
        wdetail.seat         ","  
        wdetail.body         ","        
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
        /*wdetail.drivnam      "," 
        wdetail.drivnam1     "," 
        wdetail.drivbir1     "," 
        wdetail.drivbir2     "," 
        wdetail.drivage1     "," */
        wdetail.cancel       ","
        wdetail.WARNING      ","
        wdetail.comment      ","
        wdetail.seat41       ","
        wdetail.pass         ","   
        wdetail.OK_GEN       ","   
        wdetail.comper       ","   
        wdetail.comacc       ","   
        wdetail.NO_411        ","   
        wdetail.NO_42        ","   
        wdetail.NO_43        ","   
        wdetail.tariff       ","   
        wdetail.baseprem     ","   
        wdetail.cargrp       ","   
        wdetail.producer     ","   
        wdetail.agent        ","   
        /*wdetail.inscod       ","   
        wdetail.premt        ","   
        wdetail.base         ","   
        wdetail.accdat       ","   
        wdetail.docno        ","   
        wdetail.ICNO         ","  */
        wdetail.CoverNote    
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
            "redbook  "     ","    
            "branch   "      ","     
            "tiname   "      ","     
            "insnam   "      ","     
            "poltyp   "      ","     
            "policy   "      ","     
            /*"entdat   "      ","     
            "enttim   "      ","  */   
            "trandat  "      ","     
           /* "trantim  "      ","     
            "renpol   "      "," */    
            "comdat   "      ","     
            "expdat   "      ","     
            "compul   "      ","     
            "iadd1    "      ","     
            "iadd2    "      ","     
            "iadd3    "      ","     
            "iadd4    "      ","     
            "prempa   "      ","     
            "subclass "      ","     
            "brand    "      ","    
            "model    "      ","    
            "cc       "      ","     
            "weight   "      ","     
            "seat     "      ","     
            "body     "      ","     
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
           /* "drivnam  "      ","     
            "drivnam1 "      ","     
            "drivbir1 "      ","     
            "drivbir2 "      ","     
            "drivage1 "      ","  */   
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
           /* "inscod    "     ","    
            "premt     "     ","    
            
            "base      "     ","    
            "accdat    "     ","    
            "docno     "     ","    
            "ICNO      "     ","  */  
            "CoverNote "    
            
        SKIP.        
    FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
        wdetail.redbook      ","   
        wdetail.branch       ","
        wdetail.tiname       ","
        wdetail.insnam       "," 
        wdetail.poltyp       ","
        wdetail.policy       ","
        /*wdetail.entdat       ","
        wdetail.enttim       "," */
        wdetail.trandat      ","
        /*wdetail.trantim      ","*/
        /*wdetail.renpol       ","*/
        wdetail.comdat       "," 
        wdetail.expdat       ","
        wdetail.compul       ","
        wdetail.iadd1        ","
        wdetail.iadd2        ","
        wdetail.iadd3        ","
        wdetail.iadd4        ","  
        wdetail.prempa       "," 
        wdetail.subclass     ","  
        wdetail.brand        ","  
        wdetail.model        ","  
        wdetail.cc           ","  
        wdetail.weight       ","  
        wdetail.seat         ","  
        wdetail.body         ","        
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
        /*wdetail.drivnam      "," 
        wdetail.drivnam1     "," 
        wdetail.drivbir1     "," 
        wdetail.drivbir2     "," 
        wdetail.drivage1     "," */
        wdetail.cancel       ","
        wdetail.WARNING      ","
        wdetail.comment      ","
        wdetail.seat41       ","
        wdetail.pass         ","   
        wdetail.OK_GEN       ","   
        wdetail.comper       ","   
        wdetail.comacc       ","   
        wdetail.NO_411        ","   
        wdetail.NO_42        ","   
        wdetail.NO_43        ","   
        wdetail.tariff       ","   
        wdetail.baseprem     ","   
        wdetail.cargrp       ","   
        wdetail.producer     ","   
        wdetail.agent        ","   
        /*wdetail.inscod       ","   
        wdetail.premt        ","   
        wdetail.base         ","   
        wdetail.accdat       ","   
        wdetail.docno        ","   
        wdetail.ICNO         ","  */
        wdetail.CoverNote    
    SKIP.  
  
  END.
OUTPUT STREAM ns2 CLOSE.                                                           
END. /*pass > 0*/

END PROCEDURE.

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
/*"IMPORT TEXT FILE TAS " SKIP*//*kridtiya i. A53-0156*/
"IMPORT TEXT FILE TPIS " SKIP    /*kridtiya i. A53-0156*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_stkfinddup C-Win 
PROCEDURE proc_stkfinddup :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*เช็ค เลขสติ๊กเกอร์ซ้ำในไฟล์เดียวกัน*/
/*comment by Kridtiya i. A54-0026....
DEF BUFFER bwdetail FOR wdetail.
FIND FIRST bwdetail WHERE bwdetail.stk = wdetail.stk AND
                          bwdetail.policy NE wdetail.policy NO-LOCK NO-ERROR NO-WAIT .
IF AVAIL bwdetail THEN
    ASSIGN 
        wdetail.comment = wdetail.comment + wdetail.stk + "| พบ เลขสติ๊กเกอร์ซ้ำในระบบ"
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N".
end....by Kridtiya i. A54-0026....   */
/*add by Kridtiya i. A54-0026....*/
FOR EACH wuppertxt2 WHERE  wuppertxt2.stk  = wdetail.stk    NO-LOCK .
    IF  wuppertxt2.policydup <> wdetail.policy  THEN 
        ASSIGN 
        wdetail.comment = wdetail.comment + wdetail.stk + "| พบ เลขสติ๊กเกอร์ซ้ำในระบบ"
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N".
    
END.
/*add by Kridtiya i. A54-0026....*/

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
  RELEASE sicsyac.xmm106 .
  
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
    /* nv_txt1 = "ขยายอุปกรณ์ตกแต่งเพิ่มเติมไม่เกิน 20,000.00 บาท"*/        /*A58-0489*/
    /*nv_txt2  = "วันที่แจ้งงาน SAFE : " + wdetail.revday */                /*A58-0489*/  
    nv_txt1  = ""                                                           /*A58-0489*/
    nv_txt2  = ""                                                           /*A58-0489*/
    /*nv_txt3  = ""*/                                                       /*A58-0489*/
    /*nv_txt4  = ""*/                                                       /*A58-0489*/
    nv_txt3 =   "ขยายอุปกรณ์ตกแต่งเพิ่มเติมไม่เกิน 20,000.00 บาท"           /*A58-0489*/
    nv_txt4 =   "วันที่แจ้งงาน SAFE : " + wdetail.revday                    /*A58-0489*/
    nv_txt5  = "" . 
FIND LAST wno30txt  WHERE wno30txt.policy  = wdetail.policy     NO-LOCK NO-ERROR NO-WAIT.
/*IF   AVAIL wno30txt THEN  ASSIGN  nv_txt3  =  wno30txt.text30   .  /*A57-0303*/*/ /*A58-0489*/
IF   AVAIL wno30txt THEN  ASSIGN  nv_txt5  =  wno30txt.text30   .                   /*A58-0489*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 C-Win 
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
       nv_line1 = 1.
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
/*Comment by A58-0489...............
DO WHILE nv_line1 <= 7:
    CREATE wuppertxt3.
    wuppertxt3.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt3.txt = "SAFE : " + wdetail.revday .
    IF nv_line1 = 2  THEN wuppertxt3.txt = wdetail.campens.
    IF nv_line1 = 3  THEN wuppertxt3.txt = IF substr(wdetail.stk,1,1) <> "0" THEN  "0" + wdetail.stk ELSE wdetail.stk  .
    IF nv_line1 = 4  THEN wuppertxt3.txt = IF wdetail.memotext = "" THEN  " " ELSE  wdetail.memotext .
    IF nv_line1 = 5  THEN wuppertxt3.txt = IF wdetail.name2 = "" THEN  ""  ELSE "ออกใบเสร็จใบกำกับในนามดิลเลอร์ : " + wdetail.name2.
    /*IF nv_line1 = 6  THEN wuppertxt3.txt = IF wdetail.n_telreq = "" THEN "" ELSE  "เบอร์โทรศัพสำหรับติดต่อกลับ " + TRIM(wdetail.n_telreq) . */  /* A57-0260 */
    IF nv_line1 = 6  THEN wuppertxt3.txt = IF wdetail.remark1 = "" THEN " " ELSE  TRIM(wdetail.remark1) .
    /*IF nv_line1 = 3 THEN wuppertxt3.txt = "Date Confirm_file_name :" + wdetail.remark . */
    nv_line1 = nv_line1 + 1.                                                
END.
............end A58-0489.......*/

/*DO WHILE nv_line1 <= 8:*/ /*A61-0152*/
DO WHILE nv_line1 <= 12: /*A61-0152*/
    CREATE wuppertxt3.
    wuppertxt3.line = nv_line1.
    IF nv_line1 = 3 THEN wuppertxt3.txt  = "SAFE : " + wdetail.revday .
    IF nv_line1 = 4 THEN wuppertxt3.txt  = wdetail.campens + IF wdetail.polmaster <> "" THEN " Polmaster : " + wdetail.polmaster ELSE "".
    /*IF nv_line1 = 5 THEN wuppertxt3.txt  = IF substr(wdetail.stk,1,1) <> "0" THEN  "0" + wdetail.stk ELSE wdetail.stk  .*//*A66-0252*/
    IF nv_line1 = 5 THEN wuppertxt3.txt  = IF trim(wdetail.stk) = "" THEN "" ELSE IF trim(wdetail.stk) = "0" THEN ""  
                                           ELSE IF substr(wdetail.stk,1,1) <> "0" THEN  "0" + wdetail.stk ELSE wdetail.stk  . /*A66-0252*/
    IF nv_line1 = 6 THEN wuppertxt3.txt  = IF wdetail.memotext = "" THEN  " " ELSE  wdetail.memotext .
    IF nv_line1 = 7 THEN wuppertxt3.txt  = IF wdetail.name2 = "" THEN  ""  ELSE "ออกใบเสร็จใบกำกับในนามดิลเลอร์ : " + wdetail.name2.
    IF nv_line1 = 8 THEN wuppertxt3.txt  = IF wdetail.remark1 = "" THEN " " ELSE  TRIM(wdetail.remark1) .
    IF nv_line1 = 9 THEN wuppertxt3.txt  = IF TRIM(wdetail.memo) <> "" THEN TRIM(wdetail.memo) ELSE ""  . /*A61-0152*/
    /*A66-0252 ...
    IF nv_line1 = 10 THEN wuppertxt3.txt = "E-Mail1 : " + TRIM(nv_memo1) . /*A61-0152*/
    IF nv_line1 = 11 THEN wuppertxt3.txt = "E-Mail2 : " + TRIM(nv_memo2). /*A61-0152*/
    IF nv_line1 = 12 THEN wuppertxt3.txt = "E-Mail3 : " + TRIM(nv_memo3).  /*A61-0152*/ 
    ...end A66-0252...*/
    /* add by : A66-0252 */
    IF nv_line1 = 10 THEN wuppertxt3.txt = "E-Mail1 : " + TRIM(wdetail.memo2) . /*A61-0152*/
    IF nv_line1 = 11 THEN wuppertxt3.txt = "E-Mail2 : " + TRIM(wdetail.memo3). /*A61-0152*/
    IF nv_line1 = 12 THEN wuppertxt3.txt = "E-Mail3 : " + TRIM(wdetail.memo4).  /*A61-0152*/ 
    /*...end A66-0252...*/
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
             /*MESSAGE "AA".*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_assign3 C-Win 
PROCEDURE pro_assign3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS CHAR INIT "".
FOR EACH wdetail2 .
    /*---------- สาขา , Deler code , vat code ------------------*/
    IF TRIM(wdetail2.showroom) <> "" THEN DO:
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno       = "TPIS"                   AND         
            TRIM(stat.insure.fname)  = TRIM(wdetail2.deler)     AND
            TRIM(stat.insure.lname)  = TRIM(wdetail2.showroom)  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.insure THEN DO:
                ASSIGN  /*wdetail2.branch     = stat.insure.branch*/ /*A66-05252*/
                        wdetail2.branch     = IF trim(wdetail2.branch) = "" THEN  stat.insure.branch ELSE TRIM(wdetail2.branch)  /*A66-05252*/
                        wdetail2.delerco    = stat.insure.insno  
                        wdetail2.financecd  = stat.Insure.Text3     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                        wdetail2.typepay    = stat.insure.vatcode.   /* kridtiya i. A53-0183*/ 
                /*---------- ภัยก่อการร้าย----------------*/
                IF TRIM(stat.insure.Addr3) <> "" THEN DO:
                    IF INDEX(wdetail2.typ_work,"V") <> 0   THEN DO:        /*A58-0489*/
                    /*FIND LAST wno30txt  WHERE wno30txt.policy = "0" + wdetail2.tpis_no   NO-ERROR NO-WAIT.*/ /*A58-0489*/
                        FIND LAST wno30txt  WHERE wno30txt.policy = "V" + wdetail2.tpis_no   NO-ERROR NO-WAIT. /*A58-0489*/
                        IF NOT AVAIL wno30txt THEN DO:
                            CREATE wno30txt.
                            ASSIGN 
                                /*wno30txt.policy  = "0" + wdetail2.tpis_no */ /*A58-0489*/
                                wno30txt.policy  = "V" + wdetail2.tpis_no   /*A58-0489*/
                                wno30txt.text30  = stat.Insure.Addr3.
                        END.
                    END.
                    ELSE IF INDEX(wdetail2.typ_work,"C") <> 0   THEN  DO:
                        FIND LAST wno30txt  WHERE wno30txt.policy = "C" + wdetail2.tpis_no   NO-ERROR NO-WAIT. /*A58-0489*/
                        IF NOT AVAIL wno30txt THEN DO:
                            CREATE wno30txt.
                            ASSIGN 
                                wno30txt.policy  = "C" + wdetail2.tpis_no   /*A58-0489*/
                                wno30txt.text30  = stat.Insure.Addr3.
                        END.
        
                    END.             
                END. /* ก่อการร้าย */
                /*----------ออกใบเสร็จในนามดีลเลอร์ ----------------*/
                IF INDEX(wdetail2.remark1,"Issue tax invoice") <> 0 THEN DO: 
                    IF trim(stat.insure.addr1) <> " " THEN DO:
                        ASSIGN wdetail2.dealer_name2  = "และ/หรือ " + trim(stat.insure.addr1) + 
                                                        IF TRIM(stat.insure.addr2) <> "" THEN " " + trim(stat.insure.addr2) ELSE "". 
                   END.
                   ELSE DO:
                       FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = trim(wdetail2.typepay) NO-LOCK NO-ERROR .
                            IF AVAIL sicsyac.xmm600 THEN 
                                ASSIGN wdetail2.dealer_name2  = "และ/หรือ " + trim(sicsyac.xmm600.ntitle) + " " + trim(sicsyac.xmm600.NAME).    
                   END.
                END.
                ELSE DO:
                     ASSIGN  wdetail2.dealer_name2  = "".
                END.
                /*---end a58-0489----*/
            END.
            ELSE DO:                                       
                ASSIGN /*wdetail2.branch   = ""  */ /*A66-0252*/            
                       wdetail2.delerco  = ""  
                       wdetail2.financecd  = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                       wdetail2.typepay  = ""              
                       wdetail2.dealer_name2      = "" .   
            END.  
    END.
    ELSE DO:
      FIND FIRST stat.insure USE-INDEX insure01 WHERE stat.insure.compno       = "TPIS"     AND       
                                                      TRIM(stat.insure.fname)  = TRIM(wdetail2.deler) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.insure THEN DO:
                ASSIGN  /*wdetail2.branch     = stat.insure.branch*/ /*A66-05252*/
                        wdetail2.branch     = IF trim(wdetail2.branch) = "" THEN  stat.insure.branch ELSE TRIM(wdetail2.branch)  /*A66-05252*/
                        wdetail2.delerco    = stat.insure.insno 
                        wdetail2.financecd  = stat.Insure.Text3     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                        wdetail2.typepay    = stat.insure.vatcode.   /* kridtiya i. A53-0183*/ 
                IF TRIM(stat.insure.Addr3) <> "" THEN DO:
                    IF INDEX(wdetail2.typ_work,"V") <> 0   THEN DO:        /*A58-0489*/
                    /*FIND LAST wno30txt  WHERE wno30txt.policy = "0" + wdetail2.tpis_no   NO-ERROR NO-WAIT.*/ /*A58-0489*/
                        FIND LAST wno30txt  WHERE wno30txt.policy = "V" + wdetail2.tpis_no   NO-ERROR NO-WAIT. /*A58-0489*/
                        IF NOT AVAIL wno30txt THEN DO:
                            CREATE wno30txt.
                            ASSIGN 
                                /*wno30txt.policy  = "0" + wdetail2.tpis_no */ /*A58-0489*/
                                wno30txt.policy  = "V" + wdetail2.tpis_no   /*A58-0489*/
                                wno30txt.text30  = stat.Insure.Addr3.
                        END.
                    END.
                    ELSE IF INDEX(wdetail2.typ_work,"C") <> 0   THEN  DO:
                        FIND LAST wno30txt  WHERE wno30txt.policy = "C" + wdetail2.tpis_no   NO-ERROR NO-WAIT. /*A58-0489*/
                        IF NOT AVAIL wno30txt THEN DO:
                            CREATE wno30txt.
                            ASSIGN 
                                wno30txt.policy  = "C" + wdetail2.tpis_no   /*A58-0489*/
                                wno30txt.text30  = stat.Insure.Addr3.
                        END.
                    END.             
                END.
                /*----------ออกใบเสร็จในนามดีลเลอร์ ----------------*/
                IF INDEX(wdetail2.remark1,"Issue tax invoice") <> 0 THEN DO: 
                    IF trim(stat.insure.addr1) <> " " THEN DO:
                        ASSIGN wdetail2.dealer_name2  = "และ/หรือ " + trim(stat.insure.addr1) + 
                                                        IF TRIM(stat.insure.addr2) <> "" THEN " " + trim(stat.insure.addr2) ELSE "". 
                   END.
                   ELSE DO:
                       FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = trim(wdetail2.typepay) NO-LOCK NO-ERROR .
                            IF AVAIL sicsyac.xmm600 THEN 
                                ASSIGN wdetail2.dealer_name2  = "และ/หรือ " + trim(sicsyac.xmm600.ntitle) + " " + trim(sicsyac.xmm600.NAME).    
                   END.
                END.
                ELSE DO:
                     ASSIGN  wdetail2.dealer_name2  = "".
                END.
                /*---end a58-0489----*/
            END.
            ELSE DO:                                       
                ASSIGN /*wdetail2.branch    = ""    */ /*A66-0252*/          
                       wdetail2.delerco   = ""  
                       wdetail2.financecd = ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                       wdetail2.typepay   = "".            
            END.  
    END.
   
    /*------------- ที่อยู่ -----------------------------------*/
    IF wdetail2.mail_build   <> ""  THEN DO: 
        ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
    END.
    IF wdetail2.mail_mu <> ""  THEN DO: 
        IF INDEX(wdetail2.mail_mu,"หมู่") <> 0   OR INDEX(wdetail2.mail_mu,"ม.") <> 0 OR 
           INDEX(wdetail2.mail_mu,"บ้าน") <> 0   OR INDEX(wdetail2.mail_mu,"หมู่บ้าน") <> 0 THEN DO:
            ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_mu).
        END.
        ELSE DO:
        ASSIGN  n = ""  
                n = SUBSTR(TRIM(wdetail2.mail_mu),1,1).
                IF INDEX("0123456789",n) <> 0 THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ม." + trim(wdetail2.mail_mu).
                ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " หมู่บ้าน" + trim(wdetail2.mail_mu).
        END.
    END.
    IF wdetail2.mail_soi <> ""  THEN DO:
        IF INDEX(wdetail2.mail_soi,"ซ.") <> 0 OR INDEX(wdetail2.mail_soi,"ซอย") <> 0 THEN 
             wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_soi) .
        ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ซอย" + trim(wdetail2.mail_soi) .
    END.
    IF wdetail2.mail_road <> ""  THEN DO: 
        IF INDEX(wdetail2.mail_road,"ถ.") <> 0 OR INDEX(wdetail2.mail_road,"ถนน") <> 0 THEN
             wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_road) .
        ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ถนน" + trim(wdetail2.mail_road) .
    END.
    IF trim(wdetail2.mail_country) <> ""  THEN DO:
        IF (index(wdetail2.mail_country,"กทม") <> 0 ) OR (index(wdetail2.mail_country,"กรุงเทพ") <> 0 ) THEN 
            ASSIGN 
            wdetail2.mail_tambon  = "แขวง"  + trim(wdetail2.mail_tambon) 
            wdetail2.mail_amper   = "เขต"   + trim(wdetail2.mail_amper)
            wdetail2.mail_country = trim(wdetail2.mail_country)                              /*Add by Kridtiya i. A63-0472*/
            wdetail2.mail_post    = trim(wdetail2.mail_post)  .  /* A67-0101*/ 
            /*wdetail2.mail_post    = trim(wdetail2.post)  . */ /* A67-0101*/                                  /*Add by Kridtiya i. A63-0472*/

        ELSE ASSIGN 
            wdetail2.mail_tambon  = "ตำบล"  +   trim(wdetail2.mail_tambon) 
            wdetail2.mail_amper   = "อำเภอ" +   trim(wdetail2.mail_amper)
             wdetail2.mail_country = "จังหวัด" + trim(wdetail2.mail_country)                                   /*Add by Kridtiya i. A63-0472*/    
            wdetail2.mail_post    =  trim(wdetail2.mail_post) .                                               /*Add by Kridtiya i. A63-0472*/    
    END.
    /*--------- A58-0489-----------------*/
    DO WHILE INDEX(wdetail2.mail_hno,"  ") <> 0 :
        ASSIGN wdetail2.mail_hno = REPLACE(wdetail2.mail_hno,"  "," ").
    END.
    IF LENGTH(wdetail2.mail_hno) > 50  THEN DO: /*A66-0252*/
        loop_add01:
        DO WHILE LENGTH(wdetail2.mail_hno) > 50 : /*A66-0252*/
            IF r-INDEX(wdetail2.mail_hno," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.mail_tambon  = trim(SUBSTR(wdetail2.mail_hno,r-INDEX(wdetail2.mail_hno," "))) + " " + wdetail2.mail_tambon
                    wdetail2.mail_hno = trim(SUBSTR(wdetail2.mail_hno,1,r-INDEX(wdetail2.mail_hno," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        loop_add02:
        DO WHILE LENGTH(wdetail2.mail_tambon) > 50 :  /*A66-0252*/
            IF r-INDEX(wdetail2.mail_tambon," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.mail_amper   = trim(SUBSTR(wdetail2.mail_tambon,r-INDEX(wdetail2.mail_tambon," "))) + " " + wdetail2.mail_amper
                    wdetail2.mail_tambon  = trim(SUBSTR(wdetail2.mail_tambon,1,r-INDEX(wdetail2.mail_tambon," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
    END.
    IF LENGTH(wdetail2.mail_tambon + " " + wdetail2.mail_amper) <= 50 THEN DO: /*A66-0252*/
        ASSIGN 
        wdetail2.mail_tambon  =  wdetail2.mail_tambon + " " + wdetail2.mail_amper   
        wdetail2.mail_amper   =  wdetail2.mail_country 
        wdetail2.mail_country =  "" .
    END.
    IF LENGTH(wdetail2.mail_amper + " " + wdetail2.mail_country ) <= 50 THEN DO: /*A66-0252*/
        ASSIGN 
        wdetail2.mail_amper   =  trim(wdetail2.mail_amper) + " " + TRIM(wdetail2.mail_country) 
        wdetail2.mail_country =  "" .
    END.
    IF LENGTH(wdetail2.mail_country) > 35 THEN DO: /*A66-0252*/
        IF INDEX(wdetail2.mail_country,"จังหวัด") <> 0 THEN 
            ASSIGN wdetail2.mail_country = REPLACE(wdetail2.mail_country,"จังหวัด","จ.").
    END.

    /*========================== ที่อยู่ 2 =========================*/
     
    IF wdetail2.build   <> ""  THEN DO: 
        ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
    END.
    IF wdetail2.mu <> ""  THEN DO: 
        IF INDEX(wdetail2.mu,"หมู่") <> 0   OR INDEX(wdetail2.mu,"ม.") <> 0 OR 
           INDEX(wdetail2.mu,"บ้าน") <> 0   OR INDEX(wdetail2.mu,"หมู่บ้าน") <> 0 THEN DO:
            ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu).
        END.
        ELSE DO:
        ASSIGN  n = ""  
                n = SUBSTR(TRIM(wdetail2.mu),1,1).
                IF INDEX("0123456789",n) <> 0 THEN wdetail2.address = trim(wdetail2.address) + " ม." + trim(wdetail2.mu).
                ELSE wdetail2.address = trim(wdetail2.address) + " หมู่บ้าน" + trim(wdetail2.mu).
        END.
    END.
    IF wdetail2.soi <> ""  THEN DO:
        IF INDEX(wdetail2.soi,"ซ.") <> 0 OR INDEX(wdetail2.soi,"ซอย") <> 0 THEN 
             wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.soi) .
        ELSE wdetail2.address = trim(wdetail2.address) + " ซอย" + trim(wdetail2.soi) .
    END.
    IF wdetail2.road <> ""  THEN DO: 
        IF INDEX(wdetail2.road,"ถ.") <> 0 OR INDEX(wdetail2.road,"ถนน") <> 0 THEN
             wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.road) .
        ELSE wdetail2.address = trim(wdetail2.address) + " ถนน" + trim(wdetail2.road) .
    END.
    IF trim(wdetail2.country) <> ""  THEN DO:
        IF (index(wdetail2.country,"กทม") <> 0 ) OR (index(wdetail2.country,"กรุงเทพ") <> 0 ) THEN 
            ASSIGN 
            wdetail2.tambon  = "แขวง"  + trim(wdetail2.tambon) 
            wdetail2.amper   = "เขต"   + trim(wdetail2.amper)
            wdetail2.country = trim(wdetail2.country)                           
            wdetail2.post    = trim(wdetail2.post)  .                           

        ELSE ASSIGN 
            wdetail2.tambon  = "ตำบล"  +   trim(wdetail2.tambon) 
            wdetail2.amper   = "อำเภอ" +   trim(wdetail2.amper)
             wdetail2.country = "จังหวัด" + trim(wdetail2.country)              
            wdetail2.post    =  trim(wdetail2.post) .                           
    END.
    
    DO WHILE INDEX(wdetail2.address,"  ") <> 0 :
        ASSIGN wdetail2.address = REPLACE(wdetail2.address,"  "," ").
    END.
    IF LENGTH(wdetail2.address) > 50  THEN DO: /*A66-0252*/
        loop_add01:
        DO WHILE LENGTH(wdetail2.address) > 50 : /*A66-0252*/
            IF r-INDEX(wdetail2.address," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.tambon  = trim(SUBSTR(wdetail2.address,r-INDEX(wdetail2.address," "))) + " " + wdetail2.tambon
                    wdetail2.address = trim(SUBSTR(wdetail2.address,1,r-INDEX(wdetail2.address," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        loop_add02:
        DO WHILE LENGTH(wdetail2.tambon) > 50 :  /*A66-0252*/
            IF r-INDEX(wdetail2.tambon," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.amper   = trim(SUBSTR(wdetail2.tambon,r-INDEX(wdetail2.tambon," "))) + " " + wdetail2.amper
                    wdetail2.tambon  = trim(SUBSTR(wdetail2.tambon,1,r-INDEX(wdetail2.tambon," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
    END.
    IF LENGTH(wdetail2.tambon + " " + wdetail2.amper) <= 50 THEN DO: /*A66-0252*/
        ASSIGN 
        wdetail2.tambon  =  wdetail2.tambon + " " + wdetail2.amper   
        wdetail2.amper   =  wdetail2.country 
        wdetail2.country =  "" .
    END.
    IF LENGTH(wdetail2.amper + " " + wdetail2.country ) <= 50 THEN DO: /*A66-0252*/
        ASSIGN 
        wdetail2.amper   =  trim(wdetail2.amper) + " " + TRIM(wdetail2.country) 
        wdetail2.country =  "" .
    END.
    IF LENGTH(wdetail2.country) > 35 THEN DO: /*A66-0252*/
        IF INDEX(wdetail2.country,"จังหวัด") <> 0 THEN 
            ASSIGN wdetail2.country = REPLACE(wdetail2.country,"จังหวัด","จ.").
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

