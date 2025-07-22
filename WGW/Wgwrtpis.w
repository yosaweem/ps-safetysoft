&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases :GW_SAFE LD SIC_BRAN, GW_STAT LD BRSTAT ,SICSYAC  ,SICUW ,STAT */
  File: Description: 
  Input Parameters:<none>
  Output Parameters:<none>
  Author: 
  Created: Ranu I. A58-0489  15/06/2016   */
/*------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/*Modify by : Saowapa U . A62-0186 02/06/2019 แก้ไข เปลี่ยน Branch 12 14 T เป็น Branch M */
/*Modify by : Nontamas H. A62-0329 08/07/2019 เพิ่มช่องเลขที่ใบแจ้งหนี้*/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */  
/*******************************/
/*programid   : wgwrtpis.w                                              */ 
/*programname : Load text file TPIS to GW  -สำหรับงานต่ออายุ             */ 
/* Copyright  : Safety Insurance Public Company Limited                 */  
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)        */

/*************************************************************************************/
DEF VAR dod0       AS DECI.
DEF VAR dod1       AS DECI.
DEF VAR dod2       AS DECI.
DEF VAR dpd0       AS DECI.
DEF VAR n_cr2      AS CHAR INIT "" FORMAT "x(20)".
DEF NEW SHARED VAR nv_producer AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR nv_agent    AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno. 
def  var  nv_row  as  int  init  0.
DEFINE STREAM  ns1. 
DEFINE STREAM  ns2.
DEFINE STREAM  ns3.
DEF VAR nv_uom1_v AS DECI INIT 0.
DEF VAR nv_uom2_v AS DECI INIT 0.
DEF VAR nv_uom5_v AS DECI INIT 0.
DEF VAR chkred    AS logi INIT NO.
/*DEF SHARED Var   n_User    As CHAR .  */ /*A61-0152*/
/*DEF SHARED Var   n_PassWd  As CHAR .  */ /*A61-0152*/  
DEF SHARED Var   n_User    As CHAR format "X(10)" . /*A61-0152*/      
DEF SHARED Var   n_PassWd  As CHAR format "X(15)" . /*A61-0152*/      
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
DEF New  shared VAR nv_prem     AS DECIMAL  FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_prem1    AS DECIMAL  FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
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
DEF NEW  SHARED VAR nv_41prm    AS INTEGER  FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_odcod    AS CHAR     FORMAT "X(4)".
DEF NEW  SHARED VAR nv_cons     AS CHAR     FORMAT "X(2)".
DEF NEW  SHARED VAR nv_baseap   AS DECI     FORMAT ">>,>>>,>>9.99-".
DEF New  shared VAR nv_ded      AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_gapprm   AS DECI     FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_pdprm    AS DECI     FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_prvprm   AS DECI     FORMAT ">>,>>>,>>9.99-".
DEF New  SHARED VAR nv_addprm   AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_totded   AS INTEGER  FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_totdis   AS INTEGER  FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_ded1prm  AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_aded1prm AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_ded2prm  AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_dedod    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_addod    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_dedpd    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
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
DEF NEW  SHARED VAR   nv_cl_cod   AS CHAR       FORMAT "X(4)".
DEF New  SHARED VAR   nv_lodclm   AS INTEGER    FORMAT ">>>,>>9.99-".
DEF             VAR   nv_lodclm1  AS INTEGER    FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR   nv_clmvar1  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar2  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar   AS CHAR       FORMAT "X(60)". 
DEF NEW  SHARED VAR nv_compcod   AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_compprm   AS DECI        FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR nv_compvar1  AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_compvar2  AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_compvar   AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_basecod   AS CHAR        FORMAT "X(4)".
DEF New  SHARED VAR nv_basevar1  AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_basevar2  AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_basevar   AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_baseprm   AS DECI        FORMAT ">>,>>>,>>9.99-". 
DEF NEW  SHARED VAR   nv_cl_per   AS DECIMAL    FORMAT ">9.99".
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
DEF NEW SHARED VAR    nv_tariff     LIKE sicuw.uwm301.tariff.
DEF NEW SHARED VAR    nv_comdat     LIKE sicuw.uwm100.comdat.
DEF NEW SHARED VAR    nv_covcod     LIKE sicuw.uwm301.covcod.
DEF NEW SHARED VAR    nv_class      AS CHAR    FORMAT "X(4)".
DEF NEW SHARED VAR    nv_key_b      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEF NEW SHARED VAR    nv_drivno     AS INT       .
DEF NEW SHARED VAR    nv_drivcod    AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR    nv_drivprm    AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR    nv_drivvar1   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR    nv_drivvar2   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR    nv_drivvar    AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR    nv_usecod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR    nv_useprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR    nv_usevar1  AS CHAR  FORMAT "X(30)". 
DEF NEW SHARED VAR    nv_usevar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR    nv_usevar   AS CHAR  FORMAT "X(60)".
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
def NEW SHARED var  s_recid3       as recid .     /* uwm130  */  
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
DEF VAR nv_reccnt   AS  INT  INIT  0.           /*all load record*/
DEF VAR nv_completecnt    AS   INT   INIT  0.   /*complete record */
DEF NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".   
DEF NEW SHARED  VAR nv_modulo    AS INTE  FORMAT  "9".
DEF VAR s_riskgp    AS INTE FORMAT ">9".
DEF VAR s_riskno    AS INTE FORMAT "999".
DEF VAR s_itemno    AS INTE FORMAT "999". 
def var nv_dept     as char format  "X(1)".
def NEW SHARED var  nv_branch     LIKE sicsyac.XMM023.BRANCH.  
def var n_newpol    Like  sicuw.uwm100.policy  init  "".
def var nv_undyr    as    char  init  ""    format   "X(4)".
def var n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO. 
def New shared  var      nv_makdes    as   CHAR.
def New shared  var      nv_moddes    as   CHAR.
DEF VAR nv_fptr     AS RECID.
DEF VAR nv_bptr     AS RECID.
DEF VAR nv_rstp     AS DECIMAL                          NO-UNDO.
DEF VAR nv_rtax     AS DECIMAL                          NO-UNDO.
DEF VAR nv_gap2     AS DECIMAL                          NO-UNDO.
DEF VAR nv_prem2    AS DECIMAL                          NO-UNDO.
DEF VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.
DEF VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR s_130bp1    AS RECID                            NO-UNDO.
DEF VAR s_130fp1    AS RECID                            NO-UNDO.
DEF VAR nvffptr     AS RECID                            NO-UNDO.
DEF VAR n_rd132     AS RECID                            NO-UNDO.
DEF VAR nv_gap      AS DECIMAL                          NO-UNDO.
DEF VAR nv_key_a    AS DECIMAL INITIAL 0                NO-UNDO.
DEF VAR nv_rec100   AS RECID .
DEF VAR nv_rec120   AS RECID .
DEF VAR nv_rec130   AS RECID .
DEF VAR nv_rec301   AS RECID .
{wgw\wgwrtpis.i}      /*ประกาศตัวแปร*/
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
DEFINE VAR gv_id       AS CHAR FORMAT "X(15)" NO-UNDO.   
/*DEFINE VAR nv_pwd      AS CHAR NO-UNDO.  */ /*A61-0152*/
DEFINE VAR nv_pwd      AS CHAR FORMAT "X(15)" NO-UNDO.   /*A61-0152*/
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".
DEFINE VAR n_ratmin    AS INTE INIT 0.
DEFINE VAR n_ratmax    AS INTE INIT 0.
DEFINE VAR nv_maxdes   AS CHAR.
DEFINE VAR nv_mindes   AS CHAR.
DEFINE VAR nv_si       AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_maxSI    AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_minSI    AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */
DEFINE VAR nv_uwm301trareg    LIKE sic_bran.uwm301.cha_no INIT "".
DEFINE VAR nv_basere   AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0.00. 
DEFINE VAR nv_newsck   AS CHAR FORMAT "x(15)" INIT " ".
DEFINE VAR n_firstdat  AS DATE.
DEFINE VAR nv_deler    AS CHAR FORMAT "x(10)" INIT " ".
def var nv_cnt      as int    init 0.
/*--------A58-0489---------------*/
DEF VAR n_Engine  AS CHAR FORMAT "X(20)" .
DEF VAR n_Tonn70  AS DECI.
DEF VAR n_policy72  AS CHAR FORMAT "x(15)".
DEF VAR np_prepol  AS CHAR FORMAT "x(15)". 
DEF VAR n_brand1   AS CHAR FORMAT "x(30)".  
DEF VAR n_body     AS CHAR FORMAT "x(20)". 
DEF VAR nn_redbook AS CHAR FORMAT "x(20)".
DEF VAR n_occupn   AS CHAR FORMAT "x(60)".
def var nv_memo1   as char format "x(150)".  /*A61-0152*/
def var nv_memo2   as char format "x(150)".  /*A61-0152*/
def var nv_meno3   as char format "x(150)".  /*A61-0152*/
DEF VAR nv_cctv    AS CHAR FORMAT "x(5)" .   /*a61-0416 */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_comp

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wcomp wdetail

/* Definitions for BROWSE br_comp                                       */
&Scoped-define FIELDS-IN-QUERY-br_comp wcomp.package wcomp.premcomp   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_comp   
&Scoped-define SELF-NAME br_comp
&Scoped-define QUERY-STRING-br_comp FOR EACH wcomp
&Scoped-define OPEN-QUERY-br_comp OPEN QUERY br_comp FOR EACH wcomp.
&Scoped-define TABLES-IN-QUERY-br_comp wcomp
&Scoped-define FIRST-TABLE-IN-QUERY-br_comp wcomp


/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail WDETAIL.WARNING wdetail.poltyp wdetail.redbook wdetail.policy wdetail.prvpol wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.iadd1 wdetail.iadd2 wdetail.iadd3 wdetail.iadd4 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.engno wdetail.chasno wdetail.caryear wdetail.carprovi wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.volprem wdetail.Compprem wdetail.fleet wdetail.ncb wdetail.access wdetail.deductpp wdetail.deductba wdetail.deductpa wdetail.benname wdetail.n_user wdetail.n_IMPORT wdetail.n_export wdetail.producer wdetail.agent wdetail.comment wdetail.cancel   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_comp ra_typefile fi_loaddat fi_pack ~
fi_branch fi_producer fi_bchno fi_producerre fi_producer72 fi_agent ~
fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 fi_output3 ~
fi_usrcnt fi_usrprem buok bu_exit bu_hpbrn bu_hpacno1 bu_hpagent ~
bu_hpacno72 bu_hpagent72 fi_process fi_prom fi_packcom fi_premcomp bu_add ~
bu_del fi_model RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 br_wdetail ~
RECT-377 RECT-378 RECT-379 
&Scoped-Define DISPLAYED-OBJECTS ra_typefile fi_loaddat fi_pack fi_branch ~
fi_producer fi_bchno fi_producerre fi_producer72 fi_agent fi_prevbat ~
fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem ~
fi_brndes fi_proname fi_rename fi_impcnt fi_proname72 fi_completecnt ~
fi_premtot fi_agtname fi_premsuc fi_process fi_prom fi_packcom fi_premcomp ~
fi_model 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_add 
     LABEL "ADD" 
     SIZE 6 BY .91.

DEFINE BUTTON bu_del 
     LABEL "DEL" 
     SIZE 6 BY .91.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4.5 BY .91.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpacno72 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpagent72 
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
     SIZE 50 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 24.33 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

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
     SIZE 4 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_packcom AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premcomp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY .95
     BGCOLOR 8 FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer72 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producerre AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_prom AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_proname72 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_rename AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_typefile AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match File to Excel", 1,
"Load To GW", 2,
"Match Sticker Yes/no", 3,
"Match Policy", 4,
"Match Policy Send TPIS", 5
     SIZE 117.33 BY .91
     BGCOLOR 3 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.52
     BGCOLOR 31 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 14.1
     BGCOLOR 10 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 5.05
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 2.86
     BGCOLOR 10 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 120.83 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 32.67 BY 2.33
     BGCOLOR 4 FGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_comp FOR 
      wcomp SCROLLING.

DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_comp c-Win _FREEFORM
  QUERY br_comp DISPLAY
      wcomp.package    COLUMN-LABEL "Package"   FORMAT "x(10)"
      wcomp.premcomp   COLUMN-LABEL "Premcomp"  FORMAT "->>>,>>9.99"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 30.5 BY 4.48
         BGCOLOR 15 FGCOLOR 0 FONT 6 FIT-LAST-COLUMN.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      WDETAIL.WARNING COLUMN-LABEL "Warning" 
        wdetail.poltyp  COLUMN-LABEL "Policy Type"
        wdetail.redbook COLUMN-LABEL "RedBook"
        wdetail.policy  COLUMN-LABEL "Policy"
        wdetail.prvpol  COLUMN-LABEL "Renew Policy"
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
        wdetail.carprovi COLUMN-LABEL "Car Province"
        wdetail.vehuse  COLUMN-LABEL "Vehicle Use" 
        wdetail.garage  COLUMN-LABEL "Garage"
        wdetail.stk     COLUMN-LABEL "Sticker"
        wdetail.covcod  COLUMN-LABEL "Cover Type"
        wdetail.si      COLUMN-LABEL "Sum Insure"
        wdetail.volprem COLUMN-LABEL "Voluntory Prem"
        wdetail.Compprem COLUMN-LABEL "Compulsory Prem"
        wdetail.fleet   COLUMN-LABEL "Fleet"
        wdetail.ncb     COLUMN-LABEL "NCB"
        wdetail.access COLUMN-LABEL "Load Claim"
        wdetail.deductpp  COLUMN-LABEL "Deduct TP"
        wdetail.deductba   COLUMN-LABEL "Deduct DA"
        wdetail.deductpa   COLUMN-LABEL "Deduct PD"
        wdetail.benname COLUMN-LABEL "Benefit Name" 
        wdetail.n_user  COLUMN-LABEL "User"
        wdetail.n_IMPORT COLUMN-LABEL "Import"
        wdetail.n_export COLUMN-LABEL "Export"
        wdetail.producer COLUMN-LABEL "Producer"
        wdetail.agent    COLUMN-LABEL "Agent"
        wdetail.comment FORMAT "x(45)" COLUMN-BGCOLOR  80 COLUMN-LABEL "Comment"
        wdetail.cancel  COLUMN-LABEL "Cancel"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 4.71
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_comp AT ROW 7.52 COL 101.5
     ra_typefile AT ROW 2.91 COL 9.33 NO-LABEL
     fi_loaddat AT ROW 4 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 4 COL 71.67 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 9.29 COL 11.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.05 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.86 COL 18.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_producerre AT ROW 6.05 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_producer72 AT ROW 7.1 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 8.14 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 9.29 COL 57 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 9.29 COL 88.33 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 10.33 COL 26.33 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 10.33 COL 88.83
     fi_output1 AT ROW 11.33 COL 26.33 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 12.33 COL 26.33 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 13.38 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 14.33 COL 26.33 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 14.33 COL 64.67 NO-LABEL
     buok AT ROW 12.71 COL 92
     bu_exit AT ROW 14.57 COL 92
     fi_brndes AT ROW 9.29 COL 20.67 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 9.29 COL 18.83
     bu_hpacno1 AT ROW 5.05 COL 42.83
     bu_hpagent AT ROW 6.05 COL 42.83
     fi_proname AT ROW 5.05 COL 45.33 COLON-ALIGNED NO-LABEL
     fi_rename AT ROW 6.05 COL 45.33 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 22.38 COL 62.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpacno72 AT ROW 7.1 COL 42.83
     bu_hpagent72 AT ROW 8.14 COL 42.83
     fi_proname72 AT ROW 7.1 COL 45.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.38 COL 62.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.38 COL 100 NO-LABEL NO-TAB-STOP 
     fi_agtname AT ROW 8.14 COL 45.33 COLON-ALIGNED NO-LABEL
     fi_premsuc AT ROW 23.43 COL 98 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 15.43 COL 16.67 COLON-ALIGNED NO-LABEL
     fi_prom AT ROW 4 COL 51.33 COLON-ALIGNED NO-LABEL
     fi_packcom AT ROW 5.24 COL 111 COLON-ALIGNED NO-LABEL
     fi_premcomp AT ROW 6.24 COL 111.83 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 5.19 COL 125
     bu_del AT ROW 6.29 COL 125.17
     fi_model AT ROW 4 COL 106 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 17.05 COL 2.33
     "Branch :" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 9.29 COL 4.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 12.33 COL 4.5
          BGCOLOR 8 FGCOLOR 1 
     "Package :" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 4 COL 63.33
          BGCOLOR 10 FGCOLOR 1 FONT 6
     "   IMPORT TEXT FILE MOTOR [TPIS] RENEW" VIEW-AS TEXT
          SIZE 128 BY .95 AT ROW 1.29 COL 129.5 RIGHT-ALIGNED
          BGCOLOR 20 FGCOLOR 6 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 22.38 COL 97.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Prom :" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 4 COL 47
          BGCOLOR 10 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.86 COL 7.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "       Producer Renew :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 5.05 COL 4.5
          BGCOLOR 20 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 10.33 COL 4.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TieS 4 01/03/2022" VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 15.48 COL 111.5 WIDGET-ID 2
     "   Producer Code V72 :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 7.1 COL 4.5
          BGCOLOR 20 FGCOLOR 2 FONT 6
     "Previous Batch No." VIEW-AS TEXT
          SIZE 19 BY .91 AT ROW 9.29 COL 39.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 22.38 COL 60.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "              Agent Code :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 8.14 COL 4.5
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "                 Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 4 COL 4.5
          BGCOLOR 10 FGCOLOR 1 FONT 6
     "Campaign Renew/Refinance :" VIEW-AS TEXT
          SIZE 29.33 BY .91 AT ROW 4 COL 78.67
          BGCOLOR 10 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .91 AT ROW 14.33 COL 63 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 14.33 COL 26.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Producer Refinance :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 6.05 COL 4.5
          BGCOLOR 20 FGCOLOR 2 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 9.29 COL 89 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 23.38 COL 60.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "PackComp :" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 5.24 COL 101.5
          BGCOLOR 4 FGCOLOR 7 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 14.33 COL 82.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Base Comp :" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 6.24 COL 101.33
          BGCOLOR 4 FGCOLOR 7 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 13.33 COL 4.5
          BGCOLOR 8 FGCOLOR 1 
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1 AT ROW 23.38 COL 97.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 23.38 COL 119
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 11.33 COL 4.5
          BGCOLOR 8 FGCOLOR 1 
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 22.38 COL 119
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.62 COL 1.17
     RECT-373 AT ROW 16.81 COL 1
     RECT-374 AT ROW 21.95 COL 1
     RECT-376 AT ROW 22.14 COL 4.33
     RECT-377 AT ROW 12.43 COL 90.83
     RECT-378 AT ROW 14.29 COL 90.83
     RECT-379 AT ROW 5.05 COL 99.83
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
  CREATE WINDOW c-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "LOAD TEXT FILE RENEW[TIL/NON-TIL]"
         HEIGHT             = 24
         WIDTH              = 133
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
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
IF NOT c-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_comp 1 fr_main */
/* BROWSE-TAB br_wdetail RECT-376 fr_main */
ASSIGN 
       br_comp:SEPARATOR-FGCOLOR IN FRAME fr_main      = 15.

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
/* SETTINGS FOR FILL-IN fi_proname72 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_rename IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "   IMPORT TEXT FILE MOTOR [TPIS] RENEW"
          SIZE 128 BY .95 AT ROW 1.29 COL 129.5 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.5 BY .91 AT ROW 9.29 COL 89 RIGHT-ALIGNED             */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 23 BY .91 AT ROW 14.33 COL 26.5 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .91 AT ROW 14.33 COL 63 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1 AT ROW 22.38 COL 60.67 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1 AT ROW 22.38 COL 97.67 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1 AT ROW 23.38 COL 60.67 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1 AT ROW 23.38 COL 97.83 RIGHT-ALIGNED          */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_comp
/* Query rebuild information for BROWSE br_comp
     _START_FREEFORM
OPEN QUERY br_comp FOR EACH wcomp.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_comp */
&ANALYZE-RESUME

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

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* LOAD TEXT FILE RENEW[TIL/NON-TIL] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* LOAD TEXT FILE RENEW[TIL/NON-TIL] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_comp
&Scoped-define SELF-NAME br_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_comp c-Win
ON ROW-DISPLAY OF br_comp IN FRAME fr_main
DO:
  DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    wcomp.package:BGCOLOR IN BROWSE  BR_comp = z NO-ERROR.  
    wcomp.premcomp:BGCOLOR IN BROWSE BR_comp = z NO-ERROR.

    wcomp.package:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
    wcomp.premcomp:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
          
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_wdetail
&Scoped-define SELF-NAME br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_wdetail c-Win
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
          wdetail.poltyp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.redbook:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. /*new add*/  
          wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.prvpol:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
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
          wdetail.producer:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.agent:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.comment:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          WDETAIL.CANCEL:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
                         


          /*wdetail.entdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.enttim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trandat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trantim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. *//*a490166*/ 
          WDETAIL.WARNING:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
          wdetail.poltyp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
          wdetail.redbook:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  /*new add*/
          wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.prvpol:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
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
          wdetail.producer:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.agent:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comment:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
          WDETAIL.CANCEL:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          
            
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    /*--comment by Ranu i. A58-0489 .......................
    IF     ra_typefile = 1 THEN DO:                            /*แปลงไฟล์แจ้งงาน */
        IF ra_typload  = 1 THEN RUN proc_matfileload.          /*A56-0262     Til */
                           ELSE RUN proc_matfileload_2.        /*A57-0226 non-til */
    END.                                                       
    ELSE IF ra_typefile = 3 THEN DO:                           /*Match file STK */
        IF ra_typload = 1 THEN  RUN proc_matfileloadstk.       /*A56-0262  */
                          ELSE  RUN proc_matfileloadstknontil. /*A57-0226  */
    END.
    ELSE IF ra_typefile = 4 THEN DO:      /*Til / non-til*/    /*Match file Policy */
        IF ra_typload = 1 THEN  RUN proc_matpol_til.      
        ELSE RUN proc_matpol_nontil.
    END.
    ......... end A58-0489..............*/
    /*--------A58-0489-----------*/
    IF     ra_typefile = 1 THEN DO:    /*แปลงไฟล์แจ้งงาน */
        RUN proc_matfileload.                  
    END.                                                       
    ELSE IF ra_typefile = 3 THEN DO:   /*Match file STK */
        RUN proc_matfileloadstk.  
    END.
    ELSE IF ra_typefile = 4 THEN DO:   /*Match file Policy */
        RUN proc_matpol. 
    END.    
    ELSE IF ra_typefile = 5 THEN DO:   /*Match file Policy Send to TIL*/
        RUN proc_matpoltil.  
    END.
    
    /*-------- end : A58-0489 ---------*/
    ELSE DO:
        ASSIGN
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2
            fi_completecnt         = 0
            fi_premsuc             = 0
            fi_bchno               = ""
            fi_premtot             = 0
            fi_impcnt              = 0.
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
        nv_batchyr = INPUT fi_bchyr.
        IF nv_batprev = "" THEN DO:  
            FIND LAST uzm700 USE-INDEX uzm70001 WHERE
                uzm700.bchyr   = nv_batchyr        AND
                uzm700.branch  = TRIM(nv_batbrn)   AND
                uzm700.acno    = TRIM(fi_producer) NO-LOCK NO-ERROR .
            IF AVAIL uzm700 THEN DO:   
                nv_batrunno = uzm700.runno.
                FIND LAST uzm701 USE-INDEX uzm70102 WHERE
                    uzm701.bchyr = nv_batchyr  AND
                    uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999")  NO-LOCK NO-ERROR.
                IF AVAIL uzm701 THEN DO:
                    nv_batcnt = uzm701.bchcnt .
                    nv_batrunno = nv_batrunno + 1.
                END.
            END.
            ELSE DO:  
                ASSIGN nv_batcnt = 1
                    nv_batrunno = 1.
            END.
            nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
        END.
        ELSE DO:  
            nv_batprev = INPUT fi_prevbat.
            FIND LAST uzm701 USE-INDEX uzm70102  WHERE 
                uzm701.bchyr = nv_batchyr        AND
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
        RUN proc_assign.  /*A58-0489*/
        /*IF ra_typload = 1 THEN RUN proc_assign.  /*Til*/*/ /*A58-0489*/
        /*ELSE RUN proc_assign_nontil.        /*non-Til*/*/ /*A58-0489*/
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
            IF WDETAIL.POLTYP = "v70" OR WDETAIL.POLTYP = "v72"  THEN DO:
                ASSIGN
                    nv_reccnt      =  nv_reccnt   + 1
                    nv_netprm_t    =  nv_netprm_t + decimal(wdetail.volprem) 
                    wdetail.pass   = "Y"
                    WDETAIL.POLTYP =  WDETAIL.POLTYP.     
            END.
            ELSE DO :    
                DELETE WDETAIL.
            END.
        END.
        IF  nv_reccnt = 0 THEN DO: 
            MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
            RETURN NO-APPLY.
        END.
        /* comment by : Ranu I. a64-0344...
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
                               INPUT            "wgwrtpis" ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                               INPUT            nv_imppol  ,     /* INT   */
                               INPUT            nv_impprem       /* DECI  */
                               ).
        ASSIGN
            fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
        DISP  fi_bchno   WITH FRAME fr_main.
        RUN proc_chktest1.
        FOR EACH wdetail WHERE wdetail.pass = "y"  NO-LOCK.
            ASSIGN
                nv_completecnt = nv_completecnt + 1
                nv_netprm_s    = nv_netprm_s    + decimal(wdetail.volprem) . 
        END.
        nv_rectot = nv_reccnt.      
        nv_recsuc = nv_completecnt. 
        IF nv_rectot <> nv_recsuc   THEN DO:
            nv_batflg = NO.
        END.
        ELSE IF  nv_netprm_t <> nv_netprm_s THEN nv_batflg = NO.
        ELSE nv_batflg = YES.
        FIND LAST uzm701 USE-INDEX uzm70102  WHERE uzm701.bchyr = nv_batchyr AND
            uzm701.bchno = nv_batchno AND
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
        IF nv_batflg = NO THEN DO:  
            ASSIGN
                fi_completecnt:FGCOLOR = 6
                fi_premsuc:FGCOLOR = 6 
                fi_bchno:FGCOLOR = 6
                fi_process =  "Please check Data again."  .    /*A56-0262*/
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
                fi_process =  "Process Complete" .
            MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
        END.
        RUN   proc_open.    
        DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_process WITH FRAME fr_main.
        /*output*/
        RUN proc_report1 .   
        RUN PROC_REPORT2 .
        RUN proc_screen  .  
        IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
        RELEASE uzm700.
        RELEASE uzm701.
        RELEASE sic_bran.uwm100.
        RELEASE sic_bran.uwm120.
        RELEASE sic_bran.uwm130.
        RELEASE sic_bran.uwm301.
        RELEASE sic_bran.uwd132.
        RELEASE sic_bran.uwd100.
        RELEASE sic_bran.uwd102.
        RELEASE stat.detaitem.
        RELEASE brStat.Detaitem.
        RELEASE sicsyac.xtm600.
        RELEASE sicsyac.xmm600.
        RELEASE sicsyac.xzm056.
        RELEASE sicsyac.sym100.
        RELEASE sicsyac.xmd031.
        RELEASE sicsyac.xmm016.
        RELEASE sicsyac.xmm018.
        RELEASE sicsyac.xmm020.
        RELEASE sicsyac.xmm031.
        RELEASE sicsyac.xmm104.
        RELEASE sicsyac.xmm105.
        RELEASE sicsyac.xmm106.
        RELEASE sicuw.uwm100. 
        RELEASE sicuw.uwm130. 
        RELEASE sicuw.uwm301.
        RELEASE stat.maktab_fil.
        RELEASE stat.makdes31.
        RELEASE stat.insure.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add c-Win
ON CHOOSE OF bu_add IN FRAME fr_main /* ADD */
DO:
    IF fi_packcom = "" THEN DO:
        APPLY "ENTRY" TO fi_packcom .
        disp fi_packcom  with frame  fr_main.
    END.
    ELSE DO:
        FIND LAST WComp WHERE wcomp.package = trim(fi_packcom) NO-ERROR NO-WAIT.
        IF NOT AVAIL wcomp THEN DO:
            CREATE wcomp.
            ASSIGN wcomp.package   = trim(fi_packcom)
                   wcomp.premcomp  = fi_premcomp
                fi_packcom      = "" 
                fi_premcomp     = 0  .
        END.
    END.
    OPEN QUERY br_comp FOR EACH wcomp.
    APPLY "ENTRY" TO fi_packcom  .
    disp  fi_packcom  fi_premcomp  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del c-Win
ON CHOOSE OF bu_del IN FRAME fr_main /* DEL */
DO:
    GET CURRENT br_comp EXCLUSIVE-LOCK.
    DELETE wcomp.
    /*FIND LAST wcomp WHERE wcomp.package  = fi_packcom NO-ERROR NO-WAIT.
        IF    AVAIL wcomp THEN DELETE wcomp.
        ELSE MESSAGE "Not found Package !!! in : " fi_packcom VIEW-AS ALERT-BOX.
        */
    OPEN QUERY br_comp FOR EACH wcomp.
    APPLY "ENTRY" TO fi_packcom IN FRAME fr_main.
    disp  fi_packcom  fi_premcomp with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS     "CSV (Comma Delimited)"   "*.csv",
       "Text Documents" "*.txt"
       /* "Data Files (*.dat)"     "*.dat",*/
       /* "Text Files (*.txt)" "*.csv"*/
       
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
         IF ra_typefile = 1 THEN DO:
             ASSIGN
                 fi_filename  = cvData
                 fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + "Load.slk" /*.csv*/
                 fi_output2 = ""
                 fi_output3 = "".
             DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
             APPLY "Entry" TO fi_output1.
             RETURN NO-APPLY.
         END.
         IF ra_typefile = 4 THEN DO:
             ASSIGN
                 fi_filename  = cvData
                 fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + "_pol.slk" /*.csv*/
                 fi_output2 = ""
                 fi_output3 = "".
             DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
             APPLY "Entry" TO fi_output1.
             RETURN NO-APPLY.
         END.
         /*--create by A58-0489--------------*/
         IF ra_typefile = 5 THEN DO:
             ASSIGN
                 fi_filename  = cvData
                 fi_output1 = SUBSTRING(cvData,1,R-INDEX(cvdata,"\"))  + "INFORM_RENEW_SAFE_xx.CSV" /*.csv*/
                 fi_output2 = SUBSTRING(cvData,1,R-INDEX(cvdata,"\"))  + "Send_TPIS_RENEW" + NO_add + ".slk" 
                 fi_output3 = "".
             DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
             APPLY "Entry" TO fi_output1.
             RETURN NO-APPLY.
         END.
         /*--------End : A58-0489--------------*/
         ELSE DO: 
             ASSIGN
                 fi_filename  = cvData
                 fi_output1   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
                 fi_output2   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
                 fi_output3   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
             DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
             APPLY "Entry" TO fi_output3.
             RETURN NO-APPLY.
         END.
    END.

    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 c-Win
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


&Scoped-define SELF-NAME bu_hpacno72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno72 c-Win
ON CHOOSE OF bu_hpacno72 IN FRAME fr_main
DO:
    Def   var     n_acno       As  Char.
    Def   var     n_agent      As  Char.    
    Run whp\whpacno1(output  n_acno,      /*a490166 note modi*/ /*28/11/2006*/
                     output  n_agent).

    If  n_acno  <>  ""  Then  fi_producer72 =  n_acno.
    disp  fi_producer72  with frame  fr_main.
    Apply "Entry"  to  fi_producer72.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent c-Win
ON CHOOSE OF bu_hpagent IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,   /*a490166 note modi*/
                    output  n_agent). 
                                          
     If  n_acno  <>  ""  Then  fi_producerre =  n_acno.
     
     disp  fi_producerre  with frame  fr_main.

     Apply "Entry"  to  fi_producerre.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpagent72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent72 c-Win
ON CHOOSE OF bu_hpagent72 IN FRAME fr_main
DO:
    Def   var     n_acno       As  Char.
    Def   var     n_agent      As  Char.    
    Run whp\whpacno1(output  n_acno,           /*a490166 note modi*/
                     output  n_agent). 
    If  n_acno  <>  ""  Then  fi_agent =  n_acno.
    disp  fi_agent  with frame  fr_main.
    
    Apply "Entry"  to  fi_agent.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn c-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent c-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    IF  fi_agent <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001        WHERE
            sicsyac.xmm600.acno  =  Input fi_agent  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"   View-as alert-box.
            Apply "Entry" To  fi_agent.
            RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO:
            IF TRIM(sicsyac.xmm600.ntitle) = "" THEN fi_agtname  =   TRIM(sicsyac.xmm600.name).
            ELSE fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name). 
            ASSIGN
                fi_agent =  caps(INPUT  fi_agent) 
                nv_agent = fi_agent .
        END.
    END.
    Disp  fi_agent  fi_agtname    WITH Frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr c-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch c-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat c-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
  fi_loaddat  =  Input  fi_loaddat.
  Disp  fi_loaddat  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model c-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
    fi_model  =  Input  fi_model.
    Disp  fi_model  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output1 c-Win
ON LEAVE OF fi_output1 IN FRAME fr_main
DO:
    fi_output1 = INPUT fi_output1.
    DISP fi_output1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack c-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
    
  fi_pack  =  Input  fi_pack.
  Disp  fi_pack  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_packcom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_packcom c-Win
ON LEAVE OF fi_packcom IN FRAME fr_main
DO:
    fi_packcom =  Input  fi_packcom.
    Disp  fi_packcom with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_premcomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_premcomp c-Win
ON LEAVE OF fi_premcomp IN FRAME fr_main
DO:
    fi_premcomp  =  Input fi_premcomp.
    Disp  fi_premcomp with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat c-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer.
    IF  fi_producer <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_producer  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producer.
            RETURN NO-APPLY.  
        END.
        ELSE DO:
            IF TRIM(sicsyac.xmm600.ntitle) = "" THEN fi_agtname =   TRIM(sicsyac.xmm600.name).
            ELSE fi_proname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name).
            ASSIGN
                fi_producer =  caps(INPUT  fi_producer) 
                nv_producer = fi_producer .             
        END.
    END.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer72 c-Win
ON LEAVE OF fi_producer72 IN FRAME fr_main
DO:
    fi_producer72 = INPUT fi_producer72.
    IF  fi_producer72 <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001          WHERE
            sicsyac.xmm600.acno  =  Input fi_producer72 NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" View-as alert-box.
            Apply "Entry" To  fi_producer72.
            RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO:
            IF TRIM(sicsyac.xmm600.ntitle) = "" THEN fi_proname72 =   TRIM(sicsyac.xmm600.name).
            ELSE fi_proname72 =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name). 
                 ASSIGN fi_producer72 =  caps(INPUT  fi_producer72) .
        END.
    END.
    Disp  fi_producer72  fi_proname72   WITH Frame  fr_main.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerre c-Win
ON LEAVE OF fi_producerre IN FRAME fr_main
DO:
    fi_producerre = INPUT fi_producerre.
    IF fi_producerre <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_producerre  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producerre.
            RETURN NO-APPLY.  
        END.
        ELSE DO: 
            ASSIGN
                fi_rename =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producerre   =  caps(INPUT  fi_producerre) .
        END.
    END.
    Disp  fi_producerre  fi_rename  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prom c-Win
ON LEAVE OF fi_prom IN FRAME fr_main
DO:
    fi_prom  =  Input  fi_prom.
    Disp  fi_prom with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrcnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrcnt c-Win
ON LEAVE OF fi_usrcnt IN FRAME fr_main
DO:
  fi_usrcnt = INPUT fi_usrcnt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrprem c-Win
ON LEAVE OF fi_usrprem IN FRAME fr_main
DO:
  fi_usrprem = INPUT fi_usrprem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typefile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typefile c-Win
ON VALUE-CHANGED OF ra_typefile IN FRAME fr_main
DO:
    ra_typefile = INPUT ra_typefile.
    ASSIGN
        fi_filename  = ""
        fi_output1   = ""
        fi_output2   = ""
        fi_output3   = "".
    IF ra_typefile = 1 THEN ASSIGN fi_model = "TPIS_RE" .  /*A61-0152*/
    ELSE ASSIGN fi_model   = "TPIS_CAMPRENEW" .            /*A61-0152*/
    DISP ra_typefile fi_filename fi_output1 fi_output2 fi_output3 fi_model WITH FRAME {&FRAME-NAME}. 
    APPLY "Entry" TO fi_output1.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_comp
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-Win 


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
  
  gv_prgid = "wgwrtpis.w".
  gv_prog  = "Load Text & Generate TPIS-RENEW".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN proc_createcomp.
  OPEN QUERY br_comp FOR EACH wcomp.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
      fi_prom       = "TPIS"    /* A57-0266 */
      fi_pack       = "V"
      fi_branch     = "M"
      fi_producer   = "A000324"
      fi_agent      = "B3M0018"
      fi_producer72 = "A000324"       /*Saowapa U. A62-0110 25/02/2019*/
      /*fi_producer72 = "A0M0083"*/  /*Saowapa U. A62-0110 25/02/2019*/
      fi_producerre = "B3M0034"       /*A61-0152*/
      /*fi_agent72    = "B3M0018" */ /*A61-0152*/
      /*fi_model      = "model" */ /*A61-0152*/
      fi_process    = "Load Text file RENEW TPIS "    /*A56-0262*/
     /* ra_typload    = 1   /*A57-0226*/*/
      ra_typefile   = 1   /*A56-0262*/
      fi_bchyr    = YEAR(TODAY) .
      IF ra_typefile   = 1 THEN  ASSIGN fi_model = "TPIS_RE" .
      ELSE ASSIGN fi_model   = "TPIS_CAMPRENEW" .
      
  DISP fi_prom fi_pack fi_branch fi_producer fi_agent fi_producer72 /*fi_agent72*/ fi_bchyr ra_typefile fi_process
       /*ra_typload*/ fi_model  fi_producerre  /*A57-0226*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_addbr1_bp c-Win 
PROCEDURE 00-proc_addbr1_bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by A61-0152....
DEF VAR n AS CHAR INIT "".
    /*--- ทีอยุ่----*/
    IF wdetail2.mail_build   <> ""  THEN DO: 
        IF INDEX(wdetail2.mail_build,"อาคาร") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build). 
        ELSE IF INDEX(wdetail2.mail_build,"ตึก") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF INDEX(wdetail2.mail_build,"บ้าน") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"บจก") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"หจก") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"บริษัท") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"ห้าง") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"มูลนิธิ") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"ชั้น") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " อาคาร" + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"ห้อง") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " อาคาร" + trim(wdetail2.mail_build).
        ELSE ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " บ้าน" + trim(wdetail2.mail_build).
    END.
    IF wdetail2.mail_mu <> ""  THEN DO: 
        IF INDEX(wdetail2.mail_mu,"หมู่")      <> 0  THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_mu).
        ELSE IF INDEX(wdetail2.mail_mu,"ม.")   <> 0  THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_mu).
        ELSE IF INDEX(wdetail2.mail_mu,"บ้าน") <> 0  THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_mu). 
        ELSE IF INDEX(wdetail2.mail_mu,"หมู่บ้าน") <> 0  THEN  wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_mu).
        ELSE IF INDEX(wdetail2.mail_mu,"ที่")  <> 0  THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " หมู่" + trim(wdetail2.mail_mu).
        ELSE DO:
            ASSIGN  n = ""  
                n = SUBSTR(TRIM(wdetail2.mail_mu),1,1).
                IF INDEX("0123456789",n) <> 0 THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " หมู่ที่" + trim(wdetail2.mail_mu).
                ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_mu).
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
    IF wdetail2.mail_country <> ""  THEN DO:
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
    /*---- สาขา ----------*/
    IF wdetail2.branch = "" THEN DO:
        IF TRIM(wdetail2.prvpol) <> ""  THEN  DO:
            IF substr(TRIM(wdetail2.prvpol),1,1) = "D" THEN ASSIGN wdetail2.branch = substr(TRIM(wdetail2.prvpol),2,1).
            ELSE ASSIGN wdetail2.branch = substr(TRIM(wdetail2.prvpol),1,2).
        END.
        ELSE DO:
            ASSIGN wdetail2.branch  = "M" 
                   wdetail2.delerco = "" .
        END.

       /* FIND FIRST stat.insure USE-INDEX insure01 WHERE                       
            stat.insure.compno = "TPIS"             AND                       
            stat.insure.fname  = wdetail2.deler     AND                       
            stat.insure.lname  = wdetail2.showroom  NO-ERROR NO-WAIT.         
        IF AVAIL stat.insure THEN                                             
            ASSIGN wdetail2.branch   = stat.insure.branch                     
                   wdetail2.delerco  = stat.insure.insno .                    
        ELSE ASSIGN wdetail2.branch  = ""                                     
                    wdetail2.delerco  = "" . */ 
    END.

   end A61-0152 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_addbr2_bp c-Win 
PROCEDURE 00-proc_addbr2_bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by A61-0152....
DEF VAR n AS CHAR INIT "".
        /*--- ทีอยุ่----*/
        IF wdetail2.build  <> ""  THEN DO: 
            IF INDEX(wdetail2.build,"อาคาร") <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build). 
            ELSE IF INDEX(wdetail2.build,"บ้าน") <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
            ELSE IF INDEX(wdetail2.build,"ตึก") <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
            ELSE ASSIGN wdetail2.address = trim(wdetail2.address) + " อาคาร" + trim(wdetail2.build).
        END.
        IF wdetail2.mu <> ""  THEN DO: 
            IF INDEX(wdetail2.mu,"หมู่")      <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu).
            ELSE IF INDEX(wdetail2.mu,"ม.")   <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu).
            ELSE IF INDEX(wdetail2.mu,"บ้าน") <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu).
            ELSE IF INDEX(wdetail2.mu,"หมู่บ้าน") <> 0 THEN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu).
            ELSE DO:
                ASSIGN  n = ""  
                    n = SUBSTR(TRIM(wdetail2.mu),1,1).
                    IF INDEX("0123456789",n) <> 0 THEN wdetail2.address = trim(wdetail2.address) + " หมู่" + trim(wdetail2.mu).
                    ELSE wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu).
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
    END.
end a61-0152...*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assign3_old c-Win 
PROCEDURE 00-proc_assign3_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A58-0489    
------------------------------------------------------------------------------*/
FOR EACH wdetail2 .
    IF TRIM(wdetail2.tpis_no) = ""  THEN DELETE wdetail2.
    ELSE DO:
        IF      wdetail2.pol_netprem  = "-" THEN ASSIGN wdetail2.pol_netprem = "0" .
        ELSE IF wdetail2.pol_netprem  = " " THEN ASSIGN wdetail2.pol_netprem = "0" .
                                            ELSE ASSIGN wdetail2.pol_netprem = wdetail2.pol_netprem . 
        IF      wdetail2.pol_gprem    = "-" THEN ASSIGN wdetail2.pol_gprem   = "0" .   
        ELSE IF wdetail2.pol_gprem    = " " THEN ASSIGN wdetail2.pol_gprem   = "0" .   
                                            ELSE ASSIGN wdetail2.pol_gprem   = wdetail2.pol_gprem .
        IF      wdetail2.com_netprem  = "-" THEN ASSIGN wdetail2.com_netprem = "0" .
        ELSE IF wdetail2.com_netprem  = " " THEN ASSIGN wdetail2.com_netprem = "0" .
                                            ELSE ASSIGN wdetail2.com_netprem = wdetail2.com_netprem. 
        IF      wdetail2.com_gprem    = "-" THEN ASSIGN wdetail2.com_gprem   = "0" .
        ELSE IF wdetail2.com_gprem    = " " THEN ASSIGN wdetail2.com_gprem   = "0" .
                                            ELSE ASSIGN wdetail2.com_gprem   = wdetail2.com_gprem .
        ASSIGN fi_process = "Import data TPIS-renew".    /*A56-0262*/
        DISP fi_process WITH FRAM fr_main.
        /*IF  ((DECI(wdetail2.cc) / 2)) - (TRUNC(DECI(wdetail2.cc) / 2,0)) > 0 THEN   wdetail2.cc = STRING(DECI(wdetail2.cc) + 1) .*/ /*A61-0152*/
        /* create by : A61-0152*/
        IF deci(wdetail2.cc) <> 0 THEN DO:
            nv_cc = "" .
            IF  ((DECI(wdetail2.cc) / 2)) - (TRUNC(DECI(wdetail2.cc) / 2,0)) > 0 THEN  nv_cc = STRING(DECI(wdetail2.cc) + 1). 
            ELSE nv_cc = TRIM(wdetail2.cc). 
        END.
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno = "TPIS"             AND    
            stat.insure.fname  = wdetail2.deler     AND
            stat.insure.lname  = wdetail2.showroom  NO-ERROR NO-WAIT.
        IF AVAIL stat.insure THEN
            ASSIGN /*wdetail2.branch   = stat.insure.branch*/
            wdetail2.delerco  = stat.insure.insno . 
        ELSE ASSIGN /*wdetail2.branch  = ""*/
            wdetail2.delerco  = "" .
        /*-- end A61-0152---*/
        /* comment by : ranu A61-0416 .....
        IF trim(wdetail2.ntitle) = "นาย" THEN ASSIGN wdetail2.ntitle = "คุณ".
        ELSE IF trim(wdetail2.ntitle) = "นาง" THEN ASSIGN wdetail2.ntitle = "คุณ".
        ELSE IF trim(wdetail2.ntitle) = "นางสาว" THEN ASSIGN wdetail2.ntitle = "คุณ".
        ELSE IF trim(wdetail2.ntitle) = "น.ส." THEN ASSIGN wdetail2.ntitle = "คุณ".
        ELSE IF trim(wdetail2.ntitle) = "น.ส" THEN ASSIGN wdetail2.ntitle = "คุณ".
        .......end Ranu A61-0416.....*/
        /* create by : Ranu A61-0416 */
        FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno  = "999" AND
            TRIM(brstat.msgcode.MsgDesc) = trim(wdetail2.ntitle)  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL brstat.msgcode THEN DO:  
            ASSIGN wdetail2.ntitle  =  trim(brstat.msgcode.branch).
        END.
        ELSE DO: 
            IF wdetail2.ntitle = "" THEN ASSIGN wdetail2.ntitle = "คุณ".
            ELSE wdetail2.ntitle = trim(wdetail2.ntitle) .
        END.
        /* end Ranu A61-0416 */
        RUN proc_assign3Addr (INPUT  wdetail2.mail_tambon 
                             ,INPUT  wdetail2.mail_amper      
                             ,INPUT  wdetail2.mail_country   
                             ,INPUT  wdetail2.occup   
                             ,OUTPUT wdetail2.codeocc  
                             ,OUTPUT wdetail2.codeaddr1
                             ,OUTPUT wdetail2.codeaddr2
                             ,OUTPUT wdetail2.codeaddr3).
        RUN proc_addbr1.
        IF TRIM(wdetail2.cust_typ) = "J" THEN RUN proc_addbr2.
        IF trim(wdetail2.typ_work) = "C" THEN RUN proc_assign3_72.        /*พรบ.only 72*/
        ELSE IF trim(wdetail2.typ_work) = "V" THEN RUN proc_assign3_70.   /*กธ.only 70*/
        ELSE DO:
            IF DECI(wdetail2.pol_netprem) <> 0  AND DECI(wdetail2.pol_netprem) <> 0 THEN DO:
                FIND FIRST wdetail WHERE wdetail.policy = "0TL" + trim(wdetail2.tpis_no) NO-ERROR NO-WAIT.
                IF NOT AVAIL wdetail THEN DO:
                    CREATE wdetail.
                    ASSIGN
                        wdetail.policy      = "0TL" + trim(wdetail2.tpis_no)
                        /*wdetail.cr_2        = TRIM(wdetail2.com_no)*/ /* A63-0101*/
                        wdetail.cr_2        = IF wdetail2.typ_work = "V+C" THEN "VTL" + trim(wdetail2.tpis_no) ELSE ""  /* A63-0101*/
                        wdetail.seat        = IF      DECI(wdetail2.com_netprem) = 600 THEN "7"  
                                              ELSE IF index(wdetail2.class,"110") <> 0 THEN "7" 
                                              ELSE IF index(wdetail2.class,"210") <> 0 THEN "5"
                                              ELSE "3"  /*A61-0152*/
                        wdetail.brand       = TRIM(wdetail2.brand)
                        wdetail.poltyp      = "V70" 
                        wdetail.insrefno    = ""
                        wdetail.comdat      = TRIM(wdetail2.pol_comm_date)
                        wdetail.expdat      = TRIM(wdetail2.pol_exp_date)
                        wdetail.tiname      = trim(wdetail2.ntitle)
                        wdetail.insnam      = trim(wdetail2.insnam) + " " + TRIM(wdetail2.NAME2)
                        wdetail.ICNO        = trim(wdetail2.ICNO)     /*A56-0217*/
                        /* comment by A61-0152 ...
                        wdetail.subclass    = IF DECI(wdetail2.com_netprem) = 600 THEN "110" ELSE 
                                              IF DECI(wdetail2.com_netprem) <> 0  THEN "210" ELSE TRIM(wdetail2.CLASS)
                        wdetail.model       = IF INDEX(wdetail2.model,"TFR85HG") <> 0 THEN "MU-7" ELSE "D-MAX" 
                        end A61-0152...*/
                        /* create by A61-0152 */
                        wdetail.subclass    = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,2,3) ELSE trim(wdetail2.CLASS)
                        wdetail.model       = TRIM(wdetail2.model) 
                        wdetail.engine      = nv_cc
                        /*end A61-0152*/
                        wdetail.cc          = trim(wdetail2.cc) 
                        wdetail.caryear     = trim(wdetail2.md_year)
                        wdetail.chasno      = trim(wdetail2.chasno)
                        wdetail.vehreg      = trim(wdetail2.License) + " " + trim(wdetail2.regis_cl)
                        wdetail.engno       = trim(wdetail2.engno)
                        wdetail.iadd1       = trim(wdetail2.mail_hno)               
                        wdetail.iadd2       = trim(wdetail2.mail_tambon)            
                        wdetail.iadd3       = trim(wdetail2.mail_amper)             
                        wdetail.iadd4       = trim(wdetail2.mail_country) 
                        wdetail.post        = TRIM(wdetail2.mail_post)
                        wdetail.address     = trim(wdetail2.address)
                        wdetail.tambon      = trim(wdetail2.tambon)
                        wdetail.amper       = trim(wdetail2.amper) 
                        wdetail.country     = trim(wdetail2.country)
                        wdetail.vehuse      = "1"
                        /*wdetail.garage      = ""*/ /*A61-0152*/
                        /*wdetail.garage      = IF INDEX(wdetail2.np_f18line4,"ห้าง") <> 0 THEN "G" ELSE ""  /*A61-0152*/*/ /*A62-0422*/
                        wdetail.garage      = IF INDEX(wdetail2.np_f18line4,"ห้าง") <> 0 THEN "G"
                                              ELSE IF INDEX(wdetail2.np_f18line4,"อะไหล่แท้") <> 0  THEN "P" ELSE "" /*A62-0422*/
                        wdetail.stk         = ""
                        wdetail.covcod      = TRIM(wdetail2.cover)
                        wdetail.si          = trim(wdetail2.si) 
                        /*wdetail.prempa      = caps(trim(fi_pack))*/ /*A61-0152*/
                        wdetail.prempa      = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,1,1) ELSE ""  /*A61-0152*/
                        wdetail.branch      = TRIM(wdetail2.branch)
                        wdetail.benname     = TRIM(wdetail2.financename) 
                        wdetail.volprem     = trim(wdetail2.pol_netprem)   /*A61-0152*/
                        wdetail.comment     = ""
                        wdetail.agent       = trim(fi_agent) 
                        /*wdetail.producer    = TRIM(fi_producer)*/ /*A61-0152*/
                        wdetail.producer    = IF wdetail2.producer <> "" THEN trim(wdetail2.producer) 
                                              ELSE IF index(wdetail2.deler,"Refinance") <> 0 THEN trim(fi_producerre) 
                                              ELSE trim(fi_producer) /*A61-0152*/
                        wdetail.entdat      = string(TODAY)              /*entry date*/
                        wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
                        wdetail.trandat     = STRING(TODAY)             /*tran date*/
                        wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
                        wdetail.n_IMPORT    = "IM"
                        wdetail.n_EXPORT    = "" 
                        wdetail.prvpol      = trim(wdetail2.prvpol)
                        /*wdetail.inscod      = wdetail2.typepay  */  
                        wdetail.cedpol      = trim(wdetail2.tpis_no)  
                        wdetail.remark      = trim(wdetail2.remark1)  
                        wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE ""    
                        wdetail.cuts_typ    = TRIM(wdetail2.cust_type)
                        /*wdetail.promo       = "TIL"*/
                        /*A61-0152*/
                        wdetail.promo       = TRIM(wdetail2.bus_typ) 
                        /*wdetail.campens     = IF INDEX(wdetail2.campaign,"/") <> 0 THEN trim(REPLACE(wdetail2.campaign,"/","_")) ELSE TRIM(wdetail2.campaign)*/
                        wdetail.campens     = wdetail2.campaign
                        wdetail.finint      = TRIM(wdetail2.delerco) 
                        wdetail.seat41      = INT(wdetail.seat) 
                        /* end A61-0152*/
                        wdetail.occup       = TRIM(n_occupn)
                        wdetail.prmtxt      = IF wdetail2.acc_cv <> "" THEN TRIM(wdetail2.acc_cv) + " " + trim(Wdetail2.Acc_amount) ELSE "" .







                    IF  (wdetail2.np_f18line1 <> "") OR (wdetail2.np_f18line2 <> "") OR
                        (wdetail2.np_f18line3 <> "") OR (wdetail2.np_f18line4 <> "") OR
                        (wdetail2.np_f18line5 <> "") OR (wdetail2.np_f18line6 <> "") OR 
                        (wdetail2.np_f18line7 <> "") OR (wdetail2.np_f18line8 <> "") THEN DO:
                        FIND LAST wdetmemo WHERE wdetmemo.policymemo = wdetail.policy  NO-ERROR NO-WAIT.
                        IF NOT AVAIL wdetmemo THEN DO:
                            CREATE wdetmemo.
                            ASSIGN 
                                wdetmemo.policymemo = wdetail.policy
                                wdetmemo.f18line1   = wdetail2.np_f18line1 
                                wdetmemo.f18line2   = wdetail2.np_f18line2 
                                wdetmemo.f18line3   = wdetail2.np_f18line3 
                                wdetmemo.f18line4   = wdetail2.np_f18line4
                                wdetmemo.f18line5   = wdetail2.np_f18line5 
                                wdetmemo.f18line6   = wdetail2.np_f18line6  /*Kridtiya i. 21/08/2020 */
                                wdetmemo.f18line7   = wdetail2.np_f18line7  /*Kridtiya i. 21/08/2020 */
                                wdetmemo.f18line8   = wdetail2.np_f18line8  /*Kridtiya i. 21/08/2020 */
                                .
                        END.
                    END.
                END.  /* FIND FIRST wdetail */
            END.
            /*IF TRIM(wdetail2.com_no) <> ""  AND DECI(wdetail2.com_netprem) <> 0  AND DECI(wdetail2.com_gprem) <> 0   THEN DO: */  /*create v72*/ /*a63-0101*/
            IF DECI(wdetail2.com_netprem) <> 0  AND DECI(wdetail2.com_gprem) <> 0   THEN DO:  /*create v72*/ /*a63-0101*/    
            /* FIND FIRST wdetail WHERE wdetail.policy = TRIM(wdetail2.com_no) NO-ERROR NO-WAIT. */ /*a63-0101*/
                FIND FIRST wdetail WHERE wdetail.policy = "VTL" + trim(wdetail2.tpis_no) NO-ERROR NO-WAIT.  /*a63-0101*/
                IF NOT AVAIL wdetail THEN DO:
                    CREATE wdetail.
                    ASSIGN
                        /*wdetail.policy     = TRIM(wdetail2.com_no)*/  /*a63-0101 */
                        wdetail.policy      = "VTL" + trim(wdetail2.tpis_no)  /*a63-0101 */
                        wdetail.cr_2        = IF wdetail2.typ_work = "V+C" THEN "0TL" + trim(wdetail2.tpis_no) ELSE ""
                        /*wdetail.seat        = IF DECI(wdetail2.com_netprem) = 600 THEN "7"  ELSE "3"*/ /*A61-0152*/
                        wdetail.seat        = IF DECI(wdetail2.com_netprem) = 600 THEN "7"  
                                              ELSE IF index(wdetail2.class,"110") <> 0 THEN "7" 
                                              ELSE IF index(wdetail2.class,"210") <> 0 THEN "5"
                                              ELSE "3"  /*A61-0152*/
                        wdetail.brand       = TRIM(wdetail2.brand)
                        wdetail.poltyp      = "V72" 
                        wdetail.insrefno    = ""
                        wdetail.comdat      = TRIM(wdetail2.com_comm_date)    
                        wdetail.expdat      = TRIM(wdetail2.com_exp_date)     
                        wdetail.tiname      = trim(wdetail2.ntitle)
                        wdetail.insnam      = trim(wdetail2.insnam) + " " + TRIM(wdetail2.name2)
                        /* comment by A61-0152 ...
                        wdetail.subclass    = IF DECI(wdetail2.com_netprem) = 600 THEN "110" ELSE 
                                              IF DECI(wdetail2.com_netprem) <> 0  THEN "210" ELSE TRIM(wdetail2.CLASS)
                        wdetail.model       = IF INDEX(wdetail2.model,"TFR85HG") <> 0 THEN "MU-7" ELSE "D-MAX" 
                        end A61-0152...*/
                        /* create by A61-0152 */
                        wdetail.subclass    = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,2,3) ELSE trim(wdetail2.CLASS)
                        wdetail.model       = TRIM(wdetail2.model) 
                        wdetail.engine      = nv_cc
                        /*end A61-0152*/
                        wdetail.cc          = trim(wdetail2.cc)              
                        wdetail.caryear     = trim(wdetail2.md_year)         
                        wdetail.chasno      = trim(wdetail2.chasno)          
                        wdetail.vehreg      = trim(wdetail2.License) + " " + trim(wdetail2.regis_cl)           
                        wdetail.engno       = trim(wdetail2.engno)           
                        wdetail.iadd1       = trim(wdetail2.mail_hno)                      
                        wdetail.iadd2       = trim(wdetail2.mail_tambon)                   
                        wdetail.iadd3       = trim(wdetail2.mail_amper)                    
                        wdetail.iadd4       = trim(wdetail2.mail_country)
                        wdetail.post        = TRIM(wdetail2.mail_post)
                        wdetail.address     = trim(wdetail2.address)        
                        wdetail.tambon      = trim(wdetail2.tambon)         
                        wdetail.amper       = trim(wdetail2.amper)          
                        wdetail.country     = trim(wdetail2.country)        
                        wdetail.vehuse      = "1"
                        wdetail.garage      = ""
                        /*wdetail.stk         = ""*//*A56-0217*/
                        wdetail.ICNO        = trim(wdetail2.ICNO)       /*A56-0217*/
                        wdetail.stk         = TRIM(wdetail2.stkno) 
                        /* wdetail.docno       = "" /*trim(wdetail2.docno)      /*A56-0217*/*/ */ /*****Block By Nontamas H. [A62-0329] Date 08/07/2019*****/
                        wdetail.docno       = trim(wdetail2.docno) /*****Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
                        wdetail.covcod      = "T" 
                        wdetail.si          = trim(wdetail2.si) 
                        /*wdetail.prempa      = trim(fi_pack)*/ /*A61-0152*/
                        /*wdetail.branch      = "M" */               /*A63-0101*/
                        wdetail.branch      = TRIM(wdetail2.branch)  /*A63-0101*/
                        /*wdetail.benname     = "บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด"*//*A57-0010*/
                        wdetail.benname     = ""  /*A57-0010*/
                        /*wdetail.volprem     = wdetail2.ref_no *//*A56-0217*/
                        wdetail.volprem     = TRIM(wdetail2.com_gprem)  /*A61-0152*/
                        wdetail.comment     = ""
                        wdetail.agent       = trim(fi_agent)     
                        /*wdetail.producer    = TRIM(fi_producer)*/ /*A61-0152*/
                        wdetail.prempa      = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,1,1) ELSE ""  /*A61-0152*/
                        wdetail.producer    = IF wdetail2.producer <> "" THEN trim(wdetail2.producer) 
                                              ELSE IF index(wdetail2.deler,"Refinance") <> 0 THEN trim(fi_producerre) 
                                              ELSE trim(fi_producer) /*A61-0152*/
                        wdetail.entdat      = string(TODAY)              /*entry date*/
                        wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
                        wdetail.trandat     = STRING(TODAY)             /*tran date*/
                        wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
                        wdetail.n_IMPORT    = "IM"
                        wdetail.n_EXPORT    = "" 
                        /*wdetail.inscod      = wdetail2.typepay  */  
                        wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE ""    
                        wdetail.remark      = trim(wdetail2.remark1)  
                        /*wdetail.promo       = "TIL"*/
                        wdetail.promo       = TRIM(wdetail2.bus_typ) /*A61-0152*/
                        wdetail.cedpol      = trim(wdetail2.tpis_no)
                        wdetail.occup       = TRIM(n_occupn)
                        wdetail.finint      = TRIM(wdetail2.delerco) /*A61-0152*/
                        wdetail.seat41      = INT(wdetail.seat) /*A61-0152*/
                        wdetail.cuts_typ    = TRIM(wdetail2.cust_type).
                        /*wdetail.sendnam     = trim(wdetail2.sendnam)  
                        wdetail.chkcar      = trim(wdetail2.chkcar)   
                        wdetail.telno       = trim(wdetail2.telno)  
                        wdetail.prmtxt      = "" */ 
                END.
            END.  /* stk */
        END.
    END. 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assignrenew c-Win 
PROCEDURE 00-proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0177....
DEF VAR n_benname  AS CHAR FORMAT "x(50)".
DEF VAR nv_status  AS CHAR FORMAT "x(5)".
DEF VAR nv_renpol  AS CHAR FORMAT "x(13)".
DEF VAR nv_prmtxt  AS CHAR FORMAT "x(200)".
DEF VAR nv_bran    AS CHAR FORMAT "X(2)".
DEF VAR nv_insref  AS CHAR FORMAT "x(10)" .
DEF VAR nv_branold AS CHAR FORMAT "x(10)" .
ASSIGN 
    n_benname   = "" 
    n_policy    = ""
    np_prepol   = ""
    n_body      = ""
    nn_redbook  = ""
    n_Engine    = ""
    n_Tonn70    = 0
    nv_status   = ""
    nv_renpol   = ""
    nv_prmtxt   = ""
    nv_bran     = ""    /*A61-0152*/
    nv_insref   = "" .  /*A61-0152*/
RUN proc_assignrenew_inipol.
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwtilexp(INPUT-OUTPUT wdetail.prvpol,               
                     INPUT-OUTPUT  nv_branold,      /* wdetail.branch, *//* A63-00472 */           
                     INPUT-OUTPUT  wdetail.insrefno,
                     INPUT-OUTPUT  nv_deler,                 
                     INPUT-OUTPUT  re_firstdat,               
                     INPUT-OUTPUT  re_comdat,                
                     INPUT-OUTPUT  re_expdat,                
                     INPUT-OUTPUT  wdetail.prempa,           
                     INPUT-OUTPUT  re_class,                 
                     INPUT-OUTPUT  nn_redbook,               
                     INPUT-OUTPUT  re_moddes,                
                     INPUT-OUTPUT  re_yrmanu,                
                     INPUT-OUTPUT  wdetail.cargrp,           
                     INPUT-OUTPUT  n_body,                   
                     INPUT-OUTPUT  n_Engine,                 
                     INPUT-OUTPUT  n_Tonn70,                       
                     INPUT-OUTPUT  re_seats,                       
                     INPUT-OUTPUT  re_vehuse,                      
                     INPUT-OUTPUT  re_covcod,                      
                     INPUT-OUTPUT  re_garage,                      
                     INPUT-OUTPUT  re_vehreg,                      
                     INPUT-OUTPUT  re_cha_no,                      
                     INPUT-OUTPUT  re_eng_no,                      
                     INPUT-OUTPUT  re_uom1_v,                      
                     INPUT-OUTPUT  re_uom2_v,                      
                     INPUT-OUTPUT  re_uom5_v,                      
                     INPUT-OUTPUT  re_si,                          
                     INPUT-OUTPUT  re_baseprm, 
                     INPUT-OUTPUT  re_baseprm3, /*A61-0152*/
                     INPUT-OUTPUT  re_41,                          
                     INPUT-OUTPUT  re_42,                          
                     INPUT-OUTPUT  re_43,                          
                     INPUT-OUTPUT  re_seat41,                      
                     INPUT-OUTPUT  re_dedod,                       
                     INPUT-OUTPUT  re_addod,                       
                     INPUT-OUTPUT  re_dedpd,                       
                     INPUT-OUTPUT  re_flet_per,                    
                     INPUT-OUTPUT  re_ncbper,                      
                     INPUT-OUTPUT  re_dss_per,                     
                     INPUT-OUTPUT  re_stf_per,                     
                     INPUT-OUTPUT  re_cl_per,
                     INPUT-OUTPUT  re_prem, /*A61-0152*/
                     INPUT-OUTPUT  n_benname,                      
                     INPUT-OUTPUT  nv_prmtxt,                 
                     INPUT-OUTPUT  nv_driver,
                     INPUT-OUTPUT  nv_status,    
                     INPUT-OUTPUT  nv_renpol,
                     INPUT-OUTPUT  nv_cctv).
END.
/*IF nv_status <> "RW" AND nv_renpol = " " THEN DO:*/
    ASSIGN np_prepol  =  wdetail.prvpol
           n_policy   =  wdetail.cr_2
           nv_bran    =  trim(wdetail.branch)    /*A61-0152*/
           nv_insref  =  trim(wdetail.insrefno)  /*A61-0152*/
           wdetail.volprem = STRING(re_prem) .
    /*A63-00472....
    /*Saowapa U. A62-0110 26/2019*/
    IF nv_bran = "37" THEN DO:
       ASSIGN
       wdetail.branch = "J"
       nv_insref = ""
       wdetail.insrefno = "".
    END.
    /*Saowapa U. A62-0110 26/2019*/
    A63-00472....*/
    /*Saowapa U.A62-0186 23/05/2019*/
    /* comment by : A6-0344....
    IF nv_bran = "12" THEN DO:
        ASSIGN                   
        wdetail.branch = "M"     
        nv_insref = ""           
        wdetail.insrefno = "".   
    END.
    ELSE IF nv_bran = "14" THEN DO:
         ASSIGN                   
         wdetail.branch = "M"     
         nv_insref = ""           
         wdetail.insrefno = "". 
    END.
    ELSE IF nv_bran = "T" THEN DO:
        ASSIGN                    
        wdetail.branch = "M"     
        nv_insref = ""           
        wdetail.insrefno = "".   
    END.
   ...end : A6-0344..*/
    /* add by : A6-0344 */
    FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.compno  = "TPIS-BR" AND 
              stat.insure.branch  = nv_bran   NO-LOCK NO-ERROR .
        IF AVAIL stat.insure THEN DO:
            ASSIGN  wdetail.branch = trim(stat.insure.vatcode) .
        IF nv_bran <> wdetail.branch THEN             
            ASSIGN  nv_insref = ""           
                    wdetail.insrefno = "". 
    END.
    /* end : A6-0344 */

    /*Saowapa U.A62-0186 23/05/2019*/
    IF wdetail.cr_2 <> "" THEN DO: /* ใส่ข้อมูลให้ พรบ. */
       FIND LAST wdetail WHERE wdetail.policy = n_policy AND wdetail.covcod = "T" NO-LOCK no-error .
        IF AVAIL wdetail THEN DO:
            ASSIGN wdetail.subclass   =  re_class    
                   wdetail.body       =  n_body    
                   wdetail.cc         =  n_engine  
                   wdetail.redbook    =  nn_redbook
                   /*wdetail.brand      =  re_moddes */ /*A61-0152*/
                   wdetail.caryear    =  re_yrmanu     
                   wdetail.seat       =  re_seats  
                   wdetail.vehuse     =  re_vehuse 
                   wdetail.covcod     =  re_covcod 
                   wdetail.insrefno   =  nv_insref . /*A63-0101*/
           /* IF nv_bran = "M" THEN ASSIGN wdetail.insrefno = nv_insref .*/ /*A61-0152*/ /*A63-0101*/
       END.
    END.
    FIND LAST wdetail WHERE wdetail.prvpol = np_prepol AND wdetail.covcod <> "T"  NO-LOCK NO-ERROR . /* ใส่ข้อมูลให้ กธ. */
    IF AVAIL wdetail THEN DO:
       ASSIGN  wdetail.insrefno = nv_insref         /*a63-0101*/
               n_firstdat       =  DATE(re_firstdat)
               wdetail.subclass = re_class           
               wdetail.redbook  = nn_redbook         
               /*wdetail.model    = re_moddes  */ /*A61-0152*/                           
               wdetail.caryear  = re_yrmanu 
               wdetail.body     = n_body             
               wdetail.cc       = n_Engine           
               nv_tons          = n_Tonn70 
               wdetail.weight   = string(n_tonn70) /*A63-0113*/
               wdetail.seat     = re_seats           
               wdetail.vehuse   = re_vehuse          
               wdetail.covcod   = re_covcod          
               wdetail.garage   = re_garage 
               nv_uom1_v        = DECI(re_uom1_v)          
               nv_uom2_v        = DECI(re_uom2_v)          
               nv_uom5_v        = DECI(re_uom5_v) 
               wdetail.deductpp = re_uom1_v /*A61-0152*/   
               wdetail.deductba = re_uom2_v /*A61-0152*/   
               wdetail.deductpa = re_uom5_v /*A61-0152*/
               wdetail.si       = re_si              
               nv_basere        = re_baseprm
               wdetail.base3    = string(re_baseprm3)
               wdetail.netprem  = STRING(re_prem)
               nv_41            = re_41              
               nv_42            = re_42              
               nv_43            = re_43 
               wdetail.no_411   = string(re_41)  /*A61-0152*/
               wdetail.no_42    = string(re_42)  /*A61-0152*/
               wdetail.no_43    = string(re_43)  /*A61-0152*/
               wdetail.seat41   = re_seat41          
               dod1             = re_dedod     /*"dod" */     
               dod2             = re_addod     /*"dod2"*/     
               dod0             = re_dedpd     /*"dpd" */     
               wdetail.fleet    = re_flet_per 
               wdetail.NCB      = re_ncbper         
               /*nv_dss_per       = DECI(re_dss_per)   */ /*A61-0152*/
               wdetail.dspc     = re_dss_per /* A61-0152*/
               nv_stf_per       = re_stf_per       
               nv_cl_per        = re_cl_per
               wdetail.loadclm  = string(re_cl_per)     /*A61-0152*/
               wdetail.staff    = string(re_stf_per)   /*A61-0152*/
               wdetail.prmtxt   = IF nv_prmtxt <> "" THEN wdetail.prmtxt + " " + TRIM(nv_prmtxt) ELSE wdetail.prmtxt. 
               /*Saowapa U. A62-0110 25/02/2019*/
                IF wdetail.promo   = "CV" THEN  DO:      
                    wdetail.model  = re_moddes.    
                END.  
               /*Saowapa U. A62-0110 25/02/2019*/
                /*IF nv_bran = "M" THEN ASSIGN wdetail.insrefno = nv_insref .*/  /*Saowapa U*/ /*a63-0101*/
                /* Add : A63-0113 */
                /*IF DATE(wdetail.comdat) >= 04/01/2020 AND trim(wdetail.prempa) <> "A" THEN DO: */ /*A64-0344*/
                IF DATE(wdetail.comdat) >= 04/01/2020 THEN DO:  /*A64-0344*/
                    IF      trim(wdetail.prempa) = "A" THEN ASSIGN wdetail.prempa = "A".  /*A64-0344*/
                    ELSE IF trim(wdetail.prempa) = "U" THEN ASSIGN wdetail.prempa = "U".  /*A64-0344*/
                    ELSE ASSIGN wdetail.prempa = "T".
                END.
                /* end : A63-0113 */
    END. 
/*END.
ELSE DO:
    wdetail.comment = wdetail.comment + "| ข้อมูลกรมธรรม์ที่ระบบ Expiry ถูกต่ออายุเป็นเบอร์ " + nv_renpol .
END.*/
...END A65-0177..... */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_base2 c-Win 
PROCEDURE 00-proc_base2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0344....
DEF VAR chk     AS LOGICAL.
DEF VAR model   AS CHAR .
DEF VAR aa      AS DECI.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF wdetail.poltyp = "v70" THEN DO:
    IF wdetail.prvpol = "" THEN DO:
        IF deci(wdetail.base) <> 0 THEN ASSIGN nv_baseprm = deci(wdetail.base) . /*A61-0152*/
        ELSE  RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ELSE 
        ASSIGN aa      = nv_basere
            nv_baseprm = nv_basere .  
    ASSIGN chk = NO
        nv_baseprm = aa
        NO_basemsg = " " .
    IF nv_drivno = 0 THEN
        Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN nv_drivvar  = " "
            nv_drivvar     = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END. 
   
    /*-------nv_baseprm----------*/
    IF NO_basemsg <> " " THEN 
        wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN  nv_basevar = "" 
        nv_prem1   = nv_baseprm
        nv_basecod = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    ASSIGN  nv_41 = 0
            nv_42 = 0
            nv_43 = 0
            nv_41 = deci(wdetail.no_411)  
            nv_42 = deci(wdetail.no_42)
            nv_43 = deci(wdetail.no_43) .
       
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                    nv_class,
                    nv_key_b,
                    nv_comdat). 

    nv_411var = "" .   /*A61-0152*/
    nv_412var = "" .   /*A61-0152*/
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
    /* -------fi_42---------*/
    nv_42var    = " ".     
    Assign
        nv_42cod   = "42".
    nv_42var1  = "     Medical Expense = ".
    nv_42var2  = STRING(nv_42).
    SUBSTRING(nv_42var,1,30)   = nv_42var1.
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
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/  
    /*------nv_usecod------------*/
    ASSIGN nv_usevar = ""
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
     ASSIGN nv_grpvar = ""
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
         /*nv_bipvar2     =  STRING(uwm130.uom1_v) */ /*A61-0152*/  
         nv_bipvar2     =  TRIM(wdetail.deductpp)  /*A61-0152*/      
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1                   
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     nv_biavar = "" .
     Assign 
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         /*nv_biavar2     =   STRING(uwm130.uom2_v)*/ /*A61-0152*/
         nv_biavar2     =  TRIM(wdetail.deductba)  /*A61-0152*/
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     nv_pdavar = "" .
     Assign
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         /*nv_pdavar2     =  STRING(uwm130.uom5_v)*/ /*A61-0152*/
         nv_pdavar2     =  TRIM(wdetail.deductpa) /*A61-0152*/
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
     
      ASSIGN  
          nv_odcod = "DC01"
          nv_prem  =   dod1.        
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
          ASSIGN
              wdetail.pass    = "N"
              wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
          /*NEXT.*/
      END.
      ASSIGN nv_dedod1var = ""
          nv_ded1prm       = nv_prem
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
          nv_cons  = "PD"
          nv_ded   = dpd0.
        Run  Wgs\Wgsmx025(INPUT  dod0, /*a490166 note modi*/
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
              nv_dedpdvar2   =  STRING(dod0)
              SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
              SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
              nv_dedpd_prm  = nv_prem.
      /*---------- fleet -------------------*/
      nv_flet_per =    INTE(wdetail.fleet) .
      IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
          Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
          ASSIGN
              wdetail.pass    = "N"
              wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
          /*NEXT.  *//*a490166*/
      END.
      IF nv_flet_per = 0 Then do:
          Assign
              nv_flet     = 0
              nv_fletvar  = " ".
      END.
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
          nv_fletvar                  = " "
          nv_fletvar1                 = "     Fleet % = "
          nv_fletvar2                 =  STRING(nv_flet_per)
          SUBSTRING(nv_fletvar,1,30)  = nv_fletvar1
          SUBSTRING(nv_fletvar,31,30) = nv_fletvar2.
      IF nv_flet   = 0  THEN
          nv_fletvar  = " ".
      /*---------------- NCB -------------------*/
      /*IF wdetail.covcod = "3" THEN WDETAIL.NCB = "30".*/
      ASSIGN 
          NV_NCBPER  = INTE(WDETAIL.NCB)
          nv_ncb     = INTE(WDETAIL.NCB)
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
          END.
          ASSIGN
              nv_ncbper = xmm104.ncbper   
              nv_ncbyrs = xmm104.ncbyrs.
      END.
      Else do:  
          Assign
              nv_ncbyrs  =   0
              nv_ncbper  =   0
              nv_ncb     =   0.
      END.
      RUN WGS\WGSORPRM.P (INPUT nv_tariff, /*pass*/
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
     /*-------------- load claim ---------------------*/
     nv_cl_per  = 0.
     nv_cl_per  = deci(wdetail.loadclm).
     nv_clmvar  = " ".
     IF nv_cl_per  <> 0  THEN
         Assign 
         nv_clmvar1   = " Load Claim % = "
         nv_clmvar2   =  STRING(nv_cl_per)
         SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
         SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
     RUN WGS\WGSORPRM.P (INPUT nv_tariff, /*pass*/
                               nv_class,
                               nv_covcod,
                               nv_key_b,
                               nv_comdat,
                               nv_totsi,
                               uwm130.uom1_v,
                               uwm130.uom2_v,
                               uwm130.uom5_v).
     /*-------------- dspc----------------*/
     nv_dss_per = 0.                    /*A61-0152*/
     nv_dss_per = deci(wdetail.dspc) .  /*A61-0152*/
     IF  nv_dss_per   <> 0  THEN
         Assign nv_dsspcvar = ""
         nv_dsspcvar1   = "     Discount Special % = "
         nv_dsspcvar2   =  STRING(nv_dss_per)
         SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
         SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
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

     /*------------------ stf ---------------*/
       nv_stf_per  = 0 .
       nv_stfvar   = " ".
       nv_stf_per  = DECI(wdetail.staff). /*A60-0152*/
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
                    nv_uom5_v ).

    ASSIGN fi_process = "out base2 " + wdetail.policy.
    DISP fi_process WITH FRAM fr_main.
END.
...end a64-0344...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_base2_camp c-Win 
PROCEDURE 00-proc_base2_camp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by A61-0416...
DEF VAR chk     AS LOGICAL.
DEF VAR model   AS CHAR .
DEF VAR aa      AS DECI.

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
        NO_basemsg  = " "
        nv_baseprm  = aa
        nv_dss_per  =  deci(wdetail.dspc).

    IF nv_drivno = 0 THEN
        Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN  nv_drivvar = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
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
        SUBSTRING(nv_412var,31,30)  = nv_412var2

    /* -------fi_42---------*/   
    nv_42var    = " ".     
    Assign
        nv_42cod   = "42".
    nv_42var1  = "     Medical Expense = ".
    nv_42var2  = STRING(nv_42).
    SUBSTRING(nv_42var,1,30)   = nv_42var1.
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
    Assign
        nv_usevar  = ""
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
      ASSIGN nv_grpvar = ""
          nv_grpcod      = "GRP" + wdetail.cargrp
          nv_grpvar1     = "     Vehicle Group = "
          nv_grpvar2     = wdetail.cargrp
          Substr(nv_grpvar,1,30)  = nv_grpvar1
          Substr(nv_grpvar,31,30) = nv_grpvar2.
     /*-------------nv_bipcod--------------------*/
     ASSIGN nv_bipvar = ""
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(deci(wdetail.deductpp))
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign nv_biavar  = ""
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(deci(wdetail.deductba))
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN nv_pdavar = ""
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         nv_pdavar2     = string(deci(WDETAIL.deductpa))   
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.

     /*------------------------- 2+ 3+  -------------------------------------------*/
     IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2" OR wdetail.covcod = "3.1" OR wdetail.covcod = "3.2"  THEN DO:
        nv_usecod3 = "" .
        IF      (wdetail.covcod = "2.1")   THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "21" .
        ELSE IF (wdetail.covcod = "2.2")   THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "22" .
        ELSE IF (wdetail.covcod = "3.1")  THEN  nv_usecod3 = "U" + TRIM(nv_vehuse) + "31" .
        ELSE nv_usecod3 = "U" + TRIM(nv_vehuse) + "32" .
        
        ASSIGN   nv_usevar3 = ""
            nv_usevar4 = "     Vehicle Use = "
            nv_usevar5 =  wdetail.vehuse
            Substring(nv_usevar3,1,30)   = nv_usevar4
            Substring(nv_usevar3,31,30)  = nv_usevar5.

         nv_basecod3 = "" .
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
     END.
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
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     /*----------- load claim -----------*/

     nv_clmvar  = " ".
    /*nv_cl_per  = DECI(wdetail.cl_per).*/ 
    IF nv_cl_per  <> 0  THEN
        Assign 
        nv_clmvar1   = " Load Claim % = "
        nv_clmvar2   =  STRING(nv_cl_per)
        SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
     
     /*------------------ dsspc ---------------*/
    nv_dsspcvar   = " ".
     IF  nv_dss_per   <> 0  THEN
         Assign
         nv_dsspcvar1   = "     Discount Special % = "
         nv_dsspcvar2   =  STRING(nv_dss_per)
         SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
         SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
     /*------------------ stf ---------------*/
          nv_stfvar   = " ".
          /*nv_stf_per     = DECI(wdetail.stf_per). /*A60-0150*/*/
      IF  nv_stf_per   <> 0  THEN
           ASSIGN nv_stfvar1   = "     Discount Staff"          
                 nv_stfvar2   =  STRING(nv_stf_per)           
                 SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1    
                 SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2. 
     /*--------------------------*/                        
     
END.

IF wdetail.polmaster <> "" THEN RUN proc_adduwd132.
... end A61-0416...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_baseplus c-Win 
PROCEDURE 00-proc_baseplus :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : a64-0334 ....
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "v70" THEN DO:
    /*Saowapa U. A62-0186*/
    IF wdetail.prvpol <> ""  THEN DO:
       wdetail.base = STRING(nv_basere).
    END.
    /*End Saowapa U. A62-0186*/
   
    ASSIGN fi_process = "Create data to base..." + wdetail.policy 
        nv_baseprm    = 0
        nv_baseprm    = DECI(wdetail.base)    .
    IF wdetail.base = "" OR DECI(wdetail.base) = 0  THEN DO:
        IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR
           (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN DO: 
            RUN wgs\wgsfbas.
        END.
    END.
    DISP fi_process WITH FRAM fr_main.
    IF nv_baseprm = 0  THEN DO: 
        RUN wgs\wgsfbas.
    END.
    ASSIGN chk = NO
        NO_basemsg = " " .
    If nv_drivno  = 0  Then 
        Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN  wdetail.pass = "N"
                wdetail.comment  = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN  nv_drivvar = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.
    /*-------nv_baseprm----------*/
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
    IF wdetail.prvpol <> "" THEN  
    ASSIGN 
        nv_41 = deci(wdetail.no_411) 
        nv_42 = deci(wdetail.no_42)
        nv_43 = deci(wdetail.no_43)      
        nv_seat41 = 0 
        nv_seat41 = IF wdetail.seat41  = 0 THEN deci(wdetail.seat) ELSE wdetail.seat41.
       /* nv_class  =  wdetail.subclass.*/  /*Saowapa U. A62-0186 04/06/2019*/
    RUN WGS\WGSOPER(INPUT nv_tariff, /*add krid  23/07/2015 */
                nv_class,
                nv_key_b,
                nv_comdat). 

    nv_411var = "" . /* A61-0152*/
    nv_412var = "" . /* A61-0152*/
    ASSIGN 
        nv_41     =  deci(wdetail.no_411)  
        nv_41cod1 = "411"
        nv_411var1   = "     PA Driver = "
        nv_411var2   =  STRING(nv_41)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"       /* 412 412 412 412 .........................*/
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(nv_41)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_41
        nv_412prm  = nv_41.
    nv_42var    = " ".       /* -------fi_42---------*/
    Assign
        nv_42cod   = "42" 
        nv_42var1  = "     Medical Expense = " 
        nv_42var2  = STRING(nv_42) 
        SUBSTRING(nv_42var,1,30)   = nv_42var1 
        SUBSTRING(nv_42var,31,30)  = nv_42var2 
    nv_43var    = " ".        /*---------fi_43--------*/
    Assign
        nv_43prm   = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    /*RUN proc_wgsoper .*/
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*add krid  23/07/2015 */
                    nv_class,
                    nv_key_b,
                    nv_comdat).     
    /*------nv_usecod------------*/
    Assign
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30)  = nv_usevar2.
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
    nv_sivar = "" .
    Assign  nv_totsi = 0
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
    nv_bipvar = "" .
    ASSIGN
        nv_bipcod      = "BI1"
        nv_bipvar1     = "     BI per Person = "
        nv_bipvar2     =  wdetail.deductpp    /*STRING(uwm130.uom1_v)*/
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    nv_biavar = "" .
    Assign 
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     =  wdetail.deductba     /* STRING(uwm130.uom2_v)*/
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*Add kridtiya i.  2+ 3 */
    IF      (wdetail.covcod = "2.1")   THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "21" .
    ELSE IF (wdetail.covcod = "2.2")   THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "22" .
    ELSE IF (wdetail.covcod = "3.1")  THEN  nv_usecod3 = "U" + TRIM(nv_vehuse) + "31" .
    ELSE nv_usecod3 = "U" + TRIM(nv_vehuse) + "32" .
    ASSIGN   
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
     ASSIGN 
         nv_basevar4 = "     Base Premium3 = "
         nv_basevar5 = STRING(nv_baseprm3)
         SUBSTRING(nv_basevar3,1,30)   = nv_basevar4
         SUBSTRING(nv_basevar3,31,30)  = nv_basevar5.  
     ASSIGN
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
    nv_pdavar = "" .
    Assign
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     =  wdetail.deductpa         /*STRING(uwm130.uom5_v)*/
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    RUN WGS\WGSORPR1.P (INPUT   nv_tariff,  
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                deci(wdetail.si),
                                deci(wdetail.deductpp),
                                deci(wdetail.deductba),
                                deci(wdetail.deductpa)).   /*kridtiya i.*/
    /*--------------- deduct ----------------*/
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1")  THEN ASSIGN dod1 = 2000 .   /*A57-0126*/
    ELSE DO:
        IF dod0 > 3000 THEN DO:
            dod1 = 3000.
            dod2 = dod0 - dod1.
        END.
    END.
    IF dod0 <> 0 THEN DO:
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
        ASSIGN nv_ded1prm     = nv_prem
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
            nv_cons  = "PD"
            nv_ded   = dpd0
            /*dod0 = 0*/    .
        Run  Wgs\Wgsmx025(INPUT  dod0,  
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
            nv_dedpdvar2   =  STRING(dod0)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
            nv_dedpd_prm  = nv_prem.
    END.
    /*---------- fleet -------------------*/
    ASSIGN nv_flet_per = DECI(wdetail.fleet) .
    IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
        Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
        ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
    END.
    IF nv_flet_per = 0 Then do:
        ASSIGN nv_flet     = 0
            nv_fletvar  = " ".
    END.
    RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*kridtiya i. 23/07/2015*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    DECI(wdetail.si),
                    uwm130.uom1_v,
                    uwm130.uom2_v,
                    uwm130.uom5_v).
    ASSIGN
        nv_fletvar                  = " "
        nv_fletvar1                 = "     Fleet % = "
        nv_fletvar2                 =  STRING(nv_flet_per)
        SUBSTRING(nv_fletvar,1,30)  = nv_fletvar1
        SUBSTRING(nv_fletvar,31,30) = nv_fletvar2.
    IF nv_flet   = 0  THEN  nv_fletvar  = " ".
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
    RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    DECI(wdetail.si),
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
    /*-------------- load claim ---------------------*/
    nv_cl_per  = 0.
    nv_clmvar  = " ".
    nv_cl_per  = DECI(wdetail.loadclm).
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
                    uwm130.uom5_v).
    /*------------------ dsspc ---------------*/
    ASSIGN nv_dss_per = deci(wdetail.dspc).
    IF  nv_dss_per   <> 0  THEN
        ASSIGN nv_dsspcvar1   = "     Discount Special % = "
        nv_dsspcvar2   =  STRING(nv_dss_per)
        SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
        SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
    /*--------------------------*/
    RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    nv_totsi,
                    nv_uom1_v ,       
                    nv_uom2_v ,       
                    nv_uom5_v ).
    /*------------------ stf ---------------*/
     nv_stf_per = 0.
     nv_stfvar   = " ".
     nv_stf_per     = DECI(wdetail.staff). /*A60-0152*/
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
                    nv_uom5_v ).

    ASSIGN fi_process = "out baseplus " + wdetail.policy.
    DISP fi_process WITH FRAM fr_main.
END.
... END a64-0344...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_campaign_fil_bk c-Win 
PROCEDURE 00-proc_campaign_fil_bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_seat AS INT INIT 0.
DEF VAR nv_garage AS CHAR FORMAT "X(15)" .
DEF VAR nv_carmodel AS CHAR FORMAT "X(10)" . /*A62-0422*/
DO:
    ASSIGN nv_yr = 0    nv_seat = 0  nv_garage = ""
        nv_carmodel = "" . /*A62-0422*/
    /* add a62-0422 */
    IF INDEX(wdetail.model," ") <> 0 THEN DO:
        ASSIGN nv_carmodel   = trim(wdetail.model)  
            wdetail.model = SUBSTR(nv_carmodel,1,INDEX(nv_carmodel," ") - 1 ) .
    END.
    ELSE DO: 
        ASSIGN nv_carmodel = TRIM(wdetail.model) .
    END.
    /* end A62-0422 */
    IF wdetail.covcod = "1" THEN DO:
        IF wdetail.garage = "G" THEN  nv_garage = "ซ่อมอู่ห้าง".
        ELSE nv_garage = "ซ่อมอู่ประกัน" .
    END.
    ELSE nv_garage = "" .
    IF wdetail.caryear <> "" THEN DO:
        ASSIGN nv_yr = INT(YEAR(DATE(wdetail.comdat)))
               nv_yr = (nv_yr - INT(wdetail.caryear)) + 1 .
        IF nv_yr > 10  THEN ASSIGN nv_yr = 99 .
    END.
    FIND LAST brstat.insure USE-INDEX insure03 WHERE 
        brstat.insure.compno      = "TPIS_RE"  AND
        deci(brstat.insure.text4) = DECI(wdetail.volprem) AND
        brstat.insure.text3       = trim(wdetail.prempa) + trim(wdetail.subclass)  NO-LOCK NO-ERROR .
    IF AVAIL brstat.insure THEN DO:
        ASSIGN 
            wdetail.deductpp  =  brstat.insure.lname
            wdetail.deductba  =  brstat.insure.addr1  
            wdetail.deductpa  =  brstat.insure.addr2 
            /* add : A63-0113 */
            wdetail.NO_411     = brstat.insure.addr3  
            wdetail.NO_412     = brstat.insure.addr3  
            wdetail.NO_42      = brstat.insure.addr4 
            wdetail.NO_43      = brstat.insure.telno .
        /* end : A63-0113 */
    END.
    ELSE DO:
        FIND LAST brstat.insure USE-INDEX insure03 WHERE 
            brstat.insure.compno   = "TPIS_RE"  AND
            brstat.insure.text2    = nv_garage  AND 
            brstat.insure.text3    = trim(wdetail.prempa) + trim(wdetail.subclass)  NO-LOCK NO-ERROR .
        IF AVAIL brstat.insure THEN 
            ASSIGN 
            wdetail.deductpp  =  brstat.insure.lname
            wdetail.deductba  =  brstat.insure.addr1  
            wdetail.deductpa  =  brstat.insure.addr2 
            /* add : A63-0113 */
            wdetail.NO_411     = brstat.insure.addr3  
            wdetail.NO_412     = brstat.insure.addr3  
            wdetail.NO_42      = brstat.insure.addr4 
            wdetail.NO_43      = brstat.insure.telno .
        /* end : A63-0113 */
    END.
    RELEASE brstat.insure.
    /*---------------------------------14/07/2020
    /* add : A63-0113 */
    IF DATE(wdetail.comdat) >= 04/01/2020 THEN DO:
        ASSIGN wdetail.prempa = "T" .
    END.
    ELSE DO:
    /* end : A63-0113 */
        ---------------------------------14/07/2020 */
    IF wdetail.covcod = "1" THEN DO:
        IF wdetail.subclass = "210" THEN ASSIGN nv_seat = 5   .
        IF wdetail.subclass = "320" THEN ASSIGN nv_seat = 3   .

        IF wdetail.subclass = "110" THEN DO: /* 110 */
                IF INT(wdetail.engine) <= 2000  THEN DO: 
                     FIND LAST stat.campaign_fil USE-INDEX campfil01     WHERE 
                      stat.campaign_fil.camcod  = trim(wdetail.campens)  and  /* campaign */
                      stat.campaign_fil.sclass  = trim(wdetail.subclass) and  /* class 110 210 320 */
                      stat.campaign_fil.covcod  = trim(wdetail.covcod)   and  /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                      stat.campaign_fil.vehgrp  = "3"                    and  /* group car */
                      stat.campaign_fil.vehuse  = "1"                    and  /* ประเภทการใช้รถ */
                      stat.campaign_fil.garage  = wdetail.garage         and  /* การซ่อม */
                      stat.campaign_fil.engine  <= 2000                  and  /* CC */
                      stat.campaign_fil.maxyea = nv_yr                   AND  /* car year */
                      stat.campaign_fil.simax  = deci(wdetail.si)     /*   and  /* ทุน */
                      stat.campaign_fil.moddes = trim(wdetail.model) */    NO-LOCK NO-ERROR.   /* Model */
                END.
                ELSE DO:
                    FIND LAST stat.campaign_fil USE-INDEX campfil01      WHERE 
                     stat.campaign_fil.camcod  = trim(wdetail.campens)   and   /* campaign */
                     stat.campaign_fil.sclass  = trim(wdetail.subclass)  and   /* class 110 210 320 */
                     stat.campaign_fil.covcod  = trim(wdetail.covcod)    and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                     stat.campaign_fil.vehgrp  = "3"                     and   /* group car */
                     stat.campaign_fil.vehuse  = "1"                     and   /* ประเภทการใช้รถ */
                     stat.campaign_fil.garage  = wdetail.garage          and    /* การซ่อม */
                     stat.campaign_fil.engine  > 2000                    and   /* CC */
                     stat.campaign_fil.maxyea  = nv_yr                   AND   /* car year */
                     stat.campaign_fil.simax   = deci(wdetail.si)     /*   and  /* ทุน */
                     stat.campaign_fil.moddes  = trim(wdetail.model)  */    NO-LOCK NO-ERROR.   /* Model */
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
                        wdetail.seat41     = stat.campaign_fil.seats .
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
            END. /* end 110 */
            ELSE DO:  /* 210,320 */
                 FIND LAST stat.campaign_fil USE-INDEX campfil15  WHERE 
                          stat.campaign_fil.camcod  = trim(wdetail.campens)  and  /* campaign */
                          stat.campaign_fil.sclass  = trim(wdetail.subclass) and  /* class 110 210 320 */
                          stat.campaign_fil.covcod  = trim(wdetail.covcod)   and  /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                          /*stat.campaign_fil.vehgrp  = "3"                    and  /* group car */*/
                          stat.campaign_fil.vehuse  = "1"                    and  /* ประเภทการใช้รถ */
                          stat.campaign_fil.garage  = TRIM(wdetail.garage)   and  /* การซ่อม */
                          stat.campaign_fil.seats   = nv_seat                and  /* ที่นั่ง */
                          /*stat.campaign_fil.tons    = nv_ton                 and*/  /* ton */
                          stat.campaign_fil.maxyea  = nv_yr                  AND  /* car year */
                          stat.campaign_fil.simax   = deci(wdetail.si)      /* and  /* ทุน */
                          stat.campaign_fil.moddes  = trim(wdetail.model)   */ NO-LOCK NO-ERROR.   /* Model */
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
                            wdetail.seat41     = stat.campaign_fil.seats .
                 END.
                 ELSE DO:
                     FIND LAST stat.campaign_fil USE-INDEX campfil15         WHERE 
                          stat.campaign_fil.camcod  = trim(wdetail.campens)  and  /* campaign */
                          stat.campaign_fil.sclass  = trim(wdetail.subclass) and  /* class 110 210 320 */
                          stat.campaign_fil.covcod  = trim(wdetail.covcod)   and  /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                          /*stat.campaign_fil.vehgrp  = "3"                    and  /* group car */*/
                          stat.campaign_fil.vehuse  = "2"                    and  /* ประเภทการใช้รถ */
                          stat.campaign_fil.garage  = TRIM(wdetail.garage)   and  /* การซ่อม */
                          stat.campaign_fil.seats   = nv_seat                and  /* ที่นั่ง */
                          /*stat.campaign_fil.tons    = nv_ton                 and*/  /* ton */
                          stat.campaign_fil.maxyea  = nv_yr                  AND  /* car year */
                          stat.campaign_fil.simax   = deci(wdetail.si)    /*   and  /* ทุน */
                          stat.campaign_fil.moddes  = trim(wdetail.model) */  NO-LOCK NO-ERROR.   /* Model */
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
                                  wdetail.seat41     = stat.campaign_fil.seats .
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
            END. /*end 210 320 */
        END.
        ELSE DO:  /* 2 3 2+ 3+ */
            FIND LAST stat.campaign_fil USE-INDEX campfil15  WHERE 
                       stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                       stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                       stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                       stat.campaign_fil.vehgrp  = "3"                    and   /* group car */
                       stat.campaign_fil.vehuse  = "1"                    and   /* ประเภทการใช้รถ */
                       stat.campaign_fil.garage  = TRIM(wdetail.garage)   and    /* การซ่อม */
                       stat.campaign_fil.maxyea  = nv_yr                  AND   /* car year */
                       stat.campaign_fil.simax   = deci(wdetail.si)       and  /* ทุน */   
                       stat.campaign_fil.moddes  = ""        NO-LOCK NO-ERROR.   /* Model */
               
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
                           wdetail.seat41     = stat.campaign_fil.seats .
                END.
                ELSE DO:
                    FIND LAST stat.campaign_fil USE-INDEX campfil15  WHERE 
                       stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                       stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                       stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                       stat.campaign_fil.vehgrp  = "3"                    and   /* group car */
                       stat.campaign_fil.vehuse  = "1"                    and   /* ประเภทการใช้รถ */
                       stat.campaign_fil.garage  = TRIM(wdetail.garage)   and    /* การซ่อม */
                       stat.campaign_fil.maxyea  = nv_yr                  AND   /* car year */
                       stat.campaign_fil.simax   = deci(wdetail.si)       and   /* ทุน */   
                       stat.campaign_fil.moddes  = ""        NO-LOCK NO-ERROR.   /* Model */
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
                                  wdetail.seat41     = stat.campaign_fil.seats .
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
                            wdetail.baseprem   =  0
                            wdetail.base3      = "0" 
                            wdetail.netprem    = "0"
                            wdetail.seat       = "0"
                            wdetail.seat41     = 0 .
                
                END.
        END. /* end 2 3 2+ 3+ */
        RELEASE stat.campaign_fil .
        OUTPUT TO LinkLogOS_LoadTPIS_RENew.TXT APPEND.
        PUT
            TODAY    FORMAT "99/99/9999"  " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3) SKIP
            "wdetail.policy  :" wdetail.policy     FORMAT "X(20)"     skip    
            "wdetail.campens :" wdetail.campens    FORMAT "X(20)"     skip                                                
            "wdetail.subclass:" wdetail.subclass   FORMAT "X(5)"      skip                                                
            "wdetail.covcod  :" wdetail.covcod     FORMAT "X(5)"      skip                                                
            "wdetail.garage  :" wdetail.garage     FORMAT "X(3)"      skip                                                
            "wdetail.seat    :" wdetail.seat       FORMAT "X(5)"      skip                                                
            "wdetail.si      :" wdetail.si         FORMAT "X(20)"     skip 
            "wdetail.polmaster:" wdetail.polmaster FORMAT "X(20)"     skip  .
        OUTPUT CLOSE.

            /*---------------------------------14/07/2020
    END. /* end a63-0113...*/
        ---------------------------------14/07/2020 */

    wdetail.model = nv_carmodel . /*a62-0422*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest2_bp c-Win 
PROCEDURE 00-proc_chktest2_bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR np_driver AS CHAR FORMAT "x(23)" INIT "".   /*driver policynew */
ASSIGN fi_process    = "Import data TPIS-renew to uwm130..." + wdetail.policy .    /*A56-0262*/
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND            /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND            /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND            /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr             AND 
    sic_bran.uwm130.bchno  = nv_batchno             AND 
    sic_bran.uwm130.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN DO: 
    DO TRANSACTION:
        CREATE sic_bran.uwm130.
        ASSIGN
            sic_bran.uwm130.policy = sic_bran.uwm120.policy
            sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
            sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
            sic_bran.uwm130.itemno = s_itemno
            sic_bran.uwm130.bchyr  = nv_batchyr        /* batch Year */
            sic_bran.uwm130.bchno  = nv_batchno        /* bchno      */
            sic_bran.uwm130.bchcnt = nv_batcnt       /* bchcnt     */
            np_driver = TRIM(sic_bran.uwm130.policy) +
                        STRING(sic_bran.uwm130.rencnt,"99" ) +
                        STRING(sic_bran.uwm130.endcnt,"999") +
                        STRING(sic_bran.uwm130.riskno,"999") +
                        STRING(sic_bran.uwm130.itemno,"999")
            nv_sclass = wdetail.subclass.
        IF nv_uom6_u  =  "A"  THEN DO:
            IF  nv_sclass  =  "320"  OR  nv_sclass  =  "340"  OR nv_sclass  =  "520"  OR  nv_sclass  =  "540"  
                Then  nv_uom6_u  =  "A".         
            Else 
                ASSIGN wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
        END.
        IF CAPS(nv_uom6_u) = "A"  Then
            Assign  nv_uom6_u          = "A"
            nv_othcod                  = "OTH"
            nv_othvar1                 = "     Accessory  = "
            nv_othvar2                 =  STRING(nv_uom6_u)
            SUBSTRING(nv_othvar,1,30)  = nv_othvar1
            SUBSTRING(nv_othvar,31,30) = nv_othvar2.
        ELSE
            ASSIGN  nv_uom6_u              = ""
                nv_othcod                  = ""
                nv_othvar1                 = ""
                nv_othvar2                 = ""
                SUBSTRING(nv_othvar,1,30)  = nv_othvar1
                SUBSTRING(nv_othvar,31,30) = nv_othvar2.
        IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN 
            ASSIGN
            sic_bran.uwm130.uom6_v   = inte(wdetail.si)
            sic_bran.uwm130.uom7_v   = inte(wdetail.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        IF wdetail.covcod = "2"  THEN 
            ASSIGN
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = inte(wdetail.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        IF wdetail.covcod = "3"  THEN 
            ASSIGN 
            /*sic_bran.uwm130.uom1_v =  deci(wdetail.tp1)  
            sic_bran.uwm130.uom2_v   =   deci(wdetail.tp2)  
            sic_bran.uwm130.uom5_v   =   deci(wdetail.tp3) */ 
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = 0
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        IF wdetail.poltyp = "v72" THEN  n_sclass72 = wdetail.subclass.
        ELSE n_sclass72 = wdetail.prempa + wdetail.subclass .
        FIND FIRST stat.clastab_fil Use-index clastab01 Where
            stat.clastab_fil.class   = n_sclass72       And
            stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
        IF avail stat.clastab_fil Then do: 
            Assign 
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
            IF wdetail.prvpol = "" THEN DO:  
                ASSIGN 
                    sic_bran.uwm130.uom1_v     =  stat.clastab_fil.uom1_si
                    sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si
                    sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si
                    nv_uom1_v                  =  sic_bran.uwm130.uom1_v   
                    nv_uom2_v                  =  sic_bran.uwm130.uom2_v
                    nv_uom5_v                  =  sic_bran.uwm130.uom5_v  .
                If  wdetail.garage  =  ""  Then
                    Assign 
                    nv_41      =   stat.clastab_fil.si_41unp
                    nv_42      =   stat.clastab_fil.si_42
                    nv_43      =   stat.clastab_fil.si_43
                    nv_seat41  =   stat.clastab_fil.dri_41 + clastab_fil.pass_41 .  
                Else If  wdetail.garage  =  "G"  Then
                    Assign nv_41       =  stat.clastab_fil.si_41pai
                    nv_42       =  stat.clastab_fil.si_42
                    nv_43       =  stat.clastab_fil.impsi_43
                    nv_seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41. 
            END.
            ELSE ASSIGN 
                sic_bran.uwm130.uom1_v     =  nv_uom1_v 
                sic_bran.uwm130.uom2_v     =  nv_uom2_v 
                sic_bran.uwm130.uom5_v     =  nv_uom5_v .
            IF (n_sclass72 = "210") OR (n_sclass72 = "v210") THEN nv_seat41 = 3.
        END.
        ASSIGN  nv_riskno = 1
            nv_itemno = 1.
        IF wdetail.covcod = "1" Then 
            RUN wgs/wgschsum(INPUT  wdetail.policy, 
                             nv_riskno,
                             nv_itemno).
        ASSIGN  s_recid3  = RECID(sic_bran.uwm130) .
    END.  /* end Do transaction*/
END.
ASSIGN
    nv_covcod  = wdetail.covcod
    nv_makdes  = wdetail.brand
    nv_moddes  = wdetail.model
    nv_newsck  = " ".
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
    sic_bran.uwm301.bchcnt = nv_batcnt     NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
    DO TRANSACTION:
        CREATE sic_bran.uwm301.
        ASSIGN sic_bran.uwm301.policy = sic_bran.uwm120.policy                 
            sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
            sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
            sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
            sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
            sic_bran.uwm301.itemno    = s_itemno
            sic_bran.uwm301.tariff    = wdetail.tariff    
            sic_bran.uwm301.covcod    = nv_covcod
            sic_bran.uwm301.cha_no    = wdetail.chasno
            sic_bran.uwm301.trareg    = nv_uwm301trareg
            sic_bran.uwm301.eng_no    = wdetail.engno
            sic_bran.uwm301.Tons      = nv_tons
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
            /*sic_bran.uwm301.prmtxt    = IF wdetail.poltyp = "v70" THEN wdetail.prmtxt ELSE ""  */
            wdetail.tariff            = sic_bran.uwm301.tariff.
            IF wdetail.poltyp = "v70" AND (wdetail.prmtxt <> "" ) THEN DO: 
                 RUN proc_prmtxt. 
            END.
        IF wdetail.compul = "y" THEN DO:
            sic_bran.uwm301.cert = "".
            IF LENGTH(wdetail.stk) = 11 THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
            IF LENGTH(wdetail.stk) = 13  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
            IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".
            FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
                brStat.Detaitem.serailno = wdetail.stk  NO-LOCK NO-ERROR .
            IF NOT AVAIL brstat.Detaitem THEN DO:     
                CREATE brstat.Detaitem.
                ASSIGN brStat.Detaitem.Policy   = sic_bran.uwm301.Policy
                    brStat.Detaitem.RenCnt   = sic_bran.uwm301.RenCnt
                    brStat.Detaitem.EndCnt   = sic_bran.uwm301.Endcnt
                    brStat.Detaitem.RiskNo   = sic_bran.uwm301.RiskNo
                    brStat.Detaitem.ItemNo   = sic_bran.uwm301.ItemNo
                    brStat.Detaitem.serailno = wdetail.stk.  
            END.
        END.
        /*add driver  A57-0010 */
        IF nv_driver = ""   THEN ASSIGN nv_drivno = 0.
        ELSE DO:
            FOR EACH ws0m009 WHERE ws0m009.policy  = nv_driver NO-LOCK .
                CREATE brstat.mailtxt_fil.
                ASSIGN
                    brstat.mailtxt_fil.policy  = np_driver    
                    brstat.mailtxt_fil.lnumber = INTEGER(ws0m009.lnumber)
                    brstat.mailtxt_fil.ltext   = ws0m009.ltext  
                    brstat.mailtxt_fil.ltext2  = ws0m009.ltext2   
                    brstat.mailtxt_fil.bchyr   = nv_batchyr 
                    brstat.mailtxt_fil.bchno   = nv_batchno 
                    brstat.mailtxt_fil.bchcnt  = nv_batcnt .
                ASSIGN nv_drivno = INTEGER(ws0m009.lnumber).
            END.
        END.    /*add driver  A57-0010 */
        ASSIGN  
            sic_bran.uwm301.bchyr  = nv_batchyr   /* batch Year */
            sic_bran.uwm301.bchno  = nv_batchno   /* bchno      */
            sic_bran.uwm301.bchcnt = nv_batcnt    /* bchcnt     */
            s_recid4               = RECID(sic_bran.uwm301).
        IF wdetail.redbook <> ""  /*AND chkred = YES*/  THEN DO:
            FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE
                stat.maktab_fil.sclass = wdetail.subclass  AND
                stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
            If  avail  stat.maktab_fil  Then 
                ASSIGN
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes */ /*A61-0152*/
                wdetail.cargrp          =  maktab_fil.prmpac
                /*sic_bran.uwm301.Tons    =  stat.maktab.tons*/
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body    =  stat.maktab_fil.body
                sic_bran.uwm301.engine  =  stat.maktab_fil.engine
                nv_engine               =  stat.maktab_fil.engine.
        END.
        ELSE DO:
            Find First stat.maktab_fil Use-index      maktab04          Where
                stat.maktab_fil.makdes   =     nv_makdes                And                  
                index(stat.maktab_fil.moddes,nv_moddes) <> 0            And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
                /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
                stat.maktab_fil.sclass   =     wdetail.subclass        AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) /*AND
                 stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  */   No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                Assign
                wdetail.redbook         =  stat.maktab_fil.modcod
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/ /*A61-0152*/
                wdetail.cargrp          =  stat.maktab_fil.prmpac
                sic_bran.uwm301.Tons    =  stat.maktab.tons
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body    =  stat.maktab_fil.body
                sic_bran.uwm301.engine  =  stat.maktab_fil.engine
                nv_engine               =  stat.maktab_fil.engine.
        END.
        /*IF wdetail.redbook  = ""  THEN RUN proc_maktab.*/
        IF wdetail.redbook  = ""  THEN DO:
            Find LAST stat.maktab_fil Use-index maktab04          Where
                stat.maktab_fil.makdes   =   "isuzu"                     And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0         And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear)  AND
                stat.maktab_fil.engine   >=     Integer(wdetail.cc)      AND
                /*stat.maktab_fil.sclass   =     "****"        AND*/
                (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) /*AND
                 stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)   */   No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                Assign
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/ /*A61-0152*/
                wdetail.cargrp          =  stat.maktab_fil.prmpac
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body    =  stat.maktab_fil.body.
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest3 c-Win 
PROCEDURE 00-proc_chktest3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0344...
DEF VAR np_prem AS DECI INIT 0.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

ASSIGN  nv_tariff = sic_bran.uwm301.tariff             
    nv_class  = wdetail.prempa + wdetail.subclass
    nv_comdat = sic_bran.uwm100.comdat
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse                     
    nv_COMPER = deci(wdetail.comper)            
    nv_comacc = deci(wdetail.comacc)            
    nv_seats  = INTE(wdetail.seat) 
    nv_seat41 = inte(wdetail.seat41)
    nv_ncbyrs  = 0               
    nv_totsi   = 0  
    fi_process    = "Import data TPIS-renew to base..." + wdetail.policy .    /*A56-0262*/
DISP fi_process WITH FRAM fr_main.

IF wdetail.compul = "Y" THEN DO:
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
ELSE DO:
    ASSIGN
        sic_bran.uwm130.uom8_v  =  0    sic_bran.uwm130.uom9_v  =  0    nv_dsspcvar1 = ""           nv_dsspcvar2 = ""               
        nv_dsspcvar  = ""               nv_usecod    = ""               nv_yrcod     = ""           nv_othcod    = ""  
        nv_useprm    = 0                nv_yrprm     = 0                nv_othprm    = 0            nv_usevar    = ""           
        nv_yrvar     = ""               nv_othvar    = ""  
        nv_basecod   = ""               nv_grpcod    = ""           nv_sicod     = ""               nv_engcod    = ""  
        nv_baseprm   = 0                nv_grprm     = 0            nv_siprm     = 0                nv_engprm    = 0  
        nv_basevar   = ""               nv_grpvar    = ""           nv_sivar     = ""               nv_engvar    = "" 
        nv_drivcod  = ""                nv_biacod   = ""            nv_41cod1  = ""                 nv_42cod    = ""
        nv_drivprm  = 0                 nv_biaprm   = 0             nv_41cod2  = ""                 nv_42prm    = 0
        nv_drivvar  = ""                nv_biavar   = ""            nv_411prm  = 0                  nv_42var    = ""
        nv_bipcod   = ""                nv_pdacod   = ""            nv_412prm  = 0                  nv_43cod    = ""
        nv_bipprm   = 0                 nv_pdaprm   = 0             nv_411var  = ""                 nv_43prm    = 0
        nv_bipvar   = ""                nv_pdavar   = ""            nv_412var  = ""                 nv_43var    = ""
        nv_dedod1_cod = ""              nv_dss_per  = 0             nv_flet_per  = 0                nv_usevar3    = "" 
        nv_dedod1_prm = 0               nv_dsspc    = 0             nv_flet      = 0                nv_usecod3    = "" 
        nv_dedod1var  = ""              nv_dsspcvar = ""            nv_fletvar   = ""               nv_usevar4    = "" 
        nv_dedod2_cod = ""              nv_stf_per  = 0             nv_ncbper    = 0                nv_usevar5    = "" 
        nv_dedod2_prm = 0               nv_stf_amt  = 0             nv_ncb       = 0                nv_basecod3   = "" 
        nv_dedod2var  = ""              nv_stfvar   = ""            nv_ncbvar    = ""               nv_baseprm3   = 0  
        nv_dedpd_cod  = ""              nv_cl_per   = 0             nv_campcod   = ""               nv_basevar3   = "" 
        nv_dedpd_prm  = 0               nv_lodclm   = 0             nv_camprem   = 0                nv_basevar4   = "" 
        nv_dedpdvar   = ""              nv_clmvar   = ""            nv_campvar   = ""               nv_basevar5   = "" 
        nv_sicod3     = ""              nv_sivar3   = ""            nv_sivar4    = ""               nv_sivar5     = "" 
        nv_ncbyrs  = 0                  nv_line     = 0              
        nv_totsi   = 0     .    

    IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2" OR 
       wdetail.covcod = "3.1" OR wdetail.covcod = "3.2"  THEN DO:
        ASSIGN nv_baseprm3 = DECI(wdetail.base3).
        RUN proc_baseplus.
    END.
    ELSE DO: 
        RUN proc_base2.
    END.
END.
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
      nv_pdacod   = "" 
      nv_class = SUBSTRING(nv_class,2,3).
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
/* comment by A63-0113...
 /* create by A61-0152*/
IF deci(wdetail.netprem) <> DECI(wdetail.volprem) THEN  DO:
   ASSIGN np_prem         = 0
          nv_gapprm       = deci(wdetail.netprem)
          nv_pdprm        = deci(wdetail.netprem)
          WDETAIL.WARNING = WDETAIL.WARNING +  "เบี้ยในไฟล์ ไม่เท่ากับเบี้ยในแคมเปญหรือใบเตือน"
          wdetail.comment = wdetail.comment + "| gen เข้าระบบได้เบี้ยไม่ตรงกับไฟล์ "
          wdetail.pass    = IF wdetail.pass <> "N" THEN "Y" ELSE "N".
END. 
ELSE DO:
    ASSIGN nv_gapprm = DECI(wdetail.volprem)
           nv_pdprm  = DECI(wdetail.volprem).
END.
.. end a63-0113..*/
/*ELSE DO:
    np_prem = 0.
    IF nv_gapprm <> deci(wdetail.netprem) THEN DO:
        IF DECI(wdetail.netprem) > nv_gapprm THEN DO:
            ASSIGN np_prem   = (deci(wdetail.netprem) - nv_gapprm)
                   nv_gapprm = nv_gapprm + (deci(wdetail.netprem) - nv_gapprm)
                   nv_pdprm  = nv_pdprm  + (deci(wdetail.netprem) - nv_pdprm).
        END.
        IF DECI(wdetail.netprem) < nv_gapprm THEN DO:
            ASSIGN np_prem   = (nv_gapprm - deci(wdetail.netprem))
                   nv_gapprm = nv_gapprm - (nv_gapprm - deci(wdetail.netprem))
                   nv_pdprm  = nv_pdprm  - (nv_pdprm  - deci(wdetail.netprem)).
        END.
      
    END.
END.*/
/* end A61-0152*/

IF wdetail.polmaster <> ""  THEN 
    ASSIGN nv_gapprm = DECI(wdetail.volprem)   /*  A63-0370 */
           nv_pdprm  = DECI(wdetail.volprem).  /*  A63-0370 */

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
        sic_bran.uwm301.mv41seat = inte(wdetail.seat41)
        /* A63-0113 */
        sic_bran.uwm301.tons     = IF sic_bran.uwm301.tons = 0 THEN 0 
                                   ELSE IF sic_bran.uwm301.tons < 100 THEN (sic_bran.uwm301.tons * 1000) 
                                   ELSE sic_bran.uwm301.tons.

IF (SUBSTR(wdetail.subclass,1,1) = "3" OR SUBSTR(wdetail.subclass,1,1) = "4" OR
   SUBSTR(wdetail.subclass,1,1)  = "5" OR TRIM(wdetail.subclass) = "803"     OR
   TRIM(wdetail.subclass)  = "804"     OR TRIM(wdetail.subclass) = "805" )   and
   (wdetail.prempa = "T" OR  wdetail.prempa = "A" ) AND sic_bran.uwm301.tons < 100  THEN DO:

   MESSAGE  wdetail.subclass + "ระบุน้ำหนักรถไม่ถูกต้อง " VIEW-AS ALERT-BOX.
   ASSIGN 
       wdetail.comment = wdetail.comment + "|Class " + wdetail.subclass + " น้ำหนักรถไม่ถูกต้อง " 
       wdetail.pass    = "N".
END.       
 /* end A63-0113 */

/* create by A61-0152*/
IF wdetail.prvpol <> " " THEN DO:
    IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR
       (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" ) THEN DO:     
        RUN WGS\WGSTP132(INPUT S_RECID3,   
                         INPUT S_RECID4). 
    END.
    /* end A61-0152*/
    ELSE DO:
        RUN WGS\WGSTN132(INPUT S_RECID3, 
                         INPUT S_RECID4). 
    END.
    /* a61-0152
    IF np_prem <> 0 THEN DO:
        ASSIGN nv_adjgap = 0    nv_adjpd = 0
               nv_adjgap = np_prem
               nv_adjpd  = np_prem .
        RUN proc_uwd132.
    END.
    end A61-0152*/
END.
ELSE DO:
    IF wdetail.polmaster <> ""  THEN RUN proc_adduwd132.
    ELSE DO:
        IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR
           (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" ) THEN DO:     
            RUN WGS\WGSTP132(INPUT S_RECID3,   
                             INPUT S_RECID4). 
        END.
        /* end A61-0152*/
        ELSE DO:
            RUN WGS\WGSTN132(INPUT S_RECID3, 
                             INPUT S_RECID4). 
        END.
    END.
END.


nv_pdprm0 = 0.
IF nv_drivno <> 0  THEN DO:
     RUN wgw\wgwORPR0 (INPUT  nv_tariff,
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         uwm130.uom1_v,
                         uwm130.uom2_v,
                         uwm130.uom5_v,
                  OUTPUT nv_pdprm0).
     ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
END.
...end A64-0344 ..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest3_old c-Win 
PROCEDURE 00-proc_chktest3_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN  nv_tariff = sic_bran.uwm301.tariff             
    nv_class  = wdetail.prempa + wdetail.subclass
    nv_comdat = sic_bran.uwm100.comdat
    /*nv_engine = DECI(wdetail.engcc)*/
    /*nv_tons   = deci(wdetail2.weight)*/
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse                     
    nv_COMPER = deci(wdetail.comper)               
    nv_comacc = deci(wdetail.comacc)               
    nv_seats  = INTE(wdetail.seat) 
    nv_seat41 = inte(wdetail.seat41)
    /*nv_tons   = DECI(wdetail2.weight) */             
    /*nv_dss_per = 0  */                           
    nv_dsspcvar1   = ""                            
    nv_dsspcvar2   =  ""                           
    nv_dsspcvar    = ""                             
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
    /*nv_ncbper  =   0 */                                 
    /*nv_ncb     =   0*/                                  
    nv_totsi   =  0 
    fi_process    = "Import data TPIS-renew to base..." + wdetail.policy .    /*A56-0262*/
DISP fi_process WITH FRAM fr_main.
IF wdetail.compul = "y" THEN DO:
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
      nv_pdacod   = "" 
      nv_class = SUBSTRING(nv_class,2,3).
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
        WDETAIL2.WARNING  = "เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้"
        wdetail2.comment  = wdetail2.comment + "| gen เข้าระบบได้แต่เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้ "
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
        sic_bran.uwm301.mv41seat = inte(wdetail.seat41).   /*wdetail.seat41.*/
  
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).
                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_insnam c-Win 
PROCEDURE 00-proc_insnam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* A66-0084...
ASSIGN  n_insref     = ""       nv_usrid     = ""       nv_transfer  = NO 
        n_check      = ""       nv_insref    = ""       nv_typ       = "" 
        nv_usrid     = SUBSTRING(USERID(LDBNAME(1)),3,4)  nv_transfer  = YES .  
IF wdetail.insrefno = "" THEN DO:
  FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    /*sicsyac.xmm600.NAME   = TRIM(wdetail.insnam)  AND */
    sicsyac.xmm600.firstname = TRIM(wdetail.firstname) AND
    sicsyac.xmm600.lastname = TRIM(wdetail.lastname) AND 
    sicsyac.xmm600.homebr = TRIM(wdetail.branch)  AND 
    sicsyac.xmm600.clicod = "IN"                  NO-ERROR NO-WAIT.  
  IF NOT AVAILABLE sicsyac.xmm600 THEN DO:
    IF LOCKED sicsyac.xmm600 THEN DO:   
        ASSIGN nv_transfer = NO     n_insref = sicsyac.xmm600.acno.
        RETURN.
    END.
    ELSE DO:
      ASSIGN n_check = "" nv_insref  = "".
      IF TRIM(wdetail.tiname) <> " " THEN DO: 
        IF  R-INDEX(TRIM(wdetail.tiname),"จก.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"จำกัด")           <> 0  OR  
            R-INDEX(TRIM(wdetail.tiname),"(มหาชน)")         <> 0  OR R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR INDEX(TRIM(wdetail.tiname),"บริษัท")            <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"บ.")                <> 0  OR INDEX(TRIM(wdetail.tiname),"บจก.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"หจก.")              <> 0  OR INDEX(TRIM(wdetail.tiname),"หสน.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"บรรษัท")            <> 0  OR INDEX(TRIM(wdetail.tiname),"มูลนิธิ")           <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"ห้าง")              <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วน")      <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
            INDEX(TRIM(wdetail.tiname),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
        ELSE nv_typ = "0s".   /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/
      END.
      ELSE DO:                  /* ---- Check ด้วย name ---- */
        IF  R-INDEX(TRIM(wdetail.tiname),"จก.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"จำกัด")           <> 0  OR  
            R-INDEX(TRIM(wdetail.tiname),"(มหาชน)")         <> 0  OR R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR INDEX(TRIM(wdetail.tiname),"บริษัท")            <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"บ.")                <> 0  OR INDEX(TRIM(wdetail.tiname),"บจก.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"หจก.")              <> 0  OR INDEX(TRIM(wdetail.tiname),"หสน.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"บรรษัท")            <> 0  OR INDEX(TRIM(wdetail.tiname),"มูลนิธิ")           <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"ห้าง")              <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วน")      <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
            INDEX(TRIM(wdetail.tiname),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
        ELSE nv_typ = "0s".  /*0s= บุคคลธรรมดา Cs = นิติบุคคล */
      END.
      RUN proc_insno. 
      IF n_check <> "" THEN DO:
          ASSIGN nv_transfer = NO
              nv_insref   = "".
          RETURN.
      END.
      loop_runningins:  /* Check Insured  */
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
      ELSE DO:
          ASSIGN 
              wdetail.pass    = "N"  
              wdetail.comment = wdetail.comment + "| รหัสลูกค้าเป็นค่าว่างไม่สามารถนำเข้าระบบได้ค่ะ" 
              WDETAIL.OK_GEN  = "N"
              nv_transfer = NO.
      END.
    END.
    n_insref = nv_insref.
  END.
  ELSE DO:  /* กรณีพบ */
    IF sicsyac.xmm600.acno <> "" THEN    
      ASSIGN
        nv_insref               = trim(sicsyac.xmm600.acno) 
        wdetail.insrefno        = nv_insref
        n_insref                = trim(nv_insref) 
        nv_transfer             = NO 
        sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                        /*First Name*/
        sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
        sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
        sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*//*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)       /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)       /*Address line 3*/
        sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4) 
        sicsyac.xmm600.postcd   = TRIM(wdetail.post)        /*Postal Code*/
        sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
        sicsyac.xmm600.opened   = TODAY                     
        sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid 
        sicsyac.xmm600.dtyp20   = ""   
        sicsyac.xmm600.dval20   = "" 
        /* add by : Ranu I. A66-0084 */ /* vat ชมพู */
        sicsyac.xmm600.nbr_insure = ""
        sicsyac.xmm600.nntitle    = ""
        sicsyac.xmm600.nfirstName = ""
        sicsyac.xmm600.nlastname  = ""
        sicsyac.xmm600.nicno      = ""
        sicsyac.xmm600.nphone   = ""
        sicsyac.xmm600.naddr1   = ""
        sicsyac.xmm600.naddr2   = ""
        sicsyac.xmm600.naddr3   = ""
        sicsyac.xmm600.naddr4   = ""
        sicsyac.xmm600.npost    = ""
        sicsyac.xmm600.anlyc1   = "" .
        /*....end A66-0084...*/
       /* comment by : Ranu I. A66-0084 .....
        sicsyac.xmm600.nphone   = if trim(wdetail.cuts_typ) = "J" then TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) else ""
        sicsyac.xmm600.naddr1   = if trim(wdetail.cuts_typ) = "J" then trim(wdetail.address) else ""
        sicsyac.xmm600.naddr2   = if trim(wdetail.cuts_typ) = "J" then trim(wdetail.tambon)  else ""
        sicsyac.xmm600.naddr3   = if trim(wdetail.cuts_typ) = "J" then trim(wdetail.amper)   else ""
        sicsyac.xmm600.naddr4   = if trim(wdetail.cuts_typ) = "J" then trim(wdetail.country) else ""
        sicsyac.xmm600.anlyc1   = if trim(wdetail.cuts_typ) = "J" then TRIM(wdetail.ICNO)    else "" .
        ....end A66-0084...*/
  END.
END.
ELSE DO:
  FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
      sicsyac.xmm600.acno   = TRIM(wdetail.insrefno)  NO-ERROR NO-WAIT.  
  IF AVAILABLE sicsyac.xmm600 THEN 
    ASSIGN
      nv_insref               = trim(sicsyac.xmm600.acno) 
      n_insref                = trim(nv_insref) 
      wdetail.insrefno        = nv_insref
      nv_transfer             = NO 
      sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
      sicsyac.xmm600.fname    = ""                        /*First Name*/
      sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
      sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
      sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*//*--Crate by Amparat C. A51-0071--*/
      sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       /*Address line 1*/
      sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)       /*Address line 2*/
      sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)       /*Address line 3*/
      sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4)  
      sicsyac.xmm600.postcd   = TRIM(wdetail.post)        /*Postal Code*/
      sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
      sicsyac.xmm600.opened   = TODAY                     
      sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
      sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
      sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
      sicsyac.xmm600.usrid    = nv_usrid 
      sicsyac.xmm600.dtyp20   = ""   
      sicsyac.xmm600.dval20   = ""   
      /* add by : Ranu I. A66-0084 *//* vat ชมพู */
      sicsyac.xmm600.nbr_insure = ""
      sicsyac.xmm600.nntitle    = ""
      sicsyac.xmm600.nfirstName = ""
      sicsyac.xmm600.nlastname  = ""
      sicsyac.xmm600.nicno      = ""
      sicsyac.xmm600.nphone   = ""
      sicsyac.xmm600.naddr1   = ""
      sicsyac.xmm600.naddr2   = ""
      sicsyac.xmm600.naddr3   = ""
      sicsyac.xmm600.naddr4   = ""
      sicsyac.xmm600.npost    = ""
      sicsyac.xmm600.anlyc1   = "" .
      /*....end A66-0084...*/
      /* comment by : Ranu I. A66-0084 .....
      sicsyac.xmm600.nphone   = if trim(wdetail.cuts_typ) = "J" then TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) else ""
      sicsyac.xmm600.naddr1   = if trim(wdetail.cuts_typ) = "J" then trim(wdetail.address) else ""
      sicsyac.xmm600.naddr2   = if trim(wdetail.cuts_typ) = "J" then trim(wdetail.tambon)  else ""
      sicsyac.xmm600.naddr3   = if trim(wdetail.cuts_typ) = "J" then trim(wdetail.amper)   else ""
      sicsyac.xmm600.naddr4   = if trim(wdetail.cuts_typ) = "J" then trim(wdetail.country) else ""
      sicsyac.xmm600.anlyc1   = if trim(wdetail.cuts_typ) = "J" then TRIM(wdetail.ICNO)    else "".
      ...end A66-0084....*/
END.
IF nv_transfer = YES THEN DO:
  IF nv_insref  <> "" THEN 
    ASSIGN
      wdetail.insrefno        = nv_insref
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
      sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
      sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       /*Address line 1*/
      sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)       /*Address line 2*/
      sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)       /*Address line 3*/
      sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4)       /*Address line 4*/
      sicsyac.xmm600.postcd   = TRIM(wdetail.post)        /*Postal Code*/
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
      sicsyac.xmm600.anlyc5   = ""                      /*Analysis Code 5*/
      sicsyac.xmm600.dtyp20   = ""     
      sicsyac.xmm600.dval20   = "" 
      /* add by : Ranu I. A66-0084 */
      /* vat ชมพู */
      sicsyac.xmm600.nbr_insure = ""
      sicsyac.xmm600.nntitle    = ""
      sicsyac.xmm600.nfirstName = ""
      sicsyac.xmm600.nlastname  = ""
      sicsyac.xmm600.nicno      = ""
      sicsyac.xmm600.nphone   = ""
      sicsyac.xmm600.naddr1   = ""
      sicsyac.xmm600.naddr2   = ""
      sicsyac.xmm600.naddr3   = ""
      sicsyac.xmm600.naddr4   = ""
      sicsyac.xmm600.npost    = ""
      sicsyac.xmm600.anlyc1   = "" .
      /*....end A66-0084...*/
      /* comment by : Ranu I. A66-0084 .....
      sicsyac.xmm600.nphone   = if TRIM( wdetail.cuts_typ) = "J" then TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) else ""
      sicsyac.xmm600.naddr1   = if TRIM( wdetail.cuts_typ) = "J" then trim(wdetail.address) else ""
      sicsyac.xmm600.naddr2   = if TRIM( wdetail.cuts_typ) = "J" then trim(wdetail.tambon)  else ""
      sicsyac.xmm600.naddr3   = if TRIM( wdetail.cuts_typ) = "J" then trim(wdetail.amper)   else ""
      sicsyac.xmm600.naddr4   = if TRIM( wdetail.cuts_typ) = "J" then trim(wdetail.country) else ""
      sicsyac.xmm600.anlyc1   = if TRIM( wdetail.cuts_typ) = "J" then TRIM(wdetail.ICNO)    else "" .
      ....end A66-0084...*/
END.
IF sicsyac.xmm600.acno <> ""  THEN DO:
  ASSIGN nv_insref = sicsyac.xmm600.acno.
  nv_transfer = YES.
  FIND sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
  IF NOT AVAILABLE sicsyac.xtm600 THEN DO:
      IF LOCKED sicsyac.xtm600 THEN DO:
          nv_transfer = NO.
          RETURN.
      END.
      ELSE DO:
          IF nv_insref <> "" THEN  CREATE sicsyac.xtm600.
      END.
  END.
  IF nv_transfer = YES THEN DO:
      IF nv_insref <> "" THEN  
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
          sicsyac.xtm600.fname   = ""   .                   /*First Name*/
  END.
END.
RUN proc_insnam2.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
RETURN.
HIDE MESSAGE NO-PAUSE. 
...END A66-0084...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pro_chkfile c-Win 
PROCEDURE 00-pro_chkfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: comment by : A66-0252      
------------------------------------------------------------------------------*/
/*DEF VAR n_pol       AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_recnt     AS INT INIT 0.
DEF VAR n_encnt     AS INT INIT 0.
DEF VAR n_rev       AS INT INIT 0. 
DEF VAR n_revday    AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_cc        AS CHAR FORMAT "x(3)" INIT "".    /*a61-0152*/
DEF VAR n_model     AS CHAR FORMAT "x(2)" INIT "".    /*a61-0152*/
DEF VAR n_model1    AS CHAR FORMAT "x(5)" INIT "".    /*a61-0152*/
DEF VAR np_garage    AS CHAR FORMAT "x(25)" INIT "" .  /*A66-0084*/

ASSIGN fi_process   = "Check data & Match STK TPIS-renew....".    /*A56-0262*/
DISP fi_process WITH FRAM fr_main.
FOR EACH wdetail2.
    IF TRIM(wdetail2.tpis_no) = ""  THEN DELETE wdetail2.
    ELSE DO:
        ASSIGN n_cc = ""     n_model = ""   
               np_garage = ""   /*A66-0084*/
               np_garage = IF trim(wdetail2.garage) = "ซ่อมห้าง" THEN "ซ่อมอู่ห้าง" ELSE "ซ่อมอู่ประกัน"  /*A66-0084*/ 
               wdetail2.np_f18line4 = wdetail2.garage . /*A62-0422*/

        RUN proc_cutpol72.
        IF TRIM(wdetail2.License) <> "" THEN DO:
                IF R-INDEX(wdetail2.License," ") <> 0 THEN
                    ASSIGN wdetail2.License = trim(SUBSTR(trim(wdetail2.License),1,INDEX(trim(wdetail2.License)," "))) + " " +
                                             trim(SUBSTR(trim(wdetail2.License),INDEX(trim(wdetail2.License)," "))).
        END.
        IF TRIM(wdetail2.regis_CL) <> "" THEN DO:
           FIND FIRST brstat.insure USE-INDEX Insure03   WHERE 
                brstat.insure.compno = "999"    AND 
                brstat.insure.fname  = trim(wdetail2.regis_CL)  NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN DO:
                ASSIGN wdetail2.regis_CL = trim(Insure.LName).
            END.
        END.
        ELSE ASSIGN  wdetail2.regis_CL =  "".
        /* comment by Ranu : a63-0101...
        ASSIGN fi_process   = "Check Data V72 & Match Sticker.........".    /*A56-0262*/
                DISP fi_process WITH FRAM fr_main. 
        IF wdetail2.com_no <> "" THEN DO:
            FIND FIRST brstat.tlt USE-INDEX tlt04 WHERE brstat.tlt.datesent      =  ?                       AND
                                                        brstat.tlt.nor_noti_tlt  = TRIM(wdetail2.com_no)    AND 
                                                        brstat.tlt.ins_name      =  ""                      AND
                                                        brstat.tlt.genusr        =  "til72"   NO-ERROR NO-WAIT.             
                IF AVAIL brstat.tlt THEN DO:
                    IF brstat.tlt.releas = "NO" THEN
                        ASSIGN wdetail2.stkno = brstat.tlt.cha_no
                               wdetail2.docno = brstat.tlt.safe2.  /****Add by Nontamas H. [A62-0329] Date 08/07/2019***/
                    ELSE ASSIGN wdetail2.stkno = "เลขที่สติ๊กเกอร์นี้ถูกใช้งานแล้ว".
                END.
                ELSE ASSIGN wdetail2.stkno = ""
                           wdetail2.docno = "". /****Add by Nontamas H. [A62-0329] Date 08/07/2019***/
        END.
        ... end A63-0101 ...*/
        ASSIGN fi_process   = "Check data Old Policy............".    /*A56-0262*/
        DISP fi_process WITH FRAM fr_main.
        /*IF trim(wdetail2.chasno) <> "" AND INDEX(wdetail2.typ_work,"V") <> 0  THEN DO:*/  /*A61-0152*/
        IF trim(wdetail2.chasno) <> "" AND INDEX(wdetail2.typ_work,"V") <> 0 AND 
           index(wdetail2.deler,"Refinance") = 0  THEN DO:  /*A61-0152*/
            FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail2.chasno)) AND 
                                                             sicuw.uwm301.tariff = "X" NO-LOCK  NO-ERROR NO-WAIT.
                 IF AVAIL sicuw.uwm301 THEN DO:
                     ASSIGN  n_pol   = ""
                             n_recnt = 0
                             n_encnt = 0
                             n_pol   = sicuw.uwm301.policy 
                             n_recnt = sicuw.uwm301.rencnt 
                             n_encnt = sicuw.uwm301.endcnt .
                     FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                         sicuw.uwm100.policy = n_pol     AND
                         sicuw.uwm100.rencnt = n_recnt   AND
                         sicuw.uwm100.endcnt = n_encnt  NO-LOCK NO-ERROR .
                     IF AVAIL sicuw.uwm100 THEN
                         IF sicuw.uwm100.renpol = "" THEN
                            ASSIGN wdetail2.prvpol = sicuw.uwm100.policy.
                         ELSE 
                             ASSIGN wdetail2.prvpol = sicuw.uwm100.policy + " ต่ออายุแล้ว ".
                     ELSE
                         ASSIGN wdetail2.prvpol = "".
                 END.
                 ELSE DO: 
                     ASSIGN  wdetail2.prvpol = "".
                 END.
        END.
        ELSE DO:
            ASSIGN  wdetail2.prvpol = "".
        END.

        IF TRIM(wdetail2.prvpol) <> ""  THEN  DO:
            IF substr(TRIM(wdetail2.prvpol),1,1) = "D" THEN ASSIGN wdetail2.branch = substr(TRIM(wdetail2.prvpol),2,1).
            ELSE ASSIGN wdetail2.branch = substr(TRIM(wdetail2.prvpol),1,2).
        END.
        ELSE DO:
            /* add by : A65-0177 */
            FIND FIRST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.compno = "TPIS"             AND    
              stat.insure.fname  = wdetail2.deler     AND
              stat.insure.lname  = wdetail2.showroom  NO-ERROR NO-WAIT.
            IF AVAIL stat.insure THEN DO: 
                ASSIGN wdetail2.branch  = stat.insure.branch  . 
            END.
            ELSE DO: 
                ASSIGN wdetail2.branch  = "M" . 
            END.
            /* end : A65-0177 */
        END.
        /* ---create by A61-0152---*/
        IF trim(wdetail2.cust_type) = "J" AND TRIM(wdetail2.icno) <> "" THEN DO:
            IF LENGTH(TRIM(wdetail2.icno)) < 13 THEN ASSIGN wdetail2.icno = "0" + TRIM(wdetail2.icno) .
        END.

        IF trim(wdetail2.cover) = "2+" THEN ASSIGN wdetail2.cover = "2.2" .
        ELSE IF trim(wdetail2.cover) = "3+" THEN ASSIGN wdetail2.cover = "3.2" .
        ELSE ASSIGN wdetail2.cover = TRIM(wdetail2.cover).

        IF INT(wdetail2.cc) = 0 AND wdetail2.chasno <> "" THEN DO:
            n_cc = trim(SUBSTR(wdetail2.chasno,7,2)).
            IF n_cc = "85"  THEN wdetail2.cc = "3000".
            ELSE IF n_cc = "86" THEN wdetail2.cc = "2500".
            ELSE wdetail2.cc = "1900" .
        END.

        IF trim(wdetail2.chasno) <> ""  THEN DO:
            n_model = trim(SUBSTR(wdetail2.chasno,9,1)) . 
            n_model1 = trim(SUBSTR(wdetail2.chasno,7,5)) .  /*A62-0110*/
            IF n_model = "G" THEN wdetail2.model = "MU-X".
            /*ELSE wdetail2.model = "D-MAX" .*/ /*A61-0416*/
            ELSE IF wdetail2.brand = "ISUZU"  THEN  DO:
                IF n_model1 = "85HBT" THEN wdetail2.model = "MU-7". /*A62-0110*/
                ELSE IF TRIM(wdetail2.bus_typ) = "CV" THEN wdetail2.model = wdetail2.model. 
                ELSE  wdetail2.model = "D-MAX" . /*A61-0416*/  
            END.
            ELSE wdetail2.model = trim(wdetail2.model) . /*A61-0416*/
        END.
        IF wdetail2.CLASS = "" THEN DO:
            IF DECI(wdetail2.com_netprem) = 600 THEN ASSIGN wdetail2.CLASS = "110" .
            ELSE wdetail2.CLASS = "" .
        END.
        IF trim(wdetail2.prvpol) <> "" THEN DO: /* มีกรมธรรม์เดิม */
            ASSIGN wdetail2.producer = TRIM(fi_producer)
                   re_class   = ""      re_covcod  = ""
                   re_si      = ""      re_baseprm = 0 .

            IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
            IF  CONNECTED("sic_exp") THEN DO:
                ASSIGN re_producerexp = ""   /*A63-00472*/ 
                       re_dealerexp   = "".  /*A63-00472*/
                RUN wgw\wgwchktil (INPUT-OUTPUT  wdetail2.prvpol,               
                                   INPUT-OUTPUT  wdetail2.branch, 
                                   INPUT-OUTPUT  re_producerexp,
                                   INPUT-OUTPUT  re_dealerexp,
                                   INPUT-OUTPUT  re_class ,
                                   INPUT-OUTPUT  re_covcod,
                                   INPUT-OUTPUT  re_si     ,                          
                                   INPUT-OUTPUT  re_baseprm,
                                   input-output  re_expdat , /*A62-0422*/

                /*A63-00472*/
                IF wdetail2.prvpol <> "" AND re_producerexp = "" THEN ASSIGN  wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |ไม่พบรหัส Producer ที่ระบบ Expiry".
                IF wdetail2.prvpol <> "" AND re_dealerexp   = "" THEN ASSIGN  wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |ไม่พบรหัส Dealer ที่ระบบ Expiry".
                IF wdetail2.prvpol <> "" AND re_producerexp <> "" AND re_dealerexp <> ""  THEN DO:
                    IF trim(re_producerexp) = "B3MF101980"  THEN DO:
                        FIND LAST stat.insure USE-INDEX insure01 WHERE 
                            stat.insure.compno = "TPIS"             AND   
                            stat.insure.insno =  re_dealerexp  NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL stat.insure THEN  ASSIGN wdetail2.branch =   trim(stat.Insure.Branch).
                    END.
                END.
                /*A63-00472*/
                IF re_class = "" AND re_covcod = "" AND re_si = "" AND re_baseprm = 0 THEN ASSIGN  wdetail2.np_f18line6 = "ไม่มีขอ้มูลที่ระบบ Expiry".
                ELSE DO:
                    IF INDEX(re_class,wdetail2.CLASS) <> 0 THEN 
                        ASSIGN wdetail2.np_f18line6 = "Class ตรง" 
                               wdetail2.CLASS        = re_class .
                    ELSE ASSIGN wdetail2.np_f18line6 = "Class ไม่ตรง".
                    
                    IF trim(wdetail2.cover) = TRIM(re_covcod)  THEN ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |Cover ตรง".
                    ELSE ASSIGN wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |Cover ไม่ตรง".
                    
                    IF DECI(wdetail2.si) = deci(re_si)  THEN ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |SI ตรง".
                    ELSE ASSIGN wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |SI ไม่ตรง".
                    
                    IF DECI(wdetail2.pol_netprem) = re_baseprm  THEN ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |เบี้ยตรง".
                    ELSE ASSIGN wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |เบี้ยไม่ตรง " + wdetail2.pol_netprem .
                    /* create by : A62-0422 */ 
                    IF YEAR(date(re_expdat)) < YEAR(TODAY) THEN DO:
                        ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |กรมธรรม์ขาดต่ออายุมากกว่า 3 วัน  Exp:" + re_expdat .
                    END.
                    ELSE DO:
                        IF MONTH(date(re_expdat)) <= MONTH(date(wdetail2.pol_comm_date)) THEN DO:
                            IF MONTH(date(re_expdat)) = MONTH(date(wdetail2.pol_comm_date)) THEN DO:
                                IF DAY(date(re_expdat)) < (DAY(date(wdetail2.pol_comm_date)) - 3 ) THEN DO:
                                   ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |กรมธรรม์ขาดต่ออายุมากกว่า 3 วัน  Exp:" + re_expdat .
                                END.
                            END.
                            ELSE DO:
                                ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |กรมธรรม์ขาดต่ออายุมากกว่า 3 วัน  Exp:" + re_expdat .
                            END.
                        END.
                    END.
                    /* end A62-0422*/
                END.
                ASSIGN  re_class   = ""      re_covcod  = ""        re_si      = ""      re_baseprm = 0 .
            END.
        END.
        ELSE DO: /* ไม่มีกรมธรรม์เดิม */
            IF index(wdetail2.deler,"Refinance") <> 0 THEN ASSIGN wdetail2.producer = TRIM(fi_producerre).
            ELSE IF trim(wdetail2.typ_work) = "C" THEN ASSIGN wdetail2.producer = TRIM(fi_producer72).
            ELSE ASSIGN wdetail2.producer = TRIM(fi_producer).

            IF DECI(wdetail2.pol_netprem) <> 0 AND TRIM(wdetail2.cover) <> "2"  THEN DO:
                /* A66-0084 */
                IF TRIM(wdetail2.cover) = "1" THEN DO:
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = trim(fi_model)           AND 
                           index(brstat.insure.Text3,wdetail2.class) <> 0       AND  
                           brstat.insure.vatcode     = TRIM(wdetail2.cover)     AND
                           deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) AND 
                           trim(brstat.insure.Text2) = trim(np_garage)   NO-LOCK NO-ERROR.
                END.
                ELSE DO: /* end A66-0084*/
                  FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                         brstat.insure.compno      = trim(fi_model)            AND 
                         index(brstat.insure.Text3,wdetail2.class) <> 0        AND  
                         brstat.insure.vatcode     = TRIM(wdetail2.cover)     AND
                         deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) NO-LOCK NO-ERROR.
                END.
                 IF AVAIL brstat.insure THEN DO:
                     ASSIGN wdetail2.CLASS       = TRIM(brstat.insure.Text3) 
                            wdetail2.campaign    = trim(brstat.insure.Text1)
                            wdetail2.np_f18line4 = TRIM(brstat.insure.Text2)
                            wdetail2.np_f18line6 = "เบี้ยตรงกับแคมเปญ"
                            wdetail2.product     = IF TRIM(brstat.insure.icaddr2) <> "" THEN TRIM(brstat.insure.icaddr2) + "_" + trim(brstat.insure.Text1) 
                                                   ELSE trim(brstat.insure.Text1). /*A65-0177*/
                 END.
                 ELSE ASSIGN wdetail2.np_f18line6 = "เบี้ยไม่ตรงกับแคมเปญ " + wdetail2.pol_netprem .
            END.
            IF TRIM(wdetail2.cover) = "2"  THEN DO:
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = trim(fi_model)            AND 
                           index(brstat.insure.Text3,wdetail2.class) <> 0        AND  
                           brstat.insure.vatcode     = TRIM(wdetail2.cover)      AND
                           deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) NO-LOCK NO-ERROR.
                 IF AVAIL brstat.insure THEN DO:
                     ASSIGN wdetail2.CLASS       = TRIM(brstat.insure.Text3) 
                            wdetail2.np_f18line4 = trim(brstat.insure.Text1) 
                            wdetail2.np_f18line6 = "เบี้ยตรงกับแคมเปญ".
                 END.
                 ELSE ASSIGN wdetail2.np_f18line6 = "เบี้ยไม่ตรงกับแคมเปญ " + wdetail2.pol_netprem .
            END.
        END.

        IF wdetail2.np_f18line6 = "ไม่มีขอ้มูลที่ระบบ Expiry" THEN DO:   /* ไม่มีที่ใบเตือน */
            IF index(wdetail2.deler,"Refinance") <> 0 THEN ASSIGN wdetail2.producer = TRIM(fi_producerre).
            ELSE IF trim(wdetail2.typ_work) = "C" THEN ASSIGN wdetail2.producer = TRIM(fi_producer72).
            ELSE ASSIGN wdetail2.producer = TRIM(fi_producer).

            IF DECI(wdetail2.pol_netprem) <> 0 AND TRIM(wdetail2.cover) <> "2"  THEN DO:
                 /* A66-0084 */
                IF TRIM(wdetail2.cover) = "1" THEN DO:
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = trim(fi_model)           AND 
                           index(brstat.insure.Text3,wdetail2.class) <> 0       AND  
                           brstat.insure.vatcode     = TRIM(wdetail2.cover)     AND
                           deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) AND 
                           trim(brstat.insure.Text2) = trim(np_garage)   NO-LOCK NO-ERROR.
                END.
                ELSE DO: /* end A66-0084*/
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = trim(fi_model)            AND 
                           index(brstat.insure.Text3,wdetail2.class) <> 0        AND  
                           brstat.insure.vatcode     = TRIM(wdetail2.cover)     AND
                           deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) NO-LOCK NO-ERROR.
                END.
                 IF AVAIL brstat.insure THEN DO:
                     ASSIGN wdetail2.CLASS       = TRIM(brstat.insure.Text3) 
                            wdetail2.campaign    = trim(brstat.insure.Text1)
                            wdetail2.np_f18line4 = TRIM(brstat.insure.Text2)
                            wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |เบี้ยตรงกับแคมเปญ " 
                            wdetail2.product     = IF TRIM(brstat.insure.icaddr2) <> "" THEN TRIM(brstat.insure.icaddr2) + "_" + trim(brstat.insure.Text1) 
                                                   ELSE trim(brstat.insure.Text1). /*A65-0177*/
                 END.
                 ELSE ASSIGN wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |เบี้ยไม่ตรงกับแคมเปญ " + wdetail2.pol_netprem .
            END.
            IF TRIM(wdetail2.cover) = "2"  THEN DO:
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = trim(fi_model)            AND 
                           index(brstat.insure.Text3,wdetail2.class) <> 0        AND  
                           brstat.insure.vatcode     = TRIM(wdetail2.cover)     AND
                           deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) NO-LOCK NO-ERROR.
                 IF AVAIL brstat.insure THEN DO:
                     ASSIGN wdetail2.CLASS       = TRIM(brstat.insure.Text3) 
                            wdetail2.np_f18line4 = trim(brstat.insure.Text1) 
                            wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |เบี้ยตรงกับแคมเปญ ".
                 END.
                 ELSE ASSIGN wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |เบี้ยไม่ตรงกับแคมเปญ " + wdetail2.pol_netprem  .
            END.
        END.
        /* ---end : A61-0152---*/         
        IF TRIM(wdetail2.financename) = "Cash" THEN ASSIGN wdetail2.financename = " ". 
        IF wdetail2.financename <> " "  THEN DO:
            FIND FIRST stat.insure USE-INDEX insure01 WHERE stat.insure.compno = "TPIS-LEAS"        AND 
                                     stat.insure.fname = wdetail2.financename   OR
                                     stat.insure.lname = wdetail2.financename   NO-LOCK NO-ERROR . 
             IF AVAIL stat.insure THEN
                 ASSIGN wdetail2.financename = stat.insure.addr1 + stat.insure.addr2.
             ELSE 
                 ASSIGN wdetail2.financename = "error : " + wdetail2.financename.
        END.
       /*-- create by A61-0152 --*/
        ASSIGN wdetail2.np_f18line1 = nv_memo1
               wdetail2.np_f18line2 = nv_memo2
               wdetail2.np_f18line3 = nv_meno3.
        /*-- end A61-0152---*/
    END.
END.

IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.

ASSIGN fi_process   = "Check data complete ......".    /*A56-0262*/
DISP fi_process WITH FRAM fr_main.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pro_createpol c-Win 
PROCEDURE 00-pro_createpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A66-0252      
------------------------------------------------------------------------------*/
/*def var nv_row      as int    init 0.
If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_cnt  =  0  nv_row  =  0.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "จังหวัด "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "สาขา   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "ภูมิภาค   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "สาขากรมธรรม์   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Ins. Year type "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Business type  "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "TAS received by"  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "Ins company    "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "Insurance ref no."  '"' SKIP.                             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "TPIS Contract No."  '"' SKIP.                             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "Title name     " '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "customer name  " '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "customer lastname"  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Customer type  " '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "Director Name  " '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "ID number " '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "House no. " '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Building  " '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "Village name/no. "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Soi       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Road      "  '"' SKIP.                                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Sub-district   "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "District  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Province  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Postcode  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "Brand     "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Car model "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Insurance Code "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Model Year "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Usage Type "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Colour     "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Car Weight "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Year       "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "Engine No. "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "Chassis No."  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "Accessories (for CV) "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "Accessories amount"  '"' SKIP.                                           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "License No.       "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "Registered Car License "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "Campaign        "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "Type of work    "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "Insurance amount"  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "Insurance Date ( Voluntary )   "  '"' SKIP.                                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "Expiry Date ( Voluntary)       "  '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "Last Policy No. (Voluntary)    "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "Branch          "  '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "New policy no   "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "Insurance Type  "  '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Net premium (Voluntary)   "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "Gross premium (Voluntary) "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "Stamp  "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "VAT    "  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "Stamp HO  "  '"' SKIP.    /*A61-0152*/       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "VAT HO   "  '"' SKIP.     /*A61-0152*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "WHT    "  '"' SKIP.                                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "Compulsory No. "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "เลขใบแจ้งหนั้. "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "Sticker No.    "  '"' SKIP.                                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "Insurance Date ( Compulsory )  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "Expiry Date ( Compulsory)  "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "Net premium (Compulsory)   "  '"' SKIP.            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "Gross premium (Compulsory) "  '"' SKIP.            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "Stamp "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "VAT   "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "WHT   "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "Dealer"  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "Showroom "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "Payment Type "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "Beneficiery  "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "Mailing House no. "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "Mailing  Building "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "Mailing  Village name/no.      "  '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "Mailing Soi    "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "Mailing  Road  "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' "Mailing  Sub-district "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "Mailing  District "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "Mailing Province  "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "Mailing Postcode  "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' "Policy no. to customer date    "  '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' "Insurer Stamp Date"  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' "Remark            "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' "Occupation code   "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' "Register NO. "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' "f18line1 "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' "f18line2 "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' "f18line3 "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' "f18line4 "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' "f18line5 "  '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' "f18line6 "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"' "f18line7 "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"' "f18line8 "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"' "campaign_ov  "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"' "Producer code "  '"' SKIP. /*A65-0177*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"' "Product   "  '"' SKIP. /*A65-0177*/
FOR EACH wdetail2.                           
  IF TRIM(wdetail2.tpis_no) = ""  THEN DELETE wdetail2. ELSE RUN pro_chk_pol.
END.
FOR EACH wdetail2 BREAK BY wdetail2.delerco.
  ASSIGN nv_row  =  nv_row  + 1   nv_cnt  =  nv_cnt  + 1.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' Wdetail2.bran_name    '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' Wdetail2.bran_name2   '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' Wdetail2.region       '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdetail2.branch       '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' Wdetail2.ins_ytyp    '"' SKIP.  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' wdetail2.bus_typ     '"' SKIP.  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' wdetail2.TASreceived '"' SKIP.  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' wdetail2.InsCompany  '"' SKIP.  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' wdetail2.Insurancerefno   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' wdetail2.tpis_no          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' wdetail2.ntitle      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' wdetail2.insnam      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' wdetail2.NAME2       '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' wdetail2.cust_type   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' wdetail2.nDirec      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' wdetail2.ICNO        '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' wdetail2.address     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' wdetail2.build       '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' wdetail2.mu          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' wdetail2.soi         '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' wdetail2.road        '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' wdetail2.tambon      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' wdetail2.amper       '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' wdetail2.country     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' wdetail2.post        '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' wdetail2.brand       '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' wdetail2.model       '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' wdetail2.class       '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' wdetail2.md_year     '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' wdetail2.Usage FORMAT "x(50)"  '"' SKIP.  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' wdetail2.coulor      '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' wdetail2.cc          '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' wdetail2.regis_year  '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' wdetail2.engno       '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' wdetail2.chasno      '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' Wdetail2.Acc_CV      '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' Wdetail2.Acc_amount  '"' SKIP.            
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' wdetail2.License     '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' wdetail2.regis_CL    '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' wdetail2.campaign    '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' wdetail2.typ_work    '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' deci(wdetail2.si) FORMAT ">>,>>>,>>9.99"    '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' wdetail2.prvpol           '"' SKIP.                                      
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' wdetail2.branch           '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' wdetail2.policy           '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' wdetail2.cover            '"' SKIP.                                          
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' deci(wdetail2.pol_netprem)'"' SKIP.                                          
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' deci(wdetail2.pol_gprem)  '"' SKIP.                                          
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' deci(wdetail2.pol_stamp)  '"' SKIP.                                          
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' deci(wdetail2.pol_vat)    '"' SKIP.                                          
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' deci(wdetail2.pol_stamp_ho)  '"' SKIP.  /*A61-0152*/                                   
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' deci(wdetail2.pol_vat_ho)    '"' SKIP.  /*A61-0152*/ 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' deci(wdetail2.pol_wht)    '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' wdetail2.com_no           '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' wdetail2.docno            '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' wdetail2.stkno            '"' SKIP.                                 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' DATE(wdetail2.com_comm_date) FORMAT "99/99/9999" '"' SKIP.         
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999" '"' SKIP.         
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' deci(wdetail2.com_netprem)'"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' deci(wdetail2.com_gprem)  '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' deci(wdetail2.com_stamp)  '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' deci(wdetail2.com_vat)    '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' deci(wdetail2.com_wht)    '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' wdetail2.deler            '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' wdetail2.showroom         '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' wdetail2.typepay          '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' wdetail2.financename      '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' wdetail2.mail_hno         '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' wdetail2.mail_build       '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' wdetail2.mail_mu          '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' wdetail2.mail_soi         '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' wdetail2.mail_road        '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' wdetail2.mail_tambon      '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' wdetail2.mail_amper       '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' wdetail2.mail_country     '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' wdetail2.mail_post        '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' wdetail2.send_date        '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' wdetail2.send_data        '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' wdetail2.REMARK1          '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' wdetail2.occup            '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' wdetail2.regis_no         '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' wdetail2.np_f18line1      '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' wdetail2.np_f18line2      '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' wdetail2.np_f18line3      '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' wdetail2.np_f18line4      '"' SKIP.                                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' wdetail2.np_f18line5      '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' wdetail2.np_f18line6      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"' wdetail2.np_f18line7      '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"' wdetail2.np_f18line8      '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"' wdetail2.campaign_ov      '"' SKIP.  /*Add by Kridtiya i. A63-0472*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"' wdetail2.agent            '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"' wdetail2.product          '"' SKIP. /*A65-0177*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K" '"' wdetail2.comment          '"' SKIP. /*A65-0177*/
End.   
nv_row  =  nv_row  + 1.  
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
FOR EACH wdetail2.  DELETE wdetail2. END.
message "Export Match File Policy Complete"  view-as alert-box.
RELEASE sicuw.uwm100.  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pro_createpol_bk c-Win 
PROCEDURE 00-pro_createpol_bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A58-0489     
------------------------------------------------------------------------------*/
def VAR nv_file     as char   init "d:\fileload\return.txt".
def var nv_row      as int    init 0.
If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_cnt  =  0  nv_row  =  0.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "จังหวัด   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "สาขา   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "ภูมิภาค   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "สาขากรมธรรม์   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Ins. Year type     "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Business type      "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "TAS received by    "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "Ins company        "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "Insurance ref no.  "  '"' SKIP.                             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "TPIS Contract No.  "  '"' SKIP.                             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "Title name         "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "customer name      "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "customer lastname  "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Customer type      "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "Director Name      "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "ID number          "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "House no.          "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Building           "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "Village name/no.   "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Soi                "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Road               "  '"' SKIP.                                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Sub-district       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "District           "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Province           "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Postcode           "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "Brand              "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Car model          "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Insurance Code     "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Model Year         "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Usage Type         "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Colour             "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Car Weight         "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Year               "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "Engine No.         "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "Chassis No.        "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "Accessories (for CV) "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "Accessories amount   "  '"' SKIP.                                           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "License No.          "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "Registered Car License "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "Campaign               "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "Type of work           "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "Insurance amount       "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "Insurance Date ( Voluntary )   "  '"' SKIP.                                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "Expiry Date ( Voluntary)       "  '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "Last Policy No. (Voluntary)    "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "Branch          "  '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "New policy no   "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "Insurance Type  "  '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Net premium (Voluntary)   "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "Gross premium (Voluntary) "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "Stamp  "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "VAT    "  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "Stamp HO  "  '"' SKIP.    /*A61-0152*/       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "VAT HO   "  '"' SKIP.     /*A61-0152*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "WHT    "  '"' SKIP.                                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "Compulsory No. "  '"' SKIP. 
/****Add by Nontamas H. [A62-0329] Date 04/07/2019***/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "เลขใบแจ้งหนั้. "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "Sticker No.    "  '"' SKIP.                                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "Insurance Date ( Compulsory )  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "Expiry Date ( Compulsory)  "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "Net premium (Compulsory)   "  '"' SKIP.            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "Gross premium (Compulsory) "  '"' SKIP.            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "Stamp   "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "VAT     "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "WHT     "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "Dealer  "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "Showroom   "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "Payment Type "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "Beneficiery  "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "Mailing House no. "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "Mailing  Building "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "Mailing  Village name/no.      "  '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "Mailing Soi    "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "Mailing  Road  "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' "Mailing  Sub-district "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "Mailing  District     "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "Mailing Province      "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "Mailing Postcode      "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' "Policy no. to customer date    "  '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' "Insurer Stamp Date   "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' "Remark               "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' "Occupation code      "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' "Register NO. "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' "f18line1     "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' "f18line2     "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' "f18line3     "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' "f18line4     "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' "f18line5     "  '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' "f18line6     "  '"' SKIP.  



PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' "Producer code        "  '"' SKIP.                  
/****End Add by Nontamas H. [A62-0329] Date 04/07/2019***/   
FOR EACH wdetail2.                           
    IF TRIM(wdetail2.tpis_no) = ""  THEN DELETE wdetail2.
    ELSE RUN pro_chk_pol.
END.
FOR EACH wdetail2 BREAK BY wdetail2.delerco.
    ASSIGN nv_row  =  nv_row  + 1   nv_cnt  =  nv_cnt  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' Wdetail2.bran_name    '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' Wdetail2.bran_name2   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' Wdetail2.region       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdetail2.branch       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' Wdetail2.ins_ytyp    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' wdetail2.bus_typ     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' wdetail2.TASreceived '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' wdetail2.InsCompany  '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' wdetail2.Insurancerefno   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' wdetail2.tpis_no          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' wdetail2.ntitle      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' wdetail2.insnam      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' wdetail2.NAME2       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' wdetail2.cust_type   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' wdetail2.nDirec      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' wdetail2.ICNO        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' wdetail2.address     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' wdetail2.build       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' wdetail2.mu          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' wdetail2.soi         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' wdetail2.road        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' wdetail2.tambon      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' wdetail2.amper       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' wdetail2.country     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' wdetail2.post        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' wdetail2.brand       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' wdetail2.model       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' wdetail2.class       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' wdetail2.md_year     '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' wdetail2.Usage FORMAT "x(50)"  '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' wdetail2.coulor      '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' wdetail2.cc          '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' wdetail2.regis_year  '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' wdetail2.engno       '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' wdetail2.chasno      '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' Wdetail2.Acc_CV      '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' Wdetail2.Acc_amount  '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' wdetail2.License     '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' wdetail2.regis_CL    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' wdetail2.campaign    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' wdetail2.typ_work    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' deci(wdetail2.si) FORMAT ">>,>>>,>>9.99"    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' wdetail2.prvpol           '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' wdetail2.branch           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' wdetail2.policy           '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' wdetail2.cover            '"' SKIP.                                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' deci(wdetail2.pol_netprem)'"' SKIP.                                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' deci(wdetail2.pol_gprem)  '"' SKIP.                                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' deci(wdetail2.pol_stamp)  '"' SKIP.                                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' deci(wdetail2.pol_vat)    '"' SKIP.                                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' deci(wdetail2.pol_stamp_ho)  '"' SKIP.  /*A61-0152*/                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' deci(wdetail2.pol_vat_ho)    '"' SKIP.  /*A61-0152*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' deci(wdetail2.pol_wht)    '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' wdetail2.com_no           '"' SKIP.                                
    /****Add by Nontamas H. [A62-0329] Date 04/07/2019***/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' wdetail2.docno            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' wdetail2.stkno            '"' SKIP.                                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' DATE(wdetail2.com_comm_date) FORMAT "99/99/9999" '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999" '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' deci(wdetail2.com_netprem)'"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' deci(wdetail2.com_gprem)  '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' deci(wdetail2.com_stamp)  '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' deci(wdetail2.com_vat)    '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' deci(wdetail2.com_wht)    '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' wdetail2.deler            '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' wdetail2.showroom         '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' wdetail2.typepay          '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' wdetail2.financename      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' wdetail2.mail_hno         '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' wdetail2.mail_build       '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' wdetail2.mail_mu          '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' wdetail2.mail_soi         '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' wdetail2.mail_road        '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' wdetail2.mail_tambon      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' wdetail2.mail_amper       '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' wdetail2.mail_country     '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' wdetail2.mail_post        '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' wdetail2.send_date        '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' wdetail2.send_data        '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' wdetail2.REMARK1          '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' wdetail2.occup            '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' wdetail2.regis_no         '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' wdetail2.np_f18line1      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' wdetail2.np_f18line2      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' wdetail2.np_f18line3      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' wdetail2.np_f18line4      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' wdetail2.np_f18line5      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' wdetail2.agent          '"' SKIP.       
    /****End Add by Nontamas H. [A62-0329] Date 04/07/2019***/                                 
End.   
nv_row  =  nv_row  + 1.  
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
FOR EACH wdetail2.
    DELETE wdetail2.
END.
message "Export Match File Policy Complete"  view-as alert-box.
RELEASE sicuw.uwm100.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pro_createpol_old c-Win 
PROCEDURE 00-pro_createpol_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A58-0489     
------------------------------------------------------------------------------*/
def VAR nv_file     as char   init "d:\fileload\return.txt".
def var nv_row      as int    init 0.
If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_cnt  =  0  nv_row  =  0.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "จังหวัด   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "สาขา   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "ภูมิภาค   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "สาขากรมธรรม์   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Ins. Year type     "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Business type      "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "TAS received by    "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "Ins company        "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "Insurance ref no.  "  '"' SKIP.                             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "TPIS Contract No.  "  '"' SKIP.                             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "Title name         "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "customer name      "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "customer lastname  "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Customer type      "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "Director Name      "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "ID number          "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "House no.          "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Building           "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "Village name/no.   "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Soi                "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Road               "  '"' SKIP.                                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Sub-district       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "District           "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Province           "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Postcode           "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "Brand              "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Car model          "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Insurance Code     "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Model Year         "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Usage Type         "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Colour             "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Car Weight         "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Year               "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "Engine No.         "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "Chassis No.        "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "Accessories (for CV) "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "Accessories amount   "  '"' SKIP.                                           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "License No.          "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "Registered Car License "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "Campaign               "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "Type of work           "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "Insurance amount       "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "Insurance Date ( Voluntary )   "  '"' SKIP.                                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "Expiry Date ( Voluntary)       "  '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "Last Policy No. (Voluntary)    "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "Branch          "  '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "New policy no   "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "Insurance Type  "  '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Net premium (Voluntary)   "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "Gross premium (Voluntary) "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "Stamp  "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "VAT    "  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "Stamp HO  "  '"' SKIP.    /*A61-0152*/       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "VAT HO   "  '"' SKIP.     /*A61-0152*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "WHT    "  '"' SKIP.                                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "Compulsory No. "  '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "Sticker No.    "  '"' SKIP.                                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "Insurance Date ( Compulsory )  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "Expiry Date ( Compulsory)  "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "Net premium (Compulsory)   "  '"' SKIP.            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "Gross premium (Compulsory) "  '"' SKIP.            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "Stamp   "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "VAT     "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "WHT     "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "Dealer  "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "Showroom   "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "Payment Type "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "Beneficiery  "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "Mailing House no. "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "Mailing  Building "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "Mailing  Village name/no.      "  '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "Mailing Soi    "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "Mailing  Road  "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "Mailing  Sub-district "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' "Mailing  District     "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "Mailing Province      "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "Mailing Postcode      "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "Policy no. to customer date    "  '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' "Insurer Stamp Date   "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' "Remark               "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' "Occupation code      "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' "Register NO. "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' "f18line1     "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' "f18line2     "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' "f18line3     "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' "f18line4     "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' "f18line5     "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' "Producer code        "  '"' SKIP.                  


FOR EACH wdetail2.                           
    IF TRIM(wdetail2.tpis_no) = ""  THEN DELETE wdetail2.
    ELSE RUN pro_chk_pol.
END.
FOR EACH wdetail2 BREAK BY wdetail2.delerco.
    ASSIGN nv_row  =  nv_row  + 1   nv_cnt  =  nv_cnt  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' Wdetail2.bran_name    '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' Wdetail2.bran_name2   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' Wdetail2.region       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdetail2.branch       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' Wdetail2.ins_ytyp    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' wdetail2.bus_typ     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' wdetail2.TASreceived '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' wdetail2.InsCompany  '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' wdetail2.Insurancerefno   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' wdetail2.tpis_no          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' wdetail2.ntitle      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' wdetail2.insnam      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' wdetail2.NAME2       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' wdetail2.cust_type   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' wdetail2.nDirec      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' wdetail2.ICNO        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' wdetail2.address     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' wdetail2.build       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' wdetail2.mu          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' wdetail2.soi         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' wdetail2.road        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' wdetail2.tambon      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' wdetail2.amper       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' wdetail2.country     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' wdetail2.post        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' wdetail2.brand       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' wdetail2.model       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' wdetail2.class       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' wdetail2.md_year     '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' wdetail2.Usage FORMAT "x(50)"  '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' wdetail2.coulor      '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' wdetail2.cc          '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' wdetail2.regis_year  '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' wdetail2.engno       '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' wdetail2.chasno      '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' Wdetail2.Acc_CV      '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' Wdetail2.Acc_amount  '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' wdetail2.License     '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' wdetail2.regis_CL    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' wdetail2.campaign    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' wdetail2.typ_work    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' deci(wdetail2.si) FORMAT ">>,>>>,>>9.99"    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' wdetail2.prvpol           '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' wdetail2.branch           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' wdetail2.policy           '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' wdetail2.cover            '"' SKIP.                                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' deci(wdetail2.pol_netprem)'"' SKIP.                                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' deci(wdetail2.pol_gprem)  '"' SKIP.                                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' deci(wdetail2.pol_stamp)  '"' SKIP.                                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' deci(wdetail2.pol_vat)    '"' SKIP.                                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' deci(wdetail2.pol_stamp_ho)  '"' SKIP.  /*A61-0152*/                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' deci(wdetail2.pol_vat_ho)    '"' SKIP.  /*A61-0152*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' deci(wdetail2.pol_wht)    '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' wdetail2.com_no           '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' wdetail2.stkno           '"' SKIP.                                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' DATE(wdetail2.com_comm_date) FORMAT "99/99/9999" '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999" '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' deci(wdetail2.com_netprem)'"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' deci(wdetail2.com_gprem)  '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' deci(wdetail2.com_stamp)  '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' deci(wdetail2.com_vat)    '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' deci(wdetail2.com_wht)    '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' wdetail2.deler            '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' wdetail2.showroom         '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' wdetail2.typepay          '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' wdetail2.financename      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' wdetail2.mail_hno         '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' wdetail2.mail_build       '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' wdetail2.mail_mu          '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' wdetail2.mail_soi         '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' wdetail2.mail_road        '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' wdetail2.mail_tambon      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' wdetail2.mail_amper       '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' wdetail2.mail_country     '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' wdetail2.mail_post        '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' wdetail2.send_date        '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' wdetail2.send_data        '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' wdetail2.REMARK1          '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' wdetail2.occup            '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' wdetail2.regis_no         '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' wdetail2.np_f18line1      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' wdetail2.np_f18line2      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' wdetail2.np_f18line3      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' wdetail2.np_f18line4      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' wdetail2.np_f18line5      '"' SKIP.                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' wdetail2.agent          '"' SKIP.                                  
End.   
nv_row  =  nv_row  + 1.  
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
FOR EACH wdetail2.
    DELETE wdetail2.
END.
message "Export Match File Policy Complete"  view-as alert-box.
RELEASE sicuw.uwm100.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
  THEN DELETE WIDGET c-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-Win  _DEFAULT-ENABLE
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
  DISPLAY ra_typefile fi_loaddat fi_pack fi_branch fi_producer fi_bchno 
          fi_producerre fi_producer72 fi_agent fi_prevbat fi_bchyr fi_filename 
          fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes 
          fi_proname fi_rename fi_impcnt fi_proname72 fi_completecnt fi_premtot 
          fi_agtname fi_premsuc fi_process fi_prom fi_packcom fi_premcomp 
          fi_model 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE br_comp ra_typefile fi_loaddat fi_pack fi_branch fi_producer fi_bchno 
         fi_producerre fi_producer72 fi_agent fi_prevbat fi_bchyr fi_filename 
         bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok 
         bu_exit bu_hpbrn bu_hpacno1 bu_hpagent bu_hpacno72 bu_hpagent72 
         fi_process fi_prom fi_packcom fi_premcomp bu_add bu_del fi_model 
         RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 br_wdetail RECT-377 
         RECT-378 RECT-379 
      WITH FRAME fr_main IN WINDOW c-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72 c-Win 
PROCEDURE proc_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/************** v72 comp y **********/
ASSIGN
    n_rencnt = 0
    n_endcnt = 0
    wdetail.benname = ""
    wdetail.covcod = "T"
    wdetail.prvpol = ""
    wdetail.compul = "y"
    wdetail.tariff = "9" . 

IF wdetail.poltyp = "v72" THEN DO:
    /* comment by Ranu :A61-0152.....
    IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN wdetail.subclass = "140A".
    ELSE wdetail.subclass = "110".*/
    /* Create by A61-0152*/
    /*IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN ASSIGN  wdetail.subclass = "140A".
    ELSE*/ 
    IF (wdetail.subclass = "110") THEN ASSIGN  wdetail.subclass = "110".
    ELSE DO:
        ASSIGN wdetail.subclass = wdetail.subclass . 
        RUN proc_chkcomp.
    END.
    /* end A61-0152*/
    IF wdetail.compul <> "y" THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N". 
END.
IF wdetail.compul = "y" THEN DO:
    /*--Str amparat C. A51-0253--*/
    IF wdetail.stk <> "" THEN DO:    
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN 
            wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
            wdetail.pass    = ""
            wdetail.OK_GEN  = "N".
             /*--end amparat C. A51-0253--*/
    END.
END.
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail.subclass NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ" + wdetail.subclass
    wdetail.pass    = "N"
    wdetail.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101       WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp    AND
        sicsyac.xmd031.class  = wdetail.subclass  NO-LOCK NO-ERROR.
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
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod  NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN   wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ" + wdetail.tariff + wdetail.subclass +  wdetail.covcod
    wdetail.OK_GEN = "N".
/*--------- modcod --------------*/
chkred = NO.   
/*IF wdetail.redbook <> "" THEN DO:    /*กรณีที่มีการระบุ Code รถมา*/
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
        sicsyac.xmm102.engine = INTE(wdetail.cc)           AND 
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
    wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ= " + wdetail.vehuse
    wdetail.OK_GEN  = "N".
ASSIGN  nv_docno  = " "
        nv_accdat = TODAY.
/***--- Docno ---***/
IF wdetail.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M"                             AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999") NO-LOCK NO-ERROR .
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 c-Win 
PROCEDURE proc_722 :
/* ---------------------------------------------  U W M 1 3 0 -------------- */
DEF VAR n_class AS CHAR FORMAT "x(10)".
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
    ASSIGN sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno.
    ASSIGN    /*a490166*/
        sic_bran.uwm130.bchyr = nv_batchyr         /* batch Year */
        sic_bran.uwm130.bchno = nv_batchno         /* bchno      */
        sic_bran.uwm130.bchcnt  = nv_batcnt .      /* bchcnt     */
    ASSIGN sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0     /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0     /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0     /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0     /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.    /*Item Endt. Clause*/
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class
        NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN 
        ASSIGN sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
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
        sic_bran.uwm301.bchyr  = nv_batchyr                      AND 
        sic_bran.uwm301.bchno  = nv_batchno                      AND 
        sic_bran.uwm301.bchcnt = nv_batcnt          NO-WAIT NO-ERROR.
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
        sic_bran.uwm301.cha_no  = wdetail.chasno
        sic_bran.uwm301.eng_no  = wdetail.engno
        sic_bran.uwm301.Tons    = DECI(wdetail.weight)
        sic_bran.uwm301.engine  = DECI(wdetail.cc)
        sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage  = wdetail.garage
        sic_bran.uwm301.body    = wdetail.body
        sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = wdetail.benname
        sic_bran.uwm301.vehreg   = wdetail.vehreg 
        sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        /*sic_bran.uwm301.moddes   = wdetail.model    /*A58-0489*/ */ /*A61-0152*/
        sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model /*A61-0152*/
        sic_bran.uwm301.modcod   = wdetail.redbook 
        sic_bran.uwm301.car_color = trim(wdetail.colorcar)   /*A66-0252*/  
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
            brstat.detaitem.policy   = sic_bran.uwm301.policy  AND               
            brstat.Detaitem.rencnt   = sic_bran.uwm301.rencnt  AND               
            brstat.Detaitem.endcnt   = sic_bran.uwm301.endcnt  AND               
            brstat.Detaitem.riskno   = sic_bran.uwm301.riskno  AND               
            brstat.Detaitem.itemno   = sic_bran.uwm301.itemno  AND
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
    ELSE  sic_bran.uwm301.drinam[9] = "".
    s_recid4  = RECID(sic_bran.uwm301).
    /***--- modi by note a490166 ---***/
    /*IF    (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN ASSIGN n_class = "210"  wdetail.subclass = "140A".
    ELSE IF wdetail.subclass = "110" THEN  ASSIGN n_class = "110"   wdetail.subclass = "110". /*A61-0152*/
    ELSE ASSIGN n_class = wdetail.subclass .  /*a61-0152*/*/
    RUN proc_chkcomp70 (INPUT-OUTPUT n_class).  /*A68-0019*/
    IF n_class = "" THEN ASSIGN n_class = wdetail.subclass .  /*A68-0019*/
    ASSIGN nv_modcod  = "".   
    IF wdetail.redbook NE "" THEN DO:   /*กรณีที่มีการระบุ Code รถมา*/
        /*FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
            sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
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
                wdetail.brand                  = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/
                wdetail.model                  = SUBSTRING(xmm102.modest,19,22).  /*Thai*/
        END.*/
        FIND FIRST stat.maktab_fil USE-INDEX maktab01 
            WHERE stat.maktab_fil.sclass = n_class      AND
            stat.maktab_fil.modcod = wdetail.redbook
            No-lock no-error no-wait.
        If  avail  stat.maktab_fil  Then 
            ASSIGN
            nv_modcod               =  stat.maktab_fil.modcod 
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes */ /*A61-0152*/
            wdetail.cargrp          =  stat.maktab_fil.prmpac
            /*sic_bran.uwm301.Tons    =  stat.maktab.tons*/
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body    =  stat.maktab_fil.body
            /*sic_bran.uwm301.engine  =  stat.maktab_fil.eng*/ /*A61-0152*/
            nv_engine   =  stat.maktab_fil.engine.
    END.
    ELSE DO:
        /*comment by Ranu i. A58-0489...............
        IF ra_typload =  2 THEN DO:   /* Non-til */ 
            FIND FIRST stat.insure USE-INDEX insure01  WHERE   
                stat.insure.compno = fi_model          AND          
                stat.insure.fname  = wdetail.model     NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL insure THEN  ASSIGN wdetail.model =  trim(stat.insure.lname)   .
         END.
        ......... end A58-0489.........*/
        /*IF wdetail.cc <> "" THEN DO: /*A58-0489*/ */ /*A61-0152*/
        IF INT(wdetail.engine) <> 0 THEN DO: /*A61-0152*/
            FIND FIRST stat.maktab_fil Use-index  maktab04           Where
                stat.maktab_fil.makdes   =   wdetail.brand            And                  
                INDEX(stat.maktab_fil.moddes,wdetail.model) <>  0     AND
                stat.maktab_fil.makyea   =   Integer(wdetail.caryear) AND
                /*stat.maktab_fil.engine   =   Integer(wdetail.cc)      AND */ /*A61-0152*/
                stat.maktab_fil.engine   =   INT(wdetail.engine)  AND  /*A61-0152*/
                stat.maktab_fil.sclass   =   n_class                  AND
               /*(stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )   GE  deci(wdetail.si)    OR  
                stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )   LE  deci(wdetail.si) )  AND */
                stat.maktab_fil.seats    GE  inte(wdetail.seat)                                           
                No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN
                ASSIGN 
                nv_modcod               =  stat.maktab_fil.modcod 
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                   
                /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/ /*A61-0152*/
                wdetail.cargrp          =  stat.maktab_fil.prmpac
                /*sic_bran.uwm301.seats   =  stat.maktab_fil.seat*/
                /*sic_bran.uwm301.engine  =  stat.maktab_fil.engine*/ /*A61-0152*/
                /*sic_bran.uwm301.Tons    =  stat.maktab.tons*/
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body    =  stat.maktab_fil.body   .
        END.
        /*------------- create by : A58-0489 ไม่มีข้อมูล CC ----------------*/
        ELSE DO:
            FIND FIRST stat.maktab_fil Use-index  maktab04           Where
                stat.maktab_fil.makdes   =   wdetail.brand            And                  
                INDEX(stat.maktab_fil.moddes,wdetail.model) <>  0     AND
                stat.maktab_fil.makyea   =   Integer(wdetail.caryear) AND
                /*stat.maktab_fil.engine   =   Integer(wdetail.cc)      AND*/
                stat.maktab_fil.sclass   =   n_class            AND     
                /*(stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )   GE  deci(wdetail.si)   OR    
                stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )   LE  deci(wdetail.si) )  AND */
                stat.maktab_fil.seats    GE  inte(wdetail.seat)  No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN
                ASSIGN 
                nv_modcod               =  stat.maktab_fil.modcod 
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                   
                /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/ /*A61-0152*/
                wdetail.cargrp          =  stat.maktab_fil.prmpac
                /*sic_bran.uwm301.seats   =  stat.maktab_fil.seat*/
                /*sic_bran.uwm301.engine  =  stat.maktab_fil.engine*/ /*A61-0152*/
                /*sic_bran.uwm301.Tons    =  stat.maktab.tons*/
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body    =  stat.maktab_fil.body   .
        END.
        IF nv_modcod   = ""  THEN RUN proc_maktab.
       /*-------------- end : A58-0489--------------------------------------*/ 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_723 c-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_7231 c-Win 
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
IF AVAIL sicsyac.xmm020 THEN 
    ASSIGN nv_stm_per = sicsyac.xmm020.rvstam
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addbr1 c-Win 
PROCEDURE proc_addbr1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A61-0152      
------------------------------------------------------------------------------*/
/* ที่อยู่ mailing  */
DEF VAR n_address AS CHAR FORMAT "X(100)" .
DEF VAR n  AS CHAR INIT "".
DEF VAR n_length  AS INT  INIT 0.
ASSIGN 
    wdetail2.ntitle = REPLACE(wdetail2.ntitle,"บจก.","บริษัท")
    wdetail2.ntitle = REPLACE(wdetail2.ntitle,"บ.","บริษัท") .
IF      INDEX(wdetail2.mail_mu,"หมู่ที่")  <> 0  THEN wdetail2.mail_mu =  trim(REPLACE(wdetail2.mail_mu,"หมู่ที่","")).
ELSE IF INDEX(wdetail2.mail_mu,"ม.")       <> 0  THEN wdetail2.mail_mu =  trim(REPLACE(wdetail2.mail_mu,"ม.","")).
ELSE IF INDEX(wdetail2.mail_mu,"หมู่บ้าน") <> 0  THEN wdetail2.mail_mu =  trim(REPLACE(wdetail2.mail_mu,"หมู่บ้าน","")).
ELSE IF INDEX(wdetail2.mail_mu,"บ้าน")     <> 0  THEN wdetail2.mail_mu =  trim(REPLACE(wdetail2.mail_mu,"บ้าน","")).
ELSE IF INDEX(wdetail2.mail_mu,"หมู่")     <> 0  THEN wdetail2.mail_mu =  trim(REPLACE(wdetail2.mail_mu,"หมู่","")).


    IF wdetail2.mail_hno <> "" AND INDEX(wdetail2.mail_hno,"เลขที่") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(REPLACE(wdetail2.mail_hno,"เลขที่","")).
    IF wdetail2.mail_build   <> ""  THEN DO: 
        IF INDEX(wdetail2.mail_build,"อาคาร")        <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build). 
        ELSE IF INDEX(wdetail2.mail_build,"ตึก")     <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF INDEX(wdetail2.mail_build,"บ้าน")    <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"บจก")     <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"หจก")     <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"บริษัท")  <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(REPLACE(wdetail2.mail_build,"บริษัท","บ.")).
        ELSE IF index(wdetail2.mail_build,"ห้าง")    <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"มูลนิธิ") <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"ชั้น")    <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE IF index(wdetail2.mail_build,"ห้อง")    <> 0  THEN ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
        ELSE ASSIGN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_build).
    END.
    IF wdetail2.mail_mu <> ""  THEN DO: 
        IF      INDEX(wdetail2.mail_mu,"หมู่ที่")  <> 0  THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(REPLACE(wdetail2.mail_mu,"หมู่ที่","ม.")).
        ELSE IF INDEX(wdetail2.mail_mu,"ม.")       <> 0  THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_mu).
        ELSE IF INDEX(wdetail2.mail_mu,"หมู่บ้าน") <> 0  THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(REPLACE(wdetail2.mail_mu,"หมู่บ้าน","บ.")).
        ELSE IF INDEX(wdetail2.mail_mu,"บ้าน")     <> 0  THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(REPLACE(wdetail2.mail_mu,"บ้าน","บ.")).
        ELSE IF INDEX(wdetail2.mail_mu,"หมู่")     <> 0  THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(REPLACE(wdetail2.mail_mu,"หมู่","ม.")).
        ELSE DO:
            ASSIGN  n = ""  
                n = SUBSTR(TRIM(wdetail2.mail_mu),1,1).
                IF INDEX("0123456789",n) <> 0 THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ม." + trim(wdetail2.mail_mu).
                ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_mu).
        END.
    END.
    IF wdetail2.mail_soi <> ""  THEN DO:
        IF INDEX(wdetail2.mail_soi,"ซ.") <> 0 THEN  wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_soi) .
        ELSE IF INDEX(wdetail2.mail_soi,"ซอย") <> 0 THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(REPLACE(wdetail2.mail_soi,"ซอย","ซ.")) .
        ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ซ." + trim(wdetail2.mail_soi) .
    END. 
    IF wdetail2.mail_road <> ""  THEN DO: 
        IF INDEX(wdetail2.mail_road,"ถ.") <> 0  THEN wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_road) .
        ELSE IF INDEX(wdetail2.mail_road,"ถนน") <> 0 THEN  wdetail2.mail_hno = trim(wdetail2.mail_hno) + " " + trim(REPLACE(wdetail2.mail_road,"ถนน","ถ.")) .
        ELSE wdetail2.mail_hno = trim(wdetail2.mail_hno) + " ถ." + trim(wdetail2.mail_road) .
    END. 
    ASSIGN
        wdetail2.mail_tambon  = trim(REPLACE(wdetail2.mail_tambon,"แขวง",""))      /*A68-0019*/
        wdetail2.mail_tambon  = trim(REPLACE(wdetail2.mail_tambon,"ต.",""))        /*A68-0019*/
        wdetail2.mail_tambon  = trim(REPLACE(wdetail2.mail_tambon,"ตำบล",""))      /*A68-0019*/
        wdetail2.mail_amper   = trim(REPLACE(wdetail2.mail_amper,"เขต",""))        /*A68-0019*/ 
        wdetail2.mail_amper   = trim(REPLACE(wdetail2.mail_amper,"อำเภอ",""))      /*A68-0019*/ 
        wdetail2.mail_amper   = trim(REPLACE(wdetail2.mail_amper,"อ.",""))         /*A68-0019*/ 
        wdetail2.mail_country = trim(REPLACE(wdetail2.mail_country,"จ.",""))       /*A68-0019*/ 
        wdetail2.mail_country = trim(REPLACE(wdetail2.mail_country,"จังหวัด","")). /*A68-0019*/ 
    
    IF wdetail2.mail_country <> ""  THEN DO:
        IF (index(wdetail2.mail_country,"กทม") <> 0 ) OR (index(wdetail2.mail_country,"กรุงเทพ") <> 0 ) THEN 
            ASSIGN 
            wdetail2.mail_country = "กรุงเทพฯ" 
            wdetail2.mail_tambon  = "แขวง"  + trim(wdetail2.mail_tambon) 
            wdetail2.mail_amper   = "เขต"   + trim(wdetail2.mail_amper)
            /*wdetail2.mail_country = trim(wdetail2.mail_country) + " " + trim(wdetail2.mail_post)/*comment by Kridtiya i. A63-0472*/
            wdetail2.mail_post    = "" .   */                                                     /*comment by Kridtiya i. A63-0472*/ 
            wdetail2.mail_country = trim(wdetail2.mail_country)                                   /*Add by Kridtiya i. A63-0472*/
            wdetail2.mail_post    = trim(wdetail2.mail_post).                                     /*Add by Kridtiya i. A63-0472*/


        ELSE ASSIGN 
            wdetail2.mail_tambon  = "ต." + trim(wdetail2.mail_tambon) 
            wdetail2.mail_amper   = "อ." + trim(wdetail2.mail_amper)
            /*wdetail2.mail_country = "จ." + trim(wdetail2.mail_country) + " " + trim(wdetail2.mail_post) /*comment by Kridtiya i. A63-0472*/
            wdetail2.mail_post    = "" . */                                                               /*comment by Kridtiya i. A63-0472*/
            wdetail2.mail_country = "จ." + trim(wdetail2.mail_country)                                    /*Add by Kridtiya i. A63-0472*/    
            wdetail2.mail_post    =        trim(wdetail2.mail_post).                                      /*Add by Kridtiya i. A63-0472*/    
    END.
    
    DO WHILE INDEX(wdetail2.mail_hno,"  ") <> 0 :
        ASSIGN wdetail2.mail_hno = trim(REPLACE(wdetail2.mail_hno,"  "," ")).
    END.



    /*IF LENGTH(wdetail2.mail_hno) > 35  THEN DO:*/ /*A66-0252*/
     IF LENGTH(wdetail2.mail_hno) > 50  THEN DO:   /*A66-0252*/
        loop_add01:
        /*DO WHILE LENGTH(wdetail2.mail_hno) > 35 :*/ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.mail_hno) > 50 :   /*A66-0252*/
            IF r-INDEX(wdetail2.mail_hno," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.mail_tambon  = trim(SUBSTR(wdetail2.mail_hno,r-INDEX(wdetail2.mail_hno," "))) + " " + wdetail2.mail_tambon
                    wdetail2.mail_hno     = trim(SUBSTR(wdetail2.mail_hno,1,r-INDEX(wdetail2.mail_hno," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        
        ASSIGN  n_length = 0
                /*n_length = (32 - LENGTH(wdetail2.mail_hno)) */  /*A66-0252*/
                n_length = (45 - LENGTH(wdetail2.mail_hno))  . /*A66-0252*/
        /*IF LENGTH(wdetail2.mail_hno) < 10  THEN DO:*/   /*A66-0252*/
        IF LENGTH(wdetail2.mail_hno) < 20  THEN DO:     /*A66-0252*/
            ASSIGN 
            wdetail2.mail_hno     = wdetail2.mail_hno + " " + trim(SUBSTR(wdetail2.mail_tambon,1,n_length - 1))
            wdetail2.mail_tambon  = trim(SUBSTR(wdetail2.mail_tambon,(n_length),r-INDEX(wdetail2.mail_tambon," "))).
        END.
   
        loop_add02:
        /*DO WHILE LENGTH(wdetail2.mail_tambon) > 30 :*/ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.mail_tambon) > 50 : /*A66-0252*/
            IF r-INDEX(wdetail2.mail_tambon," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.mail_amper   = trim(SUBSTR(wdetail2.mail_tambon,r-INDEX(wdetail2.mail_tambon," "))) + " " + wdetail2.mail_amper
                    wdetail2.mail_tambon  = trim(SUBSTR(wdetail2.mail_tambon,1,r-INDEX(wdetail2.mail_tambon," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
        loop_add03:
        /*DO WHILE LENGTH(wdetail2.mail_amper) > 30 : */ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.mail_amper) > 50 :   /*A66-0252*/
            IF r-INDEX(wdetail2.mail_amper," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.mail_country   = trim(SUBSTR(wdetail2.mail_amper,r-INDEX(wdetail2.mail_amper," "))) + " " + wdetail2.mail_country
                    wdetail2.mail_amper     = trim(SUBSTR(wdetail2.mail_amper,1,r-INDEX(wdetail2.mail_amper," "))).
            END.
            ELSE LEAVE loop_add03.
        END.

        loop_add04:
        /*DO WHILE LENGTH(wdetail2.mail_country) > 20 : */ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.mail_country) > 50 :  /*A66-0252*/
            IF r-INDEX(wdetail2.mail_country," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.mail_post      = trim(SUBSTR(wdetail2.mail_country,r-INDEX(wdetail2.mail_country," ")))
                    wdetail2.mail_country   = trim(SUBSTR(wdetail2.mail_country,1,r-INDEX(wdetail2.mail_country," "))).
            END.
            ELSE LEAVE loop_add04.
        END.
        
    END. 
   
    /* A66-0252 */
     /*IF LENGTH(wdetail2.mail_hno + " " + wdetail2.mail_tambon) < 35 THEN DO:*/ /*A66-0252*/
    IF LENGTH(wdetail2.mail_hno + " " + wdetail2.mail_tambon) < 50 THEN DO: /*A66-0252*/
        ASSIGN 
        wdetail2.mail_hno     =  trim(wdetail2.mail_hno) + " " + trim(wdetail2.mail_tambon)  
        wdetail2.mail_tambon  =  trim(wdetail2.mail_amper)   
        wdetail2.mail_amper   =  trim(wdetail2.mail_country) 
        wdetail2.mail_country =  "" .
    END.

    /*IF LENGTH(wdetail2.mail_tambon + " " + wdetail2.mail_amper) < 35 THEN DO:*/ /*A66-0252*/
    IF LENGTH(wdetail2.mail_tambon + " " + wdetail2.mail_amper) < 50 THEN DO: /*A66-0252*/
        ASSIGN 
        wdetail2.mail_tambon  =  trim(wdetail2.mail_tambon + " " + wdetail2.mail_amper)   
        wdetail2.mail_amper   =  trim(wdetail2.mail_country) 
        wdetail2.mail_country =  "" .
    END.

    /*IF LENGTH(wdetail2.mail_amper + " " + wdetail2.mail_country ) < 35 THEN DO:*/ /*A66-0252*/
    IF LENGTH(wdetail2.mail_amper + " " + wdetail2.mail_country ) < 50 THEN DO: /*A66-0252*/
        ASSIGN 
        wdetail2.mail_amper   =  trim(wdetail2.mail_amper) + " " + TRIM(wdetail2.mail_country) 
        wdetail2.mail_country =  "" .
    END.
   
  
    /*---- สาขา ----------*/
    IF wdetail2.branch = "" THEN DO:
        IF TRIM(wdetail2.prvpol) <> ""  THEN  DO:
            IF substr(TRIM(wdetail2.prvpol),1,1) = "D" THEN ASSIGN wdetail2.branch = substr(TRIM(wdetail2.prvpol),2,1).
            ELSE ASSIGN wdetail2.branch = substr(TRIM(wdetail2.prvpol),1,2).
        END.
        ELSE DO:
            ASSIGN wdetail2.branch  = "M" 
                   wdetail2.delerco = "" .
        END.
    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addbr2 c-Win 
PROCEDURE proc_addbr2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS CHAR INIT "".
DEF VAR n_length  AS INT  INIT 0.

    IF wdetail2.address <> "" AND INDEX(wdetail2.address,"เลขที่") <> 0  THEN ASSIGN wdetail2.address = trim(REPLACE(wdetail2.address,"เลขที่","")).
    IF wdetail2.build   <> ""  THEN DO: 
        IF INDEX(wdetail2.build,"อาคาร")        <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build). 
        ELSE IF INDEX(wdetail2.build,"ตึก")     <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF INDEX(wdetail2.build,"บ้าน")    <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"บจก")     <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"หจก")     <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"บริษัท")  <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.build,"บริษัท","บ.")).
        ELSE IF index(wdetail2.build,"ห้าง")    <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"มูลนิธิ") <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"ชั้น")    <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"ห้อง")    <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
    END.
    IF wdetail2.mu <> ""  THEN DO: 

        IF      INDEX(wdetail2.mu,"หมู่ที่")  <> 0  THEN wdetail2.mu =  trim(REPLACE(wdetail2.mu,"หมู่ที่","")).
        ELSE IF INDEX(wdetail2.mu,"ม.")       <> 0  THEN wdetail2.mu =  trim(REPLACE(wdetail2.mu,"ม.","")).
        ELSE IF INDEX(wdetail2.mu,"หมู่บ้าน") <> 0  THEN wdetail2.mu =  trim(REPLACE(wdetail2.mu,"หมู่บ้าน","")).
        ELSE IF INDEX(wdetail2.mu,"บ้าน")     <> 0  THEN wdetail2.mu =  trim(REPLACE(wdetail2.mu,"บ้าน","")).
        ELSE IF INDEX(wdetail2.mu,"หมู่")     <> 0  THEN wdetail2.mu =  trim(REPLACE(wdetail2.mu,"หมู่","")).

        IF INDEX(wdetail2.mu,"หมู่ที่")       <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.mu,"หมู่ที่","ม.")).
        ELSE IF INDEX(wdetail2.mu,"ม.")       <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu).
        ELSE IF INDEX(wdetail2.mu,"หมู่บ้าน") <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.mu,"หมู่บ้าน","บ.")).
        ELSE IF INDEX(wdetail2.mu,"บ้าน")     <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.mu,"บ้าน","บ.")).
        ELSE IF INDEX(wdetail2.mu,"หมู่")     <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.mu,"หมู่","ม.")).
        ELSE DO:
            ASSIGN  n = ""  
                n = SUBSTR(TRIM(wdetail2.mu),1,1).
                IF INDEX("0123456789",n) <> 0 THEN wdetail2.address = trim(wdetail2.address) + " ม." + trim(wdetail2.mu).
                ELSE wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu).
        END.
    END.
    IF wdetail2.soi <> ""  THEN DO:
        IF INDEX(wdetail2.soi,"ซ.") <> 0 THEN  wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.soi) .
        ELSE IF INDEX(wdetail2.soi,"ซอย") <> 0 THEN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.soi,"ซอย","ซ.")) .
        ELSE wdetail2.address = trim(wdetail2.address) + " ซ." + trim(wdetail2.soi) .
    END. 
    IF wdetail2.road <> ""  THEN DO: 
        IF INDEX(wdetail2.road,"ถ.") <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.road) .
        ELSE IF INDEX(wdetail2.road,"ถนน") <> 0 THEN  wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.road,"ถนน","ถ.")) .
        ELSE wdetail2.address = trim(wdetail2.address) + " ถ." + trim(wdetail2.road) .
    END.  
    ASSIGN
            wdetail2.tambon  = REPLACE(wdetail2.tambon,"แขวง","")      /*A68-0019*/
            wdetail2.tambon  = REPLACE(wdetail2.tambon,"ต.","")        /*A68-0019*/
            wdetail2.tambon  = REPLACE(wdetail2.tambon,"ตำบล","")      /*A68-0019*/
            wdetail2.amper   = REPLACE(wdetail2.amper,"เขต","")        /*A68-0019*/ 
            wdetail2.amper   = REPLACE(wdetail2.amper,"อำเภอ","")      /*A68-0019*/ 
            wdetail2.amper   = REPLACE(wdetail2.amper,"อ.","")         /*A68-0019*/ 
            wdetail2.country = REPLACE(wdetail2.country,"จ.","")       /*A68-0019*/ 
            wdetail2.country = REPLACE(wdetail2.country,"จังหวัด",""). /*A68-0019*/ 

    IF wdetail2.country <> ""  THEN DO:
        IF (index(wdetail2.country,"กทม") <> 0 ) OR (index(wdetail2.country,"กรุงเทพ") <> 0 ) THEN 
            ASSIGN 
            wdetail2.country = "กรุงเทพฯ" 
            wdetail2.tambon  = "แขวง"  + trim(wdetail2.tambon) 
            wdetail2.amper   = "เขต"   + trim(wdetail2.amper)
            wdetail2.country = trim(wdetail2.country) + " " + trim(wdetail2.post)
            wdetail2.post    = "" . 
        ELSE ASSIGN 
            wdetail2.tambon  = "ต." + trim(wdetail2.tambon) 
            wdetail2.amper   = "อ." + trim(wdetail2.amper)
            wdetail2.country = "จ." + trim(wdetail2.country) + " " + trim(wdetail2.post)
            wdetail2.post    = "" . 
    END.

    DO WHILE INDEX(wdetail2.address,"  ") <> 0 :
        ASSIGN wdetail2.address = REPLACE(wdetail2.address,"  "," ").
    END.

    /*IF LENGTH(wdetail2.address) > 35  THEN DO:*/  /*A66-0252*/
    IF LENGTH(wdetail2.address) > 50  THEN DO:  /*A66-0252*/
        loop_add01:
        /*DO WHILE LENGTH(wdetail2.address) > 35 :*/ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.address) > 50 : /*A66-0252*/
            IF r-INDEX(wdetail2.address," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.tambon  = trim(SUBSTR(wdetail2.address,r-INDEX(wdetail2.address," "))) + " " + wdetail2.tambon
                    wdetail2.address = trim(SUBSTR(wdetail2.address,1,r-INDEX(wdetail2.address," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        
        ASSIGN  n_length = 0
                /*n_length = (32 - LENGTH(wdetail2.address)) */  /*A66-0252*/
                n_length = (45 - LENGTH(wdetail2.address)). /*A66-0252*/
        /*IF LENGTH(wdetail2.address) < 10  THEN DO: */  /*A66-0252*/
        IF LENGTH(wdetail2.address) < 20  THEN DO: /*A66-0252*/
            ASSIGN 
            wdetail2.address     = wdetail2.address + " " + trim(SUBSTR(wdetail2.tambon,1,n_length - 1))
            wdetail2.tambon  = trim(SUBSTR(wdetail2.tambon,(n_length),r-INDEX(wdetail2.tambon," "))).
        END.
        
        loop_add02:
        /*DO WHILE LENGTH(wdetail2.tambon) > 30 :*/ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.tambon) > 50 : /*A66-0252*/
            IF r-INDEX(wdetail2.tambon," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.amper   = trim(SUBSTR(wdetail2.tambon,r-INDEX(wdetail2.tambon," "))) + " " + wdetail2.amper
                    wdetail2.tambon  = trim(SUBSTR(wdetail2.tambon,1,r-INDEX(wdetail2.tambon," "))).
            END.
            ELSE LEAVE loop_add02.
        END.

        loop_add03:
        /*DO WHILE LENGTH(wdetail2.amper) > 30 : */ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.amper) > 50 :      /*A66-0252*/
            IF r-INDEX(wdetail2.amper," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.country   = trim(SUBSTR(wdetail2.amper,r-INDEX(wdetail2.amper," "))) + " " + wdetail2.country
                    wdetail2.amper     = trim(SUBSTR(wdetail2.amper,1,r-INDEX(wdetail2.amper," "))).
            END.
            ELSE LEAVE loop_add03.
        END.
    END. 

    /*IF LENGTH(wdetail2.address + " " + wdetail2.tambon) < 35 THEN DO:*/ /*A66-0252*/  
    IF LENGTH(wdetail2.address + " " + wdetail2.tambon) < 35 THEN DO:     /*A66-0252*/  
        ASSIGN 
        wdetail2.address =  trim(wdetail2.address) + " " + trim(wdetail2.tambon)  
        wdetail2.tambon  =  trim(wdetail2.amper)   
        wdetail2.amper   =  trim(wdetail2.country)
        wdetail2.country =  "" .
    END.

   /*IF LENGTH(wdetail2.tambon + " " + wdetail2.amper) < 35 THEN DO:*/ /*A66-0252*/  
   IF LENGTH(wdetail2.tambon + " " + wdetail2.amper) < 35 THEN DO:     /*A66-0252*/  
        ASSIGN 
        wdetail2.tambon  =  trim(wdetail2.tambon) + " " + trim(wdetail2.amper)   
        wdetail2.amper   =  trim(wdetail2.country) 
        wdetail2.country =  "" .
    END.

    /*IF LENGTH(wdetail2.amper + " " + wdetail2.country ) < 35 THEN DO:*/ /*A66-0252*/  
    IF LENGTH(wdetail2.amper + " " + wdetail2.country ) < 35 THEN DO:     /*A66-0252*/  
        ASSIGN 
        wdetail2.amper   =  trim(wdetail2.amper) + " " + TRIM(wdetail2.country) 
        wdetail2.country =  "" .
    END.
    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addbrcktyp c-Win 
PROCEDURE proc_addbrcktyp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nvtypename AS CHAR.

ASSIGN nvtypename = ""
    nv_typ = "" 
    nvtypename =   trim(wdetail2.ntitle) + trim(wdetail2.insnam) + " " + TRIM(wdetail2.name2).
IF TRIM(nvtypename) <> " " THEN DO: 
    IF  INDEX(TRIM(nvtypename),"บริษัท")            <> 0  OR INDEX(TRIM(nvtypename),"บ.")                <> 0  OR 
        INDEX(TRIM(nvtypename),"บจก.")              <> 0  OR INDEX(TRIM(nvtypename),"หจก.")              <> 0  OR 
        INDEX(TRIM(nvtypename),"บรรษัท")            <> 0  OR INDEX(TRIM(nvtypename),"มูลนิธิ")           <> 0  OR 
        INDEX(TRIM(nvtypename),"ห้าง")              <> 0  OR INDEX(TRIM(nvtypename),"ห้างหุ้นส่วน")      <> 0  OR 
        INDEX(TRIM(nvtypename),"ห้างหุ้นส่วนจำกัด") <> 0  OR INDEX(TRIM(nvtypename),"ห้างหุ้นส่วนจำก")   <> 0  OR  
        R-INDEX(TRIM(nvtypename),"จก.")             <> 0  OR R-INDEX(TRIM(nvtypename),"จำกัด")           <> 0  OR  
        R-INDEX(TRIM(nvtypename),"(มหาชน)")         <> 0  OR R-INDEX(TRIM(nvtypename),"INC.")            <> 0  OR 
        R-INDEX(TRIM(nvtypename),"CO.")             <> 0  OR R-INDEX(TRIM(nvtypename),"LTD.")            <> 0  OR 
        R-INDEX(TRIM(nvtypename),"LIMITED")         <> 0  OR INDEX(TRIM(nvtypename),"หสน.")              <> 0  OR   
        INDEX(TRIM(nvtypename),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
    ELSE nv_typ = "0s".   /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/
END.
ELSE nv_typ = "0s". 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addbrCS c-Win 
PROCEDURE proc_addbrCS :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR n AS CHAR INIT "".
DEF VAR n_length  AS INT  INIT 0.

    IF wdetail2.address <> "" AND INDEX(wdetail2.address,"เลขที่") <> 0  THEN ASSIGN wdetail2.address = trim(REPLACE(wdetail2.address,"เลขที่","")).
    IF wdetail2.build   <> ""  THEN DO: 
        IF INDEX(wdetail2.build,"อาคาร")        <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build). 
        ELSE IF INDEX(wdetail2.build,"ตึก")     <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF INDEX(wdetail2.build,"บ้าน")    <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"บจก")     <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"หจก")     <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"บริษัท")  <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.build,"บริษัท","บ.")).
        ELSE IF index(wdetail2.build,"ห้าง")    <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"มูลนิธิ") <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"ชั้น")    <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE IF index(wdetail2.build,"ห้อง")    <> 0  THEN ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
        ELSE ASSIGN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.build).
    END.
    IF wdetail2.mu <> ""  THEN DO: 
        IF INDEX(wdetail2.mu,"หมู่ที่")       <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.mu,"หมู่ที่","ม.")).
        ELSE IF INDEX(wdetail2.mu,"ม.")       <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu).
        ELSE IF INDEX(wdetail2.mu,"หมู่บ้าน") <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.mu,"หมู่บ้าน","บ.")).
        ELSE IF INDEX(wdetail2.mu,"บ้าน")     <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.mu,"บ้าน","บ.")).
        ELSE IF INDEX(wdetail2.mu,"หมู่")     <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.mu,"หมู่","ม.")).
        ELSE DO:
            ASSIGN  n = ""  
                n = SUBSTR(TRIM(wdetail2.mu),1,1).
                IF INDEX("0123456789",n) <> 0 THEN wdetail2.address = trim(wdetail2.address) + " ม." + trim(wdetail2.mu).
                ELSE wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.mu).
        END.
    END.
    IF wdetail2.soi <> ""  THEN DO:
        IF INDEX(wdetail2.soi,"ซ.") <> 0 THEN  wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.soi) .
        ELSE IF INDEX(wdetail2.soi,"ซอย") <> 0 THEN wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.soi,"ซอย","ซ.")) .
        ELSE wdetail2.address = trim(wdetail2.address) + " ซ." + trim(wdetail2.soi) .
    END. 
    IF wdetail2.road <> ""  THEN DO: 
        IF INDEX(wdetail2.road,"ถ.") <> 0  THEN wdetail2.address = trim(wdetail2.address) + " " + trim(wdetail2.road) .
        ELSE IF INDEX(wdetail2.road,"ถนน") <> 0 THEN  wdetail2.address = trim(wdetail2.address) + " " + trim(REPLACE(wdetail2.road,"ถนน","ถ.")) .
        ELSE wdetail2.address = trim(wdetail2.address) + " ถ." + trim(wdetail2.road) .
    END.  
    IF wdetail2.country <> ""  THEN DO:
        ASSIGN
            wdetail2.tambon  = REPLACE(wdetail2.tambon,"แขวง","")       /*A68-0019*/
            wdetail2.tambon  = REPLACE(wdetail2.tambon,"ต.","")         /*A68-0019*/
            wdetail2.tambon  = REPLACE(wdetail2.tambon,"ตำบล","")       /*A68-0019*/
            wdetail2.amper   = REPLACE(wdetail2.amper,"เขต","")    /*A68-0019*/ 
            wdetail2.amper   = REPLACE(wdetail2.amper,"อำเภอ","")  /*A68-0019*/ 
            wdetail2.amper   = REPLACE(wdetail2.amper,"อ.","")     /*A68-0019*/ 
            wdetail2.country = REPLACE(wdetail2.country,"จ.","")        /*A68-0019*/ 
            wdetail2.country = REPLACE(wdetail2.country,"จังหวัด","").  /*A68-0019*/ 
        IF (index(wdetail2.country,"กทม") <> 0 ) OR (index(wdetail2.country,"กรุงเทพ") <> 0 ) THEN 
            ASSIGN 
            wdetail2.country = "กรุงเทพฯ" 
            wdetail2.tambon  = "แขวง"  + trim(wdetail2.tambon) 
            wdetail2.amper   = "เขต"   + trim(wdetail2.amper)
            wdetail2.country = trim(wdetail2.country)  
            wdetail2.post    = trim(wdetail2.post).
        ELSE ASSIGN 
            wdetail2.tambon  = "ต." + trim(wdetail2.tambon) 
            wdetail2.amper   = "อ." + trim(wdetail2.amper)
            wdetail2.country = "จ." + trim(wdetail2.country)  
            wdetail2.post    = trim(wdetail2.post).
    END.
    DO WHILE INDEX(wdetail2.address,"  ") <> 0 :
        ASSIGN wdetail2.address = REPLACE(wdetail2.address,"  "," ").
    END.

    /*IF LENGTH(wdetail2.address) > 35  THEN DO:*/  /*A66-0252*/
    IF LENGTH(wdetail2.address) > 50  THEN DO:  /*A66-0252*/
        loop_add01:
        /*DO WHILE LENGTH(wdetail2.address) > 35 :*/ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.address) > 50 : /*A66-0252*/
            IF r-INDEX(wdetail2.address," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.tambon  = trim(SUBSTR(wdetail2.address,r-INDEX(wdetail2.address," "))) + " " + wdetail2.tambon
                    wdetail2.address = trim(SUBSTR(wdetail2.address,1,r-INDEX(wdetail2.address," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        
        ASSIGN  n_length = 0
                /*n_length = (32 - LENGTH(wdetail2.address)) */  /*A66-0252*/
                n_length = (45 - LENGTH(wdetail2.address)). /*A66-0252*/
        /*IF LENGTH(wdetail2.address) < 10  THEN DO: */  /*A66-0252*/
        IF LENGTH(wdetail2.address) < 20  THEN DO: /*A66-0252*/
            ASSIGN 
            wdetail2.address     = wdetail2.address + " " + trim(SUBSTR(wdetail2.tambon,1,n_length - 1))
            wdetail2.tambon  = trim(SUBSTR(wdetail2.tambon,(n_length),r-INDEX(wdetail2.tambon," "))).
        END.
        
        loop_add02:
        /*DO WHILE LENGTH(wdetail2.tambon) > 30 :*/ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.tambon) > 50 : /*A66-0252*/
            IF r-INDEX(wdetail2.tambon," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.amper   = trim(SUBSTR(wdetail2.tambon,r-INDEX(wdetail2.tambon," "))) + " " + wdetail2.amper
                    wdetail2.tambon  = trim(SUBSTR(wdetail2.tambon,1,r-INDEX(wdetail2.tambon," "))).
            END.
            ELSE LEAVE loop_add02.
        END.

        loop_add03:
        /*DO WHILE LENGTH(wdetail2.amper) > 30 : */ /*A66-0252*/
        DO WHILE LENGTH(wdetail2.amper) > 50 :      /*A66-0252*/
            IF r-INDEX(wdetail2.amper," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail2.country   = trim(SUBSTR(wdetail2.amper,r-INDEX(wdetail2.amper," "))) + " " + wdetail2.country
                    wdetail2.amper     = trim(SUBSTR(wdetail2.amper,1,r-INDEX(wdetail2.amper," "))).
            END.
            ELSE LEAVE loop_add03.
        END.
    END. 

    /*IF LENGTH(wdetail2.address + " " + wdetail2.tambon) < 35 THEN DO:*/ /*A66-0252*/  
    IF LENGTH(wdetail2.address + " " + wdetail2.tambon) < 35 THEN DO:     /*A66-0252*/  
        ASSIGN 
        wdetail2.address =  wdetail2.address + " " + wdetail2.tambon  
        wdetail2.tambon  =  wdetail2.amper   
        wdetail2.amper   =  wdetail2.country
        wdetail2.country =  "" .
    END.

   /*IF LENGTH(wdetail2.tambon + " " + wdetail2.amper) < 35 THEN DO:*/ /*A66-0252*/  
   IF LENGTH(wdetail2.tambon + " " + wdetail2.amper) < 35 THEN DO:     /*A66-0252*/  
        ASSIGN 
        wdetail2.tambon  =  wdetail2.tambon + " " + wdetail2.amper   
        wdetail2.amper   =  wdetail2.country 
        wdetail2.country =  "" .
    END.

    /*IF LENGTH(wdetail2.amper + " " + wdetail2.country ) < 35 THEN DO:*/ /*A66-0252*/  
    IF LENGTH(wdetail2.amper + " " + wdetail2.country ) < 35 THEN DO:     /*A66-0252*/  
        ASSIGN 
        wdetail2.amper   =  trim(wdetail2.amper) + " " + TRIM(wdetail2.country) 
        wdetail2.country =  "" .
    END.
    ASSIGN 
     wdetail2.mail_hno      =  trim(wdetail2.address)
     wdetail2.mail_tambon   =  trim(wdetail2.tambon)
     wdetail2.mail_amper    =  trim(wdetail2.amper)
     wdetail2.mail_country  =  trim(wdetail2.country)
     wdetail2.mail_post     =  trim(wdetail2.post).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132 c-Win 
PROCEDURE proc_adduwd132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
             sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod      NO-ERROR NO-WAIT.
   
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
                  nv_pdprm  = nv_pdprm + stat.pmuwd132.prem_C.
              
               IF sic_bran.uwd132.bencod = "SI"  THEN ASSIGN sic_bran.uwd132.benvar = nv_sivar .
               IF sic_bran.uwd132.bencod = "BI1" THEN ASSIGN sic_bran.uwd132.benvar = nv_bipvar.
               IF sic_bran.uwd132.bencod = "BI2" THEN ASSIGN sic_bran.uwd132.benvar = nv_biavar.
               IF sic_bran.uwd132.bencod = "PD"  THEN ASSIGN sic_bran.uwd132.benvar = nv_pdavar.
               IF sic_bran.uwd132.bencod = "411" THEN ASSIGN sic_bran.uwd132.benvar = nv_411var.
               IF sic_bran.uwd132.bencod = "412" THEN ASSIGN sic_bran.uwd132.benvar = nv_412var.
               IF sic_bran.uwd132.bencod = "42"  THEN ASSIGN sic_bran.uwd132.benvar = nv_42var .
               IF sic_bran.uwd132.bencod = "43"  THEN ASSIGN sic_bran.uwd132.benvar = nv_43var .

                /* add by : Ranu I. A64-0344 */
               IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN  nv_ncbper  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)). /*A64-0344*/
               IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  .  
               IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  . 
               IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  .  
               IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  .   
               
               IF sic_bran.uwd132.bencod = "FLET" AND TRIM(stat.pmuwd132.benvar) = "" THEN DO:
                   ASSIGN sic_bran.uwd132.benvar = "     Fleet Discount %  =      10 " .
               END.
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
           wdetail.WARNING = wdetail.WARNING + "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.volprem
           wdetail.pass    = IF wdetail.pass <> "N" THEN "Y" ELSE "N"  
           wdetail.OK_GEN  = "N".
        END.
        /* end A64-0344 */
    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132prem c-Win 
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
           wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.volprem .
           wdetail.WARNING = wdetail.WARNING + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ ".
           /*
           wdetail.pass    = IF wdetail.pass <> "N" THEN "Y" ELSE "N"  
           wdetail.OK_GEN  = "N".*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132Renew c-Win 
PROCEDURE proc_adduwd132Renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A65-0177       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
   
    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 .
          
     FOR EACH wuwd132  WHERE TRIM(wuwd132.prepol)  = TRIM(wdetail.prvpol) NO-LOCK.
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
             sic_bran.uwd132.bencod  = wuwd132.bencod      NO-ERROR NO-WAIT.
   
            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.

               ASSIGN fi_process = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
               DISP fi_process WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  wuwd132.bencod 
                  sic_bran.uwd132.benvar  =  wuwd132.benvar 
                  /*sic_bran.uwd132.rate    =  0.00 */       
                  sic_bran.uwd132.gap_ae  =  wuwd132.gap_ae           
                  sic_bran.uwd132.gap_c   =  wuwd132.gap_c   
                  /*sic_bran.uwd132.dl1_c   =  0.00 */       
                  /*sic_bran.uwd132.dl2_c   =  0.00 */       
                  /*sic_bran.uwd132.dl3_c   =  0.00 */       
                  sic_bran.uwd132.pd_aep  =  wuwd132.pd_aep             
                  sic_bran.uwd132.prem_c  =  wuwd132.prem_c  
                  sic_bran.uwd132.fptr    =  0                  
                  sic_bran.uwd132.bptr    =  nv_bptr                   
                  sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
                  sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
                  sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
                  sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
                  sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
                  sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
                  /*sic_bran.uwd132.rateae  =  "A"   */              
                  sic_bran.uwd132.bchyr   =  nv_batchyr                   
                  sic_bran.uwd132.bchno   =  nv_batchno 
                  sic_bran.uwd132.bchcnt  =  nv_batcnt.
               
                  nv_gapprm = nv_gapprm + wuwd132.gap_c .
                  nv_pdprm  = nv_pdprm  + wuwd132.prem_C.
               
               IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
               
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
                          nv_ncbper =   0
                          nv_ncb    =   0.
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
        IF nv_pdprm <> DECI(wdetail.volprem) THEN DO:
            ASSIGN
                wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.volprem .
                wdetail.WARNING = wdetail.WARNING + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ ".
        END.
    sic_bran.uwm130.bptr03  = nv_bptr. 
    RELEASE sic_bran.uwd132.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign c-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:                                                  
    For each  wdetail2 :                             
        DELETE  wdetail2.                            
    END.
    For each  wdetail :                              
        DELETE  wdetail.                             
    END.
    FOR EACH wdetmemo.
        DELETE wdetmemo.
    END.
    FOR EACH ws0m009 .
        DELETE ws0m009.
    END.
    INPUT FROM VALUE (fi_filename) .
    REPEAT:                  
        CREATE wdetail2.     
        IMPORT DELIMITER "|" 
            wdetail2.ins_ytyp              /* Ins. Year type                    */     
            wdetail2.bus_typ               /* Business type                     */ 
            wdetail2.TASreceived           /* TAS received by                   */  
            wdetail2.InsCompany            /* Ins company                       */  
            wdetail2.Insurancerefno        /* Insurance ref no.                 */  
            wdetail2.tpis_no               /* TPIS Contract No.                 */  
            wdetail2.ntitle                /* Title name                        */
            wdetail2.insnam                /* customer name                     */
            wdetail2.NAME2                 /* customer lastname                 */
            wdetail2.cust_type             /* Customer type                     */
            wdetail2.nDirec                /* Director Name                     */
            wdetail2.ICNO                  /* ID number                         */
            wdetail2.address               /* House no.                         */
            wdetail2.build                 /* Building                          */
            wdetail2.mu                    /* Village name/no.                  */
            wdetail2.soi                   /* Soi                               */
            wdetail2.road                  /* Road                              */
            wdetail2.tambon                /* Sub-district                      */
            wdetail2.amper                 /* District                          */
            wdetail2.country               /* Province                          */
            wdetail2.post                  /* Postcode                          */
            wdetail2.brand                 /* Brand                             */
            wdetail2.model                 /* Car model                         */
            wdetail2.class                 /* Insurance Code                    */
            wdetail2.md_year               /* Model Year                        */
            wdetail2.Usage                 /* Usage Type                        */
            wdetail2.coulor                /* Colour                            */
            wdetail2.cc                    /* Car Weight (CC.)                  */
            wdetail2.regis_year            /* Year                              */
            wdetail2.engno                 /* Engine No.                        */
            wdetail2.chasno                /* Chassis No.                       */
            Wdetail2.Acc_CV                /* Accessories (for CV)              */
            Wdetail2.Acc_amount            /* Accessories amount                */
            wdetail2.License               /* License No.                       */
            wdetail2.regis_CL              /* Registered Car License            */
            wdetail2.campaign              /* Campaign                          */
            wdetail2.typ_work              /* Type of work                      */
            wdetail2.si                    /* Insurance amount                  */
            wdetail2.pol_comm_date         /* Insurance Date ( Voluntary )      */
            wdetail2.pol_exp_date          /* Expiry Date ( Voluntary)          */
            wdetail2.prvpol               /* Last Policy No. (Voluntary)       */
            wdetail2.branch                /* branch */ 
            wdetail2.cover                 /* Insurance Type                    */
            wdetail2.pol_netprem           /* Net premium (Voluntary)           */
            wdetail2.pol_gprem             /* Gross premium (Voluntary)         */
            wdetail2.pol_stamp             /* Stamp                             */
            wdetail2.pol_vat               /* VAT                               */
            wdetail2.pol_wht               /* WHT                               */
            wdetail2.com_no                /* Compulsory No.                    */
            wdetail2.docno                 /* DocNo.                            */ /**Add By Nontamas H. [A62-0329] Date 08/07/2019****/
            wdetail2.stkno                 /* sticker No.                    */
            wdetail2.com_comm_date         /* Insurance Date ( Compulsory )     */
            wdetail2.com_exp_date          /* Expiry Date ( Compulsory)         */
            wdetail2.com_netprem           /* Net premium (Compulsory)          */
            wdetail2.com_gprem             /* Gross premium (Compulsory)        */
            wdetail2.com_stamp             /* Stamp                             */
            wdetail2.com_vat               /* VAT                               */
            wdetail2.com_wht               /* WHT                               */
            wdetail2.deler                 /* Dealer                            */
            wdetail2.showroom              /* Showroom                          */
            wdetail2.typepay               /* Payment Type                      */
            wdetail2.financename           /* Beneficiery                       */
            wdetail2.mail_hno              /* Mailing House no.                 */
            wdetail2.mail_build            /* Mailing  Building                 */
            wdetail2.mail_mu               /* Mailing  Village name/no.         */ 
            wdetail2.mail_soi              /* Mailing Soi                       */ 
            wdetail2.mail_road             /* Mailing  Road                     */ 
            wdetail2.mail_tambon           /* Mailing  Sub-district             */ 
            wdetail2.mail_amper            /* Mailing  District                 */ 
            wdetail2.mail_country          /* Mailing Province                  */ 
            wdetail2.mail_post             /* Mailing Postcode                  */ 
            wdetail2.send_date             /* Policy no. to customer date       */
            wdetail2.policy_no             /* New policy no                     */
            wdetail2.send_data             /* Insurer Stamp Date                */
            wdetail2.REMARK1               /* Remark                            */
            wdetail2.occup                 /* Occupation code                   */
            wdetail2.regis_no                                               
            wdetail2.np_f18line1           
            wdetail2.np_f18line2     
            wdetail2.np_f18line3     
            wdetail2.np_f18line4     
            wdetail2.np_f18line5     
            wdetail2.np_f18line6     
            wdetail2.np_f18line7   
            wdetail2.np_f18line8
            /* A66-0252 */
            wdetail2.np_f18line9
            wdetail2.insp
            wdetail2.ispno
            wdetail2.detail
            wdetail2.damage
            wdetail2.ispacc
            /* A66-0252 */
            wdetail2.producer      /* "Producer    */
            wdetail2.product .      /* A65-0177 */
                                    /* "Data Check  */

        IF      index(wdetail2.ins_ytyp,"ins")   <> 0 THEN DELETE wdetail2.
        ELSE IF index(wdetail2.ins_ytyp,"Ins")   <> 0 THEN DELETE wdetail2.
        ELSE IF index(wdetail2.ins_ytyp,"first") <> 0 THEN DELETE wdetail2.
        ELSE IF index(wdetail2.ins_ytyp,"First") <> 0 THEN DELETE wdetail2.
        ELSE IF TRIM(wdetail2.tpis_no) = ""           THEN DELETE wdetail2.
        ELSE DO: 
            IF trim(wdetail2.producer) = "B3M0034" THEN ASSIGN  wdetail2.insp = "Y" . /*A66-0252*/
            RUN proc_colorcode. /*A66-0252*/
        END.
    END.   /* repeat   */
    RUN proc_assign3.
    
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign3 c-Win 
PROCEDURE proc_assign3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2 .
  IF TRIM(wdetail2.tpis_no) = ""  THEN DELETE wdetail2.
  ELSE DO:
    IF      wdetail2.pol_netprem  = "-" THEN ASSIGN wdetail2.pol_netprem = "0" .
    ELSE IF wdetail2.pol_netprem  = " " THEN ASSIGN wdetail2.pol_netprem = "0" .
    ELSE ASSIGN wdetail2.pol_netprem = wdetail2.pol_netprem . 
    IF      wdetail2.pol_gprem    = "-" THEN ASSIGN wdetail2.pol_gprem   = "0" .   
    ELSE IF wdetail2.pol_gprem    = " " THEN ASSIGN wdetail2.pol_gprem   = "0" .   
    ELSE ASSIGN wdetail2.pol_gprem   = wdetail2.pol_gprem .
    IF      wdetail2.com_netprem  = "-" THEN ASSIGN wdetail2.com_netprem = "0" .
    ELSE IF wdetail2.com_netprem  = " " THEN ASSIGN wdetail2.com_netprem = "0" .
    ELSE ASSIGN wdetail2.com_netprem = wdetail2.com_netprem. 
    IF      wdetail2.com_gprem    = "-" THEN ASSIGN wdetail2.com_gprem   = "0" .
    ELSE IF wdetail2.com_gprem    = " " THEN ASSIGN wdetail2.com_gprem   = "0" .
    ELSE ASSIGN wdetail2.com_gprem   = wdetail2.com_gprem .
    ASSIGN fi_process = "Import data TPIS-renew".    
    DISP fi_process WITH FRAM fr_main.
    IF deci(wdetail2.cc) <> 0 THEN DO:
      nv_cc = "" .
      IF  ((DECI(wdetail2.cc) / 2)) - (TRUNC(DECI(wdetail2.cc) / 2,0)) > 0 THEN  nv_cc = STRING(DECI(wdetail2.cc) + 1). 
      ELSE nv_cc = TRIM(wdetail2.cc). 
    END.
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
      stat.insure.compno = "TPIS"             AND    
      stat.insure.fname  = wdetail2.deler     AND
      stat.insure.lname  = wdetail2.showroom  NO-ERROR NO-WAIT.
    IF AVAIL stat.insure THEN ASSIGN wdetail2.delerco    = stat.insure.insno
        wdetail2.financecd  = stat.Insure.Text3.  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
    ELSE  ASSIGN wdetail2.delerco  = "" 
        wdetail2.financecd  = "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
    FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno  = "999" AND
        TRIM(brstat.msgcode.MsgDesc) = trim(wdetail2.ntitle)  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL brstat.msgcode THEN  ASSIGN wdetail2.ntitle  =  trim(brstat.msgcode.branch).
    ELSE DO: 
      IF wdetail2.ntitle = "" THEN ASSIGN wdetail2.ntitle = "คุณ".
      ELSE wdetail2.ntitle = trim(wdetail2.ntitle) .
    END.
    /*Add by Kridtiya i. A63-0472*/
    RUN proc_assign3Addr (INPUT  trim(wdetail2.mail_tambon) 
                         ,INPUT  trim(wdetail2.mail_amper)      
                         ,INPUT  trim(wdetail2.mail_country)   
                         ,INPUT  trim(wdetail2.occup)   
                         ,OUTPUT wdetail2.codeocc  
                         ,OUTPUT wdetail2.codeaddr1
                         ,OUTPUT wdetail2.codeaddr2
                         ,OUTPUT wdetail2.codeaddr3).
    RUN proc_matchtypins (INPUT  trim(wdetail2.ntitle)                              
                         ,INPUT  trim(wdetail2.insnam) + " " + TRIM(wdetail2.NAME2) 
                         ,OUTPUT wdetail2.insnamtyp
                         ,OUTPUT wdetail2.firstName
                         ,OUTPUT wdetail2.lastName).
    /*Add by Kridtiya i. A63-0472*/
    RUN proc_addbr1.
    RUN proc_addbrcktyp.  /*A68-0019*/
    IF nv_typ = "Cs"  THEN RUN proc_addbrCS.  /*A68-0019*/
    IF TRIM(wdetail2.cust_typ) = "J" THEN RUN proc_addbr2.
    IF trim(wdetail2.typ_work) = "C" THEN RUN proc_assign3_72.        /*พรบ.only 72*/
    ELSE IF trim(wdetail2.typ_work) = "V" THEN RUN proc_assign3_70.   /*กธ.only 70*/
    ELSE DO:
      IF DECI(wdetail2.pol_netprem) <> 0  AND DECI(wdetail2.pol_netprem) <> 0 THEN DO:
        FIND FIRST wdetail WHERE wdetail.policy = "0TL" + trim(wdetail2.tpis_no) NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
          CREATE wdetail.
          ASSIGN wdetail.policy      = "0TL" + trim(wdetail2.tpis_no)
          wdetail.cr_2        = IF wdetail2.typ_work = "V+C" THEN "VTL" + trim(wdetail2.tpis_no) ELSE ""  /* A63-0101*/
          wdetail.seat        = IF      DECI(wdetail2.com_netprem) = 600 THEN "7"  
                                ELSE IF index(wdetail2.class,"110") <> 0 THEN "7" 
                                ELSE IF index(wdetail2.class,"210") <> 0 THEN "5" ELSE "3"  /*A61-0152*/
          wdetail.brand       = TRIM(wdetail2.brand)
          wdetail.poltyp      = "V70" 
          wdetail.insrefno    = ""
          wdetail.comdat      = TRIM(wdetail2.pol_comm_date)
          wdetail.expdat      = TRIM(wdetail2.pol_exp_date)
          wdetail.tiname      = trim(wdetail2.ntitle)
          wdetail.insnam      = trim(wdetail2.insnam) + " " + TRIM(wdetail2.NAME2)
          wdetail.ICNO        = trim(wdetail2.ICNO)    
          wdetail.subclass    = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,2,3) ELSE trim(wdetail2.CLASS)
          wdetail.model       = TRIM(wdetail2.model) 
          wdetail.engine      = nv_cc
          wdetail.cc          = trim(wdetail2.cc)
          wdetail.ton         = IF index(wdetail2.class,"320") <> 0 OR index(wdetail2.class,"420") <> 0 OR index(wdetail2.class,"520") <> 0  THEN TRIM(wdetail2.cc) ELSE ""  /*A68-0019*/
          wdetail.weight      = IF index(wdetail2.class,"320") <> 0 OR index(wdetail2.class,"420") <> 0 OR index(wdetail2.class,"520") <> 0  THEN TRIM(wdetail2.cc) ELSE ""  /*A68-0019*/
          wdetail.caryear     = trim(wdetail2.md_year) 
          wdetail.chasno      = trim(wdetail2.chasno)
          wdetail.vehreg      = trim(wdetail2.License) + " " + trim(wdetail2.regis_cl)
          wdetail.engno       = trim(wdetail2.engno)
          wdetail.iadd1       = trim(wdetail2.mail_hno)               
          wdetail.iadd2       = trim(wdetail2.mail_tambon)            
          wdetail.iadd3       = trim(wdetail2.mail_amper)             
          wdetail.iadd4       = trim(wdetail2.mail_country) 
          wdetail.post        = TRIM(wdetail2.mail_post)
          wdetail.address     = trim(wdetail2.address)
          wdetail.tambon      = trim(wdetail2.tambon)
          wdetail.amper       = trim(wdetail2.amper) 
          wdetail.country     = trim(wdetail2.country)
          wdetail.vehuse      = IF INDEX(wdetail2.Usage,"พาณิชย์") <> 0 THEN "2" ELSE "1" /*A66-0252*/
          wdetail.garage      = IF INDEX(wdetail2.np_f18line4,"ห้าง") <> 0 THEN "G"
                                ELSE IF INDEX(wdetail2.np_f18line4,"อะไหล่แท้") <> 0  THEN "P" ELSE ""  
          wdetail.stk         = ""
          wdetail.covcod      = TRIM(wdetail2.cover)
          wdetail.si          = trim(wdetail2.si) 
          wdetail.prempa      = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,1,1) ELSE ""  
          wdetail.branch      = TRIM(wdetail2.branch)
          wdetail.benname     = TRIM(wdetail2.financename) 
          wdetail.volprem     = trim(wdetail2.pol_netprem)   
          wdetail.comment     = ""
          wdetail.agent       = trim(fi_agent) 
          wdetail.producer    = IF wdetail2.producer <> "" THEN trim(wdetail2.producer) 
                                ELSE IF index(wdetail2.deler,"Refinance") <> 0 THEN trim(fi_producerre) ELSE trim(fi_producer)  
          wdetail.entdat      = string(TODAY)              /*entry date*/
          wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
          wdetail.trandat     = STRING(TODAY)             /*tran date*/
          wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
          wdetail.n_IMPORT    = "IM"
          wdetail.n_EXPORT    = "" 
          wdetail.prvpol      = trim(wdetail2.prvpol)
          wdetail.cedpol      = trim(wdetail2.tpis_no)  
          wdetail.remark      = trim(wdetail2.remark1)  
          wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE ""    
          wdetail.cuts_typ    = TRIM(wdetail2.cust_type)
          wdetail.promo       = TRIM(wdetail2.bus_typ) + "-" + trim(wdetail2.np_f18line5) /*A66-0252*/ 
          wdetail.campens     = wdetail2.campaign
          wdetail.finint      = TRIM(wdetail2.delerco) 
          wdetail.financecd   = wdetail2.financecd  
          wdetail.seat41      = INT(wdetail.seat) 
          wdetail.occup       = TRIM(n_occupn)
          wdetail.prmtxt      = IF wdetail2.acc_cv <> "" AND trim(Wdetail2.Acc_amount) <> "" THEN TRIM(wdetail2.acc_cv) + " คุ้มครองรวมในทุนประกันภัยไม่เกิน " + trim(Wdetail2.Acc_amount) + " บาท" 
                                ELSE IF wdetail2.acc_cv <> "" THEN TRIM(wdetail2.acc_cv) ELSE ""  /*A66-0252*/
          wdetail.insnamtyp   = wdetail2.insnamtyp     /*Add by Kridtiya i. A63-0472*/
          wdetail.firstName   = wdetail2.firstName     /*Add by Kridtiya i. A63-0472*/
          wdetail.lastName    = wdetail2.lastName      /*Add by Kridtiya i. A63-0472*/
          wdetail.postcd      = wdetail2.mail_post     /*Add by Kridtiya i. A63-0472*/
          wdetail.codeocc     = wdetail2.codeocc       /*Add by Kridtiya i. A63-0472*/
          wdetail.codeaddr1   = wdetail2.codeaddr1     /*Add by Kridtiya i. A63-0472*/
          wdetail.codeaddr2   = wdetail2.codeaddr2     /*Add by Kridtiya i. A63-0472*/
          wdetail.codeaddr3   = wdetail2.codeaddr3     /*Add by Kridtiya i. A63-0472*/
          wdetail.br_insured  = "00000"                /*Add by Kridtiya i. A63-0472*/
          wdetail.product     = wdetail2.product  /*A65-0177*/
          wdetail.tariff      = "X"    /*A65-0177*/
          wdetail.insp        = trim(wdetail2.insp)     /* A66-0252 */
          wdetail.colorcar    = trim(wdetail2.coulor). /* A66-0252 */
          IF (wdetail2.np_f18line1 <> "") OR (wdetail2.np_f18line2 <> "") OR (wdetail2.np_f18line3 <> "") OR (wdetail2.np_f18line4 <> "") OR
             /*(wdetail2.np_f18line5 <> "") OR*/ (wdetail2.np_f18line6 <> "") OR (wdetail2.np_f18line7 <> "") OR (wdetail2.np_f18line8 <> "") OR 
             (wdetail2.np_f18line9 <> "") OR (wdetail2.ispno  <> "" ) OR (wdetail2.detail <> "" ) OR (wdetail2.damage <> "" ) OR (wdetail2.ispacc <> "" )THEN DO:
             FIND LAST wdetmemo WHERE wdetmemo.policymemo = wdetail.policy  NO-ERROR NO-WAIT.
              IF NOT AVAIL wdetmemo THEN DO:
                CREATE wdetmemo.
                ASSIGN wdetmemo.policymemo = wdetail.policy
                wdetmemo.f18line1   = wdetail2.np_f18line1 
                wdetmemo.f18line2   = wdetail2.np_f18line2 
                wdetmemo.f18line3   = wdetail2.np_f18line3 
                wdetmemo.f18line4   = wdetail2.np_f18line4
                wdetmemo.f18line5   = "" 
                wdetmemo.f18line6   = wdetail2.np_f18line6  /*Kridtiya i. 21/08/2020 */
                wdetmemo.f18line7   = wdetail2.np_f18line7  /*Kridtiya i. 21/08/2020 */
                wdetmemo.f18line8   = wdetail2.np_f18line8  /*Kridtiya i. 21/08/2020 */
                wdetmemo.f18line9   = wdetail2.np_f18line9
                wdetmemo.ispno      = wdetail2.ispno  
                wdetmemo.detail     = wdetail2.detail 
                wdetmemo.damage     = wdetail2.damage 
                wdetmemo.ispacc     = wdetail2.ispacc .
                /* end :A66-0252 */
              END.
          END.
        END.   /* FIND FIRST wdetail */
      END.
      IF DECI(wdetail2.com_netprem) <> 0  AND DECI(wdetail2.com_gprem) <> 0   THEN DO:  /*create v72*/ /*a63-0101*/    
          FIND FIRST wdetail WHERE wdetail.policy = "VTL" + trim(wdetail2.tpis_no) NO-ERROR NO-WAIT.  /*a63-0101*/
          IF NOT AVAIL wdetail THEN DO:
              CREATE wdetail.
              ASSIGN wdetail.policy      = "VTL" + trim(wdetail2.tpis_no)  /*a63-0101 */
              wdetail.cr_2        = IF wdetail2.typ_work = "V+C" THEN "0TL" + trim(wdetail2.tpis_no) ELSE ""
              wdetail.seat        = IF DECI(wdetail2.com_netprem) = 600 THEN "7"  
                                    ELSE IF index(wdetail2.class,"110") <> 0 THEN "7" 
                                    ELSE IF index(wdetail2.class,"210") <> 0 THEN "5" ELSE "3"  /*A61-0152*/
              wdetail.brand       = TRIM(wdetail2.brand)
              wdetail.poltyp      = "V72" 
              wdetail.insrefno    = ""
              wdetail.comdat      = TRIM(wdetail2.com_comm_date)    
              wdetail.expdat      = TRIM(wdetail2.com_exp_date)     
              wdetail.tiname      = trim(wdetail2.ntitle)
              wdetail.insnam      = trim(wdetail2.insnam) + " " + TRIM(wdetail2.name2)
              wdetail.subclass    = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,2,3) ELSE trim(wdetail2.CLASS)
              wdetail.model       = TRIM(wdetail2.model) 
              wdetail.engine      = nv_cc
              wdetail.cc          = trim(wdetail2.cc)
              wdetail.ton         = IF index(wdetail2.class,"320") <> 0 OR index(wdetail2.class,"420") <> 0 OR index(wdetail2.class,"520") <> 0  THEN TRIM(wdetail2.cc) ELSE ""  /*A68-0019*/
              wdetail.weight      = IF index(wdetail2.class,"320") <> 0 OR index(wdetail2.class,"420") <> 0 OR index(wdetail2.class,"520") <> 0  THEN TRIM(wdetail2.cc) ELSE ""  /*A68-0019*/
              wdetail.caryear     = trim(wdetail2.md_year) 
              wdetail.chasno      = trim(wdetail2.chasno)          
              wdetail.vehreg      = trim(wdetail2.License) + " " + trim(wdetail2.regis_cl)           
              wdetail.engno       = trim(wdetail2.engno)           
              wdetail.iadd1       = trim(wdetail2.mail_hno)                      
              wdetail.iadd2       = trim(wdetail2.mail_tambon)                   
              wdetail.iadd3       = trim(wdetail2.mail_amper)                    
              wdetail.iadd4       = trim(wdetail2.mail_country)
              wdetail.post        = TRIM(wdetail2.mail_post)
              wdetail.address     = trim(wdetail2.address)        
              wdetail.tambon      = trim(wdetail2.tambon)         
              wdetail.amper       = trim(wdetail2.amper)          
              wdetail.country     = trim(wdetail2.country)        
              wdetail.vehuse      = "1"
              wdetail.garage      = ""
              wdetail.ICNO        = trim(wdetail2.ICNO)       /*A56-0217*/
              wdetail.stk         = TRIM(wdetail2.stkno) 
              wdetail.docno       = trim(wdetail2.docno) /*****Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
              wdetail.covcod      = "T" 
              wdetail.si          = trim(wdetail2.si) 
              wdetail.branch      = TRIM(wdetail2.branch)  /*A63-0101*/
              wdetail.benname     = ""  /*A57-0010*/
              wdetail.volprem     = TRIM(wdetail2.com_gprem)  /*A61-0152*/
              wdetail.comment     = ""
              wdetail.agent       = trim(fi_agent)     
              wdetail.prempa      = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,1,1) ELSE ""  /*A61-0152*/
              wdetail.producer    = IF wdetail2.producer <> "" THEN trim(wdetail2.producer) 
                                    ELSE IF index(wdetail2.deler,"Refinance") <> 0 THEN trim(fi_producerre)  ELSE trim(fi_producer) /*A61-0152*/
              wdetail.entdat      = string(TODAY)              /*entry date*/
              wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
              wdetail.trandat     = STRING(TODAY)             /*tran date*/
              wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
              wdetail.n_IMPORT    = "IM"
              wdetail.n_EXPORT    = "" 
              wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE ""    
              wdetail.remark      = trim(wdetail2.remark1)  
              wdetail.promo       = TRIM(wdetail2.bus_typ) /*A61-0152*/
              wdetail.cedpol      = trim(wdetail2.tpis_no)
              wdetail.occup       = TRIM(n_occupn)
              wdetail.finint      = TRIM(wdetail2.delerco) /*A61-0152*/
              wdetail.financecd   = wdetail2.financecd  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
              wdetail.seat41      = INT(wdetail.seat) /*A61-0152*/
              wdetail.cuts_typ    = TRIM(wdetail2.cust_type)
              wdetail.insnamtyp   = wdetail2.insnamtyp     /*Add by Kridtiya i. A63-0472*/
              wdetail.firstName   = wdetail2.firstName     /*Add by Kridtiya i. A63-0472*/
              wdetail.lastName    = wdetail2.lastName      /*Add by Kridtiya i. A63-0472*/
              wdetail.postcd      = wdetail2.mail_post     /*Add by Kridtiya i. A63-0472*/
              wdetail.codeocc     = wdetail2.codeocc       /*Add by Kridtiya i. A63-0472*/
              wdetail.codeaddr1   = wdetail2.codeaddr1     /*Add by Kridtiya i. A63-0472*/
              wdetail.codeaddr2   = wdetail2.codeaddr2     /*Add by Kridtiya i. A63-0472*/
              wdetail.codeaddr3   = wdetail2.codeaddr3     /*Add by Kridtiya i. A63-0472*/
              wdetail.br_insured  = "00000"                /*Add by Kridtiya i. A63-0472*/
              wdetail.tariff      = "9"                   /*A65-0177*/
              wdetail.colorcar    = trim(wdetail2.coulor). /* A66-0252 */
             IF (wdetail2.np_f18line1 <> "") OR (wdetail2.np_f18line2 <> "") OR (wdetail2.np_f18line3 <> "") OR (wdetail2.np_f18line4 <> "") OR
                /*(wdetail2.np_f18line5 <> "") OR*/ (wdetail2.np_f18line6 <> "") OR (wdetail2.np_f18line7 <> "") OR (wdetail2.np_f18line8 <> "") OR 
                (wdetail2.np_f18line9 <> "") OR (wdetail2.ispno  <> "" )     OR (wdetail2.detail <> "" )     OR (wdetail2.damage <> "" )     OR 
                (wdetail2.ispacc <> "" )THEN DO:
                FIND LAST wdetmemo WHERE wdetmemo.policymemo = wdetail.policy  NO-ERROR NO-WAIT.
                IF NOT AVAIL wdetmemo THEN DO:
                  CREATE wdetmemo.
                  ASSIGN wdetmemo.policymemo = wdetail.policy
                  wdetmemo.f18line1   = wdetail2.np_f18line1 
                  wdetmemo.f18line2   = wdetail2.np_f18line2 
                  wdetmemo.f18line3   = wdetail2.np_f18line3 
                  wdetmemo.f18line4   = wdetail2.np_f18line4
                  wdetmemo.f18line5   = "" /*wdetail2.np_f18line5 */
                  wdetmemo.f18line6   = wdetail2.np_f18line6  
                  wdetmemo.f18line7   = wdetail2.np_f18line7  
                  wdetmemo.f18line8   = wdetail2.np_f18line8  
                  wdetmemo.f18line9   = wdetail2.np_f18line9
                  wdetmemo.ispno      = wdetail2.ispno  
                  wdetmemo.detail     = wdetail2.detail 
                  wdetmemo.damage     = wdetail2.damage 
                  wdetmemo.ispacc     = wdetail2.ispacc .
                END.
              END.  /* end :A66-0252 */
          END.
      END.       /* stk */
    END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign3Addr c-Win 
PROCEDURE proc_assign3Addr :
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
IF      INDEX(np_mail_country,"กรุงเทพ") <> 0 THEN np_mail_country = "กรุงเทพมหานคร".
ELSE IF INDEX(np_mail_country,"กทม")     <> 0 THEN np_mail_country = "กรุงเทพมหานคร".

FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE 
    sicuw.uwm500.prov_d = np_mail_country  NO-LOCK NO-ERROR NO-WAIT.  /*"กาญจนบุรี"*/   /*uwm100.codeaddr1*/
IF AVAIL sicuw.uwm500 THEN DO:  
    /*DISP sicuw.uwm500.prov_n .*/
    np_codeaddr1 = sicuw.uwm500.prov_n.
    FIND LAST sicuw.uwm501 USE-INDEX uwm50102   WHERE 
        sicuw.uwm501.prov_n = sicuw.uwm500.prov_n  AND
        sicuw.uwm501.dist_d = np_mail_amper        NO-LOCK NO-ERROR NO-WAIT. /*"พนมทวน"*/
    IF AVAIL sicuw.uwm501 THEN DO:  
        /*DISP
        sicuw.uwm501.prov_n  /* uwm100.codeaddr1 */
        sicuw.uwm501.dist_n  /* uwm100.codeaddr2 */ 
        . 
        */
        ASSIGN np_codeaddr1 =  sicuw.uwm501.prov_n
               np_codeaddr2 =  sicuw.uwm501.dist_n.
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
        ELSE np_codeocc  = trim(np_occupation) .
    END.
    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign3old c-Win 
PROCEDURE proc_assign3old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2 .
  IF TRIM(wdetail2.tpis_no) = ""  THEN DELETE wdetail2.
  ELSE DO:
    IF      wdetail2.pol_netprem  = "-" THEN ASSIGN wdetail2.pol_netprem = "0" .
    ELSE IF wdetail2.pol_netprem  = " " THEN ASSIGN wdetail2.pol_netprem = "0" .
    ELSE ASSIGN wdetail2.pol_netprem = wdetail2.pol_netprem . 
    IF      wdetail2.pol_gprem    = "-" THEN ASSIGN wdetail2.pol_gprem   = "0" .   
    ELSE IF wdetail2.pol_gprem    = " " THEN ASSIGN wdetail2.pol_gprem   = "0" .   
    ELSE ASSIGN wdetail2.pol_gprem   = wdetail2.pol_gprem .
    IF      wdetail2.com_netprem  = "-" THEN ASSIGN wdetail2.com_netprem = "0" .
    ELSE IF wdetail2.com_netprem  = " " THEN ASSIGN wdetail2.com_netprem = "0" .
    ELSE ASSIGN wdetail2.com_netprem = wdetail2.com_netprem. 
    IF      wdetail2.com_gprem    = "-" THEN ASSIGN wdetail2.com_gprem   = "0" .
    ELSE IF wdetail2.com_gprem    = " " THEN ASSIGN wdetail2.com_gprem   = "0" .
    ELSE ASSIGN wdetail2.com_gprem   = wdetail2.com_gprem .
    ASSIGN fi_process = "Import data TPIS-renew".    
    DISP fi_process WITH FRAM fr_main.
    IF deci(wdetail2.cc) <> 0 THEN DO:
      nv_cc = "" .
      IF  ((DECI(wdetail2.cc) / 2)) - (TRUNC(DECI(wdetail2.cc) / 2,0)) > 0 THEN  nv_cc = STRING(DECI(wdetail2.cc) + 1). 
      ELSE nv_cc = TRIM(wdetail2.cc). 
    END.
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
      stat.insure.compno = "TPIS"             AND    
      stat.insure.fname  = wdetail2.deler     AND
      stat.insure.lname  = wdetail2.showroom  NO-ERROR NO-WAIT.
    IF AVAIL stat.insure THEN ASSIGN wdetail2.delerco    = stat.insure.insno
        wdetail2.financecd  = stat.Insure.Text3.  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
    ELSE  ASSIGN wdetail2.delerco  = "" 
        wdetail2.financecd  = "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
    FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno  = "999" AND
        TRIM(brstat.msgcode.MsgDesc) = trim(wdetail2.ntitle)  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL brstat.msgcode THEN  ASSIGN wdetail2.ntitle  =  trim(brstat.msgcode.branch).
    ELSE DO: 
      IF wdetail2.ntitle = "" THEN ASSIGN wdetail2.ntitle = "คุณ".
      ELSE wdetail2.ntitle = trim(wdetail2.ntitle) .
    END.
    /*Add by Kridtiya i. A63-0472*/
    RUN proc_assign3Addr (INPUT  trim(wdetail2.mail_tambon) 
                         ,INPUT  trim(wdetail2.mail_amper)      
                         ,INPUT  trim(wdetail2.mail_country)   
                         ,INPUT  trim(wdetail2.occup)   
                         ,OUTPUT wdetail2.codeocc  
                         ,OUTPUT wdetail2.codeaddr1
                         ,OUTPUT wdetail2.codeaddr2
                         ,OUTPUT wdetail2.codeaddr3).
    RUN proc_matchtypins (INPUT  trim(wdetail2.ntitle)                              
                         ,INPUT  trim(wdetail2.insnam) + " " + TRIM(wdetail2.NAME2) 
                         ,OUTPUT wdetail2.insnamtyp
                         ,OUTPUT wdetail2.firstName
                         ,OUTPUT wdetail2.lastName).
    /*Add by Kridtiya i. A63-0472*/
    RUN proc_addbr1.
    RUN proc_addbrcktyp.  /*A68-0019*/
    IF nv_typ = "Cs"  THEN RUN proc_addbrCS.  /*A68-0019*/
    IF TRIM(wdetail2.cust_typ) = "J" THEN RUN proc_addbr2.
    IF trim(wdetail2.typ_work) = "C" THEN RUN proc_assign3_72.        /*พรบ.only 72*/
    ELSE IF trim(wdetail2.typ_work) = "V" THEN RUN proc_assign3_70.   /*กธ.only 70*/
    ELSE DO:
      IF DECI(wdetail2.pol_netprem) <> 0  AND DECI(wdetail2.pol_netprem) <> 0 THEN DO:
        FIND FIRST wdetail WHERE wdetail.policy = "0TL" + trim(wdetail2.tpis_no) NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
          CREATE wdetail.
          ASSIGN wdetail.policy      = "0TL" + trim(wdetail2.tpis_no)
          wdetail.cr_2        = IF wdetail2.typ_work = "V+C" THEN "VTL" + trim(wdetail2.tpis_no) ELSE ""  /* A63-0101*/
          wdetail.seat        = IF      DECI(wdetail2.com_netprem) = 600 THEN "7"  
                                ELSE IF index(wdetail2.class,"110") <> 0 THEN "7" 
                                ELSE IF index(wdetail2.class,"210") <> 0 THEN "5" ELSE "3"  /*A61-0152*/
          wdetail.brand       = TRIM(wdetail2.brand)
          wdetail.poltyp      = "V70" 
          wdetail.insrefno    = ""
          wdetail.comdat      = TRIM(wdetail2.pol_comm_date)
          wdetail.expdat      = TRIM(wdetail2.pol_exp_date)
          wdetail.tiname      = trim(wdetail2.ntitle)
          wdetail.insnam      = trim(wdetail2.insnam) + " " + TRIM(wdetail2.NAME2)
          wdetail.ICNO        = trim(wdetail2.ICNO)    
          wdetail.subclass    = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,2,3) ELSE trim(wdetail2.CLASS)
          wdetail.model       = TRIM(wdetail2.model) 
          wdetail.engine      = nv_cc
          wdetail.cc          = trim(wdetail2.cc)
          wdetail.ton         = IF index(wdetail2.class,"320") <> 0 OR index(wdetail2.class,"420") <> 0 OR index(wdetail2.class,"520") <> 0  THEN TRIM(wdetail2.cc) ELSE ""  /*A68-0019*/
          wdetail.weight      = IF index(wdetail2.class,"320") <> 0 OR index(wdetail2.class,"420") <> 0 OR index(wdetail2.class,"520") <> 0  THEN TRIM(wdetail2.cc) ELSE ""  /*A68-0019*/
          wdetail.caryear     = trim(wdetail2.md_year) 
          /*wdetail.caryear     = trim(wdetail2.regis_year) */  /*A66-0252*/
          wdetail.chasno      = trim(wdetail2.chasno)
          wdetail.vehreg      = trim(wdetail2.License) + " " + trim(wdetail2.regis_cl)
          wdetail.engno       = trim(wdetail2.engno)
          wdetail.iadd1       = trim(wdetail2.mail_hno)               
          wdetail.iadd2       = trim(wdetail2.mail_tambon)            
          wdetail.iadd3       = trim(wdetail2.mail_amper)             
          wdetail.iadd4       = trim(wdetail2.mail_country) 
          wdetail.post        = TRIM(wdetail2.mail_post)
          wdetail.address     = trim(wdetail2.address)
          wdetail.tambon      = trim(wdetail2.tambon)
          wdetail.amper       = trim(wdetail2.amper) 
          wdetail.country     = trim(wdetail2.country)
          /*wdetail.vehuse      = "1"*/ /*A66-0252*/
          wdetail.vehuse      = IF INDEX(wdetail2.Usage,"พาณิชย์") <> 0 THEN "2" ELSE "1" /*A66-0252*/
          wdetail.garage      = IF INDEX(wdetail2.np_f18line4,"ห้าง") <> 0 THEN "G"
                                ELSE IF INDEX(wdetail2.np_f18line4,"อะไหล่แท้") <> 0  THEN "P" ELSE ""  
          wdetail.stk         = ""
          wdetail.covcod      = TRIM(wdetail2.cover)
          wdetail.si          = trim(wdetail2.si) 
          wdetail.prempa      = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,1,1) ELSE ""  
          wdetail.branch      = TRIM(wdetail2.branch)
          wdetail.benname     = TRIM(wdetail2.financename) 
          wdetail.volprem     = trim(wdetail2.pol_netprem)   
          wdetail.comment     = ""
          wdetail.agent       = trim(fi_agent) 
          wdetail.producer    = IF wdetail2.producer <> "" THEN trim(wdetail2.producer) 
                                ELSE IF index(wdetail2.deler,"Refinance") <> 0 THEN trim(fi_producerre) ELSE trim(fi_producer)  
          wdetail.entdat      = string(TODAY)              /*entry date*/
          wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
          wdetail.trandat     = STRING(TODAY)             /*tran date*/
          wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
          wdetail.n_IMPORT    = "IM"
          wdetail.n_EXPORT    = "" 
          wdetail.prvpol      = trim(wdetail2.prvpol)
          wdetail.cedpol      = trim(wdetail2.tpis_no)  
          wdetail.remark      = trim(wdetail2.remark1)  
          wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE ""    
          wdetail.cuts_typ    = TRIM(wdetail2.cust_type)
          /*wdetail.promo       = TRIM(wdetail2.bus_typ)*/ /*A66-0252*/ 
          wdetail.promo       = TRIM(wdetail2.bus_typ) + "-" + trim(wdetail2.np_f18line5) /*A66-0252*/ 
          wdetail.campens     = wdetail2.campaign
          wdetail.finint      = TRIM(wdetail2.delerco) 
          wdetail.financecd   = wdetail2.financecd  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
          wdetail.seat41      = INT(wdetail.seat) 
          wdetail.occup       = TRIM(n_occupn)
          /*wdetail.prmtxt      = IF wdetail2.acc_cv <> "" THEN TRIM(wdetail2.acc_cv) + " " + trim(Wdetail2.Acc_amount) ELSE "" */ /*A66-0252*/
          wdetail.prmtxt      = IF wdetail2.acc_cv <> "" AND trim(Wdetail2.Acc_amount) <> "" THEN TRIM(wdetail2.acc_cv) + " คุ้มครองรวมในทุนประกันภัยไม่เกิน " + trim(Wdetail2.Acc_amount) + " บาท" 
                                ELSE IF wdetail2.acc_cv <> "" THEN TRIM(wdetail2.acc_cv) ELSE ""  /*A66-0252*/
          wdetail.insnamtyp   = wdetail2.insnamtyp     /*Add by Kridtiya i. A63-0472*/
          wdetail.firstName   = wdetail2.firstName     /*Add by Kridtiya i. A63-0472*/
          wdetail.lastName    = wdetail2.lastName      /*Add by Kridtiya i. A63-0472*/
          wdetail.postcd      = wdetail2.mail_post     /*Add by Kridtiya i. A63-0472*/
          wdetail.codeocc     = wdetail2.codeocc       /*Add by Kridtiya i. A63-0472*/
          wdetail.codeaddr1   = wdetail2.codeaddr1     /*Add by Kridtiya i. A63-0472*/
          wdetail.codeaddr2   = wdetail2.codeaddr2     /*Add by Kridtiya i. A63-0472*/
          wdetail.codeaddr3   = wdetail2.codeaddr3     /*Add by Kridtiya i. A63-0472*/
          wdetail.br_insured  = "00000"                /*Add by Kridtiya i. A63-0472*/
          wdetail.product     = wdetail2.product  /*A65-0177*/
          wdetail.tariff      = "X"    /*A65-0177*/
          wdetail.insp        = trim(wdetail2.insp)     /* A66-0252 */
          wdetail.colorcar    = trim(wdetail2.coulor). /* A66-0252 */
          IF (wdetail2.np_f18line1 <> "") OR (wdetail2.np_f18line2 <> "") OR (wdetail2.np_f18line3 <> "") OR (wdetail2.np_f18line4 <> "") OR
             /*(wdetail2.np_f18line5 <> "") OR*/ (wdetail2.np_f18line6 <> "") OR (wdetail2.np_f18line7 <> "") OR (wdetail2.np_f18line8 <> "") OR 
             /* Add by : A66-0252 */
             (wdetail2.np_f18line9 <> "") OR (wdetail2.ispno  <> "" ) OR (wdetail2.detail <> "" ) OR (wdetail2.damage <> "" ) OR (wdetail2.ispacc <> "" )THEN DO:
             /* end A66-0252 */
              FIND LAST wdetmemo WHERE wdetmemo.policymemo = wdetail.policy  NO-ERROR NO-WAIT.
              IF NOT AVAIL wdetmemo THEN DO:
                CREATE wdetmemo.
                ASSIGN wdetmemo.policymemo = wdetail.policy
                wdetmemo.f18line1   = wdetail2.np_f18line1 
                wdetmemo.f18line2   = wdetail2.np_f18line2 
                wdetmemo.f18line3   = wdetail2.np_f18line3 
                wdetmemo.f18line4   = wdetail2.np_f18line4
                wdetmemo.f18line5   = "" /*wdetail2.np_f18line5 */
                wdetmemo.f18line6   = wdetail2.np_f18line6  /*Kridtiya i. 21/08/2020 */
                wdetmemo.f18line7   = wdetail2.np_f18line7  /*Kridtiya i. 21/08/2020 */
                wdetmemo.f18line8   = wdetail2.np_f18line8  /*Kridtiya i. 21/08/2020 */
                /* Add by :A66-0252 */
                wdetmemo.f18line9   = wdetail2.np_f18line9
                wdetmemo.ispno      = wdetail2.ispno  
                wdetmemo.detail     = wdetail2.detail 
                wdetmemo.damage     = wdetail2.damage 
                wdetmemo.ispacc     = wdetail2.ispacc .
                /* end :A66-0252 */
              END.
          END.
        END.   /* FIND FIRST wdetail */
      END.
      /*IF TRIM(wdetail2.com_no) <> ""  AND DECI(wdetail2.com_netprem) <> 0  AND DECI(wdetail2.com_gprem) <> 0   THEN DO: */  /*create v72*/ /*a63-0101*/
      IF DECI(wdetail2.com_netprem) <> 0  AND DECI(wdetail2.com_gprem) <> 0   THEN DO:  /*create v72*/ /*a63-0101*/    
          /* FIND FIRST wdetail WHERE wdetail.policy = TRIM(wdetail2.com_no) NO-ERROR NO-WAIT. */ /*a63-0101*/
          FIND FIRST wdetail WHERE wdetail.policy = "VTL" + trim(wdetail2.tpis_no) NO-ERROR NO-WAIT.  /*a63-0101*/
          IF NOT AVAIL wdetail THEN DO:
              CREATE wdetail.
              ASSIGN wdetail.policy      = "VTL" + trim(wdetail2.tpis_no)  /*a63-0101 */
              wdetail.cr_2        = IF wdetail2.typ_work = "V+C" THEN "0TL" + trim(wdetail2.tpis_no) ELSE ""
              wdetail.seat        = IF DECI(wdetail2.com_netprem) = 600 THEN "7"  
                                    ELSE IF index(wdetail2.class,"110") <> 0 THEN "7" 
                                    ELSE IF index(wdetail2.class,"210") <> 0 THEN "5" ELSE "3"  /*A61-0152*/
              wdetail.brand       = TRIM(wdetail2.brand)
              wdetail.poltyp      = "V72" 
              wdetail.insrefno    = ""
              wdetail.comdat      = TRIM(wdetail2.com_comm_date)    
              wdetail.expdat      = TRIM(wdetail2.com_exp_date)     
              wdetail.tiname      = trim(wdetail2.ntitle)
              wdetail.insnam      = trim(wdetail2.insnam) + " " + TRIM(wdetail2.name2)
              /* create by A61-0152 */
              wdetail.subclass    = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,2,3) ELSE trim(wdetail2.CLASS)
              wdetail.model       = TRIM(wdetail2.model) 
              wdetail.engine      = nv_cc
              wdetail.cc          = trim(wdetail2.cc)
              

              wdetail.caryear     = trim(wdetail2.md_year) 
              wdetail.chasno      = trim(wdetail2.chasno)          
              wdetail.vehreg      = trim(wdetail2.License) + " " + trim(wdetail2.regis_cl)           
              wdetail.engno       = trim(wdetail2.engno)           
              wdetail.iadd1       = trim(wdetail2.mail_hno)                      
              wdetail.iadd2       = trim(wdetail2.mail_tambon)                   
              wdetail.iadd3       = trim(wdetail2.mail_amper)                    
              wdetail.iadd4       = trim(wdetail2.mail_country)
              wdetail.post        = TRIM(wdetail2.mail_post)
              wdetail.address     = trim(wdetail2.address)        
              wdetail.tambon      = trim(wdetail2.tambon)         
              wdetail.amper       = trim(wdetail2.amper)          
              wdetail.country     = trim(wdetail2.country)        
              wdetail.vehuse      = "1"
              wdetail.garage      = ""
              wdetail.ICNO        = trim(wdetail2.ICNO)       /*A56-0217*/
              wdetail.stk         = TRIM(wdetail2.stkno) 
              wdetail.docno       = trim(wdetail2.docno) /*****Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
              wdetail.covcod      = "T" 
              wdetail.si          = trim(wdetail2.si) 
              wdetail.branch      = TRIM(wdetail2.branch)  /*A63-0101*/
              wdetail.benname     = ""  /*A57-0010*/
              wdetail.volprem     = TRIM(wdetail2.com_gprem)  /*A61-0152*/
              wdetail.comment     = ""
              wdetail.agent       = trim(fi_agent)     
              wdetail.prempa      = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,1,1) ELSE ""  /*A61-0152*/
              wdetail.producer    = IF wdetail2.producer <> "" THEN trim(wdetail2.producer) 
                                    ELSE IF index(wdetail2.deler,"Refinance") <> 0 THEN trim(fi_producerre)  ELSE trim(fi_producer) /*A61-0152*/
              wdetail.entdat      = string(TODAY)              /*entry date*/
              wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
              wdetail.trandat     = STRING(TODAY)             /*tran date*/
              wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
              wdetail.n_IMPORT    = "IM"
              wdetail.n_EXPORT    = "" 
              wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE ""    
              wdetail.remark      = trim(wdetail2.remark1)  
              wdetail.promo       = TRIM(wdetail2.bus_typ) /*A61-0152*/
              wdetail.cedpol      = trim(wdetail2.tpis_no)
              wdetail.occup       = TRIM(n_occupn)
              wdetail.finint      = TRIM(wdetail2.delerco) /*A61-0152*/
              wdetail.financecd   = wdetail2.financecd  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
              wdetail.seat41      = INT(wdetail.seat) /*A61-0152*/
              wdetail.cuts_typ    = TRIM(wdetail2.cust_type)
              wdetail.insnamtyp   = wdetail2.insnamtyp     /*Add by Kridtiya i. A63-0472*/
              wdetail.firstName   = wdetail2.firstName     /*Add by Kridtiya i. A63-0472*/
              wdetail.lastName    = wdetail2.lastName      /*Add by Kridtiya i. A63-0472*/
              wdetail.postcd      = wdetail2.mail_post     /*Add by Kridtiya i. A63-0472*/
              wdetail.codeocc     = wdetail2.codeocc       /*Add by Kridtiya i. A63-0472*/
              wdetail.codeaddr1   = wdetail2.codeaddr1     /*Add by Kridtiya i. A63-0472*/
              wdetail.codeaddr2   = wdetail2.codeaddr2     /*Add by Kridtiya i. A63-0472*/
              wdetail.codeaddr3   = wdetail2.codeaddr3     /*Add by Kridtiya i. A63-0472*/
              wdetail.br_insured  = "00000"                /*Add by Kridtiya i. A63-0472*/
              wdetail.tariff      = "9"                   /*A65-0177*/
              wdetail.colorcar    = trim(wdetail2.coulor). /* A66-0252 */
             /* Add by : A66-0252 */
             IF (wdetail2.np_f18line1 <> "") OR (wdetail2.np_f18line2 <> "") OR (wdetail2.np_f18line3 <> "") OR (wdetail2.np_f18line4 <> "") OR
                /*(wdetail2.np_f18line5 <> "") OR*/ (wdetail2.np_f18line6 <> "") OR (wdetail2.np_f18line7 <> "") OR (wdetail2.np_f18line8 <> "") OR 
                (wdetail2.np_f18line9 <> "") OR (wdetail2.ispno  <> "" )     OR (wdetail2.detail <> "" )     OR (wdetail2.damage <> "" )     OR 
                (wdetail2.ispacc <> "" )THEN DO:
                FIND LAST wdetmemo WHERE wdetmemo.policymemo = wdetail.policy  NO-ERROR NO-WAIT.
                IF NOT AVAIL wdetmemo THEN DO:
                  CREATE wdetmemo.
                  ASSIGN wdetmemo.policymemo = wdetail.policy
                  wdetmemo.f18line1   = wdetail2.np_f18line1 
                  wdetmemo.f18line2   = wdetail2.np_f18line2 
                  wdetmemo.f18line3   = wdetail2.np_f18line3 
                  wdetmemo.f18line4   = wdetail2.np_f18line4
                  wdetmemo.f18line5   = "" /*wdetail2.np_f18line5 */
                  wdetmemo.f18line6   = wdetail2.np_f18line6  
                  wdetmemo.f18line7   = wdetail2.np_f18line7  
                  wdetmemo.f18line8   = wdetail2.np_f18line8  
                  wdetmemo.f18line9   = wdetail2.np_f18line9
                  wdetmemo.ispno      = wdetail2.ispno  
                  wdetmemo.detail     = wdetail2.detail 
                  wdetmemo.damage     = wdetail2.damage 
                  wdetmemo.ispacc     = wdetail2.ispacc .
                END.
              END.  /* end :A66-0252 */
          END.
      END.       /* stk */
    END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign3_70 c-Win 
PROCEDURE proc_assign3_70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A58-0489    
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.policy = "0TL" + trim(wdetail2.tpis_no) NO-ERROR NO-WAIT.
       IF NOT AVAIL wdetail THEN DO:
           CREATE wdetail.
           ASSIGN
               /*wdetail.policy      = caps(trim(wdetail2.policy)) */    /*A57-0226*/
               wdetail.policy      = "0TL" + trim(wdetail2.tpis_no) /*A57-0226*/
               wdetail.brand       = TRIM(wdetail2.brand)
               wdetail.poltyp      = "V70" 
               wdetail.insrefno    = ""
               wdetail.comdat      = TRIM(wdetail2.pol_comm_date)
               wdetail.expdat      = TRIM(wdetail2.pol_exp_date)
               wdetail.tiname      = trim(wdetail2.ntitle)
               wdetail.insnam      = trim(wdetail2.insnam) + " " + TRIM(wdetail2.NAME2)
               wdetail.ICNO        = trim(wdetail2.ICNO)    /*A56-0217*/
               /*wdetail.subclass    = IF DECI(wdetail2.com_netprem) = 600 THEN "110" ELSE 
                                     IF DECI(wdetail2.com_netprem) <> 0 THEN  "210" ELSE TRIM(wdetail2.CLASS)*/ /*A61-0152*/
                wdetail.seat        = IF      DECI(wdetail2.com_netprem) = 600 THEN "7"  
                                      ELSE IF index(wdetail2.class,"110") <> 0 THEN "7" 
                                      ELSE IF index(wdetail2.class,"210") <> 0 THEN "5"
                                      ELSE "3"  /*A61-0152*/
               /*wdetail.model       = IF INDEX(wdetail2.model,"TFR85HG") <> 0 THEN "MU-7" ELSE "D-MAX" */ /*A61-0152*/
               /* create by A61-0152 */
               wdetail.subclass    = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,2,3) ELSE trim(wdetail2.CLASS)
               wdetail.model       = TRIM(wdetail2.model) 
               wdetail.engine      = nv_cc
               /*end A61-0152*/
               wdetail.cc          = trim(wdetail2.cc) 
               wdetail.ton         = IF index(wdetail2.class,"320") <> 0 OR index(wdetail2.class,"420") <> 0 OR index(wdetail2.class,"520") <> 0  THEN TRIM(wdetail2.cc) ELSE ""  /*A68-0019*/
               wdetail.weight      = IF index(wdetail2.class,"320") <> 0 OR index(wdetail2.class,"420") <> 0 OR index(wdetail2.class,"520") <> 0  THEN TRIM(wdetail2.cc) ELSE ""  /*A68-0019*/
               wdetail.caryear     = trim(wdetail2.md_year) 
               /*wdetail.caryear     = trim(wdetail2.regis_year)   A66-0252*/
               wdetail.chasno      = trim(wdetail2.chasno)
               wdetail.vehreg      = trim(wdetail2.License) + " " + trim(wdetail2.regis_cl)
               wdetail.engno       = trim(wdetail2.engno)
               wdetail.iadd1       = trim(wdetail2.mail_hno)              /*wdetail2.address*/
               wdetail.iadd2       = trim(wdetail2.mail_tambon)           /*wdetail2.tambon */
               wdetail.iadd3       = trim(wdetail2.mail_amper)            /*wdetail2.amper  */
               wdetail.iadd4       = trim(wdetail2.mail_country)          /*wdetail2.country*/ 
               wdetail.post        = TRIM(wdetail2.mail_post)
               wdetail.address     = trim(wdetail2.address)        
               wdetail.tambon      = trim(wdetail2.tambon)         
               wdetail.amper       = trim(wdetail2.amper)          
               wdetail.country     = trim(wdetail2.country)        
               /*wdetail.vehuse      = "1"*/ /*A66-0252*/
               wdetail.vehuse      = IF INDEX(wdetail2.Usage,"พาณิชย์") <> 0 THEN "2" ELSE "1" /*A66-0252*/
               /*wdetail.garage      = ""*/ /*A61-0152*/
              /* wdetail.garage      = IF INDEX(wdetail2.np_f18line4,"ห้าง") <> 0 THEN "G"  ELSE "" /*A61-0152*/*/ /*A62-0422*/
               wdetail.garage      = IF INDEX(wdetail2.np_f18line4,"ห้าง") <> 0 THEN "G"
                                     ELSE IF INDEX(wdetail2.np_f18line4,"อะไหล่แท้") <> 0  THEN "P" ELSE "" /*A62-0422*/
               wdetail.stk         = ""
               wdetail.covcod      = TRIM(wdetail2.cover) 
               wdetail.si          = trim(wdetail2.si) 
               /*wdetail.prempa      = caps(trim(fi_pack))*/ /*A61-0152*/
               wdetail.prempa      = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,1,1) ELSE ""  /*A61-0152*/
               /*wdetail.branch      = "M" */
               wdetail.branch      = TRIM(wdetail2.branch)
               wdetail.benname     = TRIM(wdetail2.financename)
               wdetail.volprem     = trim(wdetail2.pol_netprem)  
               wdetail.comment     = ""
               wdetail.agent       = trim(fi_agent)     
               wdetail.producer    = IF wdetail2.producer <> "" THEN trim(wdetail2.producer) 
                                     ELSE IF index(wdetail2.deler,"Refinance") <> 0 THEN trim(fi_producerre) 
                                     ELSE trim(fi_producer)  /*A61-0152*/
               wdetail.entdat      = string(TODAY)              /*entry date*/
               wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
               wdetail.trandat     = STRING(TODAY)             /*tran date*/
               wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
               wdetail.n_IMPORT    = "IM"
               wdetail.n_EXPORT    = "" 
               wdetail.prvpol      = trim(wdetail2.prvpol)
               /*wdetail.inscod      = wdetail2.typepay  */  
               wdetail.cedpol      = trim(wdetail2.tpis_no)  
               wdetail.remark     = trim(wdetail2.remark1)  
               /*wdetail.chkcar      = trim(wdetail2.chkcar)   
               wdetail.telno       = trim(wdetail2.telno)*/
               wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE ""    
               wdetail.cuts_typ    = TRIM(wdetail2.cust_type)
               wdetail.occup       = TRIM(n_occupn)
               /*wdetail.promo       = "TIL"*/
               /*A61-0152*/
               /*wdetail.promo       = TRIM(wdetail2.bus_typ)*/ /*A66-0252*/ 
               wdetail.promo       = TRIM(wdetail2.bus_typ) + "-" + trim(wdetail2.np_f18line5) /*A66-0252*/  
               /*wdetail.campens     = IF INDEX(wdetail2.campaign,"/") <> 0 THEN trim(REPLACE(wdetail2.campaign,"/","_")) ELSE TRIM(wdetail2.campaign)*/
               wdetail.campens     = trim(wdetail2.campaign) 
               wdetail.finint      = TRIM(wdetail2.delerco) 
               wdetail.seat41      = INT(wdetail.seat) 
               /* end A61-0152*/
                /*wdetail.prmtxt      = IF wdetail2.acc_cv <> "" THEN TRIM(wdetail2.acc_cv) + " " + trim(Wdetail2.Acc_amount) ELSE "" */ /*A66-0252*/
               wdetail.prmtxt      = IF wdetail2.acc_cv <> "" AND trim(Wdetail2.Acc_amount) <> "" THEN TRIM(wdetail2.acc_cv) + " คุ้มครองรวมในทุนประกันภัยไม่เกิน " + trim(Wdetail2.Acc_amount) + " บาท" 
                                     ELSE IF wdetail2.acc_cv <> "" THEN TRIM(wdetail2.acc_cv) ELSE ""  /*A66-0252*/
               wdetail.firstName   = trim(wdetail2.insnam)  /*Add by Kridtiya i. A63-0472*/
               wdetail.lastName    = TRIM(wdetail2.NAME2)   /*Add by Kridtiya i. A63-0472*/
               wdetail.postcd      = wdetail2.mail_post     /*Add by Kridtiya i. A63-0472*/
               wdetail.codeocc     = wdetail2.codeocc       /*Add by Kridtiya i. A63-0472*/
               wdetail.codeaddr1   = wdetail2.codeaddr1     /*Add by Kridtiya i. A63-0472*/
               wdetail.codeaddr2   = wdetail2.codeaddr2     /*Add by Kridtiya i. A63-0472*/
               wdetail.codeaddr3   = wdetail2.codeaddr3     /*Add by Kridtiya i. A63-0472*/
               wdetail.br_insured  = "00000"                /*Add by Kridtiya i. A63-0472*/
               wdetail.product     = wdetail2.product   /*A65-0177*/
               wdetail.tariff      = "X"                /*A65-0177*/
               wdetail.insp        = trim(wdetail2.insp)     /* A66-0252 */
               wdetail.colorcar    = trim(wdetail2.coulor). /* A66-0252 */

           IF  (wdetail2.np_f18line1 <> "") OR (wdetail2.np_f18line2 <> "") OR
               (wdetail2.np_f18line3 <> "") OR (wdetail2.np_f18line4 <> "") OR
               /*(wdetail2.np_f18line5 <> "") OR ---a66-0252 --- */ 
               /* Add by : A66-0252 */
               (wdetail2.np_f18line6 <> "") OR (wdetail2.np_f18line7 <> "") OR 
               (wdetail2.np_f18line8 <> "") OR (wdetail2.np_f18line9 <> "") OR  
               (wdetail2.ispno  <> "" ) OR (wdetail2.detail <> "" ) OR
               (wdetail2.damage <> "" ) OR (wdetail2.ispacc <> "" )THEN DO:
               /* end A66-0252 */
               FIND LAST wdetmemo WHERE wdetmemo.policymemo = wdetail.policy   NO-ERROR NO-WAIT.
               IF NOT AVAIL wdetmemo THEN DO:
                   CREATE wdetmemo.
                   ASSIGN 
                       wdetmemo.policymemo = wdetail.policy  
                       wdetmemo.f18line1   = wdetail2.np_f18line1 
                       wdetmemo.f18line2   = wdetail2.np_f18line2 
                       wdetmemo.f18line3   = wdetail2.np_f18line3 
                       wdetmemo.f18line4   = wdetail2.np_f18line4
                       wdetmemo.f18line5   = "" /*wdetail2.np_f18line5*/ /*A66-0252*/
                       /* Add by :A66-0252 */
                       wdetmemo.f18line6   = wdetail2.np_f18line6
                       wdetmemo.f18line7   = wdetail2.np_f18line7 
                       wdetmemo.f18line8   = wdetail2.np_f18line8
                       wdetmemo.f18line9   = wdetail2.np_f18line9
                       wdetmemo.ispno      = wdetail2.ispno  
                       wdetmemo.detail     = wdetail2.detail 
                       wdetmemo.damage     = wdetail2.damage 
                       wdetmemo.ispacc     = wdetail2.ispacc .
                      /* end :A66-0252 */
               END.
           END.
       END.  /* FIND FIRST wdetail */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign3_72 c-Win 
PROCEDURE proc_assign3_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FIND FIRST wdetail WHERE wdetail.policy = trim(wdetail2.com_no) NO-ERROR NO-WAIT.*/ /*A63-0101*/
FIND FIRST wdetail WHERE wdetail.policy = "VTL" + trim(wdetail2.tpis_no) NO-ERROR NO-WAIT.  /*a63-0101*/
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN
        /*wdetail.policy      = trim(wdetail2.com_no)*/ /*A63-0101*/
        wdetail.policy      = "VTL" + trim(wdetail2.tpis_no)  /*A63-0101*/
        wdetail.brand       = TRIM(wdetail2.brand)
        wdetail.poltyp      = "V72" 
        wdetail.insrefno    = ""
        wdetail.comdat      = TRIM(wdetail2.com_comm_date) 
        wdetail.expdat      = TRIM(wdetail2.com_exp_date)  
        wdetail.tiname      = trim(wdetail2.ntitle)                                                
        wdetail.insnam      = trim(wdetail2.insnam) + " " + TRIM(wdetail2.name2)                   
        /*wdetail.subclass    = IF DECI(wdetail2.com_netprem) = 600 THEN "110" ELSE 
                              IF DECI(wdetail2.com_netprem) <> 0 THEN  "210" ELSE TRIM(wdetail2.CLASS) */ /*A61-0152*/
        wdetail.seat        = IF DECI(wdetail2.com_netprem) = 600 THEN "7"  
                              ELSE IF index(wdetail2.class,"110") <> 0 THEN "7" 
                              ELSE IF index(wdetail2.class,"210") <> 0 THEN "5"
                              ELSE "3"
        /*wdetail.model       = IF index(wdetail2.model,"TFR85HG") <> 0 THEN "MU-7" ELSE "D-MAX"  */ /*A61-0152*/ 
        /* create by A61-0152 */
        wdetail.subclass    = IF LENGTH(wdetail2.CLASS) >= 4 THEN SUBSTR(wdetail2.CLASS,2,3) ELSE trim(wdetail2.CLASS)
        wdetail.model       = TRIM(wdetail2.model) 
        wdetail.engine      = nv_cc
        /*end A61-0152*/
        wdetail.cc          = trim(wdetail2.cc)                                                    
        wdetail.ton         = IF index(wdetail2.class,"320") <> 0 OR index(wdetail2.class,"420") <> 0 OR index(wdetail2.class,"520") <> 0  THEN TRIM(wdetail2.cc) ELSE ""  /*A68-0019*/
        wdetail.weight      = IF index(wdetail2.class,"320") <> 0 OR index(wdetail2.class,"420") <> 0 OR index(wdetail2.class,"520") <> 0  THEN TRIM(wdetail2.cc) ELSE ""  /*A68-0019*/
        wdetail.caryear     = trim(wdetail2.md_year) 
        /*wdetail.caryear     = trim(wdetail2.regis_year)   A66-0252*/                                               
        wdetail.chasno      = trim(wdetail2.chasno)                                                
        wdetail.vehreg      = trim(wdetail2.License) + " " + trim(wdetail2.regis_cl)                                                 
        wdetail.engno       = trim(wdetail2.engno)                                                 
        wdetail.iadd1       = trim(wdetail2.mail_hno)                  /*wdetail2.address*/                                                     
        wdetail.iadd2       = trim(wdetail2.mail_tambon)               /*wdetail2.tambon */                                                     
        wdetail.iadd3       = trim(wdetail2.mail_amper)                /*wdetail2.amper  */                                                     
        wdetail.iadd4       = trim(wdetail2.mail_country)              /*wdetail2.country*/
        wdetail.post        = TRIM(wdetail2.mail_post)
        wdetail.address     = trim(wdetail2.address)        
        wdetail.tambon      = trim(wdetail2.tambon)         
        wdetail.amper       = trim(wdetail2.amper)          
        wdetail.country     = trim(wdetail2.country)        
        wdetail.vehuse      = "1"
        wdetail.garage      = ""
        wdetail.ICNO        = trim(wdetail2.ICNO)       /*A56-0217*/
        wdetail.stk         = TRIM(wdetail2.stkno)   
        /*wdetail.docno     = "" /*trim(wdetail2.docno) */     /*A56-0217*/*/ /*****Block By Nontamas H. [A62-0329] Date 04/07/2019*****/
        wdetail.docno       = trim(wdetail2.docno)         /*****Add By Nontamas H. [A62-0329] Date 04/07/2019*****/
        wdetail.covcod      = "T" 
        wdetail.instyp      = "" /*trim(wdetail2.instyp)*/     /*A57-0302*/
        wdetail.si          = trim(wdetail2.si) 
        wdetail.prempa      = trim(fi_pack)
        /*wdetail.branch      = "M" */               /*A63-0101*/
        wdetail.branch      = TRIM(wdetail2.branch)  /*A63-0101*/
        /*wdetail.benname     = "บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด"*/ /*A57-0010*/
        wdetail.benname     = TRIM(wdetail2.financename) 
        /*wdetail.volprem     = wdetail2.ref_no *//*A56-0217*/
        wdetail.volprem     = TRIM(wdetail2.com_gprem)  /*A61-0152*/
        wdetail.comment     = ""
        /*wdetail.agent       = trim(fi_agent72)   */ /*A61-0152*/
        wdetail.agent       = TRIM(fi_agent)          /*A61-0152*/
        /*wdetail.producer    = trim(fi_producer72) */ /*A61-0152*/
        wdetail.producer    = IF wdetail2.producer <> "" THEN trim(wdetail2.producer) ELSE trim(fi_producer72) /*A61-0152*/ 
        wdetail.entdat      = string(TODAY)             /*entry date*/
        wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
        wdetail.trandat     = STRING(TODAY)             /*tran date*/
        wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
        wdetail.n_IMPORT    = "IM"
        wdetail.n_EXPORT    = "" 
        /*wdetail.inscod      = wdetail2.typepay  */  
        wdetail.cedpol      = trim(wdetail2.tpis_no) 
        wdetail.remark      = TRIM(wdetail2.remark1)
        /*wdetail.promo       = "TIL"*/
         wdetail.promo       = TRIM(wdetail2.bus_typ) /*A61-0152*/
        wdetail.nDirec      = IF trim(wdetail2.cust_type) = "J" THEN TRIM(wdetail2.nDirec) ELSE ""
        wdetail.cuts_typ    = TRIM(wdetail2.cust_type)
        wdetail.occup       = TRIM(n_occupn)
        wdetail.finint      = TRIM(wdetail2.delerco) /*A61-0152*/
        wdetail.seat41      = INT(wdetail.seat) /*A61-0152*/
        /*wdetail.sendnam     = trim(wdetail2.sendnam)  
        wdetail.chkcar      = trim(wdetail2.chkcar)   
        wdetail.telno       = trim(wdetail2.telno)  
        wdetail.prmtxt      = ""*/  
        wdetail.firstName   = trim(wdetail2.insnam)  /*Add by Kridtiya i. A63-0472*/
        wdetail.lastName    = TRIM(wdetail2.NAME2)   /*Add by Kridtiya i. A63-0472*/
        wdetail.postcd      = wdetail2.mail_post     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeocc     = wdetail2.codeocc       /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr1   = wdetail2.codeaddr1     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr2   = wdetail2.codeaddr2     /*Add by Kridtiya i. A63-0472*/
        wdetail.codeaddr3   = wdetail2.codeaddr3     /*Add by Kridtiya i. A63-0472*/
        wdetail.br_insured  = "00000"                /*Add by Kridtiya i. A63-0472*/
        wdetail.tariff      = "9"                   /*A65-0177*/
        wdetail.colorcar    = trim(wdetail2.coulor). /* A66-0252 */

       /* Add by : A66-0252 */
       IF (wdetail2.np_f18line1 <> "") OR (wdetail2.np_f18line2 <> "") OR (wdetail2.np_f18line3 <> "") OR (wdetail2.np_f18line4 <> "") OR
          /*(wdetail2.np_f18line5 <> "") OR*/ (wdetail2.np_f18line6 <> "") OR (wdetail2.np_f18line7 <> "") OR (wdetail2.np_f18line8 <> "") OR 
          (wdetail2.np_f18line9 <> "") OR (wdetail2.ispno  <> "" )     OR (wdetail2.detail <> "" )     OR (wdetail2.damage <> "" )     OR 
          (wdetail2.ispacc <> "" )THEN DO:
          FIND LAST wdetmemo WHERE wdetmemo.policymemo = wdetail.policy  NO-ERROR NO-WAIT.
          IF NOT AVAIL wdetmemo THEN DO:
            CREATE wdetmemo.
            ASSIGN wdetmemo.policymemo = wdetail.policy
            wdetmemo.f18line1   = wdetail2.np_f18line1 
            wdetmemo.f18line2   = wdetail2.np_f18line2 
            wdetmemo.f18line3   = wdetail2.np_f18line3 
            wdetmemo.f18line4   = wdetail2.np_f18line4
            wdetmemo.f18line5   = "" /*wdetail2.np_f18line5*/ 
            wdetmemo.f18line6   = wdetail2.np_f18line6  
            wdetmemo.f18line7   = wdetail2.np_f18line7  
            wdetmemo.f18line8   = wdetail2.np_f18line8  
            wdetmemo.f18line9   = wdetail2.np_f18line9
            wdetmemo.ispno      = wdetail2.ispno  
            wdetmemo.detail     = wdetail2.detail 
            wdetmemo.damage     = wdetail2.damage 
            wdetmemo.ispacc     = wdetail2.ispacc .
            
          END.
        END.
        /* end :A66-0252 */

END.                          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignredbook c-Win 
PROCEDURE proc_assignredbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail.seat = "" THEN DO:                                                                                              
    IF wdetail.cc = "" THEN DO:                                                                                              
        Find First stat.maktab_fil USE-INDEX maktab04    Where                                                                
        stat.maktab_fil.makdes   =  trim(wdetail.brand)  And                                                       
        index(stat.maktab_fil.moddes,n_model) <> 0       And                                                             
        stat.maktab_fil.makyea   =  Integer(wdetail.caryear)             AND                                   
        stat.maktab_fil.sclass   =  SUBSTR(wdetail.subclass,2,3)         AND                                                       
        (stat.maktab_fil.si - (stat.maktab_fil.si * nv_maxSI / 100 ) LE deci(wdetail.si)    AND                              
         stat.maktab_fil.si + (stat.maktab_fil.si * nv_minSI / 100 ) GE deci(wdetail.si) ) No-lock no-error no-wait.        
        If  avail stat.maktab_fil  THEN                                                                                         
            ASSIGN                                                                                                              
            wdetail.redbook  =  stat.maktab_fil.modcod                                                                          
            /*wdetail.brand    =  stat.maktab_fil.makdes                                                                        
            n_model    =  stat.maktab_fil.moddes*/                                                                              
            wdetail.cargrp     =  stat.maktab_fil.prmpac                                                                          
            wdetail.body       =  IF wdetail.body    = "" THEN stat.maktab_fil.body           ELSE wdetail.body                     
            wdetail.weight     =  IF wdetail.weight  = "" THEN STRING(stat.maktab_fil.tons)   ELSE wdetail.weight                     
            wdetail.cc         =  IF wdetail.cc      = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.cc                    
            wdetail.cargrp     =  stat.maktab_fil.prmpac                                                                      
            wdetail.seat       =  IF wdetail.seat    = "" THEN string(stat.maktab_fil.seats)  ELSE wdetail.seat  .                    
        ELSE wdetail.redbook   = "".                                                                                             
    END.                                                                                                                        
    ELSE DO:                                                                                                                    
        Find First stat.maktab_fil USE-INDEX maktab04       Where                                                                  
            stat.maktab_fil.makdes   =  trim(wdetail.brand) And                                                   
            index(stat.maktab_fil.moddes,n_model) <> 0      And                                                         
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)  AND                                                   
            stat.maktab_fil.engine   =  deci(wdetail.cc)          AND                                                   
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.subclass,2,3)       AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * nv_maxSI / 100 ) LE deci(wdetail.si)    AND                        
             stat.maktab_fil.si + (stat.maktab_fil.si * nv_minSI / 100 ) GE deci(wdetail.si) ) No-lock no-error no-wait.   
        If  avail stat.maktab_fil  THEN                                                                                         
            ASSIGN                                                                                                              
            wdetail.redbook  =  stat.maktab_fil.modcod                                                                          
            /*wdetail.brand  =  stat.maktab_fil.makdes                                                                        
            wdetail.model    =  stat.maktab_fil.moddes*/                                                                        
            wdetail.cargrp   =  stat.maktab_fil.prmpac                                                                          
            wdetail.body     =  IF wdetail.body    = "" THEN stat.maktab_fil.body           ELSE wdetail.body                     
            wdetail.weight   =  IF wdetail.weight  = "" THEN STRING(stat.maktab_fil.tons)   ELSE wdetail.weight                     
            wdetail.cc       =  IF wdetail.cc      = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.cc                    
            wdetail.cargrp   =  stat.maktab_fil.prmpac                                                          
            wdetail.seat     =  IF wdetail.seat    = "" THEN string(stat.maktab_fil.seats)  ELSE wdetail.seat  .                    
        ELSE wdetail.redbook = "".                                                                                             
    END.                                                                                                                        
END.                                                                                                                            
ELSE DO:                                                                                                                        
    IF wdetail.cc = "" THEN DO:                                                                                              
        Find First stat.maktab_fil USE-INDEX maktab04    Where                                                                  
        stat.maktab_fil.makdes   =  trim(wdetail.brand)  And                                                       
        index(stat.maktab_fil.moddes,n_model) <> 0       And                                                             
        stat.maktab_fil.makyea   =  Integer(wdetail.caryear)     AND                                                       
        /*stat.maktab_fil.engine   =  deci(wdetail.engcc)        AND*/                                                   
        stat.maktab_fil.sclass   =  SUBSTR(wdetail.subclass,2,3) AND 
        (stat.maktab_fil.si - (stat.maktab_fil.si * nv_maxSI / 100 ) LE deci(wdetail.si)    AND                        
         stat.maktab_fil.si + (stat.maktab_fil.si * nv_minSI / 100 ) GE deci(wdetail.si) )  AND
        stat.maktab_fil.seats    >=    DECI(wdetail.seat)       No-lock no-error no-wait.                                       
        If  avail stat.maktab_fil  THEN                                                                                         
            ASSIGN                                                                                                              
            wdetail.redbook  =  stat.maktab_fil.modcod                                                                          
            /*wdetail.brand  =  stat.maktab_fil.makdes                                                                        
            wdetail.model    =  stat.maktab_fil.moddes*/                                                                        
            wdetail.cargrp   =  stat.maktab_fil.prmpac                                                              
            wdetail.body     =  IF wdetail.body    = "" THEN stat.maktab_fil.body           ELSE wdetail.body                     
            wdetail.weight   =  IF wdetail.weight  = "" THEN STRING(stat.maktab_fil.tons)   ELSE wdetail.weight                     
            wdetail.cc       =  IF wdetail.cc      = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.cc                    
            wdetail.cargrp   =  stat.maktab_fil.prmpac                                                              
            wdetail.seat     =  IF wdetail.seat    = "" THEN string(stat.maktab_fil.seats)  ELSE wdetail.seat  .                    
        ELSE wdetail.redbook = "".                                                                                             
    END.                                                                                                                        
    ELSE DO:                                                                                                                    
        Find First stat.maktab_fil USE-INDEX maktab04           Where                                                                  
            stat.maktab_fil.makdes   =  trim(wdetail.brand)     And                                                   
            index(stat.maktab_fil.moddes,n_model) <> 0          And                                                         
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)    AND                                                   
            stat.maktab_fil.engine   =  deci(wdetail.cc)            AND                                                   
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.subclass,2,3)   AND                                                   
            (stat.maktab_fil.si - (stat.maktab_fil.si * nv_maxSI / 100 ) LE deci(wdetail.si)    AND                        
             stat.maktab_fil.si + (stat.maktab_fil.si * nv_minSI / 100 ) GE deci(wdetail.si) )  AND
            stat.maktab_fil.seats    >=    DECI(wdetail.seat)       No-lock no-error no-wait.                                   
        If  avail stat.maktab_fil  THEN                                                                                         
            ASSIGN                                                                                                              
            wdetail.redbook  =  stat.maktab_fil.modcod                                                                          
            /*wdetail.brand  =  stat.maktab_fil.makdes                                                                        
            wdetail.model    =  stat.maktab_fil.moddes*/                                                                        
            wdetail.cargrp   =  stat.maktab_fil.prmpac                                                                          
            wdetail.body     =  IF wdetail.body     = "" THEN stat.maktab_fil.body           ELSE wdetail.body                     
            wdetail.weight   =  IF wdetail.weight   = "" THEN STRING(stat.maktab_fil.tons)   ELSE wdetail.weight                     
            wdetail.cc       =  IF wdetail.cc       = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.cc                    
            wdetail.cargrp   =  stat.maktab_fil.prmpac                                                           
            wdetail.seat     =  IF wdetail.seat     = "" THEN string(stat.maktab_fil.seats)  ELSE wdetail.seat.                      
        ELSE wdetail.redbook = "".                                                                                             
    END.
END.
    END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew c-Win 
PROCEDURE proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_benname  AS CHAR FORMAT "x(50)".
DEF VAR nv_status  AS CHAR FORMAT "x(5)".
DEF VAR nv_renpol  AS CHAR FORMAT "x(13)".
DEF VAR nv_prmtxt  AS CHAR FORMAT "x(200)".
DEF VAR nv_bran    AS CHAR FORMAT "X(2)".
DEF VAR nv_insref  AS CHAR FORMAT "x(10)" .
DEF VAR nv_branold AS CHAR FORMAT "x(10)" .
DEF VAR nv_productold AS CHAR FORMAT "x(30)" .
ASSIGN 
    n_benname   = "" 
    n_policy    = ""
    np_prepol   = ""
    n_body      = ""
    nn_redbook  = ""
    n_Engine    = ""
    n_Tonn70    = 0
    nv_status   = ""
    nv_renpol   = ""
    nv_prmtxt   = ""
    nv_bran     = ""    /*A61-0152*/
    nv_insref   = ""    /*A61-0152*/
    nv_productold = "".
RUN proc_assignrenew_inipol.
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    /*RUN wgw\wgwtilexp(INPUT-OUTPUT wdetail.prvpol, */              
    RUN wgw\wgwtpiexp(INPUT-OUTPUT wdetail.prvpol, 
                     INPUT-OUTPUT  nv_branold,      /* wdetail.branch, *//* A63-00472 */           
                     INPUT-OUTPUT  wdetail.insrefno,
                     INPUT-OUTPUT  nv_deler,                 
                     INPUT-OUTPUT  re_firstdat,               
                     INPUT-OUTPUT  re_comdat,                
                     INPUT-OUTPUT  re_expdat,                
                     INPUT-OUTPUT  wdetail.prempa,           
                     INPUT-OUTPUT  re_class,                 
                     INPUT-OUTPUT  nn_redbook,               
                     INPUT-OUTPUT  re_moddes,                
                     INPUT-OUTPUT  re_yrmanu,                
                     INPUT-OUTPUT  wdetail.cargrp,           
                     INPUT-OUTPUT  n_body,                   
                     INPUT-OUTPUT  n_Engine,                 
                     INPUT-OUTPUT  n_Tonn70,                       
                     INPUT-OUTPUT  re_seats,                       
                     INPUT-OUTPUT  re_vehuse,                      
                     INPUT-OUTPUT  re_covcod,                      
                     INPUT-OUTPUT  re_garage,                      
                     INPUT-OUTPUT  re_vehreg,                      
                     INPUT-OUTPUT  re_cha_no,                      
                     INPUT-OUTPUT  re_eng_no,                      
                     INPUT-OUTPUT  re_uom1_v,                      
                     INPUT-OUTPUT  re_uom2_v,                      
                     INPUT-OUTPUT  re_uom5_v,                      
                     INPUT-OUTPUT  re_si,                          
                     INPUT-OUTPUT  re_baseprm, 
                     INPUT-OUTPUT  re_baseprm3, /*A61-0152*/
                     INPUT-OUTPUT  re_41,                          
                     INPUT-OUTPUT  re_42,                          
                     INPUT-OUTPUT  re_43,                          
                     INPUT-OUTPUT  re_seat41,                      
                     INPUT-OUTPUT  re_dedod,                       
                     INPUT-OUTPUT  re_addod,                       
                     INPUT-OUTPUT  re_dedpd,                       
                     INPUT-OUTPUT  re_flet_per,                    
                     INPUT-OUTPUT  re_ncbper,                      
                     INPUT-OUTPUT  re_dss_per,                     
                     INPUT-OUTPUT  re_stf_per,                     
                     INPUT-OUTPUT  re_cl_per,
                     INPUT-OUTPUT  re_prem, /*A61-0152*/
                     INPUT-OUTPUT  n_benname,                      
                     INPUT-OUTPUT  nv_prmtxt,                 
                     INPUT-OUTPUT  nv_driver,
                     INPUT-OUTPUT  nv_status,    
                     INPUT-OUTPUT  nv_renpol,
                     INPUT-OUTPUT  nv_cctv,
                     INPUT-OUTPUT  nv_productold ).
END.


ASSIGN np_prepol  =  wdetail.prvpol
       n_policy   =  wdetail.cr_2
       nv_bran    =  trim(wdetail.branch)      /*A61-0152*/
       nv_insref  =  trim(wdetail.insrefno) .  /*A61-0152*/
       /*wdetail.volprem = STRING(re_prem) .*/ /* A65-0177*/
IF nv_productold <> "" THEN DO:
    IF index(nv_productold,"P1") <> 0 OR index(nv_productold,"P2") <> 0 OR
       index(nv_productold,"P3") <> 0 OR index(nv_productold,"P4") <> 0 THEN wdetail.product = trim(nv_productold).
END.

/* add by : A6-0344 */
FIND LAST stat.insure USE-INDEX insure01 WHERE 
          stat.insure.compno  = "TPIS-BR" AND 
          stat.insure.branch  = nv_bran   NO-LOCK NO-ERROR .
    IF AVAIL stat.insure THEN DO:
        ASSIGN  wdetail.branch = trim(stat.insure.vatcode) .
    IF nv_bran <> wdetail.branch THEN             
        ASSIGN  nv_insref = ""           
                wdetail.insrefno = "". 
END.
/* end : A6-0344 */

/*Saowapa U.A62-0186 23/05/2019*/
IF wdetail.cr_2 <> "" THEN DO: /* ใส่ข้อมูลให้ พรบ. */
   FIND LAST wdetail WHERE wdetail.policy = n_policy AND wdetail.covcod = "T" NO-LOCK no-error .
    IF AVAIL wdetail THEN DO:
        ASSIGN wdetail.subclass   =  re_class    
               wdetail.body       =  n_body    
               wdetail.cc         =  n_engine  
               wdetail.redbook    =  nn_redbook
               /*wdetail.brand      =  re_moddes */ /*A61-0152*/
               wdetail.caryear    =  re_yrmanu     
               wdetail.seat       =  re_seats  
               wdetail.vehuse     =  re_vehuse 
               wdetail.covcod     =  re_covcod 
               wdetail.insrefno   =  nv_insref . /*A63-0101*/
       /* IF nv_bran = "M" THEN ASSIGN wdetail.insrefno = nv_insref .*/ /*A61-0152*/ /*A63-0101*/
   END.
END.

FIND LAST wdetail WHERE wdetail.prvpol = np_prepol AND wdetail.covcod <> "T"  NO-LOCK NO-ERROR . /* ใส่ข้อมูลให้ กธ. */
IF AVAIL wdetail THEN DO:
   ASSIGN  wdetail.insrefno = nv_insref         /*a63-0101*/
           n_firstdat       =  DATE(re_firstdat)
           wdetail.subclass = re_class           
           wdetail.redbook  = nn_redbook         
           /*wdetail.model    = re_moddes  */ /*A61-0152*/                           
           wdetail.caryear  = re_yrmanu 
           wdetail.body     = n_body             
           wdetail.cc       = n_Engine           
           /*nv_tons          = n_Tonn70                                                  /*A66-0252*/
           wdetail.weight   = string(n_tonn70)*/ /*A63-0113*/                             /*A66-0252*/
           wdetail.weight   = IF n_Tonn70 <> 0 THEN string(n_tonn70) ELSE  wdetail.weight /*A66-0252*/
           nv_tons          = IF n_Tonn70 <> 0 THEN n_tonn70 ELSE  deci(wdetail.weight) /*A66-0252*/
           wdetail.seat     = re_seats           
           wdetail.vehuse   = re_vehuse          
           wdetail.covcod   = re_covcod          
           wdetail.garage   = re_garage 
           nv_uom1_v        = DECI(re_uom1_v)          
           nv_uom2_v        = DECI(re_uom2_v)          
           nv_uom5_v        = DECI(re_uom5_v) 
           wdetail.deductpp = re_uom1_v /*A61-0152*/   
           wdetail.deductba = re_uom2_v /*A61-0152*/   
           wdetail.deductpa = re_uom5_v /*A61-0152*/
           wdetail.si       = re_si              
           nv_basere        = re_baseprm
           wdetail.base3    = string(re_baseprm3)
           wdetail.netprem  = STRING(re_prem)
           nv_41            = re_41              
           nv_42            = re_42              
           nv_43            = re_43 
           wdetail.no_411   = string(re_41)  /*A61-0152*/
           wdetail.no_42    = string(re_42)  /*A61-0152*/
           wdetail.no_43    = string(re_43)  /*A61-0152*/
           wdetail.seat41   = re_seat41          
           dod1             = re_dedod     /*"dod" */     
           dod2             = re_addod     /*"dod2"*/     
           dod0             = re_dedpd     /*"dpd" */     
           wdetail.fleet    = re_flet_per 
           wdetail.NCB      = re_ncbper         
           /*nv_dss_per       = DECI(re_dss_per)   */ /*A61-0152*/
           wdetail.dspc     = re_dss_per /* A61-0152*/
           nv_stf_per       = re_stf_per       
           nv_cl_per        = re_cl_per
           wdetail.loadclm  = string(re_cl_per)     /*A61-0152*/
           wdetail.staff    = string(re_stf_per)   /*A61-0152*/
           /*wdetail.prmtxt   = IF nv_prmtxt <> "" THEN trim(wdetail.prmtxt + " " + TRIM(nv_prmtxt)) ELSE wdetail.prmtxt. */ /*A65-0177*/
           wdetail.prmtxt   = IF wdetail.prmtxt = "" THEN TRIM(nv_prmtxt) ELSE trim(wdetail.prmtxt).     /*A65-0177*/
           /*Saowapa U. A62-0110 25/02/2019*/
            IF wdetail.promo   = "CV" THEN  DO:      
                wdetail.model  = re_moddes.    
            END.  
           IF DATE(wdetail.comdat) >= 04/01/2020 THEN DO:  /*A64-0344*/
                IF      trim(wdetail.prempa) = "A" THEN ASSIGN wdetail.prempa = "A".  /*A64-0344*/
                ELSE IF trim(wdetail.prempa) = "U" THEN ASSIGN wdetail.prempa = "U".  /*A64-0344*/
                ELSE ASSIGN wdetail.prempa = "T".
            END.
            /* end : A63-0113 */
END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew_inipol c-Win 
PROCEDURE proc_assignrenew_inipol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  
    n_policy72     = ""
    np_prepol      = ""
    n_brand1       = ""
    n_body         = ""
    nn_redbook     = ""
    n_Engine       = ""
    n_Tonn70       = 0.00
    re_branch      = ""
    n_firstdat     = ?
    re_firstdat    = ""
    re_comdat      = ""                          
    re_expdat      = ""                          
    re_class       = ""                          
    re_moddes      = ""                          
    re_yrmanu      = ""                          
    re_seats       = ""                      
    re_vehuse      = ""                     
    re_covcod      = ""                     
    re_garage      = ""                     
    re_vehreg      = ""                     
    re_cha_no      = ""                     
    re_eng_no      = ""                     
    re_uom1_v      = ""                    
    re_uom2_v      = ""                    
    re_uom5_v      = ""                    
    re_si          = ""                     
    re_baseprm     = 0                      
    re_41          = 0                      
    re_42          = 0                      
    re_43          = 0                      
    re_seat41      = 0                      
    re_dedod       = 0                      
    re_addod       = 0                      
    re_dedpd       = 0                      
    re_flet_per    = ""                     
    re_ncbper      = ""                     
    re_dss_per     = ""                     
    re_stf_per     = 0                      
    re_cl_per      = 0                      
    re_bennam1     = ""  
    nv_tons        = 0  
    nv_uom1_v      = 0 
    nv_uom2_v      = 0 
    nv_uom5_v      = 0 
    nv_basere      = 0 
    nv_41          = 0 
    nv_42          = 0 
    nv_43          = 0 
    dod1           = 0 
    dod2           = 0 
    dod0           = 0 
    nv_dss_per     = 0 
    nv_stf_per     = 0 
    nv_cl_per      = 0 
    re_baseprm3    = 0
    re_prem        = 0
    nv_cctv        = "". /*A61-0416*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2 c-Win 
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
    IF wdetail.prvpol = "" THEN DO:
        IF deci(wdetail.base) <> 0 THEN ASSIGN nv_baseprm = deci(wdetail.base) . /*A61-0152*/
        ELSE  RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ELSE 
        ASSIGN aa      = nv_basere
            nv_baseprm = nv_basere .  
    ASSIGN chk = NO
        nv_baseprm = aa
        NO_basemsg = " " .
    IF nv_drivno = 0 THEN
        Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN nv_drivvar  = " "
            nv_drivvar     = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END. 
   
    /*-------nv_baseprm----------*/
    IF NO_basemsg <> " " THEN 
        wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN  nv_basevar = "" 
        nv_prem1   = nv_baseprm
        nv_basecod = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    ASSIGN  nv_41 = 0
            nv_42 = 0
            nv_43 = 0
            nv_41 = deci(wdetail.no_411)  
            nv_42 = deci(wdetail.no_42)
            nv_43 = deci(wdetail.no_43) .
       
  
    nv_411var = "" .   /*A61-0152*/
    nv_412var = "" .   /*A61-0152*/
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
    /* -------fi_42---------*/
    nv_42var    = " ".     
    Assign
        nv_42cod   = "42".
    nv_42var1  = "     Medical Expense = ".
    nv_42var2  = STRING(nv_42).
    SUBSTRING(nv_42var,1,30)   = nv_42var1.
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
    ASSIGN nv_usevar = ""
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
     ASSIGN nv_grpvar = ""
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
         /*nv_bipvar2     =  STRING(uwm130.uom1_v) */ /*A61-0152*/  
         nv_bipvar2     =  TRIM(wdetail.deductpp)  /*A61-0152*/      
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1                   
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     nv_biavar = "" .
     Assign 
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         /*nv_biavar2     =   STRING(uwm130.uom2_v)*/ /*A61-0152*/
         nv_biavar2     =  TRIM(wdetail.deductba)  /*A61-0152*/
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     nv_pdavar = "" .
     Assign
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         /*nv_pdavar2     =  STRING(uwm130.uom5_v)*/ /*A61-0152*/
         nv_pdavar2     =  TRIM(wdetail.deductpa) /*A61-0152*/
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
      ASSIGN  nv_dedod1var = ""  
          nv_odcod = "DC01"
          nv_prem  =   dod1.        
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
          ASSIGN
              wdetail.pass    = "N"
              wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
          /*NEXT.*/
      END.
      IF dod1 <> 0  THEN
       ASSIGN nv_dedod1var = ""
           nv_ded1prm       = nv_prem
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
      IF dod2 <> 0  THEN
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
        nv_ded   = dod0.
      IF dpd0 <> 0  THEN 
        ASSIGN
          nv_dedpd_cod   = "DPD"
          nv_dedpdvar1   = "     Deduct PD = "
          nv_dedpdvar2   =  STRING(dod0)
          SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
          SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2.
      /*---------- fleet -------------------*/
      nv_flet_per = 0.
      nv_flet_per =    INTE(wdetail.fleet) .
      IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
          Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
          ASSIGN
              wdetail.pass    = "N"
              wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
          /*NEXT.  *//*a490166*/
      END.
      IF nv_flet_per = 0 Then do:
          Assign
              nv_flet     = 0
              nv_fletvar  = " ".
      END.
      IF nv_flet_per <> 0 Then
      ASSIGN
          nv_fletvar                  = " "
          nv_fletvar1                 = "     Fleet % = "
          nv_fletvar2                 =  STRING(nv_flet_per)
          SUBSTRING(nv_fletvar,1,30)  = nv_fletvar1
          SUBSTRING(nv_fletvar,31,30) = nv_fletvar2.
      IF nv_flet   = 0  THEN
          nv_fletvar  = " ".
      /*---------------- NCB -------------------*/
      /*IF wdetail.covcod = "3" THEN WDETAIL.NCB = "30".*/
      NV_NCBPER = 0 .
      ASSIGN 
          NV_NCBPER  = INTE(WDETAIL.NCB)
          nv_ncb     = INTE(WDETAIL.NCB)
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
          END.
          ASSIGN
              nv_ncbper = xmm104.ncbper   
              nv_ncbyrs = xmm104.ncbyrs.
      END.
      Else do:  
          Assign
              nv_ncbyrs  =   0
              nv_ncbper  =   0
              nv_ncb     =   0.
      END.
      
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     /*-------------- load claim ---------------------*/
     nv_cl_per  = 0.
     nv_cl_per  = deci(wdetail.loadclm).
     nv_clmvar  = " ".
     IF nv_cl_per  <> 0  THEN
         Assign 
         nv_clmvar1   = " Load Claim % = "
         nv_clmvar2   =  STRING(nv_cl_per)
         SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
         SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
     
     /*-------------- dspc----------------*/
     nv_dss_per = 0.                    /*A61-0152*/
     nv_dsspcvar = "" .
     nv_dss_per = deci(wdetail.dspc) .  /*A61-0152*/
     IF  nv_dss_per   <> 0  THEN
         Assign nv_dsspcvar = ""
         nv_dsspcvar1   = "     Discount Special % = "
         nv_dsspcvar2   =  STRING(nv_dss_per)
         SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
         SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
     /*--------------------------*/
    /*------------------ stf ---------------*/
    nv_stf_per  = 0 .
    nv_stfvar   = " ".
    nv_stf_per  = DECI(wdetail.staff). /*A60-0152*/
    IF  nv_stf_per   <> 0  THEN
       ASSIGN nv_stfvar1   = "     Discount Staff"          
             nv_stfvar2   =  STRING(nv_stf_per)           
             SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1    
             SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2. 
    /*--------------------------*/                        
 

    ASSIGN fi_process = "out base2 " + wdetail.policy.
    DISP fi_process WITH FRAM fr_main.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_baseplus c-Win 
PROCEDURE proc_baseplus :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by : Ranu I. A64-0344       
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "v70" THEN DO:
    /*Saowapa U. A62-0186*/
    IF wdetail.prvpol <> ""  THEN DO:
       wdetail.base = STRING(nv_basere).
    END.
    /*End Saowapa U. A62-0186*/
    ASSIGN fi_process = "Create data to base..." + wdetail.policy 
        nv_baseprm    = 0
        nv_baseprm    = DECI(wdetail.base)    .
    IF wdetail.base = "" OR DECI(wdetail.base) = 0  THEN DO:
        IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR
           (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN DO: 
            RUN wgs\wgsfbas.
        END.
    END.
    DISP fi_process WITH FRAM fr_main.
    IF nv_baseprm = 0  THEN DO: 
        RUN wgs\wgsfbas.
    END.
    ASSIGN chk = NO
        NO_basemsg = " " .
    If nv_drivno  = 0  Then 
        Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN  wdetail.pass = "N"
                wdetail.comment  = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN  nv_drivvar = ""
            nv_drivvar = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.
    /*-------nv_baseprm----------*/
    IF NO_basemsg <> " " THEN  wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail.pass = "N"
        wdetail.comment      = wdetail.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN  nv_basevar = ""
        nv_prem1 = nv_baseprm
        nv_basecod  = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    IF wdetail.prvpol <> "" THEN  
    ASSIGN 
        nv_41 = deci(wdetail.no_411) 
        nv_42 = deci(wdetail.no_42)
        nv_43 = deci(wdetail.no_43)      
        nv_seat41 = 0 
        nv_seat41 = IF wdetail.seat41  = 0 THEN deci(wdetail.seat) ELSE wdetail.seat41.

    nv_411var = "" . /* A61-0152*/
    nv_412var = "" . /* A61-0152*/
    ASSIGN 
        nv_41     =  deci(wdetail.no_411)  
        nv_41cod1 = "411"
        nv_411var1   = "     PA Driver = "
        nv_411var2   =  STRING(nv_41)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"       /* 412 412 412 412 .........................*/
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(nv_41)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_41
        nv_412prm  = nv_41.
    nv_42var    = " ".       /* -------fi_42---------*/
    Assign
        nv_42cod   = "42" 
        nv_42var1  = "     Medical Expense = " 
        nv_42var2  = STRING(nv_42) 
        SUBSTRING(nv_42var,1,30)   = nv_42var1 
        SUBSTRING(nv_42var,31,30)  = nv_42var2 
    nv_43var    = " ".        /*---------fi_43--------*/
    Assign
        nv_43prm   = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
     
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
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
        Substr(nv_yrvar,1,30)    = nv_yrvar1
        Substr(nv_yrvar,31,30)   = nv_yrvar2.  
    /*-----nv_sicod----------------------------*/ 
    nv_sivar = "" .
    Assign  nv_totsi = 0
        nv_sicod     = "SI"
        nv_sivar1    = "     Own Damage = "
        nv_sivar2    =  wdetail.si
        SUBSTRING(nv_sivar,1,30)  = nv_sivar1
        SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
        nv_totsi     =  DECI(wdetail.si).
    /*----------nv_grpcod--------------------*/
    ASSIGN nv_grpvar = ""
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
        nv_bipvar2     =  wdetail.deductpp    /*STRING(uwm130.uom1_v)*/
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    nv_biavar = "" .
    Assign 
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     =  wdetail.deductba     /* STRING(uwm130.uom2_v)*/
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*Add kridtiya i.  2+ 3 */
    IF      (wdetail.covcod = "2.1")   THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "21" .
    ELSE IF (wdetail.covcod = "2.2")   THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "22" .
    ELSE IF (wdetail.covcod = "3.1")  THEN  nv_usecod3 = "U" + TRIM(nv_vehuse) + "31" .
    ELSE nv_usecod3 = "U" + TRIM(nv_vehuse) + "32" .

    ASSIGN  nv_usevar3 = ""  
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
    nv_pdavar = "" .
    Assign
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     =  wdetail.deductpa         /*STRING(uwm130.uom5_v)*/
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
   /*--------------- deduct ----------------*/
    
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1")  THEN ASSIGN dod1 = 2000 .   /*A57-0126*/
    
        ASSIGN nv_dedod1var = ""
               nv_odcod    = "DC01"
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
        IF dod1 <> 0 THEN 
        ASSIGN nv_ded1prm     = nv_prem
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
        IF dod2 <> 0  THEN
        Assign
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   =  STRING(dod2)
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2.
        /***** pd *******/
        Assign
            nv_dedpdvar  = " "
            nv_cons  = "PD"
            nv_ded   = dod0.
        IF dod0 <> 0 THEN
        ASSIGN
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(dod0)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2.
    
    /*---------- fleet -------------------*/
    ASSIGN nv_fletvar = ""
        nv_flet_per = 0
        nv_flet_per = DECI(wdetail.fleet) .
    IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
        Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
        ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
    END.
    IF nv_flet_per = 0 Then do:
        ASSIGN nv_flet     = 0
            nv_fletvar  = " ".
    END.
    IF nv_flet_per <>  0 Then
    ASSIGN
        nv_fletvar                  = " "
        nv_fletvar1                 = "     Fleet % = "
        nv_fletvar2                 =  STRING(nv_flet_per)
        SUBSTRING(nv_fletvar,1,30)  = nv_fletvar1
        SUBSTRING(nv_fletvar,31,30) = nv_fletvar2.
    IF nv_flet   = 0  THEN  nv_fletvar  = " ".
    /*---------------- NCB -------------------*/
    /*IF wdetail.covcod = "3" THEN WDETAIL.NCB = "30".*/
    ASSIGN NV_NCBPER = 0 
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
    nv_ncbvar   = " ".
    IF  nv_ncb <> 0  THEN
        ASSIGN 
        nv_ncbvar1   = "     NCB % = "
        nv_ncbvar2   =  STRING(nv_ncbper)
        SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
        SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
    /*-------------- load claim ---------------------*/
    nv_cl_per  = 0.
    nv_clmvar  = " ".
    nv_cl_per  = DECI(wdetail.loadclm).
    IF nv_cl_per  <> 0  THEN
        Assign 
        nv_clmvar1   = " Load Claim % = "
        nv_clmvar2   =  STRING(nv_cl_per)
        SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
   
    /*------------------ dsspc ---------------*/
    ASSIGN nv_dsspcvar = ""
        nv_dss_per = 0
        nv_dss_per = deci(wdetail.dspc).
    IF  nv_dss_per   <> 0  THEN
        ASSIGN nv_dsspcvar1   = "     Discount Special % = "
        nv_dsspcvar2   =  STRING(nv_dss_per)
        SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
        SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
    
    /*------------------ stf ---------------*/
     nv_stf_per = 0.
     nv_stfvar   = " ".
     nv_stf_per     = DECI(wdetail.staff). /*A60-0152*/
     IF  nv_stf_per   <> 0  THEN
        ASSIGN nv_stfvar1   = "     Discount Staff"          
              nv_stfvar2   =  STRING(nv_stf_per)           
              SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1    
              SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2. 

    ASSIGN fi_process = "out baseplus " + wdetail.policy.
    DISP fi_process WITH FRAM fr_main.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt c-Win 
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
         nv_dspcp   = deci(wdetail.dspc)  /*nv_dss_per */                                   
         nv_dstfp   = deci(wdetail.staff)                                                     
         nv_clmp    = DECI(wdetail.loadclm)                                                          
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
            /*RUN wgw/wgwredbook(input  wdetail.brand ,  */ /*A65-0177*/
             RUN wgw/wgwredbk1(input  wdetail.brand ,        /*A65-0177*/
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
            /*RUN wgw/wgwredbook(input  wdetail.brand , */ /*A65-0177*/
             RUN wgw/wgwredbk1(input  wdetail.brand ,        /*A65-0177*/
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
            Find FIRST stat.maktab_fil Use-index  maktab01  Where
              stat.maktab_fil.sclass = wdetail.subclass  AND 
              stat.maktab_fil.modcod = wdetail.redbook    No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
               ASSIGN 
               sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
               wdetail.cargrp         =  stat.maktab_fil.prmpac
               sic_bran.uwm301.vehgrp =  stat.maktab_fil.prmpac
               nv_vehgrp              =  stat.maktab_fil.prmpac .

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
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.    */ 

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
        ASSIGN  wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
                wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt.
                wdetail.pass     = "Y"   
                wdetail.OK_GEN  = "N".*/  /*comment by Kridtiya i. A65-0035*/ 
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN wdetail.comment = wdetail.comment + "|" + nv_message    /*  by Kridtiya i. A65-0035*/ 
               wdetail.WARNING = wdetail.WARNING + "|" + nv_message .  /*  by Kridtiya i. A65-0035*/  
    END.
    /*  by Kridtiya i. A65-0035*/  
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate (input DATE(wdetail.comdat),
                       input date(wdetail.expdat),
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_campaignov c-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_campaign_fil c-Win 
PROCEDURE proc_campaign_fil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_seat AS INT INIT 0.
DEF VAR nv_garage AS CHAR FORMAT "X(15)" .
DEF VAR nv_carmodel AS CHAR FORMAT "X(10)" . /*A62-0422*/
DEF VAR nv_status   AS CHAR INIT "".
DO:
    ASSIGN nv_yr = 0    nv_seat = 0  nv_garage = ""
        nv_carmodel = "" . /*A62-0422*/
    /* add a62-0422 */
    IF INDEX(wdetail.model," ") <> 0 THEN DO:
        ASSIGN nv_carmodel   = trim(wdetail.model)  
            wdetail.model = SUBSTR(nv_carmodel,1,INDEX(nv_carmodel," ") - 1 ) .
    END.
    ELSE DO: 
        ASSIGN nv_carmodel = TRIM(wdetail.model) .
    END.
    /* end A62-0422 */
    IF wdetail.covcod = "1" THEN DO:
        IF wdetail.garage = "G" THEN  nv_garage = "ซ่อมอู่ห้าง".
        ELSE nv_garage = "ซ่อมอู่ประกัน" .
    END.
    ELSE nv_garage = "" .
    IF wdetail.caryear <> "" THEN DO:
        ASSIGN nv_yr = INT(YEAR(DATE(wdetail.comdat)))
               nv_yr = (nv_yr - INT(wdetail.caryear)) + 1 .
        IF nv_yr > 10  THEN ASSIGN nv_yr = 99 .
    END.

    FIND LAST brstat.insure USE-INDEX insure03 WHERE 
        brstat.insure.compno      = "TPIS_RE"  AND
        trim(brstat.insure.Text1) = TRIM(wdetail.campens) AND /*A66-0252*/
        brstat.insure.text2       = nv_garage             AND /*A66-0252*/
        deci(brstat.insure.text4) = DECI(wdetail.volprem) AND
        brstat.insure.text3       = trim(wdetail.prempa) + trim(wdetail.subclass)  NO-LOCK NO-ERROR .
    IF AVAIL brstat.insure THEN DO:
        ASSIGN 
            wdetail.deductpp  =  brstat.insure.lname
            wdetail.deductba  =  brstat.insure.addr1  
            wdetail.deductpa  =  brstat.insure.addr2 
            /* add : A63-0113 */
            wdetail.NO_411     = brstat.insure.addr3  
            wdetail.NO_412     = brstat.insure.addr3  
            wdetail.NO_42      = brstat.insure.addr4 
            wdetail.NO_43      = brstat.insure.telno .
        /* end : A63-0113 */
    END.
    ELSE DO:
        FIND LAST brstat.insure USE-INDEX insure03 WHERE 
            brstat.insure.compno      = "TPIS_RE"  AND
            trim(brstat.insure.Text1) = TRIM(wdetail.campens) AND /*A66-0252*/
            brstat.insure.text2       = nv_garage  AND 
            brstat.insure.text3       = trim(wdetail.prempa) + trim(wdetail.subclass)  NO-LOCK NO-ERROR .
        IF AVAIL brstat.insure THEN DO:
            ASSIGN 
            wdetail.deductpp  =  brstat.insure.lname
            wdetail.deductba  =  brstat.insure.addr1  
            wdetail.deductpa  =  brstat.insure.addr2 
            /* add : A63-0113 */
            wdetail.NO_411     = brstat.insure.addr3  
            wdetail.NO_412     = brstat.insure.addr3  
            wdetail.NO_42      = brstat.insure.addr4 
            wdetail.NO_43      = brstat.insure.telno .
        /* end : A63-0113 */
        END.
        /* A66-0252 */
        ELSE DO:
            FIND LAST brstat.insure USE-INDEX insure03 WHERE 
            brstat.insure.compno      = "TPIS_RE"  AND
            trim(brstat.insure.Text1) = TRIM(wdetail.campens) AND 
            deci(brstat.insure.text4) = DECI(wdetail.volprem) AND
            brstat.insure.text3       = trim(wdetail.prempa) + trim(wdetail.subclass)  NO-LOCK NO-ERROR .
            IF AVAIL brstat.insure THEN 
                ASSIGN 
                    wdetail.deductpp  =  brstat.insure.lname
                    wdetail.deductba  =  brstat.insure.addr1  
                    wdetail.deductpa  =  brstat.insure.addr2 
                    wdetail.NO_411     = brstat.insure.addr3  
                    wdetail.NO_412     = brstat.insure.addr3  
                    wdetail.NO_42      = brstat.insure.addr4 
                    wdetail.NO_43      = brstat.insure.telno .
        END.
        /* end : A66-0252 */
    END.
    RELEASE brstat.insure.
    /*---------------------------------14/07/2020
    /* add : A63-0113 */
    IF DATE(wdetail.comdat) >= 04/01/2020 THEN DO:
        ASSIGN wdetail.prempa = "T" .
    END.
    ELSE DO:
    /* end : A63-0113 */
        ---------------------------------14/07/2020 */
    nv_status = "no".
    IF wdetail.covcod = "1" THEN DO:
        IF      wdetail.subclass = "210" THEN ASSIGN nv_seat = 5   .
        ELSE IF wdetail.subclass = "320" THEN ASSIGN nv_seat = 3   .
        ELSE ASSIGN nv_seat = 7   .  /* A63-0325 */
        
        IF wdetail.subclass = "110" THEN DO:  /* 110 */
            IF INT(wdetail.engine) <= 2000  THEN DO: 
                FIND LAST stat.campaign_fil USE-INDEX campfil01     WHERE 
                    stat.campaign_fil.camcod   = trim(wdetail.campens)  and  /* campaign */
                    stat.campaign_fil.sclass   = trim(wdetail.subclass) and  /* class 110 210 320 */
                    stat.campaign_fil.covcod   = trim(wdetail.covcod)   and  /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                    stat.campaign_fil.vehgrp   = "3"                    and  /* group car */
                    stat.campaign_fil.vehuse   = "1"                    and  /* ประเภทการใช้รถ */
                    stat.campaign_fil.garage   = wdetail.garage         and  /* การซ่อม */
                    stat.campaign_fil.engine   <= 2000                  and  /* CC */
                    stat.campaign_fil.maxyea   = nv_yr                  AND  /* car year */
                    stat.campaign_fil.simax    = deci(wdetail.si)       AND
                    stat.campaign_fil.netprm   = DECI(wdetail.volprem)    /*   and  /* ทุน */
                    stat.campaign_fil.moddes = trim(wdetail.model) */    NO-LOCK NO-ERROR.   /* Model */
            END.
            ELSE DO:
                FIND LAST stat.campaign_fil USE-INDEX campfil01      WHERE 
                    stat.campaign_fil.camcod  = trim(wdetail.campens)   and   /* campaign */
                    stat.campaign_fil.sclass  = trim(wdetail.subclass)  and   /* class 110 210 320 */
                    stat.campaign_fil.covcod  = trim(wdetail.covcod)    and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                    stat.campaign_fil.vehgrp  = "3"                     and   /* group car */
                    stat.campaign_fil.vehuse  = "1"                     and   /* ประเภทการใช้รถ */
                    stat.campaign_fil.garage  = wdetail.garage          and    /* การซ่อม */
                    stat.campaign_fil.engine  > 2000                    and   /* CC */
                    stat.campaign_fil.maxyea  = nv_yr                   AND   /* car year */
                    stat.campaign_fil.simax   = deci(wdetail.si)        AND  
                    stat.campaign_fil.netprm  = DECI(wdetail.volprem)   /*   and  /* ทุน */
                    stat.campaign_fil.moddes  = trim(wdetail.model)  */    NO-LOCK NO-ERROR.   /* Model */
            END.
            IF AVAIL stat.campaign_fil THEN DO:
                ASSIGN 
                    wdetail.polmaster  = stat.campaign_fil.polmst
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
                    wdetail.seat41     = stat.campaign_fil.seats .
                    nv_status = "yes".
            END.
        END.  /* end 110 */
        ELSE DO:  /* 210,320 */
            FIND LAST stat.campaign_fil USE-INDEX campfil15  WHERE 
                stat.campaign_fil.camcod  = trim(wdetail.campens)  and  /* campaign */
                stat.campaign_fil.sclass  = trim(wdetail.subclass) and  /* class 110 210 320 */
                stat.campaign_fil.covcod  = trim(wdetail.covcod)   and  /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                /*stat.campaign_fil.vehgrp  = "3"                    and  /* group car */*/
                stat.campaign_fil.vehuse  = "1"                    and  /* ประเภทการใช้รถ */
                stat.campaign_fil.garage  = TRIM(wdetail.garage)   and  /* การซ่อม */
                stat.campaign_fil.seats   = nv_seat                and  /* ที่นั่ง */
                /*stat.campaign_fil.tons    = nv_ton                 and*/  /* ton */
                stat.campaign_fil.maxyea  = nv_yr                  AND  /* car year */
                stat.campaign_fil.simax   = deci(wdetail.si)       AND 
                stat.campaign_fil.netprm  = DECI(wdetail.volprem)  /* and  /* ทุน */
                stat.campaign_fil.moddes  = trim(wdetail.model)   */ NO-LOCK NO-ERROR.   /* Model */
            IF AVAIL stat.campaign_fil THEN DO:
                ASSIGN 
                    wdetail.polmaster  = stat.campaign_fil.polmst
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
                    wdetail.seat41     = stat.campaign_fil.seats  
                    nv_status          = "yes".
            END.
            ELSE DO:
                FIND LAST stat.campaign_fil USE-INDEX campfil15          WHERE 
                    stat.campaign_fil.camcod  = trim(wdetail.campens)    and  /* campaign */
                    stat.campaign_fil.sclass  = trim(wdetail.subclass)   and  /* class 110 210 320 */
                    stat.campaign_fil.covcod  = trim(wdetail.covcod)     and  /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                    /*stat.campaign_fil.vehgrp  = "3"                    and  /* group car */*/
                    stat.campaign_fil.vehuse  = "2"                      and  /* ประเภทการใช้รถ */
                    stat.campaign_fil.garage  = TRIM(wdetail.garage)     and  /* การซ่อม */
                    stat.campaign_fil.seats   = nv_seat                  and  /* ที่นั่ง */
                    /*stat.campaign_fil.tons    = nv_ton                 and*/  /* ton */
                    stat.campaign_fil.maxyea  = nv_yr                    AND  /* car year */
                    stat.campaign_fil.simax   = deci(wdetail.si)         AND 
                    stat.campaign_fil.netprm  = DECI(wdetail.volprem)    /*   and  /* ทุน */
                    stat.campaign_fil.moddes  = trim(wdetail.model) */  NO-LOCK NO-ERROR.   /* Model */
                IF AVAIL stat.campaign_fil THEN DO:
                    ASSIGN 
                        wdetail.polmaster  = stat.campaign_fil.polmst
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
                        wdetail.seat41     = stat.campaign_fil.seats  
                        nv_status          = "yes".
                END.
            END.  /*else do: */
        END.  /*end 210 320 */
    END.
    ELSE DO:  /* 2 3 2+ 3+ */
        FIND LAST stat.campaign_fil USE-INDEX campfil15  WHERE 
            stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
            stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
            stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
            stat.campaign_fil.vehgrp  = "3"                    and   /* group car */
            stat.campaign_fil.vehuse  = "1"                    and   /* ประเภทการใช้รถ */
            stat.campaign_fil.garage  = TRIM(wdetail.garage)   and    /* การซ่อม */
            stat.campaign_fil.maxyea  = nv_yr                  AND   /* car year */
            stat.campaign_fil.simax   = deci(wdetail.si)       and  /* ทุน */   
            stat.campaign_fil.netprm  = DECI(wdetail.volprem) 
            /*stat.campaign_fil.moddes  = ""  */      NO-LOCK NO-ERROR.   /* Model */
        IF AVAIL stat.campaign_fil THEN DO:
            ASSIGN 
                wdetail.polmaster  = stat.campaign_fil.polmst
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
                wdetail.seat41     = stat.campaign_fil.seats  
                nv_status          = "yes".
        END.
        ELSE DO:
            FIND LAST stat.campaign_fil USE-INDEX campfil15  WHERE 
                stat.campaign_fil.camcod  = trim(wdetail.campens)  and   /* campaign */
                stat.campaign_fil.sclass  = trim(wdetail.subclass) and   /* class 110 210 320 */
                stat.campaign_fil.covcod  = trim(wdetail.covcod)   and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.vehgrp  = "3"                    and   /* group car */
                stat.campaign_fil.vehuse  = "1"                    and   /* ประเภทการใช้รถ */
                stat.campaign_fil.garage  = TRIM(wdetail.garage)   and    /* การซ่อม */
                stat.campaign_fil.maxyea  = nv_yr                  AND   /* car year */
                stat.campaign_fil.simax   = deci(wdetail.si)       and   /* ทุน */   
                stat.campaign_fil.netprm  = DECI(wdetail.volprem) 
                /*stat.campaign_fil.moddes  = ""   */     NO-LOCK NO-ERROR.   /* Model */
            IF AVAIL stat.campaign_fil THEN DO:
                ASSIGN 
                    wdetail.polmaster  = stat.campaign_fil.polmst
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
                    wdetail.seat41     = stat.campaign_fil.seats  
                    nv_status          = "yes".
            END.
        END.
    END.    /* end 2 3 2+ 3+ */
    RELEASE stat.campaign_fil .
    
    OUTPUT TO LinkLogOS_LoadTPIS_RENew.TXT APPEND.
    PUT
        TODAY    FORMAT "99/99/9999"  " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3) SKIP
        "wdetail.policy   :" wdetail.policy     FORMAT "X(20)"     skip    
        "wdetail.campens  :" wdetail.campens    FORMAT "X(20)"     skip                                                
        "wdetail.subclass :" wdetail.subclass   FORMAT "X(5)"      skip                                                
        "wdetail.covcod   :" wdetail.covcod     FORMAT "X(5)"      skip                                                
        "wdetail.garage   :" wdetail.garage     FORMAT "X(3)"      skip                                                
        "wdetail.seat     :" wdetail.seat       FORMAT "X(5)"      skip                                                
        "wdetail.si       :" wdetail.si         FORMAT "X(20)"     skip 
        "wdetail.volprem  :" wdetail.volprem    FORMAT "X(20)"     skip 
        "wdetail.polmaster:" wdetail.polmaster  FORMAT "X(20)"     skip 
        "*----------------------end.---------------------------------*--" skip.
    OUTPUT CLOSE.
    IF nv_status   = "no"  THEN
        ASSIGN 
        wdetail.polmaster  = ""
      /*  wdetail.NO_411     = "0"
        wdetail.NO_412     = "0"
        wdetail.NO_42      = "0"
        wdetail.NO_43      = "0"
        wdetail.fleet      = "0"
        wdetail.ncb        = "0"
        wdetail.dspc       = "0"
        wdetail.loadclm    = "0"
        wdetail.baseprem   =  0
        wdetail.base3      = "0" 
        wdetail.netprem    = "0"
        wdetail.seat       = "0"
        wdetail.seat41     = 0 */   .
    /*---------------------------------14/07/2020
    END. /* end a63-0113...*/
        ---------------------------------14/07/2020 */

    wdetail.model = nv_carmodel .  /*a62-0422*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_camp_renew c-Win 
PROCEDURE proc_camp_renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF trim(wdetail.covcod) = "1" THEN DO:
        ASSIGN  nv_cc = ""   nv_yr = 0 .
        IF wdetail.model = "D-MAX"  THEN DO:
            IF wdetail.subclass = "110" THEN DO:
                IF INT(wdetail.engine) <= 2000  THEN nv_cc = "<=2000" .
                ELSE IF INT(wdetail.engine) > 2000 THEN nv_cc = ">2000".
            END.
            ELSE nv_cc = "3" .
        END.
        ELSE IF wdetail.model = "MU-X" AND int(wdetail.engine) = 3000 THEN nv_cc = "2500" .  
        ELSE nv_cc = wdetail.engine.

        IF wdetail.caryear <> "" THEN DO:
            ASSIGN nv_yr = INT(YEAR(DATE(wdetail.comdat)))
                   nv_yr = (nv_yr - INT(wdetail.caryear)) + 1 .
        END.
       
        FIND LAST brstat.insure USE-INDEX Insure03             WHERE 
                   trim(brstat.insure.compno)  = TRIM(fi_model)       AND 
                   trim(brstat.insure.insno)   = TRIM(fi_model)       AND
                   trim(brstat.insure.vatcode) = trim(wdetail.covcod) AND          /*ประเภท*/
                   trim(brstat.insure.Text1)   = TRIM(wdetail.garage) AND          /* garage */
                   trim(brstat.insure.Text2)   = trim(wdetail.model)  AND          /* ยี่ห้อ */
                   trim(brstat.insure.Text3)   = trim(wdetail.prempa) + trim(wdetail.subclass)    AND    /* class */
                   INT(brstat.insure.Text4)    = INT(wdetail.si) AND         /* ทุน */
                   TRIM(brstat.insure.icno)    = trim(nv_cc)          AND         /* cc */
                   TRIM(brstat.insure.ICAddr4) = string(nv_yr) NO-LOCK NO-ERROR.  /* อายุรถ */

         IF AVAIL brstat.insure THEN DO:
             ASSIGN wdetail.deductpp   = brstat.Insure.LName 
                    wdetail.deductba   = brstat.Insure.Addr1 
                    wdetail.deductpa   = brstat.Insure.Addr2 
                    wdetail.NO_411     = brstat.Insure.Addr3 
                    wdetail.NO_42      = brstat.Insure.Addr4 
                    wdetail.NO_43      = brstat.Insure.TelNo 
                    wdetail.fleet      = brstat.insure.ICAddr3
                    wdetail.ncb        = string(brstat.insure.Deci1)
                    wdetail.dspc       = string(brstat.insure.Deci2)
                    wdetail.base       = brstat.insure.Text5
                    wdetail.base3      = "0" /*brstat.insure.ICAddr4*/ 
                    wdetail.netprem    = brstat.insure.ICAddr2
                    wdetail.seat       = brstat.insure.ICAddr1
                    wdetail.seat41     = INT(brstat.insure.ICAddr1).
         END.
         ELSE ASSIGN wdetail.deductpp   = ""
                     wdetail.deductba   = ""
                     wdetail.deductpa   = ""
                     wdetail.NO_411      = ""
                     wdetail.NO_42      = ""
                     wdetail.NO_43      = ""
                     wdetail.fleet      = ""
                     wdetail.ncb        = ""
                     wdetail.dspc       = ""
                     wdetail.base       = ""
                     wdetail.base3      = "0"
                     wdetail.netprem    = "".
                     /*wdetail.seat       = ""
                     wdetail.seat41     = 0.*/
    END.
    ELSE IF wdetail.covcod = "2.2" OR wdetail.covcod = "3.2"  THEN DO:
        ASSIGN  nv_cc = ""   nv_yr = 0 .
        IF wdetail.subclass = "110"  THEN DO:
            IF INT(wdetail.engine) <= 2000  THEN nv_cc = "<=2000" .
            ELSE nv_cc = ">2000".
        END.
        ELSE nv_cc = "" .
        
         FIND LAST brstat.insure USE-INDEX Insure03             WHERE 
                   brstat.insure.compno       = TRIM(fi_model)       AND 
                   brstat.insure.insno        = TRIM(fi_model)       AND
                   brstat.insure.vatcode      = trim(wdetail.covcod) AND          /*ประเภท*/
                   brstat.insure.Text3        = trim(wdetail.prempa) + trim(wdetail.subclass)    AND    /* class */
                   INT(brstat.insure.Text4)   = INT(wdetail.si)      AND         /* ทุน */
                   brstat.insure.icno         = trim(nv_cc)   NO-LOCK NO-ERROR.  /* cc */
                   
         IF AVAIL brstat.insure THEN DO:
             ASSIGN wdetail.deductpp   = brstat.Insure.LName 
                    wdetail.deductba   = brstat.Insure.Addr1 
                    wdetail.deductpa   = brstat.Insure.Addr2 
                    wdetail.NO_411      = brstat.Insure.Addr3 
                    wdetail.NO_42      = brstat.Insure.Addr4 
                    wdetail.NO_43      = brstat.Insure.TelNo 
                    wdetail.fleet      = brstat.insure.ICAddr3
                    wdetail.ncb        = string(brstat.insure.Deci1)
                    wdetail.dspc       = string(brstat.insure.Deci2)
                    wdetail.base       = brstat.insure.Text5
                    wdetail.base3      = brstat.insure.ICAddr4
                    wdetail.netprem    = brstat.insure.ICAddr2
                    wdetail.seat       = brstat.insure.ICAddr1
                    wdetail.seat41     = INT(brstat.insure.ICAddr1).
         END.
         ELSE ASSIGN wdetail.deductpp   = ""
                     wdetail.deductba   = ""
                     wdetail.deductpa   = ""
                     wdetail.NO_411      = ""
                     wdetail.NO_42      = ""
                     wdetail.NO_43      = ""
                     wdetail.fleet      = ""
                     wdetail.ncb        = ""
                     wdetail.dspc       = ""
                     wdetail.base       = ""
                     wdetail.base3      = "0"
                     wdetail.netprem    = "".
                     /*wdetail.seat       = ""
                     wdetail.seat41     = 0.*/
         
    END.
    ELSE DO:
        ASSIGN  nv_cc = ""   nv_yr = 0 .
        IF wdetail.subclass = "110" THEN DO:
            IF INT(wdetail.engine) <= 2000  THEN nv_cc = "<=2000" .
            ELSE nv_cc = ">2000".
        END.
        ELSE nv_cc = "" .
        IF wdetail.covcod = "2" THEN DO:
         FIND LAST brstat.insure USE-INDEX Insure03             WHERE 
                   brstat.insure.compno       = TRIM(fi_model)       AND 
                   brstat.insure.insno        = TRIM(fi_model)       AND
                   brstat.insure.vatcode      = trim(wdetail.covcod) AND          /*ประเภท*/
                   brstat.insure.Text3        = trim(wdetail.prempa) + trim(wdetail.subclass)    AND    /* class */
                   INT(brstat.insure.Text4)   = INT(wdetail.si)      AND         /* ทุน */
                   brstat.insure.icno         = trim(nv_cc)   NO-LOCK NO-ERROR.  /* cc */
        END.
        ELSE DO:
            FIND LAST brstat.insure USE-INDEX Insure03             WHERE 
                   brstat.insure.compno       = TRIM(fi_model)       AND 
                   brstat.insure.insno        = TRIM(fi_model)       AND
                   brstat.insure.vatcode      = trim(wdetail.covcod) AND          /*ประเภท*/
                   brstat.insure.Text3        = trim(wdetail.prempa) + trim(wdetail.subclass)    AND    /* class */
                   /*INT(brstat.insure.Text4)   = INT(wdetail.si)      AND    */     /* ทุน */
                   brstat.insure.icno         = trim(nv_cc)   NO-LOCK NO-ERROR.  /* cc */
        END.
        IF AVAIL brstat.insure THEN DO:
             ASSIGN wdetail.deductpp   = brstat.Insure.LName 
                    wdetail.deductba   = brstat.Insure.Addr1 
                    wdetail.deductpa   = brstat.Insure.Addr2 
                    wdetail.NO_411      = brstat.Insure.Addr3 
                    wdetail.NO_42      = brstat.Insure.Addr4 
                    wdetail.NO_43      = brstat.Insure.TelNo 
                    wdetail.fleet      = brstat.insure.ICAddr3
                    wdetail.ncb        = string(brstat.insure.Deci1)
                    wdetail.dspc       = string(brstat.insure.Deci2)
                    wdetail.base       = brstat.insure.Text5
                    wdetail.base3      = brstat.insure.ICAddr4
                    wdetail.netprem    = brstat.insure.ICAddr2
                    wdetail.seat       = brstat.insure.ICAddr1
                    wdetail.seat41     = INT(brstat.insure.ICAddr1).
         END.
         ELSE ASSIGN wdetail.deductpp   = ""
                     wdetail.deductba   = ""
                     wdetail.deductpa   = ""
                     wdetail.NO_411      = ""
                     wdetail.NO_42      = ""
                     wdetail.NO_43      = ""
                     wdetail.fleet      = ""
                     wdetail.ncb        = ""
                     wdetail.dspc       = ""
                     wdetail.base       = ""
                     wdetail.base3      = "0"
                     wdetail.netprem    = "".
                     /*wdetail.seat       = ""
                     wdetail.seat41     = 0.*/
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_charpolicyre c-Win 
PROCEDURE proc_charpolicyre :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
ASSIGN 
    nv_c = wdetail2.prvpol
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
    ind = INDEX(nv_c," ").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,".").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN
    wdetail2.prvpol = trim(nv_c) .*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassic c-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcode c-Win 
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
 END.
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
 END.*/
 RELEASE sicsyac.xmm600.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcomp c-Win 
PROCEDURE proc_chkcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*A68-0019 
IF wdetail.poltyp = "V72" THEN DO:
    IF      deci(wdetail.volprem) = 645.21    THEN ASSIGN wdetail.subclass = "110" .
    ELSE IF deci(wdetail.volprem) = 967.28    THEN ASSIGN wdetail.subclass = "140A". 
    ELSE IF deci(wdetail.volprem) = 1310.75   THEN ASSIGN wdetail.subclass = "140B". 
    ELSE IF deci(wdetail.volprem) = 2718.87   THEN ASSIGN wdetail.subclass = "240D" .
    ELSE IF deci(wdetail.volprem) = 1408.12   THEN ASSIGN wdetail.subclass = "140C" .
    ELSE IF deci(wdetail.volprem) = 1826.49   THEN ASSIGN wdetail.subclass = "140D" .
    ELSE IF deci(wdetail.volprem) = 1182.35   THEN ASSIGN wdetail.subclass = "120A" .
    ELSE IF deci(wdetail.volprem) = 2203.13   THEN ASSIGN wdetail.subclass = "120B" .
    ELSE IF deci(wdetail.volprem) = 3437.91   THEN ASSIGN wdetail.subclass = "120C" .
    ELSE IF deci(wdetail.volprem) = 4017.85   THEN ASSIGN wdetail.subclass = "120D" .
    ELSE IF deci(wdetail.volprem) = 2041.56   THEN ASSIGN wdetail.subclass = "210"  .
    ELSE IF deci(wdetail.volprem) = 1891.76   THEN ASSIGN wdetail.subclass = "240A" .
    ELSE IF deci(wdetail.volprem) = 1966.66   THEN ASSIGN wdetail.subclass = "240B" .
    ELSE IF deci(wdetail.volprem) = 2127.16   THEN ASSIGN wdetail.subclass = "240C" .
    ELSE IF deci(wdetail.volprem) = 2718.87   THEN ASSIGN wdetail.subclass = "240D" .
    ELSE IF deci(wdetail.volprem) = 2546.60   THEN ASSIGN wdetail.subclass = "150"  .
    ELSE IF deci(wdetail.volprem) = 3395.11   THEN ASSIGN wdetail.subclass = "250"  .
END.
 A68-0019*/
 /*A68-0019*/
    IF      deci(wdetail.volprem) = 645.21  AND wdetail.subclass = "110"  THEN ASSIGN wdetail.subclass = "110"   wdetail.vehuse = "1" .   
    ELSE IF deci(wdetail.volprem) = 645.21  AND wdetail.subclass = "520"  THEN ASSIGN wdetail.subclass = "260"   wdetail.vehuse = "2" . 
    ELSE IF deci(wdetail.volprem) = 967.28    THEN ASSIGN wdetail.subclass = "140A"     wdetail.vehuse = "1" .   
    ELSE IF deci(wdetail.volprem) = 1310.75   THEN ASSIGN wdetail.subclass = "140B"     wdetail.vehuse = "1" .   
    ELSE IF deci(wdetail.volprem) = 1408.12   THEN ASSIGN wdetail.subclass = "140C"     wdetail.vehuse = "1" .   
    ELSE IF deci(wdetail.volprem) = 1826.49   THEN ASSIGN wdetail.subclass = "140D"     wdetail.vehuse = "1" .   
    ELSE IF deci(wdetail.volprem) = 1182.35   THEN ASSIGN wdetail.subclass = "120A"     wdetail.vehuse = "1" .   
    ELSE IF deci(wdetail.volprem) = 2203.13   THEN ASSIGN wdetail.subclass = "120B"     wdetail.vehuse = "1" .   
    ELSE IF deci(wdetail.volprem) = 3437.91   THEN ASSIGN wdetail.subclass = "120C"     wdetail.vehuse = "1" .   
    ELSE IF deci(wdetail.volprem) = 4017.85   THEN ASSIGN wdetail.subclass = "120D"     wdetail.vehuse = "1" .   
    ELSE IF deci(wdetail.volprem) = 2041.56   THEN ASSIGN wdetail.subclass = "210"      wdetail.vehuse = "2" .   
    ELSE IF deci(wdetail.volprem) = 1891.76   THEN ASSIGN wdetail.subclass = "240A"     wdetail.vehuse = "2" .   
    ELSE IF deci(wdetail.volprem) = 1966.66   THEN ASSIGN wdetail.subclass = "240B"     wdetail.vehuse = "2" .   
    ELSE IF deci(wdetail.volprem) = 2127.16   THEN ASSIGN wdetail.subclass = "240C"     wdetail.vehuse = "2" .   
    ELSE IF deci(wdetail.volprem) = 2718.87   THEN ASSIGN wdetail.subclass = "240D"     wdetail.vehuse = "2" .   
    ELSE IF deci(wdetail.volprem) = 2546.60   THEN ASSIGN wdetail.subclass = "150"      wdetail.vehuse = "1" .   
    ELSE IF deci(wdetail.volprem) = 3395.11   THEN ASSIGN wdetail.subclass = "250"      wdetail.vehuse = "2" .                                 
    ELSE IF deci(wdetail.volprem) = 2493.10   THEN ASSIGN wdetail.subclass = "220A"     wdetail.vehuse = "2" .                              
    ELSE IF deci(wdetail.volprem) = 3738.58   THEN ASSIGN wdetail.subclass = "220B"     wdetail.vehuse = "2" .                        
    ELSE IF deci(wdetail.volprem) = 7155.09   THEN ASSIGN wdetail.subclass = "220C"     wdetail.vehuse = "2" .             
    ELSE IF deci(wdetail.volprem) = 8079.57   THEN ASSIGN wdetail.subclass = "220D"     wdetail.vehuse = "2" .
    ELSE DO:
        /*
        IF      index(wdetail.subclass,"110") <> 0 THEN assign wdetail.subclass = "110"   wdetail.vehuse = "1" . 
        ELSE IF index(wdetail.subclass,"210") <> 0 AND index(wdetail.brand,"isuzu") <> 0 THEN 
                                                        assign wdetail.subclass = "140A"  wdetail.vehuse = "1" .   
        ELSE IF index(wdetail.subclass,"210") <> 0 THEN assign wdetail.subclass = "120A"  wdetail.vehuse = "1" .   
        ELSE IF index(wdetail.subclass,"320") <> 0 THEN assign wdetail.subclass = "140A"  wdetail.vehuse = "1" .   
        */
        ASSIGN
            wdetail.comment = wdetail.comment + "| ไม่พบเบี้ย พรบ. นี้ " + wdetail.volprem 
            wdetail.pass    = "N"  
            wdetail.OK_GEN  = "N".

         
    END.
     /*A68-0019*/

 
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcomp70 c-Win 
PROCEDURE proc_chkcomp70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT-OUTPUT PARAMETER  np_subclass70  as char FORMAT "x(10)".
np_subclass70 = "".

IF      deci(wdetail.volprem) = 645.21    AND wdetail.subclass = "110"  THEN ASSIGN np_subclass70 = "110"   .
ELSE IF deci(wdetail.volprem) = 645.21    AND wdetail.subclass = "520"  THEN ASSIGN np_subclass70 = "520"   .
ELSE IF deci(wdetail.volprem) = 967.28    THEN  ASSIGN np_subclass70 = "320"  . 
ELSE IF deci(wdetail.volprem) = 1310.75   THEN  ASSIGN np_subclass70 = "320"  . 
ELSE IF deci(wdetail.volprem) = 1408.12   THEN  ASSIGN np_subclass70 = "320"  . 
ELSE IF deci(wdetail.volprem) = 1826.49   THEN  ASSIGN np_subclass70 = "320"  . 
ELSE IF deci(wdetail.volprem) = 1182.35   THEN  ASSIGN np_subclass70 = "210"  . 
ELSE IF deci(wdetail.volprem) = 2203.13   THEN  ASSIGN np_subclass70 = "210"  . 
ELSE IF deci(wdetail.volprem) = 3437.91   THEN  ASSIGN np_subclass70 = "210"  . 
ELSE IF deci(wdetail.volprem) = 4017.85   THEN  ASSIGN np_subclass70 = "210"  . 
ELSE IF deci(wdetail.volprem) = 2041.56   THEN  ASSIGN np_subclass70 = "120"  . 
ELSE IF deci(wdetail.volprem) = 1891.76   THEN  ASSIGN np_subclass70 = "320"  . 
ELSE IF deci(wdetail.volprem) = 1966.66   THEN  ASSIGN np_subclass70 = "320"  . 
ELSE IF deci(wdetail.volprem) = 2127.16   THEN  ASSIGN np_subclass70 = "320"  . 
ELSE IF deci(wdetail.volprem) = 2718.87   THEN  ASSIGN np_subclass70 = "320"  . 
ELSE IF deci(wdetail.volprem) = 2546.60   THEN  ASSIGN np_subclass70 = "420"  . 
ELSE IF deci(wdetail.volprem) = 3395.11   THEN  ASSIGN np_subclass70 = "420"  . 
ELSE IF deci(wdetail.volprem) = 2493.10   THEN  ASSIGN np_subclass70 = "220"  .           
ELSE IF deci(wdetail.volprem) = 3738.58   THEN  ASSIGN np_subclass70 = "220"  .     
ELSE IF deci(wdetail.volprem) = 7155.09   THEN  ASSIGN np_subclass70 = "220"  . 
ELSE IF deci(wdetail.volprem) = 8079.57   THEN  ASSIGN np_subclass70 = "220"  . 


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 c-Win 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail.vehreg = " " AND wdetail.prvpol  = " " THEN DO: 
    ASSIGN
        wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N". 
END.
ELSE DO:
    IF wdetail.prvpol = " " THEN DO:     /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
        Def  var  nv_vehreg  as char  init  " ".
        Def  var  s_polno       like sicuw.uwm100.policy   init " ".
        Find LAST sicuw.uwm301 Use-index uwm30102 Where  
            sicuw.uwm301.vehreg = wdetail.vehreg  No-lock no-error no-wait.
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
                sicuw.uwm100.expdat > date(wdetail.comdat)
                No-lock no-error no-wait.
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
        wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
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
/*IF wdetail.cc    = " " THEN 
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
/*IF INDEX(wdetail.vehreg," ฉท") <> 0  THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| พบจังหวัดที่จดทะเบียนคือ ฉะเชิงเทรา ไม่นำเข้าระบบ"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".*/
ASSIGN
    nv_maxsi = 0
    nv_minsi = 0
    nv_si    = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred = NO
    n_model = "".     
IF wdetail.redbook NE "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
        stat.maktab_fil.sclass = wdetail.subclass  AND 
        stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        Assign
            nv_modcod        =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            chkred           =  YES                     /*note chk found redbook*/
           /* wdetail.brand    =  stat.maktab_fil.makdes*/ /*A61-0152*/
           /*wdetail.model    =  stat.maktab_fil.moddes*/ /*A61-0152*/
           /*wdetail.caryear  =  STRING(stat.maktab_fil.makyea)*/ /*A61-0152*/
            wdetail.cc       =  STRING(stat.maktab_fil.engine)
            wdetail.subclass =  stat.maktab_fil.sclass   
            /*wdetail.si       =  STRING(stat.maktab_fil.si)*/
            wdetail.redbook  =  stat.maktab_fil.modcod                                    
            /*wdetail.seat     =  STRING(stat.maktab_fil.seats)*/
            nv_si            =  stat.maktab_fil.si.
        IF wdetail.covcod = "1"  THEN DO:
            FIND FIRST stat.makdes31 WHERE 
                stat.makdes31.makdes = "X"  AND     /*Lock X*/
                stat.makdes31.moddes = wdetail.prempa + wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE makdes31 THEN 
                ASSIGN
                    nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                    nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                    nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                    nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            ELSE 
                ASSIGN
                    nv_maxSI = nv_si
                    nv_minSI = nv_si.
        END.  
    End.          
    ELSE nv_modcod = " ".
   /* RUN proc_assignredbook. */
END.
/*---- A58-0489 : Redbook = "" --------
ELSE DO:                      /*red book <> ""*/   
    RUN proc_assignredbook.
END.
---end : A58-0489----*/
IF nv_modcod = "" THEN DO:
    /*comment by Ranu i. A58-0489..............
    IF ra_typload =  2 THEN DO:   /* Non-til */  
        FIND FIRST stat.insure USE-INDEX insure01  WHERE   
            stat.insure.compno = fi_model          AND          
            stat.insure.fname  = wdetail.model     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL insure THEN  ASSIGN wdetail.model =  trim(stat.insure.lname)   .
    END.
    .............end A58-0489......*/
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN 
        n_ratmin = makdes31.si_theft_p   
        n_ratmax = makdes31.load_p   .  
    ELSE ASSIGN n_ratmin = 0
                n_ratmax = 0.
    FIND FIRST stat.maktab_fil Use-index  maktab04           Where
        stat.maktab_fil.makdes   =   wdetail.brand            And                  
        INDEX(stat.maktab_fil.moddes,wdetail.model) <>  0     AND
        stat.maktab_fil.makyea   =   Integer(wdetail.caryear) AND
        stat.maktab_fil.engine   =   Integer(wdetail.cc)      AND
        stat.maktab_fil.sclass   =   wdetail.subclass         AND 
       (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )   GE  deci(wdetail.si)    AND
        stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )   LE  deci(wdetail.si) )  /*AND  
        stat.maktab_fil.seats    GE  inte(wdetail.seat) */         
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN  nv_modcod  =  stat.maktab_fil.modcod                                    
        nv_moddes          =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp     =  stat.maktab_fil.prmpac
        wdetail.redbook    =  stat.maktab_fil.modcod  .
    /*IF nv_modcod = ""  THEN RUN proc_maktab.  */
    END.  
    ASSIGN                  
        NO_CLASS  = wdetail.prempa + wdetail.subclass 
        nv_poltyp = wdetail.poltyp.
    If no_class  <>  " " Then do:
        FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
            sicsyac.xmd031.poltyp =   nv_poltyp AND
            sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE sicsyac.xmd031 THEN 
            ASSIGN wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1 c-Win 
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
    ASSIGN fi_process    = "Check  data TPIS-renew...." + wdetail.policy.    /*A56-0262*/
    DISP fi_process WITH FRAM fr_main.
    RUN proc_cr_2.
    ASSIGN 
        n_rencnt = 0
        n_endcnt = 0
        nv_deler  = ""
        nv_driver = ""
        nv_drivno = 0 
        nv_cctv   = "" .  /*A61-0152 */
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    /*
    IF wdetail.finint <> "" THEN DO:
        RUN wgw\wgwmatov (INPUT        wdetail.poltyp                 
                         ,INPUT        inte(wdetail.caryear)    
                         ,INPUT        wdetail.subclass        
                         ,INPUT        wdetail.covcod         
                         ,INPUT        wdetail.brand               
                         ,INPUT        wdetail.model               
                         ,INPUT        wdetail.finint          
                         ,INPUT        wdetail.financecd            
                         ,INPUT        inte(wdetail.si)                      
                         ,INPUT        wdetail.agent                                                     
                         ,INPUT-OUTPUT wdetail.campaign_ov) .  
    END.*/
    /*version 2 */
    /*RUN proc_campaignov (INPUT wdetail.producer 
                        ,INPUT wdetail.poltyp   
                        ,INPUT wdetail.branch   
                        ,INPUT DATE(wdetail.comdat) 
                        ,OUTPUT wdetail.campaign_ov).*/
    /* Add by : A65-0177 */
    IF wdetail.redbook = ""  THEN DO:
        ASSIGN fi_process = "check Redbook " + " " + wdetail.chasno + ".....".
        DISP fi_process WITH FRAM fr_main.
        nv_si = 0 .
        nv_si = INT(wdetail.si).

        RUN wgw/wgwredbk1(input  wdetail.brand , 
                           input  wdetail.model ,  
                           input  nv_si         ,  
                           INPUT  wdetail.tariff,  
                           input  wdetail.subclass,   
                           input  wdetail.caryear, 
                           input  wdetail.cc  ,
                           input  wdetail.weight, 
                           INPUT-OUTPUT wdetail.redbook) .
         nv_si = 0.
    END.
    /* end : A65-0177 */
    ASSIGN wdetail.campaign_ov = trim(wdetail.producer) .  /*Version 3*/
    RUN proc_susspect.
    RUN proc_chkcode . /* A64-0344 */
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
   IF wdetail.prvpol <> " " THEN DO: 
       RUN proc_renew.
       RUN proc_chktest0.
       RUN proc_policy .  
       RUN proc_chktest2.
       RUN proc_chktest3.
       RUN proc_chktest4.
   END.
   ELSE DO:
       IF wdetail.poltyp = "V72"  THEN DO:
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
           RUN proc_campaign_fil.
           /*IF wdetail.polmaster = "" THEN RUN proc_camp_renew .*/
           RUN proc_chktest0.                        
           RUN proc_policy .                         
           RUN proc_chktest2.                        
           RUN proc_chktest3.
           RUN proc_chktest4. 
        END.
   END.
   
END.  /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2 c-Win 
PROCEDURE proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR np_driver AS CHAR FORMAT "x(23)" INIT "".   /*driver policynew */
ASSIGN fi_process    = "Import data TPIS-renew to uwm130..." + wdetail.policy .    /*A56-0262*/
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND            /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND            /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND            /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr             AND 
    sic_bran.uwm130.bchno  = nv_batchno             AND 
    sic_bran.uwm130.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN DO: 
    DO TRANSACTION:
        CREATE sic_bran.uwm130.
        ASSIGN
            sic_bran.uwm130.policy = sic_bran.uwm120.policy
            sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
            sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
            sic_bran.uwm130.itemno = s_itemno
            sic_bran.uwm130.bchyr  = nv_batchyr        /* batch Year */
            sic_bran.uwm130.bchno  = nv_batchno        /* bchno      */
            sic_bran.uwm130.bchcnt = nv_batcnt       /* bchcnt     */
            np_driver = TRIM(sic_bran.uwm130.policy) +
                        STRING(sic_bran.uwm130.rencnt,"99" ) +
                        STRING(sic_bran.uwm130.endcnt,"999") +
                        STRING(sic_bran.uwm130.riskno,"999") +
                        STRING(sic_bran.uwm130.itemno,"999")
            nv_sclass = wdetail.subclass.
        IF nv_uom6_u  =  "A"  THEN DO:
            IF  nv_sclass  =  "320"  OR  nv_sclass  =  "340"  OR nv_sclass  =  "520"  OR  nv_sclass  =  "540"  
                Then  nv_uom6_u  =  "A".         
            Else 
                ASSIGN wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
        END.
        IF CAPS(nv_uom6_u) = "A"  Then
            Assign  nv_uom6_u          = "A"
            nv_othcod                  = "OTH"
            nv_othvar1                 = "     Accessory  = "
            nv_othvar2                 =  STRING(nv_uom6_u)
            SUBSTRING(nv_othvar,1,30)  = nv_othvar1
            SUBSTRING(nv_othvar,31,30) = nv_othvar2.
        ELSE
            ASSIGN  nv_uom6_u              = ""
                nv_othcod                  = ""
                nv_othvar1                 = ""
                nv_othvar2                 = ""
                SUBSTRING(nv_othvar,1,30)  = nv_othvar1
                SUBSTRING(nv_othvar,31,30) = nv_othvar2.
        IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR 
           (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN 
            ASSIGN
            sic_bran.uwm130.uom6_v   = inte(wdetail.si)
            /*sic_bran.uwm130.uom7_v   = inte(wdetail.si) */ /*a61-0152*/
            sic_bran.uwm130.uom7_v   = IF wdetail.covcod <> "3.2" THEN inte(wdetail.si) ELSE 0 /*a61-0152*/
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        
        IF wdetail.covcod = "2"  THEN 
            ASSIGN
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = inte(wdetail.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        IF wdetail.covcod = "3"  THEN 
            ASSIGN 
            /*sic_bran.uwm130.uom1_v =  deci(wdetail.tp1)  
            sic_bran.uwm130.uom2_v   =   deci(wdetail.tp2)  
            sic_bran.uwm130.uom5_v   =   deci(wdetail.tp3) */ 
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = 0
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/

        IF nv_cctv <> "" THEN sic_bran.uwm130.i_text = trim(nv_cctv) .  /* A61-0416*/
        ELSE sic_bran.uwm130.i_text    = "" .  /* A61-0416*/

        IF wdetail.poltyp = "v72" THEN  n_sclass72 = wdetail.subclass.
        ELSE n_sclass72 = wdetail.prempa + wdetail.subclass .

        FIND FIRST stat.clastab_fil Use-index clastab01 Where
            stat.clastab_fil.class   = n_sclass72       And
            stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
        IF avail stat.clastab_fil Then do: 
            Assign 
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
            IF wdetail.prvpol = "" THEN DO:  
                ASSIGN 
                    sic_bran.uwm130.uom1_v     =  if deci(wdetail.deductpp) <> 0 then deci(wdetail.deductpp) else stat.clastab_fil.uom1_si
                    sic_bran.uwm130.uom2_v     =  if deci(wdetail.deductba) <> 0 then deci(wdetail.deductba) else stat.clastab_fil.uom2_si
                    sic_bran.uwm130.uom5_v     =  if deci(wdetail.deductpa) <> 0 then deci(wdetail.deductpa) else stat.clastab_fil.uom5_si
                    nv_uom1_v                  =  if deci(wdetail.deductpp) <> 0 then deci(wdetail.deductpp) else sic_bran.uwm130.uom1_v   
                    nv_uom2_v                  =  if deci(wdetail.deductba) <> 0 then deci(wdetail.deductba) else sic_bran.uwm130.uom2_v
                    nv_uom5_v                  =  if deci(wdetail.deductpa) <> 0 then deci(wdetail.deductpa) else sic_bran.uwm130.uom5_v  .
                If  wdetail.garage  =  ""  Then
                    Assign 
                    nv_41      =   if deci(wdetail.NO_411) <> 0  then deci(wdetail.NO_411) else stat.clastab_fil.si_41unp
                    nv_42      =   if deci(wdetail.NO_42) <> 0  then deci(wdetail.NO_42) else stat.clastab_fil.si_42
                    nv_43      =   if deci(wdetail.NO_43) <> 0  then deci(wdetail.NO_43) else stat.clastab_fil.si_43
                    nv_seat41  =   if wdetail.seat41 <> 0       THEN wdetail.seat41      else stat.clastab_fil.dri_41 + clastab_fil.pass_41 .  
                Else If  wdetail.garage  =  "G"  Then
                    Assign 
                    nv_41       =  if deci(wdetail.NO_411) <> 0  then deci(wdetail.NO_411) else stat.clastab_fil.si_41pai
                    nv_42       =  if deci(wdetail.NO_42) <> 0  then deci(wdetail.NO_42) else stat.clastab_fil.si_42
                    nv_43       =  if deci(wdetail.NO_43) <> 0  then deci(wdetail.NO_43) else stat.clastab_fil.impsi_43
                    nv_seat41   =  if wdetail.seat41 <> 0       THEN wdetail.seat41      else stat.clastab_fil.dri_41 + clastab_fil.pass_41. 
            END.
            ELSE DO: 
                ASSIGN 
                sic_bran.uwm130.uom1_v     =  nv_uom1_v 
                sic_bran.uwm130.uom2_v     =  nv_uom2_v 
                sic_bran.uwm130.uom5_v     =  nv_uom5_v 
                nv_seat41                  =  wdetail.seat41.
            END.
        END.
        ASSIGN  nv_riskno = 1
            nv_itemno = 1.
        IF wdetail.covcod = "1" Then 
            RUN wgs/wgschsum(INPUT  wdetail.policy, 
                             nv_riskno,
                             nv_itemno).
        ASSIGN  s_recid3  = RECID(sic_bran.uwm130) .
    END.  /* end Do transaction*/
END.

ASSIGN
    nv_covcod  = wdetail.covcod
    nv_makdes  = wdetail.brand
    nv_moddes  = wdetail.model
    nv_newsck  = " ".
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
    sic_bran.uwm301.bchcnt = nv_batcnt     NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
    DO TRANSACTION:
        CREATE sic_bran.uwm301.
        ASSIGN sic_bran.uwm301.policy = sic_bran.uwm120.policy                 
            sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
            sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
            sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
            sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
            sic_bran.uwm301.itemno    = s_itemno
            sic_bran.uwm301.tariff    = wdetail.tariff    
            sic_bran.uwm301.covcod    = nv_covcod
            sic_bran.uwm301.cha_no    = wdetail.chasno
            sic_bran.uwm301.trareg    = nv_uwm301trareg
            sic_bran.uwm301.eng_no    = wdetail.engno
            sic_bran.uwm301.Tons      = DECI(wdetail.weight)    /*nv_tons*/
            sic_bran.uwm301.engine    = DECI(wdetail.cc)
            sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
            sic_bran.uwm301.logbok    = IF wdetail.subclass = "110" THEN "N" ELSE IF wdetail.prvpol = "" THEN "Y" ELSE "N"  /*A61-0152*/
            sic_bran.uwm301.garage    = wdetail.garage
            sic_bran.uwm301.body      = wdetail.body
            sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
            sic_bran.uwm301.mv_ben83  = wdetail.benname
            sic_bran.uwm301.vehreg    = wdetail.vehreg 
            sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
            sic_bran.uwm301.vehuse    = wdetail.vehuse
           /* sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   */      /*A62-0110*/
            sic_bran.uwm301.moddes    = IF wdetail.promo = "CV" THEN wdetail.model ELSE wdetail.brand + " " + wdetail.model    /*A62-0110*/
            sic_bran.uwm301.sckno     = 0
            sic_bran.uwm301.itmdel    = NO
            sic_bran.uwm301.car_color = trim(wdetail.colorcar)  /* A66-0252 */
            sic_bran.uwm301.logbok    = trim(wdetail.insp)      /* A66-0252 */
            /*sic_bran.uwm301.prmtxt    = IF wdetail.poltyp = "v70" THEN wdetail.prmtxt ELSE ""  */
            wdetail.tariff            = sic_bran.uwm301.tariff.
            /*IF wdetail.poltyp = "V70" AND (wdetail.prmtxt <> "" ) THEN DO:*/  /*A65-0177*/ 
            IF wdetail.poltyp = "V70"  THEN DO:  /*A65-0177*/ 
                 RUN proc_prmtxt. 
            END.
        IF wdetail.compul = "y" THEN DO:
            sic_bran.uwm301.cert = "".
            IF LENGTH(wdetail.stk) = 11 THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
            IF LENGTH(wdetail.stk) = 13  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
            IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".
            FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
                brStat.Detaitem.serailno = wdetail.stk  NO-LOCK NO-ERROR .
            IF NOT AVAIL brstat.Detaitem THEN DO:     
                CREATE brstat.Detaitem.
                ASSIGN brStat.Detaitem.Policy   = sic_bran.uwm301.Policy
                    brStat.Detaitem.RenCnt   = sic_bran.uwm301.RenCnt
                    brStat.Detaitem.EndCnt   = sic_bran.uwm301.Endcnt
                    brStat.Detaitem.RiskNo   = sic_bran.uwm301.RiskNo
                    brStat.Detaitem.ItemNo   = sic_bran.uwm301.ItemNo
                    brStat.Detaitem.serailno = wdetail.stk.  
            END.
        END.
        /*add driver  A57-0010 */
        IF nv_driver = ""   THEN ASSIGN nv_drivno = 0.
        ELSE DO:
            FOR EACH ws0m009 WHERE ws0m009.policy  = nv_driver NO-LOCK .
                CREATE brstat.mailtxt_fil.
                ASSIGN
                    brstat.mailtxt_fil.policy  = np_driver    
                    brstat.mailtxt_fil.lnumber = INTEGER(ws0m009.lnumber)
                    brstat.mailtxt_fil.ltext   = ws0m009.ltext  
                    brstat.mailtxt_fil.ltext2  = ws0m009.ltext2   
                    brstat.mailtxt_fil.bchyr   = nv_batchyr 
                    brstat.mailtxt_fil.bchno   = nv_batchno 
                    brstat.mailtxt_fil.bchcnt  = nv_batcnt .
                ASSIGN nv_drivno = INTEGER(ws0m009.lnumber).
            END.
        END.    /*add driver  A57-0010 */
        ASSIGN  
            sic_bran.uwm301.bchyr  = nv_batchyr   /* batch Year */
            sic_bran.uwm301.bchno  = nv_batchno   /* bchno      */
            sic_bran.uwm301.bchcnt = nv_batcnt    /* bchcnt     */
            s_recid4               = RECID(sic_bran.uwm301).
        IF wdetail.redbook <> ""  /*AND chkred = YES*/  THEN DO:
            FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE
                stat.maktab_fil.sclass = wdetail.subclass  AND
                stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
            If  avail  stat.maktab_fil  Then 
                ASSIGN
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes */ /*ฤ61-0152*/
                wdetail.cargrp          =  maktab_fil.prmpac
                /*sic_bran.uwm301.Tons    =  IF sic_bran.uwm301.Tons = 0 THEN stat.maktab.tons ELSE sic_bran.uwm301.Tons  /* A63-0113 */*/
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body    =  stat.maktab_fil.body
                sic_bran.uwm301.engine  =  stat.maktab_fil.engine
                nv_engine               =  stat.maktab_fil.engine.
        END.
        ELSE DO:
            Find First stat.maktab_fil Use-index      maktab04          Where
                stat.maktab_fil.makdes   =     nv_makdes                And                  
                index(stat.maktab_fil.moddes,nv_moddes) <> 0            And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
                stat.maktab_fil.engine   =     Integer(wdetail.engine)  AND
                stat.maktab_fil.sclass   =     wdetail.subclass        AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) /*AND
                 stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  */   No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                Assign
                wdetail.redbook         =  stat.maktab_fil.modcod
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/ /*A61-0152*/
                wdetail.cargrp          =  stat.maktab_fil.prmpac
                /*sic_bran.uwm301.Tons    =  stat.maktab.tons*/
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body    =  stat.maktab_fil.body
                sic_bran.uwm301.engine  =  stat.maktab_fil.engine
                nv_engine               =  stat.maktab_fil.engine.
        END.
        /*IF wdetail.redbook  = ""  THEN RUN proc_maktab.*/
        IF wdetail.redbook  = ""  THEN DO:
            Find LAST stat.maktab_fil Use-index maktab04          Where
                stat.maktab_fil.makdes   =   "ISUZU"                     And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0         And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear)  AND
                stat.maktab_fil.engine   >=    Integer(wdetail.engine)   AND
                /*stat.maktab_fil.sclass   =     "****"        AND*/
                (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) /*AND
                 stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)   */   No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                Assign
                wdetail.redbook         =  stat.maktab_fil.modcod
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/ /*A61-0152*/
                /*sic_bran.uwm301.Tons    =  stat.maktab.tons /*A66-0252*/*/
                wdetail.cargrp          =  stat.maktab_fil.prmpac
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body    =  stat.maktab_fil.body.
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest3 c-Win 
PROCEDURE proc_chktest3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR np_prem AS DECI INIT 0.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

ASSIGN  nv_tariff = sic_bran.uwm301.tariff             
    nv_class  = wdetail.prempa + wdetail.subclass
    nv_comdat = sic_bran.uwm100.comdat
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse                     
    nv_COMPER = deci(wdetail.comper)            
    nv_comacc = deci(wdetail.comacc)            
    nv_seats  = INTE(wdetail.seat) 
    nv_seat41 = inte(wdetail.seat41)
    nv_ncbyrs  = 0               
    nv_totsi   = 0  
    fi_process    = "Import data TPIS-renew to base..." + wdetail.policy .    /*A56-0262*/
DISP fi_process WITH FRAM fr_main.

IF wdetail.compul = "Y" THEN DO:
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
ELSE DO:
    ASSIGN
        sic_bran.uwm130.uom8_v  =  0    sic_bran.uwm130.uom9_v  =  0    nv_dsspcvar1 = ""           nv_dsspcvar2 = ""               
        nv_dsspcvar  = ""               nv_usecod    = ""               nv_yrcod     = ""           nv_othcod    = ""  
        nv_useprm    = 0                nv_yrprm     = 0                nv_othprm    = 0            nv_usevar    = ""           
        nv_yrvar     = ""               nv_othvar    = ""  
        nv_basecod   = ""               nv_grpcod    = ""           nv_sicod     = ""               nv_engcod    = ""  
        nv_baseprm   = 0                nv_grprm     = 0            nv_siprm     = 0                nv_engprm    = 0  
        nv_basevar   = ""               nv_grpvar    = ""           nv_sivar     = ""               nv_engvar    = "" 
        nv_drivcod  = ""                nv_biacod   = ""            nv_41cod1  = ""                 nv_42cod    = ""
        nv_drivprm  = 0                 nv_biaprm   = 0             nv_41cod2  = ""                 nv_42prm    = 0
        nv_drivvar  = ""                nv_biavar   = ""            nv_411prm  = 0                  nv_42var    = ""
        nv_bipcod   = ""                nv_pdacod   = ""            nv_412prm  = 0                  nv_43cod    = ""
        nv_bipprm   = 0                 nv_pdaprm   = 0             nv_411var  = ""                 nv_43prm    = 0
        nv_bipvar   = ""                nv_pdavar   = ""            nv_412var  = ""                 nv_43var    = ""
        nv_dedod1_cod = ""              nv_dss_per  = 0             nv_flet_per  = 0                nv_usevar3    = "" 
        nv_dedod1_prm = 0               nv_dsspc    = 0             nv_flet      = 0                nv_usecod3    = "" 
        nv_dedod1var  = ""              nv_dsspcvar = ""            nv_fletvar   = ""               nv_usevar4    = "" 
        nv_dedod2_cod = ""              nv_stf_per  = 0             nv_ncbper    = 0                nv_usevar5    = "" 
        nv_dedod2_prm = 0               nv_stf_amt  = 0             nv_ncb       = 0                nv_basecod3   = "" 
        nv_dedod2var  = ""              nv_stfvar   = ""            nv_ncbvar    = ""               nv_baseprm3   = 0  
        nv_dedpd_cod  = ""              nv_cl_per   = 0             nv_campcod   = ""               nv_basevar3   = "" 
        nv_dedpd_prm  = 0               nv_lodclm   = 0             nv_camprem   = 0                nv_basevar4   = "" 
        nv_dedpdvar   = ""              nv_clmvar   = ""            nv_campvar   = ""               nv_basevar5   = "" 
        nv_sicod3     = ""              nv_sivar3   = ""            nv_sivar4    = ""               nv_sivar5     = "" 
        nv_ncbyrs  = 0                  nv_line     = 0              
        nv_totsi   = 0     .    

    IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2" OR 
       wdetail.covcod = "3.1" OR wdetail.covcod = "3.2"  THEN DO:
        ASSIGN nv_baseprm3 = DECI(wdetail.base3).
        RUN proc_baseplus.
    END.
    ELSE DO: 
        RUN proc_base2.
    END.
END.
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
      nv_pdacod   = "" 
      nv_class = SUBSTRING(nv_class,2,3).
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

IF wdetail.polmaster <> ""  THEN RUN proc_adduwd132.
ELSE IF wdetail.prvpol <> ""  THEN  RUN proc_adduwd132renew. /*A65-0177*/
ELSE DO:
    RUN proc_calpremt.
    RUN proc_adduwd132prem.
END.

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
        /*sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs*/
        sic_bran.uwm301.mv41seat = inte(wdetail.seat41)
        /* A63-0113 */
        sic_bran.uwm301.tons     = IF sic_bran.uwm301.tons = 0 THEN 0 
                                   ELSE IF sic_bran.uwm301.tons < 100 THEN (sic_bran.uwm301.tons * 1000) 
                                   ELSE sic_bran.uwm301.tons.

IF (SUBSTR(wdetail.subclass,1,1) = "3" OR SUBSTR(wdetail.subclass,1,1) = "4" OR
   SUBSTR(wdetail.subclass,1,1)  = "5" OR TRIM(wdetail.subclass) = "803"     OR
   TRIM(wdetail.subclass)  = "804"     OR TRIM(wdetail.subclass) = "805" )   and
   (wdetail.prempa = "T" OR  wdetail.prempa = "A" ) AND sic_bran.uwm301.tons < 100  THEN DO:

   MESSAGE  wdetail.subclass + "ระบุน้ำหนักรถไม่ถูกต้อง " VIEW-AS ALERT-BOX.
   ASSIGN 
       wdetail.comment = wdetail.comment + "|Class " + wdetail.subclass + " น้ำหนักรถไม่ถูกต้อง " 
       wdetail.pass    = "N".
END.       
 /* end A63-0113 */




END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4 c-Win 
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
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND              /*แยกงานตาม Code Producer*/  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_colorcode c-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create100 c-Win 
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
       sic_bran.uwm100.bchyr  = nv_batchyr 
       sic_bran.uwm100.bchno  = nv_batchno 
       sic_bran.uwm100.bchcnt  = nv_batcnt     .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createcomp c-Win 
PROCEDURE proc_createcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wcomp.
    DELETE wcomp.
END.
CREATE wcomp. 
ASSIGN wcomp.package   = "110"  
       wcomp.premcomp  =  645.21 .
CREATE wcomp. 
ASSIGN wcomp.package   = "120A" 
       wcomp.premcomp  =  1182.35 .
CREATE wcomp. 
ASSIGN wcomp.package   = "120B" 
       wcomp.premcomp  =  2203.13 .
CREATE wcomp. 
ASSIGN wcomp.package   = "120C" 
       wcomp.premcomp  =  3437.91.
CREATE wcomp. 
ASSIGN wcomp.package   = "120D" 
       wcomp.premcomp  =  4017.85 . 
CREATE wcomp. 
ASSIGN wcomp.package   = "140A" 
       wcomp.premcomp  =  967.28.
CREATE wcomp. 
ASSIGN wcomp.package   = "140B" 
       wcomp.premcomp  =  1310.75.
CREATE wcomp. 
ASSIGN wcomp.package   = "140C" 
       wcomp.premcomp  =  1408.12.
CREATE wcomp. 
ASSIGN wcomp.package   = "140D" 
       wcomp.premcomp  =  1826.49. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cr_2 c-Win 
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
    len = len - 1   
    n_cr2 = "" .

    FOR EACH buwm100 WHERE 
        buwm100.policy <> wdetail.policy  AND
        buwm100.cedpol =  wdetail.cedpol  NO-LOCK.
        ASSIGN 
            n_cr2 = buwm100.policy.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpol72 c-Win 
PROCEDURE proc_cutpol72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
nv_c = wdetail2.com_no.
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
ASSIGN wdetail2.com_no = nv_c .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpolnoti c-Win 
PROCEDURE proc_cutpolnoti :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
/*nv_c = TRIM(np_notino).*/             /*A58-0489*/
nv_c = TRIM(wdetail2.tpis_no).          /*A58-0489*/
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
/*ASSIGN np_notino = nv_c .*/ /*A58-0489*/
ASSIGN wdetail2.tpis_no = nv_c .    /*A58-0489*/*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_definitions c-Win 
PROCEDURE proc_definitions :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: รายละเอียดการแก้ไขโปรแกรม      
------------------------------------------------------------------------------*/
/*Modify by : Ranu I. A61-0152  14/03/2018 ปลี่ยนแปลงเงื่อนไขการเช็คข้อมูล CC และยี่ห้อรถใหม่ 
           เช็คเงื่อนไขการหาเบอร์กรมธรรม์ในระบบ เพื่อนำส่งตรีเพชร และดึงเบี้ยตามแคมเปญ */
/*Modify by : Ranu I. A61-0416 04/09/2018 แก้ไขคำนำหน้าชื่อดึงข้อมูลจากพารามิเตอร์ */
/*Modify By: Saowapa U. A62-0110  27/02/2019
           แก้ไขเพิ่มข้อมูลรุ่นรถ ISUZU MU-7 ห้ระบบดึงข้อมูลช่อง Car  Model  ตามข้อมูลใบเตือน 
           ปิดโค๊ต B3M0083 พรบ.รายเดียว และใช้โค๊ต A000324 แทน เปลี่ย Branch "37"  ให้เปลี่ยนมาใช้ Branch  "J" ทั้งหมด*/
/*Modify by :  Nontamas H. [A62-0329] Date 08/07/2019 เพิ่มคอลัมน์ เลขที่ใบแจ้งหนี้ */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019 : Change Host => TMSth*/
/*Modify By : Ranu I. A62-0422 Date:10/09/2019 เพิ่มการเก็บข้อมูลจากไฟล์แจ้งงาน ช่อง Garage Repair , Model Description */
/*Modify by : Ranu I. a63-0101 Date: 12/03/2020 ปรับเงื่อนไขการโหลดงาน พรบ. */
/*modify by : Ranu I. A63-0113 เพิ่มเงื่อนไขการเช็คงานที่เริ่มคุ้มครอง 01/04/2020 ให้ใช้ Pack T 
             งานต่ออายุ Pack A ใช้ Pack เดิม */
/*modify by : Kridtiya i. A63-0325 Date. 13/07/2020 เพิ่ม แคมเปญ เข้าระบบ C63/00033 C63/00007 */   
/*modify by : Kridtiya i. A63-0370 Date. 08/08/2020 เพิ่ม การให้ค่าเบี้ยรวม กรณี พบเบี้ยตามแคมเปญ */              
/*Modify by : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by : Ranu I. A64-0344  เพิ่มการเช็คสาขา ภูมิภาคจากพารามิเตอร์ เพิ่มการคำนวณเบี้ยจากโปรแกรมกลาง เช็คการคำนวณเบี้ย รย.ของพารามิเตอร์ campaign */
/*Modify by : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by : Kridtiya i. A65-0035 comment message error premium not on file */
/*Modify by : Ranu I. A66-0084 ยกเลิกการสร้างหน้า Vat สีชมพูและเคลียร์ค่าเดิมให้เป็นค่าว่าง*/
/*Modify by : Ranu I. A66-0252 แก้ไข format file load ,เพิ่มการเก็บสีรถ , เพิ่มการเก็บข้อมูลการตรวจสภาพรถใน memo text*/ 
/*Modify by : kridtiya i. A68-0019 Date. 24/01/2025 แก้ไขที่อยู่ ตัด ซอย ตำบล อำเภอ จังหวัด ออก ++ ตามassign*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exportNote c-Win 
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

ASSIGN 
       n_day       = STRING(TODAY,"99/99/9999")
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam c-Win 
PROCEDURE proc_insnam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A66-0084      
------------------------------------------------------------------------------*/
DEF VAR nv_insname AS CHAR FORMAT "x(200)" .

ASSIGN  n_insref     = ""       nv_usrid     = ""       nv_transfer  = NO 
        n_check      = ""       nv_insref    = ""       nv_typ       = "" 
        nv_usrid     = SUBSTRING(USERID(LDBNAME(1)),3,4) 
        nv_insname   = TRIM(TRIM(wdetail.firstname) + " " + TRIM(wdetail.lastname)) 
        nv_transfer  = YES .  
IF wdetail.insrefno = "" THEN DO:
  FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME   = TRIM(nv_insname)  AND 
    sicsyac.xmm600.homebr    = TRIM(wdetail.branch)  AND 
    sicsyac.xmm600.clicod = "IN"                  NO-ERROR NO-WAIT.  
  IF NOT AVAILABLE sicsyac.xmm600 THEN DO:
    IF LOCKED sicsyac.xmm600 THEN DO:   
        ASSIGN nv_transfer = NO     n_insref = sicsyac.xmm600.acno.
        RETURN.
    END.
    ELSE DO:
      ASSIGN n_check = "" nv_insref  = "".
      IF TRIM(wdetail.tiname) <> " " THEN DO: 
        IF  R-INDEX(TRIM(wdetail.tiname),"จก.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"จำกัด")           <> 0  OR  
            R-INDEX(TRIM(wdetail.tiname),"(มหาชน)")         <> 0  OR R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR INDEX(TRIM(wdetail.tiname),"บริษัท")            <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"บ.")                <> 0  OR INDEX(TRIM(wdetail.tiname),"บจก.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"หจก.")              <> 0  OR INDEX(TRIM(wdetail.tiname),"หสน.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"บรรษัท")            <> 0  OR INDEX(TRIM(wdetail.tiname),"มูลนิธิ")           <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"ห้าง")              <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วน")      <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
            INDEX(TRIM(wdetail.tiname),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
        ELSE nv_typ = "0s".   /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/
      END.
      ELSE DO:                  /* ---- Check ด้วย name ---- */
        IF  R-INDEX(TRIM(wdetail.tiname),"จก.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"จำกัด")           <> 0  OR  
            R-INDEX(TRIM(wdetail.tiname),"(มหาชน)")         <> 0  OR R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR INDEX(TRIM(wdetail.tiname),"บริษัท")            <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"บ.")                <> 0  OR INDEX(TRIM(wdetail.tiname),"บจก.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"หจก.")              <> 0  OR INDEX(TRIM(wdetail.tiname),"หสน.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"บรรษัท")            <> 0  OR INDEX(TRIM(wdetail.tiname),"มูลนิธิ")           <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"ห้าง")              <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วน")      <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
            INDEX(TRIM(wdetail.tiname),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
        ELSE nv_typ = "0s".  /*0s= บุคคลธรรมดา Cs = นิติบุคคล */
      END.
      RUN proc_insno. 
      IF n_check <> "" THEN DO:
          ASSIGN nv_transfer = NO
              nv_insref   = "".
          RETURN.
      END.
      loop_runningins:  /* Check Insured  */
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
      ELSE DO:
          ASSIGN 
              wdetail.pass    = "N"  
              wdetail.comment = wdetail.comment + "| รหัสลูกค้าเป็นค่าว่างไม่สามารถนำเข้าระบบได้ค่ะ" 
              WDETAIL.OK_GEN  = "N"
              nv_transfer = NO.
      END.
    END.
    n_insref = nv_insref.
  END.
  ELSE DO:  /* กรณีพบ */
    IF sicsyac.xmm600.acno <> "" THEN    
      ASSIGN
        nv_insref               = trim(sicsyac.xmm600.acno) 
        wdetail.insrefno        = nv_insref
        n_insref                = trim(nv_insref) 
        nv_transfer             = NO 
        sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                        /*First Name*/
        sicsyac.xmm600.name     = TRIM(TRIM(wdetail.firstname) + " " + TRIM(wdetail.lastname))      /*Name Line 1*/
        sicsyac.xmm600.abname   = TRIM(TRIM(wdetail.firstname) + " " + TRIM(wdetail.lastname))      /*Abbreviated Name*/
        sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*//*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)       /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)       /*Address line 3*/
        sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4) 
        sicsyac.xmm600.postcd   = TRIM(wdetail.post)        /*Postal Code*/
        sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
        sicsyac.xmm600.opened   = TODAY                     
        sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid 
        sicsyac.xmm600.dtyp20   = ""   
        sicsyac.xmm600.dval20   = "" 
        /* add by : Ranu I. A66-0084 */ /* vat ชมพู */
        sicsyac.xmm600.nbr_insure = ""
        sicsyac.xmm600.nntitle    = ""
        sicsyac.xmm600.nfirstName = ""
        sicsyac.xmm600.nlastname  = ""
        sicsyac.xmm600.nicno      = ""
        sicsyac.xmm600.nphone   = ""
        sicsyac.xmm600.naddr1   = ""
        sicsyac.xmm600.naddr2   = ""
        sicsyac.xmm600.naddr3   = ""
        sicsyac.xmm600.naddr4   = ""
        sicsyac.xmm600.npost    = ""
        sicsyac.xmm600.anlyc1   = "" .
        /*....end A66-0084...*/
  END.
END.
ELSE DO:
  FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
      sicsyac.xmm600.acno   = TRIM(wdetail.insrefno)  NO-ERROR NO-WAIT.  
  IF AVAILABLE sicsyac.xmm600 THEN 
    ASSIGN
      nv_insref               = trim(sicsyac.xmm600.acno) 
      n_insref                = trim(nv_insref) 
      wdetail.insrefno        = nv_insref
      nv_transfer             = NO 
      sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
      sicsyac.xmm600.fname    = ""                        /*First Name*/
      sicsyac.xmm600.name     = TRIM(TRIM(wdetail.firstname) + " " + TRIM(wdetail.lastname))      /*Name Line 1*/
      sicsyac.xmm600.abname   = TRIM(TRIM(wdetail.firstname) + " " + TRIM(wdetail.lastname))      /*Abbreviated Name*/
      sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*//*--Crate by Amparat C. A51-0071--*/
      sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       /*Address line 1*/
      sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)       /*Address line 2*/
      sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)       /*Address line 3*/
      sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4)  
      sicsyac.xmm600.postcd   = TRIM(wdetail.post)        /*Postal Code*/
      sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
      sicsyac.xmm600.opened   = TODAY                     
      sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
      sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
      sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
      sicsyac.xmm600.usrid    = nv_usrid 
      sicsyac.xmm600.dtyp20   = ""   
      sicsyac.xmm600.dval20   = ""   
      /* add by : Ranu I. A66-0084 *//* vat ชมพู */
      sicsyac.xmm600.nbr_insure = ""
      sicsyac.xmm600.nntitle    = ""
      sicsyac.xmm600.nfirstName = ""
      sicsyac.xmm600.nlastname  = ""
      sicsyac.xmm600.nicno      = ""
      sicsyac.xmm600.nphone   = ""
      sicsyac.xmm600.naddr1   = ""
      sicsyac.xmm600.naddr2   = ""
      sicsyac.xmm600.naddr3   = ""
      sicsyac.xmm600.naddr4   = ""
      sicsyac.xmm600.npost    = ""
      sicsyac.xmm600.anlyc1   = "" .
      /*....end A66-0084...*/
END.
IF nv_transfer = YES THEN DO:
  IF nv_insref  <> "" THEN 
    ASSIGN
      wdetail.insrefno        = nv_insref
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
      sicsyac.xmm600.name     = TRIM(trim(wdetail.firstname) + " " + TRIM(wdetail.lastname))      /*Name Line 1*/
      sicsyac.xmm600.abname   = TRIM(trim(wdetail.firstname) + " " + TRIM(wdetail.lastname))      /*Abbreviated Name*/
      sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
      sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       /*Address line 1*/
      sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)       /*Address line 2*/
      sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)       /*Address line 3*/
      sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4)       /*Address line 4*/
      sicsyac.xmm600.postcd   = TRIM(wdetail.post)        /*Postal Code*/
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
      sicsyac.xmm600.anlyc5   = ""                      /*Analysis Code 5*/
      sicsyac.xmm600.dtyp20   = ""     
      sicsyac.xmm600.dval20   = "" 
      /* add by : Ranu I. A66-0084 */
      /* vat ชมพู */
      sicsyac.xmm600.nbr_insure = ""
      sicsyac.xmm600.nntitle    = ""
      sicsyac.xmm600.nfirstName = ""
      sicsyac.xmm600.nlastname  = ""
      sicsyac.xmm600.nicno      = ""
      sicsyac.xmm600.nphone   = ""
      sicsyac.xmm600.naddr1   = ""
      sicsyac.xmm600.naddr2   = ""
      sicsyac.xmm600.naddr3   = ""
      sicsyac.xmm600.naddr4   = ""
      sicsyac.xmm600.npost    = ""
      sicsyac.xmm600.anlyc1   = "" .
      /*....end A66-0084...*/
END.
IF sicsyac.xmm600.acno <> ""  THEN DO:
  ASSIGN nv_insref = sicsyac.xmm600.acno.
  nv_transfer = YES.
  FIND sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
  IF NOT AVAILABLE sicsyac.xtm600 THEN DO:
      IF LOCKED sicsyac.xtm600 THEN DO:
          nv_transfer = NO.
          RETURN.
      END.
      ELSE DO:
          IF nv_insref <> "" THEN  CREATE sicsyac.xtm600.
      END.
  END.
  IF nv_transfer = YES THEN DO:
      IF nv_insref <> "" THEN  
        ASSIGN
          sicsyac.xtm600.acno    = nv_insref               /*Account no.*/
          sicsyac.xtm600.name    = TRIM((wdetail.firstname) + " " + TRIM(wdetail.lastname))   /*Name of Insured Line 1*/
          sicsyac.xtm600.abname  = TRIM((wdetail.firstname) + " " + TRIM(wdetail.lastname))    /*Abbreviated Name*/
          sicsyac.xtm600.addr1   = TRIM(wdetail.iadd1)     /*address line 1*/
          sicsyac.xtm600.addr2   = TRIM(wdetail.iadd2)     /*address line 2*/
          sicsyac.xtm600.addr3   = TRIM(wdetail.iadd3)     /*address line 3*/
          sicsyac.xtm600.addr4   = TRIM(wdetail.iadd4)     /*address line 4*/
          sicsyac.xtm600.name2   = ""                      /*Name of Insured Line 2*/
          sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)    /*Title*/
          sicsyac.xtm600.name3   = ""                      /*Name of Insured Line 3*/
          sicsyac.xtm600.fname   = ""   .                   /*First Name*/
  END.
END.
RUN proc_insnam2.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
RETURN.
HIDE MESSAGE NO-PAUSE. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam2 c-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insno c-Win 
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
    sicsyac.xzm056.seqtyp   =  nv_typ        AND
    sicsyac.xzm056.branch   =  wdetail.branch     NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp   =  nv_typ
            sicsyac.xzm056.branch   =  wdetail.branch
            sicsyac.xzm056.des      =  "Personal/Start"
            sicsyac.xzm056.lastno   =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref     =    wdetail.branch   + String(1,"999999")
            nv_lastno  =    1.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(wdetail.branch) = 2 THEN
            nv_insref = wdetail.branch + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:   
            /*comment by Kridtiya i. A56-0310...
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + wdetail.branch + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       wdetail.branch + STRING(sicsyac.xzm056.lastno + 1 ,"999999").*/
            /*Add A56-0310 */
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
                ELSE nv_insref = TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.
            /*Add A56-0310 */
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
            /*comment by Kridtiya i. A56-0310....
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       wdetail.branch + STRING(sicsyac.xzm056.lastno,"999999").    kridtiya i. A56-0310 .*/
            /*add A56-0310 */
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
                ELSE nv_insref = TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.
            /*add A56-0310 */
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
   /* MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_mailtxt c-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab c-Win 
PROCEDURE proc_maktab :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Find LAST stat.maktab_fil Use-index maktab04          Where
    stat.maktab_fil.makdes   =   "isuzu"              And                  
    index(stat.maktab_fil.moddes,wdetail.model) <> 0             And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
    stat.maktab_fil.engine   >=    Integer(wdetail.cc)   AND 
    /*stat.maktab_fil.sclass   =     "****"        AND*/
    (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
     stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) /*AND
     stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)   */
    No-lock no-error no-wait.
If  avail stat.maktab_fil  Then DO:
    Assign
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/ /*A61-0152*/
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.Tons    =  stat.maktab.tons /*A66-0252*/
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body.
END.
/* A66-0252 */
ELSE IF wdetail.poltyp  = "V72" THEN  DO:
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
/* end A66-0252 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchbran c-Win 
PROCEDURE proc_matchbran :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0344..
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
 end A64-0344...*/
 /* add by : A64-0344 */
 FIND LAST stat.insure USE-INDEX insure01 WHERE 
          stat.insure.compno  = "TPIS-BR"     AND 
          stat.insure.branch  = trim(wdetail2.branch) NO-LOCK NO-ERROR .
 IF AVAIL stat.insure THEN DO:
    ASSIGN wdetail2.bran_name  = stat.insure.fname    /* ชื่อสาขา */    
           wdetail2.bran_name2 = stat.insure.lname    /* สาขา */    
           wdetail2.region     = stat.Insure.Addr3.   /* ภูมิภาค */ 
    /*
    "branch   " stat.insure.branch  SKIP  /* สาขา */
    "vatcode  " stat.insure.vatcode skip  /* สาขาปีต่ออายุ */
    "fname    " stat.insure.fname   SKIP      /* ชื่อสาขา */
    "lname    " stat.insure.lname   SKIP      /* สาขา */
    "addr3    " stat.Insure.Addr3   SKIP(1) . /* ภูมิภาค */
    */
END.
/*...end A64-0344..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchtypins c-Win 
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

    IF R-INDEX(np_name1,".") <> 0 THEN np_name1 = SUBSTR(np_name1,R-INDEX(np_name1,".")). /* A66-0084*/

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matfileload c-Win 
PROCEDURE proc_matfileload :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each  wdetail2 :                             
    DELETE  wdetail2.                            
END.
ASSIGN nv_memo1 = ""
       nv_memo2 = ""
       nv_meno3 = "".
ASSIGN fi_process   = "Match file load TPIS-renew.......".    /*A56-0262*/
        DISP fi_process WITH FRAM fr_main.
INPUT FROM VALUE (fi_filename) .                                   
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
        wdetail2.usage               
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
        wdetail2.prvpol
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
        wdetail2.occup.
    IF INDEX(wdetail2.ins_ytyp,"mail") <> 0 THEN DO:
        ASSIGN nv_memo1 = wdetail2.bus_typ 
               nv_memo2 = wdetail2.TASreceived  
               nv_meno3 = wdetail2.InsCompany.
    END.
    ELSE IF index(wdetail2.ins_ytyp,"ins.")   <> 0 THEN DELETE wdetail2.   
    ELSE IF index(wdetail2.ins_ytyp,"Ins.")   <> 0 THEN DELETE wdetail2.            
    ELSE IF index(wdetail2.ins_ytyp,"first")  <> 0 THEN DELETE wdetail2.  
    ELSE IF index(wdetail2.ins_ytyp,"First")  <> 0 THEN DELETE wdetail2. 
    ELSE IF TRIM(wdetail2.tpis_no) = ""  THEN DELETE wdetail2. 
END.
RUN pro_chkfile.
/*RUN Pro_createfileexcel.*/  /***Block By Nontamas H. [A62-0329] Date 08/07/2019*****/
 /***Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
RUN Pro_createfileexcelHD.
RUN Pro_createfileexcelDT.
 /***End Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matfileloadstk c-Win 
PROCEDURE proc_matfileloadstk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Load Text file Sticker til */
For each  wdetail2 :                             
    DELETE  wdetail2.                            
END.
INPUT FROM VALUE (fi_filename) .                                   
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
            wdetail2.usage               
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
            wdetail2.prvpol
            wdetail2.branch
            wdetail2.cover
            wdetail2.pol_netprem
            wdetail2.pol_gprem
            wdetail2.pol_stamp
            wdetail2.pol_vat
            wdetail2.pol_wht
            wdetail2.com_no
            wdetail2.docno           /****Add by Nontamas H. [A62-0329] Date 08/07/2019***/
            wdetail2.stkno
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
            wdetail2.regis_no
            wdetail2.np_f18line1 
            wdetail2.np_f18line2 
            wdetail2.np_f18line3 
            wdetail2.np_f18line4 
            wdetail2.np_f18line5
            wdetail2.np_f18line6  /*A63-0259*/
            wdetail2.np_f18line7  /*A63-0259*/
            wdetail2.np_f18line8  /*A63-0259*/
            wdetail2.producer.
       IF index(wdetail2.ins_ytyp,"ins.")       <> 0 THEN DELETE wdetail2.  
       ELSE IF index(wdetail2.ins_ytyp,"Ins.")  <> 0 THEN DELETE wdetail2.      
       ELSE IF index(wdetail2.ins_ytyp,"first") <> 0 THEN DELETE wdetail2. 
       ELSE IF index(wdetail2.ins_ytyp,"First") <> 0 THEN DELETE wdetail2.     
       ELSE IF TRIM(wdetail2.stkno) = ""  THEN DELETE wdetail2.     
END.   /* repeat   */
FOR EACH wdetail2.
  /*Create by A58-0489 .............................*/
  IF TRIM(wdetail2.tpis_no) = ""  THEN DELETE wdetail2.
  ELSE DO:
    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = trim(wdetail2.com_no) NO-LOCK NO-ERROR .
    IF AVAIL sicuw.uwm100 THEN DO:
        IF ( sicuw.uwm100.name1  <>  "" ) OR ( sicuw.uwm100.comdat <> ? )  THEN DO:
            FIND FIRST brstat.tlt    WHERE 
                brstat.tlt.nor_noti_tlt   = trim(wdetail2.com_no)   AND 
                brstat.tlt.genusr         = "til72"                 NO-ERROR NO-WAIT .
            IF AVAIL brstat.tlt THEN DO:
                IF INDEX(tlt.releas,"cancel") <> 0 THEN
                    ASSIGN tlt.releas   = "yes/Cancel".
                ELSE ASSIGN tlt.releas  = "yes".
            END.
        END.
    END.
  END.
END.
For each  wdetail2 :                             
    DELETE  wdetail2.                            
END.
MESSAGE "Match Sticker Complete" VIEW-AS ALERT-BOX.
RELEASE brstat.tlt.
RELEASE sicuw.uwm100.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matpol c-Win 
PROCEDURE proc_matpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File ส่งห้องผลิต     
------------------------------------------------------------------------------*/
DO:                                                  
    For each  wdetail2 :                             
        DELETE  wdetail2.                            
    END.
    INPUT FROM VALUE (fi_filename) .                                   
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
            wdetail2.usage               
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
            wdetail2.prvpol
            wdetail2.branch
            wdetail2.cover
            wdetail2.pol_netprem
            wdetail2.pol_gprem
            wdetail2.pol_stamp
            wdetail2.pol_vat
            wdetail2.pol_wht
            wdetail2.com_no
            wdetail2.docno   /****Add by Nontamas H. [A62-0329] Date 04/07/2019***/
            wdetail2.stkno
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
            wdetail2.regis_no
            wdetail2.np_f18line1  
            wdetail2.np_f18line2  
            wdetail2.np_f18line3  
            wdetail2.np_f18line4  
            wdetail2.np_f18line5
            wdetail2.np_f18line6  /*Kridtiya i. A63-0259*/
            wdetail2.np_f18line7  /*Kridtiya i. A63-0259*/
            wdetail2.np_f18line8  /*Kridtiya i. A63-0259*/
            /* A66-0252 */
            wdetail2.np_f18line9
            wdetail2.insp
            wdetail2.ispno
            wdetail2.detail
            wdetail2.damage
            wdetail2.ispacc
            /* A66-0252 */
            /*wdetail2.campaign_ov*/  /*Add by Kridtiya i. A63-0472*/ /* A65-0177*/
            wdetail2.producer
            wdetail2.product . /*A65-0177*/

        IF index(wdetail2.ins_ytyp,"ins.")        <> 0 THEN DELETE wdetail2.   
        ELSE IF index(wdetail2.ins_ytyp,"Ins.")   <> 0 THEN DELETE wdetail2.            
        ELSE IF index(wdetail2.ins_ytyp,"first")  <> 0 THEN DELETE wdetail2.    
        ELSE IF index(wdetail2.ins_ytyp,"First")  <> 0 THEN DELETE wdetail2.     
        ELSE IF wdetail2.tpis_no = ""  THEN DELETE wdetail2.   
    END.   /* repeat   */
    RUN pro_createpol.
END. /*-Repeat-*/  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matpoltil c-Win 
PROCEDURE proc_matpoltil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File ส่งกลับ TIL      
------------------------------------------------------------------------------*/
DO:                                                  
    For each  wdetail2 :                             
        DELETE  wdetail2.                            
    END.
    INPUT FROM VALUE (fi_filename) .                                   
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
            wdetail2.usage               
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
            wdetail2.garage       /*a62-0422*/
            wdetail2.desmodel     /*a62-0422*/
            wdetail2.si                   
            wdetail2.pol_comm_date     
            wdetail2.pol_exp_date     
            wdetail2.prvpol
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
            wdetail2.regis_no.
        IF index(wdetail2.ins_ytyp,"ins.")       <> 0 THEN DELETE wdetail2.  
        ELSE IF index(wdetail2.ins_ytyp,"Ins.")  <> 0 THEN DELETE wdetail2.            
        ELSE IF index(wdetail2.ins_ytyp,"first") <> 0 THEN DELETE wdetail2.  
        ELSE IF index(wdetail2.ins_ytyp,"First") <> 0 THEN DELETE wdetail2.     
        ELSE IF wdetail2.tpis_no = ""  THEN DELETE wdetail2.
    END.   /* repeat   */
    RUN pro_createpol_til.
END. /*-Repeat-*/   

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open c-Win 
PROCEDURE proc_open :
/*OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y".   */
OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policy c-Win 
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
ASSIGN fi_process    = "Import data TPIS-renew to uwm100..." + wdetail.policy .    /*A56-0262*/
    DISP fi_process WITH FRAM fr_main.
IF wdetail.policy <> "" THEN DO:
    IF wdetail.poltyp = "v70" THEN
        ASSIGN n_stkk = wdetail.stk
               wdetail.stk = "".
    IF wdetail.stk  <>  ""  THEN DO: 
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        IF wdetail.poltyp = "V72" THEN DO:
            FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
                sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN  
                        ASSIGN
                        wdetail.pass    = "N"
                        wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                        wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            END.
        END.
        ELSE DO:
            FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
                sicuw.uwm100.cedpol =  wdetail.cedpol  AND 
                sicuw.uwm100.poltyp =  wdetail.poltyp  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN DO:
                    IF sicuw.uwm100.expdat > DATE(wdetail.comdat) THEN
                        ASSIGN
                        wdetail.pass    = "N"
                        wdetail.comment = wdetail.comment + "| เลขที่สัญญานี้ได้ถูกใช้ไปแล้ว "
                        wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
                END.
            END.
        END.
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk      NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
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
        IF wdetail.poltyp = "v70" THEN DO:
            FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
                sicuw.uwm100.cedpol =  wdetail.cedpol  AND 
                sicuw.uwm100.poltyp =  wdetail.poltyp  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN DO: 
                    IF sicuw.uwm100.expdat > DATE(wdetail.comdat) THEN
                        ASSIGN
                        wdetail.pass    = "N"
                        wdetail.comment = wdetail.comment + "| เลขที่สัญญานี้ได้ถูกใช้ไปแล้ว "
                        wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
                END.
                RUN proc_create100. 
            END.
            ELSE RUN proc_create100. 
        END.
        ELSE DO:
            FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
                sicuw.uwm100.policy = wdetail.policy   AND 
                sicuw.uwm100.poltyp = wdetail.poltyp   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES THEN DO:
                    IF sicuw.uwm100.expdat > DATE(wdetail.comdat) THEN
                        ASSIGN                               
                        wdetail.pass    = "N"
                        wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                        wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
                END.
                IF wdetail.policy = "" THEN DO:
                    RUN proc_temppolicy.
                    wdetail.policy  = nv_tmppol.
                END.
                RUN proc_create100. 
            END.  /*policy <> "" & stk = ""*/                 
            ELSE RUN proc_create100.  /*add A52-0172*/
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
            ASSIGN wdetail.pass    = "N"
                   wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001  WHERE
            sicuw.uwm100.policy =  wdetail.policy   AND
            sicuw.uwm100.poltyp =  wdetail.poltyp   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN DO: 
                IF sicuw.uwm100.expdat > DATE(wdetail.comdat) THEN
                    ASSIGN
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            END.
        END.   /*add kridtiya i..*/
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk      NO-LOCK NO-ERROR.
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
/* A66-0084...
IF R-INDEX(wdetail.insnam,".") <> 0 THEN 
    wdetail.insnam = SUBSTR(wdetail.insnam,R-INDEX(wdetail.insnam,".")).*/
IF wdetail.prvpol = "" THEN n_firstdat = DATE(wdetail.comdat).        /*kridtiya i . A53-0220*/
/*IF wdetail.insrefno = " " THEN DO: RUN proc_insnam .   END.*/    /*A58-0489*/ /*A61-0152*/
RUN proc_insnam . /*A61-0152*/
RUN proc_insnam2 . /*Add by Kridtiya i. A63-0472*/
/* add by : A64-0344 */
IF wdetail.insrefno = ""  THEN DO:
   ASSIGN  wdetail.pass    = "N"
   wdetail.comment = wdetail.comment + "| Insured Code เป็นค่าว่าง กรุณาตรวจสอบรันนิ่งสาขา " + trim(wdetail.branch)
   wdetail.warning = wdetail.WARNING + "Insured Code เป็นค่าว่าง".
END.
/* end : A64-0344 */
DO TRANSACTION:
   ASSIGN
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = trim(wdetail.poltyp)
      sic_bran.uwm100.insref = trim(wdetail.insrefno)
      sic_bran.uwm100.opnpol = wdetail.promo    /*A58-0489*/
      sic_bran.uwm100.cr_1   = wdetail.product  /*A65-0177*/
      sic_bran.uwm100.anam2  = trim(wdetail.Icno)       /* ICNO  Cover Note A51-0071 Amparat */
      sic_bran.uwm100.ntitle = trim(wdetail.tiname)
      /*sic_bran.uwm100.name1  = TRIM(wdetail.insnam) */ /*A58-0489*/
      /*sic_bran.uwm100.name1  = IF wdetail.nDirec <> " "  THEN TRIM(wdetail.insnam)  + " (" + wdetail.nDirec + ")" ELSE TRIM(wdetail.insnam)*/ /*A66-0084*/
      /*sic_bran.uwm100.name2  = IF ra_typload = 1 THEN "" ELSE  trim(wdetail.insnam2)  /*"และ/หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด" */*/ /*A58-0489*/
      /*sic_bran.uwm100.name2  = TRIM(wdetail.insnam2)*//*A66-0084*/
      sic_bran.uwm100.name1  = trim(TRIM(wdetail.firstname) + " " + TRIM(wdetail.lastname))                    /*A66-0084*/
      sic_bran.uwm100.name2  = IF wdetail.nDirec <> " "  THEN trim(wdetail.nDirec) ELSE TRIM(wdetail.insnam2)  /*A66-0084*/
      sic_bran.uwm100.name3  = IF wdetail.nDirec <> " "  THEN TRIM(wdetail.insnam2) ELSE ""                    /*A66-0084*/
      sic_bran.uwm100.addr1  = TRIM(wdetail.iadd1)      
      sic_bran.uwm100.addr2  = TRIM(wdetail.iadd2)     
      sic_bran.uwm100.addr3  = TRIM(wdetail.iadd3)     
      sic_bran.uwm100.addr4  = TRIM(wdetail.iadd4)  
      sic_bran.uwm100.postcd  =  "" 
      sic_bran.uwm100.undyr  = String(Year(today),"9999")   /*   nv_undyr  */
      sic_bran.uwm100.branch = caps(trim(wdetail.branch))   /* nv_branch  */                        
      sic_bran.uwm100.dept   = nv_dept
      sic_bran.uwm100.usrid  = USERID(LDBNAME(1))
      sic_bran.uwm100.fstdat = n_firstdat 
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
      sic_bran.uwm100.prog   = "wgwrtpis"
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
      sic_bran.uwm100.agent  = trim(wdetail.agent)     /*nv_agent   */
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
      sic_bran.uwm100.prvpol = caps(TRIM(wdetail.prvpol))      /*A52-0172*/
      sic_bran.uwm100.cedpol = TRIM(wdetail.cedpol)
      /*sic_bran.uwm100.finint = nv_deler*/ /*A61-0152*/
      sic_bran.uwm100.finint = wdetail.finint     /*A61-0152*/
      sic_bran.uwm100.dealer = wdetail.financecd  /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.occupn = wdetail.occup      
      /*sic_bran.uwm100.bs_cd  = "MC16182".*/     /* Kridtiya i. A53-0183 .............*/
      sic_bran.uwm100.bs_cd  =  ""      /*.vatcode*/ 
      sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)     /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)      /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.postcd     = trim(wdetail.postcd)        /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.icno       = trim(wdetail.icno)          /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)       /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)     /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)     /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)     /*Add by Kridtiya i. A63-0472*/
      /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*/    /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov).  /*Add by Kridtiya i. A63-0472*/

      IF wdetail.prvpol <> " " THEN DO:
          IF wdetail.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = ""
                                                 sic_bran.uwm100.tranty  = "R".  
          ELSE 
              ASSIGN
                  sic_bran.uwm100.prvpol  = caps(TRIM(wdetail.prvpol))  /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                  sic_bran.uwm100.tranty  = "R".                        /*Transaction Type (N/R/E/C/T)*/
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
END. /*transaction*//*
IF wdetail.sendnam <> ""  THEN RUN proc_uwd100.   
ELSE IF wdetail.chkcar <> ""  THEN RUN proc_uwd100.   
ELSE IF wdetail.telno  <> ""   THEN RUN proc_uwd100. */
/*kridtiya i. A52-0293.....*/
RUN proc_uwd102. /* A66-0252*/
/*IF wdetail.poltyp = "V70" THEN  RUN proc_uwd102.*/ /* A66-0252*/
/*IF wdetail.poltyp = "V70" AND wdetail.remark <> ""  THEN  RUN proc_uwd100. A61-0152*/
IF wdetail.poltyp = "V70" AND wdetail.remark <> "" OR wdetail.campens <> "" THEN  RUN proc_uwd100. /*A61-0152*/
 /* --------------------U W M 1 2 0 -------------- */
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
            sic_bran.uwm120.class  = trim(wdetail.prempa)  + trim(wdetail.subclass)
            s_recid2     = RECID(sic_bran.uwm120).
    END. 
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_prmtxt c-Win 
PROCEDURE proc_prmtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Add by :  A65-0177 */
IF wdetail.prmtxt = ""  THEN DO:
    IF index(wdetail.product,"P1") <> 0  THEN DO:
        ASSIGN 
              SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "คุ้มครองอุปกรณ์ มูลค่าไม่เกิน 30,000 บาท " .
    END.
    ELSE IF  index(wdetail.product,"P2") <> 0  THEN DO:
        ASSIGN 
            SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "คุ้มครองอุปกรณ์ตามมูลค่าจริงไม่เกิน 50,000 บาท "
            SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = "(ไม่คุ้มครองเครื่องทำความเย็น)" .
    END.
    ELSE IF  index(wdetail.product,"P4") <> 0  THEN DO:
        ASSIGN 
            SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "คุ้มครองอุปกรณ์  ตามมูลค่าจริงไม่เกิน 80,000 บาท" .
    END.
END.
ELSE DO:
/* end A65-0177 */
 /*IF wdetail.prmtxt   <> ""  THEN ASSIGN nv_acc5 = TRIM(wdetail.prmtxt) .*/ /* A65-0177*/
   ASSIGN   
            nv_acc1 = ""
            nv_acc2 = ""
            nv_acc3 = ""
            nv_acc4 = ""
            nv_acc5 = ""
            nv_acc5 = TRIM(wdetail.prmtxt) . /* A65-0177*/.
         loop_chk1:
         REPEAT:
             IF (INDEX(nv_acc5," ") <> 0 ) AND LENGTH(nv_acc1 + TRIM(SUBSTR(nv_acc5,1,INDEX(nv_acc5," ")))) <= 60 THEN 
                 ASSIGN  nv_acc1 = trim(nv_acc1 + " " + TRIM(SUBSTR(nv_acc5,1,INDEX(nv_acc5," "))))
                 nv_acc5 = TRIM(SUBSTR(nv_acc5,INDEX(nv_acc5," "))).
             ELSE LEAVE loop_chk1.
         END.
         IF nv_acc5 <> "" THEN
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

         IF (nv_acc4 <> "") AND (length(nv_acc4 + " " + nv_acc5 ) <= 60 ) THEN 
             ASSIGN nv_acc4 = nv_acc4  + " " + nv_acc5 
             nv_acc5 = "" .
         ELSE IF (nv_acc3 <> "") AND (length(nv_acc3 + " " + nv_acc5 ) <= 60 ) THEN 
             ASSIGN nv_acc3 = nv_acc3  + " " + nv_acc5
             nv_acc5 = "" .
         ELSE IF (nv_acc2 <> "") AND (length(nv_acc2 + " " + nv_acc5 ) <= 60 ) THEN 
             ASSIGN nv_acc2 = nv_acc2  + " " + nv_acc5
             nv_acc5 = "" .
         ELSE IF (nv_acc1 <> "") AND (length(nv_acc1 + " " + nv_acc5 ) <= 60 ) THEN
             ASSIGN  nv_acc1 = nv_acc1  + " " + nv_acc5
             nv_acc5 = "" .
        /* comment by : A65-0177...
        ASSIGN 
          SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  nv_acc1 
          SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  nv_acc2 
          SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  nv_acc3 
          SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  nv_acc4  
          SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  nv_acc5. 
       ...end A65-0177...*/
        /* add by : A65-0177 */
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
        /* end : A65-0177 */
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew c-Win 
PROCEDURE proc_renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail.prvpol   No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF sicuw.uwm100.renpol <> " "  THEN DO:
        MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
        ASSIGN  
            wdetail.prvpol  = "Already Renew"        /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
            wdetail.comment = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
            WDETAIL.OK_GEN  = "N"
            wdetail.pass    = "N". 
    END.
    ELSE DO: 
        ASSIGN  
            wdetail.prvpol = sicuw.uwm100.policy
            n_rencnt  =  sicuw.uwm100.rencnt  +  1
            n_endcnt  =  0
            wdetail.pass  = "Y".
        RUN proc_assignrenew.            /*รับค่า ความคุ้มครองของเก่า */
    END.
END.   /*  avail  uwm100  */
Else do:  
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0
        wdetail.prvpol   = ""
        wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".

END.   /*not  avail uwm100*/
IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 c-Win 
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
        "redbook    "   "," 
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
            wdetail.redbook     ","
            wdetail.poltyp      ","
            wdetail.policy      ","
            wdetail.entdat      ","
            wdetail.enttim      ","
            wdetail.trandat     ","
            wdetail.trantim     ","
            wdetail.prvpol      ","
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
            wdetail.cancel      ","
            wdetail.WARNING     ","
            wdetail.comment     ","
            wdetail.seat41      ","
            wdetail.pass        ","   
            wdetail.OK_GEN      ","   
            wdetail.comper      ","   
            wdetail.comacc      ","   
            wdetail.NO_411       ","   
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT2 c-Win 
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
            "redbook   "     ","    
            "base      "     ","    
            "accdat    "     ","    
            "docno     "     ","    
            "ICNO      "     ","    
            "CoverNote "    
            
        SKIP.        
    FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
        wdetail.branch       ","
        wdetail.entdat       ","
        wdetail.enttim       ","
        wdetail.trandat      ","
        wdetail.trantim      ","
        wdetail.poltyp       ","
        wdetail.policy       ","
        wdetail.prvpol       ","
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
        wdetail.inscod       ","   
        wdetail.premt        ","   
        wdetail.redbook      ","   
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen c-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 c-Win 
PROCEDURE proc_sic_exp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR pv_conpara AS CHAR FORMAT "x(150)" INIT "".
/*create by kridtiya i. A53-0220*/
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
  /*A68-0019*/ 
  FIND FIRST sicsyac.dbtable WHERE sicsyac.dbtable.phyname = "expiry"
      NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL sicsyac.dbtable THEN pv_conpara = sicsyac.dbtable.unixpara.
  ELSE pv_conpara = "". 
  pv_conpara = pv_conpara +    " -U " + gv_id + " -P " + nv_pwd.   
  /*A68-0019*/

  IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
      /*CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) . */ /*Production จริง*/
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) .     /*Production จริง*/*//*A62-0105*/
      /*CONNECT expiry -H devserver -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) . */  /*db dev.*/  

      CONNECT VALUE(pv_conpara) NO-ERROR. /*A66-0266*/

      CLEAR FRAME nf00.
      HIDE FRAME nf00.

      RETURN. 
    
   END.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_stkfinddup c-Win 
PROCEDURE proc_stkfinddup :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*เช็ค เลขสติ๊กเกอร์ซ้ำในไฟล์เดียวกัน*/
DEF BUFFER bwdetail FOR wdetail.
FIND FIRST bwdetail WHERE bwdetail.stk = wdetail.stk AND
                          bwdetail.policy NE wdetail.policy NO-LOCK NO-ERROR NO-WAIT .
IF AVAIL bwdetail THEN
    ASSIGN 
        wdetail.comment = wdetail.comment + wdetail.stk + "| พบ เลขสติ๊กเกอร์ซ้ำในระบบ"
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_susspect c-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_TempPolicy c-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_usdcod c-Win 
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
FIND FIRST ws0m009 WHERE 
    ws0m009.policy  = nv_driver  AND
    ws0m009.lnumber = 1  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE ws0m009 THEN  ASSIGN  nv_drivage1 =  inte(replace(trim(substr(ws0m009.ltext2,11,5)),"-","")).
ELSE nv_drivage1 = 0 .
FIND FIRST ws0m009 WHERE 
    ws0m009.policy  = nv_driver  AND
    ws0m009.lnumber = 2  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE ws0m009 THEN  ASSIGN  nv_drivage2 =  inte(replace(trim(substr(ws0m009.ltext2,11,5)),"-","")).
ELSE nv_drivage2 = 0 .
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 c-Win 
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
    nv_txt1  = ""
    /*nv_txt2  = "" */
    nv_txt2  = "Campaign : " + wdetail.campens + " Policy master : " + wdetail.polmaster
    nv_txt3  = wdetail.remark
    nv_txt4  = ""
    nv_txt5  = "".
    /*---A58-0489------
    nv_txt3  = wdetail.sendnam 
    nv_txt4  = wdetail.chkcar  
    nv_txt5  = wdetail.telno 
    ---- end A58-0489----*/  
IF LENGTH(nv_txt3) > 80 THEN ASSIGN  nv_txt4 = SUBSTR(nv_txt3,80,R-INDEX(nv_txt3," "))
                                     nv_txt3 = SUBSTR(nv_txt3,1,80).
IF LENGTH(nv_txt4) > 80 THEN ASSIGN  nv_txt5 = SUBSTR(nv_txt4,80,R-INDEX(nv_txt4," "))
                                     nv_txt4 = SUBSTR(nv_txt4,1,80).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 c-Win 
PROCEDURE proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: MEMO (Alt + F8)      
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
FIND LAST wdetmemo WHERE wdetmemo.policymemo = trim(wdetail.policy) NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL wdetmemo THEN DO: 
    /*DO WHILE nv_line1 <= 9:*/
    /*DO WHILE nv_line1 <= 12: A66-0252 */
    DO WHILE nv_line1 <= 17: /*A66-0252 */
        CREATE wuppertxt3.
        wuppertxt3.line = nv_line1.
        IF nv_line1 < 4  THEN wuppertxt3.txt =  "".  
        IF nv_line1 = 4  THEN wuppertxt3.txt =  wdetmemo.f18line1.   
        IF nv_line1 = 5  THEN wuppertxt3.txt =  wdetmemo.f18line2.   
        IF nv_line1 = 6  THEN wuppertxt3.txt =  wdetmemo.f18line3.   
        IF nv_line1 = 7  THEN wuppertxt3.txt =  wdetmemo.f18line4.   
        IF nv_line1 = 8  THEN wuppertxt3.txt =  wdetmemo.f18line5.
        IF nv_line1 = 9  THEN wuppertxt3.txt =  wdetmemo.f18line6.
        IF nv_line1 = 10  THEN wuppertxt3.txt =  wdetmemo.f18line7.
        IF nv_line1 = 11  THEN wuppertxt3.txt =  wdetmemo.f18line8.
        /*A66-0252 */
        IF nv_line1 = 12  THEN wuppertxt3.txt =  wdetmemo.f18line9.
        IF nv_line1 = 13  THEN wuppertxt3.txt =  wdetmemo.ispno.
        IF nv_line1 = 14  THEN wuppertxt3.txt =  wdetmemo.detail.
        IF nv_line1 = 15  THEN wuppertxt3.txt =  wdetmemo.damage.
        IF nv_line1 = 16  THEN wuppertxt3.txt =  wdetmemo.ispacc.
        /* end : A66-0252 */

        nv_line1 = nv_line1 + 1.       
    END.
    IF nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? THEN DO:
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
            FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr  NO-ERROR NO-WAIT.
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
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd132 c-Win 
PROCEDURE proc_uwd132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---------Adjust premium ---------*/
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

    FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE 
        sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
        sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
        sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
        sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
        sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
        sic_bran.uwd132.bencod  = "PD"                    AND
        sic_bran.uwd132.bchyr   = nv_batchyr              AND
        sic_bran.uwd132.bchno   = nv_batchno              AND
        sic_bran.uwd132.bchcnt  = nv_batcnt               NO-ERROR.
    IF  AVAIL   sic_bran.uwd132  THEN  DO:
        ASSIGN  sic_bran.uwd132.gap_c   = sic_bran.uwd132.gap_c - nv_adjgap
                sic_bran.uwd132.prem_c  = sic_bran.uwd132.prem_c - nv_adjpd.
    END.

    FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE 
        sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
        sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
        sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
        sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
        sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
        sic_bran.uwd132.bencod  = "43"                    AND
        sic_bran.uwd132.bchyr   = nv_batchyr                AND
        sic_bran.uwd132.bchno   = nv_batchno                AND
        sic_bran.uwd132.bchcnt  = nv_batcnt               NO-ERROR.
    IF  AVAIL   sic_bran.uwd132  THEN  DO:
        ASSIGN  sic_bran.uwd132.gap_c   = sic_bran.uwd132.gap_c  + nv_adjgap
                sic_bran.uwd132.prem_c  = sic_bran.uwd132.prem_c + nv_adjpd.
    END.
/*-------------------end adjust premium-----------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var c-Win 
PROCEDURE proc_var :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    /* nv_camptyp =  "NORM"*/
    s_riskgp   =   0                     s_riskno       =  1
    s_itemno   =   1                     nv_undyr       =  String(Year(today),"9999")   
    n_rencnt   =   0                     n_endcnt       =  0.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wgw72013 c-Win 
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
                   sicsyac.xmm127.nodays GE n_dcover  NO-LOCK NO-ERROR.
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
             MESSAGE "AA".
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_chkfile c-Win 
PROCEDURE pro_chkfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_pol       AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_recnt     AS INT INIT 0.
DEF VAR n_encnt     AS INT INIT 0.
DEF VAR n_rev       AS INT INIT 0. 
DEF VAR n_revday    AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_cc        AS CHAR FORMAT "x(3)" INIT "".    /*a61-0152*/
DEF VAR n_model     AS CHAR FORMAT "x(2)" INIT "".    /*a61-0152*/
DEF VAR n_model1    AS CHAR FORMAT "x(5)" INIT "".    /*a61-0152*/
DEF VAR np_garage    AS CHAR FORMAT "x(25)" INIT "" .  /*A66-0084*/

ASSIGN fi_process   = "Check data & Match STK TPIS-renew....".    /*A56-0262*/
DISP fi_process WITH FRAM fr_main.
FOR EACH wdetail2.
    IF TRIM(wdetail2.tpis_no) = ""  THEN DELETE wdetail2.
    ELSE DO:
        ASSIGN n_cc = ""     n_model = ""   
               np_garage = ""   /*A66-0084*/
               np_garage = IF trim(wdetail2.garage) = "ซ่อมห้าง" THEN "ซ่อมอู่ห้าง" ELSE "ซ่อมอู่ประกัน"  /*A66-0084*/ 
               wdetail2.np_f18line4 = wdetail2.garage . /*A62-0422*/

        RUN proc_cutpol72.
        IF TRIM(wdetail2.License) <> "" THEN DO:
                IF R-INDEX(wdetail2.License," ") <> 0 THEN
                    ASSIGN wdetail2.License = trim(SUBSTR(trim(wdetail2.License),1,INDEX(trim(wdetail2.License)," "))) + " " +
                                             trim(SUBSTR(trim(wdetail2.License),INDEX(trim(wdetail2.License)," "))).
        END.
        IF TRIM(wdetail2.regis_CL) <> "" THEN DO:
           FIND FIRST brstat.insure USE-INDEX Insure03   WHERE 
                brstat.insure.compno = "999"    AND 
                brstat.insure.fname  = trim(wdetail2.regis_CL)  NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN DO:
                ASSIGN wdetail2.regis_CL = trim(Insure.LName).
            END.
        END.
        ELSE ASSIGN  wdetail2.regis_CL =  "".
       
        ASSIGN fi_process   = "Check data Old Policy............".    /*A56-0262*/
        DISP fi_process WITH FRAM fr_main.
        IF trim(wdetail2.chasno) <> "" AND INDEX(wdetail2.typ_work,"V") <> 0 AND 
           index(wdetail2.deler,"Refinance") = 0  THEN DO:  /*A61-0152*/
            FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail2.chasno)) AND 
                                                             sicuw.uwm301.tariff = "X" NO-LOCK  NO-ERROR NO-WAIT.
                 IF AVAIL sicuw.uwm301 THEN DO:
                     ASSIGN  n_pol   = ""
                             n_recnt = 0
                             n_encnt = 0
                             n_pol   = sicuw.uwm301.policy 
                             n_recnt = sicuw.uwm301.rencnt 
                             n_encnt = sicuw.uwm301.endcnt .
                     FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                         sicuw.uwm100.policy = n_pol     AND
                         sicuw.uwm100.rencnt = n_recnt   AND
                         sicuw.uwm100.endcnt = n_encnt  NO-LOCK NO-ERROR .
                     IF AVAIL sicuw.uwm100 THEN
                         IF sicuw.uwm100.renpol = "" THEN
                            ASSIGN wdetail2.prvpol = sicuw.uwm100.policy.
                         ELSE 
                             ASSIGN wdetail2.prvpol = sicuw.uwm100.policy + " ต่ออายุแล้ว ".
                     ELSE
                         ASSIGN wdetail2.prvpol = "".
                 END.
                 ELSE DO: 
                     ASSIGN  wdetail2.prvpol = "".
                 END.
        END.
        ELSE DO:
            ASSIGN  wdetail2.prvpol = "".
        END.

        IF TRIM(wdetail2.prvpol) <> ""  THEN  DO:
            IF substr(TRIM(wdetail2.prvpol),1,1) = "D" THEN ASSIGN wdetail2.branch = substr(TRIM(wdetail2.prvpol),2,1).
            ELSE ASSIGN wdetail2.branch = substr(TRIM(wdetail2.prvpol),1,2).
        END.
        ELSE DO:
            /* add by : A65-0177 */
            FIND FIRST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.compno = "TPIS"             AND    
              stat.insure.fname  = wdetail2.deler     AND
              stat.insure.lname  = wdetail2.showroom  NO-ERROR NO-WAIT.
            IF AVAIL stat.insure THEN DO: 
                ASSIGN wdetail2.branch  = stat.insure.branch  . 
            END.
            ELSE DO: 
                ASSIGN wdetail2.branch  = "M" . 
            END.
            /* end : A65-0177 */
        END.
        /* ---create by A61-0152---*/
        IF trim(wdetail2.cust_type) = "J" AND TRIM(wdetail2.icno) <> "" THEN DO:
            IF LENGTH(TRIM(wdetail2.icno)) < 13 THEN ASSIGN wdetail2.icno = "0" + TRIM(wdetail2.icno) .
        END.

        IF trim(wdetail2.cover) = "2+" THEN ASSIGN wdetail2.cover = "2.2" .
        ELSE IF trim(wdetail2.cover) = "3+" THEN ASSIGN wdetail2.cover = "3.2" .
        ELSE ASSIGN wdetail2.cover = TRIM(wdetail2.cover).

        IF INT(wdetail2.cc) = 0 AND wdetail2.chasno <> "" THEN DO:
            n_cc = trim(SUBSTR(wdetail2.chasno,7,2)).
            IF n_cc = "85"  THEN wdetail2.cc = "3000".
            ELSE IF n_cc = "86" THEN wdetail2.cc = "2500".
            ELSE wdetail2.cc = "1900" .
        END.

        IF trim(wdetail2.chasno) <> ""  THEN DO:
            n_model = trim(SUBSTR(wdetail2.chasno,9,1)) . 
            n_model1 = trim(SUBSTR(wdetail2.chasno,7,5)) .  /*A62-0110*/
            IF n_model = "G" THEN wdetail2.model = "MU-X".
            /*ELSE wdetail2.model = "D-MAX" .*/ /*A61-0416*/
            ELSE IF wdetail2.brand = "ISUZU"  THEN  DO:
                IF n_model1 = "85HBT" THEN wdetail2.model = "MU-7". /*A62-0110*/
                ELSE IF TRIM(wdetail2.bus_typ) = "CV" THEN wdetail2.model = wdetail2.model. 
                ELSE  wdetail2.model = "D-MAX" . /*A61-0416*/  
            END.
            ELSE wdetail2.model = trim(wdetail2.model) . /*A61-0416*/
        END.
        IF wdetail2.CLASS = "" THEN DO:
            IF DECI(wdetail2.com_netprem) = 600 THEN ASSIGN wdetail2.CLASS = "110" .
            ELSE wdetail2.CLASS = "" .
        END.
        IF trim(wdetail2.prvpol) <> "" THEN DO: /* มีกรมธรรม์เดิม */
            ASSIGN wdetail2.producer = TRIM(fi_producer)
                   re_class   = ""      re_covcod  = ""     re_si      = ""      re_baseprm = 0   
                   re_expdat  = ""      re_year    = ""     re_chassic = ""      re_rencnt  = 0. /*A66-0252*/

            IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
            IF  CONNECTED("sic_exp") THEN DO:
                ASSIGN re_producerexp = ""   /*A63-00472*/ 
                       re_dealerexp   = "".  /*A63-00472*/
                RUN wgw\wgwchktil (INPUT-OUTPUT  wdetail2.prvpol,               
                                   INPUT-OUTPUT  wdetail2.branch, 
                                   INPUT-OUTPUT  re_producerexp,
                                   INPUT-OUTPUT  re_dealerexp,
                                   INPUT-OUTPUT  re_class ,
                                   INPUT-OUTPUT  re_covcod,
                                   INPUT-OUTPUT  re_si     ,                          
                                   INPUT-OUTPUT  re_baseprm,
                                   input-output  re_expdat , /*A62-0422*/
                                   INPUT-OUTPUT  re_year  ,    /*A66-0252*/
                                   INPUT-OUTPUT  re_chassic,  /*A66-0252*/
                                   INPUT-OUTPUT  re_rencnt).  /*A66-0252*/

                /*A63-00472*/
                IF wdetail2.prvpol <> "" AND re_producerexp = "" THEN ASSIGN  wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |ไม่พบรหัส Producer ที่ระบบ Expiry".
                IF wdetail2.prvpol <> "" AND re_dealerexp   = "" THEN ASSIGN  wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |ไม่พบรหัส Dealer ที่ระบบ Expiry".
                IF wdetail2.prvpol <> "" AND re_producerexp <> "" AND re_dealerexp <> ""  THEN DO:
                    IF trim(re_producerexp) = "B3MF101980"  THEN DO:
                        FIND LAST stat.insure USE-INDEX insure01 WHERE 
                            stat.insure.compno = "TPIS"             AND   
                            stat.insure.insno =  re_dealerexp  NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL stat.insure THEN  ASSIGN wdetail2.branch =   trim(stat.Insure.Branch).
                    END.
                END.
                /*A63-00472*/
                IF re_class = "" AND re_covcod = "" AND re_si = "" AND re_baseprm = 0 THEN DO: 
                    ASSIGN  wdetail2.np_f18line6 = "ไม่มีขอ้มูลที่ระบบ Expiry".
                END.
                ELSE DO:
                    IF INDEX(re_class,wdetail2.CLASS) <> 0 THEN 
                        ASSIGN wdetail2.np_f18line6 = "Class ตรง" 
                               wdetail2.CLASS        = re_class .
                    ELSE ASSIGN wdetail2.np_f18line6 = "Class ไม่ตรง".
                    
                    IF trim(wdetail2.cover) = TRIM(re_covcod)  THEN ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |Cover ตรง".
                    ELSE ASSIGN wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |Cover ไม่ตรง".
                    
                    IF DECI(wdetail2.si) = deci(re_si)  THEN ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |SI ตรง".
                    ELSE ASSIGN wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |SI ไม่ตรง".
                    
                    IF DECI(wdetail2.pol_netprem) = re_baseprm  THEN ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |เบี้ยตรง".
                    ELSE ASSIGN wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |เบี้ยไม่ตรง " + wdetail2.pol_netprem .
                    /* create by : A62-0422 */ 
                    IF YEAR(date(re_expdat)) < YEAR(TODAY) THEN DO:
                        ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน  Exp:" + re_expdat .
                    END.
                    ELSE DO:
                        IF MONTH(date(re_expdat)) <= MONTH(date(wdetail2.pol_comm_date)) THEN DO:
                            IF MONTH(date(re_expdat)) = MONTH(date(wdetail2.pol_comm_date)) THEN DO:
                                IF DAY(date(re_expdat)) < (DAY(date(wdetail2.pol_comm_date)) - 1 ) THEN DO:
                                   ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน  Exp:" + re_expdat .
                                END.
                            END.
                            ELSE DO:
                                ASSIGN wdetail2.np_f18line6 =  wdetail2.np_f18line6 + " |กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน  Exp:" + re_expdat .
                            END.
                        END.
                    END.
                    /* end A62-0422*/
                    IF re_rencnt < 2 THEN ASSIGN wdetail2.np_f18line5 = "First Year" .
                    ELSE ASSIGN wdetail2.np_f18line5 = "Other Year" .
                END.
                ASSIGN  re_class   = ""     re_covcod  = ""     re_si      = ""      re_baseprm = 0  
                        re_expdat  = ""     re_year    = ""     re_chassic = ""      re_rencnt  = 0. /*A66-0252*/.
            END.
        END.
        ELSE DO: /* ไม่มีกรมธรรม์เดิม */
            IF index(wdetail2.deler,"Refinance") <> 0 THEN ASSIGN wdetail2.producer = TRIM(fi_producerre).
            ELSE IF trim(wdetail2.typ_work) = "C" THEN ASSIGN wdetail2.producer = TRIM(fi_producer72).
            ELSE ASSIGN wdetail2.producer = TRIM(fi_producer).

            IF DECI(wdetail2.pol_netprem) <> 0 AND TRIM(wdetail2.cover) <> "2"  THEN DO:
                /* A66-0084 */
                IF TRIM(wdetail2.cover) = "1" THEN DO:
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = trim(fi_model)           AND 
                           index(brstat.insure.Text3,wdetail2.class) <> 0       AND  
                           brstat.insure.vatcode     = TRIM(wdetail2.cover)     AND
                           deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) AND 
                           trim(brstat.insure.Text2) = trim(np_garage)   NO-LOCK NO-ERROR.
                END.
                ELSE DO: /* end A66-0084*/
                  FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                         brstat.insure.compno      = trim(fi_model)            AND 
                         index(brstat.insure.Text3,wdetail2.class) <> 0        AND  
                         brstat.insure.vatcode     = TRIM(wdetail2.cover)     AND
                         deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) NO-LOCK NO-ERROR.
                END.
                 IF AVAIL brstat.insure THEN DO:
                     ASSIGN wdetail2.CLASS       = TRIM(brstat.insure.Text3) 
                            wdetail2.campaign    = trim(brstat.insure.Text1)
                            wdetail2.np_f18line4 = TRIM(brstat.insure.Text2)
                            wdetail2.np_f18line6 = "เบี้ยตรงกับแคมเปญ"
                            wdetail2.product     = IF TRIM(brstat.insure.icaddr2) <> "" THEN TRIM(brstat.insure.icaddr2) + "_" + trim(brstat.insure.Text1) 
                                                   ELSE trim(brstat.insure.Text1). /*A65-0177*/
                 END.
                 ELSE ASSIGN wdetail2.np_f18line6 = "เบี้ยไม่ตรงกับแคมเปญ " + wdetail2.pol_netprem .
            END.
            IF TRIM(wdetail2.cover) = "2"  THEN DO:
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = trim(fi_model)            AND 
                           index(brstat.insure.Text3,wdetail2.class) <> 0        AND  
                           brstat.insure.vatcode     = TRIM(wdetail2.cover)      AND
                           deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) NO-LOCK NO-ERROR.
                 IF AVAIL brstat.insure THEN DO:
                     ASSIGN wdetail2.CLASS       = TRIM(brstat.insure.Text3) 
                            wdetail2.np_f18line4 = trim(brstat.insure.Text1) 
                            wdetail2.np_f18line6 = "เบี้ยตรงกับแคมเปญ".
                 END.
                 ELSE ASSIGN wdetail2.np_f18line6 = "เบี้ยไม่ตรงกับแคมเปญ " + wdetail2.pol_netprem .
            END.
            IF index(wdetail2.deler,"Refinance") <> 0 THEN ASSIGN wdetail2.np_f18line5 = "Refinence". 
            ELSE IF index(wdetail2.deler,"Used Car") <> 0 THEN ASSIGN wdetail2.np_f18line5 = "Used Car".
            ELSE IF index(wdetail2.deler,"UsedCar")  <> 0 THEN ASSIGN wdetail2.np_f18line5 = "Used Car".
            ELSE ASSIGN wdetail2.np_f18line5 = "Switch".
        END.

        IF wdetail2.np_f18line6 = "ไม่มีขอ้มูลที่ระบบ Expiry" THEN DO:   /* ไม่มีที่ใบเตือน */
            IF index(wdetail2.deler,"Refinance") <> 0 THEN ASSIGN wdetail2.producer = TRIM(fi_producerre).
            ELSE IF trim(wdetail2.typ_work) = "C" THEN ASSIGN wdetail2.producer = TRIM(fi_producer72).
            ELSE ASSIGN wdetail2.producer = TRIM(fi_producer).
            IF DECI(wdetail2.pol_netprem) <> 0 AND TRIM(wdetail2.cover) <> "2"  THEN DO:
                 /* A66-0084 */
                IF TRIM(wdetail2.cover) = "1" THEN DO:
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = trim(fi_model)           AND 
                           index(brstat.insure.Text3,wdetail2.class) <> 0       AND  
                           brstat.insure.vatcode     = TRIM(wdetail2.cover)     AND
                           deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) AND 
                           trim(brstat.insure.Text2) = trim(np_garage)   NO-LOCK NO-ERROR.
                END.
                ELSE DO: /* end A66-0084*/
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = trim(fi_model)            AND 
                           index(brstat.insure.Text3,wdetail2.class) <> 0        AND  
                           brstat.insure.vatcode     = TRIM(wdetail2.cover)     AND
                           deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) NO-LOCK NO-ERROR.
                END.
                 IF AVAIL brstat.insure THEN DO:
                     ASSIGN wdetail2.CLASS       = TRIM(brstat.insure.Text3) 
                            wdetail2.campaign    = trim(brstat.insure.Text1)
                            wdetail2.np_f18line4 = TRIM(brstat.insure.Text2)
                            wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |เบี้ยตรงกับแคมเปญ " 
                            wdetail2.product     = IF TRIM(brstat.insure.icaddr2) <> "" THEN TRIM(brstat.insure.icaddr2) + "_" + trim(brstat.insure.Text1) 
                                                   ELSE trim(brstat.insure.Text1). /*A65-0177*/
                 END.
                 ELSE ASSIGN wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |เบี้ยไม่ตรงกับแคมเปญ " + wdetail2.pol_netprem .
            END.
            IF TRIM(wdetail2.cover) = "2"  THEN DO:
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = trim(fi_model)            AND 
                           index(brstat.insure.Text3,wdetail2.class) <> 0        AND  
                           brstat.insure.vatcode     = TRIM(wdetail2.cover)     AND
                           deci(brstat.insure.Text4) = DECI(wdetail2.pol_netprem) NO-LOCK NO-ERROR.
                 IF AVAIL brstat.insure THEN DO:
                     ASSIGN wdetail2.CLASS       = TRIM(brstat.insure.Text3) 
                            wdetail2.np_f18line4 = trim(brstat.insure.Text1) 
                            wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |เบี้ยตรงกับแคมเปญ ".
                 END.
                 ELSE ASSIGN wdetail2.np_f18line6 = wdetail2.np_f18line6 + " |เบี้ยไม่ตรงกับแคมเปญ " + wdetail2.pol_netprem  .
            END.
            IF index(wdetail2.deler,"Refinance") <> 0 THEN ASSIGN wdetail2.np_f18line5 = "Refinence". 
            ELSE IF index(wdetail2.deler,"Used Car") <> 0 THEN ASSIGN wdetail2.np_f18line5 = "Used Car".
            ELSE IF index(wdetail2.deler,"UsedCar")  <> 0 THEN ASSIGN wdetail2.np_f18line5 = "Used Car".
            ELSE ASSIGN wdetail2.np_f18line5 = "Switch".
        END.
        /* ---end : A61-0152---*/         
        IF TRIM(wdetail2.financename) = "Cash" THEN ASSIGN wdetail2.financename = " ". 
        IF wdetail2.financename <> " "  THEN DO:
            FIND FIRST stat.insure USE-INDEX insure01 WHERE stat.insure.compno = "TPIS-LEAS"        AND 
                                     stat.insure.fname = wdetail2.financename   OR
                                     stat.insure.lname = wdetail2.financename   NO-LOCK NO-ERROR . 
             IF AVAIL stat.insure THEN
                 ASSIGN wdetail2.financename = stat.insure.addr1 + stat.insure.addr2.
             ELSE 
                 ASSIGN wdetail2.financename = "error : " + wdetail2.financename.
        END.
       /*-- create by A61-0152 --*/
        ASSIGN wdetail2.np_f18line1 = nv_memo1
               wdetail2.np_f18line2 = nv_memo2
               wdetail2.np_f18line3 = nv_meno3.
        /*-- end A61-0152---*/
    END.
END.

IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.

ASSIGN fi_process   = "Check data complete ......".    /*A56-0262*/
DISP fi_process WITH FRAM fr_main.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_chk_pol c-Win 
PROCEDURE pro_chk_pol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
assign n_status         = NO
       n_statuscomp     = ""
       n_statuspol      = "".

IF ra_typefile = 4  THEN DO:
    IF INDEX(wdetail2.typ_work,"V" ) <> 0 THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                  sicuw.uwm100.cedpol =  trim(wdetail2.tpis_no) AND 
                  sicuw.uwm100.poltyp = "V70"  NO-LOCK NO-ERROR. 
            IF AVAIL sicuw.uwm100 THEN DO:
                ASSIGN 
                    wdetail2.policy        = sicuw.uwm100.policy   
                    wdetail2.agent         = sicuw.uwm100.acno1
                    wdetail2.branch        = sicuw.uwm100.branch
                    wdetail2.pol_stamp_ho  = string(sicuw.uwm100.rstp_t)   /*A61-0152*/
                    wdetail2.pol_vat_ho    = string(sicuw.uwm100.rtax_t)   /*A61-0152*/
                    wdetail2.comment       = IF  deci(wdetail2.pol_netprem) <> deci(sicuw.uwm100.prem_t) THEN wdetail2.comment + "เบี้ยในไฟล์ " + string(wdetail2.pol_netprem) + " ไม่เท่ากับพรีเมียม " + STRING(uwm100.prem_t)  
                                             ELSE wdetail2.comment . /* A65-0177 */
                /* add by A63-0113 */
                 FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                      sicuw.uwm120.policy  = sicuw.uwm100.policy   AND
                      sicuw.uwm120.rencnt  = sicuw.uwm100.rencnt   AND
                      sicuw.uwm120.endcnt  = sicuw.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
                  IF AVAIL sicuw.uwm120 THEN
                      ASSIGN wdetail2.class  = sicuw.uwm120.class.
                  /* end a63-0113 */
            END.
            ELSE 
                ASSIGN  wdetail2.policy  = ""    
                        wdetail2.agent   = ""
                        wdetail2.branch  = ""
                        wdetail2.pol_stamp_ho  = ""  /*A61-0152*/
                        wdetail2.pol_vat_ho    = "".  /*A61-0152*/
                        .
       RUN proc_matchbran.
    END.
   /* ELSE DO: */ /*A63-0101*/
       /* FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy =  trim(wdetail2.com_no) NO-LOCK NO-ERROR. */ /*A63-0101*/
    /* add by : A63-0101 */
    IF INDEX(wdetail2.typ_work,"C" ) <> 0 THEN DO:
       FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol =  trim(wdetail2.tpis_no) AND 
                                                       sicuw.uwm100.poltyp = "V72"  NO-LOCK NO-ERROR. 
   /* end : A63-0101 */
            IF AVAIL sicuw.uwm100 THEN DO:
                IF TRIM(wdetail2.typ_work) = "C"  THEN DO: /*A63-0101 */
                    ASSIGN 
                       wdetail2.com_no  = sicuw.uwm100.policy  /*A63-0101 */
                       wdetail2.agent   = sicuw.uwm100.acno1
                       wdetail2.branch  = sicuw.uwm100.branch.
                    /* add by A63-0113 */
                    FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001        WHERE
                         sicuw.uwm120.policy  = sicuw.uwm100.policy   AND
                         sicuw.uwm120.rencnt  = sicuw.uwm100.rencnt   AND
                         sicuw.uwm120.endcnt  = sicuw.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAIL sicuw.uwm120 THEN
                         ASSIGN wdetail2.class  = sicuw.uwm120.class.
                     /* end a63-0113 */
                END.
                ELSE ASSIGN wdetail2.com_no  = sicuw.uwm100.policy .  /*A63-0101 */
            END.
            ELSE  ASSIGN  wdetail2.com_no  = "". /*A63-0101 */
       RUN proc_matchbran.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createfileexcel c-Win 
PROCEDURE pro_createfileexcel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:      
------------------------------------------------------------------------------*/
If substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
    ASSIGN nv_cnt  =  0
           nv_row  =  0.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
 nv_row  =  nv_row + 1.
 PUT STREAM ns2 "ID;PND" SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Ins. Year type"         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Business type"         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "TAS received by"         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "Ins company "         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Insurance ref no."         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "TPIS Contract No."         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "Title name "         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "customer name"         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "customer lastname "         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "Customer type"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "Director Name"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "ID number"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "House no."         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Building "         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "Village name/no."         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "Soi"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "Road "         '"' SKIP.                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Sub-district"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "District"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Province"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Postcode"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Brand"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "Car model "         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Insurance Code"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Model Year"         '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "Usage Type"         '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Colour "         '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Car Weight"         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Year      "         '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Engine No."         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Chassis No."         '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Accessories (for CV)"         '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Accessories amount"         '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "License No."         '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "Registered Car License"         '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "Campaign"         '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "Type of work "         '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "Insurance amount             "         '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "Insurance Date (Voluntary) "         '"' SKIP.                                                
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "Expiry Date (Voluntary)     "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "Last Policy No.(Voluntary)  "         '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "Branch             "         '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "Insurance Type               "         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "Net premium (Voluntary)      "         '"' SKIP.                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "Gross premium (Voluntary)    "         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "Stamp "         '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "VAT   "         '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "WHT   "         '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Compulsory No.               "         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "Sticker No.               "         '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "Insurance Date (Compulsory)"         '"' SKIP.                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "Expiry Date ( Compulsory)    "         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "Net premium (Compulsory)     "         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "Gross premium (Compulsory)   "         '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "Stamp   "         '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "VAT     "         '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "WHT     "         '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "Dealer  "         '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "Showroom   "         '"' SKIP.                                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "Payment Type "         '"' SKIP.                                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "Beneficiery  "         '"' SKIP.                                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "Mailing House no."         '"' SKIP.                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "Mailing  Building"         '"' SKIP.                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "Mailing  Village name/no. "         '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "Mailing  Soi  "         '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "Mailing  Road "         '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "Mailing  Sub-district"         '"' SKIP.                                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "Mailing  District "         '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "Mailing Province  "         '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "Mailing Postcode  "         '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "Policy no. to customer date"         '"' SKIP.                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "New policy no      "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "Insurer Stamp Date "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "Remark             "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' "Occupation code    "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "Register NO.       "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "f18line1           "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "f18line2           "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' "f18line3           "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' "f18line4           "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' "f18line5           "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' "Producer           "         '"' SKIP.
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' "Data Check         "         '"' SKIP. /*A61-0152*/

 FOR EACH wdetail2  NO-LOCK.
     ASSIGN 
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' Wdetail2.ins_ytyp       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' wdetail2.bus_typ        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' wdetail2.TASreceived    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdetail2.InsCompany     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' wdetail2.Insurancerefno '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' wdetail2.tpis_no        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' wdetail2.ntitle         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' wdetail2.insnam         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' wdetail2.NAME2          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' wdetail2.cust_type      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' wdetail2.nDirec         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' wdetail2.ICNO           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' wdetail2.address        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' wdetail2.build          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' wdetail2.mu             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' wdetail2.soi            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' wdetail2.road           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' wdetail2.tambon         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' wdetail2.amper          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' wdetail2.country        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' wdetail2.post           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' wdetail2.brand          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' wdetail2.model          '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' wdetail2.class          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' wdetail2.md_year        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' wdetail2.usage          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' wdetail2.coulor         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' wdetail2.cc             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' wdetail2.regis_year     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' wdetail2.engno          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' wdetail2.chasno         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' Wdetail2.Acc_CV         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' IF Wdetail2.Acc_CV <> "" THEN STRING(DECI(Wdetail2.Acc_amount)) ELSE "" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' wdetail2.License         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' wdetail2.regis_CL        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' wdetail2.campaign        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' wdetail2.typ_work        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' DECI(wdetail2.si) FORMAT ">>>>>>>9.99" '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' wdetail2.prvpol            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' wdetail2.Branch            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' wdetail2.cover             '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' DECI(wdetail2.pol_netprem) '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' DECI(wdetail2.pol_gprem)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' DECI(wdetail2.pol_stamp)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' DECI(wdetail2.pol_vat)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' DECI(wdetail2.pol_wht)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' wdetail2.com_no            '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' wdetail2.stkno FORMAT "x(35)"   '"' SKIP.                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' DATE(wdetail2.com_comm_date) FORMAT "99/99/9999"   '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999"   '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' DECI(wdetail2.com_netprem) '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' DECI(wdetail2.com_gprem)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' DECI(wdetail2.com_stamp)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' DECI(wdetail2.com_vat)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' DECI(wdetail2.com_wht)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' wdetail2.deler             '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' wdetail2.showroom          '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' wdetail2.typepay           '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' wdetail2.financename       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' wdetail2.mail_hno          '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' wdetail2.mail_build        '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' wdetail2.mail_mu           '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' wdetail2.mail_soi          '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' wdetail2.mail_road         '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' wdetail2.mail_tambon       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' wdetail2.mail_amper        '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' wdetail2.mail_country      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' wdetail2.mail_post         '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' wdetail2.send_date         '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' wdetail2.policy            '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' wdetail2.send_data         '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' wdetail2.REMARK1           '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' wdetail2.occup             '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' wdetail2.regis_no          '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' wdetail2.np_f18line1       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' wdetail2.np_f18line2       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' wdetail2.np_f18line3       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' wdetail2.np_f18line4       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' wdetail2.np_f18line5       '"' SKIP.   
    /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"'   ""                         '"' SKIP.   A61-0152 */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' wdetail2.producer          '"' SKIP.  /* A61-0152 */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"'  wdetail2.np_f18line6      '"' SKIP . /* A61-0152 */
 End.  /*end for*/                                                                                            
 nv_row  =  nv_row  + 1.  
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
FOR EACH wdetail2.
    DELETE wdetail2.
END.
message "Export File  Complete"  view-as alert-box.
RELEASE stat.insure.
RELEASE brstat.tlt.
RELEASE sicuw.uwm301.
RELEASE sicuw.uwm100.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfileexcelDT c-Win 
PROCEDURE Pro_createfileexcelDT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /***Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
 /*****************Detail file Excel***********************************/
 FOR EACH wdetail2  NO-LOCK.
     ASSIGN 
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' Wdetail2.ins_ytyp       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' wdetail2.bus_typ        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' wdetail2.TASreceived    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdetail2.InsCompany     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' wdetail2.Insurancerefno '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' wdetail2.tpis_no        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' wdetail2.ntitle         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' wdetail2.insnam         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' wdetail2.NAME2          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' wdetail2.cust_type      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' wdetail2.nDirec         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' wdetail2.ICNO           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' wdetail2.address        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' wdetail2.build          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' wdetail2.mu             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' wdetail2.soi            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' wdetail2.road           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' wdetail2.tambon         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' wdetail2.amper          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' wdetail2.country        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' wdetail2.post           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' wdetail2.brand          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' wdetail2.model          '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' wdetail2.class          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' wdetail2.md_year        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' wdetail2.usage          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' wdetail2.coulor         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' wdetail2.cc             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' wdetail2.regis_year     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' wdetail2.engno          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' wdetail2.chasno         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' Wdetail2.Acc_CV         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' IF Wdetail2.Acc_CV <> "" THEN STRING(DECI(Wdetail2.Acc_amount)) ELSE "" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' wdetail2.License         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' wdetail2.regis_CL        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' wdetail2.campaign        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' wdetail2.typ_work        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' DECI(wdetail2.si) FORMAT ">>>>>>>9.99" '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' wdetail2.prvpol            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' wdetail2.Branch            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' wdetail2.cover             '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' DECI(wdetail2.pol_netprem) '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' DECI(wdetail2.pol_gprem)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' DECI(wdetail2.pol_stamp)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' DECI(wdetail2.pol_vat)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' DECI(wdetail2.pol_wht)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' wdetail2.com_no            '"' SKIP.  
     /*เพิ่มเลขใบแจ้งหนี้ docno*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' wdetail2.docno            '"' SKIP. /**Add By Nontamas H. [A62-0329] Date 08/07/2019****/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' wdetail2.stkno FORMAT "x(35)"   '"' SKIP.                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' DATE(wdetail2.com_comm_date) FORMAT "99/99/9999"   '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999"   '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' DECI(wdetail2.com_netprem) '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' DECI(wdetail2.com_gprem)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' DECI(wdetail2.com_stamp)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' DECI(wdetail2.com_vat)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' DECI(wdetail2.com_wht)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' wdetail2.deler             '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' wdetail2.showroom          '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' wdetail2.typepay           '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' wdetail2.financename       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' wdetail2.mail_hno          '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' wdetail2.mail_build        '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' wdetail2.mail_mu           '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' wdetail2.mail_soi          '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' wdetail2.mail_road         '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' wdetail2.mail_tambon       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' wdetail2.mail_amper        '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' wdetail2.mail_country      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' wdetail2.mail_post         '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' wdetail2.send_date         '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' wdetail2.policy            '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' wdetail2.send_data         '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' wdetail2.REMARK1           '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' wdetail2.occup             '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' wdetail2.regis_no          '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' wdetail2.np_f18line1       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' wdetail2.np_f18line2       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' wdetail2.np_f18line3       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' wdetail2.np_f18line4       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' wdetail2.np_f18line5       '"' SKIP.   
    /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"'   ""                    '"' SKIP.    A61-0152 */ 
    /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' wdetail2.producer       '"' SKIP.    /* A61-0152 */   /*A63-0259*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' wdetail2.np_f18line6      '"' SKIP .   /* A61-0152 */    /*A63-0259*/*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' " "       '"' SKIP.                    /*A63-0259  */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' " "       '"' SKIP.                    /*A63-0259  */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' " "       '"' SKIP.                    /*A63-0259  */
    /* comment by : A66-0252 ...
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' wdetail2.producer         '"' SKIP.    /*A63-0259  */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' wdetail2.product          '"' SKIP .   /*A65-0177  */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' wdetail2.np_f18line6      '"' SKIP . */  /*A63-0259  */
    /* add by : A66-0252 */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' " "         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' " "         '"' SKIP.   /*isp       */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' " "         '"' SKIP.   /*ispno     */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' " "         '"' SKIP.   /*ispresult */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"' " "         '"' SKIP.   /*ispdetail */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"' " "         '"' SKIP.   /*ispacc    */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"' wdetail2.producer          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"' wdetail2.product           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"' wdetail2.np_f18line6       '"' SKIP. 
    /* end : A66-0252 */
 End.  /*end for*/                                                                                            
 nv_row  =  nv_row  + 1.  
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
FOR EACH wdetail2.
    DELETE wdetail2.
END.
message "Export File  Complete"  view-as alert-box.
RELEASE stat.insure.
RELEASE brstat.tlt.
RELEASE sicuw.uwm301.
RELEASE sicuw.uwm100.
 /***End Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfileexcelHD c-Win 
PROCEDURE Pro_createfileexcelHD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/***Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
 /*****************Header file Excel***********************************/
If substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
    ASSIGN nv_cnt  =  0
           nv_row  =  0.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
 nv_row  =  nv_row + 1.
 PUT STREAM ns2 "ID;PND" SKIP.                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Ins. Year type"    '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Business type"     '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "TAS received by"   '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "Ins company "      '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Insurance ref no." '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "TPIS Contract No." '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "Title name "       '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "customer name"     '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "customer lastname "'"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "Customer type"     '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "Director Name"     '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "ID number"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "House no."         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Building "         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "Village name/no."  '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "Soi"           '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "Road "         '"' SKIP.                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Sub-district"  '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "District"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Province"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Postcode"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Brand"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "Car model "    '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Insurance Code"'"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Model Year"    '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "Usage Type"    '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Colour "       '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Car Weight"    '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Year      "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Engine No."    '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Chassis No."   '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Accessories (for CV)"   '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Accessories amount"     '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "License No."            '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "Registered Car License" '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "Campaign"               '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "Type of work "          '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "Insurance amount  "     '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "Insurance Date (Voluntary)" '"' SKIP.                                                
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "Expiry Date (Voluntary)   " '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "Last Policy No.(Voluntary)" '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "Branch             "        '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "Insurance Type            " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "Net premium (Voluntary)   " '"' SKIP.                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "Gross premium (Voluntary) " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "Stamp "         '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "VAT   "         '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "WHT   "         '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Compulsory No." '"' SKIP. 
 /*เพิ่มเลขใบแจ้งหนี้*/                                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "เลขใบแจ้งหนี้." '"' SKIP.        /**Add By Nontamas H. [A62-0329] Date 08/07/2019****/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "Sticker No.   " '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "Insurance Date (Compulsory)" '"' SKIP.                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "Expiry Date ( Compulsory)  " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "Net premium (Compulsory)   " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "Gross premium (Compulsory) " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "Stamp   " '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "VAT     " '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "WHT     " '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "Dealer  " '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "Showroom   "   '"' SKIP.                                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "Payment Type " '"' SKIP.                                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "Beneficiery  " '"' SKIP.                                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "Mailing House no." '"' SKIP.                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "Mailing  Building" '"' SKIP.                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "Mailing  Village name/no. "  '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "Mailing  Soi  "              '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "Mailing  Road "              '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "Mailing  Sub-district"       '"' SKIP.                                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "Mailing  District "          '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "Mailing Province  "          '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "Mailing Postcode  "          '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "Policy no. to customer date" '"' SKIP.                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "New policy no      "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "Insurer Stamp Date "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' "Remark             "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "Occupation code"         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "Register NO.   "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "f18line1       "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' "f18line2       "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' "f18line3       "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' "f18line4       "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' "f18line5       "         '"' SKIP. /*
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' "Producer       "         '"' SKIP.                 /*A63-0259*/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' "Data Check     "         '"' SKIP. /*A61-0152*/*/  /*A63-0259*/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' "f18line6       "         '"' SKIP.                 /*A63-0259*/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' "f18line7       "         '"' SKIP.                 /*A63-0259*/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' "f18line8       "         '"' SKIP.                 /*A63-0259*/
/* comment by : A66-0252...
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' "Producer       "         '"' SKIP.                 /*A63-0259*/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' "Product        "         '"' SKIP.       /* A65-0177*/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' "Data Check     "         '"' SKIP.  */               /*A63-0259*/
 /* add by : A66-0252 */
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' "f18line9       "         '"' SKIP.   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' "Inspection     "         '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' "ISP No.        "         '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' "ISP Detail     "         '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"' "ISP Damge      "         '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"' "ISP Accessories"         '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"' "Producer       "         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"' "Product        "         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"' "Data Check     "         '"' SKIP.  
 /* end : A66-0252 */
 
 /***End Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createpol c-Win 
PROCEDURE pro_createpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by : A66-0252      
------------------------------------------------------------------------------*/
def var nv_row      as int    init 0.
If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_cnt  =  0  nv_row  =  0.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "จังหวัด "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "สาขา   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "ภูมิภาค   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "สาขากรมธรรม์   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Ins. Year type "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Business type  "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "TAS received by"  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "Ins company    "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "Insurance ref no."  '"' SKIP.                             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "TPIS Contract No."  '"' SKIP.                             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "Title name     " '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "customer name  " '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "customer lastname"  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Customer type  " '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "Director Name  " '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "ID number " '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "House no. " '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Building  " '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "Village name/no. "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Soi       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Road      "  '"' SKIP.                                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Sub-district   "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "District  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Province  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Postcode  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "Brand     "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Car model "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Insurance Code "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Model Year "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Usage Type "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Colour     "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Car Weight "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Year       "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "Engine No. "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "Chassis No."  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "Accessories (for CV) "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "Accessories amount"  '"' SKIP.                                           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "License No.       "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "Registered Car License "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "Campaign        "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "Type of work    "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "Insurance amount"  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "Insurance Date ( Voluntary )   "  '"' SKIP.                                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "Expiry Date ( Voluntary)       "  '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "Last Policy No. (Voluntary)    "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "Branch          "  '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "New policy no   "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "Insurance Type  "  '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Net premium (Voluntary)   "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "Gross premium (Voluntary) "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "Stamp  "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "VAT    "  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "Stamp HO  "  '"' SKIP.    /*A61-0152*/       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "VAT HO   "  '"' SKIP.     /*A61-0152*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "WHT    "  '"' SKIP.                                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "Compulsory No. "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "เลขใบแจ้งหนั้. "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "Sticker No.    "  '"' SKIP.                                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "Insurance Date ( Compulsory )  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "Expiry Date ( Compulsory)  "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "Net premium (Compulsory)   "  '"' SKIP.            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "Gross premium (Compulsory) "  '"' SKIP.            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "Stamp "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "VAT   "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "WHT   "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "Dealer"  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "Showroom "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "Payment Type "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "Beneficiery  "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "Mailing House no. "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "Mailing  Building "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "Mailing  Village name/no.      "  '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "Mailing Soi    "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "Mailing  Road  "  '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' "Mailing  Sub-district "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "Mailing  District "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "Mailing Province  "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "Mailing Postcode  "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' "Policy no. to customer date    "  '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' "Insurer Stamp Date"  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' "Remark            "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' "Occupation code   "  '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' "Register NO. "       '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' "f18line1"           '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' "f18line2"           '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' "f18line3"           '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' "f18line4"           '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' "f18line5"           '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' "f18line6"           '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"' "f18line7"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"' "f18line8"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"' "f18line9"           '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"' "Inspection "        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"' "ISP No. "           '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K" '"' "ISP Detail "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K" '"' "ISP Damge  "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K" '"' "ISP Accessories"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K" '"' "Producer"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K" '"' "Product "           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"' "campaign_ov"       '"' SKIP.

FOR EACH wdetail2.                           
  IF TRIM(wdetail2.tpis_no) = ""  THEN DELETE wdetail2. 
  ELSE RUN pro_chk_pol.
end.
RUN Pro_createpol1. 
nv_row  =  nv_row  + 1.  
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
FOR EACH wdetail2.  DELETE wdetail2. END.
message "Export Match File Policy Complete"  view-as alert-box.
RELEASE sicuw.uwm100.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createpol1 c-Win 
PROCEDURE pro_createpol1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FOR EACH wdetail2 BREAK BY wdetail2.delerco.
      ASSIGN nv_row  =  nv_row  + 1   nv_cnt  =  nv_cnt  + 1.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' Wdetail2.bran_name    '"' SKIP. 
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' Wdetail2.bran_name2   '"' SKIP. 
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' Wdetail2.region       '"' SKIP. 
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdetail2.branch       '"' SKIP. 
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' Wdetail2.ins_ytyp    '"' SKIP.  
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' wdetail2.bus_typ     '"' SKIP.  
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' wdetail2.TASreceived '"' SKIP.  
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' wdetail2.InsCompany  '"' SKIP.  
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' wdetail2.Insurancerefno   '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' wdetail2.tpis_no          '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' wdetail2.ntitle      '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' wdetail2.insnam      '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' wdetail2.NAME2       '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' wdetail2.cust_type   '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' wdetail2.nDirec      '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' wdetail2.ICNO        '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' wdetail2.address     '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' wdetail2.build       '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' wdetail2.mu          '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' wdetail2.soi         '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' wdetail2.road        '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' wdetail2.tambon      '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' wdetail2.amper       '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' wdetail2.country     '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' wdetail2.post        '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' wdetail2.brand       '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' wdetail2.model       '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' wdetail2.class       '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' wdetail2.md_year     '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' wdetail2.Usage FORMAT "x(50)"  '"' SKIP.  
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' wdetail2.coulor      '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' wdetail2.cc          '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' wdetail2.regis_year  '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' wdetail2.engno       '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' wdetail2.chasno      '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' Wdetail2.Acc_CV      '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' Wdetail2.Acc_amount  '"' SKIP.            
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' wdetail2.License     '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' wdetail2.regis_CL    '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' wdetail2.campaign    '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' wdetail2.typ_work    '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' deci(wdetail2.si) FORMAT ">>,>>>,>>9.99"    '"' SKIP.       
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' wdetail2.prvpol           '"' SKIP.                                      
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' wdetail2.branch           '"' SKIP. 
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' wdetail2.policy           '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' wdetail2.cover            '"' SKIP.                                          
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' deci(wdetail2.pol_netprem)'"' SKIP.                                          
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' deci(wdetail2.pol_gprem)  '"' SKIP.                                          
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' deci(wdetail2.pol_stamp)  '"' SKIP.                                          
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' deci(wdetail2.pol_vat)    '"' SKIP.                                          
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' deci(wdetail2.pol_stamp_ho)  '"' SKIP.  /*A61-0152*/                                   
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' deci(wdetail2.pol_vat_ho)    '"' SKIP.  /*A61-0152*/ 
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' deci(wdetail2.pol_wht)    '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' wdetail2.com_no           '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' wdetail2.docno            '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' wdetail2.stkno            '"' SKIP.                                 
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' DATE(wdetail2.com_comm_date) FORMAT "99/99/9999" '"' SKIP.         
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999" '"' SKIP.         
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' deci(wdetail2.com_netprem)'"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' deci(wdetail2.com_gprem)  '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' deci(wdetail2.com_stamp)  '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' deci(wdetail2.com_vat)    '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' deci(wdetail2.com_wht)    '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' wdetail2.deler            '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' wdetail2.showroom         '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' wdetail2.typepay          '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' wdetail2.financename      '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' wdetail2.mail_hno         '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' wdetail2.mail_build       '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' wdetail2.mail_mu          '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' wdetail2.mail_soi         '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' wdetail2.mail_road        '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' wdetail2.mail_tambon      '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' wdetail2.mail_amper       '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' wdetail2.mail_country     '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' wdetail2.mail_post        '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' wdetail2.send_date        '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' wdetail2.send_data        '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' wdetail2.REMARK1          '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' wdetail2.occup            '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' wdetail2.regis_no         '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' wdetail2.np_f18line1      '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' wdetail2.np_f18line2      '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' wdetail2.np_f18line3      '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' wdetail2.np_f18line4      '"' SKIP.                                
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' wdetail2.np_f18line5      '"' SKIP. 
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' wdetail2.np_f18line6      '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"' wdetail2.np_f18line7      '"' SKIP. 
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"' wdetail2.np_f18line8      '"' SKIP. 
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"' wdetail2.np_f18line9      '"' SKIP.  /*Add by Kridtiya i. A63-0472*/
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"' wdetail2.insp             '"' SKIP. 
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"' wdetail2.ispno            '"' SKIP. /*A65-0177*/
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K" '"' wdetail2.detail         '"' SKIP. /*A65-0177*/
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K" '"' wdetail2.damage         '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K" '"' wdetail2.ispacc         '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K" '"' wdetail2.agent          '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K" '"' wdetail2.product        '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"' wdetail2.campaign_ov   '"' SKIP.
      PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"' wdetail2.comment    '"' SKIP.
                                                                           
    End.  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createpol_til c-Win 
PROCEDURE pro_createpol_til :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A58-0489     
------------------------------------------------------------------------------*/
If  substr(fi_output2,length(fi_output2) - 3,4) <>  ".slk"  Then
    fi_output2  =  Trim(fi_output2) + ".slk"  .
ASSIGN nv_cnt  =  0
       nv_row  =  0.
OUTPUT STREAM ns2 TO VALUE(fi_output2).
PUT STREAM ns2 "ID;PND" SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "  Ins. Year type                 "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "  Business type                  "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "  TAS received by                "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "  Ins company                    "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "  Insurance ref no.              "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "  TPIS Contract No.              "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "  Title name                     "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "  customer name                  "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "  customer lastname              "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "  Customer type                  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "  Director Name                  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "  ID number                      "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "  House no.                      "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "  Building                       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "  Village name/no.               "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "  Soi                            "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "  Road                           "  '"' SKIP.                                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "  Sub-district                   "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "  District                       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "  Province                       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "  Postcode                       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "  Brand                          "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "  Car model                      "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "  Insurance Code                 "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "  Model Year                     "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "  Usage Type                     "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "  Colour                         "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "  Car Weight                     "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "  Year                           "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "  Engine No.                     "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "  Chassis No.                    "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "  Accessories (for CV)           "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "  Accessories amount             "  '"' SKIP.                                           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "  License No.                    "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "  Registered Car License         "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "  Campaign                       "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "  Type of work                   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "  Garage Repair                  "  '"' SKIP. /*a62-0422*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "  Model Description              "  '"' SKIP. /*a62-0422*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "  Insurance amount               "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "  Insurance Date ( Voluntary )   "  '"' SKIP.                                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "  Expiry Date ( Voluntary)       "  '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "  Last Policy No. (Voluntary)    "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "  Insurance Type                 "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "  Net premium (Voluntary)        "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "  Gross premium (Voluntary)      "  '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "  Stamp                          "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "  VAT                            "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "  WHT                            "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "  Compulsory No.                 "  '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "  Insurance Date ( Compulsory )  "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "  Expiry Date ( Compulsory)      "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "  Net premium (Compulsory)       "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "  Gross premium (Compulsory)     "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "  Stamp                          "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "  VAT                            "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "  WHT                            "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "  Dealer                         "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "  Showroom                       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "  Payment Type                   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "  Beneficiery                    "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "  Mailing House no.              "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "  Mailing  Building              "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "  Mailing  Village name/no.      "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "  Mailing Soi                    "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "  Mailing  Road                  "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "  Mailing  Sub-district          "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "  Mailing  District              "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "  Mailing Province               "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "  Mailing Postcode               "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "  Policy no. to customer date    "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "  New policy no                  "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "  Insurer Stamp Date             "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "  Remark                         "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' "  Occupation code                "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "  Register NO.                   "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "  Status Policy                  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "  Status Compulsory              "  '"' SKIP.
RUN pro_sendtpis.
nv_row   =  nv_row + 1.
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
RUN pro_createpol_til_txt.
FOR EACH wdetail2.
    DELETE wdetail2.
END.
message "Export Match File Policy Complete"  view-as alert-box.
RELEASE sicuw.uwm100.
RELEASE sicuw.uwm130.
RELEASE sicuw.uwm301.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createpol_til_txt c-Win 
PROCEDURE pro_createpol_til_txt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A58-0489     
------------------------------------------------------------------------------*/
If  substr(fi_output1,length(fi_output1) - 3,4) <>  ".csv"  Then
    fi_output1  =  Trim(fi_output1) + ".csv"  .
OUTPUT TO VALUE(fi_output1).
EXPORT DELIMITER ","                       
"Ins. Year type"                            /*1  */                           
"Business type"                             /*2  */
"TAS received by"                           /*3  */ 
"Ins company"                               /*4  */
"Insurance ref no."                         /*5  */   
"TPIS Contract No."                         /*6  */   
"Title name"                                /*7  */
"customer name "                            /*8  */
"customer lastname"                         /*9  */   
"Customer type"                             /*10 */
"Director Name"                             /*11 */
"ID number "                                /*12 */
"House no. "                                /*13 */
"Building "                                 /*14 */
"Village name/no."                          /*15 */
"Soi"                                       /*16 */
"Road"                                      /*17 */
"Sub-district"                              /*18 */
"District"                                  /*19 */
"Province"                                  /*20 */
"Postcode"                                  /*21 */
"Brand "                                    /*22 */
"Car model"                                 /*23 */
"Insurance Code"                            /*24 */
"Model Year"                                /*25 */
"Usage Type"                                /*26 */
"Colour"                                    /*27 */
"Car Weight"                                /*28 */
"Year"                                      /*29 */
"Engine No."                                /*30 */
"Chassis No."                               /*31 */
"Accessories (for CV)"                      /*32 */
"Accessories amount  "                      /*33 */                     
"License No."                               /*34 */
"Registered Car License"                    /*35 */
"Campaign "                                 /*36 */
"Type of work"                              /*37 */
"Garage "                                   /*38 */   /*A62-0422*/
"Model Description "                        /*39 */   /*A62-0422*/
"Insurance amount"                          /*40 */   
"Insurance Date ( Voluntary )"              /*41 */                                  
"Expiry Date ( Voluntary)"                  /*42 */                    
"Last Policy No. (Voluntary)"               /*43 */     
"Insurance Type"                            /*44 */   
"Net premium (Voluntary)"                   /*45 */   
"Gross premium (Voluntary)"                 /*46 */                      
"Stamp"                                     /*47 */   
"VAT"                                       /*48 */   
"WHT"                                       /*49 */   
"Compulsory No."                            /*50 */          
"Insurance Date ( Compulsory )"             /*51 */       
"Expiry Date ( Compulsory)"                 /*52 */   
"Net premium (Compulsory) "                 /*53 */   
"Gross premium (Compulsory)"                /*54 */    
"Stamp "                                    /*55 */   
"VAT"                                       /*56 */   
"WHT"                                       /*57 */   
"Dealer"                                    /*58 */   
"Showroom "                                 /*59 */   
"Payment Type"                              /*60 */   
"Beneficiery "                              /*61 */   
"Mailing House no."                         /*62 */   
"Mailing  Building"                         /*63 */   
"Mailing  Village name/no."                 /*64 */   
"Mailing Soi"                               /*65 */   
"Mailing  Road"                             /*66 */   
"Mailing  Sub-district"                     /*67 */   
"Mailing  District"                         /*68 */   
"Mailing Province"                          /*69 */   
"Mailing Postcode"                          /*70 */   
"Policy no. to customer date"               /*71 */   
"New policy no "                            /*72 */   
"Insurer Stamp Date"                        /*73 */   
"Remark "                                   /*74 */
"Occupation code"  .                        /*75 */
FOR EACH wdetail2 NO-LOCK.                  
EXPORT DELIMITER ","                        
 trim(Wdetail2.ins_ytyp)                                                                                        /*1  */
 trim(wdetail2.bus_typ)                                                                                         /*2  */
 trim(wdetail2.TASreceived)                                                                                     /*3  */
 trim(wdetail2.InsCompany)                                                                                      /*4  */
 trim(wdetail2.Insurancerefno)                                                                                  /*5  */
 trim(wdetail2.tpis_no)                                                                                         /*6  */
 trim(wdetail2.ntitle)                                                                                          /*7  */
 trim(wdetail2.insnam)                                                                                          /*8  */
 trim(wdetail2.NAME2)                                                                                           /*9  */
 trim(wdetail2.cust_type)                                                                                       /*10 */
 trim(wdetail2.nDirec)                                                                                          /*11 */
 trim(wdetail2.ICNO)                                                                                            /*12 */
 trim(wdetail2.address)                                                                                         /*13 */
 trim(wdetail2.build)                                                                                           /*14 */
 trim(wdetail2.mu)                                                                                              /*15 */
 trim(wdetail2.soi)                                                                                             /*16 */
 trim(wdetail2.road)                                                                                            /*17 */
 trim(wdetail2.tambon)                                                                                          /*18 */
 trim(wdetail2.amper)                                                                                           /*19 */
 trim(wdetail2.country)                                                                                         /*20 */
 trim(wdetail2.post)                                                                                            /*21 */
 trim(wdetail2.brand)                                                                                           /*22 */
 trim(wdetail2.model)                                                                                           /*23 */
 trim(wdetail2.class)                                                                                           /*24 */
 trim(wdetail2.md_year)                                                                                         /*25 */
 trim(wdetail2.Usage)                                                                                           /*26 */
 trim(wdetail2.coulor)                                                                                          /*27 */
 trim(wdetail2.cc)                                                                                              /*28 */
 trim(wdetail2.regis_year)                                                                                      /*29 */
 trim(wdetail2.engno)                                                                                           /*30 */
 trim(wdetail2.chasno)                                                                                          /*31 */
 trim(Wdetail2.Acc_CV)                                                                                          /*32 */
 trim(Wdetail2.Acc_amount)                                                                                      /*33 */
 trim(wdetail2.License)                                                                                         /*34 */
 trim(wdetail2.regis_CL)                                                                                        /*35 */
 trim(wdetail2.campaign)                                                                                        /*36 */
 trim(wdetail2.typ_work)                                                                                        /*37 */
 trim(wdetail2.garage)                                                                                          /*38 */      /*A62-0422*/
 trim(wdetail2.desmodel)                                                                                        /*39 */      /*A62-0422*/
 trim(wdetail2.si)                                                                                              /*40 */ 
 if wdetail2.pol_comm_date <> "" then string(date(wdetail2.pol_comm_date),"99/99/9999") ELSE ""                 /*41 */ 
 if wdetail2.pol_exp_date  <> "" then string(date(wdetail2.pol_exp_date),"99/99/9999") ELSE ""                  /*42 */ 
 trim(wdetail2.prvpol)                                                                                          /*43 */ 
 trim(wdetail2.cover)                                                                                           /*44 */ 
 trim(wdetail2.pol_netprem)                                                                                     /*45 */ 
 trim(wdetail2.pol_gprem)                                                                                       /*46 */ 
 trim(wdetail2.pol_stamp)                                                                                       /*47 */ 
 trim(wdetail2.pol_vat)                                                                                         /*48 */ 
 trim(wdetail2.pol_wht)                                                                                         /*49 */ 
 trim(wdetail2.com_no)                                                                                          /*50 */ 
 IF wdetail2.com_comm_date <> "" then string(date(wdetail2.com_comm_date),"99/99/9999") ELSE ""                 /*51 */ 
 IF wdetail2.com_exp_date  <> "" then string(date(wdetail2.com_exp_date),"99/99/9999") ELSE ""                  /*52 */ 
 trim(wdetail2.com_netprem)                                                                                     /*53 */ 
 trim(wdetail2.com_gprem)                                                                                       /*54 */ 
 trim(wdetail2.com_stamp)                                                                                       /*55 */ 
 trim(wdetail2.com_vat)                                                                                         /*56 */ 
 trim(wdetail2.com_wht)                                                                                         /*57 */ 
 trim(wdetail2.deler)                                                                                           /*58 */ 
 trim(wdetail2.showroom)                                                                                        /*59 */ 
 trim(wdetail2.typepay)                                                                                         /*60 */ 
 trim(wdetail2.financename)                                                                                     /*61 */ 
 trim(wdetail2.mail_hno)                                                                                        /*62 */ 
 trim(wdetail2.mail_build)                                                                                      /*63 */ 
 trim(wdetail2.mail_mu)                                                                                         /*64 */ 
 trim(wdetail2.mail_soi)                                                                                        /*65 */ 
 trim(wdetail2.mail_road)                                                                                       /*66 */ 
 trim(wdetail2.mail_tambon)                                                                                     /*67 */ 
 trim(wdetail2.mail_amper)                                                                                      /*68 */ 
 trim(wdetail2.mail_country)                                                                                    /*69 */ 
 trim(wdetail2.mail_post)                                                                                       /*70 */ 
 trim(wdetail2.send_date)                                                                                       /*71 */ 
 trim(wdetail2.policy)                                                                                          /*72 */ 
 trim(wdetail2.send_data)                                                                                       /*73 */ 
 trim(wdetail2.REMARK)                                                                                          /*74 */
 TRIM(wdetail2.occup).                                                                                          /*75 */
END.                                                                                                           
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_sendtpis c-Win 
PROCEDURE pro_sendtpis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nf_expdat70 AS CHAR FORMAT "x(15)".
DEF VAR nf_expdat72 AS CHAR FORMAT "x(15)".
DEF VAR nv_expdat70 AS CHAR FORMAT "x(15)".
DEF VAR nv_expdat72 AS CHAR FORMAT "x(15)".
DEF VAR n_length  AS INT.
for each wdetail2.
   IF wdetail2.ins_ytyp = "" THEN DELETE wdetail2.
   ELSE DO:                                                                                   /*A61-0152*/
       ASSIGN n_statuspol          = ""         nf_expdat70   = ""                            /*A61-0152*/
              n_statuscomp         = ""         nf_expdat72   = ""                            /*A61-0152*/
              n_length             = 0          nv_expdat70   = ""                            /*A61-0152*/
              wdetail2.policy      = ""         nv_expdat72   = ""                            /*A61-0152*/
              wdetail2.com_no      = ""         nf_expdat70   = trim(wdetail2.pol_exp_date)   /*A61-0152*/
              wdetail2.prvpol      = ""         nf_expdat72   = trim(wdetail2.com_exp_date)   /*A61-0152*/
              wdetail2.pol_comm_date = ""       wdetail2.pol_exp_date  = ""
              wdetail2.com_comm_date = ""       wdetail2.com_exp_date  = ""
              wdetail2.si        = ""           wdetail2.License   = ""    
              wdetail2.engno     = ""           wdetail2.chasno    = "". 
       FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol =  trim(wdetail2.tpis_no) NO-LOCK.
            ASSIGN nv_expdat70 = STRING(DAY(sicuw.uwm100.expdat),"99") + "/" + STRING(MONTH(sicuw.uwm100.expdat),"99") + "/" + 
                                 STRING(YEAR(sicuw.uwm100.expdat),"9999") .   /*A61-0152*/
            IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
            ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY) THEN NEXT.         /*A61-0152*/
            ELSE IF DATE(nv_expdat70) <> DATE(nf_expdat70)  THEN NEXT.         /*A61-0152*/
            ELSE DO:
                  ASSIGN 
                     wdetail2.policy        = sicuw.uwm100.policy 
                     wdetail2.prvpol        = sicuw.uwm100.prvpol 
                     wdetail2.pol_comm_date = STRING(sicuw.uwm100.comdat) 
                     wdetail2.pol_exp_date  = STRING(sicuw.uwm100.expdat)
                     wdetail2.ntitle        = sicuw.uwm100.ntitle                                                 
                     wdetail2.ICNO          = sicuw.uwm100.anam2
                     wdetail2.pol_netprem   = STRING(sicuw.uwm100.prem_t)
                     wdetail2.pol_gprem     = string(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t)
                     wdetail2.pol_stamp     = string(sicuw.uwm100.rstp_t)    
                     wdetail2.pol_vat       = string(sicuw.uwm100.rtax_t)
                     wdetail2.pol_wht       = STRING((DECI(wdetail2.pol_netprem) + DECI(wdetail2.pol_stamp)) * 0.01 )
                     n_status               = sicuw.uwm100.releas
                     n_statuspol            = STRING(n_status).
                  
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
                  /*-- หาทะเบียน --*/
                  FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                      sicuw.uwm301.policy = sicuw.uwm100.policy AND 
                      sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                      sicuw.uwm301.endcnt = sicuw.uwm100.endcnt AND 
                      sicuw.uwm301.riskno = 1                   AND
                      sicuw.uwm301.itemno = 1                   NO-LOCK NO-ERROR.
                     IF AVAIL sicuw.uwm301 THEN DO:
                        ASSIGN wdetail2.License     = sicuw.uwm301.vehreg
                               wdetail2.engno       = sicuw.uwm301.eng_no
                               wdetail2.chasno      = sicuw.uwm301.cha_no
                               /*wdetail2.financename = sicuw.uwm301.mv_ben83*/
                               /*wdetail2.License     = SUBSTR(wdetail2.License,1,R-INDEX(wdetail2.license," ")).*/ /*A66-0252*/
                               wdetail2.License     = IF  wdetail2.License <> "" THEN SUBSTR(wdetail2.License,1,R-INDEX(wdetail2.license," ")) ELSE "" . /*A66-0252*/
                              /*-- หาทุน --*/
                              FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                   sicuw.uwm130.policy = sicuw.uwm100.policy  AND 
                                   sicuw.uwm130.rencnt = sicuw.uwm100.rencnt AND
                                   sicuw.uwm130.endcnt = sicuw.uwm100.endcnt AND 
                                   sicuw.uwm130.riskno = 1                   AND
                                   sicuw.uwm130.itemno = 1                   NO-LOCK NO-ERROR.
                                  IF AVAIL sicuw.uwm130 THEN 
                                      ASSIGN wdetail2.si   = IF sicuw.uwm301.covcod = "1" THEN STRING(sicuw.uwm130.uom6_v) ELSE STRING(sicuw.uwm130.uom7_v).
                                  ELSE  ASSIGN wdetail2.si   = "".
                      END.
                      ELSE DO:
                          ASSIGN wdetail2.si     = ""    wdetail2.License   = ""
                                 wdetail2.engno  = ""    wdetail2.chasno    = "".
                      END.
                RUN proc_exportNote.
            END.
       END.
       IF wdetail2.com_no = "" AND INDEX(wdetail2.typ_work,"C") <> 0  THEN DO:
           FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol =  trim(wdetail2.tpis_no) NO-LOCK.
             ASSIGN nv_expdat72 = STRING(DAY(sicuw.uwm100.expdat),"99") + "/" + STRING(MONTH(sicuw.uwm100.expdat),"99") + "/" + 
                                  STRING(YEAR(sicuw.uwm100.expdat),"9999") . /*A61-0152*/
             IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
             ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY) THEN NEXT.      /*A61-0152*/
             ELSE IF DATE(nv_expdat72) <> DATE(nf_expdat72)  THEN NEXT.      /*A61-0152*/
             ELSE DO:
                    ASSIGN wdetail2.com_no = sicuw.uwm100.policy 
                         wdetail2.com_comm_date = STRING(sicuw.uwm100.comdat)
                         wdetail2.com_exp_date  = STRING(sicuw.uwm100.expdat)
                         wdetail2.ntitle        = sicuw.uwm100.ntitle                                                          
                         wdetail2.ICNO          = sicuw.uwm100.anam2                                                           
                         wdetail2.com_netprem   = STRING(sicuw.uwm100.prem_t)                                                  
                         wdetail2.com_gprem     = string(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t)      
                         wdetail2.com_stamp     = string(sicuw.uwm100.rstp_t)                                                  
                         wdetail2.com_vat       = string(sicuw.uwm100.rtax_t)
                         wdetail2.com_wht       = STRING((DECI(wdetail2.com_netprem) + DECI(wdetail2.com_stamp)) * 0.01 ) 
                         n_status        = sicuw.uwm100.releas
                         n_statuscomp    = IF n_status = NO THEN "NO" ELSE "YES".
                        
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
                    FIND FIRST sicuw.uwm301 USE-INDEX uwm30101      WHERE 
                      sicuw.uwm301.policy   = sicuw.uwm100.policy AND 
                      sicuw.uwm301.rencnt   = sicuw.uwm100.rencnt AND
                      sicuw.uwm301.endcnt   = sicuw.uwm100.endcnt AND 
                      sicuw.uwm301.riskno   = 1                   AND 
                      sicuw.uwm301.itemno   = 1                   NO-LOCK NO-ERROR.
                      IF AVAIL sicuw.uwm301 THEN
                          ASSIGN wdetail2.License = sicuw.uwm301.vehreg
                                 wdetail2.engno   = sicuw.uwm301.eng_no  
                                 wdetail2.chasno  = sicuw.uwm301.cha_no 
                                 /*wdetail2.License     = SUBSTR(wdetail2.License,1,R-INDEX(wdetail2.license," ")).*/ /*A66-0252*/
                                 wdetail2.License     = IF  wdetail2.License <> "" THEN SUBSTR(wdetail2.License,1,R-INDEX(wdetail2.license," ")) ELSE "" . /*A66-0252*/
                      ELSE
                          ASSIGN wdetail2.License  = ""
                                 wdetail2.engno    = ""
                                 wdetail2.chasno   = "".
        
                    RUN proc_ExportNote. 
                 END.
            END.
       END.
     ASSIGN nv_cnt  =  nv_cnt  + 1 
            nv_row  =  nv_row  + 1 .
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   Wdetail2.ins_ytyp         '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail2.bus_typ          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail2.TASreceived      '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail2.InsCompany       '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail2.Insurancerefno   '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail2.tpis_no          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail2.ntitle           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail2.insnam           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail2.NAME2            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetail2.cust_type        '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetail2.nDirec           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetail2.ICNO             '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetail2.address          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   wdetail2.build            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   wdetail2.mu               '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   wdetail2.soi              '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   wdetail2.road             '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   wdetail2.tambon           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   wdetail2.amper            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   wdetail2.country          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   wdetail2.post             '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   wdetail2.brand            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   wdetail2.model            '"' SKIP.            
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   wdetail2.class            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   wdetail2.md_year          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   wdetail2.Usage FORMAT "x(50)"  '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   wdetail2.coulor           '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   wdetail2.cc               '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   wdetail2.regis_year       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   wdetail2.engno            '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   wdetail2.chasno           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   Wdetail2.Acc_CV           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   Wdetail2.Acc_amount       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'   wdetail2.License          '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'   wdetail2.regis_CL         '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'   wdetail2.campaign         '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'   wdetail2.typ_work         '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'   wdetail2.garage           '"' SKIP.    /*A62-0422*/
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'   wdetail2.desmodel         '"' SKIP.    /*A62-0422*/
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'   deci(wdetail2.si) FORMAT ">>,>>>,>>9.99"      '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'   DATE(wdetail2.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'   DATE(wdetail2.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'   wdetail2.prvpol           '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'   wdetail2.cover            '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'   deci(wdetail2.pol_netprem)'"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'   deci(wdetail2.pol_gprem)  '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'   deci(wdetail2.pol_stamp)  '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'   deci(wdetail2.pol_vat)    '"' SKIP.           
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'   deci(wdetail2.pol_wht)    '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'   wdetail2.com_no           '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'   DATE(wdetail2.com_comm_date) FORMAT "99/99/9999" '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'   DATE(wdetail2.com_exp_date)  FORMAT "99/99/9999" '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'   deci(wdetail2.com_netprem)'"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'   deci(wdetail2.com_gprem)  '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'   deci(wdetail2.com_stamp)  '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'   deci(wdetail2.com_vat)    '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'   deci(wdetail2.com_wht)    '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'   wdetail2.deler            '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'   wdetail2.showroom         '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'   wdetail2.typepay          '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"'   wdetail2.financename      '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"'   wdetail2.mail_hno         '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"'   wdetail2.mail_build       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"'   wdetail2.mail_mu          '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"'   wdetail2.mail_soi         '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"'   wdetail2.mail_road        '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"'   wdetail2.mail_tambon      '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"'   wdetail2.mail_amper       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"'   wdetail2.mail_country     '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"'   wdetail2.mail_post        '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"'   wdetail2.send_date        '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"'   wdetail2.policy           '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"'   wdetail2.send_data        '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"'   wdetail2.REMARK1          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"'   wdetail2.occup            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"'   wdetail2.regis_no         '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"'   n_statuspol               '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"'   n_statuscomp              '"' SKIP.
    END.
END.
      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

