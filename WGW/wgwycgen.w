&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases   sic_test         PROGRESS*/
  File: Description: 
  Input Parameters: <none>
  Output Parameters: <none>
  Author: 
  Created: -------------------------------------------------------------*/  
/*          This .W file was created with the Progress AppBuilder.      */  
/* Create an unnamed pool to store all the widgets created              
     by this procedure. This is a good default which assures            
     that this procedure's triggers and internal procedures             
     will execute in this procedure's storage, and that proper          
     cleanup will occur on deletion of the procedure. */                
CREATE WIDGET-POOL.                                                     
/****************************  Definitions  *****************/  
/*Parameters Definitions ---                                */  
/*Local Variable Definitions ---                            */  
/*programid   : wgwycgen.w                                  */  
/*programname : load text file ya-cool to GW                */  
/*Copyright  : Safety Insurance Public Company Limited      */  
/*copy write  : wgwargen.w                                  */  
/*บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                        */  
/*create by   : Kridtiya i. A52-0232 date . 27/07/2010 ปรับโปรแกรมให้สามารถนำเข้า text file yakulte to GW system*/
/*Modify by   : Kridtiya i. A52-0232 date . 10/09/2010 ปรับโปรแกรมให้รับเบสที่พารามิเตอร์ */
/*Modify by   : Kridtiya i. A53-0370 เพิ่มการรับค่าวันที่ความคุ้มครอง   */  
/*Modify by   : Kridtiya i. A54-0057 ปรับให้รับที่อยู่จากfile xtm600    */  
/*Modify by   : Kridtiya i. A54-0188 ปรับการรับรหัสลูกค้าที่ xtm600     */  
/*Modify by   : Kridtiya i. A56-0072 ปรับการรับข้อมูลการต่ออายุงาน พรบ. *//*proc_definition*/
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by   : Kridtiya i. A65-0035 comment message error premium not on file */
DEF NEW SHARED VAR nv_producer AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR nv_agent    AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno. 
def  var  nv_row  as  int  init  0.
DEFINE STREAM  ns1. 
DEFINE STREAM  ns2.
DEFINE STREAM  ns3.
DEF VAR nv_uom1_v AS INTE INIT 0.
DEF VAR nv_uom2_v AS INTE INIT 0.
DEF VAR nv_uom5_v AS INTE INIT 0.
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
DEF NEW  SHARED VAR   nv_ncbper   AS DECI .
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
/*DEF VAR nv_provi   AS   CHAR INIT "".*/
DEF VAR n_rencnt   LIKE sicuw.uwm100.rencnt INITIAL "".
def var nv_index   as   int  init  0. 
DEF VAR n_endcnt   LIKE sicuw.uwm100.endcnt INITIAL "".
def var n_comdat   LIKE sicuw.uwm100.comdat  NO-UNDO.
def var n_policy   LIKE sicuw.uwm100.policy  INITIAL "" .
DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEF VAR nv_reccnt   AS  INT  INIT  0.          /*all load record*/
DEF VAR nv_completecnt    AS   INT   INIT  0.  /*complete record */
DEF NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".  
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
{wgw\wgwycgen.i}      /*ประกาศตัวแปร*/
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
DEFINE  WORKFILE makt NO-UNDO
/*1*/  FIELD brand1    AS CHAR   FORMAT "x(30)"
/*2*/  FIELD model1     AS CHARACTER FORMAT "X(50)"   INITIAL "".
DEF WORKFILE wk_db
    FIELD phyname  AS CHAR FORMAT "x(10)"
    FIELD unixpara AS CHAR FORMAT "x(10)".

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
&Scoped-define FIELDS-IN-QUERY-br_comp wcomp.brand wcomp.redbook   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_comp   
&Scoped-define SELF-NAME br_comp
&Scoped-define QUERY-STRING-br_comp FOR EACH wcomp
&Scoped-define OPEN-QUERY-br_comp OPEN QUERY br_comp FOR EACH wcomp.
&Scoped-define TABLES-IN-QUERY-br_comp wcomp
&Scoped-define FIRST-TABLE-IN-QUERY-br_comp wcomp


/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.policy wdetail.comdat wdetail.expdat wdetail.covcod wdetail.n_insured wdetail.tiname wdetail.insnam wdetail.name2 wdetail.addr_1 wdetail.addr_2 wdetail.addr_3 wdetail.addr_4 wdetail.garage wdetail.cndat   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY  br_query FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_exphd ra_typefile fi_loaddat fi_pack ~
fi_covcod fi_brandset fi_redbookset bu_add bu_del fi_branch fi_producer ~
fi_agent fi_insurno fi_prevbat fi_bchyr fi_filename bu_file fi_output1 ~
fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit bu_hpbrn bu_hpacno1 ~
bu_hpagent bu_insured fi_process br_wdetail br_comp fi_base fi_deduct ~
fi_fleet fi_ncb fi_411 fi_412 fi_43 fi_filenameHD RECT-370 RECT-372 ~
RECT-373 RECT-374 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS ra_typefile fi_loaddat fi_pack fi_covcod ~
fi_brandset fi_redbookset fi_branch fi_producer fi_bchno fi_agent ~
fi_insurno fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 ~
fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_proname fi_agtname fi_insurnam ~
fi_completecnt fi_process fi_premtot fi_premsuc fi_base fi_deduct fi_fleet ~
fi_ncb fi_411 fi_412 fi_43 fi_filenameHD 

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
     SIZE 14 BY 1.14
     FONT 6.

DEFINE BUTTON bu_add 
     LABEL "ADD" 
     SIZE 6 BY .95.

DEFINE BUTTON bu_del 
     LABEL "DEL" 
     SIZE 6 BY .91.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 14 BY 1.14
     FONT 6.

DEFINE BUTTON bu_exphd 
     LABEL "EXP" 
     SIZE 5.5 BY .91.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 5.5 BY .91.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_insured 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE VARIABLE fi_411 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_412 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_43 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_base AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(19)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brandset AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_deduct AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_filenameHD AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_fleet AS DECIMAL FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_insurnam AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insurno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ncb AS DECIMAL FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
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
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

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
     SIZE 18.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60.5 BY .91
     FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_redbookset AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

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
          "Match Policy Renew", 1,
"LOAD ", 2
     SIZE 32.5 BY .95
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.43
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 14.48
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 4.81
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 2.91
     BGCOLOR 8 .

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
      wcomp.brand    COLUMN-LABEL "Brand"     FORMAT "x(15)"
      wcomp.redbook  COLUMN-LABEL "Redbook"   FORMAT "X(8)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 28 BY 4.05
         BGCOLOR 15 FONT 6 FIT-LAST-COLUMN.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.policy         COLUMN-LABEL "Policy No"
      wdetail.comdat         COLUMN-LABEL "comdate"   
      wdetail.expdat         COLUMN-LABEL "expidate" 
      wdetail.covcod         COLUMN-LABEL "covcod"
      wdetail.n_insured      COLUMN-LABEL "Insured"
      wdetail.tiname         COLUMN-LABEL "tiname"
      wdetail.insnam         COLUMN-LABEL "insnam"
      wdetail.name2          COLUMN-LABEL "name2"
      wdetail.addr_1         COLUMN-LABEL "addr_1"
      wdetail.addr_2         COLUMN-LABEL "addr_2"
      wdetail.addr_3         COLUMN-LABEL "addr_3"
      wdetail.addr_4         COLUMN-LABEL "addr_4"
      wdetail.garage         COLUMN-LABEL "garage"
      wdetail.cndat          COLUMN-LABEL "CN date"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 131 BY 4.38
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_exphd AT ROW 9.76 COL 87.5 WIDGET-ID 6
     ra_typefile AT ROW 2.67 COL 3.5 NO-LABEL
     fi_loaddat AT ROW 2.67 COL 47.67 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 2.67 COL 77.83 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 2.67 COL 93.83 COLON-ALIGNED NO-LABEL
     fi_brandset AT ROW 4.81 COL 108.67 COLON-ALIGNED NO-LABEL
     fi_redbookset AT ROW 5.86 COL 108.83 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 4.81 COL 121.83
     bu_del AT ROW 5.86 COL 121.83
     fi_branch AT ROW 4.76 COL 25 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.76 COL 25 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.86 COL 16 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agent AT ROW 6.76 COL 25 COLON-ALIGNED NO-LABEL
     fi_insurno AT ROW 7.76 COL 25 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 8.76 COL 25 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 8.76 COL 57.67 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 10.76 COL 25 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 10.81 COL 87.5
     fi_output1 AT ROW 11.76 COL 25 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 12.76 COL 25 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 13.76 COL 25 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 14.76 COL 25 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 14.76 COL 63.17 NO-LABEL
     buok AT ROW 11.81 COL 95
     bu_exit AT ROW 13.48 COL 95
     fi_brndes AT ROW 4.76 COL 43.83 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 4.76 COL 33.67
     bu_hpacno1 AT ROW 5.76 COL 41.33
     bu_hpagent AT ROW 6.76 COL 41.33
     fi_impcnt AT ROW 22.29 COL 59.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_proname AT ROW 5.76 COL 43.83 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6.76 COL 43.83 COLON-ALIGNED NO-LABEL
     bu_insured AT ROW 7.76 COL 41.33
     fi_insurnam AT ROW 7.76 COL 43.83 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.29 COL 59.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 15.81 COL 25 COLON-ALIGNED NO-LABEL
     fi_premtot AT ROW 22.29 COL 97.17 NO-LABEL NO-TAB-STOP 
     br_wdetail AT ROW 17.19 COL 1.67
     br_comp AT ROW 6.91 COL 99.67
     fi_premsuc AT ROW 23.33 COL 95.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_base AT ROW 3.76 COL 25 COLON-ALIGNED NO-LABEL
     fi_deduct AT ROW 3.76 COL 46.17 COLON-ALIGNED NO-LABEL
     fi_fleet AT ROW 3.76 COL 65 COLON-ALIGNED NO-LABEL
     fi_ncb AT ROW 3.76 COL 75.67 COLON-ALIGNED NO-LABEL
     fi_411 AT ROW 3.76 COL 84.83 COLON-ALIGNED NO-LABEL
     fi_412 AT ROW 3.76 COL 101 COLON-ALIGNED NO-LABEL
     fi_43 AT ROW 3.76 COL 117.17 COLON-ALIGNED NO-LABEL
     fi_filenameHD AT ROW 9.76 COL 25 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     "                      Branch :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 4.76 COL 3.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "43:" VIEW-AS TEXT
          SIZE 3.5 BY .91 AT ROW 3.76 COL 115.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 10.76 COL 3.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Redbook :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 5.86 COL 99.83
          BGCOLOR 5 FGCOLOR 0 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .91 AT ROW 14.76 COL 61.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Package :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 2.67 COL 68.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 23.29 COL 95 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                   IMPORT TEXT FILE MOTOR [YAKULT]" VIEW-AS TEXT
          SIZE 130 BY .91 AT ROW 1.24 COL 2.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                         Base :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 3.76 COL 3.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Brand :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 4.81 COL 99.83
          BGCOLOR 5 FGCOLOR 0 FONT 6
     "42:" VIEW-AS TEXT
          SIZE 3.5 BY .91 AT ROW 3.76 COL 99.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "               Agent Code :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 6.76 COL 3.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 23.29 COL 116.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "1= ป1, 2= ป2, 3= ป3,T= พรบ." VIEW-AS TEXT
          SIZE 30.5 BY .95 AT ROW 2.67 COL 100.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.29 COL 116.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "NCB:" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 3.76 COL 72.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "      Head Report Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 9.76 COL 3.5 WIDGET-ID 2
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 11.76 COL 3.5
          BGCOLOR 8 FGCOLOR 1 
     "TieS 4 01/03/2022":60 VIEW-AS TEXT
          SIZE 19 BY .91 AT ROW 15.81 COL 94 WIDGET-ID 8
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 22.29 COL 94.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "          Producer  Code :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 5.76 COL 3.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 14.76 COL 25.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 14.76 COL 81
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Covcod :" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 2.67 COL 85.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.86 COL 5.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Load Date :":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 2.67 COL 37
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.29 COL 57.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "41:" VIEW-AS TEXT
          SIZE 3.5 BY .91 AT ROW 3.76 COL 83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 13.76 COL 3.5
          BGCOLOR 8 FGCOLOR 1 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "    Previous Batch No. :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 8.76 COL 3.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 23.29 COL 57.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Fleet :" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 3.76 COL 60.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Deduct :" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 3.76 COL 39.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 12.76 COL 3.5
          BGCOLOR 8 FGCOLOR 1 
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .91 AT ROW 8.76 COL 46.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                     Insured :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 7.76 COL 3.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.43 COL 1
     RECT-373 AT ROW 16.95 COL 1
     RECT-374 AT ROW 21.86 COL 1
     RECT-376 AT ROW 22.05 COL 4.5
     RECT-377 AT ROW 11.57 COL 93.5
     RECT-378 AT ROW 13.24 COL 93.5
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
         TITLE              = "Load Text file yakult to GW"
         HEIGHT             = 23.95
         WIDTH              = 132.83
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
/* BROWSE-TAB br_wdetail fi_premtot fr_main */
/* BROWSE-TAB br_comp br_wdetail fr_main */
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
/* SETTINGS FOR FILL-IN fi_insurnam IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premsuc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premtot IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "     Policy Import Total :"
          SIZE 23 BY .91 AT ROW 14.76 COL 25.5 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .91 AT ROW 14.76 COL 61.67 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.29 COL 57.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 22.29 COL 94.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 23.29 COL 57.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 23.29 COL 95 RIGHT-ALIGNED          */

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
OPEN QUERY  br_query FOR EACH wdetail.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* Load Text file yakult to GW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text file yakult to GW */
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
    wcomp.brand:BGCOLOR IN BROWSE BR_comp = z NO-ERROR.  
    wcomp.redbook:BGCOLOR IN BROWSE BR_comp = z NO-ERROR.

    wcomp.brand:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
    wcomp.redbook:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
          
  
  
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
    IF wdetail.WARNING <> "" THEN DO:
        wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.comdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.expdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.covcod:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.n_insured:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.tiname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.insnam:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.name2 :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.addr_1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
        wdetail.addr_2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.addr_3:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.addr_4:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.garage:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.cndat :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        
        wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.comdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.expdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.covcod:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.n_insured:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.tiname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.insnam:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.name2 :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.addr_1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.addr_2:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.addr_3:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.addr_4:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
        wdetail.garage:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.cndat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    IF ra_typefile = 2 THEN DO:
        ASSIGN
            nn_acno      =  ""
        nn_name      =  ""  
        nn_name2     =  ""
        nn_name3     =  ""  
        nn_addr1     =  ""  
        nn_addr2     =  ""  
        nn_addr3     =  ""  
        nn_addr4     =  ""  
        nn_ntitle    =  "" 
        fi_insurnam  =  "" 
        fi_completecnt:FGCOLOR = 2
        fi_premsuc:FGCOLOR     = 2 
        fi_bchno:FGCOLOR       = 2
        fi_completecnt         = 0
        fi_premsuc             = 0
        fi_bchno               = ""
        fi_premtot             = 0
        fi_impcnt              = 0
        fi_process             = "Start Load Text file Yakulte....".
    DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
    IF INPUT fi_covcod = ""  THEN DO:
        MESSAGE "กรุณาใสประเภทประกันภัย !!!" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_covcod.
        RETURN NO-APPLY.
    END.
    IF fi_branch = " " THEN DO: 
        MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_branch.
        RETURN NO-APPLY.
    END.
    IF fi_insurno = ""    THEN DO:
        MESSAGE "Insurced Code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_insurno.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        FIND FIRST  sicsyac.xtm600  USE-INDEX  xtm60001 WHERE
            sicsyac.xtm600.acno  =  trim(fi_insurno)    NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xtm600 THEN DO: 
            ASSIGN  nn_acno  =  trim(sicsyac.xtm600.acno)  
                nn_name      =  trim(sicsyac.xtm600.name)  
                nn_name2     =  ""
                nn_name3     =  ""  
                nn_addr1     =  trim(sicsyac.xtm600.addr1) 
                nn_addr2     =  trim(sicsyac.xtm600.addr2) 
                nn_addr3     =  trim(sicsyac.xtm600.addr3) 
                nn_addr4     =  trim(sicsyac.xtm600.addr4) 
                nn_ntitle    =  trim(sicsyac.xtm600.ntitle) 
                fi_insurno   =  trim(caps(INPUT  fi_insurno)) 
                fi_insurnam  =  TRIM(sicsyac.xtm600.ntitle) + "  "  + trim(sicsyac.xtm600.name) .
            FIND FIRST sicsyac.xmm600  USE-INDEX  xmm60001 WHERE
                sicsyac.xmm600.acno  =  trim(fi_insurno)   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE sicsyac.xmm600 THEN 
                ASSIGN nn_icno      =  trim(sicsyac.xmm600.icno)  
                /* xmm600 *//*Add by Kridtiya i. A63-0472*/
                nn_firstName  = TRIM(sicsyac.xmm600.firstname)  
                nn_lastName   = TRIM(sicsyac.xmm600.lastName)   
                nn_postcd     = trim(sicsyac.xmm600.postcd)     
                nn_codeocc    = trim(sicsyac.xmm600.codeocc)    
                nn_codeaddr1  = TRIM(sicsyac.xmm600.codeaddr1)  
                nn_codeaddr2  = TRIM(sicsyac.xmm600.codeaddr2)  
                nn_codeaddr3  = trim(sicsyac.xmm600.codeaddr3)  
                nn_br_insured = trim(sicsyac.xmm600.anlyc5)     .   
                /*Add by Kridtiya i. A63-0472*/
            ELSE nn_icno      = "".
        END.
        ELSE DO: 
            /*Message  "Not on Name & Address Master File xtm600"  View-as alert-box.
            Apply  "Entry" To  fi_insurno .
            RETURN NO-APPLY. */               /* note add on 10/11/2005 */
            ASSIGN nn_acno  = "0C17962" 
                nn_name     = "ยาคูลท์เซลส์ (กรุงเทพฯ) จำกัด"  
                nn_name2    = ""
                nn_name3    = ""  
                nn_addr1    = "1025 อาคารยาคูลท์ ชั้น 16"  
                nn_addr2    = "ถนนพหลโยธิน แขวงสามเสนใน"   
                nn_addr3    = "เขตพญาไท กรุงเทพมหานคร"     
                nn_addr4    = ""                           
                nn_ntitle   = "บริษัท"  
                fi_insurno  = ""
                fi_insurnam = ""
                nn_icno     = ""  
                /* xmm600 *//*Add by Kridtiya i. A63-0472*/
                nn_firstName  = ""
                nn_lastName   = ""
                nn_postcd     = ""
                nn_codeocc    = ""
                nn_codeaddr1  = ""
                nn_codeaddr2  = ""
                nn_codeaddr3  = ""
                nn_br_insured = "".   
                /*Add by Kridtiya i. A63-0472*/
        END.     /*end note 10/11/2005*/
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
    ASSIGN fi_output1 = INPUT fi_output1
        fi_output2    = INPUT fi_output2
        fi_output3    = INPUT fi_output3.
    IF fi_output1  = ""  THEN DO:
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
        FIND LAST uzm700 USE-INDEX uzm70002    WHERE 
            uzm700.bchyr  = nv_batchyr         AND
            uzm700.acno   = TRIM(fi_producer)  AND
            uzm700.branch = TRIM(nv_batbrn)    NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:  
            ASSIGN nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102      WHERE 
                uzm701.bchyr = nv_batchyr            AND 
                uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN 
                ASSIGN nv_batcnt = uzm701.bchcnt 
                nv_batrunno      = nv_batrunno + 1. 
        END.
        ELSE DO:  
            ASSIGN nv_batcnt = 1
                nv_batrunno  = 1.
        END.
        ASSIGN nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END.
    ELSE DO: 
        ASSIGN  nv_batprev = INPUT fi_prevbat .
        FIND LAST uzm701 USE-INDEX uzm70102  WHERE  
            uzm701.bchyr = nv_batchyr        AND 
            uzm701.bchno = CAPS(nv_batprev)  NO-LOCK NO-ERROR NO-WAIT.
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
    /*For each  wdetail2 :
    DELETE  wdetail2.
    End.*/
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
        IF WDETAIL.POLTYP = "v70" OR WDETAIL.POLTYP = "v72" THEN  
            ASSIGN nv_reccnt      =  nv_reccnt   + 1
            nv_netprm_t    =  nv_netprm_t + decimal(wdetail.prem_r)
            wdetail.pass   =  "Y". 
        ELSE DELETE WDETAIL. 
    END.
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen" VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    /*comment by :A64-0138...
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
     ..end A64-0138..*/ 
    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                           INPUT            nv_batchyr ,     /* INT   */
                           INPUT            fi_producer,     /* CHAR  */ 
                           INPUT            nv_batbrn  ,     /* CHAR  */
                           INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                           INPUT            "WGWYCGEN" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem       /* DECI  */
                           ).
    ASSIGN  fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.
    RUN proc_chktest1. 
    FOR EACH wdetail WHERE wdetail.pass = "y" NO-LOCK.
        ASSIGN nv_completecnt = nv_completecnt + 1
            nv_netprm_s       = nv_netprm_s    + decimal(wdetail.prem_r). 
    END.
    ASSIGN 
        nv_rectot = nv_reccnt
        nv_recsuc = nv_completecnt. 
    IF  /*nv_imppol <> nv_rectot OR nv_imppol <> nv_recsuc OR */
        nv_rectot <> nv_recsuc   THEN DO:
        nv_batflg = NO.
        /*MESSAGE "Policy import record is not match to Total record !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE IF   /*nv_impprem  <> nv_netprm_t OR nv_impprem  <> nv_netprm_s OR*/
        nv_netprm_t <> nv_netprm_s THEN DO:
        nv_batflg = NO.
        /*MESSAGE "Total net premium is not match to Total net premium !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE  nv_batflg = YES.
    FIND LAST uzm701 USE-INDEX uzm70102 WHERE 
        uzm701.bchyr  = nv_batchyr      AND
        uzm701.bchno  = nv_batchno      AND
        uzm701.bchcnt = nv_batcnt       NO-ERROR NO-WAIT.
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

    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  . 
    
    IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_process    = " Load file Error ...."
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno      :FGCOLOR = 6. 
        DISP fi_completecnt fi_premsuc WITH FRAME fr_main.
        MESSAGE "Batch Year  : " STRING(nv_batchyr) SKIP
            "Batch No.   : " nv_batchno             SKIP
            "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
            TRIM(nv_txtmsg)                         SKIP
            "Please check Data again...!!!  "  VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".     
        DISP fi_process  WITH FRAM fr_main.
    END.
    ELSE IF nv_batflg = YES THEN DO: 
        ASSIGN
            fi_process   = "Load File complete..."
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
        DISP fi_process  WITH FRAM fr_main.
    END.
    /*FOR EACH wdetail:
         FOR EACH wdetail2 WHERE wdetail2.policyno = wdetail.policyno :
            ASSIGN wdetail.pass = wdetail2.pass.
        END.
    END.*/
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.  
    END.
    ELSE DO:  /*match file policy renew */
        IF INPUT fi_covcod = ""  THEN DO:
            MESSAGE "กรุณาใสประเภทประกันภัย !!!" VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_covcod .
            RETURN NO-APPLY.
        END.
        ELSE ASSIGN chk_type =  INPUT fi_covcod .
        RUN proc_matpolrenew.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add c-Win
