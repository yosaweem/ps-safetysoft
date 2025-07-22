&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases  sic_test         PROGRESS */                
File: 
Description: 
Input Parameters:  <none>
Output Parameters: <none>
Author: 
Created: ---------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure.                  */
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */  
/*programid   : wgwtbgen.w                                              */ 
/*programname : Load text file tib to GW [Toyota ]                      */ 
/* Copyright  : Safety Insurance Public Company Limited                 */
/*copy write  : wgwargen.w                                              */ 
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                      */
/*create by   : Kridtiya i. A52-0182   date . 14/06/2010                */
/*              ปรับโปรแกรมให้สามารถนำเข้า text file TIB to GW system   */ 
/*             proc_definition  */
/*modify by   : Kridtiya i. A54-0112 ขยายช่องทะเบียนรถ จาก 10 เป็น 11 หลัก */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
DEF VAR aa  AS DECI .
DEF NEW SHARED VAR nv_producer AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR nv_agent    AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno. 
DEFINE VAR n_ratmin    AS INTE INIT 0.
DEFINE VAR n_ratmax    AS INTE INIT 0.
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
{wgw\wgwtbgen.i}      /*ประกาศตัวแปร*/
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
DEF VAR nv_uwm301trareg    LIKE sicuw.uwm301.cha_no INIT "".
DEF  VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO.
DEF  VAR gv_sp2 AS CHAR FORMAT "x(2)" NO-UNDO.
DEF  VAR gv_ver AS CHAR NO-UNDO.
DEF  VAR gv_prdid AS CHAR FORMAT "x(40)" NO-UNDO.
DEF  VAR gv_sp1 AS CHAR FORMAT "x(1)" NO-UNDO.
DEF  VAR gv_date AS DATE NO-UNDO.
DEF  VAR gv_time AS CHAR NO-UNDO.
DEF VAR nv_pwd AS CHAR NO-UNDO.
DEF VAR nv_log AS CHAR FORMAT "X(100)".
DEF VAR n_db AS CHAR FORMAT "X(10)".
DEF WORKFILE wk_db
    FIELD phyname  AS CHAR FORMAT "x(10)"
    FIELD unixpara AS CHAR FORMAT "x(10)".
DEF VAR n_wdetail  AS INTE INIT 0.  /*kridtiy . A53-0310 */
DEF VAR n_stk70tex  AS CHAR FORMAT "x(25)" INIT "".  /*kridtiy . A54-0062 */
DEF VAR n_prem  AS DECI.

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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.poltyp wdetail.policy wdetail.renpol wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.add1 wdetail.add2 wdetail.add3 wdetail.add4 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.eng wdetail.chasno wdetail.caryear wdetail.re_country wdetail.vehuse wdetail.garage wdetail.stk wdetail.access wdetail.covcod wdetail.si wdetail.fleet wdetail.ncb wdetail.deductda wdetail.deductpd wdetail.benname wdetail.n_IMPORT wdetail.n_export wdetail.drivnam wdetail.producer wdetail.agent wdetail.comment WDETAIL.WARNING wdetail.cancel wdetail.redbook /*add new*/   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_wdetail fi_process ra_renewby fi_loaddat ~
fi_pack fi_branch fi_producer fi_agent fi_prevbat fi_bchyr fi_filename ~
bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit ~
bu_hpbrn bu_hpacno1 bu_hpagent fi_campaign RECT-370 RECT-372 RECT-373 ~
RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_process ra_renewby fi_loaddat fi_pack ~
fi_branch fi_producer fi_bchno fi_agent fi_prevbat fi_bchyr fi_filename ~
fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt ~
fi_proname fi_agtname fi_completecnt fi_premtot fi_premsuc fi_campaign 

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

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 5 BY 1.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY 1
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(19)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY 1
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 69 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 69 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 69 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 69 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
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
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 81.5 BY 1
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY 1
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_renewby AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Renew by policy", 1,
"Renew by Chassis", 2
     SIZE 42 BY 1
     BGCOLOR 153  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.5 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.5 BY 12.71
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.5 BY 5.71
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.5 BY 3.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-375
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 121.5 BY 3.1
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18 BY 2.24
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18 BY 2.24
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
      wdetail.poltyp  COLUMN-LABEL "Policy Type"
        wdetail.policy  COLUMN-LABEL "Policy"
        wdetail.renpol  COLUMN-LABEL "Renew Policy"
        wdetail.tiname  COLUMN-LABEL "Title Name"   
        wdetail.insnam  COLUMN-LABEL "Insured Name" 
        wdetail.comdat  COLUMN-LABEL "Comm Date"
        wdetail.expdat  COLUMN-LABEL "Expiry Date"
        wdetail.compul  COLUMN-LABEL "Compulsory"

        wdetail.add1   COLUMN-LABEL "Ins Add1"
        wdetail.add2   COLUMN-LABEL "Ins Add2"
        wdetail.add3   COLUMN-LABEL "Ins Add3"
        wdetail.add4   COLUMN-LABEL "Ins Add4"
        wdetail.prempa  COLUMN-LABEL "Premium Package"
        wdetail.subclass COLUMN-LABEL "Sub Class"
        wdetail.brand   COLUMN-LABEL "Brand"
        wdetail.model   COLUMN-LABEL "Model"
        wdetail.cc      COLUMN-LABEL "CC"
        wdetail.weight  COLUMN-LABEL "Weight"
        wdetail.seat    COLUMN-LABEL "Seat"
        wdetail.body    COLUMN-LABEL "Body"
        wdetail.vehreg  COLUMN-LABEL "Vehicle Register"
        wdetail.eng     COLUMN-LABEL "Engine NO."
        wdetail.chasno  COLUMN-LABEL "Chassis NO."
        wdetail.caryear COLUMN-LABEL "Car Year" 
        wdetail.re_country  COLUMN-LABEL "Car Province"
        wdetail.vehuse  COLUMN-LABEL "Vehicle Use" 
        wdetail.garage  COLUMN-LABEL "Garage"
        wdetail.stk     COLUMN-LABEL "Sticker"
        wdetail.access  COLUMN-LABEL "Accessories"
        wdetail.covcod  COLUMN-LABEL "Cover Type"
        wdetail.si      COLUMN-LABEL "Sum Insure"
        wdetail.fleet   COLUMN-LABEL "Fleet"
        wdetail.ncb     COLUMN-LABEL "NCB"
        wdetail.deductda COLUMN-LABEL "Deduct DA"
        wdetail.deductpd COLUMN-LABEL "Deduct PD"
        wdetail.benname COLUMN-LABEL "Benefit Name" 
        wdetail.n_IMPORT COLUMN-LABEL "Import"
        wdetail.n_export COLUMN-LABEL "Export"
        wdetail.drivnam  COLUMN-LABEL "Driver Name"
        wdetail.producer COLUMN-LABEL "Producer"
        wdetail.agent    COLUMN-LABEL "Agent"
        wdetail.comment FORMAT "x(35)" COLUMN-BGCOLOR  80 COLUMN-LABEL "Comment"
        WDETAIL.WARNING   COLUMN-LABEL "Warning"

        wdetail.cancel  COLUMN-LABEL "Cancel"
        wdetail.redbook COLUMN-LABEL "RedBook"  /*add new*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128.5 BY 5.24
         BGCOLOR 15 FONT 6.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_wdetail AT ROW 15.57 COL 2.5
     fi_process AT ROW 14 COL 15.17 COLON-ALIGNED NO-LABEL
     ra_renewby AT ROW 2.95 COL 86 NO-LABEL
     fi_loaddat AT ROW 2.95 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 2.95 COL 79.33 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.05 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.14 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.29 COL 17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agent AT ROW 6.24 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 7.33 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 7.33 COL 61 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 8.43 COL 27.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 8.43 COL 99.17
     fi_output1 AT ROW 9.57 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 10.67 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 11.76 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 12.86 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 12.86 COL 66.83 NO-LABEL
     buok AT ROW 9.48 COL 109
     bu_exit AT ROW 11.95 COL 109
     fi_brndes AT ROW 4.05 COL 47.33 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 4.05 COL 36.5
     bu_hpacno1 AT ROW 5.14 COL 44.33
     fi_impcnt AT ROW 21.71 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpagent AT ROW 6.24 COL 44.33
     fi_proname AT ROW 5.14 COL 47.33 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6.24 COL 47.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 22.71 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 21.71 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 22.76 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_campaign AT ROW 2.95 COL 53 COLON-ALIGNED NO-LABEL
     "                     Branch  :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 4.05 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.29 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 22.71 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "       Batch File Name  :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 11.76 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "              Agent Code  :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 6.24 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 21.71 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 2.95 COL 70.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "    Policy Import Total  :":60 VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 12.86 COL 28 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TieS 4 01/03/2022" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 14 COL 107.67 WIDGET-ID 2
          BGCOLOR 8 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 12.86 COL 84.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.71 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY 1 AT ROW 7.33 COL 61.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 21.71 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "         Producer  Code  :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 5.14 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Output Data Load  :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 9.57 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "Campaign :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 2.95 COL 44
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY 1 AT ROW 12.86 COL 65.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 10.67 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "Input File Name Load  :" VIEW-AS TEXT
          SIZE 23 BY 1.05 AT ROW 8.43 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    IMPORT TEXT FILE MOTOR [TIB-TOYOTA AND HINO ]" VIEW-AS TEXT
          SIZE 126 BY .95 AT ROW 1.29 COL 2.17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 21.71 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.71 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                Load Date  :":35 VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 2.95 COL 6
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "  Previous Batch No.   :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 7.33 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.57 COL 1
     RECT-373 AT ROW 15.29 COL 1
     RECT-374 AT ROW 21 COL 1
     RECT-375 AT ROW 21.24 COL 4
     RECT-376 AT ROW 21.48 COL 5.5
     RECT-377 AT ROW 8.95 COL 107.5
     RECT-378 AT ROW 11.38 COL 107.5
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
         TITLE              = "Load Text file TOYOTA TO GW"
         HEIGHT             = 23.86
         WIDTH              = 132.5
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
/* BROWSE-TAB br_wdetail 1 fr_main */
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
          SIZE 12.83 BY 1 AT ROW 7.33 COL 61.33 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "    Policy Import Total  :"
          SIZE 23 BY 1 AT ROW 12.86 COL 28 RIGHT-ALIGNED                */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY 1 AT ROW 12.86 COL 65.33 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 21.71 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 21.71 COL 95.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.71 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 22.71 COL 96 RIGHT-ALIGNED          */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_query FOR EACH wdetail.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* Load Text file TOYOTA TO GW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text file TOYOTA TO GW */
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

          wdetail.add1 :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.add2 :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.add3 :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.add4 :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.prempa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.subclass:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.brand:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.model:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.cc:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
          wdetail.weight:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.seat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.body:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.vehreg:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.eng:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.chasno:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.caryear:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.re_country:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.vehuse:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.garage:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.stk:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.access:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.covcod:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.si:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
          wdetail.fleet:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.     
          wdetail.ncb:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.deductda:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductpd:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.benname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.n_IMPORT:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_export:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivnam:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.producer:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.agent:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.comment:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          WDETAIL.CANCEL:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.redbook:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. /*new add*/                 


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

          wdetail.add1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.add2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.add3:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.add4:FGCOLOR IN BROWSE BR_WDETAIL = s  NO-ERROR.  
          wdetail.prempa:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.subclass:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.brand:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.model:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.cc:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.weight:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.seat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.body:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehreg:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.eng:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.chasno:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.caryear:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.re_country:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehuse:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.garage:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.stk:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.access:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.covcod:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.si:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.fleet:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.ncb:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductda:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductpd:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.benname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_IMPORT:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_export:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivnam:FGCOLOR IN BROWSE BR_WDETAIL = s  NO-ERROR.  
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
    END.   */
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
        FIND LAST uzm700 USE-INDEX uzm70002 WHERE
            uzm700.bchyr       = nv_batchyr          AND   /*kridtiya i. A53-0263 */
            uzm700.acno        = TRIM(fi_producer)   AND
            uzm700.branch      = TRIM(nv_batbrn)     NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:
            ASSIGN nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102 
                WHERE  uzm701.bchyr =  nv_batchyr          AND  /*kridtiya i. A53-0263 */
                uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") 
                NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN 
                ASSIGN nv_batcnt = uzm701.bchcnt 
                nv_batrunno = nv_batrunno + 1.
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
        FIND LAST uzm701 USE-INDEX uzm70102 WHERE
            uzm701.bchyr =  nv_batchyr       AND     /*kridtiya i. A53-0263 */
            uzm701.bchno =  CAPS(nv_batprev)  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL uzm701 THEN DO:
            MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev)
                + " on file uzm701" .
            APPLY "entry" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
        ELSE 
            ASSIGN nv_batcnt  = uzm701.bchcnt + 1
            nv_batchno = CAPS(TRIM(nv_batprev))  .
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
    RUN proc_assign. 
    /*
    ASSIGN
    wdetail2.comment  = ""
    wdetail2.agent    = fi_agent
    wdetail2.producer = fi_producer     
    wdetail2.entdat   = string(TODAY)                /*entry date*/
    wdetail2.enttim   = STRING (TIME, "HH:MM:SS")    /*entry time*/
    wdetail2.trandat  = STRING (fi_loaddat)          /*tran date*/
    wdetail2.trantim  = STRING (TIME, "HH:MM:SS")    /*tran time*/
    wdetail2.n_IMPORT = "IM"
    wdetail2.n_EXPORT = "" .  */ 
    FOR EACH wdetail:
        IF WDETAIL.POLTYP = "v70" OR WDETAIL.POLTYP = "v72" THEN  
            ASSIGN
                nv_reccnt     =  nv_reccnt   + 1
                nv_netprm_t   =  nv_netprm_t + decimal(wdetail.prem_r)
                wdetail.pass  = "Y". 
         
        ELSE DELETE WDETAIL.
    END.
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    /*Add by Kridtiya i. A63-0472*/
    /*comment by : A64-0138...
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
    ...end A64-0138..*/
    /*Add by Kridtiya i. A63-0472*/
    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                           INPUT            nv_batchyr ,     /* INT   */
                           INPUT            fi_producer,     /* CHAR  */ 
                           INPUT            nv_batbrn  ,     /* CHAR  */
                           INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                           INPUT            "WGWTBGEN" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem ).    /* DECI  */
    ASSIGN
        fi_bchno   = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99"))
        fi_process = "Create Batchfile ...".
    DISP  fi_bchno fi_process  WITH FRAME fr_main.
    RUN proc_chktest1. 
    FOR EACH wdetail WHERE  wdetail.pass = "y" :
        ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + decimal(wdetail.prem_r). 
    END.
    ASSIGN 
        nv_rectot = nv_reccnt       
        nv_recsuc = nv_completecnt. 
    /*IF  /*nv_imppol <> nv_rectot OR  nv_imppol <> nv_recsuc OR*/*/
    IF nv_rectot <> nv_recsuc   THEN DO:
        nv_batflg = NO.
        /*MESSAGE "Policy import record is not match to Total record !!!" VIEW-AS ALERT-BOX.*/
    END.    /*ELSE  IF /*nv_impprem  <> nv_netprm_t OR nv_impprem  <> nv_netprm_s OR*/*/
    ELSE IF nv_netprm_t <> nv_netprm_s THEN DO:
        nv_batflg = NO.
        /*MESSAGE "Total net premium is not match to Total net premium !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE 
        nv_batflg = YES.
    FIND LAST uzm701 USE-INDEX uzm70102  
        WHERE uzm701.bchyr   = nv_batchyr AND
              uzm701.bchno   = nv_batchno AND
              uzm701.bchcnt  = nv_batcnt  NO-ERROR.
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
    /* add by : A64-0138 */
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp. 
    /* add by : A64-0138 */

    IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_process = "Error import file tib please check data again..."
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno    :FGCOLOR = 6. 
        DISP fi_completecnt fi_premsuc WITH FRAME fr_main.
        MESSAGE "Batch Year  : " STRING(nv_batchyr)     SKIP
            "Batch No.   : " nv_batchno             SKIP
            "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
            TRIM(nv_txtmsg)                         SKIP
            "Please check Data again."      
            VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE". 
            DISP fi_process WITH FRAM fr_main.
    END.
    ELSE IF nv_batflg = YES THEN DO: 
        ASSIGN
            fi_process = "Import text file Complete..."
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
        DISP fi_process WITH FRAM fr_main.
    END.
    ASSIGN fi_impcnt      = n_wdetail . /*kridtiya i. A53-0310*/
    
    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .  
    /* add by : A64-0138 ......
    /*add  A55-0197 */
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.
    /*end add  A55-0197 */
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp. 
    END. by : A64-0138 */
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
                            "Data Files (*.dat)"     "*.dat"
                    /*"Text Files (*.txt)" "*.txt"*/
                    
                            
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
    ASSIGN fi_agent = "B3m0016".
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


&Scoped-define SELF-NAME fi_campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaign c-Win
ON LEAVE OF fi_campaign IN FRAME fr_main
DO:
    
  fi_pack  =  Input  fi_pack.
  Disp  fi_pack  with  frame  fr_main.
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


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack c-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
    
  fi_pack  =  Input  fi_pack.
  Disp  fi_pack  with  frame  fr_main.
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
    ASSIGN fi_producer = "B300125".
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


&Scoped-define SELF-NAME ra_renewby
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_renewby c-Win
ON VALUE-CHANGED OF ra_renewby IN FRAME fr_main
DO:
  ra_renewby = INPUT ra_renewby.
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
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "Wgwtbgen".
  gv_prog  = "Load Text & Generate TIB[TOYOTA]".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
      fi_pack     = "X"
      fi_branch   = "M"
      fi_producer = "B3M0008"
      fi_agent    = "B3M0008"
      fi_bchyr    = YEAR(TODAY) 
      fi_campaign = "CAM_TOYOTA"
      fi_process  = "Load Text file TOYOTA...."
      ra_renewby  = 1 .   /*kridtiya i. A53-0263...*/
  DISP fi_pack fi_branch fi_producer fi_agent fi_bchyr fi_process fi_campaign WITH FRAME fr_main.
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
  DISPLAY fi_process ra_renewby fi_loaddat fi_pack fi_branch fi_producer 
          fi_bchno fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 
          fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt 
          fi_proname fi_agtname fi_completecnt fi_premtot fi_premsuc fi_campaign 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE br_wdetail fi_process ra_renewby fi_loaddat fi_pack fi_branch 
         fi_producer fi_agent fi_prevbat fi_bchyr fi_filename bu_file 
         fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit 
         bu_hpbrn bu_hpacno1 bu_hpagent fi_campaign RECT-370 RECT-372 RECT-373 
         RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
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
    wdetail.tariff = "9"
    wdetail.prepol = "" 
    wdetail.compul = "y".


IF      wdetail.subclass = "210" THEN  wdetail.subclass =  "120A" .
ELSE IF wdetail.subclass = "120" THEN  wdetail.subclass =  "210" . 
/*ELSE IF wdetail.subclass = "320" THEN  wdetail.subclass =  "320A" . */
ELSE IF wdetail.subclass = "320" THEN DO: 
         IF deci(wdetail.comprem)= 967.28    THEN wdetail.subclass =  "140A".  /*ใช้รถส่วนบุคคล ไม่ใช้รับจ้างหรือให้เช่า*/
    ELSE IF deci(wdetail.comprem)= 1310.75   THEN wdetail.subclass =  "140B".  /*ใช้รถส่วนบุคคล ไม่ใช้รับจ้างหรือให้เช่า*/  
    ELSE IF deci(wdetail.comprem)= 1408.12   THEN wdetail.subclass =  "140C".  /*ใช้รถส่วนบุคคล ไม่ใช้รับจ้างหรือให้เช่า*/    
    ELSE IF deci(wdetail.comprem)= 1826.49   THEN wdetail.subclass =  "140D".  /*ใช้รถส่วนบุคคล ไม่ใช้รับจ้างหรือให้เช่า*/  
    ELSE IF deci(wdetail.comprem)= 1891.76   THEN wdetail.subclass =  "240A".  /*ใช้รับจ้าง / ให้เช่า                   */  
    ELSE IF deci(wdetail.comprem)= 1966.66   THEN wdetail.subclass =  "240B".  /*ใช้รับจ้าง / ให้เช่า                   */  
    ELSE IF deci(wdetail.comprem)= 2127.16   THEN wdetail.subclass =  "240C".  /*ใช้รับจ้าง / ให้เช่า                   */      
    ELSE IF deci(wdetail.comprem)= 2718.87   THEN wdetail.subclass =  "240D".  /*ใช้รับจ้าง / ให้เช่า                   */  
    ELSE IF deci(wdetail.comprem)= 1891.76   THEN wdetail.subclass =  "340A".  /*ใช้รับจ้างสาธารณะ                      */  
    ELSE IF deci(wdetail.comprem)= 1966.66   THEN wdetail.subclass =  "340B".  /*ใช้รับจ้างสาธารณะ                      */  
    ELSE IF deci(wdetail.comprem)= 2127.16   THEN wdetail.subclass =  "340C".  /*ใช้รับจ้างสาธารณะ                      */      
    ELSE IF deci(wdetail.comprem)= 2718.87   THEN wdetail.subclass =  "340D".  /*ใช้รับจ้างสาธารณะ                      */ 
END.
ELSE IF wdetail.subclass = "420" THEN DO:  
         IF deci(wdetail.comprem)= 2546.60   THEN wdetail.subclass =  "150".  /*ใช้รถส่วนบุคคล ไม่ใช้รับจ้างหรือให้เช่า */  
    ELSE IF deci(wdetail.comprem)= 3395.11   THEN wdetail.subclass =  "250".  /*ใช้รับจ้าง / ให้เช่า                    */  
    ELSE IF deci(wdetail.comprem)= 3395.11   THEN wdetail.subclass =  "350".  /*ใช้รับจ้างสาธารณะ                       */  
END.
ELSE IF wdetail.subclass = "520" THEN DO:  
         IF deci(wdetail.comprem)= 645.21   THEN wdetail.subclass =  "160".  /*ใช้รถส่วนบุคคล ไม่ใช้รับจ้างหรือให้เช่า */  
    ELSE IF deci(wdetail.comprem)= 645.21   THEN wdetail.subclass =  "260".  /*ใช้รับจ้าง / ให้เช่า                    */  
    ELSE IF deci(wdetail.comprem)= 645.21   THEN wdetail.subclass =  "360".  /*ใช้รับจ้างสาธารณะ                       */  
END.
ELSE    wdetail.subclass = "110".
      

IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass    = "N"
        WDETAIL.OK_GEN  = "N". 
END.
IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk <> "" THEN DO:    
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN  wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
            wdetail.pass    = ""
            WDETAIL.OK_GEN  = "N".
    END.    
END.
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail.subclass
    NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
        wdetail.pass    = "N"
        WDETAIL.OK_GEN  = "N".

/*------------- poltyp ------------*/
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp  AND
        sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
            WDETAIL.OK_GEN  = "N".
END. 
/*---------- covcod ----------*/
wdetail.covcod = CAPS(wdetail.covcod).
/*IF (wdetail.n_branch = "L")  OR (wdetail.n_branch = "14") THEN 
                ASSIGN  wdetail.comment =  wdetail.comment + "| พบกรมธรรม์สาขา " + wdetail.n_branch + " ไม่นำเข้ากรมธรรม์" 
                        wdetail.pass    = "N" 
                        WDETAIL.OK_GEN  = "N".*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
        WDETAIL.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = "110" AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
        WDETAIL.OK_GEN = "N".
/*--------- modcod --------------*/
IF INDEX(wdetail.model,"vigo") <> 0 THEN wdetail.model = "vigo".
ELSE IF INDEX(wdetail.model,"altis") <> 0 THEN wdetail.model = "altis".
ASSIGN chkred = NO
nv_moddes  = wdetail.model
n_sclass72 = substr(wdetail.subclass,1,3) .
IF INDEX(trim(wdetail.model)," ") <> 0 THEN DO:
        ASSIGN wdetail.model = SUBSTR(trim(wdetail.model),1,INDEX(trim(wdetail.model)," ") - 1 ).
    END.
Find First stat.maktab_fil Use-index      maktab04          Where
    stat.maktab_fil.makdes   =     nv_makdes                And                  
    index(stat.maktab_fil.moddes,nv_moddes) <> 0            And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
    stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
    stat.maktab_fil.sclass   =     n_sclass72        AND
    (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
     stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) AND
    stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    ASSIGN 
        nv_modcod        =  stat.maktab_fil.modcod 
        wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.body     =  stat.maktab_fil.body  
        wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes
        wdetail.weight   =  string(stat.maktab_fil.tons)
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.seat     =  string(stat.maktab_fil.seats).
ELSE wdetail.redbook = "".
IF nv_modcod = "" THEN DO:
    IF INDEX(trim(wdetail.model)," ") <> 0 THEN DO:
        ASSIGN wdetail.model = SUBSTR(trim(wdetail.model),1,INDEX(trim(wdetail.model)," ") - 1 ).
    END.
    IF INDEX(wdetail.model,"vigo") <> 0 THEN wdetail.model = "vigo".
    ELSE IF INDEX(wdetail.model,"altis") <> 0 THEN wdetail.model = "altis".
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN n_ratmin = makdes31.si_theft_p   
        n_ratmax = makdes31.load_p   .    
    ELSE ASSIGN n_ratmin = 0
        n_ratmax = 0.
    Find First stat.maktab_fil Use-index maktab04             Where
        stat.maktab_fil.makdes   =  nv_makdes             And                  
        index(stat.maktab_fil.moddes,nv_moddes) <> 0      And
        stat.maktab_fil.makyea   =  Integer(wdetail.caryear)  AND
        stat.maktab_fil.engine   =  Integer(wdetail.engcc)    AND
        stat.maktab_fil.sclass   =  n_sclass72          AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )   <=  deci(wdetail.si)   OR
         stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )   >=  deci(wdetail.si) ) AND
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN  
        nv_modcod        =  stat.maktab_fil.modcod 
        wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.body     =  stat.maktab_fil.body  
        wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes
        wdetail.weight   =  string(stat.maktab_fil.tons)
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.seat     =  string(stat.maktab_fil.seats).
        chkred           =  YES .
    IF nv_modcod = ""  THEN RUN proc_maktab. 
