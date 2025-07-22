&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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
/*programid  : wgwtlm3.i                                                        */ 
/*programname: Load Text & Generate เพรซิเดนท์เบเกอรี่-ฟาร์มเฮ้าส์               */ 
/*Copyright  : Safety Insurance Public Company Limited                           */ 
/*                         บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                    */ 
/*create by  : Kridtiya i. A57-0123 date. 31/03/2014                             
               ปรับโปรแกรมให้สามารถนำเข้า Load Text & Generate เพรซิเดนท์เบเกอรี่*/ 
/*Modify by  :Kridtiya i. A58-0206 เพิ่ม Line: V70,V72,V74 
              and sic_bran.uwm301.trareg    = nv_uwm301trareg                    */
/*Modify by  :Kridtiya i. A58-0271 เพิ่ม การนำเข้างาน ประเภท 2+ 3+               */
/*Modify by : Ranu I. A59-0013 11/01/2016                                       */
/*           เพิ่มตัวแปรรับค่า เลขที่อ้างอิง จากไฟล์และเก็บที่ช่อง C.Pol.no     */
/*Modify by : Ranu I. A59-0060 01/03/2016                                       */
/*           เพิ่มการเก็บค่าข้อมูลกรมธรรม์เดิม                                  */
/*Modify by : Kridtiya i. A59-0185  */
/*dup program by chaiyong W. A59-0445 03/10/2016*/
/*  wgwtlbu2.i       to wgwtlm3.i               */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*-------------------------------------------------------------------------------*/
DEF VAR n_firstdat AS CHAR FORMAT "x(10)"  INIT "".
DEF VAR n_brand    AS CHAR FORMAT "x(50)"  INIT "".
DEF VAR n_model    AS CHAR FORMAT "x(50)"  INIT "".
DEF VAR n_index    AS INTE  INIT 0.
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
DEF NEW  SHARED VAR   nv_covcod     LIKE sicuw.uwm301.covcod.
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
{wgw\wgwtlm3.i}      /*ประกาศตัวแปร*/

DEF VAR nv_para   AS CHAR INIT "BENZ-LEXUS".
DEF VAR nv_camp   AS CHAR INIT "".
DEF VAR nv_opnpol AS CHAR INIT "".

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
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_branch fi_producer fi_bchno ~
fi_agent fi_vatcod fi_prevbat fi_bchyr fi_filename bu_file fi_output1 ~
fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit br_wdetail bu_hpbrn ~
bu_hpacno1 bu_hpagent fi_process fi_outputHead buok-2 fi_delcod bu_hp ~
fi_financecd RECT-370 RECT-372 RECT-373 RECT-374 RECT-375 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_branch fi_producer fi_bchno ~
fi_agent fi_vatcod fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 ~
fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname fi_impcnt ~
fi_process fi_completecnt fi_premtot fi_premsuc fi_outputHead fi_delcod ~
fi_financecd 

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

DEFINE BUTTON buok-2 
     LABEL "OK" 
     SIZE 5 BY .91
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 5 BY .95.

DEFINE BUTTON bu_hp 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
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

DEFINE VARIABLE fi_delcod AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_financecd AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .95
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

DEFINE VARIABLE fi_outputHead AS CHARACTER FORMAT "X(256)":U 
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

DEFINE VARIABLE fi_vatcod AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 13.38
     BGCOLOR 18 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 5.43
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
     fi_loaddat AT ROW 2.81 COL 17 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.86 COL 17 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.91 COL 17 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.71 COL 15 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agent AT ROW 5.95 COL 17 COLON-ALIGNED NO-LABEL
     fi_vatcod AT ROW 7 COL 106.5 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 6.95 COL 20.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 6.95 COL 56.17 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.14 COL 24 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9.19 COL 86.67
     fi_output1 AT ROW 10.14 COL 24 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.14 COL 24 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.14 COL 24 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 13.14 COL 24 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 13.14 COL 63.17 NO-LABEL
     buok AT ROW 9.76 COL 96.83
     bu_exit AT ROW 11.62 COL 97
     fi_brndes AT ROW 3.86 COL 26.83 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 16.91 COL 2.17
     bu_hpbrn AT ROW 3.86 COL 25
     bu_hpacno1 AT ROW 4.91 COL 36.5
     bu_hpagent AT ROW 5.95 COL 36.5
     fi_proname AT ROW 4.91 COL 39 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 5.95 COL 39 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 22.38 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 14.14 COL 24 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.43 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.38 COL 97 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.43 COL 95 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_outputHead AT ROW 8.14 COL 24 COLON-ALIGNED NO-LABEL
     buok-2 AT ROW 8.14 COL 86.5
     fi_delcod AT ROW 4.91 COL 110.67 COLON-ALIGNED NO-LABEL
     bu_hp AT ROW 4.91 COL 108.5
     fi_financecd AT ROW 5.95 COL 106.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     "           Branch :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.86 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "       Load Date :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 2.81 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 6.95 COL 56.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer Code :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 4.91 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " Finance Code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 5.95 COL 92 WIDGET-ID 4
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY .91 AT ROW 22.38 COL 94.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 22.71 COL 5.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Agent Code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 5.95 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 23.43 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Output Head Report :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 8.14 COL 2.5
          BGCOLOR 2 FGCOLOR 7 
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 9.14 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Vat code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 7 COL 92
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "   Dealer Code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 4.91 COL 92
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY .91 AT ROW 23.43 COL 94.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 13.14 COL 82.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 12.14 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 25 BY .91 AT ROW 13.14 COL 61.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "LOAD TEXT BENZ RAMA3/LEXUS" VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.33 COL 2.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 11.14 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "     Policy Import Total :":60 VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 13.14 COL 24 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 22.38 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 22.38 COL 57.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Previous Batch No.:" VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 6.95 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 23.43 COL 57.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 10.14 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.62 COL 1
     RECT-373 AT ROW 16.14 COL 1
     RECT-374 AT ROW 21.71 COL 1
     RECT-375 AT ROW 22.19 COL 1
     RECT-377 AT ROW 9.43 COL 95.17
     RECT-378 AT ROW 11.29 COL 95.33
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
         TITLE              = "LOAD TEXT BENZ RAMA3/LEXUS"
         HEIGHT             = 23.91
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
          SIZE 12 BY .95 AT ROW 6.95 COL 56.67 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "     Policy Import Total :"
          SIZE 22.5 BY .91 AT ROW 13.14 COL 24 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 25 BY .91 AT ROW 13.14 COL 61.83 RIGHT-ALIGNED           */

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
ON END-ERROR OF c-Win /* LOAD TEXT BENZ RAMA3/LEXUS */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* LOAD TEXT BENZ RAMA3/LEXUS */
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
    ASSIGN
        nv_batprev  = INPUT fi_prevbat
        fi_process  = "LOAD TEXT FILE MOTOR[BU2]"
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
    FOR EACH wuwd132.
        DELETE wuwd132.
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
                           INPUT            "WGWTLBU2" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem ).
    ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok-2 c-Win
ON CHOOSE OF buok-2 IN FRAME fr_main /* OK */
DO:
    IF fi_outputHead = " " THEN DO: 
        MESSAGE "Please Input file name !!!" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_outputHead.
        RETURN NO-APPLY.
    END.
    If  substr(fi_outputHead,length(fi_outputHead) - 3,4) <>  ".csv"  Then
        fi_outputHead  =  Trim(fi_outputHead) + ".csv"  .

    OUTPUT TO VALUE(fi_outputHead).
    EXPORT DELIMITER "|" 
        "ลำดับ                        "
        "บริษัทผู้แจ้งงาน             "
        "วันที่แจ้งงาน                "
        "ชื่อผู้แจ้งงาน               "
        "เลขกรมธรรม์เดิม              "
        "เลขกรมธรรม์ใหม่              "
        "เลขกรมธรรม์พรบ.              "
        "ชื่อ - สกุล ผู้เอาประกันภัย  "
        "ชื่อ – สกุล กรรมการ (กรณีนิติบุคคล)"
        "ที่อยู่ผู้เอาประกันภัย 1     "
        "ที่อยู่ผู้เอาประกันภัย 2     "
        "ที่อยู่ผู้เอาประกันภัย 3     "
        "ที่อยู่ผู้เอาประกันภัย 4     "
        "เลขที่บัตรประชาชน            "
        "อาชีพ                        "
        "เบอร์โทรลูกค้า               "
        "วัน/เดือน/ปีเกิด             "
        "วันหมดอายุบัตร               "
        "วันที่เริ่มคุ้มครอง          "
        "วันที่สิ้นสุด                "
        "ยี่ห้อ                       "
        "รุ่น                         "
        "ปี                           "
        "ขนาดเครื่องยนต์              "
        "ที่นั่ง                      "
        "รหัสรถ ภาคสมัครใจ            "
        "ลักษณะการใช้รถ               "
        "รหัส พรบ.                    "
        "ทะเบียน                      "
        "เลขตัวถัง                    "
        "เลขเครื่องยนต์               "
        "ระบุชื่อ 1                   "
        "วัน/เดือน/ปี เกิด ระบุชื่อ 1 "
        "ID ระบุชื่อ 1                "
        "ระบุชื่อ 2                   "
        "วัน/เดือน/ปี เกิดระบุชื่อ 2  "
        "ID ระบุชื่อ 2                "
        "ประเภท                       "
        "ราคารถ                       "
        "ทุนประกัน                    "
        "เบี้ยสุทธิ ป.1               "
        "เบี้ยรวมภาษีอากร ป.1         "
        "เบี้ยสุทธิ พรบ.              "
        "เบี้ย พรบ.รวมภาษีอากร        "
        "รวมเบี้ย+พรบ.                "
        "เลขสติ๊กเกอร์                "
        "ผู้รับผลประโยชน์             "
        "ออกใบเสร็จประกัน             "
        "ออกใบเสร็จ พรบ.              "
        "อุปกรณ์เสริม                 "
        "หมายเหตุ                     "
        "Campaign / Quatation Num.    "
        "ชื่อเมลล์ผู้แจ้ง             "
        "วันที่เมลล์แจ้ง              "
        "ผู้แจ้งงาน                   "
        "อื่นๆ                        "
        "อื่นๆ                        "
        "อื่นๆ                        "
        "อื่นๆ                        "
        "อื่นๆ                        "
        "อื่นๆ                        ".
        
        
    OUTPUT CLOSE.
    message "Export File  Complete"  view-as alert-box.
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


&Scoped-define SELF-NAME bu_hp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hp c-Win
ON CHOOSE OF bu_hp IN FRAME fr_main
DO: 
     
    DEF VAR nv_rec AS RECID INIT ?.
   Run whp\whpdeal(INPUT   nv_para,
                   output  nv_rec).

   IF nv_rec <> ? THEN DO:
       FIND FIRST stat.insure WHERE RECID(stat.insure) = nv_rec NO-LOCK NO-ERROR.
       IF AVAIL stat.insure THEN DO:
           ASSIGN
               fi_producer  = stat.insure.addr1
               fi_agent     = stat.insure.addr2
               fi_vatcod    = stat.insure.vatcode
               fi_delcod    = stat.Insure.InsNo  
               fi_financecd = stat.Insure.Text3 .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
    
       END.
   END.
   DISP fi_producer 
       fi_agent   
       fi_vatcod  
       fi_delcod 
       fi_financecd    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
       with frame  fr_main.
   IF nv_rec <> ? THEN DO:
       Apply "Entry"  to  fi_producer.
       Return no-apply.
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


&Scoped-define SELF-NAME fi_agtname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agtname c-Win
ON LEAVE OF fi_agtname IN FRAME fr_main
DO:
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
                fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name).
    END.
    Disp  fi_agtname  WITH Frame  fr_main.    
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


&Scoped-define SELF-NAME fi_delcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_delcod c-Win
ON LEAVE OF fi_delcod IN FRAME fr_main
DO:
    fi_delcod = INPUT fi_delcod.
    IF fi_delcod <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001       WHERE
            sicsyac.xmm600.acno  =  Input fi_delcod  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            /*Message  "Not on Name & Address Master File xmm600" View-as alert-box.
            Apply "Entry" To  fi_delcod.
            RETURN NO-APPLY.  */
        END.
        ELSE  
            ASSIGN fi_delcod   =  caps(INPUT  fi_delcod). 
    END. 
    Disp  fi_delcod   WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_financecd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_financecd c-Win
ON LEAVE OF fi_financecd IN FRAME fr_main
DO:
    fi_financecd = INPUT fi_financecd.
    IF fi_financecd <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001       WHERE
            sicsyac.xmm600.acno  =  Input fi_financecd  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            /*Message  "Not on Name & Address Master File xmm600" View-as alert-box.
            Apply "Entry" To  fi_financecd.
            RETURN NO-APPLY.  */
        END.
        ELSE  
            ASSIGN fi_financecd   =  caps(INPUT  fi_financecd). 
    END. 
    Disp  fi_financecd   WITH Frame  fr_main.                 
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


&Scoped-define SELF-NAME fi_outputHead
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outputHead c-Win
ON LEAVE OF fi_outputHead IN FRAME fr_main
DO:
    fi_outputHead = INPUT fi_outputHead.
    DISP fi_outputHead WITH FRAM fr_main.
  
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
    nv_vatdes = "".
    IF fi_vatcod <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001       WHERE
            sicsyac.xmm600.acno  =  Input fi_vatcod  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" View-as alert-box.
            Apply "Entry" To  fi_vatcod.
            RETURN NO-APPLY.  
        END.
        ELSE DO:
            ASSIGN fi_vatcod   =  caps(INPUT  fi_vatcod). 
            nv_vatdes = TRIM(TRIM(xmm600.ntitle) + " " + trim(xmm600.NAME)).
            FIND sicsyac.xtm600 USE-INDEX xtm60001       WHERE
                 sicsyac.xtm600.acno  =  Input fi_vatcod  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xtm600 THEN DO:
                nv_vatdes = TRIM(TRIM(xtm600.ntitle) + " " + trim(xtm600.NAME)).


            END.
        END.
    END. 
    Disp  fi_vatcod   WITH Frame  fr_main.                 
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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)"  NO-UNDO.
  ASSIGN 
      gv_prgid   = "wgwtlm3.w"
      gv_prog    = "LOAD TEXT BENZ RAMA3/LEXUS "
      fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). 
  ASSIGN                /*
      ra_f6text    = 1  
      ra_f15text   = 1  
      ra_f17text   = 1  
      ra_NAP_pd    = 1*/
      /*fi_insurceco = "WC16231"*/
      fi_branch   = "M" 
      fi_vatcod   = "MC03604"
      fi_delcod   = "MB00009"
      fi_producer = "A0M2028"  /*A000761/A000000*/
      fi_agent    = "A000000"
      fi_bchyr    = YEAR(TODAY)
      fi_process  = "LOAD TEXT FILE MOTOR[BU2]".
  DISP  /*ra_f6text ra_f15text ra_f17text fi_process ra_NAP_pd */  /*fi_insurceco*/ 
      fi_delcod fi_branch fi_vatcod  fi_producer fi_agent fi_bchyr WITH FRAME fr_main.
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
  DISPLAY fi_loaddat fi_branch fi_producer fi_bchno fi_agent fi_vatcod 
          fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 
          fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname fi_impcnt 
          fi_process fi_completecnt fi_premtot fi_premsuc fi_outputHead 
          fi_delcod fi_financecd 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE fi_loaddat fi_branch fi_producer fi_bchno fi_agent fi_vatcod 
         fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 
         fi_output3 fi_usrcnt fi_usrprem buok bu_exit br_wdetail bu_hpbrn 
         bu_hpacno1 bu_hpagent fi_process fi_outputHead buok-2 fi_delcod bu_hp 
         fi_financecd RECT-370 RECT-372 RECT-373 RECT-374 RECT-375 RECT-377 
         RECT-378 
      WITH FRAME fr_main IN WINDOW c-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_caddr c-Win 
PROCEDURE pd_caddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_addrx = ""
    nv_ctext = "".
IF length(nv_addr) > 35 THEN DO:
    nv_ctext = SUBSTR(nv_addr,31,5).

    IF INDEX(nv_ctext," ") <> 0 THEN DO:
        ASSIGN
            nv_addrx = SUBSTR(nv_addr,1,30) + SUBSTR(nv_ctext,1,INDEX(nv_ctext," "))
            nv_addr  = SUBSTR(nv_addr,31 + INDEX(nv_ctext," "))
            nv_ctext = "".
    END.
    ELSE DO:
        nv_ctext = SUBSTR(nv_addr,1,30).
        IF R-INDEX(nv_ctext," ") > 20 THEN DO:
            ASSIGN
                nv_addrx = TRIM(SUBSTR(nv_ctext,1,R-INDEX(nv_ctext," ")))
                nv_addr  = TRIM(SUBSTR(nv_addr,R-INDEX(nv_ctext," ") + 1)).
        END.
        ELSE DO:
            ASSIGN
                nv_addrx = SUBSTR(nv_addr,1,35)
                nv_addr  = SUBSTR(nv_addr,36)
                nv_ctext = "".
        END.

    END.    
END.
ELSE 
    ASSIGN
        nv_addrx = nv_addr
            nv_addr  = "".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_fpol72 c-Win 
PROCEDURE pd_fpol72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR n_policy2 AS CHAR INIT "".
DEF VAR nv_run    AS CHAR INIT "".


FIND LAST sic_bran.uwm100 WHERE
          sic_bran.uwm100.policy = n_policy70 NO-LOCK NO-ERROR.
IF AVAIL sic_bran.uwm100 THEN DO:
    IF trim(uwm100.cr_2) <> "" THEN
        ASSIGN
            n_policy72 = TRIM(uwm100.cr_2)
            n_policy2  = TRIM(uwm100.cr_2).
END.
IF n_policy72 = "" THEN DO:
    n_policy2    = SUBSTR(n_policy70,1,2) + "72" + SUBstr(STRING(year(TODAY) + 543,"9999"),3,2) . /*DM7259*/