ON CHOOSE OF bu_add IN FRAME fr_main /* ADD */
DO:
    IF fi_brandset = "" THEN DO:
        APPLY "ENTRY" TO fi_brandset .
        disp fi_brandset  with frame  fr_main.
    END.
    ELSE DO:
        IF fi_redbookset = "" THEN DO:
            APPLY "entry" TO fi_redbookset.
            DISP fi_redbookset WITH FRAM fr_main.
        END.
        ELSE DO:
            FIND LAST WComp WHERE 
                wcomp.brand    = trim(fi_brandset)   AND
                wcomp.redbook  = TRIM(fi_redbookset) NO-ERROR NO-WAIT.
            IF NOT AVAIL wcomp THEN DO:
                CREATE wcomp.
                ASSIGN 
                    wcomp.brand     = trim(fi_brandset)  
                    wcomp.redbook   = TRIM(fi_redbookset)
                    fi_brandset      = "" 
                    fi_redbookset     = "" .
            END.
        END.
    END.
    OPEN QUERY br_comp FOR EACH wcomp.
    APPLY "ENTRY" TO fi_brandset   .
    disp fi_brandset  fi_redbookset   with frame  fr_main.
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
    APPLY "ENTRY" TO fi_brandset   .
    disp fi_brandset  fi_redbookset   with frame  fr_main.
  
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


&Scoped-define SELF-NAME bu_exphd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exphd c-Win
ON CHOOSE OF bu_exphd IN FRAME fr_main /* EXP */
DO:
    OUTPUT TO VALUE(fi_filenameHD).
    EXPORT DELIMITER "|"
        
        "ลำดับ"
        "กรม"
        "กรมธรรม์ 72"
        "เสียภาษี"
        "แผนก"
        "Key_ID"        
        "คำนำหน้าชื่อ"
        "ชื่อ"
        "นามสกุล"
        "ยี่ห้อ"
        "ซีซี"
        "ทะเบียน"
        "จังหวัดทะเบียน"
        "หมายเลขตัวถัง"
        "ปีพ.ศ."
        "วันที่เริ่มคุ้มครอง"
        "วันที่สิ้นสุดความคุ้มครอง"
        "ทุน"
        "TEXT_F17_1"    
        "TEXT_F17_2"    
        "TEXT_F17_3"    
        "TEXT_F18_1"    
        "TEXT_F18_2"    
        "TEXT_F18_3"    
        "TEXT_F6_1"     
        "TEXT_F6_2"     
        "TEXT_F6_3"     
        "TEXT_F6_4"     
        "TEXT_F6_5"     
        "Campaign OV".
    OUTPUT CLOSE.
    MESSAGE "Export Report Head Complete " VIEW-AS ALERT-BOX.
    
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
         IF ra_typefile = 2 THEN DO:
             ASSIGN
                 fi_filename  = cvData
                 fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
                 fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
                 fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
             DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
             APPLY "Entry" TO fi_output3.
             RETURN NO-APPLY.
         END.
         ELSE DO:
             ASSIGN
                 fi_filename  = cvData
                 fi_output1   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))    +  "_chkrenew.csv" /*.csv*/
                 fi_output2   =  ""           
                 fi_output3   =  "".  /*txt*/ 
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


&Scoped-define SELF-NAME bu_insured
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_insured c-Win
ON CHOOSE OF bu_insured IN FRAME fr_main
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


&Scoped-define SELF-NAME fi_411
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_411 c-Win
ON LEAVE OF fi_411 IN FRAME fr_main
DO:
  fi_411  =  Input  fi_411.
  Disp  fi_411  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_412
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_412 c-Win
ON LEAVE OF fi_412 IN FRAME fr_main
DO:
  fi_412  =  Input  fi_412.
  Disp  fi_412  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_43
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_43 c-Win
ON LEAVE OF fi_43 IN FRAME fr_main
DO:
  fi_43  =  Input  fi_43.
  Disp  fi_43  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent c-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    /*ASSIGN fi_agent = "B3m0016".*/
    fi_agent = INPUT fi_agent.
    IF fi_agent <> ""    THEN DO:
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno  =  Input fi_agent  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_agent.
            RETURN NO-APPLY.   /*note add on 10/11/2005*/
        END.
        ELSE DO: /*note modi on 10/11/2005*/
            ASSIGN
                fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_agent   =  caps(INPUT  fi_agent) /*note modi 08/11/05*/
                nv_agent   =  fi_agent.             /*note add  08/11/05*/
        END.  /*end note 10/11/2005*/
    END.  /*Then fi_agent <> ""*/
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_base
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_base c-Win
ON LEAVE OF fi_base IN FRAME fr_main
DO:
  fi_base  =  Input  fi_base.
  Disp  fi_base  with  frame  fr_main.
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
    fi_branch = INPUT fi_branch.
    IF  Input fi_branch  =  ""  Then do:
        Message "กรุณาระบุ Branch Code ." View-as alert-box.
        Apply "Entry"  To  fi_branch.
    END.
    Else do:
        FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
            sicsyac.xmm023.branch   =  Input  fi_branch NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
            Message  "Not on Description Master File xmm023" 
                View-as alert-box.
            Apply "Entry"  To  fi_branch.
            RETURN NO-APPLY.
        END.
        ASSIGN fi_branch  =  CAPS(Input fi_branch)  
            fi_brndes  =  sicsyac.xmm023.bdes .
    END.  /*else do:*/
    Disp fi_branch  fi_brndes  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brandset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brandset c-Win
ON LEAVE OF fi_brandset IN FRAME fr_main
DO:
    fi_brandset  =  Input  fi_brandset .
    Disp  fi_brandset  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod c-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
    fi_covcod  = Input  fi_covcod.
    IF fi_covcod <> "" THEN DO:
        MESSAGE "You use covcod : " fi_covcod "ต้องการนำเข้าประเภท " + fi_covcod + "  !!!!"        
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
            TITLE "" UPDATE choice AS LOGICAL.
        CASE choice:         
            WHEN TRUE THEN /* Yes */ 
                DO: 
                IF fi_covcod = "1"  THEN
                    ASSIGN 
                    fi_base   = 2500
                    fi_deduct = 500
                    fi_fleet  = 10
                    fi_ncb    = 50
                    fi_411    = 100000
                    fi_412    = 100000
                    fi_43     = 0.
                ELSE IF fi_covcod = "3"  THEN 
                    ASSIGN 
                    fi_base   = 900        
                    fi_deduct = 0         
                    fi_fleet  = 10          
                    fi_ncb    = 40          
                    fi_411    = 100000      
                    fi_412    = 100000      
                    fi_43     = 0. 
                ELSE ASSIGN 
                    fi_base   = 0       
                    fi_deduct = 0         
                    fi_fleet  = 0          
                    fi_ncb    = 0         
                    fi_411    = 0     
                    fi_412    = 0     
                    fi_43     = 0. 

                Disp  fi_covcod fi_base fi_deduct fi_fleet fi_ncb fi_411 fi_412  fi_43   WITH FRAME fr_main.

                APPLY "entry" TO fi_branch.
                RETURN NO-APPLY. 
            END.
            WHEN FALSE THEN /* No */          
                DO:   
                APPLY "entry" TO fi_covcod.
                RETURN NO-APPLY.
            END.
            /*OTHERWISE /* Cancel */             
            STOP.*/
        END CASE.
    END.
    Disp  fi_covcod fi_base fi_deduct fi_fleet fi_ncb fi_411 fi_412  fi_43   WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_deduct
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deduct c-Win
ON LEAVE OF fi_deduct IN FRAME fr_main
DO:
  fi_deduct  =  Input  fi_deduct.
  Disp fi_deduct  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filenameHD
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filenameHD c-Win
ON LEAVE OF fi_filenameHD IN FRAME fr_main
DO:
  fi_filenameHD = INPUT fi_filenameHD.
  DISP fi_filenameHD WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_fleet
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_fleet c-Win
ON LEAVE OF fi_fleet IN FRAME fr_main
DO:
  fi_fleet  =  Input  fi_fleet.
  Disp fi_fleet  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insurno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insurno c-Win
ON LEAVE OF fi_insurno IN FRAME fr_main
DO:
    fi_insurno = INPUT fi_insurno.
    IF fi_insurno <> ""    THEN DO:
        FIND FIRST  sicsyac.xtm600  USE-INDEX  xtm60001 WHERE
            sicsyac.xtm600.acno =   fi_insurno     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xtm600 THEN  
            ASSIGN  
            nn_acno      =  trim(sicsyac.xtm600.acno)  
            nn_name      =  trim(sicsyac.xtm600.name)  
            nn_name2     =  ""
            nn_name3     =  ""  
            nn_addr1     =  trim(sicsyac.xtm600.addr1) 
            nn_addr2     =  trim(sicsyac.xtm600.addr2) 
            nn_addr3     =  trim(sicsyac.xtm600.addr3) 
            nn_addr4     =  trim(sicsyac.xtm600.addr4) 
            nn_ntitle    =  trim(sicsyac.xtm600.ntitle) 
            fi_insurno   =  trim(sicsyac.xtm600.acno) 
            /*comment by Kridtiyai...A54-0188
            wdetail.n_insured =  "0C17962"  
            wdetail.tiname    =   "บริษัท"  
            end...comment by Kridtiyai...A54-0188 */
            fi_insurnam  =  TRIM(sicsyac.xtm600.ntitle) + "  "  + trim(sicsyac.xtm600.name)  .
        
        ELSE DO: 
            Message  "Not on Name & Address Master File xtm600"  View-as alert-box.
            Apply "Entry" To  fi_insurno.
            RETURN NO-APPLY. /*note add on 10/11/2005*/
            ASSIGN 
                nn_acno    =  "0C17962" 
                nn_name    =  "ยาคูลท์เซลส์ (กรุงเทพฯ) จำกัด"  
                nn_name2   =  ""
                nn_name3   =  ""  
                nn_addr1   =  "1025 อาคารยาคูลท์ ชั้น 16"  
                nn_addr2   =  "ถนนพหลโยธิน แขวงสามเสนใน"   
                nn_addr3   =  "เขตพญาไท กรุงเทพมหานคร"     
                nn_addr4   =  ""                           
                nn_ntitle  =  "บริษัท"  
                fi_insurno =  "0C17962" 
           /*comment by Kridtiyai...A54-0188
            wdetail.n_insured =  "0C17962"  
            wdetail.tiname    =   "บริษัท"  
            end...comment by Kridtiyai...A54-0188 */
                fi_insurnam  = "".
        END.  /*end note 10/11/2005*/
    END.     /*Then fi_insurno <> ""*/
    Disp fi_insurno fi_insurnam  WITH Frame  fr_main.                 
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


&Scoped-define SELF-NAME fi_ncb
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ncb c-Win
ON LEAVE OF fi_ncb IN FRAME fr_main
DO:
  fi_ncb  =  Input  fi_ncb.
  Disp fi_ncb  with  frame  fr_main.
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
    /*ASSIGN fi_producer = "B300029".*/
    fi_producer = INPUT fi_producer.
    IF  fi_producer <> " " THEN DO:
        FIND LAST  sicsyac.xmm600 USE-INDEX xmm60001  WHERE
            sicsyac.xmm600.acno  =  Input fi_producer NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_producer.
            RETURN NO-APPLY.   /*note add on 10/11/2005*/
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


&Scoped-define SELF-NAME fi_redbookset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_redbookset c-Win
ON LEAVE OF fi_redbookset IN FRAME fr_main
DO:
    fi_redbookset  =  Input  fi_redbookset .
    Disp fi_redbookset with  frame  fr_main.
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
  DISP ra_typefile WITH FRAM fr_main.
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
  ASSIGN 
      gv_prgid = "Wgwycgen" 
      gv_prog  = "Load Text & Generate ยาคูลท์"
      fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN proc_createcomp.
  OPEN QUERY br_comp FOR EACH wcomp.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).  /*28/11/2006*/
  ASSIGN
      fi_pack     = "E"
      fi_base     = 0
      fi_deduct   = 0
      fi_fleet    = 0
      fi_ncb      = 0
      fi_411      = 0
      fi_412      = 0
      fi_43       = 0
      fi_branch   = "0"
      fi_producer = "B300029"
      fi_agent    = "B300029"
      fi_insurno  = "0C17962" 
      ra_typefile = 2                /*A57-0430*/
      fi_process  = "Load Text file Yakulte to GW..."
      fi_filenameHD = "D:\Temp\DATA_HeadReportYakult.csv"    /*Add by Kridtiya i. A63-0472*/
      fi_bchyr    = YEAR(TODAY) .
  DISP fi_pack fi_branch fi_producer fi_agent fi_bchyr fi_covcod fi_insurno fi_process ra_typefile  /*A57-0430*/
       fi_base fi_deduct fi_fleet fi_ncb fi_411 fi_412  fi_43  fi_filenameHD  WITH FRAME fr_main.
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
  DISPLAY ra_typefile fi_loaddat fi_pack fi_covcod fi_brandset fi_redbookset 
          fi_branch fi_producer fi_bchno fi_agent fi_insurno fi_prevbat fi_bchyr 
          fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem 
          fi_brndes fi_impcnt fi_proname fi_agtname fi_insurnam fi_completecnt 
          fi_process fi_premtot fi_premsuc fi_base fi_deduct fi_fleet fi_ncb 
          fi_411 fi_412 fi_43 fi_filenameHD 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE bu_exphd ra_typefile fi_loaddat fi_pack fi_covcod fi_brandset 
         fi_redbookset bu_add bu_del fi_branch fi_producer fi_agent fi_insurno 
         fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 
         fi_output3 fi_usrcnt fi_usrprem buok bu_exit bu_hpbrn bu_hpacno1 
         bu_hpagent bu_insured fi_process br_wdetail br_comp fi_base fi_deduct 
         fi_fleet fi_ncb fi_411 fi_412 fi_43 fi_filenameHD RECT-370 RECT-372 
         RECT-373 RECT-374 RECT-376 RECT-377 RECT-378 
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
ASSIGN wdetail.compul = "y"
    wdetail.tariff    = "9"
    wdetail.covcod    = "T".
IF wdetail.subclass = "" THEN DO:
    IF deci(wdetail.engcc) <= 75 THEN 
        ASSIGN wdetail.subclass =  "130A" 
        wdetail.comp_prm = "150".
    ELSE IF (deci(wdetail.engcc) > 75) AND (deci(wdetail.engcc) <= 125) THEN 
        ASSIGN wdetail.subclass =  "130B" 
        wdetail.comp_prm = "300". 
    ELSE IF (deci(wdetail.engcc) > 125) AND (deci(wdetail.engcc) <= 150) THEN 
        ASSIGN wdetail.subclass =  "130C" 
        wdetail.comp_prm = "400". 
    ELSE IF deci(wdetail.engcc) > 150  THEN 
        ASSIGN wdetail.subclass =  "130D" 
        wdetail.comp_prm = "600". 
    IF wdetail.compul <> "y" THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N". 
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
            wdetail.OK_GEN  = "N".
    END.
END.
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class = wdetail.subclass  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
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
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass = "N"
    wdetail.comment      = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
    wdetail.OK_GEN       = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
    wdetail.OK_GEN = "N".
