&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_bran         PROGRESS
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases 
          sic_test         PROGRESS     */
  File: Description: 
  Input Parameters:<none>
  Output Parameters:<none>
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
/*programid   : wgwttpis.w                                              */ 
/*programname : Load text file tpis to GW           */ 
/* Copyright  : Safety Insurance Public Company Limited                 */  
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)        */  
/*create by   : ranu i. A57-0242   date. 22/07/2014             
               ปรับโปรแกรมให้สามารถนำเข้า text file tpis   to GW system   */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/**************************************************************************/
DEF VAR nv_nptr    AS RECID.
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
DEF NEW  SHARED VAR nv_cl_cod   AS CHAR       FORMAT "X(4)".
DEF New  SHARED VAR nv_lodclm   AS INTEGER    FORMAT ">>>,>>9.99-".
DEF             VAR nv_lodclm1  AS INTEGER    FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR nv_clmvar1  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR nv_clmvar2  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR nv_clmvar   AS CHAR       FORMAT "X(60)". 
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
DEF NEW  SHARED VAR nv_cl_per   AS DECIMAL    FORMAT ">9.99".
DEF NEW  SHARED VAR nv_stf_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR nv_stf_per  AS DECIMAL   FORMAT ">9.99".
DEF New  SHARED VAR nv_stf_amt  AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR nv_stfvar1  AS CHAR      FORMAT "X(30)".
DEF New  SHARED VAR nv_stfvar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR nv_stfvar   AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR nv_dss_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR nv_dss_per  AS DECIMAL   FORMAT ">9.99".
DEF New  SHARED VAR nv_dsspc    AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR nv_dsspcvar1 AS CHAR     FORMAT "X(30)".
DEF New  SHARED VAR nv_dsspcvar2 AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR nv_dsspcvar  AS CHAR     FORMAT "X(60)".
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
DEF VAR nv_lnumber AS   INTE INIT 0.
DEF VAR nv_provi   AS   CHAR INIT "".
DEF VAR n_rencnt   LIKE sicuw.uwm100.rencnt INITIAL "".
def var nv_index   as   int  init  0. 
DEF VAR n_endcnt   LIKE sicuw.uwm100.endcnt INITIAL "".
def var n_comdat   LIKE sicuw.uwm100.comdat  NO-UNDO.
def var n_policy   LIKE sicuw.uwm100.policy  INITIAL "" .
/*DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.*/
/*DEF VAR nv_reccnt   AS  INT  INIT  0.           /*all load record*/*/
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
{wgw\Wgwttpi2.i}      /*ประกาศตัวแปร*/

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
&Scoped-define FIELDS-IN-QUERY-br_comp wcomp.vehuse wcomp.package wcomp.premcomp   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_comp   
&Scoped-define SELF-NAME br_comp
&Scoped-define QUERY-STRING-br_comp FOR EACH wcomp
&Scoped-define OPEN-QUERY-br_comp OPEN QUERY br_comp FOR EACH wcomp.
&Scoped-define TABLES-IN-QUERY-br_comp wcomp
&Scoped-define FIRST-TABLE-IN-QUERY-br_comp wcomp


/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.poltyp wdetail.policy wdetail.prvpol wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.iadd1 wdetail.iadd2 wdetail.iadd3 wdetail.iadd4 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.engno wdetail.chasno wdetail.caryear wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.volprem wdetail.Compprem wdetail.fleet wdetail.ncb wdetail.access wdetail.benname wdetail.n_user wdetail.n_IMPORT wdetail.n_export wdetail.producer wdetail.agent wdetail.comment WDETAIL.WARNING wdetail.cancel wdetail.redbook   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_comp fi_camname fi_pack ra_typefile ~
fi_loaddat fi_branch fi_bchno fi_producer fi_agent fi_prevbat fi_bchyr ~
fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem ~
buok bu_exit bu_hpbrn bu_hpacno72 bu_hpagent72 fi_process fi_packcom ~
fi_premcomp bu_add bu_del fi_vehuse RECT-370 RECT-372 RECT-373 RECT-374 ~
RECT-376 br_wdetail RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_camname fi_pack ra_typefile fi_loaddat ~
fi_branch fi_bchno fi_producer fi_agent fi_prevbat fi_bchyr fi_filename ~
fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt ~
fi_proname fi_completecnt fi_premtot fi_agtname fi_premsuc fi_process ~
fi_packcom fi_premcomp fi_vehuse 

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
     SIZE 4.5 BY .95.

DEFINE BUTTON bu_hpacno72 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpagent72 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 41 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(19)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
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
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
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

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

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
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 66.5 BY .95
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 41 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehuse AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_typefile AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match File Text to Excel", 1,
"Load To GW", 2,
"Match Policy", 3
     SIZE 84 BY .95
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 1.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 14.81
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 4.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 3
     BGCOLOR 8 .

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
      wcomp.vehuse     COLUMN-LABEL "VehUse "   FORMAT "x(1)"
      wcomp.package    COLUMN-LABEL "Package"   FORMAT "x(5)"
      wcomp.premcomp   COLUMN-LABEL "Premcomp"  FORMAT "->>>,>>9.99"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 30 BY 4.52
         BGCOLOR 15 FGCOLOR 0 FONT 6 EXPANDABLE.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.poltyp   COLUMN-LABEL "Policy Type"
        wdetail.policy   COLUMN-LABEL "Policy"
        wdetail.prvpol   COLUMN-LABEL "Renew Policy"
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
        wdetail.benname  COLUMN-LABEL "Benefit Name" 
        wdetail.n_user   COLUMN-LABEL "User"
        wdetail.n_IMPORT COLUMN-LABEL "Import"
        wdetail.n_export COLUMN-LABEL "Export"
        wdetail.producer COLUMN-LABEL "Producer"
        wdetail.agent    COLUMN-LABEL "Agent"
        wdetail.comment  FORMAT "x(35)" COLUMN-BGCOLOR  80 COLUMN-LABEL "Comment"
        WDETAIL.WARNING  COLUMN-LABEL "Warning"
        wdetail.cancel   COLUMN-LABEL "Cancel"
        wdetail.redbook  COLUMN-LABEL "RedBook"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 3.95
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_comp AT ROW 5.33 COL 95.5
     fi_camname AT ROW 4 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 4 COL 62.5 COLON-ALIGNED NO-LABEL
     ra_typefile AT ROW 8.43 COL 10 NO-LABEL
     fi_loaddat AT ROW 2.91 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 5.1 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.57 COL 17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_producer AT ROW 6.14 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 7.19 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 9.57 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 9.57 COL 67.83 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 10.67 COL 31.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 10.67 COL 94.17
     fi_output1 AT ROW 11.71 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 12.81 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 13.91 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 15 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 15 COL 71 NO-LABEL
     buok AT ROW 10.91 COL 104.67
     bu_exit AT ROW 12.81 COL 104.67
     fi_brndes AT ROW 5.1 COL 42.33 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 5.1 COL 40
     fi_impcnt AT ROW 22.29 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpacno72 AT ROW 6.14 COL 49
     bu_hpagent72 AT ROW 7.19 COL 49
     fi_proname AT ROW 6.14 COL 51.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.29 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.29 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_agtname AT ROW 7.19 COL 51.33 COLON-ALIGNED NO-LABEL
     fi_premsuc AT ROW 23.33 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 16.14 COL 25.83 COLON-ALIGNED NO-LABEL
     fi_packcom AT ROW 3.86 COL 95.5 COLON-ALIGNED NO-LABEL
     fi_premcomp AT ROW 3.91 COL 114 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 4.05 COL 126
     bu_del AT ROW 5.1 COL 126.17
     fi_vehuse AT ROW 3.86 COL 78.5 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 17.67 COL 2.33
     "                      Branch :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 5.1 COL 10
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1 AT ROW 23.29 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Base Comp :" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 3.91 COL 103.5
          BGCOLOR 5 FGCOLOR 1 FONT 6
     "                 Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 2.91 COL 10
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Vehuse" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 3.86 COL 71.67
          BGCOLOR 5 FGCOLOR 1 FONT 6
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 10.67 COL 10
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "                                      IMPORT TEXT FILE TIL[TPIB] รถบรรทุกใหญ่" VIEW-AS TEXT
          SIZE 128 BY 1 AT ROW 1.29 COL 129.67 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "               Agent Code :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 7.19 COL 10
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 13.91 COL 10
          BGCOLOR 3 FGCOLOR 7 
     " Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 9.57 COL 68.16 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 7 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 22.29 COL 117.17
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 22.29 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 2 FONT 6
     " Packge :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 4 COL 54
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 15 COL 69.5 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 23.29 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 22.29 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 11.71 COL 10
          BGCOLOR 3 FGCOLOR 7 
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 12.81 COL 10
          BGCOLOR 3 FGCOLOR 7 
     "          Producer  Code :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 6.14 COL 10
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 15.05 COL 88.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "    Previous Batch No. :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 9.57 COL 10
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "         Campaign Name :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 4 COL 10
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.67 COL 5.33
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 23.29 COL 117.17
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "    Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 15 COL 32 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "PackComp :" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 3.86 COL 85.83
          BGCOLOR 5 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.62 COL 1
     RECT-373 AT ROW 17.48 COL 1
     RECT-374 AT ROW 21.81 COL 1
     RECT-376 AT ROW 22.05 COL 2.5
     RECT-377 AT ROW 10.67 COL 103.5
     RECT-378 AT ROW 12.52 COL 103.5
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
         TITLE              = "Load Text & Generate TPIB"
         HEIGHT             = 23.91
         WIDTH              = 132.83
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
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "                                      IMPORT TEXT FILE TIL[TPIB] รถบรรทุกใหญ่"
          SIZE 128 BY 1 AT ROW 1.29 COL 129.67 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL " Batch Year :"
          SIZE 12.83 BY .95 AT ROW 9.57 COL 68.16 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "    Policy Import Total :"
          SIZE 23 BY .95 AT ROW 15 COL 32 RIGHT-ALIGNED                 */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .95 AT ROW 15 COL 69.5 RIGHT-ALIGNED             */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1 AT ROW 22.29 COL 58.83 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1 AT ROW 22.29 COL 95.83 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1 AT ROW 23.29 COL 58.83 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1 AT ROW 23.29 COL 96 RIGHT-ALIGNED             */

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
ON END-ERROR OF c-Win /* Load Text  Generate TPIB */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text  Generate TPIB */
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
    wcomp.vehuse:BGCOLOR IN BROWSE  BR_comp = z NO-ERROR.   
    wcomp.package:BGCOLOR IN BROWSE  BR_comp = z NO-ERROR.  
    wcomp.premcomp:BGCOLOR IN BROWSE BR_comp = z NO-ERROR.

    wcomp.vehuse:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.
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
        wdetail.poltyp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
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
        wdetail.benname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.n_user:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
        wdetail.n_IMPORT:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.n_export:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.producer:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
        wdetail.agent:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
        wdetail.comment:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
        WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
        WDETAIL.CANCEL:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
        wdetail.redbook:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. /*new add*/                 


        wdetail.poltyp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
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
        wdetail.benname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.n_user:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.n_IMPORT:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.n_export:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.producer:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.agent:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.comment:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        WDETAIL.WARNING:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        WDETAIL.CANCEL:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.redbook:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  /*new add*/
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    /*IF      ra_typefile = 1 THEN RUN proc_matfileload.*/
    IF      ra_typefile = 1 THEN RUN proc_matfileloadtxt.
    ELSE IF ra_typefile = 3 THEN RUN proc_matfileloadpol.
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
                FIND LAST uzm701 USE-INDEX uzm70102 
                    WHERE uzm701.bchyr = nv_batchyr  AND
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
                WHERE uzm701.bchyr = nv_batchyr  AND
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

        /*ranu*/

       /* For each  wdetail2 :
            DELETE  wdetail2.
        END.*/
        RUN proc_assign.
        FOR EACH wdetail NO-LOCK .  
            IF WDETAIL.POLTYP = "V70" OR WDETAIL.POLTYP = "V72" THEN DO: 
                ASSIGN
                    nv_reccnt      =  nv_reccnt   + 1
                    nv_netprm_t    =  nv_netprm_t + decimal(wdetail.volprem) .
            END.
            ELSE DO :    
                DELETE WDETAIL.
            END.
        END.
        IF  nv_reccnt =0 THEN DO: 
            MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
            RETURN NO-APPLY.
        END.
        RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                               INPUT            nv_batchyr ,     /* INT   */
                               INPUT            fi_producer,     /* CHAR  */ 
                               INPUT            nv_batbrn  ,     /* CHAR  */
                               INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                               INPUT            "wgwttpis" ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                               INPUT            nv_imppol  ,     /* INT   */
                               INPUT            nv_impprem).       /* DECI  */
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
        IF /*nv_imppol <> nv_rectot OR nv_imppol <> nv_recsuc OR*/
            nv_rectot <> nv_recsuc   THEN DO:
            nv_batflg = NO.
            /*MESSAGE "Policy import record is not match to Total record !!!" VIEW-AS ALERT-BOX.*/
        END.
        ELSE IF /*nv_impprem  <> nv_netprm_t OR
            nv_impprem  <> nv_netprm_s OR*/
                nv_netprm_t <> nv_netprm_s THEN DO:
            nv_batflg = NO.
            /*MESSAGE "Total net premium is not match to Total net premium !!!" VIEW-AS ALERT-BOX.*/
        END.
        ELSE  nv_batflg = YES.
        FIND LAST uzm701 USE-INDEX uzm70102  
            WHERE uzm701.bchyr = nv_batchyr AND
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
        RELEASE stat.detaitem.
        RELEASE brStat.Detaitem.
        RELEASE sicsyac.xtm600.
        RELEASE sicsyac.xmm600.
        RELEASE sicsyac.xzm056.
        IF nv_batflg = NO THEN DO:  
            ASSIGN
                fi_completecnt:FGCOLOR = 6
                fi_premsuc    :FGCOLOR = 6 
                fi_bchno    :FGCOLOR = 6
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
                   wcomp.vehuse  = fi_vehuse
                fi_packcom      = "" 
                fi_vehuse       = ""
                fi_premcomp     = 0  .
        END.
    END.
    OPEN QUERY br_comp FOR EACH wcomp.
    APPLY "ENTRY" TO fi_packcom  .
    disp  fi_packcom  fi_premcomp fi_vehuse  with frame  fr_main.
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
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
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
         IF ra_typefile = 3 THEN DO:
             ASSIGN
                 fi_filename  = cvData
                 fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + "pol.slk" /*.csv*/
                 fi_output2 = ""
                 fi_output3 = "".
             DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
             APPLY "Entry" TO fi_output1.
             RETURN NO-APPLY.
         END.
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


&Scoped-define SELF-NAME bu_hpacno72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno72 c-Win
ON CHOOSE OF bu_hpacno72 IN FRAME fr_main
DO:
    Def   var     n_acno       As  Char.
    Def   var     n_agent      As  Char.    
    Run whp\whpacno1(output  n_acno,      /*a490166 note modi*/ /*28/11/2006*/
                     output  n_agent).

    If  n_acno  <>  ""  Then  fi_producer =  n_acno.
    disp  fi_producer  with frame  fr_main.
    Apply "Entry"  to  fi_producer.
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
                fi_agent =  caps(INPUT  fi_agent) .
        END.
    END.
    Disp  fi_agent  fi_agtname   WITH Frame  fr_main. 
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


&Scoped-define SELF-NAME fi_camname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camname c-Win
ON LEAVE OF fi_camname IN FRAME fr_main
DO:
    fi_camName = INPUT fi_camName .
    DISP fi_camName WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_output1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output1 c-Win
ON LEAVE OF fi_output1 IN FRAME fr_main
DO:
  fi_output1 = INPUT fi_output1.
  DISP fi_output1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack c-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
  fi_pack  = INPUT fi_pack .
  Disp fi_pack  With Frame  fr_main.
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
        FIND sicsyac.xmm600 USE-INDEX xmm60001          WHERE
            sicsyac.xmm600.acno  =  Input fi_producer NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" View-as alert-box.
            Apply "Entry" To  fi_producer.
            RETURN NO-APPLY.  /*note add on 10/11/2005*/
        END.
        ELSE DO:
            IF TRIM(sicsyac.xmm600.ntitle) = "" THEN fi_proname =   TRIM(sicsyac.xmm600.name).
            ELSE fi_proname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name). 
            ASSIGN fi_producer =  caps(INPUT  fi_producer) .
        END.
    END.
    Disp  fi_producer  fi_proname   WITH Frame  fr_main.   
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


