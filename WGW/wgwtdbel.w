&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_bran         PROGRESS
*/
&Scoped-define WINDOW-NAME wgwtdbel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwtdbel 
/*------------------------------------------------------------------------
/* Connected Databases  sic_test         PROGRESS  */
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
/*CREATE WIDGET-POOL.*/
/* ***************************  Definitions  ************************** */  
/* Parameters Definitions ---                                           */  
/* Local Variable Definitions ---                                       */  
/*******************************/                                       
/*programid  : wgwtdbel.w                                               */  
/*programname: load text file Fleet บริษัท เดอเบล จำกัด to GW           */  
/*Copyright  : Safety Insurance Public Company Limited                  */  
/*                         บริษัท ประกันคุ้มภัย จำกัด (มหาชน)           */  
/*create by  : Kridtiya i. A56-0328  date . 18/10/2013                  
               ปรับโปรแกรมให้สามารถนำเข้า text file บริษัท เดอเบล จำกัด to GW  system  */
/*Modify by  : Kridtiya i. A58-0206 แก้ไขการให้ค่าเลขตัวถัง 
               จากเดิม sic_bran.uwm301.trareg    = trim(wdetail.vehreg) 
               เป็น    sic_bran.uwm301.trareg    = trim(nv_uwm301trareg) */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/***************************************************************************************/ 
DEF VAR n_firstdat  AS CHAR     FORMAT "x(10)"  INIT "".
DEF VAR n_brand     AS CHAR     FORMAT "x(50)"  INIT "".
DEF VAR n_model     AS CHAR     FORMAT "x(50)"  INIT "".
DEF VAR n_index     AS INTE     INIT 0.
DEF VAR stklen      AS INTE.
DEF VAR dod0        AS DECI.
DEF VAR dod1        AS DECI.
DEF VAR dod2        AS DECI.
DEF VAR dpd0        AS DECI.
DEF VAR nv_com1p    AS DECI     INIT 0.00 .
DEF VAR n_ratmin    AS INTE     INIT 0.
DEF VAR n_ratmax    AS INTE     INIT 0.
DEF NEW SHARED VAR nv_riskno    Like  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno    Like  sicuw.uwm301.itemno. 
DEFINE STREAM  ns1. 
DEFINE STREAM  ns2.
DEFINE STREAM  ns3.
DEF VAR nv_uom1_v   AS INTE INIT 0. 
DEF VAR nv_uom2_v   AS INTE INIT 0. 
DEF VAR nv_uom5_v   AS INTE INIT 0. 
DEF VAR chkred      AS LOGICAL INIT NO.
DEF SHARED Var   n_User    As CHAR .
DEF SHARED Var   n_PassWd  As CHAR .    
DEF VAR nv_comper   AS DECI INIT 0.                
DEF VAR nv_comacc   AS DECI INIT 0.                
DEF NEW SHARED VAR nv_seat41        AS INTEGER FORMAT ">>9".
DEF NEW SHARED VAR nv_totsi         AS DECIMAL FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_polday        AS INTE    FORMAT ">>9".
def New SHARED VAR nv_uom6_u        as char.                
def var  nv_chk     as  logic.
DEF VAR  nv_ncbyrs  AS INTE.    
DEF NEW  SHARED VAR nv_odcod        AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_cons         AS CHAR        FORMAT "X(2)".
DEF New  shared VAR nv_prem         AS DECIMAL     FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_baseap       AS DECI        FORMAT ">>,>>>,>>9.99-".
DEF New  shared VAR nv_ded          AS INTEGER     FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_gapprm       AS DECI        FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_pdprm        AS DECI        FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_prvprm       AS DECI        FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_41prm        AS INTEGER     FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_ded1prm      AS INTEGER     FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_aded1prm     AS INTEGER     FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_ded2prm      AS INTEGER     FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_dedod        AS INTEGER     FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_addod        AS INTEGER     FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_dedpd        AS INTEGER     FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_prem1        AS DECIMAL     FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_addprm       AS INTEGER     FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_totded       AS INTEGER     FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_totdis       AS INTEGER     FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF New  SHARED VAR nv_41cod1       AS CHARACTER   FORMAT "X(4)".
DEF NEW  SHARED VAR nv_41cod2       AS CHARACTER   FORMAT "X(4)".
DEF New  SHARED VAR nv_41           AS INTEGER     FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_411prm       AS DECI        FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR nv_412prm       AS DECI        FORMAT ">,>>>,>>9.99".
DEF New  SHARED VAR nv_411var1      AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_411var2      AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_411var       AS CHAR        FORMAT "X(60)".
DEF New  SHARED VAR nv_412var1      AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_412var2      AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_412var       AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_42cod        AS CHARACTER   FORMAT "X(4)".
DEF NEW  SHARED VAR nv_42           AS INTEGER     FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_42prm        AS DECI        FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR nv_42var1       AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_42var2       AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_42var        AS CHAR        FORMAT "X(60)".
DEF New  SHARED VAR nv_43cod        AS CHARACTER   FORMAT "X(4)".
DEF NEW  SHARED VAR nv_43           AS INTEGER     FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_43prm        AS DECI        FORMAT ">,>>>,>>9.99".
DEF New  SHARED VAR nv_43var1       AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_43var2       AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_43var        AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_campcod      AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_camprem      AS DECI        FORMAT ">>>9".
DEF New  SHARED VAR nv_campvar1     AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_campvar2     AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_campvar      AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_compcod      AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_compprm      AS DECI        FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR nv_compvar1     AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_compvar2     AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_compvar      AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_basecod      AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_baseprm      AS DECI        FORMAT ">>,>>>,>>9.99-". 
DEF New  SHARED VAR nv_basevar1     AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_basevar2     AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_basevar      AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_cl_cod       AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_cl_per       AS DECIMAL     FORMAT ">9.99".
DEF New  SHARED VAR nv_lodclm       AS INTEGER     FORMAT ">>>,>>9.99-".
DEF             VAR nv_lodclm1      AS INTEGER     FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR nv_clmvar1      AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_clmvar2      AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_clmvar       AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_stf_cod      AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_stf_per      AS DECIMAL     FORMAT ">9.99".
DEF New  SHARED VAR nv_stf_amt      AS INTEGER     FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR nv_stfvar1      AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_stfvar2      AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_stfvar       AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_dss_cod      AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_dss_per      AS DECIMAL     FORMAT ">9.99".
DEF New  SHARED VAR nv_dsspc        AS INTEGER     FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR nv_dsspcvar1    AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_dsspcvar2    AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_dsspcvar     AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_ncb_cod      AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_ncbper       LIKE sicuw.uwm301.ncbper.
DEF New  SHARED VAR nv_ncb          AS DECI        FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_ncbvar1      AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_ncbvar2      AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_ncbvar       AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_flet_cod     AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_flet_per     AS DECIMAL     FORMAT ">>9".
DEF New  SHARED VAR nv_flet         AS DECI        FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_fletvar1     AS CHAR        FORMAT "X(30)".
DEF New  SHARED VAR nv_fletvar2     AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_fletvar      AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_vehuse       LIKE sicuw.uwm301.vehuse.                 
DEF NEW  SHARED VAR nv_grpcod       AS CHARACTER   FORMAT "X(4)".
DEF NEW  SHARED VAR nv_grprm        AS DECI        FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_grpvar1      AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_grpvar2      AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_grpvar       AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_othcod       AS CHARACTER   FORMAT "X(4)".
DEF NEW  SHARED VAR nv_othprm       AS DECI        FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_othvar1      AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_othvar2      AS CHAR        FORMAT "X(30)".
DEF NEW  SHARED VAR nv_othvar       AS CHAR        FORMAT "X(60)".
DEF NEW  SHARED VAR nv_dedod1_cod   AS CHAR        FORMAT "X(4)".             
DEF NEW  SHARED VAR nv_dedod1_prm   AS DECI        FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR nv_dedod1var1   AS CHAR        FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedod1var2   AS CHAR        FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedod1var    AS CHAR        FORMAT "X(60)".            
DEF NEW  SHARED VAR nv_dedod2_cod   AS CHAR        FORMAT "X(4)".             
DEF NEW  SHARED VAR nv_dedod2_prm   AS DECI        FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR nv_dedod2var1   AS CHAR        FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedod2var2   AS CHAR        FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedod2var    AS CHAR        FORMAT "X(60)".            
DEF NEW  SHARED VAR nv_dedpd_cod    AS CHAR        FORMAT "X(4)".             
DEF NEW  SHARED VAR nv_dedpd_prm    AS DECI        FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR nv_dedpdvar1    AS CHAR        FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedpdvar2    AS CHAR        FORMAT "X(30)".            
DEF NEW  SHARED VAR nv_dedpdvar     AS CHAR        FORMAT "X(60)".            
DEF NEW  SHARED VAR nv_tariff       LIKE sicuw.uwm301.tariff.
DEF NEW  SHARED VAR nv_comdat       LIKE sicuw.uwm100.comdat.
DEF NEW  SHARED VAR nv_covcod       LIKE sicuw.uwm301.covcod.
DEF NEW  SHARED VAR nv_class        AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_key_b        AS DECIMAL     FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEF NEW  SHARED VAR nv_drivno       AS INT       . 
DEF NEW  SHARED VAR nv_drivcod      AS CHARACTER   FORMAT "X(4)".
DEF NEW  SHARED VAR nv_drivprm      AS DECI        FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_drivvar1     AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_drivvar2     AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_drivvar      AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR nv_usecod       AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_useprm       AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_usevar1      AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_usevar2      AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_usevar       AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR nv_sicod        AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_siprm        AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_sivar1       AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_sivar2       AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_sivar        AS CHAR  FORMAT "X(60)".
def New  shared var nv_uom6_c       as  char.      /* Sum  si*/
def New  shared var nv_uom7_c       as  char.      /* Fire/Theft*/
DEF NEW  SHARED VAR nv_bipcod       AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_bipprm       AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_bipvar1      AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_bipvar2      AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_bipvar       AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR nv_biacod       AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_biaprm       AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_biavar1      AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_biavar2      AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_biavar       AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR nv_pdacod       AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_pdaprm       AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_pdavar1      AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_pdavar2      AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_pdavar       AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR nv_engine       LIKE sicsyac.xmm102.engine.
DEF NEW  SHARED VAR nv_tons         LIKE sicsyac.xmm102.tons.
DEF NEW  SHARED VAR nv_seats        LIKE sicsyac.xmm102.seats.
DEF NEW  SHARED VAR nv_sclass       AS CHAR FORMAT "x(3)".
DEF NEW  SHARED VAR nv_engcod       AS CHAR FORMAT "x(4)".
DEF NEW  SHARED VAR nv_engprm       AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_engvar1      AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_engvar2      AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_engvar       AS CHAR  FORMAT "X(60)".
DEF VAR  NO_CLASS                   AS CHAR INIT "".
DEF VAR  no_tariff                  AS CHAR INIT "".
DEF New shared var nv_poltyp        AS char   init  "".
DEF NEW SHARED VAR nv_yrcod         AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_yrprm         AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_yrvar1        AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar2        AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar         AS CHAR  FORMAT "X(60)".
DEF New shared VAR nv_caryr         AS INTE  FORMAT ">>>9" .
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
/*def var n_comdat   LIKE sicuw.uwm100.comdat  NO-UNDO.*/
/*def var n_policy   LIKE sicuw.uwm100.policy  INITIAL "" .*/
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
{wgw\wgwtdbel.i}      /*ประกาศตัวแปร*/
DEFINE VAR nv_txt1    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.
DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEF  VAR n_taxae    AS LOGICAL .
DEF  VAR n_stmpae   AS LOGICAL .
DEF  VAR n_com2ae   AS LOGICAL .
DEF  VAR n_com1ae   AS LOGICAL .
DEF  VAR nv_fi_com2_t    AS DECI INIT 0.00.
DEF  VAR nv_fi_rstp_t    AS INTE INIT 0.
DEF  VAR nv_fi_rtax_t    AS DECI INIT 0.00 .
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".
DEF VAR nv_uwm301trareg    LIKE sicuw.uwm301.cha_no INIT "".
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".
DEF  VAR gv_id AS CHAR FORMAT "X(15)" NO-UNDO.
DEF VAR nv_pwd AS CHAR FORMAT "X(15)" NO-UNDO.
DEF VAR nn_access AS CHAR FORMAT "x(100)" INIT "".

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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.policy wdetail.cndat wdetail.comdat wdetail.expdat wdetail.covcod wdetail.garage wdetail.tiname wdetail.insnam wdetail.policy   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y"
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail WHERE wdetail.pass = "y".
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_branch fi_producer fi_agent ~
fi_prevbat fi_bchno fi_bchyr fi_filename bu_file fi_output1 fi_output2 ~
fi_output3 fi_usrcnt fi_usrprem buok bu_exit br_wdetail bu_hpbrn bu_hpacno1 ~
bu_hpagent fi_process RECT-370 RECT-372 RECT-373 RECT-374 RECT-375 RECT-376 ~
RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_branch fi_producer fi_agent ~
fi_prevbat fi_bchno fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 ~
fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname fi_process fi_impcnt ~
fi_completecnt fi_premtot fi_premsuc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwtdbel AS WIDGET-HANDLE NO-UNDO.

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
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50.5 BY .95
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
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY .95
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
     SIZE 16 BY .95
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
     SIZE 22.67 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50.5 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 1.57
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 12
     BGCOLOR 18 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 6.48
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 3.76
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-375
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 130 BY 3.1
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 119 BY 2.52
     BGCOLOR 8 .

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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail wgwtdbel _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.policy        COLUMN-LABEL "Policy No."
      wdetail.cndat         COLUMN-LABEL "CN date."
      wdetail.comdat        COLUMN-LABEL "comdate."   
      wdetail.expdat        COLUMN-LABEL "expidate." 
      wdetail.covcod        COLUMN-LABEL "covcod  "
      wdetail.garage        COLUMN-LABEL "garage  "
      wdetail.tiname        COLUMN-LABEL "tiname  "
      wdetail.insnam        COLUMN-LABEL "insnam  "
      wdetail.policy        COLUMN-LABEL "policyno2"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 5.86
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 2.81 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.86 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.91 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 5.95 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 7 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.62 COL 15 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_bchyr AT ROW 7 COL 63.5 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 8.05 COL 27.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 8.05 COL 90.17
     fi_output1 AT ROW 9.1 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 10.14 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 11.19 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 12.24 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 12.24 COL 66.67 NO-LABEL
     buok AT ROW 8.48 COL 102.67
     bu_exit AT ROW 10.33 COL 102.83
     fi_brndes AT ROW 3.86 COL 37 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 14.91 COL 2.17
     bu_hpbrn AT ROW 3.86 COL 35
     bu_hpacno1 AT ROW 4.91 COL 46
     bu_hpagent AT ROW 5.95 COL 46
     fi_proname AT ROW 4.91 COL 48.33 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 5.95 COL 48.33 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 13.29 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 22.05 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_completecnt AT ROW 23.05 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.05 COL 97 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.1 COL 95 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     "                    Branch :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 3.86 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 7 COL 63.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 22.05 COL 94.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 23.05 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Previous Batch No.:" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 7 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.05 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 12.24 COL 86.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "            Agent Code  :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 5.95 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 23.05 COL 94.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.62 COL 5.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Policy Import Total :":60 VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 12.24 COL 27.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                Load Date :":35 VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 2.81 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     IMPORT TEXT FILE MOTOR [งานต่ออายุ บจก.เดอเบล]" VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.24 COL 2.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 8.05 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 10.14 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 12.24 COL 65.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.29 COL 57.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 11.19 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "         Producer Code :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 4.91 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 23.05 COL 57.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 9.1 COL 6
          BGCOLOR 8 FGCOLOR 1 
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.57 COL 1
     RECT-373 AT ROW 14.57 COL 1
     RECT-374 AT ROW 21.1 COL 1
     RECT-375 AT ROW 21.62 COL 2
     RECT-376 AT ROW 21.95 COL 4.33
     RECT-377 AT ROW 8.14 COL 101
     RECT-378 AT ROW 10 COL 101.17
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
  CREATE WINDOW wgwtdbel ASSIGN
         HIDDEN             = YES
         TITLE              = "     IMPORT TEXT FILE MOTOR [งานต่ออายุ บจก.เดอเบล]"
         HEIGHT             = 24.05
         WIDTH              = 133.17
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
IF NOT wgwtdbel:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwtdbel
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
          SIZE 12 BY .95 AT ROW 7 COL 63.83 RIGHT-ALIGNED               */