/*--------- modcod --------------*/
ASSIGN chkred = NO.
IF wdetail.redbook = "" THEN DO:
    FIND LAST wcomp WHERE wcomp.brand = trim(wdetail.brand) NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wcomp THEN
        ASSIGN wdetail.redbook = wcomp.redbook.
    ELSE DO:
        IF wdetail.brand = "HONDA" THEN 
            ASSIGN wdetail.brand = "honda"
            wdetail.redbook      = "HO88". 
        IF wdetail.brand = "SUZUKI"   THEN  wdetail.redbook  = "ZU00".  
        IF wdetail.brand = "KAWASAKI" THEN  wdetail.redbook  = "KA03". 
        IF wdetail.brand = "YAMAHA"   THEN  wdetail.redbook  = "YA00". 
    END.
    /*END.*/
/*
ELSE DO:
    FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
        sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm102 THEN DO:
        ASSIGN  wdetail.pass = "N"  
            wdetail.comment  = wdetail.comment + "| not find on table xmm102"
            wdetail.OK_GEN   = "N"
            chkred           = NO
            wdetail.redbook  = " ".
    END. 
    ELSE DO:
        chkred = YES.
    END.
END.*/
/*IF chkred = NO  THEN DO:*/
    
    FIND LAST sicsyac.xmm102   WHERE 
        index(sicsyac.xmm102.modest,wdetail.brand) <> 0   AND 
        sicsyac.xmm102.modcod = wdetail.redbook    /*A57-0042*/
        NO-LOCK NO-ERROR.  
        /* AND sicsyac.xmm102.engine = INTE(wdetail.engcc) AND 
        sicsyac.xmm102.tons   = 0 */                  
    /*comment by ...Kridtiya i. A56-0072..
    IF NOT AVAIL sicsyac.xmm102  THEN DO:
        ASSIGN wdetail.pass = "N"  
            wdetail.comment = wdetail.comment + "| not find on table xmm102"
            wdetail.OK_GEN  = "N".
    END.
    ELSE DO:
        wdetail.redbook = sicsyac.xmm102.modcod. 
    END.
    end...Kridtiya i. A56-0072...*/
    IF AVAIL sicsyac.xmm102 THEN wdetail.redbook = sicsyac.xmm102.modcod.   /*Kridtiya i. A56-0072..*/
    ELSE wdetail.redbook = "" .                                             /*Kridtiya i. A56-0072..*/
    IF wdetail.redbook = ""  THEN DO:
        FIND LAST sicsyac.xmm102 WHERE 
            sicsyac.xmm102.modest = wdetail.brand  NO-LOCK NO-ERROR.
        IF NOT AVAIL sicsyac.xmm102  THEN DO:
            ASSIGN wdetail.pass = "N"  
                wdetail.comment = wdetail.comment + "| not find on table xmm102"
                wdetail.OK_GEN  = "N".
        END.
        ELSE DO:
            wdetail.redbook = sicsyac.xmm102.modcod. 
        END.
    END.
END.
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001     WHERE
    sicsyac.sym100.tabcod = "U014"         AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
    wdetail.OK_GEN  = "N".
ASSIGN nv_docno = " "
    nv_accdat   = TODAY.
/***--- Docno ---***/
IF wdetail.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M" AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999")  NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN 
        ASSIGN wdetail.pass    = "N"  
        wdetail.comment = "Receipt is Dup. on uwm100 :"     + string(sicuw.uwm100.policy,"x(16)") +
                          STRING(sicuw.uwm100.rencnt,"99")  + "/" +
                          STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
        wdetail.OK_GEN  = "N".
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
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND 
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND 
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND 
    sic_bran.uwm130.riskgp = s_riskgp               AND  /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND  /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND  /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr             AND  /*26/10/2006 change field name */
    sic_bran.uwm130.bchno  = nv_batchno             AND  /*26/10/2006 change field name */ 
    sic_bran.uwm130.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno.
    ASSIGN  sic_bran.uwm130.bchyr = nv_batchyr    /* batch Year */
        sic_bran.uwm130.bchno     = nv_batchno    /* bchno      */
        sic_bran.uwm130.bchcnt    = nv_batcnt .   /* bchcnt     */
    ASSIGN  sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0     /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0     /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0     /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0     /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.    /*Item Endt. Clause*/
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  
        sicsyac.xmm016.class =   sic_bran.uwm120.class NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN 
        ASSIGN  sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
        sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9 
        nv_comper     = deci(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc     = deci(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v   = nv_comper   
        sic_bran.uwm130.uom9_v   = nv_comacc  .   
    ASSIGN  nv_riskno = 1
        nv_itemno     = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy,         
                                nv_riskno,
                                nv_itemno).
END.
/*transaction*/
ASSIGN
s_recid3  = RECID(sic_bran.uwm130)
/* ---------------------------------------------  U W M 3 0 1 --------------*/ 
nv_covcod =   wdetail.covcod
nv_makdes  =  wdetail.brand
nv_moddes  =  wdetail.model
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
    sic_bran.uwm301.bchyr = nv_batchyr               AND 
    sic_bran.uwm301.bchno = nv_batchno               AND 
    sic_bran.uwm301.bchcnt  = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
    DO TRANSACTION:
        CREATE sic_bran.uwm301.
    END.   /*transaction*/
END.
Assign 
    sic_bran.uwm301.policy   = sic_bran.uwm120.policy                   
    sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
    sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
    sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
    sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
    sic_bran.uwm301.itemno   = s_itemno
    sic_bran.uwm301.tariff   = wdetail.tariff
    sic_bran.uwm301.covcod   = wdetail.covcod
    sic_bran.uwm301.cha_no   = wdetail.chasno
    sic_bran.uwm301.eng_no   = wdetail.eng
    sic_bran.uwm301.Tons     = INTEGER(wdetail.tons)
    sic_bran.uwm301.engine   = INTEGER(wdetail.engcc)
    sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage   = wdetail.garage
    sic_bran.uwm301.body     = wdetail.body
    sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv_ben83 = wdetail.benname
    sic_bran.uwm301.vehreg   = wdetail.vehreg 
    sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
    sic_bran.uwm301.vehuse   = wdetail.vehuse
    sic_bran.uwm301.moddes   = trim(wdetail.brand + " " + wdetail.model)     
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
    FIND FIRST brStat.Detaitem USE-INDEX detaitem11     WHERE
        brStat.Detaitem.serailno   = wdetail.stk         AND 
        brstat.detaitem.yearReg    = nv_batchyr          AND
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
ELSE sic_bran.uwm301.drinam[9] = "".
s_recid4  = RECID(sic_bran.uwm301).
IF wdetail.redbook <> "" THEN DO:      /*กรณีที่มีการระบุ Code รถมา*/
    FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
        sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm102 THEN DO:
        ASSIGN  sic_bran.uwm301.modcod              = sicsyac.xmm102.modcod
            /*Substring(sic_bran.uwm301.moddes,1,18)  = SUBSTRING(xmm102.modest, 1,18)  /*Thai language*/  
            Substring(sic_bran.uwm301.moddes,19,22) = SUBSTRING(xmm102.modest,19,22)  /*Thai Language*/*/
            sic_bran.uwm301.moddes         = xmm102.modest
            sic_bran.uwm301.Tons           = sicsyac.xmm102.tons
            /*sic_bran.uwm301.engine         = wdetail.engcc */    /* sicsyac.xmm102.engine*/
            sic_bran.uwm301.moddes         = sicsyac.xmm102.modest
            sic_bran.uwm301.seats          = sicsyac.xmm102.seats
            sic_bran.uwm301.vehgrp         = sicsyac.xmm102.vehgrp
            sic_bran.uwm301.body           = sicsyac.xmm102.body
            wdetail.engcc                  = string(sicsyac.xmm102.engine)
            /* wdetail.seat                   = sicsyac.xmm102.seats*/
            wdetail.redbook                = sicsyac.xmm102.modcod
            /*wdetail.brand                  = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/
            wdetail.model                  = SUBSTRING(xmm102.modest,19,22)*/   .  /*Thai*/
    END.
END.
ELSE DO:
    FIND LAST sicsyac.xmm102 WHERE sicsyac.xmm102.modest = trim(wdetail.brand)  NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm102  THEN DO:
        ASSIGN  sic_bran.uwm301.modcod               = sicsyac.xmm102.modcod
            /*Substring(sic_bran.uwm301.moddes,1,18)   = SUBSTRING(xmm102.modest, 1,18)  /*Thai language*/  
            Substring(sic_bran.uwm301.moddes,19,22)  = SUBSTRING(xmm102.modest,19,22)  /*Thai Language*/*/
            sic_bran.uwm301.moddes         = xmm102.modest
            sic_bran.uwm301.Tons           = sicsyac.xmm102.tons
            /*sic_bran.uwm301.engine         = wdetail.engcc */    /*sicsyac.xmm102.engine*/
            sic_bran.uwm301.moddes         = sicsyac.xmm102.modest
            sic_bran.uwm301.seats          = sicsyac.xmm102.seats
            sic_bran.uwm301.vehgrp         = sicsyac.xmm102.vehgrp
            sic_bran.uwm301.body           = sicsyac.xmm102.body
            /*wdetail.engcc                  = string(sicsyac.xmm102.engine)*/
            wdetail.seat                   =  sicsyac.xmm102.seats 
            wdetail.redbook                = sicsyac.xmm102.modcod
            /*wdetail.brand                  = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/
            wdetail.model                  = SUBSTRING(xmm102.modest,19,22)*/  .  /*Thai*/
    END.
END.
FIND sic_bran.uwd132  USE-INDEX uwd13201     WHERE
    sic_bran.uwd132.policy = wdetail.policy  AND
    sic_bran.uwd132.rencnt = n_rencnt        AND
    sic_bran.uwd132.endcnt = n_endcnt        AND
    sic_bran.uwd132.riskgp = 0               AND
    sic_bran.uwd132.riskno = 1               AND
    sic_bran.uwd132.itemno = 1               AND
    sic_bran.uwd132.bchyr  = nv_batchyr      AND
    sic_bran.uwd132.bchno  = nv_batchno      AND
    sic_bran.uwd132.bchcnt = nv_batcnt       NO-ERROR NO-WAIT.
IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
    IF LOCKED sic_bran.uwd132 THEN DO:
        MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wdetail.policy 
                "ไม่สามารถ Generage ข้อมูลได้".
        NEXT.
    END.
    CREATE sic_bran.uwd132.
END.
ASSIGN  /*wdetail.comp_prm = string(TRUNCATE(((deci(wdetail.comp_prm)  * 100 ) / 107.43),0))*/
    sic_bran.uwd132.bencod  = "COMP"                   /*Benefit Code*/
    sic_bran.uwd132.benvar  = ""                       /*Benefit Variable*/
    sic_bran.uwd132.rate    = 0                        /*Premium Rate %*/
    sic_bran.uwd132.gap_ae  = NO                       /*GAP A/E Code*/
    sic_bran.uwd132.gap_c   = deci(wdetail.comp_prm)   /*deci(wdetail.premt)*//*GAP, per Benefit per Item*/
    sic_bran.uwd132.dl1_c   = 0                        /*Disc./Load 1,p. Benefit p.Item*/
    sic_bran.uwd132.dl2_c   = 0                        /*Disc./Load 2,p. Benefit p.Item*/
    sic_bran.uwd132.dl3_c   = 0                        /*Disc./Load 3,p. Benefit p.Item*/
    sic_bran.uwd132.pd_aep  = "E"                      /*Premium Due A/E/P Code*/
    sic_bran.uwd132.prem_c  = deci(wdetail.comp_prm)   /*PD, per Benefit per Item*/
    sic_bran.uwd132.fptr    = 0                        /*Forward Pointer*/
    sic_bran.uwd132.bptr    = 0                        /*Backward Pointer*/
    sic_bran.uwd132.policy  = wdetail.policy           /*Policy No. - uwm130*/
    sic_bran.uwd132.rencnt  = n_rencnt                 /*Renewal Count - uwm130*/
    sic_bran.uwd132.endcnt  = n_endcnt                 /*Endorsement Count - uwm130*/
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
    nv_prem    = 0 .
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = nv_rec301 NO-WAIT NO-ERROR.
IF sic_bran.uwm130.fptr03 = 0 OR sic_bran.uwm130.fptr03 = ? THEN DO:
    FIND sicsyac.xmm107 USE-INDEX xmm10701      WHERE
        sicsyac.xmm107.class  = wdetail.subclass  AND
        sicsyac.xmm107.tariff = wdetail.tariff    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xmm107 THEN DO:
        FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmd107 THEN DO:
            CREATE sic_bran.uwd132.
            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                sicsyac.xmm016.class = wdetail.subclass  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm016 THEN 
                ASSIGN sic_bran.uwd132.gap_ae = NO
                sic_bran.uwd132.pd_aep = "E".
            ASSIGN 
                sic_bran.uwd132.bencod = sicsyac.xmd107.bencod   sic_bran.uwd132.policy = wdetail.policy
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
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.tons).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = uwd132.bencod    AND
                    sicsyac.xmm106.class   = wdetail.subclass AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= nv_key_a         AND
                    sicsyac.xmm106.key_b  >= nv_key_b         AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    ASSIGN   
                        sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                        sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                        /*sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm)
                        sic_bran.uwd132.prem_c = deci(wdetail.comp_prm)*/
                        nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                        sic_bran.uwd132.gap_c  = nv_prem
                        sic_bran.uwd132.prem_c = nv_prem
                        /*nv_gap                 = deci(wdetail.comp_prm)
                        nv_prem                = deci(wdetail.comp_prm)*/  .
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
                    sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap. 
                    sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap. 
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                               RECID(sic_bran.uwd132),
                                               sic_bran.uwm301.tariff).
                    ASSIGN nv_gap     = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c
                        sic_bran.uwd132.gap_c  = nv_prem
                        sic_bran.uwd132.prem_c = nv_prem
                        /*nv_gap        = deci(wdetail.comp_prm)
                        nv_prem       = deci(wdetail.comp_prm)*/   .
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
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.tons).
                    nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff         AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod AND
                        sicsyac.xmm106.class   = wdetail.subclass       AND
                        sicsyac.xmm106.covcod  = wdetail.covcod         AND
                        sicsyac.xmm106.key_a  >= nv_key_a               AND
                        sicsyac.xmm106.key_b  >= nv_key_b               AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE sicsyac.xmm106 THEN DO:
                        ASSIGN    
                            sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                            sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                            /*sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm)
                            sic_bran.uwd132.prem_c = deci(wdetail.comp_prm)*/
                            nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                            nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                            sic_bran.uwd132.gap_c  = nv_prem
                            sic_bran.uwd132.prem_c = nv_prem
                            /*nv_gap                 = deci(wdetail.comp_prm)
                            nv_prem                = deci(wdetail.comp_prm)*/   .
                    END.
                END.
                ELSE DO:
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601          WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff           AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.subclass         AND
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
                        /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap. 
                        sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm).*/
                        sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap. 
                        sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap. 
                        RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                             RECID(sic_bran.uwd132),
                                             sic_bran.uwm301.tariff).
                        nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                        sic_bran.uwd132.gap_c  = nv_prem.
                        sic_bran.uwd132.prem_c = nv_prem.
                        /*nv_gap        = deci(wdetail.comp_prm).
                        nv_prem       = deci(wdetail.comp_prm).*/
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
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.tons).
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
                    ASSIGN   sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap 
                        /*sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm)
                        sic_bran.uwd132.prem_c = deci(wdetail.comp_prm)*/
                        nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                        sic_bran.uwd132.gap_c  = nv_prem
                        sic_bran.uwd132.prem_c = nv_prem
                        /*nv_gap                 = deci(wdetail.comp_prm)
                        nv_prem                = deci(wdetail.comp_prm)*/   .
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
                    /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.    
                     sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm).*/
                    sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap. 
                    sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap. 
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100),         
                                         RECID(sic_bran.uwd132),                
                                         sic_bran.uwm301.tariff).
                    ASSIGN
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c
                        sic_bran.uwd132.gap_c  = nv_prem
                        sic_bran.uwd132.prem_c = nv_prem
                    /*nv_gap                 = deci(wdetail.comp_prm)
                    nv_prem                = deci(wdetail.comp_prm)*/    .
                END.
            END.
        END.
    END.