END.
IF wdetail.redbook = "" THEN RUN proc_maktab.
/*
IF      wdetail.subclass = "210" THEN  wdetail.subclass =  "120A" .
ELSE IF wdetail.subclass = "120" THEN  wdetail.subclass =  "210" . 
/*ELSE IF wdetail.subclass = "320" THEN  wdetail.subclass =  "320A" . */
ELSE IF wdetail.subclass = "320" THEN  wdetail.subclass =  "140A" . 
ELSE    wdetail.subclass = "110".
        */
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN     
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
        WDETAIL.OK_GEN  = "N".
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
        ASSIGN wdetail.pass    = "N"  
        wdetail.comment = "Receipt is Dup. on uwm100 :" + string(sicuw.uwm100.policy,"x(16)") +
        STRING(sicuw.uwm100.rencnt,"99")  + "/" +
        STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
        WDETAIL.OK_GEN  = "N".
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
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp     AND         /*0*/
    sic_bran.uwm130.riskno = s_riskno     AND         /*1*/
    sic_bran.uwm130.itemno = s_itemno     AND         /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr   AND         /*26/10/2006 change field name */
    sic_bran.uwm130.bchno  = nv_batchno   AND         /*26/10/2006 change field name */ 
    sic_bran.uwm130.bchcnt = nv_batcnt                /*26/10/2006 change field name */            
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
nv_newsck = " ".
IF SUBSTR(wdetail.stk,1,1) = "2" THEN 
    ASSIGN nv_newsck = "0" + wdetail.stk
    wdetail.stk = "0" + wdetail.stk.
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
        sic_bran.uwm301.tariff  = wdetail.tariff
        sic_bran.uwm301.covcod  = "T"
        sic_bran.uwm301.cha_no  = wdetail.chasno
        sic_bran.uwm301.eng_no  = wdetail.eng
        sic_bran.uwm301.Tons    = INTEGER(wdetail.weight)
        sic_bran.uwm301.engine  = INTEGER(wdetail.engcc)
        sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage  = wdetail.garage
        sic_bran.uwm301.body    = wdetail.body
        sic_bran.uwm301.vehgrp  =  wdetail.cargrp
        sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = wdetail.benname
        sic_bran.uwm301.vehreg   = wdetail.vehreg + nv_provi
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
    ELSE sic_bran.uwm301.drinam[9] = "".
    s_recid4  = RECID(sic_bran.uwm301).
    /*IF wdetail.redbook <> "" THEN DO:     /*กรณีที่มีการระบุ Code รถมา*/
        FIND FIRST stat.maktab_fil Use-index      maktab04          WHERE 
            stat.maktab_fil.modcod = wdetail.redbook     No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN wdetail.redbook =  stat.maktab_fil.modcod
            wdetail.model           = stat.maktab_fil.moddes
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp          =  stat.maktab_fil.prmpac
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body    =  stat.maktab_fil.body
            sic_bran.uwm301.seats   =  stat.maktab_fil.seats
            sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
            sic_bran.uwm301.engine  =  stat.maktab_fil.eng.
    END.
    ELSE DO:*/
    IF wdetail.redbook = "" THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04          Where
            stat.maktab_fil.makdes   =   wdetail.brand              And                  
            index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
            stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
            stat.maktab_fil.sclass   =     n_sclass72        AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
             stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) AND
            stat.maktab_fil.seats    = INTEGER(wdetail.seat) 
            No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN wdetail.redbook =  stat.maktab_fil.modcod
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp          =  stat.maktab_fil.prmpac
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body    =  stat.maktab_fil.body.
    END.
    FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
         sic_bran.uwd132.policy = wdetail.policy   AND
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
        MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wdetail.policy 
                "ไม่สามารถ Generage ข้อมูลได้".
        NEXT.
      END.
      CREATE sic_bran.uwd132.
    END.
    ASSIGN  sic_bran.uwd132.bencod  = "COMP"             /*Benefit Code*/
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
      sic_bran.uwd132.policy  = wdetail.policy           /*Policy No. - uwm130*/
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
                sic_bran.uwd132.bchyr = nv_batchyr           /* batch Year */      
                sic_bran.uwd132.bchno = nv_batchno           /* bchno    */      
                sic_bran.uwd132.bchcnt  = nv_batcnt .        /* bchcnt     */ 
            FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                sicsyac.xmm105.tariff = wdetail.tariff  AND
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE  MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:  /* Malaysia */
                IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
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
                    sic_bran.uwd132.bchno = nv_batchno      /* bchno      */      
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
                    IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.engcc).
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
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
                        sicsyac.xmm106.class   = wdetail.subclass        AND
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
                IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
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
     /*RUN proc_chktest4.*//*kridtiya i. A55-0197 */
     RUN proc_chktest41.   /*kridtiya i. A55-0197 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132prem c-Win 
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
    End.
    For each  wdetail :
        DELETE  wdetail.
    End.
    ASSIGN fi_process = "Import text file TIB to wdetail...".
    DISP fi_process WITH FRAM fr_main.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail2.
        IMPORT DELIMITER "|" 
            wdetail2.head         /* 1    ประเภทรายการ*/  
            wdetail2.comcode      /* 2    รหัสบริษัท  */  
            wdetail2.senddat      /* 3    วันที่ส่ง   */  
            wdetail2.contractno   /* 4    เลขที่(ApplicationNo.)*/  
            wdetail2.lotno        /* 5    Lotno.        */  
            wdetail2.seqno        /* 6    Seqno.        */  
            wdetail2.recact       /* 7    Record Active.*/  
            wdetail2.STATUSno     /* 8    สถานะ         */  
            wdetail2.flag         /* 9    แก้ไขเลขเครื่องยนต์/เลขตัวถัง */  
            wdetail2.tiname       /* 10   คำนำ                   */  
            wdetail2.insname      /* 11   ชื่อผู้เอาประกันภัย    */  
            wdetail2.add1         /* 12   ที่อยู่ผู้เอาประกันภัย1*/  
            wdetail2.add2         /* 13   ที่อยู่ผู้เอาประกันภัย2*/  
            wdetail2.add3         /* 14   ที่อยู่ผู้เอาประกันภัย3*/  
            wdetail2.add4         /* 15   ที่อยู่ผู้เอาประกันภัย4*/  
            wdetail2.add5         /* 16   ที่อยู่ผู้เอาประกันภัย5*/  
            wdetail2.engno        /* 17   เลขเครื่องยนต์         */  
            wdetail2.chasno       /* 18   เลขตัวถัง              */  
            wdetail2.brand        /* 19   รหัสยี่ห้อรถ           */  
            wdetail2.model        /* 20   รุ่นรถ                 */  
            wdetail2.cc           /* 21   ขนาดเครื่องยนต์        */  
            wdetail2.COLORno      /* 22   สีรถ                   */  
            wdetail2.reg1         /* 23   ทะเบียนรถ1             */  
            wdetail2.reg2         /* 24   ทะเบียนรถ2             */  
            wdetail2.provinco     /* 25   จังหวัดที่จดทะเบียน    */  
            wdetail2.subinsco     /* 26   รหัสย่อยบริษัทประกันภัย*/  
            wdetail2.covamount    /* 27   Normal Coverage amount */  
            wdetail2.grpssprem    /* 28   Normal Gross premium   */  
            wdetail2.effecdat     /* 29   Effective date         */  
            wdetail2.notifyno     /* 30   เลขรับแจ้งฯ TLT.       */  
            wdetail2.noticode     /* 31   รหัสผู้รับแจ้งฯ TLT.   */  
            wdetail2.noticodesty  /* 32   เลขรับแจ้งฯ จากบ.ประกันภัย*/  
            wdetail2.notiname     /* 33   ชื่อผู้รับแจ้งฯ ของบ.ประกันภัย*/  
            wdetail2.substyname   /* 34   รหัสย่อยบริษัทประกันภัย*/  
            wdetail2.comamount    /* 35   Compl. Coverage amount */  
            wdetail2.comprem      /* 36   Compl. Gross premium   */  
            wdetail2.comeffecdat  /* 37   Compl. Effective date  */  
            wdetail2.compno       /* 38   เครื่องหมาย (พรบ.)     */  
            wdetail2.recivno      /* 39   เลขรับแจ้งฯ TLT.       */  
            wdetail2.recivcode    /* 40   รหัสผู้รับแจ้งฯ TLT.   */  
            wdetail2.recivcosty   /* 41   เลขรับแจ้งฯ จากบ.ประกันภัย*/  
            wdetail2.recivstynam  /* 42   ชื่อผู้รับแจ้งฯ ของบ.ประกันภัย */  
            wdetail2.comppol      /* 43   เลขกรมธรรม์ พรบ. */  
            wdetail2.recivstydat  /* 44   วันที่บ.ประกันภัย รับแจ้งฯ */  
            wdetail2.drivnam1     /* 45   ชื่อผู้ขับขี่ คนที่ 1  */  
            wdetail2.drivnam2     /* 46   ชื่อผู้ขับขี่ คนที่ 2  */  
            wdetail2.drino1       /* 47   เลขที่ใบขับขี่ คนที่ 1 */  
            wdetail2.drino2       /* 48   เลขที่ใบขับขี่ คนที่ 2 */  
            wdetail2.oldeng       /* 49   หมายเลขเครื่องยนต์ (เดิม)*/  
            wdetail2.oldchass     /* 50   หมายเลขตัวถังรถ (เดิม)*/  
            wdetail2.NAMEpay      /* 51   ชื่อ-สกุลสำหรับออกใบเสร็จรับเงิน  */  
            wdetail2.addpay1      /* 52   ที่อยู่ บรรทัดที่1*/  
            wdetail2.addpay2      /* 53   ที่อยู่ บรรทัดที่2*/  
            wdetail2.addpay3      /* 54   ที่อยู่ บรรทัดที่3*/  
            wdetail2.addpay4      /* 55   ที่อยู่ บรรทัดที่4*/  
            wdetail2.postpay      /* 56   รหัสไปรษณีย์      */  
            wdetail2.Reserved1    /* 57   Reserved1         */  
            wdetail2.Reserved2    /* 58   Reserved2         */  
            wdetail2.norcovdat    /* 59   Normal End coverage date*/  
            wdetail2.norcovenddat /* 60   Compulsory End coverage date*/  
            wdetail2.delercode    /* 61   Dealer code     */  
            wdetail2.caryear      /* 62   ปีรถ            */  
            wdetail2.renewtyp     /* 63   Renewal type    */  
            wdetail2.Reserved5    /* 64   Reserved5       */  
            wdetail2.Reserved6    /* 65   Reserved6       */  
            wdetail2.access       /* 66   access          */  
            wdetail2.branch       /* 67   branch          */  
            wdetail2.producer     /* 68   producer        */  
            wdetail2.agent        /* 69   agent           */  
            wdetail2.prvpol       /* 70   Previous Policy */  
            wdetail2.covcod       /* 71   covcod          */  
            wdetail2.CLASS        /* 72   class           */ 
            wdetail2.GarageType      /*A67-0184*/   
            wdetail2.DriverFlag      /*A67-0184*/   
            wdetail2.Driver1name     /*A67-0184*/   
            wdetail2.Driver1DOB      /*A67-0184*/   
            wdetail2.Driver1License  /*A67-0184*/   
            wdetail2.Driver2name     /*A67-0184*/   
            wdetail2.Driver2DOB      /*A67-0184*/   
            wdetail2.Driver2License  /*A67-0184*/   
            wdetail2.DealerCode       /*A67-0184*/   
            wdetail2.CarUsageCode     /*A67-0184*/   
             .
            
    END.
    FOR EACH wdetail2.
        IF wdetail2.head <> "D"  THEN DELETE wdetail2.
        ELSE DO:
            /*add  A55-0197 */
            IF wdetail2.add1 <> "" THEN  wdetail2.add1 = trim(wdetail2.add1) .
            IF wdetail2.add2 <> "" THEN  wdetail2.add1 = trim(wdetail2.add1) + " " + trim(wdetail2.add2).
            IF wdetail2.add3 <> "" THEN  wdetail2.add1 = trim(wdetail2.add1) + " " + trim(wdetail2.add3).
            IF wdetail2.add4 <> "" THEN  wdetail2.add1 = trim(wdetail2.add1) + " " + trim(wdetail2.add4).
            /*IF wdetail2.add5 <> "" THEN  wdetail2.add1 = trim(wdetail2.add1) + " " + trim(wdetail2.add5).*/
            IF R-INDEX(wdetail2.add1,"จ.") <> 0 THEN  
                ASSIGN wdetail2.add4  = SUBSTR(wdetail2.add1,R-INDEX(wdetail2.add1,"จ."))
                       wdetail2.add4  = REPLACE(wdetail2.add4," ","")
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,R-INDEX(wdetail2.add1,"จ.") - 1 ).
            ELSE IF INDEX(wdetail2.add1,"จังหวัด") <> 0 THEN  
                ASSIGN wdetail2.add4  = SUBSTR(wdetail2.add1,INDEX(wdetail2.add1,"จังหวัด"))
                       wdetail2.add4  = REPLACE(wdetail2.add4," ","")
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,INDEX(wdetail2.add1,"จังหวัด") - 1 ).
            ELSE IF R-INDEX(wdetail2.add1,"กรุงเทพ") <> 0 THEN  
                ASSIGN wdetail2.add4  = SUBSTR(wdetail2.add1,R-INDEX(wdetail2.add1,"กรุงเทพ"))
                       wdetail2.add4  = REPLACE(wdetail2.add4," ","")
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,R-INDEX(wdetail2.add1,"กรุงเทพ") - 1 ).
            ELSE IF R-INDEX(wdetail2.add1,"กทม") <> 0 THEN  
                ASSIGN wdetail2.add4  = SUBSTR(wdetail2.add1,R-INDEX(wdetail2.add1,"กทม"))
                       wdetail2.add4  = REPLACE(wdetail2.add4," ","")
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,R-INDEX(wdetail2.add1,"กทม") - 1 ).
            /*ASSIGN wdetail2.add4  = wdetail2.add4  + " " + trim(wdetail2.add5). *//*Add by Kridtiya i. A63-0472*/
            ASSIGN wdetail2.add4  = wdetail2.add4   .  /*Add by Kridtiya i. A63-0472*/
            /*อำเภอ */
            IF R-INDEX(wdetail2.add1,"อ.") <> 0  THEN 
                ASSIGN wdetail2.add3  = SUBSTR(wdetail2.add1,R-INDEX(wdetail2.add1,"อ."))
                       wdetail2.add3  = REPLACE(wdetail2.add3," ","")
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,R-INDEX(wdetail2.add1,"อ.") - 1 ).
            ELSE IF R-INDEX(wdetail2.add1,"อำเภอ") <> 0  THEN 
                ASSIGN wdetail2.add3  = SUBSTR(wdetail2.add1,R-INDEX(wdetail2.add1,"อำเภอ"))
                       wdetail2.add3  = REPLACE(wdetail2.add3," ","")
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,R-INDEX(wdetail2.add1,"อำเภอ") - 1 ).
            ELSE IF R-INDEX(wdetail2.add1,"เขต") <> 0  THEN 
                ASSIGN wdetail2.add3  = SUBSTR(wdetail2.add1,R-INDEX(wdetail2.add1,"เขต"))
                       wdetail2.add3  = REPLACE(wdetail2.add3," ","")
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,R-INDEX(wdetail2.add1,"เขต") - 1 ).
            /*ตำบล */
            IF R-INDEX(wdetail2.add1,"ต.") <> 0  THEN 
                ASSIGN wdetail2.add2  = SUBSTR(wdetail2.add1,R-INDEX(wdetail2.add1,"ต."))
                       wdetail2.add2  = REPLACE(wdetail2.add2," ","")
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,R-INDEX(wdetail2.add1,"ต.") - 1 ).
            ELSE IF R-INDEX(wdetail2.add1,"ตำบล") <> 0  THEN 
                ASSIGN wdetail2.add2  = SUBSTR(wdetail2.add1,R-INDEX(wdetail2.add1,"ตำบล"))
                       wdetail2.add2  = REPLACE(wdetail2.add2," ","")
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,R-INDEX(wdetail2.add1,"ตำบล") - 1 ).
            ELSE IF R-INDEX(wdetail2.add1,"แขวง") <> 0  THEN 
                ASSIGN wdetail2.add2  = SUBSTR(wdetail2.add1,R-INDEX(wdetail2.add1,"แขวง"))
                       wdetail2.add2  = REPLACE(wdetail2.add2," ","")
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,R-INDEX(wdetail2.add1,"แขวง") - 1 ).
            /*road */
            IF INDEX(wdetail2.add1,"ถ.") <> 0  THEN 
                ASSIGN wdetail2.road  = SUBSTR(wdetail2.add1,INDEX(wdetail2.add1,"ถ."))
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,INDEX(wdetail2.add1,"ถ.") - 1 ).
            ELSE IF INDEX(wdetail2.add1,"ถนน") <> 0  THEN 
                ASSIGN wdetail2.road  = SUBSTR(wdetail2.add1,INDEX(wdetail2.add1,"ถนน"))
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,INDEX(wdetail2.add1,"ถนน") - 1 ).
            /*soy  */
            IF INDEX(wdetail2.add1,"ซ.") <> 0  THEN 
                ASSIGN wdetail2.soy   = SUBSTR(wdetail2.add1,INDEX(wdetail2.add1,"ซ."))
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,INDEX(wdetail2.add1,"ซ.") - 1 ).
            ELSE IF INDEX(wdetail2.add1,"ซอย") <> 0  THEN 
                ASSIGN wdetail2.soy   = SUBSTR(wdetail2.add1,INDEX(wdetail2.add1,"ซอย"))
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,INDEX(wdetail2.add1,"ซอย") - 1 ).
            /*Mu  */
            IF INDEX(wdetail2.add1,"ม.") <> 0  THEN 
                ASSIGN wdetail2.moo   = SUBSTR(wdetail2.add1,INDEX(wdetail2.add1,"ม."))
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,INDEX(wdetail2.add1,"ม.") - 1 )
                       wdetail2.add1  = TRIM(wdetail2.add1) + " " + TRIM(wdetail2.moo).
            ELSE IF INDEX(wdetail2.add1,"หมู่") <> 0  THEN 
                ASSIGN wdetail2.moo   = SUBSTR(wdetail2.add1,INDEX(wdetail2.add1,"หมู่"))
                       wdetail2.add1  = SUBSTR(wdetail2.add1,1,INDEX(wdetail2.add1,"หมู่") - 1 )
                       wdetail2.add1  = TRIM(wdetail2.add1) + " " + TRIM(wdetail2.moo).
            IF wdetail2.soy <> "" THEN DO:
                IF LENGTH(trim(wdetail2.add1) + " " + trim(wdetail2.soy)) <= 35 THEN DO: 
                    ASSIGN wdetail2.add1  = trim(wdetail2.add1)  + " " + trim(wdetail2.soy).
                    IF wdetail2.road <> "" THEN DO:
                        IF LENGTH(TRIM(wdetail2.road)  + " " + TRIM(wdetail2.add2)) <= 35 THEN
                            ASSIGN wdetail2.add2  = TRIM(wdetail2.road)  + " " + TRIM(wdetail2.add2)
                            wdetail2.add3  = TRIM(wdetail2.add3)  + " " + TRIM(wdetail2.add4)
                            wdetail2.add4  = "".
                        ELSE ASSIGN wdetail2.add2  = TRIM(wdetail2.road)
                            wdetail2.add3  = TRIM(wdetail2.add2)  + " " + TRIM(wdetail2.add3).
                    END.
                    ELSE ASSIGN 
                        wdetail2.add2  = TRIM(wdetail2.add2) + " " + TRIM(wdetail2.add3)
                        wdetail2.add3  = TRIM(wdetail2.add4)  
                        wdetail2.add4  = "".
                END.
                ELSE DO: 
                    IF wdetail2.road <> "" THEN DO:
                        ASSIGN wdetail2.road  = trim(wdetail2.soy)   + " " + TRIM(wdetail2.road).
                        IF LENGTH(TRIM(wdetail2.road)  + " " + TRIM(wdetail2.add2)) <= 35 THEN
                            ASSIGN 
                            wdetail2.add2  = TRIM(wdetail2.road)  + " " + TRIM(wdetail2.add2)
                            wdetail2.add3  = TRIM(wdetail2.add3)  + " " + TRIM(wdetail2.add4)
                            wdetail2.add4  = "".
                        ELSE ASSIGN 
                            wdetail2.add2  = TRIM(wdetail2.road)
                            wdetail2.add3  = TRIM(wdetail2.add2)  + " " + TRIM(wdetail2.add3).
                    END.
                    ELSE ASSIGN 
                        wdetail2.add2  = trim(wdetail2.soy)   + " " + TRIM(wdetail2.add2) 
                        wdetail2.add3  = TRIM(wdetail2.add3)  + " " + TRIM(wdetail2.add4)  
                        wdetail2.add4  = "".
                END.
            END. /*soy = "" */
            ELSE DO:
                IF wdetail2.road <> "" THEN DO:
                    IF LENGTH(trim(wdetail2.add1) + " " + trim(wdetail2.road)) <= 35 THEN 
                        ASSIGN 
                            wdetail2.add1  = trim(wdetail2.add1)  + " " + trim(wdetail2.road) 
                            wdetail2.add2  = TRIM(wdetail2.add2)  + " " + TRIM(wdetail2.add3)
                            wdetail2.add3  = TRIM(wdetail2.add4)
                            wdetail2.add4  = "".
                    ELSE ASSIGN 
                        wdetail2.add2  = TRIM(wdetail2.road)  + " " + TRIM(wdetail2.add2)
                        wdetail2.add3  = TRIM(wdetail2.add3)  + " " + TRIM(wdetail2.add4)
                        wdetail2.add4  = "".
                END.
                ELSE DO: /*road = ""*/
                    IF LENGTH(trim(wdetail2.add1) + " " + trim(wdetail2.add2)) <= 35 THEN 
                        ASSIGN 
                        wdetail2.add1  = trim(wdetail2.add1) + " " + trim(wdetail2.add2)
                        wdetail2.add2  = trim(wdetail2.add3) + " " + trim(wdetail2.add4)
                        wdetail2.add3  = ""
                        wdetail2.add4  = "".
                    ELSE ASSIGN 
                        wdetail2.add2  = trim(wdetail2.add2) + " " + trim(wdetail2.add3)
                        wdetail2.add3  = trim(wdetail2.add4)
                        wdetail2.add4  = "".
                END.
            END.
        END.  /*end...else do: */
    END.
    RUN proc_assignwdetail.  
END.  /*-Repeat-*/
RUN proc_assign2.

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
DEF VAR  b_eng   AS DECI FORMAT  ">>>>9.99-".
DEF VAR  n_date  AS CHAR FORMAT  "x(10)".
FOR EACH wdetail WHERE wdetail.policy  NE " "  .
    ASSIGN fi_process   = "Import text file tib to gw..."
        n_date          = STRING(TODAY,"99/99/9999")
        b_eng           = round((DECI(wdetail.engcc) / 1000),1)    
        b_eng           = b_eng * 1000
        wdetail.engcc   = STRING(b_eng)
        wdetail.weight  = STRING(b_eng)
        wdetail.seat    = IF INTEGER(wdetail.seat) = 0 THEN  "7" ELSE wdetail.seat
        /*wdetail.caryear =  string(YEAR(TODAY),"9999") */  
        /*wdetail.prempa  = fi_pack*/    .
    DISP fi_process WITH FRAM fr_main.
    IF (wdetail.subclass = "") OR (LENGTH(wdetail.subclass) < 3 ) THEN DO:
        ASSIGN wdetail.prempa = fi_pack.
        IF      index(wdetail.model,"vios")     <> 0 THEN wdetail.subclass = "110".
        ELSE IF index(wdetail.model,"altis")    <> 0 THEN wdetail.subclass = "110".
        ELSE IF index(wdetail.model,"avanza")   <> 0 THEN wdetail.subclass = "110".
        ELSE IF index(wdetail.model,"camry")    <> 0 THEN wdetail.subclass = "110".
        ELSE IF index(wdetail.model,"wish")     <> 0 THEN wdetail.subclass = "110".
        ELSE IF index(wdetail.model,"fortuner") <> 0 THEN wdetail.subclass = "110".
        ELSE IF index(wdetail.model,"innova")   <> 0 THEN wdetail.subclass = "110".
        ELSE IF index(wdetail.model,"commuter") <> 0 OR
                index(wdetail.model,"hiace")    <> 0 OR
                index(wdetail.model,"VENTURY")  <> 0 THEN 
            ASSIGN wdetail.subclass = "210"
                   wdetail.seat = "12".
        ELSE wdetail.subclass = "110".
    END.
    ELSE DO:
        IF LENGTH(wdetail.subclass) > 3  THEN  
            ASSIGN wdetail.prempa    = SUBSTR(wdetail.subclass,1,1)
                   wdetail.subclass  = SUBSTR(wdetail.subclass,2,3).
    END.
    IF      wdetail.subclass = "110" THEN wdetail.seat = "7".
    ELSE IF wdetail.subclass = "120" THEN wdetail.seat = "7".
    ELSE IF wdetail.subclass = "210" THEN wdetail.seat = "12".
    ELSE IF wdetail.subclass = "220" THEN wdetail.seat = "12".
    ELSE IF wdetail.subclass = "320" THEN wdetail.seat = "3".
    ELSE IF wdetail.subclass = "520" THEN wdetail.seat = "3".
    /*IF wdetail.prepol <> "" THEN RUN proc_cutchar.*/
    /*IF wdetail.road <> "" THEN wdetail.road = "ถนน" + wdetail.road. */
    IF wdetail.vehreg = "" THEN 
        ASSIGN wdetail.vehreg   = "/" + SUBSTRING(wdetail.chasno,9,LENGTH(wdetail.chasno)) . 
    ELSE RUN proc_vehregprovin.
    /*RUN  proc_assign2_insnam.*/
    RUN  proc_assign2_ben.
    FIND FIRST stat.insure USE-INDEX Insure06 WHERE 
        stat.insure.lname  = wdetail.deler AND
        stat.insure.compno = "TIB" NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL stat.insure THEN DO:
        ASSIGN           
        wdetail.deler      = stat.insure.insno                 
        /*wdetail.vatcode  = stat.insure.vatcode*/
        wdetail.br_sta     = stat.insure.addr3      /*kridtiya i. A53-0351 เก็บสถานะการนำเข้าสาขา เข้า/ไม่เข้า */
        wdetail.financecd  = stat.Insure.Text3     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
        wdetail.vatcode    = stat.insure.vatcode .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        /*IF INDEX(wdetail.insnam," ") <> 0 THEN
            IF index(wdetail.vatcode,SUBSTR(TRIM(wdetail.insnam),1,index(TRIM(wdetail.insnam)," "))) <> 0 THEN 
                ASSIGN  wdetail.vatcode  = "".
            ELSE ASSIGN 
                wdetail.vatcode  = stat.insure.vatcode .
        ELSE DO: 
            IF index(wdetail.vatcode,wdetail.insnam) <> 0  THEN 
                 ASSIGN  wdetail.vatcode  = "".
            ELSE ASSIGN  wdetail.vatcode  = stat.insure.vatcode .
        END.*//*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
         
    END.
    ELSE
        ASSIGN  wdetail.deler = ""
            wdetail.financecd  = ""  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020 Finance Code*/
            wdetail.vatcode = "" 
            wdetail.br_sta  = ""  .            /*kridtiya i. A53-0351 เก็บสถานะการนำเข้าสาขา เข้า/ไม่เข้า */
    IF wdetail.poltyp = "v70" THEN DO:
        IF  wdetail.nSTATUS2 = "N"  THEN wdetail.garage = "G" .  /*add kridtiya i.   A54-0178 เพิ่ม Garage*/
        IF (wdetail.nSTATUS2 = "N") AND (wdetail.access = "" ) THEN
            wdetail.access = "คุ้มครองอุปกรณ์เสริมไม่เกิน 30,000 บาท".
        /*IF index(wdetail.ncd,"3") = 0  THEN  wdetail.vatcode  = "". */
        IF wdetail.ncd = "K3GZ" THEN  wdetail.vatcode  = "MC44771". /* รหัส K3GZ >> ออกใบเสร็จในนาม โตโยต้า ลีสซิ่ง จับจาก VAT CODE : MC44771*/
        ELSE IF wdetail.ncd <> "K3GD" THEN DO: 
             IF wdetail.ncd <> "KCGZ" THEN  wdetail.vatcode = "" .
        END. 
    END.
    ELSE DO:   /* v72 */
        /*IF index(wdetail.ccd,"3") = 0  THEN  wdetail.vatcode  = "".*//*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        IF wdetail.ncd = "K3GZ" THEN  wdetail.vatcode  = "MC44771". /* รหัส K3GZ >> ออกใบเสร็จในนาม โตโยต้า ลีสซิ่ง จับจาก VAT CODE : MC44771*/
        ELSE IF wdetail.ncd <> "K3GD" THEN DO: 
             IF wdetail.ncd <> "KCGZ" THEN  wdetail.vatcode = "" .
        END. 
    END.
    IF wdetail.nSTATUS2 <> "N" THEN wdetail.vatcode  = "".
    IF wdetail.vatcode NE ""  THEN DO:
        FIND FIRST sicsyac.xmm600 WHERE sicsyac.xmm600.acno =  wdetail.vatcode NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm600 THEN 
            ASSIGN   wdetail.NAME2 = "และ/หรือ บริษัท " +  trim(sicsyac.xmm600.name) .
        ELSE wdetail.NAME2 = "".
             /*IF wdetail.prepol <> ""  THEN DO:
                IF (SUBSTR(wdetail.prepol,1,1) >= "1") AND (SUBSTR(wdetail.prepol,1,1) <= "9") THEN 
                    wdetail.n_branch = SUBSTR(wdetail.prepol,1,2).
                ELSE wdetail.n_branch = SUBSTR(wdetail.prepol,2,1).
            END.*/
    END.
    IF wdetail.tiname = "" THEN DO:
        FIND FIRST brstat.msgcode USE-INDEX MsgCode01 WHERE
            index(wdetail.insnam,brstat.msgcode.MsgDesc) <> 0  NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.msgcode  THEN 
            ASSIGN wdetail.tiname = brstat.msgcode.branch
                wdetail.insnam    = trim(SUBSTR(wdetail.insnam,LENGTH(trim(brstat.msgcode.branch)) + 1 )).
        ELSE wdetail.tiname = "".
    END.
    ELSE DO:
        FIND FIRST brstat.msgcode USE-INDEX MsgCode01 WHERE
            brstat.msgcode.MsgDesc = wdetail.tiname  NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.msgcode  THEN 
            ASSIGN wdetail.tiname = brstat.msgcode.branch.
    END.
    