&Scoped-define SELF-NAME fi_vehuse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehuse c-Win
ON LEAVE OF fi_vehuse IN FRAME fr_main
DO:
    fi_vehuse =  Input  fi_vehuse.
    Disp  fi_vehuse with  frame  fr_main.
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
    DISP ra_typefile fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
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
  
  gv_prgid = "wgwttpi2".
  gv_prog  = "Load Text & Generate TPIB รถบรรทุกใหญ่".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN proc_createcomp.
  OPEN QUERY br_comp FOR EACH wcomp.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). 
  ASSIGN
      fi_pack       = "V"
      fi_camName    = "CAMPAIGN_TPIS"
      fi_branch     = "M"
      fi_producer   = "A0M2001"
      fi_agent      = "B3M0018"
       
      fi_process    = "Load Text file TPIS รถบรรทุกใหญ่ "    
      ra_typefile   = 1   
      fi_bchyr    = YEAR(TODAY) .
  DISP  fi_pack fi_camName fi_branch fi_producer fi_agent  fi_bchyr ra_typefile fi_process WITH FRAME fr_main.
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
  DISPLAY fi_camname fi_pack ra_typefile fi_loaddat fi_branch fi_bchno 
          fi_producer fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 
          fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt 
          fi_proname fi_completecnt fi_premtot fi_agtname fi_premsuc fi_process 
          fi_packcom fi_premcomp fi_vehuse 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE br_comp fi_camname fi_pack ra_typefile fi_loaddat fi_branch fi_bchno 
         fi_producer fi_agent fi_prevbat fi_bchyr fi_filename bu_file 
         fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit 
         bu_hpbrn bu_hpacno72 bu_hpagent72 fi_process fi_packcom fi_premcomp 
         bu_add bu_del fi_vehuse RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 
         br_wdetail RECT-377 RECT-378 
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
    IF      (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN wdetail.subclass = "140A".
    ELSE IF wdetail.subclass = "320" OR wdetail.subclass = "240C" THEN wdetail.subclass = "240C".
    ELSE wdetail.subclass = "110".
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
    ASSIGN wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
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
    wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
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
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
    RUN proc_chassic.
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
        sic_bran.uwm301.trareg  = nv_uwm301trareg
        sic_bran.uwm301.eng_no  = wdetail.eng
        sic_bran.uwm301.Tons    = INTEGER(wdetail.weight)
        sic_bran.uwm301.engine  = INTEGER(wdetail.cc)
        sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage  = wdetail.garage
        sic_bran.uwm301.body    = wdetail.body
        sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = wdetail.benname
        sic_bran.uwm301.vehreg   = substr(wdetail.vehreg,1,11) 
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
    IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN 
        ASSIGN n_class          = "210"
               wdetail.subclass = "140A".
    IF (wdetail.subclass = "240C") OR (wdetail.subclass = "320") THEN 
        ASSIGN n_class          = "320"
               wdetail.subclass = "240C".
    ELSE ASSIGN n_class = "110"
            wdetail.subclass = "110".
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
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
            wdetail.cargrp          =  stat.maktab_fil.prmpac
            sic_bran.uwm301.Tons    =  stat.maktab.tons
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body    =  stat.maktab_fil.body
            sic_bran.uwm301.engine  =  stat.maktab_fil.eng
            nv_engine   =  stat.maktab_fil.eng.
    END.
    ELSE DO:
        /*IF ra_typload =  2 THEN DO:   /* Non-til */
            FIND FIRST stat.insure USE-INDEX insure01  WHERE   
                stat.insure.compno = fi_model          AND          
                stat.insure.fname  = wdetail.model     NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL insure THEN  ASSIGN wdetail.model =  trim(stat.insure.lname)   .
        END.*/

        FIND FIRST stat.maktab_fil Use-index  maktab04           Where
            stat.maktab_fil.makdes   =   wdetail.brand            And                  
            INDEX(stat.maktab_fil.moddes,wdetail.model) <>  0     AND
            stat.maktab_fil.makyea   =   Integer(wdetail.caryear) AND
            /*stat.maktab_fil.engine   =   Integer(wdetail.cc)      AND*/
            stat.maktab_fil.sclass   =   n_class                 
/*             (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )   GE  deci(wdetail.si)    OR    */
/*              stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )   LE  deci(wdetail.si) )  /*AND */
/*              stat.maktab_fil.seats    GE  inte(wdetail.seat) */                                          */
            No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN
            ASSIGN 
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                   
            sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp          =  stat.maktab_fil.prmpac
            /*sic_bran.uwm301.seats   =  stat.maktab_fil.seat*/
            sic_bran.uwm301.engine  =  stat.maktab_fil.engine
            sic_bran.uwm301.Tons    =  stat.maktab.tons
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body    =  stat.maktab_fil.body   .
        
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_address c-Win 
PROCEDURE proc_address :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*10/81 หมู่บ้านดาวเรือง หมู่ 3 ถ.รังสิต-ปทุม ตำบลสวนพริกไทย อำเภอเมืองปทุมธานี จังหวัดปทุมธานี  12000  */
/*nv_address1*/
DEFINE VAR nv_len AS INTE.
ASSIGN 
    nv_address1 = trim(nv_maiAddress)
    nv_address2 = ""
    nv_address3 = ""
    nv_address4 = "".
/* แยก * ออกจากที่อยู่ */
    loop_add04:
    REPEAT:
        IF INDEX(nv_address1,"*") <> 0 THEN DO:
            nv_len = LENGTH(nv_address1).
            nv_address1 = SUBSTRING(nv_address1,1,INDEX(nv_address1,"*") - 1) +
                          SUBSTRING(nv_address1,INDEX(nv_address1,"*") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_add04.
    END.

/*จังหวัด /จ./กทม /กรุงเทพ */
IF R-INDEX(nv_address1,"กรุง") <> 0 THEN DO:
    ASSIGN 
        nv_address4 = trim(SUBSTR(TRIM(nv_address1),R-INDEX(nv_address1,"กรุง")))
        nv_address1 = trim(SUBSTR(TRIM(nv_address1),1,R-INDEX(nv_address1,"กรุง") - 1 )).
END.
ELSE IF R-INDEX(nv_address1,"กทม") <> 0 THEN DO:
    ASSIGN 
        nv_address4 = trim(SUBSTR(TRIM(nv_address1),R-INDEX(nv_address1,"กทม")))
        nv_address1 = trim(SUBSTR(TRIM(nv_address1),1,R-INDEX(nv_address1,"กทม") - 1 )).
END.
ELSE IF R-INDEX(nv_address1,"จังหวัด") <> 0 THEN DO:
    ASSIGN 
        nv_address4 = trim(SUBSTR(TRIM(nv_address1),R-INDEX(nv_address1,"จังหวัด")))
        nv_address1 = trim(SUBSTR(TRIM(nv_address1),1,R-INDEX(nv_address1,"จังหวัด") - 1 )).
END.
ELSE IF R-INDEX(nv_address1,"จ.") <> 0 THEN DO:
    ASSIGN 
        nv_address4 = trim(SUBSTR(TRIM(nv_address1),R-INDEX(nv_address1,"จ.")))
        nv_address1 = trim(SUBSTR(TRIM(nv_address1),1,R-INDEX(nv_address1,"จ.") - 1 )).
END.
IF INDEX(nv_address4," ") <> 0 THEN 
    ASSIGN nv_address4 = trim(SUBSTR(nv_address4,1,INDEX(nv_address4," "))) + " " +
                         trim(SUBSTR(nv_address4,INDEX(nv_address4," "))).


/* อำเภอ / เขต /อ. */
IF R-INDEX(nv_address1,"อำเภอ") <> 0 THEN DO:
    ASSIGN 
        nv_address3 = trim(SUBSTR(TRIM(nv_address1),R-INDEX(nv_address1,"อำเภอ")))
        nv_address1 = trim(SUBSTR(TRIM(nv_address1),1,R-INDEX(nv_address1,"อำเภอ") - 1 )).
END.
ELSE IF R-INDEX(nv_address1,"อ.") <> 0 THEN DO:
    ASSIGN 
        nv_address3 = trim(SUBSTR(TRIM(nv_address1),R-INDEX(nv_address1,"อ.")))
        nv_address1 = trim(SUBSTR(TRIM(nv_address1),1,R-INDEX(nv_address1,"อ.") - 1 )).
END.
ELSE IF R-INDEX(nv_address1,"เขต") <> 0 THEN DO:
    ASSIGN 
        nv_address3 = trim(SUBSTR(TRIM(nv_address1),R-INDEX(nv_address1,"เขต")))
        nv_address1 = trim(SUBSTR(TRIM(nv_address1),1,R-INDEX(nv_address1,"เขต") - 1 )).
END.
/*ตำบล / ต. /แขวง */ 
IF R-INDEX(nv_address1,"ตำบล") <> 0 THEN DO:
    ASSIGN 
        nv_address2 = trim(SUBSTR(TRIM(nv_address1),R-INDEX(nv_address1,"ตำบล")))
        nv_address1 = trim(SUBSTR(TRIM(nv_address1),1,R-INDEX(nv_address1,"ตำบล") - 1 )).
END.
ELSE IF R-INDEX(nv_address1,"ต.") <> 0 THEN DO:
    ASSIGN 
        nv_address2 = trim(SUBSTR(TRIM(nv_address1),R-INDEX(nv_address1,"ต.")))
        nv_address1 = trim(SUBSTR(TRIM(nv_address1),1,R-INDEX(nv_address1,"ต.") - 1 )).
END.
ELSE IF R-INDEX(nv_address1,"แขวง") <> 0 THEN DO:
    ASSIGN 
        nv_address2 = trim(SUBSTR(TRIM(nv_address1),R-INDEX(nv_address1,"แขวง")))
        nv_address1 = trim(SUBSTR(TRIM(nv_address1),1,R-INDEX(nv_address1,"แขวง") - 1 )).
END.
IF nv_address1 <> ""  THEN ASSIGN nv_address1 = REPLACE(nv_address1,"  "," ").
IF nv_address2 <> ""  THEN ASSIGN nv_address2 = REPLACE(nv_address2,"  "," ").
IF nv_address3 <> ""  THEN ASSIGN nv_address3 = REPLACE(nv_address3,"  "," ").
IF nv_address4 <> ""  THEN ASSIGN nv_address4 = REPLACE(nv_address4,"  "," ").
 
   IF LENGTH(nv_address1) > 35  THEN DO:
        loop_add01:
        DO WHILE LENGTH(nv_address1) > 35 :
            IF R-INDEX(nv_address1," ") <> 0 THEN DO:
                ASSIGN 
                    nv_address2  = trim(SUBSTR(nv_address1,r-INDEX(nv_address1," "))) + " " + nv_address2
                    nv_address1  = trim(SUBSTR(nv_address1,1,r-INDEX(nv_address1," "))).
        END.
        ELSE LEAVE loop_add01.
    END.
    IF LENGTH(nv_address2) > 35 THEN DO:
        loop_add02:
        DO WHILE LENGTH(nv_address2) > 35 :
            IF R-INDEX(nv_address2," ") <> 0 THEN DO:
                ASSIGN 
                    nv_address3   = trim(SUBSTR(nv_address2,r-INDEX(nv_address2," "))) + " " + nv_address3
                    nv_address2   = trim(SUBSTR(nv_address2,1,r-INDEX(nv_address2," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
    END.
    IF LENGTH(nv_address3) > 35 THEN DO:
        loop_add03:
        DO WHILE LENGTH(nv_address3) > 35 :
            IF R-INDEX(nv_address3," ") <> 0 THEN DO:
                ASSIGN 
                    nv_address4  = trim(SUBSTR(nv_address3,r-INDEX(nv_address3," "))) + " " + nv_address4
                    nv_address3  = trim(SUBSTR(nv_address3,1,r-INDEX(nv_address3," "))).
            END.
            ELSE LEAVE loop_add03.
        END.
    END.  
END.
ELSE DO:
    IF LENGTH(nv_address2 + " " + nv_address3) <= 35 THEN 
        ASSIGN 
        nv_address2 = nv_address2 + " " + nv_address3
        nv_address3 = nv_address4
        nv_address4 = "".
    ELSE IF  LENGTH(nv_address3 + " " + nv_address4) <= 35 THEN 
        ASSIGN 
        nv_address3 = nv_address3 + " " + nv_address4
        nv_address4 = "".
END.
IF nv_address4 <> "" AND LENGTH(nv_address4) > 20 THEN DO:
    ASSIGN nv_address4 = REPLACE(nv_address4,"จังหวัด","จ.").
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign c-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: รับค่าตัวแปรเก็บใน wdetail      
------------------------------------------------------------------------------*/
DEFINE VAR nv_len AS INTE.
DO: 
    For each  wdetail :                              
        DELETE  wdetail.                             
    END.
    FOR EACH wdetailmemo.
        DELETE wdetailmemo.
    END.
    FOR EACH wprmt  .
        DELETE wprmt .
    END.
    RUN proc_assigninit.
    INPUT FROM VALUE (fi_filename) . 
    REPEAT:     
        IMPORT DELIMITER "|"          
            nv_contract      /*CONTRACT*/          /*  contract no */   /*nv_title         /*TITLE*/             /*  Title name  */  */                 
            nv_Name          /*NAME*/              /*  Name    *//*nv_sName         /*S_NAME*/            /*  S-name  */     */                
            nv_address1    /*REG_ADDRESS1*/      /*  reg.address */ 
            nv_brand         /*BRAND*/             /*  brand   */                       
            nv_modelTPIS     /*MODEL*/             /*  model   */                     
            nv_modelYear     /*YEAR*/              /*  year    */                                 
            nCOLOUR          /*COLOUR*/            /*  color   */                                 
            nv_cc            /*CC*/                /*  cc  */                                     
            nv_engNum        /*ENG_NUM*/           /*  engine no   */                             
            nv_chassis       /*CHASSIS*/           /*  chassis */                                 
            nv_licence      /*LICENSE*/           /*  licence no  */                             
            nv_province      /*PROVINCE*/          /*  province    */                                       
            nv_insCom        /*INS_COM*/           /*  insurance comp. */             
            nv_insDate       /*INS_DATE*/          /*  insurance date. */                        
            nv_expDate       /*EXP_DATE*/          /*  expdat  */                     
            nv_package       /*PACKAGE*/           /*  Package */                     
            nv_branch        /*BRANCH*/            /*  Branch  */                     
            nv_dealer 
            nv_cover        /*COVVER*/            /*  Covver  */                     
            nv_vehuse72
            nvclass72  
            nv_insAmount     /*INS_AMT*/           /*  insurance amount    */                     
            nv_netPrem       /*NET_PREM(VOL)*/     /*  Net Premium (Voluntary).*/     
            nv_premium       /*PREMIUM(VOL)*/      /*  premium(voluntary)  */         
            nv_compulsory    /*COMPULSORY*/        /*  compulsory no.          */     
            nsticker         /*stkno.....*/        /*  Sticker no.             */     
            nv_recive        /*RECIVE_NO*/         /*  recive no.              */     
            nv_netPrem1      /*NET_PREM(COM)*/     /*  Net Premium (Compulsory)    */ 
            nv_premium1      /*PREMIUM(COM)*/      /*  premium(commpulsory)        */ 
            nv_maiAddress    /*Mai_Address*/       /*  mailing address             */ 
            nv_idNum         /*ID_Number*/         /*  IDcard number               */ 
            nv_insType      /*INS_TYPE*/          /*  Insurance Type              */ 
            nv_bennames 
            nv_f6acc1
            nv_f6acc2
            nv_f6acc3
            nv_f18_1 
            nv_f18_2 
            nv_f18_3 
            nv_f18_4 
            nv_f18_5 .
        IF      index(nv_contract,"THAI") <> 0          THEN RUN proc_assigninit.
        ELSE IF index(nv_contract,"contract no") <> 0   THEN RUN proc_assigninit.
        ELSE IF  nv_chassis = ""                        THEN RUN proc_assigninit.
        ELSE DO:
            
            /*RUN proc_province_bran.*/
            IF nv_address1 <> "" THEN RUN proc_address.
            ASSIGN nv_polno = "".
            IF length(trim(nv_chassis)) > 9  THEN
                ASSIGN nv_polno = SUBSTR(trim(nv_chassis),LENGTH(trim(nv_chassis)) - 9 ) .
            ELSE ASSIGN nv_polno = trim(nv_chassis).
            FIND FIRST wdetail WHERE wdetail.policy = "70" + trim(nv_polno)   NO-ERROR NO-WAIT.   
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN
                    wdetail.policy      = "70" + trim(nv_polno) 
                    WDETAIL.POLTYP      = "V70"
                    wdetail.cedpol      = trim(nv_contract) 
                    wdetail.branch      = TRIM(nv_branch ) /*-สาขา-*/
                    /*wdetail.tiname      = trim(nv_title) */
                    wdetail.insnam      = TRIM(nv_Name) 
                    wdetail.iadd1       = trim(nv_address1)
                    wdetail.iadd2       = trim(nv_address2)
                    wdetail.iadd3       = trim(nv_address3)
                    wdetail.iadd4       = trim(nv_address4)
                    wdetail.ICNO        = trim(nv_idNum) 
                    wdetail.brand       = trim(nv_brand)  
                    wdetail.model       = IF length(TRIM(nv_modelTPIS)) > 6 THEN  SUBSTR(trim(nv_modelTPIS),1,6) ELSE TRIM(nv_modelTPIS)
                    wdetail.caryear     = trim(nv_modelYear) 
                    wdetail.cc          = trim(nv_cc)
                    wdetail.vehuse      = IF nv_vehuse72 = "" THEN "1" ELSE trim(nv_vehuse72)        /* ประเภทการใช้งานรถ */
                    wdetail.vehreg      = trim(nv_licence)  + " " + (nv_changwat)
                    wdetail.engno       = trim(nv_engNum)
                    wdetail.chasno      = trim(nv_chassis)
                    wdetail.vehreg      = trim(nv_licence) + " " + 
                                          trim(nv_province)
                    wdetail.comdat      = trim(nv_insDate)
                    wdetail.expdat      = trim(nv_expDate)
                    wdetail.prempa      = substr(trim(nv_package),1,1)  
                    wdetail.subclass    = substr(trim(nv_package),2,3) 
                    wdetail.covcod      = TRIM(nv_cover)
                    wdetail.si          = trim(nv_insAmount)
                    wdetail.netprem     = trim(nv_netPrem)
                    wdetail.volprem     = trim(nv_premium)
                    wdetail.compul      = "n"
                    wdetail.stk         = ""
                    wdetail.seat        = IF      wdetail.subclass = "320" THEN "3" 
                                          ELSE IF wdetail.subclass = "110" THEN "7"
                                          ELSE "12" 
                    wdetail.garage      = ""
                    wdetail.comment     = "" 
                    wdetail.producer    = trim(fi_producer) 
                    wdetail.agent       = trim(fi_agent)  
                    wdetail.entdat      = string(TODAY)             /*entry date*/
                    wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
                    wdetail.trandat     = STRING(TODAY)             /*tran date*/
                    wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
                    wdetail.n_IMPORT    = "IM"
                    wdetail.n_EXPORT    = "" 
                    wdetail.pass        = "y"
                    /*wdetail.changwat    = trim(nv_changwat)*/
                    wdetail.benname     = TRIM(nv_bennames)  .
            FIND FIRST brstat.msgcode WHERE 
                brstat.msgcode.compno = "999"  AND 
                index(wdetail.insnam,brstat.msgcode.MsgDesc) <> 0   NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.msgcode THEN  
                ASSIGN 
                wdetail.tiname  =  trim(brstat.msgcode.branch)
                wdetail.insnam  =  SUBSTR(TRIM(wdetail.insnam),LENGTH(brstat.msgcode.MsgDesc) + 1 ).
            ELSE   wdetail.tiname = "คุณ".
            /*ถ้า ทะเบียน ว่าง ไปเอา เลขถัง  / + NDT001763 */

            IF wdetail.vehreg = ""   THEN DO: 
                IF LENGTH(wdetail.chasno) > 9 THEN
                    ASSIGN   
                    wdetail.chasno  = trim(wdetail.chasno)
                    wdetail.vehreg  = "/" + SUBSTR(TRIM(wdetail.chasno),LENGTH(wdetail.vehreg) + 8 ).
                ELSE wdetail.vehreg  = "/" + TRIM(wdetail.chasno).
            END.
            ELSE DO:  /*ทะเบียนมีค่า*/
                IF R-INDEX(wdetail.vehreg," ") <> INDEX(wdetail.vehreg," ") THEN DO:
                    IF (SUBSTR(wdetail.vehreg,1,1) >= "1" )  AND (SUBSTR(wdetail.vehreg,1,1) <= "9" ) THEN
                        ASSIGN wdetail.vehreg = trim(SUBSTR(wdetail.vehreg,1,INDEX(wdetail.vehreg," "))) + 
                        trim(SUBSTR(wdetail.vehreg,INDEX(wdetail.vehreg," "))).
                END.
            END.
            /*
            loop_add05:
            REPEAT:
                IF INDEX(nv_licence," ") <> 0 THEN DO:
                    nv_len = LENGTH(nv_licence).
                    nv_licence = SUBSTRING(nv_licence,1,INDEX(nv_licence," ") - 1) + 
                                 SUBSTRING(nv_licence,INDEX(nv_licence," ") + 1, nv_len ) .
                END.
                ELSE LEAVE loop_add05.
            END.*/


           
            
            
            
            
            /* nv_licence = wdetail.vehreg.

        IF  SUBSTR(wdetail.vehreg,1,1) <> "/" THEN DO:
            IF SUBSTR(wdetail.vehreg,1,1) >= "1" AND SUBSTR(wdetail.vehreg,1,1) <= "9"  THEN DO:
                IF SUBSTR(wdetail.vehreg,2,1) >= "1" AND SUBSTR(wdetail.vehreg,2,1) <= "9" THEN DO:
                    wdetail.vehreg = TRIM(SUBSTR(nv_licence,1,2)) + " " + TRIM(SUBSTR(nv_licence,3,5)) + " " + nv_province.
                END.
                ELSE wdetail.vehreg = TRIM(SUBSTR(nv_licence,1,3)) + " " + TRIM(SUBSTR(nv_licence,4,5)) + " " + nv_province.
            END.
            ELSE DO:
                wdetail.vehreg = TRIM(SUBSTR(nv_licence,1,2)) + " " + TRIM(SUBSTR(nv_licence,3,5)) + " " + nv_province.
            END.
        END.
        ELSE wdetail.vehreg = wdetail.vehreg.*/
                
                /* ASSIGN  
                wdetail.vehreg  = TRIM(wdetail.vehreg) .*/ 

                   
                IF  nv_f18_1 <> "" OR
                    nv_f18_2 <> "" OR nv_f18_3 <> "" OR
                    nv_f18_4 <> "" OR nv_f18_5 <> "" THEN DO:
                    FIND FIRST   wdetailmemo WHERE wdetailmemo.policy = "70" + trim(nv_polno) NO-ERROR NO-WAIT.
                    IF NOT AVAIL wdetailmemo THEN DO:
                        CREATE wdetailmemo.
                        ASSIGN 
                           wdetailmemo.policy      = "70" + trim(nv_polno) 
                           wdetailmemo.reportDate  = trim(nv_reportDate)
                           wdetailmemo.dateReq     = trim(nv_dateReq)
                           wdetailmemo.ref_no      = TRIM(nv_refno)
                           wdetailmemo.ModelTPIS   = TRIM(nv_modelTPIS)
                           wdetailmemo.inscom      = TRIM(nv_insCom )    
                           wdetailmemo.Polnum      = TRIM(nv_polnum)
                           wdetailmemo.LPBName     = TRIM(nv_LPBName)  
                           wdetailmemo.mktOff      = TRIM(nv_mktOff)   
                           wdetailmemo.oldCont     = TRIM(nv_oldCont)  
                           wdetailmemo.CAT3        = TRIM(nv_CAT3)     
                           wdetailmemo.DATE491     = TRIM(nv_DATE491)  
                           wdetailmemo.DATE724     = TRIM(nv_DATE724)  
                           wdetailmemo.memotxt1    = trim(nv_ISP)   
                           wdetailmemo.memotxt2    = trim(nv_f18_1)
                           wdetailmemo.memotxt3    = trim(nv_f18_2)   
                           wdetailmemo.memotxt4    = trim(nv_f18_3)   
                           wdetailmemo.memotxt5    = trim(nv_f18_4)   
                           wdetailmemo.memotxt6    = trim(nv_f18_5). 
                    END.  /* wdetailmemo */
                END.  /*nv_ISP */
                IF nv_f6acc1 <> ""  OR nv_f6acc2 <> "" OR nv_f6acc3  <> "" THEN DO:
                    FIND FIRST   wprmt WHERE wprmt.policy = "70" + trim(nv_polno) NO-ERROR NO-WAIT.
                    IF NOT AVAIL wprmt THEN DO:
                        CREATE wprmt.
                        ASSIGN 
                            wprmt.policy         = "70" + trim(nv_polno)
                            wprmt.premtacc1      = trim(nv_f6acc1)
                            wprmt.premtacc2      = trim(nv_f6acc2)
                            wprmt.premtacc3      = trim(nv_f6acc3).
                    END.
                END.

               /* comment  ....................*/
            END.  /*wdetail */
            /*IF  nv_compulsory <> "" OR nv_netPrem1 <> ""  THEN proc_assign72.*//*  create 72*/
            /*พรบ. */
            IF  (trim(nv_compulsory) <> "" ) OR (trim(nv_netPrem1) <> "" ) THEN RUN proc_assign72. 
            RUN proc_assigninit.
        END. /*else do: */
    END.
END.    /* repeat   */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign72 c-Win 
PROCEDURE proc_assign72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.policy = "72" + trim(nv_polno)   NO-ERROR NO-WAIT.   
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN
        wdetail.policy      = "72" + trim(nv_polno) 
        WDETAIL.POLTYP      = "V72"
        wdetail.cedpol      = trim(nv_contract) 
        wdetail.branch      = TRIM(nv_branch ) /*-สาขา-*/
        /*wdetail.tiname      = trim(nv_title) */
        wdetail.insnam      = TRIM(nv_Name) 
        wdetail.iadd1       = trim(nv_address1)
        wdetail.iadd2       = trim(nv_address2)
        wdetail.iadd3       = trim(nv_address3)
        wdetail.iadd4       = trim(nv_address4)
        wdetail.ICNO        = trim(nv_idNum) 
        wdetail.brand       = trim(nv_brand)  
        wdetail.model       = IF length(TRIM(nv_modelTPIS)) > 6 THEN  SUBSTR(trim(nv_modelTPIS),1,6) ELSE TRIM(nv_modelTPIS)
        wdetail.caryear     = trim(nv_modelYear) 
        wdetail.cc          = trim(nv_cc)
        wdetail.vehuse      = IF nv_vehuse72 = "" THEN "1" ELSE TRIM(nv_vehuse72)        /* ประเภทการใช้งานรถ */ 
        wdetail.vehreg      = trim(nv_licence)  + " " + (nv_changwat)
        wdetail.engno       = trim(nv_engNum)
        wdetail.chasno      = trim(nv_chassis)
        wdetail.vehreg      = trim(nv_licence) + " " + 
        trim(nv_province)
        wdetail.comdat      = trim(nv_insDate)
        wdetail.expdat      = trim(nv_expDate)
        wdetail.prempa      = substr(trim(nv_package),1,1)  
        wdetail.subclass    = IF TRIM(nvclass72) <> "" THEN TRIM(nvclass72)
                              ELSE IF substr(trim(nv_package),2,3) = "320" THEN "240C"
                              ELSE "110"
        
        wdetail.covcod      = "T"
        wdetail.si          = trim(nv_insAmount)
        wdetail.netprem     = trim(nv_netPrem)
        wdetail.volprem     = trim(nv_premium)
        wdetail.compul      = "y"
        wdetail.stk         = TRIM(nsticker)
        wdetail.seat        = IF      wdetail.subclass = "320" THEN "3" 
        ELSE IF wdetail.subclass = "110" THEN "7"
        ELSE "12" 
        wdetail.garage      = ""
        wdetail.comment     = "" 
        wdetail.producer    = trim(fi_producer) 
        wdetail.agent       = trim(fi_agent)  
        wdetail.entdat      = string(TODAY)             /*entry date*/
        wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
        wdetail.trandat     = STRING(TODAY)             /*tran date*/
        wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
        wdetail.n_IMPORT    = "IM"
        wdetail.n_EXPORT    = "" 
        wdetail.pass        = "y"
        /*wdetail.changwat    = trim(nv_changwat)*/
        wdetail.benname     = "" .
            
    FIND FIRST brstat.msgcode WHERE 
        brstat.msgcode.compno = "999"  AND 
        index(wdetail.insnam,brstat.msgcode.MsgDesc) <> 0   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN  
        ASSIGN 
        wdetail.tiname  =  trim(brstat.msgcode.branch)
        wdetail.insnam  =  SUBSTR(TRIM(wdetail.insnam),LENGTH(brstat.msgcode.MsgDesc) + 1 ).
    ELSE   wdetail.tiname = "คุณ".
    IF wdetail.vehreg = ""   THEN DO: 
        IF LENGTH(wdetail.chasno) > 9 THEN
            ASSIGN   
            wdetail.chasno  = trim(wdetail.chasno)
            wdetail.vehreg  = "/" + SUBSTR(TRIM(wdetail.chasno),LENGTH(wdetail.vehreg) + 8 ).
        ELSE wdetail.vehreg  = "/" + TRIM(wdetail.chasno).
    END.
    ELSE DO:  /*ทะเบียนมีค่า*/
        IF R-INDEX(wdetail.vehreg," ") <> INDEX(wdetail.vehreg," ") THEN DO:
            IF (SUBSTR(wdetail.vehreg,1,1) >= "1" )  AND (SUBSTR(wdetail.vehreg,1,1) <= "9" ) THEN
                ASSIGN wdetail.vehreg = trim(SUBSTR(wdetail.vehreg,1,INDEX(wdetail.vehreg," "))) + 
                trim(SUBSTR(wdetail.vehreg,INDEX(wdetail.vehreg," "))).
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigninit c-Win 
PROCEDURE proc_assigninit :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: เคลียร์ค่าตัวแปร      
------------------------------------------------------------------------------*/
ASSIGN
    nv_polno               = ""
    nv_contract            = ""           
    nv_title               = ""           
    nv_Name                = ""           
    nv_sName               = ""           
    nREG_ADDRESS1          = ""           
    nv_brand               = ""           
    nv_modelTPIS           = ""           
    nv_modelYear           = ""           
    nCOLOUR                = ""           
    nv_cc                  = ""           
    nv_engNum              = ""           
    nv_chassis             = ""           
    nv_licence             = ""           
    nv_province            = ""           
    nv_insCom              = ""           
    nv_insDate             = ""           
    nv_expDate             = ""           
    nv_package             = ""           
    nv_branch              = ""           
    nv_cover              = ""           
    nv_insAmount           = ""           
    nv_netPrem             = ""           
    nv_premium             = ""           
    nv_compulsory          = ""           
    nsticker               = ""           
    nv_recive              = ""           
    nv_netPrem1            = ""           
    nv_premium1            = ""           
    nv_maiAddress          = ""           
    nv_idNum               = ""           
    nv_insType             = ""   
    nv_vehuse72            = ""
    nvclass72              = "" 
    nv_dealer    = ""
    nv_f6acc1    = ""   
    nv_f6acc2    = ""   
    nv_f6acc3    = ""   
  nv_reportDate = ""
  nv_dateReq    = ""       
  nv_contract   = ""     
  nv_refno      = ""          
  nv_title      = ""          
  nv_custName   = ""          
  nv_address1   = ""          
  nv_address2   = ""          
  nv_address3   = ""         
  nv_postCode   = ""       
  nv_icno       = ""       
  nv_birthDate  = ""       
  nv_tel        = ""       
  nv_brand      = ""       
  nv_modelTPIS  = "" 
  nv_modelSaf   = ""
  nv_modelYear  = ""       
  nv_cc         = ""   
  /*nv_cover      = ""  */
  nv_typeVeh    = ""       
  nv_insCom     = ""       
  nv_licence    = ""
  nv_changwat   = "" 
  nv_chassis    = ""       
  nv_engNum     = ""       
  nv_insAmount  = "" 
  nv_netPrem    = "" 
  nv_premium    = ""           
  nv_polNum     = ""       
  nv_comDate    = ""       
  nv_expDate    = ""       
  nv_LPBName    = ""       
  nv_mktOff     = ""       
  nv_oldCont    = ""     
  nv_CAT3       = ""       
  nv_date491    = ""       
  nv_date724    = ""
  nv_ISP        = ""      
  nv_f18_1      = "" 
  nv_f18_2      = "" 
  nv_f18_3      = "" 
  nv_f18_4      = "" 
  nv_f18_5      = ""
  nREG_ADDRESS1 = ""   
  nREG_ADDRESS2 = ""   
  nREG_ADDRESS3 = ""   
  nREG_CODE     = ""   
  nCOLOUR       = ""
  nsticker             = ""        
  nINS_COM1            = ""     
  nINSRQST1            = ""     
  nINS_EXP1            = ""     
  nPOL_NUM1            = ""     
  nPREMIUM1            = ""     
  nYR_EXT              = ""     
  nINS_COLL_OLD_CONT   = ""     
  nNEW_OLD             = ""     
  nINS_RQST            = ""     
  nENDORSE             = ""     
  nYR_EXT2             = ""     
  nINS_COLL            = ""    .
                            
                       
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
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF (wdetail.covcod <> "2.1") OR (wdetail.covcod <> "3.1") AND wdetail.base = "" THEN DO:
    ASSIGN aa = 0 nv_dss_per = 0  WDETAIL.NCB = 0 dod1 = 0.
    IF (wdetail.subclass = "110") OR 
       (wdetail.subclass = "210") OR 
       (wdetail.subclass = "320") AND 
       (wdetail.prempa    = "V" ) THEN RUN proc_dsp_ncb.
    ELSE 
            ASSIGN aa = nv_basere . 
            RUN wgs\wgsfbas.
            ASSIGN aa = nv_baseprm.
    

   ASSIGN 
        chk = NO
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
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN  nv_prem1   = nv_baseprm
        nv_basecod = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.

    /*-------nv_add perils----------*/
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
    Assign  
        nv_totsi     = 0
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
         nv_bipvar2     =  STRING(uwm130.uom1_v) 
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign 
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     =   STRING(uwm130.uom2_v)
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     Assign
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         nv_pdavar2     =  STRING(uwm130.uom5_v)
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
    
        ASSIGN nv_ded1prm     = nv_prem
          nv_dedod1_prm     = nv_prem
          nv_dedod1_cod     = "DOD"
          nv_dedod1var1     = "     Deduct OD = "
          nv_dedod1var2     = STRING(dod1)
          SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
          SUBSTRING(nv_dedod1var,31,30) =  nv_dedod1var2.
    
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
    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base21 c-Win 
PROCEDURE proc_base21 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR model   AS CHAR FORMAT "x(30)".
ASSIGN fi_process = "Check Base Plus+ data HCT 2+3+...." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") AND wdetail.base = "" THEN DO:
    ASSIGN aa = 0  nv_dss_per = 0  WDETAIL.NCB = 0 .
    IF (wdetail.subclass = "110") OR 
       (wdetail.subclass = "210") OR 
       (wdetail.subclass = "320") AND 
       (wdetail.prempa    = "C" ) THEN  RUN proc_dsp_ncb1 .
    ELSE DO:
            
            RUN wgs\wgsfbas.
            ASSIGN aa = nv_baseprm.
     END.
   
    ASSIGN
        chk = NO
        NO_basemsg  = ""
        nv_baseprm  = aa
        nv_dss_per  = 0  .

    /*-----nv_drivcod---------------------*/
        
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
        
        ASSIGN  nv_drivvar = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2. 
       END. 
    
    /*-------nv_baseprm----------*/
    
    IF NO_basemsg <> " " THEN  wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN nv_prem1 = nv_baseprm
        nv_basecod  = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
   
    /*-------nv_add perils----------*/
    
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
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat).      
    /*------nv_usecod------------*/
    ASSIGN 
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30) = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  wdetail.subclass.       
    RUN wgs\wgsoeng.

    /*-----nv_yrcod---------- 1. ------------------*/  
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
        nv_totsi     = deci(wdetail.si) .  
    /*----------nv_grpcod--------------------*/
    ASSIGN  nv_grpcod      = "GRP" + wdetail.cargrp
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
   IF (wdetail.covcod = "2.1") THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "21" .
    ELSE nv_usecod3 = "U" + TRIM(nv_vehuse) + "31" .
    ASSIGN   
        nv_usevar4 = "     Vehicle Use = "
        nv_usevar5 =  wdetail.vehuse
        Substring(nv_usevar3,1,30)   = nv_usevar4
        Substring(nv_usevar3,31,30)  = nv_usevar5.

     ASSIGN  nv_basecod3 = IF (wdetail.covcod = "2.1") THEN "BA21" ELSE "BA31".
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
        nv_sicod3    = IF (wdetail.covcod = "2.1") THEN "SI21"  ELSE "SI31"
        nv_sivar4    = "     Own Damage = "
        nv_sivar5    = wdetail.si
        SUBSTRING(nv_sivar3,1,30)  = nv_sivar4
        SUBSTRING(nv_sivar3,31,30) = nv_sivar5 .
        nv_totsi     = deci(wdetail.si) .
    Assign
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         nv_pdavar2     =  STRING(uwm130.uom5_v)
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.

     RUN WGS\WGSORPR1.P (INPUT  nv_tariff,  
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                DECI(wdetail.si),
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).   /*kridtiya i.*/
     /*--------------- deduct ----------------*/
      
      IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") THEN ASSIGN dod1 = dod1.
      IF dod1 = 0 THEN
            ASSIGN dod1 = 2000.
      ELSE DO:
         IF dod0 > 3000 THEN DO:
             dod1 = 3000.
             dod2 = dod0 - dod1.
         END.
     END.
     MESSAGE dod1 VIEW-AS ALERT-BOX.
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
             wdetail.pass    = "N"
             wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
     END.
     /*dod*/
     ASSIGN 
         /*nv_prem           =  dod1   /*A57-0176 kridtiya */ */
         nv_ded1prm        = nv_prem
         nv_dedod1_prm     = nv_prem.    /*A57-0176 */
     RUN WGS\WGSORPR1.P (INPUT  nv_tariff,  /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                DECI(wdetail.si),
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).  
     ASSIGN
         nv_dedod1var      = ""
         nv_dedod1_cod     = "DOD"
         nv_dedod1var1     = "     Deduct OD = "
         nv_dedod1var2     = STRING(dod1)
         SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
         SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2  .
    
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
         nv_dedpd_prm  = nv_prem  .    /*A57-0177*/
     /*---------- fleet -------------------*/
     nv_flet_per = INTE(wdetail.fleet).
     IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
         Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
         ASSIGN
             wdetail.pass    = "N"
             wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
     End.
     IF nv_flet_per = 0 Then do:
         ASSIGN nv_flet     = 0
             nv_fletvar  = " ".
     End.
     RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                DECI(wdetail.si),
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).
     ASSIGN  nv_fletvar     = " "
         nv_fletvar1    = "     Fleet % = "
         nv_fletvar2    =  STRING(nv_flet_per)
         SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
         SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     NV_NCBPER = WDETAIL.NCB.
     ASSIGN  
         nv_ncb  = wdetail.ncb
         NV_NCBPER = wdetail.ncb
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
     
     /*------------------ dsspc ---------------*/
   
         nv_dsspcvar   = " ".
         Assign                
             nv_dss_per = 0 .     
         IF  nv_dss_per   <> 0  THEN
             Assign
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
         END.
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
         IF nv_gapprm <> DECI(wdetail.premt)  THEN  DO:
             IF (nv_gapprm - DECI(wdetail.premt)) < 3 THEN DO:
                 
                 RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*pass*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 c-Win 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail.vehreg = " " AND wdetail.prvpol  = " " THEN DO: 
    ASSIGN  wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N". 
END.
ELSE DO:
    IF wdetail.prvpol = " " THEN DO:     /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
        Def  var  nv_vehreg     as char  init  " ".
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
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.prempa = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.subclass = " " THEN DO:
    ASSIGN wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
END. /*can't block in use*/ 
IF wdetail.brand = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"        
        wdetail.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N".
IF wdetail.seat  = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
ASSIGN nv_modcod = ""
    nv_maxsi  = 0
    nv_minsi  = 0
    nv_si     = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred    = NO
    n_model   = "".     
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
            wdetail.brand    =  stat.maktab_fil.makdes
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
            wdetail.cc       =  STRING(stat.maktab_fil.engine)
            wdetail.redbook  =  stat.maktab_fil.modcod                                    
            nv_si            =  maktab_fil.si.
        IF wdetail.covcod = "1"  THEN DO:
            FIND FIRST stat.makdes31 WHERE 
                stat.makdes31.makdes = "X"  AND     /*Lock X*/
                stat.makdes31.moddes = wdetail.prempa + wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE makdes31 THEN 
                ASSIGN nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
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
END.                       /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN 
        n_ratmin = makdes31.si_theft_p   
        n_ratmax = makdes31.load_p   .    
    ELSE ASSIGN n_ratmin = 0
                n_ratmax = 0.
    ASSIGN nv_model   = "".  
    FIND FIRST stat.insure USE-INDEX insure01  WHERE   
        stat.insure.compno = wdetail.model     AND        
        stat.insure.fname  = wdetail.model     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL insure THEN  ASSIGN nv_model =  stat.insure.lname   .
    ELSE ASSIGN nv_model =  wdetail.model .
    FIND FIRST stat.maktab_fil Use-index  maktab04           Where
        stat.maktab_fil.makdes   =   wdetail.brand            And                  
        INDEX(stat.maktab_fil.moddes,nv_model) <>  0          AND
        stat.maktab_fil.makyea   =   Integer(wdetail.caryear) AND
        stat.maktab_fil.engine   =   Integer(wdetail.cc)      AND
        stat.maktab_fil.sclass   =   wdetail.subclass         AND 
       (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )   GE  deci(wdetail.si)    AND
        stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )   LE  deci(wdetail.si) )  No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN  
        nv_modcod          =  stat.maktab_fil.modcod                                    
        nv_moddes          =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp     =  stat.maktab_fil.prmpac
        wdetail.redbook    =  stat.maktab_fil.modcod  .
    IF wdetail.model = ""  THEN 
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
FOR EACH wdetail:
    IF  wdetail.policy = ""  THEN NEXT.
    /*------------------  renew ---------------------*/
    ASSIGN fi_process    = "Check  data TPIS...." + wdetail.policy.    
    DISP fi_process WITH FRAM fr_main.
    RUN proc_cr_2.
    ASSIGN 
        n_rencnt = 0
        n_endcnt = 0
        nv_driver = "".
    IF wdetail.poltyp = "v72"  THEN DO:
        RUN proc_72.
        RUN proc_policy. 
        RUN proc_722.
        RUN proc_723 (INPUT  s_recid1,       
                      INPUT  s_recid2,
                      INPUT  s_recid3,
                      INPUT  s_recid4,
                      INPUT-OUTPUT nv_message).


    END.
    ELSE DO:
        IF wdetail.prvpol <> " " THEN RUN proc_renew.
        RUN proc_chktest0.
        RUN proc_policy . 
        RUN proc_chktest2.      
        RUN proc_chktest3.      
        RUN proc_chktest4.   
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
  Notes: เลขที่ BATCH NO.      
