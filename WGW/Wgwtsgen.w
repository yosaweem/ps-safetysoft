&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_bran         PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
/* Connected Databases sic_test         PROGRESS      */
File:  Description:  Input Parameters:  <none> Output Parameters:  <none>  Author:  Created:  ---------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/* Create an unnamed pool to store all the widgets created  by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
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
{wgw\wgwtsgen.i}      /*ประกาศตัวแปร*/
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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.redbook wdetail.poltyp wdetail.policy wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.iadd1 wdetail.iadd2 wdetail.iadd3 wdetail.iadd4 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.engno wdetail.chasno wdetail.caryear wdetail.carprovi wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.volprem wdetail.Compprem wdetail.fleet wdetail.ncb wdetail.access wdetail.deductpp wdetail.deductba wdetail.deductpa wdetail.benname wdetail.n_user wdetail.n_IMPORT wdetail.n_export wdetail.drivnam1 wdetail.drivnam wdetail.drivbir1 wdetail.producer wdetail.agent wdetail.comment WDETAIL.WARNING wdetail.cancel   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_typeload fi_loaddat fi_pack fi_campens ~
fi_mocode fi_branch fi_memotext fi_producer fi_agent fi_vatcode fi_name2 ~
fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 fi_output3 ~
fi_usrcnt fi_usrprem buok bu_exit br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent ~
ra_compatyp fi_process RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 ~
RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS ra_typeload fi_loaddat fi_pack fi_campens ~
fi_mocode fi_branch fi_memotext fi_producer fi_agent fi_vatcode fi_bchno ~
fi_name2 fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 ~
fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname fi_impcnt ra_compatyp ~
fi_process fi_completecnt fi_premtot fi_premsuc 

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
     SIZE 19 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

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
     SIZE 15 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_memotext AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 36 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_mocode AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .91
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
     SIZE 5 BY .91
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
     BGCOLOR 5  NO-UNDO.

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

DEFINE VARIABLE ra_compatyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "TAS", 1,
"TPIB", 2
     SIZE 23 BY .91
     BGCOLOR 5 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE ra_typeload AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match file Load", 1,
"Load To GW", 2,
"Match file Policy", 3,
"Match file Recipt", 4
     SIZE 90 BY .91
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 1.43
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 14.05
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 5
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 3.1
     BGCOLOR 8 .

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

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail C-Win _FREEFORM
  QUERY br_wdetail DISPLAY
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
        WDETAIL.WARNING   COLUMN-LABEL "Warning"
        wdetail.cancel    COLUMN-LABEL "Cancel"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 4.52
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_typeload AT ROW 2.67 COL 30 NO-LABEL
     fi_loaddat AT ROW 3.67 COL 27 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 3.67 COL 53.5 COLON-ALIGNED NO-LABEL
     fi_campens AT ROW 3.67 COL 70 COLON-ALIGNED NO-LABEL
     fi_mocode AT ROW 3.67 COL 97.83 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.71 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_memotext AT ROW 4.71 COL 81.83 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.71 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6.71 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_vatcode AT ROW 7.71 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.86 COL 15.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_name2 AT ROW 7.71 COL 50.67 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 8.95 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 8.95 COL 59.17 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.95 COL 26.83 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9.95 COL 89.5
     fi_output1 AT ROW 10.95 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.95 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.95 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 13.91 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 13.91 COL 65.17 NO-LABEL
     buok AT ROW 10.52 COL 98
     bu_exit AT ROW 12.38 COL 98
     fi_brndes AT ROW 4.71 COL 36.83 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 16.91 COL 2
     bu_hpbrn AT ROW 4.71 COL 34.5
     bu_hpacno1 AT ROW 5.71 COL 43.5
     bu_hpagent AT ROW 6.71 COL 43.5
     fi_proname AT ROW 5.71 COL 46 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6.71 COL 46 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 22.29 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     ra_compatyp AT ROW 2.67 COL 5.5 NO-LABEL
     fi_process AT ROW 15.1 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.29 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.29 COL 97 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.33 COL 95 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     "                      Branch :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 4.71 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "               Agent Code :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 6.71 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Model :" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 3.67 COL 91.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .91 AT ROW 8.95 COL 59.66 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 8.95 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .91 AT ROW 13.91 COL 63.67 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 13.91 COL 82.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "         Vat Code[TPIB] :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 7.71 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "    IMPORT TEXT FILE MOTOR [TIL]" VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.24 COL 2.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "F18:" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 4.71 COL 78.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "         Producer  Code :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 5.71 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.29 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 12.95 COL 5.5
          BGCOLOR 18 FGCOLOR 1 
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.86 COL 5.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 22.29 COL 94.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 11.95 COL 5.5
          BGCOLOR 18 FGCOLOR 1 
     "Name 2 :" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 7.71 COL 43.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 10.95 COL 5.5
          BGCOLOR 18 FGCOLOR 1 
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 23.29 COL 57.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 23.29 COL 94.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 23.29 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 13.91 COL 27.5 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "                 Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 3.67 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.29 COL 57.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Campaign :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 3.67 COL 61
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 3.67 COL 44.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "      NO-MN30 : By Status Dealer" VIEW-AS TEXT
          SIZE 35 BY .91 AT ROW 8.95 COL 76.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 9.95 COL 5.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.43 COL 1
     RECT-373 AT ROW 16.67 COL 1
     RECT-374 AT ROW 21.71 COL 1
     RECT-376 AT ROW 22.05 COL 4.17
     RECT-377 AT ROW 10.05 COL 96.5
     RECT-378 AT ROW 12 COL 96.5
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
         TITLE              = "LOAD TEXT FILE TIL TO GW"
         HEIGHT             = 24
         WIDTH              = 133
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
/* SETTINGS FOR FILL-IN fi_bchno IN FRAME fr_main
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
          SIZE 12.83 BY .91 AT ROW 8.95 COL 59.66 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "    Policy Import Total :"
          SIZE 23 BY .91 AT ROW 13.91 COL 27.5 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .91 AT ROW 13.91 COL 63.67 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.29 COL 57.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 22.29 COL 94.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 23.29 COL 57.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 23.29 COL 94.83 RIGHT-ALIGNED       */

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
ON END-ERROR OF C-Win /* LOAD TEXT FILE TIL TO GW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* LOAD TEXT FILE TIL TO GW */
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
        WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                    
        WDETAIL.CANCEL:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
                                       
           /*new add*/                 


          /*wdetail.entdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.enttim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trandat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trantim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. *//*a490166*/ 
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
    IF ra_typeload = 2 THEN DO:  /*  Load GW*/
        ASSIGN
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2
            fi_completecnt         = 0
            fi_premsuc             = 0
            fi_bchno               = ""
            fi_premtot             = 0
            fi_impcnt              = 0
            fi_process  = "Import data TAS/TPIB.......[ISUZU]" .   /*a55-0051*/ 
        DISP fi_process  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
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
        RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                               INPUT            nv_batchyr ,     /* INT   */
                               INPUT            fi_producer,     /* CHAR  */ 
                               INPUT            nv_batbrn  ,     /* CHAR  */
                               INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                               INPUT            "WGWTSGEN" ,     /* CHAR  */
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
        RELEASE brstat.detaitem.
        RELEASE sicsyac.xtm600.
        RELEASE sicsyac.xmm600.
        RELEASE sicsyac.xzm056.
        IF nv_batflg = NO THEN DO:  
            ASSIGN
                fi_completecnt:FGCOLOR = 6
                fi_premsuc    :FGCOLOR = 6 
                fi_bchno    :FGCOLOR = 6 
                fi_process  = "Data Error............ TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
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
                fi_process  = "Process Data compleate TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
            DISP  fi_process WITH FRAM fr_main.
            MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
        END.
        RUN   proc_open.
        ASSIGN fi_process = "Load Text file TAS/TPIB.......[ISUZU]" . 
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
         /***---a490166 ---***/
         IF ra_typeload = 2 THEN
             ASSIGN
             fi_filename  = cvData
             fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
             fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
             fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
         ELSE IF ra_typeload = 1 THEN
             ASSIGN
             fi_filename  = cvData
             fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add  + "_mat.slk"  /*.csv*/
             fi_output2 = ""
             fi_output3 = "".
         ELSE IF ra_typeload = 3 THEN
        ASSIGN
             fi_filename  = cvData
             fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add +  "_matpol.csv" /*.csv*/
             fi_output2 = ""
             fi_output3 = "".
    ELSE ASSIGN
             fi_filename  = cvData
             fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add +  "_matrep.csv" /*.csv*/
             fi_output2 = ""
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
                fi_memotext = "TIL Topping Interest Rate"
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


&Scoped-define SELF-NAME ra_compatyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_compatyp C-Win
ON VALUE-CHANGED OF ra_compatyp IN FRAME fr_main
DO:
  ra_compatyp = INPUT ra_compatyp.
  IF ra_compatyp = 2 THEN DO:  /*tpib*/
  
      ASSIGN
      /*fi_campens  = "C56/00166"*/ /*A57-0260*/   
      fi_campens  = "C57/00041"     /*A57-0260*/   
      fi_producer = "B3M0018"
      fi_agent    = "B3M0018"
      fi_memotext = "TIL Topping Interest Rate"
      fi_vatcode  = "MC21364"
      /*fi_name2    = "" .*//*A56-0245*/
      fi_name2    = "และ/หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด" .  /*A56-0245*/
      /*A58-0092*/
      FIND FIRST brstat.insure USE-INDEX insure01      WHERE 
          index(brstat.insure.compno,"TPIB_C") <> 0    AND  
          insure.ICAddr2 =  fi_producer   NO-LOCK  NO-WAIT NO-ERROR.
      IF AVAIL brstat.insure  THEN  
          ASSIGN fi_campens = trim(substr(brstat.insure.compno,6))  .
      /*A58-0092*/

  END.
  ELSE DO: 
      /*A58-0092*/
      ASSIGN  /*tas*/
          fi_campens  = "C54/00770"
          fi_producer = "A0M0086"
          fi_agent    = "B3M0018"
          fi_memotext = ""
          fi_vatcode  = ""
          fi_name2    = "และ/หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด" .
      FIND FIRST brstat.insure USE-INDEX insure01      WHERE 
          index(brstat.insure.compno,"TAS_C") <> 0    AND  
          insure.ICAddr2 =  fi_producer   NO-LOCK  NO-WAIT NO-ERROR.
      IF AVAIL brstat.insure  THEN  
          ASSIGN fi_campens = trim(substr(brstat.insure.compno,6))  .
      /*A58-0092*/
  END.
  DISP ra_compatyp 
       fi_campens 
       fi_producer
       fi_agent   
       fi_vatcode 
       fi_name2 
       fi_memotext
      WITH FRAM fr_main.
  APPLY "entry" TO fi_loaddat.
      RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typeload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typeload C-Win
ON VALUE-CHANGED OF ra_typeload IN FRAME fr_main
DO:
    ra_typeload = INPUT ra_typeload .
    no_add =           STRING(MONTH(TODAY),"99")    + 
        STRING(DAY(TODAY),"99")      + 
        SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
        SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
    IF fi_filename = "" THEN DO:
        APPLY "Entry" TO fi_filename.
         RETURN NO-APPLY.
    END.
    ELSE DO:
        
    IF ra_typeload = 2 THEN
        ASSIGN
        fi_filename  = cvData
        fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
        fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
        fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
    ELSE IF ra_typeload = 1 THEN
        ASSIGN
             fi_filename  = cvData
             fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add  + "_mat.slk"  /*.csv*/
             fi_output2 = ""
             fi_output3 = "".
    ELSE IF ra_typeload = 3 THEN
        ASSIGN
             fi_filename  = cvData
             fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add +  "_matpol.csv" /*.csv*/
             fi_output2 = ""
             fi_output3 = "".
    ELSE ASSIGN
             fi_filename  = cvData
             fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add +  "_matrep.csv" /*.csv*/
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
  
  gv_prgid = "Wgwtsgen".
  gv_prog  = "Load Text & Generate TIL".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
      ra_compatyp = 2
      ra_typeload = 1
      fi_pack     = "V"
      fi_branch   = "M"
      fi_mocode   = "Model"        /*add Kridtiya i. A55-0107*/
      /*fi_vatcode  = ""*/ /*A57-0415*/
      fi_vatcode  = "MC21364"   /*A57-0415*/
      fi_memotext = ""
      fi_name2    = "และ/หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด" 
      fi_campens  = "C57/00041"      
      fi_producer = "B3M0018"
      fi_agent    = "B3M0018"
      fi_memotext = "TIL Topping Interest Rate"
      fi_bchyr    = YEAR(TODAY)
      fi_process  = "Load Text file TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
  /*A58-0092*/
  FIND FIRST brstat.insure USE-INDEX insure01      WHERE 
      index(brstat.insure.compno,"TPIB_C") <> 0    AND  
      insure.ICAddr2 =  fi_producer   NO-LOCK  NO-WAIT NO-ERROR.
  IF AVAIL brstat.insure  THEN  
      ASSIGN fi_campens = trim(substr(brstat.insure.compno,6))  .
  /*A58-0092*/
  DISP fi_mocode  ra_typeload ra_compatyp fi_pack  fi_branch   fi_campens fi_producer fi_agent 
       fi_process fi_vatcode  fi_name2    fi_bchyr fi_memotext  WITH FRAME fr_main.
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
  DISPLAY ra_typeload fi_loaddat fi_pack fi_campens fi_mocode fi_branch 
          fi_memotext fi_producer fi_agent fi_vatcode fi_bchno fi_name2 
          fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 
          fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname fi_impcnt 
          ra_compatyp fi_process fi_completecnt fi_premtot fi_premsuc 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE ra_typeload fi_loaddat fi_pack fi_campens fi_mocode fi_branch 
         fi_memotext fi_producer fi_agent fi_vatcode fi_name2 fi_prevbat 
         fi_bchyr fi_filename bu_file fi_output1 fi_output2 fi_output3 
         fi_usrcnt fi_usrprem buok bu_exit br_wdetail bu_hpbrn bu_hpacno1 
         bu_hpagent ra_compatyp fi_process RECT-370 RECT-372 RECT-373 RECT-374 
         RECT-376 RECT-377 RECT-378 
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
RUN proc_stkfinddup.
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
        sic_bran.uwm301.eng_no   = wdetail.eng
        sic_bran.uwm301.Tons     = INTEGER(wdetail.weight)
        sic_bran.uwm301.engine   = INTEGER(wdetail.cc)
        sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage   = wdetail.garage
        sic_bran.uwm301.body     = wdetail.body
        sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = wdetail.benname
        sic_bran.uwm301.vehreg   = wdetail.vehreg 
        sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        sic_bran.uwm301.moddes   = wdetail.model     
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
                Substring(sic_bran.uwm301.moddes,1,18)   = SUBSTRING(xmm102.modest, 1,18)  /*Thai language*/  
                Substring(sic_bran.uwm301.moddes,19,22)  = SUBSTRING(xmm102.modest,19,22)  /*Thai Language*/
                sic_bran.uwm301.Tons           = sicsyac.xmm102.tons
                sic_bran.uwm301.engine         = sicsyac.xmm102.engine
                sic_bran.uwm301.moddes         = sicsyac.xmm102.modest
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
            sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
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
                        MESSAGE sic_bran.uwd132.gap_c "1 / " nv_gap nv_prem   VIEW-AS ALERT-BOX.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign C-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_process  = "Create data to workfile TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail2.
    /*IMPORT DELIMITER "," *//*A54-335 */
    IMPORT DELIMITER "|"     /*A54-335 */
        wdetail2.id              
        wdetail2.TASDay          
        wdetail2.TASMonth        
        wdetail2.TASYear         
        wdetail2.policy          
        wdetail2.TASreceived     
        wdetail2.InsCompany      
        wdetail2.Insurancerefno  
        wdetail2.receivedDay     
        wdetail2.receivedMonth   
        wdetail2.receivedYear    
        wdetail2.insnam          
        wdetail2.NAME2 
        wdetail2.ICNO
        wdetail2.address         
        wdetail2.mu              
        wdetail2.soi             
        wdetail2.road            
        wdetail2.tambon          
        wdetail2.amper           
        wdetail2.country         
        wdetail2.post            
        wdetail2.tel             
        wdetail2.model           
        wdetail2.vehuse          
        wdetail2.coulor          
        wdetail2.cc              
        wdetail2.engno           
        wdetail2.chasno          
        wdetail2.nameinsur       
        wdetail2.comday          
        wdetail2.commonth        
        wdetail2.comyear         
        wdetail2.si 
        wdetail2.baseprm
        wdetail2.stk             
        wdetail2.deler           
        wdetail2.showroom        
        wdetail2.typepay         
        wdetail2.financename     
        wdetail2.requresname     
        wdetail2.requresname2    
        wdetail2.telreq          
        wdetail2.staus           
        wdetail2.REMARK1         
        wdetail2.CHECK1          
        wdetail2.COUNT1.  
END. /*-Repeat-*/
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
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_benname   AS CHAR INIT "" FORMAT "x(50)".  /*A55-0051*/
ASSIGN fi_process  = "Match benifitcode data to workfile TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
FOR EACH wdetail2 .
    /*IF wdetail2.id = "" THEN DO:*//*Kridtiya i. A53-0180*/
    IF (wdetail2.id = "id") THEN DELETE wdetail2.
    ELSE IF  wdetail2.policy =  ""  THEN DELETE wdetail2.    /*Kridtiya i. A53-0180*/
    ELSE DO:
     
        /*comment by Kridtiya i.A55-0051.....
        IF wdetail2.financename = "kk"        THEN  wdetail2.financename2 = "ธนาคาร เกียรตินาคิน จำกัด".
        IF wdetail2.financename = "T-BANK"    THEN  wdetail2.financename2 = "ธนาคาร ธนชาต จำกัด (มหาชน)".
        IF wdetail2.financename = "AYCL"      THEN  wdetail2.financename2 = "บริษัท อยุธยา แคปปิตอล ออโต้ ลีส จำกัด (มหาชน)".
        /*IF wdetail2.financename = "TAS"       THEN  wdetail2.financename2 = "บจก.ไทยออโต้เซลส์".*//*comment Kridtiya i. A53-0156*/
        IF wdetail2.financename = "TISCO"     THEN  wdetail2.financename2 = "ธนาคารทิสโก้ จำกัด (มหาชน)".
        IF wdetail2.financename = "K-Leasing" THEN  wdetail2.financename2 = "บริษัท ลีสซิ่งกสิกรไทย จำกัด".
        IF wdetail2.financename = "SCBL"      THEN  wdetail2.financename2 = "ธนาคารไทยพาณิชย์ จำกัด (มหาชน)".
        IF wdetail2.financename = "Asia SK"   THEN  wdetail2.financename2 = "บจก.เอเซียเสริมกิจ ลิสซิ่ง".
        IF wdetail2.financename = "TIL"       THEN  wdetail2.financename2 = "บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด".  /*Kridtiya i. A53-0156*/
        /*Kridtiya i. A54-0026*/ 
        IF wdetail2.financename = "KTB"       THEN  wdetail2.financename2 = "ธนาคารกรุงไทย".              
        IF wdetail2.financename = "sin asia"  THEN  wdetail2.financename2 = "ลิชซิ่งเอเชีย".               
        IF wdetail2.financename = "i-bank"    THEN  wdetail2.financename2 = "ธนาคารอิสลามแห่งประเทศไทย".  
        /*Kridtiya i. A54-0026*/
        end...comment by Kridtiya i.A55-0051.....*/
        /*add comment by Kridtiya i.A55-0051.....*/
        ASSIGN n_benname = "" 
            n_benname = trim(wdetail2.financename).
        IF (n_benname = "0" ) OR (n_benname = "-0" ) OR (n_benname = "" ) OR (n_benname = "-" ) THEN 
            ASSIGN wdetail2.financename = "".
        ELSE DO:
            FIND FIRST stat.company USE-INDEX Company01 WHERE 
                company.compno = n_benname    NO-LOCK   NO-ERROR NO-WAIT.
            IF AVAIL stat.company THEN
                ASSIGN  n_benname    = stat.company.name2
                wdetail2.financename2 = n_benname  .
            ELSE ASSIGN wdetail2.financename2 = "error:" + n_benname .
        END.
        /*end...comment by Kridtiya i.A55-0051.....*/
        /*comment BY Kridtiya i. a54-0271.....
        IF wdetail2.vehuse = "เก๋ง" THEN DO:
            IF (deci(wdetail2.si) >= 470000 ) AND (deci(wdetail2.si) <= 650000 ) THEN  wdetail2.baseprm = "13828".
            IF (deci(wdetail2.si) >= 660000 ) AND (deci(wdetail2.si) <= 800000 ) THEN  wdetail2.baseprm = "14294".
            IF (deci(wdetail2.si) >= 750000 ) AND (deci(wdetail2.si) <= 850000 ) THEN  wdetail2.baseprm = "13994".
            IF (deci(wdetail2.si) >= 860000 ) AND (deci(wdetail2.si) <= 1200000 )THEN  wdetail2.baseprm = "17086".
        END.
        ELSE DO:
            IF (deci(wdetail2.si) >= 340000 ) AND (deci(wdetail2.si) <= 530000) THEN   wdetail2.baseprm = "13528".
            IF (deci(wdetail2.si) >= 540000 ) AND (deci(wdetail2.si) <= 650000) THEN   wdetail2.baseprm = "17086".
        END. 
        end....BY Kridtiya i. a54-0271.....*/
        /*Add BY Kridtiya i. a54-0271....*/
        IF ra_compatyp = 1 THEN DO: /*kridtiya i. A54-0335 */
            IF wdetail2.vehuse = "เก๋ง" THEN DO:
                IF (INDEX(wdetail2.model,"mu7") <> 0 ) OR (INDEX(wdetail2.model,"mu") <> 0 ) THEN DO: 
                    IF (deci(wdetail2.si) >= 750000 ) AND (deci(wdetail2.si) <= 850000 )  THEN  wdetail2.baseprm = "16155".
                    ELSE IF (deci(wdetail2.si) >= 860000 ) AND (deci(wdetail2.si) <= 1200000 ) THEN  wdetail2.baseprm = "17086".
                END.
                ELSE DO:
                    IF (deci(wdetail2.si) >= 470000 ) AND (deci(wdetail2.si) <= 650000 ) THEN  wdetail2.baseprm = "13828".
                    ELSE IF (deci(wdetail2.si) >= 660000 ) AND (deci(wdetail2.si) <= 800000 ) THEN  wdetail2.baseprm = "14294".
                    ELSE IF (deci(wdetail2.si) >= 810000 ) AND (deci(wdetail2.si) <= 850000 ) THEN  wdetail2.baseprm = "14294".
                    ELSE IF (deci(wdetail2.si) >= 860000 ) AND (deci(wdetail2.si) <= 900000 ) THEN  wdetail2.baseprm = "14294".
                    ELSE IF (deci(wdetail2.si) >= 910000 ) AND (deci(wdetail2.si) <= 950000 ) THEN  wdetail2.baseprm = "14294".
                END.
            END.
            ELSE DO:
                IF (deci(wdetail2.si) >= 340000 ) AND (deci(wdetail2.si) <= 530000 ) THEN  wdetail2.baseprm = "13528".
                ELSE IF (deci(wdetail2.si) >= 540000 ) AND (deci(wdetail2.si) <= 650000 ) THEN  wdetail2.baseprm = "13994".
                ELSE IF (deci(wdetail2.si) >= 660000 ) AND (deci(wdetail2.si) <= 700000 ) THEN  wdetail2.baseprm = "13994".
                ELSE IF (deci(wdetail2.si) >= 710000 ) AND (deci(wdetail2.si) <= 750000 ) THEN  wdetail2.baseprm = "13994".
                ELSE IF (deci(wdetail2.si) >= 760000 ) AND (deci(wdetail2.si) <= 800000 ) THEN  wdetail2.baseprm = "13994".
            END.
        END. /*add kridtiya i. A54-0335 */
        ELSE DO:   /* TPIB  */
            IF (INDEX(wdetail2.model,"mu-X") <> 0 ) THEN DO:
                IF (deci(wdetail2.si) >= 820000 ) AND (deci(wdetail2.si) <= 1000000 ) THEN  
                    wdetail2.baseprm = "18900".
                ELSE IF (deci(wdetail2.si) >= 1100000 ) AND (deci(wdetail2.si) <= 1300000 ) THEN  
                    wdetail2.baseprm = "19550".
            END.
            ELSE DO:
                IF wdetail2.vehuse = "เก๋ง" THEN DO:
                    IF (deci(wdetail2.si) >= 450000 ) AND (deci(wdetail2.si) <= 900000 ) THEN  wdetail2.baseprm = "15224".
                END.
                ELSE DO:
                    IF (deci(wdetail2.si) >= 375000 ) AND (deci(wdetail2.si) <= 750000 ) THEN  wdetail2.baseprm = "14924".
                END.
            END.
        END.  /*kridtiya i. A54-0335 */
        /*Add BY Kridtiya i. a54-0271....*/
    END.
