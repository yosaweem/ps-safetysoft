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
/* Copyright  : Safety Insurance Public Company Limited ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�) */ 
/*create by   : Kridtiya i. A54-0351  date . 06/12/11                                      */ 
/*              �������������ҧҹ������� ��Ҥ�����õԹҤԹ                            */ 
/*modify by   : Kridtiya i. A55-0008  date . 06/01/12                                      */ 
/*              ��Ѻ��ǹ������Ţ����ѭ�ҷ�������к����                                    */ 
/*modify by   : Kridtiya i. A55-0016  date . 16/01/12                                      */ 
/*              ��Ѻ��ǹ����͡�ҹ�Ңҵ����������parameter[Setup Company and deler Code:]*/
/*modify by   : Kridtiya i. A55-0029  date . 30/01/12 ���Ţ����ѭ������ ���͹� �ҹ 70 */ 
/*modify by   : Kridtiya i. A55-0104  date . 20/03/12 �������͹䢡���ʴ���ҡ�ë���       */
/*modify by   : Kridtiya i. A55-0114  date . 26/03/2012 ����ŧ������ö�������� Setupdeler*/
/*modify by   : Kridtiya i. A58-0015  date.  13/01/2015 add message error icno ,add icno   */
/*modify by   : Ranu i. A60-0232 date.  01/06/2017  ����������Ѻ�������   */
/*Modify by  : Ranu i. A61-0335 date:11/07/2018 ��������红����Ũҡ��� */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/* Modify by : Ranu I. A63-0130 ��� Pack T                */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by  : Ranu I. A64-0138 ��䢡�äӹǳ���·���������ҧ            */
/*Modify by   : Kridtiya i. A65-0035 comment message error premium not on file */
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
{wgw\wgwkkren.i}      /*��С�ȵ����*/
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
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_pack fi_pack1 fi_pack2 ~
fi_pack3 fi_bchno fi_branch fi_producer fi_agent fi_prevbat fi_bchyr ~
fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem ~
buok bu_exit br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent RECT-368 RECT-370 ~
RECT-372 RECT-373 RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_show fi_loaddat fi_pack fi_pack1 ~
fi_pack2 fi_pack3 fi_bchno fi_branch fi_producer fi_agent fi_prevbat ~
fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem ~
fi_brndes fi_impcnt fi_proname fi_agtname fi_completecnt fi_premtot ~
fi_premsuc 

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

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_pack1 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_pack2 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_pack3 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

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
     SIZE 86 BY 1.19
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
     BGCOLOR 8 FGCOLOR 1 .

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
     BGCOLOR 19 .

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
     fi_show AT ROW 13.67 COL 16.5 NO-LABEL
     fi_loaddat AT ROW 2.81 COL 29 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 2.81 COL 61.17 COLON-ALIGNED NO-LABEL
     fi_pack1 AT ROW 2.81 COL 78.83 COLON-ALIGNED NO-LABEL
     fi_pack2 AT ROW 2.81 COL 94.67 COLON-ALIGNED NO-LABEL
     fi_pack3 AT ROW 2.81 COL 110 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.29 COL 14.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_branch AT ROW 3.86 COL 29 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.86 COL 29 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 5.91 COL 29 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 6.91 COL 29 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 6.91 COL 67.33 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 7.95 COL 29 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 7.95 COL 92.83
     fi_output1 AT ROW 9 COL 29 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 10.05 COL 29 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 11.24 COL 29 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 12.38 COL 29 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 12.48 COL 74 NO-LABEL
     buok AT ROW 7.86 COL 104.67
     bu_exit AT ROW 9.76 COL 104.67
     fi_brndes AT ROW 3.76 COL 42.67 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 15.29 COL 1.83
     bu_hpbrn AT ROW 3.81 COL 38
     bu_hpacno1 AT ROW 4.81 COL 46.17
     fi_impcnt AT ROW 21.71 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpagent AT ROW 5.86 COL 46.17
     fi_proname AT ROW 4.81 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 5.86 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 22.71 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 21.71 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 22.76 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     "Branch  :" VIEW-AS TEXT
          SIZE 9 BY 1.05 AT ROW 3.81 COL 20.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    IMPORT TEXT FILE MOTOR [KK-RENEW�͹���� �Ҥ��Ѥ��]" VIEW-AS TEXT
          SIZE 120.67 BY .95 AT ROW 1.38 COL 1.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 20 BY 1.05 AT ROW 12.38 COL 28.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 11.24 COL 11.83
          BGCOLOR 8 FGCOLOR 1 
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 21 BY 1.05 AT ROW 6.91 COL 8
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.29 COL 4.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 22.71 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 21.71 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package1.1:" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 2.81 COL 50.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 9 COL 10.5
          BGCOLOR 8 FGCOLOR 1 
     "Agent Code  :" VIEW-AS TEXT
          SIZE 13 BY 1.05 AT ROW 5.91 COL 15.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY 1.05 AT ROW 6.91 COL 66.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 124.5 BY 23.76
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 12.67 COL 92
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package2:" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 2.81 COL 85.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package3:" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 2.81 COL 101.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY 1.05 AT ROW 12.52 COL 71.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22 BY 1.05 AT ROW 7.95 COL 7
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Load Date :":35 VIEW-AS TEXT
          SIZE 12.33 BY 1.05 AT ROW 2.81 COL 17.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer  Code :" VIEW-AS TEXT
          SIZE 17.17 BY 1.05 AT ROW 4.86 COL 12.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 22.71 COL 116.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.71 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 21.71 COL 116.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TieS 4 01/03/2022":60 VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 12.67 COL 104.17 WIDGET-ID 2
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package1.2:" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 2.81 COL 68
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY 1.05 AT ROW 10.05 COL 6.5
          BGCOLOR 8 FGCOLOR 1 
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 21.71 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-368 AT ROW 12.33 COL 11.5
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.52 COL 1
     RECT-373 AT ROW 15.05 COL 1
     RECT-374 AT ROW 20.91 COL 1
     RECT-375 AT ROW 21.24 COL 2
     RECT-376 AT ROW 21.48 COL 3.33
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
         TITLE              = "Load Text File KK[renew-�͹���� �Ҥ��Ѥ��]"
         HEIGHT             = 23.76
         WIDTH              = 124.67
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
          SIZE 12.83 BY 1.05 AT ROW 6.91 COL 66.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 20 BY 1.05 AT ROW 12.38 COL 28.17 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY 1.05 AT ROW 12.52 COL 71.5 RIGHT-ALIGNED         */

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
ON END-ERROR OF C-Win /* Load Text File KK[renew-�͹���� �Ҥ��Ѥ��] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Load Text File KK[renew-�͹���� �Ҥ��Ѥ��] */
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
                  uzm700.branch  = TRIM(nv_batbrn)    AND
                  uzm700.bchyr   = nv_batchyr         NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:   
            nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102 
                WHERE uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") 
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
        nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
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
        nv_batbrn    = fi_branch .
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
    /* comment by : A64-0138 ...
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
    ....end : A64-0138 ...*/

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
    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    /*output*/
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

    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    
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
       Message "��س��к� Branch Code ." View-as alert-box.
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


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack C-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
  fi_pack  =  Input  fi_pack.
  Disp  fi_pack  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack1 C-Win
ON LEAVE OF fi_pack1 IN FRAME fr_main
DO:
    fi_pack1  =  Input  fi_pack1.
    Disp  fi_pack1  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack2 C-Win
ON LEAVE OF fi_pack2 IN FRAME fr_main
DO:
    
  fi_pack2  =  Input  fi_pack2.
  Disp  fi_pack2  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack3 C-Win
ON LEAVE OF fi_pack3 IN FRAME fr_main
DO:
    
  fi_pack3  =  Input  fi_pack3.
  Disp  fi_pack3  with  frame  fr_main.
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
  
  gv_prgid = "WGWKKREN".
  gv_prog  = "Load Text & Generate (KK-��������͹����)".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).    
  ASSIGN
      fi_pack     = "F"
      fi_pack1    = "G"
      fi_pack2    = "Y"
      fi_pack3    = "V"
      fi_branch   = "M"
      /*fi_producer = "A0M1005"    */ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
      /*fi_agent    = "B3M0006"    */ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
      fi_producer = "B3MLKK0101"      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
      fi_agent    = "B3MLKK0100"      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
      fi_bchyr    = YEAR(TODAY) 
      fi_show     = "Load Text file KK-Renew ............. ".
  DISP fi_pack fi_pack1 fi_pack2  fi_pack3  fi_branch fi_producer fi_agent fi_bchyr fi_show WITH FRAME fr_main.
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
  DISPLAY fi_show fi_loaddat fi_pack fi_pack1 fi_pack2 fi_pack3 fi_bchno 
          fi_branch fi_producer fi_agent fi_prevbat fi_bchyr fi_filename 
          fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes 
          fi_impcnt fi_proname fi_agtname fi_completecnt fi_premtot fi_premsuc 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loaddat fi_pack fi_pack1 fi_pack2 fi_pack3 fi_bchno fi_branch 
         fi_producer fi_agent fi_prevbat fi_bchyr fi_filename bu_file 
         fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit 
         br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent RECT-368 RECT-370 RECT-372 
         RECT-373 RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
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
    wdetail.tariff = "9" . 
IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.subclass = "210" THEN wdetail.subclass = "140A".
    ELSE wdetail.subclass = "110".
    IF wdetail.compul <> "y" THEN 
        ASSIGN /*a490166*/
            wdetail.comment = wdetail.comment + "| poltyp �� v72 Compulsory ��ͧ�� y" 
            wdetail.pass    = "N"
            wdetail.OK_GEN  = "N". 
END.
IF wdetail.compul = "y" THEN DO:
    /*--Str amparat C. A51-0253--*/
    IF wdetail.stk <> "" THEN DO:    
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN 
                wdetail.comment = wdetail.comment + "| �Ţ Sticker ��ͧ�� 11 ���� 13 ��ѡ��ҹ��"
                wdetail.pass    = ""
                wdetail.OK_GEN  = "N".
            /*--end amparat C. A51-0253--*/
    END.    
END.
/*---------- class --------------*/

FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail.subclass
    NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN 
        wdetail.comment = wdetail.comment + "| ��辺 Class �����к�"
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp  AND
        sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN 
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| ��辺 Class ����繢ͧ Policy Type���"
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
        wdetail.comment = wdetail.comment + "| ��辺 Cover Type �����к�"
        wdetail.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod  NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ��辺 Tariff or Compulsory or Class or Cover Type ��к�"
        wdetail.OK_GEN = "N".