------------------------------------------------------------------------------*/
DEFINE VAR np_driver AS CHAR FORMAT "x(23)" INIT "".
ASSIGN fi_process    = "Import data TIL-renew to uwm130..." + wdetail.policy .    /*A56-0262*/
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
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno
        sic_bran.uwm130.bchyr  = nv_batchyr        /* batch Year */
        sic_bran.uwm130.bchno  = nv_batchno        /* bchno      */
        sic_bran.uwm130.bchcnt = nv_batcnt         /* bchcnt     */
        np_driver = TRIM(sic_bran.uwm130.policy) +
                STRING(sic_bran.uwm130.rencnt,"99" ) +
                STRING(sic_bran.uwm130.endcnt,"999") +
                STRING(sic_bran.uwm130.riskno,"999") +
                STRING(sic_bran.uwm130.itemno,"999")
        nv_sclass = wdetail.subclass.
    IF nv_uom6_u  =  "A"  THEN DO:
        IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
            nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
            Then  nv_uom6_u  =  "A".         
        Else 
            ASSIGN
                wdetail.pass    = "N"
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
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1" ) THEN 
        ASSIGN
        sic_bran.uwm130.uom6_v   = inte(wdetail.si)
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
                wdetail.seat41 = stat.clastab_fil.dri_41 + clastab_fil.pass_41
                nv_seat41      =   stat.clastab_fil.dri_41 + clastab_fil.pass_41 .  
            Else Assign nv_41       =  stat.clastab_fil.si_41pai
                nv_42       =  stat.clastab_fil.si_42
                nv_43       =  stat.clastab_fil.impsi_43
                wdetail.seat41 = stat.clastab_fil.dri_41 + clastab_fil.pass_41
                nv_seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41. 
        END.
        ELSE ASSIGN 
            sic_bran.uwm130.uom1_v     =  nv_uom1_v 
            sic_bran.uwm130.uom2_v     =  nv_uom2_v 
            sic_bran.uwm130.uom5_v     =  nv_uom5_v .
        IF (n_sclass72 = "210") OR (n_sclass72 = "v210") THEN nv_seat41 = 3.
    END.
    ASSIGN  
        nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                         nv_riskno,
                         nv_itemno).