END.
/*kridtiya i. Ad53-0310*/
ASSIGN n_wdetail = 0.
FOR EACH wdetail WHERE wdetail.policy  <> "".
    ASSIGN n_wdetail = n_wdetail + 1.
    /*comment by kridtiya i. A53-0351 
    IF wdetail.n_branch = "L" THEN DO: 
    DELETE wdetail.
    DELETE wdetail2.
    MESSAGE "พบกรมธรรม์ สาขา L ไม่นำเข้าระบบ"  VIEW-AS ALERT-BOX.
    END.
    ELSE IF wdetail.n_branch = "14" THEN DO:
    DELETE wdetail.
    DELETE wdetail2.
    MESSAGE "พบกรมธรรม์ สาขา 14 ไม่นำเข้าระบบ"  VIEW-AS ALERT-BOX.
    END.
    ELSE IF (wdetail.n_branch = "") OR (wdetail.policy = "") THEN DO:
    DELETE wdetail.
    DELETE wdetail2.
    END.  
    end.....comment by kridtiya i. A53-0351 */
    /*Add by Kridtiya i. A63-0472*/
    wdetail.br_insured = "00000".
    RUN proc_assign2addr (INPUT  TRIM(wdetail.add1) + " " + TRIM(wdetail.add2)   
                         ,INPUT  TRIM(wdetail.add3)
                         ,INPUT  TRIM(wdetail.add4) 
                         ,INPUT  wdetail.occup   
                         ,OUTPUT wdetail.codeocc  
                         ,OUTPUT wdetail.codeaddr1
                         ,OUTPUT wdetail.codeaddr2
                         ,OUTPUT wdetail.codeaddr3).
    RUN proc_matchtypins (INPUT  wdetail.tiname  
                         ,INPUT  trim(wdetail.insnam)
                         ,OUTPUT wdetail.insnamtyp
                         ,OUTPUT wdetail.firstName
                         ,OUTPUT wdetail.lastName) .
    /*Add by Kridtiya i. A63-0472*/

    IF INDEX(wdetail.br_sta,"no" ) <> 0 THEN 
        MESSAGE "พบกรมธรรม์ สาขา: " wdetail.n_branch "ไม่นำเข้าระบบ status = NO"  VIEW-AS ALERT-BOX WARNING.
    ELSE IF (wdetail.n_branch = "")  THEN DO:
        MESSAGE "พบกรมธรรม์ สาขาเป็นค่าว่าง: " wdetail.policy "ไม่นำเข้าระบบ /ไม่พบดีเลอร์นี้" wdetail.deler  VIEW-AS ALERT-BOX WARNING.
        DELETE wdetail.
    END.
END.  /*kridtiya i. Ad53-0310*/
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
DEFINE VAR nv_postcd    as char init "".
DEFINE VAR nv_address   as char init "".

ASSIGN nv_address = trim(np_tambon + " " + np_mail_amper + " " + np_mail_country) .
IF      R-INDEX(nv_address,"จ.")       <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จ.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จ.")       - 1 )). 
ELSE IF R-INDEX(nv_address,"จังหวัด.") <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จังหวัด.")   + 8 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จังหวัด.") - 1 )). 
ELSE IF R-INDEX(nv_address,"จังหวัด")  <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จังหวัด")    + 7 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จังหวัด")  - 1 )). 
ELSE IF R-INDEX(nv_address,"กรุงเทพ")  <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"กรุงเทพ")    + 7 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"กรุงเทพ")  - 1 )).
/*IF index(np_mail_country," ") <> 0  THEN 
    ASSIGN 
    nv_postcd       = trim(SUBSTR(np_mail_country,index(np_mail_country," ")))
    wdetail.postcd  = trim(SUBSTR(np_mail_country,index(np_mail_country," ")))
    np_mail_country = trim(SUBSTR(np_mail_country,1,index(np_mail_country," ") - 1 )).*/

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
        ELSE np_codeocc  = trim(np_occupation) .
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2_ben c-Win 
PROCEDURE proc_assign2_ben :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*IF wdetail.benname = "TLT" THEN wdetail.benname = "บริษัทโตโยต้าลีสซิ่งจำกัด".*//*kridtiya i. A53-0263*/
IF wdetail.benname = "TLT" THEN wdetail.benname = "บจก.โตโยต้าลีสซิ่ง (ปทท.)".    /*kridtiya i. A53-0263*/
ELSE IF wdetail.benname = "W01" THEN wdetail.benname = "บมจ. เงินทุน เอไอจี ไฟแนนซ์ (ประเทศไทย)".
ELSE IF wdetail.benname = "W02" THEN wdetail.benname = "บมจ. นวลิสซิ่ง".
ELSE IF wdetail.benname = "W03" THEN wdetail.benname = "ธนาคาร ทิสโก้ จำกัด (มหาชน)".
ELSE IF wdetail.benname = "W04" THEN wdetail.benname = "บจก.ตรีเพชรอีซูซุลีสซิ่ง".
ELSE IF wdetail.benname = "W05" THEN wdetail.benname = "ธนาคาร เกียรตินาคิน จำกัด (มหาชน)".
ELSE IF wdetail.benname = "W06" THEN wdetail.benname = "บมจ. เงินทุน สินอุตสาหกรรม".
ELSE IF wdetail.benname = "W07" THEN wdetail.benname = "บริษัท ซัมมิท แคปปิตอล ลีสซิ่ง".
ELSE IF wdetail.benname = "W08" THEN wdetail.benname = "บจก. สแตนดาร์ด ชาร์เตอร์ (ประเทศไทย)".
ELSE IF wdetail.benname = "W09" THEN wdetail.benname = "บมจ. อยุธยา แคปปิตอล ออโต้ ลีส".
ELSE IF wdetail.benname = "W10" THEN wdetail.benname = "บจก. ไพรมัส ลีสซิ่ง".
ELSE IF wdetail.benname = "W11" THEN wdetail.benname = "บมจ. เอเซียเสริมกิจลีสซิ่ง".
ELSE IF wdetail.benname = "W12" THEN wdetail.benname = "ธนาคาร ธนชาต จำกัด (มหาชน)".
ELSE IF wdetail.benname = "W13" THEN wdetail.benname = "บจก. ยู เอ็ม แอล ลีสซิ่ง".
ELSE IF wdetail.benname = "W14" THEN wdetail.benname = "บจก. ยูไนเต็ดลีสซิ่ง".
ELSE IF wdetail.benname = "W15" THEN wdetail.benname = "บมจ. ไทยพาณิชย์ลีสซิ่ง".
ELSE IF wdetail.benname = "W16" THEN wdetail.benname = "บจก. ชยภาค".
ELSE IF wdetail.benname = "W17" THEN wdetail.benname = "บจก. พระนคร ยนตการ".
ELSE IF wdetail.benname = "W18" THEN wdetail.benname = "บจก. ซิตี้คอร์ป ลีสซิ่ง (ประเทศไทย)".
ELSE IF wdetail.benname = "W19" THEN wdetail.benname = "บจก. เจนเนอรัล มอเตอร์ส แอคเซพแตนซ์ คอร์ปอเรชั่น(ประเทศไทย)".
ELSE IF wdetail.benname = "W20" THEN wdetail.benname = "บจก. กรุงเทพทรัพย์ถาวร".
ELSE IF wdetail.benname = "W21" THEN wdetail.benname = "บจก. บีเอ็มดับเบิลยู ลีสซิ่ง (ประเทศไทย)".
ELSE IF wdetail.benname = "W22" THEN wdetail.benname = "บมจ. สแกนดิเนเวียลีสซิ่ง".
ELSE IF wdetail.benname = "W23" THEN wdetail.benname = "บมจ. ราชธานีลีสซิ่ง".
ELSE IF wdetail.benname = "W24" THEN wdetail.benname = "บจก. เดมเลอร์ไครสเลอร์ ลีสซิ่ง (ประเทศไทย)".
ELSE IF wdetail.benname = "W25" THEN wdetail.benname = "บจก. ตะวันออกพาณิชย์ลีสซิ่ง (ประเทศไทย)".
ELSE IF wdetail.benname = "W26" THEN wdetail.benname = "บมจ. จีอี แคปปิตอล ออโต้ ลีส".
ELSE IF wdetail.benname = "W27" THEN wdetail.benname = "บจก. ไทยประกันชีวิต".
ELSE IF wdetail.benname = "W28" THEN wdetail.benname = "บจก. คลังเศรษฐการ".
ELSE IF wdetail.benname = "W29" THEN wdetail.benname = "บจก. เอ. ที ลีสซิ่ง".
ELSE IF wdetail.benname = "W30" THEN wdetail.benname = "บจก. ทวีทรัพย์สมเด็จ".
ELSE IF wdetail.benname = "W31" THEN wdetail.benname = "บจก. กรุงไทย ออโตลีส".
ELSE IF wdetail.benname = "W32" THEN wdetail.benname = "บจก. ลีสซิ่งกสิกรไทย".
ELSE IF wdetail.benname = "W33" THEN wdetail.benname = "บจก. บีที ลีสซิ่ง".
ELSE IF wdetail.benname = "W34" THEN wdetail.benname = "บจก. ลีสซิ่งสินเอเซีย".
ELSE IF wdetail.benname = "W35" THEN wdetail.benname = "บจก. เคทีบี ลีสซิ่ง".
ELSE IF wdetail.benname = "W36" THEN wdetail.benname = "บจก.โตโยต้า มอเตอร์ ประเทศไทย".
ELSE IF wdetail.benname = "W37" THEN wdetail.benname = "บจก.บางกอก มิตซูบิชิ ยูเอฟเจ ลิส".
ELSE IF wdetail.benname = "W38" THEN wdetail.benname = "ธนาคาร ไทยเครดิต เพื่อรายย่อย จำกัด (มหาชน)".
ELSE IF wdetail.benname = "W39" THEN wdetail.benname = "บจก. เงินทุน ฟินันซ่า".
ELSE IF wdetail.benname = "W40" THEN wdetail.benname = "บจก. โปรออโต้ลีส".
ELSE IF wdetail.benname = "W41" THEN wdetail.benname = "บจก.โตโยต้า สุรินทร์(1991)".
ELSE IF wdetail.benname = "W42" THEN wdetail.benname = "ธนาคารเอไอจี เพื่อรายย่อย จำกัด(มหาชน)".
ELSE IF wdetail.benname = "w43" THEN wdetail.benname = "ธนาคารไทยพาณิชย์ จำกัด (มหาชน)".
ELSE IF wdetail.benname = "w44" THEN wdetail.benname = "บจก.ไทยโอริกซ์ลีสซิ่ง".
ELSE IF wdetail.benname = "w45" THEN wdetail.benname = "บจก.ทิสโก้ โตเกียว ลิสซิ่ง".
ELSE IF wdetail.benname = "w46" THEN wdetail.benname = "บจก.ซูมิโตโม มิตซุย ออโต้ ลิสซิ่ง แอนด์ เซอร์วิส (ไทยแลนด์)".
ELSE IF wdetail.benname = "w47" THEN wdetail.benname = "บจก.โตโยต้าชุมพร ผู้จำหน่ายโตโยต้า ".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2_insnam c-Win 
PROCEDURE proc_assign2_insnam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_i AS CHAR.
DEF VAR nv_c AS CHAR FORMAT "x(50)".
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
ASSIGN nv_c = trim(wdetail.insnam)
    nv_i = ""
    nv_l = LENGTH(nv_c)
    ind = 0.
IF INDEX(nv_c,"คุณ") NE  0 THEN 
    ASSIGN  ind = 4 
    wdetail.insnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"นาย") NE  0 THEN 
    ASSIGN  ind = 4 
    nv_i = "นาย"
    wdetail.insnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"น.ส.") NE  0 THEN 
    ASSIGN  ind = 5 
    wdetail.insnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"นางสาว ") NE 0  THEN 
    ASSIGN  ind = 7
    wdetail.insnam = TRIM(SUBSTR(nv_c,ind,nv_l)).
ELSE IF INDEX(nv_c,"นาง") NE 0  THEN 
    ASSIGN  ind = 4
    wdetail.insnam = TRIM(SUBSTR(nv_c,ind,nv_l)).      
nv_c = "".*/
/*
FIND FIRST brstat.msgcode USE-INDEX MsgCode01 WHERE
    INDEX(trim(wdetail.insnam),TRIM(brstat.msgcode.MsgDesc)) <> 0 NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL brstat.msgcode  THEN DO:
    /*IF (brstat.msgcode.MsgDesc = "บจก.") OR (brstat.msgcode.MsgDesc = "บริษัท") OR (brstat.msgcode.MsgDesc = "หจก.") THEN
        wdetail.tiname = brstat.msgcode.branch.*/
    ASSIGN wdetail.tiname = brstat.msgcode.branch
        wdetail.insnam = substr(trim(wdetail.insnam),LENGTH(brstat.msgcode.MsgDesc) + 2).
END.*/
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
/*IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.*//*kridtiya i. A54-0062 */
/*Add kridtiya i. A54-0062 */
DEF VAR number_sic AS INTE INIT 0.
DEFINE VAR nre_premt      AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/
ASSIGN nre_premt = 0.
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
/*end...kridtiya i. A54-0062 */
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwtbex2 (INPUT-OUTPUT  wdetail.prepol,     
                      INPUT-OUTPUT  wdetail.prempa,     
                      INPUT-OUTPUT  wdetail.subclass,   
                      INPUT-OUTPUT  wdetail.redbook,    
                      INPUT-OUTPUT  wdetail.brand,      
                      INPUT-OUTPUT  wdetail.model,      
                      INPUT-OUTPUT  wdetail.caryear,     
                      INPUT-OUTPUT  wdetail.engcc,                            
                      INPUT-OUTPUT  wdetail.cargrp,                
                      INPUT-OUTPUT  wdetail.body,           
                      INPUT-OUTPUT  wdetail.weight,                         
                      INPUT-OUTPUT  wdetail.seat,                          
                      INPUT-OUTPUT  wdetail.vehuse,            
                      INPUT-OUTPUT  wdetail.covcod,         
                      INPUT-OUTPUT  wdetail.garage,                
                      INPUT-OUTPUT  wdetail.vehreg,        
                      INPUT-OUTPUT  wdetail.chasno,        
                      INPUT-OUTPUT  wdetail.eng,           
                      INPUT-OUTPUT  nv_uom1_v,                              
                      INPUT-OUTPUT  nv_uom2_v,                              
                      INPUT-OUTPUT  nv_uom5_v,                              
                      INPUT-OUTPUT  WDETAIL.deductpd,                       
                      INPUT-OUTPUT  WDETAIL.deductpd2,                      
                      INPUT-OUTPUT  nv_basere,                               
                      INPUT-OUTPUT  wdetail.seat41,                          
                      INPUT-OUTPUT  n_41,                             
                      INPUT-OUTPUT  n_42,                             
                      INPUT-OUTPUT  n_43,                             
                      INPUT-OUTPUT  nv_dedod,                        
                      INPUT-OUTPUT  nv_ded,                          
                      INPUT-OUTPUT  wdetail.fleet,                     
                      INPUT-OUTPUT  wdetail.NCB,                     
                      INPUT-OUTPUT  nv_dss_per,                      
                      INPUT-OUTPUT  nv_stf_per,                      
                      INPUT-OUTPUT  nv_cl_per,                       
                      INPUT-OUTPUT  wdetail.firstdat,      
                      INPUT-OUTPUT  wdetail.benname,
                      INPUT-OUTPUT  nre_premt)  . 
    ASSIGN 
        wdetail.premt = string(nre_premt)  .

    /*IF (SUBSTR(wdetail.prepol,1,1) >= "0") AND (SUBSTR(wdetail.prepol,1,1) <= "9") THEN 
        wdetail.n_branch =  SUBSTR(wdetail.prepol,1,2) .
    ELSE wdetail.n_branch =  SUBSTR(wdetail.prepol,2,1) . */

END.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignwdetail c-Win 
PROCEDURE proc_assignwdetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2 NO-LOCK.
    ASSIGN fi_process = "Import text file tib to wdetail...".
    DISP fi_process WITH FRAM fr_main.
    
    IF (wdetail2.effecdat <> "00/00/0000") AND (wdetail2.grpssprem <> "0" ) THEN DO:  /*create 70*/
        FIND FIRST wdetail WHERE 
            wdetail.policy = "D70" + trim(wdetail2.contractno)  NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO: 
            CREATE wdetail.
            ASSIGN  
                wdetail.policy       = "D70" + trim(wdetail2.contractno)       
                wdetail.cndat        = TRIM(SUBSTRING(wdetail2.senddat,7,2)) + "/" + TRIM(SUBSTRING(wdetail2.senddat,5,2)) + "/" + TRIM(SUBSTRING(wdetail2.senddat,1,4))                    
                wdetail.appenno      = TRIM(wdetail2.contractno)                                                  
                wdetail.comdat       = TRIM(wdetail2.effecdat) 
                wdetail.expdat       = TRIM(wdetail2.norcovdat)   
                wdetail.active       = TRIM(wdetail2.recact)     
                wdetail.nSTATUS      = TRIM(wdetail2.STATUSno) 
                wdetail.nSTATUS2     = TRIM(wdetail2.renewtyp)  
                wdetail.flag         = TRIM(wdetail2.flag)      
                wdetail.covcod       = TRIM(wdetail2.covcod)       
                wdetail.seqno        = TRIM(wdetail2.seqno)     
                wdetail.garage       = IF TRIM(wdetail2.GarageType) = "01" OR  TRIM(wdetail2.GarageType) = "1" THEN "G" ELSE ""      
                wdetail.lotno        = TRIM(wdetail2.lotno)  
                wdetail.n_branch     = TRIM(wdetail2.branch)
                wdetail.tiname       = trim(wdetail2.tiname)     
                wdetail.insnam       = TRIM(wdetail2.insname)         
                wdetail.name2        = "" 
                wdetail.vatcode      = TRIM(wdetail2.NAMEpay) 
                /*wdetail.add1         = TRIM(wdetail2.add1) + " " + TRIM(wdetail2.add2) 
                wdetail.add2         = TRIM(wdetail2.add3)    
                wdetail.add3         = TRIM(wdetail2.add4) + " " + TRIM(wdetail2.add5) 
                wdetail.add4         = ""*/
                wdetail.add1         = TRIM(wdetail2.add1)   /*A55-0197*/ 
                wdetail.add2         = TRIM(wdetail2.add2)   /*A55-0197*/ 
                wdetail.add3         = TRIM(wdetail2.add3)   /*A55-0197*/ 
                wdetail.add4         = TRIM(wdetail2.add4)   /*A55-0197*/ 
                wdetail.brand        = TRIM(wdetail2.brand)        
                wdetail.chasno       = TRIM(wdetail2.chasno)   
                wdetail.eng          = TRIM(wdetail2.engno)   
                wdetail.model        = TRIM(wdetail2.model)
                wdetail.caryear      = TRIM(wdetail2.caryear)       
                wdetail.vehuse       = IF TRIM(substr(wdetail2.class,2,3)) = "120" THEN "2" ELSE IF TRIM(substr(wdetail2.class,2,3)) = "520" THEN "2" ELSE "1"      
                wdetail.seat         = "7"        
                wdetail.engcc        = TRIM(wdetail2.cc)       
                wdetail.vehreg       = TRIM(wdetail2.reg1) + " " + TRIM(wdetail2.reg2)        
                wdetail.re_country   = TRIM(wdetail2.provinco)  
                wdetail.ncd          = TRIM(wdetail2.subinsco)     
                wdetail.si           = TRIM(wdetail2.covamount) 
                wdetail.comprem      = trim(wdetail2.comprem)
                wdetail.stk          = trim(wdetail2.comprem) + "/" + trim(REPLACE(wdetail2.compno,"'",""))
                wdetail.premt        = TRIM(wdetail2.grpssprem)
                wdetail.benname      = TRIM(wdetail2.noticode)
                wdetail.ccd          = TRIM(wdetail2.substyname)
                /* wdetail.drivername1  = TRIM(wdetail2.drivnam1)       
                wdetail.ddriveno     = TRIM(wdetail2.drino1)           
                wdetail.drivername2  = TRIM(wdetail2.drivnam2)
                wdetail.dddriveno    = TRIM(wdetail2.drino2)  */   
                /*wdetail.comper       = ""      
                wdetail.comacc       = ""   */
                wdetail.deductpd     = 0   
                /*wdetail.tp2          = ""  */ 
                wdetail.deductda     = ""   
                /*wdetail.deduct       = ""  */
                wdetail.deductpd2    = deci(TRIM(wdetail2.covamount))   
                wdetail.compul       = "y" 
                wdetail.prepol       = TRIM(wdetail2.prvpol)  
                wdetail.deler        = TRIM(wdetail2.delercode)
                wdetail.poltyp       = "V70"
                wdetail.tariff       = "x" 
                wdetail.prempa       = TRIM(substr(wdetail2.class,1,1))
                wdetail.subclass     = TRIM(substr(wdetail2.class,2,3))
                wdetail.comment      = ""
                wdetail.producer     = TRIM(wdetail2.producer)
                wdetail.agent        = TRIM(wdetail2.agent)      
                wdetail.entdat       = string(TODAY)                /*entry date*/
                wdetail.enttim       = STRING (TIME, "HH:MM:SS")    /*entry time*/
                wdetail.trandat      = STRING (fi_loaddat)          /*tran date*/
                wdetail.trantim      = STRING (TIME, "HH:MM:SS")    /*tran time*/
                wdetail.n_IMPORT     = "IM"
                wdetail.n_EXPORT     = "" 
                wdetail.compul       = "n"
                wdetail.access       = trim(wdetail2.access)
                wdetail.icno         = wdetail2.Reserved6     /*Add by Kridtiya i. A63-0472*/
                wdetail.postcd       = trim(wdetail2.add5).    /*Add by Kridtiya i. A63-0472*/
            IF trim(wdetail2.DriverFlag) = "Y" THEN DO:
                ASSIGN
                wdetail.Driver1name    = TRIM(wdetail2.Driver1name)        
                wdetail.Driver1DOB     = TRIM(wdetail2.Driver1DOB)        
                wdetail.Driver1License = TRIM(wdetail2.Driver1License)
                wdetail.Driver2name    = TRIM(wdetail2.Driver2name)   
                wdetail.Driver2DOB     = TRIM(wdetail2.Driver2DOB)    
                wdetail.Driver2License = TRIM(wdetail2.Driver2License).
            END.

        END.  /*end..not avail */
    END.      /*end... policy 70 */
    IF (wdetail2.comeffecdat <> "00/00/0000") AND (wdetail2.comprem <> "0" ) THEN DO:   /*comp 72 */
        FIND FIRST wdetail WHERE wdetail.policy = "D72" + trim(wdetail2.contractno)  NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN  
                wdetail.policy       = "D72" + trim(wdetail2.contractno)      
                wdetail.cndat        = TRIM(SUBSTRING(wdetail2.senddat,7,2)) + "/" + TRIM(SUBSTRING(wdetail2.senddat,5,2)) + "/" + TRIM(SUBSTRING(wdetail2.senddat,1,4))                    
                wdetail.appenno      = TRIM(wdetail2.contractno)                                                  
                wdetail.comdat       = TRIM(wdetail2.comeffecdat)       
                wdetail.expdat       = TRIM(wdetail2.norcovenddat)
                wdetail.active       = TRIM(wdetail2.recact)     
                wdetail.nSTATUS      = TRIM(wdetail2.STATUSno) 
                wdetail.nSTATUS2     = TRIM(wdetail2.renewtyp)     
                wdetail.flag         = TRIM(wdetail2.flag)      
                wdetail.covcod       = "T"     
                wdetail.seqno        = TRIM(wdetail2.seqno)     
                wdetail.garage       = ""         
                wdetail.lotno        = TRIM(wdetail2.lotno)       
                wdetail.n_branch     = TRIM(wdetail2.branch)
                wdetail.tiname       = trim(wdetail2.tiname)     
                wdetail.insnam       = TRIM(wdetail2.insname)         
                wdetail.name2        = ""  
                /*A55-0197
                wdetail.add1       = TRIM(wdetail2.add1) + " " + TRIM(wdetail2.add2) 
                wdetail.add2         = TRIM(wdetail2.add3)    
                wdetail.add3         = TRIM(wdetail2.add4) + " " + TRIM(wdetail2.add5) 
                wdetail.add4         = ""
                A55-0197*/
                wdetail.add1         = TRIM(wdetail2.add1)  /*A55-0197*/
                wdetail.add2         = TRIM(wdetail2.add2)  /*A55-0197*/
                wdetail.add3         = TRIM(wdetail2.add3)  /*A55-0197*/
                wdetail.add4         = TRIM(wdetail2.add4)  /*A55-0197*/
                wdetail.brand        = TRIM(wdetail2.brand)        
                wdetail.chasno       = TRIM(wdetail2.chasno)   
                wdetail.eng          = TRIM(wdetail2.engno)   
                wdetail.model        = TRIM(wdetail2.model)
                wdetail.caryear      = TRIM(wdetail2.caryear)       
                wdetail.vehuse       = "1"      
                wdetail.seat         = "7"        
                wdetail.engcc        = TRIM(wdetail2.cc)       
                wdetail.vehreg       = TRIM(wdetail2.reg1) + " " + TRIM(wdetail2.reg2)        
                wdetail.re_country   = TRIM(wdetail2.provinco)  
                wdetail.ncd          = TRIM(wdetail2.subinsco)     
                wdetail.si           = TRIM(wdetail2.covamount)  
                wdetail.comprem      = trim(wdetail2.comprem)           /*A63-0259*/
                wdetail.stk          = trim(REPLACE(wdetail2.compno,"'",""))
                wdetail.premt        = TRIM(wdetail2.grpssprem)
                wdetail.benname      = ""    /*TRIM(wdetail2.noticode)*/
                wdetail.ccd          = TRIM(wdetail2.substyname)
                /*wdetail.drivername1  = TRIM(wdetail2.drivnam1)       
                wdetail.ddriveno     = TRIM(wdetail2.drino1)           
                wdetail.drivername2  = TRIM(wdetail2.drivnam2)
                wdetail.dddriveno    = TRIM(wdetail2.drino2)     
                wdetail.comper       = ""      
                wdetail.comacc       = ""   */
                wdetail.deductpd     = 0   
                /*wdetail.tp2        = "" */  
                wdetail.deductda     = ""     
                /*wdetail.deduct     = ""  */ 
                wdetail.deductpd2    = deci(TRIM(wdetail2.covamount))   
                wdetail.compul       = "y" 
                wdetail.prepol       = TRIM(wdetail2.prvpol)  
                wdetail.deler        = TRIM(wdetail2.delercode)
                wdetail.poltyp       = "V72"
                wdetail.tariff       = "9" 
                wdetail.prempa       = TRIM(substr(wdetail2.class,1,1)) 
                wdetail.subclass     = TRIM(substr(wdetail2.class,2,3)) 
                wdetail.comment      = ""
                wdetail.producer     = TRIM(wdetail2.producer)
                wdetail.agent        = TRIM(wdetail2.agent)   
                wdetail.entdat       = string(TODAY)              /*entry date*/
                wdetail.enttim       = STRING(TIME, "HH:MM:SS")   /*entry time*/
                wdetail.trandat      = STRING(fi_loaddat)         /*tran date*/
                wdetail.trantim      = STRING(TIME, "HH:MM:SS")   /*tran time*/
                wdetail.n_IMPORT     = "IM"
                wdetail.n_EXPORT     = "" 
                wdetail.compul       = "y"
                wdetail.icno         = wdetail2.Reserved6     /*Add by Kridtiya i. A63-0472*/
                wdetail.postcd       = trim(wdetail2.add5).    /*Add by Kridtiya i. A63-0472*/
        END.
    END.  /*if ....*/
