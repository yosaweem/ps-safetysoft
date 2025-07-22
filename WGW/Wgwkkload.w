&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
/* Connected Databases : sic_test         PROGRESS                      */
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
cleanup will occur on deletion of the procedure.                                           */
CREATE WIDGET-POOL.   
/*******************************************************************************************/                                      
/*programid   : wgwkkren.w                                                                 */ 
/*programname : load text file KK to GW                                                    */ 
/* Copyright: Safety Insurance Public Company Limited บริษัท ประกันคุ้มภัย จำกัด (มหาชน) */ 
/*create by : Kridtiya i. A54-0351  date . 06/12/11                                      */ 
/*          เพิ่มโปรแกรมนำเข้างานต่ออายุ ธนาคารเกียรตินาคิน                            */ 
/*modify by : Kridtiya i. A55-0008  date . 06/01/12                                      */ 
/*          ปรับส่วนการหาเลขที่สัญญาที่ทำให้ระบบช้า                                    */ 
/*modify by : Kridtiya i. A55-0016  date . 16/01/12                                      */ 
/*          ปรับส่วนการออกงานสาขาตามไฟล์แจ้งและparameter[Setup Company and deler Code:]*/
/*modify by : Kridtiya i. A55-0029  date . 30/01/12 เช็คเลขที่สัญญาเพิ่ม เงื่อนไข งาน 70 */ 
/*modify by : Kridtiya i. A55-0104  date . 20/03/12 เพิ่มเงื่อนไขการแสดงค่าการซ่อม       */
/*modify by : Kridtiya i. A55-0114  date . 26/03/2012 ให้แปลงค่ารุ่นรถที่โปรแกรม Setupdeler*/
/*modify by : Kridtiya i. A58-0015  date.  13/01/2015 add message error icno ,add icno   */
/*modify by : Ranu i. A60-0232 date.  01/06/2017  เพิ่มตัวแปรรับค่าเพิ่ม   */
/*Modify by : Ranu i. A61-0335 date:11/07/2018 เพิ่มการเก็บข้อมูลจากไฟล์ */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019  Change Host => TMSth*/
/*Modify by : Ranu I. A63-0130 แก้ไข Pack T                */
/*Modify by : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by : Ranu I. A64-0138 แก้ไขการคำนวณเบี้ยที่โปรแกรมกลาง            */
/* proc_definitions */
/* ***************************  Definitions  ***********************************************/
/* Parameters Definitions ---                                                              */
/* Local Variable Definitions ---                                                          */  
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.  
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno.  
DEFINE STREAM  ns1.                   
DEFINE STREAM  ns2.                   
DEFINE STREAM  ns3.                   
DEF VAR nv_uom1_v AS INTE INIT 0.     
DEF VAR nv_uom2_v AS INTE INIT 0.     
DEF VAR nv_uom5_v AS INTE INIT 0.
DEF VAR dod0       AS DECI.
DEF VAR dod1       AS DECI.
DEF VAR dod2       AS DECI.
DEF VAR dpd0       AS DECI.
DEF SHARED Var   n_User    As CHAR . 
DEF VAR nv_comper  AS DECI INIT 0.                 
DEF VAR nv_comacc  AS DECI INIT 0.                 
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
DEF New  SHARED VAR nv_411      AS INTEGER      FORMAT ">>>,>>>,>>9".
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
DEF NEW SHARED VAR nv_tariff     LIKE sicuw.uwm301.tariff.
DEF NEW SHARED VAR nv_comdat     LIKE sicuw.uwm100.comdat.
DEF NEW SHARED VAR nv_covcod     LIKE sicuw.uwm301.covcod.
DEF NEW SHARED VAR nv_class      AS CHAR    FORMAT "X(5)".
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
DEF NEW SHARED VAR nv_sclass  AS CHAR FORMAT "x(4)".            
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
def NEW SHARED var  nv_branch     LIKE sicsyac.XMM023.BRANCH.  
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
{wgw\wgwkkload.i}      /*ประกาศตัวแปร*/
DEFINE VAR nv_txt1    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt6    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt7    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt8    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.
DEF VAR nv_nptr     AS RECID.
DEF VAR n_index AS INTE INIT 0 .
DEF VAR n_index2 AS INTE INIT 0.
DEF VAR n_prmtxt AS CHAR FORMAT "x(100)" INIT "".    /*A55-0114*/

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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.comment wdetail.poltyp wdetail.policy wdetail.prepol wdetail.branch wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.iadd1 wdetail.iadd2 wdetail.iadd3 wdetail.iadd4 wdetail.prempa wdetail.subclass wdetail.redbook wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.engno wdetail.chasno wdetail.caryear wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.volprem wdetail.fleet wdetail.ncb wdetail.access wdetail.deductpp wdetail.deductba wdetail.deductpa wdetail.benname wdetail.n_IMPORT wdetail.n_export wdetail.drivnam1 wdetail.drivnam wdetail.producer wdetail.agent WDETAIL.WARNING wdetail.cancel   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_bchno fi_branch fi_producer ~
fi_agent fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 ~
fi_output3 fi_usrcnt fi_usrprem buok bu_exit br_wdetail bu_hpbrn bu_hpacno1 ~
bu_hpagent RECT-368 RECT-370 RECT-372 RECT-373 RECT-374 RECT-375 RECT-376 ~
RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_show fi_loaddat fi_bchno fi_branch ~
fi_producer fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 ~
fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_proname fi_agtname ~
fi_completecnt fi_premtot fi_premsuc 

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
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.1.

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

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 65.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
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
     SIZE 25.33 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 65.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_show AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 86 BY 1
     BGCOLOR 3 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1.05
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-368
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 91.5 BY 1.52
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 123.5 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 123.5 BY 12.52
     BGCOLOR 29 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 123.5 BY 5.86
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 123.5 BY 3.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-375
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 121.5 BY 3.1
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 6 FGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail C-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.comment FORMAT "x(30)" COLUMN-BGCOLOR  80 
        wdetail.poltyp  COLUMN-LABEL "Policy Type"
        wdetail.policy  COLUMN-LABEL "Policy"
        wdetail.prepol  COLUMN-LABEL "Renew Policy"
        wdetail.branch  COLUMN-LABEL "BR"
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
        wdetail.redbook COLUMN-LABEL "RedBook"
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
        wdetail.covcod  COLUMN-LABEL "Cover Type"
        wdetail.si      COLUMN-LABEL "Sum Insure"
        wdetail.volprem COLUMN-LABEL "Voluntory Prem"
        wdetail.fleet   COLUMN-LABEL "Fleet"
        wdetail.ncb     COLUMN-LABEL "NCB"
        wdetail.access COLUMN-LABEL "Load Claim"
        wdetail.deductpp  COLUMN-LABEL "Deduct TP"
        wdetail.deductba   COLUMN-LABEL "Deduct DA"
        wdetail.deductpa   COLUMN-LABEL "Deduct PD"
        wdetail.benname COLUMN-LABEL "Benefit Name" 
        wdetail.n_IMPORT COLUMN-LABEL "Import"
        wdetail.n_export COLUMN-LABEL "Export"
        wdetail.drivnam1 COLUMN-LABEL "Driver Name1"
        wdetail.drivnam  COLUMN-LABEL "Driver Name2"
        wdetail.producer COLUMN-LABEL "Producer"
        wdetail.agent    COLUMN-LABEL "Agent"
        WDETAIL.WARNING   COLUMN-LABEL "Warning"
        wdetail.cancel  COLUMN-LABEL "Cancel"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 122 BY 5.33
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_show AT ROW 13.95 COL 16.5 NO-LABEL
     fi_loaddat AT ROW 2.76 COL 29 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.29 COL 14.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_branch AT ROW 3.86 COL 29 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.86 COL 29 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 5.91 COL 29 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 6.91 COL 29 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 6.91 COL 67.33 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 7.95 COL 29 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 7.95 COL 91.33
     fi_output1 AT ROW 9 COL 29 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 10.05 COL 29 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 11.14 COL 29 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 12.52 COL 37.33 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 12.48 COL 77.67 NO-LABEL
     buok AT ROW 7.86 COL 104.67
     bu_exit AT ROW 9.76 COL 104.67
     fi_brndes AT ROW 3.76 COL 42.67 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 15.29 COL 2.33
     bu_hpbrn AT ROW 3.81 COL 38
     bu_hpacno1 AT ROW 4.81 COL 46.17
     fi_impcnt AT ROW 21.71 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpagent AT ROW 5.86 COL 46.17
     fi_proname AT ROW 4.81 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 5.86 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 22.71 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 21.71 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 22.76 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     "                    Branch  :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 3.76 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    IMPORT TEXT FILE MOTOR KK ALL" VIEW-AS TEXT
          SIZE 123 BY 1.33 AT ROW 1.14 COL 1.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 12.52 COL 95.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 22.71 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "24/07/2023":60 VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 12.52 COL 103.67 WIDGET-ID 2
          BGCOLOR 29 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY 1 AT ROW 6.95 COL 68 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 21.71 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 22.71 COL 116.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 7.95 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "             Agent Code  :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 5.86 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.71 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 2.71 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY 1.05 AT ROW 12.52 COL 75.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 124.5 BY 23.76
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "BHT.":60 VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 21.71 COL 116.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "         Producer  Code :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 4.81 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "       Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 11.14 COL 6.5
          BGCOLOR 8 FGCOLOR 1 
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 21.71 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 20 BY 1.05 AT ROW 12.52 COL 36.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Previous Batch No. :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 6.91 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY 1.05 AT ROW 10.05 COL 6.5
          BGCOLOR 8 FGCOLOR 1 
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 9 COL 6.5
          BGCOLOR 8 FGCOLOR 1 
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.29 COL 4.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-368 AT ROW 12.33 COL 11.5
     RECT-370 AT ROW 1 COL 1.5
     RECT-372 AT ROW 2.52 COL 1.5
     RECT-373 AT ROW 15.05 COL 1.5
     RECT-374 AT ROW 20.91 COL 1.5
     RECT-375 AT ROW 21.24 COL 2.5
     RECT-376 AT ROW 21.48 COL 3.83
     RECT-377 AT ROW 7.62 COL 103.5
     RECT-378 AT ROW 9.48 COL 103.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 124.5 BY 23.76
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
         TITLE              = "Load Text File KK 70,72"
         HEIGHT             = 23.86
         WIDTH              = 124.17
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
/* SETTINGS FOR FILL-IN fi_show IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.83 BY 1 AT ROW 6.95 COL 68 RIGHT-ALIGNED              */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 20 BY 1.05 AT ROW 12.52 COL 36.5 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY 1.05 AT ROW 12.52 COL 75.17 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 21.71 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 21.71 COL 95.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.71 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 22.71 COL 96 RIGHT-ALIGNED          */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

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

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Load Text File KK 70,72 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Load Text File KK 70,72 */
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
  /*  DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    IF WDETAIL.WARNING <> "" THEN DO:

          /*wdetail.entdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.enttim:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.trandat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.trantim:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. *//*a490166*/
          wdetail.comment:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.poltyp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
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
          wdetail.redbook:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
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
          wdetail.fleet:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.     
          wdetail.ncb:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.access :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.deductpp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductba:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductpa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductpa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.benname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.n_IMPORT:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_export:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivnam1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivnam :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.producer:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.agent:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          WDETAIL.CANCEL:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  /*new add*/ 
          wdetail.prepol:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  


          /*wdetail.entdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.enttim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trandat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trantim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. *//*a490166*/ 
          wdetail.comment:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.poltyp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
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
          wdetail.redbook:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
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
          wdetail.fleet:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.ncb:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.access:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
          wdetail.deductpp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductba:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductpa:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.benname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_IMPORT:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_export:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivnam1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.drivnam :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.producer:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.agent:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          WDETAIL.WARNING:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          WDETAIL.CANCEL:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.prepol:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  /*new add*/
            
  END.*/
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
        fi_impcnt              = 0 .
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
        FIND LAST uzm700 USE-INDEX uzm70001
            WHERE uzm700.acno    = TRIM(fi_producer)  AND
                  uzm700.branch  = "M"    AND
                  uzm700.bchyr   = nv_batchyr         NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:   
            nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102 
                WHERE uzm701.bchno = trim(fi_producer) + "M" + string(nv_batrunno,"9999") 
                NO-LOCK NO-ERROR.
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
        nv_batchno = CAPS(fi_producer) + "M" + STRING(nv_batrunno,"9999").
    END.
    ELSE DO:  
        nv_batprev = INPUT fi_prevbat.
        FIND LAST uzm701 USE-INDEX uzm70102 
            WHERE uzm701.bchno = CAPS(nv_batprev)
            NO-LOCK NO-ERROR NO-WAIT.
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
        nv_batbrn    = "M" .
    For each  wdetail :
        DELETE  wdetail.
    End.
    For each  wdetail2 :
        DELETE  wdetail2.
    End.
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
       wdetail2.n_EXPORT = "" .   */
    FOR EACH wdetail:    
        IF WDETAIL.POLTYP = "70" OR WDETAIL.POLTYP = "72" THEN DO:
            ASSIGN
                nv_reccnt      =  nv_reccnt   + 1
                nv_netprm_t    =  nv_netprm_t + decimal(wdetail.volprem) 
                wdetail.pass   = "Y"
                WDETAIL.POLTYP = "V" + WDETAIL.POLTYP.     
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
                           INPUT            "WGWKKLOAD" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem       /* DECI  */
                           ).
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
    /*output*/
     
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.

     IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno    :FGCOLOR = 6. 

        ASSIGN fi_show = "Please check Data again...ERROR.."  .
       

        DISP fi_show fi_completecnt fi_premsuc WITH FRAME fr_main.
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

        ASSIGN fi_show = "Process Complete.....".
        DISP fi_show WITH FRAM fr_main.
        
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.
    RUN proc_open.
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    
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
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS    /* "CSV (Comma Delimited)"   "*.csv",
                            "Data Files (*.dat)"     "*.dat",*/
                    "Text Files (*.txt)" "*.csv"
                    
                            
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
   Run  whp\whpbrn01(Input-output  fi_branch, /*a490166 note modi*/
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
    /*ASSIGN fi_agent = "B3M0006".*/
    ASSIGN fi_agent = "B3MLKK0100".
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


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
  fi_loaddat  =  Input  fi_loaddat.
  Disp  fi_loaddat  with  frame  fr_main.
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


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    ASSIGN fi_producer = "A0M1053".
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
                /*nv_producer = fi_producer*/   .             /*note add  08/11/05*/
                
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
  
  gv_prgid = "WGWKKLOAD".
  gv_prog  = "Load Text & Generate (KK-ต่ออายุโอนย้าย)".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).    
  ASSIGN
      fi_branch   = "ML"
      /*fi_producer = "A0M1005"    */ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
      /*fi_agent    = "B3M0006"    */ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
      fi_producer = "B3MLKK0101"      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
      fi_agent    = "B3MLKK0100"      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
      fi_bchyr    = YEAR(TODAY) 
      fi_show     = "Load Text file KK-Renew ............. ".
  RUN proc_comp.
  DISP fi_branch fi_producer fi_agent fi_bchyr fi_show WITH FRAME fr_main.
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_mailtxt C-Win 
PROCEDURE 00-proc_mailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0076.....
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
  
  nv_drivage1 =  YEAR(TODAY) - (INT(SUBSTR(wdetail.drivbir1,7,4)) - 543). 
  nv_drivage2 =  YEAR(TODAY) - (INT(SUBSTR(wdetail.drivbir2,7,4)) - 543). 

  IF wdetail.drivbir1 <> " "  AND wdetail.drivnam1 <> " " THEN DO: /*note add & modified*/
     nv_drivbir1      = STRING(INT(SUBSTR(wdetail.drivbir1,7,4))).
     wdetail.drivbir1 = SUBSTR(wdetail.drivbir1,1,6) + nv_drivbir1.
  END.

  IF wdetail.drivbir2 <>  " " AND wdetail.drivnam2 <> " " THEN DO: /*note add & modified */
     nv_drivbir2      = STRING(INT(SUBSTR(wdetail.drivbir2,7,4))).
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
                     brstat.mailtxt_fil.ltext     = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)). 
                     brstat.mailtxt_fil.ltext2    = wdetail.drivbir1 + "  " 
                                                  + string(nv_drivage1).
                     nv_drivno                    = 1.
                     ASSIGN /*a490166*/
                     brstat.mailtxt_fil.bchyr = nv_batchyr 
                     brstat.mailtxt_fil.bchno = nv_batchno 
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                     SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"  
                     SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = "-"        
                     SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.drivid1)     . 
              IF wdetail.drivnam2 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil. 
                    ASSIGN
                        brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                        brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                        brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)). 
                        brstat.mailtxt_fil.ltext2   = wdetail.drivbir2 + "  "
                                                    + string(nv_drivage2). 
                        nv_drivno                   = 2.
                        ASSIGN /*a490166*/
                        brstat.mailtxt_fil.bchyr = nv_batchyr 
                        brstat.mailtxt_fil.bchno = nv_batchno 
                        brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                        SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
                        SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = "-"        
                        SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.drivid2)     . 
              END.  /*drivnam2 <> " " */
        END. /*End Avail Brstat*/
        ELSE  DO:
              CREATE  brstat.mailtxt_fil.
              ASSIGN  brstat.mailtxt_fil.policy     = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
                      brstat.mailtxt_fil.lnumber    = nv_lnumber
                      brstat.mailtxt_fil.ltext      = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)) 
                      brstat.mailtxt_fil.ltext2     = wdetail.drivbir1 + "  " +  TRIM(string(nv_drivage1))
                      brstat.mailtxt_fil.bchyr      = nv_batchyr 
                      brstat.mailtxt_fil.bchno      = nv_batchno 
                      brstat.mailtxt_fil.bchcnt     = nv_batcnt 
                      SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-" 
                      SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = "-"        
                      SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.drivid1)     .

                      IF wdetail.drivnam2 <> "" THEN DO:
                            CREATE  brstat.mailtxt_fil.
                                ASSIGN
                                brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                                brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)). 
                                brstat.mailtxt_fil.ltext2   = wdetail.drivbir2 + "  "
                                                            + TRIM(string(nv_drivage2)).
                                ASSIGN /*a490166*/
                                brstat.mailtxt_fil.bchyr = nv_batchyr 
                                brstat.mailtxt_fil.bchno = nv_batchno 
                                brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-" 
                                SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = "-"        
                                SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.drivid2)     .
                      END. /*drivnam2 <> " " */
        END. /*Else DO*/
 END. /*note add for mailtxt 07/11/2005*/
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
  DISPLAY fi_show fi_loaddat fi_bchno fi_branch fi_producer fi_agent fi_prevbat 
          fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt 
          fi_usrprem fi_brndes fi_impcnt fi_proname fi_agtname fi_completecnt 
          fi_premtot fi_premsuc 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loaddat fi_bchno fi_branch fi_producer fi_agent fi_prevbat fi_bchyr 
         fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt 
         fi_usrprem buok bu_exit br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent 
         RECT-368 RECT-370 RECT-372 RECT-373 RECT-374 RECT-375 RECT-376 
         RECT-377 RECT-378 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72 C-Win 
PROCEDURE proc_72 :
IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass            = "N"
        wdetail.OK_GEN          = "N". 
END.
IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk <> "" THEN DO:    
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + trim(wdetail.stk).
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN 
            wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
            wdetail.pass    = ""
            wdetail.OK_GEN  = "N".
    END.
END.
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class  = wdetail.subclass  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN 
    wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
    wdetail.pass    = "N"
    wdetail.OK_GEN  = "N".
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp  AND
        sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN 
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
        wdetail.OK_GEN  = "N".
END.
IF wdetail.branch = ""  THEN
    ASSIGN 
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| สาขาเป็นค่าว่าง  "
        wdetail.OK_GEN  = "N".
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
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod  NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  
    wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
    wdetail.OK_GEN = "N".
/*--------- modcod --------------*/
IF wdetail.redbook = ""  THEN RUN proc_redbook72.
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
        sicuw.uwm100.trty11 = "M"                             AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999") NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN 
        ASSIGN     /*a490166*/     
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 C-Win 
PROCEDURE proc_722 :
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
        sic_bran.uwm301.bchyr = nv_batchyr                      AND 
        sic_bran.uwm301.bchno = nv_batchno                      AND 
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
        sic_bran.uwm301.cha_no  = trim(wdetail.chasno) 
        sic_bran.uwm301.trareg  = trim(wdetail.chasno)  /*A60-0232*/
        sic_bran.uwm301.eng_no  = wdetail.engno
        sic_bran.uwm301.Tons    = INTEGER(wdetail.weight)
        sic_bran.uwm301.engine  = deci(wdetail.cc)                    
        sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage  = wdetail.garage
        sic_bran.uwm301.body    = wdetail.body
        sic_bran.uwm301.seats   = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = ""
        sic_bran.uwm301.vehreg   = wdetail.vehreg 
        sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model 
        sic_bran.uwm301.modcod   = wdetail.redbook 
        sic_bran.uwm301.sckno    = 0              
        sic_bran.uwm301.itmdel   = NO
        sic_bran.uwm301.bchyr    = nv_batchyr         /* batch Year */      
        sic_bran.uwm301.bchno    = nv_batchno         /* bchno    */      
        sic_bran.uwm301.bchcnt   = nv_batcnt          /* bchcnt     */ 
        /* A67-0076 */
        sic_bran.uwm301.watts     = deci(wdetail.hp)  
        sic_bran.uwm301.maksi     = INTE(wdetail.maksi)      
        sic_bran.uwm301.eng_no2   = IF LENGTH(wdetail.eng) > 25 THEN TRIM(substr(wdetail.eng,25,LENGTH(wdetail.eng))) ELSE ""
        sic_bran.uwm301.battper   = INTE(wdetail.battper)
        /*sic_bran.uwm301.battrate  = INTE(wdetail.battrate)*/
        sic_bran.uwm301.battyr    = INTE(wdetail.battyr)  
        /*sic_bran.uwm301.battsi    = INTE(wdetail.battsi)
        sic_bran.uwm301.battprice = deci(wdetail.battprice)*/
        sic_bran.uwm301.battno    = wdetail.battno 
        sic_bran.uwm301.chargno   = wdetail.chargno 
        /*sic_bran.uwm301.chargsi   = deci(wdetail.chargsi)*/ .
        /* end : A67-0076 */
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
    IF wdetail.redbook <> "" THEN DO:   /*กรณีที่มีการระบุ Code รถมา*/
        FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
            sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102 THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod         = sicsyac.xmm102.modcod
                sic_bran.uwm301.Tons           = sicsyac.xmm102.tons
                sic_bran.uwm301.vehgrp         = sicsyac.xmm102.vehgrp
                wdetail.redbook                = sicsyac.xmm102.modcod
                wdetail.brand                  = SUBSTRING(xmm102.modest, 1,18) .  /*Thai*/
               
        END.
    END.
    ELSE DO:
        ASSIGN
        nv_simat = DECI(wdetail.si) - (DECI(wdetail.si) * 20 / 100 )
        nv_simat1 = DECI(wdetail.si) + (DECI(wdetail.si) * 20 / 100 )  .
        FIND LAST sicsyac.xmm102 WHERE 
            INDEX(sicsyac.xmm102.modest,wdetail.brand) <> 0 AND
            INDEX(sicsyac.xmm102.modest,n_model) <> 0 AND
            sicsyac.xmm102.seats  >= INTE(wdetail.seat) NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102  THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod         = sicsyac.xmm102.modcod
                sic_bran.uwm301.Tons           = sicsyac.xmm102.tons  
                sic_bran.uwm301.body           = sicsyac.xmm102.body 
                sic_bran.uwm301.vehgrp         = sicsyac.xmm102.vehgrp
                wdetail.weight                 = string(sicsyac.xmm102.tons)  
                wdetail.cc                     = string(sicsyac.xmm102.engine)
                wdetail.redbook                = sicsyac.xmm102.modcod
                wdetail.brand                  = SUBSTRING(xmm102.modest, 1,18)    .  /*Thai*/
        END.
    END.
    /*add A52-0172*/
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
      sic_bran.uwd132.policy  = wdetail.policy         /*Policy No. - uwm130*/
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
            ELSE MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addresstax C-Win 
PROCEDURE proc_addresstax :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
   /* ชื่อที่อยู่ออกใบเสร็จ */
   IF (TRIM(wdetail.firstName) =  trim(wdetail.reci_name1)  AND                   
      TRIM(wdetail.lastName)   =  trim(wdetail.reci_name2)  AND 
      trim(wdetail.iadd1)      <> trim(wdetail.reci_1) )    OR
      (TRIM(wdetail.firstName) <> trim(wdetail.reci_name1)  AND
      TRIM(wdetail.lastName)   <> trim(wdetail.reci_name2)) THEN DO:
      ASSIGN 
       sicsyac.xmm600.nntitle    = trim(wdetail.reci_title) 
       sicsyac.xmm600.nfirstname = trim(wdetail.reci_name1) 
       sicsyac.xmm600.nlastname  = trim(wdetail.reci_name2) 
       sicsyac.xmm600.nphone     = trim(wdetail.reci_title) + " " + trim(wdetail.reci_name1) + " " + trim(wdetail.reci_name2)
       sicsyac.xmm600.nicno      = trim(wdetail.tax)   
       sicsyac.xmm600.nbr_insure = "00000"   
       sicsyac.xmm600.naddr1     = trim(wdetail.reci_1)      
       sicsyac.xmm600.naddr2     = trim(wdetail.reci_2)     
       sicsyac.xmm600.naddr3     = trim(wdetail.reci_3)     
       sicsyac.xmm600.naddr4     = trim(wdetail.reci_4)     
       sicsyac.xmm600.npostcd    = trim(wdetail.reci_5)     
       sicsyac.xmm600.anlyc1     = "" .
   END.
   ELSE DO:
       ASSIGN 
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
   END.
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
        FIND LAST sic_bran.uwd132  USE-INDEX uwd13201 WHERE
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

               ASSIGN fi_show = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
               DISP fi_show WITH FRAM fr_main. 
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
              
               
               IF SUBSTR(sic_bran.uwd132.bencod,1,3) = "GRP" AND wdetail.cargrp <> "" THEN DO:
                   ASSIGN   sic_bran.uwd132.bencod = nv_grpcod
                            sic_bran.uwd132.benvar = nv_grpvar .
               END.
               IF sic_bran.uwd132.bencod = "SI" AND wdetail.covcod = "2"  THEN ASSIGN SUBSTRING(sic_bran.uwd132.benvar,31,30) = "0". /* A65-0288*/
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
            
       DELETE stat.pmuwd132.   /* delete pmuwd132 */
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
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail2.
    IMPORT DELIMITER "|" 
        wdetail2.recno         /* ลำดับที่                     */
        wdetail2.Notify_dat    /* วันที่รับแจ้ง                */
        wdetail2.recive_dat    /* วันที่รับเงินค่าเบิ้ยประกัน  */
        wdetail2.comp_code     /* รายชื่อบริษัทประกันภัย       */
        wdetail2.cedpol        /* เลขที่สัญญาเช่าซื้อ          */
        wdetail2.typpol        /* New/Renew                    */
        wdetail2.prepol        /* เลขที่กรมธรรม์เดิม           */
        wdetail2.cmbr_no       /* รหัสสาขา                     */
        wdetail2.cmbr_code     /* สาขา KK                      */
        wdetail2.brtms         /* สาขา TMSTH                   */
        wdetail2.notifyno      /* เลขรับเเจ้ง                  */
        wdetail2.kkflag        /* KK offer */
        wdetail2.campaigno     /* Campaign                     */
        wdetail2.campaigsub    /* Sub Campaign                 */
        wdetail2.typper        /* บุคคล/นิติบุคคล              */
        wdetail2.n_TITLE       /* คำนำหน้าชื่อ                 */
        wdetail2.n_name1       /* ชื่อผู้เอาประกัน             */
        wdetail2.n_name2       /* นามสกุลผู้เอาประกัน          */
        wdetail2.ADD_1         /* บ้านเลขที่                   */
        wdetail2.ADD_2         /* ตำบล/แขวง                    */
        wdetail2.ADD_3         /* อำเภอ/เขต                    */
        wdetail2.ADD_4         /* จังหวัด                      */
        wdetail2.ADD_5         /* รหัสไปรษณีย์                 */
        wdetail2.cover         /* ประเภทความคุ้มครอง           */
        wdetail2.garage        /* ประเภทการซ่อม                */
        wdetail2.comdat        /* วันเริ่มคุ้มครอง             */
        wdetail2.expdat        /* วันสิ้นสุดคุ้มครอง           */
        wdetail2.subclass      /* รหัสรถ                       */
        wdetail2.n_43          /* ประเภทประกันภัยรถยนต์        */
        wdetail2.brand         /* ชื่อยี่ห้อรถ                 */
        wdetail2.model         /* รุ่นรถ                       */
        wdetail2.nSTATUS       /* New/Used                     */
        wdetail2.licence       /* เลขทะเบียน                   */
        wdetail2.province       /* จังหวัดจดทะเบียน             */
        wdetail2.chassis       /* เลขตัวถัง                    */
        wdetail2.engine        /* เลขเครื่องยนต์              */
        wdetail2.cyear         /* ปีรถยนต์                    */
        wdetail2.power         /* ซีซี                        */
        wdetail2.hp            /* แรงม้า */                         /* A67-0076 */
        wdetail2.weight        /* น้ำหนัก/ตัน                 */
        wdetail2.seat          /* ที่นั่ง */
        wdetail2.ins_amt1      /* ทุนประกันปี 1               */
        wdetail2.netprem       /* เบี้ยสุทธิ                  */
        wdetail2.prem1         /* เบี้ยรวมภาษีเเละอากรปี 1    */
        wdetail2.time_notify   /* เวลารับเเจ้ง                */
        wdetail2.NAME_mkt      /* ชื่อเจ้าหน้าที่ MKT         */
        wdetail2.bennam        /* หมายเหตุ                    */
        wdetail2.drititle1     /* คำนำหน้าชื่อ */             /* A67-0076 */
        wdetail2.drivno1       /* ผู้ขับขี่ที่ 1              */
        wdetail2.drivdat1      /* วันเกิดผู้ขับขี่ 1          */
        wdetail2.drivid1       /* เลขที่ใบขับขี่ 1            */
        wdetail2.drigender1     /* A67-0076 */
        wdetail2.drioccup1      /* A67-0076 */
        wdetail2.driICNo1       /* A67-0076 */ 
        wdetail2.drilevel1      /* A67-0076 */
        wdetail2.drititle2      /* A67-0076 */ 
        wdetail2.drivno2       /* ผู้ขับขี่ที่ 2              */
        wdetail2.drivdat2      /* วันเกิดผู้ขับขี่ 2          */
        wdetail2.drivid2       /* เลขที่ใบขับขี่ 2            */
        /* add : A67-0076 */
        wdetail2.drigender2      
        wdetail2.drioccup2 
        wdetail2.driICNo2
        wdetail2.drilevel2
        wdetail2.drilic3         
        wdetail2.drititle3       
        wdetail2.driname3        
        wdetail2.drivno3         
        wdetail2.drigender3      
        wdetail2.drioccup3 
        wdetail2.driICNo3
        wdetail2.drilevel3
        wdetail2.drilic4         
        wdetail2.drititle4       
        wdetail2.driname4        
        wdetail2.drivno4         
        wdetail2.drigender4      
        wdetail2.drioccup4
        wdetail2.driICNo4
        wdetail2.drilevel4
        wdetail2.drilic5         
        wdetail2.drititle5       
        wdetail2.driname5        
        wdetail2.drivno5         
        wdetail2.drigender5      
        wdetail2.drioccup5
        wdetail2.driICNo5
        wdetail2.drilevel5
        /* end : A67-0076 */
        wdetail2.reci_title    /* คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี) */
        wdetail2.reci_name1    /* ชื่อ (ใบเสร็จ/ใบกำกับภาษี)         */
        wdetail2.reci_name2    /* นามสกุล (ใบเสร็จ/ใบกำกับภาษี)      */
        wdetail2.reci_1        /* บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)   */
        wdetail2.reci_2        /* ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)    */
        wdetail2.reci_3        /* อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)    */
        wdetail2.reci_4        /* จังหวัด (ใบเสร็จ/ใบกำกับภาษี)      */
        wdetail2.reci_5        /* รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี) */
        wdetail2.ncb           /* ส่วนลดประวัติดี             */
        wdetail2.fleet         /* ส่วนลดงาน Fleet             */
        wdetail2.phone         /* เบอร์ติดต่อ                 */
        wdetail2.icno          /* เลขที่บัตรประชาชน           */
        wdetail2.bdate         /* วันเดือนปีเกิด              */
        wdetail2.occup         /* อาชีพ                       */
        wdetail2.cstatus       /* สถานภาพ                     */
        wdetail2.gender        /* เพศ   */ 
        wdetail2.nation        /* สัญชาติ   */ 
        wdetail2.email         /* เมล์   */ 
        wdetail2.tax           /* เลขประจำตัวผู้เสียภาษีอากร  */
        wdetail2.tname1        /* คำนำหน้าชื่อ 1              */
        wdetail2.cname1        /* ชื่อกรรมการ 1               */
        wdetail2.lname1        /* นามสกุลกรรมการ 1            */
        wdetail2.icno1         /* เลขที่บัตรประชาชนกรรมการ 1  */
        wdetail2.tname2        /* คำนำหน้าชื่อ 2              */
        wdetail2.cname2        /* ชื่อกรรมการ 2               */
        wdetail2.lname2        /* นามสกุลกรรมการ 2            */
        wdetail2.icno2         /* เลขที่บัตรประชาชนกรรมการ 2  */
        wdetail2.tname3        /* คำนำหน้าชื่อ 3              */
        wdetail2.cname3        /* ชื่อกรรมการ 3               */
        wdetail2.lname3        /* นามสกุลกรรมการ 3            */
        wdetail2.icno3         /* เลขที่บัตรประชาชนกรรมการ 3  */
        wdetail2.nsend         /* จัดส่งเอกสารที่สาขา         */
        wdetail2.sendname      /* ชื่อผู้รับเอกสาร            */
        wdetail2.bennefit      /* ผู้รับผลประโยชน์            */
        wdetail2.KKapp         /* KK ApplicationNo            */
        wdetail2.remak1        /* Remak1                      */
        wdetail2.remak2        /* Remak2                      */
        wdetail2.dealercd      /* Dealer KK                    */
        wdetail2.dealtms       /* Dealer TMSTH                  */
        wdetail2.packcod       /* Campaignno TMSTH            */
        wdetail2.campOV        /* Campaign OV                 */
        wdetail2.producer      /* Producer code      */
        wdetail2.Agent         /* Agent code        */
        wdetail2.RefNo         /*ReferenceNo  */
        wdetail2.KKQuo         /* KK Quotation No.*/
        wdetail2.RiderNo       /* Rider  No.  */
        wdetail2.releas        /* Release                     */
        wdetail2.loandat       /* Loan First Date             */
        /* add by : A65-0288 */
        wdetail2.PolPrem           /*Policy Premium   */
        wdetail2.UnProblem     /*Note Un Problem  */
        wdetail2.colors        /* color  */
        wdetail2.Insp          /* ตรวจสภาพ */
        wdetail2.Inspsts       /* สถานะกล่องตรวจสภาพ*/
        wdetail2.InspNo        /* เลขกล่อง*/
        wdetail2.InspClosed    /* วันที่ปิดเรื่อง*/
        wdetail2.InspDetail    /* ผลตรวจสภาพ*/
        wdetail2.inspDamg      /* รายการความเสียหาย*/
        wdetail2.inspAcc      /* อุปกรณ์เสริม */
        /* end : A65-0288 */
        /* A67-0076 */
        wdetail2.dateregis       
        wdetail2.pay_option      
        wdetail2.battno          
        wdetail2.battyr          
        wdetail2.maksi           
        wdetail2.chargno         
        wdetail2.veh_key .
        /*  end : A67-0076 */

    IF index(wdetail2.recno,"ที่") <> 0 THEN DELETE wdetail2.
    ELSE IF INDEX(wdetail2.recno,"คุ้มภัย") <> 0 THEN DELETE wdetail2.
    ELSE IF wdetail2.recno = " "  THEN DELETE wdetail2.

