&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_bran         PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
/* Connected Databases : sic_test         PROGRESS                                         */
File:     Description:                                                                               
Input Parameters:  <none>                                                                                     
Output Parameters: <none>                                                                                     
Author:                                                                         
Created:              
------------------------------------------------------------------------                   */
/*          This .W file was created with the Progress AppBuilder.                         */
/*----------------------------------------------------------------------                   */
/* Create an unnamed pool to store all the widgets created                                 
by this procedure. This is a good default which assures                                    
that this procedure's triggers and internal procedures                                     
will execute in this procedure's storage, and that proper                                  
cleanup will occur on deletion of the procedure.                                           */
CREATE WIDGET-POOL.                                                                        
/*******************************************************************************************/                                      
/*programid   : wgwkbgen.w                                                                 */ 
/*programname : load text file Ktb to GW                                                   */ 
/* Copyright  : Safety Insurance Public Company Limited บริษัท ประกันคุ้มภัย จำกัด (มหาชน) */ 
/*create by   : Kridtiya i. A55-0128 date 05/04/2012.                                      */ 
/*              เพิ่มโปรแกรมนำเข้างานบริษัท กรุงไทยธุรกิจลีสซิ่ง จำกัด                     */ 
/*modify by   : Kridtiya i. A55-0163 ปรับตำแหน่งการแสดงที่อยู่ช่องว่างหนึ่งตัวอักษร        */
/*modify by   : Kridtiya i. 21/09/2012 A55-0301 add icno ,birthday occup                   */ 
/*modify by   : Kridtiya i. A55-0301 เพิ่มข้อมูลผู้เอาประกันภัย                            */
/*modify by   : Kridtiya i. A55-0268 เพิ่มข้อมูลผู้เอาประกันภัย insurce="" not create xmm600*/
/*modify by   : Kridtiya i. A55-0340 คืนค่า table xmm600                                   */
/*modify by   : Kridtiya i. A56-0081 ปรับแก้ไขการให้ค่าเลขทะเบียนใหม่  */
/*modify by   : Kridtiya i. A56-0118 ปรับแก้ไขการให้ค่าเลขcampaign จากพารามิเตอร์          */
/*modify by   : Kridtiya i. A56-0310 อร์โค๊ต */
/*Modify by   : Kridtiya i. A56-0047  Add check sicsyac.xmm600.clicod   = "IN"             */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/* ***************************  Definitions  ***********************************************/
/* Parameters Definitions ---                                                              */
/* Local Variable Definitions ---                                                          */  
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.  
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno.  
DEFINE STREAM  ns1.                   
DEFINE STREAM  ns2.                   
DEFINE STREAM  ns3. 
DEF VAR aa          AS DECI.
DEF VAR n_prem      AS DECI.
DEF VAR nv_uom1_v   AS INTE INIT 0.     
DEF VAR nv_uom2_v   AS INTE INIT 0.     
DEF VAR nv_uom5_v   AS INTE INIT 0.
DEF VAR dod0        AS DECI.
DEF VAR dod1        AS DECI.
DEF VAR dod2        AS DECI.
DEF VAR dpd0        AS DECI.
DEF SHARED Var n_User    As CHAR . 
DEF VAR nv_comper   AS DECI INIT 0.                 
DEF VAR nv_comacc   AS DECI INIT 0.                 
DEF VAR nv_modcod   AS CHAR FORMAT "x(8)" INIT "" .  
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
DEF NEW  SHARED VAR   nv_engine   LIKE sicsyac.xmm102.engine.       
DEF NEW  SHARED VAR   nv_tons     LIKE sicsyac.xmm102.tons.         
DEF NEW  SHARED VAR   nv_seats    LIKE sicsyac.xmm102.seats.        
DEF NEW  SHARED VAR   nv_sclass   AS CHAR FORMAT "x(3)".            
DEF NEW  SHARED VAR   nv_engcod   AS CHAR FORMAT "x(4)".            
DEF NEW  SHARED VAR   nv_engprm   AS DECI  FORMAT ">>,>>>,>>9.99-". 
DEF NEW  SHARED VAR   nv_engvar1  AS CHAR  FORMAT "X(30)".          
DEF NEW  SHARED VAR   nv_engvar2  AS CHAR  FORMAT "X(30)".          
DEF NEW  SHARED VAR   nv_engvar   AS CHAR  FORMAT "X(60)".          
DEF VAR  NO_CLASS AS CHAR INIT "".                              
DEF VAR  no_tariff AS CHAR INIT "".
def New  shared var  nv_poltyp   as   char   init  "".
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
DEF NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".   /*amparat c. a51-0253*/
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
{wgw\wgwkbgen.i}      /*ประกาศตัวแปร*/
/* DEFINE VAR nv_txt1    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO. */
/* DEFINE VAR nv_txt2    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO. */
/* DEFINE VAR nv_txt3    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO. */
/* DEFINE VAR nv_txt4    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO. */
/* DEFINE VAR nv_txt5    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO. */
/* DEFINE VAR nv_txt6    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO. */
/* DEFINE VAR nv_txt7    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO. */
/* DEFINE VAR nv_txt8    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO. */
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.             
DEF VAR nv_nptr     AS RECID.                                                
DEF VAR nc_r2    AS CHAR FORMAT "x(20)" INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_cam

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wcam wdetail

/* Definitions for BROWSE br_cam                                        */
&Scoped-define FIELDS-IN-QUERY-br_cam wcam.campan wcam.cover wcam.brand   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_cam   
&Scoped-define SELF-NAME br_cam
&Scoped-define QUERY-STRING-br_cam FOR EACH wcam
&Scoped-define OPEN-QUERY-br_cam OPEN QUERY br_cam FOR EACH wcam.
&Scoped-define TABLES-IN-QUERY-br_cam wcam
&Scoped-define FIRST-TABLE-IN-QUERY-br_cam wcam


/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.poltyp wdetail.policy wdetail.producer wdetail.agent wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.iadd1 wdetail.iadd2 wdetail.iadd3 wdetail.iadd4 wdetail.prempa wdetail.subclass wdetail.redbook wdetail.brand wdetail.model wdetail.cc wdetail.weight wdetail.seat wdetail.body wdetail.vehreg wdetail.engno wdetail.chasno wdetail.caryear wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.volprem wdetail.fleet wdetail.ncb wdetail.access wdetail.benname wdetail.n_IMPORT wdetail.n_export WDETAIL.WARNING wdetail.cancel wdetail.prepol wdetail.comment   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail     .     /* WHERE wdetail2.policyno = wdetail.policyno.*/.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_branch fi_producer ~
fi_producer2 fi_agent bu_vatcode fi_product fi_prevbat fi_bchyr fi_filename ~
bu_file fi_output1 fi_output2 fi_output3 buok bu_exit br_wdetail bu_hpbrn ~
bu_hpacno1 bu_hpagent bu_hpacno2 fi_outputex fi_campaign1 br_cam fi_brcam ~
bu_add bu_clr bu_del fi_brand fi_model fi_vatcode bu_okex fi_camname ~
RECT-368 RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 RECT-377 RECT-378 ~
RECT-381 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_branch fi_producer ~
fi_producer2 fi_bchno fi_agent fi_product fi_prevbat fi_bchyr fi_filename ~
fi_output1 fi_output2 fi_output3 fi_brndes fi_proname fi_agtname ~
fi_proname2 fi_impcnt fi_show fi_outputex fi_campaign1 fi_completecnt ~
fi_premtot fi_brcam fi_premsuc fi_brand fi_model fi_vatcode fi_vatname ~
fi_camname 

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
     SIZE 13 BY 1.14
     FONT 6.

DEFINE BUTTON bu_add 
     LABEL "ADD" 
     SIZE 5 BY 1.

DEFINE BUTTON bu_clr 
     LABEL "CLR" 
     SIZE 5 BY 1.

DEFINE BUTTON bu_del 
     LABEL "DEL" 
     SIZE 5 BY 1.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 13 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4.83 BY .95.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpacno2 
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

DEFINE BUTTON bu_okex 
     LABEL "OK" 
     SIZE 6 BY .95
     FGCOLOR 2 .

DEFINE BUTTON bu_vatcode 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(19)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brcam AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_campaign1 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outputex AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58.33 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(18)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_product AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_proname2 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_show AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 68 BY 1
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_vatname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-368
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 92 BY 1.29
     BGCOLOR 18 FGCOLOR 1 .

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132 BY 1.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132 BY 14.43
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132 BY 4.71
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132 BY 3
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 119 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17 BY 2
     BGCOLOR 6 FGCOLOR 1 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 92 BY 1.52
     BGCOLOR 4 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_cam FOR 
      wcam SCROLLING.

DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_cam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_cam C-Win _FREEFORM
  QUERY br_cam DISPLAY
      wcam.campan  COLUMN-LABEL "Campaign" FORMAT "x(9)"
      wcam.cover   COLUMN-LABEL "Cov"      FORMAT "x(3)"
      wcam.brand   COLUMN-LABEL "Brand"    FORMAT "x(25)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 31 BY 4.57
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .57.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail C-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.poltyp   COLUMN-LABEL "Policy Type"
      wdetail.policy   COLUMN-LABEL "Policy"
      wdetail.producer COLUMN-LABEL "Producer"
      wdetail.agent    COLUMN-LABEL "Agent"
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
      wdetail.redbook  COLUMN-LABEL "RedBook"
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
      wdetail.fleet    COLUMN-LABEL "Fleet"
      wdetail.ncb      COLUMN-LABEL "NCB"
      wdetail.access   COLUMN-LABEL "Load Claim"
      wdetail.benname  COLUMN-LABEL "Benefit Name" 
      wdetail.n_IMPORT COLUMN-LABEL "Import"
      wdetail.n_export COLUMN-LABEL "Export"
      WDETAIL.WARNING  COLUMN-LABEL "Warning"
      wdetail.cancel   COLUMN-LABEL "Cancel"
      wdetail.prepol   COLUMN-LABEL "Renew Policy"
      wdetail.comment  FORMAT "x(50)" COLUMN-BGCOLOR  80
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.67 BY 4.29
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 2.67 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.67 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.67 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_producer2 AT ROW 5.67 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.81 COL 17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agent AT ROW 6.67 COL 25.67 COLON-ALIGNED NO-LABEL
     bu_vatcode AT ROW 7.67 COL 42.5
     fi_product AT ROW 2.67 COL 57 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 8.71 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 8.71 COL 59.17 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.71 COL 25.67 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9.71 COL 86.5
     fi_output1 AT ROW 10.71 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.71 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.71 COL 25.67 COLON-ALIGNED NO-LABEL
     buok AT ROW 10.33 COL 111.5
     bu_exit AT ROW 12.48 COL 111.33
     fi_brndes AT ROW 3.67 COL 37 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 17.19 COL 1.83
     bu_hpbrn AT ROW 3.67 COL 34.5
     bu_hpacno1 AT ROW 4.67 COL 42.5
     bu_hpagent AT ROW 6.67 COL 42.5
     fi_proname AT ROW 4.67 COL 45 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6.67 COL 45 COLON-ALIGNED NO-LABEL
     bu_hpacno2 AT ROW 5.67 COL 42.5
     fi_proname2 AT ROW 5.67 COL 45 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 22.24 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_show AT ROW 15.38 COL 26.33 NO-LABEL
     fi_outputex AT ROW 13.95 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_campaign1 AT ROW 2.67 COL 111.5 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.24 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.24 COL 98.17 NO-LABEL NO-TAB-STOP 
     br_cam AT ROW 4.91 COL 95.17
     fi_brcam AT ROW 3.81 COL 105.5 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 5 COL 126.67
     fi_premsuc AT ROW 23.29 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_clr AT ROW 6.43 COL 126.67
     bu_del AT ROW 7.71 COL 126.67
     fi_brand AT ROW 3.81 COL 117.33 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 3.67 COL 75.83 COLON-ALIGNED NO-LABEL
     fi_vatcode AT ROW 7.67 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_vatname AT ROW 7.67 COL 45 COLON-ALIGNED NO-LABEL
     bu_okex AT ROW 14 COL 87.17
     fi_camname AT ROW 2.67 COL 87.17 COLON-ALIGNED NO-LABEL
     "Branch  :" VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 3.67 COL 17.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 12.71 COL 8.83
          BGCOLOR 8 FGCOLOR 1 
     "    IMPORT TEXT FILE KTB[บริษัทกรุงไทยธุรกิจลีสซิ่ง]" VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.24 COL 2
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Brand:" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 3.81 COL 113
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 8.71 COL 59.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 22.24 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 10.71 COL 7.67
          BGCOLOR 8 FGCOLOR 1 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 23.24 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Cov:" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 3.81 COL 102.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Out put Policy file ex :" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 13.95 COL 4.17
          BGCOLOR 8 FGCOLOR 1 
     "Cam_Name:" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 2.67 COL 76.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 23.24 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.81 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 11.71 COL 3.67
          BGCOLOR 8 FGCOLOR 1 
     "Previous Batch No.:" VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 8.71 COL 6.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Agent Code  :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 6.67 COL 13
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 22.24 COL 116.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Campaign :" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 2.67 COL 102.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Producer[UseCar]:" VIEW-AS TEXT
          SIZE 18 BY .95 AT ROW 5.67 COL 8.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "   Vat Code  :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 7.67 COL 13
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer[NewCar]:" VIEW-AS TEXT
          SIZE 18 BY .95 AT ROW 4.67 COL 8.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Load Date :":35 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 2.67 COL 16
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Model :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 3.67 COL 70.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.24 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 9.71 COL 4.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Product Type :" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 2.67 COL 44.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 23.24 COL 116.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-368 AT ROW 15.29 COL 3.33
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.52 COL 1
     RECT-373 AT ROW 16.95 COL 1
     RECT-374 AT ROW 21.67 COL 1
     RECT-376 AT ROW 22 COL 3.33
     RECT-377 AT ROW 9.91 COL 109.5
     RECT-378 AT ROW 11.95 COL 109.5
     RECT-381 AT ROW 13.71 COL 3.33
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
         TITLE              = "IMPORT TEXT FILE KTB[บริษัทกรุงไทยธุรกิจลีสซิ่ง]"
         HEIGHT             = 23.95
         WIDTH              = 132.83
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
/* BROWSE-TAB br_cam fi_premtot fr_main */
ASSIGN 
       br_cam:SEPARATOR-FGCOLOR IN FRAME fr_main      = 15.

ASSIGN 
       br_wdetail:COLUMN-RESIZABLE IN FRAME fr_main       = TRUE.

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
/* SETTINGS FOR FILL-IN fi_proname2 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_show IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_vatname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.83 BY .95 AT ROW 8.71 COL 59.33 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.24 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 22.24 COL 95.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 23.24 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 23.24 COL 96 RIGHT-ALIGNED          */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_cam
/* Query rebuild information for BROWSE br_cam
     _START_FREEFORM
OPEN QUERY br_cam FOR EACH wcam.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_cam */
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

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* IMPORT TEXT FILE KTB[บริษัทกรุงไทยธุรกิจลีสซิ่ง] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* IMPORT TEXT FILE KTB[บริษัทกรุงไทยธุรกิจลีสซิ่ง] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_cam
&Scoped-define SELF-NAME br_cam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_cam C-Win
ON ROW-DISPLAY OF br_cam IN FRAME fr_main
DO:
  
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    wcam.campan:BGCOLOR IN BROWSE BR_cam = z NO-ERROR.  
    wcam.cover:BGCOLOR IN BROWSE BR_cam = z NO-ERROR.
    wcam.brand:BGCOLOR IN BROWSE BR_cam = z NO-ERROR.

    wcam.campan:FGCOLOR IN BROWSE BR_cam = s NO-ERROR.  
    wcam.cover:FGCOLOR IN BROWSE BR_cam = s NO-ERROR.
    wcam.brand:FGCOLOR IN BROWSE BR_cam = s NO-ERROR.
          
  
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
          wdetail.poltyp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.producer:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.agent:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
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
          wdetail.covcod :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
          wdetail.si:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.volprem:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.     
          wdetail.fleet:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.ncb:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.access:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.benname :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.n_IMPORT:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_export:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.cancel:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.prepol:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.comment:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   


          
          wdetail.poltyp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.producer:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.agent:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.tiname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.insnam:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.    
          wdetail.expdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
          wdetail.compul:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.iadd3:FGCOLOR IN BROWSE BR_WDETAIL = s  NO-ERROR.  
          wdetail.iadd4:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
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
          wdetail.benname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_IMPORT:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_export:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          WDETAIL.WARNING:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.cancel:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.prepol:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comment:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.   
                                
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
        FIND LAST uzm700 USE-INDEX uzm70001    WHERE
            uzm700.bchyr   = nv_batchyr        AND
            uzm700.branch  = TRIM(nv_batbrn)   AND
            uzm700.acno    = TRIM(fi_producer) NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:   
            nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102 
                WHERE uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") NO-LOCK NO-ERROR.
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
            WHERE uzm701.bchyr =  nv_batchyr        AND
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
    RUN proc_assign. 
    RUN proc_assign2.
    RUN proc_assign3.
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
    FOR EACH wdetail :    
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
                           INPUT            "WGWKKREN" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem       /* DECI  */
                           ).
    ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.
    RUN proc_chktest1.
    FOR EACH wdetail WHERE wdetail.pass = "y"  NO-LOCK:
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
    ELSE nv_batflg = YES.
    FIND LAST uzm701 USE-INDEX uzm70102  
        WHERE uzm701.bchyr  = nv_batchyr  AND
        uzm701.bchcnt       = nv_batcnt   AND
        uzm701.bchno        = nv_batchno  NO-ERROR.
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
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.
    RELEASE sicsyac.xtm600.  /*Add A55-0340 */
    RELEASE sicsyac.xmm600.  /*Add A55-0340 */
    RELEASE sicsyac.xzm056.  /*Add A55-0340 */
    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    /*output*/
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .  
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    ASSIGN fi_product   = "PA1".
    DISP fi_product   WITH FRAM fr_main.
    
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add C-Win
ON CHOOSE OF bu_add IN FRAME fr_main /* ADD */
DO:
    IF fi_campaign1 = "" THEN DO:
        APPLY "ENTRY" TO fi_campaign1 IN FRAME fr_main.
        disp  fi_campaign1  with frame  fr_main.
    END.
    ELSE DO:
        FIND LAST WCAM WHERE wcam.campan = fi_campaign1 NO-ERROR NO-WAIT.
        IF NOT AVAIL wcam THEN DO:
            CREATE wcam.
            ASSIGN wcam.campan  = trim(fi_campaign1)
                   wcam.cover   = trim(fi_brcam) 
                   wcam.brand   = trim(fi_brand)
                   fi_campaign1 = "" 
                   fi_brcam     = "" 
                   fi_brand     = "" .
        END.
    END.
    OPEN QUERY br_cam FOR EACH wcam.
    APPLY "ENTRY" TO fi_campaign1 IN FRAME fr_main.
    disp  fi_campaign1  fi_brcam fi_brand with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_clr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_clr C-Win
