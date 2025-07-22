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
  Created: ------------------------------------------------------------------------*/
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
/*programid   : wgwtsge2.w                                              */ 
/*programname : Load text file TIL to GW  -สำหรับงานต่ออายุ             */ 
/* Copyright  : Safety Insurance Public Company Limited                 */  
/*                            บริษัท ประกันคุ้มภัย จำกัด (มหาชน)        */  
/*create by   : Kridtiya i. A53-0374   date. 22/11/2010               
          ปรับโปรแกรมให้สามารถนำเข้า text file TIL-renew to GW system   */ 
/*copy write  : wgwargen.w                                              */ 
/*modify by   : Kridtiya i. A56-0217 เพิ่มเลขบัตรประจำตัวผู้เอาประกัน   */
/*modify by   : Kridtiya i. A56-0217 เพิ่มเลขสติ๊กเกอร์และเลขที่ใบเสร็จ */
/*modify by   : Kridtiya i. A56-0262 เพิ่มส่วนการแปลงไฟล์ที่หน้าจอการนำเข้าข้อมูล*/
/*modify  by  : Kridtiya i. A57-0010 date . 15/01/2014 add pretxt (F6)add driver    */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
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
DEF VAR nv_reccnt   AS  INT  INIT  0.           /*all load record*/
DEF VAR nv_completecnt    AS   INT   INIT  0.   /*complete record */
DEF NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".   
DEF NEW SHARED  VAR nv_modulo    AS INTE  FORMAT  "9".
DEF VAR s_riskgp    AS INTE FORMAT ">9".
DEF VAR s_riskno    AS INTE FORMAT "999".
DEF VAR s_itemno    AS INTE FORMAT "999". 
/*DEF VAR nv_drivage1 AS INTE INIT 0.
DEF VAR nv_drivage2 AS INTE INIT 0.
DEF VAR nv_drivbir1 AS CHAR INIT "".
DEF VAR nv_drivbir2 AS CHAR INIT "".*/
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
/*DEF Var nv_lastno As       Int.
Def Var nv_seqno  As       Int.
DEF VAR sv_xmm600 AS       RECID.*/
{wgw\wgwtsge2.i}      /*ประกาศตัวแปร*/
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
DEFINE VAR gv_id       AS CHAR FORMAT "X(8)" NO-UNDO.   
DEFINE VAR nv_pwd      AS CHAR NO-UNDO.                
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".
DEFINE VAR n_ratmin    AS INTE INIT 0.
DEFINE VAR n_ratmax    AS INTE INIT 0.
DEFINE VAR nv_maxdes   AS CHAR.
DEFINE VAR nv_mindes   AS CHAR.
DEFINE VAR nv_si       AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_maxSI    AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_minSI    AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */
DEFINE VAR nv_uwm301trareg    LIKE sic_bran.uwm301.cha_no INIT "".
DEFINE VAR nv_basere   AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0. 
DEFINE VAR nv_newsck   AS CHAR FORMAT "x(15)" INIT " ".
DEFINE VAR n_firstdat  AS DATE INIT ?.
DEFINE VAR nv_deler    AS CHAR FORMAT "x(10)" INIT " ".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.poltyp wdetail.policy wdetail.prvpol wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.iadd1 wdetail.iadd2 wdetail.iadd3 wdetail.iadd4 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.engno wdetail.chasno wdetail.caryear wdetail.carprovi wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.volprem wdetail.Compprem wdetail.fleet wdetail.ncb wdetail.access wdetail.deductpp wdetail.deductba wdetail.deductpa wdetail.benname wdetail.n_user wdetail.n_IMPORT wdetail.n_export wdetail.producer wdetail.agent wdetail.comment WDETAIL.WARNING wdetail.cancel wdetail.redbook   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_comp ra_typload ra_typefile fi_loaddat ~
fi_pack fi_branch fi_producer fi_bchno fi_agent fi_producer72 fi_agent72 ~
fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 fi_output3 ~
fi_usrcnt fi_usrprem buok bu_exit bu_hpbrn bu_hpacno1 bu_hpagent ~
bu_hpacno72 bu_hpagent72 fi_process fi_prom fi_packcom fi_premcomp bu_add ~
bu_del fi_model RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 br_wdetail ~
RECT-377 RECT-378 RECT-379 
&Scoped-Define DISPLAYED-OBJECTS ra_typload ra_typefile fi_loaddat fi_pack ~
fi_branch fi_producer fi_bchno fi_agent fi_producer72 fi_agent72 fi_prevbat ~
fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem ~
fi_brndes fi_proname fi_agtname fi_impcnt fi_proname72 fi_completecnt ~
fi_premtot fi_agtname72 fi_premsuc fi_process fi_prom fi_packcom ~
fi_premcomp fi_model 

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

DEFINE VARIABLE fi_agent72 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agtname72 AS CHARACTER FORMAT "X(40)":U 
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
     SIZE 30 BY .91
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
     SIZE 70 BY .95 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer72 AS CHARACTER FORMAT "X(10)":U 
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
          "Match File Text to Excel", 1,
"Load To GW", 2,
"Match Sticker Yes/no", 3,
"Match Policy", 4
     SIZE 100 BY .91
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE ra_typload AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          " TIL", 1,
"NON-TIL", 2
     SIZE 23 BY .91
     BGCOLOR 6 FGCOLOR 2  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 1.52
     BGCOLOR 31 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 14
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 5.24
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
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17 BY 1.67
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 32.67 BY 2.33
     BGCOLOR 6 FGCOLOR 6 .

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
         BGCOLOR 15 FGCOLOR 0 FONT 6 EXPANDABLE.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.poltyp  COLUMN-LABEL "Policy Type"
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
        wdetail.comment FORMAT "x(35)" COLUMN-BGCOLOR  80 COLUMN-LABEL "Comment"
        WDETAIL.WARNING   COLUMN-LABEL "Warning"

        wdetail.cancel  COLUMN-LABEL "Cancel"
        wdetail.redbook COLUMN-LABEL "RedBook"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 4.95
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_comp AT ROW 7.29 COL 101.5
     ra_typload AT ROW 2.71 COL 4.5 NO-LABEL
     ra_typefile AT ROW 2.71 COL 28.5 NO-LABEL
     fi_loaddat AT ROW 3.76 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 3.76 COL 71.67 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 9.29 COL 11.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.05 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.57 COL 17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agent AT ROW 6.05 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_producer72 AT ROW 7.14 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_agent72 AT ROW 8.14 COL 26.5 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 9.29 COL 57 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 9.29 COL 88.33 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 10.33 COL 26.33 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 10.33 COL 88.83
     fi_output1 AT ROW 11.33 COL 26.33 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 12.33 COL 26.33 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 13.33 COL 26.33 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 14.33 COL 26.33 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 14.33 COL 64.67 NO-LABEL
     buok AT ROW 12.71 COL 92
     bu_exit AT ROW 14.62 COL 92
     fi_brndes AT ROW 9.29 COL 20.67 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 9.29 COL 18.83
     bu_hpacno1 AT ROW 5.05 COL 42.83
     bu_hpagent AT ROW 6.05 COL 42.83
     fi_proname AT ROW 5.05 COL 45.33 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6.05 COL 45.33 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 22.29 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpacno72 AT ROW 7.14 COL 42.83
     bu_hpagent72 AT ROW 8.14 COL 42.83
     fi_proname72 AT ROW 7.14 COL 45.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.29 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.29 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_agtname72 AT ROW 8.14 COL 45.33 COLON-ALIGNED NO-LABEL
     fi_premsuc AT ROW 23.33 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 15.43 COL 16.67 COLON-ALIGNED NO-LABEL
     fi_prom AT ROW 3.76 COL 51.33 COLON-ALIGNED NO-LABEL
     fi_packcom AT ROW 5 COL 111 COLON-ALIGNED NO-LABEL
     fi_premcomp AT ROW 6 COL 111.83 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 4.95 COL 125
     bu_del AT ROW 6.05 COL 125.17
     fi_model AT ROW 3.76 COL 100.33 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 16.71 COL 2
     "Branch :" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 9.29 COL 4.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Model Non-TIL vs STY :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 3.76 COL 78.67
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "                                   IMPORT TEXT FILE MOTOR [TIL/NON-TIL ] RENEW" VIEW-AS TEXT
          SIZE 128 BY .95 AT ROW 1.29 COL 129.5 RIGHT-ALIGNED
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 11.33 COL 4.5
          BGCOLOR 8 FGCOLOR 1 
     "     Agent Code 70-72:" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 6.05 COL 4.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 22.29 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Prom :" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 3.76 COL 47
          BGCOLOR 3 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.67 COL 5.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Base Comp :" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 6 COL 101.33
          BGCOLOR 5 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 14.33 COL 82.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Previous Batch No." VIEW-AS TEXT
          SIZE 19 BY .91 AT ROW 9.29 COL 39.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer Code 70-72:" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 5.05 COL 4.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 22.29 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 22.29 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Agent Code V72:" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 8.14 COL 4.5
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "                 Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 3.76 COL 4.5
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 3.76 COL 63.33
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 14.33 COL 26.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 12.33 COL 4.5
          BGCOLOR 8 FGCOLOR 1 
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 9.29 COL 89 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 10.33 COL 4.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 23.29 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "PackComp :" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 5 COL 101.5
          BGCOLOR 5 FGCOLOR 1 FONT 6
     "Producer  Code V72:" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 7.14 COL 4.5
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 13.33 COL 4.5
          BGCOLOR 8 FGCOLOR 1 
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1 AT ROW 23.29 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 23.29 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .91 AT ROW 14.33 COL 63 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.48 COL 1
     RECT-373 AT ROW 16.52 COL 1
     RECT-374 AT ROW 21.81 COL 1
     RECT-376 AT ROW 22.05 COL 2.5
     RECT-377 AT ROW 12.43 COL 90.83
     RECT-378 AT ROW 14.29 COL 90.83
     RECT-379 AT ROW 4.81 COL 99.83
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
         HEIGHT             = 23.91
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
   Custom                                                               */
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
/* SETTINGS FOR FILL-IN fi_agtname72 IN FRAME fr_main
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
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "                                   IMPORT TEXT FILE MOTOR [TIL/NON-TIL ] RENEW"
          SIZE 128 BY .95 AT ROW 1.29 COL 129.5 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.5 BY .91 AT ROW 9.29 COL 89 RIGHT-ALIGNED             */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 23 BY .91 AT ROW 14.33 COL 26.5 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .91 AT ROW 14.33 COL 63 RIGHT-ALIGNED            */

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
          WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          WDETAIL.CANCEL:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.redbook:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. /*new add*/                 


          /*wdetail.entdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.enttim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trandat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trantim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. *//*a490166*/ 
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
        IF ra_typload = 1 THEN RUN proc_assign.  /*Til*/
        ELSE RUN proc_assign_nontil.             /*non-Til*/
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
        RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                               INPUT            nv_batchyr ,     /* INT   */
                               INPUT            fi_producer,     /* CHAR  */ 
                               INPUT            nv_batbrn  ,     /* CHAR  */
                               INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                               INPUT            "wgwtsge2" ,     /* CHAR  */
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
        RELEASE stat.detaitem.
        RELEASE brStat.Detaitem.
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
                                          
     If  n_acno  <>  ""  Then  fi_agent =  n_acno.
     
     disp  fi_agent  with frame  fr_main.

     Apply "Entry"  to  fi_agent.
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
    If  n_acno  <>  ""  Then  fi_agent72 =  n_acno.
    disp  fi_agent72  with frame  fr_main.
    
    Apply "Entry"  to  fi_agent72.
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
            sicsyac.xmm600.acno  =  Input fi_agent  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_agent.
            RETURN NO-APPLY.  
        END.
        ELSE DO: 
            ASSIGN
                fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_agent   =  caps(INPUT  fi_agent) 
                nv_agent   =  fi_agent.             
        END.
    END.
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent72 c-Win
ON LEAVE OF fi_agent72 IN FRAME fr_main
DO:
    fi_agent72 = INPUT fi_agent72.
    IF  fi_agent72 <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001        WHERE
            sicsyac.xmm600.acno  =  Input fi_agent72  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"   View-as alert-box.
            Apply "Entry" To  fi_agent72.
            RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO:
            IF TRIM(sicsyac.xmm600.ntitle) = "" THEN fi_agtname72  =   TRIM(sicsyac.xmm600.name).
            ELSE fi_agtname72 =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name). 
            ASSIGN
                fi_agent72 =  caps(INPUT  fi_agent72) .
        END.
    END.
    Disp  fi_agent72  fi_agtname72    WITH Frame  fr_main. 
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
            IF TRIM(sicsyac.xmm600.ntitle) = "" THEN fi_agtname72 =   TRIM(sicsyac.xmm600.name).
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
                 ASSIGN
                     fi_producer72 =  caps(INPUT  fi_producer72) .
        END.
    END.
    Disp  fi_producer72  fi_proname72   WITH Frame  fr_main.   
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
    DISP ra_typefile fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
    APPLY "Entry" TO fi_output1.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typload c-Win
ON VALUE-CHANGED OF ra_typload IN FRAME fr_main
DO:
    ra_typload = INPUT ra_typload.
    IF ra_typload = 2 THEN ASSIGN fi_prom = "NON-TIL".
    ELSE ASSIGN fi_prom = "TIL".
    DISP ra_typload fi_prom WITH FRAM fr_main.
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
  
  gv_prgid = "wgwtsge2".
  gv_prog  = "Load Text & Generate TIL-RENEW".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN proc_createcomp.
  OPEN QUERY br_comp FOR EACH wcomp.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
      fi_prom       = "TIL"    /* A57-0266 */
      fi_pack       = "V"
      fi_branch     = "M"
      fi_producer   = "A000324"
      fi_agent      = "B3M0018"
      fi_producer72 = "A0M0083"
      fi_agent72    = "B3M0018"
      fi_model      = "model"
      fi_process    = "Load Text file RENEW Til/Non-Til "    /*A56-0262*/
      ra_typload    = 1   /*A57-0226*/
      ra_typefile   = 1   /*A56-0262*/
      fi_bchyr    = YEAR(TODAY) .
  DISP fi_prom fi_pack fi_branch fi_producer fi_agent fi_producer72 fi_agent72 fi_bchyr ra_typefile fi_process
       ra_typload fi_model   /*A57-0226*/
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
  DISPLAY ra_typload ra_typefile fi_loaddat fi_pack fi_branch fi_producer 
          fi_bchno fi_agent fi_producer72 fi_agent72 fi_prevbat fi_bchyr 
          fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem 
          fi_brndes fi_proname fi_agtname fi_impcnt fi_proname72 fi_completecnt 
          fi_premtot fi_agtname72 fi_premsuc fi_process fi_prom fi_packcom 
          fi_premcomp fi_model 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE br_comp ra_typload ra_typefile fi_loaddat fi_pack fi_branch 
         fi_producer fi_bchno fi_agent fi_producer72 fi_agent72 fi_prevbat 
         fi_bchyr fi_filename bu_file fi_output1 fi_output2 fi_output3 
         fi_usrcnt fi_usrprem buok bu_exit bu_hpbrn bu_hpacno1 bu_hpagent 
         bu_hpacno72 bu_hpagent72 fi_process fi_prom fi_packcom fi_premcomp 
         bu_add bu_del fi_model RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 
         br_wdetail RECT-377 RECT-378 RECT-379 
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
        sic_bran.uwm301.eng_no  = wdetail.eng
        sic_bran.uwm301.Tons    = INTEGER(wdetail.weight)
        sic_bran.uwm301.engine  = INTEGER(wdetail.cc)
        sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage  = wdetail.garage
        sic_bran.uwm301.body    = wdetail.body
        sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
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
    IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN ASSIGN n_class = "210"
            wdetail.subclass = "140A".
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
        IF ra_typload =  2 THEN DO:   /* Non-til */
            FIND FIRST stat.insure USE-INDEX insure01  WHERE   
                stat.insure.compno = fi_model          AND          
                stat.insure.fname  = wdetail.model     NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL insure THEN  ASSIGN wdetail.model =  trim(stat.insure.lname)   .
        END.
        FIND FIRST stat.maktab_fil Use-index  maktab04           Where
            stat.maktab_fil.makdes   =   wdetail.brand            And                  
            INDEX(stat.maktab_fil.moddes,wdetail.model) <>  0     AND
            stat.maktab_fil.makyea   =   Integer(wdetail.caryear) AND
            stat.maktab_fil.engine   =   Integer(wdetail.cc)      AND
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
            wdetail2.contractno     /*contract no             */ 
            wdetail2.tiname         
            wdetail2.insnam         
            wdetail2.insnam2        /*customer name           */  
            wdetail2.address        /*reg.address             */  
            wdetail2.brand          /*brand                   */  
            wdetail2.model          /*model                   */  
            wdetail2.caryear        /*year                    */  
            wdetail2.ccolor         /*color                   */  
            wdetail2.cc             /*cc                      */  
            wdetail2.engno          /*engine no               */  
            wdetail2.chasno         /*chassis                 */  
            wdetail2.vehreg         /*licence no              */ 
            wdetail2.province       /*province                */ 
            wdetail2.ins_compa      /*insurance comp.         */ 
            wdetail2.comdat         /*insurance date.         */ 
            wdetail2.expdat         /*expdat                  */ 
            wdetail2.prvpol         /*policy old              */ 
            wdetail2.branch         /*A57-0226                 */
            wdetail2.policy         /*policy                   */ 
            wdetail2.ins_si         /*sum insurance amount     */ 
            wdetail2.ins_amt        /*Net Premium (Voluntary). */ 
            wdetail2.prem_vo        /*premium(voluntary)       */ 
            wdetail2.sckno          /*compulsory no.           */ 
            wdetail2.scknumber      /*A56-0217*/ 
            wdetail2.docno          /*A56-0217*/ 
            wdetail2.prem_72        /*Net Premium (Compulsory) */ 
            wdetail2.prem_72net     /*premium(commpulsory)     */ 
            wdetail2.mail           /*mailing address          */ 
            /*wdetail2.ref_no       /*referance number         */    /*A56-0217*/
            wdetail2.temp           /*temporary number         */ */ /*A56-0217*/
            wdetail2.ICNO                                      /*A56-0217*/
            wdetail2.instyp                                    /*A56-0217*/
            wdetail2.sendnam
            wdetail2.chkcar
            wdetail2.telno
            wdetail2.np_f18line1 
            wdetail2.np_f18line2 
            wdetail2.np_f18line3 
            wdetail2.np_f18line4 
            wdetail2.np_f18line5 .
    END.   /* repeat   */
    FOR EACH wdetail2  .
             IF index(wdetail2.contractno,"THAI")     <> 0  THEN DELETE wdetail2.
        ELSE IF index(wdetail2.contractno,"contract") <> 0  THEN DELETE wdetail2.
        ELSE IF index(wdetail2.contractno,"Total")    <> 0  THEN DELETE wdetail2.
        ELSE IF wdetail2.contractno  = ""  THEN DELETE wdetail2.
        /*ELSE IF (wdetail2.policy = "") AND (trim(wdetail2.sckno) = "" ) THEN DELETE wdetail2.*//*A57-0226*/
    END.