END.
RUN Pro_assign3.
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
DEFINE VAR n_len_c AS INTE INIT 0.                   /*kridtiya i. A53-0317...*/
DEFINE VAR n_cha_no AS CHAR FORMAT "x(25)" INIT "".  /*kridtiya i. A53-0317...*/

ASSIGN num = 1
    fi_process  = "Create data to wdetail TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.

FOR EACH wdetail2 .
    ASSIGN 
        wdetail2.id = string(num)
        /*wdetail2.policy = "1" + wdetail2.policy*/ /*A54-0271*/
        /*wdetail2.policy = "0" + wdetail2.policy     /*A54-0271*/*/ /*A55-0251 */
        wdetail2.policy = "0" + wdetail2.Insurancerefno              /*A55-0251 */   
        num = num + 1.
END.
FOR EACH wdetail2 .
    IF (wdetail2.id = "ID") OR (DECI(wdetail2.id) < 0 ) THEN NEXT.
    ELSE DO:
        /*IF INDEX(wdetail2.policy,"tas-") NE 0 THEN DO:*/                                          /*A54-0335*/
        /*comment by Kridtiya i. A55-0251...
        IF ((INDEX(wdetail2.policy,"tas-") NE 0 ) AND ( ra_compatyp = 1 )) OR
        ((INDEX(wdetail2.policy,"tpib-") NE 0 ) AND (ra_compatyp = 2)) THEN DO:                 /*A54-0335*/
        end...comment by Kridtiya i. A55-0251...*/                
        ASSIGN  expyear = deci(wdetail2.comyear) + 1 
            n_titlenam  = TRIM(wdetail2.insnam)
            n_name01    = "" . 
        FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno = "999" AND
            index(trim(n_titlenam),brstat.msgcode.MsgDesc) > 0    NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL brstat.msgcode THEN  
            ASSIGN  
            n_name01    = trim(SUBSTR(n_titlenam,LENGTH(brstat.msgcode.MsgDesc) + 1))
            n_titlenam  =  trim(brstat.msgcode.branch) .
        ELSE ASSIGN n_name01 = TRIM(wdetail2.insnam)
            n_titlenam = "คุณ"
            .
        IF ( R-INDEX(TRIM(n_titlenam),"จก.")     <> 0 ) OR (R-INDEX(TRIM(n_titlenam),"จำกัด")      <> 0 ) OR  
           ( R-INDEX(TRIM(n_titlenam),"(มหาชน)") <> 0 ) OR (R-INDEX(TRIM(n_titlenam),"INC.")       <> 0 ) OR
           ( R-INDEX(TRIM(n_titlenam),"CO.")     <> 0 ) OR (R-INDEX(TRIM(n_titlenam),"LTD.")       <> 0 ) OR 
           ( R-INDEX(TRIM(n_titlenam),"LIMITED") <> 0 ) OR (INDEX(TRIM(n_titlenam),"บริษัท")       <> 0 ) OR 
           ( INDEX(TRIM(n_titlenam),"บ.")        <> 0 ) OR (INDEX(TRIM(n_titlenam),"บจก.")         <> 0 ) OR 
           ( INDEX(TRIM(n_titlenam),"หจก.")      <> 0 ) OR (INDEX(TRIM(n_titlenam),"หสน.")         <> 0 ) OR 
           ( INDEX(TRIM(n_titlenam),"บรรษัท")    <> 0 ) OR (INDEX(TRIM(n_titlenam),"มูลนิธิ")      <> 0 ) OR 
           ( INDEX(TRIM(n_titlenam),"ห้าง")      <> 0 ) OR (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วน") <> 0 ) OR 
           ( INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วนจำกัด") <> 0 ) OR (INDEX(TRIM(n_titlenam),"ห้างหุ้นส่วนจำก")   <> 0 ) OR  
           ( INDEX(TRIM(n_titlenam),"และ/หรือ")          <> 0 ) THEN 
                  ASSIGN wdetail2.NAME2 = "(" + trim(wdetail2.NAME2) + ")".

        FIND FIRST wdetail WHERE wdetail.policy = wdetail2.policy NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            CREATE wuppertxt2.
            /*add A57-0159 */
            FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno = "999" AND
                index(trim(wdetail2.insnam),brstat.msgcode.MsgDesc) > 0    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL brstat.msgcode THEN  ASSIGN wdetail.tiname  =  trim(brstat.msgcode.branch).
            ELSE wdetail.tiname = "คุณ".
            ASSIGN                        /*policy line : 70       */
                n_len_c             = 0   /*kridtiya i. A53-0317...*/
                n_cha_no            = ""  /*kridtiya i. A53-0317...*/
                n_len_c             = length(trim(wdetail2.chasno))  /*kridtiya i. A53-0317...*/
                /* n_index             = INDEX(wdetail2.insnam," ")  + 1
                n_index2            = LENGTH(wdetail2.insnam) - n_index + 1 */
                wdetail.seat        = IF wdetail2.vehuse = "เก๋ง" THEN "7" ELSE "5"
                wdetail.brand       = "ISUZU"
                wdetail.caryear     = string(fi_bchyr)    /*ปีรถปัจจุบัน*/
                /*wdetail.poltyp      = IF substr(wdetail2.policy,1,1) = "0" THEN "72" ELSE "70" */ /*A54-0271*/
                wdetail.poltyp      = IF substr(wdetail2.policy,1,1) = "0" THEN "70" ELSE "72"      /*A54-0271*/
                /*wdetail.policy      = "0" + substring(wdetail2.policy,2,4) + substring(wdetail2.policy,11,LENGTH(wdetail2.policy) - 10 )*/
                wdetail.policy      = wdetail2.policy
                wdetail.comdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + wdetail2.comyear     
                wdetail.expdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + STRING(expyear)   
                /*wdetail.insnam      = SUBSTRING(wdetail2.insnam,n_index,n_index2)  + " " + wdetail2.NAME2*//*A54-0200*/
                wdetail.tiname      = trim(n_titlenam)       /*A57-0159*/
                wdetail.insnam      = trim(n_name01)   + " " + TRIM(wdetail2.NAME2)   /*A54-0200*/ 
                wdetail.ICNO        = trim(wdetail2.ICNO)         /*A56-0211*/
                /*Kridtiya i. A53-0180
                wdetail.iadd1       = "1088 ถ.วิภาวดีรังสิต" 
                wdetail.iadd2       = "แขวงจตุจักร เขตจตุจักร"
                wdetail.iadd3       = "กทม. 10900"
                wdetail.iadd4       = ""*/
                /*Kridtiya i. A53-0180*/
                wdetail.name2       = wdetail2.dealer_name2 
                wdetail.iadd1       = wdetail2.address
                wdetail.iadd2       = wdetail2.tambon  
                wdetail.iadd3       = wdetail2.amper   
                wdetail.iadd4       = wdetail2.country + " " + wdetail2.post  /*Kridtiya i. A53-0180*/
                /*wdetail.subclass    = IF wdetail2.vehuse = "เก๋ง" THEN "110" ELSE "210"*/ /*A56-0353*/
                wdetail.subclass    = IF (index(wdetail2.model,"mu-x") <> 0 ) THEN "110" ELSE IF wdetail2.vehuse = "เก๋ง" THEN "110" ELSE "210" /*A56-0353*/
                wdetail.model       = wdetail2.model 
                wdetail.cc          = wdetail2.cc
                /*wdetail.vehreg      = "/" + substr(wdetail2.chasno,1,2) + " " + substr(wdetail2.chasno,3,LENGTH(wdetail2.chasno) - 2 )*//*kridtiya i. A53-0317...*/
                /*kridtiya i. A53-0317...*/
                wdetail.chasno      = trim(wdetail2.chasno) 
               /*n_cha_no            = substr(trim(wdetail2.chasno),n_len_c - 7 ) */
                /*wdetail.vehreg      = "/" + substr(n_cha_no,1,2) + " " + substr(n_cha_no,3)*//*A56-0245*/
                wdetail.vehreg      = "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 )  /*A56-0245*/
                /*kridtiya i. A53-0317...*/
                wdetail.engno       = substr(wdetail2.engno,1,2) + " " + substr(wdetail2.engno,3,LENGTH(wdetail2.engno)) 
                /*wdetail.chasno      = substr(wdetail2.chasno,1,2) + " " + substr(wdetail2.chasno,3,LENGTH(wdetail2.chasno) - 2 )*//*kridtiyai. A53-0317*/
                wdetail.vehuse      = "1"
                /*A54-0271
                wdetail.garage   = "H" 
                wdetail.covcod      = IF substr(wdetail2.policy,1,1) = "0" THEN "t" ELSE "1" 
                A54-0271*/
                /*A54-0271*/
                /*wdetail.garage      = "H"   /* A54-0271 */ */
                wdetail.garage      = "G"   /* A54-0271 */ 
                wdetail.stk         = trim(wdetail2.stk)
                wuppertxt2.stk      = trim(wdetail2.stk)
                wdetail.covcod      = IF substr(wdetail2.policy,1,1) = "1" THEN "t" ELSE "1" 
                /*A54-0271*/
                wdetail.si          = wdetail2.si
                wdetail.prempa      = fi_pack
                wdetail.branch      = wdetail2.branch 
                wdetail.benname     = wdetail2.financename2
                wdetail.volprem     = wdetail2.baseprm
                wdetail.comment     = ""
                wdetail.finint      = wdetail2.delerco
                wdetail.agent       = fi_agent     
                wdetail.producer    = fi_producer  
                wdetail.entdat      = string(TODAY)      /*entry date*/
                wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
                wdetail.trandat     = STRING (TODAY)     /*tran date*/
                wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
                wdetail.n_IMPORT    = "IM"
                wdetail.n_EXPORT    = "" 
                wdetail.n_telreq    = wdetail2.telreq     /* A57-0260 */
                wdetail.inscod      = wdetail2.typepay    /*add Kridtiya i. A53-0183 ...vatcode*/
                wdetail.cedpol      = substr(wdetail2.policy,2,LENGTH(wdetail2.policy) - 1 )
                wdetail.revday      = wdetail2.receivedDay + "/" + wdetail2.receivedMonth + "/" + wdetail2.receivedYear .
        END.
        ASSIGN 
            wdetail2.policy = "1" + substr(wdetail2.policy,2,LENGTH(wdetail2.policy) - 1 ).
        FIND FIRST wdetail WHERE wdetail.policy = wdetail2.policy NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            /*CREATE wuppertxt2.*/
            ASSIGN
                n_len_c             = 0   /*kridtiya i. A53-0317...*/
                n_cha_no            = ""  /*kridtiya i. A53-0317...*/
                n_len_c             = length(trim(wdetail2.chasno))  /*kridtiya i. A53-0317...*/
                /*n_index             = INDEX(wdetail2.insnam," ")  + 1
                n_index2            = LENGTH(wdetail2.insnam) - n_index + 1 */
                wdetail.seat        = IF wdetail2.vehuse = "เก๋ง" THEN "7" ELSE "5"
                wdetail.brand       = "isuzu"
                wdetail.caryear     = string(fi_bchyr)     /*ปีรถปัจจุบัน*/
                /*wdetail.poltyp      = IF substr(wdetail2.policy,1,1) = "0" THEN "72" ELSE "70" *//*A54-0271 */
                wdetail.poltyp      = IF substr(wdetail2.policy,1,1) = "0" THEN "70" ELSE "72"     /*A54-0271 */
                /*wdetail.policy      = substring(wdetail2.policy,1,5) + substring(wdetail2.policy,11,LENGTH(wdetail2.policy) - 10 )*/
                wdetail.policy      = wdetail2.policy
                wuppertxt2.policydup = wdetail2.policy
                wdetail.comdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + wdetail2.comyear     
                wdetail.expdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + STRING(expyear)   
                /*wdetail.insnam      = SUBSTRING(wdetail2.insnam,n_index,n_index2)  + " " + wdetail2.NAME2*//*A54-0200*/
                wdetail.tiname      = trim(n_titlenam)       /*A57-0159*/
                wdetail.insnam      = trim(n_name01)  + " " + trim(wdetail2.NAME2)  /*A54-0200*/
                wdetail.ICNO        = wdetail2.ICNO         /*A56-0211*/
                /*Kridtiya i. A53-0180....
                wdetail.iadd1       = "1088 ถ.วิภาวดีรังสิต แขวงจตุจักร" 
                wdetail.iadd2       = "เขตจตุจักร กทม. 10900"
                wdetail.iadd3       = ""
                wdetail.iadd4       = ""*/
                /*Kridtiya i. A53-0180....*/
                wdetail.name2       = wdetail2.dealer_name2 
                wdetail.iadd1       = wdetail2.address
                wdetail.iadd2       = wdetail2.tambon  
                wdetail.iadd3       = wdetail2.amper   
                wdetail.iadd4       = wdetail2.country + " " + wdetail2.post 
                    /*Kridtiya i. A53-0180....*/
                /*wdetail.subclass    = IF wdetail2.vehuse = "เก๋ง" THEN "110" ELSE "210"*/ /*A56-0353*/
                wdetail.subclass    = IF (index(wdetail2.model,"mu-x") <> 0 ) THEN "110" ELSE IF wdetail2.vehuse = "เก๋ง" THEN "110" ELSE "210" /*A56-0353*/
                wdetail.model       = wdetail2.model 
                wdetail.cc          = wdetail2.cc
                /*wdetail.vehreg      = "/" + substr(wdetail2.chasno,1,2) + " " + substr(wdetail2.chasno,3,LENGTH(wdetail2.chasno) - 2 )
                wdetail.engno       = substr(wdetail2.engno,1,2) + " " + substr(wdetail2.engno,3,LENGTH(wdetail2.engno))
                wdetail.chasno      = substr(wdetail2.chasno,1,2) + " " + substr(wdetail2.chasno,3,LENGTH(wdetail2.chasno) - 2 )*/
                /*wdetail.vehreg      = "/" + substr(wdetail2.chasno,1,2) + " " + substr(wdetail2.chasno,3,LENGTH(wdetail2.chasno) - 2 )*//*kridtiya i. A53-0317...*/
                /*kridtiya i. A53-0317...*/
                wdetail.chasno      = trim(wdetail2.chasno)  
                /*n_cha_no            = substr(trim(wdetail2.chasno),n_len_c - 7 ) /*A56-0245*/
                wdetail.vehreg      = "/" + substr(n_cha_no,1,2) + " " + substr(n_cha_no,3)*//*A56-0245*/
                wdetail.vehreg      = "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 8 )  /*A56-0245*/
                /*kridtiya i. A53-0317...*/
                wdetail.engno       = substr(wdetail2.engno,1,2) + " " + substr(wdetail2.engno,3,LENGTH(wdetail2.engno)) 
                /*wdetail.chasno      = substr(wdetail2.chasno,1,2) + " " + substr(wdetail2.chasno,3,LENGTH(wdetail2.chasno) - 2 )*//*kridtiyai. A53-0317*/
                wdetail.vehuse      = "1"
                wdetail.garage      = ""
                /* wdetail.covcod      = IF substr(wdetail2.policy,1,1) = "0" THEN "t" ELSE "1" *//*a54-0271*/
                wdetail.covcod      = IF substr(wdetail2.policy,1,1) = "1" THEN "t" ELSE "1" /*a54-0271*/
                wdetail.stk         = trim(wdetail2.stk)
                /*wuppertxt2.stk      = trim(wdetail2.stk)*/
                wdetail.si          = wdetail2.si
                wdetail.prempa      = fi_pack
                wdetail.branch      = wdetail2.branch 
                wdetail.benname     = wdetail2.financename2
                wdetail.volprem     = wdetail2.baseprm
                wdetail.comment     = ""
                wdetail.n_telreq    = wdetail2.telreq     /* A57-0260 */
                wdetail.finint      = wdetail2.delerco
                wdetail.agent       = fi_agent
                wdetail.producer    = fi_producer 
                wdetail.entdat      = string(TODAY)      /*entry date*/
                wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
                wdetail.trandat     = STRING (TODAY)     /*tran date*/
                wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
                wdetail.n_IMPORT    = "IM"
                wdetail.n_EXPORT    = "" 
                wdetail.inscod      = wdetail2.typepay    /*add Kridtiya i. A53-0183 ...vatcode*/
                wdetail.cedpol      = substr(wdetail2.policy,2,LENGTH(wdetail2.policy) - 1 )
                wdetail.revday      = wdetail2.receivedDay + "/" + wdetail2.receivedMonth + "/" + wdetail2.receivedYear .
        END.  /*avail 1*/
        /*END.  /*index*/*/
    END.  /*id*/
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
    
END. */ 
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
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN fi_process  = "Create data base_ TAS/TPIB.......[ISUZU]   " + wdetail.policy  .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.
IF wdetail.poltyp = "v70" THEN DO:
    /*IF (wdetail.subclass = "110") OR (wdetail.subclass = "v110") THEN aa = 7600.         /*A54-0271*/
    ELSE IF (wdetail.subclass = "210") OR (wdetail.subclass = "v210") THEN aa = 12000. */  /*A54-0271*/
    IF (wdetail.subclass = "110") OR (wdetail.subclass = "v110") THEN DO: 
        ASSIGN aa = 7600.  
        /*RUN proc_dsp_ncb1.*//*comment A54-0335*/
        IF ra_compatyp = 1 THEN RUN proc_dsp_ncb1.   /*add A54-0335*/
        ELSE RUN proc_dsp_ncb2.                      /*add A54-0335*/
    END.
    ELSE IF (wdetail.subclass = "210") OR (wdetail.subclass = "v210") THEN DO: 
        ASSIGN aa = 12000.
        /*RUN proc_dsp_ncb1.*//*comment A54-0335*/
        IF ra_compatyp = 1 THEN RUN proc_dsp_ncb1.   /*add A54-0335*/
        ELSE RUN proc_dsp_ncb2.                      /*add A54-0335*/
    END.
    ELSE DO: 
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ASSIGN  chk     = NO
        NO_basemsg  = " "
        nv_baseprm  = aa
        wdetail.drivnam  = "N"
       /* nv_dss_per  = 0 */
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
            nv_41 = DECI(wdetail.no_41)
            nv_42 = DECI(wdetail.no_42)
            nv_43 = DECI(wdetail.no_43)
            nv_seat41 = integer(wdetail.seat41). 
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
     /*RUN proc_dsp_ncb.*/
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
         Assign  nv_dss_per = per .  */
         nv_dsspcvar   = " ".
         IF  nv_dss_per   <> 0  THEN
             Assign
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
         END.
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
ASSIGN
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
    /*ASSIGN  
        nv_simat  = DECI(wdetail.si) - (DECI(wdetail.si) * 50 / 100 )
        nv_simat1 = DECI(wdetail.si) + (DECI(wdetail.si) * 50 / 100 )  .*/
    /*Comment by kridtiya i. A55-0107....
    IF wdetail.model = "cab4"  THEN n_model = "Hi-Lander".
    IF wdetail.model = "CAB4 HILANDER"  THEN n_model = "Hi-Lander".
    IF (wdetail.model = "CAB4 RODEO") OR (wdetail.model = "RODEO")  THEN n_model = "RODEO".
    IF wdetail.model = "MU7"  THEN n_model = "MU-7".
    IF wdetail.model = "SPACECAB HILANDER"  THEN n_model = "Extended Cab SX".
    IF wdetail.model = "SPACECAB"  THEN n_model = "Extended Cab SX".
    IF wdetail.model = "SPARK"  THEN n_model = "Single Cab EXL".
    end... by kridtiya i. A55-0107....*/
    /*add A55-0107 ...*/
    FIND FIRST stat.insure USE-INDEX insure01  WHERE   
        stat.insure.compno  = fi_mocode        AND          
        stat.insure.fname   = wdetail.model    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL insure THEN  
         ASSIGN n_model =  stat.insure.lname   .
    ELSE ASSIGN n_model =  wdetail.model .
    /*Add A55-0107 ...*/
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  TRIM(wdetail.prempa) + wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
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
        stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)       No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN nv_modcod =  stat.maktab_fil.modcod                                    
        nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.redbook  =  stat.maktab_fil.modcod  .
    ELSE ASSIGN nv_modcod = "".
    IF nv_modcod = ""  THEN  RUN proc_maktab.
END. 

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
        /*IF wdetail.renpol <> " " THEN RUN proc_renew. */ /*a54-0271 NOT RENEW */
        /*IF wdetail.poltyp = "v72"  THEN DO:
                RUN proc_72.
                RUN proc_policy. 
                RUN proc_722.
                RUN proc_723 (INPUT  s_recid1,       
                              INPUT  s_recid2,
                              INPUT  s_recid3,
                              INPUT  s_recid4,
                              INPUT-OUTPUT nv_message).
                RUN proc_chktest2.      
                RUN proc_chktest3.      
                RUN proc_chktest4.
        END.
        ELSE DO:
            RUN proc_chktest0.
            RUN proc_policy.    /*ใช้ร่วมกัน 70/72*/
            RUN proc_chktest2.      
            RUN proc_chktest3.      
            RUN proc_chktest4.   
        END.  */
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
ASSIGN fi_process  = "Create data sic_bran.uwm120,uwm130,uwm301 TAS/TPIB.......[ISUZU]  " + wdetail.policy  .  /*a55-0051*/
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
             sic_bran.uwm301.itmdel    = NO.
             sic_bran.uwm301.prmtxt    = IF wdetail.poltyp = "v70" THEN "คุ้มครองอุปกรณ์ตกแต่งราคาไม่เกิน 20,000 บาท" ELSE "" .
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
             /* Add A55-0107 
             IF wdetail.model = "cab4"  THEN n_model = "Hi-Lander".
             IF wdetail.model = "CAB4 HILANDER"  THEN n_model = "Hi-Lander".
             IF (wdetail.model = "CAB4 RODEO") OR (wdetail.model = "RODEO")  THEN n_model = "RODEO".
             IF wdetail.model = "MU7"  THEN n_model = "MU-7".
             IF wdetail.model = "SPACECAB HILANDER"  THEN n_model = "Extended Cab SX".   
             IF wdetail.model = "SPACECAB"  THEN n_model = "Extended Cab SX".            
             IF wdetail.model = "SPARK"  THEN n_model = "Single Cab EXL".
             end...Add A55-0107 */ 
             /* Add A55-0107 */
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
         IF wdetail.poltyp = "v72" THEN DO:
                 IF wdetail.subclass = "210" THEN wdetail.subclass = "140A".
         END.
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
ASSIGN fi_process  = "Create data base_premium... TAS/TPIB.......[ISUZU]   " + wdetail.policy  .  /*a55-0051*/
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

ASSIGN fi_process  = "Create data to premium,stamp,vat TAS/TPIB.......[ISUZU]" .  /*a55-0051*/
DISP  fi_process WITH FRAM fr_main.

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
    FIND FIRST buwm100 WHERE 
        substr(buwm100.policy,2,len) = SUBSTR(wdetail.policy,2,len) AND
        buwm100.policy    <> wdetail.policy  NO-LOCK.
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
/*modify by   : Kridtiya i. A53-0106 date . 08/03/2010 ปรับการให้ค่า code redbook. ให้ถูกต้อง*/
/*modify by   : Kridtiya i. A53-0156 date . 19/04/2010 เปลี่ยนชื่อบริษัทจากและ / หรือ บริษัท ไทยออโต้เซลส์ จำกัด 
               เป็น และ/ หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด เปลี่ยน TAS เห็น TIL */
/*Modify by : Kridtiya i. A53-0183 08/06/2010 ปรับแวทโค๊ดให้รับค่าจาก field stat.insure.vatcode */
/*modify by : Kridtiya i. A53-0317 ปรับแสดงค่าเลขทะเบียนรถโดยให้รับจากเลขตัวถัง 8 ตัวสุดท้าย*/
/*modify by : Kridtiya i. A54-0011 เพิ่ม Text F17,F18 */
/*modify by : Kridtiya i. A54-0200 ตัดคำนำหน้าชื่อผู้เอาประกันภัย*/
/*modify by : Kridtiya i. A54-0271 เช็คสาขาเป็นค่าว่างไม่ให้นำเข้าระบบ เพิ่มช่วงทุน */
/*modify by : Kridtiya i. A54-0335 แยกไฟล์นำเข้า TAS/TPIB */
/*modify by : Kridtiya i. A55-0051 ปรับส่วนการแปลงชื่อผู้รับผลประโยชน์        */
/*modify by : Kridtiya i. A55-0107 ปรับส่วนการหารหัสรถ จากเดิมให้ค่ารุ่มรถโดยตรง
                                   ปรับเป็นเซตรุ่นรถที่ต้องการใช้งานที่ระบบ
                                   Setup Company and deler code              */
/*modify by : Kridtiya i. A55-0251 date. 07/08/2012 ปรับการรับเลขที่สัญญา TAS/TPIB            */
/*modify by : Kridtiya i. A58-0136 date. 03/04/2015 ปรับขนาดที่ อยู่ */
                                   

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_definiton C-Win 
PROCEDURE proc_definiton :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */  
/*programid   : wgwtsgen.w                                              */ 
/*programname : load text file TAS to GW                                */ 
/* Copyright    : Safety Insurance Public Company Limited  บริษัท ประกันคุ้มภัย จำกัด (มหาชน) */  
/*create by   : Kridtiya i. A52-0172   date . 08/07/2009ปรับโปรแกรมให้สามารถนำเข้า text file TAS to GW system   */ 
/*copy write  : wgwargen.w                                              */ 
/*modify by   : Kridtiya i. A56-0211 เพิ่มเลขที่บัตรประชาชน             */
/*modify by   : Kridtiya i. A56-0245 add F18                            */
/*modify by   : Kridtiya i. A56-0353 add base premium model MU-X        */
/*Modify by   : Kridtiya i. A56-0047  Add check sicsyac.xmm600.clicod = "IN"   */
/*Modify by   : Kridtiya i. A57-0159  Add และ/หรือ ให้แสดงชื่อ ดีเลอร์   */
/*Modify by   : kridtiya i. A57-0260  ปรับเลขแคมเปญ*/
/*Modify by   : kridtiya i. A57-0303  เพิ่ม no 30 */
/*modify by   : Kridtiya i. A57-0415 เพิ่มตัวแปรแสดงชื่อสาขา,ภาคสาขา                */
/*modify by   : Kridtiya i. A58-0092 เพิ่มคำนำหน้าลูกค้า,และรับค่าเลขเคมเปญจากพารามิเตอร์*/
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
/*comment by Kridtiya i....a54-0271....
ASSIGN 
    WDETAIL.NCB = "".
IF wdetail.subclass = "110" THEN DO:
    IF (wdetail.model <> "MU7") AND (wdetail.model <> "MU-7") THEN DO:
        IF wdetail.si = "470000" THEN ASSIGN nv_dss_per = 20.05.  
        IF wdetail.si = "480000" THEN ASSIGN nv_dss_per = 21.21.  
        IF wdetail.si = "490000" THEN ASSIGN nv_dss_per = 22.34.  
        IF wdetail.si = "500000" THEN ASSIGN nv_dss_per = 23.44.  
        IF wdetail.si = "510000" THEN ASSIGN nv_dss_per = 24.16.  
        IF wdetail.si = "520000" THEN ASSIGN nv_dss_per = 24.86.  
        IF wdetail.si = "530000" THEN ASSIGN nv_dss_per = 25.54.  
        IF wdetail.si = "540000" THEN ASSIGN nv_dss_per = 26.22.  
        IF wdetail.si = "550000" THEN ASSIGN nv_dss_per = 26.88.  
        IF wdetail.si = "560000" THEN ASSIGN nv_dss_per = 27.53.  
        IF wdetail.si = "570000" THEN ASSIGN nv_dss_per = 28.18.  
        IF wdetail.si = "580000" THEN ASSIGN nv_dss_per = 28.81.  
        IF wdetail.si = "590000" THEN ASSIGN nv_dss_per = 29.42.  
        IF wdetail.si = "600000" THEN ASSIGN nv_dss_per = 30.03.  
        IF wdetail.si = "610000" THEN ASSIGN nv_dss_per = 30.63.  
        IF wdetail.si = "620000" THEN ASSIGN nv_dss_per = 31.21.  
        IF wdetail.si = "630000" THEN ASSIGN nv_dss_per = 31.79.  
        IF wdetail.si = "640000" THEN ASSIGN nv_dss_per = 32.36.  
        IF wdetail.si = "650000" THEN ASSIGN nv_dss_per = 32.92.  
        IF wdetail.si = "660000" THEN ASSIGN nv_dss_per = 31.23.  
        IF wdetail.si = "670000" THEN ASSIGN nv_dss_per = 31.78.  
        IF wdetail.si = "680000" THEN ASSIGN nv_dss_per = 32.33.  
        IF wdetail.si = "690000" THEN ASSIGN nv_dss_per = 32.87.  
        IF wdetail.si = "700000" THEN 
            ASSIGN nv_dss_per = 16.76
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "710000" THEN 
            ASSIGN nv_dss_per = 17.41
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "720000" THEN 
            ASSIGN nv_dss_per = 18.06
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "730000" THEN 
            ASSIGN nv_dss_per = 18.69
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "740000" THEN 
            ASSIGN nv_dss_per = 19.32
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "750000" THEN 
            ASSIGN nv_dss_per = 19.93
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "760000" THEN 
            ASSIGN nv_dss_per = 20.54
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "770000" THEN 
            ASSIGN nv_dss_per = 21.13
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "780000" THEN 
            ASSIGN nv_dss_per = 21.72
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "790000" THEN 
            ASSIGN nv_dss_per = 22.30
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "800000" THEN 
            ASSIGN nv_dss_per = 22.87
            WDETAIL.NCB = "20.00".
    END.
    ELSE DO:
        IF wdetail.si = "750000" THEN ASSIGN nv_dss_per = 27.60.
        IF wdetail.si = "760000" THEN ASSIGN nv_dss_per = 28.15.
        IF wdetail.si = "770000" THEN ASSIGN nv_dss_per = 28.69.
        IF wdetail.si = "780000" THEN ASSIGN nv_dss_per = 29.22.
        IF wdetail.si = "790000" THEN ASSIGN nv_dss_per = 29.75.
        IF wdetail.si = "800000" THEN ASSIGN nv_dss_per = 30.26.
        IF wdetail.si = "810000" THEN ASSIGN nv_dss_per = 30.77.
        IF wdetail.si = "820000" THEN ASSIGN nv_dss_per = 31.27.
        IF wdetail.si = "830000" THEN ASSIGN nv_dss_per = 31.77.
        IF wdetail.si = "840000" THEN ASSIGN nv_dss_per = 32.25.
        IF wdetail.si = "850000" THEN ASSIGN nv_dss_per = 32.73.
        IF wdetail.si = "860000" THEN ASSIGN nv_dss_per = 29.36.
        IF wdetail.si = "870000" THEN ASSIGN nv_dss_per = 29.85.
        IF wdetail.si = "880000" THEN ASSIGN nv_dss_per = 30.34.
        IF wdetail.si = "890000" THEN ASSIGN nv_dss_per = 30.82.
        IF wdetail.si = "900000" THEN ASSIGN nv_dss_per = 31.29.
        IF wdetail.si = "910000" THEN ASSIGN nv_dss_per = 31.76.
        IF wdetail.si = "920000" THEN ASSIGN nv_dss_per = 32.22.
        IF wdetail.si = "930000" THEN ASSIGN nv_dss_per = 32.67.
        IF wdetail.si = "940000" THEN 
            ASSIGN nv_dss_per = 16.40
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "950000" THEN 
            ASSIGN nv_dss_per = 16.96
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "960000" THEN 
            ASSIGN nv_dss_per = 17.50
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "970000" THEN 
            ASSIGN nv_dss_per = 18.04
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "980000" THEN 
            ASSIGN nv_dss_per = 18.57
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "990000" THEN 
            ASSIGN nv_dss_per = 19.10
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "1000000" THEN 
            ASSIGN nv_dss_per = 19.61
            WDETAIL.NCB = "20.00".
        IF wdetail.si = "1050000" THEN 
        ASSIGN nv_dss_per = 22.35
        WDETAIL.NCB = "20.00".
    IF wdetail.si = "1100000" THEN 
        ASSIGN nv_dss_per = 24.90
        WDETAIL.NCB = "20.00".
    IF wdetail.si = "1150000" THEN 
        ASSIGN nv_dss_per = 27.30
        WDETAIL.NCB = "20.00".
    IF wdetail.si = "1200000" THEN 
        ASSIGN nv_dss_per = 29.54
        WDETAIL.NCB = "20.00".
    END.
END.
ELSE DO:
    IF wdetail.si = "340000" THEN ASSIGN nv_dss_per = 15.72. 
    IF wdetail.si = "350000" THEN ASSIGN nv_dss_per = 16.83. 
    IF wdetail.si = "360000" THEN ASSIGN nv_dss_per = 17.92. 
    IF wdetail.si = "370000" THEN ASSIGN nv_dss_per = 18.97. 
    IF wdetail.si = "380000" THEN ASSIGN nv_dss_per = 20.00. 
    IF wdetail.si = "390000" THEN ASSIGN nv_dss_per = 21.01. 
    IF wdetail.si = "400000" THEN ASSIGN nv_dss_per = 21.99. 
    IF wdetail.si = "410000" THEN ASSIGN nv_dss_per = 22.94. 
    IF wdetail.si = "420000" THEN ASSIGN nv_dss_per = 23.88. 
    IF wdetail.si = "430000" THEN ASSIGN nv_dss_per = 24.79. 
    IF wdetail.si = "440000" THEN ASSIGN nv_dss_per = 25.68. 
    IF wdetail.si = "450000" THEN ASSIGN nv_dss_per = 26.54. 
    IF wdetail.si = "460000" THEN ASSIGN nv_dss_per = 27.39. 
    IF wdetail.si = "470000" THEN ASSIGN nv_dss_per = 28.22. 
    IF wdetail.si = "480000" THEN ASSIGN nv_dss_per = 29.03. 
    IF wdetail.si = "490000" THEN ASSIGN nv_dss_per = 29.82. 
    IF wdetail.si = "500000" THEN ASSIGN nv_dss_per = 30.59. 
    IF wdetail.si = "510000" THEN ASSIGN nv_dss_per = 31.35. 
    IF wdetail.si = "520000" THEN ASSIGN nv_dss_per = 32.09. 
    IF wdetail.si = "530000" THEN ASSIGN nv_dss_per = 32.82. 
    IF wdetail.si = "540000" THEN ASSIGN nv_dss_per = 31.24. 
    IF wdetail.si = "550000" THEN ASSIGN nv_dss_per = 31.95. 
    IF wdetail.si = "560000" THEN ASSIGN nv_dss_per = 32.66. 
    IF wdetail.si = "570000" THEN ASSIGN nv_dss_per = 33.34. 
    IF wdetail.si = "580000" THEN 
        ASSIGN nv_dss_per = 17.53
        WDETAIL.NCB = "20.00".
    IF wdetail.si = "590000" THEN 
        ASSIGN nv_dss_per = 18.35
        WDETAIL.NCB = "20.00".
    IF wdetail.si = "600000" THEN 
        ASSIGN nv_dss_per = 19.17
        WDETAIL.NCB = "20.00".
    IF wdetail.si = "610000" THEN 
        ASSIGN nv_dss_per = 19.96
        WDETAIL.NCB = "20.00".
    IF wdetail.si = "620000" THEN 
        ASSIGN nv_dss_per = 20.74
        WDETAIL.NCB = "20.00".
    IF wdetail.si = "630000" THEN 
        ASSIGN nv_dss_per = 21.51
        WDETAIL.NCB = "20.00".
    IF wdetail.si = "640000" THEN 
        ASSIGN nv_dss_per = 22.26
        WDETAIL.NCB = "20.00".
    IF wdetail.si = "650000" THEN 
        ASSIGN nv_dss_per = 22.99
        WDETAIL.NCB = "20.00".
END.  end comment by kridtiya i. A54-0271 ........*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam C-Win 
PROCEDURE proc_insnam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_transfer  AS LOGICAL   .
ASSIGN  
    n_insref      = ""  
    n_check       = ""
    nv_insref     = "" 
    nv_transfer   = YES. 
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME     = TRIM(wdetail.insnam)   AND 
    /*sicsyac.xmm600.homebr   = TRIM(wdetail.branch)   NO-ERROR NO-WAIT. *//*A56-0047*/
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
            sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
            sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
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
            sicsyac.xmm600.dval20   = ""   .     
       
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
        sicsyac.xmm600.name     = TRIM(wdetail.insnam)     /*Name Line 1*/
        sicsyac.xmm600.abname   = TRIM(wdetail.insnam)     /*Abbreviated Name*/
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
        ASSIGN sicsyac.xmm600.nphone   = IF R-INDEX(TRIM(wdetail.insnam),"(") <> 0 THEN 
                                             TRIM(wdetail.tiname) + " " + trim(SUBSTR(TRIM(wdetail.insnam),1,r-INDEX(TRIM(wdetail.insnam),"(") - 1 )) 
                                         /*ELSE TRIM(wdetail.insnam) /*New phone no.*/ *//*A58-0092*/
            ELSE TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam)   /*New phone no.*/  /*A58-0092*/
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
            sicsyac.xtm600.acno    = nv_insref               /*Account no.*/
            sicsyac.xtm600.name    = TRIM(wdetail.insnam)    /*Name of Insured Line 1*/
            sicsyac.xtm600.abname  = TRIM(wdetail.insnam)    /*Abbreviated Name*/
            sicsyac.xtm600.addr1   = wdetail.iadd1           /*address line 1*/
            sicsyac.xtm600.addr2   = wdetail.iadd2           /*address line 2*/
            sicsyac.xtm600.addr3   = wdetail.iadd3           /*address line 3*/
            sicsyac.xtm600.addr4   = wdetail.iadd4           /*address line 4*/
            sicsyac.xtm600.name2   = ""                      /*Name of Insured Line 2*/ 
            sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)    /*Title*/
            sicsyac.xtm600.name3   = ""                      /*Name of Insured Line 3*/
            sicsyac.xtm600.fname   = "" .                    /*First Name*/
    END.