ON CHOOSE OF bu_clr IN FRAME fr_main /* CLR */
DO:
    ASSIGN 
        fi_campaign1 = ""
        fi_brcam     = "" 
        fi_brand = "" .
    OPEN QUERY br_cam FOR EACH wcam.
    APPLY "ENTRY" TO fi_campaign1 IN FRAME fr_main.
    disp  fi_campaign1  fi_brcam fi_brand with frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del C-Win
ON CHOOSE OF bu_del IN FRAME fr_main /* DEL */
DO:
   
    GET CURRENT br_cam EXCLUSIVE-LOCK.
        DELETE wcam.
    FIND LAST WCAM WHERE wcam.campan = fi_campaign1 NO-ERROR NO-WAIT.
        IF    AVAIL wcam THEN DELETE wcam.
        ELSE MESSAGE "Not found Campaign !!! in : " fi_campaign1 VIEW-AS ALERT-BOX.
    OPEN QUERY br_cam FOR EACH wcam.
    APPLY "ENTRY" TO fi_campaign1 IN FRAME fr_main.
    disp  fi_campaign1  fi_brcam with frame  fr_main.
    

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


&Scoped-define SELF-NAME bu_hpacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno2 C-Win
ON CHOOSE OF bu_hpacno2 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno, /*a490166 note modi*/ /*28/11/2006*/
                    output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer2 =  n_acno.
     
     disp  fi_producer2  with frame  fr_main.

     Apply "Entry"  to  fi_producer2.
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


&Scoped-define SELF-NAME bu_okex
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_okex C-Win
ON CHOOSE OF bu_okex IN FRAME fr_main /* OK */
DO: 
    IF fi_outputex = ""  THEN DO:
        MESSAGE "Plese Input File Data Export Policy...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_outputex.
        RETURN NO-APPLY.
    END.
    For each  wdetail2 :
        DELETE  wdetail2.
    END.
    RUN proc_assign. 
    RUN proc_assign2.
    Run  Pro_createfile.
    Message "Export data Complete"  View-as alert-box.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_vatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_vatcode C-Win
ON CHOOSE OF bu_vatcode IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,   /*a490166 note modi*/
                    output  n_agent). 
                                          
     If  n_acno  <>  ""  Then  fi_vatcode =  n_acno.
     
     disp  fi_vatcode  with frame  fr_main.

     Apply "Entry"  to  fi_vatcode.
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
            fi_agent   =  caps(INPUT  fi_agent)    /*note modi 08/11/05*/
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


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
   fi_brand  =  CAPS(INPUT fi_brand) .
    DISP fi_brand  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brcam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brcam C-Win
ON LEAVE OF fi_brcam IN FRAME fr_main
DO:
    fi_brcam  =  CAPS(Input fi_brcam) .
    Disp fi_brcam  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camname C-Win
ON LEAVE OF fi_camname IN FRAME fr_main
DO:
  fi_camname  =  Input  fi_camname.
  Disp  fi_camname  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campaign1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaign1 C-Win
ON LEAVE OF fi_campaign1 IN FRAME fr_main
DO:
  fi_campaign1  =  Input  fi_campaign1.
  Disp  fi_campaign1  with  frame  fr_main.
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


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model C-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
    fi_model = INPUT fi_model.
    Disp  fi_model    WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outputex
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outputex C-Win
ON LEAVE OF fi_outputex IN FRAME fr_main
DO:
  fi_outputex = INPUT fi_outputex.
  DISP fi_outputex WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_producer2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer2 C-Win
ON LEAVE OF fi_producer2 IN FRAME fr_main
DO:
    fi_producer2 = INPUT fi_producer2.
    IF  fi_producer2 <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_producer2  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_producer2.
            RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO:
            ASSIGN
                fi_proname2 =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer2 =  caps(INPUT  fi_producer2) /*note modi 08/11/05*/
                /*nv_producer = fi_producer2*/   .             /*note add  08/11/05*/
        END.
  END.

  Disp  fi_producer2  fi_proname2  WITH Frame  fr_main.   
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_product
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_product C-Win
ON LEAVE OF fi_product IN FRAME fr_main
DO:
    fi_product = INPUT fi_product.
    Disp  fi_product    WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcode C-Win
ON LEAVE OF fi_vatcode IN FRAME fr_main
DO:
    fi_vatcode = caps(INPUT fi_vatcode).
    IF fi_vatcode <> ""    THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
         sicsyac.xmm600.acno  =  Input fi_vatcode  
    NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
             Message  "Not on Name & Address Master File xmm600" 
             View-as alert-box.
             Apply "Entry" To  fi_vatcode.
             RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO: /*note modi on 10/11/2005*/
            ASSIGN
            fi_vatname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
            fi_vatcode   =  caps(INPUT  fi_vatcode)    /*note modi 08/11/05*/
            /*nv_agent   =  fi_vatcode*/    .             /*note add  08/11/05*/
            
        END. /*end note 10/11/2005*/
    END. /*Then fi_vatcode <> ""*/
    
    Disp  fi_vatcode  fi_vatname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_cam
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
  gv_prgid = "WGWKBGEN".
  gv_prog  = "IMPORT TEXT FILE KTBL".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).    
  ASSIGN
      fi_branch    = "M"
      fi_camname   = "CAM_KTB"
      fi_producer2 = "A0M0100"
      fi_producer  = "A0M0099"
      fi_agent     = "A000000"
      fi_vatcode   = "MC24875"
      fi_bchyr     = YEAR(TODAY) 
      fi_model     = "MODEL_KTBL"
      fi_product   = "PA1"
      fi_show      = "IMPORT TEXT FILE KTB... ".
  RUN proc_createcam.
  OPEN QUERY br_cam FOR EACH wcam.
  disp  fi_campaign1  with frame  fr_main.
  DISP fi_camname fi_branch fi_producer fi_producer2 fi_agent fi_vatcode fi_bchyr fi_show  fi_product fi_model
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
  DISPLAY fi_loaddat fi_branch fi_producer fi_producer2 fi_bchno fi_agent 
          fi_product fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 
          fi_output3 fi_brndes fi_proname fi_agtname fi_proname2 fi_impcnt 
          fi_show fi_outputex fi_campaign1 fi_completecnt fi_premtot fi_brcam 
          fi_premsuc fi_brand fi_model fi_vatcode fi_vatname fi_camname 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loaddat fi_branch fi_producer fi_producer2 fi_agent bu_vatcode 
         fi_product fi_prevbat fi_bchyr fi_filename bu_file fi_output1 
         fi_output2 fi_output3 buok bu_exit br_wdetail bu_hpbrn bu_hpacno1 
         bu_hpagent bu_hpacno2 fi_outputex fi_campaign1 br_cam fi_brcam bu_add 
         bu_clr bu_del fi_brand fi_model fi_vatcode bu_okex fi_camname RECT-368 
         RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 RECT-377 RECT-378 
         RECT-381 
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
/************** v72 comp y **********/
ASSIGN
    wdetail.compul = "y"
    wdetail.tariff = "9" 
    wdetail.covcod = "T"
    nv_modcod      = " " . 
IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N". 
END.
IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk <> "" THEN DO:    
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN 
                wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
                wdetail.pass    = ""
                wdetail.OK_GEN  = "N".
    END.    
END.
IF wdetail.branch = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| branch เป็นค่าว่าง มีผลต่อการรับประกันภัย"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
/*add Kridtiya i. A56-0310 */
ELSE IF trim(wdetail.branch) = "4" THEN
    ASSIGN  
    wdetail.comment = wdetail.comment + "| พบงาน พรบ.branch 4 ไม่สามารถเจนตามระบบได้เนื่องจากซ้ำกับโบรกเกอร์"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
/*add Kridtiya i. A56-0310 */
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  
    xmm016.class =   wdetail.prempa + wdetail.subclass  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp  AND
        sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
            wdetail.OK_GEN  = "N".
END. 
/*---------- covcod ----------*/
wdetail.covcod = CAPS(wdetail.covcod).
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
        wdetail.OK_GEN  = "N".
IF      wdetail.subclass = "110" THEN DO: 
    ASSIGN wdetail.seat = "7".
    FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
        sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
        sicsyac.xmm106.class   = "110"            AND  sicsyac.xmm106.covcod  = wdetail.covcod  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmm106 THEN 
        ASSIGN  wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
        wdetail.OK_GEN = "N".
END.
ELSE IF wdetail.subclass = "320" THEN DO: 
    ASSIGN wdetail.seat = "3".
    FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
        sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
        sicsyac.xmm106.class   = "140A"            AND  sicsyac.xmm106.covcod  = wdetail.covcod  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmm106 THEN 
        ASSIGN  wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
        wdetail.OK_GEN = "N".
END.
ELSE IF wdetail.subclass = "210" THEN DO: 
    ASSIGN wdetail.seat = "12".
    FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
        sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
        sicsyac.xmm106.class   = "120A"            AND  sicsyac.xmm106.covcod  = wdetail.covcod  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmm106 THEN 
        ASSIGN  wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
        wdetail.OK_GEN = "N".
END.
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE 
        stat.maktab_fil.sclass = wdetail.subclass   AND 
        stat.maktab_fil.modcod = wdetail.redbook    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN nv_modcod        =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
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
            ELSE ASSIGN  nv_maxSI = nv_si
                nv_minSI = nv_si.
        END.   /***--- End Check Rate SI ---***/
    END.
    ELSE nv_modcod = " ".
END.    /*red book <> ""*/ 
IF nv_modcod = " " THEN DO:
    ASSIGN  n_model = ""
        n_model    = IF wdetail.model <> "" THEN SUBSTR(wdetail.model,1,INDEX(wdetail.model," ")) ELSE "".
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN nv_simat  = makdes31.si_theft_p   
        nv_simat1 = makdes31.load_p   .  
    ELSE ASSIGN nv_simat  = 0
        nv_simat1 = 0.
    Find LAST stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,n_model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.engine   =     Integer(wdetail.cc)      AND
        stat.maktab_fil.sclass   =     wdetail.subclass         AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        wdetail.redbook =  stat.maktab_fil.modcod
        nv_modcod       =  stat.maktab_fil.modcod                                    
        nv_moddes       =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        nv_modcod       =  stat.maktab_fil.modcod 
        wdetail.brand   =  stat.maktab_fil.makdes  
        wdetail.model   =  stat.maktab_fil.moddes
        wdetail.cargrp  =  stat.maktab_fil.prmpac
        wdetail.body    =  stat.maktab_fil.body 
        wdetail.cc       =  STRING(stat.maktab_fil.engine)
        wdetail.cargrp  =  stat.maktab_fil.prmpac
        wdetail.seat    =  string(stat.maktab_fil.seats) .
    IF nv_modcod = ""  THEN RUN proc_maktab.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 C-Win 
PROCEDURE proc_722 :
/* ---------------------------------------------  U W M 1 3 0 -------------- */
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp      AND             
    sic_bran.uwm130.riskno = s_riskno      AND            
    sic_bran.uwm130.itemno = s_itemno      AND            
    sic_bran.uwm130.bchyr  = nv_batchyr    AND           
    sic_bran.uwm130.bchno  = nv_batchno    AND           
    sic_bran.uwm130.bchcnt = nv_batcnt     NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno.
    ASSIGN     
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
        sic_bran.uwm301.cha_no  = wdetail.chasno
        sic_bran.uwm301.eng_no  = wdetail.eng
        sic_bran.uwm301.Tons    = INTEGER(wdetail.weight)
        sic_bran.uwm301.engine  = INTEGER(wdetail.cc)
        sic_bran.uwm301.yrmanu  = INTEGER(wdetail.caryear)
        sic_bran.uwm301.vehgrp  = wdetail.cargrp
        sic_bran.uwm301.garage  = ""
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
    ASSIGN 
    nv_maxsi = 0
    nv_minsi = 0
    nv_si    = 0
    nv_maxdes = ""
    nv_mindes = ""
    /*chkred = NO*/
    n_model = "". 
IF      wdetail.subclass = "110" THEN wdetail.seat = "7".
ELSE IF wdetail.subclass = "320" THEN wdetail.seat = "3".
ELSE IF wdetail.subclass = "210" THEN wdetail.seat = "12".
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE 
        stat.maktab_fil.sclass = wdetail.prempa + wdetail.subclass   AND 
        stat.maktab_fil.modcod = wdetail.redbook    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  
            sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
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
                stat.makdes31.moddes = substr(wdetail.subclass,1,3)   NO-LOCK NO-ERROR NO-WAIT.
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
    ASSIGN n_model = ""
        n_model    = IF wdetail.model <> "" THEN SUBSTR(wdetail.model,1,INDEX(wdetail.model," ")) ELSE "".
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN nv_simat  = makdes31.si_theft_p   
               nv_simat1 = makdes31.load_p   .    
    ELSE ASSIGN nv_simat  = 0
                nv_simat1 = 0.
    Find LAST stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,n_model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)  No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp  =  stat.maktab_fil.prmpac
        wdetail.redbook =  stat.maktab_fil.modcod 
        wdetail.weight  =  STRING(stat.maktab_fil.tons)
        wdetail.body    =  stat.maktab_fil.body .
END.
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
      sic_bran.uwd132.gap_c   = 0     /*deci(wdetail.premt)  kridtiya i.*/      /*GAP, per Benefit per Item*/
      sic_bran.uwd132.dl1_c   = 0                        /*Disc./Load 1,p. Benefit p.Item*/
      sic_bran.uwd132.dl2_c   = 0                        /*Disc./Load 2,p. Benefit p.Item*/
      sic_bran.uwd132.dl3_c   = 0                        /*Disc./Load 3,p. Benefit p.Item*/
      sic_bran.uwd132.pd_aep  = "E"                      /*Premium Due A/E/P Code*/
      sic_bran.uwd132.prem_c  = 0    /*kridtiya i. deci(wdetail.premt) */     /*PD, per Benefit per Item*/
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
IF      wdetail.subclass = "210" THEN wdetail.subclass = "120A".
ELSE iF wdetail.subclass = "320" THEN wdetail.subclass = "140A".
ELSE    wdetail.subclass = "110".
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
    sic_bran.uwm120.bchyr  = nv_batchyr              AND 
    sic_bran.uwm120.bchno  = nv_batchno              AND 
    sic_bran.uwm120.bchcnt = nv_batcnt             :
    ASSIGN nv_gap  = 0
        nv_prem = 0.
    FOR EACH sic_bran.uwm130 WHERE
        sic_bran.uwm130.policy = wdetail.policy AND
        sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
        sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp AND
        sic_bran.uwm130.riskno = sic_bran.uwm120.riskno AND
        sic_bran.uwm130.bchyr  = nv_batchyr            AND 
        sic_bran.uwm130.bchno  = nv_batchno            AND 
        sic_bran.uwm130.bchcnt = nv_batcnt             NO-LOCK:
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
/*RUN proc_chktest4. */ /*kridtiya i. A55-0163 */
RUN proc_chktest41 .    /*kridtiya i. A55-0163 */
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
        wdetail2.recno        /* 1  "ลำดับที่"  */                             
        wdetail2.Notify_dat   /* 2   วันที่แจ้ง      */                                   
        wdetail2.comp_code    /* 3   บริษัทประกัน        */                               
        wdetail2.notifyno     /* 4   เลขที่รับแจ้ง       */                               
        wdetail2.NAME_mkt     /* 5   ชื่อผู้แจ้ง     */                                   
        wdetail2.ref          /* 6   เลขที่ใบคำขอ        */ 
        wdetail2.n_TITLE      /* 7   คำนำหน้า        */                                       
        wdetail2.n_name1      /* 8   ชื่อผู้เอาประกัน        */                           
        wdetail2.sex          /* 9   เพศ     */                                           
        wdetail2.idno         /* 10  เลขบัตรประชาชน      */                               
        wdetail2.brithday     /* 11  วันเดือนปี เกิด     */                               
        wdetail2.accoup       /* 12  อาชีพ       */                                       
        wdetail2.brand        /* 13  ชื่อรถยนต์      */                                   
        wdetail2.model        /* 14  รุ่น        */                                       
        wdetail2.cyear        /* 15  ปีรุ่น      */                                       
        wdetail2.cov_car      /* 16  แบบตัวถัง       */                                   
        wdetail2.vehuse       /* 17  ลักษณะการใช้รถยนต์      */                           
        wdetail2.power        /* 18  ซี.ซี.      */                                       
        wdetail2.engine       /* 19  เลขเครื่องยนต์      */                               
        wdetail2.chassis      /* 20  เลขตัวถัง       */                                   
        wdetail2.licence      /* 21  ทะเบียน     */                                       
        wdetail2.cov_new      /* 22  New Used    */                                       
        wdetail2.comdat       /* 23  กรมธรรม์ภาคสมัครใจ  เริ่มต้นคุ้มครอง    */           
        wdetail2.expdat       /* 24  สิ้นสุดวันที่   */                                 
        wdetail2.covcod       /* 25  ประเภท  */                                       
        wdetail2.ins_amt1     /* 26  ทุนประกันภัย    */                                 
        wdetail2.prem1        /* 27  ค่าเบี้ยประกัน  */                                 
        wdetail2.comprem      /* 28  กรมธรรม์ภาคบังคับ (พ.ร.บ.)  ค่า พ.ร.บ.  */             
        wdetail2.comdat72     /* 29  วันที่คุ้มครอง พ.ร.บ.   */                         
        wdetail2.expdat72     /* 30  วันที่สิ้นสุด พ.ร.บ.    */                       
        wdetail2.sck          /* 31  เลขเครื่องหมาย พ.ร.บ.   */                       
        wdetail2.prem2        /* 32  เบี้ยประกันภัยรวม พ.ร.บ.        */                     
        wdetail2.pricar       /* 33  ราคารถ      */                                         
        wdetail2.pricar2      /* 34  ยอดจัด      */                                       
        wdetail2.driname1     /* 35  ประเภทการประกันภัยที่ต้องการ    ระบุชื่อผู้ขับขี่ 1 */
        wdetail2.driname2     /* 36  ระบุชื่อผู้ขับขี่ 2 */                           
        wdetail2.bennam       /* 37  ผู้รับผลประโยชน์        */                           
        wdetail2.ADD_1        /* 38  ที่อยู่ที่จัดส่งกรมธรรม์        */                   
        wdetail2.remak1       /* 39  เงื่อนไขพิเศษ       */                               
        wdetail2.deler        /* 40  Dealer      */                                       
        wdetail2.addr_deler   /* 41  ที่อยู่ Dealer      */                               
        wdetail2.notiuser     /* 42  แจ้งประกันโดย       */                                    
        wdetail2.cedpol       /* 43  เลขที่สัญญา     */                                  
        wdetail2.refince      /* 44  รถใหม่/รถเก่า/Refinance */
        wdetail2.branchktb    /* 45  A56-0310 สาขา KTBL   */                        
        wdetail2.delerktb     /* 46  A56-0310 Dealer      */                   
        wdetail2.noti_name    /* 47  A56-0310 ผู้บันทึกข้อมูลประกัน       */   
        wdetail2.campaign     /* 48  A56-0310 Campaign        */               
        wdetail2.booking      /* 49  A56-0310 วัน Booking     */               
        wdetail2.si_ktb       /* 50  A56-0310 ทุนประกัน       */               
        wdetail2.premt_ktb.   /* 51  A56-0310 ค่าเบี้ย        */  