/************************************
        IF wdetail2.prem_72 <> "" THEN DO:
            CREATE  wdetail2.
            ASSIGN 
                wdetail2.policy      = TRIM(SUBSTR(nv_daily,443,26))                                                   /*1 Header Record "D"*/                   
                wdetail2.contractno  = TRIM(SUBSTR(nv_daily,2,10))      /*2 Contract Number  */                              
                wdetail2.insnam      = TRIM(SUBSTR(nv_daily,12,60))     /*3 ชื่อผู้เอาประกัน*/                               
                wdetail2.address     = TRIM(SUBSTR(nv_daily,72,160))    /*4 ที่อยู่ผู้เอาประกัน1/สำหรับส่งเอกสาร*/           
                wdetail2.brand       = TRIM(SUBSTR(nv_daily,232,16))    /*5 Car brand code*/                    
                wdetail2.model       = TRIM(SUBSTR(nv_daily,248,16))    /*6 HILUX,SOLUNA*/                                   
                wdetail2.caryear     = TRIM(SUBSTR(nv_daily,264,4))     /*7 Year of car */                                   
                wdetail2.cc          = TRIM(SUBSTR(nv_daily,284,4))     /*9 CC/WEIGHT KG/TON*/                               
                wdetail2.engno       = TRIM(SUBSTR(nv_daily,288,26))    /*10หมายเลขเครื่องยนต์*/                             
                wdetail2.chasno      = TRIM(SUBSTR(nv_daily,314,26))    /*11หมายเลขตัวถังรถ*/                                
                wdetail2.vehreg      = TRIM(SUBSTR(nv_daily,340,12))    /*12หมายเลขทะเบียนรถ */                              
                wdetail2.province    = "TIL" + TRIM(SUBSTR(nv_daily,352,20))    /*13จังหวัดที่จดทะเบียนรถ*/                          
                wdetail2.comdat      = TRIM(SUBSTR(nv_daily,377,8))     /*15วันที่ตกลงรับประกัน */                           
                wdetail2.expdat      = TRIM(SUBSTR(nv_daily,385,8))     /*16วันทีสิ้นสุดความคุ้มครอง */                      
                wdetail2.prvpol      = TRIM(SUBSTR(nv_daily,393,26))    /*17เลขที่กรมธรรม์ */                                
                wdetail2.ins_amt     = TRIM(SUBSTR(nv_daily,419,12))    /*18เลขที่กรมธรรม์ */                                
                wdetail2.prem_vo     = TRIM(SUBSTR(nv_daily,431,12))    /*19ค่าเบี้ยป.1 + ภาษี + อากร */                     
                wdetail2.sckno       = TRIM(SUBSTR(nv_daily,443,26))    /*20เลขที่กรมธรรม์พรบ. */                            
                wdetail2.prem_72     = TRIM(SUBSTR(nv_daily,469,12))    /*21เบี้ย พรบ. */                                    
                wdetail2.mail        = TRIM(SUBSTR(nv_daily,481,160))
                wdetail2.ref_no      = TRIM(SUBSTR(nv_daily,641,15))
                wdetail2.temp        = TRIM(SUBSTR(nv_daily,656,16))  .                                
        END.

    END. */
END. /*-Repeat-*/    
/*RUN proc_assign2. */  
RUN proc_assign3. 
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
FOR EACH wdetail2.
    /*add A56-0262*/
    ASSIGN fi_process    = "Import data TIL-renew".    /*A56-0262*/
    DISP fi_process WITH FRAM fr_main.
    IF R-INDEX(trim(wdetail2.vehreg)," ") <> 0 THEN
        ASSIGN wdetail2.vehreg = trim(SUBSTR(trim(wdetail2.vehreg),1,INDEX(trim(wdetail2.vehreg)," "))) + " " +
                                 trim(SUBSTR(trim(wdetail2.vehreg),INDEX(trim(wdetail2.vehreg)," "))).
    IF INDEX(wdetail2.province,"til") <> 0 THEN DO:
        FIND FIRST brstat.insure USE-INDEX Insure03   WHERE   /*use-index fname */
            brstat.insure.compno = "999"    AND 
            brstat.insure.InsNo  = trim(wdetail2.province)  NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN DO:
            ASSIGN wdetail2.vehreg = trim(wdetail2.vehreg) + " " + trim(Insure.LName).
        END.
    END.
    ELSE ASSIGN  wdetail2.vehreg = trim(wdetail2.vehreg) + " " + trim(wdetail2.province).
    /*add A56-0262*/
    /*ELSE DO: 
        DELETE wdetail2.            /* not create  til12 ฉะเชิงเทรา */
        MESSAGE "proc_3 next" wdetail2.prvpol wdetail2.contractno wdetail2.province   VIEW-AS ALERT-BOX.
        NEXT.
    END.*/
    IF r-index(wdetail2.mail,"กรุง") <> 0  THEN 
        ASSIGN wdetail2.add4 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"กรุง"))
        wdetail2.mail = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"กรุง") - 1 ).
    ELSE IF r-index(wdetail2.mail,"กทม") <> 0  THEN 
        ASSIGN wdetail2.add4 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"กทม"))
        wdetail2.mail = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"กทม") - 1 ).
    ELSE IF r-index(wdetail2.mail,"จ.") <> 0  THEN 
        ASSIGN wdetail2.add4 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"จ."))
        wdetail2.mail = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"จ.") - 1 ).
    ELSE IF r-index(wdetail2.mail,"จังหวัด") <> 0  THEN 
        ASSIGN wdetail2.add4 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"จังหวัด"))
        wdetail2.mail = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"จังหวัด") - 1 ).
    IF r-index(wdetail2.mail,"เขต") <> 0  THEN 
        ASSIGN wdetail2.add3 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"เขต"))
        wdetail2.mail = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"เขต") - 1 ).
    ELSE IF r-index(wdetail2.mail,"อำเภอ") <> 0  THEN 
        ASSIGN wdetail2.add3 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"อำเภอ"))
        wdetail2.mail = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"อำเภอ") - 1 ).
    ELSE IF r-index(wdetail2.mail,"อ.") <> 0  THEN 
        ASSIGN wdetail2.add3 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"อ."))
        wdetail2.mail = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"อ.") - 1 ).
    /*"แขวง"*/
    IF r-index(wdetail2.mail,"แขวง") <> 0  THEN 
        ASSIGN wdetail2.add2 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"แขวง"))
        wdetail2.mail = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"แขวง") - 1 )
        wdetail2.add1 = wdetail2.mail.
    ELSE IF r-index(wdetail2.mail,"ตำบล") <> 0  THEN 
        ASSIGN wdetail2.add2 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"ตำบล"))
        wdetail2.mail = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"ตำบล") - 1 )
        wdetail2.add1 = wdetail2.mail.
    ELSE IF r-index(wdetail2.mail,"ต.") <> 0  THEN 
        ASSIGN wdetail2.add2 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"ต."))
        wdetail2.mail = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"ต.") - 1 )
        wdetail2.add1 = wdetail2.mail.
    /*"ถนน"*/
    IF r-index(wdetail2.mail,"ถนน") <> 0  THEN 
        ASSIGN wdetail2.add3 = wdetail2.add2  + " " + wdetail2.add3
        wdetail2.add2 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"ถนน"))
        wdetail2.add1 = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"ถนน") - 1 ).
    ELSE IF r-index(wdetail2.mail,"ถ.") <> 0  THEN 
        ASSIGN wdetail2.add3 = wdetail2.add2  + " " + wdetail2.add3
        wdetail2.add2 = SUBSTR(wdetail2.mail,r-index(wdetail2.mail,"ถ."))
        wdetail2.add1 = SUBSTR(wdetail2.mail,1,r-index(wdetail2.mail,"ถ.") - 1 ).
    RUN proc_cutchar.
    RUN proc_cutchar2.
    IF  ((DECI(wdetail2.cc) / 2)) - (TRUNC(DECI(wdetail2.cc) / 2 ,0)) > 0 THEN   wdetail2.cc = STRING(DECI(wdetail2.cc) + 1) .
    IF trim(wdetail2.tiname) <> "คุณ" THEN DO:
        FIND FIRST brstat.msgcode WHERE 
            brstat.msgcode.compno = "999" AND
            brstat.msgcode.MsgDesc = trim(wdetail2.tiname) NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.msgcode THEN 
            ASSIGN wdetail2.tiname = brstat.msgcode.branch.
    END.
    IF trim(wdetail2.instyp) = "9" THEN RUN proc_assign3_72.   /*พรบ.only 72*/
    ELSE DO:
        /*IF wdetail2.policy = ""  THEN RUN proc_assign3_72no70. /* 72 */
        ELSE DO:*/
        /*FIND FIRST wdetail WHERE wdetail.policy = wdetail2.policy NO-ERROR NO-WAIT.*/
        IF ( DECI(wdetail2.prem_vo) <> 0 ) AND (TRIM(wdetail2.prem_vo) <> "") THEN DO:
            FIND FIRST wdetail WHERE wdetail.policy = "0TL" + trim(wdetail2.contractno) NO-ERROR NO-WAIT.
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN
                    /*wdetail.policy      = caps(trim(wdetail2.policy)) */    /*A57-0226*/
                    wdetail.policy      = "0TL" + trim(wdetail2.contractno)  /*A57-0226*/
                    wdetail.seat        = IF deci(wdetail2.prem_72) = 600 THEN "7"  ELSE "3"
                    wdetail.brand       = "ISUZU"
                    wdetail.poltyp      = "v70" 
                    wdetail.insrefno    = ""
                    wdetail.comdat      = substr(wdetail2.comdat,1,2) + "/" + substr(wdetail2.comdat,3,2) + "/" + substr(wdetail2.comdat,5,4)  
                    wdetail.expdat      = substr(wdetail2.expdat,1,2) + "/" + substr(wdetail2.expdat,3,2) + "/" + substr(wdetail2.expdat,5,4) 
                    wdetail.tiname      = trim(wdetail2.tiname)
                    wdetail.insnam      = trim(wdetail2.insnam) + " " + TRIM(wdetail2.insnam2)
                    wdetail.ICNO        = trim(wdetail2.ICNO)    /*A56-0217*/
                    wdetail.subclass    = IF deci(wdetail2.prem_72) = 600 THEN "110"  ELSE "210"
                    wdetail.model       = IF index(wdetail2.model,"TFR85HG") <> 0 THEN "MU-7" ELSE "D-MAX" 
                    wdetail.cc          = trim(wdetail2.cc) 
                    wdetail.caryear     = trim(wdetail2.caryear)
                    wdetail.chasno      = trim(wdetail2.chasno)
                    wdetail.vehreg      = trim(wdetail2.vehreg)
                    wdetail.engno       = trim(wdetail2.engno)
                    wdetail.iadd1       = trim(wdetail2.add1) 
                    wdetail.iadd2       = trim(wdetail2.add2) 
                    wdetail.iadd3       = trim(wdetail2.add3) 
                    wdetail.iadd4       = trim(wdetail2.add4) 
                    wdetail.vehuse      = "1"
                    wdetail.garage      = ""
                    wdetail.stk         = ""
                    wdetail.covcod      = "1" 
                    wdetail.si          = trim(wdetail2.ins_si) 
                    wdetail.prempa      = caps(trim(fi_pack))
                    /*wdetail.branch      = "M" */
                    wdetail.branch      = IF TRIM(wdetail2.branch) = "" THEN "M" ELSE TRIM(wdetail2.branch)
                    /*wdetail.benname     = "บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด"*//*A57-0010*/
                    /*wdetail.benname     = ""  /*A57-0010*/*/ /*a57-0226*/
                    wdetail.benname     = IF trim(wdetail2.prvpol) = "" THEN "บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด" ELSE "" /*a57-0226*/
                    wdetail.volprem     = trim(wdetail2.prem_vo)  
                    wdetail.comment     = ""
                    wdetail.agent       = trim(fi_agent)     
                    wdetail.producer    = trim(fi_producer)  
                    wdetail.entdat      = string(TODAY)              /*entry date*/
                    wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
                    wdetail.trandat     = STRING(TODAY)             /*tran date*/
                    wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
                    wdetail.n_IMPORT    = "IM"
                    wdetail.n_EXPORT    = "" 
                    wdetail.prvpol      = trim(wdetail2.prvpol)
                    /*wdetail.inscod      = wdetail2.typepay  */  
                    wdetail.cedpol      = trim(wdetail2.contractno)  
                    wdetail.sendnam     = trim(wdetail2.sendnam)  
                    wdetail.chkcar      = trim(wdetail2.chkcar)   
                    wdetail.telno       = trim(wdetail2.telno)
                    wdetail.prmtxt      = "" .
                IF  (wdetail2.np_f18line1 <> "") OR (wdetail2.np_f18line2 <> "") OR
                    (wdetail2.np_f18line3 <> "") OR (wdetail2.np_f18line4 <> "") OR
                    (wdetail2.np_f18line5 <> "")  THEN DO:
                    FIND LAST wdetmemo WHERE wdetmemo.policymemo = "0TL" + trim(wdetail2.contractno)  NO-ERROR NO-WAIT.
                    IF NOT AVAIL wdetmemo THEN DO:
                        CREATE wdetmemo.
                        ASSIGN 
                            wdetmemo.policymemo = "0TL" + trim(wdetail2.contractno) 
                            wdetmemo.f18line1   = wdetail2.np_f18line1 
                            wdetmemo.f18line2   = wdetail2.np_f18line2 
                            wdetmemo.f18line3   = wdetail2.np_f18line3 
                            wdetmemo.f18line4   = wdetail2.np_f18line4
                            wdetmemo.f18line5   = wdetail2.np_f18line5   .
                    END.
                END.
            END.  /* FIND FIRST wdetail */
        END.
        IF (wdetail2.sckno  <> "") AND (DECI(wdetail2.prem_72net) > 0 OR deci(wdetail2.prem_72) > 0 )  THEN DO:   /*create v72*/
            FIND FIRST wdetail WHERE wdetail.policy = trim(wdetail2.sckno) NO-ERROR NO-WAIT.
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN
                    wdetail.policy      = caps(trim(wdetail2.sckno))
                    wdetail.seat        = IF deci(wdetail2.prem_72) = 600 THEN "7"  ELSE "3"
                    wdetail.brand       = "ISUZU"
                    wdetail.poltyp      = "V72" 
                    wdetail.insrefno    = ""
                    wdetail.comdat      = substr(wdetail2.comdat,1,2) + "/" + substr(wdetail2.comdat,3,2) + "/" + substr(wdetail2.comdat,5,4)  
                    wdetail.expdat      = substr(wdetail2.expdat,1,2) + "/" + substr(wdetail2.expdat,3,2) + "/" + substr(wdetail2.expdat,5,4) 
                    /*wdetail.tiname      = trim(wdetail2.tiname)  
                    wdetail.insnam      = trim(wdetail2.insnam) */ 
                    wdetail.tiname      = trim(wdetail2.tiname)
                    wdetail.insnam      = trim(wdetail2.insnam) + " " + TRIM(wdetail2.insnam2)
                    wdetail.subclass    = IF deci(wdetail2.prem_72) = 600 THEN "110"  ELSE "210"
                    wdetail.model       = IF index(wdetail2.model,"TFR85HG") <> 0 THEN "MU-7" ELSE "D-MAX" 
                    wdetail.cc          = trim(wdetail2.cc) 
                    wdetail.caryear     = trim(wdetail2.caryear)
                    wdetail.chasno      = trim(wdetail2.chasno)
                    wdetail.vehreg      = trim(wdetail2.vehreg)
                    wdetail.engno       = trim(wdetail2.engno)
                    wdetail.iadd1       = trim(wdetail2.add1) 
                    wdetail.iadd2       = trim(wdetail2.add2) 
                    wdetail.iadd3       = trim(wdetail2.add3) 
                    wdetail.iadd4       = trim(wdetail2.add4) 
                    wdetail.vehuse      = "1"
                    wdetail.garage      = ""
                    /*wdetail.stk         = ""*//*A56-0217*/
                    wdetail.ICNO        = trim(wdetail2.ICNO)       /*A56-0217*/
                    wdetail.stk         = trim(wdetail2.scknumber)  /*A56-0217*/
                    wdetail.docno       = trim(wdetail2.docno)      /*A56-0217*/
                    wdetail.covcod      = "T" 
                    wdetail.si          = trim(wdetail2.ins_si) 
                    wdetail.prempa      = trim(fi_pack)
                    wdetail.branch      = "M" 
                    /*wdetail.benname     = "บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด"*//*A57-0010*/
                    wdetail.benname     = ""  /*A57-0010*/
                    /*wdetail.volprem     = wdetail2.ref_no *//*A56-0217*/
                    wdetail.comment     = ""
                    wdetail.agent       = trim(fi_agent)     
                    wdetail.producer    = trim(fi_producer)  
                    wdetail.entdat      = string(TODAY)              /*entry date*/
                    wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
                    wdetail.trandat     = STRING(TODAY)             /*tran date*/
                    wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
                    wdetail.n_IMPORT    = "IM"
                    wdetail.n_EXPORT    = "" 
                    /*wdetail.inscod      = wdetail2.typepay  */  
                    wdetail.cedpol      = trim(wdetail2.contractno)  
                    wdetail.sendnam     = trim(wdetail2.sendnam)  
                    wdetail.chkcar      = trim(wdetail2.chkcar)   
                    wdetail.telno       = trim(wdetail2.telno)  
                    wdetail.prmtxt      = "" .
            END.
        END.  /* stk */
    END.