/* SETTINGS FOR TEXT-LITERAL "     Policy Import Total :"
          SIZE 22.5 BY .95 AT ROW 12.24 COL 27.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 25 BY .95 AT ROW 12.24 COL 65.33 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 22.05 COL 94.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.29 COL 57.5 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 23.05 COL 57.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 23.05 COL 94.83 RIGHT-ALIGNED       */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtdbel)
THEN wgwtdbel:HIDDEN = no.

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

&Scoped-define SELF-NAME wgwtdbel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtdbel wgwtdbel
ON END-ERROR OF wgwtdbel /*      IMPORT TEXT FILE MOTOR [งานต่ออายุ บจก.เดอเบล] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtdbel wgwtdbel
ON WINDOW-CLOSE OF wgwtdbel /*      IMPORT TEXT FILE MOTOR [งานต่ออายุ บจก.เดอเบล] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_wdetail
&Scoped-define SELF-NAME br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_wdetail wgwtdbel
ON ROW-DISPLAY OF br_wdetail IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    IF WDETAIL.WARNING <> "" THEN DO:
        wdetail.policy       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.cndat        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.comdat       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.expdat       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.covcod       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.garage       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.tiname       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.insnam       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.policy       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        
        wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.cndat        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.comdat       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.expdat       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.covcod       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.garage       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.tiname       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.insnam       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.policy       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok wgwtdbel
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    ASSIGN
        nv_batprev  = INPUT fi_prevbat
        fi_process  = "Load Text file [งานต่ออายุ บจก.เดอเบล]"
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
    nv_batchyr = INPUT fi_bchyr.
    IF nv_batprev = "" THEN DO: 
        FIND LAST uzm700 USE-INDEX uzm70001    WHERE 
            uzm700.bchyr   = nv_batchyr        AND
            uzm700.branch  = TRIM(nv_batbrn)   AND
            uzm700.acno    = TRIM(fi_producer) NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:  
            ASSIGN nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102   WHERE
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
            MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev) + " on file uzm701" .
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
        IF wdetail.poltyp      = "V70"  OR wdetail.poltyp   = "V72"  THEN DO:
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
                           INPUT            "WGWTDBEL" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem ).
    ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.
    RUN proc_chktest1.  
    FOR EACH wdetail WHERE wdetail.pass = "y" NO-LOCK .
        ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + decimal(wdetail.prem_r). 
    END.
    ASSIGN  
        nv_rectot     = nv_reccnt       
        nv_recsuc     = nv_completecnt. 
    IF  nv_rectot   <> nv_recsuc   THEN nv_batflg = NO.
    IF  nv_netprm_t <> nv_netprm_s THEN nv_batflg = NO.
    ELSE nv_batflg = YES.
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
    RELEASE sicsyac.xtm600.
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit wgwtdbel
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file wgwtdbel
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


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 wgwtdbel
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent wgwtdbel
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn wgwtdbel
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent wgwtdbel
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    IF fi_agent <> ""    THEN DO:
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001  WHERE
            sicsyac.xmm600.acno  =  Input fi_agent   NO-LOCK NO-ERROR NO-WAIT.
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr wgwtdbel
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch wgwtdbel
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
                fi_brndes     =  sicsyac.xmm023.bdes.
    END.    /*else do:*/
    Disp fi_branch  fi_brndes  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat wgwtdbel
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp  fi_loaddat  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat wgwtdbel
ON LEAVE OF fi_prevbat IN FRAME fr_main
DO:
    fi_prevbat = caps(INPUT fi_prevbat).
    nv_batprev = fi_prevbat.
    IF nv_batprev <> " "  THEN DO:
        IF LENGTH(nv_batprev) > 20 THEN DO:
            MESSAGE "Length Of Batch no. Must Be 16 Character " SKIP
                    "Please Check Batch No. Again             " view-as alert-box.
            APPLY "entry" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
    END.         /*nv_batprev <> " "*/
    DISPLAY fi_prevbat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer wgwtdbel
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer.
    IF  fi_producer <> " " THEN DO:
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001     WHERE
            sicsyac.xmm600.acno  =  Input fi_producer   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producer.
            RETURN NO-APPLY.     
        END.
        ELSE 
            ASSIGN
                fi_proname  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  caps(INPUT  fi_producer)  .  
    END.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrcnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrcnt wgwtdbel
ON LEAVE OF fi_usrcnt IN FRAME fr_main
DO:
  fi_usrcnt = INPUT fi_usrcnt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrprem wgwtdbel
ON LEAVE OF fi_usrprem IN FRAME fr_main
DO:
  fi_usrprem = INPUT fi_usrprem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwtdbel 


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
      gv_prgid = "Wgwtdbel.w" 
      gv_prog  = "Load Text & Generate Fleet บริษัท เดอเบล จำกัด".
      
  RUN  WUT\WUTHEAD (wgwtdbel:handle,gv_prgid,gv_prog).  
  ASSIGN
      fi_loaddat  = TODAY
      fi_branch   = "M" 
      fi_producer = "A0M0024"
      fi_agent    = "A000000"
      fi_bchyr    = YEAR(TODAY)
      fi_process  = "Load Text file บริษัท เดอเบล จำกัด" .
  DISP fi_loaddat  fi_process  fi_branch  fi_producer fi_agent fi_bchyr WITH FRAME fr_main.
  /*********************************************************************/  
  RUN  WUT\WUTWICEN (wgwtdbel:handle).  
  Session:data-Entry-Return = Yes.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
      WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwtdbel  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtdbel)
  THEN DELETE WIDGET wgwtdbel.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwtdbel  _DEFAULT-ENABLE
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
  DISPLAY fi_loaddat fi_branch fi_producer fi_agent fi_prevbat fi_bchno fi_bchyr 
          fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem 
          fi_brndes fi_proname fi_agtname fi_process fi_impcnt fi_completecnt 
          fi_premtot fi_premsuc 
      WITH FRAME fr_main IN WINDOW wgwtdbel.
  ENABLE fi_loaddat fi_branch fi_producer fi_agent fi_prevbat fi_bchno fi_bchyr 
         fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt 
         fi_usrprem buok bu_exit br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent 
         fi_process RECT-370 RECT-372 RECT-373 RECT-374 RECT-375 RECT-376 
         RECT-377 RECT-378 
      WITH FRAME fr_main IN WINDOW wgwtdbel.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW wgwtdbel.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72 wgwtdbel 
PROCEDURE proc_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/************** v72 comp y **********/
ASSIGN
    wdetail.tariff = "9"
    wdetail.compul = "y" 
    fi_process = "Process data Siam Carrent Group....compulsary "  .
DISP fi_process WITH FRAM fr_main.
IF wdetail.vehreg = "" THEN wdetail.vehreg = IF SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8) <> "" THEN
                                              "/" +   SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8 ) 
                                               ELSE "".

IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN /*a490166*/
            wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
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
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail.class NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN 
        wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
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
    sicsyac.xmm106.class   = "110" AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
        wdetail.OK_GEN = "N".
/*--------- modcod --------------*/
chkred = NO.
IF wdetail.prepol = "" THEN DO:
    ASSIGN np_moddes = wdetail.brand.
    IF INDEX(wdetail.brand," ") <> 0 THEN DO:
        IF  trim(SUBSTR(wdetail.brand,INDEX(wdetail.brand," "))) <> ""  THEN
        ASSIGN  
            wdetail.model = trim(SUBSTR(wdetail.brand,INDEX(wdetail.brand," ")))
            wdetail.brand = trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," "))).
        ELSE ASSIGN wdetail.model = "".
    END.
    FIND LAST sicsyac.xmm102 WHERE 
        sicsyac.xmm102.modest = trim(wdetail.brand + " " + wdetail.model)   No-lock no-error no-wait.
    If  avail sicsyac.xmm102  THEN  
        ASSIGN wdetail.redbook = sicsyac.xmm102.modcod
               wdetail.cargrp  = sicsyac.xmm102.vehgrp 
               wdetail.body    = sicsyac.xmm102.body
               np_moddes       = sicsyac.xmm102.modest . 
    ELSE wdetail.redbook = "".
    IF wdetail.redbook = ""  THEN DO:
        FIND LAST sicsyac.xmm102 WHERE 
            index(sicsyac.xmm102.modest,wdetail.brand) <> 0  No-lock no-error no-wait.
        If  avail sicsyac.xmm102  THEN  
            ASSIGN wdetail.redbook = sicsyac.xmm102.modcod
                   wdetail.cargrp  = sicsyac.xmm102.vehgrp 
                   wdetail.body    = sicsyac.xmm102.body
                   np_moddes       = sicsyac.xmm102.modest . 
        ELSE wdetail.redbook = "".
    END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 wgwtdbel 