END.                      /*-Repeat-*/
ASSIGN fi_show = "Import Text file to GW......".
DISP fi_show WITH FRAM fr_main.
RUN proc_assign2.
RUN proc_assign3.

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
DEF VAR n_comdate AS CHAR INIT "" .
DEF VAR n_vehpro AS CHAR FORMAT "x(50)" INIT "". /*A64-0138*/
FOR EACH wdetail2 .
    ASSIGN n_comdate = "" .
    IF  (index(wdetail2.recno,"บริษัท") <> 0 ) OR
        (index(wdetail2.recno,"ลำดับ") <> 0)   THEN DELETE wdetail2.
    ELSE DO:
        /*IF wdetail2.cedpol NE "" THEN DO: */ /*A67-0198*/
            /* check branch */
            IF wdetail2.brtms <> ""  THEN DO:
               /* FIND LAST sicsyac.xmm023 WHERE sicsyac.xmm023.branch = trim(wdetail2.brtms) NO-LOCK NO-ERROR.
                IF AVAIL sicsyac.xmm023 THEN DO:
                ASSIGN wdetail2.branch = sicsyac.xmm023.branch .*/

                FIND FIRST stat.insure USE-INDEX insure03 WHERE                                        
                    stat.insure.compno = "kk"                              AND                         
                    index(trim(wdetail2.brtms),trim(stat.insure.fname)) <> 0 NO-LOCK NO-ERROR NO-WAIT. 
                IF AVAIL stat.insure THEN ASSIGN wdetail2.branch  = CAPS(stat.insure.branch) . 
                ELSE ASSIGN wdetail2.branch  = "" .
            END.
               /* ELSE DO:
                    FIND FIRST stat.insure USE-INDEX insure03 WHERE 
                        stat.insure.compno = "kk"                              AND
                        index(trim(wdetail2.brtms),trim(stat.insure.fname)) <> 0 NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL stat.insure THEN ASSIGN wdetail2.branch  = CAPS(stat.insure.branch) . 
                    ELSE DO:
                        FIND FIRST stat.insure USE-INDEX insure03 WHERE 
                            stat.insure.compno = "kk"                              AND
                            index(trim(wdetail2.cmbr_no),trim(stat.insure.fname)) <> 0 NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL stat.insure THEN
                            ASSIGN   wdetail2.branch  = CAPS(stat.insure.branch) .
                        ELSE DO:
                            FIND FIRST stat.insure USE-INDEX insure03 WHERE 
                                stat.insure.compno = "kk"                              AND
                                index(trim(wdetail2.cmbr_no),stat.insure.insno)   <> 0 NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL stat.insure THEN
                                ASSIGN   wdetail2.branch  = CAPS(stat.insure.branch) .
                            ELSE 
                                ASSIGN   wdetail2.branch = "" .
                        END.
                    END.
                END.
            END.*/
            /* สาขา KK 
            ELSE DO:
                FIND FIRST stat.insure USE-INDEX insure03 WHERE 
                    stat.insure.compno = "kk"                              AND
                    index(trim(wdetail2.cmbr_no),stat.insure.insno)   <> 0 AND
                    index(trim(wdetail2.cmbr_no),trim(stat.insure.fname)) <> 0 NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL stat.insure THEN 
                    ASSIGN wdetail2.branch  = CAPS(stat.insure.branch). 
                ELSE DO:
                    FIND FIRST stat.insure USE-INDEX insure03 WHERE 
                        stat.insure.compno = "kk"                              AND
                        index(trim(wdetail2.cmbr_no),trim(stat.insure.fname)) <> 0 NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL stat.insure THEN
                        ASSIGN   wdetail2.branch  = CAPS(stat.insure.branch) .
                    ELSE DO:
                        FIND FIRST stat.insure USE-INDEX insure03 WHERE 
                            stat.insure.compno = "kk"                              AND
                            index(trim(wdetail2.cmbr_no),stat.insure.insno)   <> 0 NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL stat.insure THEN
                            ASSIGN   wdetail2.branch  = CAPS(stat.insure.branch).
                        ELSE 
                            ASSIGN   wdetail2.branch = "" .
                    END.
                
                END.
            END.*/
        /*END. ..A67-0198 */
        IF index(wdetail2.kkflag,"ธนาคาร") <> 0 AND INDEX(wdetail2.kkflag,"N") = 0 THEN DO:
            FIND FIRST stat.insure USE-INDEX insure03 WHERE stat.insure.compno = "kk"  AND
                    index(trim(wdetail2.cmbr_no),trim(stat.insure.fname)) <> 0 NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL stat.insure THEN
                       ASSIGN wdetail2.vatcode = CAPS(stat.insure.vatcode) .
                    ELSE ASSIGN wdetail2.vatcode = "" .
        END.

        IF index(wdetail2.typpol,"ปีแรก") <> 0  THEN ASSIGN wdetail2.vatcode = "" . /*A67-0198 */

        IF (trim(wdetail2.subclass) = " ") OR (trim(wdetail2.subclass) = "999") THEN DO:
                IF      index(wdetail2.n_43,"รย1") <> 0 THEN wdetail2.subclass  = "110" .
                ELSE IF index(wdetail2.n_43,"รย2") <> 0 THEN wdetail2.subclass  = "210" .
                ELSE IF index(wdetail2.n_43,"รย3") <> 0 THEN wdetail2.subclass  = "320" .
        END.
        /* ที่อยู่ลูกค้า */
        IF trim(wdetail2.ADD_4) = ""  THEN DO:
            ASSIGN wdetail2.ADD_2 = IF trim(wdetail2.ADD_2) = "" THEN "" 
                                    ELSE IF INDEX(wdetail2.ADD_2,"ตำบล") <> 0 THEN  trim(wdetail2.ADD_2)
                                    ELSE "ตำบล" + trim(wdetail2.ADD_2)
                   wdetail2.ADD_3 = IF trim(wdetail2.ADD_3) = "" THEN "" 
                                    ELSE IF INDEX(wdetail2.ADD_3,"อำเภอ") <> 0 THEN trim(wdetail2.ADD_3)
                                    ELSE "อำเภอ" + trim(wdetail2.ADD_3).
        END.
        ELSE DO: 
            IF (INDEX(wdetail2.ADD_4,"กรุงเทพ") <> 0 ) OR (INDEX(wdetail2.ADD_4,"กทม") <> 0) THEN
                ASSIGN wdetail2.ADD_2 = IF trim(wdetail2.ADD_2) = "" THEN "" 
                                        ELSE IF INDEX(wdetail2.ADD_2,"แขวง") <> 0 THEN  trim(wdetail2.ADD_2)
                                        ELSE "แขวง" + trim(wdetail2.ADD_2)
                       wdetail2.ADD_3 = IF trim(wdetail2.ADD_3) = "" THEN "" 
                                        ELSE IF INDEX(wdetail2.ADD_3,"เขต") <> 0 THEN  trim(wdetail2.ADD_3)
                                        ELSE "เขต" + trim(wdetail2.ADD_3).
            ELSE ASSIGN
                wdetail2.ADD_2 = IF trim(wdetail2.ADD_2) = "" THEN "" 
                                 ELSE IF INDEX(wdetail2.ADD_2,"ตำบล") <> 0 THEN  trim(wdetail2.ADD_2)
                                 ELSE "ตำบล"  + trim(wdetail2.ADD_2)
                wdetail2.ADD_3 = IF trim(wdetail2.ADD_3) = "" THEN "" 
                                 ELSE IF INDEX(wdetail2.ADD_3,"อำเภอ") <> 0 THEN trim(wdetail2.ADD_3)
                                 ELSE "อำเภอ" + trim(wdetail2.ADD_3) 
                wdetail2.ADD_4 = IF wdetail2.ADD_4 = "" THEN "" 
                                 ELSE IF INDEX(wdetail2.ADD_4,"จังหวัด") <> 0 THEN trim(wdetail2.ADD_4) 
                                 ELSE "จังหวัด" + trim(wdetail2.ADD_4) .
        END.
        /* ที่อยู่ของใบเสร็จ */
        IF trim(wdetail2.reci_4) = ""  THEN DO:
            ASSIGN wdetail2.reci_2 = IF trim(wdetail2.reci_2) = "" THEN "" 
                                    ELSE IF INDEX(wdetail2.reci_2,"ตำบล") <> 0 THEN  trim(wdetail2.reci_2)
                                    ELSE "ตำบล" + trim(wdetail2.reci_2)
                   wdetail2.reci_3 = IF trim(wdetail2.reci_3) = "" THEN "" 
                                    ELSE IF INDEX(wdetail2.reci_3,"อำเภอ") <> 0 THEN trim(wdetail2.reci_3)
                                    ELSE "อำเภอ" + trim(wdetail2.reci_3).
        END.
        ELSE DO: 
            IF (INDEX(wdetail2.reci_4,"กรุงเทพ") <> 0 ) OR (INDEX(wdetail2.reci_4,"กทม") <> 0) THEN
                ASSIGN wdetail2.reci_2 = IF trim(wdetail2.reci_2) = "" THEN "" 
                                        ELSE IF INDEX(wdetail2.reci_2,"แขวง") <> 0 THEN  trim(wdetail2.reci_2)
                                        ELSE "แขวง" + trim(wdetail2.reci_2)
                       wdetail2.reci_3 = IF trim(wdetail2.reci_3) = "" THEN "" 
                                        ELSE IF INDEX(wdetail2.reci_3,"เขต") <> 0 THEN  trim(wdetail2.reci_3)
                                        ELSE "เขต" + trim(wdetail2.reci_3).
            ELSE ASSIGN
                wdetail2.reci_2 = IF trim(wdetail2.reci_2) = "" THEN "" 
                                 ELSE IF INDEX(wdetail2.reci_2,"ตำบล") <> 0 THEN  trim(wdetail2.reci_2)
                                 ELSE "ตำบล"  + trim(wdetail2.reci_2)
                wdetail2.reci_3 = IF trim(wdetail2.reci_3) = "" THEN "" 
                                 ELSE IF INDEX(wdetail2.reci_3,"อำเภอ") <> 0 THEN trim(wdetail2.reci_3)
                                 ELSE "อำเภอ" + trim(wdetail2.reci_3) 
                wdetail2.reci_4 = IF wdetail2.reci_4 = "" THEN "" 
                                 ELSE IF INDEX(wdetail2.reci_4,"จังหวัด") <> 0 THEN trim(wdetail2.reci_4) 
                                 ELSE "จังหวัด" + trim(wdetail2.reci_4) .
        END.
        ASSIGN n_comdate  = string(DAY(date(wdetail2.comdat)),"99")   + "/" +  
                            string(MONTH(date(wdetail2.comdat)),"99") + "/" +  
                            STRING(YEAR(date(wdetail2.comdat)),"9999") . 
        IF (TODAY - date(n_comdate)) >= 29 THEN DO:          /* 27  วันเริ่มคุ้มครอง    */                                   
            /*MESSAGE "เลขที่สัญญาREKK :" wdetail2.notifyno "วันที่เริ่มคุ้มครองน้อยกว่าวันที่นำเข้า 29 วัน" VIEW-AS ALERT-BOX.*/
            ASSIGN wdetail2.comdat = string(DAY(TODAY),"99")   + "/" +       
                                     string(MONTH(TODAY),"99") + "/" +       
                                     STRING(YEAR(TODAY),"9999")            
                wdetail2.expdat    = string(DAY(TODAY),"99")   + "/" +                    
                                     string(MONTH(TODAY),"99") + "/" +       
                                     STRING(YEAR(TODAY) + 1 ,"9999")   .  /* 28  วันสิ้นสุดคุ้มครอง  */    
            FIND LAST brstat.tlt    WHERE 
                brstat.tlt.comp_noti_tlt  = wdetail2.notifyno  AND
                brstat.tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
            IF AVAIL brstat.tlt THEN 
                ASSIGN 
                brstat.tlt.OLD_cha = brstat.tlt.OLD_cha + "เปลี่ยนวันที่เริ่มคุ้มครอง รอลูกค้าชำระเงิน ".
        END.
        /* add by : A64-0138 13/07/21 หาอักษรย่อทะเบียน */
        IF wdetail2.licence <> "" AND wdetail2.province <> "" THEN DO:
            n_vehpro = wdetail2.province.
            FOR EACH brstat.insure WHERE brstat.Insure.Compno = "999" NO-LOCK:
                IF INDEX(n_vehpro,brstat.Insure.Fname) <> 0 THEN DO: 
                    ASSIGN
                        n_vehpro = brstat.insure.Lname.
                END.
            END.
            wdetail2.licence = trim(wdetail2.licence) + " " + n_vehpro.
        END.
        /* end : A64-0138 */
    END.
END.
/*RUN proc_assign2_veh.*/ /*A64-0138*/
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
     ASSIGN np_codeaddr1 =  sicuw.uwm500.prov_n .   /*= uwm100.codeaddr1 */  
    FIND LAST sicuw.uwm501 USE-INDEX uwm50102   WHERE 
        sicuw.uwm501.prov_n = sicuw.uwm500.prov_n  AND
        index(sicuw.uwm501.dist_d,np_mail_amper) <> 0        NO-LOCK NO-ERROR NO-WAIT. /*"พนมทวน"*/
    IF AVAIL sicuw.uwm501 THEN DO:  
        ASSIGN np_codeaddr2 =  sicuw.uwm501.dist_n .   /*= uwm100.codeaddr2 */

        FIND LAST sicuw.uwm506 USE-INDEX uwm50601 WHERE 
            sicuw.uwm506.prov_n   = sicuw.uwm501.prov_n and
            sicuw.uwm506.dist_n   = sicuw.uwm501.dist_n and
            sicuw.uwm506.sdist_d  = np_tambon           NO-LOCK NO-ERROR NO-WAIT. /*"รางหวาย"*/
        IF AVAIL sicuw.uwm506 THEN  
            ASSIGN np_codeaddr3 =  sicuw.uwm506.sdist_n . /*= uwm100.codeaddr3 */
             
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign3 C-Win 
PROCEDURE proc_assign3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_length AS INT.
FOR EACH wdetail2 .
   /* IF wdetail2.cedpol NE "" THEN DO:*/ /*A67-0198*/
   IF wdetail2.KKQuo <> "" THEN DO:       /*A67-0198*/
        ASSIGN nv_chass         = ""
               wdetail2.chassis = trim(wdetail2.chassis) 
               nv_chass = IF length(wdetail2.chassis) > 9 THEN SUBSTR(wdetail2.chassis,(LENGTH(wdetail2.chassis) - 9) + 1,LENGTH(wdetail2.chassis)) 
                          ELSE TRIM(wdetail2.chassis).
        IF trim(wdetail2.licence) = ""  THEN ASSIGN wdetail2.licence = IF LENGTH(wdetail2.chassis)  > 9 THEN "/" + substr(trim(wdetail2.chassis),LENGTH(trim(wdetail2.chassis)) - 9 ) 
                              ELSE "/" + trim(wdetail2.chassis) . /*A67-0198*/  
        IF      INDEX(wdetail2.cover,"พรบ")    <> 0  OR  INDEX(wdetail2.cover,"ภาคบังคับ") <> 0 THEN RUN proc_assign72.
        ELSE IF index(wdetail2.typpol,"new")   <> 0  and  index(wdetail2.typpol,"ปีแรก")    <> 0 THEN RUN proc_assign70.
        ELSE IF index(wdetail2.typpol,"Renew") <> 0  and  index(wdetail2.typpol,"ปีต่อ")  <> 0 THEN DO:

            ASSIGN fi_show  = "Import data to wdetail... Text file KK [RENEW 70] " .   
            DISP fi_show  WITH FRAME fr_main.

            FIND FIRST wdetail WHERE wdetail.policy = "R0" + trim(nv_chass) NO-ERROR NO-WAIT.
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN
                    n_length            = LENGTH(wdetail2.cedpol)
                    n_length            = n_length - 1
                    wdetail.revday      = wdetail2.Notify_dat 
                    wdetail.seat        = IF INT(wdetail2.seat) <> 0 THEN trim(wdetail2.seat) 
                                          ELSE IF wdetail2.subclass  = "110" THEN "7"   
                                          ELSE IF wdetail2.subclass  = "210" THEN "12"     
                                          ELSE IF wdetail2.subclass  = "320" THEN "3"   
                                          ELSE IF wdetail2.subclass  = "610" THEN "2"
                                          ELSE "0"   
                    wdetail.caryear     = wdetail2.cyear 
                    wdetail.prepol      = caps(trim(wdetail2.prepol))
                    wdetail.poltyp      = "70" 
                    wdetail.policy      = "R0" + trim(nv_chass) 
                    wdetail.comdat      = trim(wdetail2.comdat)  
                    wdetail.expdat      = trim(wdetail2.expdat) 
                    wdetail.insnamtyp   = IF trim(wdetail2.typper) = "Individual" THEN "PR" ELSE "CO"
                    wdetail.tiname      = trim(wdetail2.n_TITLE)
                    wdetail.firstName   = trim(wdetail2.n_name1)
                    wdetail.lastName    = trim(wdetail2.n_name2)
                    wdetail.insnam      = trim(wdetail2.n_name1) + " " + trim(wdetail2.n_name2)
                    wdetail.name2       = IF index(wdetail2.kkflag,"ธนาคาร") <> 0 AND index(wdetail2.kkflag,"N") = 0 THEN "และ/หรือ ธนาคารเกียรตินาคินภัทร จำกัด (มหาชน)"
                                          ELSE ""
                    wdetail.iadd1       = trim(wdetail2.ADD_1) 
                    wdetail.iadd2       = trim(wdetail2.ADD_2)  
                    wdetail.iadd3       = trim(wdetail2.ADD_3)  
                    wdetail.iadd4       = trim(wdetail2.ADD_4)  
                    wdetail.postcd      = trim(wdetail2.ADD_5) 
                    wdetail.subclass    = trim(wdetail2.subclass)
                    wdetail.brand       = trim(wdetail2.brand)
                    wdetail.model       = trim(wdetail2.model) 
                    wdetail.cc          = IF deci(wdetail2.power) = 0 THEN "0"
                                          ELSE string(ROUND((deci(wdetail2.power) / 100 ),0) * 100)
                    wdetail.weight      = trim(wdetail2.weight)    
                    wdetail.vehreg      = TRIM(wdetail2.licence)
                    wdetail.engno       = trim(wdetail2.engine)
                    wdetail.chasno      = trim(wdetail2.chassis)
                    /*wdetail.vehuse      = IF wdetail.subclass <> "" THEN substr(wdetail.subclass,2,1) ELSE "1" */ /* ranu : A65-0288*/
                    wdetail.vehuse      = IF index(wdetail2.n_43,"ส่วนบุคคล") <> 0 THEN "1"  ELSE "2"   /* ranu : A65-0288*/
                    wdetail.garage      = IF      (index(trim(wdetail2.garage),"ห้าง") <> 0) THEN "G"   /*A55-0104*/
                                          ELSE IF (index(trim(wdetail2.garage),"G")    <> 0) THEN "G"   /*A55-0104*/
                                          ELSE " "                                                      /*A55-0104*/
                    wdetail.stk         = ""
                    wdetail.covcod      = IF      index(wdetail2.cover,"1") <> 0 THEN "1"
                                          ELSE IF index(wdetail2.cover,"2+") <> 0 THEN "2.2"
                                          ELSE IF index(wdetail2.cover,"2 +") <> 0 THEN "2.2"
                                          ELSE IF index(wdetail2.cover,"2.2") <> 0 THEN "2.2"
                                          ELSE IF index(wdetail2.cover,"2") <> 0 AND index(wdetail2.cover,"plus") <> 0 THEN "2.2"
                                          ELSE IF index(wdetail2.cover,"2") <> 0 THEN "2"
                                          ELSE IF index(wdetail2.cover,"3+") <> 0 THEN "3.2"
                                          ELSE IF index(wdetail2.cover,"3 +") <> 0 THEN "3.2"
                                          ELSE IF index(wdetail2.cover,"3.2") <> 0 THEN "3.2"
                                          ELSE IF index(wdetail2.cover,"3") <> 0 AND index(wdetail2.cover,"plus") <> 0 THEN "3.2"
                                          ELSE IF index(wdetail2.cover,"3") <> 0 THEN "3"
                                          ELSE wdetail2.cover
                    wdetail.si          = trim(wdetail2.ins_amt1)
                   /* wdetail.deductpp    = "500000"   */ /*A67-0076*/
                   /* wdetail.deductba    = "10000000" */ /*A67-0076*/   
                   /* wdetail.deductpa    = "1000000"  */ /*A67-0076*/
                    wdetail.deductpp    = IF wdetail2.subclass  = "E11" OR wdetail2.subclass  = "E21"  THEN "" ELSE  "500000"      /* A63-0130 ความคุ้มครอง pack T */  /* A67-0079*/
                    wdetail.deductba    = IF wdetail2.subclass  = "E11" OR wdetail2.subclass  = "E21"  THEN "" ELSE  "10000000"   /*kridtiya i. a54-0344*/             /* A67-0079*/
                    wdetail.deductpa    = IF wdetail2.subclass  = "E11" OR wdetail2.subclass  = "E21"  THEN "" ELSE  "600000"     /*kridtiya i. a54-0344*/             /* A67-0079*/
                    wdetail.prempa      = "T"
                    wdetail.prempa      = "T"
                    wdetail.branch      = wdetail2.branch 
                    wdetail.benname     = TRIM(wdetail2.bennam)
                    wdetail.premt       = wdetail2.netprem
                    wdetail.volprem     = wdetail2.prem1
                    wdetail.comment     = ""
                    wdetail.entdat      = string(TODAY)                /*entry date*/
                    wdetail.enttim      = STRING(TIME, "HH:MM:SS")    /*entry time*/
                    wdetail.trandat     = STRING(TODAY)               /*tran date*/
                    wdetail.trantim     = STRING(TIME, "HH:MM:SS")    /*tran time*/
                    wdetail.n_IMPORT    = "IM"
                    wdetail.n_EXPORT    = ""  
                    wdetail.namenotify  = trim(wdetail2.NAME_mkt)
                    wdetail.nmember     = "วันที่รับเงิน : " + trim(wdetail2.recive_dat) + " ประเภทการแจ้งงาน:" + trim(wdetail2.typpol) + " : " + trim(wdetail2.kkflag) 
                    wdetail.phone       = trim(wdetail2.phone)       /*เบอร์ติดต่อ                */      
                    wdetail.icno        = trim(wdetail2.icno )       /*เลขที่บัตรประชาชน          */ 
                    wdetail.bdate       = trim(wdetail2.bdate)       /*วันเดือนปีเกิด             */ 
                    wdetail.occup       = trim(wdetail2.occup)       /*อาชีพ                      */ 
                    wdetail.cstatus     = trim(wdetail2.cstatus)     /*สถานภาพ                    */
                    wdetail.gender      = trim(wdetail2.gender)
                    wdetail.nation      = trim(wdetail2.nation)
                    wdetail.email       = trim(wdetail2.email)
                    wdetail.reci_title  = trim(wdetail2.reci_title)  /* คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี) */     
                    wdetail.reci_name1  = trim(wdetail2.reci_name1)  /* ชื่อ (ใบเสร็จ/ใบกำกับภาษี)         */     
                    wdetail.reci_name2  = trim(wdetail2.reci_name2)  /* นามสกุล (ใบเสร็จ/ใบกำกับภาษี)      */     
                    wdetail.reci_1      = trim(wdetail2.reci_1)      /* บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)   */     
                    wdetail.reci_2      = trim(wdetail2.reci_2)      /* ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)    */     
                    wdetail.reci_3      = trim(wdetail2.reci_3)      /* อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)    */     
                    wdetail.reci_4      = trim(wdetail2.reci_4)      /* จังหวัด (ใบเสร็จ/ใบกำกับภาษี)      */     
                    wdetail.reci_5      = trim(wdetail2.reci_5)      /* รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี) */     
                    wdetail.tax         = trim(wdetail2.tax)         /*เลขประจำตัวผู้เสียภาษีอากร */ 
                    wdetail.tname1      = trim(wdetail2.tname1)      /*คำนำหน้าชื่อ 1             */ 
                    wdetail.cname1      = trim(wdetail2.cname1)      /*ชื่อกรรมการ 1              */ 
                    wdetail.lname1      = trim(wdetail2.lname1)      /*นามสกุลกรรมการ 1           */ 
                    wdetail.icno1       = trim(wdetail2.icno1 )      /*เลขที่บัตรประชาชนกรรมการ 1 */ 
                    wdetail.tname2      = trim(wdetail2.tname2)      /*คำนำหน้าชื่อ 2             */ 
                    wdetail.cname2      = trim(wdetail2.cname2)      /*ชื่อกรรมการ 2              */ 
                    wdetail.lname2      = trim(wdetail2.lname2)      /*นามสกุลกรรมการ 2           */ 
                    wdetail.icno2       = trim(wdetail2.icno2 )      /*เลขที่บัตรประชาชนกรรมการ 2 */ 
                    wdetail.tname3      = trim(wdetail2.tname3)      /*คำนำหน้าชื่อ 3             */ 
                    wdetail.cname3      = trim(wdetail2.cname3)      /*ชื่อกรรมการ 3              */ 
                    wdetail.lname3      = trim(wdetail2.lname3)      /*นามสกุลกรรมการ 3           */ 
                    wdetail.icno3       = trim(wdetail2.icno3 )      /*เลขที่บัตรประชาชนกรรมการ 3 */ 
                    wdetail.nsend       = trim(wdetail2.nsend)       /*ที่จัดส่ง */
                    wdetail.sendname    = trim(wdetail2.sendname)    /*ชื่อผู้รับเอกสาร */ 
                    wdetail.bennefit    = IF index(wdetail2.bennefit,"ยกเลิก") <> 0 OR index(wdetail2.bennefit,"ไม่ระบุ") <> 0 THEN "" 
                                          ELSE trim(wdetail2.bennefit)    /*ผู้รับผลประโยชน์ */ 
                    wdetail.KKapp       = trim(wdetail2.KKapp)       /*KK app */ /*A61-0335*/
                    wdetail.cedpol      = trim(wdetail2.cedpol)      /* เลขที่สัญญา */
                    wdetail.notifyno    = trim(wdetail2.notifyno)    /* เลขรับแจ้ง */
                    wdetail.remak1      = trim(wdetail2.remak1)
                    wdetail.remak2      = trim(wdetail2.remak2)  
                    wdetail.dealercd    = trim(wdetail2.dealercd)
                    wdetail.dealtms     = IF INDEX(wdetail2.dealtms,"/") <> 0 THEN "" ELSE TRIM(wdetail2.dealtms) 
                    wdetail.product     = trim(wdetail2.packcod)
                    wdetail.campaign_ov = trim(wdetail2.campOV) 
                    wdetail.producer    = trim(wdetail2.producer)
                    wdetail.Agent       = trim(wdetail2.Agent) 
                    wdetail.drivnam     = IF wdetail2.drivno1 <> "" THEN "Y" ELSE "N"
                    wdetail.drivnam1    = trim(wdetail2.drivno1)       /* ผู้ขับขี่ที่ 1              */
                    wdetail.drivbir1    = trim(wdetail2.drivdat1)      /* วันเกิดผู้ขับขี่ 1          */
                    wdetail.drivid1     = trim(wdetail2.drivid1)       /* เลขที่ใบขับขี่ 1            */
                    wdetail.drivnam2    = trim(wdetail2.drivno2)       /* ผู้ขับขี่ที่ 2              */
                    wdetail.drivbir2    = trim(wdetail2.drivdat2)      /* วันเกิดผู้ขับขี่ 2          */
                    wdetail.drivid2     = trim(wdetail2.drivid2)       /* เลขที่ใบขับขี่ 2            */ 
                    wdetail.RefNo       = trim(wdetail2.RefNo)  
                    wdetail.KKQuo       = trim(wdetail2.KKQuo)  
                    wdetail.RiderNo     = trim(wdetail2.RiderNo)
                   /* add by : A65-0288 */
                    wdetail.problem    = trim(wdetail2.UnProblem)     /*Note Un Problem  */
                    wdetail.colors     = trim(wdetail2.colors)        /* color A65-0288 */
                    wdetail.Insp       = trim(wdetail2.Insp)          /* ตรวจสภาพ */
                    wdetail.Inspsts    = trim(wdetail2.Inspsts)       /* สถานะกล่องตรวจสภาพ*/
                    wdetail.InspNo     = trim(wdetail2.InspNo)        /* เลขกล่อง*/
                    wdetail.InspClosed = trim(wdetail2.InspClosed)    /* วันที่ปิดเรื่อง*/
                    wdetail.InspDetail = trim(wdetail2.InspDetail)    /* ผลตรวจสภาพ*/
                    wdetail.inspDamg   = trim(wdetail2.inspDamg)      /* รายการความเสียหาย*/
                    wdetail.inspAcc    = trim(wdetail2.inspAcc )       /* อุปกรณ์เสริม */
                   /* end : A65-0288 */
                   /* A67-0076 */ 
                    wdetail.hp          = deci(wdetail2.hp)            
                    wdetail.drititle1   = wdetail2.drititle1     
                    wdetail.drigender1  = wdetail2.drigender1    
                    wdetail.drioccup1   = wdetail2.drioccup1     
                    wdetail.driICNo1    = wdetail2.driICNo1      
                    wdetail.drilevel1   = wdetail2.drilevel1     
                    wdetail.drititle2   = wdetail2.drititle2     
                    wdetail.drigender2  = wdetail2.drigender2    
                    wdetail.drioccup2   = wdetail2.drioccup2     
                    wdetail.driICNo2    = wdetail2.driICNo2      
                    wdetail.drilevel2   = wdetail2.drilevel2     
                    wdetail.drilic3     = wdetail2.drilic3       
                    wdetail.drititle3   = wdetail2.drititle3     
                    wdetail.drivnam3    = wdetail2.driname3      
                    wdetail.drivbir3    = wdetail2.drivno3      
                    wdetail.drigender3  = wdetail2.drigender3    
                    wdetail.drioccup3   = wdetail2.drioccup3     
                    wdetail.driICNo3    = wdetail2.driICNo3      
                    wdetail.drilevel3   = wdetail2.drilevel3     
                    wdetail.drilic4     = wdetail2.drilic4       
                    wdetail.drititle4   = wdetail2.drititle4     
                    wdetail.drivnam4    = wdetail2.driname4      
                    wdetail.drivbir4    = wdetail2.drivno4      
                    wdetail.drigender4  = wdetail2.drigender4    
                    wdetail.drioccup4   = wdetail2.drioccup4     
                    wdetail.driICNo4    = wdetail2.driICNo4      
                    wdetail.drilevel4   = wdetail2.drilevel4     
                    wdetail.drilic5     = wdetail2.drilic5       
                    wdetail.drititle5   = wdetail2.drititle5     
                    wdetail.drivnam5    = wdetail2.driname5      
                    wdetail.drivbir5    = wdetail2.drivno5      
                    wdetail.drigender5  = wdetail2.drigender5    
                    wdetail.drioccup5   = wdetail2.drioccup5     
                    wdetail.driICNo5    = wdetail2.driICNo5      
                    wdetail.drilevel5   = wdetail2.drilevel5     
                    wdetail.dateregis   = wdetail2.dateregis     
                    wdetail.pay_option  = wdetail2.pay_option    
                    wdetail.battno      = wdetail2.battno        
                    wdetail.battyr      = IF (wdetail2.battyr = "" OR wdetail2.battyr = "0" ) AND index(wdetail2.subclass,"E") <> 0 THEN  trim(wdetail2.cyear) ELSE wdetail2.battyr  
                    wdetail.maksi       = deci(wdetail2.maksi)         
                    wdetail.chargno     = wdetail2.chargno       
                    wdetail.veh_key     = wdetail2.veh_key 
                    wdetail.redbook     = TRIM(wdetail2.veh_key) . /*A67-0198*/
                   /* end : A67-0076 */ 
                END.  /*if avail*/
        END.
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
DEF VAR n_length AS INT.
ASSIGN fi_show  = "Import data to wdetail... Text file KK [NEW 70] " .   
DISP fi_show  WITH FRAME fr_main.