END.                       /*-Repeat-*/
ASSIGN fi_show = "Import Text file to GW......".
DISP fi_show WITH FRAM fr_main.
FOR EACH wdetail2.
    IF      index(wdetail2.recno,"รายงาน")   <> 0 THEN DELETE wdetail2.
    ELSE IF index(wdetail2.recno,"วันที่")   <> 0 THEN DELETE wdetail2.
    ELSE IF index(wdetail2.recno,"บริษัท")   <> 0 THEN DELETE wdetail2.
    ELSE IF index(wdetail2.recno,"ลำดับ")    <> 0 THEN DELETE wdetail2.
    ELSE IF index(wdetail2.recno,"เจ้าหน้า") <> 0 THEN DELETE wdetail2.
END.                                
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
DEF VAR n_banno   AS  CHAR   INIT "" FORMAT "x(150)".
DEF VAR n_banno1  AS  CHAR   INIT "" FORMAT "x(35)".
DEF VAR n_muno    AS  CHAR   INIT "" FORMAT "x(35)".
DEF VAR n_build   AS  CHAR   INIT "" FORMAT "x(50)".
/*Add kridtiya i. A55-0163....*/
DEF VAR n_road    AS  CHAR   INIT "" FORMAT "x(50)".
DEF VAR n_soy     AS  CHAR   INIT "" FORMAT "x(50)".
DEF VAR muban     AS  CHAR   INIT "" FORMAT "x(35)".
DEF VAR mu        AS  CHAR   INIT "" FORMAT "x(35)".
DEF VAR post      AS  CHAR   INIT "" FORMAT "x(35)".
/*Add kridtiya i. A55-0163....*/
FOR EACH wdetail2 .
    ASSIGN 
        n_banno   = "" 
        n_banno1  = "" 
        n_muno    = "" 
        n_build   = "" 
        n_road    = "" 
        n_soy     = "" 
        muban     = ""   /*A55-0163...*/
        mu        = ""   /*A55-0163...*/
        post      = "".  /*A55-0163...*/
    IF deci(wdetail2.cyear)  > YEAR(TODAY) THEN ASSIGN wdetail2.cyear = string(deci(wdetail2.cyear) - 543 ). 
    IF wdetail2.ADD_1 <> "" THEN DO:
        ASSIGN n_banno  = trim(wdetail2.ADD_1).
        IF (INDEX(n_banno,"กรุงเทพ") <> 0 ) THEN DO:  
            ASSIGN wdetail2.ADD_4 = SUBSTR(n_banno,INDEX(n_banno,"กรุงเทพ"))
                n_banno           = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(wdetail2.ADD_4)).
        END.
        ELSE IF (INDEX(n_banno,"กทม") <> 0 ) THEN DO:  
            ASSIGN wdetail2.ADD_4 = SUBSTR(n_banno,INDEX(n_banno,"กทม"))
                n_banno           = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(wdetail2.ADD_4)).
        END.
        ELSE IF (INDEX(n_banno,"จ.") <> 0 ) THEN DO:  
            ASSIGN wdetail2.ADD_4 = SUBSTR(n_banno,INDEX(n_banno,"จ."))
                n_banno           = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(wdetail2.ADD_4)).
        END.
        ELSE IF (INDEX(n_banno,"จังหวัด") <> 0 ) THEN DO:  
            ASSIGN wdetail2.ADD_4 = SUBSTR(n_banno,INDEX(n_banno,"จังหวัด"))
                n_banno           = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(wdetail2.ADD_4)).
        END.
        IF (INDEX(n_banno,"อ.") <> 0 ) THEN DO:     /*เขต*/
            ASSIGN wdetail2.ADD_3 = SUBSTR(n_banno,INDEX(n_banno,"อ."))
                n_banno           = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(wdetail2.ADD_3)).
        END.
        ELSE IF (INDEX(n_banno,"อำเภอ") <> 0 ) THEN DO:  
            ASSIGN wdetail2.ADD_3 = SUBSTR(n_banno,INDEX(n_banno,"อำเภอ"))
                n_banno           = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(wdetail2.ADD_3)).
        END.
        ELSE IF (INDEX(n_banno,"เขต") <> 0 ) THEN DO:  
            ASSIGN wdetail2.ADD_3 = SUBSTR(n_banno,INDEX(n_banno,"เขต"))
                n_banno           = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(wdetail2.ADD_3)).
        END.
        IF (INDEX(n_banno,"ต.") <> 0 ) THEN DO:   /*แขวง*/ 
            ASSIGN wdetail2.ADD_2 = SUBSTR(n_banno,INDEX(n_banno,"ต."))
                n_banno           = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(wdetail2.ADD_2)).
        END.
        ELSE IF (INDEX(n_banno,"ตำบล") <> 0 ) THEN DO:  
            ASSIGN wdetail2.ADD_2 = SUBSTR(n_banno,INDEX(n_banno,"ตำบล"))
                n_banno           = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(wdetail2.ADD_2)).
        END.
        ELSE IF (INDEX(n_banno,"แขวง") <> 0 ) THEN DO:  
            ASSIGN wdetail2.ADD_2 = SUBSTR(n_banno,INDEX(n_banno,"แขวง"))
                n_banno           = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(wdetail2.ADD_2)).
        END.   
        /*Add kridtiya i. A55-0163 ....    ถนน , ถ. */
        IF (INDEX(n_banno,"ถ.") <> 0 ) THEN DO:   /*  ถนน    ถ.  */
            ASSIGN n_road  = SUBSTR(n_banno,INDEX(n_banno,"ถ."))
                n_banno    = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(n_road)).
        END.
        ELSE IF (INDEX(n_banno,"ถนน") <> 0 ) THEN DO:  
            ASSIGN n_road   = SUBSTR(n_banno,INDEX(n_banno,"ถนน"))
                n_banno    = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(n_road)).
        END.
        IF (INDEX(n_banno,"ซ.") <> 0 ) THEN DO:    /*  ซอย    ซ.  */
            ASSIGN n_soy    = SUBSTR(n_banno,INDEX(n_banno,"ซ."))
                n_banno    = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(n_soy)).
        END.
        ELSE IF (INDEX(n_banno,"ซอย") <> 0 ) THEN DO:  
            ASSIGN n_soy   = SUBSTR(n_banno,INDEX(n_banno,"ซอย"))
                n_banno = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(n_soy)).
        END.
        IF (INDEX(n_banno,"หมู่บ้าน") <> 0 ) THEN DO:  /*  หมู่บ้าน    */
            ASSIGN muban   = SUBSTR(n_banno,INDEX(n_banno,"หมู่บ้าน"))
                n_banno    = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(muban)).
        END.
        IF (INDEX(n_banno,"หมู่ที่") <> 0 ) THEN DO:  
            ASSIGN mu   = SUBSTR(n_banno,INDEX(n_banno,"หมู่ที่"))
                n_banno = SUBSTR(n_banno,1,LENGTH(n_banno) - LENGTH(mu)).
        END.
    END.
    ASSIGN 
        add_1 = trim(n_banno)
        n_road = IF INDEX(n_road," ") <> 0 THEN trim(SUBSTR(n_road,1,INDEX(n_road," "))) + trim(SUBSTR(n_road,INDEX(n_road," ")))
                ELSE trim(n_road) 
        n_soy = IF INDEX(n_soy," ") <> 0 THEN trim(SUBSTR(n_soy,1,INDEX(n_soy," "))) + trim(SUBSTR(n_soy,INDEX(n_soy," ")))
                ELSE trim(n_soy)
        add_2 = IF INDEX(add_2," ") <> 0 THEN trim(SUBSTR(add_2,1,INDEX(add_2," "))) + trim(SUBSTR(add_2,INDEX(add_2," ")))
                ELSE trim(ADD_2) 
        add_3 = IF INDEX(add_3," ") <> 0 THEN trim(SUBSTR(add_3,1,INDEX(add_3," "))) + trim(SUBSTR(add_3,INDEX(add_3," ")))
                ELSE trim(ADD_3)
        add_4 = IF INDEX(add_4," ") <> 0 THEN trim(SUBSTR(add_4,1,INDEX(add_4," "))) + trim(SUBSTR(add_4,INDEX(add_4," ")))
        ELSE trim(ADD_4) .
        IF  n_banno <> "" THEN ADD_1 = TRIM(n_banno).                
        ELSE ADD_1 = "". 
        IF  mu      <> "" THEN ADD_1 = trim(ADD_1 + " " + TRIM(mu)). 
        IF  muban   <> "" THEN ADD_1 = trim(ADD_1 + " " + TRIM(muban)).
        IF  n_soy     <> "" THEN DO: 
            IF LENGTH(trim(ADD_1 + " " + TRIM(n_soy))) <= 35 THEN  
                ASSIGN ADD_1 = trim(ADD_1 + " " + TRIM(n_soy)).
        END.
        IF n_road <> ""  THEN DO:
            IF LENGTH(trim(ADD_1 + " " + TRIM(n_road))) <= 35  THEN
                ASSIGN  ADD_1 = trim(ADD_1 + " " + TRIM(n_road)).
            ELSE DO: 
                ASSIGN ADD_2 = TRIM(n_road) + " " + trim(ADD_2).
                IF INDEX(ADD_4," ") <> 0 THEN
                    ASSIGN post  = trim(SUBSTR(ADD_4,INDEX(ADD_4," ")))
                    ADD_4 = trim(SUBSTR(ADD_4,1,INDEX(ADD_4," ")))
                    ADD_3 = TRIM(ADD_3) + " " + TRIM(ADD_4).
            END.
        END.
        /*Add kridtiya i. A55-0163 ....*/
END.
RUN proc_assign2_veh.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2_veh C-Win 
PROCEDURE proc_assign2_veh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_show   = "Match province ......"
    n_setbranch  = "" 
    n_proceder   = "" .
DISP fi_show WITH FRAM fr_main.
FOR EACH wdetail2 .
    ASSIGN  wdetail2.delerktb =  trim(wdetail2.branchktb) + " " + trim(wdetail2.delerktb)  .
    IF wdetail2.n_TITLE <> "" THEN DO:
        FIND FIRST brstat.msgcode USE-INDEX MsgCode01 WHERE
            brstat.msgcode.MsgDesc = TRIM(wdetail2.n_TITLE)  NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.msgcode  THEN DO:
            ASSIGN wdetail2.n_TITLE = brstat.msgcode.branch.
        END.
    END.
    IF      (index(wdetail2.cov_new,"รถมือสอง") <> 0 ) THEN ASSIGN n_proceder = fi_producer2.
    ELSE IF (index(wdetail2.cov_new,"ป้ายแดง")  <> 0 ) THEN ASSIGN n_proceder = fi_producer.
    ELSE IF (index(wdetail2.cov_new,"รถใหม่")   <> 0 ) THEN ASSIGN n_proceder = fi_producer.  /* new car */ /*A55-0301 */
    IF wdetail2.notifyno NE "" THEN DO:
        /*IF (index(wdetail2.licence,"ป้ายแดง") = 0 ) OR (index(wdetail2.licence,"รถใหม่") = 0)  THEN 
        ELSE ASSIGN n_proceder = fi_producer. /* new car */ */  /*A55-0301 */
        IF      (index(wdetail2.cov_new,"รถมือสอง") <> 0 ) THEN ASSIGN n_proceder = fi_producer2.
        ELSE IF (index(wdetail2.cov_new,"ป้ายแดง") <> 0 ) THEN ASSIGN n_proceder = fi_producer.
        ELSE IF (index(wdetail2.cov_new,"รถใหม่")  <> 0 ) THEN ASSIGN n_proceder = fi_producer.   /* new car */ /*A55-0301 */
        /*ELSE     ASSIGN n_proceder = fi_producer2.*/  /* use car */ /*A55-0301 */
        IF (TRIM(wdetail2.licence) = "ป้ายแดง") OR (wdetail2.licence = "รถใหม่") OR (wdetail2.licence = "") THEN DO:
            ASSIGN   wdetail2.licence = "/" + SUBSTRING(trim(wdetail2.chassis),LENGTH(trim(wdetail2.chassis))  - 8 ). 
            /*comment by kridtiya i. A56-0310.....
            IF wdetail2.addr_deler = ""  THEN wdetail2.branch2 = "".
            ELSE DO: /*"ป้ายแดง" */
                FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*licence  */
                    brstat.insure.compno = "999" AND
                    index(wdetail2.addr_deler,brstat.Insure.fName) <> 0 NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL brstat.insure THEN ASSIGN n_setbranch = TRIM(Insure.LName).
                ELSE ASSIGN n_setbranch = "".
                IF n_setbranch = "" THEN  ASSIGN  wdetail2.branch2 = "".
                ELSE DO:
                    FIND LAST stat.insure USE-INDEX Insure06 WHERE 
                        stat.insure.lname  = n_setbranch   AND
                        stat.insure.compno = "KTBL" NO-LOCK NO-WAIT NO-ERROR.
                    IF AVAIL stat.insure THEN 
                        ASSIGN wdetail2.branch2 = stat.insure.branch.
                    ELSE ASSIGN wdetail2.branch2 = "M".
                END.
            END.  ....comment by kridtiya i. A56-0310.....*/
        END.
        ELSE DO:
            ASSIGN 
                n_setbranch  =   IF r-index(wdetail2.licence," ") <> 0 THEN 
                                 trim(substr(wdetail2.licence,r-index(wdetail2.licence," ")))
                                 ELSE TRIM(wdetail2.licence)
                n_vehpro     =   n_setbranch .
            FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*licence  */
                brstat.insure.compno = "999" AND
                brstat.Insure.fName = n_setbranch NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN DO: 
                ASSIGN wdetail2.licence = trim(substr(wdetail2.licence,1,r-index(wdetail2.licence," "))) + " " + TRIM(brstat.insure.LName)
                    /*wdetail2.licence = trim(SUBSTR(wdetail2.licence,1,2)) + " " + TRIM(SUBSTR(wdetail2.licence,3))*/   .  /*A56-0081*/
                /*add  A56-0081...*/
                IF (substr(trim(wdetail2.licence),1,1) >= "1" ) AND (substr(trim(wdetail2.licence),1,1) <= "9" ) THEN
                    wdetail2.licence = trim(SUBSTR(wdetail2.licence,1,3)) + " " + TRIM(SUBSTR(wdetail2.licence,4)).
                ELSE wdetail2.licence = trim(SUBSTR(wdetail2.licence,1,2)) + " " + TRIM(SUBSTR(wdetail2.licence,3)).
                /*end A56-0081...*/
                /*comment by kridtiya i. A56-0310.....
                FIND LAST stat.insure USE-INDEX Insure06 WHERE 
                    stat.insure.lname  = n_setbranch   AND
                    stat.insure.compno = "KTBL" NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL stat.insure THEN 
                    /*ASSIGN wdetail2.branch2  = stat.insure.branch.*/
                    ASSIGN wdetail2.branch2  = "M".  /*งานที่ไม่ใช่ป้ายแดง ให้เข้า สาขา DM */
                ELSE ASSIGN wdetail2.branch2 = "M".
                comment by kridtiya i. A56-0310.....*/
            END.
            /*ELSE ASSIGN wdetail2.branch2 = "".*//* add by kridtiya i. A56-0310.....*/
        END.
        /* add by kridtiya i. A56-0310.....*/
        FIND LAST stat.insure USE-INDEX Insure05 WHERE 
            stat.insure.fname  = TRIM(wdetail2.branchktb)   AND
            stat.insure.compno = "KTBL" NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL stat.insure THEN 
            ASSIGN wdetail2.branchktb  = stat.insure.branch.
        ELSE ASSIGN wdetail2.branchktb = "".
        /* add by kridtiya i. A56-0310.....*/
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
    IF (wdetail2.notifyno NE "")  THEN DO:
        /*create pol 72 only .....*/
        IF (trim(wdetail2.prem1) = "0") OR (trim(wdetail2.prem1) = "-") OR (trim(wdetail2.prem1) = "") THEN RUN proc_assign72.
        ELSE DO:
            FIND FIRST wdetail WHERE wdetail.policy = "0" + trim(wdetail2.notifyno) NO-ERROR NO-WAIT.
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.           /*create pol 70 .....*/
                ASSIGN
                    wdetail.policy      = "0" + trim(wdetail2.notifyno)
                    wdetail.brand       = trim(wdetail2.brand)
                    wdetail.caryear     = trim(wdetail2.cyear) 
                    wdetail.poltyp      = "70" 
                    wdetail.comdat      = trim(wdetail2.comdat)  
                    wdetail.expdat      = trim(wdetail2.expdat) 
                    wdetail.tiname      = trim(wdetail2.n_TITLE)
                    wdetail.insnam      = trim(wdetail2.n_name1) 
                    wdetail.name2       = IF index(wdetail2.remak1,"KTBL") <> 0 THEN "และ/หรือ บริษัท กรุงไทยธุรกิจลีสซิ่ง จำกัด" 
                                          ELSE IF index(wdetail2.remak1,"Dealer") <> 0 THEN "และ/หรือ " + trim(wdetail2.deler) 
                                          ELSE ""
                    wdetail.iadd1       = trim(wdetail2.ADD_1) 
                    wdetail.iadd2       = trim(wdetail2.ADD_2)  
                    wdetail.iadd3       = trim(wdetail2.ADD_3)  
                    wdetail.iadd4       = trim(wdetail2.ADD_4) 
                    wdetail.subclass    = IF index(wdetail2.cov_car,"เก๋ง") <> 0        THEN   "110"
                                          ELSE IF index(wdetail2.cov_car,"กระบะ")  <> 0 THEN   "320"
                                          ELSE IF index(wdetail2.cov_car,"โดยสาร") <> 0 THEN   "210"
                                          ELSE IF index(wdetail2.cov_car,"รถตู้")  <> 0 THEN   "210"
                                          ELSE  "110"
                    wdetail.prempa      = IF      (index(wdetail2.covcod,"1") <> 0 ) AND (index(wdetail2.cov_car,"เก๋ง") <> 0 )  THEN "Z"
                                          ELSE IF (index(wdetail2.covcod,"1") <> 0 ) AND (index(wdetail2.cov_car,"กระบะ") <> 0 ) THEN "G"
                                          ELSE IF (index(wdetail2.covcod,"1") <> 0 ) AND (index(wdetail2.cov_car,"รถตู้") <> 0 ) THEN "G"
                                          ELSE IF (index(wdetail2.covcod,"2") <> 0 ) THEN "Y"
                                          ELSE "Z"
                    wdetail.model       = trim(wdetail2.model) 
                    /*wdetail.cc          = trim(wdetail2.power) *//* A55-0301*/
                    wdetail.cc          = string(ROUND((deci(trim(wdetail2.power)) / 1000), 1 ) * 1000 )     /* A55-0301*/
                    wdetail.weight      = ""
                    wdetail.vehreg      = IF wdetail2.licence = "" THEN "" 
                                          ELSE trim(wdetail2.licence) 
                    wdetail.engno       = trim(wdetail2.engine)
                    wdetail.chasno      = trim(wdetail2.chassis)
                    wdetail.vehuse      = "1"
                    wdetail.garage      = IF      trim(wdetail2.cov_new) = "รถใหม่"  THEN "G"
                                          /*ELSE IF index(wdetail2.covcod,"1") <> 0   THEN "G"*//*kridtiya i. A55-0163 */
                                          ELSE IF trim(wdetail2.cov_new) = "ป้ายแดง" THEN "G"   /*kridtiya i. A55-0163 */
                                          ELSE ""
                    wdetail.stk         = trim(wdetail2.sck) 
                    wdetail.covcod      = IF      index(wdetail2.covcod,"1") <> 0 THEN "1"
                                          ELSE IF index(wdetail2.covcod,"2") <> 0 THEN "2"
                                          ELSE IF index(wdetail2.covcod,"3") <> 0 THEN "3"
                                          ELSE IF index(wdetail2.covcod,"5") <> 0 THEN "5"
                                          ELSE "1"
                    wdetail.product     = trim(fi_product)
                    wdetail.vatcode     = IF      trim(wdetail2.cov_new) = "รถใหม่"  THEN ""
                                          ELSE IF trim(wdetail2.cov_new) = "ป้ายแดง" THEN ""
                                          ELSE IF wdetail2.remak1 = "KTBL แถมประกัน"  THEN trim(fi_vatcode)
                                          ELSE ""
                    wdetail.si          = trim(wdetail2.ins_amt1)
                    /*wdetail.branch      = trim(wdetail2.branch2)*/  /* A56-0310 */
                    wdetail.branch      = caps(trim(wdetail2.branchktb))    /* A56-0310 *//* 45  สาขา KTBL   */      
                    wdetail.benname     = TRIM(wdetail2.bennam)
                    wdetail.volprem     = trim(wdetail2.prem1)
                    wdetail.typecar     = trim(wdetail2.cov_new)
                    wdetail.comment     = ""
                    /*wdetail.producer    = trim(n_proceder)*/ /* A55-0301 */
                    wdetail.producer    = IF trim(wdetail2.cov_new) = "รถใหม่"  THEN fi_producer
                                          ELSE IF trim(wdetail2.cov_new) = "ป้ายแดง" THEN fi_producer
                                          ELSE fi_producer2  .
             ASSIGN 

                    wdetail.agent       = trim(fi_agent) 
                    wdetail.entdat      = string(TODAY)                /*entry date*/
                    wdetail.enttim      = STRING(TIME, "HH:MM:SS")    /*entry time*/
                    wdetail.trandat     = STRING(TODAY)               /*tran date*/
                    wdetail.trantim     = STRING(TIME, "HH:MM:SS")    /*tran time*/
                    wdetail.n_IMPORT    = "IM"
                    wdetail.n_EXPORT    = ""   
                    wdetail.nmember     = "วันที่เเจ้ง : "   + trim(wdetail2.Notify_dat) + 
                                          "     ผู้แจ้ง : "  + trim(wdetail2.NAME_mkt)   +
                                          "เลขที่ใบคำขอ : "  + trim(wdetail2.ref)   
                    wdetail.delerco    = IF trim(wdetail2.delerktb) = "" THEN "" ELSE "Dealer : " +  trim(wdetail2.delerktb)                  /* 46  Dealer      */ 
                    wdetail.remak2     = IF trim(wdetail2.noti_name) = "" THEN "" ELSE "ผู้บันทึกข้อมูลประกัน : " + trim(wdetail2.noti_name)  /* 47  ผู้บันทึกข้อมูลประกัน  */   
                    wdetail.remak2     = wdetail.remak2 + IF trim(wdetail2.campaign)  = "" THEN "" ELSE " CampaCampaign: "    +  trim(wdetail2.campaign)                         /* 48  CampaCampaign              ign               */               
                    wdetail.remak2     = wdetail.remak2 + IF trim(wdetail2.booking)   = "" THEN "" ELSE " วัน Bวัน Booking: " +  trim(wdetail2.booking)                             /* 49  วัน Bวัน Booking           ooking            */               
                    wdetail.remak1      = trim(wdetail2.remak1)
                    wdetail.cedpol      = trim(wdetail2.notifyno)  
                    wdetail.ICNO        = trim(wdetail2.idno)        /* add A55-0301 เลขบัตรประชาชน */                               
                    wdetail2.brithday   = REPLACE(wdetail2.brithday,"'","")
                    wdetail2.brithday   = IF trim(wdetail2.brithday) = "" THEN ""
                                          ELSE STRING(DATE(wdetail2.brithday),"99/99/9999")
                    wdetail.brithday    = IF trim(wdetail2.brithday) = "" THEN ""
                                          ELSE IF deci(SUBSTR(trim(wdetail2.brithday),7,4)) <= YEAR(TODAY) THEN  
                                            (SUBSTR(trim(wdetail2.brithday),1,6)) + 
                                              STRING(deci(SUBSTR(trim(wdetail2.brithday),7,4)) + 543)
                                          ELSE  trim(wdetail2.brithday)   /* add A55-0301 วันเดือนปี เกิด */                               
                    wdetail.accoup      = trim(wdetail2.accoup)  .   /* add A55-0301 อาชีพ           */     
            END.    /*if avail*/
            ELSE MESSAGE "พบกรมธรรม์นี้ซ้ำในไฟล์เดียวกันเลขกรมธรรม์คือ: " +  wdetail.policy VIEW-AS ALERT-BOX.
            IF wdetail2.sck  <> "" THEN RUN proc_assign72.
        END.
    END.
