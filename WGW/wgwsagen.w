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
/*programid   : wgwsagen.w                                              */ 
/*programname : load text file บจก.สยามออโต้เซอร์วิส to GW (งานต่อายุ)  */ 
/* Copyright  : Safety Insurance Public Company Limited                 */
/*copy write  : wgwatcgen.w                                             */ 
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                      */
/*create by   : Kridtiya i. A54-0011  date . 11/01/2011               
                ปรับโปรแกรมให้สามารถนำเข้า text file บจก.สยามออโต้เซอร์วิส to GW system */
/*modify by   : Kridtiya i. A54-0215  date . 27/07/2011               
                ปรับโปรแกรมให้สามารถรับค่า Text f17 เทคข้อความจากกรมธรรม์เดิมได้ครบ */
/*modify by   : Kridtiya i. A56-0082  date . 14/03/2013 ปรับการให้ค่าตัวแปรจำนวนวัน การนำเข้าระบบ*/
/*modify by   : Kridtiya i. A56-0151  Add F6,F15,F17    */
/*Modify by  : Kridtiya i. A56-0327 เพิ่ม การรับทะเบียนรถจากไฟล์นำเข้า*/
/*Modify by  : Kridtiya i. A57-0193 เพิ่ม การรับค่าคอมจากไฟล์แจ้งงาน */
/*----------------------------------------------------------------------------------*/
/* Modify By : RANU I. A58-0354  Date.15/09/2015                                    */
/*             เพิ่มตัวแปรเก็บข้อมูล nv_promo  nv_garage                            */
/*             ให้เก็บค่าช่อง Promotion..   และ   Garage  จากกรมธรรม์ตัวอย่าง       */
/*Modify by  : Kridtiya i. A59-0186 date: 30/05/2016 add occupation                 */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/*Modify by : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....     */
/*Modify by   : Ranu i. A64-0138 เพิ่มเงื่อนไขการคำนวณเบี้ยจากโปรแกรมกลาง */
/*Modify by   : Kridtiya i. A65-0035 comment message error premium not on file */
/*----------------------------------------------------------------------------------*/
DEF VAR n_firstdat AS CHAR FORMAT "x(10)"  INIT "".   
DEF VAR n_brand    AS CHAR FORMAT "x(50)"  INIT "".
DEF VAR n_model    AS CHAR FORMAT "x(50)"  INIT "".
DEF VAR n_index    AS INTE INIT 0.
DEF VAR stklen     AS INTE.
DEF VAR dod0       AS DECI.
DEF VAR dod1       AS DECI.
DEF VAR dod2       AS DECI.
DEF VAR dpd0       AS DECI.
DEF VAR nv_com1p   AS DECI INIT 0.00 .
DEF VAR n_ratmin   AS INTE INIT 0.
DEF VAR n_ratmax   AS INTE INIT 0.
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
DEF NEW SHARED VAR nv_seat41   AS INTEGER FORMAT ">>9".
DEF NEW SHARED VAR nv_totsi    AS DECIMAL FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_polday   AS INTE    FORMAT ">>9".
def New SHARED VAR nv_uom6_u   as char.                
DEF VAR            nv_chk      as  logic.
DEF VAR            nv_ncbyrs   AS INTE.        
DEF NEW SHARED VAR nv_odcod    AS CHAR     FORMAT "X(4)".
DEF NEW SHARED VAR nv_cons     AS CHAR     FORMAT "X(2)".
DEF New shared VAR nv_prem     AS DECIMAL  FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_baseap   AS DECI     FORMAT ">>,>>>,>>9.99-".
DEF New shared VAR nv_ded      AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_gapprm   AS DECI     FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_pdprm    AS DECI     FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_prvprm   AS DECI     FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_41prm    AS INTEGER  FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_ded1prm  AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_aded1prm AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF New SHARED VAR nv_ded2prm  AS INTEGER  FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_dedod    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF New SHARED VAR nv_addod    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_dedpd    AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_prem1    AS DECIMAL  FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF New SHARED VAR nv_addprm   AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW SHARED VAR nv_totded   AS INTEGER  FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF New SHARED VAR nv_totdis   AS INTEGER  FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF New SHARED VAR nv_41cod1   AS CHARACTER    FORMAT "X(4)".
DEF NEW SHARED VAR nv_41cod2   AS CHARACTER    FORMAT "X(4)".
DEF New SHARED VAR nv_41       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF New SHARED VAR nv_411prm   AS DECI         FORMAT ">,>>>,>>9.99".
DEF NEW SHARED VAR nv_412prm   AS DECI         FORMAT ">,>>>,>>9.99".
DEF New SHARED VAR nv_411var1  AS CHAR         FORMAT "X(30)".
DEF New SHARED VAR nv_411var2  AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_411var   AS CHAR         FORMAT "X(60)".
DEF New SHARED VAR nv_412var1  AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_412var2  AS CHAR         FORMAT "X(30)".
DEF New SHARED VAR nv_412var   AS CHAR         FORMAT "X(60)".
DEF NEW SHARED VAR nv_42cod    AS CHARACTER    FORMAT "X(4)".
DEF NEW SHARED VAR nv_42       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF New SHARED VAR nv_42prm    AS DECI         FORMAT ">,>>>,>>9.99".
DEF NEW SHARED VAR nv_42var1   AS CHAR         FORMAT "X(30)".
DEF New SHARED VAR nv_42var2   AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_42var    AS CHAR         FORMAT "X(60)".
DEF New SHARED VAR nv_43cod    AS CHARACTER    FORMAT "X(4)".
DEF NEW SHARED VAR nv_43       AS INTEGER      FORMAT ">>>,>>>,>>9".
DEF New SHARED VAR nv_43prm    AS DECI         FORMAT ">,>>>,>>9.99".
DEF New SHARED VAR nv_43var1   AS CHAR         FORMAT "X(30)".
DEF NEW SHARED VAR nv_43var2   AS CHAR         FORMAT "X(30)".
DEF New SHARED VAR nv_43var    AS CHAR         FORMAT "X(60)".
DEF NEW SHARED VAR nv_campcod  AS CHAR        FORMAT "X(4)".
DEF NEW SHARED VAR nv_camprem  AS DECI        FORMAT ">>>9".
DEF New SHARED VAR nv_campvar1 AS CHAR        FORMAT "X(30)".
DEF NEW SHARED VAR nv_campvar2 AS CHAR        FORMAT "X(30)".
DEF New SHARED VAR nv_campvar  AS CHAR        FORMAT "X(60)".
DEF NEW SHARED VAR nv_compcod  AS CHAR        FORMAT "X(4)".
DEF NEW SHARED VAR nv_compprm  AS DECI        FORMAT ">>>,>>9.99-".
DEF New SHARED VAR nv_compvar1 AS CHAR        FORMAT "X(30)".
DEF NEW SHARED VAR nv_compvar2 AS CHAR        FORMAT "X(30)".
DEF New SHARED VAR nv_compvar  AS CHAR        FORMAT "X(60)".
DEF NEW SHARED VAR nv_basecod  AS CHAR        FORMAT "X(4)".
DEF NEW SHARED VAR nv_baseprm  AS DECI        FORMAT ">>,>>>,>>9.99-". 
DEF New SHARED VAR nv_basevar1 AS CHAR        FORMAT "X(30)".
DEF NEW SHARED VAR nv_basevar2 AS CHAR        FORMAT "X(30)".
DEF New SHARED VAR nv_basevar  AS CHAR        FORMAT "X(60)".
DEF NEW SHARED VAR nv_cl_cod   AS CHAR       FORMAT "X(4)".
DEF NEW SHARED VAR nv_cl_per   AS DECIMAL    FORMAT ">9.99".
DEF New SHARED VAR nv_lodclm   AS INTEGER    FORMAT ">>>,>>9.99-".
DEF            VAR nv_lodclm1  AS INTEGER    FORMAT ">>>,>>9.99-".
DEF New SHARED VAR nv_clmvar1  AS CHAR       FORMAT "X(30)".
DEF NEW SHARED VAR nv_clmvar2  AS CHAR       FORMAT "X(30)".
DEF NEW SHARED VAR nv_clmvar   AS CHAR       FORMAT "X(60)".
DEF NEW SHARED VAR nv_stf_cod  AS CHAR      FORMAT "X(4)".
DEF NEW SHARED VAR nv_stf_per  AS DECIMAL   FORMAT ">9.99".
DEF New SHARED VAR nv_stf_amt  AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW SHARED VAR nv_stfvar1  AS CHAR      FORMAT "X(30)".
DEF New SHARED VAR nv_stfvar2  AS CHAR      FORMAT "X(30)".
DEF NEW SHARED VAR nv_stfvar   AS CHAR      FORMAT "X(60)".
DEF NEW SHARED VAR nv_dss_cod  AS CHAR      FORMAT "X(4)".
DEF NEW SHARED VAR nv_dss_per  AS DECIMAL   FORMAT ">9.99".
DEF New SHARED VAR nv_dsspc    AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW SHARED VAR nv_dsspcvar1 AS CHAR     FORMAT "X(30)".
DEF New SHARED VAR nv_dsspcvar2 AS CHAR     FORMAT "X(30)".
DEF NEW SHARED VAR nv_dsspcvar  AS CHAR     FORMAT "X(60)".
DEF NEW SHARED VAR nv_ncb_cod   AS CHAR  FORMAT "X(4)".
DEF NEW SHARED VAR nv_ncbper    LIKE sicuw.uwm301.ncbper.
DEF New SHARED VAR nv_ncb       AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_ncbvar1   AS CHAR  FORMAT "X(30)".
DEF New SHARED VAR nv_ncbvar2   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_ncbvar    AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_flet_cod  AS CHAR    FORMAT "X(4)".
DEF NEW SHARED VAR nv_flet_per  AS DECIMAL FORMAT ">>9".
DEF New SHARED VAR nv_flet      AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_fletvar1  AS CHAR    FORMAT "X(30)".
DEF New SHARED VAR nv_fletvar2  AS CHAR    FORMAT "X(30)".
DEF NEW SHARED VAR nv_fletvar   AS CHAR    FORMAT "X(60)".
DEF NEW SHARED VAR nv_vehuse    LIKE sicuw.uwm301.vehuse.                 
DEF NEW SHARED VAR nv_grpcod    AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_grprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_grpvar1   AS CHAR      FORMAT "X(30)".
DEF NEW SHARED VAR nv_grpvar2   AS CHAR      FORMAT "X(30)".
DEF NEW SHARED VAR nv_grpvar    AS CHAR      FORMAT "X(60)".
DEF NEW SHARED VAR nv_othcod    AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_othprm    AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_othvar1   AS CHAR      FORMAT "X(30)".
DEF NEW SHARED VAR nv_othvar2   AS CHAR      FORMAT "X(30)".
DEF NEW SHARED VAR nv_othvar    AS CHAR      FORMAT "X(60)".
DEF NEW SHARED VAR nv_dedod1_cod AS CHAR   FORMAT "X(4)".             
DEF NEW SHARED VAR nv_dedod1_prm AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW SHARED VAR nv_dedod1var1 AS CHAR   FORMAT "X(30)".            
DEF NEW SHARED VAR nv_dedod1var2 AS CHAR   FORMAT "X(30)".            
DEF NEW SHARED VAR nv_dedod1var  AS CHAR   FORMAT "X(60)".            
DEF NEW SHARED VAR nv_dedod2_cod AS CHAR   FORMAT "X(4)".             
DEF NEW SHARED VAR nv_dedod2_prm AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW SHARED VAR nv_dedod2var1 AS CHAR   FORMAT "X(30)".            
DEF NEW SHARED VAR nv_dedod2var2 AS CHAR   FORMAT "X(30)".            
DEF NEW SHARED VAR nv_dedod2var  AS CHAR   FORMAT "X(60)".            
DEF NEW SHARED VAR nv_dedpd_cod  AS CHAR   FORMAT "X(4)".             
DEF NEW SHARED VAR nv_dedpd_prm  AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW SHARED VAR nv_dedpdvar1  AS CHAR   FORMAT "X(30)".            
DEF NEW SHARED VAR nv_dedpdvar2  AS CHAR   FORMAT "X(30)".            
DEF NEW SHARED VAR nv_dedpdvar   AS CHAR   FORMAT "X(60)".            
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
DEF NEW SHARED VAR nv_usecod     AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_useprm     AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_usevar1    AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_usevar2    AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_usevar     AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_sicod      AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_siprm      AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_sivar1     AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_sivar2     AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_sivar      AS CHAR  FORMAT "X(60)".
def New shared var nv_uom6_c     as  char.      /* Sum  si*/
def New shared var nv_uom7_c     as  char.      /* Fire/Theft*/
DEF NEW SHARED VAR nv_bipcod     AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_bipprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_bipvar1 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_bipvar2 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_bipvar  AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_biacod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_biaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_biavar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_biavar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_biavar   AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_pdacod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_pdaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_pdavar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_pdavar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_pdavar   AS CHAR  FORMAT "X(60)".
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
DEF Var nv_lastno   As Int.
Def Var nv_seqno    As Int.
DEF VAR sv_xmm600   AS RECID.
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
{wgw\wgwsagen.i}      /*ประกาศตัวแปร*/
DEFINE VAR nv_txt1    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.
DEF    VAR n_taxae    AS LOGICAL .
DEF    VAR n_stmpae   AS LOGICAL .
DEF    VAR n_com2ae   AS LOGICAL .
DEF    VAR n_com1ae   AS LOGICAL .
DEF    VAR nv_fi_com2_t    AS DECI INIT 0.00.
DEF    VAR nv_fi_rstp_t    AS INTE INIT 0.
DEF    VAR nv_fi_rtax_t    AS DECI INIT 0.00 .
DEFINE VAR nv_newsck       AS CHAR FORMAT "x(15)" INIT " ".
DEF    VAR nv_uwm301trareg LIKE sicuw.uwm301.cha_no INIT "".
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".
DEF    VAR gv_id       AS CHAR FORMAT "X(8)" NO-UNDO.
DEF    VAR nv_pwd      AS CHAR NO-UNDO.
DEF    VAR nn_access   AS CHAR FORMAT "x(100)" INIT "".
DEF    VAR nn_polf6    AS CHAR FORMAT "x(12)"  INIT "".
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF VAR nv_promo  AS CHAR FORMAT "x(25)" INIT "". /*--- A58-0354--*/
DEF VAR nv_garage AS CHAR FORMAT "x(2)" INIT "". /*--- A58-0354--*/

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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.policyno wdetail.cndat wdetail.comdat wdetail.expdat wdetail.covcod wdetail.garage wdetail.tiname wdetail.insnam wdetail.policyno   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_pack fi_endexpday ra_typepol ~
fi_insurceco fi_polmas70 fi_polmas72 fi_branch fi_bchno ra_textf6 ~
ra_textf15 ra_textf17 fi_producer fi_agent fi_vatcod fi_prevbat fi_bchyr ~
fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem ~
buok bu_exit br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent fi_process RECT-370 ~
RECT-372 RECT-373 RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_pack fi_endexpday ra_typepol ~
fi_insurceco fi_polmas70 fi_polmas72 fi_branch fi_bchno ra_textf6 ~
ra_textf15 ra_textf17 fi_producer fi_agent fi_vatcod fi_prevbat fi_bchyr ~
fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes ~
fi_proname fi_impcnt fi_agtname fi_process fi_completecnt fi_premtot ~
fi_premsuc 

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
     SIZE 4 BY .95.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 43.5 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_endexpday AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_insurceco AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

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

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polmas70 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_polmas72 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 22.67 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 59.5 BY .95
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vatcod AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE ra_textf15 AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "F15 on Pol_Master", 1,
"F15 on Prepol", 2,
"No Gen", 3
     SIZE 48 BY .95
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_textf17 AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "F17 on Pol_Master", 1,
"F17 on Prepol", 2,
"No Gen", 3
     SIZE 48 BY .95
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_textf6 AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "F6  on Pol_Master", 1,
"F6  on Prepol", 2,
"No Gen", 3
     SIZE 48 BY .95
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_typepol AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "RENEW", 1,
"NEW", 2,
"RENEW(error2)", 3
     SIZE 45 BY .95
     BGCOLOR 19  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 12.52
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 5.95
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 3.57
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
      wdetail.policyno      COLUMN-LABEL "Policy No."
      wdetail.cndat         COLUMN-LABEL "CN date."
      wdetail.comdat        COLUMN-LABEL "comdate."   
      wdetail.expdat        COLUMN-LABEL "expidate." 
      wdetail.covcod        COLUMN-LABEL "covcod  "
      wdetail.garage        COLUMN-LABEL "garage  "
      wdetail.tiname        COLUMN-LABEL "tiname  "
      wdetail.insnam        COLUMN-LABEL "insnam  "
      wdetail.policyno     COLUMN-LABEL "policyno2"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 5.52
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 2.71 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 2.71 COL 51.67 COLON-ALIGNED NO-LABEL
     fi_endexpday AT ROW 2.71 COL 67.5 COLON-ALIGNED NO-LABEL
     ra_typepol AT ROW 2.71 COL 83.33 NO-LABEL
     fi_insurceco AT ROW 3.76 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_polmas70 AT ROW 3.76 COL 64 COLON-ALIGNED NO-LABEL
     fi_polmas72 AT ROW 3.76 COL 104.5 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.81 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.48 COL 15 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     ra_textf6 AT ROW 4.81 COL 83.33 NO-LABEL
     ra_textf15 AT ROW 5.86 COL 83.33 NO-LABEL
     ra_textf17 AT ROW 6.86 COL 83.33 NO-LABEL
     fi_producer AT ROW 5.86 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6.86 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_vatcod AT ROW 7.86 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 7.86 COL 61.33 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 7.86 COL 98 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 8.95 COL 24.33 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 8.95 COL 86.83
     fi_output1 AT ROW 10 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 13 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 13 COL 61.5 NO-LABEL
     buok AT ROW 10.48 COL 92.83
     bu_exit AT ROW 12.29 COL 93
     fi_brndes AT ROW 4.81 COL 37 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 15.48 COL 2.17
     bu_hpbrn AT ROW 4.81 COL 33.33
     bu_hpacno1 AT ROW 5.86 COL 43
     bu_hpagent AT ROW 6.86 COL 43
     fi_proname AT ROW 5.86 COL 45.5 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 21.91 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agtname AT ROW 6.86 COL 45.5 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 14.05 COL 24.17 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 22.91 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 21.91 COL 97 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 22.95 COL 95 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     "Branch  :" VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 4.81 COL 16.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 10 COL 7
          BGCOLOR 8 FGCOLOR 1 
     "New Policy line 72 EXT:" VIEW-AS TEXT
          SIZE 22.67 BY .95 AT ROW 3.76 COL 83.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 13 COL 81
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 8.95 COL 3.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer  Code :" VIEW-AS TEXT
          SIZE 16.17 BY .95 AT ROW 5.86 COL 9.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "  Vat code  :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 7.86 COL 13.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 24.5 BY .95 AT ROW 13 COL 60.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.14 COL 57.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     IMPORT TEXT FILE MOTOR [CARRENT GROUP - งานต่ออายุ/งานใหม่ ]" VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.33 COL 2.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 12 COL 8
          BGCOLOR 8 FGCOLOR 1 
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 7.86 COL 98.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.91 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Load Date :":35 VIEW-AS TEXT
          SIZE 11.17 BY .95 AT ROW 2.71 COL 14.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 11 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "Previous Batch No. :" VIEW-AS TEXT
          SIZE 19.83 BY .95 AT ROW 7.86 COL 43
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 21.91 COL 94.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "EXP day :" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 2.71 COL 59.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.91 COL 57.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Agent Code  :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 6.86 COL 12.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 2.71 COL 43.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 13 COL 24.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "New Policy line 70 EXT:" VIEW-AS TEXT
          SIZE 24 BY .95 AT ROW 3.76 COL 41.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Insurce code :" VIEW-AS TEXT
          SIZE 14.17 BY .95 AT ROW 3.76 COL 11.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 21.91 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.48 COL 5.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TieS 4 01/03/2022":60 VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 14 COL 92 WIDGET-ID 2
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 22.91 COL 94.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.57 COL 1.17
     RECT-373 AT ROW 15.24 COL 1
     RECT-374 AT ROW 21.24 COL 1
     RECT-375 AT ROW 21.43 COL 2.83
     RECT-376 AT ROW 21.67 COL 4.33
     RECT-377 AT ROW 10.1 COL 91.33
     RECT-378 AT ROW 11.95 COL 91.5
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
         TITLE              = "Import Text file บจก.สยามออโต้เซอร์วิส-RENEW"
         HEIGHT             = 23.95
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
          SIZE 12.83 BY .95 AT ROW 7.86 COL 98.33 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 19 BY .95 AT ROW 13 COL 24.5 RIGHT-ALIGNED               */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 24.5 BY .95 AT ROW 13 COL 60.17 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 21.91 COL 94.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.14 COL 57.5 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.91 COL 57.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 22.91 COL 94.83 RIGHT-ALIGNED       */

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
ON END-ERROR OF c-Win /* Import Text file บจก.สยามออโต้เซอร์วิส-RENEW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Import Text file บจก.สยามออโต้เซอร์วิส-RENEW */
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
        wdetail.policyno    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.cndat       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.comdat       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.expdat       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.covcod       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.garage       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.tiname       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.insnam       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.policyno    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        
        wdetail.policyno:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.cndat        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.comdat       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.expdat       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.covcod       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.garage       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.tiname       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.insnam       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.policyno    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
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
        fi_impcnt              = 0
        fi_process             = "Load Text File Siam Carrent Group".
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot fi_process  WITH FRAME fr_main.
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
        FIND LAST uzm700 USE-INDEX uzm70002     WHERE
            uzm700.bchyr   = nv_batchyr         AND
            uzm700.acno    = TRIM(fi_producer)  AND
            uzm700.branch  = TRIM(nv_batbrn)    NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:   
            nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102    WHERE
                uzm701.bchyr = nv_batchyr          AND
                uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999")  NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN 
                ASSIGN 
                nv_batcnt    = uzm701.bchcnt  
                nv_batrunno  = nv_batrunno + 1.
        END.
        ELSE   
            ASSIGN nv_batcnt = 1
                nv_batrunno  = 1.
        nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END.
    ELSE DO:  
        nv_batprev = INPUT fi_prevbat .
        FIND LAST uzm701 USE-INDEX uzm70102    WHERE 
            uzm701.bchyr   = nv_batchyr        AND
            uzm701.bchno   = CAPS(nv_batprev)  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL uzm701 THEN DO:
            MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev)
                  + " on file uzm701" .
            APPLY "entry" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
        IF AVAIL uzm701 THEN 
            ASSIGN  nv_batcnt  = uzm701.bchcnt + 1 
            nv_batchno = CAPS(TRIM(nv_batprev)).
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
    /*ASSIGN
       wdetail2.comment  = ""
       wdetail2.agent    = fi_agent
       wdetail2.producer = fi_producer     
       wdetail2.entdat   = string(TODAY)                /*entry date*/
       wdetail2.enttim   = STRING (TIME, "HH:MM:SS")    /*entry time*/
       wdetail2.trandat  = STRING (fi_loaddat)          /*tran date*/
       wdetail2.trantim  = STRING (TIME, "HH:MM:SS")    /*tran time*/
       wdetail2.n_IMPORT = "IM"
       wdetail2.n_EXPORT = "" .  */ 
    FOR EACH wdetail :
        IF wdetail.poltyp   = "V70"  OR wdetail.poltyp   = "V72"  THEN DO:
            ASSIGN  nv_reccnt  =  nv_reccnt   + 1
                nv_netprm_t    =  nv_netprm_t + decimal(wdetail.prem_r)
                wdetail.pass   =  "Y". 
        END.
        ELSE DELETE WDETAIL.
    END.
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    /*Add by Kridtiya i. A63-0472*/
    /* comment by : A64-0138..
    ELSE DO:
        FOR EACH wdetail :
            RUN wgw\wgwchkagpd (INPUT wdetail.agent  
                                ,INPUT wdetail.producer
                                ,INPUT-OUTPUT nv_chkerror).
        END.
        IF nv_chkerror <> ""  THEN DO: 
            nv_reccnt = 0.
            MESSAGE "Error Code Producer/Agent :" nv_chkerror VIEW-AS ALERT-BOX.       
            RETURN NO-APPLY.
        END.
    END.
    ..end A64-0138..*/
    /*Add by Kridtiya i. A63-0472*/
    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                           INPUT            nv_batchyr ,     /* INT   */
                           INPUT            fi_producer,     /* CHAR  */ 
                           INPUT            nv_batbrn  ,     /* CHAR  */
                           INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                           INPUT            "WGWSAGEN" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem ).    /* DECI  */
    ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.
    RUN proc_chktest1.  
    FOR EACH wdetail WHERE wdetail.pass = "y" :
        ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + decimal(wdetail.prem_r). 
    END.
    ASSIGN nv_rectot = nv_reccnt 
        nv_recsuc = nv_completecnt. 
    IF /*nv_imppol <> nv_rectot OR
    nv_imppol <> nv_recsuc OR*/
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
    FIND LAST uzm701 USE-INDEX uzm70102  WHERE
        uzm701.bchyr   = nv_batchyr      AND
        uzm701.bchno   = nv_batchno      AND
        uzm701.bchcnt  = nv_batcnt       NO-ERROR.
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
    /* add by : A64-0138 */
    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .  
    
    /*end. add A56-0082 */
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.
    RELEASE sicsyac.xzm056.
    RELEASE sicsyac.xmm600.
    /*end. add A56-0082 */
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    /* add by : A64-0138 */

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
        ASSIGN fi_completecnt:FGCOLOR = 2
               fi_premsuc:FGCOLOR     = 2 
               fi_bchno:FGCOLOR       = 2.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.
    /*/* comment by : A64-0138 */
    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .  
    
    /*end. add A56-0082 */
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.
    RELEASE sicsyac.xzm056.
    RELEASE sicsyac.xmm600.
    /*end. add A56-0082 */
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    /* add by : A64-0138 */*/
    
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
            /*nv_agent   =  fi_agent*/    .             /*note add  08/11/05*/
            
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