END.
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
FIND FIRST wdetail WHERE wdetail.policy = trim(wdetail2.sckno) NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN
        wdetail.policy      = caps(trim(wdetail2.sckno))
        wdetail.seat        = IF deci(wdetail2.prem_72) = 600 THEN "7"  ELSE "3"
        wdetail.brand       = "ISUZU"
        wdetail.poltyp      = "V72" 
        wdetail.insrefno    = ""
        wdetail.comdat      = substr(wdetail2.comdat,1,2) + "/" + substr(wdetail2.comdat,3,2) + "/" + substr(wdetail2.comdat,5,4)  
        wdetail.expdat      = substr(wdetail2.expdat,1,2) + "/" + substr(wdetail2.expdat,3,2) + "/" + substr(wdetail2.expdat,5,4) 
        /*wdetail.tiname      = wdetail2.tiname  /*A56-0262*/
        wdetail.insnam      = wdetail2.insnam*/  /*A56-0262*/
        wdetail.tiname      = trim(wdetail2.tiname)
        wdetail.insnam      = trim(wdetail2.insnam) + " " + TRIM(wdetail2.insnam2)
        wdetail.subclass    = IF deci(wdetail2.prem_72) = 600 THEN "110"  ELSE "210"
        wdetail.model       = IF index(wdetail2.model,"TFR85HG") <> 0 THEN "MU-7" ELSE "D-MAX" 
        wdetail.cc          = trim(wdetail2.cc) 
        wdetail.caryear     = trim(wdetail2.caryear)
        wdetail.chasno      = trim(wdetail2.chasno)
        wdetail.vehreg      = trim(wdetail2.vehreg)
        wdetail.engno       = trim(wdetail2.engno)
        wdetail.iadd1       = trim(wdetail2.add1) 
        wdetail.iadd2       = trim(wdetail2.add2) 
        wdetail.iadd3       = trim(wdetail2.add3) 
        wdetail.iadd4       = trim(wdetail2.add4) 
        wdetail.vehuse      = "1"
        wdetail.garage      = ""
        wdetail.ICNO        = trim(wdetail2.ICNO)       /*A56-0217*/
        wdetail.stk         = trim(wdetail2.scknumber)  /*A56-0217*/
        wdetail.docno       = trim(wdetail2.docno)      /*A56-0217*/
        wdetail.covcod      = "T" 
        wdetail.instyp      = trim(wdetail2.instyp)     /*A57-0302*/
        wdetail.si          = trim(wdetail2.ins_si) 
        wdetail.prempa      = trim(fi_pack)
        wdetail.branch      = "M" 
        /*wdetail.benname     = "บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด"*//*A57-0010*/
        wdetail.benname     = ""  /*A57-0010*/
        /*wdetail.volprem     = wdetail2.ref_no *//*A56-0217*/
        wdetail.comment     = ""
        wdetail.agent       = trim(fi_agent72)     
        wdetail.producer    = trim(fi_producer72)
        wdetail.entdat      = string(TODAY)             /*entry date*/
        wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
        wdetail.trandat     = STRING(TODAY)             /*tran date*/
        wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
        wdetail.n_IMPORT    = "IM"
        wdetail.n_EXPORT    = "" 
        /*wdetail.inscod      = wdetail2.typepay  */  
        wdetail.cedpol      = trim(wdetail2.contractno)  
        wdetail.sendnam     = trim(wdetail2.sendnam)  
        wdetail.chkcar      = trim(wdetail2.chkcar)   
        wdetail.telno       = trim(wdetail2.telno)  
        wdetail.prmtxt      = "" .
END.                          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign3_72no70 c-Win 
PROCEDURE proc_assign3_72no70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail2.sckno <> ""  THEN DO:   /*create v72*/
    FIND FIRST wdetail WHERE wdetail.policy = trim(wdetail2.sckno) NO-ERROR NO-WAIT.
    IF NOT AVAIL wdetail THEN DO:
        CREATE wdetail.
        ASSIGN
            wdetail.policy    = caps(trim(wdetail2.sckno))
            wdetail.seat      = IF deci(wdetail2.prem_72) = 600 THEN "7"  ELSE "3"
            wdetail.brand     = "ISUZU"
            wdetail.poltyp    = "V72" 
            wdetail.insrefno  = ""
            wdetail.comdat    = substr(wdetail2.comdat,1,2) + "/" + substr(wdetail2.comdat,3,2) + "/" + substr(wdetail2.comdat,5,4)  
            wdetail.expdat    = substr(wdetail2.expdat,1,2) + "/" + substr(wdetail2.expdat,3,2) + "/" + substr(wdetail2.expdat,5,4) 
            /*wdetail.tiname    = trim(wdetail2.tiname)  
            wdetail.insnam    = trim(wdetail2.insnam)*/  
            wdetail.tiname    = trim(wdetail2.tiname)
            wdetail.insnam    = trim(wdetail2.insnam) + " " + TRIM(wdetail2.insnam2)
            wdetail.subclass  = IF deci(wdetail2.prem_72) = 600 THEN "110"  ELSE "210"
            wdetail.model     = IF index(wdetail2.model,"TFR85HG") <> 0 THEN "MU-7" ELSE "D-MAX" 
            wdetail.cc        = trim(wdetail2.cc) 
            wdetail.caryear   = trim(wdetail2.caryear)
            wdetail.chasno    = trim(wdetail2.chasno)
            wdetail.vehreg    = trim(wdetail2.vehreg)
            wdetail.engno     = trim(wdetail2.engno)
            wdetail.iadd1     = trim(wdetail2.add1) 
            wdetail.iadd2     = trim(wdetail2.add2) 
            wdetail.iadd3     = trim(wdetail2.add3) 
            wdetail.iadd4     = trim(wdetail2.add4) 
            wdetail.vehuse    = "1"
            wdetail.garage    = ""
            /*wdetail.stk       = ""*/              /*A56-0217*/
            wdetail.ICNO      = trim(wdetail2.ICNO)       /*A56-0217*/
            wdetail.stk       = trim(wdetail2.scknumber)  /*A56-0217*/
            wdetail.docno     = trim(wdetail2.docno)      /*A56-0217*/
            wdetail.covcod    = "T" 
            wdetail.si        = trim(wdetail2.ins_si) 
            wdetail.prempa    = trim(fi_pack)
            wdetail.branch    = "M" 
            /*wdetail.benname     = "บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด"*//*A57-0010*/
            wdetail.benname     = ""  /*A57-0010*/
            /*wdetail.volprem   = wdetail2.ref_no *//*A56-0217*/
            wdetail.comment   = ""
            wdetail.agent     = trim(fi_agent)     
            wdetail.producer  = trim(fi_producer)  
            wdetail.entdat    = string(TODAY)              /*entry date*/
            wdetail.enttim    = STRING(TIME, "HH:MM:SS")  /*entry time*/
            wdetail.trandat   = STRING(TODAY)             /*tran date*/
            wdetail.trantim   = STRING(TIME, "HH:MM:SS")  /*tran time*/
            wdetail.n_IMPORT  = "IM"
            wdetail.n_EXPORT  = "" 
            /*wdetail.inscod    = wdetail2.typepay  */  
            wdetail.cedpol    = trim(wdetail2.contractno)  
            wdetail.sendnam   = trim(wdetail2.sendnam)  
            wdetail.chkcar    = trim(wdetail2.chkcar)   
            wdetail.telno     = trim(wdetail2.telno) 
            wdetail.prmtxt    = "" .
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
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    np_class72          = ""
    np_number           = ""       
   np_Contract_No       = ""     
   np_Ref_no            = ""          
   np_comdat            = ""          
   np_expdat            = ""          
   np_ntitle            = ""          
   np_insurce           = ""          
   np_Surename          = ""         
   np_Contact_Address   = ""       
   np_Sub_District      = ""       
   np_District          = ""       
   np_Province          = ""       
   np_Postcode          = ""       
   np_Landmark          = ""       
   np_Brand             = ""       
   np_nColor            = ""       
   np_model             = ""       
   np_License           = ""       
   np_Li_Province       = ""       
   np_Chassis           = ""       
   np_Engine            = ""       
   np_model_year        = ""       
   np_cc                = ""       
   np_Weight            = ""       
   np_finance_Comp      = ""       
   np_Insurance_Type    = ""       
   np_Insured_Amount    = ""       
   np_Voluntary         = ""       
   np_Compulsory        = ""       
   np_nTotal            = ""       
   np_Request_Date      = ""       
   np_companyins        = ""       
   np_policy72          = ""       
   np_stk72             = ""       
   np_docno72           = ""       
   np_comdat72          = ""       
   np_expdat72          = ""       
   np_prepol            = ""       
   np_notino            = "" 
   np_packclass         = ""  
   np_seate72           = ""
   np_seate             = ""  
   np_remark            = ""       
   np_icno              = ""       
   np_sendContact_Addr  = ""       
   np_sendSub_District  = ""       
   np_sendDistrict      = ""       
   np_sendProvince      = ""       
   np_sendPostcode      = ""  
   np_f18line1          = ""  
   np_f18line2          = ""  
   np_f18line3          = ""  
   np_f18line4          = ""   
   np_f18line5          = ""  .
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
DEF VAR NEW_si    AS CHAR INIT "" .
ASSIGN NEW_si =  wdetail.si .
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    /*comment by Kridtiya i. A56-0217...
    RUN wgw\wgwtsexp (INPUT-OUTPUT wdetail.prvpol,       
                      INPUT-OUTPUT wdetail.branch,         
                      INPUT-OUTPUT n_firstdat,              
                      INPUT-OUTPUT wdetail.subclass,               
                      INPUT-OUTPUT wdetail.redbook,           
                      INPUT-OUTPUT wdetail.vehuse,           
                      INPUT-OUTPUT wdetail.covcod,          
                      INPUT-OUTPUT wdetail.seat,                             
                      INPUT-OUTPUT nv_basere,                              
                      INPUT-OUTPUT dod1,                                
                      INPUT-OUTPUT dod2,                               
                      INPUT-OUTPUT dod0,                                  
                      INPUT-OUTPUT nv_flet_per,                        
                      INPUT-OUTPUT wdetail.NCB, 
                      INPUT-OUTPUT nv_dss_per,
                      INPUT-OUTPUT nv_cl_per).
                      end..by Kridtiya i. A56-0217...*/
    /*by Kridtiya i. A56-0217..*/
    RUN wgw\wgwtsexp (INPUT-OUTPUT wdetail.prvpol,   /*n_prepol  */ 
                      INPUT-OUTPUT wdetail.branch,   /*n_branch  */ 
                      INPUT-OUTPUT wdetail.insrefno,
                      INPUT-OUTPUT nv_deler,
                      INPUT-OUTPUT wdetail.prempa,   /*n_prempa  */  
                      INPUT-OUTPUT wdetail.subclass, /*n_subclass*/  
                      INPUT-OUTPUT wdetail.redbook,  /*n_redbook */  
                      INPUT-OUTPUT wdetail.brand,    /*n_brand   */  
                      INPUT-OUTPUT wdetail.model,    /*n_model   */  
                      INPUT-OUTPUT wdetail.caryear,  /*n_caryear */
                      INPUT-OUTPUT wdetail.cargrp,   /*n_cargrp  */  
                      INPUT-OUTPUT wdetail.cc,  
                      INPUT-OUTPUT nv_tons, 
                      INPUT-OUTPUT wdetail.body,
                      INPUT-OUTPUT wdetail.vehuse,   /*n_vehuse  */  
                      INPUT-OUTPUT wdetail.covcod,   /*n_covcod  */  
                      INPUT-OUTPUT wdetail.garage,   /*n_garage  */    
                      INPUT-OUTPUT nv_uom1_v,        /*n_tp1     */  
                      INPUT-OUTPUT nv_uom2_v,        /*n_tp2     */  
                      INPUT-OUTPUT nv_uom5_v,        /*n_tp3     */  
                      INPUT-OUTPUT wdetail.si,
                      INPUT-OUTPUT nv_basere,        /*nv_basere */  
                      INPUT-OUTPUT wdetail.seat,     /* DECI     n_seat     */  
                      INPUT-OUTPUT wdetail.seat41,   /* INTE     */    
                      INPUT-OUTPUT nv_41,            /* INTE     n_41       */  
                      INPUT-OUTPUT nv_42,            /* DECI     n_42       */  
                      INPUT-OUTPUT nv_43,            /* DECI     n_43       */  
                      INPUT-OUTPUT dod1,             /* DECI     n_dod      */  
                      INPUT-OUTPUT dod2,             /* DECI     n_dod2     */
                      INPUT-OUTPUT dod0,             /* DECI     n_pd       */  
                      INPUT-OUTPUT wdetail.fleet,    /*n DECI    _feet     */  
                      INPUT-OUTPUT nv_dss_per,       /* DECI     nv_dss_per */  
                      INPUT-OUTPUT WDETAIL.NCB,      /* DECI     n_ncb      */  
                      INPUT-OUTPUT nv_cl_per,        /* DECI     n_lcd      */  
                      INPUT-OUTPUT n_firstdat,
                      INPUT-OUTPUT wdetail.benname,  /* A57-0010 */
                      INPUT-OUTPUT wdetail.prmtxt,   /* A57-0010 */
                      INPUT-OUTPUT nv_driver).       /* A57-0010 */
    /*by Kridtiya i. A56-0217..*/