PROCEDURE proc_722 :
/* ---------------------------------------------  U W M 1 3 0 -------------- */
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
        sic_bran.uwm301.bchyr  = nv_batchyr                      AND 
        sic_bran.uwm301.bchno  = nv_batchno                      AND 
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
        sic_bran.uwm301.cha_no  = wdetail.chassis
        sic_bran.uwm301.eng_no  = wdetail.engno
        sic_bran.uwm301.Tons    = INTEGER(wdetail.tonn)
        sic_bran.uwm301.engine  = INTEGER(wdetail.engcc)
        sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage  = wdetail.garage
        sic_bran.uwm301.body    = wdetail.body
        sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = ""
        sic_bran.uwm301.vehreg   = wdetail.vehreg 
        sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
        sic_bran.uwm301.vehgrp   = wdetail.cargrp
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        sic_bran.uwm301.moddes   = np_moddes       /*wdetail.brand + " " + wdetail.model */
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
    /*
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
                sic_bran.uwm301.body           = sicsyac.xmm102.body    /*A54-0126*/
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
    END.*/
    /*add A52-0172*/
    FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
         sic_bran.uwd132.policy = wdetail.policy   AND
         sic_bran.uwd132.rencnt = wdetail.n_rencnt AND
         sic_bran.uwd132.endcnt = wdetail.n_endcnt AND
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
      sic_bran.uwd132.gap_c   = deci(wdetail.premt)      /* kridtiya i.*/      /*GAP, per Benefit per Item*/
      sic_bran.uwd132.dl1_c   = 0                        /*Disc./Load 1,p. Benefit p.Item*/
      sic_bran.uwd132.dl2_c   = 0                        /*Disc./Load 2,p. Benefit p.Item*/
      sic_bran.uwd132.dl3_c   = 0                        /*Disc./Load 3,p. Benefit p.Item*/
      sic_bran.uwd132.pd_aep  = "E"                      /*Premium Due A/E/P Code*/
      sic_bran.uwd132.prem_c  = deci(wdetail.premt)      /*kridtiya i. deci(wdetail.premt) */     /*PD, per Benefit per Item*/
      sic_bran.uwd132.fptr    = 0                        /*Forward Pointer*/
      sic_bran.uwd132.bptr    = 0                        /*Backward Pointer*/
      sic_bran.uwd132.policy  = wdetail.policy           /*Policy No. - uwm130*/
      sic_bran.uwd132.rencnt  = wdetail.n_rencnt         /*Renewal Count - uwm130*/
      sic_bran.uwd132.endcnt  = wdetail.n_endcnt         /*Endorsement Count - uwm130*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_723 wgwtdbel 
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
        sicsyac.xmm107.class  = wdetail.class   AND
        sicsyac.xmm107.tariff = wdetail.tariff
        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xmm107 THEN DO:
        FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmd107 THEN DO:
            CREATE sic_bran.uwd132.
            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                sicsyac.xmm016.class = wdetail.class
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
                sic_bran.uwd132.bchyr   = nv_batchyr         /* batch Year */      
                sic_bran.uwd132.bchno   = nv_batchno         /* bchno    */      
                sic_bran.uwd132.bchcnt  = nv_batcnt .        /* bchcnt     */ 
            FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                sicsyac.xmm105.tariff = wdetail.tariff  AND
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:  /* Malaysia */
                IF           wdetail.class      = "110" THEN nv_key_a = inte(wdetail.engcc).
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
                    /*sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.*/
                    sic_bran.uwd132.gap_c  = deci(wdetail.premt) 
                    sic_bran.uwd132.prem_c = deci(wdetail.premt) 
                    nv_gap                 = nv_gap  +  deci(wdetail.premt) 
                    nv_prem                = nv_prem +  deci(wdetail.premt) .    /* durbell 72 */
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.class AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= 0                AND
                    sicsyac.xmm106.key_b  >= 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.class AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a   = 0                AND
                    sicsyac.xmm106.key_b   = 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.*/ /* Durbell */
                    sic_bran.uwd132.gap_c     =  deci(wdetail.premt).
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                        RECID(sic_bran.uwd132),
                                        sic_bran.uwm301.tariff).
                    /*nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.*/ /* durbell */
                    nv_gap        = nv_gap  +  deci(wdetail.premt). 
                    nv_prem       = nv_prem +  deci(wdetail.premt) .
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
                    sicsyac.xmm016.class = wdetail.class
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
                    IF           wdetail.class      = "110" THEN nv_key_a = inte(wdetail.engcc).
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
                            /*sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                            sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                            nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                            nv_prem                = nv_prem + sic_bran.uwd132.prem_c.*/
                        sic_bran.uwd132.gap_c  = deci(wdetail.premt) 
                        sic_bran.uwd132.prem_c = deci(wdetail.premt) 
                        nv_gap                 = nv_gap  +  deci(wdetail.premt) 
                        nv_prem                = nv_prem +  deci(wdetail.premt) .    /* durbell 72 */
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
                        sicsyac.xmm106.class   = wdetail.class          AND
                        sicsyac.xmm106.covcod  = wdetail.covcod            AND
                        sicsyac.xmm106.key_a   = 0                         AND
                        sicsyac.xmm106.key_b   = 0                         AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE xmm106 THEN DO:
                        /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.*/
                        sic_bran.uwd132.gap_c      = deci(wdetail.premt)   .

                        RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                            RECID(sic_bran.uwd132),
                                            sic_bran.uwm301.tariff).
                        /*nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c.*//*durbell*/
                        nv_gap        = nv_gap  +   deci(wdetail.premt) .
                        nv_prem       = nv_prem +   deci(wdetail.premt) .
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
                    ASSIGN 
                    /*sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.*/
                    sic_bran.uwd132.gap_c  = deci(wdetail.premt) 
                    sic_bran.uwd132.prem_c = deci(wdetail.premt) 
                    nv_gap                 = nv_gap  +  deci(wdetail.premt) 
                    nv_prem                = nv_prem +  deci(wdetail.premt) .    /* durbell 72 */
                
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
                    /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.*//*durbell*/
                    sic_bran.uwd132.gap_c      = deci(wdetail.premt).
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                        RECID(sic_bran.uwd132),
                                        sic_bran.uwm301.tariff).
                    /*nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.*/
                    nv_gap                 = nv_gap  +  deci(wdetail.premt). 
                    nv_prem                = nv_prem +  deci(wdetail.premt) .    /* durbell 72 */

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
            nv_pdprm  =  sicuw.uwd132.prem_c .
            
    END. 
END.*/
RUN proc_7231.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_7231 wgwtdbel 
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
        sic_bran.uwm130.bchyr = nv_batchyr              AND 
        sic_bran.uwm130.bchno = nv_batchno            AND 
        sic_bran.uwm130.bchcnt  = nv_batcnt             NO-LOCK:
        nv_fptr = sic_bran.uwm130.fptr03.
        DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
            FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr  NO-LOCK NO-ERROR NO-WAIT.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign wgwtdbel 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
  /*Load Text file 70 */
-------------------------------------------------------------------------------*/
DO:
    For each  wdetail :
        DELETE  wdetail.
    END.
    RUN proc_initdata.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|" 
            n_policy        /*  เลขกรมธรรม์ใหม่ */
            n_prepol        /*  เลขกรมธรรม์ต่ออายุ      */
            n_poltyp        /*  Policytype      */
            n_vehreg        /*  ทะเบียน */
            n_comdat        /*  วันเริ่มคุ้มครอง        */
            n_expdat        /*  วันหมดอายุ      */
            n_premtnet      /*  Net Premium     */
            n_stmp          /*  stmp    */
            n_tax           /*  vat     */
            np_insref       /*  Insd..  */
            np_producer     /*  Producer        */
            np_agent        /*  Agent   */
            np_class        /*  คลาสรถ  */
            np_cha_no       /*  เลขถัง  */
            np_eng_no       /*  เลขเครื่องยนต์  */
            np_yrmanu       /*  ปีรถ    */
            np_brand        /*  ยี่ห้อ-รุ่นรถ   */
            np_engine       /*  Engine CC's..   */
            np_tons         /*  Tonnage..       */
            np_seats        /*  Seats.. */
            np_textf18 .    /*  Remark */
        IF (n_policy <> "" ) AND (index(n_policy,"เลขกรม") = 0 )   THEN  RUN proc_assignwdetail .
        RUN proc_initdata.
    END.                     /* repeat   */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign72 wgwtdbel 
PROCEDURE proc_assign72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    n_policy72 = ""
    n_vehreg   = "" 
    n_comdat   = ""
    n_expdat   = ""
    n_premtnet = ""
    n_stmp     = ""
    n_tax      = "" .  
For each  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "|" 
        n_policy72 
        n_vehreg
        n_comdat
        n_expdat
        n_premtnet
        n_stmp
        n_tax        .
    IF n_policy72 <> "" THEN RUN proc_create72.
    RUN proc_initdata.