&Scoped-define SELF-NAME fi_endexpday
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_endexpday c-Win
ON LEAVE OF fi_endexpday IN FRAME fr_main
DO:
    fi_endexpday = INPUT fi_endexpday.
    Disp  fi_endexpday   WITH Frame  fr_main.                       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insurceco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insurceco c-Win
ON LEAVE OF fi_insurceco IN FRAME fr_main
DO:
   fi_insurceco = INPUT fi_insurceco.
   IF  fi_insurceco <> " " THEN DO:
       FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
           sicsyac.xmm600.acno  =  Input fi_insurceco  
           NO-LOCK NO-ERROR NO-WAIT.
       IF NOT AVAIL sicsyac.xmm600 THEN DO:
           Message  "Not on Name & Address Master File xmm600" 
               View-as alert-box.
           Apply "Entry" To  fi_insurceco.
           RETURN NO-APPLY. 
       END.
       ELSE DO:
           ASSIGN
               fi_insurceco =  caps(INPUT  fi_insurceco)  .       
       END.
   END.
   Disp  fi_insurceco    WITH Frame  fr_main.                 
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


&Scoped-define SELF-NAME fi_polmas70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polmas70 c-Win
ON LEAVE OF fi_polmas70 IN FRAME fr_main
DO:
    fi_polmas70 = INPUT fi_polmas70.
    Disp  fi_polmas70    WITH Frame  fr_main.                
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polmas72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polmas72 c-Win
ON LEAVE OF fi_polmas72 IN FRAME fr_main
DO:
    fi_polmas72 = INPUT fi_polmas72.
    Disp  fi_polmas72    WITH Frame  fr_main.                       
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
                fi_producer =  caps(INPUT  fi_producer)  /*note modi 08/11/05*/
                /*nv_producer = fi_producer*/    .       /*note add  08/11/05*/
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


&Scoped-define SELF-NAME fi_vatcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcod c-Win
ON LEAVE OF fi_vatcod IN FRAME fr_main
DO:
    fi_vatcod = INPUT fi_vatcod.
    IF fi_vatcod <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_vatcod  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_vatcod.
            RETURN NO-APPLY.  
        END.
        ELSE DO:  
            ASSIGN
            fi_vatcod   =  caps(INPUT  fi_vatcod)  .           
            
        END.  
    END. 
    Disp  fi_vatcod   WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_textf15
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_textf15 c-Win
ON VALUE-CHANGED OF ra_textf15 IN FRAME fr_main
DO:
  ra_textf15 = INPUT ra_textf15 .
    DISP ra_textf15 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_textf17
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_textf17 c-Win
ON VALUE-CHANGED OF ra_textf17 IN FRAME fr_main
DO:
   ra_textf17 = INPUT ra_textf17 .
   DISP ra_textf17 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_textf6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_textf6 c-Win
ON VALUE-CHANGED OF ra_textf6 IN FRAME fr_main
DO:
    ra_textf6 = INPUT ra_textf6 .
    DISP ra_textf6 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typepol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typepol c-Win
ON VALUE-CHANGED OF ra_typepol IN FRAME fr_main
DO:
  ra_typepol = INPUT ra_typepol .
  DISP ra_typepol WITH FRAM fr_main.
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
    
    gv_prgid = "Wgwsagen.w".
    gv_prog  = "Load Text & Generate บจก.สยามออโต้เซอร์วิส(RENEW)".
    fi_loaddat = TODAY.
    DISP fi_loaddat WITH FRAME fr_main.
    RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
    ASSIGN
        fi_insurceco = "19C0000015"
        fi_polmas70  = "197058A00001"
        fi_polmas72  = "197258A00001"
        ra_typepol   = 1
        fi_branch    = "19" 
        fi_pack      = "Z"
        fi_vatcod    = "19C0000007"
        fi_producer  = "A019000003"
        fi_agent     = "A000000"
        ra_textf6    = 1
        ra_textf15   = 1
        ra_textf17   = 1
        fi_endexpday = TODAY             /*A56-0082*/
        fi_bchyr     = YEAR(TODAY) .
    DISP fi_insurceco ra_typepol fi_polmas70 fi_polmas72  fi_endexpday     /*A56-0082*/
         fi_pack fi_branch fi_vatcod  fi_producer fi_agent fi_bchyr
         ra_textf6 ra_textf15 ra_textf17  WITH FRAME fr_main.
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
  DISPLAY fi_loaddat fi_pack fi_endexpday ra_typepol fi_insurceco fi_polmas70 
          fi_polmas72 fi_branch fi_bchno ra_textf6 ra_textf15 ra_textf17 
          fi_producer fi_agent fi_vatcod fi_prevbat fi_bchyr fi_filename 
          fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes 
          fi_proname fi_impcnt fi_agtname fi_process fi_completecnt fi_premtot 
          fi_premsuc 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE fi_loaddat fi_pack fi_endexpday ra_typepol fi_insurceco fi_polmas70 
         fi_polmas72 fi_branch fi_bchno ra_textf6 ra_textf15 ra_textf17 
         fi_producer fi_agent fi_vatcod fi_prevbat fi_bchyr fi_filename bu_file 
         fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit 
         br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent fi_process RECT-370 RECT-372 
         RECT-373 RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
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
DEF VAR stklen AS INTE.
DEF VAR n_seate AS INTE INIT 0.
ASSIGN 
    wdetail.compul    = "y"
    wdetail.tariff    = "9"
    wdetail.covcod    = "T"
    wdetail.garage    = " "
    /*n_rencnt          = 0*/
    n_endcnt          = 0
    wdetail.prepol    = "" 
    wdetail.tp1       = ""
    wdetail.tp2       = ""
    wdetail.tp3       = ""
    /*nv_basere         = 0*/
    dod1              = 0        
    dod2              = 0        
    dod0              = 0        
    wdetail.fleet     = "0"
    /*nv_dss_per        = 0  */
    WDETAIL.NCB       = "0"
   /* nv_cl_per         = 0  */
    wdetail.prepol    = ""
    wdetail.stk       = substr(wdetail.stk,1,length(TRIM(wdetail.stk)))  
    fi_process    = "Check Data File Siam Carrent Group.." + wdetail.policyno .
    DISP fi_process WITH FRAM fr_main.
IF ra_typepol = 2 THEN n_rencnt  = 0.
IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass    = "N"
        WDETAIL.OK_GEN  = "N". 
END.
IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk <> "" THEN DO:  
        ASSIGN stklen = 0
            stklen = INDEX(trim(wdetail.stk)," ") - 1.
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN DO:
            IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN DO: 
                IF stklen > 1 THEN wdetail.stk = "0" + substr(wdetail.stk,1,stklen).
                ELSE wdetail.stk = "0" + substr(wdetail.stk,1,LENGTH(wdetail.stk)).
            END.
        END.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN  wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
            wdetail.pass    = ""
            WDETAIL.OK_GEN  = "N".
    END.
END.
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class = wdetail.subclass  NO-LOCK NO-ERROR.
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
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
    WDETAIL.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
    WDETAIL.OK_GEN = "N".
/*--------- modcod --------------*/
/*
IF INDEX(wdetail.brand,"TOYOTA") <> 0 THEN DO:
    wdetail.brand  =  "TOYOTA".
    IF INDEX(wdetail.model,"vigo") <> 0 THEN wdetail.model = "vigo".
    ELSE IF INDEX(wdetail.model,"altis") <> 0 THEN wdetail.model = "altis".
    ELSE IF INDEX(wdetail.model,"ALPHARD") <> 0 THEN 
        ASSIGN wdetail.seat = "7"
        wdetail.model = "ALPHARD".
    ELSE IF INDEX(wdetail.model,"COROLLA") <> 0 THEN wdetail.model = "COROLLA".
    ELSE IF INDEX(wdetail.model,"CAMRY") <> 0 THEN wdetail.model = "CAMRY".
    ELSE IF INDEX(wdetail.model,"COMMUTER") <> 0 THEN 
        ASSIGN wdetail.model = "COMMUTER"
        wdetail.seat = "16".
    ELSE IF INDEX(wdetail.model,"HARRIER") <> 0 THEN wdetail.model = "HARRIER".
    ELSE IF INDEX(wdetail.model,"SOLUNA") <> 0 THEN wdetail.model = "SOLUNA".
END.
ELSE IF INDEX(wdetail.brand,"honda") <> 0 THEN DO: 
    IF INDEX(wdetail.brand,"city") <> 0 THEN wdetail.model = "city".
    ELSE IF INDEX(wdetail.brand,"ACCORD") <> 0 THEN wdetail.model = "ACCORD".
    ELSE IF INDEX(wdetail.brand,"CIVIC") <> 0 THEN wdetail.model = "CIVIC".
    ELSE IF INDEX(wdetail.brand,"JAZZ") <> 0 THEN wdetail.model = "JAZZ".
    wdetail.brand  =  "honda".
END.
ELSE IF INDEX(wdetail.brand,"CHEVROLET") <> 0 THEN DO: 
    IF INDEX(wdetail.brand,"AVEO") <> 0 THEN wdetail.model = "AVEO".
    ELSE IF INDEX(wdetail.brand,"OPTRA") <> 0 THEN wdetail.model = "OPTRA".
    wdetail.brand  =  "CHEVROLET".
END.
ELSE IF INDEX(wdetail.brand,"NISSAN") <> 0 THEN DO: 
    ASSIGN wdetail.brand  =  "NISSAN".
    IF INDEX(wdetail.model,"TIIDA") <> 0 THEN wdetail.model = "TIIDA".
    ELSE IF INDEX(wdetail.model,"FRONTIER") <> 0 THEN 
        ASSIGN wdetail.model = "FRONTIER"
        wdetail.seat = "3".
END.
ELSE IF INDEX(wdetail.brand,"BENZ") <> 0 THEN 
    ASSIGN wdetail.brand  =  "MERCEDES-BENZ".*/

