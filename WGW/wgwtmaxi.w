&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_bran         PROGRESS
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases 
sic_test         PROGRESS  */
File: 
Description: 
Input Parameters:
<none>
Output Parameters:
<none>
Author: 
Created: 
------------------------------------------------------------------------*/
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
/*programid  : wgwtmaxi.w                                               */  
/*programname: Load Text & Generate Maxi              */                
/*Copyright  : Safety Insurance Public Company Limited                  */  
/*                         บริษัท ประกันคุ้มภัย จำกัด (มหาชน)           */  
/*create by  : Kridtiya i. A58-0321  date. 25/08/2015                   
               ปรับโปรแกรมให้สามารถนำเข้า Load Text & Generate Maxi     */  
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/************************************************************************/

/* DEF VAR n_firstdat AS CHAR FORMAT "x(10)"  INIT "". */
/* DEF VAR n_brand    AS CHAR FORMAT "x(50)"  INIT "". */
DEF VAR n_model    AS CHAR FORMAT "x(50)"  INIT "".  
/* DEF VAR n_index    AS INTE  INIT 0.                 */
DEF VAR stklen     AS INTE.
DEF VAR dod0       AS DECI.
DEF VAR dod1       AS DECI.
DEF VAR dod2       AS DECI.
DEF VAR dpd0       AS DECI.
DEF VAR nv_com1p        AS DECI INIT 0.00 .
DEF VAR n_ratmin  AS INTE INIT 0.
DEF VAR n_ratmax  AS INTE INIT 0.
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno. 
DEFINE STREAM  ns1. 
DEFINE STREAM  ns2.
DEFINE STREAM  ns3.
DEF VAR nv_uom1_v AS INTE INIT 0. 
DEF VAR nv_uom2_v AS INTE INIT 0. 
DEF VAR nv_uom5_v AS INTE INIT 0. 
DEF VAR chkred    AS logi INIT NO.
DEF SHARED Var   n_User    As CHAR .
DEF SHARED Var   n_PassWd  As CHAR .    
DEF VAR nv_comper  AS DECI INIT 0.                
DEF VAR nv_comacc  AS DECI INIT 0.                
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
DEF New  SHARED VAR nv_412      AS INTEGER      FORMAT ">>>,>>>,>>9".
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
DEF NEW  SHARED VAR   nv_tariff     LIKE sicuw.uwm301.tariff.
DEF NEW  SHARED VAR   nv_comdat     LIKE sicuw.uwm100.comdat.
DEF NEW  SHARED VAR   nv_covcod     AS CHAR   FORMAT "X(3)". 
DEF NEW  SHARED VAR   nv_class      AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_key_b      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEF NEW  SHARED VAR   nv_drivno     AS INT       .
DEF NEW  SHARED VAR   nv_drivcod    AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_drivprm    AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_drivvar1   AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_drivvar2   AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_drivvar    AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_usecod     AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_useprm     AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_usevar1    AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_usevar2    AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_usevar     AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_sicod    AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_siprm    AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_sivar1   AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_sivar2   AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_sivar    AS CHAR  FORMAT "X(60)".
def New  shared var   nv_uom6_c   as  char.      /* Sum  si*/
def New  shared var   nv_uom7_c   as  char.      /* Fire/Theft*/
DEF NEW  SHARED VAR   nv_bipcod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_bipprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_bipvar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_bipvar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_bipvar   AS CHAR  FORMAT "X(60)".
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
DEF VAR  NO_CLASS  AS CHAR INIT "".
DEF VAR  no_tariff AS CHAR INIT "".
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

/* DEF VAR nv_lnumber AS   INTE INIT 0.                                         */
/* DEF VAR nv_provi   AS   CHAR INIT "".                                        */
DEF VAR n_rencnt   LIKE sicuw.uwm100.rencnt INITIAL "".                     
/* def var nv_index   as   int  init  0.                                        */
DEF VAR n_endcnt   LIKE sicuw.uwm100.endcnt INITIAL "".                      
/* def var n_comdat   LIKE sicuw.uwm100.comdat  NO-UNDO.                        */
/* def var n_policy   LIKE sicuw.uwm100.policy  INITIAL "" .                    */
DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.  
DEF VAR nv_reccnt   AS  INT  INIT  0.                                       
DEF VAR nv_completecnt    AS   INT   INIT  0.                               

DEF NEW SHARED VAR chr_sticker  AS CHAR FORMAT "9999999999999" INIT "". 
def NEW SHARED var nv_modulo    as int  format "9".
def var s_riskgp    AS INTE FORMAT ">9".
def var s_riskno    AS INTE FORMAT "999".
def var s_itemno    AS INTE FORMAT "999". 
DEF VAR nv_drivage1 AS INTE INIT 0.  
DEF VAR nv_drivage2 AS INTE INIT 0.  
DEF VAR nv_drivbir1 AS CHAR INIT "". 
DEF VAR nv_drivbir2 AS CHAR INIT "". 
def var nv_dept     as char format  "X(1)".
def NEW SHARED var  nv_branch  AS CHAR FORMAT "x(3)" .  
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
DEF VAR nv_nptr     AS RECID.
DEF VAR nv_gap2     AS DECIMAL                          NO-UNDO.
DEF VAR nv_prem2    AS DECIMAL                          NO-UNDO.
DEF VAR nv_rstp     AS DECIMAL                          NO-UNDO.
DEF VAR nv_rtax     AS DECIMAL                          NO-UNDO.
DEF VAR nv_key_a    AS DECIMAL INITIAL 0                NO-UNDO.
DEF VAR nv_rec100   AS RECID .
DEF VAR nv_rec120   AS RECID .
DEF VAR nv_rec130   AS RECID .
DEF VAR nv_rec301   AS RECID .
{wgw\wgwtmaxi.i}      /*ประกาศตัวแปร*/
DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
/* DEF  VAR n_taxae    AS LOGICAL .                             */
/* DEF  VAR n_stmpae   AS LOGICAL .                             */
/* DEF  VAR n_com2ae   AS LOGICAL .                             */
/* DEF  VAR n_com1ae   AS LOGICAL .                             */
/* DEF  VAR nv_fi_com2_t    AS DECI INIT 0.00.                  */
/* DEF  VAR nv_fi_rstp_t    AS INTE INIT 0.                     */
/* DEF  VAR nv_fi_rtax_t    AS DECI INIT 0.00 .                 */
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".       
DEF VAR nv_uwm301trareg    LIKE sicuw.uwm301.cha_no INIT "". 
/* DEFINE VAR n_sclass72     AS CHAR FORMAT "x(4)".             */
DEF  VAR gv_id            AS CHAR FORMAT "X(15)" NO-UNDO.    
DEF  VAR nv_pwd           AS CHAR FORMAT "X(15)" NO-UNDO.    
/* DEF  VAR nn_access        AS CHAR FORMAT "x(100)" INIT "".   */
/*                                                              */

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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.policy wdetail.n_branch wdetail.comdat wdetail.expdat wdetail.covcod wdetail.garage wdetail.inserf wdetail.tiname wdetail.insnam wdetail.n_addr1 wdetail.n_addr2 wdetail.n_addr3 wdetail.n_addr4   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y"
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail WHERE wdetail.pass = "y".
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_typerequest fi_loaddat fi_branch ~
fi_producer fi_bchno fi_agent fi_vatcod fi_prevbat fi_bchyr fi_filename ~
bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit ~
br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent fi_process RECT-370 RECT-372 ~
RECT-373 RECT-374 RECT-375 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS ra_typerequest fi_loaddat fi_branch ~
fi_producer fi_bchno fi_agent fi_vatcod fi_prevbat fi_bchyr fi_filename ~
fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_proname ~
fi_agtname fi_impcnt fi_process fi_completecnt fi_premtot fi_premsuc 

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
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10 BY 1
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
     SIZE 3.5 BY .95.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 42 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
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

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 22.67 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY .95
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vatcod AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE ra_typerequest AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match File Text", 1,
"Load Text File ", 2,
"Match File Policy ", 3
     SIZE 60 BY 1
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 13.76
     BGCOLOR 18 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 5.19
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 3.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-375
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 130 BY 2.76
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 13 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 13 BY 1.67
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.policy        COLUMN-LABEL "Policy No."
      wdetail.n_branch      COLUMN-LABEL "branch"  
      wdetail.comdat        COLUMN-LABEL "comdate."   
      wdetail.expdat        COLUMN-LABEL "expidate." 
      wdetail.covcod        COLUMN-LABEL "covcod  "
      wdetail.garage        COLUMN-LABEL "garage  "
      wdetail.inserf        COLUMN-LABEL "Insd."
      wdetail.tiname        COLUMN-LABEL "tiname  "
      wdetail.insnam        COLUMN-LABEL "insnam  "
      wdetail.n_addr1       COLUMN-LABEL "addr1 "  
      wdetail.n_addr2       COLUMN-LABEL "addr2 "  
      wdetail.n_addr3       COLUMN-LABEL "addr3 "   
      wdetail.n_addr4       COLUMN-LABEL "addr4 "
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 4.52
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_typerequest AT ROW 8.14 COL 26.17 NO-LABEL
     fi_loaddat AT ROW 2.81 COL 24 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.91 COL 24 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.95 COL 24 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.71 COL 15 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agent AT ROW 6 COL 24 COLON-ALIGNED NO-LABEL
     fi_vatcod AT ROW 7.05 COL 24 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 7.05 COL 61.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 7.05 COL 97.17 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.24 COL 24 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9.29 COL 86.67
     fi_output1 AT ROW 10.24 COL 24 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.24 COL 24 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.24 COL 24 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 13.24 COL 24 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 13.24 COL 63.17 NO-LABEL
     buok AT ROW 9.86 COL 96.83
     bu_exit AT ROW 11.71 COL 97
     fi_brndes AT ROW 3.91 COL 33.83 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 16.91 COL 2.17
     bu_hpbrn AT ROW 3.91 COL 32
     bu_hpacno1 AT ROW 4.95 COL 43.5
     bu_hpagent AT ROW 6 COL 43.5
     fi_proname AT ROW 4.95 COL 46 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6 COL 46 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 22.38 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 14.24 COL 24 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.43 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.38 COL 97 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.43 COL 95 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     "                     Branch :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 3.91 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 7.05 COL 97.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY .91 AT ROW 22.38 COL 94.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "          Producer Code :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 4.95 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Previous Batch No.:" VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 7.05 COL 43.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 23.43 COL 57.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 23.43 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 13.24 COL 82.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "LOAD TEXT FILE MAXI [BU2]" VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.33 COL 2.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY .91 AT ROW 23.43 COL 94.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 22.71 COL 5.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 22.38 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "              Agent Code  :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 6 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.95
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "                  Vat code  :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 7.05 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 25 BY .91 AT ROW 13.24 COL 61.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 11.24 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "                 Load Date :":35 VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 2.81 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 22.38 COL 57.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 12.24 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 10.24 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "     Policy Import Total :":60 VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 13.24 COL 24 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 9.24 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.67 COL 1
     RECT-373 AT ROW 16.48 COL 1
     RECT-374 AT ROW 21.71 COL 1
     RECT-375 AT ROW 21.95 COL 2
     RECT-377 AT ROW 9.52 COL 95.17
     RECT-378 AT ROW 11.38 COL 95.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.95
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
         TITLE              = "LOAD TEXT FILE MAXI [BU2]"
         HEIGHT             = 23.95
         WIDTH              = 133
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
          SIZE 12 BY .95 AT ROW 7.05 COL 97.67 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "     Policy Import Total :"
          SIZE 22.5 BY .91 AT ROW 13.24 COL 24 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 25 BY .91 AT ROW 13.24 COL 61.83 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY .91 AT ROW 22.38 COL 57.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY .91 AT ROW 22.38 COL 94.67 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY .91 AT ROW 23.43 COL 57.67 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY .91 AT ROW 23.43 COL 94.83 RIGHT-ALIGNED        */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_query FOR EACH wdetail WHERE wdetail.pass = "y".
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* LOAD TEXT FILE MAXI [BU2] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* LOAD TEXT FILE MAXI [BU2] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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
        wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.n_branch:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.comdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.expdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.covcod:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.garage:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.inserf:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.tiname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.insnam:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.n_addr1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.n_addr2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.n_addr3:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.n_addr4:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        
        wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.n_branch:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.comdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.expdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.covcod:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.garage:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.inserf:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.tiname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.insnam:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.n_addr1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.n_addr2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.n_addr3:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.n_addr4:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  



    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    IF       ra_typerequest = 1 THEN DO:
        IF fi_filename = ""  THEN DO:
            MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
            APPLY "Entry" TO fi_filename.
            RETURN NO-APPLY.
        END.
        IF fi_output1 = "" THEN DO:
            MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
            APPLY "Entry" TO fi_output1.
            RETURN NO-APPLY.
        END.
        RUN proc_matfileLoad.
    END.
    ELSE IF  ra_typerequest = 3 THEN DO:
        IF fi_filename = ""  THEN DO:
            MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
            APPLY "Entry" TO fi_filename.
            RETURN NO-APPLY.
        END.
        IF fi_output1 = "" THEN DO:
            MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
            APPLY "Entry" TO fi_output1.
            RETURN NO-APPLY.
        END.
        RUN proc_matfilePol.
    END.
    ELSE DO:
        ASSIGN
            nv_batprev             = INPUT fi_prevbat
            fi_process             = "LOAD TEXT FILE MAXI [BU2]"
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2
            fi_completecnt         = 0
            fi_premsuc             = 0
            fi_bchno               = ""
            fi_premtot             = 0
            fi_impcnt              = 0.
        DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
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
            FIND LAST uzm700 USE-INDEX uzm70001    WHERE 
                uzm700.bchyr   = nv_batchyr        AND
                uzm700.branch  = TRIM(nv_batbrn)   AND
                uzm700.acno    = TRIM(fi_producer) NO-LOCK NO-ERROR .
            IF AVAIL uzm700 THEN DO:  
                ASSIGN nv_batrunno = uzm700.runno.
                FIND LAST uzm701 USE-INDEX uzm70102 WHERE
                    uzm701.bchyr  = nv_batchyr        AND
                    uzm701.bchno  = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") NO-LOCK NO-ERROR.
                IF AVAIL uzm701 THEN DO:
                    nv_batcnt   = uzm701.bchcnt .
                    nv_batrunno = nv_batrunno + 1.
                END.
            END.
            ELSE DO:  
                ASSIGN
                    nv_batcnt   = 1
                    nv_batrunno = 1.
            END.
            nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
        END.
        ELSE DO:  
            nv_batprev = INPUT fi_prevbat.
            FIND LAST uzm701 USE-INDEX uzm70102 WHERE
                uzm701.bchyr   = nv_batchyr        AND
                uzm701.bchno   = CAPS(nv_batprev)  NO-LOCK NO-ERROR NO-WAIT.
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
        RUN proc_assign. 
        FOR EACH wdetail :
            IF wdetail.poltyp   = "V70"  OR wdetail.poltyp   = "V72"  THEN DO:
                ASSIGN nv_reccnt   =  nv_reccnt   + 1
                    nv_netprm_t    =  nv_netprm_t + decimal(wdetail.prem_r)
                    wdetail.pass   = "Y". 
            END.
            ELSE DELETE WDETAIL.
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
                               INPUT            "WGWTLBU2" ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                               INPUT            nv_imppol  ,     /* INT   */
                               INPUT            nv_impprem ).
        ASSIGN fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
        DISP  fi_bchno   WITH FRAME fr_main.
        RUN proc_chktest1. 
        FOR EACH wdetail  NO-LOCK.
            IF wdetail.pass = "y" THEN
                ASSIGN nv_completecnt = nv_completecnt + 1
                nv_netprm_s    = nv_netprm_s    + decimal(wdetail.prem_r). 
            ELSE nv_batflg = NO.
        END.
        nv_rectot = nv_reccnt.      
        nv_recsuc = nv_completecnt. 
        IF  nv_netprm_t <> nv_netprm_s THEN nv_batflg = NO.
        ELSE nv_batflg = YES.
        IF nv_rectot <> nv_recsuc   THEN nv_batflg = NO.
        FIND LAST uzm701 USE-INDEX uzm70102 WHERE
            uzm701.bchyr   = nv_batchyr     AND
            uzm701.bchno   = nv_batchno     AND
            uzm701.bchcnt  = nv_batcnt      NO-ERROR.
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
                fi_premsuc    :FGCOLOR = 6 
                fi_bchno      :FGCOLOR = 6. 
            DISP fi_completecnt fi_premsuc WITH FRAME fr_main.
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
        END.
        RUN   proc_open.    
        DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
        RUN proc_report1 .   
        RUN PROC_REPORT2 .
        RUN proc_screen  .   
        RELEASE uzm700.
        RELEASE uzm701.
        RELEASE sic_bran.uwm100.
        RELEASE sic_bran.uwm120.
        RELEASE sic_bran.uwm130.
        RELEASE sic_bran.uwm301.
        RELEASE brstat.detaitem.
        RELEASE sicsyac.xzm056.
        RELEASE sicsyac.xmm600.
        IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    END.
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
       
       FILTERS    /* "Text Documents" "*.csv"*/
       "CSV (Comma Delimited)"   "*.csv"   /*,
                            "Data Files (*.dat)"     "*.dat",
                    "Text Files (*.txt)" "*.txt"*/
                    
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        IF ra_typerequest = 1  THEN DO: /*match file */
            no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
            ASSIGN
                fi_filename  = cvData
                fi_output1   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + no_add + "mat.csv" /*.csv*/
                fi_output2 = ""
                fi_output3 = "".
        END.
        ELSE IF ra_typerequest = 2 THEN DO:
            ASSIGN 
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

         
         ASSIGN
            fi_filename  = cvData
            fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
            fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
            fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
        END.
        ELSE DO:
            ASSIGN 
            no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
            ASSIGN
                fi_filename  = cvData
                fi_output1   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + no_add + "matpol.csv" /*.csv*/
                fi_output2 = ""
                fi_output3 = "".
        END.
        DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
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


&Scoped-define SELF-NAME bu_hpagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent c-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn c-Win
ON CHOOSE OF bu_hpbrn IN FRAME fr_main
DO:
    Run  whp\whpbrn01(Input-output  fi_branch,   
                      Input-output  fi_brndes).
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
    IF fi_agent <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_agent  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600.."  View-as alert-box.
            Apply "Entry" To  fi_agent.
            RETURN NO-APPLY.  
        END.
        ELSE   
            ASSIGN  
                fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_agent   =  caps(INPUT  fi_agent) .   
    END.
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
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
    fi_branch = caps(INPUT fi_branch) .
    IF  Input fi_branch  =  ""  Then do:
        Message "กรุณาระบุ Branch Code ." View-as alert-box.
        Apply "Entry"  To  fi_branch.
    END.
    Else do:
        FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
            sicsyac.xmm023.branch   = TRIM(Input fi_branch)  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
            Message  "Not on Description Master File xmm023" View-as alert-box.
            Apply "Entry"  To  fi_branch.
            RETURN NO-APPLY.
        END.
        ELSE 
            ASSIGN fi_branch  =  CAPS(Input fi_branch) 
            fi_brndes  =  sicsyac.xmm023.bdes.
    END.    /*else do:*/
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


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat c-Win
ON LEAVE OF fi_prevbat IN FRAME fr_main
DO:
    fi_prevbat = caps(INPUT fi_prevbat).
    nv_batprev = fi_prevbat.
    IF nv_batprev <> " "  THEN DO:
        IF LENGTH(nv_batprev) > 16 THEN DO:
            MESSAGE "Length Of Batch no. Must Be 16 Character " SKIP
                    "Please Check Batch No. Again             " view-as alert-box.
            APPLY "entry" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
    END.     /*nv_batprev <> " "*/
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
        FIND sicsyac.xmm600 USE-INDEX xmm60001          WHERE
            sicsyac.xmm600.acno  =  Input fi_producer   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producer.
            RETURN NO-APPLY.    /*note add on 10/11/2005*/
        END.
        ELSE 
            ASSIGN
                fi_proname  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  caps(INPUT  fi_producer)   .
    END.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
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