END.
FIND LAST sicsyac.xcpara49 WHERE  sicsyac.xcpara49.typ[1]  = fi_product NO-LOCK NO-ERROR .
IF AVAIL sicsyac.xcpara49 THEN
    ASSIGN fi_product = sicsyac.xcpara49.typ[1] + " " +
                        /*sicsyac.xcpara49.typ[7] + " " +*/
                        sicsyac.xcpara49.typ[9].
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
FIND FIRST wdetail WHERE wdetail.policy = "1" + trim(wdetail2.notifyno) NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN
        wdetail.policy      = "1" + trim(wdetail2.notifyno)
        wdetail.brand       = trim(wdetail2.brand)
        wdetail.caryear     = trim(wdetail2.cyear) 
        wdetail.poltyp      = "72" 
        wdetail.comdat      = trim(wdetail2.comdat)  
        wdetail.expdat      = trim(wdetail2.expdat) 
        wdetail.tiname      = trim(wdetail2.n_TITLE)
        wdetail.insnam      = trim(wdetail2.n_name1) 
        wdetail.name2       = IF      index(wdetail2.remak1,"KTBL")   <> 0 THEN "และ/หรือ บริษัท กรุงไทยธุรกิจลีสซิ่ง จำกัด" 
                              ELSE IF index(wdetail2.remak1,"Dealer") <> 0 THEN "และ/หรือ " + trim(wdetail2.deler) 
                              ELSE ""
        wdetail.iadd1       = trim(wdetail2.ADD_1) 
        wdetail.iadd2       = trim(wdetail2.ADD_2)  
        wdetail.iadd3       = trim(wdetail2.ADD_3)  
        wdetail.iadd4       = trim(wdetail2.ADD_4) 
        wdetail.subclass    = IF index(wdetail2.cov_car,"เก๋ง") <> 0        THEN   "110"
                              ELSE IF index(wdetail2.cov_car,"กระบะ") <> 0  THEN   "320"
                              ELSE IF index(wdetail2.cov_car,"โดยสาร") <> 0 THEN   "210"
                              ELSE IF index(wdetail2.cov_car,"รถตู้")  <> 0 THEN   "210"
                              ELSE  "110"
        wdetail.prempa      = IF      (index(wdetail2.covcod,"1") <> 0 ) AND (index(wdetail2.cov_car,"เก๋ง") <> 0 )  THEN "Z"
                              ELSE IF (index(wdetail2.covcod,"1") <> 0 ) AND (index(wdetail2.cov_car,"กระบะ") <> 0 ) THEN "G"
                              ELSE IF (index(wdetail2.covcod,"1") <> 0 ) AND (index(wdetail2.cov_car,"รถตู้") <> 0 ) THEN "G"
                              ELSE IF (index(wdetail2.covcod,"2") <> 0 ) THEN "Y"
                              ELSE "Z"
        wdetail.model       = trim(wdetail2.model) 
        /*wdetail.cc          = trim(wdetail2.power) *//* A55-0301*/
        wdetail.cc          = string(ROUND((deci(trim(wdetail2.power)) / 1000), 1 ) * 1000 )     /* A55-0301*/
        wdetail.weight      = ""
        wdetail.vehreg      = IF wdetail2.licence = "" THEN "" 
                              ELSE trim(wdetail2.licence) 
        wdetail.engno       = trim(wdetail2.engine)
        wdetail.chasno      = trim(wdetail2.chassis)
        wdetail.vehuse      = "1"
        wdetail.garage      = ""
        wdetail.stk         = trim(wdetail2.sck) 
        wdetail.covcod      =  "T"
        wdetail.product     = ""
        wdetail.vatcode     = IF      trim(wdetail2.cov_new) = "รถใหม่"  THEN ""
                              ELSE IF trim(wdetail2.cov_new) = "ป้ายแดง" THEN ""
                              ELSE IF wdetail2.remak1 = "KTBL แถมประกัน"  THEN trim(fi_vatcode)
                              ELSE ""
        wdetail.si          = trim(wdetail2.ins_amt1)
        /*wdetail.branch      = trim(wdetail2.branch2)*/     /* add by kridtiya i. A56-0310.....*/
        wdetail.branch      = caps(trim(wdetail2.branchktb)) /* add by kridtiya i. A56-0310.....*/
        wdetail.benname     = TRIM(wdetail2.bennam)
        wdetail.volprem     = trim(wdetail2.prem1)
        wdetail.typecar     = trim(wdetail2.cov_new)
        wdetail.comment     = ""
        /*wdetail.producer    = trim(n_proceder)  *//*A55-0301*/
        wdetail.producer    = IF trim(wdetail2.cov_new) = "รถใหม่"  THEN fi_producer
                              ELSE IF trim(wdetail2.cov_new) = "ป้ายแดง" THEN fi_producer
                              ELSE fi_producer2   /*A55-0301*/
        wdetail.agent       = trim(fi_agent) 
        wdetail.entdat      = string(TODAY)                /*entry date*/
        wdetail.enttim      = STRING(TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat     = STRING(TODAY)               /*tran date*/
        wdetail.trantim     = STRING(TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT    = "IM"
        wdetail.n_EXPORT    = ""
        wdetail.nmember     = "" 
        wdetail.remak1      = ""
        wdetail.cedpol      = trim(wdetail2.notifyno)  
        wdetail.ICNO        = trim(wdetail2.idno)          /* add A55-0301 เลขบัตรประชาชน  */                               
        wdetail2.brithday   = REPLACE(wdetail2.brithday,"'","")
        wdetail.brithday    = IF trim(wdetail2.brithday) = "" THEN ""
                              ELSE IF deci(SUBSTR(trim(wdetail2.brithday),7,4)) <= YEAR(TODAY) THEN  
                              (SUBSTR(trim(wdetail2.brithday),1,6)) + 
                               STRING(deci(SUBSTR(trim(wdetail2.brithday),7,4)) + 543)
                               ELSE  trim(wdetail2.brithday)   /* add A55-0301 วันเดือนปี เกิด */                               
        wdetail.accoup      = trim(wdetail2.accoup)            /* add A55-0301 อาชีพ           */      .
END.   /*if avail*/
ELSE MESSAGE "พบกรมธรรม์นี้ซ้ำในไฟล์เดียวกันเลขกรมธรรม์คือ: " + wdetail.policy VIEW-AS ALERT-BOX.
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
DEF VAR Nv_brchk   AS CHAR FORMAT "x(5)" INIT "" .  /*add Kridtiya i. A55-0016....*/
ASSIGN 
    n_firstdat = ""
    nv_basere  = 0  
    n_41 = 0        
    n_42 = 0         
    n_43 = 0         
    dod1 = 0         
    dod2 = 0         
    dod0 = 0         
    nv_dss_per = 0  
    nv_cl_per  = 0 
    Nv_brchk   = "" . /*add Kridtiya i. A55-0016....*/

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
    RUN wgw\wgwkkex1
        (INPUT-OUTPUT wdetail.prepol,   /*n_prepol  */ 
         INPUT-OUTPUT nv_brchk,
         INPUT-OUTPUT wdetail.producer, /*Producer  */
         INPUT-OUTPUT wdetail.agent,    /*Agent     */
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
         /*INPUT-OUTPUT wdetail.deductpp, /*n_tp1     */  
         INPUT-OUTPUT wdetail.deductba, /*n_tp2     */  
         INPUT-OUTPUT wdetail.deductpa, /*n_tp3     */ */  
         INPUT-OUTPUT nv_basere,        /*nv_basere */
         INPUT-OUTPUT wdetail.seat41,   /* INTE                */    
         INPUT-OUTPUT n_41,             /* INTE     n_41       */  
         INPUT-OUTPUT n_42,             /* DECI     n_42       */  
         INPUT-OUTPUT n_43,             /* DECI     n_43       */  
         INPUT-OUTPUT dod1,             /* DECI     n_dod      */  
         INPUT-OUTPUT dod2,             /* DECI     n_dod2     */
         INPUT-OUTPUT dod0,             /* DECI     n_pd       */  
         INPUT-OUTPUT wdetail.fleet,    /*n DECI    _feet      */  
         INPUT-OUTPUT WDETAIL.NCB,      /* DECI     n_ncb      */  
         INPUT-OUTPUT nv_dss_per,       /* DECI     nv_dss_per */  
         INPUT-OUTPUT nv_cl_per,
         INPUT        inte(wdetail.si),
         INPUT        wdetail.vehreg).       /* DECI     n_lcd      */ 
END. 
/*INPUT-OUTPUT wdetail.branch,   /*n_branch  */*//*add Kridtiya i. A55-0016....*/
/*add Kridtiya i. A55-0016....*/
IF wdetail.branch <> nv_brchk THEN 
    ASSIGN 
    wdetail.comment = wdetail.comment + "สาขาจากไฟล์แจ้งงาน ไม่ตรงกับ สาขากรมธรรม์เดิม" + wdetail.branch + "/" +  nv_brchk 
    wdetail.pass    = "Y" .
/*end....Add A55-0016..... */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base02 C-Win 
PROCEDURE proc_base02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN WDETAIL.NCB = "0" 
                aa = 0
    nv_baseprm     = 0
        nv_dss_per = 0.
IF (wdetail.covcod = "1") THEN DO:
    IF (wdetail.typecar = "รถมือสอง") THEN 
        ASSIGN WDETAIL.NCB = "20" .
    IF wdetail.prempa = "G" THEN DO: 
        IF wdetail.subclass = "110" THEN aa = 8000.
        ELSE  aa = 13000.
    END.
    ELSE IF wdetail.prempa = "F" THEN DO: 
        IF wdetail.subclass = "110" THEN aa = 9100.
        ELSE  aa = 14500.
    END.
    ELSE IF (wdetail.prempa = "X") OR (wdetail.prempa = "V") OR (wdetail.prempa = "Z") THEN DO: 
        IF  (substr(wdetail.subclass,2,3) = "110") OR (wdetail.subclass = "110") THEN aa = 7600.
        ELSE IF wdetail.subclass = "210" THEN aa = 12000.
        ELSE IF wdetail.subclass = "320" THEN aa = 13000.
    END.
END.
ELSE IF wdetail.covcod = "2" THEN DO:
    IF (wdetail.subclass = "110") OR (substr(wdetail.subclass,2,3) = "110") THEN DO: 
        IF (deci(wdetail.weight) <= 2000 ) THEN 
            ASSIGN aa = 3000
            nv_dss_per = 1.45.
        ELSE /* > 2000*/
            ASSIGN aa = 3000
                nv_dss_per = 10.90.
    END.
    ELSE IF (wdetail.subclass = "210") OR (substr(wdetail.subclass,2,3) = "210") THEN
        ASSIGN aa = 6000
        WDETAIL.NCB = "30" 
        nv_dss_per  = 12.83.
    ELSE IF (wdetail.subclass = "320") OR (substr(wdetail.subclass,2,3) = "320") THEN
        ASSIGN aa = 6000
        WDETAIL.NCB = "30" 
        nv_dss_per  = 3.97.
END.
ELSE IF (wdetail.covcod = "3") AND (wdetail.prempa = "V") THEN DO:
    IF (wdetail.subclass = "110") OR (substr(wdetail.subclass,2,3) = "110") THEN DO: 
        IF (deci(wdetail.weight) <= 2000 ) THEN
            ASSIGN  aa  = 2635
            nv_dss_per  = 0
            WDETAIL.NCB = "20" .
        ELSE ASSIGN aa = 2646
            nv_dss_per = 0
            WDETAIL.NCB = "30" .
    END.
    ELSE IF (wdetail.subclass = "210") OR (substr(wdetail.subclass,2,3) = "210") THEN
        ASSIGN aa = 3544
        nv_dss_per = 0
        WDETAIL.NCB = "30" .
    ELSE IF (wdetail.subclass = "320") OR (substr(wdetail.subclass,2,3) = "320") THEN
        ASSIGN aa = 4045
        nv_dss_per = 0
        WDETAIL.NCB = "" .
END.
ELSE IF (wdetail.covcod = "3") AND (wdetail.prempa = "R") THEN DO:
        IF (wdetail.subclass = "110") OR (substr(wdetail.subclass,2,3) = "110") THEN DO: 
            IF (deci(wdetail.weight) <= 2000 ) THEN
                ASSIGN  aa  = 2458
                nv_dss_per  = 0
                WDETAIL.NCB = "30" .
            ELSE ASSIGN aa = 2524
                nv_dss_per = 0
                WDETAIL.NCB = "40" .
        END.
        ELSE IF (wdetail.subclass = "210") OR (substr(wdetail.subclass,2,3) = "210") THEN
            ASSIGN aa = 3401
            nv_dss_per = 0
            WDETAIL.NCB = "30" .
        ELSE IF (wdetail.subclass = "320") OR (substr(wdetail.subclass,2,3) = "320") THEN
            ASSIGN aa = 4135
            nv_dss_per = 0
            WDETAIL.NCB = "30" .
    END.
    ELSE IF (wdetail.covcod = "3") AND (wdetail.prempa = "Z") THEN DO:
        IF (wdetail.subclass = "110") OR (substr(wdetail.subclass,2,3) = "110") THEN DO: 
            IF (deci(wdetail.weight) <= 2000 ) THEN
                ASSIGN  aa  = 2691
                nv_dss_per  = 0
                WDETAIL.NCB = "20" .
            ELSE ASSIGN aa = 2341
                nv_dss_per = 0
                WDETAIL.NCB = "20" .
        END.
        ELSE IF (wdetail.subclass = "210") OR (substr(wdetail.subclass,2,3) = "210") THEN
            ASSIGN aa = 3245
            nv_dss_per = 0
            WDETAIL.NCB = "20" .
        ELSE IF (wdetail.subclass = "320") OR (substr(wdetail.subclass,2,3) = "320") THEN
            ASSIGN aa = 3750
            nv_dss_per = 0
            WDETAIL.NCB = "20" .
    END.
IF wdetail.covcod = "5" THEN DO:
        IF (wdetail.subclass = "110") OR (substr(wdetail.subclass,2,3) = "110") THEN DO: 
            IF (deci(wdetail.weight) <= 2000 ) THEN
                ASSIGN aa = 4600
                nv_dss_per = 17.54 .
            ELSE ASSIGN aa = 4000
                nv_dss_per = 17 .
        END.
        ELSE IF (wdetail.subclass = "210") OR (substr(wdetail.subclass,2,3) = "210") THEN
            ASSIGN aa = 6000
            nv_dss_per = 10.06 
            WDETAIL.NCB = "20" .
        ELSE IF (wdetail.subclass = "320") OR (substr(wdetail.subclass,2,3) = "320") THEN
            ASSIGN aa = 6000
            nv_dss_per = 12.79
            WDETAIL.NCB = "" .
    END.
    ASSIGN nv_baseprm = aa.
    nv_dss_per = 0.
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
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN nv_drivno = 0
    nv_drivvar1 = "" .
IF wdetail.poltyp = "v70" THEN DO:
    RUN proc_base02.
    IF aa = 0 THEN DO:
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END. 
    If nv_drivvar1  = ""  Then 
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
    IF NO_basemsg <> " " THEN 
        wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    Assign
        nv_prem1   = nv_baseprm
        nv_basecod = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    IF      wdetail.subclass = "110"  THEN wdetail.seat = "7".
    ELSE IF wdetail.subclass = "210"  THEN wdetail.seat = "12".
    ELSE IF wdetail.subclass = "320"  THEN wdetail.seat = "3".
    ASSIGN 
        nv_41     = deci(wdetail.no_41)  
        nv_42     = deci(wdetail.no_42)  
        nv_43     = deci(wdetail.no_43)  
        nv_seat41 = wdetail.seat41  .       /*integer(wdetail.seat)*/ 
    IF wdetail.prempa = "Z" THEN nv_seat41 = deci(wdetail.seat). 
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
         nv_bipvar2     = STRING(nv_uom1_v) 
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign 
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(nv_uom2_v)
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN 
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         /*nv_pdavar2     = STRING(uwm130.uom5_v)   a52-0172*/
         nv_pdavar2     = string(nv_uom5_v)     
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
     DEF VAR dod0 AS INTEGER.
     DEF VAR dod1 AS INTEGER INIT 0 .
     DEF VAR dod2 AS INTEGER.
     DEF VAR dpd0 AS INTEGER.
     IF dod0 > 3000 THEN DO:
         dod1 = 3000.
         dod2 = dod0 - dod1.
     END.
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
         nv_dedpd_prm  = nv_prem.
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
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi, 
                                nv_uom1_v,  
                                nv_uom2_v,  
                                nv_uom5_v).
     ASSIGN
         nv_fletvar     = " "
         nv_fletvar1    = "     Fleet % = "
         nv_fletvar2    =  STRING(nv_flet_per)
         SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
         SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN
         nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     /*IF wdetail.covcod = "1" THEN WDETAIL.NCB = "0".
     ELSE RUN proc_dsp_ncb.*/
     /*IF wdetail.covcod = "1" THEN WDETAIL.NCB = "20".*/
     ASSIGN
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
                                nv_uom1_v,  
                                nv_uom2_v,  
                                nv_uom5_v).
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     
     /*------------------ dsspc ---------------*/
     
     /*IF nv_gapprm <> f THEN  DO:
         per = TRUNCATE((nv_gapprm - f ),1).
         per = TRUNCATE((per * 100 ),1).
         per = ROUND((per / nv_gapprm ),2).  
         Assign                
             nv_dss_per = per .  */

         assign
             nv_dsspcvar   = " ".
         /*IF  (wdetail.covcod = "2") AND (nv_dss_per = 0 )  THEN /*RUN proc_dsp_ncb.  */ ASSIGN nv_dss_per = 4.1.*/
         IF  nv_dss_per   <> 0  THEN
             Assign
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
         END.
         /*--------------------------*/
         RUN WGS\WGSORPRM.P (INPUT  nv_tariff,  
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v,  
                         nv_uom2_v,  
                         nv_uom5_v).
         ASSIGN 
             nv_dsspcvar   = " "
             n_prem  = 0
             n_prem = DECI(wdetail.volprem)
             nv_dss_per   = 0
             n_prem = TRUNCATE(((n_prem * 100 ) / 107.43),0).
         
         IF (nv_dss_per = 0 ) AND (nv_gapprm > n_prem) AND (n_prem > 0 ) THEN DO:
             
             nv_dss_per = TRUNCATE(((nv_gapprm  - n_prem ) * 100 ) / nv_gapprm ,3 ) . 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base23 C-Win 