/*--------- modcod --------------*/
/*chkred = NO.
IF wdetail.redbook <> "" THEN DO:    /*�óշ���ա���к� Code ö��*/
    FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
        sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm102 THEN DO:
        ASSIGN  
            wdetail.pass    = "N"  
            wdetail.comment = wdetail.comment + "| not find on table xmm102 ��辺 Makes/Models �����к�"
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
    ASSIGN     
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ��辺 Veh.Usage ��к� "
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
    sic_bran.uwm130.riskgp = s_riskgp      AND            /*0*/
    sic_bran.uwm130.riskno = s_riskno      AND            /*1*/
    sic_bran.uwm130.itemno = s_itemno      AND            /*1*/
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
    Assign            /*a490166 �������ѹ*/
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
    IF wdetail.redbook <> "" THEN DO:   /*�óշ���ա���к� Code ö��*/
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
                wdetail.weight                = string(sicsyac.xmm102.tons)  
                wdetail.cc                  = string(sicsyac.xmm102.engine)
                wdetail.seat                   = string(sicsyac.xmm102.seats)
                wdetail.redbook               = sicsyac.xmm102.modcod
                wdetail.brand                  = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/
                wdetail.model                  = SUBSTRING(xmm102.modest,19,22).  /*Thai*/
        END.
    END.
    ELSE DO:
        ASSIGN
        nv_simat  = DECI(wdetail.si) - (DECI(wdetail.si) * 20 / 100 )
        nv_simat1 = DECI(wdetail.si) + (DECI(wdetail.si) * 20 / 100 )  .
        IF wdetail.model = "cab4"  THEN n_model = "cab4".
        IF wdetail.model = "CAB4 HILANDER"  THEN n_model = "cab".
        IF (wdetail.model = "CAB4 RODEO") OR (wdetail.model = "RODEO")  THEN n_model = "RODEO".
        IF wdetail.model = "MU7"  THEN n_model = "MU-7".
        IF wdetail.model = "SPACECAB HILANDER"  THEN n_model = "cab".
        IF wdetail.model = "SPACECAB"  THEN n_model = "SPACECAB".
        IF wdetail.model = "SPARK"  THEN n_model = "SPARK".
        FIND LAST sicsyac.xmm102 WHERE 
            /*sicsyac.xmm102.modest = wdetail.brand + wdetail.model AND*/
            INDEX(sicsyac.xmm102.modest,wdetail.brand) <> 0 AND
            INDEX(sicsyac.xmm102.modest,n_model) <> 0 AND
            sicsyac.xmm102.engine = INTE(wdetail.cc) AND 
            /*sicsyac.xmm102.tons   = INTE(wdetail.weight) AND*/
            sicsyac.xmm102.seats  >= INTE(wdetail.seat)
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
        MESSAGE "�����ѧ��ҹ Insured (UWD132)" wdetail.policy
                "�������ö Generage ��������".
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

               ASSIGN fi_show = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
               DISP fi_show WITH FRAM fr_main. 
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
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail2.
    IMPORT DELIMITER "|" 
        wdetail2.recno           /* 0   �ӴѺ���        */
        wdetail2.Notify_dat      /* 1   �ѹ����Ѻ��   */                                       
        wdetail2.recive_dat      /* 2   �ѹ����Ѻ�Թ������»�Сѹ */                           
        wdetail2.comp_code       /* 3   ��ª��ͺ���ѷ��Сѹ���  */                               
        wdetail2.cedpol          /* 4   �Ţ����ѭ����ҫ��� */                                   
        wdetail2.prepol          /* 5   �Ţ�������������  */                                   
        wdetail2.cmbr_no         /* 6   �����Ң�    */                                           
        wdetail2.cmbr_code       /* 7   �Ң� KK */                                               
        wdetail2.notifyno        /* 8   �Ţ�Ѻ��� */                                           
        wdetail2.campaigno       /* 9   Campaign    */                                           
        wdetail2.campaigsub      /* 10  Sub Campaign    */                                       
        wdetail2.typper          /* 11  �ؤ��/�ԵԺؤ�� */                                       
        wdetail2.n_TITLE         /* 12  �ӹ�˹�Ҫ���    */                                       
        wdetail2.n_name1         /* 13  ���ͼ����һ�Сѹ    */                                   
        wdetail2.n_name2         /* 14  ���ʡ�ż����һ�Сѹ */                                   
        wdetail2.ADD_1           /* 15  ��ҹ�Ţ���  */                                           
        wdetail2.ADD_2           /* 21  �Ӻ�/�ǧ   */                                           
        wdetail2.ADD_3           /* 22  �����/ࢵ   */                                           
        wdetail2.ADD_4           /* 23  �ѧ��Ѵ */                                               
        wdetail2.ADD_5           /* 24  ������ɳ���    */                                       
        wdetail2.cover           /* 25  ����������������ͧ  */                                   
        wdetail2.garage          /* 26  ��������ë���   */                                       
        wdetail2.comdat          /* 27  �ѹ�����������ͧ    */                                   
        wdetail2.expdat          /* 28  �ѹ����ش������ͧ  */                                   
        wdetail2.subclass        /* 29  ����ö  */                                               
        wdetail2.n_43            /* 30  ��������Сѹ���ö¹��   */                               
        wdetail2.brand           /* 31  ����������ö    */                                       
        wdetail2.model           /* 32  ���ö  */                                               
        wdetail2.nSTATUS         /* 33  New/Used    */                                           
        wdetail2.licence         /* 34  �Ţ����¹  */                                           
        wdetail2.chassis         /* 35  �Ţ��Ƕѧ   */                                           
        wdetail2.engine          /* 36  �Ţ����ͧ¹��  */                                       
        wdetail2.cyear           /* 37  ��ö¹��    */                                           
        wdetail2.power           /* 38  �ի�    */                                               
        wdetail2.weight          /* 39  ���˹ѡ/�ѹ */                                           
        wdetail2.ins_amt1        /* 40  �ع��Сѹ�� 1   */                                       
        wdetail2.prem1           /* 41  ����������������ҡû� 1    */                           
        wdetail2.ins_amt2        /* 42  �ع��Сѹ�� 2   */ 
        wdetail2.fi              /* A60-0232 �ع��Сѹö¹���٭���/����� ��2(F&T) */
        wdetail2.prem2           /* 43  ����������������ҡû� 2    */                           
        wdetail2.time_notify     /* 44  �����Ѻ���    */                                       
        wdetail2.NAME_mkt        /* 45  �������˹�ҷ�� MKT */                                   
        wdetail2.bennam          /* 46  �����˵�    */                                           
        wdetail2.drivno1         /* 47  ���Ѻ����� 1 �����ѹ�Դ  */                           
        wdetail2.drivno2         /* 48  ���Ѻ����� 2 �����ѹ�Դ  */                           
        wdetail2.reci_title      /* 49  �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)  */                   
        wdetail2.reci_name1      /* 50  ���� (�����/㺡ӡѺ����)  */                           
        wdetail2.reci_name2      /* 51  ���ʡ�� (�����/㺡ӡѺ����)   */                       
        wdetail2.reci_1      /* 52  ��ҹ�Ţ��� (�����/㺡ӡѺ����)    */                   
        wdetail2.reci_2          /* 57  �Ӻ�/�ǧ (�����/㺡ӡѺ����) */                       
        wdetail2.reci_3          /* 58  �����/ࢵ (�����/㺡ӡѺ����) */                       
        wdetail2.reci_4          /* 59  �ѧ��Ѵ (�����/㺡ӡѺ����)   */                       
        wdetail2.reci_5          /* 60  ������ɳ��� (�����/㺡ӡѺ����)  */                   
        wdetail2.ncb             /* 61  ��ǹŴ����ѵԴ� */                                       
        wdetail2.fleet          /* 62  ��ǹŴ�ҹ Fleet */
        /*A60-0232*/
        wdetail2.phone         /*����Դ���                */      
        wdetail2.icno          /*�Ţ���ѵû�ЪҪ�          */ 
        wdetail2.bdate         /*�ѹ��͹���Դ             */ 
        wdetail2.occup         /*�Ҫվ                      */ 
        wdetail2.cstatus       /*ʶҹ�Ҿ                    */ 
        wdetail2.tax           /*�Ţ��Шӵ�Ǽ�����������ҡ� */ 
        wdetail2.tname1        /*�ӹ�˹�Ҫ��� 1             */ 
        wdetail2.cname1        /*���͡������ 1              */ 
        wdetail2.lname1        /*���ʡ�š������ 1           */ 
        wdetail2.icno1         /*�Ţ���ѵû�ЪҪ�������� 1 */ 
        wdetail2.tname2        /*�ӹ�˹�Ҫ��� 2             */ 
        wdetail2.cname2        /*���͡������ 2              */ 
        wdetail2.lname2        /*���ʡ�š������ 2           */ 
        wdetail2.icno2         /*�Ţ���ѵû�ЪҪ�������� 2 */ 
        wdetail2.tname3        /*�ӹ�˹�Ҫ��� 3             */ 
        wdetail2.cname3        /*���͡������ 3              */ 
        wdetail2.lname3        /*���ʡ�š������ 3           */ 
        wdetail2.icno3         /*�Ţ���ѵû�ЪҪ�������� 3 */ 
        /* end : A60-0232*/
        wdetail2.nsend       /*���Ѵ�� */ /*A61-0335*/
        wdetail2.sendname    /*���ͼ���Ѻ�͡��� */ /*A61-0335*/
        wdetail2.bennefit    /*����Ѻ�Ż���ª�� */ /*A61-0335*/
        wdetail2.KKapp       /*KK app */ /*A61-0335*/
        wdetail2.remak1
        wdetail2.remak2 
        wdetail2.dealercd   . /*Add A63-00472 Daaler*/
        