/*ASSIGN nv_makdes = wdetail.brand
    /*chkred = NO*/
    nv_moddes = wdetail.model
    n_sclass72 = substr(wdetail.subclass,1,3).
IF wdetail.seat = "16"  THEN  n_seate = 12.
ELSE n_seate = INTE(wdetail.seat).
IF (wdetail.subclass =  "120A") OR (wdetail.subclass =  "120B") THEN n_sclass72 = "210".
ELSE IF wdetail.subclass =  "320A"  THEN  n_sclass72 = "320".
ELSE  n_sclass72 =  "110".

FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN n_ratmin = makdes31.si_theft_p   
           n_ratmax = makdes31.load_p   .    
ELSE ASSIGN n_ratmin = 0
            n_ratmax = 0.
Find First stat.maktab_fil USE-INDEX maktab04    Where
    stat.maktab_fil.makdes   =     wdetail.brand            And                  
    index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
    /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
    stat.maktab_fil.sclass   =     n_sclass72        AND
   (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
    stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
    stat.maktab_fil.seats    =     n_seate     
    No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    ASSIGN wdetail.redbook = stat.maktab_fil.modcod.
ELSE wdetail.redbook = "".*/
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
    WDETAIL.OK_GEN  = "N".
ASSIGN nv_docno  = " "
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
    ELSE  nv_docno = wdetail.docno.
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
ASSIGN fi_process    = "Create data uwm130 File Siam Carrent Group.." + wdetail.policyno .
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND        /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND        /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND        /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr             AND        /*26/10/2006 change field name */
    sic_bran.uwm130.bchno  = nv_batchno             AND        /*26/10/2006 change field name */ 
    sic_bran.uwm130.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno.
    ASSIGN  sic_bran.uwm130.bchyr = nv_batchyr      /* batch Year */
        sic_bran.uwm130.bchno = nv_batchno          /* bchno      */
        sic_bran.uwm130.bchcnt  = nv_batcnt .       /* bchcnt     */
    ASSIGN  sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0     /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0     /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0     /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0     /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.    /*Item Endt. Clause*/
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class  NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN 
        ASSIGN  sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
        sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9 
        nv_comper     = deci(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc     = deci(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v   = deci(wdetail.comper)   
        sic_bran.uwm130.uom9_v   = deci(wdetail.comacc)  .   
    ASSIGN  nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy,         
                                nv_riskno,
                                nv_itemno).
END.
/*transaction*/
ASSIGN
    s_recid3  = RECID(sic_bran.uwm130)
    nv_covcod =   wdetail.covcod
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
    sic_bran.uwm301.bchcnt = nv_batcnt     NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
    DO TRANSACTION:
        CREATE sic_bran.uwm301.
    END.   /*transaction*/
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
    sic_bran.uwm301.cha_no  = wdetail.chasno
    sic_bran.uwm301.eng_no  = wdetail.eng
    sic_bran.uwm301.Tons    = INTEGER(wdetail.Tonn)
    sic_bran.uwm301.engine  = INTEGER(wdetail.engcc)
    sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage  = ""
    sic_bran.uwm301.body    = wdetail.body
    sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv_ben83 = wdetail.benname
    sic_bran.uwm301.vehreg   = wdetail.vehreg  
    sic_bran.uwm301.vehuse   = wdetail.vehuse
    sic_bran.uwm301.moddes   = wdetail.model     
    sic_bran.uwm301.modcod   = wdetail.redbook 
    sic_bran.uwm301.sckno    = 0              
    sic_bran.uwm301.itmdel   = NO
    sic_bran.uwm301.bchyr    = nv_batchyr         /* batch Year */      
    sic_bran.uwm301.bchno    = nv_batchno         /* bchno      */      
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
        CREATE  brstat.Detaitem.
        ASSIGN  brstat.detaitem.policy   = sic_bran.uwm301.policy                 
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
ELSE sic_bran.uwm301.drinam[9] = "".
s_recid4  = RECID(sic_bran.uwm301).
FIND sic_bran.uwd132  USE-INDEX uwd13201  WHERE
    sic_bran.uwd132.policy = wdetail.policyno AND
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
        MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wdetail.policyno
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
    sic_bran.uwd132.gap_c   =  deci(wdetail.comp_prm)  /*deci(wdetail.premt)*//*GAP, per Benefit per Item*/
    sic_bran.uwd132.dl1_c   = 0                        /*Disc./Load 1,p. Benefit p.Item*/
    sic_bran.uwd132.dl2_c   = 0                        /*Disc./Load 2,p. Benefit p.Item*/
    sic_bran.uwd132.dl3_c   = 0                        /*Disc./Load 3,p. Benefit p.Item*/
    sic_bran.uwd132.pd_aep  = "E"                      /*Premium Due A/E/P Code*/
    sic_bran.uwd132.prem_c  = deci(wdetail.premt)      /*PD, per Benefit per Item*/
    sic_bran.uwd132.fptr    = 0                        /*Forward Pointer*/
    sic_bran.uwd132.bptr    = 0                        /*Backward Pointer*/
    sic_bran.uwd132.policy  = wdetail.policyno         /*Policy No. - uwm130*/
    sic_bran.uwd132.rencnt  = wdetail.n_rencnt                      /*Renewal Count - uwm130*/
    sic_bran.uwd132.endcnt  = wdetail.n_endcnt                      /*Endorsement Count - uwm130*/
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
ASSIGN  
    nv_rec100  = s_recid1
    nv_rec120  = s_recid2
    nv_rec130  = s_recid3
    nv_rec301  = s_recid4
    nv_message = ""
    nv_gap     = 0
    nv_prem    = 0 
fi_process     = "Create data baseprm File Siam Carrent Group.." + wdetail.policyno .
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = nv_rec301 NO-WAIT NO-ERROR.
IF sic_bran.uwm130.fptr03 = 0 OR sic_bran.uwm130.fptr03 = ? THEN DO:
    FIND sicsyac.xmm107 USE-INDEX xmm10701      WHERE
        sicsyac.xmm107.class  = wdetail.subclass  AND
        sicsyac.xmm107.tariff = wdetail.tariff    NO-LOCK NO-ERROR NO-WAIT.
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
                sic_bran.uwd132.bchcnt  = nv_batcnt .      /* bchcnt     */ 
            FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                sicsyac.xmm105.tariff = wdetail.tariff  AND
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE  MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:  /* Malaysia */
                IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.Tonn).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = uwd132.bencod    AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= nv_key_a         AND
                    sicsyac.xmm106.key_b  >= nv_key_b         AND
                    sicsyac.xmm106.effdat <= uwm100.comdat    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    ASSIGN   /*sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap*/
                        sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm)
                        sic_bran.uwd132.prem_c = deci(wdetail.premt)
                        nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                        nv_gap                 = deci(wdetail.comp_prm)
                        nv_prem                = deci(wdetail.comp_prm) .
                END.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod    AND
                    sicsyac.xmm106.key_a  >= 0                 AND
                    sicsyac.xmm106.key_b  >= 0                 AND
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
                    /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.*/
                    sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm).
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                               RECID(sic_bran.uwd132),
                                               sic_bran.uwm301.tariff).
                    ASSIGN nv_gap     = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c
                        nv_gap        = deci(wdetail.comp_prm)
                        nv_prem       = deci(wdetail.comp_prm).
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
                    sic_bran.uwd132.bchyr  = nv_batchyr    /* batch Year */      
                    sic_bran.uwd132.bchno  = nv_batchno    /* bchno      */      
                    sic_bran.uwd132.bchcnt = nv_batcnt     /* bchcnt     */      
                    n_rd132                = RECID(sic_bran.uwd132).
                FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                    sicsyac.xmm016.class = wdetail.subclass  NO-LOCK NO-ERROR.
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
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.Tonn).
                    nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff        AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod AND
                        sicsyac.xmm106.class   = wdetail.subclass      AND
                        sicsyac.xmm106.covcod  = wdetail.covcod         AND
                        sicsyac.xmm106.key_a  >= nv_key_a               AND
                        sicsyac.xmm106.key_b  >= nv_key_b               AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE sicsyac.xmm106 THEN DO:
                        ASSIGN    /*sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                        sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap*/
                            sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm)
                            sic_bran.uwd132.prem_c = deci(wdetail.premt)
                            nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                            nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                            nv_gap                 = deci(wdetail.comp_prm)
                            nv_prem                = deci(wdetail.comp_prm).
                    END.
                END.
                ELSE DO:
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601          WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff          AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.subclass        AND
                        sicsyac.xmm106.covcod  = wdetail.covcod           AND
                        sicsyac.xmm106.key_a  >= 0                        AND
                        sicsyac.xmm106.key_b  >= 0                        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601           WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff           AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod    AND
                        sicsyac.xmm106.class   = wdetail.subclass         AND
                        sicsyac.xmm106.covcod  = wdetail.covcod            AND
                        sicsyac.xmm106.key_a   = 0                         AND
                        sicsyac.xmm106.key_b   = 0                         AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE xmm106 THEN DO:
                        /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.*/
                        sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm).
                        RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                             RECID(sic_bran.uwd132),
                                             sic_bran.uwm301.tariff).
                        nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                        nv_gap        = deci(wdetail.comp_prm).
                        nv_prem       = deci(wdetail.comp_prm).
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
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.Tonn).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601         WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff         AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod  AND
                    sicsyac.xmm106.class   = wdetail.subclass       AND
                    sicsyac.xmm106.covcod  = wdetail.covcod          AND
                    sicsyac.xmm106.key_a  >= nv_key_a                AND 
                    sicsyac.xmm106.key_b  >= nv_key_b                AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE xmm106 THEN DO:
                    ASSIGN   /*sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap*/
                        sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm)
                        sic_bran.uwd132.prem_c = deci(wdetail.premt)
                        nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                        nv_gap                 = deci(wdetail.comp_prm)
                        nv_prem                = deci(wdetail.comp_prm).
                END.
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
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601   WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod    AND
                    sicsyac.xmm106.key_a   = 0                 AND
                    sicsyac.xmm106.key_b   = 0                 AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.   */
                    sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm).
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100),         
                                         RECID(sic_bran.uwd132),                
                                         sic_bran.uwm301.tariff).
                    ASSIGN
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c
                    nv_gap                 = deci(wdetail.comp_prm)
                    nv_prem                = deci(wdetail.comp_prm).
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
             sic_bran.uwm130.policy = wdetail.policy         AND
             sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
             sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
             sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp AND
             sic_bran.uwm130.riskno = sic_bran.uwm120.riskno AND
             sic_bran.uwm130.bchyr = nv_batchyr              AND 
             sic_bran.uwm130.bchno = nv_batchno              AND 
             sic_bran.uwm130.bchcnt  = nv_batcnt             NO-LOCK:
             nv_fptr = sic_bran.uwm130.fptr03.
             DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
                 FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr
                     NO-LOCK NO-ERROR NO-WAIT.
                 IF NOT AVAILABLE sic_bran.uwd132 THEN LEAVE.
                 ASSIGN nv_fptr = sic_bran.uwd132.fptr
                 nv_gap  = nv_gap  + sic_bran.uwd132.gap_c
                 nv_prem = nv_prem + sic_bran.uwd132.prem_c.
                 
             END.
         END.
         ASSIGN 
             sic_bran.uwm120.gap_r  =  nv_gap
         sic_bran.uwm120.prem_r =  nv_prem
         sic_bran.uwm120.rstp_r  =  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) +
             (IF  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 2) -
              TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) > 0  THEN 1 ELSE 0)
         sic_bran.uwm120.rtax_r = ROUND((sic_bran.uwm120.prem_r + sic_bran.uwm120.rstp_r)  * nv_tax_per  / 100 ,2)
         nv_gap2  = nv_gap2  + nv_gap
         nv_prem2 = nv_prem2 + nv_prem
         nv_rstp  = nv_rstp  + sic_bran.uwm120.rstp_r
         nv_rtax  = nv_rtax  + sic_bran.uwm120.rtax_r.
         IF sic_bran.uwm120.com1ae = NO THEN nv_com1_per  = sic_bran.uwm120.com1p.
         IF nv_com1_per <> 0 THEN 
             ASSIGN sic_bran.uwm120.com1ae =  NO
             sic_bran.uwm120.com1p  =  nv_com1_per
             sic_bran.uwm120.com1_r =  (sic_bran.uwm120.prem_r * sic_bran.uwm120.com1p / 100) * 1-
             nv_com1_prm = nv_com1_prm + sic_bran.uwm120.com1_r.
         ELSE DO:
             IF nv_com1_per   = 0  AND sic_bran.uwm120.com1ae = NO THEN 
                 ASSIGN  sic_bran.uwm120.com1p  =  0
                 sic_bran.uwm120.com1_r =  0
                 sic_bran.uwm120.com1_r =  0
                 nv_com1_prm            =  0.
         END.
     END.
     FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
     FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
     ASSIGN  sic_bran.uwm100.gap_p  =  nv_gap2
         sic_bran.uwm100.prem_t =  nv_prem2
         sic_bran.uwm100.rstp_t =  nv_rstp
         sic_bran.uwm100.rtax_t =  nv_rtax
         sic_bran.uwm100.com1_t =  nv_com1_prm.
     RUN proc_chktest4.
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
DEF VAR ntoday AS CHAR FORMAT "x(10)".
ASSIGN  
    nn_acno   = ""
    nn_name   = ""
    nn_addr1  = ""
    nn_addr2  = ""

    nn_addr3  = ""
    nn_addr4  = ""
    nn_ntitle = ""
    n_yearpol =  SUBSTR(STRING(deci(YEAR(TODAY)) + 543 ),3,2) 
    /*ntoday    = STRING(TODAY) .*/           /*A56-0082*/
    ntoday    = STRING(fi_endexpday - 7 )     /*A56-0082*/
    nv_occup  = ""  . /*A59-0186*/  
/*comment by Kridtiya i. A56-0082....
IF  (DAY(DATE(ntoday)) - 7) <= 0  THEN DO:
        IF (MONTH(DATE(ntoday)) - 1) <= 0 THEN
            ASSIGN ntoday = string(((DAY(DATE(ntoday)) - 7 ) + 30 ),"99")   + "/" +
            STRING(((MONTH(DATE(ntoday)) - 1) + 12),"99")       + "/" +
            string((year(DATE(ntoday)) - 1),"9999") .
        ELSE ASSIGN ntoday = string(((DAY(DATE(ntoday)) + 7 ) - 30 ),"99")   + "/" +
            STRING((MONTH(DATE(ntoday)) - 1),"99")       + "/" +
            string(year(DATE(ntoday)),"9999") .
    END.
    ELSE ASSIGN ntoday = string(((DAY(DATE(ntoday)) - 7 )),"99")   + "/" +
            STRING((MONTH(DATE(ntoday))),"99")       + "/" +
            string(year(DATE(ntoday)),"9999") .  
end...comment by Kridtiya i. A56-0082....   */