END. 
*/                    /* repeat   */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew wgwtdbel 
PROCEDURE proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF VAR nseats AS INTE INIT 0.
DEF VAR nclas2 AS CHAR INIT "".
ASSIGN 
    nn_cr2       = ""
    nn_covcod    = ""
    nn_garage    = ""
    nn_redbook   = ""
    nn_brand     = ""
    nn_model     = ""
    nn_body      = ""
    nn_vehreg    = ""
    nn_eng       = ""
    nn_chasno    = ""
    nn_caryear   = ""
    nn_comdat    = ?
    nn_firstdat  = ?.
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwsaex1(INPUT-OUTPUT  np_prepol    AS CHAR FORMAT "x(16)" .                        
                     INPUT-OUTPUT  np_insref    AS CHAR FORMAT "x(10)".                         
                     INPUT-OUTPUT  np_title     AS CHAR FORMAT "x(20)" .                        
                     INPUT-OUTPUT  np_name1     AS CHAR FORMAT "x(60)" .                        
                     INPUT-OUTPUT  np_name2     AS CHAR FORMAT "x(60)"  .                       
                     INPUT-OUTPUT  np_name3     AS CHAR FORMAT "x(60)" .                        
                     INPUT-OUTPUT  np_addr1     AS CHAR FORMAT "x(35)" INIT "" .                
                     INPUT-OUTPUT  np_addr2     AS CHAR FORMAT "x(35)" INIT "" .                
                     INPUT-OUTPUT  np_addr3     AS CHAR FORMAT "x(35)" INIT "" .                
                     INPUT-OUTPUT  np_addr4     AS CHAR FORMAT "x(35)" INIT "" .                
                     INPUT-OUTPUT  np_occupn    AS CHAR FORMAT "x(40)"  .                       
                     INPUT-OUTPUT  np_firstdat  AS DATE FORMAT "99/99/9999".                    
                     INPUT-OUTPUT  np_comdat    AS DATE FORMAT "99/99/9999".                    
                     INPUT-OUTPUT  np_expdat    AS DATE FORMAT "99/99/9999".                    
                     INPUT-OUTPUT  np_class     AS CHAR FORMAT "x(4)"      .                    
                     INPUT-OUTPUT  np_redbook    AS CHAR FORMAT "x(10)".                        
                     INPUT-OUTPUT  np_moddes    AS CHAR FORMAT "x(65)".                         
                     INPUT-OUTPUT  np_yrmanu    AS CHAR FORMAT "x(5)".                          
                     INPUT-OUTPUT  np_vehgrp    AS CHAR FORMAT "x"  .                           
                     INPUT-OUTPUT  np_body      AS CHAR FORMAT "x(20)".                         
                     INPUT-OUTPUT  np_engine    AS CHAR FORMAT "x(30)".                         
                     INPUT-OUTPUT  np_tons      AS CHAR FORMAT "x(5)"   INIT "" .               
                     INPUT-OUTPUT  np_seats     AS CHAR FORMAT "x(2)"   INIT "" .               
                     INPUT-OUTPUT  np_vehuse    AS CHAR FORMAT "x"      INIT "" .               
                     INPUT-OUTPUT  np_covcod    AS CHAR FORMAT "x"      INIT "" .               
                     INPUT-OUTPUT  np_garage    AS CHAR FORMAT "x"      INIT "" .               
                     INPUT-OUTPUT  np_vehreg    AS CHAR FORMAT "x(11)"  INIT "" .               
                     INPUT-OUTPUT  np_cha_no    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_eng_no    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_uom1_v    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_uom2_v    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_uom5_v    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_si        AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_baseprm   AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_41        AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_42        AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_43        AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_seat41    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_dedod     AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_addod     AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_dedpd     AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_flet_per  AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_ncbper    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_dss_per   AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_stf_per   AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_cl_per    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_bennam1   AS CHAR FORMAT "x(60)"  INIT "" .      
                      
END.  */          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew72 wgwtdbel 
PROCEDURE proc_assignrenew72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
RUN proc_initrenew.
FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
    sicuw.uwm100.policy = wdetail.prepol NO-LOCK NO-ERROR NO-WAIT .
IF AVAIL sicuw.uwm100 THEN DO:
    ASSIGN 
        wdetail.prepol            /*  np_prepol       */ 
        wdetail.n_branch   = sicuw.uwm100.branch       /*  np_branch       */     
        wdetail.producer          /*  np_producer     */ 
        wdetail.agent             /*  np_agent        */ 
        np_langug                 /*  np_langug       */      
        wdetail.inserf            /*  np_insref       */ 
        wdetail.tiname            /*  np_title        */ 
        wdetail.insnam            /*  np_name1        */ 
        wdetail.name2             /*  np_name2        */ 
        wdetail.name3             /*  np_name3        */ 
        wdetail.n_addr1           /*  np_addr1        */ 
        wdetail.n_addr2           /*  np_addr2        */ 
        wdetail.n_addr3           /*  np_addr3        */ 
        wdetail.n_addr4           /*  np_addr4        */ 
        np_occupn,                /*  np_occupn       */ 
        wdetail.comdat,           /*  np_comdat       */ 
        wdetail.expdat,           /*  np_expdat       */ 
        wdetail.fristdat,         /*  np_firstdat     */ 
        np_cedpol,                /*  np_cedpol       */ 
                     INPUT-OUTPUT  wdetail.class,       /*  np_class        */ 
                     INPUT-OUTPUT  wdetail.redbook,     /*  np_redbook      */ 
                     INPUT-OUTPUT  np_moddes,           /*  np_moddes       */ 
                     INPUT-OUTPUT  wdetail.caryear,     /*  np_yrmanu       */ 
                     INPUT-OUTPUT  wdetail.cargrp,      /*  np_vehgrp       */ 
                     INPUT-OUTPUT  wdetail.body,        /*  np_body         */ 
                     INPUT-OUTPUT  wdetail.engcc,       /*  np_engine       */ 
                     INPUT-OUTPUT  wdetail.Tonn,        /*  np_tons         */ 
                     INPUT-OUTPUT  wdetail.seat,        /*  np_seats        */ 
                     INPUT-OUTPUT  wdetail.vehuse,      /*  np_vehuse       */ 
                     INPUT-OUTPUT  wdetail.covcod,      /*  np_covcod       */ 
                     INPUT-OUTPUT  wdetail.garage,      /*  np_garage       */ 
                     INPUT-OUTPUT  np_vehreg,           /*  np_vehreg       */ 
                     INPUT-OUTPUT  wdetail.chassis,     /*  np_cha_no       */ 
                     INPUT-OUTPUT  wdetail.engno,       /*  np_eng_no       */ 
                     INPUT-OUTPUT  wdetail.seat41,      /*  np_seat41       */ 
                     INPUT-OUTPUT  np_ncbyrs,           /*  np_ncbyrs       */ 
                     INPUT-OUTPUT  wdetail.benname,     /*  np_bennam1      */ 
                     INPUT-OUTPUT  wdetail.prmtxt,      /*  np_prmtxt       */ 
                     INPUT-OUTPUT  wdetail.uom1_v,      /*  np_uom1_v       */ 
                     INPUT-OUTPUT  wdetail.uom2_v,      /*  np_uom2_v       */ 
                     INPUT-OUTPUT  wdetail.uom5_v,      /*  np_uom5_v       */ 
                     INPUT-OUTPUT  wdetail.si,          /*  np_uom6_v       */ 
                     INPUT-OUTPUT  wdetail.fi,          /*  np_uom7_v       */ 
                     INPUT-OUTPUT  np_styp20,           /*  np_styp20       */ 
                     INPUT-OUTPUT  nv_baseprm,          /*  np_baseprm      */ 
                     INPUT-OUTPUT  np_use,              /*  np_use          */ 
                     INPUT-OUTPUT  np_grp,              /*  np_grp          */ 
                     INPUT-OUTPUT  np_yr,               /*  np_yr           */ 
                     INPUT-OUTPUT  np_si,               /*  np_si           */ 
                     INPUT-OUTPUT  np_oth,              /*  np_oth          */ 
                     INPUT-OUTPUT  np_eng,              /*  np_eng          */ 
                     INPUT-OUTPUT  np_driv,             /*  np_driv         */ 
                     INPUT-OUTPUT  nv_41,               /*  np_41           */ 
                     INPUT-OUTPUT  nv_42,               /*  np_42           */ 
                     INPUT-OUTPUT  nv_43,               /*  np_43           */ 
                     INPUT-OUTPUT  np_dedod,            /*  np_dedod        */ 
                     INPUT-OUTPUT  np_addod,            /*  np_addod        */ 
                     INPUT-OUTPUT  np_dedpd,            /*  np_dedpd        */                         
                     INPUT-OUTPUT  wdetail.fleet,       /*  np_flet_per     */  
                     INPUT-OUTPUT  nv_ncbper,           /*  np_ncbper       */  
                     INPUT-OUTPUT  wdetail.dspc,        /*  np_dss_per      */  
                     INPUT-OUTPUT  nv_stf_per,          /*  np_stf_per      */  
                     INPUT-OUTPUT  nv_cl_per).          /*  np_cl_per       */ 
                                
END.     */                                                      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew_pol wgwtdbel 
PROCEDURE proc_assignrenew_pol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    np_occupn    = ""    /*  np_occupn       */ 
    np_cedpol    = ""    /*  np_cedpol       */ 
    np_moddes    = ""    /*  np_moddes       */ 
    np_vehreg    = ""    /*  np_vehreg       */ 
    np_ncbyrs    = ""    /*  np_ncbyrs       */ 
    np_styp20    = ""    /*  np_styp20       */ 
    nv_baseprm   = 0     /*  np_baseprm      */ 
    np_use       = 0     /*  np_use          */ 
    np_grp       = 0     /*  np_grp          */ 
    np_yr        = 0     /*  np_yr           */ 
    np_si        = ""    /*  np_si           */ 
    np_oth       = 0     /*  np_oth          */ 
    np_eng       = 0     /*  np_eng          */ 
    np_driv      = 0     /*  np_driv         */ 
    nv_41        = 0     /*  np_41           */ 
    nv_42        = 0     /*  np_42           */ 
    nv_43        = 0     /*  np_43           */ 
    np_dedod     = 0     /*  np_dedod        */ 
    np_addod     = 0     /*  np_addod        */ 
    np_dedpd     = 0     /*  np_dedpd        */                       
    nv_ncbper    = 0    
    nv_stf_per   = 0     /*  np_stf_per      */  
    nv_cl_per    = 0  .  /*  np_cl_per       */

IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwtdbex(INPUT-OUTPUT  wdetail.prepol,      /*  np_prepol       */ 
                     INPUT-OUTPUT  wdetail.n_branch,    /*  np_branch       */     
                     INPUT-OUTPUT  wdetail.producer,    /*  np_producer     */ 
                     INPUT-OUTPUT  wdetail.agent,       /*  np_agent        */ 
                     INPUT-OUTPUT  np_langug,           /*  np_langug       */      
                     INPUT-OUTPUT  wdetail.inserf,      /*  np_insref       */ 
                     INPUT-OUTPUT  wdetail.tiname,      /*  np_title        */ 
                     INPUT-OUTPUT  wdetail.insnam,      /*  np_name1        */ 
                     INPUT-OUTPUT  wdetail.name2,       /*  np_name2        */ 
                     INPUT-OUTPUT  wdetail.name3,       /*  np_name3        */ 
                     INPUT-OUTPUT  wdetail.n_addr1,     /*  np_addr1        */ 
                     INPUT-OUTPUT  wdetail.n_addr2,     /*  np_addr2        */ 
                     INPUT-OUTPUT  wdetail.n_addr3,     /*  np_addr3        */ 
                     INPUT-OUTPUT  wdetail.n_addr4,     /*  np_addr4        */ 
                     INPUT-OUTPUT  np_occupn,           /*  np_occupn       */ 
                     INPUT-OUTPUT  wdetail.comdat,      /*  np_comdat       */ 
                     INPUT-OUTPUT  wdetail.expdat,      /*  np_expdat       */ 
                     INPUT-OUTPUT  wdetail.fristdat,    /*  np_firstdat     */ 
                     INPUT-OUTPUT  np_cedpol,           /*  np_cedpol       */ 
                     INPUT-OUTPUT  wdetail.class,       /*  np_class        */ 
                     INPUT-OUTPUT  wdetail.redbook,     /*  np_redbook      */ 
                     INPUT-OUTPUT  np_moddes,           /*  np_moddes       */ 
                     INPUT-OUTPUT  wdetail.caryear,     /*  np_yrmanu       */ 
                     INPUT-OUTPUT  wdetail.cargrp,      /*  np_vehgrp       */ 
                     INPUT-OUTPUT  wdetail.body,        /*  np_body         */ 
                     INPUT-OUTPUT  wdetail.engcc,       /*  np_engine       */ 
                     INPUT-OUTPUT  wdetail.Tonn,        /*  np_tons         */ 
                     INPUT-OUTPUT  wdetail.seat,        /*  np_seats        */ 
                     INPUT-OUTPUT  wdetail.vehuse,      /*  np_vehuse       */ 
                     INPUT-OUTPUT  wdetail.covcod,      /*  np_covcod       */ 
                     INPUT-OUTPUT  wdetail.garage,      /*  np_garage       */ 
                     INPUT-OUTPUT  np_vehreg,           /*  np_vehreg       */ 
                     INPUT-OUTPUT  wdetail.chassis,     /*  np_cha_no       */ 
                     INPUT-OUTPUT  wdetail.engno,       /*  np_eng_no       */ 
                     INPUT-OUTPUT  wdetail.seat41,      /*  np_seat41       */ 
                     INPUT-OUTPUT  np_ncbyrs,           /*  np_ncbyrs       */ 
                     INPUT-OUTPUT  wdetail.benname,     /*  np_bennam1      */ 
                     INPUT-OUTPUT  wdetail.prmtxt,      /*  np_prmtxt       */ 
                     INPUT-OUTPUT  wdetail.uom1_v,      /*  np_uom1_v       */ 
                     INPUT-OUTPUT  wdetail.uom2_v,      /*  np_uom2_v       */ 
                     INPUT-OUTPUT  wdetail.uom5_v,      /*  np_uom5_v       */ 
                     INPUT-OUTPUT  wdetail.si,          /*  np_uom6_v       */ 
                     INPUT-OUTPUT  wdetail.fi,          /*  np_uom7_v       */ 
                     INPUT-OUTPUT  np_styp20,           /*  np_styp20       */ 
                     INPUT-OUTPUT  nv_baseprm,          /*  np_baseprm      */ 
                     INPUT-OUTPUT  np_use,              /*  np_use          */ 
                     INPUT-OUTPUT  np_grp,              /*  np_grp          */ 
                     INPUT-OUTPUT  np_yr,               /*  np_yr           */ 
                     INPUT-OUTPUT  np_si,               /*  np_si           */ 
                     INPUT-OUTPUT  np_oth,              /*  np_oth          */ 
                     INPUT-OUTPUT  np_eng,              /*  np_eng          */ 
                     INPUT-OUTPUT  np_driv,             /*  np_driv         */ 
                     INPUT-OUTPUT  nv_41,               /*  np_41           */ 
                     INPUT-OUTPUT  nv_42,               /*  np_42           */ 
                     INPUT-OUTPUT  nv_43,               /*  np_43           */ 
                     INPUT-OUTPUT  np_dedod,            /*  np_dedod        */ 
                     INPUT-OUTPUT  np_addod,            /*  np_addod        */ 
                     INPUT-OUTPUT  np_dedpd,            /*  np_dedpd        */                       
                     INPUT-OUTPUT  wdetail.fleet,       /*  np_flet_per     */  
                     INPUT-OUTPUT  nv_ncbper,           /*  np_ncbper       */  
                     INPUT-OUTPUT  wdetail.dspc,        /*  np_dss_per      */  
                     INPUT-OUTPUT  nv_stf_per,          /*  np_stf_per      */  
                     INPUT-OUTPUT  nv_cl_per).          /*  np_cl_per       */