END.                       /*-Repeat-*/
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
FOR EACH wdetail2 .
    ASSIGN n_comdate = "" .
    IF  (index(wdetail2.recno,"����ѷ") <> 0 ) OR
        (index(wdetail2.recno,"�ӴѺ") <> 0)   THEN DELETE wdetail2.
    ELSE DO:
        IF wdetail2.cedpol NE "" THEN DO:
            FIND FIRST stat.insure USE-INDEX insure03 WHERE 
                stat.insure.compno = "kk"                              AND
                index(stat.insure.insno,trim(wdetail2.cmbr_no))   <> 0 AND
                index(trim(wdetail2.cmbr_code),trim(stat.insure.fname)) <> 0 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.insure THEN 
                ASSIGN wdetail2.branch = CAPS(stat.insure.branch) . 
            /*a60-0232*/
            ELSE DO:
                FIND FIRST stat.insure USE-INDEX insure03 WHERE 
                    stat.insure.compno = "kk"                              AND
                    index(stat.insure.insno,trim(wdetail2.cmbr_no))   <> 0 NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL stat.insure THEN
                    ASSIGN   wdetail2.branch = CAPS(stat.insure.branch) .
                ELSE 
                    ASSIGN   wdetail2.branch = "" .
            END.
            /* end:A60-0232*/  
            IF      index(wdetail2.n_43,"��1") <> 0 THEN wdetail2.subclass  = "110".
            ELSE IF index(wdetail2.n_43,"��2") <> 0 THEN wdetail2.subclass  = "210".
            ELSE IF index(wdetail2.n_43,"��3") <> 0 THEN wdetail2.subclass  = "320".
        END.
        IF trim(wdetail2.ADD_4) = ""  THEN 
            ASSIGN wdetail2.ADD_2 = IF trim(wdetail2.ADD_2) = "" THEN "" ELSE "�Ӻ�"  + trim(wdetail2.ADD_2)
                   wdetail2.ADD_3 = IF trim(wdetail2.ADD_3) = "" THEN "" ELSE "�����" + trim(wdetail2.ADD_3).
        ELSE DO: 
            IF (INDEX(wdetail2.ADD_4,"��ا෾") <> 0 ) OR (INDEX(wdetail2.ADD_4,"���") <> 0) THEN
                ASSIGN wdetail2.ADD_2 = IF trim(wdetail2.ADD_2) = "" THEN "" ELSE "�ǧ" + trim(wdetail2.ADD_2)
                       wdetail2.ADD_3 = IF trim(wdetail2.ADD_3) = "" THEN "" ELSE "ࢵ" + trim(wdetail2.ADD_3).
            ELSE ASSIGN
                wdetail2.ADD_2 = IF trim(wdetail2.ADD_2) = "" THEN "" ELSE "�Ӻ�"  + trim(wdetail2.ADD_2)
                wdetail2.ADD_3 = IF trim(wdetail2.ADD_3) = "" THEN "" ELSE "�����" + trim(wdetail2.ADD_3) 
                wdetail2.ADD_4 = "�ѧ��Ѵ" + trim(wdetail2.ADD_4) .
        END.
        ASSIGN n_comdate  = string(DAY(date(wdetail2.comdat)),"99")   + "/" +  
                            string(MONTH(date(wdetail2.comdat)),"99") + "/" +  
                            STRING(YEAR(date(wdetail2.comdat)),"9999") . 
        IF (TODAY - date(n_comdate)) >= 29 THEN DO:          /* 27  �ѹ�����������ͧ    */                                   
            /*MESSAGE "�Ţ����ѭ��REKK :" wdetail2.notifyno "�ѹ��������������ͧ���¡����ѹ������� 29 �ѹ" VIEW-AS ALERT-BOX.*/
            ASSIGN wdetail2.comdat = string(DAY(TODAY),"99")   + "/" +       
                                     string(MONTH(TODAY),"99") + "/" +       
                                     STRING(YEAR(TODAY),"9999")            
                wdetail2.expdat    = string(DAY(TODAY),"99")   + "/" +                    
                                     string(MONTH(TODAY),"99") + "/" +       
                                     STRING(YEAR(TODAY) + 1 ,"9999")   .  /* 28  �ѹ����ش������ͧ  */    
            FIND LAST brstat.tlt    WHERE 
                brstat.tlt.comp_noti_tlt  = wdetail2.notifyno  AND
                brstat.tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
            IF AVAIL brstat.tlt THEN 
                ASSIGN 
                brstat.tlt.OLD_cha = brstat.tlt.OLD_cha + "����¹�ѹ��������������ͧ ���١��Ҫ����Թ ".
        END.
    END.
END.
RUN proc_assign2_veh.
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

IF      R-INDEX(nv_address,"�.")       <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"�.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"�.")       - 1 )). 
ELSE IF R-INDEX(nv_address,"�ѧ��Ѵ.") <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"�ѧ��Ѵ.")   + 8 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"�ѧ��Ѵ.") - 1 )). 
ELSE IF R-INDEX(nv_address,"�ѧ��Ѵ")  <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"�ѧ��Ѵ")    + 7 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"�ѧ��Ѵ")  - 1 )). 
ELSE IF R-INDEX(nv_address,"��ا෾")  <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"��ا෾"))) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"��ا෾")  - 1 )).
ELSE IF R-INDEX(nv_address,"���")      <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"���"))) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"���")  - 1 )).

IF index(np_mail_country," ") <> 0  THEN 
    ASSIGN 
    nv_postcd       = trim(SUBSTR(np_mail_country,index(np_mail_country," "))) 
    np_mail_country = trim(SUBSTR(np_mail_country,1,index(np_mail_country," ") - 1 )) .
IF      index(np_mail_country,"��ا෾") <> 0 THEN np_mail_country = "��ا෾��ҹ��".
ELSE IF index(np_mail_country,"���")     <> 0 THEN np_mail_country = "��ا෾��ҹ��".

IF      R-INDEX(nv_address,"�����.")   <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"�����.")     + 6 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"�����.")   - 1 )). 
ELSE IF R-INDEX(nv_address,"�����")    <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"�����")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"�����")    - 1 )).
ELSE IF R-INDEX(nv_address,"�.")       <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"�.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"�.")       - 1 )).
ELSE IF R-INDEX(nv_address,"ࢵ.")     <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"ࢵ.")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"ࢵ.")     - 1 )).
ELSE IF R-INDEX(nv_address,"ࢵ")      <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"ࢵ")        + 3 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"ࢵ")      - 1 )). 

IF      R-INDEX(nv_address,"�.")       <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"�.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"�.")       - 1 )).
ELSE IF R-INDEX(nv_address,"�Ӻ�.")    <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"�Ӻ�.")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"�Ӻ�.")    - 1 )).
ELSE IF R-INDEX(nv_address,"�Ӻ�")     <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"�Ӻ�")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"�Ӻ�")     - 1 )).

ELSE IF R-INDEX(nv_address,"�ǧ.")    <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"�ǧ.")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"�ǧ.")    - 1 )). 
ELSE IF R-INDEX(nv_address,"�ǧ")     <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"�ǧ")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"�ǧ")     - 1 )). 

FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE 
    sicuw.uwm500.prov_d = np_mail_country  NO-LOCK NO-ERROR NO-WAIT.  /*"�ҭ������"*/   /*uwm100.codeaddr1*/