/*RUN proc_assign70.   /*Assign Policy Master to new policy */ ---- A58-0354---*/
IF fi_polmas70 <> "" THEN RUN proc_assign70.    /*---- A58-0354---*/
IF fi_polmas72 <> "" THEN RUN proc_assign72.
DO:
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
            wdetail2.prepol 
            wdetail2.comdat
            wdetail2.expdat
            wdetail2.licen      /* add kridtiya i...A56-0327*/
            wdetail2.benname 
            wdetail2.commiss70
            wdetail2.commiss72 
            wdetail2.nomn30   .  /*a57-0302*/
    END.    /* repeat   */
    FIND FIRST  sicsyac.xtm600 USE-INDEX  xtm60001  WHERE
        sicsyac.xtm600.acno =   trim(fi_insurceco)  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xtm600 THEN 
        ASSIGN  
        nn_acno    =  sicsyac.xtm600.acno  
        nn_name    =  sicsyac.xtm600.name  
        nn_addr1   =  sicsyac.xtm600.addr1 
        nn_addr2   =  sicsyac.xtm600.addr2 
        nn_addr3   =  sicsyac.xtm600.addr3 
        nn_addr4   =  sicsyac.xtm600.addr4 
        nn_ntitle  =  sicsyac.xtm600.ntitle .
    ELSE 
        ASSIGN nn_acno    =  " " 
            nn_name    =  " "               
            nn_addr1   =  " "  
            nn_addr2   =  " "   
            nn_addr3   =  " "     
            nn_addr4   =  " "                           
            nn_ntitle  =  " ".
    RUN proc_xmm600.  /*Add by Kridtiya i. A63-0472*/
    FOR EACH wdetail2   NO-LOCK.
        IF index(wdetail2.prepol,"เลขกรมธรรม์เดิม") <> 0  THEN NEXT.
        ELSE IF wdetail2.prepol = "" THEN NEXT .
        ELSE DO:
            
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  TRIM(wdetail2.prepol) NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicuw.uwm100 THEN 
            MESSAGE "ไม่พบหมายเลขกรมธรรม์นี้ในระบบ Premium " VIEW-AS ALERT-BOX ERROR.
        ELSE DO: 
            /* test วันหมดอายุ > today  ok or  expdate < (today - 7 ) least 7 day*/ 
            IF (ra_typepol = 1) AND (sicuw.uwm100.renpol <> "") THEN  
                MESSAGE "กรมธรรม์นี้ถูกต่ออายุแล้ว" VIEW-AS ALERT-BOX ERROR.
            ELSE DO:
                IF      ra_typepol = 1 THEN RUN proc_renew.
                ELSE IF ra_typepol = 3 THEN RUN proc_renew3.
                ELSE IF ra_typepol = 2 THEN DO:     /*typ 2  new policy */
                    RUN proc_assignrenew.
                    ASSIGN  n_rencnt  =  0
                            n_endcnt  =  0.
                END.     /*ra_typepol = 2*/
                /*IF (nn_comdat < date(ntoday) ) AND (ra_typepol = 1)  THEN DO:
                    MESSAGE wdetail2.prepol "กรมธรรม์ต่ออายุมีวันที่ หมดอายุน้อยกว่าวันที่นำเข้า ต้องเลือกเป็น New Policy" VIEW-AS ALERT-BOX.
                    RETURN NO-APPLY.
                END.
                ELSE DO: */
                    FIND FIRST wdetail WHERE 
                        wdetail.policyno = substr(wdetail2.prepol,1,4) + n_yearpol + substr(wdetail2.prepol,7,6)  
                        NO-ERROR NO-WAIT.
                    IF NOT AVAIL wdetail THEN DO:
                        CREATE wdetail.
                        ASSIGN 
                            wdetail.n_branch  = fi_branch
                            wdetail.n_rencnt  = n_rencnt
                            wdetail.n_endcnt  = n_endcnt
                            wdetail.poltyp    = "V70" 
                            wdetail.promotion = nv_promo   /*---A58-0354--*/
                            wdetail.occup     = nv_occup   /*   A59-0186  */ 
                            wdetail.policyno = substr(wdetail2.prepol,1,4) + n_yearpol + substr(wdetail2.prepol,7,6)
                            wdetail.ins_co   = trim(fi_insurceco) 
                            wdetail.tiname   = nn_ntitle  
                            wdetail.insnam   = nn_name  
                            wdetail.n_addr1  = nn_addr1 
                            wdetail.n_addr2  = nn_addr2 
                            wdetail.n_addr3  = nn_addr3 
                            wdetail.n_addr4  = nn_addr4  
                            wdetail.benname  = wdetail2.benname 
                            wdetail.prepol   = IF (ra_typepol = 1 ) OR (ra_typepol = 3 ) THEN wdetail2.prepol ELSE " " 
                            wdetail.cr_2     = IF (sicuw.uwm100.cr_2  <> "") AND (fi_polmas72 <> "") THEN substr(wdetail2.prepol,1,2) + "72" + n_yearpol + substr(wdetail2.prepol,7,6) ELSE " "
                            wdetail.comment  = ""
                            wdetail.si       = string(n_si)
                            wdetail.tp1      = string(n_tp1) 
                            wdetail.tp2      = string(N_tp2) 
                            wdetail.tp3      = string(n_tp3) 
                            wdetail.fleet    = string(nv_flet)
                            wdetail.ncb      = string(nv_NCB) 
                            wdetail.nv_com1p     = nv_com1p70    
                            wdetail.n_taxae      = nv_taxae70    
                            wdetail.n_stmpae     = nv_stmpae70   
                            wdetail.n_com2ae     = nv_com2ae70   
                            wdetail.n_com1ae     = nv_com1ae70   
                            wdetail.nv_fi_rstp_t = nv_fi_rstp_t70
                            wdetail.nv_fi_rtax_t = nv_fi_rtax_t70
                            wdetail.subclass = nn_subclass
                            wdetail.covcod   = nn_covcod 
                            /*wdetail.garage   = nn_garage   ---A58-0354---*/
                            wdetail.garage   = nv_garage    /*--A58-0354--*/  
                            wdetail.redbook  = nn_redbook     
                            wdetail.brand    = nn_brand       
                            wdetail.model    = nn_model       
                            wdetail.body     = nn_body        
                            wdetail.engcc    = nn_engcc       
                            wdetail.tonn     = nn_tonn       
                            wdetail.seat     = nn_seat       
                            wdetail.seat41   = nn_seat41     
                            wdetail.cargrp   = nn_cargrp     
                           /* wdetail.vehreg   = nn_vehreg     */ /* kridtiya i. A56-0327*/
                            wdetail.vehreg   = IF trim(wdetail2.licen) = "" THEN nn_vehreg ELSE trim(wdetail2.licen)  /*add kridtiya i.A56-0327*/
                            wdetail.eng      = nn_eng        
                            wdetail.chasno   = nn_chasno     
                            wdetail.caryear  = nn_caryear    
                            wdetail.vehuse   = nn_vehuse   
                            wdetail.comdat   = wdetail2.comdat   
                            wdetail.expdat   = wdetail2.expdat 
                            wdetail.firstdat = string(nn_firstdat) 
                            wdetail.agent    = fi_agent
                            wdetail.producer = fi_producer
                            wdetail.vatcode  = fi_vatcod
                            wdetail.nomn30   = Trim(wdetail2.nomn30)
                            wdetail.commission = IF trim(wdetail2.commiss70) = "" THEN "0" ELSE trim(wdetail2.commiss70)      /*A57-0193*/
                            wdetail.entdat   = string(TODAY)                /*entry date*/
                            wdetail.enttim   = STRING (TIME, "HH:MM:SS")    /*entry time*/
                            wdetail.trandat  = STRING (fi_loaddat)          /*tran date*/
                            wdetail.trantim  = STRING (TIME, "HH:MM:SS")    /*tran time*/
                            wdetail.n_IMPORT = "IM"
                            wdetail.n_EXPORT = "" 
                            /*Add by Kridtiya i. A63-0472*/
                            wdetail.firstName      = nn_firstName  
                            wdetail.lastName       = nn_lastName   
                            wdetail.postcd         = nn_postcd     
                            wdetail.icno           = nn_icno       
                            wdetail.codeocc        = nn_codeocc    
                            wdetail.codeaddr1      = nn_codeaddr1  
                            wdetail.codeaddr2      = nn_codeaddr2  
                            wdetail.codeaddr3      = nn_codeaddr3  
                            wdetail.br_insured     = nn_br_insured  .
                            /*Add by Kridtiya i. A63-0472*/   
                    IF (sicuw.uwm100.cr_2  <> "" ) AND (fi_polmas72 <> "")  THEN RUN proc_assign2.   /*create v72 */
                    END.  /* not avail */
               /* END.  /*else do:*/*/
            END.  /* sicuw.uwm100.expdat >= TODAY */
        END.  /* ELSE DO*/
        END. 
    END.  /* FOR EACH wdetail2 */
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
CREATE wdetail.
ASSIGN 
    wdetail.n_branch = fi_branch
    wdetail.poltyp   = "V72" 
    wdetail.n_rencnt = n_rencnt
    wdetail.n_endcnt = n_endcnt
    wdetail.policyno = substr(wdetail2.prepol,1,2) + "72" + n_yearpol + substr(wdetail2.prepol,7,6)
    wdetail.promotion = nv_promo   /*---A58-0354--*/
    wdetail.occup     = nv_occup   /*   A59-0186  */ 
    wdetail.ins_co   = fi_insurceco 
    wdetail.tiname   = nn_ntitle  
    wdetail.insnam   = nn_name  
    wdetail.n_addr1  = nn_addr1 
    wdetail.n_addr2  = nn_addr2 
    wdetail.n_addr3  = nn_addr3 
    wdetail.n_addr4  = nn_addr4  
    wdetail.benname  = "" 
    wdetail.prepol   = ""  
    wdetail.cr_2     = substr(wdetail2.prepol,1,2) + "70" + n_yearpol + substr(wdetail2.prepol,7,6) 
    wdetail.comment  = ""
    wdetail.subclass = nn_subclass2  
    wdetail.covcod   = "T"     
    wdetail.garage   = ""      
    wdetail.redbook  = nn_redbook     
    wdetail.brand    = nn_brand       
    wdetail.model    = nn_model       
    wdetail.body     = nn_body        
    wdetail.engcc    = nn_engcc       
    wdetail.tonn     = nn_tonn       
    wdetail.seat     = nn_seat         
    wdetail.seat41   = nn_seat41      
    wdetail.cargrp   = nn_cargrp     
    /* wdetail.vehreg   = nn_vehreg     */ /*A56-0327*/
    wdetail.vehreg   = IF trim(wdetail2.licen) = "" THEN nn_vehreg ELSE trim(wdetail2.licen)  /*A56-0327*/
    wdetail.eng      = nn_eng        
    wdetail.chasno   = nn_chasno     
    wdetail.caryear  = nn_caryear    
    wdetail.vehuse   = nn_vehuse 
    wdetail.nv_com1p     = nv_com1p72      
    wdetail.n_taxae      = nv_taxae72      
    wdetail.n_stmpae     = nv_stmpae72     
    wdetail.n_com2ae     = nv_com2ae72     
    wdetail.n_com1ae     = nv_com1ae72     
    wdetail.nv_fi_rstp_t = nv_fi_rstp_t72  
    wdetail.nv_fi_rtax_t = nv_fi_rtax_t72  
    wdetail.comper   = string(nv_comper) 
    wdetail.comacc   = string(nv_comacc)
    wdetail.comp_prm = string(n_comp_prm)  
    wdetail.premt    = string(n_premt)        
    wdetail.comdat   = wdetail2.comdat 
    wdetail.expdat   = wdetail2.expdat 
    wdetail.firstdat = string(nn_firstdat) 
    wdetail.agent    = fi_agent
    wdetail.producer = fi_producer
    wdetail.vatcode  = fi_vatcod
    wdetail.commission = IF trim(wdetail2.commiss72) = "" THEN "0" ELSE trim(wdetail2.commiss72)     /*A57-0193*/ 
    wdetail.entdat   = string(TODAY)                /*entry date*/
    wdetail.enttim   = STRING (TIME, "HH:MM:SS")    /*entry time*/
    wdetail.trandat  = STRING (fi_loaddat)          /*tran date*/
    wdetail.trantim  = STRING (TIME, "HH:MM:SS")    /*tran time*/
    wdetail.n_IMPORT = "IM"
    wdetail.n_EXPORT = "" . 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign70 c-Win 