PROCEDURE proc_base23 :
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
    IF (wdetail.subclass = "110") OR (wdetail.subclass = "z110") THEN aa = 3000.
    ELSE IF (wdetail.subclass = "210") OR (wdetail.subclass = "z210") OR
        (wdetail.subclass = "320") OR (wdetail.subclass = "z320") THEN aa = 6000.
    ELSE DO: 
            RUN wgs\wgsfbas.
            ASSIGN aa = nv_baseprm.
    END.
ASSIGN
    chk = NO
    NO_basemsg = " "
    nv_baseprm = aa
    nv_dss_per = 0 
    nv_drivvar1 = "".
    IF nv_drivvar1 <> ""  THEN  nv_drivno = 1.  
    ELSE IF nv_drivvar1 = ""  THEN  nv_drivno = 0.   
    IF nv_drivvar1 = ""  Then 
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
        End.
        RUN proc_usdcod.
        Assign
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
        ASSIGN
        wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    Assign
            nv_prem1   = nv_baseprm
            nv_basecod = "BASE"
            nv_basevar1 = "     Base Premium = "
            nv_basevar2 = STRING(nv_baseprm)
            SUBSTRING(nv_basevar,1,30)   = nv_basevar1
            SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    IF wdetail.prepol <> "" THEN  ASSIGN  wdetail.no_41  = STRING(n_41)
                                          wdetail.no_42  = STRING(n_42)
                                          wdetail.no_43  = STRING(n_43).  
    ASSIGN
            nv_41 =  50000      /*DECI(wdetail.no_41)*/
            nv_42 =  50000      /*DECI(wdetail.no_42)*/
            nv_43 =  100000      /* DECI(wdetail.no_43)*/
            nv_seat41 = integer(wdetail.seat).   /*integer(wdetail.seat41).*/ 
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
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) 
            Else "YR99"
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
     ASSIGN 
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         /*nv_pdavar2     = STRING(uwm130.uom5_v)   a52-0172*/
        /* nv_pdavar2     = string(deci(WDETAIL.deductpa))        /*A52-0172*/*/
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
     /* caculate deduct OD  */
     DEF VAR dod0 AS INTEGER.
     DEF VAR dod1 AS INTEGER.
     DEF VAR dod2 AS INTEGER.
     DEF VAR dpd0 AS INTEGER.
     /*def  var  nv_chk  as  logic.*/
      /*dod0 = inte(wdetail.deductda).  a52-0172*/
     IF dod0 > 3000 THEN DO:
         dod1 = 3000.
         dod2 = dod0 - dod1.
     END.
     ASSIGN
         nv_odcod    = "DC01"
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
         nv_dedpd_prm  = nv_prem.
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
     RUN proc_dsp_ncb.
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
     
     /*------------------ dsspc ---------------*/
     
     /*IF nv_gapprm <> f THEN  DO:
         per = TRUNCATE((nv_gapprm - f ),1).
         per = TRUNCATE((per * 100 ),1).
         per = ROUND((per / nv_gapprm ),2).  
         Assign                
             nv_dss_per = per .  */
         nv_dsspcvar   = " ".
            
         IF  nv_dss_per   <> 0  THEN
             Assign
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
         END.
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

         /*IF nv_gapprm <> DECI(wdetail.volprem )  THEN  DO:
             IF (nv_gapprm - DECI(wdetail.volprem )) < 3 THEN DO:
                 ASSIGN
                     nv_dss_per = nv_dss_per + 0.01.    
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
                 IF nv_gapprm = DECI(wdetail.volprem ) THEN i = 10.
             END.
             nv_baseprm = nv_baseprm + 1.
             i = i + 1.
             END. 
             ELSE  i = 10.
 END.
END.*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 C-Win 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER  INIT  0. 

ASSIGN fi_show = "Check data basic......".
DISP fi_show WITH FRAM fr_main.
IF wdetail.vehreg = " " AND wdetail.prepol  = " " THEN DO: 
    ASSIGN wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass       = "N"   
        wdetail.OK_GEN     = "N". 
END.
ELSE DO:
    IF wdetail.prepol = " " THEN DO:         /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
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
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.prempa = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| prem pack เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.branch = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| branch เป็นค่าว่าง มีผลต่อการรับประกันภัย"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.subclass = " " THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
IF wdetail.brand = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
/*Add A55-0301 ...*/
/*comment BY Kridtiya i. A56-0310...
IF wdetail.ICNO <> "" THEN DO:
    IF LENGTH(TRIM(wdetail.ICNO)) = 13 THEN DO:
        DO WHILE nv_seq <= 12:
            nv_sum = nv_sum + INTEGER(SUBSTR(TRIM(wdetail.ICNO),nv_seq,1)) * (14 - nv_seq).
            nv_seq = nv_seq + 1.
        END.
        nv_checkdigit = 11 - nv_sum MODULO 11.
        IF nv_checkdigit >= 10 THEN nv_checkdigit = nv_checkdigit - 10.
        IF STRING(nv_checkdigit) <> SUBSTR(TRIM(wdetail.ICNO),13,1) THEN  
            ASSIGN  wdetail.comment = wdetail.comment + "| WARNING: พบเลขบัตรประชาชนไม่ถูกต้อง"
            wdetail.pass    = "N"  
            WDETAIL.OK_GEN  = "N".
    END.
    ELSE ASSIGN  wdetail.comment = wdetail.comment + "| WARNING: คีย์เลขบัตรประชาชนไม่ถูกต้องไม่เท่ากับ 13 หลัก"
        wdetail.pass    = "N"  
        WDETAIL.OK_GEN  = "N".
END.
comment BY Kridtiya i. A56-0310...*/
/*Add A55-0301 ...*/
ASSIGN 
    nv_maxsi  = 0
    nv_minsi  = 0
    nv_si     = 0
    nv_maxdes = ""
    nv_mindes = ""
    n_model   = ""
    nv_modcod = "". 
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
            ELSE ASSIGN  nv_maxSI = nv_si
                         nv_minSI = nv_si.
        END.   /***--- End Check Rate SI ---***/
    END.
    ELSE nv_modcod = " ".  /*stat.maktab_fil*/
END.    /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    ASSIGN 
        n_model = ""
        n_model = IF wdetail.model <> "" THEN SUBSTR(wdetail.model,1,INDEX(wdetail.model," ")) ELSE "".
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN nv_simat  = makdes31.si_theft_p   
               nv_simat1 = makdes31.load_p   .    
    ELSE ASSIGN  nv_simat  = 0
                 nv_simat1 = 0.
    Find LAST stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand              And                  
        index(stat.maktab_fil.moddes,n_model) <> 0          And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear)   AND 
        stat.maktab_fil.engine   =     Integer(wdetail.cc)     AND 
        stat.maktab_fil.sclass   =     wdetail.subclass           AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)         No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        wdetail.redbook =  stat.maktab_fil.modcod
        nv_modcod       =  stat.maktab_fil.modcod                                    
        nv_moddes       =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        nv_modcod       =  stat.maktab_fil.modcod 
        /*wdetail.brand   =  stat.maktab_fil.makdes  */
        wdetail.model   =  stat.maktab_fil.moddes
        wdetail.cargrp  =  stat.maktab_fil.prmpac
        wdetail.body    =  stat.maktab_fil.body 
        wdetail.cc      =  STRING(stat.maktab_fil.engine)
        wdetail.cargrp  =  stat.maktab_fil.prmpac
        wdetail.seat    =  string(stat.maktab_fil.seats) .
    IF nv_modcod = ""  THEN RUN proc_maktab.
END.
ASSIGN      
    NO_CLASS  = ""
    NO_CLASS  = wdetail.prempa + wdetail.subclass 
    nv_poltyp = wdetail.poltyp.
IF wdetail.poltyp = "V72" THEN ASSIGN NO_CLASS  =   wdetail.subclass .
If no_class  <>  " " Then do:
    FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
        sicsyac.xmd031.poltyp =   nv_poltyp AND
        sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmd031 THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N" .
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
    sicsyac.sym100.tabcod = "u013"          And
    sicsyac.sym100.itmcod = wdetail.covcod  No-lock no-error no-wait.
IF not avail sicsyac.sym100 Then 
    ASSIGN
    wdetail.comment = wdetail.comment + "| Not on Motor Cover Type Codes table sym100 u013"
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
/*---------- fleet -------------------*/
IF inte(wdetail.fleet) <> 0 AND INTE(wdetail.fleet) <> 10 Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. "
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
/*----------  ncb -------------------*/
     IF wdetail.prepol = ""  THEN DO:
         IF wdetail.covcod = "2" THEN RUN proc_dsp_ncb. 
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
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail:
    IF  wdetail.policy = ""  THEN NEXT.
    /*------------------  renew ---------------------*/
    ASSIGN 
        nc_r2    = ""
        n_rencnt = 0
        n_endcnt = 0.
    RUN proc_cr_2. 
    /* IF wdetail.prepol <> " " THEN RUN proc_renew.*/
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
        RUN proc_chktest0.
        RUN proc_policy . 
        RUN proc_chktest2.      
        RUN proc_chktest3.      
        /*RUN proc_chktest4. */ /*kridtiya i. A55-0163 */
        RUN proc_chktest41 .    /*kridtiya i. A55-0163 */
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
ASSIGN fi_show = "Create policy data detail car[uwm301]......" .
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
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN 
        ASSIGN
        sic_bran.uwm130.uom6_v   = inte(wdetail.si)
        sic_bran.uwm130.uom7_v   = inte(wdetail.si)
        sic_bran.uwm130.uom1_v   = nv_uom1_v /*deci(wdetail.deductpp) */ 
        sic_bran.uwm130.uom2_v   = nv_uom2_v /*deci(wdetail.deductba) */ 
        sic_bran.uwm130.uom5_v   = nv_uom5_v /*deci(wdetail.deductpa)   A55-301*/  
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN
        sic_bran.uwm130.uom1_c  = "D1"
        sic_bran.uwm130.uom2_c  = "D2"
        sic_bran.uwm130.uom5_c  = "D5"
        sic_bran.uwm130.uom6_c  = "D6"
        sic_bran.uwm130.uom7_c  = "D7"
        sic_bran.uwm130.uom1_v   = nv_uom1_v /*deci(wdetail.deductpp) */           
        sic_bran.uwm130.uom2_v   = nv_uom2_v /*deci(wdetail.deductba) */           
        sic_bran.uwm130.uom5_v   = nv_uom5_v /*deci(wdetail.deductpa)   A55-301*/       
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = inte(wdetail.si)
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN
        wdetail.benname          = ""
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.poltyp = "v72" THEN DO: 
        IF (wdetail.subclass = "210") OR (wdetail.subclass = "140A") THEN 
            n_sclass72 = "140A".
        ELSE n_sclass72 = "110".
    END.
    ELSE n_sclass72 = wdetail.prempa + wdetail.subclass .
    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = wdetail.covcod No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do: 
            ASSIGN      /*stat.clastab_fil.uom5_si*/
            sic_bran.uwm130.uom1_v     =  stat.clastab_fil.uom1_si        
            sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si        
            sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si 
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0 
            /*nv_uom1_v /*deci(wdetail.deductpp) */           =  string(stat.clastab_fil.uom1_si)
            nv_uom2_v /*deci(wdetail.deductba) */           =  string(stat.clastab_fil.uom2_si)
            nv_uom5_v /*deci(wdetail.deductpa)   A55-301*/  =  string(stat.clastab_fil.uom5_si) */  
            nv_uom1_v                  =  deci(stat.clastab_fil.uom1_si)  
            nv_uom2_v                  =  deci(stat.clastab_fil.uom2_si)  
            nv_uom5_v                  =  deci(stat.clastab_fil.uom5_si)      
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".
        IF wdetail.prempa = "Z"  THEN DO:
            FIND FIRST brstat.insure USE-INDEX insure03 WHERE 
                brstat.insure.compno = n_campaign     AND
                brstat.Insure.FName  = n_sclass72      NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL brstat.insure THEN 
                ASSIGN 
                nv_uom1_v /*deci(wdetail.deductpp) */          =  deci(Insure.LName)   
                nv_uom2_v /*deci(wdetail.deductba) */          =  deci(Insure.Addr1)   
                nv_uom5_v /*deci(wdetail.deductpa) A55-301*/   =  deci(Insure.Addr2)    
                wdetail.no_41              =  Insure.Addr3   
                wdetail.no_42              =  Insure.Addr4   
                wdetail.no_43              =  Insure.TelNo
                sic_bran.uwm130.uom1_v     = deci(Insure.LName)      /*stat.clastab_fil.uom1_si*/
                sic_bran.uwm130.uom2_v     = deci(Insure.Addr1)      /*stat.clastab_fil.uom2_si*/
                sic_bran.uwm130.uom5_v     = deci(Insure.Addr2)
              /*nv_uom1_v                  = deci(wdetail.deductpp)   
                nv_uom2_v                  = deci(wdetail.deductba) 
                nv_uom5_v                  = deci(wdetail.deductpa)301*/ .
            ELSE DO:
                ASSIGN 
                    nv_uom1_v /*deci(wdetail.deductpp) */           =  500000
                    nv_uom2_v /*deci(wdetail.deductba) */           =  10000000
                    nv_uom5_v /*deci(wdetail.deductpa)   A55-301*/  =  1000000 
                    wdetail.no_41          =  "100000"
                    wdetail.no_42          =  "100000"
                    wdetail.no_43          =  "200000"
                    sic_bran.uwm130.uom1_v = nv_uom1_v   /*deci(wdetail.deductpp) */            /*stat.clastab_fil.uom1_si*/
                    sic_bran.uwm130.uom2_v = nv_uom2_v   /*deci(wdetail.deductba) */            /*stat.clastab_fil.uom2_si*/
                    sic_bran.uwm130.uom5_v = nv_uom5_v   /*deci(wdetail.deductpa)   A55-301*/   /*stat.clastab_fil.uom5_si*/
                    /*nv_uom1_v              = deci(wdetail.deductpp)   
                    nv_uom2_v              = deci(wdetail.deductba) 
                    nv_uom5_v              = deci(wdetail.deductpa)   301*/  .
            END.
    END.
    ELSE DO:
        If  wdetail.garage  =  ""  Then
                Assign 
                wdetail.no_41   =  string(stat.clastab_fil.si_41unp)
                wdetail.no_42   =  string(stat.clastab_fil.si_42)
                wdetail.no_43   =  string(stat.clastab_fil.si_43)
                wdetail.seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
            Else If  wdetail.garage  =  "G"  Then
                Assign 
                wdetail.no_41    = string(stat.clastab_fil.si_41pai)
                wdetail.no_42    =   string(stat.clastab_fil.si_42)    
                wdetail.no_43    =   string(stat.clastab_fil.impsi_43)  
                wdetail.seat41   =   stat.clastab_fil.dri_41 + clastab_fil.pass_41.  
        END.
     
    END.           
    ASSIGN
        nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                         nv_riskno,
                         nv_itemno).
    END.  /* end Do transaction*/
    ASSIGN 
    s_recid3  = RECID(sic_bran.uwm130) 
    nv_covcod = wdetail.covcod 
    nv_makdes = wdetail.brand 
    nv_newsck = " ".
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
             sic_bran.uwm301.eng_no    = wdetail.eng
             sic_bran.uwm301.modcod    = wdetail.redbook
             sic_bran.uwm301.Tons      = INTEGER(wdetail.weight)
             sic_bran.uwm301.engine    = INTEGER(wdetail.cc)
             sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
             sic_bran.uwm301.garage    = wdetail.garage
             sic_bran.uwm301.logbok    = IF      (wdetail.typecar = "ป้ายแดง") THEN ""      /* Inspection = N */
                                         ELSE IF (wdetail.typecar = "รถใหม่")  THEN ""
                                         ELSE IF  wdetail.poltyp  = "V72"      THEN ""
                                         ELSE IF (wdetail.covcod = "1")        THEN "N"
                                         ELSE ""
             sic_bran.uwm301.body      = wdetail.body
             sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
             sic_bran.uwm301.mv_ben83  = wdetail.benname
             sic_bran.uwm301.vehreg    = wdetail.vehreg
             sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
             sic_bran.uwm301.vehuse    = wdetail.vehuse
             sic_bran.uwm301.vehgrp    = wdetail.cargrp  
             sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
             sic_bran.uwm301.sckno     = 0
             sic_bran.uwm301.itmdel    = NO
             sic_bran.uwm301.prmtxt    = IF (wdetail.poltyp = "v70") AND (wdetail.covcod = "1") THEN "คุ้มครองอุปกรณ์ตกแต่งราคาไม่เกิน 30,000 บาท" ELSE ""
             wdetail.tariff            = sic_bran.uwm301.tariff.
         s_recid4                      = RECID(sic_bran.uwm301).
      
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
    nv_dss_per = 0     
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
/*****A52-0172
If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0.
/*-----nv_drivcod---------------------*/
nv_drivvar1 = wdetail.drivername1.
nv_drivvar2 = wdetail.drivername2.
IF wdetail.drivername1 <> ""   THEN DO:  
    ASSIGN nv_drivno = 1
    wdetail.drivnam  = "y".