END.   /* end Do transaction*/
ASSIGN 
    s_recid3  = RECID(sic_bran.uwm130)
    nv_covcod =   wdetail.covcod
    nv_makdes  =  wdetail.brand
    nv_moddes  =  wdetail.model
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
    sic_bran.uwm301.bchcnt = nv_batcnt NO-WAIT NO-ERROR.
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
    sic_bran.uwm301.covcod    = nv_covcod
    sic_bran.uwm301.cha_no    = wdetail.chasno
    sic_bran.uwm301.trareg    = nv_uwm301trareg
    sic_bran.uwm301.eng_no    = wdetail.eng
    sic_bran.uwm301.Tons      = nv_tons
    sic_bran.uwm301.engine    = INTEGER(wdetail.cc)
    sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage    = wdetail.garage
    sic_bran.uwm301.logbok    = wdetail.inspec 
    sic_bran.uwm301.body      = wdetail.body
    sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv_ben83  = wdetail.benname
    sic_bran.uwm301.vehreg    = substr(wdetail.vehreg,1,11)
    sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
    sic_bran.uwm301.vehuse    = wdetail.vehuse
    sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
    sic_bran.uwm301.sckno     = 0
    sic_bran.uwm301.itmdel    = NO
    sic_bran.uwm301.prmtxt    = ""
    wdetail.tariff            = sic_bran.uwm301.tariff.

IF wdetail.poltyp = "v70" THEN DO:
    FIND LAST wprmt WHERE wprmt.policy = wdetail.policy NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL wprmt THEN
        ASSIGN 
        SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  wprmt.premtacc1     
        SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  wprmt.premtacc2 
        SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  wprmt.premtacc3 .
END.
IF wdetail.compul = "y" THEN DO:
    sic_bran.uwm301.cert = "".
    IF LENGTH(wdetail.stk) = 11 THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
    IF LENGTH(wdetail.stk) = 13  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
    IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".
    FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
        brStat.Detaitem.serailno   = wdetail.stk         AND
        brstat.detaitem.yearReg    = nv_batchyr          AND
        brstat.detaitem.seqno      = STRING(nv_batchno)  AND
        brstat.detaitem.seqno2     = STRING(nv_batcnt)   NO-ERROR NO-WAIT.
    IF NOT AVAIL brstat.Detaitem THEN DO:     
        CREATE brstat.Detaitem.
        ASSIGN 
            brStat.Detaitem.Policy   = sic_bran.uwm301.Policy
            brStat.Detaitem.RenCnt   = sic_bran.uwm301.RenCnt
            brStat.Detaitem.EndCnt   = sic_bran.uwm301.Endcnt
            brStat.Detaitem.RiskNo   = sic_bran.uwm301.RiskNo
            brStat.Detaitem.ItemNo   = sic_bran.uwm301.ItemNo
            brStat.Detaitem.serailno = wdetail.stk  
            brstat.detaitem.yearReg  = sic_bran.uwm301.bchyr
            brstat.detaitem.seqno    = STRING(sic_bran.uwm301.bchno)     
            brstat.detaitem.seqno2   = STRING(sic_bran.uwm301.bchcnt).  
    END.
END.
/*driver */
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
END.
ASSIGN  
    sic_bran.uwm301.bchyr   = nv_batchyr  /* batch Year */
    sic_bran.uwm301.bchno   = nv_batchno  /* bchno      */
    sic_bran.uwm301.bchcnt  = nv_batcnt   /* bchcnt     */
    s_recid4                = RECID(sic_bran.uwm301).
IF wdetail.redbook <> ""  /*AND chkred = YES*/  THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 
        WHERE stat.maktab_fil.sclass = wdetail.subclass AND
        stat.maktab_fil.modcod = wdetail.redbook  No-lock no-error no-wait.
    If  avail  stat.maktab_fil  Then 
        ASSIGN
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
        wdetail.cargrp          =  maktab_fil.prmpac
        /*sic_bran.uwm301.Tons    =  stat.maktab.tons*/
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.engine  =  stat.maktab_fil.eng
        nv_engine               =  stat.maktab_fil.eng.
END.
ELSE DO:
    IF  (nv_moddes = "SPACECAB") OR (nv_moddes = "D-MAX Single") THEN  nv_moddes = "D-MAX".
    Find First stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =     nv_makdes                And                  
        index(stat.maktab_fil.moddes,nv_moddes) <> 0            And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) /*AND
         stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  */     
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook         =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.Tons    =  stat.maktab.tons
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.engine  =  stat.maktab_fil.eng
        nv_engine               =  stat.maktab_fil.eng.