END.
/*
MESSAGE wdetail.policy nv_gap  
        nv_prem  VIEW-AS alert-box.*/

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
    nv_tax_per = 7.0 .
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
              
               
              /* IF SUBSTR(sic_bran.uwd132.bencod,1,3) = "GRP" AND wdetail.cargrp <> "" THEN DO:
                   ASSIGN   sic_bran.uwd132.bencod = nv_grpcod
                            sic_bran.uwd132.benvar = nv_grpvar .
               END.*/
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
    /*comment by Kridtiya i. A55-0182...
    For each  wdetail2 :
    DELETE  wdetail2.
    END.  end...comment by Kridtiya i. A55-0182..*/
    ASSIGN fi_process = "Create data to file ".
    DISP fi_process WITH FRAM fr_main.
    FOR EACH   wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        /*CREATE wdetail2.*//*Kridtiya i. A55-0182....*/
        IMPORT DELIMITER "|" 
            /*/*Kridtiya i. A55-0182....*/
            wdetail2.number      /*1  No./ลำดับ   */        
            wdetail2.prepol      /*2  กธ.พรบเดิม/กรมธรรม์เดิม  */   
            wdetail2.policyno    /*3  กรม / พรบ.  *//*A53-0370*/   
            wdetail2.tax_dat     /*4  วันเสียภาษี */     
            wdetail2.comcode     /*5  เซ็นเตอร์   */     
            wdetail2.Key_ID      /*6  key.id      */
            wdetail2.tiname      /*7  title       */
            wdetail2.insnam      /*8  ชื่อ        */
            wdetail2.name2       /*9  นามสกุล     */
            wdetail2.brand       /*10 ยี่ห้อ      */
            wdetail2.engcc       /*11 ซีซี        */
            wdetail2.vehreg      /*12 ทะเบียน     */     
            wdetail2.re_country  /*13 จ.ว.ทะเบียน */
            wdetail2.chasno      /*14 หมายเลขตัวถังรถ */
            wdetail2.caryear     /*15 ปี พศ.          */            
            wdetail2.comdat      /*16 วดป.ประกัน      */      
            wdetail2.expdat      /*17 วันที่สิ้นสุดความคุ้มครอง expidate เพิ่มกรมช่อง expirydate.*//*A53-0370*/ 
            wdetail2.n_STATUS    /*18 ต่อ  หมายเหตุ (ต่อ/ใหม่) */   
            /*wdetail.policyno   /*19 กรมธรรม์v70ใหม่ เพิ่มกรมช่องที่ 1 *//*A53-0370*/  */                       
            wdetail2.mem1        /*20 D-0-70-53/013918      */                                    
            wdetail2.mem2        /*21 แทนคันเก่า            */           
            wdetail2.mem3 */     /*22 No.1                  *//*Kridtiya i. A55-0182....*/
            /*Add..Kridtiya i. A55-0182....*/
            as_number    
            as_prepol     
            as_policyno  
            as_tax_dat   
            as_comcode   
            as_Key_ID    
            as_tiname    
            as_insnam    
            as_name2     
            as_brand     
            as_engcc     
            as_vehreg    
            as_re_country
            as_chasno    
            as_caryear   
            as_comdat    
            as_expdat    
            /*as_n_STATUS  /*A57-0430*/ 
            as_mem1        /*A57-0430*/ 
            as_mem2        /*A57-0430*/ 
            as_mem3*/      /*A57-0430*/ 
            as_sumins      /*A57-0430*/   
            as_texF17_1    /*A57-0430*/   
            as_texF17_2    /*A57-0430*/   
            as_texF17_3    /*A57-0430*/   
            as_texF18_1    /*A57-0430*/   
            as_texF18_2    /*A57-0430*/   
            as_texF18_3    /*A57-0430*/   
            as_texF6_1     /*A57-0430*/   
            as_texF6_2     /*A57-0430*/   
            as_texF6_3     /*A57-0430*/
            as_texF6_4     /*A57-0430*/ 
            as_texF6_5 .    /*A57-0430*/ 
        /*end..add ... Kridtiya i. A55-0182....*/
        IF      INDEX(as_number,"รายการ") <> 0 THEN RUN proc_assigninitdata.
        ELSE IF INDEX(as_number,"ประกัน") <> 0 THEN RUN proc_assigninitdata.
        ELSE IF INDEX(as_number,"ลำดับ")  <> 0 THEN RUN proc_assigninitdata.
        ELSE IF INDEX(as_number,"ขอต่อ")  <> 0 THEN RUN proc_assigninitdata.
        ELSE IF INDEX(as_number,"no")     <> 0 THEN RUN proc_assigninitdata.
        ELSE IF trim(as_policyno)         = "" THEN RUN proc_assigninitdata.
        ELSE RUN proc_assign11.
        /*comment by Kridtiya i A57-0042...
        ASSIGN as_number  = ""    
            as_prepol     = ""     
            as_policyno   = ""    
            as_tax_dat    = ""    
            as_comcode    = ""    
            as_Key_ID     = ""    
            as_tiname     = ""    
            as_insnam     = ""    
            as_name2      = ""    
            as_brand      = ""    
            as_engcc      = ""    
            as_vehreg     = ""     
            as_re_country = ""    
            as_chasno     = ""    
            as_caryear    = ""    
            as_comdat     = ""    
            as_expdat     = ""    
            as_n_STATUS   = ""    
            as_mem1       = ""    
            as_mem2       = ""    
            as_mem3       = "".
            end.... comment by Kridtiya i. A57-0042 ....*/
    END.    /* repeat  */            
   /* FOR EACH wdetail2 .
        IF INDEX(wdetail2.number,"รายการ") <> 0      THEN DELETE wdetail2.
        ELSE IF INDEX(wdetail2.number,"ประกัน") <> 0 THEN DELETE wdetail2.
        ELSE IF INDEX(wdetail2.number,"ลำดับ") <> 0  THEN DELETE wdetail2.
        ELSE IF INDEX(wdetail2.number,"ขอต่อ") <> 0  THEN DELETE wdetail2.
        ELSE IF INDEX(wdetail2.number,"no") <> 0     THEN DELETE wdetail2.
    END.*/
    /*IF fi_covcod = "T" THEN DO:
        FOR EACH wdetail .
            ASSIGN wdetail.policyno = wdetail.pol_stk.
            RUN proc_cutchar.
        END.
    END.  */  
    /*FOR EACH wdetail2 NO-LOCK.
        FIND FIRST wdetail WHERE wdetail.policy = trim(wdetail2.policyno)  NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail  THEN DO:
            CREATE wdetail.   /*create wdetail .......... */
            ASSIGN 
                wdetail.policy    =  trim(wdetail2.policyno)    /*3  กรม / พรบ.  *//*A53-0370*/   
                wdetail.poltyp    =  "V" + IF fi_covcod = "T" THEN "72" ELSE "70"
                wdetail.covcod    =  fi_covcod
                wdetail.prepol    =  trim(wdetail2.prepol)      /*2  กธ.พรบเดิม/กรมธรรม์เดิม  */   
                wdetail.tiname    =  trim(wdetail2.tiname)      /*7  title       */
                wdetail.name2     =  "(คุณ" +  trim(wdetail2.insnam)  + " " + TRIM(wdetail2.name2) + " " + TRIM(wdetail2.number) + ")"   
                wdetail.brand     =  trim(wdetail2.brand)       /*10 ยี่ห้อ      */
                wdetail.engcc     =  trim(wdetail2.engcc)       /*11 ซีซี        */
                wdetail.vehreg    =  trim(wdetail2.vehreg)      /*12 ทะเบียน     */     
                wdetail.re_country  =  trim(wdetail2.re_country)  /*13 จ.ว.ทะเบียน */
                wdetail.chasno    =  trim(wdetail2.chasno)      /*14 หมายเลขตัวถังรถ */
                wdetail.caryear   =  trim(wdetail2.caryear)     /*15 ปี พศ.          */            
                wdetail.comdat    =  trim(wdetail2.comdat)      /*16 วดป.ประกัน      */      
                wdetail.expdat    =  trim(wdetail2.expdat)      /*17 วันที่สิ้นสุดความคุ้มครอง expidate เพิ่มกรมช่อง expirydate.*//*A53-0370*/ 
                wdetail.comment     = ""
                wdetail.agent       = trim(fi_agent)
                wdetail.producer    = trim(fi_producer)     
                wdetail.entdat      = string(TODAY)                /*entry date*/
                wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
                wdetail.trandat     = STRING (fi_loaddat)          /*tran date*/
                wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
                wdetail.n_IMPORT    = "IM"
                wdetail.n_EXPORT    = "" .
        END.
    END.*/
    RUN proc_assign2. 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign11 c-Win 
