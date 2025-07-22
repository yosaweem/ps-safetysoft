&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases 
sic_test         PROGRESS  */
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/
CREATE WIDGET-POOL.
/* ***************************  Definitions  **************************        */
/* Parameters Definitions ---                                                  */
/* Local Variable Definitions ---                                              */  
/*******************************/                                              
/*programid   : wgwtcg72.w                                                     */ 
/*programname : load text file Tisco to GW (พรบ.)                              */ 
/* Copyright  : Safety Insurance Public Company Limited                        */
/*copy write  : wgwatcgen.w                                                    */ 
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                             */
/*create by   : Kridtiya i. A55-0184    date . 27/06/2012                      
                ปรับโปรแกรมให้สามารถนำเข้า text file Tisco to GW system (พรบ.) */
/*modify by   : Kridtiya i. A54-0112 ขยายช่องทะเบียนรถ จาก 10 เป็น 11 หลัก     */
/*modify by   : Kridtiya i. A56-0323 เพิ่มการรับค่า icno                       */
/*modify by   : Kridtiya i. A57-0017 เพิ่มการรับค่า seat by file               */
/*modify by   : Kridtiya i. A57-0088 date. 10/03/2014 ปรับการรับค่ารหัสรถ(Redbook)จากไฟล์*/
/*modify by   : Kridtiya i. A57-0431 date. 02/12/2014 เพิ่ม code รถ redbook   */
/*Modify By   : MANOP G.  A59-0178  เปลี่ยนแปลง FORMAT การโหลด File   -*/
/*Modify By   : MANOP G.  A59-0503  เปลี่ยนแปลง รหัสจังหวัดจากตัวย่อเป็นตัวเต็ม   -*/
/*Modify by   : Ranu I. A60-0095 เพิ่มการเช็ค ISUZU และทะเบียน */
/*Modify by   : Ranu I. A60-0206 เพิ่มการเก็บข้อมูลที่ uwm301.trareg*/
/*Modify by   : Ranu I. A60-0405 เพิ่มการเช็คเลขบัตรประชาชนไม่ครบ 13 หลัก */
/*Modify by   : Ranu I. A61-0045 date : 29/01/2018 แก้ไขการ Create เลขกรมธรรม์ */
/*Modify by   : Ranu I. A61-0410 date : 09/09/2018 แก้ไขการเช็คข้อมูลเบี้ยไม่เต็มปี */
/* comment in proc_defintions */
DEF VAR n_firstdat AS CHAR FORMAT "x(10)"  INIT "".
DEF VAR n_brand    AS CHAR FORMAT "x(50)"  INIT "".
DEF VAR n_model    AS CHAR FORMAT "x(50)"  INIT "".
DEF VAR n_index    AS INTE  INIT 0.
DEF VAR stklen     AS INTE.
DEF VAR dod0       AS DECI.
DEF VAR dod1       AS DECI.
DEF VAR dod2       AS DECI.
DEF VAR dpd0       AS DECI.
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
DEF NEW  SHARED VAR   nv_ncb_cod   AS CHAR     FORMAT "X(4)".
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
DEF NEW  SHARED VAR   nv_vehuse   LIKE sicuw.uwm301.vehuse.                 
DEF NEW  SHARED VAR   nv_grpcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_grprm   AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_grpvar1 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_grpvar2 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_grpvar  AS CHAR      FORMAT "X(60)".
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
DEF NEW  SHARED VAR nv_tariff     LIKE sicuw.uwm301.tariff.
DEF NEW  SHARED VAR nv_comdat     LIKE sicuw.uwm100.comdat.
DEF NEW  SHARED VAR nv_covcod     LIKE sicuw.uwm301.covcod.
DEF NEW  SHARED VAR nv_class      AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_key_b      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEF NEW  SHARED VAR nv_drivno     AS INT       .
DEF NEW  SHARED VAR nv_drivcod    AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_drivprm    AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_drivvar1   AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_drivvar2   AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_drivvar    AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_usecod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_useprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_usevar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_usevar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_usevar   AS CHAR  FORMAT "X(60)".
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
DEF NEW  SHARED VAR nv_engine  LIKE sicsyac.xmm102.engine.
DEF NEW  SHARED VAR nv_tons    LIKE sicsyac.xmm102.tons.
DEF NEW  SHARED VAR nv_seats   LIKE sicsyac.xmm102.seats.
DEF NEW  SHARED VAR nv_sclass  AS CHAR FORMAT "x(3)".
DEF NEW  SHARED VAR nv_engcod  AS CHAR FORMAT "x(4)".
DEF NEW  SHARED VAR nv_engprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_engvar1 AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_engvar2 AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_engvar  AS CHAR  FORMAT "X(60)".
DEF VAR             NO_CLASS   AS CHAR INIT "".
DEF VAR             no_tariff  AS CHAR INIT "".
def New  shared var nv_poltyp  as   char   init  "".
DEF NEW  SHARED VAR nv_yrcod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_yrprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_yrvar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_yrvar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_yrvar   AS CHAR  FORMAT "X(60)".
DEF New  shared VAR nv_caryr   AS INTE  FORMAT ">>>9" .
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
{wgw\wgwtcg72.i}      /*ประกาศตัวแปร*/
DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE  WORKFILE makt NO-UNDO
/*1*/  FIELD brand1    AS CHAR   FORMAT "x(30)"
/*2*/  FIELD model1     AS CHARACTER FORMAT "X(50)"   INITIAL "".
DEFINE VAR nv_basere    AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0. 
DEFINE VAR n_sclass72   AS CHAR FORMAT "x(4)".
DEFINE VAR nv_maxdes    AS CHAR.
DEFINE VAR nv_mindes    AS CHAR.
DEFINE VAR nv_si        AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_maxSI     AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_minSI     AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */
DEFINE VAR nv_newsck    AS CHAR FORMAT "x(15)" INIT " ".
DEFINE VAR nv_simat     AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEFINE VAR nv_simat1    AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_uwm301trareg    LIKE sicuw.uwm301.cha_no INIT "".
DEF VAR gv_id    AS CHAR FORMAT "X(8)" NO-UNDO.
DEF VAR gv_sp2   AS CHAR FORMAT "x(2)" NO-UNDO.
DEF VAR gv_ver   AS CHAR NO-UNDO.
DEF VAR gv_prdid AS CHAR FORMAT "x(40)" NO-UNDO.
DEF VAR gv_sp1   AS CHAR FORMAT "x(1)" NO-UNDO.
DEF VAR gv_date  AS DATE NO-UNDO.
DEF VAR gv_time  AS CHAR NO-UNDO.
DEF VAR nv_pwd   AS CHAR NO-UNDO.
DEF VAR nv_log   AS CHAR FORMAT "X(100)".
DEF VAR n_db     AS CHAR FORMAT "X(10)".
DEF WORKFILE wk_db
    FIELD phyname  AS CHAR FORMAT "x(10)"
    FIELD unixpara AS CHAR FORMAT "x(10)".
DEFINE  WORKFILE wcomp NO-UNDO
/*1*/FIELD package     AS CHARACTER FORMAT "X(10)"   INITIAL ""
/*2*/FIELD premcomp    AS DECI FORMAT "->>,>>9.99"    INITIAL 0
     FIELD ev  AS CHAR .   
DEF VAR n_packcomp AS CHAR FORMAT "X(10)"   INITIAL "".
DEF VAR nv_72Reciept   AS CHAR FORMAT "X(50)" INIT "".

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
&Scoped-define FIELDS-IN-QUERY-br_comp wcomp.package wcomp.premcomp   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_comp   
&Scoped-define SELF-NAME br_comp
&Scoped-define QUERY-STRING-br_comp FOR EACH wcomp
&Scoped-define OPEN-QUERY-br_comp OPEN QUERY br_comp FOR EACH wcomp.
&Scoped-define TABLES-IN-QUERY-br_comp wcomp
&Scoped-define FIRST-TABLE-IN-QUERY-br_comp wcomp


/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.WARNING /*A60-0405*/ wdetail.redbook wdetail.policyno wdetail.poltyp wdetail.branch wdetail.producer wdetail.agent wdetail.tiname wdetail.insnam wdetail.addr1 wdetail.tambon wdetail.amper wdetail.country wdetail.comdat wdetail.expdat wdetail.covcod wdetail.garage wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.body wdetail.seat   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail .
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_comp fiCompno bu_del bu_add fi_packcom ~
fi_loaddat fi_pack fi_branch fi_producer fi_agent fi_bchno fi_prevbat ~
fi_bchyr fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt ~
fi_usrprem rbuok bu_exit bu_hpbrn bu_hpacno1 bu_hpagent br_wdetail ~
fi_process fi_premcomp rs_type RECT-372 RECT-373 RECT-374 RECT-375 RECT-376 ~
RECT-377 RECT-378 RECT-379 
&Scoped-Define DISPLAYED-OBJECTS fiCompno fi_packcom fi_loaddat fi_pack ~
fi_branch fi_producer fi_agent fi_bchno fi_prevbat fi_bchyr fi_filename ~
fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_proname ~
fi_agtname fi_impcnt fi_process fi_completecnt fi_premtot fi_premsuc ~
fi_premcomp rs_type 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_add 
     LABEL "ADD" 
     SIZE 6 BY .95.

DEFINE BUTTON bu_del 
     LABEL "DEL" 
     SIZE 6 BY .95.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.

DEFINE BUTTON rbuok 
     LABEL "OK" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE VARIABLE fiCompno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
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
     SIZE 40 BY 1
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
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
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_packcom AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premcomp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY 1
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "New", 1,
"Renew", 2
     SIZE 24 BY 1
     BGCOLOR 10 FGCOLOR 2  NO-UNDO.

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 14.29
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 5.38
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 4.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-375
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 129.17 BY 3.1
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 126.17 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18 BY 2
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.5 BY 2.33
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
      wcomp.package    COLUMN-LABEL "Package" FORMAT "x(10)"
      wcomp.premcomp   COLUMN-LABEL "Premcomp"   FORMAT "->>>,>>9.99"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 30.5 BY 5.05
         BGCOLOR 15 FONT 6 FIT-LAST-COLUMN.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.WARNING   FORMAT "x(30)" COLUMN-LABEL "Warning"     /*A60-0405*/  
    wdetail.redbook   FORMAT "x(10)"  COLUMN-LABEL "redbook." 
    wdetail.policyno  FORMAT "x(20)"  COLUMN-LABEL "Policy No."
    wdetail.poltyp    FORMAT "x(4)"   COLUMN-LABEL "Policy Type."
    wdetail.branch    FORMAT "x(2)"   COLUMN-LABEL "Branch."
    wdetail.producer  FORMAT "x(10)"  COLUMN-LABEL "producer"
    wdetail.agent     FORMAT "x(10)"  COLUMN-LABEL "agent"
    wdetail.tiname    FORMAT "x(20)"  COLUMN-LABEL "tiname"
    wdetail.insnam    FORMAT "x(50)"  COLUMN-LABEL "insnam"
    wdetail.addr1     FORMAT "x(40)"  COLUMN-LABEL "addr"
    wdetail.tambon    FORMAT "x(35)"  COLUMN-LABEL "tampon"
    wdetail.amper     FORMAT "x(35)"  COLUMN-LABEL "amper"
    wdetail.country   FORMAT "x(20)"  COLUMN-LABEL "country"
    wdetail.comdat    FORMAT "x(10)"  COLUMN-LABEL "comdate."   
    wdetail.expdat    FORMAT "x(10)"  COLUMN-LABEL "expidate." 
    wdetail.covcod    FORMAT "x(1)"   COLUMN-LABEL "covcod"
    wdetail.garage    FORMAT "x(1)"   COLUMN-LABEL "garage"
    wdetail.prempa    FORMAT "x(1)"   COLUMN-LABEL "prempa" 
    wdetail.subclass  FORMAT "x(3)"   COLUMN-LABEL "subclass"
    wdetail.brand     FORMAT "x(15)"  COLUMN-LABEL "brand."       
    wdetail.model     FORMAT "x(40)"  COLUMN-LABEL "model."      
    wdetail.body      FORMAT "x(15)"  COLUMN-LABEL "body."      
    wdetail.seat      FORMAT "99"   COLUMN-LABEL "seats."
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 4.76
         BGCOLOR 15 FONT 6.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_comp AT ROW 5.67 COL 100.5
     fiCompno AT ROW 2.91 COL 76.5 COLON-ALIGNED NO-LABEL
     bu_del AT ROW 4.57 COL 123.33
     bu_add AT ROW 3.62 COL 123.33
     fi_packcom AT ROW 3.57 COL 109.83 COLON-ALIGNED NO-LABEL
     fi_loaddat AT ROW 2.81 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 2.81 COL 63.17 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.91 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6.1 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.05 COL 15.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_prevbat AT ROW 7.24 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 7.24 COL 67 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 8.33 COL 32.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 8.33 COL 95.17
     fi_output1 AT ROW 9.43 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 10.52 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 11.62 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 13.76 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 13.76 COL 77.5 NO-LABEL
     rbuok AT ROW 11.1 COL 104.5
     bu_exit AT ROW 13.24 COL 104.33
     fi_brndes AT ROW 3.91 COL 52.17 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 3.91 COL 41.33
     bu_hpacno1 AT ROW 5 COL 49.83
     bu_hpagent AT ROW 6.1 COL 49.83
     fi_proname AT ROW 5 COL 52.17 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6.05 COL 52.17 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 15.57 COL 2
     fi_impcnt AT ROW 21.48 COL 60.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 12.71 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 22.48 COL 60.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 21.48 COL 97 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 22.52 COL 95 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premcomp AT ROW 4.62 COL 109.83 COLON-ALIGNED NO-LABEL
     rs_type AT ROW 1.33 COL 107 NO-LABEL WIDGET-ID 6
     "                     Branch  :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 3.91 COL 10.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "        Load Text & Generate TISCO(พรบ. 72)" VIEW-AS TEXT
          SIZE 95 BY 1.1 AT ROW 1.33 COL 2.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 11.62 COL 10.5
          BGCOLOR 18 FGCOLOR 1 
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.48 COL 61 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY 1 AT ROW 13.76 COL 75 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Previous Batch No.  :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 7.24 COL 10.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "TYPE :" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 1.33 COL 99 WIDGET-ID 10
          BGCOLOR 10 FGCOLOR 2 
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 10.52 COL 10.5
          BGCOLOR 18 FGCOLOR 1 
     "Model :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 2.91 COL 71
          BGCOLOR 18 FGCOLOR 1 
     "              Agent Code  :" VIEW-AS TEXT
          SIZE 23 BY 1.05 AT ROW 6.1 COL 10.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.1
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "                 Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 2.81 COL 10.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.05 COL 5.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 9.43 COL 10.5
          BGCOLOR 18 FGCOLOR 1 
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 8.33 COL 10.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "          Producer  Code :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 5 COL 10.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 2.81 COL 54.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "     **ใช้ Format file Hold Load **" VIEW-AS TEXT
          SIZE 32 BY .95 AT ROW 2.33 COL 99 WIDGET-ID 4
          BGCOLOR 1 FGCOLOR 7 
     "Packcomp :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 3.57 COL 98.83
          BGCOLOR 5 FGCOLOR 0 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 22.48 COL 94.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Base comp :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 4.62 COL 98.83
          BGCOLOR 5 FGCOLOR 0 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 21.48 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "20/08/2024":60 VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 13.76 COL 121.33 WIDGET-ID 2
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 21.48 COL 94.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY 1 AT ROW 7.24 COL 66.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 13.76 COL 31.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 21.48 COL 61 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 13.76 COL 95.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.48 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-372 AT ROW 1 COL 1
     RECT-373 AT ROW 15.29 COL 1
     RECT-374 AT ROW 20.67 COL 1
     RECT-375 AT ROW 21 COL 2.83
     RECT-376 AT ROW 21.24 COL 4.33
     RECT-377 AT ROW 10.71 COL 102.83
     RECT-378 AT ROW 12.81 COL 102.83
     RECT-379 AT ROW 3.38 COL 121.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.1
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
         TITLE              = "Load Text & Generate TISCO(พรบ. 72)"
         HEIGHT             = 24.1
         WIDTH              = 133
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
/* BROWSE-TAB br_wdetail fi_agtname fr_main */
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
          SIZE 12.83 BY 1 AT ROW 7.24 COL 66.5 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 20 BY 1 AT ROW 13.76 COL 31.67 RIGHT-ALIGNED             */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY 1 AT ROW 13.76 COL 75 RIGHT-ALIGNED              */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 21.48 COL 61 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 21.48 COL 94.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.48 COL 61 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 22.48 COL 94.83 RIGHT-ALIGNED       */

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
OPEN QUERY br_query FOR EACH wdetail .
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* Load Text  Generate TISCO(พรบ. 72) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text  Generate TISCO(พรบ. 72) */
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

      wdetail.WARNING  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
      wdetail.redbook  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
      wdetail.policyno :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
      wdetail.poltyp   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
      wdetail.branch   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
      wdetail.producer :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
      wdetail.agent    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
      wdetail.tiname   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.     
      wdetail.insnam   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
      wdetail.addr1    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
      wdetail.tambon   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
      wdetail.amper    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
      wdetail.country  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
      wdetail.comdat   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
      wdetail.expdat   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
      wdetail.covcod   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
      wdetail.garage   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
      wdetail.prempa   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
      wdetail.subclass :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
      wdetail.redbook  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
      wdetail.brand    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
      wdetail.model    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
      wdetail.body     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
      wdetail.seat     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
     
      wdetail.WARNING  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
      wdetail.redbook  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
      wdetail.policyno :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
      wdetail.poltyp   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.branch   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.producer :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.agent    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.tiname   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.insnam   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.addr1    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.tambon   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.amper    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.country  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.   
      wdetail.comdat   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.expdat   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
      wdetail.covcod   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.garage   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.prempa   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
      wdetail.subclass :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
      wdetail.brand    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.model    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.body     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
      wdetail.seat     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 

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
        FIND LAST WComp WHERE wcomp.package = trim(fi_packcom) AND
            wcomp.premcomp  = fi_premcomp NO-ERROR NO-WAIT.
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


&Scoped-define SELF-NAME fiCompno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCompno c-Win
ON LEAVE OF fiCompno IN FRAME fr_main
DO:
  fiCompno = INPUT fiCompno .
  DISP fiCompno WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_packcom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_packcom c-Win
ON LEAVE OF fi_packcom IN FRAME fr_main
DO:
    fi_packcom =  Input  fi_packcom.
    Disp  fi_packcom  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_premcomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_premcomp c-Win
ON LEAVE OF fi_premcomp IN FRAME fr_main
DO:
    fi_premcomp =  Input  fi_premcomp.
    Disp  fi_premcomp  with  frame  fr_main.
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


&Scoped-define SELF-NAME rbuok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rbuok c-Win
ON CHOOSE OF rbuok IN FRAME fr_main /* OK */
DO:
    For each  wdetail :
        DELETE  wdetail.
    END.
    For each  wdetail2 :
        DELETE  wdetail2.
    END.
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
    IF fi_output1  = "" THEN DO:
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
        FIND LAST uzm700 USE-INDEX uzm70002    WHERE 
            uzm700.bchyr   = nv_batchyr        AND
            uzm700.acno    = TRIM(fi_producer) AND
            uzm700.branch  = TRIM(nv_batbrn)   NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:   
            nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102 WHERE
                uzm701.bchyr   = nv_batchyr        AND
                uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN  
                ASSIGN nv_batcnt = uzm701.bchcnt  
                nv_batrunno = nv_batrunno + 1.
        END.
        ELSE  ASSIGN nv_batcnt   = 1
                     nv_batrunno = 1.
        nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END.
    ELSE DO:  
        nv_batprev = INPUT fi_prevbat.
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
    FOR EACH wdetail:
        IF WDETAIL.POLTYP = "v70"  THEN  
            ASSIGN nv_reccnt =  nv_reccnt   + 1
            nv_netprm_t      =  nv_netprm_t + decimal(wdetail.premt)
            wdetail.pass     = "Y". 
        ELSE IF WDETAIL.POLTYP =  "v72" THEN  
            ASSIGN nv_reccnt = nv_reccnt   + 1
            nv_netprm_t      = nv_netprm_t + decimal(wdetail.comp_prm)
            wdetail.pass     = "Y". 
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
                           INPUT            "WGWTCG72" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem       /* DECI  */
                           ).
    ASSIGN  fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.
    RUN proc_chktest1.  
    FOR EACH wdetail WHERE  wdetail.pass = "y" :
        IF WDETAIL.POLTYP =  "v70" THEN  
            ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + decimal(wdetail.premt).
        ELSE
            ASSIGN
                nv_completecnt = nv_completecnt + 1
                nv_netprm_s    = nv_netprm_s    + decimal(wdetail.comp_prm).
    END.
    ASSIGN 
        nv_rectot = nv_reccnt      
        nv_recsuc = nv_completecnt. 
    IF /*nv_imppol <> nv_rectot OR
         nv_imppol <> nv_recsuc OR*/
        nv_rectot <> nv_recsuc   THEN DO:
        nv_batflg = NO.
        /*MESSAGE "Policy import record is not match to Total record !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE IF   /*nv_impprem  <> nv_netprm_t OR
               nv_impprem  <> nv_netprm_s OR*/
        nv_netprm_t <> nv_netprm_s THEN DO:
        IF nv_rectot = nv_recsuc  THEN nv_batflg = YES.
        ELSE nv_batflg = NO.
             /*MESSAGE "Total net premium is not match to Total net premium !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE  nv_batflg = YES.
    FIND LAST uzm701 USE-INDEX uzm70102  
        WHERE uzm701.bchyr = nv_batchyr   AND
              uzm701.bchno = nv_batchno   AND
              uzm701.bchcnt  = nv_batcnt  NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        ASSIGN
            uzm701.recsuc   = nv_recsuc     
            uzm701.premsuc  = nv_netprm_s   
            uzm701.rectot   = nv_rectot     
            uzm701.premtot  = nv_netprm_t   
            uzm701.impflg   = nv_batflg    
            uzm701.cnfflg   = nv_batflg .   
    END.
    ASSIGN
        fi_impcnt      = nv_rectot
        fi_premtot     = nv_netprm_t
        fi_completecnt = nv_recsuc
        fi_premsuc     = nv_netprm_s .
    IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.
    RELEASE sicsyac.xtm600.
    RELEASE sicsyac.xmm600.
    RELEASE sicsyac.xzm056.
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_process = " Please check Data again...!!! "
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
    ELSE IF nv_batflg = YES THEN DO: 
        ASSIGN
            fi_process = "Process Complete..."
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.
    RUN   proc_open.    
    DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_bchno WITH FRAME fr_main.
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  . 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type c-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type .
    DISP rs_type WITH FRAME fr_main.
  
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
    DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)"  NO-UNDO.
    
    gv_prgid = "Wgwtcg72.w".
    gv_prog  = "Load Text & Generate TISCO(พรบ. 72)".
    fi_loaddat = TODAY.
    RUN proc_createcomp.
    OPEN QUERY br_comp FOR EACH wcomp.
    DISP fi_loaddat WITH FRAME fr_main.
    RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).  
    ASSIGN
        fiCompno    = "model_tis"
        fi_pack     = "F"
        fi_branch   = "M"
        /*fi_producer = "A0M2012"*/   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
        /*fi_agent    = "B3M0002"*/   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        fi_producer = "B3MLTIS104"    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/   
        fi_agent    = "B3MLTIS200"    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        fi_bchyr    = YEAR(TODAY)
        rs_type     = 1 /*A67-0114*/
        fi_process  = "Load Text file Tisco ......" .
    DISP fiCompno fi_pack fi_branch fi_producer fi_agent fi_bchyr fi_process rs_type WITH FRAME fr_main.
    /*********************************************************************/  
    RUN  WUT\WUTWICEN (c-win:handle).  
    Session:data-Entry-Return = Yes.
    
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assign c-Win 
PROCEDURE 00-proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0114...
DO:
    DEF BUFFER buwm100 FOR wdetail.
    DEF VAR nv_chkstk  AS LOGICAL INIT NO.
    ASSIGN 
        nv_chkstk = NO
        fi_process = "Start create wdetail...compulsary...".
    DISP fi_process WITH FRAM fr_main.
    For each  wdetail2 :
        DELETE  wdetail2.
    END.
    For each  wdetail :
        DELETE  wdetail.
    End.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail2.
        IMPORT DELIMITER "|" 
            wdetail2.Pro_off        /*2   2   รหัสสาขาที่ผู้เอาประกันภัยเปิดบัญชี */        
            wdetail2.cmr_code       /*3...3   รหัสเจ้าหน้าที่การตลาด              */        
            wdetail2.comcode        /*4...3   รหัสบริษัทประกัน 3หลัก  */        
            wdetail2.policyno       /*5...25  เลขที่รับแจ้งประกัน  */     
            wdetail2.caryear        /*6...4   ปีรถ*/     
            wdetail2.eng            /*7...25  เครื่อง ยนต์  */
            wdetail2.chasno         /*8...25  หมายเลขตัวถัง  */
            wdetail2.engcc          /*9...5   น้ำหนัก         */
            wdetail2.power          /*10..7   กำลังเครื่องยนต์*/
            wdetail2.colorcode      /*11...2  สีรถ  */
            wdetail2.vehreg         /*12...2  ทะเบียน */     
            wdetail2.garage         /*13...2  การซ่อม */
            wdetail2.fleetper       /*14...2  ส่วนลดหมู่ */
            wdetail2.ncb            /*15..3   ส่วนลดประวัติดี*/
            wdetail2.orthper        /*16...3  ส่วนลดอื่นๆ */
            wdetail2.vehuse         /*17...2  การใช้งาน */
            wdetail2.comdat         /*18...2  วันเริ่มคุ้มครอง */
            wdetail2.si             /*19...2   ทุน*/
            wdetail2.name_insur     /*20...2   ชื่อเจ้าหน้าที่ประกัน*/
            wdetail2.not_office     /*21...3   รหัสเจ้าหน้าที่แจ้งประกัน*/
            wdetail2.entdat         /*22...3   วันที่แจ้งประกัน*/
            wdetail2.enttim         /*23...2   เวลาแจ้งประกัน*/
            wdetail2.not_code       /*24...2   รหัสแจ้งงาน*/        
            wdetail2.premt          /*25...2   เบี้ยประกันรวม  ภาษี อากร*/
            wdetail2.comp_prm       /*26...2   เบี้ยพรบ.  ภาษี อากร*/
            wdetail2.stk            /*27...3   สติ๊กเกอร์*/
            wdetail2.brand          /*28...3   ยี่ห้อ*/
            wdetail2.addr1          /*29...2   ที่อยูผู้เอาประกัน1*/
            wdetail2.addr2          /*30...2   ที่อยูผู้เอาประกัน2*/
            wdetail2.tiname         /*31...2   คำนำหน้า*/
            wdetail2.insnam         /*32...2   ชื่อลูกค้า*/
            wdetail2.name2          /*33...3   นามสกุล*/
            wdetail2.benname        /*34...3   ผู้รับผลประโยชน์*/
            wdetail2.remark         /*35...2   หมายเหตุ*/
            wdetail2.Account_no     /*36...2   เลขที่สัญญาของผู้เอาประกัน*/         
            wdetail2.client_no      /*37...2   รหัสของผู้เอาประกัน*/
            wdetail2.expdat         /*38...2   วันสิ้นสุดความคุ้มครอง*/
            wdetail2.gap            /*39...3   เบี้ยรวม พรบ*/
            wdetail2.re_country     /*40...3   จังหวัดที่จดทะเบียน*/
            wdetail2.receipt_name   /*41...2   ชื่อออกใบเสร็จ*/
            wdetail2.agent          /*42...2   บริษัท*/
            wdetail2.prev_insur     /*43...2   บริษัทประกันภัยเดิม*/
            wdetail2.prepol         /*44...2   เลขกรมธรรม์เดิม*/
            wdetail2.deduct         /*45...3   ส่วนลดเสียหายแรก*/
            wdetail2.add1_70        /*46 add1 ภาคสมัครใจ         */
            wdetail2.add2_70        /*47 add2 ภาคสมัครใจ         */
            wdetail2.Sub_Di_70      /*48 Sub Dist. 1149 1178 30  */
            wdetail2.Direc_70       /*49 Direction 1179 1208 30  */
            wdetail2.Provi_70       /*50 Province  1209 1238 30  */
            wdetail2.ZipCo_70       /*51 ZipCode   1239 1243 5   */
            wdetail2.add1_72        /*52 add1 ภาคสมัครใจ         */
            wdetail2.add2_72        /*53 add2 ภาคสมัครใจ         */
            wdetail2.Sub_Di_72      /*54 Sub Dist. 1149 1178 30  */
            wdetail2.Direc_72       /*55 Direction 1179 1208 30  */
            wdetail2.Provi_72       /*56 Province  1209 1238 30  */
            wdetail2.ZipCo_72       /*57 ZipCode   1239 1243 5   */
            wdetail2.apptype        /*58 application type h = ยังไม่ออกกรมธรรม์ p = ออกกรมธรรม์ได้*/
            wdetail2.appcode        /*59 application code [HP, H2, H6, HN, HM, HG] */
            wdetail2.nBLANK         /*60 */
            wdetail2.prempa         /*61 package*/
            wdetail2.seate          /*add A57-0017 add seate */
            wdetail2.tp1            /*62 pd 1   */
            wdetail2.tp2            /*63 pd 2   */
            wdetail2.tp3            /*64 pd 3   */
            wdetail2.covcod         /*65 covcod */
            wdetail2.producer       /*66 Producerr -*/
            wdetail2.agent1         /*67 Agent -*/
            wdetail2.nbranch        /*68 Branch -*/
            wdetail2.npolty         /*69 Poltyp -*/
            wdetail2.nredbook       /*70 Red Book -*/
            wdetail2.Price_Ford     /* Price Ford */                                                                  
            wdetail2.Year_fd        /* Year FD */                                                                     
            wdetail2.Brand_Model                                                                                      
            wdetail2.id_no70        /*“เลขทีบัตรประจำตัวประชาชน/เลขทีหนังสือเดินทาง /เลขทะเบียนพาณิชย์”*/           
            wdetail2.id_nobr70      /*สาขาของสถานประกอบการลูกค้า*/                                                    
            wdetail2.id_no72        /*“เลขทีบัตรประจำตัวประชาชน/เลขทีหนังสือเดินทาง /เลขทะเบียนพาณิชย์”*/           
            wdetail2.id_nobr72      /*สาขาของสถานประกอบการลูกค้า*/                                                    
            wdetail2.comp_comdat    /*Effective Date Accidential*/            
            wdetail2.comp_expdat    /*Expiry Date Accidential*/               
            wdetail2.fi             /*Coverage Amount Theft*/                 
            wdetail2.class          /*Car code*/                              
            wdetail2.usedtype       /*Per Used*/                              
            wdetail2.driveno1       /*Driver Seq1*/                                 
            wdetail2.drivename1     /*Driver Name1*/                                
            wdetail2.bdatedriv1     /*Birthdate Driver1*/                           
            wdetail2.occupdriv1     /*Occupation Driver1*/                          
            wdetail2.positdriv1     /*Position Driver1 */                           
            wdetail2.driveno2       /*Driver Seq2*/                                 
            wdetail2.drivename2     /*Driver Name2*/                                
            wdetail2.bdatedriv2     /*Birthdate Driver2*/                           
            wdetail2.occupdriv2     /*Occupation Driver2*/                          
            wdetail2.positdriv2     /*Position Driver2*/                            
            wdetail2.driveno3       /*Driver Seq3*/                                 
            wdetail2.drivename3     /*Driver Name3*/                                
            wdetail2.bdatedriv3     /*Birthdate Driver3*/                           
            wdetail2.occupdriv3     /*Occupation Driver3*/                          
            wdetail2.positdriv3     /*Position Driver3*/                            
            wdetail2.nBLANK         /* A57-0088 */
            wdetail2.Reciept72  

    END.    /* repeat  */
    /*comment by Kridtiya i. A65-0360 close tombon amper provin
    FOR EACH wdetail2  .
        IF      index(wdetail2.Pro_off,"บริษัท") > 0 THEN DELETE wdetail2.
        ELSE IF index(wdetail2.Pro_off,"Pro") >    0 THEN DELETE wdetail2.
        ELSE IF index(wdetail2.Pro_off,"Totle") >  0 THEN DELETE wdetail2.
        ELSE IF (wdetail2.policyno = "") AND (wdetail2.Account_no = "") THEN DELETE wdetail2.
        ELSE IF wdetail2.Pro_off  = ""               THEN DELETE wdetail2.
        /*comment by Kridtiya i. A65-0360 close tombon amper provin
        ELSE DO:
            IF (INDEX(wdetail2.Provi_72,"กรุง") <> 0) OR (INDEX(wdetail2.Provi_72,"กทม") <> 0) THEN  
                ASSIGN 
                wdetail2.Sub_Di_72  = IF wdetail2.Sub_Di_72 = "" THEN "" ELSE "แขวง" + wdetail2.Sub_Di_72 /*54 Sub Dist. 1149 1178 30  */
                wdetail2.Direc_72   = IF wdetail2.Direc_72  = "" THEN "" ELSE "เขต" + wdetail2.Direc_72   /*55 Direction 1179 1208 30  */
                wdetail2.Provi_72   = IF wdetail2.Provi_72  = "" THEN "" ELSE wdetail2.Provi_72           /*56 Province  1209 1238 30  */
                wdetail2.ZipCo_72   = IF wdetail2.ZipCo_72  = "" THEN "" ELSE wdetail2.ZipCo_72 .         /*57 ZipCode   1239 1243 5   */
            ELSE 
                ASSIGN 
                    wdetail2.Sub_Di_72  = IF wdetail2.Sub_Di_72 = "" THEN "" ELSE "ตำบล" + wdetail2.Sub_Di_72   /*54 Sub Dist. 1149 1178 30  */
                    wdetail2.Direc_72   = IF wdetail2.Direc_72  = "" THEN "" ELSE "อำเภอ" + wdetail2.Direc_72   /*55 Direction 1179 1208 30  */
                    wdetail2.Provi_72   = IF wdetail2.Provi_72  = "" THEN "" ELSE "จังหวัด" + wdetail2.Provi_72 /*56 Province  1209 1238 30  */
                    wdetail2.ZipCo_72   = IF wdetail2.ZipCo_72  = "" THEN "" ELSE wdetail2.ZipCo_72 .           /*57 ZipCode   1239 1243 5   */
        END.
        end.comment by Kridtiya i. A65-0360 close tombon amper provin */

    END.*/
    RUN proc_assign1.  /* Add by Kridtiya i. A65-0360*/

    FOR EACH wdetail2 WHERE deci(wdetail2.comp_prm) > 0    NO-LOCK.
        ASSIGN n_policy72 = "" 
               n_packcomp = "".
       /* comment by Ranu A61-0045............
        IF wdetail2.policyno = "" THEN DO: 
            IF LENGTH(TRIM(wdetail2.Account_no)) <= 12 THEN 
                 ASSIGN n_policy72 = "TC72" + TRIM(wdetail2.Account_no) .
            ELSE ASSIGN n_policy72 = "TC72" + substr(TRIM(wdetail2.Account_no),1,12) .
        END.
        ELSE IF INDEX(wdetail2.policyno,",") <> 0 THEN
            ASSIGN n_policy72 = "TC72" +  trim(substr(wdetail2.policyno,1,INDEX(wdetail2.policyno,",") - 1 )).
        ELSE n_policy72 = "TC72" + trim(wdetail2.policyno) .
        ....................end A61-0045..............*/
        /* ------- Create by Ranu A61-0045----------*/
        IF wdetail2.policyno = "" THEN DO: 
            IF LENGTH(TRIM(wdetail2.Account_no)) <= 12 THEN 
                 ASSIGN n_policy72 = "72" + TRIM(wdetail2.Account_no) .
            ELSE ASSIGN n_policy72 = "72" + substr(TRIM(wdetail2.Account_no),1,12) .
        END.
        ELSE IF INDEX(wdetail2.policyno,",") <> 0 THEN
            ASSIGN n_policy72 = "72" +  trim(substr(wdetail2.policyno,1,INDEX(wdetail2.policyno,",") - 1 )).
        ELSE n_policy72 = "72" + trim(wdetail2.policyno) .
        /*---------end A61-0045------------*/
        /*IF LENGTH(n_policy72) > 16 THEN ASSIGN n_policy72 = SUBSTR(n_policy72,1,16).*/ /*A64-0092*/
        IF LENGTH(n_policy72) > 16 THEN ASSIGN n_policy72 = "72" + SUBSTR(n_policy72,7,16).     /*A64-0092*/

        FIND FIRST wcomp WHERE  wcomp.premcomp  = deci(wdetail2.comp_prm) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL wcomp  THEN ASSIGN n_packcomp = wcomp.package . 
        ELSE DO:
            /* create by a61-0410*/
            IF index(wdetail2.prempa,"210") <>  0   THEN ASSIGN n_packcomp = "120A".
            ELSE if index(wdetail2.prempa,"110") <> 0 THEN ASSIGN n_packcomp = "110".
            ELSE if index(wdetail2.prempa,"320") <> 0 THEN ASSIGN n_packcomp = "140A".
            ELSE n_packcomp = "".
           /* end a61-0410*/
        END.
        /* ---A60-0095---*/
        ASSIGN 
            n_brand = IF INDEX(wdetail2.brand," ") <> 0 THEN trim(SUBSTR(wdetail2.brand,1,INDEX(wdetail2.brand," ") - 1 )) ELSE trim(wdetail2.brand).
        IF n_brand = "ISUZU" AND index(wdetail2.prempa,"210") <> 0 THEN ASSIGN n_packcomp = "140A".
        IF index(wdetail2.prempa,"520") <> 0 THEN DO: 
            IF wdetail2.usedtype = "1" THEN  ASSIGN n_packcomp = "160".
            ELSE ASSIGN n_packcomp = "260".
        END.
        /* ---end a60-0095---*/
        FIND FIRST wdetail WHERE wdetail.policyno = n_policy72 NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN 
                wdetail.policyno   =   trim(n_policy72)   
                wdetail.cedpol     =   trim(wdetail2.policyno)
                wdetail.renpol     =   TRIM(wdetail2.policyno)  /*A61-0410*/
                wdetail.caryear    =   trim(wdetail2.caryear)    
                wdetail.eng        =   trim(wdetail2.eng)  
                wdetail.chasno     =   trim(wdetail2.chasno)     
                wdetail.engcc      =   trim(wdetail2.power)       
                wdetail.vehreg     =   trim(wdetail2.vehreg)     
                wdetail.garage     =   trim(wdetail2.garage)     
                wdetail.fleetper   =   deci(trim(wdetail2.fleetper))   
                wdetail.ncb        =   deci(trim(wdetail2.ncb))        
                wdetail.orthper    =   trim(wdetail2.orthper)    
                /*wdetail.vehuse     =   trim(wdetail2.vehuse)*/ /*A60-0095*/
                wdetail.vehuse     =   ""                        /*A60-0095*/
                wdetail.comdat     =   TRIM(wdetail2.comp_comdat)  /* วันคุ้มครอง พ.ร.บ. */
                /*-wdetail.comdat     =   trim(wdetail2.comdat)    -*/
                wdetail.si         =   trim(wdetail2.si)         
                wdetail.name_insur =   trim(wdetail2.name_insur) 
                wdetail.not_office =   trim(wdetail2.not_office) 
                wdetail.entdat     =   trim(wdetail2.entdat) 
                wdetail.enttim     =   trim(wdetail2.enttim) 
                wdetail.not_code   =   trim(wdetail2.not_code)   
                wdetail.premt      =   trim(wdetail2.premt)   
                wdetail.comp_prm   =   trim(wdetail2.comp_prm)   
                wdetail.stk        =   trim(wdetail2.stk)        
                wdetail.brand      =   trim(wdetail2.brand) 
                wdetail.redbook    =   TRIM(wdetail2.nredbook)     /*A57-0088*/
                wdetail.addr1      =   IF (trim(wdetail2.add1_72) + " " +
                                           trim(wdetail2.add2_72) + " " + 
                                           trim(wdetail2.Sub_Di_72) + " " + 
                                           trim(wdetail2.Direc_72) + " " + 
                                           trim(wdetail2.Provi_72) + " " +
                                           trim(wdetail2.ZipCo_72)) = "" THEN 
                                          (trim(wdetail2.add1_70) + " " + 
                                           trim(wdetail2.add2_70)  + " " + 
                                           trim(wdetail2.Sub_Di_70)  + " " + 
                                           trim(wdetail2.Direc_70)  + " " + 
                                           trim(wdetail2.Provi_70)  + " " + 
                                           trim(wdetail2.ZipCo_70))     
                                       ELSE 
                                           trim(wdetail2.add1_72) + " " +
                                           trim(wdetail2.add2_72) + " " + 
                                           trim(wdetail2.Sub_Di_72) + " " + 
                                           trim(wdetail2.Direc_72) + " " + 
                                           trim(wdetail2.Provi_72) + " " +
                                           trim(wdetail2.ZipCo_72) 
                /*wdetail.tambon   =   trim(wdetail2.tambon)       
                wdetail.amper      =   trim(wdetail2.amper)        
                wdetail.country    =   trim(wdetail2.country)  */    
                wdetail.tiname     =   trim(wdetail2.tiname)      
                wdetail.insnam     =   trim(trim(wdetail2.insnam) + " " + trim(wdetail2.name2))  
                wdetail.benname    =   trim(wdetail2.benname)         
                wdetail.remark     =   trim(wdetail2.remark)       
                wdetail.Account_no =   trim(wdetail2.Account_no)   
                wdetail.client_no  =   trim(wdetail2.client_no)    
                wdetail.expdat     =   trim(wdetail2.comp_expdat)           /* วันสิ้นสุด พ.ร.บ. */  
                /*-wdetail.expdat     =   trim(wdetail2.expdat)       -*/
                wdetail.gap        =   trim(wdetail2.gap)          
                wdetail.re_country =   trim(wdetail2.re_country)   
                /*wdetail.receipt_name = trim(wdetail2.receipt_name)  -V72 Receipt Name-*/
                wdetail.receipt_name =     TRIM(wdetail2.Reciept72)   
                wdetail.prepol     =   ""      
                wdetail.deduct     =   trim(wdetail2.deduct)       
                wdetail.branch     =   caps(trim(wdetail2.nbranch))       
                wdetail.tp1        =   trim(wdetail2.tp1)          
                wdetail.tp2        =   trim(wdetail2.tp2)          
                wdetail.tp3        =   trim(wdetail2.tp3)          
                wdetail.covcod     =   "T"    
                wdetail.poltyp     =   "V72"
                wdetail.prepol     =  trim(wdetail2.prepol)
                /*wdetail.subclass   =  SUBSTR(wdetail2.prempa,2,3)*//*add A57-0017 */
                wdetail.subclass   =  n_packcomp                                            /*add A57-0017 */
                wdetail.seat       = IF (wdetail2.seate = "") OR (deci(trim(wdetail2.seate)) = 0 ) THEN 0 ELSE INTE(wdetail2.seate)    /*add A57-0017 */
                wdetail.prempa     = IF  trim(wdetail2.prempa) = "" THEN trim(fi_pack)
                                     ELSE SUBSTR(trim(wdetail2.prempa),1,1)
                wdetail.comment    = ""
                wdetail.producer   = IF trim(wdetail2.producer) = "" THEN caps(trim(fi_producer)) ELSE trim(wdetail2.producer) 
                wdetail.agent      = IF trim(wdetail2.agent1)   = "" THEN caps(trim(fi_agent))    ELSE trim(wdetail2.agent1)     
                wdetail.entdat     = string(TODAY)              /*entry date*/
                wdetail.enttim     = STRING(TIME,"HH:MM:SS")    /*entry time*/
                wdetail.trandat    = STRING(fi_loaddat)         /*tran  date*/
                wdetail.trantim    = STRING(TIME,"HH:MM:SS")    /*tran  time*/
                wdetail.n_IMPORT   = "IM"
                wdetail.n_EXPORT   = "" 
                wdetail.colorcode = wdetail2.colorcode   /*A65-0356*/
                wdetail.br_insured = wdetail2.id_nobr72.
                
            END.
    END.
    FOR EACH wdetail NO-LOCK.
        IF wdetail.stk <> "" THEN DO:
            FOR EACH buwm100 WHERE buwm100.stk   =  wdetail.stk  NO-LOCK.
                IF  buwm100.policyno <>  wdetail.policyno  THEN DO:
                    MESSAGE "พบเลขสติ๊กเกอร์ซ้ำในไฟล์เดียวกัน : " wdetail.policyno " " wdetail.stk  VIEW-AS ALERT-BOX.
                    ASSIGN nv_chkstk = YES.
                    
                END.
            END.
        END.
    END.
    IF nv_chkstk = YES THEN DO: 
        FOR EACH wdetail.
            DELETE wdetail.
        END.
    END.
    ELSE RUN proc_assign2.