END.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
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
/*
ASSIGN
    nv_simat = 0
    nv_simat1 = 0
    nv_simat = DECI(wdetail.si) - (DECI(wdetail.si) * 20 / 100 )
    nv_simat1 = DECI(wdetail.si) + (DECI(wdetail.si) * 20 / 100 )  .
IF wdetail.model = "cab4"  THEN n_model = "cab4".
IF wdetail.model = "CAB4 HILANDER"  THEN n_model = "cab".
IF (wdetail.model = "CAB4 RODEO") OR (wdetail.model = "RODEO")  THEN n_model = "RODEO".
IF wdetail.model = "MU7"  THEN n_model = "MU-7".
IF wdetail.model = "SPACECAB HILANDER"  THEN n_model = "cab".
IF wdetail.model = "SPACECAB"  THEN n_model = "SPACECAB".
IF wdetail.model = "SPARK"  THEN n_model = "SPARK".
Find LAST stat.maktab_fil Use-index      maktab04          Where
    stat.maktab_fil.makdes   =     nv_makdes                And                  
    index(stat.maktab_fil.moddes,n_model) <> 0             And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
    stat.maktab_fil.engine   =     Integer(wdetail.cc)   AND
    /*stat.maktab_fil.sclass   =     "****"        AND*/
    (stat.maktab_fil.si      >=     nv_simat      OR
    stat.maktab_fil.si       <=     nv_simat1 )   AND  
    stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)   
    No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    Assign
        wdetail.redbook =  stat.maktab_fil.modcod                                    
        wdetail.brand   =  stat.maktab_fil.makdes  
        wdetail.model   =  stat.maktab_fil.moddes
        wdetail.cargrp  =  stat.maktab_fil.prmpac
        wdetail.body    =  stat.maktab_fil.body.*/
        /*add A55-0107 ...*/
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
        stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND
        stat.maktab_fil.sclass   =     wdetail.subclass                AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
         stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1  / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)       No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN  
        nv_modcod        =  stat.maktab_fil.modcod                                    
        nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.redbook  =  stat.maktab_fil.modcod  .
    /*Add A55-0107 ...*/
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
        wdetail2.id               
        wdetail2.TASDay           
        wdetail2.TASMonth         
        wdetail2.TASYear          
        wdetail2.policy           
        wdetail2.TASreceived      
        wdetail2.InsCompany       
        wdetail2.Insurancerefno   
        wdetail2.receivedDay      
        wdetail2.receivedMonth    
        wdetail2.receivedYear     
        wdetail2.insnam          
        wdetail2.NAME2 
        wdetail2.icno   
        wdetail2.address         
        wdetail2.mu              
        wdetail2.soi             
        wdetail2.road            
        wdetail2.tambon          
        wdetail2.amper           
        wdetail2.country         
        wdetail2.post            
        wdetail2.tel             
        wdetail2.model           
        wdetail2.vehuse          
        wdetail2.coulor          
        wdetail2.cc              
        wdetail2.engno           
        wdetail2.chasno          
        wdetail2.nameinsur       
        wdetail2.comday          
        wdetail2.commonth        
        wdetail2.comyear         
        wdetail2.si              
        wdetail2.baseprm         
        wdetail2.stk           
        wdetail2.deler           
        wdetail2.showroom        
        wdetail2.typepay         
        wdetail2.financename     
        wdetail2.requresname     
        wdetail2.requresname2    
        wdetail2.telreq          
        wdetail2.staus           
        wdetail2.REMARK1         
        wdetail2.CHECK1          
        wdetail2.COUNT1 . 