/*DM7259 + BF*/
    IF nv_pack = "F" THEN n_policy2 = n_policy2 + "B" + TRIM(CAPS(nv_pack)).
    ELSE n_policy2 = n_policy2 + "L" + TRIM(CAPS(nv_pack)).
    
    
    
    FIND LAST sic_bran.uwm100 WHERE
        substr(sic_bran.uwm100.policy,1,8) = n_policy2 NO-LOCK NO-ERROR.
    IF AVAIL sic_Bran.uwm100 THEN DO:
    
        loop_count:
        REPEAT:
            n_policy2 = substr(n_policy2,1,8) +  STRING(INT(substr(sic_bran.uwm100.policy,9,4)) + 1,"9999").
            FIND LAST sic_bran.uwm100 WHERE sic_bran.uwm100.policy = n_policy2 NO-LOCK NO-ERROR.
            IF AVAIL sic_Bran.uwm100 THEN DO:
                NEXT loop_count.
            END.
            ELSE DO:
                n_policy72 = n_policy2.
                LEAVE loop_count.
            END.
        END.                           
    END.
    ELSE DO:
        n_policy2 = n_policy2 + "0001".
        n_policy72 = n_policy2.
    END.
END.






/*
               
n_policy72     */


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
IF      SUBSTR(wdetail.class,1,3) = "110" THEN  ASSIGN nv_class72rd = "110".
ELSE IF SUBSTR(wdetail.class,1,3) = "120" THEN  ASSIGN nv_class72rd = "210".
ELSE IF SUBSTR(wdetail.class,1,3) = "210" THEN  ASSIGN nv_class72rd = "120".
ELSE IF SUBSTR(wdetail.class,1,3) = "220" THEN  ASSIGN nv_class72rd = "220".
ELSE IF SUBSTR(wdetail.class,1,3) = "320" THEN  ASSIGN nv_class72rd = "320".
ELSE IF SUBSTR(wdetail.class,1,3) = "140" THEN  ASSIGN nv_class72rd = "320".
ELSE IF SUBSTR(wdetail.class,1,3) = "240" THEN  ASSIGN nv_class72rd = "320".
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
    RUN proc_72red.
END.

IF wdetail.redbook = ""  THEN DO:
    FIND FIRST sicsyac.xmm102   WHERE 
        index(sicsyac.xmm102.modest,wdetail.brand) <> 0  NO-LOCK NO-ERROR.  
    IF AVAIL sicsyac.xmm102 THEN 
        ASSIGN 
        wdetail.redbook = sicsyac.xmm102.modcod 
        /*wdetail.body    = sicsyac.xmm102.body *//*A57-0426*/
        wdetail.body    = IF wdetail.body = ""  THEN        sicsyac.xmm102.body    ELSE wdetail.body  /*A57-0426*/
        wdetail.tonn    = IF wdetail.Tonn  = 0  THEN        sicsyac.xmm102.tons    ELSE wdetail.Tonn                    
        wdetail.engcc   = IF wdetail.engcc = "" THEN string(sicsyac.xmm102.engine) ELSE wdetail.engcc    
        wdetail.seat    = IF wdetail.seat  = "" THEN STRING(sicsyac.xmm102.seats)  ELSE wdetail.seat
        wdetail.cargrp  = sicsyac.xmm102.vehgrp 
        wdetail.redbook = sicsyac.xmm102.modcod.

    ELSE wdetail.redbook = "" .                                            
    IF wdetail.redbook = ""  THEN DO:
        FIND LAST sicsyac.xmm102 WHERE sicsyac.xmm102.modest = wdetail.brand  NO-LOCK NO-ERROR.
        IF NOT AVAIL sicsyac.xmm102  THEN DO:
            /*---
            ASSIGN wdetail.pass = "N"  
            wdetail.comment = wdetail.comment + "| not find on table xmm102"
            wdetail.OK_GEN  = "N". */
        END.
        ELSE  
            ASSIGN 
                wdetail.redbook = sicsyac.xmm102.modcod 
                /*wdetail.body    = sicsyac.xmm102.body *//*A57-0426*/
                wdetail.body    = IF wdetail.body  = "" THEN        sicsyac.xmm102.body     ELSE wdetail.body  /*A57-0426*/
                wdetail.tonn    = IF wdetail.Tonn  = 0  THEN        sicsyac.xmm102.tons     ELSE wdetail.Tonn                    
                wdetail.engcc   = IF wdetail.engcc = "" THEN string(sicsyac.xmm102.engine)  ELSE wdetail.engcc    
                wdetail.seat    = IF wdetail.seat  = "" THEN STRING(sicsyac.xmm102.seats)   ELSE wdetail.seat
                wdetail.tonn    = sicsyac.xmm102.tons  
                wdetail.engcc   = string(sicsyac.xmm102.engine)
                wdetail.seat    = STRING(sicsyac.xmm102.seats)
                /*wdetail.cargrp  = sicsyac.xmm102.vehgrp*/  .
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
------------------------------------------------------------------------------*/DEFINE INPUT        PARAMETER  s_recid1   AS   RECID     NO-UNDO.
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
/*--
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
END. ---*/
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
    nv_com1_per            = 0.

    /*--
    ASSIGN  nv_com1_per = sicsyac.xmm031.comm1
    nv_com1_per            =  deci(wdetail.commission). --*/
    
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
        ASSIGN 
        nv_com1_per     = 0
                           /*
         nv_com1_per     = sic_bran.uwm120.com1p
         nv_com1_per            =  deci(wdetail.commission)*/ .
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72red c-Win 
PROCEDURE proc_72red :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--

    IF TRIM(wdetail.mkval) <> "" THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
            index(stat.maktab_fil.moddes,n_model) <> 0              And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
            stat.maktab_fil.sclass   =  nv_class72rd                      AND
            stat.maktab_fil.maksi    =  DECI(wdetail.mkval)               No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN DO:
            
    
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
        END.
        ELSE wdetail.redbook  = "".
            
    END.  */
    IF TRIM(wdetail.redbook)  = "" THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            INDEX(stat.maktab_fil.makdes,trim(wdetail.brand)) <> 0      And                  
            index(stat.maktab_fil.moddes,n_model) <> 0              And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
            stat.maktab_fil.sclass   =  nv_class72rd                 No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN DO:
          
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
        END.
        ELSE wdetail.redbook  = "".
    END.

    IF TRIM(wdetail.redbook)  = "" THEN DO:
        /*MESSAGE wdetail.brand VIEW-AS ALERT-BOX. */
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            index(stat.maktab_fil.makdes,trim(wdetail.brand)) <> 0        And                  
            index(stat.maktab_fil.moddes,n_model) <> 0                    And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            /*stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND*/
            stat.maktab_fil.sclass   =  nv_class72rd         No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN DO:
          
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
        END.
        ELSE wdetail.redbook  = "".
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
-------------------------------------------------------------------------------*/
DO:
    For each  wdetail :
        DELETE  wdetail.
    END.
    FOR EACH wuwd132.
        DELETE wuwd132.
    END.
    FOR EACH wacctext15.
        DELETE wacctext15.
    END.
    FOR EACH wacctext17.
        DELETE wacctext17.
    END.

    RUN proc_assign2.
    /*--

    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|" 
            n_idno  
            np_prepol      
            n_policy70 
            np_type01    /*A58-0206*/
            np_prepol72    
            n_policy72     
            np_type02    /*A58-0206*/
            n_branch  
            np_insref
            np_icno
            np_title 
            np_name1 
            np_addr1 
            np_addr2 
            np_addr3 
            np_addr4
            n_cover
            n_textf5 
            n_textf52
            n_textf53
            n_textf7  
            n_textf72
            n_textf73
            n_com70        
            n_com72        
            nf_vehuse70   
            n_class70     
            nf_vehuse72   
            n_class72  
            n_seat1  
            n_Engine 
            n_Tonnage
            n_garage
            n_uom1_v       
            n_uom2_v       
            n_uom5_v       
            n_siins        
            n_fi           
            n_nv_41 
            n_nv_412
            n_nv_42        
            n_nv_43 
            n_seat_41
            n_ncb          
            n_feet         
            n_dspc         
            n_base  
            n_nap
            n_vehreg 
            nn_redbook
            n_brand1       
            n_model1 
            n_body
            n_chassis      
            n_engno        
            n_caryear      
            n_comdat1      
            n_expdat1      
            n_comdat72    
            n_expdat72    
            n_benname
            n_cpol        /*-- A59-0013 --*/ 
            n_textacc     
            n_textacc1    
            n_textacc2    
            n_textacc3    
            n_textacc4    
            n_textacc5    
            n_textacc6    
            n_textacc7    
            n_textacc8    
            n_textacc9.
      
            /*n_bennams*/
        IF TRIM(n_idno) = "" THEN RUN proc_initdata.
        ELSE IF index(TRIM(n_idno),"ที่")   <> 0 THEN RUN proc_initdata.
        ELSE IF index(TRIM(n_idno),"ลำดับ") <> 0 THEN RUN proc_initdata.
        ELSE IF index(TRIM(n_idno),"เลข")   <> 0 THEN RUN proc_initdata.
        ELSE IF index(TRIM(n_idno),"NO")    <> 0 THEN RUN proc_initdata.
        ELSE DO:
            IF n_policy70 <> "" THEN RUN proc_create70.
            IF n_policy72 <> "" THEN RUN proc_create72.
            RUN proc_initdata.
        END.
    END.         /* repeat   */  */
    FOR EACH wdetail:
        ASSIGN fi_process  = "Create file to work file... " + wdetail.policy.
        DISP fi_process  WITH FRAME fr_main.
        IF      index(wdetail.number,"ที่") <> 0 THEN DELETE wdetail.
        ELSE IF index(wdetail.number,"เลข") <> 0 THEN DELETE wdetail.
        ELSE IF   wdetail.policy = ""  THEN DELETE wdetail.
        ELSE DO:
            ASSIGN wdetail.n_rencnt = 0 
                wdetail.n_endcnt    = 0 
                wdetail.drivnam     = "N"
                wdetail.tariff      = "X"
                wdetail.compul      = "n"
                wdetail.producer    = trim(fi_producer)
                wdetail.agent       = trim(fi_agent)
                
              /*  wdetail.vatcode     = trim(fi_vatcod) */ .


            IF TRIM(fi_delcod)    <> "NONE" AND TRIM(fi_delcod)    <> "" THEN  wdetail.finint    = fi_delcod.
            IF TRIM(fi_financecd) <> "NONE" AND TRIM(fi_financecd) <> "" THEN  wdetail.financecd = fi_delcod.   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

            /*---test--*/
            IF wdetail.poltyp = "V70" AND (wdetail.fdri1 <> "" OR  wdetail.fdri2 <> "" ) THEN DO:
                wdetail.drivnam     = "Y".
            END.
            /*---test---*/


            /*RUN proc_chassic.*/
            IF TRIM(wdetail.inserf) <> ""  THEN DO:
                FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
                    sicsyac.xmm600.acno = trim(wdetail.inserf)     NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm600  THEN
                    ASSIGN 
                    wdetail.tiname  = trim(sicsyac.xmm600.ntitle)
                    wdetail.insnam  = trim(sicsyac.xmm600.name)
                    wdetail.icno    = IF TRIM(sicsyac.xmm600.icno) = "" THEN trim(wdetail.icno) ELSE TRIM(sicsyac.xmm600.icno)
                    wdetail.n_addr1 = trim(sicsyac.xmm600.addr1)
                    wdetail.n_addr2 = trim(sicsyac.xmm600.addr2)
                    wdetail.n_addr3 = trim(sicsyac.xmm600.addr3)
                    wdetail.n_addr4 = trim(sicsyac.xmm600.addr4) .
                ELSE 
                     Message "รหัสลูกค้า  " trim(wdetail.inserf) " ไม่พบในระบบกรุณาตรวจสอบอีกครั้ง !!!"  View-as alert-box.
            END.
            ASSIGN
                 wdetail.name2       = TRIM(wdetail.name2).
            
            IF wdetail.name2 <> "" THEN wdetail.name2 = "(" + wdetail.name2 + ")".
            IF LENGTH(wdetail.insnam + " " + wdetail.name2) < 50 THEN DO:
                ASSIGN
                    wdetail.insnam2 = wdetail.insnam
                    wdetail.insnam  = wdetail.insnam + " " + wdetail.name2
                    wdetail.name2   = "".
            
                
            END.
                
                    
            IF wdetail.poltyp = "V72" THEN DO:
                IF nv_vatname72 = "แถม" THEN DO:                  
                    ASSIGN
                        wdetail.vatcode     = trim(fi_vatcod) .
                    IF wdetail.name2 = "" THEN wdetail.name2 = "และ/หรือ " + nv_vatdes.
                    ELSE wdetail.name3 = "และ/หรือ " + nv_vatdes.
                END.
                ELSE IF nv_vatname72 <> "" THEN DO:
                    FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                               sicsyac.xmm600.acno = nv_vatname72  NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicsyac.xmm600 THEN DO:
                        ASSIGN
                            wdetail.vatcode     = sicsyac.xmm600.acno.
                        IF wdetail.name2 = "" THEN wdetail.name2 = "และ/หรือ "  + xmm600.ntitle + " " + xmm600.NAME.
                        ELSE wdetail.name3 = "และ/หรือ " +  xmm600.ntitle + " " + xmm600.NAME.
                    END.
            
            
                END.
            END.
            ELSE DO:
                IF nv_vatname70 = "แถม" THEN DO:                  
                    ASSIGN
                        wdetail.vatcode     = trim(fi_vatcod). 
                    IF wdetail.name2 = "" THEN wdetail.name2 = "และ/หรือ " + nv_vatdes.
                    ELSE wdetail.name3 = "และ/หรือ " + nv_vatdes.
                END.
                ELSE IF nv_vatname70 <> "" THEN DO:
                    FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                               sicsyac.xmm600.acno = nv_vatname70  NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicsyac.xmm600 THEN DO:
                        ASSIGN
                            wdetail.vatcode     = sicsyac.xmm600.acno.
                        IF wdetail.name2 = "" THEN wdetail.name2 = "และ/หรือ "  + xmm600.ntitle + " " + xmm600.NAME.
                        ELSE wdetail.name3 = "และ/หรือ " +  xmm600.ntitle + " " + xmm600.NAME.
                    END.
            
            
                END.
            END.
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2 c-Win 
PROCEDURE proc_assign2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_rindex AS INT INIT 0.
DEF VAR nv_date   AS DATE FORMAT "99/99/9999".
DEF VAR nv_total  AS CHAR INIT "".
ASSIGN
    nv_addrx = ""
    nv_addr  = ""
    n_garage = "".
FIND FIRST stat.insure WHERE 
    stat.insure.compno = nv_para     AND
    stat.insure.addr1  = fi_producer AND
    stat.insure.addr2  = fi_agent    NO-LOCK NO-ERROR.
IF AVAIL stat.insure THEN DO:
    ASSIGN
        n_garage  = "G"
        nv_prom   = CAPS(TRIM(Insure.Addr3))
        nv_pack   = CAPS(TRIM(Insure.Addr4)).
END.
ELSE 
    ASSIGN
        nv_prom = ""
        nv_pack = "E".
    
FIND sicsyac.xtm600 USE-INDEX xtm60001       WHERE
    sicsyac.xtm600.acno  =  fi_vatcod  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xtm600 THEN DO:
    nv_vatdes = TRIM(TRIM(xtm600.ntitle) + " " + trim(xtm600.NAME)).