END.    /*for wdetail2...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_back c-Win 
PROCEDURE proc_assign_back :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT UNFORMATTED c.
    IF  SUBSTRING(c,1,1) = "D"  THEN DO:
        CREATE wdetail.
        CREATE wdetail2.
        IF SUBSTRING(c,479,8) <> "00000000" THEN DO:
            ASSIGN
                wdetail.policyno     = TRIM(SUBSTRING(c,1,1)) + "70" + TRIM(SUBSTRING(c,14,10))         
                wdetail.cndat        = TRIM(SUBSTRING(c,12,2)) + "/" + TRIM(SUBSTRING(c,10,2)) + "/" + TRIM(SUBSTRING(c,6,4))                    
                wdetail.appenno      = TRIM(SUBSTRING(c,14,10))                                                  
                wdetail.comdat       = TRIM(SUBSTRING(c,485,2)) + TRIM(SUBSTRING(c,483,2)) + TRIM(SUBSTRING(c,479,4))         
                wdetail.expdat       = TRIM(SUBSTRING(c,1402,2)) + TRIM(SUBSTRING(c,1400,2)) + TRIM(SUBSTRING(c,1396,4))      
                wdetail.comcode      = TRIM(SUBSTRING(c,2,4))                 
                wdetail.active       = TRIM(SUBSTRING(c,39,1))       
                wdetail.nSTATUS      = TRIM(SUBSTRING(c,40,1))       
                wdetail.flag         = TRIM(SUBSTRING(c,41,1))       
                wdetail.covcod       = "1"           
                wdetail.seqno        = TRIM(SUBSTRING(c,33,6))       
                wdetail.garage       = "G"         
                wdetail.lotno        = TRIM(SUBSTRING(c,24,9))       
                wdetail.tiname       = "คุณ"           
                wdetail.insnam       = TRIM(SUBSTRING(c,42,100))         
                wdetail.name2        = ""                  
                wdetail.name3        = ""                  
                wdetail.addr         = TRIM(SUBSTRING(c,142,50))        
                wdetail.tambon       = TRIM(SUBSTRING(c,192,50))      
                wdetail.amper        = TRIM(SUBSTRING(c,242,50))     
                wdetail.country      = TRIM(SUBSTRING(c,292,50))     
                wdetail.post         = TRIM(SUBSTRING(c,342,5))      
                wdetail.brand        = "TOYOTA"            
                wdetail.chasno       = TRIM(SUBSTRING(c,367,20))    
                wdetail.eng          = TRIM(SUBSTRING(c,347,20))    
                wdetail.model        = TRIM(SUBSTRING(c,390,40))  
                wdetail.caryear      = TRIM(SUBSTRING(c,1416,4))       
                wdetail.vehuse       = "1"      
                wdetail.seat         = "7"        
                wdetail.engcc        = TRIM(SUBSTRING(c,430,5))       
                wdetail.vehreg       = TRIM(SUBSTRING(c,439,5)) + " " + TRIM(SUBSTRING(c,444,5))        
                wdetail.re_country   = TRIM(SUBSTRING(c,449,2))            
                wdetail.ncd          = TRIM(SUBSTRING(c,451,4))     
                wdetail.si           = TRIM(SUBSTRING(c,455,13))    
                wdetail.premt        = TRIM(SUBSTRING(c,468,11)).     
            ASSIGN
                wdetail.benname      = TRIM(SUBSTRING(c,587,4))
                wdetail.ccd          = TRIM(SUBSTRING(c,666,4))
                wdetail.drivername1  = TRIM(SUBSTRING(c,939,30))       
                wdetail.ddriveno     = TRIM(SUBSTRING(c,999,13))           
                wdetail.drivername2  = TRIM(SUBSTRING(c,969,30))     
                wdetail.dddriveno    = TRIM(SUBSTRING(c,1012,13))     
                wdetail.comper       = ""      
                wdetail.comacc       = ""   
                wdetail.deductpd     = ""   
                wdetail.tp2          = ""   
                wdetail.deductda     = ""     
                wdetail.deduct       = ""   
                wdetail.tpfire       = TRIM(SUBSTRING(c,455,13))   
                /*wdetail.prepol       = TRIM(SUBSTRING(c,1501,30))   /*kridtiya i. a530263*/*/
                wdetail.prepol       = TRIM(SUBSTRING(c,1601,30))     /*kridtiya i. a530351*/
                wdetail.compul       = "n" .
            ASSIGN 
                wdetail2.policyno     =  TRIM(SUBSTRING(c,1,1)) + "70" + TRIM(SUBSTRING(c,14,10)) 
                wdetail2.nstatus      =  TRIM(SUBSTRING(c,1420,1))     /*A = new, R= renew */   
                wdetail2.typrequest   =  TRIM(SUBSTRING(c,487,100)) 
                wdetail2.comrequest   =  CAPS(TRIM(SUBSTRING(c,1412,4)))   
                wdetail2.brrequest    =  TRIM(SUBSTRING(c,591,25))  
                wdetail2.salename     =  TRIM(SUBSTRING(c,616,50))  
                wdetail2.comcar       =  TRIM(SUBSTRING(c,666,4)) 
                wdetail2.brcar        =  TRIM(SUBSTRING(c,702,25))    /*kridtiya i. a530263   */
                wdetail2.access       =  TRIM(SUBSTRING(c,1501,100))  /*kridtiya i. A53-0351 */
                wdetail2.poltyp       = "V70"
                wdetail2.subclass     = "110"
                wdetail2.seat41       = INTE(wdetail.seat) 
                wdetail2.comment  = ""
                wdetail2.agent    = fi_agent
                wdetail2.producer = fi_producer     
                wdetail2.entdat   = string(TODAY)                /*entry date*/
                wdetail2.enttim   = STRING (TIME, "HH:MM:SS")    /*entry time*/
                wdetail2.trandat  = STRING (fi_loaddat)          /*tran date*/
                wdetail2.trantim  = STRING (TIME, "HH:MM:SS")    /*tran time*/
                wdetail2.n_IMPORT = "IM"
                wdetail2.n_EXPORT = ""  .
        END.
        IF (TRIM(SUBSTRING(c,683,11)) <> "00000000000") THEN DO: 
            IF  (TRIM(SUBSTRING(c,683,11)) <> "")   THEN DO:
                CREATE wdetail.
                CREATE wdetail2.
                RUN proc_assign_v72.
            END.
        END.
    END.
END.           /*-Repeat-*/
INPUT CLOSE.   /*close Import*/
RUN proc_assign2.*/
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
DEF VAR chk   AS LOGICAL.
DEF VAR nseat AS CHAR INIT "".
ASSIGN dod0 = 0
       dod1 = 0
       dod2 = 0
       nseat = ""
       /*nv_dss_per =  0   */        
       nv_dedod   =  0
       n_prem  = 0
       fi_process = "Generate base ncb dspc . ".
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "v70" THEN DO:
    /*IF (wdetail.prepol = "") AND (index(wdetail.model,"camry") <> 0 ) THEN RUN proc_dssper8.*/
    IF  wdetail.prepol <> ""  THEN  aa = nv_basere.
    ELSE IF  wdetail.covcod = "3"  THEN DO:
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ELSE IF wdetail.n_branch = "8" THEN DO:
        FIND FIRST brstat.insure WHERE 
            brstat.insure.InsNo    = fi_campaign                        AND 
            brstat.insure.Text3    = wdetail.prempa + wdetail.subclass  AND
            brstat.insure.Deci2    = deci(wdetail.si)                   AND 
            ((deci(brstat.insure.PostCode)    = deci(wdetail.premt))     OR
            (round(deci(brstat.insure.PostCode),0) = deci(wdetail.premt)))    NO-LOCK NO-ERROR NO-WAIT. 
        IF AVAIL brstat.insure THEN
            ASSIGN aa     =  deci(brstat.insure.Text4)  
            nv_dss_per    =  deci(brstat.insure.Text5)                            
            nv_dedod      =  brstat.insure.Deci1        
            nseat         =  brstat.insure.ICNo   .   
        ELSE ASSIGN 
            aa            =  0
            nv_dss_per    =  0           
            nv_dedod      =  0    
            nseat         = ""   .
        IF aa =  0 THEN DO:
            FIND FIRST brstat.insure WHERE 
                brstat.insure.InsNo    = fi_campaign                        AND 
                brstat.insure.Text3    = wdetail.prempa + wdetail.subclass  AND
              ((brstat.insure.Deci2   >= (deci(wdetail.si) - ((deci(wdetail.si) * 5 ) / 100)))  AND
               (brstat.insure.Deci2   <= (deci(wdetail.si) + ((deci(wdetail.si) * 5 ) / 100))))  AND
              ((deci(brstat.insure.PostCode)    = deci(wdetail.premt))      OR
               (deci(brstat.insure.PostCode) - deci(brstat.insure.ICAddr4))    = deci(wdetail.premt) OR 
               (ROUND((deci(brstat.insure.PostCode) - deci(brstat.insure.ICAddr4)),0)  = deci(wdetail.premt))     OR
               ((ROUND((deci(brstat.insure.PostCode) - deci(brstat.insure.ICAddr4)),0) + 1 )  = deci(wdetail.premt)) OR
               (round(deci(brstat.insure.PostCode),0)  = deci(wdetail.premt) - 1 ) OR 
               (round(deci(brstat.insure.PostCode),0)  = round(deci(wdetail.premt),0 )) OR 
               (round(deci(brstat.insure.PostCode) - deci(wdetail.comprem),0)  = deci(wdetail.premt)) OR 
               (round(deci(brstat.insure.PostCode) - deci(wdetail.comprem),0)  = ROUND(deci(wdetail.premt),0)) OR 
               (deci(brstat.insure.PostCode) - deci(wdetail.comprem)   = deci(wdetail.premt)))    NO-LOCK NO-ERROR NO-WAIT. 
            IF AVAIL brstat.insure THEN
                ASSIGN aa     =  deci(brstat.insure.Text4)  
                nv_dss_per    =  deci(brstat.insure.Text5)                            
                nv_dedod      =  brstat.insure.Deci1    
                nseat         =  brstat.insure.ICNo   .                   
            ELSE ASSIGN 
                aa            =  0
                nv_dss_per    =  0           
                nv_dedod      =  0    
                nseat         = ""   .
            IF aa = 0 THEN DO:
                FIND FIRST brstat.insure WHERE 
                    brstat.insure.InsNo    = fi_campaign  AND 
                    brstat.insure.Text3    = wdetail.prempa + wdetail.subclass  AND
                    brstat.insure.Deci2    = deci(wdetail.si)      AND 
                    deci(brstat.insure.ICAddr4)  = deci(wdetail.comprem) AND
                    round(deci(brstat.insure.PostCode),0)  =    round(deci(wdetail.premt),0) NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.insure THEN
                    ASSIGN aa     =  deci(brstat.insure.Text4)  
                    nv_dss_per    =  deci(brstat.insure.Text5)                            
                    nv_dedod      =  brstat.insure.Deci1      
                    nseat         =  brstat.insure.ICNo   .                       
                ELSE ASSIGN aa    =  0
                    nv_dss_per    =  0           
                    nv_dedod      =  0   
                    nseat         =  ""   .  
            END.
        END.
        IF DECI(nseat) <> 0 THEN   
            ASSIGN wdetail.seat = nseat 
            wdetail.seat41 = deci(nseat)
            nv_seat41 =  deci(nseat) 
            nv_seats  = deci(nseat)  .
    END.
    ELSE DO:
        IF  (index(wdetail.model,"VIOS") <> 0 )  OR (index(wdetail.model,"avanza") <> 0 )     THEN RUN proc_dssper.
        ELSE IF (index(wdetail.model,"ALTIS") <> 0 ) OR (INDEX(wdetail.model,"COROLLA") <> 0) THEN RUN proc_dssper1. 
        ELSE IF index(wdetail.model,"CAMRY") <> 0    THEN RUN proc_dssper2.
        ELSE IF index(wdetail.model,"WISH") <> 0     THEN RUN proc_dssper3.
        ELSE IF index(wdetail.model,"FORTUNER") <> 0 THEN RUN proc_dssper4.
        ELSE IF index(wdetail.model,"INNOVA") <> 0   THEN RUN proc_dssper5.
        ELSE IF (index(wdetail.model,"COMMUTER") <> 0 ) OR (index(wdetail.model,"HIACE") <> 0 ) THEN RUN proc_dssper6.
        ELSE IF (index(wdetail.model,"HILUX") <> 0 ) OR (index(wdetail.model,"VIGO") <> 0 )     THEN RUN proc_dssper7.
        IF aa = 0 THEN RUN proc_dssper8.
    END.
    /*ASSIGN aa = 13000
        nv_dss_per = 15
        wdetail.subclass = "320".*/
    IF aa = 0 THEN DO:
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    IF  wdetail.subclass = "520" THEN DO:  
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
        aa = 18000.
    END.
    ASSIGN chk = NO
        NO_basemsg = " "
        nv_baseprm = aa.
    /*-----nv_drivcod---------------------*/
    wdetail.drivnam  = "N".
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
            ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        End.
        RUN proc_usdcod.
        ASSIGN nv_drivvar = ""
            nv_drivvar     = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.
    /*-------nv_baseprm----------*/
    IF NO_basemsg <> " " THEN wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN  nv_basevar = ""
            nv_prem1   = nv_baseprm
            nv_basecod = "BASE"
            nv_basevar1 = "     Base Premium = "
            nv_basevar2 = STRING(nv_baseprm)
            SUBSTRING(nv_basevar,1,30)   = nv_basevar1
            SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    /*IF wdetail.prepol <> "" THEN  ASSIGN  nv_41 = n_41
                                          nv_42  = n_42
                                          nv_43  = n_43
                                          nv_seat41 =  inte(wdetail.seat) .
    ELSE */
       /* ASSIGN
            nv_41     =     deci(wdetail.no_41)
            nv_42     =     deci(wdetail.no_42)
            nv_43     =     deci(wdetail.no_43)
            nv_seat41 = integer(wdetail.seat41) .*/
    /*comment by : A64-0138..
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                    nv_class,
                    nv_key_b,
                    nv_comdat). */
    ASSIGN nv_411var = ""   nv_412var = ""                                                    
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
    ASSIGN  nv_42cod   = "42".
        nv_42var1  = "     Medical Expense = ".
        nv_42var2  = STRING(nv_42).
        SUBSTRING(nv_42var,1,30)   = nv_42var1.
        SUBSTRING(nv_42var,31,30)  = nv_42var2.
    nv_43var    = " ".     /*---------fi_43--------*/
    ASSIGN  nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    /*comment by : A64-0138..
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat). */     /*  RUN US\USOPER(INPUT nv_tariff,*/
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
    Assign  nv_sivar  = ""
         nv_totsi     = 0 
         nv_sicod     = "SI"
         nv_sivar1    = "     Own Damage = "
         nv_sivar2    =  WDETAIL.si
         SUBSTRING(nv_sivar,1,30)  = nv_sivar1
         SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
         nv_totsi     =  deci(wdetail.si) .
     /*----------nv_grpcod--------------------*/
     ASSIGN nv_grpvar   = ""
         nv_grpcod      = "GRP" + wdetail.cargrp
         nv_grpvar1     = "     Vehicle Group = "
         nv_grpvar2     = wdetail.cargrp
         Substr(nv_grpvar,1,30)  = nv_grpvar1
         Substr(nv_grpvar,31,30) = nv_grpvar2.
    /*-------------nv_bipcod--------------------*/
     ASSIGN nv_bipvar   = ""
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(nv_uom1_v)
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign nv_biavar   = ""
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(nv_uom2_v)
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN nv_pdavar   = ""
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         nv_pdavar2     = string(deci(nv_uom5_v))       
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
     ASSIGN dod0 = nv_dedod     dpd0 = nv_ded .  
     IF  dod0 > 3000 THEN  
         ASSIGN dod1 = 3000
                dod2 = dod0 - dod1.
     ELSE dod1 = dod0.
     IF dod1 <> 0 THEN DO:
        ASSIGN nv_odcod    = "DC01"
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
        ASSIGN nv_dedod1var   = ""
            nv_ded1prm        = nv_prem
            nv_dedod1_prm     = nv_prem
            nv_dedod1_cod     = "DOD"
            nv_dedod1var1     = "     Deduct OD = "
            nv_dedod1var2     = STRING(dod1)
            SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
            SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
        /*add od*/
        ASSIGN nv_dedod2var   = " "
            nv_cons  = "AD"
            nv_ded   = dod2   .
        /* comment by :A64-0138..
        Run  Wgs\Wgsmx025(INPUT  nv_ded,  
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).*/      
        ASSIGN nv_dedod2var = ""
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   =  STRING(dod2)
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2.
            /*nv_dedod2_prm   = nv_prem.*/
     END.
     /***** pd *******/
     ASSIGN nv_dedpdvar  = " "
         nv_cons  = "PD"
         nv_ded   = dpd0.
     /* comment by : A64-0138..
     Run  Wgs\Wgsmx025(INPUT  nv_ded, 
                              nv_tariff,
                              nv_class,
                              nv_key_b,
                              nv_comdat,
                              nv_cons,
                       OUTPUT nv_prem).
     nv_ded2prm    = nv_prem.*/
     IF dpd0 <> 0 THEN
     ASSIGN nv_dedpd_cod   = "DPD"
         nv_dedpdvar1   = "     Deduct PD = "
         nv_dedpdvar2   =  STRING(nv_ded)
         SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
         SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
         /*nv_dedpd_prm  = nv_prem.*/
     /*---------- fleet -------------------*/
     nv_flet_per = INTE(wdetail.fleet)   .
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
     /* comment by : A64-0138..
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff,  /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).*/
     ELSE 
     ASSIGN nv_fletvar     = " "
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
         ASSIGN nv_ncbyrs  =   0
             nv_ncbper  =   0
             nv_ncb     =   0.
     End.
     /* comment by : A64-0138..
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).*/
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN  nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     /*------------------ dsspc ---------------*/
     /*A64-0138
     IF nv_dss_per = 0 THEN DO:
         ASSIGN  n_prem = deci(wdetail.premt)
             n_prem = TRUNCATE(((n_prem * 100 ) / 107.43),0).
         IF nv_gapprm > n_prem THEN  
             ASSIGN 
             nv_dss_per = TRUNCATE(((nv_gapprm - n_prem ) * 100 ) / nv_gapprm ,3 ) 
             nv_dss_per = ROUND(nv_dss_per,2).
         /*RUN proc_basesdspc3.*/
         
     END.
     A64-0138*/
     /*ELSE DO:*/
     nv_dsspcvar   = " ".
     IF  nv_dss_per   <> 0  THEN
         ASSIGN nv_dsspcvar1   = "     Discount Special % = "
         nv_dsspcvar2   =  STRING(nv_dss_per)
         SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
         SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
     /*--------------------------*/
         /* comment by : A64-0138..
         RUN WGS\WGSORPRM.P (INPUT nv_tariff,  /*pass*/
                             nv_class,
                             nv_covcod,
                             nv_key_b,
                             nv_comdat,
                             nv_totsi,
                             nv_uom1_v ,       
                             nv_uom2_v ,       
                             nv_uom5_v ). */
     /*END.*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_basesdspc3 c-Win 
PROCEDURE proc_basesdspc3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF nv_gapprm <> n_prem THEN  nv_dss_per = TRUNCATE(((nv_gapprm - n_prem ) * 100 ) / nv_gapprm ,3 ) . 
          
         IF  nv_dss_per   <> 0  THEN
             Assign
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
        

     IF  nv_dss_per   <> 0  THEN
         Assign
         nv_dsspcvar1   = "     Discount Special % = "
         nv_dsspcvar2   =  STRING(nv_dss_per)
         SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
         SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
     /*--------------------------*/
     /*comment by : A64-0138..
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v ,       
                         nv_uom2_v ,       
                         nv_uom5_v ). 
     comment by : A64-0138..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt c-Win 
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
    ASSIGN fi_process = "Create data to base..." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
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
         nv_uom7_c  = "" 
         n_net      = 0 .

    ASSIGN               
         nv_covcod  = wdetail.covcod                                              
         nv_class   = trim(wdetail.prempa) + TRIM(wdetail.subclass)
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
         nv_tpbi1si = nv_uom1_v             
         nv_tpbi2si = nv_uom2_v             
         nv_tppdsi  = nv_uom5_v             
         nv_411si   = nv_41             
         nv_412si   = nv_41             
         nv_413si   = 0                  
         nv_414si   = 0                 
         nv_42si    = nv_42             
         nv_43si    = nv_43             
         nv_seat41  = wdetail.seat41        
         nv_dedod   = DOD1              
         nv_addod   = DOD2              
         nv_dedpd   = nv_ded             
         nv_ncbp    = deci(wdetail.ncb)        
         nv_fletp   = deci(wdetail.fleet)                                  
         nv_dspcp   = nv_dss_per                                      
         nv_dstfp   = nv_stf_per                                            
         nv_clmp    = nv_cl_per 
         nv_netprem  = TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) + 
                        (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )
         n_net      = nv_netprem  /* เบี้ยสุทธิ */                                                
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

     IF wdetail.prepol <> "" THEN nv_netprem  = deci(wdetail.premt).  
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
                               INPUT  wdetail.tariff,  
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
                               INPUT  wdetail.tariff,  
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
            If  avail stat.maktab_fil  Then  
                ASSIGN 
                    sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                    sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                    nv_vehgrp               =  stat.maktab_fil.prmpac                              
                    wdetail.cargrp          =  stat.maktab_fil.prmpac.
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
    "nv_baseprm "    nv_baseprm        skip
    "nv_baseprm3"    nv_baseprm3       skip
    "nv_pdprem  "    nv_pdprem         skip

    " nv_netprem       "  nv_netprem    skip  
    " nv_gapprm        "  nv_gapprem    skip  
    " nv_flagprm       "  nv_flagprm    skip  
    " wdetail.comdat   "  nv_effdat     skip 
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.    */ 

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
                       OUTPUT  nv_status, 
                       OUTPUT  nv_message). 
    /*IF nv_gapprm <> n_net  THEN DO:*/
    IF nv_status = "no" THEN DO:
        /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + string(n_net,">>>,>>>,>>9.99") + 
        nv_message VIEW-AS ALERT-BOX. 
        ASSIGN wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
            wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + string(n_net,">>>,>>>,>>9.99") 
            wdetail.pass     = "Y"   
            wdetail.OK_GEN  = "N".*/    /*comment by Kridtiya i. A65-0035*/ 
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN wdetail.comment = wdetail.comment + "|" + nv_message     /*  by Kridtiya i. A65-0035*/  
               wdetail.WARNING = wdetail.WARNING + "|" + nv_message .   /*  by Kridtiya i. A65-0035*/
    END.
    /*  by Kridtiya i. A65-0035*/
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
    ASSIGN wdetail.chasno = nv_uwm301trareg .
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcode c-Win 
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
 IF wdetail.vatcod <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.vatcod) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Vat " + wdetail.vatcod + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code VAT " + wdetail.vatcod + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
             wdetail.pass    = "N" 
             wdetail.OK_GEN  = "N".
    END.
 END.
 RELEASE sicsyac.xmm600.
  /* end : A64-0138 */ 


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
ASSIGN fi_process = "Check Data For Load to GW...".
DISP fi_process WITH FRAM fr_main.
RUN proc_chassic.
IF wdetail.vehreg = " " AND wdetail.prepol  = " " THEN  
    ASSIGN wdetail.comment =     wdetail.comment + "| Vehicle Register is mandatory field. "
           wdetail.pass    = "N"   
           WDETAIL.OK_GEN  = "N". 
/*comment by Kridtiya i. A54-0062 ...ระบบช้ามาก ไม่สามารถตรวจสอบด้วยเลขตัวถังได้*/
ELSE DO:
    IF wdetail.nSTATUS2 = "n" THEN DO:     /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
        Def  var  nv_vehreg  as char  init  " ".
        Def  var  s_polno       like sicuw.uwm100.policy   init " ".
        /*Find LAST sicuw.uwm301 Use-index uwm30102 Where  */
        /*sicuw.uwm301.vehreg = wdetail.vehreg*/
        Find LAST sicuw.uwm100 USE-INDEX uwm10002 Where
            sicuw.uwm100.cedpol    = wdetail.appenno  No-lock no-error no-wait.
        IF AVAIL sicuw.uwm100 THEN DO:
            /*MESSAGE "พบเลขตัวถังซ้ำ"  wdetail.chasno VIEW-AS ALERT-BOX.*/
            ASSIGN 
                wdetail.comment = wdetail.comment + "| พบเลขที่สัญญา " + wdetail.appenno + "/" + sicuw.uwm100.policy
                wdetail.pass    = "N"   
                WDETAIL.OK_GEN  = "N". 
            /*If  sicuw.uwm301.policy =  wdetail.policy     and          
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
                s_polno     =   sicuw.uwm100.policy.*/
        END.   /*avil 301*/
    END.       /*จบการ Check chassic */
END.           /*note end else*/   
IF INDEX(wdetail.br_sta,"no" ) <> 0 THEN 
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| พบรหัสดีเลอร์ในระบบมี status = No."
    wdetail.OK_GEN  = "N".
/*IF wdetail.deler = "" THEN
    ASSIGN
    wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบรหัสดีเลอร์ในระบบ"
    wdetail.OK_GEN  = "N".*/
IF wdetail.cancel = "ca"  THEN  
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    wdetail.OK_GEN  = "N".
IF wdetail.tiname = "" THEN
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| พบคำนำหน้าชื่อเป็นค่าว่าง"
    wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
/*IF wdetail.drivnam  = "y" AND wdetail.drivername1 =  " "   THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
    wdetail.pass    = "N" 
    wdetail.OK_GEN  = "N".*/
IF wdetail.prempa = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.subclass = " " THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
IF wdetail.brand = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N".
IF wdetail.engcc    = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.seat  = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
/*IF (wdetail.n_branch = "L")  OR (wdetail.n_branch = "14") THEN 
    ASSIGN  
    wdetail.comment =  wdetail.comment + "| พบกรมธรรม์สาขา " + wdetail.n_branch + " ไม่นำเข้ากรมธรรม์" 
    wdetail.pass    = "N" 
    wdetail.OK_GEN  = "N".*/
ASSIGN  nv_modcod = "" 
        nv_maxsi  = 0
        nv_minsi  = 0
        nv_si     = 0
        nv_maxdes = ""
        nv_mindes = ""
        chkred    = NO.
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
        stat.maktab_fil.sclass = wdetail.subclass  AND 
        stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  nv_modcod    =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            chkred           =  YES                     
            wdetail.brand    =  stat.maktab_fil.makdes
            wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
            wdetail.engcc    =  STRING(stat.maktab_fil.engine)
            wdetail.subclass =  stat.maktab_fil.sclass   
            wdetail.redbook  =  stat.maktab_fil.modcod                                    
            wdetail.seat     =  STRING(stat.maktab_fil.seats)
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
        END.  /***--covcod = "1"- End Check Rate SI ---***/
    End.     /*avail maktab_fil */      
    ELSE nv_modcod = " ".