END.
...end A67-0114...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  DISPLAY fiCompno fi_packcom fi_loaddat fi_pack fi_branch fi_producer fi_agent 
          fi_bchno fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 
          fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname 
          fi_impcnt fi_process fi_completecnt fi_premtot fi_premsuc fi_premcomp 
          rs_type 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE br_comp fiCompno bu_del bu_add fi_packcom fi_loaddat fi_pack fi_branch 
         fi_producer fi_agent fi_bchno fi_prevbat fi_bchyr fi_filename bu_file 
         fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem rbuok bu_exit 
         bu_hpbrn bu_hpacno1 bu_hpagent br_wdetail fi_process fi_premcomp 
         rs_type RECT-372 RECT-373 RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
         RECT-379 
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
/*comment by kridtiya i. A57-0017.....
DEF VAR stklen AS INTE.
ASSIGN wdetail.compul = "y"
    wdetail.tariff = "9"
    wdetail.covcod = "T"
    n_sclass72     = ""
    /*n_sclass72     = substr(wdetail.subclass,1,3)*/
    wdetail.stk    = substr(wdetail.stk,1,length(TRIM(wdetail.stk))) .
/*add A56-0104*/
IF wdetail.subclass = ""  THEN
    ASSIGN  wdetail.comment = wdetail.comment + "| คลาสเป็นค่าว่าง เซตคลาสตามเบี้ยพรบ..!!!"   
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".  
ELSE DO:
        FIND FIRST sicsyac.xzmcom WHERE  sicsyac.xzmcom.comp_cod = substr(wdetail.subclass,1,1) + "." + substr(wdetail.subclass,2)   NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xzmcom  THEN ASSIGN n_sclass72 = SUBSTR(sicsyac.xzmcom.class,2,3) .
        ELSE n_sclass72 = "".
    END.
/*A56-0104*/
/*FIND FIRST sicsyac.xzmcom  WHERE 
    REPLACE(sicsyac.xzmcom.comp_cod,".","")  = wdetail.subclass  AND 
    substr(xzmcom.class,1,1) = fi_pack   NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xzmcom THEN ASSIGN n_sclass72 =   xzmcom.class .*/

/*FIND FIRST sicsyac.xzmcom   USE-INDEX xzmcom01   WHERE
    sicsyac.xzmcom.class    = wdetail.prempa + wdetail.subclass   NO-LOCK NO-ERROR .
IF AVAIL sicsyac.xzmcom THEN
    ASSIGN n_sclass72 = wdetail.subclass
    wdetail.subclass  = replace(sicsyac.xzmcom.comp_cod,".","") 
    wdetail.subclass  = replace(wdetail.subclass," ","").
FIND LAST sicsyac.xmm106 WHERE 
    sicsyac.xmm106.tariff  = "9"      AND
    sicsyac.xmm106.bencod  = "comp"   AND
    substr(sicsyac.xmm106.class,1,3) = SUBSTR(wdetail.subclass,1,3)            AND
    sicsyac.xmm106.covcod  = "t"                                               AND 
   (sicsyac.xmm106.baseap  = TRUNCATE(((deci(wdetail.comp_prm) * 100 ) / 107.43 ),0) OR
    sicsyac.xmm106.baseap  = ROUND(((deci(wdetail.comp_prm) * 100 ) / 107.43 ),0))   NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm106 THEN
    ASSIGN wdetail.subclass = sicsyac.xmm106.class .*/

IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk <> "" THEN DO:  
        ASSIGN stklen = 0
            stklen    = INDEX(trim(wdetail.stk)," ") - 1.
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN DO:
            IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN DO: 
                IF stklen > 1 THEN wdetail.stk = "0" + substr(wdetail.stk,1,stklen).
                ELSE wdetail.stk = "0" + substr(wdetail.stk,1,LENGTH(wdetail.stk)).
            END.
        END.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN  wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
            wdetail.pass    = ""
            wdetail.OK_GEN  = "N".
    END.
END.
IF wdetail.branch = ""  THEN  /* A56-0323 */
    ASSIGN  wdetail.comment = wdetail.comment + "| พบสาขาเป็นค่าว่างไม่สามารถนำเข้าระบบได้"  /* A56-0323 */
    wdetail.pass    = "N"     /* A56-0323 */
    wdetail.OK_GEN  = "N".    /* A56-0323 */
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class = wdetail.subclass  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
    wdetail.pass    = "N"
    wdetail.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101      WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp   AND
        sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN  wdetail.pass = "N"
        wdetail.comment      = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
        wdetail.OK_GEN       = "N".
END.
/*---------- covcod ----------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
    wdetail.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
    wdetail.OK_GEN = "N".
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
ASSIGN chkred  = NO
    n_brand    = ""
    n_index    = 0
    n_model    = "".
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + n_sclass72  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN n_ratmin = makdes31.si_theft_p   
        n_ratmax        = makdes31.load_p   .    
    ELSE ASSIGN n_ratmin = 0
        n_ratmax         = 0.
    IF index(wdetail.brand,"benz") <> 0 THEN DO: 
        IF INDEX(wdetail.brand," ") <> 0 THEN  
            ASSIGN wdetail.model = SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1 )
            wdetail.brand = "MERCEDES-BENZ".
        IF INDEX(wdetail.model," ") <> 0 THEN 
            ASSIGN wdetail.model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ") - 1 ).
        IF index(wdetail.model,"cls") <> 0 THEN DO:
            IF index(wdetail.model," ") <> 0   THEN
                ASSIGN wdetail.model = SUBSTR(wdetail.model,1,index(wdetail.model," ") - 1) +
                SUBSTR(wdetail.model,index(wdetail.model," ") + 1) .
            IF index(wdetail.model," ") <> 0   THEN
                ASSIGN wdetail.model = SUBSTR(wdetail.model,1,index(wdetail.model," ") - 1) .
        END.
    END.
    ELSE DO:
        IF INDEX(wdetail.brand," ") <> 0 THEN  
            ASSIGN wdetail.model = SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1 )
            wdetail.brand = SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 ).
        /*RUN proc_model_brand.*/
        IF      INDEX(wdetail.model,"vigo")   <> 0 THEN wdetail.model = "vigo".
        ELSE IF INDEX(wdetail.model,"altis")  <> 0 THEN wdetail.model = "altis".
        ELSE IF INDEX(wdetail.model,"soluna") <> 0 THEN wdetail.model = "vios".
        ELSE IF INDEX(wdetail.model,"HIACE")  <> 0 THEN 
            ASSIGN wdetail.seat = 12
            wdetail.model  = "HIACE"
            n_sclass72   = "210" .
        ELSE IF INDEX(wdetail.model," ") <> 0 THEN 
            ASSIGN wdetail.model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ") - 1 ).
    END.
    IF deci(wdetail.si) = 0 THEN DO:
        IF (Integer(wdetail.engcc) = 0 )  THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04         Where
                stat.maktab_fil.makdes   = wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0    And
                stat.maktab_fil.makyea   = Integer(wdetail.caryear) AND
                stat.maktab_fil.sclass   =  n_sclass72              AND
                stat.maktab_fil.seats    =  INTEGER(wdetail.seat)   No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.weight   =  string(stat.maktab_fil.tons)
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  stat.maktab_fil.seats .
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     n_sclass72         AND
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  string(stat.maktab_fil.tons) 
                wdetail.seat     =  stat.maktab_fil.seats .
        END.
    END.     /*end....covcod..2/3 .....*/
    ELSE DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =     trim(wdetail.brand)            And                  
            index(stat.maktab_fil.moddes,trim(wdetail.model)) <> 0        And
            stat.maktab_fil.makyea   =    Integer(wdetail.caryear)  AND 
            stat.maktab_fil.engine   =    Integer(wdetail.engcc)    AND
            stat.maktab_fil.sclass   =    n_sclass72                AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)   OR
             stat.maktab_fil.si  + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) ) AND   
            stat.maktab_fil.seats    =     INTEGER(wdetail.seat)      No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN chkred    =  YES
            nv_modcod        =  stat.maktab_fil.modcod 
            wdetail.redbook  =  stat.maktab_fil.modcod
            wdetail.body     =  stat.maktab_fil.body  
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.weight   =  string(stat.maktab_fil.tons) 
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  stat.maktab_fil.seats .
    END.
    IF wdetail.redbook = "" THEN DO:
        FIND LAST sicsyac.xmm102 WHERE 
            sicsyac.xmm102.modest = wdetail.brand  NO-LOCK NO-ERROR.
        IF NOT AVAIL sicsyac.xmm102  THEN  
            ASSIGN 
            nv_modcod = ""
            wdetail.redbook  = "".
        ELSE  
            ASSIGN 
                 nv_modcod  = sicsyac.xmm102.modcod. 
            wdetail.redbook = sicsyac.xmm102.modcod. 
         
    END.
IF nv_modcod = ""  THEN DO: 
    /*MESSAGE wdetail.brand
            wdetail.model
         n_sclass72 
        Integer(wdetail.caryear)
        Integer(wdetail.engcc)  
        INTEGER(wdetail.seat) 
        deci(wdetail.si)
        VIEW-AS ALERT-BOX.*/

    ASSIGN chkred     = YES 
        n_brand       = ""
        n_index       = 0
        n_model       = "". 
    RUN proc_model_brand.   /*RUN proc_maktab.*/
END.
IF wdetail.redbook  = ""  THEN DO: 
    /*MESSAGE wdetail.brand
            wdetail.model
         n_sclass72 
        Integer(wdetail.caryear)
        Integer(wdetail.engcc)  
        INTEGER(wdetail.seat) 
        deci(wdetail.si)
        VIEW-AS ALERT-BOX.*/
    ASSIGN chkred   = YES 
        n_brand     = ""
        n_index     = 0
        n_model     = "".
    RUN proc_model_brand.
    RUN proc_maktab.
END.
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
    wdetail.OK_GEN  = "N".
ASSIGN nv_docno  = " "
    nv_accdat = TODAY.
/***--- Docno ---***/
IF wdetail.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M"                              AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999")  NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN 
        ASSIGN wdetail.pass    = "N"  
        wdetail.comment = "Receipt is Dup. on uwm100 :" + string(sicuw.uwm100.policy,"x(16)") +
        STRING(sicuw.uwm100.rencnt,"99")  + "/" +
        STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
        wdetail.OK_GEN  = "N".
    ELSE  nv_docno = wdetail.docno.
END.
/***--- Account Date ---***/
IF wdetail.accdat <> " "  THEN nv_accdat = date(wdetail.accdat).
ELSE nv_accdat = TODAY. end....comment by kridtiya i. A57-0017.....*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 c-Win 
PROCEDURE proc_722 :
/* ---------------------------------------------  U W M 1 3 0 -------------- */
ASSIGN fi_process = "Create uwm301....compulsary..." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp     AND      /*0*/
    sic_bran.uwm130.riskno = s_riskno     AND      /*1*/
    sic_bran.uwm130.itemno = s_itemno     AND      /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr   AND      /*26/10/2006 change field name */
    sic_bran.uwm130.bchno  = nv_batchno   AND      /*26/10/2006 change field name */ 
    sic_bran.uwm130.bchcnt = nv_batcnt             /*26/10/2006 change field name */            
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
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class NO-LOCK NO-ERROR.
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
        RUN wgs/wgschsum(INPUT  wdetail.policy,         
                                nv_riskno,
                                nv_itemno).
END.
/*transaction*/
/* ---------------------------------------------  U W M 3 0 1 --------------*/ 
ASSIGN s_recid3  = RECID(sic_bran.uwm130)
nv_covcod  =  wdetail.covcod
nv_makdes  =  wdetail.brand
nv_moddes  =  wdetail.model
nv_newsck  = " ".

IF INDEX(wdetail.brand,"ISUZU") <> 0 AND index(wdetail.subclass,"110") <> 0 THEN ASSIGN wdetail.body =  "PICKUP" . /*A60-0118*/
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
         sic_bran.uwm301.bchyr  = nv_batchyr               AND 
         sic_bran.uwm301.bchno  = nv_batchno               AND 
         sic_bran.uwm301.bchcnt  = nv_batcnt     NO-WAIT NO-ERROR.
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
         sic_bran.uwm301.tariff  = "9"
         sic_bran.uwm301.covcod  = "T"
         sic_bran.uwm301.cha_no   = trim(wdetail.chasno)
         sic_bran.uwm301.trareg   = trim(wdetail.chasno)  /*--Ranu:A60-0206--*/
         sic_bran.uwm301.drinam[1] = TRIM(wdetail.tiname) + " " + trim(wdetail.insnam)  /*A60-0206*/  
         sic_bran.uwm301.eng_no   = trim(wdetail.eng)
         sic_bran.uwm301.Tons     = DECI(wdetail.weight) 
         sic_bran.uwm301.engine   = INTEGER(wdetail.engcc)
         sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
         sic_bran.uwm301.garage   = wdetail.garage
         sic_bran.uwm301.body     = wdetail.body
         sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
         sic_bran.uwm301.mv_ben83 = wdetail.benname
         sic_bran.uwm301.vehreg   = wdetail.vehreg 
         sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
         sic_bran.uwm301.vehgrp   = wdetail.cargrp
         sic_bran.uwm301.vehuse   = wdetail.vehuse
         /*sic_bran.uwm301.moddes   = trim(wdetail.brand) + " " + trim(wdetail.model) */    /*A60-0118*/  
         sic_bran.uwm301.moddes   = caps(trim(wdetail.brand)) + " " + caps(trim(wdetail.model)) /*A60-0118*/    
         sic_bran.uwm301.modcod   = wdetail.redbook 
         sic_bran.uwm301.sckno    = 0              
         sic_bran.uwm301.itmdel   = NO
         sic_bran.uwm301.bchyr    = nv_batchyr          /* batch Year */      
         sic_bran.uwm301.bchno    = nv_batchno          /* bchno    */      
         sic_bran.uwm301.bchcnt   = nv_batcnt           /* bchcnt     */  
         sic_bran.uwm301.car_color = wdetail.colorcode  /*A65-0356*/
        /* A67-0114 */
         sic_bran.uwm301.watt      = DECI(wdetail.hp) 
         sic_bran.uwm301.maksi     = DECI(wdetail.maksi)    
         sic_bran.uwm301.eng_no2   = TRIM(wdetail.engno2)   
         sic_bran.uwm301.battyr    = INTE(wdetail.battyr)   
         sic_bran.uwm301.battper   = INTE(wdetail.battper) .
        /* end A67-0114*/
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
             brStat.Detaitem.serailno   = wdetail.stk         AND 
             brstat.detaitem.yearReg    = nv_batchyr          AND
             brstat.detaitem.seqno      = STRING(nv_batchno)  AND
             brstat.detaitem.seqno2     = STRING(nv_batcnt)   NO-ERROR NO-WAIT.
         IF NOT AVAIL brstat.Detaitem THEN DO:   
             CREATE brstat.Detaitem.
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
     FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
         sic_bran.uwd132.policy = wdetail.policyno AND
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
             MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wdetail.policyno
                 "ไม่สามารถ Generage ข้อมูลได้".
             NEXT.
         END.
         CREATE sic_bran.uwd132.
     END.
     ASSIGN  wdetail.comp_prm = string(TRUNCATE(((deci(wdetail.comp_prm)  * 100 ) / 107.43),0))
         sic_bran.uwd132.bencod  = "COMP"                   /*Benefit Code*/
         sic_bran.uwd132.benvar  = ""                       /*Benefit Variable*/
         sic_bran.uwd132.rate    = 0                        /*Premium Rate %*/
         sic_bran.uwd132.gap_ae  = NO                       /*GAP A/E Code*/
         sic_bran.uwd132.gap_c   =  deci(wdetail.comp_prm)  /*deci(wdetail.premt)*//*GAP, per Benefit per Item*/
         sic_bran.uwd132.dl1_c   = 0                        /*Disc./Load 1,p. Benefit p.Item*/
         sic_bran.uwd132.dl2_c   = 0                        /*Disc./Load 2,p. Benefit p.Item*/
         sic_bran.uwd132.dl3_c   = 0                        /*Disc./Load 3,p. Benefit p.Item*/
         sic_bran.uwd132.pd_aep  = "E"                      /*Premium Due A/E/P Code*/
         sic_bran.uwd132.prem_c  = deci(wdetail.comp_prm)   /*PD, per Benefit per Item*/
         sic_bran.uwd132.fptr    = 0                        /*Forward Pointer*/
         sic_bran.uwd132.bptr    = 0                        /*Backward Pointer*/
         sic_bran.uwd132.policy  = wdetail.policyno         /*Policy No. - uwm130*/
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
ASSIGN  nv_rec100 = s_recid1
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
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.tonss).
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
                        sic_bran.uwd132.prem_c = deci(wdetail.comp_prm)
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
                ASSIGN sic_bran.uwd132.bencod = sicsyac.xmd107.bencod   sic_bran.uwd132.policy = wdetail.policy
                    sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt     sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                    sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp     sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
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
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.tonss).
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
                            sic_bran.uwd132.prem_c = deci(wdetail.comp_prm)
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
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.tonss).
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
                        sic_bran.uwd132.prem_c = deci(wdetail.comp_prm)
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
                 FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr
                     NO-LOCK NO-ERROR NO-WAIT.
                 IF NOT AVAILABLE sic_bran.uwd132 THEN LEAVE.
                 ASSIGN nv_fptr = sic_bran.uwd132.fptr
                 nv_gap  = nv_gap  + sic_bran.uwd132.gap_c
                 nv_prem = nv_prem + sic_bran.uwd132.prem_c.
             END.
         END.
         ASSIGN sic_bran.uwm120.gap_r  =  nv_gap
         sic_bran.uwm120.prem_r =  nv_prem
         sic_bran.uwm120.rstp_r  =  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) +
             (IF  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 2) -
              TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) > 0  THEN 1 ELSE 0)
         sic_bran.uwm120.rtax_r = ROUND((sic_bran.uwm120.prem_r + sic_bran.uwm120.rstp_r)  * nv_tax_per  / 100 ,2)
         nv_gap2  = nv_gap2  + nv_gap
         nv_prem2 = nv_prem2 + nv_prem
         nv_rstp  = nv_rstp  + sic_bran.uwm120.rstp_r
         nv_rtax  = nv_rtax  + sic_bran.uwm120.rtax_r.
         IF sic_bran.uwm120.com1ae = NO THEN  nv_com1_per  = sic_bran.uwm120.com1p.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72new c-Win 
PROCEDURE proc_72new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR stklen AS INTE.
ASSIGN  
    nv_modcod      = ""
    wdetail.compul = "y"
    wdetail.tariff = "9"
    wdetail.covcod = "T"
    n_sclass72     = ""  /*match class 72 -> 70 for redbook  */
    wdetail.stk    = substr(wdetail.stk,1,length(TRIM(wdetail.stk))) .
IF TRIM(wdetail.subclass) = ""  THEN
    ASSIGN  wdetail.comment = wdetail.comment + "| คลาสเป็นค่าว่าง เซตคลาสตามเบี้ยพรบ..!!!"   
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
ELSE DO:   /* 110 120  140 class 72->70*/
        IF      TRIM(wdetail.bev) = "Y" THEN n_sclass72 = trim(wdetail.n_class70) . /*A67-0114 */
        ELSE IF substr(wdetail.subclass,1,3) = "110" THEN ASSIGN   n_sclass72 = "110".
        ELSE IF substr(wdetail.subclass,1,3) = "140" THEN ASSIGN   n_sclass72 = "320".
        ELSE IF substr(wdetail.subclass,1,3) = "120" THEN ASSIGN   n_sclass72 = "210".
        ELSE DO:
            FIND LAST sicsyac.xzmcom WHERE 
                sicsyac.xzmcom.comp_cod  = (SUBSTR(wdetail.subclass,1,1) + "." + SUBSTR(wdetail.subclass,2)) NO-LOCK NO-ERROR.  
            IF AVAIL  sicsyac.xzmcom THEN ASSIGN n_sclass72 = SUBSTR(sicsyac.xzmcom.class,2,3).  /*class 70 */
        END.