END.                                                            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew_pol2 wgwtdbel 
PROCEDURE proc_assignrenew_pol2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF   wdetail.comdat   = ""   THEN  wdetail.comdat   =  re_comdat .     
IF   wdetail.expdat   = ""   THEN  wdetail.expdat   =  re_expdat .     
IF   wdetail.class    = ""   THEN  wdetail.class    =  re_class .      
IF   wdetail.brand    = ""   THEN  wdetail.brand    =  re_moddes .     
ELSE wdetail.redbook = "" .   
IF  wdetail.caryear  = ""   THEN  wdetail.caryear  =  re_yrmanu .     
IF  wdetail.seat     = ""   THEN  wdetail.seat     =  re_seats  .         
IF  wdetail.vehuse   = ""   THEN  wdetail.vehuse   =  re_vehuse .       
IF  wdetail.covcod   = ""   THEN  wdetail.covcod   =  re_covcod .       
IF  wdetail.garage   = ""   THEN  wdetail.garage   =  re_garage .       
IF  wdetail.vehreg   = ""   THEN  wdetail.vehreg   =  re_vehreg .        
IF  wdetail.chassis  = ""   THEN  wdetail.chassis  =  re_cha_no .     
IF  wdetail.engno    = ""   THEN  wdetail.engno    =  re_eng_no .       
IF  wdetail.uom1_v   = ""   THEN  wdetail.uom1_v   =  re_uom1_v .      
IF  wdetail.uom2_v   = ""   THEN  wdetail.uom2_v   =  re_uom2_v .     
IF  wdetail.uom5_v   = ""   THEN  wdetail.uom5_v   =  re_uom5_v .     
IF  wdetail.si       = ""   THEN  wdetail.si       =  re_si     .      
IF  nv_baseprm       = 0    THEN  nv_baseprm       =  re_baseprm.     
IF  nv_41            = 0    THEN  nv_41            =  re_41     .      
IF  nv_42            = 0    THEN  nv_42            =  re_42     .     
IF  nv_43            = 0    THEN  nv_43            =  re_43     .     
IF  wdetail.seat41   = 0    THEN  wdetail.seat41   =  re_seat41 .      
IF  dod1             = 0    THEN  dod1             =  re_dedod  .     
IF  dod2             = 0    THEN  dod2             =  re_addod  .     
IF  dod0             = 0    THEN  dod0             =  re_dedpd  .     
IF  wdetail.fleet    = ""   THEN  wdetail.fleet    =  re_flet_per .      
IF  wdetail.ncb      = ""   THEN  wdetail.ncb      =  re_ncbper .      
IF  wdetail.dspc     = ""   THEN  wdetail.dspc     =  re_dss_per.      
IF  nv_stf_per       = 0    THEN  nv_stf_per       =  re_stf_per.      
IF  nv_cl_per        = 0    THEN  nv_cl_per        =  re_cl_per .     
IF  n_benname        = ""   THEN  n_benname        =  re_bennam1.     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignwdetail wgwtdbel 
PROCEDURE proc_assignwdetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.policy = trim(n_policy) NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    /*CREATE wacctext.*/
    ASSIGN 
        wdetail.policy     = trim(n_policy)      /*  เลขกรมธรรม์ใหม่    */    
        wdetail.prepol     = TRIM(n_prepol)      /*  เลขกรมธรรม์ต่ออายุ */
        wdetail.n_branch   = "M"
        wdetail.poltyp     = trim(n_poltyp)      /*  Policytype         */        
        wdetail.vehreg     = trim(n_vehreg)      /*  ทะเบียน */            
        wdetail.comdat     = trim(n_comdat)      /*  วันเริ่มคุ้มครอง    */
        wdetail.expdat     = TRIM(n_expdat)      /*  วันหมดอายุ  */        
        wdetail.premt      = trim(n_premtnet)    /*  Net Premium */        
                                                 /*n_stmp      /*  stmp*/            
                                                 n_tax       /*  vat */ */               
        wdetail.inserf     = trim(np_insref)     /*  Insd..   */            
        wdetail.producer   = trim(np_producer)   /*  Producer */        
        wdetail.agent      = trim(np_agent)      /*  Agent    */            
        wdetail.class      = TRIM(np_class)      /*  คลาสรถ  */            
        wdetail.chassis    = TRIM(np_cha_no)     /*  เลขถัง  */            
        wdetail.engno      = trim(np_eng_no)     /*  เลขเครื่องยนต์  */    
        wdetail.caryear    = TRIM(np_yrmanu)     /*  ปีรถ    */            
        wdetail.brand      = TRIM(np_brand)      /*  ยี่ห้อ-รุ่นรถ   */    
        wdetail.engcc      = trim(np_engine)     /*  Engine CC's..   */    
        wdetail.Tonn       = deci(TRIM(np_tons)) /*  Tonnage..   */        
        wdetail.seat       = TRIM(np_seats)      /*  Seats.. */  
        wdetail.nmember    = TRIM(np_textf18)    /*  F18.. */ 
        wdetail.tariff     = IF trim(n_poltyp) = "V72" THEN "9" ELSE "X" 
        wdetail.pass       = "y".
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_polexp wgwtdbel 
PROCEDURE proc_assign_polexp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN         
    nv_gapprm = 0
    nv_pdprm  = 0.
FOR EACH wuwd132 WHERE  wuwd132.prepol = wdetail.prepol   NO-LOCK  .
    ASSIGN nv_gapprm     = nv_gapprm + wuwd132.gap_c  
        nv_pdprm         = nv_pdprm  + wuwd132.prem_c .

    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
    FIND LAST  sic_bran.uwd132  USE-INDEX uwd13201  WHERE     /*a490116 note change index from uwd13290 to uwd13201*/
        sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
        sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
        sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
        sic_bran.uwd132.bencod  = wuwd132.bencod          AND 
        sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
        sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
        sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
        sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
        sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  NO-ERROR  NO-WAIT  .
    IF AVAIL sic_bran.uwd132 THEN DO:  
        ASSIGN  
            sic_bran.uwd132.bencod       = ""  
            sic_bran.uwd132.benvar       = ""
            sic_bran.uwd132.gap_c        = 0   
            sic_bran.uwd132.prem_c       = 0
            sic_bran.uwd132.bencod       = wuwd132.bencod   
            sic_bran.uwd132.benvar       = wuwd132.benvar
            sic_bran.uwd132.gap_c        = wuwd132.gap_c   
            sic_bran.uwd132.prem_c       = wuwd132.prem_c .

            IF sic_bran.uwd132.bencod  = "BASE" THEN  
               ASSIGN  
                nv_basecod = sic_bran.uwd132.bencod
                nv_baseprm = wuwd132.gap_c    
                nv_basevar = wuwd132.benvar  .
            ELSE IF  index(sic_bran.uwd132.bencod,"use") <> 0 THEN
                ASSIGN  
                nv_usecod  = sic_bran.uwd132.bencod
                nv_baseprm = wuwd132.gap_c    
                nv_basevar = wuwd132.benvar  .
            ELSE IF  sic_bran.uwd132.bencod  =   "ENGC" THEN
                ASSIGN  
                nv_engcod  = sic_bran.uwd132.bencod   
                nv_baseprm = wuwd132.gap_c       
                nv_basevar = wuwd132.benvar  .   
            ELSE IF  sic_bran.uwd132.bencod  =  "411" THEN
                ASSIGN 
                nv_41cod1  = sic_bran.uwd132.bencod    
                nv_411prm  = wuwd132.gap_c        
                nv_411var  = wuwd132.benvar  .    
 
            ELSE IF  sic_bran.uwd132.bencod  =   "42" THEN
                ASSIGN  
                nv_42cod  = sic_bran.uwd132.bencod 
                nv_412prm = wuwd132.gap_c     
                nv_412var = wuwd132.benvar  . 
            ELSE IF  sic_bran.uwd132.bencod  =   "43" THEN
                ASSIGN  
                nv_43cod = sic_bran.uwd132.bencod   
                nv_43prm = wuwd132.gap_c       
                nv_43var = wuwd132.benvar  .   
            ELSE IF  sic_bran.uwd132.bencod  =   "si" THEN
                ASSIGN  
                nv_sicod = sic_bran.uwd132.bencod    
                nv_siprm = wuwd132.gap_c        
                nv_sivar = wuwd132.benvar  .
        END.
        ELSE DO:
            CREATE sic_bran.uwd132.
            ASSIGN  
            sic_bran.uwd132.bencod   = ""  
            sic_bran.uwd132.benvar   = ""
            sic_bran.uwd132.gap_c    = 0   
            sic_bran.uwd132.prem_c   = 0
            sic_bran.uwd132.policy   = sic_bran.uwm130.policy  
            sic_bran.uwd132.rencnt   = sic_bran.uwm130.rencnt 
            sic_bran.uwd132.endcnt   = sic_bran.uwm130.endcnt 
            sic_bran.uwd132.bencod   = wuwd132.bencod    
            sic_bran.uwd132.riskno   = sic_bran.uwm130.riskno   
            sic_bran.uwd132.itemno   = sic_bran.uwm130.itemno  
            sic_bran.uwd132.bchyr    = sic_bran.uwm130.bchyr   
            sic_bran.uwd132.bchno    = sic_bran.uwm130.bchno   
            sic_bran.uwd132.bchcnt   = sic_bran.uwm130.bchcnt   
            sic_bran.uwd132.benvar   = wuwd132.benvar     
            sic_bran.uwd132.gap_c    = wuwd132.gap_c      
            sic_bran.uwd132.prem_c   = wuwd132.prem_c .  
            IF sic_bran.uwd132.bencod  = "BASE" THEN  
               ASSIGN  nv_basecod = "BASE"
                nv_baseprm = wuwd132.gap_c    
                nv_basevar = wuwd132.benvar  .
        END.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_polmas wgwtdbel 
PROCEDURE proc_assign_polmas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN         
    nv_gapprm = 0
    nv_pdprm  = 0.