FIND FIRST wdetail WHERE wdetail.policy  = "N0" + trim(nv_chass) NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN
        n_length            = LENGTH(trim(wdetail2.cedpol))
        n_length            = n_length - 1
        wdetail.revday      = wdetail2.Notify_dat
        wdetail.seat        = IF INT(wdetail2.seat) <> 0 THEN trim(wdetail2.seat) 
                              ELSE IF wdetail2.subclass  = "110" THEN "7"   
                              ELSE IF wdetail2.subclass  = "210" THEN "12"     
                              ELSE IF wdetail2.subclass  = "320" THEN "3"   
                              ELSE IF wdetail2.subclass  = "610" THEN "2"
                              ELSE IF wdetail2.subclass  = "E11" THEN "7"    /* A67-0076*/
                              ELSE IF wdetail2.subclass  = "E21" THEN "12"   /* A67-0076*/
                              ELSE "0"  
        wdetail.brand       = trim(wdetail2.brand)
        wdetail.caryear     = wdetail2.cyear 
        wdetail.poltyp      = "70" 
        wdetail.policy      = "N0" + trim(nv_chass)
        wdetail.comdat      = trim(wdetail2.comdat)  
        wdetail.expdat      = trim(wdetail2.expdat)
        wdetail.insnamtyp   = IF trim(wdetail2.typper) = "Individual" THEN "PR" ELSE "CO"
        wdetail.tiname      = trim(wdetail2.n_TITLE)
        wdetail.firstName   = trim(wdetail2.n_name1)
        wdetail.lastName    = trim(wdetail2.n_name2)
        wdetail.insnam      = trim(wdetail2.n_name1) + " " + trim(wdetail2.n_name2)
        wdetail.name2       = IF index(wdetail2.kkflag,"ธนาคาร") <> 0 AND index(wdetail2.kkflag,"N") = 0 THEN "และ/หรือ ธนาคารเกียรตินาคินภัทร จำกัด (มหาชน)"
                              ELSE ""  
        wdetail.iadd1       = trim(wdetail2.ADD_1)  
        wdetail.iadd2       = trim(wdetail2.ADD_2)  
        wdetail.iadd3       = trim(wdetail2.ADD_3)  
        wdetail.iadd4       = trim(wdetail2.ADD_4)  
        wdetail.postcd      = trim(wdetail2.ADD_5)  
        wdetail.subclass    = trim(wdetail2.subclass)
        wdetail.model       = trim(wdetail2.model) 
        wdetail.cc          = IF deci(wdetail2.power) = 0 THEN "0"
                              ELSE string(ROUND((deci(wdetail2.power) / 100 ),0) * 100)
        wdetail.weight      = trim(wdetail2.weight)   
        wdetail.vehreg      = TRIM(wdetail2.licence)
        wdetail.engno       = trim(wdetail2.engine)
        wdetail.chasno      = trim(wdetail2.chassis)
        /*wdetail.vehuse      = IF wdetail.subclass <> "" THEN substr(wdetail.subclass,2,1) ELSE "1" */ /* ranu : A65-0288*/
        wdetail.vehuse      = IF index(wdetail2.n_43,"ส่วนบุคคล") <> 0 THEN "1"  ELSE "2"   /* ranu : A65-0288*/
        wdetail.garage      = IF      (index(trim(wdetail2.garage),"ห้าง") <> 0) THEN "G"   /*A55-0104*/
                              ELSE IF (index(trim(wdetail2.garage),"G")    <> 0) THEN "G"   /*A55-0104*/
                              ELSE " "                                                      /*A55-0104*/
        wdetail.stk         = ""
        wdetail.covcod      = IF      index(wdetail2.cover,"1") <> 0 THEN "1"
                              ELSE IF index(wdetail2.cover,"2+") <> 0 THEN "2.2"
                              ELSE IF index(wdetail2.cover,"2 +") <> 0 THEN "2.2"
                              ELSE IF index(wdetail2.cover,"2.2") <> 0 THEN "2.2"
                              ELSE IF index(wdetail2.cover,"2") <> 0 AND index(wdetail2.cover,"plus") <> 0 THEN "2.2"
                              ELSE IF index(wdetail2.cover,"2") <> 0 THEN "2"
                              ELSE IF index(wdetail2.cover,"3+") <> 0 THEN "3.2"
                              ELSE IF index(wdetail2.cover,"3 +") <> 0 THEN "3.2"
                              ELSE IF index(wdetail2.cover,"3.2") <> 0 THEN "3.2"
                              ELSE IF index(wdetail2.cover,"3") <> 0 AND index(wdetail2.cover,"plus") <> 0 THEN "3.2"
                              ELSE IF index(wdetail2.cover,"3") <> 0 THEN "3"
                              ELSE wdetail2.cover
        wdetail.si          = trim(wdetail2.ins_amt1)
        /*wdetail.deductpp    = "500000"      /* A63-0130 ความคุ้มครอง pack T */ */ /* A67-0079*/
        /*wdetail.deductba    = "10000000"   /*kridtiya i. a54-0344*/            */ /* A67-0079*/
        /*wdetail.deductpa    = "600000"     /*kridtiya i. a54-0344*/            */ /* A67-0079*/
        wdetail.deductpp    = IF wdetail2.subclass  = "E11" OR wdetail2.subclass  = "E21"  THEN "" ELSE  "500000"      /* A63-0130 ความคุ้มครอง pack T */  /* A67-0079*/
        wdetail.deductba    = IF wdetail2.subclass  = "E11" OR wdetail2.subclass  = "E21"  THEN "" ELSE  "10000000"   /*kridtiya i. a54-0344*/             /* A67-0079*/
        wdetail.deductpa    = IF wdetail2.subclass  = "E11" OR wdetail2.subclass  = "E21"  THEN "" ELSE  "600000"     /*kridtiya i. a54-0344*/             /* A67-0079*/
        wdetail.prempa      = "T"
        wdetail.branch      = trim(wdetail2.branch)
        wdetail.benname     = trim(wdetail2.bennam)        /* หมายเหตุ                    */    
        wdetail.premt       = wdetail2.netprem
        wdetail.volprem     = wdetail2.prem1
        wdetail.comment     = ""
        wdetail.reci_title  = trim(wdetail2.reci_title)  /* คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี) */     
        wdetail.reci_name1  = trim(wdetail2.reci_name1)  /* ชื่อ (ใบเสร็จ/ใบกำกับภาษี)         */     
        wdetail.reci_name2  = trim(wdetail2.reci_name2)  /* นามสกุล (ใบเสร็จ/ใบกำกับภาษี)      */     
        wdetail.reci_1      = trim(wdetail2.reci_1)      /* บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)   */     
        wdetail.reci_2      = trim(wdetail2.reci_2)      /* ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)    */     
        wdetail.reci_3      = trim(wdetail2.reci_3)      /* อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)    */     
        wdetail.reci_4      = trim(wdetail2.reci_4)      /* จังหวัด (ใบเสร็จ/ใบกำกับภาษี)      */     
        wdetail.reci_5      = trim(wdetail2.reci_5)      /* รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี) */     
        wdetail.phone       = trim(wdetail2.phone)       /*เบอร์ติดต่อ                */      
        wdetail.icno        = trim(wdetail2.icno )       /*เลขที่บัตรประชาชน          */ 
        wdetail.bdate       = trim(wdetail2.bdate)       /*วันเดือนปีเกิด             */ 
        wdetail.occup       = trim(wdetail2.occup)       /*อาชีพ                      */ 
        wdetail.cstatus     = trim(wdetail2.cstatus)     /*สถานภาพ                    */
        wdetail.gender      = trim(wdetail2.gender)
        wdetail.nation      = trim(wdetail2.nation)
        wdetail.email       = trim(wdetail2.email) 
        wdetail.tax         = trim(wdetail2.tax)         /*เลขประจำตัวผู้เสียภาษีอากร */ 
        wdetail.tname1      = trim(wdetail2.tname1)      /*คำนำหน้าชื่อ 1             */ 
        wdetail.cname1      = trim(wdetail2.cname1)      /*ชื่อกรรมการ 1              */ 
        wdetail.lname1      = trim(wdetail2.lname1)      /*นามสกุลกรรมการ 1           */ 
        wdetail.icno1       = trim(wdetail2.icno1 )      /*เลขที่บัตรประชาชนกรรมการ 1 */ 
        wdetail.tname2      = trim(wdetail2.tname2)      /*คำนำหน้าชื่อ 2             */ 
        wdetail.cname2      = trim(wdetail2.cname2)      /*ชื่อกรรมการ 2              */ 
        wdetail.lname2      = trim(wdetail2.lname2)      /*นามสกุลกรรมการ 2           */ 
        wdetail.icno2       = trim(wdetail2.icno2 )      /*เลขที่บัตรประชาชนกรรมการ 2 */ 
        wdetail.tname3      = trim(wdetail2.tname3)      /*คำนำหน้าชื่อ 3             */ 
        wdetail.cname3      = trim(wdetail2.cname3)      /*ชื่อกรรมการ 3              */ 
        wdetail.lname3      = trim(wdetail2.lname3)      /*นามสกุลกรรมการ 3           */ 
        wdetail.icno3       = trim(wdetail2.icno3 )      /*เลขที่บัตรประชาชนกรรมการ 3 */ 
        wdetail.nsend       = trim(wdetail2.nsend)       /*ที่จัดส่ง */ /*A61-0335*/
        wdetail.sendname    = trim(wdetail2.sendname)    /*ชื่อผู้รับเอกสาร */ /*A61-0335*/
        wdetail.bennefit    = IF index(wdetail2.bennefit,"ยกเลิก") <> 0 OR index(wdetail2.bennefit,"ไม่ระบุ") <> 0 THEN "" 
                              ELSE trim(wdetail2.bennefit)    /*ผู้รับผลประโยชน์ */ /*A61-0335*/
        wdetail.delerco     = trim(wdetail2.vatcode) /*IF index(wdetail2.kkflag,"แถม") <> 0 THEN trim(wdetail2.vatcode) ELSE "" */  /*im_cc เก็บค่า vatcode*/
        wdetail.producer    = trim(wdetail2.producer)
        wdetail.agent       = trim(wdetail2.agent)  
        wdetail.entdat      = string(TODAY)           /*entry date*/
        wdetail.enttim      = STRING(TIME,"HH:MM:SS") /*entry time*/
        wdetail.trandat     = STRING(TODAY)           /*tran date*/
        wdetail.trantim     = STRING(TIME,"HH:MM:SS") /*tran time*/
        wdetail.n_IMPORT    = "IM"
        wdetail.n_EXPORT    = "" 
        wdetail.cedpol      = trim(wdetail2.cedpol)
        wdetail.notifyno    = trim(wdetail2.notifyno)
        wdetail.KKapp       = trim(wdetail2.KKapp)       /*KK app */ /*A61-0335*/
        wdetail.remak1      = trim(wdetail2.remak1)
        wdetail.remak2      = trim(wdetail2.remak2)  
        wdetail.namenotify  = trim(wdetail2.NAME_mkt)
        wdetail.nmember     = "วันที่รับเงิน : " + trim(wdetail2.recive_dat) + " ประเภทการแจ้งงาน:" + trim(wdetail2.typpol) + " : " + trim(wdetail2.kkflag) 
        wdetail.product     = trim(wdetail2.packcod)     
        wdetail.dealer      = trim(wdetail2.dealercd)  
        wdetail.drivnam     = IF wdetail2.drivno1 <> "" THEN "Y" ELSE "N"
        wdetail.drivnam1    = trim(wdetail2.drivno1)       /* ผู้ขับขี่ที่ 1              */
        wdetail.drivbir1    = trim(wdetail2.drivdat1)      /* วันเกิดผู้ขับขี่ 1          */
        wdetail.drivid1     = trim(wdetail2.drivid1)       /* เลขที่ใบขับขี่ 1            */
        wdetail.drivnam2    = trim(wdetail2.drivno2)       /* ผู้ขับขี่ที่ 2              */
        wdetail.drivbir2    = trim(wdetail2.drivdat2)      /* วันเกิดผู้ขับขี่ 2          */
        wdetail.drivid2     = trim(wdetail2.drivid2)        /* เลขที่ใบขับขี่ 2            */  
        wdetail.RefNo       = trim(wdetail2.RefNo)  
        wdetail.KKQuo       = trim(wdetail2.KKQuo)  
        wdetail.RiderNo     = trim(wdetail2.RiderNo) 
        wdetail.dealtms     = IF INDEX(wdetail2.dealtms,"/") <> 0 THEN "" ELSE TRIM(wdetail2.dealtms)  
        /* add by : A65-0288 */
        wdetail.problem    = trim(wdetail2.UnProblem)     /*Note Un Problem  */
        wdetail.colors     = trim(wdetail2.colors)        /* color A65-0288 */
        wdetail.Insp       = trim(wdetail2.Insp)          /* ตรวจสภาพ */
        wdetail.Inspsts    = trim(wdetail2.Inspsts)       /* สถานะกล่องตรวจสภาพ*/
        wdetail.InspNo     = trim(wdetail2.InspNo)        /* เลขกล่อง*/
        wdetail.InspClosed = trim(wdetail2.InspClosed)    /* วันที่ปิดเรื่อง*/
        wdetail.InspDetail = trim(wdetail2.InspDetail)    /* ผลตรวจสภาพ*/
        wdetail.inspDamg   = trim(wdetail2.inspDamg)      /* รายการความเสียหาย*/
        wdetail.inspAcc    = trim(wdetail2.inspAcc )       /* อุปกรณ์เสริม */
        /* end : A65-0288 */
       /* A67-0076 */ 
       wdetail.hp          = deci(wdetail2.hp)            
       wdetail.drititle1   = wdetail2.drititle1     
       wdetail.drigender1  = wdetail2.drigender1    
       wdetail.drioccup1   = wdetail2.drioccup1     
       wdetail.driICNo1    = wdetail2.driICNo1      
       wdetail.drilevel1   = wdetail2.drilevel1     
       wdetail.drititle2   = wdetail2.drititle2     
       wdetail.drigender2  = wdetail2.drigender2    
       wdetail.drioccup2   = wdetail2.drioccup2     
       wdetail.driICNo2    = wdetail2.driICNo2      
       wdetail.drilevel2   = wdetail2.drilevel2     
       wdetail.drilic3     = wdetail2.drilic3       
       wdetail.drititle3   = wdetail2.drititle3     
       wdetail.drivnam3    = wdetail2.driname3      
       wdetail.drivbir3    = wdetail2.drivno3      
       wdetail.drigender3  = wdetail2.drigender3    
       wdetail.drioccup3   = wdetail2.drioccup3     
       wdetail.driICNo3    = wdetail2.driICNo3      
       wdetail.drilevel3   = wdetail2.drilevel3     
       wdetail.drilic4     = wdetail2.drilic4       
       wdetail.drititle4   = wdetail2.drititle4     
       wdetail.drivnam4    = wdetail2.driname4      
       wdetail.drivbir4    = wdetail2.drivno4      
       wdetail.drigender4  = wdetail2.drigender4    
       wdetail.drioccup4   = wdetail2.drioccup4     
       wdetail.driICNo4    = wdetail2.driICNo4      
       wdetail.drilevel4   = wdetail2.drilevel4     
       wdetail.drilic5     = wdetail2.drilic5       
       wdetail.drititle5   = wdetail2.drititle5     
       wdetail.drivnam5    = wdetail2.driname5      
       wdetail.drivbir5    = wdetail2.drivno5      
       wdetail.drigender5  = wdetail2.drigender5    
       wdetail.drioccup5   = wdetail2.drioccup5     
       wdetail.driICNo5    = wdetail2.driICNo5      
       wdetail.drilevel5   = wdetail2.drilevel5     
       wdetail.dateregis   = wdetail2.dateregis     
       wdetail.pay_option  = wdetail2.pay_option    
       wdetail.battno      = wdetail2.battno        
       /*wdetail.battyr      = wdetail2.battyr*/
       wdetail.battyr      = IF (wdetail2.battyr = "" OR wdetail2.battyr = "0") AND index(wdetail2.subclass,"E") <> 0 THEN  trim(wdetail2.cyear) ELSE wdetail2.battyr 
       wdetail.maksi       = deci(wdetail2.maksi)         
       wdetail.chargno     = wdetail2.chargno       
       wdetail.veh_key     = wdetail2.veh_key 
       wdetail.redbook     = TRIM(wdetail2.veh_key) . /*A67-0198*/
       /* end : A67-0076 */ 
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
DEF VAR n_length AS INT.
ASSIGN fi_show  = "Import data to wdetail... Text file KK [NEW 72] " .   
DISP fi_show  WITH FRAME fr_main.
DO:
   FIND FIRST wdetail WHERE wdetail.policy = "72" + trim(nv_chass) NO-ERROR NO-WAIT.
   IF NOT AVAIL wdetail THEN DO:
       CREATE wdetail.
       ASSIGN 
           wdetail.revday      = wdetail2.Notify_dat
           wdetail.brand       = TRIM(wdetail2.brand)
           wdetail.caryear     = wdetail2.cyear
           wdetail.seat        = IF INT(wdetail2.seat) <> 0 THEN trim(wdetail2.seat) 
                                 ELSE IF wdetail2.subclass  = "110" THEN "7"   
                                 ELSE IF wdetail2.subclass  = "210" THEN "12"     
                                 ELSE IF wdetail2.subclass  = "320" THEN "3"   
                                 ELSE IF wdetail2.subclass  = "610" THEN "2"
                                 ELSE IF wdetail2.subclass  = "E11" THEN "7"    /* A67-0076*/
                                 ELSE IF wdetail2.subclass  = "E21" THEN "12"   /* A67-0076*/
                                 ELSE "0"  
           wdetail.poltyp      = "72" 
           wdetail.prepol      = caps(trim(wdetail2.prepol))
           wdetail.policy      = "72" + trim(nv_chass)
           wdetail.comdat      = (wdetail2.comdat)
           wdetail.expdat      = (wdetail2.expdat)
           wdetail.insnamtyp   = IF trim(wdetail2.typper) = "Individual" THEN "PR" ELSE "CO"
           wdetail.tiname      = trim(wdetail2.n_TITLE)
           wdetail.firstName   = trim(wdetail2.n_name1)
           wdetail.lastName    = trim(wdetail2.n_name2)
           wdetail.insnam      = trim(wdetail2.n_name1) + " " + trim(wdetail2.n_name2)
           wdetail.name2       = IF index(wdetail2.kkflag,"ธนาคาร") <> 0 AND index(wdetail2.kkflag,"N") = 0 THEN "และ/หรือ ธนาคารเกียรตินาคินภัทร จำกัด (มหาชน)"
                                 ELSE ""  
           wdetail.icno        = trim(wdetail2.icno )
           wdetail.phone       = Trim(wdetail2.phone)
           wdetail.bdate       = trim(wdetail2.bdate)       /*วันเดือนปีเกิด             */ 
           wdetail.occup       = trim(wdetail2.occup)       /*อาชีพ                      */ 
           wdetail.cstatus     = trim(wdetail2.cstatus)     /*สถานภาพ                    */
           wdetail.gender      = trim(wdetail2.gender)
           wdetail.nation      = trim(wdetail2.nation)
           wdetail.email       = trim(wdetail2.email) 
           wdetail.iadd1       = trim(wdetail2.ADD_1)             
           wdetail.iadd2       = trim(wdetail2.ADD_2)            
           wdetail.iadd3       = trim(wdetail2.ADD_3)            
           wdetail.iadd4       = trim(wdetail2.ADD_4)  
           wdetail.postcd      = trim(wdetail2.ADD_5)  
           wdetail.reci_title  = trim(wdetail2.reci_title)  /* คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี) */     
           wdetail.reci_name1  = trim(wdetail2.reci_name1)  /* ชื่อ (ใบเสร็จ/ใบกำกับภาษี)         */     
           wdetail.reci_name2  = trim(wdetail2.reci_name2)  /* นามสกุล (ใบเสร็จ/ใบกำกับภาษี)      */     
           wdetail.reci_1      = trim(wdetail2.reci_1)      /* บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)   */     
           wdetail.reci_2      = trim(wdetail2.reci_2)      /* ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)    */     
           wdetail.reci_3      = trim(wdetail2.reci_3)      /* อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)    */     
           wdetail.reci_4      = trim(wdetail2.reci_4)      /* จังหวัด (ใบเสร็จ/ใบกำกับภาษี)      */     
           wdetail.reci_5      = trim(wdetail2.reci_5)      /* รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี) */ 
           wdetail.subclass    = trim(wdetail2.subclass) 
           wdetail.model       = TRIM(wdetail2.model) 
           wdetail.cc          = IF deci(wdetail2.power) = 0 THEN "0"
                                 ELSE string(ROUND((deci(wdetail2.power) / 100 ),0) * 100)
           wdetail.vehreg      = TRIM(wdetail2.licence)  
           wdetail.engno       = TRIM(wdetail2.engine)
           wdetail.chasno      = TRIM(wdetail2.chassis)
           wdetail.vehuse      = "1"
           wdetail.garage      = ""
           wdetail.stk         = ""
           wdetail.covcod      = "T"
           wdetail.si          = ""
           wdetail.branch      = caps(trim(wdetail2.branch)) 
           wdetail.benname     = trim(wdetail2.bennam)  /* หมายเหตุ */
           wdetail.nmember     = "วันที่รับเงิน : " + trim(wdetail2.recive_dat) + " ประเภทการแจ้งงาน:" + trim(wdetail2.typpol) + " : " + trim(wdetail2.kkflag) 
           wdetail.premt       = wdetail2.netprem
           wdetail.volprem     = TRIM(wdetail2.prem1)
           wdetail.comment     = ""
           wdetail.delerco     = TRIM(wdetail2.vatcode)   /*เก็บค่า vatcode*/
           wdetail.agent       = caps(TRIM(wdetail2.agent))     
           wdetail.producer    = caps(TRIM(wdetail2.producer))  
           wdetail.entdat      = string(TODAY)                /*entry date*/
           wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
           wdetail.trandat     = STRING (TODAY)               /*tran date*/
           wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
           wdetail.n_IMPORT    = "IM"
           wdetail.n_EXPORT    = "" 
           wdetail.remak1      = trim(wdetail2.remak1)
           wdetail.remak2      = trim(wdetail2.remak2) 
           wdetail.cedpol      = TRIM(wdetail2.cedpol)
           wdetail.notifyno    = trim(wdetail2.notifyno)    /* เลขรับแจ้ง */
           wdetail.tname1      = Trim(wdetail2.tname1)      
           wdetail.cname1      = Trim(wdetail2.cname1)      
           wdetail.lname1      = Trim(wdetail2.lname1)      
           wdetail.icno1       = Trim(wdetail2.icno1)       
           wdetail.tname2      = Trim(wdetail2.tname2)      
           wdetail.cname2      = Trim(wdetail2.cname2)      
           wdetail.lname2      = Trim(wdetail2.lname2)      
           wdetail.icno2       = Trim(wdetail2.icno2)       
           wdetail.tname3      = Trim(wdetail2.tname3)      
           wdetail.cname3      = Trim(wdetail2.cname3)      
           wdetail.lname3      = Trim(wdetail2.lname3)      
           wdetail.icno3       = Trim(wdetail2.icno3)       
           wdetail.namenotify  = TRIM(wdetail2.NAME_mkt)   
           wdetail.nsend       = trim(wdetail2.nsend)       
           wdetail.sendname    = trim(wdetail2.sendname)    
           wdetail.kkapp       = trim(wdetail2.kkapp)       
           wdetail.bennefit    = "" /*trim(wdetail2.bennefit)*/    /*ผู้รับผลประโยชน์ */
           wdetail.RefNo       = trim(wdetail2.RefNo)  
           wdetail.KKQuo       = trim(wdetail2.KKQuo)  
           wdetail.RiderNo     = trim(wdetail2.RiderNo) 
           wdetail.dealtms     = IF INDEX(wdetail2.dealtms,"/") <> 0 THEN "" ELSE TRIM(wdetail2.dealtms) 
           wdetail.compul      = "y"
           wdetail.tariff      = "9"
           /* add by : A65-0288 */
           wdetail.problem    = trim(wdetail2.UnProblem)     /*Note Un Problem  */
           wdetail.colors     = trim(wdetail2.colors)        /* color A65-0288 */
           wdetail.Insp       = trim(wdetail2.Insp)          /* ตรวจสภาพ */
           wdetail.Inspsts    = trim(wdetail2.Inspsts)       /* สถานะกล่องตรวจสภาพ*/
           wdetail.InspNo     = trim(wdetail2.InspNo)        /* เลขกล่อง*/
           wdetail.InspClosed = trim(wdetail2.InspClosed)    /* วันที่ปิดเรื่อง*/
           wdetail.InspDetail = trim(wdetail2.InspDetail)    /* ผลตรวจสภาพ*/
           wdetail.inspDamg   = trim(wdetail2.inspDamg)      /* รายการความเสียหาย*/
           wdetail.inspAcc    = trim(wdetail2.inspAcc )       /* อุปกรณ์เสริม */
           /* end : A65-0288 */
           /* A67-0076 */ 
            wdetail.hp          = deci(wdetail2.hp)   
            wdetail.dateregis   = wdetail2.dateregis     
            wdetail.pay_option  = wdetail2.pay_option    
            wdetail.battno      = wdetail2.battno        
            /*wdetail.battyr      = wdetail2.battyr*/
            wdetail.battyr      = IF (wdetail2.battyr = "" OR wdetail2.battyr = "0") AND index(wdetail2.subclass,"E") <> 0 THEN  trim(wdetail2.cyear) ELSE wdetail2.battyr 
            wdetail.maksi       = deci(wdetail2.maksi)         
            wdetail.chargno     = wdetail2.chargno       
            wdetail.veh_key     = wdetail2.veh_key 
            wdetail.redbook     = TRIM(wdetail2.veh_key) . /*A67-0198*/     .
           /* end : A67-0076 */ 
       /*END.*/
   END.  /*if avail*/
   RUN proc_chkcomp. 
   /* comment by : A67-0198 ...
   IF deci(wdetail.premt)  =  600 THEN DO:
    ASSIGN wdetail.subclass   = "110"     
           wdetail.seat      =  "7"       /*เก๋ง /vehuse1*/
           wdetail.body      =  "SEDAN" .   
   END.
   ELSE IF deci(wdetail.premt)  =  1100  THEN DO:
    ASSIGN wdetail.subclass   = "120A"    
           wdetail.seat      =  "12"     /*ตู้ /vehuse1*/
           wdetail.body      =  "VAN" .     
   END.
   ELSE IF deci(wdetail.premt)  =  2050  THEN DO:
    CREATE wdetail.                      
    ASSIGN wdetail.subclass   = "120B"    
           wdetail.seat      =  "15"     /*ตู้ /vehuse1*/
           wdetail.body      =  "VAN" . 
   END.
   ELSE IF deci(wdetail.premt)  =  3200  THEN DO:
    ASSIGN wdetail.subclass   = "120C"    
           wdetail.seat      =  "20"     /*ตู้ /vehuse1*/
           wdetail.body      =  "VAN" . 
   END.
   ELSE IF deci(wdetail.premt)  =  3740 THEN DO:
    ASSIGN wdetail.subclass   = "120D"    
           wdetail.seat      =  "40"     /*ตู้ /vehuse1*/
           wdetail.body      =  "VAN" .     
   END.
   ELSE IF deci(wdetail.premt)  =  900  THEN DO:
       ASSIGN wdetail.subclass   = "140A"    
           wdetail.seat      =  "3"      /*กระบะ /vehuse1*/
           wdetail.body      =  "PICKUP" .     
   END. 
   ELSE IF deci(wdetail.premt)  =  1220 THEN DO:
    ASSIGN wdetail.subclass   = "140B"    
           wdetail.seat      =  "3"      /*กระบะ /vehuse1*/
           wdetail.body      =  "TRUCK" .    
   END.
   ELSE IF deci(wdetail.premt)  =  1310 THEN DO:
    ASSIGN wdetail.subclass   = "140C"    
           wdetail.seat      =  "3"      /*กระบะ /vehuse1*/
           wdetail.body      =  "TRUCK" .     
   END.
   ELSE IF deci(wdetail.premt)  =  1700 THEN  DO: 
    ASSIGN wdetail.subclass   = "140D"    
           wdetail.seat      =  "3"      /*กระบะ /vehuse1*/ 
           wdetail.body      =  "TRUCK" .     
   END.
   ELSE IF deci(wdetail.premt)  =  1900 THEN DO:
    ASSIGN wdetail.subclass   = "210"      /*เก๋ง vehuse2*/
           wdetail.seat      = "7"  
           wdetail.body      =  "SEDAN" . 
   END.
    /*ตู้ vehuse2*/
   ELSE IF deci(wdetail.premt)  =  2320  THEN DO:
    ASSIGN wdetail.subclass   = "220A" 
           wdetail.seat      = "12"
           wdetail.body      =  "VAN" .
   END.
   ELSE IF deci(wdetail.premt)  =  3480 THEN DO:
    ASSIGN wdetail.subclass   = "220B"
           wdetail.seat      = "15"
           wdetail.body      =  "VAN" .  
   END.
   ELSE IF deci(wdetail.premt)  =  6660 THEN DO:
    ASSIGN wdetail.subclass   = "220C"
           wdetail.seat      = "20"
           wdetail.body      =  "VAN" .     
   END.
   ELSE IF deci(wdetail.premt)  =  7520  THEN DO:
    ASSIGN wdetail.subclass   = "220D"
           wdetail.seat      = "40"
           wdetail.body      =  "VAN" .     
   END.
    /*รถยนต์บรรทุก  เช็คตัน vehuse2*/
    /* open comment by A60-0542*/
   ELSE IF deci(wdetail.premt)  =  1760 THEN DO:
    ASSIGN wdetail.subclass   = "240A"
           wdetail.seat      = "3"
           wdetail.body      =  "PICKUP" .     
   END.
   ELSE IF deci(wdetail.premt)  =  1830 THEN DO:
    ASSIGN wdetail.subclass   = "240B"
           wdetail.seat      = "3"
           wdetail.body      =  "TRUCK" .      
   END.
   ELSE IF deci(wdetail.premt)  =  1980 THEN DO:
    ASSIGN wdetail.subclass   = "240C"
           wdetail.seat      = "3"
           wdetail.body      =  "TRUCK" .    
   END.
   ELSE IF deci(wdetail.premt)  =  2530  THEN DO:
    ASSIGN wdetail.subclass   = "240D"
           wdetail.seat       = "3"
           wdetail.body       =  "TRUCK" .   
   END.
   ....end A67-0198...*/ 
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
DEF VAR number_sic AS INTE INIT 0.
def var n_vatcode  AS char format "x(12)" .
def var n_dealer   AS char format "x(12)" .
DEF VAR n_producer AS CHAR FORMAT "x(12)" .
DEF VAR n_agent    AS CHAR FORMAT "x(12)" .
DEF VAR Nv_brchk   AS CHAR FORMAT "x(5)" INIT "" .  
def var nv_prmtdriv as DECI INIT 0 .
def var nv_drivnam  as char format "x(2)" .
def var nv_ndriv1   as char format "x(50)" .
def var nv_bdate1   as char format "x(50)" .
def var nv_id1      as char format "x(50)" .
def var nv_ndriv2   as char format "x(50)" .
def var nv_bdate2   as char format "x(50)" .
def var nv_id2      as char format "x(50)" .
/* A67-0076 */
DEF VAR nr_maksi    AS DECI FORMAT ">>>,>>>,>>9.99" init  0 .
DEF VAR nr_hp       AS CHAR FORMAT "X(50)" init  "" .   
DEF VAR nr_battyr   AS CHAR FORMAT "X(50)" init  "" .   
DEF VAR nr_battper  AS DECI FORMAT ">>>9.99" INIT 0 .  
/* end : a67-0076 */
DEFINE VAR nre_premt      AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/
ASSIGN 
    n_firstdat = ""         nv_prmtdriv  = 0
    nv_basere  = 0          nv_drivnam   = "N"
    n_411 = 0               nv_ndriv1    = ""
    n_412 = 0               nv_bdate1    = ""
    n_42 = 0                nv_id1       = ""
    n_43 = 0                nv_ndriv2    = ""
    dod1 = 0                nv_bdate2    = ""
    dod2 = 0                nv_id2       = ""
    dod0 = 0                nre_premt  = 0     
    nv_dss_per = 0          nr_maksi   = 0  /*A67-0076*/
    nv_cl_per  = 0          nv_driver  = "" /* A67-0076*/
    n_prmtxt   = ""         nr_hp      = ""  /*A67-0076*/
    Nv_brchk   = ""         nr_battyr  = ""  /*A67-0076*/
    n_vatcode  = ""         nr_battper = 0  /*A67-0076*/
    n_dealer   = "" 
    n_producer = ""
    n_agent    = "". 

ASSIGN fi_show = "Connect Expiry......".
DISP fi_show WITH FRAM fr_main.
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
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwexpkk
        (INPUT-OUTPUT wdetail.prepol,   /*n_prepol  */ 
         INPUT-OUTPUT nv_brchk,
         INPUT-OUTPUT n_producer, /*Producer  */
         INPUT-OUTPUT n_agent,    /*Agent     */
         INPUT-OUTPUT wdetail.dealtms,  /* Dealer */
         INPUT-OUTPUT n_vatcode ,  /* vat code */
         INPUT-OUTPUT n_firstdat,       /* First Date: */
         INPUT-OUTPUT wdetail.prempa,   /*n_prempa  */  
         INPUT-OUTPUT wdetail.subclass, /*n_subclass*/  
         INPUT-OUTPUT wdetail.redbook,  /*n_redbook */  
         INPUT-OUTPUT wdetail.brand,    /*n_brand   */  
         INPUT-OUTPUT wdetail.model,    /*n_model   */  
         INPUT-OUTPUT wdetail.caryear,  /*n_caryear */
         INPUT-OUTPUT wdetail.cargrp,   /*n_cargrp  */ 
         INPUT-OUTPUT wdetail.body, 
         INPUT-OUTPUT wdetail.cc,       
         INPUT-OUTPUT wdetail.weight,   
         INPUT-OUTPUT wdetail.seat,     /*n_seat    */     
         INPUT-OUTPUT wdetail.vehuse,   /*n_vehuse  */  
         INPUT-OUTPUT wdetail.covcod,   /*n_covcod  */  
         INPUT-OUTPUT wdetail.garage,   /*n_garage  */
         INPUT-OUTPUT wdetail.deductpp, /*n_tp1     */  
         INPUT-OUTPUT wdetail.deductba, /*n_tp2     */  
         INPUT-OUTPUT wdetail.deductpa, /*n_tp3     */   
         INPUT-OUTPUT nv_basere,        /*nv_basere */
         INPUT-OUTPUT wdetail.seat41,   /* INTE                */    
         INPUT-OUTPUT n_411,             /* INTE     n_41       */ 
         INPUT-OUTPUT n_412 ,
         INPUT-OUTPUT n_42,             /* DECI     n_42       */  
         INPUT-OUTPUT n_43,             /* DECI     n_43       */  
         INPUT-OUTPUT dod1,             /* DECI     n_dod      */  
         INPUT-OUTPUT dod2,             /* DECI     n_dod2     */
         INPUT-OUTPUT dod0,             /* DECI     n_pd       */  
         INPUT-OUTPUT wdetail.fleet,    /*n DECI    _feet      */  
         INPUT-OUTPUT WDETAIL.NCB,      /* DECI     n_ncb      */  
         INPUT-OUTPUT nv_dss_per,       /* DECI     nv_dss_per */  
         INPUT-OUTPUT nv_cl_per,
         INPUT-OUTPUT n_prmtxt,          /* A55-0114 */
         input-output nv_prmtdriv ,
         input-output nv_drivnam ,  
         input-output nv_ndriv1  , 
         input-output nv_bdate1  , 
         input-output nv_id1     , 
         input-output nv_ndriv2  , 
         input-output nv_bdate2  , 
         input-output nv_id2    ,
         INPUT-OUTPUT nre_premt ,
         /* A67-0076 */
         INPUT-OUTPUT nv_driver ,
         INPUT-OUTPUT nr_maksi, 
         INPUT-OUTPUT nr_hp,
         INPUT-OUTPUT nr_battyr,
         INPUT-OUTPUT nr_battper) .   
         /* end A67-0076 */
END. 
wdetail.premt = STRING(nre_premt).
/* A67-0076 */
IF index(wdetail.subclass,"E") <> 0 THEN DO:
    ASSIGN wdetail.maksi   = nr_maksi
           wdetail.hp      = DECi(nr_hp)
           wdetail.battyr  = nr_battyr
           wdetail.battper = nr_battper .
END.
/* end : A67-0076 */

IF nv_drivnam = "Y" THEN DO:
    ASSIGN 
    wdetail.drivnam   = nv_drivnam .
  /* comment by :A67-0076 ..
    wdetail.drivnam1  = if trim(wdetail.drivnam1) = "" then  trim(nv_ndriv1)  else trim(wdetail.drivnam1)    /* ผู้ขับขี่ที่ 1    */  
    wdetail.drivbir1  = if trim(wdetail.drivbir1) = "" then  trim(nv_bdate1)  else trim(wdetail.drivbir1)    /* วันเกิดผู้ขับขี่ 1*/  
    wdetail.drivid1   = if trim(wdetail.drivid1 ) = "" then  trim(nv_id1)     else trim(wdetail.drivid1 )    /* เลขที่ใบขับขี่ 1  */  
    wdetail.drivnam2  = if trim(wdetail.drivnam2) = "" then  trim(nv_ndriv2)  else trim(wdetail.drivnam2)    /* ผู้ขับขี่ที่ 2    */  
    wdetail.drivbir2  = if trim(wdetail.drivbir2) = "" then  trim(nv_bdate2)  else trim(wdetail.drivbir2)    /* วันเกิดผู้ขับขี่ 2*/  
    wdetail.drivid2   = if trim(wdetail.drivid2 ) = "" then  trim(nv_id2)     else trim(wdetail.drivid2 ) .   /* เลขที่ใบขับขี่ 2 */  
    ...end A67-0076 */
END.