END.   /* repeat  */
RUN  proc_matchfilechk1.
RUN  proc_matchfilechk3.
IF      ra_typeload = 1 THEN Run  proc_matchfilechk4.
ELSE IF ra_typeload = 3 THEN Run  proc_matchfilechk6.
ELSE IF ra_typeload = 4 THEN Run  proc_matchfilechk8.   /* recipt */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk1 C-Win 
PROCEDURE proc_matchfilechk1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>   wdetail2.deler           
                        wdetail2.showroom  
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_benname AS CHAR FORMAT "x(50)".
FOR EACH wdetail2 .
    IF (wdetail2.Insurancerefno = "") THEN NEXT.
    IF wdetail2.id = "" THEN DO:
        IF       wdetail2.financename = "kk"        THEN  wdetail2.financename2 = "ธนาคาร เกียรตินาคิน จำกัด".
        ELSE IF  wdetail2.financename = "T-BANK"    THEN  wdetail2.financename2 = "ธนาคาร ธนชาต จำกัด (มหาชน)".
        ELSE IF  wdetail2.financename = "AYCL"      THEN  wdetail2.financename2 = "บริษัท อยุธยา แคปปิตอล ออโต้ ลีส จำกัด (มหาชน)".
        ELSE IF  wdetail2.financename = "TIL"       THEN  wdetail2.financename2 = "บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด".  /*Kridtiya i. A53-0156*/
        ELSE IF  wdetail2.financename = "TISCO"     THEN  wdetail2.financename2 = "ธนาคารทิสโก้ จำกัด (มหาชน)".
        ELSE IF  wdetail2.financename = "K-Leasing" THEN  wdetail2.financename2 = "บริษัท ลีสซิ่งกสิกรไทย จำกัด".
        ELSE IF  wdetail2.financename = "SCBL"      THEN  wdetail2.financename2 = "ธนาคารไทยพาณิชย์ จำกัด (มหาชน)".
        ELSE IF  wdetail2.financename = "Asia SK"   THEN  wdetail2.financename2 = "บจก.เอเซียเสริมกิจ ลิสซิ่ง".
        ELSE DO:   
            ASSIGN n_benname = "" 
                n_benname = trim(wdetail2.financename).
            IF (n_benname = "0" ) OR (n_benname = "-0" ) OR (n_benname = "" ) OR (n_benname = "-" ) THEN 
                ASSIGN wdetail2.financename = "".
            ELSE DO:
                FIND FIRST stat.company USE-INDEX Company01 WHERE 
                    stat.company.compno = n_benname       NO-ERROR NO-WAIT.
                IF AVAIL  stat.company THEN
                    ASSIGN  n_benname     =  stat.company.name2
                    wdetail2.financename2 = n_benname  .
                ELSE ASSIGN wdetail2.financename2 = wdetail2.financename   .
            END.
        END.
        IF ra_compatyp = 1 THEN DO:  /* type TAS */
            IF wdetail2.vehuse = "เก๋ง" THEN DO:
                IF (index(wdetail2.model,"MU7") <> 0 ) OR (index(wdetail2.model,"MU") <> 0 ) THEN DO:  
                    IF (deci(wdetail2.si) >= 750000 ) AND (deci(wdetail2.si) <= 850000 )  THEN  wdetail2.baseprm = "16155".
                    ELSE IF (deci(wdetail2.si) >= 860000 ) AND (deci(wdetail2.si) <= 1200000 ) THEN  wdetail2.baseprm = "17086".
                END.
                ELSE DO:
                    IF (deci(wdetail2.si) >= 470000 ) AND (deci(wdetail2.si) <= 650000 ) THEN  wdetail2.baseprm = "13828".
                    ELSE IF (deci(wdetail2.si) >= 660000 ) AND (deci(wdetail2.si) <= 800000 ) THEN  wdetail2.baseprm = "14294".
                    ELSE IF (deci(wdetail2.si) >= 810000 ) AND (deci(wdetail2.si) <= 850000 ) THEN  wdetail2.baseprm = "14294". 
                    ELSE IF (deci(wdetail2.si) >= 860000 ) AND (deci(wdetail2.si) <= 900000 ) THEN  wdetail2.baseprm = "14294".
                    ELSE IF (deci(wdetail2.si) >= 910000 ) AND (deci(wdetail2.si) <= 950000 ) THEN  wdetail2.baseprm = "14294".
                END.
            END.
            ELSE DO:
                IF (deci(wdetail2.si) >= 340000 ) AND (deci(wdetail2.si) <= 530000) THEN   wdetail2.baseprm = "13528".
                ELSE IF (deci(wdetail2.si) >= 540000 ) AND (deci(wdetail2.si) <= 650000) THEN   wdetail2.baseprm = "13994".
                ELSE IF (deci(wdetail2.si) >= 660000 ) AND (deci(wdetail2.si) <= 700000) THEN   wdetail2.baseprm = "13994".
                ELSE IF (deci(wdetail2.si) >= 710000 ) AND (deci(wdetail2.si) <= 750000) THEN   wdetail2.baseprm = "13994".
                ELSE IF (deci(wdetail2.si) >= 760000 ) AND (deci(wdetail2.si) <= 800000) THEN   wdetail2.baseprm = "13994".
            END.
        END.      /*end TAS */
        ELSE DO:  /* tpib */
            IF (index(wdetail2.model,"MU-X") <> 0 )  THEN DO:
                IF (deci(wdetail2.si) >= 820000 ) AND (deci(wdetail2.si) <=  1000000 ) THEN   
                    wdetail2.baseprm = "18900".
                ELSE IF (deci(wdetail2.si) > 1000000 ) AND (deci(wdetail2.si) <= 1300000 ) THEN   
                    wdetail2.baseprm = "19550".
            END.    
            ELSE IF wdetail2.vehuse = "เก๋ง" THEN DO:
                IF (deci(wdetail2.si) >= 450000 ) AND (deci(wdetail2.si) <= 900000) THEN   
                    wdetail2.baseprm = "15224".
            END.
            ELSE DO:
                IF (deci(wdetail2.si) >= 375000 ) AND (deci(wdetail2.si) <= 750000) THEN   
                    wdetail2.baseprm = "14924".
            END.
        END.  /* tpib */
    END.
END.
RUN proc_matchfilechk2.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk2 C-Win 
PROCEDURE proc_matchfilechk2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2 .
    IF wdetail2.id = "id" THEN DELETE wdetail2.
    ELSE DO:
        IF wdetail2.mu <> ""   THEN wdetail2.address = wdetail2.address + " " + wdetail2.mu.
        IF wdetail2.soi <> ""  THEN wdetail2.address = wdetail2.address + " " + wdetail2.soi.
        IF wdetail2.road <> "" THEN wdetail2.address = wdetail2.address + " " + wdetail2.road.
        IF wdetail2.country <> ""  THEN DO:
            IF (index(wdetail2.country,"กทม") <> 0 ) OR (index(wdetail2.country,"กรุงเทพ") <> 0 ) THEN 
                ASSIGN wdetail2.tambon  = "แขวง" + wdetail2.tambon 
                wdetail2.amper   = "เขต" + wdetail2.amper.
            ELSE ASSIGN wdetail2.tambon  = "ตำบล" + wdetail2.tambon 
                wdetail2.amper   = "อำเภอ" + wdetail2.amper.
        END.
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno = "TIL"              AND    
            stat.insure.fname  = wdetail2.deler     AND
            stat.insure.lname  = wdetail2.showroom  NO-ERROR NO-WAIT.
        IF AVAIL stat.insure THEN
            ASSIGN wdetail2.branch   = stat.insure.branch
                   wdetail2.delerco  = stat.insure.insno .
        ELSE ASSIGN wdetail2.branch  = ""
            wdetail2.delerco  = "" .
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
ASSIGN num = 1.
FOR EACH wdetail2 .
    IF wdetail2.Insurancerefno = "" THEN DELETE wdetail2.
    ELSE DO:
        ASSIGN 
            wdetail2.id = string(num)
            wdetail2.policy = "0" + TRIM(wdetail2.Insurancerefno)   
            num = num + 1.
    END.
END.
FOR EACH wdetail2 .
    IF wdetail2.id <> "0" THEN DO:
        ASSIGN  expyear = deci(wdetail2.comyear) + 1 .
        FIND FIRST wdetail WHERE wdetail.policy = wdetail2.policy NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN
                wdetail.poltyp      = IF substr(wdetail2.policy,1,1) = "0" THEN "70" ELSE "72"     
                wdetail.policy      = wdetail2.policy
                wdetail.comdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + wdetail2.comyear     
                wdetail.expdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + STRING(expyear)   
                wdetail.insnam      = wdetail2.insnam + " " + wdetail2.NAME2
                wdetail.icno        = wdetail2.icno  
                wdetail.iadd1       = wdetail2.address
                wdetail.iadd2       = wdetail2.tambon  
                wdetail.iadd3       = wdetail2.amper   
                wdetail.iadd4       = wdetail2.country + " " + wdetail2.post 
                wdetail.subclass    = IF wdetail2.vehuse = "เก๋ง" THEN "110" ELSE "210"
                wdetail.model       = wdetail2.model 
                wdetail.cc          = wdetail2.cc
                wdetail.chasno      = trim(wdetail2.chasno)   
                wdetail.vehreg      = "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 7,2) + " " + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 5) /*kridtiya i. A53-0317*/
                wdetail.engno       = wdetail2.engno
                wdetail.vehuse      = "1"
                wdetail.garage      = ""
                wdetail.stk         = ""                
                wdetail.covcod      = "1" 
                wdetail.si          = wdetail2.si
                wdetail.prempa      = "v"
                wdetail.branch      = wdetail2.branch 
                wdetail.benname     = wdetail2.financename2
                wdetail.volprem     = wdetail2.baseprm
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
                wdetail.CoverNote   = wdetail2.staus  
                wdetail.nmember     = wdetail2.REMARK  .   
            IF wdetail2.stk <> ""  THEN DO:
                ASSIGN 
                    wdetail2.policy = "1" + substr(wdetail2.policy,2).
                FIND FIRST wdetail WHERE wdetail.policy = wdetail2.policy NO-ERROR NO-WAIT.
                IF NOT AVAIL wdetail THEN DO:
                    CREATE wdetail.
                    ASSIGN
                        wdetail.poltyp      = IF substr(wdetail2.policy,1,1) = "0" THEN "70" ELSE "72"   
                        wdetail.policy      = wdetail2.policy
                        wdetail.comdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + wdetail2.comyear     
                        wdetail.expdat      = wdetail2.comday + "/" + wdetail2.commonth + "/" + STRING(expyear)   
                        wdetail.insnam      = wdetail2.insnam + " " + wdetail2.NAME2
                        wdetail.icno        = wdetail2.icno 
                        wdetail.iadd1       = wdetail2.address
                        wdetail.iadd2       = wdetail2.tambon  
                        wdetail.iadd3       = wdetail2.amper   
                        wdetail.iadd4       = wdetail2.country + " " + wdetail2.post  
                        wdetail.subclass    = IF wdetail2.vehuse = "เก๋ง" THEN "110" ELSE "210"
                        wdetail.model       = wdetail2.model 
                        wdetail.cc          = wdetail2.cc
                        wdetail.engno       = wdetail2.engno
                        wdetail.chasno      = trim(wdetail2.chasno)   
                        wdetail.vehreg      = "/" + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 7,2) + " " + substr(trim(wdetail2.chasno),LENGTH(trim(wdetail2.chasno)) - 5) /*kridtiya i. A53-0317*/
                        wdetail.vehuse      = "1"
                        wdetail.garage      = ""
                        wdetail.stk         = wdetail2.stk   
                        wdetail.covcod      = "1"
                        wdetail.si          = wdetail2.si
                        wdetail.prempa      = "v"
                        wdetail.branch      = wdetail2.branch 
                        wdetail.benname     = wdetail2.financename2
                        wdetail.volprem     = wdetail2.baseprm
                        wdetail.comment     = wdetail2.typepay     
                        wdetail.agent       = ""
                        wdetail.producer    = ""   
                        wdetail.CoverNote   = wdetail2.staus    
                        wdetail.nmember     = wdetail2.REMARK 
                        wdetail.entdat      = string(TODAY)               /*entry date*/
                        wdetail.enttim      = STRING(TIME, "HH:MM:SS")    /*entry time*/
                        wdetail.trandat     = STRING(TODAY)               /*tran date*/
                        wdetail.trantim     = STRING(TIME, "HH:MM:SS")    /*tran time*/
                        wdetail.n_IMPORT    = "IM"  
                        wdetail.n_EXPORT    = ""
                        wdetail.deler       = wdetail2.deler    
                        wdetail.n_telreq    = wdetail2.showroom  
                        wdetail.delerco     = wdetail2.delerco .   
                END.  /*if avail*/
            END.      /*stk <> ""*/
        END.
    END.
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
If  substr(fi_output1,length(fi_output1) - 3,4) <>  ".slk"  Then
    fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_cnt   =  0
       nv_row   =  1 .
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
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
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'  "การจ่าย"             '"' SKIP.
RUN proc_matchfilechk5.
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
For each  wdetail2 :
    DELETE  wdetail2.
END.
For each  wdetail :
    DELETE  wdetail.
END.
message "Export File  Complete"  view-as alert-box.

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
for each wdetail  .  
    ASSIGN 
        nv_cnt  =  nv_cnt  + 1                      
        nv_row  =  nv_row + 1.   
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
END.   /*  end  wdetail  */  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilechk6 C-Win 
PROCEDURE proc_matchfilechk6 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_output1,length(fi_output1) - 3,4) <>  ".slk"  Then
    fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_cnt   =  0
       nv_row   =  1 .
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "TEXT FILE FROM TIL(บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด)"  '"' SKIP. 
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  "จังหวัด"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  "สาขา"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  "ภูมิภาค"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  "สาขากรมธรรม์"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  "รหัสดีเลอร์"        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  "Type"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  "Policy"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  "Cedpol"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  "Comdate"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  "expidate"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  "ชื่อลูกค้า"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  "เลขที่บัตรประชาชน"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  "ที่อยู่"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  "ถนน"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  "แขวง"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  "เขต"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  "คลาส"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  "รุ่นรถ"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  "ขนาดเครื่อง"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  "ทะเบียนรถ"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  "เลขเครื่อง"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  "เลขตัวถัง"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  "ลักษณะการใช้"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  "การซ่อม"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  "สติ๊กเกอร์ "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  "ชื่อดีเลอร์"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  "โชว์รูม"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  "ทุนประกัยภัย"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  "package"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  "ความคุ้มครอง"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  "ผู้รับผลประโยชน์"   '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  "เบี้ยสุทธิ"         '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  "การจ่าย"            '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  "สถานะผู้แจ้ง"       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  "REMARK"             '"' SKIP. 

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
/*---------------------------------------------------------------------*/
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
DEF VAR n_policyuwm100 AS CHAR FORMAT "x(20)" INIT "".
FOR each wdetail  . 
    FIND LAST wdetail2 WHERE TRIM(wdetail2.Insurancerefno)  = trim(substr(wdetail.policy,2)) NO-LOCK NO-ERROR.
    IF AVAIL wdetail2 THEN DO:
    ASSIGN 
        n_policyuwm100 = ""  
        Branch_Name = ""   /*A57-0415*/
        Branch_Name2 = ""  /*A57-0415*/
        nRegion     = ""   /*A57-0415*/
        nv_cnt  =  nv_cnt  + 1                      
        nv_row  =  nv_row + 1.   
    FIND LAST sicuw.uwm100 USE-INDEX uwm10002  WHERE
        sicuw.uwm100.cedpol = trim(substr(wdetail.policy,2))     AND 
        sicuw.uwm100.poltyp = "V" + wdetail.poltyp  NO-LOCK   NO-ERROR .
    IF AVAIL sicuw.uwm100  THEN DO: 
        ASSIGN 
            n_policyuwm100  = sicuw.uwm100.policy 
            wdetail.branch  = sicuw.uwm100.branch .
        /*Add A57-0415 */
        IF      trim(sicuw.uwm100.branch) = "14"  THEN ASSIGN Branch_Name  = "กรุงเทพ"                   Branch_Name2 = "ปริมณฑล" nRegion = "ปริมณฑล".
        ELSE IF trim(sicuw.uwm100.branch) = "12"  THEN ASSIGN Branch_Name  = "กรุงเทพ"                   Branch_Name2 = "ปริมณฑล" nRegion = "ปริมณฑล".
        ELSE IF trim(sicuw.uwm100.branch) = "T"   THEN ASSIGN Branch_Name  = "สมุทรปราการ(เทพารักษ์)"    Branch_Name2 = "ปริมณฑล" nRegion = "ปริมณฑล".
        ELSE IF trim(sicuw.uwm100.branch) = "R"   THEN ASSIGN Branch_Name  = "ราชพฤกษ์"                  Branch_Name2 = "สาขา"    nRegion = "กรุงเทพและปริมณฑล".
        ELSE IF trim(sicuw.uwm100.branch) = "91"  THEN ASSIGN Branch_Name  = "ถนนเพชรบุรีตัดใหม่"        Branch_Name2 = "สาขา"    nRegion = "กรุงเทพและปริมณฑล".
        ELSE IF trim(sicuw.uwm100.branch) = "92"  THEN ASSIGN Branch_Name  = "ถนนเพชรบุรีตัดใหม่"        Branch_Name2 = "สาขา"    nRegion = "กรุงเทพและปริมณฑล".
        ELSE IF trim(sicuw.uwm100.branch) = "93"  THEN ASSIGN Branch_Name  = "ถนนเพชรบุรีตัดใหม่"        Branch_Name2 = "สาขา"    nRegion = "กรุงเทพและปริมณฑล".
        ELSE IF trim(sicuw.uwm100.branch) = "94"  THEN ASSIGN Branch_Name  = "ถนนเพชรบุรีตัดใหม่"        Branch_Name2 = "สาขา"    nRegion = "กรุงเทพและปริมณฑล".
        ELSE IF trim(sicuw.uwm100.branch) = "95"  THEN ASSIGN Branch_Name  = "ถนนเพชรบุรีตัดใหม่"        Branch_Name2 = "สาขา"    nRegion = "กรุงเทพและปริมณฑล".
        ELSE IF trim(sicuw.uwm100.branch) = "96"  THEN ASSIGN Branch_Name  = "ถนนเพชรบุรีตัดใหม่"        Branch_Name2 = "สาขา"    nRegion = "กรุงเทพและปริมณฑล".  
        ELSE IF trim(sicuw.uwm100.branch) = "97"  THEN ASSIGN Branch_Name  = "ถนนเพชรบุรีตัดใหม่"        Branch_Name2 = "สาขา"    nRegion = "กรุงเทพและปริมณฑล".  
        ELSE IF trim(sicuw.uwm100.branch) = "98"  THEN ASSIGN Branch_Name  = "ถนนเพชรบุรีตัดใหม่"        Branch_Name2 = "สาขา"    nRegion = "กรุงเทพและปริมณฑล".  
        ELSE IF trim(sicuw.uwm100.branch) = "11"  THEN ASSIGN Branch_Name  = "รังสิต"                    Branch_Name2 = "สาขา"    nRegion = "กรุงเทพและปริมณฑล".  
        ELSE IF trim(sicuw.uwm100.branch) = "0"   THEN ASSIGN Branch_Name  = "การตลาด-นายหน้าในประเทศ"   Branch_Name2 = "M1"      nRegion = "M1".  
        ELSE IF trim(sicuw.uwm100.branch) = "W"   THEN ASSIGN Branch_Name  = "การตลาด-นายหน้าต่างประเทศ" Branch_Name2 = "M2"      nRegion = "M2".  
        ELSE IF trim(sicuw.uwm100.branch) = "M"   THEN ASSIGN Branch_Name  = "กรุงเทพ"                   Branch_Name2 = "M3"      nRegion = "M3".  
        ELSE IF trim(sicuw.uwm100.branch) = "L"   THEN ASSIGN Branch_Name  = "การตลาด-ตัวแทน"            Branch_Name2 = "M2"      nRegion = "M2".  
        ELSE IF trim(sicuw.uwm100.branch) = "19"  THEN ASSIGN Branch_Name  = ""                  Branch_Name2 = ""        nRegion = "กรุงเทพและปริมณฑล".  
        ELSE IF trim(sicuw.uwm100.branch) = "Y"   THEN ASSIGN Branch_Name  = ""                  Branch_Name2 = ""        nRegion = "กรุงเทพและปริมณฑล".  
        ELSE IF trim(sicuw.uwm100.branch) = "X"   THEN ASSIGN Branch_Name  = ""                  Branch_Name2 = ""        nRegion = "กรุงเทพและปริมณฑล".  
        ELSE IF trim(sicuw.uwm100.branch) = "V"   THEN ASSIGN Branch_Name  = ""                  Branch_Name2 = ""        nRegion = "กรุงเทพและปริมณฑล".  
        ELSE IF trim(sicuw.uwm100.branch) = "15"  THEN ASSIGN Branch_Name  = "อ่อนนุช"           Branch_Name2 = "ปริมณฑล" nRegion = "กรุงเทพและปริมณฑล".  
        ELSE IF trim(sicuw.uwm100.branch) = "43"  THEN ASSIGN Branch_Name  = "กาญจนาภิเษก"       Branch_Name2 = "ปริมณฑล" nRegion = "กรุงเทพและปริมณฑล".  
        ELSE IF trim(sicuw.uwm100.branch) = "32"  THEN ASSIGN Branch_Name  = "สุพรรณบุรี"        Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง" .             
        ELSE IF trim(sicuw.uwm100.branch) = "34"  THEN ASSIGN Branch_Name  = "อยุธยา"            Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง" .  
        ELSE IF trim(sicuw.uwm100.branch) = "33"  THEN ASSIGN Branch_Name  = "ราชบุรี"           Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง" .  
        ELSE IF trim(sicuw.uwm100.branch) = "U"   THEN ASSIGN Branch_Name  = "นครปฐม"            Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง" .  
        ELSE IF trim(sicuw.uwm100.branch) = "35"  THEN ASSIGN Branch_Name  = "ฉะเชิงเทรา"        Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง" .  
        ELSE IF trim(sicuw.uwm100.branch) = "A"   THEN ASSIGN Branch_Name  = "ประจวบคีรีขันธ์"   Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง" .  
        ELSE IF trim(sicuw.uwm100.branch) = "5"   THEN ASSIGN Branch_Name  = "พัทยา"             Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง" .  
        ELSE IF trim(sicuw.uwm100.branch) = "J"   THEN ASSIGN Branch_Name  = "สระบุรี"           Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง" .  
        ELSE IF trim(sicuw.uwm100.branch) = "F"   THEN ASSIGN Branch_Name  = "สมุทรสาคร"         Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง".  
        ELSE IF trim(sicuw.uwm100.branch) = "I"   THEN ASSIGN Branch_Name  = "เพชรบุรี"          Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง".  
        ELSE IF trim(sicuw.uwm100.branch) = "36"  THEN ASSIGN Branch_Name  = "ระยอง"             Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง".  
        ELSE IF trim(sicuw.uwm100.branch) = "31"  THEN ASSIGN Branch_Name  = "กาญจนบุรี"         Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง".  
        ELSE IF trim(sicuw.uwm100.branch) = "P"   THEN ASSIGN Branch_Name  = "ชลบุรี"            Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง".  
        ELSE IF trim(sicuw.uwm100.branch) = "39"  THEN ASSIGN Branch_Name  = "จันทบุรี"          Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง".  
        ELSE IF trim(sicuw.uwm100.branch) = "38"  THEN ASSIGN Branch_Name  = "ปราจีนบุรี"        Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง".  
        ELSE IF trim(sicuw.uwm100.branch) = "37"  THEN ASSIGN Branch_Name  = "ลพบุรี"            Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง".  
        ELSE IF trim(sicuw.uwm100.branch) = "41"  THEN ASSIGN Branch_Name  = "หัวหิน"            Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง".
        ELSE IF trim(sicuw.uwm100.branch) = "42"  THEN ASSIGN Branch_Name  = "สมุทรสงคราม"       Branch_Name2 = "สาขา"    nRegion = "ภาคกลาง".
        ELSE IF trim(sicuw.uwm100.branch) = "74"  THEN ASSIGN Branch_Name  = "ศรีสะเกษ"          Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "3"   THEN ASSIGN Branch_Name  = "ขอนแก่น"           Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "6"   THEN ASSIGN Branch_Name  = "โคราช"             Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "72"  THEN ASSIGN Branch_Name  = "สุรินทร์"          Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "K"   THEN ASSIGN Branch_Name  = "อุบลราชธานี"       Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "S"   THEN ASSIGN Branch_Name  = "อุดรธานี"          Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "71"  THEN ASSIGN Branch_Name  = "ร้อยเอ็ด"          Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "75"  THEN ASSIGN Branch_Name  = "มุกดาหาร"          Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "73"  THEN ASSIGN Branch_Name  = "สกลนคร"            Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "76"  THEN ASSIGN Branch_Name  = "กาฬสินธุ์"         Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "77"  THEN ASSIGN Branch_Name  = "ชัยภูมิ"           Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "79"  THEN ASSIGN Branch_Name  = "หนองคาย"           Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "78"  THEN ASSIGN Branch_Name  = "มหาสารคาม"         Branch_Name2 = "สาขา"    nRegion = "ภาคตะวันออกเฉียงเหนือ".  
        ELSE IF trim(sicuw.uwm100.branch) = "1"   THEN ASSIGN Branch_Name  = "นครสวรรค์"         Branch_Name2 = "สาขา"    nRegion = "ภาคเหนือ" .                
        ELSE IF trim(sicuw.uwm100.branch) = "2"   THEN ASSIGN Branch_Name  = "เชียงใหม่"         Branch_Name2 = "สาขา"    nRegion = "ภาคเหนือ" .               
        ELSE IF trim(sicuw.uwm100.branch) = "61"  THEN ASSIGN Branch_Name  = "ลำปาง"             Branch_Name2 = "สาขา"    nRegion = "ภาคเหนือ" .               
        ELSE IF trim(sicuw.uwm100.branch) = "H"   THEN ASSIGN Branch_Name  = "พิษณุโลก"          Branch_Name2 = "สาขา"    nRegion = "ภาคเหนือ" .  
        ELSE IF trim(sicuw.uwm100.branch) = "G"   THEN ASSIGN Branch_Name  = "เชียงราย"          Branch_Name2 = "สาขา"    nRegion = "ภาคเหนือ" .  
        ELSE IF trim(sicuw.uwm100.branch) = "62"  THEN ASSIGN Branch_Name  = "อุตรดิตถ์"         Branch_Name2 = "สาขา"    nRegion = "ภาคเหนือ" .  
        ELSE IF trim(sicuw.uwm100.branch) = "63"  THEN ASSIGN Branch_Name  = "ตาก"               Branch_Name2 = "สาขา"    nRegion = "ภาคเหนือ" .  
        ELSE IF trim(sicuw.uwm100.branch) = "64"  THEN ASSIGN Branch_Name  = "แพร่"              Branch_Name2 = "สาขา"    nRegion = "ภาคเหนือ" .  
        ELSE IF trim(sicuw.uwm100.branch) = "65"  THEN ASSIGN Branch_Name  = "กำแพงเพชร"         Branch_Name2 = "สาขา"    nRegion = "ภาคเหนือ".
        ELSE IF trim(sicuw.uwm100.branch) = "86"  THEN ASSIGN Branch_Name  = "สตูล"              Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "N"   THEN ASSIGN Branch_Name  = "นครศรีธรรมราช"     Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "81"  THEN ASSIGN Branch_Name  = "เวียงสระ"          Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "84"  THEN ASSIGN Branch_Name  = "ตะกั่วป่า"         Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "82"  THEN ASSIGN Branch_Name  = "ทุ่งสง"            Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "7"   THEN ASSIGN Branch_Name  = "สุราษฏร์ธานี"      Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "E"   THEN ASSIGN Branch_Name  = "ตรัง"              Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "C"   THEN ASSIGN Branch_Name  = "กระบี่"            Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "B"   THEN ASSIGN Branch_Name  = "ชุมพร"             Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "85"  THEN ASSIGN Branch_Name  = "พัทลุง"            Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "83"  THEN ASSIGN Branch_Name  = "ระนอง"             Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "8"   THEN ASSIGN Branch_Name  = "ภูเก็ต"            Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "D"   THEN ASSIGN Branch_Name  = "ปัตตานี"           Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "4"   THEN ASSIGN Branch_Name  = "หาดใหญ่"           Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE IF trim(sicuw.uwm100.branch) = "9"   THEN ASSIGN Branch_Name  = "สมุย"              Branch_Name2 = "สาขา"    nRegion = "ภาคใต้".  
        ELSE   ASSIGN Branch_Name  = ""        Branch_Name2 = ""    nRegion = "".                                    
        /*end. add A57-0415 */                                                                     
    END.                                                                                           
    IF wdetail.poltyp  = "72" THEN DO:                                                             
        IF wdetail.subclass = "110" THEN wdetail.volprem = "600".                                  
        ELSE IF wdetail.subclass = "210" THEN wdetail.volprem = "900".  
    END.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  Branch_Name                                    '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  Branch_Name2                                   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  nRegion                                        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail.branch                                 '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail.delerco                                '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  "V" + wdetail.poltyp                           '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  n_policyuwm100                 FORMAT "x(20)"  '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  trim(substr(wdetail.policy,2)) FORMAT "x(20)"  '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail.comdat                                 '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'  wdetail.expdat                                 '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'  wdetail.insnam                                 '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'  wdetail.icno                                   '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'  wdetail.iadd1                                  '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'  wdetail.iadd2                                  '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'  wdetail.iadd3                                  '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'  wdetail.iadd4                                  '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'  wdetail.subclass                               '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'  wdetail.model                                  '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'  wdetail.cc                                     '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'  wdetail.vehreg                                 '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'  wdetail.engno                                  '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'  wdetail.chasno                                 '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'  wdetail.vehuse                                 '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'  wdetail.garage                                 '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'  wdetail.stk                                    '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'  trim(wdetail2.deler)     FORMAT "x(100)"       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'  trim(wdetail2.showroom)  FORMAT "x(50)"        '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'  wdetail.si                                     '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'  wdetail.prempa                                 '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'  wdetail.covcod                                 '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'  wdetail.benname                                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'  wdetail.volprem                                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'  wdetail.comment   FORMAT "x(60)"               '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'  wdetail.CoverNote FORMAT "x(60)"               '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'  wdetail.nmember   FORMAT "x(100)"              '"' SKIP.

    END.                                                                                                        