&Scoped-define SELF-NAME fi_vatcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcod c-Win
ON LEAVE OF fi_vatcod IN FRAME fr_main
DO:
    fi_vatcod = INPUT fi_vatcod.
    IF fi_vatcod <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001       WHERE
            sicsyac.xmm600.acno  =  Input fi_vatcod  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" View-as alert-box.
            Apply "Entry" To  fi_vatcod.
            RETURN NO-APPLY.  
        END.
        ELSE  
            ASSIGN fi_vatcod   =  caps(INPUT  fi_vatcod). 
    END. 
    Disp  fi_vatcod   WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typerequest
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typerequest c-Win
ON VALUE-CHANGED OF ra_typerequest IN FRAME fr_main
DO:
    ra_typerequest  = INPUT ra_typerequest .
    DISP ra_typerequest  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(10)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)"  NO-UNDO.
  ASSIGN 
      gv_prgid   = "wgwtmaxi.w"
      gv_prog    = "LOAD TEXT FILE MAXI [BU2]"
      fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). 
  ASSIGN
      fi_branch      = "W" 
      fi_vatcod      = ""
      fi_producer    = "B3W0037"
      fi_agent       = "B3W0037"
      ra_typerequest = 1
      fi_bchyr       = YEAR(TODAY)
      fi_process     = "LOAD TEXT FILE MAXI [BU2]".
  DISP ra_typerequest  fi_process  fi_branch fi_vatcod  fi_producer fi_agent fi_bchyr WITH FRAME fr_main.
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  DISPLAY ra_typerequest fi_loaddat fi_branch fi_producer fi_bchno fi_agent 
          fi_vatcod fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 
          fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname 
          fi_impcnt fi_process fi_completecnt fi_premtot fi_premsuc 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE ra_typerequest fi_loaddat fi_branch fi_producer fi_bchno fi_agent 
         fi_vatcod fi_prevbat fi_bchyr fi_filename bu_file fi_output1 
         fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit br_wdetail 
         bu_hpbrn bu_hpacno1 bu_hpagent fi_process RECT-370 RECT-372 RECT-373 
         RECT-374 RECT-375 RECT-377 RECT-378 
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
DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER . 
/************** v72 comp y **********/
ASSIGN wdetail.PASS = "Y"
    wdetail.tariff  = "9"
    wdetail.compul  = "y" 
    fi_process      = "Process data Siam Carrent Group....compulsary "   
    nv_siredbook    = 0
    nv_class72rd    = ""
    nv_siredbook    = IF (wdetail.si = "" ) AND (wdetail.fi <> "" ) THEN DECI(wdetail.fi)  ELSE DECI(wdetail.si).

DISP fi_process WITH FRAM fr_main.
IF wdetail.vehreg = "" THEN wdetail.vehreg = IF SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8) <> "" THEN
                                                "/" +   SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8 ) 
                                             ELSE "".
IF wdetail.compul <> "y" THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
    wdetail.pass    = "N"
    wdetail.OK_GEN  = "N". 
IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk <> "" THEN DO:    
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
            wdetail.pass    = ""
            wdetail.OK_GEN  = "N".
    END.
END.
IF wdetail.icno <> ""  THEN DO:
    IF LENGTH(TRIM(wdetail.icno)) = 13 THEN DO:
        DO WHILE nv_seq <= 12:
            nv_sum = nv_sum + INTEGER(SUBSTR(TRIM(wdetail.icno),nv_seq,1)) * (14 - nv_seq).
            nv_seq = nv_seq + 1.
        END.
        nv_checkdigit = 11 - nv_sum MODULO 11.
        IF nv_checkdigit >= 10 THEN nv_checkdigit = nv_checkdigit - 10.
        IF STRING(nv_checkdigit) <> SUBSTR(TRIM(wdetail.icno),13,1) THEN  
            ASSIGN  
            wdetail.icno = ""
            wdetail.comment = wdetail.comment + "| WARNING: พบเลขบัตรประชาชนไม่ถูกต้อง"
            wdetail.pass    = "N"  
            WDETAIL.OK_GEN  = "N".
    END.
    /*ELSE ASSIGN  
            wdetail.comment = wdetail.comment + "| WARNING: พบเลขบัตรประชาชนไม่ถูกต้องไม่เท่ากับ 13 หลัก " + wdetail.icno
            wdetail.icno = "" 
            wdetail.pass    = "n"  
            WDETAIL.OK_GEN  = "N".*/
END.
IF wdetail.n_branch = "" THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| สาขาเป็นค่าว่างกรูณาใส่สาขาอผู้เอาประกัน"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF index("123456789",substr(wdetail.policy,1,1)) <> 0  THEN DO:
    IF wdetail.n_branch <> (substr(wdetail.policy,1,2)) THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| สาขาไม่ตรงกับสาขากรมธรรม์"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
END.
ELSE DO:  
    IF wdetail.n_branch <> (substr(wdetail.policy,2,1)) THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| สาขาไม่ตรงกับสาขากรมธรรม์"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
END.
IF LENGTH(TRIM(wdetail.policy)) <> 12  THEN
    ASSIGN wdetail.comment = wdetail.comment + "| เลขกรมธรรม์ต้องมีจำนวน 12 ตัวเท่านั้น"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail.class  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
    wdetail.pass    = "N"
    wdetail.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101     WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp  AND
        sicsyac.xmd031.class  = wdetail.class   NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN 
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
            wdetail.OK_GEN  = "N".
END. 
/*---------- covcod ----------*/
wdetail.covcod = CAPS(wdetail.covcod).
FIND sicsyac.sym100 USE-INDEX sym10001     WHERE
    sicsyac.sym100.tabcod = "U013"         AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN wdetail.pass = "N"
    wdetail.comment     = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
    wdetail.OK_GEN      = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = "110" AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
    wdetail.OK_GEN = "N".
/*--------- modcod --------------*/
IF INDEX(wdetail.class,".") <> 0 THEN ASSIGN wdetail.class = REPLACE(wdetail.class,".","").
IF      SUBSTR(wdetail.class,2,3) = "110" THEN  ASSIGN nv_class72rd = "110" wdetail.class = "110"  .
ELSE IF SUBSTR(wdetail.class,2,3) = "120" THEN  ASSIGN nv_class72rd = "210" wdetail.class = "210"  .
ELSE IF SUBSTR(wdetail.class,2,3) = "210" THEN  ASSIGN nv_class72rd = "120" wdetail.class = "120"  .
ELSE IF SUBSTR(wdetail.class,2,3) = "220" THEN  ASSIGN nv_class72rd = "220" wdetail.class = "220"  .
ELSE IF SUBSTR(wdetail.class,2,3) = "320" THEN  ASSIGN nv_class72rd = "320" wdetail.class = "320"  .
ELSE IF SUBSTR(wdetail.class,2,3) = "140" THEN  ASSIGN nv_class72rd = "320" wdetail.class = "320"  .
ELSE IF SUBSTR(wdetail.class,2,3) = "240" THEN  ASSIGN nv_class72rd = "320" wdetail.class = "320"   .
ELSE  ASSIGN nv_class72rd = SUBSTR(wdetail.class,1,3) .  
FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  wdetail.class   NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN 
    nv_simat  = makdes31.si_theft_p   
    nv_simat1 = makdes31.load_p   .    
ELSE ASSIGN  
    nv_simat  = 20
    nv_simat1 = 20.