END. /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    IF INDEX(wdetail.model,"vigo") <> 0 THEN wdetail.model = "vigo".
    ELSE IF INDEX(wdetail.model,"altis") <> 0 THEN wdetail.model = "altis".
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN n_ratmin = makdes31.si_theft_p   
        n_ratmax = makdes31.load_p   .    
    ELSE ASSIGN n_ratmin = 0
        n_ratmax = 0.
    IF INDEX(trim(wdetail.model)," ") <> 0 THEN DO:
        ASSIGN wdetail.model = SUBSTR(trim(wdetail.model),1,INDEX(trim(wdetail.model)," ") - 1 ).
    END.
    Find First stat.maktab_fil Use-index maktab04             Where
        stat.maktab_fil.makdes   =  wdetail.brand             And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0      And
        stat.maktab_fil.makyea   =  Integer(wdetail.caryear)  AND
        stat.maktab_fil.engine   =  Integer(wdetail.engcc)    AND
        stat.maktab_fil.sclass   =  wdetail.subclass          AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )   <=  deci(wdetail.si)   OR
         stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )   >=  deci(wdetail.si) ) AND
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN  
        nv_modcod        =  stat.maktab_fil.modcod 
        wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.body     =  stat.maktab_fil.body  
        wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes
        wdetail.weight   =  string(stat.maktab_fil.tons)
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.seat     =  string(stat.maktab_fil.seats).
        chkred           = YES.
    IF nv_modcod = ""  THEN RUN proc_maktab. 
END.
/*nv_modcod = blank*/    
ASSIGN                  
    NO_CLASS  = wdetail.prempa + wdetail.subclass 
    nv_poltyp = wdetail.poltyp.
IF nv_poltyp = "v72" THEN NO_CLASS  =  wdetail.subclass.
If no_class  <>  " " Then do:
    FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
        sicsyac.xmd031.poltyp =   nv_poltyp AND
        sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmd031 THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
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
        ASSIGN  wdetail.tariff =   sicsyac.xmm016.tardef
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
     /*IF (DECI(wdetail.ncb) = 0 )  OR (DECI(wdetail.ncb) = 20 ) OR
        (DECI(wdetail.ncb) = 30 ) OR (DECI(wdetail.ncb) = 40 ) OR
        (DECI(wdetail.ncb) = 50 )    THEN DO:
     END.
     ELSE 
         ASSIGN
             wdetail.comment = wdetail.comment + "| not on NCB Rates file xmm104."
             wdetail.pass    = "N"   
             wdetail.OK_GEN  = "N".*/
NV_NCBPER = INTE(WDETAIL.NCB).
If nv_ncbper  <> 0 Then do:
    Find first sicsyac.xmm104 Use-index xmm10401 Where
        sicsyac.xmm104.tariff = wdetail.tariff                      AND
        sicsyac.xmm104.class  = wdetail.prempa + wdetail.subclass   AND
        sicsyac.xmm104.covcod = wdetail.covcod           AND
        sicsyac.xmm104.ncbper = INTE(wdetail.ncb)
        No-lock no-error no-wait.
    IF not avail  sicsyac.xmm104  Then 
        ASSIGN
        wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
END.  /*ncb <> 0*/
/******* drivernam **********/
nv_sclass = wdetail.subclass. 
If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
    ASSIGN
    wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".

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
    /*FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno :*/
    IF  wdetail.policy = ""  THEN NEXT.
    /*------------------  renew ---------------------*/
    
    /*RUN proc_cr_2.*/
    ASSIGN 
        n_rencnt = 0
        n_endcnt = 0
        nv_netprem  = 0 .
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    /*IF wdetail.deler <> "" THEN DO:
        RUN wgw\wgwmatov (INPUT        wdetail.poltyp                 
                          ,INPUT       inte(wdetail.caryear)
                          ,INPUT        wdetail.subclass        
                          ,INPUT        wdetail.covcod          
                          ,INPUT        wdetail.brand                
                          ,INPUT        wdetail.model                
                          ,INPUT        wdetail.deler        
                          ,INPUT        wdetail.financecd            
                          ,INPUT        deci(wdetail.si)                      
                          ,INPUT        wdetail.agent                                                    
                          ,INPUT-OUTPUT wdetail.campaign_ov) .  
    END.*/
    RUN proc_susspect.
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

    IF wdetail.poltyp = "v72"  THEN DO:
        IF wdetail.nstatus2 = "R"  THEN
            ASSIGN 
            wdetail.agent    = fi_agent       
            wdetail.producer = fi_producer 
            wdetail.nstatus2 = "n"  
            /*---- Piyachat A54-0146 -------*/
            wdetail.deler   = ""
            wdetail.vatcode = "".
            /*------------------------------*/
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
        ASSIGN 
            n_stk70tex = ""
            n_stk70tex = wdetail.stk
            wdetail.stk = "".
        IF (wdetail.nstatus2 = "R") AND (wdetail.prepol <> "" ) THEN DO: 
            /*comment by kridtiya i. A54-0178....*/
            /*---- Piyachat A54-0146 -------*/
            ASSIGN wdetail.deler = ""
                   wdetail.vatcode = "".
            /*------------------------------*/
            /*end...comment by kridtiya i. A54-0178.*/
            IF ra_renewby = 1  THEN  RUN proc_renew2.   /*by policy..renew  kridtiya i. a53-0263*/
            ELSE  RUN proc_renew.                       /*by cha_no.. renew  kridtiya i. a53-0263*/
        END.
        RUN proc_chktest0.
    END.
    RUN proc_policy . 
    RUN proc_chktest2. 
    RUN proc_chktest3. 
    /*RUN proc_chktest4. */ /*kridtiya i. A55-0197 */
    RUN proc_chktest41 .    /*kridtiya i. A55-0197 */
    /*END. WDETAIL2....  */
END.   /*for each        */   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2 c-Win 
PROCEDURE proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       wdetail.redbook
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
    sic_bran.uwm130.bchcnt = nv_batcnt             NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno
        sic_bran.uwm130.bchyr  = nv_batchyr      /* batch Year */
        sic_bran.uwm130.bchno  = nv_batchno      /* bchno      */
        sic_bran.uwm130.bchcnt = nv_batcnt       /* bchcnt     */
        nv_sclass = wdetail.subclass   .
    IF wdetail.access <> "" THEN nv_uom6_u  =  "A".
    ELSE nv_uom6_u  =  "" .
    /*IF nv_uom6_u  =  "A"  THEN DO:
        IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
            nv_sclass  =  "520"  Or  nv_sclass  =  "540"  Then  nv_uom6_u  =  "A".         
        Else  ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
    END.*/
    IF CAPS(nv_uom6_u) = "A"  Then
        Assign  nv_uom6_u          = "A"
        nv_othcod                  = "OTH"
        nv_othvar1                 = "     Accessory  = "
        nv_othvar2                 =  STRING(nv_uom6_u)
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    ELSE  ASSIGN  nv_uom6_u              = ""
            nv_othcod                  = ""
            nv_othvar1                 = ""
            nv_othvar2                 = ""
            SUBSTRING(nv_othvar,1,30)  = nv_othvar1
            SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN 
        ASSIGN sic_bran.uwm130.uom6_v   = inte(wdetail.si)
            sic_bran.uwm130.uom7_v      = inte(wdetail.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN sic_bran.uwm130.uom6_v  = 0
            sic_bran.uwm130.uom7_v   = inte(wdetail.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN sic_bran.uwm130.uom6_v = 0
            sic_bran.uwm130.uom7_v   = 0
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF (wdetail.prepol = "") THEN DO:
        FIND FIRST stat.clastab_fil Use-index clastab01 Where
            stat.clastab_fil.class   = wdetail.prempa + wdetail.subclass And
            stat.clastab_fil.covcod  = wdetail.covcod                    No-lock  No-error No-wait.
        IF avail stat.clastab_fil Then do: 
            Assign 
                sic_bran.uwm130.uom1_v     =  stat.clastab_fil.uom1_si 
                sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si 
                sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si 
                sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
                sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
                sic_bran.uwm130.uom3_v     =  0
                sic_bran.uwm130.uom4_v     =  0
                nv_COMPER                  =  stat.clastab_fil.uom8_si
                nv_comacc                  =  stat.clastab_fil.uom9_si 
                nv_uom1_v                  =  sic_bran.uwm130.uom1_v 
                nv_uom2_v                  =  sic_bran.uwm130.uom2_v
                nv_uom5_v                  =  sic_bran.uwm130.uom5_v      
                sic_bran.uwm130.uom1_c  = "D1"
                sic_bran.uwm130.uom2_c  = "D2"
                sic_bran.uwm130.uom5_c  = "D5"
                sic_bran.uwm130.uom6_c  = "D6"
                sic_bran.uwm130.uom7_c  = "D7".
            If  wdetail.garage  =  ""  Then
                ASSIGN nv_41   =  stat.clastab_fil.si_41pai                    
                nv_42          =  stat.clastab_fil.si_42                       
                nv_43          =  stat.clastab_fil.impsi_43                    
                nv_seat41      =  stat.clastab_fil.dri_41 + clastab_fil.pass_41
                wdetail.seat41 =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
            Else If  wdetail.garage  =  "G"  Then
                Assign 
                nv_41          =   stat.clastab_fil.si_41unp                    
                nv_42          =   stat.clastab_fil.si_42                       
                nv_43          =   stat.clastab_fil.si_43                       
                nv_seat41      =   stat.clastab_fil.dri_41 + clastab_fil.pass_41
                wdetail.seat41 =   stat.clastab_fil.dri_41 + clastab_fil.pass_41.
        END.
    END.
    IF (wdetail.prepol <> "") OR (wdetail.prempa = "Z") THEN RUN proc_chktest2_covver.
    ASSIGN nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                                nv_riskno,
                                nv_itemno).
    END.  /* end Do transaction*/
    ASSIGN s_recid3  = RECID(sic_bran.uwm130)
    nv_covcod =   wdetail.covcod
    nv_makdes  =  wdetail.brand
    nv_moddes  =  wdetail.model
    nv_newsck = " ".
    /*RUN proc_chassic.*/
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
             sic_bran.uwm301.Tons      = INTEGER(wdetail.weight)
             sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
             sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
             sic_bran.uwm301.garage    = wdetail.garage
             sic_bran.uwm301.body      = wdetail.body
             sic_bran.uwm301.vehgrp    = wdetail.cargrp
             sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
             sic_bran.uwm301.mv_ben83  = wdetail.benname
             sic_bran.uwm301.vehreg    = wdetail.vehreg 
             sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
             sic_bran.uwm301.vehuse    = wdetail.vehuse
             sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
             sic_bran.uwm301.modcod    = wdetail.redbook
             sic_bran.uwm301.sckno     = 0
             sic_bran.uwm301.itmdel    = NO
             sic_bran.uwm301.prmtxt    = IF (wdetail.poltyp = "v70") AND (wdetail.access = "") THEN "" ELSE wdetail.access  .   /*kridtiya i. A53-0351 */
         wdetail.tariff            = sic_bran.uwm301.tariff.
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
         ASSIGN  sic_bran.uwm301.bchyr = nv_batchyr   /* batch Year */
             sic_bran.uwm301.bchno     = nv_batchno   /* bchno      */
             sic_bran.uwm301.bchcnt    = nv_batcnt .   /* bchcnt     */
             /*wdetail.drivername1 = wdetail.ntitle1 + " " + wdetail.drivername1 + " " + wdetail.dname1 + " " + wdetail.dname2 
             wdetail.drivername2 = wdetail.ntitle2 + " " + wdetail.drivername2 + " " + wdetail.ddname1 + " " + wdetail.ddname2 . */
         /*IF wdetail.drivername1 <> "" THEN wdetail.drivnam = "Y".*/
         RUN proc_mailtxt.
         s_recid4         = RECID(sic_bran.uwm301).

         /*IF wdetail.redbook <> "" AND chkred = YES THEN DO:
             FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass  AND
                 stat.maktab_fil.modcod       = wdetail.redbook   No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN 
                 sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                 sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                 wdetail.cargrp          =  maktab_fil.prmpac
                 sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.body    =  stat.maktab_fil.body.
         END.
         ELSE DO:*/
         IF wdetail.redbook = ""  THEN DO:
             Find First stat.maktab_fil Use-index maktab04             Where
                 stat.maktab_fil.makdes   =  wdetail.brand             And                  
                 index(stat.maktab_fil.moddes,wdetail.model) <> 0      And
                 stat.maktab_fil.makyea   =  Integer(wdetail.caryear)  AND
                 stat.maktab_fil.engine   =  Integer(wdetail.engcc)    AND
                 stat.maktab_fil.sclass   =  wdetail.subclass          AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )   <=  deci(wdetail.si)   OR
                 stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )   >=  deci(wdetail.si) ) AND
                 stat.maktab_fil.seats    =  INTEGER(wdetail.seat)  No-lock no-error no-wait.
             If  avail stat.maktab_fil  Then 
                 ASSIGN  wdetail.redbook =  stat.maktab_fil.modcod
                 nv_modcod       =  stat.maktab_fil.modcod                                    
                 nv_moddes       =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                 wdetail.cargrp          =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                 sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                 sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.body    =  stat.maktab_fil.body.
         END.
         IF wdetail.redbook  = ""  THEN RUN proc_maktab2.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2_covver c-Win 
PROCEDURE proc_chktest2_covver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST brstat.insure WHERE
    brstat.insure.InsNo    = fi_campaign                        AND 
    brstat.insure.Text3    = wdetail.prempa + wdetail.subclass  AND
    brstat.insure.Deci2    = deci(wdetail.si)  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL brstat.insure THEN
    Assign 
    sic_bran.uwm130.uom1_v  = deci(insure.LNAME)  
    sic_bran.uwm130.uom2_v  = deci(insure.Addr1)   
    sic_bran.uwm130.uom5_v  = deci(insure.Addr2)
    nv_uom1_v               = deci(insure.LNAME) 
    nv_uom2_v               = deci(insure.Addr1) 
    nv_uom5_v               = deci(insure.Addr2)    
    nv_41 = deci(insure.Addr3) 
    nv_42 = deci(insure.Addr4)   
    nv_43 = deci(insure.Telno)
    sic_bran.uwm130.uom6_v  =  deci(WDETAIL.si)
    sic_bran.uwm130.uom7_v  =  deci(WDETAIL.si)     
    sic_bran.uwm130.uom3_v  =  0
    sic_bran.uwm130.uom4_v  =  0
    sic_bran.uwm130.uom1_c  = "D1"
    sic_bran.uwm130.uom2_c  = "D2"
    sic_bran.uwm130.uom5_c  = "D5"
    sic_bran.uwm130.uom6_c  = "D6"
    sic_bran.uwm130.uom7_c  = "D7" .
ELSE  Assign 
    nv_uom1_v        = 1000000
    nv_uom2_v        = 10000000
    nv_uom5_v        = 2500000
    sic_bran.uwm130.uom1_v  = 1000000    
    sic_bran.uwm130.uom2_v  = 10000000   
    sic_bran.uwm130.uom5_v  = 2500000    
    sic_bran.uwm130.uom6_v  =  deci(WDETAIL.si)
    sic_bran.uwm130.uom7_v  =  deci(WDETAIL.si)     
    sic_bran.uwm130.uom3_v  =  0
    sic_bran.uwm130.uom4_v  =  0
    sic_bran.uwm130.uom1_c  = "D1"
    sic_bran.uwm130.uom2_c  = "D2"
    sic_bran.uwm130.uom5_c  = "D5"
    sic_bran.uwm130.uom6_c  = "D6"
    sic_bran.uwm130.uom7_c  = "D7"
    nv_41             =  50000             
    nv_42             =  50000          
    nv_43             =  200000 .   
   
Assign 
        /*sic_bran.uwm130.uom6_v  =  deci(WDETAIL.deductpd)
        sic_bran.uwm130.uom7_v  =  deci(WDETAIL.deductpd2) */   
        sic_bran.uwm130.uom3_v  =  0
        sic_bran.uwm130.uom4_v  =  0
        sic_bran.uwm130.uom1_c  = "D1"
        sic_bran.uwm130.uom2_c  = "D2"
        sic_bran.uwm130.uom5_c  = "D5"
        sic_bran.uwm130.uom6_c  = "D6"
        sic_bran.uwm130.uom7_c  = "D7"
        /*wdetail.si              =  string(WDETAIL.deductpd)*/
        wdetail.seat41    =  deci(wdetail.seat)
        nv_seat41         =  wdetail.seat41  .     
   
IF wdetail.covcod = "2" THEN  
    ASSIGN WDETAIL.si = "0"
    sic_bran.uwm130.uom6_v  =  0.
ELSE IF  wdetail.covcod = "3" THEN  
    ASSIGN WDETAIL.si = "0"
    sic_bran.uwm130.uom6_v  =  0
    sic_bran.uwm130.uom7_v  =  0.
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
ASSIGN  dod1 = 0   dod2 = 0     dpd0 = 0    /*add A64-0138*/
    nv_tariff = sic_bran.uwm301.tariff
    /*nv_class  = wdetail.prempa +  wdetail.subclass*//*Comment by Kridtiya i. A63-0143*/
    nv_class  = "T" +  wdetail.subclass               /*Add        Kridtiya i. A63-0143*/
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = DECI(wdetail.engcc)
    nv_tons   = deci(wdetail.weight)
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse
    /*nv_COMPER = deci(wdetail.comper) 
    nv_comacc = deci(wdetail.comacc) */
    nv_seats  = INTE(wdetail.seat)
    /*nv_dss_per = 0  */   
    nv_dsspcvar1 = ""
    nv_dsspcvar2 =  ""
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
    /*nv_ncb     = 0*/
    nv_totsi     = 0 . 
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
ELSE             /*compul = n  v70 */
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
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff,   /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    nv_totsi,
                    nv_uom1_v ,       
                    nv_uom2_v ,       
                    nv_uom5_v ).
END.
RUN proc_calpremt.      /*A64-0138*/
RUN proc_adduwd132prem. /*A64-0138*/

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
     /*   sic_bran.uwm301.ncbper   = nv_ncbper   /* A64-0138*/
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs*/   /* A64-0138*/
        sic_bran.uwm301.seats    = wdetail.seat41
        sic_bran.uwm301.mv41seat = wdetail.seat41.
/* a64-0138..  
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).*/
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
DEF VAR n_sigr_r     like sic_bran.uwm130.uom6_v.
DEF VAR n_gap_r      Like sic_bran.uwd132.gap_c . 
DEF VAR n_prem_r     Like sic_bran.uwd132.prem_c.
DEF VAR nt_compprm   like sic_bran.uwd132.prem_c.  
DEF VAR n_gap_t      Like sic_bran.uwm100.gap_p.
DEF VAR n_prem_t     Like sic_bran.uwm100.prem_t.
DEF VAR n_sigr_t     Like sic_bran.uwm100.sigr_p.
DEF VAR nv_policy    like sic_bran.uwm100.policy.
DEF VAR nv_rencnt    like sic_bran.uwm100.rencnt.
DEF VAR nv_endcnt    like sic_bran.uwm100.endcnt.
DEF VAR nv_com1_per  like sicsyac.xmm031.comm1.
DEF VAR nv_stamp_per like sicsyac.xmm020.rvstam.
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
  IF wdetail.agent = "A0M9999" THEN nv_com1p = 0 .  /*งานตรงไม่มีค่าคอม */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest41 c-Win 
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
      ASSIGN nv_com2p = 0.
      /*FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
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
      END.*/
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
       sic_bran.uwm100.policy = wdetail.policy                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
       sic_bran.uwm100.rencnt = n_rencnt             
       sic_bran.uwm100.renno  = "" 
       sic_bran.uwm100.endcnt = n_endcnt
       sic_bran.uwm100.bchyr  = nv_batchyr 
       sic_bran.uwm100.bchno  = nv_batchno 
       sic_bran.uwm100.bchcnt = nv_batcnt     .


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
/*
DEF VAR len AS INTE.
DEF BUFFER buwm100 FOR wdetail.
    ASSIGN wdetail.cr_2 = ""
        len = LENGTH(wdetail.policy).
    FOR EACH buwm100 WHERE 
        buwm100.appenno = wdetail.appenno AND
        buwm100.policy <> wdetail.policy   NO-LOCK.
        ASSIGN 
            wdetail.cr_2 = buwm100.policy.
    END.*/
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchar c-Win 
PROCEDURE proc_cutchar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
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
    wdetail.prepol = nv_c .*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_definition c-Win 
PROCEDURE proc_definition :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
--------------------------------------------------------------------------------------*/
/*modify by   : Kridtiya i. A52-0263   date . 23/08/2010                */
/* ปรับชื่อผู้รับผลประโยชน์จาก "บริษัทโตโยต้าลีสซิ่ง"เป็น "บจก.โตโยต้าลีสซิ่ง (ปทท.)" */ 
/*A53-0310 run proc_modify */
/*modify by   : Kridtiya i. A54-0062 ปรับ producer code 70/72ให้ตางกัน                */
/*modify by   : Piyachat A54-0146 ปรับงานต่ออายุให้ช่องVatcodeและfinintเป็นค่าว่าง    */
/*modify by   : Kridtiya i. A54-0178 เพิ่ม Garage ให้งานป้ายแดง                       */
/*modify by   : Kridtiya i. A55-0197 ปรับเบี้ยตามใบเสนอราคาสำหรับงานสาขาภูเก็ต D8     */
/*modify by   : Kridtiya i. A63-0143 Date .22/04/2020 Load Text file TIB(Pack T)      */
/*modify by   : Kridtiya i. A63-0259 Date .04/08/2020 Add file hino 320               */
/*Modify by   : Kridtiya i. A65-0035 comment message error premium not on file        */
/*Modify by   : Kridtiyai . A67-0184 Date.24/10/2024 เพิ่ม ฟิล์ด */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dssper c-Win 
PROCEDURE proc_dssper :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* vios and avanza ....*/
IF wdetail.subclass  = "" THEN wdetail.subclass  = "110".
ASSIGN aa = 8500.
IF      DECI(wdetail.si) = 350000  THEN nv_dss_per = 2.60  . 
ELSE IF DECI(wdetail.si) = 360000  THEN nv_dss_per = 4.30  . 
ELSE IF DECI(wdetail.si) = 370000  THEN nv_dss_per = 5.94  . 
ELSE IF DECI(wdetail.si) = 380000  THEN nv_dss_per = 7.53  . 
ELSE IF DECI(wdetail.si) = 390000  THEN nv_dss_per = 9.07  . 
ELSE IF DECI(wdetail.si) = 400000  THEN nv_dss_per = 10.55 . 
ELSE IF DECI(wdetail.si) = 410000  THEN nv_dss_per = 11.99 . 
ELSE IF DECI(wdetail.si) = 420000  THEN nv_dss_per = 13.38 . 
ELSE IF DECI(wdetail.si) = 430000  THEN nv_dss_per = 14.73 . 
ELSE IF DECI(wdetail.si) = 440000  THEN nv_dss_per = 16.03 . 
ELSE IF DECI(wdetail.si) = 450000  THEN nv_dss_per = 17.30 . 
ELSE IF DECI(wdetail.si) = 460000  THEN nv_dss_per = 15.98 . 
ELSE IF DECI(wdetail.si) = 470000  THEN nv_dss_per = 17.21 . 
ELSE IF DECI(wdetail.si) = 480000  THEN nv_dss_per = 18.41 . 
ELSE IF DECI(wdetail.si) = 490000  THEN nv_dss_per = 19.57 . 
ELSE IF DECI(wdetail.si) = 500000  THEN nv_dss_per = 20.70 . 
ELSE IF DECI(wdetail.si) = 510000  THEN nv_dss_per = 19.53 . 
ELSE IF DECI(wdetail.si) = 520000  THEN nv_dss_per = 20.26 . 
ELSE IF DECI(wdetail.si) = 530000  THEN nv_dss_per = 20.99 . 
ELSE IF DECI(wdetail.si) = 540000  THEN nv_dss_per = 21.70 . 
ELSE IF DECI(wdetail.si) = 550000  THEN nv_dss_per = 22.40 . 
ELSE IF DECI(wdetail.si) = 560000  THEN nv_dss_per = 22.18 . 
ELSE IF DECI(wdetail.si) = 570000  THEN nv_dss_per = 22.87 . 
ELSE IF DECI(wdetail.si) = 580000  THEN nv_dss_per = 23.53 . 
ELSE IF DECI(wdetail.si) = 590000  THEN nv_dss_per = 24.20 . 
ELSE IF DECI(wdetail.si) = 600000  THEN nv_dss_per = 24.84 . 
ELSE IF DECI(wdetail.si) = 610000  THEN nv_dss_per = 22.87 . 
ELSE IF DECI(wdetail.si) = 620000  THEN nv_dss_per = 23.52 . 
ELSE IF DECI(wdetail.si) = 630000  THEN nv_dss_per = 24.15 . 
ELSE IF DECI(wdetail.si) = 640000  THEN nv_dss_per = 24.78 . 
ELSE IF DECI(wdetail.si) = 650000  THEN nv_dss_per = 25.40 . 
ELSE IF DECI(wdetail.si) = 660000  THEN nv_dss_per = 24.75 . 
ELSE IF DECI(wdetail.si) = 670000  THEN nv_dss_per = 25.36 . 
ELSE IF DECI(wdetail.si) = 680000  THEN nv_dss_per = 25.95 . 
ELSE IF DECI(wdetail.si) = 690000  THEN nv_dss_per = 26.54 . 
ELSE IF DECI(wdetail.si) = 700000  THEN nv_dss_per = 27.12 . 
                                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dssper1 c-Win 
PROCEDURE proc_dssper1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* TOYOTA ALTIS .. ....*/
IF wdetail.subclass  = "" THEN wdetail.subclass  = "110".
ASSIGN aa         = 7600
    wdetail.model = "COROLLA Altis"
    nv_dss_per    = 0.
IF      DECI(wdetail.si) = 570000  THEN nv_dss_per = 20.81  .
ELSE IF DECI(wdetail.si) = 580000  THEN nv_dss_per = 21.50  .
ELSE IF DECI(wdetail.si) = 590000  THEN nv_dss_per = 22.17  .
ELSE IF DECI(wdetail.si) = 600000  THEN nv_dss_per = 22.84  .
ELSE IF DECI(wdetail.si) = 610000  THEN nv_dss_per = 23.49  .
ELSE IF DECI(wdetail.si) = 620000  THEN nv_dss_per = 24.13  .
ELSE IF DECI(wdetail.si) = 630000  THEN nv_dss_per = 24.76  .
ELSE IF DECI(wdetail.si) = 640000  THEN nv_dss_per = 25.39  .
ELSE IF DECI(wdetail.si) = 650000  THEN nv_dss_per = 26.00  .
ELSE IF DECI(wdetail.si) = 660000  THEN nv_dss_per = 20.37  .
ELSE IF DECI(wdetail.si) = 670000  THEN nv_dss_per = 21.01  .
ELSE IF DECI(wdetail.si) = 680000  THEN nv_dss_per = 21.65  .
ELSE IF DECI(wdetail.si) = 690000  THEN nv_dss_per = 22.27  .
ELSE IF DECI(wdetail.si) = 700000  THEN nv_dss_per = 22.88  .
ELSE IF DECI(wdetail.si) = 710000  THEN nv_dss_per = 23.48  .
ELSE IF DECI(wdetail.si) = 720000  THEN nv_dss_per = 24.08  .
ELSE IF DECI(wdetail.si) = 730000  THEN nv_dss_per = 24.66  .
ELSE IF DECI(wdetail.si) = 740000  THEN nv_dss_per = 25.23  .
ELSE IF DECI(wdetail.si) = 750000  THEN nv_dss_per = 25.80  .
ELSE IF DECI(wdetail.si) = 760000  THEN nv_dss_per = 20.60  .
ELSE IF DECI(wdetail.si) = 770000  THEN nv_dss_per = 21.19  .
ELSE IF DECI(wdetail.si) = 780000  THEN nv_dss_per = 21.77  .
ELSE IF DECI(wdetail.si) = 790000  THEN nv_dss_per = 22.35  .
ELSE IF DECI(wdetail.si) = 800000  THEN nv_dss_per = 22.91  .
ELSE IF DECI(wdetail.si) = 810000  THEN nv_dss_per = 23.47  .
ELSE IF DECI(wdetail.si) = 820000  THEN nv_dss_per = 24.02  .
ELSE IF DECI(wdetail.si) = 830000  THEN nv_dss_per = 24.57  .
ELSE IF DECI(wdetail.si) = 840000  THEN nv_dss_per = 25.10  .
ELSE IF DECI(wdetail.si) = 850000  THEN nv_dss_per = 25.63  .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dssper2 c-Win 
PROCEDURE proc_dssper2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* camry.... ....*/
IF wdetail.subclass  = "" THEN wdetail.subclass  = "110".
IF deci(wdetail.engcc) <= 2000  THEN DO:
    ASSIGN nv_dss_per = 22.
    IF (DECI(wdetail.si) >= 940000) AND (DECI(wdetail.si) <= 1000000) THEN aa = 8117.
    ELSE IF (DECI(wdetail.si)  > 1000000)  AND (DECI(wdetail.si)  <= 1050000)  THEN aa = 8095.
    ELSE IF (DECI(wdetail.si) >= 1100000) AND (DECI(wdetail.si) <= 1400000) THEN aa = 8076.