END.  /*  end  wdetail  */     
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
/*---------------------------------------------------------------------*/
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
    IF   wdetail.CoverNote <> ""  THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002  WHERE
            sicuw.uwm100.cedpol = trim(substr(wdetail.policy,2))     AND 
            sicuw.uwm100.poltyp = "V" + wdetail.poltyp  NO-LOCK   NO-ERROR .
        IF AVAIL sicuw.uwm100  THEN  wdetail.CoverNote   = sicuw.uwm100.name2.
        IF wdetail.poltyp  = "72" THEN DO:
        IF wdetail.subclass = "110" THEN wdetail.volprem = "600".
        ELSE IF wdetail.subclass = "210" THEN wdetail.volprem = "900".  
    END.  
    END.
    ELSE DELETE wdetail.
END.
FOR each wdetail 
     BY wdetail.CoverNote .
    FIND LAST wdetail2 WHERE TRIM(wdetail2.Insurancerefno)  = trim(substr(wdetail.policy,2)) NO-LOCK NO-ERROR.
    IF AVAIL wdetail2 THEN DO:
    ASSIGN 
        n_policyuwm100 = ""    
        nv_cnt  =  nv_cnt  + 1                      
        nv_row  =  nv_row + 1.   
    FIND LAST sicuw.uwm100 USE-INDEX uwm10002  WHERE
        sicuw.uwm100.cedpol = trim(substr(wdetail.policy,2))     AND 
        sicuw.uwm100.poltyp = "V" + wdetail.poltyp  NO-LOCK   NO-ERROR .
    IF AVAIL sicuw.uwm100  THEN n_policyuwm100  = sicuw.uwm100.policy .
    IF wdetail.poltyp  = "72" THEN DO:
        IF wdetail.subclass = "110" THEN wdetail.volprem = "600".
        ELSE IF wdetail.subclass = "210" THEN wdetail.volprem = "900".   
    END.                                              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' wdetail.CoverNote FORMAT "x(60)"   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' n_policyuwm100    FORMAT "x(20)"   '"' SKIP.                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' wdetail.branch    FORMAT "x(2)"     '"' SKIP.                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdetail.delerco                     '"' SKIP.                             
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
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' trim(wdetail2.showroom)  FORMAT "x(50)"     '"' SKIP.                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' wdetail.si         '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' wdetail.prempa     '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' wdetail.covcod     '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' wdetail.benname    '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' wdetail.volprem    '"' SKIP.                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' wdetail.comment   FORMAT "x(60)"     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' wdetail.nmember   FORMAT "x(100)"    '"' SKIP.  
END.
END.  /*  end  wdetail  */   
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
ASSIGN 
n_titlename = "" .
/*
FIND FIRST brstat.msgcode WHERE 
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
IF (fi_name2 = "") AND (wdetail.name2 = "")  THEN ASSIGN wdetail.inscod = "" .    /*A57-0260*/
RUN proc_insnam .

DO TRANSACTION:
   ASSIGN
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = wdetail.poltyp
      sic_bran.uwm100.insref = nv_insref
      sic_bran.uwm100.opnpol = ""
      sic_bran.uwm100.anam2  = wdetail.Icno       /* ICNO  Cover Note A51-0071 Amparat */
      sic_bran.uwm100.ntitle = wdetail.tiname     /*A54-0200*/ /*"คุณ"   */           
      sic_bran.uwm100.name1  = TRIM(wdetail.insnam)  
      /*sic_bran.uwm100.name2  = "และ/หรือ บริษัท ไทยออโต้เซลส์ จำกัด" *//*comment by kridtiya i. A53-0156*/
      /*sic_bran.uwm100.name2  = "และ/หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด" /*Add by kridtiya i. A53-0156*/*//*Kridtiya i. A54-0364*/
      sic_bran.uwm100.name2  =  IF fi_name2 = "" THEN wdetail.name2  ELSE trim(fi_name2)   /*Kridtiya i. A54-0364*/
      sic_bran.uwm100.name3  = ""                 
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
      sic_bran.uwm100.acno1  = fi_producer /*  nv_acno1 */
      sic_bran.uwm100.agent  = fi_agent    /*nv_agent   */
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
      sic_bran.uwm100.cr_2  =  n_cr2
      sic_bran.uwm100.bchyr   = nv_batchyr          /*Batch Year */  
      sic_bran.uwm100.bchno   = nv_batchno          /*Batch No.  */  
      sic_bran.uwm100.bchcnt  = nv_batcnt           /*Batch Count*/  
      sic_bran.uwm100.prvpol  = wdetail.renpol      /*A52-0172*/
      sic_bran.uwm100.cedpol  = wdetail.cedpol
      sic_bran.uwm100.finint  = wdetail.finint
      /*sic_bran.uwm100.bs_cd  = "MC16182".*/     /* Kridtiya i. A53-0183 .............*/
      /*sic_bran.uwm100.bs_cd   =  wdetail.inscod.   /*add Kridtiya i. A53-0183 ...vatcode*/ */        /*A57-0415*/  
      sic_bran.uwm100.bs_cd   = IF fi_vatcode <> "" THEN caps(trim(fi_vatcode)) ELSE  wdetail.inscod.  /*A57-0415*/   
      IF wdetail.renpol <> " " THEN DO:
          IF wdetail.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = ""
                                                  sic_bran.uwm100.tranty  = "R".  
          ELSE 
              ASSIGN
                  sic_bran.uwm100.prvpol  = wdetail.renpol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                  sic_bran.uwm100.tranty  = "R".               /*Transaction Type (N/R/E/C/T)*/
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
RUN proc_uwd100.  
/*kridtiya i. A54-0026*/
IF wdetail.poltyp = "v70" THEN DO:
    ASSIGN wdetail.stk =  n_stkk.
    RUN proc_uwd102.
END.  /*kridtiya i. A54-0026*/
/*kridtiya i. A54-0026*/
IF wdetail.poltyp = "v70" THEN  wdetail.stk = ""   .
/*kridtiya i. A54-0026*/
/*kridtiya i. A52-0293.....
RUN proc_uwd102.*/
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
        wdetail.NO_41        ","   
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
        wdetail.NO_41        ","   
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
"IMPORT TEXT FILE TIL " SKIP    /*kridtiya i. A53-0156*/
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
FOR EACH wuppertxt2 WHERE  wuppertxt2.stk    =  wdetail.stk    NO-LOCK .
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
    nv_txt1  = "ขยายอุปกรณ์ตกแต่งเพิ่มเติมไม่เกิน 20,000.00 บาท"
    nv_txt2  = "วันที่แจ้งงาน SAFE : " + wdetail.revday 
    nv_txt3  = ""
    nv_txt4  = ""
    nv_txt5  = "" . 
FIND LAST wno30txt  WHERE wno30txt.policy  = wdetail.policy     NO-LOCK NO-ERROR NO-WAIT.
IF   AVAIL wno30txt THEN  ASSIGN  nv_txt3  =  wno30txt.text30   .  /*A57-0303*/
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
DO WHILE nv_line1 <= 7:
    CREATE wuppertxt3.
    wuppertxt3.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt3.txt = "SAFE : " + wdetail.revday .
    IF nv_line1 = 2  THEN wuppertxt3.txt = fi_campens.
    IF nv_line1 = 3  THEN wuppertxt3.txt = IF substr(wdetail.stk,1,1) <> "0" THEN  "0" + wdetail.stk ELSE wdetail.stk  .
    IF nv_line1 = 4  THEN wuppertxt3.txt = IF ra_compatyp = 2 THEN  "   "  + fi_memotext ELSE "".
    IF nv_line1 = 5  THEN wuppertxt3.txt = IF wdetail.name2 = "" THEN  ""  ELSE "ออกใบเสร็จใบกำกับในนามดิลเลอร์ : " + wdetail.name2.
    IF nv_line1 = 6  THEN wuppertxt3.txt = IF wdetail.n_telreq = "" THEN "" ELSE  "เบอร์โทรศัพสำหรับติดต่อกลับ " + TRIM(wdetail.n_telreq) .   /* A57-0260 */

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign3 C-Win 
PROCEDURE Pro_assign3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2 .
    /*IF wdetail2.id = "" THEN DO:*//*Kridtiya i. A53-0180*/
    /*add  Kridtiya i. A53-0180*/
    IF (wdetail2.id <> "ID") AND (wdetail2.policy <> "")THEN DO:
        IF wdetail2.mu      <> ""  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu)   .
        IF wdetail2.soi     <> ""  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.soi)  .
        IF wdetail2.road    <> ""  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.road) .
        IF trim(wdetail2.country) <> ""  THEN DO:
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
        /*add kridtiya i. A58-0136*/
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
        END.
        /*end...Add kridtiya i.*/
        /*end...Kridtiya i. A53-0180*/
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            /*stat.insure.compno = "TAS"       AND*//*kridtiya i. A53-0156*/  
            stat.insure.compno = "TIL"              AND       /*kridtiya i. A53-0156*/     
            stat.insure.fname  = wdetail2.deler     AND
            stat.insure.lname  = wdetail2.showroom  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL insure THEN DO:
            ASSIGN wdetail2.branch = stat.insure.branch
                wdetail2.delerco   = stat.insure.insno  
                wdetail2.typepay   = stat.insure.vatcode.   /* kridtiya i. A53-0183*/    
            IF TRIM(stat.insure.Addr3) <> "" THEN DO:
                FIND LAST wno30txt  WHERE wno30txt.policy = "0" + wdetail2.Insurancerefno   NO-ERROR NO-WAIT.
                IF NOT AVAIL wno30txt THEN DO:
                    CREATE wno30txt.
                    ASSIGN 
                        wno30txt.policy  = "0" + wdetail2.Insurancerefno 
                        wno30txt.text30  = stat.Insure.Addr3.
                END.
            END.
            /*comment by kridtiya i. A57-0260....
            IF INDEX(wdetail2.REMARK1,"ออกใบเสร็จ") = 0 THEN ASSIGN  dealer_name2    = "".
            ELSE ASSIGN dealer_name2     = "และ/หรือ " + trim(stat.insure.addr1).    /* dealer name         */*//*A57-0260*/
            IF INDEX(wdetail2.staus,"ออกใบเสร็จ") = 0 THEN ASSIGN  wdetail2.dealer_name2    = "".    /*A57-0260*/
            ELSE DO: 
                FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
                    sicsyac.xmm600.acno = trim(wdetail2.typepay) NO-LOCK NO-ERROR .
                IF AVAIL sicsyac.xmm600 THEN 
                    ASSIGN wdetail2.dealer_name2     = "และ/หรือ " + trim(sicsyac.xmm600.ntitle) + " " + 
                                                       trim(sicsyac.xmm600.NAME).    /*A57-0415*/
                ELSE 
                    ASSIGN wdetail2.dealer_name2     = "และ/หรือ " + trim(stat.insure.addr1).     /*A57-0260*/
            END.
            
        END.
        ELSE ASSIGN wdetail2.branch   = ""
                    wdetail2.delerco  = "" 
                    wdetail2.typepay  = "" 
                    wdetail2.dealer_name2      = "" .
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_assign_AH C-Win 
PROCEDURE pro_assign_AH :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail2.deler  = "AYUTTHAYA ISUZU SALES" THEN ASSIGN  wdetail2.branch = "J" 
    wdetail2.delerco = "MS0C083".
IF wdetail2.deler  = "AYUTTHAYA ISUZU SALES CO.,LTD." THEN ASSIGN wdetail2.branch = "J"
    wdetail2.delerco = "MS0C076" .
IF wdetail2.deler  = "BAMROONG YONT L.P."   THEN  ASSIGN wdetail2.branch = "6" 
    wdetail2.delerco = "MS0C190" .
IF wdetail2.deler  = "CHEEWIN ISUZU" THEN  ASSIGN wdetail2.branch = "3" 
    wdetail2.delerco = "MS0C297" .
IF wdetail2.deler  = "CHEEWIN ISUZU CO.,LTD." THEN  ASSIGN wdetail2.branch = "3" 
    wdetail2.delerco = "MS0C296" .
IF wdetail2.deler  = "CHOLBURI ISUZU" OR wdetail2.deler  = "CHOLBURI ISUZU SALES CO.,LTD." THEN DO:  
    ASSIGN wdetail2.branch = "5" 
        wdetail2.delerco = "MS0C322" .
    IF wdetail2.showroom = "บางทราย"  THEN wdetail2.delerco = "MS0C325" .
    IF wdetail2.showroom = "บางแสน (สนญ)" OR wdetail2.showroom = "บางแสน"  THEN wdetail2.delerco = "MS0C324" .
    IF wdetail2.showroom = "บ้านบึง"  THEN wdetail2.delerco = "MS0C327" .
    IF wdetail2.showroom = "พัทยา"  THEN wdetail2.delerco = "MS0C326" .
END.
IF wdetail2.deler  = "CHUENG KONG HENG ISUZU" OR wdetail2.deler  = "CHUENG KONG HENG ISUZU CO.,LTD" THEN DO:  
    ASSIGN wdetail2.branch = "J" 
        wdetail2.delerco = "MS0C077" .
    IF wdetail2.showroom = "แก่งคอย"  THEN wdetail2.delerco = "MS0C086" .
    IF wdetail2.showroom = "อ่างทอง (สนญ)" OR wdetail2.showroom = "อ่างทอง"  THEN wdetail2.delerco = "MS0C087" .
    IF wdetail2.showroom = "สระบุรี (สนญ)" OR wdetail2.showroom = "สระบุรี"  THEN wdetail2.delerco = "MS0C085" .
END.
IF wdetail2.deler  = "EASTERN CHOLBURI" THEN DO:  
    ASSIGN wdetail2.branch = "5" .
    IF wdetail2.showroom = "บ่อวิน"  THEN wdetail2.delerco = "MS0C330" .
    IF wdetail2.showroom = "บ้านฉาง"  THEN wdetail2.delerco = "MS0C328" .
    IF wdetail2.showroom = "ศรีราชา (สนญ)" OR wdetail2.showroom = "ศรีราชา" THEN wdetail2.delerco = "MS0C329" .
END.
IF wdetail2.deler  = "EASTERN MOTOR WORKS" THEN DO:   
    ASSIGN wdetail2.branch = "5" .
    IF wdetail2.showroom = "แกลง" THEN wdetail2.delerco = "MS0C332" .
    IF wdetail2.showroom = "บ้านฉาง" THEN wdetail2.delerco = "MS0C333" .
    IF wdetail2.showroom = "ระยอง (สนญ)" OR wdetail2.showroom = "ระยอง" THEN wdetail2.delerco = "MS0C331" .
END.
IF wdetail2.deler  = "HAAD YAI UNITED MOTOR CO.,LTD." THEN ASSIGN wdetail2.branch = "4" 
    wdetail2.delerco = "MS0C209" .
IF wdetail2.deler  = "HIAB NGUAN ISUZU SALES" THEN DO:  
    ASSIGN wdetail2.branch = "3" .
    IF wdetail2.showroom = "สว่างแดนดิน"    THEN wdetail2.delerco = "MS0C301" .
    IF wdetail2.showroom = "อ.เมืองกาฬสินธุ์ (สนญ)" OR wdetail2.showroom = "อ.เมืองกาฬสินธุ์" THEN wdetail2.delerco = "MS0C302".
    IF wdetail2.showroom = "อ.เมืองสกลนคร"  THEN wdetail2.delerco = "MS0C300" .
    IF wdetail2.showroom = "อ.เมืองหนองคาย"  THEN wdetail2.delerco = "MS0C299" .
    IF wdetail2.showroom = "อ.เมืองอุดร (สนญ)" OR wdetail2.showroom = "อ.เมืองอุดร" THEN ASSIGN wdetail2.branch = "S" 
        wdetail2.delerco = "MS0C264" .
END.
IF wdetail2.deler  = "HIAB NGUAN ISUZU SALES CO.,LTD" THEN ASSIGN wdetail2.branch = "S" 
    wdetail2.delerco = "MS0C273" .
IF wdetail2.deler  = "HIAB NGUAN MILLER L.P.(KALASIN" THEN ASSIGN wdetail2.branch = "3" 
    wdetail2.delerco = "MS0C347" .
IF wdetail2.deler  = "HIAB NGUAN MILLER L.P.(SAKOLNA" THEN ASSIGN wdetail2.branch = "3" 
    wdetail2.delerco = "MS0C348" .
IF wdetail2.deler  = "HIAB NGUAN MILLER L.P.NONGKHAI" THEN ASSIGN wdetail2.branch = "3" 
    wdetail2.delerco = "MS0C349" .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_assign_IS C-Win 
PROCEDURE pro_assign_IS :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail2.deler  = "ISUZU UTTRADITH HOCK AN TUENG" THEN  ASSIGN wdetail2.branch = "U" 
    wdetail2.delerco = "MS0C104".