FOR EACH sicuw.uwd132 WHERE  sicuw.uwd132.policy = trim(fi_policymas)   NO-LOCK  .
    ASSIGN nv_gapprm     = nv_gapprm + sicuw.uwd132.gap_c  
        nv_pdprm         = nv_pdprm  + sicuw.uwd132.prem_c .
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
    FIND LAST  sic_bran.uwd132  USE-INDEX uwd13201  WHERE     /*a490116 note change index from uwd13290 to uwd13201*/
        sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
        sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
        sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
        sic_bran.uwd132.bencod  = sicuw.uwd132.bencod     AND 
        sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
        sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
        sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
        sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
        sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  NO-ERROR  NO-WAIT  .
    IF AVAIL sic_bran.uwd132 THEN DO:  
        ASSIGN  
            sic_bran.uwd132.bencod       = ""  
            sic_bran.uwd132.benvar       = ""
            sic_bran.uwd132.gap_c        = 0   
            sic_bran.uwd132.prem_c       = 0
            sic_bran.uwd132.bencod       = sicuw.uwd132.bencod   
            sic_bran.uwd132.benvar       = sicuw.uwd132.benvar
            sic_bran.uwd132.gap_c        = sicuw.uwd132.gap_c   
            sic_bran.uwd132.prem_c       = sicuw.uwd132.prem_c .
            IF sic_bran.uwd132.bencod  = "BASE" THEN  
               ASSIGN  
                nv_basecod = sic_bran.uwd132.bencod
                nv_baseprm = sicuw.uwd132.gap_c    
                nv_basevar = sicuw.uwd132.benvar  .
            ELSE IF  index(sic_bran.uwd132.bencod,"use") <> 0 THEN
                ASSIGN  
                nv_usecod  = sic_bran.uwd132.bencod
                nv_baseprm = sicuw.uwd132.gap_c    
                nv_basevar = sicuw.uwd132.benvar  .
            ELSE IF  sic_bran.uwd132.bencod  =   "ENGC" THEN
                ASSIGN  
                nv_engcod  = sic_bran.uwd132.bencod   
                nv_baseprm = sicuw.uwd132.gap_c       
                nv_basevar = sicuw.uwd132.benvar  .   
            ELSE IF  sic_bran.uwd132.bencod  =  "411" THEN
                ASSIGN 
                nv_41cod1  = sic_bran.uwd132.bencod    
                nv_411prm  = sicuw.uwd132.gap_c        
                nv_411var  = sicuw.uwd132.benvar  .    
 
            ELSE IF  sic_bran.uwd132.bencod  =   "42" THEN
                ASSIGN  
                nv_42cod  = sic_bran.uwd132.bencod 
                nv_412prm = sicuw.uwd132.gap_c     
                nv_412var = sicuw.uwd132.benvar  . 
            ELSE IF  sic_bran.uwd132.bencod  =   "43" THEN
                ASSIGN  
                nv_43cod = sic_bran.uwd132.bencod   
                nv_43prm = sicuw.uwd132.gap_c       
                nv_43var = sicuw.uwd132.benvar  .   
            ELSE IF  sic_bran.uwd132.bencod  =   "si" THEN
                ASSIGN  
                nv_sicod = sic_bran.uwd132.bencod    
                nv_siprm = sicuw.uwd132.gap_c        
                nv_sivar = sicuw.uwd132.benvar  .
        END.
        ELSE DO:
            CREATE sic_bran.uwd132.
            ASSIGN  
            sic_bran.uwd132.bencod   = ""  
            sic_bran.uwd132.benvar   = ""
            sic_bran.uwd132.gap_c    = 0   
            sic_bran.uwd132.prem_c   = 0
            sic_bran.uwd132.policy   = sic_bran.uwm130.policy  
            sic_bran.uwd132.rencnt   = sic_bran.uwm130.rencnt 
            sic_bran.uwd132.endcnt   = sic_bran.uwm130.endcnt 
            sic_bran.uwd132.bencod   = sicuw.uwd132.bencod    
            sic_bran.uwd132.riskno   = sic_bran.uwm130.riskno   
            sic_bran.uwd132.itemno   = sic_bran.uwm130.itemno  
            sic_bran.uwd132.bchyr    = sic_bran.uwm130.bchyr   
            sic_bran.uwd132.bchno    = sic_bran.uwm130.bchno   
            sic_bran.uwd132.bchcnt   = sic_bran.uwm130.bchcnt   
            sic_bran.uwd132.benvar   = sicuw.uwd132.benvar     
            sic_bran.uwd132.gap_c    = sicuw.uwd132.gap_c      
            sic_bran.uwd132.prem_c   = sicuw.uwd132.prem_c .  
            IF sic_bran.uwd132.bencod  = "BASE" THEN  
               ASSIGN  nv_basecod = "BASE"
                nv_baseprm = sicuw.uwd132.gap_c    
                nv_basevar = sicuw.uwd132.benvar  .
        END.
    END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2 wgwtdbel 
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
    ASSIGN fi_process = "Create data to base..." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
    IF nv_baseprm = 0  Then  RUN wgs\wgsfbas.
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
        ASSIGN  
            nv_drivvar     = nv_drivcod
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
    ASSIGN 
        nv_seat41 =  wdetail.seat41  
        nv_class  =  wdetail.class.
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                          nv_class,
                          nv_key_b,
                          nv_comdat). 
    ASSIGN nv_41cod1 = "411"
        nv_411var1   = "     PA Driver = "
        nv_411var2   =  STRING(nv_41)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(nv_41)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_41
        nv_412prm  = nv_41.
    Assign
        nv_42var    = " "         /* -------fi_42---------*/
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
    RUN WGS\WGSOPER(INPUT nv_tariff,    /*pass*//*a490166 note modi*/
                          nv_class,     
                          nv_key_b,     
                          nv_comdat).   /*  RUN US\USOPER(INPUT nv_tariff,*/  
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
        nv_bipvar2     =  wdetail.uom1_v             /*STRING(uwm130.uom1_v)*/
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    Assign 
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     =  wdetail.uom2_v             /* STRING(uwm130.uom2_v)*/
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*-------------nv_pdacod--------------------*/
    Assign
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     =  wdetail.uom5_v            /*STRING(uwm130.uom5_v)*/
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    /*--------------- deduct ----------------*/
    ASSIGN dod1 =    np_dedod
          dod2  =    np_addod
        nv_odcod = "DC01"
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
        /*dod0 = 0*/  
        dod0           = np_dedpd    /* durbell */  .
    Run  Wgs\Wgsmx025(INPUT  dod0,  
                             nv_tariff,
                             nv_class,
                             nv_key_b,
                             nv_comdat,
                             nv_cons,
                      OUTPUT nv_prem).
    nv_ded2prm    = nv_prem.
    ASSIGN
        dod0           = np_dedpd    /* durbell */
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
                               deci(wdetail.uom1_v),
                               deci(wdetail.uom2_v),
                               deci(wdetail.uom5_v)).
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
          nv_ncb     = NV_NCBPER
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
                              deci(wdetail.uom1_v),
                              deci(wdetail.uom2_v),
                              deci(wdetail.uom5_v)).
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
                        deci(wdetail.uom1_v),
                        deci(wdetail.uom2_v),
                        deci(wdetail.uom5_v)).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassic wgwtdbel 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 wgwtdbel 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail.vehreg = "" THEN ASSIGN wdetail.vehreg = trim(np_vehreg).
IF wdetail.vehreg = " " THEN 
    ASSIGN wdetail.vehreg = IF wdetail.chassis <> "" THEN 
        "/" + SUBSTRING(trim(wdetail.chassis),LENGTH(trim(wdetail.chassis))  - 8 )
        ELSE "/" .
    /*wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N". */  
IF wdetail.cancel = "ca"  THEN  
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.class = " " THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
ASSIGN 
    NO_CLASS  = trim(wdetail.class) 
    nv_poltyp = trim(wdetail.poltyp).
If no_class  <>  " " Then do:
    FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp =   nv_poltyp       AND
        sicsyac.xmd031.class  =   no_class        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmd031 THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N".
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
        sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
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
ASSIGN 
    nv_sclass = wdetail.class.
If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
/*IF wdetail.prepol = "" THEN DO:
    Find FIRST stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =     trim(wdetail.brand)      And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
        stat.maktab_fil.sclass   =    SUBSTR(wdetail.class,2,3) No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  stat.maktab_fil.body 
        wdetail.Tonn     =  stat.maktab_fil.tons
        wdetail.engcc    =  STRING(stat.maktab_fil.engine)
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        /*wdetail.seat           =  string(stat.maktab_fil.seats)*/  .
END.
ELSE DO:
    Find FIRST stat.maktab_fil Use-index      maktab01        Where
        stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3) And   
        stat.maktab_fil.modcod   =  trim(wdetail.redbook)     No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.brand    =  stat.maktab_fil.moddes  
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  stat.maktab_fil.body 
        wdetail.Tonn     =  stat.maktab_fil.tons
        wdetail.engcc    =  STRING(stat.maktab_fil.engine)
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        /*wdetail.seat           =  string(stat.maktab_fil.seats)*/  .