END.
IF wdetail.redbook  = ""  THEN DO:
Find LAST stat.maktab_fil Use-index maktab04          Where
    stat.maktab_fil.makdes   =   "isuzu"              And                  
    index(stat.maktab_fil.moddes,wdetail.model) <> 0             And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
    stat.maktab_fil.engine   >=     Integer(wdetail.cc)   AND
    /*stat.maktab_fil.sclass   =     "****"        AND*/
    (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
     stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) /*AND
     stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)   */
    No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    Assign
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body.
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
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN  
    nv_tariff = sic_bran.uwm301.tariff             
    nv_class  = wdetail.prempa + wdetail.subclass
    nv_comdat = sic_bran.uwm100.comdat
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse                     
    nv_COMPER = deci(wdetail.comper)               
    nv_comacc = deci(wdetail.comacc)               
    nv_seats  = INTE(wdetail.seat) 
    nv_seat41 = inte(wdetail.seat41)
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
    nv_ncbper  =   0 
    nv_ncb     =   0                                  
    nv_totsi   =  0 
    fi_process    = "Import data TIL-renew to base..." + wdetail.policy .    /*A56-0262*/
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

IF (nv_covcod = "1" ) OR (nv_covcod = "2" ) OR (nv_covcod = "3" ) THEN DO: 
    RUN proc_base2. 
    END.
ELSE DO: 
    RUN proc_base21. 
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
IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) THEN      /*A57-0126 add WGSTP132*/
    RUN WGS\WGSTP132(INPUT S_RECID3,   /*A57-0126 add WGSTP132*/
                     INPUT S_RECID4).  /*A57-0126 add WGSTP132*/ 
ELSE    
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
       sic_bran.uwm100.bchyr = nv_batchyr 
       sic_bran.uwm100.bchno = nv_batchno 
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

CREATE wcomp. ASSIGN wcomp.package   = "110"   wcomp.premcomp  =   600.00       wcomp.vehuse  = "1" .                   
CREATE wcomp. ASSIGN wcomp.package   = "120A"  wcomp.premcomp  =   1100.00  wcomp.vehuse  = "1" .
CREATE wcomp. ASSIGN wcomp.package   = "140A"  wcomp.premcomp  =   900.00       wcomp.vehuse  = "1" .
CREATE wcomp. ASSIGN wcomp.package   = "140B"  wcomp.premcomp  =   1220.00      wcomp.vehuse  = "1" .
CREATE wcomp. ASSIGN wcomp.package   = "140C"  wcomp.premcomp  =   1310.00      wcomp.vehuse  = "1" .
CREATE wcomp. ASSIGN wcomp.package   = "140D"  wcomp.premcomp  =   1700.00      wcomp.vehuse  = "1" .
CREATE wcomp. ASSIGN wcomp.package   = "150"   wcomp.premcomp  =   2370.00  wcomp.vehuse  = "1" .
CREATE wcomp. ASSIGN wcomp.package   = "160"   wcomp.premcomp  =   600.00       wcomp.vehuse  = "1" .
CREATE wcomp. ASSIGN wcomp.package   = "220A"  wcomp.premcomp  =   2320.00  wcomp.vehuse  = "2" .  
CREATE wcomp. ASSIGN wcomp.package   = "240A"  wcomp.premcomp  =   1760.00  wcomp.vehuse  = "2" .  
CREATE wcomp. ASSIGN wcomp.package   = "240B"  wcomp.premcomp  =   1830.00  wcomp.vehuse  = "2" .  
CREATE wcomp. ASSIGN wcomp.package   = "240C"  wcomp.premcomp  =   1980.00  wcomp.vehuse  = "2" .  
CREATE wcomp. ASSIGN wcomp.package   = "240D"  wcomp.premcomp  =   2530.00  wcomp.vehuse  = "2" .  
CREATE wcomp. ASSIGN wcomp.package   = "250"   wcomp.premcomp  =   3160.00  wcomp.vehuse  = "2" .  
CREATE wcomp. ASSIGN wcomp.package   = "260"   wcomp.premcomp  =   600.00   wcomp.vehuse  = "2" .  
                                                                                               
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dsp_ncb c-Win 
PROCEDURE proc_dsp_ncb :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: หา Base ncb dspc จากพารามิเตอร์ที่เซ็ทไว้      
------------------------------------------------------------------------------*/
/*
FIND FIRST brstat.insure USE-INDEX Insure03 WHERE
            brstat.insure.insNo   = wdetail.camName  AND                    /* ชื่อแคมเปญ*/
            brstat.insure.ICAddr4 = wdetail.caryear  AND                    /* ปีรถ */
            brstat.insure.Text3   = wdetail.prempa + wdetail.subclass AND   /* แพ็คเก็จ */
            brstat.insure.vatcode = wdetail.covcod   AND                    /* ประเภท */
            brstat.insure.Text1   = wdetail.brand    AND                    /* ยี่ห้อรถ : ISUZU */
            brstat.insure.Text2   = wdetail.model    AND                    /* รุ่นรถ : D-MAX */
            deci(brstat.insure.Text4)   = deci(wdetail.si)       NO-ERROR NO-WAIT.              /* ทุนประกัน */
                 
IF AVAIL brstat.insure THEN DO:
        ASSIGN WDETAIL.NCB = 0 .
        IF (year(TODAY) - deci(wdetail.caryear)) <= 7 THEN
         ASSIGN  
                wdetail.ncb         = brstat.insure.Deci1 
                nv_dss_per          = brstat.insure.Deci2   
                aa                  = deci(brstat.insure.Text5)
                nv_41               = DECI(brstat.Insure.Addr3)
                nv_42               = DECI(brstat.Insure.Addr3)
                nv_43               = DECI(brstat.Insure.TelNo)
                wdetail.seat41      = DECI(brstat.insure.ICAddr1).
                
        ELSE DO:

            ASSIGN aa = nv_basere . 
            RUN wgs\wgsfbas.
            ASSIGN aa = nv_baseprm.
      END.
 END.

 */
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dsp_ncb1 c-Win 
PROCEDURE proc_dsp_ncb1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FIND FIRST brstat.insure USE-INDEX Insure03 WHERE
            brstat.insure.insNo   = wdetail.camName  AND                    /* ชื่อแคมเปญ*/
            brstat.insure.ICAddr4 = " "               AND                     
            brstat.insure.Text3   = wdetail.prempa + wdetail.subclass AND   /* แพ็คเก็จ */
            brstat.insure.vatcode = wdetail.covcod   AND                    /* ประเภท */
            brstat.insure.Text1   = wdetail.brand    AND                    /* ยี่ห้อรถ : ISUZU */
            brstat.insure.Text2   = wdetail.model    AND                    /* รุ่นรถ : D-MAX */
            deci(brstat.insure.Text4)   = deci(wdetail.si)       NO-ERROR NO-WAIT.                    /* ทุนประกัน */
                 
IF AVAIL brstat.insure THEN DO:
        ASSIGN WDETAIL.NCB = 0 .
        IF (year(TODAY) - deci(wdetail.caryear)) <= 20 THEN
         ASSIGN  
                wdetail.ncb         = brstat.insure.Deci1 
                nv_dss_per          = brstat.insure.Deci2   
                aa                  = deci(brstat.insure.Text5)
                nv_41               = DECI(brstat.Insure.Addr3)
                nv_42               = DECI(brstat.Insure.Addr3)
                nv_43               = DECI(brstat.Insure.TelNo)
                wdetail.seat41      = DECI(brstat.insure.ICAddr1)
                dod1                = DECI(brstat.insure.icno). 
      END.
      ELSE DO:
            ASSIGN aa = nv_basere .
            RUN wgs\wgsfbas.
            ASSIGN aa = nv_baseprm.
    END.
    */
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
    n_insref     = ""  
    nv_messagein = "" 
    nv_usrid     = "" 
    nv_transfer  = NO 
    n_check      = "" 
    nv_insref    = "" 
    putchr       = "" 
    putchr1      = "" 
    nv_typ       = "" 
    nv_usrid     = SUBSTRING(USERID(LDBNAME(1)),3,4)  
    nv_transfer  = YES .  
IF wdetail.insrefno = "" THEN DO:
    FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
        sicsyac.xmm600.NAME   = TRIM(wdetail.insnam)  AND 
        sicsyac.xmm600.homebr = TRIM(wdetail.branch)  AND 
        sicsyac.xmm600.clicod = "IN"                  NO-ERROR NO-WAIT.  
    IF NOT AVAILABLE sicsyac.xmm600 THEN DO:                            
        IF LOCKED sicsyac.xmm600 THEN DO:   
            ASSIGN nv_transfer = NO
                n_insref = sicsyac.xmm600.acno.
            RETURN.
        END.
        ELSE DO:
            ASSIGN n_check = "" 
                nv_insref  = "".
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
        END.
        n_insref = nv_insref.
    END.
    ELSE DO:  /* กรณีพบ */
        IF sicsyac.xmm600.acno <> "" THEN    
            ASSIGN 
            nv_insref               = trim(sicsyac.xmm600.acno) 
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
            sicsyac.xmm600.addr4    = "Tel. " + TRIM(wdetail.Tele)        /* Phone no. */
            sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
            sicsyac.xmm600.phone    = ""
            sicsyac.xmm600.opened   = TODAY                     
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            sicsyac.xmm600.dtyp20   = IF wdetail.Birth <> "" THEN "DOB" ELSE ""     
            sicsyac.xmm600.dval20   = TRIM(wdetail.Birth).
    END.
END.
ELSE DO:
    FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
        sicsyac.xmm600.acno   = TRIM(wdetail.insrefno)  NO-ERROR NO-WAIT.  
    IF AVAILABLE sicsyac.xmm600 THEN 
        ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
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
            sicsyac.xmm600.addr4    = "Tel. " + TRIM(wdetail.Tele)       /* phone no. */
            sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
            sicsyac.xmm600.phone    = ""    
            sicsyac.xmm600.opened   = TODAY                     
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            sicsyac.xmm600.dtyp20   = IF wdetail.Birth <> "" THEN "DOB" ELSE ""  
            sicsyac.xmm600.dval20   = TRIM(wdetail.Birth).
END.
IF nv_transfer = YES THEN DO:
    IF nv_insref  <> "" THEN 
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
        sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)       /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)       /*Address line 3*/
        sicsyac.xmm600.addr4    = "Tel. " + TRIM(wdetail.Tele)       /* phone no. */
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
        sicsyac.xmm600.dtyp20   = IF wdetail.Birth <> "" THEN "DOB" ELSE ""                        /*Type of Date Codes (2 X 20)*/
        sicsyac.xmm600.dval20   = TRIM(wdetail.Birth)            /*Date Values (8 X 20)*/
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
        sicsyac.xmm600.dtyp20   = IF wdetail.Birth <> "" THEN "DOB" ELSE ""   
        sicsyac.xmm600.dval20   = TRIM(wdetail.Birth).  
END.
IF sicsyac.xmm600.acno <> ""  THEN DO:
    ASSIGN 
        nv_insref = sicsyac.xmm600.acno.
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
            sicsyac.xtm600.fname   = "" .                    /*First Name*/

    END.
END.

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
ASSIGN  
    n_insref     = ""  
    nv_messagein = "" 
    nv_usrid     = "" 
    nv_transfer  = NO 
    n_check      = "" 
    nv_insref    = "" 
    putchr       = "" 
    putchr1      = "" 
    nv_typ       = "" 
    nv_usrid     = SUBSTRING(USERID(LDBNAME(1)),3,4)  
    nv_transfer  = YES .  
        ASSIGN n_check = "" 
            nv_insref  = "".
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
            ELSE nv_typ = "0s".  /*0s= บุคคลธรรมดา Cs = นิติบุคคล */
        END.
        RUN proc_insno. 
        IF n_check <> "" THEN DO:
            ASSIGN
                nv_transfer = NO
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
        IF nv_insref <> "" THEN CREATE sicsyac.xmm600.  /* A55-0268 */
    
    n_insref = nv_insref.
 
   /* กรณีพบ */
IF nv_transfer = YES THEN DO:
    IF nv_insref  <> "" THEN 
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
        sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)       /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)       /*Address line 3*/
        sicsyac.xmm600.addr4    = "Tel. " + TRIM(wdetail.Tele)       /* Phone no. */
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
        sicsyac.xmm600.phone    = ""                         /*Phone no.*/
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
        sicsyac.xmm600.dtyp20   = IF wdetail.Birth <> "" THEN "DOB" ELSE ""                     /*Type of Date Codes (2 X 20)*/
        sicsyac.xmm600.dval20   = TRIM(wdetail.Birth)                       /*Date Values (8 X 20)*/
        sicsyac.xmm600.iblack   = ""                       /*Insured Black List Code*/
        sicsyac.xmm600.oldic    = ""                       /*Old IC No.*/
        sicsyac.xmm600.cardno   = ""                       /*Credit Card Account No.*/
        sicsyac.xmm600.cshcrd   = ""                       /*Cash(C)/Credit(R) Agent*/
        sicsyac.xmm600.naddr1   = ""                       /*New address line 1*/
        sicsyac.xmm600.gstreg   = ""                       /*GST Registration No.*/
        sicsyac.xmm600.naddr2   = ""                       /*New address line 2*/
        sicsyac.xmm600.fax      = ""                       /*Fax No.*/
        sicsyac.xmm600.naddr3   = ""                       /*New address line 3*/
        sicsyac.xmm600.telex    = ""                      /*Telex No.*/
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
        sicsyac.xmm600.dtyp20   = IF wdetail.Birth <> "" THEN "DOB" ELSE ""    
        sicsyac.xmm600.dval20   = TRIM(wdetail.Birth).  
END.
IF sicsyac.xmm600.acno <> ""  THEN DO:
    ASSIGN 
        nv_insref = sicsyac.xmm600.acno.
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
            sicsyac.xtm600.addr4   = "Tel. " + TRIM(wdetail.Tele)     /* phone no. */
            sicsyac.xtm600.name2   = ""                      /*Name of Insured Line 2*/
            sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)    /*Title*/
            sicsyac.xtm600.name3   = ""                      /*Name of Insured Line 3*/
            sicsyac.xtm600.fname   = "" .                    /*First Name*/
    END.
END.

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
    stat.maktab_fil.engine   >=     Integer(wdetail.cc)   AND
    /*stat.maktab_fil.sclass   =     "****"        AND*/
    (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
     stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) /*AND
     stat.maktab_fil.seats    >=     INTEGER(wdetail.seat)   */
    No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    Assign
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body.
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
/*
FOR EACH   wdetail3:
    DELETE  wdetail3.
END.
INPUT FROM VALUE (fi_filename) .  
REPEAT:   
    CREATE  wdetail3.
    IMPORT DELIMITER "|" 
        wdetail3.REPORT_DATE          /*  REPORT_DATE */        
        wdetail3.INS_REQUEST          /*  INS_REQUEST */        
        wdetail3.CONTRACT             /*  CONTRACT    */        
        wdetail3.REF_NO               /*  REF_NO  */            
        wdetail3.nTITLE               /*  TITLE   */            
        wdetail3.CUSTOMER_NAME        /*  CUSTOMER_NAME   */    
        wdetail3.MAILING_ADDRESS1     /*  MAILING_ADDRESS1    */
        /*wdetail3.MAILING_ADDRESS2     /*  MAILING_ADDRESS2    */
        wdetail3.MAILING_ADDRESS3 */    /*  MAILING_ADDRESS3    */
       /* wdetail3.POSTAL_CODE */         /*  POSTAL_CODE */       
        wdetail3.REG_ADDRESS1         /*  A57-0433 */
        /*wdetail3.REG_ADDRESS2         /*  A57-0433 */
        wdetail3.REG_ADDRESS3         /*  A57-0433 */
        wdetail3.REG_CODE             /*  A57-0433 */
        wdetail3.NATIONALITY_ID*/       /*  NATIONALITY_ID  */    
        wdetail3.BIRTH                /*  BIRTH    */            
        wdetail3.H_TEL                /*  H_TEL    */            
        wdetail3.BRAND                /*  BRAND    */            
        wdetail3.MODELTPIS            /*  MODEL    */            
        wdetail3.nYEAR                /*  YEAR     */ 
        wdetail3.ncolor               /*  A57-0433 */ 
        wdetail3.CC                   /*  CC       */                
        wdetail3.ENG_NUM              /*  ENG_NUM  */ 
        wdetail3.CHASSIS              /*  CHASSIS  */ 
        wdetail3.LICENCE              /*  LICENCE  */  
        wdetail3.CHANGWAT             /*  CHANGWAT */  
        /*wdetail3.TYPE_VEH             /*  TYPE_VEH */  
        wdetail3.INS_COM */              /*  INS_COM  */ 
        wdetail3.DATE_INS             /*  DATE_INS */   
        wdetail3.INS_EXP              /*  INS_EXP  */  
        /*wdetail3.POL_NUM */             /*  POL_NUM */    
        wdetail3.INS_AMT              /*  INS_AMT */ 
        wdetail3.PREMIUM              /*  PREMIUM */ 
        wdetail3.NET_PREM             /*  NET_PREM*/ 
        /*wdetail3.CAT3  */               /*  CAT3    */ 
        wdetail3.nINS_COM1            /*  A57-0433 */ 
        wdetail3.nINSRQST1            /*  A57-0433 */ 
        wdetail3.nINS_EXP1            /*  A57-0433 */ 
        /*wdetail3.nPOL_NUM1*/            /*  A57-0433 */ 
        wdetail3.nPREMIUM1            /*  A57-0433 */ 
        /*wdetail3.MKT_OFF              /*  MKT_OFF */   
        wdetail3.OLD_CONT */            /*  OLD_CONT    */
        wdetail3.DATE491              /*  DATE491 */            
        wdetail3.DATE724              /*  DATE724,    */
        /*wdetail3.nYR_EXT              /*  A57-0433 */ 
        wdetail3.nINS_COLL_OLD_CONT   /*  A57-0433 */ 
        wdetail3.nNEW_OLD */            /*  A57-0433 */ 
        wdetail3.nINS_RQST            /*  A57-0433 */ 
        /*wdetail3.nENDORSE             /*  A57-0433 */ 
        wdetail3.nYR_EXT2              /*  A57-0433 */ 
        wdetail3.nINS_COLL*/ .          /*  A57-0433 */ 
        /*wdetail3.LPBNAME              /*  LPBNAME */*/