END.
INPUT FROM VALUE(fi_FileName).
REPEAT: 
    IMPORT DELIMITER "|" 
        n_idno        
        nv_fcomp      
        nv_fdate      
        nv_fcont      
        np_prepol     
        n_policy70    
        n_policy72    
        nv_fname    
        nv_fname2 
        np_addr1      
        np_addr2      
        np_addr3      
        np_addr4      
        np_icno       
        np_occupn     
        nv_ftel       
        nv_fdob       
        nv_fexp       
        n_comdat1        
        n_expdat1     
        n_brand1      
        n_model1      
        n_caryear     
        n_Engine
        n_seat1       
        n_class70     
        nf_vehuse70   
        n_class72     
        n_vehreg      
        n_chassis     
        n_engno  
        nv_fdri1 
        nv_fddo1 
        nv_driid1
        nv_fdri2 
        nv_fddo2 
        nv_driid2
        n_cover
        nv_price
        n_siins 
        n_nap
        n_naptx
        n_napcom
        n_napcomtx 
        nv_total       
        n_sticker
        n_benname
        nv_vatname70 
        nv_vatname72
        nv_acc     
        n_textf78
        n_textf7  
        n_textf72 
        n_textf73 
        n_textf74 
        n_textf75 
        n_textf76 
        n_textf77 
        nv_campaign_ov   .
    
    n_garage = "G".
    IF INDEX(nv_fname," ") <> 0 THEN DO:
        nv_ctext = TRIM(SUBSTR(nv_fname,1,INDEX(nv_fname," "))).
        IF nv_ctext = "คุณ" THEN DO:
    
        END.
        ELSE IF nv_ctext = "บริษัท" THEN DO:
    
        END.
        ELSE DO:
            FIND FIRST brstat.msgcode WHERE msgcode.MsgDesc = nv_ctext NO-LOCK NO-ERROR.
            IF NOT AVAIL brstat.msgcode THEN DO:
                FIND FIRST brstat.msgcode WHERE msgcode.branch   = nv_ctext NO-LOCK NO-ERROR.
                IF NOT AVAIL brstat.msgcode THEN DO:
                    nv_ctext = "".
                END.
            END.
        END.
        IF nv_ctext <> "" THEN DO:
            ASSIGN
                nv_fname  = TRIM(SUBSTR(nv_fname,INDEX(nv_fname," ") + 1))
                nv_ntitle = nv_ctext
                nv_ctext  = "".
        END.
    END.
    np_title  = nv_ntitle   .
    np_name1  = nv_fname  . 
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    RUN proc_assign2addr (INPUT  np_addr1  
                         ,INPUT  np_addr2 
                         ,INPUT  Trim(np_addr3 + " " + np_addr4)
                         ,INPUT  np_occupn
                         ,OUTPUT nv_codeocc   
                         ,OUTPUT nv_codeaddr1 
                         ,OUTPUT nv_codeaddr2 
                         ,OUTPUT nv_codeaddr3 ).
    IF nv_postcd <> "" THEN DO:
        IF      INDEX(np_addr4,nv_postcd) <> 0 THEN np_addr4 = trim(REPLACE(np_addr4,nv_postcd,"")).
        ELSE IF INDEX(np_addr3,nv_postcd) <> 0 THEN np_addr3 = trim(REPLACE(np_addr3,nv_postcd,"")).
        ELSE IF INDEX(np_addr2,nv_postcd) <> 0 THEN np_addr2 = trim(REPLACE(np_addr2,nv_postcd,"")).
        ELSE IF INDEX(np_addr1,nv_postcd) <> 0 THEN np_addr1 = trim(REPLACE(np_addr1,nv_postcd,"")).
    END.
    RUN proc_matchtypins  (INPUT  np_title 
                          ,INPUT  np_name1 
                          ,OUTPUT nv_insnamtyp
                          ,OUTPUT nv_firstName 
                          ,OUTPUT nv_lastName).
    /*end. Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    IF nv_acc <> "" THEN DO:
        nv_addr = nv_acc.
        RUN pd_caddr.
        n_textacc  = nv_addrx.
        RUN pd_caddr.
        n_textacc1  = nv_addrx.
        RUN pd_caddr.
        n_textacc2  = nv_addrx.
        RUN pd_caddr.
        n_textacc3  = nv_addrx.
        RUN pd_caddr.
        n_textacc4  = nv_addrx.
        RUN pd_caddr.
        n_textacc5  = nv_addrx.
        RUN pd_caddr.
        n_textacc6  = nv_addrx.
        RUN pd_caddr.
        n_textacc7  = nv_addrx.
        RUN pd_caddr.
        n_textacc8  = nv_addrx.
        RUN pd_caddr.
        n_textacc9  = nv_addrx.
    END.
    n_fi  =  n_siins        .
    IF INDEX(nf_vehuse70,"จังหวัด") <> 0 THEN nf_vehuse70 = "5".
    ELSE IF INDEX(nf_vehuse70,"บุคคล") <> 0 AND INDEX(nf_vehuse70,"สาธารณะ") <> 0 THEN nf_vehuse70 = "4".
    ELSE IF INDEX(nf_vehuse70,"สาธารณะ") <> 0 THEN nf_vehuse70 = "3".
    ELSE IF INDEX(nf_vehuse70,"บุคคล") <> 0 THEN nf_vehuse70 = "1".
    ELSE nf_vehuse70 = "2".

    IF INDEX(n_vehreg,"แดง") <> 0 THEN n_vehreg = "".
    IF  nv_fdri1  = "" AND nv_fddo1 = "" THEN 
        ASSIGN
            nv_fdri1 = nv_fdri2      
            nv_fddo1 = nv_fddo2  
            nv_fdri2 = ""   
            nv_fddo2 = ""  .

    IF n_policy72 <> "" THEN
        ASSIGN
            n_comdat72  = n_comdat1
            n_expdat72  = n_expdat1
            nf_vehuse72 = nf_vehuse70.
    n_class70 = trim(nv_pack) + trim(n_class70).
    IF TRIM(n_idno) = "" THEN RUN proc_initdata.
    ELSE IF index(TRIM(n_idno),"ที่")   <> 0 THEN RUN proc_initdata.
    ELSE IF index(TRIM(n_idno),"ลำดับ") <> 0 THEN RUN proc_initdata.
    ELSE IF index(TRIM(n_idno),"เลข")   <> 0 THEN RUN proc_initdata.
    ELSE IF index(TRIM(n_idno),"NO")    <> 0 THEN RUN proc_initdata.
    ELSE DO:
        IF n_policy70 <> "" THEN RUN proc_create70.
        IF n_policy72 <> "" THEN RUN proc_create72.
        RUN proc_initdata.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2addr c-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2_bk c-Win 
PROCEDURE proc_assign2_bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_rindex AS INT INIT 0.
DEF VAR nv_date   AS DATE FORMAT "99/99/9999".
DEF VAR nv_total  AS CHAR INIT "".
ASSIGN
    nv_addrx = ""
    nv_addr  = ""
    n_garage = "".
FIND FIRST stat.insure WHERE 
    stat.insure.compno = nv_para     AND
    stat.insure.addr1  = fi_producer AND
    stat.insure.addr2  = fi_agent    NO-LOCK NO-ERROR.
IF AVAIL stat.insure THEN DO:
    ASSIGN
        n_garage  = "G"
        nv_prom   = CAPS(TRIM(Insure.Addr3))
        nv_pack   = CAPS(TRIM(Insure.Addr4)).
END.
ELSE 
    ASSIGN
        nv_prom = ""
        nv_pack = "E".
    
FIND sicsyac.xtm600 USE-INDEX xtm60001       WHERE
    sicsyac.xtm600.acno  =  fi_vatcod  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xtm600 THEN DO:
    nv_vatdes = TRIM(TRIM(xtm600.ntitle) + " " + trim(xtm600.NAME)).
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:   
    ASSIGN
        np_occupn        =  ""
        n_branch         = fi_branch
        nv_camp          =  ""
        np_addr1         =  ""
        np_addr2         =  ""
        np_addr3         =  ""
        np_addr4         =  ""
        n_idno           =  ""        
        nv_fcomp         =  ""      
        nv_fdate         =  ""      
        nv_fcont         =  ""      
        np_prepol        =  ""      
        n_policy70       =  ""      
        nv_fname         =  ""      
        nv_faddr         =  ""      
        np_icno          =  ""      
        nv_ftel          =  ""      
        nv_fdob          =  ""      
        nv_fexp          =  ""      
        n_comdat1        =  ""      
        n_expdat1        =  ""      
        n_brand1         =  ""      
        n_model1         =  ""      
        n_caryear        =  ""      
        n_Engine         =  ""  
        n_seat1         =  ""
        n_class70        =  ""      
        nf_vehuse70      =  ""
        n_class72        =  ""
        n_vehreg         =  ""      
        n_chassis        =  ""      
        n_engno          =  ""      
        nv_fdri1         =  ""      
        nv_fdri2         =  ""      
        nv_fddo1         =  ""      
        nv_fddo2         =  ""      
        n_cover          =  ""      
        nv_price         =  ""      
        n_siins          =  ""      
        n_nap            =  ""      
        n_naptx          =  ""      
        n_napcom         =  ""      
        n_napcomtx       =  ""      
        nv_total         =  ""
        n_sticker        =  ""      
        n_benname        =  ""      
        nv_vatname70     =  ""      
        nv_vatname72     =  ""      
        nv_acc           =  ""      
        nv_f51           =  ""      
        nv_f52           =  ""
        nv_addrx         =  ""
        nv_addr          =  ""
        n_policy72       =   ""
        n_garage         =  ""
        n_textf78        = ""
        nv_driid1        = ""
        nv_driid2        = "".

    ASSIGN
        n_textf7   = ""
        n_textf72  = ""
        n_textf73  = ""
        n_textf74  = ""
        n_textf75  = ""
        n_textf76  = ""
        n_textf77  = "" 
        nv_fname2  = "" 
        nv_campaign_ov  = "".      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 

    IMPORT DELIMITER "|" 
        n_idno        
        nv_fcomp      
        nv_fdate      
        nv_fcont      
        np_prepol     
        n_policy70    
        n_policy72    
        nv_fname    
        nv_fname2 
        np_addr1      
        np_addr2      
        np_addr3      
        np_addr4      
        np_icno       
        np_occupn     
        nv_ftel       
        nv_fdob       
        nv_fexp       
        n_comdat1        
        n_expdat1     
        n_brand1      
        n_model1      
        n_caryear     
        n_Engine
        n_seat1       
        n_class70     
        nf_vehuse70   
        n_class72     
        n_vehreg      
        n_chassis     
        n_engno  
        nv_fdri1 
        nv_fddo1 
        nv_driid1
        nv_fdri2 
        nv_fddo2 
        nv_driid2
        n_cover
        nv_price
        n_siins 
        n_nap
        n_naptx
        n_napcom
        n_napcomtx 
        nv_total       
        n_sticker
        n_benname
        nv_vatname70 
        nv_vatname72
        nv_acc     /*
        nv_f51
        nv_f52*/
        n_textf78
      /*  nv_camp */
        n_textf7  
        n_textf72 
        n_textf73 
        n_textf74 
        n_textf75 
        n_textf76 
        n_textf77 
        nv_campaign_ov        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        
        
        
        
        
        .

    ASSIGN
        n_policy72      =   TRIM(n_policy72   )
        n_idno          =   TRIM(n_idno       )            
        nv_fcomp        =   TRIM(nv_fcomp     )           
        nv_fdate        =   TRIM(nv_fdate     )           
        nv_fcont        =   TRIM(nv_fcont     )           
        np_prepol       =   TRIM(np_prepol    )           
        n_policy70      =   TRIM(n_policy70   )           
        nv_fname        =   TRIM(nv_fname     )     
        nv_fname2       =   TRIM(nv_fname2    )     
        nv_faddr        =   TRIM(nv_faddr     )           
        np_icno         =   TRIM(np_icno      )           
        nv_ftel         =   TRIM(nv_ftel      )           
        nv_fdob         =   TRIM(nv_fdob      )           
        nv_fexp         =   TRIM(nv_fexp      )           
        n_comdat1       =   TRIM(n_comdat1    )           
        n_expdat1       =   TRIM(n_expdat1    )           
        n_brand1        =   TRIM(n_brand1     )           
        n_model1        =   TRIM(n_model1     )           
        n_caryear       =   TRIM(n_caryear    )           
        n_Engine          =   TRIM(n_Engine       )           
        n_class70       =   TRIM(n_class70    )           
        nf_vehuse70     =   TRIM(nf_vehuse70  )           
        n_vehreg        =   TRIM(n_vehreg     )           
        n_chassis       =   TRIM(n_chassis    )           
        n_engno         =   TRIM(n_engno      )           
        nv_fdri1        =   TRIM(nv_fdri1     )           
        nv_fdri2        =   TRIM(nv_fdri2     )           
        nv_fddo1        =   TRIM(nv_fddo1     )           
        nv_fddo2        =   TRIM(nv_fddo2     )           
        n_cover         =   TRIM(n_cover      )           
        nv_price        =   TRIM(nv_price     )           
        n_siins         =   TRIM(n_siins      )           
        n_nap           =   TRIM(n_nap        )           
        n_naptx         =   TRIM(n_naptx      )           
        n_napcom        =   TRIM(n_napcom     )           
        n_napcomtx      =   TRIM(n_napcomtx   )           
        n_sticker       =   TRIM(n_sticker    )           
        n_benname       =   TRIM(n_benname    )           
        nv_vatname70    =   TRIM(nv_vatname70 )           
        nv_vatname72    =   TRIM(nv_vatname72 )           
        nv_acc          =   TRIM(nv_acc       )           
        nv_f51          =   TRIM(nv_f51       )           
        nv_f52          =   TRIM(nv_f52       ) 
        nv_camp         =   TRIM(nv_camp)     
        np_addr1        =   trim(np_addr1)              
        np_addr2        =   trim(np_addr2)         
        np_addr3        =   trim(np_addr3)         
        np_addr4        =   trim(np_addr4)         
        np_occupn       =   TRIM(np_occupn)

        n_textf7        =   trim(n_textf7 )    
        n_textf72       =   trim(n_textf72)    
        n_textf73       =   trim(n_textf73)    
        n_textf74       =   trim(n_textf74)    
        n_textf75       =   trim(n_textf75)    
        n_textf76       =   trim(n_textf76)    
        n_textf77       =   trim(n_textf77)    
        n_textf78       =   TRIM(n_textf78)


        
        .
    
    
    n_garage = "G".


    
    /*---
    IF nv_fcomp <> "" THEN n_textf7   = "บริษัทผู้แจ้งงาน : "  + nv_fcomp.
    IF nv_fdate <> "" THEN n_textf72  = "วันที่แจ้งงาน : "  + nv_fdate .
    IF nv_fcont <> "" THEN n_textf73  = "ชื่อผู้แจ้งงาน : " + nv_fcont.
    IF nv_f51   <> "" THEN n_textf74  = "Quatation Num. : " +     nv_f51.
    IF nv_f52   <> "" THEN n_textf75  = "หมายเหตุ : " +     nv_f52. 
    IF nv_camp  <> "" THEN n_textf76  = "รหัส CAMPAIGN : "  + nv_camp.
    n_textf77 = "ประเภทงาน " + n_cover.
    IF n_policy72 <> "" THEN n_textf77 + "  พรบ.".

    ASSIGN
        n_textf7   = TRIM(n_textf7 ) 
        n_textf72  = TRIM(n_textf72) 
        n_textf73  = TRIM(n_textf73) 
        n_textf74  = TRIM(n_textf74) 
        n_textf75  = TRIM(n_textf75) 
        n_textf76  = TRIM(n_textf76) 
        n_textf77  = TRIM(n_textf77)
        n_textf78  = TRIM(n_textf78).
*/


   /*--
    IF n_textf78 <> "" THEN n_textf78 = "เลขที่ตรวจสภาพ : " + n_textf78.
    IF n_textf7 = "" THEN
        ASSIGN
            n_textf7   = n_textf72 
            n_textf72  = n_textf73   
            n_textf73  = n_textf74 
            n_textf74  = n_textf75 
            n_textf75  = n_textf76 
            n_textf76  = n_textf77 
            n_textf77  = n_textf78
            n_textf78  = "".
    IF n_textf72 = "" THEN
        ASSIGN         
            n_textf72  = n_textf73            
            n_textf73  = n_textf74            
            n_textf74  = n_textf75           
            n_textf75  = n_textf76            
            n_textf76  = n_textf77            
            n_textf77  = n_textf78
            n_textf78  = "".                  
    IF n_textf73 = "" THEN
        ASSIGN
            n_textf73  = n_textf74               
            n_textf74  = n_textf75           
            n_textf75  = n_textf76           
            n_textf76  = n_textf77           
            n_textf77  = n_textf78
            n_textf78  = "".          
    IF n_textf74 = "" THEN
        ASSIGN
            n_textf74  = n_textf75           
            n_textf75  = n_textf76           
            n_textf76  = n_textf77           
            n_textf77  = n_textf78
            n_textf78  = "".          
    IF n_textf75 = "" THEN
        ASSIGN          
            n_textf75  = n_textf76           
            n_textf76  = n_textf77           
            n_textf77  = n_textf78
            n_textf78  = "".   
    IF n_textf76 = "" THEN
        ASSIGN               
            n_textf76  = n_textf77           
            n_textf77  = n_textf78
            n_textf78  = "".   
    IF n_textf77 = "" THEN
        ASSIGN
            n_textf77  = n_textf78
            n_textf78  = "".        
     n_textf78 = "".---*/


            


    
    IF INDEX(nv_fname," ") <> 0 THEN DO:
        nv_ctext = TRIM(SUBSTR(nv_fname,1,INDEX(nv_fname," "))).
        IF nv_ctext = "คุณ" THEN DO:
    
        END.
        ELSE IF nv_ctext = "บริษัท" THEN DO:
    
        END.
        ELSE DO:
            FIND FIRST brstat.msgcode WHERE msgcode.MsgDesc = nv_ctext NO-LOCK NO-ERROR.
            IF NOT AVAIL brstat.msgcode THEN DO:
                FIND FIRST brstat.msgcode WHERE msgcode.branch   = nv_ctext NO-LOCK NO-ERROR.
                IF NOT AVAIL brstat.msgcode THEN DO:
                    nv_ctext = "".
                END.
            END.
        END.
        IF nv_ctext <> "" THEN DO:
            ASSIGN
                nv_fname  = TRIM(SUBSTR(nv_fname,INDEX(nv_fname," ") + 1))
                nv_ntitle = nv_ctext
                nv_ctext  = "".
        END.
    END.
    np_title  = nv_ntitle   .
    np_name1  = nv_fname  .   




    IF nv_acc <> "" THEN DO:
        nv_addr = nv_acc.
        RUN pd_caddr.
        n_textacc  = nv_addrx.
        RUN pd_caddr.
        n_textacc1  = nv_addrx.
        RUN pd_caddr.
        n_textacc2  = nv_addrx.
        RUN pd_caddr.
        n_textacc3  = nv_addrx.
        RUN pd_caddr.
        n_textacc4  = nv_addrx.
        RUN pd_caddr.
        n_textacc5  = nv_addrx.
        RUN pd_caddr.
        n_textacc6  = nv_addrx.
        RUN pd_caddr.
        n_textacc7  = nv_addrx.
        RUN pd_caddr.
        n_textacc8  = nv_addrx.
        RUN pd_caddr.
        n_textacc9  = nv_addrx.


    END.   

    n_fi  =  n_siins        .
                 
   
    IF INDEX(nf_vehuse70,"จังหวัด") <> 0 THEN nf_vehuse70 = "5".
    ELSE IF INDEX(nf_vehuse70,"บุคคล") <> 0 AND INDEX(nf_vehuse70,"สาธารณะ") <> 0 THEN nf_vehuse70 = "4".
    ELSE IF INDEX(nf_vehuse70,"สาธารณะ") <> 0 THEN nf_vehuse70 = "3".
    ELSE IF INDEX(nf_vehuse70,"บุคคล") <> 0 THEN nf_vehuse70 = "1".
    ELSE nf_vehuse70 = "2".

    IF INDEX(n_vehreg,"แดง") <> 0 THEN n_vehreg = "".  /*-news car substr chassis--*/

    /*--
    IF n_napcom <> "" OR n_napcomtx <> "" THEN DO:

        ASSIGN
            n_class72   = n_class70
            n_comdat72  = n_comdat1
            n_expdat72  = n_expdat1
            nf_vehuse72 = nf_vehuse70.

        IF n_nap = "" AND n_naptx = "" THEN DO:
            ASSIGN
                n_policy72 = n_policy70 
                n_policy70 = ""
                n_class70  = ""
                n_comdat1  = ""
                n_expdat1  = ""
                nf_vehuse70 = ""
                .
        END.
        ELSE DO:
            RUN pd_fpol72.

        END.
           
    END.---*/
    IF  nv_fdri1  = "" AND nv_fddo1 = "" THEN 
        ASSIGN
            nv_fdri1 = nv_fdri2      
            nv_fddo1 = nv_fddo2  
            nv_fdri2 = ""   
            nv_fddo2 = ""  .

    IF n_policy72 <> "" THEN
        ASSIGN
            n_comdat72  = n_comdat1
            n_expdat72  = n_expdat1
            nf_vehuse72 = nf_vehuse70.
    n_class70 = trim(nv_pack) + trim(n_class70).

          /*
    IF n_nap <> "" OR n_naptx <> "" THEN DO:
        
        IF n_napcom <> "" OR n_napcomtx <> "" THEN DO:
        END.

    END.*/
        /*n_bennams*/
    IF TRIM(n_idno) = "" THEN RUN proc_initdata.
    ELSE IF index(TRIM(n_idno),"ที่")   <> 0 THEN RUN proc_initdata.
    ELSE IF index(TRIM(n_idno),"ลำดับ") <> 0 THEN RUN proc_initdata.
    ELSE IF index(TRIM(n_idno),"เลข")   <> 0 THEN RUN proc_initdata.
    ELSE IF index(TRIM(n_idno),"NO")    <> 0 THEN RUN proc_initdata.
    ELSE DO:
        IF n_policy70 <> "" THEN RUN proc_create70.
        IF n_policy72 <> "" THEN RUN proc_create72.
        RUN proc_initdata.
    END.


    
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
IF n_model = "" THEN n_model = TRIM(wdetail.model).
IF wdetail.redbook <> "" THEN DO:
    Find FIRST stat.maktab_fil Use-index      maktab01        Where
        stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3) And   
        stat.maktab_fil.modcod   =  trim(wdetail.redbook)     No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        wdetail.redbook  =  stat.maktab_fil.modcod /*
        wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes  */
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
        index(stat.maktab_fil.makdes,trim(wdetail.brand)) <> 0               And                  
        index(stat.maktab_fil.moddes,n_model) <> 0              And
        stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
        /*stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND*/
        stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)         AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod   /*
            wdetail.brand    =  stat.maktab_fil.makdes   
             wdetail.model    =  stat.maktab_fil.moddes  */
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
            index(stat.maktab_fil.makdes,trim(wdetail.brand)) <> 0            And                  
            index(stat.maktab_fil.moddes,n_model) <> 0              And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)         AND
           (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
            stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN DO:
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod  /*
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes  */
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
            wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn
            wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
        END.
        ELSE wdetail.redbook  = "".
    END.
END.
ELSE DO:
    IF wdetail.engcc = "" THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
        index(stat.maktab_fil.makdes,trim(wdetail.brand)) <> 0            And                  
        index(stat.maktab_fil.moddes,n_model) <> 0              And
        stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
        /*stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND*/
        stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)         AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  AND  
        stat.maktab_fil.seats    >=    DECI(wdetail.seat)       No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod /*
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes */
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
            index(stat.maktab_fil.makdes,trim(wdetail.brand)) <> 0              And                  
            index(stat.maktab_fil.moddes,n_model) <> 0              And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)         AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
             stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  AND  
            stat.maktab_fil.seats    >=    DECI(wdetail.seat)       No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod  /*
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes  */
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
            wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn
            wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat.
        ELSE wdetail.redbook  = "".
    END.