IF wdetail.prepol = "" THEN DO:
    IF wdetail.redbook <> "" THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab01    Where
            stat.maktab_fil.sclass   =  nv_class72rd     AND
            stat.maktab_fil.modcod   =  wdetail.redbook  No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod
           /* wdetail.brand    =  IF wdetail.brand = "" THEN stat.maktab_fil.makdes  ELSE wdetail.brand
            wdetail.model    =  IF wdetail.model = "" THEN stat.maktab_fil.moddes  ELSE wdetail.model*/
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  IF wdetail.body = "" THEN  stat.maktab_fil.body ELSE wdetail.body   
            wdetail.Tonn     =  IF wdetail.Tonn = 0  THEN  stat.maktab_fil.tons ELSE wdetail.Tonn
            wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
    END.
    IF wdetail.redbook = "" THEN DO:
        
    IF wdetail.seat = "" THEN DO:
        IF wdetail.engcc = "" THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0              And
                stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
                stat.maktab_fil.sclass   =  nv_class72rd                      AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN
                ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                /*wdetail.body     =  stat.maktab_fil.body */  /*A57-0426*/
                wdetail.body     =  IF wdetail.body = "" THEN  stat.maktab_fil.body ELSE wdetail.body  /*A57-0426*/
                wdetail.Tonn     =  IF wdetail.Tonn = 0 THEN stat.maktab_fil.tons ELSE wdetail.Tonn
                wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
                                    ELSE wdetail.redbook  = "".
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
            index(stat.maktab_fil.moddes,wdetail.model) <> 0              And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
            stat.maktab_fil.sclass   =  nv_class72rd                      AND
           (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
            stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            /*wdetail.body     =  stat.maktab_fil.body */  /*A57-0426*/
            wdetail.body     =  IF wdetail.body = "" THEN  stat.maktab_fil.body ELSE wdetail.body  /*A57-0426*/
            wdetail.Tonn     =  IF wdetail.Tonn = 0 THEN stat.maktab_fil.tons ELSE wdetail.Tonn
            wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
                                ELSE wdetail.redbook  = "".
        END.
    END.
    ELSE DO:
        IF wdetail.engcc = ""  THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0              And
                stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
                stat.maktab_fil.sclass   =  nv_class72rd                      AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  AND  
                stat.maktab_fil.seats    >=    DECI(wdetail.seat)       No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN
                ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                /*wdetail.body   =  stat.maktab_fil.body */  /*A57-0426*/
                wdetail.body     =  IF wdetail.body = "" THEN  stat.maktab_fil.body ELSE wdetail.body  /*A57-0426*/
                wdetail.Tonn     =  IF wdetail.Tonn = 0 THEN stat.maktab_fil.tons ELSE wdetail.Tonn
                wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
                                    ELSE wdetail.redbook  = "".
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0              And
                stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
                stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
                stat.maktab_fil.sclass   =  nv_class72rd                      AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  AND  
                stat.maktab_fil.seats    >=    DECI(wdetail.seat)       No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN
                ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                /*wdetail.body   =  stat.maktab_fil.body */  /*A57-0426*/
                wdetail.body     =  IF wdetail.body = "" THEN  stat.maktab_fil.body ELSE wdetail.body  /*A57-0426*/
                wdetail.Tonn     =  IF wdetail.Tonn = 0 THEN stat.maktab_fil.tons ELSE wdetail.Tonn
                wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
                                    ELSE wdetail.redbook  = "".
        END.
    END.
    END. /*wdetail.redbook = ""*/
END. /*wdetail.prepol = "" */
/*Find First stat.maktab_fil USE-INDEX maktab04    Where
    stat.maktab_fil.makdes   =     wdetail.brand            And                  
    index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
    stat.maktab_fil.sclass   =     wdetail.class            AND
    stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
If  avail stat.maktab_fil  Then  ASSIGN wdetail.redbook = stat.maktab_fil.modcod.
ELSE wdetail.redbook = "".*/
IF wdetail.redbook = ""  THEN DO:
    FIND LAST sicsyac.xmm102   WHERE 
        index(sicsyac.xmm102.modest,wdetail.brand) <> 0  NO-LOCK NO-ERROR.  
    IF AVAIL sicsyac.xmm102 THEN 
        ASSIGN 
        wdetail.redbook = sicsyac.xmm102.modcod 
        /*wdetail.body    = sicsyac.xmm102.body *//*A57-0426*/
        wdetail.body    = IF wdetail.body = "" THEN sicsyac.xmm102.body ELSE wdetail.body  /*A57-0426*/
        wdetail.tonn    = sicsyac.xmm102.tons  
        wdetail.engcc   = string(sicsyac.xmm102.engine)
        wdetail.seat    = STRING(sicsyac.xmm102.seats)
        wdetail.cargrp  = sicsyac.xmm102.vehgrp 
        wdetail.redbook = sicsyac.xmm102.modcod.
    ELSE wdetail.redbook = "" .                                            
    IF wdetail.redbook = ""  THEN DO:
        FIND LAST sicsyac.xmm102 WHERE sicsyac.xmm102.modest = wdetail.brand  NO-LOCK NO-ERROR.
        IF NOT AVAIL sicsyac.xmm102  THEN
            ASSIGN wdetail.pass = "N"  
            wdetail.comment = wdetail.comment + "| not find on table xmm102"
            wdetail.OK_GEN  = "N".
        ELSE  
            ASSIGN 
                wdetail.redbook = sicsyac.xmm102.modcod 
                /*wdetail.body    = sicsyac.xmm102.body *//*A57-0426*/
                wdetail.body    = IF wdetail.body = "" THEN sicsyac.xmm102.body ELSE wdetail.body  /*A57-0426*/
                wdetail.tonn    = sicsyac.xmm102.tons  
                wdetail.engcc   = string(sicsyac.xmm102.engine)
                wdetail.seat    = STRING(sicsyac.xmm102.seats)
                wdetail.cargrp  = sicsyac.xmm102.vehgrp 
                wdetail.redbook = sicsyac.xmm102.modcod.
    END.
END.
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"     AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
    wdetail.OK_GEN  = "N".
ASSIGN
    nv_docno  = " "
    nv_accdat = TODAY.
/***--- Docno ---***/
IF wdetail.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M" AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999") NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN 
        ASSIGN /*a490166*/     
        wdetail.pass    = "N"  
        wdetail.comment = "Receipt is Dup. on uwm100 :" + string(sicuw.uwm100.policy,"x(16)") +
        STRING(sicuw.uwm100.rencnt,"99")  + "/" +
        STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
        wdetail.OK_GEN  = "N".
    ELSE nv_docno = wdetail.docno.
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
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND   
    sic_bran.uwm130.riskno = s_riskno               AND   
    sic_bran.uwm130.itemno = s_itemno               AND   
    sic_bran.uwm130.bchyr  = nv_batchyr             AND   
    sic_bran.uwm130.bchno  = nv_batchno             AND   
    sic_bran.uwm130.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt    = sic_bran.uwm120.rencnt   
        sic_bran.uwm130.endcnt    = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp    = sic_bran.uwm120.riskgp   
        sic_bran.uwm130.riskno    = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno    = s_itemno 
        sic_bran.uwm130.bchyr     = nv_batchyr    /* batch Year */
        sic_bran.uwm130.bchno     = nv_batchno    /* bchno      */
        sic_bran.uwm130.bchcnt    = nv_batcnt     /* bchcnt     */
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0     /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0     /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0     /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0     /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.    /*Item Endt. Clause*/
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN 
        ASSIGN sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
        sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9 
        nv_comper              = deci(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc              = deci(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v = nv_comper   
        sic_bran.uwm130.uom9_v = nv_comacc  . 
    ASSIGN nv_riskno = 1
        nv_itemno    = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy,         
                                nv_riskno,
                                nv_itemno).
    END. /*transaction*/
    /* ---------------------------------------------  U W M 3 0 1 --------------*/ 
    RUN proc_chassic.
    ASSIGN 
        s_recid3  = RECID(sic_bran.uwm130)
        nv_covcod =   wdetail.covcod
        nv_makdes  =  wdetail.brand
        nv_moddes  =  wdetail.model
        nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
    ELSE nv_newsck = wdetail.stk.
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
        END.  /*transaction*/
    END.                                                          
    Assign  
        sic_bran.uwm301.policy  = sic_bran.uwm120.policy                   
        sic_bran.uwm301.rencnt  = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt  = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp  = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno  = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno  = s_itemno
        sic_bran.uwm301.tariff  = wdetail.tariff
        sic_bran.uwm301.covcod  = nv_covcod
        sic_bran.uwm301.trareg  = nv_uwm301trareg   /*Add kridtiya i.  23/07/2015*/
        sic_bran.uwm301.cha_no  = wdetail.chassis
        sic_bran.uwm301.eng_no  = wdetail.engno
        sic_bran.uwm301.Tons    = DECI(wdetail.tonn)
        sic_bran.uwm301.engine  = INTEGER(wdetail.engcc)                   
        sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage  = wdetail.garage
        sic_bran.uwm301.body    = wdetail.body
        sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
        sic_bran.uwm301.vehgrp  = wdetail.cargrp
        sic_bran.uwm301.mv_ben83 = ""
        sic_bran.uwm301.vehreg   = wdetail.vehreg 
        sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model 
        sic_bran.uwm301.modcod   = wdetail.redbook 
        sic_bran.uwm301.sckno    = 0              
        sic_bran.uwm301.itmdel   = NO
        sic_bran.uwm301.bchyr    = nv_batchyr      /* batch Year */      
        sic_bran.uwm301.bchno    = nv_batchno      /* bchno    */      
        sic_bran.uwm301.bchcnt   = nv_batcnt .     /* bchcnt     */  
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
        END.
    END.
    ELSE ASSIGN sic_bran.uwm301.drinam[9] = "".
    ASSIGN s_recid4  = RECID(sic_bran.uwm301).
    /*IF wdetail.redbook <> "" THEN DO:    /*กรณีที่มีการระบุ Code รถมา*/
        FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
            sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102 THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod         = sicsyac.xmm102.modcod 
                sic_bran.uwm301.Tons           = sicsyac.xmm102.tons 
                sic_bran.uwm301.body           = sicsyac.xmm102.body  
                sic_bran.uwm301.vehgrp         = sicsyac.xmm102.vehgrp
                wdetail.redbook                = sicsyac.xmm102.modcod
                wdetail.brand                  = SUBSTRING(xmm102.modest, 1,18) .
        END.
    END.
    ELSE DO:
        FIND LAST sicsyac.xmm102   WHERE
            INDEX(wdetail.model,trim(substr(sicsyac.xmm102.modest,INDEX(sicsyac.xmm102.modest," ") + 1 ))) <> 0   AND 
            INDEX(sicsyac.xmm102.modest,wdetail.brand) <> 0  NO-LOCK   NO-ERROR.
        IF AVAIL sicsyac.xmm102  THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod = sicsyac.xmm102.modcod
                sic_bran.uwm301.Tons   = sicsyac.xmm102.tons
                sic_bran.uwm301.body   = sicsyac.xmm102.body
                sic_bran.uwm301.vehgrp = sicsyac.xmm102.vehgrp
                sic_bran.uwm301.engine = sicsyac.xmm102.engine 
                wdetail.tonn           = sicsyac.xmm102.tons  
                wdetail.engcc          = string(sicsyac.xmm102.engine)
                wdetail.redbook        = sicsyac.xmm102.modcod   .  
        END.
    END.****/
    FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
         sic_bran.uwd132.policy = sic_bran.uwm100.policy AND
         sic_bran.uwd132.rencnt = sic_bran.uwm100.rencnt AND
         sic_bran.uwd132.endcnt = sic_bran.uwm100.endcnt AND
         sic_bran.uwd132.riskgp = s_riskgp               AND
         sic_bran.uwd132.riskno = s_riskno               AND
         sic_bran.uwd132.itemno = s_itemno               AND
         sic_bran.uwd132.bchyr  = nv_batchyr             AND
         sic_bran.uwd132.bchno  = nv_batchno             AND
         sic_bran.uwd132.bchcnt = nv_batcnt              NO-ERROR NO-WAIT.
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
        sic_bran.uwd132.policy  = wdetail.policy           /*Policy No. - uwm130*/
        sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt   /*Renewal Count - uwm130*/
        sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt   /*Endorsement Count - uwm130*/
        sic_bran.uwd132.riskgp  = s_riskgp                 /*Risk Group - uwm130*/
        sic_bran.uwd132.riskno  = s_riskno                 /*Risk No. - uwm130*/
        sic_bran.uwd132.itemno  = s_itemno                 /*Insured Item No. - uwm130*/
        sic_bran.uwd132.rateae  = NO                       /*Premium Rate % A/E Code*/
        sic_bran.uwm130.fptr03  = RECID(sic_bran.uwd132)   /*First uwd132 Cover & Premium*/
        sic_bran.uwm130.bptr03  = RECID(sic_bran.uwd132)   /*Last  uwd132 Cover & Premium*/
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
ASSIGN 
    nv_rec100 = s_recid1 
    nv_rec120 = s_recid2 
    nv_rec130 = s_recid3
    nv_rec301 = s_recid4
    nv_message = "" 
    nv_gap     = 0 
    nv_prem    = 0.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = nv_rec301 NO-WAIT NO-ERROR.
IF sic_bran.uwm130.fptr03 = 0 OR sic_bran.uwm130.fptr03 = ? THEN DO:
    FIND sicsyac.xmm107 USE-INDEX xmm10701      WHERE
        sicsyac.xmm107.class  = wdetail.class   AND
        sicsyac.xmm107.tariff = wdetail.tariff  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xmm107 THEN DO:
        FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmd107 THEN DO:
            CREATE sic_bran.uwd132.
            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                sicsyac.xmm016.class = wdetail.class  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm016 THEN 
                ASSIGN sic_bran.uwd132.gap_ae = NO
                sic_bran.uwd132.pd_aep = "E".
            ASSIGN 
                sic_bran.uwd132.bencod = sicsyac.xmd107.bencod      sic_bran.uwd132.policy = wdetail.policy
                sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt     sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp     sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
                sic_bran.uwd132.itemno = sic_bran.uwm130.itemno
                sic_bran.uwd132.bptr   = 0
                sic_bran.uwd132.fptr   = 0          
                nvffptr     = xmd107.fptr
                s_130bp1    = RECID(sic_bran.uwd132)
                s_130fp1    = RECID(sic_bran.uwd132)
                n_rd132     = RECID(sic_bran.uwd132)
                sic_bran.uwd132.bchyr   = nv_batchyr       /* batch Year */      
                sic_bran.uwd132.bchno   = nv_batchno       /* bchno      */      
                sic_bran.uwd132.bchcnt  = nv_batcnt .      /* bchcnt     */ 
            FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                sicsyac.xmm105.tariff = wdetail.tariff         AND
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:  /* Malaysia */
                IF           wdetail.class           = "110" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "140" THEN nv_key_a = inte(wdetail.tonn).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = uwd132.bencod    AND
                    sicsyac.xmm106.class   = wdetail.class    AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= nv_key_a         AND
                    sicsyac.xmm106.key_b  >= nv_key_b         AND
                    sicsyac.xmm106.effdat <= uwm100.comdat    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN 
                    ASSIGN 
                    sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff         AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod AND
                    sicsyac.xmm106.class   = wdetail.class          AND
                    sicsyac.xmm106.covcod  = wdetail.covcod         AND
                    sicsyac.xmm106.key_a  >= 0                      AND
                    sicsyac.xmm106.key_b  >= 0                      AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff         AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod AND
                    sicsyac.xmm106.class   = wdetail.class          AND
                    sicsyac.xmm106.covcod  = wdetail.covcod         AND
                    sicsyac.xmm106.key_a   = 0                      AND
                    sicsyac.xmm106.key_b   = 0                      AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                         RECID(sic_bran.uwd132),
                                         sic_bran.uwm301.tariff).
                    ASSIGN sic_bran.uwd132.gap_c = sic_bran.uwd132.prem_c.
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
                    sic_bran.uwd132.fptr    = 0
                    sic_bran.uwd132.bptr    = n_rd132
                    sic_bran.uwd132.bchyr   = nv_batchyr      /* batch Year */      
                    sic_bran.uwd132.bchno   = nv_batchno      /* bchno    */      
                    sic_bran.uwd132.bchcnt  = nv_batcnt       /* bchcnt     */      
                    n_rd132                 = RECID(sic_bran.uwd132).
                FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                    sicsyac.xmm016.class = wdetail.class NO-LOCK NO-ERROR.
                IF AVAIL sicsyac.xmm016 THEN 
                    ASSIGN sic_bran.uwd132.gap_ae = NO
                    sic_bran.uwd132.pd_aep = "E".
                FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                    sicsyac.xmm105.tariff = wdetail.tariff         AND
                    sicsyac.xmm105.bencod = sicsyac.xmd107.bencod  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
                ELSE   MESSAGE "ไม่พบ Tariff นี้ในระบบ กรุณาใส่ Tariff ใหม่" 
                    "Tariff" wdetail.tariff "Bencod"  xmd107.bencod VIEW-AS ALERT-BOX.
                IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
                    IF                wdetail.class      = "110" THEN nv_key_a = inte(wdetail.engcc).
                    ELSE IF SUBSTRING(wdetail.class,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                    ELSE IF SUBSTRING(wdetail.class,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                    ELSE IF SUBSTRING(wdetail.class,1,3) = "140" THEN nv_key_a = inte(wdetail.tonn).
                    nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff   AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.class    AND
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
                        sicsyac.xmm106.class   = wdetail.class         AND
                        sicsyac.xmm106.covcod  = wdetail.covcod           AND
                        sicsyac.xmm106.key_a  >= 0                        AND
                        sicsyac.xmm106.key_b  >= 0                        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601                  WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff            AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod    AND
                        sicsyac.xmm106.class   = wdetail.class             AND
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
                        ASSIGN sic_bran.uwd132.gap_c = sic_bran.uwd132.prem_c.
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
        MESSAGE "ไม่พบ Class " wdetail.class " ใน Tariff  " wdetail.tariff  skip
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
                IF           wdetail.class      = "110" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "140" THEN nv_key_a = inte(wdetail.tonn).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff          AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod  AND
                    sicsyac.xmm106.class   = wdetail.class        AND
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
                    sicsyac.xmm106.class   = wdetail.class    AND 
                    sicsyac.xmm106.covcod  = wdetail.covcod      AND 
                    sicsyac.xmm106.key_a  >= 0                   AND 
                    sicsyac.xmm106.key_b  >= 0                   AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.class    AND
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
                    ASSIGN sic_bran.uwd132.gap_c = sic_bran.uwd132.prem_c.
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                END.
            END.
        END.
    END.
END.
/*
IF fi_policymas72 <> ""  THEN DO:
    ASSIGN         
        nv_gapprm = 0
        nv_pdprm  = 0.
    FOR EACH sicuw.uwd132 WHERE 
        sicuw.uwd132.policy = fi_policymas72   NO-LOCK  .
        ASSIGN 
            nv_gapprm                = nv_gapprm + sicuw.uwd132.gap_c  
            nv_pdprm                 = nv_pdprm  + sicuw.uwd132.prem_c .
        FIND LAST  sic_bran.uwd132  USE-INDEX uwd13201  WHERE /*a490116 note change index from uwd13290 to uwd13201*/
            sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
            sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
            sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
            sic_bran.uwd132.bencod  = sicuw.uwd132.bencod     AND 
            sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
            sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
            sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
            sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
            sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  NO-ERROR    .
        IF AVAIL sic_bran.uwd132 THEN  
            ASSIGN  
            sic_bran.uwd132.bencod   = sicuw.uwd132.bencod   
            sic_bran.uwd132.benvar   = sicuw.uwd132.benvar
            sic_bran.uwd132.gap_c    = sicuw.uwd132.gap_c   
            sic_bran.uwd132.prem_c   = sicuw.uwd132.prem_c
            nv_gapprm =   sicuw.uwd132.gap_c   
            nv_pdprm  =   sicuw.uwd132.prem_c .
            
    END.
END.
*/
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
IF AVAILABLE sicsyac.xmm031 THEN 
    ASSIGN  nv_com1_per = sicsyac.xmm031.comm1 .
    
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
        ASSIGN  nv_com1_per     = sic_bran.uwm120.com1p.
    IF nv_com1_per <> 0 THEN 
        ASSIGN sic_bran.uwm120.com1ae =  NO
        sic_bran.uwm120.com1p  =  nv_com1_per
        /*sic_bran.uwm120.com1_r =  (sic_bran.uwm120.prem_r * sic_bran.uwm120.com1p / 100) * 1-*//*krid ...*/
        sic_bran.uwm120.com1_r =  (sic_bran.uwm120.prem_r * nv_com1_per / 100) * 1-

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign c-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------------------------*/
DO:
    For each  wdetail :
        DELETE  wdetail.
    END.
    FOR EACH wacctext15.
        DELETE wacctext15.
    END.
    FOR EACH wacctext17.
        DELETE wacctext17.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|" 
            np_idno           /* "No"                      */           
            np_cedpol         /* "เลขที่ใบแจ้งงาน"         */
            np_typepol        /* "ประเภทงาน"               */
            np_status         /* "สถานะการทำประกัน"        */
            np_memo           /* "หมายเหตุ"                */
            np_remak          /* "หมายเหตุสถานะกรมธรรม์"   */
            np_name1          /* "ชื่อลูกค้า"              */
            np_sumins         /* "ทุนประกัน"               */
            np_premt          /* "เบี้ยประกันภัย"          */
            np_sendat         /* "วันที่แจ้งงาน"           */
            np_comdat         /* "วันเริ่มคุ้มครอง"        */
            np_recipdat       /* "วันที่รับงาน"            */
            np_keydat         /* "วันที่ป้อนข้อมูล"        */
            np_postdat        /* "วันที่ส่งไปรษณีย์"       */
            np_brand          /* "ยี่ห้อ"                  */
            np_vehreg         /* "ทะเบียนรถ"               */
            np_chassis        /* "เลขตัวถัง"               */
            np_caryear        /* "ปีรถ"                    */
            np_comname        /* "บริษัทประกันภัย"         */
            np_agentno        /* "รหัสตัวแทน"              */
            np_agenname       /* "ชื่อตัวแทน"              */
            np_AEname         /* "ชื่อ AE"                 */
            nn_address        
            nn_icno           
            /*nn_pol70       /* "เลขกรมธรรม์70"           */     
            nn_pol72       /* "เลขกรมธรรม์72"           */  */   
            np_prepol
            nn_name2       /* "และ/หรือ"                */     
            np_garage      /* "Garage(ซ่อมอู่-ห้าง)"    */     
            np_fincode     /* dealer code.*/
            np_pack        /* "Package"                 */     
            np_41TPBI      /* "TPBI/Person"             */     
            np_42TPBI      /* "TPBI/Per Acciden"        */     
            np_43TPPD      /* "TPPD/Per Acciden"        */     
            np_41PA        /*  "41 PA. 1 FOR DRIVER"     */    
            np_42PA        /*  "42 PA. 2 MEDICAL EXPENSE"*/    
            np_43BAIL      /*  "43 BAIL BOND"            */    
            np_ben83       /*  "8.3 Benname"             */    
            np_F17_1       /*  "F17-1 "                  */    
            np_F17_2       /*  "F17-2 "                  */    
            np_F17_3       /*  "F17-3 "                  */    
            np_F17_4       /*  "F17-4 "                  */    
            np_F18_1       /*  "F18-1 "                  */    
            np_F18-2       /*  "F18-2 "                  */    
            np_F18_3       /*  "F18-3 "                  */    
            np_F18_4       /*  "F18-4 "                  */    
            np_F18_5       /*  "F18-5 "                  */  . 

        IF            TRIM(np_idno)       = "" THEN RUN proc_initdata.
        ELSE IF index(TRIM(np_idno),"NO") <> 0 THEN RUN proc_initdata.
        ELSE DO:
            IF nn_address <> "" THEN RUN proc_assignaddr.
            IF INDEX(TRIM(np_vehreg),"ป้ายแดง") <> 0 THEN np_vehreg = "" .
            IF (TRIM(np_vehreg)  =  "" ) AND (np_chassis <> "" ) THEN DO:
                IF LENGTH(trim(np_chassis)) > 9  THEN np_vehreg = "/" + SUBSTR(TRIM(np_chassis),LENGTH(trim(np_chassis)) - 8 ).
                ELSE np_vehreg = "/" + TRIM(np_chassis).
            END.
            ELSE DO:
                IF TRIM(np_vehreg) <>  ""  THEN DO:
                    IF (SUBSTR(TRIM(np_vehreg),1,1) >= "1") AND ((SUBSTR(TRIM(np_vehreg),1,1) <= "9"))  THEN
                        ASSIGN np_vehreg = TRIM(SUBSTR(trim(np_vehreg),1,1)) + TRIM(SUBSTR(trim(np_vehreg),2)) .
                END.
            END.
            IF np_cedpol <> "" THEN RUN proc_create70.
            /*IF nn_pol72 <> "" THEN RUN proc_create72.*//*ไม่มีโหลด พรบ .*/
            RUN proc_initdata.
        END.
    END. /* repeat   */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignaddr c-Win 
PROCEDURE proc_assignaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nn_addr1 = trim(nn_address)
    nn_addr2 = ""
    nn_addr3 = ""
    nn_addr4 = "".
/*nn_address*/

IF INDEX(trim(nn_address),"กทม") <> 0 THEN DO:
    ASSIGN nn_addr4 = trim(SUBSTR(trim(nn_address),INDEX(trim(nn_address),"กทม")))
        nn_address  = trim(SUBSTR(trim(nn_address),1,INDEX(trim(nn_address),"กทม") - 1 )).
END.
ELSE IF  INDEX(trim(nn_address),"กรุง") <> 0 THEN DO:
    ASSIGN nn_addr4 = trim(SUBSTR(trim(nn_address),INDEX(trim(nn_address),"กรุง")))
        nn_address  = trim(SUBSTR(trim(nn_address),1,INDEX(trim(nn_address),"กรุง") - 1 )).
END.
ELSE IF  INDEX(trim(nn_address),"จ.") <> 0 THEN DO:
    ASSIGN nn_addr4 = trim(SUBSTR(trim(nn_address),INDEX(trim(nn_address),"จ.")))
        nn_address  = trim(SUBSTR(trim(nn_address),1,INDEX(trim(nn_address),"จ.") - 1 )).
END.
ELSE IF  INDEX(trim(nn_address),"จังหวัด") <> 0 THEN DO:
    ASSIGN nn_addr4 = trim(SUBSTR(trim(nn_address),INDEX(trim(nn_address),"จังหวัด")))
        nn_address  = trim(SUBSTR(trim(nn_address),1,INDEX(trim(nn_address),"จังหวัด") - 1 )).
END.
/*อ. อำเภอ เขต */
IF INDEX(trim(nn_address),"เขต") <> 0 THEN DO:
    ASSIGN 
        nn_addr3    = trim(SUBSTR(trim(nn_address),INDEX(trim(nn_address),"เขต")))
        nn_address  = trim(SUBSTR(trim(nn_address),1,INDEX(trim(nn_address),"เขต") - 1 )).
END.
ELSE IF INDEX(trim(nn_address),"อำเภอ") <> 0 THEN DO:
    ASSIGN 
        nn_addr3    = trim(SUBSTR(trim(nn_address),INDEX(trim(nn_address),"อำเภอ")))
        nn_address  = trim(SUBSTR(trim(nn_address),1,INDEX(trim(nn_address),"อำเภอ") - 1 )).
END.
ELSE IF INDEX(trim(nn_address),"อ.") <> 0 THEN DO:
    ASSIGN 
        nn_addr3    = trim(SUBSTR(trim(nn_address),INDEX(trim(nn_address),"อ.")))
        nn_address  = trim(SUBSTR(trim(nn_address),1,INDEX(trim(nn_address),"อ.") - 1 )).
END.
/*ต. ตำบล  แขวง */
IF INDEX(trim(nn_address),"แขวง") <> 0 THEN DO:
    ASSIGN 
        nn_addr2    = trim(SUBSTR(trim(nn_address),INDEX(trim(nn_address),"แขวง")))
        nn_address  = trim(SUBSTR(trim(nn_address),1,INDEX(trim(nn_address),"แขวง") - 1 )).
END.
ELSE IF INDEX(trim(nn_address),"ตำบล") <> 0 THEN DO:
    ASSIGN 
        nn_addr2    = trim(SUBSTR(trim(nn_address),INDEX(trim(nn_address),"ตำบล")))
        nn_address  = trim(SUBSTR(trim(nn_address),1,INDEX(trim(nn_address),"ตำบล") - 1 )).
END.
ELSE IF INDEX(trim(nn_address),"ต.") <> 0 THEN DO:
    ASSIGN 
        nn_addr2    = trim(SUBSTR(trim(nn_address),INDEX(trim(nn_address),"ต.")))
        nn_address  = trim(SUBSTR(trim(nn_address),1,INDEX(trim(nn_address),"ต.") - 1 )).
END.
ASSIGN nn_addr1 = TRIM(nn_address) .
/*addr 1 */
IF LENGTH(nn_addr1) > 35 THEN DO:
    loop_add01:
    DO WHILE LENGTH(nn_addr1) > 35 :
        IF R-INDEX(nn_addr1," ") <> 0 THEN DO:
            ASSIGN 
                nn_addr2  = trim(SUBSTR(nn_addr1,r-INDEX(nn_addr1," "))) + " " + nn_addr2
                nn_addr1  = trim(SUBSTR(nn_addr1,1,r-INDEX(nn_addr1," "))) .
        END.
        ELSE LEAVE loop_add01.
    END.
    /*wdetail.tambon*/
    IF LENGTH(nn_addr2) > 35 THEN DO:
        loop_add02:
        DO WHILE LENGTH(nn_addr2) > 35 :
            IF R-INDEX(nn_addr2," ") <> 0 THEN DO:
                ASSIGN 
                    nn_addr3   = trim(SUBSTR(nn_addr2,r-INDEX(nn_addr2," "))) + " " + nn_addr3
                    nn_addr2   = trim(SUBSTR(nn_addr2,1,r-INDEX(nn_addr2," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
    END.
    /*nn_addr3*/
    IF LENGTH(nn_addr3) > 35 THEN DO:
        loop_add03:
        DO WHILE LENGTH(nn_addr3) > 35 :
            IF R-INDEX(nn_addr3," ") <> 0 THEN DO:
                ASSIGN 
                    nn_addr4   = trim(SUBSTR(nn_addr3,r-INDEX(nn_addr3," "))) + " " + nn_addr4
                    nn_addr3   = trim(SUBSTR(nn_addr3,1,r-INDEX(nn_addr3," "))).
            END.
            ELSE LEAVE loop_add03.
        END.
    END.
END.
ELSE DO:
    /*wdetail.tambon*/
    IF LENGTH(nn_addr2 + " " + nn_addr3) <= 35 THEN  
        ASSIGN 
        nn_addr2    = nn_addr2 + " " + nn_addr3
        nn_addr3    = nn_addr4
        nn_addr4    = "" .
    ELSE IF LENGTH(nn_addr3 + " " + nn_addr4) <= 35 THEN  
        ASSIGN 
        nn_addr3    = nn_addr3 + " " + nn_addr4
        nn_addr4  = "" .
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
IF wdetail.redbook <> "" THEN DO:
    Find FIRST stat.maktab_fil Use-index      maktab01        Where
        stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3) And   
        stat.maktab_fil.modcod   =  trim(wdetail.redbook)     No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        wdetail.redbook  =  stat.maktab_fil.modcod
        /*wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes*/
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
        wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn
        wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .

END.
ELSE IF wdetail.seat = "" THEN DO:
    IF wdetail.engcc = "" THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
            index(stat.maktab_fil.moddes,n_model) <> 0                    And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)         AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
             stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
            wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn
            wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
            ELSE wdetail.redbook  = "".
    END.
    ELSE DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
            index(stat.maktab_fil.moddes,n_model) <> 0                    And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)         AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
             stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN
                ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes 
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
                wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn
                wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
            ELSE wdetail.redbook  = "".
    END.
END.
ELSE DO:
    IF wdetail.engcc = "" THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
            index(stat.maktab_fil.moddes,n_model) <> 0                    And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)         AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
             stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  AND  
            stat.maktab_fil.seats    >=    DECI(wdetail.seat)       No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN
                ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
                wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn
                wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
            ELSE wdetail.redbook  = "".
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
                index(stat.maktab_fil.moddes,n_model) <> 0              And
                stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
                stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
                stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)         AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  AND  
                stat.maktab_fil.seats    >=    DECI(wdetail.seat)       No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN
                ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
                wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn
                wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat.
            ELSE wdetail.redbook  = "".
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
ASSIGN 
    dod1           = 0 
    dod2           = 0 
    dpd0           = 0 
    nv_ncbper      = 0
    nv_cl_per      = 0
    nv_dss_per     = 0
    nv_stf_per     = 0 . 

IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwtmexp(INPUT-OUTPUT  wdetail.prepol,                                    
                     INPUT-OUTPUT  wdetail.n_branch,                              
                     INPUT-OUTPUT  wdetail.inserf,                          
                     INPUT-OUTPUT  wdetail.tiname,                            
                     INPUT-OUTPUT  wdetail.insnam,                                  
                     /*INPUT-OUTPUT  wdetail.name2, */                           
                     /*INPUT-OUTPUT  wdetail.name3, */                           
                     /*INPUT-OUTPUT  wdetail.n_addr1,             
                     INPUT-OUTPUT  wdetail.n_addr2,                
                     INPUT-OUTPUT  wdetail.n_addr3,                
                     INPUT-OUTPUT  wdetail.n_addr4,*/           
                     INPUT-OUTPUT  wdetail.firstdat,        
                     INPUT-OUTPUT  wdetail.comdat,                
                     INPUT-OUTPUT  wdetail.expdat,                
                     INPUT-OUTPUT  wdetail.class,           
                     INPUT-OUTPUT  wdetail.redbook,                      
                     INPUT-OUTPUT  wdetail.brand,                             
                     INPUT-OUTPUT  wdetail.caryear,                                 
                     INPUT-OUTPUT  wdetail.cargrp,                             
                     INPUT-OUTPUT  wdetail.body,                           
                     INPUT-OUTPUT  wdetail.engcc,                         
                     INPUT-OUTPUT  wdetail.Tonn,                     
                     INPUT-OUTPUT  wdetail.seat,                
                     INPUT-OUTPUT  wdetail.vehuse,           
                     INPUT-OUTPUT  wdetail.covcod,       
                     INPUT-OUTPUT  wdetail.garage,         
                     INPUT-OUTPUT  wdetail.vehreg,                
                     INPUT-OUTPUT  wdetail.chassis,          
                     INPUT-OUTPUT  wdetail.engno,       
                     INPUT-OUTPUT  wdetail.uom1_v,                
                     INPUT-OUTPUT  wdetail.uom2_v,                
                     INPUT-OUTPUT  wdetail.uom5_v,                
                     INPUT-OUTPUT  wdetail.si,                   
                     INPUT-OUTPUT  wdetail.base,           
                     INPUT-OUTPUT  nv_41,            
                     INPUT-OUTPUT  nv_42,            
                     INPUT-OUTPUT  nv_43,            
                     INPUT-OUTPUT  wdetail.seat41,                    
                     INPUT-OUTPUT  dod1,                          
                     INPUT-OUTPUT  dod2,                          
                     INPUT-OUTPUT  dpd0,                          
                     INPUT-OUTPUT  wdetail.fleet,                
                     INPUT-OUTPUT  wdetail.ncb,                    
                     INPUT-OUTPUT  wdetail.dspc,             
                     INPUT-OUTPUT  nv_stf_per,              
                     INPUT-OUTPUT  nv_cl_per,                   
                     INPUT-OUTPUT  wdetail.benname).          
    
    IF INDEX(wdetail.brand," ") <> 0  THEN 
        ASSIGN 
        wdetail.model = trim(SUBSTR(wdetail.brand,INDEX(wdetail.brand," ")))
        wdetail.brand = trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," "))).
    IF wdetail.fi = "" THEN ASSIGN  wdetail.fi = wdetail.si. 
    ASSIGN 
        wdetail.nv_41    =  string(nv_41) 
        wdetail.nv_412   =  string(nv_41)
        wdetail.nv_42    =  string(nv_42) 
        wdetail.nv_43    =  string(nv_43).
END.
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
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "v70" THEN DO:
    ASSIGN fi_process = "Create data to base..." + wdetail.policy 
        nv_baseprm    = 0
        nv_baseprm    = DECI(wdetail.base)    .
    DISP fi_process WITH FRAM fr_main.

    IF nv_baseprm = 0  THEN DO: 
        RUN wgs\wgsfbas.
    END.
    ASSIGN chk = NO
        NO_basemsg = " " .
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
    /*IF wdetail.prepol <> "" THEN  ASSIGN  nv_41 = n_41  /*ต่ออายุ*/
    nv_42 = n_42
    nv_43 = n_43 .*/
    ASSIGN 
        /*nv_41 = 200000  /*deci(wdetail.no_41)*/ 
        nv_42 = 200000         /*deci(wdetail.no_42)*/
        nv_43 = 200000    /*deci(wdetail.no_43)*/       
        wdetail.seat = "16"
        nv_seats = 16*/
        nv_seat41 = 0 
        nv_seat41 = IF wdetail.seat41  = 0 THEN deci(wdetail.seat) ELSE wdetail.seat41
        nv_class  =  wdetail.class.
    /*RUN WGS\WGSOPER(INPUT nv_tariff,       
                          nv_class,
                          nv_key_b,
                          nv_comdat). */
    /*RUN proc_wgsoper .*/
    ASSIGN 
        nv_41     =  deci(wdetail.nv_41)    
        nv_412    =  deci(wdetail.nv_412)   
        nv_41cod1 = "411"
        nv_411var1   = "     PA Driver = "
        nv_411var2   =  STRING(nv_41)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"       /* 412 412 412 412 .........................*/
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(nv_412)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_41
        nv_412prm  = nv_412.
    Assign
        nv_42var    = " "       /* -------fi_42---------*/
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
    RUN proc_wgsoper .
    /*RUN WGS\WGSOPER(INPUT nv_tariff,    /*pass*//*a490166 note modi*/
                          nv_class,     
                          nv_key_b,     
                          nv_comdat).  */ /*  RUN US\USOPER(INPUT nv_tariff,*/  
    /*------nv_usecod------------*/
    Assign
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30)  = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  SUBSTR(wdetail.class,2,3). 
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
    ASSIGN
        nv_bipcod      = "BI1"
        nv_bipvar1     = "     BI per Person = "
        nv_bipvar2     =  wdetail.uom1_v    /*STRING(uwm130.uom1_v)*/
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    Assign 
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     =  wdetail.uom2_v     /* STRING(uwm130.uom2_v)*/
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*-------------nv_pdacod--------------------*/
    Assign
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     =  wdetail.uom5_v         /*STRING(uwm130.uom5_v)*/
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    /*--------------- deduct ----------------*/
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
        dod0     = dpd0   /*Test */
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
    RUN WGS\WGSORPRM.P (INPUT nv_tariff,  /*pass*/
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
    /*nv_cl_per  = 0.*/
    nv_clmvar  = " ".
    IF nv_cl_per  <> 0  THEN
        Assign 
        nv_clmvar1   = " Load Claim % = "
        nv_clmvar2   =  STRING(nv_cl_per)
        SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
    RUN WGS\WGSORPRM.P (INPUT nv_tariff,  
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
        Assign
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
          nv_stfvar   = " ".
      IF  nv_stf_per   <> 0  THEN
           Assign
                 nv_stfvar1   = "     Discount Staff"          
                 nv_stfvar2   =  STRING(nv_stf_per)           
                 SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1    
                 SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.   
                                                              
        /*--------------------------*/                        
      RUN WGS\WGSORPRM.P (INPUT  nv_tariff,   /*pass*/
                                       nv_class,
                                       nv_covcod,
                                       nv_key_b,
                                       nv_comdat,
                                       nv_totsi,
                                       nv_uom1_v ,       
                                       nv_uom2_v ,       
                                       nv_uom5_v ).

    ASSIGN fi_process = "out base" + wdetail.policy.
    DISP fi_process WITH FRAM fr_main.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2plus c-Win 
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
    /*
    IF fi_policymas <> ""  THEN DO:
        RUN proc_base2plus0.
    END.
    */
    IF nv_baseprm = 0  THEN DO: 
        RUN wgs\wgsfbas.
    END.
    ASSIGN chk = NO
        NO_basemsg = " " .
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
    /*IF wdetail.prepol <> "" THEN  ASSIGN  nv_41 = n_41  /*ต่ออายุ*/
    nv_42 = n_42
    nv_43 = n_43 .*/
    ASSIGN 
        /*nv_41 = 200000  /*deci(wdetail.no_41)*/ 
        nv_42 = 200000         /*deci(wdetail.no_42)*/
        nv_43 = 200000    /*deci(wdetail.no_43)*/       
        wdetail.seat = "16"
        nv_seats = 16*/
        nv_seat41 = 0 
        nv_seat41 = IF wdetail.seat41  = 0 THEN deci(wdetail.seat) ELSE wdetail.seat41
        nv_class  =  wdetail.class.
    RUN WGS\WGSOPER(INPUT nv_tariff, /*add krid  23/07/2015 */
                nv_class,
                nv_key_b,
                nv_comdat). 
    ASSIGN 
        nv_41     =  deci(wdetail.nv_41)    
        nv_412    =  deci(wdetail.nv_412)   
        nv_41cod1 = "411"
        nv_411var1   = "     PA Driver = "
        nv_411var2   =  STRING(nv_41)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"       /* 412 412 412 412 .........................*/
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(nv_412)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_41
        nv_412prm  = nv_412.
    Assign
        nv_42var    = " "       /* -------fi_42---------*/
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
    ASSIGN nv_sclass =  SUBSTR(wdetail.class,2,3). 
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
    ASSIGN
        nv_bipcod      = "BI1"
        nv_bipvar1     = "     BI per Person = "
        nv_bipvar2     =  wdetail.uom1_v    /*STRING(uwm130.uom1_v)*/
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    Assign 
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     =  wdetail.uom2_v     /* STRING(uwm130.uom2_v)*/
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
    Assign
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     =  wdetail.uom5_v         /*STRING(uwm130.uom5_v)*/
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    RUN WGS\WGSORPR1.P (INPUT   nv_tariff,  
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                deci(wdetail.si),
                                deci(wdetail.uom1_v),
                                deci(wdetail.uom2_v),
                                deci(wdetail.uom5_v)).   /*kridtiya i.*/
    /*--------------- deduct ----------------*/
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1")  THEN ASSIGN dod1    = 2000 .   /*A57-0126*/
    ELSE DO:
        IF dod0 > 3000 THEN DO:
            dod1 = 3000.
            dod2 = dod0 - dod1.
        END.
    END.
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
    /*nv_cl_per  = 0.*/
    nv_clmvar  = " ".
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
          nv_stfvar   = " ".
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

    ASSIGN fi_process = "out base" + wdetail.policy.
    DISP fi_process WITH FRAM fr_main.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2plus0 c-Win 
PROCEDURE proc_base2plus0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
            nv_baseprm    = 0
            nv_41         = 0
            nv_42         = 0
            nv_43         = 0
            dod1          = 0
            dod2          = 0
            dod0          = 0
            wdetail.fleet = ""
            wdetail.ncb   = ""
            wdetail.dspc  = ""
            nv_stf_per    = 0
            nv_cl_per     = 0.
        FOR EACH sicuw.uwd132 USE-INDEX uwd13290  WHERE
            sicuw.uwd132.policy   = fi_policymas  NO-LOCK .
            IF      sicuw.uwd132.bencod = "base"         THEN ASSIGN nv_baseprm    = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
            ELSE IF sicuw.uwd132.bencod = "411"          THEN ASSIGN nv_41         = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).  
            ELSE IF sicuw.uwd132.bencod = "42"           THEN ASSIGN nv_42         = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
            ELSE IF sicuw.uwd132.bencod = "43"           THEN ASSIGN nv_43         = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
            ELSE IF sicuw.uwd132.bencod = "dod"          THEN ASSIGN dod1          = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
            ELSE IF sicuw.uwd132.bencod = "dod2"         THEN ASSIGN dod2          = DECI(DECI(np_dedod)  +  DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))).
            ELSE IF sicuw.uwd132.bencod = "dpd"          THEN ASSIGN dod0          = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
            ELSE IF sicuw.uwd132.bencod = "flet"         THEN ASSIGN wdetail.fleet = SUBSTRING(sicuw.uwd132.benvar,31,30).
            ELSE IF sicuw.uwd132.bencod = "ncb"          THEN ASSIGN wdetail.ncb   = string(SUBSTRING(sicuw.uwd132.benvar,31,30)).
            ELSE IF sicuw.uwd132.bencod = "dspc"         THEN ASSIGN wdetail.dspc  = string(SUBSTRING(sicuw.uwd132.benvar,31,30)).
            ELSE IF sicuw.uwd132.bencod = "dstf"         THEN ASSIGN nv_stf_per    = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).     
            ELSE IF index(sicuw.uwd132.bencod,"cl") <> 0 THEN ASSIGN nv_cl_per     = deci(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        END.    /*RUN proc_assign_polmas.*/
        */
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
ASSIGN nv_uwm301trareg = wdetail.chassis.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassicmat c-Win 
PROCEDURE proc_chassicmat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew AS CHAR.
DEFINE VAR nv_len AS INTE INIT 0.
ASSIGN nv_uwm301trareg = np_chassis.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 c-Win 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER . 
ASSIGN 
    nv_siredbook    = 0
    nv_siredbook    = DECI(wdetail.si).

IF wdetail.vehreg   = "" THEN 
    wdetail.vehreg  = IF SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8) <> "" THEN
                      "/" +   SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8 ) 
                      ELSE "".
IF wdetail.vehreg   = " " THEN 
    ASSIGN wdetail.vehreg = "/" + SUBSTRING(trim(wdetail.chassis),LENGTH(trim(wdetail.chassis))  - 8 ) 
    wdetail.comment       = wdetail.comment + "| Vehicle Register is mandatory field. "
    wdetail.pass          = "N"   
    wdetail.OK_GEN        = "N". 
IF wdetail.cancel         = "ca"  THEN  
    ASSIGN wdetail.pass   = "N"  
    wdetail.comment       = wdetail.comment + "| cancel"
    wdetail.OK_GEN        = "N".
IF wdetail.icno <> ""  THEN DO:
    IF LENGTH(TRIM(wdetail.icno)) = 13 THEN DO:
        DO WHILE nv_seq <= 12:
            nv_sum = nv_sum + INTEGER(SUBSTR(TRIM(wdetail.icno),nv_seq,1)) * (14 - nv_seq).
            nv_seq = nv_seq + 1.
        END.
        nv_checkdigit = 11 - nv_sum MODULO 11.
        IF nv_checkdigit >= 10 THEN nv_checkdigit = nv_checkdigit - 10.
        IF STRING(nv_checkdigit) <> SUBSTR(TRIM(wdetail.icno),13,1) THEN  ASSIGN  wdetail.icno = "".
    END.
END.
IF wdetail.n_branch = "" THEN 
    ASSIGN 
    wdetail.comment = wdetail.comment + "| สาขาเป็นค่าว่างกรูณาใส่สาขาอผู้เอาประกัน"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
/*
IF index("123456789",substr(wdetail.policy,1,1)) <> 0  THEN DO:
    IF wdetail.n_branch <> (substr(wdetail.policy,1,2)) THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| สาขาไม่ตรงกับสาขากรมธรรม์"
        wdetail.pass           = "N"     
        wdetail.OK_GEN         = "N".
END.
ELSE DO:  
    IF wdetail.n_branch <> (substr(wdetail.policy,2,1)) THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| สาขาไม่ตรงกับสาขากรมธรรม์"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
END.

IF LENGTH(TRIM(wdetail.policy)) <> 12  THEN
    ASSIGN wdetail.comment = wdetail.comment + "| เลขกรมธรรม์ต้องมีจำนวน 12 ตัวเท่านั้น"
    wdetail.pass           = "N"     
    wdetail.OK_GEN         = "N".
*/
IF wdetail.insnam = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass           = "N"     
    wdetail.OK_GEN         = "N".
IF wdetail.class = " " THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass           = "N"  
    wdetail.OK_GEN         = "N".
IF wdetail.brand = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
/*IF wdetail.model = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N".*/
IF wdetail.caryear = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
ASSIGN NO_CLASS  = trim(wdetail.class) 
       nv_poltyp = trim(wdetail.poltyp).
If no_class  <>  " " Then do:
    FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp =   nv_poltyp       AND
        sicsyac.xmd031.class  =   no_class        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmd031 THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N".
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
    IF NOT AVAILABLE sicsyac.xmm016 THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| Not on Business class on xmm016"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".
    ELSE 
        ASSIGN  wdetail.tariff =   sicsyac.xmm016.tardef
            no_class           =   sicsyac.xmm016.class
            nv_sclass          =   Substr(no_class,2,3).
END.
Find sicsyac.sym100 Use-index sym10001       Where
    sicsyac.sym100.tabcod = "u014"           AND 
    sicsyac.sym100.itmcod =  wdetail.vehuse  No-lock no-error no-wait.
IF not avail sicsyac.sym100 Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| Not on Vehicle Usage Codes table sym100 u014"
    wdetail.pass    = "N" 
    wdetail.OK_GEN  = "N".
Find  sicsyac.sym100 Use-index sym10001    Where
    sicsyac.sym100.tabcod = "u013"         And
    sicsyac.sym100.itmcod = wdetail.covcod No-lock no-error no-wait.
IF not avail sicsyac.sym100 Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| Not on Motor Cover Type Codes table sym100 u013"
    wdetail.pass    = "N" 
    wdetail.OK_GEN  = "N".
/*---------- fleet -------------------*/
IF inte(wdetail.fleet) <> 0 AND INTE(wdetail.fleet) <> 10 Then 
    ASSIGN wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. "
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
/*NV_NCBPER = INTE(WDETAIL.NCB) .
If nv_ncbper  <> 0 Then do:
    Find first sicsyac.xmm104 Use-index xmm10401 Where
        sicsyac.xmm104.tariff = wdetail.tariff                      AND
        sicsyac.xmm104.class  = wdetail.prempa + wdetail.subclass   AND
        sicsyac.xmm104.covcod = wdetail.covcod           AND
        sicsyac.xmm104.ncbper = INTE(wdetail.ncb)
        No-lock no-error no-wait.
    IF not avail  sicsyac.xmm104  THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
END. */ /*ncb <> 0*/
/******* drivernam **********/

ASSIGN nv_sclass = wdetail.class.
IF INDEX(wdetail.model," ") <> 0 THEN  n_model = TRIM(SUBSTR(wdetail.model,1,INDEX(wdetail.model," "))) .
ELSE n_model = TRIM(wdetail.model).
If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
    ASSIGN  
    wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  wdetail.class   NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN 
    nv_simat  = makdes31.si_theft_p   
    nv_simat1 = makdes31.load_p   .    
ELSE 
    ASSIGN  
        nv_simat  = 0
        nv_simat1 = 0.
IF wdetail.prepol = "" THEN RUN proc_assignredbook.
ELSE DO:
    IF wdetail.redbook <> "" THEN DO:
        Find FIRST stat.maktab_fil Use-index      maktab01        Where
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3) And   
            stat.maktab_fil.modcod   =  trim(wdetail.redbook)     No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod
            /*wdetail.brand    =  stat.maktab_fil.moddes */ 
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
            wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn
            wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
    END.
    ELSE RUN proc_assignredbook.
END.
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
FOR EACH wdetail WHERE wdetail.policy <> "" :
    /*------------------  new ---------------------*/
    ASSIGN 
        nv_baseprm       = 0
        nv_41            = 0
        nv_42            = 0
        nv_43            = 0
        dod1             = 0
        dod2             = 0
        dod0             = 0
        nv_stf_per       = 0
        nv_cl_per        = 0 
        n_rencnt         = 0  
        n_Endcnt         = 0
        wdetail.n_rencnt = 0
        wdetail.n_endcnt = 0
        wdetail.pass     = "Y".
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
        IF  wdetail.prepol  <> "" THEN  RUN Proc_renew70. 
        RUN proc_chktest0.
        RUN proc_policy . 
        RUN proc_chktest2. 
        RUN proc_chktest3. 
        RUN proc_chktest4. 
    END.