END.       /* repeat   */

FOR EACH wdetail3.
    IF INDEX(wdetail3.REPORT_DATE,"REPORT_DATE") <> 0 THEN DELETE wdetail3.
END.
Run  Pro_createfileexcel.
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matfileloadpol c-Win 
PROCEDURE proc_matfileloadpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH   wdetail3:
    DELETE  wdetail3.
END.
INPUT FROM VALUE (fi_filename) .  
REPEAT:   
    CREATE  wdetail3.
    IMPORT DELIMITER "|" 
        wdetail3.CONTRACT            
        wdetail3.CUSTOMER_NAME       
        wdetail3.MAILING_ADDRESS1    
        wdetail3.BRAND               
        wdetail3.MODELTPIS           
        wdetail3.nYEAR               
        wdetail3.ncolor              
        wdetail3.CC                  
        wdetail3.ENG_NUM             
        wdetail3.CHASSIS             
        wdetail3.LICENCE             
        wdetail3.CHANGWAT            
        wdetail3.nINS_COM1           
        wdetail3.nINSRQST1           
        wdetail3.nINS_EXP1 
        wdetail3.nPack
        wdetail3.branch
        wdetail3.nDealer
        wdetail3.nCoverage
        wdetail3.nVeh
        wdetail3.nClass72
        wdetail3.INS_AMT 
        wdetail3.NET_PREM
        wdetail3.PREMIUM
        wdetail3.com_no
        wdetail3.stk_no
        wdetail3.rec_no
        wdetail3.netPREM
        wdetail3.nPREMIUM1
        wdetail3.REG_ADDRESS1
        wdetail3.id_num
        wdetail3.ins_type
        wdetail3.nben
        wdetail3.F6_1
        wdetail3.F6_2
        wdetail3.F6_3
        wdetail3.F18_1
        wdetail3.F18_2
        wdetail3.F18_3
        wdetail3.F18_4
        wdetail3.F18_5.
END.        /* repeat   */

FOR EACH wdetail3.
    IF      INDEX(wdetail3.CONTRACT,"THAI AUTO")   <> 0 THEN DELETE wdetail3.
    ELSE IF INDEX(wdetail3.CONTRACT,"contract no") <> 0 THEN DELETE wdetail3.
END.
Run  Pro_createfileexcel2.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matfileloadtxt c-Win 
PROCEDURE proc_matfileloadtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_daily  =  "" 
    nv_reccnt  =  0.
For each  wdetailtxt:     /*clear */
    DELETE  wdetailtxt.
END.
INPUT FROM VALUE (fi_filename) . 
REPEAT:    
    IMPORT UNFORMATTED nv_daily.
        If  nv_daily  <>  ""  and  substr(nv_daily,1,1)  =  "H"  Then  nv_export  =  TRIM(SUBSTR(nv_daily,32,8)).     
        IF  nv_daily  <>  ""  And  Substr(nv_daily,1,1)  =  "D"  THEN DO:
            ASSIGN nv_reccnt   =  nv_reccnt  +  1
                ns_policyrenew = ""                                 
                ns_policy72    = ""                                 
                ns_policyrenew = TRIM(SUBSTR(nv_daily,393,26))      
                ns_policy72    = TRIM(SUBSTR(nv_daily,443,26)) .    
           /* IF ns_policyrenew  <> "" THEN RUN proc_charpolicyre.    
            IF ns_policy72     <> "" THEN RUN proc_char72.  */        
            CREATE  wdetailtxt.
            ASSIGN
                wdetailtxt.recordtype  = TRIM(SUBSTR(nv_daily,1,1))         
                wdetailtxt.contractno  = TRIM(SUBSTR(nv_daily,2,10))  
                wdetailtxt.pol_name    = TRIM(SUBSTR(nv_daily,12,60))
                wdetailtxt.pol_addr1   = TRIM(SUBSTR(nv_daily,72,160))
                wdetailtxt.carbrand    = TRIM(SUBSTR(nv_daily,232,16))
                wdetailtxt.model       = TRIM(SUBSTR(nv_daily,248,16))
                wdetailtxt.yrmanu      = TRIM(SUBSTR(nv_daily,264,4))
                wdetailtxt.colorcode   = TRIM(SUBSTR(nv_daily,268,16))
                wdetailtxt.cc_weight   = TRIM(SUBSTR(nv_daily,284,4))
                wdetailtxt.engine      = IF INDEX(TRIM(SUBSTR(nv_daily,288,26))," ") <> 0 THEN 
                                      TRIM(SUBSTR(TRIM(SUBSTR(nv_daily,288,26)),1,INDEX(TRIM(SUBSTR(nv_daily,288,26))," "))) + " " +
                                      TRIM(SUBSTR(TRIM(SUBSTR(nv_daily,288,26)),INDEX(TRIM(SUBSTR(nv_daily,288,26))," ")))
                                      ELSE TRIM(SUBSTR(nv_daily,288,26))
                wdetailtxt.chassis     = IF INDEX(TRIM(SUBSTR(nv_daily,314,26))," ") <> 0 THEN    /*A56-0262*/
                                      TRIM(SUBSTR(TRIM(SUBSTR(nv_daily,314,26)),1,INDEX(TRIM(SUBSTR(nv_daily,314,26))," "))) + " " +
                                      TRIM(SUBSTR(TRIM(SUBSTR(nv_daily,314,26)),INDEX(TRIM(SUBSTR(nv_daily,314,26))," ")))
                                      ELSE TRIM(SUBSTR(nv_daily,314,26))
                wdetailtxt.licence     = IF INDEX(TRIM(SUBSTR(nv_daily,340,12))," ") <> 0 THEN 
                                      TRIM(SUBSTR(TRIM(SUBSTR(nv_daily,340,12)),1,INDEX(TRIM(SUBSTR(nv_daily,340,12))," "))) + " " +
                                      TRIM(SUBSTR(TRIM(SUBSTR(nv_daily,340,12)),INDEX(TRIM(SUBSTR(nv_daily,340,12))," ")))
                                      ELSE TRIM(SUBSTR(nv_daily,340,12))
                wdetailtxt.province    = TRIM(SUBSTR(nv_daily,352,20)) 
                wdetailtxt.comp_code   = TRIM(SUBSTR(nv_daily,372,5))
                wdetailtxt.accdat      = TRIM(SUBSTR(nv_daily,377,8))
                wdetailtxt.expdat      = TRIM(SUBSTR(nv_daily,385,8))
                wdetailtxt.policy      =  caps(ns_policyrenew)                 
                wdetailtxt.ins_amt     = TRIM(SUBSTR(nv_daily,419,12))
                wdetailtxt.prem_vo     = TRIM(SUBSTR(nv_daily,431,12))
                wdetailtxt.sckno       = caps(ns_policy72)                     
                wdetailtxt.prem_72     = TRIM(SUBSTR(nv_daily,469,12))
                wdetailtxt.stkno       = TRIM(SUBSTR(nv_daily,481,15))
                
                wdetailtxt.mail        = TRIM(SUBSTR(nv_daily,496,160))
                wdetailtxt.idcardno    = TRIM(SUBSTR(nv_daily,641,13))     
                wdetailtxt.insurtyp    = TRIM(SUBSTR(nv_daily,654,1))      
                . 
        END.
   END.  /* repeat  */
   Run  Pro_createfile.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open c-Win 
PROCEDURE proc_open :
OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policy c-Win 
PROCEDURE proc_policy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: เช็คเบอร์กรมธรรม์มีการใช้งานแล้วหรือไม่      
------------------------------------------------------------------------------*/
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
DEF VAR n_nameno AS INTE.
ASSIGN fi_process    = "Import data TIL-renew to uwm100..." + wdetail.policy .     
DISP fi_process WITH FRAM fr_main.
IF wdetail.policy <> "" THEN DO:
    IF wdetail.stk  <>  ""  THEN DO: 
        /*RUN proc_stkfinddup.*/
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod .
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        IF wdetail.poltyp = "V72" THEN DO:
            FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
                sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                    ASSIGN wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            END.
        END.
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk      NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.      /*wdetail.stk  <>  ""*/
    ELSE DO:  /*sticker = ""*/ 
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy = wdetail.policy   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            IF wdetail.policy = "" THEN DO:
                RUN proc_temppolicy.
                wdetail.policy  = nv_tmppol.
            END.
            RUN proc_create100. 
        END.    /*policy <> "" & stk = ""*/                 
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
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.   /*add kridtiya i..*/
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk      NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.      /*wdetail.stk  <>  ""*/
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
IF R-INDEX(wdetail.insnam,".") <> 0 THEN wdetail.insnam = SUBSTR(wdetail.insnam,R-INDEX(wdetail.insnam,".")).
/*IF trim(wdetail.poltyp) = "V72" THEN RUN proc_insnam2.*/
RUN proc_insnam.
IF wdetail.prvpol = "" THEN n_firstdat = DATE(wdetail.comdat).  
DO TRANSACTION:
   ASSIGN
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = trim(wdetail.poltyp)
      sic_bran.uwm100.insref = IF trim(wdetail.insrefno) = "" THEN trim(nv_insref) ELSE trim(wdetail.insrefno)
      sic_bran.uwm100.opnpol = ""
      sic_bran.uwm100.anam2  = trim(wdetail.Icno)      
      sic_bran.uwm100.ntitle = trim(wdetail.tiname)
      sic_bran.uwm100.name1  = TRIM(wdetail.insnam)  
      sic_bran.uwm100.name2  = trim(wdetail.insnam2)
      sic_bran.uwm100.name3  = ""                 
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
      sic_bran.uwm100.prog   = "wgwttpib"
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
      sic_bran.uwm100.dir_ri = YES
      sic_bran.uwm100.drn_p  = NO
      sic_bran.uwm100.sch_p  = NO
      sic_bran.uwm100.cr_2   = n_cr2
      sic_bran.uwm100.bchyr  = nv_batchyr          /*Batch Year */  
      sic_bran.uwm100.bchno  = nv_batchno          /*Batch No.  */  
      sic_bran.uwm100.bchcnt = nv_batcnt           /*Batch Count*/  
      sic_bran.uwm100.prvpol = caps(TRIM(wdetail.prvpol))       
      sic_bran.uwm100.cedpol = TRIM(wdetail.cedpol)
      sic_bran.uwm100.finint = IF wdetail.poltyp = "v70" THEN  wdetail.finint ELSE ""
      /*sic_bran.uwm100.bs_cd  = "MC16182".*/     /* Kridtiya i. A53-0183 .............*/
      sic_bran.uwm100.bs_cd  =  "" .     /*.vatcode*/ 
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
END.  /*transaction*//*
IF wdetail.sendnam <> ""  THEN RUN proc_uwd100.   
ELSE IF wdetail.chkcar <> ""  THEN RUN proc_uwd100.   
ELSE IF wdetail.telno  <> ""   THEN RUN proc_uwd100. */
/*
IF (wdetail.f18line1 <> "" ) OR (wdetail.f18line2 <> "" ) OR
   (wdetail.f18line3 <> "" ) OR (wdetail.f18line4 <> "" ) THEN RUN proc_uwd102 . */
RUN proc_uwd102.
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
        sic_bran.uwm120.bchyr   = nv_batchyr     /* batch Year */
        sic_bran.uwm120.bchno   = nv_batchno     /* bchno      */
        sic_bran.uwm120.bchcnt  = nv_batcnt  .   /* bchcnt     */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_province_2 c-Win 
PROCEDURE proc_province_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*

/*----Check Birthdate ---*/
DEF VAR n_day   AS CHAR FORMAT "x(2)".
DEF VAR n_month AS CHAR FORMAT "x(2)".
DEF VAR n_year  AS CHAR FORMAT "x(4)".

IF trim(wdetail3.BIRTH) <> "" THEN
    ASSIGN n_day   = trim(SUBSTRING(wdetail3.BIRTH,4,2))
           n_month = trim(SUBSTRING(wdetail3.BIRTH,1,2))
           n_year  = trim(SUBSTRING(wdetail3.BIRTH,7,4))
           n_Bdate = deci(n_year) + 534
           wdetail3.BIRTH = n_day + "/" + n_month + "/" + STRING(n_Bdate).      
    
IF trim(wdetail3.BIRTH) = "" THEN
    ASSIGN wdetail3.BIRTH = "".

/*---- check Phone ---*/
IF wdetail3.H_TEL <> "" THEN
    IF TRIM(substring(wdetail3.H_TEL,1,1)) <> "0" THEN
        ASSIGN wdetail3.H_TEL = "0" + wdetail3.H_TEL.
    ELSE wdetail3.H_TEL = wdetail3.H_TEL.
    