END.
/*ELSE DO:   /*กรณี ระบุที่ไฟล์ class 70 -> 72 */
    FIND LAST sicsyac.xzmcom WHERE sicsyac.xzmcom.class = wdetail.subclass  NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xzmcom  THEN 
        ASSIGN wdetail.subclass  = trim(REPLACE(sicsyac.xzmcom.comp_cod,".","")) /*match class 70=>>72 */
        n_sclass72        = SUBSTR(sicsyac.xzmcom.class,2,3) .            /*class 70*/
    ELSE n_sclass72 = "".
END. */
IF wdetail.stk <> "" THEN DO:  
    ASSIGN stklen = 0
        stklen    = INDEX(trim(wdetail.stk)," ") - 1.
    IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN DO:
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN DO: 
            IF stklen > 1 THEN wdetail.stk = "0" + substr(wdetail.stk,1,stklen).
            ELSE wdetail.stk = "0" + substr(wdetail.stk,1,LENGTH(wdetail.stk)).
        END.
    END.
    IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
        wdetail.pass    = ""
        wdetail.OK_GEN  = "N".
END.
IF trim(wdetail.branch) = ""  THEN     /* A56-0323 */
    ASSIGN  wdetail.comment = wdetail.comment + "| พบสาขาเป็นค่าว่างไม่สามารถนำเข้าระบบได้"  /* A56-0323 */
    wdetail.pass    = "N"              /* A56-0323 */
    wdetail.OK_GEN  = "N".             /* A56-0323 */
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class = wdetail.subclass  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| " + wdetail.subclass + " ไม่พบ Class นี้ในระบบ"
    wdetail.pass    = "N"
    wdetail.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101      WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp   AND
        sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN  wdetail.pass = "N"
        wdetail.comment      = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
        wdetail.OK_GEN       = "N".
END.
FIND sicsyac.sym100 USE-INDEX sym10001  WHERE
    sicsyac.sym100.tabcod = "U013"         AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
    wdetail.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "|" + wdetail.subclass + "ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
    wdetail.OK_GEN = "N".
ASSIGN chkred  = NO
    n_brand    = ""
    n_index    = 0
    n_model    = "".
FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  wdetail.prempa + n_sclass72  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN n_ratmin = makdes31.si_theft_p 
    n_ratmax        = makdes31.load_p   .    
ELSE ASSIGN n_ratmin = 0
            n_ratmax = 0.
IF wdetail.redbook <> "" THEN DO:
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.modcod   = trim(wdetail.redbook)   AND 
        stat.maktab_fil.sclass   =     n_sclass72          No-lock no-error no-wait.
    If  avail stat.maktab_fil  THEN DO:
        ASSIGN chkred        =  YES
            nv_modcod        =  stat.maktab_fil.modcod 
            wdetail.redbook  =  stat.maktab_fil.modcod
            wdetail.body     =  stat.maktab_fil.body  
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.weight   =  string(stat.maktab_fil.tons)
            wdetail.engcc    =  STRING(stat.maktab_fil.engine)  /*A67-0114*/
            wdetail.hp       =  string(stat.maktab_fil.watt)     /*A67-0114*/
            wdetail.maksi    =  string(stat.maktab_fil.si ) . /*A67-0114*/
        IF wdetail.seat = 0 THEN wdetail.seat     =  stat.maktab_fil.seats .
    END.
    ELSE ASSIGN wdetail.redbook = "" .
END.  /*add A57-0088*/

IF wdetail.redbook = "" THEN RUN proc_redbook72. /*A67-0114*/
IF wdetail.redbook = "" THEN DO:
    FIND LAST stat.Insure   USE-INDEX Insure01   WHERE 
        stat.insure.compno   = TRIM(fiCompno)       AND 
        stat.Insure.FName    = trim(wdetail.model)  NO-LOCK  NO-ERROR NO-WAIT.
    IF AVAIL stat.insure  THEN DO:
        /* comment by A60-0095.....
        ASSIGN 
             wdetail.brand  =  stat.Insure.text1     /*brand tisco = brand  premium *//*A57-0431*/
             wdetail.model  =  stat.insure.text2    /*model tisco = model  premium *//*A57-0431*/
              n_brand =  trim(stat.Insure.text1)   /*A57-0431*/  
             n_model =  trim(stat.insure.text2) . /*A57-0431*/  
        .... end A60-0095.....*/
         /*--- add by A60-0095---*/
        ASSIGN wdetail.model = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1)) ELSE wdetail.brand
               wdetail.brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," "))) ELSE wdetail.brand.
        ASSIGN 
             n_brand =  if trim(stat.Insure.text1) <> "" then trim(stat.Insure.text1) else trim(wdetail.brand)   
             n_model =  if trim(stat.insure.text2) <> "" then trim(stat.insure.text2) else trim(wdetail.model) . 
        /*--- add by A60-0095---*/
    END.
    ELSE DO:
        IF index(wdetail.brand,"benz") <> 0 THEN DO: 
            IF INDEX(wdetail.brand," ") <> 0 THEN  
                ASSIGN 
                /*wdetail.model = SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1 )  /*A57-0431*/
                wdetail.brand = "MERCEDES-BENZ"  .*/                                   /*A57-0431*/
                /*n_brand =  "MERCEDES-BENZ"   */ /*A60-0095*/
                n_model =  trim(SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1 ))  /*A57-0431*/
                wdetail.model = n_model          /*A60-0095*/
                wdetail.brand = "MERCEDES-BENZ"  /*A60-0095*/ 
                n_brand =  "MERCEDES BENZ"  .   /*A60-0095*/ 
            IF INDEX(wdetail.model," ") <> 0 THEN 
                ASSIGN 
                /*wdetail.model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ") - 1 ).*//*A57-0431*/ 
                n_model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ") - 1 ).          /*A57-0431*/ 
            IF index(wdetail.model,"cls") <> 0 THEN DO:
                IF index(wdetail.model," ") <> 0   THEN
                    ASSIGN 
                    /*wdetail.model = SUBSTR(wdetail.model,1,index(wdetail.model," ") - 1) + SUBSTR(wdetail.model,index(wdetail.model," ") + 1) .*//*A57-0431*/
                    n_model = SUBSTR(wdetail.model,1,index(wdetail.model," ") - 1) + SUBSTR(wdetail.model,index(wdetail.model," ") + 1) .  /*A57-0431*/
                IF index(wdetail.model," ") <> 0   THEN 
                    /*ASSIGN wdetail.model = SUBSTR(wdetail.model,1,index(wdetail.model," ") - 1) .*//*A57-0431*/      
                    ASSIGN n_model =  SUBSTR(wdetail.model,1,index(wdetail.model," ") - 1) .         /*A57-0431*/      
            END.
        END.
        ELSE DO:
            IF INDEX(wdetail.brand," ") <> 0 THEN  
                ASSIGN 
                /*wdetail.model = SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1 )
                wdetail.brand = SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 ).*/
                /* comment by A60-0095 .... 
                n_model = SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1 )     /*A57-0431*/ 
                n_brand = SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 ).  /*A57-0431*/ 
                ---end A60-0095---*/
                /*---A60-0095---*/
                wdetail.model = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1)) ELSE wdetail.brand           
                wdetail.brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," "))) ELSE wdetail.brand
                n_model = wdetail.model   /*A57-0431*/ 
                n_brand = wdetail.brand . /*A57-0431*/ 
               /*---A60-0095---*/
            IF      INDEX(wdetail.model,"vigo")   <> 0 THEN n_model = "vigo".
            ELSE IF INDEX(wdetail.model,"altis")  <> 0 THEN n_model = "altis".
            ELSE IF INDEX(wdetail.model,"soluna") <> 0 THEN n_model = "vios".
            ELSE IF INDEX(wdetail.model,"HIACE")  <> 0 THEN 
                ASSIGN 
                wdetail.seat = 12
                /*wdetail.model  = "HIACE"*/
                n_model        = "HIACE"
                n_sclass72     = "210" .
            ELSE IF INDEX(wdetail.model," ") <> 0 THEN 
                /*ASSIGN wdetail.model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ") - 1 ).*//*A57-0431*/ 
                ASSIGN n_model = SUBSTR(wdetail.model,1,R-INDEX(wdetail.model," ") - 1 ).          /*A57-0431*/ 
        END.
    END.
END.
/*MESSAGE wdetail.brand wdetail.model  n_sclass72   VIEW-AS ALERT-BOX.*/
/*add A57-0088*/
IF  deci(wdetail.si) = 0 THEN DO:
    IF (Integer(wdetail.engcc) = 0 )  THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04           Where
            /*stat.maktab_fil.makdes   = wdetail.brand          And     /*A57-0431*/              
            index(stat.maktab_fil.moddes,wdetail.model) <> 0    And*/   /*A57-0431*/
            stat.maktab_fil.makdes   =   n_brand            And         /*A57-0431*/               
            index(stat.maktab_fil.moddes,n_model)   <> 0    AND         /*A57-0431*/
            stat.maktab_fil.makyea   = Integer(wdetail.caryear) AND
            stat.maktab_fil.sclass   =  n_sclass72              /*AND
            stat.maktab_fil.seats    =  INTEGER(wdetail.seat)*/   No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN DO: 
            ASSIGN chkred    =  YES
            nv_modcod        =  stat.maktab_fil.modcod 
            wdetail.redbook  =  stat.maktab_fil.modcod
            wdetail.body     =  stat.maktab_fil.body  
            /*wdetail.brand    =  stat.maktab_fil.makdes  /*A57-0431*/ 
            wdetail.model    =  stat.maktab_fil.moddes */ /*A57-0431*/ 
            wdetail.weight   =  string(stat.maktab_fil.tons)
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.engcc    =  STRING(stat.maktab_fil.engine)  /*A67-0114*/
            wdetail.hp       =  string(stat.maktab_fil.watt)     /*A67-0114*/
            wdetail.maksi    =  string(stat.maktab_fil.si ) . /*A67-0114*/

            IF wdetail.seat = 0 THEN wdetail.seat     =  stat.maktab_fil.seats .
        END.
    END.   /*wdetail.engcc) = 0*/
    ELSE DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            /*stat.maktab_fil.makdes   =     wdetail.brand          And    /*A57-0431*/              
            index(stat.maktab_fil.moddes,wdetail.model) <> 0        And*/  /*A57-0431*/
            stat.maktab_fil.makdes   =   n_brand                    And    /*A57-0431*/              
            index(stat.maktab_fil.moddes,n_model) <> 0              AND    /*A57-0431*/
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
            stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
            stat.maktab_fil.sclass   =     n_sclass72               /*AND
            stat.maktab_fil.seats    =     INTEGER(wdetail.seat)*/    No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN DO:
            ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                /*wdetail.brand    =  stat.maktab_fil.makdes  /*A57-0431*/  
                wdetail.model    =  stat.maktab_fil.moddes*/  /*A57-0431*/ 
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  string(stat.maktab_fil.tons)
                wdetail.engcc    =  STRING(stat.maktab_fil.engine)   /*A67-0114*/
                wdetail.hp       =  string(stat.maktab_fil.watt)     /*A67-0114*/
                wdetail.maksi    =  string(stat.maktab_fil.si ) . /*A67-0114*/
            IF wdetail.seat = 0 THEN wdetail.seat     =  stat.maktab_fil.seats .
        END.
    END.
END.   /*end....covcod..2/3 .....*/
ELSE DO:
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        /*stat.maktab_fil.makdes   =     trim(wdetail.brand)      And      /*A57-0431*/             
        index(stat.maktab_fil.moddes,trim(wdetail.model)) <> 0    And */   /*A57-0431*/ 
        stat.maktab_fil.makdes   =   n_brand        And                    /*A57-0431*/ 
        index(stat.maktab_fil.moddes,n_model) <> 0  And                    /*A57-0431*/ 
        stat.maktab_fil.makyea   =    Integer(wdetail.caryear)  AND 
        stat.maktab_fil.engine   =    Integer(wdetail.engcc)    AND 
        stat.maktab_fil.sclass   =    n_sclass72                AND 
        (stat.maktab_fil.si  - ((stat.maktab_fil.si * n_ratmin / 100 )) LE deci(wdetail.si)   AND
         stat.maktab_fil.si  + ((stat.maktab_fil.si * n_ratmax / 100 )) GE deci(wdetail.si) )  /*AND   
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)*/    No-lock no-error no-wait.
    If  avail stat.maktab_fil  THEN DO:
        ASSIGN chkred    =  YES
        nv_modcod        =  stat.maktab_fil.modcod 
        wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.body     =  stat.maktab_fil.body  
        /*wdetail.brand    =  stat.maktab_fil.makdes   /*A57-0431*/ 
        wdetail.model    =  stat.maktab_fil.moddes*/   /*A57-0431*/
        wdetail.weight   =  string(stat.maktab_fil.tons) 
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.engcc    =  STRING(stat.maktab_fil.engine)   /*A67-0114*/
        wdetail.hp       =  string(stat.maktab_fil.watt)     /*A67-0114*/
        wdetail.maksi    =  string(stat.maktab_fil.si ) . /*A67-0114*/
        IF wdetail.seat = 0 THEN wdetail.seat     =  stat.maktab_fil.seats .
    END.
END.
/*END.*/
IF nv_modcod = "" THEN DO:
    /*FIND LAST sicsyac.xmm102 WHERE sicsyac.xmm102.modest = n_brand  NO-LOCK NO-ERROR.*/ /*A67-0114*/
    FIND LAST sicsyac.xmm102 WHERE index(n_brand,sicsyac.xmm102.modest) <> 0  NO-LOCK NO-ERROR. /*A67-0114*/
    IF NOT AVAIL sicsyac.xmm102  THEN  
        ASSIGN  
        nv_modcod         = ""
        wdetail.redbook   = "".
    ELSE DO: 
        ASSIGN  nv_modcod   = sicsyac.xmm102.modcod 
            wdetail.redbook = sicsyac.xmm102.modcod 
            wdetail.cargrp  = sicsyac.xmm102.vehgrp
            wdetail.weight  = string(sicsyac.xmm102.tons)  
            wdetail.body    = IF n_sclass72 = "110" THEN  "SEDAN  " ELSE "PICKUP" .
           /*wdetail.brand   = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/    /*A57-0431*/  
            wdetail.model   = SUBSTRING(xmm102.modest,19,22)*/              /*A57-0431*/ 
        IF wdetail.seat    = 0 THEN wdetail.seat    = sicsyac.xmm102.seats.
    END.
END.
/* comment by A60-0095..........
IF INDEX(wdetail.brand," ") <> 0 THEN                                              /*A57-0431*/
    ASSIGN wdetail.model = trim(SUBSTR(wdetail.brand,INDEX(wdetail.brand," ")))    /*A57-0431*/
    wdetail.brand = trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," "))).        /*A57-0431*/
ELSE ASSIGN wdetail.model = "". /*A57-0431*/
..... END A60-0095...*/
/* comment by : A67-0114..
IF nv_modcod = ""  THEN DO: 
    ASSIGN chkred     = YES 
        n_brand       = ""
        n_index       = 0
        n_model       = "". 
    RUN proc_model_brand.        /*RUN proc_maktab.*/
END.
...end A67-0114..*/
IF wdetail.redbook  = ""  THEN DO: 
    ASSIGN chkred   = YES 
        n_brand     = ""
        n_index     = 0
        n_model     = "".
    RUN proc_model_brand.
    RUN proc_maktab.
END.
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
    wdetail.OK_GEN  = "N".
ASSIGN nv_docno  = " "
    nv_accdat = TODAY.
/***--- Docno ---***/
IF wdetail.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M"                              AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999")  NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN 
        ASSIGN wdetail.pass    = "N"  
        wdetail.comment = "Receipt is Dup. on uwm100 :" + string(sicuw.uwm100.policy,"x(16)") +
        STRING(sicuw.uwm100.rencnt,"99")  + "/" +
        STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
        wdetail.OK_GEN  = "N".
    ELSE  nv_docno = wdetail.docno.
END.
IF wdetail.accdat <> " "  THEN nv_accdat = date(wdetail.accdat).
ELSE nv_accdat = TODAY.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72_11 c-Win 
PROCEDURE proc_72_11 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
/************** v72 comp y **********/
DEF VAR stklen AS INTE.
ASSIGN  
    wdetail.compul    = "y"
    wdetail.tariff    = "9"
    wdetail.covcod    = "T"
    wdetail.garage    = " "
    n_rencnt          = 0
    n_endcnt          = 0
    wdetail.prepol    = "" 
    wdetail.tp1       = ""
    wdetail.tp2       = ""
    wdetail.tp3       = ""
    nv_basere         = 0
    n_41              = 0         
    n_42              = 0         
    n_43              = 0        
    dod1              = 0        
    dod2              = 0        
    dod0              = 0        
    wdetail.fleetper  = 0
    nv_dss_per        = 0
    WDETAIL.NCB       = 0
    nv_cl_per         = 0  
    wdetail.stk       = substr(wdetail.stk,1,length(TRIM(wdetail.stk))) .

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
            wdetail.OK_GEN  = "N".
    END.
END.
IF (TODAY - DATE(wdetail.comdat)) > 7 THEN
    ASSIGN
        wdetail.comment = wdetail.comment + "| วันที่ความคุ้มครองน้อยกว่าวันที่นำเข้า " + STRING((TODAY - DATE(wdetail.comdat)))
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".

IF wdetail.branch = " " THEN
    ASSIGN
        wdetail.comment = wdetail.comment + "| สาขา เป็นค่าว่าง มีผลต่อการค้นหาข้อมูล"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".
IF wdetail.prempa = " " THEN
    ASSIGN wdetail.comment = wdetail.comment + "| แพคเกจ เป็นค่าว่าง มีผลต่อการค้นหาข้อมูล"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".
IF wdetail.subclass = " " THEN
    ASSIGN wdetail.comment = wdetail.comment + "| Class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูล"
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
IF      deci(wdetail.comp_prm) =  645.21  THEN ASSIGN  wdetail.subclass =  "110"  n_sclass72 =  "110" . 
ELSE IF deci(wdetail.comp_prm) = 1182.35  THEN ASSIGN  wdetail.subclass =  "120A" n_sclass72 =  "210". 
ELSE IF deci(wdetail.comp_prm) = 2203.13  THEN ASSIGN  wdetail.subclass =  "120B" n_sclass72 =  "210". 
ELSE IF deci(wdetail.comp_prm) = 3437.91  THEN ASSIGN  wdetail.subclass =  "120C" n_sclass72 =  "210". 
ELSE IF deci(wdetail.comp_prm) = 4017.85  THEN ASSIGN  wdetail.subclass =  "120D" n_sclass72 =  "210". 
ELSE IF deci(wdetail.comp_prm) = 2493.10  THEN ASSIGN  wdetail.subclass =  "220A" n_sclass72 =  "220". 
ELSE IF deci(wdetail.comp_prm) = 3738.58  THEN ASSIGN  wdetail.subclass =  "220B" n_sclass72 =  "220". 
ELSE IF deci(wdetail.comp_prm) = 7155.09  THEN ASSIGN  wdetail.subclass =  "220C" n_sclass72 =  "220". 
ELSE IF deci(wdetail.comp_prm) = 8079.57  THEN ASSIGN  wdetail.subclass =  "220D" n_sclass72 =  "220". 
ELSE IF deci(wdetail.comp_prm) =  967.28  THEN ASSIGN  wdetail.subclass =  "140A" n_sclass72 =  "320". 
ELSE IF deci(wdetail.comp_prm) = 1310.75  THEN ASSIGN  wdetail.subclass =  "140B" n_sclass72 =  "320". 
ELSE IF deci(wdetail.comp_prm) = 1408.12  THEN ASSIGN  wdetail.subclass =  "140C" n_sclass72 =  "320". 
ELSE IF deci(wdetail.comp_prm) = 1826.49  THEN ASSIGN  wdetail.subclass =  "140D" n_sclass72 =  "320". 
ELSE IF deci(wdetail.comp_prm) = 1891.76  THEN ASSIGN  wdetail.subclass =  "240A" n_sclass72 =  "240". 
ELSE IF deci(wdetail.comp_prm) = 1966.66  THEN ASSIGN  wdetail.subclass =  "240B" n_sclass72 =  "240". 
ELSE IF deci(wdetail.comp_prm) = 2127.16  THEN ASSIGN  wdetail.subclass =  "240C" n_sclass72 =  "240". 
ELSE IF deci(wdetail.comp_prm) = 2718.87  THEN ASSIGN  wdetail.subclass =  "240D" n_sclass72 =  "240".
ELSE wdetail.subclass = "110" . 
ASSIGN 
    nv_makdes  = ""
    chkred     = NO
    nv_moddes  = "" .
IF INDEX(wdetail.brand," ") <> 0 THEN
    ASSIGN 
    nv_makdes  = substr(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )
    nv_moddes  = substr(wdetail.brand,INDEX(wdetail.brand," ") + 1 ).
ELSE ASSIGN nv_makdes = wdetail.brand
            nv_moddes = "" .
IF INDEX(nv_moddes," ") <> 0 THEN
    ASSIGN nv_moddes  = substr(nv_moddes,1,INDEX(nv_moddes," ") - 1 ).
IF      n_sclass72 = "110"  THEN wdetail.seat = 7.
ELSE IF n_sclass72 = "210"  THEN wdetail.seat = 12.
ELSE IF n_sclass72 = "320"  THEN wdetail.seat = 3.

FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  wdetail.prempa + n_sclass72 NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN n_ratmin = makdes31.si_theft_p   
    n_ratmax        = makdes31.load_p   .    
ELSE ASSIGN n_ratmin = 0
    n_ratmax         = 0.