IF AVAIL sicuw.uwm500 THEN DO:  
     /*DISP sicuw.uwm500.prov_n . */
    FIND LAST sicuw.uwm501 USE-INDEX uwm50102   WHERE 
        sicuw.uwm501.prov_n = sicuw.uwm500.prov_n  AND
        index(sicuw.uwm501.dist_d,np_mail_amper) <> 0        NO-LOCK NO-ERROR NO-WAIT. /*"����ǹ"*/
    IF AVAIL sicuw.uwm501 THEN DO:  
         /*DISP
        sicuw.uwm501.prov_n  /* uwm100.codeaddr1 */
        sicuw.uwm501.dist_n  /* uwm100.codeaddr2 */ 
        . */
         
        FIND LAST sicuw.uwm506 USE-INDEX uwm50601 WHERE 
            sicuw.uwm506.prov_n   = sicuw.uwm501.prov_n and
            sicuw.uwm506.dist_n   = sicuw.uwm501.dist_n and
            sicuw.uwm506.sdist_d  = np_tambon           NO-LOCK NO-ERROR NO-WAIT. /*"�ҧ����"*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2_veh C-Win 
PROCEDURE proc_assign2_veh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_vehpro AS CHAR FORMAT "x(50)" INIT "".

ASSIGN fi_show = "Match province ......".
DISP fi_show WITH FRAM fr_main.
FOR EACH wdetail2 .
    IF wdetail2.cedpol NE "" THEN DO:
        ASSIGN n_vehpro = wdetail2.licence.
        IF      index(n_vehpro,"��к��")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��к��") - 2 )        + " ��".  /*1*/ 
        ELSE IF index(n_vehpro,"��ا෾��ҹ��")    <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��ا෾��ҹ��") - 2 ) + " ��".  /*2*/   
        ELSE IF index(n_vehpro,"�ҭ������")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ҭ������") - 2 )     + " ��".  /*3*/ 
        ELSE IF index(n_vehpro,"����Թ���")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"����Թ���") - 2 )     + " ��".  /*4*/ 
        ELSE IF index(n_vehpro,"��ᾧྪ�")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��ᾧྪ�") - 2 )     + " ��".  /*5*/ 
        ELSE IF index(n_vehpro,"�͹��")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�͹��") - 2 )       + " ��".  /*6*/ 
        ELSE IF index(n_vehpro,"�ѹ�����")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ѹ�����") - 2 )      + " ��".  /*7*/ 
        ELSE IF index(n_vehpro,"���ԧ���")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"���ԧ���") - 2 )    + " ��".  /*8*/ 
        ELSE IF index(n_vehpro,"�ź���")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ź���") - 2 )        + " ��".  /*9*/ 
        ELSE IF index(n_vehpro,"��¹ҷ")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��¹ҷ") - 2 )        + " ��".  /*10*/
        ELSE IF index(n_vehpro,"�������")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�������") - 2 )       + " ��".  /*11*/
        ELSE IF index(n_vehpro,"�����")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�����") - 2 )         + " ��".  /*12*/
        ELSE IF index(n_vehpro,"��§���")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��§���") - 2 )      + " ��".  /*13*/
        ELSE IF index(n_vehpro,"��§����")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��§����") - 2 )     + " ��".  /*14*/
        ELSE IF index(n_vehpro,"��ѧ")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��ѧ") - 2 )          + " ��".  /*15*/
        ELSE IF index(n_vehpro,"��Ҵ")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��Ҵ") - 2 )          + " ��".  /*16*/
        ELSE IF index(n_vehpro,"�ҡ")              <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ҡ") - 2 )           + " ��".  /*17*/
        ELSE IF index(n_vehpro,"��ù�¡")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��ù�¡") - 2 )       + " ��".  /*18*/
        ELSE IF index(n_vehpro,"��û��")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��û��") - 2 )        + " ��".  /*19*/
        ELSE IF index(n_vehpro,"��þ��")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��þ��") - 2 )        + " ��".  /*20*/
        ELSE IF index(n_vehpro,"����Ҫ����")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"����Ҫ����") - 2 )    + " ��".  /*21*/
        ELSE IF index(n_vehpro,"�����ո����Ҫ")    <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�����ո����Ҫ") - 2 ) + " ��".  /*22*/
        ELSE IF index(n_vehpro,"������ä�")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"������ä�") - 2 )     + " ��".  /*23*/
        ELSE IF index(n_vehpro,"�������")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�������") - 2 )       + " ��".  /*24*/
        ELSE IF index(n_vehpro,"��Ҹ����")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��Ҹ����") - 2 )      + " ��".  /*25*/
        ELSE IF index(n_vehpro,"��ҹ")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��ҹ") - 2 )          + " ��".  /*26*/
        ELSE IF index(n_vehpro,"���������")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"���������") - 2 )     + " ��".  /*27*/
        ELSE IF index(n_vehpro,"�����ҹ�")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�����ҹ�") - 2 )      + " ��".  /*28*/
        ELSE IF index(n_vehpro,"��ШǺ���բѹ��")  <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��ШǺ���բѹ��") - 2 ) + " ��".  /*29*/
        ELSE IF index(n_vehpro,"��Ҩչ����")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��Ҩչ����") - 2 )    + " ��".  /*30*/
        ELSE IF index(n_vehpro,"�ѵ�ҹ�")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ѵ�ҹ�") - 2 )       + " ��".  /*31*/
        ELSE IF (index(n_vehpro,"��й�������ظ��") <> 0 ) THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��й�������ظ��") - 2 ) + " ��".  /*32*/
        ELSE IF (index(n_vehpro,"��ظ��")          <> 0 ) THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��ظ��") - 2 )      + " ��".  /*32*/
        ELSE IF index(n_vehpro,"�����")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�����") - 2 )         + " ��".      /*33*/
        ELSE IF index(n_vehpro,"�ѧ��")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ѧ��") - 2 )         + " ��".      /*34*/
        ELSE IF index(n_vehpro,"�ѷ�ا")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ѷ�ا") - 2 )        + " ��".      /*35*/
        ELSE IF index(n_vehpro,"�ԨԵ�")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ԨԵ�") - 2 )        + " ��".      /*36*/
        ELSE IF index(n_vehpro,"��ɳ��š")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��ɳ��š") - 2 )      + " ��".      /*37*/
        ELSE IF index(n_vehpro,"ྪú���")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ྪú���") - 2 )      + " ��".      /*38*/
        ELSE IF index(n_vehpro,"ྪú�ó�")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ྪú�ó�") - 2 )     + " ��".      /*39*/
        ELSE IF index(n_vehpro,"���")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"���") - 2 )          + " ��".      /*40*/
        ELSE IF index(n_vehpro,"����")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"����") - 2 )        + " ��".      /*41*/
        ELSE IF index(n_vehpro,"�����ä��")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�����ä��") - 2 )     + " ��".      /*42*/
        ELSE IF index(n_vehpro,"�ء�����")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ء�����") - 2 )      + " ��".     /*43*/
        ELSE IF index(n_vehpro,"�����ͧ�͹")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�����ͧ�͹") - 2 )    + " ��".     /*44*/
        ELSE IF index(n_vehpro,"����")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"����") - 2 )          + " ��".     /*45*/
        ELSE IF index(n_vehpro,"�������")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�������") - 2 )      + " ��".     /*46*/
        ELSE IF index(n_vehpro,"�йͧ")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�йͧ") - 2 )         + " ù".     /*47*/
        ELSE IF index(n_vehpro,"���ͧ")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"���ͧ") - 2 )         + " ��".     /*48*/
        ELSE IF index(n_vehpro,"�Ҫ����")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�Ҫ����") - 2 )       + " ú".     /*49*/
        ELSE IF index(n_vehpro,"ž����")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ž����") - 2 )        + " ź".     /*50*/
        ELSE IF index(n_vehpro,"�ӻҧ")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ӻҧ") - 2 )         + " Ż".     /*51*/
        ELSE IF index(n_vehpro,"�Ӿٹ")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�Ӿٹ") - 2 )         + " ž".     /*52*/
        ELSE IF index(n_vehpro,"���")              <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"���") - 2 )           + " ��".     /*53*/
        ELSE IF index(n_vehpro,"�������")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�������") - 2 )      + " ȡ".     /*54*/
        ELSE IF index(n_vehpro,"ʡŹ��")           <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ʡŹ��") - 2 )        + " ʹ".     /*55*/
        ELSE IF index(n_vehpro,"ʧ���")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ʧ���") - 2 )         + " ʢ".     /*56*/
        ELSE IF index(n_vehpro,"������")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"������") - 2 )       + " ʡ".     /*57*/
        ELSE IF index(n_vehpro,"��к���")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��к���") - 2 )       + " ʺ".     /*58*/
        ELSE IF index(n_vehpro,"�ԧ�����")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ԧ�����") - 2 )     + " ��".     /*59*/
        ELSE IF index(n_vehpro,"��⢷��")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��⢷��") - 2 )       + " ʷ".     /*60*/
        ELSE IF index(n_vehpro,"�ؾ�ó����")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ؾ�ó����") - 2 )    + " ʾ".     /*61*/
        ELSE IF index(n_vehpro,"����ɮ��ҹ�")     <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"����ɮ��ҹ�") - 2 )  + " ʮ".   /*62*/
        ELSE IF index(n_vehpro,"���Թ���")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"���Թ���") - 2 )      + " ��".    /*63*/
        ELSE IF index(n_vehpro,"˹ͧ���")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"˹ͧ���") - 2 )       + " ��".    /*64*/
        ELSE IF index(n_vehpro,"˹ͧ����Ӿ�")      <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"˹ͧ����Ӿ�") - 2 )   + " ��".    /*65*/
        ELSE IF index(n_vehpro,"��ҧ�ͧ")          <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��ҧ�ͧ") - 2 )       + " ͷ".    /*66*/
        ELSE IF index(n_vehpro,"�ӹҨ��ԭ")       <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ӹҨ��ԭ") - 2 )    + " ͨ".    /*67*/
        ELSE IF index(n_vehpro,"�شøҹ�")         <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�شøҹ�") - 2 )      + " ʹ".    /*68*/
        ELSE IF index(n_vehpro,"�صôԵ��")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�صôԵ��") - 2 )     + " ͵".    /*69*/
        ELSE IF index(n_vehpro,"�ط�¸ҹ�")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�ط�¸ҹ�") - 2 )     + " ͹".    /*70*/
        ELSE IF index(n_vehpro,"�غ��Ҫ�ҹ�")      <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�غ��Ҫ�ҹ�") - 2 )   + " ͺ".    /*71*/
        ELSE IF index(n_vehpro,"��ʸ�")            <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"��ʸ�") - 2 )         + " ��".    /*72*/
        ELSE IF index(n_vehpro,"ʵ��")             <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"ʵ��") - 2 )          + " ʵ".    /*73*/
        ELSE IF index(n_vehpro,"����û�ҡ��")      <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"����û�ҡ��") - 2 )   + " ʻ".    /*74*/
        ELSE IF index(n_vehpro,"�����ʧ����")      <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"�����ʧ����") - 2 )   + " ��".    /*75*/
        ELSE IF index(n_vehpro,"������Ҥ�")        <> 0 THEN wdetail2.licence = SUBSTR(wdetail2.licence,1,index(n_vehpro,"������Ҥ�") - 2 )     + " ʤ".    /*76*/
        ELSE n_vehpro = "".
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
    IF wdetail2.cedpol NE "" THEN DO:
        FIND FIRST wdetail WHERE wdetail.policy = "0K" + wdetail2.cedpol NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN
                n_length            = LENGTH(wdetail2.cedpol)
                n_length            = n_length - 1
                wdetail.seat        = IF      wdetail2.subclass  = "110" THEN "7"   
                                      ELSE IF wdetail2.subclass  = "210" THEN "12"     
                                      ELSE IF wdetail2.subclass  = "320" THEN "3"   
                                      ELSE "7"  
                wdetail.brand       = trim(wdetail2.brand)
                wdetail.caryear     = wdetail2.cyear 
                wdetail.prepol      = caps(trim(wdetail2.prepol))
                wdetail.poltyp      = "70" 
                wdetail.policy      = "0K" + trim(wdetail2.cedpol) 
                wdetail.comdat      = trim(wdetail2.comdat)  
                wdetail.expdat      = trim(wdetail2.expdat) 
                wdetail.tiname      = trim(wdetail2.n_TITLE)
                wdetail.insnam      = trim(wdetail2.n_name1) + " " + 
                                      trim(wdetail2.n_name2)
                wdetail.iadd1       = trim(wdetail2.ADD_1) 
                wdetail.iadd2       = trim(wdetail2.ADD_2)  
                wdetail.iadd3       = trim(wdetail2.ADD_3)  
                wdetail.iadd4       = trim(wdetail2.ADD_4)   + " " +  
                                      trim(wdetail2.ADD_5) 
                wdetail.subclass    = trim(wdetail2.subclass)
                wdetail.model       = trim(wdetail2.model) 
                wdetail.cc          = IF deci(wdetail2.power) = 0 THEN "0"
                                      ELSE string(ROUND((deci(wdetail2.power) / 100 ),0) * 100)
                wdetail.weight      = trim(wdetail2.weight)    
                wdetail.vehreg      = TRIM(wdetail2.licence)
                wdetail.engno       = trim(wdetail2.engine)
                wdetail.chasno      = trim(wdetail2.chassis)
                wdetail.vehuse      = "1"
              /*wdetail.garage      = IF index(trim(wdetail2.garage),"��ҧ") = 0 THEN " " ELSE "G"*//*A55-0104*/
                wdetail.garage      = IF      (index(trim(wdetail2.garage),"��ҧ") <> 0) THEN "G"   /*A55-0104*/
                                      ELSE IF (index(trim(wdetail2.garage),"G")    <> 0) THEN "G"   /*A55-0104*/
                                      ELSE " "                                                      /*A55-0104*/
                wdetail.stk         = ""
                wdetail.covcod      = IF      index(wdetail2.cover,"1") <> 0 THEN "1"
                                      ELSE IF index(wdetail2.cover,"2") <> 0 THEN "2"
                                      ELSE IF index(wdetail2.cover,"3") <> 0 THEN "3"
                                      ELSE "2"
                wdetail.si          = trim(wdetail2.ins_amt2)
                /*wdetail.deductpp    = "300000"  */ /*a63-0130*/
                wdetail.deductpp    = "500000"   /*a63-0130*/
                wdetail.deductba    = "10000000"    
                wdetail.deductpa    = "1000000"  
                wdetail.prempa      = IF      (index(wdetail2.cover,"1") <> 0 ) AND ((index(wdetail2.garage,"��ҧ") <> 0 ) ) THEN fi_pack
                                      ELSE IF (index(wdetail2.cover,"1") <> 0 ) AND ((index(wdetail2.garage,"G") <> 0 ) )    THEN fi_pack
                                      ELSE IF index(wdetail2.cover,"1") <> 0  THEN fi_pack1
                                      ELSE IF index(wdetail2.cover,"2") <> 0  THEN fi_pack2
                                      ELSE IF index(wdetail2.cover,"3") <> 0  THEN fi_pack3
                                      ELSE "Z"
                wdetail.branch      = wdetail2.branch 
                wdetail.benname     = TRIM(wdetail2.bennam)
                wdetail.volprem     = wdetail2.prem2
                wdetail.comment     = ""
                wdetail.agent       = caps(trim(fi_agent))     
                wdetail.producer    = caps(trim(fi_producer))  
                wdetail.entdat      = string(TODAY)                /*entry date*/
                wdetail.enttim      = STRING(TIME, "HH:MM:SS")    /*entry time*/
                wdetail.trandat     = STRING(TODAY)               /*tran date*/
                wdetail.trantim     = STRING(TIME, "HH:MM:SS")    /*tran time*/
                wdetail.n_IMPORT    = "IM"
                wdetail.n_EXPORT    = ""  
                wdetail.nmember     = "�Ţ�Ѻ���[REKK] : " + wdetail2.notifyno + "�������˹�ҷ�� MKT: " + trim(wdetail2.NAME_mkt)
                /* A60-0232 */
                wdetail.phone       = trim(wdetail2.phone)         /*����Դ���                */      
                wdetail.icno        = trim(wdetail2.icno )         /*�Ţ���ѵû�ЪҪ�          */ 
                wdetail.bdate       = trim(wdetail2.bdate)         /*�ѹ��͹���Դ             */ 
                wdetail.occup       = trim(wdetail2.occup)         /*�Ҫվ                      */ 
                wdetail.cstatus     = trim(wdetail2.cstatus)       /*ʶҹ�Ҿ                    */ 
                wdetail.tax         = trim(wdetail2.tax)           /*�Ţ��Шӵ�Ǽ�����������ҡ� */ 
                wdetail.tname1      = trim(wdetail2.tname1)        /*�ӹ�˹�Ҫ��� 1             */ 
                wdetail.cname1      = trim(wdetail2.cname1)        /*���͡������ 1              */ 
                wdetail.lname1      = trim(wdetail2.lname1)        /*���ʡ�š������ 1           */ 
                wdetail.icno1       = trim(wdetail2.icno1 )        /*�Ţ���ѵû�ЪҪ�������� 1 */ 
                wdetail.tname2      = trim(wdetail2.tname2)        /*�ӹ�˹�Ҫ��� 2             */ 
                wdetail.cname2      = trim(wdetail2.cname2)        /*���͡������ 2              */ 
                wdetail.lname2      = trim(wdetail2.lname2)        /*���ʡ�š������ 2           */ 
                wdetail.icno2       = trim(wdetail2.icno2 )        /*�Ţ���ѵû�ЪҪ�������� 2 */ 
                wdetail.tname3      = trim(wdetail2.tname3)        /*�ӹ�˹�Ҫ��� 3             */ 
                wdetail.cname3      = trim(wdetail2.cname3)        /*���͡������ 3              */ 
                wdetail.lname3      = trim(wdetail2.lname3)        /*���ʡ�š������ 3           */ 
                wdetail.icno3       = trim(wdetail2.icno3 )        /*�Ţ���ѵû�ЪҪ�������� 3 */ 
                wdetail.nsend       = trim(wdetail2.nsend)       /*���Ѵ�� */ /*A61-0335*/
                wdetail.sendname    = trim(wdetail2.sendname)    /*���ͼ���Ѻ�͡��� */ /*A61-0335*/
                wdetail.bennefit    = trim(wdetail2.bennefit)    /*����Ѻ�Ż���ª�� */ /*A61-0335*/
                wdetail.KKapp       = trim(wdetail2.KKapp)       /*KK app */ /*A61-0335*/
                /* end : A60-0232 */
                wdetail.cedpol      = trim(wdetail2.cedpol) 
                wdetail.remak1      = trim(wdetail2.remak1)
                wdetail.remak2      = trim(wdetail2.remak2)  
                wdetail.dealercd    = trim(wdetail2.dealercd).    /*A63-00472*/  
                
                /*wdetail.icno        = trim(wdetail2.typper) */  /*A60-0232*/
                
                IF DATE(wdetail.comdat) >= 04/01/2020  THEN ASSIGN wdetail.prempa = "T" . /*a63-0130 */
            END.  /*if avail*/
    END.
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
DEF VAR Nv_brchk   AS CHAR FORMAT "x(5)" INIT "" .  /*add Kridtiya i. A55-0016....*/
DEFINE VAR nre_premt      AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/
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
    n_prmtxt   = ""     /* A55-0114 */
    Nv_brchk   = ""    /*add Kridtiya i. A55-0016....*/
    nre_premt  = 0 .

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
         INPUT-OUTPUT wdetail.deductpp, /*n_tp1     */  
         INPUT-OUTPUT wdetail.deductba, /*n_tp2     */  
         INPUT-OUTPUT wdetail.deductpa, /*n_tp3     */   
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
         INPUT-OUTPUT n_prmtxt,          /* A55-0114 */
         INPUT        inte(wdetail.si),
         INPUT        wdetail.vehreg,
         INPUT-OUTPUT nre_premt).       /* DECI     n_lcd      */ 