PROCEDURE proc_assign70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sicuw.uwm100 WHERE sicuw.uwm100.policy = trim(fi_polmas70)  NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL sicuw.uwm100 THEN DO:
    /*IF  (inte(MONTH(date(wdetail.comdat))) + 6 ) > 12    THEN
         ASSIGN wdetail.expdat =  string(DAY(DATE(wdetail.comdat)))   + "/" +
                                 STRING((inte(MONTH(date(wdetail.comdat))) + 6) - 12 ) + "/" +
                                 string(year(DATE(wdetail.comdat))   + 1 ) .
    ELSE ASSIGN wdetail.expdat = string(DAY(DATE(wdetail.comdat)))   + "/" +
                                 STRING((inte(MONTH(date(wdetail.comdat))) + 6)) + "/" +
                                 string(year(DATE(wdetail.comdat))) .
    ASSIGN  wdetail.comdat = "30/04/2010"
     wdetail.expdat = "30/10/2010".*/
    FIND LAST sicuw.uwm120  USE-INDEX uwm12001     WHERE
        sicuw.uwm120.policy = sicuw.uwm100.policy  AND
        sicuw.uwm120.rencnt = sicuw.uwm100.rencnt  AND
        sicuw.uwm120.endcnt = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm120 THEN 
        ASSIGN   /*wdetail.prempa    = ""*/
        nn_subclass    =  sicuw.uwm120.class
        nv_com1p70     =  sicuw.uwm120.com1p 
        nv_taxae70     =  sicuw.uwm120.taxae 
        nv_stmpae70    =  sicuw.uwm120.stmpae
        nv_com2ae70    =  sicuw.uwm120.com2ae
        nv_com1ae70    =  sicuw.uwm120.com1ae 
        nv_fi_rstp_t70 =  sicuw.uwm120.rstp_r 
        nv_fi_rtax_t70 =  sicuw.uwm120.rtax_r    
        nv_promo       =  sicuw.uwm100.opnpol   /*---A58-0354---*/
        nv_occup       =  sicuw.uwm100.occupn.   /*A59-0186 kridtiya i.*/

    FIND LAST sicuw.uwm130  USE-INDEX uwm13001     WHERE
        sicuw.uwm130.policy = sicuw.uwm100.policy  AND
        sicuw.uwm130.rencnt = sicuw.uwm100.rencnt  AND
        sicuw.uwm130.endcnt = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm130 THEN DO:
        ASSIGN 
            n_si     = sicuw.uwm130.uom6_v
            n_tp1    = sicuw.uwm130.uom1_v
            N_tp2    = sicuw.uwm130.uom2_v
            n_tp3    = sicuw.uwm130.uom5_v.
        FIND LAST sicuw.uwm301 USE-INDEX uwm30101      WHERE
            sicuw.uwm301.policy = sicuw.uwm100.policy  AND
            sicuw.uwm301.rencnt = sicuw.uwm100.rencnt  AND
            sicuw.uwm301.endcnt = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm301 THEN DO:
            ASSIGN  nn_access    = sicuw.uwm301.prmtxt
                nn_engcc     = string(sicuw.uwm301.engine)
                nn_tonn      = sicuw.uwm301.tons
                nn_cargrp    = sicuw.uwm301.vehgrp
                nn_vehuse    = sicuw.uwm301.vehuse
                nn_seat      = string(sicuw.uwm301.seats)   
                nn_seat41    = sicuw.uwm301.mv41seat   
                nv_garage    = sicuw.uwm301.garage.  /*--- A58-0354---*/
            FIND LAST  wacctext  WHERE wacctext.n_policytxt =  trim(fi_polmas70)   NO-ERROR NO-WAIT. 
            IF NOT AVAIL wacctext  THEN DO:
                CREATE wacctext.                /*add F6 by pol_master */
                ASSIGN 
                    wacctext.n_policytxt = trim(sicuw.uwm301.policy) 
                    wacctext.n_textacc   = SUBSTRING(sicuw.uwm301.prmtxt,1,60)    
                    wacctext.n_textacc1  = SUBSTRING(sicuw.uwm301.prmtxt,61,60)   
                    wacctext.n_textacc2  = SUBSTRING(sicuw.uwm301.prmtxt,121,60)  
                    wacctext.n_textacc3  = SUBSTRING(sicuw.uwm301.prmtxt,181,60)  
                    wacctext.n_textacc4  = SUBSTRING(sicuw.uwm301.prmtxt,241,60)  
                    wacctext.n_textacc5  = SUBSTRING(sicuw.uwm301.prmtxt,301,60)  
                    wacctext.n_textacc6  = SUBSTRING(sicuw.uwm301.prmtxt,361,60)  
                    wacctext.n_textacc7  = SUBSTRING(sicuw.uwm301.prmtxt,421,60)  
                    wacctext.n_textacc8  = SUBSTRING(sicuw.uwm301.prmtxt,481,60)  
                    wacctext.n_textacc9  = SUBSTRING(sicuw.uwm301.prmtxt,541,60). 
            END.
        END.     /*uwm301*/
    END.         /*uwm130*/
    FOR EACH sicuw.uwd132 WHERE 
        sicuw.uwd132.policy = sicuw.uwm100.policy  AND
        sicuw.uwd132.rencnt = sicuw.uwm100.rencnt  AND
        sicuw.uwd132.endcnt = sicuw.uwm100.endcnt  NO-LOCK  .
        IF sicuw.uwd132.bencod      = "base"  THEN ASSIGN nv_baseprm = DECIMAL(SUBSTRING(sicuw.uwd132.benvar,31,30)). 
        ELSE IF sicuw.uwd132.bencod = "PD"    THEN dpd0              = DECIMAL(SUBSTRING(sicuw.uwd132.benvar,31,30)). 
        ELSE IF sicuw.uwd132.bencod = "411"   THEN ASSIGN nv_41      = deci(SUBSTRING(sicuw.uwd132.benvar,31,30)).  
        ELSE IF sicuw.uwd132.bencod = "42"    THEN ASSIGN nv_42      = deci(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        ELSE IF sicuw.uwd132.bencod = "43"    THEN ASSIGN nv_43      = deci(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        ELSE IF sicuw.uwd132.bencod = "dod"   THEN ASSIGN dod1       = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        ELSE IF sicuw.uwd132.bencod = "dod2"  THEN ASSIGN dod2       = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        ELSE IF sicuw.uwd132.bencod = "dpd"   THEN ASSIGN dpd0       = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        ELSE IF sicuw.uwd132.bencod = "flet"  THEN ASSIGN nv_flet    = deci(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        ELSE IF sicuw.uwd132.bencod = "ncb"   THEN ASSIGN nv_NCB     = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        ELSE IF sicuw.uwd132.bencod = "dspc"  THEN ASSIGN nv_dss_per = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        ELSE IF sicuw.uwd132.bencod = "dstf"  THEN ASSIGN nv_stf_per = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
        ELSE IF index(sicuw.uwd132.bencod,"cl") <> 0 THEN ASSIGN  nv_cl_per = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
    END.
    /*ASSIGN nv_NCB     = 50
    nv_dss_per = 10.78
    nv_stf_per = 18. */
END.
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
FIND LAST sicuw.uwm100 WHERE sicuw.uwm100.policy = trim(fi_polmas72) NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL sicuw.uwm100 THEN DO:
    /*IF  (inte(MONTH(date(wdetail.comdat))) + 6 ) > 12    THEN
        ASSIGN wdetail.expdat =  string(DAY(DATE(wdetail.comdat)))   + "/" +
                                 STRING((inte(MONTH(date(wdetail.comdat))) + 6) - 12 ) + "/" +
                                 string(year(DATE(wdetail.comdat))   + 1 ) .
    ELSE ASSIGN wdetail.expdat = string(DAY(DATE(wdetail.comdat)))   + "/" +
                                 STRING((inte(MONTH(date(wdetail.comdat))) + 6)) + "/" +
                                 string(year(DATE(wdetail.comdat))) .*/
    /*ASSIGN wdetail.comdat = "30/04/2010"
     wdetail.expdat = "30/10/2010".*/
    FIND LAST sicuw.uwm120  USE-INDEX uwm12001     WHERE
        sicuw.uwm120.policy = sicuw.uwm100.policy  AND
        sicuw.uwm120.rencnt = sicuw.uwm100.rencnt  AND
        sicuw.uwm120.endcnt = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm120 THEN 
        ASSIGN nn_subclass2   =  sicuw.uwm120.class
        nv_com1p72     =  sicuw.uwm120.com1p 
        nv_taxae72     =  sicuw.uwm120.taxae 
        nv_stmpae72    =  sicuw.uwm120.stmpae
        nv_com2ae72    =  sicuw.uwm120.com2ae
        nv_com1ae72    =  sicuw.uwm120.com1ae 
        nv_fi_rstp_t72 =  sicuw.uwm120.rstp_r 
        nv_fi_rtax_t72 =  sicuw.uwm120.rtax_r 
        nv_promo       =  sicuw.uwm100.opnpol      /*---A58-0354         ---*/
        nv_occup       =  sicuw.uwm100.occupn  .   /*---A59-0186 kridtiya i.*/
    FIND LAST sicuw.uwm130  USE-INDEX uwm13001     WHERE
        sicuw.uwm130.policy = sicuw.uwm100.policy  AND
        sicuw.uwm130.rencnt = sicuw.uwm100.rencnt  AND
        sicuw.uwm130.endcnt = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm130 THEN
        ASSIGN nv_comper = sicuw.uwm130.uom8_v
        nv_comacc = sicuw.uwm130.uom9_v.
    FOR EACH sicuw.uwd132 WHERE 
        sicuw.uwd132.policy = sicuw.uwm100.policy  AND
        sicuw.uwd132.rencnt = sicuw.uwm100.rencnt  AND
        sicuw.uwd132.endcnt = sicuw.uwm100.endcnt  NO-LOCK  .
        IF sicuw.uwd132.bencod = "comp" THEN 
            ASSIGN 
            n_comp_prm    = sicuw.uwd132.gap_c
            n_premt       = sicuw.uwd132.prem_c.
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
DEF VAR nseats AS INTE INIT 0.
DEF VAR nclas2 AS CHAR INIT "".
DEF VAR nre_premt AS DECI INIT 0.
ASSIGN  nn_cr2       = ""
    /*nn_subclass  = ""*/
    nn_covcod    = ""
    nn_garage    = ""  
    nn_redbook   = ""
    nn_brand     = ""
    nn_model     = ""
    nn_body      = ""
    /* nn_engcc     = ""
    nn_tonn      = 0*/
    /* nn_seat      = ""
    nn_seat41    = 0*/
    /*   nn_cargrp    = ""*/
    nn_vehreg    = ""
    nn_eng       = ""
    nn_chasno    = ""
    nn_caryear   = ""
    /*nn_vehuse    = ""*/
    nn_comdat    = ?
    nn_firstdat  = ?.
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwsaexp (INPUT-OUTPUT  wdetail2.prepol, /*0. n_prepol      */  
                      INPUT-OUTPUT  nn_cr2,          
                      INPUT-OUTPUT  nclas2,          /*1. n_subclass    */  
                      INPUT-OUTPUT  nn_covcod,       /*2. n_covcod      */  
                      INPUT-OUTPUT  nn_garage,       /*3. n_garage      */                       
                      INPUT-OUTPUT  nn_redbook,      /*4. n_redbook     */  
                      INPUT-OUTPUT  nn_brand,        /*5. n_brand       */  
                      INPUT-OUTPUT  nn_model,        /*6. n_model       */  
                      INPUT-OUTPUT  nn_body,         /*7. body          */  
                      INPUT-OUTPUT  nseats,          /*8. engine cc     */  
                      INPUT-OUTPUT  nseats,          /*9. tonnage       */  
                      INPUT-OUTPUT  nseats,          /*10.n_seat  nn_seat */ 
                      INPUT-OUTPUT  nseats,          /*11.n_seat  nn_seat */ 
                      INPUT-OUTPUT  nseats  ,        /*12.Veh.group.    */  
                      INPUT-OUTPUT  nn_vehreg,       /*13.Registration  */  
                      INPUT-OUTPUT  nn_eng,          /*14.engine no     */  
                      INPUT-OUTPUT  nn_chasno,       /*15.n_seat        */ 
                      INPUT-OUTPUT  nn_caryear,      /*16.n_caryear     */  
                      INPUT-OUTPUT  nclas2,          /*17.n_vehuse      */ 
                      INPUT-OUTPUT  nn_comdat,       /*18.n_seat        */ 
                      INPUT-OUTPUT  nn_firstdat,     /*19.n_firstdat    */
                      INPUT-OUTPUT  nre_premt).      /*A64-0138*/  
    ASSIGN wdetail.premt = string(nre_premt).

END.  
/*ASSIGN wdetail.engcc  = "2700"
       wdetail.tonn   =  3.20 
       wdetail.seat   = "16". */
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
    IF nv_baseprm = 0  Then RUN wgs\wgsfbas.
    /*IF wdetail.prepol <> "" THEN  nv_baseprm = nv_basere.*/
    
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
            ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN  nv_drivvar = ""
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
    /*IF wdetail.prepol <> "" THEN  ASSIGN  nv_41 = n_41  /*ต่ออายุ*/
                                          nv_42 = n_42
                                          nv_43 = n_43 .*/
    ASSIGN 
        /*nv_41 = 200000  /*deci(wdetail.no_41)*/ 
        nv_42 = 200000         /*deci(wdetail.no_42)*/
        nv_43 = 200000    /*deci(wdetail.no_43)*/       
        wdetail.seat = "16"
        nv_seats = 16*/
        nv_seat41 =  wdetail.seat41  
        nv_class  =  wdetail.subclass .
    /* comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                    nv_class,
                    nv_key_b,
                    nv_comdat). */
    Assign  nv_411var = ""      nv_412var = ""   
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
    /* comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat). */     /*  RUN US\USOPER(INPUT nv_tariff,*/  
    /*------nv_usecod------------*/
    ASSIGN nv_usevar = ""
        nv_usecod    = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1   = "     Vehicle Use = "
        nv_usevar2   =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30) = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  SUBSTR(wdetail.subclass,2,3). 
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
    Assign  nv_sivar = ""
        nv_totsi     = 0
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
         nv_bipvar2     =  wdetail.tp1    /*STRING(uwm130.uom1_v)*/
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign nv_biavar = ""
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     =  wdetail.tp2     /* STRING(uwm130.uom2_v)*/
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN nv_pdavar = ""
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         nv_pdavar2     =  wdetail.tp3         /*STRING(uwm130.uom5_v)*/
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
     /* caculate deduct OD  */
     /*DEF VAR dod0 AS INTEGER.
     DEF VAR dod1 AS INTEGER.
     DEF VAR dod2 AS INTEGER.
     DEF VAR dpd0 AS INTEGER.*/
     /*def  var  nv_chk  as  logic.*/
      /*IF dod0 > 3000 THEN DO:
          dod1 = 3000.
          dod2 = dod0 - dod1.
      END.*/
     IF dod1 <> 0  THEN DO:
        ASSIGN  /*dod1 = dod1 * ( -1 )
            dod2     = dod2 * ( -1 )
            dod0     = dod0 * ( -1 )*/
            nv_dedod1var = ""
            nv_odcod     = "DC01"
            nv_prem      = dod1.        
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
            SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
        /*add od*/
        IF dod2 <> 0 THEN 
            Assign  
                nv_dedod2var   = " "
                nv_cons  = "AD"
                nv_ded   = dod2.
          /* comment by : A64-0138..
            Run  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */
                              nv_tariff,
                              nv_class,
                              nv_key_b,
                              nv_comdat,
                              nv_cons,
                              OUTPUT nv_prem).*/
            Assign
                nv_aded1prm     = nv_prem
                nv_dedod2_cod   = "DOD2"
                nv_dedod2var1   = "     Add Ded.OD = "
                nv_dedod2var2   =  STRING(dod2)
                SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
                SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2 .
            /*nv_dedod2_prm   = nv_prem.*/ /*A64-0138*/
     END.
      /***** pd *******/
     IF dpd0 <> 0 THEN
      Assign
          nv_dedpdvar  = " "
          nv_cons  = "PD"
          nv_ded   = dpd0.
      /* comment by : A64-0138..
        Run  Wgs\Wgsmx025(INPUT  dod0, /*a490166 note modi*/
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).
           nv_ded2prm    = nv_prem.
      ...end : A64-0138..*/

       ASSIGN
         nv_dedpd_cod   = "DPD"
         nv_dedpdvar1   = "     Deduct PD = "
         nv_dedpdvar2   =  STRING(dod0)
         SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
         SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
         /*nv_dedpd_prm  = nv_prem.*/ /*A64-0138*/
      /*---------- fleet -------------------*/
      nv_flet_per = INTE(wdetail.fleet).
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
      ELSE 
      ASSIGN
          nv_fletvar                  = " "
          nv_fletvar1                 = "     Fleet % = "
          nv_fletvar2                 =  STRING(nv_flet_per)
          SUBSTRING(nv_fletvar,1,30)  = nv_fletvar1
          SUBSTRING(nv_fletvar,31,30) = nv_fletvar2.
      IF nv_flet   = 0  THEN nv_fletvar  = " ".
      /*---------------- NCB -------------------*/
      /*IF wdetail.covcod = "3" THEN WDETAIL.NCB = "30".*/
      ASSIGN 
          NV_NCBPER  = INTE(WDETAIL.NCB)
          nv_ncb     = INTE(WDETAIL.NCB)
          nv_ncbvar = " ".
      If nv_ncbper  <> 0 Then do:
          Find first sicsyac.xmm104 Use-index xmm10401 Where
              sicsyac.xmm104.tariff = nv_tariff             AND
              sicsyac.xmm104.class  = nv_class              AND 
              sicsyac.xmm104.covcod = nv_covcod             AND 
              sicsyac.xmm104.ncbper = INTE(wdetail.ncb)
              No-lock no-error no-wait.
          IF not avail  sicsyac.xmm104  Then do:
              MESSAGE wdetail.policy nv_tariff    
                  nv_class          
                  nv_covcod         
                  INTE(wdetail.ncb)  VIEW-AS ALERT-BOX.
              Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
              ASSIGN
                  wdetail.pass    = "N"
                  wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
          END.
          ELSE ASSIGN
              nv_ncbper = xmm104.ncbper   
              nv_ncbyrs = xmm104.ncbyrs.
      END.
      Else do:  
          Assign
              nv_ncbyrs  =   0
              nv_ncbper  =   0
              nv_ncb     =   0.
      END.
      /* comment by : A64-0138..
      RUN WGS\WGSORPRM.P (INPUT nv_tariff, /*pass*/
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
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     /*-------------- load claim ---------------------*/
     /*nv_cl_per  = deci(wdetail.loadclm).*/
     nv_clmvar  = " ".
     IF nv_cl_per  <> 0  THEN
      Assign 
             nv_clmvar1   = " Load Claim % = "
             nv_clmvar2   =  STRING(nv_cl_per)
             SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
             SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
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
 
     /*------------------ dsspc ---------------*/
     IF  nv_dss_per   <> 0  THEN
         Assign
         nv_dsspcvar1   = "     Discount Special % = "
         nv_dsspcvar2   =  STRING(nv_dss_per)
         SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
         SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
     /*--------------------------*/
     /* comment by : A64-0138..
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v ,       
                         nv_uom2_v ,       
                         nv_uom5_v ).*/ 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base22 c-Win 
