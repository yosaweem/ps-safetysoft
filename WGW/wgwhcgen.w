&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
/* Connected Databases : sic_test         PROGRESS                      */
  File:   Description: 
  Input Parameters:  <none>
  Output Parameters: <none>
  Author:  Created: ------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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
/*******************************/                                       
/*programid   : wgwhcgen.w                                              */ 
/*programname : load text file HCT to GW                                */ 
/*Copyright  : Safety Insurance Public Company Limited                  */
/*copy write : wgwargen.w                                               */ 
/*           บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/*create by  : Kridtiya i. A52-0172   date . 08/07/2009                
             ปรับโปรแกรมให้สามารถนำเข้า text file HCT to GW system      */ 
/* Modify By : Narin L. ขยาย Format ระบุชื่อผู้ขับขี่ [A54-0396]  */
/* Modify By : Sarinya C. Set PACK H  ปรับโหลดงานประเภท 2+ 3+ 
         ขึ้น Error NCB แก้จาก 2.1 3.1 เป็น 2.2 3.2 [A62-0215]  */
/* Modify By : Sarinya C. แก้ไข Host Expiry เป็น TMSTH [A62-0105]  */
/*proc_definition .....*/

DEF VAR gv_id AS CHAR FORMAT "X(15)" NO-UNDO.   /*A53-0220*/
DEF VAR nv_pwd AS CHAR NO-UNDO.                 /*A53-0220*/
DEF VAR n_firstdat AS DATE INIT ?.              /*A53-0220*/
DEF NEW SHARED VAR nv_producer AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR nv_agent    AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno. 
DEF VAR  n_textfi AS CHAR FORMAT  "x(30)" INIT "".    /*A540125*/
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
DEF NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".  
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
{wgw\wgwhcgen.i}      /*ประกาศตัวแปร*/
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
DEFINE  WORKFILE wuppertxt2 NO-UNDO
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
DEF VAR n_ratmin  AS INTE INIT 0.
DEF VAR n_ratmax  AS INTE INIT 0.
DEF VAR nv_dscom  AS DECI INIT 0.
DEF VAR nv_polmaster AS CHAR FORMAT "x(35)" INIT "" .
DEF VAR nv_CC  AS DECI INIT 0. /* ranu : A64-0422 */
DEF VAR nv_timein AS CHAR FORMAT "x(35)" INIT "" .
DEF VAR nv_cal AS LOGICAL INIT NO. /*A68-0061*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_producer

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wimproducer wdetail wdetail2

/* Definitions for BROWSE br_producer                                   */
&Scoped-define FIELDS-IN-QUERY-br_producer wimproducer.idno wimproducer.saletype wimproducer.camname wimproducer.notitype wimproducer.producer   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_producer   
&Scoped-define SELF-NAME br_producer
&Scoped-define QUERY-STRING-br_producer FOR EACH wimproducer                        BY wimproducer.idno
&Scoped-define OPEN-QUERY-br_producer OPEN QUERY br_producer FOR EACH wimproducer                        BY wimproducer.idno    .
&Scoped-define TABLES-IN-QUERY-br_producer wimproducer
&Scoped-define FIRST-TABLE-IN-QUERY-br_producer wimproducer


/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail WDETAIL2.WARNING wdetail2.WCampaign wdetail.policyno wdetail.cndat wdetail.appenno wdetail.comdat wdetail.expdat wdetail.comcode wdetail.cartyp wdetail.saletyp wdetail.campen wdetail.freeamonth wdetail.covcod wdetail.typcom wdetail.garage wdetail.bysave wdetail.tiname wdetail.insnam wdetail.name2 wdetail.name3 wdetail.addr wdetail.road wdetail.tambon wdetail.amper wdetail.country wdetail.post wdetail2.policyno   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail     , ~
       LAST  wdetail2 .     /* WHERE wdetail2.policyno = wdetail.policyno.*/
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail     , ~
       LAST  wdetail2 .     /* WHERE wdetail2.policyno = wdetail.policyno.*/.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail wdetail2
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail
&Scoped-define SECOND-TABLE-IN-QUERY-br_wdetail wdetail2


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_wdetail fi_Campaign23 ra_typfile ~
fi_loaddat fi_packgarage fi_packnogar fi_packcov3 fi_campaign fi_redyear ~
fi_proid fi_saletype fi_camname fi_notitype fi_improducer bu_add fi_bchno ~
bu_delete fi_branch fi_producer01 fi_agent fi_prevbat fi_bchyr fi_no_mn30 ~
fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem ~
buok bu_exit bu_hpbrn bu_hpagent fi_outputpro bu_hpagent-2 br_producer ~
fi_packpuls fi_producerinst fi_camp_SP fi_camp_tp tg_flag tg_flagRN ~
RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 RECT-377 RECT-378 RECT-379 ~
RECT-380 
&Scoped-Define DISPLAYED-OBJECTS fi_Campaign23 ra_typfile fi_loaddat ~
fi_packgarage fi_packnogar fi_packcov3 fi_campaign fi_redyear fi_proid ~
fi_saletype fi_camname fi_notitype fi_improducer fi_bchno fi_branch ~
fi_producer01 fi_agent fi_prevbat fi_bchyr fi_no_mn30 fi_filename ~
fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_process ~
fi_outputpro fi_brndes fi_impcnt fi_packpuls fi_completecnt fi_premtot ~
fi_premsuc fi_producerinst fi_camp_SP fi_camp_tp tg_flag tg_flagRN 

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
     SIZE 9.83 BY 1.14
     FONT 6.

DEFINE BUTTON bu_add 
     LABEL "ADD" 
     SIZE 8 BY .95.

DEFINE BUTTON bu_delete 
     LABEL "DEL" 
     SIZE 8 BY .95.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 8.17 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "...." 
     SIZE 5 BY .95.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_hpagent-2 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 6.33 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camname AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Campaign23 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_camp_SP AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_camp_tp AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15  NO-UNDO.

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

DEFINE VARIABLE fi_improducer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_notitype AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_no_mn30 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

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

DEFINE VARIABLE fi_outputpro AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_packcov3 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_packgarage AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_packnogar AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_packpuls AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 96.83 BY .95
     BGCOLOR 3 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer01 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producerinst AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proid AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_redyear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_saletype AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_typfile AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Text", 1,
"CSV New", 2
     SIZE 30 BY .95
     BGCOLOR 5 FGCOLOR 7  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.43
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 15.24
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 4.05
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 3.05
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 2
     BGCOLOR 6 FGCOLOR 1 .

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 90 BY 1.29
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 68 BY 2.38
     BGCOLOR 6 .

DEFINE VARIABLE tg_flag AS LOGICAL INITIAL no 
     LABEL "" 
     VIEW-AS TOGGLE-BOX
     SIZE 2.5 BY 1
     BGCOLOR 29 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE tg_flagRN AS LOGICAL INITIAL no 
     LABEL "" 
     VIEW-AS TOGGLE-BOX
     SIZE 2.5 BY 1
     BGCOLOR 29 FGCOLOR 2  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_producer FOR 
      wimproducer SCROLLING.

DEFINE QUERY br_wdetail FOR 
      wdetail, 
      wdetail2 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_producer C-Win _FREEFORM
  QUERY br_producer DISPLAY
      wimproducer.idno        COLUMN-LABEL "ID"           FORMAT "x(3)"
      wimproducer.saletype    COLUMN-LABEL "ประเภทการขาย" FORMAT "x(5)"
      wimproducer.camname     COLUMN-LABEL "ชื่อแคมเปญ"   FORMAT "x(15)"
      wimproducer.notitype    COLUMN-LABEL "การแจ้งงาน"   FORMAT "x(2)"
      wimproducer.producer    COLUMN-LABEL "รหัสตัวแทน"   FORMAT "x(10)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 62 BY 5
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .5 FIT-LAST-COLUMN.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail C-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      WDETAIL2.WARNING       COLUMN-LABEL "WARNING"           format "x(30)"
      wdetail2.WCampaign     COLUMN-LABEL "WARNING Campiagn"  format "x(30)"  
      wdetail.policyno       COLUMN-LABEL "Policy No."    
      wdetail.cndat          COLUMN-LABEL "CN date."      
      wdetail.appenno        COLUMN-LABEL "appenno "      
      wdetail.comdat         COLUMN-LABEL "comdate."      
      wdetail.expdat         COLUMN-LABEL "expidate."     
      wdetail.comcode        COLUMN-LABEL "company code"  
      wdetail.cartyp         COLUMN-LABEL "cartyp"        
      wdetail.saletyp        COLUMN-LABEL "saletyp"       
      wdetail.campen         COLUMN-LABEL "campen"        
      wdetail.freeamonth     COLUMN-LABEL "freeamonth "   
      wdetail.covcod         COLUMN-LABEL "covcod  "      
      wdetail.typcom         COLUMN-LABEL "typcom  "      
      wdetail.garage         COLUMN-LABEL "garage  "          
      wdetail.bysave         COLUMN-LABEL "bysave  "          
      wdetail.tiname         COLUMN-LABEL "tiname  "          
      wdetail.insnam         COLUMN-LABEL "insnam  "          
      wdetail.name2          COLUMN-LABEL "name2   "          
      wdetail.name3          COLUMN-LABEL "name3   "          
      wdetail.addr           COLUMN-LABEL "addr    "          
      wdetail.road           COLUMN-LABEL "road    "          
      wdetail.tambon         COLUMN-LABEL "tampon  "          
      wdetail.amper          COLUMN-LABEL "amper   "          
      wdetail.country        COLUMN-LABEL "country "          
      wdetail.post           COLUMN-LABEL "post    "          
      wdetail2.policyno      COLUMN-LABEL "policyno2"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 3.52
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_wdetail AT ROW 18 COL 1.5
     fi_Campaign23 AT ROW 7.1 COL 53.17 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     ra_typfile AT ROW 10.14 COL 100.5 NO-LABEL
     fi_loaddat AT ROW 2.62 COL 13 COLON-ALIGNED NO-LABEL
     fi_packgarage AT ROW 2.62 COL 41.17 COLON-ALIGNED NO-LABEL
     fi_packnogar AT ROW 2.62 COL 56.83 COLON-ALIGNED NO-LABEL
     fi_packcov3 AT ROW 2.62 COL 71 COLON-ALIGNED NO-LABEL
     fi_campaign AT ROW 2.62 COL 99.33 COLON-ALIGNED NO-LABEL
     fi_redyear AT ROW 2.62 COL 123.67 COLON-ALIGNED NO-LABEL
     fi_proid AT ROW 3.76 COL 8 COLON-ALIGNED NO-LABEL
     fi_saletype AT ROW 3.76 COL 32 COLON-ALIGNED NO-LABEL
     fi_camname AT ROW 3.76 COL 47.17 COLON-ALIGNED NO-LABEL
     fi_notitype AT ROW 4.81 COL 19.5 COLON-ALIGNED NO-LABEL
     fi_improducer AT ROW 4.81 COL 34.83 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 4.81 COL 51.83
     fi_bchno AT ROW 22.81 COL 16 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_delete AT ROW 4.81 COL 60.67
     fi_branch AT ROW 6.14 COL 14 COLON-ALIGNED NO-LABEL
     fi_producer01 AT ROW 7.14 COL 14 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 8.14 COL 14 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 9.14 COL 24.67 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 9.14 COL 57.83 COLON-ALIGNED NO-LABEL
     fi_no_mn30 AT ROW 9 COL 98.5 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 10.14 COL 32.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 10.14 COL 95
     fi_output1 AT ROW 11.14 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 12.14 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 14.14 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 15.38 COL 33 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 15.38 COL 71.33 NO-LABEL
     buok AT ROW 15.86 COL 108.17
     bu_exit AT ROW 15.81 COL 121.83
     bu_hpbrn AT ROW 6.14 COL 22.5
     bu_hpagent AT ROW 8.14 COL 30.83
     fi_process AT ROW 16.57 COL 3.17 NO-LABEL
     fi_outputpro AT ROW 13.14 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_brndes AT ROW 6.14 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 22.24 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpagent-2 AT ROW 7.14 COL 30.83
     br_producer AT ROW 3.71 COL 70.5
     fi_packpuls AT ROW 2.62 COL 84.67 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.24 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.24 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.29 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_producerinst AT ROW 11.14 COL 111.83 COLON-ALIGNED NO-LABEL
     fi_camp_SP AT ROW 6.1 COL 53 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_camp_tp AT ROW 8.1 COL 53.17 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     tg_flag AT ROW 12.43 COL 98.5 WIDGET-ID 40
     tg_flagRN AT ROW 13.48 COL 98.5 WIDGET-ID 46
     "       Branch :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 6.14 COL 2.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "แคมเปญ Pack 2+3+ :" VIEW-AS TEXT
          SIZE 20.5 BY .95 AT ROW 7.1 COL 34.5 WIDGET-ID 8
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.24 COL 60.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Code Instal3:" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 11.14 COL 100.5
          BGCOLOR 5 FGCOLOR 2 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .91 AT ROW 15.38 COL 70 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Output Check Producer :" VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 13.14 COL 10.17
          BGCOLOR 18 FGCOLOR 4 
     "แคมเปญ Triple Pack :" VIEW-AS TEXT
          SIZE 20.5 BY .95 AT ROW 8.1 COL 34.5 WIDGET-ID 12
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "์New Tariff Calculate (NEW)" VIEW-AS TEXT
          SIZE 29.5 BY 1 AT ROW 12.43 COL 101 WIDGET-ID 42
          BGCOLOR 29 FGCOLOR 6 
     "    IMPORT TEXT FILE MOTOR [HCT]" VIEW-AS TEXT
          SIZE 105.17 BY .95 AT ROW 1.19 COL 2.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "ชื่อแคมเปญ:" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 3.76 COL 38.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 23.24 COL 60.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 15.38 COL 89
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Packป.3 :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 2.62 COL 62.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "การแจ้งงาน N/R/S:" VIEW-AS TEXT
          SIZE 18 BY .95 AT ROW 4.81 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 11.14 COL 10.17
          BGCOLOR 18 FGCOLOR 1 
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 23.24 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "์New Tariff Calculate (RENEW)" VIEW-AS TEXT
          SIZE 29.5 BY 1 AT ROW 13.48 COL 101 WIDGET-ID 44
          BGCOLOR 29 FGCOLOR 6 
     "รหัสตัวแทน:" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 4.81 COL 25.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ชนิดการขายN/C/S:" VIEW-AS TEXT
          SIZE 18 BY .95 AT ROW 3.76 COL 15.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ICE 12/04/2025" VIEW-AS TEXT
          SIZE 19 BY .76 AT ROW 1.29 COL 109 WIDGET-ID 14
     "IDNO:" VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 3.76 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 9.14 COL 2.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Pack 2+3+" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 2.62 COL 76.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 10.14 COL 10.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.24 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Campaign :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 2.62 COL 90.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " Load Date :":35 VIEW-AS TEXT
          SIZE 12.33 BY .95 AT ROW 2.62 COL 2.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ปีรถป้ายแดง" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 2.62 COL 114
          BGCOLOR 18 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 9.14 COL 58 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 23.24 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 12.14 COL 10.17
          BGCOLOR 18 FGCOLOR 1 
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 14.14 COL 16.17
          BGCOLOR 18 FGCOLOR 1 
     "   Producer  :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 7.14 COL 2.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "NO-MN30 คุ้มครองภัยก่อการร้าย :" VIEW-AS TEXT
          SIZE 29.5 BY .95 AT ROW 9 COL 70.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "แคมเปญ SuperPack :" VIEW-AS TEXT
          SIZE 20.5 BY .95 AT ROW 6.1 COL 34.5 WIDGET-ID 4
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Pack ป.1อู่:" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 2.62 COL 47
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Pack ป.1 อู่ห้าง:" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 2.62 COL 28.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 22.24 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 15.38 COL 32.67 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " Agent Code :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 8.14 COL 2.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.81 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.43 COL 1
     RECT-373 AT ROW 17.67 COL 1
     RECT-374 AT ROW 21.71 COL 1
     RECT-376 AT ROW 22 COL 5
     RECT-377 AT ROW 15.43 COL 106.5
     RECT-378 AT ROW 15.43 COL 119.83
     RECT-379 AT ROW 15.19 COL 9.83
     RECT-380 AT ROW 3.62 COL 2
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
         TITLE              = "Load Text file HCT[ฮอนด้าลิสซิ่ง]"
         HEIGHT             = 24.24
         WIDTH              = 132.67
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
/* BROWSE-TAB br_wdetail 1 fr_main */
/* BROWSE-TAB br_producer bu_hpagent-2 fr_main */
ASSIGN 
       br_wdetail:COLUMN-RESIZABLE IN FRAME fr_main       = TRUE.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

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
/* SETTINGS FOR FILL-IN fi_process IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.83 BY .95 AT ROW 9.14 COL 58 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 20 BY .91 AT ROW 15.38 COL 32.67 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .91 AT ROW 15.38 COL 70 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.24 COL 60.5 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 22.24 COL 95.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 23.24 COL 60.5 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 23.24 COL 96 RIGHT-ALIGNED          */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_producer
/* Query rebuild information for BROWSE br_producer
     _START_FREEFORM
OPEN QUERY br_producer FOR EACH wimproducer
                       BY wimproducer.idno    .
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_producer */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_query FOR EACH wdetail
    , LAST  wdetail2 .
    /* WHERE wdetail2.policyno = wdetail.policyno.*/
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Load Text file HCT[ฮอนด้าลิสซิ่ง] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Load Text file HCT[ฮอนด้าลิสซิ่ง] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_producer
&Scoped-define SELF-NAME br_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_producer C-Win
ON ROW-DISPLAY OF br_producer IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    wimproducer.idno    :BGCOLOR IN BROWSE br_producer = z NO-ERROR.
    wimproducer.saletype:BGCOLOR IN BROWSE br_producer = z NO-ERROR.  
    wimproducer.camname :BGCOLOR IN BROWSE br_producer = z NO-ERROR.
    wimproducer.notitype:BGCOLOR IN BROWSE br_producer = z NO-ERROR.
    wimproducer.producer:BGCOLOR IN BROWSE br_producer = z NO-ERROR.
    wimproducer.idno:FGCOLOR IN BROWSE br_producer = s NO-ERROR.  
    wimproducer.saletype:FGCOLOR IN BROWSE br_producer = s NO-ERROR.  
    wimproducer.camname :FGCOLOR IN BROWSE br_producer = s NO-ERROR. 
    wimproducer.notitype:FGCOLOR IN BROWSE br_producer = s NO-ERROR.
    wimproducer.producer:FGCOLOR IN BROWSE br_producer = s NO-ERROR.
    
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
    IF WDETAIL2.WARNING <> "" THEN DO:
        WDETAIL2.WARNING     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail2.WCampaign   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.policyno     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.cndat        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.appenno      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.comdat       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.expdat       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.comcode      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.cartyp       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.saletyp      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
        wdetail.campen       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.freeamonth   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.covcod       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.typcom       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.garage       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.bysave       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
        wdetail.tiname       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.insnam       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.name2        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
        wdetail.name3        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.addr         :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
        wdetail.road         :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
        wdetail.tambon       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.amper        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.country      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.post         :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail2.policyno    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        
        WDETAIL2.WARNING     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail2.WCampaign   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.policyno     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.cndat        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.appenno      :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.comdat       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.expdat       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.comcode      :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.cartyp       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.saletyp      :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.campen       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.freeamonth   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.covcod       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.typcom       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.garage       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.bysave       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.tiname       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.insnam       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.name2        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.name3        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.addr         :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.   
        wdetail.road         :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.   
        wdetail.tambon       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.amper        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.country      :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.post         :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail2.policyno    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
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
        fi_impcnt              = 0.
    nv_timein = STRING(TIME,"HH:MM:SS").
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.

     /* A68-0061 */
     IF tg_flag = NO AND DATE(TODAY) >= 06/01/2025 THEN DO:
       MESSAGE "งานป้ายแดงต้องเลือก New Tariff Calculate " VIEW-AS ALERT-BOX.
       APPLY "entry" TO tg_flag .
       RETURN NO-APPLY.
     END.
     /* end A68-0061 */
    IF fi_branch = " " THEN DO: 
        MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_branch.
        RETURN NO-APPLY.
    END.
    IF fi_producer01 = " " THEN DO:
        MESSAGE "Producer code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_producer01.
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
    ASSIGN fi_output1 = INPUT fi_output1
        fi_output2    = INPUT fi_output2
        fi_output3    = INPUT fi_output3
        fi_outputpro  = INPUT fi_outputpro .  
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
        FIND LAST sic_bran.uzm700 USE-INDEX uzm70001 WHERE 
            uzm700.bchyr   = nv_batchyr          AND
            uzm700.branch  = TRIM(nv_batbrn)     AND
            uzm700.acno    = TRIM(fi_producer01) NO-LOCK NO-ERROR .
        IF AVAIL sic_bran.uzm700 THEN DO:   
            nv_batrunno = uzm700.runno.
            FIND LAST sic_bran.uzm701 USE-INDEX uzm70102      WHERE
                uzm701.bchyr   = nv_batchyr          AND
                uzm701.bchno   = trim(fi_producer01) + TRIM(nv_batbrn) + string(nv_batrunno,"9999")  NO-LOCK NO-ERROR.
            IF AVAIL sic_bran.uzm701 THEN DO:
                nv_batcnt = uzm701.bchcnt .
                nv_batrunno = nv_batrunno + 1.
            END.
        END.
        ELSE DO:  
            ASSIGN
                nv_batcnt = 1
                nv_batrunno = 1.
        END.
        nv_batchno = CAPS(fi_producer01) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END.
    ELSE DO:  
        nv_batprev = INPUT fi_prevbat.
        FIND LAST sic_bran.uzm701 USE-INDEX uzm70102 
            WHERE uzm701.bchyr   = nv_batchyr       AND 
                  uzm701.bchno = CAPS(nv_batprev)   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sic_bran.uzm701 THEN DO:
            MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev)
                + " on file uzm701" .
            APPLY "entry" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
        IF AVAIL sic_bran.uzm701 THEN DO:
            nv_batcnt  = uzm701.bchcnt + 1.
            nv_batchno = CAPS(TRIM(nv_batprev)).
        END.
    END.
    ASSIGN
        fi_loaddat   = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
        fi_producer01  = INPUT fi_producer01    fi_agent        = INPUT fi_agent 
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
    For each  wdetail3 :
        DELETE  wdetail3.
    End.
    IF ra_typfile = 1 THEN RUN proc_assign.         /*A58-0198  by Text. */
    /*ELSE IF ra_typfile = 2 THEN RUN proc_assign_ex. /*A58-0198  by excel */*/ /*A68-0061*/
    ELSE RUN proc_assign_csv.
    
    FOR EACH wdetail:
        FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno : 
            
            IF WDETAIL2.POLTYP = "v70" OR WDETAIL2.POLTYP = "v72" THEN DO:
                ASSIGN
                    nv_reccnt      =  nv_reccnt   + 1
                    nv_netprm_t    =  nv_netprm_t + decimal(wdetail.prem_r)
                    wdetail2.pass  = "Y". 
            END.
            ELSE DO :  
                DELETE WDETAIL.
                DELETE WDETAIL2.
            END.
        END.
    END.  
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                           INPUT            nv_batchyr ,     /* INT   */
                           INPUT            fi_producer01,     /* CHAR  */ 
                           INPUT            nv_batbrn  ,     /* CHAR  */
                           INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                           INPUT            "WGWHCGEN" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem       /* DECI  */
                           ).
    ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.
    RUN proc_chktest1.  
    FOR EACH wdetail :
        FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno AND
                                wdetail2.pass = "y" :
                ASSIGN
                nv_completecnt = nv_completecnt + 1
                nv_netprm_s    = nv_netprm_s    + decimal(wdetail.prem_r). 
        END.
    END.
    nv_rectot = nv_reccnt.      
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
    FIND LAST sic_bran.uzm701 USE-INDEX uzm70102  
        WHERE uzm701.bchyr  = nv_batchyr AND
              uzm701.bchno  = nv_batchno AND
              uzm701.bchcnt = nv_batcnt  NO-ERROR.
    IF AVAIL sic_bran.uzm701 THEN DO:
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
    RELEASE sic_bran.uzm700.
    RELEASE sic_bran.uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.
    RELEASE sicsyac.xzm056.
    RELEASE sicsyac.xmm600.
    RELEASE sicsyac.xtm600.
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.  /*kridtiya i. A53-0220*/
    RUN   proc_open.    
    IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno      :FGCOLOR = 6. 

        ASSIGN fi_process = "Process data HCT....error !!!!" + "TimeIN:" + nv_timein + "Time Out:" + STRING(TIME,"HH:MM:SS").
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
            fi_bchno:FGCOLOR       = 2.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".

        ASSIGN fi_process = "Process data HCT...Process Complete."  + "TimeIN:" + nv_timein + "Time Out:" + STRING(TIME,"HH:MM:SS").
                DISP fi_process WITH FRAM fr_main.
    END.
    FOR EACH wdetail:
        FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno :
            ASSIGN wdetail.pass = wdetail2.pass.
        END.
    END.
DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
RUN proc_report1 .   
RUN PROC_REPORT2 .
RUN PROC_REPORT3 .   /*add A55-0151 */
RUN proc_screen  . 
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add C-Win
ON CHOOSE OF bu_add IN FRAME fr_main /* ADD */
DO:
    IF fi_proid = "" THEN DO:
        MESSAGE " IDNO. เป็นค่าว่างกรุณาตรวจสอบข้อมูลอีกครั้ง  !!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_proid .
        RETURN NO-APPLY.
    END.
    IF fi_saletype = "" THEN DO:
        MESSAGE " ประเภทการขายเป็นค่าว่างกรุณาตรวจสอบข้อมูลอีกครั้ง  !!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_saletype .
        RETURN NO-APPLY.
    END.
    IF fi_notitype = "" THEN DO:
        MESSAGE " ประเภทการแจ้งงานเป็นค่าว่างกรุณาตรวจสอบข้อมูลอีกครั้ง  !!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_notitype .
        RETURN NO-APPLY.
    END.
    IF fi_improducer = "" THEN DO:
        MESSAGE " รหัสตัวแทนเป็นค่าว่างกรุณาตรวจสอบข้อมูลอีกครั้ง  !!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_improducer.
        RETURN NO-APPLY.
    END.
    FIND LAST wimproducer WHERE wimproducer.idno  = TRIM(fi_proid) NO-LOCK NO-ERROR NO-WAIT.
    IF  AVAIL wimproducer THEN DO:
        MESSAGE "พบรหัส IDNO. " + TRIM(fi_proid)  +  "  นี้ในระบบ กรุณาตรวจสอบข้อมูลอีกครั้ง  !!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_proid .
        RETURN NO-APPLY.
    END.
    FIND LAST wimproducer WHERE 
        /*wimproducer.idno     = TRIM(fi_proid)      AND */
        wimproducer.saletype = trim(fi_saletype)   AND
        wimproducer.camname  = trim(fi_camname)    AND 
        wimproducer.notitype = trim(fi_notitype)   AND
        wimproducer.producer = trim(fi_improducer) NO-ERROR NO-WAIT.
    IF  NOT AVAIL wimproducer THEN DO:
        FIND LAST brstat.insure WHERE brstat.insure.compno  =  fi_campaign AND 
            brstat.insure.lname  = wimproducer.idno      NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.insure THEN DO:
            CREATE brstat.insure. 
            ASSIGN
                brstat.insure.compno  =  fi_campaign
                brstat.insure.lname   =   TRIM(fi_proid)        
                brstat.Insure.InsNo   =   trim(fi_saletype)     
                brstat.insure.vatcode =   trim(fi_camname)      
                brstat.insure.text4   =   trim(fi_notitype)     
                brstat.insure.Text1   =   trim(fi_improducer)   .
            CREATE wimproducer.
            ASSIGN 
                wimproducer.idno       =  TRIM(fi_proid) 
                wimproducer.saletype   =  trim(fi_saletype)   
                wimproducer.camname    =  trim(fi_camname)    
                wimproducer.notitype   =  trim(fi_notitype)   
                wimproducer.producer   =  trim(fi_improducer) 
                fi_proid         = ""
                fi_saletype      =  ""
                fi_camname       =  ""
                fi_notitype      =  ""
                fi_improducer    =  "" .
        END.
        MESSAGE "บันทึกข้อมูลรายการนี้ได้เรียบร้อยแล้ว !!!" VIEW-AS ALERT-BOX.
    END.
    ELSE DO:
        MESSAGE "พบข้อมูลรายการนี้ได้เซตไว้แล้ว !!!" VIEW-AS ALERT-BOX.
    END.
    disp fi_proid fi_saletype fi_camname fi_camname fi_notitype  fi_improducer   with frame  fr_main.
    OPEN QUERY br_producer FOR EACH wimproducer BY wimproducer.idno.
        APPLY "ENTRY" TO fi_proid .
    disp fi_proid  fi_saletype  fi_camname  fi_notitype   fi_improducer    with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_delete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_delete C-Win
ON CHOOSE OF bu_delete IN FRAME fr_main /* DEL */
DO:
    GET CURRENT br_producer EXCLUSIVE-LOCK.
    FIND LAST brstat.insure WHERE brstat.insure.compno  =  fi_campaign AND 
        brstat.insure.lname  = wimproducer.idno      NO-ERROR NO-WAIT.
    IF  AVAIL brstat.insure THEN  DELETE brstat.insure. 
    DELETE wimproducer.
    /*FIND LAST wcomp WHERE wcomp.package  = fi_packcom NO-ERROR NO-WAIT.
        IF    AVAIL wcomp THEN DELETE wcomp.
        ELSE MESSAGE "Not found Package !!! in : " fi_packcom VIEW-AS ALERT-BOX.*/

    MESSAGE "ลบข้อมูลรายการนี้ได้เรียบร้อยแล้ว !!!" VIEW-AS ALERT-BOX.
    OPEN QUERY br_producer  FOR EACH wimproducer BY wimproducer.idno.
        APPLY "ENTRY" TO fi_proid IN FRAME fr_main.
        disp  fi_proid  with frame  fr_main.
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
ON CHOOSE OF bu_file IN FRAME fr_main /* .... */
DO:
    DEFINE VARIABLE cvData     AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed  AS LOGICAL INITIAL TRUE.
    DEF VAR no_add AS CHAR FORMAT "x(8)" .    /*08/11/2006*/

    IF ra_typfile = 1  THEN DO:   /* Text */
        SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Files (*.txt)" "*.txt",
                   "CSV (Comma Delimited)"   "*.csv"
                          /*  "Data Files (*.dat)"     "*.dat",*/
                    /*"Text Files (*.txt)" "*.txt"*/             /*A58-0198*/
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    END.
    ELSE IF ra_typfile = 2 THEN DO:   /* csv */
        SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "CSV (Comma Delimited)"   "*.csv",
                   "Text Files (*.txt)" "*.txt"
                          /*  "Data Files (*.dat)"     "*.dat",*/
                    /*"Text Files (*.txt)" "*.txt"*/             /*A58-0198*/
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    END.
    /* A68-0061 */
    ELSE DO:
        SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "CSV (Comma Delimited)"   "*.csv"
                          /*  "Data Files (*.dat)"     "*.dat",*/
                    /*"Text Files (*.txt)" "*.txt"*/             /*A58-0198*/
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    END.
    /* end : A68-0061 */  
    IF OKpressed = TRUE THEN DO:
         /***--- 08/11/2006 ---***/
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

         /***---a490166 ---***/
         ASSIGN
            fi_filename  = cvData
            fi_output1   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw"   /*.csv*/
            fi_output2   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
            fi_output3   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce"   /*txt*/
            fi_outputpro = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".slk" .  /*.csv*//*A55-0151*/


         DISP fi_filename fi_output1 fi_output2 fi_output3 fi_outputpro  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.

    

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


&Scoped-define SELF-NAME bu_hpagent-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent-2 C-Win
ON CHOOSE OF bu_hpagent-2 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,   /*a490166 note modi*/
                    output  n_agent). 
                                          
     If  n_acno  <>  ""  Then  fi_producer01 =  n_acno.
     
     disp  fi_producer01  with frame  fr_main.

     Apply "Entry"  to  fi_producer01.
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
   Apply "Entry"  To  fi_producer01.
   Return no-apply.                            
                                        

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    ASSIGN 
        /*fi_agent = "B3m0016". */ /*A63-0443*/
        fi_agent = "B3M0059".    /*A63-0443*/
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
            /*fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)*/ /*A62-0215*/
            fi_agent   =  caps(INPUT  fi_agent) /*note modi 08/11/05*/
            nv_agent   =  fi_agent.             /*note add  08/11/05*/
            
        END. /*end note 10/11/2005*/
    END. /*Then fi_agent <> ""*/
    
    Disp  fi_agent WITH Frame  fr_main.                 
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


&Scoped-define SELF-NAME fi_camname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camname C-Win
ON LEAVE OF fi_camname IN FRAME fr_main
DO:
    fi_camname  = CAPS(Input  fi_camname ) .
    Disp  fi_camname  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaign C-Win
ON LEAVE OF fi_campaign IN FRAME fr_main
DO:
    fi_campaign  = CAPS(Input  fi_campaign ) .
    Disp  fi_campaign  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Campaign23
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Campaign23 C-Win
ON LEAVE OF fi_Campaign23 IN FRAME fr_main
DO:
    fi_Campaign23  = CAPS(Input  fi_Campaign23 ) .
    Disp  fi_Campaign23  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp_SP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp_SP C-Win
ON LEAVE OF fi_camp_SP IN FRAME fr_main
DO:
    fi_camp_sp  = CAPS(Input  fi_camp_sp ) .
    Disp  fi_camp_sp  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp_tp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp_tp C-Win
ON LEAVE OF fi_camp_tp IN FRAME fr_main
DO:
    fi_camp_tp  = CAPS(Input  fi_camp_tp ) .
    Disp  fi_camp_tp  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_improducer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_improducer C-Win
ON LEAVE OF fi_improducer IN FRAME fr_main
DO:
  fi_improducer  = CAPS(Input  fi_improducer ) .
  Disp  fi_improducer  with  frame  fr_main.
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


&Scoped-define SELF-NAME fi_notitype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notitype C-Win
ON LEAVE OF fi_notitype IN FRAME fr_main
DO:
  fi_notitype  = CAPS(Input  fi_notitype ) .
  Disp  fi_notitype  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_no_mn30
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_no_mn30 C-Win
ON LEAVE OF fi_no_mn30 IN FRAME fr_main
DO:
    fi_no_mn30 = INPUT fi_no_mn30 . 
    DISPLAY fi_no_mn30 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_packcov3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_packcov3 C-Win
ON LEAVE OF fi_packcov3 IN FRAME fr_main
DO:
    fi_packcov3  =  Input  fi_packcov3.
    Disp  fi_packcov3  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_packgarage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_packgarage C-Win
ON LEAVE OF fi_packgarage IN FRAME fr_main
DO:
    fi_packgarage  =  Input  fi_packgarage.
    Disp  fi_packgarage  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_packnogar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_packnogar C-Win
ON LEAVE OF fi_packnogar IN FRAME fr_main
DO:
    fi_packnogar  =  Input  fi_packnogar.
    Disp  fi_packnogar  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_packpuls
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_packpuls C-Win
ON LEAVE OF fi_packpuls IN FRAME fr_main
DO:
    fi_packpuls  =  Input  fi_packpuls .
    Disp  fi_packpuls  with  frame  fr_main.
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


&Scoped-define SELF-NAME fi_producer01
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer01 C-Win
ON LEAVE OF fi_producer01 IN FRAME fr_main
DO:
    fi_producer01 = INPUT fi_producer01.
    ASSIGN /*fi_producer01 = "B3m0016".*/ /*A63-0443*/
        fi_producer01 = "B3M0059". /*A63-0443*/
    fi_producer01 = INPUT fi_producer01.
    IF fi_producer01 <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_producer01  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_producer01.
            RETURN NO-APPLY. /*note add on 10/11/2005*/
            END.
            ELSE DO: /*note modi on 10/11/2005*/
                ASSIGN
                    /*fi_producername =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)*/ /*A62-0215*/
                    fi_producer01   =  caps(INPUT  fi_producer01) /*note modi 08/11/05*/
                    nv_agent        =  fi_producer01.             /*note add  08/11/05*/
            
        END. /*end note 10/11/2005*/
    END. /*Then fi_producer01 <> ""*/
    
    Disp  fi_producer01  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerinst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerinst C-Win
ON LEAVE OF fi_producerinst IN FRAME fr_main
DO:
    fi_producerinst = INPUT fi_producerinst .
    
    Disp  fi_producerinst    WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_proid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_proid C-Win
ON LEAVE OF fi_proid IN FRAME fr_main
DO:
    fi_proid  = CAPS(Input  fi_proid ) .
    Disp  fi_proid  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_redyear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_redyear C-Win
ON LEAVE OF fi_redyear IN FRAME fr_main
DO:
    fi_redyear = INPUT fi_redyear.
    DISP fi_redyear   WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_saletype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_saletype C-Win
ON LEAVE OF fi_saletype IN FRAME fr_main
DO:
    fi_saletype  = CAPS(Input  fi_saletype ) .
    Disp  fi_saletype  with  frame  fr_main.
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


&Scoped-define SELF-NAME ra_typfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typfile C-Win
ON VALUE-CHANGED OF ra_typfile IN FRAME fr_main
DO:
    ra_typfile = INPUT ra_typfile .
    DISP ra_typfile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tg_flag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tg_flag C-Win
ON VALUE-CHANGED OF tg_flag IN FRAME fr_main
DO:
    tg_flag = INPUT tg_flag .
    DISP tg_flag WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tg_flagRN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tg_flagRN C-Win
ON VALUE-CHANGED OF tg_flagRN IN FRAME fr_main
DO:
    tg_flagRN = INPUT tg_flagRN .
    DISP tg_flagRN WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_producer
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

ASSIGN 
    fi_campaign = "CAM_HCT"
    gv_prgid    = "Wgwhcgen"
    gv_prog     = "Load Text & Generate HCT"
    fi_loaddat  = TODAY.
DISP fi_loaddat fi_campaign  WITH FRAME fr_main.
RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).  /*28/11/2006*/
ASSIGN
    /*fi_packgarage  = "H"*/ /*A63-0443*/
    /*fi_packnogar   = "G"*/ /*A63-0443*/
    /*fi_packcov3    = "P"*/ /*A63-0443*/
    fi_packgarage  = "T" /*A63-0443*/
    fi_packnogar   = "T" /*A63-0443*/
    fi_packcov3    = "T" /*A63-0443*/
    fi_branch      = "M"
    /*fi_packpuls    = "C"           /*a57-0126*/*/ /*Comment by Sarinya c A62-0215*/
    /*fi_packpuls    = "H"           /*Add by Sarinya c A62-0215*/*/ /*A63-0443*/
    fi_packpuls    = "T" /*A63-0443*/
    fi_campaign    = "CAM_HCT"
    fi_camp_sp     = "H61_00000"  /*A61-0324 */
    /*fi_Campaign23  = "C62/00002" */ /*A62-0215 */ /*A63-0443*/
    fi_Campaign23  = "HEI-PLUS"  /*A62-0215 */ /*A63-0443 ป.2+ 3+ */
    fi_camp_tp     = "TRIPLE PACK" /*a62-0493*/
    /*fi_brio        = "CITY 18,990"     /*A57-0126*/
    fi_camplus     = "Plus"              /*A57-0126*/
    fi_producer04  = "B3M0022"         /*A57-0126*/
    fi_producer01  = "B3M0016"         /*A57-0126*/
    fi_producer02  = "B3M0019"  /*A55-0043*//*A57-0126*/
    fi_producer03  = "B3M0017"  /*A55-0151*/*//*A57-0126*/
   /* fi_producer01  = "B3M0017"   */ /*A63-0443 */
   /* fi_agent        = "B300125"  */ /*A63-0443 */
    fi_producer01   = "B3M0064"  /*A63-0443 */
    fi_agent        = "B3M0058"  /*A63-0443 */
    fi_producerinst = "MC34019"
    fi_bchyr       = YEAR(TODAY)
    fi_redyear     = YEAR(TODAY)
    fi_no_mn30     = "PTN,YLH,NRT"       /*A57-0282 NO-MN30 คุ้มครองภัยก่อการร้าย*/
    /*ra_typfile     = 1 */  /*A68-0061*/
    ra_typfile     = 2       /*A68-0061*/
    tg_flag        = YES
    tg_flagRN      = NO
    fi_process     = "Load Text file HCT..." .
RUN proc_createpro.
OPEN QUERY br_producer FOR EACH wimproducer  BY wimproducer.idno.
    DISP fi_branch     fi_producer01  /*fi_producer02*/  fi_campaign  fi_redyear  fi_packpuls /*fi_camplus fi_producer04 fi_brio*/
         fi_packgarage  fi_packnogar  fi_packcov3  /*fi_producer03*/  fi_agent fi_bchyr fi_process
         ra_typfile  fi_producerinst   /* A58-0198 */ fi_camp_sp /*A61-0324*/ fi_Campaign23 /*A62-0215*/
         fi_no_mn30  fi_camp_tp /*A62-0493*/ tg_flag tg_flagRN /*A68-0061*/ WITH FRAME fr_main.
/*********************************************************************/  
    RUN  WUT\WUTWICEN (c-win:handle).  
    Session:data-Entry-Return = Yes.
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_72 C-Win 
PROCEDURE 00-proc_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by : A68-0061..
DEF VAR nsubclass AS CHAR INIT "".
DEF VAR b_eng     AS DECI INIT "".
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "006: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
ASSIGN wdetail2.tariff = "9"
    nsubclass = wdetail2.subclass.  /*Modify by   : Kridtiya i. */
    /*wdetail2.subclass = "110"*/ /*comment by Kridtiya i. */
    fi_process = "Process data HCT....compulsary "  .
IF      wdetail2.subclass = "110" THEN wdetail2.subclass = "110".  /*Add by Kridtiya i. */
ELSE IF wdetail2.subclass = "120" THEN wdetail2.subclass = "110".  /*Add by Sarinya  C A62-0215*/
ELSE IF wdetail2.subclass = "210" THEN wdetail2.subclass = "120A". /*Add by Kridtiya i. */
ELSE IF wdetail2.subclass = "220" THEN wdetail2.subclass = "120A". /*Add by Kridtiya i. */
ELSE IF wdetail2.subclass = "320" THEN wdetail2.subclass = "140A". /*Add by Kridtiya i. */
ELSE IF wdetail2.subclass = "120E" THEN wdetail2.subclass = "210E". /*A67-0065 */
ELSE IF wdetail2.subclass = "E11"  THEN wdetail2.subclass = "E11PA".  /*A67-0065 */
ELSE IF wdetail2.subclass = "E12"  THEN wdetail2.subclass = "E12CA".  /*A67-0065 */

DISP fi_process WITH FRAM fr_main.
IF wdetail2.poltyp = "v72" THEN DO:
  IF wdetail.compul <> "y" THEN 
    ASSIGN wdetail2.comment = wdetail2.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y"  
    wdetail2.pass    = "N"
    WDETAIL2.OK_GEN  = "N". 
END.
IF wdetail.compul = "y" THEN DO:
  IF wdetail.stk <> "" THEN DO:    
    IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
    IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
      ASSIGN  wdetail2.comment = wdetail2.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"   
        wdetail2.pass    = ""
        WDETAIL2.OK_GEN  = "N".
  END.
END.
/*---------- class --------------*/
IF wdetail2.n_branch = ""  THEN  
  ASSIGN  wdetail2.pass = "N"  
  wdetail2.comment = wdetail2.comment + "| พบสาขาเป็นค่าว่างหรือไม่พบรหัสดีเลอร์" + n_textfi    
  WDETAIL2.OK_GEN  = "N".
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail2.subclass
    NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| ไม่พบ Class นี้ในระบบ"        
        wdetail2.pass    = "N"
        WDETAIL2.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail2.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail2.poltyp  AND
        sicsyac.xmd031.class  = wdetail2.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN wdetail2.pass    = "N"
            wdetail2.comment = wdetail2.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"     
            WDETAIL2.OK_GEN  = "N".
END. 
/*---------- covcod ----------*/
wdetail.covcod = CAPS(wdetail.covcod).
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN wdetail2.pass    = "N"
        wdetail2.comment = wdetail2.comment + "| ไม่พบ Cover Type นี้ในระบบ"       
        WDETAIL2.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail2.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = "110" AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN wdetail2.pass    = "N"  
        wdetail2.comment = wdetail2.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"        
        WDETAIL2.OK_GEN = "N".
/*--------- modcod --------------*/
chkred = NO.
/*IF wdetail2.redbook <> "" THEN DO:    /*กรณีที่มีการระบุ Code รถมา*/
    FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
        sicsyac.xmm102.modcod = wdetail2.redbook NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm102 THEN DO:
        ASSIGN  
            wdetail2.pass    = "N"  
            wdetail2.comment = wdetail2.comment + "| not find on table xmm102 ไม่พบ Makes/Models นี้ในระบบ"
            WDETAIL2.OK_GEN = "N"
            chkred = NO
            wdetail2.redbook = " ".
    END. 
    ELSE DO:
        chkred = YES.
    END.
END.  
IF chkred = NO  THEN DO:
    FIND LAST sicsyac.xmm102 WHERE 
        sicsyac.xmm102.modest = wdetail.brand + wdetail.model AND
        sicsyac.xmm102.engine = INTE(wdetail.engcc)           AND 
        sicsyac.xmm102.tons   = INTE(wdetail2.weight)         AND
        sicsyac.xmm102.seats  = INTE(wdetail.seat)
        NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm102  THEN DO:
      /*  MESSAGE "not find on table xmm102".
        ASSIGN /*a490166*/     
            wdetail2.pass    = "N"  
            wdetail2.comment = wdetail2.comment + "| not find on table xmm102"
            WDETAIL2.OK_GEN  = "N".     A52-0172*/
    END.
    ELSE DO:
            wdetail2.redbook = sicsyac.xmm102.modcod. 
    END.
END.*/
FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  wdetail2.prempa + wdetail2.subclass NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN n_ratmin = makdes31.si_theft_p   
           n_ratmax = makdes31.load_p   .    
ELSE ASSIGN n_ratmin = 0
     n_ratmax        = 0 .
IF DECI(wdetail.engcc) > 501 THEN DO:
   ASSIGN
     b_eng           = 0
     b_eng           = round((DECI(wdetail.engcc) / 1000),1).     /*format engcc */
     b_eng           = b_eng * 1000.
END.
ELSE b_eng           =  DECI(wdetail.engcc).
 /*create by : A60-0505*/
/*IF INDEX(wdetail.model,"CIVIC") <> 0 THEN DO:*//*A63-00472*/
IF (INDEX(wdetail.model,"CIVIC") <> 0 ) OR (INDEX(wdetail.model,"CITY") <> 0 ) THEN DO:  /*A63-00472*/
    IF INDEX(wdetail.carcode,"HATCHBACK") <> 0 THEN DO:
       Find First stat.maktab_fil USE-INDEX maktab04    Where
         stat.maktab_fil.makdes   =     wdetail.brand            And                  
         index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
         stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
         stat.maktab_fil.engine   =     b_eng /*Integer(wdetail.engcc)*/   AND
         /*stat.maktab_fil.sclass   =     wdetail2.subclass        AND  nsubclass*/
         stat.maktab_fil.sclass   =     nsubclass       AND  
        (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
         stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
         stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  AND
         stat.maktab_fil.body     = "HATCHBACK"     No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN  wdetail2.redbook       =  stat.maktab_fil.modcod .
        ELSE wdetail2.redbook       = "".
           
    END.
    ELSE DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
         stat.maktab_fil.makdes   =     wdetail.brand            And                  
         index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
         stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
         stat.maktab_fil.engine   =     b_eng /*Integer(wdetail.engcc)*/   AND
         /*stat.maktab_fil.sclass   =     wdetail2.subclass        AND*/
         stat.maktab_fil.sclass   =     nsubclass       AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
         stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
         stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  AND
         stat.maktab_fil.body     = "SEDAN"     No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN wdetail2.redbook     =  stat.maktab_fil.modcod.
        ELSE wdetail2.redbook = "".
            
    END.
END.
ELSE DO:
/* end A60-0505*/
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
        stat.maktab_fil.engine   =   b_eng   /*Integer(wdetail.engcc)*/   AND
        /*stat.maktab_fil.sclass   =     wdetail2.subclass        AND*/
        stat.maktab_fil.sclass   =    nsubclass        AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
        stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN wdetail2.redbook = stat.maktab_fil.modcod.
    ELSE wdetail2.redbook = "".
END.
         /*A63-00472*/
    IF wdetail2.redbook = "" THEN DO:
        IF nsubclass = "210E" THEN nsubclass = "E12".
        else IF nsubclass = "E11PA" THEN nsubclass = "E11".
        else IF nsubclass = "E12CA" THEN nsubclass = "E12".
        IF SUBSTR(nsubclass,1,1) = "E"    THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                /*stat.maktab_fil.engine   =   b_eng  /*Integer(wdetail.engcc)*/   AND*/
                /*stat.maktab_fil.sclass =     wdetail2.subclass       */ 
                stat.maktab_fil.sclass   =     nsubclass                                          /*AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
                stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  */ 
                No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN ASSIGN wdetail2.redbook = stat.maktab_fil.modcod.
            ELSE wdetail2.redbook = "".
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =   b_eng  /*Integer(wdetail.engcc)*/   AND
                /*stat.maktab_fil.sclass =     wdetail2.subclass       */ 
                stat.maktab_fil.sclass   =     nsubclass                                          /*AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
                stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  */ 
                No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN ASSIGN wdetail2.redbook = stat.maktab_fil.modcod.
            ELSE wdetail2.redbook = "".
        END.
    END.  /*A63-00472*/
OUTPUT TO D:\temp\LogTimeHCT_redbook.TXT APPEND.
PUT "Proc_72: " wdetail2.redbook "-"  wdetail.brand "-" wdetail.model "-" wdetail.caryear "-" b_eng "-" nsubclass   SKIP.
OUTPUT CLOSE.

/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN     
        wdetail2.pass    = "N"  
        wdetail2.comment = wdetail2.comment + "| ไม่พบ Veh.Usage ในระบบ "
        WDETAIL2.OK_GEN  = "N".
ASSIGN
    nv_docno  = " "
    nv_accdat = TODAY.
/***--- Docno ---***/
IF wdetail2.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M" AND
        sicuw.uwm100.docno1 = STRING(wdetail2.docno,"9999999")
        NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN 
        
        ASSIGN /*a490166*/     
            wdetail2.pass    = "N"  
            wdetail2.comment = "Receipt is Dup. on uwm100 :" + string(sicuw.uwm100.policy,"x(16)") +
            STRING(sicuw.uwm100.rencnt,"99")  + "/" +
            STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
            WDETAIL2.OK_GEN  = "N".
    ELSE 
        nv_docno = wdetail2.docno.
END.
/***--- Account Date ---***/
IF wdetail2.accdat <> " "  THEN nv_accdat = date(wdetail2.accdat).
ELSE nv_accdat = TODAY.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_address C-Win 
PROCEDURE 00-proc_address :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by : A68-0061...
IF wdetail.road <> "" THEN 
    ASSIGN 
    wdetail.road = "ถนน" + trim(wdetail.road)
    wdetail.addr = trim(wdetail.addr) + " " + wdetail.road.

IF (index(wdetail.country,"กรุงเทพ") <> 0) OR (index(wdetail.country,"กทม") <> 0) THEN 
    ASSIGN   
    wdetail.tambon = "แขวง" + wdetail.tambon
    wdetail.amper  = "เขต" + wdetail.amper .
ELSE  
    ASSIGN  
        wdetail.tambon  = "ตำบล" + wdetail.tambon   
        wdetail.amper   = "อำเภอ" + wdetail.amper 
        wdetail.country = "จังหวัด" + wdetail.country . 
/*addr 1 */
IF LENGTH(wdetail.addr) > 35 THEN DO:
    loop_add01:
    DO WHILE LENGTH(wdetail.addr) > 35 :
        IF R-INDEX(wdetail.addr," ") <> 0 THEN DO:
            ASSIGN 
                wdetail.tambon  = trim(SUBSTR(wdetail.addr,r-INDEX(wdetail.addr," "))) + " " + wdetail.tambon
                wdetail.addr    = trim(SUBSTR(wdetail.addr,1,r-INDEX(wdetail.addr," "))).
        END.
        ELSE LEAVE loop_add01.
    END.
    /*wdetail.tambon*/
    IF LENGTH(wdetail.tambon) > 35 THEN DO:
        loop_add02:
        DO WHILE LENGTH(wdetail.tambon) > 35 :
            IF R-INDEX(wdetail.tambon," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.amper    = trim(SUBSTR(wdetail.tambon,r-INDEX(wdetail.tambon," "))) + " " + wdetail.amper
                    wdetail.tambon   = trim(SUBSTR(wdetail.tambon,1,r-INDEX(wdetail.tambon," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
    END.
    /*wdetail.amper*/
    IF LENGTH(wdetail.amper) > 35 THEN DO:
        loop_add03:
        DO WHILE LENGTH(wdetail.amper) > 35 :
            IF R-INDEX(wdetail.amper," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.country = trim(SUBSTR(wdetail.amper,r-INDEX(wdetail.amper," "))) + " " + wdetail.country
                    wdetail.amper   = trim(SUBSTR(wdetail.amper,1,r-INDEX(wdetail.amper," "))).
            END.
            ELSE LEAVE loop_add03.
        END.
    END.
END.
ELSE DO:
    /*wdetail.tambon*/
    IF LENGTH(wdetail.tambon + " " + wdetail.amper ) <= 35 THEN  
        ASSIGN 
        wdetail.tambon   = wdetail.tambon + " " + wdetail.amper 
        wdetail.amper    = wdetail.country
        wdetail.country  = "" .
    ELSE IF LENGTH(wdetail.amper + " " + wdetail.country) <= 35 THEN  
        ASSIGN 
        wdetail.amper    = wdetail.amper + " " + wdetail.country
        wdetail.country  = "" .
END.
..end A68-0061..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assign2 C-Win 
PROCEDURE 00-proc_assign2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : Ranu I. A67-0065...
DEF VAR  name2    AS CHAR FORMAT "x(60)" INIT "" .  /*ranu*/
DEF VAR  name3    AS CHAR FORMAT "x(60)" INIT "" .  /*ranu*/
DEF VAR  delname  AS CHAR FORMAT "x(60)" INIT "" .  /*ranu*/
DEF VAR  b_eng    AS DECI FORMAT  ">>>>9.99-".
DEF VAR  n_date   AS CHAR FORMAT  "x(10)".
FOR EACH wdetail WHERE wdetail.policyno NE " "  .
    FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno . 
        FOR EACH wdetail3 WHERE wdetail3.policyno = wdetail.policyno . 
        ASSIGN n_firstdat = ?   /*A53-0220....*/
        n_producer       = ""   
        n_textfi         = ""    /*A540125*/
        n_date           = STRING(TODAY,"99/99/9999")
        b_eng            = round((DECI(wdetail.engcc) / 1000),1)     /*format engcc */
        b_eng            = b_eng * 1000
        wdetail.seat     = IF INTEGER(wdetail.seat) = 0 THEN  "7" ELSE wdetail.seat
        wdetail2.tariff  = IF wdetail2.poltyp = "v72" THEN "9" ELSE "x" 
        wdetail2.prempa  = IF      wdetail.covcod = "5" THEN fi_packpuls   /*A57-0126 add covcod 2.1,3.1 */
                           ELSE IF wdetail.covcod = "9" THEN fi_packpuls   /*A57-0126 add covcod 2.1,3.1 */
                           ELSE IF (wdetail.garage = "GARAGE") AND (wdetail.covcod = "1")  THEN fi_packnogar
                           ELSE IF (wdetail.garage = "honda")  AND (wdetail.covcod = "1")  THEN fi_packgarage
                           ELSE IF (wdetail.covcod = "3")      THEN fi_packcov3
                           ELSE fi_packgarage
        wdetail.garage   = IF       (wdetail.covcod = "5") AND (wdetail.garage = "honda") AND (wdetail2.poltyp = "v70") THEN "G" 
                           ELSE IF  (wdetail.covcod = "9") AND (wdetail.garage = "honda") AND (wdetail2.poltyp = "v70") THEN "G" 
                           ELSE IF (wdetail.garage = "honda") AND (wdetail2.poltyp = "v70") THEN "G" ELSE " "  /*A57-0176*/ 
        wdetail.country  = wdetail.country                          /*Add by Kridtiya i. A63-0472*/
        wdetail.covcod   = IF      wdetail.covcod = "0" THEN "T" 
                           ELSE IF wdetail.covcod = "T" THEN "T" 
                           ELSE IF wdetail.covcod = "5" THEN "2.1"         /*1,2,3 (เพิ่ม 5=2+ , 9=3+)*/
                           ELSE IF wdetail.covcod = "9" THEN "3.1"         /*1,2,3 (เพิ่ม 5=2+ , 9=3+)*/
                           ELSE    wdetail.covcod .

        /*Add by Sarinya C A62/0215*/  
        IF wdetail.covcod = "2.1" THEN wdetail.covcod =  "2.2" .             /*Add by Sarinya C A62/0215*/     
        ELSE IF wdetail.covcod = "3.1" THEN wdetail.covcod =  "3.2" .        /*Add by Sarinya C A62/0215*/ 
        IF wdetail.covcod = "T" OR wdetail.covcod = "0" THEN DO:
            IF wdetail2.producer = "" THEN RUN proc_assign3.
        END.
        ELSE DO:  /* V70 */
            
        /* creat by : A61-0324 */
        IF index(wdetail2.detailcam,"super pack") <> 0 THEN DO:
            FIND FIRST wimproducer WHERE 
                  wimproducer.saletype = TRIM(wdetail.saletyp)        AND 
             TRIM(wimproducer.camname) = TRIM(wdetail2.detailcam)     AND  /*Add by Sarinya C A62/0215*/ 
                  wimproducer.notitype = TRIM(wdetail2.TYPE_notify)   NO-LOCK NO-ERROR NO-WAIT. 
              IF AVAIL  wimproducer THEN  
                  ASSIGN  wdetail2.producer   = wimproducer.producer   
                          wdetail2.producer2  = wimproducer.producer.
        END. /* end A61-0324 */
        ELSE IF index(wdetail2.detailcam,"TMSTH 0%") <> 0 OR index(wdetail2.detailcam,"TMSTH0%") <> 0 OR index(wdetail2.detailcam,"DEMON_H") <> 0 THEN  RUN proc_assign4.
        ELSE IF wdetail.saletyp = "C" THEN DO:
           /*Add by Sarinya C A62/0215*/ 
            IF wdetail.covcod = "1"  AND wdetail2.TYPE_notify = "S" THEN DO:
                IF wdetail.garage = "" AND 
                    (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 2 ) AND (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 10 ) THEN DO:
                    ASSIGN wdetail2.producer = "B3M0062". /*A63-0443*/
                END.
                ELSE ASSIGN wdetail2.producer = "B3M0065".  /*A63-0443*/
               
            END.
            /*End Add by Sarinya C A62/0215*/ 
            ELSE IF wdetail.covcod <> "1" AND (wdetail2.TYPE_notify = "S" OR 
                                               wdetail2.TYPE_notify = "R" OR wdetail2.TYPE_notify = "N") THEN DO:  
                ASSIGN wdetail2.producer = "B3M0062".  /*A63-0443*/
                
            END.
            ELSE DO:  
                /*--end : A59-0118--*/
                /*A57-0073*/
                FIND FIRST wimproducer WHERE 
                    wimproducer.saletype = TRIM(wdetail.saletyp)        AND
                    /*index(wdetail2.detailcam,wimproducer.camname) <> 0  AND*/ /*Comment by Sarinya C A62/0215*/ 
               TRIM(wimproducer.camname) = TRIM(wdetail2.detailcam)     AND  /*Add by Sarinya C A62/0215*/ 
                    wimproducer.notitype = TRIM(wdetail2.TYPE_notify)   NO-LOCK NO-ERROR NO-WAIT. 
                IF AVAIL  wimproducer THEN  
                    ASSIGN  wdetail2.producer   = wimproducer.producer   
                            wdetail2.producer2  = wimproducer.producer.
                ELSE ASSIGN wdetail2.producer   =  fi_producer01.
            END.
           /*A57-0073*/
        END.
        ELSE IF wdetail.saletyp = "H" THEN   ASSIGN wdetail2.producer = "B3M0063".  
        ELSE DO:    /*wdetail.saletyp = "N"*/
            /*Add by Sarinya C A62/0215*/ 
           IF wdetail.covcod = "1"  AND wdetail2.TYPE_notify = "S" THEN DO:
               IF wdetail.garage = "" AND 
                   (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 2 ) AND (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 10 ) THEN DO:
                   ASSIGN wdetail2.producer = "B3M0062". /*A63-0443*/
               END.
               ELSE ASSIGN wdetail2.producer = "B3M0065".  /*A63-0443*/ 
           END. /*End Add by Sarinya C A62/0215*/ 
           ELSE IF wdetail.covcod <> "1" AND (wdetail2.TYPE_notify = "S" OR 
                   wdetail2.TYPE_notify = "R" OR wdetail2.TYPE_notify = "N") THEN DO:  
                   ASSIGN wdetail2.producer = "B3M0062".  /*A63-0443*/
           END.
           ELSE DO: 
           /*--end : A59-0118--*/
           /*A57-0073*/
             FIND FIRST wimproducer WHERE 
                  wimproducer.saletype = TRIM(wdetail.saletyp)        AND 
             TRIM(wimproducer.camname) = TRIM(wdetail2.detailcam)     AND  /*Add by Sarinya C A62/0215*/ 
                  wimproducer.notitype = TRIM(wdetail2.TYPE_notify)   NO-LOCK NO-ERROR NO-WAIT. 
              IF AVAIL  wimproducer THEN  
                  ASSIGN  wdetail2.producer   = wimproducer.producer   
                          wdetail2.producer2  = wimproducer.producer.
              ELSE ASSIGN wdetail2.producer   =  fi_producer01.
           END.
           ASSIGN wdetail2.ins_pay   = trim(wdetail2.n_month + wdetail2.n_bank) .
           /*A57-0073*/
        END. 
        END. /* V70 */
        IF wdetail2.producer = ""  THEN wdetail2.producer = trim(fi_producer01).


        IF wdetail.caryear = "" THEN wdetail.caryear =  string(YEAR(TODAY),"9999").
        IF wdetail.prepol <> "" THEN RUN proc_cutchar.
        /*Add by Kridtiya i. A63-0472*/
        RUN proc_assign2addr (INPUT  wdetail.tambon               
                             ,INPUT  wdetail.amper                
                             ,INPUT  wdetail.country              
                             ,INPUT  wdetail.occup                
                             ,OUTPUT wdetail3.codeocc             
                             ,OUTPUT wdetail3.codeaddr1           
                             ,OUTPUT wdetail3.codeaddr2           
                             ,OUTPUT wdetail3.codeaddr3). 
        RUN proc_matchtypins (INPUT  wdetail.tiname                      
                             ,INPUT  TRIM(wdetail.insnam + " " + wdetail.name3)
                             ,OUTPUT wdetail3.insnamtyp
                             ,OUTPUT wdetail3.firstName 
                             ,OUTPUT wdetail3.lastName).
        ASSIGN 
            wdetail3.br_insured  = "00000"      
            wdetail3.campaign_ov = "".         
        /*Add by Kridtiya i. A63-0472*/

        RUN proc_address.
        IF wdetail.vehreg = "" THEN 
            ASSIGN wdetail.vehreg   = "/" + SUBSTRING(wdetail.chasno,9,LENGTH(wdetail.chasno)) .  /* ทะเบียนรถมาMRHCP16309P302579 */ /*A63-0443 08/10/20*/
        ELSE IF substr(wdetail.vehreg,9,2) = "" THEN RUN proc_assign_vehrenew.   /*  kridtiya i. A53-0220  22/07/2010 */
        
        /*add kridtiya i. A53-0027...............*/
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "HCT" AND
                stat.insure.lname  = wdetail2.comrequest   NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN DO: 
                ASSIGN 
                    wdetail3.name3        = TRIM(stat.insure.fname)    /* A58-0198 */
                    wdetail2.n_branch     = trim(stat.insure.branch)   
                    wdetail2.n_delercode  = trim(stat.insure.insno)    
                    wdetail3.financecd    = trim(stat.Insure.Text3)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                    wdetail2.typrequest   = trim(stat.insure.vatcode)  /*เปลี่ยน เป็นเก็บค่า vatcode.*/
                    n_textfi              = TRIM(stat.insure.addr3) .  /*A540125*/ 
                IF wdetail2.voictitle = "1" THEN wdetail2.typrequest  = "".
            END.
            ELSE 
                ASSIGN
                    wdetail2.n_branch    = ""
                    wdetail2.n_delercode = "" 
                    wdetail2.typrequest  = "" 
                    wdetail3.name3       = ""
                    wdetail3.financecd   = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                    n_textfi             = "" .  /*A540125*/ 
            IF  wdetail2.poltyp = "V70" THEN DO:
                IF  wdetail3.instot > 1  THEN DO:
                    /* add by A64-0422 : 05/10/2021 */
                    IF INDEX(wdetail2.detailcam,"HATC CAMPAIGN") <> 0 THEN DO:            /* Ranu I. A64-0422 05/10/2021*/
                        ASSIGN wdetail2.name4      = "และ/หรือ บริษัท ฮอนด้า ออโตโมบิล (ประเทศไทย) จำกัด" 
                               wdetail3.companyre1 = CAPS(trim(fi_producerinst)) + " " +  trim(wdetail3.companyre1). 
                    END.
                    ELSE IF INDEX(wdetail2.detailcam,"HLTC CAMPAIGN") <> 0 THEN DO:
                        ASSIGN wdetail2.name4      = "และ/หรือ บริษัท ฮอนด้า ลีสซิ่ง (ประเทศไทย) จำกัด"
                               wdetail3.companyre1 = "MC34018" + " " +  trim(wdetail3.companyre1).
                    END.
                    /* end : A64-0422 05/10/2021 */
                    /*2 3 INSTALMENTS */
                    IF wdetail3.name3 <> "" THEN DO:
                        ASSIGN name2   = trim(REPLACE(wdetail3.companyre2," ",""))
                               name3   = trim(REPLACE(wdetail3.companyre3," ",""))
                               delname = TRIM(REPLACE(wdetail3.name3," ","")).  
                        
                        IF wdetail3.companyre2 <> "" THEN DO:
                            /*IF index(trim(wdetail3.companyre2),wdetail3.name3) <> 0 THEN*/ /* ranu */
                            IF  index(name2,delname) <> 0 THEN /* ranu */
                                ASSIGN 
                                wdetail3.name3       = "และ/หรือ " + trim(wdetail3.name3)
                                wdetail3.companyre2  = caps(trim(wdetail2.typrequest)) + " " + trim(wdetail3.companyre2).
                        END.
                        ELSE IF wdetail3.companyre3 <> "" THEN DO:
                            /*IF index(trim(wdetail3.companyre3),wdetail3.name3) <> 0 THEN  */ /* ranu */
                            IF  index(name3,delname) <> 0 THEN /* ranu */
                                ASSIGN 
                                wdetail3.name3       = "และ/หรือ " + trim(wdetail3.name3)
                                wdetail3.companyre3  = caps(trim(wdetail2.typrequest)) + " " + trim(wdetail3.companyre3).
                        END.
                        ELSE wdetail3.name3 = "".
                    END.
                END.
                ELSE wdetail3.name3 = "".
            END.
            ELSE wdetail3.name3 = "".
        /* add A540125*/ 
        IF (n_textfi <> "") AND (INDEX(n_textfi,"fi") <> 0) THEN DO:
            n_textfi   = wdetail2.comrequest + "/" + wdetail2.comcar  .
            FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "HCT" AND
                stat.insure.lname  = wdetail2.comcar   NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN DO: 
                ASSIGN wdetail2.n_branch  = trim(stat.insure.branch)
                    wdetail2.n_delercode  = trim(stat.insure.insno) 
                    wdetail3.financecd    = trim(stat.Insure.Text3)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                    wdetail2.typrequest   = trim(stat.insure.vatcode) .  /*เปลี่ยน เป็นเก็บค่า vatcode.*/
                IF wdetail2.voictitle = "1" THEN wdetail2.typrequest  = "".
            END.
            ELSE 
                ASSIGN
                    wdetail2.n_branch    = ""
                    wdetail2.n_delercode = "" 
                    wdetail3.financecd   = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                    wdetail2.typrequest  = "" .
        END.  /*end add ...A540125*/ 
        ELSE n_textfi   = wdetail2.comrequest + "/" + wdetail2.comcar  .
        END.
         /* add A63-0112 */
        IF DATE(wdetail.comdat) >= 04/01/2020 THEN DO:
           ASSIGN wdetail2.prempa  = "T" .
        END.
        /* A64-0328    
        IF wdetail2.redbook = ""  THEN DO:
            ASSIGN fi_process = "check Redbook.. " + wdetail.policy + ".....".
            DISP fi_process WITH FRAM fr_main.

            IF wdetail.covcod <> "1" THEN nv_si = INT(wdetail.tpfire)  .
            ELSE nv_si = INT(wdetail.si).
            RUN wgw/wgwredbook(input  wdetail.brand ,  
                               input  wdetail.model ,  
                               input  nv_si         ,  
                               INPUT  wdetail2.tariff,  
                               input  wdetail2.subclass,   
                               input  wdetail.caryear, 
                               input  b_eng /*wdetail.engcc */ ,
                               input  wdetail2.weight , 
                               INPUT-OUTPUT wdetail2.redbook) .
        END.
          end A64-0328 */
    END.
END.
...end A67-0065...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assignrenewbk C-Win 
PROCEDURE 00-proc_assignrenewbk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*add kridtiya i.  A53-0220...*/
/*DEF VAR nr_prempa    AS CHAR FORMAT "x(4)"  INIT "".
DEF VAR nr_subclass  AS CHAR FORMAT "x(4)"  INIT "".
 /*add kridtiya i.  A58-0115...*/   
DEF VAR nr_model     AS CHAR FORMAT "x(60)" INIT "". 
DEF VAR nr_redbook   AS CHAR FORMAT "x(10)" INIT "".         
DEF VAR nr_chasno    AS CHAR FORMAT "x(30)" INIT "".       
DEF VAR nr_eng       AS CHAR FORMAT "x(30)" INIT "".    
DEF VAR nr_caryear   AS CHAR FORMAT "x(4)"  INIT "". 
DEF VAR n_covcod     AS CHAR FORMAT "x(3)"  INIT "".
DEF VAR n_netprem    AS DECI INIT 0 .
def var n_ncb        as DECI .
def var n_garage     as char .

OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "003: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.

ASSIGN  
    nr_prempa   = ""
    nr_subclass = ""
    nr_prempa   = trim(wdetail2.prempa)
    nr_subclass = trim(wdetail2.subclass) 
    nr_model    = wdetail.model 
    nr_redbook  = wdetail2.redbook 
    nr_chasno   = wdetail.chasno 
    nr_eng      = wdetail.engcc 
    nr_caryear  = wdetail.caryear
    n_deductDOD  = 0
    n_deductDOD2 = 0
    n_deductDPD  = 0    /*A63-00472  Deduct Renew */
    /*A64-0328*/
    n_covcod    = ""
    n_NCB       = 0
    n_garage    = ""
    nv_cctvcode = ""    
    n_netprem   = 0
    nv_driver   = ""
    n_prmtdriv  = 0
    n_drivnam   = "N"
    n_ndriv1    = ""
    n_bdate1    = ""
    n_ndriv2    = ""
    n_bdate2    = "" .
  /* end A64-0328 */
 /*add kridtiya i.  A58-0115...*/
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwtbex1 (INPUT-OUTPUT wdetail.prepol,                   
                      INPUT-OUTPUT wdetail2.prempa,             
                      INPUT-OUTPUT wdetail2.subclass,         
                      INPUT-OUTPUT wdetail.model,             
                      INPUT-OUTPUT wdetail2.redbook,   wdetail2.redbook,          
                      INPUT-OUTPUT wdetail.cargrp,     wdetail.cargrp,            
                      INPUT-OUTPUT wdetail.chasno,     wdetail.chasno,            
                      INPUT-OUTPUT wdetail.eng,        wdetail.eng,               
                      INPUT-OUTPUT wdetail.vehuse,     wdetail.vehuse,            
                      INPUT-OUTPUT wdetail.caryear,    wdetail.caryear,           
                      /*INPUT-OUTPUT wdetail.covcod,    /*wdetail.carcode, A63-00472 */   */ /*A64-0328*/ 
                      INPUT-OUTPUT n_covcod,       /*A64-0328*/
                      INPUT-OUTPUT wdetail.body,               
                      INPUT-OUTPUT wdetail.seat,               
                      INPUT-OUTPUT wdetail.engcc,              
                      INPUT-OUTPUT n_41,                       
                      INPUT-OUTPUT n_42,                       
                      INPUT-OUTPUT n_43,                       
                      INPUT-OUTPUT nv_basere,                  
                      INPUT-OUTPUT nv_dss_per,
                      /* INPUT-OUTPUT wdetail.NCB,    */ /*A64-0328*/            
                     /* INPUT-OUTPUT wdetail.garage ,*/ /*A64-0328*/ 
                      INPUT-OUTPUT n_NCB,               /*A64-0328*/            
                      INPUT-OUTPUT n_garage ,           /*A64-0328*/ 
                      INPUT-OUTPUT n_firstdat, 
                      INPUT-OUTPUT n_deductDOD ,   /*A63-00472  Deduct Renew */   
                      INPUT-OUTPUT n_deductDOD2,  /*A63-00472  Deduct Renew */   
                      INPUT-OUTPUT n_deductDPD,  /*A63-00472  Deduct Renew */ 
                      /* add : A64-0328*/
                      INPUT-OUTPUT n_netprem  ,
                      INPUT-OUTPUT nv_driver , 
                      INPUT-OUTPUT n_prmtdriv ,  
                      INPUT-OUTPUT n_drivnam  ,  
                      INPUT-OUTPUT n_ndriv1   , 
                      INPUT-OUTPUT n_bdate1   ,
                      INPUT-OUTPUT n_ndriv2   ,
                      INPUT-OUTPUT n_bdate2 ) . 
                      /* end : A64-0328 */
END.
/*add kridtiya i.  A58-0115...เช็คข้อมูลไฟล์ไม่เท่ากับค่าว่าเอาที่ไฟล์*/
/*IF nr_redbook  <> "" THEN  wdetail2.redbook = nr_redbook  .*//*A63-00472*/
IF nr_model    <> "" THEN  wdetail.model    = nr_model    .
IF nr_chasno   <> "" THEN  wdetail.chasno   = nr_chasno   .
IF nr_eng      <> "" THEN  wdetail.engcc    = nr_eng      .
IF nr_caryear  <> "" THEN  wdetail.caryear  = nr_caryear  . 

IF trim(wdetail.covcod) = trim(n_covcod) THEN DO: /* ประเภทในไฟล์และ ใบเตือนตรงกัน */
   ASSIGN 
   wdetail2.NO_41 =  if int(wdetail2.NO_41) = 0 then  string(n_41)  else wdetail2.NO_41 
   wdetail2.NO_42 =  if int(wdetail2.NO_42) = 0 then  string(n_42)  else wdetail2.NO_42
   wdetail2.NO_43 =  if int(wdetail2.NO_43) = 0 then  string(n_43)  else wdetail2.NO_43
   nv_basere      =  nv_basere                   
   nv_dss_per     =  nv_dss_per                  
   wdetail.NCB    =  IF int(wdetail.NCB) = 0  THEN STRING(n_ncb)  else wdetail.NCB
   wdetail.garage =  IF wdetail.garage   = "" THEN n_garage       else wdetail.garage  
   n_deductDOD    =  n_deductDOD 
   n_deductDOD2   =  n_deductDOD2
   n_deductDPD    =  n_deductDPD 
   n_netprem      =  n_netprem
   nv_driver      =  nv_driver 
   n_prmtdriv     =  n_prmtdriv  
   n_drivnam      =  n_drivnam   
   n_ndriv1       =  n_ndriv1    
   n_bdate1       =  n_bdate1    
   n_ndriv2       =  n_ndriv2    
   n_bdate2       =  n_bdate2 .  
END.
ELSE DO:
   ASSIGN 
   /*wdetail2.NO_41 =  n_41
   wdetail2.NO_42 =  n_42
   wdetail2.NO_43 =  n_43*/
   nv_basere      =  0
   nv_dss_per     =  0
   /*wdetail.NCB    =  n_ncb
   wdetail.garage =  n_garage*/
   n_deductDOD    =  0 
   n_deductDOD2   =  0 
   n_deductDPD    =  0 
   n_netprem      =  n_netprem 
   nv_driver      =  "" 
   n_prmtdriv     =  0
   n_drivnam      =  "N"   
   n_ndriv1       =  ""     
   n_bdate1       =  ""     
   n_ndriv2       =  ""     
   n_bdate2       =  ""  . 

   ASSIGN wdetail2.comment = wdetail2.comment + "|Cover Code ในไฟล์ " + wdetail.covcod + " ไม่เหมือน ใบเตือน " + n_covcod + " ใช้ข้อมูลในไฟล์ "
          wdetail2.WARNING = wdetail2.WARNING + "|Cover Code ในไฟล์และใบเตือนไม่ตรงกัน"
          wdetail2.pass    = IF wdetail2.pass = "N" THEN "N" ELSE "Y" .
END.
IF DECI(wdetail.premt) <> n_netprem THEN DO:
    ASSIGN wdetail2.comment = wdetail2.comment + "|เบี้ยในไฟล์ " + wdetail.premt + " ไม่เท่ากับใบเตือน " + STRING(n_netprem,">,>>>,>>>,>>9.99-") 
           wdetail2.WARNING = wdetail2.WARNING + "|เบี้ยในไฟล์และใบเตือนไม่เท่ากัน" 
           wdetail2.pass    = IF wdetail2.pass = "N" THEN "N" ELSE "Y"  .
END.


/*add kridtiya i.  A58-0115...*/
IF index(wdetail.nmember,"กล้อง") <> 0 OR index(wdetail.nmember,"CCTV") <> 0  THEN DO:  /* + CCTV 5 per for Renew */
    nv_cctvcode = "0001".             /* Code CCTV */
    IF nv_dss_per  > 28 THEN nv_dss_per = 33 .   /* 28 + 5 = 33 */
    ELSE nv_dss_per = nv_dss_per + 5.
END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assignrenewbk2 C-Win 
PROCEDURE 00-proc_assignrenewbk2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nr_prempa    AS CHAR FORMAT "x(4)"  INIT "".
DEF VAR nr_subclass  AS CHAR FORMAT "x(4)"  INIT "".
DEF VAR nr_model     AS CHAR FORMAT "x(60)" INIT "". 
DEF VAR nr_redbook   AS CHAR FORMAT "x(10)" INIT "".         
DEF VAR nr_chasno    AS CHAR FORMAT "x(30)" INIT "".       
DEF VAR nr_eng       AS CHAR FORMAT "x(30)" INIT "".    
DEF VAR nr_caryear   AS CHAR FORMAT "x(4)"  INIT "". 
DEF VAR n_covcod     AS CHAR FORMAT "x(3)"  INIT "".
DEF VAR n_netprem    AS DECI INIT 0 .
def var n_ncb        as DECI .
def var n_garage     as char .
ASSIGN  
    nr_prempa   = ""
    nr_subclass = ""
    nr_prempa   = trim(wdetail2.prempa)
    nr_subclass = trim(wdetail2.subclass) 
    nr_model    = wdetail.model 
    nr_redbook  = wdetail2.redbook 
    nr_chasno   = wdetail.chasno 
    nr_eng      = wdetail.engcc 
    nr_caryear  = wdetail.caryear
    n_deductDOD  = 0
    n_deductDOD2 = 0
    n_deductDPD  = 0    
    n_covcod    = ""
    n_NCB       = 0
    n_garage    = ""
    nv_cctvcode = ""    
    n_netprem   = 0
    nv_driver   = ""
    n_prmtdriv  = 0
    n_drivnam   = "N"
    n_ndriv1    = ""
    n_bdate1    = ""
    n_ndriv2    = ""
    n_bdate2    = "" .
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwhcex1 (INPUT-OUTPUT wdetail.prepol,             
                      INPUT-OUTPUT wdetail2.prempa,                
                      INPUT-OUTPUT wdetail2.subclass,          
                      INPUT-OUTPUT wdetail.model,              
                      INPUT-OUTPUT wdetail2.redbook,           
                      INPUT-OUTPUT wdetail.cargrp,             
                      INPUT-OUTPUT wdetail.chasno,             
                      INPUT-OUTPUT wdetail.eng,                
                      INPUT-OUTPUT wdetail.vehuse,             
                      INPUT-OUTPUT wdetail.caryear,            
                      /*INPUT-OUTPUT wdetail.covcod,    /*wdetail.carcode, A63-00472 */   */ /*A64-0328*/ 
                      INPUT-OUTPUT n_covcod,        
                      INPUT-OUTPUT wdetail.body,               
                      INPUT-OUTPUT wdetail.seat,               
                      INPUT-OUTPUT wdetail.engcc,              
                      INPUT-OUTPUT n_41,                       
                      INPUT-OUTPUT n_42,                       
                      INPUT-OUTPUT n_43,                       
                      INPUT-OUTPUT nv_basere,                  
                      INPUT-OUTPUT nv_dss_per,
                      /* INPUT-OUTPUT wdetail.NCB,    */           
                     /* INPUT-OUTPUT wdetail.garage ,*/ 
                      INPUT-OUTPUT n_NCB,                         
                      INPUT-OUTPUT n_garage ,           
                      INPUT-OUTPUT n_firstdat, 
                      INPUT-OUTPUT n_deductDOD ,    
                      INPUT-OUTPUT n_deductDOD2,   
                      INPUT-OUTPUT n_deductDPD,  
                      INPUT-OUTPUT n_netprem  ,
                      INPUT-OUTPUT nv_driver , 
                      INPUT-OUTPUT n_prmtdriv ,  
                      INPUT-OUTPUT n_drivnam  ,  
                      INPUT-OUTPUT n_ndriv1   , 
                      INPUT-OUTPUT n_bdate1   ,
                      INPUT-OUTPUT n_ndriv2   ,
                      INPUT-OUTPUT n_bdate2   ,
                      INPUT-OUTPUT nv_cctvcode ) .
                      
END.
IF nr_model    <> "" THEN  wdetail.model    = nr_model    .
IF nr_chasno   <> "" THEN  wdetail.chasno   = nr_chasno   .
IF nr_eng      <> "" THEN  wdetail.engcc    = nr_eng      .
IF nr_caryear  <> "" THEN  wdetail.caryear  = nr_caryear  . 

   ASSIGN 
   wdetail2.NO_41 =  string(n_41)  
   wdetail2.NO_42 =  string(n_42)  
   wdetail2.NO_43 =  string(n_43)  
   nv_basere      =  nv_basere                   
   nv_dss_per     =  nv_dss_per                  
   wdetail.NCB    =  STRING(n_ncb)  
   wdetail.covcod =  trim(n_covcod)
   wdetail.garage =  n_garage      
   n_deductDOD    =  n_deductDOD 
   n_deductDOD2   =  n_deductDOD2
   n_deductDPD    =  n_deductDPD 
   n_netprem      =  n_netprem
   nv_driver      =  nv_driver 
   n_prmtdriv     =  n_prmtdriv  
   n_drivnam      =  n_drivnam   
   n_ndriv1       =  n_ndriv1    
   n_bdate1       =  n_bdate1    
   n_ndriv2       =  n_ndriv2    
   n_bdate2       =  n_bdate2
   wdetail.premt  = string(n_netprem) .  

IF trim(wdetail.covcod) <> trim(n_covcod) THEN DO: /* ประเภทในไฟล์และ ใบเตือนไม่ตรงกัน */
   ASSIGN wdetail2.comment = wdetail2.comment + "|Cover Code ในไฟล์ " + wdetail.covcod + " ไม่เหมือน ใบเตือน " + n_covcod + " ใช้ข้อมูลในไฟล์ "
          wdetail2.WARNING = wdetail2.WARNING + "|Cover Code ในไฟล์และใบเตือนไม่ตรงกัน"
          wdetail2.pass    = IF wdetail2.pass = "N" THEN "N" ELSE "Y" .
END.
IF DECI(wdetail.premt) <> n_netprem THEN DO:
    ASSIGN wdetail2.comment = wdetail2.comment + "|เบี้ยในไฟล์ " + wdetail.premt + " ไม่เท่ากับใบเตือน " + STRING(n_netprem,">,>>>,>>>,>>9.99-") 
           wdetail2.WARNING = wdetail2.WARNING + "|เบี้ยในไฟล์และใบเตือนไม่เท่ากัน" 
           wdetail2.pass    = IF wdetail2.pass = "N" THEN "N" ELSE "Y"  .
END.
 
/*add kridtiya i.  A58-0115...*/
IF nv_cctvcode = "" THEN DO:
    IF index(wdetail.nmember,"กล้อง") <> 0 OR index(wdetail.nmember,"CCTV") <> 0  THEN DO:  /* + CCTV 5 per for Renew */
        nv_cctvcode = "0001".             /* Code CCTV */
        IF nv_dss_per  > 28 THEN nv_dss_per = 33 .   /* 28 + 5 = 33 */
        ELSE nv_dss_per = nv_dss_per + 5.
    END.
END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assign_ex C-Win 
PROCEDURE 00-proc_assign_ex :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by A68-0061...
ASSIGN fi_process = "Create data HCT....".
DISP fi_process WITH FRAM fr_main.
For each  wdetail.
    DELETE  wdetail.
END.
For each  wdetail2.
    DELETE  wdetail2.
END.
For each  wdetail3.
    DELETE  wdetail3.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "|" 
        wf_policyno        /*   เลขที่ใบคำขอ    */
        wf_n_branch        /*   สาขา    */
        wf_n_delercode     /*   รหัสดีเลอร์     */
        wf_vatcode             /*       Vat code.       */
        wf_cndat           /*   วันที่ใบคำขอ    */
        wf_appenno         /*   เลขที่รับแจ้ง   */
        wf_comdat          /*   วันที่เริ่มคุ้มครอง     */
        wf_expdat          /*   วันที่สิ้นสุด   */
        wf_comcode         /*   รหัสบริษัทประกันภัย     */
        wf_cartyp          /*   ประเภทรถ        */
        wf_saletyp         /*   ประเภทการขาย    */
        wf_campen          /*   ประเภทแคมเปญ    */
        wf_freeamonth      /*   จำนวนเงินให้ฟรี         */
        wf_covcod          /*   ประเภทความคุ้มครอง      */
        wf_typcom          /*   ประเภทประกัน    */
        wf_garage          /*   ประเภทการซ่อม   */
        wf_bysave          /*   ผู้บันทึก       */
        wf_tiname          /*   คำนำหน้า        */
        wf_insnam          /*   ชื่อลูกค้า      */
        wf_name2           /*   ชื่อกลาง        */
        wf_name3           /*   นามสกุล         */
        wf_addr            /*   ที่อยู่         */
        wf_road            /*   ถนน     */
        wf_tambon          /*   ตำบล    */
        wf_amper           /*   อำเภอ   */
        wf_country         /*   จังหวัด         */
        wf_post            /*   รหัสไปรษณีย์    */
        wf_occup           /*   อาชีพ   */
        wf_birthdat        /*   วันเกิด */
        wf_icno            /*   เลขที่บัตรประชาชน       */
        wf_driverno        /*   เลขที่ใบขับขี่  */
        wf_brand           /*   ยี่ห้อรถ        */
        wf_cargrp          /*   กลุ่มรถยนต์     */
        wf_chasno          /*   หมายเลขตัวถัง   */
        wf_eng             /*   หมายเลขเครื่อง  */
        wf_model           /*   ชื่อรุ่นรถ      */
        wf_caryear         /*   รุ่นปี  */
        wf_carcode         /*   ชื่อประเภทรถ    */
        wf_body            /*   แบบตัวถัง       */
        wf_vehuse          /*   รหัสประเภทรถ    */
        wf_carno           /*   รหัสลักษณะการใช้งาน     */
        wf_seat            /*   จำนวนที่นั่ง    */
        wf_engcc           /*   ปริมาตรกระบอกสูบ        */
        wf_colorcar        /*   ชื่อสีรถ        */
        wf_vehreg          /*   เลขทะเบียนรถ    */
        wf_re_country      /*   จังหวัดที่จดทะเบียน     */
        wf_re_year         /*   ปีที่จดทะเบียน  */
        wf_nmember         /*   หมายเหตุ        */
        wf_si              /*   วงเงินทุนประกัน */
        wf_premt           /*   เบี้ยประกัน     */
        wf_rstp_t          /*   อากร    */
        wf_rtax_t          /*   จำนวนเงินภาษี   */
        wf_prem_r          /*   เบี้ยประกันรวม  */
        wf_gap             /*   เบี้ยประกันรวมทั้งหมด   */
        wf_ncb             /*   อัตราส่วนลดประวัติดี    */
        wf_ncbprem         /*   ส่วนลดประวัติดี */
        wf_stk             /*   หมายเลขสติ๊กเกอร์       */
        wf_prepol          /*   เลขที่กรมธรรม์เดิม      */
        wf_flagname        /*   flag ระบุชื่อ   */
        wf_flagno          /*   flag ไม่ระบุชื่อ        */
        wf_ntitle1         /*   คำนำหน้า        */
        wf_drivername1     /*   ชื่อผู้ขับขี่คนที่1     */
        wf_dname1          /*   ชื่อกลาง        */
        wf_dname2          /*   นามสกุล */
        wf_docoup          /*   อาชีพ   */
        wf_dbirth          /*   วันเกิด */
        wf_dicno           /*   เลขที่บัตรประชาชน       */
        wf_ddriveno        /*   เลขที่ใบขับขี่  */
        wf_ntitle2         /*   คำนำหน้า2       */
        wf_drivername2     /*   ชื่อผู้ขับขี่คนที่2     */
        wf_ddname1         /*   ชื่อกลาง2       */
        wf_ddname2         /*   นามสกุล2        */
        wf_ddocoup         /*   อาชีพ2  */
        wf_ddbirth         /*   วันเกิด2        */
        wf_ddicno          /*   เลขที่บัตรประชาชน2      */
        wf_dddriveno       /*   เลขที่ใบขับขี่2 */
        wf_benname         /*   ผู้รับผลประโยชน์        */
        wf_comper          /*   ความเสียหายต่อชีวิต(บาท/คน)     */
        wf_comacc          /*   ความเสียหายต่อชีวิต(บาท/ครั้ง)  */
        wf_deductpd        /*   ความเสียหายต่อทรัพย์สิน */
        wf_tp2             /*   ความเสียหายส่วนแรกบุคคล */
        wf_deductda        /*   ความเสียหายต่อต่อรถยนต์ */
        wf_deduct          /*   ความเสียหายส่วนแรกรถยนต์        */
        wf_tpfire          /*   รถยนต์สูญหาย/ไฟไหม้     */
        wf_NO_41               /*  อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่        */
        wf_ac2                 /*  อุบัติเหตุส่วนบุคคลเสียชีวิตจน.ผู้โดยสาร     */
        wf_NO_42               /*  อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง        */
        wf_ac4                 /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้ขับขี่ */
        wf_ac5                 /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวจน.ผู้โดยสาร      */
        wf_ac6                 /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้โดยสารต่อครั้ง */
        wf_ac7                 /*  ค่ารักษาพยาบาล       */
        wf_NO_43           /*  การประกันตัวผู้ขับขี่    */
        wf_nstatus         /*  สถานะข้อมูล      */
        wf_typrequest      /*  รหัสบริษัทผู้แจ้งประกัน  */
        wf_comrequest      /*  ชื่อบริษัทผู้แจ้งงาน     */
        wf_brrequest       /*  สาขาบริษัทผู้แจ้งประกัน  */
        wf_salename        /*  ชื่อผู้ติดต่อ/Saleman    */
        wf_comcar          /*  บริษัทที่ปล่อยรถ */
        wf_brcar           /*  สาขาบริษัทที่ปล่อยรถ     */
        wf_projectno       /*  honda project    */
        wf_agcaryear               /*  อายุรถ   */
        wf_special1        /*  บริการเสริมพิเศษ1        */
        wf_specialprem1    /*  ราคาบริการเสริมพิเศษ1    */
        wf_special2        /*  บริการเสริมพิเศษ2        */
        wf_specialprem2    /*  ราคาบริการเสริมพิเศษ2    */
        wf_special3        /*  บริการเสริมพิเศษ3        */
        wf_specialprem3    /*  ราคาบริการเสริมพิเศษ3    */
        wf_special4        /*  บริการเสริมพิเศษ4        */
        wf_specialprem4    /*  ราคาบริการเสริมพิเศษ4    */
        wf_special5        /*  บริการเสริมพิเศษ5        */
        wf_specialprem5    /*  ราคาบริการเสริมพิเศษ5    */
        wf_ac_no           /*  เล่มที่/เลขที่   */
        wf_ac_date         /*  วันที่รับเงิน    */
        wf_ac_amount       /*  จำนวนเงิน        */
        wf_ac_pay          /*  ชำระโดย  */
        wf_ac_agent        /*  เลขที่นายหน้า    */
        wf_voictitle       /*  ออกใบเสร็จในนาม  */
        wf_voicnam         /*  รหัสDealer Receipt       */
        wf_voicnamdetail   /*   ชื่อใบเสร็จ     */
        wf_detailcam       /*  รายละเอียดเคมเปญ */
        wf_ins_pay         /*   รับประกันจ่ายแน่ๆ       */
        wf_n_month         /*   ผ่อนชำระ/เดือน          */
        wf_n_bank          /*   บัตรเครดิตธนาคาร        */
        wf_TYPE_notify     /*   ประเภทการแจ้งงาน        */
        wf_price_acc       /*   ราคารวมอุปกรณ์เสริม     */
        wf_accdata         /*  รายละเอียดอุปกรณ์เสริม   */
        wf_brdealer        /*  สาขา(ชื่อผู้เอาประกันในนามบริษัท)        */
        wf_brand_gals      /*  ยี่ห้อเคลือบแก้ว */
        wf_brand_galsprm   /*  ราคาเคลือบแก้ว   */
        wf_companyre1      /*  ชื่อบริษัทเต็มบนใบกำกับภาษี1     */
        wf_companybr1      /*  สาขาบริษัทบนใบกำกับภาษี1 */
        wf_addr_re1        /*  ที่อยู่บนใบกำกับภาษี1    */
        wf_idno_re1        /*  เลขที่ผู้เสียภาษี1       */
        wf_premt_re1       /*  อัตราเบี้ยตามใบกำกับ1    */
        wf_companyre2      /*  ชื่อบริษัทเต็มบนใบกำกับภาษี2     */
        wf_companybr2      /*  สาขาบริษัทบนใบกำกับภาษี2 */
        wf_addr_re2        /*  ที่อยู่บนใบกำกับภาษี2    */
        wf_idno_re2        /*  เลขที่ผู้เสียภาษี2       */
        wf_premt_re2       /*  อัตราเบี้ยตามใบกำกับ2    */
        wf_companyre3      /*  ชื่อบริษัทเต็มบนใบกำกับภาษี3     */
        wf_companybr3      /*  สาขาบริษัทบนใบกำกับภาษี3 */
        wf_addr_re3        /*  ที่อยู่บนใบกำกับภาษี3    */
        wf_idno_re3        /*  เลขที่ผู้เสียภาษี3       */
        wf_premt_re3       /*  อัตราเบี้ยตามใบกำกับ3    */
        wf_camp_no         /*  เลขที่แคมเปญ             */              /*--A58-0419--*/
        wf_payment_type    /*  ประเภทการชำระเบี้ย       */              /*--A58-0419--*/
        wf_producer      .
    IF            TRIM(wf_policyno) = ""           THEN RUN proc_initdataex.
    ELSE IF index(TRIM(wf_policyno),"TEXT")   <> 0 THEN RUN proc_initdataex.
    ELSE IF index(TRIM(wf_policyno),"เลขที่") <> 0 THEN RUN proc_initdataex.
    ELSE IF INDEX(TRIM(wf_policyno),"จำนวน")  <> 0 THEN RUN proc_initdataex.  /*--A58-0419--*/
    ELSE DO:
        IF Trim(wf_covcod) =  "T" THEN RUN proc_assigninit72.
                                  ELSE RUN proc_assigninit70.
        RUN proc_initdataex.
    END.
    
END.         /* repeat   */
INPUT CLOSE.   /*close Import*/


RUN proc_assign2.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_calpremt C-Win 
PROCEDURE 00-proc_calpremt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by ranu I. A64-0328      
------------------------------------------------------------------------------*/
/* comment by : A68-0061...
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "015-6:" TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
IF wdetail2.poltyp = "V70" THEN DO:
    ASSIGN fi_process = "Create data to base..." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
    ASSIGN 
         nv_polday  = 0 
         nv_covcod  = ""  
         nv_class   = ""  
         nv_vehuse  = ""  
         nv_cstflg  = ""  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/    
         nv_engcst  = 0   /* ต้องใส่ค่าตาม nv_cstflg  */         
         /*nv_drivno  = 0 */
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
         nv_gapprem = 0     /*เบี้ยรวม */
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
         nv_class   = trim(wdetail2.prempa) + trim(wdetail2.subclass)                                         
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
         nv_access  = sic_bran.uwm130.uom6_u                                           
       /*nv_supe    = NO*/                                              
         nv_tpbi1si = sic_bran.uwm130.uom1_v               
         nv_tpbi2si = sic_bran.uwm130.uom2_v               
         nv_tppdsi  = sic_bran.uwm130.uom5_v               
         nv_411si   = deci(WDETAIL2.no_41)       
         nv_412si   = deci(WDETAIL2.no_41)       
         nv_413si   = 0                       
         nv_414si   = 0                       
         nv_42si    = deci(WDETAIL2.no_42)                
         nv_43si    = deci(WDETAIL2.no_43)                
         nv_seat41  = int(wdetail2.seat41)   
         nv_dedod   = dod1       
         nv_addod   = dod2                                 
         nv_dedpd   = dpd0                                     
         nv_ncbp    = deci(wdetail.ncb) 
         nv_baseprm  = IF wdetail.prepol = "" THEN  0  ELSE nv_baseprm   /*A67-0065 */
         nv_baseprm3 = IF wdetail.prepol = "" THEN  0  ELSE nv_baseprm3  /*A67-0065 */
         nv_fletp   = deci(wdetail2.fleet)                                  
         nv_dspcp   = nv_dss_per                                      
         /*nv_dstfp   = 0 */ /*A67-0065 */
         nv_dstfp   = IF TRIM(wdetail2.producer) = "B3M0070" THEN 20 ELSE 0
         nv_clmp    = 0                                                     
         nv_netprem = DECI(wdetail.premt) /* เบี้ยสุทธิ */                                                
         nv_gapprem = 0                                                       
         nv_flagprm = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
         nv_effdat  = sic_bran.uwm100.comdat                             
         nv_ratatt  = 0                    
         nv_siatt   = 0                                                   
         nv_netatt  = 0 
         nv_fltatt  = 0 
         nv_ncbatt  = 0 
         nv_dscatt  = 0 
         /*nv_status  = "" */
         nv_fcctv   = IF nv_cctvcode = "0001" THEN YES ELSE NO . 

     FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
           clastab_fil.CLASS  = nv_class     AND
           clastab_fil.covcod = wdetail.covcod    NO-LOCK NO-ERROR.
        IF AVAIL stat.clastab_fil THEN DO:
            IF clastab_fil.unit = "C" THEN DO:
                ASSIGN
                    nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" THEN "W" ELSE clastab_fil.unit
                    nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(wdetail.engcc) ELSE INT(wdetail.engcc).
            END.
            ELSE IF clastab_fil.unit = "S" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = INT(wdetail.seat).
            END.
            ELSE IF clastab_fil.unit = "T" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = DECI(wdetail.engcc).
            END.
            /* A67-0065*/
            ELSE IF clastab_fil.unit = "H" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = DECI(wdetail.engcc).
            END.
             /* end : A67-0065 */
            nv_engcst = nv_engine .
        END.

    IF nv_cstflg = "W" THEN DO: 
        ASSIGN sic_bran.uwm301.watt   = nv_CC 
               sic_bran.uwm301.engine = 0 . /* A67-0065 */
    END.
    /* A67-0065 */
    ELSE IF nv_cstflg = "H" THEN DO: 
        ASSIGN sic_bran.uwm301.watt = nv_CC 
               sic_bran.uwm301.engine = 0. 
    END.
    /* end : A67-0065 */
    IF wdetail2.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            RUN wgw/wgwredbook(input  wdetail.brand ,  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail2.tariff,  
                               input  wdetail2.subclass,   
                               input  wdetail.caryear, 
                               input  nv_engine  ,
                               input  0 , 
                               INPUT-OUTPUT wdetail2.redbook) .
        END.
        ELSE DO:
            RUN wgw/wgwredbook(input  wdetail.brand ,  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail2.tariff,  
                               input  wdetail2.subclass,   
                               input  wdetail.caryear, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT wdetail2.redbook) .
        END.

        IF wdetail2.redbook <> ""  THEN DO:
            FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE 
                 stat.maktab_fil.sclass = wdetail2.subclass  AND
                 stat.maktab_fil.modcod = wdetail2.redbook   No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN
                 sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod  
                 sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac  
                 wdetail.cargrp          =  stat.maktab_fil.prmpac  
                 nv_vehgrp               =  stat.maktab_fil.prmpac.

        END.
        ELSE DO:
         ASSIGN
                wdetail2.comment = wdetail2.comment + "| " + "Redbook is Null !! "
                wdetail2.WARNING = wdetail2.WARNING + "|Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ " 
                wdetail2.pass    = "N" 
                wdetail2.OK_GEN  = "N".

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
    " nv_baseprm       "  nv_baseprm    skip
    " nv_baseprm3      "  nv_baseprm3   skip
    " nv_netprem       "  nv_netprem    skip  
    " nv_gapprm        "  nv_gapprem    skip  
    " nv_flagprm       "  nv_flagprm    skip  
    " wdetail.comdat   "  nv_effdat     skip 
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.     
    */
    /*RUN WUW\WUWPADP1.P(INPUT sic_bran.uwm100.policy,*/
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "015-6:" TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
    RUN WUW\WUWPADP2.P (INPUT sic_bran.uwm100.policy,
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
      /*  MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt + 
            nv_message   VIEW-AS ALERT-BOX.
         ASSIGN
                wdetail2.comment =  wdetail2.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
                wdetail2.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt
                /*wdetail2.pass    = "Y"*/  /*comment by Kridtiya i. A65-0035*/    
                wdetail2.OK_GEN  = "N".*/
        /*comment by Kridtiya i. A65-0035*/ 
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN wdetail2.comment = wdetail2.comment + "|" + nv_message    /*  by Kridtiya i. A65-0035*/ 
               wdetail2.WARNING = wdetail2.WARNING + "|" + nv_message .  /*  by Kridtiya i. A65-0035*/ 
    END.
     /*  by Kridtiya i. A65-0035*/ 
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate (input date(wdetail.comdat),
                        input date(wdetail.expdat),
                        input wdetail2.poltyp,
                        OUTPUT nv_chkerror ) .
    IF nv_chkerror <> ""  THEN 
        ASSIGN wdetail2.comment = wdetail2.comment + "|" + nv_chkerror 
        wdetail2.pass    = "N"
        wdetail2.OK_GEN  = "N".
    /* end : A65-0035 */

    ASSIGN 
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
    
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest0 C-Win 
PROCEDURE 00-proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER . 
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "012: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
ASSIGN fi_process = "check data HCT...." + wdetail.policyno .
DISP fi_process WITH FRAM fr_main.
IF wdetail.vehreg = " " AND wdetail.prepol  = " " THEN DO: 
    ASSIGN
        wdetail2.comment = wdetail2.comment + "| Vehicle Register is mandatory field. "
        wdetail2.pass    = "N"   
        WDETAIL2.OK_GEN  = "N". 
END.
ELSE DO:
    IF wdetail.prepol = " " THEN DO:     /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
        Def  var  nv_vehreg  as char  init  " ".
        Def  var  s_polno       like sicuw.uwm100.policy   init " ".
        Find LAST sicuw.uwm301 Use-index uwm30102 Where  
            sicuw.uwm301.vehreg = wdetail.vehreg  No-lock no-error no-wait.
        IF AVAIL sicuw.uwm301 THEN DO:
            If  sicuw.uwm301.policy =  wdetail.policyno     and          
                sicuw.uwm301.endcnt = 1  and
                sicuw.uwm301.rencnt = 1  and
                sicuw.uwm301.riskno = 1  and
                sicuw.uwm301.itemno = 1  Then  Leave.
            Find first sicuw.uwm100 Use-index uwm10001      Where
                sicuw.uwm100.policy = sicuw.uwm301.policy   and
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt   and
                sicuw.uwm100.expdat > date(wdetail.comdat)  No-lock no-error no-wait.
            If avail sicuw.uwm100 Then 
                s_polno     =   sicuw.uwm100.policy.
        END.        /*avil 301*/
    END.            /*จบการ Check ทะเบียนรถ*/
END.      /*note end else*/   /*end note vehreg*/
nv_chkerror = "".
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "012-1: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
RUN wgw\wgwchkagpd  (INPUT fi_agent            
                     ,INPUT wdetail2.producer   
                     ,INPUT-OUTPUT nv_chkerror).
IF nv_chkerror <> "" THEN DO:
    ASSIGN  wdetail2.pass = "N"  
        wdetail2.comment = wdetail2.comment + "|Error Code Producer/Agent:" + nv_chkerror
        WDETAIL2.OK_GEN  = "N".
END.
/*wdetail2.n_branch*/
IF wdetail2.n_branch = ""  THEN  
    ASSIGN  wdetail2.pass = "N"  
    wdetail2.comment = wdetail2.comment + "| พบสาขาเป็นค่าว่างหรือไม่พบรหัสดีเลอร์" + n_textfi
    WDETAIL2.OK_GEN  = "N".
IF wdetail2.cancel = "ca"  THEN  
    ASSIGN  wdetail2.pass = "N"  
    wdetail2.comment = wdetail2.comment + "| cancel"
    WDETAIL2.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail2.pass    = "N"     
    WDETAIL2.OK_GEN  = "N".
IF wdetail2.drivnam  = "y" AND wdetail.drivername1 =  " "   THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
    wdetail2.pass    = "N" 
    WDETAIL2.OK_GEN  = "N".
IF wdetail2.prempa = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"     
    WDETAIL2.OK_GEN  = "N".
IF wdetail2.subclass = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"  
    WDETAIL2.OK_GEN  = "N".
IF wdetail.brand = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"        
    WDETAIL2.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"   
    WDETAIL2.OK_GEN  = "N".
IF wdetail.engcc    = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"     
    WDETAIL2.OK_GEN  = "N".
IF wdetail.seat  = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"    
    WDETAIL2.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"  
    WDETAIL2.OK_GEN  = "N".

/*comment BY kridtiya i. A56-0318 ...
IF wdetail.icno <> "" THEN DO:
    IF LENGTH(TRIM(wdetail.icno)) = 13 THEN DO:
        DO WHILE nv_seq <= 12:
            nv_sum = nv_sum + INTEGER(SUBSTR(TRIM(wdetail.icno),nv_seq,1)) * (14 - nv_seq).
            nv_seq = nv_seq + 1.
        END.
        nv_checkdigit = 11 - nv_sum MODULO 11.
        IF nv_checkdigit >= 10 THEN nv_checkdigit = nv_checkdigit - 10.
        IF STRING(nv_checkdigit) <> SUBSTR(TRIM(wdetail.icno),13,1) THEN  
            ASSIGN  wdetail.icno = ""
            /*wdetail2.comment = wdetail2.comment + "| WARNING: พบเลขบัตรประชาชนไม่ถูกต้อง"
            wdetail2.pass    = "N"  
            WDETAIL2.OK_GEN  = "N"*/  .
        /* FIND FIRST sicsyac.xmm600 USE-INDEX xmm60003 WHERE 
        sicsyac.xmm600.icno  = nv_icno  AND
        sicsyac.xmm600.acno <> nv_acno NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm600 THEN DO:    
        ASSIGN  wdetail2.comment = wdetail2.comment + "| WARNING: คีย์เลขบัตรประชาชนไม่ถูกต้อง"
        wdetail2.pass    = "N"  
        WDETAIL2.OK_GEN  = "N".      
        MESSAGE "พบ Ic.No ! " nv_icno  "ซ้ำกับ  Account No. " sicsyac.xmm600.acno .      
        end. */
    END.
    ELSE ASSIGN  wdetail.icno = ""
        /*wdetail2.comment = wdetail2.comment + "| WARNING: คีย์เลขบัตรประชาชนไม่ถูกต้องไม่เท่ากับ 13 หลัก"
        wdetail2.pass    = "N"  
        WDETAIL2.OK_GEN  = "N"*/   .
END. 
comment BY kridtiya i. A56-0318 ...*/
ASSIGN
    nv_maxsi  = 0
    nv_minsi  = 0
    nv_si     = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred    = NO.  
IF wdetail2.redbook <> "" THEN DO:  /*case renew policy .......*/
    FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE 
        stat.maktab_fil.sclass = wdetail2.subclass  AND 
        stat.maktab_fil.modcod = wdetail2.redbook   No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  
            nv_modcod         =  stat.maktab_fil.modcod                                    
            nv_moddes         =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp    =  stat.maktab_fil.prmpac
            wdetail.brand     =  stat.maktab_fil.makdes
            wdetail.caryear   =  STRING(stat.maktab_fil.makyea)
            wdetail.engcc     =  STRING(stat.maktab_fil.engine)
            wdetail2.subclass =  stat.maktab_fil.sclass   
            /*wdetail.si      =  STRING(stat.maktab_fil.si)*/
            wdetail2.redbook  =  stat.maktab_fil.modcod                                    
            wdetail.seat      =  STRING(stat.maktab_fil.seats)
            nv_si             =  stat.maktab_fil.si 
            /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/
            chkred           =  YES      /*note chk found redbook*/  .
        IF wdetail.covcod = "1"  THEN DO:
            FIND FIRST stat.makdes31 WHERE 
                stat.makdes31.makdes = "X"  AND     /*Lock X*/
                stat.makdes31.moddes = wdetail2.prempa + wdetail2.subclass    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE makdes31 THEN 
                ASSIGN  nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            ELSE 
                ASSIGN
                    nv_maxSI = nv_si
                    nv_minSI = nv_si.
        END.  /***--- End Check Rate SI ---***/
    End.          
    ELSE nv_modcod = " ".
END. /*red book <> ""*/   
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "012-2: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
IF nv_modcod = "" THEN DO:
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
           makdes31.moddes =  wdetail2.prempa + wdetail2.subclass NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL makdes31  THEN
           ASSIGN n_ratmin = makdes31.si_theft_p   
           n_ratmax = makdes31.load_p   .    
       ELSE ASSIGN n_ratmin = 0     n_ratmax = 0.
    /*create by : A60-0505*/
    /*IF INDEX(wdetail.model,"CIVIC") <> 0 THEN DO:*/ /*A63-00472*/
    IF (INDEX(wdetail.model,"CIVIC") <> 0 ) OR (INDEX(wdetail.model,"CITY") <> 0) THEN DO:  /*A63-00472*/
        IF INDEX(wdetail.carcode,"HATCHBACK") <> 0 THEN DO:
           Find First stat.maktab_fil USE-INDEX maktab04    Where
             stat.maktab_fil.makdes   =     wdetail.brand            And                  
             index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
             stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
             stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
             stat.maktab_fil.sclass   =     wdetail2.subclass        AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
             stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  AND
             stat.maktab_fil.body     = "HATCHBACK"     No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN
                nv_modcod              =  stat.maktab_fil.modcod
                wdetail2.redbook       =  stat.maktab_fil.modcod
                wdetail.cargrp         =  stat.maktab_fil.prmpac
                wdetail.body           =  stat.maktab_fil.body
                chkred = YES.
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
             stat.maktab_fil.makdes   =     wdetail.brand            And                  
             index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
             stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
             stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
             stat.maktab_fil.sclass   =     wdetail2.subclass        AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
             stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  AND
             stat.maktab_fil.body     = "SEDAN"     No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN
                nv_modcod              =  stat.maktab_fil.modcod
                wdetail2.redbook       =  stat.maktab_fil.modcod
                wdetail.cargrp         =  stat.maktab_fil.prmpac
                wdetail.body           =  stat.maktab_fil.body
                chkred = YES.
        END.
    END.
    ELSE DO:
    /* end A60-0505*/
       Find First stat.maktab_fil USE-INDEX maktab04    Where
           stat.maktab_fil.makdes   =     wdetail.brand            And                  
           index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
           stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
           stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
           stat.maktab_fil.sclass   =     wdetail2.subclass        AND
          (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
           stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
           stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
           No-lock no-error no-wait.
       If  avail stat.maktab_fil  Then 
           ASSIGN
           nv_modcod              =  stat.maktab_fil.modcod
           wdetail2.redbook       =  stat.maktab_fil.modcod
           wdetail.cargrp         =  stat.maktab_fil.prmpac
           wdetail.body           =  stat.maktab_fil.body
           /*sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
           sic_bran.uwm301.moddes =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
           sic_bran.uwm301.vehgrp =  stat.maktab_fil.prmpac
           sic_bran.uwm301.body   =  stat.maktab_fil.body*/
           chkred = YES.
    /*IF nv_modcod = ""  THEN RUN proc_maktab.*/
    END.
END.  /*nv_modcod = blank*/
    /*end note add &  modi*/
    ASSIGN                  
        NO_CLASS  = wdetail2.prempa + wdetail2.subclass 
        nv_poltyp = wdetail2.poltyp.
    IF nv_poltyp = "v72" THEN NO_CLASS  =  wdetail2.subclass.
    If no_class  <>  " " Then do:
        FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
            sicsyac.xmd031.poltyp =   nv_poltyp AND
            sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE sicsyac.xmd031 THEN 
            /*MESSAGE   "Not on Business Classes Permitted per Policy Type file xmd031"  
                sicuw.uwm100.poltyp   no_class  View-as alert-box.*/
            ASSIGN
                wdetail2.comment = wdetail2.comment + "| Not On Business Class xmd031" 
                wdetail2.pass    = "N"   
                WDETAIL2.OK_GEN  = "N".
        
        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
            sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
        IF NOT AVAILABLE sicsyac.xmm016 THEN 
            ASSIGN
                wdetail2.comment = wdetail2.comment + "| Not on Business class on xmm016"
                wdetail2.pass    = "N"    
                WDETAIL2.OK_GEN  = "N".
        ELSE 
            ASSIGN    
                wdetail2.tariff =   sicsyac.xmm016.tardef
                no_class       =   sicsyac.xmm016.class
                nv_sclass      =   Substr(no_class,2,3).
    END.
    Find sicsyac.sym100 Use-index sym10001       Where
         sicsyac.sym100.tabcod = "u014"          AND 
         sicsyac.sym100.itmcod =  wdetail.vehuse No-lock no-error no-wait.
    IF not avail sicsyac.sym100 Then 
        ASSIGN
            wdetail2.comment = wdetail2.comment + "| Not on Vehicle Usage Codes table sym100 u014"
            wdetail2.pass    = "N" 
            WDETAIL2.OK_GEN  = "N".
     Find  sicsyac.sym100 Use-index sym10001  Where
         sicsyac.sym100.tabcod = "u013"         And
         sicsyac.sym100.itmcod = wdetail.covcod
         No-lock no-error no-wait.
     IF not avail sicsyac.sym100 Then 
         ASSIGN
             wdetail2.comment = wdetail2.comment + "| Not on Motor Cover Type Codes table sym100 u013"
             wdetail2.pass    = "N"    
             WDETAIL2.OK_GEN  = "N".
     /*---------- fleet -------------------*/
     IF inte(wdetail2.fleet) <> 0 AND INTE(wdetail2.fleet) <> 10 Then 
         ASSIGN
             wdetail2.comment = wdetail2.comment + "| Fleet Percent must be 0 or 10. "
             wdetail2.pass    = "N"    
             WDETAIL2.OK_GEN  = "N".
       
     /*----------  access -------------------*//*
     If  wdetail.access  =  "y"  Then do:  
         If  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
             nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
             Then  wdetail.access  =  "y".         
         Else do:
             Message "Class "  nv_sclass "ไม่รับอุปกรณ์เพิ่มพิเศษ"  View-as alert-box.
             ASSIGN
                 wdetail2.comment = wdetail2.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ"
                 wdetail2.pass    = "N"    
                 WDETAIL2.OK_GEN  = "N".
         End.
     END.   -------------A52-0172*/
     /*----------  ncb -------------------*/
     IF (DECI(wdetail.ncb) = 0 )  OR (DECI(wdetail.ncb) = 20 ) OR
        (DECI(wdetail.ncb) = 30 ) OR (DECI(wdetail.ncb) = 40 ) OR
        (DECI(wdetail.ncb) = 50 )    THEN DO:
     END.
     ELSE 
         ASSIGN
             wdetail2.comment = wdetail2.comment + "| not on NCB Rates file xmm104."
             wdetail2.pass    = "N"   
             WDETAIL2.OK_GEN  = "N".
     IF (wdetail.covcod = "2.1" ) THEN  
         ASSIGN  
         wdetail.ncb = "20"
         nv_ncb  = 20
         NV_NCBPER = 20.
     ELSE IF  (wdetail.covcod = "3.1" ) THEN  
         ASSIGN  
         wdetail.ncb = ""
         nv_ncb  = 0
         NV_NCBPER = 0.
     ELSE NV_NCBPER = INTE(WDETAIL.NCB).
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401 Where
             sicsyac.xmm104.tariff = wdetail2.tariff                      AND
             sicsyac.xmm104.class  = wdetail2.prempa + wdetail2.subclass   AND
             sicsyac.xmm104.covcod = wdetail.covcod           AND
             sicsyac.xmm104.ncbper = INTE(wdetail.ncb)
             No-lock no-error no-wait.
         IF not avail  sicsyac.xmm104  Then 
             ASSIGN
                 wdetail2.comment = wdetail2.comment + "| This NCB Step not on NCB Rates file xmm104. "
                 wdetail2.pass    = "N"     
                 WDETAIL2.OK_GEN  = "N".
        
     END. /*ncb <> 0*/
     /******* drivernam **********/
     nv_sclass = wdetail2.subclass. 
     If  wdetail2.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
         ASSIGN
             wdetail2.comment = wdetail2.comment + "| CODE  nv_sclass Driver 's Name must be no. "
             wdetail2.pass    = "N"    
             WDETAIL2.OK_GEN  = "N".
     
     /*------------- compul --------------*/ /*comment by kridtiya i. A52-0172
     IF wdetail.compul = "y" THEN DO:
         IF wdetail.stk = " " THEN DO:
             MESSAGE "ซื้อ พรบ ต้องมีหมายเลข Sticker".
             ASSIGN
                 wdetail2.comment = wdetail2.comment + "| ซื้อ พรบ ต้องมีหมายเลข Sticker"
                 wdetail2.pass    = "N"     
                 WDETAIL2.OK_GEN  = "N".
         END.
         /*STR amparat C. A51-0253--*/
         IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
         IF LENGTH(wdetail.stk) < 11 OR LENGTH(wdetail.stk) > 13 THEN DO:
             MESSAGE "เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น" VIEW-AS ALERT-BOX.
             ASSIGN /*a490166*/
                 wdetail2.comment = wdetail2.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
                 wdetail2.pass    = ""
                 WDETAIL2.OK_GEN  = "N".
         END.  /*END amparat C. A51-0253--*/
     END.   -----*/
   */ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest2 C-Win 
PROCEDURE 00-proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: ranu i. A64-0328 04/10/2021 เก็บ CC ที่นั่ง กลุ่มรถ ตามไฟล์ 
  comment by : A68-0061...    
------------------------------------------------------------------------------*/
/*OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "014: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
ASSIGN fi_process = "Process data HCT....sic_bran.uwm130,sic_bran.uwm301"  .
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
  sic_bran.uwm130.bchcnt  = nv_batcnt             NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN 
  DO TRANSACTION:
  CREATE sic_bran.uwm130.
  ASSIGN sic_bran.uwm130.policy = sic_bran.uwm120.policy
  sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
  sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
  sic_bran.uwm130.itemno = s_itemno
  sic_bran.uwm130.bchyr  = nv_batchyr       /* batch Year */
  sic_bran.uwm130.bchno  = nv_batchno       /* bchno      */
  sic_bran.uwm130.bchcnt = nv_batcnt        /* bchcnt     */
  sic_bran.uwm130.i_text = nv_cctvcode .    /* A63-00472 Add Code CCTV*/
  nv_sclass = wdetail2.subclass.
  IF nv_uom6_u  =  "A"  THEN DO:
     IF nv_sclass = "320" OR nv_sclass = "340" OR nv_sclass = "520" OR nv_sclass = "540" Then  nv_uom6_u  =  "A".         
     ELSE ASSIGN wdetail.pass    = "N"
         wdetail2.comment = wdetail2.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
  END.     
  IF CAPS(nv_uom6_u) = "A"  Then
     Assign  nv_uom6_u          = "A"
     nv_othcod                  = "OTH"
     nv_othvar1                 = "     Accessory  = "
     nv_othvar2                 =  STRING(nv_uom6_u)
     SUBSTRING(nv_othvar,1,30)  = nv_othvar1
     SUBSTRING(nv_othvar,31,30) = nv_othvar2.
  ELSE ASSIGN  nv_uom6_u  = ""
       nv_othcod      = ""
       nv_othvar1     = ""
       nv_othvar2     = ""
       SUBSTRING(nv_othvar,1,30)  = nv_othvar1
       SUBSTRING(nv_othvar,31,30) = nv_othvar2.
  IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR
     (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2")  THEN /*a62-0215*/
     ASSIGN sic_bran.uwm130.uom6_v   = IF      wdetail.covcod = "2.1" THEN inte(wdetail.tpfire)
                                       ELSE IF wdetail.covcod = "2.2" THEN inte(wdetail.tpfire) /*a62-0215*/
                                       ELSE IF wdetail.covcod = "3.1" THEN INTE(wdetail.deductda)  
                                       ELSE IF wdetail.covcod = "3.2" THEN INTE(wdetail.deductda)  /*a62-0215*/
                                       ELSE inte(wdetail.si)
     sic_bran.uwm130.uom7_v   = IF      wdetail.covcod = "2.1" THEN inte(wdetail.tpfire)
                                       ELSE IF wdetail.covcod = "2.2" THEN inte(wdetail.tpfire) /*a62-0215*/
                                       ELSE IF wdetail.covcod = "3.1" THEN 0 
                                       ELSE IF wdetail.covcod = "3.2" THEN 0  /*a62-0215*/
                                       ELSE inte(wdetail.si)
     sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
     sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
     sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
     sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
     sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
  IF wdetail.covcod = "2"  THEN 
      ASSIGN sic_bran.uwm130.uom6_v   = 0
      sic_bran.uwm130.uom7_v   = inte(wdetail.si)
      sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
      sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
      sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
      sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
      sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
  IF wdetail.covcod = "3"  THEN 
     ASSIGN sic_bran.uwm130.uom6_v  = 0
     sic_bran.uwm130.uom7_v   = 0
     sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
     sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
     sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
     sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
     sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
  IF wdetail2.poltyp = "v72" THEN  n_sclass72 = wdetail2.subclass.
  ELSE n_sclass72 = wdetail2.prempa + wdetail2.subclass .
  FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = wdetail.covcod No-lock  No-error No-wait.
  IF avail stat.clastab_fil Then do: 
     ASSIGN sic_bran.uwm130.uom1_v  = if int(wdetail.comper)   <> 0 then int(wdetail.comper)   else stat.clastab_fil.uom1_si
     sic_bran.uwm130.uom2_v  = if int(wdetail.comacc)   <> 0 then int(wdetail.comacc)   else stat.clastab_fil.uom2_si
     sic_bran.uwm130.uom5_v  = if int(wdetail.deductpd) <> 0 then int(wdetail.deductpd) else stat.clastab_fil.uom5_si
     sic_bran.uwm130.uom8_v  =  stat.clastab_fil.uom8_si                
     sic_bran.uwm130.uom9_v  =  stat.clastab_fil.uom9_si          
     sic_bran.uwm130.uom3_v  =  0
     sic_bran.uwm130.uom4_v  =  0
     wdetail.comper          =  string(stat.clastab_fil.uom8_si)                
     wdetail.comacc          =  string(stat.clastab_fil.uom9_si)
     nv_uom1_v               =  sic_bran.uwm130.uom1_v   
     nv_uom2_v               =  sic_bran.uwm130.uom2_v
     nv_uom5_v               =  sic_bran.uwm130.uom5_v        
     sic_bran.uwm130.uom1_c  = "D1"
     sic_bran.uwm130.uom2_c  = "D2"
     sic_bran.uwm130.uom5_c  = "D5"
     sic_bran.uwm130.uom6_c  = "D6"
     sic_bran.uwm130.uom7_c  = "D7".
     If  wdetail.garage  =  "G"  THEN 
     ASSIGN WDETAIL2.no_41   = if int(wdetail2.NO_41) <> 0 then wdetail2.NO_41 else string(stat.clastab_fil.si_41pai)                       
     WDETAIL2.no_42   = if int(wdetail2.NO_42) <> 0 then wdetail2.NO_42 else string(stat.clastab_fil.si_42)                         
     WDETAIL2.no_43   = if int(wdetail2.NO_43) <> 0 then wdetail2.NO_43 else string(stat.clastab_fil.impsi_43)    
     WDETAIL2.seat41  =  stat.clastab_fil.dri_41 + stat.clastab_fil.pass_41.     
     ELSE ASSIGN WDETAIL2.no_41 =  if int(wdetail2.NO_41) <> 0 then wdetail2.NO_41 else string(stat.clastab_fil.si_41unp)
          WDETAIL2.no_42    =  if int(wdetail2.NO_42) <> 0 then wdetail2.NO_42 else string(stat.clastab_fil.si_42)
          WDETAIL2.no_43    =  if int(wdetail2.NO_43) <> 0 then wdetail2.NO_43 else string(stat.clastab_fil.si_43)
          WDETAIL2.seat41   =  stat.clastab_fil.dri_41 + stat.clastab_fil.pass_41.                  
  END.
  ASSIGN nv_riskno = 1    nv_itemno = 1.
  IF wdetail.covcod = "1" Then 
      RUN wgs/wgschsum(INPUT  wdetail.policy, 
                       nv_riskno,
                       nv_itemno).
  END.  /* end Do transaction*/
  s_recid3  = RECID(sic_bran.uwm130).
  nv_covcod =   wdetail.covcod.
  nv_makdes  =  wdetail.brand.
  nv_moddes  =  wdetail.model.
  nv_newsck = " ".
  RUN proc_chassic.
  RUN proc_chassic_eng.
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
  sic_bran.uwm301.bchcnt = nv_batcnt  NO-WAIT NO-ERROR.
  IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
     DO TRANSACTION:
         CREATE sic_bran.uwm301.
     END. 
  END. 
  ASSIGN sic_bran.uwm301.policy    = sic_bran.uwm120.policy                 
  sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
  sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
  sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
  sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
  sic_bran.uwm301.itemno    = s_itemno
  sic_bran.uwm301.tariff    = wdetail2.tariff    
  sic_bran.uwm301.covcod    = nv_covcod
  sic_bran.uwm301.cha_no    = wdetail.chasno
  sic_bran.uwm301.trareg    = nv_uwm301trareg
  sic_bran.uwm301.eng_no    = wdetail.eng
  sic_bran.uwm301.Tons      = IF wdetail2.subclass = "320" THEN deci(wdetail.engcc) ELSE INTEGER(wdetail2.weight)
  sic_bran.uwm301.engine    = IF nv_cc <> 0 THEN nv_cc ELSE deci(wdetail.engcc) /*Ranu I. A64-0422 01/10/2021*/
  sic_bran.uwm301.vehgrp    = wdetail.cargrp /*ranu I. A64-0422 01/10/2021*/       
  sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear) 
  sic_bran.uwm301.garage    = wdetail.garage
  sic_bran.uwm301.body      = wdetail.body
  sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
  sic_bran.uwm301.mv_ben83  = wdetail.benname
  sic_bran.uwm301.vehreg    = wdetail.vehreg + nv_provi
  sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
  sic_bran.uwm301.vehuse    = wdetail.vehuse
  sic_bran.uwm301.moddes    = trim(wdetail.brand) + " " + trim(wdetail.model) + " " + trim(wdetail.carcode)    
  sic_bran.uwm301.sckno     = 0
  sic_bran.uwm301.itmdel    = NO
  sic_bran.uwm301.car_color = wdetail.colorcar
  sic_bran.uwm301.logbok    = IF wdetail2.TYPE_notify = "S" AND nv_covcod = "1" THEN "Y" ELSE IF wdetail2.producer = "B3M0070" THEN "Y" /*A67-0065*/ ELSE "". 
  wdetail2.tariff = sic_bran.uwm301.tariff .
  IF wdetail2.accdata <> "" THEN DO:  /*Add A56-0368 ....*/
     RUN proc_prmtxt.
     ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60) =  nv_acc1
         SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  nv_acc2
         SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  nv_acc3
         SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  nv_acc4
         SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  nv_acc5
         SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  nv_acc6. 
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
  ASSIGN  sic_bran.uwm301.bchyr     = nv_batchyr     /* batch Year */
         sic_bran.uwm301.bchno     = nv_batchno     /* bchno      */
         sic_bran.uwm301.bchcnt    = nv_batcnt      /* bchcnt     */
         wdetail.drivername1 = wdetail.ntitle1 + " " + wdetail.drivername1 + " " + wdetail.dname1 + " " + wdetail.dname2 
         wdetail.drivername2 = wdetail.ntitle2 + " " + wdetail.drivername2 + " " + wdetail.ddname1 + " " + wdetail.ddname2 . 
  IF trim(wdetail.flagno) = "0"  THEN DO:
     ASSIGN wdetail2.drivnam = "Y" .
     RUN proc_mailtxt.  /*A55-0151*/
  END.
  ELSE DO: 
         IF n_drivnam = "Y" AND nv_driver <> ""  THEN DO:
            RUN proc_mailtxt. 
         END.
         ELSE wdetail2.drivnam = "n".
         ASSIGN n_drivnam = "N"     nv_driver = ""      n_prmtdriv = 0      n_ndriv1  = "" n_bdate1   = ""     n_ndriv2  = ""      n_bdate2   = "" .
  END.
  ASSIGN s_recid4         = RECID(sic_bran.uwm301).
  IF wdetail2.redbook <> "" AND chkred = YES THEN DO:
         FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE 
             stat.maktab_fil.sclass = wdetail2.subclass  AND
             stat.maktab_fil.modcod = wdetail2.redbook   No-lock no-error no-wait.
         If  avail  stat.maktab_fil  Then 
             ASSIGN sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod 
             sic_bran.uwm301.body    =  stat.maktab_fil.body 
             sic_bran.uwm301.vehgrp  =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
             wdetail.cargrp          =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
             sic_bran.uwm301.engine  =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
             wdetail.engcc           =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
             sic_bran.uwm301.seats   =  IF sic_bran.uwm301.seats = 0  THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
     END.
     ELSE DO:
        FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
            makdes31.moddes =  wdetail2.prempa + wdetail2.subclass NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL makdes31  THEN ASSIGN n_ratmin = makdes31.si_theft_p  n_ratmax = makdes31.load_p   .    
        ELSE ASSIGN n_ratmin = 0   n_ratmax = 0.
        IF      INDEX(wdetail.model,"CIVIC") <> 0 THEN RUN proc_maktab.    /*A60-0505*/
        ELSE IF INDEX(wdetail.model,"CITY")  <> 0 THEN RUN proc_maktab.    /*A63-00472*/
        ELSE DO:
           Find First stat.maktab_fil USE-INDEX maktab04    Where
               stat.maktab_fil.makdes   =     wdetail.brand            And                  
               index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
               stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
               stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
               stat.maktab_fil.sclass   =     wdetail2.subclass        AND
               (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE  deci(wdetail.si)    AND
                stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE  deci(wdetail.si) )  AND  
               stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
           If  avail stat.maktab_fil  Then 
               ASSIGN wdetail2.redbook        =  stat.maktab_fil.modcod
                   sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                   sic_bran.uwm301.body    =  stat.maktab_fil.body 
                   sic_bran.uwm301.vehgrp  =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                   wdetail.cargrp          =  IF wdetail.cargrp = ""         THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                   sic_bran.uwm301.engine  =  IF sic_bran.uwm301.engine = 0  THEN stat.maktab_fil.engine    ELSE sic_bran.uwm301.engine  
                   wdetail.engcc           =  IF sic_bran.uwm301.engine = 0  THEN string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine) 
                   sic_bran.uwm301.seats   =  IF sic_bran.uwm301.seats = 0   THEN stat.maktab_fil.seats  ELSE sic_bran.uwm301.seats .
           IF wdetail2.redbook = "" THEN DO:
                    Find First stat.maktab_fil USE-INDEX maktab04    Where
                        stat.maktab_fil.makdes   =     wdetail.brand            And                  
                        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                        stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                        stat.maktab_fil.sclass   =     wdetail2.subclass        AND
                        (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE  deci(wdetail.si)    AND
                         stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE  deci(wdetail.si) )  No-lock no-error no-wait.
                    If  avail stat.maktab_fil  THEN 
                        ASSIGN  wdetail2.redbook        =  stat.maktab_fil.modcod
                        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod  
                        sic_bran.uwm301.body    =  stat.maktab_fil.body 
                        sic_bran.uwm301.vehgrp  =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                        wdetail.cargrp          =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                        sic_bran.uwm301.engine  =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
                        wdetail.engcc           =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE STRING(sic_bran.uwm301.engine)  
                        sic_bran.uwm301.seats   =  IF sic_bran.uwm301.seats = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
                    IF wdetail2.redbook = "" THEN  RUN proc_maktab3.
                END.
             END.
             IF nv_covcod <> "1" AND wdetail2.redbook = "" THEN  RUN proc_maktab2.
         END.
         IF wdetail2.redbook  = ""  THEN RUN proc_maktab.
         IF index(trim(wdetail.model) +  trim(wdetail.carcode),"HATCHBACK") <> 0 THEN  sic_bran.uwm301.body  = "HATCHBACK".*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_mailtxt C-Win 
PROCEDURE 00-proc_mailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A68-0061...
IF  wdetail2.drivnam = "Y" THEN DO :      /*note add 07/11/2005*/

 DEF VAR no_policy AS CHAR FORMAT "x(20)" .
 DEF VAR no_rencnt AS CHAR FORMAT "99".
 DEF VAR no_endcnt AS CHAR FORMAT "999".
 
 DEF VAR no_riskno AS CHAR FORMAT "999".
 DEF VAR no_itemno AS CHAR FORMAT "999".
 DEF VAR no_sex1    AS CHAR INIT "".
 DEF VAR no_sex2    AS CHAR INIT "".

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
  ASSIGN no_sex1 = "MALE"  
         no_sex2 = "MALE". 
  IF INDEX(wdetail.drivername1,"นางสาว") <> 0 OR INDEX(wdetail.drivername1,"นาง")  <> 0 OR
     INDEX(wdetail.drivername1,"น.ส.")   <> 0 OR INDEX(wdetail.drivername1,"หญิง") <> 0 THEN no_sex1 = "FEMALE".
  IF INDEX(wdetail.drivername2,"นางสาว") <> 0 OR INDEX(wdetail.drivername2,"นาง")  <> 0 OR
     INDEX(wdetail.drivername2,"น.ส.")   <> 0 OR INDEX(wdetail.drivername2,"หญิง") <> 0 THEN no_sex2 = "FEMALE".
  
  FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
               brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
               brstat.mailtxt_fil.bchyr   = nv_batchyr   AND                                               
               brstat.mailtxt_fil.bchno   = nv_batchno   AND
               brstat.mailtxt_fil.bchcnt  = nv_batcnt    NO-LOCK  NO-ERROR  NO-WAIT.
        IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.                                                      


        FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                     brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno     AND
                     brstat.mailtxt_fil.lnumber = nv_lnumber    AND
                     brstat.mailtxt_fil.bchyr   = nv_batchyr    AND                                               
                     brstat.mailtxt_fil.bchno   = nv_batchno    AND
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt     NO-LOCK  NO-ERROR  NO-WAIT.
        IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
              CREATE brstat.mailtxt_fil.
              ASSIGN                                           
                     brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                     brstat.mailtxt_fil.lnumber   = nv_lnumber.
                     brstat.mailtxt_fil.ltext     = wdetail.drivername1 + FILL(" ",50 - LENGTH(wdetail.drivername1)) .
                     SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = no_sex1. 
                     brstat.mailtxt_fil.ltext2 = wdetail.dbirth + "  " + string(nv_drivage1) .
                     /*brstat.mailtxt_fil.ltext2 = TRIM(brstat.mailtxt_fil.ltext2).
                     brstat.mailtxt_fil.ltext2 = brstat.mailtxt_fil.ltext2 + FILL(" ",15  - LENGTH(brstat.mailtxt_fil.ltext2)) + "-" .*/ /*TRIM(namtxt.occup)*/
                     nv_drivno                    = 1.
               ASSIGN 
                    brstat.mailtxt_fil.bchyr   = nv_batchyr 
                    brstat.mailtxt_fil.bchno   = nv_batchno 
                    brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                    SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"                        
                    SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = trim(wdetail.dicno)       
                    SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.ddriveno)  . 
              IF wdetail.drivername2 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil. 
                    ASSIGN
                        brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                        brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                        brstat.mailtxt_fil.ltext    = wdetail.drivername2 + FILL(" ",50 - LENGTH(wdetail.drivername2)) 
                        SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = no_sex2
                        brstat.mailtxt_fil.ltext2   = wdetail.ddbirth + "  " + TRIM(string(nv_drivage2)).
                        /*brstat.mailtxt_fil.ltext2   = TRIM(brstat.mailtxt_fil.ltext2).
                        brstat.mailtxt_fil.ltext2   = brstat.mailtxt_fil.ltext2 + FILL(" ",15  - LENGTH(brstat.mailtxt_fil.ltext2)) + "-" .*/ 
                        nv_drivno                   = 2.
                    ASSIGN 
                        brstat.mailtxt_fil.bchyr   = nv_batchyr 
                        brstat.mailtxt_fil.bchno   = nv_batchno 
                        brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                        SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"    
                        SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = trim(wdetail.ddicno)       
                        SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.dddriveno)   .

              END.  /*drivnam2 <> " " */
        END. /*End Avail Brstat*/
        ELSE  DO:
              CREATE  brstat.mailtxt_fil.
              ASSIGN  brstat.mailtxt_fil.policy     = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + 
                                                      string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
                      brstat.mailtxt_fil.lnumber    = nv_lnumber
                     /*--    Add by Nary A54-0396 --*/
                      brstat.mailtxt_fil.ltext      = wdetail.drivername1 + FILL(" ",50 - LENGTH(wdetail.drivername1))
                      SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = no_sex1
                      /*--End Add by Nary A54-0396 --*/
                      brstat.mailtxt_fil.ltext2     = wdetail.dbirth + "  "
                                                    +  TRIM(string(nv_drivage1))
                      SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"                        
                      SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = trim(wdetail.dicno)       
                      SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.ddriveno)  . 

                      IF wdetail.drivername2 <> "" THEN DO:
                            CREATE  brstat.mailtxt_fil.
                                ASSIGN
                                brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                                brstat.mailtxt_fil.ltext    = wdetail.drivername2 + FILL(" ",50 - LENGTH(wdetail.drivername2))
                                SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = no_sex2
                                brstat.mailtxt_fil.ltext2   = wdetail.ddbirth + "  "
                                                            + TRIM(string(nv_drivage2))
                                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"    
                                SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = trim(wdetail.ddicno)       
                                SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.dddriveno)   .
                      END. /*drivnam2 <> " " */
             ASSIGN
                brstat.mailtxt_fil.bchyr   = nv_batchyr 
                brstat.mailtxt_fil.bchno   = nv_batchno 
                brstat.mailtxt_fil.bchcnt  = nv_batcnt .
        END. /*Else DO*/
 END. /*note add for mailtxt 07/11/2005*/
 ELSE DO:
     ASSIGN
      nv_drivage1 =  YEAR(TODAY) - (INT(SUBSTR(n_bdate1,7,4)) - 543)  
      nv_drivage2 =  YEAR(TODAY) - (INT(SUBSTR(n_bdate2,7,4)) - 543) .

     IF n_drivnam = "Y" THEN DO:
        FOR EACH ws0m009 WHERE ws0m009.policy  = nv_driver NO-LOCK .
          CREATE brstat.mailtxt_fil.
          ASSIGN
              brstat.mailtxt_fil.policy  = TRIM(sic_bran.uwm301.policy) +
                           STRING(sic_bran.uwm301.rencnt,"99" ) +
                           STRING(sic_bran.uwm301.endcnt,"999")  +
                           STRING(sic_bran.uwm301.riskno,"999") +
                           STRING(sic_bran.uwm301.itemno,"999")    
              brstat.mailtxt_fil.lnumber = INTEGER(ws0m009.lnumber)
              brstat.mailtxt_fil.ltext   = ws0m009.ltext  
              /*brstat.mailtxt_fil.ltext2  = ws0m009.ltext2 */
              brstat.mailtxt_fil.bchyr   = nv_batchyr 
              brstat.mailtxt_fil.bchno   = nv_batchno 
              brstat.mailtxt_fil.bchcnt  = nv_batcnt .

          ASSIGN substr(brstat.mailtxt_fil.ltext2,1,15)   = IF ws0m009.lnumber = 1 THEN  trim(n_bdate1) + "  " + trim(string(nv_drivage1,"99"))  /*ws0m009.ltext2 */ 
                                                            ELSE trim(n_bdate2) + "  " + trim(string(nv_drivage2)) 
                 substr(brstat.mailtxt_fil.ltext2,16,250) = SUBSTR(ws0m009.ltext2,16,250) .

          ASSIGN nv_drivno = INTEGER(ws0m009.lnumber).

        END.
        IF nv_drivno <> 0 THEN DO:
          ASSIGN wdetail2.drivnam      = "Y" 
                 sic_bran.uwm301.actprm = n_prmtdriv
                 wdetail.drivername1 = trim(n_ndriv1)
                 wdetail.drivername2 = trim(n_ndriv2) .
        END.
     END.
        
 END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_policy_bk C-Win 
PROCEDURE 00-proc_policy_bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*ASSIGN fi_process = "Import data HCT...." + wdetail.policyno .   
DISP fi_process WITH FRAM fr_main.
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
IF wdetail2.poltyp = "v72" THEN n_rencnt = 0.  
IF wdetail.policyno <> "" THEN DO:
  IF wdetail.stk  <>  ""  THEN DO: 
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
    ELSE chr_sticker = wdetail.stk.
    chk_sticker = chr_sticker.
    RUN wuz\wuzchmod.
    IF chk_sticker  <>  chr_sticker  Then ASSIGN  wdetail2.pass    = "N"
        wdetail2.comment = wdetail2.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error". 
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
      sicuw.uwm100.cedpol = trim(substr(wdetail.policyno,2,12) + "-" + wdetail2.comrequest) AND 
      sicuw.uwm100.poltyp = wdetail2.poltyp NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
        ASSIGN  wdetail2.pass    = "N"
                wdetail2.comment = wdetail2.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "    
                wdetail2.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.
    nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
    ELSE wdetail.stk = wdetail.stk.
    FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
      stat.detaitem.serailno = trim(wdetail.stk) NO-LOCK NO-ERROR.
    IF AVAIL stat.detaitem THEN  
      ASSIGN  wdetail2.pass    = "N"
              wdetail2.comment = wdetail2.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"  
              wdetail2.warning = "Program Running Policy No. ให้ชั่วคราว".
    IF wdetail.policyno = "" THEN DO:
      RUN proc_temppolicy.
      wdetail.policyno  = nv_tmppol.
    END.
    RUN proc_create100.
  END.
  ELSE DO: /*sticker = ""*/ 
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
              sicuw.uwm100.cedpol = trim(substr(wdetail.policyno,2,12) + "-" + wdetail2.comrequest) AND 
              sicuw.uwm100.poltyp = wdetail2.poltyp  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES THEN 
          ASSIGN wdetail2.pass    = "N"
          wdetail2.comment = wdetail2.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  
          wdetail2.warning = "Program Running Policy No. ให้ชั่วคราว".
      IF wdetail.policyno = "" THEN DO:
          RUN proc_temppolicy.
          wdetail.policyno  = nv_tmppol.
      END.
      RUN proc_create100. 
    END.   /*policy <> "" & stk = ""*/                 
    ELSE RUN proc_create100. 
  END.
END.
ELSE DO:  /*wdetail.policyno = ""*/
  IF wdetail.stk  <>  ""  THEN DO:
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
    ELSE chr_sticker = wdetail.stk.
    chk_sticker = chr_sticker.
    RUN wuz\wuzchmod.
    IF chk_sticker  <>  chr_sticker  Then 
      ASSIGN  wdetail2.pass    = "N"
      wdetail2.comment = wdetail2.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".  
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
        sicuw.uwm100.cedpol = trim(substr(wdetail.policyno,2,12) + "-" + wdetail2.comrequest) AND 
        sicuw.uwm100.poltyp = wdetail2.poltyp  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
        ASSIGN  wdetail2.pass    = "N"
        wdetail2.comment = wdetail2.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
        wdetail2.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.
    nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
    ELSE wdetail.stk = wdetail.stk.
    FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
      stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
    IF AVAIL stat.detaitem THEN 
      ASSIGN  wdetail2.pass    = "N"
      wdetail2.comment = wdetail2.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
      wdetail2.warning = "Program Running Policy No. ให้ชั่วคราว".
    IF wdetail.policyno = "" THEN DO:
      RUN proc_temppolicy.
      wdetail.policyno  = nv_tmppol.
    END.
    RUN proc_create100.
  END.
  ELSE DO: 
    IF wdetail.policyno = "" THEN DO:
      RUN proc_temppolicy.
      wdetail.policyno  = nv_tmppol.
    END.
    RUN proc_create100.
  END.
END.
s_recid1  =  Recid(sic_bran.uwm100).
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = wdetail2.poltyp  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL  sicsyac.xmm031 THEN nv_dept = sicsyac.xmm031.dept.
IF wdetail2.poltyp = "V70"  AND wdetail2.Docno <> ""  THEN ASSIGN  nv_docno  = wdetail2.Docno   nv_accdat = TODAY.
ELSE DO:
  IF wdetail2.docno  = "" THEN nv_docno  = "".
  IF wdetail2.accdat = "" THEN nv_accdat = TODAY.
END.
IF DECI(substr(wdetail.comdat,7,4)) > (YEAR(TODAY) + 2)  THEN wdetail.comdat = substr(wdetail.comdat,1,6) + STRING(DECI(substr(wdetail.comdat,7,4)) - 543).
IF DECI(substr(wdetail.expdat,7,4)) > (YEAR(TODAY) + 3)  THEN wdetail.expdat = substr(wdetail.expdat,1,6) + STRING(DECI(substr(wdetail.expdat,7,4)) - 543).
IF wdetail.prepol = "" THEN n_firstdat = DATE(wdetail.comdat). 
IF wdetail2.TYPE_notify = "N" THEN DO: 
  IF wdetail2.detailcam  = "" THEN ASSIGN wdetail2.special2 = " ". 
  ELSE IF INDEX(wdetail2.detailcam,"CAMPAIGN") <> 0 THEN ASSIGN wdetail2.special2 = TRIM(SUBSTR(wdetail2.detailcam,1,INDEX(wdetail2.detailcam," "))).
  ELSE wdetail2.special2 = TRIM(wdetail2.detailcam). 
END.
ELSE DO:
  IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 4 ) AND (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 7 ) AND 
      (wdetail2.poltyp = "v70") AND (trim(wdetail.brand) = "HONDA") AND (wdetail.garage <> "") THEN DO:
    IF  wdetail.covcod = "1"  THEN DO: 
      IF DATE(wdetail.comdat) < 01/01/2020 THEN wdetail2.special2 = "IPA". ELSE wdetail2.special2 = "CLAIMDI".  
    END.
    ELSE IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.1") OR (wdetail.covcod = "3.2") THEN DO:
        /*IF wdetail2.producer = "B3M0023" OR wdetail2.producer = "B3M0017" OR wdetail2.producer = "B3M0038" OR wdetail2.producer = "B300125" THEN DO:*/ /*A63-0443*/
      IF wdetail2.producer = "B3M0062" OR wdetail2.producer = "B3M0064" OR wdetail2.producer = "B3M0065" OR wdetail2.producer = "B3M0058" THEN DO: /*A63-0443*/
          IF DATE(wdetail.comdat) < 01/01/2020 THEN wdetail2.special2 = "IPA". ELSE wdetail2.special2 = "CLAIMDI". 
      END.
      ELSE wdetail2.special2 = "".
    END.
    ELSE wdetail2.special2 = " ".
  END.
  ELSE IF wdetail2.detailcam <> "" THEN RUN proc_detailcampromo.
  ELSE wdetail2.special2 = "".
END.
RUN proc_insnam.  
RUN proc_insnam2.  /*Add by Kridtiya i. A63-0472*/
IF wdetail3.instot = 1 THEN DO:
  ASSIGN wdetail2.typrequest = "" .
  IF (trim(wdetail2.voictitle) = "0")  THEN DO:
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
      stat.insure.compno = "HCT" AND
      stat.insure.lname  = wdetail2.voicnam   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL stat.insure THEN  
      ASSIGN wdetail2.voicnam   = trim(stat.insure.fname)
      wdetail2.typrequest   = trim(stat.insure.vatcode).  /*เปลี่ยน เป็นเก็บค่า vatcode.*/
    IF (INDEX(wdetail2.voicnam,wdetail.insnam) <>  0 ) THEN  wdetail2.voicnam = "".  
    ELSE ASSIGN wdetail2.name4  = "และ/หรือ " + TRIM(wdetail2.voicnam).
  END.
  ELSE IF wdetail2.voictitle = "1" THEN wdetail2.typrequest  = "".  /*ลูกค้า*/
  ELSE RUN proc_policyname3.  
END.
ELSE DO: /*wdetail3.instot = 1*/
  ASSIGN wdetail2.typrequest = "".
  IF index(trim(wdetail3.companyre2),trim(wdetail.insnam)) = 0 THEN DO:
    IF index(trim(wdetail3.companyre3),trim(wdetail.insnam)) <> 0 THEN 
        ASSIGN wdetail3.companyre3 = trim(nv_insref) + " " + trim(wdetail3.companyre3).
  END.
  ELSE ASSIGN wdetail3.companyre2 = trim(nv_insref) + " " + trim(wdetail3.companyre2).
END.
IF DATE(wdetail.comdat) < 04/01/2020 THEN DO: /* a63-0112 */
  IF      index(wdetail2.detailcam,"super pack")    <> 0  THEN RUN proc_policyname4.  /*A61-0324*/ 
  ELSE IF index(wdetail2.detailcam,"Triple Pack")   <> 0  THEN RUN proc_policyname4.  /*A62-0493*/
END.
IF (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2")   THEN RUN proc_policyname4. /*A63-0443*/
IF index(wdetail2.detailcam,"HEI 20-D")           <> 0    THEN RUN proc_policyname4. /*A63-0206*/
ELSE IF index(wdetail2.detailcam,"HATC CAMPAIGN") <> 0    THEN RUN proc_policyname4. /*A63-0206*/
ELSE IF trim(wdetail2.detailcam) <> ""  THEN RUN proc_policyname4. /* A64-0328 */
IF nv_insref = ""  THEN 
    ASSIGN wdetail2.comment = wdetail2.comment + "|รหัสลูกค้าเป็นค่าว่าง เช็ครันนิ่ง insured code (XZM056) สาขา " + wdetail2.n_branch 
           wdetail2.pass    = "N" 
           WDETAIL2.OK_GEN  = "N" .
DO TRANSACTION:
  ASSIGN
    sic_bran.uwm100.renno  = ""
    sic_bran.uwm100.endno  = ""
    sic_bran.uwm100.poltyp = wdetail2.poltyp
    sic_bran.uwm100.insref = trim(nv_insref)                         /* A55-0268 */ 
    sic_bran.uwm100.opnpol = IF TRIM(wdetail3.camp_no) = "" THEN CAPS(TRIM(wdetail3.payment_type)) 
                             ELSE trim(CAPS(TRIM(wdetail3.payment_type)) + " " + CAPS(TRIM(wdetail3.camp_no))) /*a60-0498*/
    sic_bran.uwm100.anam2  = trim(wdetail.Icno)                    /* ICNO  Cover Note A51-0071 Amparat */
    sic_bran.uwm100.ntitle = wdetail.tiname              
    sic_bran.uwm100.name1  = wdetail.insnam + " " + wdetail.name3              
    sic_bran.uwm100.name2  = wdetail2.name4                         /*A57-0073*/
    sic_bran.uwm100.name3  = wdetail3.name3                 
    sic_bran.uwm100.addr1  = wdetail.addr               
    sic_bran.uwm100.addr2  = wdetail.tambon                 
    sic_bran.uwm100.addr3  = wdetail.amper                  
    sic_bran.uwm100.addr4  = wdetail.country 
    sic_bran.uwm100.undyr  = String(Year(today),"9999")           /*  nv_undyr  */
    sic_bran.uwm100.branch = wdetail2.n_branch                    /* nv_branch  */                        
    sic_bran.uwm100.dept   = nv_dept
    sic_bran.uwm100.usrid  = USERID(LDBNAME(1))
    sic_bran.uwm100.fstdat = n_firstdat                       /*kridtiya i. a53-0220*/
    sic_bran.uwm100.comdat = DATE(wdetail.comdat)
    sic_bran.uwm100.expdat = date(wdetail.expdat)
    sic_bran.uwm100.accdat = nv_accdat                    
    sic_bran.uwm100.tranty = "N"                              /*Transaction Type (N/R/E/C/T)*/
    sic_bran.uwm100.langug = "T"
    sic_bran.uwm100.acctim = "00:00"
    sic_bran.uwm100.trty11 = "M"      
    sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")     
    sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")
    sic_bran.uwm100.entdat = TODAY
    sic_bran.uwm100.curbil = "BHT"
    sic_bran.uwm100.curate = 1
    sic_bran.uwm100.instot = wdetail3.instot                  /*A58-0197*/
    sic_bran.uwm100.prog   = "wgwhcgen"
    sic_bran.uwm100.cntry  = "TH"                  /*Country where risk is situated*/
    sic_bran.uwm100.insddr = YES                   /*Print Insd. Name on DrN       */
    sic_bran.uwm100.no_sch = 0                     /*No. to print, Schedule        */
    sic_bran.uwm100.no_dr  = 1                     /*No. to print, Dr/Cr Note      */
    sic_bran.uwm100.no_ri  = 0                     /*No. to print, RI Appln        */
    sic_bran.uwm100.no_cer = 0                     /*No. to print, Certificate     */
    sic_bran.uwm100.li_sch = YES                   /*Print Later/Imm., Schedule    */
    sic_bran.uwm100.li_dr  = YES                   /*Print Later/Imm., Dr/Cr Note  */
    sic_bran.uwm100.li_ri  = YES                   /*Print Later/Imm., RI Appln,   */
    sic_bran.uwm100.li_cer = YES                   /*Print Later/Imm., Certificate */
    sic_bran.uwm100.apptax = YES                   /*Apply risk level tax (Y/N)    */
    sic_bran.uwm100.recip  = "N"                   /*Reciprocal (Y/N/C)            */
    sic_bran.uwm100.short  = NO                    
    sic_bran.uwm100.acno1  = wdetail2.producer               /*Kridtiya i. A55-0151*/
    sic_bran.uwm100.agent  = fi_agent           /*nv_agent   */
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
    sic_bran.uwm100.dir_ri =  YES
    sic_bran.uwm100.drn_p  =  NO
    sic_bran.uwm100.sch_p  =  NO
    sic_bran.uwm100.cr_1   = trim(wdetail2.special2)  /* Product */
    sic_bran.uwm100.cr_2   = wdetail2.cr_2
    sic_bran.uwm100.bchyr  = nv_batchyr          /*Batch Year */  
    sic_bran.uwm100.bchno  = nv_batchno          /*Batch No.  */  
    sic_bran.uwm100.bchcnt = nv_batcnt           /*Batch Count*/  
    sic_bran.uwm100.prvpol = wdetail.prepol      /*A52-0172   */
    sic_bran.uwm100.cedpol = substr(wdetail.policyno,2,12) + "-" + wdetail2.comrequest
    sic_bran.uwm100.finint = wdetail2.n_delercode 
    sic_bran.uwm100.dealer = wdetail3.financecd      /*Add by Kridtiya i. A63-0472*/
    sic_bran.uwm100.bs_cd  = wdetail2.typrequest     /*add kridtiya i. A53-0027 เพิ่ม Vatcode*/
    sic_bran.uwm100.occupn  = trim(wdetail.occup)     /*A55-0274  อาชีพ*/
    sic_bran.uwm100.endern  = date(wdetail2.ac_date)   /*add kridtiya i. A53-0171 เพิ่มวันที่รับเงิน*/
    sic_bran.uwm100.firstName  = TRIM(wdetail3.firstName)     /*Add by Kridtiya i. A63-0472*/ 
    sic_bran.uwm100.lastName   = TRIM(wdetail3.lastName)      /*Add by Kridtiya i. A63-0472*/ 
    sic_bran.uwm100.postcd     = trim(wdetail.post)           /*Add by Kridtiya i. A63-0472*/ 
    sic_bran.uwm100.icno       = trim(wdetail.icno)           /*Add by Kridtiya i. A63-0472*/ 
    sic_bran.uwm100.codeocc    = trim(wdetail3.codeocc)       /*Add by Kridtiya i. A63-0472*/ 
    sic_bran.uwm100.codeaddr1  = TRIM(wdetail3.codeaddr1)     /*Add by Kridtiya i. A63-0472*/
    sic_bran.uwm100.codeaddr2  = TRIM(wdetail3.codeaddr2)     /*Add by Kridtiya i. A63-0472*/
    sic_bran.uwm100.codeaddr3  = trim(wdetail3.codeaddr3)     /*Add by Kridtiya i. A63-0472*/
    /*sic_bran.uwm100.br_insured = "00000"                    /*Add by Kridtiya i. A63-0472*/*/
    sic_bran.uwm100.campaign   = trim(wdetail2.producer)  .   /*Add by Kridtiya i. A63-0472*/
  IF wdetail2.special2 = "TMSTH 0%" OR wdetail2.special2 = "DEMON_H"  THEN sic_bran.uwm100.opnpol = trim(wdetail2.special2) .
  ELSE IF trim(wdetail2.producer) <> "B3M0062" AND trim(wdetail2.producer) <> "B3M0064" AND trim(wdetail2.producer) <> "B3M0065" THEN DO:
    ASSIGN  sic_bran.uwm100.cr_1   = IF wdetail2.producer = "B3M0066" THEN "ADDON1K" ELSE ""
                 sic_bran.uwm100.opnpol = trim(wdetail2.special2) .
  END.
  ELSE IF trim(wdetail2.producer) = "B3M0065" AND wdetail.prepol <> "" THEN sic_bran.uwm100.opnpol = "RSWITCH".  /*A63-00472*/
  ELSE IF trim(wdetail2.producer) = "B3M0065"                          THEN sic_bran.uwm100.opnpol = "SWITCH".   /*A63-00472*/
  IF wdetail.prepol <> " " THEN DO:
          IF wdetail2.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = ""  sic_bran.uwm100.tranty  = "R".  
          ELSE 
              ASSIGN sic_bran.uwm100.prvpol = wdetail.prepol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                sic_bran.uwm100.tranty      = "R".               /*Transaction Type (N/R/E/C/T)*/
      END.
      IF   wdetail2.pass = "Y" THEN sic_bran.uwm100.impflg  = YES.
      ELSE sic_bran.uwm100.impflg  = NO.
      IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
      IF wdetail2.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
      ELSE sic_bran.uwm100.polsta = "IF".
      IF fi_loaddat <> ? THEN  sic_bran.uwm100.trndat = fi_loaddat.
      ELSE sic_bran.uwm100.trndat = TODAY.
      sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
      nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                    ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.  
      
END.  /*transaction*/
RUN proc_uwd100.
RUN proc_uwd102.
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
        sic_bran.uwm120.bchyr  = nv_batchyr     /* batch Year */
        sic_bran.uwm120.bchno  = nv_batchno     /* bchno      */
        sic_bran.uwm120.bchcnt = nv_batcnt .    /* bchcnt     */
        ASSIGN sic_bran.uwm120.class  = IF wdetail2.poltyp = "v72" THEN wdetail2.subclass ELSE wdetail2.prempa + wdetail2.subclass 
            s_recid2     = RECID(sic_bran.uwm120).
    END. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 01-proc_assign2 C-Win 
PROCEDURE 01-proc_assign2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: comment by A68-0061...       
------------------------------------------------------------------------------*/
/*DEF VAR  name2    AS CHAR FORMAT "x(60)" INIT "" .  /*ranu*/
DEF VAR  name3    AS CHAR FORMAT "x(60)" INIT "" .  /*ranu*/
DEF VAR  delname  AS CHAR FORMAT "x(60)" INIT "" .  /*ranu*/
DEF VAR  b_eng    AS DECI FORMAT  ">>>>9.99-".
DEF VAR  n_date   AS CHAR FORMAT  "x(10)".
DEF VAR  n_garage72 AS CHAR FORMAT  "x(10)".
DEF VAR  n_classev  AS CHAR FORMAT  "x(10)".
FOR EACH wdetail WHERE wdetail.policyno NE " "  .
    FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno . 
        FOR EACH wdetail3 WHERE wdetail3.policyno = wdetail.policyno . 
        ASSIGN n_firstdat = ?   /*A53-0220....*/
        n_producer       = ""   
        n_textfi         = ""    /*A540125*/
        n_date           = STRING(TODAY,"99/99/9999")
        b_eng            = round((DECI(wdetail.engcc) / 1000),1)     /*format engcc */
        b_eng            = b_eng * 1000
        wdetail.seat     = IF INTEGER(wdetail.seat) = 0 THEN  "7" ELSE wdetail.seat
        wdetail2.tariff  = IF wdetail2.poltyp = "v72" THEN "9" ELSE "x" 
        wdetail2.prempa  = IF      wdetail.covcod = "5" THEN fi_packpuls   /*A57-0126 add covcod 2.1,3.1 */
                           ELSE IF wdetail.covcod = "9" THEN fi_packpuls   /*A57-0126 add covcod 2.1,3.1 */
                           ELSE IF (wdetail.garage = "GARAGE") AND (wdetail.covcod = "1")  THEN fi_packnogar
                           ELSE IF (wdetail.garage = "honda")  AND (wdetail.covcod = "1")  THEN fi_packgarage
                           ELSE IF (wdetail.covcod = "3")      THEN fi_packcov3
                           ELSE fi_packgarage
        /*wdetail.garage   = IF       (wdetail.covcod = "5") AND (wdetail.garage = "honda") AND (wdetail2.poltyp = "v70") THEN "G" 
                           ELSE IF  (wdetail.covcod = "9") AND (wdetail.garage = "honda") AND (wdetail2.poltyp = "v70") THEN "G" 
                           ELSE IF (wdetail.garage = "honda") AND (wdetail2.poltyp = "v70") THEN "G" ELSE " "  /*A57-0176*/   */
        wdetail.country  = wdetail.country                          /*Add by Kridtiya i. A63-0472*/
        wdetail.covcod   = IF      wdetail.covcod = "0" THEN "T" 
                           ELSE IF wdetail.covcod = "T" THEN "T" 
                           ELSE IF wdetail.covcod = "5" AND deci(wdetail.deduct) = 2000 THEN "2.1"         /* ranu :A67-0065 */
                           ELSE IF wdetail.covcod = "5" AND (deci(wdetail.deduct) = 0 OR wdetail.deduct = "" ) THEN "2.2"   /* ranu :A67-0065 */
                           ELSE IF wdetail.covcod = "9" AND deci(wdetail.deduct) = 2000 THEN "3.1"        /* ranu :A67-0065 */
                           ELSE IF wdetail.covcod = "9" AND (deci(wdetail.deduct) = 0 OR wdetail.deduct = "" ) THEN "3.2"     /* ranu :A67-0065 */
                           ELSE    wdetail.covcod .
        IF wdetail2.poltyp = "v70" THEN DO:
            IF      (wdetail.covcod = "5") AND (wdetail.garage = "honda") AND (wdetail2.poltyp = "v70") THEN wdetail.garage   = "G" .
            ELSE IF (wdetail.covcod = "9") AND (wdetail.garage = "honda") AND (wdetail2.poltyp = "v70") THEN wdetail.garage   = "G" .
            ELSE IF (wdetail.garage = "honda") AND (wdetail2.poltyp = "v70") THEN wdetail.garage   = "G"  .
            ELSE  wdetail.garage   = ""  .
        END.
        ELSE 
            ASSIGN n_garage72 = ""
                n_garage72 = wdetail.garage.
        IF wdetail.prepol <> "" THEN RUN proc_cutchar.
        /* ranu :A67-0065 */ 
        IF wdetail.covcod = "2.2" AND wdetail.deduct = "2000"  THEN wdetail.covcod =  "2.1" .                
        ELSE IF wdetail.covcod = "3.2" AND wdetail.deduct = "2000"  THEN wdetail.covcod =  "3.1" . 
        /*IF trim(wdetail2.detailcam) = "" AND wdetail2.brrequest = "HATC-S" THEN ASSIGN wdetail2.detailcam = "HATC-S" .*/
        IF wdetail.insnam = "ฮอนด้า ออโตโมบิล (ประเทศไทย) จำกัด" AND wdetail.saletyp = "N" AND 
          (wdetail2.TYPE_notify = "S" OR wdetail2.TYPE_notify = "R" ) THEN DO:
            ASSIGN wdetail2.producer = "B3M0070"
                   wdetail2.fleet    = "10" 
                   wdetail.garage    = "G"  .
          IF wdetail.covcod =  "2.1" OR wdetail.covcod = "2.2" OR wdetail.covcod =  "3.1" OR wdetail.covcod = "3.2" THEN DO:
              ASSIGN 
                   wdetail.comper    = "500000"
                   wdetail.comacc    = "10000000"
                   wdetail.deductpd  = "5000000"
                   WDETAIL2.no_41    = "200000"                   
                   WDETAIL2.no_42    = "200000"                   
                   WDETAIL2.no_43    = "300000" .
          END.
        END.
        ELSE IF index(wdetail2.detailcam,"N1-EV") <> 0 OR  index(wdetail.model,"e:N1") <> 0 THEN DO:
            ASSIGN wdetail2.producer = "B3M0071".
            IF INDEX(TRIM(wdetail.tiname),"บริษัท")       <> 0  OR INDEX(TRIM(wdetail.tiname),"บจก.")              <> 0 OR   
               INDEX(TRIM(wdetail.tiname),"หจก.")         <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้าง")              <> 0 OR  
               R-INDEX(TRIM(wdetail.insnam),"จก.")        <> 0  OR R-INDEX(TRIM(wdetail.insnam),"จำกัด")           <> 0 OR  
               R-INDEX(TRIM(wdetail.insnam),"(มหาชน)")    <> 0  OR R-INDEX(TRIM(wdetail.insnam),"INC.")            <> 0 OR 
               R-INDEX(TRIM(wdetail.insnam),"CO.")        <> 0  OR R-INDEX(TRIM(wdetail.insnam),"LTD.")            <> 0 OR 
               R-INDEX(TRIM(wdetail.insnam),"LIMITED")    <> 0  OR INDEX(TRIM(wdetail.tiname),"มูลนิธิ")           <> 0 OR 
               INDEX(TRIM(wdetail.tiname),"บ.")           <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0 OR  
               INDEX(TRIM(wdetail.tiname),"หสน.")         <> 0  OR INDEX(TRIM(wdetail.tiname),"บรรษัท")            <> 0 OR 
               INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วน") <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0 OR 
               INDEX(TRIM(wdetail.tiname),"และ/หรือ")     <> 0  THEN n_classev = "E12".
            ELSE n_classev = "E11".
            IF      DECI(wdetail.si) = 800000 AND  DECI(wdetail.premt) = 24278 THEN ASSIGN wdetail2.producer = "B3M0060"  n_classev = "E11". 
            ELSE IF DECI(wdetail.si) = 800000 AND  DECI(wdetail.premt) = 26875 THEN ASSIGN wdetail2.producer = "B3M0060"  n_classev = "E12". 
            IF index(wdetail2.detailcam,"N1-EV") <> 0 THEN wdetail.vehuse    = "2".
            IF      n_classev = "E11" THEN wdetail.vehuse    = "1".
            ELSE IF n_classev = "E12" THEN wdetail.vehuse    = "2".
            IF wdetail.covcod = "T" OR wdetail.covcod = "0" THEN DO:
                FIND LAST brstat.tlt USE-INDEX tlt06  WHERE                                  
                    brstat.tlt.cha_no       = trim(wdetail.chasno)  AND                      
                    brstat.tlt.eng_no       = TRIM(wdetail.eng)     AND                      
                    brstat.tlt.nor_usr_ins  <> "0"                  AND
                    brstat.tlt.genusr       = "HCT"              NO-ERROR NO-WAIT .
                IF  AVAIL brstat.tlt THEN DO: 
                    IF      DECI(brstat.tlt.note17) = 800000 AND  DECI(brstat.tlt.note18) = 24278 THEN ASSIGN wdetail2.producer = "B3M0060"  n_classev = "E11". 
                    ELSE IF DECI(brstat.tlt.note17) = 800000 AND  DECI(brstat.tlt.note18) = 26875 THEN ASSIGN wdetail2.producer = "B3M0060"  n_classev = "E12". 
                END.
                ASSIGN  wdetail.garage = ""     /*A67-0211*/ 
                    wdetail2.subclass  = IF n_classev = "E12" THEN "E12CA" ELSE "E11PA".         /*wdetail2.subclass  = "210E" */
            END.
            ELSE  ASSIGN wdetail2.subclass =  IF n_classev = "E12" THEN "E12" ELSE "E11".   /*V70*/ /*ELSE ASSIGN wdetail2.subclass  = "120E" .*/
        END.
        /* end :A67-0065 */
        ELSE IF wdetail.covcod = "T" OR wdetail.covcod = "0" THEN DO:
            ASSIGN wdetail.garage = n_garage72 .   /*A67-0160*/
            IF wdetail2.producer = "" THEN RUN proc_assign3.
            ASSIGN wdetail.garage = ""  .
        END.
        ELSE DO:  /* V70 */
            /* creat by : A61-0324 */
            IF index(wdetail2.detailcam,"super pack") <> 0 THEN DO:
                FIND FIRST wimproducer WHERE 
                      wimproducer.saletype = TRIM(wdetail.saletyp)        AND 
                 TRIM(wimproducer.camname) = TRIM(wdetail2.detailcam)     AND  /*Add by Sarinya C A62/0215*/ 
                      wimproducer.notitype = TRIM(wdetail2.TYPE_notify)   NO-LOCK NO-ERROR NO-WAIT. 
                  IF AVAIL  wimproducer THEN  
                      ASSIGN  wdetail2.producer   = wimproducer.producer   
                              wdetail2.producer2  = wimproducer.producer.
            END. /* end A61-0324 */
            ELSE IF index(wdetail2.detailcam,"TMSTH 0%") <> 0 OR index(wdetail2.detailcam,"TMSTH0%") <> 0 OR index(wdetail2.detailcam,"DEMON_H") <> 0 THEN  RUN proc_assign4.
            ELSE IF wdetail.saletyp = "C" THEN DO:
               /*Add by Sarinya C A62/0215*/ 
                IF wdetail.covcod = "1"  AND wdetail2.TYPE_notify = "S" THEN DO:
                    IF wdetail.garage = "" AND 
                      (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 2 ) AND (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 10 ) THEN DO:
                        ASSIGN wdetail2.producer = "B3M0062". /*A63-0443*/
                    END.
                    ELSE ASSIGN wdetail2.producer = "B3M0065".  /*A63-0443*/
                END.
                ELSE IF wdetail.covcod <> "1" AND (wdetail2.TYPE_notify = "S" OR 
                        wdetail2.TYPE_notify = "R" OR wdetail2.TYPE_notify = "N") THEN DO:  
                    ASSIGN wdetail2.producer = "B3M0062".  /*A63-0443*/
                END.
                ELSE DO:  
                    /*A57-0073*/
                    FIND FIRST wimproducer WHERE 
                        wimproducer.saletype = TRIM(wdetail.saletyp)        AND
                        /*index(wdetail2.detailcam,wimproducer.camname) <> 0  AND*/ /*Comment by Sarinya C A62/0215*/ 
                   TRIM(wimproducer.camname) = TRIM(wdetail2.detailcam)     AND  /*Add by Sarinya C A62/0215*/ 
                        wimproducer.notitype = TRIM(wdetail2.TYPE_notify)   NO-LOCK NO-ERROR NO-WAIT. 
                    IF AVAIL  wimproducer THEN  
                        ASSIGN  wdetail2.producer   = wimproducer.producer   
                                wdetail2.producer2  = wimproducer.producer.
                    ELSE ASSIGN wdetail2.producer   =  fi_producer01.
                END.
               /*A57-0073*/
            END.
            ELSE IF wdetail.saletyp = "H" THEN   ASSIGN wdetail2.producer = "B3M0063".  
            ELSE DO:    /*wdetail.saletyp = "N"*/
                /*Add by Sarinya C A62/0215*/ 
               IF wdetail.covcod = "1"  AND wdetail2.TYPE_notify = "S" THEN DO:
                   IF wdetail.garage = "" AND 
                       (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 2 ) AND (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 10 ) THEN DO:
                       ASSIGN wdetail2.producer = "B3M0062". /*A63-0443*/
                   END.
                   ELSE ASSIGN wdetail2.producer = "B3M0065".  /*A63-0443*/ 
               END. /*End Add by Sarinya C A62/0215*/ 
               ELSE IF wdetail.covcod <> "1" AND (wdetail2.TYPE_notify = "S" OR 
                       wdetail2.TYPE_notify = "R" OR wdetail2.TYPE_notify = "N") THEN DO:  
                       ASSIGN wdetail2.producer = "B3M0062".  /*A63-0443*/
               END.
               ELSE DO: 
               /*--end : A59-0118--*/
               /*A57-0073*/
                 FIND FIRST wimproducer WHERE 
                      wimproducer.saletype = TRIM(wdetail.saletyp)        AND 
                 TRIM(wimproducer.camname) = TRIM(wdetail2.detailcam)     AND  /*Add by Sarinya C A62/0215*/ 
                      wimproducer.notitype = TRIM(wdetail2.TYPE_notify)   NO-LOCK NO-ERROR NO-WAIT. 
                  IF AVAIL  wimproducer THEN  
                      ASSIGN  wdetail2.producer   = wimproducer.producer   
                              wdetail2.producer2  = wimproducer.producer.
                  ELSE ASSIGN wdetail2.producer   =  fi_producer01.
               END.
               ASSIGN wdetail2.ins_pay   = trim(wdetail2.n_month + wdetail2.n_bank) .
               /*A57-0073*/
            END. 
        END. /* V70 */
        IF wdetail2.producer = ""  THEN wdetail2.producer = trim(fi_producer01).

        IF wdetail.caryear = "" THEN wdetail.caryear =  string(YEAR(TODAY),"9999").
        IF wdetail.prepol <> "" THEN RUN proc_cutchar.
        /*Add by Kridtiya i. A63-0472*/
        RUN proc_assign2addr (INPUT  wdetail.tambon               
                             ,INPUT  wdetail.amper                
                             ,INPUT  wdetail.country              
                             ,INPUT  wdetail.occup                
                             ,OUTPUT wdetail3.codeocc             
                             ,OUTPUT wdetail3.codeaddr1           
                             ,OUTPUT wdetail3.codeaddr2           
                             ,OUTPUT wdetail3.codeaddr3). 
        RUN proc_matchtypins (INPUT  wdetail.tiname                      
                             ,INPUT  TRIM(wdetail.insnam + " " + wdetail.name3)
                             ,OUTPUT wdetail3.insnamtyp
                             ,OUTPUT wdetail3.firstName 
                             ,OUTPUT wdetail3.lastName).
        ASSIGN 
            wdetail3.br_insured  = "00000"      
            wdetail3.campaign_ov = "".         
        /*Add by Kridtiya i. A63-0472*/

        RUN proc_address.
        IF wdetail.vehreg = "" THEN 
            ASSIGN wdetail.vehreg   = "/" + SUBSTRING(wdetail.chasno,9,LENGTH(wdetail.chasno)) .  /* ทะเบียนรถมาMRHCP16309P302579 */ /*A63-0443 08/10/20*/
        ELSE IF substr(wdetail.vehreg,9,2) = "" THEN RUN proc_assign_vehrenew.   /*  kridtiya i. A53-0220  22/07/2010 */
        
        /*add kridtiya i. A53-0027...............*/
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "HCT" AND
                stat.insure.lname  = wdetail2.comrequest   NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN DO: 
                ASSIGN 
                    wdetail3.name3        = TRIM(stat.insure.fname)    /* A58-0198 */
                    wdetail2.n_branch     = trim(stat.insure.branch)   
                    wdetail2.n_delercode  = trim(stat.insure.insno)    
                    wdetail3.financecd    = trim(stat.Insure.Text3)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                    wdetail2.typrequest   = trim(stat.insure.vatcode)  /*เปลี่ยน เป็นเก็บค่า vatcode.*/
                    n_textfi              = TRIM(stat.insure.addr3) .  /*A540125*/ 
                IF wdetail2.voictitle = "1" THEN wdetail2.typrequest  = "".
            END.
            ELSE DO:
                ASSIGN
                    wdetail2.n_branch    = ""
                    wdetail2.n_delercode = "" 
                    wdetail2.typrequest  = "" 
                    wdetail3.name3       = ""
                    wdetail3.financecd   = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                    n_textfi             = "" .  /*A540125*/ 
            END.
            IF  wdetail2.poltyp = "V70" THEN DO:
                IF  wdetail3.instot > 1  THEN DO:
                    /* add by A64-0422 : 05/10/2021 */
                    IF INDEX(wdetail2.detailcam,"HATC CAMPAIGN") <> 0 THEN DO:            /* Ranu I. A64-0422 05/10/2021*/
                        ASSIGN wdetail2.name4      = "และ/หรือ บริษัท ฮอนด้า ออโตโมบิล (ประเทศไทย) จำกัด" 
                               wdetail3.companyre1 = CAPS(trim(fi_producerinst)) + " " +  trim(wdetail3.companyre1). 
                    END.
                    ELSE IF INDEX(wdetail2.detailcam,"HLTC CAMPAIGN") <> 0 THEN DO:
                        ASSIGN wdetail2.name4      = "และ/หรือ บริษัท ฮอนด้า ลีสซิ่ง (ประเทศไทย) จำกัด"
                               wdetail3.companyre1 = "MC34018" + " " +  trim(wdetail3.companyre1).
                    END.
                    /* end : A64-0422 05/10/2021 */
                    /*2 3 INSTALMENTS */
                    IF wdetail3.name3 <> "" THEN DO:
                        ASSIGN name2   = trim(REPLACE(wdetail3.companyre2," ",""))
                               name3   = trim(REPLACE(wdetail3.companyre3," ",""))
                               delname = TRIM(REPLACE(wdetail3.name3," ","")).  
                        
                        IF wdetail3.companyre2 <> "" THEN DO:
                            IF  index(name2,delname) <> 0 THEN /* ranu */
                                ASSIGN 
                                wdetail3.name3       = "และ/หรือ " + trim(wdetail3.name3)
                                wdetail3.companyre2  = caps(trim(wdetail2.typrequest)) + " " + trim(wdetail3.companyre2).
                        END.
                        ELSE IF wdetail3.companyre3 <> "" THEN DO:
                            IF  index(name3,delname) <> 0 THEN /* ranu */
                                ASSIGN 
                                wdetail3.name3       = "และ/หรือ " + trim(wdetail3.name3)
                                wdetail3.companyre3  = caps(trim(wdetail2.typrequest)) + " " + trim(wdetail3.companyre3).
                        END.
                        ELSE wdetail3.name3 = "".
                    END.
                END.
                ELSE wdetail3.name3 = "".
            END.
            ELSE wdetail3.name3 = "".
        /* add A540125*/ 
        IF (n_textfi <> "") AND (INDEX(n_textfi,"fi") <> 0) THEN DO:
            n_textfi   = wdetail2.comrequest + "/" + wdetail2.comcar  .
            FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "HCT" AND
                stat.insure.lname  = wdetail2.comcar   NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN DO: 
                ASSIGN wdetail2.n_branch  = trim(stat.insure.branch)
                    wdetail2.n_delercode  = trim(stat.insure.insno) 
                    wdetail3.financecd    = trim(stat.Insure.Text3)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                    wdetail2.typrequest   = trim(stat.insure.vatcode) .  /*เปลี่ยน เป็นเก็บค่า vatcode.*/
                IF wdetail2.voictitle = "1" THEN wdetail2.typrequest  = "".
            END.
            ELSE 
                ASSIGN
                    wdetail2.n_branch    = ""
                    wdetail2.n_delercode = "" 
                    wdetail3.financecd   = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                    wdetail2.typrequest  = "" .
        END.  /*end add ...A540125*/ 
        ELSE n_textfi   = wdetail2.comrequest + "/" + wdetail2.comcar  .
        END.
         /* add A63-0112 */
        IF DATE(wdetail.comdat) >= 04/01/2020 THEN DO:
           ASSIGN wdetail2.prempa  = "T" .
        END.
    END.
END.
*/ 
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
  DISPLAY fi_Campaign23 ra_typfile fi_loaddat fi_packgarage fi_packnogar 
          fi_packcov3 fi_campaign fi_redyear fi_proid fi_saletype fi_camname 
          fi_notitype fi_improducer fi_bchno fi_branch fi_producer01 fi_agent 
          fi_prevbat fi_bchyr fi_no_mn30 fi_filename fi_output1 fi_output2 
          fi_output3 fi_usrcnt fi_usrprem fi_process fi_outputpro fi_brndes 
          fi_impcnt fi_packpuls fi_completecnt fi_premtot fi_premsuc 
          fi_producerinst fi_camp_SP fi_camp_tp tg_flag tg_flagRN 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_wdetail fi_Campaign23 ra_typfile fi_loaddat fi_packgarage 
         fi_packnogar fi_packcov3 fi_campaign fi_redyear fi_proid fi_saletype 
         fi_camname fi_notitype fi_improducer bu_add fi_bchno bu_delete 
         fi_branch fi_producer01 fi_agent fi_prevbat fi_bchyr fi_no_mn30 
         fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt 
         fi_usrprem buok bu_exit bu_hpbrn bu_hpagent fi_outputpro bu_hpagent-2 
         br_producer fi_packpuls fi_producerinst fi_camp_SP fi_camp_tp tg_flag 
         tg_flagRN RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 RECT-377 
         RECT-378 RECT-379 RECT-380 
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
  Notes: A68-0061..      
------------------------------------------------------------------------------*/
DEF VAR nsubclass AS CHAR INIT "".
DEF VAR b_eng     AS DECI INIT "".
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "006: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.

RUN proc_chkcomp.
ASSIGN wdetail2.tariff = "9"
    nsubclass = wdetail2.subclass.  /*Modify by   : Kridtiya i. */
    /*wdetail2.subclass = "110"*/ /*comment by Kridtiya i. */
    fi_process = "Process data HCT....compulsary "  .
/* comment by : A68-0061..
IF      wdetail2.subclass = "110" THEN wdetail2.subclass = "110".  /*Add by Kridtiya i. */
ELSE IF wdetail2.subclass = "120" THEN wdetail2.subclass = "110".  /*Add by Sarinya  C A62-0215*/
ELSE IF wdetail2.subclass = "210" THEN wdetail2.subclass = "120A". /*Add by Kridtiya i. */
ELSE IF wdetail2.subclass = "220" THEN wdetail2.subclass = "120A". /*Add by Kridtiya i. */
ELSE IF wdetail2.subclass = "320" THEN wdetail2.subclass = "140A". /*Add by Kridtiya i. */
ELSE IF wdetail2.subclass = "120E" THEN wdetail2.subclass = "210E". /*A67-0065 */
ELSE IF wdetail2.subclass = "E11"  THEN wdetail2.subclass = "E11PA".  /*A67-0065 */
ELSE IF wdetail2.subclass = "E12"  THEN wdetail2.subclass = "E12CA".  /*A67-0065 */
*/
DISP fi_process WITH FRAM fr_main.
IF wdetail2.poltyp = "v72" THEN DO:
  IF wdetail.compul <> "y" THEN 
    ASSIGN wdetail2.comment = wdetail2.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y"  
    wdetail2.pass    = "N"
    WDETAIL2.OK_GEN  = "N". 
END.
IF wdetail.compul = "y" THEN DO:
  IF wdetail.stk <> "" THEN DO:    
    IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
    IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
      ASSIGN  wdetail2.comment = wdetail2.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"   
        wdetail2.pass    = ""
        WDETAIL2.OK_GEN  = "N".
  END.
END.
/*---------- class --------------*/
IF wdetail2.n_branch = ""  THEN  
  ASSIGN  wdetail2.pass = "N"  
  wdetail2.comment = wdetail2.comment + "| พบสาขาเป็นค่าว่างหรือไม่พบรหัสดีเลอร์" + n_textfi    
  WDETAIL2.OK_GEN  = "N".
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail2.subclass
    NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| ไม่พบ Class นี้ในระบบ"        
        wdetail2.pass    = "N"
        WDETAIL2.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail2.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail2.poltyp  AND
        sicsyac.xmd031.class  = wdetail2.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN wdetail2.pass    = "N"
            wdetail2.comment = wdetail2.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"     
            WDETAIL2.OK_GEN  = "N".
END. 
/*---------- covcod ----------*/
wdetail.covcod = CAPS(wdetail.covcod).
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN wdetail2.pass    = "N"
        wdetail2.comment = wdetail2.comment + "| ไม่พบ Cover Type นี้ในระบบ"       
        WDETAIL2.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail2.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = "110" AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN wdetail2.pass    = "N"  
        wdetail2.comment = wdetail2.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"        
        WDETAIL2.OK_GEN = "N".
/*--------- modcod --------------*/
chkred = NO.
FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  wdetail2.prempa + wdetail2.subclass NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN n_ratmin = makdes31.si_theft_p   
           n_ratmax = makdes31.load_p   .    
ELSE ASSIGN n_ratmin = 0
     n_ratmax        = 0 .
IF DECI(wdetail.engcc) > 501 THEN DO:
   ASSIGN
     b_eng           = 0
     b_eng           = round((DECI(wdetail.engcc) / 1000),1).     /*format engcc */
     b_eng           = b_eng * 1000.
END.
ELSE b_eng           =  DECI(wdetail.engcc).
/* A68-0061...
IF (INDEX(wdetail.model,"CIVIC") <> 0 ) OR (INDEX(wdetail.model,"CITY") <> 0 ) THEN DO:  /*A63-00472*/
    IF INDEX(wdetail.carcode,"HATCHBACK") <> 0 THEN DO:
       Find First stat.maktab_fil USE-INDEX maktab04    Where
         stat.maktab_fil.makdes   =     wdetail.brand            And                  
         index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
         stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
         stat.maktab_fil.engine   =     b_eng /*Integer(wdetail.engcc)*/   AND
         /*stat.maktab_fil.sclass   =     wdetail2.subclass        AND  nsubclass*/
         stat.maktab_fil.sclass   =     nsubclass       AND  
        (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
         stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
         stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  AND
         stat.maktab_fil.body     = "HATCHBACK"     No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN  wdetail2.redbook       =  stat.maktab_fil.modcod .
        ELSE wdetail2.redbook       = "".
           
    END.
    ELSE DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
         stat.maktab_fil.makdes   =     wdetail.brand            And                  
         index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
         stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
         stat.maktab_fil.engine   =     b_eng /*Integer(wdetail.engcc)*/   AND
         /*stat.maktab_fil.sclass   =     wdetail2.subclass        AND*/
         stat.maktab_fil.sclass   =     nsubclass       AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
         stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
         stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  AND
         stat.maktab_fil.body     = "SEDAN"     No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN wdetail2.redbook     =  stat.maktab_fil.modcod.
        ELSE wdetail2.redbook = "".
            
    END.
END.
ELSE DO:
/* end A60-0505*/
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
        stat.maktab_fil.engine   =   b_eng   /*Integer(wdetail.engcc)*/   AND
        /*stat.maktab_fil.sclass   =     wdetail2.subclass        AND*/
        stat.maktab_fil.sclass   =    nsubclass        AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
        stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN wdetail2.redbook = stat.maktab_fil.modcod.
    ELSE wdetail2.redbook = "".
END.
         /*A63-00472*/
    IF wdetail2.redbook = "" THEN DO:
        IF nsubclass = "210E" THEN nsubclass = "E12".
        else IF nsubclass = "E11PA" THEN nsubclass = "E11".
        else IF nsubclass = "E12CA" THEN nsubclass = "E12".
        IF SUBSTR(nsubclass,1,1) = "E"    THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                /*stat.maktab_fil.engine   =   b_eng  /*Integer(wdetail.engcc)*/   AND*/
                /*stat.maktab_fil.sclass =     wdetail2.subclass       */ 
                stat.maktab_fil.sclass   =     nsubclass                                          /*AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
                stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  */ 
                No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN ASSIGN wdetail2.redbook = stat.maktab_fil.modcod.
            ELSE wdetail2.redbook = "".
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =   b_eng  /*Integer(wdetail.engcc)*/   AND
                /*stat.maktab_fil.sclass =     wdetail2.subclass       */ 
                stat.maktab_fil.sclass   =     nsubclass                                          /*AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
                stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  */ 
                No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN ASSIGN wdetail2.redbook = stat.maktab_fil.modcod.
            ELSE wdetail2.redbook = "".
        END.
    END.  /*A63-00472*/
    ...end A68-0061...*/
OUTPUT TO D:\temp\LogTimeHCT_redbook.TXT APPEND.
PUT "Proc_72: " wdetail2.redbook "-"  wdetail.brand "-" wdetail.model "-" wdetail.caryear "-" b_eng "-" nsubclass   SKIP.
OUTPUT CLOSE.

/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN     
        wdetail2.pass    = "N"  
        wdetail2.comment = wdetail2.comment + "| ไม่พบ Veh.Usage ในระบบ "
        WDETAIL2.OK_GEN  = "N".
ASSIGN
    nv_docno  = " "
    nv_accdat = TODAY.
/***--- Docno ---***/
IF wdetail2.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M" AND
        sicuw.uwm100.docno1 = STRING(wdetail2.docno,"9999999")
        NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN 
        
        ASSIGN /*a490166*/     
            wdetail2.pass    = "N"  
            wdetail2.comment = "Receipt is Dup. on uwm100 :" + string(sicuw.uwm100.policy,"x(16)") +
            STRING(sicuw.uwm100.rencnt,"99")  + "/" +
            STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
            WDETAIL2.OK_GEN  = "N".
    ELSE 
        nv_docno = wdetail2.docno.
END.
/***--- Account Date ---***/
IF wdetail2.accdat <> " "  THEN nv_accdat = date(wdetail2.accdat).
ELSE nv_accdat = TODAY.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 C-Win 
PROCEDURE proc_722 :
/* ---------------------------------------------  U W M 1 3 0 -------------- */
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "010: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
ASSIGN fi_process = "Process data HCT....sic_bran.uwm130,sic_bran.uwm301 "  .
        DISP fi_process WITH FRAM fr_main.
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
    ASSIGN sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno.
    ASSIGN  sic_bran.uwm130.bchyr = nv_batchyr     /* batch Year */
        sic_bran.uwm130.bchno = nv_batchno         /* bchno      */
        sic_bran.uwm130.bchcnt  = nv_batcnt .      /* bchcnt     */
    ASSIGN  sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0     /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0     /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0     /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0     /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.    /*Item Endt. Clause*/
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class
        NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN 
        ASSIGN  sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
        sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9 
        nv_comper     = deci(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc     = deci(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v   = nv_comper   
        sic_bran.uwm130.uom9_v   = nv_comacc  .   
    ASSIGN  nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy,         /*a490166 Note modi*/
                         nv_riskno,
                         nv_itemno).
END.   /*transaction*/
s_recid3  = RECID(sic_bran.uwm130).
/* ---------------------------------------------  U W M 3 0 1 --------------*/ 
nv_covcod =   wdetail.covcod.
nv_makdes  =  wdetail.brand.
nv_moddes  =  wdetail.model.
/*--Str Amparat C. A51-0253--*/
RUN proc_chassic . /* ranu : A64-0422*/
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
         sic_bran.uwm301.bchyr = nv_batchyr               AND 
         sic_bran.uwm301.bchno = nv_batchno               AND 
         sic_bran.uwm301.bchcnt  = nv_batcnt     NO-WAIT NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
        DO TRANSACTION:
            CREATE sic_bran.uwm301.
        END. /*transaction*/
    END.                                                          
    Assign sic_bran.uwm301.policy  = sic_bran.uwm120.policy                   
        sic_bran.uwm301.rencnt  = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt  = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp  = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno  = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno  = s_itemno
        sic_bran.uwm301.tariff  = wdetail2.tariff
        sic_bran.uwm301.covcod  = nv_covcod
        sic_bran.uwm301.cha_no  = wdetail.chasno
        sic_bran.uwm301.eng_no  = wdetail.eng
        sic_bran.uwm301.Tons    = IF wdetail2.subclass = "140A" THEN  nv_cc ELSE  INTEGER(wdetail2.weight)
        sic_bran.uwm301.trareg  = nv_uwm301trareg             /*Ranu I. A64-0422  01/10/2021*/
        /*sic_bran.uwm301.engine  = nv_CC */ /*A67-0065*/     /*Ranu I. A64-0422  01/10/2021*/
        sic_bran.uwm301.engine  = IF wdetail2.subclass <> "E11PA" AND wdetail2.subclass <> "E12CA" THEN nv_cc ELSE 0 /*A67-0065*/ 
        sic_bran.uwm301.vehgrp  = wdetail.cargrp              /*ranu I. A64-0422  01/10/2021*/ 
        sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage  = wdetail.garage
        sic_bran.uwm301.body    = wdetail.body
        sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = wdetail.benname
        sic_bran.uwm301.vehreg   = wdetail.vehreg + nv_provi
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        /*sic_bran.uwm301.moddes   = wdetail.model + " " +  */    
        sic_bran.uwm301.moddes    = trim(wdetail.brand) + " " + trim(wdetail.model) + " " + trim(wdetail.carcode)
        sic_bran.uwm301.modcod   = wdetail2.redbook 
        sic_bran.uwm301.sckno    = 0              
        sic_bran.uwm301.itmdel   = NO
        sic_bran.uwm301.car_color = wdetail.colorcar
        /*sic_bran.uwm301.watt     = IF wdetail2.subclass = "E11PA" OR wdetail2.subclass = "E12CA"  THEN nv_cc ELSE 0 /*A67-0065 */ --A68-0061--*/
        sic_bran.uwm301.watts     = deci(wdetail2.watt)
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
    ELSE sic_bran.uwm301.drinam[9] = "".
    s_recid4  = RECID(sic_bran.uwm301).
    IF wdetail2.redbook <> "" THEN DO:     /*กรณีที่มีการระบุ Code รถมา*/
        FIND FIRST stat.maktab_fil Use-index   maktab04   WHERE 
            stat.maktab_fil.sclass = wdetail2.subclass    AND  /*kridtiya i. A53-0406*/
            stat.maktab_fil.modcod = wdetail2.redbook     No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN wdetail2.redbook =  stat.maktab_fil.modcod
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.body    =  stat.maktab_fil.body
            sic_bran.uwm301.seats   =  stat.maktab_fil.seats
            sic_bran.uwm301.Tons    =  stat.maktab_fil.tons 
            sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
            wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
            sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
            wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
            sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
    END.
    ELSE DO:
        IF   INDEX(wdetail.model,"CIVIC") <>  0 THEN RUN proc_maktab4.  /* A60-0505 */
        ELSE IF INDEX(wdetail.model,"CITY")  <>  0 THEN RUN proc_maktab4.  /* A63-00472 */
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     wdetail2.subclass        AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
                 stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat) No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN wdetail2.redbook =  stat.maktab_fil.modcod
                wdetail.model           =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod 
                sic_bran.uwm301.body    =  stat.maktab_fil.body
                sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
                sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
                wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
                sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
        END.
    END.
    IF wdetail2.redbook = "" THEN  RUN proc_maktab4.   /*kridtiya i. A53-0220  */
    IF index(trim(wdetail.model) +  trim(wdetail.carcode),"HATCHBACK") <> 0 THEN  sic_bran.uwm301.body  = "HATCHBACK".
    FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
         sic_bran.uwd132.policy = wdetail.policyno AND
         sic_bran.uwd132.rencnt = 0                AND
         sic_bran.uwd132.endcnt = 0                AND
         sic_bran.uwd132.riskgp = 0                AND
         sic_bran.uwd132.riskno = 1                AND
         sic_bran.uwd132.itemno = 1                AND
         sic_bran.uwd132.bchyr  = nv_batchyr       AND
         sic_bran.uwd132.bchno  = nv_batchno       AND
         sic_bran.uwd132.bchcnt = nv_batcnt   NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
      IF LOCKED sic_bran.uwd132 THEN DO:
        MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wdetail.policyno
                "ไม่สามารถ Generage ข้อมูลได้".
        NEXT.
      END.
      CREATE sic_bran.uwd132.
    END.
    ASSIGN  sic_bran.uwd132.bencod  = "COMP"                   /*Benefit Code*/
      sic_bran.uwd132.benvar  = ""                       /*Benefit Variable*/
      sic_bran.uwd132.rate    = 0                        /*Premium Rate %*/
      sic_bran.uwd132.gap_ae  = NO                       /*GAP A/E Code*/
      sic_bran.uwd132.gap_c   = deci(wdetail.premt)      /*GAP, per Benefit per Item*/
      sic_bran.uwd132.dl1_c   = 0                        /*Disc./Load 1,p. Benefit p.Item*/
      sic_bran.uwd132.dl2_c   = 0                        /*Disc./Load 2,p. Benefit p.Item*/
      sic_bran.uwd132.dl3_c   = 0                        /*Disc./Load 3,p. Benefit p.Item*/
      sic_bran.uwd132.pd_aep  = "E"                      /*Premium Due A/E/P Code*/
      sic_bran.uwd132.prem_c  = deci(wdetail.premt)      /*PD, per Benefit per Item*/
      sic_bran.uwd132.fptr    = 0                        /*Forward Pointer*/
      sic_bran.uwd132.bptr    = 0                        /*Backward Pointer*/
      sic_bran.uwd132.policy  = wdetail.policyno         /*Policy No. - uwm130*/
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
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "011: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = nv_rec301 NO-WAIT NO-ERROR.
IF sic_bran.uwm130.fptr03 = 0 OR sic_bran.uwm130.fptr03 = ? THEN DO:
    FIND sicsyac.xmm107 USE-INDEX xmm10701      WHERE
        sicsyac.xmm107.class  = wdetail2.subclass   AND
        sicsyac.xmm107.tariff = wdetail2.tariff
        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xmm107 THEN DO:
        FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmd107 THEN DO:
            CREATE sic_bran.uwd132.
            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                sicsyac.xmm016.class = wdetail2.subclass
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
                sicsyac.xmm105.tariff = wdetail2.tariff  AND
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE  MESSAGE "ไม่พบ Tariff  " wdetail2.tariff   VIEW-AS ALERT-BOX.
            IF wdetail2.tariff = "Z" OR wdetail2.tariff = "X" THEN DO:  /* Malaysia */
                IF           wdetail2.subclass      = "110" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail2.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail2.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail2.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail2.weight).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.

                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail2.tariff   AND
                    sicsyac.xmm106.bencod  = uwd132.bencod    AND
                    sicsyac.xmm106.class   = wdetail2.subclass AND
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
                    sicsyac.xmm106.tariff  = wdetail2.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail2.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= 0                AND
                    sicsyac.xmm106.key_b  >= 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail2.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail2.subclass AND
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
                    sicsyac.xmm016.class = wdetail2.subclass
                    NO-LOCK NO-ERROR.
                IF AVAIL sicsyac.xmm016 THEN 
                    ASSIGN sic_bran.uwd132.gap_ae = NO
                    sic_bran.uwd132.pd_aep = "E".
                FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                    sicsyac.xmm105.tariff = wdetail2.tariff  AND
                    sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
                ELSE   MESSAGE "ไม่พบ Tariff นี้ในระบบ กรุณาใส่ Tariff ใหม่" 
                    "Tariff" wdetail2.tariff "Bencod"  xmd107.bencod VIEW-AS ALERT-BOX.
                IF wdetail2.tariff = "Z" OR wdetail2.tariff = "X" THEN DO:
                    IF           wdetail2.subclass      = "110" THEN nv_key_a = inte(wdetail.engcc).
                    ELSE IF SUBSTRING(wdetail2.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                    ELSE IF SUBSTRING(wdetail2.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                    ELSE IF SUBSTRING(wdetail2.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail2.weight).
                    nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                        sicsyac.xmm106.tariff  = wdetail2.tariff   AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail2.subclass    AND
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
                        sicsyac.xmm106.tariff  = wdetail2.tariff           AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail2.subclass        AND
                        sicsyac.xmm106.covcod  = wdetail.covcod           AND
                        sicsyac.xmm106.key_a  >= 0                        AND
                        sicsyac.xmm106.key_b  >= 0                        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601                  WHERE
                        sicsyac.xmm106.tariff  = wdetail2.tariff            AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod    AND
                        sicsyac.xmm106.class   = wdetail2.subclass          AND
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
        MESSAGE "ไม่พบ Class " wdetail2.subclass " ใน Tariff  " wdetail2.tariff  skip
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
            IF wdetail2.tariff = "Z" OR wdetail2.tariff = "X" THEN DO:
                IF           wdetail2.subclass      = "110" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail2.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail2.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail2.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail2.weight).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                WHERE
                    sicsyac.xmm106.tariff  = wdetail2.tariff          AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod  AND
                    sicsyac.xmm106.class   = wdetail2.subclass        AND
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
                    sicsyac.xmm106.tariff  = wdetail2.tariff      AND 
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod       AND 
                    sicsyac.xmm106.class   = wdetail2.subclass    AND 
                    sicsyac.xmm106.covcod  = wdetail.covcod      AND 
                    sicsyac.xmm106.key_a  >= 0                   AND 
                    sicsyac.xmm106.key_b  >= 0                   AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                    sicsyac.xmm106.tariff  = wdetail2.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail2.subclass    AND
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adddriver C-Win 
PROCEDURE proc_adddriver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF  wdetail2.drivnam = "Y" THEN DO :      /*note add 07/11/2005*/
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
 
        ASSIGN wdetail.dbirth    = if wdetail.dbirth  <> "" then STRING(DATE(wdetail.dbirth),"99/99/9999")  else ""
               wdetail.ddbirth   = if wdetail.ddbirth <> "" then STRING(DATE(wdetail.ddbirth),"99/99/9999") else ""
               wdetail.dbirth3   = if wdetail.dbirth3 <> "" then STRING(DATE(wdetail.dbirth3),"99/99/9999") else ""
               wdetail.dbirth4   = if wdetail.dbirth4 <> "" then STRING(DATE(wdetail.dbirth4),"99/99/9999") else ""
               wdetail.dbirth5   = if wdetail.dbirth5 <> "" then STRING(DATE(wdetail.dbirth5),"99/99/9999") else ""
               nv_drivage1       = IF TRIM(wdetail.dbirth)  <> "" THEN  INT(SUBSTR(wdetail.dbirth,7,4)) ELSE 0
               nv_drivage2       = IF TRIM(wdetail.ddbirth) <> "" THEN  INT(SUBSTR(wdetail.ddbirth,7,4)) ELSE 0
               nv_drivage3       = IF TRIM(wdetail.dbirth3) <> "" THEN  INT(SUBSTR(wdetail.dbirth3,7,4)) ELSE 0
               nv_drivage4       = IF TRIM(wdetail.dbirth4) <> "" THEN  INT(SUBSTR(wdetail.dbirth4,7,4)) ELSE 0
               nv_drivage5       = IF TRIM(wdetail.dbirth5) <> "" THEN  INT(SUBSTR(wdetail.dbirth5,7,4)) ELSE 0 .

         IF wdetail.drivername1 <> " " THEN DO: 
             RUN proc_clearmailtxt .
             IF nv_drivage1 > 0 THEN DO:
                if nv_drivage1 < year(today) then do:
                    nv_drivage1 =  YEAR(TODAY) - nv_drivage1  .
                    ASSIGN nv_dribirth    = STRING(DATE(wdetail.dbirth),"99/99/9999") /* ค.ศ. */
                           nv_drivbir1    = STRING(INT(SUBSTR(wdetail.dbirth,7,4))  + 543 )
                           wdetail.dbirth = SUBSTR(wdetail.dbirth,1,6) + nv_drivbir1
                           wdetail.dbirth = STRING(DATE(wdetail.dbirth),"99/99/9999") . /* พ.ศ. */
                END.
                ELSE DO:
                    nv_drivage1 =  YEAR(TODAY) - (nv_drivage1 - 543).
                    ASSIGN nv_drivbir1    = STRING(INT(SUBSTR(wdetail.dbirth,7,4)))
                           nv_dribirth    = SUBSTR(wdetail.dbirth,1,6) + STRING((INTE(nv_drivbir1) - 543),"9999")  /* ค.ศ. */
                           wdetail.dbirth = SUBSTR(wdetail.dbirth,1,6) + nv_drivbir1   
                           wdetail.dbirth = STRING(DATE(wdetail.dbirth),"99/99/9999")  . /* พ.ศ. */
                END.
             END.
             ASSIGN  n_count        = 1
                     nv_ntitle   = trim(wdetail.ntitle1)  
                     nv_name     = trim(wdetail.drivername1 + " " + wdetail.dname1)  
                     nv_lname    = trim(wdetail.dname2) 
                     nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
                     nv_dicno    = trim(wdetail.dicno)  
                     nv_dgender  = IF trim(wdetail.dgender1) = "M" THEN "MALE" ELSE IF trim(wdetail.dgender1) = "F" THEN "FEMALE" ELSE trim(wdetail.dgender1)
                     nv_dbirth   = trim(wdetail.dbirth)
                     nv_dage     = nv_drivage1
                     nv_doccup   = trim(wdetail.docoup) 
                     nv_ddriveno = trim(wdetail.ddriveno) 
                     nv_drivexp  = trim(wdetail.drivexp1)
                     nv_dconsent = TRIM(wdetail.drivcon1)
                     nv_dlevel   = INTE(wdetail.dlevel1)
                     wdetail.drilevel = nv_dlevel 
                     nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                                   ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
             RUN proc_mailtxt.
         END.

         IF wdetail.drivername2 <> " " THEN DO: 
             RUN proc_clearmailtxt .
             IF nv_drivage2 > 0 THEN DO:
                if nv_drivage2 < year(today) then do:
                    nv_drivage2 =  YEAR(TODAY) - nv_drivage2  .
                    ASSIGN nv_dribirth    = STRING(DATE(wdetail.ddbirth),"99/99/9999") /* ค.ศ. */
                           nv_drivbir2    = STRING(INT(SUBSTR(wdetail.ddbirth,7,4))  + 543 )
                           wdetail.ddbirth = SUBSTR(wdetail.ddbirth,1,6) + nv_drivbir2
                           wdetail.ddbirth = STRING(DATE(wdetail.ddbirth),"99/99/9999") . /* พ.ศ. */
                END.
                ELSE DO:
                    nv_drivage2 =  YEAR(TODAY) - (nv_drivage2 - 543).
                    ASSIGN nv_drivbir2    = STRING(INT(SUBSTR(wdetail.ddbirth,7,4)))
                           nv_dribirth    = SUBSTR(wdetail.ddbirth,1,6) + STRING((INTE(nv_drivbir2) - 543),"9999")  /* ค.ศ. */
                           wdetail.ddbirth = SUBSTR(wdetail.ddbirth,1,6) + nv_drivbir2   
                           wdetail.ddbirth = STRING(DATE(wdetail.ddbirth),"99/99/9999")  . /* พ.ศ. */
                END.
             END.
             ASSIGN  n_count        = 2
                     nv_ntitle   = trim(wdetail.ntitle2)  
                     nv_name     = trim(wdetail.drivername2 + " " + wdetail.ddname1)  
                     nv_lname    = trim(wdetail.ddname2)                             
                     nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
                     nv_dicno    = trim(wdetail.ddicno)  
                     nv_dgender  = IF trim(wdetail.dgender2) = "M" THEN "MALE" ELSE IF trim(wdetail.dgender2) = "F" THEN "FEMALE" ELSE trim(wdetail.dgender2) 
                     nv_dbirth   = trim(wdetail.ddbirth)
                     nv_dage     = nv_drivage2
                     nv_doccup   = trim(wdetail.ddocoup) 
                     nv_ddriveno = trim(wdetail.dddriveno) 
                     nv_drivexp  = trim(wdetail.drivexp2)
                     nv_dconsent = TRIM(wdetail.drivcon2)
                     nv_dlevel   = INTE(wdetail.dlevel2)
                     wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN nv_dlevel ELSE wdetail.drilevel 
                     nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                                   ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
             RUN proc_mailtxt.
         END.

         IF wdetail.dname3 <> " " THEN DO:
             RUN proc_clearmailtxt .
             IF nv_drivage3 > 0 THEN DO:
                if nv_drivage3 < year(today) then do:
                    nv_drivage3 =  YEAR(TODAY) - nv_drivage3  .
                    ASSIGN nv_dribirth    = STRING(DATE(wdetail.dbirth3),"99/99/9999") /* ค.ศ. */
                           nv_drivbir3    = STRING(INT(SUBSTR(wdetail.dbirth3,7,4))  + 543 )
                           wdetail.dbirth3 = SUBSTR(wdetail.dbirth3,1,6) + nv_drivbir3
                           wdetail.dbirth3 = STRING(DATE(wdetail.dbirth3),"99/99/9999") . /* พ.ศ. */
                END.
                ELSE DO:
                    nv_drivage3 =  YEAR(TODAY) - (nv_drivage3 - 543).
                    ASSIGN nv_drivbir3    = STRING(INT(SUBSTR(wdetail.dbirth3,7,4)))
                           nv_dribirth    = SUBSTR(wdetail.dbirth3,1,6) + STRING((INTE(nv_drivbir3) - 543),"9999")  /* ค.ศ. */
                           wdetail.dbirth3 = SUBSTR(wdetail.dbirth3,1,6) + nv_drivbir3   
                           wdetail.dbirth3 = STRING(DATE(wdetail.dbirth3),"99/99/9999")  . /* พ.ศ. */
                END.
             END.
             ASSIGN  n_count        = 3
                     nv_ntitle   = trim(wdetail.ntitle3)  
                     nv_name     = trim(wdetail.dname3 + " " + wdetail.dcname3 )  
                     nv_lname    = trim(wdetail.dlname3) 
                     nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
                     nv_dicno    = trim(wdetail.dicno3)  
                     nv_dgender  = IF trim(wdetail.dgender3) = "M" THEN "MALE" ELSE IF trim(wdetail.dgender3) = "F" THEN "FEMALE" ELSE trim(wdetail.dgender3)
                     nv_dbirth   = trim(wdetail.dbirth3)
                     nv_dage     = nv_drivage3
                     nv_doccup   = trim(wdetail.doccup3) 
                     nv_ddriveno = trim(wdetail.ddriveno3) 
                     nv_drivexp  = trim(wdetail.drivexp3)
                     nv_dconsent = TRIM(wdetail.drivcon3)
                     nv_dlevel   = INTE(wdetail.dlevel3) 
                     wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN nv_dlevel ELSE wdetail.drilevel 
                     nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                                   ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
             RUN proc_mailtxt.
         END.

         IF wdetail.dname4 <> " " THEN DO: 
             RUN proc_clearmailtxt .
             IF nv_drivage4 > 0 THEN DO :
                if nv_drivage4 < year(today) then do:
                    nv_drivage4 =  YEAR(TODAY) - nv_drivage4  .
                    ASSIGN nv_dribirth    = STRING(DATE(wdetail.dbirth4),"99/99/9999") /* ค.ศ. */
                           nv_drivbir4    = STRING(INT(SUBSTR(wdetail.dbirth4,7,4))  + 543 )
                           wdetail.dbirth4 = SUBSTR(wdetail.dbirth4,1,6) + nv_drivbir4
                           wdetail.dbirth4 = STRING(DATE(wdetail.dbirth4),"99/99/9999") . /* พ.ศ. */
                END.
                ELSE DO:
                    nv_drivage4 =  YEAR(TODAY) - (nv_drivage4 - 543).
                    ASSIGN nv_drivbir4    = STRING(INT(SUBSTR(wdetail.dbirth4,7,4)))
                           nv_dribirth    = SUBSTR(wdetail.dbirth4,1,6) + STRING((INTE(nv_drivbir4) - 543),"9999")  /* ค.ศ. */
                           wdetail.dbirth4 = SUBSTR(wdetail.dbirth4,1,6) + nv_drivbir4   
                           wdetail.dbirth4 = STRING(DATE(wdetail.dbirth4),"99/99/9999")  . /* พ.ศ. */
                END.
             END.
             ASSIGN  n_count        = 4
                     nv_ntitle   = trim(wdetail.ntitle4)  
                     nv_name     = trim(wdetail.dname4 + " " + wdetail.dcname4)  
                     nv_lname    = trim(wdetail.dlname4)
                     nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
                     nv_dicno    = trim(wdetail.dicno4)  
                     nv_dgender  = IF trim(wdetail.dgender4) = "M" THEN "MALE" ELSE "FEMALE"  
                     nv_dbirth   = trim(wdetail.dbirth4)
                     nv_dage     = nv_drivage4
                     nv_doccup   = trim(wdetail.doccup4) 
                     nv_ddriveno = trim(wdetail.ddriveno4) 
                     nv_drivexp  = trim(wdetail.drivexp4) 
                     nv_dconsent = TRIM(wdetail.drivcon4)
                     nv_dlevel   = INTE(wdetail.dlevel4) 
                     wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN nv_dlevel ELSE wdetail.drilevel 
                     nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                                   ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
             RUN proc_mailtxt.
         END.

         IF wdetail.dname5 <> " " THEN DO:
             RUN proc_clearmailtxt .
             IF nv_drivage5 > 0 THEN DO:
                if nv_drivage5 < year(today) then do:
                    nv_drivage5 =  YEAR(TODAY) - nv_drivage5  .
                    ASSIGN nv_dribirth    = STRING(DATE(wdetail.dbirth5),"99/99/9999") /* ค.ศ. */
                           nv_drivbir5    = STRING(INT(SUBSTR(wdetail.dbirth5,7,4))  + 543 )
                           wdetail.dbirth5 = SUBSTR(wdetail.dbirth5,1,6) + nv_drivbir5
                           wdetail.dbirth5 = STRING(DATE(wdetail.dbirth5),"99/99/9999") . /* พ.ศ. */
                END.
                ELSE DO:
                    nv_drivage5 =  YEAR(TODAY) - (nv_drivage5 - 543).
                    ASSIGN nv_drivbir5    = STRING(INT(SUBSTR(wdetail.dbirth5,7,4)))
                           nv_dribirth    = SUBSTR(wdetail.dbirth5,1,6) + STRING((INTE(nv_drivbir5) - 543),"9999")  /* ค.ศ. */
                           wdetail.dbirth5 = SUBSTR(wdetail.dbirth5,1,6) + nv_drivbir5   
                           wdetail.dbirth5 = STRING(DATE(wdetail.dbirth5),"99/99/9999")  . /* พ.ศ. */
                END.
             END.
             ASSIGN  n_count        = 5
                     nv_ntitle   = trim(wdetail.ntitle5)  
                     nv_name     = trim(wdetail.dname5 + " " + wdetail.dcname5)  
                     nv_lname    = trim(wdetail.dlname5)
                     nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
                     nv_dicno    = trim(wdetail.dicno5)  
                     nv_dgender  = IF trim(wdetail.dgender5) = "M" THEN "MALE" ELSE "FEMALE" 
                     nv_dbirth   = trim(wdetail.dbirth5)
                     nv_dage     = nv_drivage5
                     nv_doccup   = trim(wdetail.doccup5) 
                     nv_ddriveno = trim(wdetail.ddriveno5) 
                     nv_drivexp  = trim(wdetail.drivexp5)
                     nv_dconsent = TRIM(wdetail.drivcon5)
                     nv_dlevel   = INTE(wdetail.dlevel5) 
                     wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN nv_dlevel ELSE wdetail.drilevel 
                     nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                                   ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
             RUN proc_mailtxt.
         END.
 END. /*note add for mailtxt 07/11/2005*/
 /*-----nv_drivcod---------------------*/
 ASSIGN nv_drivcod = ""
        nv_drivvar = ""
        nv_drivvar1 = "".
        nv_drivvar2 = "".
 IF wdetail2.drivnam = "N" THEN ASSIGN  nv_drivno = 0.
 ELSE ASSIGN  nv_drivno = n_count. 

IF nv_drivno = 0 Then DO:
     Assign nv_drivvar   = " "
         nv_drivcod   = "A000"
         nv_drivvar1  =  "     Unname Driver"
         nv_drivvar2  = "0"
         Substr(nv_drivvar,1,30)   = nv_drivvar1
         Substr(nv_drivvar,31,30)  = nv_drivvar2.
 END.
 ELSE DO:
     IF nv_cal = NO THEN DO: /*A68-0061*/
         IF  nv_drivno  > 2 AND index(wdetail2.subclass,"E") = 0 Then do: 
             Message " Driver'S NO. must not over 2. "  View-as alert-box.
             ASSIGN wdetail2.pass    = "N"
                    wdetail2.comment = wdetail2.comment +  "| Driver'S NO. must not over 2. ".  
         END.
        
         IF  index(wdetail2.subclass,"E") = 0 THEN DO:
             RUN proc_usdcod.
         END.
         ELSE DO:
             ASSIGN nv_drivcod = "AL0" + TRIM(STRING(wdetail.drilevel)).
             FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                        xmm106.tariff = wdetail2.tariff  AND
                        xmm106.bencod = nv_drivcod   AND
                        xmm106.CLASS  = wdetail2.subclass   AND
                        xmm106.covcod = wdetail.covcod  AND
                        xmm106.KEY_a  = 0          AND
                        xmm106.KEY_b  = 0          AND
                        xmm106.effdat <= date(wdetail.comdat) NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL xmm106 THEN DO:
                 nv_dlevper = xmm106.appinc.
             END.
             ELSE ASSIGN nv_dlevper = 0.
         END.
     END.
     /* Add by : A68-0044 */
     ELSE DO:
         IF INDEX(wdetail2.subclass,"11") = 0 AND INDEX(wdetail2.subclass,"21") = 0 AND INDEX(wdetail2.subclass,"61") = 0 AND TRIM(wdetail2.subclass) <> "E12"  THEN DO:  
             RUN proc_usdcod.
         END.
         ELSE DO:
             ASSIGN nv_drivcod = "AL0" + TRIM(STRING(wdetail.drilevel)).
             FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                        xmm106.tariff = wdetail2.tariff  AND
                        xmm106.bencod = nv_drivcod   AND
                        xmm106.CLASS  = wdetail2.subclass   AND
                        xmm106.covcod = wdetail.covcod  AND
                        xmm106.KEY_a  = 0          AND
                        xmm106.KEY_b  = 0          AND
                        xmm106.effdat <= date(wdetail.comdat) NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL xmm106 THEN DO:
                 nv_dlevper = xmm106.appinc.
             END.
             ELSE ASSIGN nv_dlevper = 0.
         END.
     END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132 C-Win 
PROCEDURE proc_adduwd132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_campaign AS CHAR FORMAT "x(20)" INIT "" . /*A62-0493*/
/* add by : A64-0328*/
DEF VAR nv_412    AS DECIMAL.
DEF VAR nv_411t   AS DECIMAL.   
DEF VAR nv_412t   AS DECIMAL.   
DEF VAR nv_42t    AS DECIMAL.   
DEF VAR nv_43t    AS DECIMAL. 
DEF VAR nv_ry31   AS DECIMAL. /*A68-0061*/
DEF VAR nv_comment   AS CHAR FORMAT "x(250)" .
DEF VAR nv_warning   AS CHAR FORMAT "x(250)" .
DEF VAR nv_pass      AS CHAR .
/* end : A64-0328*/
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "015-4:" TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.

DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
   
    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0
          /* A64-0328 */ 
           nv_411t = 0      nv_412t = 0         nv_42t  = 0      nv_43t  = 0
           nv_comment = ""  nv_warning  = ""    nv_pass = ""     nv_ry31 = 0 /*A68-0061*/
           /* end : A64-0328 */ 
           nv_campaign = ""  /*A62-0493*/
           /*nv_campaign = IF INDEX(wdetail2.special2,"TRIPLE PACK") <> 0 THEN TRIM(fi_camp_tp) ELSE TRIM(fi_camp_sp) . /*A62-0493*/*/
          /* commment by : A64-0328...
           nv_campaign = IF      INDEX(wdetail2.special2,"TRIPLE PACK") <> 0 THEN TRIM(fi_camp_tp) 
                         ELSE IF INDEX(wdetail2.detailcam,"HEI 20-D")      <> 0 THEN  "HEI20-D"
                         ELSE IF INDEX(wdetail2.detailcam,"HATC CAMPAIGN") <> 0 THEN  "HEI20-H"
                         ELSE IF wdetail.covcod = "2.2" OR wdetail.covcod = "3.2" THEN "HEI-PLUS" /*a63-0443*/
                         ELSE TRIM(fi_camp_sp) . /*A62-0493*/*/
           /* add by : A64-0328 */
           nv_campaign = IF INDEX(wdetail2.detailcam,"HEI") <> 0 THEN trim(REPLACE(wdetail2.detailcam," ","")) 
                         ELSE IF INDEX(wdetail2.detailcam,"TRIPLE PACK") <> 0 THEN "TRIPLE PACK" 
                         ELSE IF INDEX(wdetail2.detailcam,"SUPER PACK")  <> 0 THEN "SUPER PACK"
                         ELSE TRIM(wdetail2.detailcam) . 
           /* end : A64-0328 */

    FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
         /*pmuwd132.campcd        = trim(fi_camp_SP)  AND*/ /*A62-0493*/
         stat.pmuwd132.campcd        = trim(nv_campaign)   AND /*A62-0493*/
         stat.pmuwd132.policy   = TRIM(nv_polmaster)  NO-LOCK.
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
              sic_bran.uwd132.gap_ae  =  NO /*stat.pmuwd132.gap_ae A64-0328 */                 
              sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
              sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
              sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
              sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
              sic_bran.uwd132.pd_aep  =  "E" /*stat.pmuwd132.pd_aep A64-0328 */                   
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
           IF sic_bran.uwd132.bencod = "dspc" THEN ASSIGN nv_dss_per  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
           IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).

            /* add by : Ranu I. A64-0328 */
           IF sic_bran.uwd132.bencod = "dstf" THEN ASSIGN  n_dstf  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
           IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  wdetail2.NO_41  = TRIM(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
           IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  nv_412          = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
           IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  wdetail2.NO_42  = trim(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
           IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  wdetail2.NO_43  = trim(SUBSTRING(sic_bran.uwd132.benvar,31,30)).   
           IF sic_bran.uwd132.bencod = "31"   THEN ASSIGN  nv_ry31 = stat.pmuwd132.prem_c . /* A68-0061*/

           IF sic_bran.uwd132.bencod = "FLET" AND TRIM(stat.pmuwd132.benvar) = "" THEN DO:
               ASSIGN sic_bran.uwd132.benvar = "     Fleet Discount %  =      10 " .
           END.
           /* end A64-0328 */
           If nv_ncbper  <> 0 Then do:
               Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                   sicsyac.xmm104.tariff = nv_tariff           AND
                   sicsyac.xmm104.class  = nv_class            AND 
                   sicsyac.xmm104.covcod = nv_covcod           AND 
                   sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
               IF not avail  sicsyac.xmm104  Then do:
                   Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                   ASSIGN wdetail2.pass    = "N"
                       wdetail2.comment = wdetail2.comment + "| This NCB Step not on NCB Rates file xmm104. ".
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
            sic_bran.uwm301.ncbyrs   = nv_ncbyrs 
            sic_bran.uwm301.mv41seat = wdetail2.seat41. /*A64-0328*/

           IF nv_bptr <> 0 THEN DO:
               FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                   wf_uwd132.fptr = RECID(sic_bran.uwd132).
           END.
           IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
           nv_bptr = RECID(sic_bran.uwd132).

         END. /* end not sic_bran.uwd132 */
    END. /* end stat.pmuwd132 */
    /* add by : A64-0328 */
    OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
    PUT "015-5:" TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
    OUTPUT CLOSE.
    RUN wgw\wgwchkpadd 
        (input        sic_bran.uwm100.comdat, 
         input        sic_bran.uwm100.expdat, 
         input        wdetail2.subclass, /* 110 ,210 ,320 */
         input        int(wdetail2.NO_41)  ,  
         input        nv_412  ,  
         input        int(wdetail2.NO_42)   ,  
         input        int(wdetail2.NO_43)   ,  
         input        int(wdetail2.seat41) ,  
         input        nv_411t,  
         input        nv_412t,  
         input        nv_42t ,  
         input        nv_43t ,  
         input        nv_polmaster,
         input        nv_campaign ,
         input-output nv_comment  ,
         input-output nv_warning  ,
         input-output nv_pass    ). 
    if nv_comment <> "" then assign wdetail2.comment  = wdetail2.comment + "|" + trim(nv_comment) .
    if nv_warning <> "" then assign wdetail2.warning  = wdetail2.warning + "|" + trim(nv_warning) .
    ASSIGN wdetail2.pass = IF wdetail2.pass = "N" THEN "N" ELSE nv_pass . 
    
    IF nv_gapprm <> DECI(wdetail.premt) THEN DO:
         /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt VIEW-AS ALERT-BOX.*/
         ASSIGN
                wdetail2.comment = wdetail2.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
                wdetail2.WARNING = wdetail2.WARNING + "|เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt
                wdetail2.pass    = IF wdetail2.pass = "N" THEN "N" ELSE "Y"     
                wdetail2.OK_GEN  = "N".
    END.
    /* end A64-0328 */
     /* Add by : A68-0061*/
    ASSIGN nv_cal = IF wdetail2.TYPE_notify = "N" THEN tg_flag ELSE tg_flagRN .
    IF nv_cal = YES AND wdetail.garage = "G" AND INDEX("110,120,210,220,230,320,327,340,347",wdetail2.subclass) <> 0 AND nv_ry31 = 0 THEN DO:
        ASSIGN 
               wdetail2.comment  = wdetail2.comment + "| Class " + wdetail2.subclass + " New Tariff Garage = G ต้องมีเบี้ย รย.31 " 
               wdetail2.WARNING  = wdetail2.subclass + " New Tariff Garage = G ต้องมีเบี้ย รย.31 "  .
    END.
    /* end : A68-0061*/
    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132Plus C-Win 
PROCEDURE proc_adduwd132Plus :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
/* add by : A64-0328*/
DEF VAR nv_412    AS DECIMAL.
DEF VAR nv_411t   AS DECIMAL.   
DEF VAR nv_412t   AS DECIMAL.   
DEF VAR nv_42t    AS DECIMAL.   
DEF VAR nv_43t    AS DECIMAL.
DEF VAR nv_ry31 AS DECI INIT 0. /*A68-0061*/
DEF VAR nv_comment   AS CHAR FORMAT "x(250)" .
DEF VAR nv_warning   AS CHAR FORMAT "x(250)" .
DEF VAR nv_pass      AS CHAR .
/* end : A64-0328*/
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "015-3:" TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.

DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
   
    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0
           /* A64-0328 */ 
           nv_411t = 0      nv_412t = 0         nv_42t  = 0      nv_43t  = 0
           nv_comment = ""  nv_warning  = ""    nv_pass = ""     nv_ry31 = 0 . /*A68-0061*/
           /* end : A64-0328 */ 

     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              /*stat.pmuwd132.campcd       = trim(wdetail2.Campaign)  AND*/ /*A63-0443*/
              stat.pmuwd132.campcd        = trim(wdetail2.detailcam)  AND   /*A64-0328*/
              stat.pmuwd132.policy        = TRIM(nv_polmaster)  NO-LOCK.
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
                  sic_bran.uwd132.gap_ae  =  NO /*stat.pmuwd132.gap_ae A64-0328 */                 
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  "E" /*stat.pmuwd132.pd_aep A64-0328 */                   
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
               IF sic_bran.uwd132.bencod = "dspc" THEN ASSIGN nv_dss_per  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
               IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).

               /* add by : Ranu I. A64-0328 */
               IF sic_bran.uwd132.bencod = "DSTF" THEN ASSIGN  n_dstf  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
               IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  wdetail2.NO_41  = TRIM(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  nv_412          = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  wdetail2.NO_42  = trim(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  wdetail2.NO_43  = trim(SUBSTRING(sic_bran.uwd132.benvar,31,30)).   
               IF sic_bran.uwd132.bencod = "31"   THEN ASSIGN nv_ry31 = stat.pmuwd132.prem_c . /* A68-0061*/

               IF sic_bran.uwd132.bencod = "FLET" AND TRIM(stat.pmuwd132.benvar) = "" THEN DO:
                   ASSIGN sic_bran.uwd132.benvar = "     Fleet Discount %  =      10 " .
               END.
               /* end A64-0328 */
               If nv_ncbper  <> 0 Then do:
                   Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                       sicsyac.xmm104.tariff = nv_tariff           AND
                       sicsyac.xmm104.class  = nv_class            AND 
                       sicsyac.xmm104.covcod = nv_covcod           AND 
                       sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
                   IF not avail  sicsyac.xmm104  Then do:
                       Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                       ASSIGN wdetail2.pass    = "N"
                           wdetail2.comment = wdetail2.comment + "| This NCB Step not on NCB Rates file xmm104. ".
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
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs 
                sic_bran.uwm301.mv41seat = wdetail2.seat41. /*A64-0328*/

               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).
            END.
        END.
         /* add by : A64-0328 */
        OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
        PUT "015-5:" TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
        OUTPUT CLOSE.
        RUN wgw\wgwchkpadd 
            (input        sic_bran.uwm100.comdat, 
             input        sic_bran.uwm100.expdat, 
             input        wdetail2.subclass, /* 110 ,210 ,320 */
             input        int(wdetail2.NO_41)  ,  
             input        nv_412  ,  
             input        int(wdetail2.NO_42)   ,  
             input        int(wdetail2.NO_43)   ,  
             input        int(wdetail2.seat41) ,  
             input        nv_411t,  
             input        nv_412t,  
             input        nv_42t ,  
             input        nv_43t ,  
             input        nv_polmaster,
             input        wdetail2.detailcam ,
             input-output nv_comment  ,
             input-output nv_warning  ,
             input-output nv_pass    ). 
        if nv_comment <> "" then assign wdetail2.comment  = wdetail2.comment + "|" + trim(nv_comment) .
        if nv_warning <> "" then assign wdetail2.warning  = wdetail2.warning + "|" + trim(nv_warning) .
        ASSIGN wdetail2.pass = IF wdetail2.pass = "N" THEN "N" ELSE nv_pass .  

        IF nv_gapprm <> DECI(wdetail.premt) THEN DO:
         /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt VIEW-AS ALERT-BOX.*/
            ASSIGN
                wdetail2.comment = wdetail2.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
                wdetail2.WARNING = wdetail2.WARNING + "|เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt
                wdetail2.pass    = IF wdetail2.pass = "N" THEN "N" ELSE "Y"     
                wdetail2.OK_GEN  = "N".
        END.
        /* end A64-0328 */
         /* Add by : A68-0061*/
         ASSIGN nv_cal = IF wdetail2.TYPE_notify = "N" THEN tg_flag ELSE tg_flagRN .
         IF nv_cal = YES AND wdetail.garage = "G" AND INDEX("110,120,210,220,230,320,327,340,347",wdetail2.subclass) <> 0 AND nv_ry31 = 0 THEN DO:
             ASSIGN 
                    wdetail2.comment  = wdetail2.comment + "| Class " + wdetail2.subclass + " New Tariff Garage = G ต้องมีเบี้ย รย.31 " 
                    wdetail2.WARNING  = wdetail2.subclass + " New Tariff Garage = G ต้องมีเบี้ย รย.31 "  .
         END.
         /* end : A68-0061*/

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
  Notes: add by Ranu I. A64-0328       
------------------------------------------------------------------------------*/
DEF VAR nv_ry31 AS DECI INIT 0. /*A68-0061*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "015-7:" TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0     nv_ry31 = 0 . /*A68-0061*/
     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              /*stat.pmuwd132.campcd    = sic_bran.uwm100.policy AND --A68-0061--*/
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
                  sic_bran.uwd132.gap_ae  =  NO /*stat.pmuwd132.gap_ae A64-0328 */                  
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  "E" /*stat.pmuwd132.pd_aep A64-0328 */                
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
              
               IF sic_bran.uwd132.bencod = "31" THEN ASSIGN nv_ry31 = stat.pmuwd132.prem_c . /* A68-0061*/

               IF SUBSTR(sic_bran.uwd132.bencod,1,3) = "GRP" AND wdetail.cargrp <> "" THEN DO:
                   ASSIGN   sic_bran.uwd132.bencod = nv_grpcod
                            sic_bran.uwd132.benvar = nv_grpvar .
               END.
               IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)). 
               IF sic_bran.uwd132.bencod = "DSTF" THEN ASSIGN n_dstf      = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).

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
                   ASSIGN wdetail2.pass    = "N"
                          wdetail2.comment = wdetail2.comment + "| This NCB Step not on NCB Rates file xmm104. ".
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
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs 
                sic_bran.uwm301.mv41seat = wdetail2.seat41. /*A64-0328*/
            
            DELETE stat.pmuwd132 .  
    END. /* end pmuwd132 */

    IF nv_gapprm <> DECI(wdetail.premt) THEN DO:
         /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt VIEW-AS ALERT-BOX.*/
         ASSIGN
                wdetail2.comment = wdetail2.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
                wdetail2.WARNING = wdetail2.WARNING + "|เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt
                wdetail2.pass    = IF wdetail2.pass = "N" THEN "N" ELSE "Y"  
                wdetail2.OK_GEN  = "N".
    END.
    /* Add by : A68-0061*/
    ASSIGN nv_cal = IF wdetail2.TYPE_notify = "N" THEN tg_flag ELSE tg_flagRN .
    IF nv_cal = YES AND wdetail.garage = "G" AND INDEX("110,120,210,220,230,320,327,340,347",wdetail2.subclass) <> 0 AND nv_ry31 = 0 THEN DO:
        ASSIGN 
               wdetail2.comment  = wdetail2.comment + "| Class " + wdetail2.subclass + " New Tariff Garage = G ต้องมีเบี้ย รย.31 " 
               wdetail2.WARNING  = wdetail2.subclass + " New Tariff Garage = G ต้องมีเบี้ย รย.31 "  .
    END.
    /* end : A68-0061*/

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
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_process = "Create data HCT....".
DISP fi_process WITH FRAM fr_main.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    CREATE wdetail2.
    CREATE wdetail3.
    IMPORT UNFORMATTED c.
    IF (index(SUBSTRING(c,1,10),"จำนวน") <> 0) OR (SUBSTRING(c,1,10) = "")  THEN NEXT.
    ELSE
        RUN proc_assigninit.    
        
END.           /*-Repeat-*/
INPUT CLOSE.   /*close Import*/

RUN proc_assign2.   

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
DEF VAR  name2    AS CHAR FORMAT "x(60)" INIT "" .  /*ranu*/
DEF VAR  name3    AS CHAR FORMAT "x(60)" INIT "" .  /*ranu*/
DEF VAR  delname  AS CHAR FORMAT "x(60)" INIT "" .  /*ranu*/
DEF VAR  b_eng    AS DECI FORMAT  ">>>>9.99-".
DEF VAR  n_date   AS CHAR FORMAT  "x(10)".
DEF VAR  n_garage72 AS CHAR FORMAT  "x(10)".
DEF VAR  n_classev  AS CHAR FORMAT  "x(10)".
FOR EACH wdetail WHERE wdetail.policyno NE " "  .
    FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno . 
        FOR EACH wdetail3 WHERE wdetail3.policyno = wdetail.policyno . 
            ASSIGN n_firstdat = ?   n_producer       = ""       n_textfi         = ""    
            n_date           = STRING(TODAY,"99/99/9999")
            b_eng            = round((DECI(wdetail.engcc) / 1000),1)     /*format engcc */
            b_eng            = b_eng * 1000
            wdetail.seat     = IF INTEGER(wdetail.seat) = 0 THEN  "7" ELSE wdetail.seat 
            wdetail2.tariff  = IF wdetail2.poltyp = "v72" THEN "9" ELSE "x" 
            wdetail2.prempa  = IF      (wdetail.covcod = "5" OR wdetail.covcod = "2.2" ) THEN fi_packpuls   /*covcod 2.1,3.1 */
                               ELSE IF (wdetail.covcod = "9" OR wdetail.covcod = "3.2" ) THEN fi_packpuls   /*covcod 2.1,3.1 */
                               ELSE IF (wdetail.garage = "GARAGE") OR (wdetail.garage = "ซ่อมอู่")   AND (wdetail.covcod = "1")  THEN fi_packnogar
                               ELSE IF (wdetail.garage = "honda")  OR (wdetail.garage = "ซ่อมห้าง")  AND (wdetail.covcod = "1")  THEN fi_packgarage
                               ELSE IF (wdetail.covcod = "3")      THEN fi_packcov3
                               ELSE fi_packgarage
            wdetail.country  = wdetail.country                          
            wdetail.covcod   = IF      wdetail.covcod = "0" THEN "T" 
                               ELSE IF wdetail.covcod = "T" THEN "T" 
                               ELSE IF wdetail.covcod = "5" AND  deci(wdetail.deduct) = 2000 THEN "2.1"         
                               ELSE IF wdetail.covcod = "5" AND (deci(wdetail.deduct) = 0 OR wdetail.deduct = "" ) THEN "2.2"   
                               ELSE IF wdetail.covcod = "9" AND deci(wdetail.deduct) = 2000 THEN "3.1"       
                               ELSE IF wdetail.covcod = "9" AND (deci(wdetail.deduct) = 0 OR wdetail.deduct = "" ) THEN "3.2"     
                               ELSE IF wdetail.covcod = "2.2" AND wdetail.deduct = "2000"  THEN  "2.1"                 
                               ELSE IF wdetail.covcod = "3.2" AND wdetail.deduct = "2000"  THEN  "3.1"  
                               ELSE    wdetail.covcod .
            
            IF wdetail.typecar = "EV" THEN ASSIGN wdetail2.watt = deci(wdetail.engcc)   wdetail.engcc = "0" .
            IF wdetail2.poltyp = "v70" THEN DO:
                IF      (wdetail.covcod = "5") AND (wdetail.garage = "honda") AND (wdetail2.poltyp = "v70") THEN wdetail.garage   = "G" .
                ELSE IF (wdetail.covcod = "9") AND (wdetail.garage = "honda") AND (wdetail2.poltyp = "v70") THEN wdetail.garage   = "G" .
                ELSE IF (wdetail.garage = "honda")    AND (wdetail2.poltyp = "v70") THEN wdetail.garage   = "G"  .
                ELSE IF (wdetail.garage = "ซ่อมห้าง") AND (wdetail2.poltyp = "v70") THEN wdetail.garage   = "G"  .
                ELSE  wdetail.garage   = ""  .
            END.
            ELSE ASSIGN n_garage72 = ""    n_garage72 = wdetail.garage.
            
            IF wdetail.insnam = "ฮอนด้า ออโตโมบิล (ประเทศไทย) จำกัด" AND ( wdetail.saletyp = "N" AND 
              wdetail2.TYPE_notify = "S" OR wdetail2.TYPE_notify = "R" ) THEN DO:
                ASSIGN wdetail2.producer = "B3M0070"
                       wdetail2.fleet    = "10" 
                       wdetail.garage    = "G"  .
              IF wdetail.covcod =  "2.1" OR wdetail.covcod = "2.2" OR wdetail.covcod =  "3.1" OR wdetail.covcod = "3.2" THEN DO:
                  ASSIGN 
                       wdetail.comper    = "500000"
                       wdetail.comacc    = "10000000"
                       wdetail.deductpd  = "5000000"
                       WDETAIL2.no_41    = "200000"                   
                       WDETAIL2.no_42    = "200000"                   
                       WDETAIL2.no_43    = "300000" .
              END.
            END.
            ELSE IF wdetail.typecar = "EV" OR index(wdetail2.detailcam,"N1-EV") <> 0 OR  index(wdetail.model,"e:N1") <> 0 THEN DO:
                ASSIGN wdetail2.producer = "B3M0071".
                IF INDEX(TRIM(wdetail.tiname),"บริษัท")       <> 0  OR INDEX(TRIM(wdetail.tiname),"บจก.")              <> 0 OR   
                   INDEX(TRIM(wdetail.tiname),"หจก.")         <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้าง")              <> 0 OR  
                   R-INDEX(TRIM(wdetail.insnam),"จก.")        <> 0  OR R-INDEX(TRIM(wdetail.insnam),"จำกัด")           <> 0 OR  
                   R-INDEX(TRIM(wdetail.insnam),"(มหาชน)")    <> 0  OR R-INDEX(TRIM(wdetail.insnam),"INC.")            <> 0 OR 
                   R-INDEX(TRIM(wdetail.insnam),"CO.")        <> 0  OR R-INDEX(TRIM(wdetail.insnam),"LTD.")            <> 0 OR 
                   R-INDEX(TRIM(wdetail.insnam),"LIMITED")    <> 0  OR INDEX(TRIM(wdetail.tiname),"มูลนิธิ")           <> 0 OR 
                   INDEX(TRIM(wdetail.tiname),"บ.")           <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0 OR  
                   INDEX(TRIM(wdetail.tiname),"หสน.")         <> 0  OR INDEX(TRIM(wdetail.tiname),"บรรษัท")            <> 0 OR 
                   INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วน") <> 0  OR INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0 OR 
                   INDEX(TRIM(wdetail.tiname),"และ/หรือ")     <> 0  THEN n_classev = "E12".
                ELSE n_classev = "E11".

                IF      DECI(wdetail.si) = 800000 AND  DECI(wdetail.premt) = 24278 THEN ASSIGN wdetail2.producer = "B3M0060"  n_classev = "E11". 
                ELSE IF DECI(wdetail.si) = 800000 AND  DECI(wdetail.premt) = 26875 THEN ASSIGN wdetail2.producer = "B3M0060"  n_classev = "E12". 
                
                IF      n_classev = "E11" THEN wdetail.vehuse    = "1".
                ELSE IF n_classev = "E12" THEN wdetail.vehuse    = "2".
                IF index(wdetail2.detailcam,"N1-EV") <> 0 THEN wdetail.vehuse    = "2".

                IF wdetail.covcod = "T" OR wdetail.covcod = "0" THEN DO:
                    FIND LAST brstat.tlt USE-INDEX tlt06  WHERE                                  
                        brstat.tlt.cha_no       = trim(wdetail.chasno)  AND                      
                        brstat.tlt.eng_no       = TRIM(wdetail.eng)     AND                      
                        brstat.tlt.nor_usr_ins  <> "0"                  AND
                        brstat.tlt.genusr       = "HCT"              NO-ERROR NO-WAIT .
                    IF  AVAIL brstat.tlt THEN DO: 
                        IF      DECI(brstat.tlt.note17) = 800000 AND  DECI(brstat.tlt.note18) = 24278 THEN ASSIGN wdetail2.producer = "B3M0060"  n_classev = "E11". 
                        ELSE IF DECI(brstat.tlt.note17) = 800000 AND  DECI(brstat.tlt.note18) = 26875 THEN ASSIGN wdetail2.producer = "B3M0060"  n_classev = "E12". 
                    END.
                    ASSIGN  wdetail.garage = "" .    /*A67-0211*/ 
                            /*wdetail2.subclass  = IF n_classev = "E12" THEN "E12CA" ELSE "E11PA". A68-0061 */        /*wdetail2.subclass  = "210E" */
                END.
                /*ELSE  ASSIGN wdetail2.subclass =  IF n_classev = "E12" THEN "E12" ELSE "E11".  A68-0061*/  /*V70*/ /*ELSE ASSIGN wdetail2.subclass  = "120E" .*/
            END.
            /* end :A67-0065 */
            ELSE IF wdetail.covcod = "T" OR wdetail.covcod = "0" THEN DO:
                ASSIGN wdetail.garage = n_garage72 .   /*A67-0160*/
                IF wdetail2.producer = "" THEN RUN proc_assign3.
                ASSIGN wdetail.garage = ""  .
            END.
            ELSE DO:  /* V70 */
                IF index(wdetail2.detailcam,"super pack") <> 0 THEN DO:
                    FIND FIRST wimproducer WHERE 
                          wimproducer.saletype = TRIM(wdetail.saletyp)        AND 
                     TRIM(wimproducer.camname) = TRIM(wdetail2.detailcam)     AND  /*Add by Sarinya C A62/0215*/ 
                          wimproducer.notitype = TRIM(wdetail2.TYPE_notify)   NO-LOCK NO-ERROR NO-WAIT. 
                      IF AVAIL  wimproducer THEN  
                          ASSIGN  wdetail2.producer   = wimproducer.producer   
                                  wdetail2.producer2  = wimproducer.producer.
                END. /* end A61-0324 */
                ELSE IF index(wdetail2.detailcam,"TMSTH 0%") <> 0 OR index(wdetail2.detailcam,"TMSTH0%") <> 0 OR index(wdetail2.detailcam,"DEMON_H") <> 0 THEN RUN proc_assign4.
                ELSE IF wdetail.saletyp = "C" THEN DO:
                   IF wdetail.covcod = "1"  AND wdetail2.TYPE_notify = "S" THEN DO:
                        IF wdetail.garage = "" AND 
                          (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 2 ) AND (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 10 ) THEN DO:
                            ASSIGN wdetail2.producer = "B3M0062". 
                        END.
                        ELSE ASSIGN wdetail2.producer = "B3M0065".
                    END.
                    ELSE IF wdetail.covcod <> "1" AND (wdetail2.TYPE_notify = "S" OR wdetail2.TYPE_notify = "R" OR wdetail2.TYPE_notify = "N") THEN DO:  
                        ASSIGN wdetail2.producer = "B3M0062".  
                    END.
                    ELSE DO:  
                        FIND FIRST wimproducer WHERE wimproducer.saletype = TRIM(wdetail.saletyp)        AND
                            TRIM(wimproducer.camname) = TRIM(wdetail2.detailcam)     AND  
                            wimproducer.notitype = TRIM(wdetail2.TYPE_notify)   NO-LOCK NO-ERROR NO-WAIT. 
                        IF AVAIL  wimproducer THEN  
                            ASSIGN  wdetail2.producer   = wimproducer.producer   
                                    wdetail2.producer2  = wimproducer.producer.
                        ELSE ASSIGN wdetail2.producer   =  fi_producer01.
                    END.
                END.
                ELSE IF wdetail.saletyp = "H" THEN   ASSIGN wdetail2.producer = "B3M0063".  
                ELSE DO:    
                   IF wdetail.covcod = "1"  AND wdetail2.TYPE_notify = "S" THEN DO:
                       IF wdetail.garage = "" AND (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 2 ) AND (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 10 ) THEN DO:
                           ASSIGN wdetail2.producer = "B3M0062". 
                       END.
                       ELSE ASSIGN wdetail2.producer = "B3M0065".
                   END. 
                   ELSE IF wdetail.covcod <> "1" AND (wdetail2.TYPE_notify = "S" OR wdetail2.TYPE_notify = "R" OR wdetail2.TYPE_notify = "N") THEN DO:  
                           ASSIGN wdetail2.producer = "B3M0062".  
                   END.
                   ELSE DO: 
                     FIND FIRST wimproducer WHERE 
                          wimproducer.saletype = TRIM(wdetail.saletyp)        AND 
                     TRIM(wimproducer.camname) = TRIM(wdetail2.detailcam)     AND  /*Add by Sarinya C A62/0215*/ 
                          wimproducer.notitype = TRIM(wdetail2.TYPE_notify)   NO-LOCK NO-ERROR NO-WAIT. 
                      IF AVAIL  wimproducer THEN  
                          ASSIGN  wdetail2.producer   = wimproducer.producer   
                                  wdetail2.producer2  = wimproducer.producer.
                      ELSE ASSIGN wdetail2.producer   =  fi_producer01.
                   END.
                   ASSIGN wdetail2.ins_pay   = trim(wdetail2.n_month + wdetail2.n_bank) .
                END. 
            END. /* V70 */
            IF index(wdetail2.detailcam,"HATC-S") <> 0 THEN ASSIGN wdetail2.producer = "B3M0070".
            IF wdetail2.producer = ""  THEN wdetail2.producer = trim(fi_producer01).
            
            IF wdetail.caryear = "" THEN wdetail.caryear =  string(YEAR(TODAY),"9999").
            IF wdetail.prepol <> "" THEN RUN proc_cutchar.

            RUN proc_chkaddr. /*add by A68-0061 */
            RUN proc_chkredbook . /* Add by : A68-0061 */

            IF wdetail.vehreg = "" THEN ASSIGN wdetail.vehreg   = "/" + SUBSTRING(wdetail.chasno,9,LENGTH(wdetail.chasno)) .  /* ทะเบียนรถมาMRHCP16309P302579 */ /*A63-0443 08/10/20*/
            ELSE IF substr(wdetail.vehreg,9,2) = "" THEN RUN proc_assign_vehrenew.   /*  kridtiya i. A53-0220  22/07/2010 */
            /*add kridtiya i. A53-0027...............*/
            FIND LAST stat.insure USE-INDEX insure01 WHERE 
                    stat.insure.compno = "HCT" AND
                    stat.insure.lname  = wdetail2.comrequest   NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL stat.insure THEN DO: 
                    ASSIGN 
                        wdetail3.name3        = TRIM(stat.insure.fname)    /* A58-0198 */
                        wdetail2.n_branch     = trim(stat.insure.branch)   
                        wdetail2.n_delercode  = trim(stat.insure.insno)    
                        wdetail3.financecd    = trim(stat.Insure.Text3)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                        wdetail2.typrequest   = trim(stat.insure.vatcode)  /*เปลี่ยน เป็นเก็บค่า vatcode.*/
                        n_textfi              = TRIM(stat.insure.addr3) .  /*A540125*/ 
                    IF wdetail2.voictitle = "1" THEN wdetail2.typrequest  = "".
                END.
                ELSE DO:
                    ASSIGN
                        wdetail2.n_branch    = ""
                        wdetail2.n_delercode = "" 
                        wdetail2.typrequest  = "" 
                        wdetail3.name3       = ""
                        wdetail3.financecd   = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                        n_textfi             = "" .  /*A540125*/ 
                END.
             IF  wdetail2.poltyp = "V70" THEN DO:
                 IF  wdetail3.instot > 1  THEN DO:
                     /* add by A64-0422 : 05/10/2021 */
                     IF INDEX(wdetail2.detailcam,"HATC CAMPAIGN") <> 0 THEN DO:            /* Ranu I. A64-0422 05/10/2021*/
                         ASSIGN wdetail2.name4      = "และ/หรือ บริษัท ฮอนด้า ออโตโมบิล (ประเทศไทย) จำกัด" 
                                wdetail3.companyre1 = CAPS(trim(fi_producerinst)) + " " +  trim(wdetail3.companyre1). 
                     END.
                     ELSE IF INDEX(wdetail2.detailcam,"HLTC CAMPAIGN") <> 0 THEN DO:
                         ASSIGN wdetail2.name4      = "และ/หรือ บริษัท ฮอนด้า ลีสซิ่ง (ประเทศไทย) จำกัด"
                                wdetail3.companyre1 = "MC34018" + " " +  trim(wdetail3.companyre1).
                     END.
                     /* end : A64-0422 05/10/2021 */
                     /*2 3 INSTALMENTS */
                     IF wdetail3.name3 <> "" THEN DO:
                         ASSIGN name2   = trim(REPLACE(wdetail3.companyre2," ",""))
                                name3   = trim(REPLACE(wdetail3.companyre3," ",""))
                                delname = TRIM(REPLACE(wdetail3.name3," ","")).  
                         IF wdetail3.companyre2 <> "" THEN DO:
                             IF  index(name2,delname) <> 0 THEN /* ranu */
                                 ASSIGN 
                                 wdetail3.name3       = "และ/หรือ " + trim(wdetail3.name3)
                                 wdetail3.companyre2  = caps(trim(wdetail2.typrequest)) + " " + trim(wdetail3.companyre2).
                         END.
                         ELSE IF wdetail3.companyre3 <> "" THEN DO:
                             IF  index(name3,delname) <> 0 THEN /* ranu */
                                 ASSIGN 
                                 wdetail3.name3       = "และ/หรือ " + trim(wdetail3.name3)
                                 wdetail3.companyre3  = caps(trim(wdetail2.typrequest)) + " " + trim(wdetail3.companyre3).
                         END.
                         ELSE wdetail3.name3 = "".
                     END.
                 END.
                 ELSE wdetail3.name3 = "".
             END.
             ELSE wdetail3.name3 = "".
             /* add A540125*/ 
             IF (n_textfi <> "") AND (INDEX(n_textfi,"fi") <> 0) THEN DO:
                 n_textfi   = wdetail2.comrequest + "/" + wdetail2.comcar  .
                 FIND LAST stat.insure USE-INDEX insure01 WHERE 
                     stat.insure.compno = "HCT" AND
                     stat.insure.lname  = wdetail2.comcar   NO-LOCK NO-WAIT NO-ERROR.
                 IF AVAIL stat.insure THEN DO: 
                     ASSIGN wdetail2.n_branch  = trim(stat.insure.branch)
                         wdetail2.n_delercode  = trim(stat.insure.insno) 
                         wdetail3.financecd    = trim(stat.Insure.Text3)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                         wdetail2.typrequest   = trim(stat.insure.vatcode) .  /*เปลี่ยน เป็นเก็บค่า vatcode.*/
                     IF wdetail2.voictitle = "1" THEN wdetail2.typrequest  = "".
                 END.
                 ELSE 
                     ASSIGN
                         wdetail2.n_branch    = ""
                         wdetail2.n_delercode = "" 
                         wdetail3.financecd   = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
                         wdetail2.typrequest  = "" .
             END.  /*end add ...A540125*/ 
             ELSE n_textfi   = wdetail2.comrequest + "/" + wdetail2.comcar  .
        END. /* end wdetail3 */
         /* add A63-0112 */
        IF DATE(wdetail.comdat) >= 04/01/2020 THEN DO:
           ASSIGN wdetail2.prempa  = "T" .
        END.
    END. /* end wdetail2*/
END. /* end wdetail*/

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

FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE 
    sicuw.uwm500.prov_d = np_mail_country  NO-LOCK NO-ERROR NO-WAIT.  /*"กาญจนบุรี"*/   /*uwm100.codeaddr1*/
IF AVAIL sicuw.uwm500 THEN DO:  
    /*DISP sicuw.uwm500.prov_n .*/
    FIND LAST sicuw.uwm501 USE-INDEX uwm50102   WHERE 
        sicuw.uwm501.prov_n = sicuw.uwm500.prov_n  AND
        index(sicuw.uwm501.dist_d,np_mail_amper) <> 0        NO-LOCK NO-ERROR NO-WAIT. /*"พนมทวน"*/
    IF AVAIL sicuw.uwm501 THEN DO:  
        /*DISP
        sicuw.uwm501.prov_n  /* uwm100.codeaddr1 */
        sicuw.uwm501.dist_n  /* uwm100.codeaddr2 */.*/
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
DEF BUFFER bfuwm100 FOR sicuw.uwm100. /* A67-0065*/
IF wdetail.saletyp = "C" THEN DO:
    IF      index(wdetail2.detailcam,"DEMON_D")     <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0059".
    /*ELSE IF index(wdetail2.detailcam,"HEI 20-D")    <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0061".
    ELSE IF index(wdetail2.detailcam,"HEI 21-D")    <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0061".
    ELSE IF index(wdetail2.detailcam,"HEI 21-S")    <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0061".
    ELSE IF index(wdetail2.detailcam,"HEI 22-D")    <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0061".
    ELSE IF index(wdetail2.detailcam,"HEI 22_S")    <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0061".*/
    ELSE IF index(wdetail2.detailcam,"HEI 23-D")    <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0061".
    ELSE IF index(wdetail2.detailcam,"HEI_CCTV")    <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0060".
    /*ELSE IF index(wdetail2.detailcam,"SUPER PACK")  <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"TRIPLE PACK") <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0066".*/
    ELSE IF index(wdetail2.detailcam,"HEI2Plus")    <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0062".
    ELSE IF index(wdetail2.detailcam,"HEI3Plus")    <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0062".
    /*ELSE IF index(wdetail2.detailcam,"SUPER PACK")  <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"TRIPLE PACK") <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0066".*/
    ELSE IF index(wdetail2.detailcam,"HEI2Plus")    <> 0 AND wdetail2.TYPE_notify = "S" THEN ASSIGN wdetail2.producer = "B3M0062".
    ELSE IF index(wdetail2.detailcam,"HEI3Plus")    <> 0 AND wdetail2.TYPE_notify = "S" THEN ASSIGN wdetail2.producer = "B3M0062". 
    ELSE IF index(wdetail2.detailcam,"Super Pack_DLR_23") <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"TMSTH 0%")     <> 0      AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0064".
    ELSE IF index(wdetail2.detailcam,"Super Pack_DLR_23") <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0066".
END.
ELSE IF wdetail.saletyp = "F" AND index(wdetail2.detailcam,"HLTC CAMPAIGN") <> 0  AND wdetail2.TYPE_notify = "N" THEN 
    ASSIGN wdetail2.producer = "B3M0068".
ELSE IF wdetail.saletyp = "H" THEN DO:
    IF      index(wdetail2.detailcam,"DEMON2YEAR_H")     <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0059".
    /*ELSE IF index(wdetail2.detailcam,"HATC CAMPAIGN_20") <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0063".
    ELSE IF index(wdetail2.detailcam,"HATC CAMPAIGN_21") <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0063".
    ELSE IF index(wdetail2.detailcam,"HATC CAMPAIGN_22") <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0063".
    ELSE IF index(wdetail2.detailcam,"SUPER PACK")       <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"SUPER PACK-H")     <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"SUPER PACK-H1")    <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"SUPER PACK-HD")    <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"TRIPLE PACK_H1")   <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0066".*/
    ELSE IF index(wdetail2.detailcam,"DEMON2YEAR_H")     <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0059".
    /*ELSE IF index(wdetail2.detailcam,"SUPER PACK")       <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"SUPER PACK-H")     <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"SUPER PACK-H1")    <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"SUPER PACK-HD")    <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"TRIPLE PACK_H1")   <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0066". */
    ELSE IF index(wdetail2.detailcam,"TMSTH 0%")         <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0058". 
    ELSE IF index(wdetail2.detailcam,"TMSTH 0%")         <> 0 AND wdetail2.TYPE_notify = "s" THEN ASSIGN wdetail2.producer = "B3M0058".
    ELSE IF index(wdetail2.detailcam,"DEMON_H")          <> 0                                THEN ASSIGN wdetail2.producer = "B3M0059".
    ELSE IF index(wdetail2.detailcam,"HATC CAMPAIGN_23") <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0063".
    ELSE IF index(wdetail2.detailcam,"Super Pack-H ฟรีปีที่ 1_23")       <> 0 AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF index(wdetail2.detailcam,"Super Pack-H ฟรีปีที่ 1_23")       <> 0 AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0066".
    ELSE IF                                                       wdetail2.TYPE_notify = "S" THEN ASSIGN wdetail2.producer = "B3M0065".
END.
ELSE IF wdetail.saletyp = "N" AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0060". 
ELSE IF wdetail.saletyp = "N" AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0062". 
ELSE IF wdetail.saletyp = "N" AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0064". 
ELSE IF wdetail.saletyp = "N" AND wdetail2.TYPE_notify = "S" THEN ASSIGN wdetail2.producer = "B3M0065".
ELSE IF wdetail.saletyp = "R" AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0062". 
ELSE IF wdetail.saletyp = "R" AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0065". 
ELSE IF wdetail.saletyp = "R" AND wdetail2.TYPE_notify = "S" THEN ASSIGN wdetail2.producer = "B3M0062". 
ELSE IF wdetail.saletyp = "S" AND wdetail2.TYPE_notify = "N" THEN ASSIGN wdetail2.producer = "B3M0062". 
ELSE IF wdetail.saletyp = "S" AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0064". 
ELSE IF wdetail.saletyp = "S" AND wdetail2.TYPE_notify = "R" THEN ASSIGN wdetail2.producer = "B3M0065". 
ELSE IF wdetail.saletyp = "S" AND wdetail2.TYPE_notify = "S" THEN ASSIGN wdetail2.producer = "B3M0062". 
ELSE IF wdetail.saletyp = "S" AND wdetail2.TYPE_notify = "S" THEN ASSIGN wdetail2.producer = "B3M0065". 
ELSE ASSIGN wdetail2.producer =  fi_producer01.
IF index(wdetail2.detailcam,"HATC-S") <> 0 THEN ASSIGN wdetail2.producer = "B3M0070".
IF wdetail2.producer = "" THEN DO: 
    FIND FIRST wimproducer WHERE 
        wimproducer.saletype      = TRIM(wdetail.saletyp)      AND 
        TRIM(wimproducer.camname) = TRIM(wdetail2.detailcam)   AND  /*Add by Sarinya C A62/0215*/ 
        wimproducer.notitype      = TRIM(wdetail2.TYPE_notify) NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL  wimproducer THEN  
        ASSIGN  wdetail2.producer   = wimproducer.producer   
        wdetail2.producer2  = wimproducer.producer.
    ELSE ASSIGN wdetail2.producer   =  fi_producer01.
END.
IF wdetail.prepol <> "" THEN DO:
    
    FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
      sicuw.uwm100.policy = trim(wdetail.prepol) No-lock No-error no-wait.
    IF AVAIL sicuw.uwm100  THEN DO:
       IF sicuw.uwm100.renpol <> " " THEN DO:
           /*  add by : A67-0065 */
           FIND LAST bfuwm100 WHERE 
               bfuwm100.policy = sicuw.uwm100.renpol AND 
               bfuwm100.polsta = "CA" AND 
               bfuwm100.releas = YES NO-LOCK NO-ERROR.
           IF AVAIL bfuwm100 THEN DO:
               /*IF wdetail.covcod = "1" THEN DO:*/
               IF      sicuw.uwm100.acno1 = "B3M0059"  THEN   ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
               ELSE IF      sicuw.uwm100.acno1 = "B3M0065"  THEN DO: 
                   ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
                   IF (wdetail.garage = ""  OR wdetail.garage = "GARAGE")  AND  (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 8 ) THEN
                       ASSIGN wdetail2.producer = "B3M0062" .
               END.
               ELSE IF sicuw.uwm100.acno1 = "B3M0062"  THEN ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
               ELSE IF sicuw.uwm100.acno1 = "B3M0064" OR sicuw.uwm100.acno1 = "B3M0061" OR sicuw.uwm100.acno1 = "B3M0063"  THEN DO:
                   ASSIGN wdetail2.producer = "B3M0064" .
                   /*IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 7 ) THEN  ASSIGN wdetail2.producer = "B3M0062" .*/
                   IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 2 ) AND  (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 7 ) THEN DO: 
                       IF (wdetail.garage = ""  OR wdetail.garage = "GARAGE") THEN ASSIGN wdetail2.producer = "B3M0062" .
                   END.
                   ELSE IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) > 7 ) THEN DO:  
                       IF (wdetail.garage = "G"  OR wdetail.garage = "HONDA") THEN ASSIGN wdetail2.producer = "B3M0064" .  /*ซ่อมห้าง*/
                       ELSE ASSIGN wdetail2.producer = "B3M0062" .
                   END.
               END.
               IF sicuw.uwm100.acno1 = "B3M0070" OR sicuw.uwm100.acno1 = "B3M0071" THEN ASSIGN wdetail2.producer = sicuw.uwm100.acno1. /* EV */ 
               /*END.*/
           END.
       END.
       ELSE DO: 
           /*IF wdetail.covcod = "1" THEN DO:*/
           IF      sicuw.uwm100.acno1 = "B3M0059"  THEN   ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
           ELSE IF      sicuw.uwm100.acno1 = "B3M0065"  THEN DO: 
               ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
               IF wdetail.garage = "" AND  (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 8 ) THEN
                   ASSIGN wdetail2.producer = "B3M0062" .
           END.
           ELSE IF sicuw.uwm100.acno1 = "B3M0062"  THEN ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
           ELSE IF sicuw.uwm100.acno1 = "B3M0064" OR sicuw.uwm100.acno1 = "B3M0061" OR sicuw.uwm100.acno1 = "B3M0063" THEN DO:
               ASSIGN wdetail2.producer = "B3M0064" .
               /*IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 7 ) THEN  ASSIGN wdetail2.producer = "B3M0062" .*/
               IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 2 ) AND  (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 7 ) THEN DO: 
                   IF (wdetail.garage = ""  OR wdetail.garage = "GARAGE") THEN ASSIGN wdetail2.producer = "B3M0062" .
               END.
               ELSE IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) > 7 ) THEN DO:  
                   IF (wdetail.garage = "G"  OR wdetail.garage = "HONDA") THEN ASSIGN wdetail2.producer = "B3M0064" . /*ซ่อมห้าง*/
                   ELSE ASSIGN wdetail2.producer = "B3M0062" .
               END.
           END.
           IF sicuw.uwm100.acno1 = "B3M0070" OR sicuw.uwm100.acno1 = "B3M0071" THEN ASSIGN wdetail2.producer = sicuw.uwm100.acno1. /* EV */ 
           /*END.*/
       END.
   End.   /*  avail  buwm100  */
   ASSIGN  
       wdetail2.producer   = wdetail2.producer  
       wdetail2.producer2  = wdetail2.producer.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign4 C-Win 
PROCEDURE proc_assign4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail.saletyp = "H" THEN DO:
    IF     ( index(wdetail2.detailcam,"TMSTH 0%") <> 0 OR  index(wdetail2.detailcam,"TMSTH0%") <> 0 ) AND  wdetail2.TYPE_notify = "R" THEN DO:
        FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
            sicuw.uwm100.policy = wdetail.prepol
            No-lock No-error no-wait.
        IF AVAIL sicuw.uwm100  THEN 
            ASSIGN  
            wdetail2.producer   = sicuw.uwm100.acno1 
            wdetail2.producer2  = sicuw.uwm100.acno1.
    END.
    ELSE IF     ( index(wdetail2.detailcam,"TMSTH 0%") <> 0 OR  index(wdetail2.detailcam,"TMSTH0%") <> 0 ) AND  wdetail2.TYPE_notify = "S" THEN DO:
        IF wdetail.covcod = "1"  AND wdetail.garage <> ""  THEN
            ASSIGN  
            wdetail2.producer   = "B3M0065"
            wdetail2.producer2  = "B3M0065".
        ELSE IF wdetail.covcod = "T" OR wdetail.covcod = "0" THEN  
            ASSIGN  
            wdetail2.producer   = "B3M0058"
            wdetail2.producer2  = "B3M0058".
        ELSE ASSIGN  
            wdetail2.producer   = "B3M0062"
            wdetail2.producer2  = "B3M0062".
    END.
    ELSE IF index(wdetail2.detailcam,"DEMON_H") <> 0  THEN 
        ASSIGN  
        wdetail2.producer   = "B3M0059"
        wdetail2.producer2  = "B3M0059".
                                  
END.
ELSE IF     ( index(wdetail2.detailcam,"TMSTH 0%") <> 0 OR  index(wdetail2.detailcam,"TMSTH0%") <> 0 ) AND  wdetail2.TYPE_notify = "R" THEN DO:
    FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
        sicuw.uwm100.policy = wdetail.prepol
        No-lock No-error no-wait.
    IF AVAIL sicuw.uwm100  THEN 
        ASSIGN  
        wdetail2.producer   = sicuw.uwm100.acno1 
        wdetail2.producer2  = sicuw.uwm100.acno1.
END.
ELSE IF     ( index(wdetail2.detailcam,"TMSTH 0%") <> 0 OR  index(wdetail2.detailcam,"TMSTH0%") <> 0 ) AND  wdetail2.TYPE_notify = "S" THEN DO:
    IF wdetail.covcod = "1"  AND wdetail.garage <> ""  THEN
        ASSIGN  
        wdetail2.producer   = "B3M0065"
        wdetail2.producer2  = "B3M0065".
    ELSE IF wdetail.covcod = "T" OR wdetail.covcod = "0" THEN  
        ASSIGN  
        wdetail2.producer   = "B3M0058"
        wdetail2.producer2  = "B3M0058".
    ELSE ASSIGN  
        wdetail2.producer   = "B3M0062"
        wdetail2.producer2  = "B3M0062".
END.
ELSE IF index(wdetail2.detailcam,"DEMON_H")  <> 0 THEN 
    ASSIGN  
    wdetail2.producer   = "B3M0059"
    wdetail2.producer2  = "B3M0059".

IF wdetail2.producer = "" AND wdetail2.producer2 = "" THEN DO:
    FIND FIRST wimproducer WHERE 
        wimproducer.saletype = TRIM(wdetail.saletyp)        AND 
        TRIM(wimproducer.camname) = TRIM(wdetail2.detailcam)     AND  /*Add by Sarinya C A62/0215*/ 
        wimproducer.notitype = TRIM(wdetail2.TYPE_notify)   NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL  wimproducer THEN  
        ASSIGN  
        wdetail2.producer   = wimproducer.producer   
        wdetail2.producer2  = wimproducer.producer.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigncode C-Win 
PROCEDURE proc_assigncode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail2.comrequest = "AKC" THEN ASSIGN wdetail2.n_branch = "5"       /*1*/
    wdetail2.n_delercode = "MH0C020".     
ELSE IF wdetail2.comrequest = "AN1"  THEN ASSIGN wdetail2.n_branch = "8" /*2*/
    wdetail2.n_delercode = "MH0C053". 
ELSE IF wdetail2.comrequest = "ANC"  THEN ASSIGN wdetail2.n_branch = "K" /*3*/
    wdetail2.n_delercode = "MH0C131".  
ELSE IF wdetail2.comrequest = "ANP"  THEN ASSIGN wdetail2.n_branch = "8" /*4*/
    wdetail2.n_delercode = "MH0C053". 
ELSE IF wdetail2.comrequest = "APN"  THEN ASSIGN wdetail2.n_branch = "8" /*5*/       
    wdetail2.n_delercode = "MH0C116". 
ELSE IF wdetail2.comrequest = "ARN"  THEN ASSIGN wdetail2.n_branch = "N" /*6*/
    wdetail2.n_delercode = "MH0C134". 
ELSE IF wdetail2.comrequest = "ARS"  THEN ASSIGN wdetail2.n_branch = "4" /*7*/ 
    wdetail2.n_delercode = "MH0C052". 
ELSE IF wdetail2.comrequest = "ATH"  THEN ASSIGN wdetail2.n_branch = "J" /*8*/
    wdetail2.n_delercode = "MH0C060".
ELSE IF wdetail2.comrequest = "AVB"  THEN ASSIGN wdetail2.n_branch = "6" /*9*/ 
    wdetail2.n_delercode = "MH0C112".  
ELSE IF wdetail2.comrequest = "AVS"  THEN ASSIGN wdetail2.n_branch = "6" /*10*/ 
    wdetail2.n_delercode = "MH0C113".  
ELSE IF wdetail2.comrequest = "BCH"  THEN ASSIGN wdetail2.n_branch = "M" /*11*/
    wdetail2.n_delercode = "MH0C049".            
ELSE IF wdetail2.comrequest = "BHA"  THEN ASSIGN wdetail2.n_branch = "8" /*12*/
    wdetail2.n_delercode = "MH0C053".  
ELSE IF wdetail2.comrequest = "BKH"  THEN ASSIGN wdetail2.n_branch = "M" /*13*/
    wdetail2.n_delercode = "MH0C034".            
ELSE IF wdetail2.comrequest = "BPC"  THEN ASSIGN wdetail2.n_branch = "5" /*14*/
    wdetail2.n_delercode = "MH0C109".            
ELSE IF wdetail2.comrequest = "BPH"  THEN ASSIGN wdetail2.n_branch = "M" /*15*/ 
    wdetail2.n_delercode = "MH0C025".
ELSE IF wdetail2.comrequest = "BST"  THEN ASSIGN wdetail2.n_branch = "C" /*16*/ 
    wdetail2.n_delercode = "MH0C027".
ELSE IF wdetail2.comrequest = "CBR"  THEN ASSIGN wdetail2.n_branch = "5" /*17*/
    Wdetail2.n_delercode = "MH0C087".            
ELSE IF wdetail2.comrequest = "CCC"  THEN ASSIGN wdetail2.n_branch = "6" /*18*/
    wdetail2.n_delercode = "MH0C114".            
ELSE IF wdetail2.comrequest = "CCS"  THEN ASSIGN wdetail2.n_branch = "8" /*19*/
    wdetail2.n_delercode = "MH0C038".            
ELSE IF wdetail2.comrequest = "CGH"  THEN ASSIGN wdetail2.n_branch = "M" /*20*/ 
    wdetail2.n_delercode = "MH0C001". 
ELSE IF wdetail2.comrequest = "CNT"  THEN ASSIGN wdetail2.n_branch = "1" /*21*/    
    wdetail2.n_delercode = "MH0C092". 
ELSE IF wdetail2.comrequest = "CPH"  THEN ASSIGN wdetail2.n_branch = "B" /*22*/ 
    wdetail2.n_delercode = "MH0C044". 
ELSE IF wdetail2.comrequest = "CSH"  THEN ASSIGN wdetail2.n_branch = "8" /*23*/
    wdetail2.n_delercode = "MH0C115". 
ELSE IF wdetail2.comrequest = "CSY"  THEN ASSIGN wdetail2.n_branch = "2" /*24*/    
    wdetail2.n_delercode = "MH0C097".
ELSE IF wdetail2.comrequest = "CYP"  THEN ASSIGN wdetail2.n_branch = "6" /*25*/
    wdetail2.n_delercode = "MH0C090".             
ELSE IF wdetail2.comrequest = "DKN"  THEN ASSIGN wdetail2.n_branch = "M" /*26*/
    wdetail2.n_delercode = "MH0C076".             
ELSE IF wdetail2.comrequest = "EKH"  THEN ASSIGN wdetail2.n_branch = "M" /*27*/
    wdetail2.n_delercode = "MH0C042".             
ELSE IF wdetail2.comrequest = "HCN"  THEN ASSIGN wdetail2.n_branch = "M"  /*28*/
    wdetail2.n_delercode = "MH0C066".             
ELSE IF wdetail2.comrequest = "PR5" THEN ASSIGN wdetail2.n_branch =  "M"   /*29*/
    wdetail2.n_delercode = "MH0C066".                                   
ELSE IF wdetail2.comrequest = "HDK"  THEN ASSIGN wdetail2.n_branch = "U"    /*30*/
    wdetail2.n_delercode = "MH0C051".                                   
ELSE IF wdetail2.comrequest = "HHA"  THEN ASSIGN wdetail2.n_branch = "A"    /*31*/ 
    wdetail2.n_delercode = "MH0C118".                                          
ELSE IF wdetail2.comrequest = "HLTC"  THEN ASSIGN wdetail2.n_branch = "M"   /*32*/ 
    wdetail2.n_delercode = "MH0C045".
ELSE IF wdetail2.comrequest = "HNK"  THEN ASSIGN wdetail2.n_branch = "1"    /*33*/    
        wdetail2.n_delercode = "MH0C091". 
ELSE IF wdetail2.comrequest = "JC1"  THEN ASSIGN wdetail2.n_branch = "J"    /*34*/    
    wdetail2.n_delercode = "MH0C086".                                              
ELSE IF wdetail2.comrequest = "JCR"  THEN ASSIGN wdetail2.n_branch = "J"  /*35*/    
    wdetail2.n_delercode = "MH0C086".
ELSE IF wdetail2.comrequest = "KGH"  THEN ASSIGN wdetail2.n_branch = "M"  /*36*/    
    wdetail2.n_delercode = "MH0C079".                                           
ELSE IF wdetail2.comrequest = "KLP"  THEN ASSIGN wdetail2.n_branch = "M"  /*37*/    
    wdetail2.n_delercode = "MH0C067".                                           
ELSE IF wdetail2.comrequest = "KLS"  THEN ASSIGN wdetail2.n_branch = "3"  /*38*/    
    wdetail2.n_delercode = "MH0C104".
ELSE IF wdetail2.comrequest = "KPH"  THEN ASSIGN wdetail2.n_branch = "1"  /*39*/    
    wdetail2.n_delercode = "MH0C093".                                           
ELSE IF wdetail2.comrequest = "KPS"  THEN ASSIGN wdetail2.n_branch = "U"  /*40*/    
    wdetail2.n_delercode = "MH0C064".                                           
ELSE IF wdetail2.comrequest = "KSP"  THEN ASSIGN wdetail2.n_branch = "I"  /*41*/  
    wdetail2.n_delercode = "MH0C053".                                           
ELSE IF wdetail2.comrequest = "KSR"  THEN ASSIGN wdetail2.n_branch = "U"  /*42*/ 
    wdetail2.n_delercode = "MH0C140".                                        
ELSE IF wdetail2.comrequest = "LBR"  THEN ASSIGN wdetail2.n_branch = "J"  /*43*/ 
    wdetail2.n_delercode = "MH0C127".                                        
ELSE IF wdetail2.comrequest = "LKH"  THEN ASSIGN wdetail2.n_branch = "M"  /*44*/ 
    wdetail2.n_delercode = "MH0C054".    
ELSE IF wdetail2.comrequest = "LHA"  THEN ASSIGN wdetail2.n_branch = "M"  /*44*/ 
    wdetail2.n_delercode = "MH0C054".                                        
ELSE IF wdetail2.comrequest = "LMT"  THEN ASSIGN wdetail2.n_branch = "U"  /*45*/ 
    wdetail2.n_delercode = "MH0C065".                                        
ELSE IF wdetail2.comrequest = "LPH"  THEN ASSIGN wdetail2.n_branch = "2"  /*46*/ 
    wdetail2.n_delercode = "MH0C100".                                        
ELSE IF wdetail2.comrequest = "MDH"  THEN ASSIGN wdetail2.n_branch = "K"  /*47*/ 
    wdetail2.n_delercode = "MH0C132".                                 
ELSE IF wdetail2.comrequest = "MLH"  THEN ASSIGN wdetail2.n_branch = "2"  /*48*/
    wdetail2.n_delercode = "MH0C101". 
ELSE IF wdetail2.comrequest = "MRM"  THEN ASSIGN wdetail2.n_branch = "2"  /*49*/ 
    wdetail2.n_delercode = "MH0C094".
ELSE IF wdetail2.comrequest = "NAN"  THEN ASSIGN wdetail2.n_branch = "2"  /*50*/ 
    wdetail2.n_delercode = "MH0C094".
ELSE IF wdetail2.comrequest = "NKA"  THEN ASSIGN wdetail2.n_branch = "S"  /*51*/ 
    wdetail2.n_delercode = "MH0C138". 
ELSE IF wdetail2.comrequest = "NKM"  THEN ASSIGN wdetail2.n_branch = "S"  /*52*/ 
    wdetail2.n_delercode = "MH0C135".
ELSE IF wdetail2.comrequest = "NKR"  THEN ASSIGN wdetail2.n_branch = "M"  /*53*/ 
    wdetail2.n_delercode = "MH0C071". 
ELSE IF wdetail2.comrequest = "NKT"  THEN ASSIGN wdetail2.n_branch = "U"  /*54*/ 
    wdetail2.n_delercode = "MH0C139". 
ELSE IF wdetail2.comrequest = "NMM"  THEN ASSIGN wdetail2.n_branch = "M"  /*55*/ 
    wdetail2.n_delercode = "MH0C084".
ELSE IF wdetail2.comrequest = "NPT"  THEN ASSIGN wdetail2.n_branch = "U"  /*56*/ 
    wdetail2.n_delercode = "MH0C026". 
ELSE IF wdetail2.comrequest = "NRM"  THEN ASSIGN wdetail2.n_branch = "6"  /*57*/ 
    wdetail2.n_delercode = "MH0C030". 
ELSE IF wdetail2.comrequest = "NRT"  THEN ASSIGN wdetail2.n_branch = "D"  /*58*/ 
    wdetail2.n_delercode = "MH0C119". 
ELSE IF wdetail2.comrequest = "NTB"  THEN ASSIGN wdetail2.n_branch = "M"  /*59*/ 
    wdetail2.n_delercode = "MH0C056". 
ELSE IF wdetail2.comrequest = "NWM"  THEN ASSIGN wdetail2.n_branch = "M"  /*60*/ 
    wdetail2.n_delercode = "MH0C035".
ELSE IF wdetail2.comrequest = "NYH"  THEN ASSIGN wdetail2.n_branch = "J"  /*61*/
    wdetail2.n_delercode = "MH0C128".
ELSE IF wdetail2.comrequest = "PBR"  THEN ASSIGN wdetail2.n_branch = "M" /*62*/
    wdetail2.n_delercode = "MH0C032".
ELSE IF wdetail2.comrequest = "PBS"  THEN ASSIGN wdetail2.n_branch = "M" /*63*/
    wdetail2.n_delercode = "MH0C010".
ELSE IF wdetail2.comrequest = "PCB"  THEN ASSIGN wdetail2.n_branch = "H" /*64*/
    wdetail2.n_delercode = "MH0C126".
ELSE IF wdetail2.comrequest = "PJH"  THEN ASSIGN wdetail2.n_branch = "H" /*65*/
    wdetail2.n_delercode = "MH0C125".
ELSE IF wdetail2.comrequest = "PKH"  THEN ASSIGN wdetail2.n_branch = "M" /*66*/
    wdetail2.n_delercode = "MH0C068".
ELSE IF wdetail2.comrequest = "PKN"  THEN ASSIGN wdetail2.n_branch = "2" /*67*/
    wdetail2.n_delercode = "MH0C095".
ELSE IF wdetail2.comrequest = "PM4"  THEN ASSIGN wdetail2.n_branch = "M" /*68*/
    wdetail2.n_delercode = "MH0C033".
ELSE IF wdetail2.comrequest = "PMP"  THEN ASSIGN wdetail2.n_branch = "2" /*69*/
    wdetail2.n_delercode = "MH0C053".
ELSE IF wdetail2.comrequest = "PNB"  THEN ASSIGN wdetail2.n_branch = "A" /*70*/
    wdetail2.n_delercode = "MH0C117".
ELSE IF wdetail2.comrequest = "PNK"  THEN ASSIGN wdetail2.n_branch = "M"  /*71*/
    wdetail2.n_delercode = "MH0C010".
ELSE IF wdetail2.comrequest = "PPD"  THEN ASSIGN wdetail2.n_branch = "M" /*72*/
    wdetail2.n_delercode = "MH0C055".
ELSE IF wdetail2.comrequest = "PR2"  THEN ASSIGN wdetail2.n_branch = "M" /*73*/
    wdetail2.n_delercode = "MH0C080".
ELSE IF wdetail2.comrequest = "PR3"  THEN ASSIGN wdetail2.n_branch = "M" /*74*/
    wdetail2.n_delercode = "MH0C074".
ELSE IF wdetail2.comrequest = "PR4"  THEN ASSIGN wdetail2.n_branch = "M" /*75*/
    wdetail2.n_delercode = "MH0C008".
ELSE IF wdetail2.comrequest = "PR7"  THEN ASSIGN wdetail2.n_branch = "M" /*76*/
    wdetail2.n_delercode = "MH0C075".
ELSE IF wdetail2.comrequest = "PR9"  THEN ASSIGN wdetail2.n_branch = "M" /*77*/
    wdetail2.n_delercode = "MH0C070".
ELSE IF wdetail2.comrequest = "PRB"  THEN ASSIGN wdetail2.n_branch = "5" /*78*/
    wdetail2.n_delercode = "MH0C106".
ELSE IF wdetail2.comrequest = "PSC"  THEN ASSIGN wdetail2.n_branch = "M" /*79*/
    wdetail2.n_delercode = "MH0C022".
ELSE IF wdetail2.comrequest = "PTF"  THEN ASSIGN wdetail2.n_branch = "M" /*80*/
    wdetail2.n_delercode = "MH0C039".
ELSE IF wdetail2.comrequest = "PTL"  THEN ASSIGN wdetail2.n_branch = "E"  /*81*/
    wdetail2.n_delercode = "MH0C120".
ELSE IF wdetail2.comrequest = "PTN"  THEN ASSIGN wdetail2.n_branch = "D" /*82*/
    wdetail2.n_delercode = "MH0C036".
ELSE IF wdetail2.comrequest = "PTT"  THEN ASSIGN wdetail2.n_branch = "M" /*83*/
    wdetail2.n_delercode = "MH0C040".
ELSE IF wdetail2.comrequest = "PTW"  THEN ASSIGN wdetail2.n_branch = "M" /*84*/
    wdetail2.n_delercode = "MH0C031".
ELSE IF wdetail2.comrequest = "PTY"  THEN ASSIGN wdetail2.n_branch = "5" /*85*/
    wdetail2.n_delercode = "MH0C107".
ELSE IF wdetail2.comrequest = "PVD"  THEN ASSIGN wdetail2.n_branch = "M" /*86*/
    wdetail2.n_delercode = "MH0C010".
ELSE IF wdetail2.comrequest = "PYH"  THEN ASSIGN wdetail2.n_branch = "2" /*87*/
    wdetail2.n_delercode = "MH0C096".
ELSE IF wdetail2.comrequest = "R3N"  THEN ASSIGN wdetail2.n_branch = "M" /*88*/
    wdetail2.n_delercode = "MH0C083".
ELSE IF wdetail2.comrequest = "RCD"  THEN ASSIGN wdetail2.n_branch = "M" /*89*/
    wdetail2.n_delercode = "MH0C077".
ELSE IF wdetail2.comrequest = "RIT"  THEN ASSIGN wdetail2.n_branch = "M" /*90*/
    wdetail2.n_delercode = "MH0C069".
ELSE IF wdetail2.comrequest = "RJK"  THEN ASSIGN wdetail2.n_branch = "3"  /*91*/
    wdetail2.n_delercode = "MH0C105".
ELSE IF wdetail2.comrequest = "RJM"  THEN ASSIGN wdetail2.n_branch = "3" /*92*/
    wdetail2.n_delercode = "MH0C103".
ELSE IF wdetail2.comrequest = "RJR"  THEN ASSIGN wdetail2.n_branch = "3" /*93*/
    wdetail2.n_delercode = "MH0C102".
ELSE IF wdetail2.comrequest = "RNH"  THEN ASSIGN wdetail2.n_branch = "B" /*94*/
    wdetail2.n_delercode = "MH0C057".
ELSE IF wdetail2.comrequest = "SBR"  THEN ASSIGN wdetail2.n_branch = "J" /*95*/
    wdetail2.n_delercode = "MH0C089".
ELSE IF wdetail2.comrequest = "SCR"  THEN ASSIGN wdetail2.n_branch = "5" /*96*/
    wdetail2.n_delercode = "MH0C110".
ELSE IF wdetail2.comrequest = "SHA"  THEN ASSIGN wdetail2.n_branch = "M" /*97*/
    wdetail2.n_delercode = "MH0C012".
ELSE IF wdetail2.comrequest = "SIB"  THEN ASSIGN wdetail2.n_branch = "J" /*98*/
    wdetail2.n_delercode = "MH0C088".
ELSE IF wdetail2.comrequest = "SKH"  THEN ASSIGN wdetail2.n_branch = "5" /*99*/
    wdetail2.n_delercode = "MH0C111".
ELSE IF wdetail2.comrequest = "SKT"  THEN ASSIGN wdetail2.n_branch = "H" /*100*/
    wdetail2.n_delercode = "MH0C085".
ELSE IF wdetail2.comrequest = "SKV"  THEN ASSIGN wdetail2.n_branch = "S"  /*101*/
    wdetail2.n_delercode = "MH0C137".
ELSE IF wdetail2.comrequest = "SLH"  THEN ASSIGN wdetail2.n_branch = "4" /*102*/
    wdetail2.n_delercode = "MH0C061".
ELSE IF wdetail2.comrequest = "SMB"  THEN ASSIGN wdetail2.n_branch = "M" /*103*/
    wdetail2.n_delercode = "MH0C063".
ELSE IF wdetail2.comrequest = "SMH"  THEN ASSIGN wdetail2.n_branch = "M" /*104*/
    wdetail2.n_delercode = "MH0C017".
ELSE IF wdetail2.comrequest = "SMM"  THEN ASSIGN wdetail2.n_branch = "F" /*105*/
    wdetail2.n_delercode = "MH0C122".
ELSE IF wdetail2.comrequest = "SMN"  THEN ASSIGN wdetail2.n_branch = "F" /*106*/
    wdetail2.n_delercode = "MH0C037".
ELSE IF wdetail2.comrequest = "SMP"  THEN ASSIGN wdetail2.n_branch = "M" /*107*/
    wdetail2.n_delercode = "MH0C029".
ELSE IF wdetail2.comrequest = "SMS"  THEN ASSIGN wdetail2.n_branch = "M" /*108*/
    wdetail2.n_delercode = "MH0C062".
ELSE IF wdetail2.comrequest = "SMU"  THEN ASSIGN wdetail2.n_branch = "M" /*109*/
    wdetail2.n_delercode = "MH0C063".
ELSE IF wdetail2.comrequest = "SRC"  THEN ASSIGN wdetail2.n_branch = "5" /*110*/
    wdetail2.n_delercode = "MH0C48".
ELSE IF wdetail2.comrequest = "SRT"  THEN ASSIGN wdetail2.n_branch = "7"  /*111*/
    wdetail2.n_delercode = "MH0C050".
ELSE IF wdetail2.comrequest = "SSK"  THEN ASSIGN wdetail2.n_branch = "K" /*112*/
    wdetail2.n_delercode = "MH0C129".
ELSE IF wdetail2.comrequest = "SSU"  THEN ASSIGN wdetail2.n_branch = "7" /*113*/
    wdetail2.n_delercode = "MH0C059".
ELSE IF wdetail2.comrequest = "STH"  THEN ASSIGN wdetail2.n_branch = "M" /*114*/
    wdetail2.n_delercode = "MH0C019".
ELSE IF wdetail2.comrequest = "SVB"  THEN ASSIGN wdetail2.n_branch = "M" /*115*/
    wdetail2.n_delercode = "MH0C081".
ELSE IF wdetail2.comrequest = "SVH"  THEN ASSIGN wdetail2.n_branch = "M" /*116*/
    wdetail2.n_delercode = "MH0C078".
ELSE IF wdetail2.comrequest = "SWW"  THEN ASSIGN wdetail2.n_branch = "M" /*117*/
    wdetail2.n_delercode = "MH0C082".
ELSE IF wdetail2.comrequest = "TAK"  THEN ASSIGN wdetail2.n_branch = "2" /*118*/
    wdetail2.n_delercode = "MH0C099".
ELSE IF wdetail2.comrequest = "TB1"  THEN ASSIGN wdetail2.n_branch = "M" /*119*/
    wdetail2.n_delercode = "MH0C073".
ELSE IF wdetail2.comrequest = "TBR"  THEN ASSIGN wdetail2.n_branch = "M" /*120*/
    wdetail2.n_delercode = "MH0C072".
ELSE IF wdetail2.comrequest = "TCJ"  THEN ASSIGN wdetail2.n_branch = "M"  /*121*/
    wdetail2.n_delercode = "MH0C003".
ELSE IF wdetail2.comrequest = "TNR"  THEN ASSIGN wdetail2.n_branch = "H" /*122*/
    wdetail2.n_delercode = "MH0C123".
ELSE IF wdetail2.comrequest = "TPR"  THEN ASSIGN wdetail2.n_branch = "M" /*123*/
    wdetail2.n_delercode = "MH0C024".
ELSE IF wdetail2.comrequest = "TRD"  THEN ASSIGN wdetail2.n_branch = "5" /*124*/
    wdetail2.n_delercode = "MH0C108".
ELSE IF wdetail2.comrequest = "TRH"  THEN ASSIGN wdetail2.n_branch = "E" /*125*/
    wdetail2.n_delercode = "MH0C121".
ELSE IF wdetail2.comrequest = "TYB"  THEN ASSIGN wdetail2.n_branch = "M" /*126*/
    wdetail2.n_delercode = "MH0C002".
ELSE IF wdetail2.comrequest = "UBP"  THEN ASSIGN wdetail2.n_branch = "K" /*127*/
    wdetail2.n_delercode = "MH0C130".
ELSE IF wdetail2.comrequest = "UDT"  THEN ASSIGN wdetail2.n_branch = "S" /*128*/
    wdetail2.n_delercode = "MH0C136".
ELSE IF wdetail2.comrequest = "UTR"  THEN ASSIGN wdetail2.n_branch = "H" /*129*/
    wdetail2.n_delercode = "MH0C124".
ELSE IF wdetail2.comrequest = "VBK"  THEN ASSIGN wdetail2.n_branch = "M" /*130*/
    wdetail2.n_delercode = "MH0C041".
ELSE IF wdetail2.comrequest = "VGH"  THEN ASSIGN wdetail2.n_branch = "M"  /*131*/
    wdetail2.n_delercode = "MH0C041".
ELSE IF wdetail2.comrequest = "VGN"  THEN ASSIGN wdetail2.n_branch = "M" /*132*/
    wdetail2.n_delercode = "MH0C041".
ELSE IF wdetail2.comrequest = "WHL"  THEN ASSIGN wdetail2.n_branch = "M" /*133*/
    wdetail2.n_delercode = "MH0C004".
ELSE IF wdetail2.comrequest = "WHR"  THEN ASSIGN wdetail2.n_branch = "M" /*134*/
    wdetail2.n_delercode = "MH0C004".
ELSE IF wdetail2.comrequest = "WPY"  THEN ASSIGN wdetail2.n_branch = "M" /*135*/
    wdetail2.n_delercode = "MH0C004".
ELSE IF wdetail2.comrequest = "YLH"  THEN ASSIGN wdetail2.n_branch = "D" /*136*/
    wdetail2.n_delercode = "MH0C023".
ELSE IF wdetail2.comrequest = "YST"  THEN ASSIGN wdetail2.n_branch = "K" /*137*/
    wdetail2.n_delercode = "MH0C133".
ELSE IF wdetail2.comrequest = "HIB" THEN ASSIGN wdetail2.n_branch = "M" /*136*/
    wdetail2.n_delercode = "MH0C045".
ELSE IF wdetail2.comrequest = "HATC" THEN ASSIGN wdetail2.n_branch = "M" /*137*/
    wdetail2.n_delercode = "MH0C045".
ELSE IF wdetail2.comrequest = "PHA" THEN ASSIGN wdetail2.n_branch = "M" /*138*/
    wdetail2.n_delercode = "MH0C045".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigninit C-Win 
PROCEDURE proc_assigninit :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
            wdetail.si = ""
            wdetail.policyno     = TRIM(SUBSTRING(c,116,1)) + TRIM(SUBSTRING(c,1,12))  /*1*/                  
            wdetail.cndat        = TRIM(SUBSTRING(c,13,10))         /*2*/                              
            wdetail.appenno      = TRIM(SUBSTRING(c,23,32))         /*3*/                      
            wdetail.comdat       = TRIM(SUBSTRING(c,55,10))         /*4*/                      
            wdetail.expdat       = TRIM(SUBSTRING(c,65,10))         /*5*/                      
            wdetail.comcode      = TRIM(SUBSTRING(c,75,10))         /*6*/                      
            wdetail.cartyp       = TRIM(SUBSTRING(c,85,4))          /*7*/                      
            wdetail.saletyp      = TRIM(SUBSTRING(c,89,1))          /*8*/                      
            wdetail.campen       = TRIM(SUBSTRING(c,90,16))         /*9*/                      
            wdetail.freeamonth   = TRIM(SUBSTRING(c,106,10))        /*10*/                     
            wdetail.covcod       = TRIM(SUBSTRING(c,116,1))         /*11*/                     
            wdetail.typcom       = TRIM(SUBSTRING(c,117,9))         /*12*/                     
            wdetail.garage       = TRIM(SUBSTRING(c,126,6))         /*13*/                     
            wdetail.bysave       = TRIM(SUBSTRING(c,132,30))        /*14*/                     
            wdetail.tiname       = TRIM(SUBSTRING(c,162,20))        /*15*/                     
            wdetail.insnam       = TRIM(SUBSTRING(c,182,80))        /*16*/                     
            wdetail.name2        = TRIM(SUBSTRING(c,262,20))        /*17*/                     
            wdetail.name3        = TRIM(SUBSTRING(c,282,60))        /*18*/                     
            wdetail.addr         = TRIM(SUBSTRING(c,342,80))        /*19*/                     
            wdetail.road         = TRIM(SUBSTRING(c,422,40))        /*20*/                     
            wdetail.tambon       = TRIM(SUBSTRING(c,462,60))        /*21*/                     
            wdetail.amper        = TRIM(SUBSTRING(c,522,30))        /*22*/                     
            wdetail.country      = TRIM(SUBSTRING(c,552,30))        /*23*/                     
            wdetail.post         = TRIM(SUBSTRING(c,582,5))         /*24*/                     
            wdetail.occup        = TRIM(SUBSTRING(c,587,50))        /*25*/                     
            wdetail.birthdat     = TRIM(SUBSTRING(c,637,10))        /*26*/                     
            wdetail.icno         = replace(TRIM(SUBSTRING(c,647,15)),"'","")        /*27*/                     
            wdetail.driverno     = TRIM(SUBSTRING(c,662,15))        /*28*/                     
            wdetail.brand        = TRIM(SUBSTRING(c,677,10))        /*29*/                     
            wdetail.cargrp       = TRIM(SUBSTRING(c,687,1))         /*30*/                      
            wdetail.chasno       = TRIM(SUBSTRING(c,688,25))        /*31*/                  
            wdetail.eng          = TRIM(SUBSTRING(c,713,20))        /*32*/                     
            wdetail.model        = TRIM(SUBSTRING(c,733,40)).       /*33*/                   
        ASSIGN                                                                                     
            /*wdetail.caryear      = TRIM(SUBSTRING(c,771,4))       /*34*/ */ /*kridtiya i. A53-0303*/ 
            wdetail.caryear      = TRIM(SUBSTRING(c,926,4))         /*34*/    /*kridtiya i. A53-0303*/ 
            wdetail.carcode      = TRIM(SUBSTRING(c,777,20))        /*35*/                         
            wdetail.body         = TRIM(SUBSTRING(c,797,40))        /*36*/                         
            wdetail.vehuse       = TRIM(SUBSTRING(c,837,1))         /*37*/                         
            wdetail.carno        = TRIM(SUBSTRING(c,838,2))         /*38*/                         
            wdetail.seat         = TRIM(SUBSTRING(c,840,2))         /*39*/                         
            wdetail.engcc        = TRIM(SUBSTRING(c,842,4))         /*40*/                         
            wdetail.colorcar     = TRIM(SUBSTRING(c,846,40))        /*41*/                         
            wdetail.vehreg       = TRIM(SUBSTRING(c,886,10))        /*42*/                         
            wdetail.re_country   = TRIM(SUBSTRING(c,896,30))        /*43*/                         
            wdetail.re_year      = TRIM(SUBSTRING(c,926,4))         /*44*/                         
            wdetail.nmember      = TRIM(SUBSTRING(c,930,512))       /*45*/                         
            wdetail.si           = TRIM(SUBSTRING(c,1442,14))       /*46*/                         
            wdetail.premt        = TRIM(SUBSTRING(c,1456,14))       /*47*/                         
            wdetail.rstp_t       = TRIM(SUBSTRING(c,1470,14))       /*48*/                         
            wdetail.rtax_t       = TRIM(SUBSTRING(c,1484,14))       /*49*/                         
            wdetail.prem_r       = TRIM(SUBSTRING(c,1498,14))       /*50*/                         
            wdetail.gap          = TRIM(SUBSTRING(c,1512,14))       /*51*/                         
            wdetail.ncb          = TRIM(SUBSTRING(c,1526,14))       /*52*/                         
            wdetail.ncbprem      = TRIM(SUBSTRING(c,1540,14))       /*53*/                         
            wdetail.stk          = TRIM(SUBSTRING(c,1554,20))       /*54*/                         
            wdetail.prepol       = TRIM(SUBSTRING(c,1574,32)).      /*55*/                         
        ASSIGN                                                                                  
            wdetail.flagname     = TRIM(SUBSTRING(c,1606,1))        /*56*/                      
            wdetail.flagno       = TRIM(SUBSTRING(c,1607,1))        /*57*/                      
            wdetail.ntitle1      = TRIM(SUBSTRING(c,1608,20))       /*58*/                      
            wdetail.drivername1  = TRIM(SUBSTRING(c,1628,80))       /*59*/                      
            wdetail.dname1       = TRIM(SUBSTRING(c,1708,20))       /*60*/                      
            wdetail.dname2       = TRIM(SUBSTRING(c,1728,60))       /*61*/                      
            wdetail.docoup       = TRIM(SUBSTRING(c,1788,50))       /*62*/                      
            wdetail.dbirth       = TRIM(SUBSTRING(c,1838,10))       /*63*/                      
            wdetail.dicno        = TRIM(SUBSTRING(c,1848,15))       /*64*/                      
            wdetail.ddriveno     = TRIM(SUBSTRING(c,1863,15))       /*65*/                      
            wdetail.ntitle2      = TRIM(SUBSTRING(c,1878,20))       /*66*/                      
            wdetail.drivername2  = TRIM(SUBSTRING(c,1898,80)).      /*67*/                      
        ASSIGN                                                                                  
            wdetail.ddname1      = TRIM(SUBSTRING(c,1978,20))       /*68*/                      
            wdetail.ddname2      = TRIM(SUBSTRING(c,1998,60))       /*69*/                      
            wdetail.ddocoup      = TRIM(SUBSTRING(c,2058,50))       /*70*/                      
            wdetail.ddbirth      = TRIM(SUBSTRING(c,2108,10))       /*71*/                       
            wdetail.ddicno       = TRIM(SUBSTRING(c,2118,15))       /*72*/                      
            wdetail.dddriveno    = TRIM(SUBSTRING(c,2133,15))       /*73*/                      
            wdetail.benname      = TRIM(SUBSTRING(c,2148,80))       /*74*/                      
            wdetail.comper       = TRIM(SUBSTRING(c,2228,14))       /*75*/                      
            wdetail.comacc       = TRIM(SUBSTRING(c,2242,14))       /*76*/                      
            wdetail.deductpd     = TRIM(SUBSTRING(c,2256,14))       /*77*/                      
            wdetail.tp2          = TRIM(SUBSTRING(c,2270,14))       /*78*/                      
            wdetail.deductda     = TRIM(SUBSTRING(c,2284,14))       /*79*/                      
            wdetail.deduct       = TRIM(SUBSTRING(c,2298,14))       /*80*/                      
            wdetail.tpfire       = TRIM(SUBSTRING(c,2312,14))       /*81*/                      
            wdetail.compul       = IF TRIM(SUBSTRING(c,116,1)) = "0" THEN "y" ELSE "n"              
            wdetail2.policyno     = wdetail.policyno                                                
            wdetail2.NO_41        = TRIM(SUBSTRING(c,2326,14))      /*82*/                          
            wdetail2.ac2          = TRIM(SUBSTRING(c,2340,2))       /*83*/                          
            wdetail2.NO_42        = TRIM(SUBSTRING(c,2342,14))      /*84*/                          
            wdetail2.ac4          = TRIM(SUBSTRING(c,2356,14))      /*85*/                          
            wdetail2.ac5          = TRIM(SUBSTRING(c,2370,2))       /*86*/                          
            wdetail2.ac6          = TRIM(SUBSTRING(c,2372,14))      /*87*/                          
            wdetail2.ac7          = TRIM(SUBSTRING(c,2386,14))      /*88*/  .                       
        ASSIGN                                                                                     
            wdetail2.NO_43        = TRIM(SUBSTRING(c,2400,14))     /*89*/                          
            wdetail2.nstatus      = TRIM(SUBSTRING(c,2414,6))      /*90*/                          
            wdetail2.typrequest   = TRIM(SUBSTRING(c,2420,10))     /*91*/                          
            wdetail2.comrequest   = TRIM(SUBSTRING(c,2430,10))     /*92*/                          
            wdetail2.brrequest    = TRIM(SUBSTRING(c,2440,30))     /*93*/                          
            wdetail2.salename     = TRIM(SUBSTRING(c,2470,80))     /*94*/                          
            wdetail2.comcar       = TRIM(SUBSTRING(c,2550,10))      /*95*/                         
            wdetail2.brcar        = TRIM(SUBSTRING(c,2560,30))      /*96*/                         
            wdetail2.projectno    = TRIM(SUBSTRING(c,2590,12))      /*97*/                         
            wdetail2.caryear      = TRIM(SUBSTRING(c,2602,3))       /*98*/                         
            wdetail2.special1     = TRIM(SUBSTRING(c,2605,10))      /*99*/                         
            wdetail2.specialprem1 = TRIM(SUBSTRING(c,2615,14))      /*100*/                        
            wdetail2.special2     = TRIM(SUBSTRING(c,2629,10))      /*101*/                        
            wdetail2.specialprem2 = TRIM(SUBSTRING(c,2639,14))      /*102*/                        
            wdetail2.special3     = TRIM(SUBSTRING(c,2653,10))      /*103*/                        
            wdetail2.specialprem3 = TRIM(SUBSTRING(c,2663,14))      /*104*/                        
            wdetail2.special4     = TRIM(SUBSTRING(c,2677,10))      /*105*/                        
            wdetail2.specialprem4 = TRIM(SUBSTRING(c,2687,14))      /*106*/                        
            wdetail2.special5     = TRIM(SUBSTRING(c,2701,10))      /*107*/                        
            wdetail2.specialprem5 = TRIM(SUBSTRING(c,2711,14))      /*108*/              
            wdetail2.ac_no        = TRIM(SUBSTRING(c,2725,15))                               
            wdetail2.ac_date      = TRIM(SUBSTRING(c,2740,10))                               
            wdetail2.ac_amount    = TRIM(SUBSTRING(c,2750,14))              
            wdetail2.ac_pay       = TRIM(SUBSTRING(c,2764,10))              
            wdetail2.ac_agent     = TRIM(SUBSTRING(c,2774,20))   
            wdetail2.voictitle    = TRIM(SUBSTRING(c,2794,1))      /*114 ออกใบเสร็จในนาม*/     
            wdetail2.voicnam      = TRIM(SUBSTRING(c,2795,120))    /*115 ชื่อใบเสร็จ*/         
            wdetail2.detailcam    = TRIM(SUBSTRING(c,2915,100))    /*116 รายละเอียดแคมเปญ*/    
            wdetail2.ins_pay      = TRIM(SUBSTRING(c,3015,2))      /*117 รับประกันจ่ายแน่ ๆ*/ 
            wdetail2.n_month      = TRIM(SUBSTRING(c,3017,2))      /*118 ผ่อนชำระ/เดือน  */ /*A55-0043*/ 
            wdetail2.n_bank       = TRIM(SUBSTRING(c,3019,10))     /*119 บัตรเครดิตธนาคาร*/ /*A55-0043*/ 
            wdetail2.TYPE_notify  = TRIM(SUBSTRING(c,3029,1))      /*120 A56-0318 */
            wdetail2.price_acc    = TRIM(SUBSTRING(c,3030,10))     /*121 A56-0318 */
            wdetail2.accdata      = TRIM(SUBSTRING(c,3040,255))    /*122 A56-0318 */
            wdetail2.brdealer     = TRIM(SUBSTRING(c,3295,5))      /*122 A57-0073*/
            wdetail2.poltyp       = IF TRIM(SUBSTRING(c,116,1)) = "0" THEN "V72" ELSE "V70"
            wdetail2.subclass     = wdetail.vehuse + wdetail.carno 
            wdetail2.seat41       = INTE(wdetail.seat) 
            wdetail2.comment      = ""
            wdetail2.producer     = ""
            wdetail2.producer2    = ""
            wdetail2.agent        = fi_agent
            /*wdetail2.producer     = fi_producer01 */           /*A56-0318*/ 
            /*wdetail2.producer     = fi_producer02                /*A56-0318*/   *//*A57-0073*/
            wdetail2.entdat       = string(TODAY)                /*entry date*/
            wdetail2.enttim       = STRING (TIME, "HH:MM:SS")    /*entry time*/
            wdetail2.trandat      = STRING (fi_loaddat)          /*tran date*/
            wdetail2.trantim      = STRING (TIME, "HH:MM:SS")    /*tran time*/
            wdetail2.n_IMPORT     = "IM"
            wdetail2.n_EXPORT     = "" 
            wdetail3.policyno     = wdetail.policyno 
            wdetail3.brand_gals    = TRIM(SUBSTRING(c,3300,20))    /* A58-0198 ยี่ห้อเคลือบแก้ว    */             
            wdetail3.brand_galsprm = TRIM(SUBSTRING(c,3320,10))    /* A58-0198 ราคาเคลือบแก้ว  */    
            wdetail3.companyre1    = TRIM(SUBSTRING(c,3330,150))  /* A58-0198 ชื่อบริษัทเต็มบนใบกำกับภาษี1    */ 
            wdetail3.camp_no       = TRIM(SUBSTRING(c,4644,12))   /*--- A58-0419 : เลขที่แคมเปญ ---*/
            wdetail3.payment_type  = TRIM(SUBSTRING(c,4656,10))   /*--- A58-0419 : ประเภทการชำระเบี้ย ---*/
            wdetail3.companybr1    = TRIM(SUBSTRING(c,3480,15)) .  /* A67-0211 */  
        IF TRIM(SUBSTRING(c,116,1)) <> "0" THEN DO:  /* covcod 1 2 3 5 = V70 */
            ASSIGN 
                /*wdetail3.policyno      = wdetail.policyno */
                wdetail3.companybr1    = TRIM(SUBSTRING(c,3480,15))    /* A58-0198 สาขาบริษัทบนใบกำกับภาษี1    */       
                wdetail3.addr_re1      = TRIM(SUBSTRING(c,3495,250))   /* A58-0198 ที่อยู่บนใบกำกับภาษี1   */           
                wdetail3.idno_re1      = TRIM(SUBSTRING(c,3745,13))    /* A58-0198 เลขที่ผู้เสียภาษี1  */               
                wdetail3.premt_re1     = TRIM(SUBSTRING(c,3758,10))    /* A58-0198 อัตราเบี้ยตามใบกำกับ1   */           
                wdetail3.companyre2    = TRIM(SUBSTRING(c,3768,150))   /* A58-0198 ชื่อบริษัทเต็มบนใบกำกับภาษี2    */   
                wdetail3.companybr2    = TRIM(SUBSTRING(c,3918,15))    /* A58-0198 สาขาบริษัทบนใบกำกับภาษี2    */       
                wdetail3.addr_re2      = TRIM(SUBSTRING(c,3933,250))   /* A58-0198 ที่อยู่บนใบกำกับภาษี2   */           
                wdetail3.idno_re2      = TRIM(SUBSTRING(c,4183,13))    /* A58-0198 เลขที่ผู้เสียภาษี2  */               
                wdetail3.premt_re2     = TRIM(SUBSTRING(c,4196,10))    /* A58-0198 อัตราเบี้ยตามใบกำกับ2   */           
                wdetail3.companyre3    = TRIM(SUBSTRING(c,4206,150))   /* A58-0198 ชื่อบริษัทเต็มบนใบกำกับภาษี3    */   
                wdetail3.companybr3    = TRIM(SUBSTRING(c,4356,15))    /* A58-0198 สาขาบริษัทบนใบกำกับภาษี3    */        
                wdetail3.addr_re3      = TRIM(SUBSTRING(c,4371,250))   /* A58-0198 ที่อยู่บนใบกำกับภาษี3   */           
                wdetail3.idno_re3      = TRIM(SUBSTRING(c,4621,13))    /* A58-0198 เลขที่ผู้เสียภาษี3  */             
                wdetail3.premt_re3     = TRIM(SUBSTRING(c,4634,10))  . /* A58-0198 อัตราเบี้ยตามใบกำกับ3  */ 
            ASSIGN wf_instot = 0 .
            IF  wdetail3.companyre1  <> "" THEN ASSIGN wf_instot = wf_instot + 1.  /*  ชื่อบริษัทเต็มบนใบกำกับภาษี1 */
            IF  wdetail3.companyre2  <> "" THEN ASSIGN wf_instot = wf_instot + 1.  /*  ชื่อบริษัทเต็มบนใบกำกับภาษี2 */
            IF  wdetail3.companyre3  <> "" THEN ASSIGN wf_instot = wf_instot + 1.  /*  ชื่อบริษัทเต็มบนใบกำกับภาษี3 */ 
            IF wf_instot = 0 THEN wdetail3.instot = 1.
            ELSE wdetail3.instot =  wf_instot.
        END.
        ELSE wdetail3.instot = 1.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigninit70 C-Win 
PROCEDURE proc_assigninit70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
CREATE wdetail.
CREATE wdetail2.
CREATE wdetail3.
ASSIGN
    wdetail.si = ""
    wdetail.policyno     = trim(wf_policyno)    /*   เลขที่ใบคำขอ*/   
    wdetail2.n_branch    = trim(wf_n_branch)    /*   สาขา        */             
    wdetail2.n_delercode = trim(wf_n_delercode) /*   รหัสดีเลอร์ */         
    wdetail2.typrequest  = trim(wf_vatcode)     /*   Vat code.   */  
    wdetail.cndat        = trim(wf_cndat)       /*   วันที่ใบคำขอ    */     
    wdetail.appenno      = trim(wf_appenno)     /*   เลขที่รับแจ้ง   */     
    wdetail.comdat       = trim(wf_comdat)      /*   วันที่เริ่มคุ้มครอง */ 
    wdetail.expdat       = trim(wf_expdat)      /*   วันที่สิ้นสุด   */     
    wdetail.comcode      = trim(wf_comcode)     /*   รหัสบริษัทประกันภัย */ 
    wdetail.cartyp       = trim(wf_cartyp)      /*   ประเภทรถ    */         
    wdetail.saletyp      = trim(wf_saletyp)     /*   ประเภทการขาย    */     
    wdetail.campen       = trim(wf_campen)      /*   ประเภทแคมเปญ    */     
    wdetail.freeamonth   = trim(wf_freeamonth)  /*   จำนวนเงินให้ฟรี     */ 
    wdetail.covcod       = trim(wf_covcod)      /*   ประเภทความคุ้มครอง  */ 
    wdetail.typcom       = trim(wf_typcom)      /*   ประเภทประกัน    */     
    wdetail.garage       = trim(wf_garage)      /*   ประเภทการซ่อม   */     
    wdetail.bysave       = trim(wf_bysave)      /*   ผู้บันทึก   */         
    wdetail.tiname       = trim(wf_tiname)      /*   คำนำหน้า    */         
    wdetail.insnam       = trim(wf_insnam)      /*   ชื่อลูกค้า  */         
    wdetail.name2        = trim(wf_name2)       /*   ชื่อกลาง    */         
    wdetail.name3        = trim(wf_name3)       /*   นามสกุล     */         
    wdetail.addr         = trim(wf_addr)        /*   ที่อยู่     */         
    wdetail.road         = trim(wf_road)        /*   ถนน     */             
    wdetail.tambon       = trim(wf_tambon)      /*   ตำบล    */             
    wdetail.amper        = trim(wf_amper)       /*   อำเภอ   */             
    wdetail.country      = trim(wf_country)     /*   จังหวัด     */         
    wdetail.post         = trim(wf_post)        /*   รหัสไปรษณีย์    */     
    wdetail.occup        = trim(wf_occup)       /*   อาชีพ   */             
    wdetail.birthdat     = trim(wf_birthdat)    /*   วันเกิด */                
    wdetail.icno         = trim(wf_icno)        /*   เลขที่บัตรประชาชน   */              
    wdetail.driverno     = trim(wf_driverno)    /*   เลขที่ใบขับขี่  */     
    wdetail.brand        = trim(wf_brand)       /*   ยี่ห้อรถ    */         
    wdetail.cargrp       = trim(wf_cargrp)      /*   กลุ่มรถยนต์     */     
    wdetail.chasno       = trim(wf_chasno)      /*   หมายเลขตัวถัง   */     
    wdetail.eng          = trim(wf_eng)         /*   หมายเลขเครื่อง  */     
    wdetail.model        = trim(wf_model)  .    /*   ชื่อรุ่นรถ  */         
ASSIGN                                          
    /*wdetail.caryear      = trim(wf_caryear)   /*   รุ่นปี  */    */         
    wdetail.carcode      = trim(wf_carcode)     /*   ชื่อประเภทรถ    */        
    wdetail.body         = trim(wf_body)        /*   แบบตัวถัง   */            
    wdetail.vehuse       = trim(wf_vehuse)      /*   รหัสประเภทรถ    */        
    wdetail.carno        = trim(wf_carno)       /*   รหัสลักษณะการใช้งาน */    
    wdetail.seat         = trim(wf_seat)        /*   จำนวนที่นั่ง    */        
    wdetail.engcc        = trim(wf_engcc)       /*   ปริมาตรกระบอกสูบ    */    
    wdetail.colorcar     = trim(wf_colorcar)    /*   ชื่อสีรถ    */            
    wdetail.vehreg       = trim(wf_vehreg)      /*   เลขทะเบียนรถ    */        
    wdetail.re_country   = trim(wf_re_country)  /*   จังหวัดที่จดทะเบียน */    
    wdetail.re_year      = trim(wf_re_year)     /*   ปีที่จดทะเบียน  */        
    wdetail.caryear      = trim(wf_re_year)     
    wdetail.nmember      = trim(wf_nmember)     /*   หมายเหตุ    */              
    wdetail.si           = trim(wf_si)          /*   วงเงินทุนประกัน */         
    wdetail.premt        = trim(wf_premt)       /*   เบี้ยประกัน */             
    wdetail.rstp_t       = trim(wf_rstp_t)      /*   อากร    */                 
    wdetail.rtax_t       = trim(wf_rtax_t)      /*   จำนวนเงินภาษี   */         
    wdetail.prem_r       = trim(wf_prem_r)      /*   เบี้ยประกันรวม  */         
    wdetail.gap          = trim(wf_gap)         /*   เบี้ยประกันรวมทั้งหมด   */ 
    wdetail.ncb          = trim(wf_ncb)         /*   อัตราส่วนลดประวัติดี    */ 
    wdetail.ncbprem      = trim(wf_ncbprem)     /*   ส่วนลดประวัติดี */         
    wdetail.stk          = trim(wf_stk)         /*   หมายเลขสติ๊กเกอร์   */     
    wdetail.prepol       = trim(wf_prepol)  .   /*   เลขที่กรมธรรม์เดิม  */     
ASSIGN  wdetail.flagname = trim(wf_flagname)    /*   flag ระบุชื่อ   */                     
    wdetail.flagno       = trim(wf_flagno)      /*   flag ไม่ระบุชื่อ   */                 
    wdetail.ntitle1      = trim(wf_ntitle1)     /*   คำนำหน้า    */                         
    wdetail.drivername1  = trim(wf_drivername1) /*   ชื่อผู้ขับขี่คนที่1 */            
    wdetail.dname1       = trim(wf_dname1)      /*   ชื่อกลาง    */                    
    wdetail.dname2       = trim(wf_dname2)      /*   นามสกุล */                        
    wdetail.docoup       = trim(wf_docoup)      /*   อาชีพ   */                        
    wdetail.dbirth       = trim(wf_dbirth)      /*   วันเกิด */                        
    wdetail.dicno        = trim(wf_dicno)       /*   เลขที่บัตรประชาชน   */            
    wdetail.ddriveno     = trim(wf_ddriveno)    /*   เลขที่ใบขับขี่  */                
    wdetail.ntitle2      = TRIM(wf_ntitle2)     /*   คำนำหน้า2   */                            
    wdetail.drivername2   = trim(wf_drivername2).  /*   ชื่อผู้ขับขี่คนที่2     */         
ASSIGN wdetail.ddname1    = trim(wf_ddname1)    /*   ชื่อกลาง2   */                     
    wdetail.ddname2       = trim(wf_ddname2)    /*   นามสกุล2    */                     
    wdetail.ddocoup       = trim(wf_ddocoup)    /*   อาชีพ2  */                         
    wdetail.ddbirth       = trim(wf_ddbirth)    /*   วันเกิด2    */                      
    wdetail.ddicno        = trim(wf_ddicno)     /*   เลขที่บัตรประชาชน2  */             
    wdetail.dddriveno     = trim(wf_dddriveno)  /*   เลขที่ใบขับขี่2 */                 
    wdetail.benname       = TRIM(wf_benname)    /*   ผู้รับผลประโยชน์    */             
    wdetail.comper        = trim(wf_comper)     /*   ความเสียหายต่อชีวิต(บาท/คน) */     
    wdetail.comacc        = trim(wf_comacc)     /*   ความเสียหายต่อชีวิต(บาท/ครั้ง)  */ 
    wdetail.deductpd      = trim(wf_deductpd)   /*   ความเสียหายต่อทรัพย์สิน */         
    wdetail.tp2           = trim(wf_tp2)        /*   ความเสียหายส่วนแรกบุคคล */         
    wdetail.deductda      = trim(wf_deductda)   /*   ความเสียหายต่อต่อรถยนต์ */         
    wdetail.deduct        = trim(wf_deduct)     /*   ความเสียหายส่วนแรกรถยนต์    */     
    wdetail.tpfire        = trim(wf_tpfire)     /*   รถยนต์สูญหาย/ไฟไหม้     */         
    wdetail.compul        = "n"                 
    /*add : A68-0061 */                         
    wdetail.typepol     =  trim(wf_typepol)     
    wdetail.typecar     =  trim(wf_typecar)     
    wdetail.maksi       =  trim(wf_maksi)       
    wdetail.drivexp1    =  trim(wf_drivexp1)    
    wdetail.drivcon1    =  trim(wf_drivcon1)    
    wdetail.dlevel1     =  trim(wf_dlevel1)     
    wdetail.dgender1    =  trim(wf_dgender1)    
    wdetail.drelation1  =  trim(wf_drelation1)  
    wdetail.drivexp2    =  trim(wf_drivexp2)    
    wdetail.drivcon2    =  trim(wf_drivcon2)    
    wdetail.dlevel2     =  trim(wf_dlevel2)     
    wdetail.dgender2    =  trim(wf_dgender2)    
    wdetail.drelation2  =  trim(wf_drelation2)  
    wdetail.ntitle3     =  trim(wf_ntitle3)     
    wdetail.dname3      =  trim(wf_dname3 )     
    wdetail.dcname3     =  trim(wf_dcname3)     
    wdetail.dlname3     =  trim(wf_dlname3)     
    wdetail.doccup3     =  trim(wf_doccup3)     
    wdetail.dbirth3     =  trim(wf_dbirth3)     
    wdetail.dicno3      =  trim(wf_dicno3 )     
    wdetail.ddriveno3   =  trim(wf_ddriveno3)   
    wdetail.drivexp3    =  trim(wf_drivexp3)    
    wdetail.drivcon3    =  trim(wf_drivcon3)    
    wdetail.dlevel3     =  trim(wf_dlevel3 )    
    wdetail.dgender3    =  trim(wf_dgender3)    
    wdetail.drelation3  =  trim(wf_drelation3)  
    wdetail.ntitle4     =  trim(wf_ntitle4)     
    wdetail.dname4      =  trim(wf_dname4 )     
    wdetail.dcname4     =  trim(wf_dcname4)     
    wdetail.dlname4     =  trim(wf_dlname4)     
    wdetail.doccup4     =  trim(wf_doccup4)     
    wdetail.dbirth4     =  trim(wf_dbirth4)     
    wdetail.dicno4      =  trim(wf_dicno4 )     
    wdetail.ddriveno4   =  trim(wf_ddriveno4 )  
    wdetail.drivexp4    =  trim(wf_drivexp4)    
    wdetail.drivcon4    =  trim(wf_drivcon4)    
    wdetail.dlevel4     =  trim(wf_dlevel4 )    
    wdetail.dgender4    =  trim(wf_dgender4)    
    wdetail.drelation4  =  trim(wf_drelation4)  
    wdetail.ntitle5     =  trim(wf_ntitle5)     
    wdetail.dname5      =  trim(wf_dname5 )     
    wdetail.dcname5     =  trim(wf_dcname5)     
    wdetail.dlname5     =  trim(wf_dlname5)     
    wdetail.doccup5     =  trim(wf_doccup5)     
    wdetail.dbirth5     =  trim(wf_dbirth5)     
    wdetail.dicno5      =  trim(wf_dicno5 )     
    wdetail.ddriveno5   =  trim(wf_ddriveno5)   
    wdetail.drivexp5    =  trim(wf_drivexp5)    
    wdetail.drivcon5    =  trim(wf_drivcon5)    
    wdetail.dlevel5     =  trim(wf_dlevel5)     
    wdetail.dgender5    =  trim(wf_dgender5)    
    wdetail.drelation5  =  trim(wf_drelation5)  
    wdetail.chargflg    =  trim(wf_chargflg)    
    wdetail.chargprice  =  trim(wf_chargprice)  
    wdetail.chargno     =  trim(wf_chargno)     
    wdetail.chargprm    =  trim(wf_chargprm)    
    wdetail.battflg     =  trim(wf_battflg)     
    wdetail.battprice   =  trim(wf_battprice)   
    wdetail.battno      =  trim(wf_battno )     
    wdetail.battprm     =  trim(wf_battprm)     
    wdetail.battdate    =  trim(wf_battdate)    
    wdetail.rate31      =  trim(wf_31rate )     
    wdetail.premt31     =  trim(wf_31premt) .   
    /*end : A68-0061 */                         
ASSIGN                                          
    wdetail2.policyno     = wdetail.policyno                                    
    wdetail2.NO_41        =   trim(wf_NO_41)    /*  อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่    */                             
    wdetail2.ac2          =   trim(wf_ac2)      /*  อุบัติเหตุส่วนบุคคลเสียชีวิตจน.ผู้โดยสาร */                            
    wdetail2.NO_42        =   trim(wf_NO_42)    /*  อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง    */                    
    wdetail2.ac4          =   trim(wf_ac4)      /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้ขับขี่ */                        
    wdetail2.ac5          =   trim(wf_ac5)      /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวจน.ผู้โดยสาร  */                    
    wdetail2.ac6          =   trim(wf_ac6)      /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้โดยสารต่อครั้ง */                
    wdetail2.ac7          =   trim(wf_ac7)      /*  ค่ารักษาพยาบาล   */                                    
    wdetail2.NO_43        =   TRIM(wf_NO_43)    /*  การประกันตัวผู้ขับขี่    */                                       
    wdetail2.nstatus      =   trim(wf_nstatus)         /*  สถานะข้อมูล  */                                                   
    /*wdetail2.typrequest   =   trim(wf_typrequest)      /*  รหัสบริษัทผู้แจ้งประกัน  */  */                             
    wdetail2.comrequest   =   trim(wf_typrequest)   /*trim(wf_comrequest) */     /*  ชื่อบริษัทผู้แจ้งงาน */                                   
    wdetail2.brrequest    =   trim(wf_brrequest)    /*  สาขาบริษัทผู้แจ้งประกัน  */                              
    wdetail2.salename     =   trim(wf_salename)     /*  ชื่อผู้ติดต่อ/Saleman    */                             
    wdetail2.comcar       =   trim(wf_comcar)       /*  บริษัทที่ปล่อยรถ */                                     
    wdetail2.brcar        =   trim(wf_brcar)        /*  สาขาบริษัทที่ปล่อยรถ */                                 
    wdetail2.projectno    =   TRIM(wf_projectno)    /*  honda project    */                                     
    wdetail2.caryear      =   trim(wf_agcaryear)    /*  อายุรถ   */                                             
    wdetail2.special1     =   trim(wf_special1)     /*  บริการเสริมพิเศษ1    */                                 
    wdetail2.specialprem1 =   trim(wf_specialprem1) /*  ราคาบริการเสริมพิเศษ1    */                             
    wdetail2.special2     =   trim(wf_special2)     /*  บริการเสริมพิเศษ2    */                                 
    wdetail2.specialprem2 =   trim(wf_specialprem2) /*  ราคาบริการเสริมพิเศษ2    */                             
    wdetail2.special3     =   trim(wf_special3)     /*  บริการเสริมพิเศษ3    */                                 
    wdetail2.specialprem3 =   trim(wf_specialprem3) /*  ราคาบริการเสริมพิเศษ3    */                             
    wdetail2.special4     =   TRIM(wf_special4)     /*  บริการเสริมพิเศษ4    */                                 
    wdetail2.specialprem4 =   trim(wf_specialprem4) /*  ราคาบริการเสริมพิเศษ4    */                             
    wdetail2.special5     =   trim(wf_special5)     /*  บริการเสริมพิเศษ5    */                                 
    wdetail2.specialprem5 =   trim(wf_specialprem5) /*  ราคาบริการเสริมพิเศษ5    */                            
    wdetail2.ac_no        =   trim(wf_ac_no)        /*  เล่มที่/เลขที่   */                    
    wdetail2.ac_date      =   trim(wf_ac_date)      /*  วันที่รับเงิน    */                                   
    wdetail2.ac_amount    =   trim(wf_ac_amount)    /*  จำนวนเงิน    */                        
    wdetail2.ac_pay       =   trim(wf_ac_pay)       /*  ชำระโดย  */                            
    wdetail2.ac_agent     =   TRIM(wf_ac_agent)     /*  เลขที่นายหน้า    */                    
    wdetail2.voictitle    =   IF       trim(wf_voictitle) = "DLR"    THEN "0" /*  ออกใบเสร็จในนาม  */  
                              ELSE IF  trim(wf_voictitle) = "ลูกค้า" THEN "1" 
                              ELSE trim(wf_voictitle)                         
    wdetail2.voicnam      =   TRIM(wf_voicnam)     /*  รหัสDealer Receipt   */  
                             /*=  wf_voicnamdetail /*   ชื่อใบเสร็จ */  */                      
    wdetail2.detailcam    =  trim(wf_detailcam)    /*  รายละเอียดเคมเปญ */                    
    wdetail2.ins_pay      =  trim(wf_ins_pay)      /*   รับประกันจ่ายแน่ๆ   */                
    wdetail2.n_month      =  trim(wf_n_month)      /*   ผ่อนชำระ/เดือน      */                
    wdetail2.n_bank       =  trim(wf_n_bank)       /*   บัตรเครดิตธนาคาร    */                
    wdetail2.TYPE_notify  =  trim(wf_TYPE_notify)  /*   ประเภทการแจ้งงาน    */                
    wdetail2.price_acc    =  trim(wf_price_acc)    /*   ราคารวมอุปกรณ์เสริม */                
    wdetail2.accdata      =  TRIM(wf_accdata)      /*  รายละเอียดอุปกรณ์เสริม   */            
    wdetail2.brdealer     =  trim(wf_brdealer)  .  /*  สาขา(ชื่อผู้เอาประกันในนามบริษัท)    */
ASSIGN wdetail3.policyno   = TRIM(wdetail.policyno) 
    wdetail3.brand_gals    = trim(wf_brand_gals)   /*  ยี่ห้อเคลือบแก้ว */            
    wdetail3.brand_galsprm = trim(wf_brand_galsprm) /*  ราคาเคลือบแก้ว   */            
    wdetail3.companyre1    = trim(wf_companyre1) /*  ชื่อบริษัทเต็มบนใบกำกับภาษี1 */
    wdetail3.companybr1    = trim(wf_companybr1) /*  สาขาบริษัทบนใบกำกับภาษี1 */    
    wdetail3.addr_re1      = trim(wf_addr_re1)   /*  ที่อยู่บนใบกำกับภาษี1    */    
    wdetail3.idno_re1      = trim(wf_idno_re1)   /*  เลขที่ผู้เสียภาษี1   */        
    wdetail3.premt_re1     = TRIM(wf_premt_re1)  /*  อัตราเบี้ยตามใบกำกับ1    */    
    wdetail3.companyre2    = trim(wf_companyre2) /*  ชื่อบริษัทเต็มบนใบกำกับภาษี2 */
    wdetail3.companybr2    = TRIM(wf_companybr2) /*  สาขาบริษัทบนใบกำกับภาษี2 */    
    wdetail3.addr_re2      = trim(wf_addr_re2)   /*  ที่อยู่บนใบกำกับภาษี2    */    
    wdetail3.idno_re2      = trim(wf_idno_re2)   /*  เลขที่ผู้เสียภาษี2   */        
    wdetail3.premt_re2     = trim(wf_premt_re2)  /*  อัตราเบี้ยตามใบกำกับ2    */    
    wdetail3.companyre3    = trim(wf_companyre3) /*  ชื่อบริษัทเต็มบนใบกำกับภาษี3 */
    wdetail3.companybr3    = trim(wf_companybr3) /*  สาขาบริษัทบนใบกำกับภาษี3 */    
    wdetail3.addr_re3      = trim(wf_addr_re3)   /*  ที่อยู่บนใบกำกับภาษี3    */    
    wdetail3.idno_re3      = TRIM(wf_idno_re3)   /*  เลขที่ผู้เสียภาษี3       */    
    wdetail3.premt_re3     = trim(wf_premt_re3)  /*  อัตราเบี้ยตามใบกำกับ3    */ 
    wdetail3.camp_no       = TRIM(wf_camp_no)    /*--- A58-0419 : เลขที่แคมเปญ ---*/
    wdetail3.payment_type  = TRIM(wf_payment_type) /*--- A58-0419 : ประเภทการชำระเบี้ย ---*/ 
    /* add by : A68-0061 */
    wdetail3.net_re1       = trim(wf_net_re1)    
    wdetail3.stam_re1      = trim(wf_stam_re1)    
    wdetail3.vat_re1       = trim(wf_vat_re1)    
    wdetail3.inscode_re2   = trim(wf_inscode_re2) 
    wdetail3.net_re2       = trim(wf_net_re2)   
    wdetail3.stam_re2      = trim(wf_stam_re2)  
    wdetail3.vat_re2       = trim(wf_vat_re2)   
    wdetail3.inscode_re3   = trim(wf_inscode_re3) 
    wdetail3.net_re3       = trim(wf_net_re3)   
    wdetail3.stam_re3      = trim(wf_stam_re3)  
    wdetail3.vat_re3       = trim(wf_vat_re3) .
    /* end : A68-0061 */
ASSIGN  wdetail2.poltyp        = "V70"
    /*wdetail2.subclass      = wdetail.vehuse + wdetail.carno */ /*A68-0061*/
    wdetail2.subclass      = IF ra_typfile = 2 THEN trim(wdetail.carno) ELSE wdetail.vehuse + wdetail.carno  /*A68-0061*/
    wdetail2.seat41        = INTE(wdetail.seat) 
    wdetail2.comment       = ""
    wdetail2.producer      = ""
    wdetail2.producer2     = ""
    wdetail2.producer      = wf_producer
    wdetail2.producer2     = wf_producer
    wdetail2.agent         = trim(fi_agent)
    wdetail2.entdat        = string(TODAY)             /*entry date*/
    wdetail2.enttim        = STRING (TIME, "HH:MM:SS") /*entry time*/
    wdetail2.trandat       = STRING (fi_loaddat)       /*tran date*/
    wdetail2.trantim       = STRING (TIME, "HH:MM:SS") /*tran time*/
    wdetail2.n_IMPORT      = "IM"
    wdetail2.n_EXPORT      = "" .
/* add by : A68-0061 */ 
IF wdetail2.voictitle  = "" AND wf_voictitle = "" THEN DO:  
   IF       trim(wdetail2.voicnam) = "ลูกค้า" THEN assign wdetail2.voictitle  = "1"  .    /*  ออกใบเสร็จในนาม  */  
   ELSE IF  index(wdetail2.voicnam,wdetail.insnam) <> 0  THEN assign wdetail2.voictitle  = "1" .
   ELSE ASSIGN wdetail2.voictitle  = "0"  .
END.
IF ra_typfile = 2 THEN ASSIGN wdetail2.comrequest = TRIM(wf_comrequest).     /*  ชื่อบริษัทผู้แจ้งงาน */
/* end : A68-0061 */ 
ASSIGN wf_instot = 0 .
IF  wf_companyre1  <> "" THEN ASSIGN wf_instot = wf_instot + 1.  /*  ชื่อบริษัทเต็มบนใบกำกับภาษี1 */
IF  wf_companyre2  <> "" THEN ASSIGN wf_instot = wf_instot + 1.  /*  ชื่อบริษัทเต็มบนใบกำกับภาษี2 */
IF  wf_companyre3  <> "" THEN ASSIGN wf_instot = wf_instot + 1.  /*  ชื่อบริษัทเต็มบนใบกำกับภาษี3 */
IF  wf_instot = 0 THEN wdetail3.instot = 1.
ELSE IF wf_instot = 1 THEN DO:
    ASSIGN 
        wdetail3.instot = 1
        wdetail3.companyre2 = ""
        wdetail3.companyre3 = "" .
END.
ELSE wdetail3.instot = wf_instot .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigninit72 C-Win 
PROCEDURE proc_assigninit72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
CREATE wdetail.
CREATE wdetail2.
CREATE wdetail3.
ASSIGN
    wdetail.si = ""
    wdetail.policyno     = trim(wf_policyno)        /*   เลขที่ใบคำขอ*/   
    wdetail2.n_branch    = trim(wf_n_branch)        /*   สาขา        */             
    wdetail2.n_delercode = trim(wf_n_delercode)     /*   รหัสดีเลอร์ */         
    wdetail2.typrequest  = trim(wf_vatcode)         /*   Vat code.   */  
    wdetail.cndat        = trim(wf_cndat)           /*   วันที่ใบคำขอ    */     
    wdetail.appenno      = trim(wf_appenno)         /*   เลขที่รับแจ้ง   */     
    wdetail.comdat       = trim(wf_comdat)          /*   วันที่เริ่มคุ้มครอง */ 
    wdetail.expdat       = trim(wf_expdat)          /*   วันที่สิ้นสุด   */     
    wdetail.comcode      = trim(wf_comcode)         /*   รหัสบริษัทประกันภัย */ 
    wdetail.cartyp       = trim(wf_cartyp)          /*   ประเภทรถ    */         
    wdetail.saletyp      = trim(wf_saletyp)         /*   ประเภทการขาย    */     
    wdetail.campen       = trim(wf_campen)          /*   ประเภทแคมเปญ    */     
    wdetail.freeamonth   = trim(wf_freeamonth)      /*   จำนวนเงินให้ฟรี     */ 
    wdetail.covcod       = trim(wf_covcod)          /*   ประเภทความคุ้มครอง  */ 
    wdetail.typcom       = trim(wf_typcom)          /*   ประเภทประกัน    */     
    wdetail.garage       = trim(wf_garage)          /*   ประเภทการซ่อม   */     
    wdetail.bysave       = trim(wf_bysave)          /*   ผู้บันทึก   */         
    wdetail.tiname       = trim(wf_tiname)          /*   คำนำหน้า    */         
    wdetail.insnam       = trim(wf_insnam)          /*   ชื่อลูกค้า  */         
    wdetail.name2        = trim(wf_name2)           /*   ชื่อกลาง    */         
    wdetail.name3        = trim(wf_name3)           /*   นามสกุล     */         
    wdetail.addr         = trim(wf_addr)            /*   ที่อยู่     */         
    wdetail.road         = trim(wf_road)            /*   ถนน     */             
    wdetail.tambon       = trim(wf_tambon)          /*   ตำบล    */             
    wdetail.amper        = trim(wf_amper)           /*   อำเภอ   */             
    wdetail.country      = trim(wf_country)         /*   จังหวัด     */         
    wdetail.post         = trim(wf_post)            /*   รหัสไปรษณีย์    */     
    wdetail.occup        = trim(wf_occup)           /*   อาชีพ   */             
    wdetail.birthdat     = trim(wf_birthdat)        /*   วันเกิด */                
    wdetail.icno         = trim(wf_icno)            /*   เลขที่บัตรประชาชน   */              
    wdetail.driverno     = trim(wf_driverno)        /*   เลขที่ใบขับขี่  */     
    wdetail.brand        = trim(wf_brand)           /*   ยี่ห้อรถ    */         
    wdetail.cargrp       = trim(wf_cargrp)          /*   กลุ่มรถยนต์     */     
    wdetail.chasno       = trim(wf_chasno)          /*   หมายเลขตัวถัง   */     
    wdetail.eng          = trim(wf_eng)             /*   หมายเลขเครื่อง  */     
    wdetail.model        = trim(wf_model)          /*   ชื่อรุ่นรถ  */  
      /*add : A68-0061 */
    wdetail.typepol     =  trim(wf_typepol)        
    wdetail.typecar     =  trim(wf_typecar)      
    wdetail.maksi       =  trim(wf_maksi) 
    wdetail.chargflg    =  trim(wf_chargflg)       
    wdetail.chargprice  =  trim(wf_chargprice)       
    wdetail.chargno     =  trim(wf_chargno)
    wdetail.chargprm    =  trim(wf_chargprm)       
    wdetail.battflg     =  trim(wf_battflg)
    wdetail.battprice   =  trim(wf_battprice)       
    wdetail.battno      =  trim(wf_battno )
    wdetail.battprm     =  trim(wf_battprm)
    wdetail.battdate    =  trim(wf_battdate)       
    wdetail.rate31      =  trim(wf_31rate )      
    wdetail.premt31     =  trim(wf_31premt) .
    /*end : A68-0061 */
ASSIGN  
    /*wdetail.caryear      = trim(wf_caryear)         /*   รุ่นปี  */  */           
    wdetail.carcode      = trim(wf_carcode)         /*   ชื่อประเภทรถ    */        
    wdetail.body         = trim(wf_body)            /*   แบบตัวถัง   */            
    wdetail.vehuse       = trim(wf_vehuse)          /*   รหัสประเภทรถ    */        
    wdetail.carno        = trim(wf_carno)           /*   รหัสลักษณะการใช้งาน */    
    wdetail.seat         = trim(wf_seat)            /*   จำนวนที่นั่ง    */        
    wdetail.engcc        = trim(wf_engcc)           /*   ปริมาตรกระบอกสูบ    */    
    wdetail.colorcar     = trim(wf_colorcar)        /*   ชื่อสีรถ    */            
    wdetail.vehreg       = trim(wf_vehreg)          /*   เลขทะเบียนรถ    */        
    wdetail.re_country   = trim(wf_re_country)      /*   จังหวัดที่จดทะเบียน */    
    /*wdetail.re_year      = trim(wf_re_year)         /*   ปีที่จดทะเบียน  */  */ 
    wdetail.caryear      = trim(wf_re_year)   
    wdetail.nmember      = trim(wf_nmember)         /*   หมายเหตุ    */              
    wdetail.si           = trim(wf_si)              /*   วงเงินทุนประกัน */         
    wdetail.premt        = trim(wf_premt)           /*   เบี้ยประกัน */             
    wdetail.rstp_t       = trim(wf_rstp_t)          /*   อากร    */                 
    wdetail.rtax_t       = trim(wf_rtax_t)          /*   จำนวนเงินภาษี   */         
    wdetail.prem_r       = trim(wf_prem_r)          /*   เบี้ยประกันรวม  */         
    wdetail.gap          = trim(wf_gap)             /*   เบี้ยประกันรวมทั้งหมด   */ 
    wdetail.ncb          = trim(wf_ncb)             /*   อัตราส่วนลดประวัติดี    */ 
    wdetail.ncbprem      = trim(wf_ncbprem)         /*   ส่วนลดประวัติดี */         
    wdetail.stk          = trim(wf_stk)             /*   หมายเลขสติ๊กเกอร์   */     
    wdetail.prepol       = trim(wf_prepol)  .       /*   เลขที่กรมธรรม์เดิม  */     
ASSIGN  wdetail.flagname = trim(wf_flagname)        /*   flag ระบุชื่อ   */                     
    wdetail.flagno       = trim(wf_flagno)          /*   flag ไม่ระบุชื่อ    */                 
    wdetail.ntitle1      = trim(wf_ntitle1)         /*   คำนำหน้า    */                         
    wdetail.drivername1  = trim(wf_drivername1)     /*   ชื่อผู้ขับขี่คนที่1 */            
    wdetail.dname1       = trim(wf_dname1)          /*   ชื่อกลาง    */                    
    wdetail.dname2       = trim(wf_dname2)          /*   นามสกุล */                        
    wdetail.docoup       = trim(wf_docoup)          /*   อาชีพ   */                        
    wdetail.dbirth       = trim(wf_dbirth)          /*   วันเกิด */                        
    wdetail.dicno        = trim(wf_dicno)           /*   เลขที่บัตรประชาชน   */            
    wdetail.ddriveno     = trim(wf_ddriveno)        /*   เลขที่ใบขับขี่  */                
    wdetail.ntitle2      = TRIM(wf_ntitle2)         /*   คำนำหน้า2   */                            
    wdetail.drivername2   = trim(wf_drivername2) .  /*   ชื่อผู้ขับขี่คนที่2     */         
ASSIGN wdetail.ddname1    = trim(wf_ddname1)        /*   ชื่อกลาง2   */                     
    wdetail.ddname2       = trim(wf_ddname2)        /*   นามสกุล2    */                     
    wdetail.ddocoup       = trim(wf_ddocoup)        /*   อาชีพ2  */                         
    wdetail.ddbirth       = trim(wf_ddbirth)        /*   วันเกิด2    */                      
    wdetail.ddicno        = trim(wf_ddicno)         /*   เลขที่บัตรประชาชน2  */             
    wdetail.dddriveno     = trim(wf_dddriveno)      /*   เลขที่ใบขับขี่2 */                 
    wdetail.benname       = TRIM(wf_benname)        /*   ผู้รับผลประโยชน์    */             
    wdetail.comper        = trim(wf_comper)         /*   ความเสียหายต่อชีวิต(บาท/คน) */     
    wdetail.comacc        = trim(wf_comacc)         /*   ความเสียหายต่อชีวิต(บาท/ครั้ง)  */ 
    wdetail.deductpd      = trim(wf_deductpd)       /*   ความเสียหายต่อทรัพย์สิน */         
    wdetail.tp2           = trim(wf_tp2)            /*   ความเสียหายส่วนแรกบุคคล */         
    wdetail.deductda      = trim(wf_deductda)       /*   ความเสียหายต่อต่อรถยนต์ */         
    wdetail.deduct        = trim(wf_deduct)         /*   ความเสียหายส่วนแรกรถยนต์    */     
    wdetail.tpfire        = trim(wf_tpfire)         /*   รถยนต์สูญหาย/ไฟไหม้     */         
    wdetail.compul        = "y"              
    wdetail2.policyno     = wdetail.policyno                                                
    wdetail2.NO_41        = trim(wf_NO_41)           /*  อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่    */                             
    wdetail2.ac2          = trim(wf_ac2)           /*  อุบัติเหตุส่วนบุคคลเสียชีวิตจน.ผู้โดยสาร */                            
    wdetail2.NO_42        = trim(wf_NO_42)           /*  อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง    */                    
    wdetail2.ac4          = trim(wf_ac4)           /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้ขับขี่ */                        
    wdetail2.ac5          = trim(wf_ac5)             /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวจน.ผู้โดยสาร  */                    
    wdetail2.ac6          = trim(wf_ac6)             /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้โดยสารต่อครั้ง */                
    wdetail2.ac7          = trim(wf_ac7)   .         /*  ค่ารักษาพยาบาล   */                                    
ASSIGN wdetail2.NO_43     = TRIM(wf_NO_43)           /*  การประกันตัวผู้ขับขี่    */                                       
    wdetail2.nstatus      = trim(wf_nstatus)         /*  สถานะข้อมูล  */                                                   
    /*wdetail2.typrequest   =   trim(wf_typrequest)      /*  รหัสบริษัทผู้แจ้งประกัน  */  */                             
    wdetail2.comrequest   =   trim(wf_typrequest)  /*trim(wf_comrequest) */     /*  ชื่อบริษัทผู้แจ้งงาน */                               
    wdetail2.brrequest    =   trim(wf_brrequest)       /*  สาขาบริษัทผู้แจ้งประกัน  */                              
    wdetail2.salename     =   trim(wf_salename)        /*  ชื่อผู้ติดต่อ/Saleman    */                             
    wdetail2.comcar       =   trim(wf_comcar)          /*  บริษัทที่ปล่อยรถ */                                     
    wdetail2.brcar        =   trim(wf_brcar)           /*  สาขาบริษัทที่ปล่อยรถ */                                 
    wdetail2.projectno    =   TRIM(wf_projectno)       /*  honda project    */                                     
    wdetail2.caryear      =   trim(wf_agcaryear)       /*  อายุรถ   */                                             
    wdetail2.special1     =   trim(wf_special1)        /*  บริการเสริมพิเศษ1    */                                 
    wdetail2.specialprem1 =   trim(wf_specialprem1)    /*  ราคาบริการเสริมพิเศษ1    */                             
    wdetail2.special2     =   trim(wf_special2)        /*  บริการเสริมพิเศษ2    */                                 
    wdetail2.specialprem2 =   trim(wf_specialprem2)    /*  ราคาบริการเสริมพิเศษ2    */                             
    wdetail2.special3     =   trim(wf_special3)        /*  บริการเสริมพิเศษ3    */                                 
    wdetail2.specialprem3 =   trim(wf_specialprem3)    /*  ราคาบริการเสริมพิเศษ3    */                             
    wdetail2.special4     =   TRIM(wf_special4)        /*  บริการเสริมพิเศษ4    */                                 
    wdetail2.specialprem4 =   trim(wf_specialprem4)    /*  ราคาบริการเสริมพิเศษ4    */                             
    wdetail2.special5     =   trim(wf_special5)        /*  บริการเสริมพิเศษ5    */                                 
    wdetail2.specialprem5 =   trim(wf_specialprem5)    /*  ราคาบริการเสริมพิเศษ5    */                            
    wdetail2.ac_no        =   trim(wf_ac_no)           /*  เล่มที่/เลขที่   */                    
    wdetail2.ac_date      =   trim(wf_ac_date)         /*  วันที่รับเงิน    */                                   
    wdetail2.ac_amount    =   trim(wf_ac_amount)       /*  จำนวนเงิน    */                        
    wdetail2.ac_pay       =   trim(wf_ac_pay)          /*  ชำระโดย  */                            
    wdetail2.ac_agent     =   TRIM(wf_ac_agent)        /*  เลขที่นายหน้า    */                    
    wdetail2.voictitle    =   IF       trim(wf_voictitle) = "DLR"    THEN "0"      /*  ออกใบเสร็จในนาม  */  
                              ELSE IF  trim(wf_voictitle) = "ลูกค้า" THEN "1"  
                                  ELSE trim(wf_voictitle)                  
    wdetail2.voicnam      =   TRIM(wf_voicnam)         /*  รหัสDealer Receipt   */  
                               /*=  wf_voicnamdetail   /*   ชื่อใบเสร็จ */  */                      
    wdetail2.detailcam    =  trim(wf_detailcam)       /*  รายละเอียดเคมเปญ */                    
    wdetail2.ins_pay      =  trim(wf_ins_pay)         /*   รับประกันจ่ายแน่ๆ   */                
    wdetail2.n_month      =  trim(wf_n_month)         /*   ผ่อนชำระ/เดือน      */                
    wdetail2.n_bank       =  trim(wf_n_bank)          /*   บัตรเครดิตธนาคาร    */                
    wdetail2.TYPE_notify  =  trim(wf_TYPE_notify)     /*   ประเภทการแจ้งงาน    */                
    wdetail2.price_acc    =  trim(wf_price_acc)       /*   ราคารวมอุปกรณ์เสริม */                
    wdetail2.accdata      =  TRIM(wf_accdata)         /*  รายละเอียดอุปกรณ์เสริม   */            
    wdetail2.brdealer     =  trim(wf_brdealer)  .      /*  สาขา(ชื่อผู้เอาประกันในนามบริษัท)    */
ASSIGN 
    wdetail3.policyno      = TRIM(wdetail.policyno) 
    wdetail3.brand_gals    = trim(wf_brand_gals)     /*  ยี่ห้อเคลือบแก้ว */            
    wdetail3.brand_galsprm = trim(wf_brand_galsprm)  /*  ราคาเคลือบแก้ว   */            
    wdetail3.companyre1    = trim(wf_companyre1)     /*  ชื่อบริษัทเต็มบนใบกำกับภาษี1 */
    /*wdetail3.companybr1    = trim(wf_companybr1)     /*  สาขาบริษัทบนใบกำกับภาษี1 */    
    wdetail3.addr_re1      = trim(wf_addr_re1)       /*  ที่อยู่บนใบกำกับภาษี1    */    
    wdetail3.idno_re1      = trim(wf_idno_re1)       /*  เลขที่ผู้เสียภาษี1   */        
    wdetail3.premt_re1     = TRIM(wf_premt_re1)      /*  อัตราเบี้ยตามใบกำกับ1    */    
    wdetail3.companyre2    = trim(wf_companyre2)     /*  ชื่อบริษัทเต็มบนใบกำกับภาษี2 */
    wdetail3.companybr2    = TRIM(wf_companybr2)     /*  สาขาบริษัทบนใบกำกับภาษี2 */    
    wdetail3.addr_re2      = trim(wf_addr_re2)       /*  ที่อยู่บนใบกำกับภาษี2    */    
    wdetail3.idno_re2      = trim(wf_idno_re2)       /*  เลขที่ผู้เสียภาษี2   */        
    wdetail3.premt_re2     = trim(wf_premt_re2)      /*  อัตราเบี้ยตามใบกำกับ2    */    
    wdetail3.companyre3    = trim(wf_companyre3)     /*  ชื่อบริษัทเต็มบนใบกำกับภาษี3 */
    wdetail3.companybr3    = trim(wf_companybr3)     /*  สาขาบริษัทบนใบกำกับภาษี3 */    
    wdetail3.addr_re3      = trim(wf_addr_re3)       /*  ที่อยู่บนใบกำกับภาษี3    */    
    wdetail3.idno_re3      = TRIM(wf_idno_re3)       /*  เลขที่ผู้เสียภาษี3       */    
    wdetail3.premt_re3     = trim(wf_premt_re3)*/     /*  อัตราเบี้ยตามใบกำกับ3    */ 
    wdetail3.camp_no       = TRIM(wf_camp_no)        /*--- A58-0419 : เลขที่แคมเปญ ---*/
    wdetail3.payment_type  = TRIM(wf_payment_type).  /*--- A58-0419 : ประเภทการชำระเบี้ย ---*/
ASSIGN                       
    wdetail2.poltyp        = "V72"
    /*wdetail2.subclass      = wdetail.vehuse + wdetail.carno */ /*A68-0061*/
    wdetail2.subclass      = IF ra_typfile = 2 THEN trim(wdetail.carno) ELSE wdetail.vehuse + wdetail.carno  /*A68-0061*/ 
    wdetail2.seat41        = INTE(wdetail.seat) 
    wdetail2.comment       = ""
    wdetail2.producer      = ""
    wdetail2.producer2     = ""
    wdetail2.producer      = wf_producer
    wdetail2.producer2     = wf_producer
    wdetail2.agent         = trim(fi_agent)
    wdetail2.entdat        = string(TODAY)                /*entry date*/
    wdetail2.enttim        = STRING (TIME, "HH:MM:SS")    /*entry time*/
    wdetail2.trandat       = STRING (fi_loaddat)          /*tran date*/
    wdetail2.trantim       = STRING (TIME, "HH:MM:SS")    /*tran time*/
    wdetail2.n_IMPORT      = "IM"
    wdetail2.n_EXPORT      = "" 
    wdetail3.instot        = 1   .
   /* add by : A68-0061 */ 
   IF wdetail2.voictitle  = "" AND wf_voictitle = "" THEN DO:  
       IF       trim(wdetail2.voicnam) = "ลูกค้า"    THEN assign wdetail2.voictitle  = "1"  .    /*  ออกใบเสร็จในนาม  */  
       ELSE IF  trim(wdetail2.voicnam) = "Other"     THEN assign wdetail2.voictitle  = "2"  .
       ELSE ASSIGN wdetail2.voictitle  = "0"  .
   END.
   IF ra_typfile = 2  THEN ASSIGN wdetail2.comrequest = trim(wf_comrequest).     /*  ชื่อบริษัทผู้แจ้งงาน */
   /* end : A68-0061 */ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew C-Win 
PROCEDURE proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Add by Kridtiya i. Date. 03/06/2024 ปรับแก้ไข ไม่เอาตามเตือน กรณีข้อมูลไม่ตรงกัน*/
DEF VAR nr_prempa    AS CHAR FORMAT "x(4)"  INIT "".
DEF VAR nr_subclass  AS CHAR FORMAT "x(4)"  INIT "".
DEF VAR nr_model     AS CHAR FORMAT "x(60)" INIT "". 
DEF VAR nr_redbook   AS CHAR FORMAT "x(10)" INIT "".         
DEF VAR nr_chasno    AS CHAR FORMAT "x(30)" INIT "".       
DEF VAR nr_eng       AS CHAR FORMAT "x(30)" INIT "".    
DEF VAR nr_caryear   AS CHAR FORMAT "x(4)"  INIT "". 
DEF VAR n_covcod     AS CHAR FORMAT "x(3)"  INIT "".
DEF VAR n_netprem    AS DECI INIT 0 .
def var n_ncb        as DECI .
def var n_garage     as char .
DEF VAR n_cargrp     as char . 
DEF VAR n_vehuse     as char . 
DEF VAR n_body       as char . 
DEF VAR n_seat       as INTE . 
DEF VAR n_engcc      as char .  
ASSIGN  
    nr_prempa   = ""
    nr_subclass = ""
    nr_prempa   = trim(wdetail2.prempa)
    nr_subclass = trim(wdetail2.subclass) 
    nr_model    = wdetail.model 
    nr_redbook  = wdetail2.redbook 
    nr_chasno   = wdetail.chasno 
    nr_eng      = wdetail.engcc 
    nr_caryear  = wdetail.caryear
    n_deductDOD  = 0
    n_deductDOD2 = 0
    n_deductDPD  = 0    
    n_covcod    = ""
    n_NCB       = 0
    n_garage    = ""
    nv_cctvcode = ""    
    n_netprem   = 0
    nv_driver   = ""
    n_prmtdriv  = 0
    n_drivnam   = "N"
    n_ndriv1    = ""
    n_bdate1    = ""
    n_ndriv2    = ""
    n_bdate2    = "" 
    n_cargrp     = ""    
    nr_chasno    = ""    
    nr_eng       = ""   
    n_vehuse     = ""   
    nr_caryear   = "" 
    n_body       = ""  
    n_seat       = 0  
    n_engcc      = ""  
    n_41         = 0  
    n_42         = 0  
    n_43         = 0  
    nv_basere    = 0   
    nv_dss_per   = 0 .

IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwhcex1 (INPUT-OUTPUT wdetail.prepol,    
                      INPUT-OUTPUT wdetail2.prempa,   /*nr_prempa,      */ 
                      INPUT-OUTPUT wdetail2.subclass, /*nr_subclass,    */ 
                      INPUT-OUTPUT wdetail.model,     /*nr_model,       */ 
                      INPUT-OUTPUT wdetail2.redbook,  /*nr_redbook,     */ 
                      INPUT-OUTPUT wdetail.cargrp,    /*n_cargrp,       */ 
                      INPUT-OUTPUT wdetail.chasno,    /*nr_chasno,      */ 
                      INPUT-OUTPUT wdetail.eng,       /*nr_eng,         */ 
                      INPUT-OUTPUT wdetail.vehuse,    /*n_vehuse,       */ 
                      INPUT-OUTPUT wdetail.caryear,   /*nr_caryear,     */ 
                      INPUT-OUTPUT n_covcod,                 
                      INPUT-OUTPUT wdetail.body,      /*n_body, */     
                      INPUT-OUTPUT wdetail.seat,      /*n_seat, */     
                      INPUT-OUTPUT wdetail.engcc,     /*n_engcc,*/     
                      INPUT-OUTPUT n_41,                   
                      INPUT-OUTPUT n_42,                   
                      INPUT-OUTPUT n_43,                   
                      INPUT-OUTPUT nv_basere,              
                      INPUT-OUTPUT nv_dss_per,             
                      INPUT-OUTPUT n_NCB,            
                      INPUT-OUTPUT n_garage ,        
                      INPUT-OUTPUT n_firstdat,       
                      INPUT-OUTPUT n_deductDOD,     
                      INPUT-OUTPUT n_deductDOD2,     
                      INPUT-OUTPUT n_deductDPD,      
                      INPUT-OUTPUT n_netprem  ,      
                      INPUT-OUTPUT nv_driver ,       
                      INPUT-OUTPUT n_prmtdriv ,      
                      INPUT-OUTPUT n_drivnam  ,      
                      INPUT-OUTPUT n_ndriv1   ,      
                      INPUT-OUTPUT n_bdate1   ,      
                      INPUT-OUTPUT n_ndriv2   ,      
                      INPUT-OUTPUT n_bdate2   ,      
                      INPUT-OUTPUT nv_cctvcode ) .   
                      
END.
IF nr_model    <> "" THEN  wdetail.model    = nr_model    .
IF nr_chasno   <> "" THEN  wdetail.chasno   = nr_chasno   .
IF nr_eng      <> "" THEN  wdetail.engcc    = nr_eng      .
IF nr_caryear  <> "" THEN  wdetail.caryear  = nr_caryear  . 

/* เก็บข้อมูลตามไฟล์ A68-0061 */
IF n_deductDOD <> 0 THEN DO:
     ASSIGN wdetail2.comment = wdetail2.comment + "|ตรวจสอบ Deduct ในไฟล์ " + wdetail.deduct + " และใบเตือน " + STRING(n_deductDOD,">,>>>,>>>,>>9.99-") 
            wdetail2.WARNING = wdetail2.WARNING + "|ตรวจสอบ Deduct ในไฟล์และใบเตือน" 
            wdetail2.pass    = IF wdetail2.pass = "N" THEN "N" ELSE "Y"  .
END.
ASSIGN
nv_driver   = ""  
n_prmtdriv  = 0   
n_drivnam   = "N" 
n_ndriv1    = ""  
n_bdate1    = ""  
n_ndriv2    = ""  
n_bdate2    = "" 
n_deductDOD  = 0     
n_deductDOD2 = 0    
n_deductDPD  = 0 .
/*  เก็บข้อมูลตามไฟล์ */

IF trim(wdetail.covcod) =  trim(n_covcod) THEN DO: 
    IF DECI(wdetail.premt) <> n_netprem THEN DO:
        ASSIGN wdetail2.comment = wdetail2.comment + "|เบี้ยในไฟล์ " + wdetail.premt + " ไม่เท่ากับใบเตือน " + STRING(n_netprem,">,>>>,>>>,>>9.99-") 
            wdetail2.WARNING = wdetail2.WARNING + "|เบี้ยในไฟล์และใบเตือนไม่เท่ากัน" 
            wdetail2.pass    = IF wdetail2.pass = "N" THEN "N" ELSE "Y"  .
    END.
    ELSE DO:
        ASSIGN 
            wdetail2.NO_41 =  string(n_41)  
            wdetail2.NO_42 =  string(n_42)  
            wdetail2.NO_43 =  string(n_43)  
            /*nv_basere      =  nv_basere  */                 
            /*nv_dss_per     =  nv_dss_per  */                
            wdetail.NCB    =  STRING(n_ncb)  
            wdetail.covcod =  trim(n_covcod)
            wdetail.garage =  n_garage      
            n_deductDOD    =  n_deductDOD 
            n_deductDOD2   =  n_deductDOD2
            n_deductDPD    =  n_deductDPD 
            n_netprem      =  n_netprem
            nv_driver      =  nv_driver 
            n_prmtdriv     =  n_prmtdriv  
            n_drivnam      =  n_drivnam   
            n_ndriv1       =  n_ndriv1    
            n_bdate1       =  n_bdate1    
            n_ndriv2       =  n_ndriv2    
            n_bdate2       =  n_bdate2
            wdetail.premt  = string(n_netprem) .  
        /*add kridtiya i.  A58-0115...*/
        IF nv_cctvcode = "" THEN DO:
            IF index(wdetail.nmember,"กล้อง") <> 0 OR index(wdetail.nmember,"CCTV") <> 0  THEN DO:  /* + CCTV 5 per for Renew */
                nv_cctvcode = "0001".             /* Code CCTV */
                IF nv_dss_per  > 28 THEN nv_dss_per = 33 .   /* 28 + 5 = 33 */
                ELSE nv_dss_per = nv_dss_per + 5.
            END.
        END.
    END.
END.
ELSE DO:   
    ASSIGN wdetail2.comment = wdetail2.comment + "|Cover Code ในไฟล์ " + wdetail.covcod + " ไม่เหมือน ใบเตือน " + n_covcod + " ใช้ข้อมูลในไฟล์ "
        wdetail2.WARNING = wdetail2.WARNING + "|Cover Code ในไฟล์และใบเตือนไม่ตรงกัน"
        wdetail2.pass    = IF wdetail2.pass = "N" THEN "N" ELSE "Y" .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_csv C-Win 
PROCEDURE proc_assign_csv :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_process = "Create data HCT....".
DISP fi_process WITH FRAM fr_main.
For each  wdetail.
    DELETE  wdetail.
END.
For each  wdetail2.
    DELETE  wdetail2.
END.
For each  wdetail3.
    DELETE  wdetail3.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "," 
        wf_policyno                   
        wf_cndat                      
        wf_appenno                    
        wf_comdat                     
        wf_expdat                     
        wf_comcode                    
        wf_cartyp                     
        wf_saletyp                    
        wf_typcom                     
        wf_covcod                     
        wf_garage                     
        wf_typepol                    
        wf_bysave                     
        wf_tiname                     
        wf_insnam                     
        wf_name2                      
        wf_name3                      
        wf_addr                       
        wf_road                       
        wf_tambon                     
        wf_amper                      
        wf_country                    
        wf_post                       
        wf_icno                       
        wf_brdealer                   
        wf_occup                      
        wf_birthdat                   
        wf_driverno                   
        wf_brand                      
        wf_cargrp                     
        wf_typecar                    
        wf_chasno                     
        wf_eng                        
        wf_model                      
        wf_caryear                    
        wf_carcode                    
        wf_maksi                      
        wf_body                       
        wf_carno                      
        wf_seat                       
        wf_engcc                      
        wf_colorcar                   
        wf_vehreg                     
        wf_re_country                 
        wf_re_year                    
        wf_si                         
        wf_premt                      
        wf_rstp_t                     
        wf_rtax_t                     
        wf_prem_r                     
        wf_gap                        
        wf_ncb                        
        wf_ncbprem                    
        wf_stk                        
        wf_prepol                     
        wf_ntitle1                    
        wf_drivername1                
        wf_dname1                     
        wf_dname2                     
        wf_docoup                     
        wf_dbirth                     
        wf_dicno                      
        wf_ddriveno                   
        wf_drivexp1                   
        wf_drivcon1                   
        wf_dlevel1                    
        wf_dgender1                   
        wf_drelation1                 
        wf_ntitle2                    
        wf_drivername2                
        wf_ddname1                    
        wf_ddname2                    
        wf_ddocoup                    
        wf_ddbirth                    
        wf_ddicno                     
        wf_dddriveno                  
        wf_drivexp2                   
        wf_drivcon2                   
        wf_dlevel2                    
        wf_dgender2                   
        wf_drelation2                 
        wf_ntitle3                    
        wf_dname3                     
        wf_dcname3                    
        wf_dlname3                    
        wf_doccup3                    
        wf_dbirth3                    
        wf_dicno3                     
        wf_ddriveno3                  
        wf_drivexp3                   
        wf_drivcon3                   
        wf_dlevel3                    
        wf_dgender3                   
        wf_drelation3                 
        wf_ntitle4                    
        wf_dname4                     
        wf_dcname4                    
        wf_dlname4                    
        wf_doccup4                    
        wf_dbirth4                    
        wf_dicno4                     
        wf_ddriveno4                  
        wf_drivexp4                   
        wf_drivcon4                   
        wf_dlevel4                    
        wf_dgender4                   
        wf_drelation4                 
        wf_ntitle5                    
        wf_dname5                     
        wf_dcname5                    
        wf_dlname5                    
        wf_doccup5                    
        wf_dbirth5                    
        wf_dicno5                     
        wf_ddriveno5                  
        wf_drivexp5                   
        wf_drivcon5                   
        wf_dlevel5                    
        wf_dgender5                   
        wf_drelation5                 
        wf_benname                    
        wf_comper                     
        wf_comacc                     
        wf_deductpd                   
        wf_tp2                        
        wf_deductda                   
        wf_deduct                     
        wf_tpfire                     
        wf_NO_41                      
        wf_ac2                        
        wf_NO_42                      
        wf_ac4                        
        wf_ac5                        
        wf_ac6                        
        wf_ac7                        
        wf_NO_43                      
        wf_typrequest                 
        wf_comrequest                 
        wf_brrequest                  
        wf_salename                   
        wf_comcar                     
        wf_brcar                      
        wf_agcaryear                  
        wf_ac_date                    
        wf_ac_amount                  
        wf_ac_pay                     
        wf_ac_agent                   
        wf_detailcam                  
        wf_ins_pay                    
        wf_n_month                    
        wf_n_bank                     
        wf_TYPE_notify                
        wf_price_acc                  
        wf_accdata                    
        wf_chargflg                   
        wf_chargprice                 
        wf_chargno                    
        wf_chargprm                   
        wf_battflg                    
        wf_battprice                  
        wf_battno                     
        wf_battprm                    
        wf_battdate                   
        wf_brand_gals                 
        wf_brand_galsprm              
        wf_voicnam                    
        wf_companyre1                 
        wf_companybr1                 
        wf_addr_re1                   
        wf_idno_re1                   
        wf_net_re1                    
        wf_stam_re1                   
        wf_vat_re1                    
        wf_premt_re1                  
        wf_inscode_re2                
        wf_companyre2                 
        wf_companybr2                 
        wf_addr_re2                   
        wf_idno_re2                   
        wf_net_re2                    
        wf_stam_re2                   
        wf_vat_re2                    
        wf_premt_re2                  
        wf_inscode_re3                
        wf_companyre3                 
        wf_companybr3                 
        wf_addr_re3                   
        wf_idno_re3                   
        wf_net_re3                    
        wf_stam_re3                   
        wf_vat_re3                    
        wf_premt_re3                  
        wf_camp_no                    
        wf_payment_type               
        wf_nmember                    
        wf_31rate                 /*Rate ร.ย.31*/
        wf_31premt    .          /*เบี้ย ร.ย.31 */
    IF            TRIM(wf_policyno) = ""           THEN RUN proc_initdataex.
    ELSE IF index(TRIM(wf_policyno),"TEXT")   <> 0 THEN RUN proc_initdataex.
    ELSE IF index(TRIM(wf_policyno),"เลขที่") <> 0 THEN RUN proc_initdataex.
    ELSE IF INDEX(TRIM(wf_policyno),"จำนวน")  <> 0 THEN RUN proc_initdataex.  /*--A58-0419--*/
    ELSE DO:
        ASSIGN wf_garage  = IF trim(wf_garage) = "ซ่อมห้าง"  THEN "HONDA"  ELSE IF trim(wf_garage) = "ซ่อมอู่"  THEN "GARAGE" ELSE TRIM(wf_garage) 
               wf_saletyp = IF     trim(wf_saletyp) = "Normal"   THEN "N" 
                           ELSE IF trim(wf_saletyp) = "Staff"    THEN "S" 
                           ELSE IF INDEX(wf_saletyp,"HATC") <> 0 THEN "H"
                           ELSE IF INDEX(wf_saletyp,"HLTC") <> 0 THEN "F"
                           ELSE IF INDEX(wf_saletyp,"Campaign") <> 0 THEN "C"
                           ELSE TRIM(wf_saletyp)
               wf_covcod  = IF     INDEX(wf_covcod,"2+") <> 0 AND deci(wf_deductpd) = 2000 THEN "2.1"
                           ELSE IF INDEX(wf_covcod,"2+") <> 0 AND deci(wf_deductpd) = 0    THEN "2.2"
                           ELSE IF INDEX(wf_covcod,"3+") <> 0 AND deci(wf_deductpd) = 2000 THEN "3.1" 
                           ELSE IF INDEX(wf_covcod,"3+") <> 0 AND deci(wf_deductpd) = 0    THEN "3.2" 
                           ELSE IF INDEX(wf_covcod,"1") <> 0  THEN "1"
                           ELSE IF INDEX(wf_covcod,"2") <> 0  THEN "2" 
                           ELSE IF INDEX(wf_covcod,"3") <> 0  THEN "3" ELSE "T"
              wf_TYPE_notify = IF      trim(wf_TYPE_notify) = "New"    THEN "N" 
                               ELSE IF trim(wf_TYPE_notify) = "Renew"  THEN "R" 
                               ELSE IF TRIM(wf_type_notify) = "Switch" THEN "S" 
                               ELSE TRIM(wf_type_notify) 
              wf_vehuse  = IF INDEX(wf_carno,"11") <> 0 THEN "1" ELSE "2" 
              wf_flagno  = IF trim(wf_drivername1) <> ""  THEN "0" ELSE "1" .

        IF      wf_covcod = "0" THEN ASSIGN  wf_policyno  = "0" + trim(wf_policyno). 
        ELSE IF wf_covcod = "T" THEN ASSIGN  wf_policyno  = "0" + trim(wf_policyno). 
        ELSE IF index(wf_covcod,"พรบ") <> 0 THEN ASSIGN  wf_policyno  = "0" + trim(wf_policyno). 
        ELSE IF INDEX(wf_covcod,"2.")  <> 0 THEN ASSIGN  wf_policyno  = "5" + trim(wf_policyno).
        ELSE IF INDEX(wf_covcod,"3.")  <> 0 THEN ASSIGN  wf_policyno  = "9" + trim(wf_policyno).
        ELSE IF INDEX(wf_covcod,"1")   <> 0 THEN ASSIGN  wf_policyno  = "1" + trim(wf_policyno).
        ELSE IF INDEX(wf_covcod,"2")   <> 0 THEN ASSIGN  wf_policyno  = "2" + trim(wf_policyno).
        ELSE IF INDEX(wf_covcod,"3")   <> 0 THEN ASSIGN  wf_policyno  = "3" + trim(wf_policyno).
       
        IF Trim(wf_covcod) =  "T" THEN RUN proc_assigninit72.
                                  ELSE RUN proc_assigninit70.
        RUN proc_initdataex.
    END.
    
END.         /* repeat   */
INPUT CLOSE.   /*close Import*/

RUN proc_assign2. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_csv-01 C-Win 
PROCEDURE proc_assign_csv-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*ASSIGN fi_process = "Create data HCT....".
DISP fi_process WITH FRAM fr_main.
For each  wdetail.
    DELETE  wdetail.
END.
For each  wdetail2.
    DELETE  wdetail2.
END.
For each  wdetail3.
    DELETE  wdetail3.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "|" 
        wf_policyno               /*เลขที่ใบคำขอ  */
        wf_n_branch               /*สาขา          */
        wf_n_delercode            /*รหัสดีเลอร์   */
        wf_vatcode                /*Vat code.     */
        wf_cndat                  /*วันที่ใบคำขอ  */
        wf_appenno                /*เลขที่รับแจ้ง */
        wf_comdat                 /*วันที่เริ่มคุ้มครอง */  
        wf_expdat                 /*วันที่สิ้นสุด */    
        wf_comcode                /*รหัสบริษัทประกันภัย */  
        wf_cartyp                 /*ประเภทการเช่าซื้อรถ */  
        wf_saletyp                /*ประเภทการขาย  */    
        wf_typepol                /*ประเภทกรมธรรม์*/    
        wf_covcod                 /*ประเภทความคุ้มครอง  */  
        wf_typcom                 /*ประเภทประกัน  */
        wf_garage                 /*ประเภทการซ่อม */
        wf_bysave                 /*ผู้บันทึก     */
        wf_tiname                 /*คำนำหน้า      */
        wf_insnam                 /*ชื่อลูกค้า    */
        wf_name2                  /*ชื่อกลาง      */
        wf_name3                  /*นามสกุล       */
        wf_addr                   /*ที่อยู่       */
        wf_road                   /*ถนน           */
        wf_tambon                 /*ตำบล          */
        wf_amper                  /*อำเภอ         */
        wf_country                /*จังหวัด       */
        wf_post                   /*รหัสไปรษณีย์  */
        wf_icno                   /*เลขที่บัตรประชาชน     */
        wf_brdealer               /*สาขาบริษัทผู้เอาประกัน*/
        wf_occup                  /*อาชีพ         */
        wf_birthdat               /*วันเกิด       */
        wf_driverno               /*เลขที่ใบขับขี่*/
        wf_brand                  /*ยี่ห้อรถ      */
        wf_cargrp                 /*กลุ่มรถยนต์   */
        wf_typecar                /*แบบรถยนต์     */
        wf_chasno                 /*หมายเลขตัวถัง */
        wf_eng                    /*หมายเลขเครื่อง*/
        wf_model                  /*ชื่อรุ่นรถ    */
        wf_caryear                /*รุ่นปี        */
        wf_carcode                /*ชื่อประเภทรถ  */
        wf_maksi                  /*ราคารถ        */
        wf_body                   /*แบบตัวถัง     */
        wf_vehuse                 /*รหัสลักษณะการใช้งาน */  
        wf_carno                  /*รหัสประเภทรถ  */    
        wf_seat                   /*จำนวนที่นั่ง  */    
        wf_engcc                  /*ปริมาตรกระบอกสูบ    */  
        wf_colorcar               /*ชื่อสีรถ      */    
        wf_vehreg                 /*เลขทะเบียนรถ  */    
        wf_re_country             /*จังหวัดที่จดทะเบียน */  
        wf_re_year                /*ปีที่จดทะเบียน*/    
        wf_si                     /*วงเงินทุนประกัน     */  
        wf_premt                  /*เบี้ยประกัน   */
        wf_rstp_t                 /*อากร          */
        wf_rtax_t                 /*จำนวนเงินภาษี */
        wf_prem_r                 /*เบี้ยประกันรวม*/
        wf_gap                    /*เบี้ยประกันรวมทั้งหมด*/ 
        wf_ncb                    /*อัตราส่วนลดประวัติดี */ 
        wf_ncbprem                /*ส่วนลดประวัติดี      */ 
        wf_stk                    /*หมายเลขสติ๊กเกอร์    */ 
        wf_prepol                 /*เลขที่กรมธรรม์เดิม   */ 
        wf_flagno             /*flag ระบุชื่อ */     
        wf_ntitle1                /*ผู้ขับขี่1 คำนำหน้า  */ 
        wf_drivername1            /*ผู้ขับขี่1 ชื่อ      */ 
        wf_dname1                 /*ผู้ขับขี่1 ชื่อกลาง  */ 
        wf_dname2                 /*ผู้ขับขี่1 นามสกุล   */ 
        wf_docoup                 /*ผู้ขับขี่1 อาชีพ     */ 
        wf_dbirth                 /*ผู้ขับขี่1 วันเกิด   */ 
        wf_dicno                  /*ผู้ขับขี่1 เลขที่บัตรประชาชน */ 
        wf_ddriveno               /*ผู้ขับขี่1 เลขที่ใบขับขี่    */ 
        wf_drivexp1               /*ผู้ขับขี่1 วันหมดอายุใบขับขี่*/ 
        wf_drivcon1               /*ความยินยอมขับขี่1   */ 
        wf_dlevel1                /*ผู้ขับขี่1 ระดับพฤติกรรมการขับขี่*/ 
        wf_dgender1               /*ผู้ขับขี่1 เพศ*/    
        wf_drelation1             /*ผู้ขับขี่1 ความสัมพันธ์กับผู้เอาประกั  */
        wf_ntitle2                /*ผู้ขับขี่2 คำนำหน้า */  
        wf_drivername2            /*ผู้ขับขี่2 ชื่อ     */  
        wf_ddname1                /*ผู้ขับขี่2 ชื่อกลาง */  
        wf_ddname2                /*ผู้ขับขี่2 นามสกุล  */  
        wf_ddocoup                /*ผู้ขับขี่2 อาชีพ    */  
        wf_ddbirth                /*ผู้ขับขี่2 วันเกิด  */  
        wf_ddicno                 /*ผู้ขับขี่2 เลขที่บัตรประชาชน */ 
        wf_dddriveno              /*ผู้ขับขี่2 เลขที่ใบขับขี่    */ 
        wf_drivexp2               /*ผู้ขับขี่2 วันหมดอายุใบขับขี่*/ 
        wf_drivcon2               /*ความยินยอมขับขี่2            */ 
        wf_dlevel2                /*ผู้ขับขี่2 ระดับพฤติกรรมการขับขี่*/ 
        wf_dgender2               /*ผู้ขับขี่2 เพศ*/                 
        wf_drelation2             /*ผู้ขับขี่2 ความสัมพันธ์กับผู้เอาประกั  */
        wf_ntitle3                /*ผู้ขับขี่3 คำนำหน้า */  
        wf_dname3                 /*ผู้ขับขี่3 ชื่อ     */  
        wf_dcname3                /*ผู้ขับขี่3 ชื่อกลาง */  
        wf_dlname3                /*ผู้ขับขี่3 นามสกุล  */  
        wf_doccup3                /*ผู้ขับขี่3 อาชีพ    */  
        wf_dbirth3                /*ผู้ขับขี่3 วันเกิด  */  
        wf_dicno3                 /*ผู้ขับขี่3 เลขที่บัตรประชาชน  */
        wf_ddriveno3              /*ผู้ขับขี่3 เลขที่ใบขับขี่     */
        wf_drivexp3               /*ผู้ขับขี่3 วันหมดอายุใบขับขี่ */
        wf_drivcon3               /*ความยินยอมมขับขี่3 */
        wf_dlevel3                /*ผู้ขับขี่3 ระดับพฤติกรรมการขับขี่*/ 
        wf_dgender3               /*ผู้ขับขี่3 เพศ*/                 
        wf_drelation3             /*ผู้ขับขี่3 ความสัมพันธ์กับผู้เอาประกั  */
        wf_ntitle4                /*ผู้ขับขี่4 คำนำหน้า  */ 
        wf_dname4                 /*ผู้ขับขี่4 ชื่อ      */ 
        wf_dcname4                /*ผู้ขับขี่4 ชื่อกลาง  */ 
        wf_dlname4                /*ผู้ขับขี่4 นามสกุล   */ 
        wf_doccup4                /*ผู้ขับขี่4 อาชีพ     */ 
        wf_dbirth4                /*ผู้ขับขี่4 วันเกิด   */ 
        wf_dicno4                 /*ผู้ขับขี่4 เลขที่บัตรประชาชน   */
        wf_ddriveno4              /*ผู้ขับขี่4 เลขที่ใบขับขี่      */
        wf_drivexp4               /*ผู้ขับขี่4 วันหมดอายุใบขับขี่  */
        wf_drivcon4               /*ความยินยอมขับขี่4              */
        wf_dlevel4                /*ผู้ขับขี่4 ระดับพฤติกรรมการขับขี่ */
        wf_dgender4               /*ผู้ขับขี่4 เพศ*/                  
        wf_drelation4             /*ผู้ขับขี่4 ความสัมพันธ์กับผู้เอาประกั  */
        wf_ntitle5                /*ผู้ขับขี่5 คำนำหน้า  */ 
        wf_dname5                 /*ผู้ขับขี่5 ชื่อ      */ 
        wf_dcname5                /*ผู้ขับขี่5 ชื่อกลาง  */ 
        wf_dlname5                /*ผู้ขับขี่5 นามสกุล   */ 
        wf_doccup5                /*ผู้ขับขี่5 อาชีพ     */ 
        wf_dbirth5                /*ผู้ขับขี่5 วันเกิด   */ 
        wf_dicno5                 /*ผู้ขับขี่5 เลขที่บัตรประชาชน */ 
        wf_ddriveno5              /*ผู้ขับขี่5 เลขที่ใบขับขี่    */ 
        wf_drivexp5               /*ผู้ขับขี่5 วันหมดอายุใบขับขี่*/ 
        wf_drivcon5               /*ความยินยอมขับขี่5 */             
        wf_dlevel5                /*ผู้ขับขี่5 ระดับพฤติกรรมการขับขี่*/ 
        wf_dgender5               /*ผู้ขับขี่5 เพศ*/                 
        wf_drelation5             /*ผู้ขับขี่5 ความสัมพันธ์กับผู้เอาประกั  */
        wf_benname                /*ผู้รับผลประโยชน์ */  
        wf_comper                 /*ความเสียหายต่อชีวิต(บาท/คน) */  
        wf_comacc                 /*ความเสียหายต่อชีวิต(บาท/ครั้ง)   */ 
        wf_deductpd               /*ความเสียหายต่อทรัพย์สิน */  
        wf_tp2                    /*ความเสียหายส่วนแรกบุคคล */  
        wf_deductda               /*ความเสียหายต่อต่อรถยนต์ */  
        wf_deduct                 /*ความเสียหายส่วนแรกรถยนต์*/  
        wf_tpfire                 /*รถยนต์สูญหาย/ไฟไหม้     */  
        wf_NO_41                  /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่  */
        wf_ac2                    /*จำนวนผู้โดยสาร*/           
        wf_NO_42                  /*เสียชีวิตผู้โดยสารต่อครั้ง */ 
        wf_ac4                    /*ทุพพลภาพชั่วคราวผู้ขับขี่  */ 
        wf_ac5                    /*ทุพพลภาพชั่วคราวจน.ผู้โดยสาร  */ 
        wf_ac6                    /*ทุพพลภาพชั่วคราวผู้โดยสารต่อครั้ง  */
        wf_ac7                    /*ค่ารักษาพยาบาล*/        
        wf_NO_43                  /*การประกันตัวผู้ขับขี่   */  
        wf_comrequest             /*รหัสบริษัทผู้แจ้งประกัน */  
        wf_brrequest              /*สาขาบริษัทผู้แจ้งประกัน */  
        wf_salename               /*ชื่อผู้ติดต่อ / Salesman*/  
        wf_comcar                 /*บริษัทที่ปล่อยรถ        */  
        wf_brcar                  /*สาขาบริษัทที่ปล่อยรถ    */  
        wf_agcaryear              /*อายุรถ */
        wf_ac_date                /*วันที่ */
        wf_ac_amount              /*จำนวนเงิน */
        wf_ac_pay                 /*ชำระโดย*/
        wf_ac_agent               /*เลขที่บัตรนายหน้า */
        wf_detailcam              /*รายละเอียดเคมเปญ  */
        wf_ins_pay                /*รับประกันจ่ายแน่ๆ */
        wf_n_month                /*ผ่อนชำระ/เดือน*/  
        wf_n_bank                 /*บัตรเครดิตธนาคาร  */
        wf_TYPE_notify            /*ประเภทการแจ้งงาน  */
        wf_price_acc              /*รวมราคาอุปกรณ์เสริม    */
        wf_accdata                /*รายละเอียดอุปกรณ์เสริม */
        wf_chargflg               /*Wall Charger Y/N       */
        wf_chargprice             /*Wall Charger Price     */
        wf_chargno                /*Wall Charger Serialnumber  */
        wf_chargprm               /*Wall Charger อัตราค่าเบี้ย */
        wf_battflg                /*Battery Replacement Y/N*/
        wf_battprice              /*Battery Price */       
        wf_battno                 /*Battery Serialnumber */ 
        wf_battprm                /*Battery อัตราค่าเบี้ย*/ 
        wf_battdate               /*Battery Date  */     
        wf_brand_gals             /*ยี่ห้อเคลือบแก้ว */ 
        wf_brand_galsprm          /*ราคาเคลือบแก้ว*/ 
        wf_voicnam                /*ภาษี1 Code    */ 
        wf_companyre1             /*ภาษี1 ชื่อบริษัท */ 
        wf_companybr1             /*ภาษี1 สาขา    */ 
        wf_addr_re1               /*ภาษี1 ที่อยู่ */ 
        wf_idno_re1               /*ภาษี1 เลขที่ผู้เสียภาษี*/
        wf_net_re1                /*ภาษี1 เบี้ยสุทธิ */ 
        wf_stam_re1               /*ภาษี1 อากร    */ 
        wf_vat_re1                /*ภาษี1 ภาษี    */ 
        wf_premt_re1              /*ภาษี1 เบี้ยรวมอากรและภาษี */
        wf_inscode_re2            /*ภาษี2 Code    */          
        wf_companyre2             /*ภาษี2 ชื่อบริษัท */       
        wf_companybr2             /*ภาษี2 สาขา    */          
        wf_addr_re2               /*ภาษี2 ที่อยู่ */          
        wf_idno_re2               /*ภาษี2 เลขที่ผู้เสียภาษี*/
        wf_net_re2                /*ภาษี2 เบี้ยสุทธิ */    
        wf_stam_re2               /*ภาษี2 อากร */       
        wf_vat_re2                /*ภาษี2 ภาษี */       
        wf_premt_re2              /*ภาษี2 เบี้ยรวมอากรและภาษี */
        wf_inscode_re3            /*ภาษี3 Code */       
        wf_companyre3             /*ภาษี3 ชื่อบริษัท  */   
        wf_companybr3             /*ภาษี3 สาขา */       
        wf_addr_re3               /*ภาษี3 ที่อยู่ */       
        wf_idno_re3               /*ภาษี3 เลขที่ผู้เสียภาษี*/
        wf_net_re3                /*ภาษี3 เบี้ยสุทธิ  */   
        wf_stam_re3               /*ภาษี3 อากร */       
        wf_vat_re3                /*ภาษี3 ภาษี */  
        wf_premt_re3              /*ภาษี3 เบี้ยรวมอากรและภาษี */
        wf_camp_no                /*เลขที่แคมเปญ  */  
        wf_payment_type           /*ประเภทการชำระเบี้ย*/
        wf_nmember                /*หมายเหตุ*/  
        wf_producer               /*Producer*/  
        wf_remark1                /*Remark1 */  
        wf_remark2                /*Remark2 */  
        wf_remark3                /*Remark3 */  
        wf_remark4                /*Remark4 */  
        wf_31rate                 /*Rate ร.ย.31*/
        wf_31premt    .          /*เบี้ย ร.ย.31 */
    IF            TRIM(wf_policyno) = ""           THEN RUN proc_initdataex.
    ELSE IF index(TRIM(wf_policyno),"TEXT")   <> 0 THEN RUN proc_initdataex.
    ELSE IF index(TRIM(wf_policyno),"เลขที่") <> 0 THEN RUN proc_initdataex.
    ELSE IF INDEX(TRIM(wf_policyno),"จำนวน")  <> 0 THEN RUN proc_initdataex.  /*--A58-0419--*/
    ELSE DO:
        ASSIGN wf_garage  = IF trim(wf_garage) = "ซ่อมห้าง"  THEN "HONDA"  ELSE IF trim(wf_garage) = "ซ่อมอู่"  THEN "GARAGE" ELSE TRIM(wf_garage) 
               wf_saletyp = IF     trim(wf_saletyp) = "Normal"   THEN "N" 
                           ELSE IF trim(wf_saletyp) = "Campaign" THEN "C" 
                           ELSE IF trim(wf_saletyp) = "Staff"    THEN "S" 
                           ELSE IF trim(wf_saletyp) = "HATC"     THEN "H" 
                           ELSE TRIM(wf_saletyp)
               wf_covhct  = IF     INDEX(wf_covhct,"2+") <> 0 AND deci(wf_deductpd) = 2000 THEN "2.1"
                           ELSE IF INDEX(wf_covhct,"2+") <> 0 AND deci(wf_deductpd) = 0    THEN "2.2"
                           ELSE IF INDEX(wf_covhct,"3+") <> 0 AND deci(wf_deductpd) = 2000 THEN "3.1" 
                           ELSE IF INDEX(wf_covhct,"3+") <> 0 AND deci(wf_deductpd) = 0    THEN "3.2" 
                           ELSE IF INDEX(wf_covhct,"1") <> 0  THEN "1"
                           ELSE IF INDEX(wf_covhct,"2") <> 0  THEN "2" 
                           ELSE IF INDEX(wf_covhct,"3") <> 0  THEN "3" ELSE "0"
              wf_TYPE_notify = IF      trim(wf_TYPE_notify) = "New"    THEN "N" 
                               ELSE IF trim(wf_TYPE_notify) = "Renew"  THEN "R" 
                               ELSE IF TRIM(wf_type_notify) = "Switch" THEN "S" 
                               ELSE TRIM(wf_type_notify) 
              wf_vehuse  = IF INDEX(wf_carno,"11") <> 0 THEN "1" ELSE "2" ELSE wf_vehuse
              wf_flagno  = IF trim(wf_drivername1) <> ""  THEN "0" ELSE "1" . 
              
        IF Trim(wf_covcod) =  "T" THEN RUN proc_assigninit72.
                                  ELSE RUN proc_assigninit70.
        RUN proc_initdataex.
    END.
    
END.         /* repeat   */
INPUT CLOSE.   /*close Import*/


RUN proc_assign2.*/ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_vehrenew C-Win 
PROCEDURE proc_assign_vehrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nvvehreg  AS CHAR INIT "" FORMAT "x(12)".
DEF VAR nvvehreg1 AS CHAR INIT "" FORMAT "x(12)".
/*Comment by Kridtiya i. A53-0371 ....DATE. 18/11/2010
/*1*/   IF wdetail.re_country = "กระบี่"        THEN wdetail.re_country = "กบ".
/*2*/   else if wdetail.re_country = "กรุงเทพมหานคร" THEN wdetail.re_country = "กท".
/*3*/   else if wdetail.re_country = "กาญจนบุรี"     THEN wdetail.re_country = "กจ".
/*4*/   else if wdetail.re_country = "กาฬสินธุ์"     THEN wdetail.re_country = "กส".
/*5*/   else if wdetail.re_country = "กำแพงเพชร"     THEN wdetail.re_country = "กพ".
/*6*/   else if wdetail.re_country = "ขอนแก่น"       THEN wdetail.re_country = "ขก".
/*7*/   else if wdetail.re_country = "จันทบุรี"      THEN wdetail.re_country = "จท".
/*8*/   else if wdetail.re_country = "ฉะเชิงเทรา"    THEN wdetail.re_country = "ฉท".
/*9*/   else if wdetail.re_country = "ชลบุรี"        THEN wdetail.re_country = "ชบ".
/*10*/  else if wdetail.re_country = "ชัยนาท"        THEN wdetail.re_country = "ชน".
/*11*/  else if wdetail.re_country = "ชัยภูมิ"       THEN wdetail.re_country = "ชย".
/*12*/  else if wdetail.re_country = "ชุมพร"         THEN wdetail.re_country = "ชพ".
/*13*/  else if wdetail.re_country = "เชียงราย"      THEN wdetail.re_country = "ชร".
/*14*/  else if wdetail.re_country = "เชียงใหม่"     THEN wdetail.re_country = "ชม".
/*15*/  else if wdetail.re_country = "ตรัง"          THEN wdetail.re_country = "ตง".
/*16*/  else if wdetail.re_country = "ตราด"          THEN wdetail.re_country = "ตร".
/*17*/  else if wdetail.re_country = "ตาก"           THEN wdetail.re_country = "ตก".
/*18*/  else if wdetail.re_country = "นครนายก"       THEN wdetail.re_country = "นย".
/*19*/  else if wdetail.re_country = "นครปฐม"        THEN wdetail.re_country = "นฐ".
/*20*/  else if wdetail.re_country = "นครพนม"        THEN wdetail.re_country = "นพ".
/*21*/  else if wdetail.re_country = "นครราชสีมา"    THEN wdetail.re_country = "นม".
/*22*/  else if wdetail.re_country = "นครศรีธรรมราช" THEN wdetail.re_country = "นศ".
/*23*/  else if wdetail.re_country = "นครสวรรค์"     THEN wdetail.re_country = "นว".
/*24*/  else if wdetail.re_country = "นนทบุรี"       THEN wdetail.re_country = "นบ".
/*25*/  else if wdetail.re_country = "นราธวาส"       THEN wdetail.re_country = "นธ".
/*26*/  else if wdetail.re_country = "น่าน"          THEN wdetail.re_country = "นน".
/*27*/  else if wdetail.re_country = "บุรีรัมย์"     THEN wdetail.re_country = "บร".
/*28*/  else if wdetail.re_country = "ปทุมธานี"      THEN wdetail.re_country = "ปท".
/*29*/  else if wdetail.re_country = "ประจวบคีรีขันธ์" THEN wdetail.re_country = "ปข".
/*30*/  else if wdetail.re_country = "ปราจีนบุรี"   THEN wdetail.re_country = "ปจ".
/*31*/  else if wdetail.re_country = "ปัตตานี"      THEN wdetail.re_country = "ปน".
/*32*/  else if wdetail.re_country = "พระนครศรีอยุธยา" OR wdetail.re_country = "อยุธยา" THEN wdetail.re_country = "อย".
/*33*/  else if wdetail.re_country = "พะเยา"      THEN wdetail.re_country = "พย".
/*34*/  else if wdetail.re_country = "พังงา"      THEN wdetail.re_country = "พง".
/*35*/  else if wdetail.re_country = "พัทลุง"     THEN wdetail.re_country = "พท".
/*36*/  else if wdetail.re_country = "พิจิตร"     THEN wdetail.re_country = "พจ".
/*37*/  else if wdetail.re_country = "พิษณุโลก"   THEN wdetail.re_country = "พล".
/*38*/  else if wdetail.re_country = "เพชรบุรี"   THEN wdetail.re_country = "พบ".
/*39*/  else if wdetail.re_country = "เพชรบูรณ์"  THEN wdetail.re_country = "พช".
/*40*/  else if wdetail.re_country = "แพร่"       THEN wdetail.re_country = "พร".
/*41*/  else if wdetail.re_country = "ภูเก็ต"     THEN wdetail.re_country = "ภก".
/*42*/  else if wdetail.re_country = "มหาสารคาม"  THEN wdetail.re_country = "มค".
/*43*/  else if wdetail.re_country = "มุกดาหาร"   THEN wdetail.re_country = "มห".
/*44*/  else if wdetail.re_country = "แม่ฮ่องสอน" THEN wdetail.re_country = "มส".
/*45*/  else if wdetail.re_country = "ยะลา"       THEN wdetail.re_country = "ยล".
/*46*/  else if wdetail.re_country = "ร้อยเอ็ด"   THEN wdetail.re_country = "รอ".
/*47*/  else if wdetail.re_country = "ระนอง"      THEN wdetail.re_country = "รน".
/*48*/  else if wdetail.re_country = "ระยอง"      THEN wdetail.re_country = "รย".
/*49*/  else if wdetail.re_country = "ราชบุรี"    THEN wdetail.re_country = "รบ".
/*50*/  else if wdetail.re_country = "ลพบุรี"     THEN wdetail.re_country = "ลบ".
/*51*/  else if wdetail.re_country = "ลำปาง"      THEN wdetail.re_country = "ลป".
/*52*/  else if wdetail.re_country = "ลำพูน"      THEN wdetail.re_country = "ลพ".
/*53*/  else if wdetail.re_country = "เลย"        THEN wdetail.re_country = "ลย".
/*54*/  else if wdetail.re_country = "ศรีสะเกษ"   THEN wdetail.re_country = "ศก".
/*55*/  else if wdetail.re_country = "สกลนคร"     THEN wdetail.re_country = "สน".
/*56*/  else if wdetail.re_country = "สงขลา"      THEN wdetail.re_country = "สข".
/*57*/  else if wdetail.re_country = "สระแก้ว"    THEN wdetail.re_country = "สก".
/*58*/  else if wdetail.re_country = "สระบุรี"    THEN wdetail.re_country = "สบ".
/*59*/  else if wdetail.re_country = "สิงห์บุรี"  THEN wdetail.re_country = "สห".
/*60*/  else if wdetail.re_country = "สุโขทัย"    THEN wdetail.re_country = "สท".
/*61*/  else if wdetail.re_country = "สุพรรณบุรี" THEN wdetail.re_country = "สพ".
/*62*/  else if wdetail.re_country = "สุราษฎร์ธานี" THEN wdetail.re_country = "สฎ".
/*63*/  else if wdetail.re_country = "สุรินทร์"    THEN wdetail.re_country = "สร".
/*64*/  else if wdetail.re_country = "หนองคาย"     THEN wdetail.re_country = "นค".
/*65*/  else if wdetail.re_country = "หนองบัวลำพู" THEN wdetail.re_country = "นล".
/*66*/  else if wdetail.re_country = "อ่างทอง"     THEN wdetail.re_country = "อท".
/*67*/  else if wdetail.re_country = "อำนาจเจริญ"  THEN wdetail.re_country = "อจ".
/*68*/  else if wdetail.re_country = "อุดรธานี"    THEN wdetail.re_country = "อด".
/*69*/  else if wdetail.re_country = "อุตรดิตถ์"   THEN wdetail.re_country = "อต".
/*70*/  else if wdetail.re_country = "อุทัยธานี"   THEN wdetail.re_country = "อท".
/*71*/  else if wdetail.re_country = "อุบลราชธานี" THEN wdetail.re_country = "อบ".
/*72*/  else if wdetail.re_country = "ยโสธร"       THEN wdetail.re_country = "ยส".
/*73*/  else if wdetail.re_country = "สตูล"        THEN wdetail.re_country = "สต".
/*74*/  else if wdetail.re_country = "สุมทรปราการ" THEN wdetail.re_country = "สป".
/*75*/  else if wdetail.re_country = "สุมทรสงคราม" THEN wdetail.re_country = "สส".
/*76*/  else if wdetail.re_country = "สุมทรสาคร"   THEN wdetail.re_country = "สค".
 wdetail.vehreg  = wdetail.vehreg + " " + wdetail.re_country .   
 END...Kridtiya i. A53-0371 ....DATE. 18/11/2010*/
/*Add ...Kridtiya i. A53-0371 ....DATE. 18/11/2010*/
ASSIGN 
    nvvehreg = ""
    nvvehreg1 = "" 
    nvvehreg = trim(wdetail.vehreg).
IF nvvehreg <> "" AND substr(nvvehreg,1,1) <> "/" AND (INDEX(nvvehreg," ") = 0 ) THEN DO:
    /*"1กก123".*/
    IF index("0123456789",substr(nvvehreg,1,1)) <> 0 THEN DO: 
        /* 11 123*/
        IF      index("0123456789",substr(nvvehreg,2,1)) <> 0 THEN  
            nvvehreg1 = trim(substr(nvvehreg,1,2)) + " " + trim(substr(nvvehreg,3)) .  
        ELSE DO:  
            /* 1ก123 */
            IF index("0123456789",substr(nvvehreg,3,1)) <> 0 THEN DO:
                nvvehreg1 = trim(substr(nvvehreg,1,2)) + " " + trim(substr(nvvehreg,3)) . 
            END.
            ELSE DO: /* 1กก123 */
                nvvehreg1 = trim(substr(nvvehreg,1,3))  + " " + trim(substr(nvvehreg,4)) . 
            END.
        END.
    END.
    ELSE DO: 
        IF      index("0123456789",substr(nvvehreg,2,1)) <> 0 THEN  
             nvvehreg1 =  trim(substr(nvvehreg,1,1))  + " " + trim(substr(nvvehreg,2)) .
        ELSE nvvehreg1 =  trim(substr(nvvehreg,1,2))  + " " + trim(substr(nvvehreg,3)) .  
    END.
    IF nvvehreg1 <> "" THEN ASSIGN wdetail.vehreg = trim(nvvehreg1).
END.
FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
    brstat.insure.compno = "999" AND
    brstat.insure.FName = TRIM(wdetail.re_country) NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL brstat.insure THEN 
    /*/*A54-0112*/
    ASSIGN wdetail.re_country = Insure.LName
    wdetail.vehreg = substr(wdetail.vehreg,1,7) + " " + wdetail.re_country .
ELSE wdetail.vehreg = substr(wdetail.vehreg,1,7).*//*A54-0112*/
    /*A54-0112*/
    ASSIGN wdetail.re_country = Insure.LName
    wdetail.vehreg = trim(substr(wdetail.vehreg,1,8)) + " " + wdetail.re_country .
ELSE wdetail.vehreg = trim(substr(wdetail.vehreg,1,8)).  
     /*A54-0112*/
/*end...Kridtiya i. A53-0371 ....DATE. 18/11/2010*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2 C-Win 
PROCEDURE proc_base2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by ranu I. A64-0328      
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR model   AS CHAR FORMAT "x(30)".
DEF VAR aa      AS DECI.
ASSIGN fi_process = "Check Base data HCT...." + wdetail.policyno .
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "015-2:" TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
IF wdetail2.poltyp = "v70" THEN DO:
    /* comment by : A68-0061...
    IF wdetail2.subclass = "110" THEN DO:
        /*IF wdetail.prepol <> "" THEN  aa = nv_basere.*/ /*A64-0328*/
        IF wdetail.prepol <> "" AND nv_basere <> 0 THEN  aa = nv_basere. /*A64-0328*/
        ELSE IF wdetail.model = "city" OR 
                wdetail.model = "jazz"   THEN aa = 8500.
        ELSE IF wdetail.model = "civic"  THEN aa = 7600.
        ELSE IF wdetail.model = "freed"  THEN aa = 7600.
        ELSE IF wdetail.model = "accord" THEN aa = 7600.
        ELSE IF wdetail.model = "CR-V"   THEN aa = 7600.  
        ELSE IF wdetail.model = "FREED"  THEN aa = 7600. 
        ELSE IF wdetail.model = "brio"   THEN aa = 7600. /*add kridtiya i. A530260 */
        ELSE IF wdetail.model = "Mobilio" THEN aa = 7600.  /*A61-0324*/
        ELSE IF wdetail.model = "HR-V" THEN aa = 7600.     /*A61-0324*/
        ELSE IF wdetail.model = "BR-V" THEN aa = 7600.     /*A61-0324*/
        ELSE DO: 
            RUN wgs\wgsfbas.
            ASSIGN aa = nv_baseprm.
        END.
    END.
    ELSE IF wdetail2.subclass = "120" THEN DO:
        /*IF wdetail.prepol <> "" THEN  aa = nv_basere.*/ /*A64-0328*/
        IF wdetail.prepol <> "" AND nv_basere <> 0 THEN  aa = nv_basere. /*A64-0328*/
        ELSE IF wdetail.model = "city" OR wdetail.model = "jazz"  THEN aa = 9000.
        ELSE IF wdetail.model = "civic"  THEN aa = 7600.
        ELSE IF wdetail.model = "freed"  THEN aa = 7600.
        ELSE IF wdetail.model = "accord" THEN aa = 7600.
        ELSE IF wdetail.model = "CR-V"   THEN aa = 7600.
        ELSE IF wdetail.model = "FREED"  THEN aa = 7600.  /*add kridtiya i. A530260 */
        ELSE DO: 
            RUN wgs\wgsfbas.
            ASSIGN aa = nv_baseprm.
        END.
    END.
    
    /*IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") THEN DO: */ /*A62-0215*/
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2")  THEN DO:  /*A62-0215*/
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ...end A68-0061...*/

    IF aa = 0 THEN DO:
        /*IF wdetail.prepol <> "" THEN  aa = nv_basere.*/ /*A64-0328*/
        IF wdetail.prepol <> "" AND nv_basere <> 0 THEN  aa = nv_basere. /*A64-0328*/
        ELSE DO: 
            RUN wgs\wgsfbas.
            ASSIGN aa = nv_baseprm.
        END.
    END.
    
    ASSIGN
        chk = NO
        NO_basemsg = " "
        nv_baseprm = aa
        nv_dss_per = IF wdetail.prepol <> " " THEN nv_dss_per ELSE  IF nv_cctvcode = "0001" THEN 5 ELSE 0.
   /* comment by : A68-0061...
    /*-----nv_drivcod---------------------*/
    nv_drivvar1 = wdetail.drivername1.
    nv_drivvar2 = wdetail.drivername2.

    IF wdetail2.drivnam = "N" THEN  nv_drivno = 0.
    ELSE DO:
        IF wdetail.drivername1 <> ""  THEN  wdetail2.drivnam  = "y".
        ELSE wdetail2.drivnam  = "N".
        IF wdetail.drivername2 <> ""   THEN  nv_drivno = 2. 
        ELSE IF wdetail.drivername1 <> "" AND wdetail.drivername2 = "" THEN  nv_drivno = 1.  
        ELSE IF wdetail.drivername1  = "" AND wdetail.drivername2 = "" THEN  nv_drivno = 0.   
    END.

    nv_drivvar  = "" .
    If wdetail2.drivnam  = "N"  Then 
        Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN wdetail2.pass    = "N"
                wdetail2.comment = wdetail2.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        Assign  
        nv_drivvar     = nv_drivcod
        nv_drivvar1    = "     Driver name person = "
        nv_drivvar2    = String(nv_drivno)
        Substr(nv_drivvar,1,30)  = nv_drivvar1
        Substr(nv_drivvar,31,30) = nv_drivvar2.
    
    END.
    
    /*-------nv_baseprm----------*/
    IF NO_basemsg <> " " THEN  wdetail2.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail2.pass    = "N"
        wdetail2.comment = wdetail2.comment + "| Base Premium is Mandatory field. ".  

    ASSIGN nv_basevar = " "
        nv_prem1 = nv_baseprm
        nv_basecod  = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/

   ASSIGN nv_41     =  deci(WDETAIL2.no_41) 
          nv_42     =  deci(WDETAIL2.no_42)
          nv_43     =  deci(WDETAIL2.no_43)
          nv_seat41 = integer(wdetail2.seat41).
   
    Assign  nv_411var = ""   nv_412var = ""                                                  
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
    ASSIGN nv_42var    = " "  
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
    /*------nv_usecod------------*/
    ASSIGN nv_usevar = ""
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30) = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  wdetail2.subclass.       
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
    Assign  nv_sivar   = "" 
         nv_totsi     = 0
         nv_sicod     = "SI"
         nv_sivar1    = "     Own Damage = "
         nv_sivar2    =  wdetail.si
         SUBSTRING(nv_sivar,1,30)  = nv_sivar1
         SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
         nv_totsi     =  DECI(wdetail.si).
    /*----------nv_grpcod--------------------*/
    ASSIGN nv_grpvar  = "" 
     nv_grpcod      = "GRP" + wdetail.cargrp
     nv_grpvar1     = "     Vehicle Group = "
     nv_grpvar2     = wdetail.cargrp
     Substr(nv_grpvar,1,30)  = nv_grpvar1
     Substr(nv_grpvar,31,30) = nv_grpvar2.
    /*-------------nv_bipcod--------------------*/
    ASSIGN nv_bipvar  = ""
     nv_bipcod      = "BI1"
     nv_bipvar1     = "     BI per Person = "
     nv_bipvar2     = STRING(uwm130.uom1_v)
     SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
     SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    Assign nv_biavar  = ""
     nv_biacod      = "BI2"
     nv_biavar1     = "     BI per Accident = "
     nv_biavar2     = STRING(uwm130.uom2_v)
     SUBSTRING(nv_biavar,1,30)  = nv_biavar1
     SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*-------------nv_pdacod--------------------*/
    ASSIGN nv_pdavar  = ""
     nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         /*nv_pdavar2     = STRING(uwm130.uom5_v)   a52-0172*/
         nv_pdavar2     = string(deci(WDETAIL.deductpd))        /*A52-0172*/
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     ...end A68-0061..*/

     /*--------------- deduct ----------------*/
     /* caculate deduct OD  */
    ASSIGN dod1  = 0
           dod2  = 0
           dpd0  = 0 .
    IF deci(wdetail.deduct) <> 0 THEN DO:
        IF deci(wdetail.deduct) > 3000 THEN DO:
            ASSIGN dod1  = 3000
                   dod2  = deci(wdetail.deduct) - 3000
                   dpd0  = 0 .
        END.
        ELSE DO:
             ASSIGN dod1  = deci(wdetail.deduct)
                    dod2   = 0
                    dpd0   = 0 .
        END.
    END.
    ELSE DO:
     IF wdetail.prepol <> " "  THEN DO:
         ASSIGN
         dod1 = n_deductDOD  
         dod2 = n_deductDOD2 
         dpd0 = n_deductDPD  .
     END.
     ELSE DO:
         ASSIGN 
         dod1  = 0  
         dod2  = 0  
         dpd0  = 0 .
     END.
    END.
    /*IF (wdetail.covcod = "2.1") /*OR (wdetail.covcod = "3.1")*/ THEN ASSIGN dod1 = 2000.  /*A57-0126*/*/ /*A67-0065*/
    /* comment by : A68-0061...
     ASSIGN
         nv_odcod    = "DC01"
         nv_prem     =  dod1
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
             wdetail2.pass    = "N"
             wdetail2.comment = wdetail2.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
     END.

     nv_dedod1var = "" .
     IF dod1 <> 0  THEN
        ASSIGN nv_dedod1var  = ""
            nv_ded1prm        = nv_prem
            nv_dedod1_prm     = nv_prem
            nv_dedod1_cod     = "DOD"
            nv_dedod1var1     = "     Deduct OD = "
            nv_dedod1var2     = STRING(dod1)
            SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
            SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
     /*add od*/
     
     nv_dedod2var   = " ".
     IF dod2 <> 0 THEN 
        Assign
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   =  STRING(dod2)
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2 .
     /***** pd *******/
     nv_dedpdvar  = " ".
     IF dpd0 <> 0  THEN
        ASSIGN
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(dpd0)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
            
     /*---------- fleet -------------------*/
     ASSIGN  nv_fletvar = " "
             nv_flet_per = INTE(wdetail2.fleet).
     IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
         Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
         ASSIGN
             wdetail2.pass    = "N"
             wdetail2.comment = wdetail2.comment + "| Fleet Percent must be 0 or 10. ".
     End.
     IF nv_flet_per = 0 Then do:
         ASSIGN nv_flet     = 0
             nv_fletvar  = " ".
     End.
     
     IF nv_flet_per <> 0  THEN
         ASSIGN 
         nv_fletvar1    = "     Fleet % = "
         nv_fletvar2    =  STRING(nv_flet_per)
         SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
         SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     NV_NCBPER = INTE(WDETAIL.NCB).
     IF (wdetail.covcod = "2.1" )  THEN  DO:
         ASSIGN  wdetail.ncb = "20"
         nv_ncb  = 20
         NV_NCBPER = 20.
     END.
     nv_ncbvar = " ".
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401 Where
             sicsyac.xmm104.tariff = nv_tariff           AND
             sicsyac.xmm104.class  = nv_class            AND 
             sicsyac.xmm104.covcod = nv_covcod           AND 
             sicsyac.xmm104.ncbper   = INTE(wdetail.ncb) No-lock no-error no-wait.
         IF not avail  sicsyac.xmm104  Then do:
             Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
             ASSIGN wdetail2.pass    = "N"
                 wdetail2.comment = wdetail2.comment + "| This NCB Step not on NCB Rates file xmm104. ".
         END.
         ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                     nv_ncbyrs = xmm104.ncbyrs.
     END.
     Else do:  
         ASSIGN nv_ncbyrs =   0
             nv_ncbper    =   0
             nv_ncb       =   0.
     END.
    
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     
     /*------------------ dsspc ---------------*/
     nv_dsspcvar   = " ".
     IF  nv_dss_per   <> 0  THEN
          Assign
          nv_dsspcvar1   = "     Discount Special % = "
          nv_dsspcvar2   =  STRING(nv_dss_per)
          SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
          SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
     ....end A68-0061...*/
    
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2plus C-Win 
PROCEDURE proc_base2plus :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by ranu I. A64-0328      
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR model   AS CHAR FORMAT "x(30)".
DEF VAR aa      AS DECI.
ASSIGN fi_process = "Check Base Plus+ data HCT 2+3+...." + wdetail.policyno .
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "015-1:" TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
IF wdetail2.poltyp = "v70" THEN DO:
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN DO: 
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    IF aa = 0 THEN DO:
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ASSIGN
        chk = NO
        NO_basemsg  = " "
        nv_baseprm  = aa
        /* comment by : A68-0061..
        nv_drivvar1 = wdetail.drivername1   /*-----nv_drivcod---------------------*/
        nv_drivvar2 = wdetail.drivername2*/
        nv_dss_per = IF wdetail.prepol <> " " THEN nv_dss_per ELSE  IF nv_cctvcode = "0001" THEN 5 ELSE 0.
    /* comment by : A68-0061...
    IF wdetail2.drivnam = "n" THEN  nv_drivno = 0.
    ELSE DO:
        IF      wdetail.drivername1 <> ""   THEN  wdetail2.drivnam  = "y".
        ELSE    wdetail2.drivnam     = "N".
        IF      wdetail.drivername2 <> ""   THEN  nv_drivno = 2. 
        ELSE IF wdetail.drivername1 <> "" AND wdetail.drivername2 = "" THEN  nv_drivno = 1.  
        ELSE IF wdetail.drivername1  = "" AND wdetail.drivername2 = "" THEN  nv_drivno = 0.   
    END.
    nv_drivvar = "" .
    If wdetail2.drivnam  = "N"  Then 
        Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN wdetail2.pass    = "N"
                    wdetail2.comment = wdetail2.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        Assign
            nv_drivvar     = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.
    
    /*-------nv_baseprm----------*/
    nv_basevar = "" .
    IF NO_basemsg <> " " THEN  wdetail2.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail2.pass    = "N"
                wdetail2.comment = wdetail2.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN nv_prem1 = nv_baseprm
        nv_basecod  = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    ASSIGN 
        nv_41  =  deci(WDETAIL2.no_41) 
        nv_42  =  deci(WDETAIL2.no_42)
        nv_43  =  deci(WDETAIL2.no_43)
        nv_seat41 = integer(wdetail2.seat41).
    
    Assign  nv_411var = ""  nv_412var = ""                                                    
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
        nv_412prm  = nv_41 
        nv_42var    = " "     /* -------fi_42---------*/
        nv_42cod   = "42"
        nv_42var1  = "     Medical Expense = "
        nv_42var2  = STRING(nv_42)
        SUBSTRING(nv_42var,1,30)   = nv_42var1
        SUBSTRING(nv_42var,31,30)  = nv_42var2
        nv_43var    = " "     /*---------fi_43--------*/
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
    ASSIGN nv_sclass =  wdetail2.subclass.       
    /*-----nv_yrcod---------- 1. ------------------*/  
    ASSIGN nv_yrvar = ""
        nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
        nv_yrvar1  = "     Vehicle Year = "
        nv_yrvar2  =  wdetail.caryear
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
        Substr(nv_yrvar,1,30)    = nv_yrvar1
        Substr(nv_yrvar,31,30)   = nv_yrvar2.  
    /*-----nv_sicod----------------------------*/  
    Assign  nv_sivar = ""       nv_totsi = 0
        nv_sicod     = "SI"
        nv_sivar1    = "     Own Damage = "
        nv_sivar2    =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2"  THEN  wdetail.tpfire ELSE  wdetail.deductda        /*A62-0215*/
        wdetail.si   =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2"  THEN  wdetail.tpfire ELSE  wdetail.deductda        /*A62-0215*/
        SUBSTRING(nv_sivar,1,30)  = nv_sivar1
        SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
        nv_totsi     = IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2" THEN  deci(wdetail.tpfire)  ELSE DECI(wdetail.deductda).  /*A62-0215*/
    /*----------nv_grpcod--------------------*/
    ASSIGN  nv_grpvar  = ""
        nv_grpcod      = "GRP" + wdetail.cargrp
        nv_grpvar1     = "     Vehicle Group = "
        nv_grpvar2     = wdetail.cargrp
        Substr(nv_grpvar,1,30)  = nv_grpvar1
        Substr(nv_grpvar,31,30) = nv_grpvar2.
    /*-------------nv_bipcod--------------------*/
    ASSIGN  nv_bipvar  = ""
        nv_bipcod      = "BI1"
        nv_bipvar1     = "     BI per Person = "
        nv_bipvar2     = STRING(uwm130.uom1_v)
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    Assign  nv_biavar  = "" 
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     = STRING(uwm130.uom2_v)
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*-------------nv_pdacod--------------------*/
    IF (wdetail.covcod = "2.1") THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "21" .
    ELSE IF (wdetail.covcod = "2.2") THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "22" .  /*a62-0215*/
    ELSE IF (wdetail.covcod = "3.2") THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "32" .  /*a62-0215*/
    ELSE nv_usecod3 = "U" + TRIM(nv_vehuse) + "31" .
    ASSIGN  nv_usevar3 = ""  
            nv_usevar4 = "     Vehicle Use = "
            nv_usevar5 =  wdetail.vehuse
            Substring(nv_usevar3,1,30)   = nv_usevar4
            Substring(nv_usevar3,31,30)  = nv_usevar5.
    ASSIGN  nv_basecod3 = IF (wdetail.covcod = "2.1") THEN "BA21" 
                          ELSE IF (wdetail.covcod = "2.2") THEN "BA22"
                          ELSE IF (wdetail.covcod = "3.1") THEN "BA31" ELSE "BA32". 
    /* end A62-0215 */
     FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
         sicsyac.xmm106.tariff = nv_tariff   AND
         sicsyac.xmm106.bencod = nv_basecod3 AND
         sicsyac.xmm106.covcod = nv_covcod   AND
         sicsyac.xmm106.class  = nv_class    AND
         sicsyac.xmm106.key_b  GE nv_key_b   AND
         sicsyac.xmm106.effdat LE nv_comdat  NO-LOCK NO-ERROR NO-WAIT.
     IF AVAIL sicsyac.xmm106 THEN  nv_baseprm3 = xmm106.min_ap.
     ELSE  nv_baseprm3 = 0.

     ASSIGN  nv_basevar3 = "" 
         nv_basevar4 = "     Base Premium3 = "
         nv_basevar5 = STRING(nv_baseprm3)
         SUBSTRING(nv_basevar3,1,30)   = nv_basevar4
         SUBSTRING(nv_basevar3,31,30)  = nv_basevar5.  
     ASSIGN
        /*nv_sicod3    = IF (wdetail.covcod = "2.1") THEN "SI21"  ELSE "SI31"*/ /*A62-0215*/
        /* add by A62-0215 */
        nv_sivar3    = ""
        nv_sicod3    = IF (wdetail.covcod = "2.1") THEN "SI21"
                       ELSE IF (wdetail.covcod = "2.2") THEN "SI22" 
                       ELSE IF (wdetail.covcod = "3.1") THEN "SI31"  ELSE "SI32" 
        /* end A62-0215 */
        nv_sivar4    = "     Own Damage = "                                                                                              
        nv_sivar5    =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2" THEN  string(deci(wdetail.tpfire)) ELSE string(deci(wdetail.deductda)) /*A62-0215*/
        wdetail.si   =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2" THEN  wdetail.tpfire ELSE  wdetail.deductda                            /*A62-0215*/
        SUBSTRING(nv_sivar3,1,30)  = nv_sivar4
        SUBSTRING(nv_sivar3,31,30) = nv_sivar5 .
        nv_siprm3    = IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2" THEN  deci(wdetail.tpfire) ELSE DECI(wdetail.deductda) . /* a62-0215 */ 
    ASSIGN nv_pdavar = ""
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = " 
         nv_pdavar2     = string(deci(WDETAIL.deductpd))        
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     ....end A68-0061...*/    
     /*--------------- deduct ----------------*/
     /* caculate deduct OD  */
         /* caculate deduct OD  */
     ASSIGN dod1  = 0
            dod2  = 0
            dpd0  = 0 .
     IF deci(wdetail.deduct) <> 0 THEN DO:
         IF deci(wdetail.deduct) > 3000 THEN DO:
             ASSIGN dod1  = 3000
                    dod2  = deci(wdetail.deduct) - 3000
                    dpd0  = 0 .
         END.
         ELSE DO:
              ASSIGN dod1  = deci(wdetail.deduct)
                     dod2  = 0
                     dpd0  = 0 .
         END.
     END.
     ELSE DO:
      IF wdetail.prepol <> " "  THEN DO:
          ASSIGN
          dod1 = n_deductDOD  
          dod2 = n_deductDOD2 
          dpd0 = n_deductDPD  .
      END.
      ELSE DO:
          ASSIGN 
          dod1  = 0  
          dod2  = 0  
          dpd0  = 0 .
      END.
     END.
     IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1")  THEN ASSIGN dod1 = 2000 .   /*A57-0126*/
     /* comment by : A68-0061...
     nv_dedod1var      = "".
     IF dod1 <> 0 THEN DO:
        ASSIGN
            DOD2        = 0
            nv_odcod    = "DC01"
            nv_prem     =  dod1 
            nv_sivar2   =  "" . 
        RUN Wgs\Wgsmx024( nv_tariff,              
                          nv_odcod,
                          nv_class,
                          nv_key_b,
                          nv_comdat,
                          INPUT-OUTPUT nv_prem,
                          OUTPUT nv_chk ,
                          OUTPUT nv_baseap). 
        IF NOT nv_chk THEN DO:
            MESSAGE  " DEDUCTIBLE EXCEED THE LIMIT " nv_baseap nv_prem   View-as alert-box.
            ASSIGN
                wdetail2.pass    = "N"
                wdetail2.comment = wdetail2.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
        END.
        
        ASSIGN
            nv_dedod1var      = ""
            nv_dedod1_cod     = "DOD"
            nv_dedod1var1     = "     Deduct OD = "
            nv_dedod1var2     = STRING(dod1)
            SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
            SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2  .
     END.
     /*add od*/
     Assign  
         nv_dedod2var   = " "
         nv_cons  = "AD"
         nv_ded   = dod2.
     IF dod2 <> 0 THEN DO:
        Assign
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   =  STRING(dod2)
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2 .
     END.
     /***** pd *******/
     Assign
         nv_dedpdvar  = " "
         nv_cons  = "PD"
         nv_ded   = dpd0.
    IF dpd0 <> 0 THEN DO:
     ASSIGN
         nv_dedpd_cod   = "DPD"
         nv_dedpdvar1   = "     Deduct PD = "
         nv_dedpdvar2   =  STRING(dpd0)
         SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
         SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
    END.
    /*---------- fleet -------------------*/
     nv_flet_per = INTE(wdetail2.fleet).
     IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
         Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
         ASSIGN
             wdetail2.pass    = "N"
             wdetail2.comment = wdetail2.comment + "| Fleet Percent must be 0 or 10. ".
     End.
     IF nv_flet_per = 0 Then do:
         ASSIGN nv_flet     = 0
             nv_fletvar  = " ".
     End.
     nv_fletvar     = " ".
     IF nv_flet_per <> 0 THEN
        ASSIGN  
            nv_fletvar1    = "     Fleet % = "
            nv_fletvar2    =  STRING(nv_flet_per)
            SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
            SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     NV_NCBPER = INTE(WDETAIL.NCB).
     IF (wdetail.covcod = "2.1" ) THEN DO: 
         ASSIGN  
         wdetail.ncb = "20"
         nv_ncb  = 20
         NV_NCBPER = 20.
     END.
     
     nv_ncbvar = " ".
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401 Where
             sicsyac.xmm104.tariff = nv_tariff           AND
             sicsyac.xmm104.class  = nv_class            AND 
             sicsyac.xmm104.covcod = nv_covcod           AND 
             sicsyac.xmm104.ncbper   = INTE(wdetail.ncb) No-lock no-error no-wait.
         IF not avail  sicsyac.xmm104  Then do:
             Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
             ASSIGN 
                 wdetail2.pass    = "N"
                 wdetail2.comment = wdetail2.comment + "| This NCB Step not on NCB Rates file xmm104. ".
         END.
         ELSE ASSIGN nv_ncbper = sicsyac.xmm104.ncbper   
                     nv_ncbyrs = sicsyac.xmm104.ncbyrs.
     END.
     Else do:  
         ASSIGN nv_ncbyrs =   0
             nv_ncbper    =   0
             nv_ncb       =   0.
     END.
     
     nv_ncbvar   = " ".
     IF  nv_ncbper <> 0  THEN
        ASSIGN 
            nv_ncbvar1   = "     NCB % = "
            nv_ncbvar2   =  STRING(nv_ncbper)
            SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
            SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.

     /*------------------ dsspc ---------------*/
     nv_dsspcvar   = " ".
     IF  nv_dss_per   <> 0  THEN
       Assign
        nv_dsspcvar1   = "     Discount Special % = "
        nv_dsspcvar2   =  STRING(nv_dss_per)
        SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
        SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
   ...end A68-0061....*/
  
            
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_baseplus C-Win 
PROCEDURE proc_baseplus :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_baseprm3 = 0 
    NO_basemsg = " " .  
    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
           sicsyac.xmm106.tariff =  nv_tariff   AND
           sicsyac.xmm106.bencod =  nv_basecod3 AND
           sicsyac.xmm106.covcod =  nv_covcod   AND
           sicsyac.xmm106.class  =  nv_class    AND
           sicsyac.xmm106.key_b  GE nv_key_b    AND
           sicsyac.xmm106.effdat LE nv_comdat
        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm106 THEN DO:
       nv_baseprm3 = sicsyac.xmm106.min_ap.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt_all C-Win 
PROCEDURE proc_calpremt_all :
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
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "015-6:" TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
IF wdetail2.poltyp = "V70" THEN DO:
        ASSIGN fi_process = "Create data to base..." + wdetail.policy .
        DISP fi_process WITH FRAM fr_main.
        RUN proc_calpremt_init. /* เคลียร์และใส่ข้อมูล*/
         FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE clastab_fil.CLASS  = nv_class  AND clastab_fil.covcod = wdetail.covcod NO-LOCK NO-ERROR.
            IF AVAIL stat.clastab_fil THEN DO:
                IF clastab_fil.unit = "C" THEN DO:
                    ASSIGN nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" OR SUBSTR(nv_class,2,1) = "E" THEN "H" ELSE clastab_fil.unit
                           nv_engine = IF SUBSTR(nv_class,5,1) = "E" OR SUBSTR(nv_class,2,1) = "E" THEN DECI(wdetail2.watt) ELSE INT(wdetail.engcc).
                END.
                ELSE IF clastab_fil.unit = "S" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = INT(wdetail.seat).
                END.
                ELSE IF clastab_fil.unit = "T" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = DECI(sic_bran.uwm301.Tons).
                END.
                ELSE IF clastab_fil.unit = "H" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = DECI(wdetail2.watt). 
                END.
                nv_engcst = nv_engine .
            END.
        IF wdetail2.redbook = ""  THEN DO:
            IF nv_cstflg = "W" OR nv_cstflg = "H" THEN DO:
                 RUN wgw/wgwredbev(input  wdetail.brand ,      
                                   input  wdetail.model ,  
                                   input  INT(wdetail.si) ,  
                                   INPUT  wdetail2.tariff,  
                                   input  SUBSTR(nv_class,2,5),   
                                   input  wdetail.caryear, 
                                   input  nv_engine ,
                                   input  0 , 
                                   INPUT-OUTPUT wdetail.maksi,
                                   INPUT-OUTPUT wdetail2.redbook) .
            END.
            ELSE IF nv_cstflg <> "T" THEN DO:
                RUN wgw/wgwredbk1(input  wdetail.brand ,       /*A65=0079*/
                               input  wdetail.model ,  
                               input  nv_totsi      ,  
                               INPUT  wdetail2.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  wdetail.caryear, 
                               input  nv_engine  ,
                               input  0 , 
                               INPUT-OUTPUT wdetail2.redbook) .
            END.
            ELSE DO:
                 RUN wgw/wgwredbk1(input  wdetail.brand ,       /*A65=0079*/  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail2.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  wdetail.caryear, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT wdetail2.redbook) .
            END.
            IF wdetail2.redbook <> ""  THEN ASSIGN sic_bran.uwm301.modcod = wdetail2.redbook      sic_bran.uwm301.maksi  = deci(wdetail.maksi) .
            ELSE DO:
             ASSIGN wdetail2.comment = wdetail2.comment + "| " + "Redbook is Null !! "
                    wdetail2.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ "  .
                    wdetail2.pass    = "N". /*A65-0079*/
            END.
        END.
        FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  wdetail.brand AND maktab_fil.sclass   =  trim(SUBSTR(nv_class,2,4)) NO-LOCK NO-ERROR.
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
        IF nv_polday < 365 THEN DO:
           nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat) + 1. 
        END.
   /* RUN WUW\WUWMCP01.P(INPUT sic_bran.uwm100.policy, */ /*A68-0044*/
    RUN WUW\WUWMCP02.P(INPUT sic_bran.uwm100.policy,       /*A68-0044*/
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
                     INPUT "wgwhcgen"  ,
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
                     INPUT nv_level ,
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
                     INPUT nv_adjpaprm,  /* yes/ No*/
                     INPUT YES ,         /* nv_adjprem yes/ No*/
                     INPUT nv_flgpol ,  /*NR=New RedPlate, NU=New Used Car, RN=Renew*/                   
                     INPUT nv_flgclm ,  /*NC=NO CLAIM , WC=With Claim*/                                  
                     INPUT 10,    /*cv_lfletper  = Limit Fleet % 10%*/                                                                                                                          
                     INPUT cv_lncbper , /*50,*/ /*  = Limit NCB %  50%*/                                                                                                                           
                     INPUT 35,    /*cv_ldssper  = Limit DSPC % กรณีป้ายแดง 110  ส่ง 45%  นอกนั้นส่ง 30% 35%*/                                                                                  
                     INPUT 0 ,    /*cv_lclmper  = Limit Claim % กรณีให้ Load Claim ได้ New 0% or 50% , Renew 0% or 20 - 50%  0%*/                                                              
                     INPUT 0 ,    /*cv_ldstfper = Limit DSTF % 0%*/                                                                                                                            
                     INPUT NO,   /*nv_reflag   = กรณีไม่ต้องการ Re-Calculate ใส่ Yes*/                                                                                                        
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
                     INPUT-OUTPUT nv_garage , /* A68-0044*/                      
                     INPUT-OUTPUT nv_31rate , /*a68-0044*/                       
                     INPUT-OUTPUT nv_31prmt , /* A68-0044*/                      
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
    ASSIGN sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
    ASSIGN sic_bran.uwm130.chr3 = IF nv_adjpaprm = YES THEN "YES" ELSE "NO" .   /*F68-0001*/
    IF nv_message <> "" THEN DO:   /*A65-0079*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN wdetail2.pass  = "N". /*A65-0043*/
        ASSIGN  wdetail2.comment = wdetail2.comment + "|" + nv_message
                wdetail2.WARNING = wdetail2.WARNING + "|" + nv_message.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt_init C-Win 
PROCEDURE proc_calpremt_init :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
 ASSIGN 
     nv_polday  = 0                                        /* nv_baseprm  = 0 */                                                    
     nv_covcod  = ""                                       /* nv_baseprm3 = 0 */                                                    
     nv_class   = ""                                        nv_pdprem   = 0                                                     
     nv_vehuse  = ""                                        nv_netprem  = 0    /*เบี้ยสุทธิ */                                  
     nv_cstflg  = ""  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  nv_gapprm   = 0    /*เบี้ยรวม */                                      
     nv_engcst  = 0   /* ต้องใส่ค่าตาม nv_cstflg  */        nv_flagprm  = "N"  /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                
     /*nv_drivno  = 0*/                                     nv_effdat   = ?                                                     
     nv_driage1 = 0                                         nv_ratatt   = 0                                                     
     nv_driage2 = 0                                         nv_siatt    = 0                                                     
     nv_pdprm0  = 0  /*เบี้ยส่วนลดผู้ขับขี่*/               nv_netatt   = 0                                                     
     nv_yrmanu  = 0                                         nv_fltatt   = 0                                                     
     nv_totsi   = 0                                         nv_ncbatt   = 0                                                     
     nv_totfi   = 0                                         nv_dscatt   = 0                                                     
     nv_vehgrp  = ""                                        nv_atfltgap = 0   /*A65-0079*/                                      
     nv_access  = ""                                        nv_atncbgap = 0   /*A65-0079*/                                      
     nv_supe    = NO                                        nv_atdscgap = 0   /*A65-0079*/                                      
     nv_tpbi1si = 0                                         nv_packatt  = ""  /*A65-0079*/                                      
     nv_tpbi2si = 0                                         nv_flgsht   = ""  /*A65-0079*/                                      
     nv_tppdsi  = 0                                         nv_status   = ""                                                    
     nv_411si   = 0                                         nv_fcctv    = NO                                                    
     nv_412si   = 0                                         nv_uom1_c   = ""                                                    
     nv_413si   = 0                                         nv_uom2_c   = ""                                                    
     nv_414si   = 0                                         nv_uom5_c   = ""                                                    
     nv_42si    = 0                                         nv_uom6_c   = ""                                                    
     nv_43si    = 0                                         nv_uom7_c   = ""                                                    
     nv_41prmt  = 0                                         nv_message  = ""                                                    
     nv_412prmt = 0                                         nv_level    = 0                                                         
     nv_413prmt = 0                                         nv_levper   = 0                                                     
     nv_414prmt = 0                                         nv_tariff   = ""                                                    
     nv_42prmt  = 0                                         nv_adjpaprm   = NO                                                  
     nv_43prmt  = 0                                         nv_flgpol     = ""                                                  
     nv_seat41  = 0                                         nv_flgclm     = ""                                                  
     nv_dedod   = 0                                         /*nv_ncbyrs     = 0*/                                                   
     nv_addod   = 0                                         nv_chgflg     = NO                                                  
     nv_dedpd   = 0                                         nv_chgrate    = 0                                                   
     nv_ncbp    = 0                                         nv_chgsi      = 0                                                   
     nv_fletp   = 0                                         nv_chgpdprm   = 0                                                   
     nv_dspcp   = 0                                         nv_chggapprm  = 0                                                   
     nv_dstfp   = 0                                         nv_battflg    = NO                                                  
     nv_clmp    = 0                                         nv_battrate   = 0                                                   
     nv_mainprm = 0                                         nv_battsi     = 0                                                   
     nv_ncbamt  = 0                                         nv_battprice  = 0                                                   
     nv_fletamt = 0                                         nv_battpdprm  = 0                                                   
     nv_dspcamt = 0                                         nv_battgapprm = 0                                                   
     nv_dstfamt = 0                                         nv_battyr     = 0                                                   
     nv_clmamt  = 0                                         nv_battper    = 0                                                   
                                                            nv_evflg      = NO 
     nv_flag    =  NO    
     nv_garage  =  ""    
     nv_31prmt  =  0     
     nv_31rate  =  0     .

 ASSIGN               
      nv_covcod  = wdetail.covcod                                              
      nv_class   = trim(wdetail2.prempa) + trim(wdetail2.subclass)     /* T110 */                                     
      nv_vehuse  = wdetail.vehuse       
      nv_driage1 = nv_drivage1                                 
      nv_driage2 = nv_drivage2                                    
      nv_yrmanu  = INT(wdetail.caryear)           
      nv_totsi   = sic_bran.uwm130.uom6_v
      nv_totfi   = sic_bran.uwm130.uom7_v 
      nv_vehgrp  = wdetail.cargrp                                                     
      nv_access  = sic_bran.uwm130.uom6_u 
      nv_tpbi1si = sic_bran.uwm130.uom1_v      
      nv_tpbi2si = sic_bran.uwm130.uom2_v      
      nv_tppdsi  = sic_bran.uwm130.uom5_v      
      nv_411si   = deci(WDETAIL2.no_41)       
      nv_412si   = deci(WDETAIL2.no_41)       
      nv_413si   = 0                                          
      nv_414si   = 0                                        
      nv_42si    = deci(WDETAIL2.no_42)               
      nv_43si    = deci(WDETAIL2.no_43)   
      nv_41prmt  = 0 
      nv_412prmt = 0 
      nv_413prmt = 0 
      nv_414prmt = 0 
      nv_42prmt  = 0 
      nv_43prmt  = 0 
      nv_seat41  = INTE(wdetail2.seat41) 
      nv_dedod   = dod1             
      nv_addod   = dod2                               
      nv_dedpd   = dpd0                                              
      nv_ncbp    = deci(wdetail.ncb) 
      nv_fletp   = deci(wdetail2.fleet)                                  
      nv_dspcp   = nv_dss_per                                               
      nv_dstfp   = IF TRIM(wdetail2.producer) = "B3M0070" THEN 18 ELSE 0 
      nv_clmp    = 0  
      nv_mainprm  = 0
      nv_dodamt   = 0  /* ระบุเบี้ย DOD */   
      nv_dadamt   = 0  /* ระบุเบี้ย DOD1 */  
      nv_dpdamt   = 0  /* ระบุเบี้ย DPD */   
      nv_ncbamt   = 0  /* ระบุเบี้ย NCB PREMIUM */           
      nv_fletamt  = 0  /* ระบุเบี้ย FLEET PREMIUM */          
      nv_dspcamt  = 0  /* ระบุเบี้ย DSPC PREMIUM */           
      nv_dstfamt  = 0  /* ระบุเบี้ย DSTF PREMIUM */           
      nv_clmamt   = 0  /* ระบุเบี้ย LOAD CLAIM PREMIUM */    
      nv_baseprm  = IF wdetail.prepol = "" THEN  0  ELSE nv_baseprm   
      nv_baseprm3 = IF wdetail.prepol = "" THEN  0  ELSE nv_baseprm3  
      nv_netprem  = DECI(wdetail.premt) /* เบี้ยสุทธิ เบี้ยเต็มปี */  
      nv_pdprem   = DECI(wdetail.premt) /* เบี้ยสุทธิ เบี้ยเต็มปี */
      nv_gapprem  = DECI(wdetail.premt)
      nv_gapprm   = 0                                                     
      nv_flagprm  = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
      nv_effdat   = sic_bran.uwm100.comdat
      nv_ratatt   =  0                  
      nv_siatt    =  0                                                
      nv_netatt   =  0    
      nv_fltatt   =  0   
      nv_ncbatt   =  0   
      nv_dscatt   =  0
      nv_attgap   =  0
      nv_atfltgap =  0
      nv_atncbgap =  0
      nv_atdscgap =  0
      nv_packatt  =  ""
      nv_flgsht   = "P" /*IF wdetail.srate = "Y" THEN "S" ELSE "P" */ /*A65-0079*/
      nv_fcctv    = IF nv_cctvcode = "0001" THEN YES ELSE NO  
      nv_level      = INTE(wdetail.drilevel)   
      nv_levper     = nv_dlevper 
      nv_tariff     = wdetail2.tariff
      nv_adjpaprm   = NO
      nv_flgpol     = IF wdetail.prepol = "" THEN "NR" ELSE "RN" /*NR=New RedPlate, NU=New Used Car, RN=Renew*/                   
      nv_flgclm     = IF nv_clmp <> 0 THEN "WC" ELSE "NC"  /*NC=NO CLAIM , WC=With Claim*/  
      nv_chgflg     = IF DECI(wdetail.chargprm) <> 0 THEN YES ELSE NO    
      nv_chgrate    = 0 /*DECI(wdetail.chargrate)*/                     
      nv_chgsi      = 0 /*INTE(wdetail.chargsi)*/                                     
      nv_chgpdprm   = DECI(wdetail.chargprm)                                     
      nv_chggapprm  = 0                                     
      nv_battflg    = IF DECI(wdetail.battprm) <> 0 THEN YES ELSE NO                                    
      nv_battrate   = 0                                   
      nv_battsi     = 0                                  
      nv_battprice  = INTE(wdetail.battprice)                     
      nv_battpdprm  = DECI(wdetail.battprm)                                     
      nv_battgapprm = 0                                                                                                                     
      nv_battyr     = INTE(wdetail.caryear)    
      nv_battper    = 0 /*DECI(wdetail.battper)*/
      nv_evflg      = IF index(wdetail2.subclass,"E") <> 0 THEN YES ELSE NO  
      nv_compprm    = 0       nv_uom9_v     = 0 
      /* end A67-0029*/
      nv_flag     = IF INDEX(wdetail2.subclass,"E") <> 0 THEN NO ELSE nv_cal
      nv_garage   = TRIM(wdetail.garage) 
      nv_31prmt   = DECI(wdetail.premt31)    /*A68-0044*/
      nv_31rate   = DECI(wdetail.rate31) .  /*A68-0044*/

 IF index(wdetail2.subclass,"E") <> 0 THEN ASSIGN cv_lncbper = 40.
 ELSE IF wdetail.prepol <> ""  THEN ASSIGN cv_lncbper = 50.
 ELSE ASSIGN cv_lncbper = 40.
 /* end : A68-0061 */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassic_eng C-Win 
PROCEDURE proc_chassic_eng :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew        AS CHAR.
DEFINE VAR nv_len           AS INTE INIT 0.
DEFINE VAR nv_uwm301_engno  AS CHAR INIT ""  .

ASSIGN nv_uwm301_engno = wdetail.eng.
    loop_chk1:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"-") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"-") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"-") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk1.
    END.
    loop_chk2:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"/") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"/") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"/") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk2.
    END.
    loop_chk3:
    REPEAT:
        IF INDEX(nv_uwm301_engno,";") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,";") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,";") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk3.
    END.
    loop_chk4:
    REPEAT:
        IF INDEX(nv_uwm301_engno,".") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,".") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,".") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk4.
    END.
    loop_chk5:
    REPEAT:
        IF INDEX(nv_uwm301_engno,",") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,",") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,",") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk5.
    END.
    loop_chk6:
    REPEAT:
        IF INDEX(nv_uwm301_engno," ") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno," ") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno," ") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk6.
    END.
    loop_chk7:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"\") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"\") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"\") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk7.
    END.
    loop_chk8:
    REPEAT:
        IF INDEX(nv_uwm301_engno,":") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,":") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,":") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk8.
    END.
    loop_chk9:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"|") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"|") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"|") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk9.
    END.
    loop_chk10:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"+") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"+") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk10.
    END.
    loop_chk11:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"#") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"#") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"#") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk11.
    END.
    loop_chk12:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"[") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"[") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"[") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk12.
    END.
    loop_chk13:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"]") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"]") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"]") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk13.
    END.
    loop_chk14:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"'") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"'") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"+") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk14.
    END.
    loop_chk15:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"(") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"(") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"(") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk15.
    END.
    loop_chk16:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"_") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"_") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"_") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk16.
    END.
    loop_chk17:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"*") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"*") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"*") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk17.
    END.
     loop_chk18:
    REPEAT:
        IF INDEX(nv_uwm301_engno,")") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,")") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,")") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk18.
    END.
    loop_chk19:
    REPEAT:
        IF INDEX(nv_uwm301_engno,"=") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301_engno).
            nv_uwm301_engno = SUBSTRING(nv_uwm301_engno,1,INDEX(nv_uwm301_engno,"=") - 1) +
                SUBSTRING(nv_uwm301_engno,INDEX(nv_uwm301_engno,"=") + 1, nv_len ) .
            
        END.
        ELSE LEAVE loop_chk19.
    END.
    ASSIGN wdetail.eng = trim(nv_uwm301_engno)   .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkaddr C-Win 
PROCEDURE proc_chkaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A68-0061      
------------------------------------------------------------------------------*/
DO:
    RUN proc_assign2addr (INPUT  wdetail.tambon               
                         ,INPUT  wdetail.amper                
                         ,INPUT  wdetail.country              
                         ,INPUT  wdetail.occup                
                         ,OUTPUT wdetail3.codeocc             
                         ,OUTPUT wdetail3.codeaddr1           
                         ,OUTPUT wdetail3.codeaddr2           
                         ,OUTPUT wdetail3.codeaddr3). 

    RUN proc_matchtypins (INPUT  wdetail.tiname                      
                         ,INPUT  TRIM(wdetail.insnam + " " + wdetail.name3)
                         ,OUTPUT wdetail3.insnamtyp
                         ,OUTPUT wdetail3.firstName 
                         ,OUTPUT wdetail3.lastName).

    ASSIGN 
        wdetail3.br_insured  = "00000"      
        wdetail3.campaign_ov = "".         
   
   
    IF wdetail.road <> "" THEN 
        ASSIGN 
        wdetail.road = "ถนน" + trim(wdetail.road)
        wdetail.addr = trim(wdetail.addr) + " " + wdetail.road.

    IF (index(wdetail.country,"กรุงเทพ") <> 0) OR (index(wdetail.country,"กทม") <> 0) THEN 
        ASSIGN   
        wdetail.tambon = "แขวง" + wdetail.tambon
        wdetail.amper  = "เขต" + wdetail.amper .
    ELSE  
        ASSIGN  
            wdetail.tambon  = "ตำบล" + wdetail.tambon   
            wdetail.amper   = "อำเภอ" + wdetail.amper 
            wdetail.country = "จังหวัด" + wdetail.country . 
    /*addr 1 */
    IF LENGTH(wdetail.addr) > 35 THEN DO:
        loop_add01:
        DO WHILE LENGTH(wdetail.addr) > 35 :
            IF R-INDEX(wdetail.addr," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.tambon  = trim(SUBSTR(wdetail.addr,r-INDEX(wdetail.addr," "))) + " " + wdetail.tambon
                    wdetail.addr    = trim(SUBSTR(wdetail.addr,1,r-INDEX(wdetail.addr," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        /*wdetail.tambon*/
        IF LENGTH(wdetail.tambon) > 35 THEN DO:
            loop_add02:
            DO WHILE LENGTH(wdetail.tambon) > 35 :
                IF R-INDEX(wdetail.tambon," ") <> 0 THEN DO:
                    ASSIGN 
                        wdetail.amper    = trim(SUBSTR(wdetail.tambon,r-INDEX(wdetail.tambon," "))) + " " + wdetail.amper
                        wdetail.tambon   = trim(SUBSTR(wdetail.tambon,1,r-INDEX(wdetail.tambon," "))).
                END.
                ELSE LEAVE loop_add02.
            END.
        END.
        /*wdetail.amper*/
        IF LENGTH(wdetail.amper) > 35 THEN DO:
            loop_add03:
            DO WHILE LENGTH(wdetail.amper) > 35 :
                IF R-INDEX(wdetail.amper," ") <> 0 THEN DO:
                    ASSIGN 
                        wdetail.country = trim(SUBSTR(wdetail.amper,r-INDEX(wdetail.amper," "))) + " " + wdetail.country
                        wdetail.amper   = trim(SUBSTR(wdetail.amper,1,r-INDEX(wdetail.amper," "))).
                END.
                ELSE LEAVE loop_add03.
            END.
        END.
    END.
    ELSE DO:
        IF LENGTH(wdetail.tambon + " " + wdetail.amper ) <= 35 THEN  
            ASSIGN 
            wdetail.tambon   = wdetail.tambon + " " + wdetail.amper 
            wdetail.amper    = wdetail.country
            wdetail.country  = "" .
        ELSE IF LENGTH(wdetail.amper + " " + wdetail.country) <= 35 THEN  
            ASSIGN 
            wdetail.amper    = wdetail.amper + " " + wdetail.country
            wdetail.country  = "" .
    END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcomp C-Win 
PROCEDURE proc_chkcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A68-0061      
------------------------------------------------------------------------------*/
DEF VAR n_bev AS CHAR .
DEF VAR n_comp72 AS CHAR INIT "" .
DO:
    ASSIGN  n_comp72    = ""     nv_chkerror = ""
            n_bev          = IF trim(wdetail.typecar) = "EV" THEN "Y" ELSE "N" 
            wdetail.vehuse = IF deci(wdetail.premt) = 600 THEN "1" ELSE "2" .
    /*MESSAGE wdetail.policy 
            " bev      " wdetail.bev       skip
            " prempa   " wdetail.prempa    skip
            " subclass " wdetail.subclass  skip
            " garage   " wdetail.garage    skip
            " vehuse   " wdetail.vehuse    skip
            "n_comp_1  " n_comp_1          skip
           
        VIEW-AS ALERT-BOX.*/
    RUN wgw/wgwcomp(INPUT  wdetail.prem_r,     
                    INPUT  wdetail.vehuse  , 
                    INPUT  wdetail2.prempa  , 
                    INPUT  wdetail2.subclass, 
                    INPUT  n_bev , 
                    INPUT  wdetail.garage  , 
                    OUTPUT n_comp72        , 
                    OUTPUT nv_chkerror ) .
    
    IF nv_chkerror <> ""  THEN DO:
        ASSIGN wdetail2.subclass = TRIM(n_comp72)
               wdetail2.comment  = wdetail2.comment + "|" + nv_chkerror 
               wdetail2.pass     = "N"
               WDETAIL2.OK_GEN   = "N".
    END.
    ELSE DO:
        ASSIGN wdetail2.subclass = TRIM(n_comp72) .
    END.
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdriver C-Win 
PROCEDURE proc_chkdriver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:add by A68-0061       
------------------------------------------------------------------------------*/
DO:
    IF nv_cal = NO THEN DO: /* Tariff เก่า */
        IF ((wdetail2.subclass = "E11" ) OR (wdetail2.subclass = "E21" ) OR (wdetail2.subclass = "E61" ) OR (wdetail2.subclass = "E12")) THEN DO:   
            IF trim(wdetail.flagno) = "1" OR TRIM(wdetail.flagno) = ""   THEN DO:
              ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " กรุณาระบุผู้ขับขี่ " 
                     WDETAIL2.OK_GEN  = "N"     
                     wdetail2.pass    = "N".
            END.
            ELSE DO:
               IF wdetail.drivername1 = "" AND wdetail.drivername2 = "" AND wdetail.dname3 = "" AND wdetail.dname4 = "" AND wdetail.dname5 = "" THEN DO:
                     ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " กรุณาระบุชื่อผู้ขับขี่" 
                       WDETAIL2.OK_GEN  = "N"     
                       wdetail2.pass    = "N".
               END.
               IF wdetail.drivername1 <> "" AND (wdetail.ddriveno = ""  OR  wdetail.dicno = "" ) THEN DO:
                 ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 1 ต้องระบุข้อมูล" 
                       WDETAIL2.OK_GEN  = "N"     
                       wdetail2.pass    = "N".
               END.
               IF wdetail.drivername2 <> "" AND (wdetail.dddriveno = ""  OR  wdetail.ddicno = "" ) THEN DO:
                 ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 2 ต้องระบุข้อมูล" 
                       WDETAIL2.OK_GEN  = "N"     
                       wdetail2.pass    = "N".
               END.
               IF wdetail.dname3 <> "" AND (wdetail.ddriveno3 = ""  OR  wdetail.dicno3 = "" ) THEN DO:
                 ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 3 ต้องระบุข้อมูล" 
                       WDETAIL2.OK_GEN  = "N"     
                       wdetail2.pass    = "N".
               END.
               IF wdetail.dname4 <> "" AND (wdetail.ddriveno4 = ""  OR  wdetail.dicno4 = "" ) THEN DO:
                 ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 4 ต้องระบุข้อมูล" 
                       WDETAIL2.OK_GEN  = "N"     
                       wdetail2.pass    = "N".
               END.
               IF wdetail.dname5 <> "" AND (wdetail.ddriveno5 = ""  OR  wdetail.dicno5 = "" ) THEN DO:
                 ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 5 ต้องระบุข้อมูล" 
                       WDETAIL2.OK_GEN  = "N"     
                       wdetail2.pass    = "N".
               END.
            END.
        END. /* end class */
    END. /* end tg_flag */
    ELSE DO: /* Tariff ใหม่*/
        IF (INDEX(wdetail2.subclass,"11") <> 0 OR INDEX(wdetail2.subclass,"21") <> 0  OR INDEX(wdetail2.subclass,"61") <> 0 OR (wdetail2.subclass = "E12")) THEN DO:
           IF trim(wdetail.flagno) = "1" OR TRIM(wdetail.flagno) = ""   THEN DO:
             ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " กรุณาระบุผู้ขับขี่ " 
                    WDETAIL2.OK_GEN  = "N"     
                    wdetail2.pass    = "N".
           END.
           ELSE DO:
              IF wdetail.drivername1 = "" AND wdetail.drivername2 = "" AND wdetail.dname3 = "" AND wdetail.dname4 = "" AND wdetail.dname5 = "" THEN DO:
                    ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " กรุณาระบุชื่อผู้ขับขี่" 
                      WDETAIL2.OK_GEN  = "N"     
                      wdetail2.pass    = "N".
              END.
              IF wdetail.drivername1 <> "" AND (wdetail.ddriveno = ""  OR  wdetail.dicno = "" ) THEN DO:
                ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 1 ต้องระบุข้อมูล" 
                      WDETAIL2.OK_GEN  = "N"     
                      wdetail2.pass    = "N".
              END.
              IF wdetail.drivername2 <> "" AND (wdetail.dddriveno = ""  OR  wdetail.ddicno = "" ) THEN DO:
                ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 2 ต้องระบุข้อมูล" 
                      WDETAIL2.OK_GEN  = "N"     
                      wdetail2.pass    = "N".
              END.
              IF wdetail.dname3 <> "" AND (wdetail.ddriveno3 = ""  OR  wdetail.dicno3 = "" ) THEN DO:
                ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 3 ต้องระบุข้อมูล" 
                      WDETAIL2.OK_GEN  = "N"     
                      wdetail2.pass    = "N".
              END.
              IF wdetail.dname4 <> "" AND (wdetail.ddriveno4 = ""  OR  wdetail.dicno4 = "" ) THEN DO:
                ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 4 ต้องระบุข้อมูล" 
                      WDETAIL2.OK_GEN  = "N"     
                      wdetail2.pass    = "N".
              END.
              IF wdetail.dname5 <> "" AND (wdetail.ddriveno5 = ""  OR  wdetail.dicno5 = "" ) THEN DO:
                ASSIGN wdetail2.comment = wdetail2.comment + "| " + "รหัสรถ" + wdetail2.subclass + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ผู้ขับขี่ 5 ต้องระบุข้อมูล" 
                      WDETAIL2.OK_GEN  = "N"     
                      wdetail2.pass    = "N".
              END.
           END.
       END.
    END. /* end tg_flag new */
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
DEF BUFFER bfwdetail2 FOR wdetail2 .
DO:
    IF wdetail2.redbook = ""  THEN DO:
        ASSIGN fi_process = "check Redbook " + wdetail.chasno + ".....".
        DISP fi_process WITH FRAM fr_main.
        
        IF wdetail.covcod <> "1" THEN nv_si = IF INT(wdetail.tpfire) <> 0 THEN INT(wdetail.tpfire) ELSE INT(wdetail.si) . 
        ELSE nv_si = INT(wdetail.si).
        
         IF INDEX(wdetail2.subclass,"E") <> 0   THEN DO:
              RUN wgw/wgwredbev(input wdetail.brand ,      
                               input  wdetail.model ,  
                               input  nv_si ,  
                               INPUT  wdetail2.tariff,  
                               input  wdetail2.subclass,   
                               input  wdetail.caryear, 
                               input  wdetail2.watt,
                               input  0 , 
                               INPUT-OUTPUT wdetail.maksi,
                               INPUT-OUTPUT wdetail2.redbook) .
         END.
         ELSE DO: 
            RUN wgw/wgwredbk1(input  wdetail.brand , /*A65-0079*/
                              input  wdetail.model ,  
                              input  nv_si         ,  
                              INPUT  wdetail2.tariff,  
                              input  wdetail2.subclass,   
                              input  wdetail.caryear, 
                              input  wdetail.engcc  ,
                              input  wdetail2.weight , 
                              INPUT-OUTPUT wdetail2.redbook) .
         END.
          
         IF wdetail2.cr_2 <> "" AND wdetail2.redbook <> ""  THEN DO:
             FIND LAST bfwdetail2 WHERE bfwdetail2.policy = wdetail2.cr_2 AND bfwdetail2.poltyp = "V72" NO-ERROR NO-WAIT.
                IF AVAIL bfwdetail2 THEN DO: 
                    ASSIGN bfwdetail2.redbook = IF bfwdetail2.redbook = "" THEN wdetail2.redbook ELSE bfwdetail2.redbook.
                END.
                RELEASE bfwdetail2.
         END.
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
DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER . 
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "012: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
ASSIGN fi_process = "check data HCT...." + wdetail.policyno .
DISP fi_process WITH FRAM fr_main.
IF wdetail.vehreg = " " AND wdetail.prepol  = " " THEN DO: 
    ASSIGN
        wdetail2.comment = wdetail2.comment + "| Vehicle Register is mandatory field. "
        wdetail2.pass    = "N"   
        WDETAIL2.OK_GEN  = "N". 
END.
ELSE DO:
    IF wdetail.prepol = " " THEN DO:     /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
        Def  var  nv_vehreg  as char  init  " ".
        Def  var  s_polno       like sicuw.uwm100.policy   init " ".
        Find LAST sicuw.uwm301 Use-index uwm30102 Where  
            sicuw.uwm301.vehreg = wdetail.vehreg  No-lock no-error no-wait.
        IF AVAIL sicuw.uwm301 THEN DO:
            If  sicuw.uwm301.policy =  wdetail.policyno     and          
                sicuw.uwm301.endcnt = 1  and
                sicuw.uwm301.rencnt = 1  and
                sicuw.uwm301.riskno = 1  and
                sicuw.uwm301.itemno = 1  Then  Leave.
            Find first sicuw.uwm100 Use-index uwm10001      Where
                sicuw.uwm100.policy = sicuw.uwm301.policy   and
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt   and
                sicuw.uwm100.expdat > date(wdetail.comdat)  No-lock no-error no-wait.
            If avail sicuw.uwm100 Then 
                s_polno     =   sicuw.uwm100.policy.
        END.        /*avil 301*/
    END.            /*จบการ Check ทะเบียนรถ*/
END.      /*note end else*/   /*end note vehreg*/
nv_chkerror = "".
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "012-1: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
RUN wgw\wgwchkagpd  (INPUT fi_agent            
                     ,INPUT wdetail2.producer   
                     ,INPUT-OUTPUT nv_chkerror).
IF nv_chkerror <> "" THEN DO:
    ASSIGN  wdetail2.pass = "N"  
        wdetail2.comment = wdetail2.comment + "|Error Code Producer/Agent:" + nv_chkerror
        WDETAIL2.OK_GEN  = "N".
END.
/*wdetail2.n_branch*/
IF wdetail2.n_branch = ""  THEN  
    ASSIGN  wdetail2.pass = "N"  
    wdetail2.comment = wdetail2.comment + "| พบสาขาเป็นค่าว่างหรือไม่พบรหัสดีเลอร์" + n_textfi
    WDETAIL2.OK_GEN  = "N".
IF wdetail2.cancel = "ca"  THEN  
    ASSIGN  wdetail2.pass = "N"  
    wdetail2.comment = wdetail2.comment + "| cancel"
    WDETAIL2.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail2.pass    = "N"     
    WDETAIL2.OK_GEN  = "N".
IF wdetail2.drivnam  = "y" AND wdetail.drivername1 =  " "   THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
    wdetail2.pass    = "N" 
    WDETAIL2.OK_GEN  = "N".
IF wdetail2.prempa = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"     
    WDETAIL2.OK_GEN  = "N".
IF wdetail2.subclass = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"  
    WDETAIL2.OK_GEN  = "N".
IF wdetail.brand = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"        
    WDETAIL2.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"   
    WDETAIL2.OK_GEN  = "N".
IF wdetail.engcc    = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"     
    WDETAIL2.OK_GEN  = "N".
IF wdetail.seat  = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"    
    WDETAIL2.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN  wdetail2.comment = wdetail2.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail2.pass    = "N"  
    WDETAIL2.OK_GEN  = "N".

/*comment BY kridtiya i. A56-0318 ...
IF wdetail.icno <> "" THEN DO:
    IF LENGTH(TRIM(wdetail.icno)) = 13 THEN DO:
        DO WHILE nv_seq <= 12:
            nv_sum = nv_sum + INTEGER(SUBSTR(TRIM(wdetail.icno),nv_seq,1)) * (14 - nv_seq).
            nv_seq = nv_seq + 1.
        END.
        nv_checkdigit = 11 - nv_sum MODULO 11.
        IF nv_checkdigit >= 10 THEN nv_checkdigit = nv_checkdigit - 10.
        IF STRING(nv_checkdigit) <> SUBSTR(TRIM(wdetail.icno),13,1) THEN  
            ASSIGN  wdetail.icno = ""
            /*wdetail2.comment = wdetail2.comment + "| WARNING: พบเลขบัตรประชาชนไม่ถูกต้อง"
            wdetail2.pass    = "N"  
            WDETAIL2.OK_GEN  = "N"*/  .
        /* FIND FIRST sicsyac.xmm600 USE-INDEX xmm60003 WHERE 
        sicsyac.xmm600.icno  = nv_icno  AND
        sicsyac.xmm600.acno <> nv_acno NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm600 THEN DO:    
        ASSIGN  wdetail2.comment = wdetail2.comment + "| WARNING: คีย์เลขบัตรประชาชนไม่ถูกต้อง"
        wdetail2.pass    = "N"  
        WDETAIL2.OK_GEN  = "N".      
        MESSAGE "พบ Ic.No ! " nv_icno  "ซ้ำกับ  Account No. " sicsyac.xmm600.acno .      
        end. */
    END.
    ELSE ASSIGN  wdetail.icno = ""
        /*wdetail2.comment = wdetail2.comment + "| WARNING: คีย์เลขบัตรประชาชนไม่ถูกต้องไม่เท่ากับ 13 หลัก"
        wdetail2.pass    = "N"  
        WDETAIL2.OK_GEN  = "N"*/   .
END. 
comment BY kridtiya i. A56-0318 ...*/
ASSIGN
    nv_maxsi  = 0
    nv_minsi  = 0
    nv_si     = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred    = NO.  
IF wdetail2.redbook <> "" THEN DO:  /*case renew policy .......*/
    FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE 
        stat.maktab_fil.sclass = wdetail2.subclass  AND 
        stat.maktab_fil.modcod = wdetail2.redbook   No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  
            nv_modcod         =  stat.maktab_fil.modcod                                    
            nv_moddes         =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp    =  stat.maktab_fil.prmpac
            wdetail.brand     =  stat.maktab_fil.makdes
            wdetail.caryear   =  STRING(stat.maktab_fil.makyea)
            wdetail.engcc     =  STRING(stat.maktab_fil.engine)
            wdetail2.subclass =  stat.maktab_fil.sclass   
            /*wdetail.si      =  STRING(stat.maktab_fil.si)*/
            wdetail2.redbook  =  stat.maktab_fil.modcod                                    
            wdetail.seat      =  STRING(stat.maktab_fil.seats)
            nv_si             =  stat.maktab_fil.si 
            /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/
            chkred           =  YES      /*note chk found redbook*/  .
        IF wdetail.covcod = "1"  THEN DO:
            FIND FIRST stat.makdes31 WHERE 
                stat.makdes31.makdes = "X"  AND     /*Lock X*/
                stat.makdes31.moddes = wdetail2.prempa + wdetail2.subclass    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE makdes31 THEN 
                ASSIGN  nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            ELSE 
                ASSIGN
                    nv_maxSI = nv_si
                    nv_minSI = nv_si.
        END.  /***--- End Check Rate SI ---***/
    End.          
    ELSE nv_modcod = " ".
END. /*red book <> ""*/   
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "012-2: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
IF nv_modcod = "" THEN DO:
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
           makdes31.moddes =  wdetail2.prempa + wdetail2.subclass NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL makdes31  THEN
           ASSIGN n_ratmin = makdes31.si_theft_p   
           n_ratmax = makdes31.load_p   .    
       ELSE ASSIGN n_ratmin = 0     n_ratmax = 0.
    /*create by : A60-0505*/
    /*IF INDEX(wdetail.model,"CIVIC") <> 0 THEN DO:*/ /*A63-00472*/
    IF (INDEX(wdetail.model,"CIVIC") <> 0 ) OR (INDEX(wdetail.model,"CITY") <> 0) THEN DO:  /*A63-00472*/
        IF INDEX(wdetail.carcode,"HATCHBACK") <> 0 THEN DO:
           Find First stat.maktab_fil USE-INDEX maktab04    Where
             stat.maktab_fil.makdes   =     wdetail.brand            And                  
             index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
             stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
             stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
             stat.maktab_fil.sclass   =     wdetail2.subclass        AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
             stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  AND
             stat.maktab_fil.body     = "HATCHBACK"     No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN
                nv_modcod              =  stat.maktab_fil.modcod
                wdetail2.redbook       =  stat.maktab_fil.modcod
                wdetail.cargrp         =  stat.maktab_fil.prmpac
                wdetail.body           =  stat.maktab_fil.body
                chkred = YES.
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
             stat.maktab_fil.makdes   =     wdetail.brand            And                  
             index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
             stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
             stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
             stat.maktab_fil.sclass   =     wdetail2.subclass        AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
             stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  AND
             stat.maktab_fil.body     = "SEDAN"     No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN
                nv_modcod              =  stat.maktab_fil.modcod
                wdetail2.redbook       =  stat.maktab_fil.modcod
                wdetail.cargrp         =  stat.maktab_fil.prmpac
                wdetail.body           =  stat.maktab_fil.body
                chkred = YES.
        END.
    END.
    ELSE DO:
    /* end A60-0505*/
       Find First stat.maktab_fil USE-INDEX maktab04    Where
           stat.maktab_fil.makdes   =     wdetail.brand            And                  
           index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
           stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
           stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
           stat.maktab_fil.sclass   =     wdetail2.subclass        AND
          (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    AND
           stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
           stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
           No-lock no-error no-wait.
       If  avail stat.maktab_fil  Then 
           ASSIGN
           nv_modcod              =  stat.maktab_fil.modcod
           wdetail2.redbook       =  stat.maktab_fil.modcod
           wdetail.cargrp         =  stat.maktab_fil.prmpac
           wdetail.body           =  stat.maktab_fil.body
           /*sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
           sic_bran.uwm301.moddes =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
           sic_bran.uwm301.vehgrp =  stat.maktab_fil.prmpac
           sic_bran.uwm301.body   =  stat.maktab_fil.body*/
           chkred = YES.
    /*IF nv_modcod = ""  THEN RUN proc_maktab.*/
    END.
END.  /*nv_modcod = blank*/
    /*end note add &  modi*/
    ASSIGN                  
        NO_CLASS  = wdetail2.prempa + wdetail2.subclass 
        nv_poltyp = wdetail2.poltyp.
    IF nv_poltyp = "v72" THEN NO_CLASS  =  wdetail2.subclass.
    If no_class  <>  " " Then do:
        FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
            sicsyac.xmd031.poltyp =   nv_poltyp AND
            sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE sicsyac.xmd031 THEN 
            /*MESSAGE   "Not on Business Classes Permitted per Policy Type file xmd031"  
                sicuw.uwm100.poltyp   no_class  View-as alert-box.*/
            ASSIGN
                wdetail2.comment = wdetail2.comment + "| Not On Business Class xmd031" 
                wdetail2.pass    = "N"   
                WDETAIL2.OK_GEN  = "N".
        
        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
            sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
        IF NOT AVAILABLE sicsyac.xmm016 THEN 
            ASSIGN
                wdetail2.comment = wdetail2.comment + "| Not on Business class on xmm016"
                wdetail2.pass    = "N"    
                WDETAIL2.OK_GEN  = "N".
        ELSE 
            ASSIGN    
                wdetail2.tariff =   sicsyac.xmm016.tardef
                no_class       =   sicsyac.xmm016.class
                nv_sclass      =   Substr(no_class,2,3).
    END.
    Find sicsyac.sym100 Use-index sym10001       Where
         sicsyac.sym100.tabcod = "u014"          AND 
         sicsyac.sym100.itmcod =  wdetail.vehuse No-lock no-error no-wait.
    IF not avail sicsyac.sym100 Then 
        ASSIGN
            wdetail2.comment = wdetail2.comment + "| Not on Vehicle Usage Codes table sym100 u014"
            wdetail2.pass    = "N" 
            WDETAIL2.OK_GEN  = "N".
     Find  sicsyac.sym100 Use-index sym10001  Where
         sicsyac.sym100.tabcod = "u013"         And
         sicsyac.sym100.itmcod = wdetail.covcod
         No-lock no-error no-wait.
     IF not avail sicsyac.sym100 Then 
         ASSIGN
             wdetail2.comment = wdetail2.comment + "| Not on Motor Cover Type Codes table sym100 u013"
             wdetail2.pass    = "N"    
             WDETAIL2.OK_GEN  = "N".
     /*---------- fleet -------------------*/
     IF inte(wdetail2.fleet) <> 0 AND INTE(wdetail2.fleet) <> 10 Then 
         ASSIGN
             wdetail2.comment = wdetail2.comment + "| Fleet Percent must be 0 or 10. "
             wdetail2.pass    = "N"    
             WDETAIL2.OK_GEN  = "N".
       
     /*----------  access -------------------*//*
     If  wdetail.access  =  "y"  Then do:  
         If  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
             nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
             Then  wdetail.access  =  "y".         
         Else do:
             Message "Class "  nv_sclass "ไม่รับอุปกรณ์เพิ่มพิเศษ"  View-as alert-box.
             ASSIGN
                 wdetail2.comment = wdetail2.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ"
                 wdetail2.pass    = "N"    
                 WDETAIL2.OK_GEN  = "N".
         End.
     END.   -------------A52-0172*/
     /*----------  ncb -------------------*/
     IF (DECI(wdetail.ncb) = 0 )  OR (DECI(wdetail.ncb) = 20 ) OR
        (DECI(wdetail.ncb) = 30 ) OR (DECI(wdetail.ncb) = 40 ) OR
        (DECI(wdetail.ncb) = 50 )    THEN DO:
     END.
     ELSE 
         ASSIGN
             wdetail2.comment = wdetail2.comment + "| not on NCB Rates file xmm104."
             wdetail2.pass    = "N"   
             WDETAIL2.OK_GEN  = "N".
     IF (wdetail.covcod = "2.1" ) THEN  
         ASSIGN  
         wdetail.ncb = "20"
         nv_ncb  = 20
         NV_NCBPER = 20.
     ELSE IF  (wdetail.covcod = "3.1" ) THEN  
         ASSIGN  
         wdetail.ncb = ""
         nv_ncb  = 0
         NV_NCBPER = 0.
     ELSE NV_NCBPER = INTE(WDETAIL.NCB).
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401 Where
             sicsyac.xmm104.tariff = wdetail2.tariff                      AND
             sicsyac.xmm104.class  = wdetail2.prempa + wdetail2.subclass   AND
             sicsyac.xmm104.covcod = wdetail.covcod           AND
             sicsyac.xmm104.ncbper = INTE(wdetail.ncb)
             No-lock no-error no-wait.
         IF not avail  sicsyac.xmm104  Then 
             ASSIGN
                 wdetail2.comment = wdetail2.comment + "| This NCB Step not on NCB Rates file xmm104. "
                 wdetail2.pass    = "N"     
                 WDETAIL2.OK_GEN  = "N".
        
     END. /*ncb <> 0*/
     /******* drivernam **********/
     nv_sclass = wdetail2.subclass. 
     If  wdetail2.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
         ASSIGN
             wdetail2.comment = wdetail2.comment + "| CODE  nv_sclass Driver 's Name must be no. "
             wdetail2.pass    = "N"    
             WDETAIL2.OK_GEN  = "N".
     
   
    
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
DEF VAR b_eng AS DECI .  /* ranu : A64-0422 01/10/2021 */
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail:
    FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno :
        FOR EACH wdetail3 WHERE wdetail3.policyno = wdetail.policyno :

        IF  wdetail.policyno = ""  THEN NEXT.
        /* ranu : A64-0422 01/10/2021 */
        OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
        PUT "str: " wdetail.policyno FORMAT "x(15)"
        " "     TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
        OUTPUT CLOSE.
        ASSIGN nv_CC    = 0
               nv_CC    = DECI(wdetail.engcc) .
        IF DECI(wdetail.engcc) > 501 THEN 
            ASSIGN 
            b_eng = round((DECI(wdetail.engcc) / 1000),1) 
            b_eng = b_eng * 1000.
        ELSE b_eng = DECI(wdetail.engcc) .   /*format engcc */
               
        wdetail.engcc    = STRING(b_eng).  
        /* end : A64-0422 01/10/2021 */
        /*------------------  renew ---------------------*/
        ASSIGN fi_process = "Process data HCT...." + wdetail.policyno .
        DISP fi_process WITH FRAM fr_main.
        /* add : A68-0061*/
        nv_cal = NO.
        IF wdetail2.poltyp = "V70" THEN DO:
            IF      wdetail2.TYPE_notify = "R" THEN ASSIGN nv_cal = tg_flagRN. 
            ELSE IF wdetail2.TYPE_notify = "S" THEN ASSIGN nv_cal = tg_flagRN.  
            ELSE ASSIGN nv_cal = tg_flag.
            RUN proc_chkdriver . 
        END.
        RUN proc_chkredbook. 
        /* end : A68-0061*/
        /*RUN proc_cr_2.*//*A67-0110*/
        ASSIGN 
            nv_dss_per = 0  /*A63-0112*/
            n_rencnt = 0
            n_endcnt = 0
            nv_dscom = 0        /*a61-0324*/
            nv_polmaster = ""   /*a61-0324*/
            nv_cctvcode  = ""   /*A63-00472*/
            /* add by : A64-0328*/
            dod0         = 0
            dod1         = 0
            dod2         = 0
            dpd0         = 0
            n_dstf       = 0
            nv_drivno    = 0
            nv_driver    = ""
            n_drivnam    = "N"  
            n_deductDOD  = 0    
            n_deductDOD2 = 0    
            n_deductDPD  = 0 .   
            /* end : A64-0328 */
        
        IF INDEX(wdetail.prepol,"1HA") <> 0  THEN ASSIGN wdetail.prepol = " " . /*a61-0324*/

        IF wdetail.prepol <> "" AND wdetail2.poltyp = "V70" THEN DO:
            RUN proc_renew.
        END.
        RUN proc_cr_2.
        IF wdetail.prepol <> " " AND wdetail2.poltyp = "V72" THEN RUN proc_renew72.
        RUN proc_susspect.  /*Add A63-00472*/
        RUN proc_ckvehreg.  /*Add A67-0100 */
        IF wdetail2.poltyp = "v72"  THEN DO:
            IF DATE(wdetail.comdat) < TODAY THEN DO:
                ASSIGN wdetail.comdat = STRING(TODAY,"99/99/9999").
                IF STRING(DAY(TODAY),"99") = "29" AND STRING(MONTH(TODAY),"99") = "02"  THEN  wdetail.expdat  = "01/03/" + STRING(YEAR(TODAY) + 1 ,"9999").
                ELSE wdetail.expdat  = STRING(DAY(TODAY),"99") + "/" + STRING(MONTH(TODAY),"99") + "/" + STRING(YEAR(TODAY) + 1 ,"9999").
            END.
            RUN proc_72.
            OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
            PUT "007: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
            OUTPUT CLOSE.
            RUN proc_policy. 
            RUN proc_colorcode  .    /*Kridtiya i. A66-0047*/
            RUN proc_722.
            RUN proc_723 (INPUT  s_recid1,       
                          INPUT  s_recid2,
                          INPUT  s_recid3,
                          INPUT  s_recid4,
                          INPUT-OUTPUT nv_message).
            OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
            PUT "End: " wdetail.policyno FORMAT "x(15)"
                " "     TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
            OUTPUT CLOSE.
            NEXT.
        END.
        ELSE DO:
            RUN proc_chktest0.
        END.
        OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
        PUT "007: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
        OUTPUT CLOSE.
        RUN proc_policy . 
        RUN proc_colorcode  .    /*Kridtiya i. A66-0047*/
        RUN proc_chktest2.      
        RUN proc_chktest3.
        RUN proc_chktest4.  /*A61-0324 */
        RUN proc_chktest5.  /*A63-00472 */
        OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
        PUT "End: " wdetail.policyno FORMAT "x(15)"
            " "     TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
        OUTPUT CLOSE.
        END.  /*wdetail3  A58-0198 */
    END.
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
ASSIGN fi_process = "Create Data " + wdetail.policyno + " on uwm130,uwm301...."  .
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
           sic_bran.uwm130.policy  = sic_bran.uwm100.policy AND
           sic_bran.uwm130.rencnt  = sic_bran.uwm100.rencnt AND
           sic_bran.uwm130.endcnt  = sic_bran.uwm100.endcnt AND
           sic_bran.uwm130.riskgp  = s_riskgp               AND            /*0*/
           sic_bran.uwm130.riskno  = s_riskno               AND            /*1*/
           sic_bran.uwm130.itemno  = s_itemno               AND            /*1*/
           sic_bran.uwm130.bchyr   = nv_batchyr             AND 
           sic_bran.uwm130.bchno   = nv_batchno             AND 
           sic_bran.uwm130.bchcnt  = nv_batcnt             NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN DO:
    DO TRANSACTION:
        CREATE sic_bran.uwm130.
        ASSIGN
            sic_bran.uwm130.policy = sic_bran.uwm120.policy
            sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
            sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
            sic_bran.uwm130.itemno = s_itemno
            sic_bran.uwm130.bchyr  = nv_batchyr          /* batch Year */
            sic_bran.uwm130.bchno  = nv_batchno          /* bchno      */
            sic_bran.uwm130.bchcnt = nv_batcnt        /* bchcnt     */
            sic_bran.uwm130.i_text = nv_cctvcode .    /* A63-00472 Add Code CCTV*/
            nv_sclass     = wdetail2.subclass .
            
        IF nv_uom6_u  =  "A"  THEN DO:
         IF nv_sclass = "320" OR nv_sclass = "340" OR nv_sclass = "520" OR nv_sclass = "540" Then  nv_uom6_u  =  "A".         
         ELSE ASSIGN wdetail.pass    = "N"
             wdetail2.comment = wdetail2.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
        END.     
        IF CAPS(nv_uom6_u) = "A"  Then
           Assign  nv_uom6_u          = "A"
           nv_othcod                  = "OTH"
           nv_othvar1                 = "     Accessory  = "
           nv_othvar2                 =  STRING(nv_uom6_u)
           SUBSTRING(nv_othvar,1,30)  = nv_othvar1
           SUBSTRING(nv_othvar,31,30) = nv_othvar2.
        ELSE ASSIGN  nv_uom6_u  = ""
             nv_othcod      = ""
             nv_othvar1     = ""
             nv_othvar2     = ""
             SUBSTRING(nv_othvar,1,30)  = nv_othvar1
             SUBSTRING(nv_othvar,31,30) = nv_othvar2.
        
        IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR
           (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2")  THEN DO: /*a62-0215*/
            ASSIGN sic_bran.uwm130.uom6_v   = IF      wdetail.covcod = "2.1" THEN inte(wdetail.tpfire)
                                              ELSE IF wdetail.covcod = "2.2" THEN inte(wdetail.tpfire) /*a62-0215*/
                                              ELSE IF wdetail.covcod = "3.1" THEN INTE(wdetail.deductda)  
                                              ELSE IF wdetail.covcod = "3.2" THEN INTE(wdetail.deductda)  /*a62-0215*/
                                              ELSE inte(wdetail.si)
            sic_bran.uwm130.uom7_v   = IF      wdetail.covcod = "2.1" THEN inte(wdetail.tpfire)
                                              ELSE IF wdetail.covcod = "2.2" THEN inte(wdetail.tpfire) /*a62-0215*/
                                              ELSE IF wdetail.covcod = "3.1" THEN 0 
                                              ELSE IF wdetail.covcod = "3.2" THEN 0  /*a62-0215*/
                                              ELSE inte(wdetail.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        END.
        IF wdetail.covcod = "2"  THEN DO:
            ASSIGN sic_bran.uwm130.uom6_v   = 0
                   sic_bran.uwm130.uom7_v   = inte(wdetail.si)
                   sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                   sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                   sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                   sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                   sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        END.
        IF wdetail.covcod = "3"  THEN DO:
            ASSIGN sic_bran.uwm130.uom6_v  = 0
                sic_bran.uwm130.uom7_v   = 0
                sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        END.
        IF wdetail2.poltyp = "v72" THEN  n_sclass72 = wdetail2.subclass.
        ELSE n_sclass72 = wdetail2.prempa + wdetail2.subclass .
        
        FIND FIRST stat.clastab_fil Use-index clastab01 Where
           stat.clastab_fil.class   = n_sclass72       And
           stat.clastab_fil.covcod  = wdetail.covcod No-lock  No-error No-wait.
        IF avail stat.clastab_fil Then do: 
            ASSIGN sic_bran.uwm130.uom1_v  = if int(wdetail.comper)   <> 0 then int(wdetail.comper)   else stat.clastab_fil.uom1_si
                   sic_bran.uwm130.uom2_v  = if int(wdetail.comacc)   <> 0 then int(wdetail.comacc)   else stat.clastab_fil.uom2_si
                   sic_bran.uwm130.uom5_v  = if int(wdetail.deductpd) <> 0 then int(wdetail.deductpd) else stat.clastab_fil.uom5_si
                   sic_bran.uwm130.uom8_v  =  stat.clastab_fil.uom8_si                
                   sic_bran.uwm130.uom9_v  =  stat.clastab_fil.uom9_si          
                   sic_bran.uwm130.uom3_v  =  0
                   sic_bran.uwm130.uom4_v  =  0
                   wdetail.comper          =  string(stat.clastab_fil.uom8_si)                
                   wdetail.comacc          =  string(stat.clastab_fil.uom9_si)
                   nv_uom1_v               =  sic_bran.uwm130.uom1_v   
                   nv_uom2_v               =  sic_bran.uwm130.uom2_v
                   nv_uom5_v               =  sic_bran.uwm130.uom5_v        
                   sic_bran.uwm130.uom1_c  = "D1"
                   sic_bran.uwm130.uom2_c  = "D2"
                   sic_bran.uwm130.uom5_c  = "D5"
                   sic_bran.uwm130.uom6_c  = "D6"
                   sic_bran.uwm130.uom7_c  = "D7".
            If  wdetail.garage  =  "G"  THEN DO:
             ASSIGN WDETAIL2.no_41   = if int(wdetail2.NO_41) <> 0 then wdetail2.NO_41 else string(stat.clastab_fil.si_41pai)                       
                    WDETAIL2.no_42   = if int(wdetail2.NO_42) <> 0 then wdetail2.NO_42 else string(stat.clastab_fil.si_42)                         
                    WDETAIL2.no_43   = if int(wdetail2.NO_43) <> 0 then wdetail2.NO_43 else string(stat.clastab_fil.impsi_43)    
                    WDETAIL2.seat41  =  stat.clastab_fil.dri_41 + stat.clastab_fil.pass_41.     
            END.
            ELSE DO: 
                ASSIGN WDETAIL2.no_41 =  if int(wdetail2.NO_41) <> 0 then wdetail2.NO_41 else string(stat.clastab_fil.si_41unp)
                 WDETAIL2.no_42    =  if int(wdetail2.NO_42) <> 0 then wdetail2.NO_42 else string(stat.clastab_fil.si_42)
                 WDETAIL2.no_43    =  if int(wdetail2.NO_43) <> 0 then wdetail2.NO_43 else string(stat.clastab_fil.si_43)
                 WDETAIL2.seat41   =  stat.clastab_fil.dri_41 + stat.clastab_fil.pass_41.                  
            END.
        END.
        ASSIGN  nv_riskno = 1   nv_itemno = 1.
        IF wdetail.covcod = "1" Then RUN wgs/wgschsum(INPUT  wdetail.policy, 
                             nv_riskno,
                             nv_itemno).
    END.  /* end Do transaction*/
    s_recid3  = RECID(sic_bran.uwm130).
    nv_covcod =   wdetail.covcod.
    nv_makdes  =  wdetail.brand.
    nv_moddes  =  wdetail.model.
    nv_newsck = " ".
    RUN proc_chassic.
    RUN proc_chassic_eng.
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
         sic_bran.uwm301.bchcnt = nv_batcnt  NO-WAIT NO-ERROR.
     IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
         DO TRANSACTION:
             CREATE sic_bran.uwm301.
         END. 
     END. 
     ASSIGN sic_bran.uwm301.policy    = sic_bran.uwm120.policy                 
            sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
            sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
            sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
            sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
            sic_bran.uwm301.itemno    = s_itemno
            sic_bran.uwm301.tariff    = wdetail2.tariff    
            sic_bran.uwm301.covcod    = nv_covcod
            sic_bran.uwm301.cha_no    = wdetail.chasno
            sic_bran.uwm301.trareg    = nv_uwm301trareg
            sic_bran.uwm301.eng_no    = wdetail.eng
            sic_bran.uwm301.Tons      = IF wdetail2.subclass = "320" THEN deci(wdetail.engcc) ELSE INTEGER(wdetail2.weight)
            sic_bran.uwm301.engine    = IF nv_cc <> 0 THEN nv_cc ELSE deci(wdetail.engcc) /*Ranu I. A64-0422 01/10/2021*/
            sic_bran.uwm301.vehgrp    = wdetail.cargrp /*ranu I. A64-0422 01/10/2021*/       
            sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear) 
            sic_bran.uwm301.garage    = wdetail.garage
            sic_bran.uwm301.body      = wdetail.body
            sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
            sic_bran.uwm301.mv_ben83  = wdetail.benname
            sic_bran.uwm301.vehreg    = wdetail.vehreg + nv_provi
            sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
            sic_bran.uwm301.vehuse    = wdetail.vehuse
            sic_bran.uwm301.moddes    = trim(wdetail.brand) + " " + trim(wdetail.model) + " " + trim(wdetail.carcode)    
            sic_bran.uwm301.sckno     = 0
            sic_bran.uwm301.itmdel    = NO
            sic_bran.uwm301.car_color = wdetail.colorcar
            sic_bran.uwm301.logbok    = IF wdetail2.TYPE_notify = "S" AND nv_covcod = "1" THEN "Y" ELSE IF wdetail2.producer = "B3M0070" THEN "Y" /*A67-0065*/ ELSE ""
            /* add by : A68-0061 */
            sic_bran.uwm301.modcod    = wdetail2.redbook
            sic_bran.uwm301.car_year = INT(wdetail.re_year)                                                                
            sic_bran.uwm301.province_reg  = trim(wdetail.re_country) 
            /*sic_bran.uwm301.fuel      = trim(wdetail.fule)*/
            sic_bran.uwm301.watts     = deci(wdetail2.watt) 
            sic_bran.uwm301.maksi     = INTE(wdetail.maksi)      
            /*sic_bran.uwm301.eng_no2   = wdetail.eng_no2  
            sic_bran.uwm301.battper   = INTE(wdetail.battper)*/
            sic_bran.uwm301.battyr    = IF index(wdetail2.subclass,"E") <> 0 THEN inte(wdetail.caryear)  ELSE 0
            /*sic_bran.uwm301.battsi    = DECI(wdetail.battsi)*/
            sic_bran.uwm301.battprice = deci(wdetail.battprice)
            sic_bran.uwm301.battno    = wdetail.battno 
            sic_bran.uwm301.chargno   = wdetail.chargno 
            sic_bran.uwm301.chargsi   = deci(wdetail.chargprice)  
            sic_bran.uwm301.battflg   = IF DECI(wdetail.battprm) <> 0 THEN "Y" ELSE "N"  
            sic_bran.uwm301.chargflg  = IF DECI(wdetail.chargprm) <> 0 THEN "Y" ELSE "N". 
            /* end : A68-0061*/   
            wdetail2.tariff = sic_bran.uwm301.tariff .
     IF wdetail2.accdata <> "" THEN DO:  /*Add A56-0368 ....*/
      RUN proc_prmtxt.
      ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60) =  nv_acc1
          SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  nv_acc2
          SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  nv_acc3
          SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  nv_acc4
          SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  nv_acc5
          SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  nv_acc6. 
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
   ASSIGN  sic_bran.uwm301.bchyr = nv_batchyr       /* batch Year */
           sic_bran.uwm301.bchno = nv_batchno       /* bchno      */
           sic_bran.uwm301.bchcnt= nv_batcnt .     /* bchcnt     */
   IF trim(wdetail.flagno) = "0"  THEN DO: /* 0 = ระบุ 1 = ไม่ระบุ */
      ASSIGN wdetail2.drivnam = "Y" .
      RUN proc_adddriver.  /*A55-0151*/
   END.
   ELSE DO: 
     ASSIGN  wdetail2.drivnam = "N".
     RUN proc_adddriver.
   END.
   ASSIGN s_recid4    = RECID(sic_bran.uwm301).
   IF wdetail2.redbook <> ""  THEN DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE 
         stat.maktab_fil.sclass = wdetail2.subclass  AND
         stat.maktab_fil.modcod = wdetail2.redbook   No-lock no-error no-wait.
        If  avail  stat.maktab_fil  Then 
            ASSIGN sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod 
            sic_bran.uwm301.body    =  stat.maktab_fil.body 
            sic_bran.uwm301.vehgrp  =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
            wdetail.cargrp          =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
            sic_bran.uwm301.engine  =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
            wdetail.engcc           =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
            sic_bran.uwm301.seats   =  IF sic_bran.uwm301.seats = 0  THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
    END.
    IF wdetail2.redbook  = ""  THEN RUN proc_maktab.
    IF index(trim(wdetail.model) +  trim(wdetail.carcode),"HATCHBACK") <> 0 THEN  sic_bran.uwm301.body  = "HATCHBACK".

   
END.
RELEASE brStat.Detaitem.
RELEASE brstat.mailtxt_fil .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest3 C-Win 
PROCEDURE proc_chktest3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  add by : ranu I. A64-0328 ....    
------------------------------------------------------------------------------*/
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "015: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
ASSIGN 
    nv_tariff = sic_bran.uwm301.tariff
    nv_class  = IF wdetail2.poltyp = "v72" THEN wdetail2.subclass ELSE wdetail2.prempa +  wdetail2.subclass
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = DECI(wdetail.engcc)
    nv_tons   = deci(wdetail2.weight)
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse
    nv_COMPER = deci(wdetail.comper) 
    nv_comacc = deci(wdetail.comacc) 
    nv_seats  = INTE(wdetail.seat)
    nv_tons   = DECI(wdetail2.weight)
    /*nv_dss_per = 0   */  
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
    nv_totsi   =   0 .
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
        END.
        Else assign          
            nv_compprm     = 0
            nv_compcod     = " "
            nv_compvar1    = " "
            nv_compvar2    = " "
            nv_compvar     = " ".
        If  nv_compprm  =  0  THEN DO:
            ASSIGN nv_vehuse = "0".     /*A52-0172 ให้ค่า0 เนื่องจากต้องการส่งค่าให้ key.b = 0 */
            RUN wgs\wgscomp.       
        END.
        nv_comacc  = nv_comacc .                  
    END.   /* else do */
    If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0. 
END.       /*compul y*/
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
/*IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) THEN RUN proc_base2plus.   /*A57-0126*/ */ /*A62-0215*/
IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" ) THEN RUN proc_base2plus.  /*A62-0215*/
ELSE RUN proc_base2.

IF wdetail2.poltyp = "v72" THEN DO:
    ASSIGN  
        nv_baseprm = 0   
        nv_usecod  = "" 
        nv_engcod  = "" 
        nv_drivcod = ""
        nv_yrcod   = "" 
        nv_sicod   = "" 
        nv_grpcod  = "" 
        nv_bipcod  = "" 
        nv_biacod  = "" 
        nv_pdacod  = "" 
        nv_class   = SUBSTRING(nv_class,2,3).
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

IF nv_polmaster <> "" THEN DO:
    IF (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN RUN proc_adduwd132Plus.
    ELSE RUN proc_adduwd132.
END.
ELSE DO:
    /*RUN proc_calpremt. */ /*A68-0061*/
    RUN proc_calpremt_all. /*A68-0061*/
    RUN proc_adduwd132prem .
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
        sic_bran.uwm100.imperr = wdetail2.comment.    
END.
FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
     ASSIGN
     sic_bran.uwm120.gap_r  = nv_gapprm
     sic_bran.uwm120.prem_r = nv_pdprm
     sic_bran.uwm120.sigr   = inte(wdetail.si).


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
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "016: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
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
                     sic_bran.uwm120.bchcnt  = nv_batcnt              NO-LOCK .
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
    IF AVAIL   sicsyac.xmm018 THEN DO:
              Assign     /*nv_com1p = sicsyac.xmm018.commsp  */ /*A67-0065*/
                         nv_com1p = IF wdetail2.producer = "B3M0070" THEN 0 ELSE sicsyac.xmm018.commsp /*A67-0065*/
                         nv_com2p = 0.
    END.
    ELSE DO:
            Find sicsyac.xmm031  Use-index xmm03101  Where  
                 sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
            No-lock no-error no-wait.
            IF not  avail sicsyac.xmm031 Then 
              Assign     nv_com1p = 0
                         nv_com2p = 0.
            Else  
              Assign     /*nv_com1p = sicsyac.xmm031.comm1*/ /*A67-0065*/
                         nv_com1p  = IF wdetail2.producer = "B3M0070" THEN 0 ELSE sicsyac.xmm031.comm1 /*A67-0065*/
                         nv_com2p = 0 .
    END. /* Not Avail Xmm018 */
    /* A64-0328 */
    IF n_dstf <> 0 THEN DO: 
        nv_com1p = nv_com1p - n_dstf .  
        IF nv_com1p < 0 THEN  nv_com1p = 0 .
    END.
    /* end : A64-0328 */
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

  /*sic_bran.uwm120.com1ae = YES. */ /*A63-0443*/
  /*sic_bran.uwm120.com2ae = YES. */ /*A63-0443*/
  if sic_bran.uwm100.poltyp = "V70" then sic_bran.uwm120.com1ae = YES.  /*A63-0443*/
  if sic_bran.uwm100.poltyp = "V72" then sic_bran.uwm120.com2ae = YES.  /*A63-0443*/

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
  If avail sic_bran.uwm100 Then DO:
      Assign 
           sic_bran.uwm100.gap_p   = n_gap_t
           sic_bran.uwm100.prem_t  = n_prem_t
           sic_bran.uwm100.sigr_p  = n_sigr_t
           sic_bran.uwm100.instot  = uwm100.instot
           sic_bran.uwm100.com1_t  =  nv_fi_com1_t
           sic_bran.uwm100.com2_t  =  nv_fi_com2_t
           sic_bran.uwm100.pstp    =  0              
           sic_bran.uwm100.rstp_t  =  nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  =  nv_fi_rtax_t 
           sic_bran.uwm100.gstrat  =  nv_fi_tax_per.
  END.
  
  IF wdetail2.poltyp = "v72" THEN DO:
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

        IF wdetail2.poltyp = "v72" THEN DO:
           ASSIGN  
           sic_bran.uwm120.com2_r    = 0 
           sic_bran.uwm120.com1_r    = nv_fi_com2_t
           sic_bran.uwm120.com1p     = nv_com2p
           sic_bran.uwm120.com2p     = 0
           sic_bran.uwm120.rstp_r   = nv_fi_rstp_t 
           sic_bran.uwm120.rtax     = nv_fi_rtax_t.
        END.
  End.
  IF wdetail3.instot > 1 THEN DO:
      ASSIGN 
          nv_com1p_ins        = nv_com1p 
          nv_fi_tax_per_ins   = nv_fi_tax_per  
          nv_fi_stamp_per_ins = nv_fi_stamp_per    . 
      /*RUN proc_instot  .  */
      IF deci(wdetail3.net_re1) = 0 THEN RUN proc_instot1  .
      ELSE RUN proc_instot2  .
  END.
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
/* comment by : Ranu I. A63-0443....
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
/*DEF VAR nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR nv_fi_stamp_per AS DECI INIT 0.00.*/
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
     ASSIGN 
         nv_com1p = nv_dscom .     
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
  If avail sic_bran.uwm100 Then DO:
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
      IF wdetail2.poltyp = "v72" THEN DO:
                ASSIGN  
               sic_bran.uwm100.com2_t  = 0 
               sic_bran.uwm100.com1_t  = nv_fi_com2_t.
      END.
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
        IF wdetail2.poltyp = "v72" THEN 
           ASSIGN  
           sic_bran.uwm120.com2_r    = 0 
           sic_bran.uwm120.com1_r    = nv_fi_com2_t
           sic_bran.uwm120.com1p     = nv_com2p
           sic_bran.uwm120.com2p     = 0
           sic_bran.uwm120.rstp_r   = nv_fi_rstp_t 
           sic_bran.uwm120.rtax     = nv_fi_rtax_t.
  End.

  IF wdetail3.instot > 1 THEN DO:
      ASSIGN 
          nv_com1p_ins        = nv_com1p 
          nv_fi_tax_per_ins   = nv_fi_tax_per  
          nv_fi_stamp_per_ins = nv_fi_stamp_per    . 
      /*RUN proc_instot  .  */
      RUN proc_instot1  .  
  END.
  ... end A63-0443...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest5 C-Win 
PROCEDURE proc_chktest5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_adjprm    AS DECI FORMAT "->>,>>>,>>>,>>9.99"  INITIAL 0  NO-UNDO. 
DEFINE VAR nv_netprm    AS DECI FORMAT "->>,>>>,>>>,>>9.99". 
DEFINE VAR nv_stamp_per AS DECI FORMAT ">9.99%"              INITIAL 0  NO-UNDO. 
DEFINE VAR nv_adtax     AS DECI FORMAT ">>>,>>>,>>9.99-"     INITIAL 0  NO-UNDO.
DEFINE VAR nv_adstmp    AS DECI FORMAT ">>>,>>>,>>9.99-"     INITIAL 0  NO-UNDO. 
DEFINE VAR nv_tptax     AS DECI FORMAT ">>>,>>>,>>9.99-"     INITIAL 0  NO-UNDO. 
DEFINE VAR nv_tpstmp    AS DECI FORMAT ">>>,>>>,>>9.99-"     INITIAL 0  NO-UNDO. 
DEFINE VAR nv_adprem    AS DECI FORMAT ">>>,>>>,>>9.99-"     INITIAL 0  NO-UNDO. 
DEFINE VAR nv_tpprem    AS DECI FORMAT ">>>,>>>,>>9.99-"     INITIAL 0  NO-UNDO. 
DEFINE VAR nv_policy    AS CHAR INIT "".
DEFINE VAR nv_rencnt    AS INTE INIT 0.
DEFINE VAR nv_endcnt    AS INTE INIT 0.
DEFINE VAR n_sigr_r     AS DECI FORMAT ">>>,>>>,>>9.99-"     INITIAL 0  NO-UNDO. 
DEFINE VAR nt_compprm   AS DECI FORMAT ">>>,>>>,>>9.99-"     INITIAL 0  NO-UNDO. 
DEFINE VAR nv_com12_t   AS DECI FORMAT ">>>,>>>,>>9.99-"     INITIAL 0  NO-UNDO. 
DEFINE VAR nv_total     AS DECI FORMAT ">>>,>>>,>>9.99-"     INITIAL 0  NO-UNDO.  
DEFINE VAR nv_difprm    AS DECI FORMAT ">>>,>>>,>>9.99-"     INITIAL 0  NO-UNDO. 
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "017: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
ASSIGN nv_adjprm  = deci(wdetail.prem_r)   .   /*เบี้ยที่ต้องการ    */
FIND sic_bran.uwm100 WHERE Recid(sic_bran.uwm100) = s_recid1 
    NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sic_bran.uwm100 THEN 
    ASSIGN nv_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t  /*เบี้ยที่ระบบคำนวณได้*/
                     + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.
ELSE nv_netprm = 0.

ASSIGN nv_difprm = nv_adjprm - nv_netprm.
IF nv_difprm < 0  THEN nv_difprm = nv_difprm * ( - 1 ).

OUTPUT TO D:\temp\LOG_HondaPremium.TXT APPEND.
PUT
    TODAY             FORMAT "99/99/9999"      " "
    STRING(TIME,"HH:MM:SS")                    "." 
    SUBSTR(STRING(MTIME,">>>>99999999"),10,3)
    "กรมธรรม์:"         wdetail.policyno   FORMAT "X(20)" 
    "เบี้ยที่ต้องการ:"  nv_adjprm          FORMAT ">>>,>>>,>>9.99-"
    "เบี้ยคำนวณ:"       nv_netprm          FORMAT ">>>,>>>,>>9.99-"
    "ส่วนต่าง:"         nv_difprm          FORMAT ">>>,>>>,>>9.99-" 
     SKIP.
OUTPUT CLOSE.

IF (nv_adjprm <> nv_netprm) AND (nv_netprm <> 0) AND (nv_difprm < 10 ) THEN DO:  /*ถ้าเบี้ยไม่เท่ากัน ให้ทำ*/
    /* + - 10  */
    /* s_recid1 = RECID(sic_bran.uwm100) */
    FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1
        no-error no-wait.
    If  not avail sic_bran.uwm100  Then do:
        /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
        OUTPUT TO D:\temp\LOG_HondaPremium.TXT APPEND.
        PUT
            TODAY             FORMAT "99/99/9999"      " "
            STRING(TIME,"HH:MM:SS")                    "." 
            SUBSTR(STRING(MTIME,">>>>99999999"),10,3)
            "กรมธรรม์:"         wdetail.policyno   FORMAT "X(20)" 
            "Error Return"       FORMAT "X(20)"  
            SKIP.
        OUTPUT CLOSE.

        Return.
    END.
    ELSE DO:
        ASSIGN 
            nv_stamp_per = 0.4
            nv_tax_per   = 7.0. 
        nv_adtax = ROUND((nv_adjprm * nv_tax_per) / (nv_tax_per + 100),2).          
        nv_adstmp = ((nv_adjprm - nv_adtax) * nv_stamp_per) / (nv_stamp_per + 100).     
        /*-- Stamp --*/
        IF nv_adstmp - TRUNCATE(nv_adstmp,0) > 0 THEN nv_adstmp = TRUNCATE(nv_adstmp,0) + 1.
        ELSE nv_adstmp = TRUNCATE(nv_adstmp,0).
        /*-- Premium --*/
        nv_adprem = nv_adjprm - nv_adtax - nv_adstmp.
        /*-- ถอยเบี้ยคืน --*/
        /*-- Stamp --*/
        nv_tpstmp = (nv_adprem * nv_stamp_per) / 100.
        IF nv_tpstmp - TRUNC(nv_tpstmp,0) > 0 THEN nv_tpstmp = TRUNC(nv_tpstmp,0) + 1.
        ELSE nv_tpstmp = TRUNC(nv_tpstmp,0).
        /*-- Vat --*/
        nv_tptax = (nv_adprem + nv_tpstmp) * nv_tax_per / 100.     
        /*-- Net Premium --*/
        nv_tpprem = nv_adprem + nv_tpstmp + nv_tptax.
        Assign 
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt.
        FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE
            sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
            sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm120.bchyr   = nv_batchyr              AND 
            sic_bran.uwm120.bchno   = nv_batchno              AND 
            sic_bran.uwm120.bchcnt  = nv_batcnt               NO-ERROR NO-WAIT.
        IF AVAIL sic_bran.uwm120 THEN DO:
            FIND FIRST sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                sic_bran.uwm130.bchyr = nv_batchyr              AND 
                sic_bran.uwm130.bchno = nv_batchno              AND 
                sic_bran.uwm130.bchcnt  = nv_batcnt     NO-LOCK NO-ERROR.
            IF AVAIL sic_bran.uwm130 THEN DO:      
                n_sigr_r                = n_sigr_r + sic_bran.uwm130.uom6_v.
                FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE 
                    sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                    sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                    sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                    sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                    sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                    sic_bran.uwd132.bchyr   = nv_batchyr              AND 
                    sic_bran.uwd132.bchno   = nv_batchno              AND 
                    sic_bran.uwd132.bchcnt  = nv_batcnt          .
                    IF sic_bran.uwd132.bencod = "411" THEN DO:
                        IF nv_polday = 365 OR nv_polday = 366 THEN DO:
                            sic_bran.uwd132.gap_c  = sic_bran.uwd132.gap_c + (nv_adprem - sic_bran.uwm100.prem_t).
                            sic_bran.uwd132.prem_c = TRUNCATE((sic_bran.uwd132.gap_c * nv_polday) / 365,2).
                        END.
                        ELSE DO:
                            sic_bran.uwd132.prem_c = sic_bran.uwd132.prem_c + (nv_adprem - sic_bran.uwm100.prem_t).
                        END.
                    END.
                END.  /* buwd132 */
            END.   /* buwm130 */
            IF  nv_polday = 365 OR nv_polday = 366 THEN DO:
                ASSIGN
                    sic_bran.uwm120.gap_r  = nv_adprem
                    sic_bran.uwm120.prem_r = (nv_adprem * nv_polday) / 365
                    /*sic_bran.uwm120.gap_p  = nv_adprem 
                    sic_bran.uwm120.prem_t = (nv_adprem * nv_polday) / 365 */    .
            END.
            ELSE DO:
                sic_bran.uwm120.prem_r = nv_adprem.
                /*sic_bran.uwm120.prem_t = nv_adprem.*/
            END.
            Assign 
                sic_bran.uwm100.prem_t  = nv_adprem . /*ranu : A64-0274 */

            IF (((sic_bran.uwm100.prem_t * nv_stamp_per) / 100) - TRUNCATE(sic_bran.uwm100.prem_t * nv_stamp_per / 100,0)) > 0 THEN DO:
                sic_bran.uwm100.rstp_t  = TRUNCATE(sic_bran.uwm100.prem_t * nv_stamp_per / 100,0) + 1.
            END.
            ELSE sic_bran.uwm100.rstp_t  = TRUNCATE(sic_bran.uwm100.prem_t * nv_stamp_per / 100,0) .

            sic_bran.uwm100.rtax_t    = (sic_bran.uwm100.prem_t + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp) * nv_tax_per  / 100.
            sic_bran.uwm100.com1_t    = - (sic_bran.uwm100.prem_t - nt_compprm) * sic_bran.uwm120.com1p / 100. 
            sic_bran.uwm100.com2_t    = - nt_compprm * sic_bran.uwm120.com2p / 100.
            nv_com12_t = sic_bran.uwm100.com1_t + sic_bran.uwm100.com2_t.
        END.  /* sic_bran.uwm120 */

        IF nv_adjprm > nv_adprem OR nv_adjprm < nv_adprem THEN sic_bran.uwm100.rtax_t = nv_adjprm - (sic_bran.uwm100.prem_t + sic_bran.uwm100.rstp_t).
        nv_netprm   = sic_bran.uwm100.prem_t  +  sic_bran.uwm100.rtax_t
                    + sic_bran.uwm100.rstp_t  +  sic_bran.uwm100.pstp.
        nv_total    = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t +
                      sic_bran.uwm100.pstp   + sic_bran.uwm100.rstp_t.
        FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE
            sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
            sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm120.bchyr   = nv_batchyr              AND 
            sic_bran.uwm120.bchno   = nv_batchno              AND 
            sic_bran.uwm120.bchcnt  = nv_batcnt               NO-ERROR NO-WAIT.
        IF AVAIL sic_bran.uwm120 THEN DO:
            ASSIGN
                sic_bran.uwm120.com1_r    = sic_bran.uwm100.com1_t
                sic_bran.uwm120.com2_r    = sic_bran.uwm100.com2_t
                sic_bran.uwm120.rstp_r    = sic_bran.uwm100.rstp_t
                sic_bran.uwm120.rtax_r    = sic_bran.uwm100.rtax_t.
        END.  
    END.  /* AVAIL sic_bran.uwm100 */
END.  /*nv_adjprm <> nv_netprm*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ckvehreg C-Win 
PROCEDURE proc_ckvehreg :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_vehreg AS CHAR INIT "".
ASSIGN nv_vehreg =  trim(wdetail.vehreg) .
IF nv_vehreg <> "" AND SUBSTR(nv_vehreg,1,1) <> "/" THEN DO:

    IF   INDEX(nv_vehreg," ")  = 0  THEN
        ASSIGN wdetail2.comment = wdetail2.comment + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " ติดกัน"  
        wdetail2.pass    = "N"  
        WDETAIL2.OK_GEN  = "N".
    ELSE IF INDEX(nv_vehreg,".") <> 0  THEN
        ASSIGN wdetail2.comment = wdetail2.comment + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " มีจุด"  
        wdetail2.pass    = "N"  
        WDETAIL2.OK_GEN  = "N".
    ELSE IF INDEX(nv_vehreg,"้") <> 0  THEN  
        ASSIGN wdetail2.comment = wdetail2.comment + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " มี ้"  
        wdetail2.pass    = "N"  
        WDETAIL2.OK_GEN  = "N".
    ELSE IF INDEX(nv_vehreg,"๊") <> 0  THEN 
        ASSIGN wdetail2.comment = wdetail2.comment + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " มี๊"  
        wdetail2.pass    = "N"  
        WDETAIL2.OK_GEN  = "N".
    ELSE IF INDEX(nv_vehreg,"๋") <> 0  THEN 
        ASSIGN wdetail2.comment = wdetail2.comment + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " มี๋"  
        wdetail2.pass    = "N"  
        WDETAIL2.OK_GEN  = "N".
    ELSE DO:
        IF INDEX("123456789",SUBSTR(nv_vehreg,1,1)) <> 0  THEN DO: 
            IF  SUBSTR(nv_vehreg,2,1) = "" THEN  
                ASSIGN wdetail2.comment = wdetail2.comment + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " ตำแหน่งที่สอง ค่าว่าง"  
                wdetail2.pass    = "N"  
                WDETAIL2.OK_GEN  = "N".
            ELSE DO:                                                       
                IF  SUBSTR(nv_vehreg,3,2) = "" THEN  
                    ASSIGN wdetail2.comment = wdetail2.comment + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " ตำแหน่งที่สามสี่ ค่าว่าง"   
                    wdetail2.pass    = "N"  
                    WDETAIL2.OK_GEN  = "N".
                ELSE IF  SUBSTR(nv_vehreg,4,2) = "" THEN  
                    ASSIGN wdetail2.comment = wdetail2.comment + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " ตำแหน่งที่สี่ห้า ค่าว่าง"  
                    wdetail2.pass    = "N"  
                    WDETAIL2.OK_GEN  = "N".
            END.
        END.
        ELSE DO: /*    "ขง 9999".     */                                   
            IF  SUBSTR(nv_vehreg,2,2) = "" THEN  
                ASSIGN wdetail2.comment = wdetail2.comment + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg +  " ตำแหน่งที่สองสาม ค่าว่าง"  
                wdetail2.pass    = "N"  
                WDETAIL2.OK_GEN  = "N".
            ELSE IF  SUBSTR(nv_vehreg,3,2) = "" THEN  
                ASSIGN wdetail2.comment = wdetail2.comment + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg +  " ตำแหน่งที่สามสี่ ค่าว่าง"   
                wdetail2.pass    = "N"  
                WDETAIL2.OK_GEN  = "N".
        END.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_clearmailtxt C-Win 
PROCEDURE proc_clearmailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A68-0061       
------------------------------------------------------------------------------*/
DEF VAR n_length AS INTE INIT 0 .

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
/*Kridtiya i. A66-0047*/
DEF VAR np_colorcode AS CHAR INIT "".
np_colorcode = "".

IF wdetail.colorcar <> "" THEN DO:
    ASSIGN np_colorcode = trim(wdetail.colorcar).
         IF np_colorcode = "LUNAR SILVER METALIC"           THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "SONIC GRAY P."                  THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "PHOENIX ORANGE PEARL"           THEN np_colorcode = "ส้ม".
    ELSE IF np_colorcode = "CRYSTAL BLACK PEARL"            THEN np_colorcode = "ดำ". 
    ELSE IF np_colorcode = "OBSIDIAN BLUE"                  THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "COSMIC BLUE METALLIC"           THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "BRILLIANT SPORTY BULE METALLIC" THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "MORNING MIST BLUE METALLIC"     THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "RALLYE RED PEARL"               THEN np_colorcode = "แดง".
    ELSE IF np_colorcode = "PASSION RED PEARL"              THEN np_colorcode = "แดง".
    ELSE IF np_colorcode = "IGNITE RED METALLIC"            THEN np_colorcode = "แดง".
    ELSE IF np_colorcode = "IGNITE RED METALLIC/BLACK ROOF" THEN np_colorcode = "แดง".
    ELSE IF np_colorcode = "METEOROID GRAY"                 THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "MODERN STEEL METALLIC"          THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "SONIC GRAY P."                  THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "RUSE BLACK METALLIC"            THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "METEOROID GRAY"                 THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "PREMIUM WHITE PERAL"            THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "TAFFETA WHITE"                  THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "WHITE ORCHID PEARL"             THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "PREMIUM SUNLIGHT WHITE PEARL"   THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "RACING BLUE PEARL"              THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "SILVER"                         THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "SILVER"                         THEN np_colorcode = "เทา". 
    ELSE IF np_colorcode = "ORANGE"                         THEN np_colorcode = "ส้ม". 
    ELSE IF np_colorcode = "BLACK1"                         THEN np_colorcode = "ดำ".  
    ELSE IF np_colorcode = "BLUE"                           THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "BLUE"                           THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "BLUE"                           THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "BLUE"                           THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "RED"                            THEN np_colorcode = "แดง". 
    ELSE IF np_colorcode = "RED"                            THEN np_colorcode = "แดง". 
    ELSE IF np_colorcode = "RED"                            THEN np_colorcode = "แดง".
    ELSE IF np_colorcode = "RED+BLACK"                      THEN np_colorcode = "แดง".
    ELSE IF np_colorcode = "GRAY 1"                         THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "GRAY 1"                         THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "GRAY 1"                         THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "GRAY2"                          THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "GRAY2"                          THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "WHITE"                          THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "WHITE"                          THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "WHITE"                          THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "BROWN"                          THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "BLUE"                           THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "LUS"                            THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "SNG"                            THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "PHO"                            THEN np_colorcode = "ส้ม".
    ELSE IF np_colorcode = "CBL"                            THEN np_colorcode = "ดำ".
    ELSE IF np_colorcode = "OSB"                            THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "CBM"                            THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "BSB"                            THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "MMB"                            THEN np_colorcode = "น้ำเงิน".
    ELSE IF np_colorcode = "RLR"                            THEN np_colorcode = "แดง".
    ELSE IF np_colorcode = "PAR"                            THEN np_colorcode = "แดง".
    ELSE IF np_colorcode = "IGR"                            THEN np_colorcode = "แดง".
    ELSE IF np_colorcode = "IRB"                            THEN np_colorcode = "แดง".
    ELSE IF np_colorcode = "MTG"                            THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "MST"                            THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "SNG"                            THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "RUB"                            THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "MTG"                            THEN np_colorcode = "เทา".
    ELSE IF np_colorcode = "PMW"                            THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "TTW"                            THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "WOR"                            THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "PSW"                            THEN np_colorcode = "ขาว".
    ELSE IF np_colorcode = "RCB"                            THEN np_colorcode = "น้ำเงิน".

    FIND LAST sicsyac.sym100 USE-INDEX sym10001 WHERE 
        sym100.tabcod = "U118"  AND 
        sym100.itmcod = trim(np_colorcode)  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
    ELSE DO:
        FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
            sym100.tabcod = "U118"  AND 
            sym100.itmdes = trim(np_colorcode) 
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
        ELSE DO:
            FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                sym100.tabcod = "U118"  AND 
                index(sym100.itmdes,trim(np_colorcode)) <> 0  
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
            ELSE DO:
                FIND LAST sicsyac.sym100 USE-INDEX sym10001 WHERE 
                    sym100.tabcod = "U119"  AND 
                    sym100.itmcod = trim(np_colorcode)  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                ELSE DO:
                    FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                        sym100.tabcod = "U119"  AND 
                        sym100.itmdes = trim(np_colorcode)  
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                    ELSE DO:
                        FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                            sym100.tabcod = "U119"  AND 
                            index(sym100.itmdes,trim(np_colorcode)) <> 0  
                            NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
    
                    END.
                END.
            END.
        END.
    END.
    wdetail.colorcar = np_colorcode. 
END.

/*Kridtiya i. A66-0047*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createpro C-Win 
PROCEDURE proc_createpro :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wimproducer.
    DELETE wimproducer.
END.
/*
CREATE wimproducer. 
ASSIGN wimproducer.saletype = "C" wimproducer.camname = "CITY 18,990" wimproducer.notitype = "N" wimproducer.producer = "B3M0016".  
CREATE wimproducer. 
ASSIGN wimproducer.saletype = "C" wimproducer.camname = "Plus"        wimproducer.notitype = "N" wimproducer.producer = "B3M0022".  
CREATE wimproducer. 
ASSIGN wimproducer.saletype = "N" wimproducer.camname = ""            wimproducer.notitype = "N" wimproducer.producer = "B3M0019".
CREATE wimproducer. 
ASSIGN wimproducer.saletype = "N" wimproducer.camname = ""            wimproducer.notitype = "S" wimproducer.producer = "B3M0017".  
CREATE wimproducer. 
ASSIGN wimproducer.saletype = "N" wimproducer.camname = ""            wimproducer.notitype = "R" wimproducer.producer = "B3M0017".
CREATE wimproducer. 
ASSIGN wimproducer.saletype = "S" wimproducer.camname = ""            wimproducer.notitype = "N" wimproducer.producer = "B3M0017".  
CREATE wimproducer. 
ASSIGN wimproducer.saletype = "N" wimproducer.camname = ""            wimproducer.notitype = "S" wimproducer.producer = "B3M0017".  
CREATE wimproducer. 
ASSIGN wimproducer.saletype = "S" wimproducer.camname = ""            wimproducer.notitype = "R" wimproducer.producer = "B3M0017".  
CREATE wimproducer. 
ASSIGN wimproducer.saletype = "S" wimproducer.camname = ""            wimproducer.notitype = "S" wimproducer.producer = "B3M0017".  
*/
FOR EACH brstat.insure USE-INDEX Insure03 WHERE brstat.insure.compno  =  fi_campaign   NO-LOCK.
    FIND LAST wimproducer WHERE wimproducer.idno = brstat.insure.lname NO-ERROR NO-WAIT.
    IF NOT AVAIL wimproducer THEN DO:
        CREATE wimproducer. 
        ASSIGN
            wimproducer.idno     = brstat.insure.lname 
            wimproducer.saletype = brstat.Insure.InsNo
            wimproducer.camname  = brstat.insure.vatcode 
            wimproducer.notitype = brstat.insure.text4   
            wimproducer.producer = brstat.insure.Text1 .
    END.
END.
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
DEF BUFFER buwm101 FOR wdetail2.

    OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
    PUT "001: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
    OUTPUT CLOSE.


    len = LENGTH(wdetail.policyno).
    FOR EACH buwm100 WHERE substr(buwm100.policy,2,len) = SUBSTR(wdetail.policyno,2,len) AND
                           buwm100.policy  <> wdetail.policyno  NO-LOCK.
        FOR EACH buwm101 WHERE buwm101.policy = buwm100.policy NO-LOCK .
            ASSIGN 
                wdetail2.cr_2 = buwm100.policy.
            IF wdetail2.poltyp = "v72"  THEN DO:
                ASSIGN 
                    wdetail2.producer  = buwm101.producer
                    wdetail2.producer2 = buwm101.producer2
                    wdetail.si         = buwm100.si.
            END.
        END.
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
    wdetail.prepol = trim(nv_c) .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_definition C-Win 
PROCEDURE proc_definition :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
/*modify by  : Kridtiya i. A53-0100  date. 01/04/2010  
             ปรับส่วนของการให้ค่า รายละเอียดรุ่นรถ เป็นการให้ค่า ซ้ำ */
/*modify by  : Kridtiya i. A53-0171 date 26/05/2010 เพิ่ม วันที่รับเงิน */
/*modify by  : Kridtiya i. A53-0220 date 22/07/2010 ปรับรับเลขทะเบียนจากเทคไฟล์*/
/*modify by  : Kridtiya i. A53-0303 date 30/09/2010 ปรับปีรถจาก รุ่นปีเป็นปีที่จดทะเบียน*/
/*modify by  : Kridtiya i. A53-0371 date 18/11/2010 ปรับส่วนจังหวัดที่จดทะเบียนให้รับจากพารามิเตอร์*/
/*modify by  : Kridtiya i. A53-0406 date 29/12/2010 ปรับรหัสเรดบุคให้งาน 70/72 ได้รหัสเดียวกัน*/
/*modify by  : Kridtiya i. A54-0125 date 18/05/2011 ปรับเงื่อนไขการให้ค่าสาขากรณีเจอรหัสไฟแนนส์ให้เช็คที่รหัสดีเลอร์แทน*/
/*modify by  : Kridtiya i. A54-0167 date. 21/06/2011 กรณีที่เป็นรถปีที่ 4-5  ให้โชว์ คำว่า AA2 เพื่อใส่ในช่อง  promotion*/*/
/*modify by  : kridtiya.i  A55-0043 เพิ่มฟิล์ด การจ่าย,ธนาคาร */
/*modify by  : kridtiya.i  A55-0151 เพิ่มเงื่อนไขการให้ค่ารหัสตัวแทน Producer code: โดยให้ค้นหาข้อมูลตามแคมเปญ */
/*modify by  : kridtiya.i  A55-0190 ปรับขยายเลขที่สัญญา จาก 11 หลักเป็น 20
             และเพิ่มขนาดตัวแปรที่เก็บค่า หมายเหตุ จาก 255 ตัวอักษร เป็น 512 ตัวอักษร                        */
/*modify by  : kridtiya i.  A55-0274 เพิ่มการเก็บอาชีพผู้เอาประกันภัย    */ 
/*modify by  : Kridtiya i. A55-0268 เพิ่มการเก็บวันเกิดผู้เอาประกัน      */
/*modify by  : Kridtiya i. A55-0268 เพิ่มข้อมูลผู้เอาประกันภัย insurce="" not create xmm600     */
/*modify by  : Kridtiya i. A54-0112 ขยายช่องทะเบียนรถ จาก 10 เป็น 11 หลัก          */
/*modify by  : Kridtiya i. A56-0318 เพิ่มการรับค่า ประเภทการแจ้งงาน,ราคารวมอุปกรณ์เสริม,รายละเอียดอุปกรณ์เสริม        */
/*modify by  : kridtiya i. A56-0368 เพิ่มรายละเอียดอุปกรณ์เสริม*/
/*Modify by  : Kridtiya i. A56-0047 Add check sicsyac.xmm600.clicod   = "IN"             */
/*Modify by  : Kridtiya i. A57-0073 เพิ่มรหัสสาขาผู้เอาประกันภัย */
/*Modify by  : Kridtiya i. A57-0126 Date. 08/04/2014 เพิ่มการเก็บข้อมูล รายละเอียดแคมเปญลงไฟล์  insure */
/*modify by  : Kridtiya i. A57-0282 date. 05/08/2014 เพิ่มการบันทุกข้อความ F17 for branch D = "NO-MN30 คุ้มครองภัยก่อการร้าย"*/
/*modify by  : Kridtiya i. A57-0396 date. 03/11/2014 ปิดส่วนการให้ค่า รหัสสาขาออกแวท */
/*modify by  : Kridtiya i. A58-0115 date. 16/03/2015 กรณีงานต่ออายุให้ ใช้ทะเบียน,เลขถัง,เลขเครื่งจากไฟล์ */
/*Modify By  : Ranu I. A58-0419  Date.04/11/2015   เพิ่ม field รับข้อมุล เลขที่แคมเปญ , ประเภทการชำระเบี้ย  */
/*            เลขที่แคมเปญ เก็บลง memo text , ประเภทการชำระเงิน แสดงในช่อง Prom ...                        */
/*Modify By : Ranu I. A59-0020  date. 15/01/2016   แก้ไขช่อง Product  จากเดิมที่มีคำว่า  MONDAIL  เป็น  IPA */
/*Modify By : Benjaporn J. A59-0118  date. 29/03/2016   แก้ไขประเภทความคุ้มครองเป็น ป.1 และ การแจ้งงานเป็น S ให้ใช้โค้ด B3M0038/B300125
              ประเภทความคุ้มครองเป็น ป.2 3 2+ 3+  การแจ้งงานเป็น S, R, N ให้ใช้โค้ด B3M0023/B300125   */
/*Modify BY : Sarinya c. A59-0414 แก้ไข เก็บรายละเอียดแคมเปญลงในช่อง Product */
/*Modify by : Ranu I. A60-0085 แก้ไขงานต่ออายุโค้ด B3M0038 ให้ดึงโค้ดเดิม */
/*Modify by : Ranu I. A60-0505 date: 30/11/2017 เพิ่มการเก็บข้อมูล แคมเปญในช่อง promotion และ เช็คเงื่อนไขเข็ค Body ของ  CIVIC*/
/*modify by : Ranu I. A61-0324 date : 04/07/2017 เพิ่มเงื่อนไขของแคมเปญ super pack  */
/*modify by : Kridtiya i. A61-0481 ปรับส่วน การ แสดงข้อมูล รหัส รถ พรบ.จากเดิม แสดงค่ะ เป็น รหัส 110 ปรับแก้ไขเป็น ให้ตาม รหัส กรมธรรม์ ภาคสมัครใจ */
/*modify by : Ranu I. A62-0493 เพิ่มแคมเปญ Triple pack , แก้ไข Product IPA และ เช็คเงื่อนไข Vat code*/
/*modify by : Ranu I. A63-0006 เช็คเงื่อนไข /และหรือ ของ B3M0037 */
/*Modify by : Ranu I. a63-0112 เพิ่มเงื่อนไขการเช็คกรมธรรม์ที่คุ้มครอง ตั้งแต่ 01/04/2020 ใช้ pack T */
/*Modify by : Kridtiya i. A63-0206 Date. 13/05/2020 เพิ่มการแสดงค่า Claimdi สำหรับ งานประเภท 2+ 3+ รถยี่ห้อ Honda อายุ 4-7ปี โค๊ด B3M0017 / B3M0038 / B300125  */
/*Modify by : Ranu I. A63-0443 แก้ไข Producer/Agent code และเพิ่มการเช็คเบี้ยตามแคมเปญงาน 2+3+ ,Process campaign HEI20-H ใหม่เนื่องจากมีการปรับเบี้ย*/
/*Modify by : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify By : Tontawan S. A64-0274 02/07/2021 Check Data ในช่อง รายละเอียดแคมเปญ ในไฟล์โหลด เพิ่มเงื่อนไขของแคมเปญ                                   */
/*Modify by : Ranu I. A64-0328  date.27/08/2021 เพิ่มการเก็บข้อมูลผู้ขับขี่จากใบเตือน และเพิ่มการคำนวณเบี้ยที่โปรแกรมกลาง*/
/*Modify by : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by : Kridtiya i. A65-0035 comment message error premium not on file */
/*Modify by : Kridtiya i. A65-0139 นำเข้า งานพรบ อย่างเดียว*/
/*Modify by : Kridtiya i. A65-0267 เพิ่ม ทางเลือก กรณี ไม่เจอเงื่อนไข แคมเปญ ให้รับค่าหน้าจอ*/
/*Modify by : Kridtiya i. A65-0379 เพิ่มเงือนไข รถอายุ มากว่า 7 ปี เข้ารหัส B3M0062 */
/*Modify by : Kridtiya i. A66-0087 เพิ่ม สีรถ */
/*Modify by : Kridtiya i. A66-0162 เพิ่ม  (รายละเอียดแคมเปญ) แสดงคำว่า "TMSTH 0% " และปรับเงื่อนไขการแสดง Producer */
/*modify by : Kridtiya i. A66-0266 เพิ่มการหารหัสตัวแทน*/
/*modify by : Kridtiya i. A66-0266 ปรับการ connection to parameter*/
/*Modify by : Ranu I. A67-0065 เพิ่มเงื่อนไขของ producer B3M0070 และ B3M0071 */
/*modify by : Kridtiya i. A67-0100  งานต่ออายุกรณี ประเภทไม่ตรงกัน ให้ใช้ข้อมูลในไฟล์ เช็คทะเบียน */
/*modify by : Kridtiya i. A67-0160  ปรับการแปลง การซ่อมหลังที่ค้นหารหัสตัวแทนเรียบร้อย */
/*modify by : Kridtiya i. A67-0211  ปรับการรับค่า รหัสสาขา รหัส Redbook */
/*-------------------------------------------------------------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_detailcampromo C-Win 
PROCEDURE proc_detailcampromo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF (INDEX(wdetail2.detailcam,"TMSTH 0%") <> 0 ) OR (INDEX(wdetail2.detailcam,"TMSTH0%") <> 0 ) THEN ASSIGN wdetail2.special2 = "TMSTH 0%".
ELSE IF INDEX(wdetail2.detailcam,"DEMON_H") <> 0 THEN ASSIGN wdetail2.special2 = "DEMON_H".
ELSE IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 4 ) AND (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 7 ) AND
    (wdetail2.poltyp = "v70") AND (trim(wdetail.brand) = "HONDA") AND (wdetail.garage <> "") THEN DO:
    IF  wdetail.covcod = "1"  THEN DO: 
        IF DATE(wdetail.comdat) < 01/01/2020 THEN wdetail2.special2 = "IPA". ELSE wdetail2.special2 = "CLAIMDI".  
    END.
    ELSE IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.1") OR (wdetail.covcod = "3.2") THEN DO:
        /* A67-0065 ...
        IF wdetail2.producer = "B3M0062" OR wdetail2.producer = "B3M0064" OR wdetail2.producer = "B3M0065" OR wdetail2.producer = "B3M0058" THEN DO: /*A63-0443*/
            IF DATE(wdetail.comdat) < 01/01/2020 THEN wdetail2.special2 = "IPA". ELSE wdetail2.special2 = "CLAIMDI". 
        END.
        ...end A67-0065*/
        IF      wdetail2.producer = "B3M0062" then assign wdetail2.special2 = "CLAIMDI". 
        ELSE IF wdetail2.producer = "B3M0064" then assign wdetail2.special2 = "CLAIMDI". 
        else if wdetail2.producer = "B3M0065" then assign wdetail2.special2 = "CLAIMDI". 
        else if wdetail2.producer = "B3M0058" THEN assign wdetail2.special2 = "CLAIMDI". 
        ELSE IF wdetail2.producer = "B3M0070" THEN assign wdetail2.special2 = "CLAIMDI". 
        ELSE wdetail2.special2 = "".
    END.
    ELSE wdetail2.special2 = " ".
END.
ELSE IF wdetail2.detailcam <> "" THEN DO: 
    IF      INDEX(wdetail2.detailcam,"super pack-hd")  <> 0 THEN ASSIGN wdetail2.special2 = "SUPER PACK-HD".
    ELSE IF INDEX(wdetail2.detailcam,"super pack-h1")  <> 0 THEN ASSIGN wdetail2.special2 = "SUPER PACK-H1".
    ELSE IF INDEX(wdetail2.detailcam,"super pack-h")   <> 0 THEN ASSIGN wdetail2.special2 = "SUPER PACK-H".
    ELSE IF INDEX(wdetail2.detailcam,"super pack")     <> 0 THEN ASSIGN wdetail2.special2 = "SUPER PACK".
    ELSE IF INDEX(wdetail2.detailcam,"Triple pack_h1") <> 0 THEN ASSIGN wdetail2.special2 = "TRIPLE PACK-H1".
    ELSE IF INDEX(wdetail2.detailcam,"Triple pack")    <> 0 THEN ASSIGN wdetail2.special2 = "TRIPLE PACK".
    ELSE IF INDEX(wdetail2.detailcam,"N1-EV")    <> 0 THEN ASSIGN wdetail2.special2 = "N1-EV".  /*A67-0065 */
END.
ELSE wdetail2.special2 = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initdataex C-Win 
PROCEDURE proc_initdataex :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    wf_policyno          = ""   /* เลขที่ใบคำขอ */
    wf_n_branch          = ""   /* สาขา     */
    wf_n_delercode       = ""   /* รหัสดีเลอร์  */
    wf_vatcode           = ""   /* Vat code.    */
    wf_cndat             = ""   /*  วันที่ใบคำขอ        */
    wf_appenno           = ""   /*  เลขที่รับแจ้ง       */
    wf_comdat            = ""   /*  วันที่เริ่มคุ้มครอง */
    wf_expdat            = ""   /*  วันที่สิ้นสุด       */
    wf_comcode           = ""   /*  รหัสบริษัทประกันภัย */
    wf_cartyp            = ""   /*  ประเภทรถ    */
    wf_saletyp           = ""   /*  ประเภทการขาย        */
    wf_campen            = ""   /*  ประเภทแคมเปญ        */
    wf_freeamonth        = ""   /* จำนวนเงินให้ฟรี      */
    wf_covcod            = ""   /* ประเภทความคุ้มครอง   */
    wf_typcom            = ""   /* ประเภทประกัน         */
    wf_garage            = ""   /* ประเภทการซ่อม        */
    wf_bysave            = ""   /* ผู้บันทึก    */
    wf_tiname            = ""   /* คำนำหน้า     */
    wf_insnam            = ""   /* ชื่อลูกค้า   */
    wf_name2             = ""   /* ชื่อกลาง     */
    wf_name3             = ""    /*     นามสกุล         */
    wf_addr              = ""    /*     ที่อยู่         */
    wf_road              = ""    /*     ถนน     */
    wf_tambon            = ""    /*     ตำบล    */
    wf_amper             = ""    /*     อำเภอ   */
    wf_country           = ""    /*     จังหวัด         */
    wf_post              = ""    /*     รหัสไปรษณีย์    */
    wf_occup             = ""    /*     อาชีพ   */
    wf_birthdat          = ""    /*     วันเกิด */
    wf_icno              = ""    /*     เลขที่บัตรประชาชน       */
    wf_driverno          = ""    /*     เลขที่ใบขับขี่  */
    wf_brand             = ""    /*     ยี่ห้อรถ        */
    wf_cargrp            = ""    /*     กลุ่มรถยนต์     */
    wf_chasno            = ""    /*     หมายเลขตัวถัง   */
    wf_eng               = ""    /*     หมายเลขเครื่อง  */
    wf_model             = ""    /*     ชื่อรุ่นรถ      */
    wf_caryear           = ""    /*     รุ่นปี  */
    wf_carcode           = ""    /*     ชื่อประเภทรถ    */
    wf_body              = ""    /*     แบบตัวถัง       */
    wf_vehuse            = ""    /*     รหัสประเภทรถ    */
    wf_carno             = ""    /*     รหัสลักษณะการใช้งาน     */
    wf_seat              = ""    /*     จำนวนที่นั่ง    */
    wf_engcc             = ""    /*     ปริมาตรกระบอกสูบ        */
    wf_colorcar          = ""    /*     ชื่อสีรถ        */
    wf_vehreg            = ""    /*     เลขทะเบียนรถ    */
    wf_re_country        = ""    /*     จังหวัดที่จดทะเบียน     */
    wf_re_year           = ""    /*     ปีที่จดทะเบียน  */
    wf_nmember           = ""    /*     หมายเหตุ        */
    wf_si                = ""    /*     วงเงินทุนประกัน */
    wf_premt             = ""    /*     เบี้ยประกัน     */
    wf_rstp_t            = ""    /*     อากร    */
    wf_rtax_t            = ""    /*     จำนวนเงินภาษี   */
    wf_prem_r            = ""    /*     เบี้ยประกันรวม  */
    wf_gap               = ""    /*     เบี้ยประกันรวมทั้งหมด   */
    wf_ncb               = ""    /*     อัตราส่วนลดประวัติดี    */
    wf_ncbprem           = ""    /*     ส่วนลดประวัติดี */
    wf_stk               = ""    /*     หมายเลขสติ๊กเกอร์       */
    wf_prepol            = ""    /*     เลขที่กรมธรรม์เดิม      */
    wf_flagname          = ""    /*     flag ระบุชื่อ   */
    wf_flagno            = ""    /*     flag ไม่ระบุชื่อ        */
    wf_ntitle1           = ""    /*     คำนำหน้า        */
    wf_drivername1       = ""    /*     ชื่อผู้ขับขี่คนที่1     */
    wf_dname1            = ""    /*     ชื่อกลาง        */
    wf_dname2            = ""    /*     นามสกุล */
    wf_docoup            = ""    /*     อาชีพ   */
    wf_dbirth            = ""    /*     วันเกิด */
    wf_dicno             = ""    /*     เลขที่บัตรประชาชน       */
    wf_ddriveno          = ""    /*     เลขที่ใบขับขี่  */
    wf_ntitle2           = ""    /*     คำนำหน้า2       */
    wf_drivername2       = ""    /*     ชื่อผู้ขับขี่คนที่2     */
    wf_ddname1           = ""    /*     ชื่อกลาง2       */
    wf_ddname2           = ""    /*     นามสกุล2        */
    wf_ddocoup           = ""    /*     อาชีพ2  */
    wf_ddbirth           = ""    /*     วันเกิด2        */
    wf_ddicno            = ""    /*     เลขที่บัตรประชาชน2      */
    wf_dddriveno         = ""    /*     เลขที่ใบขับขี่2 */
    wf_benname           = ""    /*     ผู้รับผลประโยชน์        */
    wf_comper            = ""    /*     ความเสียหายต่อชีวิต(บาท/คน)     */
    wf_comacc            = ""    /*     ความเสียหายต่อชีวิต(บาท/ครั้ง)  */
    wf_deductpd          = ""    /*     ความเสียหายต่อทรัพย์สิน */
    wf_tp2               = ""    /*     ความเสียหายส่วนแรกบุคคล */
    wf_deductda          = ""    /*     ความเสียหายต่อต่อรถยนต์ */
    wf_deduct            = ""    /*     ความเสียหายส่วนแรกรถยนต์        */
    wf_tpfire            = ""    /*     รถยนต์สูญหาย/ไฟไหม้     */
    wf_NO_41         = ""    /*  อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่  */
    wf_ac2           = ""    /*  อุบัติเหตุส่วนบุคคลเสียชีวิตจน.ผู้โดยสาร       */
    wf_NO_42         = ""    /*  อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง  */
    wf_ac4           = ""    /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้ขับขี่   */
    wf_ac5           = ""    /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวจน.ผู้โดยสาร        */
    wf_ac6           = ""    /*  อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้โดยสารต่อครั้ง   */
    wf_ac7           = ""    /*  ค่ารักษาพยาบาล */
    wf_NO_43             = ""    /*  การประกันตัวผู้ขับขี่      */
    wf_nstatus           = ""    /*  สถานะข้อมูล        */
    wf_typrequest        = ""    /*  รหัสบริษัทผู้แจ้งประกัน    */
    wf_comrequest        = ""    /*  ชื่อบริษัทผู้แจ้งงาน       */
    wf_brrequest         = ""    /*  สาขาบริษัทผู้แจ้งประกัน    */
    wf_salename          = ""    /*  ชื่อผู้ติดต่อ/Saleman      */
    wf_comcar            = ""    /*  บริษัทที่ปล่อยรถ   */
    wf_brcar             = ""    /*  สาขาบริษัทที่ปล่อยรถ       */
    wf_projectno         = ""    /*  honda project      */
    wf_agcaryear         = ""    /*  อายุรถ */
    wf_special1          = ""    /*  บริการเสริมพิเศษ1  */
    wf_specialprem1      = ""    /*  ราคาบริการเสริมพิเศษ1      */
    wf_special2          = ""    /*  บริการเสริมพิเศษ2  */
    wf_specialprem2      = ""    /*  ราคาบริการเสริมพิเศษ2      */
    wf_special3          = ""    /*  บริการเสริมพิเศษ3  */
    wf_specialprem3      = ""    /*  ราคาบริการเสริมพิเศษ3      */
    wf_special4          = ""    /*  บริการเสริมพิเศษ4  */
    wf_specialprem4      = ""    /*  ราคาบริการเสริมพิเศษ4      */
    wf_special5          = ""    /*  บริการเสริมพิเศษ5  */
    wf_specialprem5      = ""    /*  ราคาบริการเสริมพิเศษ5      */
    wf_ac_no             = ""    /*  เล่มที่/เลขที่     */
    wf_ac_date           = ""    /*  วันที่รับเงิน      */
    wf_ac_amount         = ""    /*  จำนวนเงิน  */
    wf_ac_pay            = ""    /*  ชำระโดย    */
    wf_ac_agent          = ""    /*  เลขที่นายหน้า      */
    wf_voictitle         = ""    /*  ออกใบเสร็จในนาม    */
    wf_voicnam           = ""    /*  รหัสDealer Receipt */
    wf_voicnamdetail     = ""    /* ชื่อใบเสร็จ     */
    wf_detailcam         = ""    /*  รายละเอียดเคมเปญ   */
    wf_ins_pay           = ""   /*      รับประกันจ่ายแน่ๆ       */
    wf_n_month           = ""   /*      ผ่อนชำระ/เดือน          */
    wf_n_bank            = ""   /*      บัตรเครดิตธนาคาร        */
    wf_TYPE_notify       = ""   /*      ประเภทการแจ้งงาน        */
    wf_price_acc         = ""   /*      ราคารวมอุปกรณ์เสริม     */
    wf_accdata           = ""   /*  รายละเอียดอุปกรณ์เสริม      */
    wf_brdealer          = ""   /*  สาขา(ชื่อผู้เอาประกันในนามบริษัท)   */
    wf_brand_gals        = ""   /*  ยี่ห้อเคลือบแก้ว        */
    wf_brand_galsprm     = ""   /*  ราคาเคลือบแก้ว  */
    wf_companyre1        = ""   /*  ชื่อบริษัทเต็มบนใบกำกับภาษี1    */
    wf_companybr1        = ""   /*  สาขาบริษัทบนใบกำกับภาษี1        */
    wf_addr_re1          = ""   /*  ที่อยู่บนใบกำกับภาษี1   */
    wf_idno_re1          = ""   /*  เลขที่ผู้เสียภาษี1      */
    wf_premt_re1         = ""   /*  อัตราเบี้ยตามใบกำกับ1       */
    wf_companyre2        = ""   /*  ชื่อบริษัทเต็มบนใบกำกับภาษี2        */
    wf_companybr2        = ""   /*  สาขาบริษัทบนใบกำกับภาษี2    */
    wf_addr_re2          = ""   /*  ที่อยู่บนใบกำกับภาษี2       */
    wf_idno_re2          = ""   /*  เลขที่ผู้เสียภาษี2  */
    wf_premt_re2         = ""   /*  อัตราเบี้ยตามใบกำกับ2       */
    wf_companyre3        = ""   /*  ชื่อบริษัทเต็มบนใบกำกับภาษี3        */
    wf_companybr3        = ""   /*  สาขาบริษัทบนใบกำกับภาษี3    */
    wf_addr_re3          = ""   /*  ที่อยู่บนใบกำกับภาษี3       */
    wf_idno_re3          = ""   /*  เลขที่ผู้เสียภาษี3       */
    wf_premt_re3         = ""   /*  อัตราเบี้ยตามใบกำกับ3      */ 
    wf_camp_no           = ""   /* เลขที่แคมเปญ */                          /*--A58-0419--*/
    wf_payment_type      = ""   /* ประเภทการชำระเบี้ย */                    /*--A58-0419--*/
    /* A68-0061 */
    wf_producer          = ""
    wf_typepol           = ""
    wf_typecar           = ""
    wf_maksi             = ""
    wf_drivexp1          = ""
    wf_drivcon1          = ""
    wf_dlevel1           = ""
    wf_dgender1          = ""
    wf_drelation1        = ""
    wf_drivexp2          = ""
    wf_drivcon2          = ""
    wf_dlevel2           = ""
    wf_dgender2          = ""
    wf_drelation2        = ""
    wf_ntitle3           = ""
    wf_dname3            = ""
    wf_dcname3           = ""
    wf_dlname3           = ""
    wf_doccup3           = ""
    wf_dbirth3           = ""
    wf_dicno3            = ""
    wf_ddriveno3         = ""
    wf_drivexp3          = ""
    wf_drivcon3          = ""
    wf_dlevel3           = ""
    wf_dgender3          = ""
    wf_drelation3        = ""
    wf_ntitle4           = ""
    wf_dname4            = ""
    wf_dcname4           = ""
    wf_dlname4           = ""
    wf_doccup4           = ""
    wf_dbirth4           = ""
    wf_dicno4            = ""
    wf_ddriveno4         = ""
    wf_drivexp4          = ""
    wf_drivcon4          = ""
    wf_dlevel4           = ""
    wf_dgender4          = ""
    wf_drelation4        = ""
    wf_ntitle5           = ""
    wf_dname5            = ""
    wf_dcname5           = ""
    wf_dlname5           = ""
    wf_doccup5           = ""
    wf_dbirth5           = ""
    wf_dicno5            = ""
    wf_ddriveno5         = ""
    wf_drivexp5          = ""
    wf_drivcon5          = ""
    wf_dlevel5           = ""
    wf_dgender5          = ""
    wf_drelation5        = ""
    wf_chargflg          = ""
    wf_chargprice        = ""
    wf_chargno           = ""
    wf_chargprm          = ""
    wf_battflg           = ""
    wf_battprice         = ""
    wf_battno            = ""
    wf_battprm           = ""
    wf_battdate          = ""
    wf_net_re1           = ""
    wf_stam_re1          = ""
    wf_vat_re1           = ""
    wf_inscode_re2       = ""
    wf_net_re2           = ""
    wf_stam_re2          = ""
    wf_vat_re2           = ""
    wf_inscode_re3       = ""
    wf_net_re3           = ""
    wf_stam_re3          = ""
    wf_vat_re3           = ""
    wf_remark1           = ""
    wf_remark2           = ""
    wf_remark3           = ""
    wf_remark4           = ""
    wf_31rate            = ""
    wf_31premt           = "" .
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
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "008: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
ASSIGN n_insref = ""  
  nv_messagein  = ""
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
    sicsyac.xmm600.NAME     = TRIM(wdetail.insnam) + " " + trim(wdetail.name3)  NO-ERROR NO-WAIT.   end.comment by Kridtiya i. A56-0047...*/         
/*add  A56-0047  check  sicsyac.xmm600.clicod   = "IN"*/
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
  sicsyac.xmm600.NAME     = TRIM(wdetail.insnam) + " " + trim(wdetail.name3)  AND 
  sicsyac.xmm600.homebr   = TRIM(wdetail2.n_branch)     AND 
  sicsyac.xmm600.clicod   = "IN"  EXCLUSIVE-LOCK NO-ERROR NO-WAIT.    /* A56-0047 add check  sicsyac.xmm600.clicod   = "IN"*/
IF NOT AVAILABLE sicsyac.xmm600 THEN DO: 
    /* IF LOCKED sicsyac.xmm600 THEN DO:   
        ASSIGN nv_transfer = NO .
    /*    n_insref    = "".*/
            n_insref    = sicsyac.xmm600.acno.  /*ploy**/
        RETURN.
    END.
    ELSE DO:*/
  IF  n_insref = "" THEN DO:
    ASSIGN  n_check   = "" 
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
    RUN proc_insno. 
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
        ASSIGN wdetail2.pass = "N"  
            wdetail2.comment = wdetail2.comment + "| รหัสลูกค้าเป็นค่าว่างไม่สามารถนำเข้าระบบได้ค่ะ" 
            WDETAIL2.OK_GEN  = "N"
            nv_transfer = NO.
    END.    /**/
  END.
  n_insref = nv_insref.
END.
ELSE DO:
    IF sicsyac.xmm600.acno <> "" THEN DO:   /* กรณีพบ */
        ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            n_insref                = caps(trim(nv_insref)) 
            nv_transfer             = NO 
            sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname    = ""                        /*First Name*/
            sicsyac.xmm600.name     = TRIM(wdetail.insnam) + " " + trim(wdetail.name3)    /*Name Line 1*/
            sicsyac.xmm600.abname   = TRIM(wdetail.insnam) + " " + trim(wdetail.name3)    /*Abbreviated Name*/
            sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)              /*IC No.*/          /*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1    = TRIM(wdetail.addr)       /*+ " " + wdetail.road)  *//*Address line 1*/
            sicsyac.xmm600.addr2    = TRIM(wdetail.tambon)                                /*Address line 2*/
            sicsyac.xmm600.addr3    = TRIM(wdetail.amper)                                 /*Address line 3*/
            sicsyac.xmm600.addr4    = TRIM(wdetail.country)                  
            sicsyac.xmm600.homebr   = TRIM(wdetail2.n_branch)      /*Home branch*/
            sicsyac.xmm600.opened   = TODAY
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            sicsyac.xmm600.dtyp20   = IF wdetail.birthdat = "" THEN "" ELSE "DOB"
            sicsyac.xmm600.dval20   = IF wdetail.birthdat = "" THEN ""
                                      ELSE substr(TRIM(wdetail.birthdat),1,6) +
                                      STRING(deci(substr(TRIM(wdetail.birthdat),7,4)) + 543 )       /*-- Add chutikarn A50-0072 --*/
             /* Ranu I. A64-0328 เคลียร์หน้า Vat ชมพู */
            sicsyac.xmm600.nntitle    = "" 
            sicsyac.xmm600.nfirstname = "" 
            sicsyac.xmm600.nlastname  = "" 
            sicsyac.xmm600.nphone     = "" 
            sicsyac.xmm600.nicno      = "" 
            sicsyac.xmm600.nbr_insure = "" 
            sicsyac.xmm600.naddr1     = "" 
            sicsyac.xmm600.naddr2     = "" 
            sicsyac.xmm600.naddr3     = "" 
            sicsyac.xmm600.naddr4     = "" 
            sicsyac.xmm600.npostcd    = "" 
            sicsyac.xmm600.anlyc1     = "" .
            /* End : Ranu I. A64-0328 เคลียร์หน้า Vat ชมพู */
            
            /*Add by Kridtiya i. A63-0472*/
            /*sicsyac.xmm600.anlyc5   =  ""                    /*Analysis Code 5*/ */          /*A57-0073*/
            /*sicsyac.xmm600.anlyc5   = IF nv_typ = "Cs" THEN TRIM(wdetail2.brdealer) ELSE "" .*//*kridtiya i. 31/10/2014 */
        /*
        IF wdetail2.brdealer <> "" THEN DO:
            ASSIGN sicsyac.xmm600.anlyc5   = IF nv_typ = "Cs" THEN TRIM(wdetail2.brdealer) ELSE "" .  /*A57-0073*/
        END.
        */
        /*by Kridtiya i. A65-0363*/
        IF wdetail3.companybr1 <> "" AND (nv_typ = "Cs" OR sicsyac.xmm600.acno_typ = "co") THEN DO: 
            IF INDEX(wdetail3.companybr1,"สำนักงานใหญ่") <> 0  THEN ASSIGN sicsyac.xmm600.anlyc5 = "00000".
            ELSE ASSIGN sicsyac.xmm600.anlyc5 = trim(wdetail3.companybr1).
        END.
        /*by Kridtiya i. A65-0363*/
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
        sicsyac.xmm600.name     = TRIM(wdetail.insnam) + " " + trim(wdetail.name3)     /*Name Line 1*/
        sicsyac.xmm600.abname   = TRIM(wdetail.insnam) + " " + trim(wdetail.name3)      /*Abbreviated Name*/
        sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*/     /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.addr)        /*+ " " + wdetail.road)*/    /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.tambon)                       /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.amper)                        /*Address line 3*/
        sicsyac.xmm600.addr4    = TRIM(wdetail.country)                      /*Address line 4*/
        sicsyac.xmm600.postcd   = ""                        /*Postal Code*/
        sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
        sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
        sicsyac.xmm600.homebr   = TRIM(wdetail2.n_branch)      /*Home branch*/
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
        /*sicsyac.xmm600.anlyc5   =  ""                    /*Analysis Code 5*/ */        /*A57-0073*/
        /*sicsyac.xmm600.anlyc5   = IF nv_typ = "Cs" THEN TRIM(wdetail2.brdealer) ELSE ""  /*A57-0073*/*//*kridtiya i. 31/10/2014*/
        sicsyac.xmm600.dtyp20   = IF wdetail.birthdat = "" THEN "" ELSE "DOB"
        sicsyac.xmm600.dval20   = IF wdetail.birthdat = "" THEN ""
                                  ELSE substr(TRIM(wdetail.birthdat),1,6) + 
                                      STRING(deci(substr(TRIM(wdetail.birthdat),7,4)) + 543 ) .    /*string(wdetail.brithday).*/
        /*by Kridtiya i. A65-0363*/
        IF wdetail3.companybr1 <> "" AND nv_typ = "Cs" THEN DO: 
            IF INDEX(wdetail3.companybr1,"สำนักงานใหญ่") <> 0  THEN ASSIGN sicsyac.xmm600.anlyc5 = "00000".
            ELSE ASSIGN sicsyac.xmm600.anlyc5 = trim(wdetail3.companybr1).
        END.
        /*by Kridtiya i. A65-0363*/
        
END.
IF sicsyac.xmm600.acno <> "" THEN DO:              /*A55-0268 add chk nv_insref = "" */
    ASSIGN nv_insref = trim(sicsyac.xmm600.acno)
        nv_transfer  = YES.
    FIND sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xtm600 THEN DO:
        IF LOCKED sicsyac.xtm600 THEN DO:
            nv_transfer = NO.
            RETURN.
        END.
        ELSE DO:
            CREATE sicsyac.xtm600.
            nv_transfer  = YES.
        END.
    END.
    IF nv_transfer = YES THEN DO:
        ASSIGN
            sicsyac.xtm600.acno    = nv_insref                                          /*Account no.*/
            sicsyac.xtm600.name    = TRIM(wdetail.insnam) + " " + trim(wdetail.name3)   /*Name of Insured Line 1*/
            sicsyac.xtm600.abname  = TRIM(wdetail.insnam) + " " + trim(wdetail.name3)   /*Abbreviated Name*/
            sicsyac.xtm600.addr1   = TRIM(wdetail.addr)    /*+ " " + wdetail.road)  */  /*address line 1*/
            sicsyac.xtm600.addr2   = TRIM(wdetail.tambon)                               /*address line 2*/
            sicsyac.xtm600.addr3   = TRIM(wdetail.amper)                                /*address line 3*/
            sicsyac.xtm600.addr4   = TRIM(wdetail.country)                              /*address line 4*/
            sicsyac.xtm600.name2   = ""                                                 /*Name of Insured Line 2*/ 
            sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)                               /*Title*/
            sicsyac.xtm600.name3   = ""                                                 /*Name of Insured Line 3*/
            sicsyac.xtm600.fname   = ""  .                                              /*First Name*/
            
    END.
END.
ASSIGN  
    wdetail.birthdat   = ""
    wdetail2.nv_insref = nv_insref .
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
/*
RETURN.
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
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "009: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
/*Add by Kridtiya i. A63-0472*/
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno     =  n_insref   NO-ERROR NO-WAIT.  
IF AVAIL sicsyac.xmm600 THEN DO:
    ASSIGN
    sicsyac.xmm600.acno_typ  = wdetail3.insnamtyp    /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
    sicsyac.xmm600.firstname = TRIM(wdetail3.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail3.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.post)     
    sicsyac.xmm600.icno      = trim(wdetail.icno)       
    sicsyac.xmm600.codeocc   = trim(wdetail3.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail3.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail3.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail3.codeaddr3)  
    /*sicsyac.xmm600.anlyc5    = trim(wdetail3.br_insured)*/   . 
    IF wdetail3.insnamtyp = "CO" OR sicsyac.xmm600.ntitle = "คุณ" THEN sicsyac.xmm600.sex = "O".
    ELSE IF INDEX(TRIM(wdetail.tiname),"นาย") <> 0 THEN sicsyac.xmm600.sex = "M".
    ELSE IF INDEX(TRIM(wdetail.tiname),"นาง") <> 0 THEN sicsyac.xmm600.sex = "F".
    ELSE sicsyac.xmm600.sex = "O".
         /*by Kridtiya i. A65-0363*/
    IF wdetail3.companybr1 <> "" AND (nv_typ = "Cs" OR sicsyac.xmm600.acno_typ = "co" OR wdetail3.insnamtyp = "co" ) THEN DO: 
        IF INDEX(wdetail3.companybr1,"สำนักงานใหญ่") <> 0  THEN ASSIGN sicsyac.xmm600.anlyc5 = "00000".
        ELSE ASSIGN sicsyac.xmm600.anlyc5 = trim(wdetail3.companybr1).
    END.
    /*by Kridtiya i. A65-0363*/
END.
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN
    ASSIGN 
    sicsyac.xtm600.postcd    = trim(wdetail.post)        
    sicsyac.xtm600.firstname = trim(wdetail3.firstName)      
    sicsyac.xtm600.lastname  = trim(wdetail3.lastName)   .   
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
    sicsyac.xzm056.branch   =  TRIM(wdetail2.n_branch)    NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN sicsyac.xzm056.seqtyp =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail2.n_branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref = TRIM(wdetail2.n_branch)  + String(1,"999999")
            nv_lastno = 1.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(TRIM(wdetail2.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail2.n_branch) + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:
            /*A56-0318....
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno + 1 ,"999999").   A56-0318*/
            /*Add ... A56-0318*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail2.n_branch) = "A") OR (TRIM(wdetail2.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail2.n_branch) = "A") OR (TRIM(wdetail2.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail2.n_branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(TRIM(wdetail2.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail2.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail2.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       TRIM(wdetail2.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").
        END.   
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail2.n_branch)
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(TRIM(wdetail2.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").*/
            /*Add ... A56-0318*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail2.n_branch) = "A") OR (TRIM(wdetail2.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail2.n_branch) = "A") OR (TRIM(wdetail2.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       TRIM(wdetail2.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
    END.
    ELSE DO:
        IF LENGTH(TRIM(wdetail2.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail2.n_branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail2.n_branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       TRIM(wdetail2.n_branch) + "C" + String(sicsyac.xzm056.lastno,"99999").
        END.
    END.   
END.
IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno Then Do :
    /*MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
        "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
        "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. */
    nv_insref = "" .
    n_check = "ERROR".
    RETURN. 
END.         /*lastno > seqno*/                       
ELSE DO :    /*lastno <= seqno */
    IF nv_typ = "0s" THEN DO:
        IF n_search = YES THEN DO:
            CREATE sicsyac.xzm056.
            ASSIGN
                sicsyac.xzm056.seqtyp    =  nv_typ
                sicsyac.xzm056.branch    =  TRIM(wdetail2.n_branch)
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
                sicsyac.xzm056.branch    =  TRIM(wdetail2.n_branch)
                sicsyac.xzm056.des       =  "Company/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno. 
        END.
    END.
END.        /*lastno <= seqno */  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_instot C-Win 
PROCEDURE proc_instot :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEFINE        VAR s_recid1  AS RECID NO-UNDO.   /** uwm100 recid **/*/
DEFINE        VAR nv_cnt    AS INT.
DEFINE        VAR n_index   AS INTEGER.
DEFINE        VAR n_ttprem  LIKE sic_bran.uwm100.prem_t.
DEFINE        VAR n_ttcom1  LIKE sic_bran.uwm100.com1_t.
DEFINE        VAR n_ttcom2  LIKE sic_bran.uwm100.com2_t.
DEFINE        VAR n_ttrstp  LIKE sic_bran.uwm100.rstp_t.
DEFINE        VAR n_ttrfee  LIKE sic_bran.uwm100.rfee_t.
DEFINE        VAR n_ttrtax  LIKE sic_bran.uwm100.rtax_t.
DEFINE        VAR n_recid   AS RECID.
DEFINE        VAR nv_tmp_date AS DATE.
DEFINE        VAR nv_d0     AS INT.
DEFINE        VAR nv_y      AS INT.
DEFINE        VAR nv_m      AS INT.
DEFINE        VAR nv_d      AS INT.
DEFINE        VAR nv_dtable AS INT EXTENT 12
                INIT [31,28,31,30,31,30,31,31,30,31,30,31].
DEFINE        VAR n_ttpstp  LIKE sic_bran.uwm100.rstp_t.
DEFINE        VAR n_ttpfee  LIKE sic_bran.uwm100.rfee_t.
DEFINE        VAR n_ttptax  LIKE sic_bran.uwm100.rtax_t.

FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1  no-error no-wait.
IF AVAILABLE sic_bran.uwm100  THEN DO:
  ASSIGN s_recid1               = RECID(sic_bran.uwm100)
    sic_bran.uwm100.instot = wdetail3.instot .
  FIND FIRST sic_bran.uwm101  USE-INDEX uwm10101 WHERE
    sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
    sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
    sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
    sic_bran.uwm101.bchyr  = nv_batchyr     AND
    sic_bran.uwm101.bchno  = nv_batchno     AND
    sic_bran.uwm101.bchcnt = nv_batcnt      NO-LOCK NO-ERROR NO-WAIT.
  IF AVAILABLE sic_bran.uwm101  THEN DO:
    FOR EACH sic_bran.uwm101  USE-INDEX uwm10101   WHERE
      sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
      sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
      sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
      sic_bran.uwm101.bchyr  = nv_batchyr     AND
      sic_bran.uwm101.bchno  = nv_batchno     AND
      sic_bran.uwm101.bchcnt = nv_batcnt:
        DELETE sic_bran.uwm101.
    END.    /* each uwm101 */
    RELEASE sic_bran.uwm101.
  END.     /* avail uwm101 */
  IF sic_bran.uwm100.instot > 1 THEN DO: 
    IF wdetail3.instot = 2 THEN DO:
        ASSIGN wdetail3.premt_re2 = STRING((TRUNCATE(((deci(wdetail3.premt_re2)  * 100 ) / 107.43),0)))
          wdetail3.premt_re1 = STRING(sic_bran.uwm100.prem_t - deci(wdetail3.premt_re2)).
    END.
    ELSE DO:
      ASSIGN 
          wdetail3.premt_re3 = STRING((TRUNCATE(((deci(wdetail3.premt_re3)  * 100 ) / 107.43),0)))
          wdetail3.premt_re2 = STRING((TRUNCATE(((deci(wdetail3.premt_re2)  * 100 ) / 107.43),0)))
          wdetail3.premt_re1 = STRING(sic_bran.uwm100.prem_t - deci(wdetail3.premt_re2) - deci(wdetail3.premt_re3)).
    END.
    DO transaction:
        FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 exclusive-lock NO-ERROR.
    END.
    FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE
        sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR.
    Do transaction:
        FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
          sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
          sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
          sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
          sic_bran.uwm101.bchyr  = nv_batchyr     AND
          sic_bran.uwm101.bchno  = nv_batchno     AND
          sic_bran.uwm101.bchcnt = nv_batcnt      AND
          sic_bran.uwm101.instno = 1 exclusive-lock NO-ERROR.
    END.
    IF AVAILABLE sic_bran.uwm101 THEN DO transaction:
        nv_cnt = 0.
        FOR EACH sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
          sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
          sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
          sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND 
          sic_bran.uwm101.bchyr  = nv_batchyr             AND
          sic_bran.uwm101.bchno  = nv_batchno             AND
          sic_bran.uwm101.bchcnt = nv_batcnt              no-lock:
          nv_cnt = nv_cnt + 1.
        END.
        IF nv_cnt = sic_bran.uwm100.instot THEN
          FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
            sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
            sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
            sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
            sic_bran.uwm101.bchyr  = nv_batchyr             AND
            sic_bran.uwm101.bchno  = nv_batchno             AND
            sic_bran.uwm101.bchcnt = nv_batcnt              AND
            sic_bran.uwm101.instno = 1 exclusive-lock NO-ERROR.
        ELSE DO:
            FOR EACH sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
              sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
              sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
              sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
              sic_bran.uwm101.bchyr  = nv_batchyr             AND
              sic_bran.uwm101.bchno  = nv_batchno             AND
              sic_bran.uwm101.bchcnt = nv_batcnt    :
              DELETE sic_bran.uwm101.
              END.
              REPEAT n_index = 1 TO sic_bran.uwm100.instot:
                  CREATE sic_bran.uwm101.
                  ASSIGN sic_bran.uwm101.policy = sic_bran.uwm100.policy
                    sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt
                    sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt
                    sic_bran.uwm101.bchyr  = nv_batchyr           
                    sic_bran.uwm101.bchno  = nv_batchno            
                    sic_bran.uwm101.bchcnt = nv_batcnt 
                    sic_bran.uwm101.instno = n_index
                    /*sic_bran.uwm101.prem_i = sic_bran.uwm100.prem_t / sic_bran.uwm100.instot*/
                    sic_bran.uwm101.prem_i =  IF      n_index = 1 THEN deci(wdetail3.premt_re1)
                                              ELSE IF n_index = 2 THEN deci(wdetail3.premt_re2)
                                              ELSE deci(wdetail3.premt_re3)
                    sic_bran.uwm101.com1_i = sic_bran.uwm100.com1_t / sic_bran.uwm100.instot
                    sic_bran.uwm101.com2_i = sic_bran.uwm100.com2_t / sic_bran.uwm100.instot
                    sic_bran.uwm101.rstp_i = sic_bran.uwm100.rstp_t / sic_bran.uwm100.instot
                    sic_bran.uwm101.rfee_i = sic_bran.uwm100.rfee_t / sic_bran.uwm100.instot
                    sic_bran.uwm101.rtax_i = sic_bran.uwm100.rtax_t / sic_bran.uwm100.instot
                    n_ttprem = n_ttprem + sic_bran.uwm101.prem_i
                    n_ttcom1 = n_ttcom1 + sic_bran.uwm101.com1_i
                    n_ttcom2 = n_ttcom2 + sic_bran.uwm101.com2_i
                    n_ttrstp = n_ttrstp + sic_bran.uwm101.rstp_i
                    n_ttrfee = n_ttrfee + sic_bran.uwm101.rfee_i
                    n_ttrtax = n_ttrtax + sic_bran.uwm101.rtax_i
                    sic_bran.uwm101.desc_i = IF      n_index = 1 THEN wdetail3.companyre1
                                             ELSE IF n_index = 2 THEN wdetail3.companyre2
                                                                 ELSE wdetail3.companyre3
                    sic_bran.uwm101.trty1i = ""
                    sic_bran.uwm101.docnoi = "".
                  IF n_index = 1 THEN DO:
                      ASSIGN n_recid                = RECID(sic_bran.uwm101)
                          sic_bran.uwm101.pstp_i = sic_bran.uwm100.pstp
                          sic_bran.uwm101.pfee_i = sic_bran.uwm100.pfee
                          sic_bran.uwm101.ptax_i = sic_bran.uwm100.ptax.
                  END.
                  ELSE DO:
                      ASSIGN sic_bran.uwm101.pstp_i  = 0
                          sic_bran.uwm101.pfee_i  = 0
                          sic_bran.uwm101.ptax_i  = 0.
                  END.
                  IF sicsyac.xmm031.insdef = "C" OR sicsyac.xmm031.insdef = "T" THEN DO:
                      IF n_index = 1 THEN DO:
                          IF sicsyac.xmm031.insdef = "C" THEN 
                               sic_bran.uwm101.duedat = sic_bran.uwm100.comdat.
                          ELSE sic_bran.uwm101.duedat = sic_bran.uwm100.trndat.
                               nv_tmp_date = sic_bran.uwm101.duedat.
                               nv_d0 = DAY(nv_tmp_date).
                      END.
                      ELSE DO:
                          IF  sic_bran.uwm100.instot = 3 OR sic_bran.uwm100.instot = 4  OR
                              sic_bran.uwm100.instot = 6 OR sic_bran.uwm100.instot = 12 THEN DO:
                              nv_y = YEAR(nv_tmp_date).
                              nv_m = MONTH(nv_tmp_date).
                              nv_d = DAY(nv_tmp_date).
                              nv_m = nv_m + 12 / sic_bran.uwm100.instot.
                              IF nv_m > 12 THEN DO:
                                  nv_y = nv_y + 1.
                                  nv_m = nv_m - 12.
                              END.
                              IF nv_m <> 2 THEN nv_d = MIN(nv_d0,nv_dtable[nv_m]).
                              ELSE IF nv_y MOD 4 = 0 
                                  THEN  nv_d = MIN(nv_d0,29).
                              ELSE  nv_d = MIN(nv_d0,nv_dtable[nv_m]).
                                    nv_tmp_date = DATE(nv_m,nv_d,nv_y).
                                    sic_bran.uwm101.duedat = nv_tmp_date.
                          END.
                      END.
                  END.
              END.
              FIND FIRST sic_bran.uwm101 WHERE RECID(sic_bran.uwm101) = n_recid.
              IF AVAILABLE sic_bran.uwm101 THEN DO:
                  sic_bran.uwm101.prem_i = sic_bran.uwm101.prem_i + (sic_bran.uwm100.prem_t - n_ttprem).
                  sic_bran.uwm101.com1_i = sic_bran.uwm101.com1_i + (sic_bran.uwm100.com1_t - n_ttcom1).
                  sic_bran.uwm101.com2_i = sic_bran.uwm101.com2_i + (sic_bran.uwm100.com2_t - n_ttcom2).
                  sic_bran.uwm101.rstp_i = sic_bran.uwm101.rstp_i + (sic_bran.uwm100.rstp_t - n_ttrstp).
                  sic_bran.uwm101.rfee_i = sic_bran.uwm101.rfee_i + (sic_bran.uwm100.rfee_t - n_ttrfee).
                  sic_bran.uwm101.rtax_i = sic_bran.uwm101.rtax_i + (sic_bran.uwm100.rtax_t - n_ttrtax).
              END.
          END.
      END.
      ELSE DO transaction:
          REPEAT n_index = 1 TO sic_bran.uwm100.instot:
              CREATE sic_bran.uwm101.
              ASSIGN sic_bran.uwm101.policy = sic_bran.uwm100.policy
                sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt
                sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt
                sic_bran.uwm101.bchyr  = nv_batchyr         
                sic_bran.uwm101.bchno  = nv_batchno            
                sic_bran.uwm101.bchcnt = nv_batcnt 
                sic_bran.uwm101.instno = n_index.
              ASSIGN  sic_bran.uwm101.com1_i = IF      n_index = 1 THEN deci(wdetail3.premt_re1) * nv_com1p_ins / 100
                                               ELSE IF n_index = 2 THEN deci(wdetail3.premt_re2) * nv_com1p_ins / 100
                                                                   ELSE deci(wdetail3.premt_re3)
                  sic_bran.uwm101.com2_i = sic_bran.uwm100.com2_t / ( sic_bran.uwm100.instot - 1 ) 
                  sic_bran.uwm101.prem_i = IF      n_index = 1 THEN deci(wdetail3.premt_re1)
                                           ELSE IF n_index = 2 THEN deci(wdetail3.premt_re2)
                                                               ELSE deci(wdetail3.premt_re3)
                  /*sic_bran.uwm101.com1_i = 0
                  sic_bran.uwm101.com2_i = 0*/
                  /*sic_bran.uwm101.rstp_i = sic_bran.uwm100.rstp_t / ( sic_bran.uwm100.instot - 1 )*/
                  sic_bran.uwm101.rfee_i = sic_bran.uwm100.rfee_t / ( sic_bran.uwm100.instot - 1 )
                  /*sic_bran.uwm101.rtax_i = sic_bran.uwm100.rtax_t / ( sic_bran.uwm100.instot - 1 )*/  
                  n_ttprem = n_ttprem + sic_bran.uwm101.prem_i
                  n_ttcom1 = n_ttcom1 + sic_bran.uwm101.com1_i
                  n_ttcom2 = n_ttcom2 + sic_bran.uwm101.com2_i
                  n_ttrstp = n_ttrstp + sic_bran.uwm101.rstp_i
                  n_ttrfee = n_ttrfee + sic_bran.uwm101.rfee_i
                  n_ttrtax = n_ttrtax + sic_bran.uwm101.rtax_i
                  sic_bran.uwm101.desc_i = IF      n_index = 1 THEN wdetail3.companyre1
                                           ELSE IF n_index = 2 THEN wdetail3.companyre2
                                                               ELSE wdetail3.companyre3
                  sic_bran.uwm101.trty1i = "" 
                  sic_bran.uwm101.docnoi = ""
                  n_recid       = RECID(sic_bran.uwm101).
              IF     n_index = 1 THEN 
                  ASSIGN nv_fi_rstp_t1  = Truncate(deci(wdetail3.premt_re1) * nv_fi_stamp_per_ins / 100,0) + 
                                          (IF (deci(wdetail3.premt_re1) * nv_fi_stamp_per_ins  / 100) - 
                                          Truncate(deci(wdetail3.premt_re1) * nv_fi_stamp_per_ins  / 100,0) > 0
                                          Then 1 Else 0)
                  sic_bran.uwm101.pstp_i = nv_fi_rstp_t1.
              ELSE IF n_index = 2 THEN  
                  ASSIGN nv_fi_rstp_t2   = Truncate(deci(wdetail3.premt_re2)  * nv_fi_stamp_per_ins / 100,0) + 
                                           (IF (deci(wdetail3.premt_re2)  * nv_fi_stamp_per_ins  / 100) - 
                                            Truncate(deci(wdetail3.premt_re2)  * nv_fi_stamp_per_ins  / 100,0) > 0
                                            Then 1 Else 0)
                  sic_bran.uwm101.pstp_i = nv_fi_rstp_t2.
              ELSE  
                  ASSIGN nv_fi_rstp_t3  =  Truncate(deci(wdetail3.premt_re3)  * nv_fi_stamp_per_ins / 100,0) +
                                           (IF (deci(wdetail3.premt_re3)  * nv_fi_stamp_per_ins  / 100)   - 
                                            Truncate(deci(wdetail3.premt_re3)  * nv_fi_stamp_per_ins  / 100,0) > 0
                                            Then 1 Else 0)
                  sic_bran.uwm101.pstp_i = nv_fi_rstp_t2.
              IF      n_index = 1 THEN 
               ASSIGN sic_bran.uwm101.ptax_i  =  (deci(wdetail3.premt_re1) + nv_fi_rstp_t1) * nv_fi_tax_per_ins / 100  .
              ELSE IF n_index = 2 THEN                                     
               ASSIGN sic_bran.uwm101.ptax_i  =  (deci(wdetail3.premt_re2) + nv_fi_rstp_t2) * nv_fi_tax_per_ins / 100  .
              ELSE    sic_bran.uwm101.ptax_i  =  (deci(wdetail3.premt_re3) + nv_fi_rstp_t2) * nv_fi_tax_per_ins / 100  .
              IF sicsyac.xmm031.insdef = "C" OR sicsyac.xmm031.insdef = "T" THEN DO:
                  IF sicsyac.xmm031.insdef = "C" THEN sic_bran.uwm101.duedat = sic_bran.uwm100.comdat.
                  ELSE sic_bran.uwm101.duedat = sic_bran.uwm100.trndat.
                  nv_tmp_date = sic_bran.uwm101.duedat.
                  nv_d0 = DAY(nv_tmp_date).
              END.
          END.
          FIND FIRST sic_bran.uwm101 WHERE RECID(sic_bran.uwm101) = n_recid.
          IF AVAILABLE sic_bran.uwm101 THEN DO:
              sic_bran.uwm101.prem_i = sic_bran.uwm101.prem_i + (sic_bran.uwm100.prem_t - n_ttprem).
              /*sic_bran.uwm101.com1_i = sic_bran.uwm101.com1_i + (sic_bran.uwm100.com1_t - n_ttcom1).  */
              sic_bran.uwm101.com2_i = sic_bran.uwm101.com2_i + (sic_bran.uwm100.com2_t - n_ttcom2).
              /*sic_bran.uwm101.rstp_i = sic_bran.uwm101.rstp_i + (sic_bran.uwm100.rstp_t - n_ttrstp).*/
              sic_bran.uwm101.rfee_i = sic_bran.uwm101.rfee_i + (sic_bran.uwm100.rfee_t - n_ttrfee).
              /*sic_bran.uwm101.rtax_i = sic_bran.uwm101.rtax_i + (sic_bran.uwm100.rtax_t - n_ttrtax).*/
          END.
      END.
      ASSIGN
        n_index  = 1
        n_ttprem = 0
        n_ttcom1 = 0
        n_ttcom2 = 0
        n_ttrstp = 0
        n_ttrfee = 0
        n_ttrtax = 0
        n_ttpstp = 0
        n_ttpfee = 0
        n_ttptax = 0
        nv_com1p_ins        = 0     
        nv_fi_tax_per_ins   = 0      
        nv_fi_stamp_per_ins = 0   . 
  END.                            
END.
release sic_bran.uwm101.   
release sic_bran.uwm101.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_instot1 C-Win 
PROCEDURE proc_instot1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**  uwo10085.p - NEW POLICY ENTRY - INSTALMENTS  **/
DEFINE        VAR n_recid   AS RECID.                                       
DEFINE        VAR n_ttprem  LIKE sic_bran.uwm100.prem_t.                   
DEFINE        VAR n_ttcom1  LIKE sic_bran.uwm100.com1_t.                    
DEFINE        VAR n_ttcom2  LIKE sic_bran.uwm100.com2_t.                    
DEFINE        VAR n_ttrstp  LIKE sic_bran.uwm100.rstp_t.                    
DEFINE        VAR n_ttrfee  LIKE sic_bran.uwm100.rfee_t.                    
DEFINE        VAR n_ttrtax  LIKE sic_bran.uwm100.rtax_t.                    
DEFINE        VAR n_ttpstp  LIKE sic_bran.uwm100.rstp_t.                    
DEFINE        VAR n_ttpfee  LIKE sic_bran.uwm100.rfee_t.                    
DEFINE        VAR n_ttptax  LIKE sic_bran.uwm100.rtax_t.                    
DEFINE        VAR n_index   AS INTEGER.                                    
DEFINE        VAR nv_d0     AS INT.                                         
DEFINE        VAR nv_tmp_date AS DATE.                                      
/*DEFINE  VAR s_recid1      AS RECID NO-UNDO.        /** uwm100 recid **/
DEFINE  VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 2015.
DEFINE  VAR  nv_batcnt    AS INT FORMAT "99"              INIT 1.
DEFINE  VAR  nv_batchno   AS CHARACTER FORMAT "X(18)"     INIT "B3M00170M0044"  NO-UNDO.*/
DEF VAR nv_fi_rstp_t1       AS DECI INIT 0.
DEF VAR nv_fi_rstp_t2       AS DECI INIT 0.
DEF VAR nv_fi_rstp_t3       AS DECI INIT 0.
DEF VAR nv_com1p_ins1       AS DECI INIT 0.
DEF VAR nv_com1p_ins2       AS DECI INIT 0.
DEF VAR nv_com1p_ins3       AS DECI INIT 0.
DEF VAR nv_prem01           AS DECI INIT 0.
DEF VAR nv_prem02           AS DECI INIT 0.
DEF VAR nv_prem03           AS DECI INIT 0.

/*
DEF VAR nv_fi_tax_per_ins   AS DECI .
DEF VAR nv_fi_stamp_per_ins AS DECI .*/
/*
nv_com1p_ins       
nv_fi_tax_per_ins  
nv_fi_stamp_per_ins*/
/*FIND uwm100 WHERE            RECID(uwm100)           = s_recid1 exclusive-lock NO-ERROR.*/
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
/*FIND LAST  sic_bran.uwm100   Where 
    sic_bran.uwm100.policy = wdetail.policyno AND 
    sic_bran.uwm100.bchyr  = nv_batchyr       AND 
    sic_bran.uwm100.bchno  = nv_batchno       AND 
    sic_bran.uwm100.bchcnt = nv_batcnt        no-error no-wait.*/
IF AVAILABLE sic_bran.uwm100  THEN DO:
    ASSIGN 
        s_recid1 = RECID(sic_bran.uwm100)
        sic_bran.uwm100.instot = wdetail3.instot  
        nv_fi_rstp_t1 = 0
        nv_fi_rstp_t2 = 0
        nv_fi_rstp_t3 = 0
        nv_com1p_ins1 = 0
        nv_com1p_ins2 = 0
        nv_com1p_ins3 = 0
        nv_prem01     = 0  
        nv_prem02     = 0  
        nv_prem03     = 0  .
    
    IF wdetail3.instot = 2 THEN DO:
        ASSIGN 
            nv_prem02 = (TRUNCATE(((deci(wdetail3.premt_re2)  * 100 ) / 107.43),0))       
            nv_prem01 = sic_bran.uwm100.prem_t - nv_prem02.                               
    END.
    ELSE DO:
        ASSIGN 
            nv_prem03 = (TRUNCATE(((deci(wdetail3.premt_re3)  * 100 ) / 107.43),0))
            nv_prem02 = (TRUNCATE(((deci(wdetail3.premt_re2)  * 100 ) / 107.43),0))
            nv_prem01 = sic_bran.uwm100.prem_t - nv_prem02 - nv_prem03.
    END.

    IF nv_prem01 > 0 THEN 
        ASSIGN 
        nv_com1p_ins1 = (nv_prem01 * nv_com1p_ins ) / 100
        nv_fi_rstp_t1 = Truncate(nv_prem01 * nv_fi_stamp_per_ins  / 100,0)  + 
                        IF      (nv_prem01 * nv_fi_stamp_per_ins  / 100) -
                        Truncate(nv_prem01 * nv_fi_stamp_per_ins  / 100,0) > 0 Then 1 Else 0.
    IF nv_prem02 > 0 THEN 
        ASSIGN 
        nv_com1p_ins2 = (nv_prem02 * nv_com1p_ins ) / 100
        nv_fi_rstp_t2 = Truncate(nv_prem02 * nv_fi_stamp_per_ins / 100,0) + 
                            (IF (nv_prem02 * nv_fi_stamp_per_ins / 100) - 
                        Truncate(nv_prem02 * nv_fi_stamp_per_ins / 100,0) > 0 Then 1 Else 0 ).
    IF nv_prem03 > 0 THEN   
        ASSIGN 
        nv_com1p_ins3 = (nv_prem03 * nv_com1p_ins ) / 100
        nv_fi_rstp_t3 = Truncate(nv_prem03 * nv_fi_stamp_per_ins / 100,0) + 
                            (IF (nv_prem03 * nv_fi_stamp_per_ins / 100) - 
                        Truncate(nv_prem03 * nv_fi_stamp_per_ins / 100,0) > 0 Then 1 Else 0 ).

    FIND FIRST sic_bran.uwm101  USE-INDEX uwm10101 WHERE
        sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
        sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
        sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
        sic_bran.uwm101.bchyr  = nv_batchyr     AND
        sic_bran.uwm101.bchno  = nv_batchno     AND
        sic_bran.uwm101.bchcnt = nv_batcnt      NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sic_bran.uwm101  THEN DO:
        FOR EACH sic_bran.uwm101  USE-INDEX uwm10101   WHERE
            sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
            sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm101.bchyr  = nv_batchyr     AND
            sic_bran.uwm101.bchno  = nv_batchno     AND
            sic_bran.uwm101.bchcnt = nv_batcnt:
            DELETE sic_bran.uwm101.
        END.  /* each uwm101 */
        RELEASE sic_bran.uwm101.
    END.       /* avail uwm101 */
    IF sic_bran.uwm100.instot > 1 THEN DO: 
        ASSIGN 
            n_ttprem = 0
            n_ttcom1 = 0
            n_ttcom2 = 0
            n_ttpstp = 0
            n_ttpfee = 0
            n_ttptax = 0
            n_ttrstp = 0
            n_ttrfee = 0
            n_ttrtax = 0.
        DO transaction:
            FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 exclusive-lock NO-ERROR.
        END.
        FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR.
        Do transaction:
            FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
                sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
                sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
                sic_bran.uwm101.bchyr  = nv_batchyr             AND
                sic_bran.uwm101.bchno  = nv_batchno             AND
                sic_bran.uwm101.bchcnt = nv_batcnt              AND
                sic_bran.uwm101.instno = 1 exclusive-lock NO-ERROR.
        END.
        IF NOT AVAILABLE sic_bran.uwm101 THEN DO transaction:
            REPEAT n_index = 1 TO sic_bran.uwm100.instot:
                CREATE sic_bran.uwm101.
                ASSIGN 
                    sic_bran.uwm101.policy = sic_bran.uwm100.policy 
                    sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt 
                    sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt
                    sic_bran.uwm101.bchyr  = nv_batchyr        
                    sic_bran.uwm101.bchno  = nv_batchno            
                    sic_bran.uwm101.bchcnt = nv_batcnt  
                    sic_bran.uwm101.instno = n_index
                    sic_bran.uwm101.prem_i = IF      n_index = 1 THEN nv_prem01
                                             ELSE IF n_index = 2 THEN nv_prem02
                                                                 ELSE nv_prem03
                    sic_bran.uwm101.com1_i = IF      n_index = 1 THEN nv_com1p_ins1 * ( -1 )
                                             ELSE IF n_index = 2 THEN nv_com1p_ins2 * ( -1 )
                                                                 ELSE nv_com1p_ins3 * ( -1 )
                    sic_bran.uwm101.com2_i = 0.00
                    sic_bran.uwm101.rstp_i = IF      n_index = 1 THEN nv_fi_rstp_t1
                                             ELSE IF n_index = 2 THEN nv_fi_rstp_t2
                                             ELSE                     nv_fi_rstp_t3   
                    sic_bran.uwm101.rfee_i = 0.00
                    sic_bran.uwm101.rtax_i = IF      n_index = 1 THEN (nv_prem01 + nv_fi_rstp_t1) * nv_fi_tax_per_ins / 100
                                             ELSE IF n_index = 2 THEN (nv_prem02 + nv_fi_rstp_t2) * nv_fi_tax_per_ins / 100
                                                                 ELSE (nv_prem03 + nv_fi_rstp_t3) * nv_fi_tax_per_ins / 100
                    n_ttprem               = n_ttprem + sic_bran.uwm101.prem_i 
                    n_ttcom1               = n_ttcom1 + sic_bran.uwm101.com1_i
                    n_ttcom2               = n_ttcom2 + sic_bran.uwm101.com2_i
                    n_ttrstp               = n_ttrstp + sic_bran.uwm101.rstp_i
                    n_ttrfee               = n_ttrfee + sic_bran.uwm101.rfee_i
                    n_ttrtax               = n_ttrtax + sic_bran.uwm101.rtax_i
                    sic_bran.uwm101.desc_i = IF      n_index = 1 THEN wdetail3.companyre1
                                             ELSE IF n_index = 2 THEN wdetail3.companyre2
                                                                 ELSE wdetail3.companyre3
                    sic_bran.uwm101.trty1i = ""
                    sic_bran.uwm101.docnoi = "".
                IF n_index = 1 THEN DO:
                    ASSIGN 
                    n_recid                = RECID(sic_bran.uwm101) 
                    sic_bran.uwm101.pstp_i = sic_bran.uwm100.pstp 
                    sic_bran.uwm101.pfee_i = sic_bran.uwm100.pfee
                    sic_bran.uwm101.ptax_i = sic_bran.uwm100.ptax.
                END.
                ELSE DO:
                    ASSIGN 
                        sic_bran.uwm101.pstp_i  = 0 
                        sic_bran.uwm101.pfee_i  = 0
                        sic_bran.uwm101.ptax_i  = 0.
                END.
                IF xmm031.insdef = "C" OR xmm031.insdef = "T" THEN DO:
                    
                    IF xmm031.insdef = "C" THEN sic_bran.uwm101.duedat = sic_bran.uwm100.comdat.
                            ELSE uwm101.duedat = uwm100.trndat.
                            nv_tmp_date = uwm101.duedat.
                            nv_d0       = DAY(nv_tmp_date).
                END.
            END.
            FIND FIRST sic_bran.uwm101 WHERE RECID(sic_bran.uwm101) = n_recid.
            IF AVAILABLE sic_bran.uwm101 THEN DO:
                sic_bran.uwm101.prem_i = sic_bran.uwm101.prem_i + (sic_bran.uwm100.prem_t - n_ttprem).
                /*sic_bran.uwm101.com1_i = sic_bran.uwm101.com1_i + (sic_bran.uwm100.com1_t - n_ttcom1).*/
                sic_bran.uwm101.com2_i = sic_bran.uwm101.com2_i + (sic_bran.uwm100.com2_t - n_ttcom2).
                sic_bran.uwm101.rstp_i = sic_bran.uwm101.rstp_i + (sic_bran.uwm100.rstp_t - n_ttrstp).
                sic_bran.uwm101.rfee_i = sic_bran.uwm101.rfee_i + (sic_bran.uwm100.rfee_t - n_ttrfee).
                sic_bran.uwm101.rtax_i = sic_bran.uwm101.rtax_i + (sic_bran.uwm100.rtax_t - n_ttrtax).
            END.
        END.  /*else do: */
        DO transaction:
            FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
                sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
                sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
                sic_bran.uwm101.instno = 1  exclusive-lock NO-ERROR.
        END.  /* Transaction */
        ASSIGN 
            n_index  = 1 
            n_ttprem = 0 
            n_ttcom1 = 0
            n_ttcom2 = 0
            n_ttrstp = 0 
            n_ttrfee = 0
            n_ttrtax = 0
            n_ttpstp = 0
            n_ttpfee = 0
            n_ttptax = 0 
            nv_fi_rstp_t1 = 0
            nv_fi_rstp_t2 = 0
            nv_fi_rstp_t3 = 0
            nv_com1p_ins1 = 0
            nv_com1p_ins2 = 0
            nv_com1p_ins3 = 0.
    END.  /* if */
END. /*End 100 */
RELEASE sic_bran.uwm101.
RELEASE sic_bran.uwm100.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_instot2 C-Win 
PROCEDURE proc_instot2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A68-0061
------------------------------------------------------------------------------*/
/**  uwo10085.p - NEW POLICY ENTRY - INSTALMENTS  **/
DEFINE        VAR n_recid   AS RECID.                                       
DEFINE        VAR n_ttprem  LIKE sic_bran.uwm100.prem_t.                   
DEFINE        VAR n_ttcom1  LIKE sic_bran.uwm100.com1_t.                    
DEFINE        VAR n_ttcom2  LIKE sic_bran.uwm100.com2_t.                    
DEFINE        VAR n_ttrstp  LIKE sic_bran.uwm100.rstp_t.                    
DEFINE        VAR n_ttrfee  LIKE sic_bran.uwm100.rfee_t.                    
DEFINE        VAR n_ttrtax  LIKE sic_bran.uwm100.rtax_t.                    
DEFINE        VAR n_ttpstp  LIKE sic_bran.uwm100.rstp_t.                    
DEFINE        VAR n_ttpfee  LIKE sic_bran.uwm100.rfee_t.                    
DEFINE        VAR n_ttptax  LIKE sic_bran.uwm100.rtax_t.                    
DEFINE        VAR n_index   AS INTEGER.                                    
DEFINE        VAR nv_d0     AS INT.                                         
DEFINE        VAR nv_tmp_date AS DATE.                                      
/*DEFINE  VAR s_recid1      AS RECID NO-UNDO.        /** uwm100 recid **/
DEFINE  VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 2015.
DEFINE  VAR  nv_batcnt    AS INT FORMAT "99"              INIT 1.
DEFINE  VAR  nv_batchno   AS CHARACTER FORMAT "X(18)"     INIT "B3M00170M0044"  NO-UNDO.*/
DEF VAR nv_fi_rstp_t1       AS DECI INIT 0.
DEF VAR nv_fi_rstp_t2       AS DECI INIT 0.
DEF VAR nv_fi_rstp_t3       AS DECI INIT 0.
DEF VAR nv_com1p_ins1       AS DECI INIT 0.
DEF VAR nv_com1p_ins2       AS DECI INIT 0.
DEF VAR nv_com1p_ins3       AS DECI INIT 0.
DEF VAR nv_prem01           AS DECI INIT 0.
DEF VAR nv_prem02           AS DECI INIT 0.
DEF VAR nv_prem03           AS DECI INIT 0.

/*FIND uwm100 WHERE            RECID(uwm100)           = s_recid1 exclusive-lock NO-ERROR.*/
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
/*FIND LAST  sic_bran.uwm100   Where 
    sic_bran.uwm100.policy = wdetail.policyno AND 
    sic_bran.uwm100.bchyr  = nv_batchyr       AND 
    sic_bran.uwm100.bchno  = nv_batchno       AND 
    sic_bran.uwm100.bchcnt = nv_batcnt        no-error no-wait.*/
IF AVAILABLE sic_bran.uwm100  THEN DO:
    ASSIGN s_recid1 = RECID(sic_bran.uwm100)
           sic_bran.uwm100.instot = wdetail3.instot  
           nv_fi_rstp_t1 = 0        nv_fi_rstp_t2 = 0
           nv_fi_rstp_t3 = 0        nv_com1p_ins1 = 0
           nv_com1p_ins2 = 0        nv_com1p_ins3 = 0
           nv_prem01     = 0        nv_prem02     = 0  
           nv_prem03     = 0  
           nv_fi_rstp_t1 = DECI(wdetail3.stam_re1)        
           nv_fi_rstp_t2 = DECI(wdetail3.stam_re2)
           nv_fi_rstp_t3 = DECI(wdetail3.stam_re3)       
           nv_prem01     = DECI(wdetail3.net_re1)       
           nv_prem02     = DECI(wdetail3.net_re2)  
           nv_prem03     = DECI(wdetail3.net_re3) .
   /* IF wdetail3.instot = 2 THEN DO:
        ASSIGN 
            nv_prem02 = (TRUNCATE(((deci(wdetail3.premt_re2)  * 100 ) / 107.43),0))       
            nv_prem01 = sic_bran.uwm100.prem_t - nv_prem02.                               
    END.
    ELSE DO:
        ASSIGN 
            nv_prem03 = (TRUNCATE(((deci(wdetail3.premt_re3)  * 100 ) / 107.43),0))
            nv_prem02 = (TRUNCATE(((deci(wdetail3.premt_re2)  * 100 ) / 107.43),0))
            nv_prem01 = sic_bran.uwm100.prem_t - nv_prem02 - nv_prem03.
    END.*/
    
    IF nv_prem01 > 0 THEN 
        ASSIGN 
        nv_com1p_ins1 = (nv_prem01 * nv_com1p_ins ) / 100 .
        /*nv_fi_rstp_t1 = Truncate(nv_prem01 * nv_fi_stamp_per_ins  / 100,0)  + 
                        IF      (nv_prem01 * nv_fi_stamp_per_ins  / 100) -
                        Truncate(nv_prem01 * nv_fi_stamp_per_ins  / 100,0) > 0 Then 1 Else 0*/ 
    IF nv_prem02 > 0 THEN 
        ASSIGN 
        nv_com1p_ins2 = (nv_prem02 * nv_com1p_ins ) / 100 .
        /*nv_fi_rstp_t2 = Truncate(nv_prem02 * nv_fi_stamp_per_ins / 100,0) + 
                            (IF (nv_prem02 * nv_fi_stamp_per_ins / 100) - 
                        Truncate(nv_prem02 * nv_fi_stamp_per_ins / 100,0) > 0 Then 1 Else 0 ).*/
    IF nv_prem03 > 0 THEN   
        ASSIGN 
        nv_com1p_ins3 = (nv_prem03 * nv_com1p_ins ) / 100 .
        /*nv_fi_rstp_t3 = Truncate(nv_prem03 * nv_fi_stamp_per_ins / 100,0) + 
                            (IF (nv_prem03 * nv_fi_stamp_per_ins / 100) - 
                        Truncate(nv_prem03 * nv_fi_stamp_per_ins / 100,0) > 0 Then 1 Else 0 ).*/
    
    FIND FIRST sic_bran.uwm101  USE-INDEX uwm10101 WHERE
        sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
        sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
        sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
        sic_bran.uwm101.bchyr  = nv_batchyr     AND
        sic_bran.uwm101.bchno  = nv_batchno     AND
        sic_bran.uwm101.bchcnt = nv_batcnt      NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sic_bran.uwm101  THEN DO:
        FOR EACH sic_bran.uwm101  USE-INDEX uwm10101   WHERE
            sic_bran.uwm101.policy = sic_bran.uwm100.policy  AND
            sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm101.bchyr  = nv_batchyr     AND
            sic_bran.uwm101.bchno  = nv_batchno     AND
            sic_bran.uwm101.bchcnt = nv_batcnt:
            DELETE sic_bran.uwm101.
        END.  /* each uwm101 */
        RELEASE sic_bran.uwm101.
    END.       /* avail uwm101 */
    IF sic_bran.uwm100.instot > 1 THEN DO: 
        ASSIGN 
            n_ttprem = 0
            n_ttcom1 = 0
            n_ttcom2 = 0
            n_ttpstp = 0
            n_ttpfee = 0
            n_ttptax = 0
            n_ttrstp = 0
            n_ttrfee = 0
            n_ttrtax = 0.
        DO transaction:
            FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 exclusive-lock NO-ERROR.
        END.
        FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR.
        Do transaction:
            FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
                sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
                sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
                sic_bran.uwm101.bchyr  = nv_batchyr             AND
                sic_bran.uwm101.bchno  = nv_batchno             AND
                sic_bran.uwm101.bchcnt = nv_batcnt              AND
                sic_bran.uwm101.instno = 1 exclusive-lock NO-ERROR.
        END.
        IF NOT AVAILABLE sic_bran.uwm101 THEN DO transaction:
            REPEAT n_index = 1 TO sic_bran.uwm100.instot:
                CREATE sic_bran.uwm101.
                ASSIGN 
                    sic_bran.uwm101.policy = sic_bran.uwm100.policy 
                    sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt 
                    sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt
                    sic_bran.uwm101.bchyr  = nv_batchyr        
                    sic_bran.uwm101.bchno  = nv_batchno            
                    sic_bran.uwm101.bchcnt = nv_batcnt  
                    sic_bran.uwm101.instno = n_index
                    sic_bran.uwm101.prem_i = IF      n_index = 1 THEN nv_prem01
                                             ELSE IF n_index = 2 THEN nv_prem02
                                                                 ELSE nv_prem03
                    sic_bran.uwm101.com1_i = IF      n_index = 1 THEN nv_com1p_ins1 * ( -1 )
                                             ELSE IF n_index = 2 THEN nv_com1p_ins2 * ( -1 )
                                                                 ELSE nv_com1p_ins3 * ( -1 )
                    sic_bran.uwm101.com2_i = 0.00
                    sic_bran.uwm101.rstp_i = IF      n_index = 1 THEN nv_fi_rstp_t1
                                             ELSE IF n_index = 2 THEN nv_fi_rstp_t2
                                             ELSE                     nv_fi_rstp_t3   
                    sic_bran.uwm101.rfee_i = 0.00
                    sic_bran.uwm101.rtax_i = IF      n_index = 1 THEN deci(wdetail3.vat_re1)  /*(nv_prem01 + nv_fi_rstp_t1) * nv_fi_tax_per_ins / 100 */
                                             ELSE IF n_index = 2 THEN deci(wdetail3.vat_re2)  /*(nv_prem02 + nv_fi_rstp_t2) * nv_fi_tax_per_ins / 100 */
                                                                 ELSE deci(wdetail3.vat_re3)  /*(nv_prem03 + nv_fi_rstp_t3) * nv_fi_tax_per_ins / 100 */
                    n_ttprem               = n_ttprem + sic_bran.uwm101.prem_i 
                    n_ttcom1               = n_ttcom1 + sic_bran.uwm101.com1_i
                    n_ttcom2               = n_ttcom2 + sic_bran.uwm101.com2_i
                    n_ttrstp               = n_ttrstp + sic_bran.uwm101.rstp_i
                    n_ttrfee               = n_ttrfee + sic_bran.uwm101.rfee_i
                    n_ttrtax               = n_ttrtax + sic_bran.uwm101.rtax_i
                    sic_bran.uwm101.desc_i = IF      n_index = 1 THEN wdetail3.companyre1
                                             ELSE IF n_index = 2 THEN wdetail3.companyre2
                                                                 ELSE wdetail3.companyre3
                    sic_bran.uwm101.trty1i = ""
                    sic_bran.uwm101.docnoi = "".
                IF n_index = 1 THEN DO:
                    ASSIGN 
                    n_recid                = RECID(sic_bran.uwm101) 
                    sic_bran.uwm101.pstp_i = sic_bran.uwm100.pstp 
                    sic_bran.uwm101.pfee_i = sic_bran.uwm100.pfee
                    sic_bran.uwm101.ptax_i = sic_bran.uwm100.ptax.
                END.
                ELSE DO:
                    ASSIGN 
                        sic_bran.uwm101.pstp_i  = 0 
                        sic_bran.uwm101.pfee_i  = 0
                        sic_bran.uwm101.ptax_i  = 0.
                END.
                IF xmm031.insdef = "C" OR xmm031.insdef = "T" THEN DO:
                    
                    IF xmm031.insdef = "C" THEN sic_bran.uwm101.duedat = sic_bran.uwm100.comdat.
                            ELSE uwm101.duedat = uwm100.trndat.
                            nv_tmp_date = uwm101.duedat.
                            nv_d0       = DAY(nv_tmp_date).
                END.
            END.
            FIND FIRST sic_bran.uwm101 WHERE RECID(sic_bran.uwm101) = n_recid.
            IF AVAILABLE sic_bran.uwm101 THEN DO:
                sic_bran.uwm101.prem_i = sic_bran.uwm101.prem_i + (sic_bran.uwm100.prem_t - n_ttprem).
                /*sic_bran.uwm101.com1_i = sic_bran.uwm101.com1_i + (sic_bran.uwm100.com1_t - n_ttcom1).*/
                sic_bran.uwm101.com2_i = sic_bran.uwm101.com2_i + (sic_bran.uwm100.com2_t - n_ttcom2).
                sic_bran.uwm101.rstp_i = sic_bran.uwm101.rstp_i + (sic_bran.uwm100.rstp_t - n_ttrstp).
                sic_bran.uwm101.rfee_i = sic_bran.uwm101.rfee_i + (sic_bran.uwm100.rfee_t - n_ttrfee).
                sic_bran.uwm101.rtax_i = sic_bran.uwm101.rtax_i + (sic_bran.uwm100.rtax_t - n_ttrtax).
            END.
        END.  /*else do: */
        DO transaction:
            FIND sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                sic_bran.uwm101.policy = sic_bran.uwm100.policy AND
                sic_bran.uwm101.rencnt = sic_bran.uwm100.rencnt AND 
                sic_bran.uwm101.endcnt = sic_bran.uwm100.endcnt AND
                sic_bran.uwm101.instno = 1  exclusive-lock NO-ERROR.
        END.  /* Transaction */
        ASSIGN 
            n_index  = 1 
            n_ttprem = 0 
            n_ttcom1 = 0
            n_ttcom2 = 0
            n_ttrstp = 0 
            n_ttrfee = 0
            n_ttrtax = 0
            n_ttpstp = 0
            n_ttpfee = 0
            n_ttptax = 0 
            nv_fi_rstp_t1 = 0
            nv_fi_rstp_t2 = 0
            nv_fi_rstp_t3 = 0
            nv_com1p_ins1 = 0
            nv_com1p_ins2 = 0
            nv_com1p_ins3 = 0.
    END.  /* if */
END. /*End 100 */
RELEASE sic_bran.uwm101.
RELEASE sic_bran.uwm100.

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
IF nv_dgender = "" THEN DO:
    IF      nv_ntitle = "นางสาว" THEN  ASSIGN  nv_dgender = "FEMALE" .
    else IF nv_ntitle = "น.ส."   THEN  ASSIGN  nv_dgender = "FEMALE" .
    else IF nv_ntitle = "นาง"    THEN  ASSIGN  nv_dgender = "FEMALE" .
    else IF nv_ntitle = "นาย"    THEN  ASSIGN  nv_dgender = "MALE" .
    ELSE ASSIGN  nv_dgender = "MALE" .
END.

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
                 brstat.mailtxt_fil.drivnam    = nv_drinam 
                 brstat.mailtxt_fil.titlenam   = nv_ntitle
                 brstat.mailtxt_fil.firstnam   = nv_name  
                 brstat.mailtxt_fil.lastnam    = nv_lname 
                 brstat.mailtxt_fil.drivbirth  = IF trim(nv_dribirth) <> "" THEN date(nv_dribirth) ELSE ? /* ค.ศ */
                 brstat.mailtxt_fil.drivage    = nv_dage
                 brstat.mailtxt_fil.occupcod   = IF nv_doccup  = "" THEN "-" ELSE nv_doccup 
                 brstat.mailtxt_fil.drividno   = nv_dicno
                 brstat.mailtxt_fil.licenno    = nv_ddriveno
                 brstat.mailtxt_fil.gender     = nv_dgender
                 brstat.mailtxt_fil.drivlevel  = nv_dlevel
                 brstat.mailtxt_fil.levelper   = deci(nv_dlevper)
                 brstat.mailtxt_fil.licenexp   = IF trim(nv_drivexp) <> "" THEN DATE(nv_drivexp) ELSE ?
                 brstat.mailtxt_fil.dconsen    = IF nv_dconsent = "Y" THEN YES ELSE IF nv_dconsent = "YES" THEN YES ELSE NO
                 brstat.mailtxt_fil.occupdes   = "-"
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
             brstat.mailtxt_fil.drivnam    = nv_drinam 
             brstat.mailtxt_fil.titlenam   = nv_ntitle
             brstat.mailtxt_fil.firstnam   = nv_name  
             brstat.mailtxt_fil.lastnam    = nv_lname 
             brstat.mailtxt_fil.drivbirth  = IF trim(nv_dribirth) <> "" THEN date(nv_dribirth) ELSE ? /* ค.ศ. */
             brstat.mailtxt_fil.drivage    = nv_dage
             brstat.mailtxt_fil.occupcod   = IF nv_doccup  = "" THEN "-" ELSE nv_doccup   
             brstat.mailtxt_fil.drividno   = nv_dicno
             brstat.mailtxt_fil.licenno    = nv_ddriveno
             brstat.mailtxt_fil.gender     = nv_dgender
             brstat.mailtxt_fil.drivlevel  = nv_dlevel
             brstat.mailtxt_fil.levelper   = deci(nv_dlevper)
             brstat.mailtxt_fil.licenexp   = IF trim(nv_drivexp) <> "" THEN DATE(nv_drivexp) ELSE ?
             brstat.mailtxt_fil.dconsen    = IF nv_dconsent = "Y" THEN YES ELSE IF nv_dconsent = "YES" THEN YES ELSE NO
             brstat.mailtxt_fil.occupdes   = "-"
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
FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  wdetail2.prempa + wdetail2.subclass NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN n_ratmin = makdes31.si_theft_p   
    n_ratmax = makdes31.load_p   .    
ELSE ASSIGN n_ratmin = 0
    n_ratmax = 0.
/* create by : Ranu I.  A60-0505 28/11/2017 */
IF (INDEX(wdetail.model,"CIVIC") <> 0 ) OR (INDEX(wdetail.model,"CITY") <> 0 ) THEN DO:  /*A63-00472*/
    IF INDEX(wdetail.carcode,"HATCHBACK") <> 0 THEN DO:
        IF (wdetail.si = "") OR (wdetail.si = "0.00") OR (deci(wdetail.si) = 0 ) THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.sclass   =     wdetail2.subclass        AND
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    AND 
                stat.maktab_fil.body     =     "HATCHBACK"              No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN  wdetail2.redbook =  stat.maktab_fil.modcod
                sic_bran.uwm301.modcod   =  stat.maktab_fil.modcod                                    
                sic_bran.uwm301.body     =  stat.maktab_fil.body
                wdetail.body             =  stat.maktab_fil.body
                sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
                wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
                sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     wdetail2.subclass        AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE  deci(wdetail.si)    AND
                 stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE  deci(wdetail.si) )  AND  
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       AND 
                stat.maktab_fil.body     =     "HATCHBACK"
                No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN  wdetail2.redbook =  stat.maktab_fil.modcod
                sic_bran.uwm301.modcod   =  stat.maktab_fil.modcod                                    
                wdetail.body             =  stat.maktab_fil.body
                sic_bran.uwm301.body     =  stat.maktab_fil.body
                sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
                wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
                sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
        END.
        IF wdetail2.redbook = "" THEN 
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.sclass   =     wdetail2.subclass        AND
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    AND 
                stat.maktab_fil.body     =     "HATCHBACK"              No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN  wdetail2.redbook =  stat.maktab_fil.modcod
                sic_bran.uwm301.modcod   =  stat.maktab_fil.modcod                                    
                sic_bran.uwm301.body     =  stat.maktab_fil.body
                wdetail.body             =  stat.maktab_fil.body
                sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
                wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
                sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
    END.
    ELSE DO:
         IF (wdetail.si = "") OR (wdetail.si = "0.00") OR (deci(wdetail.si) = 0 ) THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.sclass   =     wdetail2.subclass        AND
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    AND 
                stat.maktab_fil.body     =     "SEDAN"      No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN  wdetail2.redbook =  stat.maktab_fil.modcod
                sic_bran.uwm301.modcod   =  stat.maktab_fil.modcod                                    
                sic_bran.uwm301.body     =  stat.maktab_fil.body
                wdetail.body             =  stat.maktab_fil.body
                sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
                wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
                sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     wdetail2.subclass        AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE  deci(wdetail.si)    AND
                 stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE  deci(wdetail.si) )  AND  
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       AND 
                stat.maktab_fil.body     =     "SEDAN"
                No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN  wdetail2.redbook =  stat.maktab_fil.modcod
                sic_bran.uwm301.modcod   =  stat.maktab_fil.modcod                                    
                wdetail.body             =  stat.maktab_fil.body
                sic_bran.uwm301.body     =  stat.maktab_fil.body
                sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
                wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
                sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
        END.
        IF wdetail2.redbook = ""  THEN
             Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.sclass   =     wdetail2.subclass        AND
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    AND 
                stat.maktab_fil.body     =     "SEDAN"      No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN  wdetail2.redbook  =  stat.maktab_fil.modcod
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                wdetail.body            =  stat.maktab_fil.body
                sic_bran.uwm301.body    =  stat.maktab_fil.body
                sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
                sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
                wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
                sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
    END.
END.
ELSE DO: 
/*end : A60-0505 */
    IF (wdetail.si = "") OR (wdetail.si = "0.00") OR (deci(wdetail.si) = 0 ) THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =     wdetail.brand            And                  
            index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
            /*stat.maktab_fil.engine =     Integer(wdetail.engcc)   AND*/
            stat.maktab_fil.sclass   =     wdetail2.subclass        AND
            stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN  wdetail2.redbook =  stat.maktab_fil.modcod
            sic_bran.uwm301.modcod   =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.body     =  stat.maktab_fil.body
            sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
            wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
            sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
            wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
            sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
    END.
    ELSE DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =     wdetail.brand            And                  
            index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
            stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
            stat.maktab_fil.sclass   =     wdetail2.subclass        AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE  deci(wdetail.si)    AND
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE  deci(wdetail.si) )  AND  
            stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
            No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN  wdetail2.redbook =  stat.maktab_fil.modcod
            sic_bran.uwm301.modcod   =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.body     =  stat.maktab_fil.body
            sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
            wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
            sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
            wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
            sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
    END.
    IF index(trim(wdetail.model) +  trim(wdetail.carcode),"HATCHBACK") <> 0 THEN  sic_bran.uwm301.body  = "HATCHBACK". /*A68-0061*/
    
END.
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab2 C-Win 
PROCEDURE proc_maktab2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Find First stat.maktab_fil USE-INDEX maktab04    Where
    stat.maktab_fil.makdes   =     wdetail.brand            And                  
    index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
    stat.maktab_fil.sclass   =     wdetail2.subclass        AND
    stat.maktab_fil.seats    =     INTEGER(wdetail.seat)      No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    ASSIGN  
    wdetail2.redbook  =  stat.maktab_fil.modcod
    sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
    /*wdetail.cargrp          =  stat.maktab_fil.prmpac */   /* Ranu I. A64-0328 01/101/2021*/
    /*sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac */   /* Ranu I. A64-0328 01/101/2021*/
    sic_bran.uwm301.body    =  stat.maktab_fil.body
    wdetail.body            =  stat.maktab_fil.body
    /*sic_bran.uwm301.engine  =  stat.maktab_fil.eng*/ /* Ranu I. A64-0328 01/101/2021*/
    /*nv_engine               =  stat.maktab_fil.eng*/ /* Ranu I. A64-0328 01/101/2021*/
    /* Ranu I. A64-0328 01/101/2021*/
    sic_bran.uwm301.vehgrp  =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp 
    wdetail.cargrp          =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
    sic_bran.uwm301.engine  =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
    wdetail.engcc           =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
    sic_bran.uwm301.seats   =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
    /* end A64-0328 */
    IF index(trim(wdetail.model) +  trim(wdetail.carcode),"HATCHBACK") <> 0 THEN  sic_bran.uwm301.body  = "HATCHBACK". /*A68-0061*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab3 C-Win 
PROCEDURE proc_maktab3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =     wdetail.brand            And                  
            index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
            /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
            stat.maktab_fil.sclass   =     wdetail2.subclass        AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE  deci(wdetail.si)    AND
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE  deci(wdetail.si) )  AND  
            stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
            No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN  wdetail2.redbook =  stat.maktab_fil.modcod
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/
            /*wdetail.cargrp          =  stat.maktab_fil.prmpac*/   /* Ranu I. A64-0328 01/101/2021*/
            /*sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac*/   /* Ranu I. A64-0328 01/101/2021*/
            sic_bran.uwm301.body    =  stat.maktab_fil.body
            /*sic_bran.uwm301.engine  =  stat.maktab_fil.eng*/      /* Ranu I. A64-0328 01/101/2021*/
            /*nv_engine               =  stat.maktab_fil.eng.*/    /* Ranu I. A64-0328 01/101/2021*/
            /* Ranu I. A64-0328 01/101/2021*/
            sic_bran.uwm301.vehgrp  =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp 
            wdetail.cargrp          =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
            sic_bran.uwm301.engine  =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
            wdetail.engcc           =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
            sic_bran.uwm301.seats   =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
            /* end A64-0328 */
        IF index(trim(wdetail.model) +  trim(wdetail.carcode),"HATCHBACK") <> 0 THEN  sic_bran.uwm301.body  = "HATCHBACK". /*A68-0061*/
    
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab4 C-Win 
PROCEDURE proc_maktab4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_subclass AS CHAR FORMAT "x(10)" INIT "".
DEF VAR nv_model72  AS CHAR FORMAT "x(50)" INIT "".
IF      wdetail2.subclass = "110" THEN nv_subclass = "110".
ELSE IF wdetail2.subclass = "120" THEN nv_subclass = "110".
ELSE IF wdetail2.subclass = "210" OR  wdetail2.subclass = "120A" THEN nv_subclass = "210".
ELSE IF wdetail2.subclass = "220" or  wdetail2.subclass = "120A" THEN nv_subclass = "210".
ELSE IF wdetail2.subclass = "320" or  wdetail2.subclass = "140A" THEN nv_subclass = "320".
ELSE  nv_subclass = "110".

IF (INDEX(wdetail.model,"CIVIC") <> 0 )  THEN DO:
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,"CIVIC") <> 0              And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.sclass   =     nv_subclass               No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN  
        wdetail2.redbook         =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod   =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.body     =  stat.maktab_fil.body
        wdetail.body             =  stat.maktab_fil.body
        sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
        wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
        sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
        wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
        sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .

END.
ELSE IF (INDEX(wdetail.model,"CITY") <> 0 ) THEN DO:  
    Find First stat.maktab_fil USE-INDEX maktab04           Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,"CITY") <> 0               And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.sclass   =     nv_subclass               No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN  
        wdetail2.redbook         =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod   =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.body     =  stat.maktab_fil.body
        wdetail.body             =  stat.maktab_fil.body
        sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
        wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
        sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
        wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
        sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
END.
ELSE DO:
    IF INDEX(wdetail.model," ") <> 0  THEN nv_model72 = trim(SUBSTR(trim(wdetail.model),1,INDEX(trim(wdetail.model)," "))) .
    ELSE nv_model72 = trim(wdetail.model).

    Find First stat.maktab_fil USE-INDEX maktab04           Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        /*index(stat.maktab_fil.moddes,"CITY") <> 0               And*/
        index(stat.maktab_fil.moddes,nv_model72) <> 0               And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.sclass   =     nv_subclass               No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN  
        wdetail2.redbook         =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod   =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.body     =  stat.maktab_fil.body
        wdetail.body             =  stat.maktab_fil.body
        sic_bran.uwm301.vehgrp   =  if sic_bran.uwm301.vehgrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
        wdetail.cargrp           =  IF wdetail.cargrp = "" THEN stat.maktab_fil.prmpac ELSE sic_bran.uwm301.vehgrp
        sic_bran.uwm301.engine   =  IF sic_bran.uwm301.engine = 0 then stat.maktab_fil.engine ELSE sic_bran.uwm301.engine  
        wdetail.engcc            =  IF sic_bran.uwm301.engine = 0 then string(stat.maktab_fil.engine) ELSE string(sic_bran.uwm301.engine)
        sic_bran.uwm301.seats    =  IF sic_bran.uwm301.seats  = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats .
END. 
IF index(trim(wdetail.model) +  trim(wdetail.carcode),"HATCHBACK") <> 0 THEN  sic_bran.uwm301.body  = "HATCHBACK". /*A68-0061*/

OUTPUT TO D:\temp\LogTimeHCT_maktab4.TXT APPEND.
PUT "010: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
PUT "policyno:"     wdetail.policyno FORMAT "x(20)" skip.
PUT "brand:"        wdetail.brand    FORMAT "x(20)" skip.
PUT "model:"        wdetail.model    FORMAT "x(50)" skip.
PUT "caryear:"      wdetail.caryear  FORMAT "x(10)" skip.
PUT "nv_subclass:"  nv_subclass      FORMAT "x(10)" skip.
PUT "redbook:"      wdetail2.redbook FORMAT "x(20)" skip.
 
OUTPUT CLOSE.

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
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y".   */
OPEN QUERY br_wdetail FOR EACH wdetail 
    ,EACH wdetail2 WHERE wdetail2.pass = "y" 
                     AND wdetail2.policyno = wdetail.policyno .

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
ASSIGN fi_process = "Import data HCT...." + wdetail.policyno .   
DISP fi_process WITH FRAM fr_main.
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
IF wdetail2.poltyp = "v72" THEN n_rencnt = 0.  
IF wdetail.policyno <> "" THEN DO:
  IF wdetail.stk  <>  ""  THEN DO: 
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
    ELSE chr_sticker = wdetail.stk.
    chk_sticker = chr_sticker.
    RUN wuz\wuzchmod.
    IF chk_sticker  <>  chr_sticker  Then ASSIGN  wdetail2.pass    = "N"
        wdetail2.comment = wdetail2.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error". 
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
      sicuw.uwm100.cedpol = trim(substr(wdetail.policyno,2,12) + "-" + wdetail2.comrequest) AND 
      sicuw.uwm100.poltyp = wdetail2.poltyp NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      /*IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES  THEN */ /*A67-0065*/
      IF sicuw.uwm100.name1 <> "" AND sicuw.uwm100.comdat <> ? AND sicuw.uwm100.polsta = "IF" OR (sicuw.uwm100.releas <> YES ) THEN  /*A67-0065*/
        ASSIGN  wdetail2.pass    = "N"
                wdetail2.comment = wdetail2.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "    
                wdetail2.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.
    nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
    ELSE wdetail.stk = wdetail.stk.
    FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
               stat.detaitem.serailno = trim(wdetail.stk) NO-LOCK NO-ERROR.
    IF AVAIL stat.detaitem THEN  
      ASSIGN  wdetail2.pass    = "N"
              wdetail2.comment = wdetail2.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"  
              wdetail2.warning = "Program Running Policy No. ให้ชั่วคราว".
    IF wdetail.policyno = "" THEN DO:
      RUN proc_temppolicy.
      wdetail.policyno  = nv_tmppol.
    END.
    RUN proc_create100.
  END.
  ELSE DO: /*sticker = ""*/ 
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
              sicuw.uwm100.cedpol = trim(substr(wdetail.policyno,2,12) + "-" + wdetail2.comrequest) AND 
              sicuw.uwm100.poltyp = wdetail2.poltyp  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      /*IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES  THEN */ /*A67-0065*/
      IF sicuw.uwm100.name1 <> "" AND sicuw.uwm100.comdat <> ? AND sicuw.uwm100.polsta = "IF" OR (sicuw.uwm100.releas <> YES ) THEN  /*A67-0065*/
          ASSIGN wdetail2.pass    = "N"
          wdetail2.comment = wdetail2.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  
          wdetail2.warning = "Program Running Policy No. ให้ชั่วคราว".
      IF wdetail.policyno = "" THEN DO:
          RUN proc_temppolicy.
          wdetail.policyno  = nv_tmppol.
      END.
      RUN proc_create100. 
    END.   /*policy <> "" & stk = ""*/                 
    ELSE RUN proc_create100. 
  END.
END.
ELSE DO:  /*wdetail.policyno = ""*/
  IF wdetail.stk  <>  ""  THEN DO:
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
    ELSE chr_sticker = wdetail.stk.
    chk_sticker = chr_sticker.
    RUN wuz\wuzchmod.
    IF chk_sticker  <>  chr_sticker  Then 
      ASSIGN  wdetail2.pass    = "N"
      wdetail2.comment = wdetail2.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".  
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
        sicuw.uwm100.cedpol = trim(substr(wdetail.policyno,2,12) + "-" + wdetail2.comrequest) AND 
        sicuw.uwm100.poltyp = wdetail2.poltyp  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      /*IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES  THEN */ /*A67-0065*/
      IF sicuw.uwm100.name1 <> "" AND sicuw.uwm100.comdat <> ? AND sicuw.uwm100.polsta = "IF" OR ( sicuw.uwm100.releas <> YES ) THEN  /*A67-0065*/ 
        ASSIGN  wdetail2.pass    = "N"
        wdetail2.comment = wdetail2.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
        wdetail2.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.
    nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
    ELSE wdetail.stk = wdetail.stk.
    FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
      stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
    IF AVAIL stat.detaitem THEN 
      ASSIGN  wdetail2.pass    = "N"
      wdetail2.comment = wdetail2.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
      wdetail2.warning = "Program Running Policy No. ให้ชั่วคราว".
    IF wdetail.policyno = "" THEN DO:
      RUN proc_temppolicy.
      wdetail.policyno  = nv_tmppol.
    END.
    RUN proc_create100.
  END.
  ELSE DO: 
    IF wdetail.policyno = "" THEN DO:
      RUN proc_temppolicy.
      wdetail.policyno  = nv_tmppol.
    END.
    RUN proc_create100.
  END.
END.
s_recid1  =  Recid(sic_bran.uwm100).
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = wdetail2.poltyp  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL  sicsyac.xmm031 THEN nv_dept = sicsyac.xmm031.dept.
IF wdetail2.poltyp = "V70"  AND wdetail2.Docno <> ""  THEN ASSIGN  nv_docno  = wdetail2.Docno   nv_accdat = TODAY.
ELSE DO:
  IF wdetail2.docno  = "" THEN nv_docno  = "".
  IF wdetail2.accdat = "" THEN nv_accdat = TODAY.
END.
IF DECI(substr(wdetail.comdat,7,4)) > (YEAR(TODAY) + 2)  THEN wdetail.comdat = substr(wdetail.comdat,1,6) + STRING(DECI(substr(wdetail.comdat,7,4)) - 543).
IF DECI(substr(wdetail.expdat,7,4)) > (YEAR(TODAY) + 3)  THEN wdetail.expdat = substr(wdetail.expdat,1,6) + STRING(DECI(substr(wdetail.expdat,7,4)) - 543).
IF wdetail.prepol = "" THEN n_firstdat = DATE(wdetail.comdat). 
IF wdetail2.TYPE_notify = "N" THEN DO: 
  IF wdetail2.detailcam  = "" THEN ASSIGN wdetail2.special2 = " ". 
  ELSE IF INDEX(wdetail2.detailcam,"CAMPAIGN") <> 0 THEN ASSIGN wdetail2.special2 = TRIM(SUBSTR(wdetail2.detailcam,1,INDEX(wdetail2.detailcam," "))).
  ELSE wdetail2.special2 = TRIM(wdetail2.detailcam). 
END.
ELSE DO:
  RUN proc_detailcampromo. 
END.
IF trim(wdetail.insnam) = "ฮอนด้า ออโตโมบิล (ประเทศไทย) จำกัด" THEN ASSIGN nv_insref = "MC15275" . /*A67-0065*/
ELSE DO:
    RUN proc_insnam.  
    RUN proc_insnam2.  /*Add by Kridtiya i. A63-0472*/
END.
IF wdetail3.instot = 1 THEN DO:
  ASSIGN wdetail2.typrequest = "" .
  IF (trim(wdetail2.voictitle) = "0")  THEN DO:
    FIND LAST stat.insure USE-INDEX insure01 WHERE 
      stat.insure.compno = "HCT" AND
      stat.insure.lname  = wdetail2.voicnam   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL stat.insure THEN  
      ASSIGN wdetail2.voicnam   = trim(stat.insure.fname)
      wdetail2.typrequest   = trim(stat.insure.vatcode).  /*เปลี่ยน เป็นเก็บค่า vatcode.*/
    IF (INDEX(wdetail2.voicnam,wdetail.insnam) <>  0 ) THEN  wdetail2.voicnam = "".  
    ELSE ASSIGN wdetail2.name4  = "และ/หรือ " + TRIM(wdetail2.voicnam).
  END.
  ELSE IF wdetail2.voictitle = "1" THEN wdetail2.typrequest  = "".  /*ลูกค้า*/
  ELSE RUN proc_policyname3.  
END.
ELSE DO: /*wdetail3.instot = 1*/
  ASSIGN wdetail2.typrequest = "".
  IF index(trim(wdetail3.companyre2),trim(wdetail.insnam)) = 0 THEN DO:
    IF index(trim(wdetail3.companyre3),trim(wdetail.insnam)) <> 0 THEN 
        ASSIGN wdetail3.companyre3 = trim(nv_insref) + " " + trim(wdetail3.companyre3).
  END.
  ELSE ASSIGN wdetail3.companyre2 = trim(nv_insref) + " " + trim(wdetail3.companyre2).
END.

IF DATE(wdetail.comdat) < 04/01/2020 THEN DO: /* a63-0112 */
  IF      index(wdetail2.detailcam,"super pack")    <> 0  THEN RUN proc_policyname4.  /*A61-0324*/ 
  ELSE IF index(wdetail2.detailcam,"Triple Pack")   <> 0  THEN RUN proc_policyname4.  /*A62-0493*/
END.

IF (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2")   THEN RUN proc_policyname4. /*A63-0443*/
IF index(wdetail2.detailcam,"HEI 20-D")           <> 0    THEN RUN proc_policyname4. /*A63-0206*/
ELSE IF index(wdetail2.detailcam,"HATC CAMPAIGN") <> 0    THEN RUN proc_policyname4. /*A63-0206*/
ELSE IF trim(wdetail2.detailcam) <> ""  THEN RUN proc_policyname4. /* A64-0328 */

IF nv_insref = ""  THEN 
    ASSIGN wdetail2.comment = wdetail2.comment + "|รหัสลูกค้าเป็นค่าว่าง เช็ครันนิ่ง insured code (XZM056) สาขา " + wdetail2.n_branch 
           wdetail2.pass    = "N" 
           WDETAIL2.OK_GEN  = "N" .
DO TRANSACTION:
  ASSIGN
    sic_bran.uwm100.renno  = ""
    sic_bran.uwm100.endno  = ""
    sic_bran.uwm100.poltyp = wdetail2.poltyp
    sic_bran.uwm100.insref = trim(nv_insref)                         /* A55-0268 */ 
    sic_bran.uwm100.opnpol = IF TRIM(wdetail3.camp_no) = "" THEN CAPS(TRIM(wdetail3.payment_type)) 
                             ELSE trim(CAPS(TRIM(wdetail3.payment_type)) + " " + CAPS(TRIM(wdetail3.camp_no))) /*a60-0498*/
    sic_bran.uwm100.anam2  = trim(wdetail.Icno)                    /* ICNO  Cover Note A51-0071 Amparat */
    sic_bran.uwm100.ntitle = wdetail.tiname              
    sic_bran.uwm100.name1  = wdetail.insnam + " " + wdetail.name3              
    sic_bran.uwm100.name2  = wdetail2.name4                         /*A57-0073*/
    sic_bran.uwm100.name3  = wdetail3.name3                 
    sic_bran.uwm100.addr1  = wdetail.addr               
    sic_bran.uwm100.addr2  = wdetail.tambon                 
    sic_bran.uwm100.addr3  = wdetail.amper                  
    sic_bran.uwm100.addr4  = wdetail.country 
    sic_bran.uwm100.undyr  = String(Year(today),"9999")           /*  nv_undyr  */
    sic_bran.uwm100.branch = wdetail2.n_branch                    /* nv_branch  */                        
    sic_bran.uwm100.dept   = nv_dept
    sic_bran.uwm100.usrid  = USERID(LDBNAME(1))
    sic_bran.uwm100.fstdat = n_firstdat                       /*kridtiya i. a53-0220*/
    sic_bran.uwm100.comdat = DATE(wdetail.comdat)
    sic_bran.uwm100.expdat = date(wdetail.expdat)
    sic_bran.uwm100.accdat = nv_accdat                    
    sic_bran.uwm100.tranty = "N"                              /*Transaction Type (N/R/E/C/T)*/
    sic_bran.uwm100.langug = "T"
    sic_bran.uwm100.acctim = "00:00"
    sic_bran.uwm100.trty11 = "M"      
    sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")     
    sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")
    sic_bran.uwm100.entdat = TODAY
    sic_bran.uwm100.curbil = "BHT"
    sic_bran.uwm100.curate = 1
    sic_bran.uwm100.instot = wdetail3.instot                  /*A58-0197*/
    sic_bran.uwm100.prog   = "wgwhcgen"
    sic_bran.uwm100.cntry  = "TH"                  /*Country where risk is situated*/
    sic_bran.uwm100.insddr = YES                   /*Print Insd. Name on DrN       */
    sic_bran.uwm100.no_sch = 0                     /*No. to print, Schedule        */
    sic_bran.uwm100.no_dr  = 1                     /*No. to print, Dr/Cr Note      */
    sic_bran.uwm100.no_ri  = 0                     /*No. to print, RI Appln        */
    sic_bran.uwm100.no_cer = 0                     /*No. to print, Certificate     */
    sic_bran.uwm100.li_sch = YES                   /*Print Later/Imm., Schedule    */
    sic_bran.uwm100.li_dr  = YES                   /*Print Later/Imm., Dr/Cr Note  */
    sic_bran.uwm100.li_ri  = YES                   /*Print Later/Imm., RI Appln,   */
    sic_bran.uwm100.li_cer = YES                   /*Print Later/Imm., Certificate */
    sic_bran.uwm100.apptax = YES                   /*Apply risk level tax (Y/N)    */
    sic_bran.uwm100.recip  = "N"                   /*Reciprocal (Y/N/C)            */
    sic_bran.uwm100.short  = NO                    
    sic_bran.uwm100.acno1  = wdetail2.producer               /*Kridtiya i. A55-0151*/
    sic_bran.uwm100.agent  = fi_agent           /*nv_agent   */
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
    sic_bran.uwm100.dir_ri =  YES
    sic_bran.uwm100.drn_p  =  NO
    sic_bran.uwm100.sch_p  =  NO
    sic_bran.uwm100.cr_1   = trim(wdetail2.special2)  /* Product */
    sic_bran.uwm100.cr_2   = wdetail2.cr_2
    sic_bran.uwm100.bchyr  = nv_batchyr          /*Batch Year */  
    sic_bran.uwm100.bchno  = nv_batchno          /*Batch No.  */  
    sic_bran.uwm100.bchcnt = nv_batcnt           /*Batch Count*/  
    sic_bran.uwm100.prvpol = wdetail.prepol      /*A52-0172   */
    sic_bran.uwm100.cedpol = substr(wdetail.policyno,2,12) + "-" + wdetail2.comrequest
    sic_bran.uwm100.finint = wdetail2.n_delercode 
    sic_bran.uwm100.dealer = wdetail3.financecd      /*Add by Kridtiya i. A63-0472*/
    sic_bran.uwm100.bs_cd  = wdetail2.typrequest     /*add kridtiya i. A53-0027 เพิ่ม Vatcode*/
    sic_bran.uwm100.occupn  = trim(wdetail.occup)     /*A55-0274  อาชีพ*/
    sic_bran.uwm100.endern  = date(wdetail2.ac_date)   /*add kridtiya i. A53-0171 เพิ่มวันที่รับเงิน*/
    sic_bran.uwm100.firstName  = TRIM(wdetail3.firstName)     /*Add by Kridtiya i. A63-0472*/ 
    sic_bran.uwm100.lastName   = TRIM(wdetail3.lastName)      /*Add by Kridtiya i. A63-0472*/ 
    sic_bran.uwm100.postcd     = trim(wdetail.post)           /*Add by Kridtiya i. A63-0472*/ 
    sic_bran.uwm100.icno       = trim(wdetail.icno)           /*Add by Kridtiya i. A63-0472*/ 
    sic_bran.uwm100.codeocc    = trim(wdetail3.codeocc)       /*Add by Kridtiya i. A63-0472*/ 
    sic_bran.uwm100.codeaddr1  = TRIM(wdetail3.codeaddr1)     /*Add by Kridtiya i. A63-0472*/
    sic_bran.uwm100.codeaddr2  = TRIM(wdetail3.codeaddr2)     /*Add by Kridtiya i. A63-0472*/
    sic_bran.uwm100.codeaddr3  = trim(wdetail3.codeaddr3)     /*Add by Kridtiya i. A63-0472*/
    sic_bran.uwm100.campaign   = trim(wdetail2.producer)     /*Add by Kridtiya i. A63-0472*/
    sic_bran.uwm100.fgtariff   = IF INDEX(wdetail2.subclass,"E") <> 0 THEN NO ELSE nv_cal. /*A68-0044*/
  /*IF trim(wdetail2.producer) <> "B3M0062" AND trim(wdetail2.producer) <> "B3M0064" AND trim(wdetail2.producer) <> "B3M0065" THEN DO:*/ /*A67-0065*/
  IF trim(wdetail2.producer) <> "B3M0062" AND trim(wdetail2.producer) <> "B3M0064" AND 
     trim(wdetail2.producer) <> "B3M0065" AND TRIM(wdetail2.producer) <> "B3M0070"  THEN DO: /*A67-0065*/
    ASSIGN  sic_bran.uwm100.cr_1   = IF wdetail2.producer = "B3M0066" THEN "ADDON1K" ELSE ""
            sic_bran.uwm100.opnpol = trim(wdetail2.special2) .
  END.
  ELSE IF trim(wdetail2.producer) = "B3M0065" AND wdetail.prepol <> "" THEN sic_bran.uwm100.opnpol = "RSWITCH".  /*A63-00472*/
  ELSE IF trim(wdetail2.producer) = "B3M0065"                          THEN sic_bran.uwm100.opnpol = "SWITCH".   /*A63-00472*/
  /* A67-0065 */
  ELSE IF TRIM(wdetail2.producer) = "B3M0070" THEN DO:
     ASSIGN sic_bran.uwm100.cr_1   = trim(wdetail2.special2)
            sic_bran.uwm100.opnpol = "HATC-S" .
      IF wdetail.garage  = "G" AND (wdetail.covcod <> "1" AND wdetail.covcod <> "3" )  THEN ASSIGN sic_bran.uwm100.cr_1   = "CLAIMDI-FLOOD".
      ELSE IF wdetail.garage  = "" AND (wdetail.covcod <> "1" AND wdetail.covcod <> "3" )  THEN ASSIGN sic_bran.uwm100.cr_1   = "FLOOD".
      ELSE IF INDEX(wdetail2.special2,"HATC-S") <> 0 THEN sic_bran.uwm100.cr_1 = "" .
  END.
  /* end A67-0065 */
  IF wdetail2.special2 = "TMSTH 0%" THEN DO: 
      IF index(sic_bran.uwm100.opnpol,wdetail2.special2) = 0 THEN
          ASSIGN sic_bran.uwm100.opnpol = sic_bran.uwm100.opnpol + "_" + trim(wdetail2.special2) sic_bran.uwm100.cr_1 = "".  
  END.
  IF wdetail2.special2 = "DEMON_H"  THEN ASSIGN sic_bran.uwm100.opnpol = trim(wdetail2.special2) sic_bran.uwm100.cr_1 = "".
  IF wdetail.prepol <> " " THEN DO:
      IF wdetail2.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = ""  sic_bran.uwm100.tranty  = "R".  
      ELSE ASSIGN sic_bran.uwm100.prvpol = wdetail.prepol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
            sic_bran.uwm100.tranty      = "R".               /*Transaction Type (N/R/E/C/T)*/
  END.
  IF   wdetail2.pass = "Y" THEN sic_bran.uwm100.impflg  = YES.
  ELSE sic_bran.uwm100.impflg  = NO.
  IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
  IF wdetail2.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
  ELSE sic_bran.uwm100.polsta = "IF".
  IF fi_loaddat <> ? THEN  sic_bran.uwm100.trndat = fi_loaddat.
  ELSE sic_bran.uwm100.trndat = TODAY.
  sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
  nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                    (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                    (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.  
  
END.  /*transaction*/
RUN proc_uwd100.
RUN proc_uwd102.
RUN proc_uwd105.
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
        sic_bran.uwm120.bchyr  = nv_batchyr     /* batch Year */
        sic_bran.uwm120.bchno  = nv_batchno     /* bchno      */
        sic_bran.uwm120.bchcnt = nv_batcnt .    /* bchcnt     */
        ASSIGN sic_bran.uwm120.class  = IF wdetail2.poltyp = "v72" THEN wdetail2.subclass ELSE wdetail2.prempa + wdetail2.subclass 
            s_recid2     = RECID(sic_bran.uwm120).
    END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policyname3 C-Win 
PROCEDURE proc_policyname3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A62-0493  Check Vat code       
------------------------------------------------------------------------------*/
DO:
    OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
    PUT "0091: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
    OUTPUT CLOSE.

    IF INDEX(wdetail2.detailcam,"super pack") <> 0 OR INDEX(wdetail2.detailcam,"TRIPLE PACK") <> 0 THEN DO: 

        ASSIGN wdetail2.typrequest = "" .

        IF      INDEX(wdetail2.detailcam,"super pack-hd")  <> 0 THEN ASSIGN wdetail2.special2 = "SUPER PACK-HD".
        ELSE IF INDEX(wdetail2.detailcam,"super pack-h1")  <> 0 THEN ASSIGN wdetail2.special2 = "SUPER PACK-H1".
        ELSE IF INDEX(wdetail2.detailcam,"super pack-h")   <> 0 THEN ASSIGN wdetail2.special2 = "SUPER PACK-H".
        ELSE IF INDEX(wdetail2.detailcam,"super pack")     <> 0 THEN ASSIGN wdetail2.special2 = "SUPER PACK".
        ELSE IF INDEX(wdetail2.detailcam,"Triple pack_h1") <> 0 THEN ASSIGN wdetail2.special2 = "TRIPLE PACK-H1".
        ELSE IF INDEX(wdetail2.detailcam,"Triple pack")    <> 0 THEN ASSIGN wdetail2.special2 = "TRIPLE PACK".
        
        IF wdetail2.special2 = "SUPER PACK-H" OR wdetail2.special2 = "Super Pack-H ฟรีปีที่ 1_23" THEN DO:
            ASSIGN wdetail2.name4      = "และ/หรือ บริษัท ฮอนด้า ออโตโมบิล (ประเทศไทย) จำกัด"
                   wdetail2.typrequest = "MC34019".
        END.
        ELSE IF wdetail2.special2 <> "SUPER PACK" AND wdetail2.special2 <> "TRIPLE PACK"  AND 
            (INT(wdetail2.caryear) = 1 OR wdetail2.TYPE_notify = "N" ) THEN DO:
            ASSIGN wdetail2.name4      = "และ/หรือ บริษัท ฮอนด้า ออโตโมบิล (ประเทศไทย) จำกัด"
                   wdetail2.typrequest = "MC34019".
        END.
        ELSE DO:
            IF wdetail3.instot = 1 THEN DO:
                IF (trim(wdetail2.voictitle) = "0")  THEN DO:
                  FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                             stat.insure.compno = "HCT" AND
                             stat.insure.lname  = wdetail2.voicnam   NO-LOCK NO-WAIT NO-ERROR.
                    IF AVAIL stat.insure THEN  
                        ASSIGN wdetail2.voicnam     = trim(stat.insure.fname)
                               wdetail2.typrequest  = trim(stat.insure.vatcode).  /*เปลี่ยน เป็นเก็บค่า vatcode.*/
                
                  IF (INDEX(wdetail2.voicnam,wdetail.insnam) <>  0 ) THEN  wdetail2.voicnam = "".  
                  ELSE ASSIGN wdetail2.name4  = "และ/หรือ " + TRIM(wdetail2.voicnam).
                END.
                ELSE IF wdetail2.voictitle = "1" THEN wdetail2.typrequest  = "".  /*ลูกค้า*/
                ELSE DO: /* Other */
                     IF (INDEX(trim(wdetail3.companyre1),wdetail.insnam) <>  0 ) THEN DO: /* ชื่อลูกค้า */
                        ASSIGN  wdetail2.name4       = "" 
                                wdetail2.typrequest  = "" .
                     END.
                     /* a62-0493 : เพิ่มการเช็คข้อมูลในช่อง รหัส Dealer Receipt */
                     ELSE IF wdetail2.voicnam <> "" THEN DO:
                         FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                             stat.insure.compno = "HCT" AND
                             stat.insure.lname  = wdetail2.voicnam   NO-LOCK NO-WAIT NO-ERROR.
                            IF AVAIL stat.insure THEN  
                                ASSIGN wdetail2.voicnam     = trim(stat.insure.fname)
                                       wdetail2.typrequest  = trim(stat.insure.vatcode).  /*เปลี่ยน เป็นเก็บค่า vatcode.*/
        
                            IF (INDEX(wdetail2.voicnam,wdetail.insnam) <>  0 ) THEN  wdetail2.voicnam = "".  
                            ELSE ASSIGN wdetail2.name4  = "และ/หรือ " + TRIM(wdetail2.voicnam).
                    END.
                    /* end A62-0493*/
                    ELSE ASSIGN wdetail2.name4  = "และ/หรือ " + trim(wdetail3.companyre1)  
                                wdetail2.typrequest  = fi_producerinst .
                END.
                IF index(wdetail2.name4,"ฮอนด้า ออโตโมบิล (ประเทศไทย) จำกัด") <> 0 THEN ASSIGN wdetail2.typrequest = "MC34019".
            END.
            ELSE DO: 
              ASSIGN wdetail2.typrequest = "".
              IF index(trim(wdetail3.companyre2),trim(wdetail.insnam)) = 0 THEN DO:
                  IF index(trim(wdetail3.companyre3),trim(wdetail.insnam)) <> 0 THEN 
                      ASSIGN wdetail3.companyre3 = trim(nv_insref) + " " + trim(wdetail3.companyre3).
              END.
              ELSE ASSIGN wdetail3.companyre2 = trim(nv_insref) + " " + trim(wdetail3.companyre2).
            END.
        END.
    END.
    ELSE DO:
        /*IF wdetail2.producer <> "B3M0037" THEN DO:  /*  A63-0006 */*/ /*A63-0443*/
        IF wdetail2.producer <> "B3M0063" THEN DO:    /*A63-0443*/
            IF (INDEX(trim(wdetail3.companyre1),wdetail.insnam) <>  0 ) THEN DO:
                ASSIGN wdetail2.name4      = "" 
                       wdetail2.typrequest = "" .
            END.
            /* a62-0493 : เพิ่มการเช็คข้อมูลในช่อง รหัส Dealer Receipt */
            ELSE IF wdetail2.voicnam <> ""  THEN DO: 
                FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                    stat.insure.compno = "HCT" AND
                    stat.insure.lname  = wdetail2.voicnam   NO-LOCK NO-WAIT NO-ERROR.
                   IF AVAIL stat.insure THEN  
                       ASSIGN wdetail2.voicnam     = trim(stat.insure.fname)
                              wdetail2.typrequest  = trim(stat.insure.vatcode).  /*เปลี่ยน เป็นเก็บค่า vatcode.*/
                
                   IF (INDEX(wdetail2.voicnam,wdetail.insnam) <>  0 ) THEN  wdetail2.voicnam = "".  
                   ELSE ASSIGN wdetail2.name4  = "และ/หรือ " + TRIM(wdetail2.voicnam).
            END.
            /* end A62-0493*/
            ELSE ASSIGN wdetail2.name4     = "และ/หรือ " + trim(wdetail3.companyre1)  
                        wdetail2.typrequest = fi_producerinst .
        END.
        /* add by a63-0006 */
        ELSE DO:
            IF wdetail2.poltyp = "V72"  THEN DO:
                ASSIGN wdetail2.name4     = "และ/หรือ " + trim(wdetail3.companyre1)  
                       wdetail2.typrequest = fi_producerinst .
            END.
            ELSE IF wdetail2.poltyp = "V70" AND wdetail3.instot = 1 THEN DO:
                ASSIGN wdetail2.name4     = "และ/หรือ " + trim(wdetail3.companyre1)  
                       wdetail2.typrequest = fi_producerinst .
            END.
        END.
        /* end A63-0006 */

        /*-- Add By Tontawan S. A64-0274 --*/
        /*IF INDEX(wdetail2.detailcam,"HATC CAMPAIGN_21") <> 0 THEN DO:*/     /* Ranu I. A64-0422 05/10/2021*/
        IF INDEX(wdetail2.detailcam,"HATC CAMPAIGN") <> 0 THEN DO:            /* Ranu I. A64-0422 05/10/2021*/
            ASSIGN wdetail2.name4      = "และ/หรือ บริษัท ฮอนด้า ออโตโมบิล (ประเทศไทย) จำกัด" 
                   wdetail2.typrequest = "MC34019".
        END.
        ELSE IF INDEX(wdetail2.detailcam,"HLTC CAMPAIGN") <> 0 THEN DO:
            ASSIGN wdetail2.name4      = "และ/หรือ บริษัท ฮอนด้า ลีสซิ่ง (ประเทศไทย) จำกัด"
                   wdetail2.typrequest = "MC34018".
        END.
        /*-- End By Tontawan S. A64-0274 --*/  

    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policyname4 C-Win 
PROCEDURE proc_policyname4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A64-0328 เพิ่มการเก็บ CCTV    
------------------------------------------------------------------------------*/
DEF VAR n_yr AS INT INIT 0.
DEF VAR nv_si AS INT INIT 0. 
DEF VAR nv_ModelYear   AS DECI INIT 0.
DEF VAR nv_campaignMS  AS CHAR INIT "".  /*A63-0206*/ 
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "0092: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
/* add A61-0324  Super Pack 2 ปี */
IF index(wdetail2.detailcam,"super pack") <> 0 THEN DO:

    nv_campaignMS = "SUPER PACK" . /* A64-0328 :05/10/21 */
    IF wdetail2.poltyp = "V70" AND wdetail.flagno <> "0"  THEN DO:
        FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
            stat.campaign_fil.camcod = TRIM(nv_campaignMS)  and   /* campaign */ /* A64-0328 :05/10/21 */
            stat.campaign_fil.sclass = wdetail2.subclass and   /* class 110 210 320 */
            stat.campaign_fil.covcod = wdetail.covcod    and   /* cover 1 2 3 2.1 2.2 3.1 3.2 */
            stat.campaign_fil.vehgrp = wdetail.cargrp    and   /* group car */
            stat.campaign_fil.vehuse = "1"               and   /* ประเภทการใช้รถ */
            stat.campaign_fil.garage = wdetail.garage    and    /* การซ่อม */
            /*stat.campaign_fil.maxyea = 1                 and*/  /* อายุรถ */
            stat.campaign_fil.simax  = deci(wdetail.si)  AND 
            stat.campaign_fil.moddes = wdetail.model     AND 
            stat.campaign_fil.netprm = deci(wdetail.premt) NO-LOCK NO-ERROR.   /* Model */

      IF AVAIL stat.campaign_fil THEN DO:
          ASSIGN nv_polmaster = stat.campaign_fil.polmst
                 nv_cctvcode  = IF stat.campaign_fil.cctv = YES THEN "0001" ELSE "".
      END.
      ELSE ASSIGN nv_polmaster = "" .
    END.
END.  /* end A61-0324*/
/* add by : A62-0493  Triple Pack 3 ปี */
ELSE IF INDEX(wdetail2.detailcam,"TRIPLE PACK") <> 0  THEN DO:

    nv_campaignMS = "TRIPLE PACK" . /* A64-0328 :05/10/21 */
    IF wdetail2.poltyp = "V70" AND wdetail.flagno <> "0"  THEN DO:
        FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
            stat.campaign_fil.camcod = TRIM(nv_campaignMS)  and   /* campaign */ /* A64-0328 :05/10/21 */
            stat.campaign_fil.sclass = trim(wdetail2.subclass) AND /* class 110 210 320 */
            stat.campaign_fil.covcod = trim(wdetail.covcod)    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
            stat.campaign_fil.vehgrp = trim(wdetail.cargrp)    AND /* group car */
            stat.campaign_fil.vehuse = "1"                     AND /* ประเภทการใช้รถ */
            stat.campaign_fil.garage = wdetail.garage          AND /* การซ่อม */
            /*stat.campaign_fil.maxyea = 1                       AND*/ /* อายุรถ */
            stat.campaign_fil.simax  = deci(wdetail.si)        AND 
            stat.campaign_fil.moddes = trim(wdetail.model)     AND 
            stat.campaign_fil.netprm = deci(wdetail.premt)     NO-LOCK NO-ERROR.   /* Model */
        
        IF AVAIL stat.campaign_fil THEN DO:
            ASSIGN nv_polmaster = stat.campaign_fil.polmst
                   nv_cctvcode  = IF stat.campaign_fil.cctv = YES THEN "0001" ELSE "".
        END.
        ELSE ASSIGN nv_polmaster = "" .
    END.
END.
/* add by : ranu A64-0328 05/10/21 */
ELSE IF (INDEX(wdetail2.detailcam,"HEI") <> 0 ) OR (INDEX(wdetail2.detailcam,"HATC CAMPAIGN") <> 0 ) THEN DO:

    IF      INDEX(wdetail2.detailcam,"HEI")      <> 0 THEN nv_campaignMS = TRIM(REPLACE(wdetail2.detailcam," ","")).
    ELSE IF INDEX(wdetail2.detailcam,"HATC CAMPAIGN") <> 0 THEN nv_campaignMS = TRIM(wdetail2.detailcam).
/* end : ranu A64-0328 05/10/21 */
    IF wdetail2.poltyp = "V70"   THEN DO:
        FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
            stat.campaign_fil.camcod    = nv_campaignMS                   AND /* campaign triple pack */
            stat.campaign_fil.sclass    = trim(wdetail2.subclass)         AND /* class 110 210 320 */
            stat.campaign_fil.covcod    = trim(wdetail.covcod)            AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
            stat.campaign_fil.vehgrp    = trim(wdetail.cargrp)            AND /* group car */
            stat.campaign_fil.vehuse    = "1"                             AND /* ประเภทการใช้รถ */
            stat.campaign_fil.garage    = wdetail.garage                  AND /* การซ่อม */
            stat.campaign_fil.maxyea    = 1                               AND /* อายุรถ */                               
            stat.campaign_fil.simax     = deci(wdetail.si)                AND                                            
            stat.campaign_fil.netprm    = DECI(wdetail.premt)             AND 
            stat.campaign_fil.moddes    = trim(wdetail.model)             AND
            stat.campaign_fil.netprm    = deci(wdetail.premt)             NO-LOCK NO-ERROR.   /* Model */              
        
        IF AVAIL stat.campaign_fil THEN DO:
            ASSIGN nv_polmaster = stat.campaign_fil.polmst
                   nv_cctvcode  = IF stat.campaign_fil.cctv = YES THEN "0001" ELSE "".
        END.
        ELSE ASSIGN nv_polmaster = "" . 
    END.

END.  /*A63-0206 */
/*IF (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN DO:*/ /*A67-0065*/
IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "2.2") OR 
   (wdetail.covcod = "3.1") OR (wdetail.covcod = "3.2") THEN DO: /*A67-0065*/
    IF wdetail2.poltyp = "V70" THEN DO:
        nv_ModelYear = YEAR(TODAY) - DECI(wdetail.caryear) + 1.
        FIND LAST stat.campaign_fil USE-INDEX campfil15  WHERE                
            /*stat.campaign_fil.camcod  =   TRIM(fi_campaign23)      and    */      /*campaign */ /*A63-0443*/ /* A64-0328 : 05/10/21 */
            stat.campaign_fil.camcod  =   TRIM(wdetail2.detailcam) and              /*campaign */ /*A63-0443*/ /* A64-0328 : 05/10/21 */
            stat.campaign_fil.sclass  =   wdetail2.subclass        and              /* class 110 210 320 */
            stat.campaign_fil.covcod  =   wdetail.covcod           and              /* cover 1 2 3 2.1 2.2 3.1 3.2 */
            stat.campaign_fil.garage  =   wdetail.garage           and              /*   ประเภทการซ่อม   */
           (stat.campaign_fil.mincst  <=  inte(wdetail.engcc)      and              /*   ปริมาตรกระบอกสูบ        */
            stat.campaign_fil.maxcst  >=  inte(wdetail.engcc))     and              /*   ปริมาตรกระบอกสูบ        */
           (stat.campaign_fil.simin   <=  deci(wdetail.si)         and              /*   วงเงินทุนประกันต่ำสุด */
            stat.campaign_fil.simax   >=  deci(wdetail.si))        AND 
            stat.campaign_fil.netprm  =   deci(wdetail.premt)      NO-LOCK NO-ERROR.  /*   วงเงินทุนประกันสูงสุด */
                                                                         
      IF AVAIL stat.campaign_fil THEN 
          ASSIGN nv_polmaster = stat.campaign_fil.polmst
                 nv_cctvcode  = IF stat.campaign_fil.cctv = YES THEN "0001" ELSE "".
      ELSE ASSIGN nv_polmaster = "" .
    END.
END.
IF nv_polmaster = "" AND trim(wdetail2.detailcam) <> ""  THEN DO:
     FIND LAST stat.campaign_fil USE-INDEX campfil01  WHERE 
            stat.campaign_fil.camcod    = trim(wdetail2.detailcam)        AND /* campaign triple pack */
            stat.campaign_fil.sclass    = trim(wdetail2.subclass)         AND /* class 110 210 320 */
            stat.campaign_fil.covcod    = trim(wdetail.covcod)            AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
            stat.campaign_fil.vehgrp    = trim(wdetail.cargrp)            AND /* group car */
            stat.campaign_fil.vehuse    = "1"                             AND /* ประเภทการใช้รถ */
            stat.campaign_fil.garage    = wdetail.garage                  AND /* การซ่อม */
            stat.campaign_fil.maxyea    = 1                               AND /* อายุรถ */                               
            stat.campaign_fil.simax     = deci(wdetail.si)                AND                                            
            stat.campaign_fil.netprm    = DECI(wdetail.premt)             AND 
            stat.campaign_fil.moddes    = trim(wdetail.model)             NO-LOCK NO-ERROR.   /* Model */             
        
        IF AVAIL stat.campaign_fil THEN DO:
            ASSIGN nv_polmaster = stat.campaign_fil.polmst
                   nv_cctvcode  = IF stat.campaign_fil.cctv = YES THEN "0001" ELSE "".
        END.
END.
IF INDEX(wdetail2.detailcam,"NOCC") = 0 AND INDEX(wdetail2.detailcam,"CCTV") <> 0 THEN   nv_cctvcode = "0001"  .
IF wdetail2.poltyp = "V70" AND  nv_polmaster = "" THEN wdetail2.WCampaign = "เบี้ยประกัน" + wdetail.premt + "ไม่ตรงตามแคมเปญ".


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
ASSIGN 
    nv_acc6 = IF TRIM(wdetail2.accdata) = "" THEN "" 
              ELSE TRIM(wdetail2.accdata) + " ราคารวมอุปกรณ์เสริม " +  trim(wdetail2.price_acc) + " บาท"
    nv_acc1 = ""
    nv_acc2 = ""
    nv_acc3 = ""
    nv_acc4 = ""
    nv_acc5 = "".
IF wdetail3.brand_gals    <> "" THEN nv_acc6 = nv_acc6 + " ยี่ห้อเคลือบแก้ว " + TRIM(wdetail3.brand_gals).
/*IF (wdetail3.brand_galsprm <> "" ) THEN nv_acc6 = nv_acc6 + " ราคา " + TRIM(wdetail3.brand_galsprm).*/ /*A59-0118*/
IF (wdetail3.brand_galsprm <> "" ) AND (deci(wdetail3.brand_galsprm) <> 0 ) THEN nv_acc6 = nv_acc6 + " ราคา " + TRIM(wdetail3.brand_galsprm). /*A59-0118*/
/*
IF      INDEX(nv_acc6,"1.") <> 0 OR INDEX(nv_acc6,"2.") <> 0 THEN RUN proc_prmtxt1.
ELSE IF INDEX(nv_acc6,")")  <> 0 THEN  RUN proc_prmtxt2.
ELSE IF INDEX(nv_acc6,"/")  <> 0 THEN  RUN proc_prmtxt3.
ELSE DO:*/
    
loop_chk1:
REPEAT:
    IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc1 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
        ASSIGN  nv_acc1 = trim(nv_acc1 + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
        nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
    ELSE LEAVE loop_chk1.
END.
IF nv_acc6 <> "" THEN
loop_chk2:
REPEAT:
    IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc2 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
        ASSIGN  nv_acc2 = trim(nv_acc2  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
        nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
    ELSE LEAVE loop_chk2.
END.
loop_chk3:
REPEAT:
    IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc3 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
        ASSIGN  nv_acc3 = trim(nv_acc3  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
        nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
    ELSE LEAVE loop_chk3.
END.
loop_chk4:
REPEAT:
    IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc4 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
        ASSIGN  nv_acc4 = trim(nv_acc4  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
        nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
    ELSE LEAVE loop_chk4.
END.
loop_chk5:
REPEAT:
    IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc5 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
        ASSIGN  nv_acc5 = trim(nv_acc5  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
        nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
    ELSE LEAVE loop_chk5.
END.
IF      (nv_acc5 <> "") AND (length(nv_acc5 + " " + nv_acc6 ) <= 60 ) THEN 
    ASSIGN nv_acc5 = nv_acc5  + " " + nv_acc6
    nv_acc6 = "" .
ELSE IF (nv_acc4 <> "") AND (length(nv_acc4 + " " + nv_acc6 ) <= 60 ) THEN 
    ASSIGN nv_acc4 = nv_acc4  + " " + nv_acc6 
    nv_acc6 = "" .
ELSE IF (nv_acc3 <> "") AND (length(nv_acc3 + " " + nv_acc6 ) <= 60 ) THEN 
    ASSIGN nv_acc3 = nv_acc3  + " " + nv_acc6
    nv_acc6 = "" .
ELSE IF (nv_acc2 <> "") AND (length(nv_acc2 + " " + nv_acc6 ) <= 60 ) THEN 
    ASSIGN nv_acc2 = nv_acc2  + " " + nv_acc6
    nv_acc6 = "" .
ELSE IF (nv_acc1 <> "") AND (length(nv_acc1 + " " + nv_acc6 ) <= 60 ) THEN
    ASSIGN  nv_acc1 = nv_acc1  + " " + nv_acc6
    nv_acc6 = "" .
/*END.  /*ELSE DO:*/*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_prmtxt1 C-Win 
PROCEDURE proc_prmtxt1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN 
    nv_acc12 = trim(nv_acc6)
    nv_acc13 = ""
    nv_acc6  = "".
IF INDEX(nv_acc12,"11.") <> 0 THEN
    ASSIGN 
    nv_acc13 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"11."))) 
    nv_acc12 = trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"11.") - 1 )).

IF nv_acc12 <> "" THEN DO:
loop_chk1:
REPEAT:
    IF LENGTH(nv_acc1) <= 60 THEN DO:
        IF INDEX(nv_acc12,"1.") <> 0 AND INDEX(nv_acc12,"2.") <> 0 AND length(trim(nv_acc1) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"2.") - 1 ))) <= 60 THEN  
            ASSIGN 
            nv_acc1  = trim(nv_acc1 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"2.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"2."))).
        ELSE IF INDEX(nv_acc12,"2.") <> 0 AND  INDEX(nv_acc12,"3.") <> 0 AND length(trim(nv_acc1) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"3.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc1  = trim(nv_acc1 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"3.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"3."))).
        ELSE IF INDEX(nv_acc12,"3.") <> 0 AND  INDEX(nv_acc12,"4.") <> 0 AND length(trim(nv_acc1) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"4.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc1  = trim(nv_acc1 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"4.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"4."))).
        ELSE IF INDEX(nv_acc12,"4.") <> 0 AND  INDEX(nv_acc12,"5.") <> 0 AND length(trim(nv_acc1) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"5.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc1  = trim(nv_acc1 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"5.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"5."))).
        ELSE IF INDEX(nv_acc12,"5.") <> 0 AND  INDEX(nv_acc12,"6.") <> 0 AND length(trim(nv_acc1) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"6.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc1  = trim(nv_acc1 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"6.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"6."))).
        ELSE IF INDEX(nv_acc12,"6.") <> 0 AND  INDEX(nv_acc12,"7.") <> 0 AND length(trim(nv_acc1) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc1  = trim(nv_acc1 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"7."))). 
        ELSE DO:
            IF length(nv_acc1  + " " + nv_acc12) <= 60 THEN 
                ASSIGN nv_acc1 = trim(nv_acc1  + " " + nv_acc12)  
                nv_acc12 = "".
            LEAVE loop_chk1.
        END.
    END.
    ELSE LEAVE loop_chk1.
END.
END.
IF nv_acc12 <> "" THEN DO:
loop_chk2:
REPEAT:
    IF LENGTH(nv_acc2) <= 60 THEN DO:
        IF INDEX(nv_acc12,"2.") <> 0 AND  INDEX(nv_acc12,"3.") <> 0 AND length(trim(nv_acc2) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"3.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc2  = trim(nv_acc2 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"3.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"3."))).
        ELSE IF INDEX(nv_acc12,"3.") <> 0 AND  INDEX(nv_acc12,"4.") <> 0 AND length(trim(nv_acc2) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"4.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc2  = trim(nv_acc2 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"4.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"4."))).
        ELSE IF INDEX(nv_acc12,"4.") <> 0 AND  INDEX(nv_acc12,"5.") <> 0 AND length(trim(nv_acc2) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"5.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc2  = trim(nv_acc2 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"5.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"5."))).
        ELSE IF INDEX(nv_acc12,"5.") <> 0 AND  INDEX(nv_acc12,"6.") <> 0 AND length(trim(nv_acc2) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"6.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc2  = trim(nv_acc2 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"6.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"6."))).
        ELSE IF INDEX(nv_acc12,"6.") <> 0 AND  INDEX(nv_acc12,"7.") <> 0 AND length(trim(nv_acc2) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc2  = trim(nv_acc2 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"7."))). 
        ELSE IF INDEX(nv_acc12,"7.") <> 0 AND  INDEX(nv_acc12,"8.") <> 0 AND length(trim(nv_acc2) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"8.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc2  = trim(nv_acc2 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"8.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"8."))). 
        ELSE IF INDEX(nv_acc12,"8.") <> 0 AND  INDEX(nv_acc12,"9.") <> 0 AND length(trim(nv_acc2) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"9.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc2  = trim(nv_acc2 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"9.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"9."))). 
        ELSE IF INDEX(nv_acc12,"9.") <> 0 AND  INDEX(nv_acc12,"10.") <> 0 AND length(trim(nv_acc2) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"10.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc2  = trim(nv_acc2 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"10.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"10."))). 
        ELSE DO:
            IF length(nv_acc2  + " " + nv_acc12) <= 60 THEN 
                ASSIGN nv_acc2 = trim(nv_acc2  + " " + nv_acc12)  
                nv_acc12 = "".
            LEAVE loop_chk2.
        END.
        /*DISP LENGTH(nv_acc2)  nv_acc2 FORMAT "x(65)" .*/
    END.
    ELSE LEAVE loop_chk2.
END.
END.
IF nv_acc12 <> "" THEN DO:
loop_chk3:
REPEAT:
    IF LENGTH(nv_acc3) <= 60 THEN DO:
        IF INDEX(nv_acc12,"3.") <> 0 AND  INDEX(nv_acc12,"4.") <> 0 AND length(trim(nv_acc3) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"4.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc3  = trim(nv_acc3 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"4.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"4."))).
        ELSE IF INDEX(nv_acc12,"4.") <> 0 AND  INDEX(nv_acc12,"5.") <> 0 AND length(trim(nv_acc3) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"5.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc3  = trim(nv_acc3 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"5.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"5."))).
        ELSE IF INDEX(nv_acc12,"5.") <> 0 AND  INDEX(nv_acc12,"6.") <> 0 AND length(trim(nv_acc3) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"6.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc3  = trim(nv_acc3 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"6.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"6."))).
        ELSE IF INDEX(nv_acc12,"6.") <> 0 AND  INDEX(nv_acc12,"7.") <> 0 AND length(trim(nv_acc3) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc3  = trim(nv_acc3 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"7."))). 
        ELSE IF INDEX(nv_acc12,"7.") <> 0 AND  INDEX(nv_acc12,"8.") <> 0 AND length(trim(nv_acc3) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"8.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc3  = trim(nv_acc3 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"8.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"8."))). 
        ELSE IF INDEX(nv_acc12,"8.") <> 0 AND  INDEX(nv_acc12,"9.") <> 0 AND length(trim(nv_acc3) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"9.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc3  = trim(nv_acc3 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"9.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"9."))).
        ELSE IF INDEX(nv_acc12,"9.") <> 0 AND  INDEX(nv_acc12,"10.") <> 0 AND length(trim(nv_acc3) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"10.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc3  = trim(nv_acc3 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"10.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"10."))).
        ELSE DO:
            IF length(nv_acc3  + " " + nv_acc12) <= 60 THEN 
                ASSIGN nv_acc3 = trim(nv_acc3  + " " + nv_acc12)  
                nv_acc12 = "".
            LEAVE loop_chk3.
        END.
        /*DISP LENGTH(nv_acc3)  nv_acc3 FORMAT "x(65)" .*/
    END.
    ELSE LEAVE loop_chk3.
END.
END.
IF nv_acc12 <> "" THEN DO:
loop_chk4:
REPEAT:
    IF LENGTH(nv_acc4) <= 60 THEN DO:
        IF INDEX(nv_acc12,"4.") <> 0 AND  INDEX(nv_acc12,"5.") <> 0 AND length(trim(nv_acc4) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"5.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc4  = trim(nv_acc4 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"5.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"5."))).
        ELSE IF INDEX(nv_acc12,"5.") <> 0 AND  INDEX(nv_acc12,"6.") <> 0 AND length(trim(nv_acc4) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"6.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc4  = trim(nv_acc4 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"6.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"6."))).
        ELSE IF INDEX(nv_acc12,"6.") <> 0 AND  INDEX(nv_acc12,"7.") <> 0 AND length(trim(nv_acc4) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc4  = trim(nv_acc4 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"7."))). 
        ELSE IF INDEX(nv_acc12,"7.") <> 0 AND  INDEX(nv_acc12,"8.") <> 0 AND length(trim(nv_acc4) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"8.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc4  = trim(nv_acc4 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"8.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"8."))). 
        ELSE IF INDEX(nv_acc12,"8.") <> 0 AND  INDEX(nv_acc12,"9.") <> 0 AND length(trim(nv_acc4) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"9.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc4  = trim(nv_acc4 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"9.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"9."))). 
        ELSE IF INDEX(nv_acc12,"9.") <> 0 AND  INDEX(nv_acc12,"10.") <> 0 AND length(trim(nv_acc4) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"10.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc4  = trim(nv_acc4 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"10.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"10."))). 
        ELSE IF INDEX(nv_acc12,"10.") <> 0 AND  INDEX(nv_acc12,"11.") <> 0 AND length(trim(nv_acc4) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"11.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc4  = trim(nv_acc4 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"11.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"11."))). 
        ELSE IF INDEX(nv_acc12,"11.") <> 0 AND  INDEX(nv_acc12,"12.") <> 0 AND length(trim(nv_acc4) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"12.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc4  = trim(nv_acc4 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"12.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"12."))). 
        ELSE DO:
            IF length(nv_acc4  + " " + nv_acc12) <= 60 THEN 
                ASSIGN nv_acc4 = trim(nv_acc4  + " " + nv_acc12)   
                nv_acc12 = "".
            LEAVE loop_chk4.
        END.
        /*DISP LENGTH(nv_acc4)  nv_acc4 FORMAT "x(65)" .*/
    END.
    ELSE LEAVE loop_chk4.
END.
END.
IF nv_acc12 <> "" THEN DO:
loop_chk5:
REPEAT:
    IF LENGTH(nv_acc5) <= 60 THEN DO:
        IF INDEX(nv_acc12,"5.") <> 0 AND  INDEX(nv_acc12,"6.") <> 0 AND length(trim(nv_acc5) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"6.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc5  = trim(nv_acc5 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"6.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"6."))).
        ELSE IF INDEX(nv_acc12,"6.") <> 0 AND  INDEX(nv_acc12,"7.") <> 0 AND length(trim(nv_acc5) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc5  = trim(nv_acc5 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"7."))). 
        ELSE IF INDEX(nv_acc12,"7.") <> 0 AND  INDEX(nv_acc12,"8.") <> 0 AND length(trim(nv_acc5) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"8.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc5  = trim(nv_acc5 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"8.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"8."))). 
        ELSE IF INDEX(nv_acc12,"8.") <> 0 AND  INDEX(nv_acc12,"9.") <> 0 AND length(trim(nv_acc5) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"9.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc5  = trim(nv_acc5 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"9.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"9."))). 
        ELSE IF INDEX(nv_acc12,"9.") <> 0 AND  INDEX(nv_acc12,"10.") <> 0 AND length(trim(nv_acc5) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"10.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc5  = trim(nv_acc5 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"10.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"10."))). 
        ELSE IF INDEX(nv_acc12,"10.") <> 0 AND  INDEX(nv_acc12,"11.") <> 0 AND length(trim(nv_acc5) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"11.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc5  = trim(nv_acc5 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"11.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"11."))). 
        ELSE IF INDEX(nv_acc12,"11.") <> 0 AND  INDEX(nv_acc12,"12.") <> 0 AND length(trim(nv_acc5) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"12.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc5  = trim(nv_acc5 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"12.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"12."))).
        ELSE DO:
            IF length(nv_acc5  + " " + nv_acc12) <= 60 THEN 
                ASSIGN nv_acc5 = trim(nv_acc5  + " " + nv_acc12)  
                nv_acc12 = "".
            LEAVE loop_chk5.
        END.
        /*DISP LENGTH(nv_acc5)  nv_acc5 FORMAT "x(65)" .*/
    END. 
    ELSE LEAVE loop_chk5.
END.
END.
IF nv_acc12 <> "" THEN DO:
 
loop_chk6:
REPEAT:
    IF LENGTH(nv_acc6) <= 60 THEN DO:
        IF INDEX(nv_acc12,"6.") <> 0 AND  INDEX(nv_acc12,"7.") <> 0 AND length(trim(nv_acc6) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc6  = trim(nv_acc6 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"7.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"7."))). 
        ELSE IF INDEX(nv_acc12,"7.") <> 0 AND  INDEX(nv_acc12,"8.") <> 0 AND length(trim(nv_acc6) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"8.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc6  = trim(nv_acc6 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"8.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"8."))). 
        ELSE IF INDEX(nv_acc12,"8.") <> 0 AND  INDEX(nv_acc12,"9.") <> 0 AND length(trim(nv_acc6) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"9.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc6  = trim(nv_acc6 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"9.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"9."))). 
        ELSE IF INDEX(nv_acc12,"9.") <> 0 AND  INDEX(nv_acc12,"10.") <> 0 AND length(trim(nv_acc6) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"10.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc6  = trim(nv_acc6 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"10.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"10."))). 
        ELSE IF INDEX(nv_acc12,"10.") <> 0 AND  INDEX(nv_acc12,"11.") <> 0 AND length(trim(nv_acc6) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"11.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc6  = trim(nv_acc6 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"11.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"11."))). 
        ELSE IF INDEX(nv_acc12,"11.") <> 0 AND  INDEX(nv_acc12,"12.") <> 0 AND length(trim(nv_acc6) + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"12.") - 1 ))) <= 60 THEN   
            ASSIGN 
            nv_acc6  = trim(nv_acc6 + " " + trim(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"12.") - 1 )))
            nv_acc12 = trim(SUBSTR(nv_acc12,INDEX(nv_acc12,"12."))). 
        ELSE DO:
            IF length(nv_acc6  + " " + nv_acc12) <= 60 THEN 
                ASSIGN nv_acc6 = trim(nv_acc6  + " " + nv_acc12)   
                nv_acc12 = "".
            LEAVE loop_chk6.
        END.
        /*DISP LENGTH(nv_acc6)  nv_acc6 FORMAT "x(65)" .*/
    END.
    ELSE LEAVE loop_chk6.
END.
END.
IF      nv_acc6 <> "" THEN nv_acc6 = nv_acc6 + " " + nv_acc13.
ELSE IF nv_acc5 <> "" THEN nv_acc5 = nv_acc5 + " " + nv_acc13.
ELSE IF nv_acc4 <> "" THEN nv_acc4 = nv_acc4 + " " + nv_acc13.
ELSE IF nv_acc3 <> "" THEN nv_acc3 = nv_acc3 + " " + nv_acc13.
ELSE IF nv_acc2 <> "" THEN nv_acc2 = nv_acc2 + " " + nv_acc13.
ELSE IF nv_acc1 <> "" THEN nv_acc1 = nv_acc1 + " " + nv_acc13.  


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_prmtxt2 C-Win 
PROCEDURE proc_prmtxt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN nv_acc12 = nv_acc6. 
IF INDEX(nv_acc12,")") <> 0 THEN DO:
    ASSIGN nv_acc6 = "".

    loop_chk1:
    REPEAT:
        IF (INDEX(nv_acc12,")") <> 0 ) AND LENGTH(nv_acc1 + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,")")))) <= 60 THEN 
            ASSIGN  
            nv_acc1 = trim(nv_acc1 + " " + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,")"))))
            nv_acc12 = TRIM(SUBSTR(nv_acc12,INDEX(nv_acc12,")") + 1 )).
        ELSE LEAVE loop_chk1.
    END.
    loop_chk2:
    REPEAT:
        IF (INDEX(nv_acc12,")") <> 0 ) AND LENGTH(nv_acc2 + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,")")))) <= 60 THEN 
            ASSIGN  nv_acc2 = trim(nv_acc2  + " " + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,")"))))
            nv_acc12 = TRIM(SUBSTR(nv_acc12,INDEX(nv_acc12,")") + 1 )).
        ELSE LEAVE loop_chk2.
    END.
    loop_chk3:
    REPEAT:
        IF (INDEX(nv_acc12,")") <> 0 ) AND LENGTH(nv_acc3 + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,")")))) <= 60 THEN 
            ASSIGN  nv_acc3 = trim(nv_acc3  + " " + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,")"))))
            nv_acc12 = TRIM(SUBSTR(nv_acc12,INDEX(nv_acc12,")") + 1 )).
        ELSE DO: 
            ASSIGN nv_acc3 = trim(nv_acc3 + " " + nv_acc12)
                nv_acc12 = "".
            LEAVE loop_chk3.

        END.
    END.
    loop_chk4:
    REPEAT:
        IF (INDEX(nv_acc12,")") <> 0 ) AND LENGTH(nv_acc4 + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,")")))) <= 60 THEN 
            ASSIGN  nv_acc4 = trim(nv_acc4  + " " + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,")"))))
            nv_acc12 = TRIM(SUBSTR(nv_acc12,INDEX(nv_acc12,")"))).
        ELSE LEAVE loop_chk4.
    END.
    loop_chk5:
    REPEAT:
        IF (INDEX(nv_acc12,")") <> 0 ) AND LENGTH(nv_acc5 + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,")")))) <= 60 THEN 
            ASSIGN  nv_acc5 = trim(nv_acc5  + " " + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,")"))))
            nv_acc12 = TRIM(SUBSTR(nv_acc12,INDEX(nv_acc12,")"))).
        ELSE LEAVE loop_chk5.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_prmtxt3 C-Win 
PROCEDURE proc_prmtxt3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN nv_acc12 = nv_acc6.
IF INDEX(nv_acc12,"/") <> 0 THEN DO:
    ASSIGN nv_acc6 = "".

    loop_chk1:
    REPEAT:
        IF (INDEX(nv_acc12,"/") <> 0 ) AND LENGTH(nv_acc1 + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"/")))) <= 60 THEN 
            ASSIGN  
            nv_acc1 = trim(nv_acc1 + " " + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"/") - 1 )))
            nv_acc12 = TRIM(SUBSTR(nv_acc12,INDEX(nv_acc12,"/") + 1 )).
        ELSE LEAVE loop_chk1.
    END.
    loop_chk2:
    REPEAT:
        IF (INDEX(nv_acc12,"/") <> 0 ) AND LENGTH(nv_acc2 + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"/")))) <= 60 THEN 
            ASSIGN  nv_acc2 = trim(nv_acc2  + " " + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"/") - 1 )))
            nv_acc12 = TRIM(SUBSTR(nv_acc12,INDEX(nv_acc12,"/") + 1 )).
        ELSE LEAVE loop_chk2.
    END.
    loop_chk3:
    REPEAT:
        IF (INDEX(nv_acc12,"/") <> 0 ) AND LENGTH(nv_acc3 + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"/")))) <= 60 THEN 
            ASSIGN  nv_acc3 = trim(nv_acc3  + " " + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"/") - 1 )))
            nv_acc12 = TRIM(SUBSTR(nv_acc12,INDEX(nv_acc12,"/") + 1 )).
        ELSE DO: 
            ASSIGN nv_acc3 = trim(nv_acc3 + " " + nv_acc12)
                nv_acc12 = "".
            LEAVE loop_chk3.

        END.
    END.
    loop_chk4:
    REPEAT:
        IF (INDEX(nv_acc12,"/") <> 0 ) AND LENGTH(nv_acc4 + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"/")))) <= 60 THEN 
            ASSIGN  nv_acc4 = trim(nv_acc4  + " " + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"/") - 1 )))
            nv_acc12 = TRIM(SUBSTR(nv_acc12,INDEX(nv_acc12,"/"))).
        ELSE LEAVE loop_chk4.
    END.
    loop_chk5:
    REPEAT:
        IF (INDEX(nv_acc12,"/") <> 0 ) AND LENGTH(nv_acc5 + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"/")))) <= 60 THEN 
            ASSIGN  nv_acc5 = trim(nv_acc5  + " " + TRIM(SUBSTR(nv_acc12,1,INDEX(nv_acc12,"/") - 1 )))
            nv_acc12 = TRIM(SUBSTR(nv_acc12,INDEX(nv_acc12,"/"))).
        ELSE LEAVE loop_chk5.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_producer C-Win 
PROCEDURE proc_producer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Add kridtiya.i  A55-0151   */
ASSIGN 
n_age =  IF wdetail.dbirth = "" THEN 0
         ELSE YEAR(TODAY) - INT(SUBSTR(wdetail.dbirth,7,4))  .
IF wdetail.model = "city" THEN DO :
    FIND FIRST brstat.insure USE-INDEX Insure03           WHERE 
        brstat.insure.compno         = fi_campaign        AND 
        brstat.Insure.InsNo          = "jazz"             AND            /*model*/
        deci(brstat.insure.vatcode) >=  n_age             AND  
        deci(brstat.insure.text4)   <=  n_age             AND  
        deci(brstat.insure.Text2)    =  DECI(wdetail.si)  AND      /*sum ins */ 
        deci(brstat.insure.branch)   =  deci(wdetail.gap) NO-LOCK NO-ERROR .
    IF AVAIL brstat.insure THEN 
        ASSIGN  wdetail2.producer  = brstat.insure.Text1 
                wdetail2.producer2 = brstat.insure.Text1 .       
    ELSE ASSIGN wdetail2.producer  = fi_producer01
                wdetail2.producer2 = "" .             
END.                                                    
ELSE DO:                                                
    FIND FIRST brstat.insure USE-INDEX Insure03       WHERE                     
    brstat.insure.compno         = fi_campaign        AND 
    brstat.Insure.InsNo          = wdetail.model      AND      /*model*/
    deci(brstat.insure.vatcode) >=  n_age             AND  
    deci(brstat.insure.text4)   <=  n_age             AND  
    deci(brstat.insure.Text2)    =  DECI(wdetail.si)  AND      /*sum ins */ 
    deci(brstat.insure.branch)   =  deci(wdetail.gap) NO-LOCK NO-ERROR  .
    IF AVAIL brstat.insure THEN  
        ASSIGN  wdetail2.producer  = brstat.insure.Text1 
                wdetail2.producer2 = brstat.insure.Text1 .       
    ELSE ASSIGN wdetail2.producer  = fi_producer01
                wdetail2.producer2 = "" .   
END.  
/*Add kridtiya.i  A55-0151   */
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
DEF BUFFER bfuwm100 FOR sicuw.uwm100. /* A67-0065*/
DEF VAR nvchkpol AS CHAR INIT "" FORMAT "x(20)".
ASSIGN nvchkpol = trim(wdetail.prepol).
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "002: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.

 OUTPUT TO D:\temp\Log_Loadhonda.txt APPEND.
  PUT " " TODAY FORMAT "99/99/9999" ";" STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3) 
      "1Prepol:" trim(wdetail.prepol)  FORMAT "X(150)" SKIP.
  OUTPUT CLOSE.
IF length(nvchkpol) > 7 THEN DO:

IF      index(nvchkpol,"VV1") <> 0  THEN ASSIGN nvchkpol =  trim(substr(nvchkpol,length(nvchkpol)  -  7  )) .
ELSE IF index(nvchkpol,"VV2") <> 0  THEN ASSIGN nvchkpol =  trim(substr(nvchkpol,length(nvchkpol)  -  7  )) .
ELSE IF index(nvchkpol,"VV3") <> 0  THEN ASSIGN nvchkpol =  trim(substr(nvchkpol,length(nvchkpol)  -  7  )) .
ELSE IF index(nvchkpol,"VVC") <> 0  THEN ASSIGN nvchkpol =  trim(substr(nvchkpol,length(nvchkpol)  -  7  )) . 
ELSE IF index(nvchkpol,"V2N") <> 0  THEN ASSIGN nvchkpol =  trim(substr(nvchkpol,length(nvchkpol)  -  7  )) .
ELSE IF index(nvchkpol,"V2P") <> 0  THEN ASSIGN nvchkpol =  trim(substr(nvchkpol,length(nvchkpol)  -  7  )) . 
ELSE IF index(nvchkpol,"V3N") <> 0  THEN ASSIGN nvchkpol =  trim(substr(nvchkpol,length(nvchkpol)  -  7  )) .
ELSE IF index(nvchkpol,"V3P") <> 0  THEN ASSIGN nvchkpol =  trim(substr(nvchkpol,length(nvchkpol)  -  7  )) . 
                                                                            
END.
ASSIGN wdetail.prepol = trim(nvchkpol).
OUTPUT TO D:\temp\Log_Loadhonda.txt APPEND.
  PUT " " TODAY FORMAT "99/99/9999" ";" STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3) 
      "2Prepol:" trim(wdetail.prepol)  FORMAT "X(150)" SKIP.
  OUTPUT CLOSE.

   FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
       sicuw.uwm100.policy = wdetail.prepol No-lock No-error no-wait.
   IF AVAIL sicuw.uwm100  THEN DO:
       IF sicuw.uwm100.renpol <> " " THEN DO:
           /*  add by : A67-0065 */
           FIND LAST bfuwm100 WHERE bfuwm100.policy = sicuw.uwm100.renpol AND 
                                    bfuwm100.polsta = "CA" AND 
                                    bfuwm100.releas = YES NO-LOCK NO-ERROR.
           IF AVAIL bfuwm100 THEN DO:
               ASSIGN
               n_rencnt  =  sicuw.uwm100.rencnt  +  1
               n_endcnt  =  0
               wdetail.pass  = "Y".
               IF wdetail.covcod = "1" THEN DO:
                   IF      sicuw.uwm100.acno1 = "B3M0059"  THEN   ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
                   ELSE IF      sicuw.uwm100.acno1 = "B3M0065"  THEN DO: 
                       ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
                       IF wdetail.garage = "" AND  (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 8 ) THEN
                           ASSIGN wdetail2.producer = "B3M0062" .
                   END.
                   ELSE IF sicuw.uwm100.acno1 = "B3M0062"  THEN ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
                   ELSE IF sicuw.uwm100.acno1 = "B3M0064" OR sicuw.uwm100.acno1 = "B3M0061" OR sicuw.uwm100.acno1 = "B3M0063"  THEN DO:
                       ASSIGN wdetail2.producer = "B3M0064" .
                       /*IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 7 ) THEN  ASSIGN wdetail2.producer = "B3M0062" .*/
                       IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 2 ) AND  (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 7 ) THEN DO: 
                           IF wdetail.garage = "" THEN ASSIGN wdetail2.producer = "B3M0062" .
                       END.
                       ELSE IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) > 7 ) THEN DO:  
                           IF wdetail.garage <> "" THEN ASSIGN wdetail2.producer = "B3M0064" . /*ซ่อมห้าง*/
                           ELSE ASSIGN wdetail2.producer = "B3M0062" .
                       END.
                   END.
               END.
               IF sicuw.uwm100.acno1 = "B3M0070" OR sicuw.uwm100.acno1 = "B3M0071" THEN ASSIGN wdetail2.producer = sicuw.uwm100.acno1. /* EV */ 
               

               RUN proc_assignrenew.  
           END.
           /* end : A67-0065*/
           ELSE DO:
            MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
            ASSIGN
                /*wdetail.prepol  = "Already Renew"*/ /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
                wdetail2.comment = wdetail2.comment + "| กรมธรรณ์มีการต่ออายุแล้ว"     
                WDETAIL2.OK_GEN  = "N"
                wdetail.pass    = "N" 
                wdetail2.pass = "N" .
           END.
       END.
       ELSE DO: 
           ASSIGN
               n_rencnt  =  sicuw.uwm100.rencnt  +  1
               n_endcnt  =  0
               wdetail.pass  = "Y".
           /*--A60-0085 --*/
           /* comment by A63-0443...
           IF wdetail.covcod = "1" AND sicuw.uwm100.acno1 = "B3M0038" THEN DO: 
                ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
           END.
           ELSE IF wdetail.covcod = "1" AND sicuw.uwm100.acno1 = "B3M0023" THEN DO:  /*Add by Kridtiya i. A63-0206*/
               ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
           END. 
           ...end A63-0443..*/
           /*--A60-0085 --*/
           /* add by A63-0443*/
/*            IF wdetail.covcod = "1" AND sicuw.uwm100.acno1 = "B3M0038" THEN DO:      */
/*                 ASSIGN wdetail2.producer = "B3M0065".                               */
/*            END.                                                                     */
/*            ELSE IF wdetail.covcod = "1" AND sicuw.uwm100.acno1 = "B3M0065" THEN DO: */
           /*IF wdetail.covcod = "1" AND sicuw.uwm100.acno1 = "B3M0065" THEN DO: 
               ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
           END.
           /*ELSE IF wdetail.covcod = "1" AND sicuw.uwm100.acno1 = "B3M0023" THEN DO:
               ASSIGN wdetail2.producer = "B3M0062".
           END.*/
           ELSE IF wdetail.covcod = "1" AND sicuw.uwm100.acno1 = "B3M0062" THEN DO:  
               ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
           END. */
           IF wdetail.covcod = "1" THEN DO:
               IF      sicuw.uwm100.acno1 = "B3M0059"  THEN   ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
               ELSE IF      sicuw.uwm100.acno1 = "B3M0065"  THEN DO: 
                   ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
                   IF wdetail.garage = "" AND  (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 8 ) THEN
                       ASSIGN wdetail2.producer = "B3M0062" .
               END.
               ELSE IF sicuw.uwm100.acno1 = "B3M0062"  THEN ASSIGN wdetail2.producer = sicuw.uwm100.acno1.
               ELSE IF sicuw.uwm100.acno1 = "B3M0064" OR sicuw.uwm100.acno1 = "B3M0061" OR sicuw.uwm100.acno1 = "B3M0063" THEN DO:
                   ASSIGN wdetail2.producer = "B3M0064" .
                   /*IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 7 ) THEN  ASSIGN wdetail2.producer = "B3M0062" .*/
                   IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 2 ) AND  (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 7 ) THEN DO: 
                       IF wdetail.garage = "" THEN ASSIGN wdetail2.producer = "B3M0062" .
                   END.
                   ELSE IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) > 7 ) THEN DO:  
                       IF wdetail.garage <> "" THEN ASSIGN wdetail2.producer = "B3M0064" . /*ซ่อมห้าง*/
                       ELSE ASSIGN wdetail2.producer = "B3M0062" .
                   END.
               END.
           END.
           /* end : A63-0443 */
           RUN proc_assignrenew.
       END.
   End.   /*  avail  buwm100  */
   Else do:  
       n_rencnt  =  0.
       n_Endcnt  =  0.
       ASSIGN
           wdetail.prepol   = ""
           wdetail2.comment = wdetail2.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".   
         
   END.  /*not  avail uwm100*/
   IF wdetail.pass    = "Y" THEN wdetail2.comment = "COMPLETE".
     /*RUN wexp\wexpdisc.*//*a490166 note Block ชั่วคราว*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew72 C-Win 
PROCEDURE proc_renew72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A60-0085      
------------------------------------------------------------------------------*/
DEF BUFFER buwdetail  FOR wdetail.
DEF VAR rw_class AS CHAR FORMAT "x(5)" INIT "".

ASSIGN rw_class = "".

OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "004: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.

FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail.prepol
    No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    /*IF sicuw.uwm100.acno1 = "B3M0038" THEN DO:*/ /*A63-0443*/
    /*IF (sicuw.uwm100.acno1 = "B3M0038" OR sicuw.uwm100.acno1 = "B3M0065" ) THEN DO:  /*A63-0443*/*/
    IF (sicuw.uwm100.acno1 = "B3M0038" OR sicuw.uwm100.acno1 = "B3M0065" OR sicuw.uwm100.acno1 = "B3M0064") THEN DO:  /*A63-0443*/
        FIND LAST buwdetail WHERE buwdetail.policyno = wdetail2.cr_2 NO-ERROR .
        IF AVAIL buwdetail THEN DO:
            IF buwdetail.covcod = "1" THEN DO:
                /*ASSIGN wdetail2.producer = sicuw.uwm100.acno1.*/ /*A63-0443*/
                ASSIGN wdetail2.producer = IF sicuw.uwm100.acno1 = "B3M0038" THEN "B3M0065" ELSE sicuw.uwm100.acno1.  /*A63-0443*/
                IF sicuw.uwm100.acno1 = "B3M0064"  THEN DO:   /*A65-00363*/
                    /*IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 7 ) THEN  ASSIGN wdetail2.producer = "B3M0062" .  /*A65-00363*/*/
                    ASSIGN wdetail2.producer = "B3M0064" . 
                    IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) >= 2 ) AND  (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) <= 7 ) THEN DO: 
                        IF buwdetail.garage = "" THEN ASSIGN wdetail2.producer = "B3M0062" .
                    END.
                    ELSE IF (( YEAR(TODAY) - deci(wdetail.caryear) + 1 ) > 7 ) THEN DO:  
                       IF buwdetail.garage <> "" THEN ASSIGN wdetail2.producer = "B3M0064" .
                       ELSE ASSIGN wdetail2.producer = "B3M0062" .
                    END. 
                END.
            END.
            ELSE IF sicuw.uwm100.acno1 = "B3M0064" THEN ASSIGN wdetail2.producer = "B3M0062" .  /*A65-00363*/
        END.
    END.
    ELSE IF  (sicuw.uwm100.acno1 = "B3M0060") OR (sicuw.uwm100.acno1 = "B3M0061") OR
             (sicuw.uwm100.acno1 = "B3M0063") OR (sicuw.uwm100.acno1 = "B3M0064") OR
             (sicuw.uwm100.acno1 = "B3M0066") OR (sicuw.uwm100.acno1 = "B3M0068")  THEN ASSIGN wdetail2.producer = "B3M0064".
    ELSE IF  (sicuw.uwm100.acno1 = "B3M0062")  THEN ASSIGN wdetail2.producer = "B3M0062".
                       

    /*Add by Kridtiya i. .........Date 05/10/2018*/
    FIND LAST  sicuw.uwm120 USE-INDEX uwm12001     WHERE
        sicuw.uwm120.policy  = sicuw.uwm100.policy    AND
        sicuw.uwm120.rencnt  = sicuw.uwm100.rencnt    AND
        sicuw.uwm120.endcnt  = sicuw.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm120 THEN DO:
        ASSIGN rw_class = substring(sicuw.uwm120.class,2,3).
        /* Ranu I. A64-0422 01/10/2021 */
        FIND LAST sicuw.uwm301 USE-INDEX uwm30101      WHERE
           sicuw.uwm301.policy = sicuw.uwm100.policy    AND
           sicuw.uwm301.rencnt = sicuw.uwm100.rencnt    AND
           sicuw.uwm301.endcnt = sicuw.uwm100.endcnt    NO-ERROR NO-WAIT.
        IF AVAIL uwm301 THEN ASSIGN wdetail2.redbook     = sicuw.uwm301.modcod .  /* redbook  */  
        /* end Ranu I. A64-0422 01/10/2021 */
    END.
END.   /*  avail  buwm100  */
IF      rw_class = "110" THEN wdetail2.subclass = "110".  /*Add by Kridtiya i. */
ELSE IF rw_class = "210" THEN wdetail2.subclass = "120A". /*Add by Kridtiya i. */
ELSE IF rw_class = "220" THEN wdetail2.subclass = "120A". /*Add by Kridtiya i. */
ELSE IF rw_class = "320" THEN wdetail2.subclass = "140A". /*Add by Kridtiya i. */
wdetail.prepol = "".
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
FOR EACH wdetail :
    FOR EACH  wdetail2  WHERE wdetail2.PASS <> "Y"  :
       NOT_pass = NOT_pass + 1.
    END.
END.
IF NOT_pass > 0 THEN DO:
OUTPUT STREAM ns1 TO value(fi_output2).
PUT STREAM ns1
    "policyno  "   ","                                  /*1*/    
     "comment     " ","                                 /*2*/    
     "Branch    "   ","                                 /*3*/    
     "Redbook   "   ","                                 /*4*/    
     "brand    "    ","                                 /*5*/    
     "model    "    ","                                 /*6*/    
     "body     "    ","                                 /*7*/    
     "seat      "   ","                                 /*8*/    
     "engcc     "   ","                                 /*9*/    
     "Delercode "   ","                                 /*10*/   
     "vatcode   "   ","                                 /*11*/   
     "cndat     "   ","                                 /*12*/   
     "appenno   "   ","                                 /*13*/   
     "comdat    "   ","                                 /*14*/   
     "expdat    "   ","                                 /*15*/   
     "comcode   "   ","                                 /*16*/   
     "cartyp    "   ","                                 /*17*/   
     "saletyp   "   ","                                 /*18*/   
     "campen    "   ","                                 /*19*/   
     "freeamonth"   ","                                 /*20*/   
     "covcod    "   ","                                 /*21*/   
     "typcom    "   ","                                 /*22*/   
     "garage    "   ","                                 /*23*/   
     "bysave    "   ","                                 /*24*/   
     "tiname    "   ","                                 /*25*/   
     "insnam    "   ","                                 /*26*/   
     "name2     "   ","                                 /*27*/   
     "name3     "   ","                                 /*28*/   
     "addr      "   ","                                 /*29*/   
     "road     "    ","                                 /*30*/   
     "tambon   "    ","                                 /*31*/   
     "amper    "    ","                                 /*32*/   
     "country  "    ","                                 /*33*/   
     "post     "    ","                                 /*34*/   
     "occup    "    ","                                 /*35*/   
     "birthdat "    ","                                 /*36*/   
     "icno     "    ","                                 /*37*/   
     "driverno "    ","                                 /*38*/   
     "cargrp   "    ","                                 /*39*/   
     "chasno   "    ","                                 /*40*/   
     "eng      "    ","                                 /*41*/   
     "caryear  "    ","                                 /*42*/   
     "carcode  "    ","                                 /*43*/   
     "carno    "    ","                                 /*44*/   
     "vehuse   "    ","                                 /*45*/   
     "colorcar  "   ","                                 /*46*/   
     "vehreg    "   ","                                 /*47*/   
     "re_country"   ","                                 /*48*/   
     "re_year   "   ","                                 /*49*/   
     "nmember   "   ","                                 /*50*/   
     "si        "   ","                                 /*51*/   
     "premt     "   ","                                 /*52*/   
     "rstp_t    "   ","                                 /*53*/   
     "rtax_t    "   ","                                 /*54*/   
     "prem_r    "   ","                                 /*55*/   
     "gap       "   ","                                 /*56*/   
     "ncb       "   ","                                 /*57*/   
     "ncbprem   "   ","                                 /*58*/   
     "stk       "   ","                                 /*59*/   
     "prepol    "   ","                                 /*60*/   
     "flagname  "   ","                                 /*61*/   
     "flagno    "   ","                                 /*62*/   
     "ntitle1    "  ","                                 /*63*/   
     "drivername1"  ","                                 /*64*/   
     "dname1     "  ","                                 /*65*/   
     "dname2     "  ","                                 /*66*/   
     "docoup     "  ","                                 /*67*/   
     "dbirth     "  ","                                 /*68*/   
     "dicno      "  ","                                 /*69*/   
     "ddriveno   "  ","                                 /*70*/   
     "ntitle2    "  ","                                 /*71*/   
     "drivername2"  ","                                 /*72*/   
     "ddname1    "  ","                                 /*73*/   
     "ddname2    "  ","                                 /*74*/   
     "ddocoup    "  ","                                 /*75*/   
     "ddbirth    "  ","                                 /*76*/   
     "ddicno     "  ","                                 /*77*/   
     "dddriveno  "  ","                                 /*78*/   
     "benname    "  ","                                 /*79*/   
     "comper     "  ","                                 /*80*/   
     "comacc     "  ","                                 /*81*/   
     "deductpd   "  ","                                 /*82*/   
     "tp2        "  ","                                 /*83*/   
     "deductda   "  ","                                 /*84*/   
     "deduct     "  ","                                 /*85*/   
     "tpfire     "  ","                                 /*86*/   
     "compul     "  ","                                 /*87*/   
     "pass       "  ","                                 /*88*/   
     "NO_41      "  ","                                 /*89*/   
     "ac2        "  ","                                 /*90*/   
     "NO_42      "  ","                                 /*91*/   
     "ac4        "  ","                                 /*92*/   
     "ac5        "  ","                                 /*93*/   
     "ac6        "  ","                                 /*94*/   
     "ac7        "  ","                                 /*95*/   
     "NO_43      "  ","                                 /*96*/   
     "nstatus    "  ","                                 /*97*/   
     "typrequest "  ","                                 /*98*/   
     "comrequest "  ","                                 /*99*/   
     "brrequest  "  ","                                 /*100*/  
     "salename    " ","                                 /*101*/  
     "comcar      " ","                                 /*102*/  
     "brcar       " ","                                 /*103*/  
     "projectno   " ","                                 /*104*/  
     "caryear     " ","                                 /*105*/  
     "special1    " ","                                 /*106*/  
     "specialprem1" ","                                 /*107*/  
     "special2    " ","                                 /*108*/  
     "specialprem2" ","                                 /*109*/  
     "special3    " ","                                 /*110*/  
     "specialprem3" ","                                 /*111*/  
     "special4    " ","                                 /*112*/  
     "specialprem4" ","                                 /*113*/  
     "special5    " ","                                 /*114*/  
     "specialprem5" ","                                 /*115*/
     "Campaign No " ","     /*-- A58-0419--*/           /*116*/  
     "Payment Type" ","     /*-- A58-0419--*/           /*117*/  
     "WARNING     " SKIP.                               /*118*/               
FOR EACH  wdetail :                                     
    FOR EACH wdetail2 WHERE wdetail2.PASS <> "Y"  AND                
                            wdetail2.policyno = wdetail.policyno : 
        FIND FIRST wdetail3 WHERE wdetail3.policyno = wdetail2.policyno  NO-LOCK NO-ERROR .
        PUT STREAM ns1 
            wdetail.policyno      ","                          /*1*/   
            wdetail2.comment      ","                          /*2*/   
            wdetail2.n_branch     ","                          /*3*/   
            wdetail2.redbook      ","                          /*4*/   
            wdetail.brand         ","                          /*5*/   
            wdetail.model         ","                          /*6*/   
            wdetail.body          ","                          /*7*/   
            wdetail.seat          ","                          /*8*/   
            wdetail.engcc         ","                          /*9*/   
            wdetail2.n_delercode  ","                          /*10*/  
            wdetail2.typrequest   ","                          /*11*/  
            wdetail.cndat         ","                          /*12*/  
            wdetail.appenno       ","                          /*13*/  
            wdetail.comdat        ","                          /*14*/  
            wdetail.expdat        ","                          /*15*/  
            wdetail.comcode       ","                          /*16*/  
            wdetail.cartyp        ","                          /*17*/  
            wdetail.saletyp       ","                          /*18*/  
            wdetail.campen        ","                          /*19*/  
            wdetail.freeamonth    ","                          /*20*/  
            wdetail.covcod        ","                          /*21*/  
            wdetail.typcom        ","                          /*22*/  
            wdetail.garage        ","                          /*23*/  
            wdetail.bysave        ","                          /*24*/  
            wdetail.tiname        ","                          /*25*/  
            wdetail.insnam        ","                          /*26*/  
            wdetail.name2         ","                          /*27*/  
            wdetail.name3         ","                          /*28*/  
            wdetail.addr          ","                          /*29*/  
            wdetail.road          ","                          /*30*/  
            wdetail.tambon        ","                          /*31*/  
            wdetail.amper         ","                          /*32*/  
            wdetail.country       ","                          /*33*/  
            wdetail.post          ","                          /*34*/  
            wdetail.occup         ","                          /*35*/  
            wdetail.birthdat      ","                          /*36*/  
            wdetail.icno          ","                          /*37*/  
            wdetail.driverno      ","                          /*38*/  
            wdetail.cargrp        ","                          /*39*/  
            wdetail.chasno        ","                          /*40*/  
            wdetail.eng           ","                          /*41*/  
            wdetail.caryear       ","                          /*42*/  
            wdetail.carcode       ","                          /*43*/  
            wdetail.carno         ","                          /*44*/  
            wdetail.vehuse        ","                          /*45*/  
            wdetail.colorcar      ","                          /*46*/  
            wdetail.vehreg        ","                          /*47*/  
            wdetail.re_country    ","                          /*48*/  
            wdetail.re_year       ","                          /*49*/  
            wdetail.nmember       ","                          /*50*/  
            wdetail.si            ","                          /*51*/  
            wdetail.premt         ","                          /*52*/  
            wdetail.rstp_t        ","                          /*53*/  
            wdetail.rtax_t        ","                          /*54*/  
            wdetail.prem_r        ","                          /*55*/  
            wdetail.gap           ","                          /*56*/  
            wdetail.ncb           ","                          /*57*/  
            wdetail.ncbprem       ","                          /*58*/  
            wdetail.stk           ","                          /*59*/  
            wdetail.prepol        ","                          /*60*/  
            wdetail.flagname      ","                          /*61*/  
            wdetail.flagno        ","                          /*62*/  
            wdetail.ntitle1       ","                          /*63*/  
            wdetail.drivername1   ","                          /*64*/  
            wdetail.dname1        ","                          /*65*/  
            wdetail.dname2        ","                          /*66*/  
            wdetail.docoup        ","                          /*67*/  
            wdetail.dbirth        ","                          /*68*/  
            wdetail.dicno         ","                          /*69*/  
            wdetail.ddriveno      ","                          /*70*/  
            wdetail.ntitle2       ","                          /*71*/  
            wdetail.drivername2   ","                          /*72*/  
            wdetail.ddname1       ","                          /*73*/  
            wdetail.ddname2       ","                          /*74*/  
            wdetail.ddocoup       ","                          /*75*/  
            wdetail.ddbirth       ","                          /*76*/  
            wdetail.ddicno        ","                          /*77*/  
            wdetail.dddriveno     ","                          /*78*/  
            wdetail.benname       ","                          /*79*/  
            wdetail.comper        ","                          /*80*/  
            wdetail.comacc        ","                          /*81*/  
            wdetail.deductpd      ","                          /*82*/  
            wdetail.tp2           ","                          /*83*/  
            wdetail.deductda      ","                          /*84*/  
            wdetail.deduct        ","                          /*85*/  
            wdetail.tpfire        ","                          /*86*/  
            wdetail.compul        ","                          /*87*/  
            wdetail.pass          ","                          /*88*/  
            wdetail2.NO_41         ","                         /*89*/  
            wdetail2.ac2           ","                         /*90*/  
            wdetail2.NO_42         ","                         /*91*/  
            wdetail2.ac4           ","                         /*92*/  
            wdetail2.ac5           ","                         /*93*/  
            wdetail2.ac6           ","                         /*94*/  
            wdetail2.ac7           ","                         /*95*/  
            wdetail2.NO_43         ","                         /*96*/  
            wdetail2.nstatus       ","                         /*97*/  
            wdetail2.typrequest    ","                         /*98*/  
            wdetail2.comrequest    ","                         /*99*/  
            wdetail2.brrequest     ","                         /*100*/ 
            wdetail2.salename      ","                         /*101*/ 
            wdetail2.comcar        ","                         /*102*/ 
            wdetail2.brcar         ","                         /*103*/ 
            wdetail2.projectno     ","                         /*104*/ 
            wdetail2.caryear       ","                         /*105*/ 
            wdetail2.special1      ","                         /*106*/ 
            wdetail2.specialprem1  ","                         /*107*/ 
            wdetail2.special2      ","                         /*108*/ 
            wdetail2.specialprem2  ","                         /*109*/ 
            wdetail2.special3      ","                         /*110*/ 
            wdetail2.specialprem3  ","                         /*111*/ 
            wdetail2.special4      ","                         /*112*/ 
            wdetail2.specialprem4  ","                         /*113*/ 
            wdetail2.special5      ","                         /*114*/ 
            wdetail2.specialprem5  ","                         /*115*/
            wdetail3.camp_no       ","  /*-- A58-0419--*/      /*116*/ 
            wdetail3.payment_type  ","  /*-- A58-0419--*/      /*117*/ 
            wdetail2.WARNING        SKIP.                      /*118*/
       
    END.                                                      
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
FOR EACH  wdetail  .
    FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno AND
        wdetail2.PASS = "Y"  :
        FIND FIRST wdetail3 WHERE wdetail3.policyno = wdetail2.policyno  NO-LOCK NO-ERROR .
        pass = pass + 1.
END.
END.
IF pass > 0 THEN DO:
OUTPUT STREAM ns2 TO value(fi_output1).
          PUT STREAM NS2
              "policyno    "   "|"                           /*1*/   
              "producer    "   "|"                           /*2*/  
              "n_branch    "   "|"                           /*3*/  
              "si          "   "|"                           /*4*/   
              "gap         "   "|"                           /*5*/   
              "redbook     "   "|"                           /*6*/   
              "model       "   "|"                           /*7*/   
              "carcode     "   "|"                           /*8*/  
              "n_delercode "   "|"                           /*9*/   
              "typrequest  "   "|"                           /*10*/ 
              "cndat       "   "|"                           /*11*/   
              "appenno     "   "|"                           /*12*/   
              "comdat      "   "|"                           /*13*/   
              "expdat      "   "|"                           /*14*/   
              "comcode     "   "|"                           /*15*/   
              "cartyp      "   "|"                           /*16*/   
              "saletyp     "   "|"                           /*17*/   
              "campen      "   "|"                           /*18*/   
              "freeamonth  "   "|"                           /*19*/   
              "covcod      "   "|"                           /*20*/   
              "typcom      "   "|"                           /*21*/   
              "garage      "   "|"                           /*22*/   
              "bysave      "   "|"                           /*23*/   
              "tiname      "   "|"                           /*24*/   
              "insnam      "   "|"                           /*25*/   
              "name2       "   "|"                           /*26*/   
              "name3       "   "|"                           /*27*/   
              "addr        "   "|"                           /*28*/   
              "road        "   "|"                           /*29*/   
              "tambon      "   "|"                           /*30*/   
              "amper       "   "|"                           /*31*/   
              "country     "   "|"                           /*32*/   
              "post        "   "|"                           /*33*/   
              "occup        "   "|"                          /*34*/   
              "birthdat     "   "|"                          /*35*/   
              "icno         "   "|"                          /*36*/   
              "driverno     "   "|"                          /*37*/   
              "brand        "   "|"                          /*38*/   
              "cargrp       "   "|"                          /*39*/   
              "chasno       "   "|"                          /*40*/   
              "eng          "   "|"                          /*41*/   
              "caryear      "   "|"                          /*42*/   
              "body         "   "|"                          /*43*/   
              "carno        "   "|"                          /*44*/   
              "vehuse       "   "|"                          /*45*/   
              "seat         "   "|"                          /*46*/   
              "engcc        "   "|"                          /*47*/   
              "colorcar     "   "|"                          /*48*/   
              "vehreg       "   "|"                          /*49*/   
              "re_country   "   "|"                          /*50*/   
              "re_year      "   "|"                          /*51*/   
              "nmember      "   "|"                          /*52*/   
              "premt        "   "|"                          /*53*/   
              "rstp_t       "   "|"                          /*54*/   
              "rtax_t       "   "|"                          /*55*/   
              "prem_r       "   "|"                          /*56*/   
              "ncb          "   "|"                          /*57*/   
              "ncbprem      "   "|"                          /*58*/   
              "stk          "   "|"                          /*59*/   
              "prepol       "   "|"                          /*60*/   
              "flagname     "   "|"                          /*61*/   
              "flagno       "   "|"                          /*62*/   
              "ntitle1      "   "|"                          /*63*/   
              "drivername1  "   "|"                          /*64*/   
              "dname1       "   "|"                          /*65*/   
              "dname2       "   "|"                          /*66*/   
              "docoup       "   "|"                          /*67*/   
              "dbirth       "   "|"                          /*68*/   
              "dicno        "   "|"                          /*69*/   
              "ddriveno     "   "|"                          /*70*/   
              "ntitle2      "   "|"                          /*71*/   
              "drivername2  "   "|"                          /*72*/   
              "ddname1      "   "|"                          /*73*/   
              "ddname2      "   "|"                          /*74*/   
              "ddocoup      "   "|"                          /*75*/   
              "ddbirth      "   "|"                          /*76*/   
              "ddicno       "   "|"                          /*77*/   
              "dddriveno    "   "|"                          /*78*/   
              "benname      "   "|"                          /*79*/   
              "comper       "   "|"                          /*80*/   
              "comacc       "   "|"                          /*81*/   
              "deductpd     "   "|"                          /*82*/   
              "tp2          "   "|"                          /*83*/   
              "deductda     "   "|"                          /*84*/   
              "deduct       "   "|"                          /*85*/   
              "tpfire       "   "|"                          /*86*/   
              "compul       "   "|"                          /*87*/   
              "pass         "   "|"                          /*88*/   
              "NO_41        "   "|"                           /*89*/   
              "ac2          "   "|"                           /*90*/   
              "NO_42        "   "|"                           /*91*/   
              "ac4          "   "|"                           /*92*/   
              "ac5          "   "|"                           /*93*/   
              "ac6          "   "|"                           /*94*/   
              "ac7          "   "|"                           /*95*/   
              "NO_43        "   "|"                           /*96*/   
              "nstatus      "   "|"                           /*97*/   
              "typrequest   "   "|"                           /*98*/  
              "comrequest   "   "|"                           /*99*/  
              "brrequest    "   "|"                           /*100*/  
              "salename     "   "|"                           /*101*/  
              "comcar       "   "|"                           /*102*/  
              "brcar        "   "|"                           /*103*/  
              "projectno    "   "|"                           /*104*/  
              "caryear      "   "|"                           /*105*/  
              "special1     "   "|"                           /*106*/  
              "specialprem1 "   "|"                           /*107*/  
              "special2     "   "|"                           /*108*/  
              "specialprem2 "   "|"                           /*109*/  
              "special3     "   "|"                           /*110*/  
              "specialprem3 "   "|"                           /*111*/  
              "special4     "   "|"                           /*112*/  
              "specialprem4 "   "|"                           /*113*/  
              "special5     "   "|"                           /*114*/  
              "specialprem5 "   "|"                           /*115*/ 
              "Campaign No  "   "|"         /*--a58-0419--*/  /*116*/  
              "Payment Type "   "|"         /*--a58-0419--*/  /*117*/
              "comment      "   "|"                           /*118*/
              "WARNING      "        SKIP.                        /*119*/
                    
    FOR EACH  wdetail  .
    FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno AND
        wdetail2.PASS = "Y"  :
        FIND FIRST wdetail3 WHERE wdetail3.policyno = wdetail2.policyno  NO-LOCK NO-ERROR .
        PUT STREAM ns2
            wdetail.policyno      "|"                                  /*1*/   
            wdetail2.producer     "|"                                  /*2*/   
            wdetail2.n_branch     "|"                                  /*3*/   
            wdetail.si            "|"                                  /*4*/   
            wdetail.gap           "|"                                  /*5*/   
            wdetail2.redbook      "|"                                  /*6*/   
            wdetail.model         "|"                                  /*7*/   
            wdetail.carcode       "|"                                  /*8*/   
            wdetail2.n_delercode  "|"                                  /*9*/   
            wdetail2.typrequest   "|"                                  /*10*/  
            wdetail.cndat         "|"                                  /*11*/  
            wdetail.appenno       "|"                                  /*12*/  
            wdetail.comdat        "|"                                  /*13*/  
            wdetail.expdat        "|"                                  /*14*/  
            wdetail.comcode       "|"                                  /*15*/  
            wdetail.cartyp        "|"                                  /*16*/  
            wdetail.saletyp       "|"                                  /*17*/  
            wdetail.campen        "|"                                  /*18*/  
            wdetail.freeamonth    "|"                                  /*19*/  
            wdetail.covcod        "|"                                  /*20*/  
            wdetail.typcom        "|"                                  /*21*/  
            wdetail.garage        "|"                                  /*22*/  
            wdetail.bysave        "|"                                  /*23*/  
            wdetail.tiname        "|"                                  /*24*/  
            wdetail.insnam        "|"                                  /*25*/  
            wdetail.name2         "|"                                  /*26*/  
            wdetail.name3         "|"                                  /*27*/  
            wdetail.addr          "|"                                  /*28*/  
            wdetail.road          "|"                                  /*29*/  
            wdetail.tambon        "|"                                  /*30*/  
            wdetail.amper         "|"                                  /*31*/  
            wdetail.country       "|"                                  /*32*/  
            wdetail.post          "|"                                  /*33*/  
            wdetail.occup         "|"                                  /*34*/  
            wdetail.birthdat      "|"                                  /*35*/  
            wdetail.icno          "|"                                  /*36*/  
            wdetail.driverno      "|"                                  /*37*/  
            wdetail.brand         "|"                                  /*38*/  
            wdetail.cargrp        "|"                                  /*39*/  
            wdetail.chasno        "|"                                  /*40*/  
            wdetail.eng           "|"                                  /*41*/  
            wdetail.caryear       "|"                                  /*42*/  
            wdetail.body          "|"                                  /*43*/  
            wdetail.carno         "|"                                  /*44*/  
            wdetail.vehuse        "|"                                  /*45*/  
            wdetail.seat          "|"                                  /*46*/  
            wdetail.engcc         "|"                                  /*47*/  
            wdetail.colorcar      "|"                                  /*48*/  
            wdetail.vehreg        "|"                                  /*49*/  
            wdetail.re_country    "|"                                  /*50*/  
            wdetail.re_year       "|"                                  /*51*/  
            wdetail.nmember       "|"                                  /*52*/  
            wdetail.premt         "|"                                  /*53*/  
            wdetail.rstp_t        "|"                                  /*54*/  
            wdetail.rtax_t        "|"                                  /*55*/  
            wdetail.prem_r        "|"                                  /*56*/  
            wdetail.ncb           "|"                                  /*57*/  
            wdetail.ncbprem       "|"                                  /*58*/  
            wdetail.stk           "|"                                  /*59*/  
            wdetail.prepol        "|"                                  /*60*/  
            wdetail.flagname      "|"                                  /*61*/  
            wdetail.flagno        "|"                                  /*62*/  
            wdetail.ntitle1       "|"                                  /*63*/  
            wdetail.drivername1   "|"                                  /*64*/  
            wdetail.dname1        "|"                                  /*65*/  
            wdetail.dname2        "|"                                  /*66*/  
            wdetail.docoup        "|"                                  /*67*/  
            wdetail.dbirth        "|"                                  /*68*/  
            wdetail.dicno         "|"                                  /*69*/  
            wdetail.ddriveno      "|"                                  /*70*/  
            wdetail.ntitle2       "|"                                  /*71*/  
            wdetail.drivername2   "|"                                  /*72*/  
            wdetail.ddname1       "|"                                  /*73*/  
            wdetail.ddname2       "|"                                  /*74*/  
            wdetail.ddocoup       "|"                                  /*75*/  
            wdetail.ddbirth       "|"                                  /*76*/  
            wdetail.ddicno        "|"                                  /*77*/  
            wdetail.dddriveno     "|"                                  /*78*/  
            wdetail.benname       "|"                                  /*79*/  
            wdetail.comper        "|"                                  /*80*/  
            wdetail.comacc        "|"                                  /*81*/  
            wdetail.deductpd      "|"                                  /*82*/  
            wdetail.tp2           "|"                                  /*83*/  
            wdetail.deductda      "|"                                  /*84*/  
            wdetail.deduct        "|"                                  /*85*/  
            wdetail.tpfire        "|"                                  /*86*/  
            wdetail.compul        "|"                                  /*87*/  
            wdetail.pass          "|"                                  /*88*/  
            wdetail2.NO_41         "|"                                 /*89*/  
            wdetail2.ac2           "|"                                 /*90*/  
            wdetail2.NO_42         "|"                                 /*91*/  
            wdetail2.ac4           "|"                                 /*92*/  
            wdetail2.ac5           "|"                                 /*93*/  
            wdetail2.ac6           "|"                                 /*94*/  
            wdetail2.ac7           "|"                                 /*95*/  
            wdetail2.NO_43         "|"                                 /*96*/  
            wdetail2.nstatus       "|"                                 /*97*/  
            wdetail2.typrequest    "|"                                 /*98*/  
            wdetail2.comrequest    "|"                                 /*99*/  
            wdetail2.brrequest     "|"                                 /*100*/ 
            wdetail2.salename      "|"                                 /*101*/ 
            wdetail2.comcar        "|"                                 /*102*/ 
            wdetail2.brcar         "|"                                 /*103*/ 
            wdetail2.projectno     "|"                                 /*104*/ 
            wdetail2.caryear       "|"                                 /*105*/ 
            wdetail2.special1      "|"                                 /*106*/ 
            wdetail2.specialprem1  "|"                                 /*107*/ 
            wdetail2.special2      "|"                                 /*108*/ 
            wdetail2.specialprem2  "|"                                 /*109*/ 
            wdetail2.special3      "|"                                 /*110*/ 
            wdetail2.specialprem3  "|"                                 /*111*/ 
            wdetail2.special4      "|"                                 /*112*/ 
            wdetail2.specialprem4  "|"                                 /*113*/ 
            wdetail2.special5      "|"                                 /*114*/ 
            wdetail2.specialprem5  "|"                                 /*115*/ 
            wdetail3.camp_no       "|"          /*--A58-0419--*/       /*116*/ 
            wdetail3.payment_type  "|"          /*--A58-0419--*/       /*117*/ 
            wdetail2.comment       "|"                                 /*118*/ 
            wdetail2.WARNING        SKIP.                              /*119*/

  END. 
  END.
OUTPUT STREAM ns2 CLOSE.                                                           
END. /*pass > 0*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT3 C-Win 
PROCEDURE PROC_REPORT3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.
def var nv_cnt   as  int  init  0.
DEF VAR nw_icno  AS CHAR FORMAT "x(15)" INIT "".
DEF VAR acno1gw  AS CHAR FORMAT "x(20)" INIT "".
DEF VAR agentgw  AS CHAR FORMAT "x(20)" INIT "".
ASSIGN nv_row  =  1.
FOR EACH  wdetail  .
    FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno AND
        wdetail2.PASS = "Y"  :
        pass = pass + 1.
    END.
END. 
IF pass > 0 THEN DO:
    /*OUTPUT STREAM ns2 TO value(fi_outputpro).
    PUT STREAM NS2
        "กรมธรรม์"                    "|"   
        "สาขา"                        "|"   
        "producerที่เข้าระบบpremium"  "|"   
        "producerที่setup"            "|"   
        "gap"                         "|"   
        "ทุน"                         "|"   
        "ปีที่จดทะเบียน"              "|"   
        "ปีรถ"                        "|"                  
        "รุ่น"                        "|"   
        "ยี่ห้อ"                      "|"   
        "tiname"                      "|"   
        "insnam"                      "|"   
        "name2"                       "|"   
        "name3"                       
        SKIP.  */
    ASSIGN 
        nw_icno = ""
        nv_cnt  =   0
        nv_row  =  1.
    OUTPUT STREAM ns2 TO value(fi_outputpro).
    PUT STREAM ns2 "ID;PND" SKIP.
                                                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "กรมธรรม์"                    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "สาขา"                        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "Producerที่เข้าระบบpremium"  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "Producer SET"                '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Producer_GW"                 '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Agent_GW"                    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "ประเภทการขาย"                '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "Campaign"                    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "ประเภทการแจ้งงาน"            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "gap"                         '"' SKIP.                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "ทุน"                         '"' SKIP.                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "ปีที่จดทะเบียน"              '"' SKIP.                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "ปีรถ"                        '"' SKIP.                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "รุ่น"                        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "ยี่ห้อ"                      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "tiname"                      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "insnam"                      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "name2"                       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "name3"                       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "icno"                        '"' SKIP . /*a64-0328*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "insurce "                    '"' SKIP .
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Comment "                    '"' SKIP .

    FOR EACH  wdetail  .
        FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno  AND
            wdetail2.PASS = "Y"  :
            ASSIGN 
                nw_icno = ""
                nv_cnt  =  nv_cnt  + 1                      
                nv_row  =  nv_row  + 1 
                acno1gw = ""
                agentgw = "".

            FIND LAST sic_bran.uwm100 USE-INDEX uwm10001 WHERE 
                sic_bran.uwm100.policy = trim(wdetail2.policyno)  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sic_bran.uwm100 THEN
                ASSIGN 
                acno1gw = sic_bran.uwm100.acno1 
                agentgw = sic_bran.uwm100.agent .
            ELSE ASSIGN acno1gw = "" 
                        agentgw = "".


            FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
                sicsyac.xmm600.acno = wdetail2.nv_insref  NO-LOCK NO-ERROR NO-WAIT.            
            IF   AVAILABLE sicsyac.xmm600 THEN   nw_icno =  trim(sicsyac.xmm600.icno).
            ELSE nw_icno = "".
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetail.policyno     '"' SKIP. 
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetail2.n_branch    '"' SKIP. 
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetail2.producer    '"' SKIP. 
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail2.producer2   '"' SKIP. 
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  acno1gw              '"' SKIP. 
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  agentgw              '"' SKIP. 
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetail.saletyp      '"' SKIP. 
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail2.detailcam   '"' SKIP. 
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail2.TYPE_notify '"' SKIP. 
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'  wdetail.gap          '"' SKIP. 
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'  wdetail.si           '"' SKIP.                     
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'  wdetail.re_year      '"' SKIP.                     
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'  wdetail.caryear      '"' SKIP.                     
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'  wdetail.model        '"' SKIP.
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'  wdetail.brand        '"' SKIP.
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'  wdetail.tiname       '"' SKIP.
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'  wdetail.insnam       '"' SKIP.
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'  wdetail.name2        '"' SKIP. 
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'  wdetail.name3        '"' SKIP.
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'  nw_icno              '"' SKIP.  /*a64-0328*/
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'  wdetail2.nv_insref   '"' SKIP.
            PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'  wdetail2.comment     '"' SKIP.
                                                                           
        END.                                                                                    
    END.                                                                            
    PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.                                                        
END.   /*pass > 0*/
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
"IMPORT TEXT FILE HCT " SKIP
"             Loaddat : " fi_loaddat    SKIP
"              Branch : " fi_branch     SKIP
"       Producer Code : " fi_producer01   SKIP
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 C-Win 
PROCEDURE proc_sic_exp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR pv_conpara AS CHAR INIT "".
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
 /*A66-0266*/
  FIND FIRST sicsyac.dbtable WHERE sicsyac.dbtable.phyname = "expiry"
      NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL sicsyac.dbtable THEN pv_conpara = sicsyac.dbtable.unixpara.
  ELSE pv_conpara = "". 
  pv_conpara = pv_conpara +    " -U " + gv_id + " -P " + nv_pwd.   
  /*A66-0266*/

  IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
       /*CONNECT expiry -H TMSTH -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.     /*HO*/ /*เปลี้ยนHost DataBase เป็น TMSTH*/*/
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.      /*HO*/ */
      /*CONNECT expiry -H devserver -S expiry  -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.  /*db test.*/  *//*A66-0266*/
       CONNECT VALUE(pv_conpara) NO-ERROR. /*A66-0266*/


     
      CLEAR FRAME nf00.
      HIDE FRAME nf00.

      RETURN. 
    
   END.

END.

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
DEF VAR nv_insnam     AS CHAR.

OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "005: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
ASSIGN 
    nv_msgstatus   = ""
    nn_vehreglist  = ""
    nn_namelist    = ""
    nn_namelist2   = "" 
    nv_chanolist   = "" 
    nv_idnolist    = "" 
    nv_insnam      = ""
    nv_CheckLog    = YES
    nn_vehreglist  = trim(wdetail.vehreg + nv_provi)  
    nv_chanolist   = trim(wdetail.chasno)  
    nv_idnolist    = trim(wdetail.icno)  
    nv_insnam      = trim(trim(wdetail.insnam) + " " + trim(wdetail.name3))    .
IF R-INDEX(nv_insnam," ") <> 0 THEN  
    ASSIGN
    nn_namelist    = trim(SUBSTR(nv_insnam,1,R-INDEX(nv_insnam," ")))
    nn_namelist2   = trim(SUBSTR(nv_insnam,R-INDEX(nv_insnam," "))).
ELSE ASSIGN
    nn_namelist    = TRIM(nv_insnam) 
    nn_namelist2   = "".

IF wdetail.vehreg <> "" THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp01    WHERE 
        sicuw.uzsusp.vehreg = nn_vehreglist    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wdetail2.comment = wdetail2.comment + "|รถผู้เอาประกัน ติด suspect ทะเบียน " + nn_vehreglist + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail2.pass    = "N"  
            WDETAIL2.OK_GEN  = "N".
    END.
END.
IF (nv_msgstatus = "") AND (nn_namelist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
        sicuw.uzsusp.fname = nn_namelist           AND 
        sicuw.uzsusp.lname = nn_namelist2          NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wdetail2.comment = wdetail2.comment + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail2.pass    = "N"  
            WDETAIL2.OK_GEN  = "N".
    END.
    ELSE DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = Trim(nn_namelist  + " " + nn_namelist2)        
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN 
                wdetail2.comment = wdetail2.comment + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                wdetail2.pass    = "N"  
                WDETAIL2.OK_GEN  = "N".
        END.
    END.
END.
IF (nv_msgstatus = "") AND (nv_chanolist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp05   WHERE 
        uzsusp.cha_no =  nv_chanolist         NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wdetail2.comment = wdetail2.comment + "|รถผู้เอาประกัน ติด suspect เลขตัวถัง " + nv_chanolist + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail2.pass    = "N"  
            WDETAIL2.OK_GEN  = "N".
    END.
END.
IF (nv_msgstatus = "") AND (nv_idnolist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp08    WHERE 
        sicuw.uzsusp.notes = nv_idnolist   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wdetail2.comment = wdetail2.comment + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail2.pass    = "N"  
            WDETAIL2.OK_GEN  = "N".
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
                wdetail2.comment = wdetail2.comment + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                wdetail2.pass    = "N"  
                WDETAIL2.OK_GEN  = "N".
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
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "0093: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
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
    nv_txt1  = wdetail.nmember 
    nv_txt2  = IF (INDEX(fi_no_mn30,wdetail2.comrequest) <> 0 ) AND (trim(wdetail2.TYPE_notify) = "N") THEN "NO-MN30 คุ้มครองภัยก่อการร้าย"   ELSE ""  /*A57-0282*/
    /* comment by : A67-0065
    nv_txt3  = ""
    nv_txt4  = ""
    nv_txt5  = "" */
    /* Add by : A67=0065 */
    nv_txt3  = IF wdetail2.producer = "B3M0071" THEN "**กรณีรถเสียหายโดยสิ้นเชิง**" ELSE "" 
    nv_txt4  = IF wdetail2.producer = "B3M0071" THEN "บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย) จำกัด จะชดใช้ค่าสินไหมให้ตามทุนประกันภัย" ELSE "" 
    nv_txt5  = IF wdetail2.producer = "B3M0071" THEN "กับบริษัท ฮอนด้าออโตโมบิล (ประเทศไทย) จำกัด โดยผู้เอาประกันภัยไม่ต้องโอนซากคืนให้กับบริษัทผู้รับประกันภัย " ELSE ""  . 
    /* end : A67-0065 */
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
     sic_bran.uwm100.policy  = wdetail.policyno  AND
     sic_bran.uwm100.rencnt  = n_rencnt      AND
     sic_bran.uwm100.endcnt  = n_endcnt      AND
     sic_bran.uwm100.bchyr   = nv_batchyr    AND
     sic_bran.uwm100.bchno   = nv_batchno    AND
     sic_bran.uwm100.bchcnt  = nv_batcnt     NO-ERROR NO-WAIT.
IF AVAILABLE uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        IF wuppertxt.txt <> "" THEN DO:  /*-- A58-0419 --*/
            CREATE sic_bran.uwd100.
            ASSIGN
                sic_bran.uwd100.bptr    = nv_bptr
                sic_bran.uwd100.fptr    = 0
                sic_bran.uwd100.policy  = wdetail.policyno
                sic_bran.uwd100.rencnt  = n_rencnt
                sic_bran.uwd100.endcnt  = n_endcnt
                sic_bran.uwd100.ltext   = wuppertxt.txt.
            IF nv_bptr <> 0 THEN DO:
                FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                wf_uwd100.fptr = RECID(uwd100).
            END.
            IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(uwd100).
            nv_bptr = RECID(uwd100).
        END.  /*-- A58-0419 --*/
    END.
END. /*uwm100*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 C-Win 
PROCEDURE proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose: Create by A58-0419    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd102 FOR sic_bran.uwd102.
DEF VAR nv_bptr      AS RECID.
OUTPUT TO D:\temp\LogTimeHCT.TXT APPEND.
PUT "0094: " TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)  SKIP.
OUTPUT CLOSE.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
IF wdetail2.ac_no       <> "" THEN  wdetail2.ac_no      = ",เลขที่บัญชี:"   + wdetail2.ac_no .   
IF wdetail2.ac_date     <> "" THEN  wdetail2.ac_date    = ",วันที่:"        + wdetail2.ac_date . 
IF wdetail2.ac_amount   <> "" THEN  wdetail2.ac_amount  = ",จำนวนเงิน:"     + wdetail2.ac_amount.
IF wdetail2.ac_pay      <> "" THEN  wdetail2.ac_pay     = ",ประเภทการจ่าย:" + wdetail2.ac_pay .  
IF wdetail2.ac_agent    <> "" THEN  wdetail2.ac_agent   = ",เลขที่ตัวแทน:"  + wdetail2.ac_agent .
IF wdetail.appenno      <> "" THEN  wdetail.appenno     = ",เลขที่รับแจ้ง:" + wdetail.appenno. 
IF wdetail.bysave       <> "" THEN  wdetail.bysave      = ",ชื่อผู้บันทึก:" + wdetail.bysave.
IF wdetail3.camp_no     <> "" THEN  wdetail3.camp_no    = "เลขที่แคมเปญ : " + wdetail3.camp_no.
ASSIGN 
    nv_fptr  = 0
    nv_bptr  = 0
    nv_line1 = 1
    nv_fptr  = sic_bran.uwm100.fptr02
    nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    nv_txt5  = ""  
    nv_txt1  = wdetail.nmember  + wdetail2.ac_no  + wdetail2.ac_date + wdetail2.ac_amount + wdetail2.ac_pay  + wdetail2.ac_agent +  
               wdetail.appenno + wdetail.bysave 
    nv_txt2  = wdetail3.camp_no
    /* nv_txt3  = "" */ /*A61-0324*/
    nv_txt3  = IF nv_polmaster <> ""  THEN "Policy Master: " + nv_polmaster ELSE ""  /*a61-0324*/
    nv_txt4  = ""
    nv_txt5  = "" . 
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
     sic_bran.uwm100.policy  = wdetail.policyno  AND
     sic_bran.uwm100.rencnt  = n_rencnt      AND
     sic_bran.uwm100.endcnt  = n_endcnt      AND
     sic_bran.uwm100.bchyr   = nv_batchyr    AND
     sic_bran.uwm100.bchno   = nv_batchno    AND
     sic_bran.uwm100.bchcnt  = nv_batcnt     NO-ERROR NO-WAIT.
IF AVAILABLE uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        IF wuppertxt.txt <> "" THEN DO:
            CREATE sic_bran.uwd102.
            ASSIGN
                sic_bran.uwd102.bptr    = nv_bptr
                sic_bran.uwd102.fptr    = 0
                sic_bran.uwd102.policy  = sic_bran.uwm100.policy  
                sic_bran.uwd102.rencnt  = sic_bran.uwm100.rencnt  
                sic_bran.uwd102.endcnt  = sic_bran.uwm100.endcnt  
                sic_bran.uwd102.ltext   = wuppertxt.txt.
            IF nv_bptr <> 0 THEN DO:
                FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr.
                wf_uwd102.fptr = RECID(sic_bran.uwd102).
            END.
            IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(uwd102).
            nv_bptr = RECID(sic_bran.uwd102).
        END.
    END.
    sic_bran.uwm100.bptr02 = nv_bptr.
END. /*uwm100*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd105 C-Win 
PROCEDURE proc_uwd105 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd105 FOR sic_bran.uwd105.
DEF VAR nv_bptr      AS RECID.
DEF VAR nv_fptr      AS RECID.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
IF trim(wdetail2.producer) = "B3M0070" AND (wdetail.covcod = "2.1" OR wdetail.covcod = "2.2" OR wdetail.covcod = "3.1" OR wdetail.covcod = "3.2") THEN DO: 
    ASSIGN 
        nv_bptr  = 0
        nv_line1 = 1 .
 
   CREATE wuppertxt.
   ASSIGN 
       wuppertxt.line = 1
       wuppertxt.txt  = "MT002_FL".
  
    FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
         sic_bran.uwm100.policy  = wdetail.policyno  AND
         sic_bran.uwm100.rencnt  = n_rencnt      AND
         sic_bran.uwm100.endcnt  = n_endcnt      AND
         sic_bran.uwm100.bchyr   = nv_batchyr    AND
         sic_bran.uwm100.bchno   = nv_batchno    AND
         sic_bran.uwm100.bchcnt  = nv_batcnt     NO-ERROR NO-WAIT.
    IF AVAILABLE uwm100 THEN DO:
        FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
            IF wuppertxt.txt <> "" THEN DO:  
                CREATE sic_bran.uwd105.
                ASSIGN
                    sic_bran.uwd105.bptr    = nv_bptr
                    sic_bran.uwd105.fptr    = 0 
                    sic_bran.uwd105.policy  = wdetail.policyno
                    sic_bran.uwd105.rencnt  = n_rencnt
                    sic_bran.uwd105.endcnt  = n_endcnt
                    sic_bran.uwd105.clause  = wuppertxt.txt.
                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd105 WHERE RECID(wf_uwd105) = nv_bptr.
                    wf_uwd105.fptr = RECID(uwd105).
                END.
                IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr03 = RECID(uwd105).
                nv_bptr = RECID(uwd105).
            END.  /*-- A58-0419 --*/
        END.
        RELEASE sic_bran.uwd105.
        sic_bran.uwm100.bptr03 = nv_bptr.
    END. /*uwm100*/
    RELEASE sic_bran.uwd105.
END.

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