Find First stat.maktab_fil USE-INDEX  maktab04               Where
    stat.maktab_fil.makdes   =     nv_makdes                 And                  
    index(stat.maktab_fil.moddes,nv_moddes) <> 0             And
    stat.maktab_fil.makyea    =     Integer(wdetail.caryear) AND 
    stat.maktab_fil.sclass   =     n_sclass72                 AND
   (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
    stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND   
    stat.maktab_fil.seats    =     INTEGER(wdetail.seat)     No-lock no-error no-wait.
If  avail stat.maktab_fil  THEN 
    Assign
        wdetail.redbook         =  stat.maktab_fil.modcod
        wdetail.brand           =  stat.maktab_fil.makdes  
        wdetail.model           =  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        wdetail.body            =  stat.maktab_fil.body
        wdetail.ton             =  STRING(stat.maktab_fil.tons)
        wdetail.engcc           =  string(stat.maktab_fil.eng)
        nv_engine               =  stat.maktab_fil.eng.
ELSE RUN proc_maktab72.
IF wdetail.redbook  = ""  THEN DO: 
    ASSIGN chkred = YES.
    RUN proc_model_brand.
    RUN proc_maktab.
END.
/*---------- covcod ----------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
 sicsyac.sym100.tabcod = "U013"    AND
 sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
 ASSIGN  wdetail.pass    = "N"
 wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
 wdetail.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
 sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
 sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
 ASSIGN  wdetail.pass    = "N"  
 wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
 wdetail.OK_GEN = "N".
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class = wdetail.subclass  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
 ASSIGN  wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
 wdetail.pass    = "N"
 wdetail.OK_GEN  = "N".
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
    wdetail.OK_GEN  = "N".
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
        wdetail.OK_GEN  = "N".
    ELSE  nv_docno = wdetail.docno.
END.
/***--- Account Date ---***/
IF wdetail.accdat <> " "  THEN nv_accdat = date(wdetail.accdat).
ELSE nv_accdat = TODAY.
     */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign c-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: /* comment by : A67-0114...*/       
------------------------------------------------------------------------------*/
DO:
    DEF BUFFER buwm100 FOR wdetail.
    DEF VAR nv_chkstk  AS LOGICAL INIT NO.
    ASSIGN 
        nv_chkstk = NO
        fi_process = "Start create wdetail...compulsary...".
    DISP fi_process WITH FRAM fr_main.
    For each  wdetail2 :
        DELETE  wdetail2.
    END.
    For each  wdetail :
        DELETE  wdetail.
    End.
    IF rs_type = 1 THEN DO:
        INPUT FROM VALUE(fi_FileName).
        REPEAT:
            CREATE wdetail2.
            IMPORT DELIMITER "|" 
                wdetail2.Pro_off        /*2   2   รหัสสาขาที่ผู้เอาประกันภัยเปิดบัญชี */        
                wdetail2.cmr_code       /*3...3   รหัสเจ้าหน้าที่การตลาด              */        
                wdetail2.comcode        /*4...3   รหัสบริษัทประกัน 3หลัก  */        
                wdetail2.policyno       /*5...25  เลขที่รับแจ้งประกัน  */     
                wdetail2.caryear        /*6...4   ปีรถ*/     
                wdetail2.eng            /*7...25  เครื่อง ยนต์  */
                wdetail2.chasno         /*8...25  หมายเลขตัวถัง  */
                wdetail2.engcc          /*9...5   น้ำหนัก         */
                wdetail2.power          /*10..7   กำลังเครื่องยนต์*/
                wdetail2.colorcode      /*11...2  สีรถ  */
                wdetail2.vehreg         /*12...2  ทะเบียน */     
                wdetail2.garage         /*13...2  การซ่อม */
                wdetail2.fleetper       /*14...2  ส่วนลดหมู่ */
                wdetail2.ncb            /*15..3   ส่วนลดประวัติดี*/
                wdetail2.orthper        /*16...3  ส่วนลดอื่นๆ */
                wdetail2.vehuse         /*17...2  การใช้งาน */
                wdetail2.comdat         /*18...2  วันเริ่มคุ้มครอง */
                wdetail2.si             /*19...2   ทุน*/
                wdetail2.name_insur     /*20...2   ชื่อเจ้าหน้าที่ประกัน*/
                wdetail2.not_office     /*21...3   รหัสเจ้าหน้าที่แจ้งประกัน*/
                wdetail2.entdat         /*22...3   วันที่แจ้งประกัน*/
                wdetail2.enttim         /*23...2   เวลาแจ้งประกัน*/
                wdetail2.not_code       /*24...2   รหัสแจ้งงาน*/        
                wdetail2.premt          /*25...2   เบี้ยประกันรวม  ภาษี อากร*/
                wdetail2.comp_prm       /*26...2   เบี้ยพรบ.  ภาษี อากร*/
                wdetail2.stk            /*27...3   สติ๊กเกอร์*/
                wdetail2.brand          /*28...3   ยี่ห้อ*/
                wdetail2.addr1          /*29...2   ที่อยูผู้เอาประกัน1*/
                wdetail2.addr2          /*30...2   ที่อยูผู้เอาประกัน2*/
                wdetail2.tiname         /*31...2   คำนำหน้า*/
                wdetail2.insnam         /*32...2   ชื่อลูกค้า*/
                wdetail2.name2          /*33...3   นามสกุล*/
                wdetail2.benname        /*34...3   ผู้รับผลประโยชน์*/
                wdetail2.remark         /*35...2   หมายเหตุ*/
                wdetail2.Account_no     /*36...2   เลขที่สัญญาของผู้เอาประกัน*/         
                wdetail2.client_no      /*37...2   รหัสของผู้เอาประกัน*/
                wdetail2.expdat         /*38...2   วันสิ้นสุดความคุ้มครอง*/
                wdetail2.gap            /*39...3   เบี้ยรวม พรบ*/
                wdetail2.re_country     /*40...3   จังหวัดที่จดทะเบียน*/
                wdetail2.receipt_name   /*41...2   ชื่อออกใบเสร็จ*/
                wdetail2.agent          /*42...2   บริษัท*/
                wdetail2.prev_insur     /*43...2   บริษัทประกันภัยเดิม*/
                wdetail2.prepol         /*44...2   เลขกรมธรรม์เดิม*/
                wdetail2.deduct         /*45...3   ส่วนลดเสียหายแรก*/
                wdetail2.add1_70        /*46 add1 ภาคสมัครใจ         */
                wdetail2.add2_70        /*47 add2 ภาคสมัครใจ         */
                wdetail2.Sub_Di_70      /*48 Sub Dist. 1149 1178 30  */
                wdetail2.Direc_70       /*49 Direction 1179 1208 30  */
                wdetail2.Provi_70       /*50 Province  1209 1238 30  */
                wdetail2.ZipCo_70       /*51 ZipCode   1239 1243 5   */
                wdetail2.add1_72        /*52 add1 ภาคสมัครใจ         */
                wdetail2.add2_72        /*53 add2 ภาคสมัครใจ         */
                wdetail2.Sub_Di_72      /*54 Sub Dist. 1149 1178 30  */
                wdetail2.Direc_72       /*55 Direction 1179 1208 30  */
                wdetail2.Provi_72       /*56 Province  1209 1238 30  */
                wdetail2.ZipCo_72       /*57 ZipCode   1239 1243 5   */
                wdetail2.apptype        /*58 application type h = ยังไม่ออกกรมธรรม์ p = ออกกรมธรรม์ได้*/
                wdetail2.appcode        /*59 application code [HP, H2, H6, HN, HM, HG] */
                wdetail2.nBLANK         /*60 */
                wdetail2.prempa         /*61 package*/
                wdetail2.seate          /*add A57-0017 add seate */
                wdetail2.tp1            /*62 pd 1   */
                wdetail2.tp2            /*63 pd 2   */
                wdetail2.tp3            /*64 pd 3   */
                wdetail2.covcod         /*65 covcod */
                wdetail2.producer       /*66 Producerr -*/
                wdetail2.agent1         /*67 Agent -*/
                wdetail2.nbranch        /*68 Branch -*/
                wdetail2.npolty         /*69 Poltyp -*/
                wdetail2.nredbook       /*70 Red Book -*/
                wdetail2.Price_Ford     /* Price Ford */                                                                  
                wdetail2.Year_fd        /* Year FD */                                                                     
                wdetail2.Brand_Model                                                                                      
                wdetail2.id_no70        /*“เลขทีบัตรประจำตัวประชาชน/เลขทีหนังสือเดินทาง /เลขทะเบียนพาณิชย์”*/           
                wdetail2.id_nobr70      /*สาขาของสถานประกอบการลูกค้า*/                                                    
                wdetail2.id_no72        /*“เลขทีบัตรประจำตัวประชาชน/เลขทีหนังสือเดินทาง /เลขทะเบียนพาณิชย์”*/           
                wdetail2.id_nobr72      /*สาขาของสถานประกอบการลูกค้า*/                                                    
                wdetail2.comp_comdat    /*Effective Date Accidential*/            
                wdetail2.comp_expdat    /*Expiry Date Accidential*/               
                wdetail2.fi             /*Coverage Amount Theft*/                 
                wdetail2.class          /*Car code*/                              
                wdetail2.usedtype       /*Per Used*/                              
                wdetail2.driveno1       /*Driver Seq1*/                                 
                wdetail2.drivename1     /*Driver Name1*/                                
                wdetail2.bdatedriv1     /*Birthdate Driver1*/                           
                wdetail2.occupdriv1     /*Occupation Driver1*/                          
                wdetail2.positdriv1     /*Position Driver1 */                           
                wdetail2.driveno2       /*Driver Seq2*/                                 
                wdetail2.drivename2     /*Driver Name2*/                                
                wdetail2.bdatedriv2     /*Birthdate Driver2*/                           
                wdetail2.occupdriv2     /*Occupation Driver2*/                          
                wdetail2.positdriv2     /*Position Driver2*/                            
                wdetail2.driveno3       /*Driver Seq3*/                                 
                wdetail2.drivename3     /*Driver Name3*/                                
                wdetail2.bdatedriv3     /*Birthdate Driver3*/                           
                wdetail2.occupdriv3     /*Occupation Driver3*/                          
                wdetail2.positdriv3     /*Position Driver3*/                            
                wdetail2.nBLANK         /* A57-0088 */
                wdetail2.Reciept72  
                wdetail2.access          
                wdetail2.Rec_name72   
                wdetail2.Rec_add1     
                wdetail2.n_comment    /*end A63-0210 */
                wdetail2.n_comment
                wdetail2.brithday
                wdetail2.Schanel   
                wdetail2.bev       
                wdetail2.driveno4  
                wdetail2.drivename4
                wdetail2.bdatedriv4
                wdetail2.occupdriv4
                wdetail2.positdriv4
                wdetail2.driveno5  
                wdetail2.drivename5
                wdetail2.bdatedriv5
                wdetail2.occupdriv5
                wdetail2.positdriv5
                wdetail2.campagin  
                wdetail2.inspic    
                wdetail2.engcount  
                wdetail2.engno2    
                wdetail2.engno3    
                wdetail2.engno4    
                wdetail2.engno5    
                wdetail2.classcomp 
                wdetail2.carbrand . 
        END.    /* repeat  */
    END.
    ELSE DO:
        RUN proc_assign_re.
    END.

    RUN proc_assign1. 
    FOR EACH wdetail2 WHERE deci(wdetail2.comp_prm) > 0    NO-LOCK.
        ASSIGN n_policy72 = "" 
               n_packcomp = "".
      /* ------- Create by Ranu A61-0045----------*/
        IF wdetail2.policyno = "" THEN DO: 
            IF LENGTH(TRIM(wdetail2.Account_no)) <= 12 THEN 
                 ASSIGN n_policy72 = "72" + TRIM(wdetail2.Account_no) .
            ELSE ASSIGN n_policy72 = "72" + substr(TRIM(wdetail2.Account_no),1,12) .
        END.
        ELSE IF INDEX(wdetail2.policyno,",") <> 0 THEN
            ASSIGN n_policy72 = "72" +  trim(substr(wdetail2.policyno,1,INDEX(wdetail2.policyno,",") - 1 )).
        ELSE n_policy72 = "72" + trim(wdetail2.policyno) .
        /*---------end A61-0045------------*/
        IF LENGTH(n_policy72) > 16 THEN ASSIGN n_policy72 = "72" + SUBSTR(n_policy72,7,16).     /*A64-0092*/

        /* comment by : A67-0185...
        /*FIND FIRST wcomp WHERE  wcomp.premcomp  = deci(wdetail2.comp_prm) NO-LOCK NO-ERROR NO-WAIT.*/ /*A67-0087*/
        FIND FIRST wcomp WHERE  wcomp.premcomp  = deci(wdetail2.comp_prm) AND wcomp.ev = trim(wdetail2.bev) NO-LOCK NO-ERROR NO-WAIT. /*A67-0087*/
        IF AVAIL wcomp  THEN ASSIGN n_packcomp = wcomp.package . 
        ELSE DO:
            /* create by a61-0410*/
            IF index(wdetail2.prempa,"210") <>  0   THEN ASSIGN n_packcomp = "120A".
            ELSE if index(wdetail2.prempa,"110") <> 0 THEN ASSIGN n_packcomp = "110".
            ELSE if index(wdetail2.prempa,"320") <> 0 THEN ASSIGN n_packcomp = "140A".
            ELSE n_packcomp = "".
           /* end a61-0410*/
        END.
        ...end A67-0185..*/
        /* ---A60-0095---*/
        ASSIGN 
            n_brand = IF INDEX(wdetail2.brand," ") <> 0 THEN trim(SUBSTR(wdetail2.brand,1,INDEX(wdetail2.brand," ") - 1 )) ELSE trim(wdetail2.brand).
        IF n_brand = "ISUZU" AND index(wdetail2.prempa,"210") <> 0 THEN ASSIGN n_packcomp = "140A".
        IF index(wdetail2.prempa,"520") <> 0 THEN DO: 
            IF wdetail2.usedtype = "1" THEN  ASSIGN n_packcomp = "160".
            ELSE ASSIGN n_packcomp = "260".
        END.
        /* ---end a60-0095---*/
        FIND FIRST wdetail WHERE wdetail.policyno = n_policy72 NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN 
                wdetail.policyno   =   trim(n_policy72)   
                wdetail.cedpol     =   trim(wdetail2.policyno)
                wdetail.renpol     =   TRIM(wdetail2.policyno)  /*A61-0410*/
                wdetail.caryear    =   trim(wdetail2.caryear)    
                wdetail.eng        =   trim(wdetail2.eng)  
                wdetail.chasno     =   trim(wdetail2.chasno)     
                wdetail.engcc      =   trim(wdetail2.power)       
                wdetail.vehreg     =   trim(wdetail2.vehreg)     
                wdetail.garage     =   trim(wdetail2.garage)     
                wdetail.fleetper   =   deci(trim(wdetail2.fleetper))   
                wdetail.ncb        =   deci(trim(wdetail2.ncb))        
                wdetail.orthper    =   trim(wdetail2.orthper)    
                wdetail.vehuse     =   ""                        /*A60-0095*/
                wdetail.comdat     =   TRIM(wdetail2.comp_comdat)  /* วันคุ้มครอง พ.ร.บ. */
                wdetail.si         =   trim(wdetail2.si)         
                wdetail.name_insur =   trim(wdetail2.name_insur) 
                wdetail.not_office =   trim(wdetail2.not_office) 
                wdetail.entdat     =   trim(wdetail2.entdat) 
                wdetail.enttim     =   trim(wdetail2.enttim) 
                wdetail.not_code   =   trim(wdetail2.not_code)   
                wdetail.premt      =   trim(wdetail2.premt)   
                wdetail.comp_prm   =   trim(wdetail2.comp_prm)   
                wdetail.stk        =   trim(wdetail2.stk)        
                wdetail.brand      =   trim(wdetail2.brand) 
                wdetail.redbook    =   TRIM(wdetail2.nredbook)     /*A57-0088*/
                wdetail.addr1      =   IF (trim(wdetail2.add1_72) + " " +
                                           trim(wdetail2.add2_72) + " " + 
                                           trim(wdetail2.Sub_Di_72) + " " + 
                                           trim(wdetail2.Direc_72) + " " + 
                                           trim(wdetail2.Provi_72) + " " +
                                           trim(wdetail2.ZipCo_72)) = "" THEN 
                                          (trim(wdetail2.add1_70) + " " + 
                                           trim(wdetail2.add2_70)  + " " + 
                                           trim(wdetail2.Sub_Di_70)  + " " + 
                                           trim(wdetail2.Direc_70)  + " " + 
                                           trim(wdetail2.Provi_70)  + " " + 
                                           trim(wdetail2.ZipCo_70))     
                                       ELSE 
                                           trim(wdetail2.add1_72) + " " +
                                           trim(wdetail2.add2_72) + " " + 
                                           trim(wdetail2.Sub_Di_72) + " " + 
                                           trim(wdetail2.Direc_72) + " " + 
                                           trim(wdetail2.Provi_72) + " " +
                                           trim(wdetail2.ZipCo_72) 
                wdetail.tiname     =   trim(wdetail2.tiname)      
                wdetail.insnam     =   trim(trim(wdetail2.insnam) + " " + trim(wdetail2.name2))  
                wdetail.benname    =   trim(wdetail2.benname)         
                wdetail.remark     =   trim(wdetail2.remark)       
                wdetail.Account_no =   trim(wdetail2.Account_no)   
                wdetail.client_no  =   trim(wdetail2.client_no)    
                wdetail.expdat     =   trim(wdetail2.comp_expdat)           /* วันสิ้นสุด พ.ร.บ. */  
                wdetail.gap        =   trim(wdetail2.gap)          
                wdetail.re_country =   trim(wdetail2.re_country)   
                wdetail.receipt_name =     TRIM(wdetail2.Reciept72)   
                wdetail.prepol     =   ""      
                wdetail.deduct     =   trim(wdetail2.deduct)       
                wdetail.branch     =   caps(trim(wdetail2.nbranch))       
                wdetail.tp1        =   trim(wdetail2.tp1)          
                wdetail.tp2        =   trim(wdetail2.tp2)          
                wdetail.tp3        =   trim(wdetail2.tp3)          
                wdetail.covcod     =   "T"    
                wdetail.poltyp     =   "V72"
                wdetail.prepol     =  trim(wdetail2.prepol)
                /*wdetail.subclass   =  n_packcomp   */     /*add A57-0017 */ /*A67-0185*/
                wdetail.subclass   = SUBSTR(wdetail2.prempa,2,3)      /*A67-0185*/
                wdetail.seat       = IF (wdetail2.seate = "") OR (deci(trim(wdetail2.seate)) = 0 ) THEN 0 ELSE INTE(wdetail2.seate)    /*add A57-0017 */
                wdetail.prempa     = IF  trim(wdetail2.prempa) = "" THEN trim(fi_pack)
                                     ELSE SUBSTR(trim(wdetail2.prempa),1,1)
                wdetail.comment    = ""
                wdetail.producer   = IF trim(wdetail2.producer) = "" THEN caps(trim(fi_producer)) ELSE trim(wdetail2.producer) 
                wdetail.agent      = IF trim(wdetail2.agent1)   = "" THEN caps(trim(fi_agent))    ELSE trim(wdetail2.agent1)     
                wdetail.entdat     = string(TODAY)              /*entry date*/
                wdetail.enttim     = STRING(TIME,"HH:MM:SS")    /*entry time*/
                wdetail.trandat    = STRING(fi_loaddat)         /*tran  date*/
                wdetail.trantim    = STRING(TIME,"HH:MM:SS")    /*tran  time*/
                wdetail.n_IMPORT   = "IM"
                wdetail.n_EXPORT   = "" 
                wdetail.colorcode = wdetail2.colorcode   /*A65-0356*/
                wdetail.br_insured = wdetail2.id_nobr72
                 /*A67-0114*/
                wdetail.weight     =  TRIM(wdetail2.engcc)
                wdetail.hp         =  IF TRIM(wdetail2.bev) = "Y" THEN trim(wdetail2.power) ELSE "0"
                wdetail.Schanel    =  trim(wdetail2.Schanel) 
                wdetail.n_class70  =  TRIM(wdetail2.CLASS) 
                wdetail.bev        =  IF TRIM(wdetail2.bev) = "" THEN "N" ELSE TRIM(wdetail.bev) 
                wdetail.engcount   =  TRIM(wdetail2.engcount)
                wdetail.engno2     =  trim(wdetail2.engno2 ) 
                wdetail.engno3     =  trim(wdetail2.engno3 ) 
                wdetail.engno4     =  trim(wdetail2.engno4 ) 
                wdetail.engno5     =  trim(wdetail2.engno5 ) 
                wdetail.maksi      =  TRIM(wdetail2.Price_Ford)
                wdetail.battyr     =  IF trim(wdetail2.bev) = "Y" THEN TRIM(wdetail2.caryear) ELSE "" .
                /* end A67-0114 */
            END.
    END.
    FOR EACH wdetail NO-LOCK.
        IF wdetail.stk <> "" THEN DO:
            FOR EACH buwm100 WHERE buwm100.stk   =  wdetail.stk  NO-LOCK.
                IF  buwm100.policyno <>  wdetail.policyno  THEN DO:
                    MESSAGE "พบเลขสติ๊กเกอร์ซ้ำในไฟล์เดียวกัน : " wdetail.policyno " " wdetail.stk  VIEW-AS ALERT-BOX.
                    ASSIGN nv_chkstk = YES.
                    
                END.
            END.
        END.
    END.
    IF nv_chkstk = YES THEN DO: 
        FOR EACH wdetail.
            DELETE wdetail.
        END.
    END.
    ELSE RUN proc_assign2.
END.
/*...end A67-0114...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign1 c-Win 
PROCEDURE proc_assign1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2  .
    IF      index(wdetail2.Pro_off,"บริษัท") > 0 THEN DELETE wdetail2.
    ELSE IF index(wdetail2.Pro_off,"Pro") >    0 THEN DELETE wdetail2.
    ELSE IF index(wdetail2.Pro_off,"Totle") >  0 THEN DELETE wdetail2.
    ELSE IF (wdetail2.policyno = "") AND (wdetail2.Account_no = "") THEN DELETE wdetail2.
    ELSE IF wdetail2.Pro_off  = ""               THEN DELETE wdetail2.
    ELSE DO:
        IF (INDEX(wdetail2.Provi_72,"กรุง") <> 0) OR (INDEX(wdetail2.Provi_72,"กทม") <> 0) THEN DO:  
            /* "แขวง" */
            IF  wdetail2.Sub_Di_72 = "" THEN ASSIGN  wdetail2.Sub_Di_72 = "".
            ELSE DO:
                IF INDEX(wdetail2.Sub_Di_72,"ตำบล") <> 0 THEN ASSIGN wdetail2.Sub_Di_72 = REPLACE(wdetail2.Sub_Di_72,"ตำบล","").
                IF INDEX(wdetail2.Sub_Di_72,"แขวง") = 0  THEN ASSIGN wdetail2.Sub_Di_72 = "แขวง" + wdetail2.Sub_Di_72. 
            END.
            /*"เขต"*/
            IF wdetail2.Direc_72  = "" THEN ASSIGN wdetail2.Direc_72  = "".
            ELSE DO:
                IF INDEX(wdetail2.Direc_72,"อำเภอ") <> 0 THEN ASSIGN wdetail2.Direc_72 = REPLACE(wdetail2.Direc_72,"อำเภอ","").
                IF INDEX(wdetail2.Direc_72,"เขต")    = 0 THEN ASSIGN wdetail2.Direc_72 = "เขต" + wdetail2.Direc_72.
            END.
            ASSIGN 
                wdetail2.Provi_72   = IF wdetail2.Provi_72  = "" THEN "" ELSE wdetail2.Provi_72           /*56 Province  1209 1238 30  */
                wdetail2.ZipCo_72   = IF wdetail2.ZipCo_72  = "" THEN "" ELSE wdetail2.ZipCo_72 .         /*57 ZipCode   1239 1243 5   */
        END.
        ELSE DO:
            /* "ตำบล" */
            IF  wdetail2.Sub_Di_72 = "" THEN ASSIGN  wdetail2.Sub_Di_72 = "".
            ELSE DO:
                IF INDEX(wdetail2.Sub_Di_72,"แขวง") <> 0 THEN ASSIGN wdetail2.Sub_Di_72 = REPLACE(wdetail2.Sub_Di_72,"แขวง","").
                IF INDEX(wdetail2.Sub_Di_72,"ตำบล") = 0  THEN ASSIGN wdetail2.Sub_Di_72 = "ตำบล" + wdetail2.Sub_Di_72. 
            END.
            /*"อำเภอ"*/
            IF wdetail2.Direc_72  = "" THEN ASSIGN wdetail2.Direc_72  = "".
            ELSE DO:
                IF INDEX(wdetail2.Direc_72,"เขต")   <> 0 THEN ASSIGN wdetail2.Direc_72 = REPLACE(wdetail2.Direc_72,"เขต","").
                IF INDEX(wdetail2.Direc_72,"อำเภอ")  = 0 THEN ASSIGN wdetail2.Direc_72 = "อำเภอ" + wdetail2.Direc_72.
            END.
            IF wdetail2.Provi_72  = "" THEN ASSIGN wdetail2.Provi_72  = "".
            ELSE IF INDEX(wdetail2.Provi_72,"จ.") <>  0 THEN ASSIGN wdetail2.Provi_72   =   replace(wdetail2.Provi_72,"จ.","จังหวัด").  /*56 Province  1209 1238 30  */
            ELSE IF INDEX(wdetail2.Provi_72,"จังหวัด") = 0 THEN ASSIGN wdetail2.Provi_72   =   "จังหวัด" + wdetail2.Provi_72.          /*56 Province  1209 1238 30  */
            ASSIGN    wdetail2.ZipCo_72   = IF wdetail2.ZipCo_72  = "" THEN "" ELSE wdetail2.ZipCo_72 .                        /*57 ZipCode   1239 1243 5   */

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
DEF VAR b_eng  AS DECI FORMAT  ">>>>9.99-".
DEF VAR n_date AS CHAR FORMAT  "x(10)".
DEF VAR ind1   AS INTE.
DEF VAR ind2   AS INTE.
DEF VAR ind3   AS INTE.
DEF VAR ind4   AS INTE.
DEF VAR n_char AS CHAR FORMAT  "x(75)" .
FOR EACH wdetail WHERE wdetail.policyno NE " "  .
    ASSIGN  ind1 = 0
        ind2 = 0
        ind3 = 0
        ind4 = 0
        /*wdetail.seat = 0*/ /*A57-0017*/
        n_char = ""
        n_date = STRING(TODAY,"99/99/9999")
        b_eng  = round((DECI(wdetail.engcc) / 1000),1)   
        b_eng  = b_eng * 1000
        wdetail.tariff  = "9"  
        wdetail.garage  = " "
        wdetail.model   = wdetail.brand  
        wdetail.vehuse  = IF wdetail.vehuse = "" THEN "1" ELSE wdetail.vehuse
        fi_process      = "Check data wdetail..."   .
    DISP fi_process WITH FRAM fr_main.

    RUN proc_chkcomp. /*A67-0185*/

    IF DECI(wdetail.engcc) <= 99 THEN wdetail.engcc = string(deci(wdetail.engcc) * 100 ) .
    ELSE IF DECI(wdetail.engcc) < 1000 AND wdetail.bev = "Y"  THEN wdetail.engcc = trim(wdetail.engcc) . /*A67-0114*/
    ELSE IF DECI(wdetail.engcc) > 1000 THEN wdetail.engcc = trim(wdetail.engcc) . /*A67-0114*/
    ELSE wdetail.engcc   = STRING(b_eng).
    IF wdetail.bev = "Y"  THEN wdetail.hp = trim(wdetail.engcc) . /*A67-0114*/

    IF wdetail.vehreg = "" THEN DO:
        IF LENGTH(wdetail.chasno) >= 9 THEN
             wdetail.vehreg = "/" +  SUBSTRING(wdetail.chasno,LENGTH(wdetail.chasno) - 8 ,9) .
        ELSE wdetail.vehreg = "/" +  TRIM(wdetail.chasno).
    END.
    ELSE IF wdetail.vehreg = "ป้ายแดง" THEN wdetail.vehreg = "/" +  SUBSTRING(wdetail.chasno,LENGTH(wdetail.chasno) - 8 ,9) . /*A60-0095*/


    ELSE ASSIGN wdetail.vehreg = trim(wdetail.vehreg) + " " + TRIM(wdetail.re_country). /*A60-0095*/
    /*ELSE RUN proc_renew_veh. */ /*A60-0095*/
    IF wdetail.seat = 0 THEN DO:  /* class by 72 110,140A,140B...*/
        IF       (substr(wdetail.subclass,1,3)  = "110") OR (substr(wdetail.subclass,2,3)  = "110") THEN  wdetail.seat = 7.
        ELSE IF  (substr(wdetail.subclass,1,3)  = "140") OR (substr(wdetail.subclass,1,3)  = "320") THEN  wdetail.seat = 3.
        ELSE IF  (substr(wdetail.subclass,1,3)  = "120") OR (substr(wdetail.subclass,1,3)  = "210") 
              OR (substr(wdetail.subclass,1,3)  = "220") THEN  wdetail.seat = 12.
    END.  /*ELSE wdetail.seat = 7 .*/
    IF R-INDEX(wdetail.addr1,"กรุง") <> 0  THEN  
        ASSIGN 
        wdetail.country = trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"กรุง")))
        wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"กรุง") - 1 )) .
    ELSE IF R-INDEX(wdetail.addr1,"กทม") <> 0  THEN  
        ASSIGN wdetail.country = trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"กทม")))
            wdetail.addr1      = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"กทม") - 1 )) .
    ELSE IF R-INDEX(wdetail.addr1,"จ.") <> 0  THEN  
        ASSIGN wdetail.country = trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"จ.")))
            wdetail.addr1      = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"จ.") - 1 )) .
    ELSE IF R-INDEX(wdetail.addr1,"จังหวัด") <> 0  THEN  
        ASSIGN wdetail.country = trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"จังหวัด")))
            wdetail.addr1      = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"จังหวัด") - 1 )) .
    IF R-INDEX(wdetail.addr1,"เขต") <> 0  THEN  
        ASSIGN 
        wdetail.amper  = trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"เขต")))
        wdetail.amper  = trim(REPLACE(wdetail.amper," ",""))
        wdetail.addr1  = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"เขต") - 1 )) .
    ELSE IF R-INDEX(wdetail.addr1,"อ.") <> 0  THEN  
        ASSIGN 
        wdetail.amper  = trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"อ.")))
        wdetail.amper  = trim(REPLACE(wdetail.amper," ",""))
        wdetail.addr1  = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"อ.") - 1 )) .
    ELSE IF R-INDEX(wdetail.addr1,"อำเภอ") <> 0  THEN  
        ASSIGN 
        wdetail.amper  = trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"อำเภอ")))
        wdetail.amper  = trim(REPLACE(wdetail.amper," ",""))
        wdetail.addr1  = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"อำเภอ") - 1 )) .
    IF R-INDEX(wdetail.addr1,"แขวง") <> 0  THEN  
        ASSIGN wdetail.tambon = trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"แขวง")))
        wdetail.tambon        = trim(REPLACE(wdetail.tambon," ",""))
        wdetail.addr1         = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"แขวง") - 1 )) .
    ELSE IF R-INDEX(wdetail.addr1,"ต.") <> 0  THEN  
        ASSIGN wdetail.tambon = trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"ต.")))
        wdetail.tambon        = trim(REPLACE(wdetail.tambon," ",""))
        wdetail.addr1         = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"ต.") - 1 )) .
    ELSE IF R-INDEX(wdetail.addr1,"ตำบล") <> 0  THEN  
        ASSIGN wdetail.tambon = trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"ตำบล")))
        wdetail.tambon        = trim(REPLACE(wdetail.tambon," ",""))
        wdetail.addr1         = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"ตำบล") - 1 )) .
    ASSIGN 
        wdetail.addr1 = REPLACE(wdetail.addr1,"ซอย","ซ.") 
        wdetail.addr1 = REPLACE(wdetail.addr1,"ถนน","ถ.") .
    IF INDEX(wdetail.addr1,"ถนน") <> 0  THEN      /*road */
        ASSIGN 
        wdetail.road    = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"ถนน")))
        wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"ถนน") - 1 )).
    ELSE IF INDEX(wdetail.addr1,"ถ.") <> 0  THEN  /*road */
        ASSIGN 
        wdetail.road    = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"ถ.")))
        wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"ถ.") - 1 )).
    IF INDEX(wdetail.addr1,"ซอย") <> 0  THEN  /*soy */
        ASSIGN 
        wdetail.soy     = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"ซอย")))
        wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"ซอย") - 1 )).
    ELSE IF INDEX(wdetail.addr1,"ซ.") <> 0  THEN  /*soy */
        ASSIGN 
        wdetail.soy     = replace(trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"ซ."))),"ซ. ","ซ.")
        wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"ซ.") - 1 )).
    /*IF LENGTH(wdetail.addr1) > 35 THEN DO:*/ /*A67-0114*/
    IF LENGTH(wdetail.addr1) > 45 THEN DO:  /*A67-0114*/
        loop_chk1:
        REPEAT:
            /*IF LENGTH(wdetail.addr1) > 35 THEN DO:*/ /*A67-0114*/
            IF LENGTH(wdetail.addr1) > 45 THEN DO:  /*A67-0114*/
                ASSIGN 
                    wdetail.soy   =  trim(trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1," "))) + " " + TRIM(wdetail.soy))
                    wdetail.addr1 =  trim(trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1," ")))) .
            END.
            ELSE LEAVE loop_chk1.
        END.
    END.
    /*IF LENGTH(wdetail.addr1 + " " + trim(wdetail.soy) + " " + trim(wdetail.road)) <= 35 THEN*/ /* A67-0114*/
    IF LENGTH(wdetail.addr1 + " " + trim(wdetail.soy) + " " + trim(wdetail.road)) <= 45 THEN  /* A67-0114*/
        ASSIGN wdetail.addr1 = wdetail.addr1 + " " + trim(wdetail.soy) + " " + trim(wdetail.road)
        wdetail.soy   = ""  
        wdetail.road  = "".
    /*ELSE IF LENGTH(wdetail.addr1 + " " + trim(wdetail.soy) ) <= 35 THEN*/ /* A67-0114*/
    ELSE IF LENGTH(wdetail.addr1 + " " + trim(wdetail.soy) ) <= 45 THEN  /* A67-0114*/
        ASSIGN wdetail.addr1 = wdetail.addr1 + " " + trim(wdetail.soy)  
               wdetail.soy   = ""  .
    ELSE DO:
        /**/
        ASSIGN 
            wdetail.addr1 =  trim(wdetail.addr1) + " " + trim(wdetail.soy)
            wdetail.soy   = ""  .
        loop_chk2:
        REPEAT:
            /*IF LENGTH(wdetail.addr1) > 35 THEN DO:*/ /*A67-0114*/
            IF LENGTH(wdetail.addr1) > 45 THEN DO: /*A67-0114*/
                ASSIGN 
                    wdetail.soy   =  trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1," "))  + " " + wdetail.soy)
                    wdetail.addr1 =  trim(trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1," ")))) .
            END.
            ELSE LEAVE loop_chk2.
        END.
        /*MESSAGE wdetail.addr1 wdetail.soy VIEW-AS ALERT-BOX.*/
    END.
    /*IF LENGTH(trim(wdetail.soy) + " " + trim(wdetail.road) + " " + trim(wdetail.tambon) + " " + trim(wdetail.amper)) <= 35 THEN*/ /*A67-0114*/
    IF LENGTH(trim(wdetail.soy) + " " + trim(wdetail.road) + " " + trim(wdetail.tambon) + " " + trim(wdetail.amper)) <= 45 THEN /*A67-0114*/
        ASSIGN 
        wdetail.soy     = trim(trim(wdetail.soy) + " " + trim(wdetail.road))
        wdetail.tambon  = trim(wdetail.soy)      + " " + trim(wdetail.tambon) + " " + trim(wdetail.amper)
        wdetail.amper   = trim(wdetail.country)
        wdetail.country = "" .
    /*ELSE IF LENGTH(trim(wdetail.soy) + " " + trim(wdetail.road) + " " + trim(wdetail.tambon)) <= 35 THEN*/ /*A67-0114*/
    ELSE IF LENGTH(trim(wdetail.soy) + " " + trim(wdetail.road) + " " + trim(wdetail.tambon)) <= 45 THEN  /*A67-0114*/
        ASSIGN 
        wdetail.soy     = trim(trim(wdetail.soy) + " " + trim(wdetail.road))
        wdetail.tambon  = trim(wdetail.soy)   + " " + trim(wdetail.tambon) 
        wdetail.amper   = trim(wdetail.amper) + " " + trim(wdetail.country)
        wdetail.country = "" .
    ELSE DO:
        ASSIGN 
            wdetail.amper   = trim(wdetail.tambon) + " " + trim(wdetail.amper)  
            wdetail.tambon  =trim(wdetail.soy) + " " + trim(wdetail.road) .
    END.

    ASSIGN wdetail.addr1 = REPLACE(wdetail.addr1,"  "," ").
    
    FIND FIRST brstat.msgcode  WHERE brstat.msgcode.compno = "999" AND
        brstat.msgcode.MsgDesc = trim(wdetail.tiname) NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode    THEN 
        ASSIGN wdetail.tiname = brstat.msgcode.branch.

    /*IF (wdetail.tiname = "บริษัท") OR (wdetail.tiname = "บมจ.") OR (wdetail.tiname = "หจก.") */ /*A60-0095*/
    /*    OR (wdetail.tiname = "หจก")THEN  wdetail.receipt_name = "".                          */ /*A60-0095*/
    /*ELSE DO:                                                                                 */ /*A60-0095*/
    IF wdetail.receipt_name <> "" THEN DO: 
        IF INDEX(wdetail.receipt_name,substr(wdetail.insnam,1,INDEX(wdetail.insnam," ") - 1 )) = 0 THEN
            wdetail.receipt_name = "และ/หรือ " + trim(wdetail.receipt_name).
        ELSE wdetail.receipt_name = "".
    END.
    /*END. */ /*A60-0095*/
    IF index(wdetail.brand,"ford") <> 0 THEN DO:
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno = "TISCO"      AND
            index(wdetail.cedpol,stat.insure.lname) <> 0   NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL stat.insure THEN  
            ASSIGN wdetail.cedpol   = trim(stat.insure.insno) .   
        ELSE 
            ASSIGN wdetail.cedpol = "" .
    END.
    ELSE IF index(wdetail.brand,"Hyundai") <> 0 THEN DO:     /*Kridtiya i. A67-0036*/
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno = "Hyundai"      AND
            index(wdetail.cedpol,stat.insure.lname) <> 0   NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL stat.insure THEN ASSIGN wdetail.cedpol   = trim(stat.insure.insno) .   
        ELSE ASSIGN wdetail.cedpol = "" .
    END.     /*Kridtiya i. A67-0036*/
    ELSE ASSIGN wdetail.cedpol = "" .
    IF wdetail.br_insured   <> "" THEN DO:
        wdetail.br_insured = trim(REPLACE(wdetail.br_insured,"สาขาที่","")).
        IF index(wdetail.br_insured,"สำนักงานใหญ่") <> 0 THEN wdetail.br_insured = "00000".
        
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

ASSIGN nv_address = trim(np_tambon + " " + np_mail_amper + " " + np_mail_country) .

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignclass c-Win 
PROCEDURE proc_assignclass :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by a60-0095....
CREATE wclass.
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "130A"
    wclass.wbase      = 161.57.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"     
    wclass.wclass     = "130B"  
    wclass.wbase      = 323.14.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "130C"   
    wclass.wbase      = 430.14 .   
CREATE wclass.             
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "130D"  
    wclass.wbase      = 645.21.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "170A"  
    wclass.wbase      = 773.61.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "170B"  
    wclass.wbase      = 430.14.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "171"   
    wclass.wbase      = 430.14.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1" 
    wclass.wclass     = "110"   
    wclass.wbase      = 645.21.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "120A"  
    wclass.wbase      = 1182.35.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "120B"   
    wclass.wbase      = 2203.13.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "120C"  
    wclass.wbase      = 3437.91.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "120D"  
    wclass.wbase      = 4017.85.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "140A"  
    wclass.wbase      = 967.28.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "140B"  
    wclass.wbase      = 1310.75.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "140C"  
    wclass.wbase      = 1408.12.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "140D"  
    wclass.wbase      = 1826.49.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "142A"  
    wclass.wbase      = 1805.09.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"
    wclass.wclass     = "142B"  
    wclass.wbase      = 2493.10.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1"  
    wclass.wclass     = "150"   
    wclass.wbase      = 2546.60.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1" 
    wclass.wclass     = "160"   
    wclass.wbase      = 645.21.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1" 
    wclass.wclass     = "401"   
    wclass.wbase      = 1644.59.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1" 
    wclass.wclass     = "406"   
    wclass.wbase      = 97.37.
CREATE wclass.         
ASSIGN wclass.wvehuse = "1" 
    wclass.wclass     = "407"   
    wclass.wbase      = 828.18.