PROCEDURE proc_base22 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0138..
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "v70" THEN DO:
    IF nv_baseprm = 0 THEN  RUN wgs\wgsfbas.
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
            ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN  nv_drivvar = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
        /*RUN proc_usdcod. */
    END.
    /*-------nv_baseprm----------*/
    IF NO_basemsg <> " " THEN  wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN  
        nv_prem1    = nv_baseprm
        nv_basecod  = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    ASSIGN 
        nv_seats  =  deci(wdetail.seat) 
        nv_seat41 =  deci(wdetail.seat41)   .
    IF nv_41 <> 200000 THEN ASSIGN nv_41 = 200000
        nv_42 = 200000
        nv_43 = 200000
        nv_seats  = 16
        nv_seat41 = 16.
    
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
        nv_412prm  = nv_41
        nv_42var    = " "     /* -------fi_42---------*/
        /* Assign*/
        nv_42cod   = "42"
        nv_42var1  = "     Medical Expense = "
        nv_42var2  = STRING(nv_42)
        SUBSTRING(nv_42var,1,30)   = nv_42var1
        SUBSTRING(nv_42var,31,30)  = nv_42var2
        nv_43var    = " "    /*---------fi_43--------*/
    /*Assign*/
        nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    RUN WGS\WGSOPER(INPUT nv_tariff,   
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
    ASSIGN nv_sclass = substr(wdetail.subclass,2,3). 
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
        nv_totsi   = 0
        nv_sicod   = "SI"
        nv_sivar1  = "     Own Damage = "
        nv_sivar2  = wdetail.si
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
        nv_bipvar2     =  wdetail.tp1    /*STRING(uwm130.uom1_v)*/
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    Assign 
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     =  wdetail.tp2     /* STRING(uwm130.uom2_v)*/
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*-------------nv_pdacod--------------------*/
    Assign
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     =  wdetail.tp3         /*STRING(uwm130.uom5_v)*/
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    /*--------------- deduct ----------------*/
    /* caculate deduct OD  */
    /*DEF VAR dod0 AS INTEGER.
    DEF VAR dod1 AS INTEGER.
    DEF VAR dod2 AS INTEGER.
    DEF VAR dpd0 AS INTEGER.*/
    /*def  var  nv_chk  as  logic.*/
    /*IF dod0 > 3000 THEN DO:
    dod1 = 3000.
    dod2 = dod0 - dod1.
    END.*/
    /*ASSIGN  dod1 = dod1 * ( -1 )
    dod2     = dod2 * ( -1 )
    dod0     = dod0 * ( -1 )*/
      dod0 =  0 /* inte(wdetail.deductda)*/   .
      IF dod0 > 3000 THEN DO:
          dod1 = 3000.
          dod2 = dod0 - dod1.
      END.
          ASSIGN
             
             nv_odcod    = "DC01"
             nv_prem     =   dod1.
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
    ASSIGN nv_ded1prm  = nv_prem
        nv_dedod1_prm  = nv_prem
        nv_dedod1_cod  = "DOD"
        nv_dedod1var1  = "     Deduct OD = "
        nv_dedod1var2  = STRING(dod1)
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
        nv_cons  = "PD"  .
    Run  Wgs\Wgsmx025(INPUT  dod0,        /*a490166 note modi*/
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
    nv_flet_per = INTE(wdetail.fleet).
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
            sicsyac.xmm104.ncbper = INTE(wdetail.ncb)
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
    /*nv_cl_per  = deci(wdetail.loadclm).*/
    nv_clmvar  = " ".
    IF nv_cl_per  <> 0  THEN
        Assign 
        nv_clmvar1   = " Load Claim % = "
        nv_clmvar2   =  STRING(nv_cl_per)
        SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
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
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
    /*------------------ dsspc ---------------*/
    ASSIGN 
        nv_dsspcvar   = " "
        n_prem = deci(wdetail.premt)
        n_prem = TRUNCATE(((n_prem * 100 ) / 107.43),0).
    /*nv_dss_per = ((nv_gapprm - n_prem ) * 100 ) / nv_gapprm . */
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                               nv_class,
                               nv_covcod,
                               nv_key_b,
                               nv_comdat,
                               nv_totsi,
                               nv_uom1_v,       
                               nv_uom2_v,       
                               nv_uom5_v). 
    IF wdetail.prepol = "" THEN DO :
        nv_dss_per   = 0.
        IF nv_gapprm <> n_prem THEN  
            nv_dss_per = TRUNCATE(((nv_gapprm - n_prem ) * 100 ) / nv_gapprm ,3 ) . 
    END.
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
...end A64-0138...*/
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
         nv_uom7_c  = "" .

    ASSIGN               
         nv_covcod  = wdetail.covcod                                              
         nv_class   = trim(wdetail.subclass)                                         
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
         nv_seat41  = nv_seat41   
         nv_dedod   = DOD1       
         nv_addod   = DOD2                                
         nv_dedpd   = DPD0                                     
         nv_ncbp    = deci(wdetail.ncb)                                     
         nv_fletp   = deci(wdetail.fleet)                                  
         nv_dspcp   = nv_dss_per                                      
         nv_dstfp   = 0                                                     
         nv_clmp    = nv_cl_per  
         /*nv_netprem  = TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) + 
                        (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )*/
         nv_netprem  = DECI(wdetail.premt) /* เบี้ยสุทธิ */                                                
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

        IF wdetail.redbook <> ""  THEN ASSIGN sic_bran.uwm301.modcod = wdetail.redbook .
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
    " nv_netprem       "  nv_netprem    skip  
    " nv_gapprm        "  nv_gapprem    skip  
    " nv_flagprm       "  nv_flagprm    skip  
    " wdetail.comdat   "  nv_effdat     skip 
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.     
*/ 
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
                       INPUT-OUTPUT nv_pdprem,   /* nv_pdprem   */
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
                       OUTPUT nv_status, 
                       OUTPUT nv_message ). 

    /*IF nv_gapprm <> DECI(wdetail.premt) THEN DO:*/
    IF nv_status = "no" THEN DO:
        /*/*comment by Kridtiya i. A65-0035*/ 
        MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt +
            nv_message VIEW-AS ALERT-BOX.
         ASSIGN wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
                wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt.
                wdetail.pass     = "Y"   
                wdetail.OK_GEN  = "N".*/  /*comment by Kridtiya i. A65-0035*/ 
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN  wdetail.comment = wdetail.comment + "|" + nv_message   /*  by Kridtiya i. A65-0035*/  
                wdetail.WARNING = wdetail.WARNING + "|" + nv_message . /*  by Kridtiya i. A65-0035*/
    END.
    /*  by Kridtiya i. A65-0035*/
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate(input DATE(wdetail.comdat),
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
    
 
 /*IF wdetail.n_delercode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.n_delercode) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Dealer " + wdetail.n_delercode + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code Dealer " + wdetail.n_delercode + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
                wdetail.pass    = "N" 
                wdetail.OK_GEN  = "N".
     END.
 END.
 IF wdetail.fincode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.fincode) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Finance " + wdetail.fincode + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
      IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
       ASSIGN wdetail.comment = wdetail.comment + "| Code Finance " + wdetail.fincode + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
              wdetail.pass    = "N" 
              wdetail.OK_GEN  = "N".
     END.
 END.
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
ASSIGN fi_process = "Check Data File Siam Carrent Group.." + wdetail.policyno.
DISP fi_process   WITH FRAM fr_main.
IF wdetail.vehreg = " " AND wdetail.prepol  = " " THEN DO: 
    ASSIGN wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass       = "N"   
        wdetail.OK_GEN     = "N". 
END.
ELSE DO:
    Def  var  nv_vehreg  as char  init  " ".
    Def  var  s_polno    like sicuw.uwm100.policy   init " ".
    Find LAST sicuw.uwm301 Use-index uwm30102 Where  
        sicuw.uwm301.vehreg = wdetail.vehreg  No-lock no-error no-wait.
    IF AVAIL sicuw.uwm301 THEN DO:
        If  sicuw.uwm301.policy =  wdetail.policyno     and          
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
    END.    /*avil 301*/
END.         /*note end else*/   /*end note vehreg*/
IF wdetail.cancel = "ca"  THEN  
    ASSIGN wdetail.pass = "N"  
    wdetail.comment     = wdetail.comment + "| cancel"
    wdetail.OK_GEN      = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass        = "N"     
    wdetail.OK_GEN      = "N".
/*IF wdetail.drivnam = "y" AND wdetail.drivername1 =  " "   THEN 
ASSIGN
        wdetail.comment = wdetail.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
        wdetail.pass    = "N" 
        wdetail.OK_GEN  = "N".*/
/*IF wdetail.prempa = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".*/
IF wdetail.subclass = " " THEN DO:
    ASSIGN wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
           wdetail.pass    = "N"  
           wdetail.OK_GEN  = "N".
END.   /*can't block in use*/ 
IF wdetail.brand = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
           wdetail.pass    = "N"        
           wdetail.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
           wdetail.pass    = "N"   
           wdetail.OK_GEN  = "N".
/*IF wdetail.engcc    = " " THEN 
ASSIGN
wdetail.comment = wdetail.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
wdetail.pass    = "N"     
wdetail.OK_GEN  = "N".*/
IF wdetail.seat  = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
ASSIGN  
    NO_CLASS  = wdetail.subclass 
    nv_poltyp = wdetail.poltyp.
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
        ASSIGN  wdetail.comment = wdetail.comment + "| Not on Business class on xmm016"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".
    ELSE 
        ASSIGN  wdetail.tariff =   sicsyac.xmm016.tardef
            no_class       =   sicsyac.xmm016.class
            nv_sclass      =   Substr(no_class,2,3).
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
nv_sclass = wdetail.subclass . 
If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
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
    IF  wdetail.policyno = ""  THEN NEXT.
    ASSIGN fi_process    = "Check Data File Siam Carrent Group.." + wdetail.policyno .
    DISP fi_process WITH FRAM fr_main.
    /*------------------  renew ---------------------*/
    IF ra_typepol = 2 THEN
        ASSIGN 
        wdetail.n_rencnt = 0
        wdetail.n_endcnt = 0
        wdetail.pass     = "Y".
    /*IF  (inte(MONTH(date(wdetail.comdat))) + 6 ) > 12    THEN
        ASSIGN wdetail.expdat =  string(DAY(DATE(wdetail.comdat)))   + "/" +
                                 STRING((inte(MONTH(date(wdetail.comdat))) + 6) - 12 ) + "/" +
                                 string(year(DATE(wdetail.comdat))   + 1 ) .
    ELSE ASSIGN wdetail.expdat = string(DAY(DATE(wdetail.comdat)))   + "/" +
                                 STRING((inte(MONTH(date(wdetail.comdat))) + 6)) + "/" +
                                 string(year(DATE(wdetail.comdat))) .*/

    RUN proc_susspect. /*Add by Kridtiya i. A63-0472*/
    RUN proc_chkcode . /*A64-0138*/
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
    ELSE DO:  /* V70 */
        RUN proc_chktest0.
    END.
    RUN proc_policy . 
    RUN proc_chktest2.      
    RUN proc_chktest3.      
    RUN proc_chktest4. 
END.      /*for each*/
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
ASSIGN fi_process = "Create Data uwm130  File Siam Carrent Group.." + wdetail.policyno.
DISP fi_process   WITH FRAM fr_main.
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
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno
        sic_bran.uwm130.bchyr  = nv_batchyr    /* batch Year */
        sic_bran.uwm130.bchno  = nv_batchno    /* bchno      */
        sic_bran.uwm130.bchcnt = nv_batcnt     /* bchcnt     */
        nv_sclass              = wdetail.subclass.
    IF nv_uom6_u  =  "A"  THEN DO:
        IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
            nv_sclass  =  "520"  Or  nv_sclass  =  "540"  Then  nv_uom6_u  =  "A".         
        Else 
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
    END.
    IF  CAPS(nv_uom6_u)   = "A"  Then
        Assign  nv_uom6_u          = "A"
        nv_othcod                  = "OTH"
        nv_othvar1                 = "     Accessory  = "
        nv_othvar2                 =  STRING(nv_uom6_u)
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    ELSE                           
        ASSIGN  nv_uom6_u          = ""
            nv_othcod              = ""
            nv_othvar1             = ""
            nv_othvar2             = ""
            SUBSTRING(nv_othvar,1,30)  = nv_othvar1
            SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN 
        ASSIGN
        sic_bran.uwm130.uom1_v   = deci(wdetail.tp1)  
        sic_bran.uwm130.uom2_v   = deci(wdetail.tp2)  
        sic_bran.uwm130.uom5_v   = deci(wdetail.tp3) 
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
        sic_bran.uwm130.uom1_v   =   deci(wdetail.tp1)  
        sic_bran.uwm130.uom2_v   =   deci(wdetail.tp2)  
        sic_bran.uwm130.uom5_v   =   deci(wdetail.tp3)  
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = wdetail.subclass And
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do:
        Assign 
            sic_bran.uwm130.uom1_v     =  deci(wdetail.tp1)     /*stat.clastab_fil.uom1_si   1000000  */  
            sic_bran.uwm130.uom2_v     =  deci(wdetail.tp2)     /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     =  deci(wdetail.tp3)     /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  =  deci(wdetail.tp1)     /*deci(wdetail2.tp_bi)   */ 
            nv_uom2_v                  =  deci(wdetail.tp2)     /*deci(wdetail2.tp_bi2) */  
            nv_uom5_v                  =  deci(wdetail.tp3)     /*deci(wdetail2.tp_bi3) */  
            wdetail.deductpd           =  string(sic_bran.uwm130.uom5_v)
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
        /*If  wdetail.garage  =  ""  Then
            Assign nv_41      =   stat.clastab_fil.si_41unp
                   nv_42      =   stat.clastab_fil.si_42
                   nv_43      =   stat.clastab_fil.si_43
                   nv_seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
        Else If  wdetail.garage  =  "G"  Then
            Assign nv_41       =  stat.clastab_fil.si_41pai
                   nv_42       =  stat.clastab_fil.si_42
                   nv_43       =  stat.clastab_fil.impsi_43
                   nv_seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41. */  
    END.
    ASSIGN  nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                                nv_riskno,
                                nv_itemno).
END.    /* end Do transaction*/
ASSIGN 
    s_recid3  = RECID(sic_bran.uwm130)
    nv_covcod =   wdetail.covcod
    nv_newsck = " ".