END.
IF deci(NEW_si) <> deci(wdetail.si)  THEN  ASSIGN wdetail.si =  NEW_si  .
/*wdetail.prempa = "V".
IF wdetail.subclass = "210" THEN 
    ASSIGN wdetail.seat = "3"
    wdetail.seat41 = 3.
ELSE ASSIGN wdetail.seat = "7"
    wdetail.seat41 = 7.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_back c-Win 
PROCEDURE proc_assign_back :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN nv_daily  =  "".
    nv_reccnt  =  0.
FOR EACH wdetail2:
    DELETE  wdetail2.
END.
FOR EACH wdetail:
    DELETE  wdetail.
END.
INPUT FROM VALUE (fi_filename) .
REPEAT:
    IMPORT UNFORMATTED nv_daily.
    IF  nv_daily  <>  ""  And  Substr(nv_daily,1,1)  =  "D"  THEN DO:
        CREATE  wdetail2.
        ASSIGN 
            wdetail2.policy      = TRIM(SUBSTR(nv_daily,393,26))                                                     /*1 Header Record "D"*/                   
            wdetail2.contractno  = TRIM(SUBSTR(nv_daily,2,10))       /*2 Contract Number  */                              
            wdetail2.insnam      = TRIM(SUBSTR(nv_daily,12,60))      /*3 ชื่อผู้เอาประกัน*/                               
            wdetail2.address     = TRIM(SUBSTR(nv_daily,72,160))     /*4 ที่อยู่ผู้เอาประกัน1/สำหรับส่งเอกสาร*/           
            wdetail2.brand       = TRIM(SUBSTR(nv_daily,232,16))     /*5 Car brand code*/                    
            wdetail2.model       = TRIM(SUBSTR(nv_daily,248,16))     /*6 HILUX,SOLUNA*/                                   
            wdetail2.caryear     = TRIM(SUBSTR(nv_daily,264,4))      /*7 Year of car */                                   
            /*wdetail2.colorcode = TRIM(SUBSTR(nv_daily,268,16)) */  /*8 Color Code*/                                       
            wdetail2.cc          = TRIM(SUBSTR(nv_daily,284,4))      /*9 CC/WEIGHT KG/TON*/                               
            wdetail2.engno       = TRIM(SUBSTR(nv_daily,288,26))     /*10หมายเลขเครื่องยนต์*/                             
            wdetail2.chasno      = TRIM(SUBSTR(nv_daily,314,26))     /*11หมายเลขตัวถังรถ*/                                
            wdetail2.vehreg      = TRIM(SUBSTR(nv_daily,340,12))     /*12หมายเลขทะเบียนรถ */                              
            wdetail2.province    = "TIL" + TRIM(SUBSTR(nv_daily,352,20))     /*13จังหวัดที่จดทะเบียนรถ*/                          
            /*wdetail2.comp_code = TRIM(SUBSTR(nv_daily,372,5))*/    /*14รหัส บ.ประกันภัย(TLT.COMMENT)*/                    
            wdetail2.comdat      = TRIM(SUBSTR(nv_daily,377,8))      /*15วันที่ตกลงรับประกัน */                           
            wdetail2.expdat      = TRIM(SUBSTR(nv_daily,385,8))      /*16วันทีสิ้นสุดความคุ้มครอง */                      
            wdetail2.prvpol      = TRIM(SUBSTR(nv_daily,393,26))     /*17เลขที่กรมธรรม์ */                                
            wdetail2.ins_amt     = TRIM(SUBSTR(nv_daily,419,12))     /*18เลขที่กรมธรรม์ */                                
            wdetail2.prem_vo     = TRIM(SUBSTR(nv_daily,431,12))     /*19ค่าเบี้ยป.1 + ภาษี + อากร */                     
            wdetail2.sckno       = TRIM(SUBSTR(nv_daily,443,26))     /*20เลขที่กรมธรรม์พรบ. */                            
            wdetail2.prem_72     = TRIM(SUBSTR(nv_daily,469,12))     /*21เบี้ย พรบ. */                                    
            wdetail2.mail        = TRIM(SUBSTR(nv_daily,481,160))
            wdetail2.ref_no      = TRIM(SUBSTR(nv_daily,641,15))
            wdetail2.temp        = TRIM(SUBSTR(nv_daily,656,16))  .
                                   
        IF wdetail2.prem_72 <> "" THEN DO:
            CREATE  wdetail2.
            ASSIGN 
                wdetail2.policy      = TRIM(SUBSTR(nv_daily,443,26))                                                   /*1 Header Record "D"*/                   
                wdetail2.contractno  = TRIM(SUBSTR(nv_daily,2,10))      /*2 Contract Number  */                              
                wdetail2.insnam      = TRIM(SUBSTR(nv_daily,12,60))     /*3 ชื่อผู้เอาประกัน*/                               
                wdetail2.address     = TRIM(SUBSTR(nv_daily,72,160))    /*4 ที่อยู่ผู้เอาประกัน1/สำหรับส่งเอกสาร*/           
                wdetail2.brand       = TRIM(SUBSTR(nv_daily,232,16))    /*5 Car brand code*/                    
                wdetail2.model       = TRIM(SUBSTR(nv_daily,248,16))    /*6 HILUX,SOLUNA*/                                   
                wdetail2.caryear     = TRIM(SUBSTR(nv_daily,264,4))     /*7 Year of car */                                   
                wdetail2.cc          = TRIM(SUBSTR(nv_daily,284,4))     /*9 CC/WEIGHT KG/TON*/                               
                wdetail2.engno       = TRIM(SUBSTR(nv_daily,288,26))    /*10หมายเลขเครื่องยนต์*/                             
                wdetail2.chasno      = TRIM(SUBSTR(nv_daily,314,26))    /*11หมายเลขตัวถังรถ*/                                
                wdetail2.vehreg      = TRIM(SUBSTR(nv_daily,340,12))    /*12หมายเลขทะเบียนรถ */                              
                wdetail2.province    = "TIL" + TRIM(SUBSTR(nv_daily,352,20))    /*13จังหวัดที่จดทะเบียนรถ*/                          
                wdetail2.comdat      = TRIM(SUBSTR(nv_daily,377,8))     /*15วันที่ตกลงรับประกัน */                           
                wdetail2.expdat      = TRIM(SUBSTR(nv_daily,385,8))     /*16วันทีสิ้นสุดความคุ้มครอง */                      
                wdetail2.prvpol      = TRIM(SUBSTR(nv_daily,393,26))    /*17เลขที่กรมธรรม์ */                                
                wdetail2.ins_amt     = TRIM(SUBSTR(nv_daily,419,12))    /*18เลขที่กรมธรรม์ */                                
                wdetail2.prem_vo     = TRIM(SUBSTR(nv_daily,431,12))    /*19ค่าเบี้ยป.1 + ภาษี + อากร */                     
                wdetail2.sckno       = TRIM(SUBSTR(nv_daily,443,26))    /*20เลขที่กรมธรรม์พรบ. */                            
                wdetail2.prem_72     = TRIM(SUBSTR(nv_daily,469,12))    /*21เบี้ย พรบ. */                                    
                wdetail2.mail        = TRIM(SUBSTR(nv_daily,481,160))
                wdetail2.ref_no      = TRIM(SUBSTR(nv_daily,641,15))
                wdetail2.temp        = TRIM(SUBSTR(nv_daily,656,16))  .                                
        END.

    END. 
