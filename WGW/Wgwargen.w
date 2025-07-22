&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
/* Connected Databases 
          sic_test         PROGRESS
*/
  File: 
  Description: 
  Input Parameters:
  <none>
  Output Parameters:
  <none>
  Author: 
  Created: 
  ------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.        */
/*------------------------------------------------------------------------*/
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
/***--- A50-0165 ---***/
/***--- Shukiat T. develop on 28/06/2007 ---***/
/***---
    ปรับโปรแกรมให้รองรับรูปแบบ Sticker ใหม่ 
    11 หลักแต่จะไม่มีการ chkmod ให้ทำการ check กับ
    field uwm301.drinam[9] แทน ---***/       
/***--- A50-0202 ---***/
/***--- Shukiat T.  Modi on 17/08/2007 ---***/
/***--- Default ค่า uwm100.trty11 ให้มีค่าเป็น "M" ---***/    
/* Modify By : Narin L. ขยาย Format ระบุชื่อผู้ขับขี่ [A54-0396]  */
/*note add 08/11/05*/
/*modify by : Kridtiya i. A56-0152 ปรับการนำเข้าตาม layout ใหม่ค่ะ */
/*modify by : Kridtiya i. A58-0103 ปรับการนำเข้างาน 2+ , 3+        */
/*modify   by : Kridtiya i. A58-0103 เพิ่มระบุชื่อผู้ขับขี่                 */ 
/* Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 เพิ่มเงื่อนไขการคำนวณเบี้ยจากโปรแกรมกลาง */
/*Modify by   : Kridtiya i. A65-0035 comment message error premium not on file */
DEF NEW SHARED VAR nv_producer AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR nv_agent    AS CHAR FORMAT "x(10)".
/*end note add*/
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno. 
def  var  nv_row  as  int  init  0.
DEFINE STREAM  ns1. 
DEFINE STREAM  ns2.
DEFINE STREAM  ns3.
DEF VAR nv_uom1_v AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEF VAR nv_uom2_v AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEF VAR nv_uom5_v AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEF VAR chkred    AS logi INIT NO.
DEF SHARED Var   n_User    As CHAR .
DEF SHARED Var   n_PassWd  As CHAR . /*block for test assign a490166*/
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
def New SHARED VAR nv_uom6_u as char.     /* Accessory  */
def var nv_chk as  logic.

DEF NEW  SHARED VAR nv_odcod    AS CHAR     FORMAT "X(4)".
DEF NEW  SHARED VAR nv_cons     AS CHAR     FORMAT "X(2)".
DEF New  shared VAR nv_prem     AS DECIMAL  FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_baseap   AS DECI     FORMAT ">>,>>>,>>9.99-".
DEF New  shared VAR nv_ded      AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.

DEF NEW  SHARED VAR   nv_gapprm  AS DECI    FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR   nv_pdprm   AS DECI    FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR   nv_prvprm  AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_41prm   AS INTEGER FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO.

DEF NEW   SHARED VAR  nv_ded1prm  AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW   SHARED VAR  nv_aded1prm AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF New   SHARED VAR  nv_ded2prm  AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW   SHARED VAR  nv_dedod    AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF New   SHARED VAR  nv_addod    AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW   SHARED VAR  nv_dedpd    AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW   SHARED VAR  nv_prem1    AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF New   SHARED VAR  nv_addprm   AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW   SHARED VAR  nv_totded   AS INTEGER   FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF New   SHARED VAR  nv_totdis   AS INTEGER   FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.

DEF New   SHARED VAR   nv_41cod1   AS CHARACTER FORMAT "X(4)".
DEF NEW   SHARED VAR   nv_41cod2   AS CHARACTER FORMAT "X(4)".
DEF New   SHARED VAR   nv_41       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEF New   SHARED VAR   nv_411prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEF NEW   SHARED VAR   nv_412prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEF New   SHARED VAR   nv_411var1  AS CHAR      FORMAT "X(30)".
DEF New   SHARED VAR   nv_411var2  AS CHAR      FORMAT "X(30)".
DEF NEW   SHARED VAR   nv_411var   AS CHAR      FORMAT "X(60)".
DEF New   SHARED VAR   nv_412var1  AS CHAR      FORMAT "X(30)".
DEF NEW   SHARED VAR   nv_412var2  AS CHAR      FORMAT "X(30)".
DEF New   SHARED VAR   nv_412var   AS CHAR      FORMAT "X(60)".
DEF  NEW  SHARED VAR   nv_42cod    AS CHARACTER FORMAT "X(4)".
DEF  NEW  SHARED VAR   nv_42       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEF  New  SHARED VAR   nv_42prm    AS DECI      FORMAT ">,>>>,>>9.99".
DEF  NEW  SHARED VAR   nv_42var1   AS CHAR      FORMAT "X(30)".
DEF  New  SHARED VAR   nv_42var2   AS CHAR      FORMAT "X(30)".
DEF  NEW  SHARED VAR   nv_42var    AS CHAR      FORMAT "X(60)".
DEF  New  SHARED VAR   nv_43cod    AS CHARACTER FORMAT "X(4)".
DEF  NEW  SHARED VAR   nv_43       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEF  New  SHARED VAR   nv_43prm    AS DECI      FORMAT ">,>>>,>>9.99".
DEF  New  SHARED VAR   nv_43var1   AS CHAR      FORMAT "X(30)".
DEF  NEW  SHARED VAR   nv_43var2   AS CHAR      FORMAT "X(30)".
DEF  New  SHARED VAR   nv_43var    AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_campcod   AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_camprem   AS DECI      FORMAT ">>>9".
DEF New  SHARED VAR   nv_campvar1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_campvar2  AS CHAR      FORMAT "X(30)".
DEF New  SHARED VAR   nv_campvar   AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_compcod   AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_compprm   AS DECI      FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR   nv_compvar1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_compvar2  AS CHAR      FORMAT "X(30)".
DEF New  SHARED VAR   nv_compvar   AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_basecod   AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_baseprm   AS DECI      FORMAT ">>,>>>,>>9.99-". 
DEF New  SHARED VAR   nv_basevar1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_basevar2  AS CHAR      FORMAT "X(30)".
DEF New  SHARED VAR   nv_basevar   AS CHAR      FORMAT "X(60)".
/******** load ***********/
DEF NEW  SHARED VAR   nv_cl_cod   AS CHAR       FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_cl_per   AS DECIMAL    FORMAT ">9.99".
DEF New  SHARED VAR   nv_lodclm   AS INTEGER    FORMAT ">>>,>>9.99-".
DEF             VAR   nv_lodclm1  AS INTEGER    FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR   nv_clmvar1  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar2  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar   AS CHAR       FORMAT "X(60)".
/*********** staff ***********/
DEF NEW  SHARED VAR   nv_stf_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_stf_per  AS DECIMAL   FORMAT ">9.99".
DEF New  SHARED VAR   nv_stf_amt  AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_stfvar1  AS CHAR      FORMAT "X(30)".
DEF New  SHARED VAR   nv_stfvar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_stfvar   AS CHAR      FORMAT "X(60)".
/*********** dsic ***********/
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
/*********usfbas************/
DEF NEW SHARED VAR nv_tariff  LIKE sicuw.uwm301.tariff.
DEF NEW SHARED VAR nv_comdat  LIKE sicuw.uwm100.comdat.
DEF NEW SHARED VAR nv_covcod  LIKE sicuw.uwm301.covcod.
DEF NEW SHARED VAR nv_class   AS CHAR    FORMAT "X(4)".
DEF NEW SHARED VAR nv_key_b   AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.


DEF NEW SHARED VAR   nv_drivno     AS INT       .
DEF NEW SHARED VAR   nv_drivcod    AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_drivprm    AS DECI  FORMAT ">>,>>>,>>9.99-".

DEF NEW SHARED VAR   nv_drivvar1   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_drivvar2   AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_drivvar    AS CHAR  FORMAT "X(60)".
/*------usecod--------------------*/
DEF NEW   SHARED VAR   nv_usecod   AS CHARACTER FORMAT "X(4)".
DEF NEW   SHARED VAR   nv_useprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW   SHARED VAR   nv_usevar1  AS CHAR  FORMAT "X(30)".
DEF NEW   SHARED VAR   nv_usevar2  AS CHAR  FORMAT "X(30)".
DEF NEW   SHARED VAR   nv_usevar   AS CHAR  FORMAT "X(60)".
/*----------nv_sicod--------------*/
DEF NEW  SHARED VAR   nv_sicod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_siprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_sivar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_sivar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_sivar   AS CHAR  FORMAT "X(60)".
def    New  shared var   nv_uom6_c  as  char.      /* Sum  si*/
def    New  shared var   nv_uom7_c  as  char.      /* Fire/Theft*/
/*------------nv_bipcod-------------*/
DEF NEW  SHARED VAR   nv_bipcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_bipprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_bipvar1 AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_bipvar2 AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_bipvar  AS CHAR  FORMAT "X(60)".
/*------------nv_biacod----------*/
DEF NEW  SHARED VAR   nv_biacod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_biaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_biavar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_biavar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_biavar   AS CHAR  FORMAT "X(60)".
/*------------nv_pdacod------------*/
DEF NEW  SHARED VAR   nv_pdacod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_pdaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_pdavar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_pdavar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_pdavar   AS CHAR  FORMAT "X(60)".
/******** usoper **********/
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
DEF VAR n_rencnt   LIKE sicuw.uwm100.rencnt .
def var nv_index   as   int  init  0. 
DEF VAR n_endcnt   LIKE sicuw.uwm100.endcnt.
def var n_comdat   LIKE sicuw.uwm100.comdat  NO-UNDO.
def var n_policy   LIKE sicuw.uwm100.policy  INITIAL "" .

DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEF VAR nv_reccnt   AS  INT  INIT  0.        /*all load record*/
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
def NEW SHARED var  nv_branch     LIKE sicsyac.XMM023.BRANCH.  /*note add on 30/11/2005*/
def var nv_undyr    as    char  init  ""    format   "X(4)".
def var n_newpol    Like  sicuw.uwm100.policy  init  "".
def var n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.
def New shared  var      nv_makdes    as   char    .
def New shared  var      nv_moddes    as   char.
DEF Var nv_lastno As       Int.
Def Var nv_seqno  As       Int.
DEF VAR sv_xmm600 AS       RECID.
/*--------- 722 --------*/
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

{wgw\wgwargen.i} /*ประกาศตัวแปร*/

/***--- Check SI ---***/
DEFINE VAR nv_maxdes AS CHAR.
DEFINE VAR nv_mindes AS CHAR.
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */

/***--- A50-0108 Shukiat T. ---***/
/***--- Modi on A50-0108 ---***/
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".
DEF VAR n_ratmin  AS INTE INIT 0.
DEF VAR n_ratmax  AS INTE INIT 0.
DEF VAR gv_id     AS CHAR FORMAT "X(8)" NO-UNDO.    
DEF VAR nv_pwd    AS CHAR NO-UNDO. 
DEF VAR dod1 AS INTEGER.
DEF VAR dod2 AS INTEGER.
DEF VAR dpd0 AS INTEGER.
DEF VAR ns_massage  AS CHAR FORMAT "x(100)" INIT "".

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
&Scoped-define FIELDS-IN-QUERY-br_wdetail /*wdetail.entdat wdetail.enttim wdetail.trandat wdetail.trantim *//*a490166*/ wdetail.poltyp wdetail.policy wdetail.renpol wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.iadd1 wdetail.iadd2 wdetail.iadd3 wdetail.iadd4 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.engno wdetail.chasno wdetail.caryear wdetail.vehuse wdetail.garage wdetail.stk wdetail.access wdetail.covcod wdetail.si wdetail.volprem wdetail.Compprem wdetail.fleet wdetail.ncb wdetail.loadclm wdetail.deductda wdetail.deductpd wdetail.benname wdetail.n_user wdetail.n_IMPORT wdetail.n_export wdetail.drivnam wdetail.drivnam1 wdetail.drivnam2 wdetail.drivbir1 wdetail.drivbir2 wdetail.drivage1 wdetail.drivage2 wdetail.producer wdetail.agent wdetail.comment WDETAIL.WARNING wdetail.cancel wdetail.redbook /*add new*/   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat ra_filetyp fi_branch fi_bchno ~
fi_producer fi_agent fi_prevbat fi_bchyr fi_filename bu_file buok ~
fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem bu_exit br_wdetail ~
bu_hpbrn bu_hpacno1 bu_hpagent fi_process fi_outputhead buok-2 RECT-370 ~
RECT-372 RECT-373 RECT-374 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat ra_filetyp fi_branch fi_bchno ~
fi_producer fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 ~
fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_proname ~
fi_completecnt fi_agtname fi_process fi_premtot fi_premsuc fi_outputhead 

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
     SIZE 14 BY 1.14
     FONT 6.

DEFINE BUTTON buok-2 
     LABEL "OK" 
     SIZE 5 BY .95
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 14 BY 1.14
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

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 63.5 BY .95
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
     SIZE 63.5 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outputhead AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 63.5 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_filetyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "กรมธรรม์70", 1,
"กรมธรรม์72", 2
     SIZE 51.67 BY .95
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 125 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 125 BY 13.19
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 125 BY 6
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 125 BY 3
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 122.33 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 6 FGCOLOR 0 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail C-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      /*wdetail.entdat  COLUMN-LABEL "Entry Date"
        wdetail.enttim  COLUMN-LABEL "Entry Time"
        wdetail.trandat COLUMN-LABEL "Trans Date"
        wdetail.trantim COLUMN-LABEL "Trans Time" *//*a490166*/
        wdetail.poltyp  COLUMN-LABEL "Policy Type"
        wdetail.policy  COLUMN-LABEL "Policy"
        wdetail.renpol  COLUMN-LABEL "Renew Policy"
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
        wdetail.vehuse  COLUMN-LABEL "Vehicle Use" 
        wdetail.garage  COLUMN-LABEL "Garage"
        wdetail.stk     COLUMN-LABEL "Sticker"
        wdetail.access  COLUMN-LABEL "Accessories"
        wdetail.covcod  COLUMN-LABEL "Cover Type"
        wdetail.si      COLUMN-LABEL "Sum Insure"
        wdetail.volprem COLUMN-LABEL "Voluntory Prem"
        wdetail.Compprem COLUMN-LABEL "Compulsory Prem"
        wdetail.fleet   COLUMN-LABEL "Fleet"
        wdetail.ncb     COLUMN-LABEL "NCB"
        wdetail.loadclm COLUMN-LABEL "Load Claim"
        wdetail.deductda COLUMN-LABEL "Deduct DA"
        wdetail.deductpd COLUMN-LABEL "Deduct PD"
        wdetail.benname COLUMN-LABEL "Benefit Name" 
        wdetail.n_user  COLUMN-LABEL "User"
        wdetail.n_IMPORT COLUMN-LABEL "Import"
        wdetail.n_export COLUMN-LABEL "Export"
        wdetail.drivnam  COLUMN-LABEL "Driver Name"
        wdetail.drivnam1 COLUMN-LABEL "Driver Name1"
        wdetail.drivnam2 COLUMN-LABEL "Driver Name2"
        wdetail.drivbir1 COLUMN-LABEL "Driver Birth1"
        wdetail.drivbir2 COLUMN-LABEL "Driver Birth2"
        wdetail.drivage1 COLUMN-LABEL "Driver Age1"
        wdetail.drivage2 COLUMN-LABEL "Driver Age2"
        
        wdetail.producer COLUMN-LABEL "Producer"
        wdetail.agent    COLUMN-LABEL "Agent"
        wdetail.comment FORMAT "x(35)" COLUMN-BGCOLOR  80 COLUMN-LABEL "Comment"
        WDETAIL.WARNING   COLUMN-LABEL "Warning"

        wdetail.cancel  COLUMN-LABEL "Cancel"
        wdetail.redbook COLUMN-LABEL "RedBook"  /*add new*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 123 BY 5.24
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 2.86 COL 32.5 COLON-ALIGNED NO-LABEL
     ra_filetyp AT ROW 2.86 COL 65.83 NO-LABEL
     fi_branch AT ROW 3.91 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.91 COL 17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_producer AT ROW 4.95 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 7.1 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 7.1 COL 65.5 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.24 COL 32.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9.24 COL 96.17
     buok AT ROW 9.67 COL 106.67
     fi_output1 AT ROW 10.24 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.24 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.29 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 13.33 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 13.33 COL 78 NO-LABEL
     bu_exit AT ROW 11.81 COL 106.67
     fi_brndes AT ROW 3.91 COL 52 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 16.19 COL 1.83
     bu_hpbrn AT ROW 3.91 COL 41.17
     bu_hpacno1 AT ROW 4.95 COL 49.17
     bu_hpagent AT ROW 6 COL 49.17
     fi_impcnt AT ROW 22.43 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_proname AT ROW 4.95 COL 52 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.48 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agtname AT ROW 6 COL 52 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 14.38 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_premtot AT ROW 22.43 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.48 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_outputhead AT ROW 8.19 COL 32.5 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     buok-2 AT ROW 8.19 COL 96.5 WIDGET-ID 4
     "Branch  :" VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 3.91 COL 24
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Load Date :":35 VIEW-AS TEXT
          SIZE 12.33 BY .95 AT ROW 2.86 COL 21.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 7.1 COL 66.16 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 13.33 COL 76.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Output Head Report :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 8.19 COL 11 WIDGET-ID 8
          BGCOLOR 2 FGCOLOR 7 
     "EXT. ตัวอย่างไฟล์" VIEW-AS TEXT
          SIZE 20 BY .95 AT ROW 8.19 COL 101.83 WIDGET-ID 10
          BGCOLOR 18 FGCOLOR 2 
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY .95 AT ROW 22.43 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 11.24 COL 10
          BGCOLOR 8 FGCOLOR 1 
     "Producer  Code :" VIEW-AS TEXT
          SIZE 17.17 BY .95 AT ROW 4.95 COL 16.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 12.29 COL 15.33
          BGCOLOR 8 FGCOLOR 1 
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.91 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 23.48 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 125.5 BY 23.95
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY .95 AT ROW 23.48 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 21 BY .95 AT ROW 7.1 COL 11.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 10.24 COL 14
          BGCOLOR 8 FGCOLOR 1 
     "    IMPORT TEXT FILE MOTOR ART (MOTOR LINE 70/72)" VIEW-AS TEXT
          SIZE 122 BY .95 AT ROW 1.33 COL 3.17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 22.43 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "File Load :":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 2.86 COL 54
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 13.33 COL 96.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TieS 4 01/03/2022" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 14.33 COL 103.83 WIDGET-ID 2
          BGCOLOR 8 FGCOLOR 1 
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 23.48 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 9.24 COL 10.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Agent Code  :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 6 COL 19.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 22.43 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 20 BY .95 AT ROW 13.33 COL 31.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.57 COL 1
     RECT-373 AT ROW 15.76 COL 1
     RECT-374 AT ROW 21.81 COL 1
     RECT-376 AT ROW 22.1 COL 2.17
     RECT-377 AT ROW 9.38 COL 105.17
     RECT-378 AT ROW 11.52 COL 105.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 125.5 BY 23.95
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
         TITLE              = "Load Text file ART[อรุณยุภา]"
         HEIGHT             = 23.95
         WIDTH              = 125.5
         MAX-HEIGHT         = 32.48
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 32.48
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
          SIZE 12.83 BY .95 AT ROW 7.1 COL 66.16 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 20 BY .95 AT ROW 13.33 COL 31.67 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .95 AT ROW 13.33 COL 76.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY .95 AT ROW 22.43 COL 58.83 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY .95 AT ROW 22.43 COL 95.83 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY .95 AT ROW 23.48 COL 58.83 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY .95 AT ROW 23.48 COL 96 RIGHT-ALIGNED           */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

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

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Load Text file ART[อรุณยุภา] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Load Text file ART[อรุณยุภา] */
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
          wdetail.poltyp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.renpol:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
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
          wdetail.access:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.covcod:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.si:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
          wdetail.volprem:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.Compprem:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.fleet:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.     
          wdetail.ncb:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.loadclm:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.deductda:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductpd:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.benname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.n_user:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.n_IMPORT:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_export:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivnam:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.drivnam1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivnam2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivbir1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivbir2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivage1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivage2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
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
          wdetail.access:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.covcod:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.si:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.volprem:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.Compprem:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.fleet:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.ncb:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.loadclm:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductda:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductpd:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.benname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_user:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_IMPORT:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_export:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivnam:FGCOLOR IN BROWSE BR_WDETAIL = s  NO-ERROR.  
          wdetail.drivnam1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivnam2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivbir1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivbir2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivage1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivage2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    FOR EACH ws0m009 .
        DELETE ws0m009.
    END.
    ASSIGN
        fi_completecnt:FGCOLOR = 2
        fi_premsuc:FGCOLOR     = 2 
        fi_bchno:FGCOLOR       = 2
        fi_completecnt         = 0
        fi_premsuc             = 0
        fi_bchno               = ""
        fi_premtot             = 0
        fi_impcnt              = 0
        fi_process             = "Start Load Data to GW...".
    RUN proc_initail.
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
    /*IF fi_usrcnt <= 0  THEN DO:
        MESSAGE "Policy Count can't Be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_usrcnt.
        RETURN NO-APPLY.
    END. 
    IF fi_usrprem <= 0  THEN DO:
        MESSAGE "Total Net Premium can't Be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_usrprem.
        RETURN NO-APPLY.
    END.*/ /***---a490166 ---***/
    ASSIGN fi_output1 = INPUT fi_output1
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
        MESSAGE "Plese Input Batch File Name...!!!"  VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output3.
        RETURN NO-APPLY.
    END.
    nv_batchyr = INPUT fi_bchyr.
    /*--- Batch No ---*/
    IF nv_batprev = "" THEN DO:                 /* เป็นการนำเข้าข้อมูลครั้งแรกของไฟล์นั้นๆ */
        FIND LAST uzm700 USE-INDEX uzm70001     WHERE
            uzm700.bchyr   = nv_batchyr         AND
            uzm700.branch  = TRIM(nv_batbrn)    AND
            uzm700.acno    = TRIM(fi_producer)  NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:                /*ได้ running 4 หลักหลัง Branch */
            nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102     /*Shukiat T. chg Index btm10006 ---> uzm70102 31/10/2006*/
                WHERE uzm701.bchyr = nv_batchyr         AND
                uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN  
                ASSIGN nv_batcnt = uzm701.bchcnt 
                nv_batrunno = nv_batrunno + 1.
        END.
        ELSE DO:  /* ยังไม่เคยมีการนำเข้าข้อมูลสำหรับ Account No. และ Branch นี้ */
            ASSIGN nv_batcnt  = 1
                nv_batrunno   = 1 .
        END.
        nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END.
    ELSE DO:    /* ระบุ batch file เดิมที่เคยนำเข้าแล้ว */
        nv_batprev = INPUT fi_prevbat.
        FIND LAST uzm701  USE-INDEX uzm70102       /*Shukiat T. chg Index btm10006 --->uzm70102 31/10/2006*/
            WHERE uzm701.bchyr = nv_batchyr    AND
            uzm701.bchno = CAPS(nv_batprev)    NO-LOCK NO-ERROR NO-WAIT.
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
    ASSIGN fi_loaddat = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
        fi_producer   = INPUT fi_producer    fi_agent        = INPUT fi_agent 
        fi_bchyr      = INPUT fi_bchyr       fi_prevbat      = INPUT fi_prevbat
        fi_usrcnt     = INPUT fi_usrcnt      fi_usrprem      = INPUT fi_usrprem
        nv_imppol     = fi_usrcnt            nv_impprem      = fi_usrprem 
        nv_tmppolrun  = 0                    nv_daily        = ""
        nv_reccnt     = 0                    nv_completecnt  = 0
        nv_netprm_t   = 0                    nv_netprm_s     = 0
        nv_batbrn     = fi_branch .
    IF ra_filetyp = 1 THEN  RUN proc_assign  .   /*A56-0152 import 70*/
    ELSE  RUN proc_assign2  .                    /*A56-0152 import 72*/
    FOR EACH wdetail:   
        IF WDETAIL.POLTYP = "70" OR WDETAIL.POLTYP = "72" THEN DO:
            ASSIGN  nv_reccnt  = nv_reccnt   + 1 
                nv_netprm_t    = nv_netprm_t + decimal(wdetail.volprem) 
                wdetail.pass   = "Y"
                WDETAIL.POLTYP = "V" + WDETAIL.POLTYP.     
        END.
        ELSE DO :   
            DELETE WDETAIL.
        END.
    END.
    /***--- ไมมี Record ไม่ Run Batch ---***/
    /*IF  nv_reccnt = 0 THEN DO: 
    MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
    RETURN NO-APPLY.
    END.*/
    /* comment by : Ranu I. A63-0138...
    /*Add by Kridtiya i. A63-0472*/
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
    /*Add by Kridtiya i. A63-0472*/
    ...end A64-0138...*/
    IF nv_chkerror = "" THEN DO:
        /***---A490166 Run Batch No. ---***/ 
        RUN wgw\wgwbatch.p    (INPUT        fi_loaddat ,     /* DATE  */
                               INPUT        nv_batchyr ,     /* INT   */
                               INPUT        fi_producer,     /* CHAR  */ 
                               INPUT        nv_batbrn  ,     /* CHAR  */
                               INPUT        fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                               INPUT        "WGWARGEN" ,     /* CHAR  */
                               INPUT-OUTPUT nv_batchno ,     /* CHAR  */
                               INPUT-OUTPUT nv_batcnt  ,     /* INT   */
                               INPUT        nv_imppol  ,     /* INT   */
                               INPUT        nv_impprem).
        ASSIGN  fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
        DISP  fi_bchno   WITH FRAME fr_main.
        /*RUN proc_chktest1.*/    /*Kridtiyai .A56-0152*/
        RUN proc_checkdata01.     /*Kridtiyai .A56-0152*/
    END.   /*nv_chkerror = ""*/
    
    FOR EACH wdetail WHERE wdetail.pass = "y"  :
        ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + decimal(wdetail.volprem) . 
    END.
    /***------------ update ข้อมูลที่  uzm701 ------------***/
    ASSIGN  nv_rectot = nv_reccnt 
            nv_recsuc = nv_completecnt. 
    
    /*--- Check Record ---*/
    IF /*nv_imppol <> nv_rectot OR*/
        /*nv_imppol <> nv_recsuc  OR*/
        /*(nv_imppol = 0) OR*/
        nv_rectot <> nv_recsuc  THEN
        nv_batflg = NO .
    ELSE  /*--- Check Premium ---*/
        /*IF /*nv_impprem  <> nv_netprm_t OR*/
        /*nv_impprem  <> nv_netprm_s OR*/
        nv_netprm_t <> nv_netprm_s THEN
        nv_batflg = NO. ELSE */
        nv_batflg = YES.

    FIND LAST uzm701 USE-INDEX uzm70102 /*Shukiat T. chg Index btm10009 ---> uzm70102 31/10/2006*/
        WHERE uzm701.bchyr   = nv_batchyr  AND
        uzm701.bchno         = nv_batchno  AND
        uzm701.bchcnt        = nv_batcnt   NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        ASSIGN
            /***--- ไม่มีการระบุ Tax Stamp ไว้ใน Text File ---***/
            /*uzm701.rec_suc     = nv_recsuc */  /***--- 26-10-2006 change field Name ---***/
            uzm701.recsuc      = nv_recsuc     /***--- 31-10-2006 change field Name ---***/
            uzm701.premsuc     = nv_netprm_s   /*nv_premsuc*/
            /*uzm701.rec_tot     = nv_rectot*/   /***--- 26-10-2006 change field Name ---***/
            uzm701.rectot      = nv_rectot     /***--- 26-10-2006 change field Name ---***/
            uzm701.premtot      = nv_netprm_t   /*nv_premtot*/ 
            /*uzm701.sucflg1     = nv_batflg*/  /***--- 26-10-2006 change field Name ---***/
            uzm701.impflg      = nv_batflg    /***--- 26-10-2006 change field Name ---***/
            /*uzm701.batchsta    = nv_batflg*/  /***--- 26-10-2006 change field Name ---***/
            uzm701.cnfflg      = nv_batflg  .  
           /* YES  สามารถนำเข้าข้อมูลได้หมด ไม่มี error  NO   นำเข้าข้อมูลได้ไม่ได้ไม่หมด  */
    END.
    /***---------- END update ข้อมูลที่  uzm701 ---------***/
    RELEASE uzm700.          /*kridtiya i. A56-0152*/
    RELEASE uzm701.          /*kridtiya i. A56-0152*/
    RELEASE sic_bran.uwm100. /*kridtiya i. A56-0152*/
    RELEASE sic_bran.uwm120. /*kridtiya i. A56-0152*/
    RELEASE sic_bran.uwm130. /*kridtiya i. A56-0152*/
    RELEASE sic_bran.uwm301. /*kridtiya i. A56-0152*/
    RELEASE brstat.detaitem. /*kridtiya i. A56-0152*/
    RELEASE sicsyac.xzm056.  /*kridtiya i. A56-0152*/
    RELEASE sicsyac.xmm600.  /*kridtiya i. A56-0152*/
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.  /*kridtiya i. A56-0152*/
    /*...end A64-0138...*/
    ASSIGN
        fi_impcnt      = nv_rectot
        fi_premtot     = nv_netprm_t
        fi_completecnt = nv_recsuc
        fi_premsuc     = nv_netprm_s 
        .
    DISP fi_process WITH FRAM fr_main.

    IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".
    /***--- a490166 05/10/2006 ---***/
    IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_process     = "      have batch file error..!! "
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno      :FGCOLOR = 6. 
        DISP fi_process fi_completecnt fi_premsuc WITH FRAME fr_main.
        MESSAGE "Batch Year  : " STRING(nv_batchyr)     SKIP
                "Batch No.   : " nv_batchno             SKIP
                "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
                TRIM(nv_txtmsg)                         SKIP
                "Please check Data again."   
                VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".        
    END.
    ELSE IF (nv_batflg = YES) AND (nv_completecnt > 0 ) THEN DO: 
        ASSIGN
            fi_process  = "Process Complete"
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR     = 2.

        DISP fi_process fi_completecnt fi_premsuc WITH FRAME fr_main.

        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.
    /* add by : A64-0138 */
    RUN   proc_open.    
    DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    ASSIGN ns_massage = "".
    /*output*/
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .
    /***--- end a400166 ---***/
    /* comment by : A64-0138....
    RUN   proc_open.    
    DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    ASSIGN ns_massage = "".
    /*output*/
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .
    RELEASE uzm700.          /*kridtiya i. A56-0152*/
    RELEASE uzm701.          /*kridtiya i. A56-0152*/
    RELEASE sic_bran.uwm100. /*kridtiya i. A56-0152*/
    RELEASE sic_bran.uwm120. /*kridtiya i. A56-0152*/
    RELEASE sic_bran.uwm130. /*kridtiya i. A56-0152*/
    RELEASE sic_bran.uwm301. /*kridtiya i. A56-0152*/
    RELEASE brstat.detaitem. /*kridtiya i. A56-0152*/
    RELEASE sicsyac.xzm056.  /*kridtiya i. A56-0152*/
    RELEASE sicsyac.xmm600.  /*kridtiya i. A56-0152*/
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.  /*kridtiya i. A56-0152*/
    ...end A64-0138...*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok-2 C-Win
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
        "Entry date   " 
        "Entry time   " 
        "Trans Date   " 
        "Trans Time   " 
        "Policy Type  " 
        "Policy       " 
        "Renew Policy "  
        "Comm Date    " 
        "Expiry date  " 
        "Compulsory   " 
        "Title name   " 
        "Insured name "  
        "Ins addr1    " 
        "Ins addr2    " 
        "Ins addr3    " 
        "Ins addr4    " 
        "Premium Package"   
        "Sub Class" 
        "Brand    " 
        "Mode     " 
        "Cc       " 
        "Weight   " 
        "Seat     " 
        "Body     " 
        "Vehicle registration"     
        "Engine no   "
        "Chassis no  "
        "Car Year    "
        "Car Province"    
        "Vehicle Use "    
        "Garage      "          
        "Sticker no  "                  
        "Accessories "          
        "Cover Type  "
        "Sum Insured "      
        "Voluntory Premium "
        "Compulsory Prem "      
        "Fleet %     "
        "NCB %       "
        "Load Claim  "          
        "Deduct DA   "          
        "Deduct PD   "          
        "Benificiary "    
        "User id     "    
        "Import      "    
        "Export      "    
        "Drive name n"    
        "Driver name1"                  
        "Driver name2"                  
        "Driver Birthdate1"             
        "Driver Birthdate2"             
        "Driver age1"    
        "Driver age2"                   
        "Cancel  "  
        "Producer"  
        "Agent   "  
        "Code Red Book "                
        "Note  "   
        "ATTACH_NOTE"     
        "IDENT_CARD"                
        "BUSINESS REGISTRATION"         
        "BASE"      
        "campaignno"  
        "TPBIPer"     
        "TPBIAcc"     
        "pTPPD  "     
        "ry41   "     
        "ry42   "     
        "ry43   "  .

    OUTPUT CLOSE.
    message "Export File  Complete"  view-as alert-box.
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
    DEFINE VARIABLE cvData     AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed  AS LOGICAL INITIAL TRUE.
    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS     "CSV (Comma Delimited)"   "*.csv",
        "Data Files (*.dat)"     "*.dat"
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
    Run  whp\whpbrn01(Input-output   fi_branch,  
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
            sicsyac.xmm600.acno  =  Input fi_agent  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_agent.
            RETURN NO-APPLY.  
        END.
        ELSE DO:     /*note modi on 10/11/2005*/
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


&Scoped-define SELF-NAME fi_bchyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr C-Win
ON LEAVE OF fi_bchyr IN FRAME fr_main
DO:
    fi_bchyr   = INPUT fi_bchyr.
    nv_batchyr = INPUT fi_bchyr.
    IF nv_batchyr <= 0 THEN DO:
        MESSAGE "Batch Year Error...!!!".  
        APPLY "entry" TO fi_bchyr.
        RETURN NO-APPLY.
    END.
    DISP fi_bchyr WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
    fi_branch = caps(INPUT fi_branch) .
    IF  Input fi_branch  =  ""  Then do:
        Message "กรุณาระบุ Branch Code ." View-as alert-box.
        Apply "Entry"  To  fi_branch.
    END.
    Else do:
        FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
            sicsyac.xmm023.branch   =  Input  fi_branch   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
            Message  "Not on Description Master File xmm023"   View-as alert-box.
            Apply "Entry"  To  fi_branch.
            RETURN NO-APPLY.
        END.
        ASSIGN 
            fi_branch  =  CAPS(Input fi_branch) 
            fi_brndes  =  sicsyac.xmm023.bdes.
    END.
    Disp fi_branch  fi_brndes  With Frame  fr_main.
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


&Scoped-define SELF-NAME fi_outputhead
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outputhead C-Win
ON LEAVE OF fi_outputhead IN FRAME fr_main
DO:
    fi_outputhead = INPUT fi_outputhead .
    DISP fi_outputhead WITH FRAM fr_main.

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
    END. */   /*nv_batprev <> " "*/

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
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_producer  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producer.
            RETURN NO-APPLY.      
        END.
        ELSE DO:
            ASSIGN
                fi_proname  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  caps(INPUT  fi_producer)  
                nv_producer =  fi_producer .              
        END.
    END.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
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


&Scoped-define SELF-NAME ra_filetyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_filetyp C-Win
ON VALUE-CHANGED OF ra_filetyp IN FRAME fr_main
DO:
    ra_filetyp = INPUT ra_filetyp .
    DISP ra_filetyp WITH FRAM fr_main.
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
  ASSIGN
  gv_prgid   = "Wgwargen" 
  gv_prog    = "Load Text & Generate Aroonyupa"
  ra_filetyp = 1  
  fi_loaddat = TODAY.
  DISP fi_loaddat ra_filetyp  WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
  fi_producer = "B2L0297"
  fi_agent    = "B2L0297"
  fi_branch   = "L"
  fi_bchyr    = YEAR(TODAY) .
  DISP fi_producer fi_agent fi_bchyr fi_branch WITH FRAME fr_main.
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
  DISPLAY fi_loaddat ra_filetyp fi_branch fi_bchno fi_producer fi_agent 
          fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 
          fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_proname fi_completecnt 
          fi_agtname fi_process fi_premtot fi_premsuc fi_outputhead 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loaddat ra_filetyp fi_branch fi_bchno fi_producer fi_agent 
         fi_prevbat fi_bchyr fi_filename bu_file buok fi_output1 fi_output2 
         fi_output3 fi_usrcnt fi_usrprem bu_exit br_wdetail bu_hpbrn bu_hpacno1 
         bu_hpagent fi_process fi_outputhead buok-2 RECT-370 RECT-372 RECT-373 
         RECT-374 RECT-376 RECT-377 RECT-378 
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
    
    wdetail.tariff = "9". /*a490166*/
    /***--- a490166 Note block ---***/
    /***---
    loop_tariff:
    REPEAT:
    /*---------  CHK 72 -------------*/
    wdetail.tariff = "9". /*a490166*/
    MESSAGE "Please Enter Tariff"   UPDATE wdetail.tariff.     /*COMPULSORY*/

         /*--------- tariff --------------*/
         WDETAIL.COMMENT = " ".
         FIND sicsyac.xmm108 USE-INDEX xmm10801   WHERE
              sicsyac.xmm108.class  = wdetail.subclass  AND
              sicsyac.xmm108.tariff = wdetail.tariff NO-LOCK NO-ERROR.
         IF NOT AVAIL sicsyac.xmm108 THEN DO:
             MESSAGE "ไม่พบ Tariffs ที่ Permitt กับ Class ในระบบ" VIEW-AS ALERT-BOX.
             ASSIGN /*a490166*/
             wdetail.comment = wdetail.comment  + "| ไม่พบ Tariffs ที่ Permitt กับ Class ในระบบ"
             wdetail.pass    = "N"
             WDETAIL.OK_GEN  = "N".
             NEXT.
         END.
         FIND sicsyac.xmm117 USE-INDEX  xmm11701  WHERE
              sicsyac.xmm117.branch = fi_branch  AND
              sicsyac.xmm117.tariff =  wdetail.tariff NO-LOCK NO-ERROR.
         IF NOT AVAIL sicsyac.xmm117 THEN DO:
              MESSAGE "ไม่พบ Tariff  ที่ Permitt กับ Branch ในระบบ" VIEW-AS ALERT-BOX.
              ASSIGN /*a490166*/
              wdetail.comment = wdetail.comment + "| ไม่พบ Tariff  ที่ Permitt กับ Branch ในระบบ"
              wdetail.pass    = "N"
              WDETAIL.OK_GEN  = "N".
              NEXT.
          END.  
          IF wdetail.comment = "" THEN
              LEAVE loop_tariff.
              NEXT.
              
    END. /*repeat*/
    ---***/
    /***--- end a490166---***/
     
    /************** v72 comp y **********/
    IF wdetail.poltyp = "v72" THEN DO:
       IF wdetail.compul <> "y" THEN DO:
           MESSAGE "poltyp เป็น v72 Compulsory ต้องเป็น y" VIEW-AS ALERT-BOX.
           ASSIGN /*a490166*/
           wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
           wdetail.pass    = "N"
           WDETAIL.OK_GEN  = "N".
           /*NEXT.*/
       END.
    END.

   IF wdetail.compul = "y" THEN DO:
       IF wdetail.stk = "" THEN DO:
           MESSAGE "Compulsory เป็น y ต้องมีเลข Sticker" VIEW-AS ALERT-BOX.
           ASSIGN /*a490166*/
           wdetail.comment = wdetail.comment + "| Compulsory เป็น y ต้องมีเลข Sticker"
           wdetail.pass    = ""
           WDETAIL.OK_GEN  = "N".
           /*NEXT.*/
       END.
       /*--Comment by amparat c. a51-0253--
       /***--- A50-0204 Shukiat T. Add ---***/
       IF LENGTH(wdetail.stk) = 10  THEN wdetail.stk = "0" + wdetail.stk.
       IF LENGTH(wdetail.stk) <> 11 THEN DO:
           IF LENGTH(wdetail.stk) <> 9 THEN DO:
                   MESSAGE "เลข Sticker ต้องเป็น 9 หรือ 11 หลักเท่านั้น" VIEW-AS ALERT-BOX.
                   ASSIGN /*a490166*/
                   wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 9 หรือ 11 หลักเท่านั้น"
                   wdetail.pass    = ""
                   WDETAIL.OK_GEN  = "N".
           END.
       END.
       /***--- End A50-0204 Shukiat T. ---***/
       --Comment by amparat c. a51-0253--*/
       /*--Str amparat C. A51-0253--*/
       IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
       
       IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN DO: 
          MESSAGE "เลข Sticker ต้องเป็น 9 หรือ 11 หลักเท่านั้น" VIEW-AS ALERT-BOX.
          ASSIGN /*a490166*/
          wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
          wdetail.pass    = ""
          WDETAIL.OK_GEN  = "N".
       END.
       /*--end amparat C. A51-0253--*/
   END.

    /*---------- class --------------*/

      FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail.subclass
      NO-LOCK NO-ERROR.
       IF AVAIL sicsyac.xmm016 THEN DO:
       END.
       ELSE DO:
            MESSAGE "ไม่พบ Class นี้ในระบบ" VIEW-AS ALERT-BOX.
            ASSIGN /*a490166*/
            wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
            wdetail.pass    = "N"
            WDETAIL.OK_GEN  = "N".
            /*NEXT.*/
       END.
     /*------------- poltyp ------------*/

            IF wdetail.poltyp <> "v72" THEN DO:
               FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
                     sicsyac.xmd031.poltyp = wdetail.poltyp  AND
                     sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
               IF NOT AVAIL sicsyac.xmd031 THEN DO:
                     MESSAGE "ไม่พบ Class ที่เป็นของ Policy Typeนี้" VIEW-AS ALERT-BOX.
                     ASSIGN /*a490166*/
                     wdetail.pass    = "N"
                     wdetail.comment = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
                     WDETAIL.OK_GEN  = "N".
                     /*NEXT.*/
               END.
            END. 
    
    /*---------- covcod ----------*/
     wdetail.covcod = CAPS(wdetail.covcod).
     
     FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
          sicsyac.sym100.tabcod = "U013"    AND
          sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.sym100 THEN DO:
          MESSAGE "ไม่พบ Cover Type นี้ในระบบ"  VIEW-AS ALERT-BOX.
          ASSIGN /*a490166*/
          wdetail.pass    = "N"
          wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
          WDETAIL.OK_GEN  = "N".
          /*NEXT.*/
          END.
     
     FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
                sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
     IF NOT AVAILABLE sicsyac.xmm106 THEN DO:
          MESSAGE "ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"  VIEW-AS ALERT-BOX.
          ASSIGN /*a490166*/     
          wdetail.pass    = "N"  
          wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
          WDETAIL.OK_GEN = "N".
          /*NEXT.          */
     END.
    /*--------- modcod --------------*/
    /*--- A490166 Modi Code 4 on column Redbook ---***/
    chkred = NO.
    IF wdetail.redbook <> "" THEN DO: /*กรณีที่มีการระบุ Code รถมา*/
        FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
             sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
        IF NOT AVAIL sicsyac.xmm102 THEN DO:
             MESSAGE "ไม่พบ Makes/Models นี้ในระบบ " view-as alert-box.
             ASSIGN /*a490166*/     
             wdetail.pass    = "N"  
             wdetail.comment = wdetail.comment + "| not find on table xmm102"
             WDETAIL.OK_GEN = "N"
             chkred = NO
             wdetail.redbook = " ".
        END. 
        ELSE DO:
             chkred = YES.
        END.
    END.
    IF chkred = NO  THEN DO:
        FIND LAST sicsyac.xmm102 WHERE sicsyac.xmm102.modest = wdetail.brand + wdetail.model AND
                                       sicsyac.xmm102.engine = INTE(wdetail.cc)              AND 
                                       sicsyac.xmm102.tons   = INTE(wdetail.weight)          AND
                                       sicsyac.xmm102.seats  = INTE(wdetail.seat)
        NO-LOCK NO-ERROR.
        IF NOT AVAIL sicsyac.xmm102  THEN DO:
            MESSAGE "not find on table xmm102".
            ASSIGN /*a490166*/     
            wdetail.pass    = "N"  
            wdetail.comment = wdetail.comment + "| not find on table xmm102"
            WDETAIL.OK_GEN = "N".
            /*NEXT.*/
        END.
        ELSE DO:
            wdetail.redbook = sicsyac.xmm102.modcod. 
        END.
    END.
        
        
        /*-------- vehuse   --------------*/
        FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
             sicsyac.sym100.tabcod = "U014"    AND
             sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
        IF NOT AVAIL sicsyac.sym100 THEN DO:
                MESSAGE "ไม่พบ Veh.Usage ในระบบ " VIEW-AS ALERT-BOX.
                ASSIGN /*a490166*/     
                wdetail.pass    = "N"  
                wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
                WDETAIL.OK_GEN  = "N".
                /*NEXT.*/
        END.

                /***---Start 16/11/2006 For 72---***/
        ASSIGN
        nv_docno  = " "
        nv_accdat = TODAY.

        /***--- Docno ---***/
        IF wdetail.docno <> " " THEN DO:
                FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
                           sicuw.uwm100.trty11 = "M" AND
                           sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999")
                NO-LOCK NO-ERROR .
                IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy)
                THEN DO:
                  MESSAGE "Receipt is Dup. on uwm100 :" sicuw.uwm100.policy
                          STRING(sicuw.uwm100.rencnt,"99") + "/" +
                          STRING(sicuw.uwm100.endcnt,"999") sicuw.uwm100.renno uwm100.endno.
                  ASSIGN /*a490166*/     
                  wdetail.pass    = "N"  
                  wdetail.comment = "Receipt is Dup. on uwm100 :" + string(sicuw.uwm100.policy,"x(16)") +
                                    STRING(sicuw.uwm100.rencnt,"99")  + "/" +
                                    STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
                  WDETAIL.OK_GEN  = "N".
                END.
                ELSE DO:
                    nv_docno = wdetail.docno.
                END.
        END.
        
        /***--- Account Date ---***/
        IF wdetail.accdat <> " "  THEN DO:
            nv_accdat = date(wdetail.accdat).
        END.
        ELSE DO:
            nv_accdat = TODAY.
        END.
        /***--- End 16/11/2006 ---***/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_721 C-Win 
PROCEDURE proc_721 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/***--- A490166 Block ชั่วคราว    28/09/2006
IF wdetail.policy <> "" THEN DO:
                         /*have stk no.*/
                         
                         If  wdetail.stk  <>  ""  Then do:
                        chr_sticker = STRING(wdetail.stk).  
                        Run  wuz\wuzchmod.
                        
                            If  Substr(chr_sticker,11,1)  <>  Substr(wdetail.stk,11,1)  Then do:
                                Message "Sticker Number"  wdetail.stk "ใช้ Generate ไม่ได้ เนื่องจาก Modulo Error"  view-as alert-box.
                                wdetail.comment = "Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Modulo Error".
                                NEXT.                                
                            END.
                        
                            Find Last  uwm100  Use-index uwm10001 Where
                                       uwm100.policy =  wdetail.policy   no-error no-wait.
                                     If  avail uwm100 Then  do:
                                            If  uwm100.name1  <>  ""  Or uwm100.comdat <> ? 
                                            Or  uwm100.releas  =  Yes   Then do:
                                                
                                                Message "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  view-as alert-box.
                                                wdetail.comment = "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว ".
                                                WDETAIL.OK_GEN = "N".
                                                NEXT.
                                            End. 
                                                                                        
                                            Find  first  uwm301 Use-index uwm30190 Where
                                                         uwm301.sckno  =   Integer(substr(wdetail.stk,2,9))     No-error no-wait.
                                                       If  avail uwm301 Then do:          
                                                            
                                                                If  uwm301.policy <>  uwm100.policy  Then do: 
                                                                        Message "หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้วโดยเลขที่กรมธรรม์ ." uwm301.policy  View-as alert-box.
                                                                        wdetail.comment = "หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว".
                                                                        WDETAIL.OK_GEN = "N".
                                                                        NEXT.
                                                                End.
                                            End.  /* avail  301 */
                                            /*n_policy  =  uwm100.policy.*/
                                    End.  /* avail uwm100 */
                                    Else do: /*not avail uwm100*/
                                        
                                        
                                        Create  uwm100.
                                        ASSIGN
                                                 
                                                 uwm100.policy =  wdetail.policy
                                                 uwm100.rencnt =  0              
                                                 uwm100.renno  =  ""
                                                 uwm100.endcnt =  0.
                                                 
                                        


                                                 
                                    End.  /*  not avail 100 */
                         End.   /* policy <> "" & sticker <>  "" */
/*---------------------------------------------------------------------------------*/                         
END.

IF wdetail.policy = " " THEN DO:
    

             If  wdetail.stk <> ""  Then do:    /*Case3 policy = "" & stk <> ""*/
                 chr_sticker  =  wdetail.stk.                                    

                 /*Run  wuz\wuzchmod.*/
                 If  Substr(chr_sticker,11,1)  <>  Substr(wdetail.stk,11,1)  Then  do:
                 Message "Sticker Number"  wdetail.stk "ใช้ Generate ไม่ได้ เนื่องจาก Modulo Error"  view-as alert-box.
                 wdetail.comment = "Sticker Numberใช้ Generate ไม่ได้ เนื่องจาก Modulo Error".
                 WDETAIL.OK_GEN = "N".
                 NEXT.
                 End.
                 Find  first  uwm301 Use-index uwm30190 Where
                              uwm301.sckno  =   Integer(substr(wdetail.stk,2,9))     No-error no-wait.
                    If  avail uwm301 Then do:          
                           Find First uwm100 Use-index uwm10001 WHERE /*หาเลขstk*/
                                      uwm100.policy  =  uwm301.policy      And
                                      uwm100.rencnt  =  uwm301.rencnt     And
                                      uwm100.endcnt  =  uwm301.endcnt   no-error no-wait.
                                   If  avail uwm100  Then do:                           /*ดูว่าpolicy จาก301 มีใน100 ไหม*/
                                           If  uwm100.name1 <>  ""  Or  uwm100.comdat <> ?
                                            Or uwm100.releas  =  Yes
                                           Then do: 
                                           Message " กรมธรรม์นี้ได้ถูกใช้ไปแล้ว " View-as alert-box.
                                           wdetail.comment = " กรมธรรม์นี้ได้ถูกใช้ไปแล้ว ".
                                           WDETAIL.OK_GEN = "N".
                                           NEXT.
                                           End. 
                                           ELSE DO:
                                               MESSAGE "ไม่มีหมายเลขกรมธรรณ์ที่จองไว้ ใน uwm100" VIEW-AS ALERT-BOX.
                                               wdetail.comment =  "มีเลข sticker แต่ไม่มีเบอร์จองใน uwm100" .
                                               NEXT.

                                           END.

                                   End.  /*  avail  uwm100 */
                   End.  /* avail  301 */
                   Else do:  
                   Repeat:
                            nv_branch = fi_branch.
                            Message "Change Branch : "  Update nv_branch. 
                            FIND xmm023 WHERE xmm023.branch =  nv_branch
                            NO-LOCK NO-ERROR NO-WAIT.
                                   IF NOT AVAILABLE xmm023 THEN DO:
                                   MESSAGE  "Not found on file xmm023" View-as alert-box.
                            END.
                            Else leave.
                   End.      
                   MESSAGE    "Process policy" wdetail.policy   skip
                                       "Do you really want to run auto policy ?"
                   VIEW-AS ALERT-BOX QUESTION BUTTONS YES-No-Cancel
                   TITLE ""  UPDATE  choice1  AS LOGICAL.
                   Case choice1:
                            When True Then do:     

                                    Run wuz\wuzpolno(INPUT  YES,
                                                                  INPUT         wdetail.poltyp,
                                                                  INPUT         nv_branch,
                                                                  INPUT         nv_undyr ,
                                                                  INPUT-OUTPUT  wdetail.policy ,
                                                                  INPUT-OUTPUT  nv_message).

                             If  nv_message  <>  ""  Then   Return.
                             Else  do:

                                    Create  uwm100.
                                    ASSIGN
                                          uwm100.policy =  CAPS(wdetail.policy)
                                          uwm100.renno  = ""
                                          /*uwm100.prvpol  = tlt.filler1*/
                                          uwm100.rencnt  = 0
                                          uwm100.endcnt =  0 .


                              End.         
                       End.  /* ture */
                       When False Then do:  /* not auto run */
                              Loop_putpol:
                              Repeat :
                                   n_rencnt  =  0.
                                   n_endcnt  =  0.
                                   Message "Enter the New policy"  Update n_newpol. 
                                   If  Substr(n_newpol,2,1)  <> nv_branch  Then do:
                                         Message "Branch ไม่ตรงกับที่ระบุไว้ กรุณาระบุใหม่"  View-as alert-box.
                                         Message "Enter the New policy"  Update n_newpol. 
                                   End.
                                   Find First uwm100 Use-index uwm10001 Where
                                                      uwm100.policy =   n_newpol               And
                                                      uwm100.rencnt =   n_rencnt                 And
                                                      uwm100.endcnt =  n_endcnt               no-error no-wait.
                                               If  Not Avail uwm100 Then do:
                                                     Create  uwm100.
                                                     ASSIGN
                                                          uwm100.policy =  CAPS(n_newpol)     /*n_policy  */
                                                          /*uwm100.prvpol  =  tlt.filler1*/
                                                          uwm100.rencnt =  n_rencnt              
                                                          uwm100.renno  = ""
                                                          uwm100.endcnt = n_endcnt
                                                         /* uwm100.prvpol  =  tlt.policy. */
                                                          wdetail.policy = n_newpol.



                                                      Leave  Loop_putpol.             
                                                End.     
                                                Else do: 
                                                      Message "Policy is Duplicate on uwm100" View-as alert-box.

                                                End.
                              End.  /*repeat */       
                        End.  /* false */
                        Otherwise    DO:
                            WDETAIL.OK_GEN = "N".
                            NEXT.
                        END.
                            
                   End case.  
                   End.   /*  not avail 301 */
End.  /*  comp_sck  <>  ""  */  
END.

 s_recid1  =  Recid(uwm100).
    
    

Find xmm031 Where xmm031.poltyp = wdetail.poltyp  No-lock no-error no-wait.
  IF avail  xmm031 Then do:
       nv_dept     = xmm031.dept.
End.

/*********************************************************************************/
  DO TRANSACTION:
      ASSIGN

      uwm100.renno  =  ""
      uwm100.endno  = ""
      uwm100.poltyp =  wdetail.poltyp
      uwm100.insref =    ""     
      uwm100.opnpol =  ""                                     /* nv_tltcontest  Contest:uwm100.opnpol */
      uwm100.ntitle =  wdetail.tiname
      uwm100.name1  =  wdetail.insnam
      uwm100.name2  =   ""
      uwm100.name3  =   ""
      uwm100.addr1  =  wdetail.iadd1
      uwm100.addr2  =  wdetail.iadd2
      uwm100.addr3  =  wdetail.iadd3 
      uwm100.addr4  =  wdetail.iadd4
      uwm100.undyr  = String(Year(today),"9999")    /*   nv_undyr  */
      uwm100.branch =  fi_branch                                 /* nv_branch  */                        
      uwm100.dept   =  nv_dept
        
      uwm100.usrid  = USERID(LDBNAME(1))
      uwm100.fstdat = TODAY     /*TODAY */
      
      uwm100.comdat = DATE(wdetail.comdat)
      uwm100.expdat = date(wdetail.expdat)
      uwm100.accdat =     today            /*tlt.datesent  */
      uwm100.tranty = "N"                        /*Transaction Type (N/R/E/C/T)*/
      uwm100.langug = "T"
      uwm100.acctim = "00:00"
      uwm100.trty11 = ""
      uwm100.docno1 = ""

      uwm100.enttim = STRING(TIME,"HH:MM:SS")
      uwm100.entdat = TODAY
      uwm100.curbil = "BHT"
      uwm100.curate = 1
      uwm100.instot = 1
      uwm100.prog   = "wuwargen"
      uwm100.cntry  = "TH"        /*Country where risk is situated*/
      uwm100.insddr = YES         /*Print Insd. Name on DrN   */
      uwm100.no_sch = 0           /*No. to print, Schedule    */
      uwm100.no_dr  = 1           /*No. to print, Dr/Cr Note  */
      uwm100.no_ri  = 0           /*No. to print, RI Appln    */
      uwm100.no_cer = 0           /*No. to print, Certificate */

       uwm100.li_sch = YES         /*Print Later/Imm., Schedule*/
       uwm100.li_dr  = YES         /*Print Later/Imm., Dr/Cr Note*/
       uwm100.li_ri  = YES         /*Print Later/Imm., RI Appln, */
       uwm100.li_cer = YES         /*Print Later/Imm., Certificate*/
       uwm100.apptax = YES         /*Apply risk level tax (Y/N)*/
       uwm100.recip  = "N"         /*Reciprocal (Y/N/C)        */
       uwm100.short  = NO
       uwm100.acno1  = fi_producer    /*  nv_acno1 */
       uwm100.agent  = fi_agent            /*nv_agent  */
       

       /*uwm100.bs_cd  = fi_vatcode*/
       uwm100.insddr = NO
       uwm100.coins  = NO
       uwm100.billco = ""
       uwm100.fptr01 = 0        uwm100.bptr01 = 0
       uwm100.fptr02 = 0        uwm100.bptr02 = 0
       uwm100.fptr03 = 0        uwm100.bptr03 = 0
       uwm100.fptr04 = 0        uwm100.bptr04 = 0
       uwm100.fptr05 = 0        uwm100.bptr05 = 0
       uwm100.fptr06 = 0        uwm100.bptr06 = 0  
       uwm100.styp20 = "NORM"
        uwm100.dir_ri =   YES 
       uwm100.] = uwm100.trndat.
     IF uwm100.accdat > uwm100.comdat THEN  uwm100.accdat = uwm100.comdat.

     IF wdetail.cancel ="ca" THEN
         uwm100.polsta = "CA" .
     ELSE
         uwm100.polsta = "IF".

     IF fi_loaddat <> ? THEN
         uwm100.trndat = fi_loaddat.
     ELSE
         uwm100.trndat = TODAY.

    nv_polday     =  IF (uwm100.expdat  - uwm100.comdat = 365)  Or  (uwm100.expdat - uwm100.comdat = 366)  
                                  Or (uwm100.expdat - uwm100.comdat = 367)  Then  365 
                                  Else  uwm100.expdat  - uwm100.comdat.                    
                                        
  END. /*transaction*/
  
  
End  A490166 Block ชั่วคราว    28/09/2006---***/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 C-Win 
PROCEDURE proc_722 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /* ---------------------------------------------  U W M 1 2 0 -------------- */
/*                                                                                                 */
/*                 FIND uwm120 USE-INDEX uwm12001      WHERE                                       */
/*                      uwm120.policy = uwm100.policy          AND                                 */
/*                      uwm120.rencnt = uwm100.rencnt          AND                                 */
/*                      uwm120.endcnt = uwm100.endcnt        AND                                   */
/*                      uwm120.riskgp = s_riskgp                    AND                            */
/*                      uwm120.riskno = s_riskno                                                   */
/*                 NO-WAIT NO-ERROR.                                                               */
/*                 IF NOT AVAILABLE uwm120 THEN DO:                                                */
/*                     RUN wuw/wuwad120 (INPUT   uwm100.policy,                                    */
/*                                                                                  uwm100.rencnt, */
/*                                                                                  uwm100.endcnt, */
/*                                                                                  s_riskgp,      */
/*                                                                                  s_riskno,      */
/*                                                             OUTPUT  s_recid2).                  */
/*                                                                                                 */
/*                    FIND uwm120 WHERE RECID(uwm120) = s_recid2                                   */
/*                    NO-WAIT NO-ERROR.                                                            */
/*                 END. /* end not avail  uwm120 */                                                */
/*                 Else  /*avail 120*/                                                             */
/*                     Assign                                                                      */
/*                          uwm120.sicurr = "BHT"                                                  */
/*                          uwm120.siexch = 1  /*not sure*/                                        */
/*                          uwm120.fptr01 = 0               uwm120.bptr01 = 0                      */
/*                          uwm120.fptr02 = 0               uwm120.bptr02 = 0                      */
/*                          uwm120.fptr03 = 0               uwm120.bptr03 = 0                      */
/*                          uwm120.fptr04 = 0               uwm120.bptr04 = 0                      */
/*                          uwm120.fptr08 = 0               uwm120.bptr08 = 0                      */
/*                          uwm120.fptr09 = 0               uwm120.bptr09 = 0                      */
/*                          uwm120.com1ae = YES                                                    */
/*                          uwm120.stmpae = YES                                                    */
/*                          uwm120.feeae  = YES                                                    */
/*                          uwm120.taxae  = YES.                                                   */
/*                 uwm120.class = wdetail.subclass.                                                */
/*                 s_recid2     = RECID(uwm120).                                                   */
                
                /* ---------------------------------------------  U W M 1 3 0 -------------- */
      FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
           sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
           sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
           sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
           sic_bran.uwm130.riskgp = s_riskgp      AND            /*0*/
           sic_bran.uwm130.riskno = s_riskno      AND            /*1*/
           sic_bran.uwm130.itemno = s_itemno      AND            /*1*/
           /*a490166*/                                             
           sic_bran.uwm130.bchyr  = nv_batchyr     AND            /*26/10/2006 change field name */
           sic_bran.uwm130.bchno  = nv_batchno     AND            /*26/10/2006 change field name */ 
           sic_bran.uwm130.bchcnt = nv_batcnt                     /*26/10/2006 change field name */            
      NO-WAIT NO-ERROR.
      IF NOT AVAILABLE sic_bran.uwm130 THEN 
                DO TRANSACTION:
                        CREATE sic_bran.uwm130.
                        ASSIGN
                        sic_bran.uwm130.policy = sic_bran.uwm120.policy
                        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
                        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
                        sic_bran.uwm130.itemno = s_itemno.

                        ASSIGN /*a490166*/
                        sic_bran.uwm130.bchyr = nv_batchyr         /* batch Year */
                        sic_bran.uwm130.bchno = nv_batchno         /* bchno    */
                        sic_bran.uwm130.bchcnt  = nv_batcnt .        /* bchcnt     */
                        
                        /*--------------------------------------------*/
                        
                        ASSIGN
                        sic_bran.uwm130.uom6_v   = 0
                        sic_bran.uwm130.uom7_v   = 0
                        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/

                        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class
                        NO-LOCK NO-ERROR.
                        IF AVAIL sicsyac.xmm016 THEN DO:
                            ASSIGN            
                            
                            sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
                            sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9  
                            
                            nv_comper     = deci(sicsyac.xmm016.si_d_t[8]) 
                            nv_comacc     = deci(sicsyac.xmm016.si_d_t[9])                                           
                            
                            sic_bran.uwm130.uom8_v   = nv_comper   
                            sic_bran.uwm130.uom9_v   = nv_comacc  .   

                        END.
                        
                        ASSIGN
                        nv_riskno = 1
                        nv_itemno = 1.
                        IF wdetail.covcod = "1" Then do:
                           RUN wgs/wgschsum(INPUT  wdetail.policy, /*a490166 Note modi*/
                                                   nv_riskno,
                                                   nv_itemno).
                        END.
                END. /*transaction*/
                s_recid3  = RECID(sic_bran.uwm130).

 /* ---------------------------------------------  U W M 3 0 1 --------------*/ 
 nv_covcod =   wdetail.covcod.
 /*nv_index  =   index(wdetail.brand," ").*/
 nv_makdes  =  wdetail.brand.
 nv_moddes  =  wdetail.model.

 /***--- A50-0108 ---***/
 /***--- Shukiat T. Modi on 26/04/2007 ---***/
 /*---Comment BY amparat c. a51-0253--
 /***--- A50-0165 Shukiat T. on 17/07/2007 ---***/
 nv_newsck = " ".
 IF LENGTH(wdetail.stk) = 11 THEN DO:
     IF SUBSTR(wdetail.stk,1,2) = "02" THEN 
      nv_newsck = substr(wdetail.stk,3,8).
     ELSE
      nv_newsck = substr(wdetail.stk,2,9).
 END.
 ELSE DO:
     nv_newsck = wdetail.stk.
 END.
 /***--- End A50-0165 Shukiat T. ---***/
 ---Comment BY amparat c. a51-0253--*/
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
     /*a490166*/                                             
     sic_bran.uwm301.bchyr = nv_batchyr                      AND 
     sic_bran.uwm301.bchno = nv_batchno                      AND 
     sic_bran.uwm301.bchcnt  = nv_batcnt                     
 NO-WAIT NO-ERROR.
 IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
     DO TRANSACTION:
         CREATE sic_bran.uwm301.
         /*ASSIGN
              sic_bran.uwm301.policy    = sic_bran.uwm120.policy
              sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
              sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
              sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
              sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
              sic_bran.uwm301.itemno    = s_itemno

              sic_bran.uwm301.tariff    = wdetail.tariff 
              sic_bran.uwm301.covcod    = nv_covcod
              sic_bran.uwm301.cha_no    = wdetail.chasno
              sic_bran.uwm301.eng_no    = wdetail.engno
              sic_bran.uwm301.Tons      = INTEGER(wdetail.weight)
              sic_bran.uwm301.engine    = INTEGER(wdetail.cc)
              sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
              sic_bran.uwm301.garage    = wdetail.garage
              sic_bran.uwm301.body      = wdetail.body
              sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
              sic_bran.uwm301.vehreg    = wdetail.vehreg  + " " + nv_provi            
              sic_bran.uwm301.mv_ben83  = wdetail.benname
              /*uwm301.vehreg      =  wdetail.vehreg*/
              sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
              sic_bran.uwm301.vehuse    = wdetail.vehuse
              sic_bran.uwm301.moddes    = wdetail.brand + " " +  wdetail.model
              sic_bran.uwm301.sckno     = Integer(substr(wdetail.stk,2,9))
              sic_bran.uwm301.itmdel    = NO
              sic_bran.uwm301.bchyr = nv_batchyr         /* batch Year */      
              sic_bran.uwm301.bchno = nv_batchno         /* bchno    */      
              sic_bran.uwm301.bchcnt  = nv_batcnt .        /* bchcnt     */      *//*a490166 04/10/2006*/
          
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
              sic_bran.uwm301.Tons    = INTEGER(wdetail.weight)
              sic_bran.uwm301.engine  = INTEGER(wdetail.cc)
              sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
              sic_bran.uwm301.garage  = wdetail.garage
              sic_bran.uwm301.body    = wdetail.body
              sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
              /*uwm301.vehreg    =  wdetail.vehreg*/              
              sic_bran.uwm301.mv_ben83 = wdetail.benname
              sic_bran.uwm301.vehreg   = wdetail.vehreg + nv_provi
              sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
              sic_bran.uwm301.vehuse   = wdetail.vehuse
              sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model
            /*sic_bran.uwm301.sckno    = Integer(substr(wdetail.stk,2,9))*//*Shukiat T. block on 26/04/2007*/
              sic_bran.uwm301.sckno    = 0 /*INTEGER(nv_newsck)                /*Shukiat T. Modi  on 26/04/2007*/  a510253*/
              sic_bran.uwm301.itmdel   = NO
              sic_bran.uwm301.bchyr    = nv_batchyr         /* batch Year */      
              sic_bran.uwm301.bchno    = nv_batchno         /* bchno    */      
              sic_bran.uwm301.bchcnt   = nv_batcnt .        /* bchcnt     */      
   
/*  IF wdetail.compul = "y" THEN DO:                                                                                         */
/*        sic_bran.uwm301.cert = "y".                                                                                        */
/*      /*sic_bran.uwm301.sckno = INTE(SUBSTR(wdetail.stk,2,9))*/       /*Shukiat T. block on 26/04/2007*/                   */
/*        sic_bran.uwm301.sckno    =  0 . /*INTEGER(nv_newsck).                /*Shukiat T. Modi  on 26/04/2007*/  a510253*/ */
/*  END.                                                                                                                     */
   /*-----compul-----*/
   IF wdetail.compul = "y" THEN DO:
      sic_bran.uwm301.cert = "y".
      IF LENGTH(wdetail.stk) = 11 THEN DO:    
          sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
      END.
      IF LENGTH(wdetail.stk) = 13  THEN DO:
          sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
      END.      
     /*--create detaitem--*/
     FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
                brStat.Detaitem.serailno = wdetail.stk  NO-LOCK NO-ERROR .
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
     /*-------------------*/
   END.
   ELSE DO: 
    sic_bran.uwm301.drinam[9] = "".
   END.
/*--------
/***--- A50-0165 Shukiat T. modi on 17/07/2007 ---***/
IF SUBSTRING(wdetail.stk,1,2) = "02" AND integer(nv_newsck) <> 0 THEN
     uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
ELSE uwm301.drinam[9] = "".
/***--- End A50-0165 Shukiat T. ---***/
---------*/

 s_recid4  = RECID(sic_bran.uwm301).

   /***---old ---***/
   /***---
   FIND LAST sicsyac.xmm102 WHERE sicsyac.xmm102.modest = wdetail.brand + wdetail.model AND
                                sicsyac.xmm102.engine = INTE(wdetail.cc)              AND 
                                sicsyac.xmm102.tons   = INTE(wdetail.weight)          AND
                                sicsyac.xmm102.seats  = INTE(wdetail.seat)
            NO-LOCK NO-ERROR.
   IF AVAIL sicsyac.xmm102  THEN DO:
            sic_bran.uwm301.vehgrp = sicsyac.xmm102.vehgrp.
            sic_bran.uwm301.modcod = sicsyac.xmm102.modcod.
   END.
   s_recid4  = RECID(sic_bran.uwm301).
   nv_massage = " ".
   ---***/

   /***--- modi by note a490166 ---***/
   IF wdetail.redbook <> "" THEN DO: /*กรณีที่มีการระบุ Code รถมา*/
        FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
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

        END. 
   END.
   ELSE DO:
        FIND LAST sicsyac.xmm102 WHERE sicsyac.xmm102.modest = wdetail.brand + wdetail.model AND
                                       sicsyac.xmm102.engine = INTE(wdetail.cc) AND 
                                       sicsyac.xmm102.tons   = INTE(wdetail.weight) AND
                                       sicsyac.xmm102.seats  = INTE(wdetail.seat)
        NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102  THEN DO:
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
        END.
    END.

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
         IF AVAIL sicsyac.xmm016 THEN DO:
             sic_bran.uwd132.gap_ae = NO.
             sic_bran.uwd132.pd_aep = "E".
        END.

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
              /*a490166*/
              sic_bran.uwd132.bchyr = nv_batchyr         /* batch Year */      
              sic_bran.uwd132.bchno = nv_batchno         /* bchno    */      
              sic_bran.uwd132.bchcnt  = nv_batcnt .        /* bchcnt     */      

      FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
           sicsyac.xmm105.tariff = wdetail.tariff  AND
           sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
      ELSE DO:
        MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
      END.
                                         /* Malaysia */
      IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
             IF           wdetail.subclass      = "110" THEN nv_key_a = inte(wdetail.cc).
        ELSE IF SUBSTRING(wdetail.subclass,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
        ELSE IF SUBSTRING(wdetail.subclass,1,3) = "130" THEN nv_key_a = inte(wdetail.cc).
        ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.weight).

        nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.

        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                   sicsyac.xmm106.tariff  = wdetail.tariff   AND
                   sicsyac.xmm106.bencod  = uwd132.bencod   AND
                   sicsyac.xmm106.class   = wdetail.subclass    AND
                   sicsyac.xmm106.covcod  = wdetail.covcod   AND
                   sicsyac.xmm106.key_a  >= nv_key_a        AND
                   sicsyac.xmm106.key_b  >= nv_key_b        AND
                   sicsyac.xmm106.effdat <= uwm100.comdat
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmm106 THEN DO:
          sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap.
          sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap.
          nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c.
          nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
        END.
        ELSE DO:
          /*MESSAGE 
                  "Tariff" wdetail.tariff
                  "Bencod" uwd132.bencod
                  "Class"  wdetail.subclass 
                  "Covcod" wdetail.covcod
                  "Key A"  nv_key_a
                  "Key B"  nv_key_b
          VIEW-AS ALERT-BOX.       */
          nv_message = "NOTFOUND".
        END.
      END.
      ELSE DO:
        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                   sicsyac.xmm106.tariff  = wdetail.tariff   AND
                   sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                   sicsyac.xmm106.class   = wdetail.subclass AND
                   sicsyac.xmm106.covcod  = wdetail.covcod   AND
                   sicsyac.xmm106.key_a  >= 0                AND
                   sicsyac.xmm106.key_b  >= 0                AND
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

          RUN wgw/wgw72013   (INPUT RECID(sic_bran.uwm100), /*a490166 note modi*/
                                    RECID(sic_bran.uwd132),
                                    sic_bran.uwm301.tariff).
                  
          nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
          nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
          /*MESSAGE "nv_gap " nv_gap  SKIP
                  " nv_prem " nv_prem.*/
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
               /*a490166*/
               sic_bran.uwd132.bchyr = nv_batchyr         /* batch Year */      
               sic_bran.uwd132.bchno = nv_batchno         /* bchno    */      
               sic_bran.uwd132.bchcnt  = nv_batcnt          /* bchcnt     */      
               n_rd132                 = RECID(sic_bran.uwd132).

        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
             sicsyac.xmm016.class = wdetail.subclass
        NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm016 THEN DO:
          sic_bran.uwd132.gap_ae = NO.
          sic_bran.uwd132.pd_aep = "E".
        END.

        FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
             sicsyac.xmm105.tariff = wdetail.tariff  AND
             sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
        ELSE 
          MESSAGE "ไม่พบ Tariff นี้ในระบบ กรุณาใส่ Tariff ใหม่" 
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
          IF AVAILABLE sicsyac.xmm106 THEN DO:
              ASSIGN
                    sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
          END.
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
                    
            RUN wgw/wgw72013   (INPUT RECID(sic_bran.uwm100), /*a490166 note modi*/
                                      RECID(sic_bran.uwd132),
                                      sic_bran.uwm301.tariff).
                     
            nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
            nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
          END.
        END.   /* uwm301.tariff = "Z" */

        FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ s_130bp1 NO-WAIT NO-ERROR.
        sic_bran.uwd132.fptr   = n_rd132.

        FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ n_rd132 NO-WAIT NO-ERROR.
        s_130bp1      = RECID(sic_bran.uwd132).
        NEXT loop_def.
      END.
    END.
  END.
  ELSE DO:    /*  Not Avail xmm107 */
    s_130fp1 = 0.
    s_130bp1 = 0.
       
    MESSAGE "ไม่พบ Class " wdetail.subclass " ใน Tariff  " wdetail.tariff  skip
                        "กรุณาใส่ Class หรือ Tariff ใหม่อีกครั้ง" VIEW-AS ALERT-BOX.
  END.

  ASSIGN sic_bran.uwm130.fptr03 = s_130fp1
         sic_bran.uwm130.bptr03 = s_130bp1.
END.
ELSE DO:                              /* uwm130.fptr03 <> 0 OR uwm130.fptr03 <> ? */

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
        IF AVAILABLE xmm106 THEN DO:
          sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap.
          sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap.
          nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c.
          nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
        END.
        ELSE DO:
          /*MESSAGE 
                  "Tariff" wdetail.tariff
                  "Bencod" uwd132.bencod
                  "Class"  wdetail.subclass 
                  "Covcod" wdetail.covcod
                  "Key A"  nv_key_a
                  "Key B"  nv_key_b
                  "LOOP FOUND"
          VIEW-AS ALERT-BOX.*/
          
          nv_message = "NOTFOUND".
        END.
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
          RUN wgw/wgw72013   (INPUT RECID(sic_bran.uwm100), /*a490166 note modi*/
                                    RECID(sic_bran.uwd132),
                                    sic_bran.uwm301.tariff).
          nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
          nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
        END.
      END.
    END.
  END.
END.                                            /* End.  uwm130.fptr03 <> 0 OR uwm130.fptr03 <> ? */

nv_stm_per = 0.4.
nv_tax_per = 7.0.

FIND sicsyac.xmm020 USE-INDEX xmm02001     WHERE
     sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
     sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri
NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN ASSIGN nv_stm_per             = sicsyac.xmm020.rvstam
                                    nv_tax_per             = sicsyac.xmm020.rvtax
                                    sic_bran.uwm100.gstrat = sicsyac.xmm020.rvtax.
ELSE sic_bran.uwm100.gstrat = nv_tax_per.

ASSIGN
nv_gap2  = 0
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
         /*a490166*/                                             
         sic_bran.uwm120.bchyr = nv_batchyr            AND 
         sic_bran.uwm120.bchno = nv_batchno            AND 
         sic_bran.uwm120.bchcnt  = nv_batcnt             :

  nv_gap  = 0.
  nv_prem = 0.

  FOR EACH sic_bran.uwm130 WHERE
           sic_bran.uwm130.policy = wdetail.policy AND
           sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
           sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
           sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp AND
           sic_bran.uwm130.riskno = sic_bran.uwm120.riskno AND
           /*a490166*/                                             
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
                             TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) > 0
                        THEN 1 ELSE 0).

sic_bran.uwm120.rtax_r = ROUND((sic_bran.uwm120.prem_r + sic_bran.uwm120.rstp_r)  * nv_tax_per  / 100 ,2).

  /* ---------------
  uwm120.rstp_r = TRUNCATE(uwm120.prem_r * nv_stm_per / 100,0) +
                      (IF (uwm120.prem_r * nv_stm_per / 100) -
                  TRUNCATE(uwm120.prem_r * nv_stm_per / 100,0) > 0
                       THEN 1 ELSE 0).
  uwm120.rtax_r = TRUNCATE((uwm120.prem_r + uwm120.rstp_r)
                * nv_tax_per  / 100,2).
 -------------------------- */
  nv_gap2  = nv_gap2  + nv_gap.
  nv_prem2 = nv_prem2 + nv_prem.
  nv_rstp  = nv_rstp  + sic_bran.uwm120.rstp_r.
  nv_rtax  = nv_rtax  + sic_bran.uwm120.rtax_r.

  IF sic_bran.uwm120.com1ae = NO THEN
     nv_com1_per            = sic_bran.uwm120.com1p.

  IF nv_com1_per <> 0 THEN DO:
    sic_bran.uwm120.com1ae =  NO.
    sic_bran.uwm120.com1p  =  nv_com1_per.
    sic_bran.uwm120.com1_r =  (sic_bran.uwm120.prem_r * sic_bran.uwm120.com1p / 100) * 1-.
  /*sic_bran.uwm120.com1_r =  TRUNCATE(sic_bran.uwm120.com1_r, 0).*/ /*a490166 Note Block on 25/10/2006 ค่า comm ให้คิดทศนิยมด้วย*/
    

    nv_com1_prm = nv_com1_prm + sic_bran.uwm120.com1_r.
  END.
  ELSE DO:

  IF nv_com1_per   = 0  AND
     sic_bran.uwm120.com1ae = NO
  THEN DO:
    ASSIGN
    sic_bran.uwm120.com1p  =  0
    sic_bran.uwm120.com1_r =  0
    sic_bran.uwm120.com1_r =  0
    nv_com1_prm            =  0.
  END.
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


/*MESSAGE nv_gap2   SKIP     
        nv_prem2  SKIP    
        nv_rstp   SKIP     
        nv_rtax   SKIP     
        nv_com1_prm.*/

RUN proc_chktest4.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addressnew C-Win 
PROCEDURE proc_addressnew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_addressum AS CHAR FORMAT "x(250)".
DEF VAR nv_soy       AS CHAR FORMAT "x(50)".
DEF VAR nv_road      AS CHAR FORMAT "x(50)".
/*
ns_addr1 
ns_addr2 
ns_addr3 
ns_addr4 */
ASSIGN 
    /*nv_addressum = ""
    nv_soy       = ""
    nv_road      = ""
    nv_addressum = trim(ns_addr1) + " " +
                   trim(ns_addr2)*/
    ns_addr1  = trim(ns_addr1)
    ns_addr2  = trim(ns_addr2)  
    ns_addr3  = trim(ns_addr3)     
    ns_addr4  = "".
ASSIGN ns_addr4  = replace(ns_addr3,"  "," ").    /*จังหวัด / จ.  / กทม / กรุงเทพ*/   
/* อำเภอ /อ./เขต */
IF r-index(ns_addr2,"เขต") <> 0 THEN
    ASSIGN 
    ns_addr3        = trim(SUBSTR(ns_addr2,r-index(ns_addr2,"เขต")))            /*อำเภอ /อ./เขต */
    ns_addr2        = trim(SUBSTR(ns_addr2,1, r-index(ns_addr2,"เขต") - 1 )).   /*ตำบล  /ต. /แขวง*/
ELSE IF r-index(ns_addr2,"อำเภอ") <> 0 THEN                                     
    ASSIGN                                                                      
    ns_addr3        = trim(SUBSTR(ns_addr2,r-index(ns_addr2,"อำเภอ")))          /*อำเภอ /อ./เขต */
    ns_addr2        = trim(SUBSTR(ns_addr2,1, r-index(ns_addr2,"อำเภอ") - 1 )). /*ตำบล  /ต. /แขวง*/
ELSE IF r-index(ns_addr2,"อ.") <> 0 THEN                                        
    ASSIGN                                                                      
    ns_addr3        = trim(SUBSTR(ns_addr2,r-index(ns_addr2,"อ.")))             /*อำเภอ /อ./เขต */
    ns_addr2        = trim(SUBSTR(ns_addr2,1, r-index(ns_addr2,"อ.") - 1 )).    /*ตำบล  /ต. /แขวง*/
DO WHILE INDEX(ns_addr1,"  ") <> 0 :
    ASSIGN ns_addr1 = REPLACE(ns_addr1,"  "," ").
END.
IF LENGTH(ns_addr1) > 35 THEN DO:
    loop_add01:
    DO WHILE LENGTH(ns_addr1) > 35 :
        IF R-INDEX(ns_addr1," ") <> 0 THEN DO:
            ASSIGN 
                ns_addr2  = trim(SUBSTR(ns_addr1,r-INDEX(ns_addr1," "))) + " " + ns_addr2
                ns_addr1  = trim(SUBSTR(ns_addr1,1,r-INDEX(ns_addr1," "))).
        END.
        ELSE LEAVE loop_add01.
    END.
    IF LENGTH(ns_addr2) > 35 THEN DO:
        loop_add02:
        DO WHILE LENGTH(ns_addr2) > 35 :
            IF R-INDEX(ns_addr2," ") <> 0 THEN DO:
                ASSIGN 
                    ns_addr3   = trim(SUBSTR(ns_addr2,r-INDEX(ns_addr2," "))) + " " + ns_addr3
                    ns_addr2   = trim(SUBSTR(ns_addr2,1,r-INDEX(ns_addr2," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
    END.
    IF LENGTH(ns_addr2 + " " + ns_addr3) <= 35 THEN
        ASSIGN 
        ns_addr2  = ns_addr2 + " " + ns_addr3
        ns_addr3  = ns_addr4 
        ns_addr4  = "".
    ELSE IF LENGTH(ns_addr3 + " " + ns_addr4 ) <= 35 THEN
        ASSIGN 
        ns_addr3  = ns_addr3 + " " + ns_addr4
        ns_addr4  = "".
END.
ELSE DO:
    IF LENGTH(ns_addr2 + " " + ns_addr3) <= 35 THEN
        ASSIGN 
        ns_addr2  = ns_addr2 + " " + ns_addr3
        ns_addr3  = ns_addr4 
        ns_addr4  = "".
    ELSE IF LENGTH(ns_addr3 + " " + ns_addr4 ) <= 35 THEN
        ASSIGN 
        ns_addr3  = ns_addr3 + " " + ns_addr4 
        ns_addr4  = "".
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132prem C-Win 
PROCEDURE proc_adduwd132prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A64-0138       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DEF VAR nv_ncbyrs AS INT INIT 0.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign C-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        ns_entrydat     /*1   Entry date         */
        ns_entrytim     /*2   Entry time         */
        ns_trndat       /*3   Trans Date         */
        ns_trntim       /*4   Trans Time         */
        ns_poltyp       /*5   Policy Type        70      */
        ns_policy       /*6   Policy     DL7056007891    */
        ns_renewpol     /*7   Renew Policy       DL7055007225    */
        ns_comdat       /*8   Comm Date  5/5/2013        */
        ns_expidat      /*9   Expiry date        5/5/2014        */
        ns_compul       /*10  Compulsory N       */
        ns_title        /*11  Title name คุณ     */
        ns_insnam       /*12  Insured name       จตุพงษ์  ศิรินุกูลพิพัฒน์       */
        ns_addr1        /*13  Ins addr1  271/350  หมู่บ้านบ่อวินเมืองทอง 2       */
        ns_addr2        /*14  Ins addr2  ตำบลบ่อวิน  อำเภอศรีราชา        */
        ns_addr3        /*15  Ins addr3  ชลบุรี  20230   */
        ns_addr4        /*16  Ins addr4  โทร /081-685-6535  มือถือ       */
        ns_pack         /*17  Premium Package    F       */
        ns_subclass     /*18  Sub Class  110     */
        ns_Brand        /*19  Brand      NISSAN  */
        ns_Mode         /*20  Mode       NAVARA DOUBLECAB 2.5 LE 6M/T HI POWER ABS SRS   */
        ns_Cc           /*21  Cc     2500        */
        ns_Weight       /*22  Weight     0       */
        ns_Seat         /*23  Seat       7       */
        ns_Body         /*24  Body       เก๋ง    */
        ns_vehreg       /*25  Vehicle registration       ชธ 9764 กท      */
        ns_engno        /*26  Engine no  YD25-035007T    */
        ns_chassis      /*27  Chassis no MNTVCUD40Z0-001245      */
        ns_caryear      /*28  Car Year   2007    */
        ns_provin       /*29  Car Province               */
        ns_vehuse       /*30  Vehicle Use        1       */
        ns_garage       /*31  Garage     F       */
        ns_stkno        /*32  Sticker no         */
        ns_access       /*33  Accessories        n       */
        ns_cover        /*34  Cover Type 1       */
        ns_sumins       /*35  Sum Insured        340,000.00      */
        ns_volprem      /*36  Voluntory Premium  13,305.00       */
        ns_compprem     /*37  Compulsory Prem            */
        ns_fleet        /*38  Fleet %    0.00    */
        ns_ncb          /*39  NCB %      50.00   */
        ns_loadcl       /*40  Load Claim 0.00    */
        ns_DeductDA     /*41  Deduct DA  0       */
        ns_DeductPD     /*42  Deduct PD  0       */
        ns_Benname      /*43  Benificiary                */
        ns_userid       /*44  User id            */
        ns_import       /*45  Import             */
        ns_export       /*46  Export             */
        ns_drivno       /*47  Drive name n       */
        ns_drivname1    /*48  Driver name1               */
        ns_drivname2    /*49  Driver name2               */
        ns_drivbirth1   /*50  Driver Birthdate1          */
        ns_drivbirth2   /*51  Driver Birthdate2          */
        ns_drivage1     /*52  Driver age1        0       */
        ns_drivage2     /*53  Driver age2 0       */
        ns_cancel       /*54  Cancel             */
        ns_producer     /*55  Producer           */
        ns_agent        /*56  Agent      AOL00068        */
        ns_redbook      /*57  Code Red Book              */
        ns_note         /*58  Note       คุ้มภัย  DL7055/007225  */
        ns_attach       /*59  ATTACH_NOTE        อ้อม 307 ห้าง   */
        ns_idcard       /*60  IDENT_CARD         */
        ns_BUSINESS     /*61  BUSINESS REGISTRATION              */
        ns_basenew      /*62  A58-0103  */
        campaignno     /*63  A58-0103 */ 
        nv_TPBIPer     /*A64-0138*/
        nv_TPBIAcc     /*A64-0138*/
        nv_pTPPD       /*A64-0138*/
        nv_ry41       /*A64-0138*/
        nv_ry42       /*A64-0138*/
        nv_ry43       /*A64-0138*/
         .      


    IF      index(ns_policy,"Policy")       <> 0 THEN RUN proc_initail.
    ELSE IF index(ns_entrydat,"Entry date") <> 0 THEN RUN proc_initail.   
    ELSE IF ns_policy  = ""                      THEN RUN proc_initail.
    ELSE IF ns_poltyp  = "70"                    THEN RUN proc_assign70.
    ELSE IF ns_poltyp  <> "70"  THEN DO:
        ASSIGN ns_massage = "Plese Check file Load Type V70...!!!".
        RUN proc_initail.
    END.
    RUN proc_initail.
END. /*-Repeat-*/
INPUT CLOSE. /*close Import*/
IF  ns_massage <> "" THEN MESSAGE  ns_massage  VIEW-AS ALERT-BOX.
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
For each  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        ns_entrydat    /* 1  Entry date         */
        ns_entrytim    /* 2  Entry time         */
        ns_trndat      /* 3  Trans Date         */
        ns_trntim      /* 4  Trans Time         */
        ns_poltyp      /* 5  Policy Type        70      */
        ns_policy      /* 6  Policy     DL7056007891    */
        ns_renewpol    /* 7  Renew Policy       DL7055007225    */
        ns_comdat      /* 8  Comm Date  5/5/2013        */
        ns_expidat     /* 9  Expiry date        5/5/2014        */
        ns_compul      /* 10 Compulsory N       */
        ns_title       /* 11 Title name คุณ     */
        ns_insnam      /* 12 Insured name       จตุพงษ์  ศิรินุกูลพิพัฒน์       */
        ns_addr1       /* 13 Ins addr1  271/350  หมู่บ้านบ่อวินเมืองทอง 2       */
        ns_addr2       /* 14 Ins addr2  ตำบลบ่อวิน  อำเภอศรีราชา        */
        ns_addr3       /* 15 Ins addr3  ชลบุรี  20230   */
        ns_addr4       /* 16 Ins addr4  โทร /081-685-6535  มือถือ       */
        ns_pack        /* 17 Premium Package    F       */
        ns_subclass    /* 18 Sub Class  110     */
        ns_Brand       /* 19 Brand      NISSAN  */
        ns_Mode        /* 20 Mode       NAVARA DOUBLECAB 2.5 LE 6M/T HI POWER ABS SRS   */
        ns_Cc          /* 21 Cc     2500        */
        ns_Weight      /* 22 Weight     0       */
        ns_Seat        /* 23 Seat       7       */
        ns_Body        /* 24 Body       เก๋ง    */
        ns_vehreg      /* 25 Vehicle registration       ชธ 9764 กท      */
        ns_engno       /* 26 Engine no  YD25-035007T    */
        ns_chassis     /* 27 Chassis no MNTVCUD40Z0-001245      */
        ns_caryear     /* 28 Car Year   2007    */
        ns_provin      /* 29 Car Province               */
        ns_vehuse      /* 30 Vehicle Use        1       */
        ns_garage      /* 31 Garage     F       */
        ns_stkno       /* 32 Sticker no         */
        ns_access      /* 33 Accessories        n       */
        ns_cover       /* 34 Cover Type 1       */
        ns_sumins      /* 35 Sum Insured        340,000.00      */
        ns_volprem     /* 36 Voluntory Premium  13,305.00       */
        ns_compprem    /* 37 Compulsory Prem            */
        ns_fleet       /* 38 Fleet %    0.00    */
        ns_ncb         /* 39 NCB %      50.00   */
        ns_loadcl      /* 40 Load Claim 0.00    */
        ns_DeductDA    /* 41 Deduct DA  0       */
        ns_DeductPD    /* 42 Deduct PD  0       */
        ns_Benname     /* 43 Benificiary                */
        ns_userid      /* 44 User id                */
        ns_import      /* 45 Import                     */
        ns_drivno      /* 46 Drive name n       */                  
        ns_drivname1   /* 47 Driver name1       */              
        ns_drivname2   /* 48 Driver name2       */              
        ns_drivbirth1  /* 49 Driver Birthdate1  */          
        ns_drivbirth2  /* 50 Driver Birthdate2  */          
        ns_drivage1    /* 51 Driver age1    0   */              
        ns_drivage2   /* 52 Driver age2    0   */              
        ns_cancel      /* 53 Cancel     */                      
        ns_producer    /* 54 Producer       */                  
        ns_agent       /* 55 Agent  AOL00068    */              
        ns_redbook     /* 56 Code Red Book      */              
        ns_accdat      /* 57 Note   คุ้มภัย  DL7055/007225  */  
        ns_recipt      /* 58 ATTACH_NOTE    อ้อม 307 ห้าง   */  
        ns_remak.      /* 59 */  
    IF ns_policy = "" THEN   NEXT.
    IF INDEX(ns_policy,"Policy") > 0 THEN NEXT.
    ELSE IF ns_poltyp  = "72" THEN RUN proc_assign72.
    ELSE IF ns_poltyp <> "72"  THEN ASSIGN ns_massage = "Plese Check file Load Type V72...!!!".
    RUN proc_initail.
END. /*-Repeat-*/
INPUT CLOSE. /*close Import*/
IF  ns_massage <> "" THEN MESSAGE  ns_massage  VIEW-AS ALERT-BOX.
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
    ASSIGN np_codeaddr1 =  sicuw.uwm500.prov_n .    /*= uwm100.codeaddr1 */ 
    FIND LAST sicuw.uwm501 USE-INDEX uwm50102   WHERE 
        sicuw.uwm501.prov_n = sicuw.uwm500.prov_n  AND
        index(sicuw.uwm501.dist_d,np_mail_amper) <> 0        NO-LOCK NO-ERROR NO-WAIT. /*"พนมทวน"*/
    IF AVAIL sicuw.uwm501 THEN DO:  
        /*DISP
        sicuw.uwm501.prov_n  /* uwm100.codeaddr1 */
        sicuw.uwm501.dist_n  /* uwm100.codeaddr2 */ 
        . */
        ASSIGN np_codeaddr1 = sicuw.uwm501.prov_n
            np_codeaddr2 =    sicuw.uwm501.dist_n.  /*= uwm100.codeaddr2 */
        
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign70 C-Win 
PROCEDURE proc_assign70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR ns_insnam2 AS CHAR FORMAT "x(60)" INIT "" .
FIND FIRST wdetail WHERE wdetail.policy = trim(ns_policy) NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN ns_insnam2 = "".
    IF index(trim(ns_insnam),"และ/หรือ") <> 0 THEN 
        ASSIGN 
        ns_insnam2  = trim(SUBSTR(trim(ns_insnam),index(trim(ns_insnam),"และ/หรือ"))) 
        ns_insnam   = trim(SUBSTR(trim(ns_insnam),1,index(trim(ns_insnam),"และ/หรือ") - 1 )) .
    loop_chk1:
    REPEAT:
        IF INDEX(ns_insnam2,"  ") <> 0 THEN DO:
            ns_insnam2 = REPLACE(ns_insnam2,"  "," ").
        END.
        ELSE LEAVE loop_chk1.
    END.
    IF trim(ns_idcard)    <> "" THEN RUN proc_cuticno.
    IF trim(ns_BUSINESS)  <> "" THEN RUN proc_cuticnobess.
    RUN proc_addressnew.
    
    ASSIGN 
        wdetail.entdat     =  trim(ns_entrydat)    /*  Entry date       */                                            
        wdetail.enttim     =  trim(ns_entrytim)    /*  Entry time       */                                           
        wdetail.trandat    =  trim(ns_trndat)      /*  Trans Date       */                                           
        wdetail.trantim    =  trim(ns_trntim)      /*  Trans Time       */                                           
        wdetail.poltyp     =  trim(ns_poltyp)      /*  Policy Type  70  */                                           
        wdetail.policy     =  trim(ns_policy)      /*  Policy   DL7056007891     */                                   
        wdetail.renpol     =  trim(ns_renewpol)    /*  Renew Policy DL7055007225 */                               
        wdetail.comdat     =  trim(ns_comdat)      /*  Comm Date    5/5/2013     */                                   
        wdetail.expdat     =  trim(ns_expidat)     /*  Expiry date  5/5/2014     */                                   
        wdetail.compul     =  "n"                                          
        wdetail.tiname     =  trim(ns_title)       /*  Title name   คุณ */                                          
        /*wdetail.insnam     =  trim(ns_insnam)      /*  Insured name จตุพงษ์  ศิรินุกูลพิพัฒน์   */ */    
        wdetail.name2      =  trim(ns_insnam2)
        wdetail.insnam     =  IF index(trim(ns_insnam)," ") <> 0 THEN 
                                 trim(SUBSTR(trim(ns_insnam),1,index(trim(ns_insnam)," "))) + " " + trim(SUBSTR(trim(ns_insnam),index(trim(ns_insnam)," ")))
                              ELSE trim(ns_insnam)  

        wdetail.iadd1      =  trim(ns_addr1)       /*  Ins addr1    271/350  หมู่บ้านบ่อวินเมืองทอง 2   */          
        wdetail.iadd2      =  trim(ns_addr2)       /*  Ins addr2    ตำบลบ่อวิน  อำเภอศรีราชา    */                  
        wdetail.iadd3      =  trim(ns_addr3)       /*  Ins addr3    ชลบุรี  20230   */                              
        wdetail.iadd4      =  trim(ns_addr4)       /*  Ins addr4    โทร /081-685-6535  มือถือ   */                  
        /*wdetail.prempa     =  trim(ns_pack)        /*  Premium Package  F   */*/  
        wdetail.prempa     =  CAPS(IF      trim(ns_pack) = "" AND trim(ns_cover) = "1" THEN  "G"       /*  Premium Package  F   */  
                              ELSE IF trim(ns_pack) = "" AND trim(ns_cover) = "3" THEN  "R"  
                              ELSE IF trim(ns_cover) = "2.1" THEN  "C"
                              ELSE IF trim(ns_cover) = "3.1" THEN  "C"
                              ELSE  trim(ns_pack))   /*13*/ 
        wdetail.subclass   =  trim(ns_subclass)    /*  Sub Class    110 */                                          
        wdetail.brand      =  trim(ns_Brand)       /*  Brand    NISSAN  */                                          
        wdetail.model      =  trim(ns_Mode)        /*  Mode NAVARA DOUBLECAB 2.5 LE 6M/T HI POWER ABS SRS   */      
        wdetail.cc         =  trim(ns_Cc)          /*  Cc       2500    */                                          
        wdetail.weight     =  trim(ns_Weight)      /*  Weight   0   */                                              
        wdetail.seat       =  trim(ns_Seat)        /*  Seat 7   */                                                  
        wdetail.body       =  trim(ns_Body)        /*  Body เก๋ง    */                                              
        wdetail.vehreg     =  IF (index(trim(ns_vehreg),"ป้ายแดง") <> 0 ) OR (trim(ns_vehreg) = "" ) THEN 
                               "/" +  SUBSTR(trim(ns_chassis),LENGTH(trim(ns_chassis)) - 8 )  
                              ELSE replace(trim(ns_vehreg),".","")      /*  Vehicle registration ชธ 9764 กท  */                          
        wdetail.engno      =  trim(ns_engno)       /*  Engine no    YD25-035007T    */                              
        wdetail.chasno     =  trim(ns_chassis)     /*  Chassis no   MNTVCUD40Z0-001245  */                          
        wdetail.caryear    =  trim(ns_caryear)     /*  Car Year 2007    */                                          
        /*wdetail.carprovi   =  trim(ns_provin)      /*  Car Province     */  */                                        
        wdetail.vehuse     =  IF ns_vehuse = "" THEN "1" ELSE trim(ns_vehuse)      /*  Vehicle Use  1   */          
        wdetail.garage     =  IF trim(ns_cover) = "3" THEN ""
                              ELSE IF trim(ns_garage) = "" THEN "" ELSE "G"      /*  Garage   F       */                                              
        /*wdetail.stk        =  trim(ns_stkno)       /*  Sticker no       */   */                                       
        wdetail.stk        =  ""       /*  Sticker no       */ 
        wdetail.access     =  trim(ns_access)      /*  Accessories  n   */                                          
        wdetail.covcod     =  trim(ns_cover)       /*  Cover Type   1   */                                                        
        wdetail.si         =  trim(ns_sumins)      /*  Sum Insured  340,000.00  */                                                
        wdetail.volprem    =  trim(ns_volprem)     /*  Voluntory Premium    13,305.00   */                                        
        wdetail.Compprem   =  trim(ns_compprem)    /*  Compulsory Prem      */                                                    
        wdetail.baseprem   =  deci(TRIM(ns_basenew)) 
        wdetail.fleet      =  trim(ns_fleet)       /*  Fleet %  0.00    */               /*34*/                     
        wdetail.ncb        =  trim(ns_ncb)         /*  NCB %    50.00   */               /*35*/                     
        wdetail.loadclm    =  trim(ns_loadcl)      /*  Load Claim   0.00    */           /*36*/                     
        wdetail.deductda   =  trim(ns_DeductDA)    /*  Deduct DA    0   */               /*37*/                     
        wdetail.deductpd   =  trim(ns_DeductPD)    /*  Deduct PD    0   */               /*38*/                     
        wdetail.benname    =  trim(ns_Benname)     /*  Benificiary      */               /*39*/                     
        wdetail.n_user     =  trim(ns_userid)      /*  User id      */                                              
        wdetail.n_IMPORT   =  trim(ns_import)      /*  Import       */                                              
        wdetail.n_export   =  trim(ns_export)                    
        wdetail.drivnam    =  trim(ns_drivno)      /*  Drive name   n   */               /*40*/                     
        wdetail.drivnam1   =  trim(ns_drivname1)   /*  Driver name1     */               /*41*/                     
        wdetail.drivnam2   =  trim(ns_drivname2)   /*  Driver name2     */               /*42*/                     
        wdetail.drivbir1   =  trim(ns_drivbirth1)  /*  Driver Birthdate1        */       /*43*/                     
        wdetail.drivbir2   =  trim(ns_drivbirth2)  /*  Driver Birthdate2        */       /*44*/                     
        wdetail.drivage1   =  trim(ns_drivage1)    /*  Driver age1  0   */               /*45*/                     
        wdetail.drivage2   =  trim(ns_drivage2)    /*  Driver age2  0   */               /*46*/                     
        wdetail.cancel     =  trim(ns_cancel)      /*  Cancel       */                   /*47*/                     
        wdetail.producer   =  trim(ns_producer)    /*  Producer     */                   /*48*/                     
        wdetail.agent      =  trim(ns_agent)       /*  Agent    AOL00068    */           /*49*/                     
        wdetail.redbook    =  trim(ns_redbook)     /*  Code Red Book        */          /*50 note add*/     
        wdetail.note       =  trim(ns_note)                                    
        wdetail.attach_n   =  trim(ns_attach)                                  
        wdetail.idcard     =  trim(ns_idcard)                                  
        wdetail.BUSINESS   =  trim(ns_BUSINESS)    
        wdetail.campaignno =  TRIM(campaignno)
        wdetail.TPBIPer    =  deci(trim(nv_TPBIPer))  /*A64-0138*/
        wdetail.TPBIAcc    =  deci(trim(nv_TPBIAcc))  /*A64-0138*/
        wdetail.pTPPD      =  deci(trim(nv_pTPPD))  /*A64-0138*/
        WDETAIL.no_41      =  deci(trim(nv_ry41))  /*A64-0138*/
        WDETAIL.no_42      =  deci(trim(nv_ry42))  /*A64-0138*/
        WDETAIL.no_43      =  deci(trim(nv_ry43))  /*A64-0138*/
            
        wdetail.comment    =  ""
        wdetail.agent      =  trim(fi_agent)
        wdetail.producer   =  trim(fi_producer)     
        wdetail.entdat     =  string(TODAY)              /*entry date*/
        wdetail.enttim     =  STRING (TIME, "HH:MM:SS")  /*entry time*/
        wdetail.trandat    =  STRING (fi_loaddat)        /*tran date*/
        wdetail.trantim    =  STRING (TIME, "HH:MM:SS")  /*tran time*/
        wdetail.n_IMPORT   =  "IM"
        wdetail.n_EXPORT   =  "" . 
    /*Add A63-0472*/
    RUN proc_assign2addr (INPUT   wdetail.iadd1   
                         ,INPUT   wdetail.iadd2  
                         ,INPUT   trim(wdetail.iadd3 + " " + wdetail.iadd4) 
                         ,INPUT  ""      /*wdetail.occup  */ 
                         ,OUTPUT wdetail.codeocc  
                         ,OUTPUT wdetail.codeaddr1
                         ,OUTPUT wdetail.codeaddr2
                         ,OUTPUT wdetail.codeaddr3).
    IF nv_postcd <> ""  THEN DO: 
        wdetail.postcd  = nv_postcd.
        IF      INDEX(wdetail.iadd4,nv_postcd) <> 0 THEN wdetail.iadd4 = trim(REPLACE(wdetail.iadd4,nv_postcd,"")). 
        ELSE IF INDEX(wdetail.iadd3,nv_postcd) <> 0 THEN wdetail.iadd3 = trim(REPLACE(wdetail.iadd3,nv_postcd,"")). 
        ELSE IF INDEX(wdetail.iadd2,nv_postcd) <> 0 THEN wdetail.iadd2 = trim(REPLACE(wdetail.iadd2,nv_postcd,"")). 
        ELSE IF INDEX(wdetail.iadd1,nv_postcd) <> 0 THEN wdetail.iadd1 = trim(REPLACE(wdetail.iadd1,nv_postcd,"")). 
    END.
    RUN proc_matchtypins (INPUT  wdetail.tiname 
                         ,INPUT  wdetail.insnam 
                         ,OUTPUT wdetail.insnamtyp
                         ,OUTPUT wdetail.firstName
                         ,OUTPUT wdetail.lastName).
    /*Add A63-0472*/

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign72 C-Win 
PROCEDURE proc_assign72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.policy = trim(ns_policy) NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.entdat     =  trim(ns_entrydat)   /*  Entry date      */                                                             
        wdetail.enttim     =  trim(ns_entrytim)   /*  Entry time       */                                                     
        wdetail.trandat    =  trim(ns_trndat)     /*  Trans Date       */                                                    
        wdetail.trantim    =  trim(ns_trntim)     /*  Trans Time       */                                                    
        wdetail.poltyp     =  trim(ns_poltyp)     /*  Policy Type  70  */                                                               /*1*/
        wdetail.policy     =  trim(ns_policy)     /*  Policy   DL7056007891    */                                                       /*2*/
        wdetail.renpol     =  trim(ns_renewpol)   /*  Renew Policy DL7055007225    */                                                   /*3*/
        wdetail.comdat     =  trim(ns_comdat)     /*  Comm Date    5/5/2013    */                                                       /*4*/
        wdetail.expdat     =  trim(ns_expidat)    /*  Expiry date  5/5/2014    */                                                       /*5*/
        wdetail.compul     =  "Y"                 /*  Compulsory   N   */                                                               /*6*/
        wdetail.tiname     =  trim(ns_title)       /*  Title name   คุณ */                                                               /*7*/
        /*wdetail.insnam     =  trim(ns_insnam)      /*  Insured name จตุพงษ์  ศิรินุกูลพิพัฒน์   */ */                 
        wdetail.insnam     =  IF index(trim(ns_insnam)," ") <> 0 THEN 
                              trim(SUBSTR(trim(ns_insnam),1,index(trim(ns_insnam)," "))) + " " + trim(SUBSTR(trim(ns_insnam),index(trim(ns_insnam)," ")))
                              ELSE trim(ns_insnam)                                     /*8*/
        wdetail.iadd1      =  trim(ns_addr1)       /*  Ins addr1    271/350  หมู่บ้านบ่อวินเมืองทอง 2   */                               /*9*/
        wdetail.iadd2      =  trim(ns_addr2)       /*  Ins addr2    ตำบลบ่อวิน  อำเภอศรีราชา    */                                       /*10*/
        wdetail.iadd3      =  trim(ns_addr3)       /*  Ins addr3    ชลบุรี  20230   */                                                   /*11*/ 
        wdetail.iadd4      =  trim(ns_addr4)       /*  Ins addr4    โทร /081-685-6535  มือถือ   */                                       /*12*/ 
        wdetail.prempa     =  trim(ns_pack)        /*  Premium Package  F   */   
        wdetail.subclass   =  trim(REPLACE(ns_subclass," ",""))     /*  Sub Class    110 */                                                               /*14*/ 
        wdetail.brand      =  trim(ns_Brand)       /*  Brand    NISSAN  */                                                               /*15*/ 
        wdetail.model      =  trim(ns_Mode)        /*  Mode NAVARA DOUBLECAB 2.5 LE 6M/T HI POWER ABS SRS   */                           /*16*/ 
        wdetail.cc         =  trim(ns_Cc)          /*  Cc       2500    */                                                               /*17*/ 
        wdetail.weight     =  trim(ns_Weight)      /*  Weight   0   */                                                                   /*18*/ 
        wdetail.seat       =  trim(ns_Seat)        /*  Seat 7   */                                                                       /*19*/ 
        wdetail.body       =  trim(ns_Body)        /*  Body เก๋ง    */                                                                   /*20*/
        wdetail.vehreg     =  trim(ns_vehreg)      /*  Vehicle registration ชธ 9764 กท  */                                               /*21*/ 
        wdetail.engno      =  trim(ns_engno)       /*  Engine no    YD25-035007T    */                                                   /*22*/ 
        wdetail.chasno     =  trim(ns_chassis)     /*  Chassis no   MNTVCUD40Z0-001245  */                                               /*23*/ 
        wdetail.caryear    =  trim(ns_caryear)     /*  Car Year 2007    */                                                               /*24*/ 
        /*wdetail.carprovi   =  trim(ns_provin)      /*  Car Province     */  */                                                             /*25*/ 
        wdetail.vehuse     =  IF ns_vehuse = "" THEN "1" ELSE trim(ns_vehuse)      /*  Vehicle Use  1   */                                                               /*26*/ 
        wdetail.garage     =  trim(ns_garage)      /*  Garage   F   */                                                                   /*27*/ 
        wdetail.stk        =  trim(ns_stkno)       /*  Sticker no       */                                                               /*28*/ 
        wdetail.access     =  trim(ns_access)      /*  Accessories  n   */                                                               /*29*/ 
        wdetail.covcod     =  trim(ns_cover)       /*  Cover Type   1   */                                                               /*30*/
        wdetail.si         =  trim(ns_sumins)      /*  Sum Insured  340,000.00  */                                                       /*31*/ 
        wdetail.volprem    =  trim(ns_volprem)     /*  Voluntory Premium    13,305.00   */                                               /*32*/ 
        wdetail.Compprem   =  trim(ns_compprem)    /*  Compulsory Prem      */                                                           /*33*/ 
        wdetail.fleet      =  trim(ns_fleet)       /*  Fleet %  0.00    */               /*34*/ 
        wdetail.ncb        =  trim(ns_ncb)         /*  NCB %    50.00   */               /*35*/ 
        wdetail.loadclm    =  trim(ns_loadcl)      /*  Load Claim   0.00    */           /*36*/ 
        wdetail.deductda   =  trim(ns_DeductDA)    /*  Deduct DA    0   */               /*37*/ 
        wdetail.deductpd   =  trim(ns_DeductPD)    /*  Deduct PD    0   */               /*38*/ 
        wdetail.benname    =  trim(ns_Benname)     /*  Benificiary      */               /*39*/ 
        wdetail.n_user     =  trim(ns_userid)      /*  User id      */                   
        wdetail.n_IMPORT   =  trim(ns_import)      /*  Import       */                   
        wdetail.drivnam    =  trim(ns_drivno)      /*  Drive name   n   */               /*40*/ 
        wdetail.drivnam1   =  trim(ns_drivname1)   /*  Driver name1     */               /*41*/ 
        wdetail.drivnam2   =  trim(ns_drivname2)   /*  Driver name2     */               /*42*/ 
        wdetail.drivbir1   =  trim(ns_drivbirth1)  /*  Driver Birthdate1        */       /*43*/ 
        wdetail.drivbir2   =  trim(ns_drivbirth2)  /*  Driver Birthdate2        */       /*44*/ 
        wdetail.drivage1   =  trim(ns_drivage1)    /*  Driver age1  0   */               /*45*/ 
        wdetail.drivage2   =  trim(ns_drivage2)    /*  Driver age2  0   */               /*46*/ 
        wdetail.cancel     =  trim(ns_cancel)      /*  Cancel       */                   /*47*/ 
        wdetail.producer   =  trim(ns_producer)    /*  Producer     */                   /*48*/
        wdetail.agent      =  trim(ns_agent)       /*  Agent    AOL00068    */           /*49*/
        wdetail.redbook    =  trim(ns_redbook)     /*  Code Red Book        */          /*50 note add*/                                   
        wdetail.accdat     =  trim(ns_accdat)    
        wdetail.docno      =  trim(ns_recipt)    
        wdetail.note       =  trim(ns_remak)  
        wdetail.comment    =  "" 
        wdetail.agent      =  trim(fi_agent)
        wdetail.producer   =  trim(fi_producer)     
        wdetail.entdat     =  string(TODAY)      /*entry date*/
        wdetail.enttim     =  STRING (TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat    =  STRING (fi_loaddat)     /*tran date*/
        wdetail.trantim    =  STRING (TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT   =  "IM" 
        wdetail.n_EXPORT   =  "" .  
    /*Add A63-0472*/
    RUN proc_assign2addr (INPUT  wdetail.iadd1   
                         ,INPUT  wdetail.iadd2  
                         ,INPUT  trim(wdetail.iadd3 + " " + wdetail.iadd4) 
                         ,INPUT  ""      /*wdetail.occup  */ 
                         ,OUTPUT wdetail.codeocc  
                         ,OUTPUT wdetail.codeaddr1
                         ,OUTPUT wdetail.codeaddr2
                         ,OUTPUT wdetail.codeaddr3).
    IF nv_postcd <> ""  THEN DO: 
        wdetail.postcd  = nv_postcd.
        IF      INDEX(wdetail.iadd4,nv_postcd) <> 0 THEN wdetail.iadd4 = trim(REPLACE(wdetail.iadd4,nv_postcd,"")). 
        ELSE IF INDEX(wdetail.iadd3,nv_postcd) <> 0 THEN wdetail.iadd3 = trim(REPLACE(wdetail.iadd3,nv_postcd,"")). 
        ELSE IF INDEX(wdetail.iadd2,nv_postcd) <> 0 THEN wdetail.iadd2 = trim(REPLACE(wdetail.iadd2,nv_postcd,"")). 
        ELSE IF INDEX(wdetail.iadd1,nv_postcd) <> 0 THEN wdetail.iadd1 = trim(REPLACE(wdetail.iadd1,nv_postcd,"")). 
    END.
    RUN proc_matchtypins (INPUT  wdetail.tiname 
                         ,INPUT  wdetail.insnam 
                         ,OUTPUT wdetail.insnamtyp
                         ,OUTPUT wdetail.firstName
                         ,OUTPUT wdetail.lastName).
    /*Add A63-0472*/
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
------------------------------------------------------------------------------*/
DEFINE VAR  nre_premt      AS DECI FORMAT ">>>,>>>,>>9.99".  /*A64-0138*/
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    ASSIGN 
        fi_process   = "Find Data Renewal ...." + wdetail.policy
        nv_driver    = "" 
        nre_premt    = 0 .                            /* A58-0103     */

    DISP fi_process WITH FRAM fr_main.                
    RUN wgw\wgwtarex (INPUT-OUTPUT wdetail.renpol,    /* n_prepol     */
                      INPUT-OUTPUT wdetail.poltyp,    /* n_poltyp     */
                      INPUT-OUTPUT wdetail.n_opnpol,  
                      INPUT-OUTPUT wdetail.producer,  /* n_producer   */
                      INPUT-OUTPUT wdetail.agent,     /* n_agent      */
                      INPUT-OUTPUT wdetail.inscod,    /* n_insured    */
                      INPUT-OUTPUT wdetail.tiname,    /* n_title      */
                      INPUT-OUTPUT wdetail.insnam,    /* n_name1      */
                      INPUT-OUTPUT wdetail.name2,     /* n_name2      */
                      INPUT-OUTPUT wdetail.name3,     /* n_name3      */
                      INPUT-OUTPUT wdetail.iadd1,     /* n_addr1      */
                      INPUT-OUTPUT wdetail.iadd2,     /* n_addr2      */
                      INPUT-OUTPUT wdetail.iadd3,     /* n_addr3      */
                      INPUT-OUTPUT wdetail.iadd4,     /* n_addr4      */
                      INPUT-OUTPUT wdetail.comdat,    /* n_expdat     */
                      INPUT-OUTPUT wdetail.firstdat,  /* n_firstdat   */ 
                      INPUT-OUTPUT wdetail.prempa,    /* n_prempa     */
                      INPUT-OUTPUT wdetail.subclass,  /* n_subclass   */
                      INPUT-OUTPUT wdetail.redbook,   /* n_redbook    */
                      INPUT-OUTPUT wdetail.brand,     /* n_brand      */
                      INPUT-OUTPUT wdetail.model,     /* n_model      */
                      INPUT-OUTPUT wdetail.caryear,   /* n_caryear    */ 
                      INPUT-OUTPUT wdetail.cargrp,    /* n_cargrp     */ 
                      INPUT-OUTPUT wdetail.body,      /* n_body       */ 
                      INPUT-OUTPUT wdetail.cc,        /* n_engcc      */ 
                      INPUT-OUTPUT wdetail.weight,    /* n_tons       */ 
                      INPUT-OUTPUT wdetail.seat,      /* n_seat       */ 
                      INPUT-OUTPUT wdetail.vehuse,    /* n_vehuse     */ 
                      INPUT-OUTPUT wdetail.covcod,    /* n_covcod     */ 
                      INPUT-OUTPUT wdetail.garage,    /* n_garage     */ 
                      INPUT-OUTPUT wdetail.vehreg,    /* n_vehreg     */ 
                      INPUT-OUTPUT wdetail.chasno,    /* n_chasno     */ 
                      INPUT-OUTPUT wdetail.engno,     /* n_engno      */ 
                      INPUT-OUTPUT nv_uom1_v,         /* n_uom1_v     */
                      INPUT-OUTPUT nv_uom2_v,         /* n_uom2_v     */
                      INPUT-OUTPUT nv_uom5_v,         /* n_uom5_v     */
                      INPUT-OUTPUT wdetail.si,        /* n_uom6_v     */
                      INPUT-OUTPUT wdetail.si,        /* n_uom7_v     */
                      INPUT-OUTPUT nv_baseprm,        /* nv_baseprm   */
                      INPUT-OUTPUT wdetail.NO_41,     /* n_41         */
                      INPUT-OUTPUT wdetail.seat41,    /* nv_seat41    */
                      INPUT-OUTPUT wdetail.NO_42,     /* n_42         */
                      INPUT-OUTPUT wdetail.NO_43,     /* n_43         */
                      INPUT-OUTPUT wdetail.deductda,  /* nv_dedod     */
                      INPUT-OUTPUT dpd0,              /* nv_dedpd     */
                      INPUT-OUTPUT wdetail.fleet,     /* nv_flet_per  */
                      INPUT-OUTPUT wdetail.ncb,       /* nv_ncbper    */
                      INPUT-OUTPUT nv_dss_per,        /* nv_dss_per   */
                      INPUT-OUTPUT nv_stf_per,        /* nv_stf_per   */
                      INPUT-OUTPUT nv_cl_per,         /* nv_cl_per    */
                      INPUT-OUTPUT wdetail.benname,   /* nv_bennam1   */ 
                      INPUT-OUTPUT wdetail.nv_acctxt,
                      INPUT-OUTPUT nv_driver,
                      INPUT-OUTPUT nre_premt) .       /* A58-0103 */
    ASSIGN 
        nv_insref        = trim(wdetail.inscod)
        wdetail.baseprem =  nv_baseprm 
        wdetail.loadclm  = string(nv_cl_per)  
        wdetail.comper   = 0
        wdetail.comacc   = 0 
        wdetail.volprem  = string(nre_premt) .

    IF (MONTH(date(wdetail.comdat)) = 2 ) AND (day(date(wdetail.comdat)) = 29)  THEN
        ASSIGN 
        /*wdetail.expdat   = "01/03/"  + string(YEAR(date(wdetail.comdat) + 1 ),"9999")    .*//*A58-0103*/
        wdetail.expdat   = "01/03/"  + string(YEAR(date(wdetail.comdat)) + 1 ,"9999")    .    /*A58-0103*/
    ELSE 
        ASSIGN 
            wdetail.expdat   = string(day(date(wdetail.comdat)),"99") + "/"  + 
                               string(MONTH(date(wdetail.comdat)),"99") + "/"  +
                               /*string(YEAR(date(wdetail.comdat) + 1),"9999")    .*//*A58-0103*/ 
                               string(YEAR(date(wdetail.comdat)) + 1 ,"9999")    .   /*A58-0103*/ 

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt C-Win 
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
        nv_access  = nv_uom6_u                                             
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
        nv_seat41  = integer(wdetail.seat41)
        nv_dedod   = deci(dod1)      
        nv_addod   = deci(dod2)                                
        nv_dedpd   = deci(dpd0)                                    
        nv_ncbp    = deci(wdetail.ncb)                                     
        nv_fletp   = deci(wdetail.fleet)                                  
        nv_dspcp   = deci(nv_dss_per)                                      
        nv_dstfp   = 0                                                     
        nv_clmp    = deci(wdetail.loadclm)
        /*nv_netprem  = TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) + 
                        (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )*/
        nv_netprem  = DECI(wdetail.volprem)  /* เบี้ยสุทธิ */                                                
        nv_gapprm  = 0                                                       
        nv_flagprm = "N"                    /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
        nv_effdat  = sic_bran.uwm100.comdat                             
        nv_ratatt  = 0                    
        nv_siatt   = 0                                                   
        nv_netatt  = 0 
        nv_fltatt  = 0 
        nv_ncbatt  = 0 
        nv_dscatt  = 0 
        /*nv_status  = "" */
        nv_fcctv   = NO  . 
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
            RUN wgw/wgwredbook (input  wdetail.brand ,  
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
            RUN wgw/wgwredbook (input  wdetail.brand ,  
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
            FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                WHERE stat.maktab_fil.sclass = wdetail.subclass  AND
                stat.maktab_fil.modcod = wdetail.redbook         No-lock no-error no-wait.
            If  avail  stat.maktab_fil  Then do:
                ASSIGN  
                    sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                    wdetail.cargrp          =  stat.maktab_fil.prmpac
                    nv_vehgrp               =  stat.maktab_fil.prmpac
                    sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac.
            END.
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
    " nv_netprem       "  nv_netprem    skip  
    " nv_gapprm        "  nv_gapprem    skip  
    " nv_flagprm       "  nv_flagprm    skip  
    " wdetail.comdat   "  nv_effdat     skip 
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.  */   
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
                       /*INPUT-OUTPUT nv_totfi  ,  */
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
                       OUTPUT nv_uom1_c,  
                       OUTPUT nv_uom2_c,  
                       OUTPUT nv_uom5_c,  
                       OUTPUT nv_uom6_c,
                       OUTPUT nv_uom7_c,
                       OUTPUT nv_status, 
                       OUTPUT nv_message).

    /*IF nv_gapprm <> DECI(wdetail.volprem) THEN DO: */
    IF  nv_status = "NO" THEN DO:
        /* /*comment by Kridtiya i. A65-0035*/ 
        MESSAGE nv_status + nv_message + "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " +
             wdetail.volprem  VIEW-AS ALERT-BOX. 
        ASSIGN
            wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
            wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.volprem
            /*wdetail.pass    = "Y" */   
            wdetail.OK_GEN  = "N".  */
        /*comment by Kridtiya i. A65-0035*/
        /*  by Kridtiya i. A65-0035*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN
                wdetail.comment = wdetail.comment + "|" + nv_message
                wdetail.WARNING = wdetail.WARNING + "|" + nv_message .
        /*  by Kridtiya i. A65-0035*/
    END.
    /*  by Kridtiya i. A65-0035*//* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate (input wdetail.comdat,
                        input wdetail.expdat,
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_checkdata00 C-Win 
PROCEDURE proc_checkdata00 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/ 
IF wdetail.vehreg = "" THEN 
    ASSIGN wdetail.vehreg   = "/" + substr(trim(wdetail.chasno),LENGTH(trim(wdetail.chasno)) - 8 ) . /*A58-0103*/
IF wdetail.vehreg = " " AND wdetail.renpol = " " THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
    wdetail.pass    = "N" 
    WDETAIL.OK_GEN  = "N" . 
ELSE DO:
        /*comment by kridtiya i. A58-0103....
        IF wdetail.renpol = " " THEN DO:  /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
            Def  var  nv_vehreg  as char  init  " ".
            Def  var  s_polno       like sicuw.uwm100.policy init " ".
            Find LAST sicuw.uwm301 Use-index uwm30102        Where  
                sicuw.uwm301.vehreg = wdetail.vehreg         No-lock no-error no-wait.
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
                If avail sicuw.uwm100 Then do:
                    s_polno     =   sicuw.uwm100.policy.
                    ASSIGN  wdetail.pass = "N"     
                        wdetail.comment = wdetail.comment + "| Vehicle Reg. already insured under policy" 
                        WDETAIL.OK_GEN  = "N".
                END.    /* avail uwm100  */
            END.        /*avil 301 */
        END. 
        end...comment by kridtiya i. A58-0103....*/           /*จบการ Check ทะเบียนรถ*/
END.                /*note end else*/
IF wdetail.cancel = "ca"  THEN   
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    WDETAIL.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass    = "N"     
    WDETAIL.OK_GEN  = "N". 
IF wdetail.drivnam = "y" AND wdetail.drivnam1 =  " "   THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
    wdetail.pass    = "N"      
    WDETAIL.OK_GEN  = "N". 
IF wdetail.covcod = ""   THEN
    ASSIGN  wdetail.comment = wdetail.comment + "| covtype เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"      
    WDETAIL.OK_GEN  = "N". 
IF wdetail.prempa = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"      
    WDETAIL.OK_GEN  = "N". 
IF wdetail.subclass = " " THEN  
    ASSIGN  wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"     
    WDETAIL.OK_GEN  = "N".
/*IF wdetail.brand = " " THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"        
    WDETAIL.OK_GEN  = "N".
IF wdetail.model = " " THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"     
    WDETAIL.OK_GEN  = "N".*/
/*IF wdetail.cc    = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"    
    WDETAIL.OK_GEN  = "N".*/
/*IF wdetail.seat  = " "  THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"    
    WDETAIL.OK_GEN  = "N".*/
IF wdetail.caryear = " " THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"     
    WDETAIL.OK_GEN  = "N".
ASSIGN nv_maxsi = 0
    nv_minsi    = 0
    nv_si       = 0
    nv_maxdes   = ""
    nv_mindes   = "" 
    chkred      = NO
    n_ratmin    = 0
    n_ratmax    = 0 
    nv_modcod   = "".
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
        stat.maktab_fil.sclass = wdetail.subclass  AND 
        stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN nv_modcod     =  stat.maktab_fil.modcod  
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            chkred           =  YES    
            wdetail.brand    =  stat.maktab_fil.makdes
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
            wdetail.cc       =  STRING(stat.maktab_fil.engine)
            wdetail.subclass =  stat.maktab_fil.sclass
            wdetail.redbook  =  stat.maktab_fil.modcod                                    
            /*wdetail.seat     =  STRING(stat.maktab_fil.seats) */
            nv_si            =  stat.maktab_fil.si.
        IF wdetail.seat = "" THEN wdetail.seat = STRING(stat.maktab_fil.seats) .
        IF wdetail.covcod    = "1"  THEN DO:
            FIND FIRST stat.makdes31 WHERE 
                stat.makdes31.makdes = "X" AND   
                stat.makdes31.moddes = wdetail.prempa + wdetail.subclass  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE makdes31 THEN  
                ASSIGN nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            ELSE  
                ASSIGN nv_maxSI = nv_si
                       nv_minSI = nv_si.
            IF deci(wdetail.si) > nv_maxSI OR deci(wdetail.si) < nv_minSI THEN DO:
                IF nv_maxSI = nv_minSI THEN DO:
                    IF nv_maxSI = 0 AND nv_minSI = 0 THEN  
                        ASSIGN  wdetail.comment = "Not Found Sum Insure in maktab_fil (Class:"
                                                  + wdetail.prempa + wdetail.subclass + "   Make/Model:" + wdetail.redbook + " "
                                                  + wdetail.brand + " " + wdetail.model + "   Year:" + STRING(wdetail.caryear) + ")"
                        wdetail.pass    = "N"   
                        WDETAIL.OK_GEN  = "N".
                    ASSIGN wdetail.comment = "Not Found Sum Insured Rates Maintenance in makdes31 (Tariff: X"
                                             + "  Class:" + wdetail.prempa + wdetail.subclass + ")"
                           wdetail.pass    = "N"  
                           WDETAIL.OK_GEN  = "N".
                END.
                /*ASSIGN  wdetail.comment = "Sum Insure must " + nv_mindes + " and " + nv_maxdes
                + " of " + TRIM(STRING(nv_si,">>>,>>>,>>9"))
                + " (" + TRIM(STRING(nv_minSI,">>>,>>>,>>9"))
                + " - " + TRIM(STRING(nv_maxSI,">>>,>>>,>>9")) + ")"
                wdetail.pass    = "N" /*a490166*/    
                WDETAIL.OK_GEN  = "N".*/
            END.
        END.
    END.
    ELSE nv_modcod = " ".
END.   /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN n_ratmin = makdes31.si_theft_p   
        n_ratmax = makdes31.load_p   .  
    ELSE ASSIGN n_ratmin = 0
        n_ratmax = 0.
    IF index(wdetail.model," ") > 0  THEN wdetail.model = SUBSTR(wdetail.model,1,index(wdetail.model," ") - 1 ).
    IF index(wdetail.model,"SOLUNA") <> 0 THEN wdetail.model = "vios".
    IF wdetail.seat = "0" THEN DO:
        IF  (wdetail.covcod = "2.1") OR (wdetail.covcod = "2.2") OR 
            (wdetail.covcod = "3.1") OR (wdetail.covcod = "3.2") OR (wdetail.covcod = "3") THEN DO:
            IF  Integer(wdetail.cc) = 0  THEN DO:
                 Find First stat.maktab_fil Use-index      maktab04          Where
            stat.maktab_fil.makdes   =     wdetail.brand               And                  
            index(stat.maktab_fil.moddes,wdetail.model)  <> 0          And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear)    AND
            /*stat.maktab_fil.engine   =     Integer(wdetail.cc)         AND*/
            stat.maktab_fil.sclass   =     wdetail.subclass          /*  AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )  LE deci(wdetail.si)    AND
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )  GE deci(wdetail.si) )*/  No-lock no-error no-wait.
                 If  avail stat.maktab_fil  THEN DO:  
                     ASSIGN nv_modcod =  stat.maktab_fil.modcod                                    
                     nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                     wdetail.cargrp   =  stat.maktab_fil.prmpac
                     wdetail.redbook  =  stat.maktab_fil.modcod  
                     /*wdetail.seat     = STRING(stat.maktab_fil.seats)*/    .
                     IF wdetail.seat = "" THEN wdetail.seat = STRING(stat.maktab_fil.seats) .
                 END.
                 
            END.
            ELSE DO:
                Find First stat.maktab_fil Use-index      maktab04          Where
                    stat.maktab_fil.makdes   =     wdetail.brand               And                  
                    index(stat.maktab_fil.moddes,wdetail.model)  <> 0          And
                    stat.maktab_fil.makyea   =     Integer(wdetail.caryear)    AND
                    stat.maktab_fil.engine   =     Integer(wdetail.cc)         AND
                    stat.maktab_fil.sclass   =     wdetail.subclass          /*  AND
                    (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )  LE deci(wdetail.si)    AND
                    stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )  GE deci(wdetail.si) )*/  No-lock no-error no-wait.
                If  avail stat.maktab_fil  THEN DO:  
                    ASSIGN nv_modcod =  stat.maktab_fil.modcod                                    
                    nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                    wdetail.cargrp   =  stat.maktab_fil.prmpac
                    wdetail.redbook  =  stat.maktab_fil.modcod  .
                    /*wdetail.seat     = STRING(stat.maktab_fil.seats) .*/
                    IF wdetail.seat = "" THEN wdetail.seat = STRING(stat.maktab_fil.seats) .
                END.
            END.
        END.
        ELSE DO:
            Find First stat.maktab_fil Use-index      maktab04          Where
            stat.maktab_fil.makdes   =     wdetail.brand               And                  
            index(stat.maktab_fil.moddes,wdetail.model)  <> 0          And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear)    AND
            stat.maktab_fil.engine   =     Integer(wdetail.cc)         AND
            stat.maktab_fil.sclass   =     wdetail.subclass            AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )  LE deci(wdetail.si)    AND
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )  GE deci(wdetail.si) )  No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN DO:  
            ASSIGN nv_modcod =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.redbook  =  stat.maktab_fil.modcod  .
            /*wdetail.seat     = STRING(stat.maktab_fil.seats) .*/
            IF wdetail.seat = "" THEN wdetail.seat = STRING(stat.maktab_fil.seats) .
        END.
        END.
        
        /*IF nv_modcod = ""  THEN  
            ASSIGN  WDETAIL.COMMENT = wdetail.comment + "| NOT FIND MODEL CODE IN  MAKTAB_FIL"
            WDETAIL.OK_GEN  = "N"
            wdetail.pass    = "N". */
    END.
    ELSE DO:
        IF  (wdetail.covcod = "2.1") OR (wdetail.covcod = "2.2") OR 
            (wdetail.covcod = "3.1") OR (wdetail.covcod = "3.2") OR (wdetail.covcod = "3") THEN DO:
            Find First stat.maktab_fil Use-index      maktab04          Where
            stat.maktab_fil.makdes   =     wdetail.brand               And                  
            index(stat.maktab_fil.moddes,wdetail.model)  <> 0          And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear)    AND
            stat.maktab_fil.engine   =     Integer(wdetail.cc)         AND
            stat.maktab_fil.sclass   =     wdetail.subclass            AND
            /*(stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )  LE deci(wdetail.si)    OR
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )  GE deci(wdetail.si) )  AND  */
            stat.maktab_fil.seats    =     inte(wdetail.seat)            No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then  
            ASSIGN nv_modcod =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.redbook  =  stat.maktab_fil.modcod  .
        END.
        ELSE DO:
            Find First stat.maktab_fil Use-index      maktab04          Where
            stat.maktab_fil.makdes   =     wdetail.brand               And                  
            index(stat.maktab_fil.moddes,wdetail.model)  <> 0          And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear)    AND
            stat.maktab_fil.engine   =     Integer(wdetail.cc)         AND
            stat.maktab_fil.sclass   =     wdetail.subclass            AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 )  LE deci(wdetail.si)    OR
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )  GE deci(wdetail.si) )  AND  
            stat.maktab_fil.seats    =     inte(wdetail.seat)            No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then  
            ASSIGN nv_modcod =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.redbook  =  stat.maktab_fil.modcod  .
        END.
        /*IF nv_modcod = ""  THEN  
            ASSIGN  WDETAIL.COMMENT = wdetail.comment + "| NOT FIND MODEL CODE IN  MAKTAB_FIL"
            WDETAIL.OK_GEN  = "N"
            wdetail.pass    = "N".*/
    END.
END.

    ASSIGN                  
        NO_CLASS  = wdetail.prempa + wdetail.subclass
        nv_poltyp = wdetail.poltyp.
    If no_class  <>  " " Then do:
        FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
            sicsyac.xmd031.poltyp =   nv_poltyp AND
            sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE sicsyac.xmd031 THEN 
            ASSIGN  wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
            wdetail.pass    = "N"   
            WDETAIL.OK_GEN  = "N".          
        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
            sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
        IF NOT AVAILABLE sicsyac.xmm016 THEN 
            ASSIGN wdetail.comment = wdetail.comment + "| Not on Business class on xmm016"
            wdetail.pass    = "N"   
            WDETAIL.OK_GEN  = "N".           
        ELSE 
            ASSIGN wdetail.tariff  =   sicsyac.xmm016.tardef
                no_class       =   sicsyac.xmm016.class
                nv_sclass      =   Substr(no_class,2,3).
    END.
Find sicsyac.sym100 Use-index sym10001       Where
    sicsyac.sym100.tabcod = "u014"           AND 
    sicsyac.sym100.itmcod =  wdetail.vehuse  No-lock no-error no-wait.
IF not avail sicsyac.sym100 Then 
    ASSIGN wdetail.comment = wdetail.comment + "| Not on Vehicle Usage Codes table sym100 u014"
    wdetail.pass    = "N"    
    WDETAIL.OK_GEN  = "N".  

Find  sicsyac.sym100 Use-index sym10001    Where
    sicsyac.sym100.tabcod = "u013"         And
    sicsyac.sym100.itmcod = wdetail.covcod No-lock no-error no-wait.
IF not avail sicsyac.sym100 Then  
    ASSIGN wdetail.comment = wdetail.comment + "| Not on Motor Cover Type Codes table sym100 u013"
    wdetail.pass    = "N"  
    WDETAIL.OK_GEN  = "N".  

IF inte(wdetail.fleet) <> 0 AND INTE(wdetail.fleet) <> 10 Then  
    ASSIGN
    wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. "
    wdetail.pass    = "N"    
    WDETAIL.OK_GEN  = "N".
If  wdetail.access  =  "y"  Then do:
    If  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
        nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
        Then  wdetail.access  =  "y".         
    Else do:
        ASSIGN  wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ"
            wdetail.pass    = "N"   
            WDETAIL.OK_GEN  = "N".
    END.
END.
/*IF (wdetail.ncb = "0")  OR (wdetail.ncb = "20") OR
(wdetail.ncb = "30") OR (wdetail.ncb = "40") OR (wdetail.ncb = "50")   THEN DO:
END.
    ELSE DO:
        ASSIGN
            wdetail.comment = wdetail.comment + "| not on NCB Rates file xmm104."
            wdetail.pass    = "N"    
            WDETAIL.OK_GEN  = "N".
    END.*/
NV_NCBPER = INTE(WDETAIL.NCB).
If nv_ncbper  <> 0 Then do:
   
    Find first sicsyac.xmm104 Use-index xmm10401 Where
        sicsyac.xmm104.tariff = wdetail.tariff                    AND
        sicsyac.xmm104.class  = wdetail.prempa + wdetail.subclass AND
        sicsyac.xmm104.covcod = wdetail.covcod                    AND
        sicsyac.xmm104.ncbper = INTE(wdetail.ncb)                 No-lock no-error no-wait.
    IF not avail  sicsyac.xmm104  Then  
        ASSIGN wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
        wdetail.pass    = "N"     
        WDETAIL.OK_GEN  = "N".
END.
nv_sclass = wdetail.SUBclass. 

If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
    ASSIGN wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
    wdetail.pass    = "N"    
    WDETAIL.OK_GEN  = "N". 
IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk = " " THEN  
        ASSIGN wdetail.comment = wdetail.comment + "| ซื้อ พรบ ต้องมีหมายเลข Sticker"
        wdetail.pass    = "N"    
        WDETAIL.OK_GEN  = "N".
    IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
    IF LENGTH(wdetail.stk) < 11 OR LENGTH(wdetail.stk) > 13 THEN  
        ASSIGN  wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
        wdetail.pass    = ""
        WDETAIL.OK_GEN  = "N".
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_checkdata01 C-Win 
PROCEDURE proc_checkdata01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail:
    IF wdetail.policy = "" THEN NEXT.
    ELSE IF LENGTH(wdetail.policy) > 12 THEN NEXT.
    ASSIGN 
        n_rencnt   = 0 
        n_Endcnt   = 0
        nv_insref  = ""
        nv_uom1_v  = 0 
        nv_uom2_v  = 0 
        nv_uom5_v  = 0 
        nv_baseprm = 0 
        dod1       = 0  
        dod2       = 0 
        dpd0       = 0 
        nv_dss_per = 0   
        nv_stf_per = 0   
        nv_cl_per  = 0  
        nv_driver      = ""                            /* A58-0103     */
        wdetail.vehreg = trim(REPLACE(wdetail.vehreg,".",""))
        fi_process   = "Check Data on work file ...." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.

    IF wdetail.renpol <> "" THEN RUN proc_cutpolicy.
    IF wdetail.tiname = ""  THEN  
       ASSIGN wdetail.comment = wdetail.comment + "| คำนำหน้าชื่อผู้เอาประกันเป็นค่าว่างกรุณาใส่คำนำหน้านาม"
        wdetail.pass    = "N"     
        WDETAIL.OK_GEN  = "N". 
    ELSE DO:
        FIND FIRST brstat.msgcode USE-INDEX MsgCode01 WHERE
            brstat.msgcode.MsgDesc = wdetail.tiname  NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.msgcode  THEN 
            ASSIGN wdetail.tiname = brstat.msgcode.branch.
    END.
    IF wdetail.poltyp = "v72"  THEN DO:
        /*IF wdetail.renpol <> " " THEN RUN proc_renewpol72. */
        ASSIGN wdetail.renpol = "".
        RUN proc_checkdata01_v72.                       /*RUN proc_72.*/
        RUN proc_policy.                                
        RUN proc_checkdata01_v722.                      /* RUN proc_722.*/
        RUN proc_checkdata01_v723  (INPUT  s_recid1,    /*RUN proc_723*/    
                                    INPUT  s_recid2,
                                    INPUT  s_recid3,
                                    INPUT  s_recid4,
                                    INPUT-OUTPUT nv_message).
        NEXT.
    END.
    ELSE DO:
        IF wdetail.renpol <> ""  THEN RUN proc_renewpol70. 
        RUN proc_checkdata00.    /*RUN proc_chktest0.*/
        RUN proc_policy .  
        RUN proc_checkdata02.    /*RUN proc_chktest2. */  
        /*RUN proc_checkdata03.  /*RUN proc_chktest3.  */ *//*A58-0103*/
        /*add A58-0103*/
        IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "2.2" ) OR 
           (wdetail.covcod = "3.1" ) OR (wdetail.covcod = "3.2" ) THEN 
             RUN proc_checkdata03pl.   /*covcod 2+ 3+ */
        ELSE RUN proc_checkdata03.   
        /*A58-0103*/
        RUN proc_checkdata04.  /*RUN proc_chktest4. */ 
    END.
END.                           /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_checkdata01_v72 C-Win 
PROCEDURE proc_checkdata01_v72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  wdetail.tariff = "9"
    wdetail.covcod = "T"    
    fi_process     = "Check data Compulsory ...." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.compul <> "y" THEN  
        ASSIGN  wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass    = "N"
        WDETAIL.OK_GEN  = "N".
END.
IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk = "" THEN DO:
        MESSAGE "Compulsory เป็น y ต้องมีเลข Sticker" VIEW-AS ALERT-BOX.
        ASSIGN  wdetail.comment = wdetail.comment + "| Compulsory เป็น y ต้องมีเลข Sticker"
            wdetail.pass    = ""
            WDETAIL.OK_GEN  = "N".
    END.
    IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
    IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN DO: 
        ASSIGN  wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
            wdetail.pass    = ""
            WDETAIL.OK_GEN  = "N".
    END.
END.
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail.subclass  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN  
    ASSIGN  wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
    wdetail.pass    = "N"
    WDETAIL.OK_GEN  = "N".
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp  AND
        sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN wdetail.pass = "N"
        wdetail.comment     = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
        WDETAIL.OK_GEN      = "N".
END.
/*---------- covcod ----------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
    WDETAIL.OK_GEN  = "N".
FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"          AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  =  wdetail.covcod  NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN  
    ASSIGN  wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
        WDETAIL.OK_GEN = "N".
ASSIGN chkred = NO.
IF wdetail.redbook <> "" THEN DO:  
    FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
        sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm102 THEN DO:
        ASSIGN       
            wdetail.pass    = "N"  
            wdetail.comment = wdetail.comment + "| not find on table xmm102"
            WDETAIL.OK_GEN = "N"
            chkred = NO
            wdetail.redbook = " ".
    END.
    ELSE DO:
        chkred = YES.
    END.
END.
IF chkred = NO  THEN DO:
    IF INDEX(trim(wdetail.brand),"MERCEDES") <> 0 THEN ASSIGN  wdetail.brand  = "MERCEDES".
    FIND LAST sicsyac.xmm102 WHERE 
        sicsyac.xmm102.modest = trim(wdetail.brand + wdetail.model)  /*AND
        sicsyac.xmm102.engine = INTE(wdetail.cc)              AND 
        sicsyac.xmm102.tons   = INTE(wdetail.weight)          AND
        sicsyac.xmm102.seats  = INTE(wdetail.seat)*/            NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm102  THEN wdetail.redbook = sicsyac.xmm102.modcod. 
    IF wdetail.redbook = ""  THEN DO:
        FIND LAST sicsyac.xmm102 WHERE 
            sicsyac.xmm102.modest = trim(wdetail.brand)     NO-LOCK NO-ERROR.
        IF NOT AVAIL sicsyac.xmm102  THEN  
            ASSIGN   
            wdetail.pass    = "N"  
            wdetail.comment = wdetail.comment + "| not find on table xmm102"
            WDETAIL.OK_GEN  = "N".
        ELSE DO:
            ASSIGN wdetail.redbook = sicsyac.xmm102.modcod. 
        END.
    END.
END.
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN wdetail.pass = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
        WDETAIL.OK_GEN  = "N".
/***---Start 16/11/2006 For 72---***/
ASSIGN
    nv_docno  = " "
    nv_accdat = TODAY.
/***--- Docno ---***/
IF wdetail.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M"                              AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999")  NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN DO:
        MESSAGE "Receipt is Dup. on uwm100 :" sicuw.uwm100.policy
            STRING(sicuw.uwm100.rencnt,"99") + "/" +
            STRING(sicuw.uwm100.endcnt,"999") sicuw.uwm100.renno uwm100.endno.
        ASSIGN  wdetail.pass    = "N"  
            wdetail.comment     = "Receipt is Dup. on uwm100 :" + string(sicuw.uwm100.policy,"x(16)") +
                                  STRING(sicuw.uwm100.rencnt,"99")  + "/" +
                                  STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
            WDETAIL.OK_GEN  = "N".
    END.
    ELSE DO:
        nv_docno = wdetail.docno.
    END.
END.
/***--- Account Date ---***/
IF wdetail.accdat <> " "  THEN DO:
    nv_accdat = date(wdetail.accdat).
END.
ELSE DO:
    nv_accdat = TODAY.
END.
/***--- End 16/11/2006 ---***/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_checkdata01_v722 C-Win 
PROCEDURE proc_checkdata01_v722 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno
        sic_bran.uwm130.bchyr  = nv_batchyr         
        sic_bran.uwm130.bchno  = nv_batchno         
        sic_bran.uwm130.bchcnt = nv_batcnt    
        sic_bran.uwm130.uom6_v = 0
        sic_bran.uwm130.uom7_v = 0
        sic_bran.uwm130.fptr01 = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02 = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03 = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04 = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05 = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class  NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN DO:
        ASSIGN            
            sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
            sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9  
            nv_comper     = deci(sicsyac.xmm016.si_d_t[8]) 
            nv_comacc     = deci(sicsyac.xmm016.si_d_t[9])                                           
            sic_bran.uwm130.uom8_v   = nv_comper   
            sic_bran.uwm130.uom9_v   = nv_comacc  .   
    END.
    ASSIGN nv_riskno = 1
           nv_itemno = 1.
    IF wdetail.covcod = "1" Then do:
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                         nv_riskno,
                         nv_itemno).
    END.
END.  /*transaction*/
s_recid3  = RECID(sic_bran.uwm130). 
nv_covcod =   wdetail.covcod.
nv_makdes  =  wdetail.brand.
nv_moddes  =  wdetail.model.
nv_newsck = " ".
IF SUBSTR(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
ELSE nv_newsck = wdetail.stk.       
FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
    sic_bran.uwm301.policy = sic_bran.uwm100.policy   AND
    sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt   AND
    sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt   AND
    sic_bran.uwm301.riskgp = s_riskgp                 AND
    sic_bran.uwm301.riskno = s_riskno                 AND
    sic_bran.uwm301.itemno = s_itemno                 AND
    sic_bran.uwm301.bchyr = nv_batchyr                AND 
    sic_bran.uwm301.bchno = nv_batchno                AND 
    sic_bran.uwm301.bchcnt  = nv_batcnt      NO-WAIT NO-ERROR.
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
    sic_bran.uwm301.cha_no  = wdetail.chasno
    sic_bran.uwm301.eng_no  = wdetail.engno
    sic_bran.uwm301.Tons    = INTEGER(wdetail.weight)
    sic_bran.uwm301.engine  = INTEGER(wdetail.cc)
    sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage  = wdetail.garage
    sic_bran.uwm301.body    = wdetail.body
    sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv_ben83 = wdetail.benname
    sic_bran.uwm301.vehreg   = wdetail.vehreg + nv_provi
    sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
    sic_bran.uwm301.vehuse   = wdetail.vehuse
    sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model
    sic_bran.uwm301.sckno    = 0 
    sic_bran.uwm301.itmdel   = NO
    sic_bran.uwm301.bchyr    = nv_batchyr         /* batch Year */      
    sic_bran.uwm301.bchno    = nv_batchno         /* bchno    */      
    sic_bran.uwm301.bchcnt   = nv_batcnt .        /* bchcnt     */  
IF wdetail.compul = "y" THEN DO:
    sic_bran.uwm301.cert = "y".
    IF LENGTH(wdetail.stk) = 11 THEN DO:    
        sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
    END.
    IF LENGTH(wdetail.stk) = 13  THEN DO:
        sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
    END.
    /*--create detaitem--*/
    FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
        brStat.Detaitem.serailno = wdetail.stk  NO-LOCK NO-ERROR .
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
ELSE DO: 
    sic_bran.uwm301.drinam[9] = "".
END.
s_recid4  = RECID(sic_bran.uwm301).

IF wdetail.redbook <> "" THEN DO: /*กรณีที่มีการระบุ Code รถมา*/
    FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
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
    END.
END.
ELSE DO:
    FIND LAST sicsyac.xmm102 WHERE 
        sicsyac.xmm102.modest = wdetail.brand  /* + wdetail.model AND
        sicsyac.xmm102.engine = INTE(wdetail.cc)     AND 
        sicsyac.xmm102.tons   = INTE(wdetail.weight) AND
        sicsyac.xmm102.seats  = INTE(wdetail.seat)*/   NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm102  THEN DO:
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
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_checkdata01_v723 C-Win 
PROCEDURE proc_checkdata01_v723 :
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
ASSIGN nv_rec100 = s_recid1 
    nv_rec120    = s_recid2 
    nv_rec130    = s_recid3
    nv_rec301    = s_recid4
    nv_message   = "" 
    nv_gap       = 0 
    nv_prem      = 0 
    fi_process   = "Create data to table uwm100,uwm120,uwm130,uwm301 ...." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = nv_rec301 NO-WAIT NO-ERROR.
IF sic_bran.uwm130.fptr03 = 0 OR sic_bran.uwm130.fptr03 = ? THEN DO:
    FIND sicsyac.xmm107 USE-INDEX xmm10701        WHERE
        sicsyac.xmm107.class  = wdetail.subclass  AND
        sicsyac.xmm107.tariff = wdetail.tariff    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xmm107 THEN DO:
        FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmd107 THEN DO:
            CREATE sic_bran.uwd132.
            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                sicsyac.xmm016.class = wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm016 THEN DO:
                sic_bran.uwd132.gap_ae = NO.
                sic_bran.uwd132.pd_aep = "E".
            END.
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
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE DO:
                MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
            END.
            /* Malaysia */
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
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
                    sicsyac.xmm106.effdat <= uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap.
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap.
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                END.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= 0                AND
                    sicsyac.xmm106.key_b  >= 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat  NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass    AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a   = 0               AND
                    sicsyac.xmm106.key_b   = 0               AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat  NO-LOCK NO-ERROR NO-WAIT.

        IF AVAILABLE sicsyac.xmm106 THEN DO:
          sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.

          RUN wgw/wgw72013   (INPUT RECID(sic_bran.uwm100), 
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
               sic_bran.uwd132.bchyr = nv_batchyr         /* batch Year */      
               sic_bran.uwd132.bchno = nv_batchno         /* bchno    */      
               sic_bran.uwd132.bchcnt  = nv_batcnt          /* bchcnt     */      
               n_rd132                 = RECID(sic_bran.uwd132).
        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
             sicsyac.xmm016.class = wdetail.subclass  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm016 THEN DO:
          sic_bran.uwd132.gap_ae = NO.
          sic_bran.uwd132.pd_aep = "E".
        END.
        FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
             sicsyac.xmm105.tariff = wdetail.tariff  AND
             sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
        ELSE 
          MESSAGE "ไม่พบ Tariff นี้ในระบบ กรุณาใส่ Tariff ใหม่" 
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
          IF AVAILABLE sicsyac.xmm106 THEN DO:
              ASSIGN sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
          END.
        END.
        ELSE DO:
          FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                 WHERE
                     sicsyac.xmm106.tariff  = wdetail.tariff           AND
                     sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                     sicsyac.xmm106.class   = wdetail.subclass         AND
                     sicsyac.xmm106.covcod  = wdetail.covcod           AND
                     sicsyac.xmm106.key_a  >= 0                        AND
                     sicsyac.xmm106.key_b  >= 0                        AND
                     sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat   NO-LOCK NO-ERROR NO-WAIT.
          FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601                  WHERE
                     sicsyac.xmm106.tariff  = wdetail.tariff            AND
                     sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod    AND
                     sicsyac.xmm106.class   = wdetail.subclass          AND
                     sicsyac.xmm106.covcod  = wdetail.covcod            AND
                     sicsyac.xmm106.key_a   = 0                         AND
                     sicsyac.xmm106.key_b   = 0                         AND
                     sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat    NO-LOCK NO-ERROR NO-WAIT.
          IF AVAILABLE xmm106 THEN DO:
            sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
            RUN wgw/wgw72013   (INPUT RECID(sic_bran.uwm100), 
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
    s_130fp1 = 0.
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
        IF AVAILABLE xmm106 THEN DO:
          sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap.
          sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap.
          nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c.
          nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
        END.
        ELSE nv_message = "NOTFOUND".
      END.
      ELSE DO:
        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601            WHERE
                   sicsyac.xmm106.tariff  = wdetail.tariff      AND 
                   sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod       AND 
                   sicsyac.xmm106.class   = wdetail.subclass    AND 
                   sicsyac.xmm106.covcod  = wdetail.covcod      AND 
                   sicsyac.xmm106.key_a  >= 0                   AND 
                   sicsyac.xmm106.key_b  >= 0                   AND 
                   sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
        FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                   sicsyac.xmm106.tariff  = wdetail.tariff   AND
                   sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                   sicsyac.xmm106.class   = wdetail.subclass    AND
                   sicsyac.xmm106.covcod  = wdetail.covcod   AND
                   sicsyac.xmm106.key_a   = 0               AND
                   sicsyac.xmm106.key_b   = 0               AND
                   sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmm106 THEN DO:
          sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
          RUN wgw/wgw72013   (INPUT RECID(sic_bran.uwm100), /*a490166 note modi*/
                                    RECID(sic_bran.uwd132),
                                    sic_bran.uwm301.tariff).
          nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
          nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
        END.
      END.
    END.
  END.
END.                                            /* End.  uwm130.fptr03 <> 0 OR uwm130.fptr03 <> ? */
ASSIGN nv_stm_per = 0.4
    nv_tax_per = 7.0.
FIND sicsyac.xmm020 USE-INDEX xmm02001     WHERE
    sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
    sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri  NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN ASSIGN nv_stm_per             = sicsyac.xmm020.rvstam
    nv_tax_per             = sicsyac.xmm020.rvtax
    sic_bran.uwm100.gstrat = sicsyac.xmm020.rvtax.
ELSE sic_bran.uwm100.gstrat = nv_tax_per.
ASSIGN  nv_gap2 = 0
    nv_prem2    = 0
    nv_rstp     = 0
    nv_rtax     = 0
    nv_com1_per = 0
    nv_com1_prm = 0.
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sicsyac.xmm031 THEN nv_com1_per = sicsyac.xmm031.comm1.
FOR EACH sic_bran.uwm120 WHERE
    sic_bran.uwm120.policy = wdetail.policy         AND 
    sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND 
    sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND 
    sic_bran.uwm120.bchyr  = nv_batchyr             AND 
    sic_bran.uwm120.bchno  = nv_batchno             AND 
    sic_bran.uwm120.bchcnt = nv_batcnt             :
    ASSIGN nv_gap  = 0 
           nv_prem = 0.
    FOR EACH sic_bran.uwm130 WHERE
        sic_bran.uwm130.policy = wdetail.policy AND
        sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
        sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp AND
        sic_bran.uwm130.riskno = sic_bran.uwm120.riskno AND
        sic_bran.uwm130.bchyr = nv_batchyr              AND 
        sic_bran.uwm130.bchno = nv_batchno              AND 
        sic_bran.uwm130.bchcnt  = nv_batcnt             NO-LOCK:
        nv_fptr = sic_bran.uwm130.fptr03.
        DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
            FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAILABLE sic_bran.uwd132 THEN LEAVE.
            nv_fptr = sic_bran.uwd132.fptr.
            nv_gap  = nv_gap  + sic_bran.uwd132.gap_c.
            nv_prem = nv_prem + sic_bran.uwd132.prem_c.
        END.
    END.
    ASSIGN sic_bran.uwm120.gap_r =  nv_gap 
        sic_bran.uwm120.prem_r   =  nv_prem 
        sic_bran.uwm120.rstp_r   =  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) +
        (IF  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 2) -
         TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) > 0
         THEN 1 ELSE 0)
        sic_bran.uwm120.rtax_r = ROUND((sic_bran.uwm120.prem_r + sic_bran.uwm120.rstp_r)  * nv_tax_per  / 100 ,2) 
        nv_gap2  = nv_gap2  + nv_gap 
        nv_prem2 = nv_prem2 + nv_prem 
        nv_rstp  = nv_rstp  + sic_bran.uwm120.rstp_r 
        nv_rtax  = nv_rtax  + sic_bran.uwm120.rtax_r.
    IF sic_bran.uwm120.com1ae = NO THEN nv_com1_per            = sic_bran.uwm120.com1p.
    IF nv_com1_per <> 0 THEN DO:
        sic_bran.uwm120.com1ae =  NO.
        sic_bran.uwm120.com1p  =  nv_com1_per.
        sic_bran.uwm120.com1_r =  (sic_bran.uwm120.prem_r * sic_bran.uwm120.com1p / 100) * 1-.
        /*sic_bran.uwm120.com1_r =  TRUNCATE(sic_bran.uwm120.com1_r, 0).*/ /*a490166 Note Block on 25/10/2006 ค่า comm ให้คิดทศนิยมด้วย*/
        nv_com1_prm = nv_com1_prm + sic_bran.uwm120.com1_r.
    END.
    ELSE DO:
        IF ( nv_com1_per   = 0 )  AND ( sic_bran.uwm120.com1ae = NO ) THEN DO:
            ASSIGN
                sic_bran.uwm120.com1p  =  0
                sic_bran.uwm120.com1_r =  0
                sic_bran.uwm120.com1_r =  0
                nv_com1_prm            =  0.
        END.
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
RUN proc_checkdata04.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_checkdata02 C-Win 
PROCEDURE proc_checkdata02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_process   = "Create data to table uwm130 ...." + wdetail.policy .
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
  sic_bran.uwm130.bchcnt = nv_batcnt             NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN
  DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN  sic_bran.uwm130.policy = sic_bran.uwm120.policy
      sic_bran.uwm130.rencnt     = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
      sic_bran.uwm130.riskgp     = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
      sic_bran.uwm130.itemno     = s_itemno 
      sic_bran.uwm130.bchyr      = nv_batchyr    /* batch Year */
      sic_bran.uwm130.bchno      = nv_batchno    /* bchno      */
      sic_bran.uwm130.bchcnt     = nv_batcnt     /* bchcnt     */
      np_driver = TRIM(sic_bran.uwm130.policy) +
                  STRING(sic_bran.uwm130.rencnt,"99" ) +
                  STRING(sic_bran.uwm130.endcnt,"999") +
                  STRING(sic_bran.uwm130.riskno,"999") +
                  STRING(sic_bran.uwm130.itemno,"999").
    IF wdetail.access = "y" THEN  nv_uom6_u =  "A".
    ELSE ASSIGN  nv_uom6_u = ""
        nv_othcod     = ""
        nv_othvar1    = ""
        nv_othvar2    = ""
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    nv_sclass = wdetail.subclass.
    IF nv_uom6_u  =  "A"  THEN DO:
        IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"   OR nv_sclass  =  "520"  Or  nv_sclass  =  "540"   Then  nv_uom6_u  =  "A".   
        Else  ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
    END.
    IF CAPS(nv_uom6_u) = "A"  Then
        Assign  nv_uom6_u          = "A"
        nv_othcod                  = "OTH"
        nv_othvar1                 = "     Accessory  = "
        nv_othvar2                 =  STRING(nv_uom6_u)
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    ELSE ASSIGN  nv_uom6_u              = ""
        nv_othcod                  = ""
        nv_othvar1                 = ""
        nv_othvar2                 = ""
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    IF  (wdetail.covcod = "1")   OR (wdetail.covcod = "5") OR (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN 
        ASSIGN sic_bran.uwm130.uom6_v   =  inte(wdetail.si)
        sic_bran.uwm130.uom7_v   =  inte(wdetail.si)
        sic_bran.uwm130.fptr01      = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02      = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03      = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04      = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05      = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = inte(wdetail.si)
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN sic_bran.uwm130.uom6_v = 0
        sic_bran.uwm130.uom7_v    = 0
        sic_bran.uwm130.fptr01    = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02    = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03    = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04    = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05    = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.TPBIPer <> 0 AND wdetail.TPBIAcc <> 0 AND wdetail.pTPPD <> 0 AND WDETAIL.no_41 <> 0 and  WDETAIL.no_42 <> 0 AND WDETAIL.no_43 <> 0 THEN DO:
        ASSIGN sic_bran.uwm130.uom3_v  =  0
            sic_bran.uwm130.uom4_v     =  0 
            sic_bran.uwm130.uom1_v = wdetail.TPBIPer      
            sic_bran.uwm130.uom2_v = wdetail.TPBIAcc      
            sic_bran.uwm130.uom5_v = wdetail.pTPPD     
            nv_uom1_v              = wdetail.TPBIPer   
            nv_uom2_v              = wdetail.TPBIAcc   
            nv_uom5_v              = wdetail.pTPPD
            WDETAIL.seat41 =  INTE(wdetail.seat)  .
            /*WDETAIL.seat41 =  INTE(wdetail.seat) - 1.*/
    END.
    ELSE DO:
        FIND FIRST stat.clastab_fil Use-index clastab01 Where
          stat.clastab_fil.class   = wdetail.prempa + wdetail.subclass    And
          stat.clastab_fil.covcod  = wdetail.covcod  No-lock  No-error No-wait.
        IF avail stat.clastab_fil Then do:
            ASSIGN sic_bran.uwm130.uom3_v  =  0
                sic_bran.uwm130.uom4_v     =  0 .
            IF wdetail.renpol = "" THEN 
                ASSIGN sic_bran.uwm130.uom1_v =  stat.clastab_fil.uom1_si
                sic_bran.uwm130.uom2_v =  stat.clastab_fil.uom2_si
                sic_bran.uwm130.uom5_v =  stat.clastab_fil.uom5_si
                nv_uom1_v              =  sic_bran.uwm130.uom1_v   
                nv_uom2_v              =  sic_bran.uwm130.uom2_v
                nv_uom5_v              =  sic_bran.uwm130.uom5_v     .
            ELSE ASSIGN sic_bran.uwm130.uom1_v  =  nv_uom1_v
                sic_bran.uwm130.uom2_v     =  nv_uom2_v
                sic_bran.uwm130.uom5_v     =  nv_uom5_v.
            IF wdetail.renpol = "" THEN DO:
                If  wdetail.garage  =  ""  Then
                    ASSIGN 
                    WDETAIL.no_41  =   stat.clastab_fil.si_41unp
                    WDETAIL.no_42  =   stat.clastab_fil.si_42
                    WDETAIL.no_43  =   stat.clastab_fil.si_43
                    WDETAIL.seat41 =   stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
                Else If  wdetail.garage  =  "G"  Then
                    ASSIGN WDETAIL.no_41    =  stat.clastab_fil.si_41pai
                    WDETAIL.no_42    =  stat.clastab_fil.si_42
                    WDETAIL.no_43    =  stat.clastab_fil.impsi_43
                    WDETAIL.seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.                
            END.
        END.   /*stat.clastab_fil*/
    END. /*ELSE DO:*/
    ASSIGN 
        sic_bran.uwm130.uom1_c  = "D1"
        sic_bran.uwm130.uom2_c  = "D2"
        sic_bran.uwm130.uom5_c  = "D5"
        sic_bran.uwm130.uom6_c  = "D6"
        sic_bran.uwm130.uom7_c  = "D7"
        nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then do:
        RUN wgs/wgschsum (INPUT  wdetail.policy, /*a490166 Note Modi*/
                          nv_riskno,
                          nv_itemno).
    END.
END.  /*transaction*/
ASSIGN  s_recid3  = RECID(sic_bran.uwm130) 
    nv_covcod =   wdetail.covcod 
    nv_makdes  =  wdetail.brand 
    nv_moddes  =  IF index(wdetail.model," ") = 0 THEN  wdetail.model ELSE SUBSTR(wdetail.model,1,index(wdetail.model," ") - 1 )
    nv_newsck = " " .
IF SUBSTRING(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
ELSE nv_newsck =  wdetail.stk. 

FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
    sic_bran.uwm301.policy = sic_bran.uwm100.policy   AND
    sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt   AND
    sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt   AND
    sic_bran.uwm301.riskgp = s_riskgp                 AND
    sic_bran.uwm301.riskno = s_riskno                 AND
    sic_bran.uwm301.itemno = s_itemno                 AND
    sic_bran.uwm301.bchyr  = nv_batchyr               AND 
    sic_bran.uwm301.bchno  = nv_batchno               AND 
    sic_bran.uwm301.bchcnt  = nv_batcnt               NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
    DO TRANSACTION:
        CREATE sic_bran.uwm301.
    /*END.
END.*/
ASSIGN sic_bran.uwm301.policy = sic_bran.uwm120.policy                 
    sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
    sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
    sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
    sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
    sic_bran.uwm301.itemno    = s_itemno
    sic_bran.uwm301.tariff    = "X"
    sic_bran.uwm301.covcod    = nv_covcod
    sic_bran.uwm301.cha_no    = wdetail.chasno
    sic_bran.uwm301.eng_no    = wdetail.engno
    sic_bran.uwm301.Tons      = INTEGER(wdetail.weight)
    sic_bran.uwm301.engine    = INTEGER(wdetail.cc)
    sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage    = wdetail.garage
    sic_bran.uwm301.body      = wdetail.body
    sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv_ben83  = wdetail.benname
    sic_bran.uwm301.vehreg    = wdetail.vehreg + nv_provi
    sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
    sic_bran.uwm301.vehuse    = wdetail.vehuse
    sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
    sic_bran.uwm301.modcod    = wdetail.redbook
    sic_bran.uwm301.sckno     = 0
    sic_bran.uwm301.itmdel    = NO
    sic_bran.uwm301.prmtxt    = wdetail.nv_acctxt  
    wdetail.tariff            = sic_bran.uwm301.tariff.
IF wdetail.compul = "y" THEN DO:
    sic_bran.uwm301.cert = "y".
    IF LENGTH(wdetail.stk) = 11 THEN DO:    
        sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
    END.
    IF LENGTH(wdetail.stk) = 13  THEN DO:
        sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
    END.
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
ASSIGN sic_bran.uwm301.bchyr  = nv_batchyr   /* batch Year */
    sic_bran.uwm301.bchno  = nv_batchno   /* bchno      */
    sic_bran.uwm301.bchcnt = nv_batcnt    /* bchcnt     */ 
    nv_drivage1 = 0  /*A58-0103*/
    nv_drivage2 = 0. /*A58-0103*/
IF  wdetail.drivnam = "Y" THEN DO :      /*note add 07/11/2005*/
    DEF VAR no_policy AS CHAR FORMAT "x(20)" .
    DEF VAR no_rencnt AS CHAR FORMAT "99".
    DEF VAR no_endcnt AS CHAR FORMAT "999".
    DEF VAR no_riskno AS CHAR FORMAT "999".
    DEF VAR no_itemno AS CHAR FORMAT "999".
    ASSIGN no_policy = uwm301.policy  
        no_rencnt = STRING(sic_bran.uwm301.rencnt,"99")  
        no_endcnt = STRING(sic_bran.uwm301.endcnt,"999")  
        no_riskno = "001" 
        no_itemno = "001" 
        nv_drivage1 =  YEAR(TODAY) - INT(SUBSTR(wdetail.drivbir1,7,4))  
        nv_drivage2 =  YEAR(TODAY) - INT(SUBSTR(wdetail.drivbir2,7,4))  .
    IF wdetail.drivbir1 <> " "  AND wdetail.drivnam1 <> " " THEN   
        ASSIGN nv_drivbir1      = STRING(INT(SUBSTR(wdetail.drivbir1,7,4)) + 543) 
        wdetail.drivbir1 = SUBSTR(wdetail.drivbir1,1,6) + nv_drivbir1.
    IF wdetail.drivbir2 <>  " " AND wdetail.drivnam2 <> " " THEN  
        ASSIGN nv_drivbir2      = STRING(INT(SUBSTR(wdetail.drivbir2,7,4)) + 543) 
        wdetail.drivbir2 = SUBSTR(wdetail.drivbir2,1,6) + nv_drivbir2.
    FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
        brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
        brstat.mailtxt_fil.bchyr   = nv_batchyr     AND                                               
        brstat.mailtxt_fil.bchno   = nv_batchno     AND
        brstat.mailtxt_fil.bchcnt  = nv_batcnt      NO-LOCK  NO-ERROR  NO-WAIT.
    IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.                                                      
    FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
        brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno     AND
        brstat.mailtxt_fil.lnumber = nv_lnumber  AND
        brstat.mailtxt_fil.bchyr   = nv_batchyr  AND                                               
        brstat.mailtxt_fil.bchno   = nv_batchno  AND
        brstat.mailtxt_fil.bchcnt  = nv_batcnt   NO-LOCK  NO-ERROR  NO-WAIT.
    IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
        CREATE brstat.mailtxt_fil.
        ASSIGN brstat.mailtxt_fil.policy = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
            brstat.mailtxt_fil.lnumber   = nv_lnumber 
            brstat.mailtxt_fil.ltext     = wdetail.drivnam1 + FILL(" ",50 - LENGTH(wdetail.drivnam1)) 
            brstat.mailtxt_fil.ltext2    = wdetail.drivbir1 + "  " + string(nv_drivage1) 
            nv_drivno                    = 1 
            brstat.mailtxt_fil.bchyr     = nv_batchyr 
            brstat.mailtxt_fil.bchno     = nv_batchno 
            brstat.mailtxt_fil.bchcnt    = nv_batcnt 
            SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   .  
        IF wdetail.drivnam2 <> "" THEN DO:
            CREATE brstat.mailtxt_fil. 
            ASSIGN  brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",50 - LENGTH(wdetail.drivnam2)) 
                brstat.mailtxt_fil.ltext2   = wdetail.drivbir2 + "  " + string(nv_drivage2) 
                nv_drivno                   = 2 
                brstat.mailtxt_fil.bchyr = nv_batchyr 
                brstat.mailtxt_fil.bchno = nv_batchno 
                brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"    .
        END.  /*drivnam2 <> " " */
    END. /*End Avail Brstat*/
    ELSE  DO:
        CREATE  brstat.mailtxt_fil.
        ASSIGN  brstat.mailtxt_fil.policy = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
            brstat.mailtxt_fil.lnumber    = nv_lnumber 
            brstat.mailtxt_fil.ltext      = wdetail.drivnam1 + FILL(" ",50 - LENGTH(wdetail.drivnam1))
            brstat.mailtxt_fil.ltext2     = wdetail.drivbir1 + "  " +  TRIM(string(nv_drivage1)).
        IF wdetail.drivnam2 <> "" THEN DO:
            CREATE  brstat.mailtxt_fil.
            ASSIGN brstat.mailtxt_fil.policy = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                brstat.mailtxt_fil.lnumber   = nv_lnumber + 1
                brstat.mailtxt_fil.ltext     = wdetail.drivnam2 + FILL(" ",50 - LENGTH(wdetail.drivnam2)) 
                brstat.mailtxt_fil.ltext2    = wdetail.drivbir2 + "  " + TRIM(string(nv_drivage1)) 
                brstat.mailtxt_fil.bchyr     = nv_batchyr 
                brstat.mailtxt_fil.bchno     = nv_batchno 
                brstat.mailtxt_fil.bchcnt    = nv_batcnt 
                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . 
        END.
    END.
END.  
ELSE nv_drivno = 0.
IF wdetail.renpol <> "" THEN DO:
    IF nv_driver = ""   THEN ASSIGN nv_drivno = 0.
    ELSE DO:
        ASSIGN wdetail.drivnam = "Y".
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
END.
s_recid4         = RECID(sic_bran.uwm301).
IF wdetail.redbook <> ""  THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 
        WHERE stat.maktab_fil.sclass = wdetail.subclass  AND
        stat.maktab_fil.modcod = wdetail.redbook         No-lock no-error no-wait.
    If  avail  stat.maktab_fil  Then do:
        ASSIGN  sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes      =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes /*note modi 07/11/05*/
            wdetail.cargrp              =  stat.maktab_fil.prmpac
            sic_bran.uwm301.vehgrp      =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body        =  stat.maktab_fil.body.
    END.
END.
ELSE DO:
    Find First stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =     nv_makdes                And                  
        index(stat.maktab_fil.moddes,nv_moddes)  <> 0           AND  
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND 
        stat.maktab_fil.sclass   =     wdetail.subclass         AND 
       (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     inte(wdetail.seat)       No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp          =  stat.maktab_fil.prmpac
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body    =  stat.maktab_fil.body.
    END.
END.
IF wdetail.renpol = "" THEN NO_baseprm = deci(wdetail.baseprem).
END.
END. /*trasection uwm301 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_checkdata02bk C-Win 
PROCEDURE proc_checkdata02bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_process   = "Create data to table uwm130 ...." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
  sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
  sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
  sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
  sic_bran.uwm130.riskgp = s_riskgp               AND            /*0*/
  sic_bran.uwm130.riskno = s_riskno               AND            /*1*/
  sic_bran.uwm130.itemno = s_itemno               AND            /*1*/
  sic_bran.uwm130.bchyr  = nv_batchyr              AND 
  sic_bran.uwm130.bchno  = nv_batchno              AND 
  sic_bran.uwm130.bchcnt = nv_batcnt             NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN
  DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN  sic_bran.uwm130.policy = sic_bran.uwm120.policy
      sic_bran.uwm130.rencnt     = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
      sic_bran.uwm130.riskgp     = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
      sic_bran.uwm130.itemno     = s_itemno 
      sic_bran.uwm130.bchyr      = nv_batchyr    /* batch Year */
      sic_bran.uwm130.bchno      = nv_batchno    /* bchno      */
      sic_bran.uwm130.bchcnt     = nv_batcnt     /* bchcnt     */
      np_driver = TRIM(sic_bran.uwm130.policy) +
                  STRING(sic_bran.uwm130.rencnt,"99" ) +
                  STRING(sic_bran.uwm130.endcnt,"999") +
                  STRING(sic_bran.uwm130.riskno,"999") +
                  STRING(sic_bran.uwm130.itemno,"999").
    IF wdetail.access = "y" THEN  nv_uom6_u =  "A".
    ELSE ASSIGN  nv_uom6_u = ""
        nv_othcod     = ""
        nv_othvar1    = ""
        nv_othvar2    = ""
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    nv_sclass = wdetail.subclass.
    IF nv_uom6_u  =  "A"  THEN DO:
      IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"   OR nv_sclass  =  "520"  Or  nv_sclass  =  "540"   Then  nv_uom6_u  =  "A".   
      Else  ASSIGN wdetail.pass    = "N"
          wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
    END.
    IF CAPS(nv_uom6_u) = "A"  Then
        Assign  nv_uom6_u          = "A"
        nv_othcod                  = "OTH"
        nv_othvar1                 = "     Accessory  = "
        nv_othvar2                 =  STRING(nv_uom6_u)
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    ELSE ASSIGN  nv_uom6_u              = ""
        nv_othcod                  = ""
        nv_othvar1                 = ""
        nv_othvar2                 = ""
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    IF  (wdetail.covcod = "1")   OR (wdetail.covcod = "5") OR (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN 
        ASSIGN sic_bran.uwm130.uom6_v   =  inte(wdetail.si)
        sic_bran.uwm130.uom7_v   =  inte(wdetail.si)
        sic_bran.uwm130.fptr01      = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02      = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03      = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04      = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05      = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = inte(wdetail.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN sic_bran.uwm130.uom6_v = 0
            sic_bran.uwm130.uom7_v    = 0
            sic_bran.uwm130.fptr01    = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02    = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03    = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04    = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05    = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    
        FIND FIRST stat.clastab_fil Use-index clastab01 Where
          stat.clastab_fil.class   = wdetail.prempa + wdetail.subclass    And
          stat.clastab_fil.covcod  = wdetail.covcod  No-lock  No-error No-wait.
        IF avail stat.clastab_fil Then do:
            Assign  
            /*sic_bran.uwm130.uom1_v     =  stat.clastab_fil.uom1_si
            sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si
            sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si*/
            /*sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si  */        
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            /*wdetail.comper             =  stat.clastab_fil.uom8_si                
            wdetail.comacc             =  stat.clastab_fil.uom9_si*/ .
            IF wdetail.renpol = "" THEN 
                ASSIGN 
                sic_bran.uwm130.uom1_v =  stat.clastab_fil.uom1_si
                sic_bran.uwm130.uom2_v =  stat.clastab_fil.uom2_si
                sic_bran.uwm130.uom5_v =  stat.clastab_fil.uom5_si
                nv_uom1_v              =  sic_bran.uwm130.uom1_v   
                nv_uom2_v              =  sic_bran.uwm130.uom2_v
                nv_uom5_v              =  sic_bran.uwm130.uom5_v        .
            ELSE /*wdetail.renpol <> "" *//*A58-0103 กรณี พบ pack Z */
                ASSIGN sic_bran.uwm130.uom1_v  =  nv_uom1_v
                    sic_bran.uwm130.uom2_v     =  nv_uom2_v
                    sic_bran.uwm130.uom5_v     =  nv_uom5_v.
            ASSIGN sic_bran.uwm130.uom1_c  = "D1"
                sic_bran.uwm130.uom2_c  = "D2"
                sic_bran.uwm130.uom5_c  = "D5"
                sic_bran.uwm130.uom6_c  = "D6"
                sic_bran.uwm130.uom7_c  = "D7".
            IF wdetail.renpol = "" THEN DO:
                If  wdetail.garage  =  ""  Then
                    ASSIGN WDETAIL.no_41 =   stat.clastab_fil.si_41unp
                    WDETAIL.no_42        =   stat.clastab_fil.si_42
                    WDETAIL.no_43        =   stat.clastab_fil.si_43
                    WDETAIL.seat41       =   stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
                Else If  wdetail.garage  =  "G"  Then
                    ASSIGN WDETAIL.no_41    =  stat.clastab_fil.si_41pai
                    WDETAIL.no_42    =  stat.clastab_fil.si_42
                    WDETAIL.no_43    =  stat.clastab_fil.impsi_43
                    WDETAIL.seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.                
            END.
        END.  /*stat.clastab_fil*/
    

    ASSIGN nv_riskno = 1
           nv_itemno = 1.
    IF wdetail.covcod = "1" Then do:
        RUN wgs/wgschsum(INPUT  wdetail.policy, /*a490166 Note Modi*/
                         nv_riskno,
                         nv_itemno).
    END.
END.  /*transaction*/
ASSIGN  s_recid3  = RECID(sic_bran.uwm130) 
    nv_covcod =   wdetail.covcod 
    nv_makdes  =  wdetail.brand 
    nv_moddes  =  IF index(wdetail.model," ") = 0 THEN  wdetail.model ELSE SUBSTR(wdetail.model,1,index(wdetail.model," ") - 1 )
    nv_newsck = " " .
IF SUBSTRING(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
ELSE nv_newsck =  wdetail.stk. 

FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
    sic_bran.uwm301.policy = sic_bran.uwm100.policy   AND
    sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt   AND
    sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt   AND
    sic_bran.uwm301.riskgp = s_riskgp                 AND
    sic_bran.uwm301.riskno = s_riskno                 AND
    sic_bran.uwm301.itemno = s_itemno                 AND
    sic_bran.uwm301.bchyr  = nv_batchyr               AND 
    sic_bran.uwm301.bchno  = nv_batchno               AND 
    sic_bran.uwm301.bchcnt  = nv_batcnt               NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
    DO TRANSACTION:
        CREATE sic_bran.uwm301.
    /*END.
END.*/
ASSIGN sic_bran.uwm301.policy = sic_bran.uwm120.policy                 
    sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
    sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
    sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
    sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
    sic_bran.uwm301.itemno    = s_itemno
    sic_bran.uwm301.tariff    = "X"
    sic_bran.uwm301.covcod    = nv_covcod
    sic_bran.uwm301.cha_no    = wdetail.chasno
    sic_bran.uwm301.eng_no    = wdetail.engno
    sic_bran.uwm301.Tons      = INTEGER(wdetail.weight)
    sic_bran.uwm301.engine    = INTEGER(wdetail.cc)
    sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage    = wdetail.garage
    sic_bran.uwm301.body      = wdetail.body
    sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv_ben83  = wdetail.benname
    sic_bran.uwm301.vehreg    = wdetail.vehreg + nv_provi
    sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
    sic_bran.uwm301.vehuse    = wdetail.vehuse
    sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
    sic_bran.uwm301.modcod    = wdetail.redbook
    sic_bran.uwm301.sckno     = 0
    sic_bran.uwm301.itmdel    = NO
    sic_bran.uwm301.prmtxt    = wdetail.nv_acctxt  
    wdetail.tariff            = sic_bran.uwm301.tariff.
IF wdetail.compul = "y" THEN DO:
    sic_bran.uwm301.cert = "y".
    IF LENGTH(wdetail.stk) = 11 THEN DO:    
        sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
    END.
    IF LENGTH(wdetail.stk) = 13  THEN DO:
        sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
    END.
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
ASSIGN sic_bran.uwm301.bchyr  = nv_batchyr   /* batch Year */
    sic_bran.uwm301.bchno  = nv_batchno   /* bchno      */
    sic_bran.uwm301.bchcnt = nv_batcnt    /* bchcnt     */ 
    nv_drivage1 = 0  /*A58-0103*/
    nv_drivage2 = 0. /*A58-0103*/
IF  wdetail.drivnam = "Y" THEN DO :      /*note add 07/11/2005*/
    DEF VAR no_policy AS CHAR FORMAT "x(20)" .
    DEF VAR no_rencnt AS CHAR FORMAT "99".
    DEF VAR no_endcnt AS CHAR FORMAT "999".
    DEF VAR no_riskno AS CHAR FORMAT "999".
    DEF VAR no_itemno AS CHAR FORMAT "999".
    ASSIGN no_policy = uwm301.policy  
        no_rencnt = STRING(sic_bran.uwm301.rencnt,"99")  
        no_endcnt = STRING(sic_bran.uwm301.endcnt,"999")  
        no_riskno = "001" 
        no_itemno = "001" 
        nv_drivage1 =  YEAR(TODAY) - INT(SUBSTR(wdetail.drivbir1,7,4))  
        nv_drivage2 =  YEAR(TODAY) - INT(SUBSTR(wdetail.drivbir2,7,4))  .
    IF wdetail.drivbir1 <> " "  AND wdetail.drivnam1 <> " " THEN   
        ASSIGN nv_drivbir1      = STRING(INT(SUBSTR(wdetail.drivbir1,7,4)) + 543) 
        wdetail.drivbir1 = SUBSTR(wdetail.drivbir1,1,6) + nv_drivbir1.
    IF wdetail.drivbir2 <>  " " AND wdetail.drivnam2 <> " " THEN  
        ASSIGN nv_drivbir2      = STRING(INT(SUBSTR(wdetail.drivbir2,7,4)) + 543) 
        wdetail.drivbir2 = SUBSTR(wdetail.drivbir2,1,6) + nv_drivbir2.
    FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
        brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
        brstat.mailtxt_fil.bchyr   = nv_batchyr     AND                                               
        brstat.mailtxt_fil.bchno   = nv_batchno     AND
        brstat.mailtxt_fil.bchcnt  = nv_batcnt      NO-LOCK  NO-ERROR  NO-WAIT.
    IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.                                                      
    FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
        brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno     AND
        brstat.mailtxt_fil.lnumber = nv_lnumber  AND
        brstat.mailtxt_fil.bchyr   = nv_batchyr  AND                                               
        brstat.mailtxt_fil.bchno   = nv_batchno  AND
        brstat.mailtxt_fil.bchcnt  = nv_batcnt   NO-LOCK  NO-ERROR  NO-WAIT.
    IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
        CREATE brstat.mailtxt_fil.
        ASSIGN brstat.mailtxt_fil.policy = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
            brstat.mailtxt_fil.lnumber   = nv_lnumber 
            brstat.mailtxt_fil.ltext     = wdetail.drivnam1 + FILL(" ",50 - LENGTH(wdetail.drivnam1)) 
            brstat.mailtxt_fil.ltext2    = wdetail.drivbir1 + "  " + string(nv_drivage1) 
            nv_drivno                    = 1 
            brstat.mailtxt_fil.bchyr     = nv_batchyr 
            brstat.mailtxt_fil.bchno     = nv_batchno 
            brstat.mailtxt_fil.bchcnt    = nv_batcnt 
            SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   .  
        IF wdetail.drivnam2 <> "" THEN DO:
            CREATE brstat.mailtxt_fil. 
            ASSIGN  brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",50 - LENGTH(wdetail.drivnam2)) 
                brstat.mailtxt_fil.ltext2   = wdetail.drivbir2 + "  " + string(nv_drivage2) 
                nv_drivno                   = 2 
                brstat.mailtxt_fil.bchyr = nv_batchyr 
                brstat.mailtxt_fil.bchno = nv_batchno 
                brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"    .
        END.  /*drivnam2 <> " " */
    END. /*End Avail Brstat*/
    ELSE  DO:
        CREATE  brstat.mailtxt_fil.
        ASSIGN  brstat.mailtxt_fil.policy = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
            brstat.mailtxt_fil.lnumber    = nv_lnumber 
            brstat.mailtxt_fil.ltext      = wdetail.drivnam1 + FILL(" ",50 - LENGTH(wdetail.drivnam1))
            brstat.mailtxt_fil.ltext2     = wdetail.drivbir1 + "  " +  TRIM(string(nv_drivage1)).
        IF wdetail.drivnam2 <> "" THEN DO:
            CREATE  brstat.mailtxt_fil.
            ASSIGN brstat.mailtxt_fil.policy = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                brstat.mailtxt_fil.lnumber   = nv_lnumber + 1
                brstat.mailtxt_fil.ltext     = wdetail.drivnam2 + FILL(" ",50 - LENGTH(wdetail.drivnam2)) 
                brstat.mailtxt_fil.ltext2    = wdetail.drivbir2 + "  " + TRIM(string(nv_drivage1)) 
                brstat.mailtxt_fil.bchyr     = nv_batchyr 
                brstat.mailtxt_fil.bchno     = nv_batchno 
                brstat.mailtxt_fil.bchcnt    = nv_batcnt 
                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . 
        END.
    END.
END.  /*A58-0103*/
ELSE nv_drivno = 0.
IF wdetail.renpol <> "" THEN DO:
    IF nv_driver = ""   THEN ASSIGN nv_drivno = 0.
    ELSE DO:
        ASSIGN wdetail.drivnam = "Y".
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
END.
/*A58-0103*/
s_recid4         = RECID(sic_bran.uwm301).
IF wdetail.redbook <> ""  THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 
        WHERE stat.maktab_fil.sclass = wdetail.subclass  AND
        stat.maktab_fil.modcod = wdetail.redbook         No-lock no-error no-wait.
    If  avail  stat.maktab_fil  Then do:
        ASSIGN  sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes      =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes /*note modi 07/11/05*/
            wdetail.cargrp              =  stat.maktab_fil.prmpac
            sic_bran.uwm301.vehgrp      =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body        =  stat.maktab_fil.body.
    END.
END.
ELSE DO:
    Find First stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =     nv_makdes                And                  
        index(stat.maktab_fil.moddes,nv_moddes)  <> 0           AND  
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND 
        stat.maktab_fil.sclass   =     wdetail.subclass         AND 
       (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     inte(wdetail.seat)       No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp          =  stat.maktab_fil.prmpac
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body    =  stat.maktab_fil.body.
    END.
END.
/*IF sic_bran.uwm301.modcod = ""  THEN DO:
    ASSIGN wdetail.pass    = "N"
           WDETAIL.COMMENT =  wdetail.comment + "| NOT FIND MODEL CODE IN  MAKTAB_FIL".
END.*/
IF wdetail.renpol = "" THEN NO_baseprm = deci(wdetail.baseprem).
END.
END. /*trasection uwm301 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_checkdata03 C-Win 
PROCEDURE proc_checkdata03 :
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
    nv_class  = wdetail.prempa +  wdetail.subclass
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = DECI(wdetail.cc)
    nv_tons   = deci(wdetail.weight)
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse
    nv_COMPER = wdetail.comper
    nv_comacc = wdetail.comacc
    nv_seats  = INTE(wdetail.seat)
    nv_tons   = DECI(wdetail.weight) 
    fi_process   = "Create data to table uwm120,uwm301 ...." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
/*----------- comprem ---------------*/
IF wdetail.compul = "y" THEN DO:
    RUN wgs\wgscomp. 
    If  nv_comper  =  0  Then   nv_comacc =  0 . 
    Else do:
        IF   nv_comacc  <> 0  Then do:
            ASSIGN nv_compcod   = "COMP"
                nv_compvar1     = "     Compulsory  =   "
                nv_compvar2     = STRING(nv_comacc)
                Substr(nv_compvar,1,30)   = nv_compvar1
                Substr(nv_compvar,31,30)  = nv_compvar2.
            IF n_curbil = "bht" THEN
                nv_comacc = Truncate(nv_comacc, 0).
            ELSE 
                nv_comacc = nv_comacc.  
            ASSIGN sic_bran.uwm130.uom8_c  = "D8"
                sic_bran.uwm130.uom9_c  = "D9". /*copy จาก usomn01.p*/
        END.
        Else assign          nv_compprm     = 0
            nv_compcod     = " "
            nv_compvar1    = " "
            nv_compvar2    = " "
            nv_compvar     = " ".
        If  nv_compprm  =  0  Then  RUN wgs\wgscomp.    
        nv_comacc  = nv_comacc . 
    END.   /* else do */ 
    If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0. 
END.  /*compul y*/
ELSE DO:
    ASSIGN nv_compprm  = 0
        nv_compcod     = " "
        nv_compvar1    = " "
        nv_compvar2    = " "
        nv_compvar     = " "
        nv_COMPER      = 0
        nv_comacc      = 0
        sic_bran.uwm130.uom8_v  =  0               
        sic_bran.uwm130.uom9_v  =  0.
END.
If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0. 
/*-----nv_drivcod---------------------*/
ASSIGN nv_drivvar1 = wdetail.drivnam1
    nv_drivvar2    = wdetail.drivnam2.
If wdetail.drivnam  = "N"  Then do:
    Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
END.
ELSE DO:
    IF  nv_drivno  > 2  Then 
        ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".
    ASSIGN  nv_drivvar     = " "
        nv_drivvar1    = "     Driver name person = "
        nv_drivvar2    = String(nv_drivno)
        Substr(nv_drivvar,1,30)  = nv_drivvar1
        Substr(nv_drivvar,31,30) = nv_drivvar2.
    /*RUN proc_usdcod.     *//*A58-0103*/
    RUN proc_usdcodnew .     /*A58-0103*/
END.
/*-------nv_baseprm----------*/
ASSIGN nv_basevar = " "      nv_baseprm = wdetail.baseprem.
IF /*(wdetail.renpol = "") OR*/  (nv_baseprm = 0 ) THEN RUN wgs\wgsfbas.     /*25/09/2006 add condition base in range*/
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
ASSIGN nv_41 =  WDETAIL.no_41  
       nv_41 =  WDETAIL.no_41  
       nv_42 =  WDETAIL.no_42  
       nv_43 =  WDETAIL.no_43 
       nv_seat41 = integer(wdetail.seat41).
/*comment by : Ranu I. A64-0138...
RUN WGS\WGSOPER(INPUT nv_tariff, /*pass*/ /*a490166 note modi*/
                nv_class,
                nv_key_b,
                nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/
...end A64-0138...*/                
Assign nv_411var = ""   nv_412var = ""         /*---------fi_41---------*/
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
ASSIGN                                                    /* -------fi_42---------*/
    nv_42var    = " "
    nv_42cod   = "42" 
    nv_42var1  = "     Medical Expense = "
    nv_42var2  = STRING(nv_42) 
    SUBSTRING(nv_42var,1,30)   = nv_42var1 
    SUBSTRING(nv_42var,31,30)  = nv_42var2.
ASSIGN                                                    /*---------fi_43--------------*/
    nv_43var    = " "   
    nv_43prm = nv_43
    nv_43cod   = "43"
    nv_43var1  = "     Airfrieght = "
    nv_43var2  =  STRING(nv_43)
    SUBSTRING(nv_43var,1,30)   = nv_43var1
    SUBSTRING(nv_43var,31,30)  = nv_43var2.
/*comment by : Ranu I. A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,      
                    nv_class,
                    nv_key_b,
                    nv_comdat).*/ 
/*------nv_usecod------------*/
ASSIGN  nv_usevar = ""
    nv_usecod  = "USE" + TRIM(wdetail.vehuse)
    nv_usevar1    = "     Vehicle Use = "
    nv_usevar2    =  wdetail.vehuse
    Substring(nv_usevar,1,30)   = nv_usevar1
    Substring(nv_usevar,31,30)  = nv_usevar2.
/*-----nv_engcod-----------------*/
ASSIGN nv_sclass =  wdetail.subclass.
RUN wgs\wgsoeng.
/*-----nv_yrcod----------------------------*/  
ASSIGN nv_yrvar = ""
    nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
    nv_yrvar1  = "     Vehicle Year = "
    nv_yrvar2  =  String(wdetail.caryear)
    nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
    Substr(nv_yrvar,1,30)    = nv_yrvar1
    Substr(nv_yrvar,31,30)   = nv_yrvar2.
/*-----nv_sicod----------------------------*/ 
Assign nv_sivar = ""     
    nv_sicod     = "SI"
    nv_sivar1    = "     Own Damage = "
    nv_sivar2    =  STRING(wdetail.si)
    SUBSTRING(nv_sivar,1,30)  = nv_sivar1
    SUBSTRING(nv_sivar,31,30) = nv_sivar2
    nv_totsi     =  inte(wdetail.si).
/*----------nv_grpcod--------------------*/
ASSIGN  nv_grpvar = ""
    nv_grpcod      = "GRP" + wdetail.cargrp
    nv_grpvar1     = "     Vehicle Group = "
    nv_grpvar2     = wdetail.cargrp
    Substr(nv_grpvar,1,30)  = nv_grpvar1
    Substr(nv_grpvar,31,30) = nv_grpvar2.
/*-------------nv_bipcod--------------------*/
ASSIGN nv_bipvar = ""
    nv_bipcod      = "BI1"
    nv_bipvar1     = "     BI per Person = "
    nv_bipvar2     = STRING(uwm130.uom1_v)
    SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
    SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
/*-------------nv_biacod--------------------*/
ASSIGN nv_biavar   = ""
    nv_biacod      = "BI2"
    nv_biavar1     = "     BI per Accident = "
    nv_biavar2     = STRING(uwm130.uom2_v)
    SUBSTRING(nv_biavar,1,30)  = nv_biavar1
    SUBSTRING(nv_biavar,31,30) = nv_biavar2.
/*-------------nv_pdacod--------------------*/
ASSIGN nv_pdavar   = ""
    nv_pdacod      = "PD"
    nv_pdavar1     = "     PD per Accident = "
    nv_pdavar2     = STRING(uwm130.uom5_v)
    SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
    SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
/*--------------- deduct ----------------*/
/* caculate deduct OD  */
DEF VAR dod0 AS INTEGER.
/*kridtiya i.A56-0152...
DEF VAR dod1 AS INTEGER.
DEF VAR dod2 AS INTEGER.
DEF VAR dpd0 AS INTEGER. kridtiya i.A56-0152...*/
dod0 = inte(wdetail.deductda).
IF dod0 > 3000 THEN DO:
    dod1 = 3000.
    dod2 = dod0 - dod1.
END.
ELSE dod1 = dod0.

IF dod1<> 0  THEN DO:
    ASSIGN nv_odcod = "DC01"
        nv_prem     =   dod1.  
    RUN Wgs\Wgsmx024( nv_tariff,    
                      nv_odcod,
                      nv_class,
                      nv_key_b,
                      nv_comdat,
                      INPUT-OUTPUT nv_prem,
                      OUTPUT nv_chk ,
                      OUTPUT nv_baseap).
    IF NOT nv_chk THEN  
        ASSIGN wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".

    ASSIGN nv_dedod1var   = ""
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
    /*comment by : A64-0138 ...
    Run  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */
                      nv_tariff,
                      nv_class,
                      nv_key_b,
                      nv_comdat,
                      nv_cons,
                      OUTPUT nv_prem). */         
    ASSIGN nv_dedod2var = ""
        nv_aded1prm     = nv_prem
        nv_dedod2_cod   = "DOD2"
        nv_dedod2var1   = "     Add Ded.OD = "
        nv_dedod2var2   =  STRING(dod2)
        SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
        SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2 .
        /*nv_dedod2_prm   = nv_prem.*/ /*A64-0138*/
END.
/***** pd *******/
Assign
    nv_dedpdvar  = " "
    dpd0     = inte(wdetail.deductpd) 
    nv_cons  = "PD"
    nv_ded   = dpd0.
/*comment by : A64-0138...
Run  Wgs\Wgsmx025(INPUT  nv_ded, 
                  nv_tariff,
                  nv_class,
                  nv_key_b,
                  nv_comdat,
                  nv_cons,
                  OUTPUT nv_prem).
nv_ded2prm    = nv_prem.
...end A64-0138...*/
IF dpd0 <> 0  THEN
 ASSIGN nv_dedpd_cod   = "DPD"
     nv_dedpdvar1   = "     Deduct PD = "
     nv_dedpdvar2   =  STRING(nv_ded)
     SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
     SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
     /*nv_dedpd_prm  = nv_prem.*/ /*A64-0138*/
nv_flet_per = INTE(wdetail.fleet).
IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
    Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
    ASSIGN wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
END.
IF nv_flet_per = 0 Then do:
    ASSIGN nv_flet     = 0
        nv_fletvar  = " ".
END.
/*comment by : A64-0138...
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
    nv_fletvar     = " "
    nv_fletvar1    = "     Fleet % = "
    nv_fletvar2    =  STRING(nv_flet_per)
    SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
    SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
IF nv_flet   = 0  THEN nv_fletvar  = " ".

DEF VAR nv_ncbyrs AS INTE.
ASSIGN 
    NV_NCBPER = INTE(WDETAIL.NCB)
    nv_ncb = INTE(WDETAIL.NCB).
nv_ncbvar = " ".
If nv_ncbper  <> 0 Then do:
    Find first sicsyac.xmm104 Use-index xmm10401 Where
        sicsyac.xmm104.tariff = nv_tariff           AND 
        sicsyac.xmm104.class  = nv_class            AND 
        sicsyac.xmm104.covcod = nv_covcod           AND 
        sicsyac.xmm104.ncbper = INTE(wdetail.ncb) No-lock no-error no-wait.
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
/*comment by : A64-0138...
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
    ASSIGN 
    nv_ncbvar1   = "     NCB % = "
    nv_ncbvar2   =  STRING(nv_ncbper)
    SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
    SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.

nv_cl_per  = deci(wdetail.loadclm).
nv_clmvar  = " ".
IF nv_cl_per  <> 0  THEN
    Assign 
    nv_clmvar1   = " Load Claim % = "
    nv_clmvar2   =  STRING(nv_cl_per)
    SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
    SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.

/*comment by : A64-0138...
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
    ASSIGN  nv_clmvar1   = " Load Claim % = "
    nv_clmvar2   =  STRING(nv_cl_per)
    SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
    SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
... end A64-0138...*/

nv_dsspcvar   = " ".
IF  nv_dss_per   <> 0  THEN
    ASSIGN  nv_dsspcvar1   = "     Discount Special % = "
    nv_dsspcvar2   =  STRING(nv_dss_per)
    SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
    SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.

/*comment by : A64-0138...
RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    nv_totsi,
                    nv_uom1_v ,       
                    nv_uom2_v ,       
                    nv_uom5_v ).*/
/*IF nv_gapprm <> inte(wdetail.volprem) /*OR inte(wdetail.Compprem) <> nv_compprm */ THEN  DO:
    MESSAGE "เบี้ยไม่ตรงกับเบี้ยที่คำนวณได้" + wdetail.volprem + " <> " + STRING(nv_gapprm) VIEW-AS ALERT-BOX.
    ASSIGN  WDETAIL.WARNING  = "เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้"
        wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้ "
        wdetail.pass    = "N".
END.*/
/*comment by : A64-0138...
IF wdetail.pass <> "N"  THEN 
    ASSIGN wdetail.comment = "COMPLETE"
    WDETAIL.WARNING = ""
    wdetail.pass    = "Y".*/

RUN proc_calpremt.      /*A64-0138*/
RUN proc_adduwd132prem. /*A64-0138*/

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
    ASSIGN sic_bran.uwm100.prem_t = nv_gapprm
        sic_bran.uwm100.sigr_p = inte(wdetail.si)
        sic_bran.uwm100.gap_p  = nv_gapprm.
    IF wdetail.pass <> "Y" THEN DO:
        ASSIGN  sic_bran.uwm100.impflg = NO
            sic_bran.uwm100.imperr = wdetail.comment.      
    END.
END.
FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN DO:
    ASSIGN sic_bran.uwm120.gap_r  = nv_gapprm
        sic_bran.uwm120.prem_r    = nv_pdprm
        sic_bran.uwm120.sigr      = inte(wdetail.si).
END.
FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN DO:
  ASSIGN /* sic_bran.uwm301.ncbper   = nv_ncbper     */ /* A64-0138*/
         /* sic_bran.uwm301.ncbyrs       = nv_ncbyrs */ /* A64-0138*/
          sic_bran.uwm301.mv41seat     = wdetail.seat41.
END.
/* comment by : A64-0138..
RUN WGS\WGSTN132(INPUT S_RECID3,  
                 INPUT S_RECID4).*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_checkdata03pl C-Win 
PROCEDURE proc_checkdata03pl :
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
    nv_class  = wdetail.prempa +  wdetail.subclass
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = DECI(wdetail.cc)
    nv_tons   = deci(wdetail.weight)
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse
    nv_COMPER = wdetail.comper 
    nv_comacc = wdetail.comacc
    nv_seats  = INTE(wdetail.seat)
    nv_tons   = DECI(wdetail.weight) 
    fi_process   = "Create data to table uwm120,uwm301 ...." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
/*----------- comprem ---------------*/
IF wdetail.compul = "y" THEN DO:
    RUN wgs\wgscomp. 
    If  nv_comper  =  0  Then   nv_comacc =  0 . 
    Else do:
        IF   nv_comacc  <> 0  Then do:
            ASSIGN nv_compcod   = "COMP"
                nv_compvar1     = "     Compulsory  =   "
                nv_compvar2     = STRING(nv_comacc)
                Substr(nv_compvar,1,30)   = nv_compvar1
                Substr(nv_compvar,31,30)  = nv_compvar2.
            IF n_curbil = "bht" THEN
                nv_comacc = Truncate(nv_comacc, 0).
            ELSE 
                nv_comacc = nv_comacc.  
            ASSIGN sic_bran.uwm130.uom8_c  = "D8"
                sic_bran.uwm130.uom9_c  = "D9". /*copy จาก usomn01.p*/
        END.
        Else assign          nv_compprm     = 0
            nv_compcod     = " "
            nv_compvar1    = " "
            nv_compvar2    = " "
            nv_compvar     = " ".
        If  nv_compprm  =  0  Then  RUN wgs\wgscomp.    
        nv_comacc  = nv_comacc . 
    END.   /* else do */ 
    If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0. 
END.  /*compul y*/
ELSE DO:
    ASSIGN nv_compprm  = 0
        nv_compcod     = " "
        nv_compvar1    = " "
        nv_compvar2    = " "
        nv_compvar     = " "
        nv_COMPER      = 0
        nv_comacc      = 0
        sic_bran.uwm130.uom8_v  =  0               
        sic_bran.uwm130.uom9_v  =  0.
END.
If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0. 
/*-----nv_drivcod---------------------*/
ASSIGN nv_drivvar1 = wdetail.drivnam1
    nv_drivvar2    = wdetail.drivnam2.
If wdetail.drivnam  = "N"  Then do:
    Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
END.
ELSE DO:
    IF  nv_drivno  > 2  Then 
        ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".
    ASSIGN  nv_drivvar = " "
        nv_drivvar1    = "     Driver name person = "
        nv_drivvar2    = String(nv_drivno)
        Substr(nv_drivvar,1,30)  = nv_drivvar1
        Substr(nv_drivvar,31,30) = nv_drivvar2.
    /*RUN proc_usdcod.  */    /*A58-0103*/
    RUN proc_usdcodnew .      /*A58-0103*/
END.
/*-------nv_baseprm----------*/
ASSIGN nv_baseprm = deci(wdetail.baseprem) .
IF (nv_baseprm = 0 ) THEN RUN wgs\wgsfbas.     /*25/09/2006 add condition base in range*/
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
ASSIGN nv_41 =  WDETAIL.no_41  
       nv_41 =  WDETAIL.no_41  
       nv_42 =  WDETAIL.no_42  
       nv_43 =  WDETAIL.no_43 
       nv_seat41 = IF integer(wdetail.seat41) = 0 THEN integer(wdetail.seat) ELSE integer(wdetail.seat41).
RUN WGS\WGSOPER(INPUT nv_tariff, /*pass*/ /*a490166 note modi*/
                nv_class,
                nv_key_b,
                nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/
Assign                                                    /*---------fi_41---------*/
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
ASSIGN                                                    /* -------fi_42---------*/
    nv_42var    = " "
    nv_42cod   = "42" 
    nv_42var1  = "     Medical Expense = "
    nv_42var2  = STRING(nv_42) 
    SUBSTRING(nv_42var,1,30)   = nv_42var1 
    SUBSTRING(nv_42var,31,30)  = nv_42var2.
ASSIGN                                                    /*---------fi_43--------------*/
    nv_43var    = " "     /*---------fi_43--------*/
    nv_43prm   = nv_43
    nv_43cod   = "43"
    nv_43var1  = "     Airfrieght = "
    nv_43var2  =  STRING(nv_43)
    SUBSTRING(nv_43var,1,30)   = nv_43var1
    SUBSTRING(nv_43var,31,30)  = nv_43var2.
    RUN WGS\WGSOPER(INPUT nv_tariff,        /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat).             /*  RUN US\USOPER(INPUT nv_tariff,*/
/*------nv_usecod------------*/
ASSIGN nv_usecod  = "USE" + TRIM(wdetail.vehuse)
    nv_usevar1    = "     Vehicle Use = "
    nv_usevar2    =  wdetail.vehuse
    Substring(nv_usevar,1,30)   = nv_usevar1
    Substring(nv_usevar,31,30)  = nv_usevar2.
/*-----nv_engcod-----------------*/
ASSIGN nv_sclass =  wdetail.subclass.
RUN wgs\wgsoeng.
/*-----nv_yrcod----------------------------*/  
ASSIGN nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
    nv_yrvar1  = "     Vehicle Year = "
    nv_yrvar2  =  String(wdetail.caryear)
    nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
    Substr(nv_yrvar,1,30)    = nv_yrvar1
    Substr(nv_yrvar,31,30)   = nv_yrvar2.
/*-----nv_sicod----------------------------*/ 
Assign nv_totsi  = 0      
    nv_sicod     = "SI"
    nv_sivar1    = "     Own Damage = "
    nv_sivar2    =  STRING(wdetail.si)
    SUBSTRING(nv_sivar,1,30)  = nv_sivar1
    SUBSTRING(nv_sivar,31,30) = nv_sivar2
    nv_totsi     =  inte(wdetail.si).
/*----------nv_grpcod--------------------*/
ASSIGN  nv_grpcod      = "GRP" + wdetail.cargrp
    nv_grpvar1     = "     Vehicle Group = "
    nv_grpvar2     = wdetail.cargrp
    Substr(nv_grpvar,1,30)  = nv_grpvar1
    Substr(nv_grpvar,31,30) = nv_grpvar2.
/*-------------nv_bipcod--------------------*/
ASSIGN nv_bipcod      = "BI1"
    nv_bipvar1     = "     BI per Person = "
    nv_bipvar2     = STRING(uwm130.uom1_v)
    SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
    SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
/*-------------nv_biacod--------------------*/
ASSIGN nv_biacod   = "BI2"
    nv_biavar1     = "     BI per Accident = "
    nv_biavar2     = STRING(uwm130.uom2_v)
    SUBSTRING(nv_biavar,1,30)  = nv_biavar1
    SUBSTRING(nv_biavar,31,30) = nv_biavar2.
/*-------------nv_pdacod--------------------*/
IF      (wdetail.covcod = "2.1") THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "21" .
ELSE IF (wdetail.covcod = "2.2") THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "22" .
ELSE IF (wdetail.covcod = "3.1") THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "31" .
ELSE nv_usecod3 = "U" + TRIM(nv_vehuse) + "32" .
    ASSIGN   
        nv_usevar4 = "     Vehicle Use = "
        nv_usevar5 =  wdetail.vehuse
        Substring(nv_usevar3,1,30)   = nv_usevar4
        Substring(nv_usevar3,31,30)  = nv_usevar5.
     ASSIGN  nv_basecod3 = IF      (wdetail.covcod = "2.1") THEN "BA21" 
                           ELSE IF (wdetail.covcod = "2.2") THEN "BA22"  
                           ELSE IF (wdetail.covcod = "3.1") THEN "BA31"
                           ELSE "BA32".
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
                       ELSE IF (wdetail.covcod = "3.1") THEN "SI31" ELSE "SI32"
        nv_sivar4    = "     Own Damage = "
        nv_sivar5    =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2" THEN  
                           string(deci(wdetail.si)) ELSE string(deci(wdetail.si)) 
        wdetail.si   =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2" THEN  
                            wdetail.si ELSE  wdetail.si
        SUBSTRING(nv_sivar3,1,30)  = nv_sivar4
        SUBSTRING(nv_sivar3,31,30) = nv_sivar5 .
        nv_totsi     = IF wdetail.covcod = "2.1"  OR wdetail.covcod = "2.2"  THEN  
                       deci(wdetail.si) ELSE  deci(wdetail.si).
        /*nv_siprm3    = IF wdetail.covcod = "2.1" THEN  deci(wdetail.tpfire) ELSE DECI(wdetail.deductda)  .*/ 
    ASSIGN nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     = STRING(nv_uom5_v)
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
/* caculate deduct OD  */
DEF VAR dod0 AS INTEGER.
/*kridtiya i.A56-0152...
DEF VAR dod1 AS INTEGER.
DEF VAR dod2 AS INTEGER.
DEF VAR dpd0 AS INTEGER. kridtiya i.A56-0152...*/
dod0 = inte(wdetail.deductda).
IF dod0 > 3000 THEN DO:
    dod1 = 3000.
    dod2 = dod0 - dod1.
END.
IF (wdetail.covcod = "2.1")  THEN 
    ASSIGN dod1 = 2000
           dod2 = 0 .  
ASSIGN nv_odcod = "DC01"
    nv_prem     =   dod1.  
RUN Wgs\Wgsmx024( nv_tariff,    
                  nv_odcod,
                  nv_class,
                  nv_key_b,
                  nv_comdat,
                  INPUT-OUTPUT nv_prem,
                  OUTPUT nv_chk ,
                  OUTPUT nv_baseap).
IF NOT nv_chk THEN  
    ASSIGN wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
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
Run  Wgs\Wgsmx025(INPUT  nv_ded, 
                  nv_tariff,
                  nv_class,
                  nv_key_b,
                  nv_comdat,
                  nv_cons,
                  OUTPUT nv_prem).
nv_ded2prm    = nv_prem.
ASSIGN  nv_dedpd_cod   = "DPD"
    nv_dedpdvar1   = "     Deduct PD = "
    nv_dedpdvar2   =  STRING(nv_ded)
    SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
    SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
    nv_dedpd_prm  = nv_prem.
nv_flet_per = INTE(wdetail.fleet).
IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
    Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
    ASSIGN wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
END.
IF nv_flet_per = 0 Then do:
    ASSIGN nv_flet     = 0
        nv_fletvar  = " ".
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
ASSIGN
    nv_fletvar     = " "
    nv_fletvar1    = "     Fleet % = "
    nv_fletvar2    =  STRING(nv_flet_per)
    SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
    SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
IF nv_flet   = 0  THEN
    nv_fletvar  = " ".
DEF VAR nv_ncbyrs AS INTE.
ASSIGN 
NV_NCBPER = INTE(WDETAIL.NCB).
nv_ncbvar = " ".
If nv_ncbper  <> 0 Then do:
    Find first sicsyac.xmm104 Use-index xmm10401 Where
        sicsyac.xmm104.tariff = nv_tariff           AND 
        sicsyac.xmm104.class  = nv_class            AND 
        sicsyac.xmm104.covcod = nv_covcod           AND 
        sicsyac.xmm104.ncbper = INTE(wdetail.ncb) No-lock no-error no-wait.
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
nv_cl_per  = deci(wdetail.loadclm).
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
nv_clmvar    = " ".
IF nv_cl_per  <> 0  THEN
    ASSIGN  nv_clmvar1   = " Load Claim % = "
    nv_clmvar2   =  STRING(nv_cl_per)
    SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
    SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
nv_dsspcvar   = " ".
IF  nv_dss_per   <> 0  THEN
    ASSIGN  nv_dsspcvar1   = "     Discount Special % = "
    nv_dsspcvar2   =  STRING(nv_dss_per)
    SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
    SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    nv_totsi,
                    nv_uom1_v ,       
                    nv_uom2_v ,       
                    nv_uom5_v ).
/*IF nv_gapprm <> inte(wdetail.volprem) /*OR inte(wdetail.Compprem) <> nv_compprm */ THEN  DO:
    MESSAGE "เบี้ยไม่ตรงกับเบี้ยที่คำนวณได้" + wdetail.volprem + " <> " + STRING(nv_gapprm) VIEW-AS ALERT-BOX.
    ASSIGN  WDETAIL.WARNING  = "เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้"
        wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้ "
        wdetail.pass    = "N".
END.*/
IF wdetail.pass <> "N"  THEN 
    ASSIGN wdetail.comment = "COMPLETE"
    WDETAIL.WARNING = ""
    wdetail.pass    = "Y".
FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
    ASSIGN sic_bran.uwm100.prem_t = nv_gapprm
        sic_bran.uwm100.sigr_p = inte(wdetail.si)
        sic_bran.uwm100.gap_p  = nv_gapprm.
    IF wdetail.pass <> "Y" THEN DO:
        ASSIGN  sic_bran.uwm100.impflg = NO
            sic_bran.uwm100.imperr = wdetail.comment.      
    END.
END.
FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN DO:
    ASSIGN sic_bran.uwm120.gap_r  = nv_gapprm
        sic_bran.uwm120.prem_r    = nv_pdprm
        sic_bran.uwm120.sigr      = inte(wdetail.si).
END.
FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN DO:
    ASSIGN  sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs
        sic_bran.uwm301.mv41seat = wdetail.seat41.
END.
IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR
   (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" ) THEN      /*A57-0126 add WGSTP132*/
    RUN WGS\WGSTP132(INPUT S_RECID3,   /*A57-0126 add WGSTP132*/
                     INPUT S_RECID4).  /*A57-0126 add WGSTP132*/ 
ELSE 
    RUN WGS\WGSTN132(INPUT S_RECID3,  
                 INPUT S_RECID4).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_checkdata04 C-Win 
PROCEDURE proc_checkdata04 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Def  var   n_sigr_r     like sic_bran.uwm130.uom6_v.
Def  var   n_gap_r      Like sic_bran.uwd132.gap_c . 
Def  var   n_prem_r     Like sic_bran.uwd132.prem_c.
Def  var   nt_compprm   like sic_bran.uwd132.prem_c.  
Def  var   n_gap_t      Like sic_bran.uwm100.gap_p.
Def  var   n_prem_t     Like sic_bran.uwm100.prem_t.
Def  var   n_sigr_t     Like sic_bran.uwm100.sigr_p.
def  var   nv_policy    like sic_bran.uwm100.policy.
def  var   nv_rencnt    like sic_bran.uwm100.rencnt.
def  var   nv_endcnt    like sic_bran.uwm100.endcnt.
def  var   nv_com1_per  like sicsyac.xmm031.comm1.
def  var   nv_stamp_per like sicsyac.xmm020.rvstam.
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
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
If  not avail sic_bran.uwm100  Then do:
    Message "not found (uwm100./wuwrep02.p)" View-as alert-box.
    Return.
END.
Else  do:
    ASSIGN nv_policy  =  CAPS(sic_bran.uwm100.policy)
        nv_rencnt  =  sic_bran.uwm100.rencnt
        nv_endcnt  =  sic_bran.uwm100.endcnt.
    FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
        sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
        sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
        sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
        sic_bran.uwm120.bchyr   = nv_batchyr              AND 
        sic_bran.uwm120.bchno   = nv_batchno              AND 
        sic_bran.uwm120.bchcnt  = nv_batcnt               NO-LOCK.
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
            END.
        END.
        ASSIGN n_gap_t      = n_gap_t   + n_gap_r
            n_prem_t     = n_prem_t  + n_prem_r
            n_sigr_t     = n_sigr_t  + n_sigr_r
            n_gap_r      = 0 
            n_prem_r     = 0  
            n_sigr_r     = 0.
    END.     /* end uwm120 */
END.         /*  avail  100   */
Find LAST  sic_bran.uwm120  Use-index uwm12001  WHERE          /***--- a490166 change first to last ---***/
    sic_bran.uwm120.policy  = sic_bran.uwm100.policy  And
    sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  And
    sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND 
    sic_bran.uwm120.bchyr   = nv_batchyr              AND 
    sic_bran.uwm120.bchno   = nv_batchno              AND 
    sic_bran.uwm120.bchcnt  = nv_batcnt               No-error.
FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
    sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
    substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
    SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
    sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
IF AVAIL   sicsyac.xmm018 THEN DO:
    Assign     nv_com1p = sicsyac.xmm018.commsp  
               nv_com2p = 0.
END.  /* Avail Xmm018 */
ELSE DO:
    Find sicsyac.xmm031  Use-index xmm03101  Where  
        sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp  No-lock no-error no-wait.
    IF not  avail sicsyac.xmm031 Then 
        Assign     nv_com1p = 0
                   nv_com2p = 0.
    Else  
        Assign     nv_com1p = sicsyac.xmm031.comm1
            nv_com2p = 0 .
                     /*nv_com2p = sicsyac.xmm031.comm2.*//*A490206*/
END.    /* Not Avail Xmm018 */
IF wdetail.compul = "y" THEN DO:
    FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
        sicsyac.xmm018.agent              = sic_bran.uwm100.acno1  AND               /*แยกงานตาม Code Producer*/   
        substr(sicsyac.xmm018.poltyp,1,5) = "CRV72"                AND               /*Shukiat T. modi on 25/04/2007*/
        SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
        sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
    IF AVAIL   sicsyac.xmm018 THEN DO:
        nv_com2p = sicsyac.xmm018.commsp.
    END.
    ELSE DO:
        Find  sicsyac.xmm031  Use-index xmm03101  Where  
            sicsyac.xmm031.poltyp    = "v72" No-lock no-error no-wait.
        nv_com2p = sicsyac.xmm031.comm1.   /***--- Shukiat T. 26/01/2007 ---***/
    END.
END.   /* Wdetail.Compul = "Y"*/
Find sicsyac.xmm020 Use-index xmm02001        Where
    sicsyac.xmm020.branch = sic_bran.uwm100.branch   And
    sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri   No-lock no-error.
IF avail sicsyac.xmm020 Then do:
    nv_fi_stamp_per      = sicsyac.xmm020.rvstam.
    If    sic_bran.uwm100.gstrat  <>  0  Then  nv_fi_tax_per  =  sic_bran.uwm100.gstrat.
    Else  nv_fi_tax_per  =  sicsyac.xmm020.rvtax.
END.
/*----------- stamp ------------*/
IF sic_bran.uwm120.stmpae  = Yes Then do:                        /* STAMP */
    nv_fi_rstp_t  = Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) +
                    (IF     (sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100)   -
                     Truncate(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) > 0
                     Then 1 Else 0).
END. 
sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
    nv_fi_rtax_t  = (sic_bran.uwm100.prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                     * nv_fi_tax_per  / 100.
END.
sic_bran.uwm100.rtax_t = nv_fi_rtax_t.
sic_bran.uwm120.com1ae = YES.
sic_bran.uwm120.com2ae = YES.
IF sic_bran.uwm120.com1ae   = Yes  Then do:                   
    If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
    nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.  
END.
/*----------- comp comission ------------*/
IF  sic_bran.uwm120.com2ae   = Yes  Then do:                    
    If sic_bran.uwm120.com2p <> 0  Then nv_com2p  = sic_bran.uwm120.com2p.
    nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.               
END.
IF sic_bran.uwm100.pstp <> 0 Then do:
    IF sic_bran.uwm100.no_sch  = 1 Then NV_fi_dup_trip = "D".
    Else If sic_bran.uwm100.no_sch  = 2 Then  NV_fi_dup_trip = "T".
END.
Else  NV_fi_dup_trip  =  "".
nv_fi_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t
               + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.
Find     sic_bran.uwm100 Where  Recid(sic_bran.uwm100)  =  s_recid1.
If avail sic_bran.uwm100 Then do:
    Assign  sic_bran.uwm100.gap_p  = n_gap_t
        sic_bran.uwm100.prem_t  = n_prem_t
        sic_bran.uwm100.sigr_p  = n_sigr_t
        sic_bran.uwm100.instot  = uwm100.instot
        sic_bran.uwm100.com1_t  =  nv_fi_com1_t
        sic_bran.uwm100.com2_t  =  nv_fi_com2_t
        sic_bran.uwm100.pstp    =  0               /*note modified on 25/10/2006*/
        sic_bran.uwm100.rstp_t  =  nv_fi_rstp_t
        sic_bran.uwm100.rtax_t  =  nv_fi_rtax_t
        sic_bran.uwm100.gstrat  =  nv_fi_tax_per.
END.
IF wdetail.poltyp = "v72" THEN DO:
    ASSIGN  
        sic_bran.uwm100.com2_t  = 0 
        sic_bran.uwm100.com1_t  = nv_fi_com2_t.
END.
Find     sic_bran.uwm120 Where  Recid(sic_bran.uwm120)   =  s_recid2   .
IF avail sic_bran.uwm120 Then do:
    ASSIGN sic_bran.uwm120.gap_r = n_gap_t      /*n_gap_r */
        sic_bran.uwm120.prem_r   = n_prem_t     /*n_prem_r */
        sic_bran.uwm120.sigr     = n_sigr_T     /* A490166 note modi from n_sigr_r to n_sigr_t 11/10/2006 */
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
    IF wdetail.poltyp = "v72" THEN DO:
        ASSIGN  sic_bran.uwm120.com2_r = 0 
            sic_bran.uwm120.com1_r     = nv_fi_com2_t
            sic_bran.uwm120.com1p      = nv_com2p
            sic_bran.uwm120.com2p      = 0.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcode C-Win 
PROCEDURE proc_chkcode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 /* Add by : A64-0138 */ 
  nv_chkerror = "".
    RUN wgw\wgwchkagpd  (INPUT fi_agent ,           
                         INPUT fi_producer ,  
                         INPUT-OUTPUT nv_chkerror).
    IF nv_chkerror <> "" THEN DO:
        MESSAGE "Error Code Producer/Agent :" nv_chkerror  SKIP
        wdetail.producer SKIP
        wdetail.agent  VIEW-AS ALERT-BOX. 
        ASSIGN wdetail.comment = wdetail.comment + nv_chkerror 
               wdetail.pass    = "N" 
               wdetail.OK_GEN  = "N".
    END.
 
/* IF wdetail.n_delercode <> "" THEN DO:
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
 END.*/
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
  /* end : A64-0138 */ 

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
                /*note add vehreg*/
                IF wdetail.vehreg = " " AND wdetail.renpol = " " THEN DO: 
                    Message " Vehicle Register is mandatory field. "  View-as alert-box.
                    ASSIGN
                    wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
                    wdetail.pass    = "N"  /*a490166*/
                    WDETAIL.OK_GEN  = "N".
                    /*NEXT.*//*a490166*/
                END.
                ELSE DO:
                    IF wdetail.renpol = " " THEN DO: /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
                        Def  var  nv_vehreg  as char  init  " ".
                        Def  var  s_polno       like sicuw.uwm100.policy   init " ".
                        
                        Find LAST sicuw.uwm301 Use-index uwm30102 Where  
                                  sicuw.uwm301.vehreg = wdetail.vehreg
                        No-lock no-error no-wait.
                        IF AVAIL sicuw.uwm301 THEN DO:
                        If  sicuw.uwm301.policy =  wdetail.policy     and          
                            sicuw.uwm301.endcnt = 1  and
                            sicuw.uwm301.rencnt = 1  and
                            sicuw.uwm301.riskno = 1  and
                            sicuw.uwm301.itemno = 1  Then  Leave.
                                Find first sicuw.uwm100 Use-index uwm10001     Where
                                           sicuw.uwm100.policy = sicuw.uwm301.policy    and
                                           sicuw.uwm100.rencnt = sicuw.uwm301.rencnt    and                         
                                           sicuw.uwm100.endcnt = sicuw.uwm301.endcnt  and
                                           sicuw.uwm100.expdat > date(wdetail.comdat)
                                           No-lock no-error no-wait.
                                If avail sicuw.uwm100 Then do:
                                    s_polno     =   sicuw.uwm100.policy.
                                    /***--- Shukiat T. Modi On 26/10/2006 ---***/
                                    MESSAGE "Vehicle Reg. already insured under policy" s_polno VIEW-AS ALERT-BOX.
                                    ASSIGN
                                    wdetail.pass    = "N" /*a490166*/    
                                    wdetail.comment = wdetail.comment + "| Vehicle Reg. already insured under policy" 
                                    WDETAIL.OK_GEN  = "N".
                                    /***----
                                    Message "WARNING: Reg. already insured under policy" s_polno 
                                            "Accept ?"  View-as alert-box Question Buttons YES-NO
                                            Update choice101 As Logical.
                                            Case choice101:
                                            When True  Then do:
                                                  ASSIGN
                                                  wdetail.pass    = "N" /*a490166*/
                                                  wdetail.comment = wdetail.comment + "| Vehicle Register is Repeat "  .
                                            End.
                                            When False Then do:
                                                  MESSAGE "Entry New Vehreg " UPDATE wdetail.vehreg . 
                                                  ASSIGN                               
                                                  wdetail.pass    = "N" /*a490166*/
                                                  wdetail.comment = wdetail.comment + "| Edit Vehicle Register in Process"  .
                                            End.
                                            End Case.       
                                    ---***//*End Shukiat T. Modi*/
                               End.  /* avail uwm100  */
                        END.  /*avil 301*/
                    END. /*จบการ Check ทะเบียนรถ*/
                END. /*note end else*/
                /*end note vehreg*/

                IF wdetail.cancel = "ca"  THEN  DO:
                    MESSAGE "cancel".
                    ASSIGN
                    wdetail.pass    = "N" /*a490166*/    
                    wdetail.comment = wdetail.comment + "| cancel"
                    WDETAIL.OK_GEN  = "N".
                    /*NEXT.*//*a490166*/
                END.     
                IF wdetail.insnam = " " THEN DO:
                    MESSAGE "ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน". 
                    ASSIGN
                    wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
                    wdetail.pass    = "N" /*a490166*/    
                    WDETAIL.OK_GEN  = "N".
                    /*NEXT.*//*a490166*/
                END.    
                IF wdetail.drivnam = "y" AND wdetail.drivnam1 =  " "   THEN DO :
                    MESSAGE "มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ" VIEW-AS ALERT-BOX .
                    ASSIGN
                    wdetail.comment = wdetail.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
                    wdetail.pass    = "N" /*a490166*/    
                    WDETAIL.OK_GEN  = "N".
                    /*NEXT.*//*a490166*/
                END.
                /*-----------------------*/
                 IF wdetail.prempa = " " THEN DO:
                    MESSAGE "prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil".
                    ASSIGN
                    wdetail.comment = wdetail.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
                    wdetail.pass    = "N" /*a490166*/    
                    WDETAIL.OK_GEN  = "N".
                    /*NEXT.*//*a490166*/
                END. /*can't block in use*/
                IF wdetail.subclass = " " THEN DO:
                    ASSIGN
                    wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
                    wdetail.pass    = "N" /*a490166*/    
                    WDETAIL.OK_GEN  = "N".
                    /*NEXT.*//*a490166*/
                END. /*can't block in use*/ 
                IF wdetail.brand = " " THEN DO:
                    MESSAGE "Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil".
                    ASSIGN
                    wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
                    wdetail.pass    = "N" /*a490166*/        
                    WDETAIL.OK_GEN  = "N".
                    /*NEXT.*//*a490166*/
                END. /*3note block*/
                IF wdetail.model = " " THEN DO:
                    MESSAGE "model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil".
                    ASSIGN
                    wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
                    wdetail.pass    = "N" /*a490166*/    
                    WDETAIL.OK_GEN  = "N".
                    /*NEXT.*//*a490166*/
                END. /*4note block*/
                IF wdetail.cc    = " " THEN DO:
                    MESSAGE "Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil".
                    ASSIGN
                    wdetail.comment = wdetail.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
                    wdetail.pass    = "N" /*a490166*/    
                    WDETAIL.OK_GEN  = "N".
                    /*NEXT.*//*a490166*/
                END. /*5note block*/
                IF wdetail.seat  = " " THEN DO:
                    MESSAGE "seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil".
                    ASSIGN
                    wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
                    wdetail.pass    = "N" /*a490166*/    
                    WDETAIL.OK_GEN  = "N".
                    /*NEXT.*//*a490166*/
                END. /*6note block*/
                IF wdetail.caryear = " " THEN DO:
                    MESSAGE "year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil".
                    ASSIGN
                    wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
                    wdetail.pass    = "N" /*a490166*/    
                    WDETAIL.OK_GEN  = "N".
                    /*NEXT.*//*a490166*/
                END. /*7note block*/
                /*-----------------------*/
                ASSIGN
                nv_maxsi = 0
                nv_minsi = 0
                nv_si    = 0
                nv_maxdes = ""
                nv_mindes = "".

                chkred = NO.
                IF wdetail.redbook <> "" THEN DO:
                            FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                                 WHERE stat.maktab_fil.sclass = wdetail.subclass   AND   
                                       stat.maktab_fil.modcod = wdetail.redbook 
                            No-lock no-error no-wait.
                            If  avail stat.maktab_fil  Then do:
                                     Assign
                                         nv_modcod        =  stat.maktab_fil.modcod                                    
                                         nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                                         wdetail.cargrp   =  stat.maktab_fil.prmpac
                                         chkred           =  YES    /*note chk found redbook*/
                                         /***--- Shukiat T. Add on  26/10/2006 ---***/
                                         wdetail.brand    =  stat.maktab_fil.makdes
                                         wdetail.model    =  stat.maktab_fil.moddes
                                         wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
                                         wdetail.cc       =  STRING(stat.maktab_fil.engine)
                                         wdetail.subclass =  stat.maktab_fil.sclass
                                         /*wdetail.si     =  STRING(stat.maktab_fil.si)  *//*08/12/2006 Shukiat T.*/
                                         wdetail.redbook  =  stat.maktab_fil.modcod                                    
                                         wdetail.seat     =  STRING(stat.maktab_fil.seats)
                                         nv_si = maktab_fil.si.
                                    /***--- Check Rate SI ---***/
                                    /***--- A490166 Shukiat T. Add on 08/12/2006 ---***/
                                    IF wdetail.covcod = "1"  THEN DO:
                                        FIND FIRST stat.makdes31 WHERE 
                                                   stat.makdes31.makdes = "X" AND  /*Lock X*/
                                                   stat.makdes31.moddes = wdetail.prempa + wdetail.subclass
                                        NO-LOCK NO-ERROR NO-WAIT.
                                        IF AVAILABLE makdes31 THEN DO:
                                            ASSIGN
                                            nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                                            nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                                            nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                                            nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
                                        END.
                                        ELSE DO:
                                            ASSIGN
                                                nv_maxSI = nv_si
                                                nv_minSI = nv_si.
                                        END.
                                
                                        IF deci(wdetail.si) > nv_maxSI OR deci(wdetail.si) < nv_minSI THEN DO:
                                            IF nv_maxSI = nv_minSI THEN DO:
                                                    IF nv_maxSI = 0 AND nv_minSI = 0 THEN do:

                                                        MESSAGE "Not Found Sum Insure in maktab_fil (Class:"
                                                                + wdetail.prempa + wdetail.subclass + "   Make/Model:" + wdetail.redbook + " "
                                                                + wdetail.brand + " " + wdetail.model + "   Year:" + STRING(wdetail.caryear) + ")" .
                                                        ASSIGN
                                                        wdetail.comment = "Not Found Sum Insure in maktab_fil (Class:"
                                                                        + wdetail.prempa + wdetail.subclass + "   Make/Model:" + wdetail.redbook + " "
                                                                        + wdetail.brand + " " + wdetail.model + "   Year:" + STRING(wdetail.caryear) + ")"
                                                        wdetail.pass    = "N" /*a490166*/    
                                                        WDETAIL.OK_GEN  = "N".
                                                    end.
                                                    ELSE
                                                        MESSAGE         "Not Found Sum Insured Rates Maintenance in makdes31 (Tariff: X"
                                                                        + "  Class:" + wdetail.prempa + wdetail.subclass + ")" .
                                                        ASSIGN
                                                        wdetail.comment = "Not Found Sum Insured Rates Maintenance in makdes31 (Tariff: X"
                                                                        + "  Class:" + wdetail.prempa + wdetail.subclass + ")"
                                                        wdetail.pass    = "N" /*a490166*/    
                                                        WDETAIL.OK_GEN  = "N".
                                            END.
                                            ELSE
                                                MESSAGE  "Sum Insure must " + nv_mindes + " and " + nv_maxdes
                                                                + " of " + TRIM(STRING(nv_si,">>>,>>>,>>9"))
                                                                + " (" + TRIM(STRING(nv_minSI,">>>,>>>,>>9"))
                                                                + " - " + TRIM(STRING(nv_maxSI,">>>,>>>,>>9")) + ")" .
                                                ASSIGN
                                                wdetail.comment = "Sum Insure must " + nv_mindes + " and " + nv_maxdes
                                                                + " of " + TRIM(STRING(nv_si,">>>,>>>,>>9"))
                                                                + " (" + TRIM(STRING(nv_minSI,">>>,>>>,>>9"))
                                                                + " - " + TRIM(STRING(nv_maxSI,">>>,>>>,>>9")) + ")"
                                                wdetail.pass    = "N" /*a490166*/    
                                                WDETAIL.OK_GEN  = "N".

                                        END.
                                    END.
                                    /***--- End Check Rate SI ---***/
                            End.          
                            ELSE nv_modcod = " ".
                END. /*red book <> ""*/   
                IF nv_modcod = "" THEN DO:
                            Find First stat.maktab_fil Use-index      maktab04          Where
                                       stat.maktab_fil.makdes   =     wdetail.brand               And                  
                                       stat.maktab_fil.moddes   =     wdetail.model               And
                                       stat.maktab_fil.makyea   =     Integer(wdetail.caryear)    AND
                                       stat.maktab_fil.engine   =     Integer(wdetail.cc)         AND
                                       stat.maktab_fil.sclass   =     wdetail.subclass            AND
                                       stat.maktab_fil.si       =     INTEGER(wdetail.si)         AND
                                       stat.maktab_fil.seats    =     inte(wdetail.seat)          
                            No-lock no-error no-wait.
                            If  avail stat.maktab_fil  Then do:
                                     Assign
                                         nv_modcod      =  stat.maktab_fil.modcod                                    
                                         nv_moddes      =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                                         wdetail.cargrp =  stat.maktab_fil.prmpac
                                         wdetail.redbook  =  stat.maktab_fil.modcod                                    .
                              End.
                              IF nv_modcod = ""  THEN DO:
                                  MESSAGE "NOT FIND MODEL CODE IN  MAKTAB_FIL".
                                  ASSIGN
                                  WDETAIL.COMMENT = wdetail.comment + "| NOT FIND MODEL CODE IN  MAKTAB_FIL"
                                  WDETAIL.OK_GEN  = "N"
                                  wdetail.pass    = "N". /*a490166*/    
                                  /*/*NEXT.*//*a490166*/*/              /*a490166*/
                              END.
                END. /*nv_modcod = blank*/
               /*end note add &  modi*/
    ASSIGN                  
    NO_CLASS  = wdetail.prempa + wdetail.subclass
    nv_poltyp = wdetail.poltyp.
    If no_class  <>  " " Then do:
     FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
                 sicsyac.xmd031.poltyp =   nv_poltyp AND
                 sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
       IF NOT AVAILABLE sicsyac.xmd031 THEN DO:
              MESSAGE   "Not on Business Classes Permitted per Policy Type file xmd031"  
                         sicuw.uwm100.poltyp   no_class  View-as alert-box.
              ASSIGN
                wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
                wdetail.pass    = "N" /*a490166*/    
                WDETAIL.OK_GEN  = "N".
              /*NEXT.*//*a490166*/               
      END.
      FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
           sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
      IF NOT AVAILABLE sicsyac.xmm016 THEN DO:
                                MESSAGE  "Not on Business Classes on xmm016"  no_class.
                                ASSIGN
                                    wdetail.comment = wdetail.comment + "| Not on Business class on xmm016"
                                    wdetail.pass    = "N" /*a490166*/    
                                    WDETAIL.OK_GEN  = "N".
                                /*NEXT.*//*a490166*/                  
                        END.
        ELSE DO:  
        ASSIGN    
              wdetail.tariff =   sicsyac.xmm016.tardef
              no_class       =   sicsyac.xmm016.class
              nv_sclass      =   Substr(no_class,2,3).
        END.
    END.
    Find sicsyac.sym100 Use-index sym10001       Where
         sicsyac.sym100.tabcod = "u014"          AND 
         sicsyac.sym100.itmcod =  wdetail.vehuse No-lock no-error no-wait.
     IF not avail sicsyac.sym100 Then do:
         Message " Not on Vehicle Usage Codes table sym100 u014. " View-as alert-box.
         ASSIGN
         wdetail.comment = wdetail.comment + "| Not on Vehicle Usage Codes table sym100 u014"
         wdetail.pass    = "N" /*a490166*/    
         WDETAIL.OK_GEN  = "N".
         /*NEXT.*//*a490166*/        
     End.
     Find  sicsyac.sym100 Use-index sym10001  Where
           sicsyac.sym100.tabcod = "u013"         And
           sicsyac.sym100.itmcod = wdetail.covcod
    No-lock no-error no-wait.
    IF not avail sicsyac.sym100 Then do:
       Message " Not on Motor Cover Type Codes table sym100 u013. " View-as alert-box.
       ASSIGN
       wdetail.comment = wdetail.comment + "| Not on Motor Cover Type Codes table sym100 u013"
       wdetail.pass    = "N" /*a490166*/    
       WDETAIL.OK_GEN  = "N".
       /*NEXT.*//*a490166*/       
   End.
   /*---------- fleet -------------------*/
       IF inte(wdetail.fleet) <> 0 AND INTE(wdetail.fleet) <> 10 Then do:
              Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
              ASSIGN
                wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. "
                wdetail.pass    = "N" /*a490166*/    
                WDETAIL.OK_GEN  = "N".
              /*NEXT.*//*a490166*/
              End.
   /*----------  access -------------------*/
              If  wdetail.access  =  "y"  Then do:
         If  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
             nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
         Then  wdetail.access  =  "y".         
         Else do:
             Message "Class "  nv_sclass "ไม่รับอุปกรณ์เพิ่มพิเศษ"  View-as alert-box.
             ASSIGN
                wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ"
                wdetail.pass    = "N" /*a490166*/    
                WDETAIL.OK_GEN  = "N".
             /*NEXT.*//*a490166*/
         End.
              END.
   /*----------  ncb -------------------*/
   
              IF (wdetail.ncb = "0")  OR (wdetail.ncb = "20") OR
                 (wdetail.ncb = "30") OR (wdetail.ncb = "40") OR
                 (wdetail.ncb = "50")   THEN DO:
              END.
              ELSE DO:
                  MESSAGE "not on NCB Rates file xmm104. " View-as alert-box.
                  ASSIGN
                  wdetail.comment = wdetail.comment + "| not on NCB Rates file xmm104."
                  wdetail.pass    = "N" /*a490166*/    
                  WDETAIL.OK_GEN  = "N".
                  /*NEXT.*//*a490166*/
              END.
              
              NV_NCBPER = INTE(WDETAIL.NCB).
              
     If nv_ncbper  <> 0 Then do:
           Find first sicsyac.xmm104 Use-index xmm10401 Where
                      sicsyac.xmm104.tariff = wdetail.tariff                      AND
                      sicsyac.xmm104.class  = wdetail.prempa + wdetail.subclass               AND
                      sicsyac.xmm104.covcod = wdetail.covcod           AND
                      sicsyac.xmm104.ncbper = INTE(wdetail.ncb)
            No-lock no-error no-wait.
            IF not avail  sicsyac.xmm104  Then do:
                   Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                   ASSIGN
                        wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
                        wdetail.pass    = "N" /*a490166*/    
                        WDETAIL.OK_GEN  = "N".
                   /*NEXT.*//*a490166*/
           End.
     END. /*ncb <> 0*/
      /******* drivernam **********/
   nv_sclass = wdetail.SUBclass. 
   If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then do:
          Message  "THIS CLASS CODE Driver 's Name must be no. " View-as alert-box.
          ASSIGN
          wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
          wdetail.pass    = "N" /*a490166*/    
          WDETAIL.OK_GEN  = "N".
          /*NEXT.*//*a490166*/
   End.
      /*------------- compul --------------*/
       IF wdetail.compul = "y" THEN DO:
           IF wdetail.stk = " " THEN DO:
               MESSAGE "ซื้อ พรบ ต้องมีหมายเลข Sticker".
               ASSIGN
               wdetail.comment = wdetail.comment + "| ซื้อ พรบ ต้องมีหมายเลข Sticker"
               wdetail.pass    = "N" /*a490166*/    
               WDETAIL.OK_GEN  = "N".
               /*NEXT.*//*a490166*/
           END.
           /***--- A50-0204 Shukiat T. Add ---***/
           /*amparat C. A51-0253--
           IF LENGTH(wdetail.stk) = 10  THEN wdetail.stk = "0" + wdetail.stk.
           IF LENGTH(wdetail.stk) <> 11 THEN DO:
               IF LENGTH(wdetail.stk) <> 9 THEN DO:
                       MESSAGE "เลข Sticker ต้องเป็น 9 หรือ 11 หลักเท่านั้น" VIEW-AS ALERT-BOX.
                       ASSIGN /*a490166*/
                       wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 9 หรือ 11 หลักเท่านั้น"
                       wdetail.pass    = ""
                       WDETAIL.OK_GEN  = "N".
               END.
           END.
           /***--- End A50-0204 Shukiat T. ---***/
           --amparat C. A51-0253--*/
           /*STR amparat C. A51-0253--*/
             IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
             IF LENGTH(wdetail.stk) < 11 OR LENGTH(wdetail.stk) > 13 THEN DO:
                MESSAGE "เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น" VIEW-AS ALERT-BOX.
                ASSIGN /*a490166*/
                   wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
                   wdetail.pass    = ""
                   WDETAIL.OK_GEN  = "N".
             END.
           /*END amparat C. A51-0253--*/
       END.
/***************************/
    

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
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail:
    RUN proc_chkcode. /* A64-0138*/
    /*------------------  renew ---------------------*/
    IF wdetail.renpol <> " " THEN DO:
        RUN proc_renew.
        /***--- Shukiat T. ---***/
        RUN proc_chktest0.
        RUN proc_policy . /*ใช้ร่วมกัน 70/72*/  
        RUN PROC_INSURE.                        
        RUN proc_chktest2.                      
        RUN proc_chktest3.                      
        RUN proc_chktest4.                      
    END.
    ELSE DO:
        IF wdetail.poltyp = "v72"  THEN DO:
            RUN proc_72.
        /***--- A490166 ข้อมูลไม่ถูกต้องก็นำเข้า 28/09/2006
            IF  WDETAIL.OK_GEN = "N" THEN
            NEXT.                       
            ---***/
            /*RUN proc_721.*//*a490166 ใช้ร่วมกัน 70 & 72*/
            RUN proc_policy. /*a490166 ใช้ร่วมกัน 70 & 72*/
            /***--- A490166 ข้อมูลไม่ถูกต้องก็นำเข้า 28/09/2006
            IF  WDETAIL.OK_GEN = "N" THEN
            NEXT.                       
            ---***/
            RUN PROC_INSURE.
            RUN proc_722.
            RUN proc_723 (INPUT  s_recid1,       
                          INPUT  s_recid2,
                          INPUT  s_recid3,
                          INPUT  s_recid4,
                          INPUT-OUTPUT nv_message).
            /*wdetail.pass = "y".*//*a490166*/
            NEXT.
        END.
        ELSE DO:
            RUN proc_chktest0.
        END.

        /***--- A490166 ข้อมูลไม่ถูกต้องก็นำเข้า 28/09/2006
        IF  WDETAIL.OK_GEN = "N" THEN
        NEXT.                            
        ---***/
        /*a490166*/
        RUN proc_policy . /*ใช้ร่วมกัน 70/72*/
        RUN PROC_INSURE.
        RUN proc_chktest2.      
        RUN proc_chktest3.      
        RUN proc_chktest4.      
    END.    
END. /*for each*/
      
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
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
           sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
           sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
           sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
           sic_bran.uwm130.riskgp = s_riskgp               AND            /*0*/
           sic_bran.uwm130.riskno = s_riskno               AND            /*1*/
           sic_bran.uwm130.itemno = s_itemno               AND            /*1*/
           sic_bran.uwm130.bchyr = nv_batchyr              AND 
           sic_bran.uwm130.bchno = nv_batchno              AND 
           sic_bran.uwm130.bchcnt  = nv_batcnt             NO-WAIT NO-ERROR.
  IF NOT AVAILABLE uwm130 THEN 
     DO TRANSACTION:
        CREATE sic_bran.uwm130.
        ASSIGN
          sic_bran.uwm130.policy = sic_bran.uwm120.policy
          sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
          sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
          sic_bran.uwm130.itemno = s_itemno.
     
        ASSIGN /*a490166*/
            sic_bran.uwm130.bchyr = nv_batchyr      /* batch Year */
            sic_bran.uwm130.bchno = nv_batchno      /* bchno    */
            sic_bran.uwm130.bchcnt  = nv_batcnt .   /* bchcnt     */

      IF wdetail.access = "y" THEN DO:
            nv_uom6_u =  "A".
      END.
      ELSE DO:
        ASSIGN             
          nv_uom6_u = ""
          nv_othcod     = ""
          nv_othvar1    = ""
          nv_othvar2    = ""
          SUBSTRING(nv_othvar,1,30)  = nv_othvar1
          SUBSTRING(nv_othvar,31,30) = nv_othvar2.
      END.
      nv_sclass = wdetail.subclass.
      IF nv_uom6_u  =  "A"  THEN DO:
         IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
              nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
         Then  nv_uom6_u  =  "A".         
         Else do:
             Message "Class "  nv_sclass "ไม่รับอุปกรณ์เพิ่มพิเศษ"  View-as alert-box.
             ASSIGN
             wdetail.pass    = "N"
             wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
         END.
      END.     
     IF CAPS(nv_uom6_u) = "A"  Then
          Assign  nv_uom6_u                  = "A"
                  nv_othcod                  = "OTH"
                  nv_othvar1                 = "     Accessory  = "
                  nv_othvar2                 =  STRING(nv_uom6_u)
                  SUBSTRING(nv_othvar,1,30)  = nv_othvar1
                  SUBSTRING(nv_othvar,31,30) = nv_othvar2.
     ELSE
          ASSIGN  nv_uom6_u                  = ""
                  nv_othcod                  = ""
                  nv_othvar1                 = ""
                  nv_othvar2                 = ""
                  SUBSTRING(nv_othvar,1,30)  = nv_othvar1
                  SUBSTRING(nv_othvar,31,30) = nv_othvar2.
      /*--------------------------------------------*/
      IF wdetail.covcod = "1"  THEN DO:
      ASSIGN
              sic_bran.uwm130.uom6_v   = inte(wdetail.si)
              sic_bran.uwm130.uom7_v   = inte(wdetail.si)
              sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
              sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
              sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
              sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
              sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
      END.
      IF wdetail.covcod = "2"  THEN DO:
      ASSIGN
         sic_bran.uwm130.uom6_v   = 0
         sic_bran.uwm130.uom7_v   = inte(wdetail.si)
         sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
         sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
         sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
         sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
         sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
      END.
      IF wdetail.covcod = "3"  THEN DO:
      ASSIGN
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
      END.
      FIND FIRST stat.clastab_fil Use-index clastab01 Where
                 stat.clastab_fil.class   = wdetail.prempa + wdetail.subclass    And
                 stat.clastab_fil.covcod  = wdetail.covcod No-lock  No-error No-wait.
        IF avail stat.clastab_fil Then do:                            
            Assign 
            sic_bran.uwm130.uom1_v     =  stat.clastab_fil.uom1_si
            sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si
            sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            wdetail.comper             =  stat.clastab_fil.uom8_si                
            wdetail.comacc             =  stat.clastab_fil.uom9_si
            nv_uom1_v                  =  sic_bran.uwm130.uom1_v   
            nv_uom2_v                  =  sic_bran.uwm130.uom2_v
            nv_uom5_v                  =  sic_bran.uwm130.uom5_v        .
            ASSIGN
              sic_bran.uwm130.uom1_c  = "D1"
              sic_bran.uwm130.uom2_c  = "D2"
              sic_bran.uwm130.uom5_c  = "D5"
              sic_bran.uwm130.uom6_c  = "D6"
              sic_bran.uwm130.uom7_c  = "D7".
            If  wdetail.garage  =  ""  Then
                Assign WDETAIL.no_41   =   stat.clastab_fil.si_41unp
                       WDETAIL.no_42   =   stat.clastab_fil.si_42
                       WDETAIL.no_43   =   stat.clastab_fil.si_43
                       WDETAIL.seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
            Else If  wdetail.garage  =  "G"  Then
                Assign WDETAIL.no_41    =  stat.clastab_fil.si_41pai
                       WDETAIL.no_42    =  stat.clastab_fil.si_42
                       WDETAIL.no_43    =  stat.clastab_fil.impsi_43
                       WDETAIL.seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.                
        END.           
        ASSIGN
        nv_riskno = 1
        nv_itemno = 1.
        IF wdetail.covcod = "1" Then do:
        RUN wgs/wgschsum(INPUT  wdetail.policy, /*a490166 Note Modi*/
                                nv_riskno,
                                nv_itemno).
        END.
END. /*transaction*/
 s_recid3  = RECID(sic_bran.uwm130).
 /* ---------  U W M 3 0 1 --------------*/ 
 nv_covcod =   wdetail.covcod.
 nv_makdes  =  wdetail.brand.
 nv_moddes  =  wdetail.model.
/*--STR Amparat c.A51-0253--*/
nv_newsck = " ".
IF SUBSTRING(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
ELSE nv_newsck =  wdetail.stk.
/*--STR Amparat c.A51-0253--*/
 FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
      sic_bran.uwm301.policy = sic_bran.uwm100.policy          AND
      sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt          AND
      sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt          AND
      sic_bran.uwm301.riskgp = s_riskgp                        AND
      sic_bran.uwm301.riskno = s_riskno                        AND
      sic_bran.uwm301.itemno = s_itemno                        AND
      sic_bran.uwm301.bchyr = nv_batchyr                     AND 
      sic_bran.uwm301.bchno = nv_batchno                     AND 
      sic_bran.uwm301.bchcnt  = nv_batcnt                     
 NO-WAIT NO-ERROR.
 IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
     DO TRANSACTION:
         CREATE sic_bran.uwm301.
     END. /*transaction*/
 END.                                                          
 ASSIGN
   sic_bran.uwm301.policy    = sic_bran.uwm120.policy                 
   sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
   sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
   sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
   sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
   sic_bran.uwm301.itemno    = s_itemno
   sic_bran.uwm301.tariff    = "X"
   sic_bran.uwm301.covcod    = nv_covcod
   sic_bran.uwm301.cha_no    = wdetail.chasno
   sic_bran.uwm301.eng_no    = wdetail.engno
   sic_bran.uwm301.Tons      = INTEGER(wdetail.weight)
   sic_bran.uwm301.engine    = INTEGER(wdetail.cc)
   sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
   sic_bran.uwm301.garage    = wdetail.garage
   sic_bran.uwm301.body      = wdetail.body
   sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
   sic_bran.uwm301.mv_ben83  = wdetail.benname
   sic_bran.uwm301.vehreg    = wdetail.vehreg + nv_provi
   sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
   sic_bran.uwm301.vehuse    = wdetail.vehuse
   sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
   /*sic_bran.uwm301.sckno     = INTEGER(nv_newsck)                /*Shukiat T. Modi  on 26/04/2007*/ ---amparat a510253*/
   sic_bran.uwm301.sckno   = 0
   sic_bran.uwm301.itmdel    = NO.
   wdetail.tariff            = sic_bran.uwm301.tariff.
   /*-----compul-----*/
   IF wdetail.compul = "y" THEN DO:
      sic_bran.uwm301.cert = "y".
      IF LENGTH(wdetail.stk) = 11 THEN DO:    
          sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
      END.
      IF LENGTH(wdetail.stk) = 13  THEN DO:
          sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
      END.      
     /*--create detaitem--*/
     FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
                brStat.Detaitem.serailno = wdetail.stk  NO-LOCK NO-ERROR .
       IF NOT AVAIL brstat.Detaitem THEN DO:     
          CREATE brstat.Detaitem.
          ASSIGN
           brStat.Detaitem.Policy   = sic_bran.uwm301.Policy
           brStat.Detaitem.RenCnt   = sic_bran.uwm301.RenCnt
           brStat.Detaitem.EndCnt   = sic_bran.uwm301.Endcnt
           brStat.Detaitem.RiskNo   = sic_bran.uwm301.RiskNo
           brStat.Detaitem.ItemNo   = sic_bran.uwm301.ItemNo
           brStat.Detaitem.serailno = wdetail.stk.       
       END.
     /*-------------------*/
   END.
  
 ASSIGN /*a490166*/
  sic_bran.uwm301.bchyr = nv_batchyr         /* batch Year */
  sic_bran.uwm301.bchno = nv_batchno         /* bchno    */
  sic_bran.uwm301.bchcnt  = nv_batcnt .        /* bchcnt     */

 /*  mailtxt_fil  */
 IF  wdetail.drivnam = "Y" THEN DO :      /*note add 07/11/2005*/
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
  nv_drivage1 =  YEAR(TODAY) - INT(SUBSTR(wdetail.drivbir1,7,4))  .
  nv_drivage2 =  YEAR(TODAY) - INT(SUBSTR(wdetail.drivbir2,7,4))  .
  IF wdetail.drivbir1 <> " "  AND wdetail.drivnam1 <> " " THEN DO: /*note add & modified*/
     nv_drivbir1      = STRING(INT(SUBSTR(wdetail.drivbir1,7,4)) + 543).
     wdetail.drivbir1 = SUBSTR(wdetail.drivbir1,1,6) + nv_drivbir1.
  END.
  IF wdetail.drivbir2 <>  " " AND wdetail.drivnam2 <> " " THEN DO: /*note add & modified */
     nv_drivbir2      = STRING(INT(SUBSTR(wdetail.drivbir2,7,4)) + 543).
     wdetail.drivbir2 = SUBSTR(wdetail.drivbir2,1,6) + nv_drivbir2.
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
                     /*-- Comment by Narin A54-0396
                     brstat.mailtxt_fil.ltext     = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)). 
                     --*/
                     /*--    Add by Narin A54-0396--*/
                     brstat.mailtxt_fil.ltext     = wdetail.drivnam1 + FILL(" ",50 - LENGTH(wdetail.drivnam1)). 
                     /*--End Add by Narin A54-0396--*/
                     brstat.mailtxt_fil.ltext2    = wdetail.drivbir1 + "  " 
                                                  + string(nv_drivage1).
                     nv_drivno                    = 1.
                     ASSIGN /*a490166*/
                     brstat.mailtxt_fil.bchyr = nv_batchyr 
                     brstat.mailtxt_fil.bchno = nv_batchno 
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                     SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/
              IF wdetail.drivnam2 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil. 
                    ASSIGN
                        brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                        brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                        /*-- Comment by Narin A54-0396
                        brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)). 
                        --*/
                        /*--    Add by Narin A54-0396--*/
                        brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",50 - LENGTH(wdetail.drivnam2)). 
                        /*--End Add by Narin A54-0396--*/
                        brstat.mailtxt_fil.ltext2   = wdetail.drivbir2 + "  "
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
                      /*-- Comment by Narin A54-0396
                      brstat.mailtxt_fil.ltext      = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)). 
                      --*/
                      /*--    Add by Narin A54-0396--*/
                      brstat.mailtxt_fil.ltext      = wdetail.drivnam1 + FILL(" ",50 - LENGTH(wdetail.drivnam1)). 
                      /*--End Add by Narin A54-0396--*/ 
                      brstat.mailtxt_fil.ltext2     = wdetail.drivbir1 + "  "
                                                    +  TRIM(string(nv_drivage1)).

                      IF wdetail.drivnam2 <> "" THEN DO:
                            CREATE  brstat.mailtxt_fil.
                                ASSIGN
                                brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                                /*-- Comment by Narin A54-0396
                                brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)). 
                                --*/
                                /*--    Add by Narin A54-0396--*/
                                brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",50 - LENGTH(wdetail.drivnam2)). 
                                /*--End Add by Narin A54-0396--*/
                                brstat.mailtxt_fil.ltext2   = wdetail.drivbir2 + "  "
                                                            + TRIM(string(nv_drivage1)).
                                ASSIGN /*a490166*/
                                brstat.mailtxt_fil.bchyr = nv_batchyr 
                                brstat.mailtxt_fil.bchno = nv_batchno 
                                brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/
                      END. /*drivnam2 <> " " */
        END. /*Else DO*/
 END. 
 s_recid4         = RECID(sic_bran.uwm301).
 /*-- maktab_fil --*/
 IF wdetail.redbook <> "" AND chkred = YES THEN DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab01 
             WHERE stat.maktab_fil.sclass = wdetail.subclass      AND
                   stat.maktab_fil.modcod = wdetail.redbook
        No-lock no-error no-wait.
        If  avail  stat.maktab_fil  Then do:
            ASSIGN
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes /*note modi 07/11/05*/
                wdetail.cargrp =  maktab_fil.prmpac
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body    =  stat.maktab_fil.body.
        END.
 END.
 ELSE DO:
        Find First stat.maktab_fil Use-index      maktab04          Where
                   stat.maktab_fil.makdes   =     nv_makdes                   And                  
                   stat.maktab_fil.moddes   =     nv_moddes                   And
                   stat.maktab_fil.makyea   =     Integer(wdetail.caryear)    AND
                   stat.maktab_fil.engine   =     Integer(wdetail.cc)         AND
                   stat.maktab_fil.sclass   =     wdetail.subclass            AND
                   stat.maktab_fil.si       =     INTEGER(wdetail.si)         AND
                   stat.maktab_fil.seats    =     inte(wdetail.seat)          
    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        Assign
              sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
              sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
              wdetail.cargrp          =  stat.maktab_fil.prmpac
              sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
              sic_bran.uwm301.body    =  stat.maktab_fil.body.
    End.
END.
IF sic_bran.uwm301.modcod = ""  THEN DO:
             MESSAGE "NOT FIND MODEL CODE IN  MAKTAB_FIL".
             ASSIGN
             wdetail.pass    = "N"
             WDETAIL.COMMENT =  wdetail.comment + "| NOT FIND MODEL CODE IN  MAKTAB_FIL".
END.

NO_baseprm = deci(wdetail.base).

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
    
    /*-------nv_COMPPRM----------*/
    ASSIGN 
        nv_tariff = sic_bran.uwm301.tariff
        nv_class  = wdetail.prempa +  wdetail.subclass
        nv_comdat = sic_bran.uwm100.comdat
        nv_engine = DECI(wdetail.cc)
        nv_tons   = deci(wdetail.weight)
        nv_covcod = wdetail.covcod
        nv_vehuse = wdetail.vehuse
        nv_COMPER = wdetail.comper
        nv_comacc = wdetail.comacc
        nv_seats  = INTE(wdetail.seat)
        nv_tons   = DECI(wdetail.weight).
    
    /*----------- comprem ---------------*/
    IF wdetail.compul = "y" THEN DO:
        RUN wgs\wgscomp. /*a490166 note modi*/
    
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

                                  /***--- 25/10/2006 ---***/
                                  ASSIGN
                                  sic_bran.uwm130.uom8_c  = "D8"
                                  sic_bran.uwm130.uom9_c  = "D9". /*copy จาก usomn01.p*/
                   End.
                   Else assign          nv_compprm     = 0
                                        nv_compcod     = " "
                                        nv_compvar1    = " "
                                        nv_compvar2    = " "
                                        nv_compvar     = " ".
            
                    If  nv_compprm  =  0  Then  
                         RUN wgs\wgscomp.    /*a490166 note modi*/     
                         nv_comacc  = nv_comacc .                  
                End.  /* else do */     
                
            
                If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0. 
    END. /*compul y*/
    ELSE DO:
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


    END.
    /*------------------------------*/

    
    If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0. 


     /*-----nv_drivcod---------------------*/
    nv_drivvar1 = wdetail.drivnam1.
    nv_drivvar2 = wdetail.drivnam2.
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
               /*NEXT. *//*a490166*/
               End.
      Assign
              nv_drivvar     = " "
              nv_drivvar1    = "     Driver name person = "
              nv_drivvar2    = String(nv_drivno)
              Substr(nv_drivvar,1,30)  = nv_drivvar1
              Substr(nv_drivvar,31,30) = nv_drivvar2.
      RUN proc_usdcod.        
      
    END.
    
    /*-------nv_baseprm----------*/
    RUN wgs\wgsfbas. /*25/09/2006 add condition base in range*/
    IF NO_basemsg <> " " THEN 
        wdetail.WARNING = no_basemsg.
    
    IF nv_baseprm = 0  Then do:
          Message  " Base Premium is Mandatory field. "  View-as alert-box.
          ASSIGN
          wdetail.pass    = "N"
          wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".
          /*NEXT.        *//*a490166*/
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
       nv_41 =  WDETAIL.no_41  
       nv_41 =  WDETAIL.no_41  
       nv_42 =  WDETAIL.no_42  
       nv_43 =  WDETAIL.no_43 
       


       nv_seat41 = integer(wdetail.seat41).
    

      RUN WGS\WGSOPER(INPUT nv_tariff, /*pass*/ /*a490166 note modi*/
                                    nv_class,
                                    nv_key_b,
                                    nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/
    
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
   
    RUN wgs\wgsoeng. /*a490166 note modi*/
    /*MESSAGE "nv_engcod1" nv_engcod.*/

    

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
      /* caculate deduct OD  */
      DEF VAR dod0 AS INTEGER.
      DEF VAR dod1 AS INTEGER.
      DEF VAR dod2 AS INTEGER.
      DEF VAR dpd0 AS INTEGER.
      /*def  var  nv_chk  as  logic.*/
               
      dod0 = inte(wdetail.deductda).
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
          
           
           

      /*---------- fleet -------------------*/
    
     nv_flet_per = INTE(wdetail.fleet).

     IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
              Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
              ASSIGN
              wdetail.pass    = "N"
              wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
              /*NEXT.  *//*a490166*/
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


     DEF VAR nv_ncbyrs AS INTE.
     /*nv_ncbyrs = inte(wdetail.ncb).*/
     NV_NCBPER = INTE(WDETAIL.NCB).
     nv_ncbvar = " ".

     If nv_ncbper  <> 0 Then do:
           Find first sicsyac.xmm104 Use-index xmm10401 Where
                   sicsyac.xmm104.tariff = nv_tariff                      AND
                   sicsyac.xmm104.class  = nv_class                 AND
                   sicsyac.xmm104.covcod = nv_covcod           AND
                   sicsyac.xmm104.ncbper   = INTE(wdetail.ncb)
            No-lock no-error no-wait.
            IF not avail  sicsyac.xmm104  Then do:
                   Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                   ASSIGN
                   wdetail.pass    = "N"
                   wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
                   /*NEXT.*//*a490166 Load all no Comment*/
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
 
     /*-------------- load claim ---------------------*/
      
     nv_cl_per  = deci(wdetail.loadclm).
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
          nv_dsspcvar   = " ".
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


      IF nv_gapprm <> inte(wdetail.volprem) /*OR inte(wdetail.Compprem) <> nv_compprm */ THEN  DO:
                    MESSAGE "เบี้ยไม่ตรงกับเบี้ยที่คำนวณได้" + wdetail.volprem + " <> " + STRING(nv_gapprm) VIEW-AS ALERT-BOX.
                    ASSIGN 
                    WDETAIL.WARNING  = "เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้"
                    wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้ "
                    wdetail.pass    = "N".
      END. /*a490166*/
      
      IF wdetail.pass <> "N"  THEN 
                    ASSIGN
                    wdetail.comment = "COMPLETE"
                    WDETAIL.WARNING = ""
                    wdetail.pass    = "Y".
                    
      
 
    FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
    IF AVAIL  sic_bran.uwm100 THEN DO:
         ASSIGN 
         sic_bran.uwm100.prem_t = nv_gapprm
         sic_bran.uwm100.sigr_p = inte(wdetail.si)
         sic_bran.uwm100.gap_p  = nv_gapprm.
         IF wdetail.pass <> "Y" THEN DO:
             ASSIGN
             sic_bran.uwm100.impflg = NO
             sic_bran.uwm100.imperr = wdetail.comment.      /*26/10/2006 change field name*/
           /*sic_bran.uwm100.imperrmsg = wdetail.comment.*/ /*26/10/2006 change field name*/
         END.
    END.
    FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
    IF AVAIL  sic_bran.uwm120 THEN DO:
         ASSIGN
         sic_bran.uwm120.gap_r  = nv_gapprm
         sic_bran.uwm120.prem_r = nv_pdprm
         sic_bran.uwm120.sigr   = inte(wdetail.si).
    END.
     FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
     IF AVAIL  sic_bran.uwm301 THEN DO:
         ASSIGN   
         sic_bran.uwm301.ncbper   = nv_ncbper
         sic_bran.uwm301.ncbyrs   = nv_ncbyrs
         sic_bran.uwm301.mv41seat = wdetail.seat41.
     END.                                     
 

     RUN WGS\WGSTN132(INPUT S_RECID3, /*a490166 note modi*/
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
  /********************************/
Def  var   n_sigr_r     like sic_bran.uwm130.uom6_v.
Def  var   n_gap_r      Like sic_bran.uwd132.gap_c . 
Def  var   n_prem_r     Like sic_bran.uwd132.prem_c.
Def  var   nt_compprm   like sic_bran.uwd132.prem_c.  
Def  var   n_gap_t      Like sic_bran.uwm100.gap_p.
Def  var   n_prem_t     Like sic_bran.uwm100.prem_t.
Def   var  n_sigr_t     Like sic_bran.uwm100.sigr_p.

def  var   nv_policy    like sic_bran.uwm100.policy.
def  var   nv_rencnt    like sic_bran.uwm100.rencnt.
def  var   nv_endcnt    like sic_bran.uwm100.endcnt.

def  var   nv_com1_per  like sicsyac.xmm031.comm1.
def  var   nv_stamp_per like sicsyac.xmm020.rvstam.

/*-------  note add ------*/
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

/*------------------------*/
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1
  no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      Message "not found (uwm100./wuwrep02.p)" View-as alert-box.
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
                     /*a490166*/                                             
                     sic_bran.uwm120.bchyr = nv_batchyr               AND 
                     sic_bran.uwm120.bchno = nv_batchno               AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt                     .

                     FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                              sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                              sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                              sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                              sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                              /*a490166*/                                             
                              sic_bran.uwm130.bchyr = nv_batchyr              AND 
                              sic_bran.uwm130.bchno = nv_batchno              AND 
                              sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                          

                              n_sigr_r                = n_sigr_r + uwm130.uom6_v.
                              FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE /*a490166 แก้ Index จาก 09 เป็น 01*/
                                       sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                                       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                                       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                                       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                                       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                                       /*a490166*/                                             
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
  Find LAST  sic_bran.uwm120  Use-index uwm12001  WHERE          /***--- a490166 change first to last ---***/
             sic_bran.uwm120.policy  = sic_bran.uwm100.policy   And
             sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt   And
             sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt   AND 
             /*a490166*/                                             
             sic_bran.uwm120.bchyr = nv_batchyr               AND 
             sic_bran.uwm120.bchno = nv_batchno               AND 
             sic_bran.uwm120.bchcnt  = nv_batcnt                No-error.

  /***--- A50-0097 Shukiat T. 26/04/2007 ---***/
  /***--- เปลี่ยนรูปแบบการค้น Commission Rate ใหม่ ---***/
  /***--- A49-0206 Shukiat T. 15/01/2006 ---***/
  /***--- Commmission Rate Line 70 ---***/
  /***--- A50-0144 Shukiat T. 05/06/2007 ---***/
  /***--- เปลี่ยนเงื่อนไขการ Find เงื่อนไขใน Table Xmm018 ---***/
  FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
             substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
             SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
             sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
  IF AVAIL   sicsyac.xmm018 THEN DO:
            Assign     nv_com1p = sicsyac.xmm018.commsp  
                       nv_com2p = 0.
  END. /* Avail Xmm018 */
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
                     /*nv_com2p = sicsyac.xmm031.comm2.*//*A490206*/
  END. /* Not Avail Xmm018 */
  
  /***--- Commmission Rate Line 72 ---***/
  IF wdetail.compul = "y" THEN DO:
      FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
                 sicsyac.xmm018.agent              = sic_bran.uwm100.acno1  AND               /*แยกงานตาม Code Producer*/   
                 substr(sicsyac.xmm018.poltyp,1,5) = "CRV72"                AND               /*Shukiat T. modi on 25/04/2007*/
                 SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
                 sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
      IF AVAIL   sicsyac.xmm018 THEN DO:
                 nv_com2p = sicsyac.xmm018.commsp.
      END.
      ELSE DO:
           Find  sicsyac.xmm031  Use-index xmm03101  Where  
                 sicsyac.xmm031.poltyp    = "v72"
           No-lock no-error no-wait.
                 /*nv_com2p = sicsyac.xmm018.commsp.*//***--- Shukiat T. 26/01/2007 ---***/
                   nv_com2p = sicsyac.xmm031.comm1.   /***--- Shukiat T. 26/01/2007 ---***/
      END.
  END. /* Wdetail.Compul = "Y"*/
  /***--- End a490206 15/01/2007 ---***/


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
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else  do:
           /*nv_fi_stmpae    = NO. /*a / e*/*/
  End.
  ---***//***---End Note Block ---***/  
  
  sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
     
  IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
      nv_fi_rtax_t  = (sic_bran.uwm100.prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
       /* fi_taxae       = Yes.*/
  End.
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else do:
        /*fi_taxae     = no.*/
  end.
  ---***//***---End Note Block ---***/  
    
  sic_bran.uwm100.rtax_t = nv_fi_rtax_t.

  /*-a490206-*/
  sic_bran.uwm120.com1ae = YES.
  sic_bran.uwm120.com2ae = YES.
  
  /*--------- motor commission -----------------*/
  IF sic_bran.uwm120.com1ae   = Yes  Then do:                   /* MOTOR COMMISION */
     If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
         /*nv_fi_com1_t   =  - TRUNCATE ((sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100,0).*/ /*A490166 Shukiat T. Block on 24/10/2006*/
           nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.             /*A490166 Shukiat T. Modi on 24/10/2006*/
         /*fi_com1ae        =  YES.*/
  End.
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else do:
         /*fi_com1ae     = NO.*/
  End.
  ---***//***---End Note Block ---***/  

  /*----------- comp comission ------------*/
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then nv_com2p  = sic_bran.uwm120.com2p.
         /*nv_fi_com2_t   =  - TRUNCATE ( nt_compprm  *  nv_com2p / 100,0).*/   /*A490166 Shukiat T. Block on 24/10/2006*/
           nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.              /*A490166 Shukiat T. Modi on 24/10/2006*/
         /*nv_fi_com2ae        =  YES.*/
  End.
  /***--- a490166 Block on 28/09/2006 ---***//***---
  Else do:
       /*  fi_com2ae     = NO.*/
  End.
  ---***//***---End Note Block ---***/  

  IF sic_bran.uwm100.pstp <> 0 Then do:
     IF sic_bran.uwm100.no_sch  = 1 Then NV_fi_dup_trip = "D".
     Else If sic_bran.uwm100.no_sch  = 2 Then  NV_fi_dup_trip = "T".
  End.
  Else  NV_fi_dup_trip  =  "".

  nv_fi_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t
               + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.

  /*---------------------------*/
  
  Find     sic_bran.uwm100 Where  Recid(sic_bran.uwm100)  =  s_recid1.
  If avail sic_bran.uwm100 Then do:
      Assign 
           sic_bran.uwm100.gap_p   = n_gap_t
           sic_bran.uwm100.prem_t  = n_prem_t
           sic_bran.uwm100.sigr_p  = n_sigr_t
           sic_bran.uwm100.instot  = uwm100.instot
           sic_bran.uwm100.com1_t  =  nv_fi_com1_t
           sic_bran.uwm100.com2_t  =  nv_fi_com2_t
         /*sic_bran.uwm100.pstp    =  nv_fi_stamp_per /*note Block on 25/10/2006*/*/
           sic_bran.uwm100.pstp    =  0               /*note modified on 25/10/2006*/
           sic_bran.uwm100.rstp_t  =  nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  =  nv_fi_rtax_t
           sic_bran.uwm100.gstrat  =  nv_fi_tax_per.
  End.
  IF wdetail.poltyp = "v72" THEN DO:
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
       
        IF wdetail.poltyp = "v72" THEN DO:
           ASSIGN  
           sic_bran.uwm120.com2_r    = 0 
           sic_bran.uwm120.com1_r    = nv_fi_com2_t
           /*-a490206-*/
           sic_bran.uwm120.com1p     = nv_com2p
           sic_bran.uwm120.com2p     = 0.
        END.

     
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
Create  sic_bran.uwm100. /*Create ฝั่ง gateway*/
ASSIGN
       sic_bran.uwm100.policy =  wdetail.policy
       sic_bran.uwm100.rencnt =  n_rencnt          
       sic_bran.uwm100.renno  =  ""    
       sic_bran.uwm100.endcnt =  n_endcnt
       sic_bran.uwm100.bchyr   = nv_batchyr 
       sic_bran.uwm100.bchno   = nv_batchno 
       sic_bran.uwm100.bchcnt  = nv_batcnt     .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cuticno C-Win 
PROCEDURE proc_cuticno :
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
ASSIGN 
    nv_c = trim(ns_idcard) 
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
    ns_idcard    = trim(nv_c) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cuticnobess C-Win 
PROCEDURE proc_cuticnobess :
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
ASSIGN 
    nv_c = trim(ns_BUSINESS)
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
    ns_BUSINESS  = trim(nv_c) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpolicy C-Win 
PROCEDURE proc_cutpolicy :
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
    ind = INDEX(nv_c,".").
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initail C-Win 
PROCEDURE proc_initail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  ns_entrydat  = ""    /* 1  Entry date           */
        ns_entrytim  = ""    /* 2  Entry time           */
        ns_trndat    = ""    /* 3  Trans Date           */
        ns_trntim    = ""    /* 4  Trans Time           */
        ns_poltyp    = ""    /* 5  Policy Type  70      */
        ns_policy    = ""    /* 6  Policy       DL7056007891    */
        ns_renewpol  = ""      /* 7  Renew Policy       DL7055007225    */
        ns_comdat    = ""      /* 8  Comm Date  5/5/2013        */
        ns_expidat   = ""      /* 9  Expiry date        5/5/2014        */
        ns_compul    = ""      /* 10 Compulsory N       */
        ns_title     = ""      /* 11 Title name คุณ     */
        ns_insnam    = ""      /* 12 Insured name       จตุพงษ์  ศิรินุกูลพิพัฒน์       */
        ns_addr1     = ""      /* 13 Ins addr1  271/350  หมู่บ้านบ่อวินเมืองทอง 2       */
        ns_addr2     = ""      /* 14 Ins addr2  ตำบลบ่อวิน  อำเภอศรีราชา        */
        ns_addr3     = ""      /* 15 Ins addr3  ชลบุรี  20230   */
        ns_addr4     = ""      /* 16 Ins addr4  โทร /081-685-6535  มือถือ       */
        ns_pack      = ""      /* 17 Premium Package    F       */
        ns_subclass  = ""      /* 18 Sub Class  110     */
        ns_Brand     = ""      /* 19 Brand      NISSAN  */
        ns_Mode      = ""      /* 20 Mode       NAVARA DOUBLECAB 2.5 LE 6M/T HI POWER ABS SRS   */
        ns_Cc        = ""      /* 21 Cc     2500        */
        ns_Weight    = ""      /* 22 Weight     0       */
        ns_Seat      = ""      /* 23 Seat       7       */
        ns_Body      = ""      /* 24 Body       เก๋ง    */
        ns_vehreg    = ""      /* 25 Vehicle registration       ชธ 9764 กท      */
        ns_engno     = ""      /* 26 Engine no  YD25-035007T    */
        ns_chassis   = ""      /* 27 Chassis no MNTVCUD40Z0-001245      */
        ns_caryear   = ""      /* 28 Car Year   2007    */
        ns_provin    = ""      /* 29 Car Province               */
        ns_vehuse    = ""      /* 30 Vehicle Use        1       */
        ns_garage    = ""      /* 31 Garage     F       */
        ns_stkno     = ""      /* 32 Sticker no         */
        ns_access    = ""      /* 33 Accessories        n       */
        ns_cover     = ""      /* 34 Cover Type 1       */
        ns_sumins    = ""      /* 35 Sum Insured        340,000.00      */
        ns_volprem   = ""      /* 36 Voluntory Premium  13,305.00       */
        ns_compprem  = ""      /* 37 Compulsory Prem            */
        ns_fleet     = ""      /* 38 Fleet %    0.00    */
        ns_ncb       = ""      /* 39 NCB %      50.00   */
        ns_loadcl    = ""      /* 40 Load Claim 0.00    */
        ns_DeductDA  = ""      /* 41 Deduct DA  0       */
        ns_DeductPD  = ""      /* 42 Deduct PD  0       */
        ns_Benname   = ""      /* 43 Benificiary                */
        ns_userid    = ""      /* 44 User id                */
        ns_import    = ""      /* 45 Import                     */
        ns_export     = ""      /* 46 Drive name n       */                  
        ns_drivno     = ""      /* 47 Driver name1       */              
        ns_drivname1  = ""      /* 48 Driver name2       */              
        ns_drivname2  = ""     /* 49 Driver Birthdate1  */          
        ns_drivbirth1 = ""     /* 50 Driver Birthdate2  */          
        ns_drivbirth2 = ""     /* 51 Driver age1    0   */              
        ns_drivage1   = ""     /* 52 Driver age2    0   */              
        ns_drivname2  = ""     /* 53 Cancel     */                      
        ns_cancel     = ""     /* 54 Producer       */                  
        ns_producer   = ""     /* 55 Agent  AOL00068    */              
        ns_agent      = ""     /* 56 Code Red Book      */              
        ns_redbook    = ""     /* 57 Note   คุ้มภัย  DL7055/007225  */  
        ns_note       = ""     /* 58 ATTACH_NOTE    อ้อม 307 ห้าง   */  
        ns_attach     = ""          /* 59 */  
        ns_idcard     = ""    
        ns_BUSINESS   = ""  
        ns_basenew    = ""    /*A58-0103 */
        campaignno    = ""  . /*A58-0103 */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_inscod C-Win 
PROCEDURE proc_inscod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   /***--- a490166 Block on 28/09/2006 ---***//***---
   FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno  = wdetail.inscod NO-ERROR.
                                        IF NOT AVAILABLE xmm600 THEN DO:
                                               CREATE xmm600.
                                               sv_xmm600        =   Recid(xmm600).
                                               xmm600.acno     =   CAPS( wdetail.inscod).
                                               xmm600.entdat   =   TODAY.
                                               xmm600.enttim   =   String(Time,"HH:MM:SS").         
                                               xmm600.usrid     =   SUBSTRING(n_user,3,6).
                                                             
                                               FIND FIRST xmm024  NO-LOCK NO-ERROR.         
                                               FIND xmm023 WHERE xmm023.branch = SUBSTRING(n_user,6,1) NO-LOCK NO-ERROR.
                                               If Avail xmm023 Then Do :
                                                    ASSIGN
                                                         xmm600.homebr  = CAPS(SUBSTRING(n_user,6,2)) 
                                                         xmm600.cntry       = CAPS(xmm023.dcntry)
                                                         xmm600.stattp      = CAPS(xmm024.dsttyp).
                                               End.
                                               FIND xmm011 WHERE xmm011.cntry = xmm023.dcntry NO-LOCK NO-ERROR.
                                               IF AVAILABLE xmm011 THEN xmm600.ltcurr = CAPS(xmm011.curd_d).
                                             
                                               ASSIGN
                                                   xmm600.ntitle       =  wdetail.tiname
                                                   xmm600.name      =  wdetail.insnam
                                                   /*xmm600.abname  = Input fi_abname*/
                                                   /*xmm600.icno         = Input  fi_icno
                                                   xmm600.oldic        = Input  fi_oldic*/
                                                   xmm600.addr1      = wdetail.iadd1
                                                   xmm600.addr2      = wdetail.iadd2
                                                   xmm600.addr3      = wdetail.iadd3
                                                   xmm600.addr4      = wdetail.iadd4
                                                   xmm600.clicod     = "IN"  /*note on a490088*/
                                                   xmm600.acccod     = "IN"  /*note on a490088*/
                                                   /*xmm600.crper       = xmm024.dcrprd*/
                                                   xmm600.gpstcs     =  wdetail.inscod
                                                   xmm600.gpage     =   wdetail.producer
                                                   xmm600.gpstmt    =   wdetail.inscod
                                                   xmm600.opened   = TODAY
                                                   xmm600.chgpol    = No
                                                   xmm600.debtyn    = Yes
                                                   xmm600.muldeb   = No
                                                   xmm600.prindr      = 1
                                                   xmm600.stattp      =  "I"
                                                   xmm600.regagt    =  "R" 
                                                   xmm600.ltcurr       =  "BHT"
                                                   xmm600.or1gn      = "G"
                                                   xmm600.or2gn      = "G"
                                                   xmm600.comtab   = 1   . 
                                                   
                                        END. /*Not avail xmm600*/         
/***--- Thai code ---***/

/***--- note new thai code ---***/
  Find  xtm600  Use-index xtm60001 Where
        xtm600.acno  =  wdetail.inscod     No-error No-wait.
      If Not  avail  xtm600 Then do:
      Create xtm600.
      Assign 
           xtm600.acno    =  wdetail.inscod
           xtm600.ntitle  =  wdetail.tiname 
           xtm600.name    =  wdetail.insnam 
           /*xtm600.abname  = Input fi_abname*/
           xtm600.addr1   = wdetail.iadd1                             
           xtm600.addr2   = wdetail.iadd2                             
           xtm600.addr3   = wdetail.iadd3                             
           xtm600.addr4   = wdetail.iadd4  .                           

  End.           

/***--- end note ---***/
---*//***---End Note Block a490166 ---***/
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
    nv_transfer   = YES .
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME     = TRIM(wdetail.insnam)  AND 
    sicsyac.xmm600.homebr   = caps(trim(fi_branch)) AND 
    sicsyac.xmm600.clicod   = "IN"                  NO-ERROR NO-WAIT.  
IF NOT AVAILABLE sicsyac.xmm600 THEN DO: 
    IF LOCKED sicsyac.xmm600 THEN DO:   
        ASSIGN nv_transfer = NO 
            n_insref    = sicsyac.xmm600.acno.
        RETURN.
    END.
    ELSE DO:
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
    IF sicsyac.xmm600.acno <> "" THEN DO:   /* กรณีพบ */
        ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            n_insref                = caps(trim(nv_insref)) 
            nv_transfer             = NO 
            sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname    = ""                        /*First Name*/
            sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
            sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
            sicsyac.xmm600.icno     = IF wdetail.idcard  = "" THEN wdetail.BUSINESS ELSE wdetail.idcard        /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       /*Address line 1*/
            sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)       /*Address line 2*/
            sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)       /*Address line 3*/
            sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4)       
            sicsyac.xmm600.homebr   = caps(trim(fi_branch))     /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                     
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            sicsyac.xmm600.dtyp20   = ""
            sicsyac.xmm600.dval20   = ""      /*-- Add chutikarn A50-0072 --*/
            sicsyac.xmm600.anlyc5   = ""  .
          /*sicsyac.xmm600.anlyc5   =  ""     /*Analysis Code 5*/ */          /*A57-0073*/
            /*sicsyac.xmm600.anlyc5   = IF nv_typ = "Cs" THEN TRIM(wdetail2.brdealer) ELSE "" .*//*kridtiya i. 31/10/2014 */
        
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
        sicsyac.xmm600.name     = TRIM(wdetail.insnam)     /*Name Line 1*/
        sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
        sicsyac.xmm600.icno     = IF wdetail.idcard  = "" THEN wdetail.BUSINESS ELSE wdetail.idcard       /*IC No.*/     /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.iadd1)       /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.iadd2)                    /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.iadd3)                    /*Address line 3*/
        sicsyac.xmm600.addr4    = TRIM(wdetail.iadd4)                    /*Address line 4*/
        sicsyac.xmm600.postcd   = ""                        /*Postal Code*/
        sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
        sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
        sicsyac.xmm600.homebr   = caps(trim(fi_branch))      /*Home branch*/
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
            sicsyac.xtm600.name    = TRIM(wdetail.insnam)   /*Name of Insured Line 1*/
            sicsyac.xtm600.abname  = TRIM(wdetail.insnam)   /*Abbreviated Name*/
            sicsyac.xtm600.addr1   = TRIM(wdetail.iadd1)    /*address line 1*/
            sicsyac.xtm600.addr2   = TRIM(wdetail.iadd2)    /*address line 2*/
            sicsyac.xtm600.addr3   = TRIM(wdetail.iadd3)    /*address line 3*/
            sicsyac.xtm600.addr4   = TRIM(wdetail.iadd4)    /*address line 4*/
            sicsyac.xtm600.name2   = ""                     /*Name of Insured Line 2*/ 
            sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)   /*Title*/
            sicsyac.xtm600.name3   = ""                     /*Name of Insured Line 3*/
            sicsyac.xtm600.fname   = "" .                   /*First Name*/
    END.
END.

RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.

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
/*Add by Kridtiya i. A63-0472*/
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno      = nv_insref   NO-ERROR NO-WAIT.  
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
    sicsyac.xmm600.anlyc5    = IF wdetail.insnamtyp = "co" THEN trim(wdetail.br_insured) ELSE "".  
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN
    ASSIGN 
    sicsyac.xtm600.postcd    = trim(wdetail.postcd)        
    sicsyac.xtm600.firstname = trim(wdetail.firstName)     
    sicsyac.xtm600.lastname  = trim(wdetail.lastName)   .   
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xtm600.
/*Add by Kridtiya i. A63-0472 */
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
    sicsyac.xzm056.branch   =  caps(trim(fi_branch))   NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN sicsyac.xzm056.seqtyp =  nv_typ
            sicsyac.xzm056.branch    =  caps(trim(fi_branch))
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref = caps(trim(fi_branch))  + String(1,"999999")
            nv_lastno = 1.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(caps(trim(fi_branch))) = 2 THEN
            nv_insref = caps(trim(fi_branch)) + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:
            /*A56-0318....
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno + 1 ,"999999").   A56-0318*/
            /*Add ... A56-0318*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (caps(trim(fi_branch)) = "A") OR (caps(trim(fi_branch)) = "B") THEN DO:
                    nv_insref = "7" + caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (caps(trim(fi_branch)) = "A") OR (caps(trim(fi_branch)) = "B") THEN DO:
                    nv_insref = "7" + caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  caps(trim(fi_branch))
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(caps(trim(fi_branch))) = 2 THEN
            nv_insref = caps(trim(fi_branch)) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + caps(trim(fi_branch)) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       caps(trim(fi_branch)) + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").
        END.   
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  caps(trim(fi_branch))
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(caps(trim(fi_branch))) = 2 THEN
            nv_insref = caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno,"999999").*/
            /*Add ... A56-0318*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (caps(trim(fi_branch)) = "A") OR (caps(trim(fi_branch)) = "B") THEN DO:
                    nv_insref = "7" + caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (caps(trim(fi_branch)) = "A") OR (caps(trim(fi_branch)) = "B") THEN DO:
                    nv_insref = "7" + caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       caps(trim(fi_branch)) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
    END.
    ELSE DO:
        IF LENGTH(caps(trim(fi_branch))) = 2 THEN
            nv_insref = caps(trim(fi_branch)) + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + caps(trim(fi_branch)) + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       caps(trim(fi_branch)) + "C" + String(sicsyac.xzm056.lastno,"99999").
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
                sicsyac.xzm056.branch    =  caps(trim(fi_branch))
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
                sicsyac.xzm056.branch    =  caps(trim(fi_branch))
                sicsyac.xzm056.des       =  "Company/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno. 
        END.
    END.
END.        /*lastno <= seqno */  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_INSURE C-Win 
PROCEDURE PROC_INSURE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/***--- a490166 Block on 28/09/2006 ---***//***---  
  /**********************  find inscode   ***********************/
Find LAST xmm600 Use-index xmm60002 Where xmm600.NAME = wdetail.insnam AND  Xmm600.ntitle = wdetail.TIname
                No-lock no-error no-wait.
                IF Not avail xmm600 Then do:
                      Message "Not on Name & Address Master file xmm600" View-as alert-box.
                      FIND LAST xtm600 Use-index xtm60002 Where xtm600.NAME = wdetail.insnam AND  Xtm600.ntitle = wdetail.TIname
                      No-lock no-error no-wait.
                      IF Not avail xtm600 Then do:
                              Message "Warning:  Not Found Insured Code is"  Skip
                                      "Thai on File xtm600 Please Update" View-as alert-box.  
                              DEF VAR ptype AS CHAR FORMAT "x"  .
                              MESSAGE    "Process Insure Code"    skip
                                         "Do you really want to run auto Insure Code ?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-No
                              TITLE ""  UPDATE  choice3   AS LOGICAL.
                              CASE choice3:
                              When True Then do:  
                              Repeat:
                                ptype = "0".
                                MESSAGE "ประเภทของผู้เอาประกัน" SKIP
                                        "บุคคลธรรมดา Enter Value 0" SKIP
                                        "นิติบุคคล   Enter Value C" SKIP
                                UPDATE ptype . 
                                IF ptype = "0" THEN DO:
                                        Do Transaction : /*start*/
                                            Find Last  xzm056 Use-Index  xzm05601  Where 
                                                       xzm056.seqtyp  =  "0s"      And
                                                       xzm056.branch  =  fi_branch No-Lock No-Error .
                                            If Not Avail  xzm056 Then Do :
                                                Create  xzm056.
                                                Assign
                                                    xzm056.seqtyp    =     "0s"
                                                    xzm056.branch    =     fi_branch
                                                    xzm056.des       =     "Personal/Start"
                                                    xzm056.lastno    =      1.                   
                                            End. /*not avail xzm056*/       
                                            If  xzm056.lastno >   xzm056.seqno Then Do :
                                                    Message  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
                                                    "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
                                                    "แล้วติดต่อผู้ตั้ง Code"  View-As Alert-Box.  
                                            End. /*lastno > seqno*/                       
                                            Else Do :   /*lastno <= seqno */
                                                    wdetail.inscod  =    fi_branch   + String( xzm056.lastno,"999999").
                                                    nv_lastno       =    xzm056.lastno.
                                                    nv_seqno        =    xzm056.seqno. 
                                                    Create  xzm056.
                                                    Assign
                                                    xzm056.seqtyp    =     "0s"
                                                    xzm056.branch    =     fi_branch
                                                    xzm056.des       =     "Personal/Start"
                                                    xzm056.lastno    =     nv_lastno + 1
                                                    xzm056.seqno     =     nv_seqno.                                       
                                            End.   /*lastno <= seqno */
                                        End. /* Do transaction */
                                        RUN proc_inscod.
                                        LEAVE.
                                END. /*ptype 0*/
                                IF ptype = "C" THEN DO:
                                        Do Transaction :
                                            Find Last  xzm056 Use-Index  xzm05601 Where 
                                                       xzm056.seqtyp  =  "Cs"                   And
                                                       xzm056.branch  =  fi_branch        No-Lock No-Error .
                                            If Not Avail  xzm056 Then Do :
                                                    Create  xzm056.
                                                    Assign
                                                    xzm056.seqtyp    =     "Cs"
                                                    xzm056.branch    =     fi_branch
                                                    xzm056.des       =     "Company/Start"
                                                    xzm056.lastno    =     1.                   
                                            End. /*not avail xzm056*/       
                                            If  xzm056.lastno >   xzm056.seqno Then Do :
                                                    Message  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
                                                    "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
                                                    "แล้วติดต่อผู้ตั้ง Code"  View-As Alert-Box.  
                                            End. /*lastno > seqno*/                       
                                            Else Do :   /*lastno <= seqno */
                                                    wdetail.inscod    =    fi_branch  + "C" + String( xzm056.lastno,"99999").
                                                    nv_lastno         =    xzm056.lastno.
                                                    nv_seqno          =    xzm056.seqno. 
                                                    Create  xzm056.
                                                    Assign
                                                        xzm056.seqtyp    =     "Cs"
                                                        xzm056.branch    =     fi_branch
                                                        xzm056.des       =     "Company/Start"
                                                        xzm056.lastno    =     nv_lastno + 1
                                                        xzm056.seqno     =     nv_seqno.                                       
                                            End.   /*lastno <= seqno */
                                        End. /* Do transaction */
                                        RUN proc_inscod.
                                        LEAVE.
                                END. /* type c */
                              End.  /* repeat */ 
                                
                              End.  /* true case */
                             END CASE.
                                
                                
                                
                                End.
                                End.
                                
                                Find LAST xmm600 Use-index xmm60002 Where xmm600.NAME = wdetail.insnam AND  Xmm600.ntitle = wdetail.TIname
                                No-lock no-error no-wait.
                                IF AVAIL xmm600 THEN DO:
                                wdetail.inscod = xmm600.acno.
                                uwm100.insref = wdetail.inscod.
                                END.
---*//***---End Note Block a490166 ---***/
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
OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y".   

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
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
ASSIGN fi_process   = "Create data to table uwm100 ...." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
IF wdetail.policy <> "" THEN DO:
    IF wdetail.stk  <>  ""  THEN DO:
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN  wdetail.pass = "N"
                wdetail.comment  = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN  
                ASSIGN wdetail.pass = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            nv_newsck = " ".
            IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
            ELSE wdetail.stk = wdetail.stk.
            FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
                stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
            IF AVAIL stat.detaitem THEN DO:
                IF stat.detaitem.policy <>  sicuw.uwm100.policy  THEN 
                    ASSIGN  wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
                    wdetail.WARNING = "Program Running Policy No. ให้ชั่วคราว".
            END.
        END.   /*uwm100*/
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.       /*wdetail.stk  <>  ""*/
    ELSE DO:   /*sticker = ""*/ 
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy = wdetail.policy   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES THEN DO:
                ASSIGN  wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            END.
            IF wdetail.policy = "" THEN DO:
                RUN proc_temppolicy.
                wdetail.policy  = nv_tmppol.
            END.
            RUN proc_create100.  
        END.
        ELSE RUN proc_create100. 
    END.
END.
ELSE DO:   /*wdetail.policy = ""*/
    IF wdetail.stk  <>  ""  THEN DO:
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then do:
            ASSIGN wdetail.pass  = "N"
                wdetail.comment  = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        END.
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN DO:
                ASSIGN wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว". 
            END.
            nv_newsck = " ".
            IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
            ELSE wdetail.stk = wdetail.stk.
            FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
                stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
            IF AVAIL stat.detaitem THEN DO:
                IF stat.detaitem.policy <>  sicuw.uwm100.policy  THEN DO:
                    ASSIGN  wdetail.pass    = "N"
                        wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
                        wdetail.WARNING = "Program Running Policy No. ให้ชั่วคราว".
                END.
            END.
        END.  /*uwm100*/
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.    /*wdetail.stk  <>  ""*/
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
IF wdetail.poltyp = "V70" AND wdetail.Docno <> "" THEN DO:
    nv_docno  = wdetail.Docno.
    nv_accdat = TODAY.
END.
ELSE DO:
    IF wdetail.docno  = "" THEN nv_docno  = "".
    IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
IF nv_insref = ""  THEN DO:
    RUN proc_insnam  .  /*a58-0103*/
    RUN proc_insnam2 .  /*Add by Kridtiya i. A63-0472*/
END.

RUN proc_chkcode .  /* A64-0138*/

DO TRANSACTION:
    ASSIGN
        sic_bran.uwm100.renno  = ""
        sic_bran.uwm100.endno  = ""
        sic_bran.uwm100.poltyp = wdetail.poltyp
        /*sic_bran.uwm100.insref = ""    */          /*A58-0103*/
        sic_bran.uwm100.insref = trim(nv_insref)     /*A58-0103*/
        /*sic_bran.uwm100.opnpol = ""   */           /*A58-0103*/
        sic_bran.uwm100.opnpol = wdetail.campaignno  /*A58-0103*/
        sic_bran.uwm100.cr_1   = IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "2.2" ) OR 
                                    (wdetail.covcod = "3.1" ) OR (wdetail.covcod = "3.2" ) THEN "SUPER SAVE" ELSE ""   /*A58-0103*/
        sic_bran.uwm100.anam2  = IF wdetail.idcard  = "" THEN wdetail.BUSINESS ELSE wdetail.idcard                 /* ICNO  Cover Note A51-0071 Amparat */
        sic_bran.uwm100.ntitle = wdetail.tiname               
        sic_bran.uwm100.name1  = wdetail.insnam               
        sic_bran.uwm100.name2  = wdetail.name2                           
        sic_bran.uwm100.name3  = ""                           
        sic_bran.uwm100.addr1  = wdetail.iadd1                
        sic_bran.uwm100.addr2  = wdetail.iadd2                
        sic_bran.uwm100.addr3  = wdetail.iadd3                
        sic_bran.uwm100.addr4  = wdetail.iadd4                
        sic_bran.uwm100.undyr  = String(Year(today),"9999")   /*   nv_undyr  */
        sic_bran.uwm100.branch = caps(trim(fi_branch))                    /* nv_branch  */                        
        sic_bran.uwm100.dept   = nv_dept
        sic_bran.uwm100.usrid  = USERID(LDBNAME(1))
        sic_bran.uwm100.fstdat = TODAY                        /*TODAY */
        sic_bran.uwm100.comdat = DATE(wdetail.comdat)
        sic_bran.uwm100.expdat = date(wdetail.expdat)
        sic_bran.uwm100.accdat = nv_accdat                    /*Shukiat T. 07/11/2006*/
        sic_bran.uwm100.tranty = "N"                          /*Transaction Type (N/R/E/C/T)*/
        sic_bran.uwm100.langug = "T"
        sic_bran.uwm100.acctim = "00:00"
        /*sic_bran.uwm100.trty11 = ""*//*A50-0202 Shukiat T. block on 14/08/2007*/
        sic_bran.uwm100.trty11 = "M"   /*A50-0202 Shukiat T. Modi  on 14/08/2007*/
        sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")      /*Shukiat T. 06/11/2006*/
        sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")
        sic_bran.uwm100.entdat = TODAY
        sic_bran.uwm100.curbil = "BHT"
        sic_bran.uwm100.curate = 1
        sic_bran.uwm100.instot = 1
        sic_bran.uwm100.prog   = "wgwargen"
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
        sic_bran.uwm100.acno1  = trim(fi_producer)   /*  nv_acno1 */
        sic_bran.uwm100.agent  = trim(fi_agent)      /*nv_agent   */
        /*uwm100.bs_cd  = fi_vatcode*/
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
        /*--A51-0071 Amparat C. --*/
        sic_bran.uwm100.drn_p =  IF wdetail.CoverNote = "CoverNote" THEN YES ELSE NO
        sic_bran.uwm100.sch_p =  IF wdetail.CoverNote = "CoverNote" THEN YES ELSE NO
        /***---a490166 ---***/
        sic_bran.uwm100.bchyr   = nv_batchyr          /*Batch Year */  
        sic_bran.uwm100.bchno   = nv_batchno          /*Batch No.  */  
        sic_bran.uwm100.bchcnt  = nv_batcnt           /*Batch Count*/  
        sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)    /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)     /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.postcd     = trim(wdetail.postcd)       /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.icno       = trim(wdetail.icno)         /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)      /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.br_insured = trim(wdetail.br_insured)   /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov)  /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.dealer     = trim(wdetail.financecd) .  /*Add by Kridtiya i. A63-0472*/

        /*sic_bran.uwm100.markflg = "Complete".*/     /*note block a490166 09/10/2006*/
        /*a490166*/  
        IF wdetail.renpol <> " " THEN DO:
            ASSIGN sic_bran.uwm100.prvpol  = trim(wdetail.renpol) /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                   sic_bran.uwm100.tranty  = "R".                 /*Transaction Type (N/R/E/C/T)*/
        END.
        /*Policy Flag*/
        IF wdetail.pass = "Y" THEN
            sic_bran.uwm100.impflg  = YES.
        ELSE 
            sic_bran.uwm100.impflg  = NO.
        IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN 
            sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
        IF wdetail.cancel ="ca" THEN
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
END.   /*transaction*/
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
    RUN wgw/wgwad120 (INPUT sic_bran.uwm100.policy, /***--- A490166 Note Modi ---***/
                      sic_bran.uwm100.rencnt,
                      sic_bran.uwm100.endcnt,
                      s_riskgp,
                      s_riskno,
                      OUTPUT  s_recid2).
    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
    END.  /* end not avail  uwm120 */
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
           sic_bran.uwm120.bchyr  = nv_batchyr      /* batch Year */
           sic_bran.uwm120.bchno  = nv_batchno      /* bchno      */
           sic_bran.uwm120.bchcnt = nv_batcnt .     /* bchcnt     */
       ASSIGN
           sic_bran.uwm120.class  = trim(wdetail.prempa + wdetail.subclass)
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
    
   FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE sicuw.uwm100.policy = wdetail.renpol
                           No-lock No-error no-wait.
                           IF AVAIL sicuw.uwm100  THEN DO:
                                 IF sicuw.uwm100.renpol <> " " THEN DO:
                                    MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
                                    ASSIGN
                                    wdetail.renpol  = "Already Renew" /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
                                    wdetail.comment = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว"
                                    WDETAIL.OK_GEN  = "N"
                                    wdetail.pass    = "N". /*a490166*/
                                    /*NEXT.*//*a490166 เอาเข้าหมด*/
                                END.
                                ELSE DO: /*Shukiat T. modi on 30/10/2006*/
                                /***--- a490166 ---***/
                                        ASSIGN
                                        n_rencnt  =  sicuw.uwm100.rencnt  +  1
                                        n_endcnt  =  0
                                        wdetail.pass    = "Y".
                                END.
                                
                         
                         /***--- a490166 Note Block งานต่ออายุยังไม่ทำ ณ ตอนนี้ ---***//***---
                         Message "กำลังจะทำการดึงข้อมูลใบเตือนต่ออายุจาก Expiry "  View-as alert-box.
                         n_policy  = wdetail.policy.
                         nv_poltyp = wdetail.poltyp.
                         
                         Run  wexp\wexpcnex.    /* connect  expiry  */ 
                         
                         /*------ส่วนของการหากรมธรรม์ใน Expiry Gen เป็นเบอร์ใหม่ใน Premium   -----------*/
                         Run  wuw\wuw7410n(Input  uwm100.policy, /*note copy program from proto 74101*/
                                           Input  n_policy,
                                           Input  nv_poltyp,
                                           Input  nv_undyr,
                                           Input-output   n_newpol,
                                           Input-output  s_RECID1,
                                           Input-output  s_RECID2,
                                           Input-output  s_RECID3,
                                           Input-output  s_RECID4,
                                           Input-output  nv_clmtext).
                         
                    
                          n_renew  =  Yes.
                          wdetail.policy =  n_newpol.
                          wdetail.comment = "COMPLETE".
                          wdetail.pass = "y".
                          wdetail.comment = "COMPLETE".
                          RUN wexp\wexpdisc.
                          /*tlt.nor_noti_ins   =   n_newpol.*/
                    
                          /*หากกรมธรรม์เก่าเพื่อใส่ renew pol เป็นเบอร์ใหม่ที่ได้จากการ gen ผ่านระบบ Expiry  */
                          Find last  uwm100 Use-index uwm10001 Where
                                     uwm100.policy  =  wdetail.renpol
                          No-error  no-wait.
                          If  avail  uwm100 Then  uwm100.renpol   =  n_newpol.
                          NEXT.
                          ---*//***---End Note Block a490166 ---***/
                      End.   /*  avail  buwm100  */
                      Else do:  
                            n_rencnt  =  0.
                            n_Endcnt  =  0.
                            Message    "เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  "
                            View-as alert-box.
                            /*--- a490166 ---*/
                            ASSIGN
                            wdetail.renpol  = "Not Found Previous Policy"
                            wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  "
                            WDETAIL.OK_GEN  = "N"
                            wdetail.pass    = "N". /*a490166*/
                            /*NEXT.*//*a490166 เอาเข้าหมด*/
                      END. /*not  avail uwm100*/

                      IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".
                      /*RUN wexp\wexpdisc.*//*a490166 note Block ชั่วคราว*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renewpol70 C-Win 
PROCEDURE proc_renewpol70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE sicuw.uwm100.policy = wdetail.renpol No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF sicuw.uwm100.renpol <> " " THEN DO:
        MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
        ASSIGN
            wdetail.renpol  = "Already Renew" 
            wdetail.comment = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว"
            WDETAIL.OK_GEN  = "N"
            wdetail.pass    = "N".  
    END.
    ELSE DO:  
        ASSIGN 
            n_rencnt  =  sicuw.uwm100.rencnt  +  1
            n_endcnt     =  0
            wdetail.pass = "Y".
        RUN proc_assignrenew.
    END.
END.
Else do:  
    n_rencnt  =  0.
    n_Endcnt  =  0.
    ASSIGN
        wdetail.renpol  = ""
        wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".  
END.
IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".
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
FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"  :
    NOT_pass = NOT_pass + 1.
END.

IF NOT_pass > 0 THEN DO:
/*a490166 05/10/2006 block*/
/* a = fi_FileName.              */
/* c = R-INDEX (a,".").          */
/* b = SUBSTR(a,1,c) + "err" .   */
/*                               */
OUTPUT STREAM ns1 TO value(fi_output2).
/*PUT STREAM ns2 "ID;PND" SKIP.*/
        PUT STREAM ns1
            "entry date"            ","  
            "entry time"            ","  
            "trans date"            ","  
            "trans time"            ","  
            "policy type"           ","  
            "policy"                ","  
            "rennew policy"         ","  
            "comdat"                ","  
            "expdat"                ","  
            "compulsory"            ","  
            "title name"            ","  
            "insure name"           ","  
            "insure add1"           ","  
            "insure add2"           ","  
            "insure add3"           ","  
            "insure add4"           ","  
            "premium pack"          ","  
            "subclass"              ","  
            "brand"                 ","  
            "model"                 ","  
            "cc"                    ","  
            "weight"                ","  
            "seat"                  ","  
            "body"                  ","  
            "vehicle register"      ","  
            "engine no"             ","  
            "chassis no"            ","  
            "car year"              ","  
            "car province"          ","  
            "vehicle use"           ","  
            "garage"                ","  
            "sticker"               ","  
            "accessories"           ","  
            "cover type"            ","  
            "sum insure"            ","  
            "voluntory premium"     ","  
            "Compulsory premmium"   ","  
            "fleet"                 ","  
            "ncb"                   ","  
            "load claim"            ","  
            "deduct da"             ","  
            "deduct pd"             ","  
            "benefit name"          ","  
            "user"                  ","  
            "IMPORT"               ","   
            "export"               ","   
            "driver name"          ","   
            "driver name1"         ","   
            "driver name2"         ","   
            "driver birth1"        ","   
            "driver birth2"        ","   
            "driver age1"          ","   
            "driver age2"          ","   
            "cancel"               ","
            "Redbook"              ","
            "Comment"              "," 
            "Warning"
        SKIP.

    FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"  :
        PUT STREAM ns1
     
        wdetail.entdat     ","
        wdetail.enttim     ","
        wdetail.trandat    ","
        wdetail.trantim    ","
        wdetail.poltyp     ","
        wdetail.policy     ","
        wdetail.renpol     ","
        wdetail.comdat     ","
        wdetail.expdat     "," 
        wdetail.compul     ","
        wdetail.tiname     ","
        wdetail.insnam     ","
        wdetail.iadd1      "," 
        wdetail.iadd2      ","
        wdetail.iadd3      ","
        wdetail.iadd4      ","
        wdetail.prempa     ","  
        wdetail.subclass   "," 
        wdetail.brand      ","  
        wdetail.model      ","  
        wdetail.cc         ","  
        wdetail.weight     ","  
        wdetail.seat       ","  
        wdetail.body       ","  
        wdetail.vehreg     ","        
        wdetail.engno      ","  
        wdetail.chasno     "," 
        wdetail.caryear    "," 
        wdetail.vehuse     ","               
        wdetail.garage     ","               
        wdetail.stk        ","               
        wdetail.access     "," 
        wdetail.covcod     "," 
        wdetail.si         "," 
        wdetail.volprem    "," 
        wdetail.Compprem   "," 
        wdetail.fleet      "," 
        wdetail.ncb        "," 
        wdetail.loadclm    "," 
        wdetail.deductda   "," 
        wdetail.deductpd   "," 
        wdetail.benname    "," 
        wdetail.n_user     "," 
        wdetail.n_IMPORT  "," 
        wdetail.n_export  "," 
        wdetail.drivnam   "," 
        wdetail.drivnam1  "," 
        wdetail.drivnam2  "," 
        wdetail.drivbir1  "," 
        wdetail.drivbir2  "," 
        wdetail.drivage1  "," 
        wdetail.drivage2  "," 
        wdetail.cancel    ","
        wdetail.redbook   ","
        wdetail.base      ","
        wdetail.accdat    ","
        wdetail.docno     ","
        wdetail.comment   ","
        wdetail.WARNING

    SKIP.  
                                                                                               
                                                                                               
END.                                                                                           
/*PUT STREAM ns2 "E". */                                                                           
OUTPUT STREAM ns1 CLOSE.                                                           
END. /*not pass = 0*/

END PROCEDURE.

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
/*a490166 block 05/10/2006*/
/* a = fi_FileName.                           */
/* c = R-INDEX (a,".").                       */
/* d = R-INDEX (a,"\").                       */
/* f = SUBSTR(a,(d + 1),(c - d)).             */
/* b = SUBSTR(a,1,d) + "safe_" + f + "CSV"  . */

OUTPUT STREAM ns2 TO value(fi_output1).
/*PUT STREAM ns2 "ID;PND" SKIP.*/
          PUT STREAM NS2
            "entry date"            ","  
            "entry time"            ","  
            "trans date"            ","  
            "trans time"            ","  
            "policy type"           ","  
            "policy"                ","  
            "rennew policy"         ","  
            "comdat"                ","  
            "expdat"                ","  
            "compulsory"            ","  
            "title name"            ","  
            "insure name"           ","  
            "insure add1"           ","  
            "insure add2"           ","  
            "insure add3"           ","  
            "insure add4"           ","  
            "premium pack"          ","  
            "subclass"              ","  
            "brand"                 ","  
            "model"                 ","  
            "cc"                    ","  
            "weight"                ","  
            "seat"                  ","  
            "body"                  ","  
            "vehicle register"      ","  
            "engine no"             ","  
            "chassis no"            ","  
            "car year"              ","  
            "car province"          ","  
            "vehicle use"           ","  
            "garage"                ","  
            "sticker"               ","  
            "accessories"           ","  
            "cover type"            ","  
            "sum insure"            ","  
            "voluntory premium"     ","  
            "Compulsory premmium"   ","  
            "fleet"                 ","  
            "ncb"                   ","  
            "load claim"            ","  
            "deduct da"             ","  
            "deduct pd"             ","  
            "benefit name"          ","  
            "user"                  ","  
            "IMPORT"               ","   
            "export"               ","   
            "driver name"          ","   
            "driver name1"         ","   
            "driver name2"         ","   
            "driver birth1"        ","   
            "driver birth2"        ","   
            "driver age1"          ","   
            "driver age2"          ","   
            "cancel"               ","
            "Redbook"              ","
            "Comment"              "," 
            "Warning"
        SKIP.

    FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
     
        wdetail.entdat     ","
        wdetail.enttim     ","
        wdetail.trandat    ","
        wdetail.trantim    ","
        wdetail.poltyp     ","
        wdetail.policy     ","
        wdetail.renpol     ","
        wdetail.comdat     ","
        wdetail.expdat     "," 
        wdetail.compul     ","
        wdetail.tiname     ","
        wdetail.insnam     ","
        wdetail.iadd1      "," 
        wdetail.iadd2      ","
        wdetail.iadd3      ","
        wdetail.iadd4      ","
        wdetail.prempa     ","  
        wdetail.subclass   "," 
        wdetail.brand      ","  
        wdetail.model      ","  
        wdetail.cc         ","  
        wdetail.weight     ","  
        wdetail.seat       ","  
        wdetail.body       ","  
        wdetail.vehreg     ","        
        wdetail.engno      ","  
        wdetail.chasno     "," 
        wdetail.caryear    ","             
        wdetail.vehuse     ","               
        wdetail.garage     ","               
        wdetail.stk        ","               
        wdetail.access     "," 
        wdetail.covcod     "," 
        wdetail.si         "," 
        wdetail.volprem    "," 
        wdetail.Compprem   "," 
        wdetail.fleet      "," 
        wdetail.ncb        "," 
        wdetail.loadclm    "," 
        wdetail.deductda   "," 
        wdetail.deductpd   "," 
        wdetail.benname    "," 
        wdetail.n_user     "," 
        wdetail.n_IMPORT  "," 
        wdetail.n_export  "," 
        wdetail.drivnam   "," 
        wdetail.drivnam1  "," 
        wdetail.drivnam2  "," 
        wdetail.drivbir1  "," 
        wdetail.drivbir2  "," 
        wdetail.drivage1  "," 
        wdetail.drivage2  "," 
        wdetail.cancel    ","
        wdetail.redbook   ","
        wdetail.base      ","
        wdetail.accdat    ","
        wdetail.docno     ","
        wdetail.comment   ","
        wdetail.WARNING
    SKIP.  
  END.                                                                                           
/*PUT STREAM ns2 "E". */                                                                           
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
"IMPORT TEXT FILE MOTOR ART (MOTOR LINE 70/72) " SKIP
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 C-Win 
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
    /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. /*db test.*/*/
    CLEAR FRAME nf00.
    HIDE FRAME nf00.
    RETURN. 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_usdcodnew C-Win 
PROCEDURE proc_usdcodnew :
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
/*ELSE nv_drivage1 = 0 .*/
FIND FIRST ws0m009 WHERE 
    ws0m009.policy  = nv_driver  AND
    ws0m009.lnumber = 2  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE ws0m009 THEN  ASSIGN  nv_drivage2 =  inte(replace(trim(substr(ws0m009.ltext2,11,5)),"-","")).
/*ELSE nv_drivage2 = 0 .*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var C-Win 
PROCEDURE proc_var :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    /* nv_camptyp =  "NORM"*/
    s_riskgp   =   0               s_riskno       =  1
    s_itemno   =   1               nv_undyr       =  String(Year(today),"9999")   
    n_rencnt   =   0               n_endcnt       =  0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