PROCEDURE proc_assign11 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.policy = trim(as_policyno)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail  THEN DO:
    ASSIGN fi_process = "Create Data ..."  + trim(as_policyno).
    DISP fi_process WITH FRAM fr_main.
    CREATE wdetail.                                 /*create wdetail ..........   */
    ASSIGN 
        wdetail.policy     = trim(as_policyno)      /*3  กรม / พรบ.  *//*A53-0370 */   
        wdetail.poltyp     = "V" + IF fi_covcod = "T" THEN "72" ELSE "70"
        wdetail.covcod     = trim(fi_covcod)
        wdetail.prepol     = trim(as_prepol)        /*2  กธ.พรบเดิม/กรมธรรม์เดิม  */   
        wdetail.tiname     = trim(as_tiname)        /*7  title                    */
        /*wdetail.name2      = "(คุณ" +  trim(as_insnam)  + " " + trim(TRIM(as_name2)   + " " + TRIM(as_number)) + ")"*/ 
        wdetail.name2      = IF (trim(as_insnam)  + " " + trim(TRIM(as_name2)   + " " + TRIM(as_number))) = "" THEN ""      /*A57-0108*/
                             ELSE "(คุณ" +  trim(as_insnam)  + " " + trim(TRIM(as_name2)   + " " + TRIM(as_number)) + ")"   /*A57-0108*/
        wdetail.brand      = trim(as_brand)              /*10 ยี่ห้อ      */
        wdetail.engcc      = trim(as_engcc)              /*11 ซีซี        */
        wdetail.vehreg     = trim(as_vehreg)             /*12 ทะเบียน     */     
        wdetail.re_country = trim(as_re_country)         /*13 จ.ว.ทะเบียน */
        wdetail.chasno     = trim(as_chasno)             /*14 หมายเลขตัวถังรถ */
        wdetail.caryear    = trim(as_caryear)            /*15 ปี พศ.          */            
        wdetail.comdat     = trim(as_comdat)             /*16 วดป.ประกัน      */      
        wdetail.expdat     = trim(as_expdat)             /*17 วันที่สิ้นสุดความคุ้มครอง expidate เพิ่มกรมช่อง expirydate.*//*A53-0370*/ 
        wdetail.si         = deci(as_sumins)     /*A57-0430*/   
        wdetail.comment    = ""                          
        wdetail.agent      = caps(trim(fi_agent))        
        wdetail.producer   = caps(trim(fi_producer))     
        wdetail.entdat     = string(TODAY)               /*entry date*/
        wdetail.enttim     = STRING(TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat    = STRING(fi_loaddat)          /*tran date*/
        wdetail.trantim    = STRING(TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT   = "IM"
        wdetail.n_EXPORT   = "" .
    /*add by kridtiya i...A57-0430*/ 
    IF  trim(as_texF17_1) <> "" OR trim(as_texF17_2) <> "" OR trim(as_texF17_3) <> "" THEN DO:
        FIND LAST wtext17 WHERE wtext17.as_policyF17  = trim(as_policyno)  NO-ERROR NO-WAIT.
        IF NOT AVAIL wtext17 THEN DO:
            CREATE wtext17.
            ASSIGN 
                wtext17.as_policyF17  = trim(as_policyno) 
                wtext17.as_texF17_1   = trim(as_texF17_1)     
                wtext17.as_texF17_2   = trim(as_texF17_2)    
                wtext17.as_texF17_3   = trim(as_texF17_3).  
        END.
    END.
    IF  trim(as_texF18_1) <> "" OR trim(as_texF18_2) <> "" OR trim(as_texF18_3) <> ""  THEN DO:
        FIND LAST wtext18 WHERE wtext18.as_policyF18 = trim(as_policyno) NO-ERROR NO-WAIT.
        IF NOT AVAIL wtext18 THEN DO:
            CREATE wtext18.
            ASSIGN 
                wtext18.as_policyF18  = trim(as_policyno)
                wtext18.as_texF18_1   = trim(as_texF18_1)       
                wtext18.as_texF18_2   = trim(as_texF18_2)      
                wtext18.as_texF18_3   = trim(as_texF18_3).   
        END.
    END.
    IF  trim(as_texF6_1) <> "" OR trim(as_texF6_2) <> "" OR trim(as_texF6_3) <> "" THEN DO:
        FIND LAST wtext6 WHERE wtext6.as_policyF6 = trim(as_policyno) NO-ERROR NO-WAIT.
        IF NOT AVAIL wtext6 THEN DO:
            CREATE wtext6.
            ASSIGN 
                wtext6.as_policyF6    = trim(as_policyno)
                wtext6.as_texF6_1    = trim(as_texF6_1)      
                wtext6.as_texF6_2    = trim(as_texF6_2)     
                wtext6.as_texF6_3    = trim(as_texF6_3)
                wtext6.as_texF6_4    = trim(as_texF6_4)
                wtext6.as_texF6_5    = trim(as_texF6_5)  .   
        END.
    END.
    /*add by kridtiya i...A57-0430*/ 
END.
RUN proc_assigninitdata.
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
DEF VAR  b_eng   AS DECI FORMAT  ">>>>9.99-" .
FOR EACH wdetail .
    IF  (year(DATE(wdetail.comdat)) < (YEAR(TODAY) - 1 ) ) AND 
        (year(DATE(wdetail.comdat)) > (YEAR(TODAY) + 1 ) ) THEN 
        /*comment by kridtiya i. A53-0370
        wdetail.expdat  = string(DAY(DATE(wdetail.comdat)))   + "/" +     
        string(MONTH(DATE(wdetail.comdat))) + "/" +  
        string(year(DATE(wdetail.comdat))   + 1 ) .*/
        /*ELSE*/ 
        MESSAGE "Please cheack year of comdat : ค.ศ!!! " wdetail.comdat  .
    /*comment by kridtiya i. A57-0042 add expdate by file
    IF fi_covcod = "T" THEN    /*A53-0370  พรบ. คุ้มครอง 1 ปีนับจากวันที่คุ้มครอง*/
        wdetail.expdat  = IF (string(DAY(DATE(wdetail.comdat)),"99") = "29") AND (string(MONTH(DATE(wdetail.comdat)),"99") = "02" )
                          THEN "01/03/" + string(year(DATE(wdetail.comdat))   + 1 )  
                          ELSE  string(DAY(DATE(wdetail.comdat)))   + "/" +     
                                string(MONTH(DATE(wdetail.comdat))) + "/" +  
                                string(year(DATE(wdetail.comdat))   + 1 ) .
    end...comment by kridtiya i. A57-0042 add expdate by file*/
    ASSIGN  
        wdetail.tariff  = IF wdetail.poltyp = "v72" THEN "9" ELSE "x" 
        wdetail.prempa  = fi_pack
        wdetail.vehuse  = "1"
        /*wdetail.fleet   = 10   */  /*A57-0108 kridtiya i. */
        /*WDETAIL.NCB     =  "50"*/
        wdetail.tp1     = 0 
        wdetail.tp2     = 0
        wdetail.tp3     = 0
        wdetail.n_branch = fi_branch .
    IF wdetail.engcc <> "" THEN DO:
        ASSIGN  
            b_eng   = 0 
            b_eng   = round(DECI(wdetail.engcc),0)
            b_eng   = 1 - (DECI(wdetail.engcc) - b_eng).
        IF b_eng < 1  THEN wdetail.engcc = string(round(DECI(wdetail.engcc),0) + 1).
        ELSE wdetail.engcc = string(round(DECI(wdetail.engcc),0)) .
    END.
    IF wdetail.caryear <> "" THEN wdetail.caryear = string(DECI(wdetail.caryear) - 543 ).
    ELSE wdetail.caryear = "".
    IF      fi_covcod = "3" THEN wdetail.subclass = "610".       /*ประเภท.. 3*/
    ELSE IF fi_covcod = "1" THEN wdetail.subclass = "620".       /*ประเภท.. 1*/
    IF wdetail.poltyp = "v70" THEN DO: 
        ASSIGN wdetail.stk = "".
        IF wdetail.prepol = ""  THEN DO:  /* งานป้ายแดง */
            FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401                  WHERE
                sicsyac.xmm104.tariff = wdetail.tariff                    AND
                sicsyac.xmm104.class  = wdetail.prempa + wdetail.subclass AND
                sicsyac.xmm104.covcod = wdetail.covcod                    AND
                sicsyac.xmm104.ncbyrs =  3  NO-LOCK NO-ERROR NO-WAIT.   /*deflut by user step = 3 */
            IF NOT AVAIL sicsyac.xmm104 THEN DO:
                /*MESSAGE COLOR YELLOW/RED " This NCB Years not on NCB Rates file xmm104. ".*/
                NEXT.
            END.
            ELSE ASSIGN WDETAIL.NCB  =  sicsyac.xmm104.ncbper .
        END.
    END.
    IF wdetail.vehreg = "" THEN DO:
        IF wdetail.chasno <> "" THEN 
            ASSIGN wdetail.vehreg   = "/" + SUBSTR(wdetail.chasno,LENGTH(wdetail.chasno) - 8 ,LENGTH(wdetail.chasno) ) .
    END.
    ELSE DO: 
        /*ASSIGN wdetail.vehreg = trim(substr(wdetail.vehreg,1,3)) + " " + trim(substr(wdetail.vehreg,4))  + " " + trim(wdetail.re_country).*//*A57-0042*/
        IF  INDEX(trim(wdetail.vehreg)," ") <> R-INDEX(trim(wdetail.vehreg)," ")  THEN
            ASSIGN wdetail.vehreg = trim(substr(trim(wdetail.vehreg),1,INDEX(wdetail.vehreg," "))) + trim(substr(trim(wdetail.vehreg),INDEX(wdetail.vehreg," ")) ).
        ASSIGN wdetail.vehreg = trim(wdetail.vehreg) + " " +  trim(wdetail.re_country).    /*A57-0042*/
    END.
    RUN proc_brand.
END.
/*RUN proc_atestp.*/                        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigninitdata c-Win 
PROCEDURE proc_assigninitdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    as_number     = ""    
    as_prepol     = ""     
    as_policyno   = ""    
    as_tax_dat    = ""    
    as_comcode    = ""    
    as_Key_ID     = ""    
    as_tiname     = ""    
    as_insnam     = ""    
    as_name2      = ""    
    as_brand      = ""    
    as_engcc      = ""    
    as_vehreg     = ""     
    as_re_country = ""    
    as_chasno     = ""    
    as_caryear    = ""    
    as_comdat     = ""    
    as_expdat     = ""    
    as_n_STATUS   = ""    
    as_mem1       = ""    
    as_mem2       = ""    
    as_mem3       = ""
    as_sumins     = ""    /*A57-0430*/   
    as_texF17_1   = ""    /*A57-0430*/   
    as_texF17_2   = ""    /*A57-0430*/   
    as_texF17_3   = ""    /*A57-0430*/   
    as_texF18_1   = ""    /*A57-0430*/   
    as_texF18_2   = ""    /*A57-0430*/   
    as_texF18_3   = ""    /*A57-0430*/   
    as_texF6_1    = ""    /*A57-0430*/   
    as_texF6_2    = ""    /*A57-0430*/   
    as_texF6_3    = ""    /*A57-0430*/ 
    as_texF6_4    = ""    /*A57-0430*/ 
    as_texF6_5    = "" .  /*A57-0430*/ 
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
DEF VAR nv_vehregf  AS CHAR INIT "".                     /*A57-0108 kridtiya i. date 20/03/2014 */
DEF VAR nv_comdatf  AS CHAR FORMAT "x(10)" INIT "" .     /*A57-0108 kridtiya i. date 20/03/2014 */
DEF VAR nv_expdatf  AS CHAR FORMAT "x(10)" INIT "" .     /*A57-0108 kridtiya i. date 20/03/2014 */
DEFINE VAR nre_premt  AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/

ASSIGN nre_premt = 0
    nv_vehregf  = ""                                  /*A57-0108 kridtiya i. date 20/03/2014 */
    nv_comdatf     = ""                                  /*A57-0108 kridtiya i. date 20/03/2014 */
    nv_expdatf     = ""                                  /*A57-0108 kridtiya i. date 20/03/2014 */
    nv_vehregf     = wdetail.vehreg                      /*A57-0108 kridtiya i. date 20/03/2014 */
    nv_comdatf     = wdetail.comdat                      /*A57-0108 kridtiya i. date 20/03/2014 */
    nv_expdatf     = wdetail.expdat .                    /*A57-0108 kridtiya i. date 20/03/2014 */
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwycex1 (INPUT-OUTPUT wdetail.prepol,    /* n_prepol     */
                      INPUT-OUTPUT wdetail.poltyp,    /* n_poltyp     */
                      INPUT-OUTPUT wdetail.n_opnpol,  
                      INPUT-OUTPUT wdetail.producer,  /* n_producer   */
                      INPUT-OUTPUT wdetail.agent,     /* n_agent      */
                      INPUT-OUTPUT wdetail.n_insured, /* n_insured    */
                      INPUT-OUTPUT wdetail.tiname,    /* n_title      */
                      INPUT-OUTPUT wdetail.insnam,    /* n_name1      */
                      INPUT-OUTPUT wdetail.name2,     /* n_name2      */
                      INPUT-OUTPUT wdetail.name3,     /* n_name3      */
                      INPUT-OUTPUT wdetail.addr_1,    /* n_addr1      */
                      INPUT-OUTPUT wdetail.addr_2,    /* n_addr2      */
                      INPUT-OUTPUT wdetail.addr_3,    /* n_addr3      */
                      INPUT-OUTPUT wdetail.addr_4,    /* n_addr4      */
                      INPUT-OUTPUT wdetail.icno,      /* n_icno       *//*A55-0182 kridtiya i.เลขบัตรประชาชน */
                      INPUT-OUTPUT wdetail.comdat,    /* n_expdat     */
                      INPUT-OUTPUT wdetail.firstdat,  /* n_firstdat   */
                      INPUT-OUTPUT wdetail.cedpol,    /* n_cedpol     */
                      INPUT-OUTPUT wdetail.prempa,    /* n_prempa     */
                      INPUT-OUTPUT wdetail.subclass,  /* n_subclass   */
                      INPUT-OUTPUT wdetail.redbook,   /* n_redbook    */
                      INPUT-OUTPUT wdetail.brand,     /* n_brand      */
                      INPUT-OUTPUT wdetail.model,     /* n_model      */
                      INPUT-OUTPUT wdetail.caryear,   /* n_caryear    */ 
                      INPUT-OUTPUT wdetail.cargrp,    /* n_cargrp     */ 
                      INPUT-OUTPUT wdetail.body,      /* n_body       */ 
                      INPUT-OUTPUT wdetail.engcc,     /* n_engcc      */ 
                      INPUT-OUTPUT wdetail.tons,      /* n_tons       */ 
                      INPUT-OUTPUT wdetail.seat,      /* n_seat       */ 
                      INPUT-OUTPUT wdetail.vehuse,    /* n_vehuse     */ 
                      INPUT-OUTPUT wdetail.covcod,    /* n_covcod     */ 
                      INPUT-OUTPUT wdetail.garage,    /* n_garage     */ 
                      INPUT-OUTPUT wdetail.vehreg,    /* n_vehreg     */ 
                      INPUT-OUTPUT wdetail.chasno,    /* n_chasno     */ 
                      INPUT-OUTPUT wdetail.eng,       /* n_engno      */ 
                      INPUT-OUTPUT wdetail.tp1,       /* n_uom1_v     */
                      INPUT-OUTPUT wdetail.tp2,       /* n_uom2_v     */
                      INPUT-OUTPUT wdetail.tp3,       /* n_uom5_v     */
                      INPUT-OUTPUT wdetail.si,        /* n_uom6_v     */
                      INPUT-OUTPUT wdetail.fire,      /* n_uom7_v     */
                      INPUT-OUTPUT nv_basere,         /* nv_baseprm   */
                      INPUT-OUTPUT wdetail.NO_41,     /* n_41         */
                      INPUT-OUTPUT wdetail.seat41,    /* nv_seat41    */
                      INPUT-OUTPUT wdetail.NO_42,     /* n_42         */
                      INPUT-OUTPUT wdetail.NO_43,     /* n_43         */
                      INPUT-OUTPUT dod1,              /* nv_dedod     */
                      INPUT-OUTPUT dod2,              /* nv_addod     */
                      INPUT-OUTPUT nv_ded2,           /* nv_dedpd     */
                      INPUT-OUTPUT wdetail.fleet,     /* nv_flet_per  */
                      INPUT-OUTPUT wdetail.ncb,       /* nv_ncbper    */
                      INPUT-OUTPUT nv_dss_per,        /* nv_dss_per   */
                      INPUT-OUTPUT nv_stf_per,        /* nv_stf_per   */
                      INPUT-OUTPUT nv_cl_per,         /* nv_cl_per    */
                      INPUT-OUTPUT nre_premt,         /* A64-0138    */
                      INPUT-OUTPUT wdetail.benname,
                      INPUT-OUTPUT wdetail.nv_acctxt) . /* nv_bennam1   */

    ASSIGN wdetail.premt = string(nre_premt).
    IF (wdetail.comdat <> "")  THEN DO:
        IF wdetail.expdat = ""  THEN
            ASSIGN wdetail.expdat  = IF (string(DAY(DATE(wdetail.comdat)),"99") = "29") AND (string(MONTH(DATE(wdetail.comdat)),"99") = "02" )
            THEN "01/03/" + string(year(DATE(wdetail.comdat))   + 1 )  
                ELSE        string(DAY(DATE(wdetail.comdat)))   + "/" +     
                            string(MONTH(DATE(wdetail.comdat))) + "/" +  
                            string(year(DATE(wdetail.comdat))   + 1 ) .
    END.
    IF nv_vehregf <> "" THEN  ASSIGN  wdetail.vehreg   =  trim(nv_vehregf)  .   /*A57-0108 kridtiya i. date 20/03/2014 */
    IF nv_comdatf <> "" THEN  ASSIGN  wdetail.comdat   =  trim(nv_comdatf)  .   /*A57-0108 kridtiya i. date 20/03/2014 */
    IF nv_expdatf <> "" THEN  ASSIGN  wdetail.expdat   =  trim(nv_expdatf)  .   /*A57-0108 kridtiya i. date 20/03/2014 */
END.                                           
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
    /*COMMENT by Kridtiya i. A53-0232
    IF wdetail.prepol <> "" THEN  aa = nv_basere.
    ELSE IF wdetail.subclass = "610" THEN aa = 1100.
    ELSE IF wdetail.subclass = "620" THEN aa = 2500.
    ELSE DO: 
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    end...COMMENT by Kridtiya i. A53-0232*/
    IF wdetail.prepol = "" THEN DO: 
        /*RUN wgs\wgsfbas.*/
       /*comment by kridtiya i. A57-0108...
        IF wdetail.covcod = "1" THEN  aa = 2200.
        ELSE IF  wdetail.covcod = "3" THEN  aa = 900.    A57-0108 kridtiya i. */
        ASSIGN  aa        = fi_base   /*A57-0108 kridtiya i. */
            wdetail.fleet = fi_fleet  /*A57-0108 kridtiya i. */
            WDETAIL.NCB   = fi_ncb    /*A57-0108 kridtiya i. */ 
            nv_41 = fi_411            /*A57-0108 kridtiya i. */
            nv_42 = fi_412            /*A57-0108 kridtiya i. */
            nv_43 = fi_43  .          /*A57-0108 kridtiya i. */
        IF nv_seat41 = 0 THEN nv_seat41 =  inte(wdetail.seat).   /*A57-0108 kridtiya i. */
    END.
    ELSE    aa =  nv_basere .   /* renew */
    IF aa = 0 THEN DO: 
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ASSIGN 
        chk = NO
        NO_basemsg = " "
        nv_baseprm = aa.

    /*-----nv_drivcod---------------------*/
    /*nv_drivvar1 = wdetail.drivername1.
    nv_drivvar2 = wdetail.drivername2.
    IF wdetail.drivername1 <> ""   THEN  wdetail.drivnam  = "y".
    ELSE wdetail.drivnam  = "N".
    IF wdetail.drivername2 <> ""   THEN  nv_drivno = 2. 
    ELSE IF wdetail.drivername1 <> "" AND wdetail.drivername2 = "" THEN  nv_drivno = 1.  
    ELSE IF wdetail.drivername1 = "" AND wdetail.drivername2 = "" THEN  nv_drivno = 0.  */
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
    IF wdetail.prepol <> "" THEN  ASSIGN  nv_41     = wdetail.NO_41              
                                          nv_seat41 = wdetail.seat41      
                                          nv_42     = wdetail.NO_42       
                                          nv_43     = wdetail.NO_43  .    
    /*comment by kridtiya i. A57-0108
    ELSE ASSIGN  
        nv_41 =  100000                                       
        nv_42 =  100000                                                 
        nv_43 = 0 
    ....comment by kridtiya i. A57-0108  */                                                     
        /*nv_seat41 =  inte(wdetail.seat)*/ 
    /* comment by :A64-0138..
    RUN WGS\WGSOPER(INPUT nv_tariff,                                   
                    nv_class,                                          
                    nv_key_b,                                          
                    nv_comdat).  */                                      
    Assign  nv_411var = ""  nv_412var = ""                                                          
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
    RUN WGS\WGSOPER(INPUT nv_tariff,   
                    nv_class,
                    nv_key_b,
                    nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/  
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
        nv_sivar2    =  string(wdetail.si)
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
         nv_bipvar2     = STRING(uwm130.uom1_v)
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign nv_biavar = ""
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(uwm130.uom2_v)
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN  nv_pdavar = ""
         nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         /*nv_pdavar2     = STRING(uwm130.uom5_v)   a52-0172*/
         nv_pdavar2     = string(deci(WDETAIL.deductpd))         /*A52-0172*/
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
     /* caculate deduct OD  */
     /*DEF VAR dod0 AS INTEGER INIT 0.
     DEF VAR dod1 AS INTEGER INIT 0.
     DEF VAR dod2 AS INTEGER INIT 0.
     DEF VAR dpd0 AS INTEGER INIT 0.*/
     /*def  var  nv_chk  as  logic.*/
      /*dod0 = inte(wdetail.deductda).  a52-0172*/
     /*IF dod0 > 3000 THEN DO:
         dod1 = 500 .
         dod2 = dod0 - dod1.
     END.*/
     IF wdetail.prepol = "" THEN /*DO:
         IF wdetail.covcod = "3" THEN dod1 = 0.           /*A57-0108*/
         ELSE IF wdetail.covcod = "1" THEN dod1 = 500.*/  /*A57-0108*/
        ASSIGN dod1 = fi_deduct  .                        /*A57-0108*/ 
     /*END.*/
     ASSIGN nv_dedod1var = ""
         nv_odcod    = "DC01"
         nv_prem     = dod1
         nv_sivar2   = "" .  
     IF wdetail.covcod = "3" THEN dod0 = 0.
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
     IF dod1 <> 0 THEN 
     ASSIGN
         nv_ded1prm        = nv_prem
         nv_dedod1_prm     = nv_prem
         nv_dedod1_cod     = "DOD"
         nv_dedod1var1     = "     Deduct OD = "
         nv_dedod1var2     =  STRING(dod1)
         SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
         SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
     /*add od*/
     Assign  nv_dedod2var   = " "
         nv_cons  = "AD"
         nv_ded   = 0
         nv_ded   = dod2.
     /* comment by : A64-0138..
     Run  Wgs\Wgsmx025(INPUT  nv_ded,  
                              nv_tariff,
                              nv_class,
                              nv_key_b,
                              nv_comdat,
                              nv_cons,
                       OUTPUT nv_prem).*/ 
     IF dod2 <> 0  THEN
     ASSIGN  nv_aded1prm     = nv_prem
         nv_dedod2_cod   = "DOD2"
         nv_dedod2var1   = "     Add Ded.OD = "
         nv_dedod2var2   =  STRING(dod2)
         SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
         SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2 .
         /*nv_dedod2_prm   = nv_prem.*/ /* A64-0138*/
     /***** pd *******/
     ASSIGN  nv_dedpdvar  = " " 
         nv_cons  = "PD"  
         nv_ded   = 0
         nv_ded   =  nv_ded2.
     /* comment by : A64-0138..
     Run  Wgs\Wgsmx025(INPUT  nv_ded, 
                              nv_tariff,
                              nv_class,
                              nv_key_b,
                              nv_comdat,
                              nv_cons,
                       OUTPUT nv_prem).
     nv_ded2prm    = nv_prem.*/
     IF nv_ded2 <> 0 THEN
     ASSIGN
         nv_dedpd_cod   = "DPD"
         nv_dedpdvar1   = "     Deduct PD = "   
         nv_dedpdvar2   =  STRING(nv_ded)
         SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
         SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
         /*nv_dedpd_prm  = nv_prem.*/ /* A64-0138*/
     /*---------- fleet -------------------*/
     nv_flet_per = INTE(wdetail.fleet) .
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
         nv_fletvar     = " "
         nv_fletvar1    = "     Fleet % = "
         nv_fletvar2    =  STRING(nv_flet_per)
         SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
         SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN
         nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
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
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     /*------------------ dsspc ---------------*/
     /*nv_dss_per = ((nv_gapprm - n_prem ) * 100 ) / nv_gapprm . */
     /* comment by : A64-0138..
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v ,       
                         nv_uom2_v ,       
                         nv_uom5_v ). */
     /*IF nv_gapprm <> n_prem THEN  nv_dss_per = TRUNCATE(((nv_gapprm - n_prem ) * 100 ) / nv_gapprm ,2 ) . 
          
         IF  nv_dss_per   <> 0  THEN
             Assign
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.*/
        

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
                         nv_uom5_v ). */
     IF  nv_stf_per   <> 0  THEN
         Assign
         nv_stfvar1   = "     Discount staff % = "
         nv_stfvar2   =  STRING(nv_stf_per)                 
         SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1          
         SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.         
     /*--------------------------*/
     /* comment by : A64-0138..
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/         
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                nv_uom1_v,       
                                nv_uom2_v,       
                                nv_uom5_v). */
 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_brand c-Win 
PROCEDURE proc_brand :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF            wdetail.brand = ""  THEN wdetail.brand = "".
ELSE IF index(wdetail.brand,"ฮอนด้า")   <> 0 THEN wdetail.brand = "HONDA".
ELSE IF index(wdetail.brand,"ซูซูกิ")   <> 0 THEN wdetail.brand = "SUZUKI".
ELSE IF index(wdetail.brand,"คาวาซากิ") <> 0 THEN wdetail.brand = "KAWASAKI".
ELSE IF index(wdetail.brand,"ยามาฮ่า")  <> 0 THEN wdetail.brand = "YAMAHA".
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
         nv_dedod   = dod1      
         nv_addod   = dod2                                
         nv_dedpd   = nv_ded2                                    
         nv_ncbp    = deci(wdetail.ncb)                                        
         nv_fletp   = deci(wdetail.fleet)                              
         nv_dspcp   = nv_dss_per                                  
         nv_dstfp   = nv_stf_per                                                       
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

        IF wdetail.redbook <> ""  THEN DO:
            FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
                stat.maktab_fil.sclass = wdetail.subclass  AND 
                stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then  
                ASSIGN  
                sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
                wdetail.cargrp         =  stat.maktab_fil.prmpac
                sic_bran.uwm301.vehgrp =  stat.maktab_fil.prmpac
                nv_vehgrp              =  stat.maktab_fil.prmpac. 
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
                       INPUT-OUTPUT nv_totfi  ,
                       INPUT-OUTPUT nv_vehgrp,  
                       INPUT-OUTPUT nv_access,  
                       INPUT-OUTPUT nv_supe,                       
                       INPUT-OUTPUT nv_tpbi1si, 
/*                        INPUT-OUTPUT nv_tpbi2si, */
                       INPUT-OUTPUT nv_tppdsi,                 
                       INPUT-OUTPUT nv_411si,   
                       INPUT-OUTPUT nv_412si,   
                       INPUT-OUTPUT nv_413si,   
                       INPUT-OUTPUT nv_414si,   
                       INPUT-OUTPUT nv_42si,    
                       INPUT-OUTPUT nv_43si,    
                       INPUT-OUTPUT nv_41prmt,  /* nv_41prmt */
                       INPUT-OUTPUT nv_42prmt,  /* nv_42prmt */
                       INPUT-OUTPUT nv_43prmt,  /* nv_43prmt */
                       INPUT-OUTPUT nv_seat41,  /* nv_seat41 */
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
        /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt + 
        nv_message VIEW-AS ALERT-BOX. 
        ASSIGN  wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
                wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt.
                wdetail.pass    = "Y"   
                wdetail.OK_GEN  = "N".*/   /*comment by Kridtiya i. A65-0035*/ 
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN  wdetail.comment = wdetail.comment + "|" + nv_message   /*  by Kridtiya i. A65-0035*/
                wdetail.WARNING = wdetail.WARNING + "|" + nv_message . /*  by Kridtiya i. A65-0035*/ 
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
    
 /*
 IF wdetail.n_delercode <> "" THEN DO:
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 c-Win 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF (wdetail.vehreg = " " ) AND (wdetail.prepol  = " " ) THEN DO: 
    ASSIGN 
        wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N". 
END.
ELSE DO:
    Def  var  nv_vehreg  as char  init  " ".
    Def  var  s_polno    like sicuw.uwm100.policy   init " ".
    Find LAST sicuw.uwm301 Use-index uwm30102 Where  
        sicuw.uwm301.vehreg = wdetail.vehreg  No-lock no-error no-wait.
    IF AVAIL sicuw.uwm301 THEN DO:
        If  sicuw.uwm301.policy =  wdetail.policy  and          
            sicuw.uwm301.endcnt = 1  and
            sicuw.uwm301.rencnt = 1  and
            sicuw.uwm301.riskno = 1  and
            sicuw.uwm301.itemno = 1  Then  Leave.
        Find first sicuw.uwm100 Use-index uwm10001     Where
            sicuw.uwm100.policy = sicuw.uwm301.policy  and
            sicuw.uwm100.rencnt = sicuw.uwm301.rencnt  and                         
            sicuw.uwm100.endcnt = sicuw.uwm301.endcnt  and
            sicuw.uwm100.expdat > date(wdetail.comdat) No-lock no-error no-wait.
        If avail sicuw.uwm100 THEN  s_polno     =   sicuw.uwm100.policy.
    END.     /*avil 301*/
END.         /*note end else*/   /*end note vehreg*/
IF wdetail.cancel = "ca"  THEN  
    ASSIGN  wdetail.pass = "N"  
    wdetail.comment      = wdetail.comment + "| cancel"
    wdetail.OK_GEN       = "N".
/*IF wdetail.insnam = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".*/
/*IF wdetail.drivnam = "y" AND wdetail.drivername1 =  " "   THEN 
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
/*can't block in use*/      
IF wdetail.brand = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
/*IF wdetail.model = " " THEN 
     ASSIGN wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
     wdetail.pass    = "N"   
     wdetail.OK_GEN  = "N".*/
IF wdetail.engcc    = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
/*IF wdetail.seat  = " " THEN 
ASSIGN wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
wdetail.pass    = "N"    
wdetail.OK_GEN  = "N".*/
IF wdetail.caryear = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
ASSIGN nv_maxsi = 0
    nv_minsi    = 0
    nv_si       = 0
    nv_maxdes   = ""
    nv_mindes   = ""
    chkred      = NO  
    nv_modcod   = "". 
IF wdetail.prepol = "" THEN DO:
    IF wdetail.redbook <> "" THEN DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
            stat.maktab_fil.sclass = wdetail.subclass  AND 
            stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
        If  avail stat.maktab_fil  THEN DO:
            ASSIGN  nv_modcod       =  stat.maktab_fil.modcod                                    
                nv_moddes       =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                wdetail.cargrp  =  stat.maktab_fil.prmpac
                /*chkred        =  YES    */                 /*note chk found redbook*/
                wdetail.brand   =  stat.maktab_fil.makdes
                wdetail.caryear =  STRING(stat.maktab_fil.makyea)
                /*wdetail.engcc =  stat.maktab_fil.engineine*/
                /*wdetail.si    =  STRING(stat.maktab_fil.si)*/
                wdetail.redbook =  stat.maktab_fil.modcod                                    
                wdetail.seat    =  stat.maktab_fil.seats
                wdetail.body    =  stat.maktab_fil.body
                /*wdetail.si    =  string(maktab_fil.si)*/
                nv_si            =  maktab_fil.si.
            IF wdetail.covcod = "1"  THEN DO:
                FIND FIRST stat.makdes31 WHERE 
                    stat.makdes31.makdes = "X"  AND     /* Lock X */
                    stat.makdes31.moddes = wdetail.prempa + wdetail.subclass    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE makdes31 THEN 
                    ASSIGN  nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                    nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                    nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                    nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
                ELSE 
                    ASSIGN  nv_maxSI = nv_si
                            nv_minSI = nv_si.
            END.  /*wdetail.covcod = "1"*//***--- End Check Rate SI ---***/
        END.  /*if avail */
        ELSE nv_modcod = " ".
    END.         /*red book <> ""*/ 
    IF nv_modcod = "" THEN DO:
        Find First stat.maktab_fil Use-index maktab04             Where
            stat.maktab_fil.makdes   =   wdetail.brand            And 
            stat.maktab_fil.makyea   =   Integer(wdetail.caryear) AND
            stat.maktab_fil.engine   =   Integer(wdetail.engcc)   AND
            stat.maktab_fil.sclass   =   wdetail.subclass         No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN  wdetail.redbook  =  stat.maktab_fil.modcod
            nv_modcod       =  stat.maktab_fil.modcod                                    
            nv_moddes       =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp  =  stat.maktab_fil.prmpac
            wdetail.body    =  stat.maktab_fil.body
            wdetail.seat    =  stat.maktab_fil.seats 
            wdetail.seat41  =  stat.maktab_fil.seats
            /*wdetail.si      =  (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100))*/ /*A57-0430*/
            wdetail.si      = IF wdetail.si = 0 THEN  (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100)) /*A57-0430*/
                              ELSE wdetail.si   /*A57-0430*/ 
            nv_engine       =  stat.maktab_fil.engine .
        IF nv_modcod = ""  THEN DO: 
            Find LAST stat.maktab_fil Use-index      maktab04          Where
                stat.maktab_fil.makdes   =    wdetail.brand            And                  
                stat.maktab_fil.makyea   =    Integer(wdetail.caryear) AND
                stat.maktab_fil.sclass   =    wdetail.subclass         No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN wdetail.redbook =  stat.maktab_fil.modcod
                nv_modcod        =  stat.maktab_fil.modcod                                    
                nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.body     =  stat.maktab_fil.body
                wdetail.seat     =  (stat.maktab_fil.seats)
                /*wdetail.si     =  (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100))*/ /*A57-0430*/
                wdetail.si       =  IF wdetail.si  = 0 THEN (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100)) /*A57-0430*/
                                    ELSE wdetail.si   /*A57-0430*/
                nv_engine        =  stat.maktab_fil.engine.
        END.
    END.    /*nv_modcod = blank*/ 