END. 
ASSIGN wdetail.premt = string(nre_premt).

/*INPUT-OUTPUT wdetail.branch,   /*n_branch  */*//*add Kridtiya i. A55-0016....*/
/*add Kridtiya i. A55-0016....*/
IF wdetail.branch <> nv_brchk THEN 
    ASSIGN 
    wdetail.comment = wdetail.comment + "�ҢҨҡ����駧ҹ: " + wdetail.branch + " ���ç�Ѻ�Ңҡ����������: "  +  nv_brchk 
    wdetail.pass    = "Y" .
/*end....Add A55-0016..... */
/* add by A63-0130 */
IF wdetail.prempa <> "A" AND DATE(wdetail.comdat) >= 04/01/2020 THEN DO:
   ASSIGN wdetail.prempa = "T" .
END.
/* end A63-0130 */


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
    ASSIGN
        nv_drivvar = ""
        wdetail.drivnam  = "N"     /*����ռ��Ѻ���*/
        chk = NO
        NO_basemsg = " "
        nv_baseprm = aa
        nv_drivvar1 = wdetail.drivnam1.

    IF wdetail.drivnam1 <> ""  THEN  nv_drivno = 1.  
    ELSE IF wdetail.drivnam1 = ""  THEN  nv_drivno = 0. 

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
    /* comment by A63-0130...
    IF wdetail.prepol <> "" THEN  ASSIGN  wdetail.no_41  = STRING(n_41)
                                          wdetail.no_42  = STRING(n_42)
                                          wdetail.no_43  = STRING(n_43).  
     ...... end A63-0130....*/
    /* add by A63-0130 */
    IF wdetail.prepol <> "" THEN  
        ASSIGN  nv_41  = n_41
                nv_42  = n_42
                nv_43  = n_43. 
    ELSE
        ASSIGN  nv_41  = int(wdetail.no_41)
                nv_42  = int(wdetail.no_42)
                nv_43  = int(wdetail.no_43).
     /*....end A63-0130....*/
    IF      wdetail.subclass = "110"  THEN wdetail.seat = "7".
    ELSE IF wdetail.subclass = "210"  THEN wdetail.seat = "12".
    ELSE IF wdetail.subclass = "320"  THEN wdetail.seat = "3".

    IF wdetail.covcod = "2" THEN
        ASSIGN nv_41 = 50000
               nv_42 = 50000
               nv_43 = 200000 .
        
    nv_seat41 = integer(wdetail.seat).   /*integer(wdetail.seat)*/ 
   /* comment by : A64-0138 ...
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                    nv_class,
                    nv_key_b,
                    nv_comdat). 
    ...end : A64-0138..*/
    Assign nv_411var = ""   nv_412var = ""                                                    
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
    /* comment by : A64-0138 ...
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/
    ...end : A64-0138 ...*/
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
    /* comment by : A64-0138...
     DEF VAR dod0 AS INTEGER.
     DEF VAR dod1 AS INTEGER INIT 0 .
     DEF VAR dod2 AS INTEGER.
     DEF VAR dpd0 AS INTEGER.

     IF dod0 > 3000 THEN DO:
         dod1 = 3000.
         dod2 = dod0 - dod1.
     END.
     ..end : A64-0138...*/
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
         /* comment by : A64-0138 ...
         Run  Wgs\Wgsmx025(INPUT  nv_ded,  
                                  nv_tariff,
                                  nv_class,
                                  nv_key_b,
                                  nv_comdat,
                                  nv_cons,
                           OUTPUT nv_prem). 
         .....end : A64-0138 ... */                 
         Assign
             nv_aded1prm     = nv_prem
             nv_dedod2_cod   = "DOD2"
             nv_dedod2var1   = "     Add Ded.OD = "
             nv_dedod2var2   =  STRING(dod2)
             SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
             SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
             nv_dedod2_prm   = nv_prem.
    END.
     /***** pd *******/
    nv_dedpdvar  = " " .
    IF dod0  <> 0 THEN DO:
        Assign
             nv_cons  = "PD"
             /*nv_ded   = dpd0.*/  /* A64-0138  */
             nv_ded   = dod0 .     /* A64-0138  */
        /* comment by : Ranu I. A64-0138...
         Run  Wgs\Wgsmx025(INPUT  nv_ded, 
                                  nv_tariff,
                                  nv_class,
                                  nv_key_b,
                                  nv_comdat,
                                  nv_cons,
                           OUTPUT nv_prem).
         nv_ded2prm    = nv_prem.
         ...end : Ranu I. A64-0138...*/

        ASSIGN nv_dedpdvar = "" 
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(nv_ded)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
            /*nv_dedpd_prm  = nv_prem.*/ 
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
     /* comment by : Ranu I. A64-0138...
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                wdetail.deductpp,
                                wdetail.deductba,
                                wdetail.deductpa).
      ...end : Ranu I. A64-0138...*/
     ELSE 
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
     /* comment by : Ranu I. A64-0138...
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                wdetail.deductpp,
                                wdetail.deductba,
                                wdetail.deductpa).
     ...end : Ranu I. A64-0138...*/
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
        /* IF  (wdetail.covcod = "2") AND (nv_dss_per = 0 )  THEN RUN proc_dsp_ncb.  */ /*A64-0138*/

         IF  nv_dss_per  <> 0  THEN
             Assign
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
         END.
         /*--------------------------*/
         /* comment by : Ranu I. A64-0138...
         RUN WGS\WGSORPRM.P (INPUT  nv_tariff,  
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         wdetail.deductpp,       
                         wdetail.deductba,       
                         wdetail.deductpa). 
          ..end : Ranu I. A64-0138...*/

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
    nv_drivvar1 = wdetail.drivnam1.

    IF wdetail.drivnam1 <> ""  THEN  nv_drivno = 1.  
    ELSE IF wdetail.drivnam1 = ""  THEN  nv_drivno = 0. 

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
        End.
        RUN proc_usdcod.
        ASSIGN nv_drivvar   = " "
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
    Assign  nv_basevar = ""
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
    /* comment by: A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                    nv_class,
                    nv_key_b,
                    nv_comdat). 
    ..end : A64-0138...*/
    Assign   nv_411var = ""  nv_412var = ""                                               
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
    /* comment by: A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/
    ...end : A64-0138...*/
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
     ASSIGN nv_bipvar   = ""
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(uwm130.uom1_v)
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign nv_biavar   = ""
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(uwm130.uom2_v)
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
        /* comment by : A64-0138...
     DEF VAR dod0 AS INTEGER.
     DEF VAR dod1 AS INTEGER INIT 0 .
     DEF VAR dod2 AS INTEGER.
     DEF VAR dpd0 AS INTEGER.

     IF dod0 > 3000 THEN DO:
         dod1 = 3000.
         dod2 = dod0 - dod1.
     END.
     ..end : A64-0138...*/
     IF dod1 <> 0 THEN DO:
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

        ASSIGN nv_dedod1var = ""
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
        /* comment by : A64-0138...
        Run  Wgs\Wgsmx025(INPUT  nv_ded,  
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem). 
        ... end : A64-0138 ...*/     
        Assign
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   =  STRING(dod2)
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
            nv_dedod2_prm   = nv_prem.
     END.
     /***** pd *******/
     IF dod0 <> 0 THEN DO:
        Assign
            nv_dedpdvar  = " "
            nv_cons  = "PD"
            nv_ded   = dod0.     /* A64-0138*/
           /* nv_ded   = dpd0.*/ /* A64-0138*/
        /* comment by : A64-0138 ...
        Run  Wgs\Wgsmx025(INPUT  nv_ded, 
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).
        nv_ded2prm    = nv_prem.
        ...end A64-0138..*/
        ASSIGN nv_dedpdvar = ""
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(nv_ded)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
            /*nv_dedpd_prm  = nv_prem.*/
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
     /* comment by : A64-0138...
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).
     .....end : A64-0138...*/
     ELSE 
     ASSIGN
         nv_fletvar     = " "
         nv_fletvar1    = "     Fleet % = "
         nv_fletvar2    =  STRING(nv_flet_per)
         SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
         SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     /*RUN proc_dsp_ncb. */ /*A64-0138*/

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
     /* comment by : A64-0138 ....
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).
     ... end A64-0138 ...*/
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
         /* comment by : A64-0138...
         RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v ,       
                         nv_uom2_v ,       
                         nv_uom5_v ).
        ... end : A64-0138...*/  

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
         nv_engcst  = 0   /* ��ͧ����ҵ�� nv_cstflg  */         
         /*nv_drivno  = 0*/
         nv_driage1 = 0
         nv_driage2 = 0
         nv_pdprm0  = 0  /*������ǹŴ���Ѻ���*/
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
         nv_netprem = 0     /*�����ط�� */
         nv_gapprm  = 0     /*������� */
         nv_flagprm = "N"   /* N = �����ط��, G = ������� */
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
         nv_class   = trim(wdetail.prempa) +  trim(wdetail.subclass)                                       
         nv_vehuse  = wdetail.vehuse                                    
       /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
         nv_engcst  = 1900*/ /* ��ͧ����ҵ�� nv_cstflg         
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
         nv_411si   = deci(nv_41)       
         nv_412si   = deci(nv_41)       
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
         nv_netprem  = TRUNCATE(((deci(wdetail.volprem) * 100 ) / 107.43 ),0 ) + 
                       (IF ((deci(wdetail.volprem) * 100) / 107.43) - TRUNCATE(((deci(wdetail.volprem) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )
         wdetail.premt = STRING(nv_netprem,">>>,>>>,>>9.99") 
         /*nv_netprem  = DECI(wdetail.premt) *//* �����ط�� */                                                
         nv_gapprm  = 0                                                       
         nv_flagprm = "N"  /* N = �����ط��, G = ������� */                                    
         nv_effdat  = sic_bran.uwm100.comdat                             
         nv_ratatt  = 0                    
         nv_siatt   = 0                                                   
         nv_netatt  = 0 
         nv_fltatt  = 0 
         nv_ncbatt  = 0 
         nv_dscatt  = 0 
         /*nv_status  = "" */
         nv_fcctv   = NO
          . 

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
            FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                WHERE stat.maktab_fil.sclass = wdetail.subclass      AND
                stat.maktab_fil.modcod = wdetail.redbook
                No-lock no-error no-wait.
            If  avail  stat.maktab_fil  Then 
                ASSIGN  
                sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod  
                nv_vehgrp               =  stat.maktab_fil.prmpac
                wdetail.cargrp          =  stat.maktab_fil.prmpac
                sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac.
        END.
        ELSE DO:
         ASSIGN
                wdetail.comment = wdetail.comment + "| " + "Redbook is Null !! "
                wdetail.WARNING = "Redbook �繤����ҧ�������ö������������� " 
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
          nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  �ѹ */
        END.
    END.
    /*
    MESSAGE 
    " wdetail.covcod   "  nv_covcod     skip  
    " wdetail.class    "  nv_class      skip  
    " wdetail.vehuse   "  nv_vehuse     skip  
    " nv_cstflg        "  nv_cstflg     skip  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/
    " nv_engine        "  nv_engcst     skip  /* ��ͧ����ҵ�� nv_cstflg  */
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
                       OUTPUT  nv_message
                       ). 

    /*IF nv_gapprm <> DECI(wdetail.premt) THEN DO:*/
    IF nv_status = "no" THEN DO:
        /*MESSAGE "���¨ҡ�к� " + string(nv_gapprm,">>,>>>,>>9.99") + " �����ҡѺ�������� " + wdetail.premt + nv_message VIEW-AS ALERT-BOX.
        ASSIGN
                wdetail.comment = wdetail.comment + "| " + "���¨ҡ�к� �����ҡѺ�������� "
                wdetail.WARNING = "���¨ҡ�к� " + string(nv_gapprm,">>,>>>,>>9.99") + " �����ҡѺ�������� " + wdetail.premt
              /*wdetail.pass    = "Y" */ /*comment by Kridtiya i. A65-0035*/    
                wdetail.OK_GEN  = "N". *//*comment by Kridtiya i. A65-0035*/ 
        /*  by Kridtiya i. A65-0035*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN
            wdetail.comment = wdetail.comment + "|" + nv_message
            wdetail.WARNING = wdetail.WARNING + "|" + nv_message .  
        /*  by Kridtiya i. A65-0035*/
    END.
    /*  by Kridtiya i. A65-0035 */
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate (input  DATE(wdetail.comdat),
                        input  date(wdetail.expdat),
                        input  wdetail.poltyp,
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
 
 IF wdetail.dealercd <> "" THEN DO:
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
    IF wdetail.prepol = " " THEN DO:     /*����繧ҹ New ��� Check ����¹ö*/
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
    END.      /*����� Check ����¹ö*/
END.          /*note end else*/   /*end note vehreg*/
IF wdetail.cancel = "ca"  THEN  
    ASSIGN
    wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| ���ͼ����һ�Сѹ�繤����ҧ��ٳ������ͼ����һ�Сѹ"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.prempa = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| prem pack �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.branch = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| branch �繤����ҧ �ռŵ�͡���Ѻ��Сѹ���"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.subclass = " " THEN  
    ASSIGN
        wdetail.comment = wdetail.comment + "| sub class �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
IF wdetail.brand = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| Brand �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| model �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N".
/*IF wdetail.seat  = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| seat �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".*/
IF wdetail.caryear = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| year manufacture �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
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
             Message "Class "  nv_sclass "����Ѻ�ػ�ó����������"  View-as alert-box.
             ASSIGN
                 wdetail.comment = wdetail.comment + "| Class��� ����Ѻ�ػ�ó����������"
                 wdetail.pass    = "N"    
                 wdetail.OK_GEN  = "N".
         End.
     END.   -------------A52-0172*/
     /*----------  ncb -------------------*/
     IF wdetail.prepol = ""  THEN DO:
     
     IF wdetail.covcod = "2" THEN RUN proc_dsp_ncb. 
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
             MESSAGE "���� �ú ��ͧ�������Ţ Sticker".
             ASSIGN
                 wdetail.comment = wdetail.comment + "| ���� �ú ��ͧ�������Ţ Sticker"
                 wdetail.pass    = "N"     
                 wdetail.OK_GEN  = "N".
         END.
         /*STR amparat C. A51-0253--*/
         IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
         IF LENGTH(wdetail.stk) < 11 OR LENGTH(wdetail.stk) > 13 THEN DO:
             MESSAGE "�Ţ Sticker ��ͧ�� 11 ���� 13 ��ѡ��ҹ��" VIEW-AS ALERT-BOX.
             ASSIGN /*a490166*/
                 wdetail.comment = wdetail.comment + "| �Ţ Sticker ��ͧ�� 11 ���� 13 ��ѡ��ҹ��"
                 wdetail.pass    = ""
                 wdetail.OK_GEN  = "N".
         END.  /*END amparat C. A51-0253--*/
     END.   -----*/
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
    /*RUN proc_cr_2.  ੾�Чҹ 70 */
    ASSIGN 
        n_rencnt = 0
        n_endcnt = 0
        n_prmtxt = ""     /* A55-0114 */
        nv_dss_per = 0 .  /*A63-0130 */
    IF wdetail.prepol <> " " THEN RUN proc_renew.
    /*comment by Kridtiya i. A55-0008.....
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
    END.
    end...comment by Kridtiya i. A55-0008.....*/
    /*Add by Kridtiya i. A63-0472*/ 
    RUN proc_assign2addr (INPUT  wdetail.iadd1
                         ,INPUT  wdetail.iadd2
                         ,INPUT  wdetail.iadd3 + " " + wdetail.iadd4
                         ,INPUT  wdetail.occup
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
    IF      fi_producer = "A0M1005"    AND wdetail.prepol <> "" THEN ASSIGN fi_producer =  "B3MLKK0101"      wdetail.financecd = "FKK" wdetail.campaign_ov = "RENEW".
    ELSE IF fi_producer = "A0M1005"    THEN ASSIGN  fi_producer =  "B3MLKK0101"      wdetail.financecd = "FKK" wdetail.campaign_ov = "TRANSF".
    ELSE IF fi_producer = "A0M1050"    THEN ASSIGN  fi_producer =  "B3MLKK0102"      wdetail.financecd = "FKK" wdetail.campaign_ov = "REDPLATE".             
    ELSE IF fi_producer = "A0M1054"    THEN ASSIGN  fi_producer =  "B3MLKK0103"      wdetail.financecd = "FKK" wdetail.campaign_ov = "VREDPLATE".            
    ELSE IF fi_producer = "A000190"    THEN ASSIGN  fi_producer =  "B3MLKK0104"      wdetail.financecd = "FKK" wdetail.campaign_ov = "BBREDPLATE".  
    ELSE IF fi_producer = "B3MLKK0101" AND wdetail.prepol <> "" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "RENEW".
    ELSE IF fi_producer = "B3MLKK0101" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "TRANSF".
    ELSE IF fi_producer = "B3MLKK0102" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "REDPLATE".          
    ELSE IF fi_producer = "B3MLKK0103" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "VREDPLATE".         
    ELSE IF fi_producer = "B3MLKK0104" THEN ASSIGN   wdetail.financecd = "FKK" wdetail.campaign_ov = "BBREDPLATE".

    RUN proc_chkcode . /* A64-0138*/
    RUN proc_susspect. 
    /*Add by Kridtiya i. A63-0472*/
    RUN proc_chktest0.
    RUN proc_policy . 
    RUN proc_chktest2.      
    RUN proc_chktest3.      
    RUN proc_chktest4.   
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
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN 
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
    IF wdetail.covcod = "2"  THEN 
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
        ASSIGN
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
        IF substr(n_sclass72,1,1) = "Z" THEN
        Assign 
            sic_bran.uwm130.uom1_v     = deci(wdetail.deductpp)      /*stat.clastab_fil.uom1_si*/
            sic_bran.uwm130.uom2_v     = deci(wdetail.deductba)      /*stat.clastab_fil.uom2_si*/
            sic_bran.uwm130.uom5_v     = deci(wdetail.deductpa).
        ELSE
        ASSIGN      /*stat.clastab_fil.uom5_si*/
            /* comment by A63-0130...
            sic_bran.uwm130.uom1_v     =  stat.clastab_fil.uom1_si        
            sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si        
            sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si  
            .. end A63-0130 ...*/
            /* add by A63-0130 */
            sic_bran.uwm130.uom1_v    = if sic_bran.uwm130.uom1_v <> 0 then sic_bran.uwm130.uom1_v  else stat.clastab_fil.uom1_si
            sic_bran.uwm130.uom2_v    = if sic_bran.uwm130.uom2_v <> 0 then sic_bran.uwm130.uom2_v  else stat.clastab_fil.uom2_si
            sic_bran.uwm130.uom5_v    = if sic_bran.uwm130.uom5_v <> 0 then sic_bran.uwm130.uom5_v  else stat.clastab_fil.uom5_si
            /* end A63-0130 */
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
            sic_bran.uwm130.uom7_c  = "D7".
        /* comment by A63-0130...
        If  wdetail.garage  =  ""  Then
            Assign 
            wdetail.no_41   =  string(stat.clastab_fil.si_41unp)
            wdetail.no_42   =  string(stat.clastab_fil.si_42)
            wdetail.no_43   =  string(stat.clastab_fil.si_43)
            wdetail.seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
        Else If  wdetail.garage  =  "G"  Then
            Assign wdetail.no_41    = string(stat.clastab_fil.si_41pai)
            wdetail.no_42    =   string(stat.clastab_fil.si_42)    
            wdetail.no_43    =   string(stat.clastab_fil.impsi_43)  
            wdetail.seat41   =   stat.clastab_fil.dri_41 + clastab_fil.pass_41.    
        ... end A63-0130....*/
       /* add by A63-0130. */
        If  wdetail.garage  =  ""  Then
            Assign 
            wdetail.no_41   =  string(stat.clastab_fil.si_41unp)
            wdetail.no_42   =  string(stat.clastab_fil.si_42)
            wdetail.no_43   =  string(stat.clastab_fil.si_43)
            wdetail.seat41  =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
        Else If  wdetail.garage  =  "G"  Then
            Assign wdetail.no_41    = string(stat.clastab_fil.si_41pai)
            wdetail.no_42    =   string(stat.clastab_fil.si_42)    
            wdetail.no_43    =   string(stat.clastab_fil.impsi_43)  
            wdetail.seat41   =   stat.clastab_fil.dri_41 + clastab_fil.pass_41.    
        /*... end A63-0130....*/ 
        
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
    nv_covcod =   wdetail.covcod 
    nv_makdes  =  wdetail.brand 
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
             sic_bran.uwm301.bchyr  = nv_batchyr               
             sic_bran.uwm301.bchno  = nv_batchno               
             sic_bran.uwm301.bchcnt = nv_batcnt   
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
             sic_bran.uwm301.body      = wdetail.body
             sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
             /*sic_bran.uwm301.mv_ben83  = IF INDEX(wdetail.benname,"�á��")  <> 0 THEN "��Ҥ�� ���õԹҤԹ �ӡѴ (��Ҫ�)" ELSE ""*/ /*A61-0335*/
             sic_bran.uwm301.mv_ben83  = trim(wdetail.bennefit)  /*A61-0335*/
             sic_bran.uwm301.vehreg    = wdetail.vehreg
             sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
             sic_bran.uwm301.vehuse    = wdetail.vehuse
             sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
             sic_bran.uwm301.sckno     = 0
             sic_bran.uwm301.itmdel    = NO
             /*sic_bran.uwm301.prmtxt    = "".  *//*IF wdetail.poltyp = "v70" THEN "������ͧ�ػ�ó쵡���Ҥ�����Թ 20,000 �ҷ" ELSE "" .*/
             sic_bran.uwm301.prmtxt    = n_prmtxt .  /*A55-0114 */
             wdetail.tariff            = sic_bran.uwm301.tariff.
         
         s_recid4         = RECID(sic_bran.uwm301).
         /*-- maktab_fil --*/
         IF wdetail.redbook <> "" THEN DO:
             /*AND chkred = YES  THEN DO:*/
             FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass      AND
                 stat.maktab_fil.modcod = wdetail.redbook
                 No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN  sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                     wdetail.cargrp          =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
                     wdetail.body            =  stat.maktab_fil.body .
         END.
         ELSE DO:
             FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
                 makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL makdes31  THEN
                 ASSIGN nv_simat  = makdes31.si_theft_p   
                 nv_simat1 = makdes31.load_p   .    
             ELSE ASSIGN 
                 nv_simat  = 0
                 nv_simat1 = 0.
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
                 Assign
                 wdetail.redbook         =  stat.maktab_fil.modcod
                 wdetail.body            =  stat.maktab_fil.body 
                 wdetail.weight          =  STRING(stat.maktab_fil.tons)
                 sic_bran.uwm301.tons    =  stat.maktab_fil.tons
                 sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                 wdetail.cargrp          =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.body    =  stat.maktab_fil.body
                 sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes.
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

run proc_calpremt .      /*A64-0138*/
run proc_adduwd132prem . /*A64-0138*/

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
        /*sic_bran.uwm301.ncbper   = nv_ncbper */ /*A64-0138*/
        /*sic_bran.uwm301.ncbyrs   = nv_ncbyrs */ /*A64-0138*/
        sic_bran.uwm301.mv41seat = inte(wdetail.seat)
    /* assign A63-0130 */
        sic_bran.uwm301.tons     = IF sic_bran.uwm301.tons = 0 THEN 0 ELSE IF sic_bran.uwm301.ton < 100 THEN ( sic_bran.uwm301.tons * 1000 )
                                   ELSE sic_bran.uwm301.tons .

IF sic_bran.uwm301.tons < 100  AND ( SUBSTR(sic_bran.uwm120.CLASS,2,1) = "3"   OR  
     SUBSTR(sic_bran.uwm120.CLASS,2,1) = "4"   OR  SUBSTR(sic_bran.uwm120.CLASS,2,1) = "5"  OR  
     SUBSTR(sic_bran.uwm120.CLASS,2,3) = "803" OR SUBSTR(sic_bran.uwm120.CLASS,2,3) = "804" OR  
     SUBSTR(sic_bran.uwm120.CLASS,2,3) = "805" ) THEN DO:
       ASSIGN
            wdetail.comment = wdetail.comment + "| " + sic_bran.uwm120.CLASS + " �кع��˹ѡö���١��ͧ "
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
END.
/* end a63-0129 */
/* comment by :A64-0138..
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).*/
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
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*�¡�ҹ��� Code Producer*/  
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
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*�¡�ҹ��� Code Producer*/  
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
     ASSIGN nv_com1p = 0.00.  /*�ҹ kk �����  com1A = 0.00 */
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
Create  sic_bran.uwm100.   /*Create ��� gateway*/    
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cr_2 C-Win 
PROCEDURE proc_cr_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF VAR len AS INTE.
DEF BUFFER buwm100 FOR wdetail.
    ASSIGN
    len = LENGTH(wdetail.policy)
    len = len - 1    .
    FOR EACH buwm100 WHERE 
        substr(buwm100.policy,2,len) = SUBSTR(wdetail.policy,2,len) AND
                buwm100.policy    <> wdetail.policy  NO-LOCK.
        ASSIGN 
            n_cr2 = buwm100.policy.
    END.
    */
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
/* comment by : A64-0138...
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
...end A64-0138..*/             
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
/* comment by : A64-0138...
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
 ...end : A64-0138...*/
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
            IF  R-INDEX(TRIM(wdetail.tiname),"��.")             <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"�ӡѴ")           <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"(��Ҫ�)")         <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"����ѷ")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"�.")                <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"���.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"˨�.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"�ʹ.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"����ѷ")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"��ŹԸ�")           <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"��ҧ")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ")      <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ�ӡѴ") <> 0  OR
                INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ�ӡ")   <> 0  OR  
                INDEX(TRIM(wdetail.tiname),"���/����")          <> 0  THEN nv_typ = "Cs".
            ELSE nv_typ = "0s".   /*0s= �ؤ�Ÿ����� Cs = �ԵԺؤ��*/
        END.
        ELSE DO:  /* ---- Check ���� name ---- */
            IF  R-INDEX(TRIM(wdetail.tiname),"��.")             <> 0  OR              
                R-INDEX(TRIM(wdetail.tiname),"�ӡѴ")           <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"(��Ҫ�)")         <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"����ѷ")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"�.")                <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"���.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"˨�.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"�ʹ.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"����ѷ")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"��ŹԸ�")           <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"��ҧ")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ")      <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ�ӡѴ") <> 0  OR
                INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ�ӡ")   <> 0  OR  
                INDEX(TRIM(wdetail.tiname),"���/����")          <> 0  THEN nv_typ = "Cs".
            ELSE nv_typ = "0s".         /*0s= �ؤ�Ÿ����� Cs = �ԵԺؤ��  */
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
                wdetail.comment = wdetail.comment + "| �����١����繤����ҧ�������ö������к�����" 
                WDETAIL.OK_GEN  = "N"
                nv_transfer = NO.
        END.    /**/
    END.
    n_insref = nv_insref.