END.        /*for each*/
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
ASSIGN fi_process = "Create data to uwm130..." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
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
        nv_sclass              = substr(wdetail.class,2,3) .
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
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
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
        ASSIGN sic_bran.uwm130.uom1_v = deci(wdetail.uom1_v)  
        sic_bran.uwm130.uom2_v        = deci(wdetail.uom2_v)  
        sic_bran.uwm130.uom5_v        = deci(wdetail.uom5_v) 
        sic_bran.uwm130.uom6_v        = inte(wdetail.si)
        sic_bran.uwm130.uom7_v        = inte(wdetail.fi)
        sic_bran.uwm130.fptr01        = 0     sic_bran.uwm130.bptr01 = 0   /*Item Upper text*/
        sic_bran.uwm130.fptr02        = 0     sic_bran.uwm130.bptr02 = 0   /*Item Lower Text*/
        sic_bran.uwm130.fptr03        = 0     sic_bran.uwm130.bptr03 = 0   /*Cover & Premium*/
        sic_bran.uwm130.fptr04        = 0     sic_bran.uwm130.bptr04 = 0   /*Item Endt. Text*/
        sic_bran.uwm130.fptr05        = 0     sic_bran.uwm130.bptr05 = 0.  /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = inte(wdetail.si)
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN sic_bran.uwm130.uom1_v = deci(wdetail.uom1_v)  
        sic_bran.uwm130.uom2_v    = deci(wdetail.uom2_v)  
        sic_bran.uwm130.uom5_v    = deci(wdetail.uom5_v)  
        sic_bran.uwm130.uom6_v    = 0   
        sic_bran.uwm130.uom7_v    = 0
        sic_bran.uwm130.fptr01    = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02    = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03    = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04    = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05    = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = wdetail.class    And
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do:
        IF substr(wdetail.class,1,1) = "Z" THEN
            Assign 
            sic_bran.uwm130.uom1_v     =  deci(wdetail.uom1_v)     /*stat.clastab_fil.uom1_si  1000000  */  
            sic_bran.uwm130.uom2_v     =  deci(wdetail.uom2_v)     /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     =  deci(wdetail.uom5_v)     /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  =  deci(wdetail.uom1_v)     /*deci(wdetail2.tp_bi)   */ 
            nv_uom2_v                  =  deci(wdetail.uom2_v)     /*deci(wdetail2.tp_bi2) */  
            nv_uom5_v                  =  deci(wdetail.uom5_v).     /*deci(wdetail2.tp_bi3) */ 
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
        IF (wdetail.prepol <> "") OR (substr(wdetail.class,1,1) = "Z") THEN
            ASSIGN nv_41          = deci(wdetail.nv_41) 
                   nv_412         = deci(wdetail.nv_412) 
                   nv_42          = deci(wdetail.nv_42) 
                   nv_43          = deci(wdetail.nv_43) 
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
        sic_bran.uwm301.tariff    = wdetail.tariff    
        sic_bran.uwm301.covcod    = TRIM(wdetail.covcod)
        sic_bran.uwm301.cha_no    = trim(wdetail.chassis)
        sic_bran.uwm301.trareg    = trim(nv_uwm301trareg)        
        sic_bran.uwm301.eng_no    = trim(wdetail.engno)
        sic_bran.uwm301.Tons      = DECI(wdetail.Tonn)
        sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
        sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage    = trim(wdetail.garage)
        sic_bran.uwm301.body      = trim(wdetail.body)
        sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv41seat  = wdetail.seat41
        sic_bran.uwm301.mv_ben83  = IF wdetail.poltyp = "v70" THEN trim(wdetail.benname) ELSE ""
        sic_bran.uwm301.vehreg    = substr(trim(wdetail.vehreg),1,11)     
        sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse    = wdetail.vehuse
        sic_bran.uwm301.moddes    = IF wdetail.prepol = "" THEN trim(wdetail.brand) + " " + trim(wdetail.model) 
                                    ELSE trim(trim(wdetail.brand)  + " " + trim(wdetail.model)) 
        sic_bran.uwm301.modcod    = wdetail.redbook                                    
        sic_bran.uwm301.vehgrp    = wdetail.cargrp
        sic_bran.uwm301.sckno     = 0
        sic_bran.uwm301.itmdel    = NO  
        wdetail.tariff            = sic_bran.uwm301.tariff . 
        /*sic_bran.uwm301.prmtxt    = IF wdetail.poltyp = "v70" THEN wdetail.prmtxt ELSE ""    /*nn_access.*/*/  
    FIND FIRST wacctext WHERE wacctext.n_policytxt = wdetail.policy NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wacctext THEN
        ASSIGN 
        SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  wacctext.n_textacc 
        SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  wacctext.n_textacc1
        SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  wacctext.n_textacc2
        SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  wacctext.n_textacc3
        SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  wacctext.n_textacc4
        SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  wacctext.n_textacc5
        SUBSTRING(sic_bran.uwm301.prmtxt,361,60) =  wacctext.n_textacc6
        SUBSTRING(sic_bran.uwm301.prmtxt,421,60) =  wacctext.n_textacc7
        SUBSTRING(sic_bran.uwm301.prmtxt,481,60) =  wacctext.n_textacc8
        SUBSTRING(sic_bran.uwm301.prmtxt,541,60) =  wacctext.n_textacc9.
    ELSE sic_bran.uwm301.prmtxt = "".
        
        IF wdetail.compul = "y" THEN DO:
            sic_bran.uwm301.cert = "".
            IF LENGTH(wdetail.stk) = 11 THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
            IF LENGTH(wdetail.stk) = 13  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
            IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".
            FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
                brStat.Detaitem.serailno = wdetail.stk  NO-LOCK NO-ERROR .
            IF NOT AVAIL brstat.Detaitem THEN DO:     
                CREATE brstat.Detaitem.
                ASSIGN brStat.Detaitem.Policy = sic_bran.uwm301.Policy
                    brStat.Detaitem.RenCnt    = sic_bran.uwm301.RenCnt
                    brStat.Detaitem.EndCnt    = sic_bran.uwm301.Endcnt
                    brStat.Detaitem.RiskNo    = sic_bran.uwm301.RiskNo
                    brStat.Detaitem.ItemNo    = sic_bran.uwm301.ItemNo
                    brStat.Detaitem.serailno  = wdetail.stk.  
            END.
        END.
        ASSIGN 
            sic_bran.uwm301.bchyr  = nv_batchyr      /* batch Year */
            sic_bran.uwm301.bchno  = nv_batchno      /* bchno      */
            sic_bran.uwm301.bchcnt = nv_batcnt    .  /* bchcnt     */
        s_recid4         = RECID(sic_bran.uwm301) .
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
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN  
    nv_tariff    = sic_bran.uwm301.tariff             
    nv_class     = wdetail.class 
    nv_comdat    = sic_bran.uwm100.comdat
    nv_engine    = DECI(wdetail.engcc)
    nv_tons      = deci(wdetail.tonn) 
    nv_covcod    = wdetail.covcod
    nv_vehuse    = wdetail.vehuse                     
    nv_COMPER    = deci(wdetail.comper)               
    nv_comacc    = deci(wdetail.comacc)               
    nv_seats     = INTE(wdetail.seat)   
    nv_dsspcvar1 = ""                            
    nv_dsspcvar2 = ""                           
    nv_dsspcvar  = ""                             
    nv_42cod     = ""                                
    nv_43cod     = ""                                
    nv_41cod1    = ""                                 
    nv_41cod2    = ""                               
    nv_basecod   = ""                                    
    nv_usecod    = ""                                
    nv_engcod    = ""                                  
    nv_drivcod   = ""                                          
    nv_yrcod     = ""                                          
    nv_sicod     = ""                                          
    nv_grpcod    = ""                                    
    nv_bipcod    = ""                                           
    nv_biacod    = ""                                     
    nv_pdacod    = ""                               
    nv_ncbyrs    = 0                                     
    nv_ncbper    = 0  
    nv_totsi     = 0 .  