END.        /*if wdetail.prepol = " " */
ASSIGN   
    NO_CLASS  = wdetail.prempa + wdetail.subclass 
    nv_poltyp = wdetail.poltyp .
IF nv_poltyp  = "v72"  THEN NO_CLASS  =  wdetail.subclass.
If no_class  <>  " " Then do:
    FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101  WHERE
        sicsyac.xmd031.poltyp =   nv_poltyp        AND
        sicsyac.xmd031.class  =   no_class         NO-LOCK NO-ERROR NO-WAIT.
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
Find sicsyac.sym100 Use-index sym10001      Where
    sicsyac.sym100.tabcod = "u014"          AND 
    sicsyac.sym100.itmcod =  wdetail.vehuse No-lock no-error no-wait.
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
    ASSIGN  wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. "
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
NV_NCBPER = INTE(WDETAIL.NCB) .
If nv_ncbper  <> 0 Then do:
    Find first sicsyac.xmm104 Use-index xmm10401                   Where
        sicsyac.xmm104.tariff = wdetail.tariff                     AND
        sicsyac.xmm104.class  = wdetail.prempa + wdetail.subclass  AND
        sicsyac.xmm104.covcod = wdetail.covcod                     AND
        sicsyac.xmm104.ncbper = INTE(wdetail.ncb)                  No-lock no-error no-wait.
    IF not avail  sicsyac.xmm104  Then 
        ASSIGN  wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
END.   /*ncb <> 0*/
/******* drivernam **********/
nv_sclass = wdetail.subclass. 
If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
    ASSIGN   wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
/*ASSIGN wdetail.si  =  IF ((wdetail.si / 1000) - (TRUNCATE((wdetail.si / 1000),0))) > 0 THEN      /*A57-0430*/
    (TRUNCATE((wdetail.si / 1000),0) + 1) * 1000  ELSE TRUNCATE((wdetail.si / 1000),0) * 1000   .*//*A57-0430*/
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
FOR EACH wdetail  :
    IF  wdetail.policy = " "  THEN NEXT.
    ASSIGN 
        n_rencnt   = 0
        n_endcnt   = 0 
        nv_basere  = 0 
        dod0       = 0         
        dod1       = 0    
        nv_ded2    = 0  
        dod2       = 0
        nv_ncbper  = 0   
        nv_dss_per = 0
        nv_stf_per = 0    
        nv_cl_per  = 0
        fi_process = "Create data to file GW .." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.

    RUN proc_susspect. /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    IF wdetail.poltyp = "v72"   THEN DO:
        IF wdetail.prepol <> "" THEN RUN proc_renew72.   /*16  หมายเหตุ (ต่อ/ใหม่) */
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
        IF wdetail.prepol <> "" THEN RUN proc_renew.  /*16  หมายเหตุ (ต่อ/ใหม่) */
        RUN proc_chktest0.
    END.
    IF wdetail.poltyp = "v70"  THEN DO:
        RUN proc_policy . 
        RUN proc_chktest2.    
        RUN proc_chktest3. 
        RUN proc_chktest4. 
    END.
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
DEF VAR n_si  AS DECI INIT 0.
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
IF NOT AVAILABLE uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN  sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp  = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno  = s_itemno
        sic_bran.uwm130.bchyr   = nv_batchyr        /* batch Year */
        sic_bran.uwm130.bchno   = nv_batchno        /* bchno      */
        sic_bran.uwm130.bchcnt  = nv_batcnt         /* bchcnt     */
        nv_sclass = wdetail.subclass.
    IF nv_uom6_u  =  "A"  THEN DO:
        IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
            nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
            Then  nv_uom6_u  =  "A".         
        Else 
            ASSIGN  wdetail.pass = "N"
                wdetail.comment  = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
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
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0   /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0   /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0   /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0   /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.  /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = inte(wdetail.fire)
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
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do: 
        IF wdetail.prepol <> "" THEN
            Assign 
            sic_bran.uwm130.uom1_v     =  deci(wdetail.tp1)   
            sic_bran.uwm130.uom2_v     =  deci(wdetail.tp2)  
            sic_bran.uwm130.uom5_v     =  deci(wdetail.tp3) 
            nv_uom1_v                  =  deci(wdetail.tp1)    /*deci(wdetail.tp_bi ) */ 
            nv_uom2_v                  =  deci(wdetail.tp2)    /*deci(wdetail.tp_bi2) */  
            nv_uom5_v                  =  deci(wdetail.tp3).   /*deci(wdetail.tp_bi3) */  
        ELSE 
            Assign 
                sic_bran.uwm130.uom1_v     =  stat.clastab_fil.uom1_si    
                sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si   
                sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si  
                wdetail.tp1                =  stat.clastab_fil.uom1_si   
                wdetail.tp2                =  stat.clastab_fil.uom2_si   
                wdetail.tp3                =  stat.clastab_fil.uom5_si  
                nv_uom1_v                  =  deci(wdetail.tp1)    /*deci(wdetail.tp_bi )   */ 
                nv_uom2_v                  =  deci(wdetail.tp2)    /*deci(wdetail.tp_bi2) */  
                nv_uom5_v                  =  deci(wdetail.tp3) .
        Assign 
            /*sic_bran.uwm130.uom1_v     =  stat.clastab_fil.uom1_si    
            sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si   
            sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si  
            wdetail.tp1                =  stat.clastab_fil.uom1_si   
            wdetail.tp2                =  stat.clastab_fil.uom2_si   
            wdetail.tp3                =  stat.clastab_fil.uom5_si  
            nv_uom1_v                  =  deci(wdetail.tp1)    /*deci(wdetail.tp_bi )   */ 
            nv_uom2_v                  =  deci(wdetail.tp2)    /*deci(wdetail.tp_bi2) */  
            nv_uom5_v                  =  deci(wdetail.tp3) */    /*deci(wdetail.tp_bi3) */  
            wdetail.deductpd           =  string(sic_bran.uwm130.uom5_v)
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            wdetail.comper             =  string(stat.clastab_fil.uom8_si)                
            wdetail.comacc             =  string(stat.clastab_fil.uom9_si) 
            /* nv_uom1_v                  =  sic_bran.uwm130.uom1_v 
            nv_uom2_v                  =  sic_bran.uwm130.uom2_v
            nv_uom5_v                  =  sic_bran.uwm130.uom5_v  */ 
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".
        If  wdetail.garage  =  ""  Then
            Assign 
            nv_41      = stat.clastab_fil.si_41unp
            nv_42      = stat.clastab_fil.si_42
            nv_43      = stat.clastab_fil.si_43
            nv_seat41  = stat.clastab_fil.dri_41 + clastab_fil.pass_41.  
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
END.   /* end Do transaction*/
ASSIGN  s_recid3 = RECID(sic_bran.uwm130)
    nv_covcod   =   wdetail.covcod
    nv_makdes   =  wdetail.brand
    nv_moddes   =  wdetail.model
    nv_newsck   = " ".
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
    sic_bran.uwm301.bchcnt = nv_batcnt    NO-WAIT NO-ERROR.
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
    sic_bran.uwm301.covcod    = wdetail.covcod
    sic_bran.uwm301.cha_no    = wdetail.chasno
    sic_bran.uwm301.trareg    = nv_uwm301trareg
    sic_bran.uwm301.eng_no    = wdetail.eng
    sic_bran.uwm301.Tons      = INTEGER(wdetail.tons)
    sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
    sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage    = wdetail.garage
    sic_bran.uwm301.body      = wdetail.body
    sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv_ben83  = trim(wdetail.benname)
    sic_bran.uwm301.vehreg    = wdetail.vehreg 
    sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
    sic_bran.uwm301.vehuse    = wdetail.vehuse
    sic_bran.uwm301.modcod    = wdetail.redbook
    sic_bran.uwm301.vehgrp    = wdetail.cargrp          
    sic_bran.uwm301.moddes    = trim(wdetail.brand) + " " + trim(wdetail.model)   
    sic_bran.uwm301.sckno     = 0
    sic_bran.uwm301.itmdel    = NO
    /*sic_bran.uwm301.prmtxt    = wdetail.nv_acctxt    */
    wdetail.tariff            = sic_bran.uwm301.tariff.
FIND LAST wtext6 WHERE wtext6.as_policyF6 = wdetail.policy NO-LOCK NO-ERROR .
IF AVAIL wtext6 THEN
    ASSIGN 
    SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  wtext6.as_texF6_1
    SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  wtext6.as_texF6_2
    SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  wtext6.as_texF6_3
    SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  wtext6.as_texF6_4
    SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  wtext6.as_texF6_5.

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
    sic_bran.uwm301.bchyr  = nv_batchyr   /* batch Year */
    sic_bran.uwm301.bchno  = nv_batchno   /* bchno      */
    sic_bran.uwm301.bchcnt = nv_batcnt    /* bchcnt     */
    s_recid4               = RECID(sic_bran.uwm301)
    nv_engine              = inte(wdetail.engcc).
IF wdetail.redbook  = ""  /*AND chkred = YES*/  THEN DO:
    /*FIND FIRST stat.maktab_fil USE-INDEX maktab01 
            WHERE stat.maktab_fil.sclass = wdetail.subclass   AND
            stat.maktab_fil.modcod       =  wdetail.redbook   No-lock no-error no-wait.
        If  avail  stat.maktab_fil  Then 
            ASSIGN  sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
            sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
            wdetail.cargrp          =  maktab_fil.prmpac
            sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
            sic_bran.uwm301.body    =  stat.maktab_fil.body
            sic_bran.uwm301.engine  =  stat.maktab_fil.eng
            nv_engine   =  stat.maktab_fil.eng
            /*nv_engine   =  inte(wdetail.engcc)*/  .
    END.
    ELSE DO:*/
    Find First stat.maktab_fil Use-index      maktab04          Where
        stat.maktab_fil.makdest  =     nv_makdes                And                  
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
        stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
        stat.maktab_fil.sclass   =     wdetail.subclass   No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN wdetail.redbook  =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.engine  =  stat.maktab_fil.engine
        nv_engine               =  stat.maktab_fil.engine
        wdetail.seat            =  stat.maktab_fil.seats
        /*wdetail.si              =  stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 )*/                    /*A57-0430*/
        wdetail.si              =  IF wdetail.si = 0 THEN stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) /*A57-0430*/
                                   ELSE wdetail.si  .  /*A57-0430*/
END.
IF wdetail.redbook  = ""  THEN RUN proc_maktab.
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
    nv_class  = IF wdetail.poltyp = "v72" THEN wdetail.subclass ELSE wdetail.prempa +  wdetail.subclass
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = DECI(wdetail.engcc) 
    nv_tons   = deci(wdetail.tons) 
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse
    nv_COMPER = deci(wdetail.comper) 
    nv_comacc = deci(wdetail.comacc) 
    nv_seats  = INTE(wdetail.seat)
    nv_tons   = DECI(wdetail.tons)
    /*nv_dss_per = 0  */   
    nv_dsspcvar1   = ""
    nv_dsspcvar2   =  ""
    nv_dsspcvar   = ""
    nv_42cod   = ""
    nv_43cod   = ""
    nv_41cod1  = ""
    nv_41cod2  = ""
    nv_basecod = ""
    nv_usecod  = "" 
    nv_engcod  = "" 
    nv_drivcod = ""
    nv_yrcod   = "" 
    nv_sicod   = "" 
    nv_grpcod  = "" 
    nv_bipcod  = "" 
    nv_biacod  = "" 
    nv_pdacod  = "" 
    nv_ncbyrs  =   0    
    nv_ncbper  =   0    
    /*nv_ncb   =   0*/
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
            ASSIGN nv_compcod   = "COMP"
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
        END.
        Else assign nv_compprm     = 0
            nv_compcod     = " "
            nv_compvar1    = " "
            nv_compvar2    = " "
            nv_compvar     = " " .
        If  nv_compprm  =  0  THEN DO:
            ASSIGN nv_vehuse = "0".     /*A52-0172 ให้ค่า0 เนื่องจากต้องการส่งค่าให้ key.b = 0 */
            RUN wgs\wgscomp.  
        END.
        nv_comacc  = nv_comacc .   
    END.    /* else do */
    If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0. 
END.   /*compul y*/
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
RUN proc_calpremt .      /*A64-0138*/
RUN proc_adduwd132prem . /*A64-0138*/

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN 
     /*sic_bran.uwm100.prem_t = nv_gapprm*//*A57-0430*/
     sic_bran.uwm100.prem_t = nv_pdprm     /*A57-0430*/
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
       /* sic_bran.uwm301.ncbper   = nv_ncbper /*A57-0430*/ 
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs*/ /*A57-0430*/ 
        sic_bran.uwm301.mv41seat = nv_seat41.
/*comment by : A64-0138..  
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
  If avail sic_bran.uwm100 THEN 
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
       sic_bran.uwm100.policy =  caps(wdetail.policy)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
       sic_bran.uwm100.rencnt =  n_rencnt             
       sic_bran.uwm100.renno  =  ""
       sic_bran.uwm100.endcnt =  n_endcnt
       sic_bran.uwm100.bchyr  =  nv_batchyr 
       sic_bran.uwm100.bchno  =  nv_batchno 
       sic_bran.uwm100.bchcnt =  nv_batcnt     .


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
ASSIGN wcomp.brand    = "HONDA"  
    wcomp.redbook  = "HO88".  
CREATE wcomp. 
ASSIGN wcomp.brand    = "SUZUKI" 
    wcomp.redbook  = "ZU00".  
CREATE wcomp. 
ASSIGN wcomp.brand    = "KAWASAKI"
    wcomp.redbook  = "KA03".   
CREATE wcomp. 
ASSIGN wcomp.brand    = "YAMAHA"  
    wcomp.redbook  = "YA00". 
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
nv_c = wdetail.policy.
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
ASSIGN
    wdetail.policy = nv_c 
    /*wdetail2.policyno = nv_c*/ .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchar72 c-Win 
PROCEDURE proc_cutchar72 :
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
ASSIGN
    wdetail.prepol = nv_c 
    /*wdetail2.policyno = nv_c*/ .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_definition c-Win 
PROCEDURE proc_definition :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Modify by   : Kridtiya i. A57-0042 สิ่งที่ขอเพิ่มแก้ไข
- ปรับการแสดงค่า เลขทะเบียนรถตามรูปแบบใหม่
- ปรับการรับค่าวันที่ความคุ้มครองจากไฟล์แจ้งงาน
   */
/*Modify by   : Kridtiya i. A57-0108 ปรับส่วนการรับค่าเลขทะเบียนจากไฟล์กรณีต่ออายุมีทะเบียนใหม่มา*/
/*modify by   : Kridtiya i. A57-0430 03/12/2014 เพิ่มการรับค่าทุนประกัน และการบันทึกข้อความ F6,F17,F18 */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab c-Win 
PROCEDURE proc_maktab :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Find LAST stat.maktab_fil Use-index      maktab04          Where
    stat.maktab_fil.makdes   =    wdetail.brand            And                  
    stat.maktab_fil.makyea   =    Integer(wdetail.caryear) AND
    stat.maktab_fil.sclass   =    wdetail.subclass         No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    Assign
    wdetail.redbook        =  stat.maktab_fil.modcod
    sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
    sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
    wdetail.cargrp          =  stat.maktab_fil.prmpac
    sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
    sic_bran.uwm301.body    =  stat.maktab_fil.body
    sic_bran.uwm301.engine  =  stat.maktab_fil.engine
    nv_engine               =  stat.maktab_fil.engine
    wdetail.seat            =  stat.maktab_fil.seats
  /*wdetail.si              =  stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 )*/                      /*A57-0430*/
    wdetail.si              =  IF wdetail.si = 0 THEN stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) /*A57-0430*/
                               ELSE wdetail.si  .  /*A57-0430*/
IF wdetail.redbook  = ""  THEN
    ASSIGN  wdetail.comment = wdetail.comment + "| Code Red Book เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchchass c-Win 
PROCEDURE proc_matchchass :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew AS CHAR.
DEFINE VAR nv_len AS INTE INIT 0. 

ASSIGN nv_uwm301trareg = trim(as_chasno) .
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
IF chk_type = "T" THEN DO:
    FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE 
        sicuw.uwm301.trareg             = trim(nv_uwm301trareg) AND
        sicuw.uwm301.covcod             = "T"   NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm301 THEN
        ASSIGN as_prepol = caps(trim(sicuw.uwm301.policy)).
    ELSE ASSIGN as_prepol = "".
END.
ELSE DO:
    FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE 
        sicuw.uwm301.trareg       =  trim(nv_uwm301trareg) AND
        sicuw.uwm301.covcod       <> "T"                   NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm301 THEN
        ASSIGN as_prepol = caps(trim(sicuw.uwm301.policy)).
    ELSE ASSIGN as_prepol = "".
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matoutfile c-Win 
PROCEDURE proc_matoutfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  nv_output AS CHAR FORMAT "x(60)".
DEF VAR  n_count   AS DECI INIT 0.
IF INDEX(fi_output1,".csv") = 0  THEN 
    fi_output1 = fi_output1 + ".csv".
/*ELSE  nv_output = substr(fi_output1,1,INDEX(fi_output1,".slk") - 1 ) + "_1.slk".  */
OUTPUT TO VALUE(fi_output1).   
EXPORT DELIMITER "|"   
    "no."
    "กรมธรรม์เดิม"
    "กรมธรรม์ใหม่"
    "เสียภาษี"
    "แผนก"
    "   "
    "   "
    "ชื่อ"
    "นามสกุล"
    "ยี่ห้อ"
    "ซีซี"
    "ทะเบียน"
    "   "
    "หมายเลขตัวถัง"
    "ปีพ.ศ."
    "วันที่ความคุ้มครอง"
    "วันที่สิ้นสุดความคุ้มครอง"
    "ทุน"
    "F17_1"
    "F17_2"
    "F17_3"
    "F18_1"
    "F18_2"
    "F18_3"
    "F6_01"
    "F6_02"
    "F6_03"
    "F6_04"
    "F6_05"  . 