....end a60-0095...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew c-Win 
PROCEDURE proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------------*/
/*IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.*/ /*Add kridtiya i. A54-0062 */
/* comment by a60-0095..................
DEF VAR number_sic AS INTE INIT 0.
ASSIGN  
    nr_prempa    = ""
    nr_subclass  = "".
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
    RUN wgw\wgwtcex1
                 (INPUT-OUTPUT wdetail.prepol,   /*n_prepol  */ 
                  INPUT-OUTPUT wdetail.branch,   /*n_branch  */ 
                  INPUT-OUTPUT nr_prempa,        /*n_prempa  */  
                  INPUT-OUTPUT nr_subclass,      /*n_subclass*/  
                  INPUT-OUTPUT wdetail.redbook,  /*n_redbook */  
                  INPUT-OUTPUT wdetail.brand,    /*n_brand   */  
                  INPUT-OUTPUT wdetail.model,    /*n_model   */  
                  INPUT-OUTPUT wdetail.caryear,  /*n_caryear */
                  INPUT-OUTPUT wdetail.cargrp,   /*n_cargrp  */  
                  INPUT-OUTPUT wdetail.engcc,  
                  INPUT-OUTPUT wdetail.tonss, 
                  INPUT-OUTPUT wdetail.body,
                  INPUT-OUTPUT wdetail.vehuse,   /*n_vehuse  */  
                  INPUT-OUTPUT wdetail.covcod,   /*n_covcod  */  
                  INPUT-OUTPUT wdetail.garage,   /*n_garage  */    
                  INPUT-OUTPUT wdetail.tp1,      /*n_tp1     */  
                  INPUT-OUTPUT wdetail.tp2,      /*n_tp2     */  
                  INPUT-OUTPUT wdetail.tp3,      /*n_tp3     */  
                  INPUT-OUTPUT nv_basere,        /*nv_basere */  
                  INPUT-OUTPUT wdetail.seat,     /* DECI     n_seat     */  
                  INPUT-OUTPUT wdetail.seat41,   /* INTE     */    
                  INPUT-OUTPUT n_41,             /* INTE     n_41       */  
                  INPUT-OUTPUT n_42,             /* DECI     n_42       */  
                  INPUT-OUTPUT n_43,             /* DECI     n_43       */  
                  INPUT-OUTPUT dod1,             /* DECI     n_dod      */  
                  INPUT-OUTPUT dod2,             /* DECI     n_dod2     */
                  INPUT-OUTPUT dod0,             /* DECI     n_pd       */  
                  INPUT-OUTPUT wdetail.fleetper,    /*n DECI    _feet     */  
                  INPUT-OUTPUT nv_dss_per,       /* DECI     nv_dss_per */  
                  INPUT-OUTPUT WDETAIL.NCB,      /* DECI     n_ncb      */  
                  INPUT-OUTPUT nv_cl_per,        /* DECI     n_lcd      */  
                  INPUT-OUTPUT n_firstdat ).     /* DECI     n_firstdat */
END.
IF wdetail.poltyp = "v72" THEN
    ASSIGN 
    wdetail.covcod = "T"  
    wdetail.garage = ""  
    nv_basere  = 0 
    n_41  = 0     
    n_42  = 0      
    n_43  = 0       
    dod1  = 0        
    dod2  = 0      
    dod0  = 0        
    wdetail.fleetper = 0   
    nv_dss_per       = 0    
    WDETAIL.NCB      = 0 
    nv_cl_per        = 0   .
IF wdetail.prempa   = "" THEN  ASSIGN wdetail.prempa   = nr_prempa  .
IF wdetail.subclass = "" THEN  ASSIGN wdetail.subclass = nr_subclass  .
...........end a60-0095..........*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_re c-Win 
PROCEDURE proc_assign_re :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE(fi_FileName).
REPEAT:
 CREATE wdetail2.
 IMPORT DELIMITER "|" 
     wdetail2.Pro_off        /*2   2   รหัสสาขาที่ผู้เอาประกันภัยเปิดบัญชี */        
     wdetail2.cmr_code       /*3...3   รหัสเจ้าหน้าที่การตลาด              */        
     wdetail2.comcode        /*4...3   รหัสบริษัทประกัน 3หลัก  */        
     wdetail2.policyno       /*5...25  เลขที่รับแจ้งประกัน  */     
     wdetail2.caryear        /*6...4   ปีรถ*/     
     wdetail2.eng            /*7...25  เครื่อง ยนต์  */
     wdetail2.chasno         /*8...25  หมายเลขตัวถัง  */
     wdetail2.engcc          /*9...5   น้ำหนัก         */
     wdetail2.power          /*10..7   กำลังเครื่องยนต์*/
     wdetail2.colorcode      /*11...2  สีรถ  */
     wdetail2.vehreg         /*12...2  ทะเบียน */     
     wdetail2.garage         /*13...2  การซ่อม */
     wdetail2.fleetper       /*14...2  ส่วนลดหมู่ */
     wdetail2.ncb            /*15..3   ส่วนลดประวัติดี*/
     wdetail2.orthper        /*16...3  ส่วนลดอื่นๆ */
     wdetail2.vehuse         /*17...2  การใช้งาน */
     wdetail2.comdat         /*18...2  วันเริ่มคุ้มครอง */
     wdetail2.si             /*19...2   ทุน*/
     wdetail2.name_insur     /*20...2   ชื่อเจ้าหน้าที่ประกัน*/
     wdetail2.not_office     /*21...3   รหัสเจ้าหน้าที่แจ้งประกัน*/
     wdetail2.entdat         /*22...3   วันที่แจ้งประกัน*/
     wdetail2.enttim         /*23...2   เวลาแจ้งประกัน*/
     wdetail2.not_code       /*24...2   รหัสแจ้งงาน*/        
     wdetail2.premt          /*25...2   เบี้ยประกันรวม  ภาษี อากร*/
     wdetail2.comp_prm       /*26...2   เบี้ยพรบ.  ภาษี อากร*/
     wdetail2.stk            /*27...3   สติ๊กเกอร์*/
     wdetail2.brand          /*28...3   ยี่ห้อ*/
     wdetail2.addr1          /*29...2   ที่อยูผู้เอาประกัน1*/
     wdetail2.addr2          /*30...2   ที่อยูผู้เอาประกัน2*/
     wdetail2.tiname         /*31...2   คำนำหน้า*/
     wdetail2.insnam         /*32...2   ชื่อลูกค้า*/
     wdetail2.name2          /*33...3   นามสกุล*/
     wdetail2.benname        /*34...3   ผู้รับผลประโยชน์*/
     wdetail2.remark         /*35...2   หมายเหตุ*/
     wdetail2.Account_no     /*36...2   เลขที่สัญญาของผู้เอาประกัน*/         
     wdetail2.client_no      /*37...2   รหัสของผู้เอาประกัน*/
     wdetail2.expdat         /*38...2   วันสิ้นสุดความคุ้มครอง*/
     wdetail2.gap            /*39...3   เบี้ยรวม พรบ*/
     wdetail2.re_country     /*40...3   จังหวัดที่จดทะเบียน*/
     wdetail2.receipt_name   /*41...2   ชื่อออกใบเสร็จ*/
     wdetail2.agent          /*42...2   บริษัท*/
     wdetail2.prev_insur     /*43...2   บริษัทประกันภัยเดิม*/
     wdetail2.prepol         /*44...2   เลขกรมธรรม์เดิม*/
     wdetail2.deduct         /*45...3   ส่วนลดเสียหายแรก*/
     wdetail2.add1_70        /*46 add1 ภาคสมัครใจ         */
     wdetail2.add2_70        /*47 add2 ภาคสมัครใจ         */
     wdetail2.Sub_Di_70      /*48 Sub Dist. 1149 1178 30  */
     wdetail2.Direc_70       /*49 Direction 1179 1208 30  */
     wdetail2.Provi_70       /*50 Province  1209 1238 30  */
     wdetail2.ZipCo_70       /*51 ZipCode   1239 1243 5   */
     wdetail2.add1_72        /*52 add1 ภาคสมัครใจ         */
     wdetail2.add2_72        /*53 add2 ภาคสมัครใจ         */
     wdetail2.Sub_Di_72      /*54 Sub Dist. 1149 1178 30  */
     wdetail2.Direc_72       /*55 Direction 1179 1208 30  */
     wdetail2.Provi_72       /*56 Province  1209 1238 30  */
     wdetail2.ZipCo_72       /*57 ZipCode   1239 1243 5   */
     wdetail2.apptype        /*58 application type h = ยังไม่ออกกรมธรรม์ p = ออกกรมธรรม์ได้*/
     wdetail2.appcode        /*59 application code [HP, H2, H6, HN, HM, HG] */
     wdetail2.nBLANK         /*60 */
     wdetail2.prempa         /*61 package*/
     wdetail2.seate          /*add A57-0017 add seate */
     wdetail2.tp1            /*62 pd 1   */
     wdetail2.tp2            /*63 pd 2   */
     wdetail2.tp3            /*64 pd 3   */
     wdetail2.covcod         /*65 covcod */
     wdetail2.producer       /*66 Producerr -*/
     wdetail2.agent1         /*67 Agent -*/
     wdetail2.nbranch        /*68 Branch -*/
     wdetail2.npolty         /*69 Poltyp -*/
     wdetail2.nredbook       /*70 Red Book -*/
     wdetail2.Price_Ford     /* Price Ford */                                                                  
     wdetail2.Year_fd        /* Year FD */                                                                     
     wdetail2.Brand_Model                                                                                      
     wdetail2.id_no70        /*“เลขทีบัตรประจำตัวประชาชน/เลขทีหนังสือเดินทาง /เลขทะเบียนพาณิชย์”*/           
     wdetail2.id_nobr70      /*สาขาของสถานประกอบการลูกค้า*/                                                    
     wdetail2.id_no72        /*“เลขทีบัตรประจำตัวประชาชน/เลขทีหนังสือเดินทาง /เลขทะเบียนพาณิชย์”*/           
     wdetail2.id_nobr72      /*สาขาของสถานประกอบการลูกค้า*/                                                    
     wdetail2.comp_comdat    /*Effective Date Accidential*/            
     wdetail2.comp_expdat    /*Expiry Date Accidential*/               
     wdetail2.fi             /*Coverage Amount Theft*/                 
     wdetail2.class          /*Car code*/                              
     wdetail2.usedtype       /*Per Used*/                              
     wdetail2.driveno1       /*Driver Seq1*/                                 
     wdetail2.drivename1     /*Driver Name1*/                                
     wdetail2.bdatedriv1     /*Birthdate Driver1*/                           
     wdetail2.occupdriv1     /*Occupation Driver1*/                          
     wdetail2.positdriv1     /*Position Driver1 */                           
     wdetail2.driveno2       /*Driver Seq2*/                                 
     wdetail2.drivename2     /*Driver Name2*/                                
     wdetail2.bdatedriv2     /*Birthdate Driver2*/                           
     wdetail2.occupdriv2     /*Occupation Driver2*/                          
     wdetail2.positdriv2     /*Position Driver2*/                            
     wdetail2.driveno3       /*Driver Seq3*/                                 
     wdetail2.drivename3     /*Driver Name3*/                                
     wdetail2.bdatedriv3     /*Birthdate Driver3*/                           
     wdetail2.occupdriv3     /*Occupation Driver3*/                          
     wdetail2.positdriv3     /*Position Driver3*/                            
     wdetail2.nBLANK         /* A57-0088 */
     wdetail2.Reciept72 
     /* A67-0087 */
     wdetail2.access          
     wdetail2.Rec_name72   
     wdetail2.Rec_add1     
     wdetail2.n_comment   
     wdetail2.n_comment   
     wdetail2.n_comment   
     wdetail2.n_comment   
     wdetail2.n_comment   
     wdetail2.n_comment   
     wdetail2.n_comment 
     wdetail2.n_comment   
     wdetail2.Schanel   
     wdetail2.bev       
     wdetail2.driveno4  
     wdetail2.drivename4
     wdetail2.bdatedriv4
     wdetail2.occupdriv4
     wdetail2.positdriv4
     wdetail2.driveno5  
     wdetail2.drivename5
     wdetail2.bdatedriv5
     wdetail2.occupdriv5
     wdetail2.positdriv5
     wdetail2.campagin  
     wdetail2.inspic    
     wdetail2.engcount  
     wdetail2.engno2    
     wdetail2.engno3    
     wdetail2.engno4    
     wdetail2.engno5    
     wdetail2.classcomp 
     wdetail2.carbrand . 
END.   /* repeate */

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
/* comment by a60-0095...........
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "v70" THEN DO:
    IF wdetail.model = "commuter"  THEN nv_baseprm = 13000.
    IF wdetail.prepol = "" THEN  RUN wgs\wgsfbas.
    ELSE nv_baseprm = nv_basere.
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
    IF wdetail.prepol <> "" THEN  ASSIGN nv_41 = n_41  /*ต่ออายุ*/          
                                         nv_42 = n_42                       
                                         nv_43 = n_43                       
                                         nv_seat41 = inte(wdetail.seat41).  
    ELSE IF wdetail.prempa = "Z" THEN
        ASSIGN 
        nv_41 = 50000  /*deci(wdetail.no_41)*/ 
        nv_42 = 50000         /*deci(wdetail.no_42)*/
        nv_43 = 200000        /*deci(wdetail.no_43)*/  
        nv_seat41 = inte(wdetail.seat) .     
    IF wdetail.model = "commuter" THEN 
        ASSIGN wdetail.seat = 16
        nv_seats = 16
        nv_seat41 =  16.
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
      ASSIGN  /*dod1 = dod1 * ( -1 )
          dod2     = dod2 * ( -1 )
          dod0     = dod0 * ( -1 )*/
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
      nv_flet_per = INTE(wdetail.fleetper).
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
                         nv_uom1_v ,       
                         nv_uom2_v ,       
                         nv_uom5_v ). 
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
.......end a60-0095........*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcomp c-Win 
PROCEDURE proc_chkcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A67-0185      
------------------------------------------------------------------------------*/
DEF VAR n_comp72 AS CHAR INIT "" .
ASSIGN  n_comp72    = ""
        nv_chkerror = "".

/*MESSAGE wdetail.policy 
        " bev      " wdetail.bev       skip
        " prempa   " wdetail.prempa    skip
        " subclass " wdetail.subclass  skip
        " garage   " wdetail.garage    skip
        " vehuse   " wdetail.vehuse    skip
        "n_comp_1  " n_comp_1          skip
       
    VIEW-AS ALERT-BOX.*/

RUN wgw/wgwcomp(INPUT  wdetail.comp_prm,     
                INPUT  wdetail.vehuse  , 
                INPUT  wdetail.prempa  , 
                INPUT  wdetail.subclass, 
                INPUT  wdetail.bev     , 
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

/*
IF wdetail.bev = "Y" THEN DO:
    FIND LAST sicsyac.xmm106 WHERE 
              sicsyac.xmm106.tariff  = "9"      AND
              sicsyac.xmm106.bencod  = "comp"   AND         
              SUBSTR(sicsyac.xmm106.CLASS,1,3) = trim(wdetail.subclass)  AND 
              sicsyac.xmm106.covcod  = "T"                  AND 
              sicsyac.xmm106.KEY_b   = INTE(wdetail.vehuse) AND 
              sicsyac.xmm106.baseap  = n_comp_1   NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm106 THEN DO:
        ASSIGN n_comp72 = sicsyac.xmm106.class .
    END.
    ELSE DO:
        FIND LAST sicsyac.xmm106 WHERE 
                  sicsyac.xmm106.tariff  = "9"      AND 
                  sicsyac.xmm106.bencod  = "comp"   AND 
                  SUBSTR(sicsyac.xmm106.CLASS,1,3)  = substr(wdetail.subclass,1,3)   AND
                  sicsyac.xmm106.covcod  = "T"      AND 
                  sicsyac.xmm106.baseap = n_comp_1  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm106 THEN ASSIGN n_comp72 = sicsyac.xmm106.class .
        ELSE DO:
          FIND FIRST sicsyac.xzmcom WHERE
              sicsyac.xzmcom.class    = wdetail.prempa + wdetail.subclass  AND
              sicsyac.xzmcom.garage   = wdetail.garage     AND
              sicsyac.xzmcom.vehuse   = wdetail.vehuse     NO-LOCK NO-ERROR NO-WAIT.
          IF AVAILABLE sicsyac.xzmcom THEN DO:
              ASSIGN n_classcomp72  = replace(sicsyac.xzmcom.comp_cod,".","")
                     n_classcomp72  = replace(n_classcomp72," ","").
          END.
          ELSE DO:
              FIND FIRST sicsyac.xzmcom WHERE
                  sicsyac.xzmcom.class    = wdetail.prempa + wdetail.subclass  AND 
                  sicsyac.xzmcom.vehuse   = wdetail.vehuse      NO-LOCK NO-ERROR NO-WAIT.
              IF AVAILABLE sicsyac.xzmcom THEN 
                  ASSIGN n_classcomp72  = replace(sicsyac.xzmcom.comp_cod,".","")
                  n_classcomp72  = replace(n_classcomp72," ","").
              ELSE ASSIGN wdetail.comment = wdetail.comment + "| ไม่พบ Class " + wdetail.prempa + wdetail.subclass + "และ Veh. Use" + wdetail.vehuse + 
                      "ที่แฟ้มตารางเปรียบเทียบ (sicsyac.xzmcom)" .
          END. 

          FIND LAST sicsyac.xmm106 WHERE 
                   sicsyac.xmm106.tariff  = "9"      AND
                   sicsyac.xmm106.bencod  = "comp"   AND
                   substr(sicsyac.xmm106.CLASS,1,3)   = trim(n_classcomp72)  AND
                   sicsyac.xmm106.covcod  = "t"                 AND 
                   sicsyac.xmm106.baseap  = n_comp_1  NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm106 THEN  ASSIGN n_comp72 = sicsyac.xmm106.class .
            ELSE DO:
                FIND LAST sicsyac.xmm106 WHERE 
                          sicsyac.xmm106.tariff  = "9"      AND
                          sicsyac.xmm106.bencod  = "comp"   AND
                          substr(sicsyac.xmm106.CLASS,1,3)  = substr(n_classcomp72,1,3)    AND
                          sicsyac.xmm106.covcod  = "t"      AND 
                          sicsyac.xmm106.baseap  = n_comp_1 NO-LOCK NO-ERROR.
                 IF AVAIL sicsyac.xmm106 THEN  ASSIGN n_comp72 = sicsyac.xmm106.class .
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
        ASSIGN n_classcomp72  = replace(sicsyac.xzmcom.comp_cod,".","")
               n_classcomp72  = replace(n_classcomp72," ","").
    ELSE DO:
        FIND FIRST sicsyac.xzmcom WHERE
            sicsyac.xzmcom.class    = wdetail.prempa + wdetail.subclass  AND 
            sicsyac.xzmcom.vehuse   = wdetail.vehuse      NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xzmcom THEN 
            ASSIGN n_classcomp72  = replace(sicsyac.xzmcom.comp_cod,".","")
                   n_classcomp72  = replace(n_classcomp72," ","").
        ELSE ASSIGN wdetail.comment = wdetail.comment + "| ไม่พบ Class " + wdetail.prempa + wdetail.subclass + "และ Veh. Use" + wdetail.vehuse + 
                      "ที่แฟ้มตารางเปรียบเทียบ (sicsyac.xzmcom)" .
    END.
    FIND LAST sicsyac.xmm106 WHERE 
            sicsyac.xmm106.tariff  = "9"      AND
            sicsyac.xmm106.bencod  = "comp"   AND
            sicsyac.xmm106.CLASS   = trim(n_classcomp72) AND
            sicsyac.xmm106.covcod  = "t"                 AND 
            sicsyac.xmm106.baseap  = n_comp_1  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm106 THEN  ASSIGN n_comp72 = sicsyac.xmm106.class .
        ELSE DO:
            FIND LAST sicsyac.xmm106 WHERE 
            sicsyac.xmm106.tariff  = "9"      AND
            sicsyac.xmm106.bencod  = "comp"   AND
            substr(sicsyac.xmm106.CLASS,1,3)  = substr(n_classcomp72,1,3)    AND
            sicsyac.xmm106.covcod  = "t"      AND 
            sicsyac.xmm106.baseap  = n_comp_1 NO-LOCK NO-ERROR.
             IF AVAIL sicsyac.xmm106 THEN  ASSIGN n_comp72 = sicsyac.xmm106.class .
             ELSE DO:
                n_comp72 = "" .
                FOR EACH sicsyac.xmm106 WHERE 
                    sicsyac.xmm106.tariff  = "9"      AND
                    sicsyac.xmm106.bencod  = "comp"   AND
                    /*substr(sicsyac.xmm106.CLASS,1,3)  = substr(n_class,1,3)    AND*/ 
                    sicsyac.xmm106.covcod  = "T"      AND 
                    sicsyac.xmm106.baseap  = n_comp_1 NO-LOCK .
                    ASSIGN n_classcomp72 = TRIM(SUBSTR(sicsyac.xmm106.class,1,1) + "." + SUBSTR(sicsyac.xmm106.class,2,LENGTH(sicsyac.xmm106.class))) .
                
                    IF n_comp72 <> ""  THEN NEXT.
                    ELSE DO:
                        FIND FIRST sicsyac.xzmcom WHERE
                            sicsyac.xzmcom.class    = wdetail.prempa + wdetail.subclass  AND
                            /*sicsyac.xzmcom.vehuse   = n_vehues      AND*/
                            sicsyac.xzmcom.comp_cod = n_classcomp72     NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAILABLE sicsyac.xzmcom THEN DO:
                                ASSIGN n_comp72  = sicsyac.xzmcom.comp_cod
                                       n_comp72  = trim(replace(n_comp72,".","")).
                            END.
                    END.
                END.
                IF n_comp72 = "" THEN DO: 
                     ASSIGN wdetail.comment = wdetail.comment + "| ไม่พบข้อมูล Class " + wdetail.prempa + wdetail.subclass + 
                            " Match กับ Class พรบ. " + n_classcomp72 + " ที่ sicsyac.xzmcom " .
                END.
             END.
        END.
END.
ASSIGN wdetail.subclass = TRIM(n_comp72) .
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpolpremium c-Win 
PROCEDURE proc_chkpolpremium :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
def var nv_chasno  as char  format "x(50)" init "" .
def var nv_poltyp  as char  format "x(50)" init "" .
def var nv_vehreg  as char  format "x(50)" init "" .
def var nv_chassic as char  format "x(50)" init "" .
def var nv_typpol  as char  format "x(50)" init "" .
def var nv_comdat  as date   init "" .
def var nv_expdat  as date   init "" .

 ASSIGN nv_chasno  = ""
        nv_poltyp  = ""
        nv_comdat  = ?
        nv_expdat  = ?
        nv_vehreg  = "" /*A65-0079*/
        nv_chasno  = trim(wdetail.chasno)
        nv_poltyp  = TRIM(wdetail.poltyp)
        nv_comdat  = DATE(wdetail.comdat)
        nv_expdat  = DATE(wdetail.expdat)
        nv_vehreg  = IF INDEX(wdetail.vehreg,"-") <> 0 THEN REPLACE(wdetail.vehreg,"-"," ") + " " + trim(wdetail.re_country)  
                     ELSE trim(wdetail.vehreg) + " " + trim(wdetail.re_country) /*A65-0079*/ .

/* add by : A67-0185 */
  /* Check Date and Cover Day */
  nv_chkerror = "" .
  IF trim(wdetail.comdat) = "" OR trim(wdetail.expdat) = "" THEN DO:
   ASSIGN wdetail.comment = wdetail.comment + "| วันที่คุ้มครอง หรือวันที่หมดอายุ เป็นค่าว่าง " 
          wdetail.pass    = "N"
          wdetail.OK_GEN  = "N".
  END.
  ELSE DO:  
    RUN wgw/wgwchkdate(input wdetail.comdat,
                       input wdetail.expdat,
                       input wdetail.poltyp,
                       OUTPUT nv_chkerror ) .
    IF nv_chkerror <> ""  THEN DO:
        ASSIGN wdetail.comment = wdetail.comment + "|" + nv_chkerror 
               wdetail.pass    = "N"
               wdetail.OK_GEN  = "N".
    END.
                        
    IF nv_chasno <> ""   THEN DO:
       FIND FIRST sicuw.uwm301 Use-index uwm30121 Where sicuw.uwm301.cha_no = trim(nv_chasno) No-lock no-error no-wait.
       If avail sicuw.uwm301 Then DO:
    
         FOR EACH  sicuw.uwm301 Use-index uwm30121 Where sicuw.uwm301.cha_no = trim(nv_chasno) NO-LOCK:
    
             Find LAST sicuw.uwm100 Use-index uwm10001       Where
                 sicuw.uwm100.policy = sicuw.uwm301.policy   and
                 sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                 /*sicuw.uwm100.endcnt = sicuw.uwm301.endcnt   AND */ /*A64-0044*/
                 sicuw.uwm100.poltyp = nv_poltyp  No-lock no-error no-wait.
             If avail sicuw.uwm100 Then DO:
    
                 IF DATE(sicuw.uwm100.expdat) > date(nv_comdat) AND 
                    YEAR(sicuw.uwm100.expdat) = YEAR(nv_expdat) AND  
                    sicuw.uwm100.polsta    = "IF" THEN DO:
                    ASSIGN wdetail.comment = wdetail.comment + "| เลขตัวถังนี้มีกรมธรรม์ในระบบแล้ว" + uwm100.policy      
                           WDETAIL.OK_GEN  = "N"
                           wdetail.pass    = "N". 
                 END.
                 /* add by : A64-0355 */
                 ELSE IF DATE(sicuw.uwm100.expdat) > date(nv_comdat)  AND 
                         YEAR(sicuw.uwm100.expdat) <> YEAR(nv_expdat) AND 
                         MONTH(sicuw.uwm100.expdat) - MONTH(TODAY) > 3 AND
                         sicuw.uwm100.polsta    = "IF" THEN DO:
                     ASSIGN wdetail.comment = wdetail.comment + "| เลขตัวถังนี้มีกรมธรรม์ในระบบแล้ว" + uwm100.policy      
                           WDETAIL.OK_GEN  = "N"
                           wdetail.pass    = "N". 
                 END.
                 /* end : A64-0355 */
             END.
         END. /*FOR EACH  sicuw.uwm301 */
    
       END.        /*avil 301*/
       RELEASE sicuw.uwm301.
       RELEASE sicuw.uwm100.
    END.
    /* Add by : a65-0079 */
    IF (wdetail.subclass = "801") OR (wdetail.subclass = "401") /*A66-0202*/ THEN DO:
        FIND FIRST sicuw.uwm301 Use-index uwm30102 Where sicuw.uwm301.vehreg = trim(nv_vehreg) No-lock no-error no-wait.
          If avail sicuw.uwm301 Then DO:
             FOR EACH  sicuw.uwm301 Use-index uwm30102 Where sicuw.uwm301.vehreg = trim(nv_vehreg) NO-LOCK:
             
                 Find LAST sicuw.uwm100 Use-index uwm10001       Where
                     sicuw.uwm100.policy = sicuw.uwm301.policy   and
                     sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                     sicuw.uwm100.poltyp = nv_poltyp  No-lock no-error no-wait.
                 If avail sicuw.uwm100 Then DO:
             
                     IF DATE(sicuw.uwm100.expdat) > date(nv_comdat) AND 
                        YEAR(sicuw.uwm100.expdat) = YEAR(nv_expdat) AND  
                        sicuw.uwm100.polsta    = "IF" THEN DO:
                        ASSIGN wdetail.comment = wdetail.comment + "| เลขทะเบียนนี้มีกรมธรรม์ในระบบแล้ว" + uwm100.policy      
                               WDETAIL.OK_GEN  = "N"
                               wdetail.pass    = "N". 
                     END.
                     /* add by : A64-0355 */
                     ELSE IF DATE(sicuw.uwm100.expdat) > date(nv_comdat)  AND 
                             YEAR(sicuw.uwm100.expdat) <> YEAR(nv_expdat) AND 
                             MONTH(sicuw.uwm100.expdat) - MONTH(TODAY) > 3 AND
                             sicuw.uwm100.polsta    = "IF" THEN DO:
                         ASSIGN wdetail.comment = wdetail.comment + "| เลขทะเบียนนี้มีกรมธรรม์ในระบบแล้ว" + uwm100.policy      
                               WDETAIL.OK_GEN  = "N"
                               wdetail.pass    = "N". 
                     END.
                     /* end : A64-0355 */
                 END.
             END. /*FOR EACH  sicuw.uwm301 */
          END.        /*avil 301*/
       RELEASE sicuw.uwm301.
       RELEASE sicuw.uwm100.
    END.
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
/* comment by a60-0095...............
ASSIGN fi_process = "Start Check Data empty...".
DISP fi_process WITH FRAM fr_main.
IF wdetail.vehreg = " " AND wdetail.prepol  = " " THEN DO: 
    ASSIGN wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N". 
END.
ELSE DO:
        Def  var  nv_vehreg  as char  init  " ".
        Def  var  s_polno       like sicuw.uwm100.policy   init " ".
        Find LAST sicuw.uwm301 Use-index uwm30102 Where  
            sicuw.uwm301.vehreg = wdetail.vehreg
            No-lock no-error no-wait.
        IF AVAIL sicuw.uwm301 THEN DO:
            If  sicuw.uwm301.policy =  wdetail.policyno     and          
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
            If avail sicuw.uwm100 Then 
                s_polno     =   sicuw.uwm100.policy.
        END.   /*avil 301*/
END.           /*note end else*/   /*end note vehreg*/
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
/*IF wdetail.drivnam = "y" AND wdetail.drivername1 =  " "   THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
        wdetail.pass    = "N" 
        wdetail.OK_GEN  = "N".*/
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
IF wdetail.engcc    = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
IF wdetail.seat  = 0 THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"  
        wdetail.OK_GEN  = "N".
IF wdetail.branch = " " THEN
    ASSIGN
        wdetail.comment = wdetail.comment + "| สาขา เป็นค่าว่าง มีผลต่อการค้นหาข้อมูล"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".
ASSIGN  
    nv_maxsi = 0
    nv_minsi = 0
    nv_si    = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred = NO  
    nv_modcod = " ". 
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
        stat.maktab_fil.sclass = wdetail.subclass  AND 
        stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then do:
        ASSIGN  
            nv_modcod        =  stat.maktab_fil.modcod                                    
            nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            /*chkred         =  YES    */                 /*note chk found redbook*/
            wdetail.body     =  stat.maktab_fil.body   
            wdetail.brand    =  stat.maktab_fil.makdes
            /*wdetail.engcc    =  STRING(stat.maktab_fil.engine) */
            /*wdetail.subclass =  stat.maktab_fil.sclass         */
            /*wdetail.si       =  STRING(stat.maktab_fil.si)       */
            wdetail.redbook    =  stat.maktab_fil.modcod                                    
            /*wdetail.seat     =  STRING(stat.maktab_fil.seats)*/
            nv_si              = maktab_fil.si   .
        IF wdetail.covcod = "1"  THEN DO:
            FIND FIRST stat.makdes31        WHERE 
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
        END.  /***--- End Check Rate SI ---***/
    End.          
    ELSE ASSIGN  nv_modcod = ""
        wdetail.redbook    = "".
END. /*red book <> ""*/   
IF nv_modcod = " " THEN DO:
    RUN proc_model_brand.
    IF INDEX(wdetail.model,"vigo") <> 0 THEN wdetail.model = "vigo".
    ELSE IF INDEX(wdetail.model,"altis") <> 0 THEN wdetail.model = "altis".
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass 
        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN n_ratmin = makdes31.si_theft_p   
        n_ratmax = makdes31.load_p   .    
    ELSE ASSIGN n_ratmin = 0
        n_ratmax = 0.
    IF (wdetail.covcod = "3") OR (wdetail.covcod = "2") THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.engine  <=     Integer(wdetail.engcc)   AND
        stat.maktab_fil.sclass   =     wdetail.subclass         AND
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        chkred           =  YES
        wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.body     =  stat.maktab_fil.body   
        nv_modcod        =  stat.maktab_fil.modcod                                    
        nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac.
    END.
    ELSE DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.engine   <=     Integer(wdetail.engcc)  AND
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
       (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        chkred           =  YES
        wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.body     =  stat.maktab_fil.body   
        nv_modcod        =  stat.maktab_fil.modcod                                    
        nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac.

    END.
    IF nv_modcod = ""  THEN DO: 
        ASSIGN chkred = YES.
        RUN proc_model_brand.
        /*RUN proc_maktab.*/
    END.
END.
ASSIGN  NO_CLASS  = wdetail.prempa + wdetail.subclass 
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
        ASSIGN  wdetail.comment = wdetail.comment + "| Not on Business class on xmm016"
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
    ASSIGN  wdetail.comment = wdetail.comment + "| Not on Vehicle Usage Codes table sym100 u014"
    wdetail.pass    = "N" 
    wdetail.OK_GEN  = "N".
Find  sicsyac.sym100 Use-index sym10001  Where
    sicsyac.sym100.tabcod = "u013"         And
    sicsyac.sym100.itmcod = wdetail.covcod
    No-lock no-error no-wait.
IF not avail sicsyac.sym100 Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| Not on Motor Cover Type Codes table sym100 u013"
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
nv_sclass = wdetail.subclass. 
If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
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
     ............end a60-0095...............*/
     
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
FOR EACH wdetail WHERE wdetail.policyno <> "" :
    ASSIGN nv_basere = 0      /*nv_basere  */  
        n_41 = 0              /*n_41       */  
        n_42 = 0              /*n_42       */  
        n_43 = 0              /*n_43       */  
        dod1 = 0              /*n_dod      */  
        dod2 = 0              /*n_dod2     */
        dod0 = 0              /*n_pd       */  
        nv_dss_per = 0        /*nv_dss_per */  
        nv_cl_per  = 0        /*n_lcd      */  
        n_firstdat = ?        /*n_firstdat */
        nv_insref  = ""       /*A56-0104*/ 
        fi_process = "Start Check Data..."  +  wdetail.policyno .
    DISP fi_process WITH FRAM fr_main.
    IF  wdetail.policyno = ""  THEN NEXT.
    /*------------------  renew ---------------------*/
    ASSIGN 
        n_rencnt = 0
        n_endcnt = 0.
     /* A67-0114 */
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
    /* end A67-0114 */
    IF wdetail.poltyp = "v72"  THEN DO:
        /*IF wdetail.prepol <> "" THEN RUN proc_renew.  /* A55-0267 */*//*A57-0017*/
        /*RUN proc_72. */ /*A57-0017*/
        /*Add by Kridtiya i. A63-0472*/
        /*wdetail.br_insured = "00000".*//*A66-0160 มีรับค่ามาแล้ว*/
        RUN proc_assign2addr (INPUT  trim(wdetail.addr1)                
                             ,INPUT  trim(wdetail.tambon)               
                             ,INPUT  trim(wdetail.amper) + " " + trim(wdetail.country)   
                             ,INPUT  ""     /*wdetail.occup     */                                           
                             ,OUTPUT wdetail.codeocc                             
                             ,OUTPUT wdetail.codeaddr1                           
                             ,OUTPUT wdetail.codeaddr2                           
                             ,OUTPUT wdetail.codeaddr3).                         
        RUN proc_matchtypins (INPUT  trim(wdetail.tiname)  
                             ,INPUT  trim(wdetail.insnam)  
                             ,OUTPUT wdetail.insnamtyp
                             ,OUTPUT wdetail.firstName
                             ,OUTPUT wdetail.lastName).
        IF nv_postcd <> "" THEN DO:
            wdetail.postcd = nv_postcd.
            IF       index(wdetail.country,nv_postcd) <> 0 THEN  wdetail.country = REPLACE(wdetail.country,nv_postcd,"").
            ELSE IF  index(wdetail.amper,nv_postcd)   <> 0 THEN  wdetail.amper   = REPLACE(wdetail.amper,nv_postcd,"").
            ELSE IF  index(wdetail.tambon,nv_postcd)  <> 0 THEN  wdetail.tambon  = REPLACE(wdetail.tambon,nv_postcd,""). 
        END.
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        IF      wdetail.producer = "A0M2008"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer  = "B3MLTIS101" wdetail.financecd = "FTIS"   wdetail.campaign_ov = "RENEW".  
        ELSE IF wdetail.producer = "A0M2008"                             THEN ASSIGN wdetail.producer  = "B3MLTIS101" wdetail.financecd = "FTIS"   wdetail.campaign_ov = "TRANSF".
        ELSE IF wdetail.producer = "A0M2010"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer  = "B3MLTIS102" wdetail.financecd = "FTIS"   wdetail.campaign_ov = "RENEW". 
        ELSE IF wdetail.producer = "A0M2010"                             THEN ASSIGN wdetail.producer  = "B3MLTIS102" wdetail.financecd = "FTIS"   wdetail.campaign_ov = "TRANSF".
        ELSE IF wdetail.producer = "A0M2011"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer  = "B3MLTIS103" wdetail.financecd = "FTIS"   wdetail.campaign_ov = "RENEW".   
        ELSE IF wdetail.producer = "A0M2011"                             THEN ASSIGN wdetail.producer  = "B3MLTIS103" wdetail.financecd = "FTIS"   wdetail.campaign_ov = "TRANSF".
        ELSE IF wdetail.producer = "A0M2012"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer  = "B3MLTIS104" wdetail.financecd = "FTIS"   wdetail.campaign_ov = "RENEW".  
        ELSE IF wdetail.producer = "A0M2012"                             THEN ASSIGN wdetail.producer  = "B3MLTIS104" wdetail.financecd = "FTIS"   wdetail.campaign_ov = "TRANSF".
        ELSE IF wdetail.producer = "B3M0003"    AND wdetail.prepol = ""  THEN ASSIGN wdetail.producer  = "B3MLTIS201" wdetail.financecd = "FTISCO" wdetail.campaign_ov = "REDPLATE".     
        ELSE IF wdetail.producer = "B3M0007"    AND wdetail.prepol = ""  THEN ASSIGN wdetail.producer  = "B3MLTIS202" wdetail.financecd = "FTISCO" wdetail.campaign_ov = "BTREDPLATE".   
        ELSE IF wdetail.producer = "B3M0007"                             THEN ASSIGN wdetail.producer  = "B3MLTIS202" wdetail.financecd = "FTISCO" wdetail.campaign_ov = "BTRENEW".
        ELSE IF wdetail.producer = "B3M0028"    AND wdetail.prepol = ""  THEN ASSIGN wdetail.producer  = "B3MLTIS203" wdetail.financecd = "FTISCO" wdetail.campaign_ov = "BBREDPLATE".
        ELSE IF wdetail.producer = "B3M0028"                             THEN ASSIGN wdetail.producer  = "B3MLTIS203" wdetail.financecd = "FTISCO" wdetail.campaign_ov = "BBRENEW".      
        ELSE IF wdetail.producer = "B3M0029"    AND wdetail.prepol = ""  THEN ASSIGN wdetail.producer  = "B3MLTIS204" wdetail.financecd = "FTISCO" wdetail.campaign_ov = "ISREDPLATE". 
        ELSE IF wdetail.producer = "A0M0013"    AND wdetail.prepol = ""  THEN ASSIGN wdetail.producer  = "B3MLTIS301" wdetail.financecd = "FHIWAY" wdetail.campaign_ov = "REDPLATE".     
        ELSE IF wdetail.producer = "A0M0013"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer  = "B3MLTIS301" wdetail.financecd = "FHIWAY" wdetail.campaign_ov = "RENEW". 
        ELSE IF wdetail.producer = "B3MLTIS101" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FTIS"       wdetail.campaign_ov = "RENEW".  
        ELSE IF wdetail.producer = "B3MLTIS101"                          THEN ASSIGN wdetail.financecd = "FTIS"       wdetail.campaign_ov = "TRANSF".
        ELSE IF wdetail.producer = "B3MLTIS102" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FTIS"       wdetail.campaign_ov = "RENEW". 
        ELSE IF wdetail.producer = "B3MLTIS102"                          THEN ASSIGN wdetail.financecd = "FTIS"       wdetail.campaign_ov = "TRANSF".
        ELSE IF wdetail.producer = "B3MLTIS103" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FTIS"       wdetail.campaign_ov = "RENEW".   
        ELSE IF wdetail.producer = "B3MLTIS103"                          THEN ASSIGN wdetail.financecd = "FTIS"       wdetail.campaign_ov = "TRANSF".
        ELSE IF wdetail.producer = "B3MLTIS104" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FTIS"       wdetail.campaign_ov = "RENEW".  
        ELSE IF wdetail.producer = "B3MLTIS104"                          THEN ASSIGN wdetail.financecd = "FTIS"       wdetail.campaign_ov = "TRANSF".
        ELSE IF wdetail.producer = "B3MLTIS201" AND wdetail.prepol = ""  THEN ASSIGN wdetail.financecd = "FTISCO"     wdetail.campaign_ov = "REDPLATE".     
        ELSE IF wdetail.producer = "B3MLTIS202" AND wdetail.prepol = ""  THEN ASSIGN wdetail.financecd = "FTISCO"     wdetail.campaign_ov = "BTREDPLATE".   
        ELSE IF wdetail.producer = "B3MLTIS202" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FTISCO"     wdetail.campaign_ov = "BTRENEW".
        ELSE IF wdetail.producer = "B3MLTIS203" AND wdetail.prepol = ""  THEN ASSIGN wdetail.financecd = "FTISCO"     wdetail.campaign_ov = "BBREDPLATE".
        ELSE IF wdetail.producer = "B3MLTIS203"                          THEN ASSIGN wdetail.financecd = "FTISCO"     wdetail.campaign_ov = "BBRENEW".      
        ELSE IF wdetail.producer = "B3MLTIS204" AND wdetail.prepol = ""  THEN ASSIGN wdetail.financecd = "FTISCO"     wdetail.campaign_ov = "ISREDPLATE". 
        ELSE IF wdetail.producer = "B3MLTIS301" AND wdetail.prepol = ""  THEN ASSIGN wdetail.financecd = "FHIWAY"     wdetail.campaign_ov = "REDPLATE".     
        ELSE IF wdetail.producer = "B3MLTIS301"                          THEN ASSIGN wdetail.financecd = "FHIWAY"     wdetail.campaign_ov = "RENEW". 
        IF      wdetail.agent =   "B3M0035" then  wdetail.agent =   "B3MLTIS100" . 
        ELSE IF wdetail.agent =   "B3M0002" then  wdetail.agent =   "B3MLTIS200" . 
        ELSE IF wdetail.agent =   "B3M0054" then  wdetail.agent =   "B3MLTIS300" .   
        RUN proc_susspect.
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        /*Add by Kridtiya i. A63-0472*/
        RUN proc_chkpolpremium . /*A67-0185*/
        RUN proc_72new.   /*A57-0017*/
        RUN proc_policy. 
        RUN proc_colorcode  . /*A65-0356*/ 
        RUN proc_722.
        RUN proc_723 (INPUT  s_recid1,       
                      INPUT  s_recid2,
                      INPUT  s_recid3,
                      INPUT  s_recid4,
                      INPUT-OUTPUT nv_message).
        NEXT.
    END.
    /*ELSE DO:    /* v70 */
        IF wdetail.prepol <> "" THEN RUN proc_renew.
        RUN proc_chktest0.
    END.
    RUN proc_policy . 
    RUN proc_chktest2.      
    RUN proc_chktest3.      
    RUN proc_chktest4. 
    */
END.     /*for each*/
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
/* comment by a60-0095...................
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
        sic_bran.uwm130.bchyr = nv_batchyr        /* batch Year */
        sic_bran.uwm130.bchno = nv_batchno        /* bchno      */
        sic_bran.uwm130.bchcnt  = nv_batcnt       /* bchcnt     */
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
    IF wdetail.covcod = "3"  THEN 
        ASSIGN sic_bran.uwm130.uom1_v =  deci(wdetail.tp1)  
            sic_bran.uwm130.uom2_v   =   deci(wdetail.tp2)  
            sic_bran.uwm130.uom5_v   =   deci(wdetail.tp3)  
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
        stat.clastab_fil.covcod  = wdetail.covcod No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do: 
        IF wdetail.prempa = "z" OR wdetail.prepol <> "" THEN
        Assign 
            sic_bran.uwm130.uom1_v     =  deci(wdetail.tp1)     /*stat.clastab_fil.uom1_si   1000000  */  
            sic_bran.uwm130.uom2_v     =  deci(wdetail.tp2)     /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     =  deci(wdetail.tp3)     /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  =  deci(wdetail.tp1)     /*deci(wdetail.tp_bi)   */ 
            nv_uom2_v                  =  deci(wdetail.tp2)     /*deci(wdetail.tp_bi2) */  
            nv_uom5_v                  =  deci(wdetail.tp3).     /*deci(wdetail.tp_bi3) */  
        ELSE 
            Assign  sic_bran.uwm130.uom1_v =  stat.clastab_fil.uom1_si   
                sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si  
                sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si
                nv_uom1_v                  =  stat.clastab_fil.uom1_si        /*deci(wdetail.tp_bi)   */ 
                nv_uom2_v                  =  stat.clastab_fil.uom2_si        /*deci(wdetail.tp_bi2) */  
                nv_uom5_v                  =  stat.clastab_fil.uom5_si  .     /*deci(wdetail.tp_bi3) */  
        ASSIGN 
            wdetail.deductpd           =  string(sic_bran.uwm130.uom5_v)
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            wdetail.comper             =  string(stat.clastab_fil.uom8_si)                
            wdetail.comacc             =  string(stat.clastab_fil.uom9_si)
            /*nv_uom1_v                  =  sic_bran.uwm130.uom1_v 
            nv_uom2_v                  =  sic_bran.uwm130.uom2_v
            nv_uom5_v                  =  sic_bran.uwm130.uom5_v  */    
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".
        If  wdetail.garage  =  ""  Then
            Assign nv_41      =   stat.clastab_fil.si_41unp
                   nv_42      =   stat.clastab_fil.si_42
                   nv_43      =   stat.clastab_fil.si_43
                   nv_seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
        Else If  wdetail.garage  =  "G"  Then
            Assign nv_41       =  stat.clastab_fil.si_41pai
                   nv_42       =  stat.clastab_fil.si_42
                   nv_43       =  stat.clastab_fil.impsi_43
                   nv_seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.             
    END.           
    ASSIGN  nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                         nv_riskno,
                         nv_itemno).
    END.  /* end Do transaction*/
    s_recid3  = RECID(sic_bran.uwm130).
    nv_covcod =   wdetail.covcod.
    
    ASSIGN
    nv_makdes  =  wdetail.brand
    nv_moddes  =  wdetail.model
    nv_newsck  = " ".
    IF  wdetail.seat41 = 0 THEN  wdetail.seat41 = wdetail.seat. 
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
         ASSIGN sic_bran.uwm301.policy = sic_bran.uwm120.policy                 
             sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
             sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
             sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
             sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
             sic_bran.uwm301.itemno    = s_itemno
             sic_bran.uwm301.tariff    = wdetail.tariff    
             sic_bran.uwm301.covcod    = nv_covcod
             /*sic_bran.uwm301.cha_no   = wdetail.chasno        /*A56-0323*/
             sic_bran.uwm301.trareg   = nv_uwm301trareg*/       /*A56-0323*/
             sic_bran.uwm301.cha_no   = trim(nv_uwm301trareg)   /*A56-0323*/
             sic_bran.uwm301.trareg   = trim(nv_uwm301trareg)   /*A56-0323*/
             sic_bran.uwm301.eng_no    = wdetail.eng
             sic_bran.uwm301.Tons      = DECI(wdetail.tonss)
             sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
             sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
             sic_bran.uwm301.garage    = wdetail.garage
             sic_bran.uwm301.body      = wdetail.body
             sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
             sic_bran.uwm301.mv_ben83  = wdetail.benname
             sic_bran.uwm301.vehreg    = wdetail.vehreg 
             sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
             sic_bran.uwm301.vehuse    = wdetail.vehuse
             sic_bran.uwm301.modcod    = wdetail.redbook
             sic_bran.uwm301.vehgrp    = wdetail.cargrp
             sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
             sic_bran.uwm301.sckno     = 0
             sic_bran.uwm301.itmdel    = NO.
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
         ASSIGN  sic_bran.uwm301.bchyr = nv_batchyr   /* batch Year */
                 sic_bran.uwm301.bchno = nv_batchno       /* bchno      */
                 sic_bran.uwm301.bchcnt  = nv_batcnt .    /* bchcnt     */
         IF (wdetail.prepol <> "") AND (wdetail.poltyp = "v70") THEN 
         RUN proc_mailtxt.
         s_recid4         = RECID(sic_bran.uwm301).
         IF wdetail.seat = 16 THEN wdetail.seat = 12.
         /*IF wdetail.redbook <> ""  /*AND chkred = YES*/  THEN DO:
             FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass      AND
                 stat.maktab_fil.modcod = wdetail.redbook
                 No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN
                     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                     wdetail.cargrp          =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.Tons    =  stat.maktab_fil.tons 
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.engine  =  stat.maktab_fil.eng
                     nv_engine   =  stat.maktab_fil.eng.
         END.
         ELSE DO:*/
         IF wdetail.redbook = "" THEN DO:
             Find First stat.maktab_fil Use-index      maktab04          Where
                 stat.maktab_fil.makdes   =     nv_makdes                And                  
                 index(stat.maktab_fil.moddes,nv_moddes) <> 0            And
                 stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
                 stat.maktab_fil.engine   <=     Integer(wdetail.engcc)    AND
                 stat.maktab_fil.sclass   =     wdetail.subclass         AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) AND
                 stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
                 No-lock no-error no-wait.
             If  avail stat.maktab_fil  Then 
                 Assign
                     wdetail.redbook         =  stat.maktab_fil.modcod
                     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                     wdetail.cargrp          =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.Tons    =  stat.maktab_fil.tons 
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.engine  =  stat.maktab_fil.eng
                     nv_engine               =  stat.maktab_fil.eng.
         END.
         IF wdetail.redbook  = ""  THEN RUN proc_maktab2.
         IF wdetail.redbook  = ""  THEN DO: 
             ASSIGN chkred = YES.
             RUN proc_model_brand.
             RUN proc_maktab2.
         END.