END.
ELSE DO:
    IF sicsyac.xmm600.acno <> "" THEN DO:
        ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            n_insref                = caps(trim(nv_insref)) 
            nv_transfer             = NO 
            sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname    = ""                        /*First Name*/
            sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
            sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
            sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1    = wdetail.iadd1             /*Address line 1*/
            sicsyac.xmm600.addr2    = wdetail.iadd2             /*Address line 2*/
            sicsyac.xmm600.addr3    = wdetail.iadd3             /*Address line 3*/
            sicsyac.xmm600.addr4    = wdetail.iadd4             
            sicsyac.xmm600.homebr   = TRIM(wdetail.branch)   /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                     
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid  
            sicsyac.xmm600.dtyp20   = ""
            /*sicsyac.xmm600.dval20   = "DOB" + wdetail.birthday*/    .       /*-- Add chutikarn A50-0072 --*/
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
        sicsyac.xmm600.name     = TRIM(wdetail.insnam)       /*Name Line 1*/
        sicsyac.xmm600.abname   = TRIM(wdetail.insnam)       /*Abbreviated Name*/
        sicsyac.xmm600.icno     = TRIM(wdetail.ICNO)        /*IC No.*/     /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = wdetail.iadd1             /*Address line 1*/
        sicsyac.xmm600.addr2    = wdetail.iadd2             /*Address line 2*/
        sicsyac.xmm600.addr3    = wdetail.iadd3             /*Address line 3*/
        sicsyac.xmm600.addr4    = wdetail.iadd4             /*Address line 4*/
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
        /*sicsyac.xmm600.dval20   = "DOB" + wdetail.birthday*/ .
        /*sicsyac.xmm600.dval20   = "DOB" + trim(wdetail.birthday)*/     /*string(wdetail.brithday).*/