RUN proc_chassic.
IF SUBSTRING(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
ELSE nv_newsck =  wdetail.stk.
FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
    sic_bran.uwm301.policy = sic_bran.uwm100.policy  AND
    sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt  AND
    sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt  AND
    sic_bran.uwm301.riskgp = s_riskgp                AND
    sic_bran.uwm301.riskno = s_riskno                AND
    sic_bran.uwm301.itemno = s_itemno                AND
    sic_bran.uwm301.bchyr  = nv_batchyr              AND 
    sic_bran.uwm301.bchno  = nv_batchno              AND 
    sic_bran.uwm301.bchcnt = nv_batcnt         NO-WAIT NO-ERROR.
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
        sic_bran.uwm301.Tons      = DECI(wdetail.Tonn)
        sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
        sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage    = wdetail.garage
        sic_bran.uwm301.body      = wdetail.body
        sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv41seat  = wdetail.seat41
        sic_bran.uwm301.mv_ben83  = wdetail.benname
        sic_bran.uwm301.vehreg    = wdetail.vehreg 
        sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse    = wdetail.vehuse
        sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
        sic_bran.uwm301.modcod    = wdetail.redbook                                    
        sic_bran.uwm301.vehgrp    = wdetail.cargrp
        sic_bran.uwm301.sckno     = 0
        sic_bran.uwm301.itmdel    = NO
        /*sic_bran.uwm301.prmtxt    = nn_access*/ /*A56-0151*/
        wdetail.tariff            = sic_bran.uwm301.tariff.
IF      ra_textf6 = 1 THEN nn_polf6  = TRIM(fi_polmas70).   
ELSE IF ra_textf6 = 2 THEN nn_polf6  = wdetail.prepol   .
ELSE nn_polf6  = "".
IF nn_polf6    = "" THEN sic_bran.uwm301.prmtxt = "" .
ELSE DO:
    FIND FIRST wacctext WHERE wacctext.n_policytxt = nn_polf6  NO-LOCK NO-ERROR NO-WAIT.
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
END.
IF wdetail.compul = "y" THEN DO:
    sic_bran.uwm301.cert = "".
    IF LENGTH(wdetail.stk) = 11  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
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
    sic_bran.uwm301.bchyr  = nv_batchyr   /* batch Year */
    sic_bran.uwm301.bchno  = nv_batchno   /* bchno      */
    sic_bran.uwm301.bchcnt = nv_batcnt .  /* bchcnt     */
s_recid4         = RECID(sic_bran.uwm301).
    
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
    nv_class  = wdetail.subclass 
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
    /*nv_ncb       =   0*/                                  
    nv_totsi     = 0 
    fi_process = "Create Data  baseprm  File Siam Carrent Group.." + wdetail.policyno.
DISP fi_process   WITH FRAM fr_main.
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
                nv_compcod    = "COMP"
                nv_compvar1   = "     Compulsory  =   "
                nv_compvar2   = STRING(nv_comacc)
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
RUN proc_base2.
IF wdetail.poltyp = "v72" THEN DO:
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
        /*nv_class = SUBSTRING(nv_class,2,3)*/   .
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
/* Add by : A64-0138 */
IF wdetail.prepol <> ""  THEN DO:
    RUN proc_calpremt.
    RUN proc_adduwd132prem.
END.
ELSE DO:
    FOR EACH sicuw.uwd132 WHERE 
        sicuw.uwd132.policy = fi_polmas70   NO-LOCK  .
        FIND LAST  sic_bran.uwd132  USE-INDEX uwd13201  WHERE    /*a490116 note change index from uwd13290 to uwd13201*/
            sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
            sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
            sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
            sic_bran.uwd132.bencod  = sicuw.uwd132.bencod     AND 
            sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
            sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
            sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
            sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
            sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  NO-ERROR    .
        IF AVAIL sic_bran.uwd132 THEN DO:
            ASSIGN  
                sic_bran.uwd132.bencod   = sicuw.uwd132.bencod   
                sic_bran.uwd132.benvar   = sicuw.uwd132.benvar
                sic_bran.uwd132.gap_c    = sicuw.uwd132.gap_c   
                sic_bran.uwd132.prem_c   = sicuw.uwd132.prem_c .
            nv_gapprm = nv_gapprm + sicuw.uwd132.gap_c .
            nv_pdprm  = nv_pdprm  + sicuw.uwd132.prem_C.
        END.
    END.

END.
/* end A64-0138 */

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
  /*  sic_bran.uwm301.ncbper   = nv_ncbper  /* A64-0138*/    
    sic_bran.uwm301.ncbyrs   = nv_ncbyrs*/  /* A64-0138*/    
    sic_bran.uwm301.mv41seat = wdetail.seat41.

/* comment by : A64-0138..
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).
/*MESSAGE 
    sic_bran.uwm130.policy SKIP
    sic_bran.uwm130.rencnt SKIP
    sic_bran.uwm130.endcnt VIEW-AS ALERT-BOX.*/
FOR EACH sicuw.uwd132 WHERE 
    sicuw.uwd132.policy = fi_polmas70   NO-LOCK  .
    FIND LAST  sic_bran.uwd132  USE-INDEX uwd13201  WHERE    /*a490116 note change index from uwd13290 to uwd13201*/
        sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
        sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
        sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
        sic_bran.uwd132.bencod  = sicuw.uwd132.bencod     AND 
        sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
        sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
        sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
        sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
        sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  NO-ERROR    .
    IF AVAIL sic_bran.uwd132 THEN DO:
        ASSIGN  
            sic_bran.uwd132.bencod   = sicuw.uwd132.bencod   
            sic_bran.uwd132.benvar   = sicuw.uwd132.benvar
            sic_bran.uwd132.gap_c    = sicuw.uwd132.gap_c   
            sic_bran.uwd132.prem_c   = sicuw.uwd132.prem_c .
        /*MESSAGE "AVAIL"
        sic_bran.uwd132.policy  SKIP 
        sic_bran.uwd132.rencnt  SKIP 
        sic_bran.uwd132.endcnt  SKIP 
        sic_bran.uwd132.bencod  SKIP 
        sic_bran.uwd132.riskno  SKIP 
        sic_bran.uwd132.itemno  SKIP 
        sic_bran.uwd132.bchyr   SKIP 
        sic_bran.uwd132.bchno   SKIP 
        sic_bran.uwd132.bchcnt  SKIP 
        sic_bran.uwd132.bencod   ":"  sicuw.uwd132.bencod   SKIP                
        sic_bran.uwd132.benvar   ":"  sicuw.uwd132.benvar   SKIP                
        sic_bran.uwd132.gap_c   ":"   sicuw.uwd132.gap_c    SKIP                
        sic_bran.uwd132.prem_c  ":"   sicuw.uwd132.prem_c   VIEW-AS ALERT-BOX. */
    END.
END.
...end A64-0138..*/
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
ASSIGN fi_process = "Updat to uwm120 stamp tax com % ..." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
If  not avail sic_bran.uwm100  Then do:
    /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
    Return.
END.
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
                sic_bran.uwd132.bchyr   = nv_batchyr              AND 
                sic_bran.uwd132.bchno   = nv_batchno              AND 
                sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.
                IF  sic_bran.uwd132.bencod  = "COMP"   THEN nt_compprm     = nt_compprm + sic_bran.uwd132.prem_c.
                n_gap_r  = sic_bran.uwd132.gap_c  + n_gap_r.
                n_prem_r = sic_bran.uwd132.prem_c + n_prem_r.
            END.    /* uwd132 */
        END.        /*uwm130 */
        ASSIGN
            n_gap_t      = n_gap_t   + n_gap_r
            n_prem_t     = n_prem_t  + n_prem_r
            n_sigr_t     = n_sigr_t  + n_sigr_r
            n_gap_r      = 0 
            n_prem_r     = 0  
            n_sigr_r     = 0.
    END.    /* end uwm120 */
END.        /*  avail  100   */
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
        sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp   No-lock no-error no-wait.
    IF not  avail sicsyac.xmm031 Then 
        Assign     nv_com1p = 0
                   nv_com2p = 0.
    Else  
        Assign     nv_com1p = sicsyac.xmm031.comm1
                   nv_com2p = 0 .
END.
/***--- Commmission Rate Line 72 ---***/
IF wdetail.compul = "y" THEN  
    ASSIGN nv_com2p = 0
        nv_com2p = DECI(wdetail.commission) .
/*--------- tax -----------*/
Find sicsyac.xmm020 Use-index xmm02001        Where
    sicsyac.xmm020.branch = sic_bran.uwm100.branch   And
    sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri   No-lock no-error.
IF avail sicsyac.xmm020 Then do:
    nv_fi_stamp_per      = sicsyac.xmm020.rvstam.
    If    sic_bran.uwm100.gstrat  <>  0  Then  nv_fi_tax_per  =  sic_bran.uwm100.gstrat.
    Else  nv_fi_tax_per  =  sicsyac.xmm020.rvtax.
END.
/*----------- stamp ------------*/
IF sic_bran.uwm120.stmpae  = Yes Then do: 
    /* STAMP */ 
    nv_fi_rstp_t  = Truncate(sic_bran.uwm120.prem_r * nv_fi_stamp_per / 100,0) +
        (IF     (sic_bran.uwm120.prem_r * nv_fi_stamp_per / 100)   -
         Truncate(sic_bran.uwm120.prem_r  * nv_fi_stamp_per / 100,0) > 0
         Then 1 Else 0).
END.
  sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
  
IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
    nv_fi_rtax_t  = (sic_bran.uwm120.prem_r + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                    * nv_fi_tax_per  / 100.
     /* MESSAGE "sic_bran.uwm120.prem_r  "  sic_bran.uwm120.prem_r
              "nv_fi_rstp_t + "          nv_fi_rstp_t         
              "sic_bran.uwm100.pstp  "    sic_bran.uwm100.pstp  
              "nv_fi_tax_per  "          nv_fi_tax_per     VIEW-AS ALERT-BOX.    */
       /* fi_taxae       = Yes.*/
END.
sic_bran.uwm100.rtax_t = nv_fi_rtax_t.
sic_bran.uwm120.com1ae = YES.
sic_bran.uwm120.com2ae = YES.
  /*--------- motor commission -----------------*/
 
  IF sic_bran.uwm120.com1ae   = Yes  Then do:                   /* MOTOR COMMISION */
     If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
     ASSIGN nv_com1p = 0.00  /*งาน kk ให้ค่า  com1A = 0.00 */
         nv_com1p    = deci(wdetail.commission).
     nv_fi_com1_t   =  - (sic_bran.uwm120.prem_r - nt_compprm) * nv_com1p / 100.            
         /*fi_com1ae        =  YES.*/
  End.
  /*----------- comp comission ------------*/
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then ASSIGN nv_com2p  = 0.00 
         nv_com2p  = DECI(wdetail.commission) .
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
           sic_bran.uwm120.gap_r    = n_gap_t    /*n_gap_r */
           sic_bran.uwm120.prem_r   = n_prem_t   /*n_prem_r */
           sic_bran.uwm120.sigr     = n_sigr_T   /* A490166 note modi from n_sigr_r to n_sigr_t 11/10/2006 */
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
 wdetail.nv_com1p     = nv_com1p70    
 wdetail.n_taxae      = nv_taxae70    
 wdetail.n_stmpae     = nv_stmpae70   
 wdetail.n_com2ae     = nv_com2ae70   
 wdetail.n_com1ae     = nv_com1ae70   
 wdetail.nv_fi_rstp_t = nv_fi_rstp_t70
 wdetail.nv_fi_rtax_t = nv_fi_rtax_t70
------------------------------------------------------------------------------*/
/*
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
            Assign     wdetail.nv_com1p = sicsyac.xmm018.commsp  
      /* nv_com2p = 0.*/
      nv_com2p =  deci(wdetail.commiss70). 
  ELSE DO:
          Find sicsyac.xmm031  Use-index xmm03101  Where  
               sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
          No-lock no-error no-wait.
          IF not  avail sicsyac.xmm031 Then 
            Assign     wdetail.nv_com1p = 0
                       /*nv_com2p = 0.*/
              nv_com2p =  deci(wdetail.commiss70). 
          Else  
            Assign     wdetail.nv_com1p = sicsyac.xmm031.comm1
                       /*nv_com2p = 0 .*/
                nv_com2p =  deci(wdetail.commiss70). 
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
     If sic_bran.uwm120.com1p <> 0  Then wdetail.nv_com1p  = sic_bran.uwm120.com1p.
           nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * wdetail.nv_com1p / 100.            
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
           sic_bran.uwm120.com1p    = wdetail.nv_com1p
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
  End.  */   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4_old c-Win 
PROCEDURE proc_chktest4_old :
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
/*
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
DEF VAR   nv_com2p        AS DECI INIT 0.00 .
DEF VAR   nv_fi_netprm    AS DECI INIT 0.00.
DEF VAR   NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR   nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR   nv_fi_stamp_per AS DECI INIT 0.00.
DEF VAR   nv_fi_com1_t    AS DECI INIT 0.00.
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
      Return.
  End.
  Else  do:
      Assign nv_policy  =  CAPS(sic_bran.uwm100.policy)
          nv_rencnt  =  sic_bran.uwm100.rencnt
          nv_endcnt  =  sic_bran.uwm100.endcnt.
      FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
          sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
          sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
          sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
          sic_bran.uwm120.bchyr = nv_batchyr                AND 
          sic_bran.uwm120.bchno = nv_batchno                AND 
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
  END.  /*  avail  100   */

  /*-------------------- calprem ---------------------*/
  Find LAST  sic_bran.uwm120  Use-index uwm12001       WHERE          
      sic_bran.uwm120.policy  = sic_bran.uwm100.policy And
      sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt And
      sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND 
      sic_bran.uwm120.bchyr = nv_batchyr               AND 
      sic_bran.uwm120.bchno = nv_batchno               AND 
      sic_bran.uwm120.bchcnt  = nv_batcnt              No-error.

  /*FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
      sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
      substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
      SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
      sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
  IF AVAIL   sicsyac.xmm018 THEN 
      Assign     
      nv_com1p = sicsyac.xmm018.commsp  
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
  END. */
  /***--- Commmission Rate Line 72 ---***/
  IF wdetail.compul = "y" THEN DO:
      FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
                 sicsyac.xmm018.agent              = sic_bran.uwm100.acno1  AND               
                 substr(sicsyac.xmm018.poltyp,1,5) = "CRV72"                AND               
                 SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch AND               
                 sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR. 
      IF AVAIL   sicsyac.xmm018 THEN 
          ASSIGN nv_com2p = sicsyac.xmm018.commsp 
          nv_com2p = deci(wdetail.commiss70). 
      
      ELSE DO:
           Find  sicsyac.xmm031  Use-index xmm03101  Where  
                 sicsyac.xmm031.poltyp    = "v72"
           No-lock no-error no-wait.
           IF AVAIL sicsyac.xmm031 THEN
               ASSIGN nv_com2p = sicsyac.xmm031.comm1
               nv_com2p = deci(wdetail.commiss72). 
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
  /*IF sic_bran.uwm120.stmpae  = Yes Then do:                        /* STAMP */
     wdetail.nv_fi_rstp_t  = Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) +
                     (IF     (sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100)   -
                     Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) > 0
                     Then 1 Else 0).
  End.*/
  /*sic_bran.uwm100.rstp_t = wdetail.nv_fi_rstp_t.  54-0011*/
  sic_bran.uwm100.rstp_t =  wdetail.nv_fi_rstp_t.
     
  /*IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
      wdetail.nv_fi_rtax_t  = (sic_bran.uwm100.prem_t + wdetail.nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
       /* fi_taxae       = Yes.*/
  End.*/
  /*sic_bran.uwm100.rtax_t = wdetail.nv_fi_rtax_t.   54-0011*/
  sic_bran.uwm100.rtax_t =  wdetail.nv_fi_rtax_t.
  /*A54-0011
  sic_bran.uwm120.com1ae = YES.
  sic_bran.uwm120.com2ae = YES.*/
  sic_bran.uwm120.com1ae = wdetail.n_com1ae.   /*n_com1ae . A54-0011*/
  sic_bran.uwm120.com2ae = wdetail.n_com2ae.   /*n_com2ae .    A54-0011*/
  /*--------- motor commission ------70-----------*/
  IF sic_bran.uwm120.com1ae   = Yes  Then do:                   /* MOTOR COMMISION */
     If sic_bran.uwm120.com1p <> 0  Then 
         ASSIGN nv_com1p  = sic_bran.uwm120.com1p 
         nv_com1p = deci(wdetail.commiss70). 

           nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.            
         /*fi_com1ae        =  YES.*/

  End. 
  /*----------- comp comission ----72--------*/
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then 
          ASSIGN nv_com2p  = sic_bran.uwm120.com2p
          nv_com2p = deci(wdetail.commiss72).
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
           sic_bran.uwm100.rstp_t  =  wdetail.nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  =  wdetail.nv_fi_rtax_t         
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
           sic_bran.uwm120.rtax     = wdetail.nv_fi_rtax_t
           sic_bran.uwm120.taxae    = wdetail.n_taxae
           sic_bran.uwm120.stmpae   = wdetail.n_stmpae
           sic_bran.uwm120.rstp_r   = wdetail.nv_fi_rstp_t            
           sic_bran.uwm120.com1ae   = wdetail.n_com1ae
           sic_bran.uwm120.com1p    = nv_com1p
           sic_bran.uwm120.com1_r   = nv_fi_com1_t
           sic_bran.uwm120.com2ae   = wdetail.n_com2ae
           sic_bran.uwm120.com2p    = nv_com2p
           sic_bran.uwm120.com2_r   = nv_fi_com2_t.
        IF wdetail.poltyp = "v72" THEN 
           ASSIGN  
           sic_bran.uwm120.com2_r  = 0  
           sic_bran.uwm120.com1_r  = (n_prem_t * nv_com1p / 100) * 1-    /*nv_fi_com2_t*/
           sic_bran.uwm120.com1p   = nv_com1p  /*wdetail.nv_com1p  */        /*nv_com2p*/
           sic_bran.uwm120.com2p   = 0  
           sic_bran.uwm120.rstp_r  = wdetail.nv_fi_rstp_t 
           sic_bran.uwm120.rtax    = wdetail.nv_fi_rtax_t.
  End.    */ 
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
       sic_bran.uwm100.policy =  wdetail.policyno                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
       sic_bran.uwm100.rencnt =  wdetail.n_rencnt             
       sic_bran.uwm100.renno  =  ""
       sic_bran.uwm100.endcnt =  wdetail.n_endcnt
       sic_bran.uwm100.bchyr  =  nv_batchyr 
       sic_bran.uwm100.bchno  =  nv_batchno 
       sic_bran.uwm100.bchcnt =  nv_batcnt     .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_mailtxt c-Win 
PROCEDURE proc_mailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
IF  wdetail2.drivnam = "Y" THEN DO :      /*note add 07/11/2005*/
 
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
  
  /*nv_drivage1 =  YEAR(TODAY) - INT(SUBSTR(wdetail.dbirth,7,4))  .
  nv_drivage2 =  YEAR(TODAY) - INT(SUBSTR(wdetail.ddbirth,7,4))  .*/

  /*IF wdetail.dbirth <> " "  AND wdetail.drivername1 <> " " THEN DO: /*note add & modified*/
     nv_drivbir1      = STRING(INT(SUBSTR(wdetail.dbirth,7,4)) + 543).
     wdetail.dbirth = SUBSTR(wdetail.dbirth,1,6) + nv_drivbir1.
  END.

  IF wdetail.ddbirth <>  " " AND wdetail.drivername2 <> " " THEN DO: /*note add & modified */
     nv_drivbir2      = STRING(INT(SUBSTR(wdetail.ddbirth,7,4)) + 543).
     wdetail.ddbirth = SUBSTR(wdetail.ddbirth,1,6) + nv_drivbir2.
  END.*/
  
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
 END. /*note add for mailtxt 07/11/2005*/
 */

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
IF wdetail.policyno <> "" THEN DO:
    ASSIGN fi_process = "Create Data uwm100  File Siam Carrent Group.." + wdetail.policyno.
    DISP fi_process   WITH FRAM fr_main.
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
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        /*FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policyno NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.  */
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk      NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass = "N"
            wdetail.comment      = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning      = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policyno = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policyno  = nv_tmppol.
        END.
        RUN proc_create100.
    END.      /*wdetail.stk  <>  ""*/
    ELSE DO:  /*sticker = ""*/ 
        /*FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy = wdetail.policyno NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            IF wdetail.policyno = "" THEN DO:
                RUN proc_temppolicy.
                wdetail.policyno  = nv_tmppol.
            END.
            RUN proc_create100. 
        END.           
        ELSE RUN proc_create100.  */
        RUN proc_create100. 
    END.
END.
ELSE DO:  /*wdetail.policyno = ""*/
    IF wdetail.stk  <>  ""  THEN DO:
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001  WHERE
            sicuw.uwm100.policy =  wdetail.policyno NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
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
        IF wdetail.policyno = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policyno  = nv_tmppol.
        END.
        RUN proc_create100.
    END.       /*wdetail.stk  <>  ""*/
    ELSE DO:   /*policy = "" and comp_sck = ""  */
        IF wdetail.policyno = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policyno  = nv_tmppol.
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
    ASSIGN  nv_docno  = wdetail.Docno
    nv_accdat = TODAY.
ELSE DO:
        IF wdetail.docno  = "" THEN nv_docno  = "".
        IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