IF wdetail.dealtms <> "" THEN DO:
  FIND FIRST stat.insure USE-INDEX insure03 WHERE       
        stat.insure.compno = "kk"                       AND 
        trim(wdetail.dealtms) = trim(stat.insure.fname) NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.insure THEN ASSIGN wdetail.branch  = CAPS(stat.insure.branch) . 
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2 C-Win 
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
    IF wdetail.prepol = " " THEN DO:
        IF (wdetail.subclass = "110") OR (wdetail.subclass = "F110") OR 
                (wdetail.subclass = "G110") THEN   aa = 3000.
        ELSE IF (wdetail.subclass = "210") OR (wdetail.subclass = "Z210") OR 
                (wdetail.subclass = "Y210") THEN aa = 6000.
        ELSE IF (wdetail.subclass = "320") OR (wdetail.subclass = "V320") OR (wdetail.subclass = "Z320")THEN aa = 6000.
    END.
    ELSE aa = nv_basere. 
    IF aa = 0 THEN DO:
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    RUN proc_chkdrive. /*A67-0076 */
    
    ASSIGN
        /*nv_drivvar = ""*/ /*A67-0076 */
        chk = NO
        NO_basemsg = " "
        nv_baseprm = aa .
       /* nv_drivvar1 = wdetail.drivnam1.*/  /*A67-0076 */
    /* comment by : A67-0076...
    /*IF wdetail.drivnam1 <> ""  THEN  nv_drivno = 1.  
    ELSE IF wdetail.drivnam1 = ""  THEN  nv_drivno = 0. */
    
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
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        Assign
            nv_drivvar     = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.  /*drivernam...*/
    ....end A67-0076....*/
    IF NO_basemsg <> " " THEN 
        wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN nv_basevar = "" 
        nv_prem1   = nv_baseprm
        nv_basecod = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    /* add by A63-0130 */
    IF wdetail.prepol <> "" THEN  
        ASSIGN  nv_411 = n_411
                nv_412 = n_412
                nv_42  = n_42
                nv_43  = n_43. 
    ELSE
        ASSIGN  nv_411 = int(wdetail.no_411)
                nv_412 = int(wdetail.no_412)
                nv_42  = int(wdetail.no_42)
                nv_43  = int(wdetail.no_43).
     /*....end A63-0130....*/
    IF      wdetail.subclass = "110"  THEN wdetail.seat = "7".
    ELSE IF wdetail.subclass = "210"  THEN wdetail.seat = "12".
    ELSE IF wdetail.subclass = "320"  THEN wdetail.seat = "3".

    IF wdetail.covcod = "2" THEN DO:
        ASSIGN nv_411 = 50000
               nv_412 = 50000
               nv_42  = 50000
               nv_43  = 200000 .
    END.
        
    nv_seat41 = integer(wdetail.seat).   /*integer(wdetail.seat)*/ 
    Assign nv_411var = ""   nv_412var = ""                                                    
        nv_41cod1   = "411"
        nv_411var1  = "     PA Driver = "
        nv_411var2  =  STRING(nv_411)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(nv_412)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_411
        nv_412prm  = nv_412.

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
    
    /*------nv_usecod------------*/
    Assign  nv_usevar = ""
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
     ASSIGN nv_bipvar   = ""
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(wdetail.deductpp)
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign  nv_biavar  = ""
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(wdetail.deductba)
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN nv_pdavar   = ""
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         /*nv_pdavar2     = STRING(uwm130.uom5_v)   a52-0172*/
         nv_pdavar2     = string(deci(WDETAIL.deductpa))        /*A52-0172*/
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
    
    ASSIGN nv_dedod1var   = ""  nv_dedod2var   = " " .
    IF dod1 <> 0 THEN DO:
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
         Assign  
             nv_dedod2var   = " "
             nv_cons  = "AD"
             nv_ded   = dod2.
         IF dod2 <> 0 THEN
            Assign
                nv_aded1prm     = nv_prem
                nv_dedod2_cod   = "DOD2"
                nv_dedod2var1   = "     Add Ded.OD = "
                nv_dedod2var2   =  STRING(dod2)
                SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
                SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2.
             /*nv_dedod2_prm   = nv_prem.*/
    END.
     /***** pd *******/
    nv_dedpdvar  = " " .
    IF dod0  <> 0 THEN DO:
        Assign
             nv_cons  = "PD"
             nv_ded   = dod0 .    
        ASSIGN nv_dedpdvar = "" 
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(nv_ded)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
           
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
     ELSE DO:
        ASSIGN
            nv_fletvar     = " "
            nv_fletvar1    = "     Fleet % = "
            nv_fletvar2    =  STRING(nv_flet_per)
            SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
            SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     END.
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
         ELSE DO:
             ASSIGN
             nv_ncbper = xmm104.ncbper   
             nv_ncbyrs = xmm104.ncbyrs.
         END.
         
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
     
     
     nv_dsspcvar   = " ".
     IF  nv_dss_per  <> 0  THEN
       Assign
       nv_dsspcvar1   = "     Discount Special % = "
       nv_dsspcvar2   =  STRING(nv_dss_per)
       SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
       SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
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
    ASSIGN fi_show = "Create data to base..." + wdetail.policy .
    DISP fi_show WITH FRAM fr_main.
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
        nv_message = "". /* ranu : A65-0288*/
    ASSIGN               
        nv_covcod  = wdetail.covcod                                              
        nv_class   = trim(wdetail.prempa) +  trim(wdetail.subclass)                                       
        nv_vehuse  = wdetail.vehuse                                    
        /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
        nv_engcst  = 1900*/ /* ต้องใส่ค่าตาม nv_cstflg         
        nv_drivno  = 0   */                                     
        nv_driage1 = nv_drivage1                                 
        nv_driage2 = nv_drivage2                                    
        nv_yrmanu  = INT(wdetail.caryear)                         
        /*nv_totsi   = sic_bran.uwm130.uom6_v   */ /* A65-0288 */
        nv_totsi   = IF sic_bran.uwm130.uom6_v = 0 THEN sic_bran.uwm130.uom7_v ELSE sic_bran.uwm130.uom6_v    /*ranu : A65-0288*/
        nv_totfi   = sic_bran.uwm130.uom7_v
        nv_vehgrp  = wdetail.cargrp                                                     
        nv_access  = ""                                             
        /*nv_supe    = NO*/                                              
        nv_tpbi1si = sic_bran.uwm130.uom1_v            
        nv_tpbi2si = sic_bran.uwm130.uom2_v            
        nv_tppdsi  = sic_bran.uwm130.uom5_v            
        nv_411si   = deci(nv_411)       
        nv_412si   = deci(nv_412)       
        nv_413si   = 0                       
        nv_414si   = 0                       
        nv_42si    = deci(nv_42)                
        nv_43si    = deci(nv_43)                
        nv_seat41  = INT(wdetail.seat41)   
        nv_dedod   = deci(DOD1)       
        nv_addod   = deci(DOD2)                                
        nv_dedpd   = deci(DOD0)                                     
        nv_ncbp    = deci(wdetail.ncb)                                     
        nv_fletp   = deci(wdetail.fleet)                                  
        nv_dspcp   = deci(nv_dss_per)                                      
        nv_dstfp   = 0                                                     
        nv_clmp    = nv_cl_per
        /*nv_netprem  = TRUNCATE(((deci(wdetail.volprem) * 100 ) / 107.43 ),0 ) + 
                   (IF ((deci(wdetail.volprem) * 100) / 107.43) - TRUNCATE(((deci(wdetail.volprem) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )
        wdetail.premt = STRING(nv_netprem,">>>,>>>,>>9.99") */
        nv_netprem  = DECI(wdetail.premt) /* เบี้ยสุทธิ */                                                
        nv_gapprm  = 0                                                       
        nv_flagprm = "N"  /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
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
            /*RUN wgw/wgwredbook (input  wdetail.brand , */  /*A65-0288*/
              RUN wgw/wgwredbk1 (input  wdetail.brand ,      /*A65-0288*/ 
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
            /*RUN wgw/wgwredbook (input  wdetail.brand , */  /*A65-0288*/
              RUN wgw/wgwredbk1 (input  wdetail.brand ,      /*A65-0288*/
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
                WHERE stat.maktab_fil.sclass = wdetail.subclass      AND
                stat.maktab_fil.modcod = wdetail.redbook
                No-lock no-error no-wait.
            If  avail  stat.maktab_fil  Then 
                ASSIGN  
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod    
                wdetail.cargrp          =  stat.maktab_fil.prmpac
                nv_vehgrp               =  stat.maktab_fil.prmpac
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac.
        END.
        ELSE DO:
            ASSIGN
                wdetail.comment = wdetail.comment + "| " + "Redbook is Null !! "
                wdetail.WARNING = "Redbook เป็นค่าว่าง " 
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
    IF nv_polday < 365 THEN DO:
        nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat).
        nv_netprem = TRUNCATE((nv_netprem / nv_polday ) * 365 ,0) +
                     (IF ((nv_netprem / nv_polday ) * 365 ) - Truncate((nv_netprem / nv_polday ) * 365,0) > 0 Then 1 
                      Else 0). 
    END.
       /* MESSAGE 
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
    " nv_netprem       "  nv_baseprm    SKIP
    " nv_netprem       "  nv_netprem    skip  
    " nv_gapprm        "  nv_gapprem    skip  
    " nv_flagprm       "  nv_flagprm    skip  
    " wdetail.comdat   "  nv_effdat     skip 
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.   */
   
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
                       INPUT-OUTPUT nv_fcctv ,  /* cctv = yes/no */
                       OUTPUT nv_uom1_c,  
                       OUTPUT nv_uom2_c,  
                       OUTPUT nv_uom5_c,  
                       OUTPUT nv_uom6_c,
                       OUTPUT nv_uom7_c,
                       OUTPUT nv_status, 
                       OUTPUT nv_message).  

    IF nv_status = "no" THEN DO:
        /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt + nv_message VIEW-AS ALERT-BOX.
        ASSIGN
            wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
            wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt
            wdetail.pass    = "Y"     
            wdetail.OK_GEN  = "N".*/
        /* ranu : A65-0288*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0  THEN wdetail.pass = "N" .
        ASSIGN
            wdetail.comment = wdetail.comment + "| " + nv_message
            wdetail.WARNING = wdetail.WARNING + "|" +  nv_message.
        /* end : A65-0288*/
    END.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt_ev C-Win 
PROCEDURE proc_calpremt_ev :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A67-0114      
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "V70" THEN DO:
        ASSIGN fi_show = "Create data to base..." + wdetail.policy .
        DISP fi_show WITH FRAM fr_main.
        RUN proc_initcal.
        ASSIGN               
            nv_covcod  = wdetail.covcod                                              
            nv_class   = trim(wdetail.prempa) + trim(wdetail.subclass)     /* T110 */                                     
            nv_vehuse  = wdetail.vehuse                                    
           /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
            nv_engcst  = 1900*/ /* ต้องใส่ค่าตาม nv_cstflg         
            nv_drivno  = 0   */                                     
            nv_driage1 = nv_drivage1                                 
            nv_driage2 = nv_drivage2                                    
            nv_yrmanu  = INT(wdetail.caryear)          
            nv_totsi   = IF sic_bran.uwm130.uom6_v = 0 THEN sic_bran.uwm130.uom7_v ELSE sic_bran.uwm130.uom6_v /*A66-0202*/
            nv_totfi   = sic_bran.uwm130.uom7_v
            nv_vehgrp  = wdetail.cargrp                                                     
            nv_access  = ""                                         
           /*nv_supe    = NO*/                                              
            nv_tpbi1si = sic_bran.uwm130.uom1_v          
            nv_tpbi2si = sic_bran.uwm130.uom2_v          
            nv_tppdsi  = sic_bran.uwm130.uom5_v          
            nv_411si   = deci(nv_411)             
            nv_412si   = deci(nv_412)             
            nv_413si   = 0                          
            nv_414si   = 0                        
            nv_42si    = deci(nv_42)             
            nv_43si    = deci(nv_43) 
            nv_41prmt  = 0                      /* ระบุเบี้ย รย.*/  
            nv_412prmt = 0                      /* ระบุเบี้ย รย.*/ 
            nv_413prmt = 0                      /* ระบุเบี้ย รย.*/ 
            nv_414prmt = 0                      /* ระบุเบี้ย รย.*/ 
            nv_42prmt  = 0                      /* ระบุเบี้ย รย.*/  
            nv_43prmt  = 0                      /* ระบุเบี้ย รย.*/  
            nv_seat41  = INT(wdetail.seat41)
            nv_dedod   = deci(DOD1)         
            nv_addod   = deci(DOD2)                        
            nv_dedpd   = deci(DOD0)                             
            nv_ncbp    = deci(wdetail.ncb)                                   
            nv_fletp   = deci(wdetail.fleet)                                
            nv_dspcp   = deci(nv_dss_per)                              
            nv_dstfp   = 0                                                     
            nv_clmp    = nv_cl_per
            nv_mainprm  = 0  
            nv_dodamt   = 0  /*A67-0029*/ /* ระบุเบี้ย DOD */   
            nv_dadamt   = 0  /*A67-0029*/ /* ระบุเบี้ย DOD1 */  
            nv_dpdamt   = 0  /*A67-0029*/ /* ระบุเบี้ย DPD */   
            nv_ncbamt   = 0  /* ระบุเบี้ย  NCB PREMIUM */           
            nv_fletamt  = 0  /* ระบุเบี้ย  FLEET PREMIUM */          
            nv_dspcamt  = 0  /* ระบุเบี้ย  DSPC PREMIUM */           
            nv_dstfamt  = 0  /* ระบุเบี้ย  DSTF PREMIUM */           
            nv_clmamt   = 0  /* ระบุเบี้ย  LOAD CLAIM PREMIUM */    
            /* end : A65-0079*/
            nv_baseprm  = 0
            nv_baseprm3 = 0
            nv_netprem  = DECI(wdetail.premt) 
            nv_pdprem   = nv_netprem /* เบี้ยสุทธิ เบี้ยเต็มปี */
            nv_gapprem  = nv_netprem
            nv_gapprm   = 0                                                     
            nv_flagprm  = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
            nv_effdat   = sic_bran.uwm100.comdat
            nv_ratatt   = 0                    
            nv_siatt    = 0                                                  
            nv_netatt   = 0      
            nv_fltatt   = 0     
            nv_ncbatt   = 0     
            nv_dscatt   = 0
            nv_attgap   = 0
            nv_atfltgap = 0
            nv_atncbgap = 0
            nv_atdscgap = 0
            nv_packatt  = ""
            nv_flgsht   = "P" 
            nv_fcctv    = NO 
            /* A67-0029*/
            nv_level      = INTE(wdetail.drivlevel)   
            nv_levper     = DECI(nv_dlevper) 
            nv_tariff     = wdetail.tariff
            nv_adjpaprm   = NO
            nv_flgpol     = IF wdetail.prepol = "" THEN "NR" ELSE "RN" /*NR=New RedPlate, NU=New Used Car, RN=Renew*/                   
            nv_flgclm     = IF nv_clmp <> 0 THEN "WC" ELSE "NC"  /*NC=NO CLAIM , WC=With Claim*/  
            nv_chgflg     = NO /*IF DECI(wdetail.chargprm) <> 0 THEN YES ELSE NO  */   
            nv_chgrate    = 0 /*DECI(wdetail.chargrate)                          */
            nv_chgsi      = 0 /*INTE(wdetail.chargsi)                            */          
            nv_chgpdprm   = 0 /*DECI(wdetail.chargprm)                           */           
            nv_chggapprm  = 0                                     
            nv_battflg    = NO  /*IF DECI(wdetail.battprm) <> 0 THEN YES ELSE NO*/                                    
            nv_battrate   = 0  /*DECI(wdetail.battrate)                        */            
            nv_battsi     = 0  /*INTE(wdetail.battsi)                          */           
            nv_battprice  = 0  /*INTE(wdetail.battprice)                       */
            nv_battpdprm  = 0  /*DECI(wdetail.battprm)                         */            
            nv_battgapprm = 0                                                                                                                     
            nv_battyr     = INTE(wdetail.battyr)                                  
            nv_battper    = DECI(wdetail.battper)                                 
            nv_evflg      = IF index(wdetail.subclass,"E") <> 0 THEN YES ELSE NO   
            nv_compprm  = 0
            nv_uom9_v   = 0 .
            /* end A67-0029*/
            /*nv_status  = "" */
         FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
               clastab_fil.CLASS  = nv_class     AND
               clastab_fil.covcod = wdetail.covcod    NO-LOCK NO-ERROR.
            IF AVAIL stat.clastab_fil THEN DO:
                IF clastab_fil.unit = "C" THEN DO:
                    ASSIGN nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" OR SUBSTR(nv_class,2,1) = "E" THEN "H" ELSE clastab_fil.unit
                           nv_engine = IF SUBSTR(nv_class,5,1) = "E" OR SUBSTR(nv_class,2,1) = "E" THEN DECI(wdetail.hp) ELSE INT(wdetail.cc).
                END.
                ELSE IF clastab_fil.unit = "S" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = INT(wdetail.seat).
                END.
                ELSE IF clastab_fil.unit = "T" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = DECI(sic_bran.uwm301.Tons).
                END.
                ELSE IF clastab_fil.unit = "H" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = DECI(wdetail.cc). 
                END.
                nv_engcst = nv_engine .
            END.
        IF wdetail.redbook = ""  THEN DO:
            IF nv_cstflg = "W" OR nv_cstflg = "H" THEN DO:
                RUN wgw/wgwredbev(input  wdetail.brand ,      
                                   input wdetail.model ,  
                                   input INT(wdetail.si) ,  
                                   INPUT wdetail.tariff,  
                                   input SUBSTR(nv_class,2,5),   
                                   input wdetail.caryear, 
                                   input nv_engine  ,
                                   input 0, 
                                   INPUT-OUTPUT wdetail.maksi,
                                   INPUT-OUTPUT wdetail.redbook) .
            END.
        END.
        IF wdetail.redbook <> ""  THEN DO: 
            FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                WHERE stat.maktab_fil.sclass = wdetail.subclass     AND
                stat.maktab_fil.modcod       = wdetail.redbook   
                No-lock no-error no-wait.
            If  avail  stat.maktab_fil  Then 
                ASSIGN
                sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
                wdetail.cargrp         =  stat.maktab_fil.prmpac
                sic_bran.uwm301.vehgrp =  stat.maktab_fil.prmpac
                nv_vehgrp              =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body   =  stat.maktab_fil.body 
                sic_bran.uwm301.tons   =  stat.maktab_fil.tons 
                sic_bran.uwm301.engine =  IF sic_bran.uwm301.engine = 0 THEN stat.maktab_fil.engine ELSE sic_bran.uwm301.engine
                wdetail.body           =  IF wdetail.body = "" THEN stat.maktab_fil.body ELSE wdetail.body   /*A65-0035*/
                sic_bran.uwm301.maksi  =  IF deci(wdetail.maksi) = 0 THEN stat.maktab_fil.si ELSE DECI(wdetail.maksi) .
        END.
        ELSE DO:
            ASSIGN
                wdetail.comment = wdetail.comment + "| " + "Redbook is Null !! "
                wdetail.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ " 
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".
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
        END.
    RUN WUW\WUWMCP01.P(INPUT sic_bran.uwm100.policy,
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
                     INPUT "wgwtcgen"  ,
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
                     INPUT 50,    /*cv_lncbper  = Limit NCB %  50%*/                                                                                                                           
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
                     INPUT-OUTPUT nv_mainprm,  /* Main Premium ????????????? ??? Name/Unname Premium (HG) */
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
                     INPUT-OUTPUT nv_compprm ,
                     INPUT-OUTPUT nv_uom9_v  ,
                     INPUT-OUTPUT nv_fcctv ,  /* cctv = yes/no */
                     INPUT-OUTPUT nv_flgsht , /* Short rate = "S" , Pro rate = "P" */
                     INPUT-OUTPUT nv_evflg , /* EV = yes/no */
                     OUTPUT nv_uom1_c,
                     OUTPUT nv_uom2_c,
                     OUTPUT nv_uom5_c,
                     OUTPUT nv_uom6_c,
                     OUTPUT nv_uom7_c,
                     output nv_gapprm,
                     output nv_pdprm ,
                     OUTPUT nv_status,
                     OUTPUT nv_message).
    ASSIGN                        
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
    IF nv_message <> "" THEN DO:   /*A65-0079*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN wdetail.pass  = "N". /*A65-0043*/
        ASSIGN
                wdetail.comment = wdetail.comment + "|" + nv_message
                wdetail.WARNING = wdetail.WARNING + "|" + nv_message.
    END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcampaign C-Win 