END.
ELSE DO:
    ASSIGN nv_dss_per = 19.
    IF (DECI(wdetail.si) >= 1100000) AND (DECI(wdetail.si) <= 1200000) THEN aa = 8238.
    ELSE IF (DECI(wdetail.si)  = 1250000)  THEN aa = 8203.
    ELSE IF (DECI(wdetail.si)  = 1300000)  THEN aa = 8171.
    ELSE IF (DECI(wdetail.si)  = 1350000)  THEN aa = 8141.
    ELSE IF (DECI(wdetail.si)  = 1400000)  THEN aa = 8094.
    ELSE IF (DECI(wdetail.si)  = 1450000)  THEN aa = 8050.
    ELSE IF (DECI(wdetail.si) >= 1500000) OR (DECI(wdetail.si) >= 2900000) THEN aa = 8008.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dssper3 c-Win 
PROCEDURE proc_dssper3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*  wish.........*/
IF wdetail.subclass  = "" THEN wdetail.subclass  = "110".
ASSIGN nv_dss_per = 27 .
IF      DECI(wdetail.si) >= 890000    THEN aa = 8130    .
ELSE IF DECI(wdetail.si)  = 900000    THEN aa = 8121    .
ELSE IF DECI(wdetail.si)  = 910000    THEN aa = 8112    .
ELSE IF DECI(wdetail.si)  = 920000    THEN aa = 8127    .
ELSE IF DECI(wdetail.si)  = 930000    THEN aa = 8120    .
ELSE IF DECI(wdetail.si)  = 940000    THEN aa = 8134    .
ELSE IF DECI(wdetail.si)  = 950000    THEN aa = 8125    .
ELSE IF DECI(wdetail.si)  = 960000    THEN aa = 8141    .
ELSE IF DECI(wdetail.si)  = 970000    THEN aa = 8132    .
ELSE IF DECI(wdetail.si)  = 980000    THEN aa = 8147    .
ELSE IF DECI(wdetail.si)  = 990000    THEN aa = 8139    .
ELSE IF DECI(wdetail.si)  = 1000000   THEN aa = 8152    .
ELSE IF DECI(wdetail.si)  = 1050000   THEN aa = 8131    .
ELSE IF DECI(wdetail.si)  = 1100000   THEN aa = 8111    .
ELSE IF DECI(wdetail.si)  = 1150000   THEN aa = 8071    .
ELSE IF DECI(wdetail.si)  = 1200000   THEN aa = 8034    .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dssper4 c-Win 
PROCEDURE proc_dssper4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*  fortuner.........*/
IF wdetail.subclass  = "" THEN wdetail.subclass  = "110".
ASSIGN nv_dss_per = 22.
IF      DECI(wdetail.si)  = 830000   THEN aa = 8068 .
ELSE IF DECI(wdetail.si)  = 840000   THEN aa = 8060 .
ELSE IF DECI(wdetail.si)  = 850000   THEN aa = 8076 .
ELSE IF DECI(wdetail.si)  = 860000   THEN aa = 8067 .
ELSE IF DECI(wdetail.si)  = 870000   THEN aa = 8082 .
ELSE IF DECI(wdetail.si)  = 880000   THEN aa = 8075 .
ELSE IF DECI(wdetail.si)  = 890000   THEN aa = 8090 .
ELSE IF DECI(wdetail.si)  = 900000   THEN aa = 8081 .
ELSE IF DECI(wdetail.si)  = 910000   THEN aa = 8072 .
ELSE IF DECI(wdetail.si)  = 920000   THEN aa = 8088 .
ELSE IF DECI(wdetail.si)  = 930000   THEN aa = 8081 .
ELSE IF DECI(wdetail.si)  = 940000   THEN aa = 8096 .
ELSE IF DECI(wdetail.si)  = 950000   THEN aa = 8087 .
ELSE IF DECI(wdetail.si)  = 960000   THEN aa = 8103 .
ELSE IF DECI(wdetail.si)  = 970000   THEN aa = 8095 .
ELSE IF DECI(wdetail.si)  = 980000   THEN aa = 8109 .
ELSE IF DECI(wdetail.si)  = 990000   THEN aa = 8101 .
ELSE IF DECI(wdetail.si)  = 1000000  THEN aa = 8116 .
ELSE IF DECI(wdetail.si)  = 1050000  THEN aa = 8095 .
ELSE IF DECI(wdetail.si)  = 1100000  THEN aa = 8075 .
ELSE IF DECI(wdetail.si)  = 1150000  THEN aa = 8035 .
ELSE IF DECI(wdetail.si)  = 1200000  THEN aa = 8000 .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dssper5 c-Win 
PROCEDURE proc_dssper5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* innova.... ....*/
IF wdetail.subclass  = "" THEN wdetail.subclass  = "110".
IF deci(wdetail.engcc) <= 2000  THEN DO:
    ASSIGN aa = 8500.
    IF (DECI(wdetail.si) >= 660000) AND (DECI(wdetail.si) <= 840000) THEN ASSIGN nv_dss_per = 30.39.
    ELSE IF DECI(wdetail.si)  = 850000  THEN nv_dss_per = 30.26.
    ELSE IF DECI(wdetail.si)  = 860000  THEN nv_dss_per = 30.34.
    ELSE IF DECI(wdetail.si)  = 870000  THEN nv_dss_per = 30.20.
    ELSE IF DECI(wdetail.si)  = 880000  THEN nv_dss_per = 30.27.
    ELSE IF DECI(wdetail.si)  = 890000  THEN nv_dss_per = 30.14.
    ELSE IF DECI(wdetail.si)  = 900000  THEN nv_dss_per = 30.22.
    ELSE IF DECI(wdetail.si)  = 910000  THEN nv_dss_per = 30.29.
    ELSE IF DECI(wdetail.si)  = 920000  THEN nv_dss_per = 30.16.
    ELSE IF DECI(wdetail.si)  = 930000  THEN nv_dss_per = 30.23.
    ELSE IF DECI(wdetail.si)  = 940000  THEN nv_dss_per = 30.11.
    ELSE IF DECI(wdetail.si)  = 950000  THEN nv_dss_per = 30.18.
    ELSE IF DECI(wdetail.si)  = 960000  THEN nv_dss_per = 30.04.
    ELSE IF DECI(wdetail.si)  = 970000  THEN nv_dss_per = 30.13.
    ELSE IF DECI(wdetail.si)  = 980000  THEN nv_dss_per = 30.01.
    ELSE IF DECI(wdetail.si)  = 990000  THEN nv_dss_per = 30.07.
    ELSE IF DECI(wdetail.si) = 1000000  THEN nv_dss_per = 29.95.
END.
ELSE DO:
    ASSIGN aa = 8500.
    IF (DECI(wdetail.si)  >= 890000) OR 
        (DECI(wdetail.si)  <= 920000) THEN 
        nv_dss_per = 20.42.
    ELSE IF DECI(wdetail.si)  = 930000    THEN nv_dss_per = 20.50.
    ELSE IF DECI(wdetail.si)  = 940000    THEN nv_dss_per = 20.35.
    ELSE IF DECI(wdetail.si)  = 950000    THEN nv_dss_per = 20.43.
    ELSE IF DECI(wdetail.si)  = 960000    THEN nv_dss_per = 20.28.
    ELSE IF DECI(wdetail.si)  = 970000    THEN nv_dss_per = 20.36.
    ELSE IF DECI(wdetail.si)  = 980000    THEN nv_dss_per = 20.23.
    ELSE IF DECI(wdetail.si)  = 990000    THEN nv_dss_per = 20.30.
    ELSE IF DECI(wdetail.si)  = 1000000   THEN nv_dss_per = 20.16.
    ELSE IF DECI(wdetail.si)  = 1050000   THEN nv_dss_per = 20.37.
    ELSE IF DECI(wdetail.si)  = 1100000   THEN nv_dss_per = 20.56.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dssper6 c-Win 
PROCEDURE proc_dssper6 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* commuter /hiace .. ....*/
    ASSIGN aa = 13000
    wdetail.subclass = "210".
    IF (DECI(wdetail.si) >= 640000) AND (DECI(wdetail.si) <= 890000) THEN ASSIGN nv_dss_per = 19.32.
    ELSE IF DECI(wdetail.si)  = 900000  THEN nv_dss_per = 19.48.
    ELSE IF DECI(wdetail.si)  = 910000  THEN nv_dss_per = 19.40.
    ELSE IF DECI(wdetail.si)  = 920000  THEN nv_dss_per = 19.55.
    ELSE IF DECI(wdetail.si)  = 930000  THEN nv_dss_per = 19.47.
    ELSE IF DECI(wdetail.si)  = 940000  THEN nv_dss_per = 19.63.
    ELSE IF (DECI(wdetail.si)  >= 950000) AND (DECI(wdetail.si)  <= 1200000)  THEN nv_dss_per = 19.56.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dssper7 c-Win 
PROCEDURE proc_dssper7 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*....กระบะจดเก๋ง.......*/
IF wdetail.subclass  = "" THEN wdetail.subclass  = "110".
ASSIGN nv_dss_per = 19.
IF      DECI(wdetail.si)  = 480000 THEN aa = 8119.
ELSE IF DECI(wdetail.si)  = 490000 THEN aa = 8070.
ELSE IF DECI(wdetail.si)  = 500000 THEN aa = 8054.
ELSE IF DECI(wdetail.si)  = 510000 THEN aa = 8079.
ELSE IF DECI(wdetail.si)  = 520000 THEN aa = 8069.
ELSE IF DECI(wdetail.si)  = 530000 THEN aa = 8091.
ELSE IF DECI(wdetail.si)  = 540000 THEN aa = 8082.
ELSE IF DECI(wdetail.si)  = 550000 THEN aa = 8105.
ELSE IF DECI(wdetail.si)  = 560000 THEN aa = 8094.
ELSE IF DECI(wdetail.si)  = 570000 THEN aa = 8117.
ELSE IF DECI(wdetail.si)  = 580000 THEN aa = 8140.
ELSE IF DECI(wdetail.si)  = 590000 THEN aa = 8130.
ELSE IF DECI(wdetail.si)  = 600000 THEN aa = 8152.
ELSE IF DECI(wdetail.si)  = 610000 THEN aa = 8142.
ELSE IF DECI(wdetail.si)  = 620000 THEN aa = 8162.
ELSE IF DECI(wdetail.si)  = 630000 THEN aa = 8152.
ELSE IF DECI(wdetail.si)  = 640000 THEN aa = 8173.
ELSE IF DECI(wdetail.si)  = 650000 THEN aa = 8192.
ELSE IF DECI(wdetail.si)  = 660000 THEN aa = 8184.
ELSE IF DECI(wdetail.si)  = 670000 THEN aa = 8202.
ELSE IF DECI(wdetail.si)  = 680000 THEN aa = 8194.
ELSE IF DECI(wdetail.si)  = 690000 THEN aa = 8213.
ELSE IF DECI(wdetail.si)  = 700000 THEN aa = 8203.
ELSE IF DECI(wdetail.si)  = 710000 THEN aa = 8222.
ELSE IF DECI(wdetail.si)  = 720000 THEN aa = 8213.
ELSE IF DECI(wdetail.si)  = 730000 THEN aa = 8231.
ELSE IF DECI(wdetail.si)  = 740000 THEN aa = 8222.
ELSE IF DECI(wdetail.si)  = 750000  THEN aa = 8241.
ELSE IF DECI(wdetail.si)  = 760000  THEN aa = 8231.
ELSE IF DECI(wdetail.si)  = 770000  THEN aa = 8249.
ELSE IF DECI(wdetail.si)  = 780000  THEN aa = 8240.
ELSE IF DECI(wdetail.si)  = 790000  THEN aa = 8256.
ELSE IF DECI(wdetail.si)  = 800000  THEN aa = 8249.
ELSE IF DECI(wdetail.si)  = 810000  THEN aa = 8265.
ELSE IF DECI(wdetail.si)  = 820000  THEN aa = 8257.
ELSE IF DECI(wdetail.si)  = 830000  THEN aa = 8272.
ELSE IF DECI(wdetail.si)  = 840000  THEN aa = 8265.
ELSE IF DECI(wdetail.si)  = 850000  THEN aa = 8280.
ELSE IF DECI(wdetail.si)  = 860000  THEN aa = 8270.
ELSE IF DECI(wdetail.si)  = 870000  THEN aa = 8286.
ELSE IF DECI(wdetail.si)  = 880000  THEN aa = 8278.
ELSE IF DECI(wdetail.si)  = 890000  THEN aa = 8295.
ELSE IF DECI(wdetail.si)  = 900000  THEN aa = 8286.
ELSE IF DECI(wdetail.si)  = 910000  THEN aa = 8278.
ELSE IF DECI(wdetail.si)  = 920000  THEN aa = 8293.
ELSE IF DECI(wdetail.si)  = 930000  THEN aa = 8286.
ELSE IF DECI(wdetail.si)  = 940000  THEN aa = 8300.
ELSE IF DECI(wdetail.si)  = 950000  THEN aa = 8291.
ELSE IF DECI(wdetail.si)  = 960000  THEN aa = 8309.
ELSE IF DECI(wdetail.si)  = 970000  THEN aa = 8298.
ELSE IF DECI(wdetail.si)  = 980000  THEN aa = 8313.
ELSE IF DECI(wdetail.si)  = 990000  THEN aa = 8306.
ELSE IF DECI(wdetail.si)  = 1000000 THEN aa = 8319.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dssper8 c-Win 
PROCEDURE proc_dssper8 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* one price */
ASSIGN aa               = 7600
       wdetail.fleet    = "10" .
       /*nv_dss_per = 19.*/
/*MAKE  ทุนประกันภัย    Fleet   DS      Base*/
IF index(wdetail.model,"camry") <> 0    THEN DO:
    IF deci(wdetail.cc) = 2000 THEN DO:
        IF      DECI(wdetail.si)  = 950000  THEN nv_dss_per = 20.38.
        ELSE IF DECI(wdetail.si)  = 960000  THEN nv_dss_per = 20.91.
        ELSE IF DECI(wdetail.si)  = 970000  THEN nv_dss_per = 21.42.
        ELSE IF DECI(wdetail.si)  = 980000  THEN nv_dss_per = 21.93.
        ELSE IF DECI(wdetail.si)  = 990000  THEN nv_dss_per = 22.44.
        ELSE IF DECI(wdetail.si)  = 1000000 THEN nv_dss_per = 22.93.
        ELSE IF DECI(wdetail.si)  = 1050000 THEN nv_dss_per = 25.56.
        ELSE IF DECI(wdetail.si)  = 1100000 THEN nv_dss_per = 28.01.
        ELSE IF DECI(wdetail.si)  = 1150000 THEN nv_dss_per = 30.30.
        ELSE IF DECI(wdetail.si)  = 1200000 THEN nv_dss_per = 32.46.
    END.
    ELSE IF deci(wdetail.cc) > 2000   THEN DO:
        IF      DECI(wdetail.si)  =  1150000 THEN nv_dss_per = 21.29.
        ELSE IF DECI(wdetail.si)  =  1200000 THEN nv_dss_per = 23.72. 
        ELSE IF DECI(wdetail.si)  =  1250000 THEN nv_dss_per = 26.01. 
        ELSE IF DECI(wdetail.si)  =  1300000 THEN nv_dss_per = 28.16. 
        ELSE IF DECI(wdetail.si)  =  1350000 THEN nv_dss_per = 30.19. 
        ELSE IF DECI(wdetail.si)  =  1400000 THEN nv_dss_per = 32.11. 
        ELSE IF DECI(wdetail.si)  =  1450000 THEN nv_dss_per = 27.92. 
        ELSE IF DECI(wdetail.si)  =  1500000 THEN nv_dss_per = 29.80. 
        ELSE IF DECI(wdetail.si)  =  1550000 THEN nv_dss_per = 31.26.
        ELSE IF DECI(wdetail.si)  =  1600000 THEN nv_dss_per = 32.67.
        ELSE IF DECI(wdetail.si)  =  2300000 THEN nv_dss_per = 24.65.
        ELSE IF DECI(wdetail.si)  =  2400000 THEN nv_dss_per = 26.50.
        ELSE IF DECI(wdetail.si)  =  2500000 THEN nv_dss_per = 28.27.
        ELSE IF DECI(wdetail.si)  =  2600000 THEN nv_dss_per = 29.72.
    END.
END.
ELSE IF wdetail.cargrp = "3" THEN DO:  /*กลุ่ม 3 ไม่เกิน 2,000 ซีซี  */ 
    IF deci(wdetail.cc) <= 2000   THEN DO:
        IF      DECI(wdetail.si)  =  830000    THEN nv_dss_per = 16.64 .
        ELSE IF DECI(wdetail.si)  =  840000    THEN nv_dss_per = 17.23 .
        ELSE IF DECI(wdetail.si)  =  850000    THEN nv_dss_per = 17.82 .
        ELSE IF DECI(wdetail.si)  =  860000    THEN nv_dss_per = 18.40 .
        ELSE IF DECI(wdetail.si)  =  870000    THEN nv_dss_per = 18.97 .
        ELSE IF DECI(wdetail.si)  =  880000    THEN nv_dss_per = 19.53 .
        ELSE IF DECI(wdetail.si)  =  890000    THEN nv_dss_per = 20.09 .
        ELSE IF DECI(wdetail.si)  =  900000    THEN nv_dss_per = 20.63 .
        ELSE IF DECI(wdetail.si)  =  910000    THEN nv_dss_per = 21.17 .
        ELSE IF DECI(wdetail.si)  =  920000    THEN nv_dss_per = 21.71 .
        ELSE IF DECI(wdetail.si)  =  930000    THEN nv_dss_per = 22.23 .
        ELSE IF DECI(wdetail.si)  =  940000    THEN nv_dss_per = 22.75 .
        ELSE IF DECI(wdetail.si)  =  950000    THEN nv_dss_per = 23.26 .
        ELSE IF DECI(wdetail.si)  =  960000    THEN nv_dss_per = 23.76 .
        ELSE IF DECI(wdetail.si)  =  970000    THEN nv_dss_per = 24.26 .
        ELSE IF DECI(wdetail.si)  =  980000    THEN nv_dss_per = 24.75 .
        ELSE IF DECI(wdetail.si)  =  990000    THEN nv_dss_per = 25.24 .
        ELSE IF DECI(wdetail.si)  =  1000000   THEN nv_dss_per = 25.72 .
        ELSE IF DECI(wdetail.si)  =  1050000   THEN nv_dss_per = 28.25 .
        ELSE IF DECI(wdetail.si)  =  1100000   THEN nv_dss_per = 30.61 .
    END.
    ELSE DO:   /*กลุ่ม 3 เกิน 2,000 ซีซี        */
        IF      DECI(wdetail.si)  =  830000    THEN nv_dss_per = 6.72  .
        ELSE IF DECI(wdetail.si)  =  840000    THEN nv_dss_per = 7.38  .
        ELSE IF DECI(wdetail.si)  =  850000    THEN nv_dss_per = 8.04  .
        ELSE IF DECI(wdetail.si)  =  860000    THEN nv_dss_per = 8.69  .
        ELSE IF DECI(wdetail.si)  =  870000    THEN nv_dss_per = 9.32  .
        ELSE IF DECI(wdetail.si)  =  880000    THEN nv_dss_per = 9.95  .
        ELSE IF DECI(wdetail.si)  =  890000    THEN nv_dss_per = 10.57 .
        ELSE IF DECI(wdetail.si)  =  900000    THEN nv_dss_per = 11.18 .
        ELSE IF DECI(wdetail.si)  =  910000    THEN nv_dss_per = 11.79 .
        ELSE IF DECI(wdetail.si)  =  920000    THEN nv_dss_per = 12.38 .
        ELSE IF DECI(wdetail.si)  =  930000    THEN nv_dss_per = 12.97 .
        ELSE IF DECI(wdetail.si)  =  940000    THEN nv_dss_per = 13.55 .
        ELSE IF DECI(wdetail.si)  =  950000    THEN nv_dss_per = 14.12 .
        ELSE IF DECI(wdetail.si)  =  960000    THEN nv_dss_per = 14.69 .
        ELSE IF DECI(wdetail.si)  =  970000    THEN nv_dss_per = 15.24 .
        ELSE IF DECI(wdetail.si)  =  980000    THEN nv_dss_per = 15.79 .
        ELSE IF DECI(wdetail.si)  =  990000    THEN nv_dss_per = 16.33 .
        ELSE IF DECI(wdetail.si)  =  1000000   THEN nv_dss_per = 16.87 .
        ELSE IF DECI(wdetail.si)  =  1050000   THEN nv_dss_per = 19.70 .
        ELSE IF DECI(wdetail.si)  =  1100000   THEN nv_dss_per = 22.34 .
    END.
END.
ELSE IF wdetail.cargrp = "4" THEN DO:  /*กลุ่ม 4 ไม่เกิน 2,000 ซีซี */
    IF deci(wdetail.cc) <= 2000   THEN DO:
        IF      DECI(wdetail.si)  =  830000    THEN nv_dss_per = 12.70 .
        ELSE IF DECI(wdetail.si)  =  840000    THEN nv_dss_per = 13.32 .
        ELSE IF DECI(wdetail.si)  =  850000    THEN nv_dss_per = 13.93 .
        ELSE IF DECI(wdetail.si)  =  860000    THEN nv_dss_per = 14.54 .
        ELSE IF DECI(wdetail.si)  =  870000    THEN nv_dss_per = 15.14 .
        ELSE IF DECI(wdetail.si)  =  880000    THEN nv_dss_per = 15.73 .
        ELSE IF DECI(wdetail.si)  =  890000    THEN nv_dss_per = 16.31 .
        ELSE IF DECI(wdetail.si)  =  900000    THEN nv_dss_per = 16.88 .
        ELSE IF DECI(wdetail.si)  =  910000    THEN nv_dss_per = 17.44 .
        ELSE IF DECI(wdetail.si)  =  920000    THEN nv_dss_per = 18.00 .
        ELSE IF DECI(wdetail.si)  =  930000    THEN nv_dss_per = 18.55 .
        ELSE IF DECI(wdetail.si)  =  940000    THEN nv_dss_per = 19.10 .
        ELSE IF DECI(wdetail.si)  =  950000    THEN nv_dss_per = 19.63 .
        ELSE IF DECI(wdetail.si)  =  960000    THEN nv_dss_per = 20.16 .
        ELSE IF DECI(wdetail.si)  =  970000    THEN nv_dss_per = 20.68 .
        ELSE IF DECI(wdetail.si)  =  980000    THEN nv_dss_per = 21.20 .
        ELSE IF DECI(wdetail.si)  =  990000    THEN nv_dss_per = 21.71 .
        ELSE IF DECI(wdetail.si)  =  1000000   THEN nv_dss_per = 22.21 .
        ELSE IF DECI(wdetail.si)  =  1050000   THEN nv_dss_per = 24.85 .
        ELSE IF DECI(wdetail.si)  =  1100000   THEN nv_dss_per = 27.33 .
    END.
    ELSE DO:
        IF      DECI(wdetail.si)  =  830000    THEN nv_dss_per = 2.31  .
        ELSE IF DECI(wdetail.si)  =  840000    THEN nv_dss_per = 3.01  .
        ELSE IF DECI(wdetail.si)  =  850000    THEN nv_dss_per = 3.70  .
        ELSE IF DECI(wdetail.si)  =  860000    THEN nv_dss_per = 4.37  .
        ELSE IF DECI(wdetail.si)  =  870000    THEN nv_dss_per = 5.04  .
        ELSE IF DECI(wdetail.si)  =  880000    THEN nv_dss_per = 5.70  .
        ELSE IF DECI(wdetail.si)  =  890000    THEN nv_dss_per = 6.35  .
        ELSE IF DECI(wdetail.si)  =  900000    THEN nv_dss_per = 6.99  .
        ELSE IF DECI(wdetail.si)  =  910000    THEN nv_dss_per = 7.62  .
        ELSE IF DECI(wdetail.si)  =  920000    THEN nv_dss_per = 8.24  .
        ELSE IF DECI(wdetail.si)  =  930000    THEN nv_dss_per = 8.86  .
        ELSE IF DECI(wdetail.si)  =  940000    THEN nv_dss_per = 9.46  .
        ELSE IF DECI(wdetail.si)  =  950000    THEN nv_dss_per = 10.07 .
        ELSE IF DECI(wdetail.si)  =  960000    THEN nv_dss_per = 10.65 .
        ELSE IF DECI(wdetail.si)  =  970000    THEN nv_dss_per = 11.24 .
        ELSE IF DECI(wdetail.si)  =  980000    THEN nv_dss_per = 11.81 .
        ELSE IF DECI(wdetail.si)  =  990000    THEN nv_dss_per = 12.38 .
        ELSE IF DECI(wdetail.si)  =  1000000   THEN nv_dss_per = 12.94 .
        ELSE IF DECI(wdetail.si)  =  1050000   THEN nv_dss_per = 15.90 .
        ELSE IF DECI(wdetail.si)  =  1100000   THEN nv_dss_per = 18.67 .
    END.
END.
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
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME     = trim(wdetail.insnam)         AND 
    sicsyac.xmm600.homebr   = trim(wdetail.n_branch)     AND 
    sicsyac.xmm600.clicod   = "IN"  NO-ERROR NO-WAIT.    