END.
IF TRIM(wdetail.redbook)  = "" THEN DO:
/*--   
    IF wdetail.policy = "DM7059011040" THEN 
        MESSAGE 
        "wdetail.brand              "  wdetail.brand                skip 
        "n_model                    "  n_model                      skip 
        "wdetail.caryear            "  wdetail.caryear              skip 
        "wdetail.engcc              "  wdetail.engcc                skip 
        "SUBSTR(wdetail.class,2,3)  "  SUBSTR(wdetail.class,2,3)    skip 
        "wdetail.mkval              "  wdetail.mkval                skip .

--*/






    IF TRIM(wdetail.mkval) <> "" THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            index(stat.maktab_fil.makdes,trim(wdetail.brand)) <> 0              And                  
            index(stat.maktab_fil.moddes,n_model) <> 0              And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)         AND
            stat.maktab_fil.maksi    =  DECI(wdetail.mkval)               No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN DO:
            
    
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod  /*
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes  */
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
            wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn
            wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
        END.
        ELSE wdetail.redbook  = "".
            
    END.
    IF TRIM(wdetail.redbook)  = "" THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            index(stat.maktab_fil.makdes,trim(wdetail.brand)) <> 0               And                  
            index(stat.maktab_fil.moddes,n_model) <> 0              And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)     No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN DO:
          
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod  /*
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes  */
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
            wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn
            wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
        END.
        ELSE wdetail.redbook  = "".
    END.

    IF TRIM(wdetail.redbook)  = "" THEN DO:
        /*MESSAGE wdetail.brand VIEW-AS ALERT-BOX. */
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            index(stat.maktab_fil.makdes,trim(wdetail.brand)) <> 0        And                  
            index(stat.maktab_fil.moddes,n_model) <> 0                    And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            /*stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND*/
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)     No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN DO:
          
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod  /*
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes  */
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
            wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn
            wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
        END.
        ELSE wdetail.redbook  = "".
    END.







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
    re_comdat         = ""                          
    re_expdat         = ""                          
    re_class          = ""                          
    re_moddes         = ""                          
    re_yrmanu         = ""                          
    re_seats          = ""                      
    re_vehuse         = ""                     
    re_covcod         = ""                     
    re_garage         = ""                     
    re_vehreg         = ""                     
    re_cha_no         = ""                     
    re_eng_no         = ""                     
    re_uom1_v         = ""                     
    re_uom2_v         = ""                     
    re_uom5_v         = ""                     
    re_si             = ""                     
    re_baseprm        = 0                      
    re_41             = 0                      
    re_42             = 0                      
    re_43             = 0                      
    re_seat41         = 0                      
    re_dedod          = 0                      
    re_addod          = 0                      
    re_dedpd          = 0                      
    re_flet_per       = ""                     
    re_ncbper         = ""                     
    re_dss_per        = ""                     
    re_stf_per        = 0                      
    re_cl_per         = 0                      
    re_bennam1        = ""   .                 
                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew_pol c-Win 
PROCEDURE proc_assignrenew_pol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    np_dedod       = ""  
    np_addod       = ""     
    np_dedpd       = ""
    np_stf_per     = ""           
    np_cl_per      = ""         
    n_benname      = "" 
    n_policy72     = ""
    np_prepol      = ""
    n_brand1       = ""
    n_body         = ""
    nn_redbook     = ""
    n_Engine       = ""
    n_Tonn70       = 0.00.
RUN proc_assignrenew_inipol.
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    /*---- create by : A59-0060-----*/
    RUN wgw\wgwbu2ex(INPUT-OUTPUT  wdetail.prepol,      
                     INPUT-OUTPUT  wdetail.n_branch,               
                     INPUT-OUTPUT  wdetail.inserf,            
                     INPUT-OUTPUT  wdetail.tiname,             
                     INPUT-OUTPUT  wdetail.insnam,                  
                     INPUT-OUTPUT  wdetail.name2,            
                     INPUT-OUTPUT  wdetail.name3,          
                     INPUT-OUTPUT  wdetail.n_addr1,       
                     INPUT-OUTPUT  wdetail.n_addr2,          
                     INPUT-OUTPUT  wdetail.n_addr3,          
                     INPUT-OUTPUT  wdetail.n_addr4,       
                     INPUT-OUTPUT  wdetail.firstdat,   
                     INPUT-OUTPUT  re_comdat,              
                     INPUT-OUTPUT  re_expdat,              
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
                     INPUT-OUTPUT  re_bennam1).      
    /*RUN proc_assignrenew_pol2.*/ /*A59-0060*/
    /*comment by Kridtiya i. A56-0151 ... */
   /*---- Create by A59-0060----*/
    ASSIGN np_prepol = wdetail.prepol
           n_policy  = wdetail.cr_2
           n_brand1  = wdetail.brand.
    IF wdetail.cr_2 <> "" THEN DO: /* ใส่ข้อมูลให้ พรบ. */
       FIND LAST wdetail WHERE wdetail.policy = n_policy AND wdetail.covcod = "T" NO-LOCK no-error .
        IF AVAIL wdetail THEN DO:
           RUN proc_assignrenew_pol2.
        IF wdetail.CLASS = "" THEN RUN proc_chkclass72.
       END.
    END.

    FIND LAST wdetail WHERE wdetail.prepol = np_prepol AND wdetail.covcod <> "T" NO-LOCK NO-ERROR . /* ใส่ข้อมูลให้ กธ. */
    IF AVAIL wdetail THEN DO:
             RUN proc_assignrenew_pol2.
    END.
    /*---- End : A59-0060----*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew_pol2 c-Win 
PROCEDURE proc_assignrenew_pol2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---- create by : A59-0060-----*/
IF  wdetail.comdat   = ""   THEN  ASSIGN wdetail.comdat   =  re_comdat .     
IF  wdetail.expdat   = ""   THEN  ASSIGN wdetail.expdat   =  re_expdat .     
IF  wdetail.class    = ""   THEN DO: 
    IF wdetail.covcod = "T" THEN  ASSIGN wdetail.class = " " .
    ELSE ASSIGN wdetail.class = re_class .
END.
IF  wdetail.base     = "0" OR wdetail.base = "" THEN 
    ASSIGN wdetail.base     =  STRING(re_baseprm).
IF  wdetail.body     = ""   THEN ASSIGN wdetail.body     =  n_body.
IF  wdetail.ton      = 0    THEN ASSIGN wdetail.ton      =  n_Tonn70.
IF  wdetail.engcc    = ""   THEN ASSIGN wdetail.engcc    =  n_engine.
IF  wdetail.redbook  = ""   THEN ASSIGN wdetail.redbook  =  nn_redbook.
IF  wdetail.brand    = ""   THEN ASSIGN wdetail.brand    =  re_moddes .     
IF  wdetail.caryear  = ""   THEN ASSIGN wdetail.caryear  =  re_yrmanu .     
IF  wdetail.seat     = ""   THEN ASSIGN wdetail.seat     =  re_seats  .         
IF  wdetail.vehuse   = ""   THEN ASSIGN wdetail.vehuse   =  re_vehuse .       
IF  wdetail.covcod   = ""   THEN ASSIGN wdetail.covcod   =  re_covcod .       
IF  wdetail.garage   = ""   THEN ASSIGN wdetail.garage   =  re_garage .       
IF  wdetail.vehreg   = ""   THEN ASSIGN wdetail.vehreg   =  re_vehreg .        
IF  wdetail.chassis  = ""   THEN ASSIGN wdetail.chassis  =  re_cha_no .     
IF  wdetail.engno    = ""   THEN ASSIGN wdetail.engno    =  re_eng_no .       
IF  wdetail.uom1_v   = ""   THEN ASSIGN wdetail.uom1_v   =  re_uom1_v .      
IF  wdetail.uom2_v   = ""   THEN ASSIGN wdetail.uom2_v   =  re_uom2_v .     
IF  wdetail.uom5_v   = ""   THEN ASSIGN wdetail.uom5_v   =  re_uom5_v .     
IF  wdetail.si       = ""   THEN ASSIGN wdetail.si       =  re_si     .
IF  wdetail.fi       = ""   THEN ASSIGN wdetail.fi       =  wdetail.si.
IF  wdetail.nv_41    = ""   THEN ASSIGN wdetail.nv_41    =  STRING(re_41).      
IF  wdetail.nv_412   = ""   THEN ASSIGN wdetail.nv_412   =  STRING(re_41).     
IF  wdetail.nv_42    = ""   THEN ASSIGN wdetail.nv_42    =  STRING(re_42). 
IF  wdetail.nv_43    = ""   THEN ASSIGN wdetail.nv_43    =  STRING(re_43). 
IF  wdetail.seat41   = 0    THEN ASSIGN wdetail.seat41   =  re_seat41 .
IF  wdetail.dod1     = ""   THEN ASSIGN wdetail.dod1     =  STRING(re_dedod).     
IF  wdetail.dod2     = ""   THEN ASSIGN wdetail.dod2     =  STRING(re_addod).     
IF  wdetail.dod0     = ""   THEN ASSIGN wdetail.dod0     =  STRING(re_dedpd).     
IF  wdetail.fleet    = ""   THEN ASSIGN wdetail.fleet    =  STRING(re_flet_per).      
IF  wdetail.ncb      = ""   THEN ASSIGN wdetail.ncb      =  STRING(re_ncbper).      
IF  wdetail.dspc     = ""   THEN ASSIGN wdetail.dspc     =  STRING(re_dss_per).      
IF  wdetail.stf_per  = ""   THEN ASSIGN wdetail.stf_per  =  STRING(re_stf_per).      
IF  wdetail.cl_per   = ""   THEN ASSIGN wdetail.cl_per   =  STRING(re_cl_per).     
IF  wdetail.benname  = ""   THEN ASSIGN wdetail.benname  =  re_bennam1.

/*MESSAGE "2 " /* wdetail.comdat     SKIP     
         wdetail.expdat     SKIP  
         wdetail.class      SKIP
         wdetail.body       SKIP
         wdetail.ton        SKIP
         wdetail.engcc      SKIP
         wdetail.redbook    SKIP
         wdetail.brand      SKIP
         wdetail.caryear    SKIP
         wdetail.seat       SKIP
         wdetail.vehuse     SKIP
         wdetail.covcod     SKIP
         wdetail.garage     SKIP
         wdetail.vehreg     SKIP
         wdetail.chassis    SKIP
         wdetail.engno      SKIP
         wdetail.uom1_v     SKIP
         wdetail.uom2_v     SKIP
         wdetail.uom5_v     SKIP
         wdetail.si         SKIP
         wdetail.fi         SKIP*/
         wdetail.prepol     SKIP
         wdetail.covcod     SKIP
         "Base " wdetail.base       SKIP
        /* wdetail.nv_41      SKIP
         wdetail.nv_412     SKIP
         wdetail.nv_42      SKIP
         wdetail.nv_43      SKIP
         wdetail.seat41     SKIP
         wdetail.dod1       SKIP
         wdetail.dod2       SKIP
         wdetail.dod0       SKIP
         wdetail.fleet      SKIP*/
         "NCB " wdetail.ncb        SKIP
        /* wdetail.dspc       SKIP
         wdetail.stf_per    SKIP
         wdetail.cl_per     SKIP*/
         wdetail.benname VIEW-AS ALERT-BOX.*/

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
        nv_baseprm    = 0 .
        nv_baseprm    = DECI(wdetail.base). 
    DISP fi_process WITH FRAM fr_main.
   /*-- IF fi_policymas <> ""  THEN DO:
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
    END.---*/
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
        

        
        /*---test---*/

        ASSIGN
            nv_drivage1 = 0
            nv_drivage2 = 0
            nv_drivno   = 0.
        IF wdetail.fdri2 <> "" THEN DO:
            nv_drivno = 2.
            nv_drivage1 = INT(SUBSTR(wdetail.fddo1,7,4)) NO-ERROR.
            IF nv_drivage1 <> 0 THEN DO:
                nv_drivage1 = (YEAR(TODAY) + 543) - INT(SUBSTR(wdetail.fddo1,7,4)).
            END.
            nv_drivage2 = INT(SUBSTR(wdetail.fddo2,7,4)) NO-ERROR.
            IF nv_drivage2 <> 0 THEN DO:
                nv_drivage2 = (YEAR(TODAY) + 543) - INT(SUBSTR(wdetail.fddo2,7,4)).
            END.
        END.
        ELSE IF wdetail.fdri1 <> ""  THEN DO: 
            nv_drivno = 1.
            nv_drivage1 = INT(SUBSTR(wdetail.fddo1,7,4)) NO-ERROR.
            IF nv_drivage1 <> 0 THEN DO:
                nv_drivage1 = (YEAR(TODAY) + 543) - INT(SUBSTR(wdetail.fddo1,7,4)).
            END.
        END.
        IF nv_drivno <> 0 THEN DO: 
            RUN proc_driver.
            /*---test---*/
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
    ASSIGN                                    /*--
        nv_41     =  deci(wdetail.nv_41)    
        nv_412    =  deci(wdetail.nv_412)   */
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
   /* IF fi_policymas <> ""  THEN DO:
        RUN proc_base2plus0.
    END.                             */
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
        /*---test---*/
        ASSIGN
            nv_drivage1 = 0
            nv_drivage2 = 0
            nv_drivno   = 0.
        IF wdetail.fdri2 <> "" THEN DO:
            nv_drivno = 2.
            nv_drivage1 = INT(SUBSTR(wdetail.fddo1,7,4)) NO-ERROR.
            IF nv_drivage1 <> 0 THEN DO:
                nv_drivage1 = (YEAR(TODAY) + 543) - INT(SUBSTR(wdetail.fddo1,7,4)).
            END.
            nv_drivage2 = INT(SUBSTR(wdetail.fddo2,7,4)) NO-ERROR.
            IF nv_drivage2 <> 0 THEN DO:
                nv_drivage2 = (YEAR(TODAY) + 543) - INT(SUBSTR(wdetail.fddo2,7,4)).
            END.
        END.
        ELSE IF wdetail.fdri1 <> ""  THEN DO: 
            nv_drivno = 1.
            nv_drivage1 = INT(SUBSTR(wdetail.fddo1,7,4)) NO-ERROR.
            IF nv_drivage1 <> 0 THEN DO:
                nv_drivage1 = (YEAR(TODAY) + 543) - INT(SUBSTR(wdetail.fddo1,7,4)).
            END.
        END.
        IF nv_drivno <> 0 THEN DO: 
            RUN proc_driver.
            /*---test---*/
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
    ASSIGN                                    /*--
        nv_41     =  deci(wdetail.nv_41)    
        nv_412    =  deci(wdetail.nv_412)   */
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
/*--
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
        END.    /*RUN proc_assign_polmas.*/---*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkclass72 c-Win 
PROCEDURE proc_chkclass72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 FIND FIRST sicsyac.xzmcom WHERE sicsyac.xzmcom.class    = re_class   AND
                                 sicsyac.xzmcom.garage   = re_garage  AND
                                 sicsyac.xzmcom.var_amt >= n_Tonn70   AND
                                 sicsyac.xzmcom.vehuse   = re_vehuse NO-LOCK NO-ERROR NO-WAIT.
     IF AVAILABLE sicsyac.xzmcom THEN 
         ASSIGN wdetail.CLASS = sicsyac.xzmcom.comp_cod.
     ELSE DO:
         FIND FIRST sicsyac.xzmcom WHERE
             sicsyac.xzmcom.class    = re_class     AND
             sicsyac.xzmcom.garage   = re_garage    AND
             sicsyac.xzmcom.vehuse   = re_vehuse  NO-LOCK NO-ERROR NO-WAIT.
             IF AVAILABLE sicsyac.xzmcom THEN 
                 ASSIGN wdetail.CLASS = sicsyac.xzmcom.comp_cod.
             ELSE DO:
                 FIND FIRST sicsyac.xzmcom WHERE 
                     sicsyac.xzmcom.class    = re_class   AND
                     sicsyac.xzmcom.vehuse   = re_vehuse  NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAILABLE sicsyac.xzmcom THEN 
                         ASSIGN wdetail.CLASS = sicsyac.xzmcom.comp_cod.
             END.
     END.

 IF INDEX(wdetail.CLASS,".") <> 0 THEN 
    ASSIGN wdetail.CLASS = trim(REPLACE(wdetail.CLASS,".","")).
 ELSE 
    ASSIGN wdetail.CLASS = trim(wdetail.CLASS).

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
ASSIGN nv_siredbook = 0
    nv_siredbook    = IF (wdetail.si = "" ) AND (wdetail.fi <> "" ) THEN DECI(wdetail.fi)  ELSE DECI(wdetail.si).