END. /*-Repeat-*/       
/*RUN proc_assign2.    */   
RUN proc_assign3.   
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_nontil c-Win 
PROCEDURE proc_assign_nontil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO: 
    For each  wdetail :                              
        DELETE  wdetail.                             
    END.
    RUN proc_assigninit.
    INPUT FROM VALUE (fi_filename) .                                   
    REPEAT:     
        IMPORT DELIMITER "|" 
            np_number                           
            np_Contract_No      
            np_Ref_no           
            np_comdat           
            np_expdat           
            np_ntitle             
            np_insurce            
            np_Surename           
            np_Contact_Address    
            np_Sub_District       
            np_District           
            np_Province           
            np_Postcode           
            np_Landmark           
            np_Brand              
            np_nColor             
            np_model              
            np_License            
            np_Li_Province        
            np_Chassis            
            np_Engine             
            np_model_year         
            np_cc                 
            np_Weight             
            np_finance_Comp       
            np_Insurance_Type  
            np_Insured_Amount  
            np_netVol          
            np_Voluntary       
            np_netCompul       
            np_Compulsory      
            np_nTotal          
            np_Request_Date    
            np_companyins      
            np_policy72        
            np_class72          
            np_seate72          
            np_stk72            
            np_docno72          
            np_comdat72         
            np_expdat72         
            np_prepol  
            np_notino                
            np_packclass              
            np_seate                  
            np_remark                 
            np_icno                   
            np_sendContact_Addr       
            np_sendSub_District       
            np_sendDistrict           
            np_sendProvince           
            np_sendPostcode           
            np_f18line1               
            np_f18line2               
            np_f18line3               
            np_f18line4 
            np_f18line5 . 
        IF       index(np_number,"no.") <> 0  THEN RUN proc_assigninit.
        ELSE IF        np_number   = ""       THEN RUN proc_assigninit.
        ELSE DO:
            /*IF TRIM(np_Contract_No) <> "" THEN DO:*//*A57-0266 เช็คเบี้ย = 0 ไม่นำเข้าระบบ*/
            IF (DECI(np_netVol) <> 0 ) AND (TRIM(np_netVol) <> "" )  THEN DO:  /*A57-0266 เช็คเบี้ย = 0 ไม่นำเข้าระบบ*/
                IF np_notino <> "" THEN RUN proc_cutpolnoti.
                FIND FIRST wdetail WHERE wdetail.policy = "0" + TRIM(np_Contract_No)  NO-ERROR NO-WAIT.
                IF NOT AVAIL wdetail THEN DO:
                    CREATE wdetail.
                    ASSIGN
                        wdetail.policy      = "0" + TRIM(np_Contract_No)
                        wdetail.cedpol      = trim(np_Contract_No) 
                        wdetail.poltyp      = "V70" 
                        wdetail.comdat      = trim(np_comdat)    
                        wdetail.expdat      = trim(np_expdat) 
                        wdetail.insrefno    = ""
                        wdetail.tiname      = trim(np_ntitle)    
                        wdetail.insnam      = trim(np_insurce) + " " + TRIM(np_Surename)
                        wdetail.insnam2     = ""
                        wdetail.brand       = trim(np_Brand)  
                        wdetail.model       = TRIM(np_model) 
                        wdetail.vehreg      = trim(np_License) + " " + TRIM(np_Li_Province)
                        wdetail.chasno      = trim(np_Chassis)
                        wdetail.engno       = trim(np_Engine)
                        wdetail.caryear     = trim(np_model_year)  
                        wdetail.cc          = trim(np_cc)          
                        wdetail.weight      = trim(np_Weight) 
                        wdetail.benname     = trim(np_finance_Comp)  
                        wdetail.prmtxt      = ""
                        wdetail.covcod      = IF      index(np_Insurance_Type,"ประเภท 1") <> 0 THEN "1"
                                              ELSE IF index(np_Insurance_Type,"ประเภท 2") <> 0 THEN "2"
                                              ELSE IF index(np_Insurance_Type,"ประเภท 3") <> 0 THEN "3"
                                              ELSE "1"
                        wdetail.si          = trim(np_Insured_Amount) 
                        wdetail.volprem     = trim(np_Voluntary)      
                        wdetail.Compprem    = trim(np_Compulsory) 
                        wdetail.prvpol      = trim(np_prepol) 
                                                  /*np_remark */         
                        wdetail.ICNO        = trim(np_icno)            
                        wdetail.iadd1       = trim(np_sendContact_Addr)  
                        wdetail.iadd2       = IF      index(trim(np_sendProvince),"กรุง") <> 0 THEN "แขวง" + trim(np_sendSub_District)
                                              ELSE IF index(trim(np_sendProvince),"กทม")  <> 0 THEN "แขวง" + trim(np_sendSub_District)
                                              ELSE "ตำบล"                                                  + trim(np_sendSub_District)
                        wdetail.iadd3       = IF      index(trim(np_sendProvince),"กรุง") <> 0 THEN "เขต"  + trim(np_sendDistrict)  
                                              ELSE IF index(trim(np_sendProvince),"กทม")  <> 0 THEN "เขต"  + trim(np_sendDistrict)
                                              ELSE "อำเภอ"                                                 + trim(np_sendDistrict)
                        wdetail.iadd4       = IF      index(trim(np_sendProvince),"กรุง") <> 0 THEN trim(np_sendProvince) + " " + trim(np_sendPostcode) 
                                              ELSE IF index(trim(np_sendProvince),"กทม")  <> 0 THEN trim(np_sendProvince) + " " + trim(np_sendPostcode) 
                                              ELSE "จังหวัด" + trim(np_sendProvince) + " " + trim(np_sendPostcode) 
                        wdetail.prempa      = IF trim(np_packclass) = "" THEN "" ELSE SUBSTR(trim(np_packclass),1,1)
                        wdetail.subclass    = IF trim(np_packclass) = "" THEN "" ELSE SUBSTR(trim(np_packclass),2,3) 
                        wdetail.seat        = IF (trim(np_seate) = "") OR (deci(trim(np_seate)) = 0 ) THEN "0" ELSE  trim(np_seate) 
                        wdetail.vehuse      = "1"
                        wdetail.garage      = ""
                        wdetail.stk         = ""
                        wdetail.branch      = "M"   /*สาขา โอนย้าย = M ,ต่ออายุ ตามกรมธรรม์ เดิม */
                        wdetail.comment     = ""
                        wdetail.producer    = trim(fi_producer) 
                        wdetail.agent       = trim(fi_agent)  
                        wdetail.entdat      = string(TODAY)             /*entry date*/
                        wdetail.enttim      = STRING(TIME, "HH:MM:SS")  /*entry time*/
                        wdetail.trandat     = STRING(TODAY)             /*tran date*/
                        wdetail.trantim     = STRING(TIME, "HH:MM:SS")  /*tran time*/
                        wdetail.n_IMPORT    = "IM"
                        wdetail.n_EXPORT    = "" 
                        wdetail.pass        = "y".
                    IF  (np_f18line1 <> "") OR (np_f18line2 <> "") OR  (np_f18line3 <> "") OR
                        (np_f18line4 <> "") OR (np_f18line5 <> "")  THEN DO:
                        FIND LAST wdetmemo WHERE wdetmemo.policymemo = "0" + TRIM(np_Contract_No)  NO-ERROR NO-WAIT.
                        IF NOT AVAIL wdetmemo THEN DO:
                            CREATE wdetmemo.
                            ASSIGN 
                                wdetmemo.policymemo = trim(wdetail.policy)
                                wdetmemo.f18line1   = trim(np_f18line1)
                                wdetmemo.f18line2   = trim(np_f18line2)
                                wdetmemo.f18line3   = trim(np_f18line3)
                                wdetmemo.f18line4   = trim(np_f18line4)
                                wdetmemo.f18line5   = trim(np_f18line5)   .
                        END.
                    END.
                    IF trim(np_ntitle) = " " THEN 
                        ASSIGN 
                        wdetail.insnam   = trim(np_insurce) + " " + TRIM(np_Surename)
                        wdetail.insnam2  = "".
                    ELSE IF R-INDEX(trim(np_ntitle),"จก.")             <> 0  OR  
                            R-INDEX(trim(np_ntitle),"จำกัด")           <> 0  OR  
                            R-INDEX(trim(np_ntitle),"(มหาชน)")         <> 0  OR  
                            R-INDEX(trim(np_ntitle),"INC.")            <> 0  OR 
                            R-INDEX(trim(np_ntitle),"CO.")             <> 0  OR 
                            R-INDEX(trim(np_ntitle),"LTD.")            <> 0  OR 
                            R-INDEX(trim(np_ntitle),"LIMITED")         <> 0  OR 
                            INDEX(trim(np_ntitle),"บริษัท")            <> 0  OR 
                            INDEX(trim(np_ntitle),"บ.")                <> 0  OR 
                            INDEX(trim(np_ntitle),"บจก.")              <> 0  OR 
                            INDEX(trim(np_ntitle),"หจก.")              <> 0  OR 
                            INDEX(trim(np_ntitle),"หสน.")              <> 0  OR 
                            INDEX(trim(np_ntitle),"บรรษัท")            <> 0  OR 
                            INDEX(trim(np_ntitle),"มูลนิธิ")           <> 0  OR 
                            INDEX(trim(np_ntitle),"ห้าง")              <> 0  OR 
                            INDEX(trim(np_ntitle),"ห้างหุ้นส่วน")      <> 0  OR 
                            INDEX(trim(np_ntitle),"ห้างหุ้นส่วนจำกัด") <> 0  OR
                            INDEX(trim(np_ntitle),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                            INDEX(trim(np_ntitle),"และ/หรือ")          <> 0  THEN 
                        ASSIGN 
                        wdetail.insnam  = trim(np_insurce)  
                        wdetail.insnam2 = "(" + TRIM(np_Surename) + ")".
                    ELSE ASSIGN 
                        wdetail.insnam  = trim(np_insurce) + " " + TRIM(np_Surename)
                        wdetail.insnam2 = "".
                END. /*end. wdetail....*/
            END.  /*np_Contract_No <> ""*/
            IF       trim(np_policy72) = "" THEN RUN proc_assigninit. 
            ELSE IF (index(trim(np_policy72),"ไม่ซื้อพรบ") <> 0 ) THEN RUN proc_assigninit.  
            ELSE DO:   /*create v72*/
                    FIND FIRST wdetail WHERE wdetail.policy = trim(np_policy72) NO-ERROR NO-WAIT.
                    IF NOT AVAIL wdetail THEN DO:
                        CREATE wdetail.
                        ASSIGN
                            wdetail.policy   = trim(np_policy72)
                            wdetail.stk      = trim(np_stk72)   
                            wdetail.docno    = trim(np_docno72) 
                            wdetail.cedpol   = trim(np_Contract_No) 
                            wdetail.poltyp   = "V72" 
                            wdetail.comdat   = trim(np_comdat72)
                            wdetail.expdat   = trim(np_expdat72)
                            wdetail.insrefno = ""
                            wdetail.tiname   = trim(np_ntitle)  
                            wdetail.insnam   = trim(np_insurce) + " " + TRIM(np_Surename)
                            wdetail.insnam2  = ""
                            wdetail.brand    = trim(np_Brand)  
                            wdetail.model    = TRIM(np_model) 
                            wdetail.vehreg   = trim(np_License) + " " + TRIM(np_Li_Province)
                            wdetail.chasno   = trim(np_Chassis)
                            wdetail.engno    = trim(np_Engine)
                            wdetail.caryear  = trim(np_model_year)  
                            wdetail.cc       = trim(np_cc)          
                            wdetail.weight   = trim(np_Weight) 
                            wdetail.benname  = ""    /*trim(np_finance_Comp) */  
                            wdetail.prmtxt   = ""
                            wdetail.covcod   = "T"
                            wdetail.si       = trim(np_Insured_Amount) 
                            wdetail.volprem  = trim(np_Voluntary)      
                            wdetail.Compprem = trim(np_Compulsory) 
                            wdetail.prvpol   = ""
                                         /*np_remark */  
                            wdetail.ICNO     = trim(np_icno)            
                            wdetail.iadd1    = trim(np_sendContact_Addr)  
                            wdetail.iadd2    = IF      index(trim(np_sendProvince),"กรุง") <> 0 THEN "แขวง" + trim(np_sendSub_District)
                                               ELSE IF index(trim(np_sendProvince),"กทม")  <> 0 THEN "แขวง" + trim(np_sendSub_District)
                                               ELSE "ตำบล"                                                  + trim(np_sendSub_District)
                            wdetail.iadd3    = IF      index(trim(np_sendProvince),"กรุง") <> 0 THEN "เขต"  + trim(np_sendDistrict)  
                                               ELSE IF index(trim(np_sendProvince),"กทม")  <> 0 THEN "เขต"  + trim(np_sendDistrict)
                                               ELSE "อำเภอ"                                                 + trim(np_sendDistrict)
                            wdetail.iadd4    = IF      index(trim(np_sendProvince),"กรุง") <> 0 THEN trim(np_sendProvince) + " " + trim(np_sendPostcode) 
                                               ELSE IF index(trim(np_sendProvince),"กทม")  <> 0 THEN trim(np_sendProvince) + " " + trim(np_sendPostcode) 
                                               ELSE "จังหวัด" + trim(np_sendProvince) + " " + trim(np_sendPostcode) 
                            wdetail.prempa   = "" 
                            wdetail.subclass = trim(np_class72)  
                            wdetail.seat     = IF (trim(np_seate72) = "") OR (deci(trim(np_seate72)) = 0 ) THEN "0" ELSE  trim(np_seate72)    
                            wdetail.vehuse   = "1"
                            wdetail.garage   = ""
                            wdetail.branch   = "M"
                            wdetail.comment  = ""
                            wdetail.producer = trim(fi_producer) 
                            wdetail.agent    = trim(fi_agent)  
                            wdetail.entdat   = string(TODAY)             /*entry date*/
                            wdetail.enttim   = STRING(TIME, "HH:MM:SS")  /*entry time*/
                            wdetail.trandat  = STRING(TODAY)             /*tran date*/
                            wdetail.trantim  = STRING(TIME, "HH:MM:SS")  /*tran time*/
                            wdetail.n_IMPORT = "IM"
                            wdetail.n_EXPORT = "" 
                            wdetail.pass     = "y".
                            /*wdetail.f18line1 = ""   
                            wdetail.f18line2 = ""   
                            wdetail.f18line3 = ""   
                            wdetail.f18line4 = "" . */
                        IF trim(np_ntitle) = " " THEN 
                            ASSIGN wdetail.insnam      = trim(np_insurce) + " " + TRIM(np_Surename)
                            wdetail.insnam2     = "".
                        ELSE IF R-INDEX(trim(np_ntitle),"จก.")             <> 0  OR  
                                R-INDEX(trim(np_ntitle),"จำกัด")           <> 0  OR  
                                R-INDEX(trim(np_ntitle),"(มหาชน)")         <> 0  OR  
                                R-INDEX(trim(np_ntitle),"INC.")            <> 0  OR 
                                R-INDEX(trim(np_ntitle),"CO.")             <> 0  OR 
                                R-INDEX(trim(np_ntitle),"LTD.")            <> 0  OR 
                                R-INDEX(trim(np_ntitle),"LIMITED")         <> 0  OR 
                                INDEX(trim(np_ntitle),"บริษัท")            <> 0  OR 
                                INDEX(trim(np_ntitle),"บ.")                <> 0  OR 
                                INDEX(trim(np_ntitle),"บจก.")              <> 0  OR 
                                INDEX(trim(np_ntitle),"หจก.")              <> 0  OR 
                                INDEX(trim(np_ntitle),"หสน.")              <> 0  OR 
                                INDEX(trim(np_ntitle),"บรรษัท")            <> 0  OR 
                                INDEX(trim(np_ntitle),"มูลนิธิ")           <> 0  OR 
                                INDEX(trim(np_ntitle),"ห้าง")              <> 0  OR 
                                INDEX(trim(np_ntitle),"ห้างหุ้นส่วน")      <> 0  OR 
                                INDEX(trim(np_ntitle),"ห้างหุ้นส่วนจำกัด") <> 0  OR
                                INDEX(trim(np_ntitle),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                                INDEX(trim(np_ntitle),"และ/หรือ")          <> 0  THEN 
                            ASSIGN wdetail.insnam  = trim(np_insurce)  
                            wdetail.insnam2        = "(" + TRIM(np_Surename) + ")".
                        ELSE ASSIGN wdetail.insnam = trim(np_insurce) + " " + TRIM(np_Surename)
                            wdetail.insnam2     = "".
                    END. 
            END. 
            RUN proc_assigninit.
        END.
    END.   /* repeat   */
END.   /*-Repeat-*/  
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
        RUN wgs\wgsfbas.
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
    /*IF wdetail.prvpol <> "" THEN  ASSIGN  nv_41 = n_41  /*ต่ออายุ*/
                                          nv_42 = n_42
                                          nv_43 = n_43 .*/
       
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
     /*nv_cl_per  = deci(wdetail.loadclm).*/
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
     /*nv_clmvar    = " ".
     IF nv_cl_per  <> 0  THEN
         Assign 
         nv_clmvar1   = " Load Claim % = "
         nv_clmvar2   =  STRING(nv_cl_per)
         SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
         SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
     /*------------------ dsspc ---------------*/
     /*ASSIGN 
     nv_dsspcvar   = " "
     n_prem = deci(wdetail.premt)
     n_prem = TRUNCATE(((n_prem * 100 ) / 107.43),0).*/
     /*nv_dss_per = ((nv_gapprm - n_prem ) * 100 ) / nv_gapprm . */
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v ,       
                         nv_uom2_v ,       
                         nv_uom5_v ). */
     /*IF wdetail.prepol = "" THEN DO :
         nv_dss_per   = 0.
         IF nv_gapprm <> n_prem THEN  
             nv_dss_per = TRUNCATE(((nv_gapprm - n_prem ) * 100 ) / nv_gapprm ,3 ) . 
     END.*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_char72 c-Win 
PROCEDURE proc_char72 :
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
ASSIGN 
    nv_c = ns_policy72
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
    ns_policy72 = trim(nv_c) .
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
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
ASSIGN 
    nv_c = ns_policyrenew
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
    ns_policyrenew = trim(nv_c) .
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
            wdetail.brand    =  stat.maktab_fil.makdes
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
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
END.                       /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    IF ra_typload =  2 THEN DO:   /* Non-til */
        FIND FIRST stat.insure USE-INDEX insure01  WHERE   
            stat.insure.compno = fi_model          AND          
            stat.insure.fname  = wdetail.model     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL insure THEN  ASSIGN wdetail.model =  trim(stat.insure.lname)   .
    END.
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
    ASSIGN fi_process    = "Check  data TIL-renew...." + wdetail.policy.    /*A56-0262*/
    DISP fi_process WITH FRAM fr_main.
    RUN proc_cr_2.
    ASSIGN 
        n_rencnt = 0
        n_endcnt = 0
        nv_deler  = ""
        nv_driver = "".  /*A57-0010 */
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
        IF wdetail.prvpol <> " " THEN RUN proc_renew.
        RUN proc_chktest0.
    END.
    RUN proc_policy . 
    RUN proc_chktest2.      
    RUN proc_chktest3.      
    RUN proc_chktest4.   
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
            sic_bran.uwm301.eng_no    = wdetail.eng
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
            sic_bran.uwm301.prmtxt    = IF wdetail.poltyp = "v70" THEN wdetail.prmtxt ELSE ""  
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
                sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                wdetail.cargrp          =  maktab_fil.prmpac
                /*sic_bran.uwm301.Tons    =  stat.maktab.tons*/
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body    =  stat.maktab_fil.body
                sic_bran.uwm301.engine  =  stat.maktab_fil.eng
                nv_engine               =  stat.maktab_fil.eng.
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
                sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                wdetail.cargrp          =  stat.maktab_fil.prmpac
                sic_bran.uwm301.Tons    =  stat.maktab.tons
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body    =  stat.maktab_fil.body
                sic_bran.uwm301.engine  =  stat.maktab_fil.eng
                nv_engine               =  stat.maktab_fil.eng.
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
                sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchar c-Win 
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
nv_c = wdetail2.prvpol.
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
    wdetail2.prvpol = nv_c .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchar2 c-Win 
PROCEDURE proc_cutchar2 :
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
nv_c = wdetail2.sckno.
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
    wdetail2.sckno = nv_c .

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
nv_c = wdetail2.policy72.
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
ASSIGN wdetail2.policy72 = nv_c .

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
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
nv_c = TRIM(np_notino).
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
ASSIGN np_notino = nv_c .

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
            sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4)       
            sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                     
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            sicsyac.xmm600.dtyp20   = ""   
            sicsyac.xmm600.dval20   = ""    .
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
            sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4)       
            sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                     
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            sicsyac.xmm600.dtyp20   = ""   
            sicsyac.xmm600.dval20   = ""    .
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
        sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4)       /*Address line 4*/
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
        sicsyac.xmm600.anlyc5   =  ""                      /*Analysis Code 5*/
        sicsyac.xmm600.dtyp20   = ""     
        sicsyac.xmm600.dval20   = "" .  
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
    /*MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
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
/*แปลงไฟล์แจ้งงาน  TIL */
DEF VAR nv_vehreg  AS CHAR INIT "" FORMAT "x(2)".
ASSIGN  nv_daily   =  "" .
FOR EACH   wdetail2.
    DELETE  wdetail2.
END.
INPUT FROM VALUE (fi_filename) .   
REPEAT:    
    IMPORT UNFORMATTED nv_daily.
    If  nv_daily  <>  ""  and  substr(nv_daily,1,1)  =  "H"  Then  nv_export  =  TRIM(SUBSTR(nv_daily,32,8)).     
    IF  nv_daily  <>  ""  And  Substr(nv_daily,1,1)  =  "D"  THEN DO:
        ASSIGN 
            nv_vehreg      = ""
            ns_policyrenew = ""                                   
            ns_policy72    = ""                                  
            ns_policyrenew = TRIM(SUBSTR(nv_daily,393,26))       
            ns_policy72    = TRIM(SUBSTR(nv_daily,443,26)) .     
        IF ns_policyrenew  <> "" THEN RUN proc_charpolicyre.     
        IF ns_policy72     <> "" THEN RUN proc_char72. 
        IF TRIM(SUBSTR(nv_daily,352,20)) <> "" THEN DO:
            FIND FIRST brstat.insure USE-INDEX Insure03   WHERE    
                brstat.insure.compno = "999"    AND 
                brstat.insure.InsNo  = ("til" + TRIM(SUBSTR(nv_daily,352,20)))   NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  
                ASSIGN nv_vehreg =  trim(Insure.LName).
            ELSE ASSIGN nv_vehreg = "til" + TRIM(SUBSTR(nv_daily,352,20)).
        END.
        FIND LAST wdetail2 WHERE wdetail2.sckno      = trim(ns_policy72)  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL wdetail2 THEN  ASSIGN ns_policy72   = TRIM(ns_policy72) + "ซ้ำ" .
        CREATE  wdetail2.
        ASSIGN
            wdetail2.contractno = TRIM(SUBSTR(nv_daily,2,10))  
            wdetail2.insnam     = TRIM(SUBSTR(nv_daily,12,60))
            wdetail2.address    = TRIM(SUBSTR(nv_daily,72,160))
            wdetail2.brand      = TRIM(SUBSTR(nv_daily,232,16))
            wdetail2.model      = TRIM(SUBSTR(nv_daily,248,16))
            wdetail2.caryear    = TRIM(SUBSTR(nv_daily,264,4))
            wdetail2.ccolor     = TRIM(SUBSTR(nv_daily,268,16))
            wdetail2.cc         = TRIM(SUBSTR(nv_daily,284,4))
            wdetail2.engno      = IF INDEX(TRIM(SUBSTR(nv_daily,288,26))," ") <> 0 THEN 
                                  trim(SUBSTR(TRIM(SUBSTR(nv_daily,288,26)),1,INDEX(TRIM(SUBSTR(nv_daily,288,26))," "))) + " " +
                                  trim(SUBSTR(TRIM(SUBSTR(nv_daily,288,26)),INDEX(TRIM(SUBSTR(nv_daily,288,26))," "))) 
                                  ELSE TRIM(SUBSTR(nv_daily,288,26))
            wdetail2.chasno     = IF INDEX(TRIM(SUBSTR(nv_daily,314,26))," ") <> 0 THEN 
                                  TRIM(SUBSTR(TRIM(SUBSTR(nv_daily,314,26)),1,INDEX(TRIM(SUBSTR(nv_daily,314,26))," "))) + " " +
                                  TRIM(SUBSTR(TRIM(SUBSTR(nv_daily,314,26)),INDEX(TRIM(SUBSTR(nv_daily,314,26))," ")))
                                  ELSE TRIM(SUBSTR(nv_daily,314,26))
            wdetail2.vehreg     = TRIM(SUBSTR(nv_daily,340,12))
            wdetail2.province   = trim(nv_vehreg) 
            wdetail2.ins_compa  = TRIM(SUBSTR(nv_daily,372,5))
            wdetail2.comdat     = TRIM(SUBSTR(nv_daily,377,8))
            wdetail2.expdat     = TRIM(SUBSTR(nv_daily,385,8))
            wdetail2.prvpol     = TRIM(ns_policyrenew)                   
            wdetail2.ins_si     = TRIM(SUBSTR(nv_daily,419,12))
            wdetail2.ins_amt    = TRIM(SUBSTR(nv_daily,431,12))
            wdetail2.sckno      = trim(ns_policy72)                       
            wdetail2.prem_72    = TRIM(SUBSTR(nv_daily,469,12))
            wdetail2.mail       = TRIM(SUBSTR(nv_daily,481,160))
            wdetail2.ICNO       = TRIM(SUBSTR(nv_daily,641,13))     
            wdetail2.instyp     = TRIM(SUBSTR(nv_daily,654,1))  . 
        END.
   END.       /* repeat  */
   ASSIGN 
       nv_daily       = "" 
       nv_vehreg      = ""
       ns_policyrenew = ""                                   
       ns_policy72    = ""    .
   Run  Pro_createfileexcel.
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
        wdetail2.contractno   
        wdetail2.tiname
        wdetail2.insnam
        wdetail2.insnam2      
        wdetail2.address      
        wdetail2.brand        
        wdetail2.model        
        wdetail2.caryear      
        wdetail2.ccolor       
        wdetail2.cc           
        wdetail2.engno        
        wdetail2.chasno       
        wdetail2.vehreg       
        wdetail2.province     
        wdetail2.ins_compa    
        wdetail2.comdat       
        wdetail2.expdat       
        wdetail2.prvpol   
        wdetail2.branch 
        wdetail2.policy       
        wdetail2.ins_si       
        wdetail2.ins_amt      
        wdetail2.prem_vo      
        wdetail2.sckno        
        wdetail2.scknumber    
        wdetail2.docno        
        wdetail2.prem_72      
        wdetail2.prem_72net   
        wdetail2.mail             
        wdetail2.ICNO             
        wdetail2.instyp           
        wdetail2.sendnam
        wdetail2.chkcar
        wdetail2.telno
        wdetail2.np_f18line1 
        wdetail2.np_f18line2 
        wdetail2.np_f18line3 
        wdetail2.np_f18line4 
        wdetail2.np_f18line5 .