IF wdetail2.deler  = "PRAKIT MOTOR SALES CO.,LTD."    THEN DO: 
    ASSIGN wdetail2.branch = "U" .
    IF wdetail2.showroom = "ราชบุรี" OR wdetail2.showroom = "สนญ.ราชบุรี" OR 
        wdetail2.showroom = "สาขาราชบุรี" OR wdetail2.showroom = "สำนักงานใหญ่ราชบุรี" THEN wdetail2.delerco = "MS0C126".
    IF wdetail2.showroom = "บ้านโป่ง" THEN wdetail2.delerco = "MS0C127".
END.
IF wdetail2.deler  = "ISUZU ANDAMAN SALES" OR wdetail2.deler  = "ISUZU ANDAMAN SALES CO.,LTD."  THEN DO:  
    IF (wdetail2.showroom = "สาขาตะกั่วป่า") OR (wdetail2.showroom = "ตะกั่วป่า") THEN ASSIGN wdetail2.branch = "8"
        wdetail2.delerco = "MS0C281".
    IF wdetail2.showroom = "โคกกลอย" THEN ASSIGN wdetail2.branch = "8" 
        wdetail2.delerco = "MS0C278".
    IF wdetail2.showroom = "เกาะแก้ว" OR wdetail2.showroom = "สาขาเกาะแก้ว" THEN ASSIGN wdetail2.branch = "8" 
        wdetail2.delerco = "MS0C279". 
    IF wdetail2.showroom = "ภูเก็ต" THEN ASSIGN wdetail2.branch = "8" 
        wdetail2.delerco = "MS0C282".
    IF wdetail2.showroom = "กระบี่" THEN ASSIGN wdetail2.branch = "C" 
        wdetail2.delerco = "MS0C199".
    IF wdetail2.showroom = "คลองท่อม"  THEN ASSIGN wdetail2.branch = "C" 
        wdetail2.delerco = "MS0C201".
    IF wdetail2.showroom = "อ่าวลึก" OR wdetail2.showroom = "อีซูซุอ่าวลึก" OR wdetail2.showroom = "อีซูซุสาขาอ่าวลึก" THEN ASSIGN wdetail2.branch = "C" 
        wdetail2.delerco = "MS0C200".
    IF wdetail2.showroom = "ทุ่งสง"   THEN ASSIGN wdetail2.branch = "N" 
        wdetail2.delerco = "MS0C198".
    IF wdetail2.showroom = "ทุ่งใหญ่" THEN ASSIGN wdetail2.branch = "N" 
        wdetail2.delerco = "MS0C197".
    IF wdetail2.showroom = "ตรัง" THEN ASSIGN wdetail2.branch = "E" 
        wdetail2.delerco = "MS0C259".
    IF wdetail2.showroom = "ย่านตาขาว" OR wdetail2.showroom = "สาขาย่านตาขาว"  THEN ASSIGN wdetail2.branch = "E" 
        wdetail2.delerco = "MS0C260".
    IF wdetail2.showroom = "สาขาห้วยยอด" OR wdetail2.showroom = "ห้วยยอด" THEN ASSIGN wdetail2.branch = "E" 
        wdetail2.delerco = "MS0C261". 
END.
IF wdetail2.deler  = "ISUZU ANGTHONG ASIA" OR wdetail2.deler  = "ISUZU ANGTHONG ASIA CO.,LTD." THEN DO: 
    ASSIGN wdetail2.branch = "J" .
    IF wdetail2.showroom = "แก่งคอย" THEN wdetail2.delerco = "MS0C089".
    IF wdetail2.showroom = "สระบุรี (สนญ)" OR wdetail2.showroom = "สระบุรี" THEN wdetail2.delerco = "MS0C088".
    IF wdetail2.showroom = "อ่างทอง (สนญ)" OR wdetail2.showroom = "อ่างทอง" THEN wdetail2.delerco = "MS0C090".
END.
IF wdetail2.deler  = "Isuzu Auto Center Co.,ltd" THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C043". 
IF wdetail2.deler  = "ISUZU BURAPHA" THEN DO:
    ASSIGN wdetail2.branch = "5" .
    IF wdetail2.showroom = "กบินทร์บุรี (สนญ)" OR wdetail2.showroom = "กบินทร์บุรี" THEN  wdetail2.delerco = "MS0C335".
    IF wdetail2.showroom = "แปดริ้ว (สนญ)" OR wdetail2.showroom = "แปดริ้ว" THEN  wdetail2.delerco = "MS0C334".
END.
IF wdetail2.deler  = "ISUZU CHAINAT" OR wdetail2.deler  = "ISUZU CHAINAT CO.,LTD." THEN DO:
    ASSIGN wdetail2.branch = "1" 
        wdetail2.delerco = "MS0C286".
    IF wdetail2.showroom = "ชัยนาท(สนญ)" OR wdetail2.showroom = "ชัยนาท" THEN  wdetail2.delerco = "MS0C285".
    IF wdetail2.showroom = "อุทัยธานี(สนญ)" OR wdetail2.showroom = "อุทัยธานี" THEN  wdetail2.delerco = "MS0C284".
END.
IF wdetail2.deler  = "ISUZU CHIANGMAI SALES" OR wdetail2.deler  = "ISUZU CHIANGMAI SALES CO.,LTD." THEN DO: 
    ASSIGN wdetail2.branch = "2" 
        wdetail2.delerco = "MS0C168" .
    IF wdetail2.showroom = "จอมทอง" THEN wdetail2.delerco = "MS0C155".
    IF wdetail2.showroom = "สันป่าตอง" THEN wdetail2.delerco = "MS0C156".
END.
IF wdetail2.deler  = "ISUZU CHIANGRAI(2002)" OR wdetail2.deler  = "ISUZU CHIANGRAI(2002)CO.,LTD." THEN DO: 
    ASSIGN wdetail2.branch = "2" 
        wdetail2.delerco = "MS0C169".
    IF wdetail2.showroom = "เทิง" THEN wdetail2.delerco = "MS0C145".
    IF wdetail2.showroom = "เชียงราย(สนญ)" OR wdetail2.showroom = "เชียงราย" THEN wdetail2.delerco = "MS0C144".
END.
IF wdetail2.deler  = "ISUZU EASTERN CHOLBURI CO.,LTD" THEN  ASSIGN wdetail2.branch = "5" 
    wdetail2.delerco = "MS0C317" .
IF wdetail2.deler  = "ISUZU HAADYAI CO.,LTD." THEN  ASSIGN wdetail2.branch = "4" 
    wdetail2.delerco = "MS0C208" .
IF wdetail2.deler  = "ISUZU HUA CHIANG CHAN CO.,LTD." THEN  ASSIGN wdetail2.branch = "5" 
    wdetail2.delerco = "MS0C321" .
IF wdetail2.deler  = "ISUZU KARNCHANABURI" OR wdetail2.deler  = "ISUZU KARNCHANABURI CO.,LTD." THEN DO:  
    ASSIGN wdetail2.branch = "U" 
        wdetail2.delerco = "MS0C112" .
    IF wdetail2.showroom = "กาญจนบุรี (สนญ)" OR wdetail2.showroom = "กาญจนบุรี" THEN wdetail2.delerco = "MS0C119".
    IF wdetail2.showroom = "ท่าเรือ"         THEN wdetail2.delerco = "MS0C120".
END.
IF wdetail2.deler  = "Isuzu King s Yont Krungthep Co.,ltd" THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C007" .
IF wdetail2.deler  = "Isuzu Krungthep Sales Co.,ltd" THEN  ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C019" .
IF (wdetail2.deler  = "ISUZU LAMPANG") OR (wdetail2.deler  = "ISUZU LAMPANG CO.,LTD") THEN DO: 
    ASSIGN wdetail2.branch = "2" .
    IF wdetail2.showroom = "เชียงคำ" THEN wdetail2.delerco = "MS0C149" .
    IF wdetail2.showroom = "บ้านต้า" THEN wdetail2.delerco = "MS0C147" .
    IF wdetail2.showroom = "งาว"     THEN wdetail2.delerco = "MS0C150" .
    IF wdetail2.showroom = "ลำปาง(สนญ)" OR wdetail2.showroom = "ลำปาง"THEN wdetail2.delerco = "MS0C146" .
    IF wdetail2.showroom = "พะเยา" THEN wdetail2.delerco = "MS0C148" .
END.
IF wdetail2.deler  = "ISUZU LOPBURI" OR wdetail2.deler  = "ISUZU LOPBURI CO.,LTD." THEN DO: 
    ASSIGN wdetail2.branch = "J" 
        wdetail2.delerco = "MS0C078" .
    IF wdetail2.showroom = "ลำนารายณ์" THEN wdetail2.delerco = "MS0C092" .
    IF wdetail2.showroom = "สำนักงานใหญ่" THEN wdetail2.delerco = "MS0C091" .
END.
IF wdetail2.deler  = "ISUZU NAKORNPANOM" THEN DO:  
    ASSIGN wdetail2.branch = "3".
    IF wdetail2.showroom = "อ.เมืองนครพนม (สนญ)" OR wdetail2.showroom = "อ.เมืองนครพนม" THEN wdetail2.delerco = "MS0C303" .
    IF wdetail2.showroom = "ธาตุพนม" THEN wdetail2.delerco = "MS0C304" .
END.
IF wdetail2.deler  = "ISUZU NAN (1989)" THEN  ASSIGN wdetail2.branch = "2" 
    wdetail2.delerco = "MS0C151" .
IF wdetail2.deler  = "ISUZU NONGBUALAMPHU" THEN  ASSIGN wdetail2.branch = "3" 
    wdetail2.delerco = "MS0C305" .
IF wdetail2.deler  = "ISUZU PATHOMYONTRAKARN" THEN  ASSIGN wdetail2.branch = "U" 
    wdetail2.delerco = "MS0C121" .
IF wdetail2.deler  = "Isuzu Mahanakorn Co.,ltd" THEN  ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C014" .
IF wdetail2.deler  = "Isuzu Metro Co.,ltd" THEN  ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C015" .
IF wdetail2.deler  = "Isuzu Nakornluang Co.,ltd" THEN  ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C003" .
IF wdetail2.deler  = "Isuzu Pathomyontrakarn Co.,ltd" THEN  ASSIGN wdetail2.branch = "U" 
    wdetail2.delerco = "MS0C106" .
IF wdetail2.deler  = "ISUZU PHRAE" THEN  ASSIGN wdetail2.branch = "2" 
    wdetail2.delerco = "MS0C152" .
IF wdetail2.deler  = "Isuzu Phranakorn Co.,ltd" THEN  ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C008" .
IF wdetail2.deler  = "ISUZU PICHIT (1999)" THEN DO: 
    ASSIGN wdetail2.branch = "H" .
    IF wdetail2.showroom = "พิจิตร(สนญ)" OR wdetail2.showroom = "พิจิตร" THEN wdetail2.delerco = "MS0C072" .
    IF wdetail2.showroom = "กำแพงเพชร"      THEN wdetail2.delerco = "MS0C071" .
    IF wdetail2.showroom = "นครสวรรค์(สนญ)" OR wdetail2.showroom = "นครสวรรค์" THEN ASSIGN wdetail2.delerco = "MS0C292" 
        wdetail2.branch = "1" .
END.
IF wdetail2.deler  = "ISUZU PITSANULOK HOCK AN TUENG"  THEN ASSIGN wdetail2.branch = "H" 
    wdetail2.delerco = "MS0C053" .
IF wdetail2.deler  = "ISUZU PRACHINBURI MOTOR SALES" THEN  ASSIGN wdetail2.branch = "5" 
    wdetail2.delerco = "MS0C319" .
IF wdetail2.deler  = "ISUZU PRAKIT MOTOR BANPONG CO." THEN  ASSIGN wdetail2.branch = "U" 
    wdetail2.delerco = "MS0C101" .   /*บ้านโป่ง*/
IF wdetail2.deler  = "ISUZU RANONG CO., LTD." THEN  ASSIGN wdetail2.branch = "B"
    wdetail2.delerco = "MS0C359" .
IF wdetail2.deler  = "ISUZU RATCHABURI SALES" OR wdetail2.deler  = "ISUZU RATCHABURI SALES CO.,LTD"THEN DO:  
    ASSIGN wdetail2.branch = "U" 
        wdetail2.delerco = "MS0C102" .
    IF wdetail2.showroom = "ราชบุรี (สนญ)" OR wdetail2.showroom = "ราชบุรี" THEN wdetail2.delerco = "MS0C122" .
END.
IF wdetail2.deler  = "Isuzu Saeng Fah Co.,ltd" THEN  ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C038" .
IF wdetail2.deler  = "Isuzu Phranakorn Co.,ltd" THEN  ASSIGN wdetail2.branch = "M". 
IF wdetail2.deler  = "Isuzu Saenghong Bangkok Co.,ltd" THEN  ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C017" .
IF wdetail2.deler  = "ISUZU SAHAPHAN AUTO SALES" OR wdetail2.deler  = "ISUZU SAHAPHAN AUTO SALES CO.," THEN DO:  
    ASSIGN wdetail2.branch = "U"
        wdetail2.delerco = "MS0C111" .
    IF wdetail2.showroom = "กาญจนบุรี (สนญ)" OR wdetail2.showroom = "กาญจนบุรี" THEN wdetail2.delerco = "MS0C123" .
END.
IF (wdetail2.deler  = "ISUZU SAKAEW") OR (wdetail2.deler  = "ISUZU SAKAEW CO., LTD.") THEN DO: 
    ASSIGN wdetail2.branch = "5"
        wdetail2.delerco = "MS0C320" .
    IF wdetail2.showroom = "ปราจีนบุรี (สนญ)" OR wdetail2.showroom = "ปราจีนบุรี" THEN wdetail2.delerco = "MS0C336" .
    IF wdetail2.showroom = "อรัญประเทศ"      THEN wdetail2.delerco = "MS0C338" .
    IF wdetail2.showroom = "สระแก้ว (สนญ)" OR wdetail2.showroom = "สระแก้ว" THEN wdetail2.delerco = "MS0C337" .
END.
IF wdetail2.deler  = "ISUZU SALA FASTER CHIENGMAI L." THEN ASSIGN wdetail2.branch = "2" 
    wdetail2.delerco = "MS0C171" .
IF wdetail2.deler  = "ISUZU SANGUANTHAI CHIANGRAI CO" THEN  ASSIGN wdetail2.branch = "2"
    wdetail2.delerco = "MS0C059" .
IF wdetail2.deler  = "ISUZU SANGUANTHAI MOTOR SALES" THEN  ASSIGN wdetail2.branch = "F"
    wdetail2.delerco = "MS0C274" .
IF wdetail2.deler  = "ISUZU SANGUANTHAI SARABURI CO." THEN  ASSIGN wdetail2.branch = "J"
    wdetail2.delerco = "MS0C079" .
IF wdetail2.deler  = "ISUZU SENIYONT N'SAWAN" THEN DO:  
    ASSIGN wdetail2.branch = "1".
    IF wdetail2.showroom = "พิจิตร(สนญ)" OR wdetail2.showroom = "พิจิตร" THEN wdetail2.delerco = "MS0C047" .
    IF wdetail2.showroom = "นครสวรรค์(สนญ)" OR wdetail2.showroom = "นครสวรรค์" THEN wdetail2.delerco = "MS0C045" .
    IF wdetail2.showroom = "สะพานเดชา" THEN wdetail2.delerco = "MS0C046" .
    IF wdetail2.showroom = "กำแพงเพชร" THEN ASSIGN wdetail2.branch = "H"
        wdetail2.delerco = "MS0C073" .
END.
IF wdetail2.deler  = "Isuzu Siam City Co.,ltd." THEN  ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C001" .
IF wdetail2.deler  = "ISUZU SIENG PAISAN KAMPAENGPET" THEN  ASSIGN wdetail2.branch = "H" 
    wdetail2.delerco = "MS0C288" .
IF wdetail2.deler  = "ISUZU SIENG PHAISAL CO.,LTD." THEN  ASSIGN wdetail2.branch = "H" 
    wdetail2.delerco = "MS0C287" .
IF wdetail2.deler  = "ISUZU SUPORNPHAN CHUMPORN CO.," THEN DO:  
    ASSIGN wdetail2.branch = "B" .
    IF wdetail2.showroom = "ท่าแซะ"    THEN wdetail2.delerco = "MS0C356" .
    IF wdetail2.showroom = "หลังสวน" OR wdetail2.showroom = "สาขาหลังสวน " THEN wdetail2.delerco = "MS0C358" .
    IF wdetail2.showroom = "สวี" OR wdetail2.showroom = "สาขาสวี" THEN wdetail2.delerco = "MS0C357" .
    IF wdetail2.showroom = "ในเมืองชุมพร" OR wdetail2.showroom = "เมืองชุมพร" OR wdetail2.showroom = "ในเมือง" THEN wdetail2.delerco = "MS0C356" .
END.
IF wdetail2.deler  = "ISUZU SURATTHANI CO.,LTD." THEN DO:  
    ASSIGN wdetail2.branch = "7" 
        wdetail2.delerco = "MS0C316".
    IF wdetail2.showroom = "เวียงสระ"    THEN wdetail2.delerco = "MS0C350" .
    IF wdetail2.showroom = "ในเมือง" THEN wdetail2.delerco = "MS0C316" .
    IF wdetail2.showroom = "กม.5"  THEN wdetail2.delerco = "MS0C351" .
    IF wdetail2.showroom = "บ้านดอน"    THEN wdetail2.delerco = "MS0C353" .
    IF wdetail2.showroom = "เกาะสมุย" THEN ASSIGN wdetail2.delerco = "MS0C355" 
        wdetail2.branch = "9".
END.
IF wdetail2.deler  = "Isuzu Suvarnabhumi  Co.,ltd" THEN  ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C024" . 
IF wdetail2.deler  = "ISUZU TANG PARK AMNART JAREARN" THEN ASSIGN wdetail2.branch = "K"
    wdetail2.delerco = "MS0C220" . 
IF wdetail2.deler  = "ISUZU TANG PARK SRISAKET CO.,L" THEN DO: 
    ASSIGN wdetail2.branch = "K"
        wdetail2.delerco = "MS0C214" .  
END.
IF  (wdetail2.deler  = "ISUZU TANGPARK PAK ISAN CO.,LT") OR (wdetail2.deler  = "ISUZU TANG PARK PAK ISAN CO.,LT") OR 
    (wdetail2.deler  = "ISUZU TANG PARK UBON CO.,LTD.") THEN DO: 
    ASSIGN wdetail2.branch = "K" 
        wdetail2.delerco = "MS0C228" .
    IF wdetail2.showroom = "อุบล" THEN wdetail2.delerco = "MS0C216" .
    IF wdetail2.showroom = "ตระการพืชผล" THEN wdetail2.delerco = "MS0C217" .
    IF wdetail2.showroom = "วารินชำราบ" THEN wdetail2.delerco = "MS0C215" .
    IF wdetail2.showroom = "มุกดาหาร" THEN wdetail2.delerco = "MS0C218" .
    IF wdetail2.showroom = "กันทรลักษ์" THEN wdetail2.delerco = "MS0C324" .
END.
IF wdetail2.deler  = "ISUZU TANG PARK YASOTHORN CO.," THEN ASSIGN wdetail2.branch = "K"
    wdetail2.delerco = "MS0C219" .
IF wdetail2.deler  = "ISUZU TAK HOCK AN TUENG CO.,LT" THEN  ASSIGN wdetail2.branch = "H"
    wdetail2.delerco = "MS0C069" .
IF wdetail2.deler  = "ISUZU TANG SIA HUAT NAKORNPATH" OR wdetail2.deler = "Isuzu Tang Sia Huat Nakornpathom Co.,ltd" THEN DO:  
    ASSIGN wdetail2.branch = "U" .
    IF wdetail2.showroom = "สาขาสระกระเทียม" OR wdetail2.showroom = "สระกระเทียม" THEN wdetail2.delerco = "MS0C107" .
    IF wdetail2.showroom = "สาขากำแพงแสน" OR wdetail2.showroom = "กำแพงแสน" THEN wdetail2.delerco = "MS0C109" .
    IF wdetail2.showroom = "สาขาบางเลน" OR wdetail2.showroom = "บางเลน" THEN wdetail2.delerco = "MS0C110" .
    IF wdetail2.showroom = "สาขาทุ่งพระเมรุ" OR wdetail2.showroom = "ทุ่งพระเมรุ" THEN wdetail2.delerco = "MS0C108" .
END.
IF wdetail2.deler  = "ISUZU TRAD SALES" OR wdetail2.deler  = "ISUZU TRAD SALES L.P."  THEN DO: 
    ASSIGN wdetail2.branch = "5".
    IF wdetail2.showroom = "ตราด (สนญ)" OR wdetail2.showroom = "ตราด" THEN wdetail2.delerco = "MS0C339" .
    ELSE wdetail2.delerco = "MS0C323" .
END.
IF (wdetail2.deler  = "ISUZU UNG NGUAN TAI AUTO SALES") OR (wdetail2.deler  = "ISUZU UNG NGUAN TAI NAKORNPATH") OR
    (wdetail2.deler  = "ISUZU UNG NGUAN TAI SUPHAN CO.") OR (wdetail2.deler  = "Isuzu Ung Nguan tai Suphan Co.,ltd") OR
    (wdetail2.deler  = "ISUZU UNG NGUAN TAI BANGKOK CO")THEN DO: 
    ASSIGN wdetail2.branch = "U"
        wdetail2.delerco = "MS0C104" .
    IF wdetail2.showroom = "สามพราน" THEN wdetail2.delerco = "MS0C105" .
    IF wdetail2.showroom = "สาขาอู่ทอง" OR wdetail2.showroom = "อู่ทอง" THEN wdetail2.delerco = "MS0C115" .
    IF wdetail2.showroom = "สาขาสองพี่น้อง" OR wdetail2.showroom = "สองพี่น้อง" THEN wdetail2.delerco = "MS0C116" .
    IF wdetail2.showroom = "สาขาด่านช้าง" OR wdetail2.showroom = "ด่านช้าง" THEN wdetail2.delerco = "MS0C117" .
    IF wdetail2.showroom = "บางสะพาน" THEN ASSIGN wdetail2.branch = "A"
        wdetail2.delerco = "MS0C258" .
END.
IF wdetail2.deler  = "Isuzu Ung Nguan Thai Auto Sales Co.,ltd"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C002" .
IF wdetail2.deler  = "ISUZU UTHAITHANI" OR wdetail2.deler  = "ISUZU UTHAITHANI CO.,LTD."  THEN DO:  
    ASSIGN wdetail2.branch = "1"
        wdetail2.delerco = "MS0C289" .
    IF wdetail2.showroom = "ชัยนาท(สนญ)" OR wdetail2.showroom = "ชัยนาท" THEN wdetail2.delerco = "MS0C048" .
    IF wdetail2.showroom = "อุทัยธานี(สนญ)" OR wdetail2.showroom = "อุทัยธานี" THEN wdetail2.delerco = "MS0C049" .