END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1 wgwtdbel 
PROCEDURE proc_chktest1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail :
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

    IF (wdetail.poltyp = "V72") THEN DO:
        IF wdetail.prepol = ""  THEN  RUN Proc_renew72new .  /* data new 72...*/
        ELSE RUN Proc_renew72 .                           /* data renew... */
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
        IF  wdetail.prepol <> ""  THEN  RUN Proc_renew70.     /* data renew.70.. */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2 wgwtdbel 
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
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN      
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
        ASSIGN 
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = inte(wdetail.fi)
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN 
        sic_bran.uwm130.uom1_v    = deci(wdetail.uom1_v)  
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
        Assign sic_bran.uwm130.uom1_v  =  deci(wdetail.uom1_v)     /*stat.clastab_fil.uom1_si  1000000  */  
            sic_bran.uwm130.uom2_v     =  deci(wdetail.uom2_v)     /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     =  deci(wdetail.uom5_v)     /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  =  deci(wdetail.uom1_v)     /*deci(wdetail2.tp_bi)   */ 
            nv_uom2_v                  =  deci(wdetail.uom2_v)     /*deci(wdetail2.tp_bi2) */  
            nv_uom5_v                  =  deci(wdetail.uom5_v)     /*deci(wdetail2.tp_bi3) */ 
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
        IF wdetail.prepol = "" THEN DO:
            IF substr(wdetail.class,1,1) = "Z" THEN
                ASSIGN 
                nv_41          =  deci(wdetail.nv_41)
                nv_42          =  deci(wdetail.nv_42)
                nv_43          =  deci(wdetail.nv_43)
                nv_seat41      =  deci(wdetail.seat)
                wdetail.seat41 =  deci(wdetail.seat)   .
            ELSE IF  wdetail.garage =  ""  Then
                ASSIGN 
                nv_41          = stat.clastab_fil.si_41unp
                nv_42          = stat.clastab_fil.si_42
                nv_43          = stat.clastab_fil.si_43
                nv_seat41      = stat.clastab_fil.dri_41 + clastab_fil.pass_41
                wdetail.seat41 = stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
            Else If  wdetail.garage  =  "G"  Then
                Assign 
                nv_41       =  stat.clastab_fil.si_41pai
                nv_42       =  stat.clastab_fil.si_42
                nv_43       =  stat.clastab_fil.impsi_43
                nv_seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41
                wdetail.seat41 =  stat.clastab_fil.dri_41 + clastab_fil.pass_41 .  
        END.
    END.   
    ASSIGN  
        nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                                nv_riskno,
                                nv_itemno).
    END.   /* end Do transaction*/
    ASSIGN  s_recid3  = RECID(sic_bran.uwm130)
        nv_covcod     = wdetail.covcod
        nv_newsck     = " ".
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
      /*sic_bran.uwm301.trareg    = trim(wdetail.vehreg)*/ /*A58-0206 */
        sic_bran.uwm301.trareg    = trim(nv_uwm301trareg)  /*A58-0206 */
        sic_bran.uwm301.eng_no    = trim(wdetail.engno)
        sic_bran.uwm301.Tons      = INTEGER(wdetail.Tonn)
        sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
        sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage    = trim(wdetail.garage)
        sic_bran.uwm301.body      = trim(wdetail.body)
        sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv41seat  = wdetail.seat41
        sic_bran.uwm301.mv_ben83  = IF wdetail.poltyp = "v70" THEN trim(wdetail.benname) ELSE ""
        /*sic_bran.uwm301.vehreg    = trim(wdetail.vehreg) */            /*A58-0206 */
        sic_bran.uwm301.vehreg    = substr(trim(wdetail.vehreg),1,11)    /*A58-0206 */
        sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse    = wdetail.vehuse
        sic_bran.uwm301.moddes    = np_moddes
        sic_bran.uwm301.modcod    = wdetail.redbook                                    
        sic_bran.uwm301.vehgrp    = wdetail.cargrp
        sic_bran.uwm301.sckno     = 0
        sic_bran.uwm301.itmdel    = NO  
        wdetail.tariff            = sic_bran.uwm301.tariff 
        sic_bran.uwm301.prmtxt    = wdetail.prmtxt .
    /*FIND FIRST wacctext WHERE wacctext.n_policytxt = wdetail.policy NO-LOCK NO-ERROR NO-WAIT.
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
    ELSE sic_bran.uwm301.prmtxt = "".*/
    IF wdetail.compul = "y" THEN DO:
        sic_bran.uwm301.cert = "".
        IF LENGTH(wdetail.stk) = 11 THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
        IF LENGTH(wdetail.stk) = 13  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
        IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".
        ELSE DO:
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
    END.
    ASSIGN 
        sic_bran.uwm301.bchyr  = nv_batchyr      /* batch Year */
        sic_bran.uwm301.bchno  = nv_batchno      /* bchno      */
        sic_bran.uwm301.bchcnt = nv_batcnt    .  /* bchcnt     */
    s_recid4         = RECID(sic_bran.uwm301) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest3 wgwtdbel 
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
    nv_class     = substr(wdetail.class,2,3) 
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
      nv_pdacod   = ""   .
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff,  /*pass*/
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
/*IF fi_policymas <> ""   THEN RUN proc_assign_polmas.*/
/*IF      ra_renewby = 1 THEN RUN proc_assign_polexp.
ELSE IF ra_renewby = 2 THEN RUN proc_assign_polmas.*/
RUN proc_uwm100.
RUN proc_uwm120.
RUN proc_uwm301.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4 wgwtdbel 
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
 ASSIGN fi_process = "Updat to uwm120 stamp tax ..." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
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
  END. 
  /***--- Commmission Rate Line 72 ---***/
  IF wdetail.compul = "y" THEN DO:
      ASSIGN nv_com2p = 0.
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
  IF sic_bran.uwm120.stmpae  = Yes Then do: 
       /* STAMP */ 
                  nv_fi_rstp_t  = Truncate(sic_bran.uwm120.prem_r * nv_fi_stamp_per / 100,0) +
                      (IF     (sic_bran.uwm120.prem_r * nv_fi_stamp_per / 100)   -
                     Truncate(sic_bran.uwm120.prem_r  * nv_fi_stamp_per / 100,0) > 0
                     Then 1 Else 0).
    
  End.
  sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
     
  IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
      nv_fi_rtax_t  = (sic_bran.uwm120.prem_r + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
     /* MESSAGE "sic_bran.uwm120.prem_r  "  sic_bran.uwm120.prem_r
              "nv_fi_rstp_t + "          nv_fi_rstp_t         
              "sic_bran.uwm100.pstp  "    sic_bran.uwm100.pstp  
              "nv_fi_tax_per  "          nv_fi_tax_per     VIEW-AS ALERT-BOX.    */
       /* fi_taxae       = Yes.*/
  End.
  sic_bran.uwm100.rtax_t = nv_fi_rtax_t.
  sic_bran.uwm120.com1ae = YES.
  sic_bran.uwm120.com2ae = YES.
  /*--------- motor commission -----------------*/
 
  IF sic_bran.uwm120.com1ae   = Yes  Then do:                   /* MOTOR COMMISION */
     If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
     ASSIGN nv_com1p = 0.00.  /*งาน kk ให้ค่า  com1A = 0.00 */
     nv_fi_com1_t   =  - (sic_bran.uwm120.prem_r - nt_compprm) * nv_com1p / 100.            
         /*fi_com1ae        =  YES.*/
  End.
  /*----------- comp comission ------------*/
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then nv_com2p  = 0.00.
         /* nv_com2p  = sic_bran.uwm120.com2p.*/
           nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.              
         /*nv_fi_com2ae        =  YES.*/
  End.
  IF sic_bran.uwm100.pstp <> 0 Then do:
     IF sic_bran.uwm100.no_sch  = 1 Then NV_fi_dup_trip = "D".
     Else If sic_bran.uwm100.no_sch  = 2 Then  NV_fi_dup_trip = "T".
  End.
  Else  NV_fi_dup_trip  =  "".
  nv_fi_netprm = sic_bran.uwm120.prem_r + sic_bran.uwm100.rtax_t
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create100 wgwtdbel 
PROCEDURE proc_create100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Create  sic_bran.uwm100.    /*Create ฝั่ง gateway*/    
ASSIGN                                              
       sic_bran.uwm100.policy =  CAPS(trim(wdetail.policy))                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
       sic_bran.uwm100.rencnt =  n_rencnt   
       sic_bran.uwm100.renno  =  ""       
       sic_bran.uwm100.endcnt =  n_Endcnt
       sic_bran.uwm100.bchyr  =  nv_batchyr 
       sic_bran.uwm100.bchno  =  nv_batchno 
       sic_bran.uwm100.bchcnt =  nv_batcnt     .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create72 wgwtdbel 
PROCEDURE proc_create72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FIND FIRST wdetail WHERE wdetail.policy = trim(n_policy72) NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.policy      = trim(n_policy72)
        wdetail.prepol      = TRIM(n_policy72)  
        wdetail.vehreg      = trim(n_vehreg)  
        wdetail.comdat      = trim(n_comdat)  
        wdetail.expdat      = trim(n_expdat)  
        wdetail.premt       = TRIM(n_premtnet)
        /*n_stmp    
        n_tax    */ 
        wdetail.poltyp      = "V72"
        wdetail.covcod      = "T"    
        wdetail.pass        = "y" .
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initdata wgwtdbel 
PROCEDURE proc_initdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    n_policy     = ""    /*  เลขกรมธรรม์ใหม่ */               
    n_prepol     = ""    /*  เลขกรมธรรม์ต่ออายุ*/    
    n_poltyp     = ""    /*  Policytype      */               
    n_vehreg     = ""    /*  ทะเบียน */                       
    n_comdat     = ""    /*  วันเริ่มคุ้มครอง*/    
    n_expdat     = ""    /*  วันหมดอายุ      */            
    n_premtnet   = ""    /*  Net Premium     */            
    n_stmp       = ""    /*  stmp    */                       
    n_tax        = ""    /*  vat     */                       
    np_insref    = ""    /*  Insd..  */                       
    np_producer  = ""    /*  Producer*/            
    np_agent     = ""    /*  Agent   */                       
    np_class     = ""    /*  คลาสรถ  */                       
    np_cha_no    = ""    /*  เลขถัง  */                       
    np_eng_no    = ""    /*  เลขเครื่องยนต์*/              
    np_yrmanu    = ""    /*  ปีรถ    */                    
    np_brand     = ""    /*  ยี่ห้อ-รุ่นรถ*/              
    np_engine    = ""    /*  Engine CC's..*/              
    np_tons      = ""    /*  Tonnage..    */              
    np_seats     = ""    /*  Seats.. */     
    np_textf18   = ""    /*  F18 */
    /*n_policy70   = ""  */ 
    n_vehreg     = ""  
    /*n_policy72   = "" */ 
    n_vehreg     = ""  
    n_comdat     = ""  
    n_expdat     = ""  
    n_premtnet   = ""  
    n_stmp       = ""  
    n_tax        = ""  
    n_idno       = ""       
    /*n_policy70   = ""       
    n_policy72   = ""   */    
    n_branch     = ""  
    n_cover      = ""  
    n_textf7     = ""  
    n_textf5     = ""
    n_com70      = ""  
    n_com72      = ""  
    n_class70    = ""  
    n_class72    = ""  
    n_seat1      = "" 
    n_uom1_v     = ""  
    n_uom2_v     = ""  
    n_uom5_v     = ""  
    n_siins      = ""  
    n_fi         = ""  
    n_nv_41      = ""  
    n_nv_42      = ""  
    n_nv_43      = "" 
    n_ncb        = ""    
    n_feet       = ""    
    n_dspc       = ""    
    n_base       = ""  
    n_vehreg     = ""  
    n_brand1     = ""  
    n_model1     = ""  
    n_chassis    = ""  
    n_engno      = ""  
    n_caryear    = ""  
    n_comdat1    = ""  
    n_expdat1    = ""  
    n_benname    = ""
    n_textacc    = "" 
    nf_vehuse70  = ""     
    nf_vehuse70  = "" .  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open wgwtdbel 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policy wgwtdbel 
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
            stklen = INDEX(trim(wdetail.stk)," ") - 1.
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
        /* check renpol only....by renew...
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN wdetail.pass = "N"
                wdetail.comment     = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning     = "Program Running Policy No. ให้ชั่วคราว".
        END.*/
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        ELSE RUN proc_create100.
    END.   /*wdetail.stk  <>  ""*/
    ELSE DO:  /* sticker = ""  */ 
        /*FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
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
            ELSE RUN proc_create100. 
        END.
        ELSE RUN proc_create100.*/  
        RUN proc_create100.  
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
        /*FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass = "N"
                wdetail.comment      = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning      = "Program Running Policy No. ให้ชั่วคราว".
        END.*/
        nv_newsck = " ".
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
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.       /*wdetail.stk  <>  ""*/
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
    ASSIGN nv_docno = wdetail.Docno
    nv_accdat       = TODAY.
ELSE DO:
        IF wdetail.docno  = "" THEN nv_docno  = "".
        IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
IF wdetail.inserf <> "" THEN DO:
    FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
        sicsyac.xmm600.acno = TRIM(wdetail.inserf) NO-LOCK NO-ERROR NO-WAIT .
    IF AVAIL sicsyac.xmm600  THEN wdetail.nv_icno = sicsyac.xmm600.icno.
    ELSE wdetail.nv_icno = "".
END.
DO TRANSACTION:                                                                        
    ASSIGN                                                                             
        sic_bran.uwm100.renno  = ""                                                      
        sic_bran.uwm100.endno  = ""                                                      
        sic_bran.uwm100.poltyp = wdetail.poltyp                                          
        sic_bran.uwm100.insref = caps(TRIM(wdetail.inserf))                                             
        sic_bran.uwm100.opnpol = trim(np_occupn)
        sic_bran.uwm100.anam2  = trim(wdetail.nv_icno)             
        sic_bran.uwm100.ntitle = trim(wdetail.tiname)        
        sic_bran.uwm100.name1  = trim(wdetail.insnam)        
        sic_bran.uwm100.name2  = trim(wdetail.name2)                                     
        sic_bran.uwm100.name3  = trim(wdetail.name3)        
        sic_bran.uwm100.addr1  = trim(wdetail.n_addr1)             
        sic_bran.uwm100.addr2  = trim(wdetail.n_addr2)       
        sic_bran.uwm100.addr3  = trim(wdetail.n_addr3)       
        sic_bran.uwm100.addr4  = trim(wdetail.n_addr4)       
        sic_bran.uwm100.postcd = ""                          
        sic_bran.uwm100.undyr  = String(Year(today),"9999")  /*   nv_undyr  */
        sic_bran.uwm100.branch = trim(wdetail.n_branch)      /*trim(wdetail.n_branch)*//* nv_branch  */                        
        sic_bran.uwm100.dept   = nv_dept                     
        sic_bran.uwm100.usrid  = USERID(LDBNAME(1))          
        sic_bran.uwm100.fstdat = IF n_rencnt = 0 THEN  DATE(wdetail.comdat)    ELSE DATE(wdetail.fristdat)      /*DATE(wdetail.comdat) ให้ firstdate*/
        sic_bran.uwm100.comdat = DATE(wdetail.comdat)        
        sic_bran.uwm100.expdat = DATE(wdetail.expdat)        
        sic_bran.uwm100.accdat = nv_accdat                   
        sic_bran.uwm100.tranty = "N"                         /*Transaction Type (N/R/E/C/T)*/
        sic_bran.uwm100.langug = "T"                         
        sic_bran.uwm100.acctim = "00:00"                     
        sic_bran.uwm100.trty11 = "M"                         
        sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")  
        sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")     
        sic_bran.uwm100.entdat = TODAY                       
        sic_bran.uwm100.curbil = "BHT"                       
        sic_bran.uwm100.curate = 1                           
        sic_bran.uwm100.instot = 1                           
        sic_bran.uwm100.prog   = "wgwtdbel"                  
        sic_bran.uwm100.cntry  = "TH"                        /*Country where risk is situated*/
        sic_bran.uwm100.insddr = YES                         /*Print Insd. Name on DrN       */
        sic_bran.uwm100.no_sch = 0                           /*No. to print, Schedule        */
        sic_bran.uwm100.no_dr  = 1                           /*No. to print, Dr/Cr Note      */
        sic_bran.uwm100.no_ri  = 0                           /*No. to print, RI Appln        */
        sic_bran.uwm100.no_cer = 0                           /*No. to print, Certificate     */
        sic_bran.uwm100.li_sch = YES                         /*Print Later/Imm., Schedule    */
        sic_bran.uwm100.li_dr  = YES                         /*Print Later/Imm., Dr/Cr Note  */
        sic_bran.uwm100.li_ri  = YES                         /*Print Later/Imm., RI Appln,   */
        sic_bran.uwm100.li_cer = YES                         /*Print Later/Imm., Certificate */
        sic_bran.uwm100.apptax = YES                         /*Apply risk level tax (Y/N)    */
        sic_bran.uwm100.recip  = "N"                         /*Reciprocal (Y/N/C)            */
        sic_bran.uwm100.short  = NO                          
        sic_bran.uwm100.acno1  = trim(wdetail.producer)      /*nv_acno1 */
        sic_bran.uwm100.agent  = trim(wdetail.agent)         /*nv_agent */
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
        sic_bran.uwm100.cr_2   = ""                     /*wdetail.cr_2*/
        sic_bran.uwm100.bchyr  = nv_batchyr              /*Batch Year */  
        sic_bran.uwm100.bchno  = nv_batchno              /*Batch No.  */  
        sic_bran.uwm100.bchcnt = nv_batcnt               /*Batch Count*/  
        sic_bran.uwm100.prvpol = caps(trim(wdetail.prepol))   
        sic_bran.uwm100.cedpol = np_cedpol    
        sic_bran.uwm100.finint = ""
        sic_bran.uwm100.bs_cd  = ""      /*trim(wdetail.vatcode)*/
        sic_bran.uwm100.opnpol = "" . 
    IF wdetail.pass = "Y" THEN
        sic_bran.uwm100.impflg  = YES.
    ELSE sic_bran.uwm100.impflg  = NO.
    IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN  sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
    IF wdetail.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
    ELSE  sic_bran.uwm100.polsta = "IF".
    IF fi_loaddat <> ? THEN sic_bran.uwm100.trndat = fi_loaddat.
    ELSE sic_bran.uwm100.trndat = TODAY.
    sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
    nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                      (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                      (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                  ELSE (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1 .   
END.     /*transaction*//**/
IF wdetail.nmember <> "" THEN  RUN proc_uwd102_1.
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
    RUN wgw/wgwad120 (INPUT  sic_bran.uwm100.policy,   /***--- A490166 Note Modi ---***/
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
        sic_bran.uwm120.bchyr  = nv_batchyr         /* batch Year */
        sic_bran.uwm120.bchno  = nv_batchno         /* bchno    */
        sic_bran.uwm120.bchcnt = nv_batcnt .        /* bchcnt     */
    ASSIGN
        sic_bran.uwm120.class  = wdetail.class 
        s_recid2     = RECID(sic_bran.uwm120).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_renew70 wgwtdbel 
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
        ASSIGN wdetail.comment = wdetail.comment + "|กรมธรรม์มีการต่ออายุแล้ว : " + wdetail.policy
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
    ELSE DO: 
        ASSIGN   
            n_rencnt         = sicuw.uwm100.rencnt  +  1
            n_endcnt         = 0   
            wdetail.n_rencnt = sicuw.uwm100.rencnt  +  1    
            wdetail.n_endcnt = 0 . 
        RUN proc_assignrenew_pol.                                
    END.
END.
Else do:  
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0
        wdetail.n_rencnt = 0
        wdetail.n_endcnt = 0 
        wdetail.comment  = wdetail.comment + "|ไม่พบกรมธรรม์: " + wdetail.policy
        wdetail.pass     = "N"     
        wdetail.OK_GEN   = "N".
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_renew72 wgwtdbel 
PROCEDURE Proc_renew72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail.prepol   No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF uwm100.releas = NO THEN DO:
        ASSIGN wdetail.comment = wdetail.comment + "|ยังไม่ได้ทำการโอนไป บ/ช ไม่สามารถทำงานต่ออายุได้: " + wdetail.policy
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
        NEXT.
    END.
    IF sicuw.uwm100.renpol <> " " THEN DO: 
        ASSIGN wdetail.comment = wdetail.comment + "|กรมธรรณ์มีการต่ออายุแล้ว : " + wdetail.policy
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
        NEXT.
    END.
    ELSE DO: 
        /*-RUN proc_assignrenew72.  */                              
        ASSIGN 
            n_rencnt         = sicuw.uwm100.rencnt  +  1
            n_endcnt         = 0   
            wdetail.n_rencnt = sicuw.uwm100.rencnt  +  1    
            wdetail.n_endcnt = 0 
            wdetail.n_branch = sicuw.uwm100.branch   /*  np_branch       */     
            wdetail.producer = sicuw.uwm100.acno1    /*  np_producer     */ 
            wdetail.agent    = sicuw.uwm100.agent    /*  np_agent        */ 
            np_langug        = sicuw.uwm100.langug   /*  np_langug       */      
            wdetail.inserf   = sicuw.uwm100.insref   /*  np_insref       */ 
            wdetail.tiname   = sicuw.uwm100.ntitle   /*  np_title        */ 
            wdetail.insnam   = sicuw.uwm100.name1    /*  np_name1        */ 
            wdetail.name2    = sicuw.uwm100.name2    /*  np_name2        */ 
            wdetail.name3    = sicuw.uwm100.name3    /*  np_name3        */ 
            wdetail.n_addr1  = sicuw.uwm100.addr1    /*  np_addr1        */ 
            wdetail.n_addr2  = sicuw.uwm100.addr2    /*  np_addr2        */ 
            wdetail.n_addr3  = sicuw.uwm100.addr3    /*  np_addr3        */ 
            wdetail.n_addr4  = sicuw.uwm100.addr4    /*  np_addr4        */ 
            np_occupn        = sicuw.uwm100.occupn   /*  np_occupn       */ 
            /*wdetail.comdat =     /*  np_comdat     */ 
            wdetail.expdat   =     /*  np_expdat     */ */
            wdetail.fristdat = string(sicuw.uwm100.fstdat,"99/99/9999")   /*  np_firstdat     */ 
            np_cedpol        = sicuw.uwm100.cedpol.  /*  np_cedpol       */ 
        FIND LAST  sicuw.uwm120  WHERE
            sicuw.uwm120.policy = sicuw.uwm100.policy   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE uwm120 THEN DO: 
            ASSIGN wdetail.class = sicuw.uwm120.class .     /*  np_class        */ 
            FIND LAST sicuw.uwm301 WHERE
                sicuw.uwm301.policy  = sicuw.uwm120.policy  AND
                sicuw.uwm301.rencnt  = sicuw.uwm120.rencnt  AND
                sicuw.uwm301.endcnt  = sicuw.uwm120.endcnt  AND
                sicuw.uwm301.riskgp  = sicuw.uwm120.riskgp  AND
                sicuw.uwm301.riskno  = sicuw.uwm120.riskno  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN
                ASSIGN 
                wdetail.redbook      = sicuw.uwm301.modcod          /*  np_redbook */ 
                np_moddes            = sicuw.uwm301.moddes          /*  np_moddes  */ 
                wdetail.caryear      = string(sicuw.uwm301.yrmanu)  /*  np_yrmanu  */ 
                wdetail.cargrp       = sicuw.uwm301.vehgrp          /*  np_vehgrp  */ 
                wdetail.body         = sicuw.uwm301.body            /*  np_body    */ 
                wdetail.engcc        = STRING(sicuw.uwm301.engine)  /*  np_engine  */ 
                wdetail.Tonn         = sicuw.uwm301.tons            /*  np_tons    */ 
                wdetail.seat         = string(sicuw.uwm301.seats)   /*  np_seats   */ 
                wdetail.vehuse       = sicuw.uwm301.vehuse     /*  np_vehuse  */ 
                wdetail.covcod       =  "T"                    /*  np_covcod  */ 
                wdetail.garage       = sicuw.uwm301.garage     /*  np_garage  */ 
                np_vehreg            = sicuw.uwm301.vehreg     /*  np_vehreg  */ 
                wdetail.chassis      = sicuw.uwm301.cha_no     /*  np_cha_no  */ 
                wdetail.engno        = sicuw.uwm301.eng_no     /*  np_eng_no  */ 
                wdetail.seat41       = sicuw.uwm301.mv41seat   /*  np_seat41       */ 
                /*np_ncbyrs,            /*  np_ncbyrs     */   */
                wdetail.benname      = sicuw.uwm301.mv_ben83   /*  np_bennam1      */ 
                wdetail.prmtxt       = sicuw.uwm301.prmtxt .   /*  np_prmtxt       */ 
        END.
        ELSE ASSIGN wdetail.class = "".
    END.
END.
Else do:  
    ASSIGN
        wdetail.comment = wdetail.comment + "|ไม่พบข้อมูลเบอร์กรมธรรม์: " + wdetail.policy
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
    NEXT.
        /*n_rencnt  =  0  
        n_Endcnt  =  0
        wdetail.n_rencnt = 0
        wdetail.n_endcnt = 0 .*/
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_renew72new wgwtdbel 
PROCEDURE Proc_renew72new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail.inserf <> "" THEN DO:            /* 72 new */
    FIND LAST sicsyac.xmm600 USE-INDEX xmm60001  WHERE
        sicsyac.xmm600.acno  =  wdetail.inserf   NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            
    END.
    ELSE DO:
        ASSIGN 
            n_rencnt         = 0
            n_endcnt         = 0   
            wdetail.n_rencnt = 0
            wdetail.n_endcnt = 0 
            wdetail.n_branch = "M"                    /*  np_branch       */     
            wdetail.tiname   = sicsyac.xmm600.ntitle  /*  np_title        */ 
            wdetail.insnam   = sicsyac.xmm600.name    /*  np_name1        */ 
            wdetail.name2    = ""                     /*  np_name2        */ 
            wdetail.name3    = ""                     /*  np_name3        */ 
            wdetail.n_addr1  = sicsyac.xmm600.addr1   /*  np_addr1        */ 
            wdetail.n_addr2  = sicsyac.xmm600.addr2   /*  np_addr2        */ 
            wdetail.n_addr3  = sicsyac.xmm600.addr3   /*  np_addr3        */ 
            wdetail.n_addr4  = sicsyac.xmm600.addr4   /*  np_addr4        */ 
            np_occupn        = ""                     /*  np_occupn       */
            wdetail.nv_icno  = sicsyac.xmm600.icno    
            wdetail.fristdat = wdetail.comdat         
            np_cedpol        = ""                     /*  np_cedpol  */ 
            np_moddes        = ""                     /*  np_moddes  */ 
            wdetail.vehuse   = "1"                    /*  np_vehuse  */ 
            wdetail.covcod   = "T"                    /*  np_covcod  */ 
            wdetail.garage   = ""                     /*  np_garage  */ 
            np_vehreg        = ""  .                  /*  np_vehreg  */ 
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 wgwtdbel 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT2 wgwtdbel 
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
            wdetail.policy   ","
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen wgwtdbel 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 wgwtdbel 
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
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*//*Comment A62-0105*/    
      /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.   */
      CLEAR FRAME nf00.
      HIDE FRAME nf00.
      RETURN. 
   END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_TempPolicy wgwtdbel 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_usdcod wgwtdbel 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 wgwtdbel 
PROCEDURE proc_uwd100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
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
FIND LAST sicuw.uwm100  USE-INDEX uwm10001 
    WHERE uwm100.policy     = fi_policymas NO-LOCK NO-ERROR.
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
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100_1 wgwtdbel 
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
    nv_txt1  = wdetail.textf7
    nv_txt2  = ""
    nv_txt3  = ""
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
     sic_bran.uwm100.policy  = wdetail.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt        AND
     sic_bran.uwm100.endcnt  = n_endcnt        AND
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 wgwtdbel 
PROCEDURE proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
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
FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE uwm100.policy =  fi_policymas   NO-LOCK NO-ERROR.
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
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102_1 wgwtdbel 
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
ASSIGN nv_fptr = 0
       nv_bptr = 0
       nv_nptr = 0
       nv_line1 = 1  .
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
DO WHILE nv_line1 <= 11:
    CREATE wuppertxt3.                                                                                 
    wuppertxt3.line = nv_line1.     
    IF nv_line1 = 1  THEN wuppertxt3.txt = "".   
    IF nv_line1 = 2  THEN wuppertxt3.txt =  wdetail.nmember .                                          
    /*IF nv_line1 = 3  THEN wuppertxt3.txt =  "สาขา : "  + SUBSTR(wdetail.nmember2,index(wdetail.nmember2,"-:") + 2,R-INDEX(wdetail.nmember2,":") - index(wdetail.nmember2,"-:") - 2 ) + 
                                            " ชื่อเจ้าหน้าที่ MKT: " + SUBSTR(wdetail.nmember2,r-index(wdetail.nmember2,":") + 1 ). 
    IF nv_line1 = 4  THEN wuppertxt3.txt =  wdetail.campaign .                                         
    IF nv_line1 = 5  THEN wuppertxt3.txt =  wdetail.notiuser  .
    IF nv_line1 = 6  THEN wuppertxt3.txt =  "STK : " +  wdetail.stk  .                                 
    IF nv_line1 = 7  THEN wuppertxt3.txt =  "เลขที่สัญญา : " +  wdetail.cedpol .     
    IF nv_line1 = 8  THEN wuppertxt3.txt =  "เลขที่ตรวจสภาพ : " +  wdetail.ispno.
    IF nv_line1 = 9  THEN wuppertxt3.txt =  "ProductType : " + wdetail.product.
    IF nv_line1 = 10 THEN wuppertxt3.txt =  trim(wdetail.remak1)*/ .
                                            
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd132 wgwtdbel 
PROCEDURE proc_uwd132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm100 wgwtdbel 
PROCEDURE proc_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm120 wgwtdbel 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm301 wgwtdbel 
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
  
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var wgwtdbel 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wgw72013 wgwtdbel 
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
/*
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
         sicsyac.xmm031.poltyp EQ sic_bran.uwm100.poltyp NO-LOCK NO-ERROR.
    IF AVAILABLE sicsyac.xmm031 THEN DO:
       IF n_dcover = 365  THEN   
      n_ddyr   = YEAR(TODAY).
      n_ddyr1  = n_ddyr + 1.
      n_dyear  = 365.   
      FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
           sicsyac.xmm105.tariff EQ nvtariff      AND
           sicsyac.xmm105.bencod EQ sic_bran.uwd132.bencod  NO-LOCK NO-ERROR.
      IF  sic_bran.uwm100.short = NO OR sicsyac.xmm105.shorta = NO THEN DO:
          sic_bran.uwd132.prem_c = (n_orgnap * n_dcover) / n_dyear .  
      END.
      ELSE DO:
        FIND FIRST sicsyac.xmm127 USE-INDEX xmm12701     WHERE
                   sicsyac.xmm127.poltyp =  sic_bran.uwm100.poltyp AND
                   sicsyac.xmm127.daymth =  YES                    AND
                   sicsyac.xmm127.nodays GE n_dcover               NO-LOCK NO-ERROR.
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
                     sicsyac.xmm127.nodays GE n_dmonth      NO-LOCK NO-ERROR.
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
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