END.   /* repeat   */
FOR EACH wdetail2  .
    IF      index(wdetail2.contractno,"THAI")     <> 0  THEN DELETE wdetail2.
    ELSE IF index(wdetail2.contractno,"contract") <> 0  THEN DELETE wdetail2.
    ELSE IF index(wdetail2.contractno,"Total")    <> 0  THEN DELETE wdetail2.
    ELSE IF trim(wdetail2.sckno) = ""                   THEN DELETE wdetail2.
    ELSE DO:
        IF substr(TRIM(wdetail2.scknumber),1,1) <> "0" THEN wdetail2.scknumber = "0" + trim(wdetail2.scknumber).
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy = trim(wdetail2.sckno) NO-LOCK NO-ERROR .
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ( sicuw.uwm100.name1  <>  "" ) OR ( sicuw.uwm100.comdat <> ? )  THEN DO:
                FIND FIRST brstat.tlt    WHERE 
                    brstat.tlt.nor_noti_tlt   = trim(wdetail2.sckno)   AND 
                    brstat.tlt.genusr         = "til72"                NO-ERROR NO-WAIT .
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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matfileloadstknontil c-Win 
PROCEDURE proc_matfileloadstknontil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_vehreg      AS CHAR INIT "" FORMAT "x(2)".
DEF VAR nn_class72     AS CHAR FORMAT "x(4)"   INIT ""   .
DEF VAR nn_seat72      AS CHAR FORMAT "x(4)"   INIT ""   .
DEF VAR nn_stk         AS CHAR FORMAT "x(15)"  INIT ""   .
DEF VAR nn_docno       AS CHAR FORMAT "x(10)"  INIT ""   . 
DEF VAR nn_noti70      AS CHAR FORMAT "x(20)"  INIT ""   . 
DEF VAR nn_class70     AS CHAR FORMAT "x(10)"  INIT ""   . 
DEF VAR nn_seat70      AS CHAR FORMAT "x(10)"  INIT ""   . 
ASSIGN  nv_daily   =  "" .
FOR EACH   wdetail2:
    DELETE  wdetail2.
END.
INPUT FROM VALUE (fi_filename) .  
REPEAT:   
    CREATE  wdetail2.
    IMPORT DELIMITER "|" 
       wdetail2.number            /*  No.     */                                                        
       wdetail2.Contract_No       /*  เลขที่สัญญาลูกค้า/ Contract No.*/                            
       wdetail2.Ref_no            /*  Ref.NO.     */                                                    
       wdetail2.comdat            /*  ระยะเวลาคุ้มครอง/Period Insured วันเริ่มต้น Start   */            
       wdetail2.expdat            /*  วันสิ้นสุด Expiry   */                                        
       wdetail2.ntitle            /*  ชื่อผู้เอาประกันภัย/The Insured name    คำนำหน้า/Title  */        
       wdetail2.insurce           /*  ชื่อ/Name   */                                                
       wdetail2.Surename          /*  นามสกุล/Surename    */                                        
       wdetail2.Contact_Address   /*  ที่อยู่/Address ทีอยู่ที่ติดต่อได้/ Contact Address */            
       wdetail2.Sub_District      /*  ตำบล/Sub District*/                                        
       wdetail2.District          /*  อำเภอ/District*/                                            
       wdetail2.Province          /*  จังหวัด/Province*/                                        
       wdetail2.Postcode          /*  รหัสไปรษณีย์/Postcode*/                                    
       wdetail2.Landmark          /*  สถานที่ใกล้เคียง/Landmark*/                                
       wdetail2.Brand             /*  ยี่ห้อ/Brand      */                                            
       wdetail2.nColor            /*  สี/Color          */                                                
       wdetail2.model             /*  รุ่น/Model        */                                                
       wdetail2.vehreg            /*  ทะเบียน/License   */                                            
       wdetail2.vehreg2           /*  จังหวัด/Province  */                                        
       wdetail2.chasno            /*  เลขตัวถัง/Chassis */                                        
       wdetail2.engno             /*  เลขเครื่อง/Engine */                                        
       wdetail2.caryear           /*  รถปี/Model year   */                                            
       wdetail2.cc                /*  กำลังเครื่องยนต์/C.C. */                                    
       wdetail2.Weight            /*  น้ำหนัก/Weight        */                                            
       wdetail2.finance_Comp      /*  บริษัท ไฟแนนซ์/Finance Comp. */                            
       wdetail2.Insurance_Type    /*  ประเภทของสัญญาประกันภัย/Insurance Type */                    
       wdetail2.ins_si            /*  จำนวนเงินเอาประกันภัย/ Insured Amount  */                    
       wdetail2.ins_amt           
       wdetail2.prem_70           /*  ค่าเบี้ยประกันภัย/ Insurance Premium ประกันภัย/Voluntary */
       wdetail2.prem_70net        
       wdetail2.prem_72           /*  พรบ./Compulsory  */                                        
       wdetail2.prem_72net        /*  รวม/Total        */                                                
       wdetail2.Request_Date      /*  วันแจ้งประกัน/Request Date */                                
       wdetail2.companyins        /*  บริษัทประกันภย */                                            
       wdetail2.policy72          /*  กรมธรรมุ้คุ้มครองผู้ประสบภัยจากรถ (พรบ.) เลขที่     */            
       wdetail2.class72           /*  ระยะเวลาคุ้มครอง/Period Insured วันเริ่มต้น Start   */            
       wdetail2.seat72            /*  วันสิ้นสุด Expiry   */                                        
       wdetail2.sckno             /*  กรมธรรม์เดิม        */                                            
       wdetail2.docno             /*  เลขรับแจ้ง          */                                                
       wdetail2.comdat72          /*  Remark              */                                                    
       wdetail2.expdat72          /*  เลขบัตรประชาชน      */
       wdetail2.prvpol            /*  ที่อยู่จัดส่งเอกสาร     ทีอยู่ที่ติดต่อได้/ Contact Address */
       wdetail2.policy            /*  ตำบล/   Sub District  */
       wdetail2.class70            
       wdetail2.seat70                      
       wdetail2.remark             
       wdetail2.icno               
       wdetail2.sendContact_Addr   
       wdetail2.sendSub_District   
       wdetail2.sendDistrict       
       wdetail2.sendProvince       
       wdetail2.sendPostcode       
       wdetail2.np_f18line1       
       wdetail2.np_f18line2       
       wdetail2.np_f18line3       
       wdetail2.np_f18line4       
       wdetail2.np_f18line5 .  
END.       /* repeat   */
FOR EACH wdetail2.
    IF trim(wdetail2.number) = "no." THEN DELETE wdetail2.
    ELSE IF wdetail2.number  = ""    THEN DELETE wdetail2.
    ELSE DO:
        IF SUBSTR(trim(wdetail2.sckno),1,1) <> "0"  THEN wdetail2.sckno = "0" + trim(wdetail2.sckno).
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy = trim(wdetail2.policy72) NO-LOCK NO-ERROR .
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ( sicuw.uwm100.name1  <>  "" ) OR ( sicuw.uwm100.comdat <> ? )  THEN DO:
                FIND FIRST brstat.tlt    WHERE 
                    brstat.tlt.nor_noti_tlt   = trim(wdetail2.policy72)   AND 
                    brstat.tlt.genusr         = "til72"                NO-ERROR NO-WAIT .
                IF AVAIL brstat.tlt THEN DO:
                    IF INDEX(tlt.releas,"cancel") <> 0 THEN
                        ASSIGN tlt.releas   = "yes/Cancel".
                    ELSE ASSIGN tlt.releas  = "yes".
                END.
            END.
        END. 
    END.
END.
MESSAGE "Match Sticker Complete" VIEW-AS ALERT-BOX.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matfileload_2 c-Win 
PROCEDURE proc_matfileload_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* match file Load  NON-TIL */
DEF VAR nv_vehreg  AS CHAR INIT "" FORMAT "x(2)".
ASSIGN  nv_daily   =  "" .
FOR EACH   wdetail2:
    DELETE  wdetail2.
END.
INPUT FROM VALUE (fi_filename) .  
REPEAT:   
    CREATE  wdetail2.
    IMPORT DELIMITER "|" 
        wdetail2.number             /*  No.     */                                                        
        wdetail2.Contract_No        /*  เลขที่สัญญาลูกค้า/ Contract No.*/                            
        wdetail2.Ref_no             /*  Ref.NO.     */                                                    
        wdetail2.comdat             /*  ระยะเวลาคุ้มครอง/Period Insured วันเริ่มต้น Start   */            
        wdetail2.expdat             /*  วันสิ้นสุด Expiry   */                                        
        wdetail2.ntitle             /*  ชื่อผู้เอาประกันภัย/The Insured name    คำนำหน้า/Title  */        
        wdetail2.insurce            /*  ชื่อ/Name   */                                                
        wdetail2.Surename           /*  นามสกุล/Surename    */                                        
        wdetail2.Contact_Address    /*  ที่อยู่/Address ทีอยู่ที่ติดต่อได้/ Contact Address */            
        wdetail2.Sub_District       /*  ตำบล/Sub District*/                                        
        wdetail2.District           /*  อำเภอ/District*/                                            
        wdetail2.Province           /*  จังหวัด/Province*/                                        
        wdetail2.Postcode           /*  รหัสไปรษณีย์/Postcode*/                                    
        wdetail2.Landmark           /*  สถานที่ใกล้เคียง/Landmark*/                                
        wdetail2.Brand              /*  ยี่ห้อ/Brand      */                                            
        wdetail2.nColor             /*  สี/Color          */                                                
        wdetail2.model              /*  รุ่น/Model        */                                                
        wdetail2.vehreg             /*  ทะเบียน/License   */                                            
        wdetail2.vehreg2            /*  จังหวัด/Province  */                                        
        wdetail2.chasno             /*  เลขตัวถัง/chasno */                                        
        wdetail2.engno              /*  เลขเครื่อง/Engine */                                        
        wdetail2.caryear            /*  รถปี/Model year   */                                            
        wdetail2.cc                 /*  กำลังเครื่องยนต์/C.C. */                                    
        wdetail2.Weight             /*  น้ำหนัก/Weight        */                                            
        wdetail2.finance_Comp       /*  บริษัท ไฟแนนซ์/Finance Comp. */                            
        wdetail2.Insurance_Type     /*  ประเภทของสัญญาประกันภัย/Insurance Type */                    
        wdetail2.ins_si             /*  จำนวนเงินเอาประกันภัย/ Insured Amount  */    
        wdetail2.ins_amt            /*  ค่าเบี้ยประกันภัย/ Insurance Premium ประกันภัย/Voluntary */
        wdetail2.prem_72            /*  พรบ./Compulsory  */                                        
        wdetail2.prem_72net         /*  รวม/Total        */                                                
        wdetail2.Request_Date       /*  วันแจ้งประกัน/Request Date */                                
        wdetail2.companyins         /*  บริษัทประกันภย */                                            
        wdetail2.policy72           /*  กรมธรรมุ้คุ้มครองผู้ประสบภัยจากรถ (พรบ.) เลขที่     */            
        wdetail2.comdat72           /*  ระยะเวลาคุ้มครอง/Period Insured วันเริ่มต้น Start   */            
        wdetail2.expdat72           /*  วันสิ้นสุด Expiry   */                                        
        wdetail2.prvpol             /*  กรมธรรม์เดิม        */                                            
        wdetail2.notino             /*  เลขรับแจ้ง      */                                                
        wdetail2.remark             /*  Remark      */                                                    
        wdetail2.icno               /*  เลขบัตรประชาชน      */
        wdetail2.sendContact_Addr   /*  ที่อยู่จัดส่งเอกสาร     ทีอยู่ที่ติดต่อได้/ Contact Address */
        wdetail2.sendSub_District   /*  ตำบล/   Sub District  */
        wdetail2.sendDistrict       /*  อำเภอ/  District      */
        wdetail2.sendProvince       /*  จังหวัด/Province      */
        wdetail2.sendPostcode.      /*  รหัสไปรษณีย์/Postcode */
END.       /* repeat   */
FOR EACH wdetail2.
    IF      trim(wdetail2.number)  = "no." THEN DELETE wdetail2.
    ELSE IF trim(wdetail2.number)  = ""    THEN DELETE wdetail2.
    ELSE DO:
        FIND FIRST brstat.msgcode WHERE      /*mat Title name...*/
            brstat.msgcode.compno = "999"  AND
            brstat.msgcode.MsgDesc = TRIM(wdetail2.ntitle)  NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.msgcode THEN ASSIGN wdetail2.ntitle = trim(brstat.msgcode.branch) .
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*Match Provin.licence  */
            brstat.insure.compno = "999" AND
            brstat.Insure.fName  = TRIM(wdetail2.vehreg2) NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN  
            ASSIGN wdetail2.vehreg2 = TRIM(brstat.insure.LName) .
        FIND FIRST stat.company USE-INDEX Company01 WHERE 
            company.compno = TRIM(wdetail2.finance_Comp)  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.company THEN ASSIGN  wdetail2.finance_Comp  = trim(stat.company.name).  /*8.3*/
        IF trim(wdetail2.companyins)  = "SAFE" THEN DO:
            FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE
                sicuw.uwm301.trareg = TRIM(wdetail2.chasno) AND 
                SUBSTR(sicuw.uwm301.policy,3,2)  = "70"     NO-LOCK NO-ERROR NO-WAIT.  /*previes policy by chassis */
            IF AVAIL sicuw.uwm301  THEN  ASSIGN wdetail2.prvpol = trim(sicuw.uwm301.policy).
            ELSE ASSIGN wdetail2.prvpol = "".
        END.
        IF (wdetail2.comdat72 = "-" ) OR (wdetail2.comdat72 = "" ) THEN wdetail2.comdat72 = "".
        IF (wdetail2.expdat72 = "-" ) OR (wdetail2.expdat72 = "" ) THEN wdetail2.expdat72 = "" .
        RUN proc_cutpol72.
    END.
END.
Run  Pro_createfile_nontil.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matpol_nontil c-Win 
PROCEDURE proc_matpol_nontil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_vehreg  AS CHAR INIT "" FORMAT "x(2)".
ASSIGN  nv_daily   =  "" .
FOR EACH   wdetail2:
    DELETE  wdetail2.
END.
INPUT FROM VALUE (fi_filename) .  
REPEAT:   
    CREATE  wdetail2.
    IMPORT DELIMITER "|" 
        wdetail2.number               /*  No.     */                                                        
        wdetail2.Contract_No          /*  เลขที่สัญญาลูกค้า/ Contract No.*/                            
        wdetail2.Ref_no               /*  Ref.NO.     */                                                    
        wdetail2.comdat               /*  ระยะเวลาคุ้มครอง/Period Insured วันเริ่มต้น Start   */            
        wdetail2.expdat               /*  วันสิ้นสุด Expiry   */                                        
        wdetail2.ntitle               /*  ชื่อผู้เอาประกันภัย/The Insured name    คำนำหน้า/Title  */        
        wdetail2.insurce              /*  ชื่อ/Name   */                                                
        wdetail2.Surename             /*  นามสกุล/Surename    */                                        
        wdetail2.Contact_Address      /*  ที่อยู่/Address ทีอยู่ที่ติดต่อได้/ Contact Address */            
        wdetail2.Sub_District         /*  ตำบล/Sub District*/                                        
        wdetail2.District             /*  อำเภอ/District*/                                            
        wdetail2.Province             /*  จังหวัด/Province*/                                        
        wdetail2.Postcode             /*  รหัสไปรษณีย์/Postcode*/                                    
        wdetail2.Landmark             /*  สถานที่ใกล้เคียง/Landmark*/                                
        wdetail2.Brand                /*  ยี่ห้อ/Brand      */                                            
        wdetail2.nColor               /*  สี/Color          */                                                
        wdetail2.model                /*  รุ่น/Model        */                                                
        wdetail2.vehreg               /*  ทะเบียน/License   */                                            
        wdetail2.vehreg2              /*  จังหวัด/Province  */                                        
        wdetail2.chasno               /*  เลขตัวถัง/chasno */                                        
        wdetail2.engno                /*  เลขเครื่อง/Engine */                                        
        wdetail2.caryear              /*  รถปี/Model year   */                                            
        wdetail2.cc                   /*  กำลังเครื่องยนต์/C.C. */                                    
        wdetail2.Weight               /*  น้ำหนัก/Weight        */                                            
        wdetail2.finance_Comp         /*  บริษัท ไฟแนนซ์/Finance Comp. */                            
        wdetail2.Insurance_Type       /*  ประเภทของสัญญาประกันภัย/Insurance Type */                    
        wdetail2.ins_si               /*  จำนวนเงินเอาประกันภัย/ Insured Amount  */    
        wdetail2.ins_amt              /*  ค่าเบี้ยประกันภัย/ Insurance Premium ประกันภัย/Voluntary */
        wdetail2.prem_70              /*  พรบ./Compulsory  */                                        
        wdetail2.prem_70net           /*  รวม/Total        */                                                
        wdetail2.prem_72              /*  วันแจ้งประกัน/Request Date */                                
        wdetail2.prem_72net           /*  บริษัทประกันภย */                                            
        wdetail2.Request_Date         /*  กรมธรรมุ้คุ้มครองผู้ประสบภัยจากรถ (พรบ.) เลขที่     */            
        wdetail2.companyins           /*  ระยะเวลาคุ้มครอง/Period Insured วันเริ่มต้น Start   */            
        wdetail2.policy72             /*  วันสิ้นสุด Expiry   */                                        
        wdetail2.class72              /*  กรมธรรม์เดิม        */                                            
        wdetail2.seat72               /*  เลขรับแจ้ง      */                                                
        wdetail2.sckno                /*  Remark      */                                                    
        wdetail2.docno                /*  เลขบัตรประชาชน      */
        wdetail2.comdat72             /*  ที่อยู่จัดส่งเอกสาร     ทีอยู่ที่ติดต่อได้/ Contact Address */
        wdetail2.expdat72             /*  ตำบล/   Sub District  */
        wdetail2.prvpol               /*  อำเภอ/  District      */
        wdetail2.policy               /*  จังหวัด/Province      */
        wdetail2.class70              /*  รหัสไปรษณีย์/Postcode */
        wdetail2.seat70                                        
        wdetail2.remark                  
        wdetail2.icno                    
        wdetail2.sendContact_Addr        
        wdetail2.sendSub_District        
        wdetail2.sendDistrict            
        wdetail2.sendProvince            
        wdetail2.sendPostcode 
        wdetail2.np_f18line1                
        wdetail2.np_f18line2                
        wdetail2.np_f18line3                
        wdetail2.np_f18line4                
        wdetail2.np_f18line5 .  