IF wdetail.compul = "y" THEN DO:
    ASSIGN 
        nv_comper               = deci(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc               = deci(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v  = nv_comper   
        sic_bran.uwm130.uom9_v  = nv_comacc  
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

IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR 
   (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" )  THEN RUN proc_base2plus.  
ELSE RUN proc_base2.
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
      nv_pdacod  = "" .
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
ASSIGN fi_process = "Create data to uwm120 stamp tax ..." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4 c-Win 
PROCEDURE proc_chktest4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:     
  wdetail.nv_com1p     = nv_com1p70    
 wdetail.n_taxae      = nv_taxae70    
 wdetail.n_stmpae     = nv_stmpae70   
 wdetail.n_com2ae     = nv_com2ae70   
 wdetail.n_com1ae     = nv_com1ae70   
 wdetail.nv_fi_rstp_t = nv_fi_rstp_t70
 wdetail.nv_fi_rtax_t = nv_fi_rtax_t70  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4_72 c-Win 
PROCEDURE proc_chktest4_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:     
  wdetail.nv_com1p     = nv_com1p70    
 wdetail.n_taxae      = nv_taxae70    
 wdetail.n_stmpae     = nv_stmpae70   
 wdetail.n_com2ae     = nv_com2ae70   
 wdetail.n_com1ae     = nv_com1ae70   
 wdetail.nv_fi_rstp_t = nv_fi_rstp_t70
 wdetail.nv_fi_rtax_t = nv_fi_rtax_t70  
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
DEF VAR nv_fi_netprm    AS DECI INIT 0.00 .
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
     If sic_bran.uwm120.com1p <> 0  Then 
         ASSIGN nv_com1p  = sic_bran.uwm120.com1p.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create100 c-Win 
PROCEDURE proc_create100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Create  sic_bran.uwm100.    /*Create ฝั่ง gateway*/    
ASSIGN                                              
       sic_bran.uwm100.policy =  wdetail.policy                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
       sic_bran.uwm100.rencnt =  n_rencnt   
       sic_bran.uwm100.renno  =  ""       
       sic_bran.uwm100.endcnt =  n_Endcnt
       sic_bran.uwm100.bchyr  =  nv_batchyr 
       sic_bran.uwm100.bchno  =  nv_batchno 
       sic_bran.uwm100.bchcnt =  nv_batcnt     .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create70 c-Win 
PROCEDURE proc_create70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR np_ntitle AS CHAR INIT "" FORMAT "x(25)".

ASSIGN np_ntitle = "".

IF TRIM(np_comdat) = "" THEN 
    ASSIGN np_comdatday  = ""
           np_comdatmont = ""
           np_comdatyear = "".
ELSE DO:
    IF INDEX(trim(np_comdat),"/") <> 0 THEN
        ASSIGN 
        np_comdatmont = SUBSTR(trim(np_comdat),1,INDEX(trim(np_comdat),"/") - 1 )
        np_comdat     = SUBSTR(trim(np_comdat),INDEX(trim(np_comdat),"/") + 1 ).
    IF INDEX(trim(np_comdat),"/") <> 0 THEN
        ASSIGN 
        np_comdatday  = SUBSTR(trim(np_comdat),1,INDEX(trim(np_comdat),"/") - 1 )
        np_comdat     = SUBSTR(trim(np_comdat),INDEX(trim(np_comdat),"/") + 1 ).
    IF INDEX(trim(np_comdat)," ") <> 0 THEN
        ASSIGN 
        np_comdatyear = SUBSTR(trim(np_comdat),1,INDEX(trim(np_comdat)," ") - 1 ).

END.
IF trim(np_name1) <> "" THEN DO:
    FIND FIRST brstat.msgcode WHERE 
        brstat.msgcode.compno   = "999"  AND 
        index(trim(np_name1),brstat.msgcode.MsgDesc) <> 0   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN DO:   
        ASSIGN 
            np_ntitle = trim(brstat.msgcode.branch) 
            np_name1  = SUBSTR(trim(np_name1),LENGTH(brstat.msgcode.MsgDesc) + 1).
    END.
    ELSE ASSIGN np_ntitle = "คุณ".
END.
FIND FIRST wdetail WHERE wdetail.policy = "70MX" + TRIM(np_cedpol)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.policy     = "70MX" + TRIM(np_cedpol)  
        wdetail.cr_2       = trim(nn_pol72) 
        wdetail.cedpol     = TRIM(np_cedpol)
        wdetail.prepol     = trim(np_prepol)
        wdetail.opnpol     = TRIM(np_agentno)
        wdetail.finint     = caps(trim(np_fincode))
        wdetail.poltyp     = "V70"                                  
        wdetail.n_branch   = "W"                     
        wdetail.icno       = TRIM(nn_icno)
        wdetail.tiname     = np_ntitle                                   
        wdetail.insnam     = trim(np_name1)    
        wdetail.name2      = IF TRIM(nn_name2) = "" THEN "" ELSE "และ/หรือ " + TRIM(nn_name2)
        wdetail.name3      = ""
        wdetail.n_addr1    = nn_addr1                                      
        wdetail.n_addr2    = nn_addr2                       
        wdetail.n_addr3    = nn_addr3                      
        wdetail.n_addr4    = nn_addr4
        wdetail.covcod     = "1"  
        wdetail.benname    = TRIM(np_ben83)        
        wdetail.garage     = TRIM(np_garage)
        wdetail.class      = trim(np_pack) 
        wdetail.si         = trim(np_sumins)            
        wdetail.fi         = trim(np_sumins) 
        wdetail.uom1_v     = trim(np_41TPBI)              
        wdetail.uom2_v     = trim(np_42TPBI)        
        wdetail.uom5_v     = trim(np_43TPPD)                          
        wdetail.nv_41      = trim(np_41PA)  
        wdetail.nv_42      = trim(np_42PA)   
        wdetail.nv_43      = trim(np_43BAIL)   
        wdetail.vehreg     = trim(np_vehreg)  
        wdetail.brand      = IF trim(np_brand) = "" THEN "" 
                             ELSE IF INDEX(TRIM(np_brand)," ") <> 0 THEN trim(SUBSTR(TRIM(np_brand),1,INDEX(TRIM(np_brand)," "))) 
                             ELSE TRIM(np_brand)
        wdetail.model      = IF trim(np_brand) = "" THEN "" 
                             ELSE IF INDEX(TRIM(np_brand)," ") <> 0 THEN trim(SUBSTR(TRIM(np_brand),INDEX(TRIM(np_brand)," "))) 
                             ELSE TRIM(np_brand) 
        wdetail.chassis    = trim(np_chassis)
        wdetail.caryear    = trim(np_caryear)
        wdetail.firstdat   = trim(np_comdatday)  + "/" + trim(np_comdatmont)  + "/" + trim(np_comdatyear)
        wdetail.comdat     = trim(np_comdatday)  + "/" + trim(np_comdatmont)  + "/" + trim(np_comdatyear)
        wdetail.expdat     = trim(np_comdatday)  + "/" + trim(np_comdatmont)  + "/" + trim(string(deci(np_comdatyear) + 1 ,"9999"))          
        wdetail.benname    = trim(np_ben83) 
        wdetail.pass        = "y"
        wdetail.vehuse      = "1"                
        wdetail.n_rencnt    = 0 
        wdetail.n_endcnt    = 0 
        wdetail.drivnam     = "N"
        wdetail.tariff      = "X"
        wdetail.compul      = "n"
        wdetail.producer    = trim(fi_producer)
        wdetail.agent       = trim(fi_agent)
        wdetail.vatcode     = trim(fi_vatcod) .
    
    
    IF  (trim(np_F17_1) <> "" ) OR (trim(np_F17_2) <> "" ) OR 
        (trim(np_F17_3) <> "" ) OR (trim(np_F17_4) <> "" )    THEN DO:
        CREATE wacctext15.
        ASSIGN 
            wacctext15.n_policytxt15    = "70MX" + TRIM(np_cedpol)  
            wacctext15.n_textacc1       = trim(np_F17_1)  
            wacctext15.n_textacc2       = trim(np_F17_2) 
            wacctext15.n_textacc3       = trim(np_F17_3)
            wacctext15.n_textacc4       = trim(np_F17_4)  . 
    END.
    IF  (trim(np_F18_1) <> "" ) OR (trim(np_F18-2) <> "" ) OR 
        (trim(np_F18_3) <> "" ) OR (trim(np_F18_4) <> "" ) OR
        (trim(np_F18_5) <> "" )  THEN DO:
        CREATE wacctext17.
        ASSIGN 
            wacctext17.n_policytxt17 = "70MX" + TRIM(np_cedpol)     
            wacctext17.n_textacc1    = trim(np_F18_1)  
            wacctext17.n_textacc2    = trim(np_F18-2) 
            wacctext17.n_textacc3    = trim(np_F18_3)
            wacctext17.n_textacc4    = trim(np_F18_4)
            wacctext17.n_textacc5    = trim(np_F18_5) . 
    END.
     
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create72 c-Win 
PROCEDURE proc_create72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.policy = trim(nn_pol72) NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.policy     = trim(nn_pol72)       
        wdetail.cr_2       = trim(nn_pol70) 
        wdetail.cedpol     = TRIM(np_cedpol)
        wdetail.poltyp     = "V72"                                  
        wdetail.n_branch   = "W"                     
        wdetail.icno       = TRIM(nn_icno)
        wdetail.tiname     = ""                                   
        wdetail.insnam     = trim(np_name1)    
        wdetail.name2      = IF TRIM(nn_name2) = "" THEN "" ELSE "และ/หรือ " + TRIM(nn_name2)
        wdetail.name3      = ""
        wdetail.n_addr1    = nn_addr1                                      
        wdetail.n_addr2    = nn_addr2                       
        wdetail.n_addr3    = nn_addr3                      
        wdetail.n_addr4    = nn_addr4
        wdetail.covcod     = "T"  
        wdetail.benname    = ""        
        wdetail.garage     = TRIM(np_garage)
        wdetail.class      = trim(np_pack) 
        wdetail.si         = trim(np_sumins)            
        wdetail.fi         = trim(np_sumins) 
        wdetail.uom1_v     = trim(np_41TPBI)              
        wdetail.uom2_v     = trim(np_42TPBI)        
        wdetail.uom5_v     = trim(np_43TPPD)                          
        wdetail.nv_41      = trim(np_41PA)  
        wdetail.nv_42      = trim(np_42PA)   
        wdetail.nv_43      = trim(np_43BAIL)   
        wdetail.vehreg     = trim(np_vehreg)  
        wdetail.brand      = IF trim(np_brand) = "" THEN "" 
                             ELSE IF INDEX(TRIM(np_brand)," ") <> 0 THEN trim(SUBSTR(TRIM(np_brand),1,INDEX(TRIM(np_brand)," "))) 
                             ELSE TRIM(np_brand)
        wdetail.model      = IF trim(np_brand) = "" THEN "" 
                             ELSE IF INDEX(TRIM(np_brand)," ") <> 0 THEN trim(SUBSTR(TRIM(np_brand),INDEX(TRIM(np_brand)," "))) 
                             ELSE TRIM(np_brand) 
        wdetail.chassis    = trim(np_chassis)
        wdetail.caryear    = trim(np_caryear)
        wdetail.comdat     = trim(np_comdatday)  + "/" + trim(np_comdatmont)  + "/" + trim(np_comdatyear)
        wdetail.expdat     = trim(np_comdatday)  + "/" + trim(np_comdatmont)  + "/" + trim(string(deci(np_comdatyear) + 1 ,"9999"))          
        wdetail.benname    = trim(np_ben83) 
        wdetail.pass        = "y"
        wdetail.vehuse      = "1"                
        wdetail.n_rencnt    = 0 
        wdetail.n_endcnt    = 0 
        wdetail.drivnam     = "N"
        wdetail.tariff      = "9"
        wdetail.compul      = "y"
        wdetail.producer    = trim(fi_producer)
        wdetail.agent       = trim(fi_agent)
        wdetail.vatcode     = trim(fi_vatcod) .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initdata c-Win 
PROCEDURE proc_initdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    np_idno      = ""   /* "No"                      */           
    np_cedpol    = ""   /* "เลขที่ใบแจ้งงาน"         */
    np_typepol   = ""   /* "ประเภทงาน"               */
    np_status    = ""   /* "สถานะการทำประกัน"        */
    np_memo      = ""   /* "หมายเหตุ"                */
    np_remak     = ""   /* "หมายเหตุสถานะกรมธรรม์"   */
    np_name1     = ""   /* "ชื่อลูกค้า"              */
    np_sumins    = ""   /* "ทุนประกัน"               */
    np_premt     = ""   /* "เบี้ยประกันภัย"          */
    np_sendat    = ""   /* "วันที่แจ้งงาน"           */
    np_comdat    = ""   /* "วันเริ่มคุ้มครอง"        */
    np_recipdat  = ""   /* "วันที่รับงาน"            */
    np_keydat    = ""   /* "วันที่ป้อนข้อมูล"        */
    np_postdat   = ""   /* "วันที่ส่งไปรษณีย์"       */
    np_brand     = ""   /* "ยี่ห้อ"                  */
    np_vehreg    = ""   /* "ทะเบียนรถ"               */
    np_chassis   = ""   /* "เลขตัวถัง"               */
    np_caryear   = ""   /* "ปีรถ"                    */
    np_comname   = ""   /* "บริษัทประกันภัย"         */
    np_agentno   = ""   /* "รหัสตัวแทน"              */
    np_agenname  = ""   /* "ชื่อตัวแทน"              */
    np_AEname    = ""   /* "ชื่อ AE"                 */
    nn_address   = ""   
    nn_icno      = ""   
    nn_pol70     = ""   /* "เลขกรมธรรม์70"           */     
    nn_pol72     = ""   /* "เลขกรมธรรม์72"           */     
    nn_name2     = ""   /* "และ/หรือ"                */     
    np_garage    = ""   /* "Garage(ซ่อมอู่-ห้าง)"    */     
    np_pack      = ""   /* "Package"                 */     
    np_41TPBI    = ""   /* "TPBI/Person"             */     
    np_42TPBI    = ""   /* "TPBI/Per Acciden"        */     
    np_43TPPD    = ""   /* "TPPD/Per Acciden"        */     
    np_41PA      = ""   /*  "41 PA. 1 FOR DRIVER"     */    
    np_42PA      = ""   /*  "42 PA. 2 MEDICAL EXPENSE"*/    
    np_43BAIL    = ""   /*  "43 BAIL BOND"            */    
    np_ben83     = ""   /*  "8.3 Benname"             */    
    np_F17_1     = ""   /*  "F17-1 "                  */    
    np_F17_2     = ""   /*  "F17-2 "                  */    
    np_F17_3     = ""   /*  "F17-3 "                  */    
    np_F17_4     = ""   /*  "F17-4 "                  */    
    np_F18_1     = ""   /*  "F18-1 "                  */    
    np_F18-2     = ""   /*  "F18-2 "                  */    
    np_F18_3     = ""   /*  "F18-3 "                  */    
    np_F18_4     = ""   /*  "F18-4 "                  */    
    np_F18_5     = ""   /*  "F18-5 "                  */  
    np_comdatday  = ""
    np_comdatmont = ""
    np_comdatyear = ""  
    np_prepol     = "" 
    np_fincode    = "" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam c-Win 
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
    nv_typ        = ""
    nv_usrid      = SUBSTRING(USERID(LDBNAME(1)),3,4) 
    nv_transfer   = YES.
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME     = TRIM(wdetail.insnam)   AND 
    sicsyac.xmm600.homebr   = trim(wdetail.n_branch) AND 
    sicsyac.xmm600.clicod   = "IN"                   NO-ERROR NO-WAIT.   
IF NOT AVAILABLE sicsyac.xmm600 THEN DO: 
    IF LOCKED sicsyac.xmm600 THEN DO:   
        ASSIGN nv_transfer = NO 
            n_insref    = sicsyac.xmm600.acno.
        RETURN.
    END.
    ELSE DO:
        ASSIGN  n_check   = "" 
            nv_insref     = "".
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
            ASSIGN 
                wdetail.pass    = "N"  
                wdetail.comment = wdetail.comment + "| รหัสลูกค้าเป็นค่าว่างไม่สามารถนำเข้าระบบได้ค่ะ" 
                WDETAIL.OK_GEN  = "N"
                nv_transfer = NO.
        END.    /**/
    END.
    n_insref = nv_insref.
END.
ELSE DO:
    IF sicsyac.xmm600.acno <> "" THEN DO:   /* กรณีพบ */
       /* MESSAGE     wdetail.tiname    trim(sicsyac.xmm600.ntitle)
                    wdetail.insnam   trim(sicsyac.xmm600.name)
                    wdetail.nv_icno  TRIM(sicsyac.xmm600.icno)    
                    wdetail.n_addr1  trim(sicsyac.xmm600.addr1)
                    wdetail.n_addr2  trim(sicsyac.xmm600.addr2)
                    wdetail.n_addr3  trim(sicsyac.xmm600.addr3)
                    wdetail.n_addr4  trim(sicsyac.xmm600.addr4) 
            VIEW-AS ALERT-BOX. */
        ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            n_insref                = caps(trim(nv_insref)) 
            nv_transfer             = NO 
            /*wdetail.tiname          = trim(sicsyac.xmm600.ntitle)
            wdetail.insnam          = trim(sicsyac.xmm600.name)
            wdetail.icno            = IF  TRIM(sicsyac.xmm600.icno) <> "" THEN   TRIM(sicsyac.xmm600.icno) ELSE wdetail.icno 
            wdetail.n_addr1         = trim(sicsyac.xmm600.addr1)
            wdetail.n_addr2         = trim(sicsyac.xmm600.addr2)
            wdetail.n_addr3         = trim(sicsyac.xmm600.addr3)
            wdetail.n_addr4         = trim(sicsyac.xmm600.addr4)*/
            sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)    /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname    = ""                      /*First Name*/
            sicsyac.xmm600.name     = TRIM(wdetail.insnam)    /*Name Line 1*/
            sicsyac.xmm600.abname   = TRIM(wdetail.insnam)    /*Abbreviated Name*/
            sicsyac.xmm600.icno     = IF TRIM(sicsyac.xmm600.icno) <> "" THEN TRIM(sicsyac.xmm600.icno) ELSE TRIM(wdetail.ICNO)      /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1    = trim(wdetail.n_addr1)   /*Address line 1*/
            sicsyac.xmm600.addr2    = trim(wdetail.n_addr2)   /*Address line 2*/
            sicsyac.xmm600.addr3    = trim(wdetail.n_addr3)   /*Address line 3*/
            sicsyac.xmm600.addr4    = trim(wdetail.n_addr4)   
              
            sicsyac.xmm600.homebr   = trim(wdetail.n_branch)    /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                   
            sicsyac.xmm600.chgpol   = YES                     /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                   /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS") /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            /*sicsyac.xmm600.dtyp20   = IF wdetail.birthdat = "" THEN "" ELSE "DOB"
            sicsyac.xmm600.dval20   = IF wdetail.birthdat = "" THEN ""
                                      ELSE substr(TRIM(wdetail.birthdat),1,6) +
                                      STRING(deci(substr(TRIM(wdetail.birthdat),7,4)) + 543 ) */     /*-- Add chutikarn A50-0072 --*/
            sicsyac.xmm600.anlyc5   =  ""          
            sicsyac.xmm600.dtyp20   =  "" 
            sicsyac.xmm600.dval20   =  "" . 
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
        sicsyac.xmm600.ntitle   = trim(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                        /*First Name*/
        sicsyac.xmm600.name     = trim(wdetail.insnam)      /*Name Line 1*/
        sicsyac.xmm600.abname   = trim(wdetail.insnam)      /*Abbreviated Name*/
        wdetail.icno            = IF  TRIM(sicsyac.xmm600.icno) <> "" THEN   TRIM(sicsyac.xmm600.icno) ELSE wdetail.icno     
        wdetail.n_addr1         = trim(sicsyac.xmm600.addr1)     
        wdetail.n_addr2         = trim(sicsyac.xmm600.addr2)     
        wdetail.n_addr3         = trim(sicsyac.xmm600.addr3)     
        wdetail.n_addr4         = trim(sicsyac.xmm600.addr4)   
        sicsyac.xmm600.icno     = IF TRIM(sicsyac.xmm600.icno) <> "" THEN TRIM(sicsyac.xmm600.icno) ELSE TRIM(wdetail.ICNO)        /*IC No.*/     /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    =  trim(wdetail.n_addr1)    /*Address line 1*/
        sicsyac.xmm600.addr2    =  trim(wdetail.n_addr2)    /*Address line 2*/
        sicsyac.xmm600.addr3    =  trim(wdetail.n_addr3)    /*Address line 3*/
        sicsyac.xmm600.addr4    =  trim(wdetail.n_addr4)    /*Address line 4*/
        sicsyac.xmm600.postcd   = ""                        /*Postal Code*/
        sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
        sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
        sicsyac.xmm600.homebr   = trim(wdetail.n_branch)    /*Home branch*/
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
        sicsyac.xmm600.anlyc5   =  ""          
        sicsyac.xmm600.dtyp20   =  "" 
        sicsyac.xmm600.dval20   =  "" .     
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
        END.
    END.
    IF nv_transfer = YES THEN DO:
        ASSIGN
            sicsyac.xtm600.acno    = nv_insref              /*Account no.*/
            sicsyac.xtm600.name    = trim(wdetail.insnam)   /*Name of Insured Line 1*/
            sicsyac.xtm600.abname  = trim(wdetail.insnam)   /*Abbreviated Name*/
            sicsyac.xtm600.addr1   = trim(wdetail.n_addr1)  /*address line 1*/
            sicsyac.xtm600.addr2   = trim(wdetail.n_addr2)  /*address line 2*/
            sicsyac.xtm600.addr3   = trim(wdetail.n_addr3)  /*address line 3*/
            sicsyac.xtm600.addr4   = trim(wdetail.n_addr4)  /*address line 4*/
            sicsyac.xtm600.name2   = ""                     /*Name of Insured Line 2*/ 
            sicsyac.xtm600.ntitle  = trim(wdetail.tiname)   /*Title*/
            sicsyac.xtm600.name3   = ""                     /*Name of Insured Line 3*/
            sicsyac.xtm600.fname   = "" .                   /*First Name*/
    END.
END.
ASSIGN  wdetail.inserf = nv_insref .
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.

RETURN.
HIDE MESSAGE NO-PAUSE.

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
DEF VAR nv_lastno  AS INT INIT 0. 
DEF VAR nv_seqno   AS INT INIT 0.  
ASSIGN  nv_insref = "" .
FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
    sicsyac.xzm056.seqtyp   =  nv_typ                 AND
    sicsyac.xzm056.branch   =  TRIM(wdetail.n_branch) NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN sicsyac.xzm056.seqtyp =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.n_branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref = TRIM(wdetail.n_branch)  + String(1,"999999")
            nv_lastno = 1.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(TRIM(wdetail.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail.n_branch) + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.n_branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(TRIM(wdetail.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       TRIM(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").
        END.   
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.n_branch)
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(TRIM(wdetail.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").*/
            /*Add ... A56-0318*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
    END.
    ELSE DO:
        IF LENGTH(TRIM(wdetail.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       TRIM(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno,"99999").
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
                sicsyac.xzm056.branch    =  TRIM(wdetail.n_branch)
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
                sicsyac.xzm056.branch    =  TRIM(wdetail.n_branch)
                sicsyac.xzm056.des       =  "Company/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno. 
        END.
    END.
END.        /*lastno <= seqno */  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matfileLoad c-Win 
PROCEDURE proc_matfileLoad :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each  wdetailfile.
    DELETE  wdetailfile.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "|" 
        np_idno        /* "No"                    */           
        np_cedpol      /* "เลขที่ใบแจ้งงาน"       */
        np_typepol     /* "ประเภทงาน"             */
        np_status      /* "สถานะการทำประกัน"      */
        np_memo        /* "หมายเหตุ"              */
        np_remak       /* "หมายเหตุสถานะกรมธรรม์" */
        np_name1       /* "ชื่อลูกค้า"            */
        np_sumins      /* "ทุนประกัน"             */
        np_premt       /* "เบี้ยประกันภัย"        */
        np_sendat      /* "วันที่แจ้งงาน"         */
        np_comdat      /* "วันเริ่มคุ้มครอง"      */
        np_recipdat    /* "วันที่รับงาน"          */
        np_keydat      /* "วันที่ป้อนข้อมูล"      */
        np_postdat     /* "วันที่ส่งไปรษณีย์"     */
        np_brand       /* "ยี่ห้อ"                */
        np_vehreg      /* "ทะเบียนรถ"             */
        np_chassis     /* "เลขตัวถัง"             */
        np_caryear     /* "ปีรถ"                  */
        np_comname     /* "บริษัทประกันภัย"       */
        np_agentno     /* "รหัสตัวแทน"            */
        np_agenname    /* "ชื่อตัวแทน"            */
        np_AEname      /* "ชื่อ AE"               */
        nn_address
        nn_icno   .
    IF            TRIM(np_idno)       = "" THEN RUN proc_initdata.
    ELSE IF index(TRIM(np_idno),"NO") <> 0 THEN RUN proc_initdata.
    ELSE DO:
        CREATE wdetailfile.
        ASSIGN 
            wdetailfile.np_idno        =      np_idno    
            wdetailfile.np_cedpol      =      np_cedpol  
            wdetailfile.np_typepol     =      np_typepol 
            wdetailfile.np_status      =      np_status  
            wdetailfile.np_memo        =      np_memo    
            wdetailfile.np_remak       =      np_remak   
            wdetailfile.np_name1       =      np_name1   
            wdetailfile.np_sumins      =      np_sumins  
            wdetailfile.np_premt       =      np_premt   
            wdetailfile.np_sendat      =      np_sendat  
            wdetailfile.np_comdat      =      np_comdat  
            wdetailfile.np_recipdat    =      np_recipdat
            wdetailfile.np_keydat      =      np_keydat  
            wdetailfile.np_postdat     =      np_postdat 
            wdetailfile.np_brand       =      np_brand   
            wdetailfile.np_vehreg      =      np_vehreg  
            wdetailfile.np_chassis     =      np_chassis 
            wdetailfile.np_caryear     =      np_caryear 
            wdetailfile.np_comname     =      np_comname 
            wdetailfile.np_agentno     =      np_agentno 
            wdetailfile.np_agenname    =      np_agenname
            wdetailfile.np_AEname      =      np_AEname 
            wdetailfile.nn_address     =      nn_address
            wdetailfile.nn_icno        =      nn_icno  . 
        RUN proc_initdata.             
    END.
END.  /* repeat   */      
RUN proc_matfileloadexp.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matfileloadexp c-Win 
PROCEDURE proc_matfileloadexp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF VAR nv_accdat   AS DATE   FORMAT "99/99/9999" NO-UNDO.
DEF VAR nv_comdat   AS DATE   FORMAT "99/99/9999" NO-UNDO.
DEF VAR nv_expdat   AS DATE   FORMAT "99/99/9999" NO-UNDO.
DEF VAR nv_comchr   AS CHAR . 
DEF VAR nv_dd       AS INT    FORMAT "99".
DEF VAR nv_mm       AS INT    FORMAT "99".
DEF VAR nv_yy       AS INT    FORMAT "9999".
DEF VAR nv_cpamt1   AS DECI   INIT 0.
DEF VAR nv_cpamt2   AS DECI   INIT 0.
DEF VAR nv_cpamt3   AS DECI   INIT 0.
DEF VAR nv_insamt1  AS DECI   INIT 0.
DEF VAR nv_insamt2  AS DECI   INIT 0.
DEF VAR nv_insamt3  AS DECI   INIT 0.
DEF VAR nv_premt1   AS DECI   INIT 0.
DEF VAR nv_premt2   AS DECI   INIT 0.
DEF VAR nv_premt3   AS DECI   INIT 0.
DEF VAR nv_name1    AS CHAR   INIT ""   Format "X(30)".
DEF VAR nv_ntitle   AS CHAR   INIT ""   Format  "X(10)". 
DEF VAR nv_titleno  AS INT    INIT 0.
DEF VAR nv_policy   AS CHAR   INIT ""   Format  "X(12)".
def var nv_source   as char   format    "X(35)".
def var nv_indexno  as int    init 0.
def var nv_indexno1 as int    init 0.
def var nv_cnt      as int    init 0.
def var nv_addr     as char   extent 4  format "X(35)".
def var nv_prem     as char   init "".
def VAR nv_file     as char   init "d:\fileload\return.txt".
def var nv_row      as int    init 0.
DEF VAR nv_title    AS CHAR INIT "" FORMAT "X(70)". 
DEF VAR nv_name     AS CHAR INIT "" FORMAT "X(40)".
DEF VAR nv_sname    AS CHAR INIT "" FORMAT "X(40)".*/
def var nv_cnt      as int    init 0.
def var nv_row      as int    init 0.
If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1 =  Trim(fi_output1) + ".slk"  .
nv_cnt   =   0.
nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.

PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "No"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "เลขที่ใบแจ้งงาน"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "ประเภทงาน"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "สถานะการทำประกัน"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "หมายเหตุ"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "หมายเหตุสถานะกรมธรรม์" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "ชื่อลูกค้า"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "ทุนประกัน"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "เบี้ยประกันภัย"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "วันที่แจ้งงาน"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "วันเริ่มคุ้มครอง"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "วันที่รับงาน"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "วันที่ป้อนข้อมูล"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "วันที่ส่งไปรษณีย์"     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "ยี่ห้อ"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "ทะเบียนรถ"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "เลขตัวถัง"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "ปีรถ"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "บริษัทประกันภัย"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "รหัสตัวแทน"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "ชื่อตัวแทน"            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "ชื่อ AE"               '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "ที่อยู่"               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Idno. "                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "กรมธรรม์เดิม"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "และ/หรือ"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Garage"                '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Fin.int.Code"          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "pack "                 '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "TPBI/Person"           '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "TPBI/Per Acciden"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "TPPD/Per Acciden"      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "41 PA. 1"              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "42  PA. 2"             '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "43   BAIL BOND"        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "8.3"                   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "F17-1"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "F17-2"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "F17-3"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "F17-4"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "F18-1"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "F18-2"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "F18-3"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "F18-4"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "F18-5"                 '"' SKIP. 

FOR EACH wdetailfile  NO-LOCK.
    ASSIGN 
        nv_cnt      =  nv_cnt  + 1 
        nv_row      =  nv_row + 1  
        np_chassis  = "" 
        np_prepol   = "" 
        nv_uwm301trareg = ""
        np_chassis  = wdetailfile.np_chassis .
    IF np_chassis <> "" THEN DO:
        RUN proc_chassicmat.
        FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE
            sicuw.uwm301.trareg             = trim(nv_uwm301trareg)  AND 
            substr(sicuw.uwm301.policy,3,2) = "70"                   NO-LOCK NO-ERROR NO-WAIT .
        IF AVAIL sicuw.uwm301 THEN np_prepol =  sicuw.uwm301.policy.
        ELSE np_prepol = "".
    END.
    ELSE np_prepol = "".
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetailfile.np_idno         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetailfile.np_cedpol       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetailfile.np_typepol      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetailfile.np_status       '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetailfile.np_memo         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetailfile.np_remak        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetailfile.np_name1        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetailfile.np_sumins       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetailfile.np_premt        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'  wdetailfile.np_sendat       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'  wdetailfile.np_comdat       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'  wdetailfile.np_recipdat     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'  wdetailfile.np_keydat       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'  wdetailfile.np_postdat      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'  wdetailfile.np_brand        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'  wdetailfile.np_vehreg       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'  wdetailfile.np_chassis      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'  wdetailfile.np_caryear      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'  wdetailfile.np_comname      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'  wdetailfile.np_agentno      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'  wdetailfile.np_agenname     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'  wdetailfile.np_AEname       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'  wdetailfile.nn_address      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'  wdetailfile.nn_icno         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'  np_prepol                   '"' SKIP.
End.   

PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.

message "Export File  Complete"  view-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matfilePol c-Win 
PROCEDURE proc_matfilePol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each  wdetailfile.
    DELETE  wdetailfile.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "|" 
        np_idno      
        np_cedpol    
        np_typepol   
        np_status    
        np_memo      
        np_remak     
        np_name1     
        np_sumins    
        np_premt     
        np_sendat    
        np_comdat    
        np_recipdat  
        np_keydat    
        np_postdat   
        np_brand     
        np_vehreg    
        np_chassis   
        np_caryear   
        np_comname   
        np_agentno   
        np_agenname  
        np_AEname    
        nn_address   
        nn_icno    
        np_prepol
        nn_name2  
        np_garage
        np_fincode
        np_pack  
        np_41TPBI
        np_42TPBI
        np_43TPPD
        np_41PA  
        np_42PA  
        np_43BAIL
        np_ben83 
        np_F17_1 
        np_F17_2 
        np_F17_3 
        np_F17_4 
        np_F18_1 
        np_F18-2 
        np_F18_3 
        np_F18_4 
        np_F18_5 .
    IF            TRIM(np_idno)       = "" THEN RUN proc_initdata.
    ELSE IF index(TRIM(np_idno),"NO") <> 0 THEN RUN proc_initdata.
    ELSE DO:
        CREATE wdetailfile.
        ASSIGN 
            wdetailfile.np_idno     =  np_idno    
            wdetailfile.np_cedpol   =  np_cedpol  
            wdetailfile.np_typepol  =  np_typepol 
            wdetailfile.np_status   =  np_status  
            wdetailfile.np_memo     =  np_memo    
            wdetailfile.np_remak    =  np_remak   
            wdetailfile.np_name1    =  np_name1   
            wdetailfile.np_sumins   =  np_sumins  
            wdetailfile.np_premt    =  np_premt   
            wdetailfile.np_sendat   =  np_sendat  
            wdetailfile.np_comdat   =  np_comdat  
            wdetailfile.np_recipdat =  np_recipdat
            wdetailfile.np_keydat   =  np_keydat  
            wdetailfile.np_postdat  =  np_postdat 
            wdetailfile.np_brand    =  np_brand   
            wdetailfile.np_vehreg   =  np_vehreg  
            wdetailfile.np_chassis  =  np_chassis 
            wdetailfile.np_caryear  =  np_caryear 
            wdetailfile.np_comname  =  np_comname 
            wdetailfile.np_agentno  =  np_agentno 
            wdetailfile.np_agenname =  np_agenname
            wdetailfile.np_AEname   =  np_AEname 
            wdetailfile.nn_address  =  nn_address
            wdetailfile.nn_icno     =  nn_icno   
            wdetailfile.np_prepol   =  np_prepol
            wdetailfile.nn_name2    =  nn_name2  
            wdetailfile.np_garage   =  np_garage
            wdetailfile.np_fincode  =  np_fincode
            wdetailfile.np_pack     =  np_pack  
            wdetailfile.np_41TPBI   =  np_41TPBI
            wdetailfile.np_42TPBI   =  np_42TPBI
            wdetailfile.np_43TPPD   =  np_43TPPD
            wdetailfile.np_41PA     =  np_41PA  
            wdetailfile.np_42PA     =  np_42PA  
            wdetailfile.np_43BAIL   =  np_43BAIL
            wdetailfile.np_ben83    =  np_ben83 
            wdetailfile.np_F17_1    =  np_F17_1 
            wdetailfile.np_F17_2    =  np_F17_2 
            wdetailfile.np_F17_3    =  np_F17_3 
            wdetailfile.np_F17_4    =  np_F17_4 
            wdetailfile.np_F18_1    =  np_F18_1 
            wdetailfile.np_F18-2    =  np_F18-2 
            wdetailfile.np_F18_3    =  np_F18_3 
            wdetailfile.np_F18_4    =  np_F18_4 
            wdetailfile.np_F18_5    =  np_F18_5 .
        RUN proc_initdata.             
    END.
END.  /* repeat   */      
RUN proc_matfilePolexp.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matfilePolexp c-Win 
PROCEDURE proc_matfilePolexp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
def var nv_cnt      as int    init 0.
def var nv_row      as int    init 0.
If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1 =  Trim(fi_output1) + ".slk"  .
nv_cnt   =   0.
nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.

PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "No                   "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "เลขที่ใบแจ้งงาน      "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "ประเภทงาน            "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "สถานะการทำประกัน     "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "หมายเหตุ             "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "หมายเหตุสถานะกรมธรรม์"     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "ชื่อลูกค้า           "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "ทุนประกัน            "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "เบี้ยประกันภัย       "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "วันที่แจ้งงาน        "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "วันเริ่มคุ้มครอง     "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "วันที่รับงาน         "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "วันที่ป้อนข้อมูล     "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "วันที่ส่งไปรษณีย์    "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "ยี่ห้อ               "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "ทะเบียนรถ            "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "เลขตัวถัง            "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "ปีรถ                 "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "บริษัทประกันภัย      "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "รหัสตัวแทน           "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "ชื่อตัวแทน           "     '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "ชื่อ AE              "     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "ที่อยู่              "     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Idno.                "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "กรมธรรม์เดิม         "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "กรมธรรม์ใหม่         "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "และ/หรือ             "     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Garage               "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Fin.int.Code"              '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "pack "                     '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "TPBI/Person"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "TPBI/Per Acciden"          '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "TPPD/Per Acciden"          '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "41 PA. 1"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "42  PA. 2"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "43   BAIL BOND"            '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "8.3"                       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "F17-1"                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "F17-2"                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "F17-3"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "F17-4"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "F18-1"                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "F18-2"                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "F18-3"                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "F18-4"                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "F18-5"                     '"' SKIP.       
FOR EACH wdetailfile  NO-LOCK.                      
    ASSIGN 
        np_polnew   = ""
        nv_cnt      =  nv_cnt  + 1 
        nv_row      =  nv_row + 1  .

    IF wdetailfile.np_cedpol <> "" THEN DO:

        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE
          sicuw.uwm100.cedpol   =  wdetailfile.np_cedpol   AND 
          sicuw.uwm100.poltyp   =  "V70"                   NO-LOCK NO-ERROR NO-WAIT .
        IF AVAIL sicuw.uwm100 THEN np_polnew =  sicuw.uwm100.policy.
        ELSE np_polnew = "".
    END.
    ELSE np_prepol = "".
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetailfile.np_idno       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetailfile.np_cedpol     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetailfile.np_typepol    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetailfile.np_status     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetailfile.np_memo       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetailfile.np_remak      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetailfile.np_name1      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetailfile.np_sumins     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetailfile.np_premt      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'  wdetailfile.np_sendat     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'  wdetailfile.np_comdat     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'  wdetailfile.np_recipdat   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'  wdetailfile.np_keydat     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'  wdetailfile.np_postdat    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'  wdetailfile.np_brand      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'  wdetailfile.np_vehreg     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'  wdetailfile.np_chassis    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'  wdetailfile.np_caryear    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'  wdetailfile.np_comname    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'  wdetailfile.np_agentno    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'  wdetailfile.np_agenname   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'  wdetailfile.np_AEname     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'  wdetailfile.nn_address    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'  wdetailfile.nn_icno       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'  wdetailfile.np_prepol     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'  np_polnew                 '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'  wdetailfile.nn_name2      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'  wdetailfile.np_garage     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'  wdetailfile.np_fincode    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'  wdetailfile.np_pack       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'  wdetailfile.np_41TPBI     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'  wdetailfile.np_42TPBI     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'  wdetailfile.np_43TPPD     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'  wdetailfile.np_41PA       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'  wdetailfile.np_42PA       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'  wdetailfile.np_43BAIL     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'  wdetailfile.np_ben83      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'  wdetailfile.np_F17_1      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'  wdetailfile.np_F17_2      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'  wdetailfile.np_F17_3      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'  wdetailfile.np_F17_4      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'  wdetailfile.np_F18_1      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'  wdetailfile.np_F18-2      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'  wdetailfile.np_F18_3      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'  wdetailfile.np_F18_4      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'  wdetailfile.np_F18_5      '"' SKIP.
End.   

PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.

message "Export File Match Policy  Complete"  view-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open c-Win 
PROCEDURE proc_open :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y".

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
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
ASSIGN fi_process = "Create data to uwm100..." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
IF wdetail.policy <> "" THEN DO:
    ASSIGN wdetail.stk = "".
    IF wdetail.stk  <>  ""  THEN DO: 
        ASSIGN stklen = 0
            stklen    = INDEX(trim(wdetail.stk)," ") - 1.
        IF (SUBSTRING(wdetail.stk,1,1) = "2") AND (wdetail.poltyp = "v72") THEN DO: 
            IF stklen > 1 THEN wdetail.stk = "0" + substr(wdetail.stk,1,stklen).
            ELSE wdetail.stk = "0" + substr(wdetail.stk,1,LENGTH(wdetail.stk)).
        END.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN  wdetail.pass = "N"
            wdetail.comment      = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".

        FIND LAST sicuw.uwm100  USE-INDEX uwm10002   WHERE
            sicuw.uwm100.cedpol  = wdetail.cedpol    AND
            sicuw.uwm100.poltyp  =  "V70"            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ( sicuw.uwm100.expdat > DATE(wdetail.comdat) )    THEN 
                ASSIGN 
                wdetail.pass     = "N"
                wdetail.comment  = wdetail.comment + "| พบเลขที่สัญญานี้ได้ถูกใช้ไปแล้ว " + sicuw.uwm100.policy 
                wdetail.warning  = "Program Running Policy No. ให้ชั่วคราว".
        END.
        ASSIGN  nv_newsck = " " .
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk .
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass = "N"
            wdetail.comment      = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning      = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            ASSIGN wdetail.policy  = nv_tmppol.
        END.
        ELSE RUN proc_create100 .
    END.       /*wdetail.stk  <>  ""*/
    ELSE DO:   /*sticker = ""*/ 

        FIND LAST sicuw.uwm100  USE-INDEX uwm10002   WHERE
            sicuw.uwm100.cedpol  = wdetail.cedpol    AND
            sicuw.uwm100.poltyp  =  "V70"            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ( sicuw.uwm100.expdat > DATE(wdetail.comdat))    THEN 
                ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| พบเลขที่สัญญานี้ได้ถูกใช้ไปแล้ว " + sicuw.uwm100.policy 
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            IF wdetail.policy = "" THEN DO:
                RUN proc_temppolicy.
                ASSIGN wdetail.policy  = nv_tmppol.
            END.
            ELSE RUN proc_create100. 
        END.
        ELSE RUN proc_create100.   
    END.
END.
ELSE DO:     /*wdetail.policy = ""*/
    IF wdetail.stk  <>  ""  THEN DO:
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".

        FIND LAST sicuw.uwm100  USE-INDEX uwm10002   WHERE
            sicuw.uwm100.cedpol  = wdetail.cedpol    AND
            sicuw.uwm100.poltyp  =  "V70"            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ( sicuw.uwm100.expdat > DATE(wdetail.comdat))   THEN 
                ASSIGN 
                wdetail.pass     = "N"
                wdetail.comment  = wdetail.comment + "| พบเลขที่สัญญานี้ได้ถูกใช้ไปแล้ว " + sicuw.uwm100.policy 
                wdetail.warning  = "Program Running Policy No. ให้ชั่วคราว".
        END.
        ASSIGN nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk      NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass = "N"
            wdetail.comment      = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning      = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            ASSIGN wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.       /*wdetail.stk  <>  ""*/
    ELSE DO:  /*policy = "" and comp_sck = ""  */       
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            ASSIGN wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.
END.
ASSIGN  s_recid1  =  Recid(sic_bran.uwm100).
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = wdetail.poltyp  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL  sicsyac.xmm031 THEN DO:
    nv_dept = sicsyac.xmm031.dept.
END.
/*IF TRIM(wdetail.inserf) = "" THEN */
RUN proc_insnam.
IF wdetail.poltyp = "V70"  AND wdetail.Docno <> ""  THEN 
    ASSIGN nv_docno = wdetail.Docno
    nv_accdat       = TODAY.
ELSE DO:
        IF wdetail.docno  = "" THEN nv_docno  = "".
        IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
DO TRANSACTION:                                                                        
    ASSIGN                                                                             
        sic_bran.uwm100.renno  = ""                                                      
        sic_bran.uwm100.endno  = ""                                                      
        sic_bran.uwm100.poltyp = caps(trim(wdetail.poltyp))                                          
        sic_bran.uwm100.insref = caps(TRIM(wdetail.inserf))                                             
        sic_bran.uwm100.opnpol = trim(wdetail.opnpol)              /*Prom. */
        sic_bran.uwm100.anam2  = trim(wdetail.icno)             
        sic_bran.uwm100.ntitle = trim(wdetail.tiname)        
        sic_bran.uwm100.name1  = trim(wdetail.insnam)        
        sic_bran.uwm100.name2  = trim(wdetail.name2)                                     
        sic_bran.uwm100.name3  = trim(wdetail.name3)        
        sic_bran.uwm100.addr1  = trim(wdetail.n_addr1)             
        sic_bran.uwm100.addr2  = trim(wdetail.n_addr2)      
        sic_bran.uwm100.addr3  = trim(wdetail.n_addr3)      
        sic_bran.uwm100.addr4  = trim(wdetail.n_addr4)      
        sic_bran.uwm100.postcd = ""                          
        sic_bran.uwm100.undyr  = String(Year(today),"9999")     /*   nv_undyr  */
        sic_bran.uwm100.branch = caps(trim(wdetail.n_branch))   /*trim(wdetail.n_branch)*//* nv_branch  */                        
        sic_bran.uwm100.dept   = nv_dept                        
        sic_bran.uwm100.usrid  = USERID(LDBNAME(1))             
        sic_bran.uwm100.fstdat = DATE(wdetail.firstdat)           /*DATE(wdetail.comdat) ให้ firstdate*/
        sic_bran.uwm100.comdat = DATE(wdetail.comdat)           
        sic_bran.uwm100.expdat = DATE(wdetail.expdat)           
        sic_bran.uwm100.accdat = nv_accdat                      
        sic_bran.uwm100.tranty = "N"                            /*Transaction Type (N/R/E/C/T)*/
        sic_bran.uwm100.langug = "T"                            
        sic_bran.uwm100.acctim = "00:00"                        
        sic_bran.uwm100.trty11 = "M"                            
        sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")     
        sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")        
        sic_bran.uwm100.entdat = TODAY                          
        sic_bran.uwm100.curbil = "BHT"                          
        sic_bran.uwm100.curate = 1                              
        sic_bran.uwm100.instot = 1                              
        sic_bran.uwm100.prog   = "wgwtmaxi"                     
        sic_bran.uwm100.cntry  = "TH"                           /*Country where risk is situated*/
        sic_bran.uwm100.insddr = YES                            /*Print Insd. Name on DrN       */
        sic_bran.uwm100.no_sch = 0                              /*No. to print, Schedule        */
        sic_bran.uwm100.no_dr  = 1                              /*No. to print, Dr/Cr Note      */
        sic_bran.uwm100.no_ri  = 0                              /*No. to print, RI Appln        */
        sic_bran.uwm100.no_cer = 0                              /*No. to print, Certificate     */
        sic_bran.uwm100.li_sch = YES                            /*Print Later/Imm., Schedule    */
        sic_bran.uwm100.li_dr  = YES                            /*Print Later/Imm., Dr/Cr Note  */
        sic_bran.uwm100.li_ri  = YES                            /*Print Later/Imm., RI Appln,   */
        sic_bran.uwm100.li_cer = YES                            /*Print Later/Imm., Certificate */
        sic_bran.uwm100.apptax = YES                            /*Apply risk level tax (Y/N)    */
        sic_bran.uwm100.recip  = "N"                            /*Reciprocal (Y/N/C)            */
        sic_bran.uwm100.short  = NO                             
        sic_bran.uwm100.acno1  = caps(trim(wdetail.producer))   /*nv_acno1 */
        sic_bran.uwm100.agent  = caps(trim(wdetail.agent))      /*nv_agent */
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
        sic_bran.uwm100.dir_ri = YES
        sic_bran.uwm100.drn_p  = NO
        sic_bran.uwm100.sch_p  = NO
        sic_bran.uwm100.cr_2   = caps(trim(wdetail.cr_2))
        sic_bran.uwm100.bchyr  = nv_batchyr              /*Batch Year */  
        sic_bran.uwm100.bchno  = nv_batchno              /*Batch No.  */  
        sic_bran.uwm100.bchcnt = nv_batcnt               /*Batch Count*/  
        sic_bran.uwm100.prvpol = caps(trim(wdetail.prepol))   
        sic_bran.uwm100.cedpol = trim(wdetail.cedpol)  
        sic_bran.uwm100.finint = wdetail.finint
        sic_bran.uwm100.bs_cd  = caps(trim(wdetail.vatcode))  . 
    IF wdetail.prepol <> " " THEN DO:
        IF wdetail.poltyp = "v72"  THEN 
            ASSIGN sic_bran.uwm100.prvpol  = ""
            sic_bran.uwm100.tranty  = "R".  
        ELSE 
            ASSIGN
                sic_bran.uwm100.prvpol  = caps(trim(wdetail.prepol))     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                sic_bran.uwm100.tranty  = "R".                           /*Transaction Type (N/R/E/C/T)*/
    END.
    IF wdetail.pass = "Y" THEN sic_bran.uwm100.impflg  = YES.
    ELSE sic_bran.uwm100.impflg  = NO.
    IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN  sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
    IF wdetail.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
    ELSE  sic_bran.uwm100.polsta = "IF".
    IF fi_loaddat <> ? THEN sic_bran.uwm100.trndat = fi_loaddat.
    ELSE sic_bran.uwm100.trndat = TODAY.

    ASSIGN 
        sic_bran.uwm100.issdat = sic_bran.uwm100.trndat
        nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                          (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                          (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                      ELSE (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1 .   
END.     /*transaction*//**/
IF wdetail.poltyp = "v70" THEN DO:
    RUN proc_uwd100_1.   /*by file */
    RUN proc_uwd102_1.
END.

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
    RUN wgw/wgwad120 (INPUT  sic_bran.uwm100.policy,  
                             sic_bran.uwm100.rencnt,
                             sic_bran.uwm100.endcnt,
                             s_riskgp,
                             s_riskno,
                      OUTPUT s_recid2).
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
        sic_bran.uwm120.bchyr  = nv_batchyr    /* batch Year */
        sic_bran.uwm120.bchno  = nv_batchno    /* bchno      */
        sic_bran.uwm120.bchcnt = nv_batcnt .   /* bchcnt     */
    ASSIGN
        sic_bran.uwm120.class  = wdetail.class 
        s_recid2     = RECID(sic_bran.uwm120).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_renew70 c-Win 
PROCEDURE Proc_renew70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail.prepol   No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF sicuw.uwm100.renpol <> " " THEN 
        ASSIGN 
        wdetail.comment = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว: " + wdetail.prepol 
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
    ELSE DO: 
        ASSIGN   
            wdetail.prepol   = sicuw.uwm100.policy
            n_rencnt         = sicuw.uwm100.rencnt  +  1
            n_endcnt         = 0   
            wdetail.n_rencnt = sicuw.uwm100.rencnt  +  1    
            wdetail.n_endcnt = 0   .                         
        RUN proc_assignrenew .   /* รับค่าข้อมูลกรมธรรม์ เดิม */                             
    END.
END.
Else do:  
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0
        wdetail.n_rencnt = 0
        wdetail.n_endcnt = 0 .
END. 
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
/*nv_row  =  1.*/
DEF VAR a AS CHAR FORMAT "x(100)" INIT "".
DEF VAR b AS CHAR FORMAT "x(100)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR NOT_pass AS INTE INIT 0.
FOR EACH wdetail  WHERE wdetail.PASS <> "Y"  NO-LOCK :
        NOT_pass = NOT_pass + 1.
    
END.
IF NOT_pass > 0 THEN DO:
OUTPUT STREAM ns1 TO value(fi_output2).
PUT STREAM ns1
    "Redbook"     ","
    "Branch    "     "," 
    "Delercode "     "," 
    "vatcode   "     "," 
    "policyno  "      ","  
    "cndat     "      ","  
    "appenno   "      ","  
    "comdat    "      ","  
    "expdat    "      ","  
    "comcode   "      ","  
    "cartyp    "      ","  
    "saletyp   "      ","  
    "campen    "      ","  
    "freeamonth"      ","  
    "covcod    "      ","  
    "typcom    "      ","  
    "garage    "      ","  
    "bysave    "      ","  
    "tiname    "      ","  
    "insnam    "      ","  
    "name2     "      ","  
    "name3     "      ","  
    "addr      "      ","  
    "road     "       ","  
    "tambon   "       ","  
    "amper    "       ","  
    "country  "       ","  
    "post     "       ","  
    "occup    "       ","  
    "birthdat "       ","  
    "icno     "       ","  
    "driverno "       ","  
    "brand    "       ","  
    "cargrp   "       ","  
    "chasno   "       ","  
    "eng      "       ","  
    "model    "       ","  
    "caryear  "       ","  
    "carcode  "       ","  
    "body     "       ","  
    "carno    "       ","  
    "vehuse   "       ","  
    "seat      "      ","  
    "engcc     "      ","  
    "colorcar  "      ","  
    "vehreg    "      ","  
    "re_country"      ","  
    "re_year   "      ","  
    "nmember   "      ","   
    "si        "      ","   
    "premt     "      ","   
    "rstp_t    "      ","   
    "rtax_t    "      ","   
    "prem_r    "      ","   
    "gap       "      ","   
    "ncb       "      ","   
    "ncbprem   "      ","   
    "stk       "      ","
    "prepol    "      ","
    "flagname  "      "," 
    "flagno    "      "," 
    "ntitle1    "     "," 
    "drivername1"     "," 
    "dname1     "     "," 
    "dname2     "     "," 
    "docoup     "     "," 
    "dbirth     "     "," 
    "dicno      "     "," 
    "ddriveno   "     "," 
    "ntitle2    "     "," 
    "drivername2"     "," 
    "ddname1    "     "," 
    "ddname2    "     "," 
    "ddocoup    "     "," 
    "ddbirth    "     "," 
    "ddicno     "     "," 
    "dddriveno  "     "," 
    "benname    "     "," 
    "comper     "     "," 
    "comacc     "     "," 
    "deductpd   "     "," 
    "tp2        "     "," 
    "deductda   "     "," 
    "deduct     "     "," 
    "tpfire     "     "," 
    "compul     "     "," 
    "pass       "     "," 
    "NO_41      "     "," 
    "ac2        "     "," 
    "NO_42      "     "," 
    "ac4        "     "," 
    "ac5        "     "," 
    "ac6        "     "," 
    "ac7        "     "," 
    "NO_43      "     "," 
    "nstatus    "     "," 
    "typrequest "     "," 
    "comrequest "     "," 
    "brrequest  "     "," 
    "salename    "    "," 
    "comcar      "    "," 
    "brcar       "    "," 
    "projectno   "    "," 
    "caryear     "    "," 
    "special1    "    "," 
    "specialprem1"    "," 
    "special2    "    "," 
    "specialprem2"    "," 
    "special3    "    ","
    "specialprem3"    ","
    "special4    "    ","
    "specialprem4"    ","
    "special5    "    ","
    "specialprem5"    ","
    "comment     "    "," 
    "WARNING     "    
            SKIP.                                                   
FOR EACH  wdetail  WHERE wdetail.PASS <> "Y" NO-LOCK:   
    PUT STREAM ns1 wdetail.redbook     "," 
        wdetail.n_branch     "," 
        wdetail.policy       ","
        wdetail.cndat         ","
        wdetail.comdat        ","
        wdetail.expdat        ","
        wdetail.covcod        ","
        wdetail.garage        "," 
        wdetail.tiname        ","
        wdetail.insnam        ","
        wdetail.brand         ","               
        wdetail.cargrp        ","               
        wdetail.chassis        ","               
        wdetail.engno           ","               
        wdetail.model         "," 
        wdetail.caryear       "," 
        wdetail.body          "," 
        wdetail.vehuse        "," 
        wdetail.seat          "," 
        wdetail.engcc         "," 
        wdetail.vehreg        "," 
        wdetail.si            "," 
        wdetail.premt         "," 
        /*wdetail.rstp_t        "," 
        wdetail.rtax_t        "," */
        wdetail.prem_r        "," 
        wdetail.ncb           "," 
        /*wdetail.ncbprem       "," */
        wdetail.stk           ","
         
        /*wdetail.ntitle1       ","
        wdetail.drivername1   ","   
        wdetail.dname1        ","   
        wdetail.dname2        ","   
        wdetail.docoup        ","   
        wdetail.dbirth        ","   
        wdetail.dicno         ","   
        wdetail.ddriveno      ","   
        wdetail.ntitle2       ","   
        wdetail.drivername2   ","   
        wdetail.ddname1       ","   
        wdetail.ddname2       ","   
        wdetail.ddocoup       ","   
        wdetail.ddbirth       ","   
        wdetail.ddicno        ","   
        wdetail.dddriveno     "," */  
        wdetail.benname       ","   
        wdetail.comper        ","   
        wdetail.comacc        ","   
         
        /*wdetail.tp2           ","  */ 
        /*wdetail.deductda      ","  */ 
        /*wdetail.deduct        ","   */
        /*wdetail.tpfire        ","  */ 
        wdetail.compul        ","   
        wdetail.pass          ","     
        wdetail.nv_41         ","   
        wdetail.nv_42         ","   
        wdetail.nv_43         ","   
        wdetail.caryear       ","   
        wdetail.comment       ","
        wdetail.WARNING         
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
/*nv_row  =  1.*/
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.
FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  NO-LOCK:
        pass = pass + 1.
END.

IF pass > 0 THEN DO:
OUTPUT STREAM ns2 TO value(fi_output1).
PUT STREAM NS2
    "redbook "  ","
    "n_branch"  ","   
    "policyno"  ","   
    "cndat   "  "," 
    "comdat  "  ","  
    "expdat  "  ","  
    "covcod  "  ","  
    "garage  "  ","  
    "tiname  "  ","  
    "insnam  "  ","  
    "brand   "  ","  
    "cargrp  "  ","  
    "chasno  "  ","  
    "eng     "  ","  
    "model   "  ","  
    "caryear "  ","  
    "body    "  ","  
    "vehuse  "  ","  
    "seat    "  ","  
    "engcc   "  ","  
    "vehreg  "  ","  
    "si      "  ","  
    "premt   "  ","  
    "rstp_t  "  ","  
    "rtax_t  "  ","  
    "prem_r  "  ","  
    "ncb     "  ","  
    "stk     "  ","  
    "prepol  "  ","  
    "benname "  ","  
    "comper  "  ","  
    "comacc  "  ","  
    "deductpd"  ","  
    "deduct  "  ","  
    "compul  "  ","  
    "pass    "  ","  
    "NO_41   "  ","  
    "ac2     "  ","  
    "NO_42   "  ","  
    "NO_43   "  ","  
    "caryear "  ","  
    "comment "  ","  
    "WARNING "  SKIP.        
FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  NO-LOCK:
        PUT STREAM ns2
            wdetail.redbook    ","   
            wdetail.n_branch   ","   
            wdetail.policy     ","
            wdetail.cndat      ","
            wdetail.comdat     ","
            wdetail.expdat     ","
            wdetail.covcod     ","
            wdetail.garage     "," 
            wdetail.tiname     ","
            wdetail.insnam     ","
            wdetail.brand      ","               
            wdetail.cargrp     ","               
            wdetail.chassis    ","               
            wdetail.engno      ","               
            wdetail.model      "," 
            wdetail.caryear    "," 
            wdetail.body       "," 
            wdetail.vehuse     "," 
            wdetail.seat       "," 
            wdetail.engcc      "," 
            wdetail.vehreg     "," 
            wdetail.si         "," 
            wdetail.premt      "," 
            /*wdetail.rstp_t     "," 
            wdetail.rtax_t     "," */
            wdetail.prem_r     "," 
            wdetail.ncb        "," 
            wdetail.stk        ","
            /*wdetail.prepol     ","*/
            wdetail.benname    ","   
            wdetail.comper     ","   
            wdetail.comacc     ","   
            /*wdetail.deductpd   ","   
            wdetail.deduct     "," */ 
            wdetail.compul     ","   
            wdetail.pass       ","     
            wdetail.nv_41      ","   
            wdetail.nv_42      ","   
            wdetail.nv_43      ","   
            wdetail.caryear    ","   
            wdetail.comment    ","
            wdetail.WARNING    SKIP.  
  
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
"IMPORT TEXT FILE TISCO " SKIP
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
"Batch No. : " fi_bchno  SKIP
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
            IF FRAME-FIELD = "gv_id" AND LASTKEY = KEYCODE("ENTER") OR LASTKEY = KEYCODE("f1") THEN DO:
                IF INPUT gv_id = "" THEN DO:
                    MESSAGE "User ID. IS NOT BLANK".
                    NEXT-PROMPT gv_id WITH FRAME nf00.
                    NEXT.
                END.
                gv_id = INPUT gv_id.
            END.
            IF FRAME-FIELD = "nv_pwd" AND  LASTKEY = KEYCODE("ENTER") OR  LASTKEY = KEYCODE("f1") THEN DO:
                nv_pwd = INPUT nv_pwd.
            END.
            APPLY LASTKEY.
    END.
    ASSIGN n_user = gv_id.
    IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
        CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.    /* connect HO */
       /* CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.    /* connect HO */*//*Comment A62-0105*/
        /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.  /*test system */  */
        CLEAR FRAME nf00.
        HIDE FRAME nf00.
        RETURN. 
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
DEFINE  VAR sv_fptr AS RECID no-undo.
DEFINE  VAR sv_bptr AS RECID no-undo.
DEFINE VAR nvw_bptr        AS RECID.
DEFINE VAR nvw_fptr        AS RECID.
DEFINE VAR nvw_index       AS INTEGER.
/*DEFINE VAR nvw_dl          AS INTEGER INITIAL[14].*//*Kridtiya i. A54-0215*/
DEFINE VAR nvw_dl          AS INTEGER INITIAL[70].    /*Kridtiya i. A54-0215*/
DEFINE VAR nvw_prev        AS RECID INITIAL[0].
DEFINE VAR nvw_next        AS RECID INITIAL[0].
DEFINE VAR nvw_list        AS LOGICAL INITIAL[YES].
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
    nv_txt1  = " " 
    nv_txt2  = " " 
    nv_txt3  = " "  
    nv_txt4  = " "  
    nv_txt5  = "" . 
ASSIGN  nv_line1 = 0.
/*
IF trim(fi_policymas) <> "" THEN DO:
    
FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE uwm100.policy     = trim(fi_policymas) NO-LOCK NO-ERROR.
IF AVAILABLE uwm100 THEN DO :
    ASSIGN sv_fptr = uwm100.fptr01
        sv_bptr = uwm100.bptr01.
    IF sv_fptr <> 0  AND sv_fptr <> ? THEN DO:
        IF sv_fptr <> 0 THEN  nvw_fptr = sv_fptr.
        REPEAT nvw_index = 1 TO nvw_dl
            WHILE nvw_fptr <> 0:
            FIND sicuw.uwd100 WHERE RECID(uwd100) = nvw_fptr NO-LOCK NO-ERROR.
            CREATE wuppertxt.
            ASSIGN wuppertxt.line = nv_line1 + 1
                wuppertxt.txt =  sicuw.uwd100.ltext .
            IF nvw_index = 1 THEN
                nvw_prev = uwd100.bptr.
            ELSE IF nvw_index = nvw_dl THEN DO:
                nvw_next = sicuw.uwd100.fptr.
                LEAVE.
            END.
            nvw_fptr = uwd100.fptr.
            DOWN 1 WITH FRAME nf1.
        END.
        nvw_list = NO.
    /*END.
END.*/
        FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
            sic_bran.uwm100.policy  = wdetail.policy  AND
            sic_bran.uwm100.rencnt  = wdetail.n_rencnt  AND
            sic_bran.uwm100.endcnt  = wdetail.n_endcnt  AND
            sic_bran.uwm100.bchyr   = nv_batchyr    AND
            sic_bran.uwm100.bchno   = nv_batchno    AND
            sic_bran.uwm100.bchcnt  = nv_batcnt    NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwm100 THEN DO:
            FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
                CREATE sic_bran.uwd100.
                ASSIGN
                    sic_bran.uwd100.bptr    = nv_bptr
                    sic_bran.uwd100.fptr    = 0
                    sic_bran.uwd100.policy  = wdetail.policy
                    sic_bran.uwd100.rencnt  = wdetail.n_rencnt
                    sic_bran.uwd100.endcnt  = wdetail.n_endcnt
                    sic_bran.uwd100.ltext   = wuppertxt.txt.
                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                    wf_uwd100.fptr = RECID(sic_bran.uwd100).
                END.
                IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(sic_bran.uwd100).
                nv_bptr = RECID(sic_bran.uwd100).
            END. 
        END.  /*uwm100*/ 
    END.
END.

END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100_1 c-Win 
PROCEDURE proc_uwd100_1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
    nv_txt6  = ""  .
FIND LAST wacctext15 WHERE wacctext15.n_policytxt15 = wdetail.policy NO-LOCK NO-ERROR.
IF AVAIL wacctext15 THEN DO:
    ASSIGN 
        nv_txt3  =  wacctext15.n_textacc1  
        nv_txt4  =  wacctext15.n_textacc2   
        nv_txt5  =  wacctext15.n_textacc3   
        nv_txt6  =  wacctext15.n_textacc4   .
    DO WHILE nv_line1 <= 5:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
    IF nv_line1 = 6  THEN wuppertxt.txt = nv_txt6.
    nv_line1 = nv_line1 + 1.
    END.  /* Do while */
    FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
        sic_bran.uwm100.policy  = wdetail.policy  AND
        sic_bran.uwm100.rencnt  = n_rencnt        AND
        sic_bran.uwm100.endcnt  = n_endcnt        AND
        sic_bran.uwm100.bchyr   = nv_batchyr      AND
        sic_bran.uwm100.bchno   = nv_batchno      AND
        sic_bran.uwm100.bchcnt  = nv_batcnt       NO-ERROR NO-WAIT.
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
        END.   /*for wuppertxt*/
    END. /*uwm100*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 c-Win 
PROCEDURE proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*F18 memmo */
DEFINE  VAR sv_fptr   AS RECID no-undo.
DEFINE  VAR sv_bptr   AS RECID no-undo.     /* DEFINE VAR nvw_bptr        AS RECID.                   */
DEFINE VAR nvw_fptr   AS RECID.                   
DEFINE VAR nvw_index  AS INTEGER.                 
DEFINE VAR nvw_dl     AS INTEGER INITIAL[14].     
DEFINE VAR nvw_prev   AS RECID INITIAL[0].       
DEFINE VAR nvw_next   AS RECID INITIAL[0].       
DEFINE VAR nvw_list   AS LOGICAL INITIAL[YES].
DEF VAR n_num1        AS INTE INIT 0.
DEF VAR n_num2        AS INTE INIT 0.
DEF VAR n_num3        AS INTE INIT 1.
DEF VAR i             AS INTE INIT 0.
DEF VAR n_text1       AS CHAR FORMAT "x(255)".
DEF VAR n_numtxt      AS INTE INIT 0.
ASSIGN 
    nv_fptr  = 0
    nv_bptr  = 0
    nv_nptr  = 0
    nv_line1 = 0
    n_numtxt = 0.
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.

/*
IF trim(fi_policymas) <> "" THEN DO:
    
FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE uwm100.policy =  trim(fi_policymas)   NO-LOCK NO-ERROR.
IF AVAILABLE uwm100 THEN DO :
    ASSIGN sv_fptr = uwm100.fptr02 
    sv_bptr = uwm100.bptr02.
    IF sv_fptr <> 0  AND sv_fptr <> ? THEN DO:
        IF sv_fptr <> 0 THEN DO:
            VIEW FRAME nf1.
            nvw_fptr = sv_fptr.
        END.
        REPEAT nvw_index = 1 TO nvw_dl
            WHILE nvw_fptr <> 0:
            FIND sicuw.uwd102 WHERE RECID(uwd102) = nvw_fptr NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwd102  THEN DO:
                n_numtxt = n_numtxt + 1.
                CREATE wuppertxt3.
                ASSIGN wuppertxt3.line = nv_line1 + 1 
                    wuppertxt3.txt = sicuw.uwd102.ltext .
                /*DISPLAY uwd102.ltext  WITH FRAME nf1.*/
                IF nvw_index = 1 THEN
                    nvw_prev = uwd102.bptr.
                ELSE IF nvw_index = nvw_dl THEN DO:
                    nvw_next = uwd102.fptr.
                    LEAVE.
                END.
            END.
            nvw_fptr = uwd102.fptr.
            DOWN 1 WITH FRAME nf1.
        END.
        
    /*END.
END.*/
        Assign
            nvw_list = NO
            nv_fptr = 0 
            nv_bptr = 0  
            nv_nptr = 0 . 
        IF n_numtxt > 0 THEN DO:
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
            sic_bran.uwm100.bptr02         =       Recid(sic_bran.uwd102).
            sic_bran.uwd102.fptr           =      0.  
            IF nv_bptr = 0 THEN sic_bran.uwm100.fptr02 = RECID(sic_bran.uwd102).
            nv_bptr = RECID(sic_bran.uwd102).
            /*END.*/
            ASSIGN 
                sic_bran.uwm100.bptr02 = nv_bptr 
                n_numtxt = 0.
        END.
    END.
END.
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102_1 c-Win 
PROCEDURE proc_uwd102_1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*F18 memmo */
DEF VAR n_num1 AS INTE INIT 0.
DEF VAR n_num2 AS INTE INIT 0.
DEF VAR n_num3 AS INTE INIT 1.
DEF VAR i AS INTE INIT 0.
DEF VAR n_text1 AS CHAR FORMAT "x(255)".
ASSIGN 
    nv_fptr = 0
    nv_bptr = 0
    nv_nptr = 0
    nv_line1 = 1  .
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
FIND LAST wacctext17 WHERE wacctext17.n_policytxt17 = wdetail.policy NO-LOCK NO-ERROR.
IF AVAIL wacctext17 THEN DO:
    DO WHILE nv_line1 <= 11:
        CREATE wuppertxt3.                                                                                 
        wuppertxt3.line = nv_line1.     
        IF nv_line1 = 3  THEN wuppertxt3.txt =   wacctext17.n_textacc1 .  
        IF nv_line1 = 4  THEN wuppertxt3.txt =   wacctext17.n_textacc2 .                                      
        IF nv_line1 = 5  THEN wuppertxt3.txt =   wacctext17.n_textacc3 .
        IF nv_line1 = 6  THEN wuppertxt3.txt =   wacctext17.n_textacc4 .
        IF nv_line1 = 7  THEN wuppertxt3.txt =   wacctext17.n_textacc5 .


        nv_line1 = nv_line1 + 1.                                                                           
    END.
    IF nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? THEN DO:
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
            FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr NO-ERROR NO-WAIT.
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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm100 c-Win 
PROCEDURE proc_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
IF ra_NAP_pd = 1 THEN DO:  /*กรณี ต้องการ ให้ได้เบี้ย ตามไฟล์ */
    IF (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) >= 365 ) AND
       (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) <= 366 ) THEN
        ASSIGN 
        nv_gapprm  =  IF wdetail.prem_nap = "" THEN nv_gapprm ELSE DECI(wdetail.prem_nap)
        nv_pdprm   =  IF wdetail.prem_nap = "" THEN nv_pdprm  ELSE DECI(wdetail.prem_nap).
        ELSE  /*เบี้ย ไม่เต็มปี หรือ เกินปี */
            ASSIGN nv_pdprm   =  IF wdetail.prem_nap = "" THEN nv_pdprm  ELSE DECI(wdetail.prem_nap).
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
     
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm120 c-Win 
PROCEDURE proc_uwm120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
     ASSIGN
     sic_bran.uwm120.gap_r  = nv_gapprm
     sic_bran.uwm120.prem_r = nv_pdprm
     sic_bran.uwm120.sigr   = inte(wdetail.si).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm301 c-Win 
PROCEDURE proc_uwm301 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN 
    ASSIGN   
        sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs
        sic_bran.uwm301.mv41seat = nv_seat41 .
 /* 
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).*/

IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR
   (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" ) THEN      
    RUN WGS\WGSTP132(INPUT S_RECID3,   
                     INPUT S_RECID4). 
ELSE 
    RUN WGS\WGSTN132(INPUT S_RECID3,  
                 INPUT S_RECID4).
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
    s_itemno   =   1                     nv_undyr       =    String(Year(today),"9999")   
    n_rencnt   =   0                     n_endcnt       =  0.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wgsoper c-Win 
PROCEDURE proc_wgsoper :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
          nv_411prm  = nv_41
          nv_412prm  = nv_412
          nv_42prm   = nv_42
          nv_43prm   = nv_43.

        /*chk
        message color black/white "nv 41 42 43 " nv_41 nv_42 nv_43 .
        pause 10.
       chk*/

        IF nv_41 <> 0 AND nv_41 <> ? THEN DO:
         nv_41cod1 = "411".
         nv_41cod2 = "412".
        END.

        IF nv_42 <> 0 AND nv_42 <> ? THEN DO:
          nv_42cod = "42".
        END.

        IF nv_43 <> 0 AND nv_43 <> ? THEN DO:
          nv_43cod = "43".
        END.

        IF nv_41 <> 0 THEN DO:
           RUN wgu\wgumx022 (INPUT  nv_tariff,           /*      MV411   *//*a490166 note modi*/
                                    nv_41cod1,
                                    nv_class,
                                    nv_key_b,
                                    nv_comdat,
                                    nv_seat41,
                       INPUT-OUTPUT nv_411prm).

           RUN wgu\wgumx022 (INPUT nv_tariff,           /*      MV411   *//*a490166 note modi*/
                                    nv_41cod2,
                                    nv_class,
                                    nv_key_b,
                                    nv_comdat,
                                    nv_seat41,
                       INPUT-OUTPUT nv_412prm).
        END.
        ELSE ASSIGN nv_411prm = 0
                    nv_412prm = 0.

        IF nv_42 <> 0 THEN DO:
           RUN wgu\wgumx023 (INPUT nv_tariff,           /*      MV42    *//*a490166 note modi*/
                                    nv_42cod,
                                    nv_class,
                                    nv_42   ,
                                    nv_comdat,
                                  nv_seat41,
                           OUTPUT nv_42prm).
        END.
        ELSE nv_42prm = 0.
        IF nv_43 <> 0 THEN DO:
          RUN wgu\wgumx022 (INPUT nv_tariff,           /*      MV43    *//*a490166 note modi*/
                                   nv_43cod,
                                   nv_class,
                                   nv_key_b,
                                   nv_comdat,
                                   nv_seat41,
                      INPUT-OUTPUT nv_43prm).
        END.
        ELSE nv_43prm = 0.

        nv_addprm = nv_411prm + nv_412prm + nv_42prm + nv_43prm.

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
         sicsyac.xmm031.poltyp EQ sic_bran.uwm100.poltyp  NO-LOCK NO-ERROR.
    IF AVAILABLE sicsyac.xmm031 THEN DO:
        IF n_dcover = 365  THEN   
            n_ddyr   = YEAR(TODAY).
        n_ddyr1  = n_ddyr + 1.
        n_dyear  = 365.   
        FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
            sicsyac.xmm105.tariff EQ nvtariff       AND
            sicsyac.xmm105.bencod EQ sic_bran.uwd132.bencod  NO-LOCK NO-ERROR.
      IF  sic_bran.uwm100.short = NO OR sicsyac.xmm105.shorta = NO THEN DO:
          sic_bran.uwd132.prem_c = ROUND((n_orgnap * n_dcover) / n_dyear,0) .    /*A57-0195*/
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
             sic_bran.uwd132.prem_c =  IF (((n_orgnap * n_dcover) / n_dyear) - ROUND((n_orgnap * n_dcover) / n_dyear,0)) > 0 THEN 
                                       ROUND((n_orgnap * n_dcover) / n_dyear,0) + 1
                                       ELSE ROUND((n_orgnap * n_dcover) / n_dyear,0) .   /*A57-0195*/
          END.

        END.
      END.
      IF s_curbil = "BHT" THEN  sic_bran.uwd132.prem_c = IF (((n_orgnap * n_dcover) / n_dyear) - ROUND((n_orgnap * n_dcover) / n_dyear,0)) > 0 THEN 
                                       ROUND((n_orgnap * n_dcover) / n_dyear,0) + 1
                                       ELSE ROUND((n_orgnap * n_dcover) / n_dyear,0) .   /*A57-0195*/   /*A57-0195*/
    END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