END.
IF sicsyac.xmm600.acno <> "" THEN DO:              /*A55-0268 add chk nv_insref = "" */
    ASSIGN nv_insref = trim(sicsyac.xmm600.acno)
        nv_transfer  = YES.
    FIND sicsyac.xtm600 WHERE
        sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
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
            sicsyac.xtm600.acno    = nv_insref               /*Account no.*/
            sicsyac.xtm600.name    = TRIM(wdetail.insnam)    /*Name of Insured Line 1*/
            sicsyac.xtm600.abname  = TRIM(wdetail.insnam)    /*Abbreviated Name*/
            sicsyac.xtm600.addr1   = wdetail.iadd1           /*address line 1*/
            sicsyac.xtm600.addr2   = wdetail.iadd2           /*address line 2*/
            sicsyac.xtm600.addr3   = wdetail.iadd3           /*address line 3*/
            sicsyac.xtm600.addr4   = wdetail.iadd4           /*address line 4*/
            sicsyac.xtm600.name2   = ""                                                 /*Name of Insured Line 2*/ 
            sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)                               /*Title*/
            sicsyac.xtm600.name3   = ""                                                 /*Name of Insured Line 3*/
            sicsyac.xtm600.fname   = "" .                                               /*First Name*/
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
/*Add by Kridtiya i. A63-0472*/
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno     = nv_insref  NO-ERROR NO-WAIT.  
IF AVAIL sicsyac.xmm600 THEN
    ASSIGN
    sicsyac.xmm600.acno_typ  = trim(wdetail.insnamtyp)   /*�������١��� CO = �ԵԺؤ��  PR = �ؤ��*/   
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
/*Add by Kridtiya i. A63-0472*/
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
        "�����١��� �֧�����Ţ�ش�������� / ¡��ԡ��÷ӧҹ���Ǥ���"      SKIP
        "���ǵԴ��ͼ���� Code"  VIEW-AS ALERT-BOX. */
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
        sic_bran.uwm301.seats   =  stat.maktab_fil.seats .
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
            sic_bran.uwm301.seats   =  stat.maktab_fil.seats  .
    