END.       /* repeat   */  
FOR EACH wdetail2 .
    IF trim(wdetail2.number)  = "no."  THEN DELETE wdetail2.
    ELSE IF trim(wdetail2.number)  =  ""    THEN DELETE wdetail2.
    ELSE DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
            sicuw.uwm100.cedpol =  trim(wdetail2.Contract_No) AND 
            sicuw.uwm100.poltyp = "V70"    NO-LOCK NO-ERROR .
        IF AVAIL sicuw.uwm100 THEN ASSIGN wdetail2.policy = sicuw.uwm100.policy .
        ELSE ASSIGN wdetail2.policy = "".
    END.
END.
Run  pro_createpolnontil.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matpol_til c-Win 
PROCEDURE proc_matpol_til :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:                                                  
    For each  wdetail2 :                             
        DELETE  wdetail2.                            
    END.
    INPUT FROM VALUE (fi_filename) .                                   
    REPEAT:       
        CREATE wdetail2.                                                
        IMPORT DELIMITER "|" 
            wdetail2.contractno     
            wdetail2.tiname         
            wdetail2.insnam         
            wdetail2.insnam2        
            wdetail2.address        
            wdetail2.brand          
            wdetail2.model          
            wdetail2.caryear        
            wdetail2.ccolor         
            wdetail2.cc             
            wdetail2.engno          
            wdetail2.chasno         
            wdetail2.vehreg         
            wdetail2.province       
            wdetail2.ins_compa      
            wdetail2.comdat         
            wdetail2.expdat         
            wdetail2.prvpol   
            wdetail2.branch 
            wdetail2.policy         
            wdetail2.ins_si         
            wdetail2.ins_amt        
            wdetail2.prem_vo        
            wdetail2.sckno          
            wdetail2.scknumber      
            wdetail2.docno          
            wdetail2.prem_72        
            wdetail2.prem_72net     
            wdetail2.mail           
            wdetail2.ICNO                                     
            wdetail2.instyp                                   
            wdetail2.sendnam
            wdetail2.chkcar
            wdetail2.telno
            wdetail2.np_f18line1 
            wdetail2.np_f18line2 
            wdetail2.np_f18line3 
            wdetail2.np_f18line4  
            wdetail2.np_f18line5 .
    END.   /* repeat   */
    FOR EACH wdetail2  .
        IF      index(wdetail2.contractno,"THAI")     <> 0  THEN DELETE wdetail2.
        ELSE IF index(wdetail2.contractno,"contract") <> 0  THEN DELETE wdetail2.
        ELSE IF index(wdetail2.contractno,"Total")    <> 0  THEN DELETE wdetail2.
        ELSE IF wdetail2.contractno = ""  THEN DELETE wdetail2.
    END.
    RUN pro_createpol.
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
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
DEF VAR n_nameno AS INTE.
ASSIGN fi_process    = "Import data TIL-renew to uwm100..." + wdetail.policy .    /*A56-0262*/
    DISP fi_process WITH FRAM fr_main.
IF wdetail.policy <> "" THEN DO:
    IF wdetail.stk  <>  ""  THEN DO: 
        RUN proc_stkfinddup.
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            /*MESSAGE "Sticker Number"  wdetail.stk "ใช้ Generate ไม่ได้ เนื่องจาก Modulo Error"  VIEW-AS ALERT-BOX.*/
            ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        IF wdetail.poltyp = "V72" THEN DO:
            FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
                sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN  
                    
                        /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
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
                        /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
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
        IF wdetail.poltyp = "v70" THEN DO:
            FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
                sicuw.uwm100.cedpol =  wdetail.cedpol  AND 
                sicuw.uwm100.poltyp =  wdetail.poltyp  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN DO: 
                    IF sicuw.uwm100.expdat > DATE(wdetail.comdat) THEN
                        /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
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
                        /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว " VIEW-AS ALERT-BOX.*/ 
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
            /*MESSAGE "Sticker Number"  wdetail.stk "ใช้ Generate ไม่ได้ เนื่องจาก Modulo Error"  VIEW-AS ALERT-BOX.*/
            ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001  WHERE
            sicuw.uwm100.policy =  wdetail.policy   AND
            sicuw.uwm100.poltyp =  wdetail.poltyp   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN DO: 
                IF sicuw.uwm100.expdat > DATE(wdetail.comdat) THEN
                    /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
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
IF R-INDEX(wdetail.insnam,".") <> 0 THEN 
    wdetail.insnam = SUBSTR(wdetail.insnam,R-INDEX(wdetail.insnam,".")).
IF wdetail.prvpol = "" THEN n_firstdat = DATE(wdetail.comdat).        /*kridtiya i . A53-0220*/
DO TRANSACTION:
   ASSIGN
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = trim(wdetail.poltyp)
      sic_bran.uwm100.insref = trim(wdetail.insrefno)
      /*sic_bran.uwm100.opnpol = ""*/       /*A57-0226*/
      sic_bran.uwm100.opnpol = IF wdetail.instyp = "9" THEN "" ELSE fi_prom      /*A57-0226*/
      sic_bran.uwm100.anam2  = trim(wdetail.Icno)       /* ICNO  Cover Note A51-0071 Amparat */
      /*sic_bran.uwm100.ntitle = "คุณ"   */
      sic_bran.uwm100.ntitle = trim(wdetail.tiname)
      sic_bran.uwm100.name1  = TRIM(wdetail.insnam)  
      sic_bran.uwm100.name2  = IF ra_typload = 1 THEN "" ELSE  trim(wdetail.insnam2)  /*"และ/หรือ บริษัท ตรีเพชรอีซูซุลิสซิ่ง จำกัด" */
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
      sic_bran.uwm100.prog   = "wgwtsge2"
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
      sic_bran.uwm100.finint = nv_deler
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
END. /*transaction*//*
IF wdetail.sendnam <> ""  THEN RUN proc_uwd100.   
ELSE IF wdetail.chkcar <> ""  THEN RUN proc_uwd100.   
ELSE IF wdetail.telno  <> ""   THEN RUN proc_uwd100. */
/*kridtiya i. A52-0293.....
RUN proc_uwd102.*/
IF wdetail.poltyp = "V70" THEN  RUN proc_uwd102.
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
    IF sicuw.uwm100.renpol <> " " THEN DO:
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
      
      CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) .  
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) . *//*Comment A62-0105*/         
      /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) .  /*db test.*/ */
      
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
    nv_txt2  = ""
    nv_txt3  = wdetail.sendnam 
    nv_txt4  = wdetail.chkcar  
    nv_txt5  = wdetail.telno   .
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
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
FIND LAST wdetmemo WHERE wdetmemo.policymemo = trim(wdetail.policy) NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL wdetmemo THEN DO: 
    DO WHILE nv_line1 <= 9:
        CREATE wuppertxt3.
        wuppertxt3.line = nv_line1.
        IF nv_line1 < 4  THEN wuppertxt3.txt =  "".   
        IF nv_line1 = 4  THEN wuppertxt3.txt =  wdetmemo.f18line1.   
        IF nv_line1 = 5  THEN wuppertxt3.txt =  wdetmemo.f18line2.   
        IF nv_line1 = 6  THEN wuppertxt3.txt =  wdetmemo.f18line3.   
        IF nv_line1 = 7  THEN wuppertxt3.txt =  wdetmemo.f18line4.   
        IF nv_line1 = 8  THEN wuppertxt3.txt =  wdetmemo.f18line5.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfileexcel c-Win 
PROCEDURE Pro_createfileexcel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Export file แจ้งงาน TIL */
DEF VAR nv_accdat   AS DATE   FORMAT "99/99/9999" NO-UNDO.
DEF VAR nv_comdat   AS DATE   FORMAT "99/99/9999" NO-UNDO.
DEF VAR nv_expdat   AS DATE   FORMAT "99/99/9999" NO-UNDO.
DEF VAR nv_comchr   AS CHAR   . 
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
DEF VAR nv_name1    AS CHAR   INIT ""   Format  "X(30)".
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
DEF VAR nv_tilstkno AS CHAR INIT "" FORMAT "X(20)".    /*A57-0010 */
DEF VAR nv_tildocno AS CHAR INIT "" FORMAT "X(10)".    /*A57-0010 */
DEF VAR nv_branch   AS CHAR INIT "" FORMAT "x(2)" .    /*A57-0226 */
If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "THAI AUTO SALES CO,.LTD."  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' nv_export                   '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "contract no"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Title name"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "Name"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "S-name "                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "reg.address"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "brand "                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "model"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "year"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "color"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "cc"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "engine no"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "chassis"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "licence no"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "province"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "insurance comp."          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "insurance date."          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "expdat"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Policy-Renew"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "Branch"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Policy-NEW "              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "insurance amount "        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Net Premium (Voluntary)"  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "premium(voluntary)      " '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "compulsory no."           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Sticker no."              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "recive no."               '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Net Premium (Compulsory)" '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "premium(commpulsory)"     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "mailing address"          '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "IDcard number"            '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Insurance Type"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Sendnam"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Chkcar"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "Telno"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "F18_Line1"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "F18_Line2"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "F18_Line3"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "F18_Line4"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "F18_Line5"                '"' SKIP.

FOR EACH wdetail2  NO-LOCK.
    ASSIGN 
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row + 1
        nv_title =  ""
        nv_name  =  ""
        nv_sname =  ""
        nv_tilstkno  =  ""       /*A57-0010*/ 
        nv_tildocno  =  ""       /*A57-0010*/ 
        nv_cpamt3    = 0
        nv_premt3    = 0
        nv_insamt3   = 0 .
    IF INDEX(wdetail2.insnam," ") <> 0 THEN DO:
        IF INDEX(wdetail2.insnam," ") = 0 THEN
            ASSIGN nv_title =  ""
                   nv_name  =  TRIM(wdetail2.insnam)
                   nv_sname =  "".
        ELSE IF (R-INDEX(wdetail2.insnam," ")) = (INDEX(wdetail2.insnam," "))  THEN
            ASSIGN 
            nv_name  = trim(SUBSTR(wdetail2.insnam,INDEX(wdetail2.insnam," ") + 1))
            nv_title = trim(SUBSTR(wdetail2.insnam,1,INDEX(wdetail2.insnam," ") - 1))
            nv_sname = "".
        ELSE 
            ASSIGN 
                nv_title = TRIM(wdetail2.insnam)
                nv_sname = trim(SUBSTR(nv_title,R-INDEX(nv_title," ")))
                nv_title = trim(SUBSTR(nv_title,1,R-INDEX(nv_title," ") - 1))
                nv_name  = trim(SUBSTR(nv_title,R-INDEX(nv_title," "))) 
                nv_title = trim(SUBSTR(nv_title,1,R-INDEX(nv_title," ") - 1))   .
    END.
    IF nv_title <> "" THEN DO:
        FIND FIRST brstat.msgcode WHERE 
            brstat.msgcode.compno = "999"      AND
            brstat.msgcode.MsgDesc = nv_title  NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.msgcode THEN 
            ASSIGN nv_title = brstat.msgcode.branch.
    END.
    IF wdetail2.sckno = "" THEN ASSIGN nv_tilstkno  =  ""    nv_tildocno  =  ""   .   /*A57-0010*/ 
    ELSE DO:
        FIND FIRST brstat.tlt    WHERE 
            brstat.tlt.nor_noti_tlt   = trim(wdetail2.sckno) AND 
            brstat.tlt.genusr         = "til72"              NO-LOCK NO-ERROR NO-WAIT .
        IF AVAIL brstat.tlt THEN  
            ASSIGN nv_tilstkno  = TRIM(brstat.tlt.cha_no)
                   nv_tildocno  = TRIM(brstat.tlt.safe2)  .
    END.
   nv_premt1 = DECIMAL(SUBSTRING(wdetail2.ins_amt,1,10)).
   IF nv_premt1 < 0 THEN nv_premt2 = (DECIMAL(SUBSTRING(wdetail2.ins_amt,11,2)) * -1) / 100.
   ELSE nv_premt2 = DECIMAL(SUBSTRING(wdetail2.ins_amt,11,2)) / 100.

   nv_premt3 = nv_premt1 + nv_premt2. 
   nv_cpamt1 = DECIMAL(SUBSTRING(wdetail2.prem_72,1,10)).

   IF nv_cpamt1 < 0 THEN nv_cpamt2 = (DECIMAL(SUBSTRING(wdetail2.prem_72,11,2)) * -1) / 100.
   ELSE  nv_cpamt2 = DECIMAL(SUBSTRING(wdetail2.prem_72,11,2)) / 100.
        
   nv_cpamt3 = nv_cpamt1 + nv_cpamt2. 
   IF nv_premt3 <= 0 THEN wdetail2.net_prm     = nv_premt3.                                   
   ELSE  ASSIGN wdetail2.net_prm     = (ROUND(((nv_premt3 - nv_cpamt3 ) * 100 / 107.43),0)) .                                                      /*A56-0217*/
   IF nv_cpamt3 > 0 THEN 
       ASSIGN  wdetail2.net_comp    = (TRUNC((nv_cpamt3 * 100 / 107.43),0)).
   nv_insamt1 = DECIMAL(SUBSTRING(wdetail2.ins_si,1,10)).
   IF nv_insamt1 < 0 THEN nv_insamt2 = (DECIMAL(SUBSTRING(wdetail2.ins_si,11,2)) * -1) / 100.
   ELSE nv_insamt2 = DECIMAL(SUBSTRING(wdetail2.ins_si,11,2)) / 100.
   nv_insamt3 = nv_insamt1 + nv_insamt2.
   IF                  TRIM(wdetail2.prvpol) = ""  THEN ASSIGN nv_branch = "".
   ELSE IF substr(TRIM(wdetail2.prvpol),1,1) = "D" THEN ASSIGN nv_branch = substr(TRIM(wdetail2.prvpol),2,1).
   ELSE ASSIGN nv_branch = substr(TRIM(wdetail2.prvpol),1,2).
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetail2.contractno                          '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   nv_title            FORMAT "x(25)"           '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   nv_name             FORMAT "x(35)"           '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   nv_sname            FORMAT "x(40)"           '"' SKIP.    
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail2.address                             '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail2.brand                               '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail2.model                               '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail2.caryear                             '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail2.ccolor                              '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetail2.cc                                  '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetail2.engno                               '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetail2.chasno                              '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetail2.vehreg                              '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   wdetail2.province                            '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   wdetail2.ins_compa                           '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   wdetail2.comdat                              '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   wdetail2.expdat                              '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   wdetail2.prvpol                              '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   nv_branch                                    '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   ""                                           '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   nv_insamt3          FORMAT ">>>,>>>,>>9-"    '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   wdetail2.net_prm    FORMAT ">>>,>>>,>>9-"    '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   nv_premt3           FORMAT ">>>,>>>,>>9.99-" '"' SKIP.                
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   wdetail2.sckno                               '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   nv_tilstkno                                  '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   nv_tildocno                                  '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   wdetail2.net_comp   FORMAT ">>>,>>>,>>9-"    '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   nv_cpamt3                                    '"' SKIP. 
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   wdetail2.mail                                '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   wdetail2.ICNO                                '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   wdetail2.instyp                              '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   ""                                           '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   ""                                           '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'   ""                                           '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'   ""                                           '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'   ""                                           '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'   ""                                           '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'   ""                                           '"' SKIP.
End.                                                                                              
nv_row  =  nv_row  + 1.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " Total "               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' String(nv_cnt,"99999")  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' " รายการ  "             '"' SKIP.
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
FOR EACH wdetail2.
    DELETE wdetail2.