/*--- อักษรย่อทะเบียน ---*/
DEF VAR n_changwat AS CHAR INIT "".
ASSIGN n_changwat = TRIM(wdetail3.CHANGWAT).
IF n_changwat = ""  THEN ASSIGN wdetail3.CHANGWAT = "".
ELSE IF n_changwat <> "" THEN 
        IF n_changwat = "1" OR n_changwat = "01"   THEN DO: ASSIGN wdetail3.CHANGWAT = "กท". END.
        IF n_changwat = "2" OR n_changwat = "02"   THEN DO: ASSIGN wdetail3.CHANGWAT = "สป". END.
        IF n_changwat = "3" OR n_changwat = "03"   THEN DO: ASSIGN wdetail3.CHANGWAT = "สค". END.
        IF n_changwat = "4" OR n_changwat = "04"   THEN DO: ASSIGN wdetail3.CHANGWAT = "สส". END.
        IF n_changwat = "5" OR n_changwat = "05"   THEN DO: ASSIGN wdetail3.CHANGWAT = "ชน". END.
        IF n_changwat = "6" OR n_changwat = "06"   THEN DO: ASSIGN wdetail3.CHANGWAT = "นบ". END.
        IF n_changwat = "7" OR n_changwat = "07"   THEN DO: ASSIGN wdetail3.CHANGWAT = "นฐ". END.
        IF n_changwat = "8" OR n_changwat = "08"   THEN DO: ASSIGN wdetail3.CHANGWAT = "นย". END.
        IF n_changwat = "9" OR n_changwat = "09"   THEN DO: ASSIGN wdetail3.CHANGWAT = "อย". END.
        IF n_changwat = "10" THEN DO: ASSIGN wdetail3.CHANGWAT = "ปท". END.
        IF n_changwat = "11" THEN DO: ASSIGN wdetail3.CHANGWAT = "กจ". END.
        IF n_changwat = "12" THEN DO: ASSIGN wdetail3.CHANGWAT = "ฉช". END.
        IF n_changwat = "13" THEN DO: ASSIGN wdetail3.CHANGWAT = "ปข". END.
        IF n_changwat = "14" THEN DO: ASSIGN wdetail3.CHANGWAT = "ปจ". END.
        IF n_changwat = "15" THEN DO: ASSIGN wdetail3.CHANGWAT = "พบ". END.
        IF n_changwat = "16" THEN DO: ASSIGN wdetail3.CHANGWAT = "รบ". END.
        IF n_changwat = "17" THEN DO: ASSIGN wdetail3.CHANGWAT = "ลบ". END.
        IF n_changwat = "18" THEN DO: ASSIGN wdetail3.CHANGWAT = "สบ". END.
        IF n_changwat = "19" THEN DO: ASSIGN wdetail3.CHANGWAT = "สห". END.
        IF n_changwat = "20" THEN DO: ASSIGN wdetail3.CHANGWAT = "สพ". END.
        IF n_changwat = "21" THEN DO: ASSIGN wdetail3.CHANGWAT = "สก". END.
        IF n_changwat = "22" THEN DO: ASSIGN wdetail3.CHANGWAT = "อท". END. /* อ่างทอง */
        IF n_changwat = "23" THEN DO: ASSIGN wdetail3.CHANGWAT = "กพ". END.
        IF n_changwat = "24" THEN DO: ASSIGN wdetail3.CHANGWAT = "ชม". END.
        IF n_changwat = "25" THEN DO: ASSIGN wdetail3.CHANGWAT = "ชร". END.
        IF n_changwat = "26" THEN DO: ASSIGN wdetail3.CHANGWAT = "ตก". END.
        IF n_changwat = "27" THEN DO: ASSIGN wdetail3.CHANGWAT = "นว". END.
        IF n_changwat = "28" THEN DO: ASSIGN wdetail3.CHANGWAT = "นน". END.
        IF n_changwat = "29" THEN DO: ASSIGN wdetail3.CHANGWAT = "พย". END.
        IF n_changwat = "30" THEN DO: ASSIGN wdetail3.CHANGWAT = "พจ". END.
        IF n_changwat = "31" THEN DO: ASSIGN wdetail3.CHANGWAT = "พล". END.
        IF n_changwat = "32" THEN DO: ASSIGN wdetail3.CHANGWAT = "พช". END.
        IF n_changwat = "33" THEN DO: ASSIGN wdetail3.CHANGWAT = "พร". END.
        IF n_changwat = "34" THEN DO: ASSIGN wdetail3.CHANGWAT = "มส". END.
        IF n_changwat = "35" THEN DO: ASSIGN wdetail3.CHANGWAT = "ลป". END.
        IF n_changwat = "36" THEN DO: ASSIGN wdetail3.CHANGWAT = "ลพ". END.
        IF n_changwat = "37" THEN DO: ASSIGN wdetail3.CHANGWAT = "สท". END.
        IF n_changwat = "38" THEN DO: ASSIGN wdetail3.CHANGWAT = "อน". END. /* อุทัย */
        IF n_changwat = "39" THEN DO: ASSIGN wdetail3.CHANGWAT = "อต". END.
        IF n_changwat = "40" THEN DO: ASSIGN wdetail3.CHANGWAT = "จบ". END.
        IF n_changwat = "41" THEN DO: ASSIGN wdetail3.CHANGWAT = "ชบ". END.
        IF n_changwat = "42" THEN DO: ASSIGN wdetail3.CHANGWAT = "ตร". END.
        IF n_changwat = "43" THEN DO: ASSIGN wdetail3.CHANGWAT = "รย". END.
        IF n_changwat = "44" THEN DO: ASSIGN wdetail3.CHANGWAT = "กส". END.
        IF n_changwat = "45" THEN DO: ASSIGN wdetail3.CHANGWAT = "ขก". END.
        IF n_changwat = "46" THEN DO: ASSIGN wdetail3.CHANGWAT = "ชย". END.
        IF n_changwat = "47" THEN DO: ASSIGN wdetail3.CHANGWAT = "นม". END.
        IF n_changwat = "48" THEN DO: ASSIGN wdetail3.CHANGWAT = "นพ". END.
        IF n_changwat = "49" THEN DO: ASSIGN wdetail3.CHANGWAT = "บร". END.
        IF n_changwat = "50" THEN DO: ASSIGN wdetail3.CHANGWAT = "มค". END.
        IF n_changwat = "51" THEN DO: ASSIGN wdetail3.CHANGWAT = "มห". END.
        IF n_changwat = "52" THEN DO: ASSIGN wdetail3.CHANGWAT = "ยส". END.
        IF n_changwat = "53" THEN DO: ASSIGN wdetail3.CHANGWAT = "รอ". END.
        IF n_changwat = "54" THEN DO: ASSIGN wdetail3.CHANGWAT = "ลย". END.
        IF n_changwat = "55" THEN DO: ASSIGN wdetail3.CHANGWAT = "ศก". END.
        IF n_changwat = "56" THEN DO: ASSIGN wdetail3.CHANGWAT = "สน". END.
        IF n_changwat = "57" THEN DO: ASSIGN wdetail3.CHANGWAT = "สร". END.
        IF n_changwat = "58" THEN DO: ASSIGN wdetail3.CHANGWAT = "นค". END.
        IF n_changwat = "59" THEN DO: ASSIGN wdetail3.CHANGWAT = "นล". END.
        IF n_changwat = "60" THEN DO: ASSIGN wdetail3.CHANGWAT = "อด". END.
        IF n_changwat = "61" THEN DO: ASSIGN wdetail3.CHANGWAT = "อบ". END.
        IF n_changwat = "62" THEN DO: ASSIGN wdetail3.CHANGWAT = "อจ". END.
        IF n_changwat = "63" THEN DO: ASSIGN wdetail3.CHANGWAT = "กบ". END.
        IF n_changwat = "64" THEN DO: ASSIGN wdetail3.CHANGWAT = "ชพ". END.
        IF n_changwat = "65" THEN DO: ASSIGN wdetail3.CHANGWAT = "ตง". END.
        IF n_changwat = "66" THEN DO: ASSIGN wdetail3.CHANGWAT = "นธ". END.
        IF n_changwat = "67" THEN DO: ASSIGN wdetail3.CHANGWAT = "นศ". END.
        IF n_changwat = "68" THEN DO: ASSIGN wdetail3.CHANGWAT = "ปน". END.
        IF n_changwat = "69" THEN DO: ASSIGN wdetail3.CHANGWAT = "พท". END.
        IF n_changwat = "70" THEN DO: ASSIGN wdetail3.CHANGWAT = "พง". END.
        IF n_changwat = "71" THEN DO: ASSIGN wdetail3.CHANGWAT = "ภก". END.
        IF n_changwat = "72" THEN DO: ASSIGN wdetail3.CHANGWAT = "ยล". END.
        IF n_changwat = "73" THEN DO: ASSIGN wdetail3.CHANGWAT = "รน". END.
        IF n_changwat = "74" THEN DO: ASSIGN wdetail3.CHANGWAT = "สต". END.
        IF n_changwat = "75" THEN DO: ASSIGN wdetail3.CHANGWAT = "สข". END.
        IF n_changwat = "76" THEN DO: ASSIGN wdetail3.CHANGWAT = "สฎ". END.
        IF n_changwat = "77" THEN DO: ASSIGN wdetail3.CHANGWAT = "บต". END.
        */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_province_bran c-Win 
PROCEDURE proc_province_bran :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 DO:
     /*--- check Pack ---*/
     IF trim(nv_cover) = "2.1" OR trim(nv_cover) = "3.1" THEN ASSIGN fi_pack = "C".
     ELSE ASSIGN fi_pack = "V".

     /*--- Check CC  ---*/
    IF (DECI(nv_cc) / 100 ) - Truncate(DECI(nv_cc) / 100 ,0) > 0 THEN
     ASSIGN np_cc = (Truncate(DECI(nv_cc) / 100 ,0) + 1 ) * 100 . 
     ELSE ASSIGN np_cc = DECI(nv_cc).


     /*--- เทียบซ่อมอู่ = "" ซ่อมห้าง = G ---*/
     IF trim(nv_cover) = "1" THEN
         IF TRIM(nv_netPrem) = "16155" OR TRIM(nv_netPrem) = "16620" OR
            TRIM(nv_netPrem) = "17085" OR TRIM(nv_netPrem) = "16320" OR
            TRIM(nv_netPrem) = "16785" OR TRIM(nv_netPrem) = "17251" OR
            TRIM(nv_netPrem) = "15855" THEN ASSIGN n_garage = "G".
      ELSE n_garage = " ".

     /*--- เทียบ Branch ---*/
    IF nv_contract = "" THEN
        MESSAGE " ไม่มีข้อมูลเลขที่สัญญา " VIEW-AS ALERT-BOX.
    IF nv_contract <> "" THEN
        ASSIGN nv_branTP = "TP" + TRIM(SUBSTRING(nv_contract,1,2)).
    
    FIND FIRST brstat.insure WHERE 
               brstat.insure.compno = "999"         AND
               brstat.insure.insno  = nv_branTP     AND
              TRIM(SUBSTRING(brstat.insure.FName,1,2)) = TRIM(SUBSTRING(nv_contract,1,2)) NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN  ASSIGN nv_branSaf  = trim(brstat.insure.LName).
        ELSE nv_branSaf = "M".

    END.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_redbook72 c-Win 
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
            /*wdetail.entdat      ","*/
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
            wdetail.vehuse      ","               
            wdetail.garage      ","               
            wdetail.covcod      "," 
            wdetail.si          "," 
            wdetail.volprem     "," 
            wdetail.Compprem    "," 
            wdetail.fleet       "," 
            wdetail.ncb         "," 
            wdetail.access      "," 
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
            /*"entdat   "      "," */    
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
        /*wdetail.entdat       ","*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 c-Win 
PROCEDURE proc_sic_exp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


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

  IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
      CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. 
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.  *//*Comment A62-0105*/
     /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.   /*db test.*/ */
      
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
    nv_txt2  = ""
    nv_txt3  = wdetail.sendnam 
    nv_txt4  = wdetail.chkcar  
    nv_txt5  = ""   .
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
     sic_bran.uwm100.rencnt  = n_rencnt        AND
     sic_bran.uwm100.endcnt  = n_endcnt        AND
     sic_bran.uwm100.bchyr   = nv_batchyr      AND
     sic_bran.uwm100.bchno   = nv_batchno      AND
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
  Notes: Create Memo.      
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
FIND LAST wdetailmemo WHERE wdetailmemo.policy = wdetail.policy NO-LOCK NO-ERROR.
IF AVAIL wdetailmemo THEN DO:
DO WHILE nv_line1 <= 11:
    
    
        CREATE wuppertxt3.
        wuppertxt3.line = nv_line1.
        IF nv_line1 < 4  THEN wuppertxt3.txt =  "".   
        IF nv_line1 = 4  THEN wuppertxt3.txt = wdetailmemo.memotxt1.
        IF nv_line1 = 5  THEN wuppertxt3.txt = wdetailmemo.memotxt2.  
        IF nv_line1 = 6  THEN wuppertxt3.txt = wdetailmemo.memotxt3.  
        IF nv_line1 = 7  THEN wuppertxt3.txt = wdetailmemo.memotxt4. 
        IF nv_line1 = 8  THEN wuppertxt3.txt = wdetailmemo.memotxt5.
        IF nv_line1 = 9  THEN wuppertxt3.txt = wdetailmemo.memotxt6.
        IF nv_line1 = 10 THEN wuppertxt3.txt = wdetailmemo.memotxt7.
    
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
END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile c-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
DEF VAR nv_sname    AS CHAR INIT "" FORMAT "X(40)".
DEF VAR nv_pack70   AS CHAR INIT "" FORMAT "X(3)".


If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
        
nv_cnt   =   0.
nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "THAI AUTO SALES CO,.LTD."  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' nv_export  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "contract no"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "name"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "reg.address"              '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "brand"                    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "model"                    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "year"                     '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "color"                    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "cc"                       '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "engine no"                '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "chassis"                  '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "licence no"               '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "province"                 '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "insurance comp."          '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "insurance date."          '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "expdat"                   '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "Package"                  '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "Branch"                   '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Dealer"                   '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "Covver"                   '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Vehuse"                   '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Class72"                  '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "insurance amount"         '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "Net Premium (Voluntary)." '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "premium(voluntary)"       '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "compulsory no.       "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "Sticker no.          "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "recive no.           "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Net Premium (Compulsory)" '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "premium(commpulsory)    " '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "mailing address         " '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "IDcard number           " '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Insurance Type          " '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "8.3:Beneficiary"          '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "F6_ACC1"                  '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "F6_ACC2"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "F6_ACC3"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "F18-1"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "F18-2"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "F18-3"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "F18-4"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "F18-5"                    '"' SKIP. 
FOR EACH wdetailtxt  NO-LOCK.
    ASSIGN 
        nv_cnt       =  nv_cnt  + 1 
        nv_row       =  nv_row + 1
        nv_title     =  ""
        nv_name      =  ""
        nv_sname     =  "" 
        nv_vehuse72  = ""
        nvclass72    = ""
        nv_pack70    = ""  .

    /*IF INDEX(wdetailtxt.pol_name," ") <> 0 THEN DO:
        IF (R-INDEX(wdetailtxt.pol_name," ")) = (INDEX(wdetailtxt.pol_name," "))  THEN
            ASSIGN 
            nv_name  = trim(SUBSTR(wdetailtxt.pol_name,INDEX(wdetailtxt.pol_name," ") + 1))
            nv_title = trim(SUBSTR(wdetailtxt.pol_name,1,INDEX(wdetailtxt.pol_name," ") - 1))
            nv_sname = "".
        ELSE 
            ASSIGN 
                nv_title = TRIM(wdetailtxt.pol_name)
                nv_sname = trim(SUBSTR(nv_title,R-INDEX(nv_title," ")))
                nv_title = trim(SUBSTR(nv_title,1,R-INDEX(nv_title," ") - 1))
                nv_name  = trim(SUBSTR(nv_title,R-INDEX(nv_title," "))) 
                nv_title = trim(SUBSTR(nv_title,1,R-INDEX(nv_title," ") - 1))   .
    END.*/

   nv_premt1 = DECIMAL(SUBSTRING(wdetailtxt.prem_vo,1,10)).
   IF nv_premt1 < 0 THEN nv_premt2 = (DECIMAL(SUBSTRING(wdetailtxt.prem_vo,11,2)) * -1) / 100.
   ELSE nv_premt2 = DECIMAL(SUBSTRING(wdetailtxt.prem_vo,11,2)) / 100.

   nv_premt3 = nv_premt1 + nv_premt2. 
   nv_cpamt1 = DECIMAL(SUBSTRING(wdetailtxt.prem_72,1,10)).

   IF nv_cpamt1 < 0 THEN nv_cpamt2 = (DECIMAL(SUBSTRING(wdetailtxt.prem_72,11,2)) * -1) / 100.
   ELSE  nv_cpamt2 = DECIMAL(SUBSTRING(wdetailtxt.prem_72,11,2)) / 100.
        
   nv_cpamt3 = nv_cpamt1 + nv_cpamt2.  
 
   /*---- Add  Watsana K. [A530131] > หา Net Premium -----*/
   IF nv_premt3 <= 0 THEN wdetailtxt.net_prm     = nv_premt3.                                   /*A56-0217*/
   ELSE  ASSIGN wdetailtxt.net_prm     = (ROUND(((nv_premt3 - nv_cpamt3 ) * 100 / 107.43),0)) . /*A56-0217*/                                                      /*A56-0217*/
   IF nv_cpamt3 > 0 THEN 
       ASSIGN  /* wdetailtxt.net_prm     = (ROUND(((nv_premt3 - nv_cpamt3 ) * 100 / 107.43),0))*/
      wdetailtxt.net_comp    = (TRUNC((nv_cpamt3 * 100 / 107.43),0)).
   /*------------ End Watsana K. [A530131] --------------*/ 

   /* ----- INS_AMT  CHR(12) ทุนประกันรถยนต์ --- */
   nv_insamt1 = DECIMAL(SUBSTRING(wdetailtxt.ins_amt,1,10)).
   IF nv_insamt1 < 0 THEN nv_insamt2 = (DECIMAL(SUBSTRING(wdetailtxt.ins_amt,11,2)) * -1) / 100.
   ELSE nv_insamt2 = DECIMAL(SUBSTRING(wdetailtxt.ins_amt,11,2)) / 100.

   nv_insamt3 = nv_insamt1 + nv_insamt2.
   FIND LAST wcomp WHERE wcomp.premcomp = wdetailtxt.net_comp NO-LOCK NO-WAIT NO-ERROR.
   IF AVAIL wcomp THEN DO:
       ASSIGN 
           nv_vehuse72  = wcomp.vehuse
           nvclass72    = wcomp.package.

   END.
   IF trim(wdetailtxt.model) = "" THEN nv_pack70 = "".
   ELSE IF substr(trim(wdetailtxt.model),1,1) = "N" THEN nv_pack70 = "320".  
   ELSE IF substr(trim(wdetailtxt.model),1,1) = "F" THEN nv_pack70 = "320".  
   ELSE IF substr(trim(wdetailtxt.model),1,1) = "G" THEN nv_pack70 = "420".  
   ELSE nv_pack70 = "".

   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetailtxt.contractno                             '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetailtxt.pol_name               FORMAT "x(80)"  '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetailtxt.pol_addr1                              '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetailtxt.carbrand                               '"' SKIP.      
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetailtxt.model                                  '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetailtxt.yrmanu                                 '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetailtxt.colorcode                              '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetailtxt.cc_weight                              '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetailtxt.engine                                 '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetailtxt.chassis                                '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetailtxt.licence                                '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetailtxt.province                               '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetailtxt.comp_code                              '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   wdetailtxt.accdat                                 '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   wdetailtxt.expdat                                 '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   "V"  + nv_pack70                                  '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   ""                                                '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   ""                                                '"' SKIP.          
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   "1"                                               '"' SKIP.           
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   nv_vehuse72                                       '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   nvclass72                                         '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   nv_insamt3            FORMAT ">>>,>>>,>>9-"       '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   wdetailtxt.net_prm    FORMAT ">>>,>>>,>>9-"       '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   nv_premt3             FORMAT ">>>,>>>,>>9.99-"    '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   wdetailtxt.sckno                                  '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   wdetailtxt.stkno                                  '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   ""                                                '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   wdetailtxt.net_comp   FORMAT ">>>,>>>,>>9-"       '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   nv_cpamt3                                         '"' SKIP. 
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   wdetailtxt.mail                                   '"' SKIP. 
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   wdetailtxt.idcardno                               '"' SKIP. 
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   wdetailtxt.insurtyp                               '"' SKIP. 
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   "บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด"               '"' SKIP. 
End.   