FOR EACH wmatch   NO-LOCK .
    EXPORT DELIMITER "|" 
        wmatch.n_id      
        wmatch.n_prepol  
        wmatch.n_policy 
        wmatch.n_taxno  
        wmatch.n_dept   
        wmatch.n_recno  
        wmatch.n_title  
        wmatch.n_name1  
        wmatch.n_name2  
        wmatch.n_brand  
        wmatch.n_cc     
        wmatch.n_vehreg 
        wmatch.n_provin 
        wmatch.n_chass  
        wmatch.n_year   
        wmatch.n_comdat 
        wmatch.n_expdat 
        wmatch.n_sumins 
        wmatch.n_tex1701
        wmatch.n_tex1702
        wmatch.n_tex1703
        wmatch.n_tex1801
        wmatch.n_tex1802
        wmatch.n_tex1803
        wmatch.n_tex1601       
        wmatch.n_tex1602
        wmatch.n_tex1603
        wmatch.n_tex1604
        wmatch.n_tex1605 .  
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matpolrenew c-Win 
PROCEDURE proc_matpolrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN fi_process = "Match file find policy renew ".
    DISP fi_process WITH FRAM fr_main.
    FOR EACH   wmatch :
        DELETE  wmatch.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|" 
            as_number    
            as_prepol     
            as_policyno  
            as_tax_dat   
            as_comcode   
            as_Key_ID    
            as_tiname    
            as_insnam    
            as_name2     
            as_brand     
            as_engcc     
            as_vehreg    
            as_re_country
            as_chasno    
            as_caryear   
            as_comdat    
            as_expdat  
            as_sumins       
            as_texF17_1    
            as_texF17_2    
            as_texF17_3    
            as_texF18_1    
            as_texF18_2    
            as_texF18_3    
            as_texF6_1     
            as_texF6_2     
            as_texF6_3     
            as_texF6_4     
            as_texF6_5  .  
        IF      INDEX(as_number,"รายการ") <> 0 THEN RUN proc_assigninitdata.
        ELSE IF INDEX(as_number,"ประกัน") <> 0 THEN RUN proc_assigninitdata.
        ELSE IF INDEX(as_number,"ลำดับ")  <> 0 THEN RUN proc_assigninitdata.
        ELSE IF INDEX(as_number,"ขอต่อ")  <> 0 THEN RUN proc_assigninitdata.
        ELSE IF INDEX(as_number,"no")     <> 0 THEN RUN proc_assigninitdata.
        ELSE IF trim(as_policyno)         = "" THEN RUN proc_assigninitdata.
        ELSE DO:
            FIND FIRST wmatch WHERE wmatch.n_policy  = trim(as_policyno)    NO-ERROR NO-WAIT.
            IF NOT AVAIL wmatch  THEN DO:
                ASSIGN fi_process = "Create Data ..."  + trim(as_policyno).
                DISP fi_process WITH FRAM fr_main.
                RUN proc_matchchass.
                CREATE wmatch.                                 /*create wmatch ..........   */
                ASSIGN 
                    wmatch.n_id      = trim(as_number) 
                    wmatch.n_prepol  = trim(as_prepol)  
                    wmatch.n_policy  = trim(as_policyno)  
                    wmatch.n_taxno   = trim(as_tax_dat) 
                    wmatch.n_dept    = trim(as_comcode) 
                    wmatch.n_recno   = trim(as_Key_ID) 
                    wmatch.n_title   = trim(as_tiname) 
                    wmatch.n_name1   = trim(as_insnam) 
                    wmatch.n_name2   = trim(as_name2)  
                    wmatch.n_brand   = trim(as_brand)  
                    wmatch.n_cc      = trim(as_engcc)  
                    wmatch.n_vehreg  = trim(as_vehreg)       
                    wmatch.n_provin  = trim(as_re_country)         
                    wmatch.n_chass   = trim(as_chasno)         
                    wmatch.n_year    = trim(as_caryear)         
                    wmatch.n_comdat  = trim(as_comdat)         
                    wmatch.n_expdat  = trim(as_expdat)         
                    wmatch.n_sumins  = trim(as_sumins)         
                    wmatch.n_tex1701 = trim(as_texF17_1)         
                    wmatch.n_tex1702 = trim(as_texF17_2)         
                    wmatch.n_tex1703 = trim(as_texF17_3)         
                    wmatch.n_tex1801 = trim(as_texF18_1)         
                    wmatch.n_tex1802 = trim(as_texF18_2)         
                    wmatch.n_tex1803 = trim(as_texF18_3)         
                    wmatch.n_tex1601 = trim(as_texF6_1)                        
                    wmatch.n_tex1602 = trim(as_texF6_2)         
                    wmatch.n_tex1603 = trim(as_texF6_3)         
                    wmatch.n_tex1604 = trim(as_texF6_4)         
                    wmatch.n_tex1605 = trim(as_texF6_5)  .     
            END.
        END.
    END.    /* repeat  */   
    RUN proc_matoutfile.
    MESSAGE "Export data Check Policy Renew Complete" VIEW-AS ALERT-BOX.
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
/*comment by Kridtiyain. A54-0129.....
DEF VAR nn_acno    LIKE  sicsyac.xtm600.acno  .
DEF VAR nn_name    LIKE sicsyac.xtm600.name.  
DEF VAR nn_addr1   LIKE  sicsyac.xtm600.addr1 .
DEF VAR nn_addr2   LIKE  sicsyac.xtm600.addr2 .
DEF VAR nn_addr3   LIKE  sicsyac.xtm600.addr3 .
DEF VAR nn_addr4   LIKE  sicsyac.xtm600.addr4 .
DEF VAR nn_ntitle  LIKE  sicsyac.xtm600.ntitle .  
end comment by Kridtiya i . A54-0129 .....*/
IF wdetail.policy <> "" THEN DO:
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
            wdetail.comment   = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001  WHERE
            sicuw.uwm100.policy =  wdetail.policy   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN wdetail.pass = "N"
                wdetail.comment     = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning     = "Program Running Policy No. ให้ชั่วคราว".
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
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.       /*wdetail.stk  <>  ""*/
    ELSE DO:  /*sticker = ""*/ 
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
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
            RUN proc_create100. 
        END.
        ELSE RUN proc_create100.  
    END.
END.
ELSE DO:    /*wdetail.policy = ""*/
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
                ASSIGN wdetail.pass = "N"
                wdetail.comment     = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning     = "Program Running Policy No. ให้ชั่วคราว".
        END.
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass = "N"
            wdetail.comment      = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning      = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.     /*wdetail.stk  <>  ""*/
    ELSE DO:       /*policy = "" and comp_sck = ""  */       
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
IF (wdetail.poltyp = "V70")  AND (wdetail.Docno <> "" ) THEN 
    ASSIGN  nv_docno  = wdetail.Docno
    nv_accdat = TODAY.
ELSE DO:
        IF wdetail.docno  = "" THEN nv_docno  = "".
        IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
IF wdetail.prepol = "" THEN 
    ASSIGN  wdetail.firstdat  = wdetail.comdat 
    wdetail.n_insured = nn_acno           
    wdetail.insnam    = nn_name   
    /*wdetail.name2     = nn_name2   */       
    wdetail.name3     = nn_name3          
    wdetail.addr_1    = nn_addr1          
    wdetail.addr_2    = nn_addr2
    wdetail.addr_3    = nn_addr3          
    wdetail.addr_4    = nn_addr4          
    wdetail.tiname    = nn_ntitle .
/*comment by Kridtiya i. A57-0042...
ELSE  /*wdetail.expdat  = string(DAY(DATE(wdetail.comdat)))   + "/" +    /*renew policy*/ 
                        string(MONTH(DATE(wdetail.comdat))) + "/" +  
                        string(year(DATE(wdetail.comdat))   + 1 ) .*/
      wdetail.expdat  = IF (string(DAY(DATE(wdetail.comdat)),"99") = "29") AND    /*renew policy*/ 
                           (string(MONTH(DATE(wdetail.comdat)),"99") = "02" )
                        THEN "01/03/" + string(year(DATE(wdetail.comdat))   + 1 ,"99/99/9999")  
                        ELSE  string(DAY(DATE(wdetail.comdat)),"99")   + "/" +     
                              string(MONTH(DATE(wdetail.comdat)),"99") + "/" +  
                              string(year(DATE(wdetail.comdat))   + 1 ,"9999").
end....comment by Kridtiya i. A57-0042...*/
/*comment BY Kridtiya i. A54-0129.....
/*Add kridtiya i. A54-0057 */
FIND FIRST  sicsyac.xtm600 USE-INDEX  xtm60001    WHERE
    sicsyac.xtm600.acno =   "0C17962"  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sicsyac.xtm600 THEN 
    ASSIGN  
    nn_acno      =  sicsyac.xtm600.acno  
    nn_name      =  sicsyac.xtm600.name  
    nn_addr1     =  sicsyac.xtm600.addr1 
    nn_addr2     =  sicsyac.xtm600.addr2 
    nn_addr3     =  sicsyac.xtm600.addr3 
    nn_addr4     =  sicsyac.xtm600.addr4 
    nn_ntitle    =  sicsyac.xtm600.ntitle .
ELSE
    ASSIGN nn_acno =  "0C17962" 
        nn_name    =  "ยาคูลท์เซลส์ (กรุงเทพฯ) จำกัด"               
        nn_addr1   =  "1025 อาคารยาคูลท์ ชั้น 16"  
        nn_addr2   =  "ถนนพหลโยธิน แขวงสามเสนใน"   
        nn_addr3   =  "เขตพญาไท กรุงเทพมหานคร"     
        nn_addr4   =  ""                           
        nn_ntitle  =  "บริษัท"   .