END.
message "Export File  Complete"  view-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_nontil c-Win 
PROCEDURE Pro_createfile_nontil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*แปลงไฟล์ Load Text non-til */
DEF VAR nn_stk    AS CHAR INIT "" FORMAT "x(15)".
DEF VAR nn_docno  AS CHAR INIT "" FORMAT "x(7)".
DEF VAR nn_class  AS CHAR INIT "" FORMAT "x(4)".
DEF VAR nn_seat72 AS CHAR INIT "" FORMAT "x(3)".
/*DEF VAR nn_seat70 AS CHAR INIT "" FORMAT "x(3)".*/
If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  "No."                                    '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  "เลขที่สัญญาลูกค้า"                      '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  "Ref.NO."                                '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  "วันเริ่มต้น Start"                      '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  "วันสิ้นสุด Expiry"                      '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  "คำนำหน้า/Title   "                      '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  "ชื่อ/Name"                              '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  "นามสกุล/Surename"                       '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  "ที่อยู่/Address "                       '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'  "ตำบล/Sub District"                      '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'  "อำเภอ/District"                         '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'  "จังหวัด/Province"                       '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'  "รหัสไปรษณีย์/Postcode"                  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'  "สถานที่ใกล้เคียง/Landmark"              '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'  "ยี่ห้อ/Brand"                           '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'  "สี/Color"                               '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'  "รุ่น/Model "                            '"' SKIP.                                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'  "ทะเบียน/License"                        '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'  "จังหวัด/Province"                       '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'  "เลขตัวถัง/Chassis"                      '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'  "เลขเครื่อง/Engine"                      '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'  "รถปี/Model year"                        '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'  "กำลังเครื่องยนต์/C.C."                  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'  "น้ำหนัก/Weight"                         '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'  "บริษัท ไฟแนนซ์/Finance Comp."           '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'  "ประเภทของสัญญาประกันภัย/Insurance Type" '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'  "จำนวนเงินเอาประกันภัย/ Insured Amount"  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'  "เบี้ยสุทธิประเภท 1/Net Premium (Voluntary)"  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'  "ค่าเบี้ยประกันภัย "                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'  "เบี้ยสุทธิ พรบ./Net Premium (Compulsory)"    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'  "พรบ./Compulsory"                        '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'  "รวม/Total"                              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'  "วันแจ้งประกัน/Request Date"             '"' SKIP.                                           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'  "บริษัทประกันภย"                         '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'  "กรมธรรม์(พรบ.)"                         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'  "คลาสรถ72"                               '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'  "จำนวนที่นั่ง72"                         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'  "เลขสติ๊กเกอร์"                          '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'  "เลขที่ใบเสร็จ"                          '"' SKIP.                                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'  "วันเริ่มต้น Start"                      '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'  "วันสิ้นสุด Expiry"                      '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'  "กรมธรรม์เดิม"                           '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'  "กรมธรรม์ใหม่"                           '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'  "แพคเกจ/คลาสรถ"                          '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'  "จำนวนที่นั่ง70"                         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'  "Remark"                                 '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'  "เลขบัตรประชาชน"                         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'  "ที่อยู่จัดส่งเอกสาร"                    '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'  "ตำบล/Sub District"                      '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'  "อำเภอ/District"                         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'  "จังหวัด/Province"                       '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'  "รหัสไปรษณีย์/Postcode"                  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'  "F18_Line1"                              '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'  "F18_Line2"                              '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'  "F18_Line3"                              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'  "F18_Line4"                              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'  "F18_Line5"                              '"' SKIP.
FOR EACH wdetail2  NO-LOCK 
    BREAK BY deci(wdetail2.number) .
    ASSIGN nv_row =  nv_row + 1 
        nn_stk    = ""
        nn_docno  = ""
        nn_class  = "" 
        nn_seat72 = ""  
        /*nn_seat70 = "" */  .
    FIND FIRST brstat.tlt    WHERE tlt.nor_noti_tlt   = trim(wdetail2.policy72) AND 
        tlt.genusr         = "til72"                 NO-LOCK NO-ERROR NO-WAIT .
    IF AVAIL tlt THEN  ASSIGN nn_stk   = TRIM(tlt.cha_no)
               nn_docno = TRIM(tlt.safe2) .
    IF (TRIM(wdetail2.prem_72) <> "-") OR (TRIM(wdetail2.prem_72) <> "")  THEN DO:
        FIND LAST wcomp WHERE wcomp.premcomp = deci(wdetail2.prem_72) NO-LOCK NO-ERROR.
        IF AVAIL wcomp  THEN ASSIGN nn_class  = trim(wcomp.package) .
        ELSE ASSIGN nn_class  = "" .
    END.
    IF      (substr(nn_class,1,3) = "110")  THEN ASSIGN nn_seat72 = "7"  .
    ELSE IF (substr(nn_class,1,3) = "140")  THEN ASSIGN nn_seat72 = "3"  .
    ELSE IF (substr(nn_class,1,3) = "120")  THEN ASSIGN nn_seat72 = "12" .
    ELSE ASSIGN nn_seat72 = "0" .
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetail2.number            '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetail2.Contract_No       '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetail2.Ref_no            '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail2.comdat            '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail2.expdat            '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetail2.ntitle            '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetail2.insurce           '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail2.Surename          '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail2.Contact_Address   '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'  wdetail2.Sub_District      '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'  wdetail2.District          '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'  wdetail2.Province          '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'  wdetail2.Postcode          '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'  wdetail2.Landmark          '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'  wdetail2.Brand             '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'  wdetail2.nColor            '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'  wdetail2.model             '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'  wdetail2.vehreg            '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'  wdetail2.vehreg2           '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'  wdetail2.chasno            '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'  wdetail2.engno             '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'  wdetail2.caryear           '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'  wdetail2.cc                '"' SKIP.            
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'  wdetail2.Weight            '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'  wdetail2.finance_Comp      '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'  wdetail2.Insurance_Type    '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'  wdetail2.ins_si            '"' SKIP. 
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'  string(ROUND(((deci(wdetail2.ins_amt) * 100 ) / 107.43),0)) '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'  wdetail2.ins_amt           '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'  string(truncate(((deci(wdetail2.prem_72) * 100 ) / 107.43),0)) '"' SKIP. 
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'  wdetail2.prem_72        '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'  wdetail2.prem_72net            '"' SKIP.  
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'  wdetail2.Request_Date      '"' SKIP. 
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'  wdetail2.companyins        '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'  wdetail2.policy72          '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'  nn_class                   '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'  nn_seat72                  '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'  nn_stk                     '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'  nn_docno                   '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'  wdetail2.comdat72          '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'  wdetail2.expdat72          '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'  wdetail2.prvpol            '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'  ""                         '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'  ""                         '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'  ""                         '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'  wdetail2.remark            '"' SKIP.           
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'  wdetail2.icno              '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'  wdetail2.sendContact_Addr  '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'  wdetail2.sendSub_District  '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'  wdetail2.sendDistrict      '"' SKIP.   
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'  wdetail2.sendProvince      '"' SKIP.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'  wdetail2.sendPostcode      '"' SKIP.
End.                                                    
/*PUT STREAM ns2 "E".*/
OUTPUT STREAM ns2 CLOSE.
FOR EACH wdetail2.
    DELETE wdetail2.
END.
message "Export File Non-Til... Complete "  view-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createpol c-Win 
PROCEDURE pro_createpol :
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
DEF VAR nv_tilstkno AS CHAR INIT "" FORMAT "X(20)".    /*A57-0010*/
DEF VAR nv_tildocno AS CHAR INIT "" FORMAT "X(10)".    /*A57-0010*/
If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN
    nv_cnt  =  0
    nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "THAI AUTO SALES CO,.LTD."  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' nv_export                   '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "contract no"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Title name"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "Name"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "S-name "                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "reg.address"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "brand "                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "model"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "year"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "color"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "cc"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "engine no"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "chassis"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "licence no"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "province"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "insurance comp."          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "insurance date."          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "expdat"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Policy-Renew"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "Branch"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Policy-NEW "              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "insurance amount "        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Net Premium (Voluntary)." '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "premium(voluntary)      " '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "compulsory no."           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Sticker no."              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "recive no."               '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Net Premium (Compulsory)" '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "premium(commpulsory)"     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "mailing address"          '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "IDcard number"            '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Insurance Type"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Sendnam"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Chkcar"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "Telno"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "F18_Line1"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "F18_Line2"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "F18_Line3"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "F18_Line4"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "F18_Line5"                '"' SKIP.

FOR EACH wdetail2  .
    ASSIGN nv_row  =  nv_row  + 1.  
    FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
        sicuw.uwm100.cedpol =  trim(wdetail2.contractno) AND 
        sicuw.uwm100.poltyp = "V70"                      NO-LOCK NO-ERROR .
    IF AVAIL sicuw.uwm100 THEN wdetail2.policy = sicuw.uwm100.policy .
    ELSE wdetail2.policy = "".
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'       wdetail2.contractno     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'       wdetail2.tiname         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'       wdetail2.insnam         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'       wdetail2.insnam2        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'       wdetail2.address        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'       wdetail2.brand          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'       wdetail2.model          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'       wdetail2.caryear        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'       wdetail2.ccolor         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'       wdetail2.cc             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'       wdetail2.engno          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'       wdetail2.chasno         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'       wdetail2.vehreg         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'       wdetail2.province       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'       wdetail2.ins_compa      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'       wdetail2.comdat         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'       wdetail2.expdat         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'       wdetail2.prvpol         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'       wdetail2.branch         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'       wdetail2.policy         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'       wdetail2.ins_si         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'       wdetail2.ins_amt        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'       wdetail2.prem_vo        '"' SKIP.                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'       wdetail2.sckno          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'       wdetail2.scknumber      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'       wdetail2.docno          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'       wdetail2.prem_72        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'       wdetail2.prem_72net     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'       wdetail2.mail           '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'       wdetail2.ICNO           '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'       wdetail2.instyp         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'       wdetail2.sendnam        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'       wdetail2.chkcar         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'       wdetail2.telno          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'       wdetail2.np_f18line1    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'       wdetail2.np_f18line2    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'       wdetail2.np_f18line3    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'       wdetail2.np_f18line4    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'       wdetail2.np_f18line5    '"' SKIP.
                                                                                      
End.   
nv_row  =  nv_row  + 1.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " Total "               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' String(nv_cnt,"99999")  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' " รายการ  "             '"' SKIP.
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
FOR EACH wdetail2.
    DELETE wdetail2.
END.
message "Export Match File Policy Complete"  view-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createpolnontil c-Win 
PROCEDURE pro_createpolnontil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nn_stk    AS CHAR INIT "" FORMAT "x(15)".
DEF VAR nn_docno  AS CHAR INIT "" FORMAT "x(7)".
DEF VAR nn_class  AS CHAR INIT "" FORMAT "x(4)".
DEF VAR nn_seat72 AS CHAR INIT "" FORMAT "x(3)".
/*DEF VAR nn_seat70 AS CHAR INIT "" FORMAT "x(3)".*/
If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1  =  Trim(fi_output1) + ".slk"  .
ASSIGN nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  "No."                                    '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  "เลขที่สัญญาลูกค้า"                      '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  "Ref.NO."                                '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  "วันเริ่มต้น Start"                      '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  "วันสิ้นสุด Expiry"                      '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  "คำนำหน้า/Title   "                      '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  "ชื่อ/Name"                              '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  "นามสกุล/Surename"                       '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  "ที่อยู่/Address "                       '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'  "ตำบล/Sub District"                      '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'  "อำเภอ/District"                         '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'  "จังหวัด/Province"                       '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'  "รหัสไปรษณีย์/Postcode"                  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'  "สถานที่ใกล้เคียง/Landmark"              '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'  "ยี่ห้อ/Brand"                           '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'  "สี/Color"                               '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'  "รุ่น/Model "                            '"' SKIP.                                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'  "ทะเบียน/License"                        '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'  "จังหวัด/Province"                       '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'  "เลขตัวถัง/Chassis"                      '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'  "เลขเครื่อง/Engine"                      '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'  "รถปี/Model year"                        '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'  "กำลังเครื่องยนต์/C.C."                  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'  "น้ำหนัก/Weight"                         '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'  "บริษัท ไฟแนนซ์/Finance Comp."           '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'  "ประเภทของสัญญาประกันภัย/Insurance Type" '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'  "จำนวนเงินเอาประกันภัย/ Insured Amount"  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'  "เบี้ยสุทธิประเภท 1/Net Premium (Voluntary)"  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'  "ค่าเบี้ยประกันภัย "                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'  "เบี้ยสุทธิ พรบ./Net Premium (Compulsory)"    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'  "พรบ./Compulsory"                        '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'  "รวม/Total"                              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'  "วันแจ้งประกัน/Request Date"             '"' SKIP.                                           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'  "บริษัทประกันภย"                         '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'  "กรมธรรม์(พรบ.)"                         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'  "คลาสรถ72"                               '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'  "จำนวนที่นั่ง72"                         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'  "เลขสติ๊กเกอร์"                          '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'  "เลขที่ใบเสร็จ"                          '"' SKIP.                                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'  "วันเริ่มต้น Start"                      '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'  "วันสิ้นสุด Expiry"                      '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'  "กรมธรรม์เดิม"                           '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'  "กรมธรรม์ใหม่"                           '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'  "แพคเกจ/คลาสรถ"                          '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'  "จำนวนที่นั่ง70"                         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'  "Remark"                                 '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'  "เลขบัตรประชาชน"                         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'  "ที่อยู่จัดส่งเอกสาร"                    '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'  "ตำบล/Sub District"                      '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'  "อำเภอ/District"                         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'  "จังหวัด/Province"                       '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'  "รหัสไปรษณีย์/Postcode"                  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'  "F18_Line1"                              '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'  "F18_Line2"                              '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'  "F18_Line3"                              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'  "F18_Line4"                              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'  "F18_Line5"                              '"' SKIP.
FOR EACH wdetail2 NO-LOCK.
    ASSIGN nv_row =  nv_row + 1 .
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetail2.number            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail2.Contract_No       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail2.Ref_no            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail2.comdat            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail2.expdat            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail2.ntitle            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail2.insurce           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail2.Surename          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail2.Contact_Address   '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetail2.Sub_District      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetail2.District          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetail2.Province          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetail2.Postcode          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   wdetail2.Landmark          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   wdetail2.Brand             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   wdetail2.nColor            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   wdetail2.model             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   wdetail2.vehreg            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   wdetail2.vehreg2           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   wdetail2.chasno            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   wdetail2.engno             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   wdetail2.caryear           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   wdetail2.cc                '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   wdetail2.Weight            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   wdetail2.finance_Comp      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   wdetail2.Insurance_Type    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   wdetail2.ins_si            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   wdetail2.ins_amt           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   wdetail2.prem_70           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   wdetail2.prem_70net        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   wdetail2.prem_72           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   wdetail2.prem_72net        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   wdetail2.Request_Date      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'   wdetail2.companyins        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'   wdetail2.policy72          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'   wdetail2.class72           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'   wdetail2.seat72            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'   wdetail2.sckno             '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'   wdetail2.docno             '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'   wdetail2.comdat72          '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'   wdetail2.expdat72          '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'   wdetail2.prvpol            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'   wdetail2.policy            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'   wdetail2.class70           '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'   wdetail2.seat70            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'   wdetail2.remark            '"' SKIP.           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'   wdetail2.icno              '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'   wdetail2.sendContact_Addr  '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'   wdetail2.sendSub_District  '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'   wdetail2.sendDistrict      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'   wdetail2.sendProvince      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'   wdetail2.sendPostcode      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'   wdetail2.np_f18line1       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'   wdetail2.np_f18line2       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'   wdetail2.np_f18line3       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'   wdetail2.np_f18line4       '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'   wdetail2.np_f18line5       '"' SKIP.  
END.
OUTPUT STREAM ns2 CLOSE.
message "Export File Non-Til... Complete "  view-as alert-box.
FOR EACH wdetail2.
    DELETE wdetail2.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