END.
ELSE wdetail.drivnam  = "N".
IF wdetail.drivername2 <> ""   THEN  nv_drivno = 2.  /*A52-0172*/
ELSE IF wdetail.drivername1 = "" AND wdetail.drivername2 = "" THEN  nv_drivno = 0.   /*A52-0172*/
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
           End.
  Assign
          nv_drivvar     = " "
          nv_drivvar1    = "     Driver name person = "
          nv_drivvar2    = String(nv_drivno)
          Substr(nv_drivvar,1,30)  = nv_drivvar1
          Substr(nv_drivvar,31,30) = nv_drivvar2.
  RUN proc_usdcod.  
END.  /*-------nv_baseprm----------*/
RUN wgs\wgsfbas.  /*25/09/2006 add condition base in range*/
IF NO_basemsg <> " " THEN 
    wdetail.WARNING = no_basemsg.
IF nv_baseprm = 0  Then do:
      Message  " Base Premium is Mandatory field. "  View-as alert-box.
      ASSIGN
      wdetail.pass    = "N"
      wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".
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
   nv_41 =  deci(wdetail.no_41)  
   nv_42 =  deci(wdetail.no_42)  
   nv_43 =  deci(wdetail.no_43) 
   nv_seat41 = integer(wdetail.seat41).
  RUN WGS\WGSOPER(INPUT nv_tariff, 
                                nv_class,
                                nv_key_b,
                                nv_comdat).  
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
RUN wgs\wgsoeng.  /*a490166 note modi*/
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
  DEF VAR dod0 AS INTEGER.
  DEF VAR dod1 AS INTEGER.
  DEF VAR dod2 AS INTEGER.
  DEF VAR dpd0 AS INTEGER.
  dod0 = inte(wdetail.deductda).
  IF dod0 > 3000 THEN DO:
      dod1 = 3000.
      dod2 = dod0 - dod1.
  END.
      ASSIGN
         nv_odcod    = "DC01"
         nv_prem     =   dod1. 
 RUN Wgs\Wgsmx024( nv_tariff,/*a490166 note modi*/
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
  /*---------- fleet -------------------*//*A52-0172
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
           nv_fletvar  = " ".         --------------- A52-0172*/
/*---------------- NCB -------------------*/
DEF VAR nv_ncbyrs AS INTE.
NV_NCBPER = INTE(WDETAIL.NCB).
nv_ncbvar = " ".
If nv_ncbper  <> 0 Then do:
    Find first sicsyac.xmm104 Use-index xmm10401 Where
        sicsyac.xmm104.tariff = nv_tariff      AND
        sicsyac.xmm104.class  = nv_class       AND
        sicsyac.xmm104.covcod = nv_covcod      AND
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
/*-------------- load claim ---------------------*//***A52-0172
        nv_cl_per  = deci(wdetail.loadclm).
        nv_clmvar  = " ".
        IF nv_cl_per  <> 0  THEN
           Assign 
                  nv_clmvar1   = " Load Claim % = "
                  nv_clmvar2   =  STRING(nv_cl_per)
                  SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
                  SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
         RUN WGS\WGSORPRM.P (INPUT  nv_tariff, 
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
                  SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.  ***A52-0172*/
    /*------------------ dsspc ---------------*/
nv_dsspcvar   = " ".
IF  nv_dss_per   <> 0  THEN
    Assign
    nv_dsspcvar1   = "     Discount Special % = "
    nv_dsspcvar2   =  STRING(nv_dss_per)
    SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
    SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.    --A52-0172*/
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
/*IF nv_gapprm <> inte(wdetail.premt) THEN  DO:
    MESSAGE "เบี้ยไม่ตรงกับเบี้ยที่คำนวณได้" + wdetail.premt + " <> " + STRING(nv_gapprm) VIEW-AS ALERT-BOX.
    ASSIGN 
        wdetail.WARNING  = "เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้"
        wdetail.comment  = wdetail.comment + "| gen เข้าระบบได้แต่เบี้ยไม่ตรงกับที่โปรแกรมคำนวณได้ "
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
        sic_bran.uwm301.mv41seat = inte(wdetail.seat).
  
RUN WGS\WGSTN132(INPUT S_RECID3, 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest41 C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest_4 C-Win 
PROCEDURE proc_chktest_4 :
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
     ASSIGN nv_com1p = 0.00.  /*งาน kk ให้ค่า  com1A = 0.00 */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create100 C-Win 
PROCEDURE proc_create100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Create  sic_bran.uwm100.      /*Create ฝั่ง gateway*/    
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createcam C-Win 
PROCEDURE proc_createcam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wcam.
    DELETE wcam.
END.
/*comment by Kridtiya i. A56-0118....
CREATE wcam.
ASSIGN wcam.campan = "C55/00182"
       wcam.cover = "1" .
 
CREATE wcam.
ASSIGN wcam.campan = "C55/00183"
       wcam.cover = "2".
CREATE wcam.
ASSIGN wcam.campan = "C55/00036"
       wcam.cover = "1"
    wcam.brand    = "CHEVROLET" .
end..comment by Kridtiya i. A56-0118....*/
/*Add  Kridtiya i. A56-0118....*/
FOR EACH brstat.insure USE-INDEX insure01 WHERE
    brstat.insure.compno = fi_camname NO-LOCK. 
    FIND LAST wcam WHERE wcam.campan = Insure.InsNo  NO-ERROR NO-WAIT.
    IF NOT AVAIL wcam THEN DO:
        CREATE wcam.
        ASSIGN 
            wcam.campan = Insure.InsNo
            wcam.cover  = insure.vatcode 
            wcam.brand  = insure.Text2  .
    END.
END.
/*end..Add Kridtiya i. A56-0118....*/

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
DEF BUFFER buwm100 FOR wdetail.
    ASSIGN nc_r2 = "" .
    IF wdetail.cedpol = " "    THEN DO:
        FOR EACH buwm100 WHERE 
            buwm100.insnam  = wdetail.insnam  AND
            buwm100.policy <> wdetail.policy  AND 
            buwm100.poltyp <> wdetail.poltyp NO-LOCK.
            ASSIGN 
                nc_r2 = buwm100.policy.
        END.
    END.
    ELSE DO:
        FOR EACH buwm100 WHERE 
            buwm100.cedpol  = wdetail.cedpol  AND
            buwm100.policy <> wdetail.policy  AND 
            buwm100.poltyp <> wdetail.poltyp NO-LOCK.
            ASSIGN 
                nc_r2 = buwm100.policy.
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
    wdetail.prepol = nv_c .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dsp_ncb C-Win 
PROCEDURE proc_dsp_ncb :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    WDETAIL.NCB = "".
IF wdetail.subclass = "110" THEN DO:
    WDETAIL.NCB = "40".
    IF wdetail.si = "100,000.00"    THEN ASSIGN nv_dss_per = 28.69. 
    IF wdetail.si = "110,000.00"    THEN ASSIGN nv_dss_per = 28.57.  
    IF wdetail.si = "120,000.00"    THEN ASSIGN nv_dss_per = 28.36.  
    IF wdetail.si = "130,000.00"    THEN ASSIGN nv_dss_per = 28.25.  
    IF wdetail.si = "140,000.00"    THEN ASSIGN nv_dss_per = 28.10.  
    IF wdetail.si = "150,000.00"    THEN ASSIGN nv_dss_per = 27.94.  
    IF wdetail.si = "160,000.00"    THEN ASSIGN nv_dss_per = 27.84.  
    IF wdetail.si = "170,000.00"    THEN ASSIGN nv_dss_per = 27.77.  
    IF wdetail.si = "180,000.00"    THEN ASSIGN nv_dss_per = 27.59.  
    IF wdetail.si = "190,000.00"    THEN ASSIGN nv_dss_per = 27.45.  
    IF wdetail.si = "200,000.00"    THEN ASSIGN nv_dss_per = 27.38.  
    IF wdetail.si = "210,000.00"    THEN ASSIGN nv_dss_per = 27.24.  
    IF wdetail.si = "220,000.00"    THEN ASSIGN nv_dss_per = 27.10.  
    IF wdetail.si = "230,000.00"    THEN ASSIGN nv_dss_per = 27.01.  
    IF wdetail.si = "240,000.00"    THEN ASSIGN nv_dss_per = 26.88.  
    IF wdetail.si = "250,000.00"    THEN ASSIGN nv_dss_per = 26.75.  
    IF wdetail.si = "260,000.00"    THEN ASSIGN nv_dss_per = 26.66.  
    IF wdetail.si = "270,000.00"    THEN ASSIGN nv_dss_per = 26.49.  
    IF wdetail.si = "280,000.00"    THEN ASSIGN nv_dss_per = 26.44.  
    IF wdetail.si = "290,000.00"    THEN ASSIGN nv_dss_per = 26.36.  
    IF wdetail.si = "300,000.00"    THEN ASSIGN nv_dss_per = 26.20.  
    IF wdetail.si = "310,000.00"    THEN ASSIGN nv_dss_per = 26.16.  
    IF wdetail.si = "320,000.00"    THEN ASSIGN nv_dss_per = 26.04.  
    IF wdetail.si = "330,000.00"    THEN ASSIGN nv_dss_per = 25.92.  
    IF wdetail.si = "340,000.00"    THEN ASSIGN nv_dss_per = 25.84.  
    IF wdetail.si = "350,000.00"    THEN ASSIGN nv_dss_per = 25.73.  
    IF wdetail.si = "360,000.00"    THEN ASSIGN nv_dss_per = 25.62.  
    IF wdetail.si = "370,000.00"    THEN ASSIGN nv_dss_per = 25.55.  
    IF wdetail.si = "380,000.00"    THEN ASSIGN nv_dss_per = 25.40.  
    IF wdetail.si = "390,000.00"    THEN ASSIGN nv_dss_per = 25.36.  
    IF wdetail.si = "400,000.00"    THEN ASSIGN nv_dss_per = 25.25.  
    IF wdetail.si = "410,000.00"    THEN ASSIGN nv_dss_per = 25.12.
    IF wdetail.si = "420,000.00"    THEN ASSIGN nv_dss_per = 25.08.  
    IF wdetail.si = "430,000.00"    THEN ASSIGN nv_dss_per = 25.02.  
    IF wdetail.si = "440,000.00"    THEN ASSIGN nv_dss_per = 24.92.  
    IF wdetail.si = "450,000.00"    THEN ASSIGN nv_dss_per = 24.85.  
    IF wdetail.si = "460,000.00"    THEN ASSIGN nv_dss_per = 24.76.  
    IF wdetail.si = "470,000.00"    THEN ASSIGN nv_dss_per = 24.66.  
    IF wdetail.si = "480,000.00"    THEN ASSIGN nv_dss_per = 24.56.  
    IF wdetail.si = "490,000.00"    THEN ASSIGN nv_dss_per = 24.51.  
    IF wdetail.si = "500,000.00"    THEN ASSIGN nv_dss_per = 24.44. 
END.
ELSE IF wdetail.subclass = "210" THEN DO:
    WDETAIL.NCB = "50".
    IF wdetail.si = "100,000.00"    THEN ASSIGN nv_dss_per =  52.62  .  
    IF wdetail.si = "110,000.00"    THEN ASSIGN nv_dss_per =  53.03  .  
    IF wdetail.si = "120,000.00"    THEN ASSIGN nv_dss_per =  53.32  .  
    IF wdetail.si = "130,000.00"    THEN ASSIGN nv_dss_per =  53.68  .  
    IF wdetail.si = "140,000.00"    THEN ASSIGN nv_dss_per =  54.00  . 
    IF wdetail.si = "150,000.00"    THEN ASSIGN nv_dss_per =  54.30  .  
    IF wdetail.si = "160,000.00"    THEN ASSIGN nv_dss_per =  54.27  . 
    IF wdetail.si = "170,000.00"    THEN ASSIGN nv_dss_per =  54.23  .  
    IF wdetail.si = "180,000.00"    THEN ASSIGN nv_dss_per =  54.18  .  
    IF wdetail.si = "190,000.00"    THEN ASSIGN nv_dss_per =  54.14  .  
    IF wdetail.si = "200,000.00"    THEN ASSIGN nv_dss_per =  54.11  .  
    IF wdetail.si = "210,000.00"    THEN ASSIGN nv_dss_per =  54.06  .  
    IF wdetail.si = "220,000.00"    THEN ASSIGN nv_dss_per =  54.00  .  
    IF wdetail.si = "230,000.00"    THEN ASSIGN nv_dss_per =  53.97  .  
    IF wdetail.si = "240,000.00"    THEN ASSIGN nv_dss_per =  53.90  .  
    IF wdetail.si = "250,000.00"    THEN ASSIGN nv_dss_per =  53.83  .  
    IF wdetail.si = "260,000.00"    THEN ASSIGN nv_dss_per =  53.81  .  
    IF wdetail.si = "270,000.00"    THEN ASSIGN nv_dss_per =  53.73  .  
    IF wdetail.si = "280,000.00"    THEN ASSIGN nv_dss_per =  53.70  .  
    IF wdetail.si = "290,000.00"    THEN ASSIGN nv_dss_per =  53.68  .  
    IF wdetail.si = "300,000.00"    THEN ASSIGN nv_dss_per =  53.65  .  
    IF wdetail.si = "310,000.00"    THEN ASSIGN nv_dss_per =  53.63  .  
    IF wdetail.si = "320,000.00"    THEN ASSIGN nv_dss_per =  53.56  .  
    IF wdetail.si = "330,000.00"    THEN ASSIGN nv_dss_per =  53.51  .  
    IF wdetail.si = "340,000.00"    THEN ASSIGN nv_dss_per =  53.48  .  
    IF wdetail.si = "350,000.00"    THEN ASSIGN nv_dss_per =  53.46  .  
    IF wdetail.si = "360,000.00"    THEN ASSIGN nv_dss_per =  53.39  .  
    IF wdetail.si = "370,000.00"    THEN ASSIGN nv_dss_per =  53.36  .  
    IF wdetail.si = "380,000.00"    THEN ASSIGN nv_dss_per =  53.30  .  
    IF wdetail.si = "390,000.00"    THEN ASSIGN nv_dss_per =  53.29  .  
    IF wdetail.si = "400,000.00"    THEN ASSIGN nv_dss_per =  53.23  .
    IF wdetail.si = "410,000.00"    THEN ASSIGN nv_dss_per =  53.21  .  
    IF wdetail.si = "420,000.00"    THEN ASSIGN nv_dss_per =  53.19  .  
    IF wdetail.si = "430,000.00"    THEN ASSIGN nv_dss_per =  53.17  .  
    IF wdetail.si = "440,000.00"    THEN ASSIGN nv_dss_per =  53.11  .  
    IF wdetail.si = "450,000.00"    THEN ASSIGN nv_dss_per =  53.09  .  
    IF wdetail.si = "460,000.00"    THEN ASSIGN nv_dss_per =  53.07  .  
    IF wdetail.si = "470,000.00"    THEN ASSIGN nv_dss_per =  53.03  .  
    IF wdetail.si = "480,000.00"    THEN ASSIGN nv_dss_per =  52.96  .  
    IF wdetail.si = "490,000.00"    THEN ASSIGN nv_dss_per =  52.94  .  
    IF wdetail.si = "500,000.00"    THEN ASSIGN nv_dss_per =  52.92  .
END.                 
ELSE IF wdetail.subclass = "320" THEN DO:
    /*WDETAIL.NCB = "50".*/
    WDETAIL.NCB = "40".
    /* comment by kridtiya i. A54-0344...
    IF wdetail.si = "100,000.00"    THEN ASSIGN nv_dss_per = 40.98.  
    IF wdetail.si = "110,000.00"    THEN ASSIGN nv_dss_per = 41.03.  
    IF wdetail.si = "120,000.00"    THEN ASSIGN nv_dss_per = 40.93.  
    IF wdetail.si = "130,000.00"    THEN ASSIGN nv_dss_per = 40.95.  
    IF wdetail.si = "140,000.00"    THEN ASSIGN nv_dss_per = 40.91.  
    IF wdetail.si = "150,000.00"    THEN ASSIGN nv_dss_per = 40.90.  
    IF wdetail.si = "160,000.00"    THEN ASSIGN nv_dss_per = 40.93.  
    IF wdetail.si = "170,000.00"    THEN ASSIGN nv_dss_per = 40.93.  
    IF wdetail.si = "180,000.00"    THEN ASSIGN nv_dss_per = 40.90.  
    IF wdetail.si = "190,000.00"    THEN ASSIGN nv_dss_per = 40.90.  
    IF wdetail.si = "200,000.00"    THEN ASSIGN nv_dss_per = 40.93.  
    IF wdetail.si = "210,000.00"    THEN ASSIGN nv_dss_per = 40.90.  
    IF wdetail.si = "220,000.00"    THEN ASSIGN nv_dss_per = 40.87.  
    IF wdetail.si = "230,000.00"    THEN ASSIGN nv_dss_per = 40.90.  
    IF wdetail.si = "240,000.00"    THEN ASSIGN nv_dss_per = 40.84.  
    IF wdetail.si = "250,000.00"    THEN ASSIGN nv_dss_per = 40.81. 
    IF wdetail.si = "260,000.00"    THEN ASSIGN nv_dss_per = 40.83.  
    IF wdetail.si = "270,000.00"    THEN ASSIGN nv_dss_per = 40.77.  
    IF wdetail.si = "280,000.00"    THEN ASSIGN nv_dss_per = 40.80.  
    IF wdetail.si = "290,000.00"    THEN ASSIGN nv_dss_per = 40.82.  
    IF wdetail.si = "300,000.00"    THEN ASSIGN nv_dss_per = 40.80.  
    IF wdetail.si = "310,000.00"    THEN ASSIGN nv_dss_per = 40.82.  
    IF wdetail.si = "320,000.00"    THEN ASSIGN nv_dss_per = 40.76.  
    IF wdetail.si = "330,000.00"    THEN ASSIGN nv_dss_per = 40.75.  
    IF wdetail.si = "340,000.00"    THEN ASSIGN nv_dss_per = 40.77.  
    IF wdetail.si = "350,000.00"    THEN ASSIGN nv_dss_per = 40.77.  
    IF wdetail.si = "360,000.00"    THEN ASSIGN nv_dss_per = 40.73.  
    IF wdetail.si = "370,000.00"    THEN ASSIGN nv_dss_per = 40.75.  
    IF wdetail.si = "380,000.00"    THEN ASSIGN nv_dss_per = 40.69.  
    IF wdetail.si = "390,000.00"    THEN ASSIGN nv_dss_per = 40.75.  
    IF wdetail.si = "400,000.00"    THEN ASSIGN nv_dss_per = 40.68.
    IF wdetail.si = "410,000.00"    THEN ASSIGN nv_dss_per = 40.70.  
    IF wdetail.si = "420,000.00"    THEN ASSIGN nv_dss_per = 40.71.  
    IF wdetail.si = "430,000.00"    THEN ASSIGN nv_dss_per = 40.73.  
    IF wdetail.si = "440,000.00"    THEN ASSIGN nv_dss_per = 40.68.  
    IF wdetail.si = "450,000.00"    THEN ASSIGN nv_dss_per = 40.69.  
    IF wdetail.si = "460,000.00"    THEN ASSIGN nv_dss_per = 40.70.  
    IF wdetail.si = "470,000.00"    THEN ASSIGN nv_dss_per = 40.70.  
    IF wdetail.si = "480,000.00"    THEN ASSIGN nv_dss_per = 40.65.  
    IF wdetail.si = "490,000.00"    THEN ASSIGN nv_dss_per = 40.65.  
    IF wdetail.si = "500,000.00"    THEN ASSIGN nv_dss_per = 40.68.
    end...comment by kridtiya i. A54-0344....*/
    RUN proc_dsp_ncb2.
END.                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dsp_ncb2 C-Win 
PROCEDURE proc_dsp_ncb2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* add by kridtiya i. A54-0344...*/
         IF wdetail.si = "100,000.00"    THEN ASSIGN nv_dss_per = 41.69.  
    /*ELSE IF wdetail.si = "100000"        THEN ASSIGN nv_dss_per = 41.69. */ 
    ELSE IF wdetail.si = "100000"        THEN ASSIGN nv_dss_per = 7.06. 
    ELSE IF wdetail.si = "110,000.00"    THEN ASSIGN nv_dss_per = 41.75.  
    ELSE IF wdetail.si = "120,000.00"    THEN ASSIGN nv_dss_per = 41.67.  
    ELSE IF wdetail.si = "130,000.00"    THEN ASSIGN nv_dss_per = 41.67.  
    ELSE IF wdetail.si = "140,000.00"    THEN ASSIGN nv_dss_per = 41.65.  
    ELSE IF wdetail.si = "150,000.00"    THEN ASSIGN nv_dss_per = 41.63.  
    ELSE IF wdetail.si = "160,000.00"    THEN ASSIGN nv_dss_per = 41.63.  
    ELSE IF wdetail.si = "170,000.00"    THEN ASSIGN nv_dss_per = 41.65.  
    ELSE IF wdetail.si = "180,000.00"    THEN ASSIGN nv_dss_per = 41.63.  
    ELSE IF wdetail.si = "190,000.00"    THEN ASSIGN nv_dss_per = 41.63.  
    ELSE IF wdetail.si = "200,000.00"    THEN ASSIGN nv_dss_per = 41.63.  
    ELSE IF wdetail.si = "210,000.00"    THEN ASSIGN nv_dss_per = 41.61.  
    ELSE IF wdetail.si = "220,000.00"    THEN ASSIGN nv_dss_per = 41.59.  
    ELSE IF wdetail.si = "230,000.00"    THEN ASSIGN nv_dss_per = 41.59.  
    ELSE IF wdetail.si = "240,000.00"    THEN ASSIGN nv_dss_per = 41.57.  
    ELSE IF wdetail.si = "250,000.00"    THEN ASSIGN nv_dss_per = 41.55. 
    ELSE IF wdetail.si = "260,000.00"    THEN ASSIGN nv_dss_per = 41.55.  
    ELSE IF wdetail.si = "270,000.00"    THEN ASSIGN nv_dss_per = 41.51.  
    ELSE IF wdetail.si = "280,000.00"    THEN ASSIGN nv_dss_per = 41.51.  
    ELSE IF wdetail.si = "290,000.00"    THEN ASSIGN nv_dss_per = 41.51.  
    ELSE IF wdetail.si = "300,000.00"    THEN ASSIGN nv_dss_per = 41.53.  
    ELSE IF wdetail.si = "310,000.00"    THEN ASSIGN nv_dss_per = 41.53.  
    ELSE IF wdetail.si = "320,000.00"    THEN ASSIGN nv_dss_per = 41.50.  
    ELSE IF wdetail.si = "330,000.00"    THEN ASSIGN nv_dss_per = 41.47.  
    ELSE IF wdetail.si = "340,000.00"    THEN ASSIGN nv_dss_per = 41.49.  
    ELSE IF wdetail.si = "350,000.00"    THEN ASSIGN nv_dss_per = 41.49.  
    ELSE IF wdetail.si = "360,000.00"    THEN ASSIGN nv_dss_per = 41.47.  
    ELSE IF wdetail.si = "370,000.00"    THEN ASSIGN nv_dss_per = 41.47.  
    ELSE IF wdetail.si = "380,000.00"    THEN ASSIGN nv_dss_per = 41.43.  
    ELSE IF wdetail.si = "390,000.00"    THEN ASSIGN nv_dss_per = 41.45.  
    ELSE IF wdetail.si = "400,000.00"    THEN ASSIGN nv_dss_per = 41.43.
    ELSE IF wdetail.si = "410,000.00"    THEN ASSIGN nv_dss_per = 41.43.  
    ELSE IF wdetail.si = "420,000.00"    THEN ASSIGN nv_dss_per = 41.43.  
    ELSE IF wdetail.si = "430,000.00"    THEN ASSIGN nv_dss_per = 41.43.  
    ELSE IF wdetail.si = "440,000.00"    THEN ASSIGN nv_dss_per = 41.40.  
    ELSE IF wdetail.si = "450,000.00"    THEN ASSIGN nv_dss_per = 41.40.  
    ELSE IF wdetail.si = "460,000.00"    THEN ASSIGN nv_dss_per = 41.42.  
    ELSE IF wdetail.si = "470,000.00"    THEN ASSIGN nv_dss_per = 41.41.  
    ELSE IF wdetail.si = "480,000.00"    THEN ASSIGN nv_dss_per = 41.37.  
    ELSE IF wdetail.si = "490,000.00"    THEN ASSIGN nv_dss_per = 41.37.  
    ELSE IF wdetail.si = "500,000.00"    THEN ASSIGN nv_dss_per = 41.39.
    /*end...add by kridtiya i. A54-0344....*/
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
    n_insref     = ""  
    nv_messagein  = ""
    nv_usrid    = ""
    nv_transfer = NO
    n_check     = ""
    nv_insref   = ""
    putchr      = "" 
    putchr1     = ""
    nv_typ      = ""
    nv_usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4) 
    nv_transfer = YES.
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME   = TRIM(wdetail.insnam)  AND 
    /*sicsyac.xmm600.homebr = TRIM(wdetail.branch) NO-ERROR NO-WAIT.  *//*A56-0047 */
    sicsyac.xmm600.homebr = TRIM(wdetail.branch)  AND  /*A56-0047 Add check sicsyac.xmm600.clicod = "IN" */
    sicsyac.xmm600.clicod = "IN"  NO-ERROR NO-WAIT.     /*A56-0047 Add check sicsyac.xmm600.clicod = "IN" */
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
    END.
    n_insref = nv_insref.