PROCEDURE proc_chkcampaign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by a65-0203     
------------------------------------------------------------------------------*/
DEF VAR nv_camp1 AS CHAR INIT "".  /*---add by Chaiyong W. A61-0015 14/03/2018*/
DEF VAR nv_year  AS CHAR INIT "".
DEF VAR nv_camp2 AS CHAR INIT "".
DEF VAR n_yr     AS INTE INIT 0.
DEF VAR n_model  AS CHAR INIT "" .
DEF VAR nv_cc AS CHAR INIT 0.
IF wdetail.product <> "" THEN DO: 
 fi_show = "Check Campaign policy: " + wdetail.policy.
 DISP fi_show WITH FRAME fr_main.

 FIND LAST stat.caccount USE-INDEX caccount05 WHERE caccount.camcod = TRIM(wdetail.product) NO-LOCK NO-ERROR.
 IF NOT AVAIL stat.caccount THEN DO:
     ASSIGN wdetail.comment = wdetail.comment + "| " +  "ไม่พบรหัสแคมเปญ :" + wdetail.product + " ในระบบพารามิเตอร์ UW"
            wdetail.pass    = "Y".
 END.
 ELSE DO:   
  FIND LAST stat.campaign_fil USE-INDEX campfil14  WHERE campaign_fil.camcod = caccount.camcod NO-LOCK NO-ERROR.
      IF NOT AVAIL stat.campaign_fil THEN DO:
          ASSIGN wdetail.comment = wdetail.comment + "| " + "Campaign code : " + wdetail.product + " ยังไม่มีวิธีคีย์ในระบบพารามิเตอร์" 
                 wdetail.pass    = "Y" .  
      END.
      ELSE DO:
         nv_camp1 = trim(wdetail.product).
        /* เช็ค แพ็คเกจ ในพารามิเตอร์ uw  */
        IF nv_camp1 <> ""  THEN DO:
           ASSIGN n_yr = 0       
                  n_yr = (YEAR(TODAY) - DECI(wdetail.caryear)) + 1.
           CREATE wexcamp.
           ASSIGN wexcamp.policy    = wdetail.policy
                  wexcamp.campaign  = wdetail.product.
              IF wdetail.covcod = "1"  THEN DO:
                  IF wdetail.subclass <> "110" THEN DO:  /* 110E 210 320 */ 
                     FIND LAST stat.campaign_fil USE-INDEX campfil04      WHERE 
                          stat.campaign_fil.camcod = nv_camp1             AND /* campaign no */
                          stat.campaign_fil.sclass = wdetail.subclass     AND /* class 110 210 320 */
                          stat.campaign_fil.covcod = wdetail.covcod       AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                          stat.campaign_fil.garage = wdetail.garage       AND /* การซ่อม */
                          stat.campaign_fil.maxyea = n_yr                 AND /* อายุรถ */
                          stat.campaign_fil.simax  = deci(wdetail.si)     AND  /* ทุน */
                          stat.campaign_fil.makdes = trim(wdetail.brand)  AND 
                          (index(wdetail.model,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                          index(stat.campaign_fil.moddes,wdetail.model)  <> 0 ) AND   /* Model */ 
                          stat.campaign_fil.netprm  = deci(wdetail.premt)   NO-LOCK NO-ERROR. 
                     IF AVAIL stat.campaign_fil THEN DO:
                        ASSIGN   
                            wdetail.prempa    = stat.campaign_fil.paccod
                            wdetail.deductpp  = string(stat.campaign_fil.uom1_v) 
                            wdetail.deductba  = string(stat.campaign_fil.uom2_v) 
                            wdetail.deductpa  = string(stat.campaign_fil.uom5_v) 
                            wdetail.no_411    = string(stat.campaign_fil.mv411) 
                            wdetail.no_412    = string(stat.campaign_fil.mv412) 
                            wdetail.no_42     = string(stat.campaign_fil.mv42)  
                            wdetail.no_43     = string(stat.campaign_fil.mv43)  
                            wexcamp.polmaster = stat.campaign_fil.polmst
                            wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                            wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                            wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                            wexcamp.pa411     = stat.campaign_fil.mv411
                            wexcamp.pa412     = stat.campaign_fil.mv412
                            wexcamp.pa42      = stat.campaign_fil.mv42 
                            wexcamp.pa43      = stat.campaign_fil.mv43 
                            wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                            wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                            wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                            wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                            wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                            wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                            wexcamp.sumins    = wdetail.si
                            wexcamp.sumfit    = wdetail.si
                            wexcamp.Prem_t    = stat.campaign_fil.netprm  . 
                     END.
                     ELSE ASSIGN wexcamp.polmaster = "" .
                  END. /* end <> 110 */
                  ELSE DO:  /* class 110 */
                      IF wdetail.subclass = "110" THEN DO:
                           IF INT(wdetail.cc) <= 2000 THEN nv_cc = "2000".
                           ELSE IF int(wdetail.cc) > 2000 THEN nv_cc = "2001".
                      END.
                      ELSE nv_cc = "". 
                      RUN proc_chkCampaign110.
                  END.
              END. /* end ป.1 */
              ELSE IF (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN DO:
                   IF wdetail.subclass <> "110" THEN DO:  
                    FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/       WHERE                
                        stat.campaign_fil.camcod  = nv_camp1                  and  /*campaign */ 
                        stat.campaign_fil.sclass  = wdetail.subclass          and  /* class 110 210 320 */
                        stat.campaign_fil.covcod  = wdetail.covcod            and  /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                        stat.campaign_fil.garage  = wdetail.garage            and  /*   ประเภทการซ่อม   */
                        stat.campaign_fil.maxyea  = n_yr                      AND /* อายุรถ */
                        stat.campaign_fil.simax   = deci(wdetail.si)          AND  /*   วงเงินทุนประกัน */
                        stat.campaign_fil.makdes  = trim(wdetail.brand)       AND 
                        (index(wdetail.model,stat.campaign_fil.moddes) <> 0    OR   /* Model */
                        index(stat.campaign_fil.moddes,wdetail.model)  <> 0 ) AND   /* Model */ 
                        stat.campaign_fil.netprm  = deci(wdetail.premt)  NO-LOCK NO-ERROR. /* เบี้ยจากไฟล์ */
                      IF AVAIL stat.campaign_fil THEN DO:
                        ASSIGN
                            wdetail.prempa    = stat.campaign_fil.paccod
                            wdetail.deductpp  = string(stat.campaign_fil.uom1_v) 
                            wdetail.deductba  = string(stat.campaign_fil.uom2_v) 
                            wdetail.deductpa  = string(stat.campaign_fil.uom5_v) 
                            wdetail.no_411    = string(stat.campaign_fil.mv411)  
                            wdetail.no_412    = string(stat.campaign_fil.mv412)  
                            wdetail.no_42     = string(stat.campaign_fil.mv42)   
                            wdetail.no_43     = string(stat.campaign_fil.mv43)  
                            wexcamp.polmaster = stat.campaign_fil.polmst
                            wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                            wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                            wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                            wexcamp.pa411     = stat.campaign_fil.mv411
                            wexcamp.pa412     = stat.campaign_fil.mv412
                            wexcamp.pa42      = stat.campaign_fil.mv42 
                            wexcamp.pa43      = stat.campaign_fil.mv43 
                            wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                            wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                            wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                            wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                            wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                            wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                            wexcamp.sumins    = wdetail.si
                            wexcamp.sumfit    = IF (wdetail.covcod = "2.2") THEN wdetail.si ELSE "0"
                            wexcamp.Prem_t    = stat.campaign_fil.netprm .
                      END.
                      ELSE RUN proc_chkcampaignplus .
                   END. /* <> 110 */
                   ELSE DO: /* class 110 */
                       IF INT(wdetail.cc) <= 2000 THEN nv_cc = "2000".
                       ELSE IF int(wdetail.cc) > 2000 THEN nv_cc = "2001". 
                       IF int(nv_cc) <= 2000 THEN DO:
                            FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/    WHERE                
                             stat.campaign_fil.camcod  =  nv_camp1                 and     /*campaign */ /*A63-0443*/
                             stat.campaign_fil.sclass  =  wdetail.subclass         and     /* class 110 210 320 */
                             stat.campaign_fil.covcod  =  wdetail.covcod           and     /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                             stat.campaign_fil.garage  =  wdetail.garage           and     /*   ประเภทการซ่อม   */
                             stat.campaign_fil.maxyea  =  n_yr                     AND  /* อายุรถ */
                             stat.campaign_fil.engine  <= 2000                     AND     /* cc */   
                             stat.campaign_fil.simax    = deci(wdetail.si)         AND     /*   วงเงินทุนประกันสูงสุด */
                             stat.campaign_fil.makdes   = trim(wdetail.brand)      AND 
                             (index(wdetail.model,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                             index(stat.campaign_fil.moddes,wdetail.model)  <> 0 ) AND   /* Model */ 
                             stat.campaign_fil.netprm  = deci(wdetail.premt)  NO-LOCK NO-ERROR. /* เบี้ยจากไฟล์ */
                       END.
                       ELSE DO:
                            FIND LAST stat.campaign_fil /*USE-INDEX campf   il15*/ WHERE                
                             stat.campaign_fil.camcod  =  nv_camp1                 and       /*campaign */ /*A63-0443*/
                             stat.campaign_fil.sclass  =  wdetail.subclass         and       /* class 110 210 320 */
                             stat.campaign_fil.covcod  =  wdetail.covcod           and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                             stat.campaign_fil.garage  =  wdetail.garage           and       /*   ประเภทการซ่อม   */
                             stat.campaign_fil.maxyea  =  n_yr                     AND  /* อายุรถ */
                             stat.campaign_fil.engine  > 2000                      AND /* cc */  
                             stat.campaign_fil.simax   = deci(wdetail.si)          AND       /*   วงเงินทุนประกันสูงสุด */
                             stat.campaign_fil.makdes  = trim(wdetail.brand)       AND 
                             (index(wdetail.model,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                             index(stat.campaign_fil.moddes,wdetail.model)  <> 0 ) AND   /* Model */ 
                             stat.campaign_fil.netprm  = deci(wdetail.premt)  NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
                       END.
                       IF AVAIL stat.campaign_fil THEN DO:
                           ASSIGN
                               wdetail.prempa    = stat.campaign_fil.paccod
                               wdetail.deductpp  = string(stat.campaign_fil.uom1_v) 
                               wdetail.deductba  = string(stat.campaign_fil.uom2_v) 
                               wdetail.deductpa  = string(stat.campaign_fil.uom5_v) 
                               wdetail.no_411    = string(stat.campaign_fil.mv411)  
                               wdetail.no_412    = string(stat.campaign_fil.mv412)  
                               wdetail.no_42     = string(stat.campaign_fil.mv42)   
                               wdetail.no_43     = string(stat.campaign_fil.mv43)  
                               wexcamp.polmaster = stat.campaign_fil.polmst
                               wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                               wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                               wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                               wexcamp.pa411     = stat.campaign_fil.mv411
                               wexcamp.pa412     = stat.campaign_fil.mv412
                               wexcamp.pa42      = stat.campaign_fil.mv42 
                               wexcamp.pa43      = stat.campaign_fil.mv43 
                               wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                               wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                               wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                               wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                               wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                               wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                               wexcamp.sumins    = wdetail.si
                               wexcamp.sumfit    = IF (wdetail.covcod = "2.2") THEN wdetail.si ELSE "0"
                               wexcamp.Prem_t    = stat.campaign_fil.netprm .
                       END.
                       ELSE ASSIGN wexcamp.polmaster = "" . 
                   END. /* 110 */
              END. /* end ป.2+ ป.3+ */ 
              ELSE DO: /* ป2 ป3 */
                  IF wdetail.subclass = "110"  THEN DO:
                      IF INT(wdetail.cc) <= 2000 THEN nv_cc = "2000".
                      ELSE IF int(wdetail.cc) > 2000 THEN nv_cc = "2001". 
                  END.
                  ELSE nv_cc = "0".
                  IF wdetail.covcod = "2" THEN DO: /* ป 2 */
                       FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/ WHERE                
                           stat.campaign_fil.camcod  = nv_camp1            and       /*campaign */ /*A63-0443*/
                           stat.campaign_fil.sclass  = wdetail.subclass    and       /* class 110 210 320 */
                           stat.campaign_fil.covcod  = wdetail.covcod      and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                           stat.campaign_fil.maxyea  = n_yr                AND
                           stat.campaign_fil.engine  = INTE(nv_cc)         AND       /* cc */ 
                           stat.campaign_fil.simax   = deci(wdetail.si)    AND       /* ทุนประกัน */
                           stat.campaign_fil.netprm  = deci(wdetail.premt) NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
                  END.
                  ELSE DO: /* ป 3*/
                       FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                        stat.campaign_fil.camcod  = nv_camp1                and       /*campaign */ /*A63-0443*/
                        stat.campaign_fil.sclass  = wdetail.subclass        and       /* class 110 210 320 */
                        stat.campaign_fil.covcod  = wdetail.covcod          and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                        stat.campaign_fil.engine  = INTE(nv_cc)             AND       /* cc */  
                        stat.campaign_fil.netprm  = deci(wdetail.premt)  NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
                  END.
                  IF AVAIL stat.campaign_fil THEN DO:
                      ASSIGN
                        wdetail.prempa    = stat.campaign_fil.paccod
                        wdetail.deductpp  = string(stat.campaign_fil.uom1_v) 
                        wdetail.deductba  = string(stat.campaign_fil.uom2_v) 
                        wdetail.deductpa  = string(stat.campaign_fil.uom5_v) 
                        wdetail.no_411    = string(stat.campaign_fil.mv411)  
                        wdetail.no_412    = string(stat.campaign_fil.mv412)  
                        wdetail.no_42     = string(stat.campaign_fil.mv42)   
                        wdetail.no_43     = string(stat.campaign_fil.mv43)  
                        wexcamp.polmaster = stat.campaign_fil.polmst
                        wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                        wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                        wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                        wexcamp.pa411     = stat.campaign_fil.mv411
                        wexcamp.pa412     = stat.campaign_fil.mv412
                        wexcamp.pa42      = stat.campaign_fil.mv42 
                        wexcamp.pa43      = stat.campaign_fil.mv43 
                        wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                        wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                        wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                        wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                        wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                        wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                        wexcamp.sumins    = "0"
                        wexcamp.sumfit    = IF (wdetail.covcod = "2") THEN wdetail.si ELSE "0"
                        wexcamp.Prem_t    = stat.campaign_fil.netprm .
                  END.
                  ELSE ASSIGN wexcamp.polmaster = "" . 
              END.
           IF wexcamp.polmaster = "" THEN DO:
               FIND LAST stat.campaign_fil WHERE                
                             stat.campaign_fil.camcod  =  nv_camp1                 and       /*campaign */ /*A63-0443*/
                             stat.campaign_fil.sclass  =  wdetail.subclass         and       /* class 110 210 320 */
                             stat.campaign_fil.covcod  =  wdetail.covcod           and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                             stat.campaign_fil.garage  =  wdetail.garage           NO-LOCK NO-ERROR.       /*   ประเภทการซ่อม   */
               IF AVAIL stat.campaign_fil THEN DO:
                  ASSIGN wdetail.prempa   = stat.campaign_fil.paccod
                         wdetail.deductpp  = string(stat.campaign_fil.uom1_v) 
                         wdetail.deductba  = string(stat.campaign_fil.uom2_v) 
                         wdetail.deductpa  = string(stat.campaign_fil.uom5_v) 
                         wdetail.no_411    = string(stat.campaign_fil.mv411)  
                         wdetail.no_412    = string(stat.campaign_fil.mv412)  
                         wdetail.no_42     = string(stat.campaign_fil.mv42)   
                         wdetail.no_43     = string(stat.campaign_fil.mv43) .
               END.
              ASSIGN  wdetail.comment = wdetail.comment + "|" + "ไม่พบ Policy Master ตามรายละเอียดของไฟล์โหลดในแคมเปญ " + nv_camp1  
                      wdetail.pass    = "Y". 
           END.
         END. /* end nv_camp1 <> "" */
    END. /* if avail */
 END. /* end else */
 RELEASE stat.campaign_fil.
END. /* end wdetail.product <> "" */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcampaign110 C-Win 
PROCEDURE proc_chkcampaign110 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_camp1 AS CHAR INIT "".  /*---add by Chaiyong W. A61-0015 14/03/2018*/
DEF VAR n_yr     AS INTE INIT 0.
DO:
    ASSIGN nv_camp1 = trim(wdetail.product)
           n_yr = 0       
           n_yr = (YEAR(TODAY) - DECI(wdetail.caryear)) + 1 .

    IF INT(INT(wdetail.cc)) <= 2000  THEN DO:  /* 2000 CC */
      FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
       stat.campaign_fil.camcod = nv_camp1   AND /* campaign no */
       stat.campaign_fil.sclass = wdetail.subclass  AND /* class 110 210 320 */
       stat.campaign_fil.covcod = wdetail.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
       stat.campaign_fil.garage = wdetail.garage    AND /* การซ่อม */
       stat.campaign_fil.maxyea = n_yr              AND /* อายุรถ */
       stat.campaign_fil.engine <= 2000             AND /* cc */  
       stat.campaign_fil.simax  = deci(wdetail.si)  AND  /* ทุน */
       stat.campaign_fil.makdes = wdetail.brand    AND 
       (index(wdetail.model,stat.campaign_fil.moddes) <> 0   OR   /* Model */
       index(stat.campaign_fil.moddes,wdetail.model)  <> 0 ) AND   /* Model */ /*A64-0044*/
       stat.campaign_fil.netprm  = deci(wdetail.premt)   NO-LOCK NO-ERROR. 
    END.
    ELSE DO:  /* > 2000 CC */
       FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
           stat.campaign_fil.camcod = nv_camp1   AND /* campaign no */
           stat.campaign_fil.sclass = wdetail.subclass  AND /* class 110 210 320 */
           stat.campaign_fil.covcod = wdetail.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
           stat.campaign_fil.garage = wdetail.garage    AND /* การซ่อม */
           stat.campaign_fil.maxyea = n_yr              AND /* อายุรถ */
           stat.campaign_fil.engine > 2000              AND /* cc */  
           stat.campaign_fil.simax  = deci(wdetail.si)  AND  /* ทุน */
           stat.campaign_fil.makdes = wdetail.brand     AND 
           (index(wdetail.model,stat.campaign_fil.moddes) <> 0   OR   /* Model */
           index(stat.campaign_fil.moddes,wdetail.model)  <> 0 ) AND   /* Model */ /*A64-0044*/
           stat.campaign_fil.netprm  = deci(wdetail.premt)   NO-LOCK NO-ERROR. 
    END.
    IF AVAIL stat.campaign_fil THEN DO:
        ASSIGN   
          wdetail.prempa    = stat.campaign_fil.paccod
          wdetail.deductpp  = string(stat.campaign_fil.uom1_v) 
          wdetail.deductba  = string(stat.campaign_fil.uom2_v) 
          wdetail.deductpa  = string(stat.campaign_fil.uom5_v) 
          wdetail.no_411    = string(stat.campaign_fil.mv411)  
          wdetail.no_412    = string(stat.campaign_fil.mv412)  
          wdetail.no_42     = string(stat.campaign_fil.mv42)  
          wdetail.no_43     = string(stat.campaign_fil.mv43)
          wexcamp.polmaster = stat.campaign_fil.polmst
          wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
          wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
          wexcamp.tp_pd     = stat.campaign_fil.uom5_v
          wexcamp.pa411     = stat.campaign_fil.mv411
          wexcamp.pa412     = stat.campaign_fil.mv412
          wexcamp.pa42      = stat.campaign_fil.mv42 
          wexcamp.pa43      = stat.campaign_fil.mv43 
          wexcamp.base1     = string(stat.campaign_fil.baseprm)   
          wexcamp.base2     = string(stat.campaign_fil.baseprm3)
          wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
          wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
          wexcamp.fleet     = string(stat.campaign_fil.fletper)    
          wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
          wexcamp.sumins    = wdetail.si
          wexcamp.sumfit    = wdetail.si
          wexcamp.Prem_t    = stat.campaign_fil.netprm . 
    END.
    ELSE ASSIGN wexcamp.polmaster = "" .
    
    /*IF wexcamp.polmaster = "" THEN DO: 
        IF n_yr = 0 THEN n_yr = 1 . 
        ELSE n_yr = n_yr + 1.

        IF INT(INT(wdetail.cc)) <= 2000 THEN DO:
            FIND LAST stat.campaign_fil /*USE-INDEX campfil01*/  WHERE 
                stat.campaign_fil.camcod = nv_camp1          AND /* campaign no */
                stat.campaign_fil.sclass = wdetail.sclass     AND /* class 110 210 320 */
                stat.campaign_fil.covcod = wdetail.covcod     AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.garage = wdetail.garage     AND /* การซ่อม */
                stat.campaign_fil.maxyea = n_yr              AND /* อายุรถ */
                stat.campaign_fil.engine <= 2000             AND /* cc */ 
                stat.campaign_fil.simax  = deci(wdetail.si)   AND  /* ทุน */
                stat.campaign_fil.makdes = wdetail.makdes     AND 
                (index(wdetail.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                index(stat.campaign_fil.moddes,wdetail.moddes)  <> 0 ) AND   /* Model */ /*A64-0044*/
                stat.campaign_fil.netprm  = deci(wdetail.netprm)   NO-LOCK NO-ERROR. 
        END.
        ELSE DO:
             FIND LAST stat.campaign_fil /*USE-INDEX campfil01*/  WHERE 
                stat.campaign_fil.camcod = nv_camp1         AND /* campaign no */
                stat.campaign_fil.sclass = wdetail.sclass    AND /* class 110 210 320 */
                stat.campaign_fil.covcod = wdetail.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.garage = wdetail.garage    AND /* การซ่อม */
                stat.campaign_fil.maxyea = n_yr             AND /* อายุรถ */
                stat.campaign_fil.engine > 2000             AND /* cc */ 
                stat.campaign_fil.simax  = deci(wdetail.si)  AND  /* ทุน */
                stat.campaign_fil.makdes = wdetail.makdes    AND 
                (index(wdetail.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                index(stat.campaign_fil.moddes,wdetail.moddes)  <> 0 ) AND   /* Model */ /*A64-0044*/
                stat.campaign_fil.netprm  = deci(wdetail.netprm)   NO-LOCK NO-ERROR.
        END.
        IF AVAIL stat.campaign_fil THEN DO:
            ASSIGN   
              wexcamp.polmaster = stat.campaign_fil.polmst
              wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
              wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
              wexcamp.tp_pd     = stat.campaign_fil.uom5_v
              wexcamp.pa411     = stat.campaign_fil.mv411
              wexcamp.pa412     = stat.campaign_fil.mv412
              wexcamp.pa42      = stat.campaign_fil.mv42 
              wexcamp.pa43      = stat.campaign_fil.mv43 
              wexcamp.base1     = string(stat.campaign_fil.baseprm)   
              wexcamp.base2     = string(stat.campaign_fil.baseprm3)
              wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
              wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
              wexcamp.fleet     = string(stat.campaign_fil.fletper)    
              wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
              wexcamp.sumins    = wdetail.si
              wexcamp.sumfit    = wdetail.si
              wexcamp.Prem_t    = stat.campaign_fil.netprm . 
        END.
        ELSE ASSIGN wexcamp.polmaster = "" . 
    END.*/
END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcampaignplus C-Win 
PROCEDURE proc_chkcampaignplus :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_camp1 AS CHAR INIT "".  /*---add by Chaiyong W. A61-0015 14/03/2018*/
DEF VAR n_yr     AS INTE INIT 0.
DEF VAR nv_cc AS CHAR INIT 0.
DO:
    ASSIGN nv_camp1 = trim(wdetail.product)
           n_yr = 0       
           n_yr = (YEAR(TODAY) - DECI(wdetail.caryear)) + 1 .

    IF wdetail.subclass <> "110" THEN DO:
        FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/      WHERE                
                 stat.campaign_fil.camcod  = nv_camp1            and  /*campaign */ 
                 stat.campaign_fil.sclass  = wdetail.subclass    and  /* class 110 210 320 */
                 stat.campaign_fil.covcod  = wdetail.covcod      and  /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                 stat.campaign_fil.garage  = wdetail.garage      and  /*   ประเภทการซ่อม   */
                 stat.campaign_fil.maxyea  = n_yr                AND /* อายุรถ */
                 stat.campaign_fil.simax   = deci(wdetail.si)    AND  /*   วงเงินทุนประกัน */
                /*  stat.campaign_fil.makdes  = trim(wdetail.brand)       AND 
                (index(wdetail.model,stat.campaign_fil.moddes)<> 0    OR   /* Model */
                 index(stat.campaign_fil.moddes,wdetail.model)  <> 0 ) AND */  /* Model */ 
                 stat.campaign_fil.netprm  = deci(wdetail.premt)  NO-LOCK NO-ERROR. /* เบี้ยจากไฟล์ */
        IF AVAIL stat.campaign_fil THEN DO:
            ASSIGN
                wdetail.prempa    = stat.campaign_fil.paccod
                wdetail.deductpp  = string(stat.campaign_fil.uom1_v) 
                wdetail.deductba  = string(stat.campaign_fil.uom2_v) 
                wdetail.deductpa  = string(stat.campaign_fil.uom5_v) 
                wdetail.no_411    = string(stat.campaign_fil.mv411)  
                wdetail.no_412    = string(stat.campaign_fil.mv412)  
                wdetail.no_42     = string(stat.campaign_fil.mv42)   
                wdetail.no_43     = string(stat.campaign_fil.mv43)  
                wexcamp.polmaster = stat.campaign_fil.polmst
                wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                wexcamp.pa411     = stat.campaign_fil.mv411
                wexcamp.pa412     = stat.campaign_fil.mv412
                wexcamp.pa42      = stat.campaign_fil.mv42 
                wexcamp.pa43      = stat.campaign_fil.mv43 
                wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                wexcamp.sumins    = wdetail.si
                wexcamp.sumfit    = IF (wdetail.covcod = "2.2") THEN wdetail.si ELSE "0"
                wexcamp.Prem_t    = stat.campaign_fil.netprm .
        END.
        ELSE ASSIGN wexcamp.polmaster = "" . 
    END.
    ELSE DO:
        IF INT(wdetail.cc) <= 2000 THEN nv_cc = "2000".
        ELSE IF int(wdetail.cc) > 2000 THEN nv_cc = "2001".  

        IF int(nv_cc) <= 2000 THEN DO:
            FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/    WHERE                
             stat.campaign_fil.camcod  =  nv_camp1                 and     /*campaign */ /*A63-0443*/
             stat.campaign_fil.sclass  =  wdetail.subclass         and     /* class 110 210 320 */
             stat.campaign_fil.covcod  =  wdetail.covcod           and     /* cover 1 2 3 2.1 2.2 3.1 3.2 */
             stat.campaign_fil.garage  =  wdetail.garage           and     /*   ประเภทการซ่อม   */
             stat.campaign_fil.maxyea  =  n_yr                     AND  /* อายุรถ */
             stat.campaign_fil.engine  <= 2000                     AND     /* cc */   
             stat.campaign_fil.simax    = deci(wdetail.si)         AND     /*   วงเงินทุนประกันสูงสุด */
             /*stat.campaign_fil.makdes   = trim(wdetail.brand)      AND 
             (index(wdetail.model,stat.campaign_fil.moddes) <> 0   OR   /* Model */
             index(stat.campaign_fil.moddes,wdetail.model)  <> 0 ) AND   /* Model */ */
             stat.campaign_fil.netprm  = deci(wdetail.premt)  NO-LOCK NO-ERROR. /* เบี้ยจากไฟล์ */
        END.
        ELSE DO:
            FIND LAST stat.campaign_fil /*USE-INDEX campf   il15*/ WHERE                
             stat.campaign_fil.camcod  =  nv_camp1                 and       /*campaign */ /*A63-0443*/
             stat.campaign_fil.sclass  =  wdetail.subclass         and       /* class 110 210 320 */
             stat.campaign_fil.covcod  =  wdetail.covcod           and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
             stat.campaign_fil.garage  =  wdetail.garage           and       /*   ประเภทการซ่อม   */
             stat.campaign_fil.maxyea  =  n_yr                     AND  /* อายุรถ */
             stat.campaign_fil.engine  > 2000                      AND /* cc */  
             stat.campaign_fil.simax   = deci(wdetail.si)          AND       /*   วงเงินทุนประกันสูงสุด */
             /*stat.campaign_fil.makdes  = trim(wdetail.brand)       AND 
             (index(wdetail.model,stat.campaign_fil.moddes) <> 0   OR   /* Model */
             index(stat.campaign_fil.moddes,wdetail.model)  <> 0 ) AND   /* Model */ */
             stat.campaign_fil.netprm  = deci(wdetail.premt)  NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
        END.
        IF AVAIL stat.campaign_fil THEN DO:
           ASSIGN
               wdetail.prempa    = stat.campaign_fil.paccod
               wdetail.deductpp  = string(stat.campaign_fil.uom1_v) 
               wdetail.deductba  = string(stat.campaign_fil.uom2_v) 
               wdetail.deductpa  = string(stat.campaign_fil.uom5_v) 
               wdetail.no_411    = string(stat.campaign_fil.mv411)  
               wdetail.no_412    = string(stat.campaign_fil.mv412)  
               wdetail.no_42     = string(stat.campaign_fil.mv42)   
               wdetail.no_43     = string(stat.campaign_fil.mv43)  
               wexcamp.polmaster = stat.campaign_fil.polmst
               wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
               wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
               wexcamp.tp_pd     = stat.campaign_fil.uom5_v
               wexcamp.pa411     = stat.campaign_fil.mv411
               wexcamp.pa412     = stat.campaign_fil.mv412
               wexcamp.pa42      = stat.campaign_fil.mv42 
               wexcamp.pa43      = stat.campaign_fil.mv43 
               wexcamp.base1     = string(stat.campaign_fil.baseprm)   
               wexcamp.base2     = string(stat.campaign_fil.baseprm3)
               wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
               wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
               wexcamp.fleet     = string(stat.campaign_fil.fletper)    
               wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
               wexcamp.sumins    = wdetail.si
               wexcamp.sumfit    = IF (wdetail.covcod = "2.2") THEN wdetail.si ELSE "0"
               wexcamp.Prem_t    = stat.campaign_fil.netprm .
        END.
        ELSE ASSIGN wexcamp.polmaster = "" . 
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
 
 /*IF wdetail.dealercd <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.dealercd) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Dealer " + wdetail.dealercd + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code Dealer " + wdetail.dealercd + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
                wdetail.pass    = "N" 
                wdetail.OK_GEN  = "N".
     END.
 END.*/
 IF wdetail.dealtms <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.dealtms) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Dealer " + wdetail.dealtms + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code Dealer " + wdetail.dealtms + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcomp C-Win 
PROCEDURE proc_chkcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  add by A67-0198     
------------------------------------------------------------------------------*/
DEF VAR n_comp72 AS CHAR INIT "" .
DEF VAR n_bev    AS CHAR INIT "" .

ASSIGN  n_comp72    = ""
        n_bev       = ""
        nv_chkerror = "".

IF trim(SUBSTR(wdetail.subclass,1,1)) = "E"  THEN ASSIGN n_bev = "Y" .
ELSE  ASSIGN n_bev = "N" .

RUN wgw/wgwcomp(INPUT  wdetail.volprem,     
                INPUT  wdetail.vehuse  , 
                INPUT  "T"  , 
                INPUT  wdetail.subclass, 
                INPUT  n_bev     , 
                INPUT  wdetail.garage  , 
                OUTPUT n_comp72        , 
                OUTPUT nv_chkerror ) .

IF nv_chkerror <> ""  THEN DO:
    ASSIGN wdetail.subclass = TRIM(n_comp72) 
           wdetail.comment  = wdetail.comment + "|" + nv_chkerror 
           wdetail.pass     = "N"
           wdetail.OK_GEN   = "N".
END.
ELSE DO:
    ASSIGN wdetail.subclass = TRIM(n_comp72) .
END.



/*MESSAGE " bev      " wdetail.bev       skip
        " prempa   " wdetail.prempa    skip
        " subclass " wdetail.subclass  skip
        " garage   " wdetail.garage    skip
        " vehuse   " wdetail.vehuse    skip
        " comp_prm " wdetail.comp_prm  skip
        "n_comp_1  " n_comp_1          skip
        "n_comp_2  " n_comp_2          skip
    VIEW-AS ALERT-BOX.*/
/*
IF deci(wdetail.hp) <> 0 AND DATE(TODAY) >= 12/15/2024  THEN DO:
    FIND LAST sicsyac.xmm106 WHERE 
              sicsyac.xmm106.tariff  = "9"      AND
              sicsyac.xmm106.bencod  = "comp"   AND         
              sicsyac.xmm106.CLASS   = trim(wdetail.subclass)  AND 
              sicsyac.xmm106.covcod  = "T"                  AND 
              sicsyac.xmm106.KEY_b   = INTE(wdetail.vehuse) AND 
              sicsyac.xmm106.baseap  = deci(wdetail.premt)   NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm106 THEN DO:
        ASSIGN wdetail.subclass = sicsyac.xmm106.class .
    END.
    ELSE DO:
        FIND LAST sicsyac.xmm106 WHERE 
                  sicsyac.xmm106.tariff  = "9"      AND 
                  sicsyac.xmm106.bencod  = "comp"   AND 
                  sicsyac.xmm106.class   = TRIM(wdetail.subclass)    AND
                  sicsyac.xmm106.covcod  = "T"      AND 
                  sicsyac.xmm106.baseap = deci(wdetail.premt)  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm106 THEN ASSIGN wdetail.subclass = sicsyac.xmm106.class .
        ELSE DO:
          FIND FIRST sicsyac.xzmcom WHERE
              sicsyac.xzmcom.class    = wdetail.prempa + wdetail.subclass  AND
              sicsyac.xzmcom.garage   = wdetail.garage     AND
              sicsyac.xzmcom.vehuse   = wdetail.vehuse     NO-LOCK NO-ERROR NO-WAIT.
          IF AVAILABLE sicsyac.xzmcom THEN DO:
              ASSIGN wdetail.subclass  = replace(sicsyac.xzmcom.comp_cod,".","")
                     wdetail.subclass  = replace(wdetail.subclass," ","").
          END.
          ELSE DO:
              FIND FIRST sicsyac.xzmcom WHERE
                  sicsyac.xzmcom.class    = wdetail.prempa + wdetail.subclass  AND 
                  sicsyac.xzmcom.vehuse   = wdetail.vehuse      NO-LOCK NO-ERROR NO-WAIT.
              IF AVAILABLE sicsyac.xzmcom THEN 
                  ASSIGN wdetail.subclass  = replace(sicsyac.xzmcom.comp_cod,".","")
                  wdetail.subclass  = replace(wdetail.subclass," ","").
              ELSE MESSAGE COLOR "ไม่พบ Class"  wdetail.prempa + wdetail.subclass  "และ Veh. Use" wdetail.vehuse  
                      "ที่แฟ้มตารางเปรียบเทียบ (sicsyac.xzmcom)" VIEW-AS ALERT-BOX.
          END. 
          FIND LAST sicsyac.xmm106 WHERE 
                   sicsyac.xmm106.tariff  = "9"      AND
                   sicsyac.xmm106.bencod  = "comp"   AND
                   sicsyac.xmm106.CLASS   = wdetail.subclass    AND
                   sicsyac.xmm106.covcod  = "t"                 AND 
                   sicsyac.xmm106.baseap  = deci(wdetail.premt)  NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm106 THEN  ASSIGN wdetail.subclass = sicsyac.xmm106.class .
            ELSE DO:
                FIND LAST sicsyac.xmm106 WHERE 
                          sicsyac.xmm106.tariff  = "9"      AND
                          sicsyac.xmm106.bencod  = "comp"   AND
                          substr(sicsyac.xmm106.CLASS,1,3)  = substr(wdetail.subclass,1,3)    AND
                          sicsyac.xmm106.covcod  = "t"      AND 
                          sicsyac.xmm106.baseap  = deci(wdetail.premt) NO-LOCK NO-ERROR.
                 IF AVAIL sicsyac.xmm106 THEN  ASSIGN wdetail.subclass = sicsyac.xmm106.class .
            END.  
        END.
    END.
END.
ELSE DO:
    
    FIND FIRST sicsyac.xzmcom WHERE
        sicsyac.xzmcom.class    = wdetail.prempa + wdetail.subclass  AND
        sicsyac.xzmcom.garage   = wdetail.garage     AND
        sicsyac.xzmcom.vehuse   = wdetail.vehuse     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xzmcom THEN 
        ASSIGN wdetail.subclass  = replace(sicsyac.xzmcom.comp_cod,".","")
               wdetail.subclass  = replace(wdetail.subclass," ","").
    ELSE DO:
        FIND FIRST sicsyac.xzmcom WHERE
            sicsyac.xzmcom.class    = wdetail.prempa + wdetail.subclass  AND 
            sicsyac.xzmcom.vehuse   = wdetail.vehuse      NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xzmcom THEN 
            ASSIGN wdetail.subclass  = replace(sicsyac.xzmcom.comp_cod,".","")
            wdetail.subclass  = replace(wdetail.subclass," ","").
        ELSE  MESSAGE COLOR "ไม่พบ Class"  wdetail.prempa + wdetail.subclass  "และ Veh. Use" wdetail.vehuse  
                "ที่แฟ้มตารางเปรียบเทียบ (sicsyac.xzmcom)" VIEW-AS ALERT-BOX.
    END.
    FIND LAST sicsyac.xmm106 WHERE 
            sicsyac.xmm106.tariff  = "9"      AND
            sicsyac.xmm106.bencod  = "comp"   AND
            sicsyac.xmm106.CLASS   = wdetail.subclass    AND
            sicsyac.xmm106.covcod  = "t"                 AND 
            sicsyac.xmm106.baseap  = deci(wdetail.premt)  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm106 THEN  ASSIGN wdetail.subclass = sicsyac.xmm106.class .
        ELSE DO:
             FIND LAST sicsyac.xmm106 WHERE 
            sicsyac.xmm106.tariff  = "9"      AND
            sicsyac.xmm106.bencod  = "comp"   AND
            substr(sicsyac.xmm106.CLASS,1,3)  = substr(wdetail.subclass,1,3)    AND
            sicsyac.xmm106.covcod  = "t"      AND 
            sicsyac.xmm106.baseap  = deci(wdetail.premt) NO-LOCK NO-ERROR.
             IF AVAIL sicsyac.xmm106 THEN  ASSIGN wdetail.subclass = sicsyac.xmm106.class .
        END.
END.

MESSAGE " bev      " wdetail.bev       skip
        " prempa   " wdetail.prempa    skip
        " subclass " wdetail.subclass  skip
        " garage   " wdetail.garage    skip
        " vehuse   " wdetail.vehuse    skip
        " comp_prm " wdetail.comp_prm  skip
       
    VIEW-AS ALERT-BOX.*/

   IF  (INDEX(wdetail.subclass,"110") <> 0 ) OR (index(wdetail.subclass,"210") <> 0 ) OR 
       (INDEX(wdetail.subclass,"E1") <> 0 ) THEN DO:
    ASSIGN wdetail.seat      =  "7"       /*เก๋ง /vehuse1*/
           wdetail.body      =  "SEDAN" .   
   END.
   ELSE IF (wdetail.subclass   = "120A" ) OR (wdetail.subclass   = "220A" ) OR 
           (INDEX(wdetail.subclass,"E2") <> 0 AND  INDEX(wdetail.subclass,"A") <> 0 ) THEN DO: 
    ASSIGN wdetail.seat      =  "12"     /*ตู้ /vehuse1*/
           wdetail.body      =  "VAN" .     
   END.
   ELSE IF (wdetail.subclass   = "120B") OR (wdetail.subclass   = "220B" ) OR 
           (INDEX(wdetail.subclass,"E2") <> 0 AND  INDEX(wdetail.subclass,"B") <> 0 ) THEN DO:    
    ASSIGN wdetail.seat      =  "15"     /*ตู้ /vehuse1*/
           wdetail.body      =  "VAN" . 
   END.
   ELSE IF wdetail.subclass   = "120C" OR wdetail.subclass   = "220C" OR
       (INDEX(wdetail.subclass,"E2") <> 0 AND  INDEX(wdetail.subclass,"C") <> 0 ) THEN DO:   
    ASSIGN wdetail.seat      =  "20"     /*ตู้ /vehuse1*/
           wdetail.body      =  "VAN" . 
   END.
   ELSE IF wdetail.subclass   = "120D" OR wdetail.subclass   = "220D" OR 
       (INDEX(wdetail.subclass,"E2") <> 0 AND  INDEX(wdetail.subclass,"D") <> 0 ) THEN DO:    
    ASSIGN wdetail.seat      =  "40"     /*ตู้ /vehuse1*/
           wdetail.body      =  "VAN" .     
   END.
   ELSE IF (wdetail.subclass = "140A" )  OR (wdetail.subclass = "240A") OR 
           (INDEX(wdetail.subclass,"E32") <> 0 AND  INDEX(wdetail.subclass,"A") <> 0 )THEN DO:   
    ASSIGN wdetail.seat      =  "3"      /*กระบะ /vehuse1*/
           wdetail.body      =  "PICKUP" .     
   END. 
   ELSE IF index(wdetail.subclass,"140") <> 0  OR INDEX(wdetail.subclass,"240") <> 0  OR  
       (INDEX(wdetail.subclass,"E32") <> 0 AND  INDEX(wdetail.subclass,"A") = 0 ) THEN DO:    
    ASSIGN wdetail.seat      =  "3"      /*กระบะ /vehuse1*/
           wdetail.body      =  "TRUCK" .    
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdrive C-Win 
PROCEDURE proc_chkdrive :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF  wdetail.drivnam = "Y" AND wdetail.prepol = "" THEN DO :      /*note add 07/11/2005*/
    ASSIGN no_policy    = ""            nv_drivage1  = 0        nv_drivbir1  = ""    
           no_rencnt    = ""            nv_drivage2  = 0        nv_drivbir2  = ""    
           no_endcnt    = ""            nv_drivage3  = 0        nv_drivbir3  = ""    
           no_riskno    = ""            nv_drivage4  = 0        nv_drivbir4  = ""    
           no_itemno    = ""            nv_drivage5  = 0        nv_drivbir5  = "" 
           nv_dribirth  = ""            nv_dlevel    = 0        nv_dlevper   = 0
           no_policy = sic_bran.uwm301.policy 
           no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") 
           no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") 
           no_riskno = "001"
           no_itemno = "001"
           n_count   = 0.
  
   ASSIGN wdetail.drivbir1  = STRING(DATE(wdetail.drivbir1),"99/99/9999")
         wdetail.drivbir2   = STRING(DATE(wdetail.drivbir2),"99/99/9999")
         wdetail.drivbir3   = STRING(DATE(wdetail.drivbir3),"99/99/9999") 
         wdetail.drivbir4   = STRING(DATE(wdetail.drivbir4),"99/99/9999") 
         wdetail.drivbir5   = STRING(DATE(wdetail.drivbir5),"99/99/9999") 
         nv_drivage1       = IF TRIM(wdetail.drivbir1) <> "?" THEN  INT(SUBSTR(wdetail.drivbir1,7,4)) ELSE 0
         nv_drivage2       = IF TRIM(wdetail.drivbir2) <> "?" THEN  INT(SUBSTR(wdetail.drivbir2,7,4)) ELSE 0
         nv_drivage3       = IF TRIM(wdetail.drivbir3) <> "?" THEN  INT(SUBSTR(wdetail.drivbir3,7,4)) ELSE 0
         nv_drivage4       = IF TRIM(wdetail.drivbir4) <> "?" THEN  INT(SUBSTR(wdetail.drivbir4,7,4)) ELSE 0
         nv_drivage5       = IF TRIM(wdetail.drivbir5) <> "?" THEN  INT(SUBSTR(wdetail.drivbir5,7,4)) ELSE 0 .
   
   IF wdetail.drivbir1 <> " "  AND wdetail.drivnam1 <> " " THEN DO: 
       RUN proc_clearmailtxt .
       if nv_drivage1 < year(today) then do:
           nv_drivage1 =  YEAR(TODAY) - nv_drivage1  .
           ASSIGN nv_dribirth    = STRING(DATE(wdetail.drivbir1),"99/99/9999") /* ค.ศ. */
                  nv_drivbir1    = STRING(INT(SUBSTR(wdetail.drivbir1,7,4))  + 543 )
                  wdetail.drivbir1 = SUBSTR(wdetail.drivbir1,1,6) + nv_drivbir1
                  wdetail.drivbir1 = STRING(DATE(wdetail.drivbir1),"99/99/9999") . /* พ.ศ. */
       END.
       ELSE DO:
           nv_drivage1 =  YEAR(TODAY) - (nv_drivage1 - 543).
           ASSIGN nv_drivbir1    = STRING(INT(SUBSTR(wdetail.drivbir1,7,4)))
                  nv_dribirth    = SUBSTR(wdetail.drivbir1,1,6) + STRING((INTE(nv_drivbir1) - 543),"9999")  /* ค.ศ. */
                  wdetail.drivbir1 = SUBSTR(wdetail.drivbir1,1,6) + nv_drivbir1   
                  wdetail.drivbir1 = STRING(DATE(wdetail.drivbir1),"99/99/9999")  . /* พ.ศ. */
       END.
       ASSIGN  n_count        = 1
               nv_ntitle   = trim(wdetail.drititle1)  
               nv_name     = trim(wdetail.drivnam1)  
               nv_lname    = trim(wdetail.drivnam1) 
               nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
               nv_dicno    = trim(wdetail.driICNo1)  
               nv_dgender  = trim(wdetail.drigender1) 
               nv_dbirth   = trim(wdetail.drivbir1)
               nv_dage     = nv_drivage1
               nv_doccup   = trim(wdetail.drioccup1) 
               nv_ddriveno = trim(wdetail.drivid1) 
               nv_drivexp  = "" 
               nv_dlevel   = IF INTE(wdetail.drilevel1) = 0 THEN 1 ELSE INTE(wdetail.drilevel1)
               wdetail.drivlevel = STRING(nv_dlevel) 
               nv_dlevper  = IF      inte(wdetail.drivlevel) = 1 THEN 100 ELSE IF inte(wdetail.drivlevel) = 2 THEN 90 
                             ELSE IF inte(wdetail.drivlevel) = 3 THEN 80  ELSE IF inte(wdetail.drivlevel) = 4 THEN 70 ELSE 60      .
       RUN proc_mailtxt.
   END.
   
   IF wdetail.drivbir2 <> " "  AND wdetail.drivnam2 <> " " THEN DO: 
       RUN proc_clearmailtxt .
       if nv_drivage2 < year(today) then do:
           nv_drivage2 =  YEAR(TODAY) - nv_drivage2  .
           ASSIGN nv_dribirth    = STRING(DATE(wdetail.drivbir2),"99/99/9999") /* ค.ศ. */
                  nv_drivbir2    = STRING(INT(SUBSTR(wdetail.drivbir2,7,4))  + 543 )
                  wdetail.drivbir2 = SUBSTR(wdetail.drivbir2,1,6) + nv_drivbir2
                  wdetail.drivbir2 = STRING(DATE(wdetail.drivbir2),"99/99/9999") . /* พ.ศ. */
       END.
       ELSE DO:
           nv_drivage2 =  YEAR(TODAY) - (nv_drivage2 - 543).
           ASSIGN nv_drivbir2    = STRING(INT(SUBSTR(wdetail.drivbir2,7,4)))
                  nv_dribirth    = SUBSTR(wdetail.drivbir2,1,6) + STRING((INTE(nv_drivbir2) - 543),"9999")  /* ค.ศ. */
                  wdetail.drivbir2 = SUBSTR(wdetail.drivbir2,1,6) + nv_drivbir2   
                  wdetail.drivbir2 = STRING(DATE(wdetail.drivbir2),"99/99/9999")  . /* พ.ศ. */
       END.
       ASSIGN  n_count        = 2
               nv_ntitle   = trim(wdetail.drititle2)  
               nv_name     = trim(wdetail.drivnam2 )  
               nv_lname    = trim(wdetail.drivnam2)
               nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
               nv_dicno    = trim(wdetail.driICNo2)  
               nv_dgender  = trim(wdetail.drigender2) 
               nv_dbirth   = trim(wdetail.drivbir2)
               nv_dage     = nv_drivage2
               nv_doccup   = trim(wdetail.drioccup2) 
               nv_ddriveno = trim(wdetail.drivid2) 
               nv_drivexp  = "" 
               nv_dlevel   = IF INTE(wdetail.drilevel2) = 0 THEN 1 ELSE INTE(wdetail.drilevel2)
               wdetail.drivlevel = IF INTE(nv_dlevel) < INTE(wdetail.drivlevel) THEN string(nv_dlevel) ELSE wdetail.drivlevel 
               nv_dlevper  = IF      inte(wdetail.drivlevel) = 1 THEN 100 ELSE IF inte(wdetail.drivlevel) = 2 THEN 90 
                             ELSE IF inte(wdetail.drivlevel) = 3 THEN 80  ELSE IF inte(wdetail.drivlevel) = 4 THEN 70 ELSE 60      .
       RUN proc_mailtxt.
   END.
   
   IF wdetail.drivbir3 <> " "  AND wdetail.drivnam3 <> " " THEN DO:
       RUN proc_clearmailtxt .
       if nv_drivage3 < year(today) then do:
           nv_drivage3 =  YEAR(TODAY) - nv_drivage3  .
           ASSIGN nv_dribirth    = STRING(DATE(wdetail.drivbir3),"99/99/9999") /* ค.ศ. */
                  nv_drivbir3    = STRING(INT(SUBSTR(wdetail.drivbir3,7,4))  + 543 )
                  wdetail.drivbir3 = SUBSTR(wdetail.drivbir3,1,6) + nv_drivbir3
                  wdetail.drivbir3 = STRING(DATE(wdetail.drivbir3),"99/99/9999") . /* พ.ศ. */
       END.
       ELSE DO:
           nv_drivage3 =  YEAR(TODAY) - (nv_drivage3 - 543).
           ASSIGN nv_drivbir3    = STRING(INT(SUBSTR(wdetail.drivbir3,7,4)))
                  nv_dribirth    = SUBSTR(wdetail.drivbir3,1,6) + STRING((INTE(nv_drivbir3) - 543),"9999")  /* ค.ศ. */
                  wdetail.drivbir3 = SUBSTR(wdetail.drivbir3,1,6) + nv_drivbir3   
                  wdetail.drivbir3 = STRING(DATE(wdetail.drivbir3),"99/99/9999")  . /* พ.ศ. */
       END.
       ASSIGN  n_count        = 3
               nv_ntitle   = trim(wdetail.drititle3)  
               nv_name     = trim(wdetail.drivnam3 )  
               nv_lname    = trim(wdetail.drivnam3) 
               nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
               nv_dicno    = trim(wdetail.driICNo3)  
               nv_dgender  = trim(wdetail.drigender3) 
               nv_dbirth   = trim(wdetail.drivbir3)
               nv_dage     = nv_drivage3
               nv_doccup   = trim(wdetail.drioccup3) 
               nv_ddriveno = trim(wdetail.drilic3) 
               nv_drivexp  = "" 
               nv_dlevel   = IF INTE(wdetail.drilevel3) = 0 THEN 1 ELSE INTE(wdetail.drilevel3) 
               wdetail.drivlevel = IF INTE(nv_dlevel) < INTE(wdetail.drivlevel) THEN string(nv_dlevel) ELSE wdetail.drivlevel 
               nv_dlevper  = IF      inte(wdetail.drivlevel) = 1 THEN 100 ELSE IF inte(wdetail.drivlevel) = 2 THEN 90 
                             ELSE IF inte(wdetail.drivlevel) = 3 THEN 80  ELSE IF inte(wdetail.drivlevel) = 4 THEN 70 ELSE 60      .
       RUN proc_mailtxt.
   END.
   
   IF wdetail.drivbir4 <> " "  AND wdetail.drivnam4 <> " " THEN DO: 
       RUN proc_clearmailtxt .
       if nv_drivage4 < year(today) then do:
           nv_drivage4 =  YEAR(TODAY) - nv_drivage4  .
           ASSIGN nv_dribirth    = STRING(DATE(wdetail.drivbir4),"99/99/9999") /* ค.ศ. */
                  nv_drivbir4    = STRING(INT(SUBSTR(wdetail.drivbir4,7,4))  + 543 )
                  wdetail.drivbir4 = SUBSTR(wdetail.drivbir4,1,6) + nv_drivbir4
                  wdetail.drivbir4 = STRING(DATE(wdetail.drivbir4),"99/99/9999") . /* พ.ศ. */
       END.
       ELSE DO:
           nv_drivage4 =  YEAR(TODAY) - (nv_drivage4 - 543).
           ASSIGN nv_drivbir4    = STRING(INT(SUBSTR(wdetail.drivbir4,7,4)))
                  nv_dribirth    = SUBSTR(wdetail.drivbir4,1,6) + STRING((INTE(nv_drivbir4) - 543),"9999")  /* ค.ศ. */
                  wdetail.drivbir4 = SUBSTR(wdetail.drivbir4,1,6) + nv_drivbir4   
                  wdetail.drivbir4 = STRING(DATE(wdetail.drivbir4),"99/99/9999")  . /* พ.ศ. */
       END.
       ASSIGN  n_count        = 4
               nv_ntitle   = trim(wdetail.drititle4)  
               nv_name     = trim(wdetail.drivnam4 )  
               nv_lname    = trim(wdetail.drivnam4)
               nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
               nv_dicno    = trim(wdetail.driICNo4)  
               nv_dgender  = trim(wdetail.drigender4) 
               nv_dbirth   = trim(wdetail.drivbir4)
               nv_dage     = nv_drivage4
               nv_doccup   = trim(wdetail.drioccup4) 
               nv_ddriveno = trim(wdetail.drilic4) 
               nv_drivexp  = ""
               nv_dlevel   = IF INTE(wdetail.drilevel4) = 0 THEN 1 ELSE INTE(wdetail.drilevel4) 
               wdetail.drivlevel = IF INTE(nv_dlevel) < INTE(wdetail.drivlevel) THEN string(nv_dlevel) ELSE wdetail.drivlevel 
               nv_dlevper  = IF      inte(wdetail.drivlevel) = 1 THEN 100 ELSE IF inte(wdetail.drivlevel) = 2 THEN 90 
                             ELSE IF inte(wdetail.drivlevel) = 3 THEN 80  ELSE IF inte(wdetail.drivlevel) = 4 THEN 70 ELSE 60      .
       RUN proc_mailtxt.
   END.
   
   IF wdetail.drivbir5 <> " "  AND wdetail.drivnam5 <> " " THEN DO:
       RUN proc_clearmailtxt .
       if nv_drivage5 < year(today) then do:
           nv_drivage5 =  YEAR(TODAY) - nv_drivage5  .
           ASSIGN nv_dribirth    = STRING(DATE(wdetail.drivbir5),"99/99/9999") /* ค.ศ. */
                  nv_drivbir5    = STRING(INT(SUBSTR(wdetail.drivbir5,7,4))  + 543 )
                  wdetail.drivbir5 = SUBSTR(wdetail.drivbir5,1,6) + nv_drivbir5
                  wdetail.drivbir5 = STRING(DATE(wdetail.drivbir5),"99/99/9999") . /* พ.ศ. */
       END.
       ELSE DO:
           nv_drivage5 =  YEAR(TODAY) - (nv_drivage5 - 543).
           ASSIGN nv_drivbir5    = STRING(INT(SUBSTR(wdetail.drivbir5,7,4)))
                  nv_dribirth    = SUBSTR(wdetail.drivbir5,1,6) + STRING((INTE(nv_drivbir5) - 543),"9999")  /* ค.ศ. */
                  wdetail.drivbir5 = SUBSTR(wdetail.drivbir5,1,6) + nv_drivbir5   
                  wdetail.drivbir5 = STRING(DATE(wdetail.drivbir5),"99/99/9999")  . /* พ.ศ. */
       END.
       ASSIGN  n_count        = 5
               nv_ntitle   = trim(wdetail.drititle5)  
               nv_name     = trim(wdetail.drivnam5 )  
               nv_lname    = trim(wdetail.drivnam5)
               nv_drinam   = nv_ntitle + " " + nv_name  + " " + nv_lname
               nv_dicno    = trim(wdetail.driICNo5)  
               nv_dgender  = trim(wdetail.drigender5) 
               nv_dbirth   = trim(wdetail.drivbir5)
               nv_dage     = nv_drivage5
               nv_doccup   = trim(wdetail.drioccup5) 
               nv_ddriveno = trim(wdetail.drilic5) 
               nv_drivexp  = "" 
               nv_dlevel   = IF INTE(wdetail.drilevel5) = 0 THEN 1 ELSE INTE(wdetail.drilevel5) 
               wdetail.drivlevel = IF INTE(nv_dlevel) < INTE(wdetail.drivlevel) THEN string(nv_dlevel) ELSE wdetail.drivlevel 
               nv_dlevper  = IF      inte(wdetail.drivlevel) = 1 THEN 100 ELSE IF inte(wdetail.drivlevel) = 2 THEN 90 
                             ELSE IF inte(wdetail.drivlevel) = 3 THEN 80  ELSE IF inte(wdetail.drivlevel) = 4 THEN 70 ELSE 60      .
       RUN proc_mailtxt.
   END.
    
END. /*note add for mailtxt 07/11/2005*/
/*-----nv_drivcod---------------------*/
ASSIGN nv_drivvar = ""
       nv_drivvar1 = "".
       nv_drivvar2 = "".
IF wdetail.drivnam = "N" THEN ASSIGN  nv_drivno = 0.
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
    IF  nv_drivno  > 2 AND wdetail.subclass <> "E11" Then do:
        Message " Driver'S NO. must not over 2. "  View-as alert-box.
        ASSIGN wdetail.pass    = "N"
               wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
    END.
    IF SUBSTR(wdetail.subclass,1,1) <> "E" THEN DO: 
        RUN proc_usdcod.
    END.
    ELSE DO:
        ASSIGN nv_drivcod = "AL0" + TRIM(wdetail.drivlevel).
        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                   xmm106.tariff = wdetail.tariff  AND
                   xmm106.bencod = nv_drivcod   AND
                   xmm106.CLASS  = wdetail.subclass   AND
                   xmm106.covcod = wdetail.covcod  AND
                   xmm106.KEY_a  = 0          AND
                   xmm106.KEY_b  = 0          AND
                   xmm106.effdat <= DATE(wdetail.comdat) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xmm106 THEN DO:
            nv_dlevper = xmm106.appinc.
        END.
        ELSE ASSIGN nv_dlevper = 0.
    END.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpolpremium C-Win 
PROCEDURE proc_chkpolpremium :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfuwm301 FOR sicuw.uwm301.
DEF VAR stk   AS CHAR FORMAT "x(12)" INIT "" .
DEF VAR nv_chasno AS CHAR FORMAT "x(50)" .
DEF VAR nv_poltyp AS CHAR FORMAT "x(3)" .
DEF VAR nv_compol AS CHAR FORMAT "x(15)" .
DEF VAR nv_comdat AS DATE .
DEF VAR nv_expdat AS DATE .

DO:
    ASSIGN fi_show = "check Policy on Premium " + wdetail.policy + " " + wdetail.chasno + ".....".
    DISP fi_show WITH FRAM fr_main.
  ASSIGN nv_chasno  = ""
         nv_poltyp  = ""
         nv_compol  = ""
         nv_expdat  = ?
         nv_chasno  = trim(wdetail.chasno)
         nv_poltyp  = TRIM(wdetail.poltyp)
         nv_comdat  = DATE(wdetail.comdat)
         nv_expdat  = DATE(wdetail.expdat) .

  IF nv_chasno <> ""   THEN DO:
     FIND FIRST sicuw.uwm301 Use-index uwm30121 Where sicuw.uwm301.cha_no = trim(nv_chasno) No-lock no-error no-wait.
     If avail sicuw.uwm301 Then DO:

       FOR EACH  sicuw.uwm301 Use-index uwm30121 Where sicuw.uwm301.cha_no = trim(nv_chasno) NO-LOCK:
           Find LAST sicuw.uwm100 Use-index uwm10001       Where
               sicuw.uwm100.policy = sicuw.uwm301.policy   and
               sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
               sicuw.uwm100.poltyp = nv_poltyp  No-lock no-error no-wait.
           If avail sicuw.uwm100 Then DO:

               IF DATE(sicuw.uwm100.expdat) > date(nv_comdat) AND 
                  YEAR(sicuw.uwm100.expdat) = YEAR(nv_expdat) AND  
                  sicuw.uwm100.polsta    = "IF" THEN DO:
                  ASSIGN wdetail.comment = wdetail.comment + "| เลขตัวถังนี้มีกรมธรรม์ในระบบแล้ว" + uwm100.policy      
                       WDETAIL.OK_GEN  = "N"
                       wdetail.pass    = "N". 
               END.
           END.
       END. /*FOR EACH  sicuw.uwm301 */

     END. /*avil 301*/
     ELSE DO:
          RUN proc_chassic .
          FIND FIRST sicuw.uwm301 Use-index uwm30103 Where sicuw.uwm301.trareg = trim(nv_uwm301trareg) No-lock no-error no-wait.
           If avail sicuw.uwm301 Then DO:
             FOR EACH  sicuw.uwm301 Use-index uwm30103 Where sicuw.uwm301.trareg = trim(nv_uwm301trareg) NO-LOCK:
                 Find LAST sicuw.uwm100 Use-index uwm10001       Where
                     sicuw.uwm100.policy = sicuw.uwm301.policy   and
                     sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                     sicuw.uwm100.poltyp = nv_poltyp  No-lock no-error no-wait.
                 If avail sicuw.uwm100 Then DO:
                     IF DATE(sicuw.uwm100.expdat) > date(nv_comdat) AND 
                        YEAR(sicuw.uwm100.expdat) = YEAR(nv_expdat) AND  
                        sicuw.uwm100.polsta    = "IF" THEN DO:
                        ASSIGN wdetail.comment = wdetail.comment + "| เลขตัวถังนี้มีกรมธรรม์ในระบบแล้ว" + uwm100.policy      
                               WDETAIL.OK_GEN  = "N"
                               wdetail.pass    = "N". 
                     END.
                 END.
             END. /*FOR EACH  sicuw.uwm301.trareg */
           END. /* if avail sicuw.uwm301.trareg */
     END.  /*end else do */
  END.
END.
RELEASE sicuw.uwm301.
RELEASE sicuw.uwm100.

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
ASSIGN fi_show = "Check data basic......".
DISP fi_show WITH FRAM fr_main.
IF wdetail.vehreg = " " AND wdetail.prepol  = " " THEN DO: 
    ASSIGN
        wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N". 
END.
ELSE DO:
    IF wdetail.prepol = " " THEN DO:     /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
        Def  var  nv_vehreg  as char  init  " ".
        Def  var  s_polno    like sicuw.uwm100.policy   init " ".
        Find LAST sicuw.uwm301 Use-index uwm30102  Where  
            sicuw.uwm301.vehreg = wdetail.vehreg   No-lock no-error no-wait.
        IF AVAIL sicuw.uwm301 THEN DO:
            If  sicuw.uwm301.policy =  wdetail.policy     and          
                sicuw.uwm301.endcnt = 1  and
                sicuw.uwm301.rencnt = 1  and
                sicuw.uwm301.riskno = 1  and
                sicuw.uwm301.itemno = 1  Then  Leave.
            Find first sicuw.uwm100 Use-index uwm10001     Where
                sicuw.uwm100.policy = sicuw.uwm301.policy    and
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt    and                         
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt    and
                sicuw.uwm100.expdat > date(wdetail.comdat)   No-lock no-error no-wait.
            If avail sicuw.uwm100 Then 
                s_polno     =   sicuw.uwm100.policy.
        END.  /*avil 301*/
    END.      /*จบการ Check ทะเบียนรถ*/
END.          /*note end else*/   /*end note vehreg*/
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
IF wdetail.branch = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| branch เป็นค่าว่าง กรุณาเช็คสาขาในไฟล์ กับพารามิเตอร์ KK "
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.subclass = " " THEN  
    ASSIGN
        wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
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
/*IF wdetail.seat  = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".*/
IF wdetail.caryear = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".

ASSIGN 
    nv_maxsi = 0
    nv_minsi = 0
    nv_si    = 0
    nv_maxdes = ""
    nv_mindes = ""
    /*chkred = NO*/
    n_model = "". 
IF      wdetail.subclass = "110" THEN wdetail.seat = "7".
ELSE IF wdetail.subclass = "210" THEN wdetail.seat = "12".
ELSE IF wdetail.subclass = "320" THEN wdetail.seat = "3".
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE 
        stat.maktab_fil.sclass = wdetail.subclass   AND 
        stat.maktab_fil.modcod = wdetail.redbook    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  
            nv_modcod        =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            /*chkred           =  YES     */               
            wdetail.brand    =  stat.maktab_fil.makdes
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
            wdetail.cc       =  STRING(stat.maktab_fil.engine)
            wdetail.weight   =  STRING(stat.maktab_fil.tons)
            wdetail.subclass =  stat.maktab_fil.sclass   
            wdetail.redbook  =  stat.maktab_fil.modcod                                    
            wdetail.seat     =  STRING(stat.maktab_fil.seats)
            nv_si            = maktab_fil.si.

        IF wdetail.covcod = "1"  THEN DO:
            FIND FIRST stat.makdes31 WHERE 
                stat.makdes31.makdes = "X"  AND     /*Lock X*/
                stat.makdes31.moddes = wdetail.prempa + wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE makdes31 THEN 
                ASSIGN  nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            ELSE 
                ASSIGN  nv_maxSI = nv_si
                    nv_minSI = nv_si.
        END.  /***--- End Check Rate SI ---***/
    END.
    ELSE nv_modcod = " ".
END.    /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN 
        nv_simat  = makdes31.si_theft_p   
        nv_simat1 = makdes31.load_p   .    
    ELSE ASSIGN 
        nv_simat  = 0
        nv_simat1 = 0.
    Find LAST stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        nv_modcod       =  stat.maktab_fil.modcod                                    
        nv_moddes       =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp  =  stat.maktab_fil.prmpac
        wdetail.redbook =  stat.maktab_fil.modcod 
        wdetail.weight   =  STRING(stat.maktab_fil.tons)
        wdetail.body    =  stat.maktab_fil.body .
END.
    ASSIGN                  
        NO_CLASS  = wdetail.prempa + wdetail.subclass 
        nv_poltyp = wdetail.poltyp.
    If no_class  <>  " " Then do:
        FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
            sicsyac.xmd031.poltyp =   nv_poltyp AND
            sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE sicsyac.xmd031 THEN 
            /*MESSAGE   "Not on Business Classes Permitted per Policy Type file xmd031"  
                sicuw.uwm100.poltyp   no_class  View-as alert-box.*/
            ASSIGN
                wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
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
     IF wdetail.prepol = ""  THEN DO:
     
     IF (DECI(wdetail.ncb) = 0 )  OR (DECI(wdetail.ncb) = 20 ) OR
        (DECI(wdetail.ncb) = 30 ) OR (DECI(wdetail.ncb) = 40 ) OR
        (DECI(wdetail.ncb) = 50 )    THEN DO:
     END.
     ELSE 
         ASSIGN
             wdetail.comment = wdetail.comment + "| not on NCB Rates file xmm104."
             wdetail.pass    = "N"   
             wdetail.OK_GEN  = "N".
     END.
     
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
DEF VAR nv_error AS CHAR FORMAT "x(150)" .    /* a65-0288*/
DEF VAR nv_typpol AS CHAR INIT "" .                        /* a65-0288*/

ASSIGN fi_show  = "Import data by type... Text file KK [NEW] " .  /*A55-0029*/
DISP fi_show  WITH FRAME fr_main.
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail:
        IF  wdetail.policy = ""  THEN NEXT.
        /*------------------  renew ---------------------*/
        /*RUN proc_cr_2.  เฉพาะงาน 70 */
        ASSIGN 
            n_rencnt = 0     nv_dss_per = 0
            n_endcnt = 0     nv_cl_per  = 0
            nv_411   = 0     n_prmtxt   = "" 
            nv_412   = 0     nv_drivno = 0
            nv_42    = 0     nv_driver = ""  /*A67-0076*/
            nv_43    = 0     n_count = 0     /*A67-0076*/
            DOD1     = 0
            DOD2     = 0
            DOD0     = 0.
        /*Add by Kridtiya i. A63-0472*/
        IF wdetail.producer = "B3MLKK0102" THEN 
            ASSIGN 
            wdetail.campaign_ov = "REDPLATE"
            wdetail.financecd   = "FKK".
        RUN proc_assign2addr (INPUT  wdetail.iadd1
                             ,INPUT  wdetail.iadd2
                             ,INPUT  wdetail.iadd3 + " " + wdetail.iadd4
                             ,INPUT  ""    /*wdetail.occup   */
                             ,OUTPUT wdetail.codeocc  
                             ,OUTPUT wdetail.codeaddr1
                             ,OUTPUT wdetail.codeaddr2
                             ,OUTPUT wdetail.codeaddr3).
        wdetail.br_insured = "00000".
        IF nv_postcd <> ""  THEN DO: 
            wdetail.postcd  = nv_postcd.
            IF      INDEX(wdetail.iadd4,nv_postcd) <> 0 THEN wdetail.iadd4 = trim(REPLACE(wdetail.iadd4,nv_postcd,"")). 
            ELSE IF INDEX(wdetail.iadd3,nv_postcd) <> 0 THEN wdetail.iadd3 = trim(REPLACE(wdetail.iadd3,nv_postcd,"")). 
            ELSE IF INDEX(wdetail.iadd2,nv_postcd) <> 0 THEN wdetail.iadd2 = trim(REPLACE(wdetail.iadd2,nv_postcd,"")). 
            ELSE IF INDEX(wdetail.iadd1,nv_postcd) <> 0 THEN wdetail.iadd1 = trim(REPLACE(wdetail.iadd1,nv_postcd,"")). 
        END.
        
        IF      wdetail.producer =  "A0M1005"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer =  "B3MLKK0101"  wdetail.financecd = "FKK" wdetail.campaign_ov = "RENEW".
        ELSE IF wdetail.producer =  "A0M1005"    THEN ASSIGN  wdetail.producer =  "B3MLKK0101"  wdetail.financecd = "FKK" wdetail.campaign_ov = "TRANSF".
        ELSE IF wdetail.producer =  "A0M1050"    THEN ASSIGN  wdetail.producer =  "B3MLKK0102"  wdetail.financecd = "FKK" wdetail.campaign_ov = "REDPLATE".             
        ELSE IF wdetail.producer =  "A0M1054"    THEN ASSIGN  wdetail.producer =  "B3MLKK0103"  wdetail.financecd = "FKK" wdetail.campaign_ov = "VREDPLATE".            
        ELSE IF wdetail.producer =  "A000190"    THEN ASSIGN  wdetail.producer =  "B3MLKK0104"  wdetail.financecd = "FKK" wdetail.campaign_ov = "BBREDPLATE".  
        ELSE IF wdetail.producer =  "B3MLKK0101" AND wdetail.prepol <> "" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "RENEW".
        /*ELSE IF wdetail.producer =  "B3MLKK0101" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "TRANSF".*/ /* A65-0288*/
        ELSE IF wdetail.producer =  "B3MLKK0102" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "REDPLATE".              
        ELSE IF wdetail.producer =  "B3MLKK0103" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "VREDPLATE".             
        ELSE IF wdetail.producer =  "B3MLKK0104" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "BBREDPLATE".
        ELSE IF wdetail.producer =  "B3MLKK0105" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "USED".
        ELSE IF wdetail.producer =  "B3MLKK0106" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "TRANSF". /* A65-0288*/

        RUN proc_susspect.
        RUN proc_chkcode. /* A64-0138*/
        RUN proc_chkpolpremium. /*27/09/2021*/
        /* A67-0076*/
        IF trim(wdetail.battyr) <> ""  THEN DO:
            RUN wgw/wgwbattper(INPUT INTE(wdetail.battyr),
                               INPUT DATE(wdetail.comdat),
                               INPUT-OUTPUT wdetail.battper ,
                               INPUT-OUTPUT nv_chkerror) . 
            IF nv_chkerror <> ""  THEN DO:
               ASSIGN wdetail.comment = wdetail.comment + "|" + TRIM(nv_chkerror)
                      wdetail.pass    = "N" 
                      wdetail.OK_GEN  = "N".
            END.
        END.
        /* end : A67-0076*/
        /* 05/10/2021 */
        IF wdetail.redbook = "" THEN DO:
           /* RUN wgw/wgwredbook(input  wdetail.brand ,*/ /*A65-0288 */  
            RUN wgw/wgwredbk1 (input  wdetail.brand ,    /*A65-0288 */
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail.tariff,  
                               input  wdetail.subclass,   
                               input  wdetail.caryear, 
                               input  wdetail.cc ,
                               input  wdetail.weight, 
                               INPUT-OUTPUT wdetail.redbook) .
        END.
        /* end 05/10/2021 */
        /*Add by Kridtiya i. A63-0472*/
        IF wdetail.prepol <> " " AND wdetail.poltyp = "V70" THEN RUN proc_renew.
        /* create by : A65-0288 */
        ASSIGN 
            nv_chkerror = "" 
            nv_typpol   = ""
            nv_typpol   = "V" + wdetail.poltyp .
        RUN wgw/wgwchkdate(input  date(wdetail.comdat) ,
                           input  date(wdetail.expdat) ,
                           INPUT  nv_typpol, 
                           OUTPUT nv_error ).
        IF nv_error <> ""  THEN DO:
            ASSIGN 
            wdetail.comment = wdetail.comment + "| " + nv_error
            wdetail.pass    = "N"  
            wdetail.OK_GEN  = "N".
        END.
        
        /*end A65-0288 */
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
        ELSE DO:
            IF wdetail.product <> "" THEN RUN proc_chkcampaign .
            RUN proc_chktest0.
            RUN proc_policy.    /*ใช้ร่วมกัน 70/72*/
            RUN proc_chktest2.      
            RUN proc_chktest3.      
            RUN proc_chktest4.  
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
DEF VAR nv_colorcode AS CHAR INIT "" . /* A65-0288 */
DEF VAR n_yr         AS INT INIT 0. /* A65-0288*/
ASSIGN fi_show = "Create policy data detail car[uwm301]......".
DISP fi_show WITH FRAM fr_main.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND             
    sic_bran.uwm130.riskno = s_riskno               AND            
    sic_bran.uwm130.itemno = s_itemno               AND            
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
        sic_bran.uwm130.bchcnt  = nv_batcnt        /* bchcnt     */
        nv_sclass = wdetail.subclass
        nv_uom6_u  =  "A" .  
    /*IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN */                        /*ranu : A65-0288 */
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR (wdetail.covcod = "2.2") THEN  /*ranu : A65-0288 */
        ASSIGN
        sic_bran.uwm130.uom6_v   = inte(wdetail.si)
        sic_bran.uwm130.uom7_v   = inte(wdetail.si)
        sic_bran.uwm130.uom1_v   = deci(wdetail.deductpp)  
        sic_bran.uwm130.uom2_v   = deci(wdetail.deductba)  
        sic_bran.uwm130.uom5_v   = deci(wdetail.deductpa)  
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
   /* IF wdetail.covcod = "2"  THEN  */ /*ranu : A65-0288 */
    IF (wdetail.covcod = "2") OR (wdetail.covcod = "3.2")  THEN    /*ranu : A65-0288 */
        ASSIGN
        sic_bran.uwm130.uom1_c  = "D1"
        sic_bran.uwm130.uom2_c  = "D2"
        sic_bran.uwm130.uom5_c  = "D5"
        sic_bran.uwm130.uom6_c  = "D6"
        sic_bran.uwm130.uom7_c  = "D7"
        sic_bran.uwm130.uom1_v   = deci(wdetail.deductpp)       
        sic_bran.uwm130.uom2_v   = deci(wdetail.deductba)       
        sic_bran.uwm130.uom5_v   = deci(wdetail.deductpa)       
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = inte(wdetail.si)
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.poltyp = "v72" THEN DO: 
        IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN 
            n_sclass72 = "140A".
        ELSE n_sclass72 = trim(wdetail.subclass).
    END.
    ELSE n_sclass72 = wdetail.prempa + wdetail.subclass .
    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = wdetail.covcod No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do:   
        IF substr(n_sclass72,1,1) = "Z" AND  wdetail.prepol = "" THEN
            Assign 
            sic_bran.uwm130.uom1_v = deci(wdetail.deductpp)      /*stat.clastab_fil.uom1_si*/
            sic_bran.uwm130.uom2_v = deci(wdetail.deductba)      /*stat.clastab_fil.uom2_si*/
            sic_bran.uwm130.uom5_v = deci(wdetail.deductpa).
        ELSE ASSIGN      /*stat.clastab_fil.uom5_si*/
           /* add by A63-0130 */
            sic_bran.uwm130.uom1_v    = if sic_bran.uwm130.uom1_v <> 0 then sic_bran.uwm130.uom1_v  else stat.clastab_fil.uom1_si
            sic_bran.uwm130.uom2_v    = if sic_bran.uwm130.uom2_v <> 0 then sic_bran.uwm130.uom2_v  else stat.clastab_fil.uom2_si
            sic_bran.uwm130.uom5_v    = if sic_bran.uwm130.uom5_v <> 0 then sic_bran.uwm130.uom5_v  else stat.clastab_fil.uom5_si.
            /* end A63-0130 */
        ASSIGN 
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            nv_uom1_v                  =  sic_bran.uwm130.uom1_v   
            nv_uom2_v                  =  sic_bran.uwm130.uom2_v
            nv_uom5_v                  =  sic_bran.uwm130.uom5_v        
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7"
            nv_seat41               = wdetail.seat41 .
        If  wdetail.garage  =  ""  Then
            Assign wdetail.seat41    =  stat.clastab_fil.dri_41 + clastab_fil.pass_41
            /* add by : A65-0288 */
            wdetail.no_411    =  if int(wdetail.no_411) <> 0 then wdetail.no_411 else string(stat.clastab_fil.si_41unp)             
            wdetail.no_412    =  if int(wdetail.no_412) <> 0 then wdetail.no_412 else string(stat.clastab_fil.si_41nam)             
            wdetail.no_42     =  if int(wdetail.no_42)  <> 0 then wdetail.no_42  else string(stat.clastab_fil.si_42)                
            wdetail.no_43     =  if int(wdetail.no_43)  <> 0 then wdetail.no_43  else string(stat.clastab_fil.si_43) .
            /* end : A65-0288 */
        Else If  wdetail.garage  =  "G"  Then
            Assign 
            wdetail.seat41    = stat.clastab_fil.dri_41 + clastab_fil.pass_41
             /* add by : A65-0288 */
            wdetail.no_411    =  if int(wdetail.no_411) <> 0 then wdetail.no_411 else string(stat.clastab_fil.si_41unp)             
            wdetail.no_412    =  if int(wdetail.no_412) <> 0 then wdetail.no_412 else string(stat.clastab_fil.si_41nam)             
            wdetail.no_42     =  if int(wdetail.no_42)  <> 0 then wdetail.no_42  else string(stat.clastab_fil.si_42)                
            wdetail.no_43     =  if int(wdetail.no_43)  <> 0 then wdetail.no_43  else string(stat.clastab_fil.si_43) .
            /* end: A65-0288 */
        IF wdetail.prepol <> "" THEN
            Assign 
            sic_bran.uwm130.uom1_v = deci(wdetail.deductpp)      /*stat.clastab_fil.uom1_si*/
            sic_bran.uwm130.uom2_v = deci(wdetail.deductba)      /*stat.clastab_fil.uom2_si*/
            sic_bran.uwm130.uom5_v = deci(wdetail.deductpa)
            wdetail.no_411    =  string(n_411) 
            wdetail.no_412    =  string(n_412)
            wdetail.no_42     =  string(n_42) 
            wdetail.no_43     =  string(n_43) 
            wdetail.seat41    =  nv_seat41. 
        /*... end A63-0130....*/ 
    END.           
    ASSIGN nv_riskno = 1   nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                         nv_riskno,
                         nv_itemno).
    END.  /* end Do transaction*/
    ASSIGN 
    s_recid3  = RECID(sic_bran.uwm130) 
    nv_covcod =   wdetail.covcod 
    nv_makdes  =  wdetail.brand 
    nv_newsck = " ".
    RUN proc_chassic.
    /* add by : A65-0288 */
    ASSIGN n_yr = 0     n_yr = (YEAR(TODAY) - DECI(wdetail.caryear)) + 1.
    IF TRIM(wdetail.colors) <> "" THEN DO:
        RUN wgw/wgwfcolor (INPUT        wdetail.colors,
                           INPUT-OUTPUT nv_colorcode ).
    END.
    /* end A65-0288 */
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
         ASSIGN
             sic_bran.uwm301.bchyr     = nv_batchyr               
             sic_bran.uwm301.bchno     = nv_batchno               
             sic_bran.uwm301.bchcnt    = nv_batcnt   
             sic_bran.uwm301.policy    = sic_bran.uwm120.policy                 
             sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
             sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
             sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
             sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
             sic_bran.uwm301.itemno    = s_itemno
             sic_bran.uwm301.tariff    = wdetail.tariff    
             sic_bran.uwm301.covcod    = nv_covcod
             sic_bran.uwm301.cha_no    = wdetail.chasno
             sic_bran.uwm301.trareg    = nv_uwm301trareg
             sic_bran.uwm301.eng_no    = IF LENGTH(wdetail.eng) >= 25 THEN  TRIM(substr(wdetail.eng,1,25)) ELSE TRIM(wdetail.eng)
             sic_bran.uwm301.modcod    = wdetail.redbook
             sic_bran.uwm301.Tons      = INTEGER(wdetail.weight)
             sic_bran.uwm301.engine    = INTEGER(wdetail.cc)
             sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
             sic_bran.uwm301.garage    = wdetail.garage
             sic_bran.uwm301.body      = wdetail.body
             sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
             sic_bran.uwm301.mv_ben83  = trim(wdetail.bennefit) 
             sic_bran.uwm301.vehreg    = wdetail.vehreg
             sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
             sic_bran.uwm301.vehuse    = wdetail.vehuse
             sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
             sic_bran.uwm301.sckno     = 0
             sic_bran.uwm301.itmdel    = NO
             sic_bran.uwm301.prmtxt    = IF substr(wdetail.policy,1,2) = "R0" AND wdetail.prepol = "" AND wdetail.covcod = "1" AND n_yr >= 2 THEN 
                                        "คุ้มครองอุปกรณ์เสริมไม่เกิน 20,000 บาท " + n_prmtxt  
                                         ELSE IF  substr(wdetail.policy,1,2) = "N0" AND wdetail.covcod = "1" AND n_yr >= 2 THEN 
                                         "คุ้มครองอุปกรณ์เสริมไม่เกิน 20,000 บาท"   ELSE ""     /*A65-0288 */
             sic_bran.uwm301.logbok    = TRIM(wdetail.insp)       /* ตรวจสภาพ : A65-0288*/
             sic_bran.uwm301.car_color = trim(nv_colorcode)   /* สีรถ     : A65-0288*/
             wdetail.tariff            = sic_bran.uwm301.tariff
             /* A67-0076 */
             sic_bran.uwm301.watts     = deci(wdetail.hp)  
             sic_bran.uwm301.maksi     = IF index(wdetail.subclass,"E") <> 0 THEN INTE(wdetail.maksi) ELSE 0     
             sic_bran.uwm301.eng_no2   = IF LENGTH(wdetail.eng) > 25 THEN TRIM(substr(wdetail.eng,25,LENGTH(wdetail.eng))) ELSE ""
             sic_bran.uwm301.battper   = INTE(wdetail.battper)
             sic_bran.uwm301.battyr    = INTE(wdetail.battyr)  
             sic_bran.uwm301.battno    = wdetail.battno 
             sic_bran.uwm301.chargno   = wdetail.chargno 
             /*sic_bran.uwm301.chargsi   = deci(wdetail.chargsi)*/ .
             /* end : A67-0076 */                                                                                      
            s_recid4         = RECID(sic_bran.uwm301).
         IF wdetail.drivnam = "Y" THEN DO:
             IF wdetail.prepol = "" THEN RUN proc_chkdrive.        /*A67-0076 */
             /*add by :A67-0076 */
             ELSE DO:
                FOR EACH ws0m009 WHERE ws0m009.policy = nv_driver NO-LOCK .
                   CREATE brstat.mailtxt_fil.
                   ASSIGN brstat.mailtxt_fil.policy  = TRIM(sic_bran.uwm301.policy) +
                                    STRING(sic_bran.uwm301.rencnt,"99" ) +
                                    STRING(sic_bran.uwm301.endcnt,"999")  +
                                    STRING(sic_bran.uwm301.riskno,"999") +
                                    STRING(sic_bran.uwm301.itemno,"999")    
                       brstat.mailtxt_fil.lnumber = INTEGER(ws0m009.lnumber)
                       brstat.mailtxt_fil.ltext   = ws0m009.ltext  
                       brstat.mailtxt_fil.ltext2  = ws0m009.ltext2   
                       brstat.mailtxt_fil.bchyr   = nv_batchyr 
                       brstat.mailtxt_fil.bchno   = nv_batchno 
                       brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                       brstat.mailtxt_fil.drivbirth = ws0m009.drivbirth 
                       brstat.mailtxt_fil.drivage   = ws0m009.drivage    
                       brstat.mailtxt_fil.occupcod  = ws0m009.occupcod   
                       brstat.mailtxt_fil.occupdes  = ws0m009.occupdes   
                       brstat.mailtxt_fil.cardflg   = ws0m009.cardflg    
                       brstat.mailtxt_fil.drividno  = ws0m009.drividno   
                       brstat.mailtxt_fil.licenno   = ws0m009.licenno   
                       brstat.mailtxt_fil.drivnam   = ws0m009.drivnam   
                       brstat.mailtxt_fil.gender    = ws0m009.gender    
                       brstat.mailtxt_fil.drivlevel = ws0m009.drivlevel 
                       brstat.mailtxt_fil.levelper  = ws0m009.levelper  
                       brstat.mailtxt_fil.titlenam  = ws0m009.titlenam  
                       brstat.mailtxt_fil.licenexp  = ws0m009.licenexp  
                       brstat.mailtxt_fil.firstnam  = ws0m009.firstnam  
                       brstat.mailtxt_fil.lastnam   = ws0m009.lastnam  
                       brstat.mailtxt_fil.dconsen   = ws0m009.dconsen .
                   ASSIGN n_count = INTEGER(ws0m009.lnumber)
                          wdetail.drivlevel = IF INTE(wdetail.drivlevel) = 0 THEN STRING(ws0m009.drivlevel)  
                              ELSE IF INTE(ws0m009.drivlevel) < INTE(wdetail.drivlevel) THEN string(ws0m009.drivlevel) ELSE wdetail.drivlevel .
                END.
             END.
             /* end A67-0076 */
         END.
         IF wdetail.redbook <> "" THEN DO:
             FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass      AND
                       stat.maktab_fil.modcod = wdetail.redbook No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN  sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                     wdetail.cargrp          =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
                     wdetail.body            =  stat.maktab_fil.body 
                     sic_bran.uwm301.maksi   =  IF sic_bran.uwm301.maksi = 0 THEN stat.maktab_fil.maksi ELSE sic_bran.uwm301.maksi /*A67-0087*/
                     sic_bran.uwm301.seats   =  IF sic_bran.uwm301.seats = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats.
         END.
         ELSE DO:
             FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
                 makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL makdes31  THEN ASSIGN nv_simat  = makdes31.si_theft_p   nv_simat1 = makdes31.load_p   .    
             ELSE ASSIGN nv_simat  = 0  nv_simat1 = 0.
             Find LAST stat.maktab_fil USE-INDEX maktab04    Where
                 stat.maktab_fil.makdes   =     wdetail.brand            And                  
                 index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                 stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                 stat.maktab_fil.sclass   =     wdetail.subclass        AND
                 (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE  deci(wdetail.si)    OR
                  stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE  deci(wdetail.si) )  AND  
                 stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
                 No-lock no-error no-wait.
             If  avail stat.maktab_fil  Then 
                 ASSIGN wdetail.redbook         =  stat.maktab_fil.modcod
                 wdetail.body            =  stat.maktab_fil.body 
                 wdetail.weight          =  STRING(stat.maktab_fil.tons)
                 sic_bran.uwm301.tons    =  stat.maktab_fil.tons
                 sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                 wdetail.cargrp          =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.body    =  stat.maktab_fil.body
                 sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                 sic_bran.uwm301.seats   =  IF sic_bran.uwm301.seats = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats
                 sic_bran.uwm301.maksi   =  IF sic_bran.uwm301.maksi = 0 THEN stat.maktab_fil.maksi ELSE sic_bran.uwm301.maksi /*A67-0087*/    .
         END.
         IF sic_bran.uwm301.modcod = ""  THEN RUN proc_maktab.
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
ASSIGN 
    nv_tariff = sic_bran.uwm301.tariff
    nv_class  = wdetail.prempa +  wdetail.subclass    /*IF wdetail.poltyp = "v72" THEN wdetail.subclass ELSE wdetail.prempa +  wdetail.subclass*/
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = DECI(wdetail.cc)
    nv_tons   = deci(wdetail.weight)
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse
    nv_COMPER = deci(wdetail.comper) 
    nv_comacc = deci(wdetail.comacc) 
    nv_seats  = INTE(wdetail.seat)
    nv_tons   = DECI(wdetail.weight)
    /*nv_dss_per = 0     */ /*A63-0130 */
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
    nv_totsi   =  0 
 fi_show = "Check data base... premium campaign......" .
DISP fi_show WITH FRAM fr_main.
IF wdetail.compul = "y" THEN DO:
    IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN nv_class  = "140A".
    ELSE nv_class  = "110".
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
      nv_pdacod   = "" .
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
ELSE DO:
    /* comment by : A65-0288..
    run proc_calpremt .      
    run proc_adduwd132prem . 
    ...end A65-0288....*/
     /* add by : A65-0288..*/
    FIND LAST wexcamp WHERE wexcamp.policy    = TRIM(wdetail.policy) AND
                            wexcamp.campaign  = TRIM(wdetail.product) AND 
                            wexcamp.polmaster <> "" NO-LOCK NO-ERROR .
    IF AVAIL wexcamp THEN DO:
         RUN proc_Create132_camp.
    END.
    ELSE DO:
        IF substr(wdetail.subclass,1,1) = "E" THEN RUN proc_calpremt_EV .
        ELSE RUN proc_calpremt .      
        run proc_adduwd132prem . 
    END.
    /*...end A65-0288....*/
END.

/* comment by : ranu A65-0288...
IF nv_pdprm <> DECI(wdetail.premt) THEN DO:
     ASSIGN
            wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
            wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_pdprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt
            wdetail.pass    = IF wdetail.pass = "N" THEN "N" ELSE "Y"    
            wdetail.OK_GEN  = "N".
END.
...end ranu A65-0288....*/

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN 
         sic_bran.uwm100.gap_p  = nv_gapprm
         sic_bran.uwm100.prem_t = nv_pdprm
         sic_bran.uwm100.sigr_p = inte(wdetail.si).
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
        sic_bran.uwm301.mv41seat = inte(wdetail.seat41)
    /* assign A63-0130 */
        sic_bran.uwm301.tons     = IF sic_bran.uwm301.tons = 0 THEN 0 ELSE IF sic_bran.uwm301.ton < 100 THEN ( sic_bran.uwm301.tons * 1000 )
                                   ELSE sic_bran.uwm301.tons .

IF sic_bran.uwm301.tons < 100  AND ( SUBSTR(sic_bran.uwm120.CLASS,2,1) = "3"   OR  
     SUBSTR(sic_bran.uwm120.CLASS,2,1) = "4"   OR  SUBSTR(sic_bran.uwm120.CLASS,2,1) = "5"  OR  
     SUBSTR(sic_bran.uwm120.CLASS,2,3) = "803" OR SUBSTR(sic_bran.uwm120.CLASS,2,3) = "804" OR  
     SUBSTR(sic_bran.uwm120.CLASS,2,3) = "805" ) THEN DO:
       ASSIGN
            wdetail.comment = wdetail.comment + "| " + sic_bran.uwm120.CLASS + " ระบุน้ำหนักรถไม่ถูกต้อง "
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
END.
/* end a63-0129 */

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_clearmailtxt C-Win 
PROCEDURE proc_clearmailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
       nv_dlevper   = 0 .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_comp C-Win 
PROCEDURE proc_comp :
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
       wcomp.seat      =  "7"       /*เก๋ง /vehuse1*/
       wcomp.premcomp  =  600
       wcomp.body      =  "SEDAN" .     /*A64-0060*/ 
CREATE wcomp.                      
ASSIGN wcomp.package   = "120A"    
       wcomp.seat      =  "12"     /*ตู้ /vehuse1*/
       wcomp.premcomp  =  1100
       wcomp.body      =  "VAN" .     /*A64-0060*/ 
CREATE wcomp.                      
ASSIGN wcomp.package   = "120B"    
       wcomp.seat      =  "15"     /*ตู้ /vehuse1*/
       wcomp.premcomp  =  2050
       wcomp.body      =  "VAN" .     /*A64-0060*/ 
CREATE wcomp.                      
ASSIGN wcomp.package   = "120C"    
       wcomp.seat      =  "20"     /*ตู้ /vehuse1*/
       wcomp.premcomp  =  3200
       wcomp.body      =  "VAN" .     /*A64-0060*/ 
CREATE wcomp.                      
ASSIGN wcomp.package   = "120D"    
       wcomp.seat      =  "40"     /*ตู้ /vehuse1*/
       wcomp.premcomp  =  3740
       wcomp.body      =  "VAN" .     /*A64-0060*/ 
/* เช็ค ตัน*/                      
CREATE wcomp.                      
ASSIGN wcomp.package   = "140A"    
       wcomp.seat      =  "3"      /*กระบะ /vehuse1*/
       wcomp.premcomp  =  900
       wcomp.body      =  "PICKUP" .     /*A64-0060*/ 
CREATE wcomp.                      
ASSIGN wcomp.package   = "140B"    
       wcomp.seat      =  "3"      /*กระบะ /vehuse1*/
       wcomp.premcomp  =  1220
       wcomp.body      =  "TRUCK" .     /*A64-0060*/ 
CREATE wcomp.                      
ASSIGN wcomp.package   = "140C"    
       wcomp.seat      =  "3"      /*กระบะ /vehuse1*/
       wcomp.premcomp  =  1310
       wcomp.body      =  "TRUCK" .     /*A64-0060*/ 
CREATE wcomp.                      
ASSIGN wcomp.package   = "140D"    
       wcomp.seat      =  "3"      /*กระบะ /vehuse1*/ 
       wcomp.premcomp  =  1700
       wcomp.body      =  "TRUCK" .     /*A64-0060*/ 

/*Add Jiraporn A59-0342*/
/*จักรยานยนต์/vehuse1*/
/*CREATE wcomp.
ASSIGN wcomp.package   = "130A"
       wcomp.premcomp  =  150.
CREATE wcomp.
ASSIGN wcomp.package   = "130B"
       wcomp.premcomp  =  300.
CREATE wcomp.
ASSIGN wcomp.package   = "130C"
       wcomp.premcomp  =  400.
CREATE wcomp.
ASSIGN wcomp.package   = "130D"
       wcomp.premcomp  =  600.
/*รถบบรทุกน้ำมัน /vehuse1*/
CREATE wcomp.
ASSIGN wcomp.package   = "142A"
       wcomp.premcomp  =  1680.
CREATE wcomp.
ASSIGN wcomp.package   = "142B"
       wcomp.premcomp  =  2320.
CREATE wcomp.
ASSIGN wcomp.package   = "150"      /*หัวรถลากจูง /vehuse1*/
       wcomp.premcomp  =  2370.     
CREATE wcomp.                       
ASSIGN wcomp.package   = "160"      /*รถพ่วง /vehuse1*/
       wcomp.premcomp  =  600.      
CREATE wcomp.                       
ASSIGN wcomp.package   = "170A"     /*รถสามล้อเครื่อง /vehuse1*/
       wcomp.premcomp  =  720.      
CREATE wcomp.                       
ASSIGN wcomp.package   = "170B"     
       wcomp.premcomp  =  400.      
CREATE wcomp.                       
ASSIGN wcomp.package   = "171"      /*สามล้อแปรสภาพ /vehuse1*/
       wcomp.premcomp  =  400.      
CREATE wcomp.                       
ASSIGN wcomp.package   = "401"      /*ยนต์ป้ายแดง /vehuse1*/
       wcomp.premcomp  =  1530.     
CREATE wcomp.                       
ASSIGN wcomp.package   = "406"      /*ยนต์เกษตร /vehuse1*/
       wcomp.premcomp  =  90.       
CREATE wcomp.                       
ASSIGN wcomp.package   = "407"      /*ยนต์อื่นๆ /vehuse1*/
       wcomp.premcomp  =  770.     */ 
                                    
CREATE wcomp.                       
ASSIGN wcomp.package   = "210"      /*เก๋ง vehuse2*/
       wcomp.seat      = "7"    
       wcomp.premcomp  =  1900
       wcomp.body      =  "SEDAN" .     /*A64-0060*/ 
/*CREATE wcomp.                       
ASSIGN wcomp.package   = "310"      /*เก๋ง vehuse2*/
       wcomp.seat      = "7"
       wcomp.premcomp  =  1900. */ 
/*ตู้ vehuse2*/
CREATE wcomp.
ASSIGN wcomp.package   = "220A" 
       wcomp.seat      = "12"
       wcomp.premcomp  =  2320
       wcomp.body      =  "VAN" .     /*A64-0060*/ 
CREATE wcomp.
ASSIGN wcomp.package   = "220B"
       wcomp.seat      = "15"
       wcomp.premcomp  =  3480
       wcomp.body      =  "VAN" .     /*A64-0060*/ 
CREATE wcomp.
ASSIGN wcomp.package   = "220C"
       wcomp.seat      = "20"
       wcomp.premcomp  =  6660
       wcomp.body      =  "VAN" .     /*A64-0060*/ 
CREATE wcomp.
ASSIGN wcomp.package   = "220D"
       wcomp.seat      = "40"
       wcomp.premcomp  =  7520
       wcomp.body      =  "VAN" .     /*A64-0060*/ 
/*CREATE wcomp.
ASSIGN wcomp.package   = "320A"
       wcomp.seat      = "12"
       wcomp.premcomp  =  2320.
CREATE wcomp.
ASSIGN wcomp.package   = "320B"
       wcomp.seat      = "15"
       wcomp.premcomp  =  3480.
CREATE wcomp.
ASSIGN wcomp.package   = "320C"
       wcomp.seat      = "20"
       wcomp.premcomp  =  6660.
CREATE wcomp.
ASSIGN wcomp.package   = "320D"
       wcomp.seat      = "40"
       wcomp.premcomp  =  7520.
/*โดยสารหมวด4 vehuse2*/
CREATE wcomp.
ASSIGN wcomp.package   = "220E"
       wcomp.seat      = "12"
       wcomp.premcomp  =  1580.
CREATE wcomp.
ASSIGN wcomp.package   = "220F"
       wcomp.seat      = "15" 
       wcomp.premcomp  =  2260.
CREATE wcomp.
ASSIGN wcomp.package   = "220G"
       wcomp.seat      = "20"
       wcomp.premcomp  =  3810.
CREATE wcomp.
ASSIGN wcomp.package   = "220H"
       wcomp.seat      = "40"
       wcomp.premcomp  =  4630.
CREATE wcomp.
ASSIGN wcomp.package   = "320E"
       wcomp.seat      = "12"
       wcomp.premcomp  =  1580.
CREATE wcomp.
ASSIGN wcomp.package   = "320F"
       wcomp.seat      = "15"
       wcomp.premcomp  =  2260.
CREATE wcomp.
ASSIGN wcomp.package   = "320G"
       wcomp.seat      = "20"
       wcomp.premcomp  =  3810.
CREATE wcomp.
ASSIGN wcomp.package   = "320H"
       wcomp.seat      = "40"
       wcomp.premcomp  =  4630.*/
/*รถยนต์บรรทุก  เช็คตัน vehuse2*/
/* open comment by A60-0542*/
CREATE wcomp.
ASSIGN wcomp.package   = "240A"
       wcomp.seat      = "3"
       wcomp.premcomp  =  1760
       wcomp.body      =  "PICKUP" .     /*A64-0060*/ 
CREATE wcomp.
ASSIGN wcomp.package   = "240B"
       wcomp.seat      = "3"
       wcomp.premcomp  =  1830
       wcomp.body      =  "TRUCK" .     /*A64-0060*/ 
CREATE wcomp.
ASSIGN wcomp.package   = "240C"
       wcomp.seat      = "3"
       wcomp.premcomp  =  1980
       wcomp.body      =  "TRUCK" .     /*A64-0060*/
CREATE wcomp.
ASSIGN wcomp.package   = "240D"
       wcomp.seat      = "3"
       wcomp.premcomp  =  2530
       wcomp.body      =  "TRUCK" .     /*A64-0060*/
/*-- end a60-0542---*/
/*CREATE wcomp.
ASSIGN wcomp.package   = "340A"
       wcomp.seat      = "3"
       wcomp.premcomp  =  1760.
CREATE wcomp.
ASSIGN wcomp.package   = "340B"
       wcomp.seat      = "3"
       wcomp.premcomp  =  1830.
CREATE wcomp.
ASSIGN wcomp.package   = "340C"
       wcomp.seat      = "3"
       wcomp.premcomp  =  1980.
CREATE wcomp.
ASSIGN wcomp.package   = "340D"
       wcomp.seat      = "3"
       wcomp.premcomp  =  2530.

/*รถจักรยานยนต์ Vehuse2*/
CREATE wcomp.
ASSIGN wcomp.package   = "230A"
       wcomp.premcomp  =  150.
CREATE wcomp.
ASSIGN wcomp.package   = "230B"
       wcomp.premcomp  =  350.
CREATE wcomp.
ASSIGN wcomp.package   = "230C"
       wcomp.premcomp  =  400.
CREATE wcomp.
ASSIGN wcomp.package   = "230D"
       wcomp.premcomp  =  600.
CREATE wcomp.
ASSIGN wcomp.package   = "330A"
       wcomp.premcomp  =  150.
CREATE wcomp.
ASSIGN wcomp.package   = "330B"
       wcomp.premcomp  =  350.
CREATE wcomp.
ASSIGN wcomp.package   = "330C"
       wcomp.premcomp  =  400.
CREATE wcomp.
ASSIGN wcomp.package   = "330D"
       wcomp.premcomp  =  600.
/*รถสามล้อเครื่อง /vehuse2*/
CREATE wcomp.
ASSIGN wcomp.package   = "270A"
       wcomp.premcomp  =  1440.
CREATE wcomp.
ASSIGN wcomp.package   = "270B"
       wcomp.premcomp  =  400.
CREATE wcomp.
ASSIGN wcomp.package   = "370A"
       wcomp.premcomp  =  1440.
CREATE wcomp.
ASSIGN wcomp.package   = "370B"
       wcomp.premcomp  =  400.

/*รถสามล้อแปรสภาพ /vehuse2*/
CREATE wcomp.
ASSIGN wcomp.package   = "271" 
       wcomp.premcomp  =  400.
CREATE wcomp.
ASSIGN wcomp.package   = "371" 
       wcomp.premcomp  =  400.

/*บรรทุกน้ำมัน vehuse2*/
CREATE wcomp.
ASSIGN wcomp.package   = "242A"
       wcomp.premcomp  =  1980.
CREATE wcomp.
ASSIGN wcomp.package   = "242B"
       wcomp.premcomp  =  3060.
CREATE wcomp.
ASSIGN wcomp.package   = "342A"
       wcomp.premcomp  =  1980.
CREATE wcomp.
ASSIGN wcomp.package   = "342B"
       wcomp.premcomp  =  3060.

CREATE wcomp.
ASSIGN wcomp.package   = "250"    /*หัวลากจูง vehuse2*/
       wcomp.premcomp  =  3160.   
CREATE wcomp.                     
ASSIGN wcomp.package   = "350"    /*หัวลากจูง vehuse2*/
       wcomp.premcomp  =  3160.                                
CREATE wcomp.                     
ASSIGN wcomp.package   = "260"    /*รถพ่วง vehuse2*/
       wcomp.premcomp  =  600.    
CREATE wcomp.                     
ASSIGN wcomp.package   = "360"    /*รถพ่วง vehuse2*/
       wcomp.premcomp  =  600.
/*End Add Jiraporn A59-0342*/*/




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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Create132_camp C-Win 
PROCEDURE proc_Create132_camp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  A65-0203     
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
def var nv_comment   as char .
def var nv_warning   as char .
def var nv_pass      as char .
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

    fi_show = "Create data uwd132 policy: " + wdetail.policy.
    DISP fi_show WITH FRAME fr_main.
    
    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 
           /* A64-0309 */ 
           nv_411t = 0      nv_412t = 0
           nv_42t  = 0      nv_43t  = 0.
           /* end : A64-0309 */ 
    FIND LAST wexcamp WHERE wexcamp.policy    = TRIM(wdetail.policy) AND
                            wexcamp.campaign  = TRIM(wdetail.product) AND
                            wexcamp.polmaster <> "" NO-LOCK NO-ERROR .
    IF AVAIL wexcamp THEN DO:
         FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
                  stat.pmuwd132.campcd        = trim(wexcamp.campaign)   AND 
                  TRIM(stat.pmuwd132.policy)  = TRIM(wexcamp.polmaster)  NO-LOCK.    /*A64-0044*/
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
        
                   ASSIGN fi_show = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
                   DISP fi_show WITH FRAM fr_main. 
                   ASSIGN
                      sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                      sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                      sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                      sic_bran.uwd132.gap_ae  =  NO /*stat.pmuwd132.gap_ae --A64-0355--*/                
                      sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                      sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                      sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                      sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                      sic_bran.uwd132.pd_aep  =  "E" /*stat.pmuwd132.pd_aep --A64-0355--*/                      
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
                         
                   IF sic_bran.uwd132.bencod = "ENGC" THEN ASSIGN SUBSTRING(sic_bran.uwd132.benvar,31,30) = trim(STRING(sic_bran.uwm301.engine)) .
                   IF sic_bran.uwd132.bencod = "ENGT" THEN ASSIGN SUBSTRING(sic_bran.uwd132.benvar,31,30) = TRIM(STRING(sic_bran.uwm301.tons)).
                   IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                  
                   IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  wexcamp.pa411 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
                   IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  wexcamp.pa412 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
                   IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  wexcamp.pa42  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
                   IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  wexcamp.pa43  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).   
                   
                   If nv_ncbper  <> 0 Then do:
                       Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                           sicsyac.xmm104.tariff = "X"           AND
                           sicsyac.xmm104.class  = trim(trim(wdetail.prempa) + trim(wdetail.subclass)) AND 
                           sicsyac.xmm104.covcod = wdetail.covcod AND 
                           sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
                       IF not avail  sicsyac.xmm104  Then do:
                           Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                           ASSIGN wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104."
                                  wdetail.pass    = "N" .
                                  
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
        RUN wgw\wgwchkpadd 
            (input sic_bran.uwm100.comdat, 
             input sic_bran.uwm100.expdat, 
             input wdetail.subclass, /* 110 ,210 ,320 */
             input int(wexcamp.pa411),  
             input int(wexcamp.pa412),             
             input int(wexcamp.pa42 ) , 
             input int(wexcamp.pa43 ) ,  
             input int(wdetail.seat),  
             input nv_411t,  
             input nv_412t,  
             input nv_42t ,  
             input nv_43t ,  
             input wexcamp.polmaster,
             input wexcamp.campaign,
             input-output nv_comment  ,
             input-output nv_warning  ,
             input-output nv_pass). 
        if nv_comment <> "" then assign wdetail.comment = wdetail.comment + trim(nv_comment) + "| " .
        ASSIGN wdetail.pass = IF wdetail.pass  = "N" THEN "N" ELSE IF nv_pass = "Y" THEN "Y" ELSE "N" . 

        sic_bran.uwm130.bptr03  =  nv_bptr. 
        RELEASE stat.pmuwd132.
        RELEASE sic_bran.uwd132.
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
/*DEF VAR len AS INTE.
DEF BUFFER buwm100 FOR wdetail.
    ASSIGN
    len = LENGTH(wdetail.policy)
    len = len - 1    .
    FOR EACH buwm100 WHERE buwm100.poltyp <> wdetail.poltyp NO-LOCK.
       IF index(wdetail.poltyp,"70") <> 0 THEN   substr(buwm100.policy,2,len) = SUBSTR(wdetail.policy,2,len) AND
                buwm100.policy    <> wdetail.policy  NO-LOCK.
        ASSIGN 
            n_cr2 = buwm100.policy.
    END.*/
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
    wdetail.prepol = nv_c .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_definitions C-Win 