IF wdetail.vehreg  = "" THEN 
    wdetail.vehreg = IF SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8) <> "" THEN
                       "/" +   SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8 ) 
                     ELSE "".
IF wdetail.vehreg = " " THEN 
    ASSIGN wdetail.vehreg = "/" + SUBSTRING(trim(wdetail.chassis),LENGTH(trim(wdetail.chassis))  - 8 ) 
    wdetail.comment       = wdetail.comment + "| Vehicle Register is mandatory field. "
    wdetail.pass          = "N"   
    wdetail.OK_GEN        = "N". 
/*ELSE DO:
        DEF  var  nv_vehreg  as char  init  " ".
        Def  var  s_polno       like sicuw.uwm100.policy   init " ".
        Find LAST sicuw.uwm301 Use-index uwm30102   Where  
            sicuw.uwm301.vehreg = wdetail.vehreg    No-lock no-error no-wait.
        IF AVAIL sicuw.uwm301 THEN DO:
            If  sicuw.uwm301.policy =  wdetail.policy     and          
                sicuw.uwm301.endcnt = 1  and
                sicuw.uwm301.rencnt = 1  and
                sicuw.uwm301.riskno = 1  and
                sicuw.uwm301.itemno = 1  Then  Leave.
            Find first sicuw.uwm100 Use-index uwm10001      Where
                sicuw.uwm100.policy = sicuw.uwm301.policy   and
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt   and 
                sicuw.uwm100.expdat > date(wdetail.comdat)  No-lock no-error no-wait.
            If avail sicuw.uwm100 Then  s_polno     =   sicuw.uwm100.policy.
        END.    /*avil 301*/
END.            /*note end else*/   /*end note vehreg*/*/
IF wdetail.cancel = "ca"  THEN  
    ASSIGN wdetail.pass = "N"  
    wdetail.comment     = wdetail.comment + "| cancel"
    wdetail.OK_GEN      = "N".
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
    /*ELSE  
        ASSIGN  
            wdetail.comment = wdetail.comment + "| WARNING: พบเลขบัตรประชาชนไม่ถูกต้องไม่เท่ากับ 13 หลัก " + wdetail.nv_icno
            wdetail.nv_icno    = "" 
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
n_model = "".
IF INDEX(wdetail.model," ") <> 0 THEN 
    /*wdetail.model = TRIM(SUBSTR(wdetail.model,1,INDEX(wdetail.model," "))) .*/
    n_model = TRIM(SUBSTR(wdetail.model,1,INDEX(wdetail.model," "))) .
If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
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
IF wdetail.prepol = "" THEN DO:
    /*Find FIRST stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =     trim(wdetail.brand)      And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
        stat.maktab_fil.sclass   =    SUBSTR(wdetail.class,2,3) No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        wdetail.redbook =  stat.maktab_fil.modcod
        wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  stat.maktab_fil.body 
        wdetail.Tonn     =  stat.maktab_fil.tons
        wdetail.engcc    =  STRING(stat.maktab_fil.engine)
        wdetail.cargrp   =  stat.maktab_fil.prmpac 
        wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .*/
    /****
    IF wdetail.redbook <> "" THEN DO:
        Find FIRST stat.maktab_fil Use-index      maktab01        Where
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3) And   
            stat.maktab_fil.modcod   =  trim(wdetail.redbook)     No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  stat.maktab_fil.body 
            wdetail.Tonn     =  IF wdetail.Tonn = 0 THEN stat.maktab_fil.tons ELSE wdetail.Tonn
            wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .

    END.
    ELSE IF wdetail.seat = "" THEN DO:
        IF wdetail.engcc = "" THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
            index(stat.maktab_fil.moddes,wdetail.model) <> 0              And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            /*stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND*/
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)         AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
             stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  stat.maktab_fil.body 
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
                stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)         AND
               (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(nv_siredbook)    AND 
                stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(nv_siredbook) )  No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN
                ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.body     =  stat.maktab_fil.body 
                wdetail.Tonn     =  IF wdetail.Tonn = 0 THEN stat.maktab_fil.tons ELSE wdetail.Tonn
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
            index(stat.maktab_fil.moddes,wdetail.model) <> 0              And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            /*stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND*/
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
            wdetail.body     =  stat.maktab_fil.body 
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
                wdetail.body     =  stat.maktab_fil.body 
                wdetail.Tonn     =  IF wdetail.Tonn = 0 THEN stat.maktab_fil.tons ELSE wdetail.Tonn
                wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
                                    ELSE wdetail.redbook  = "".
        END.
    END.*/
    RUN proc_assignredbook.

END.
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
   RUN proc_susspect.  /*Add by Kridtiya i. A63-0419 */ 
   IF wdetail.prepol <> ""  THEN DO:
    RUN proc_renew70.
    RUN proc_chktest0.
    RUN proc_policy.  
    RUN proc_chktest2. 
    RUN proc_chktest3.
    RUN proc_chktest4.
   END.
   ELSE DO:
        IF wdetail.poltyp = "V70"  THEN DO:  
            RUN proc_chktest0.     
            RUN proc_policy.      
            RUN proc_chktest2.       
            RUN proc_chktest3.                         
            RUN proc_chktest4.                         
        END.                                           
        ELSE DO:           
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
        /*--
        IF (wdetail.prepol <> "") OR (substr(wdetail.class,1,1) = "Z") THEN
            ASSIGN nv_41          = deci(wdetail.nv_41) 
                   nv_412         = deci(wdetail.nv_412) 
                   nv_42          = deci(wdetail.nv_42) 
                   nv_43          = deci(wdetail.nv_43) 
                   nv_seat41      = IF wdetail.seat41 = 0 THEN deci(wdetail.seat) ELSE wdetail.seat41
                   /*wdetail.seat41 = IF nv_seat41 = 0 THEN deci(wdetail.seat) ELSE nv_seat41 */  .
        ELSE*/ IF  wdetail.garage =  ""  Then
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
      /*sic_bran.uwm301.trareg    = trim(wdetail.vehreg)*/  /*A58-0206*/
        sic_bran.uwm301.trareg    = nv_uwm301trareg         /*A58-0206*/
        sic_bran.uwm301.eng_no    = trim(wdetail.engno)
        sic_bran.uwm301.Tons      = DECI(wdetail.Tonn)
        sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
        sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage    = trim(wdetail.garage)
        sic_bran.uwm301.body      = trim(wdetail.body)
        sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv41seat  = wdetail.seat41
        sic_bran.uwm301.mv_ben83  = IF wdetail.poltyp = "v70" THEN trim(wdetail.benname) ELSE ""
      /*sic_bran.uwm301.vehreg    = trim(wdetail.vehreg) */              /*A58-0206*/   
        sic_bran.uwm301.vehreg    = substr(trim(wdetail.vehreg),1,11)    /*A58-0206*/   
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
    nv_tariff = sic_bran.uwm301.tariff             
    nv_class  = wdetail.class 
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = DECI(wdetail.engcc)
    nv_tons   = deci(wdetail.tonn) 
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse                     
    nv_COMPER = deci(wdetail.comper)               
    nv_comacc = deci(wdetail.comacc)               
    nv_seats  = INTE(wdetail.seat)     
    /*nv_tons   = DECI(wdetail.Tonn) */             
    /*nv_dss_per = 0  */                           
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
    /*nv_ncb     =   0*/                                  
    nv_totsi     =  0 .  
IF wdetail.compul = "y" THEN DO:
    ASSIGN nv_comper  = deci(sicsyac.xmm016.si_d_t[8]) 
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
/*RUN proc_base2.*/
IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR 
   (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" )  THEN RUN proc_base2plus.   /*A58-0271*/
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
      nv_pdacod   = "" 
      /*nv_class = SUBSTRING(nv_class,2,3)*/   .
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                    nv_class ,
                    nv_covcod,
                    nv_key_b ,
                    nv_comdat,
                    nv_totsi ,
                    nv_uom1_v ,       
                    nv_uom2_v ,       
                    nv_uom5_v ).
END.
ASSIGN fi_process = "Create data to uwm120 stamp tax ..." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
/*IF fi_policymas <> ""   THEN RUN proc_assign_polmas.*/

RUN proc_uwm100.
RUN proc_uwm120.
RUN proc_uwm301.
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
DEF VAR nv_fi_netprm    AS DECI INIT 0.00 .
DEF VAR NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR nv_fi_stamp_per AS DECI INIT 0.00.
DEF VAR nv_fi_rstp_t    AS INTE INIT 0.
DEF VAR nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF VAR nv_fi_com1_t    AS DECI INIT 0.00.
DEF VAR nv_fi_com2_t    AS DECI INIT 0.00.
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
If  not avail sic_bran.uwm100  Then do:
    /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
    Return.
END.
Else  do:
    Assign nv_policy  =  CAPS(sic_bran.uwm100.policy)
        nv_rencnt     =  sic_bran.uwm100.rencnt
        nv_endcnt     =  sic_bran.uwm100.endcnt.
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
        END.   /*uwm130 */
        ASSIGN
            n_gap_t      = n_gap_t   + n_gap_r
            n_prem_t     = n_prem_t  + n_prem_r
            n_sigr_t     = n_sigr_t  + n_sigr_r
            n_gap_r      = 0 
            n_prem_r     = 0  
            n_sigr_r     = 0.
    END.    /* end uwm120 */
END.   /*  avail  100   */

IF sic_bran.uwm100.prvpol = "" AND wdetail.commission <> "" THEN DO:  /*--งาน New : A59-0060--*/
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
        Assign      /*
        nv_com1p = sicsyac.xmm018.commsp  
        nv_com1p = deci(wdetail.commission)*/
        nv_com1p = 0
        nv_com2p = 0.
    ELSE DO:
            Find sicsyac.xmm031  Use-index xmm03101  Where  
                sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
                No-lock no-error no-wait.
              IF not  avail sicsyac.xmm031 Then 
                Assign     nv_com1p = 0
                           nv_com2p = 0.
              Else  
                   Assign     nv_com1p = 0
                           nv_com2p = 0.
                  /*--
                Assign     nv_com1p = sicsyac.xmm031.comm1
                           nv_com1p = deci(wdetail.commission)
                           nv_com2p = 0 .---*/
      END. /* Not Avail Xmm018 */
      /***--- Commmission Rate Line 72 ---***/
      IF wdetail.compul = "y" THEN DO:
          ASSIGN
              nv_com2p = 0
              nv_com2p = 0.

          /*--
          FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
                     sicsyac.xmm018.agent              = sic_bran.uwm100.acno1  AND               
                     substr(sicsyac.xmm018.poltyp,1,5) = "CRV72"                AND               
                     SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch AND               
                     sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR. 
          IF AVAIL   sicsyac.xmm018 THEN 
              ASSIGN 
              nv_com2p =  sicsyac.xmm018.commsp
              nv_com2p =  deci(wdetail.commission).
          ELSE DO:
               Find  sicsyac.xmm031  Use-index xmm03101  Where  
                     sicsyac.xmm031.poltyp    = "v72"    No-lock no-error no-wait.
               ASSIGN nv_com2p = sicsyac.xmm031.comm1
                      nv_com2p =  deci(wdetail.commission).
                      
          END. */
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
             nv_com1p = 0.
             /*--
             ASSIGN nv_com1p  = sic_bran.uwm120.com1p
                    nv_com1p  = deci(wdetail.commission)*/ .
                    nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.            
             /*fi_com1ae        =  YES.*/
      End.
      /*----------- comp comission ------------*/
      IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
          If sic_bran.uwm120.com2p <> 0  Then 
              assign 
              nv_com2p  =  0.
                             /*
               nv_com2p  = sic_bran.uwm120.com2p
               nv_com2p  = deci(wdetail.commission).*/
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
END. /*A59-0060*/
/* งานต่ออายุ : A59-0060 */
ELSE IF sic_bran.uwm100.prvpol <> "" OR  wdetail.commission = "" THEN DO:
    RUN proc_chktest4_2.
END.
/* End A59-0060 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4_2 c-Win 
PROCEDURE proc_chktest4_2 :
/*------------------------------------------------------------------------------
  Purpose: Create by A59-0060    
  Parameters:  <none>
  Notes: งานต่ออายุ      
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
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
If  not avail sic_bran.uwm100  Then do:
    Return.
END.
Else  do:
    Assign nv_policy  =  CAPS(sic_bran.uwm100.policy)
        nv_rencnt     =  sic_bran.uwm100.rencnt
        nv_endcnt     =  sic_bran.uwm100.endcnt.
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
        END.   /*uwm130 */
        ASSIGN
            n_gap_t      = n_gap_t   + n_gap_r
            n_prem_t     = n_prem_t  + n_prem_r
            n_sigr_t     = n_sigr_t  + n_sigr_r
            n_gap_r      = 0 
            n_prem_r     = 0  
            n_sigr_r     = 0.
    END.    /* end uwm120 */