END.


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
IF  R-INDEX(TRIM(np_textname),"��.")             <> 0  OR              
    R-INDEX(TRIM(np_textname),"�ӡѴ")           <> 0  OR  
    R-INDEX(TRIM(np_textname),"(��Ҫ�)")         <> 0  OR  
    R-INDEX(TRIM(np_textname),"INC.")            <> 0  OR 
    R-INDEX(TRIM(np_textname),"CO.")             <> 0  OR 
    R-INDEX(TRIM(np_textname),"LTD.")            <> 0  OR 
    R-INDEX(TRIM(np_textname),"LIMITED")         <> 0  OR 
    INDEX(TRIM(np_textname),"����ѷ")            <> 0  OR 
    INDEX(TRIM(np_textname),"�.")                <> 0  OR 
    INDEX(TRIM(np_textname),"���.")              <> 0  OR 
    INDEX(TRIM(np_textname),"˨�.")              <> 0  OR 
    INDEX(TRIM(np_textname),"�ʹ.")              <> 0  OR 
    INDEX(TRIM(np_textname),"����ѷ")            <> 0  OR 
    INDEX(TRIM(np_textname),"��ŹԸ�")           <> 0  OR 
    INDEX(TRIM(np_textname),"��ҧ")              <> 0  OR 
    INDEX(TRIM(np_textname),"��ҧ�����ǹ")      <> 0  OR 
    INDEX(TRIM(np_textname),"��ҧ�����ǹ�ӡѴ") <> 0  OR
    INDEX(TRIM(np_textname),"��ҧ�����ǹ�ӡ")   <> 0  OR  
    INDEX(TRIM(np_textname),"���/����")          <> 0  THEN DO: 
    /*  Cs = �ԵԺؤ�� */
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
            /*MESSAGE "Sticker Number"  wdetail.stk "�� Generate ����� ���ͧ�ҡ Modulo Error"  VIEW-AS ALERT-BOX.*/
            ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number �� Generate ����� ���ͧ�ҡ Module Error".
        /*comment by Kridtiya i. A55-0008......����觹�������к����.........
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
                    /*MESSAGE "�����Ţ������������١������� "  VIEW-AS ALERT-BOX.*/
                    ASSIGN wdetail.pass = "N"
                    wdetail.comment     = wdetail.comment + "| �Ţ����ѭ�ҹ����١���������к� Premium "
                    wdetail.warning  = "Program Running Policy No. �����Ǥ���".
            END.
        END.
        ASSIGN nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.detaitem THEN 
            /*MESSAGE "�����Ţ Sticker ��������١����������Ţ���������� ." stat.Detaitem.policy VIEW-AS ALERT-BOX.*/
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| �����Ţ Sticker ��������١�������"
            wdetail.warning = "Program Running Policy No. �����Ǥ���".
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
                    /*MESSAGE "�����Ţ������������١������� "  VIEW-AS ALERT-BOX.*/
                    ASSIGN wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| �Ţ����ѭ�ҹ����١���������к� Premium "
                    wdetail.warning = "Program Running Policy No. �����Ǥ���".
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
            /*MESSAGE "Sticker Number"  wdetail.stk "�� Generate ����� ���ͧ�ҡ Modulo Error"  VIEW-AS ALERT-BOX.*/
            ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number �� Generate ����� ���ͧ�ҡ Module Error".
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
                    /*MESSAGE "�����Ţ������������١������� "  VIEW-AS ALERT-BOX.*/
                    ASSIGN wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| �Ţ����ѭ�ҹ����١���������к� Premium "
                    wdetail.warning = "Program Running Policy No. �����Ǥ���".
            END.
        END.
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            /*MESSAGE "�����Ţ Sticker ��������١����������Ţ���������� ." stat.Detaitem.policy VIEW-AS ALERT-BOX.*/
            ASSIGN                               
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| �����Ţ Sticker ��������١�������"
            wdetail.warning = "Program Running Policy No. �����Ǥ���".
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
IF wdetail.tiname = " " THEN wdetail.tiname = "�س".
ELSE DO:
    FIND FIRST brstat.msgcode WHERE 
        brstat.msgcode.compno  = "999" AND
        brstat.msgcode.MsgDesc = wdetail.tiname   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN  wdetail.tiname  =  trim(brstat.msgcode.branch).
    ELSE wdetail.tiname = "�س".
END.
IF wdetail.prepol = "" THEN n_firstdat = wdetail.comdat.
/*Add A57-0015 */
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
                wdetail.comment = wdetail.comment + "| �Ţ�ѵû�ЪҪ����١��ͧ"
                wdetail.warning = "Program Running Policy No. �����Ǥ���".
        END.
    END.
END.    /* A58-0015 */
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
      sic_bran.uwm100.ntitle = wdetail.tiname     /*"�س" */ /*kridtiya i. A54-0203    */           
      sic_bran.uwm100.name1  = TRIM(wdetail.insnam)  
      sic_bran.uwm100.name2  = ""
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
      sic_bran.uwm100.cedpol  = IF wdetail.kkapp <> "" THEN trim(wdetail.kkapp) ELSE trim(wdetail.cedpol) /*A61-0335*/
      sic_bran.uwm100.finint  = ""
      sic_bran.uwm100.bs_cd  = " "      /*vat code */
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
                  sic_bran.uwm100.prvpol  = wdetail.prepol     /*����繧ҹ Renew  ��ͧ����繤����ҧ*/
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
        MESSAGE "�����ó��ա�õ����������" VIEW-AS ALERT-BOX .
        ASSIGN  wdetail.prepol = "Already Renew" /*������������繧ҹ�������*/
            wdetail.comment    = wdetail.comment + "| �����ó��ա�õ����������" 
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
        RUN proc_assignrenew.      /*�Ѻ��� ����������ͧ�ͧ��� */
    END.
END.        /*  avail  uwm100  */
ELSE DO:
    ASSIGN
        n_rencnt        = 0  
        n_Endcnt        = 0
        wdetail.prepol  = ""
        n_prmtxt        = ""  
        wdetail.comment = wdetail.comment + "| �繡������������بҡ����ѷ���  ".
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
            wdetail.NO_41       ","   
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
        wdetail.NO_41        ","   
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
    /*CONNECT expiry -H 18.10.100.5 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.   */
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
            wdetail.comment = wdetail.comment + "|ö�����һ�Сѹ �Դ suspect ����¹ " + nn_vehreglist + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
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
            wdetail.comment = wdetail.comment + "|���ͼ����һ�Сѹ �Դ suspect �س" + nn_namelist + " " + nn_namelist2 + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
    ELSE DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = Trim(nn_namelist  + " " + nn_namelist2)        
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN 
                wdetail.comment = wdetail.comment + "|���ͼ����һ�Сѹ �Դ suspect �س" + nn_namelist + " " + nn_namelist2 + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
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
            wdetail.comment = wdetail.comment + "|ö�����һ�Сѹ �Դ suspect �Ţ��Ƕѧ " + nv_chanolist + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
END.
IF (nv_msgstatus = "") AND (nv_idnolist <> "") THEN DO:
    
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp08    WHERE 
        sicuw.uzsusp.notes = nv_idnolist   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN wdetail.comment = wdetail.comment + "|ID�����һ�Сѹ �Դ suspect ID: " + nv_idnolist2 + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
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
                wdetail.comment = wdetail.comment + "|ID�����һ�Сѹ �Դ suspect ID: " + nv_idnolist2 + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
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
    nv_txt1  = "�����ػ�ó쵡�������������Թ 20,000.00 �ҷ"
    nv_txt2  = "�ѹ����駧ҹ SAFE : " + wdetail.revday 
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
    IF nv_line1 = 1  THEN wuppertxt3.txt = wdetail.nmember .
    IF nv_line1 = 2  THEN wuppertxt3.txt = "�Ţ����ѭ����ҫ��� : " + substr(wdetail.cedpol,1,LENGTH(wdetail.cedpol) - 4 ) .
    IF nv_line1 = 3  THEN wuppertxt3.txt = "�����˵� : "            + wdetail.benname . 
    IF nv_line1 = 4  THEN wuppertxt3.txt = "Remak1 : "              + wdetail.remak1 . 
    IF nv_line1 = 5  THEN wuppertxt3.txt = "Remak2 : "              + wdetail.remak2 . 
    IF nv_line1 = 6  THEN wuppertxt3.txt = "����Դ��� : " + wdetail.phone  + "  " + "�Ţ��Шӵ�Ǽ���������� : " + wdetail.tax.         /*A60-0232*/
    IF nv_line1 = 7  THEN wuppertxt3.txt = "�ѹ��͹���Դ : " + wdetail.bdate .                                                         /*A60-0232*/
    IF nv_line1 = 8  THEN wuppertxt3.txt = "�Ҫվ : " + wdetail.occup + "  " + "ʶҹ�Ҿ : " + wdetail.cstatus.                           /*A60-0232*/
    IF nv_line1 = 9  THEN wuppertxt3.txt = "���͡������ 1 : " + wdetail.tname1 + " " + wdetail.cname1 + " " + wdetail.lname1 + " " +     /*A60-0232*/
                                           "ICNO1 :" + wdetail.icno1.                                                                    /*A60-0232*/
    IF nv_line1 = 10 THEN wuppertxt3.txt = "���͡������ 2 : " + wdetail.tname2 + " " + wdetail.cname2 + " " + wdetail.lname2 + " " +     /*A60-0232*/
                                           "ICNO2 :" + wdetail.icno2.                                                                    /*A60-0232*/
    IF nv_line1 = 11 THEN wuppertxt3.txt = "���͡������ 3 : " + wdetail.tname3 + " " + wdetail.cname3 + " " + wdetail.lname3 + " " +     /*A60-0232*/
                                           "ICNO3 :" + wdetail.icno3.                                                                    /*A60-0232*/
    IF nv_line1 = 12 THEN wuppertxt3.txt = "�Ѵ���͡��÷���Ң�: " + wdetail.nsend + " ���ͼ���Ѻ�͡���: " + wdetail.sendname .   /*A61-0335*/
    IF nv_line1 = 13 THEN wuppertxt3.txt = "�Ţ����ѭ�� : " + wdetail.cedpol.                                                   /*A61-0335*/
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