PROCEDURE proc_definitions :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Modify by : Ranu I. A65-0288 20/10/2022 เพิ่มการเก็บข้อมูลสีรถ และข้อมูลการตรวจสภาพ */
/* Modify by : Kridtiya i A66-0160 Add color and campaign code = Producer             */
/* Modify by : Ranu I. A67-0076 เพิ่มเงื่อนไขรถไฟฟ้า */
/* Modify by : Ranu I. A67-0198 แก้ไขเงื่อนไขการเช็ค Class พรบ.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initcal C-Win 
PROCEDURE proc_initcal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN   nv_polday  = 0 
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
         nv_41prmt  = 0      /* ระบุเบี้ย รย.*/  
         nv_412prmt = 0       /* ระบุเบี้ย รย.*/ 
         nv_413prmt = 0       /* ระบุเบี้ย รย.*/ 
         nv_414prmt = 0       /* ระบุเบี้ย รย.*/ 
         nv_42prmt  = 0      /* ระบุเบี้ย รย.*/  
         nv_43prmt  = 0      /* ระบุเบี้ย รย.*/ 
         nv_seat41  = 0          
         nv_dedod   = 0
         nv_addod   = 0
         nv_dedpd   = 0        
         nv_ncbp    = 0
         nv_fletp   = 0
         nv_dspcp   = 0
         nv_dstfp   = 0
         nv_clmp    = 0
         nv_mainprm  = 0  
         nv_dodamt   = 0  /*A67-0029*/ /* ระบุเบี้ย DOD */   
         nv_dadamt   = 0  /*A67-0029*/ /* ระบุเบี้ย DOD1 */  
         nv_dpdamt   = 0  /*A67-0029*/ /* ระบุเบี้ย DPD */   
         nv_ncbamt   = 0  /* ระบุเบี้ย  NCB PREMIUM */           
         nv_fletamt  = 0  /* ระบุเบี้ย  FLEET PREMIUM */          
         nv_dspcamt  = 0  /* ระบุเบี้ย  DSPC PREMIUM */           
         nv_dstfamt  = 0  /* ระบุเบี้ย  DSTF PREMIUM */           
         nv_clmamt   = 0  /* ระบุเบี้ย  LOAD CLAIM PREMIUM */ 
         nv_baseprm  = 0
         nv_baseprm3 = 0
         nv_pdprem   = 0
         nv_netprem = 0     /*เบี้ยสุทธิ */
         nv_gapprm  = 0     /*เบี้ยรวม */
         nv_gapprem  = 0  
         nv_flagprm = "N"   /* N = เบี้ยสุทธิ, G = เบี้ยรวม */
         nv_effdat  = ?
         nv_ratatt  = 0        
         nv_siatt   = 0        
         nv_netatt  = 0        
         nv_fltatt  = 0        
         nv_ncbatt  = 0        
         nv_dscatt  = 0 
         nv_status  = "" 
         nv_fcctv   = NO
         nv_uom1_c  = "" 
         nv_uom2_c  = "" 
         nv_uom5_c  = "" 
         nv_uom6_c  = "" 
         nv_uom7_c  = ""
         nv_message = "" 
         nv_attgap   = 0
         nv_atfltgap = 0
         nv_atncbgap = 0
         nv_atdscgap = 0
         nv_packatt  = ""
         nv_flgsht   = "P" 
         nv_level      = 0   
         nv_levper     = 0
         nv_tariff     = ""
         nv_adjpaprm   = NO
         nv_flgpol     = ""  /*NR=New RedPlate, NU=New Used Car, RN=Renew*/                   
         nv_flgclm     = "" /*NC=NO CLAIM , WC=With Claim*/  
         nv_chgflg     = NO /*IF DECI(wdetail.chargprm) <> 0 THEN YES ELSE NO  */   
         nv_chgrate    = 0 /*DECI(wdetail.chargrate)                          */
         nv_chgsi      = 0 /*INTE(wdetail.chargsi)                            */          
         nv_chgpdprm   = 0 /*DECI(wdetail.chargprm)                           */           
         nv_chggapprm  = 0                                     
         nv_battflg    = NO  /*IF DECI(wdetail.battprm) <> 0 THEN YES ELSE NO*/                                    
         nv_battrate   = 0  /*DECI(wdetail.battrate)                        */            
         nv_battsi     = 0  /*INTE(wdetail.battsi)                          */           
         nv_battprice  = 0  /*INTE(wdetail.battprice)                       */
         nv_battpdprm  = 0  /*DECI(wdetail.battprm)                         */            
         nv_battgapprm = 0                                                                                                                     
         nv_battyr     = 0 /*INTE(wdetail.battyr)                                  */
         nv_battper    = 0 /*DECI(wdetail.battper)                                 */
         nv_evflg      = NO   
         nv_compprm  = 0
         nv_uom9_v   = 0 .

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
    nv_usrid      = ""
    nv_transfer   = NO
    n_check       = ""
    nv_insref     = ""
    putchr        = "" 
    putchr1       = ""
    nv_typ        = ""
    nv_usrid      = SUBSTRING(USERID(LDBNAME(1)),3,4) 
    nv_transfer   = YES
    nv_insref     = "".

FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE 
    sicsyac.xmm600.NAME     = TRIM(wdetail.insnam)  AND
    sicsyac.xmm600.homebr   = TRIM(wdetail.branch)  AND
    sicsyac.xmm600.clicod   = "IN"                  NO-ERROR NO-WAIT.  /*end...comment by kridtiya i. A56-0047....*/ 
IF NOT AVAILABLE sicsyac.xmm600 THEN DO: 
    IF LOCKED sicsyac.xmm600 THEN DO:   
        ASSIGN nv_transfer = NO 
               n_insref    = sicsyac.xmm600.acno.
        RETURN.
    END.
    ELSE DO:
        ASSIGN 
            n_check   = "" 
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
    IF sicsyac.xmm600.acno <> "" THEN DO:
        ASSIGN
            nv_insref                 = trim(sicsyac.xmm600.acno) 
            n_insref                  = caps(trim(nv_insref)) 
            nv_transfer               = NO 
            sicsyac.xmm600.acno_typ   = trim(wdetail.insnamtyp)  /* CodeType. */                 
            sicsyac.xmm600.ntitle     = TRIM(wdetail.tiname)     /*Title for Name Mr/Mrs/etc*/   
            sicsyac.xmm600.firstname  = TRIM(wdetail.firstName)  /*F.Name.*/                     
            sicsyac.xmm600.lastName   = TRIM(wdetail.lastName)   /*L.Name.*/                     
            sicsyac.xmm600.fname      = ""                       /*First Name*/                  
            sicsyac.xmm600.name       = TRIM(wdetail.insnam)     /*Name Line 1*/                 
            sicsyac.xmm600.abname     = TRIM(wdetail.insnam)     /*Abbreviated Name*/            
            sicsyac.xmm600.icno       = TRIM(wdetail.ICNO)       /*IC No.*/                      
            sicsyac.xmm600.addr1      = trim(wdetail.iadd1)      /*Address line 1*/              
            sicsyac.xmm600.addr2      = trim(wdetail.iadd2)      /*Address line 2*/              
            sicsyac.xmm600.addr3      = trim(wdetail.iadd3)      /*Address line 3*/              
            sicsyac.xmm600.addr4      = trim(wdetail.iadd4)      /*Address line 4*/              
            sicsyac.xmm600.postcd     = trim(wdetail.postcd)     /* PC */                        
            sicsyac.xmm600.codeaddr1  = TRIM(wdetail.codeaddr1)  /*Province    */                
            sicsyac.xmm600.codeaddr2  = TRIM(wdetail.codeaddr2)  /*District    */                
            sicsyac.xmm600.codeaddr3  = trim(wdetail.codeaddr3)  /*Sub District*/                
            sicsyac.xmm600.birthdate  = DATE(wdetail.bdate)      /*DOB: */                       
            sicsyac.xmm600.codeocc    = trim(wdetail.codeocc)    /*Occupation. */                
            sicsyac.xmm600.occupation = trim(wdetail.occup)                                      
            sicsyac.xmm600.phone      = trim(wdetail.phone)     /*Phone no.*/                   
            sicsyac.xmm600.sex        = trim(wdetail.gender)    /*Gender.*/                     
            sicsyac.xmm600.nationality = trim(wdetail.nation)    /*Nationality: */               
            sicsyac.xmm600.telex      = TRIM(wdetail.email)      /* Email */                     
            sicsyac.xmm600.homebr     = TRIM(wdetail.branch)     /*Home branch*/                 
            sicsyac.xmm600.opened     = TODAY                     
            sicsyac.xmm600.chgpol     = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat     = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim     = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid      = nv_usrid  
            sicsyac.xmm600.dtyp20     = "" .
        RUN proc_addresstax.
       
    END.
END.
IF nv_transfer = YES THEN DO: 
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
        sicsyac.xmm600.acno_typ   = trim(wdetail.insnamtyp) /* CodeType. */
        sicsyac.xmm600.ntitle     = TRIM(wdetail.tiname)    /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.firstname  = TRIM(wdetail.firstName) /*F.Name.*/
        sicsyac.xmm600.lastName   = TRIM(wdetail.lastName)  /*L.Name.*/
        sicsyac.xmm600.fname      = ""                      /*First Name*/
        sicsyac.xmm600.name       = TRIM(wdetail.insnam)    /*Name Line 1*/
        sicsyac.xmm600.abname     = TRIM(wdetail.insnam)    /*Abbreviated Name*/
        sicsyac.xmm600.icno       = TRIM(wdetail.ICNO)      /*IC No.*/          
        sicsyac.xmm600.addr1      = trim(wdetail.iadd1)     /*Address line 1*/
        sicsyac.xmm600.addr2      = trim(wdetail.iadd2)     /*Address line 2*/
        sicsyac.xmm600.addr3      = trim(wdetail.iadd3)     /*Address line 3*/
        sicsyac.xmm600.addr4      = trim(wdetail.iadd4)     /*Address line 4*/ 
        sicsyac.xmm600.postcd     = trim(wdetail.postcd)    /* PC */  
        sicsyac.xmm600.codeaddr1  = TRIM(wdetail.codeaddr1) /*Province    */ 
        sicsyac.xmm600.codeaddr2  = TRIM(wdetail.codeaddr2) /*District    */ 
        sicsyac.xmm600.codeaddr3  = trim(wdetail.codeaddr3) /*Sub District*/ 
        sicsyac.xmm600.birthdate  = DATE(wdetail.bdate)     /*DOB: */
        sicsyac.xmm600.codeocc    = trim(wdetail.codeocc)   /*Occupation. */   
        sicsyac.xmm600.occupation = trim(wdetail.occup)     
        sicsyac.xmm600.phone      = trim(wdetail.phone)     /*Phone no.*/        
        sicsyac.xmm600.sex        = trim(wdetail.gender)    /*Gender.*/
        sicsyac.xmm600.nationality = trim(wdetail.nation)   /*Nationality: */
        sicsyac.xmm600.telex      = TRIM(wdetail.email)     /* Email */
        sicsyac.xmm600.homebr     = TRIM(wdetail.branch)    /*Home branch*/
        sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
        sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
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
        sicsyac.xmm600.gstreg   = ""                       /*GST Registration No.*/
        sicsyac.xmm600.fax      = ""                       /*Fax No.*/
        sicsyac.xmm600.name2    = ""                       /*Name Line 2*/
        sicsyac.xmm600.name3    = ""                       /*Name Line 3*/
        sicsyac.xmm600.nachg    = YES                      /*Change N&A on Renewal/Endt*/
        sicsyac.xmm600.regdate  = ?                        /*Agents registration Date*/
        sicsyac.xmm600.alevel   = 0                        /*Agency Level*/
        sicsyac.xmm600.taxno    = ""                       /*Agent tax no.*/
        sicsyac.xmm600.anlyc1   = ""                       /*Analysis Code 1*/
        sicsyac.xmm600.taxdate  = ?                        /*Agent tax date*/
        sicsyac.xmm600.anlyc5   =  ""                      /*Analysis Code 5*/
        sicsyac.xmm600.dtyp20   = "" .
    RUN proc_addresstax.
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
            sicsyac.xtm600.acno      = nv_insref               /*Account no.*/
            sicsyac.xtm600.firstname = trim(wdetail.firstName) 
            sicsyac.xtm600.lastname  = trim(wdetail.lastName)  
            sicsyac.xtm600.name      = TRIM(wdetail.insnam)    /*Name of Insured Line 1*/
            sicsyac.xtm600.abname    = TRIM(wdetail.insnam)    /*Abbreviated Name*/
            sicsyac.xtm600.addr1     = wdetail.iadd1           /*address line 1*/
            sicsyac.xtm600.addr2     = wdetail.iadd2           /*address line 2*/
            sicsyac.xtm600.addr3     = wdetail.iadd3           /*address line 3*/
            sicsyac.xtm600.addr4     = wdetail.iadd4           /*address line 4*/
            sicsyac.xtm600.postcd    = trim(wdetail.postcd)  
            sicsyac.xtm600.name2     = ""                                                 /*Name of Insured Line 2*/ 
            sicsyac.xtm600.ntitle    = TRIM(wdetail.tiname)                               /*Title*/
            sicsyac.xtm600.name3     = ""                                                 /*Name of Insured Line 3*/
            sicsyac.xtm600.fname     = "" .                                               /*First Name*/
    END.