/*Add kridtiya i. A54-0057 */
end...comment BY Kridtiya i. A54-0129...*/
RUN proc_chkcode . /*A64-0138*/
DO TRANSACTION:
    ASSIGN sic_bran.uwm100.renno  = ""
        sic_bran.uwm100.endno  = ""
        sic_bran.uwm100.poltyp = trim(wdetail.poltyp)
        sic_bran.uwm100.insref = caps(wdetail.n_insured)
        sic_bran.uwm100.opnpol = trim(wdetail.n_opnpol)
        /*sic_bran.uwm100.anam2  = ""                /* ICNO  Cover Note A51-0071 Amparat */  A55-0182 */
        sic_bran.uwm100.anam2  = trim(nn_icno)             /*A55-0182 */
        sic_bran.uwm100.ntitle = trim(wdetail.tiname)       
        sic_bran.uwm100.name1  = trim(wdetail.insnam)           
        /*sic_bran.uwm100.name2  = " (คุณ" +  wdetail.insnam  + " " + wdetail.name2 + " " + wdetail.number + ")  " */     
        sic_bran.uwm100.name2  = trim(wdetail.name2)   
        sic_bran.uwm100.name3  = trim(wdetail.name3)                                              
        sic_bran.uwm100.addr1  = trim(wdetail.addr_1)      
        sic_bran.uwm100.addr2  = trim(wdetail.addr_2)       
        sic_bran.uwm100.addr3  = trim(wdetail.addr_3)        
        sic_bran.uwm100.addr4  = trim(wdetail.addr_4) 
        sic_bran.uwm100.postcd =  "" 
        sic_bran.uwm100.undyr  = String(Year(today),"9999")   /*   nv_undyr  */
        sic_bran.uwm100.branch = trim(wdetail.n_branch)               /* nv_branch  */                        
        sic_bran.uwm100.dept   = nv_dept
        sic_bran.uwm100.usrid  = USERID(LDBNAME(1))
        /*sic_bran.uwm100.fstdat = TODAY                        /*TODAY */kridtiya i. a53-0171*/
        sic_bran.uwm100.fstdat =  date(wdetail.firstdat)                 /* ให้ firstdate=comdate */
        sic_bran.uwm100.comdat =  DATE(wdetail.comdat)
        sic_bran.uwm100.expdat =  date(wdetail.expdat)
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
        sic_bran.uwm100.prog   = "wgwycgen"
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
        sic_bran.uwm100.acno1  = trim(wdetail.producer)  /*  nv_acno1 */
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
        sic_bran.uwm100.cr_2    = ""
        sic_bran.uwm100.bchyr   = nv_batchyr           /*Batch Year */  
        sic_bran.uwm100.bchno   = nv_batchno           /*Batch No.  */  
        sic_bran.uwm100.bchcnt  = nv_batcnt            /*Batch Count*/  
        sic_bran.uwm100.prvpol  = trim(wdetail.prepol) /*A52-0172*/
        sic_bran.uwm100.cedpol  = ""                   
        sic_bran.uwm100.finint  = ""                   
        sic_bran.uwm100.bs_cd   = ""                   /*add kridtiya i. A53-0027 เพิ่ม Vatcode*/
        sic_bran.uwm100.opnpol  = ""                   
        sic_bran.uwm100.endern  = ?                    /*add kridtiya i. A53-0171 เพิ่มวันที่รับเงิน*/
        sic_bran.uwm100.firstName  = nn_firstName      /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.lastName   = nn_lastName       /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.postcd     = nn_postcd         /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.icno       = nn_icno           /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeocc    = nn_codeocc        /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr1  = nn_codeaddr1      /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr2  = nn_codeaddr2      /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr3  = nn_codeaddr3      /*Add by Kridtiya i. A63-0472*/
        /*sic_bran.uwm100.br_insured = nn_br_insured */    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.campaign   = wdetail.campaignov . /*Add by Kridtiya i. A63-0472*/

    IF wdetail.prepol <> " " THEN DO:
        ASSIGN  sic_bran.uwm100.prvpol  = wdetail.prepol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
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
    /*comment by kridtiya i..A54-0129 ปรับการคำนวณวันที่ให้เท่ากับระบบ พรีเมียม
      nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                    ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.  
      end...by kridtiya i..A54-0129*/ 
    /*Add by kridtiya i..A54-0129....*/
    IF  (DAY(sic_bran.uwm100.comdat)      =  DAY(sic_bran.uwm100.expdat)    AND
         MONTH(sic_bran.uwm100.comdat)    =  MONTH(sic_bran.uwm100.expdat)  AND
         YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) ) OR
        (DAY(sic_bran.uwm100.comdat)      =  29                             AND
         MONTH(sic_bran.uwm100.comdat)    =  02                             AND
         DAY(sic_bran.uwm100.expdat)      =  01                             AND
         MONTH(sic_bran.uwm100.expdat)    =  03                             AND
         YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
        THEN nv_polday = 365.
    ELSE nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
     /*by kridtiya i..A54-0129*/
END. /*transaction*//**/
/*RUN proc_uwd100.*/ /*A57-0430*/   
RUN proc_uwd100new .  /*A57-0430*/   
/*RUN proc_uwd102.*/ /*A57-0430*/ 
RUN proc_uwd102new .  /*A57-0430*/ 
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
    RUN wgw/wgwad120 (INPUT  sic_bran.uwm100.policy,   /***--- A490166 Note Modi ---***/
                             sic_bran.uwm100.rencnt,
                             sic_bran.uwm100.endcnt,
                             s_riskgp,
                             s_riskno,
                      OUTPUT s_recid2).
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
        sic_bran.uwm120.bchyr  = nv_batchyr       /* batch Year */
        sic_bran.uwm120.bchno  = nv_batchno       /* bchno    */
        sic_bran.uwm120.bchcnt = nv_batcnt .      /* bchcnt     */
    ASSIGN
        sic_bran.uwm120.class  = IF wdetail.poltyp = "v72" THEN wdetail.subclass ELSE wdetail.prempa + wdetail.subclass 
        s_recid2               = RECID(sic_bran.uwm120).
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
DEF VAR n_year  AS INTE INIT 0.
ASSIGN 
    n_year = YEAR(TODAY) + 543
    n_year = n_year - 1 .
IF LENGTH(wdetail.prepol) < 12  THEN DO:
    IF      LENGTH(wdetail.prepol) = 6 THEN wdetail.prepol = "D070" + (SUBSTR(string(n_year),3,2)) +  wdetail.prepol.
    ELSE IF LENGTH(wdetail.prepol) = 1 THEN wdetail.prepol = "D070" + (SUBSTR(string(n_year),3,2)) + "00000" + wdetail.prepol.
    ELSE IF LENGTH(wdetail.prepol) = 2 THEN wdetail.prepol = "D070" + (SUBSTR(string(n_year),3,2)) + "0000" + wdetail.prepol.
    ELSE IF LENGTH(wdetail.prepol) = 3 THEN wdetail.prepol = "D070" + (SUBSTR(string(n_year),3,2)) + "000" + wdetail.prepol.
    ELSE IF LENGTH(wdetail.prepol) = 4 THEN wdetail.prepol = "D070" + (SUBSTR(string(n_year),3,2)) + "00" + wdetail.prepol.
    ELSE IF LENGTH(wdetail.prepol) = 5 THEN wdetail.prepol = "D070" + (SUBSTR(string(n_year),3,2)) + "0" + wdetail.prepol.
END.
ELSE DO:
    IF LENGTH(wdetail.prepol) > 12  THEN RUN proc_cutchar72.
END.
FIND LAST sicuw.uwm301  USE-INDEX uwm30101  WHERE   /* prepol */
    sicuw.uwm301.policy  =  wdetail.prepol  NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL sicuw.uwm301 THEN DO:                      /*policy renew */
    FIND LAST sicuw.uwm100  Use-index uwm10001    WHERE 
        sicuw.uwm100.policy = sicuw.uwm301.policy No-lock No-error no-wait.
    IF AVAIL sicuw.uwm100  THEN DO:
        IF sicuw.uwm100.renpol <> " " THEN DO:
            MESSAGE "กรมธรรม์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
            ASSIGN wdetail.prepol  = "Already Renew"  /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
                wdetail.comment = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
                wdetail.OK_GEN  = "N"
                wdetail.pass    = "N". 
        END.
        ELSE DO: 
            ASSIGN
                wdetail.prepol = sicuw.uwm100.policy
                n_rencnt       = sicuw.uwm100.rencnt  +  1
                n_endcnt       =  0
                wdetail.pass   = "Y".
            RUN proc_assignrenew.  /*รับค่า ความคุ้มครองของเก่า */
        END.
    END.                           /*  avail  buwm100  */
    Else do:  
        ASSIGN
            n_rencnt  =  0  
            n_Endcnt  =  0
            wdetail.prepol   = ""
            wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".
    END.                           /*not  avail uwm100*/
    IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".
END.      /* sicuw.uwm301 */
ELSE DO:
    ASSIGN wdetail.comment = wdetail.comment + "| ไม่พบเลขตัวถังในการต่ออายุ " 
           wdetail.OK_GEN  = "N"
           wdetail.pass    = "N".
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew72 c-Win 
PROCEDURE proc_renew72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_year  AS INTE INIT 0.
DEF VAR nv_vehregf  AS CHAR INIT "".                     /*A57-0108 kridtiya i. date 20/03/2014 */
DEF VAR nv_comdatf  AS CHAR FORMAT "x(10)" INIT "" .     /*A57-0108 kridtiya i. date 20/03/2014 */
DEF VAR nv_expdatf  AS CHAR FORMAT "x(10)" INIT "" .     /*A57-0108 kridtiya i. date 20/03/2014 */
ASSIGN nv_vehregf  = ""                                  /*A57-0108 kridtiya i. date 20/03/2014 */
    nv_comdatf     = ""                                  /*A57-0108 kridtiya i. date 20/03/2014 */
    nv_expdatf     = ""                                  /*A57-0108 kridtiya i. date 20/03/2014 */
    nv_vehregf     = wdetail.vehreg                      /*A57-0108 kridtiya i. date 20/03/2014 */
    nv_comdatf     = wdetail.comdat                      /*A57-0108 kridtiya i. date 20/03/2014 */
    nv_expdatf     = wdetail.expdat                      /*A57-0108 kridtiya i. date 20/03/2014 */
    n_year           = YEAR(TODAY) + 543
    n_year           = n_year - 1 
    wdetail.agent    = fi_agent       
    wdetail.producer = fi_producer   .
IF LENGTH(wdetail.prepol) < 12  THEN DO:
    IF      LENGTH(wdetail.prepol) = 6 THEN wdetail.prepol = "D072" + (SUBSTR(string(n_year),3,2)) +  wdetail.prepol.
    ELSE IF LENGTH(wdetail.prepol) = 1 THEN wdetail.prepol = "D072" + (SUBSTR(string(n_year),3,2)) + "00000" + wdetail.prepol.
    ELSE IF LENGTH(wdetail.prepol) = 2 THEN wdetail.prepol = "D072" + (SUBSTR(string(n_year),3,2)) + "0000" + wdetail.prepol.
    ELSE IF LENGTH(wdetail.prepol) = 3 THEN wdetail.prepol = "D072" + (SUBSTR(string(n_year),3,2)) + "000" + wdetail.prepol.
    ELSE IF LENGTH(wdetail.prepol) = 4 THEN wdetail.prepol = "D072" + (SUBSTR(string(n_year),3,2)) + "00" + wdetail.prepol.
    ELSE IF LENGTH(wdetail.prepol) = 5 THEN wdetail.prepol = "D072" + (SUBSTR(string(n_year),3,2)) + "0" + wdetail.prepol.
END.
ELSE DO:
    IF LENGTH(wdetail.prepol) > 12  THEN RUN proc_cutchar72.
END.

FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail.prepol   No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF sicuw.uwm100.releas = NO THEN DO:
        /*MESSAGE "Policy no. / Endorsement"  "ยังไม่ได้ทำการโอนไป บ/ช ไม่สามารถทำงานต่ออายุได้".*/
        ASSIGN  
            wdetail.comment = wdetail.comment + "| ยังไม่ได้ทำการโอนไป บ/ช ไม่สามารถทำงานต่ออายุได้" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
    IF sicuw.uwm100.renpol <> " " THEN DO:
        /*MESSAGE "กรมธรรม์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .*/
        ASSIGN wdetail.prepol  = "Already Renew"   /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
            wdetail.comment = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" + sicuw.uwm100.policy
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
    ELSE DO: 
        ASSIGN  
            wdetail.prepol    = sicuw.uwm100.policy
            wdetail.n_insured = sicuw.uwm100.insref 
            wdetail.n_opnpol  = sicuw.uwm100.opnpol
            wdetail.tiname    = sicuw.uwm100.ntitle
            wdetail.insnam    = sicuw.uwm100.name1 
            wdetail.name2     = sicuw.uwm100.name2
            wdetail.name3     = sicuw.uwm100.name3
            wdetail.addr_1    = sicuw.uwm100.addr1 
            wdetail.addr_2    = sicuw.uwm100.addr2 
            wdetail.addr_3    = sicuw.uwm100.addr3 
            wdetail.addr_4    = sicuw.uwm100.addr4 
            wdetail.n_branch  = sicuw.uwm100.branch
            /*comment by .. .kridtiya i. A57-0108  
            wdetail.comdat    = IF (string(day(sicuw.uwm100.expdat),"99") = "29") AND (string(MONTH(sicuw.uwm100.expdat),"99") = "02")
                                THEN  "01/03/" + string(YEAR(sicuw.uwm100.expdat),"9999")  
                                ELSE string(sicuw.uwm100.expdat,"99/99/9999")
            wdetail.expdat    = IF (string(day(sicuw.uwm100.expdat),"99") = "29") AND (string(MONTH(sicuw.uwm100.expdat),"99") = "02")
                                THEN  "01/03/" + string(YEAR(sicuw.uwm100.expdat) + 1,"9999")  
                                ELSE string(day(sicuw.uwm100.expdat),"99") + "/" +
                                string(MONTH(sicuw.uwm100.expdat),"99") + "/" +
                                string(YEAR(sicuw.uwm100.expdat) + 1,"9999")  
                               comment by ...kridtiya i. A57-0108 */ 
            n_rencnt          = sicuw.uwm100.rencnt  +  1
            n_endcnt          =  0
            wdetail.pass      = "Y" .
        /*add...kridtiya i. A57-0108 */
        IF wdetail.comdat = "" THEN 
            ASSIGN wdetail.comdat    = IF (string(day(sicuw.uwm100.expdat),"99") = "29") AND (string(MONTH(sicuw.uwm100.expdat),"99") = "02")
                                THEN  "01/03/" + string(YEAR(sicuw.uwm100.expdat),"9999")  
                                ELSE string(sicuw.uwm100.expdat,"99/99/9999").
        IF wdetail.expdat    = "" THEN
            ASSIGN wdetail.expdat    = IF (string(day(sicuw.uwm100.expdat),"99") = "29") AND (string(MONTH(sicuw.uwm100.expdat),"99") = "02")
                                THEN  "01/03/" + string(YEAR(sicuw.uwm100.expdat) + 1,"9999")  
                                ELSE string(day(sicuw.uwm100.expdat),"99") + "/" +
                                string(MONTH(sicuw.uwm100.expdat),"99") + "/" +
                                string(YEAR(sicuw.uwm100.expdat) + 1,"9999")  .
        /*end...kridtiya i. A57-0108 */
        FIND FIRST  sicuw.uwm120 USE-INDEX uwm12001     WHERE
            sicuw.uwm120.policy  = sicuw.uwm100.policy  AND 
            sicuw.uwm120.rencnt  = sicuw.uwm100.rencnt  AND 
            sicuw.uwm120.endcnt  = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm120 THEN                      
            ASSIGN wdetail.firstdat = string(sicuw.uwm100.fstdat)  
            wdetail.subclass = sicuw.uwm120.class.      
        FIND LAST sicuw.uwm301 USE-INDEX uwm30101       WHERE
            sicuw.uwm301.policy = sicuw.uwm100.policy   AND
            sicuw.uwm301.rencnt = sicuw.uwm100.rencnt   AND
            sicuw.uwm301.endcnt = sicuw.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm301 THEN DO:
            ASSIGN 
                wdetail.garage   = sicuw.uwm301.garage  
                wdetail.redbook  = sicuw.uwm301.modcod            /* redbook  */   
                /*wdetail.brand    = trim(substr(sicuw.uwm301.moddes,1,INDEX(sicuw.uwm301.moddes," ") - 1))
                wdetail.model    = trim(substr(sicuw.uwm301.moddes,INDEX(sicuw.uwm301.moddes," ") - 1)) */
                wdetail.brand    = IF INDEX(sicuw.uwm301.moddes," ") = 0 THEN  TRIM(sicuw.uwm301.moddes) 
                                   ELSE trim(substr(sicuw.uwm301.moddes,1,INDEX(sicuw.uwm301.moddes," ") - 1))
                wdetail.model    = "" 
                wdetail.eng      = sicuw.uwm301.eng_no          /*หมายเลขเครื่อง  */                      
                wdetail.vehuse   = sicuw.uwm301.vehuse          
                /*wdetail.vehreg   = sicuw.uwm301.vehreg   *//* .kridtiya i. A57-0108 */    
                wdetail.vehreg   = IF wdetail.vehreg = "" THEN trim(sicuw.uwm301.vehreg) ELSE trim(wdetail.vehreg) /* .kridtiya i. A57-0108 */    
                wdetail.chasno   = trim(sicuw.uwm301.cha_no)    
                wdetail.caryear  = string(sicuw.uwm301.yrmanu)  /*รุ่นปี          */
                wdetail.covcod   = sicuw.uwm301.covcod          
                wdetail.body     = sicuw.uwm301.body            /*แบบตัวถัง       */                                       
                wdetail.engcc    = string(sicuw.uwm301.engine)  /*ปริมาตรกระบอกสูบ*/  
                wdetail.tons     = string(sicuw.uwm301.tons)    
                wdetail.seat     = sicuw.uwm301.seats           /*จำนวนที่นั่ง    */ 
                wdetail.cargrp   = sicuw.uwm301.vehgrp          /*กลุ่มรถยนต์     */    .   

            FOR EACH sicuw.uwd132 USE-INDEX uwd13290  WHERE
                sicuw.uwd132.policy   = sicuw.uwm301.policy  AND
                sicuw.uwd132.rencnt   = sicuw.uwm301.rencnt  AND
                sicuw.uwd132.endcnt   = sicuw.uwm301.endcnt  AND
                sicuw.uwd132.riskno   = 1                    AND
                sicuw.uwd132.itemno   = 1                    NO-LOCK .
                IF sicuw.uwd132.bencod  = "comp" THEN
                    ASSIGN   wdetail.comp_prm   = string(sicuw.uwd132.prem_c).  
            END.
        END.    /*avail 301*/
    END.        /*else renpol = "" */
END.            /*  avail  uwm100  */
Else do:  
    ASSIGN
        n_rencnt        =  0  
        n_Endcnt        =  0
        wdetail.prepol  = ""
        wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".
END.    /*not  avail uwm100*/
IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".
IF nv_vehregf <> "" THEN  ASSIGN  wdetail.vehreg   =  trim(nv_vehregf)  .   /*A57-0108 kridtiya i. date 20/03/2014 */
IF nv_comdatf <> "" THEN  ASSIGN  wdetail.comdat   =  trim(nv_comdatf)  .   /*A57-0108 kridtiya i. date 20/03/2014 */
IF nv_expdatf <> "" THEN  ASSIGN  wdetail.expdat   =  trim(nv_expdatf)  .   /*A57-0108 kridtiya i. date 20/03/2014 */
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
FOR EACH wdetail  WHERE wdetail.PASS <> "Y"  :
        NOT_pass = NOT_pass + 1.
END.
IF NOT_pass > 0 THEN DO:
OUTPUT STREAM ns1 TO value(fi_output2).
PUT STREAM ns1
    "redbook "     ","
    "n_branch"     "," 
    "policy  "     "," 
    "comment "     "," 
    "comdat  "      ","  
    "expdat  "      ","  
    "covcod  "      ","  
    "garage  "      ","  
    "tiname  "      ","  
    "insnam  "      ","  
    "name2   "      ","  
    "addr_1  "      ","  
    "addr_2  "      ","  
    "addr_3  "      ","  
    "addr_4  "      ","  
    "cndat   "      ","  
    "brand   "      ","  
    "cargrp  "      ","  
    "chasno  "      ","  
    "eng     "      ","  
    "model   "      ","  
    "caryear "      ","  
    "body   "      ","  
    "vehuse "       ","  
    "seat   "       ","  
    "engcc  "       ","  
    "vehreg "       ","  
    "re_country"       ","  
    "si    "       ","  
    "premt "       ","  
    "rstp_t"       ","  
    "rtax_t"       ","  
    "prem_r"       ","  
    "gap   "       ","  
    "ncb   "       ","  
    "stk   "       ","  
    "prepol"       ","  
    "benname"      ","  
    "comper"       ","  
    "comacc"       ","  
    "deductpd"       ","  
    "deduct  "       ","  
    "compul  "      ","  
    "pass    "      ","  
    "NO_41   "      ","  
    "NO_42   "      ","  
    "NO_43   "      ","  
    "caryear "      ","  
    "WARNING "      SKIP.  
FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"   :   
    PUT STREAM ns1 
        wdetail.redbook     "," 
        wdetail.n_branch    "," 
        wdetail.policy      ","
        wdetail.comment     ","
        wdetail.comdat      ","
        wdetail.expdat      ","
        wdetail.covcod      ","
        wdetail.garage      "," 
        wdetail.tiname      ","
        wdetail.insnam      ","
        wdetail.name2       ","  
        wdetail.addr_1      ","  
        wdetail.addr_2      ","  
        wdetail.addr_3      ","  
        wdetail.addr_4      ","  
        wdetail.cndat       ","
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
        wdetail.si          "," 
        wdetail.premt       "," 
        wdetail.rstp_t      "," 
        wdetail.rtax_t      "," 
        wdetail.prem_r      "," 
        wdetail.gap         "," 
        wdetail.ncb         "," 
        wdetail.stk         "," 
        wdetail.prepol      "," 
        wdetail.benname     ","   
        wdetail.comper      ","   
        wdetail.comacc      ","   
        wdetail.deductpd    ","   
        wdetail.deduct      ","   
        wdetail.compul      ","   
        wdetail.pass        ","     
        wdetail.NO_41       ","   
        wdetail.NO_42       ","   
        wdetail.NO_43       ","   
        wdetail.caryear     "," 
        wdetail.WARNING     SKIP.  
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
FOR EACH  wdetail   WHERE 
        wdetail.PASS = "Y"  :
        pass = pass + 1.

END.
IF pass > 0 THEN DO:
OUTPUT STREAM ns2 TO value(fi_output1).
PUT STREAM NS2
    "redbook "  "," 
    "n_branch"  ","   
    "policy  "  ","   
    "comment "  "," 
    "comdat  "  ","  
    "expdat  "  ","  
    "covcod  "  ","  
    "garage  "  ","  
    "tiname  "  ","  
    "insnam  "  ","  
    "name2   "  ","  
    "addr_1  "  ","  
    "addr_2  "  ","  
    "addr_3  "  ","  
    "addr_4  "  ","  
    "cndat   "  ","  
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
    "re_country"  ","  
    "si     "   ","  
    "premt  "   ","  
    "rstp_t "   ","  
    "rtax_t "   ","  
    "prem_r "   ","  
    "gap    "   ","  
    "ncb    "   ","  
    "stk    "   ","  
    "prepol "   ","  
    "benname"   ","  
    "comper "   ","  
    "comacc "   ","  
    "deductpd"  ","  
    "deduct "   ","  
    "compul "   ","  
    "pass   "   ","  
    "NO_41  "   ","  
    "NO_42  "   ","  
    "NO_43  "   ","  
    "caryear"   ","  
    "WARNING"        SKIP.        
FOR EACH  wdetail WHERE wdetail.PASS = "Y"  :
    PUT STREAM ns2
        wdetail.redbook      ","   
        wdetail.n_branch      ","   
        wdetail.policy        ","
        wdetail.comment       ","
        wdetail.comdat        ","
        wdetail.expdat        ","
        wdetail.covcod        ","
        wdetail.garage        "," 
        wdetail.tiname        ","
        wdetail.insnam        ","
        wdetail.name2         ","  
        wdetail.addr_1        ","  
        wdetail.addr_2        ","  
        wdetail.addr_3        ","  
        wdetail.addr_4        ","  
        wdetail.cndat         ","
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
        wdetail.re_country    "," 
        wdetail.si            "," 
        wdetail.premt         "," 
        wdetail.rstp_t        "," 
        wdetail.rtax_t        "," 
        wdetail.prem_r        "," 
        wdetail.gap           "," 
        wdetail.ncb           "," 
        wdetail.stk           ","
        wdetail.prepol        ","
        wdetail.benname       ","   
        wdetail.comper        ","   
        wdetail.comacc        ","   
        wdetail.deductpd      ","   
        wdetail.deduct        ","   
        wdetail.compul        ","   
        wdetail.pass          ","     
        wdetail.NO_41         ","   
        wdetail.NO_42         ","   
        wdetail.NO_43         ","   
        wdetail.caryear       ","   
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
"IMPORT TEXT FILE YAKULT " SKIP
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
      /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. /*test*/*/
      /*CONNECT expiry -H 18.10.100.5 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/

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
    nv_idnolist    = trim(nn_icno) .

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
/*create  text (F17) for Query claim....*/
DEFINE  VAR sv_fptr AS RECID no-undo.                
DEFINE  VAR sv_bptr AS RECID no-undo.                
DEFINE VAR nvw_bptr        AS RECID.                
DEFINE VAR nvw_fptr        AS RECID.                
DEFINE VAR nvw_index       AS INTEGER.              
DEFINE VAR nvw_dl          AS INTEGER INITIAL[14].  
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
    WHERE uwm100.policy     = wdetail.prepol NO-LOCK NO-ERROR.
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
        FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
            sic_bran.uwm100.policy  = wdetail.policy    AND
            sic_bran.uwm100.rencnt  = n_rencnt          AND
            sic_bran.uwm100.endcnt  = n_endcnt          AND
            sic_bran.uwm100.bchyr   = nv_batchyr        AND
            sic_bran.uwm100.bchno   = nv_batchno        AND
            sic_bran.uwm100.bchcnt  = nv_batcnt         NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwm100 THEN DO:
            FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
                CREATE sic_bran.uwd100.
                ASSIGN
                    sic_bran.uwd100.bptr    = nv_bptr
                    sic_bran.uwd100.fptr    = 0
                    sic_bran.uwd100.policy  = wdetail.policy
                    sic_bran.uwd100.rencnt  = n_rencnt
                    sic_bran.uwd100.endcnt  = n_endcnt
                    sic_bran.uwd100.ltext   = wuppertxt.txt .
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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100new c-Win 
PROCEDURE proc_uwd100new :
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
FIND LAST wtext17 WHERE wtext17.as_policyF17 = wdetail.policy NO-LOCK NO-ERROR.
IF AVAIL wtext17 THEN DO:
    ASSIGN 
        nv_txt3  =  wtext17.as_texF17_1   
        nv_txt4  =  wtext17.as_texF17_2    
        nv_txt5  =  wtext17.as_texF17_3    .
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
DEFINE  VAR sv_fptr AS RECID no-undo.
DEFINE  VAR sv_bptr AS RECID no-undo.
DEFINE VAR nvw_fptr        AS RECID.                   
DEFINE VAR nvw_index       AS INTEGER.                 
DEFINE VAR nvw_dl          AS INTEGER INITIAL[14].     
DEFINE VAR nvw_prev        AS RECID INITIAL[0].       
DEFINE VAR nvw_next        AS RECID INITIAL[0].       
DEFINE VAR nvw_list        AS LOGICAL INITIAL[YES].
DEF VAR n_num1 AS INTE INIT 0.
DEF VAR n_num2 AS INTE INIT 0.
DEF VAR n_num3 AS INTE INIT 1.
DEF VAR i AS INTE INIT 0.
DEF VAR n_text1 AS CHAR FORMAT "x(255)".
DEF VAR n_numtxt AS INTE INIT 0.
ASSIGN nv_fptr = 0
       nv_bptr = 0
       nv_nptr = 0
       nv_line1 = 0
    n_numtxt = 0.
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE uwm100.policy =  wdetail.prepol  NO-LOCK NO-ERROR.
IF AVAILABLE uwm100 THEN DO :
    sv_fptr = uwm100.fptr02.
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
        
        Assign 
            nvw_list = NO
            nv_fptr = 0 
            nv_bptr = 0  
            nv_nptr = 0. 
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
            ASSIGN 
                sic_bran.uwm100.bptr02 = nv_bptr 
                n_numtxt = 0.
        END.
    END.  /******/
END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102new c-Win 
PROCEDURE proc_uwd102new :
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

FIND LAST wtext18 WHERE wtext18.as_policyF18  = wdetail.policy NO-LOCK NO-ERROR.
IF AVAIL wtext18 THEN DO:
    DO WHILE nv_line1 <= 11:
        CREATE wuppertxt3.                                                                                 
        wuppertxt3.line = nv_line1.     
        IF nv_line1 = 3  THEN wuppertxt3.txt =   wtext18.as_texF18_1 .  
        IF nv_line1 = 4  THEN wuppertxt3.txt =   wtext18.as_texF18_2 .                                      
        IF nv_line1 = 5  THEN wuppertxt3.txt =   wtext18.as_texF18_3 .
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
    END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