IF NOT AVAILABLE sicsyac.xmm600 THEN DO: 
    IF LOCKED sicsyac.xmm600 THEN DO:   
        ASSIGN nv_transfer = NO 
            n_insref    = sicsyac.xmm600.acno.
        MESSAGE "return 1 " VIEW-AS ALERT-BOX.
        RETURN.
    END.
    ELSE DO:
        ASSIGN  n_check   = "" 
            nv_insref = "".
        IF trim(wdetail.tiname) <> " " THEN DO: 
            IF  R-INDEX(trim(wdetail.tiname),"จก.")             <> 0  OR R-INDEX(trim(wdetail.tiname),"จำกัด")           <> 0  OR  
                R-INDEX(trim(wdetail.tiname),"(มหาชน)")         <> 0  OR R-INDEX(trim(wdetail.tiname),"INC.")            <> 0  OR 
                R-INDEX(trim(wdetail.tiname),"CO.")             <> 0  OR R-INDEX(trim(wdetail.tiname),"LTD.")            <> 0  OR 
                R-INDEX(trim(wdetail.tiname),"LIMITED")         <> 0  OR INDEX(trim(wdetail.tiname),"บริษัท")            <> 0  OR 
                INDEX(trim(wdetail.tiname),"บ.")                <> 0  OR INDEX(trim(wdetail.tiname),"บจก.")              <> 0  OR 
                INDEX(trim(wdetail.tiname),"หจก.")              <> 0  OR INDEX(trim(wdetail.tiname),"หสน.")              <> 0  OR 
                INDEX(trim(wdetail.tiname),"บรรษัท")            <> 0  OR INDEX(trim(wdetail.tiname),"มูลนิธิ")           <> 0  OR 
                INDEX(trim(wdetail.tiname),"ห้าง")              <> 0  OR INDEX(trim(wdetail.tiname),"ห้างหุ้นส่วน")      <> 0  OR 
                INDEX(trim(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0  OR INDEX(trim(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                INDEX(trim(wdetail.tiname),"และ/หรือ")          <> 0  OR INDEX(trim(wdetail.tiname),"ห.จ.ก.") <> 0   THEN nv_typ = "Cs".
            ELSE nv_typ = "0s".   /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/
        END.
        ELSE DO:  /* ---- Check ด้วย name ---- */
            IF  R-INDEX(trim(wdetail.tiname),"จก.")             <> 0  OR R-INDEX(trim(wdetail.tiname),"จำกัด")           <> 0  OR  
                R-INDEX(trim(wdetail.tiname),"(มหาชน)")         <> 0  OR R-INDEX(trim(wdetail.tiname),"INC.")            <> 0  OR 
                R-INDEX(trim(wdetail.tiname),"CO.")             <> 0  OR R-INDEX(trim(wdetail.tiname),"LTD.")            <> 0  OR 
                R-INDEX(trim(wdetail.tiname),"LIMITED")         <> 0  OR INDEX(trim(wdetail.tiname),"บริษัท")            <> 0  OR 
                INDEX(trim(wdetail.tiname),"บ.")                <> 0  OR INDEX(trim(wdetail.tiname),"บจก.")              <> 0  OR 
                INDEX(trim(wdetail.tiname),"หจก.")              <> 0  OR INDEX(trim(wdetail.tiname),"หสน.")              <> 0  OR 
                INDEX(trim(wdetail.tiname),"บรรษัท")            <> 0  OR INDEX(trim(wdetail.tiname),"มูลนิธิ")           <> 0  OR 
                INDEX(trim(wdetail.tiname),"ห้าง")              <> 0  OR INDEX(trim(wdetail.tiname),"ห้างหุ้นส่วน")      <> 0  OR 
                INDEX(trim(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0  OR INDEX(trim(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                INDEX(trim(wdetail.tiname),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
            ELSE nv_typ = "0s".         /*0s= บุคคลธรรมดา Cs = นิติบุคคล  */
        END.
        RUN proc_insno. 
        IF n_check <> "" THEN DO: 
            ASSIGN nv_transfer = NO
                nv_insref   = "".
            MESSAGE "return 2 " VIEW-AS ALERT-BOX.
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
                        MESSAGE "return 3 " VIEW-AS ALERT-BOX.
                        RETURN.
                    END.
                END.
                ELSE LEAVE loop_runningins.
            END.
        END.
        IF nv_insref <> "" THEN CREATE sicsyac.xmm600.
        ELSE DO:
            ASSIGN wdetail.pass = "N"  
                wdetail.comment = wdetail.comment + "| รหัสลูกค้าเป็นค่าว่างไม่สามารถนำเข้าระบบได้ค่ะ" 
                WDETAIL.OK_GEN  = "N"
                nv_transfer = NO.
        END.    /**/
    END.
    n_insref = nv_insref.
    IF nv_typ = "Cs" THEN ASSIGN wdetail.firstName = TRIM(wdetail.insnam)
        wdetail.lastName  = "".
    ELSE DO:
        IF R-INDEX(TRIM(wdetail.insnam)," ") <> 0 THEN ASSIGN wdetail.firstName = substr(TRIM(wdetail.insnam),1,R-INDEX(TRIM(wdetail.insnam)," "))
                wdetail.lastName  = substr(TRIM(wdetail.insnam),R-INDEX(TRIM(wdetail.insnam)," ")).
        ELSE ASSIGN wdetail.firstName =  TRIM(wdetail.insnam) 
                wdetail.lastName  = "".
    END.
END.
ELSE DO:
    IF sicsyac.xmm600.acno <> "" THEN DO:   /* กรณีพบ */
        IF SUBSTR(trim(sicsyac.xmm600.acno),2) = "C" OR SUBSTR(trim(sicsyac.xmm600.acno),3) = "C" THEN
            ASSIGN wdetail.firstName = TRIM(wdetail.insnam)
            wdetail.lastName  = "".
        ELSE DO:
            IF R-INDEX(TRIM(wdetail.insnam)," ") <> 0 THEN ASSIGN wdetail.firstName = substr(TRIM(wdetail.insnam),1,R-INDEX(TRIM(wdetail.insnam)," "))
                    wdetail.lastName  = substr(TRIM(wdetail.insnam),R-INDEX(TRIM(wdetail.insnam)," ")).
            ELSE ASSIGN wdetail.firstName =  TRIM(wdetail.insnam) 
                    wdetail.lastName  = "".
        END.
        ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            n_insref                = caps(trim(nv_insref)) 
            nv_transfer             = NO 
            sicsyac.xmm600.ntitle   = trim(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname    = ""                        /*First Name*/
            sicsyac.xmm600.name     = trim(wdetail.insnam)       /*Name Line 1*/
            sicsyac.xmm600.abname   = trim(wdetail.insnam)       /*Abbreviated Name*/
            sicsyac.xmm600.icno     = TRIM(wdetail.Icno)              /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1    = trim(wdetail.add1)             /*Address line 1*/
            sicsyac.xmm600.addr2    = trim(wdetail.add2)                             /*Address line 2*/
            sicsyac.xmm600.addr3    = trim(wdetail.add3)                             /*Address line 3*/
            sicsyac.xmm600.addr4    = trim(wdetail.add4)
            sicsyac.xmm600.homebr   = trim(wdetail.n_branch)     /*Home branch*/
            sicsyac.xmm600.opened   = TODAY
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid  . 
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
        sicsyac.xmm600.icno     = TRIM(wdetail.Icno)        /*IC No.*/     /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = trim(wdetail.add1)        /*Address line 1*/
        sicsyac.xmm600.addr2    = trim(wdetail.add2)        /*Address line 2*/
        sicsyac.xmm600.addr3    = trim(wdetail.add3)        /*Address line 3*/
        sicsyac.xmm600.addr4    = trim(wdetail.add4)        /*Address line 4*/
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
        sicsyac.xmm600.taxdate  = ? .                       /*Agent tax date*/
END.
IF sicsyac.xmm600.acno <> "" THEN DO:              
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
        ASSIGN sicsyac.xtm600.acno      = nv_insref              /*Account no.*/
            sicsyac.xtm600.name      = trim(wdetail.insnam)    /*Name of Insured Line 1*/
            sicsyac.xtm600.abname    = trim(wdetail.insnam)    /*Abbreviated Name*/
            sicsyac.xtm600.addr1     = trim(wdetail.add1)  /*address line 1*/
            sicsyac.xtm600.addr2     = trim(wdetail.add2)  /*address line 2*/
            sicsyac.xtm600.addr3     = trim(wdetail.add3)  /*address line 3*/
            sicsyac.xtm600.addr4     = trim(wdetail.add4)  /*address line 4*/
            sicsyac.xtm600.name2     = ""                     /*Name of Insured Line 2*/ 
            sicsyac.xtm600.ntitle    = trim(wdetail.tiname)   /*Title*/
            sicsyac.xtm600.name3     = ""                     /*Name of Insured Line 3*/
            sicsyac.xtm600.fname     = ""    .                 /*First Name*/
    END. 
END.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
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
DEF VAR nv_lastno  AS INT INIT 0. 
DEF VAR nv_seqno   AS INT INIT 0.  
ASSIGN  nv_insref = "" .

FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
    sicsyac.xzm056.seqtyp   =  nv_typ        AND
    sicsyac.xzm056.branch   =  trim(wdetail.n_branch)   NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN sicsyac.xzm056.seqtyp =  nv_typ
            sicsyac.xzm056.branch    =  trim(wdetail.n_branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref = trim(wdetail.n_branch)  + String(1,"999999")
            nv_lastno = 1.
        MESSAGE "return 11 " VIEW-AS ALERT-BOX.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(trim(wdetail.n_branch)) = 2 THEN
            nv_insref = trim(wdetail.n_branch) + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:
            /*A56-0318....
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno + 1 ,"999999").   A56-0318*/
            /*Add ... A56-0318*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (trim(wdetail.n_branch) = "A") OR (trim(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (trim(wdetail.n_branch) = "A") OR (trim(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  trim(wdetail.n_branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(trim(wdetail.n_branch)) = 2 THEN
            nv_insref = trim(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + trim(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       trim(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").
        END.   
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  trim(wdetail.n_branch)
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(trim(wdetail.n_branch)) = 2 THEN
            nv_insref = trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").*/
            /*Add ... A56-0318*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (trim(wdetail.n_branch) = "A") OR (trim(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (trim(wdetail.n_branch) = "A") OR (trim(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       trim(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
    END.
    ELSE DO:
        IF LENGTH(trim(wdetail.n_branch)) = 2 THEN
            nv_insref = trim(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + trim(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       trim(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno,"99999").
        END.
    END.   
END.
IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno Then Do :
    /*MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
        "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
        "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. */
    n_check = "ERROR".
    MESSAGE "return 12 " VIEW-AS ALERT-BOX.
    RETURN. 
END.         /*lastno > seqno*/                       
ELSE DO :    /*lastno <= seqno */
    IF nv_typ = "0s" THEN DO:
        IF n_search = YES THEN DO:
            CREATE sicsyac.xzm056.
            ASSIGN
                sicsyac.xzm056.seqtyp    =  nv_typ
                sicsyac.xzm056.branch    =  trim(wdetail.n_branch)
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
                sicsyac.xzm056.branch    =  trim(wdetail.n_branch)
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
wdetail.Driver1name      ชื่อผู้ขับขี่                                 
wdetail.Driver1DOB       วันเดือนปีเกิด ผู้ขับขี่  yyyymmdd (ปี พ.ศ.) 
wdetail.Driver1License   เลขใบขับขี่                                  
wdetail.Driver2name      ชื่อผู้ขับขี่                                
wdetail.Driver2DOB       วันเดือนปีเกิด ผู้ขับขี่                     
wdetail.Driver2License   เลขใบขับขี่ */ 
IF  wdetail.Driver1name <> "" THEN DO :     
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
    IF wdetail.Driver1DOB <> "" THEN
        nv_drivage1 =  YEAR(TODAY) - (INT(SUBSTR(wdetail.Driver1DOB,1,4)))   .  /* yyyymmdd (ปี พ.ศ.) */

    IF wdetail.Driver2DOB <> "" THEN
        nv_drivage2 =  YEAR(TODAY) - (INT(SUBSTR(wdetail.Driver2DOB,1,4)))  .

    IF wdetail.Driver1DOB <> " "  AND wdetail.Driver1name <> " " THEN DO:  /*note add & modified*/
        nv_drivbir1      =  SUBSTR(wdetail.Driver1DOB,7,2) + "/" +
                            SUBSTR(wdetail.Driver1DOB,5,2) + "/" +
                            SUBSTR(wdetail.Driver1DOB,1,4) .
                             
    END.
    IF wdetail.Driver2DOB <>  " " AND wdetail.Driver2name <> " " THEN DO: /*note add & modified */
        nv_drivbir2      =  SUBSTR(wdetail.Driver2DOB,7,2) + "/" +
                            SUBSTR(wdetail.Driver2DOB,5,2) + "/" +
                            SUBSTR(wdetail.Driver2DOB,1,4)  .
    END.
    ASSIGN 
        no_sex1 = "MALE"  
        no_sex2 = "MALE". 
    IF INDEX(wdetail.Driver1name,"นางสาว") <> 0 OR INDEX(wdetail.Driver1name,"นาง")  <> 0 OR
        INDEX(wdetail.Driver1name,"น.ส.")   <> 0 OR INDEX(wdetail.Driver1name,"หญิง") <> 0 THEN no_sex1 = "FEMALE".
    IF INDEX(wdetail.Driver2name,"นางสาว") <> 0 OR INDEX(wdetail.Driver2name,"นาง")  <> 0 OR
        INDEX(wdetail.Driver2name,"น.ส.")   <> 0 OR INDEX(wdetail.Driver2name,"หญิง") <> 0 THEN no_sex2 = "FEMALE".
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
        brstat.mailtxt_fil.ltext     = wdetail.Driver1name + FILL(" ",50 - LENGTH(wdetail.Driver1name)) .
        SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = no_sex1. 
        brstat.mailtxt_fil.ltext2 = trim(SUBSTR(wdetail.Driver1DOB,7,2) + "/" +
                                         SUBSTR(wdetail.Driver1DOB,5,2) + "/" +
                                         SUBSTR(wdetail.Driver1DOB,1,4)) + "  " + string(nv_drivage1,"99") + " -" NO-ERROR.
        /*brstat.mailtxt_fil.ltext2 = TRIM(brstat.mailtxt_fil.ltext2).
        brstat.mailtxt_fil.ltext2 = brstat.mailtxt_fil.ltext2 + FILL(" ",15  - LENGTH(brstat.mailtxt_fil.ltext2)) + "-" .*/ /*TRIM(namtxt.occup)*/
        nv_drivno                    = 1.
        ASSIGN 
            brstat.mailtxt_fil.bchyr   = nv_batchyr 
            brstat.mailtxt_fil.bchno   = nv_batchno 
            brstat.mailtxt_fil.bchcnt  = nv_batcnt 
            SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"                        
            /*SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = trim(wdetail.dicno) */      
            SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.Driver1License)  . 

        IF wdetail.Driver2name <> "" THEN DO: 
            CREATE brstat.mailtxt_fil.         
            ASSIGN                             
                brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                brstat.mailtxt_fil.ltext    = wdetail.Driver2name + FILL(" ",50 - LENGTH(wdetail.Driver2name)) 
                SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = no_sex2
                brstat.mailtxt_fil.ltext2   = trim(SUBSTR(wdetail.Driver2DOB,7,2) + "/" +
                                              SUBSTR(wdetail.Driver2DOB,5,2) + "/" +
                                              SUBSTR(wdetail.Driver2DOB,1,4)) + "  " + TRIM(string(nv_drivage2,"99")) + " -" NO-ERROR.
            /*brstat.mailtxt_fil.ltext2   = TRIM(brstat.mailtxt_fil.ltext2).
            brstat.mailtxt_fil.ltext2   = brstat.mailtxt_fil.ltext2 + FILL(" ",15  - LENGTH(brstat.mailtxt_fil.ltext2)) + "-" .*/ 
            nv_drivno                   = 2.
            ASSIGN 
                brstat.mailtxt_fil.bchyr   = nv_batchyr 
                brstat.mailtxt_fil.bchno   = nv_batchno 
                brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"    
                /*SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = trim(wdetail.ddicno)  */     
                SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.Driver2License)   .
        END.   /*drivnam2 <> " " */
    END. /*End Avail Brstat*/
    ELSE  DO:
        CREATE  brstat.mailtxt_fil.
        ASSIGN  brstat.mailtxt_fil.policy     = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + 
            string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
            brstat.mailtxt_fil.lnumber    = nv_lnumber
            /*--    Add by Nary A54-0396 --*/
            brstat.mailtxt_fil.ltext      = wdetail.Driver1name + FILL(" ",50 - LENGTH(wdetail.Driver1name))
            SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = no_sex1
            /*--End Add by Nary A54-0396 --*/
            brstat.mailtxt_fil.ltext2     = SUBSTR(wdetail.Driver1DOB,7,2) + "/" +
                                            SUBSTR(wdetail.Driver1DOB,5,2) + "/" +
                                            SUBSTR(wdetail.Driver1DOB,1,4) + " " + string(nv_drivage1,"99") + " -" NO-ERROR.
        ASSIGN
            SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"                        
            /*SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = trim(wdetail.dicno)  */     
            SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.Driver1License)  . 
        
        IF wdetail.Driver2name <> "" THEN DO:
            CREATE  brstat.mailtxt_fil.
            ASSIGN
                brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                brstat.mailtxt_fil.ltext    = wdetail.Driver2name + FILL(" ",50 - LENGTH(wdetail.Driver2name))
                SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = no_sex2
                                brstat.mailtxt_fil.ltext2   = SUBSTR(wdetail.Driver2DOB,7,2) + "/" +
                                              SUBSTR(wdetail.Driver2DOB,5,2) + "/" +
                                              SUBSTR(wdetail.Driver2DOB,1,4)  + " " + TRIM(string(nv_drivage2,"99")) + " -" NO-ERROR .
            ASSIGN
                                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"    
                                /*SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = trim(wdetail.ddicno) */      
                                SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.Driver2License)   .
        END.  /*drivnam2 <> " " */
        ASSIGN
            brstat.mailtxt_fil.bchyr   = nv_batchyr 
            brstat.mailtxt_fil.bchno   = nv_batchno 
            brstat.mailtxt_fil.bchcnt  = nv_batcnt .
    END.  /*Else DO*/
END. /*note add for mailtxt 07/11/2005*/
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

FIND FIRST stat.maktab_fil Use-index      maktab04          Where
    stat.maktab_fil.makdes   =    wdetail.brand             And                  
    index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
    stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
    stat.maktab_fil.sclass   =     wdetail.subclass         /*AND
    /*(stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
    stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) AND*/
    stat.maktab_fil.seats    =   INTEGER(wdetail.seat)*/
    No-lock NO-WAIT NO-ERROR.
IF AVAIL stat.maktab_fil  THEN
    Assign
        nv_modcod        =  stat.maktab_fil.modcod                                    
        nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.redbook  =  stat.maktab_fil.modcod 
        wdetail.seat     =  string(stat.maktab_fil.seats)
        chkred = YES  .
/*A63-0259 */
 IF nv_modcod = "" THEN DO:
     Find First stat.maktab_fil Use-index maktab04             Where
         stat.maktab_fil.makdes   =  wdetail.brand             And                  
         index(stat.maktab_fil.moddes,wdetail.model) <> 0      And
         stat.maktab_fil.makyea   =  Integer(wdetail.caryear)  AND
         stat.maktab_fil.tons     =  Integer(wdetail.engcc)    AND
         stat.maktab_fil.sclass   =  wdetail.subclass          AND
         (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )   <=  deci(wdetail.si)   OR
          stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )   >=  deci(wdetail.si) ) AND
         stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  No-lock no-error no-wait.
     If  avail stat.maktab_fil  Then 
         ASSIGN  
         nv_modcod        =  stat.maktab_fil.modcod 
         wdetail.redbook  =  stat.maktab_fil.modcod
         wdetail.body     =  stat.maktab_fil.body  
         wdetail.brand    =  stat.maktab_fil.makdes  
         wdetail.model    =  stat.maktab_fil.moddes
         wdetail.weight   =  string(stat.maktab_fil.tons)
         wdetail.cargrp   =  stat.maktab_fil.prmpac
         wdetail.seat     =  string(stat.maktab_fil.seats).
     chkred           = YES.
    
 END.
    /*A63-0259*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab2 c-Win 
PROCEDURE proc_maktab2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 Find First stat.maktab_fil Use-index maktab04             Where
     stat.maktab_fil.makdes   =  wdetail.brand             And                  
     index(stat.maktab_fil.moddes,wdetail.model) <> 0      And
     stat.maktab_fil.makyea   =  Integer(wdetail.caryear)  AND
     stat.maktab_fil.engine   =  Integer(wdetail.engcc)    AND
     stat.maktab_fil.sclass   =  wdetail.subclass          AND
    /* (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )   GE  deci(wdetail.si)   OR
     stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )   LE  deci(wdetail.si) ) AND*/
     stat.maktab_fil.seats    =  INTEGER(wdetail.seat)  No-lock no-error no-wait.
 If  avail stat.maktab_fil  Then 
     ASSIGN  wdetail.redbook =  stat.maktab_fil.modcod
     nv_modcod       =  stat.maktab_fil.modcod                                    
     nv_moddes       =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
     wdetail.cargrp          =  stat.maktab_fil.prmpac
     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
     sic_bran.uwm301.body    =  stat.maktab_fil.body.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_modify c-Win 
PROCEDURE proc_modify :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Modify by : kridtiya i. A53-0310 date. 07/10/2010
1.ตรวจสอบ รหัสโค้ตดีเลอร์ ดังนี้ ถ้าพบ ไม่ให้ Run Policy Auto ของ Branch L (ไม่นำเข้าข้อมูล )
   ชื่อ-ดีเลอร์                             รหัสดีเลอร์ สาขา    producer        agent                   code_deler      code_vat
พาราวินเซอร์                                0008                L       B3L0010 B3L0010         
พาราวินเซอร์ โชว์รูมบางซ่อน                 PV4             L   B3L0010 B3L0010         
พาราวินเซอร์ โชว์รูมบางปิ้ง                 PV1             L   B3L0010 B3L0010         
พาราวินเซอร์ โชว์รูมประชาอุทิศ      PV3             L   B3L0010 B3L0010         
พาราวินเซอร์ โชว์รูมพระรามสี่       PV6             L   B3L0010 B3L0010         
พาราวินเซอร์ โชว์รูมมีนบุรี                 PV2             L   B3L0010 B3L0010         
พาราวินเซอร์ โชว์รูมศรีนครินทร์     PV8             L   B3L0010 B3L0010         MT0C074 MC22143
พาราวินเซอร์ โชว์รูมอาคารวิบูลย์    PV5             L   B3L0010 B3L0010         
พาราวินเซอร์ โชว์รูมอื้อจื่อเหลียง  PV7             L   B3L0010 B3L0010         MT0C004 MC10753
             สนง.ใหญ่

2.แก้ไขคำนำหน้า ของ Code Ins.  เนื่องจากระบบจะึดึงคำนำหน้า โดยจะมีทั้ง คุณ และ นาย / น.ส./ บจก. เป็นต้น  ซึ่งเดิม Text file จะมีคำนำหน้าเป็น นาย / น.ส. / บจก. อยู่แล้ว

3.ให้ระบบสามารถ Gen เฉพาะ Line 72 ด้วย ในกรณีที่ทาง TIB แจ้งเฉพาะ Line 72 อย่างเดียว....*/

/*create by   : Kridtiya i. A52-0351   date . 04/11/2010                */
/*              ปรับการรับค่าเพิ่มข้อมูลในรายละเอียด เพิ่มอุปกรณ์เสริม"*/ 


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
ASSIGN fi_process = "Import text file to uwm100 ".
    DISP fi_process WITH FRAM fr_main.

DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
IF wdetail.poltyp = "v72" THEN n_rencnt = 0.  
IF wdetail.policy <> "" THEN DO:
    IF wdetail.stk  <>  ""  THEN DO: 
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN
            wdetail.pass    = "N"
            wdetail.comment =  wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        /*comment kridtiya i. A53-0263 
        FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
        substr(sicuw.uwm301.policy,3,2)  = substr( wdetail.poltyp,2,2) AND
        substr(sicuw.uwm301.policy,5,2)  = SUBstr(STRING(YEAR(TODAY) + 543),3,2) AND  /*ปีปัจจุบัน*/
        sicuw.uwm301.cha_no  = wdetail.chasno  NO-ERROR NO-WAIT.
        comment kridtiya i. A53-0263 */
        IF wdetail.nSTATUS <> "A"  THEN
            ASSIGN   
            wdetail.pass    = "N"
            wdetail.comment =  wdetail.comment + "| กรมธรรม์นี้ไม่สามารถนำเข้าได้โดยสถานะไม่เท่ากับ A: " + wdetail.nSTATUS
            wdetail.OK_GEN  = "N".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN
                wdetail.pass    = "N"
                wdetail.comment =  wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
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
            wdetail.comment =  wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.      /*wdetail.stk  <>  ""*/
    ELSE DO:  /*sticker = ""*/ 
        /*comment kridtiya i. A53-0263 
        FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
            substr(sicuw.uwm301.policy,3,2)  = substr( wdetail.poltyp,2,2) AND
            substr(sicuw.uwm301.policy,5,2)  = SUBstr(STRING(YEAR(TODAY) + 543),3,2) AND  /*ปีปัจจุบัน*/
            sicuw.uwm301.cha_no  = wdetail.chasno  NO-ERROR NO-WAIT.
            comment kridtiya i. A53-0263 */
        IF wdetail.nSTATUS <> "A"  THEN
            ASSIGN   wdetail.pass    = "N"
                     wdetail.comment =  wdetail.comment + "| กรมธรรม์นี้ไม่สามารถนำเข้าได้โดยสถานะไม่เท่ากับ A: " + wdetail.nSTATUS
                     wdetail.OK_GEN  = "N".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES THEN 
                ASSIGN   
                wdetail.pass    = "N"
                wdetail.comment =  wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            IF wdetail.policy = "" THEN DO:
                RUN proc_temppolicy.
                wdetail.policy  = nv_tmppol.
            END.
            RUN proc_create100. 
        END.  /*policy <> "" & stk = ""*/                 
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
            wdetail.comment =  wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN
                wdetail.pass    = "N"
                wdetail.comment =  wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
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
            wdetail.comment =  wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
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
IF wdetail.poltyp = "V70"  AND  wdetail.Docno <> ""  THEN 
    ASSIGN 
    nv_docno  =  wdetail.Docno
    nv_accdat = TODAY.
ELSE DO:
   IF  wdetail.docno  = "" THEN nv_docno  = "".
   IF  wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
ASSIGN nv_insref = "" . /**/
RUN proc_insnam.        /**/
RUN proc_insnam2 . /*Add by Kridtiya i. A63-0472*/
RUN proc_chkcode . /*A64-0138*/
DO TRANSACTION:
   ASSIGN
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = wdetail.poltyp
      sic_bran.uwm100.insref = nv_insref
      sic_bran.uwm100.opnpol = ""
      sic_bran.uwm100.anam2  = wdetail.Icno                /* ICNO  */
      sic_bran.uwm100.ntitle = wdetail.tiname              
      sic_bran.uwm100.name1  = trim(wdetail.insnam)            
      sic_bran.uwm100.name2  = wdetail.NAME2                
      sic_bran.uwm100.name3  = ""                 
      sic_bran.uwm100.addr1  = wdetail.add1    
      sic_bran.uwm100.addr2  = wdetail.add2 
      sic_bran.uwm100.addr3  = wdetail.add3 
      sic_bran.uwm100.addr4  = wdetail.add4 
      sic_bran.uwm100.postcd  =  ""                                 
      sic_bran.uwm100.undyr  = String(Year(today),"9999")  /*   nv_undyr  */
      sic_bran.uwm100.branch =  wdetail.n_branch           /* nv_branch  */                        
      sic_bran.uwm100.dept   = nv_dept                     
      sic_bran.uwm100.usrid  = USERID(LDBNAME(1))          
      sic_bran.uwm100.fstdat = DATE(wdetail.comdat)        /*ให้ firstdate=comdate */
      sic_bran.uwm100.comdat = DATE(wdetail.comdat)        
      sic_bran.uwm100.expdat = date(wdetail.expdat)        
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
      sic_bran.uwm100.prog   = "wgwtbgen"
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
      sic_bran.uwm100.acno1  =  wdetail.producer  /*  nv_acno1 */
      sic_bran.uwm100.agent  =  wdetail.agent     /*nv_agent   */
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
      sic_bran.uwm100.drn_p  = NO
      sic_bran.uwm100.sch_p  = NO
      sic_bran.uwm100.cr_2   = wdetail.cr_2
      sic_bran.uwm100.bchyr  = nv_batchyr         /*Batch Year */  
      sic_bran.uwm100.bchno  = nv_batchno         /*Batch No.  */  
      sic_bran.uwm100.bchcnt = nv_batcnt          /*Batch Count*/  
      sic_bran.uwm100.prvpol = wdetail.prepol     /*A52-0172*/
      sic_bran.uwm100.cedpol = wdetail.appenno
      sic_bran.uwm100.finint = wdetail.deler
      sic_bran.uwm100.dealer = wdetail.financecd    /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.bs_cd  = wdetail.vatcod      /*add เพิ่ม Vatcode*/
      sic_bran.uwm100.opnpol =  ""         /*CAPS( wdetail.ins_pay)*/  
      /*sic_bran.uwm100.endern  = ?   recive date. */  
      sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)   /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)    /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.postcd     = trim(wdetail.postcd)      /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.icno       = trim(wdetail.icno)        /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)     /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)   /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)   /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)   /*Add by Kridtiya i. A63-0472*/
      /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*/  /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov) /*Add by Kridtiya i. A63-0472*/  . 
      IF wdetail.prepol <> " " THEN DO:
          IF wdetail.poltyp = "v72"  THEN ASSIGN  sic_bran.uwm100.prvpol  = ""
                                                  sic_bran.uwm100.tranty  = "R"
                                                  sic_bran.uwm100.bs_cd   = "" 
                                                  sic_bran.uwm100.fstdat  =  wdetail.firstdat.  
          ELSE 
              ASSIGN
                  sic_bran.uwm100.prvpol  = wdetail.prepol        /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                  sic_bran.uwm100.tranty  = "R"
                  sic_bran.uwm100.bs_cd   = "" 
                  sic_bran.uwm100.fstdat  =  wdetail.firstdat.    /*Transaction Type (N/R/E/C/T)*/
      END.
      IF  wdetail.pass = "Y" THEN
        sic_bran.uwm100.impflg  = YES.
      ELSE 
        sic_bran.uwm100.impflg  = NO.
      IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN 
         sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
      IF  wdetail.cancel = "ca" THEN
         sic_bran.uwm100.polsta = "CA" .
      ELSE  
         sic_bran.uwm100.polsta = "IF".
      IF fi_loaddat <> ? THEN
         sic_bran.uwm100.trndat = fi_loaddat.
      ELSE
         sic_bran.uwm100.trndat = TODAY.
      sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
      /*-------------- Comment By Piyachat A54-0146 ----------------------
      nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                    ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat. 
      --------------------------------------------------------------------*/  
      /*---------------- STR Piyachat A54-0146 --------------------------*/
      IF ( DAY(sic_bran.uwm100.comdat)      =   DAY(sic_bran.uwm100.expdat)    AND
           MONTH(sic_bran.uwm100.comdat)    = MONTH(sic_bran.uwm100.expdat)    AND
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
          nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .   /*    =  366  ??? */
      END.
      /*---------------- END Piyachat A54-0146 --------------------------*/
END.  /*transaction*//**/
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
       RUN wgw/wgwad120 (INPUT sic_bran.uwm100.policy,   
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
        ASSIGN
            /*sic_bran.uwm120.class  = IF wdetail.poltyp = "v72" THEN  wdetail.subclass ELSE  wdetail.prempa +  wdetail.subclass *//*Comment Kridtiya i. A63-00143*/ 
            sic_bran.uwm120.class  = IF wdetail.poltyp = "v72" THEN  wdetail.subclass ELSE  "T" +  wdetail.subclass                /*Add     Kridtiya i. A63-00143*/ 
            s_recid2     = RECID(sic_bran.uwm120).
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
ASSIGN fi_process = "Check data Renew... ".
    DISP fi_process WITH FRAM fr_main.
RUN proc_renew_veh. 
ASSIGN 
    wdetail.agent    = fi_agent       
    wdetail.producer = fi_producer    
    wdetail.vehreg   = wdetail.vehreg + " " + wdetail.re_country
    wdetail.vatcod   = ""
    wdetail.name2       = "".
FIND LAST sicuw.uwm301  USE-INDEX uwm30103  WHERE     /*trareg chassis */
    sicuw.uwm301.trareg             = wdetail.chasno  AND
    substr(sicuw.uwm301.policy,3,2) = "70"            NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL sicuw.uwm301 THEN DO:                        /*policy renew */
    FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
        sicuw.uwm100.policy = sicuw.uwm301.policy
        No-lock No-error no-wait.
    IF AVAIL sicuw.uwm100  THEN DO:
        IF sicuw.uwm100.renpol <> " " THEN DO:
            MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
            ASSIGN  wdetail.prepol  = "Already Renew"   /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
                wdetail.comment =  wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
                wdetail.OK_GEN  = "N"
                wdetail.pass     = "N". 
        END.
        ELSE DO: 
            /*IF sicuw.uwm100.acno1 <> "A0M7023" THEN DO: 
                IF sicuw.uwm100.acno1 <> "B3M0008" THEN 
                    ASSIGN  wdetail.prepol  = "Already Renew"   /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
                    wdetail.comment = wdetail.comment + "| เลขตัวถังที่ต้องการต่ออายุ ใช้ รหัสตัวแทนไม่ถูกต้องรหัสตัวแทนไม่เท่ากับ A0M7023,B3M0008" 
                    wdetail.OK_GEN  = "N"
                    wdetail.pass    = "N". 
                ELSE 
                    ASSIGN
                        wdetail.prepol = sicuw.uwm100.policy
                        n_rencnt  =  sicuw.uwm100.rencnt  +  1
                        n_endcnt  =  0
                        wdetail.pass  = "Y".
                    RUN proc_assignrenew.                  /*รับค่า ความคุ้มครองของเก่า */
            END.
            ELSE */
                ASSIGN wdetail.prepol = sicuw.uwm100.policy
                    n_rencnt  =  sicuw.uwm100.rencnt  +  1
                    n_endcnt  =  0
                    wdetail.pass  = "Y".
                RUN proc_assignrenew.                  /*รับค่า ความคุ้มครองของเก่า */
        END.
    END.      /*  avail  buwm100  */
    Else do:  
           ASSIGN n_rencnt  =  0  
               n_Endcnt  =  0
               wdetail.prepol   = ""
               wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".
             
    END.  /*not  avail uwm100*/
    IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".
END.  /* sicuw.uwm301 */
ELSE DO:
    ASSIGN wdetail.comment = wdetail.comment + "| ไม่พบเลขตัวถังในการต่ออายุ " 
           wdetail.OK_GEN  = "N"
           wdetail.pass     = "N".

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew2 c-Win 
PROCEDURE proc_renew2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*  RUN proc_renew_veh. */
ASSIGN 
    wdetail.agent    = fi_agent       
    wdetail.producer = fi_producer    
    wdetail.vehreg   = wdetail.vehreg + " " + wdetail.re_country
    wdetail.vatcod   = ""
    wdetail.name2    = "".
IF wdetail.prepol = "" THEN DO: 
    ASSIGN wdetail.comment = wdetail.comment + "| ไม่พบเลขกรมธรรม์ในการต่ออายุ " 
        wdetail.OK_GEN  = "N"
        wdetail.pass    = "N".
END.
ELSE DO:
    FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
        sicuw.uwm100.policy = wdetail.prepol   No-lock No-error no-wait.
    IF AVAIL sicuw.uwm100  THEN DO:
        IF sicuw.uwm100.renpol <> " " THEN DO:
            ASSIGN  wdetail.prepol  = "Already Renew"   /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
                wdetail.comment = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
                wdetail.OK_GEN  = "N"
                wdetail.pass    = "N". 
        END.
        ELSE DO: 
            ASSIGN wdetail.prepol = sicuw.uwm100.policy
                n_rencnt  =  sicuw.uwm100.rencnt  +  1
                n_endcnt  =  0
                wdetail.pass  = "Y".
            RUN proc_assignrenew.                  /*รับค่า ความคุ้มครองของเก่า */
        END.
    END.     /*  avail  buwm100  */
    Else do:  
        ASSIGN n_rencnt     =  0  
            n_Endcnt        =  0
            wdetail.prepol  = ""
            wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".
    END.   /*not  avail uwm100*/
    IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew_veh c-Win 
PROCEDURE proc_renew_veh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
/*1*/   IF wdetail.re_country = "65"    THEN wdetail.re_country = "กบ".
/*2*/   IF wdetail.re_country = "01"    THEN wdetail.re_country = "กท".
/*3*/   IF wdetail.re_country = "25"    THEN wdetail.re_country = "กจ".
/*4*/   IF wdetail.re_country = "40"    THEN wdetail.re_country = "กส".
/*5*/   IF wdetail.re_country = "68"    THEN wdetail.re_country = "กพ".
/*6*/   IF wdetail.re_country = "15"    THEN wdetail.re_country = "ขก".
/*7*/   IF wdetail.re_country = "37"    THEN wdetail.re_country = "จท".
/*8*/   IF wdetail.re_country = "11"    THEN wdetail.re_country = "ฉท".
/*9*/   IF wdetail.re_country = "05"    THEN wdetail.re_country = "ชบ".
/*10*/  IF wdetail.re_country = "44"    THEN wdetail.re_country = "ชน".
/*11*/  IF wdetail.re_country = "46"    THEN wdetail.re_country = "ชย".
/*12*/  IF wdetail.re_country = "64"    THEN wdetail.re_country = "ชพ".
/*13*/  IF wdetail.re_country = "73"    THEN wdetail.re_country = "ชร".
/*14*/  IF wdetail.re_country = "75"    THEN wdetail.re_country = "ชม".
/*15*/  IF wdetail.re_country = "14"    THEN wdetail.re_country = "ตง".
/*16*/  IF wdetail.re_country = "49"    THEN wdetail.re_country = "ตร".
/*17*/  IF wdetail.re_country = "62"    THEN wdetail.re_country = "ตก".
/*18*/  IF wdetail.re_country = "50"    THEN wdetail.re_country = "นย".
/*19*/  IF wdetail.re_country = "08"    THEN wdetail.re_country = "นฐ".
/*20*/  IF wdetail.re_country = "30"    THEN wdetail.re_country = "นพ".
/*21*/  IF wdetail.re_country = "42"    THEN wdetail.re_country = "นม".
/*22*/  IF wdetail.re_country = "38"    THEN wdetail.re_country = "นศ".
/*23*/  IF wdetail.re_country = "53"    THEN wdetail.re_country = "นว".
/*24*/  IF wdetail.re_country = "02"    THEN wdetail.re_country = "นบ".
/*25*/  IF wdetail.re_country = "19"    THEN wdetail.re_country = "นธ".
/*26*/  IF wdetail.re_country = "72"    THEN wdetail.re_country = "นน".
/*27*/  IF wdetail.re_country = "47"    THEN wdetail.re_country = "บร".
/*28*/  IF wdetail.re_country = "06"    THEN wdetail.re_country = "ปท".
/*29*/  IF wdetail.re_country = "26"    THEN wdetail.re_country = "ปข".
/*30*/  IF wdetail.re_country = "13"    THEN wdetail.re_country = "ปจ".
/*31*/  IF wdetail.re_country = "21"    THEN wdetail.re_country = "ปน".
/*32*/  IF wdetail.re_country = "55"    THEN wdetail.re_country = "อย".
/*33*/  IF wdetail.re_country = "74"    THEN wdetail.re_country = "พย".
/*34*/  IF wdetail.re_country = "63"    THEN wdetail.re_country = "พง".
/*35*/  IF wdetail.re_country = "12"    THEN wdetail.re_country = "พท".
/*36*/  IF wdetail.re_country = "60"    THEN wdetail.re_country = "พจ".
/*37*/  IF wdetail.re_country = "54"    THEN wdetail.re_country = "พล".
/*38*/  IF wdetail.re_country = "24"    THEN wdetail.re_country = "พบ".
/*39*/  IF wdetail.re_country = "70"    THEN wdetail.re_country = "พช".
/*40*/  IF wdetail.re_country = "71"    THEN wdetail.re_country = "พร".
/*41*/  IF wdetail.re_country = "66"    THEN wdetail.re_country = "ภก".
/*42*/  IF wdetail.re_country = "32"    THEN wdetail.re_country = "มค".
/*43*/  IF wdetail.re_country = "23"    THEN wdetail.re_country = "มห".
/*44*/  IF wdetail.re_country = "76"    THEN wdetail.re_country = "มส".
/*45*/  IF wdetail.re_country = "20"    THEN wdetail.re_country = "ยล".
/*46*/  IF wdetail.re_country = "35"    THEN wdetail.re_country = "รอ".
/*47*/  IF wdetail.re_country = "67"    THEN wdetail.re_country = "รน".
/*48*/  IF wdetail.re_country = "16"    THEN wdetail.re_country = "รย".
/*49*/  IF wdetail.re_country = "10"    THEN wdetail.re_country = "รบ".
/*50*/  IF wdetail.re_country = "58"    THEN wdetail.re_country = "ลบ".
/*51*/  IF wdetail.re_country = "61"    THEN wdetail.re_country = "ลป".
/*52*/  IF wdetail.re_country = "41"    THEN wdetail.re_country = "ลพ".
/*53*/  IF wdetail.re_country = "43"    THEN wdetail.re_country = "ลย".
/*54*/  IF wdetail.re_country = "18"    THEN wdetail.re_country = "ศก".
/*55*/  IF wdetail.re_country = "29"    THEN wdetail.re_country = "สน".
/*56*/  IF wdetail.re_country = "09"    THEN wdetail.re_country = "สข".
/*57*/  IF wdetail.re_country = "57"    THEN wdetail.re_country = "สก".
/*58*/  IF wdetail.re_country = "52"    THEN wdetail.re_country = "สบ".
/*59*/  IF wdetail.re_country = "51"    THEN wdetail.re_country = "สห".
/*60*/  IF wdetail.re_country = "48"    THEN wdetail.re_country = "สท".
/*61*/  IF wdetail.re_country = "22"    THEN wdetail.re_country = "สพ".
/*62*/  IF (wdetail.re_country = "33") OR (wdetail.re_country = "84") THEN wdetail.re_country = "สฎ".
/*63*/  IF wdetail.re_country = "34"    THEN wdetail.re_country = "สร".
/*64*/  IF wdetail.re_country = "36"    THEN wdetail.re_country = "นค".
/*65*/  IF wdetail.re_country = "39"    THEN wdetail.re_country = "นล".
/*66*/  IF wdetail.re_country = "56"    THEN wdetail.re_country = "อท".
/*67*/  IF wdetail.re_country = "69"    THEN wdetail.re_country = "อจ".
/*68*/  IF wdetail.re_country = "28"    THEN wdetail.re_country = "อด".
/*69*/  IF wdetail.re_country = "59"    THEN wdetail.re_country = "อต".
/*70*/  IF wdetail.re_country = "45"    THEN wdetail.re_country = "อท".
/*71*/  IF wdetail.re_country = "04"    THEN wdetail.re_country = "อบ".
/*72*/  IF wdetail.re_country = "17"    THEN wdetail.re_country = "ยส".
/*73*/  IF wdetail.re_country = "27"    THEN wdetail.re_country = "สต".
/*74*/  IF wdetail.re_country = "03"    THEN wdetail.re_country = "สป".
/*75*/  IF wdetail.re_country = "31"    THEN wdetail.re_country = "สส".
/*76*/  IF wdetail.re_country = "07"    THEN wdetail.re_country = "สค".*/
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
    "Redbook   "   ","
    "Branch    "   "," 
    "Delercode "   "," 
    "vatcode   "   "," 
    "policyno  "   ","  
    "cndat     "   ","  
    "appenno   "   ","  
    "comdat    "   ","  
    "expdat    "   ","  
    "comcode   "   ","  
    "cartyp    "   ","  
    "saletyp   "   ","  
    "campen    "   ","  
    "freeamonth"   ","  
    "covcod    "   ","  
    "typcom    "   ","  
    "garage    "   ","  
    "bysave    "   ","  
    "tiname    "   ","  
    "insnam    "   ","  
    "name2     "   ","  
    "name3     "   ","  
    "addr      "   ","  
    "road     "    ","  
    "tambon   "    ","  
    "amper    "    ","  
    "country  "    ","  
    "post     "    ","  
    "occup    "    ","  
    "birthdat "    ","  
    "icno     "    ","  
    "driverno "    ","  
    "brand    "    ","  
    "cargrp   "    ","  
    "chasno   "    ","  
    "eng      "    ","  
    "model    "    ","  
    "caryear  "    ","  
    "carcode  "    ","  
    "body     "    ","  
    "carno    "    ","  
    "vehuse   "    ","  
    "seat      "   ","  
    "engcc     "   ","  
    "colorcar  "   ","  
    "vehreg    "   ","  
    "re_country"   ","  
    "re_year   "   ","  
    "nmember   "   ","   
    "si        "   ","   
    "premt     "   ","   
    "rstp_t    "   ","   
    "rtax_t    "   ","   
    "prem_r    "   ","   
    "gap       "   ","   
    "ncb       "   ","   
    "ncbprem   "   ","   
    "stk       "   ","
    "prepol    "   ","
    "flagname  "   "," 
    "flagno    "   "," 
    "ntitle1    "  "," 
    "drivername1"  "," 
    "dname1     "  "," 
    "dname2     "  "," 
    "docoup     "  "," 
    "dbirth     "  "," 
    "dicno      "  "," 
    "ddriveno   "  "," 
    "ntitle2    "  "," 
    "drivername2"  "," 
    "ddname1    "  "," 
    "ddname2    "  "," 
    "ddocoup    "  "," 
    "ddbirth    "  "," 
    "ddicno     "  "," 
    "dddriveno  "  "," 
    "benname    "  "," 
    "comper     "  "," 
    "comacc     "  "," 
    "deductpd   "  "," 
    "tp2        "  "," 
    "deductda   "  "," 
    "deduct     "  "," 
    "tpfire     "  "," 
    "compul     "  "," 
    "pass       "  "," 
    "NO_41      "  "," 
    "ac2        "  "," 
    "NO_42      "  "," 
    "ac4        "  "," 
    "ac5        "  "," 
    "ac6        "  "," 
    "ac7        "  "," 
    "NO_43      "  "," 
    "nstatus    "  "," 
    "typrequest "  "," 
    "comrequest "  "," 
    "brrequest  "  "," 
    "salename    " "," 
    "comcar      " "," 
    "brcar       " "," 
    "projectno   " "," 
    "caryear     " "," 
    "special1    " "," 
    "specialprem1" "," 
    "special2    " "," 
    "specialprem2" "," 
    "special3    " ","
    "specialprem3" ","
    "special4    " ","
    "specialprem4" ","
    "comment     " "," 
    "WARNING     " SKIP.                                                   
FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"   :            
                            
        PUT STREAM ns1 
            wdetail.redbook     "," 
            wdetail.n_branch      "," 
            wdetail.deler         "," 
            wdetail.vatcod            "," 
            wdetail.policy       ","
            wdetail.cndat          ","
            wdetail.appenno        ","
            wdetail.comdat         ","
            wdetail.expdat         ","
            /*wdetail.comcode        ","*/
            /*wdetail.cartyp         ","*/
            wdetail.active         ","
            wdetail.nSTATUS        "," 
            wdetail.flag           ","
            wdetail.covcod         ","
            wdetail.seqno          ","
            wdetail.garage         "," 
            wdetail.lotno          ","
            wdetail.tiname         ","
            wdetail.insnam         ","
            wdetail.name2          ","  
            wdetail.add1        ","  
            wdetail.add2        ","  
            wdetail.add3        ","  
            wdetail.add4        ","   
            wdetail.icno           "," 
            wdetail.brand          ","               
            wdetail.cargrp         ","               
            wdetail.chasno         ","               
            wdetail.eng            ","               
            wdetail.model          "," 
            wdetail.caryear        "," 
            wdetail.body           "," 
            wdetail.vehuse         "," 
            wdetail.seat           "," 
            wdetail.engcc          ","
            wdetail.vehreg         "," 
            wdetail.re_country     "," 
            wdetail.ncd            "," 
            wdetail.si             "," 
            wdetail.premt          "," 
            wdetail.rstp_t         "," 
            wdetail.rtax_t         "," 
            wdetail.prem_r         "," 
            wdetail.gap            "," 
            wdetail.ncb            "," 
            wdetail.stk            ","
            wdetail.prepol         ","
            wdetail.ccd            ","
            /*wdetail.ntitle1        ","
            wdetail.drivername1    ","   
            wdetail.dname1         ","   
            wdetail.dname2         "," 
            wdetail.ddriveno       ","   
            wdetail.ntitle2        ","   
            wdetail.drivername2    ","   
            wdetail.ddname1        ","   
            wdetail.ddname2        ","   
            wdetail.dddriveno      "," */  
            wdetail.benname        ","   
            /*wdetail.comper         ","   
            wdetail.comacc         "," */  
            wdetail.deductpd       ","   
            /*wdetail.tp2            "," */  
            wdetail.deductda       ","   
            wdetail.deductpd2       ","   
            wdetail.compul         ","   
            wdetail.pass           ","     
            /*wdetail.NO_41         ","   
            wdetail.NO_42         ","   
            wdetail.NO_43         "," */  
            wdetail.nstatus       ","   
            wdetail.vatcod        "," 
            wdetail.caryear       ","   
            wdetail.subclass     ","
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
nv_row  =  1.
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.
FOR EACH  wdetail WHERE wdetail.PASS = "Y"  :
        pass = pass + 1.

END.
IF pass > 0 THEN DO:
OUTPUT STREAM ns2 TO value(fi_output1).
          PUT STREAM NS2
              "Redbook   "      "," 
              "Branch    "      ","   
              "Delercode "      ","   
              "Vatcode   "      "," 
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
              "comment     "    "," 
              "WARNING     "    
        SKIP. 

    FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
            wdetail.redbook     ","   
            wdetail.n_branch    ","   
            wdetail.deler       ","   
            wdetail.vatcod      ","   
            wdetail.policy      "," 
            wdetail.cndat       "," 
            wdetail.appenno     "," 
            wdetail.comdat      "," 
            wdetail.expdat      "," 
            wdetail.active      "," 
            wdetail.nSTATUS     "," 
            wdetail.flag        "," 
            wdetail.covcod      ","
            wdetail.seqno       ","
            wdetail.garage      "," 
            wdetail.lotno       ","
            wdetail.tiname      ","
            wdetail.insnam      ","
            wdetail.name2       "," 
            wdetail.add1        ","  
            wdetail.add2        ","  
            wdetail.add3        ","  
            wdetail.add4        ","  
            wdetail.icno        "," 
                        
            wdetail.brand       ","               
            wdetail.cargrp      ","               
            wdetail.chasno      ","               
            wdetail.eng         ","               
            wdetail.model       "," 
            wdetail.caryear     "," 
            
            wdetail.body        "," 
            
            wdetail.vehuse      "," 
            wdetail.seat        "," 
            wdetail.engcc       "," 
            
            wdetail.vehreg      "," 
            wdetail.re_country  "," 
            
            wdetail.ncd         "," 
            wdetail.si          "," 
            wdetail.premt       "," 
            wdetail.rstp_t      "," 
            wdetail.rtax_t      "," 
            wdetail.prem_r      "," 
            wdetail.gap         "," 
            wdetail.ncb         "," 
            
            wdetail.stk         "," 
            wdetail.prepol      "," 
            wdetail.ccd      ","
            /*wdetail.ntitle1       ","
            wdetail.drivername1   ","   
            wdetail.dname1        ","   
            wdetail.dname2        "," 
            wdetail.ddriveno      ","   
            wdetail.ntitle2       ","   
            wdetail.drivername2   ","   
            wdetail.ddname1       ","   
            wdetail.ddname2       ","   
            wdetail.dddriveno     ","  */ 
            wdetail.benname       ","   
           /* wdetail.comper        ","   
            wdetail.comacc        "," */  
            wdetail.deductpd      ","   
           /* wdetail.tp2           ","  */ 
            wdetail.deductda      ","   
            wdetail.deductpd2     ","   
            wdetail.compul        ","   
            wdetail.pass          ","     
            /*wdetail.NO_41         ","   
            wdetail.NO_42         ","   
            wdetail.NO_43         "," */  
            wdetail.nstatus       ","   
            wdetail.caryear       ","   
            wdetail.subclass     ","
            wdetail.comment       ","
            wdetail.WARNING         
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
"IMPORT TEXT FILE TIB " SKIP
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
      /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. */  /*db test.*/
      /*CONNECT    expiry   -ld sic_exp  -H 10.35.176.37 -S 9060 -N tcp -U value(gv_id)    -P value(nv_pwd) NO-ERROR.  */
       
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
    nv_txt1  = "Date Sent:" + wdetail.cndat + "User Sent:" + wdetail.appenno + " Active:" +
               wdetail.active + " Status:" + wdetail.nSTATUS + " Flag:" + wdetail.flag 
    nv_txt2  = "Lot No:" + wdetail.lotno + " SeqNo.:" + wdetail.seqno + 
               " Tran.Date:" + string(TODAY,"99/99/9999") + " Time:" + "123 " 
    nv_txt3  = "NCD : " + wdetail.ncd
    nv_txt4  = "CCD : " + wdetail.ccd
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
IF (n_stk70tex = "" ) OR (substring(n_stk70tex,1,1) = "0")  THEN n_stk70tex = "ไม่มีพรบ.".
ELSE 
    n_stk70tex = SUBSTR(n_stk70tex,1,INDEX(n_stk70tex,"/")) + " STK:" + SUBSTR(n_stk70tex,INDEX(n_stk70tex,"/") + 1).

FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
DO WHILE nv_line1 <= 8:
    CREATE wuppertxt3.
    wuppertxt3.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt3.txt = "Date Sent:" + wdetail.cndat + " User Sent:" + wdetail.appenno + " Active:" +
                                            wdetail.active + " Status:" + wdetail.nSTATUS + " Flag:" + wdetail.flag.
    IF nv_line1 = 2  THEN wuppertxt3.txt = "Lot No:" + wdetail.lotno + " SeqNo.:" + wdetail.seqno + 
               " Tran.Date:" + wdetail.trandat + " Time:" + wdetail.trantim.
    IF nv_line1 = 3  THEN wuppertxt3.txt = "NCD : " + wdetail.ncd.
    IF nv_line1 = 4  THEN wuppertxt3.txt = "CCD : " + wdetail.ccd.
    IF nv_line1 = 5  THEN wuppertxt3.txt = "      "  .
    IF nv_line1 = 6  THEN wuppertxt3.txt = "      "  .
    IF nv_line1 = 7  THEN wuppertxt3.txt = n_stk70tex.
    IF nv_line1 = 8  THEN wuppertxt3.txt = wdetail.access.
    nv_line1 = nv_line1 + 1.                                                   
END.

IF nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? THEN DO:
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
        FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr
            NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwd102 THEN DO:  /*sombat */
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
    END.
END.                /* End DO nv_fptr */
ELSE DO:
    Assign            
         nv_fptr = 0 
         nv_bptr = 0  
         nv_nptr = 0. 
    FOR EACH wuppertxt3 NO-LOCK BREAK BY wuppertxt3.line:
                        
        CREATE sic_bran.uwd102.
        ASSIGN
            sic_bran.uwd102.policy        = sic_bran.uwm100.policy            /* NEW POLICY */
            sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt 
            sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt            /* New Endorsement */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_vehregprovin c-Win 
PROCEDURE proc_vehregprovin :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF LENGTH(TRIM(wdetail.re_country)) = 1 THEN DO:
    FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
        brstat.insure.compno = "999" AND
        brstat.insure.insno = "tib" + "0" + TRIM(wdetail.re_country) NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN 
        ASSIGN wdetail.re_country = Insure.LName
        wdetail.vehreg = wdetail.vehreg + " " + trim(Insure.LName) .
    /*ELSE wdetail.vehreg = substr(wdetail.vehreg,1,7).*//*A54-0112*/
    ELSE wdetail.vehreg = substr(wdetail.vehreg,1,8).    /*A54-0112*/
END.
ELSE DO:
    FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
        brstat.insure.compno = "999" AND
        brstat.insure.insno = "tib" + TRIM(wdetail.re_country) NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN 
        ASSIGN wdetail.re_country = Insure.LName
        wdetail.vehreg = wdetail.vehreg + " " + trim(Insure.LName) .
    /*ELSE wdetail.vehreg = substr(wdetail.vehreg,1,7) .*//*A54-0112*/
    ELSE wdetail.vehreg = SUBSTR(wdetail.vehreg,1,8).     /*A54-0112*/
         
END.

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