END.
/*ASSIGN  wdetail.birthday = "".*/
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
RETURN.
HIDE MESSAGE NO-PAUSE.
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
/*Add by Kridtiya i. A63-0472
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno     = nv_insref  NO-ERROR NO-WAIT.  
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
   /* sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/      .  
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN
    ASSIGN 
    sicsyac.xtm600.postcd    = trim(wdetail.postcd)        
    sicsyac.xtm600.firstname = trim(wdetail.firstName)     
    sicsyac.xtm600.lastname  = trim(wdetail.lastName)  .   
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xtm600.
/*Add by Kridtiya i. A63-0472*/*/
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
    sicsyac.xzm056.branch   =  TRIM(wdetail.branch)    NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN sicsyac.xzm056.seqtyp =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref = TRIM(wdetail.branch)  + String(1,"999999")
            nv_lastno = 1.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(TRIM(wdetail.branch)) = 2 THEN
            nv_insref = TRIM(wdetail.branch) + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:   
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno + 1 ,"999999").
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(TRIM(wdetail.branch)) = 2 THEN
            nv_insref = TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").
        END.   
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.branch)
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(TRIM(wdetail.branch)) = 2 THEN
            nv_insref = TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"999999").
        END.
    END.
    ELSE DO:
        IF LENGTH(TRIM(wdetail.branch)) = 2 THEN
            nv_insref = TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       TRIM(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno,"99999").
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
                sicsyac.xzm056.branch    =  TRIM(wdetail.branch)
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
                sicsyac.xzm056.branch    =  TRIM(wdetail.branch)
                sicsyac.xzm056.des       =  "Company/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno. 
        END.
    END.
END.        /*lastno <= seqno */  
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
                 brstat.mailtxt_fil.dconsen    = NO
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
             brstat.mailtxt_fil.dconsen    = NO
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
DEF VAR nv_model AS CHAR FORMAT "x(50)" INIT "".
ASSIGN
    nv_model = ""
    nv_model = wdetail.model 
    nv_simat = 0
    nv_simat1 = 0
    nv_simat = (DECI(wdetail.si) * 50 / 100 )
    nv_simat1 = DECI(wdetail.si) + nv_simat .

IF INDEX(wdetail.model," ") <> 0 THEN 
    wdetail.model = SUBSTR(nv_model,1,INDEX(nv_model," ")).

Find FIRST stat.maktab_fil Use-index      maktab04          Where
    stat.maktab_fil.makdes   =     wdetail.brand            And                  
    index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
    /*stat.maktab_fil.engine   =     Integer(wdetail.cc)    AND*/
    stat.maktab_fil.sclass    =     wdetail.subclass        AND
    (stat.maktab_fil.si      >=     nv_simat                OR
     stat.maktab_fil.si      <=     nv_simat1 )             AND  
     stat.maktab_fil.seats    =     INTEGER(wdetail.seat)   
    No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    Assign
        wdetail.redbook         =  stat.maktab_fil.modcod  
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        wdetail.body            =  stat.maktab_fil.body 
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.seats   =  IF sic_bran.uwm301.seats = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats
        sic_bran.uwm301.maksi   =  IF sic_bran.uwm301.maksi = 0 THEN stat.maktab_fil.maksi ELSE sic_bran.uwm301.maksi .  /*A67-0087*/
IF wdetail.redbook  =  "" THEN DO:
    Find FIRST stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =     wdetail.brand              And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0          And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear)   AND
        /*stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND*/
        /*stat.maktab_fil.sclass   =     wdetail.subclass           AND*/
        (stat.maktab_fil.si       >=     nv_simat                  OR
         stat.maktab_fil.si       <=     nv_simat1 )             AND  
         stat.maktab_fil.seats    =     INTEGER(wdetail.seat)   
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
            wdetail.redbook         =  stat.maktab_fil.modcod  
            sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp          =  stat.maktab_fil.prmpac
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            wdetail.body            =  stat.maktab_fil.body 
            sic_bran.uwm301.body    =  stat.maktab_fil.body
            sic_bran.uwm301.seats   =  IF sic_bran.uwm301.seats = 0 THEN stat.maktab_fil.seats ELSE sic_bran.uwm301.seats 
            sic_bran.uwm301.maksi   =  IF sic_bran.uwm301.maksi = 0 THEN stat.maktab_fil.maksi ELSE sic_bran.uwm301.maksi . /*A67-0087*/
    
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open C-Win 
PROCEDURE proc_open :
/*OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y".   */
OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y" .

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
DEF VAR n_nameno AS INTE.
ASSIGN fi_show  = "Create table sic_bran.uwm100... file KK [NEW] " .  /*A55-0029*/
    DISP fi_show  WITH FRAME fr_main.
IF wdetail.policy <> "" THEN DO:
    IF wdetail.stk  <>  ""  THEN DO: 
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        
            FIND LAST sicuw.uwm100  USE-INDEX uwm10002  WHERE
               sicuw.uwm100.poltyp  = wdetail.poltyp     AND
               sicuw.uwm100.cedpol  = trim(wdetail.kkapp)  NO-LOCK NO-ERROR NO-WAIT.   /*A55-0055*/
            IF AVAIL sicuw.uwm100 THEN DO:
                /*A67-0198*/
                IF trim(wdetail.kkapp) = "" THEN DO: 
                END. /*A67-0198*/
                ELSE IF sicuw.uwm100.name1 <> "" AND YEAR(sicuw.uwm100.comdat) = YEAR(date(wdetail.comdat)) AND 
                   YEAR(sicuw.uwm100.expdat) = YEAR(date(wdetail.expdat)) THEN DO: 
                    ASSIGN
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| KK ApplicationNo. นี้ออกกรมธรรม์แล้ว : " + sicuw.uwm100.policy
                    wdetail.warning = "ออกกรมธรรม์แล้ว : " + sicuw.uwm100.policy .
                END.
            END.
       
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
                   stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN DO:
            IF trim(stat.detaitem.policy) <> trim(wdetail.policy) THEN 
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลข Sticker ถูกใช้ไปแล้ว" + stat.detaitem.policy 
                wdetail.warning = "เลขสติ๊กเกอร์ถูกใช้งานแล้ว ".
        END.
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END. /*wdetail.stk  <>  ""*/
    ELSE DO: /*sticker = ""*/ 
        
          FIND LAST sicuw.uwm100  USE-INDEX uwm10002  WHERE
              sicuw.uwm100.poltyp   = wdetail.poltyp  AND
              sicuw.uwm100.cedpol   = trim(wdetail.kkapp)  NO-LOCK NO-ERROR NO-WAIT.   /*A55-0055*/
          IF AVAIL sicuw.uwm100 THEN DO:
              /*A67-0198*/
              IF trim(wdetail.kkapp) = "" THEN DO: 
              END. /*A67-0198*/
              ELSE IF sicuw.uwm100.name1 <> "" AND YEAR(sicuw.uwm100.comdat) = YEAR(DATE(wdetail.comdat)) AND 
                 YEAR(sicuw.uwm100.expdat) = YEAR(DATE(wdetail.expdat)) THEN DO:
                    ASSIGN
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| KK ApplicationNo. นี้ออกกรมธรรม์แล้ว : " + sicuw.uwm100.policy
                    wdetail.warning = "ออกกรมธรรม์แล้ว : " + sicuw.uwm100.policy .
              END.
              IF wdetail.policy = "" THEN DO:
                  RUN proc_temppolicy.
                  wdetail.policy  = nv_tmppol.
              END.
              RUN proc_create100. 
          END. /*policy <> "" & stk = ""*/                 
          ELSE RUN proc_create100.  /*add A52-0172*/
    END.
END.
ELSE DO:  /*wdetail.policy = ""*/
    IF wdetail.stk  <>  ""  THEN DO:
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <> chr_sticker  Then DO:
            ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        END.
    
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001  WHERE
            sicuw.uwm100.poltyp   = wdetail.poltyp  AND
            sicuw.uwm100.cedpol   = trim(wdetail.kkapp)  NO-LOCK NO-ERROR NO-WAIT.   /*A55-0055*/
        IF AVAIL sicuw.uwm100 THEN DO:
             /*A67-0198*/
             IF trim(wdetail.kkapp) = "" THEN DO: 
             END. /*A67-0198*/
             ELSE IF sicuw.uwm100.name1 <> "" AND YEAR(sicuw.uwm100.comdat) = YEAR(DATE(wdetail.comdat)) AND 
               YEAR(sicuw.uwm100.expdat) = YEAR(DATE(wdetail.expdat)) THEN DO: 
                ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| KK ApplicationNo. นี้ออกกรมธรรม์แล้ว : " + sicuw.uwm100.policy
                wdetail.warning = "ออกกรมธรรม์แล้ว : " + sicuw.uwm100.policy .
             END.
        END.  
       
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลข Sticker ถูกใช้ไปแล้ว" + stat.detaitem.policy 
                wdetail.warning = "เลขสติ๊กเกอร์ถูกใช้งานแล้ว ".

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
/*add Kridtiya i. A54-0203 .....*/
IF wdetail.tiname = " " THEN wdetail.tiname = "คุณ".
ELSE DO:
    FIND FIRST brstat.msgcode WHERE 
        brstat.msgcode.compno = "999" AND
        index(wdetail.tiname,brstat.msgcode.MsgDesc) > 0    NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN  wdetail.tiname  =  trim(brstat.msgcode.branch).
    ELSE wdetail.tiname = "คุณ".
END.

ASSIGN nv_insref = "".  
RUN proc_insnam.
/*RUN proc_insnam2 . Add by Kridtiya i. A63-0472*/
/*END.*/ /* A58-0015 */
IF nv_insref = ""  THEN DO:
 ASSIGN wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "|รหัสลูกค้าเป็นค่าว่าง กรุณาตรวจสอบรันนิ่งโค้ดสาขา :" + wdetail.branch 
        wdetail.warning = "รหัสลูกค้าเป็นค่าว่าง กรุณาตรวจสอบรันนิ่งโค้ดสาขา " + wdetail.branch .
END.

DO TRANSACTION:
   ASSIGN
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = wdetail.poltyp
      sic_bran.uwm100.insref = nv_insref
      sic_bran.uwm100.opnpol = ""
      sic_bran.uwm100.anam2  = wdetail.Icno      
      sic_bran.uwm100.ntitle = wdetail.tiname         
      sic_bran.uwm100.name1  = TRIM(wdetail.insnam)  
      sic_bran.uwm100.name2  = wdetail.name2   
      sic_bran.uwm100.name3  = IF trim(wdetail.cedpol) <> "" THEN "(" + TRIM(wdetail.cedpol) + ")" ELSE ""  /* loand contact*/              
      sic_bran.uwm100.addr1  = wdetail.iadd1  
      sic_bran.uwm100.addr2  = wdetail.iadd2  
      sic_bran.uwm100.addr3  = wdetail.iadd3  
      sic_bran.uwm100.addr4  = wdetail.iadd4
      sic_bran.uwm100.postcd =  "" 
      sic_bran.uwm100.undyr  = String(Year(today),"9999")   /*   nv_undyr  */
      sic_bran.uwm100.branch = wdetail.branch                  /* nv_branch  */                        
      sic_bran.uwm100.dept   = nv_dept
      sic_bran.uwm100.usrid  = USERID(LDBNAME(1))
      /*sic_bran.uwm100.fstdat = TODAY                        /*TODAY */*//*A54-0140*/
      sic_bran.uwm100.fstdat = DATE(wdetail.comdat)           /*A54-0140*/
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
      sic_bran.uwm100.prog   = "wgwkkload"
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
      sic_bran.uwm100.acno1  = wdetail.producer       /*A55-0055*/
      sic_bran.uwm100.agent  = wdetail.agent       /*fi_agent */   /*nv_agent   */
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
      sic_bran.uwm100.cr_2   =  "" /*n_cr2*/
      sic_bran.uwm100.bchyr    = nv_batchyr          /*Batch Year */  
      sic_bran.uwm100.bchno    = nv_batchno          /*Batch No.  */  
      sic_bran.uwm100.bchcnt   = nv_batcnt           /*Batch Count*/  
      sic_bran.uwm100.prvpol   = wdetail.prepol      /*A52-0172*/
      sic_bran.uwm100.cedpol   = trim(wdetail.kkapp)   /*a61-0335*/
      sic_bran.uwm100.bs_cd    = wdetail.delerco    /*add kridtiya i. A53-0018 เพิ่ม Vatcode*/
      sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)    /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)     /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.postcd     = trim(wdetail.postcd)       /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.icno       = trim(wdetail.icno)         /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)      /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)    /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)    /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)    /*Add by Kridtiya i. A63-0472*/
      /*sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov)  /*Add by Kridtiya i. A63-0472*/*/
      sic_bran.uwm100.campaign   = TRIM(wdetail.producer)     /*A66-0160*/
      sic_bran.uwm100.dealer     = trim(wdetail.financecd)    /*Add by Kridtiya i. A63-0472*/    
      sic_bran.uwm100.cr_1       = wdetail.product            /*Add by Kridtiya i. A63-0472*/   
      sic_bran.uwm100.finint     = wdetail.dealtms     /*wdetail.dealer */          /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.s_tel[1]   = wdetail.notifyno
      sic_bran.uwm100.s_tel[2]   = wdetail.RefNo   
      sic_bran.uwm100.s_tel[3]   = wdetail.KKQuo   
      sic_bran.uwm100.s_tel[4]   = wdetail.RiderNo .

      IF wdetail.prepol <> " " THEN DO:
          IF wdetail.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = ""
                                                 sic_bran.uwm100.tranty  = "R".  
          ELSE 
              ASSIGN
                  sic_bran.uwm100.prvpol  = wdetail.prepol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                  sic_bran.uwm100.tranty  = "R".               /*Transaction Type (N/R/E/C/T)*/
      END.
      IF wdetail.pass = "Y" THEN
        sic_bran.uwm100.impflg  = YES.
      ELSE 
        sic_bran.uwm100.impflg  = NO.
      /* comment by : A65-0288 ..
      IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN 
         sic_bran.uwm100.accdat = sic_bran.uwm100.comdat. 
      ...end A65-0288..*/ 

      /* add : A65-0288 */
      IF sic_bran.uwm100.comdat >= TODAY  THEN sic_bran.uwm100.accdat = TODAY. 
      ELSE IF sic_bran.uwm100.comdat < TODAY THEN sic_bran.uwm100.accdat = sic_bran.uwm100.comdat. 
      /* end : A65-0288*/

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
END. /*transaction*/
/*RUN proc_uwd100. */  
/*kridtiya i. A52-0293.....*/
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
            sic_bran.uwm120.class  = wdetail.prempa  + wdetail.subclass
            s_recid2     = RECID(sic_bran.uwm120).
    END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policy-old C-Win 
PROCEDURE proc_policy-old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
/*DEF VAR n_nameno AS INTE .*/
ASSIGN fi_show = "Check data Premium at cedingpol and create policy......" .
DISP fi_show WITH FRAM fr_main.
IF wdetail.policy <> "" THEN DO:
    IF wdetail.stk  <>  ""  THEN DO: 
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            /*MESSAGE "Sticker Number"  wdetail.stk "ใช้ Generate ไม่ได้ เนื่องจาก Modulo Error"  VIEW-AS ALERT-BOX.*/
            ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        /*comment by Kridtiya i. A55-0008......คำสั่งนี้ทำให้ระบบช้า.........
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
        index(sicuw.uwm100.cedpol,wdetail.cedpol) <> 0 NO-ERROR NO-WAIT.
        end...comment by Kridtiya i. A55-0008......*/
        /*add by Kridtiya i. A55-0008......*/
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol =  wdetail.cedpol  NO-LOCK NO-ERROR NO-WAIT.
        /*end...add by Kridtiya i. A55-0008......*/
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ((sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ?) OR (sicuw.uwm100.releas = YES)) AND
                (sicuw.uwm100.poltyp =  wdetail.poltyp) THEN DO:   /*A55-0029*/
                IF sicuw.uwm100.expdat > date(wdetail.comdat) THEN
                    /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
                    ASSIGN wdetail.pass = "N"
                    wdetail.comment     = wdetail.comment + "| เลขที่สัญญานี้ได้ถูกใช้ไปแล้วในระบบ Premium "
                    wdetail.warning  = "Program Running Policy No. ให้ชั่วคราว".
            END.
        END.
        ASSIGN nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.detaitem THEN 
            /*MESSAGE "หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้วโดยเลขที่กรมธรรม์ ." stat.Detaitem.policy VIEW-AS ALERT-BOX.*/
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.       /*  wdetail.stk  <>  "" .......  */
    ELSE DO:   /*  sticker = ""                 */ 
        /*comment by Kridtiya i. A55-0008......
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
        index(sicuw.uwm100.cedpol,wdetail.cedpol) <> 0 NO-ERROR NO-WAIT.
        end...comment by Kridtiya i. A55-0008......*/
        /*add by Kridtiya i. A55-0008......*/
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol =  wdetail.cedpol  NO-LOCK NO-ERROR NO-WAIT.   /*end...add by Kridtiya i. A55-0008.....*/
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ((sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ?) OR (sicuw.uwm100.releas = YES)) AND
                (sicuw.uwm100.poltyp =  wdetail.poltyp) THEN DO:   /*A55-0029*/
                IF sicuw.uwm100.expdat > date(wdetail.comdat) THEN
                    /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
                    ASSIGN wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| เลขที่สัญญานี้ได้ถูกใช้ไปแล้วในระบบ Premium "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            END.
            IF wdetail.policy = "" THEN DO:
                RUN proc_temppolicy.
                wdetail.policy  = nv_tmppol.
            END.
            RUN proc_create100. 
        END.
        ELSE RUN proc_create100.   
    END. /* else ...*/
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
        /*comment by Kridtiya i. A55-0008......
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            index(sicuw.uwm100.cedpol,wdetail.cedpol) <> 0 NO-ERROR NO-WAIT.
        end...comment by Kridtiya i. A55-0008......*/
        /*add by Kridtiya i. A55-0008......*/
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol =  wdetail.cedpol  NO-LOCK NO-ERROR NO-WAIT.   /*end...add by Kridtiya i. A55-0008......*/
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ((sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ?) OR (sicuw.uwm100.releas = YES)) AND
                (sicuw.uwm100.poltyp =  wdetail.poltyp) THEN DO:  /*add kridtiya i..A55-0029*/
                IF sicuw.uwm100.expdat > date(wdetail.comdat) THEN
                    /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "  VIEW-AS ALERT-BOX.*/
                    ASSIGN wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| เลขที่สัญญานี้ได้ถูกใช้ไปแล้วในระบบ Premium "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            END.
        END.
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
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
IF wdetail.tiname = " " THEN wdetail.tiname = "คุณ".
ELSE DO:
    FIND FIRST brstat.msgcode WHERE 
        brstat.msgcode.compno  = "999" AND
        brstat.msgcode.MsgDesc = wdetail.tiname   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN  wdetail.tiname  =  trim(brstat.msgcode.branch).
    ELSE wdetail.tiname = "คุณ".
END.
/*
IF (wdetail.covcod = "1") AND (wdetail.name2 <> "" ) THEN 
    ASSIGN  wdetail.name2 = "และ/หรือ " + wdetail.name2 .
ELSE IF (wdetail.covcod = "2") AND (wdetail.name2 <> "" )  THEN 
    /*ASSIGN wdetail.name2 =  "และ/หรือ ธนาคาร เกียรตินาคิน จำกัด (มหาชน)" .*/   /*A63-00472*/
    ASSIGN wdetail.name2 =  "และ/หรือ ธนาคาร เกียรตินาคินภัทร จำกัด (มหาชน)" .   /*A63-00472*/
.*/

IF wdetail.prepol = "" THEN n_firstdat = wdetail.comdat.
/*Add A57-0015 
IF wdetail.icno = "" THEN  ASSIGN nv_insref = "". 
ELSE DO:
    IF LENGTH(TRIM(wdetail.icno)) = 13 THEN DO:
        ASSIGN nv_seq     = 1 
            nv_sum        = 0
            nv_checkdigit = 0.
        DO WHILE nv_seq <= 12:
            nv_sum = nv_sum + INTEGER(SUBSTR(wdetail.icno,nv_seq,1)) * (14 - nv_seq).
            nv_seq = nv_seq + 1.
        END.
        nv_checkdigit = 11 - nv_sum MODULO 11.
        IF nv_checkdigit >= 10 THEN nv_checkdigit = nv_checkdigit - 10.
        IF STRING(nv_checkdigit) <> SUBSTR(wdetail.icno,13,1) THEN DO:
            ASSIGN wdetail.icno = ""
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| เลขบัตรประชาชนไม่ถูกต้อง"
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.
    END.
END.  */  /* A58-0015 */
IF      trim(wdetail.branch) = ""  THEN ASSIGN nv_insref = "".  /*Add kridtiya i. A55-0268 ....*/
ELSE IF trim(wdetail.branch) = "A" THEN ASSIGN nv_insref = "".  /*Add kridtiya i. A55-0268 ....*/
ELSE IF trim(wdetail.branch) = "B" THEN ASSIGN nv_insref = "".  /*Add kridtiya i. A55-0268 ....*/
ELSE RUN proc_insnam.
RUN proc_insnam.  /* A57-0015 */
RUN proc_insnam2 . /*Add by Kridtiya i. A63-0472*/
/*
IF R-INDEX(wdetail.tiname,".") <> 0 THEN 
    wdetail.tiname = SUBSTR(wdetail.tiname,R-INDEX(wdetail.tiname,".")).*/
DO TRANSACTION:
   ASSIGN
      /*wdetail.comdat =  SUBSTR(wdetail.comdat,1,6) + STRING(INTE(SUBSTR(wdetail.comdat,7,4)) - 543 )
      wdetail.expdat =  SUBSTR(wdetail.expdat,1,6) + STRING(INTE(SUBSTR(wdetail.expdat,7,4)) - 543 )*/
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = wdetail.poltyp
      /*sic_bran.uwm100.insref = ""*/
      sic_bran.uwm100.insref = nv_insref   /*A58-0015*/
      sic_bran.uwm100.opnpol = ""
      sic_bran.uwm100.anam2  = wdetail.Icno       /* ICNO  Cover Note A51-0071 Amparat */
      sic_bran.uwm100.ntitle = wdetail.tiname     /*"คุณ" */ /*kridtiya i. A54-0203    */           
      sic_bran.uwm100.name1  = TRIM(wdetail.insnam)  
      sic_bran.uwm100.name2  = trim(wdetail.cedpol)
      sic_bran.uwm100.name3  = ""                 
      sic_bran.uwm100.addr1  = wdetail.iadd1  
      sic_bran.uwm100.addr2  = wdetail.iadd2  
      sic_bran.uwm100.addr3  = wdetail.iadd3  
      sic_bran.uwm100.addr4  = wdetail.iadd4
      sic_bran.uwm100.postcd =  "" 
      sic_bran.uwm100.undyr  = String(Year(today),"9999")   /*   nv_undyr  */
      sic_bran.uwm100.branch = wdetail.branch                  /* nv_branch  */                        
      sic_bran.uwm100.dept   = nv_dept
      sic_bran.uwm100.usrid  = USERID(LDBNAME(1))
      sic_bran.uwm100.fstdat = date(n_firstdat)         
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
      sic_bran.uwm100.prog   = "wgwkkren"
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
      sic_bran.uwm100.acno1  = fi_producer  /*  nv_acno1 */
      sic_bran.uwm100.agent  = fi_agent     /*nv_agent   */
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
      sic_bran.uwm100.drn_p =  NO
      sic_bran.uwm100.sch_p =  NO
      sic_bran.uwm100.cr_2  =  ""
      sic_bran.uwm100.bchyr   = nv_batchyr          
      sic_bran.uwm100.bchno   = nv_batchno          
      sic_bran.uwm100.bchcnt  = nv_batcnt           
      sic_bran.uwm100.prvpol  = wdetail.prepol     
      /*sic_bran.uwm100.cedpol  = wdetail.cedpol*/ /*A61-0335*/
      sic_bran.uwm100.cedpol  = trim(wdetail.kkapp) 
      sic_bran.uwm100.finint  = ""
      sic_bran.uwm100.bs_cd   = " "      /*vat code */
      sic_bran.uwm100.occup      = TRIM(wdetail.occup)  /*a60-0232*/
      sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)      /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)       /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.postcd     = trim(wdetail.postcd)         /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.icno       = trim(wdetail.icno)           /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)        /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)      /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)      /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)      /*Add by Kridtiya i. A63-0472*/
      /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)     /*Add by Kridtiya i. A63-0472*/*/
      sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov)    /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.dealer     = trim(wdetail.financecd)      /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.finint     = trim(wdetail.dealercd) .      /*Add by Kridtiya i. A63-0472*/ 
   IF wdetail.prepol <> " " THEN DO:
          IF wdetail.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = ""
                                                  sic_bran.uwm100.tranty  = "R".  
          ELSE 
              ASSIGN
                  sic_bran.uwm100.prvpol  = wdetail.prepol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                  sic_bran.uwm100.tranty  = "R".               /*Transaction Type (N/R/E/C/T)*/
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
END.  /*transaction*/
/*RUN proc_uwd100. */  
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
            sic_bran.uwm120.class  = wdetail.prempa  + wdetail.subclass
            s_recid2     = RECID(sic_bran.uwm120).
    END. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_redbook72 C-Win 
PROCEDURE proc_redbook72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_classmat  AS CHAR INIT "".
DEF VAR nv_modelmat  AS CHAR INIT "".

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
            ASSIGN wdetail.body    = IF wdetail.subclass = "110" THEN  "SEDAN  " ELSE "PICKUP" . 
    END.
END.
ELSE DO:
    FIND LAST sicsyac.xmm102 WHERE 
        sicsyac.xmm102.moddes  = wdetail.brand NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm102  THEN DO:
        ASSIGN  wdetail.comment = wdetail.comment + "| not find on table xmm102".
    END.
    ELSE DO:
        ASSIGN 
            wdetail.redbook = sicsyac.xmm102.modcod.
    END.
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
FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail.prepol   No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF sicuw.uwm100.renpol <> " " THEN DO:
        MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
        ASSIGN  wdetail.prepol = "Already Renew" /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
            wdetail.comment    = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
            wdetail.OK_GEN     = "N"
            wdetail.pass       = "N"
            n_prmtxt           = "" .    /* A55-0114 */ 
    END.
    ELSE DO: 
        ASSIGN  
            wdetail.prepol = sicuw.uwm100.policy
            n_rencnt       = sicuw.uwm100.rencnt  +  1
            n_endcnt       = 0
            wdetail.pass   = "Y".

        ASSIGN fi_show = "Import data Expiry ......".
        DISP fi_show WITH FRAM fr_main.
        RUN proc_assignrenew.      /*รับค่า ความคุ้มครองของเก่า */
    END.
END.        /*  avail  uwm100  */
ELSE DO:
    ASSIGN
        n_rencnt        = 0  
        n_Endcnt        = 0
        wdetail.prepol  = ""
        n_prmtxt        = ""  
        wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".
    /*FIND FIRST brstat.tlt USE-INDEX tlt06 WHERE
        brstat.tlt.cha_no  = wdetail.chasno NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.tlt THEN DO:
        ASSIGN 
            wdetail.seat = "7" .
    END.*/
END.   /*not  avail uwm100*/
/*IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".*/
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
/*nv_row  =  1.*/
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
        "Redbook    "   ","
        "policy     "   ","      
        "stk        "   ","              
        "poltyp     "   ","         
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
        "seat       "   ","            
        "body       "   ","            
        "brand      "   ","            
        "model      "   ","            
        "cc         "   ","            
        "weight     "   ","            
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
        "drivnam    "   ","        
        "drivnam1   "   ","        
        "drivbir1   "   ","        
        "drivbir2   "   ","        
        "drivage1   "   ","        
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
            wdetail.policy      ","
            wdetail.stk         "," 
            wdetail.poltyp      ","
            wdetail.entdat      ","
            wdetail.enttim      ","
            wdetail.trandat     ","
            wdetail.trantim     ","
            wdetail.prepol      ","
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
            wdetail.seat        ","  
            wdetail.body        ","  
            wdetail.brand       ","  
            wdetail.model       ","  
            wdetail.cc          ","  
            wdetail.weight      "," 
            wdetail.vehreg      ","  
            wdetail.engno       "," 
            wdetail.chasno      ","               
            wdetail.caryear     ","  
            wdetail.vehuse      ","               
            wdetail.garage      ","               
            wdetail.covcod      "," 
            wdetail.si          "," 
            wdetail.volprem     "," 
            wdetail.fleet       "," 
            wdetail.ncb         "," 
            wdetail.access      "," 
            wdetail.deductpp    "," 
            wdetail.deductba    "," 
            wdetail.deductpa    "," 
            wdetail.benname     "," 
            wdetail.n_IMPORT    "," 
            wdetail.n_export    "," 
            wdetail.drivnam     "," 
            wdetail.drivnam1    "," 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT2 C-Win 
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
            "branch   "      "," 
            "redbook   "     ","
            "policy   "      ","
            "entdat   "      ","     
            "enttim   "      ","     
            "trandat  "      ","     
            "trantim  "      ","     
            "poltyp   "      "," 
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
            "seat     "      ","     
            "body     "      ","     
            "brand    "      ","    
            "model    "      ","    
            "cc       "      ","     
            "weight   "      ","     
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
            "drivnam  "      ","     
            "drivnam1 "      ","     
            "drivbir1 "      ","     
            "drivbir2 "      ","     
            "drivage1 "      ","     
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
            "base      "     ","    
            "accdat    "     ","    
            "docno     "     ","    
            "ICNO      "     ","    
            "CoverNote "    
            
        SKIP.        
    FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
        wdetail.comment      ","
        wdetail.branch       ","
        wdetail.redbook      ","
        wdetail.policy       ","
        wdetail.entdat       ","
        wdetail.enttim       ","
        wdetail.trandat      ","
        wdetail.trantim      ","
        wdetail.poltyp       ","
        wdetail.prepol       ","
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
        wdetail.seat         ","  
        wdetail.body         ","        
        wdetail.brand        ","  
        wdetail.model        ","  
        wdetail.cc           ","  
        wdetail.weight       ","  
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
        wdetail.fleet        "," 
        wdetail.ncb          "," 
        wdetail.access       "," 
        wdetail.deductpp     "," 
        wdetail.deductba     "," 
        wdetail.deductpa     "," 
        wdetail.benname      "," 
        wdetail.n_IMPORT     "," 
        wdetail.n_export     "," 
        wdetail.drivnam      "," 
        wdetail.drivnam1     "," 
        wdetail.cancel       ","
        wdetail.WARNING      ","
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
        wdetail.premt        ","   
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen C-Win 
PROCEDURE proc_screen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM ns3 TO value(fi_output3).
PUT STREAM NS3   
"IMPORT TEXT FILE TAS " SKIP
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
    /*CONNECT expiry -H devserver -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/  
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
    nv_txt1  = "" /*"ขยายอุปกรณ์ตกแต่งเพิ่มเติมไม่เกิน 20,000.00 บาท"*/
    /*nv_txt2  = "วันที่แจ้งงาน : " + wdetail.revday */ /* A65-0288*/
    /* Add by : A65-0288 */
     /*nv_txt1  = "Inspection :" + wdetail.insp  17/11/2022*/
     nv_txt1  = IF TRIM(wdetail.insp) = "Y" THEN " เลขตรวจสภาพ : " + trim(wdetail.inspno) + " " + trim(wdetail.inspdetail) ELSE "" 
     nv_txt2  = IF wdetail.inspDamg <> "" THEN "รายการความเสียหาย : " +   TRIM(wdetail.inspDamg) ELSE "" 
     nv_txt3  = IF wdetail.inspAcc  <> "" THEN "อุปกรณ์เสริม : " + TRIM(wdetail.inspAcc) ELSE "" . 
    /* end A65-0288 */
   /* comment by : A65-0288 ..
    nv_txt3  = ""
    nv_txt4  = ""
    nv_txt5  = "" .
    ..end A65-0288...*/ 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 C-Win 
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
       nv_line1 = 1
       fi_show = "Create Memo Text....."  .
DISP fi_show WITH FRAM fr_main.
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
/*DO WHILE nv_line1 <= 6:*/
DO WHILE nv_line1 <= 15: /*A60-0232*/
    CREATE wuppertxt3.
    wuppertxt3.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt3.txt = "วันที่แจ้งงาน :" + wdetail.revday + " เลขที่สัญญาเช่าซื้อ : " + TRIM(wdetail.cedpol) + " ชื่อเจ้าหน้าที่ MKT: " + trim(wdetail.namenotify) .
    IF nv_line1 = 2  THEN wuppertxt3.txt = wdetail.nmember .
    IF nv_line1 = 3  THEN wuppertxt3.txt = "หมายเหตุ : "  + wdetail.benname . 
    IF nv_line1 = 4  THEN wuppertxt3.txt = "Remak1 : "    + wdetail.remak1 . 
    IF nv_line1 = 5  THEN wuppertxt3.txt = "Remak2 : "    + wdetail.remak2 . 
    IF nv_line1 = 6  THEN wuppertxt3.txt = "เบอร์ติดต่อ : " + wdetail.phone  + "  " + "เลขประจำตัวผู้เสียภาษี : " + wdetail.tax.       
    IF nv_line1 = 7  THEN wuppertxt3.txt = "วันเดือนปีเกิด : " + wdetail.bdate .                                                       
    IF nv_line1 = 8  THEN wuppertxt3.txt = "อาชีพ : " + wdetail.occup + "  " + "สถานภาพ : " + wdetail.cstatus.                         
    IF nv_line1 = 9  THEN wuppertxt3.txt = "ชื่อกรรมการ 1 : " + wdetail.tname1 + " " + wdetail.cname1 + " " + wdetail.lname1 + " " +   
                                           "ICNO1 :" + wdetail.icno1.                                                                  
    IF nv_line1 = 10 THEN wuppertxt3.txt = "ชื่อกรรมการ 2 : " + wdetail.tname2 + " " + wdetail.cname2 + " " + wdetail.lname2 + " " +   
                                           "ICNO2 :" + wdetail.icno2.                                                                  
    IF nv_line1 = 11 THEN wuppertxt3.txt = "ชื่อกรรมการ 3 : " + wdetail.tname3 + " " + wdetail.cname3 + " " + wdetail.lname3 + " " +   
                                           "ICNO3 :" + wdetail.icno3.                                                            
    IF nv_line1 = 12 THEN wuppertxt3.txt = "จัดส่งเอกสารที่สาขา: " + wdetail.nsend + " ชื่อผู้รับเอกสาร: " + wdetail.sendname .  
    IF nv_line1 = 13 THEN wuppertxt3.txt = "เลขรับแจ้ง : " + wdetail.notifyno + " KK Quotation No." + wdetail.KKQuo .
    
    /* add by : A65-0288 */
    IF nv_line1 = 14 THEN wuppertxt3.txt = "Note Problem : " + trim(wdetail.problem) . /*Note Un Problem 17/11/2022 */

    FIND LAST wexcamp WHERE wexcamp.policy    = TRIM(wdetail.policy) AND
                            wexcamp.campaign  = TRIM(wdetail.product) AND
                            wexcamp.polmaster <> "" NO-LOCK NO-ERROR .
    IF AVAIL wexcamp THEN DO:
        IF nv_line1 = 15 THEN wuppertxt3.txt = "Campaign : " + wexcamp.campaign + " Policy master : " + wexcamp.polmaster . 
    END.
    ELSE IF wdetail.product <> "" THEN DO:
        IF nv_line1 = 15 THEN wuppertxt3.txt = "Campaign : " + wdetail.product + " Policy master : " + 
                              IF index(wdetail.comment,"ไม่พบ Policy Master") <> 0 THEN "ไม่พบ Policy Master ตามรายละเอียดของไฟล์โหลดในแคมเปญ " ELSE ""  . 
    END.
    /* end : A65-0288 */

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