IF wdetail.prepol = ""  THEN nn_firstdat = date(wdetail.comdat).                             
DO TRANSACTION:                                                                        
    ASSIGN                                                                             
        sic_bran.uwm100.renno  = ""                                                      
        sic_bran.uwm100.endno  = ""                                                      
        sic_bran.uwm100.poltyp = wdetail.poltyp                                          
        sic_bran.uwm100.insref = nn_acno                                              
        sic_bran.uwm100.opnpol = wdetail.promotion   /*-- A58-0354--*/
        sic_bran.uwm100.anam2  = ""                   
        sic_bran.uwm100.ntitle = nn_ntitle          
        sic_bran.uwm100.name1  = nn_name            
        sic_bran.uwm100.name2  = ""                                 
        sic_bran.uwm100.name3  = ""                 
        sic_bran.uwm100.addr1  = nn_addr1                  
        sic_bran.uwm100.addr2  = nn_addr2
        sic_bran.uwm100.addr3  = nn_addr3
        sic_bran.uwm100.addr4  = nn_addr4
        sic_bran.uwm100.postcd = "" 
        sic_bran.uwm100.undyr  = String(Year(today),"9999")  /*   nv_undyr  */
        sic_bran.uwm100.branch = wdetail.n_branch            /* nv_branch  */                        
        sic_bran.uwm100.dept   = nv_dept                     
        sic_bran.uwm100.usrid  = USERID(LDBNAME(1))          
        /*sic_bran.uwm100.fstdat = TODAY                     /*TODAY */kridtiya i. a53-0171*/
        sic_bran.uwm100.fstdat =  nn_firstdat            /*DATE(wdetail.comdat) kridtiya i. a53-0171 ให้ firstdate*/
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
        sic_bran.uwm100.prog   = "wgwsagen"
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
        sic_bran.uwm100.acno1  = wdetail.producer /*nv_acno1 */
        sic_bran.uwm100.agent  = wdetail.agent    /*nv_agent   */
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
        sic_bran.uwm100.cr_2   =  wdetail.cr_2
        sic_bran.uwm100.bchyr  = nv_batchyr              /*Batch Year */  
        sic_bran.uwm100.bchno  = nv_batchno              /*Batch No.  */  
        sic_bran.uwm100.bchcnt = nv_batcnt               /*Batch Count*/  
        sic_bran.uwm100.prvpol = wdetail.prepol          
        sic_bran.uwm100.cedpol = ""    
        sic_bran.uwm100.finint = ""
        sic_bran.uwm100.bs_cd  = wdetail.vatcode          /*wdetail.typrequest*/ /*Vatcode*/
        sic_bran.uwm100.opnpol = wdetail.promotion        /*-- A58-0354--*/ 
        sic_bran.uwm100.occupn  = trim(wdetail.occup)     /*  A59-0186 kridtiya i.  อาชีพ*/
        /*sic_bran.uwm100.endern  = "?"*/               /*วันที่รับเงิน*/
        /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.firstName    = TRIM(wdetail.firstName)     
        sic_bran.uwm100.lastName     = TRIM(wdetail.lastName)      
        sic_bran.uwm100.postcd       = trim(wdetail.postcd)        
        sic_bran.uwm100.icno         = trim(wdetail.icno)          
        sic_bran.uwm100.codeocc      = trim(wdetail.codeocc)       
        sic_bran.uwm100.codeaddr1    = TRIM(wdetail.codeaddr1)     
        sic_bran.uwm100.codeaddr2    = TRIM(wdetail.codeaddr2)     
        sic_bran.uwm100.codeaddr3    = trim(wdetail.codeaddr3)     
        /*sic_bran.uwm100.br_insured   = trim(wdetail.br_insured)  */  
        sic_bran.uwm100.campaign     = trim(wdetail.campaign_ov)   /*campaign ov code */ 
        sic_bran.uwm100.cr_1         = trim(wdetail.product)  .  
        /*Add by Kridtiya i. A63-0472*/


    IF wdetail.prepol <> " " THEN DO:
        IF wdetail.poltyp = "v72"  THEN ASSIGN  sic_bran.uwm100.prvpol  = ""
                                                sic_bran.uwm100.tranty  = "R".  
        ELSE 
            ASSIGN
                sic_bran.uwm100.prvpol  = wdetail.prepol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                sic_bran.uwm100.tranty  = "R".               /*Transaction Type (N/R/E/C/T)*/
    END.
    IF wdetail.pass = "Y" THEN
        sic_bran.uwm100.impflg  = YES.
    ELSE  sic_bran.uwm100.impflg  = NO.
    IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN 
        sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
    IF wdetail.cancel = "ca" THEN
        sic_bran.uwm100.polsta = "CA" .
    ELSE  sic_bran.uwm100.polsta = "IF".
    IF fi_loaddat <> ? THEN sic_bran.uwm100.trndat = fi_loaddat.
    ELSE sic_bran.uwm100.trndat = TODAY.
    sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
    nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                      (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                      (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                  ELSE (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1 .   
END.  /*transaction*//**/
/*RUN proc_uwd100.     /*A56-0151*/
RUN proc_uwd102.*/     /*A56-0151*/
RUN proc_uwd100_new.   /*A56-0151*/
RUN proc_uwd102_new.   /*A56-0151*/
/*RUN proc_uwd102.*/
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
    RUN wgw/wgwad120 (INPUT  sic_bran.uwm100.policy,    /***--- A490166 Note Modi ---***/
                             sic_bran.uwm100.rencnt,
                             sic_bran.uwm100.endcnt,
                             s_riskgp,
                             s_riskno,
                      OUTPUT s_recid2).
    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
END.    /* end not avail  uwm120 */
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
        sic_bran.uwm120.bchyr  = nv_batchyr     /* batch Year */
        sic_bran.uwm120.bchno  = nv_batchno     /* bchno      */
        sic_bran.uwm120.bchcnt = nv_batcnt .    /* bchcnt     */
        ASSIGN
            sic_bran.uwm120.class  = wdetail.subclass 
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
FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail2.prepol   No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF sicuw.uwm100.renpol <> " " THEN DO:
        MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
        /* ASSIGN  wdetail.prepol = "Already Renew" /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
            wdetail.comment    = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
            wdetail.OK_GEN     = "N"
            wdetail.pass       = "N".  */
    END.
    ELSE DO: 
        ASSIGN   
            wdetail2.prepol = sicuw.uwm100.policy
            n_rencnt        =  sicuw.uwm100.rencnt  +  1
            n_endcnt        =  0   
            /*wdetail.pass  = "Y" */    .
        RUN proc_assignrenew.      /*รับค่า ความคุ้มครองของเก่า */
    END.
END.      /*  avail  uwm100  */
Else do:  
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0.
       /* wdetail.prepol   = ""
        wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  "*/  
END.   /*not  avail uwm100*/
/*IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew3 c-Win 
PROCEDURE proc_renew3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail2.prepol   No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    /*IF sicuw.uwm100.renpol <> " " THEN DO:
        MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
       /* ASSIGN  wdetail.prepol = "Already Renew" /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
            wdetail.comment    = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
            wdetail.OK_GEN     = "N"
            wdetail.pass       = "N".  */
    END.
    ELSE DO: */
    ASSIGN   
        wdetail2.prepol = sicuw.uwm100.policy
        n_rencnt  =  sicuw.uwm100.rencnt  +  1
        n_endcnt  =  0
        /*wdetail.pass  = "Y" */    .
    RUN proc_assignrenew.      /*รับค่า ความคุ้มครองของเก่า */
END.     /*  avail  uwm100  */
Else do:  
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0.
        /* wdetail.prepol   = ""
        wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  "*/  
END.   /*not  avail uwm100*/
/*IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".*/

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
FOR EACH wdetail  WHERE wdetail.PASS <> "Y"  :
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
FOR EACH  wdetail  WHERE wdetail.PASS <> "Y" :   
    PUT STREAM ns1 wdetail.redbook     "," 
        wdetail.n_branch     "," 
        wdetail.policyno      ","
        wdetail.cndat         ","
        wdetail.comdat        ","
        wdetail.expdat        ","
        wdetail.covcod        ","
        wdetail.garage        "," 
        wdetail.tiname        ","
        wdetail.insnam        ","
        wdetail.brand         ","               
        wdetail.cargrp        ","               
        wdetail.chasno        ","               
        wdetail.eng           ","               
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
        wdetail.prepol        ","
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
        wdetail.deductpd      ","   
        /*wdetail.tp2           ","  */ 
        /*wdetail.deductda      ","  */ 
        wdetail.deduct        ","   
        /*wdetail.tpfire        ","  */ 
        wdetail.compul        ","   
        wdetail.pass          ","     
        wdetail.NO_41         ","   
        wdetail.NO_42         ","   
        wdetail.NO_43         ","   
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
FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
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
FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
            wdetail.redbook    ","   
            wdetail.n_branch   ","   
            wdetail.policyno   ","
            wdetail.cndat      ","
            wdetail.comdat     ","
            wdetail.expdat     ","
            wdetail.covcod     ","
            wdetail.garage     "," 
            wdetail.tiname     ","
            wdetail.insnam     ","
            wdetail.brand      ","               
            wdetail.cargrp     ","               
            wdetail.chasno     ","               
            wdetail.eng        ","               
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
            wdetail.prepol     ","
            wdetail.benname    ","   
            wdetail.comper     ","   
            wdetail.comacc     ","   
            wdetail.deductpd   ","   
            wdetail.deduct     ","  
            wdetail.compul     ","   
            wdetail.pass       ","     
            wdetail.NO_41      ","   
            wdetail.NO_42      ","   
            wdetail.NO_43      ","   
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
      
      CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd). 
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd). *//*Comment A62-0105*/ 
      /*CONNECT expiry -H 18.10.100.5 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. /*test*/ */
      
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
        ASSIGN wdetail.comment = "รถผู้เอาประกัน ติด suspect ทะเบียน " + nn_vehreglist + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
END.
IF (nv_msgstatus = "") AND (nn_namelist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
        sicuw.uzsusp.fname = nn_namelist           AND 
        sicuw.uzsusp.lname = nn_namelist2          NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN wdetail.comment = "ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
    ELSE DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = Trim(nn_namelist  + " " + nn_namelist2)        
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN wdetail.comment = "ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".
        END.
    END.
END.

IF (nv_msgstatus = "") AND (nv_chanolist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp05   WHERE 
        uzsusp.cha_no =  nv_chanolist         NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN wdetail.comment = "รถผู้เอาประกัน ติด suspect เลขตัวถัง " + nv_chanolist + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
END.
IF (nv_msgstatus = "") AND (nv_idnolist <> "") THEN DO:

    FIND LAST sicuw.uzsusp USE-INDEX uzsusp08    WHERE 
        sicuw.uzsusp.notes = nv_idnolist   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN wdetail.comment = "IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
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
            ASSIGN wdetail.comment  = "IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
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
DEF VAR nv_polf15 AS CHAR FORMAT "x(12)" INIT "".
ASSIGN nv_polf15 = "".
IF      ra_textf15 = 1 THEN  nv_polf15 = TRIM(fi_polmas70).  /*By policy master*/
ELSE IF ra_textf15 = 2 THEN  nv_polf15 = wdetail.prepol   .  /*by prepol */
ELSE nv_polf15 = "".
IF nv_polf15 <> "" THEN DO:
    ASSIGN nv_bptr  = 0.
    FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
        sic_bran.uwm100.policy  = wdetail.policyno  AND
        sic_bran.uwm100.rencnt  = wdetail.n_rencnt  AND
        sic_bran.uwm100.endcnt  = wdetail.n_endcnt  AND
        sic_bran.uwm100.bchyr   = nv_batchyr    AND
        sic_bran.uwm100.bchno   = nv_batchno    AND
        sic_bran.uwm100.bchcnt  = nv_batcnt    NO-ERROR NO-WAIT.
    IF AVAILABLE sic_bran.uwm100 THEN DO:
        FOR EACH wuppertxt NO-LOCK 
            WHERE wuppertxt.policy = nv_polf15
            BREAK BY wuppertxt.line:

            CREATE sic_bran.uwd100.
            ASSIGN
                sic_bran.uwd100.bptr    = nv_bptr
                sic_bran.uwd100.fptr    = 0
                sic_bran.uwd100.policy  = wdetail.policyno
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
    END.   /*uwm100*/ 
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100_new c-Win 
PROCEDURE proc_uwd100_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*create  text (F17) for Query claim....*/
DEF VAR nv_polf15 AS CHAR FORMAT "x(12)" INIT "".
ASSIGN nv_polf15 = "".
IF      ra_textf15 = 1  THEN nv_polf15 = TRIM(fi_polmas70).  
ELSE IF ra_textf15 = 2  THEN nv_polf15 = wdetail.prepol .
ELSE nv_polf15 = "".
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
    nv_txt5  = ""   
    nv_line1 = 0 .
IF nv_polf15 <> "" THEN DO:
    FIND LAST sicuw.uwm100  USE-INDEX uwm10001 
        WHERE uwm100.policy     = nv_polf15    NO-LOCK NO-ERROR.
    IF AVAILABLE uwm100 THEN DO :
        ASSIGN sv_fptr = uwm100.fptr01
               sv_bptr = uwm100.bptr01.
        IF sv_fptr <> 0  AND sv_fptr <> ? THEN DO:
            IF sv_fptr <> 0 THEN  nvw_fptr = sv_fptr.
            REPEAT nvw_index = 1 TO nvw_dl
                WHILE nvw_fptr <> 0:
                FIND sicuw.uwd100 WHERE RECID(uwd100) = nvw_fptr NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwd100 THEN DO:
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
                END.   /*add kridt pin...*/
                DOWN 1 WITH FRAME nf1.
            END.
            /*Add  A57-0302  */
            IF trim(wdetail.nomn30) <> "" THEN DO:
                CREATE wuppertxt.
                ASSIGN 
                    wuppertxt.line = nv_line1 + 1
                    wuppertxt.txt  = trim(wdetail.nomn30) .
            END.
            /*Add  A57-0302  */ 
            nvw_list = NO.
            FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
                sic_bran.uwm100.policy  = wdetail.policyno  AND
                sic_bran.uwm100.rencnt  = wdetail.n_rencnt  AND
                sic_bran.uwm100.endcnt  = wdetail.n_endcnt  AND
                sic_bran.uwm100.bchyr   = nv_batchyr        AND
                sic_bran.uwm100.bchno   = nv_batchno        AND
                sic_bran.uwm100.bchcnt  = nv_batcnt         NO-ERROR NO-WAIT.
            IF AVAILABLE sic_bran.uwm100 THEN DO:
                FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
                    CREATE sic_bran.uwd100.
                    ASSIGN
                        sic_bran.uwd100.bptr    = nv_bptr
                        sic_bran.uwd100.fptr    = 0
                        sic_bran.uwd100.policy  = wdetail.policyno
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
            END.   /*uwm100*/ 
        END.
        ELSE DO:  /*sv_fptr = 0  กรณีไม่มี F15 ที่กรม master*/
            IF trim(wdetail.nomn30) <> "" THEN DO:
                CREATE wuppertxt.
                ASSIGN 
                    wuppertxt.line = nv_line1 + 1
                    wuppertxt.txt  = trim(wdetail.nomn30) .
            END.
            FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
                sic_bran.uwm100.policy  = wdetail.policyno  AND
                sic_bran.uwm100.rencnt  = wdetail.n_rencnt  AND
                sic_bran.uwm100.endcnt  = wdetail.n_endcnt  AND
                sic_bran.uwm100.bchyr   = nv_batchyr        AND
                sic_bran.uwm100.bchno   = nv_batchno        AND
                sic_bran.uwm100.bchcnt  = nv_batcnt         NO-ERROR NO-WAIT.
            IF AVAILABLE sic_bran.uwm100 THEN DO:
                FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
                    CREATE sic_bran.uwd100.
                    ASSIGN
                        sic_bran.uwd100.bptr    = nv_bptr
                        sic_bran.uwd100.fptr    = 0
                        sic_bran.uwd100.policy  = wdetail.policyno
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
            END.   /*uwm100*/ 
        END.
    END.
END.
ELSE DO:  /*Add  A57-0302  */
    IF trim(wdetail.nomn30) <> "" THEN DO:
        CREATE wuppertxt.
        ASSIGN 
            nv_line1 = 0
            wuppertxt.line = nv_line1 + 1
            wuppertxt.txt  = trim(wdetail.nomn30) .
        FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
            sic_bran.uwm100.policy  = wdetail.policyno  AND
            sic_bran.uwm100.rencnt  = wdetail.n_rencnt  AND
            sic_bran.uwm100.endcnt  = wdetail.n_endcnt  AND
            sic_bran.uwm100.bchyr   = nv_batchyr        AND
            sic_bran.uwm100.bchno   = nv_batchno        AND
            sic_bran.uwm100.bchcnt  = nv_batcnt         NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwm100 THEN DO:
            FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
                CREATE sic_bran.uwd100.
                ASSIGN
                    sic_bran.uwd100.bptr    = nv_bptr
                    sic_bran.uwd100.fptr    = 0
                    sic_bran.uwd100.policy  = wdetail.policyno
                    sic_bran.uwd100.rencnt  = wdetail.n_rencnt
                    sic_bran.uwd100.endcnt  = wdetail.n_endcnt
                    sic_bran.uwd100.ltext   = wuppertxt.txt.
                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                    wf_uwd100.fptr = RECID(sic_bran.uwd100).
                    END.
                    IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(sic_bran.uwd100).
                    nv_bptr = RECID(sic_bran.uwd100).
            END.  /* wuppertxt */
        END.    /*uwm100*/
    END.
END. /*Add  A57-0302  */
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
MESSAGE "f18" VIEW-AS ALERT-BOX.
DEF VAR nv_pol17 AS CHAR FORMAT "x(12)".
ASSIGN nv_pol17 = "".
IF ra_textf17 = 1  THEN  nv_pol17 =  wdetail.prepol.
ELSE IF ra_textf17 = 2  THEN  nv_pol17 = TRIM(fi_polmas70).
ELSE nv_pol17 = "".
IF nv_pol17 <> ""  THEN DO: 
    Assign
        nv_fptr = 0 
        nv_bptr = 0  
        nv_nptr = 0 . 
    IF n_numtxt > 0 THEN DO:
        FOR EACH wuppertxt3 NO-LOCK 
            WHERE wuppertxt3.policy = nv_pol17 
            BREAK BY wuppertxt3.line:
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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102_new c-Win 
PROCEDURE proc_uwd102_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*F18 memmo */

DEF VAR nv_pol17 AS CHAR FORMAT "x(12)".
ASSIGN nv_pol17 = "".
IF      ra_textf17 = 1  THEN nv_pol17 = TRIM(fi_polmas70).
ELSE IF ra_textf17 = 2  THEN nv_pol17 = wdetail.prepol.
ELSE nv_pol17 = "".
IF nv_pol17 <> ""  THEN DO: 
    ASSIGN 
        nv_fptr  = 0
        nv_bptr  = 0
        nv_nptr  = 0
        nv_line1 = 0
        n_numtxt = 0.
    FOR EACH wuppertxt3.
        DELETE wuppertxt3.
    END.
    FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE uwm100.policy =  nv_pol17  NO-LOCK NO-ERROR.
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
                    IF nvw_index = 1 THEN
                        nvw_prev = uwd102.bptr.
                    ELSE IF nvw_index = nvw_dl THEN DO:
                        nvw_next = uwd102.fptr.
                        LEAVE.
                    END.
                END.
                nvw_fptr = uwd102.fptr.
            END.
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
                IF ( DAY(sic_bran.uwm100.comdat)     =  DAY(sic_bran.uwm100.expdat)     AND
                   MONTH(sic_bran.uwm100.comdat)     =  MONTH(sic_bran.uwm100.expdat)   AND
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
      IF s_curbil = "BHT" THEN  
          /*sic_bran.uwd132.prem_c = sic_bran.uwd132.prem_c.*/
          sic_bran.uwd132.prem_c  = deci(wdetail.premt) .
    END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_xmm600 c-Win 
PROCEDURE proc_xmm600 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
    sicsyac.xmm600.acno = trim(fi_insurceco)     NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xmm600  THEN
    ASSIGN 
    nn_firstName      = TRIM(sicsyac.xmm600.firstname)
    nn_lastName       = TRIM(sicsyac.xmm600.lastName)
    nn_postcd         = trim(sicsyac.xmm600.postcd)
    nn_icno           = trim(sicsyac.xmm600.icno)
    nn_codeocc        = trim(sicsyac.xmm600.codeocc) 
    nn_codeaddr1      = TRIM(sicsyac.xmm600.codeaddr1)
    nn_codeaddr2      = TRIM(sicsyac.xmm600.codeaddr2)
    nn_codeaddr3      = trim(sicsyac.xmm600.codeaddr3)
    nn_br_insured     = trim(sicsyac.xmm600.anlyc5)     .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