END.
IF wdetail2.deler  = "Isuzu V Motor  Co.,ltd"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C029" .
IF wdetail2.deler  = "KING'S YONT"  THEN DO: 
    ASSIGN wdetail2.branch = "6".
    IF wdetail2.showroom = "ปากช่อง"    THEN wdetail2.delerco = "MS0C185" .
    IF wdetail2.showroom = "พิมาย" THEN wdetail2.delerco = "MS0C186" .
    IF wdetail2.showroom = "อ.เมืองโคราช (สนญ)" OR wdetail2.showroom = "อ.เมืองโคราช" THEN wdetail2.delerco = "MS0C184" .
    IF wdetail2.showroom = "นางรอง"    THEN wdetail2.delerco = "MS0C189" .
    IF wdetail2.showroom = "บุรีรัมย์" THEN wdetail2.delerco = "MS0C195" .
    IF wdetail2.showroom = "สีดา" THEN wdetail2.delerco = "MS0C187" .
END.
IF wdetail2.deler  = "KOW MOTORS"  THEN DO: 
    ASSIGN wdetail2.branch = "3".
    IF wdetail2.showroom = "กระนวน"    THEN wdetail2.delerco = "MS0C308" .
    IF wdetail2.showroom = "บ้านไผ่" THEN wdetail2.delerco = "MS0C307" .
    IF wdetail2.showroom = "พยัคฆภูมิพิสัย" THEN wdetail2.delerco = "MS0C312" .
    IF wdetail2.showroom = "วังสะพุง"    THEN wdetail2.delerco = "MS0C314" .
    IF wdetail2.showroom = "หนองเรือ" THEN wdetail2.delerco = "MS0C310" .
    IF wdetail2.showroom = "อ.เมืองขอนแก่น (สนญ)" OR wdetail2.showroom = "อ.เมืองขอนแก่น" THEN wdetail2.delerco = "MS0C306" .
    IF wdetail2.showroom = "อ.เมืองมหาสารคาม (สนญ)" OR wdetail2.showroom = "อ.เมืองมหาสารคาม" THEN wdetail2.delerco = "MS0C311" .
    IF wdetail2.showroom = "อ.เมืองร้อยเอ็ด (สนญ)" OR wdetail2.showroom = "อ.เมืองร้อยเอ็ด" THEN wdetail2.delerco = "MS0C309" .
    IF wdetail2.showroom = "อ.เมืองเลย (สนญ)" OR wdetail2.showroom = "อ.เมืองเลย" THEN wdetail2.delerco = "MS0C313" .
    IF wdetail2.showroom = "อ.พล (สนญ)" OR wdetail2.showroom = "อ.พล" THEN wdetail2.delerco = "MS0C315" .
END.
IF wdetail2.deler  = "Kow Yoo hah Isuzu Sales Co.,ltd"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C018" .
IF wdetail2.deler  = "KOW YOO HAH LAMPANG CO.,LTD."  THEN ASSIGN wdetail2.branch = "2"
    wdetail2.delerco = "MS0C170" .
IF wdetail2.deler  = "KOW YOO HAH MOTORS CO.,LTD."  THEN ASSIGN wdetail2.branch = "3"
    wdetail2.delerco = "MS0C294" .
IF wdetail2.deler  = "KOW YOO HAH MOTORS CO.,LTD. (M"  THEN ASSIGN wdetail2.branch = "3"
    wdetail2.delerco = "MS0C295" .
IF wdetail2.deler  = "KOW YOO HAH MOTORS CO. ROI-ED"  THEN ASSIGN wdetail2.branch = "3"
    wdetail2.delerco = "MS0C293" .
IF wdetail2.deler  = "NAKORN NAYOK ISUZU" OR wdetail2.deler  = "NAKORN NAYOK ISUZU SALES CO.,"  THEN DO: 
    ASSIGN wdetail2.branch = "J"
        wdetail2.delerco = "MS0C075" .
    IF wdetail2.showroom = "นครนายก (สนญ)" OR wdetail2.showroom = "นครนายก" THEN wdetail2.delerco = "MS0C098" .
    IF wdetail2.showroom = "องครักษ์" THEN wdetail2.delerco = "MS0C099" .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_assign_OTH C-Win 
PROCEDURE pro_assign_OTH :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail2.deler  = "บริษัท โค้วยู่ฮะอีซูซุเซลส์ จำกัด"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C118" .
IF wdetail2.deler  = " "  THEN ASSIGN wdetail2.branch = "2"
    wdetail2.delerco = "MS0C000" .
IF wdetail2.deler  = "บริษัท โค้วยู่ฮะลำปาง จำกัด"  THEN ASSIGN wdetail2.branch = "2"
    wdetail2.delerco = "MS0C170" .
IF wdetail2.deler  = "บริบัท หาดใหญ่สหมอเตอร์ จก."  THEN ASSIGN wdetail2.branch = "4"
    wdetail2.delerco = "MS0C205" .
IF wdetail2.deler  = "บริบัท อีซูซุตังปักภาคอีสาน จำกัด"  THEN ASSIGN wdetail2.branch = "K"
    wdetail2.delerco = "MS0C215" .
IF wdetail2.deler  = "บริษัท โค้วยู่ฮะมอเตอร์ จำกัด"  THEN ASSIGN wdetail2.branch = "3"
    wdetail2.delerco = "MS0C294" .
IF wdetail2.deler  = "บริษัท โค้วยู่ฮะ มอเตอร์ จำกัด สาขาร้อยเอ็ด"  THEN ASSIGN wdetail2.branch = "3"
    wdetail2.delerco = "MS0C293" .
IF wdetail2.deler  = "บริษัท จึงกงเฮงอีซูซุ จำกัด" THEN ASSIGN wdetail2.branch = "J"
    wdetail2.delerco = "MS0C077" .
IF wdetail2.deler  = "บริษัท ชลบุรี อีซูซุเซลส์ จำกัด" THEN ASSIGN wdetail2.branch = "5"
    wdetail2.delerco = "MS0C322" .
IF wdetail2.deler  = "บริษัท ซ.แสงมงคลอีซูซุอยุธยา จำกัด" THEN ASSIGN wdetail2.branch = "J"
    wdetail2.delerco = "MS0C082" .
IF wdetail2.deler  = "บริษัท นครนายกอีซูซุเซลส์ จำกัด" THEN ASSIGN wdetail2.branch = "J"
    wdetail2.delerco = "MS0C075" .
IF wdetail2.deler  = "บริษัท ประกิตมอเตอร์เซลส์ จำกัด" THEN ASSIGN wdetail2.branch = "U"
    wdetail2.delerco = "MS0C100" .
IF wdetail2.deler  = "บริษัท ประจักษ์อุตสาหกรรม (1982) จำกัด" THEN ASSIGN wdetail2.branch = "7"
    wdetail2.delerco = "MS0C316" .
IF wdetail2.deler  = "บริษัท พันธุ์เจริญ จำกัด" THEN ASSIGN wdetail2.branch = "J"
    wdetail2.delerco = "MS0C084" .
IF wdetail2.deler  = "บริษัท ระยองอีซูซุเซลส์ จำกัด" THEN ASSIGN wdetail2.branch = "5"
    wdetail2.delerco = "MS0C318" .
IF wdetail2.deler  = "บริษัท ลพบุรีอีซูซุเซลส์ จำกัด" THEN ASSIGN wdetail2.branch = "J"
    wdetail2.delerco = "MS0C078" . 
IF wdetail2.deler  = "บริษัท สิงห์บุรี อีซูซุ เซลส์ จำกัด" THEN ASSIGN wdetail2.branch = "J"
    wdetail2.delerco = "MS0C081" .
IF wdetail2.deler  = "บริษัท อยุธยาอีซูซุเซลส์ จำกัด" THEN ASSIGN wdetail2.branch = "J"
    wdetail2.delerco = "MS0C076" .
IF wdetail2.deler  = "บริษัท อีซูซุกรุงเทพเซลส์ จำกัด" THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C019" .
IF wdetail2.deler  = "บริษัท อีซูซุกาญจนบุรี จำกัด" THEN ASSIGN wdetail2.branch = "U"
    wdetail2.delerco = "MS0C112" .
IF wdetail2.deler  = "บริษัท อีซูซุคิงส์ยนต์กรุงเทพ จำกัด" THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C007" .
IF wdetail2.deler  = "บริษัท อีซูซุชัยนาท จำกัด" THEN ASSIGN wdetail2.branch = "1"
    wdetail2.delerco = "MS0C286" .
IF wdetail2.deler  = "บริษัท อีซูซุเชียงราย (2002) จำกัด" THEN ASSIGN wdetail2.branch = "2"
    wdetail2.delerco = "MS0C169" .
IF wdetail2.deler  = "บริษัท อีซูซุเชียงใหม่เซลส์ จำกัด" THEN ASSIGN wdetail2.branch = "2"
    wdetail2.delerco = "MS0C168" .
IF wdetail2.deler  = "บริษัท อีซูซุตะวันออก ชลบุรี จำกัด" THEN ASSIGN wdetail2.branch = "5"
    wdetail2.delerco = "MS0C317" .
IF wdetail2.deler  = "บริษัท อีซูซุตั้งเซียฮวดนครปฐม จำกัด"  THEN DO: 
    ASSIGN wdetail2.branch = "U".
    IF wdetail2.showroom = "สาขากำแพงแสน" OR wdetail2.showroom = "กำแพงแสน" THEN wdetail2.delerco = "MS0C109" .
    IF wdetail2.showroom = "สาขาทุ่งพระเมรุ" OR wdetail2.showroom = "ทุ่งพระเมรุ" THEN wdetail2.delerco = "MS0C108" .
    IF wdetail2.showroom = "สาขาบางเลน" OR wdetail2.showroom = "บางเลน" THEN wdetail2.delerco = "MS0C110" .
    IF wdetail2.showroom = "สาขาสระกระเทียม" OR wdetail2.showroom = "สระกระเทียม" THEN wdetail2.delerco = "MS0C107" .
END.
IF wdetail2.deler  = "บริษัท อีซูซุตังปักมุกดาหาร จำกัด"  THEN ASSIGN wdetail2.branch = "K"
    wdetail2.delerco = "MS0C218" .
IF wdetail2.deler  = "บริษัท อีซูซุตังปักยโสธร จำกัด"  THEN ASSIGN wdetail2.branch = "K"
    wdetail2.delerco = "MS0C219" .
IF wdetail2.deler  = "บริษัท อีซูซุตังปักศรีสะเกษ จำกัด"  THEN ASSIGN wdetail2.branch = "K"
    wdetail2.delerco = "MS0C214" .
IF wdetail2.deler  = "บริษัท อีซูซุปฐมยนตรกาญจน์ จำกัด" THEN ASSIGN wdetail2.branch = "U"
    wdetail2.delerco = "MS0C106" .
IF wdetail2.deler  = "บริษัท อีซูซุประกิตมอเตอร์บ้านโป่ง จำกัด" THEN ASSIGN wdetail2.branch = "U"
    wdetail2.delerco = "MS0C101" .
IF wdetail2.deler  = "บริษัท อีซูซุปราจีนบุรีมอเตอร์เซลส์ จำกัด" THEN ASSIGN wdetail2.branch = "5"
    wdetail2.delerco = "MS0C319" .
IF wdetail2.deler  = "บริษัท อีซูซุพระนคร จำกัด" THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C008" .
IF wdetail2.deler  = "บริษัท อีซูซุมหานคร จำกัด" OR wdetail2.deler  = "บริษัท อีซูซุมหานครจำกัด" THEN DO:
    ASSIGN wdetail2.branch = "M"
        wdetail2.delerco = "MS0C014" .
    IF wdetail2.showroom = "สาขาสมุทรสาคร" OR wdetail2.showroom = "สมุทรสาคร" THEN ASSIGN wdetail2.branch = "F" 
        wdetail2.delerco = "MS0C276" .
    IF wdetail2.showroom = "สาขาอ้อมน้อย" OR wdetail2.showroom = "อ้อมน้อย" THEN ASSIGN wdetail2.branch = "F" 
        wdetail2.delerco = "MS0C277" .
END.
IF wdetail2.deler  = "บริษัท อีซูซุ ปัตาตานี เจรฺญเทรดดิ้ง 1972"  THEN ASSIGN wdetail2.branch = "D"
    wdetail2.delerco = "MS0C204" .
IF wdetail2.deler  = "บริษัท อีซูซุนครหลวง จำกัด"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C003" .
IF wdetail2.deler  = "บริษัท อีซูซุเมโทร จำกัด"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C015" .
IF wdetail2.deler  = "บริษัทอีซูซุระนอง"  THEN ASSIGN wdetail2.branch = "B"
    wdetail2.delerco = "MS0C359" .
IF wdetail2.deler  = "บริษัท อีซูซุราชบุรีเซลส์ จำกัด"  THEN ASSIGN wdetail2.branch = "U"
    wdetail2.delerco = "MS0C102" .
IF wdetail2.deler  = "บริษัท อีซูซุ วี มอเตอร์ จำกัด"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C029" .
IF wdetail2.deler  = "บริษัท อีซูซุสงวนไทยมอเตอร์เซลล์ จำกัด"  THEN ASSIGN wdetail2.branch = "A"
    wdetail2.delerco = "MS0C249" .
IF wdetail2.deler  = "บริษัทอีซูซุ สงวนไทยมอเตอร์เซลล์จำกัด"  THEN ASSIGN wdetail2.branch = "F"
    wdetail2.delerco = "MS0C274" .
IF wdetail2.deler  = "บริษัท อีซูซุสงวนไทย สระบุรี จำกัด"  THEN ASSIGN wdetail2.branch = "J"
    wdetail2.delerco = "MS0C079" .
IF wdetail2.deler  = "บริษัท อีซูซุสยามซิตี้ จำกัด"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C001" .
IF wdetail2.deler  = "บริษัท อีซูซุสระแก้ว จำกัด"  THEN ASSIGN wdetail2.branch = "5"
    wdetail2.delerco = "MS0C320" .
IF wdetail2.deler  = "บริษัท อีซูซุสวงนไทยกรุงเทพ จำกัด"  THEN ASSIGN wdetail2.branch = "F"
    wdetail2.delerco = "MS0C274" .
IF wdetail2.deler  = "บริษัท อีซูซุสหะภัณฑ์ออโต้เซลส์ จำกัด"  THEN ASSIGN wdetail2.branch = "U"
    wdetail2.delerco = "MS0C111" .
IF wdetail2.deler  = "บริษัทอีซูซุสุภรณ์ภัณฑ์"  THEN ASSIGN wdetail2.branch = "B"
    wdetail2.delerco = "MS0C360" .
IF wdetail2.deler  = "บริษัท อีซูซุสุวรรณภูมิ จำกัด"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C024" .
IF wdetail2.deler  = "บริษัท อีซูซุเสียงไพศาลกำแพงเพชร จำกัด"  THEN ASSIGN wdetail2.branch = "H"
    wdetail2.delerco = "MS0C288" .
IF wdetail2.deler  = "บริษัท อีซูซุเสียงไพศาล จำกัด"  THEN ASSIGN wdetail2.branch = "H"
    wdetail2.delerco = "MS0C287" .
IF wdetail2.deler  = "บริษัท อีซูซุแสงฟ้า จำกัด"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C038" .
IF wdetail2.deler  = "บริษัท อีซูซุแสงหงส์บางกอก จำกัด"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C017" .
IF wdetail2.deler  = "บริษัท อีซูซุออโต้เซ็นเตอร์ จำกัด"  THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C043" .
IF wdetail2.deler  = "บริษัท อีซูซุหาดใหญ่จำกัด" OR wdetail2.deler  = "บริษัท อีซูซุหาดใหญ่ จำกัด" OR wdetail2.deler  = "บริษัท อีซูซุหาดใหญ่ จำกัด (" THEN DO:  
    ASSIGN wdetail2.branch = "4"
        wdetail2.delerco = "MS0C203" .
    IF wdetail2.showroom = "สาขาละงู" OR wdetail2.showroom = "ละงู" THEN wdetail2.delerco = "MS0C207" .
    IF wdetail2.showroom = "สาขาสตูล " OR wdetail2.showroom = "สตูล " THEN wdetail2.delerco = "MS0C206" .
    IF wdetail2.showroom = "สาขาแม่ขรี" OR wdetail2.showroom = "แม่ขรี" THEN ASSIGN wdetail2.branch = "E"
        wdetail2.delerco = "MS0C263" .   
    IF wdetail2.showroom = "สาขาพัทลุง" OR wdetail2.showroom = "พัทลุง" THEN ASSIGN wdetail2.branch = "E"
        wdetail2.delerco = "MS0C261" .
END.
IF wdetail2.deler  = "บริษัท อีซูซุ อันดามันเซลล์ จำกัด"  THEN DO:
    ASSIGN wdetail2.branch = "E".
    IF wdetail2.showroom = "สาขาย่านตาขาว" OR wdetail2.showroom = "ย่านตาขาว" THEN wdetail2.delerco = "MS0C260" .
    IF wdetail2.showroom = "สาขาห้วยยอด" OR wdetail2.showroom = "ห้วยยอด" THEN wdetail2.delerco = "MS0C261" .
    IF wdetail2.showroom = "สาขาตรัง"OR wdetail2.showroom = "ตรัง" THEN wdetail2.delerco = "MS0C259" .
    IF wdetail2.showroom = "สาขาตะกั่วป่า" OR wdetail2.showroom = "ตะกั่วป่า" THEN ASSIGN wdetail2.branch = "8" 
        wdetail2.delerco = "MS0C281" .         
    IF wdetail2.showroom = "สาขาเกาะแก้ว" OR wdetail2.showroom = "เกาะแก้ว" THEN ASSIGN wdetail2.branch = "8" 
        wdetail2.delerco = "MS0C279" .      
    IF wdetail2.showroom = "สาขาภูเก็ต"OR wdetail2.showroom = "ภูเก็ต" THEN ASSIGN wdetail2.branch = "8" 
        wdetail2.delerco = "MS0C280" .      
    IF wdetail2.showroom = "สาขาโคกกลอย" OR wdetail2.showroom = "โคกกลอย" THEN ASSIGN wdetail2.branch = "8" 
        wdetail2.delerco = "MS0C278" .
END.
IF wdetail2.deler  = "บริษัท อีซูซุอุทัยธานี จำกัด" THEN ASSIGN wdetail2.branch = "1"
    wdetail2.delerco = "MS0C289" .
IF wdetail2.deler  = "บริษัท อีซูซุอึ้งง่วนไต๋ออโต้เซลส์ จำกัด" THEN ASSIGN wdetail2.branch = "M"
    wdetail2.delerco = "MS0C002" .
IF wdetail2.deler  = "บริษัท อีซูซุฮั่วเชียงจั่น จำกัด" THEN ASSIGN wdetail2.branch = "5"
    wdetail2.delerco = "MS0C321" .
IF wdetail2.deler  = "บริษัท อีซูซุอึ้งง่วนไต๋นครปฐม จำกัด" THEN ASSIGN wdetail2.branch = "U"
    wdetail2.delerco = "MS0C105" .
IF wdetail2.deler  = "บริษัท อีซูซุ อึ้งง่วนไต๋ นครปฐม จำกัด" THEN ASSIGN wdetail2.branch = "U"
    wdetail2.delerco = "MS0C104" .
IF wdetail2.deler  = "บริษัท อีซูซุอึ้งง่วนไต๋ สุพรรณ จำกัด" OR wdetail2.deler  = "บริษัท อีซูซุอึ้งง่วนไต๋ สุพรรณ จำกัด(สนญ.)" OR 
    wdetail2.deler  = "บริษัท อีซูซุอึ้งง่วนไต๋ สุพรรณ จำกัด(สาขาสอง" THEN DO: 
    ASSIGN wdetail2.branch = "U"
        wdetail2.delerco = "MS0C113" .
    IF wdetail2.showroom = "สาขาสองพี่น้อง" OR wdetail2.showroom = "สองพี่น้อง" THEN wdetail2.delerco = "MS0C116" .
    IF wdetail2.showroom = "สาขาสามชุก" OR wdetail2.showroom = "สามชุก" THEN wdetail2.delerco = "MS0C114" .
    IF wdetail2.showroom = "สาขาอู่ทอง" OR wdetail2.showroom = "อู่ทอง" THEN wdetail2.delerco = "MS0C115" .
    IF wdetail2.showroom = "สาขาด่านช้าง" OR wdetail2.showroom = "ด่านช้าง" THEN wdetail2.delerco = "MS0C117" .
END.
IF wdetail2.deler  = "บริษัท อึ้งง่วนไต๋ อีซูซุเซลล์ จำกัด"  THEN DO:
    ASSIGN wdetail2.branch = "A".
    IF wdetail2.showroom = "สาขาเพชรบุรี(สำนักงานใหญ่)" OR wdetail2.showroom = "เพชรบุรี" THEN wdetail2.delerco = "MS0C247" .
    IF wdetail2.showroom = "สาขาชะอำ" OR wdetail2.showroom = "ชะอำ" THEN wdetail2.delerco = "MS0C248" .
    IF wdetail2.showroom = "สาขาบางสะพาน" OR wdetail2.showroom = "บางสะพาน" THEN wdetail2.delerco = "MS0C252" .
    IF wdetail2.showroom = "สาขาประจวบคีรีขันธ์" OR wdetail2.showroom = "ประจวบคีรีขันธ์" THEN wdetail2.delerco = "MS0C251" .
    IF wdetail2.showroom = "สาขาปราณบุรี" OR wdetail2.showroom = "ปราณบุรี" THEN wdetail2.delerco = "MS0C250" .
END.
IF wdetail2.deler  = "บริษัท ฮีซูซุตังปักอำนาจเจริญ จำกัด"  THEN ASSIGN wdetail2.branch = "K"
    wdetail2.delerco = "MS0C216" .
IF wdetail2.deler  = "บริษัท ฮีซูซุตังปักอุบล จำกัด"  THEN ASSIGN wdetail2.branch = "K"
    wdetail2.delerco = "MS0C217" .
IF wdetail2.deler  = "บริษัท ฮึ้งง่วนไต๋ อ๊ซูซุเซลล์จำกัด"  THEN ASSIGN wdetail2.branch = "A"
    wdetail2.delerco = "MS0C253" .
IF wdetail2.deler  = "บริษัท เฮียบหงวนอีซูซุเซลส์ จำกัด"  THEN ASSIGN wdetail2.branch = "S"
    wdetail2.delerco = "MS0C273" .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_assign_OTH1 C-Win 