END.   /*  avail  100   */
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
        Assign     
        nv_com1p = sicsyac.xmm018.commsp  
        /*nv_com1p = deci(wdetail.commission)*/
        nv_com1p = 0
        nv_com2p = 0.
    ELSE DO:
            Find sicsyac.xmm031  Use-index xmm03101  Where  
                sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
                No-lock no-error no-wait.
              IF not  avail sicsyac.xmm031 Then 
                Assign     nv_com1p = 0
                           nv_com2p = 0.
              Else  
                Assign     
                           nv_com1p = 0
                           /*nv_com1p = sicsyac.xmm031.comm1*/
                           /*nv_com1p = deci(wdetail.commission)*/
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
              ASSIGN 
              nv_com2p = 0
              /*
              nv_com2p =  sicsyac.xmm018.commsp*/  .
              /*nv_com2p =  deci(wdetail.commission).*/
          ELSE DO:
               Find  sicsyac.xmm031  Use-index xmm03101  Where  
                     sicsyac.xmm031.poltyp    = "v72"    No-lock no-error no-wait.
               ASSIGN 
                   nv_com2p = 0
              /*
                   nv_com2p = sicsyac.xmm031.comm1*/ .
                      /*nv_com2p =  deci(wdetail.commission).*/
                      
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
             ASSIGN 
                    nv_com1p  = 0
                    /*
                    nv_com1p  = sic_bran.uwm120.com1p*/  .
                    /*nv_com1p  = deci(wdetail.commission).*/
                    nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.            
             /*fi_com1ae        =  YES.*/
      End.
      /*----------- comp comission ------------*/
      IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
          If sic_bran.uwm120.com2p <> 0  Then 
              assign 
              nv_com2p   = 0
                            /*
               nv_com2p  = sic_bran.uwm120.com2p*/ .
               /*nv_com2p  = deci(wdetail.commission).*/
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
FIND FIRST wdetail WHERE wdetail.policy = trim(n_policy70)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.number     = trim(n_idno) 
        wdetail.prepol     = TRIM(np_prepol)      
        wdetail.policy     = trim(n_policy70)       
        wdetail.cr_2       = trim(n_policy72)  
        /*wdetail.poltyp     = "V70"*/                                   /*A58-0206*/
        wdetail.poltyp     = IF np_type01 = "" THEN "V70" ELSE np_type01 /*A58-0206*/
        wdetail.n_branch   = trim(n_branch)                      
        wdetail.inserf     = trim(np_insref)   
        wdetail.icno       = TRIM(np_icno)
        wdetail.tiname     = trim(np_title)                                     
        wdetail.insnam     = trim(np_name1)    
        wdetail.name2      = TRIM(nv_fname2)
        wdetail.name3      = ""
        wdetail.n_addr1    = trim(np_addr1)                                      
        wdetail.n_addr2    = trim(np_addr2)                                     
        wdetail.n_addr3    = TRIM(np_addr3)                                     
        wdetail.n_addr4    = trim(np_addr4) 
        wdetail.covcod     = trim(n_cover)                   
        wdetail.textf7     = trim(n_textf7)                  
        wdetail.textf5     = trim(n_textf5)                  
        wdetail.commission = trim(n_com70)             
        wdetail.class      = trim(n_class70)    
        wdetail.seat       = TRIM(n_seat1)
        wdetail.engcc      = trim(n_Engine)         /*A57-0195*/   
        wdetail.Tonn       = IF n_Tonnage = "" THEN 0 ELSE deci(trim(n_Tonnage))  /*A57-0195*/   
        wdetail.benname    = TRIM(n_bennams)        /*A57-0195*/   
        wdetail.garage     = TRIM(n_garage)
        wdetail.uom1_v     = trim(n_uom1_v)              
        wdetail.uom2_v     = trim(n_uom2_v)        
        wdetail.uom5_v     = trim(n_uom5_v)        
        wdetail.si         = trim(n_siins)            
        wdetail.fi         = trim(n_fi)                           
        wdetail.nv_41      = trim(n_nv_41)  
        wdetail.nv_412     = trim(n_nv_412)   
        wdetail.nv_42      = trim(n_nv_42)                                 
        wdetail.nv_43      = trim(n_nv_43) 
        wdetail.seat41     = IF TRIM(n_seat_41) = "" THEN DECI(TRIM(n_seat1)) ELSE DECI(TRIM(n_seat_41))
        wdetail.ncb        = trim(n_ncb)   
        wdetail.fleet      = trim(n_feet)  
        wdetail.dspc       = trim(n_dspc) 
        wdetail.base       = IF trim(n_base) = "" THEN "0" ELSE TRIM(n_base)    
        wdetail.prem_nap   = TRIM(n_nap)
        wdetail.vehreg     = trim(n_vehreg)   
        wdetail.redbook    = TRIM(nn_redbook)
        wdetail.brand      = trim(n_brand1)               
        wdetail.model      = trim(n_model1)   
        wdetail.body       = TRIM(n_body)         /*A57-0426 Kridtiya i. 19/11/2014 */
        wdetail.chassis    = trim(n_chassis)           
        wdetail.engno      = trim(n_engno)             
        wdetail.caryear    = trim(n_caryear)  
        wdetail.firstdat   = trim(n_comdat1) 
        wdetail.comdat     = trim(n_comdat1)            
        wdetail.expdat     = trim(n_expdat1)            
        wdetail.benname    = trim(n_benname) 
        /*wdetail.prmtxt      = trim(n_textacc)*/ /* A56-0151 */
        wdetail.pass       = "y"
        /*wdetail.vehuse   = IF SUBSTR(n_class70,2,1) = "2" THEN "2" ELSE "1" */  /*add  A56-0045 */      
        wdetail.vehuse     =  trim(nf_vehuse70)                /*add  A56-0045 */   
        wdetail.cpol       =  TRIM(n_cpol)      /*-- A59-0013 --*/
        wdetail.insnamtyp   = TRIM(nv_insnamtyp)   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.firstName   = trim(nv_firstName)   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.lastName    = trim(nv_lastName)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.postcd      = trim(nv_postcd)      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.codeocc     = nv_codeocc           /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.codeaddr1   = nv_codeaddr1         /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.codeaddr2   = nv_codeaddr2         /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.codeaddr3   = nv_codeaddr3         /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.br_insured  = "00000"              /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.campaign_ov = nv_campaign_ov.      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        /*----test---*/
        ASSIGN
            wdetail.occup      = np_occupn 
            wdetail.prom       = nv_prom
            wdetail.mkval      = nv_price
            wdetail.tel        = nv_ftel  
            wdetail.fdri1     = nv_fdri1   
            wdetail.fdri2     = nv_fdri2   
            wdetail.fddo1     = nv_fddo1   
            wdetail.fddo2     = nv_fddo2   .



        ASSIGN
            wdetail.fddo1   = trim(wdetail.fddo1) 
            wdetail.fddo2   = trim(wdetail.fddo2) 
            wdetail.fddo1   = TRIM(wdetail.fddo1 + FILL(" ",150 - LENGTH(wdetail.fddo1)) + nv_driid1)
            wdetail.fddo2   = trim(wdetail.fddo2 + FILL(" ",150 - LENGTH(wdetail.fddo2)) + nv_driid2).




         /*---test---*/
        nv_chkint = 0.
        nv_chkint = INT(SUBSTR(wdetail.fddo1,7,4)) NO-ERROR.
        IF nv_chkint < 2500 THEN do:
            nv_chkint = nv_chkint + 543.
            SUBSTR(wdetail.fddo1,7,4) = STRING(nv_chkint,"9999").
        END.
        nv_chkint = 0.
        nv_chkint = INT(SUBSTR(wdetail.fddo2,7,4)) NO-ERROR.
        IF nv_chkint < 2500 THEN do:
            nv_chkint = nv_chkint + 543.
            SUBSTR(wdetail.fddo2,7,4) = STRING(nv_chkint,"9999").
        END.
        /*---test---*/



        IF TRIM(nv_fdob) <> "" THEN wdetail.dobexp = "DOB" + TRIM(nv_fdob) + "|" .
        IF trim(nv_fexp) <> "" THEN wdetail.dobexp = wdetail.dobexp  + "EXP" + trim(nv_fexp).

                /*--
        ASSIGN
             wdetail.name2       = TRIM(wdetail.name2).


        IF wdetail.name2 <> "" THEN wdetail.name2 = "(" + wdetail.name2 + ")".
        IF LENGTH(wdetail.insnam + " " + wdetail.name2) < 50 THEN DO:
            ASSIGN
                wdetail.insnam2 = wdetail.insnam
                wdetail.insnam  = wdetail.insnam + " " + wdetail.name2
                wdetail.name2   = "".

            
        END.
        
        
        IF nv_vatname70 = "แถม" THEN DO:                  
            ASSIGN
                wdetail.vatcode     = trim(fi_vatcod). 
            IF wdetail.name2 = "" THEN wdetail.name2 = "และ/หรือ " + nv_vatdes.
            ELSE wdetail.name3 = "และ/หรือ " + nv_vatdes.
        END.
        ELSE IF nv_vatname70 <> "" THEN DO:
            FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                       sicsyac.xmm600.acno = nv_vatname70  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm600 THEN DO:
                ASSIGN
                    wdetail.vatcode     = sicsyac.xmm600.acno.
                IF wdetail.name2 = "" THEN wdetail.name2 = "และ/หรือ "  + xmm600.ntitle + " " + xmm600.NAME.
                ELSE wdetail.name3 = "และ/หรือ " +  xmm600.ntitle + " " + xmm600.NAME.
            END.


        END.

--*/


        /*----test---*/


    /* Add A56-0151 */
        /*--
    IF   ra_f6text = 2  THEN DO:   /*  ตามกรมธรรม์ หลัก ...*/
        IF  fi_policymas <> ""  THEN DO:
            FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 
                WHERE sicuw.uwm301.policy =  trim(fi_policymas)  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                CREATE wacctext.
                ASSIGN 
                    /*wacctext.n_policytxt = trim(sicuw.uwm301.policy) */         /*A57-0426*/
                    wacctext.n_policytxt = trim(n_policy70)                       /*A57-0426*/
                    wacctext.n_textacc   = SUBSTRING(sicuw.uwm301.prmtxt,1,60)    /*1*/ 
                    wacctext.n_textacc1  = SUBSTRING(sicuw.uwm301.prmtxt,61,60)   /*2*/   
                    wacctext.n_textacc2  = SUBSTRING(sicuw.uwm301.prmtxt,121,60)  /*3*/   
                    wacctext.n_textacc3  = SUBSTRING(sicuw.uwm301.prmtxt,181,60)  /*4*/   
                    wacctext.n_textacc4  = SUBSTRING(sicuw.uwm301.prmtxt,241,60)  /*5*/   
                    wacctext.n_textacc5  = SUBSTRING(sicuw.uwm301.prmtxt,301,60)  /*6*/   
                    wacctext.n_textacc6  = SUBSTRING(sicuw.uwm301.prmtxt,361,60)  /*7*/  
                    wacctext.n_textacc7  = SUBSTRING(sicuw.uwm301.prmtxt,421,60)  /*8*/   
                    wacctext.n_textacc8  = SUBSTRING(sicuw.uwm301.prmtxt,481,60)  /*9*/  
                    wacctext.n_textacc9  = SUBSTRING(sicuw.uwm301.prmtxt,541,60). /*10*/ 
            END.
        END.
    END.            /* end... A56-0151      */
    ELSE DO: --*/
        CREATE wacctext.
        ASSIGN          /*  by file F6 Accessory ...*/            
            wacctext.n_policytxt = trim(n_policy70) 
            wacctext.n_textacc   = trim(n_textacc)      
            wacctext.n_textacc1  = trim(n_textacc1)      
            wacctext.n_textacc2  = trim(n_textacc2)     
            wacctext.n_textacc3  = trim(n_textacc3)     
            wacctext.n_textacc4  = trim(n_textacc4)     
            wacctext.n_textacc5  = trim(n_textacc5)     
            wacctext.n_textacc6  = trim(n_textacc6)     
            wacctext.n_textacc7  = trim(n_textacc7)     
            wacctext.n_textacc8  = trim(n_textacc8)      
            wacctext.n_textacc9  = trim(n_textacc9) .
    /*END.---*/
    IF  (n_textf5 <> "") OR (n_textf52 <> "") OR (n_textf53 <> "" ) THEN DO:
        CREATE wacctext15.
        ASSIGN 
            wacctext15.n_policytxt15    = trim(n_policy70)     
            wacctext15.n_textacc1       = trim(n_textf5)  
            wacctext15.n_textacc2       = trim(n_textf52) 
            wacctext15.n_textacc3       = trim(n_textf53). 
    END.


    IF  (n_textf7 <> "")  OR (n_textf72 <> "") OR (n_textf73 <> "" ) OR
        (n_textf74 <> "") OR (n_textf75 <> "") OR (n_textf76 <> "" ) OR (n_textf77 <> "" ) OR 
        (n_textf78 <> "" ) THEN DO:
        CREATE wacctext17.
        ASSIGN 
            wacctext17.n_policytxt17 = trim(n_policy70)     
            wacctext17.n_textacc1    = trim(n_textf7)  
            wacctext17.n_textacc2    = trim(n_textf72) 
            wacctext17.n_textacc3    = trim(n_textf73)
            wacctext17.n_textacc4    = trim(n_textf74)
            wacctext17.n_textacc5    = trim(n_textf75)
            wacctext17.n_textacc6    = trim(n_textf76)
            wacctext17.n_textacc7    = trim(n_textf77)
            wacctext17.n_textacc8    = trim(n_textf78)
            . 
    END.


    /*--
   MESSAGE


        "number     "  wdetail.number     skip
        "policy     "  wdetail.policy     skip
        "covcod     "  wdetail.covcod     skip
        "producer   "  wdetail.producer   skip
        "agent      "  wdetail.agent      skip
        "inserf     "  wdetail.inserf     skip
        "vatcode    "  wdetail.vatcode    skip
        "textf7     "  wdetail.textf7     skip
        "textf5     "  wdetail.textf5     skip
        "commission "  wdetail.commission skip
        "class      "  wdetail.class      skip
        "uom1_v     "  wdetail.uom1_v     skip
        "uom2_v     "  wdetail.uom2_v     skip
        "uom5_v     "  wdetail.uom5_v     skip
        "si         "  wdetail.si         skip
        "fi         "  wdetail.fi         skip
        "nv_41      "  wdetail.nv_41      skip
        "nv_412     "  wdetail.nv_412     skip
        "nv_42      "  wdetail.nv_42      skip
        "nv_43      "  wdetail.nv_43      skip
        "base       "  wdetail.base       skip
        "vehreg     "  wdetail.vehreg     skip
        "brand      "  wdetail.brand      skip
        "model      "  wdetail.model      skip
        "chassis    "  wdetail.chassis    skip
        "engno      "  wdetail.engno      skip
        "caryear    "  wdetail.caryear    skip
        "comdat     "  wdetail.comdat     skip
        "expdat     "  wdetail.expdat     skip
        "n_rencnt   "  wdetail.n_rencnt   skip
        "n_endcnt   "  wdetail.n_endcnt   skip
        "n_branch   "  wdetail.n_branch   skip
        "poltyp     "  wdetail.poltyp     skip
        "tiname     "  wdetail.tiname     skip
        "insnam     "  wdetail.insnam     skip
        "name2      "  wdetail.name2      skip
        "name3      "  wdetail.name3      skip
        "occup      "  wdetail.occup      skip
        "n_addr1    "  wdetail.n_addr1    skip
        "n_addr2    "  wdetail.n_addr2    skip
        "n_addr3    "  wdetail.n_addr3    skip
        "n_addr4    "  wdetail.n_addr4    skip
        "firstdat   "  wdetail.firstdat   skip
        "trandat    "  wdetail.trandat    skip
        "garage     "  wdetail.garage     skip
        "tariff     "  wdetail.tariff     skip
        "redbook    "  wdetail.redbook    skip
        "body       "  wdetail.body       skip
        "engcc      "  wdetail.engcc      skip
        "Tonn       "  wdetail.Tonn       skip
        "seat       "  wdetail.seat       skip
        "cargrp     "  wdetail.cargrp     skip
        "vehuse     "  wdetail.vehuse     skip
        "benname    "  wdetail.benname    skip
        "prmtxt     "  wdetail.prmtxt     skip
        "seat41     "  wdetail.seat41     skip
        "ncb        "  wdetail.ncb        skip
        "fleet      "  wdetail.fleet      skip
        "dspc       "  wdetail.dspc       skip
        "stk        "  wdetail.stk        skip
        "compul     "  wdetail.compul     skip
        "comment    "  wdetail.comment    skip
        "pass       "  wdetail.pass       skip
        "WARNING    "  wdetail.WARNING    skip
        "OK_GEN     "  wdetail.OK_GEN     skip
        "premt      "  wdetail.premt      skip
        "comp_prm   "  wdetail.comp_prm   skip
        "cndat      "  wdetail.cndat      skip
        "prepol     "  wdetail.prepol     skip
        "prem_r     "  wdetail.prem_r     skip
        "prem_nap   "  wdetail.prem_nap   skip
        "comper     "  wdetail.comper     skip
        "comacc     "  wdetail.comacc     skip
        "enttim     "  wdetail.enttim     skip
        "trantim    "  wdetail.trantim    skip
        "n_IMPORT   "  wdetail.n_IMPORT   skip
        "n_EXPORT   "  wdetail.n_EXPORT   skip
        "cr_2       "  wdetail.cr_2       skip
        "docno      "  wdetail.docno      skip
        "drivnam    "  wdetail.drivnam    skip
        "cancel     "  wdetail.cancel     skip
        "cpol       "  wdetail.cpol       skip
        "accdat     "  wdetail.accdat     skip
        "ICNO       "  wdetail.ICNO       skip
        "dod0       "  wdetail.dod0       skip
        "dod1       "  wdetail.dod1       skip
        "dod2       "  wdetail.dod2       skip
        "stf_per    "  wdetail.stf_per    skip
        "cl_per     "  wdetail.cl_per     skip
        "tel        "  wdetail.tel        skip
        "dobexp     "  wdetail.dobexp     skip
        "fdri1      "  wdetail.fdri1      skip
        "fdri2      "  wdetail.fdri2      skip
        "fddo1      "  wdetail.fddo1      skip
        "fddo2      "  wdetail.fddo2      skip
        "finint     "  wdetail.finint     skip
        "mkval      "  wdetail.mkval      SKIP VIEW-AS ALERT-BOX.---*/



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
FIND FIRST wdetail WHERE wdetail.policy = trim(n_policy72) NO-ERROR NO-WAIT.
    IF NOT AVAIL wdetail THEN DO:
        CREATE wdetail.
        ASSIGN 
            wdetail.number      = trim(n_idno)          
            wdetail.policy      = trim(n_policy72)  
            wdetail.prepol      = TRIM(np_prepol72)    /*add  A56-0362 policy renew .72..*/
            wdetail.cr_2        = trim(n_policy70)       
            wdetail.n_branch    = trim(n_branch)  
            wdetail.inserf      = trim(np_insref)  
            wdetail.icno        = TRIM(np_icno)
            wdetail.tiname      = trim(np_title)                                     
            wdetail.insnam      = trim(np_name1) 
            wdetail.name2       = TRIM(nv_fname2)
            wdetail.name3       = ""
            wdetail.n_addr1     = trim(np_addr1)                                      
            wdetail.n_addr2     = trim(np_addr2)                                     
            wdetail.n_addr3     = TRIM(np_addr3)                                     
            wdetail.n_addr4     = trim(np_addr4)
            /*wdetail.poltyp      = "V72"*/                                  /*A58-0206*/
            wdetail.poltyp     = IF np_type02 = "" THEN "V72" ELSE np_type02 /*A58-0206*/
            wdetail.covcod      = "T"            
            wdetail.textf7      = trim(n_textf7)
            wdetail.textf5      = trim(n_textf5)
            wdetail.commission  = trim(n_com72)             
            wdetail.class       = caps(trim(n_class72))  
            /*wdetail.premt       = trim(n_napcom) */
            wdetail.seat        = TRIM(n_seat1)
            wdetail.engcc       = trim(n_Engine)         /*A57-0195*/ 
            wdetail.Tonn        = IF n_Tonnage = "" THEN 0 ELSE deci(trim(n_Tonnage))   /*A57-0195*/  
            wdetail.body        = TRIM(n_body)         /*A57-0426 Kridtiya i. 19/11/2014 */
            wdetail.benname     = TRIM(n_bennams)        /*A57-0195*/
            wdetail.uom1_v      = trim(n_uom1_v)              
            wdetail.uom2_v      = trim(n_uom2_v)        
            wdetail.uom5_v      = trim(n_uom5_v)        
            wdetail.si          = trim(n_siins)            
            wdetail.fi          = trim(n_fi)                           
            wdetail.nv_41       = trim(n_nv_41)                        
            wdetail.nv_42       = trim(n_nv_42)                                 
            wdetail.nv_43       = trim(n_nv_43)                                 
            wdetail.base        = trim(n_base)                
            wdetail.vehreg      = trim(n_vehreg)  
            wdetail.redbook     = TRIM(nn_redbook)
            wdetail.brand       = trim(n_brand1)               
            wdetail.model       = trim(n_model1)              
            wdetail.chassis     = trim(n_chassis)           
            wdetail.engno       = trim(n_engno)             
            wdetail.caryear     = trim(n_caryear)
            wdetail.firstdat    = trim(n_comdat72) 
            wdetail.comdat      = trim(n_comdat72) 
            wdetail.firstdat    = trim(n_comdat72) 
            wdetail.expdat      = trim(n_expdat72)            
            wdetail.benname     = trim(n_benname) 
            wdetail.prmtxt      = ""
            wdetail.pass        = "y"
            wdetail.vehuse      =  trim(nf_vehuse72)   /*add  A56-0045 */  
            wdetail.cpol        =  TRIM(n_cpol)        /*---A59-0013 --*/ 
            wdetail.insnamtyp   = TRIM(nv_insnamtyp)   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
            wdetail.firstName   = trim(nv_firstName)   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
            wdetail.lastName    = trim(nv_lastName)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
            wdetail.postcd      = trim(nv_postcd)      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
            wdetail.codeocc     = nv_codeocc           /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
            wdetail.codeaddr1   = nv_codeaddr1         /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
            wdetail.codeaddr2   = nv_codeaddr2         /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
            wdetail.codeaddr3   = nv_codeaddr3         /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
            wdetail.br_insured  = "00000"              /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
            wdetail.campaign_ov = nv_campaign_ov.      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
            

        /*----test---*/
        ASSIGN
            wdetail.occup      = np_occupn 
            wdetail.prem_nap   = TRIM(n_napcom)
            wdetail.tel        = nv_ftel  
            wdetail.stk        = n_sticker.