..........end a60-0095...........*/
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
/* comment by A60-0095..............
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN  nv_tariff = sic_bran.uwm301.tariff             
    nv_class  = wdetail.prempa + wdetail.subclass
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = DECI(wdetail.engcc)    /*A55-0184 */
    /*nv_tons   = deci(wdetail.weight)*/
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse                     
    nv_COMPER = deci(wdetail.comper)               
    nv_comacc = deci(wdetail.comacc)               
    nv_seats  = INTE(wdetail.seat)                 
    nv_tons   = DECI(wdetail.tonss)              
    /*nv_dss_per = 0  */                           
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
    /*nv_ncb     =   0*/                                  
    nv_totsi   =  0 .                              
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
        sic_bran.uwm301.mv41seat = wdetail.seat41.
  
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).
..........end a60-0095................*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_colorcode c-Win 
PROCEDURE proc_colorcode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR np_colorcode AS CHAR INIT "".
np_colorcode = "".
IF wdetail.colorcode <> "" THEN DO:
        FIND LAST sicsyac.sym100 USE-INDEX sym10001 WHERE 
            sym100.tabcod = "U118"  AND 
            sym100.itmcod = trim(wdetail.colorcode)  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
        ELSE DO:
            FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                sym100.tabcod = "U118"  AND 
                sym100.itmdes = trim(wdetail.colorcode) 
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
            ELSE DO:
                FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                    sym100.tabcod = "U118"  AND 
                    index(sym100.itmdes,trim(wdetail.colorcode)) <> 0  
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                ELSE DO:
                    FIND LAST sicsyac.sym100 USE-INDEX sym10001 WHERE 
                        sym100.tabcod = "U119"  AND 
                        sym100.itmcod = trim(wdetail.colorcode)  NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                    ELSE DO:
                        FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                            sym100.tabcod = "U119"  AND 
                            sym100.itmdes = trim(wdetail.colorcode)  
                            NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                        ELSE DO:
                            FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                                sym100.tabcod = "U119"  AND 
                                index(sym100.itmdes,trim(wdetail.colorcode)) <> 0  
                                NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                        END.
                    END.
                END.
            END.
        END.
END.
wdetail.colorcode = np_colorcode.

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
       sic_bran.uwm100.rencnt =  n_rencnt             
       sic_bran.uwm100.renno  =  ""
       sic_bran.uwm100.endcnt =  n_endcnt
       sic_bran.uwm100.bchyr  = nv_batchyr 
       sic_bran.uwm100.bchno  = nv_batchno 
       sic_bran.uwm100.bchcnt = nv_batcnt     .


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
/* comment by : A67-0185...
FOR EACH wcomp.
    DELETE wcomp.
END.
CREATE wcomp. 
ASSIGN wcomp.package   = "110"  
       wcomp.premcomp  =  645.21
       wcomp.ev        = "N" . /* A67-0114*/
CREATE wcomp. 
ASSIGN wcomp.package   = "140A" 
       wcomp.premcomp  =  967.28 
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "140B" 
       wcomp.premcomp  = 1310.75
       wcomp.ev        = "N" . /* A67-0114 */ 
CREATE wcomp. 
ASSIGN wcomp.package   = "140C" 
       wcomp.premcomp  = 1408.12
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "140D" 
       wcomp.premcomp  = 1826.49
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "120A" 
       wcomp.premcomp  = 1182.35 
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "120B" 
       wcomp.premcomp  = 2203.13 
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "120C" 
       wcomp.premcomp  = 3437.91 
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "120D" 
       wcomp.premcomp  = 4017.85 
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "210" 
       wcomp.premcomp  = 2041.56 
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "240A" 
       wcomp.premcomp  = 1891.76 
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "240B" 
       wcomp.premcomp  = 1966.66 
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "240C" 
       wcomp.premcomp  = 2127.16 
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "240D" 
       wcomp.premcomp  = 2718.87
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "150" 
       wcomp.premcomp  = 2546.60 
       wcomp.ev        = "N" . /* A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "250" 
       wcomp.premcomp  = 3395.11
       wcomp.ev        = "N" . /* A67-0114 */
/* add by : A67-0114 */
CREATE wcomp. 
ASSIGN wcomp.package   = "E11"      /*"110E"  A67-0185 */ 
       wcomp.premcomp  =  645.21
       wcomp.ev        = "Y" .
CREATE wcomp. 
ASSIGN wcomp.package   = "E12"    /*"210E"  A67-0185 */
       wcomp.premcomp  = 2041.56 
       wcomp.ev        = "Y" . 
/* end : A67-0114 */
/* add by : A67-0185 */
/* รถยนต์นั่งเกิน 7 คน */
CREATE wcomp.           
ASSIGN wcomp.package   = "E21A"  
       wcomp.premcomp  = 1182.35  
       wcomp.ev        = "Y" . 
CREATE wcomp.           
ASSIGN wcomp.package   = "E21B"  
       wcomp.premcomp  = 2203.13 
       wcomp.ev        = "Y" .
CREATE wcomp.           
ASSIGN wcomp.package   = "E21C"  
       wcomp.premcomp  = 3437.91   
       wcomp.ev        = "Y" .
CREATE wcomp.           
ASSIGN wcomp.package   = "E21D"     
       wcomp.premcomp  = 4017.85 
       wcomp.ev        = "Y" .
CREATE wcomp.           
ASSIGN wcomp.package   = "E22A"     
       wcomp.premcomp  = 2493.10 
       wcomp.ev        = "Y".
CREATE wcomp.           
ASSIGN wcomp.package   = "E22B"  
       wcomp.premcomp  = 3738.58  
       wcomp.ev        = "Y".
CREATE wcomp.           
ASSIGN wcomp.package   = "E22C"  
       wcomp.premcomp  = 7155.09 
       wcomp.ev        = "Y".
CREATE wcomp.           
ASSIGN wcomp.package   = "E22D"  
       wcomp.premcomp  = 8079.57 
       wcomp.ev        = "Y".
/* รถยนต์บรรทุก */
CREATE wcomp.           
ASSIGN wcomp.package   = "E32A"  
       wcomp.premcomp  = 967.28 
       wcomp.ev        = "Y" .
CREATE wcomp.            
ASSIGN wcomp.package   = "E32B"  
       wcomp.premcomp  = 1310.75  
       wcomp.ev        = "Y" .
CREATE wcomp.            
ASSIGN wcomp.package   = "E32C"  
       wcomp.premcomp  = 1408.12  
       wcomp.ev        = "Y" .
CREATE wcomp.            
ASSIGN wcomp.package   = "E32D"  
       wcomp.premcomp  = 1826.49
       wcomp.ev        = "Y" .
CREATE wcomp.            
ASSIGN wcomp.package   = "E32A"  
       wcomp.premcomp  = 1891.76 
       wcomp.ev        = "Y" .
CREATE wcomp.            
ASSIGN wcomp.package   = "E32B"  
       wcomp.premcomp  = 1966.66 
       wcomp.ev        = "Y" .
CREATE wcomp.            
ASSIGN wcomp.package   = "E32C"  
       wcomp.premcomp  = 2127.16 
       wcomp.ev        = "Y" .
CREATE wcomp.            
ASSIGN wcomp.package   = "E32D"  
       wcomp.premcomp  = 2718.87 
       wcomp.ev        = "Y".
... end : A67-0185 */

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
/* comment by a60-0095..................
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
nv_c = wdetail.policyno.
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
    wdetail.policyno  = nv_c 
    wdetail2.policyno = nv_c.
    
..........end a60-0095...............*/

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
/* comment by a60-0095............
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
    ind = INDEX(nv_c,"*").
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
    wdetail.prepol  = nv_c .
.....end a60-0095.....*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_defintions c-Win 
PROCEDURE proc_defintions :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by a62-0386      
------------------------------------------------------------------------------*/
/*Modify by : Ranu I. A62-0386 date : 28/08/2019 แก้เงื่อนไขการเช็คงาน MPI   */
/*Modify by : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by : Ranu I. A64-0092 แก้ไขเบอร์กรมธรรม์ 72 ไม่เกิน 16 หลัก     */
/*Modify by : Kridtiya i. A65-0360 Date . 28/11/2022 ปรับส่วนการแสดงที่อยู่ ตำบล อำเภอ จังหวัด*/
/*Modify by : Kridtiya i. A65-0356 Date. 07/01/2023 ขยายช่อง เลขเครื่องเลขถัง ทะเบียน สี */
/*Modify by : Kridtiya i. A66-0160 Date. 15/08/2023 assing campaign = producer           */  
/*Modify by : Kridtiya i. A67-0036 add hyundai */
/*Modify by : Ranu I. A67-0114 แก้ไข Format file Load เพิ่มการรับค่าข้อมูลรถไฟฟ้า */
   /*Modiby by  : Ranu I. A67-0185 แก้ไข Class EV ของ พรบ. /ตรวจสอบข้อมูลการออกกรมธรรม์ในระบบพรีเมียม โดยการเช็คเลขตัวถังในระบบพรีเมียม */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insaddr c-Win 
PROCEDURE proc_insaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
     FIND sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
          sicsyac.xmm600.acno  =  nv_insref   NO-ERROR NO-WAIT.  
        IF AVAIL sicsyac.xmm600 THEN DO:
            ASSIGN 
               wdetail.tiname     = TRIM(sicsyac.xmm600.ntitle)    
               wdetail.insnam     = TRIM(sicsyac.xmm600.name)      
               wdetail.firstName  = TRIM(sicsyac.xmm600.firstname) 
               wdetail.lastName   = TRIM(sicsyac.xmm600.lastName)  
               wdetail.name_insur = TRIM(sicsyac.xmm600.icno)      
               wdetail.addr1      = TRIM(sicsyac.xmm600.addr1)              /*Address line 1*/
               wdetail.tambon     = TRIM(sicsyac.xmm600.addr2)               /*Address line 2*/
               wdetail.amper      = TRIM(sicsyac.xmm600.addr3)              /*Address line 3*/
               wdetail.country    = TRIM(sicsyac.xmm600.addr4)     
               wdetail.postcd     = trim(sicsyac.xmm600.postcd)    
               wdetail.codeaddr1  = TRIM(sicsyac.xmm600.codeaddr1) 
               wdetail.codeaddr2  = TRIM(sicsyac.xmm600.codeaddr2) 
               wdetail.codeaddr3  = trim(sicsyac.xmm600.codeaddr3). 
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
    n_insref    = ""  
    nv_usrid    = ""
    nv_transfer = NO
    n_check     = ""
    nv_insref   = ""
    /*putchr      = "" */
    /* putchr1     = ""*/
    nv_typ      = ""
    nv_usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4) 
    nv_transfer = YES.
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME   = TRIM(wdetail.insnam)  AND 
    sicsyac.xmm600.homebr = TRIM(wdetail.branch)  AND
    sicsyac.xmm600.addr1  = TRIM(wdetail.addr1)   AND   /*Address line 1*/
    sicsyac.xmm600.addr2  = TRIM(wdetail.tambon)  AND   /*Address line 2*/
    sicsyac.xmm600.addr3  = TRIM(wdetail.amper)   AND   /*Address line 3*/
    sicsyac.xmm600.addr4  = TRIM(wdetail.country) AND
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
            ELSE nv_typ = "0s".    /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/
        END. 
        ELSE DO:       /* ---- Check ด้วย name ---- */
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
        IF nv_insref <> "" THEN CREATE sicsyac.xmm600.  /* A55-0325 */
    END.
    n_insref = nv_insref.

    
END.
ELSE DO:
    IF sicsyac.xmm600.acno <> "" THEN  /* A55-0325 */
        ASSIGN
        nv_insref               = sicsyac.xmm600.acno 
        n_insref                = nv_insref 
        nv_transfer             = NO 
        sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                        /*First Name*/
        sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
        sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
        sicsyac.xmm600.icno     = TRIM(wdetail.name_insur)  /*IC No.*//*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.addr1)       /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.tambon)       /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.amper)       /*Address line 3*/
        sicsyac.xmm600.addr4    = TRIM(wdetail.country)       
        sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
        sicsyac.xmm600.opened   = TODAY                     
        sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid .
        /*sicsyac.xmm600.dtyp20   = "DOB"
        sicsyac.xmm600.dval20   = trim(wdetail.brithday)*/        /*-- Add chutikarn A50-0072 --*/
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
        sicsyac.xmm600.icno     = TRIM(wdetail.name_insur)              /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.addr1)               /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.tambon)               /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.amper)               /*Address line 3*/
        sicsyac.xmm600.addr4    = TRIM(wdetail.country)               /*Address line 4*/
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
        sicsyac.xmm600.dtyp20 = ""
        sicsyac.xmm600.dval20 = "".
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
        sicsyac.xmm600.dval20 =  wdetail.brithday*/         /*string(wdetail.brithday).*/