END.
ELSE DO:  /* กรณีพบ */
    IF sicsyac.xmm600.acno <> "" THEN    /* A55-0268 */
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
        /*sicsyac.xmm600.dtyp20   = "DOB"    /*A56-0081 */
        sicsyac.xmm600.dval20   = trim(wdetail.brithday)*/ /*A56-0081 */
        sicsyac.xmm600.dtyp20   = ""   /*A56-0081 */
        sicsyac.xmm600.dval20   = ""   /*A56-0081 */  .
    /*RETURN.*/
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
    /*IF INDEX(wdetail.brithday,"DOBEXP") <> 0 THEN  
        ASSIGN
        xmm600.dtyp20 = "DOB" + "EXP"
        xmm600.dval20 = substr(wdetail.brithday,7).
    ELSE IF INDEX(wdetail.brithday,"DOBEXP") = 0 THEN
        ASSIGN
        xmm600.dtyp20 = ""
        xmm600.dval20 = "".
    ELSE IF  (INDEX(wdetail.brithday,"EXP") <> 0) AND (INDEX(wdetail.brithday,"DOB") = 0) THEN  
        ASSIGN
        xmm600.dtyp20 = "EXP"
        xmm600.dval20 = substr(wdetail.brithday,INDEX(wdetail.brithday,"EXP") + 3 ).
    ELSE IF  (INDEX(wdetail.brithday,"EXP") = 0) AND (INDEX(wdetail.brithday,"DOB") <> 0) THEN*/
        /*sicsyac.xmm600.dtyp20 = "DOB"
        sicsyac.xmm600.dval20 =  wdetail.brithday .         /*string(wdetail.brithday).*/*/
        /*sicsyac.xmm600.dtyp20   = "DOB"    /*A56-0081 */
        sicsyac.xmm600.dval20   = trim(wdetail.brithday)*/ /*A56-0081 */
        sicsyac.xmm600.dtyp20   = ""   /*A56-0081 */
        sicsyac.xmm600.dval20   = "" .  /*A56-0081 */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insno C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_mailtxt C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab C-Win 