nv_row  =  nv_row  + 1.  

PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " Total "               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' String(nv_cnt,"99999")  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' " รายการ  "             '"' SKIP.

PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.

message "Export File  Complete"  view-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfileexcel c-Win 
PROCEDURE Pro_createfileexcel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
IF  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'    "REPORT_DATE"              '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'    "INS_REQUEST"              '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'    "CONTRACT"                 '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'    "REF_NO"                   '"' SKIP.                                              
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'    "TITLE"                    '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'    "CUSTOMER_NAME"            '"' SKIP.                                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'    "MAILING_ADDRESS1"         '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'    "MAILING ADDRESS2"         '"' SKIP.                                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'    "MAILING_ADDRESS3"         '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'    "MAILING_POSTAL_CODE"      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'    "REG_ADDRESS1"             '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'    "REG_ADDRESS2"             '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'    "REG_ADDRESS3"             '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'    "REG_POSTAL_CODE"          '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'    "NATIONALITY"              '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'    "BIRTH"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'    "H_TEL"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'    "BRAND"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'    "MODEL"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'    "MODELSAF "                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'    "YEAR"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'    "COLOUR"                   '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'    "CC"                       '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'    "ENG_NUM"                  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'    "CHASSIS"                  '"' SKIP.                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'    "LICENSE"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'    "CHANGWAT"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'    "Coverage "                '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'    "TYPE_VEH"                 '"' SKIP.                                           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'    "INS_COM"                  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'    "DATE_INS"                 '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'    "INS_EXP"                  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'    "POL_NUM"                  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'    "Sticker No."              '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'    "INS_AMT"                  '"' SKIP.                                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'    "PREMIUM"                  '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'    "NET_PREM"                 '"' SKIP.                                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'    "CAT3"                     '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'    "INS_COM1"                 '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'    "INSRQST1"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'    "INS_EXP1"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'    "POL_NUM1"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'    "PREMIUM1"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'    "MKT_OFF"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'    "OLD_CONT"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'    "DATE491"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'    "DATE724"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'    "YR_EXT"                   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'    "INS_COLL_OLD_CONT"        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'    "NEW_OLD"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'    "INS_RQST"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'    "ENDORSE"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'    "YR_EXT"                   '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'    "INS_COLL"                 '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'    "กล่องตรวจสภาพ "           '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'    "F18_1  "                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'    "F18_2  "                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'    "F18_3  "                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'    "F18_4  "                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'    "F18_5  "                  '"' SKIP. 

FOR EACH wdetail3 WHERE wdetail3.CONTRACT <> "" .
    IF TRIM(wdetail3.CHANGWAT) <> "" THEN RUN proc_province_2.
    ASSIGN nv_row =  nv_row + 1 
        wdetail3.MODELSAF  = IF index(trim(wdetail3.MODELTPIS),"TFR86")  <> 0 THEN "D-MAX" ELSE "".
    IF index(wdetail3.REPORT_DATE,"/") <> 0 THEN
        ASSIGN wdetail3.REPORT_DATE  =  substr(wdetail3.REPORT_DATE,4,2) + "/" +  
                                        substr(wdetail3.REPORT_DATE,1,2) + "/" +
                                        substr(wdetail3.REPORT_DATE,7,4) .  
    IF wdetail3.INS_REQUEST  <> "" THEN 
        ASSIGN wdetail3.INS_REQUEST  =  substr(wdetail3.INS_REQUEST,4,2) + "/" +  
                                        substr(wdetail3.INS_REQUEST,1,2) + "/" +
                                        substr(wdetail3.INS_REQUEST,7,4) .  
    IF wdetail3.DATE_INS <> "" THEN 
        ASSIGN wdetail3.DATE_INS     =  substr(wdetail3.DATE_INS,4,2) + "/" +  
                                        substr(wdetail3.DATE_INS,1,2) + "/" +
                                        substr(wdetail3.DATE_INS,7,4) .  
    IF wdetail3.INS_EXP  <> "" THEN
        ASSIGN wdetail3.INS_EXP      =  substr(wdetail3.INS_EXP,4,2) + "/" +  
                                        substr(wdetail3.INS_EXP,1,2) + "/" +
                                        substr(wdetail3.INS_EXP,7,4) .  
    IF wdetail3.DATE491 <> ""  THEN
        ASSIGN wdetail3.DATE491      =  substr(wdetail3.DATE491,4,2) + "/" +  
                                        substr(wdetail3.DATE491,1,2) + "/" +
                                        substr(wdetail3.DATE491,7,4) .  
    IF (wdetail3.DATE724 <> "") AND (trim(wdetail3.DATE724) <> "-") THEN 
        ASSIGN wdetail3.DATE724      =  substr(wdetail3.DATE724,4,2) + "/" +  
                                        substr(wdetail3.DATE724,1,2) + "/" +
                                        substr(wdetail3.DATE724,7,4) .  
    IF wdetail3.nINS_RQST <> "" THEN 
        ASSIGN wdetail3.nINS_RQST    =  substr(wdetail3.nINS_RQST,4,2) + "/" +  
                                        substr(wdetail3.nINS_RQST,1,2) + "/" +
                                        substr(wdetail3.nINS_RQST,7,4) .  

PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetail3.REPORT_DATE          '"' SKIP.            /*  REPORT_DATE */         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail3.INS_REQUEST          '"' SKIP.   /*  INS_REQUEST */         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail3.CONTRACT             '"' SKIP.   /*  CONTRACT    */         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail3.REF_NO               '"' SKIP.   /*  REF_NO  */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail3.nTITLE               '"' SKIP.   /*  TITLE   */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail3.CUSTOMER_NAME        '"' SKIP.   /*  CUSTOMER_NAME   */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail3.MAILING_ADDRESS1     '"' SKIP.   /*  MAILING_ADDRESS1    */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail3.MAILING_ADDRESS2     '"' SKIP.   /*  MAILING_ADDRESS2    */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail3.MAILING_ADDRESS3     '"' SKIP.   /*  MAILING_ADDRESS3    */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetail3.POSTAL_CODE          '"' SKIP.   /*  POSTAL_CODE */         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetail3.REG_ADDRESS1         '"' SKIP.   /*  NATIONALITY_ID  */     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetail3.REG_ADDRESS2         '"' SKIP.   /*  BIRTH   */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetail3.REG_ADDRESS3         '"' SKIP.   /*  H_TEL   */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   wdetail3.REG_CODE             '"' SKIP.   /*  BRAND   */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   wdetail3.NATIONALITY_ID       '"' SKIP.   /*  MODELTPIS   */         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   wdetail3.BIRTH                '"' SKIP.   /*  MODELSAF    */         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   wdetail3.H_TEL                '"' SKIP.   /*  YEAR    */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   wdetail3.BRAND                '"' SKIP.   /*  CC  */                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   wdetail3.MODELTPIS            '"' SKIP.   /*  Coverage    */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   wdetail3.MODELSAF             '"' SKIP.   /*  TYPE_VEH    */         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   wdetail3.nYEAR                '"' SKIP.   /*  INS_COM */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   wdetail3.ncolor               '"' SKIP.   /*  LICENCE */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   wdetail3.CC                   '"' SKIP.   /*  CHANGWAT    */                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   wdetail3.ENG_NUM              '"' SKIP.   /*  CHASSIS */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   wdetail3.CHASSIS              '"' SKIP.   /*  ENG_NUM */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   wdetail3.LICENCE              '"' SKIP.   /*  INS_AMT */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   wdetail3.CHANGWAT                              '"' SKIP.   /*  NET_PREM    */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   ""                            '"' SKIP.   /*  PREMIUM */          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   wdetail3.TYPE_VEH             '"' SKIP.   /*  POL_NUM */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   wdetail3.INS_COM              '"' SKIP.   /*  DATE_INS    */         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   wdetail3.DATE_INS             '"' SKIP.   /*  INS_EXP */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   wdetail3.INS_EXP              '"' SKIP.   /*  LPBNAME */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   wdetail3.POL_NUM                                  '"' SKIP.   /*  MKT_OFF */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'   wdetail3.stk_no                                       '"' SKIP.   /*  OLD_CONT    */         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'   DECI(wdetail3.INS_AMT)  FORMAT ">>>,>>>,>>>"         '"' SKIP.   /*  CAT3    */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'   DECI(wdetail3.PREMIUM)  FORMAT ">>>,>>>,>>>.99-"     '"' SKIP.   /*  DATE491 */             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'   DECI(wdetail3.NET_PREM) FORMAT ">>>,>>>,>>>.99-"                  '"' SKIP.   /*  DATE724 */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'   wdetail3.CAT3                 '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'   wdetail3.nINS_COM1            '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'   wdetail3.nINSRQST1            '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'   wdetail3.nINS_EXP1            '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'   wdetail3.nPOL_NUM1            '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'   wdetail3.nPREMIUM1            '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'   wdetail3.MKT_OFF              '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'   wdetail3.OLD_CONT             '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'   wdetail3.DATE491              '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'   wdetail3.DATE724              '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'   wdetail3.nYR_EXT              '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'   wdetail3.nINS_COLL_OLD_CONT   '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'   wdetail3.nNEW_OLD             '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'   wdetail3.nINS_RQST            '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'   wdetail3.nENDORSE             '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'   wdetail3.nYR_EXT2             '"' SKIP.   /*  DATE724 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'   wdetail3.nINS_COLL                                         '"' SKIP.   /*  DATE724 */ 
END.

OUTPUT STREAM ns2 CLOSE.

FOR EACH wdetail3.
    DELETE wdetail3.
END.
message "Export File  Complete"  view-as alert-box.
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfileexcel2 c-Win 
PROCEDURE Pro_createfileexcel2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_pol70 AS CHAR INIT "" FORMAT "x(12)" .
DEF VAR nv_pol72 AS CHAR INIT "" FORMAT "x(12)" .
IF  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_row  =  1.

OUTPUT STREAM ns2 TO VALUE(fi_output1).

PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "contract no"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "เลขกรมธรรม์70"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "เลขกรมธรรม์72"               '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "name"                         '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "reg.address"                  '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "brand"                        '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "model"                        '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "year"                         '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "color"                        '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "cc"                           '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "engine no"                    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "chassis"                      '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "licence no"                   '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "province"                     '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "insurance comp."              '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "insurance date."              '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "expdat"                       '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Package"                      '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "Branch"                       '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Dealer"                       '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Covver"                       '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Vehuse"                       '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "Class72"                      '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "insurance amount"             '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Net Premium (Voluntary)."     '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "premium(voluntary)"           '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "compulsory no.       "        '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Sticker no.          "        '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "recive no.           "        '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Net Premium (Compulsory)"     '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "premium(commpulsory)    "     '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "mailing address         "     '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "IDcard number           "     '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "Insurance Type          "     '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "8.3:Beneficiary"              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "F6_ACC1"                      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "F6_ACC2"                      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "F6_ACC3"                      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "F18-1"                        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "F18-2"                        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "F18-3"                        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "F18-4"                        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "F18-5"                        '"' SKIP. 


FOR EACH wdetail3 NO-LOCK .
    ASSIGN nv_row  =  nv_row + 1.

    IF wdetail3.CONTRACT <> "" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
            sicuw.uwm100.cedpol = TRIM(wdetail3.CONTRACT)  AND 
            sicuw.uwm100.poltyp = "V70"   NO-LOCK NO-ERROR NO-WAIT .
        IF AVAIL sicuw.uwm100 THEN DO:
            ASSIGN nv_pol70 = sicuw.uwm100.policy .
            IF sicuw.uwm100.cr_2 <> ""  THEN nv_pol72 = sicuw.uwm100.cr_2 .
        END.
        IF  nv_pol72 = ""   THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                sicuw.uwm100.cedpol = TRIM(wdetail3.CONTRACT)  AND 
                sicuw.uwm100.poltyp = "V72"   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN
                ASSIGN nv_pol72 = sicuw.uwm100.policy .
        END.
    END.
    ELSE IF wdetail3.CHASSIS  <> "" THEN DO:
        FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE 
            sicuw.uwm301.trareg = TRIM(wdetail3.CHASSIS) AND
            substr(sicuw.uwm301.policy,3,2) = "70"  NO-LOCK NO-WAIT NO-ERROR .
        IF AVAIL sicuw.uwm301 THEN DO:
            ASSIGN nv_pol70 = sicuw.uwm301.policy .
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                sicuw.uwm100.policy = sicuw.uwm301.policy   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN
                ASSIGN nv_pol72 = sicuw.uwm100.cr_2.
        END.
        FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE 
            sicuw.uwm301.trareg = TRIM(wdetail3.CHASSIS) AND
            substr(sicuw.uwm301.policy,3,2) = "72"  NO-LOCK NO-WAIT NO-ERROR .
        IF AVAIL sicuw.uwm301 THEN DO:
            ASSIGN nv_pol72 = sicuw.uwm301.policy .
        END.
    END.
                                                                                            
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' wdetail3.CONTRACT            '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' nv_pol70                     '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' nv_pol72                     '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdetail3.CUSTOMER_NAME       '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' wdetail3.MAILING_ADDRESS1    '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' wdetail3.BRAND               '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' wdetail3.MODELTPIS           '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' wdetail3.nYEAR               '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' wdetail3.ncolor              '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' wdetail3.CC                  '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' wdetail3.ENG_NUM             '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' wdetail3.CHASSIS             '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' wdetail3.LICENCE             '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' wdetail3.CHANGWAT            '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' wdetail3.nINS_COM1           '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' wdetail3.nINSRQST1           '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' wdetail3.nINS_EXP1           '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' wdetail3.nPack               '"' SKIP.   /*  YEAR    */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' wdetail3.branch              '"' SKIP.   /*  CC  */                             
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' wdetail3.nDealer             '"' SKIP.   /*  Coverage    */                     
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' wdetail3.nCoverage           '"' SKIP.   /*  TYPE_VEH    */                     
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' wdetail3.nVeh                '"' SKIP.   /*  INS_COM */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' wdetail3.nClass72            '"' SKIP.   /*  LICENCE */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' wdetail3.INS_AMT             '"' SKIP.   /*  CHANGWAT    */                     
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' wdetail3.NET_PREM            '"' SKIP.   /*  CHASSIS */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' wdetail3.PREMIUM             '"' SKIP.   /*  ENG_NUM */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' wdetail3.com_no              '"' SKIP.   /*  INS_AMT */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' wdetail3.stk_no              '"' SKIP.   /*  NET_PREM    */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' wdetail3.rec_no              '"' SKIP.   /*  PREMIUM */                      
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' wdetail3.netPREM             '"' SKIP.   /*  POL_NUM */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' wdetail3.nPREMIUM1           '"' SKIP.   /*  DATE_INS    */                     
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' wdetail3.REG_ADDRESS1        '"' SKIP.   /*  INS_EXP */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' wdetail3.id_num              '"' SKIP.   /*  LPBNAME */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' wdetail3.ins_type            '"' SKIP.   /*  MKT_OFF */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' wdetail3.nben                '"' SKIP.   /*  OLD_CONT    */                     
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' wdetail3.F6_1                '"' SKIP.   /*  CAT3    */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' wdetail3.F6_2                '"' SKIP.   /*  DATE491 */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' wdetail3.F6_3                '"' SKIP.   /*  DATE724 */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' wdetail3.F18_1               '"' SKIP.   /*  ISP */                             
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' wdetail3.F18_2               '"' SKIP.   /*  F18_1   */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' wdetail3.F18_3               '"' SKIP.   /*  F18_2   */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' wdetail3.F18_4               '"' SKIP.   /*  F18_3   */                         
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' wdetail3.F18_5               '"' SKIP.   /*  F18_4   */                         
   /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'   '"' SKIP.   /*  F18_4   */   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"'   '"' SKIP.   /*  F18_4   */   */
END.
OUTPUT STREAM ns2 CLOSE.
FOR EACH wdetail3.
    DELETE wdetail3.
END.
message "Export File  Complete"  view-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