/*--
        IF TRIM(nv_fdob) <> "" THEN wdetail.dobexp = "DOB" + TRIM(nv_fdob) + "|" .
        IF trim(nv_fexp) <> "" THEN wdetail.dobexp = wdetail.dobexp  + "EXP" + trim(nv_fexp).
           
        ASSIGN
             wdetail.name2       = TRIM(wdetail.name2).

        IF wdetail.name2 <> "" THEN wdetail.name2 = "(" + wdetail.name2 + ")".
        IF LENGTH(wdetail.insnam + " " + wdetail.name2) < 50 THEN DO:
            ASSIGN
                wdetail.insnam2 = wdetail.insnam
                wdetail.insnam  = wdetail.insnam + " " + wdetail.name2
                wdetail.name2   = "".

            
        END.
        IF nv_vatname72 = "แถม" THEN DO:                  
            ASSIGN
                wdetail.vatcode     = trim(fi_vatcod) .
            IF wdetail.name2 = "" THEN wdetail.name2 = "และ/หรือ " + nv_vatdes.
            ELSE wdetail.name3 = "และ/หรือ " + nv_vatdes.
        END.
        ELSE IF nv_vatname72 <> "" THEN DO:
            FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                       sicsyac.xmm600.acno = nv_vatname72  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm600 THEN DO:
                ASSIGN
                    wdetail.vatcode     = sicsyac.xmm600.acno.
                IF wdetail.name2 = "" THEN wdetail.name2 = "และ/หรือ "  + xmm600.ntitle + " " + xmm600.NAME.
                ELSE wdetail.name3 = "และ/หรือ " +  xmm600.ntitle + " " + xmm600.NAME.
            END.


        END.
*/
        /*----test---*/



    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_driver c-Win 
PROCEDURE proc_driver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_chk AS CHAR INIT "".
DEF VAR nv_int AS INT  INIT  0. 
IF wdetail.fdri1 <> "" THEN DO:
    nv_chk = sic_bran.uwm100.policy + STRING(sic_bran.uwm301.rencnt,"99")  
             + STRING(sic_bran.uwm301.endcnt,"999") 
             + STRING(sic_bran.uwm301.riskno,"999") 
             + STRING(sic_bran.uwm301.itemno,"999") .

    FIND FIRST brstat.mailtxt_fil WHERE
        brstat.mailtxt_fil.policy         = nv_chk AND
        brstat.mailtxt_fil.lnumber        = 1      and
        brstat.mailtxt_fil.bchyr          = sic_bran.uwm301.bchyr AND
        brstat.mailtxt_fil.bchno          = sic_bran.uwm301.bchno AND
        brstat.mailtxt_fil.bchcnt         = sic_bran.uwm301.bchcnt NO-ERROR NO-WAIT.
    IF NOT AVAIL brstat.mailtxt THEN DO:
        CREATE brstat.mailtxt_fil.
        ASSIGN
            brstat.mailtxt_fil.policy         = nv_chk
            brstat.mailtxt_fil.lnumber        = 1
            brstat.mailtxt_fil.ltext          = wdetail.fdri1 
            brstat.mailtxt_fil.ltext          = brstat.mailtxt_fil.ltext + FILL(" ",50 - LENGTH(brstat.mailtxt_fil.ltext))
            brstat.mailtxt_fil.bchyr          = sic_bran.uwm301.bchyr 
            brstat.mailtxt_fil.bchno          = sic_bran.uwm301.bchno 
            brstat.mailtxt_fil.bchcnt         = sic_bran.uwm301.bchcnt
            
            .
        IF INDEX(brstat.mailtxt_fil.ltext,"นาง")  = 1 OR
           INDEX(brstat.mailtxt_fil.ltext,"Mrs")  = 1 OR
           INDEX(brstat.mailtxt_fil.ltext,"Miss") = 1 THEN brstat.mailtxt_fil.ltext          = brstat.mailtxt_fil.ltext + "FEMALE".
        ELSE brstat.mailtxt_fil.ltext          = brstat.mailtxt_fil.ltext + "MALE".
        

    
        brstat.mailtxt_fil.ltext2 = TRIM(wdetail.fddo1) + "  " +  TRIM(STRING(nv_drivage1,"99")) .
        brstat.mailtxt_fil.ltext2 = TRIM(brstat.mailtxt_fil.ltext2) .
        brstat.mailtxt_fil.ltext2 = brstat.mailtxt_fil.ltext2 + FILL(" ",15  - LENGTH(brstat.mailtxt_fil.ltext2)) + "-".
    END.

    IF wdetail.fdri2 <> "" THEN DO:
        FIND FIRST brstat.mailtxt_fil WHERE
            brstat.mailtxt_fil.policy         = nv_chk AND
            brstat.mailtxt_fil.lnumber        = 2     and
            brstat.mailtxt_fil.bchyr          = sic_bran.uwm301.bchyr AND
            brstat.mailtxt_fil.bchno          = sic_bran.uwm301.bchno AND
            brstat.mailtxt_fil.bchcnt         = sic_bran.uwm301.bchcnt NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.mailtxt THEN DO: CREATE brstat.mailtxt_fil.
        
            ASSIGN
                brstat.mailtxt_fil.policy         = nv_chk
                brstat.mailtxt_fil.lnumber        = 2
                brstat.mailtxt_fil.ltext          = wdetail.fdri2.

            ASSIGN
                brstat.mailtxt_fil.ltext          = brstat.mailtxt_fil.ltext + FILL(" ",50 - LENGTH(brstat.mailtxt_fil.ltext))
                brstat.mailtxt_fil.bchyr          = sic_bran.uwm301.bchyr 
                brstat.mailtxt_fil.bchno          = sic_bran.uwm301.bchno 
                brstat.mailtxt_fil.bchcnt         = sic_bran.uwm301.bchcnt.
            
            IF INDEX(brstat.mailtxt_fil.ltext,"นาง")  = 1 OR
               INDEX(brstat.mailtxt_fil.ltext,"Mrs")  = 1 OR
               INDEX(brstat.mailtxt_fil.ltext,"Miss") = 1 THEN brstat.mailtxt_fil.ltext          = brstat.mailtxt_fil.ltext + "FEMALE".
            ELSE brstat.mailtxt_fil.ltext          = brstat.mailtxt_fil.ltext + "MALE".
            
            brstat.mailtxt_fil.ltext2 = TRIM(wdetail.fddo2) + "  " +  TRIM(STRING(nv_drivage2,"99")).
            brstat.mailtxt_fil.ltext2 = TRIM(brstat.mailtxt_fil.ltext2) .
            brstat.mailtxt_fil.ltext2 = brstat.mailtxt_fil.ltext2 + FILL(" ",15  - LENGTH(brstat.mailtxt_fil.ltext2)) + "-".

        END.

    END.
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
    n_idno          = ""     
    n_policy70      = ""
    n_policy72      = ""
    n_branch        = ""  
    n_cover         = ""  
    n_textf5        = ""  
    n_textf52       = "" 
    n_textf53       = "" 
    n_textf7        = "" 
    n_textf72       = "" 
    n_textf73       = "" 
    n_com70         = ""  
    n_com72         = ""  
    n_class70       = ""  
    n_class72       = ""  
    n_seat1         = "" 
    n_uom1_v        = ""  
    n_uom2_v        = ""  
    n_uom5_v        = ""  
    n_siins         = ""  
    n_fi            = ""  
    n_nv_41         = ""  
    n_nv_42         = ""  
    n_nv_43         = "" 
    n_ncb           = ""    
    n_feet          = ""    
    n_dspc          = ""    
    n_base          = ""  
    n_nap           = ""
    n_model1        = ""  
    n_comdat1       = ""  
    n_benname       = ""
    np_prepol       = ""
    n_garage        = ""
    np_prepol72     = "" 
    np_insref       = ""  
    np_title        = ""  
    np_name1        = ""  
    np_addr1        = ""  
    np_addr2        = ""  
    np_addr3        = ""  
    np_addr4        = "" 
    np_icno         = "" 
    n_Tonnage       = ""    
    n_bennams       = ""
    nn_redbook      = ""
    n_body          = ""
    n_seat_41       = ""
    n_nv_412        = ""    
    n_comdat72      = ""  
    n_expdat72      = ""  
    n_textacc       = "" 
    n_textacc1      = ""  
    n_textacc2      = ""  
    n_textacc3      = ""  
    n_textacc4      = ""  
    n_textacc5      = ""  
    n_textacc6      = ""  
    n_textacc7      = ""  
    n_textacc8      = ""  
    n_textacc9      = ""
    np_type01       = ""    /*A58-0206 */
    np_type02       = ""    /*A58-0206 */
    nn_premcom      = ""    /*Add 23/07/2015 */
    n_cpol          = ""    /* ranu */
    np_occupn       =  ""
    n_branch        = fi_branch
    nv_camp         =  ""
    nv_fcomp        =  ""      
    nv_fdate        =  ""      
    nv_fcont        =  ""      
    nv_fname        =  ""      
    nv_faddr        =  ""      
    nv_ftel         =  ""      
    nv_fdob         =  ""      
    nv_fexp         =  ""      
    n_expdat1       =  ""      
    n_brand1        =  ""      
    n_caryear       =  ""      
    n_Engine        =  ""  
    nf_vehuse70     =  ""
    n_vehreg        =  ""      
    n_chassis       =  ""      
    n_engno         =  ""      
    nv_fdri1        =  ""      
    nv_fdri2        =  ""      
    nv_fddo1        =  ""      
    nv_fddo2        =  ""      
    nv_price        =  ""      
    n_naptx         =  ""      
    n_napcom        =  ""      
    n_napcomtx      =  ""      
    /*nv_total        =  ""*/
    n_sticker       =  ""      
    nv_vatname70    =  ""      
    nv_vatname72    =  ""      
    nv_acc          =  ""      
    nv_f51          =  ""      
    nv_f52          =  ""
    nv_addrx        =  ""
    nv_addr         =  ""
    n_textf78       = ""
    nv_driid1       = ""
    nv_driid2       = ""
    n_textf74       = ""
    n_textf75       = ""
    n_textf76       = ""
    n_textf77       = "" 
    nv_fname2       = "" 
    nv_campaign_ov  = ""
    nv_codeocc      = ""
    nv_codeaddr1    = ""
    nv_codeaddr2    = ""
    nv_codeaddr3    = ""
    nv_insnamtyp    = ""
    nv_firstName    = ""
    nv_lastName     = "" 
    nv_postcd       = "".




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
IF wdetail.inserf = "" THEN DO:  /*Add Kridtiya i. A59-185 */
  FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME     = TRIM(wdetail.insnam2)   AND 
    sicsyac.xmm600.homebr   = trim(wdetail.n_branch) AND 
    sicsyac.xmm600.clicod   = "IN"                   AND
    sicsyac.xmm600.addr1    = wdetail.n_addr1        AND
    sicsyac.xmm600.addr2    = wdetail.n_addr2        AND
    sicsyac.xmm600.addr3    = wdetail.n_addr3        AND
    sicsyac.xmm600.addr4    = wdetail.n_addr4        NO-ERROR NO-WAIT.  
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
      ELSE DO:  /* ---- Check ด้วย name ---- */
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
      END.  /**/
    END.
    n_insref = nv_insref.
  END.
  ELSE DO:
      IF sicsyac.xmm600.acno <> "" THEN DO:   /* กรณีพบ */
          ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            n_insref                = caps(trim(nv_insref)) 
            nv_transfer             = NO 
            wdetail.tiname          = trim(sicsyac.xmm600.ntitle)
            wdetail.insnam          = trim(sicsyac.xmm600.name)
            wdetail.icno            = IF  TRIM(sicsyac.xmm600.icno) <> "" THEN   TRIM(sicsyac.xmm600.icno) ELSE wdetail.icno 
            wdetail.n_addr1         = IF trim(sicsyac.xmm600.addr1) <> "" THEN  trim(sicsyac.xmm600.addr1) ELSE  trim(wdetail.n_addr1)  
            wdetail.n_addr2         = IF trim(sicsyac.xmm600.addr2) <> "" THEN  trim(sicsyac.xmm600.addr2) ELSE  trim(wdetail.n_addr2)   
            wdetail.n_addr3         = IF trim(sicsyac.xmm600.addr3) <> "" THEN  trim(sicsyac.xmm600.addr3) ELSE  trim(wdetail.n_addr3)   
            wdetail.n_addr4         = IF trim(sicsyac.xmm600.addr4) <> "" THEN  trim(sicsyac.xmm600.addr4) ELSE  trim(wdetail.n_addr4) 
            sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)    /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname    = ""                      /*First Name*/
            sicsyac.xmm600.name     = TRIM(wdetail.insnam)    /*Name Line 1*/
            sicsyac.xmm600.abname   = TRIM(wdetail.insnam)    /*Abbreviated Name*/
            sicsyac.xmm600.icno     = IF TRIM(sicsyac.xmm600.icno) <> "" THEN TRIM(sicsyac.xmm600.icno) ELSE TRIM(wdetail.ICNO)      /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1    = IF trim(sicsyac.xmm600.addr1) = ""  THEN  trim(wdetail.n_addr1) ELSE trim(sicsyac.xmm600.addr1) /*Address line 1*/
            sicsyac.xmm600.addr2    = IF trim(sicsyac.xmm600.addr2) = ""  THEN  trim(wdetail.n_addr2) ELSE trim(sicsyac.xmm600.addr2) /*Address line 2*/
            sicsyac.xmm600.addr3    = IF trim(sicsyac.xmm600.addr3) = ""  THEN  trim(wdetail.n_addr3) ELSE trim(sicsyac.xmm600.addr3) /*Address line 3*/
            sicsyac.xmm600.addr4    = IF trim(sicsyac.xmm600.addr4) = ""  THEN  trim(wdetail.n_addr4) ELSE trim(sicsyac.xmm600.addr4) /*Address line 4*/
            sicsyac.xmm600.homebr   = trim(wdetail.n_branch)    /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                   
            sicsyac.xmm600.chgpol   = YES                     /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                   /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS") /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            sicsyac.xmm600.dval20   = wdetail.dobexp
            sicsyac.xmm600.phone    = wdetail.tel
            sicsyac.xmm600.anlyc5   =  ""          
            sicsyac.xmm600.dtyp20   =  ""  .
            
            IF wdetail.insnam2 <> "" THEN 
              ASSIGN 
              sicsyac.xmm600.NAME     = TRIM(wdetail.insnam2)
              sicsyac.xmm600.abname   = trim(wdetail.insnam2)  .
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
      wdetail.n_addr1         = IF trim(sicsyac.xmm600.addr1) <> "" THEN  trim(sicsyac.xmm600.addr1) ELSE  trim(wdetail.n_addr1)  
      wdetail.n_addr2         = IF trim(sicsyac.xmm600.addr2) <> "" THEN  trim(sicsyac.xmm600.addr2) ELSE  trim(wdetail.n_addr2)   
      wdetail.n_addr3         = IF trim(sicsyac.xmm600.addr3) <> "" THEN  trim(sicsyac.xmm600.addr3) ELSE  trim(wdetail.n_addr3)   
      wdetail.n_addr4         = IF trim(sicsyac.xmm600.addr4) <> "" THEN  trim(sicsyac.xmm600.addr4) ELSE  trim(wdetail.n_addr4)
      sicsyac.xmm600.icno     = IF TRIM(sicsyac.xmm600.icno) <> "" THEN TRIM(sicsyac.xmm600.icno) ELSE TRIM(wdetail.ICNO)        /*IC No.*/     /*--Crate by Amparat C. A51-0071--*/
      sicsyac.xmm600.addr1    = IF trim(sicsyac.xmm600.addr1) = ""  THEN  trim(wdetail.n_addr1) ELSE trim(sicsyac.xmm600.addr1)  /*Address line 1*/
      sicsyac.xmm600.addr2    = IF trim(sicsyac.xmm600.addr2) = ""  THEN  trim(wdetail.n_addr2) ELSE trim(sicsyac.xmm600.addr2)  /*Address line 2*/
      sicsyac.xmm600.addr3    = IF trim(sicsyac.xmm600.addr3) = ""  THEN  trim(wdetail.n_addr3) ELSE trim(sicsyac.xmm600.addr3)  /*Address line 3*/
      sicsyac.xmm600.addr4    = IF trim(sicsyac.xmm600.addr4) = ""  THEN  trim(wdetail.n_addr4) ELSE trim(sicsyac.xmm600.addr4)  /*Address line 4*/
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
      sicsyac.xmm600.dval20   =  ""    
      sicsyac.xmm600.phone    = wdetail.tel
      sicsyac.xmm600.dval20   = wdetail.dobexp  .
      
      IF wdetail.insnam2 <> "" THEN 
        ASSIGN sicsyac.xmm600.NAME     = TRIM(wdetail.insnam2)
          sicsyac.xmm600.abname   = trim(wdetail.insnam2)  .
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
      ASSIGN sicsyac.xtm600.acno    = nv_insref           /*Account no.*/
          sicsyac.xtm600.name    = trim(wdetail.insnam)   /*Name of Insured Line 1*/
          sicsyac.xtm600.abname  = trim(wdetail.insnam)   /*Abbreviated Name*/
          sicsyac.xtm600.addr1   = trim(wdetail.n_addr1)  /*address line 1*/
          sicsyac.xtm600.addr2   = trim(wdetail.n_addr2)  /*address line 2*/
          sicsyac.xtm600.addr3   = trim(wdetail.n_addr3)  /*address line 3*/
          sicsyac.xtm600.addr4   = trim(wdetail.n_addr4)  /*address line 4*/
          sicsyac.xtm600.name2   = ""                     /*Name of Insured Line 2*/ 
          sicsyac.xtm600.ntitle  = trim(wdetail.tiname)   /*Title*/
          sicsyac.xtm600.name3   = ""                     /*Name of Insured Line 3*/
          sicsyac.xtm600.fname   = "".                    /*First Name*/
          
      IF wdetail.insnam2 <> "" THEN 
        ASSIGN 
          sicsyac.xtm600.NAME     = TRIM(wdetail.insnam2)
          sicsyac.xtm600.abname   = trim(wdetail.insnam2)  .
    END.
  END.
  ASSIGN  wdetail.inserf = nv_insref .
  RELEASE sicsyac.xtm600.
  RELEASE sicsyac.xmm600.
  RELEASE sicsyac.xzm056.
END.   
RETURN.
/*--HIDE MESSAGE NO-PAUSE.*/
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
    sicsyac.xmm600.acno_typ  = trim(wdetail.insnamtyp)   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    sicsyac.xmm600.icno      = trim(wdetail.icno)       
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/ .  
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN
    ASSIGN 
    sicsyac.xtm600.postcd    = trim(wdetail.postcd)          
    sicsyac.xtm600.firstname = trim(wdetail.firstName)       
    sicsyac.xtm600.lastname  = trim(wdetail.lastName)    .   
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xtm600.
/*Add by Kridtiya i. A63-0472*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam_bk c-Win 
PROCEDURE proc_insnam_bk :
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

IF wdetail.inserf = "" THEN DO:  /*Add Kridtiya i. A59-185 */

FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME     = TRIM(wdetail.insnam2)   AND 
    sicsyac.xmm600.homebr   = trim(wdetail.n_branch) AND 
    sicsyac.xmm600.clicod   = "IN"                   AND
    sicsyac.xmm600.addr1    = wdetail.n_addr1        AND
    sicsyac.xmm600.addr2    = wdetail.n_addr2        AND
    sicsyac.xmm600.addr3    = wdetail.n_addr3        AND
    sicsyac.xmm600.addr4    = wdetail.n_addr4        NO-ERROR NO-WAIT.  
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
        ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            n_insref                = caps(trim(nv_insref)) 
            nv_transfer             = NO 
            wdetail.tiname          = trim(sicsyac.xmm600.ntitle)
            wdetail.insnam          = trim(sicsyac.xmm600.name)
            wdetail.icno            = IF  TRIM(sicsyac.xmm600.icno) <> "" THEN   TRIM(sicsyac.xmm600.icno) ELSE wdetail.icno 
            /*--------- Comment & Create by : A59-0013 -----------*/
            /*wdetail.n_addr1         = trim(sicsyac.xmm600.addr1)    
            wdetail.n_addr2         = trim(sicsyac.xmm600.addr2)    
            wdetail.n_addr3         = trim(sicsyac.xmm600.addr3)
            wdetail.n_addr4         = trim(sicsyac.xmm600.addr4)*/
            wdetail.n_addr1         = IF trim(sicsyac.xmm600.addr1) <> "" THEN  trim(sicsyac.xmm600.addr1) ELSE  trim(wdetail.n_addr1)  
            wdetail.n_addr2         = IF trim(sicsyac.xmm600.addr2) <> "" THEN  trim(sicsyac.xmm600.addr2) ELSE  trim(wdetail.n_addr2)   
            wdetail.n_addr3         = IF trim(sicsyac.xmm600.addr3) <> "" THEN  trim(sicsyac.xmm600.addr3) ELSE  trim(wdetail.n_addr3)   
            wdetail.n_addr4         = IF trim(sicsyac.xmm600.addr4) <> "" THEN  trim(sicsyac.xmm600.addr4) ELSE  trim(wdetail.n_addr4) 
            /*----------- end A59-0013 -------------*/
            sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)    /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname    = ""                      /*First Name*/
            sicsyac.xmm600.name     = TRIM(wdetail.insnam)    /*Name Line 1*/
            sicsyac.xmm600.abname   = TRIM(wdetail.insnam)    /*Abbreviated Name*/
            sicsyac.xmm600.icno     = IF TRIM(sicsyac.xmm600.icno) <> "" THEN TRIM(sicsyac.xmm600.icno) ELSE TRIM(wdetail.ICNO)      /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
             /*--------- Comment & Create by : A59-0013 -----------*/
            /*sicsyac.xmm600.addr1    = trim(wdetail.n_addr1)   /*Address line 1*/
            sicsyac.xmm600.addr2    = trim(wdetail.n_addr2)   /*Address line 2*/
            sicsyac.xmm600.addr3    = trim(wdetail.n_addr3)   /*Address line 3*/
            sicsyac.xmm600.addr4    = trim(wdetail.n_addr4)  */ 
            sicsyac.xmm600.addr1    = IF trim(sicsyac.xmm600.addr1) = ""  THEN  trim(wdetail.n_addr1) ELSE trim(sicsyac.xmm600.addr1) /*Address line 1*/
            sicsyac.xmm600.addr2    = IF trim(sicsyac.xmm600.addr2) = ""  THEN  trim(wdetail.n_addr2) ELSE trim(sicsyac.xmm600.addr2) /*Address line 2*/
            sicsyac.xmm600.addr3    = IF trim(sicsyac.xmm600.addr3) = ""  THEN  trim(wdetail.n_addr3) ELSE trim(sicsyac.xmm600.addr3) /*Address line 3*/
            sicsyac.xmm600.addr4    = IF trim(sicsyac.xmm600.addr4) = ""  THEN  trim(wdetail.n_addr4) ELSE trim(sicsyac.xmm600.addr4) /*Address line 4*/
            /*---------- end A59-0013 --------------*/ 
            sicsyac.xmm600.homebr   = trim(wdetail.n_branch)    /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                   
            sicsyac.xmm600.chgpol   = YES                     /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                   /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS") /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            sicsyac.xmm600.dval20   = wdetail.dobexp
            sicsyac.xmm600.phone    = wdetail.tel


            /*sicsyac.xmm600.dtyp20   = IF wdetail.birthdat = "" THEN "" ELSE "DOB"
            sicsyac.xmm600.dval20   = IF wdetail.birthdat = "" THEN ""
                                      ELSE substr(TRIM(wdetail.birthdat),1,6) +
                                      STRING(deci(substr(TRIM(wdetail.birthdat),7,4)) + 543 ) */     /*-- Add chutikarn A50-0072 --*/
            sicsyac.xmm600.anlyc5   =  ""          
            sicsyac.xmm600.dtyp20   =  "" 
            /*sicsyac.xmm600.dval20   =  "" */  . 
            IF wdetail.insnam2 <> "" THEN 
            ASSIGN 
                sicsyac.xmm600.NAME     = TRIM(wdetail.insnam2)
                sicsyac.xmm600.abname   = trim(wdetail.insnam2)  .
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
        /*-------- Comment & create by : A59-0013 ------*/
        /*wdetail.n_addr1         = trim(sicsyac.xmm600.addr1)     
        wdetail.n_addr2         = trim(sicsyac.xmm600.addr2)     
        wdetail.n_addr3         = trim(sicsyac.xmm600.addr3)     
        wdetail.n_addr4         = trim(sicsyac.xmm600.addr4) */  
        wdetail.n_addr1         = IF trim(sicsyac.xmm600.addr1) <> "" THEN  trim(sicsyac.xmm600.addr1) ELSE  trim(wdetail.n_addr1)  
        wdetail.n_addr2         = IF trim(sicsyac.xmm600.addr2) <> "" THEN  trim(sicsyac.xmm600.addr2) ELSE  trim(wdetail.n_addr2)   
        wdetail.n_addr3         = IF trim(sicsyac.xmm600.addr3) <> "" THEN  trim(sicsyac.xmm600.addr3) ELSE  trim(wdetail.n_addr3)   
        wdetail.n_addr4         = IF trim(sicsyac.xmm600.addr4) <> "" THEN  trim(sicsyac.xmm600.addr4) ELSE  trim(wdetail.n_addr4)
        /*----------------end A59-0013 ------------*/
        sicsyac.xmm600.icno     = IF TRIM(sicsyac.xmm600.icno) <> "" THEN TRIM(sicsyac.xmm600.icno) ELSE TRIM(wdetail.ICNO)        /*IC No.*/     /*--Crate by Amparat C. A51-0071--*/
        /*------- comment & Create by : A59-0013 --------*/
        /*sicsyac.xmm600.addr1    =  trim(wdetail.n_addr1)   /*Address line 1*/
        sicsyac.xmm600.addr2    =  trim(wdetail.n_addr2)    /*Address line 2*/
        sicsyac.xmm600.addr3    =  trim(wdetail.n_addr3)    /*Address line 3*/
        sicsyac.xmm600.addr4    =  -trim(wdetail.n_addr4)   /*Address line 4*/*/
        sicsyac.xmm600.addr1    = IF trim(sicsyac.xmm600.addr1) = ""  THEN  trim(wdetail.n_addr1) ELSE trim(sicsyac.xmm600.addr1)  /*Address line 1*/
        sicsyac.xmm600.addr2    = IF trim(sicsyac.xmm600.addr2) = ""  THEN  trim(wdetail.n_addr2) ELSE trim(sicsyac.xmm600.addr2)  /*Address line 2*/
        sicsyac.xmm600.addr3    = IF trim(sicsyac.xmm600.addr3) = ""  THEN  trim(wdetail.n_addr3) ELSE trim(sicsyac.xmm600.addr3)  /*Address line 3*/
        sicsyac.xmm600.addr4    = IF trim(sicsyac.xmm600.addr4) = ""  THEN  trim(wdetail.n_addr4) ELSE trim(sicsyac.xmm600.addr4)  /*Address line 4*/
        /*----------end A59-0013 ---------*/
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
        sicsyac.xmm600.dval20   =  ""    
        sicsyac.xmm600.phone    = wdetail.tel
        sicsyac.xmm600.dval20   = wdetail.dobexp.
        IF wdetail.insnam2 <> "" THEN 
            ASSIGN 
                sicsyac.xmm600.NAME     = TRIM(wdetail.insnam2)
                sicsyac.xmm600.abname   = trim(wdetail.insnam2)  .
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

        IF wdetail.insnam2 <> "" THEN 
            ASSIGN 
                sicsyac.xtm600.NAME     = TRIM(wdetail.insnam2)
                sicsyac.xtm600.abname   = trim(wdetail.insnam2)  .

    END.
END.
ASSIGN  wdetail.inserf = nv_insref .
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.

END.  /*Add Kridtiya i. A59-0185 */

RETURN.
/*--HIDE MESSAGE NO-PAUSE.*/

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
   /* MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
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
DEF VAR nv_names1    AS CHAR INIT "".
DEF VAR nv_names2    AS CHAR INIT "".
DEF VAR nv_names3    AS CHAR INIT "".
ASSIGN fi_process = "Create data to uwm100..." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
IF wdetail.policy <> "" THEN DO:
    IF  wdetail.poltyp = "V70" THEN ASSIGN wdetail.stk = "".  /*---test*/
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
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ( sicuw.uwm100.name1 <> "" ) OR ( sicuw.uwm100.comdat <> ? ) OR ( sicuw.uwm100.releas = YES ) THEN 
                ASSIGN wdetail.pass = "N"
                wdetail.comment     = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning     = "Program Running Policy No. ให้ชั่วคราว".
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
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy = wdetail.policy   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
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
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass = "N"
                wdetail.comment      = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning      = "Program Running Policy No. ให้ชั่วคราว".
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

ASSIGN
    nv_names1 = trim(wdetail.insnam)  
    nv_names2 = trim(wdetail.name2)   
    nv_names3 = trim(wdetail.name3)   .
/*IF TRIM(wdetail.inserf) = "" THEN */
RUN proc_insnam.
RUN proc_insnam2 .  /*Add by Kridtiya i. A63-0472*/

ASSIGN
    wdetail.insnam =  nv_names1  
    wdetail.name2  =  nv_names2  
    wdetail.name3  =  nv_names3  .


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
        sic_bran.uwm100.opnpol = ""
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
        sic_bran.uwm100.fstdat = dATE(wdetail.firstdat)         /*DATE(wdetail.comdat) ให้ firstdate*/
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
        sic_bran.uwm100.prog   = "wgwtlbu2"                     
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
        /*sic_bran.uwm100.cedpol = ""            -- A59-0013 --*/
        sic_bran.uwm100.cedpol = wdetail.cpol  /*-- A59-0013 --*/  
        sic_bran.uwm100.finint = wdetail.finint  /*---add*/
        sic_bran.uwm100.dealer = wdetail.financecd              /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.bs_cd  = caps(trim(wdetail.vatcode))
        /*sic_bran.uwm100.opnpol = "" .*/
        sic_bran.uwm100.opnpol     = wdetail.prom 
        sic_bran.uwm100.occup      = wdetail.occup
        sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)    /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)     /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.postcd     = trim(wdetail.postcd)       /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.icno       = trim(wdetail.icno)         /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)      /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)    /*Add by Kridtiya i. A63-0472*/
        /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*/   /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov).  /*Add by Kridtiya i. A63-0472*/


    IF wdetail.prepol <> " " THEN DO:
        IF wdetail.poltyp = "v72"  THEN 
            ASSIGN sic_bran.uwm100.prvpol  = ""
            sic_bran.uwm100.tranty  = "R".  
        ELSE 
            ASSIGN
                sic_bran.uwm100.prvpol  = caps(trim(wdetail.prepol))     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                sic_bran.uwm100.tranty  = "R".               /*Transaction Type (N/R/E/C/T)*/
    END.
    IF wdetail.pass = "Y" THEN sic_bran.uwm100.impflg  = YES.
    ELSE sic_bran.uwm100.impflg  = NO.
    IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN  sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
    IF wdetail.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
    ELSE  sic_bran.uwm100.polsta = "IF".
    IF fi_loaddat <> ? THEN sic_bran.uwm100.trndat = fi_loaddat.
    ELSE sic_bran.uwm100.trndat = TODAY.
    ASSIGN sic_bran.uwm100.issdat = sic_bran.uwm100.trndat
        nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                          (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                          (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                      ELSE (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1 .   
END.     /*transaction*//**/
IF wdetail.poltyp = "v70" THEN DO:
    RUN proc_uwd100_1.
    RUN proc_uwd102_1.

    /*--
    IF ra_f15text = 1 THEN  RUN proc_uwd100_1.   /*by file */
    ELSE RUN proc_uwd100.                        /*by master*/
    IF ra_f17text = 1 THEN  RUN proc_uwd102_1.
    ELSE RUN proc_uwd102.---*/
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
        /*MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .*/
        ASSIGN wdetail.comment = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว: " + wdetail.prepol 
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
        /*ASSIGN   
            wdetail.prepol   = sicuw.uwm100.policy
            n_rencnt         = sicuw.uwm100.rencnt  +  1
            n_endcnt         = 0   
            wdetail.n_rencnt = sicuw.uwm100.rencnt  +  1    
            wdetail.n_endcnt = 0   . */ 
    ELSE DO: 
        ASSIGN   
            wdetail.prepol   = sicuw.uwm100.policy
            n_rencnt         = sicuw.uwm100.rencnt  +  1
            n_endcnt         = 0   
            wdetail.n_rencnt = sicuw.uwm100.rencnt  +  1    
            wdetail.n_endcnt = 0   .                         
       /*RUN proc_assignrenew_pol.  */  /*ไม่รับค่าข้อมูลกรมธรรม์ เดิม */  
       RUN proc_assignrenew_pol. /*A59-0060*/
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
     /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. *//*Comment A62-0105*/   
     /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.  /*test system */ */
     /* CONNECT expiry -H 16.90.55.11 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/
      
      CLEAR FRAME nf00.
      HIDE FRAME nf00.

      RETURN. 
    
   END.

END.

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
    nv_chanolist   = trim(wdetail.chassis)
    nv_idnolist    = trim(wdetail.icno)  .

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
        ASSIGN 
            wdetail.comment = wdetail.comment + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
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

/*---
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
END.---*/
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
    nv_txt5  = ""  .
FIND LAST wacctext15 WHERE wacctext15.n_policytxt15 = wdetail.policy NO-LOCK NO-ERROR.
IF AVAIL wacctext15 THEN DO:
    ASSIGN 
        nv_txt3  =  wacctext15.n_textacc1  
        nv_txt4  =  wacctext15.n_textacc2   
        nv_txt5  =  wacctext15.n_textacc3   .
    DO WHILE nv_line1 <= 5:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
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
/*--IF trim(fi_policymas) <> "" THEN DO:
    
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
END.--*/
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
        IF nv_line1 = 3   THEN wuppertxt3.txt =   wacctext17.n_textacc1 .  
        IF nv_line1 = 4   THEN wuppertxt3.txt =   wacctext17.n_textacc2 .                                      
        IF nv_line1 = 5   THEN wuppertxt3.txt =   wacctext17.n_textacc3 .
        IF nv_line1 = 6   THEN wuppertxt3.txt =   wacctext17.n_textacc4 .     
        IF nv_line1 = 7   THEN wuppertxt3.txt =   wacctext17.n_textacc5 .     
        IF nv_line1 = 8   THEN wuppertxt3.txt =   wacctext17.n_textacc6 .     
        IF nv_line1 = 9   THEN wuppertxt3.txt =   wacctext17.n_textacc7 .
        IF nv_line1 = 10  THEN wuppertxt3.txt =   wacctext17.n_textacc8 .







        /*IF nv_line1 = 2  THEN wuppertxt3.txt =  wdetail.nmember .                                          
    IF nv_line1 = 3  THEN wuppertxt3.txt =  "สาขา : "  + SUBSTR(wdetail.nmember2,index(wdetail.nmember2,"-:") + 2,R-INDEX(wdetail.nmember2,":") - index(wdetail.nmember2,"-:") - 2 ) + 
                                            " ชื่อเจ้าหน้าที่ MKT: " + SUBSTR(wdetail.nmember2,r-index(wdetail.nmember2,":") + 1 ). 
    IF nv_line1 = 4  THEN wuppertxt3.txt =  wdetail.campaign .                                         
    IF nv_line1 = 5  THEN wuppertxt3.txt =  wdetail.notiuser  .
    IF nv_line1 = 6  THEN wuppertxt3.txt =  "STK : " +  wdetail.stk  .                                 
    IF nv_line1 = 7  THEN wuppertxt3.txt =  "เลขที่สัญญา : " +  wdetail.cedpol .     
    IF nv_line1 = 8  THEN wuppertxt3.txt =  "เลขที่ตรวจสภาพ : " +  wdetail.ispno.
    IF nv_line1 = 9  THEN wuppertxt3.txt =  "ProductType : " + wdetail.product.
    IF nv_line1 = 10 THEN wuppertxt3.txt =  trim(wdetail.remak1)*/ 
    /*IF nv_line1 = 3 THEN wuppertxt3.txt = "Date Confirm_file_name :" + wdetail.remark . */ 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm100 c-Win 
PROCEDURE proc_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF ra_NAP_pd = 1 THEN DO:  /*กรณี ต้องการ ให้ได้เบี้ย ตามไฟล์ */*/
    IF (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) >= 365 ) AND
       (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) <= 366 ) THEN
        ASSIGN 
        nv_gapprm  =  IF wdetail.prem_nap = "" THEN nv_gapprm ELSE DECI(wdetail.prem_nap)
        nv_pdprm   =  IF wdetail.prem_nap = "" THEN nv_pdprm  ELSE DECI(wdetail.prem_nap).
        ELSE  /*เบี้ย ไม่เต็มปี หรือ เกินปี */
            ASSIGN nv_pdprm   =  IF wdetail.prem_nap = "" THEN nv_pdprm  ELSE DECI(wdetail.prem_nap).
/*END.*/
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
        sic_bran.uwm301.mv41seat = wdetail.seat41.
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