END.
IF sicsyac.xmm600.acno <> ""  THEN DO:
    ASSIGN nv_insref = sicsyac.xmm600.acno.
    nv_transfer = YES.
    FIND sicsyac.xtm600 WHERE
        sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
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
            sicsyac.xtm600.addr1   = TRIM(wdetail.addr1)     /*address line 1*/
            sicsyac.xtm600.addr2   = TRIM(wdetail.tambon)    /*address line 2*/
            sicsyac.xtm600.addr3   = TRIM(wdetail.amper)     /*address line 3*/
            sicsyac.xtm600.addr4   = TRIM(wdetail.country)   /*address line 4*/
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
/*Add by Kridtiya i. A63-0472*/
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno     =  nv_insref   NO-ERROR NO-WAIT.  
IF AVAIL sicsyac.xmm600 THEN
    ASSIGN
    sicsyac.xmm600.acno_typ  = trim(wdetail.insnamtyp)   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    /*sicsyac.xmm600.icno      = trim(wdetail.icno)  */     
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured) .   /*A66/0160*/
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN
    ASSIGN 
    sicsyac.xtm600.postcd    =  trim(wdetail.postcd)       
    sicsyac.xtm600.firstname =  trim(wdetail.firstName)    
    sicsyac.xtm600.lastname  =  trim(wdetail.lastName) .   
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
DEF VAR nv_lastno  AS INT. 
DEF VAR nv_seqno   AS INT.  
ASSIGN nv_insref = "" .
FIND LAST sicsyac.xzm056 USE-INDEX xzm05601       WHERE 
    sicsyac.xzm056.seqtyp   =  nv_typ             AND
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
            /*comment by Kridtiya i. A56-0323....
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + wdetail.branch + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       wdetail.branch + STRING(sicsyac.xzm056.lastno + 1 ,"999999").
             end...comment by Kridtiya i. A56-0323....*/
            /*add by Kridtiya i. A56-0323....*/
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
                ELSE nv_insref =       TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END. 
            /*add by Kridtiya i. A56-0323....*/
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
            /*/*kridtiya i. A56-0323*/
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + wdetail.branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       wdetail.branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").*//*kridtiya i. A56-0323*/
            /*kridtiya i. A56-0323*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (wdetail.branch = "A") OR (wdetail.branch = "B") THEN DO:
                     nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref = "0" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
            END.
            ELSE DO:
                IF (wdetail.branch = "A") OR (wdetail.branch = "B") THEN DO:
                     nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref =       wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
            END.
            /*kridtiya i. A56-0323*/
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
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       wdetail.branch + STRING(sicsyac.xzm056.lastno,"999999").*/
            /*add by Kridtiya i. A56-0323....*/
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
                ELSE nv_insref =       TRIM(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.   
            /*add by Kridtiya i. A56-0323....*/
        END.
    END.
    ELSE DO:
        IF LENGTH(wdetail.branch) = 2 THEN
            nv_insref = wdetail.branch + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.branch + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       wdetail.branch + "C" + String(sicsyac.xzm056.lastno,"99999").*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (wdetail.branch = "A") OR (wdetail.branch = "B") THEN DO:
                     nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref = "0" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
            END.
            ELSE DO:
                IF (wdetail.branch = "A") OR (wdetail.branch = "B") THEN DO:
                     nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref =       wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
            END.
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
/* comment by a60-0095...........
DEFINE        VAR nv_policy  AS CHAR  FORMAT "X(16)".
DEFINE        VAR nv_rencnt  AS INT   FORMAT ">>9".
DEFINE        VAR nv_endcnt  AS INT   FORMAT ">>9".
DEFINE        VAR nv_riskgp  AS INT   FORMAT "9".
DEFINE        VAR nv_riskno  AS INT   FORMAT ">>9".
DEFINE        VAR nv_itemno  AS INT   FORMAT ">>9".
DEFINE        VAR nv_title   AS CHAR  FORMAT "X(70)".
DEFINE        VAR nv_chkpol  AS CHAR  FORMAT "X(30)" INITIAL "" NO-UNDO.
DEFINE        VAR nv_lnumber AS INT                             NO-UNDO.
DEFINE        VAR nv_name1   AS CHAR  FORMAT "X(30)".
DEFINE        VAR nv_name2   AS CHAR  FORMAT "X(30)".
DEFINE        VAR nv_sex1    AS CHAR  FORMAT "X(6)".
DEFINE        VAR nv_sex2    AS CHAR  FORMAT "X(6)".
DEFINE        VAR nv_age1    AS CHAR  FORMAT "X(2)".
DEFINE        VAR nv_age2    AS CHAR  FORMAT "X(2)".
DEFINE        VAR nv_birdat1 AS DATE  FORMAT "99/99/9999".
DEFINE        VAR nv_birdat2 AS DATE  FORMAT "99/99/9999".
DEFINE        VAR nv_occup1  AS CHAR  FORMAT "X(15)".
DEFINE        VAR nv_occup2  AS CHAR  FORMAT "X(15)".  
ASSIGN wdetail.drivnam   = "n"
       nv_drivno = 0.
FIND LAST sicuw.uwm130 WHERE 
    sicuw.uwm130.policy  =  wdetail.prepol  NO-LOCK.
IF AVAIL sicuw.uwm130 THEN DO:
   ASSIGN
      nv_policy = sicuw.uwm130.policy
      nv_rencnt = sicuw.uwm130.rencnt
      nv_endcnt = sicuw.uwm130.endcnt
      nv_riskgp = sicuw.uwm130.riskgp
      nv_riskno = sicuw.uwm130.riskno
      nv_itemno = sicuw.uwm130.itemno
      nv_chkpol  = TRIM(nv_policy) + STRING(nv_rencnt,"99")
                   + STRING(nv_endcnt,"999")
                   + STRING(nv_riskno,"999") + STRING(nv_itemno,"999").    
      nv_lnumber = 1.                                                      
      FIND FIRST stat.mailtxt_fil USE-INDEX mailtxt01  WHERE               
                 stat.mailtxt_fil.policy  = nv_chkpol  AND                      
                 stat.mailtxt_fil.lnumber = nv_lnumber NO-ERROR NO-WAIT.
      IF AVAILABLE stat.mailtxt_fil THEN DO:
          FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
              brstat.mailtxt_fil.policy  = wdetail.policyno + string(n_rencnt,"99")  + string(n_endcnt,"999") +  "001" + "001"     AND
              brstat.mailtxt_fil.lnumber = nv_lnumber    AND
              brstat.mailtxt_fil.bchyr   = nv_batchyr    AND                                               
              brstat.mailtxt_fil.bchno   = nv_batchno    AND
              brstat.mailtxt_fil.bchcnt  = nv_batcnt     NO-LOCK  NO-ERROR  NO-WAIT.
          IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
              CREATE brstat.mailtxt_fil.
              ASSIGN 
                  wdetail.drivnam          = "y"
              brstat.mailtxt_fil.policy    = wdetail.policyno + string(n_rencnt,"99")  + string(n_endcnt,"999") +  "001" + "001" 
              brstat.mailtxt_fil.lnumber   = nv_lnumber
              brstat.mailtxt_fil.ltext     = stat.mailtxt_fil.ltext
              brstat.mailtxt_fil.ltext2    = stat.mailtxt_fil.ltext2
              nv_drivage1                  = deci(SUBSTRING(stat.mailtxt_fil.ltext2,13,2))
              brstat.mailtxt_fil.bchyr     = nv_batchyr 
              brstat.mailtxt_fil.bchno     = nv_batchno 
              brstat.mailtxt_fil.bchcnt    = nv_batcnt 
                  nv_drivno                    = 1.
          END.
          FIND NEXT stat.mailtxt_fil USE-INDEX mailtxt01   WHERE
                    stat.mailtxt_fil.policy  = nv_chkpol   NO-ERROR NO-WAIT.
           IF AVAIL stat.mailtxt_fil THEN DO:
               CREATE brstat.mailtxt_fil. 
               ASSIGN
                   brstat.mailtxt_fil.policy   = wdetail.policyno + string(n_rencnt,"99")  + string(n_endcnt,"999") +  "001" + "001"
                   brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                   brstat.mailtxt_fil.ltext    = stat.mailtxt_fil.ltext
                   brstat.mailtxt_fil.ltext2   = stat.mailtxt_fil.ltext2
                   nv_drivage2                 = deci(SUBSTRING(stat.mailtxt_fil.ltext2,13,2))
                   brstat.mailtxt_fil.bchyr    = nv_batchyr 
                   brstat.mailtxt_fil.bchno    = nv_batchno 
                   brstat.mailtxt_fil.bchcnt   = nv_batcnt 
                   nv_drivno                    = 2.
           END.
      END.
END.
.......end a60-0095..*/
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
IF wdetail.model = "commuter" THEN wdetail.seat = 12.
IF (wdetail.si = "") OR (wdetail.si = "0.00") OR (wdetail.si = "0" ) THEN DO:
    Find LAST stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =    wdetail.brand              And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0            And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
        /*(stat.maktab_fil.si - (stat.maktab_fil.si * 30 / 100 ) LE deci(wdetail.si)   AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * 30 / 100 ) GE deci(wdetail.si) ) AND*/
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook         =  stat.maktab_fil.modcod
        /*sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    A67-0114*/
        /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes A67-0114*/
        wdetail.cargrp          =  stat.maktab_fil.prmpac
       /* sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac  A67-0114 */
       /* sic_bran.uwm301.body    =  stat.maktab_fil.body    A67-0114 */
       /* sic_bran.uwm301.engine  =  stat.maktab_fil.engine  A67-0114 */
       /* A67-0114 */
        nv_modcod        =  stat.maktab_fil.modcod 
        wdetail.body     =  stat.maktab_fil.body  
        wdetail.brand    =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes  
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.weight   =  string(stat.maktab_fil.tons) 
        wdetail.engcc    =  STRING(stat.maktab_fil.engine) 
        wdetail.hp       =  string(stat.maktab_fil.watt)   
        wdetail.maksi    =  string(stat.maktab_fil.si ) 
        /* end A67-0114 */
        nv_engine        =  stat.maktab_fil.engine.
END.
ELSE DO:
    Find LAST stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =    wdetail.brand              And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0            And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * 30 / 100 ) LE deci(wdetail.si)   AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * 30 / 100 ) GE deci(wdetail.si) ) AND
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook        =  stat.maktab_fil.modcod
       /* sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                     A67-0114*/
       /* sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes  A67-0114*/
        wdetail.cargrp          =  stat.maktab_fil.prmpac
       /* sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac A67-0114*/
       /* sic_bran.uwm301.body    =  stat.maktab_fil.body   A67-0114*/
       /* sic_bran.uwm301.engine  =  stat.maktab_fil.engine A67-0114*/
        /* A67-0114 */
        nv_modcod        =  stat.maktab_fil.modcod 
        wdetail.body     =  stat.maktab_fil.body  
        wdetail.brand    =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes  
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.weight   =  string(stat.maktab_fil.tons) 
        wdetail.engcc    =  STRING(stat.maktab_fil.engine) 
        wdetail.hp       =  string(stat.maktab_fil.watt)   
        wdetail.maksi    =  string(stat.maktab_fil.si ) 
        /* end A67-0114 */
        nv_engine               =  stat.maktab_fil.engine.
END.
IF wdetail.model = "commuter" THEN wdetail.seat = 16.
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
/* comment by a60-0095..........
IF wdetail.model = "commuter" THEN wdetail.seat = 12.
IF (wdetail.si = "") OR (wdetail.si = "0.00") OR (wdetail.si = "0" ) THEN DO:
    Find LAST stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =    wdetail.brand              And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0            And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
        /*(stat.maktab_fil.si - (stat.maktab_fil.si * 30 / 100 ) LE deci(wdetail.si)   AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * 30 / 100 ) GE deci(wdetail.si) ) AND*/
        stat.maktab_fil.seats    =     wdetail.seat       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook        =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.engine  =  stat.maktab_fil.eng
        nv_engine               =  stat.maktab_fil.eng.
END.
ELSE DO:
    Find LAST stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =    wdetail.brand              And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0            And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * 30 / 100 ) LE deci(wdetail.si)   AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * 30 / 100 ) GE deci(wdetail.si) ) AND
        stat.maktab_fil.seats    =     wdetail.seat      
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook        =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.engine  =  stat.maktab_fil.eng
        nv_engine               =  stat.maktab_fil.eng.
END.
IF wdetail.model = "commuter" THEN wdetail.seat = 16.
......end a60-0095...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab72 c-Win 
PROCEDURE proc_maktab72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by a60-0095...........
IF wdetail.model = "commuter" THEN wdetail.seat = 12.
IF (wdetail.si = "") OR (wdetail.si = "0.00") OR (wdetail.si = "0" ) THEN DO:
    Find LAST stat.maktab_fil Use-index      maktab04           Where
        stat.maktab_fil.makdes   =    nv_makdes                 And                  
        index(stat.maktab_fil.moddes,nv_moddes) <> 0            And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
        stat.maktab_fil.sclass   =     wdetail.subclass         AND
        /*(stat.maktab_fil.si - (stat.maktab_fil.si * 30 / 100 ) LE deci(wdetail.si)   AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * 30 / 100 ) GE deci(wdetail.si) ) AND*/
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook         =  stat.maktab_fil.modcod
        wdetail.brand           =  stat.maktab_fil.makdes  
        wdetail.model           =  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        wdetail.body            =  stat.maktab_fil.body
        wdetail.ton             =  STRING(stat.maktab_fil.tons)
        wdetail.engcc           =  string(stat.maktab_fil.eng)
        nv_engine               =  stat.maktab_fil.eng.
END.
ELSE IF nv_moddes = "" THEN DO:

    Find LAST stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdes   =    nv_makdes              And 
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.sclass   =     wdetail.subclass        AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * 30 / 100 ) LE deci(wdetail.si)   AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * 30 / 100 ) GE deci(wdetail.si) ) AND
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook         =  stat.maktab_fil.modcod
        wdetail.brand           =  stat.maktab_fil.makdes  
        wdetail.model           =  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        wdetail.body            =  stat.maktab_fil.body
        wdetail.ton             =  STRING(stat.maktab_fil.tons)
        wdetail.engcc           =  string(stat.maktab_fil.eng)
        nv_engine               =  stat.maktab_fil.eng.
END.
IF wdetail.model = "commuter" THEN wdetail.seat = 16.
....... end a60-0095.....*/
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
DEFINE INPUT  PARAMETER  npp_title        as char init "".
DEFINE INPUT  PARAMETER  npp_flname       as char init "".
DEFINE OUTPUT PARAMETER  npp_insnamtyp    as char init "".
DEFINE OUTPUT PARAMETER  npp_firstname1   as char init "".
DEFINE OUTPUT PARAMETER  npp_lastname1    as char init "".
DEFINE VAR npp_textname  AS CHAR.
ASSIGN npp_textname = npp_title + npp_flname  .

IF  R-INDEX(TRIM(npp_textname),"จก.")             <> 0  OR              
    R-INDEX(TRIM(npp_textname),"จำกัด")           <> 0  OR  
    R-INDEX(TRIM(npp_textname),"(มหาชน)")         <> 0  OR  
    R-INDEX(TRIM(npp_textname),"INC.")            <> 0  OR 
    R-INDEX(TRIM(npp_textname),"CO.")             <> 0  OR 
    R-INDEX(TRIM(npp_textname),"LTD.")            <> 0  OR 
    R-INDEX(TRIM(npp_textname),"LIMITED")         <> 0  OR 
    INDEX(TRIM(npp_textname),"บริษัท")            <> 0  OR 
    INDEX(TRIM(npp_textname),"บ.")                <> 0  OR 
    INDEX(TRIM(npp_textname),"บจก.")              <> 0  OR 
    INDEX(TRIM(npp_textname),"หจก.")              <> 0  OR 
    INDEX(TRIM(npp_textname),"หสน.")              <> 0  OR 
    INDEX(TRIM(npp_textname),"บรรษัท")            <> 0  OR 
    INDEX(TRIM(npp_textname),"มูลนิธิ")           <> 0  OR 
    INDEX(TRIM(npp_textname),"ห้าง")              <> 0  OR 
    INDEX(TRIM(npp_textname),"ห้างหุ้นส่วน")      <> 0  OR 
    INDEX(TRIM(npp_textname),"ห้างหุ้นส่วนจำกัด") <> 0  OR
    INDEX(TRIM(npp_textname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
    INDEX(TRIM(npp_textname),"และ/หรือ")          <> 0  THEN DO: 
    /*  Cs = นิติบุคคล */
    ASSIGN
        npp_insnamtyp = "CO"
    npp_firstname1 = TRIM(npp_flname)
    npp_lastname1  = "".
     
END.
ELSE DO:
    npp_insnamtyp = "PR".
    IF INDEX(trim(npp_flname)," ") <> 0 THEN
        ASSIGN
        npp_firstname1 = substr(TRIM(npp_flname),1,INDEX(trim(npp_flname)," ")) 
        npp_lastname1  = substr(TRIM(npp_flname),INDEX(trim(npp_flname)," ")) .
    ELSE ASSIGN
        npp_firstname1 = TRIM(npp_flname)
        npp_lastname1  = "".

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_model_brand c-Win 
PROCEDURE proc_model_brand :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF chkred = NO THEN DO:
    ASSIGN   /*wdetail.model   = wdetail.brand */
        n_brand = wdetail.brand
        wdetail.brand = substr(n_brand,1,INDEX(n_brand," ") - 1)
        n_index = INDEX(n_brand," ") + 1
        n_model = substr(n_brand,n_index).
    IF INDEX(n_model," ") <> 0 THEN 
        n_model = substr(n_model,1,INDEX(n_model," ") - 1).
    /*wdetail.model  = n_model.*/
    IF index(wdetail.brand,"benz") <> 0 THEN wdetail.brand = "MERCEDES-BENZ".
    IF index(wdetail.model,"cab4") <> 0 THEN wdetail.model = "CAB".
END.
ELSE DO:
    IF index(wdetail.brand,"benz") <> 0 THEN wdetail.brand = "MERCEDES-BENZ". 
    ASSIGN 
    n_model = wdetail.model /*A60-0095*/
    n_index = INDEX(n_model," ") + 1
    n_model = substr(n_model,n_index,LENGTH(n_model))
    n_index = INDEX(n_model," ") - 1.
   /* IF n_index < 1  THEN wdetail.model  = substr(n_model,1,LENGTH(n_model)) .
    ELSE wdetail.model  = substr(n_model,1,n_index) .*/
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
DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER  INIT  0. 
DEF VAR nv_vatcode     AS CHAR FORMAT "x(10)" INIT "".  /*A57-0017  add vatcode */ 
ASSIGN nv_vatcode = "".          
IF wdetail.poltyp = "v72" THEN n_rencnt = 0.  
IF wdetail.policyno <> "" THEN DO:
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
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002    WHERE
        sicuw.uwm100.cedpol =  wdetail.Account_no AND 
        sicuw.uwm100.poltyp =  wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL sicuw.uwm100 THEN DO:
      IF ((sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ?) OR (sicuw.uwm100.releas = YES)) AND (sicuw.uwm100.expdat > date(wdetail.comdat)) THEN  
          ASSIGN wdetail.pass    = "N"
          wdetail.comment = wdetail.comment + "| เลขที่สัญญานี้ได้ถูกใช้ไปแล้ว "
          wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.
    nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
    ELSE wdetail.stk = wdetail.stk.
    FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
      stat.detaitem.serailno = wdetail.stk  NO-LOCK NO-ERROR.
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
  ELSE DO:  /*sticker = ""*/ 
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002    WHERE
      sicuw.uwm100.cedpol =  wdetail.Account_no AND 
      sicuw.uwm100.poltyp =  wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL sicuw.uwm100 THEN DO:
      IF (sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES ) AND (sicuw.uwm100.expdat > date(wdetail.comdat))     THEN 
          ASSIGN wdetail.pass    = "N"
          wdetail.comment = wdetail.comment + "| เลขที่สัญญานี้ได้ถูกใช้ไปแล้ว "
          wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
      IF wdetail.policyno = "" THEN DO:
          RUN proc_temppolicy.
          wdetail.policyno  = nv_tmppol.
      END.
      RUN proc_create100.
    END.
    ELSE RUN proc_create100. 
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
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002    WHERE
        sicuw.uwm100.cedpol =  wdetail.Account_no AND 
        sicuw.uwm100.poltyp =  wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL sicuw.uwm100 THEN DO:
      IF (sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES ) AND (sicuw.uwm100.expdat > date(wdetail.comdat))     THEN   
          ASSIGN wdetail.pass    = "N"
          wdetail.comment = wdetail.comment + "| เลขที่สัญญานี้ได้ถูกใช้ไปแล้ว "
          wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
    END.
    nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
    ELSE wdetail.stk = wdetail.stk.
    FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
        stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
    IF AVAIL stat.detaitem THEN ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
        wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
    IF wdetail.policyno = "" THEN DO:
        RUN proc_temppolicy.
        wdetail.policyno  = nv_tmppol.
    END.
    RUN proc_create100.
  END.  /*wdetail.stk  <>  ""*/
  ELSE DO:  /*policy = "" and comp_sck = ""  */       
      IF wdetail.policyno = "" THEN DO:
          RUN proc_temppolicy.
          wdetail.policyno  = nv_tmppol.
      END.
      RUN proc_create100.
  END.
END.
s_recid1  =  Recid(sic_bran.uwm100).
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = wdetail.poltyp  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL  sicsyac.xmm031 THEN  nv_dept = sicsyac.xmm031.dept.
IF wdetail.poltyp = "V70"  AND wdetail.Docno <> ""  THEN ASSIGN nv_docno  = wdetail.Docno
    nv_accdat = TODAY.
ELSE DO:
   IF wdetail.docno  = "" THEN nv_docno  = "".
   IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
IF (wdetail.prepol = "") OR (wdetail.poltyp = "V72")  THEN n_firstdat = wdetail.comdat.
/*comment by Kridtiya i. A56-0104...
IF index(wdetail.benname,"ทิสโก้") <> 0 THEN wdetail.benname = "ธนาคารทิสโก้ จำกัด (มหาชน)".
ELSE 
    ASSIGN 
        wdetail.producer = "A0M2008"
        wdetail.agent    = "B3M0002" 
        wdetail.benname   = "" .
end...comment by Kridtiya i. A56-0104...*/
IF wdetail.receipt_name = "" THEN ASSIGN nv_vatcode = "".  
ELSE DO:
  IF index(wdetail.receipt_name,"ทิสโก้") <> 0 THEN DO:
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
      stat.insure.compno = "TISCO" AND
      index(wdetail.receipt_name,stat.insure.fname) <> 0 NO-LOCK NO-WAIT NO-ERROR. 
    IF AVAIL stat.insure THEN ASSIGN nv_vatcode = trim(stat.insure.vatcode).
    ELSE nv_vatcode = "" .
  END.
  /*a61-0410*/
  ELSE DO:
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
      stat.insure.compno = "TISCO" AND
      index(trim(wdetail.renpol),stat.insure.lname) <> 0   NO-LOCK NO-WAIT NO-ERROR.   
    IF AVAIL stat.insure THEN ASSIGN nv_vatcode = trim(stat.insure.vatcode).
    ELSE nv_vatcode = "" .
  END.  /* end a61-0410*/
END.     /*add A57-0017  add vatcode */ 
IF wdetail.poltyp = "v72" THEN ASSIGN wdetail.benname = ""
    n_firstdat = wdetail.comdat. 
/*comment by Kridtiya i. A56-0323.....
IF wdetail.name_insur <> "" THEN DO:
    IF LENGTH(TRIM(wdetail.name_insur)) = 13 THEN DO:
        DO WHILE nv_seq <= 12:
            nv_sum = nv_sum + INTEGER(SUBSTR(TRIM(wdetail.name_insur),nv_seq,1)) * (14 - nv_seq).
            nv_seq = nv_seq + 1.
        END.
        nv_checkdigit = 11 - nv_sum MODULO 11.
        IF nv_checkdigit >= 10 THEN nv_checkdigit = nv_checkdigit - 10.
        IF STRING(nv_checkdigit) <> SUBSTR(TRIM(wdetail.name_insur),13,1) THEN  
            ASSIGN  wdetail.name_insur  = "".
    END.
    ELSE ASSIGN  wdetail.name_insur  = "".
    IF      trim(wdetail.branch) = ""  THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0268 ....*/
    ELSE IF trim(wdetail.branch) = "A" THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0268 ....*/
    ELSE IF trim(wdetail.branch) = "B" THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0268 ....*/
    ELSE RUN proc_insnam. 
END.  end....comment by Kridtiya i. A56-0323.....*/
/* create by A60-0405 */
IF LENGTH(wdetail.name_insur) < 13 THEN DO:
  ASSIGN  wdetail.pass    = "Y"
  wdetail.warning = "เลขบัตรประชาชนไม่ครบ 13 หลัก ".
END.
/* end A60-0405 */
 /*A67-0114*/
IF index(wdetail.insnam,"ฮุนได โมบิลิตี้") <> 0 THEN DO: 
    nv_insref = "MFC0013663" . 
    RUN proc_insaddr.
END.
ELSE IF index(wdetail.insnam,"ล็อตเต้ เรนท์-อะ-คาร์ (ไทยแลนด์)") <> 0 THEN DO: 
    nv_insref = "MLC0010760" . 
    RUN proc_insaddr.
END.
ELSE DO: /* end : A67-0114*/
    IF wdetail.name_insur <> "" THEN RUN proc_insnam.   /* Kridtiya i. A56-0323....*/
    RUN proc_insnam2 . /*Add by Kridtiya i. A63-0472*/
END. /*A67-0114*/
DO TRANSACTION:
  ASSIGN sic_bran.uwm100.renno  = ""
  sic_bran.uwm100.endno  = ""
  sic_bran.uwm100.poltyp = "V72"                       /*wdetail.poltyp*/
  sic_bran.uwm100.insref = trim(nv_insref) 
  sic_bran.uwm100.opnpol = ""
  sic_bran.uwm100.anam2  = trim(wdetail.name_insur)          /* ICNO  Cover Note A51-0071 Amparat */
  sic_bran.uwm100.ntitle = trim(wdetail.tiname)              
  sic_bran.uwm100.name1  = trim(wdetail.insnam)              /*+ " " + wdetail.name2  */            
  sic_bran.uwm100.name2  = trim(wdetail.receipt_name)        /*และ/หรือ */              
  sic_bran.uwm100.name3  = ""                          
  sic_bran.uwm100.addr1  = trim(wdetail.addr1)         
  sic_bran.uwm100.addr2  = trim(wdetail.tambon)        
  sic_bran.uwm100.addr3  = trim(wdetail.amper)         
  sic_bran.uwm100.addr4  = trim(wdetail.country)       
  sic_bran.uwm100.postcd = ""                          
  sic_bran.uwm100.undyr  = String(Year(today),"9999")  /*   nv_undyr  */
  sic_bran.uwm100.branch = caps(trim(wdetail.branch))        /* nv_branch  */                        
  sic_bran.uwm100.dept   = nv_dept                     
  sic_bran.uwm100.usrid  = USERID(LDBNAME(1))          
  /*sic_bran.uwm100.fstdat = TODAY                     /*TODAY */kridtiya i. a53-0171*/
  sic_bran.uwm100.fstdat = DATE(wdetail.comdat)        /*date(n_firstdat)*//*DATE(wdetail.comdat) kridtiya i. a53-0171 ให้ firstdate*/
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
  sic_bran.uwm100.prog   = "wgwtcg72"
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
  sic_bran.uwm100.acno1  = trim(wdetail.producer)  /*nv_acno1 */
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
  sic_bran.uwm100.drn_p =  NO
  sic_bran.uwm100.sch_p =  NO
  sic_bran.uwm100.cr_2  =  " "
  sic_bran.uwm100.bchyr   = nv_batchyr              /*Batch Year */  
  sic_bran.uwm100.bchno   = nv_batchno              /*Batch No.  */  
  sic_bran.uwm100.bchcnt  = nv_batcnt               /*Batch Count*/  
  sic_bran.uwm100.prvpol  = ""                      /*wdetail.prepol*/          
  sic_bran.uwm100.cedpol  = trim(wdetail.Account_no)      
  sic_bran.uwm100.finint  = trim(wdetail.cedpol)   /*-trim(wdetail.cedpol)-*/
  sic_bran.uwm100.bs_cd   = nv_vatcode      /*Vatcode*/
  sic_bran.uwm100.opnpol  = "" 
  sic_bran.uwm100.endern  = ?       /*วันที่รับเงิน*/
  sic_bran.uwm100.dealer     = wdetail.financecd           /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)     /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)      /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.postcd     = trim(wdetail.postcd)        /*Add by Kridtiya i. A63-0472*/ 