PROCEDURE pro_assign_OTH1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail2.deler  = "หจก.บำรุงยนต์"  THEN DO:
    ASSIGN wdetail2.branch = "6"
        wdetail2.delerco = "MS0C190" .
    IF wdetail2.showroom = "อ.สังขะ  จ.สุรินทร์"    THEN wdetail2.delerco = "MS0C181" .
    IF wdetail2.showroom = "อ.ปราสาท จ.สุรินทร์"       THEN wdetail2.delerco = "MS0C182" .
    IF wdetail2.showroom = "อ.ชุมพลบุรี จ.สุรินทร์" THEN wdetail2.delerco = "MS0C183" .
END.
IF wdetail2.deler  = "หจก.สหะภัณฑ์ทรงพล"  THEN ASSIGN wdetail2.branch = "U"
    wdetail2.delerco = "MS0C118" .
IF wdetail2.deler  = "หจก. อีซูซุ ศาลา ฟาสเตอร์ เชียงใหม่"  THEN ASSIGN wdetail2.branch = "2"
    wdetail2.delerco = "MS0C171" .
IF wdetail2.deler  = "ห้างหุ้นส่วนจำกัด เฮียบหงวนมิลเลอร์"  THEN ASSIGN wdetail2.branch = "3"
    wdetail2.delerco = "MS0C348" .
IF wdetail2.deler  = "หาดใหญ๋สหมอเตอร์ จำกัด"  THEN ASSIGN wdetail2.branch = "4"
    wdetail2.delerco = "MS0C202" .
IF wdetail2.deler  = "อีซูซุ น่าน"  THEN ASSIGN wdetail2.branch = "2"
    wdetail2.delerco = "MS0C143" .
IF wdetail2.deler  = "อีซูซุ แพร่"  THEN ASSIGN wdetail2.branch = "2"
    wdetail2.delerco = "MS0C142" .
IF wdetail2.deler  = "อีซูซุ ลำปาง "  THEN ASSIGN wdetail2.branch = "2"
    wdetail2.delerco = "MS0C141" .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_assign_T C-Win 
PROCEDURE pro_assign_T :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail2.deler  = "PHANCHAROEN  CO.,LTD." OR wdetail2.deler  = "PHANCHAROEN"  THEN DO: 
    ASSIGN wdetail2.branch = "J"
        wdetail2.delerco = "MS0C084" .
    IF wdetail2.showroom = "ลพบุรี (สนญ)" OR wdetail2.showroom = "ลพบุรี" THEN wdetail2.delerco = "MS0C093" .
END.
IF wdetail2.deler  = "PITSANULOK HOCK AN TUENG"  THEN DO: 
    ASSIGN wdetail2.branch = "H" .
    IF wdetail2.showroom = "พิษณุโลก(สนญ)" OR wdetail2.showroom = "พิษณุโลก" THEN wdetail2.delerco = "MS0C053" .
    IF wdetail2.showroom = "สุโขทัย(สนญ)" OR wdetail2.showroom = "สุโขทัย" THEN wdetail2.delerco = "MS0C054" .
    IF wdetail2.showroom = "อุตรดิษถ์(สนญ)" OR wdetail2.showroom = "อุตรดิษถ์" THEN wdetail2.delerco = "MS0C055" .
    IF wdetail2.showroom = "แม่สอด" THEN ASSIGN wdetail2.delerco = "MS0C056" 
        wdetail2.branch = "2" .
END.
IF wdetail2.deler  = "PRACHAKIJ MOTOR SALES" THEN DO: 
    ASSIGN wdetail2.branch = "U" .
    IF wdetail2.showroom = "จันทบุรี (สนญ)" OR wdetail2.showroom = "จันทบุรี" THEN wdetail2.delerco = "MS0C138" .
    IF wdetail2.showroom = "นายายอาม" THEN wdetail2.delerco = "MS0C139" .
    IF wdetail2.showroom = "สอยดาว" THEN wdetail2.delerco = "MS0C140" .
END.
IF wdetail2.deler  = "PRACHINBURI MOTOR SALES" THEN ASSIGN wdetail2.branch = "5" 
    wdetail2.delerco = "MS0C340" .
IF wdetail2.deler  = "PRAKIT MOTOR BANPONG" THEN DO: 
    ASSIGN wdetail2.branch = "U" .
    IF wdetail2.showroom = "บ้านโป่ง" THEN wdetail2.delerco = "MS0C125" .
    IF wdetail2.showroom = "ราชบุรี (สนญ)" OR wdetail2.showroom = "ราชบุรี" THEN wdetail2.delerco = "MS0C124" .
END.
IF wdetail2.deler  = "PRAKIT MOTOR SALES" OR wdetail2.deler  = "PRAKIT MOTOR SALES CO.,LTD."  THEN DO: 
    ASSIGN wdetail2.branch = "U" 
        wdetail2.delerco = "MS0C100" .
    IF wdetail2.showroom = "บ้านโป่ง" THEN wdetail2.delerco = "MS0C127" .
    IF wdetail2.showroom = "สาขาราชบุรี" OR wdetail2.showroom = "ราชบุรี (สนญ)" OR
        wdetail2.showroom = "สนญ.ราชบุรี" OR wdetail2.showroom = "ราชบุรี" THEN wdetail2.delerco = "MS0C126" .
END.
IF wdetail2.deler  = "SANGUANTHAI MOTOR"  THEN DO: 
    ASSIGN wdetail2.branch = "U".
    IF wdetail2.showroom = "แม่กลอง (สนญ)" THEN wdetail2.delerco = "MS0C129" .
    IF wdetail2.showroom = "บางเค็ม" THEN wdetail2.delerco = "MS0C130" .
END.
IF wdetail2.deler  = "RAYONG ISUZU" OR wdetail2.deler  =  "RAYONG ISUZU SALES CO.,LTD." THEN DO: 
    ASSIGN wdetail2.branch = "5" 
        wdetail2.delerco = "MS0C318" .
    IF wdetail2.showroom = "บางแสน (สนญ)" THEN wdetail2.delerco = "MS0C341" .
    IF wdetail2.showroom = "บ้านบึง" THEN wdetail2.delerco = "MS0C342" .
END. 
IF wdetail2.deler  = "SAENG HONG LEASING" THEN DO: 
    ASSIGN wdetail2.branch = "5" .
    IF wdetail2.showroom = "กบินทร์บุรี (สนญ)" OR wdetail2.showroom = "กบินทร์บุรี" THEN wdetail2.delerco = "MS0C346" .
    IF wdetail2.showroom = "บางปะกง" THEN wdetail2.delerco = "MS0C345" .
    IF wdetail2.showroom = "แปดริ้ว (สนญ)" OR wdetail2.showroom = "แปดริ้ว" THEN wdetail2.delerco = "MS0C343" .
    IF wdetail2.showroom = "พนมสารคาม" THEN wdetail2.delerco = "MS0C344" .
END.
IF wdetail2.deler  = "SAHAPHAN SONGPHOL" OR wdetail2.deler  = "SAHAPHAN SONGPHOL L.P." THEN DO: 
    ASSIGN wdetail2.branch = "U" 
        wdetail2.delerco = "MS0C118" .
    IF wdetail2.showroom = "กาญจนบุรี (สนญ)" OR wdetail2.showroom = "กาญจนบุรี" THEN wdetail2.delerco = "MS0C128" .
END. 
IF wdetail2.deler  = "SALA FASTER CHIENGMAI" OR wdetail2.deler  = "SANGUANTHAI CHIANGRAI" THEN DO: 
    ASSIGN wdetail2.branch = "2" .
    IF wdetail2.showroom = "ดอนจั่น(สนญ)" OR wdetail2.showroom = "ดอนจั่น" THEN wdetail2.delerco = "MS0C154" .
    IF wdetail2.showroom = "หน้าปริ๊นซ์(สนญ)" OR wdetail2.showroom = "หน้าปริ๊นซ์" THEN wdetail2.delerco = "MS0C153" .
    IF wdetail2.showroom = "เชียงราย(สนญ)" OR wdetail2.showroom = "เชียงราย" THEN wdetail2.delerco = "MS0C157" .
    IF wdetail2.showroom = "พาน" THEN wdetail2.delerco = "MS0C158" .
    IF wdetail2.showroom = "แม่สาย" THEN wdetail2.delerco = "MS0C159" .
END. 
IF wdetail2.deler  = "SANGUANTHAI MOTOR"  THEN DO: 
    ASSIGN wdetail2.branch = "U".
    IF wdetail2.showroom = "บางเค็ม"    THEN wdetail2.delerco = "MS0C130" .
    IF wdetail2.showroom = "แม่กลอง (สนญ)" OR wdetail2.showroom = "แม่กลอง" THEN wdetail2.delerco = "MS0C129" .
END.
IF wdetail2.deler  = "SANGUANTHAI SARABURI"  THEN DO: 
    ASSIGN wdetail2.branch = "J".
    IF wdetail2.showroom = "หนองแค (สนญ)" OR wdetail2.showroom = "หนองแค" THEN wdetail2.delerco = "MS0C097" .
END.
IF wdetail2.deler  = "SANTI ISUZU PHETCHABUN"  THEN DO: 
    ASSIGN wdetail2.branch = "1".
    IF wdetail2.showroom = "เพชรบูรณ์(สนญ)" OR wdetail2.showroom = "เพชรบูรณ์" THEN wdetail2.delerco = "MS0C050" .
    IF wdetail2.showroom = "บึงสามพัน"      THEN wdetail2.delerco = "MS0C052" .
    IF wdetail2.showroom = "หล่มสัก"        THEN wdetail2.delerco = "MS0C051" .
END.
IF wdetail2.deler  = "SIENG KAMPAENGPETCH"  THEN ASSIGN wdetail2.branch = "H"
    wdetail2.delerco = "MS0C074" .  /*wdetail2.showroom = "กำแพงเพชร(สนญ)"     */
IF wdetail2.deler  = "SIENG PAI SAN"  THEN ASSIGN wdetail2.branch = "1"
    wdetail2.delerco = "MS0C044" .  /*wdetail2.showroom = "นครสวรรค์(สนญ)"    */
IF wdetail2.deler  = "SINGBURI ISUZU SALES" OR wdetail2.deler  = "SINGBURI ISUZU SALES CO.,LTD." OR
    wdetail2.deler  = "SOR. AYUDHAYA" OR wdetail2.deler  = "SOR. SAENG MONGKOL ISUZU AYUDH"
    THEN DO: 
    ASSIGN wdetail2.branch = "J"
        wdetail2.delerco = "MS0C082" .
    IF wdetail2.showroom = "สิงห์บุรี (สนญ)" OR wdetail2.showroom = "สิงห์บุรี" THEN wdetail2.delerco = "MS0C094" .
    IF wdetail2.showroom = "ในเมือง"    THEN wdetail2.delerco = "MS0C096" .
    IF wdetail2.showroom = "ถ.สายเอเชีย (สนญ)" OR wdetail2.showroom = "ถ.สายเอเชีย" THEN wdetail2.delerco = "MS0C095" .
END.
IF wdetail2.deler  = "SUKHOTHAI HOCK AN TUENG" OR wdetail2.deler  = "SUKHOTHAI HOCK AN TUENG (1978)"  THEN DO: 
    ASSIGN wdetail2.branch = "H".
    IF wdetail2.showroom = "อีซูซุพิษณุโลกฮกอันตึ๊ง" OR wdetail2.showroom = "อีซูซุฮกอันตึ๊ง" THEN wdetail2.delerco = "MS0C053" .
    IF wdetail2.showroom = "พิษณุโลก(สนญ)" OR wdetail2.showroom = "พิษณุโลก" THEN wdetail2.delerco = "MS0C061" .
    IF wdetail2.showroom = "เมืองตาก(สนญ)" OR wdetail2.showroom = "เมืองตาก" THEN wdetail2.delerco = "MS0C064" .
    IF wdetail2.showroom = "สุโขทัย" THEN wdetail2.delerco = "MS0C062" .
    IF wdetail2.showroom = "อุตรดิษถ์(สนญ)" OR wdetail2.showroom = "อุตรดิษถ์" THEN wdetail2.delerco = "MS0C063" .
    IF wdetail2.showroom = "แม่สอด" THEN ASSIGN wdetail2.delerco = "MS0C065" 
        wdetail2.branch = "2".
END.
IF wdetail2.deler  = "TAK HOCK AN TUENG" THEN DO: 
    ASSIGN wdetail2.branch = "H".
    IF wdetail2.showroom = "พิษณุโลก(สนญ)" OR wdetail2.showroom = "พิษณุโลก" THEN wdetail2.delerco = "MS0C066" .
    IF wdetail2.showroom = "เมืองตาก(สนญ)" OR wdetail2.showroom = "เมืองตาก" THEN wdetail2.delerco = "MS0C069" .
    IF wdetail2.showroom = "สุโขทัย(สนญ)" OR wdetail2.showroom = "สุโขทัย" THEN wdetail2.delerco = "MS0C067" .
    IF wdetail2.showroom = "อุตรดิษถ์(สนญ)" OR wdetail2.showroom = "อุตรดิษถ์" THEN wdetail2.delerco = "MS0C068" .
    IF wdetail2.showroom = "แม่สอด" THEN  wdetail2.delerco = "MS0C070" .
END.
IF wdetail2.deler  = "TANG NAKORNPATHOM"  THEN DO: 
    ASSIGN wdetail2.branch = "U".
    IF wdetail2.showroom = "บางเลน " THEN wdetail2.delerco = "MS0C132" .
    IF wdetail2.showroom = "สระกระเทียม (สนญ)" OR wdetail2.showroom = "สระกระเทียม" THEN wdetail2.delerco = "MS0C131" .
END.
IF wdetail2.deler  = "TANG PARK AMNARTJAREARN"  THEN DO: 
    ASSIGN wdetail2.branch = "K".
    IF wdetail2.showroom = "วารินชำราบ" THEN wdetail2.delerco = "MS0C221" .
    IF wdetail2.showroom = "อ.เมืองยโสธร" THEN wdetail2.delerco = "MS0C222" .
    IF wdetail2.showroom = "อ.เมืองอำนาจเจริญ (สนญ)" OR wdetail2.showroom = "อ.เมืองอำนาจเจริญ" THEN wdetail2.delerco = "MS0C223" .
    IF wdetail2.showroom = "มุกดาหาร" THEN wdetail2.delerco = "MS0C224" .
    IF wdetail2.showroom = "อ.เมืองอุบล (สนญ)" OR wdetail2.showroom = "อ.เมืองอุบล" THEN wdetail2.delerco = "MS0C220" .
END.
IF wdetail2.deler  = "TANG PARK KORAT" OR wdetail2.deler  = "TANGPARK PAK ISAN" OR wdetail2.deler  = "TANG PARK SRISAKET" THEN DO: 
    ASSIGN wdetail2.branch = "K".
    IF wdetail2.showroom = "โชคชัย" THEN wdetail2.delerco = "MS0C212" .
    IF wdetail2.showroom = "อ.เมืองโคราช (สนญ)" OR wdetail2.showroom = "อ.เมืองโคราช" THEN wdetail2.delerco = "MS0C210" .
    IF wdetail2.showroom = "ชัยภูมิ" THEN wdetail2.delerco = "MS0C211" .
    IF wdetail2.showroom = "วารินชำราบ" THEN wdetail2.delerco = "MS0C229" .
    IF wdetail2.showroom = "อ.เมืองยโสธร (สนญ)" OR wdetail2.showroom = "อ.เมืองยโสธร" THEN wdetail2.delerco = "MS0C230" .
    IF wdetail2.showroom = "มุกดาหาร" THEN wdetail2.delerco = "MS0C232" .
    IF wdetail2.showroom = "อ.เมืองอุบล (สนญ)" OR wdetail2.showroom = "อ.เมืองอุบล" THEN wdetail2.delerco = "MS0C328" .
    IF wdetail2.showroom = "อ.เมืองอำนาจเจริญ" THEN wdetail2.delerco = "MS0C231" .
    IF wdetail2.showroom = "สีคิ้ว" THEN wdetail2.delerco = "MS0C213" .
    IF wdetail2.showroom = "อ.เมืองศรีสะเกษ (สนญ)" OR wdetail2.showroom = "อ.เมืองศรีสะเกษ" THEN wdetail2.delerco = "MS0C233" .
    IF wdetail2.showroom = "กันทรลักษณ์" THEN wdetail2.delerco = "MS0C234" .
END.
IF wdetail2.deler  = "TANG PARK UBON"  THEN DO: 
    ASSIGN wdetail2.branch = "K"
        wdetail2.delerco = "MS0C241" .
    IF wdetail2.showroom = "อ.เมืองอุบล (สนญ)" OR wdetail2.showroom = "อ.เมืองอุบล" THEN wdetail2.delerco = "MS0C235" .
    IF wdetail2.showroom = "วารินชำราบ" THEN wdetail2.delerco = "MS0C236" .
    IF wdetail2.showroom = "มุกดาหาร" THEN wdetail2.delerco = "MS0C239" .
    IF wdetail2.showroom = "อ.เมืองยโสธร (สนญ)" OR wdetail2.showroom = "อ.เมืองยโสธร" THEN wdetail2.delerco = "MS0C237" .
    IF wdetail2.showroom = "อ.เมืองอำนาจเจริญ (สนญ)" OR wdetail2.showroom = "อ.เมืองอำนาจเจริญ" THEN wdetail2.delerco = "MS0C238" .
END.
IF wdetail2.deler  = "TANG PARK YASOTHORN"  THEN DO: 
    ASSIGN wdetail2.branch = "K".
    IF wdetail2.showroom = "มุกดาหาร"    THEN wdetail2.delerco = "MS0C246" .
    IF wdetail2.showroom = "อ.เมืองอำนาจเจริญ (สนญ)" OR wdetail2.showroom = "อ.เมืองอำนาจเจริญ" THEN wdetail2.delerco = "MS0C245" .
    IF wdetail2.showroom = "อ.เมืองอุบล (สนญ)" OR wdetail2.showroom = "อ.เมืองอุบล" THEN wdetail2.delerco = "MS0C242" .
    IF wdetail2.showroom = "อ.เมืองยโสธร (สนญ)" OR wdetail2.showroom = "อ.เมืองยโสธร" THEN wdetail2.delerco = "MS0C244" .
    IF wdetail2.showroom = "วารินชำราบ" THEN wdetail2.delerco = "MS0C243" .
END.
IF wdetail2.deler  = "TARA & CO.,LTD." OR wdetail2.deler  = "TARA LAMPOON ISUZU SALES" OR 
    wdetail2.deler  = "TARA LAMPOON ISUZU SALES CO.,L" THEN DO: 
    ASSIGN wdetail2.branch = "2".
    IF wdetail2.showroom = "ดอยสะเก็ด(สนญ)" OR wdetail2.showroom = "ดอยสะเก็ด" THEN wdetail2.delerco = "MS0C160" .
    IF wdetail2.showroom = "ฝาง" THEN wdetail2.delerco = "MS0C163" .
    IF wdetail2.showroom = "แม่ฮ่องสอน" THEN wdetail2.delerco = "MS0C164" .
    IF wdetail2.showroom = "แม่แตง" THEN wdetail2.delerco = "MS0C167" .
    IF wdetail2.showroom = "วัดเกตุ" THEN wdetail2.delerco = "MS0C161" .
    IF wdetail2.showroom = "หนองประทีป" THEN wdetail2.delerco = "MS0C162" .
    IF wdetail2.showroom = "ลำพูน(สนญ)" OR wdetail2.showroom = "ลำพูน" THEN wdetail2.delerco = "MS0C166" .
    IF wdetail2.showroom = "สนามบิน" THEN wdetail2.delerco = "MS0C165" .
    IF wdetail2.showroom = "สำนักงานใหญ่" OR wdetail2.showroom = "ดอยสะเก็ด(สนญ)" OR wdetail2.showroom = "ดอยสะเก็ด" THEN wdetail2.delerco = "MS0C160" .
END.
IF wdetail2.deler  = "UNG NAKORNPATHOM"  THEN DO: 
    ASSIGN wdetail2.branch = "A".
    IF wdetail2.showroom = "ชะอำ" THEN wdetail2.delerco = "MS0C256" .
    IF wdetail2.showroom = "ประจวบคีรีขันธ์" THEN wdetail2.delerco = "MS0C257" .
    IF wdetail2.showroom = "ปราณบุรี" THEN wdetail2.delerco = "MS0C255" .
    IF wdetail2.showroom = "บางสะพาน" THEN wdetail2.delerco = "MS0C258" .
    IF wdetail2.showroom = "เพชรบุรี (สนญ)" OR wdetail2.showroom = "เพชรบุรี" THEN wdetail2.delerco = "MS0C254" .
    IF wdetail2.showroom = "นครปฐม (สนญ)" OR wdetail2.showroom = "นครปฐม" THEN ASSIGN wdetail2.branch = "U" 
        wdetail2.delerco = "MS0C133" .
    IF wdetail2.showroom = "สามพราน" THEN ASSIGN wdetail2.branch = "U" 
        wdetail2.delerco = "MS0C134" .
END.
IF wdetail2.deler  = "UNG NGUAN TAI ISUZU SALES CO.,"  THEN DO: 
    ASSIGN wdetail2.branch = "A".
    IF wdetail2.showroom = "บางสะพาน" THEN wdetail2.delerco = "MS0C252" .
    IF wdetail2.showroom = "ประจวบฯ" OR wdetail2.showroom = "ประจวบคีรีขันธ์" THEN wdetail2.delerco = "MS0C251" .
    IF wdetail2.showroom = "ปราณบุรี" THEN wdetail2.delerco = "MS0C250" .
    IF wdetail2.showroom = "สามพราน" THEN wdetail2.delerco = "MS0C250" .
END.
IF wdetail2.deler  = "UNG NGUAN TAI SUPHAN"  THEN DO: 
    ASSIGN wdetail2.branch = "U".
    IF wdetail2.showroom = "สุพรรณ (สนญ)" OR wdetail2.showroom = "สุพรรณ" THEN wdetail2.delerco = "MS0C135" .
    IF wdetail2.showroom = "อู่ทอง"       THEN wdetail2.delerco = "MS0C136" .
    IF wdetail2.showroom = "สามชุก" THEN wdetail2.delerco = "MS0C114" .
END.
IF wdetail2.deler  = "UTTRADITH HOCK AN TUENG"  THEN DO: 
    ASSIGN wdetail2.branch = "H".
    IF wdetail2.showroom = "พิษณุโลก(สนญ)" OR wdetail2.showroom = "พิษณุโลก"  THEN wdetail2.delerco = "MS0C261" .
    IF wdetail2.showroom = "เมืองตาก(สนญ)" OR wdetail2.showroom = "เมืองตาก"  THEN wdetail2.delerco = "MS0C264" .
    IF wdetail2.showroom = "แม่สอด" THEN wdetail2.delerco = "MS0C265" .
    IF wdetail2.showroom = "อุตรดิษถ์(สนญ)" OR wdetail2.showroom = "อุตรดิษถ์" THEN wdetail2.delerco = "MS0C263" .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