PROCEDURE proc_maktab :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Find FIRST stat.maktab_fil Use-index      maktab04          Where
    stat.maktab_fil.makdes   =     wdetail.brand            And                  
    index(stat.maktab_fil.moddes,n_model) <> 0             And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
    stat.maktab_fil.engine   =     Integer(wdetail.cc)    AND 
    /*stat.maktab_fil.sclass    =     wdetail.subclass        AND*/
   (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
    stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
    stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    ASSIGN wdetail.redbook =  stat.maktab_fil.modcod 
    nv_modcod              =  stat.maktab_fil.modcod 
    wdetail.brand          =  stat.maktab_fil.makdes  
    wdetail.model          =  stat.maktab_fil.moddes
    wdetail.cargrp         =  stat.maktab_fil.prmpac
    wdetail.body           =  stat.maktab_fil.body 
    wdetail.cc             =  STRING(stat.maktab_fil.engine)
    wdetail.cargrp         =  stat.maktab_fil.prmpac
    wdetail.seat           =  string(stat.maktab_fil.seats) .
ELSE nv_modcod = "".
IF nv_modcod = "" THEN DO:
    FIND FIRST stat.insure USE-INDEX insure01  WHERE   
        stat.insure.compno = fi_model             AND          
        stat.insure.fname  = trim(wdetail.model)        NO-ERROR NO-WAIT.
    IF AVAIL stat.insure THEN  ASSIGN n_model   =  stat.insure.lname   .
    ELSE  ASSIGN n_model = "".
    IF n_model <> "" THEN DO :
        Find FIRST stat.maktab_fil Use-index      maktab04          Where
            stat.maktab_fil.makdes   =     trim(wdetail.brand)            And                  
            index(stat.maktab_fil.moddes,n_model) <> 0             And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
            stat.maktab_fil.engine   =     Integer(wdetail.cc)    AND
            stat.maktab_fil.sclass    =     wdetail.subclass        AND 
           (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
            stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
            stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN wdetail.redbook =  stat.maktab_fil.modcod 
            nv_modcod              =  stat.maktab_fil.modcod 
            wdetail.brand          =  stat.maktab_fil.makdes  
            wdetail.model          =  stat.maktab_fil.moddes
            wdetail.cargrp         =  stat.maktab_fil.prmpac
            wdetail.body           =  stat.maktab_fil.body 
            wdetail.cc             =  STRING(stat.maktab_fil.engine)
            wdetail.cargrp         =  stat.maktab_fil.prmpac
            wdetail.seat           =  string(stat.maktab_fil.seats) .
        ELSE ASSIGN nv_modcod = "".
        IF nv_modcod = "" THEN DO:
            Find FIRST stat.maktab_fil Use-index      maktab04          Where
            stat.maktab_fil.makdes   =     trim(wdetail.brand)           And                  
            index(stat.maktab_fil.moddes,n_model) <> 0             And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
             stat.maktab_fil.engine   =     Integer(wdetail.cc)    AND 
            /*stat.maktab_fil.sclass    =     wdetail.subclass        AND */
           (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)    OR
            stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
            stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN wdetail.redbook =  stat.maktab_fil.modcod 
            nv_modcod              =  stat.maktab_fil.modcod 
            wdetail.brand          =  stat.maktab_fil.makdes  
            wdetail.model          =  stat.maktab_fil.moddes
            wdetail.cargrp         =  stat.maktab_fil.prmpac
            wdetail.body           =  stat.maktab_fil.body 
            wdetail.cc             =  STRING(stat.maktab_fil.engine)
            wdetail.cargrp         =  stat.maktab_fil.prmpac
            wdetail.seat           =  string(stat.maktab_fil.seats) .
        END.
        /*IF nv_modcod = "" THEN 
            MESSAGE trim(wdetail.brand) n_model wdetail.si wdetail.subclass INTEGER(wdetail.seat) Integer(wdetail.caryear) 
            VIEW-AS ALERT-BOX.*/
    END.
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
DEF VAR nv_stk70    AS CHAR FORMAT "x(15)" INIT "".
/*DEF VAR n_nameno AS INTE .*/
ASSIGN fi_show = "Check data Premium at cedingpol and create policy......" .
DISP fi_show WITH FRAM fr_main.
IF wdetail.poltyp = "v70" THEN 
    ASSIGN nv_stk70 = wdetail.stk
    wdetail.stk = "".
IF wdetail.policy <> "" THEN DO:
    IF wdetail.stk  <>  ""  THEN DO: 
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol =  wdetail.cedpol  NO-LOCK NO-ERROR NO-WAIT. 
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ((sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ?) OR (sicuw.uwm100.releas = YES)) AND
                (sicuw.uwm100.poltyp =  wdetail.poltyp) THEN 
                ASSIGN wdetail.pass  = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.
        ASSIGN nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.detaitem THEN 
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
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol =  wdetail.cedpol  NO-LOCK NO-ERROR NO-WAIT. 
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ((sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ?) OR (sicuw.uwm100.releas = YES)) AND
                (sicuw.uwm100.poltyp =  wdetail.poltyp) THEN 
                /*MESSAGE "หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว " VIEW-AS ALERT-BOX.*/ 
                    ASSIGN                               
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| เลขที่สัญญานี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            IF wdetail.policy = "" THEN DO:
                RUN proc_temppolicy.
                wdetail.policy  = nv_tmppol.
            END.
            RUN proc_create100. 
        END.   /*policy <> "" & stk = ""*/                 
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
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol =  wdetail.cedpol  NO-LOCK NO-ERROR NO-WAIT. 
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ((sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ?) OR (sicuw.uwm100.releas = YES)) AND
                (sicuw.uwm100.poltyp =  wdetail.poltyp) THEN  
                    ASSIGN
                    wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| เลขที่สัญญานี้ได้ถูกใช้ไปแล้ว "
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
/*ELSE DO:
    FIND FIRST brstat.msgcode WHERE 
        brstat.msgcode.compno  = "999" AND
        brstat.msgcode.MsgDesc = wdetail.tiname   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN  wdetail.tiname  =  trim(brstat.msgcode.branch).
    ELSE wdetail.tiname = "คุณ".
END.*/
IF DECI(substr(wdetail.comdat,7,4)) > (YEAR(TODAY) + 2)  THEN
    wdetail.comdat = substr(wdetail.comdat,1,6) + STRING(DECI(substr(wdetail.comdat,7,4)) - 543).
IF DECI(substr(wdetail.expdat,7,4)) > (YEAR(TODAY) + 3)  THEN
    wdetail.expdat = substr(wdetail.expdat,1,6) + STRING(DECI(substr(wdetail.expdat,7,4)) - 543).
IF wdetail.prepol = "" THEN n_firstdat = wdetail.comdat.
/*/*A56-0310*/
IF R-INDEX(wdetail.tiname,".") <> 0 THEN 
    wdetail.tiname = SUBSTR(wdetail.tiname,R-INDEX(wdetail.tiname,".")).*/
/*IF      trim(wdetail.branch) = ""  THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0268 ....*/
ELSE IF trim(wdetail.branch) = "A" THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0268 ....*/
ELSE IF trim(wdetail.branch) = "B" THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0268 ....*/
ELSE RUN proc_insnam.  *//*A56-0310*/                            /*Add kridtiya i. A55-0257 ....*/
RUN proc_insnam.  /*A56-0310*/
 
DO TRANSACTION:
   ASSIGN
      /*wdetail.comdat =  SUBSTR(wdetail.comdat,1,6) + STRING(INTE(SUBSTR(wdetail.comdat,7,4)) - 543 )
      wdetail.expdat =  SUBSTR(wdetail.expdat,1,6) + STRING(INTE(SUBSTR(wdetail.expdat,7,4)) - 543 )*/
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = trim(wdetail.poltyp)
      sic_bran.uwm100.insref = trim(nv_insref)             /*A55-0301*/
      sic_bran.uwm100.occupn = trim(wdetail.accoup)        /*A55-0301*/
      /*sic_bran.uwm100.opnpol = ""*/
      sic_bran.uwm100.anam2  = trim(wdetail.Icno)          /* ICNO  Cover Note A51-0071 Amparat */
      sic_bran.uwm100.ntitle = trim(wdetail.tiname)            /*"คุณ" */ /*kridtiya i. A54-0203    */           
      sic_bran.uwm100.name1  = TRIM(wdetail.insnam)  
      sic_bran.uwm100.name2  = trim(wdetail.name2)
      sic_bran.uwm100.name3  = ""                 
      sic_bran.uwm100.addr1  = trim(wdetail.iadd1)  
      sic_bran.uwm100.addr2  = trim(wdetail.iadd2)  
      sic_bran.uwm100.addr3  = TRIM(wdetail.iadd3)  
      sic_bran.uwm100.addr4  = trim(wdetail.iadd4)
      sic_bran.uwm100.postcd =  "" 
      sic_bran.uwm100.undyr  = String(Year(today),"9999")   /*   nv_undyr  */
      sic_bran.uwm100.branch = caps(trim(wdetail.branch))                  /* nv_branch  */                        
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
      sic_bran.uwm100.prog   = "wgwkbgen"
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
      sic_bran.uwm100.acno1  = caps(trim(wdetail.producer))   /*  nv_acno1 */   
      sic_bran.uwm100.agent  = caps(trim(wdetail.agent))              /*nv_agent   */   
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
      sic_bran.uwm100.cr_2  =  nc_r2
      sic_bran.uwm100.cr_1  =  wdetail.product
      sic_bran.uwm100.bchyr   = nv_batchyr          
      sic_bran.uwm100.bchno   = nv_batchno          
      sic_bran.uwm100.bchcnt  = nv_batcnt           
      sic_bran.uwm100.prvpol  = trim(wdetail.prepol)     
      sic_bran.uwm100.cedpol  = trim(wdetail.cedpol)
      sic_bran.uwm100.opnpol  = IF wdetail.remak1 = "KTBL แถมประกัน" THEN "แถม" ELSE ""
      sic_bran.uwm100.finint  = ""
      sic_bran.uwm100.bs_cd   = wdetail.vatcode .    /*vat code */ /*A55-0046*/
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
IF wdetail.poltyp = "v70" THEN DO:
    FIND FIRST wcam WHERE 
        wcam.cover = wdetail.covcod AND
        wcam.brand = wdetail.brand  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wcam THEN ASSIGN n_campaign = wcam.campan .
    ELSE ASSIGN n_campaign = "".
    IF n_campaign = ""  THEN DO:
        FIND FIRST wcam WHERE 
            wcam.cover = wdetail.covcod NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL wcam THEN ASSIGN n_campaign = wcam.campan .
        ELSE ASSIGN n_campaign = "".
    END.
    RUN proc_uwd100.
    ASSIGN 
        wdetail.stk = nv_stk70
        nv_stk70 = "".
    RUN proc_uwd102.
    
END.
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
            IF wdetail.subclass = "210"      THEN ASSIGN sic_bran.uwm120.class = "120A".
            ELSE IF wdetail.subclass = "110" THEN ASSIGN sic_bran.uwm120.class = "110".
            ELSE IF wdetail.subclass = "320" THEN ASSIGN sic_bran.uwm120.class = "140A".
            ELSE ASSIGN sic_bran.uwm120.class  =  wdetail.subclass
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
            wdetail.pass       = "N". 
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
FOR EACH wdetail WHERE wdetail.PASS <> "Y"  NO-LOCK:
        NOT_pass = NOT_pass + 1.
END.
IF NOT_pass > 0 THEN DO:
    OUTPUT STREAM ns1 TO value(fi_output2).
    PUT STREAM ns1
        "branch       "   ","   
        "policy       "   ","
        "poltyp       "   ","      
        "redbook      "   ","              
        "brand        "   ","         
        "model        "   ","              
        "producer     "   ","              
        "agent        "   ","        
        "tiname       "   ","             
        "insnam       "   ","             
        "iadd1        "   ","             
        "iadd2        "   ","             
        "iadd3        "   ","             
        "iadd4        "   ","             
        "entdat       "   ","             
        "enttim       "   ","             
        "trandat      "   ","             
        "trantim      "   ","             
        "prepol       "   ","             
        "comdat       "   ","             
        "expdat       "   ","  
        "compul       "   ","            
        "prempa       "   ","            
        "subclass     "   ","            
        "stk           "   ","            
        "seat          "   ","            
        "body          "   ","            
        "cc            "   ","               
        "weight        "   ","               
        "vehreg        "   ","               
        "engno         "   ","               
        "chasno        "   ","               
        "caryear       "   ","               
        "vehuse        "   ","               
        "garage        "   ","               
        "covcod        "   ","       
        "si            "   ","        
        "volprem       "   ","        
        "fleet         "   ","        
        "ncb           "   ","        
        "access        "   ","        
        "deductpp      "   ","        
        "deductba      "   ","        
        "deductpa      "   ","        
        "benname       "   ","        
        "n_IMPORT      "   ","        
        "n_export      "   ","        
        "cancel        "   "," 
        "WARNING       "   ","        
        "comment       "   SKIP.                                                   
    FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"  NO-LOCK :           
        PUT STREAM ns1                                               
            wdetail.branch      ","
            wdetail.policy      ","
            wdetail.poltyp      ","
            wdetail.redbook     "," 
            wdetail.brand       ","  
            wdetail.model       ","
            wdetail.producer    ","   
            wdetail.agent       "," 
            wdetail.tiname      ","
            wdetail.insnam      "," 
            wdetail.iadd1       ","
            wdetail.iadd2       ","
            wdetail.iadd3       ","
            wdetail.iadd4       "," 
            wdetail.entdat      ","
            wdetail.enttim      ","
            wdetail.trandat     ","
            wdetail.trantim     ","
            wdetail.prepol      ","
            wdetail.comdat      "," 
            wdetail.expdat      ","
            wdetail.compul      ","
            wdetail.prempa      "," 
            wdetail.subclass    "," 
            wdetail.stk         "," 
            wdetail.seat        ","  
            wdetail.body        ","  
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
            wdetail.benname     "," 
            wdetail.n_IMPORT    "," 
            wdetail.n_export    "," 
            wdetail.cancel      ","
            wdetail.WARNING     ","
            wdetail.comment    SKIP.  
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
FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  NO-LOCK :
        pass = pass + 1.
END.
IF pass > 0 THEN DO:
OUTPUT STREAM ns2 TO value(fi_output1).
          PUT STREAM NS2
            "branch"   ","   
        "policy"   ","
        "poltyp"   ","      
        "redbook"   ","              
        "brand"   ","         
        "model"   ","              
        "producer"   ","              
        "agent   "   ","        
        "tiname  "   ","             
        "insnam  "   ","             
        "iadd1   "   ","             
        "iadd2   "   ","             
        "iadd3   "   ","             
        "iadd4   "   ","             
        "entdat  "   ","             
        "enttim  "   ","             
        "trandat "   ","             
        "trantim "   ","             
        "prepol  "   ","             
        "comdat  "   ","             
        "expdat  "   ","  
        "compul  "   ","            
        "prempa  "   ","            
        "subclass"   ","            
        "stk     "   ","            
        "seat    "   ","            
        "body    "   ","            
        "cc      "   ","               
        "weight  "   ","               
        "vehreg  "   ","               
        "engno   "   ","               
        "chasno  "   ","               
        "caryear "   ","               
        "vehuse  "   ","               
        "garage  "   ","               
        "covcod  "   ","       
        "si      "   ","        
        "volprem "   ","        
        "fleet   "   ","        
        "ncb     "   ","        
        "access  "   ","        
        "deductpp"   ","        
        "deductba"   ","        
        "deductpa"   ","        
        "benname "   ","        
        "n_IMPORT"   ","        
        "n_export"   ","        
        "cancel  "   "," 
        "WARNING "   ","        
        "comment "   SKIP.      
    FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  NO-LOCK:
        PUT STREAM ns2
        wdetail.branch      ","
            wdetail.policy      ","
            wdetail.poltyp      ","
            wdetail.redbook     "," 
            wdetail.brand       ","  
            wdetail.model       ","
            wdetail.producer    ","   
            wdetail.agent       "," 
            wdetail.tiname      ","
            wdetail.insnam      "," 
            wdetail.iadd1       ","
            wdetail.iadd2       ","
            wdetail.iadd3       ","
            wdetail.iadd4       "," 
            wdetail.entdat      ","
            wdetail.enttim      ","
            wdetail.trandat     ","
            wdetail.trantim     ","
            wdetail.prepol      ","
            wdetail.comdat      "," 
            wdetail.expdat      ","
            wdetail.compul      ","
            wdetail.prempa      "," 
            wdetail.subclass    "," 
            wdetail.stk         "," 
            wdetail.seat        ","  
            wdetail.body        ","  
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
            wdetail.benname     "," 
            wdetail.n_IMPORT    "," 
            wdetail.n_export    "," 
            wdetail.cancel      ","
            wdetail.WARNING     ","
            wdetail.comment    SKIP.  
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
     /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 C-Win 
PROCEDURE proc_uwd100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*create  text (F17) for Query claim....*/
/*
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
    nv_txt1  = "ProductType : " + fi_product
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
*/
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
DO WHILE nv_line1 <= 10:
    CREATE wuppertxt3.                                                                                 
    wuppertxt3.line = nv_line1.                                                                        
    IF nv_line1 = 1  THEN wuppertxt3.txt = IF INDEX(wdetail.nmember,"เลขที่ใบคำขอ : ") <> 0 THEN 
                                              SUBSTR(wdetail.nmember,1,INDEX(wdetail.nmember,"เลขที่ใบคำขอ : ") - 1 )
                                           ELSE wdetail.nmember .                                          
    /*IF nv_line1 = 2  THEN wuppertxt3.txt =  "เลขที่สัญญา   : " +  wdetail.cedpol . */
    IF nv_line1 = 2  THEN wuppertxt3.txt = IF INDEX(wdetail.nmember,"เลขที่ใบคำขอ : ") <> 0 THEN 
                                              SUBSTR(wdetail.nmember,INDEX(wdetail.nmember,"เลขที่ใบคำขอ : "))
                                           ELSE "เลขที่ใบคำขอ : " .
    IF nv_line1 = 3  THEN wuppertxt3.txt =  "STK           : " +  wdetail.stk    .
    IF nv_line1 = 4  THEN wuppertxt3.txt =  "ProductType   : " +  fi_product .
    IF nv_line1 = 5  THEN wuppertxt3.txt =  "เงื่อนไขพิเศษ    : " +  wdetail.remak1 .                                 
    IF nv_line1 = 6  THEN wuppertxt3.txt =  "Campaign no   :  " + n_campaign.     
    /*IF nv_line1 = 7  THEN wuppertxt3.txt =  IF (wdetail.remak1 = "KTBL แถมประกัน")  THEN wdetail.remak1 + " เป็นงานจัดเช่าซื้อ KTB ปีแรกไม่ตรวจสภาพ"  ELSE "" .   *//*A55-0163*/
    IF (index(wdetail.typecar,"รถใหม่") <> 0 ) OR (index(wdetail.typecar,"ป้ายแดง") <> 0) THEN DO:
        IF nv_line1 = 7  THEN wuppertxt3.txt =  IF (wdetail.remak1 = "KTBL แถมประกัน") AND (wdetail.covcod = "1") THEN 
            wdetail.remak1  ELSE "" .   
    END.
    ELSE DO:
        IF nv_line1 = 7  THEN wuppertxt3.txt =  IF (wdetail.remak1 = "KTBL แถมประกัน") AND (wdetail.covcod = "1") THEN 
            wdetail.remak1 + " เป็นงานจัดเช่าซื้อ KTB ปีแรกไม่ตรวจสภาพ"  ELSE "" .  /*A55-0163*/ 
    END.
    IF nv_line1 = 8  THEN wuppertxt3.txt =  wdetail.delerco .   
    IF nv_line1 = 9  THEN wuppertxt3.txt =  wdetail.remak2  .                                           
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile C-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
DEF VAR   n_pol    AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR   n_pol2    AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR   n_branch AS CHAR FORMAT "x(10)" INIT "" .
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1 
    n_branch = "" .

If  substr(fi_outputex,length(fi_outputex) - 3,4) <>  ".slk"  THEN 
    fi_outputex  =  Trim(fi_outputex) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outputex).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "รายงานแจ้งประกันภัย (ปีแรก)"       '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "วันที่แจ้งประกันภัยระหว่างวันที่"  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "บริษัทประกันภัย : 10 "             '"' SKIP.
 nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "เจ้าหน้าที่การขาย : ทั้งหมด  "     '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'   ""     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'   ""     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'   ""     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'   ""     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'   ""     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'   ""     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'   ""     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'   ""     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'   ""     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'   ""     '"' SKIP.                                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'   "New"  '"' SKIP.                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'   ""     '"' SKIP.                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'   ""     '"' SKIP.                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'   "กรมธรรม์ภาคสมัครใจ"     '"' SKIP.              
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'   ""     '"' SKIP.                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'   ""     '"' SKIP.                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'   "    กรมธรรม์ภาคบังคับ (พ.ร.บ.)"  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'   "                   "             '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'   "                   "             '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'   "  เบี้ยประกันภัย   "             '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'   "                       "             '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'   "                       "             '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'   "ประเภทการประกันภัยที่ต้องการ "   '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'   ""                                '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'   ""                                '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'   ""                                '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'   ""                                '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'   ""                                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'   ""                                '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'   ""                                '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'   ""                                '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'   ""                                '"' SKIP.
nv_row  =  nv_row + 1.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'   "ลำดับ"                   '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'   "วันที่แจ้ง    "          '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'   "บริษัทประกัน  "          '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'   "เลขที่รับแจ้ง "          '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'   "เลขกรมธรรม์70  "         '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'   "เลขกรมธรรม์72  "         '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'   "สาขา STY  "              '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'   "ชื่อผู้แจ้ง  "           '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'   "เลขที่ใบคำขอ  "          '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'   "คำนำหน้า      "          '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'   "ชื่อผู้เอาประกัน "       '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'   "เพศ              "       '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'   "เลขบัตรประชาชน "         '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'   "วันเดือนปี เกิด"         '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'   "อาชีพ          "         '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'   "ชื่อรถยนต์     "         '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'   "รุ่น           "         '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'   "ปีรุ่น         "         '"' SKIP.                              
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'   "แบบตัวถัง      "         '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'   "ลักษณะการใช้รถยนต์"      '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'   "ซี.ซี.            "      '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'   "เลขเครื่องยนต์    "      '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'   "เลขตัวถัง         "      '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'   "ทะเบียน           "      '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'   "Used      "              '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'   "เริ่มต้นคุ้มครอง"        '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'   "สิ้นสุดวันที่   "        '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'   "ประเภท          "        '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'   "ทุนประกันภัย    "           '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'   "ค่าเบี้ยประกัน  "           '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'   "ค่า พ.ร.บ. "                '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'   "วันที่คุ้มครอง พ.ร.บ. "     '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'   "วันที่สิ้นสุด พ.ร.บ.  "     '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'   "เลขเครื่องหมาย พ.ร.บ. "     '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'   "รวม พ.ร.บ. "                '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'   "ราคารถ                   "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'   "ยอดจัด                   "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'   "ระบุชื่อผู้ขับขี่ 1      "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'   "ระบุชื่อผู้ขับขี่ 2      "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'   "ผู้รับผลประโยชน์         "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'   "ที่อยู่ที่จัดส่งกรมธรรม์ "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'   "เงื่อนไขพิเศษ            "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'   "Dealer                   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'   "ที่อยู่ Dealer           "  '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'   "แจ้งประกันโดย            "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'   "เลขที่สัญญา              "  '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'   "รถใหม่/รถเก่า/Refinance  "  '"' SKIP.                 

FOR EACH wdetail2 WHERE wdetail2.chassis <> "" no-lock.
    ASSIGN 
        n_pol    = ""
        n_pol2    = ""
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1
        n_branch =  wdetail2.branch2.
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol =  wdetail2.notifyno AND
            sicuw.uwm100.poltyp =  "V70"   NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL sicuw.uwm100 THEN  
            ASSIGN n_pol  = sicuw.uwm100.policy 
                   n_pol2 = sicuw.uwm100.cr_2.
    ELSE ASSIGN n_pol = ""
            n_pol2 = "".
    
    IF n_pol = "" THEN DO:
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol =  wdetail2.notifyno AND
            sicuw.uwm100.poltyp =  "V72"   NO-LOCK NO-ERROR NO-WAIT. 
        IF AVAIL sicuw.uwm100 THEN  
            ASSIGN n_pol  = ""
                   n_pol2 = sicuw.uwm100.policy .
        ELSE ASSIGN n_pol = ""
                    n_pol2 = "".
    END.
    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail2.Notify_dat  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail2.comp_code   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail2.notifyno    '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   n_pol                '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   n_pol2               '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail2.branch2     '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail2.NAME_mkt    '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail2.ref         '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail2.n_TITLE     '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail2.n_name1     '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail2.sex         '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail2.idno        '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail2.brithday    '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail2.accoup      '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail2.brand       '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail2.model       '"' SKIP.                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail2.cyear       '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail2.cov_car     '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail2.vehuse      '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail2.power       '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail2.engine      '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail2.chassis     '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail2.licence     '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail2.cov_new     '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail2.comdat      '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail2.expdat      '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail2.covcod      '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail2.ins_amt1    '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail2.prem1       '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail2.comprem     '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail2.comdat72    '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail2.expdat72    '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail2.sck         '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail2.prem2       '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail2.pricar      '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail2.pricar2     '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail2.driname1    '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail2.driname2    '"' SKIP.                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  wdetail2.bennam      '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  wdetail2.ADD_1       '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail2.remak1      '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail2.deler       '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail2.addr_deler  '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail2.notiuser    '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  wdetail2.cedpol      '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'  wdetail2.refince     '"' SKIP.               
END.    /*  end  wdetail2  */                                     
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_matchfile_prem C-Win 
PROCEDURE Pro_matchfile_prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FOR EACH wdetail2.
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
        sicuw.uwm100.cedpol =  wdetail2.notifyno  NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL sicuw.uwm100 THEN DO:
        IF ((sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ?) OR (sicuw.uwm100.releas = YES)) AND
            (sicuw.uwm100.poltyp =  "v70" ) THEN ASSIGN wdetail2.policy2    =  sicuw.uwm100.policy.
    END.
    ELSE ASSIGN wdetail2.policy2    = "".
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