/*sic_bran.uwm100.icno       = trim(wdetail.icno)          /*Add by Kridtiya i. A63-0472*/ */
  sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)       /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)     /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)     /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)     /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.br_insured = trim(wdetail.br_insured)    /*Add by Kridtiya i. A66-0160*/
  /*sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov).  /*Add by Kridtiya i. A63-0472*/*/
  sic_bran.uwm100.campaign   = trim(wdetail.producer) .      /*A66-0160*/
  /* Create by : A61-0313 หา product กับ Promotion */
  /* IF wdetail.producer = "B3M0044" AND (index(wdetail.remark,"MPI") <> 0  OR SUBSTR(wdetail.prepol,7,2) = "MI" ) THEN DO:*/ /*A62-0386*/
  IF wdetail.producer = "A0M2012" AND (index(wdetail.remark,"MPI") <> 0  OR SUBSTR(wdetail.prepol,7,2) = "MI" ) THEN DO: /*A62-0386*/
    FIND LAST brstat.insure USE-INDEX insure03 WHERE 
      brstat.insure.compno  = "PRO_TIS"  AND  /*PRO_TIS*/
      brstat.insure.insno   = "PRO_TIS"  AND 
      trim(brstat.insure.icaddr2)  = TRIM(wdetail.producer)  NO-LOCK NO-ERROR .
    IF AVAIL brstat.insure THEN DO:
        ASSIGN sic_bran.uwm100.cr_1   = TRIM(brstat.insure.text1)      /*product*/  
            sic_bran.uwm100.opnpol = TRIM(brstat.insure.text2)  .    /*promo */ 
    END.
    ELSE ASSIGN sic_bran.uwm100.cr_1   = ""      /*product*/  
        sic_bran.uwm100.opnpol = "" .     /*promo */ 
  END.
  /* End A61-0313*/
  IF wdetail.prepol <> " " THEN DO:
      IF wdetail.poltyp = "v72"  THEN ASSIGN  sic_bran.uwm100.prvpol   = ""
          sic_bran.uwm100.tranty  = "R".  
      ELSE ASSIGN
          sic_bran.uwm100.prvpol  = wdetail.prepol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
          sic_bran.uwm100.tranty  = "R".               /*Transaction Type (N/R/E/C/T)*/
  END.
  IF wdetail.pass = "Y" THEN sic_bran.uwm100.impflg  = YES.
  ELSE sic_bran.uwm100.impflg  = NO.
  IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
  IF wdetail.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
  ELSE  sic_bran.uwm100.polsta = "IF".
  IF fi_loaddat <> ? THEN sic_bran.uwm100.trndat = fi_loaddat.
  ELSE sic_bran.uwm100.trndat = TODAY.
  sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
  nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                    (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                    (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
      ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.                    
END. /*transaction*//**/
RUN proc_uwd102.
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
    RUN wgw/wgwad120 (INPUT sic_bran.uwm100.policy,   /***--- A490166 Note Modi ---***/
                      sic_bran.uwm100.rencnt,
                      sic_bran.uwm100.endcnt,
                      s_riskgp,
                      s_riskno,
                      OUTPUT  s_recid2).
    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
END.    /* end not avail  uwm120 */
IF AVAILABLE sic_bran.uwm120 THEN DO:  
  ASSIGN sic_bran.uwm120.sicurr = "BHT"
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
  IF wdetail.poltyp = "v72" THEN ASSIGN   sic_bran.uwm120.class =   CAPS(TRIM(wdetail.subclass)) .  
  /*FIND FIRST  sicsyac.xzmcom USE-INDEX xzmcom01   WHERE
                sicsyac.xzmcom.class    = wdetail.prempa + wdetail.subclass  AND
                sicsyac.xzmcom.garage   = ""                                 AND
                sicsyac.xzmcom.var_amt  >= DECI(wdetail.tonss)               AND
                sicsyac.xzmcom.vehuse   = wdetail.vehuse     NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xzmcom  THEN
                ASSIGN   sic_bran.uwm120.class =  caps(trim(replace(sicsyac.xzmcom.comp_cod,".",""))).
            ELSE  ASSIGN   sic_bran.uwm120.class =   caps(wdetail.subclass) .
                /*DISPLAY  
              "class   "  sicsyac.xzmcom.class
              "garage  "  sicsyac.xzmcom.garage 
              "var_amt "  sicsyac.xzmcom.var_amt 
              "vehuse"  sicsyac.xzmcom.vehuse
              "comp_cod"  sicsyac.xzmcom.comp_cod    .*/
        END.*/
  ELSE ASSIGN sic_bran.uwm120.class = caps(wdetail.prempa + wdetail.subclass) .   /*v70  */
  ASSIGN s_recid2     = RECID(sic_bran.uwm120).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_redbook72 c-Win 
PROCEDURE proc_redbook72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A67-0114      
------------------------------------------------------------------------------*/
DEF VAR nv_makdes   as char init "" .
DEF VAR nv_moddes   as char init "" .
DEF VAR rm_modcod AS CHAR INIT "" .
DEFINE VAR nv_moddes1 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes2 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes3 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes4 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes5 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes6 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_count   AS INTE INIT 0.
DEFINE VAR rm_moddes  AS CHAR FORMAT "X(60)".
DO:
    ASSIGN nv_makdes = trim(wdetail.brand)
           nv_moddes = trim(wdetail.model) .

    IF nv_moddes <> " " THEN DO:
            IF INDEX(nv_moddes," ")  <> 0 THEN nv_moddes1 = TRIM(SUBSTR(nv_moddes,1,R-INDEX(nv_moddes," ") - 1)).
            IF INDEX(nv_moddes1," ") <> 0 THEN nv_moddes2 = TRIM(SUBSTR(nv_moddes1,1,R-INDEX(nv_moddes1," ") - 1)).
            IF INDEX(nv_moddes2," ") <> 0 THEN nv_moddes3 = TRIM(SUBSTR(nv_moddes2,1,R-INDEX(nv_moddes2," ") - 1)).
            IF INDEX(nv_moddes3," ") <> 0 THEN nv_moddes4 = TRIM(SUBSTR(nv_moddes3,1,R-INDEX(nv_moddes3," ") - 1)).
            IF INDEX(nv_moddes4," ") <> 0 THEN nv_moddes5 = TRIM(SUBSTR(nv_moddes4,1,R-INDEX(nv_moddes4," ") - 1)).
            IF INDEX(nv_moddes5," ") <> 0 THEN nv_moddes6 = TRIM(SUBSTR(nv_moddes5,1,R-INDEX(nv_moddes5," ") - 1)).
    END.
    rm_modcod = "".
    nv_count  = 0.
    rm_moddes = nv_moddes.

    loop_modcod:
    REPEAT:
        nv_count = nv_count + 1.

        IF nv_count  = 1 THEN DO: 
            IF nv_moddes <> "" THEN rm_moddes = TRIM(nv_moddes). 
        END.
        ELSE IF nv_count  = 2 THEN DO: 
            IF nv_moddes1 <> "" THEN rm_moddes = TRIM(nv_moddes1).
        END.
        ELSE IF nv_count  = 3 THEN DO: 
            IF nv_moddes2 <> "" THEN rm_moddes = TRIM(nv_moddes2).
        END.
        ELSE IF nv_count  = 4 THEN DO: 
            IF nv_moddes3 <> "" THEN rm_moddes = TRIM(nv_moddes3).
        END.
        ELSE IF nv_count  = 5 THEN DO: 
            IF nv_moddes4 <> "" THEN rm_moddes = TRIM(nv_moddes4).
        END.
        ELSE IF nv_count  = 6 THEN DO: 
            IF nv_moddes5 <> "" THEN rm_moddes = TRIM(nv_moddes5).
        END.
        ELSE IF nv_count  = 7 THEN DO: 
            IF nv_moddes6 <> "" THEN rm_moddes = TRIM(nv_moddes6).
        END.
        ELSE IF nv_count >= 8 THEN LEAVE loop_modcod.

        
        FIND FIRST sicsyac.xmm102 USE-INDEX xmm10202 WHERE 
              TRIM(xmm102.moddes) = trim(nv_makdes) + " " + trim(rm_moddes)  NO-LOCK NO-ERROR .
          IF AVAIL sicsyac.xmm102 THEN DO: 
            ASSIGN  rm_modcod = xmm102.modcod 
                    wdetail.redbook  = xmm102.modcod 
                    wdetail.body     = xmm102.body
                    wdetail.engcc    = IF wdetail.bev = "Y" THEN "0" ELSE STRING(xmm102.engine)
                    wdetail.hp       = IF wdetail.bev = "Y" THEN STRING(xmm102.engine) ELSE "0"
                    wdetail.cargrp   = xmm102.vehgrp .
             /* DISP " 1 " xmm102.modest
                   xmm102.modcod
                   xmm102.moddes skip
                   xmm102.body         skip
                   xmm102.engine       skip
                   xmm102.tons         skip
                   xmm102.seats        skip
                   xmm102.vehgrp       skip.*/
          END.
          ELSE DO:
              IF INTE(wdetail.engcc) = 0 AND INTE(wdetail.hp) = 0  THEN DO:
                Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   = trim(nv_makdes) And    /*A57-0431*/              
                index(stat.maktab_fil.moddes,trim(rm_moddes)) <> 0       AND    /*A57-0431*/
                stat.maktab_fil.makyea   =   INTE(wdetail.caryear) AND 
                stat.maktab_fil.sclass   =   n_sclass72   No-lock no-error no-wait.
                 If  avail stat.maktab_fil  THEN DO:
                  ASSIGN chkred    =  YES
                     rm_modcod        = stat.maktab_fil.modcod 
                     wdetail.redbook  =  stat.maktab_fil.modcod
                     wdetail.body     =  stat.maktab_fil.body  
                     wdetail.cargrp   =  stat.maktab_fil.prmpac
                     wdetail.weight   =  string(stat.maktab_fil.tons) 
                     wdetail.engcc    =  STRING(stat.maktab_fil.engine)  /*A67-0087*/
                     wdetail.hp       =  string(stat.maktab_fil.watt)     /*A67-0087*/
                     wdetail.maksi    =  string(stat.maktab_fil.si) .    /*A67-0087*/
                     IF wdetail.seat = 0 THEN wdetail.seat  =  stat.maktab_fil.seats .
                 END.
                /*
                DISP " 2 " 
                stat.maktab_fil.modcod         format "x(50)" skip
                stat.maktab_fil.body           format "x(50)" skip
                stat.maktab_fil.prmpac         format "x(50)" skip   
                string(stat.maktab_fil.tons)   format "x(50)" skip
                STRING(stat.maktab_fil.engine) format "x(50)" skip   
                string(stat.maktab_fil.watt)   format "x(50)" skip   .*/
              END.
              ELSE DO:
                  IF INTE(wdetail.engcc) <> 0 THEN DO:
                   Find First stat.maktab_fil USE-INDEX maktab04    Where
                   stat.maktab_fil.makdes   =   trim(nv_makdes)        And    /*A57-0431*/              
                   index(stat.maktab_fil.moddes,trim(rm_moddes)) <> 0  AND    /*A57-0431*/
                   stat.maktab_fil.makyea   =   INTE(wdetail.caryear)  AND   
                   stat.maktab_fil.engine  <=  Integer(wdetail.engcc) and 
                   stat.maktab_fil.sclass   =   n_sclass72             No-lock no-error no-wait.
                  END.
                  ELSE DO:
                      Find First stat.maktab_fil USE-INDEX maktab04    Where
                      stat.maktab_fil.makdes   =   trim(nv_makdes)        And    /*A57-0431*/              
                      index(stat.maktab_fil.moddes,trim(rm_moddes)) <> 0  AND    /*A57-0431*/
                      stat.maktab_fil.makyea   =   INTE(wdetail.caryear)  AND   
                      stat.maktab_fil.watt     <=  INTEGER(wdetail.hp)   and 
                      stat.maktab_fil.sclass   =   n_sclass72             No-lock no-error no-wait.

                  END.
                    If  avail stat.maktab_fil  THEN DO: 
                        ASSIGN chkred    =  YES
                        rm_modcod        = stat.maktab_fil.modcod 
                        wdetail.redbook  =  stat.maktab_fil.modcod
                        wdetail.body     =  stat.maktab_fil.body  
                        wdetail.cargrp   =  stat.maktab_fil.prmpac
                        wdetail.weight   =  string(stat.maktab_fil.tons) 
                        /*wdetail.engcc    =  STRING(stat.maktab_fil.engine)  /*A67-0087*/
                        wdetail.hp       =  string(stat.maktab_fil.watt) */    /*A67-0087*/
                        wdetail.maksi    =  string(stat.maktab_fil.si) .    /*A67-0087*/
                        IF wdetail.seat = 0 THEN wdetail.seat     =  stat.maktab_fil.seats .
                    END.
               /* DISP " 2 " 
                stat.maktab_fil.modcod         format "x(50)" skip
                stat.maktab_fil.body           format "x(50)" skip
                stat.maktab_fil.prmpac         format "x(50)" skip   
                string(stat.maktab_fil.tons)   format "x(50)" skip
                STRING(stat.maktab_fil.engine) format "x(50)" skip   
                string(stat.maktab_fil.watt)   format "x(50)" skip   .*/
              END.
              IF rm_modcod <> "" THEN LEAVE loop_modcod.
          END.
          IF rm_modcod <> "" THEN LEAVE loop_modcod.
    END. /* end repeat */
    
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
/* comment by a60-0095.............
/*RUN proc_renew_veh. 
MESSAGE "111DB CONNECT" SKIP 
"PD: " PDBNAME(1) " LD: " LDBNAME(1) SKIP
"PD: " PDBNAME(2) " LD: " LDBNAME(2) SKIP
"PD: " PDBNAME(3) " LD: " LDBNAME(3) SKIP
"PD: " PDBNAME(4) " LD: " LDBNAME(4) SKIP
"PD: " PDBNAME(5) " LD: " LDBNAME(5) SKIP
"PD: " PDBNAME(6) " LD: " LDBNAME(6) SKIP
"PD: " PDBNAME(7) " LD: " LDBNAME(7) SKIP 
"PD: " PDBNAME(8) " LD: " LDBNAME(8) SKIP VIEW-AS ALERT-BOX. */
ASSIGN
    wdetail.agent    = fi_agent  
    wdetail.producer = fi_producer .
/*wdetail.vehreg    = wdetail.vehreg + " " + wdetail.re_country. */
FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail.prepol   No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF sicuw.uwm100.renpol <> " " THEN DO:
        /*MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .*/
        RUN proc_assignrenew. 
        /*ASSIGN  
            wdetail.prepol  = "Already Renew"    /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
            wdetail.comment = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
            wdetail.OK_GEN  = "N"
            wdetail.pass    = "N". */
    END.
    ELSE DO: 
        /* ASSIGN  wdetail.prepol = sicuw.uwm100.policy
            n_rencnt  =  sicuw.uwm100.rencnt  +  1
            n_endcnt  =  0
            wdetail.pass  = "Y".*/
        RUN proc_assignrenew.      /*รับค่า ความคุ้มครองของเก่า */
    END.
END.   /*  avail  uwm100  *//*
Else do:  
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0
        wdetail.prepol   = ""
        wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".
    IF (wdetail.prempa = "" ) OR (wdetail.subclass = "" )   THEN DO:
        FIND LAST brstat.tlt USE-INDEX tlt06   WHERE
            brstat.tlt.cha_no  = wdetail.chasno AND 
            brstat.tlt.genusr  = "TISCO"        NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.tlt THEN DO:
            ASSIGN wdetail.prempa  = substr(tlt.expotim,1,1)   
                wdetail.prempa     = substr(tlt.expotim,1,1)   
                wdetail.subclass   = substr(tlt.expotim,2,3)   
                wdetail.tp1        = tlt.old_eng   
                wdetail.tp2        = tlt.old_cha   
                wdetail.tp3        = tlt.comp_pol  
                wdetail.covcod     = tlt.expousr 
                wdetail.seat       = 7 .
            IF tlt.expotim  = "" THEN MESSAGE "ไม่พบแพคเกจของเลขตัวถังนี้:" wdetail.chasno VIEW-AS ALERT-BOX .
        END.
    END.
END.   /*not  avail uwm100*/*/
IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".

/*END.  /* sicuw.uwm301 */
ELSE DO:
    ASSIGN wdetail.comment = wdetail.comment + "| ไม่พบเลขตัวถังในการต่ออายุ " 
           wdetail.OK_GEN  = "N"
           wdetail.pass     = "N".
END.*/
......end a60-0095...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew_veh c-Win 
PROCEDURE proc_renew_veh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*1*/        IF wdetail.re_country = "ANG THONG"          THEN wdetail.re_country = "อท".
/*2*/   ELSE IF wdetail.re_country = "AYUTTHAYA"          THEN wdetail.re_country = "อย".
/*3*/   ELSE IF wdetail.re_country = "BKK"                THEN wdetail.re_country = "กท". /*-A59-0503-*/ /* open A60-0095*/
/*3*/   ELSE IF wdetail.re_country = "BANGKOK"            THEN wdetail.re_country = "กท".
/*4*/   ELSE IF wdetail.re_country = "BURIRAM"            THEN wdetail.re_country = "บร".
/*5*/   ELSE IF wdetail.re_country = "CHAI NAT"           THEN wdetail.re_country = "ชน".
/*6*/   ELSE IF wdetail.re_country = "CHANTHABURI"        THEN wdetail.re_country = "จบ".
/*7*/   ELSE IF wdetail.re_country = "CHIANG MAI"         THEN wdetail.re_country = "ชม".
/*8*/   ELSE IF wdetail.re_country = "CHONBURI"           THEN wdetail.re_country = "ชบ".
/*9*/   ELSE IF wdetail.re_country = "KALASIN"            THEN wdetail.re_country = "กส".
/*10*/  ELSE IF wdetail.re_country = "KANCHANABURI"       THEN wdetail.re_country = "กจ".
/*11*/  ELSE IF wdetail.re_country = "KHON KAEN"          THEN wdetail.re_country = "ขก".
/*12*/  ELSE IF wdetail.re_country = "KRABI"              THEN wdetail.re_country = "กบ".
/*13*/  ELSE IF wdetail.re_country = "LOPBURI"            THEN wdetail.re_country = "ลบ".
/*14*/  ELSE IF wdetail.re_country = "NAKHON NAYOK"       THEN wdetail.re_country = "นย".
/*15*/  ELSE IF wdetail.re_country = "NAKHON PATHOM"      THEN wdetail.re_country = "นฐ".
/*16*/  ELSE IF wdetail.re_country = "NAKHON RATCHASIMA"  THEN wdetail.re_country = "นม".
/*17*/  ELSE IF wdetail.re_country = "NAKHON SITHAMMARAT" THEN wdetail.re_country = "นศ".
/*18*/  ELSE IF wdetail.re_country = "NONTHABURI"         THEN wdetail.re_country = "นบ".
/*19*/  ELSE IF wdetail.re_country = "PHETCHABURI"        THEN wdetail.re_country = "พบ".
/*20*/  ELSE IF wdetail.re_country = "PHUKET"             THEN wdetail.re_country = "ภก".
/*21*/  ELSE IF wdetail.re_country = "PHITSANULOK"        THEN wdetail.re_country = "พล".
/*22*/  ELSE IF wdetail.re_country = "PRACHINBURI"        THEN wdetail.re_country = "ปจ".
/*23*/  ELSE IF wdetail.re_country = "RATCHABURI"         THEN wdetail.re_country = "รบ".
/*24*/  ELSE IF wdetail.re_country = "RAYONG"             THEN wdetail.re_country = "รย".
/*25*/  ELSE IF wdetail.re_country = "ROI ET"             THEN wdetail.re_country = "รอ".
/*26*/  ELSE IF wdetail.re_country = "SARABURI"           THEN wdetail.re_country = "สบ".
/*27*/  ELSE IF wdetail.re_country = "SRISAKET"           THEN wdetail.re_country = "ศก".
/*28*/  ELSE IF wdetail.re_country = "SONGKHLA"           THEN wdetail.re_country = "สข".
/*29*/  ELSE IF wdetail.re_country = "SA KAEO"            THEN wdetail.re_country = "สก".
/*30*/  ELSE IF wdetail.re_country = "SUPHANBURI"         THEN wdetail.re_country = "สพ".
/*31*/  ELSE IF wdetail.re_country = "SURAT THANI"        THEN wdetail.re_country = "สฏ".
/*32*/  ELSE IF wdetail.re_country = "TRANG"              THEN wdetail.re_country = "ตง".
/*33*/  ELSE IF wdetail.re_country = "UBON RATCHATHANI"   THEN wdetail.re_country = "อบ".
/*34*/  ELSE IF wdetail.re_country = "UDON THANI"         THEN wdetail.re_country = "อด".
/*35*/  ELSE IF wdetail.re_country = "AMNAT CHAROEN"      THEN wdetail.re_country = "อจ".
/*36*/  ELSE IF wdetail.re_country = "CHAIYAPHUM"         THEN wdetail.re_country = "ชย".
/*37*/  ELSE IF wdetail.re_country = "CHIANG RAI"         THEN wdetail.re_country = "ชร".
/*38*/  ELSE IF wdetail.re_country = "CHUMPHON"           THEN wdetail.re_country = "ชพ".
/*39*/  ELSE IF wdetail.re_country = "KAMPHAENG PHET"     THEN wdetail.re_country = "กพ".
/*40*/  ELSE IF wdetail.re_country = "LAMPANG"            THEN wdetail.re_country = "ลป".
/*41*/  ELSE IF wdetail.re_country = "LAMPHUN"            THEN wdetail.re_country = "ลพ".
/*42*/  ELSE IF wdetail.re_country = "NAKHON SAWAN"       THEN wdetail.re_country = "นว".
/*43*/  ELSE IF wdetail.re_country = "NONG KHAI"          THEN wdetail.re_country = "นค".
/*44*/  ELSE IF wdetail.re_country = "PATHUM THANI"       THEN wdetail.re_country = "ปท".
/*45*/  ELSE IF wdetail.re_country = "PATTANI"            THEN wdetail.re_country = "ปน".
/*46*/  ELSE IF wdetail.re_country = "PHATTHALUNG"        THEN wdetail.re_country = "พท".
/*47*/  ELSE IF wdetail.re_country = "PHETCHABUN"         THEN wdetail.re_country = "พช".
/*48*/  ELSE IF wdetail.re_country = "SAKON NAKHON"       THEN wdetail.re_country = "สน".
/*49*/  ELSE IF wdetail.re_country = "SING BURI"          THEN wdetail.re_country = "สห".
/*50*/  ELSE IF wdetail.re_country = "SURIN"              THEN wdetail.re_country = "สร".
/*51*/  ELSE IF wdetail.re_country = "YASOTHON"           THEN wdetail.re_country = "ยส".
/*52*/  ELSE IF wdetail.re_country = "YALA"               THEN wdetail.re_country = "ยล".
/*53*/  ELSE IF wdetail.re_country = "BAYTONG"            THEN wdetail.re_country = "บต".
/*54*/  ELSE IF wdetail.re_country = "CHACHOENGSAO"       THEN wdetail.re_country = "ฉช".
/*55*/  ELSE IF wdetail.re_country = "LOEI"               THEN wdetail.re_country = "ลย".
/*56*/  ELSE IF wdetail.re_country = "MAE HONG SON"       THEN wdetail.re_country = "มส".
/*57*/  ELSE IF wdetail.re_country = "MAHA SARAKHAM"      THEN wdetail.re_country = "มค".
/*58*/  ELSE IF wdetail.re_country = "MUKDAHAN"           THEN wdetail.re_country = "มห".
/*59*/  ELSE IF wdetail.re_country = "NAN"                THEN wdetail.re_country = "นน".
/*60*/  ELSE IF wdetail.re_country = "NARATHIWAT"         THEN wdetail.re_country = "นธ".
/*61*/  ELSE IF wdetail.re_country = "NONG BUA LAMPHU"    THEN wdetail.re_country = "นภ".
/*62*/  ELSE IF wdetail.re_country = "PHAYAO"             THEN wdetail.re_country = "พย".  
/*63*/  ELSE IF wdetail.re_country = "PHANG NGA"          THEN wdetail.re_country = "พง".
/*64*/  ELSE IF wdetail.re_country = "PHRAE"              THEN wdetail.re_country = "พร".
/*65*/  ELSE IF wdetail.re_country = "PHICHIT"            THEN wdetail.re_country = "พจ".
/*66*/  ELSE IF wdetail.re_country = "PRACHUAP KHIRIKHAN" THEN wdetail.re_country = "ปข".
/*67*/  ELSE IF wdetail.re_country = "RANONG"             THEN wdetail.re_country = "รน".
/*68*/  ELSE IF wdetail.re_country = "SAMUT PRAKAN"       THEN wdetail.re_country = "สป".
/*69*/  ELSE IF wdetail.re_country = "SAMUT SAKHON"       THEN wdetail.re_country = "สค". 
/*70*/  ELSE IF wdetail.re_country = "SAMUT SONGKHRAM"    THEN wdetail.re_country = "สส".
/*71*/  ELSE IF wdetail.re_country = "SATUN"              THEN wdetail.re_country = "สต".
/*72*/  ELSE IF wdetail.re_country = "SUKHOTHAI"          THEN wdetail.re_country = "สท".
/*73*/  ELSE IF wdetail.re_country = "TAK"                THEN wdetail.re_country = "ตก".
/*74*/  ELSE IF wdetail.re_country = "TRAT"               THEN wdetail.re_country = "ตร".
/*75*/  ELSE IF wdetail.re_country = "UTHAI THANI"        THEN wdetail.re_country = "อน".
/*76*/  ELSE IF wdetail.re_country = "UTTARADIT"          THEN wdetail.re_country = "อต".
/*77*/  ELSE IF wdetail.re_country = "NAKHON PHANOM"      THEN wdetail.re_country = "นพ". 
/*78*/  ELSE IF wdetail.re_country = "BUENG KAN"          THEN wdetail.re_country = "บก". 
        ELSE IF wdetail.re_country = "กทม"                THEN wdetail.re_country = "กท".  /*a60-0095*/
       /* ELSE wdetail.re_country = " ". */ /* A60-0095*/
        ELSE DO:
            FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND
                brstat.insure.FName  = TRIM(wdetail.re_country) NO-LOCK NO-WAIT NO-ERROR. /*A60-0095*/
                /*brstat.insure.LName  = TRIM(wdetail.re_country) NO-LOCK NO-WAIT NO-ERROR.*/ /*A60-0095*/
            IF AVAIL brstat.insure THEN   /* A59-0503 */
                ASSIGN wdetail.re_country = Insure.LName
            /*A54-0112....
            wdetail.vehreg = substr(wdetail.vehreg,1,7) + " " + wdetail.re_country .
        ELSE wdetail.vehreg = substr(wdetail.vehreg,1,7).*/ /*A54-0112 */
                wdetail.vehreg = trim(substr(wdetail.vehreg,1,8)) + " " + trim(wdetail.re_country) .  /*A54-0112 */
            ELSE wdetail.vehreg = trim(substr(wdetail.vehreg,1,8)).                             /*A54-0112 */
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
FOR EACH wdetail 
    WHERE wdetail.PASS <> "Y"  :
        NOT_pass = NOT_pass + 1.
    
END.
IF NOT_pass > 0 THEN DO:
OUTPUT STREAM ns1 TO value(fi_output2).
PUT STREAM ns1
        "redbook "        "," 
        "branch  "        "," 
        "policyno"        ","
        "comment"         ","
        "cndat  "         ","
        "comdat "         ","
        "expdat "         ","
        "covcod "         ","
        "garage "         "," 
        "tiname "         ","
        "insnam "         ","
        "addr1  "         ","  
        "tambon "         ","  
        "amper   "        ","  
        "country "        ","  
        "brand   "        ","               
        "cargrp  "        ","               
        "chasno  "        ","               
        "eng     "        ","               
        "model   "        "," 
        "caryear "        "," 
        "body    "        "," 
        "vehuse  "        "," 
        "seat    "        "," 
        "engcc   "        "," 
        "vehreg  "        "," 
        "re_country"      "," 
        "si"              "," 
        "premt"           "," 
        "gap"             "," 
        "ncb"             "," 
        "stk"              "," 
        "prepol"    ","
        "benname"   ","   
        "comper "   ","   
        "comacc "   ","   
        "deductpd"  ","   
        "deduct "   ","   
        "compul "   ","
        "classcomp" "," /*A67-0185*/
        "compremt" "," /*A67-0185*/
        "pass   "   ","     
        "NO_41  "   ","   
        "NO_42  "   ","   
        "NO_43  "   ","   
        "caryear"   ","   
        "WARNING"    
            SKIP.                                                   
FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"   :   
    PUT STREAM ns1 
        wdetail.redbook    "," 
        wdetail.branch     "," 
        wdetail.policyno   ","
        wdetail.comment    ","
        wdetail.cndat      ","
        wdetail.comdat     ","
        wdetail.expdat     ","
        wdetail.covcod     ","
        wdetail.garage     "," 
        wdetail.tiname     ","
        wdetail.insnam     ","
        wdetail.addr1      ","  
        wdetail.tambon     ","  
        wdetail.amper      ","  
        wdetail.country    ","  
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
        wdetail.re_country "," 
        wdetail.si         "," 
        wdetail.premt      "," 
        /*wdetail.rstp_t   "," 
        wdetail.rtax_t     "," 
        wdetail.prem_r     "," */
        wdetail.gap        "," 
        wdetail.ncb        "," 
        /*wdetail.ncbprem  "," */
        wdetail.stk        ","
        wdetail.prepol     ","
        /*wdetail.ntitle1  ","
        wdetail.drivername1","   
        wdetail.dname1     ","   
        wdetail.dname2     ","   
        wdetail.docoup     ","   
        wdetail.dbirth     ","   
        wdetail.dicno      ","   
        wdetail.ddriveno   ","   
        wdetail.ntitle2    ","   
        wdetail.drivername2","   
        wdetail.ddname1    ","   
        wdetail.ddname2    ","   
        wdetail.ddocoup    ","   
        wdetail.ddbirth    ","   
        wdetail.ddicno     ","   
        wdetail.dddriveno  "," */  
        wdetail.benname    ","   
        wdetail.comper     ","   
        wdetail.comacc     ","   
        wdetail.deductpd   ","   
        /*wdetail.tp2      ","  */ 
        /*wdetail.deductda ","  */ 
        wdetail.deduct     ","   
        /*wdetail.tpfire   ","  */ 
        wdetail.compul     "," 
        wdetail.subclass    "|" /*A67-0185*/
        wdetail.comp_prm    "|" /*A67-0185*/
        wdetail.pass       ","     
        wdetail.NO_41      ","   
        wdetail.NO_42      ","   
        wdetail.NO_43      ","   
        wdetail.caryear    ","   
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
FOR EACH  wdetail 
    WHERE wdetail.PASS = "Y"  :
        pass = pass + 1.
END.
IF pass > 0 THEN DO:
OUTPUT STREAM ns2 TO value(fi_output1).
PUT STREAM NS2
            "redbook"     "|"   
            "branch "     "|"   
            "policyno"    "|"
            "cndat  "     "|" 
            "comdat "     "|" 
            "expdat "     "|" 
            "covcod "     "|" 
            "garage "     "|" 
            "tiname "     "|" 
            "insnam "     "|" 
            "addr1"       "|"  
            "tambon"      "|"  
            "amper"       "|"  
            "country"     "|"  
            "brand"       "|"               
            "cargrp"      "|"               
            "chasno"      "|"               
            "eng"         "|"               
            "model"       "|" 
            "caryear"     "|" 
            "body"        "|" 
            "vehuse"      "|" 
            "seat"        "|" 
            "engcc"       "|" 
            "vehreg"      "|" 
            "re_country"  "|"
            "si "         "|" 
            "premt "      "|" 
            "gap"         "|" 
            "ncb"         "|" 
            "stk   "      "|"
            "prepol"      "|"
            "benname "    "|"   
            "comper  "    "|"   
            "comacc  "    "|"   
            "deductpd"    "|"   
            "deduct"      "|"   
            "compul"      "|"
            "classcomp"   "|"  /*A67-0185*/
            "compremt"    "|"  /*A67-0185*/
            "pass  "      "|"     
            "NO_41 "      "|"   
            "NO_42 "      "|"   
            "NO_43 "      "|"   
            "comment"     "|"
            "WARNING"     SKIP.  
     
FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
            wdetail.redbook     "|"   
            wdetail.branch      "|"   
            wdetail.policyno    "|" 
            wdetail.cndat       "|" 
            wdetail.comdat      "|" 
            wdetail.expdat      "|" 
            wdetail.covcod      "|" 
            wdetail.garage      "|" 
            wdetail.tiname      "|" 
            wdetail.insnam      "|" 
            wdetail.addr1       "|"  
            wdetail.tambon      "|"  
            wdetail.amper       "|"  
            wdetail.country     "|"  
            /*wdetail.birthdat  "|"  
            wdetail.driverno    "|" */              
            wdetail.brand       "|"               
            wdetail.cargrp      "|"               
            wdetail.chasno      "|"               
            wdetail.eng         "|"               
            wdetail.model       "|" 
            wdetail.caryear     "|" 
            wdetail.body        "|" 
            wdetail.vehuse      "|" 
            wdetail.seat        "|" 
            wdetail.engcc       "|" 
            wdetail.vehreg      "|" 
            wdetail.re_country  "|" 
            /*wdetail.re_year   "|" */
            wdetail.si          "|" 
            wdetail.premt       "|" 
            /*wdetail.rstp_t    "|" 
            wdetail.rtax_t      "|" 
            wdetail.prem_r      "|" */
            wdetail.gap         "|" 
            wdetail.ncb         "|" 
       /* wdetail.ncbprem       "|" */
            wdetail.stk         "|" 
            wdetail.prepol      "|" 
            /*wdetail.flagno    "|" 
            wdetail.ntitle1     "|" 
            wdetail.drivername1 "|"   
            wdetail.dname1      "|"   
            wdetail.dname2      "|"   
            wdetail.docoup      "|"   
            wdetail.dbirth      "|"   
            wdetail.dicno       "|"   
            wdetail.ddriveno    "|"   
            wdetail.ntitle2     "|"   
            wdetail.drivername2 "|"   
            wdetail.ddname1     "|"   
            wdetail.ddname2     "|"   
            wdetail.ddocoup     "|"   
            wdetail.ddbirth     "|"   
            wdetail.ddicno      "|"   
            wdetail.dddriveno   "|" */  
            wdetail.benname     "|"   
            wdetail.comper      "|"   
            wdetail.comacc      "|"   
            wdetail.deductpd    "|"   
            /*wdetail.tp2       "|" */  
       /* wdetail.deductda      "|"  */ 
            wdetail.deduct      "|"   
            /*wdetail.tpfire    "|" */  
            wdetail.compul      "|" 
            wdetail.subclass    "|" /*A67-0185*/
            wdetail.comp_prm    "|" /*A67-0185*/
            wdetail.pass        "|"     
            wdetail.NO_41       "|"   
            wdetail.NO_42       "|"   
            wdetail.NO_43       "|"   
            wdetail.comment     "|"
            wdetail.WARNING       SKIP. 
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
/* comment by a60-0095............
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
      
      CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.  
      /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. */
      
      CLEAR FRAME nf00.
      HIDE FRAME nf00.

      RETURN. 
    
   END.

END.
.....end a60-0095...*/
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
    nv_idnolist    = "" /*trim(wdetail.icno) */ .
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
/* comment by a60-0095............
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
  ....end a60-0095.....*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 c-Win 
PROCEDURE proc_uwd100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
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
     sic_bran.uwm100.policy  = wdetail.policyno  AND
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
            sic_bran.uwd100.policy  = wdetail.policyno
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
END. /*uwm100*/*/
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
/*
DEF VAR n_num1 AS INTE INIT 0.
DEF VAR n_num2 AS INTE INIT 0.
DEF VAR n_num3 AS INTE INIT 1.
DEF VAR i      AS INTE INIT 0.   
DEF VAR n_text1 AS CHAR FORMAT "x(255)".*/
ASSIGN 
    nv_fptr  = 0
    nv_bptr  = 0
    nv_nptr  = 0
    nv_line1 = 1.
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
/*DO WHILE nv_line1 <= 10:*/
DO WHILE nv_line1 <= 10:
    CREATE wuppertxt3.
    wuppertxt3.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt3.txt = "ชื่อเจ้าหน้าที่ประกัน: " + wdetail.not_office .
    IF nv_line1 = 2  THEN wuppertxt3.txt = "Notify date: " + wdetail.entdat     .
    /*IF nv_line1 = 3  THEN wuppertxt3.txt = "Notify time:" + wdetail.enttim    .*//*A55-0184*/
    IF nv_line1 = 3  THEN wuppertxt3.txt = "Notify time: " + wdetail.enttim .      /*A55-0184*/
    IF nv_line1 = 4  THEN wuppertxt3.txt = "Notify Code: " + wdetail.not_code .    /*A55-0184*/
    IF nv_line1 = 5  THEN wuppertxt3.txt = "Date Confirm_file_name :" + wdetail.remark .   
    IF nv_line1 = 6  THEN wuppertxt3.txt = "สีรถ :" + wdetail.colorcode.  /*A65-0356*/ 
     /*A67-0114 */
    IF nv_line1 = 7  THEN wuppertxt3.txt = "หมายเลขเครื่องยนต์ 3: " + wdetail.engno3 .
    IF nv_line1 = 8  THEN wuppertxt3.txt = "หมายเลขเครื่องยนต์ 4: " + wdetail.engno4 .
    IF nv_line1 = 9  THEN wuppertxt3.txt = "หมายเลขเครื่องยนต์ 5: " + wdetail.engno5 .
    /* end : A67-0114 */

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
            sic_bran.uwd102.policy  = sic_bran.uwm100.policy        
            sic_bran.uwd102.rencnt  = sic_bran.uwm100.rencnt 
            sic_bran.uwd102.endcnt  = sic_bran.uwm100.endcnt        
            sic_bran.uwd102.ltext   = wuppertxt3.txt
            nv_nptr                 = Recid(sic_bran.uwd102) .
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
      IF s_curbil = "BHT" THEN  sic_bran.uwd132.prem_c = sic_bran.uwd132.prem_c.
      IF n_dcover <> 365 AND n_dcover <> 366  THEN sic_bran.uwd132.prem_c = DECI(wdetail.comp_prm) . /*a61-0410*/
    END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

