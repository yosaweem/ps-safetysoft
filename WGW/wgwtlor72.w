&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases sic_test         PROGRESS                        */
  File: 
  Description: 
  Input Parameters:<none>
  Output Parameters:<none>
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
/****************************  Definitions  ************************** */
/*Parameters Definitions ---                                           */
/*Local Variable Definitions ---                                       */  
/*******************************/                                      
/*programid   : wgwtlor72.w                                             */ 
/*programname : Load text file ORICO V72 to GW                          */ 
/* Copyright  : Safety Insurance Public Company Limited                */
/*copy write  : wgwtlori.w                                             */ 
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                     */
/* create by : Ranu I. A62-0454  14/10/2019                            */
/*             Load text file ORICO compulsory (V72) to gw             */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Kridtiya i. A66-0239 Date. 04/11/2023 ปรับการรับค่า Agent จากไฟล์แจ้งงาน*/
/*---------------------------------------------------------------------*/
{wgw\wgwtlor72.i}      /*ประกาศตัวแปร*/
DEF VAR n_ratmin  AS INTE INIT 0.
DEF VAR n_ratmax  AS INTE INIT 0.
DEF VAR n_brand   AS CHAR FORMAT "x(50)"  INIT "".
DEF VAR n_model   AS CHAR FORMAT "x(50)"  INIT "".
DEF VAR n_index   AS INTE  INIT 0.
DEF VAR stklen    AS INTE.
DEF VAR aa        AS DECI .
DEF NEW SHARED    VAR nv_message AS char.
DEF NEW SHARED    VAR nv_producer AS CHAR FORMAT "x(10)".     
DEF NEW SHARED    VAR nv_agent    AS CHAR FORMAT "x(10)".     
DEF NEW SHARED    VAR nv_riskno   Like  sicuw.uwm301.riskgp.  
DEF NEW SHARED    VAR nv_itemno   Like  sicuw.uwm301.itemno.  
DEF SHARED Var   n_User    As CHAR format "x(10)".                   
DEF SHARED Var   n_PassWd  As CHAR format "x(15)".   
DEF NEW SHARED VAR nv_seat41 AS INTEGER FORMAT ">>9". 
DEF NEW SHARED VAR nv_totsi  AS DECIMAL FORMAT ">>,>>>,>>9.99-".                          
DEF NEW SHARED VAR nv_polday AS INTE    FORMAT ">>9".                                   
def New SHARED VAR nv_uom6_u as char.  
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".                    
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .                             
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .                
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".                
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.            
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.            
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.  
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
DEF NEW SHARED VAR nv_engine LIKE sicsyac.xmm102.engine.                
DEF NEW SHARED VAR nv_tons   LIKE sicsyac.xmm102.tons.              
DEF NEW SHARED VAR nv_seats  LIKE sicsyac.xmm102.seats.                 
DEF NEW SHARED VAR nv_sclass  AS CHAR FORMAT "x(3)".                    
DEF NEW SHARED VAR nv_engcod  AS CHAR FORMAT "x(4)".                   
DEF NEW SHARED VAR nv_engprm  AS DECI  FORMAT ">>,>>>,>>9.99-".      
DEF NEW SHARED VAR nv_engvar1 AS CHAR  FORMAT "X(30)".              
DEF NEW SHARED VAR nv_engvar2 AS CHAR  FORMAT "X(30)".              
DEF NEW SHARED VAR nv_engvar  AS CHAR  FORMAT "X(60)".          
def  New  shared var  nv_poltyp   as   char   init  "".              
DEF NEW SHARED VAR nv_yrcod   AS CHARACTER FORMAT "X(4)".            
DEF NEW SHARED VAR nv_yrprm   AS DECI  FORMAT ">>,>>>,>>9.99-".      
DEF NEW SHARED VAR nv_yrvar1  AS CHAR  FORMAT "X(30)".               
DEF NEW SHARED VAR nv_yrvar2  AS CHAR  FORMAT "X(30)".                
DEF NEW SHARED VAR nv_yrvar   AS CHAR  FORMAT "X(60)".                
DEF New shared VAR nv_caryr   AS INTE  FORMAT ">>>9" .                
def New shared  var nv_dspc   as  deci.    
def New shared  var nv_mv1    as  int .    
def New shared  var nv_mv1_s  as  int .    
def New shared  var nv_mv2    as  int .    
def New shared  var nv_mv3    as  int .    
def New shared  var nv_comprm as  int .    
def New shared  var nv_model  as  char.    
DEF NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".  
def NEW SHARED  var nv_modulo  as int  format "9".
def NEW SHARED  var nv_branch  AS CHAR FORMAT "x(3)" . 
def New shared  var nv_makdes  as   char    .
def New shared  var nv_moddes  as   char.
DEFINE VAR  n_insref     AS CHARACTER FORMAT "X(10)". 
DEFINE VAR  nv_messagein AS CHAR FORMAT "X(200)". 
DEFINE VAR  nv_usrid     AS CHARACTER FORMAT "X(08)".
DEFINE VAR  nv_transfer  AS LOGICAL   .
DEFINE VAR  n_check      AS CHARACTER .
DEFINE VAR  nv_insref    AS CHARACTER FORMAT "X(10)". 
DEFINE VAR  putchr       AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEFINE VAR  putchr1      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEFINE VAR  nv_typ       AS CHAR FORMAT "X(2)".
def var np_tiname as char format "x(15)" init "".    
def var np_insnam as char format "x(50)" init "".    
def var np_name2  as char format "x(50)" init "". 
def var np_name3  as char format "x(50)" init "". 
def var np_addr1  as char format "x(50)" init "".    
def var np_addr2  as char format "x(50)" init "".    
def var np_addr3  as char format "x(50)" init "".    
def var np_addr4  as char format "x(50)" init "".
DEF Var nv_txt1 As Char Format "X(150)" init "".
DEF Var nv_txt2 As Char Format "X(150)" init "".
DEF Var nv_txt3 As Char Format "X(150)" init "".
DEF Var nv_txt4 As Char Format "X(150)" init "".
DEF Var nv_txt5 As Char Format "X(150)" init "".
def var n_address  as char format "x(255)".
def var n_build    as char format "x(50)".
def var n_mu       as char format "x(50)".
def var n_soi      as char format "x(50)".
def var n_road     as char format "x(50)".
def var n_tambon   as char format "x(50)".
def var n_amper    as char format "x(50)".
def var n_country  as char format "x(50)".
def var n_post     as char format "x(50)".
DEF VAR n_length   AS INT.
def var n_nametax  as char format "x(60)".
def var n_taxno    as char format "x(15)".
DEF VAR ns_polnew   AS CHAR FORMAT "x(13)" .

DEF NEW  SHARED VAR nv_pdprm0   AS DECI FORMAT ">>,>>>,>>9.99-"  INITIAL 0  .

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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.poltyp wdetail.policy wdetail.prepol wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.addr1 wdetail.addr2 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.engcc wdetail.tons wdetail.seat wdetail.body wdetail.vehreg wdetail.eng wdetail.chasno wdetail.caryear wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.volprem wdetail.fleet wdetail.deductpd wdetail.benname wdetail.n_IMPORT wdetail.n_export wdetail.drivnam wdetail.producer wdetail.agent wdetail.comment WDETAIL.WARNING wdetail.cancel wdetail.redbook /*add new*/   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_wdetail FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_form rs_type buimp buok fi_loaddat ~
fi_companoti fi_branch fi_bchno fi_prevbat fi_bchyr fi_filename fi_output1 ~
fi_output2 fi_output3 fi_usrcnt fi_usrprem br_wdetail fi_process fi_fileexp ~
buext bu_hpbrn RECT-370 RECT-373 RECT-376 RECT-379 RECT-380 
&Scoped-Define DISPLAYED-OBJECTS rs_type fi_loaddat fi_companoti fi_branch ~
fi_bchno fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 ~
fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_process fi_fileexp ~
fi_completecnt fi_premtot fi_premsuc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buext 
     LABEL "EXIT" 
     SIZE 15 BY 1.14.

DEFINE BUTTON buimp 
     LABEL "..." 
     SIZE 4 BY .95
     FONT 6.

DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 15 BY 1.14.

DEFINE BUTTON bu_form 
     LABEL "Exp" 
     SIZE 6 BY 1.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY .95
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
     SIZE 33.5 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_companoti AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_fileexp AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY .95
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
     SIZE 18 BY .95
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Load Text File", 1,
"Match Policy", 2
     SIZE 47 BY .95
     BGCOLOR 29 FGCOLOR 7  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.71
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 6.38
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 2.71
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18 BY 1.91
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18 BY 1.91
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
      wdetail.poltyp     COLUMN-LABEL "Policy Type"
        wdetail.policy   COLUMN-LABEL "Policy"
        wdetail.prepol   COLUMN-LABEL "Renew Policy"
        wdetail.tiname   COLUMN-LABEL "Title Name"   
        wdetail.insnam   COLUMN-LABEL "Insured Name" 
        wdetail.comdat   COLUMN-LABEL "Comm Date"
        wdetail.expdat   COLUMN-LABEL "Expiry Date"
        wdetail.compul   COLUMN-LABEL "Compulsory"
                         
        wdetail.addr1    COLUMN-LABEL "Ins Add1"
        wdetail.addr2    COLUMN-LABEL "Ins Add2"
        wdetail.prempa   COLUMN-LABEL "Premium Package"
        wdetail.subclass COLUMN-LABEL "Sub Class"
        wdetail.brand    COLUMN-LABEL "Brand"
        wdetail.model    COLUMN-LABEL "Model"
        wdetail.engcc    COLUMN-LABEL "CC"
        wdetail.tons     COLUMN-LABEL "Weight"
        wdetail.seat     COLUMN-LABEL "Seat"
        wdetail.body     COLUMN-LABEL "Body"
        wdetail.vehreg   COLUMN-LABEL "Vehicle Register"
        wdetail.eng      COLUMN-LABEL "Engine NO."
        wdetail.chasno   COLUMN-LABEL "Chassis NO."
        wdetail.caryear  COLUMN-LABEL "Car Year" 
        wdetail.vehuse   COLUMN-LABEL "Vehicle Use" 
        wdetail.garage   COLUMN-LABEL "Garage"
        wdetail.stk      COLUMN-LABEL "Sticker"
        wdetail.covcod   COLUMN-LABEL "Cover Type"
        wdetail.si       COLUMN-LABEL "Sum Insure"
        wdetail.volprem  COLUMN-LABEL "Voluntory Prem"
        wdetail.fleet    COLUMN-LABEL "Fleet"
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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 5.81
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .71.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_form AT ROW 6.05 COL 75.5
     rs_type AT ROW 2.91 COL 79.5 NO-LABEL
     buimp AT ROW 7.19 COL 89.5
     buok AT ROW 10.1 COL 114.33
     fi_loaddat AT ROW 2.95 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_companoti AT ROW 2.95 COL 59.83 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 20.95 COL 13.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_prevbat AT ROW 5.1 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 5.05 COL 59.5 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 7.1 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_output1 AT ROW 8.1 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 9.1 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 10.14 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 12.38 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 12.43 COL 68 NO-LABEL
     fi_brndes AT ROW 4 COL 38.33 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 13.91 COL 2.5
     fi_impcnt AT ROW 20.38 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 11.33 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_fileexp AT ROW 6.1 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 21.38 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 20.38 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 21.38 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     buext AT ROW 11.81 COL 114.33
     bu_hpbrn AT ROW 3.95 COL 35.67
     "                     Branch :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 4 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 20.38 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 2.95 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 5.05 COL 48
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 9.14 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "CompanyNotify :" VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 2.95 COL 45.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 12.43 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 12.38 COL 86.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Format File Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 6.05 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Previous Batch No.  :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 5.05 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Day: 08/11/2023" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 8.14 COL 113.17 WIDGET-ID 2
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 22.33 BY .95 AT ROW 20.38 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 21.38 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 12.38 COL 43.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 20.38 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 22.05
         BGCOLOR 19 FGCOLOR 1 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY .95 AT ROW 21.38 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 21.38 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 8.1 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 20.95 COL 3
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Load Text File Compulsory V72  (ORICO)" VIEW-AS TEXT
          SIZE 128.5 BY .95 AT ROW 1.43 COL 2.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 10.19 COL 6
          BGCOLOR 8 FGCOLOR 1 
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 7.1 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-373 AT ROW 13.62 COL 1.5
     RECT-376 AT ROW 20.05 COL 1
     RECT-379 AT ROW 9.67 COL 112.83
     RECT-380 AT ROW 11.48 COL 112.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 22.05
         BGCOLOR 19 FGCOLOR 1 FONT 6.


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
         TITLE              = "Load Text file ORICO (V72)"
         HEIGHT             = 22
         WIDTH              = 132.83
         MAX-HEIGHT         = 35.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 35.33
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
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY .95 AT ROW 20.38 COL 58.83 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 22.33 BY .95 AT ROW 20.38 COL 96 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY .95 AT ROW 21.38 COL 58.83 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY .95 AT ROW 21.38 COL 96 RIGHT-ALIGNED           */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_wdetail FOR EACH wdetail.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* Load Text file ORICO (V72) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text file ORICO (V72) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buext c-Win
ON CHOOSE OF buext IN FRAME fr_main /* EXIT */
DO:
     APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buimp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buimp c-Win
ON CHOOSE OF buimp IN FRAME fr_main /* ... */
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
         IF rs_type <> 2 THEN DO:
            ASSIGN
               fi_filename  = cvData
               fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
               fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
               fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
         END.
         ELSE 
             ASSIGN fi_filename  = cvData
                    fi_output1   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + "_Matchpol" + no_add + ".csv" /*.csv*/
                    fi_output2   = ""
                    fi_output3   = "" .

         DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    IF rs_type = 1 THEN DO:
        ASSIGN
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2
            fi_completecnt         = 0
            fi_premsuc             = 0
            fi_bchno               = ""
            fi_premtot             = 0
            fi_impcnt              = 0
            fi_process             = "Strat Load text Orico   ".
        DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
        IF fi_branch = " " THEN DO: 
            MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
            APPLY "entry" TO fi_branch.
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
        ASSIGN fi_output1 = INPUT fi_output1
            fi_output2    = INPUT fi_output2
            fi_output3    = INPUT fi_output3 .
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
            FIND LAST 
                uzm700 USE-INDEX uzm70002      WHERE 
                uzm700.bchyr   = nv_batchyr          AND
                uzm700.acno    = "B300303"           AND
                uzm700.branch  = TRIM(nv_batbrn)     NO-LOCK NO-ERROR .
            IF AVAIL uzm700 THEN DO:   
                ASSIGN nv_batrunno = uzm700.runno.
                FIND LAST uzm701 USE-INDEX uzm70102     WHERE 
                    uzm701.bchyr   = nv_batchyr         AND
                    uzm701.bchno   = "B300303" + TRIM(nv_batbrn) + string(nv_batrunno,"9999")  NO-LOCK NO-ERROR.
                IF AVAIL uzm701 THEN  
                    ASSIGN 
                    nv_batcnt   = uzm701.bchcnt 
                    nv_batrunno = nv_batrunno + 1.
            END.
            ELSE  
                ASSIGN nv_batcnt = 1
                    nv_batrunno  = 1.
            ASSIGN nv_batchno = CAPS("B300303") + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
        END.
        ELSE DO:  
            ASSIGN nv_batprev = INPUT fi_prevbat.
            FIND LAST uzm701 USE-INDEX uzm70102     WHERE 
                uzm701.bchyr   = nv_batchyr         AND
                uzm701.bchno   = CAPS(nv_batprev)   NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL uzm701 THEN DO:
                MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev) + " on file uzm701" .
                APPLY "entry" TO fi_prevbat.
                RETURN NO-APPLY.
            END.
            IF AVAIL uzm701 THEN  
                ASSIGN nv_batcnt  = uzm701.bchcnt + 1
                nv_batchno = CAPS(TRIM(nv_batprev)).
        END.
        ASSIGN
            fi_loaddat    = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
            fi_bchyr      = INPUT fi_bchyr       fi_prevbat      = INPUT fi_prevbat
            fi_usrcnt     = INPUT fi_usrcnt      fi_usrprem      = INPUT fi_usrprem
            nv_imppol     = fi_usrcnt            nv_impprem      = fi_usrprem 
            nv_tmppolrun  = 0                    nv_daily        = ""
            nv_reccnt     = 0                    nv_completecnt  = 0
            nv_netprm_t   = 0                    nv_netprm_s     = 0
            nv_batbrn     = fi_branch .
        For each  wdetail :
            DELETE  wdetail.
        END.
        RUN proc_assign. 
        FOR EACH wdetail:
            IF (WDETAIL.POLTYP = "v70") OR (WDETAIL.POLTYP = "v72") THEN 
                ASSIGN
                nv_reccnt      =  nv_reccnt   + 1
                nv_netprm_t    =  nv_netprm_t + decimal(wdetail.premt)
                wdetail.pass   = "Y". 
            ELSE  DELETE WDETAIL.
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
                               INPUT            "B300303"  ,     /* CHAR  */ 
                               INPUT            nv_batbrn  ,     /* CHAR  */
                               INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                               INPUT            "WGWtlori" ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                               INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                               INPUT            nv_imppol  ,     /* INT   */
                               INPUT            nv_impprem ).    /* DECI  */
        ASSIGN  fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
        DISP  fi_bchno   WITH FRAME fr_main.
        RUN proc_chktest1.  
        FOR EACH wdetail  WHERE wdetail .pass = "y"  NO-LOCK.
            ASSIGN nv_completecnt = nv_completecnt + 1
                nv_netprm_s       = nv_netprm_s    + decimal(wdetail.premt). 
        END.
        ASSIGN nv_rectot = nv_reccnt 
            nv_recsuc    = nv_completecnt . 
        IF  nv_rectot <> nv_recsuc   THEN  nv_batflg = NO.
        ELSE IF  nv_netprm_t <> nv_netprm_s THEN  
            ASSIGN nv_netprm_t  = nv_netprm_s
                   nv_batflg    = YES.
        ELSE nv_batflg = YES.
        FIND LAST uzm701 USE-INDEX uzm70102 WHERE 
            uzm701.bchyr   = nv_batchyr     AND
            uzm701.bchno   = nv_batchno     AND
            uzm701.bchcnt  = nv_batcnt      NO-ERROR.
        IF AVAIL uzm701 THEN 
            ASSIGN  uzm701.recsuc  = nv_recsuc     
                uzm701.premsuc     = nv_netprm_s   
                uzm701.rectot      = nv_rectot     
                uzm701.premtot     = nv_netprm_t   
                uzm701.impflg      = nv_batflg    
                uzm701.cnfflg      = nv_batflg .   
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
        IF nv_batflg   = NO  THEN DO:  
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
        RUN proc_assign_init.
        IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    END.
    ELSE RUN proc_matpol.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_form
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_form c-Win
ON CHOOSE OF bu_form IN FRAME fr_main /* Exp */
DO:
    IF fi_fileexp = ""  THEN DO:
        MESSAGE "Format File Load is Null !!" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_fileexp.
        RETURN NO-APPLY.
    END.

    OUTPUT STREAM ns1 TO value(fi_fileexp).
    PUT STREAM ns1
      "Type.           "         "|"
      "เลขที่กรมธรรม์  "         "|"
      "เลขเครื่องหมาย  "         "|"
      "ชื่อผู้เอาประกัน"         "|"
      "ที่อยู่         "         "|"
      "วันเริ่มคุ้มครอง/เวลา "   "|"
      "วันสิ้นสุด      "         "|"
      "รหัส            "         "|"
      "ยี่ห้อ          "         "|"
      "รุ่นรถ          "         "|"
      "ทะเบียนรถ       "         "|"
      "จังหวัด         "         "|"
      "เลขตัวถัง       "         "|"
      "ประเภท          "         "|"
      "ขนาดเครื่องยนต์ "         "|"
      "เลขเครื่องยนต์  "         "|"
      "ปีจดทะเบียน     "         "|"
      "เบี้ยสุทธิ      "         "|"
      "อากร            "         "|"
      "ภาษี            "         "|"
      "เบี้ยรวมภาษีอากร"         "|"
      "การใช้รถ        "         "|"
      "วันออกกรมธรรม์  "         "|"
      "เลขที่สัญญา     "         "|"
      "ID Card         "         "|"
      "Producer        "         "|"
      "Agent           "         "|"
      "Branch          "         "|"
      "Docno           "         "|"
      "อาชีพ           "         "|"
      "Comment         " SKIP.  
    OUTPUT STREAM ns1 CLOSE.
    MESSAGE " Export Format File Success !!" VIEW-AS ALERT-BOX.
  
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
   Apply "Entry"  To  fi_filename.
   Return no-apply.                            
                                        

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
    fi_loaddat = INPUT fi_loaddat.
    IF  Input fi_loaddat  =  ""  Then do:
        Message "กรุณาระบุ Branch Code ." View-as alert-box.
        Apply "Entry"  To  fi_branch.
    END.
    Else do:
        FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
            sicsyac.xmm023.branch   =  Input  fi_branch NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
            Message  "Not on Description Master File xmm023"  View-as alert-box.
            Apply "Entry"  To  fi_branch.
            RETURN NO-APPLY.
        END.
        ASSIGN fi_branch  =  CAPS(Input fi_branch) 
            fi_brndes  =  sicsyac.xmm023.bdes.
    END.  /*else do:*/
    Disp fi_branch  fi_brndes  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_companoti
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_companoti c-Win
ON LEAVE OF fi_companoti IN FRAME fr_main
DO:
    fi_companoti = INPUT fi_companoti .
    Disp  fi_companoti  WITH Frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_fileexp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_fileexp c-Win
ON LEAVE OF fi_fileexp IN FRAME fr_main
DO:
    fi_fileexp = INPUT fi_fileexp.
    DISP fi_fileexp WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type c-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type.
    DISP rs_type WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_wdetail
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
  
  gv_prgid = "Wgwtlor72".
  gv_prog  = "Load Text & Generate ORICO (V72)".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
      rs_type        = 1
      
      fi_companoti   = "ORICO"
      fi_branch      = "M"
      fi_bchyr       = YEAR(TODAY) 
      fi_process     = "Load Text file Orico....  ".
  DISP fi_process fi_companoti rs_type
       fi_branch  fi_bchyr  WITH FRAME fr_main.
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
  DISPLAY rs_type fi_loaddat fi_companoti fi_branch fi_bchno fi_prevbat fi_bchyr 
          fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem 
          fi_brndes fi_impcnt fi_process fi_fileexp fi_completecnt fi_premtot 
          fi_premsuc 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE bu_form rs_type buimp buok fi_loaddat fi_companoti fi_branch fi_bchno 
         fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 
         fi_usrcnt fi_usrprem br_wdetail fi_process fi_fileexp buext bu_hpbrn 
         RECT-370 RECT-373 RECT-376 RECT-379 RECT-380 
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
/************** v72 compulsory  **********/
DEF VAR stklen AS INTE.
ASSIGN  
    wdetail.compul    = "y"
    wdetail.tariff    = "9"
    wdetail.covcod    = "T"  .
IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N". 

    /* create by A61-0221*/
    IF wdetail.policy <> ""  THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = wdetail.policy NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN 
             ASSIGN wdetail.comment = wdetail.comment + "| มีเบอร์กรมธรรม์นี้ในระบบแล้ว "
             wdetail.pass    = "N"   
             wdetail.OK_GEN  = "N". 

    END.
    /* end A61-0221*/

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
        wdetail.comment      = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Type นี้"
        wdetail.OK_GEN       = "N".
END.
/*---------- covcod ----------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod  = "U013"         AND
    sicsyac.sym100.itmcod  = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
    wdetail.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  wdetail.pass = "N"  
    wdetail.comment      = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
    wdetail.OK_GEN       = "N".
/*--------- modcod --------------*/
IF INDEX(wdetail.brand,"BENZ") <> 0 THEN 
    ASSIGN wdetail.brand  =  "MERCEDES-BENZ".
ASSIGN chkred  = NO
    n_sclass72 = TRIM(wdetail.subclass).

IF      (wdetail.subclass =  "120A") OR (wdetail.subclass =  "120B") OR (wdetail.subclass =  "120C") THEN n_sclass72 = "210".
ELSE IF (wdetail.subclass =  "140A") OR (wdetail.subclass =  "140B") OR (wdetail.subclass =  "140C") THEN n_sclass72 = "320".
ELSE  n_sclass72 =  "110".

FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  wdetail.prempa + n_sclass72 NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN  n_ratmin   = makdes31.si_theft_p   
    n_ratmax   = makdes31.load_p   .    
ELSE ASSIGN  n_ratmin   = 0
    n_ratmax   = 0.
ASSIGN n_model = ""
    n_model    = IF INDEX(wdetail.model," ") <> 0 THEN SUBSTR(wdetail.model,1,INDEX(wdetail.model," ")) ELSE TRIM(wdetail.model).
Find First stat.maktab_fil USE-INDEX maktab04    Where
    stat.maktab_fil.makdes   =     wdetail.brand            And                  
    index(stat.maktab_fil.moddes,n_model) <> 0              And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
    stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
    stat.maktab_fil.sclass   =     n_sclass72               AND
    stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    ASSIGN  chkred   =  YES
    wdetail.redbook  =  stat.maktab_fil.modcod
    nv_modcod        =  stat.maktab_fil.modcod                                    
    nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
    wdetail.cargrp   =  stat.maktab_fil.prmpac
    wdetail.body     =  stat.maktab_fil.body
    wdetail.tons     =  stat.maktab_fil.tons.
IF wdetail.redbook  = ""  THEN DO: 
    ASSIGN chkred = YES.
    RUN proc_maktab.
END.

IF wdetail.redbook = "" THEN DO:
    FIND LAST sicsyac.xmm102 WHERE TRIM(sicsyac.xmm102.moddes) = trim(wdetail.brand) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm102  THEN  DO:
         FIND LAST sicsyac.xmm102 WHERE index(sicsyac.xmm102.moddes,wdetail.brand) <> 0  NO-LOCK NO-ERROR.
          IF AVAIL sicsyac.xmm102 THEN DO:
              ASSIGN  nv_modcod   = sicsyac.xmm102.modcod 
              wdetail.redbook = sicsyac.xmm102.modcod 
              wdetail.cargrp  = sicsyac.xmm102.vehgrp
              wdetail.tons    = sicsyac.xmm102.tons  
              wdetail.body    = TRIM(sicsyac.xmm102.body)
              wdetail.seat    = string(sicsyac.xmm102.seats).
          END.
     END.
     ELSE DO: 
         ASSIGN  nv_modcod   = sicsyac.xmm102.modcod 
             wdetail.redbook = sicsyac.xmm102.modcod 
             wdetail.cargrp  = sicsyac.xmm102.vehgrp
             wdetail.tons    = sicsyac.xmm102.tons  
             wdetail.body    = TRIM(sicsyac.xmm102.body)
             wdetail.seat    = string(sicsyac.xmm102.seats).
     END.
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
    sic_bran.uwm130.riskgp = s_riskgp               AND       /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND       /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND       /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr             AND       /*26/10/2006 change field name */
    sic_bran.uwm130.bchno  = nv_batchno             AND       /*26/10/2006 change field name */ 
    sic_bran.uwm130.bchcnt = nv_batcnt    NO-WAIT NO-ERROR.   /*26/10/2006 change field name */            
IF NOT AVAILABLE sic_bran.uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt    = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp    = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno    = s_itemno.
    ASSIGN  sic_bran.uwm130.bchyr = nv_batchyr     /* batch Year */
        sic_bran.uwm130.bchno     = nv_batchno     /* bchno      */
        sic_bran.uwm130.bchcnt    = nv_batcnt .    /* bchcnt     */
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
        sic_bran.uwm130.uom9_c   = sicsyac.xmm016.uom9 
        nv_comper                = deci(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc                = deci(sicsyac.xmm016.si_d_t[9])                                           
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
ASSIGN  s_recid3  = RECID(sic_bran.uwm130)
    /* ---------------------------------------------  U W M 3 0 1 --------------*/ 
    nv_covcod  =  wdetail.covcod
    nv_makdes  =  wdetail.brand
    nv_moddes  =  n_model
    nv_newsck  =  " ".
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
         END.  /*transaction*/
     END.
     Assign 
         sic_bran.uwm301.policy     = sic_bran.uwm120.policy                   
         sic_bran.uwm301.rencnt     = sic_bran.uwm120.rencnt
         sic_bran.uwm301.endcnt     = sic_bran.uwm120.endcnt
         sic_bran.uwm301.riskgp     = sic_bran.uwm120.riskgp
         sic_bran.uwm301.riskno     = sic_bran.uwm120.riskno
         sic_bran.uwm301.itemno     = s_itemno
         sic_bran.uwm301.tariff     = wdetail.tariff
         sic_bran.uwm301.covcod     = nv_covcod
         sic_bran.uwm301.cha_no     = trim(wdetail.chasno)
         sic_bran.uwm301.trareg     = trim(wdetail.chasno)
         sic_bran.uwm301.eng_no     = trim(wdetail.eng)
         sic_bran.uwm301.Tons       = INTEGER(wdetail.tons)
         sic_bran.uwm301.engine     = INTEGER(wdetail.engcc)
         sic_bran.uwm301.yrmanu     = INTEGER(wdetail.caryear)
         sic_bran.uwm301.garage     = wdetail.garage
         sic_bran.uwm301.body       = wdetail.body
         sic_bran.uwm301.seats      = INTEGER(wdetail.seat)
         sic_bran.uwm301.mv_ben83   = wdetail.benname
         sic_bran.uwm301.vehreg     = wdetail.vehreg + nv_provi
         sic_bran.uwm301.yrmanu     = inte(wdetail.caryear)
         sic_bran.uwm301.vehuse     = wdetail.vehuse
         sic_bran.uwm301.moddes     = trim(wdetail.brand) + " " + trim(wdetail.model)     
         sic_bran.uwm301.modcod     = wdetail.redbook 
         sic_bran.uwm301.sckno      = 0              
         sic_bran.uwm301.itmdel     = NO
         sic_bran.uwm301.bchyr      = nv_batchyr         /* batch Year */      
         sic_bran.uwm301.bchno      = nv_batchno         /* bchno      */      
         sic_bran.uwm301.bchcnt     = nv_batcnt .        /* bchcnt     */  
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
         FIND FIRST brStat.Detaitem USE-INDEX detaitem11      WHERE
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
     IF wdetail.prepol = "" THEN DO:
         IF wdetail.redbook <> "" THEN DO:     /*กรณีที่มีการระบุ Code รถมา*/
             FIND FIRST stat.maktab_fil Use-index maktab04    WHERE 
                 stat.maktab_fil.sclass = n_sclass72          AND
                 stat.maktab_fil.modcod = wdetail.redbook     No-lock no-error no-wait.
             If  avail stat.maktab_fil  Then 
                 ASSIGN wdetail.redbook =  stat.maktab_fil.modcod
                 wdetail.model          =  stat.maktab_fil.moddes
                 sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
                 sic_bran.uwm301.moddes =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                 wdetail.cargrp         =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.vehgrp =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.body   =  stat.maktab_fil.body
                 sic_bran.uwm301.seats  =  stat.maktab_fil.seats
                 sic_bran.uwm301.Tons   =  stat.maktab_fil.tons
                 sic_bran.uwm301.engine =  stat.maktab_fil.engine.
         END.
         ELSE DO:
             Find First stat.maktab_fil USE-INDEX maktab04             Where
                 stat.maktab_fil.makdes   =     wdetail.brand            And                  
                 index(stat.maktab_fil.moddes,nv_moddes) <> 0        And
                 stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                 stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                 stat.maktab_fil.sclass   =     n_sclass72               AND
                 stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
             If  avail stat.maktab_fil  Then 
                 ASSIGN wdetail.redbook  =  stat.maktab_fil.modcod
                 sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                 sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                 wdetail.cargrp          =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                 sic_bran.uwm301.body    =  stat.maktab_fil.body
                 sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
                 sic_bran.uwm301.engine  =  stat.maktab_fil.engine .
         END.
     END.
     FIND sic_bran.uwd132  USE-INDEX uwd13201      WHERE                                
         sic_bran.uwd132.policy = wdetail.policy   AND
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
             MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wdetail.policy
                 "ไม่สามารถ Generage ข้อมูลได้".
             NEXT.
         END.
         CREATE sic_bran.uwd132.
     END.
     ASSIGN  /*wdetail.premt = string(TRUNCATE(((deci(wdetail.premt)  * 100 ) / 107.43),0))*/
         sic_bran.uwd132.bencod  = "COMP"                 /*Benefit Code*/
         sic_bran.uwd132.benvar  = ""                     /*Benefit Variable*/
         sic_bran.uwd132.rate    = 0                      /*Premium Rate %*/
         sic_bran.uwd132.gap_ae  = NO                     /*GAP A/E Code*/
         sic_bran.uwd132.gap_c   = 0    /*deci(wdetail.premt)*//*GAP, per Benefit per Item*/
         sic_bran.uwd132.dl1_c   = 0                      /*Disc./Load 1,p. Benefit p.Item*/
         sic_bran.uwd132.dl2_c   = 0                      /*Disc./Load 2,p. Benefit p.Item*/
         sic_bran.uwd132.dl3_c   = 0                      /*Disc./Load 3,p. Benefit p.Item*/
         sic_bran.uwd132.pd_aep  = "E"                    /*Premium Due A/E/P Code*/
         sic_bran.uwd132.prem_c  = 0   /*PD, per Benefit per Item*/
         sic_bran.uwd132.fptr    = 0                      /*Forward Pointer*/
         sic_bran.uwd132.bptr    = 0                      /*Backward Pointer*/
         sic_bran.uwd132.policy  = wdetail.policy         /*Policy No. - uwm130*/
         sic_bran.uwd132.rencnt  = 0                      /*Renewal Count - uwm130*/
         sic_bran.uwd132.endcnt  = 0                      /*Endorsement Count - uwm130*/
         sic_bran.uwd132.riskgp  = 0                      /*Risk Group - uwm130*/
         sic_bran.uwd132.riskno  = 1                      /*Risk No. - uwm130*/
         sic_bran.uwd132.itemno  = 1                      /*Insured Item No. - uwm130*/
         sic_bran.uwd132.rateae  = NO                     /*Premium Rate % A/E Code*/
         sic_bran.uwm130.fptr03  = RECID(sic_bran.uwd132) /*First uwd132 Cover & Premium*/
         sic_bran.uwm130.bptr03  = RECID(sic_bran.uwd132) /*Last  uwd132 Cover & Premium*/
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
            FIND sicsyac.xmm016 USE-INDEX xmm01601  WHERE
                sicsyac.xmm016.class = wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
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
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.tons).
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
                    ASSIGN   
                        sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap 
                        /*sic_bran.uwd132.gap_c  = deci(wdetail.premt)
                        sic_bran.uwd132.prem_c = deci(wdetail.premt)*/
                        nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                       /* nv_gap                 = deci(wdetail.premt)
                        nv_prem                = deci(wdetail.premt)*/ .
                END.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.subclass  AND
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
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                    /*sic_bran.uwd132.gap_c  = deci(wdetail.premt).*/
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                               RECID(sic_bran.uwd132),
                                               sic_bran.uwm301.tariff).
                    ASSIGN nv_gap  = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem    = nv_prem + sic_bran.uwd132.prem_c
                        /*nv_gap     = deci(wdetail.premt)
                        nv_prem    = deci(wdetail.premt)*/  .
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
                        ASSIGN    sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                        sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap 
                            /*sic_bran.uwd132.gap_c  = deci(wdetail.premt)
                            sic_bran.uwd132.prem_c = deci(wdetail.premt)*/
                            nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                            nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                            /*nv_gap                 = deci(wdetail.premt)
                            nv_prem                = deci(wdetail.premt)*/   .
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
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat   NO-LOCK NO-ERROR NO-WAIT.
                    FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601           WHERE
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
                        /*sic_bran.uwd132.gap_c  = deci(wdetail.premt).*/
                        RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                                   RECID(sic_bran.uwd132),
                                                   sic_bran.uwm301.tariff).
                        nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                       /* nv_gap        = deci(wdetail.premt).
                        nv_prem       = deci(wdetail.premt).*/
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
        sic_bran.uwm130.bptr03    = s_130bp1.
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
                    sicsyac.xmm106.tariff  = wdetail.tariff          AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod  AND
                    sicsyac.xmm106.class   = wdetail.subclass        AND
                    sicsyac.xmm106.covcod  = wdetail.covcod          AND
                    sicsyac.xmm106.key_a  >= nv_key_a                AND 
                    sicsyac.xmm106.key_b  >= nv_key_b                AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE xmm106 THEN DO:
                    ASSIGN   sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap 
                        /*sic_bran.uwd132.gap_c  = deci(wdetail.premt)
                        sic_bran.uwd132.prem_c = deci(wdetail.premt)*/
                        nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                        /*nv_gap                 = deci(wdetail.premt)
                        nv_prem                = deci(wdetail.premt)*/   .
                END.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601     WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff      AND 
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod AND 
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
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.    
                    /*sic_bran.uwd132.gap_c  = deci(wdetail.premt).*/
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100),         
                                         RECID(sic_bran.uwd132),                
                                         sic_bran.uwm301.tariff).
                    ASSIGN
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c
                    /*nv_gap        = deci(wdetail.premt)
                    nv_prem       = deci(wdetail.premt)*/   .
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
    nv_tax_per    = 7.0.
FIND sicsyac.xmm020 USE-INDEX xmm02001     WHERE
    sicsyac.xmm020.branch = sic_bran.uwm100.branch  AND
    sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri  NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN 
    ASSIGN nv_stm_per      = sicsyac.xmm020.rvstam
    nv_tax_per             = sicsyac.xmm020.rvtax
    sic_bran.uwm100.gstrat = sicsyac.xmm020.rvtax.
ELSE sic_bran.uwm100.gstrat = nv_tax_per.
ASSIGN  nv_gap2  = 0
    nv_prem2     = 0
    nv_rstp      = 0
    nv_rtax      = 0
    nv_com1_per  = 0
    nv_com1_prm  = 0.
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sicsyac.xmm031 THEN nv_com1_per = sicsyac.xmm031.comm1.
FOR EACH sic_bran.uwm120    WHERE
    sic_bran.uwm120.policy = wdetail.policy         AND
    sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm120.bchyr  = nv_batchyr             AND 
    sic_bran.uwm120.bchno  = nv_batchno             AND 
    sic_bran.uwm120.bchcnt = nv_batcnt             :
    ASSIGN nv_gap  = 0
        nv_prem = 0.
    FOR EACH sic_bran.uwm130 WHERE
        sic_bran.uwm130.policy = wdetail.policy         AND
        sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
        sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp AND
        sic_bran.uwm130.riskno = sic_bran.uwm120.riskno AND
        sic_bran.uwm130.bchyr  = nv_batchyr             AND 
        sic_bran.uwm130.bchno  = nv_batchno             AND 
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
        sic_bran.uwm120.prem_r    =  nv_prem
        sic_bran.uwm120.rstp_r    =  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) +
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
            sic_bran.uwm120.com1_r         =  0
            sic_bran.uwm120.com1_r         =  0
            nv_com1_prm                    =  0.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addr c-Win 
PROCEDURE proc_addr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A62-0219     
------------------------------------------------------------------------------*/
DO: 
     ASSIGN 
           n_nametax  = trim(SUBSTR(wdetail.receipt_name,31,INDEX(wdetail.receipt_name,"ที่อยู่:") - 32))
           n_address  = SUBSTR(wdetail.receipt_name,R-INDEX(wdetail.receipt_name,"ที่อยู่:"))
           n_taxno    = SUBSTR(n_address,R-INDEX(n_address,"เลขผู้เสียภาษี:") + 15 )
           n_address  = SUBSTR(n_address,10,LENGTH(n_address) - (LENGTH(n_taxno) + 25)) .
     /*----- ที่อยู่ --------*/
     ASSIGN  n_length   = 0      
            n_build    = ""     n_road     = ""          
            n_tambon   = ""     n_amper    = ""          
            n_country  = ""     n_post     = "".
        IF INDEX(n_address,"จ.") <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"จ."),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
        END.
        ELSE IF INDEX(n_address,"จังหวัด") <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"จังหวัด"),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length)  ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
        END.
        ELSE IF INDEX(n_address,"กทม") <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"กทม"),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
        END.
        ELSE IF INDEX(n_address,"กรุงเทพ") <> 0 THEN DO: 
            ASSIGN 
            n_country  =  SUBSTR(n_address,INDEX(n_address,"กรุงเทพ"),LENGTH(n_address))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
        END.

        IF INDEX(n_address,"อ.") <> 0 THEN DO: 
            ASSIGN 
            n_amper  =  SUBSTR(n_address,INDEX(n_address,"อ."),LENGTH(n_address))
            n_length   =  LENGTH(n_amper)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
        ELSE IF INDEX(n_address,"อำเภอ") <> 0 THEN DO: 
            ASSIGN 
            n_amper  =  SUBSTR(n_address,INDEX(n_address,"อำเภอ"),LENGTH(n_address))
            n_length   =  LENGTH(n_amper)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
        ELSE IF INDEX(n_address,"เขต") <> 0 THEN DO: 
            ASSIGN 
            n_amper  =  SUBSTR(n_address,INDEX(n_address,"เขต"),LENGTH(n_address))
            n_length   =  LENGTH(n_amper)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.

        IF INDEX(n_address,"ต.") <> 0 THEN DO: 
            ASSIGN 
            n_tambon  =  SUBSTR(n_address,INDEX(n_address,"ต."),LENGTH(n_address))
            n_length   =  LENGTH(n_tambon)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
        ELSE IF INDEX(n_address,"ตำบล") <> 0 THEN DO: 
            ASSIGN 
            n_tambon  =  SUBSTR(n_address,INDEX(n_address,"ตำบล"),LENGTH(n_address))
            n_length   =  LENGTH(n_tambon)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
        ELSE IF INDEX(n_address,"แขวง") <> 0 THEN DO: 
            ASSIGN 
            n_tambon  =  SUBSTR(n_address,INDEX(n_address,"แขวง"),LENGTH(n_address))
            n_length   =  LENGTH(n_tambon)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.

        IF INDEX(n_address,"ถ." ) <> 0 THEN DO: 
            ASSIGN 
            n_road  =  SUBSTR(n_address,INDEX(n_address,"ถ."),LENGTH(n_address))
            n_length   =  LENGTH(n_road)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
        ELSE IF INDEX(n_address,"ถนน" ) <> 0 THEN DO: 
            ASSIGN 
            n_road  =  SUBSTR(n_address,INDEX(n_address,"ถนน"),LENGTH(n_address))
            n_length   =  LENGTH(n_road)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
        END.
        ASSIGN  n_build   = trim(n_address).

        /*----- ที่อยู่ --------*/
        ASSIGN n_nametax =  TRIM(n_nametax)
               n_build   =  TRIM(n_build)   
               n_tambon  =  trim(trim(n_road) + " " + trim(n_tambon))  
               n_amper   =  TRIM(TRIM(n_amper) + " " + trim(n_country))  
               n_post    =  TRIM(n_post)
               n_taxno   =  TRIM(n_taxno).
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
    For each  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|" 
           ns_no           /* Type.           */
           ns_policy72     /* เลขที่กรมธรรม์  */
           ns_sckno        /* stk no   */
           ns_cname        /* ชื่อผู้เอาประกัน*/
           ns_addsend      /* ที่อยู่         */
           ns_effdate      /* วันเริ่มคุ้มครอง/เวลา */ 
           ns_expdate      /* วันสิ้นสุด      */
           ns_class70      /* รหัส            */
           ns_brand        /* ยี่ห้อ          */
           ns_model        /* รุ่นรถ          */
           ns_licenno      /* ทะเบียนรถ       */
           ns_regisprov    /* จังหวัด         */
           ns_chassno      /* เลขตัวถัง       */
           ns_instyp       /* ประเภท          */
           ns_cc           /* ขนาดเครื่องยนต์ */
           ns_enginno      /* เลขเครื่องยนต์  */
           ns_caryear      /* ปีจดทะเบียน     */
           ns_comprm       /* เบี้ยสุทธิ      */
           ns_tax          /* อากร            */
           ns_vat          /* ภาษี            */
           ns_groamt       /* เบี้ยรวมภาษีอากร*/
           ns_comtyp       /* การใช้รถ        */
           ns_notidate     /* วันออกกรมธรรม์  */
           ns_contno       /* เลขที่สัญญา     */
           ns_id           /* ID Card         */
           ns_producer     /* Producer        */
           ns_agent        /* Agent           */
           ns_bran         /* Branch          */
           ns_docno        /* Docno           */
           ns_occuration   /* อาชีพ           */
           ns_remark     .  /* Comment        */    
           
        IF index(ns_no,"Type") = 0  THEN DO:
              IF trim(ns_titlen) = "" THEN DO:
                  IF INDEX(ns_cname,"นาย") <> 0  THEN DO:
                      ASSIGN ns_titlen = "นาย"
                             ns_cname = REPLACE(ns_cname,ns_titlen,"")
                             /*ns_titlen = "คุณ" */ . /*A62-0219*/
                  END.
                  ELSE IF INDEX(ns_cname,"นางสาว") <> 0  THEN DO:
                      ASSIGN ns_titlen = "นางสาว"
                             ns_cname = REPLACE(ns_cname,ns_titlen,"")
                             /*ns_titlen = "คุณ" */. /*A62-0219*/
                  END.
                  ELSE IF INDEX(ns_cname,"นาง") <> 0  THEN DO:
                      ASSIGN ns_titlen = "นาง"
                             ns_cname = REPLACE(ns_cname,ns_titlen,"")
                             /*ns_titlen = "คุณ"*/ . /*A62-0219*/
                  END.
                  ELSE IF INDEX(ns_cname,"น.ส.") <> 0  THEN DO:
                      ASSIGN ns_titlen = "น.ส."
                             ns_cname = REPLACE(ns_cname,ns_titlen,"")
                             /*ns_titlen = "คุณ"*/ . /*A62-0219*/
                  END.
                  ELSE IF INDEX(ns_cname,"ว่าที่ร้อยตรี") <> 0  THEN DO:
                      ASSIGN ns_titlen = "ว่าที่ร้อยตรี"
                             ns_cname = REPLACE(ns_cname,ns_titlen,"")
                             /*ns_titlen = "คุณ" */. /*A62-0219*/
                  END.
                  ELSE IF INDEX(ns_cname,"มูลนิธิ") <> 0  THEN DO:
                      ASSIGN ns_titlen = "มูลนิธิ"
                             ns_cname = REPLACE(ns_cname,ns_titlen,"").
                  END.
                  ELSE IF INDEX(ns_cname,"บมจ.") <> 0  THEN DO:
                      ASSIGN ns_titlen = "บมจ."
                             ns_cname = REPLACE(ns_cname,ns_titlen,"").
                  END.
                  ELSE IF INDEX(ns_cname,"หจก.") <> 0  THEN DO:
                      ASSIGN ns_titlen = "หจก."
                             ns_cname = REPLACE(ns_cname,ns_titlen,"").
                  END.
                  ELSE IF INDEX(ns_cname,"ห้างหุ้นส่วนจำกัด") <> 0  THEN DO:
                      ASSIGN ns_titlen = "ห้างหุ้นส่วนจำกัด"
                             ns_cname = REPLACE(ns_cname,ns_titlen,"").
                  END.
                  ELSE IF INDEX(ns_cname,"ห้างหุ้นส่วน") <> 0  THEN DO:
                      ASSIGN ns_titlen = "ห้างหุ้นส่วน"
                             ns_cname = REPLACE(ns_cname,ns_titlen,"").
                  END.
                  ELSE IF INDEX(ns_cname,"บริษัท") <> 0  THEN DO:
                      ASSIGN ns_titlen = "บริษัท"
                             ns_cname = REPLACE(ns_cname,ns_titlen,"").
                  END.
                  ELSE IF INDEX(ns_cname,"บรรษัท") <> 0  THEN DO:
                      ASSIGN ns_titlen = "บรรษัท"
                             ns_cname = REPLACE(ns_cname,ns_titlen,"").
                  END.
                  ELSE IF INDEX(ns_cname,"โรงเรียน") <> 0  THEN DO:
                      ASSIGN ns_titlen = "โรงเรียน"
                             ns_cname = REPLACE(ns_cname,ns_titlen,"").
                  END.
                  ELSE IF INDEX(ns_cname,"โรงพยาบาล") <> 0  THEN DO:
                      ASSIGN ns_titlen = "โรงพยาบาล"
                             ns_cname = REPLACE(ns_cname,ns_titlen,"").
                  END.
                  ELSE ASSIGN ns_titlen = "" .
              END.
              /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
              RUN proc_assign2addr (INPUT  TRIM(ns_addsend)  
                                   ,INPUT  ""
                                   ,INPUT  ""
                                   ,INPUT  ns_occuration
                                   ,OUTPUT nv_codeocc   
                                   ,OUTPUT nv_codeaddr1 
                                   ,OUTPUT nv_codeaddr2 
                                   ,OUTPUT nv_codeaddr3 ).
              IF nv_postcd <> "" THEN DO:
                  IF      INDEX(ns_addsend,nv_postcd) <> 0 THEN ns_addsend = trim(REPLACE(ns_addsend,nv_postcd,"")). 
              END.
              RUN proc_matchtypins  (INPUT  ns_titlen 
                                    ,INPUT  ns_cname
                                    ,OUTPUT nv_insnamtyp
                                    ,OUTPUT nv_firstName 
                                    ,OUTPUT nv_lastName).
              /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
              /*ELSE DO: */ /*A62-0219*/
              IF ns_titlen = ""  THEN DO:
                  FIND FIRST brstat.msgcode USE-INDEX MsgCode01  WHERE
                       index(ns_cname,brstat.msgcode.MsgDesc) <> 0 NO-LOCK NO-ERROR. /*A62-0219*/
                      /*brstat.msgcode.MsgDesc = trim(ns_titlen)   NO-LOCK NO-WAIT NO-ERROR. */ /*A62-0219*/
                  IF AVAIL brstat.msgcode  THEN 
                      ASSIGN ns_titlen = brstat.msgcode.branch.
              END.
              
              IF TRIM(ns_model) = "" AND TRIM(ns_brand) <> ""  THEN DO:
                  IF INDEX(ns_brand," ") <> 0 THEN DO:
                      ASSIGN ns_model =  SUBSTR(ns_brand,INDEX(ns_brand," "),LENGTH(ns_brand))
                             ns_brand =  SUBSTR(ns_brand,1,INDEX(ns_brand," ")).
                  END.
                  ELSE ASSIGN ns_brand = TRIM(ns_brand)
                              ns_model = "".
              END.
              ASSIGN fi_process  = "Create data ORICO  to workfile ... ".
              DISP fi_process WITH FRAM fr_main.
              IF TRIM(ns_policy72) <> "" AND DECI(ns_comprm) <> 0 THEN RUN proc_assignwdetail72 .   /*A61-0234*/
              RUN proc_assign_init. /*A60-0232 */
        END. /* end ns_no */
        RUN proc_assign_init.
    END.   /* repeat  */
    RUN proc_assign2.
    
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
DEF VAR b_eng   AS DECI FORMAT  ">>>>9.99-".
DEF VAR ind1 AS INTE.
DEF VAR ind2 AS INTE.
DEF VAR ind3 AS INTE.
DEF VAR ind4 AS INTE. 
DEF VAR n_char AS CHAR FORMAT  "x(75)".
FOR EACH wdetail WHERE wdetail.policy  NE " "  .
    ASSIGN 
        ind1         = 0 
        ind2         = 0
        ind3         = 0
        ind4         = 0
        wdetail.seat = ""
        n_char       = ""
        b_eng = round((DECI(wdetail.engcc) / 1000),1)   
        b_eng = b_eng * 1000
        wdetail.engcc  = string(b_eng)
        wdetail.brand  = IF wdetail.brand = "benz" THEN "MERCEDES-BENZ" 
                         ELSE wdetail.brand 
        wdetail.vehuse = "1" .

    RUN proc_cutchar .    
    IF wdetail.poltyp = "v72" THEN DO:
        IF substr(wdetail.subclass,1,3)  = "110"   THEN  wdetail.seat = "7" .
        ELSE IF substr(wdetail.subclass,1,3)  = "120"  THEN DO: 
            ASSIGN  wdetail.seat = "12".
        END.
        ELSE IF substr(wdetail.subclass,1,3)  = "140"   THEN DO: 
            ASSIGN  wdetail.seat = "3".
        END.
        ELSE wdetail.seat = "7".
    END.
    ELSE DO:
        IF substr(wdetail.subclass,1,3)  = "110"   THEN  wdetail.seat = "7" .
        ELSE IF substr(wdetail.subclass,1,3)  = "220"  THEN ASSIGN  wdetail.seat = "15".
        ELSE IF substr(wdetail.subclass,1,3)  = "610"  THEN ASSIGN  wdetail.seat = "2".
        ELSE IF substr(wdetail.subclass,1,3)  = "210"  THEN DO: 
            /*IF wdetail.producer = "A0M0080"  AND wdetail.brand = "ISUZU" THEN ASSIGN  wdetail.seat = "5".
            ELSE*/ ASSIGN  wdetail.seat = "12".
        END.
        ELSE wdetail.seat = "3".
    END.

    IF wdetail.vehreg = "" THEN 
        wdetail.vehreg = "/" +  SUBSTRING(wdetail.chasno,LENGTH(wdetail.chasno) - 8) . 
    ELSE DO:  /*vehreg + provin....*/
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
            brstat.insure.compno = "999" AND 
            brstat.insure.FName  = TRIM(wdetail.re_country) NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN 
            ASSIGN wdetail.re_country = trim(Insure.LName)
                   wdetail.vehreg  = TRIM(wdetail.vehreg) + " " + wdetail.re_country .
        ELSE wdetail.vehreg = TRIM(wdetail.vehreg) + " " + TRIM(wdetail.re_country).
    END.

  
    IF LENGTH(wdetail.addr1) > 100 THEN DO:

        IF INDEX(wdetail.addr1,"ตำบล")  <> 0  THEN wdetail.addr1 = REPLACE(wdetail.addr1,"ตำบล","ต.").
        IF INDEX(wdetail.addr1,"อำเภอ") <> 0  THEN wdetail.addr1 = REPLACE(wdetail.addr1,"อำเภอ","อ.").
        IF INDEX(wdetail.addr1,"จังหวัด") <> 0  THEN wdetail.addr1 = REPLACE(wdetail.addr1,"จังหวัด","ถ.").

        IF INDEX(wdetail.addr1,"ถนน")   <> 0  THEN wdetail.addr1 = REPLACE(wdetail.addr1,"ถนน","ถ.").
        IF INDEX(wdetail.addr1,"ซอย")   <> 0  THEN wdetail.addr1 = REPLACE(wdetail.addr1,"ซอย","ซ.").
        IF INDEX(wdetail.addr1,"กรุงเทพมหานคร") <> 0  THEN wdetail.addr1 = REPLACE(wdetail.addr1,"กรุงเทพมหานคร","กรุงเทพฯ").
        
    END.
    /* end A62-0343 */
    IF LENGTH(wdetail.addr1) > 35  THEN DO:
        loop_add01:
        DO WHILE LENGTH(wdetail.addr1) > 35 :
            IF r-INDEX(wdetail.addr1," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.addr2  = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1," "))) + " " + wdetail.addr2
                    wdetail.addr1 = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1," "))).
            END.
            ELSE LEAVE loop_add01.
        END.
        loop_add02:
        DO WHILE LENGTH(wdetail.addr2) > 35 :
            IF r-INDEX(wdetail.addr2," ") <> 0 THEN DO:
                ASSIGN 
                    wdetail.addr3   = trim(SUBSTR(wdetail.addr2,r-INDEX(wdetail.addr2," "))) + " " + wdetail.addr3
                    wdetail.addr2   = trim(SUBSTR(wdetail.addr2,1,r-INDEX(wdetail.addr2," "))).
            END.
            ELSE LEAVE loop_add02.
        END.
        loop_add03:
        DO WHILE LENGTH(wdetail.addr3) > 35 :
            IF r-INDEX(wdetail.addr3," ") <> 0 THEN DO:
                ASSIGN 
                        wdetail.addr4   = trim(SUBSTR(wdetail.addr3,r-INDEX(wdetail.addr3," "))) + " " + wdetail.addr4
                        wdetail.addr3   = trim(SUBSTR(wdetail.addr3,1,r-INDEX(wdetail.addr3," "))).
               
            END.
            ELSE LEAVE loop_add03.
        END.

        IF LENGTH(wdetail.addr4) > 35 THEN DO:
            IF INDEX(wdetail.addr4,"กรุงเทพมหานคร") <> 0  THEN wdetail.addr4 = REPLACE(wdetail.addr4,"กรุงเทพมหานคร","กทม.").
            IF INDEX(wdetail.addr4,"กรุงเทพฯ")      <> 0  THEN wdetail.addr4 = REPLACE(wdetail.addr4,"กรุงเทพฯ","กทม.").
        END.
    END.

    RUN Proc_findredbook. 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignwdetail72 c-Win 
PROCEDURE proc_assignwdetail72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN proc_cutpol.
FIND FIRST wdetail WHERE wdetail.policy  = trim(ns_policy72)   NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail  THEN DO:
    CREATE wdetail .
    ASSIGN 
        wdetail.policy     = trim(ns_policy72)
        wdetail.cr_2       = ""  
        wdetail.cedpol     = trim(ns_contno)
        wdetail.tiname     = trim(ns_titlen)          
        wdetail.insnam     = trim(ns_cname)
        wdetail.occup      = TRIM(ns_occuration)
        wdetail.np_name2   = "" /*IF trim(ns_instyp) = "แถม" THEN trim(ns_namepol) ELSE ""*/
        wdetail.idno       = trim(ns_id)
        wdetail.brand      = trim(ns_brand)   
        wdetail.model      = TRIM(ns_model)
        wdetail.engcc      = TRIM(ns_cc)   
        wdetail.caryear    = trim(ns_caryear)
        wdetail.eng        = trim(ns_enginno)               
        wdetail.chasno     = trim(ns_chassno)            
        wdetail.vehreg     = trim(ns_licenno)            
        wdetail.re_country = trim(ns_regisprov)
        wdetail.subclass   = TRIM(ns_class70)
        wdetail.covcod     = "T" 
        wdetail.poltyp     = "V72"
        wdetail.premt      = trim(ns_comprm)
       /* wdetail.comdat     = substr(trim(ns_effdate),1,2) + "/" +
                             substr(trim(ns_effdate),4,2) + "/" +
                             STRING(INT(substr(trim(ns_effdate),7,4)) - 543)
        wdetail.firstdat   = substr(trim(ns_effdate),1,2) + "/" +
                             substr(trim(ns_effdate),4,2) + "/" +
                             STRING(INT(substr(trim(ns_effdate),7,4)) - 543)
        wdetail.expdat     = substr(trim(ns_expdate),1,2) + "/" +  
                             substr(trim(ns_expdate),4,2) + "/" +  
                             STRING(INT(substr(trim(ns_expdate),7,4)) - 543)  */  
        /*wdetail.namerequest  = trim(wdetail2.namerequest) 
        wdetail.daterequest  = trim(wdetail2.daterequest) 
        wdetail.nocheck      = trim(wdetail2.nocheck) */
        wdetail.comdat     = trim(ns_effdate)
        wdetail.firstdat   = trim(ns_effdate)
        wdetail.expdat     = trim(ns_expdate)
        wdetail.garage     = ""  
        wdetail.vehuse     = "1"
        wdetail.stk        = ""
        wdetail.addr1      = trim(ns_addsend) 
        wdetail.tariff     = "9" 
        wdetail.compul     = "y"
        wdetail.comment    = ""
        wdetail.producer   = TRIM(ns_producer)
        wdetail.agent      = TRIM(ns_agent)
        /*wdetail.vatcode    = TRIM(ns_vatcode)*/
        wdetail.n_branch   = TRIM(ns_bran)
        /*wdetail.notfyby    = trim(ns_notfyby)*/
        wdetail.entdat     = string(TODAY)                /*entry date*/
        wdetail.enttim     = STRING (TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat    = STRING (fi_loaddat)          /*tran date*/
        wdetail.trantim    = STRING (TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT   = "IM"
        wdetail.n_EXPORT   = ""
        wdetail.stk        = TRIM(ns_sckno)
        wdetail.docno      = TRIM(ns_docno) 
        wdetail.promo      = "พรบ.เดี่ยว" 
        wdetail.txtmemo    = TRIM(ns_remark)
        wdetail.prepol     = ""  
        wdetail.insnamtyp   =  nv_insnamtyp     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
        wdetail.firstName   =  nv_firstName     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
        wdetail.lastName    =  nv_lastName      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
        wdetail.postcd      =  nv_postcd        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
        wdetail.codeocc     =  nv_codeocc       /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
        wdetail.codeaddr1   =  nv_codeaddr1     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
        wdetail.codeaddr2   =  nv_codeaddr2     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
        wdetail.codeaddr3   =  nv_codeaddr3     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
        wdetail.br_insured  =  "00000"     .     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
        
END.
RUN proc_cutpol.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_init c-Win 
PROCEDURE proc_assign_init :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    ns_titlen      = ""
    ns_no          = ""
    ns_policy72    = ""
    ns_sckno       = ""
    ns_cname       = ""
    ns_addsend     = ""
    ns_effdate     = ""
    ns_expdate     = ""
    ns_class70     = ""
    ns_brand       = ""
    ns_model       = ""
    ns_licenno     = ""
    ns_regisprov   = ""
    ns_chassno     = ""
    ns_instyp      = ""
    ns_cc          = ""
    ns_enginno     = ""
    ns_caryear     = ""
    ns_comprm      = ""
    ns_tax         = ""
    ns_vat         = ""
    ns_groamt      = ""
    ns_comtyp      = ""
    ns_notidate    = ""
    ns_contno      = ""
    ns_id          = ""
    ns_producer    = ""
    ns_agent       = ""
    ns_bran        = ""
    ns_docno       = ""
    ns_occuration  = ""
    ns_remark      = "" .
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    .

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1 c-Win 
PROCEDURE proc_chktest1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail WHERE wdetail.policy <> "" :
    ASSIGN fi_process = "Check data Orico  ".
    DISP fi_process WITH FRAM fr_main.
    IF  wdetail.policy = ""  THEN NEXT.
    ASSIGN 
        nv_dss_per = 0
        n_rencnt = 0
        n_endcnt = 0
        nv_drivno = 0.
    /*RUN proc_cr_2.*/
    /*Add by Kridtiya i. A63-0472*/ 
    /*รบกวนแก้ไข CODE ORICO ดังนี้
1. B3MLOAL101 แก้ไขเป็น  >>> A0MLOAL101
2. B3MLOAL102 แก้ไขเป็น  >>> A0MLOAL102*/

    IF      wdetail.producer = "A0M0129"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer = "A0MLOAL101" wdetail.financecd = "FOALT" wdetail.campaign_ov = "RENEW".             
    ELSE IF wdetail.producer = "A0M0129"                             THEN ASSIGN wdetail.producer = "A0MLOAL101" wdetail.financecd = "FOALT" wdetail.campaign_ov = "TRANSF".    
    ELSE IF wdetail.producer = "A0M0130"                             THEN ASSIGN wdetail.producer = "A0MLOAL102" wdetail.financecd = "FOALT" wdetail.campaign_ov = "USED".
    ELSE IF wdetail.producer = "A0MLOAL101" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FOALT" wdetail.campaign_ov = "RENEW".            
    ELSE IF wdetail.producer = "A0MLOAL101"                          THEN ASSIGN wdetail.financecd = "FOALT" wdetail.campaign_ov = "TRANSF".    
    ELSE IF wdetail.producer = "A0MLOAL102"                          THEN ASSIGN wdetail.financecd = "FOALT" wdetail.campaign_ov = "USED".

    ASSIGN
        wdetail.financecd   = "FOALT" 
        wdetail.campaign_ov = "RENEW"  
        wdetail.producer    = "A0MLOAL101" 
        /*wdetail.agent       = "B3W0100"*/ .  /*Kridtiya i. A66-0239 Date. 04/11/2023*/

    RUN proc_susspect.  /*Add by Kridtiya i. A63-0419 */
     /*Add by Kridtiya i. A63-0472*/ 
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
END.    /*for each*/
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
DEF BUFFER buwm100 FOR wdetail.
    ASSIGN wdetail.cr_2 = "".
    FOR EACH  buwm100 WHERE 
        buwm100.cedpol  = wdetail.cedpol   AND
        buwm100.policy <> wdetail.policy  NO-LOCK .
        ASSIGN wdetail.cr_2 = buwm100.policy.
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
nv_c = wdetail.subclass.
nv_i = 0.
nv_l = LENGTH(nv_c).
DO WHILE nv_i <= nv_l:
    ind = 0.
    ind = INDEX(nv_c,".").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
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
    wdetail.subclass = nv_c .
IF length(wdetail.subclass) = 2 THEN wdetail.subclass = wdetail.subclass + "0" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpol c-Win 
PROCEDURE proc_cutpol :
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

ASSIGN nv_c = ""  ind = 0    nv_i = 0    nv_l = 0.
IF ns_policy <> "" THEN DO:
    nv_c = ns_policy.
    nv_i = 0.
    nv_l = LENGTH(nv_c).
    DO WHILE nv_i <= nv_l:
        ind = 0.
        ind = INDEX(nv_c,".").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
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
    ASSIGN ns_policy = nv_c .
END.

IF ns_policy72 <> "" THEN DO:
    nv_c = ns_policy72.
    nv_i = 0.
    nv_l = LENGTH(nv_c).
    DO WHILE nv_i <= nv_l:
        ind = 0.
        ind = INDEX(nv_c,".").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
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
    ASSIGN ns_policy72 = nv_c .
END.
    
IF ns_prepol <> "" THEN DO:
    nv_c = ns_prepol.
    nv_i = 0.
    nv_l = LENGTH(nv_c).
    DO WHILE nv_i <= nv_l:
        ind = 0.
        ind = INDEX(nv_c,".").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
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
    ASSIGN  ns_prepol = nv_c .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_findredbook c-Win 
PROCEDURE proc_findredbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEFINE VAR nv_rsimin  AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_rsimax  AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_si      AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_si1     AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_oldsi   AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_simaxp  AS DECI FORMAT ">>9.99-" INIT 20.
DEFINE VAR nv_siminp  AS DECI FORMAT ">>9.99-" INIT 20.
DEFINE VAR nv_moddes1 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes2 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes3 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes4 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes5 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes6 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_count   AS INTE INIT 0.
DEFINE VAR rm_modcod  AS CHAR.
DEFINE VAR rm_moddes  AS CHAR FORMAT "X(60)".
DEFINE VAR nv_supe    AS LOGICAL .
DEFINE VAR nv_spcflg  AS CHAR.
DO:
    rm_modcod = "".
    nv_makdes = trim(wdetail.brand).
    nv_moddes = TRIM(wdetail.model).
    nv_si     = INT(wdetail.si).
    FIND FIRST stat.makdes31 WHERE 
           makdes31.makdes = TRIM(wdetail.tariff) AND 
           makdes31.moddes = trim(wdetail.subclass)
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE makdes31 THEN DO:
    ASSIGN
        nv_simaxp = makdes31.si_theft_p 
        nv_siminp = makdes31.load_p.
    END.
    IF INDEX(nv_moddes," ")  <> 0 THEN nv_moddes1 = TRIM(SUBSTR(nv_moddes,1,R-INDEX(nv_moddes," ") - 1)).
    IF INDEX(nv_moddes1," ") <> 0 THEN nv_moddes2 = TRIM(SUBSTR(nv_moddes1,1,R-INDEX(nv_moddes1," ") - 1)).
    IF INDEX(nv_moddes2," ") <> 0 THEN nv_moddes3 = TRIM(SUBSTR(nv_moddes2,1,R-INDEX(nv_moddes2," ") - 1)).
    IF INDEX(nv_moddes3," ") <> 0 THEN nv_moddes4 = TRIM(SUBSTR(nv_moddes3,1,R-INDEX(nv_moddes3," ") - 1)).
    IF INDEX(nv_moddes4," ") <> 0 THEN nv_moddes5 = TRIM(SUBSTR(nv_moddes4,1,R-INDEX(nv_moddes4," ") - 1)).
    IF INDEX(nv_moddes5," ") <> 0 THEN nv_moddes6 = TRIM(SUBSTR(nv_moddes5,1,R-INDEX(nv_moddes5," ") - 1)).
    
    
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
    
        
        FOR EACH stat.maktab_fil USE-INDEX maktab02 WHERE
                 maktab_fil.sclass  = trim(wdetail.subclass) AND
                 maktab_fil.makdes  = nv_makdes            AND
                 INDEX(maktab_fil.moddes,rm_moddes) <> 0   AND
                 maktab_fil.makyea <= INT(wdetail.caryear) AND
                 maktab_fil.engine >= INT(wdetail.engcc) NO-LOCK:
    
            nv_rsimax = maktab_fil.si + ((maktab_fil.si * nv_simaxp) / 100).
            nv_rsimin = maktab_fil.si - ((maktab_fil.si * nv_siminp) / 100).
    
            IF nv_rsimin <= nv_si AND nv_rsimax >= nv_si THEN DO:
                IF (maktab_fil.si - nv_si ) > 0 THEN DO:
                   IF (maktab_fil.si) >= nv_si THEN DO:
                        /*nv_si = (nv_oldsi - maktab_fil.si).*/
                        rm_modcod = maktab_fil.modcod.
                        nv_supe   = maktab_fil.impchg.
    
                        IF nv_supe   = YES THEN nv_spcflg = "YES". ELSE nv_spcflg = "NO".
                        IF wdetail.cargrp = ""  THEN wdetail.cargrp = maktab_fil.prmpac.
                    END.
                END.
                ELSE DO:
                    IF (maktab_fil.si) <= nv_si THEN DO:
                       rm_modcod = maktab_fil.modcod.
                       nv_supe   = maktab_fil.impchg.
                       IF nv_supe   = YES THEN nv_spcflg = "YES". ELSE nv_spcflg = "NO".
                       IF wdetail.cargrp = ""  THEN wdetail.cargrp = maktab_fil.prmpac.
                    END.
                
                END.
            END.
        END.
    
        IF rm_modcod <> "" THEN LEAVE loop_modcod.
    END.

    wdetail.redbook  = rm_modcod .
END.
*/
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
DEF VAR n_recname AS CHAR FORMAT "x(255)" .   /*a62-0219*/
ASSIGN  
    n_insref     = ""         n_nametax  = ""  /*A62-0219*/   
    nv_usrid     = ""         n_build    = "" /*A62-0219*/   
    nv_transfer  = NO         n_road     = "" /*A62-0219*/   
    n_check      = ""         n_tambon   = "" /*A62-0219*/   
    nv_insref    = ""         n_amper    = "" /*A62-0219*/   
    nv_typ       = ""         n_country  = "" /*A62-0219*/   
    nv_transfer  = YES        n_post     = "" /*A62-0219*/
    n_taxno     = "" 
    nv_usrid     = SUBSTRING(USERID(LDBNAME(1)),3,4).
/* add by A62-0219*/ 
IF wdetail.vatcode = ""  THEN DO:
    ASSIGN 
        n_recname = trim(REPLACE(wdetail.receipt_name,"ออกใบเสร็จ/ใบกำกับภาษีในนาม :",""))
        n_recname = trim(REPLACE(n_recname,"ที่อยู่:",""))
        n_recname = trim(REPLACE(n_recname,"เลขผู้เสียภาษี:","")).

    IF trim(n_recname) <> "" THEN DO:
        RUN proc_addr.
        IF INDEX(n_nametax,wdetail.insnam) <> 0 AND n_taxno = ""  THEN ASSIGN n_taxno = TRIM(wdetail.idno) .
    END.
    ELSE DO:
        ASSIGN n_nametax = ""
               n_taxno   = ""
               n_build   = ""
               n_tambon  = ""
               n_amper   = ""
               n_post    = "" .
    END.
END.
ELSE DO:
    ASSIGN n_nametax = ""
           n_taxno   = ""
           n_build   = ""
           n_tambon  = ""
           n_amper   = ""
           n_post    = "" .
END.
/* end A62-0219 */
IF wdetail.insref = "" THEN DO:
    FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
        sicsyac.xmm600.NAME   = TRIM(wdetail.insnam)  AND 
        sicsyac.xmm600.homebr = TRIM(wdetail.n_branch)  AND 
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
            ELSE DO:
            ASSIGN 
                wdetail.pass    = "N"  
                wdetail.comment = wdetail.comment + "| รหัสลูกค้าเป็นค่าว่างไม่สามารถนำเข้าระบบได้ค่ะ" 
                WDETAIL.OK_GEN  = "N"
                nv_transfer = NO.
        END.
        END.
        n_insref = nv_insref.
    END.
    ELSE DO:  /* กรณีพบ */
        IF sicsyac.xmm600.acno <> "" THEN    
            ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            wdetail.insref          = nv_insref
            n_insref                = trim(nv_insref) 
            nv_transfer             = NO 
            sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname    = ""                        /*First Name*/
            sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
            sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
            sicsyac.xmm600.icno     = TRIM(wdetail.idno)        /*IC No.*//*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1    = TRIM(wdetail.addr1)       /*Address line 1*/
            sicsyac.xmm600.addr2    = TRIM(wdetail.addr2)       /*Address line 2*/
            sicsyac.xmm600.addr3    = TRIM(wdetail.addr3)       /*Address line 3*/
            sicsyac.xmm600.addr4    = TRIM(wdetail.addr4)       
            sicsyac.xmm600.homebr   = TRIM(wdetail.n_branch)      /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                     
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            sicsyac.xmm600.dtyp20   = ""   
            sicsyac.xmm600.dval20   = "" 
            sicsyac.xmm600.nphone   = n_nametax   /* A62-0219*/
            sicsyac.xmm600.naddr1   = n_build     /* A62-0219*/
            sicsyac.xmm600.naddr2   = n_tambon    /* A62-0219*/
            sicsyac.xmm600.naddr3   = n_amper     /* A62-0219*/
            sicsyac.xmm600.naddr4   = n_post      /* A62-0219*/
            sicsyac.xmm600.anlyc1   = n_taxno  .  /* A62-0219*/
    END.
END.
ELSE DO:
    FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
        sicsyac.xmm600.acno   = TRIM(wdetail.insref)  NO-ERROR NO-WAIT.  
    IF AVAILABLE sicsyac.xmm600 THEN 
        ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            n_insref                = trim(nv_insref) 
            wdetail.insref          = nv_insref
            nv_transfer             = NO 
            sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname    = ""                        /*First Name*/
            sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
            sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
            sicsyac.xmm600.icno     = TRIM(wdetail.idno)          /*IC No.*//*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1    = TRIM(wdetail.addr1)         /*Address line 1*/
            sicsyac.xmm600.addr2    = TRIM(wdetail.addr2)         /*Address line 2*/
            sicsyac.xmm600.addr3    = TRIM(wdetail.addr3)         /*Address line 3*/
            sicsyac.xmm600.addr4    = TRIM(wdetail.addr4)         
            sicsyac.xmm600.homebr   = TRIM(wdetail.n_branch)      /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                     
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            sicsyac.xmm600.dtyp20   = ""   
            sicsyac.xmm600.dval20   = ""    
            sicsyac.xmm600.nphone   = n_nametax   /* A62-0219*/
            sicsyac.xmm600.naddr1   = n_build     /* A62-0219*/
            sicsyac.xmm600.naddr2   = n_tambon    /* A62-0219*/
            sicsyac.xmm600.naddr3   = n_amper     /* A62-0219*/
            sicsyac.xmm600.naddr4   = n_post      /* A62-0219*/
            sicsyac.xmm600.anlyc1   = n_taxno  .  /* A62-0219*/
END.
IF nv_transfer = YES THEN DO:
    IF nv_insref  <> "" THEN 
        ASSIGN
        wdetail.insref          = nv_insref
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
        sicsyac.xmm600.icno     = TRIM(wdetail.idno)          /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.addr1)         /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.addr2)         /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.addr3)         /*Address line 3*/
        sicsyac.xmm600.addr4    = TRIM(wdetail.addr4)         /*Address line 4*/
        sicsyac.xmm600.postcd   = ""                        /*Postal Code*/
        sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
        sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
        sicsyac.xmm600.homebr   = TRIM(wdetail.n_branch)      /*Home branch*/
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
        sicsyac.xmm600.dval20   = "" 
        sicsyac.xmm600.nphone   = n_nametax   /* A62-0219*/
        sicsyac.xmm600.naddr1   = n_build     /* A62-0219*/
        sicsyac.xmm600.naddr2   = n_tambon    /* A62-0219*/
        sicsyac.xmm600.naddr3   = n_amper     /* A62-0219*/
        sicsyac.xmm600.naddr4   = n_post      /* A62-0219*/
        sicsyac.xmm600.anlyc1   = n_taxno  .  /* A62-0219*/ 
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
            sicsyac.xtm600.addr1   = TRIM(wdetail.addr1)     /*address line 1*/
            sicsyac.xtm600.addr2   = TRIM(wdetail.addr2)     /*address line 2*/
            sicsyac.xtm600.addr3   = TRIM(wdetail.addr3)     /*address line 3*/
            sicsyac.xtm600.addr4   = TRIM(wdetail.addr4)     /*address line 4*/
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
    sicsyac.xmm600.acno     =  n_insref   NO-ERROR NO-WAIT.  
IF AVAIL sicsyac.xmm600 THEN
    ASSIGN
    sicsyac.xmm600.acno_typ  = trim(wdetail.insnamtyp)   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    sicsyac.xmm600.icno      = trim(wdetail.idno)       
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured) */  .  
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN
    ASSIGN 
    sicsyac.xtm600.postcd    = trim(wdetail.postcd)          
    sicsyac.xtm600.firstname = trim(wdetail.firstName)       
    sicsyac.xtm600.lastname  = trim(wdetail.lastName)    .  
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
ASSIGN  nv_insref = "" .
FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
    sicsyac.xzm056.seqtyp   =  nv_typ        AND
    sicsyac.xzm056.branch   =  wdetail.n_branch     NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp   =  nv_typ
            sicsyac.xzm056.branch   =  wdetail.n_branch
            sicsyac.xzm056.des      =  "Personal/Start"
            sicsyac.xzm056.lastno   =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref     =    wdetail.n_branch   + String(1,"999999")
            nv_lastno  =    1.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(wdetail.n_branch) = 2 THEN
            nv_insref = wdetail.n_branch + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:   
            /*comment by Kridtiya i. A56-0310...
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + wdetail.n_branch + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       wdetail.n_branch + STRING(sicsyac.xzm056.lastno + 1 ,"999999").*/
            /*Add A56-0310 */
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                     nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                     nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.
            /*Add A56-0310 */
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  wdetail.n_branch
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(wdetail.n_branch) = 2 THEN
            nv_insref = wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").
        END.   
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  wdetail.n_branch
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(wdetail.n_branch) = 2 THEN
            nv_insref = wdetail.n_branch + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
            /*comment by Kridtiya i. A56-0310....
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.n_branch + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       wdetail.n_branch + STRING(sicsyac.xzm056.lastno,"999999").    kridtiya i. A56-0310 .*/
            /*add A56-0310 */
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.
            /*add A56-0310 */
        END.
    END.
    ELSE DO:
        IF LENGTH(wdetail.n_branch) = 2 THEN
            nv_insref = wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno,"99999").
        END.
    END.   
END.
IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno Then Do :
   /* MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
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
                sicsyac.xzm056.branch    =  wdetail.n_branch
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
                sicsyac.xzm056.branch    =  wdetail.n_branch
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
DEF VAR nv_lnumber AS INT INIT 0.

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
  
  nv_drivage1 =  YEAR(TODAY) - (INT(SUBSTR(wdetail.BDriv1,7,4)) - 543).
  nv_drivage2 =  YEAR(TODAY) - (INT(SUBSTR(wdetail.BDriv2,7,4)) - 543).

  IF wdetail.BDriv1 <> " "  AND wdetail.Driv1 <> " " THEN DO: /*note add & modified*/
     nv_drivbir1      = STRING(INT(SUBSTR(wdetail.BDriv1,7,4))).
     wdetail.BDriv1   = SUBSTR(wdetail.BDriv1,1,2) + "/" + SUBSTR(wdetail.BDriv1,4,2) + "/"  + nv_drivbir1.
  END.

  IF wdetail.BDriv2 <>  " " AND wdetail.Driv2 <> " " THEN DO: /*note add & modified */
     nv_drivbir2      = STRING(INT(SUBSTR(wdetail.BDriv2,7,4))).
     wdetail.BDriv2   = SUBSTR(wdetail.BDriv2,1,2) + "/" + SUBSTR(wdetail.BDriv2,4,2) + "/" + nv_drivbir2.
  END.
  
  FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
               brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
               brstat.mailtxt_fil.bchyr   = nv_batchyr   AND                                               
               brstat.mailtxt_fil.bchno   = nv_batchno   AND
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
                     brstat.mailtxt_fil.ltext     = wdetail.Driv1 + FILL(" ",50 - LENGTH(wdetail.Driv1)). 
                     brstat.mailtxt_fil.ltext2    = wdetail.BDriv1 + "  " 
                                                  + string(nv_drivage1).
                     nv_drivno                    = 1.
                     ASSIGN 
                        brstat.mailtxt_fil.bchyr = nv_batchyr 
                        brstat.mailtxt_fil.bchno = nv_batchno 
                        brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                        SUBSTRING(brstat.mailtxt_fil.ltext2,16,40) = "-"   
                        SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.idDriv1)
                        SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.LicenceNo1). 
              IF wdetail.Driv2 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil. 
                    ASSIGN
                        brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                        brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                        brstat.mailtxt_fil.ltext    = wdetail.Driv2 + FILL(" ",50 - LENGTH(wdetail.Driv2)). 
                        brstat.mailtxt_fil.ltext2   = wdetail.BDriv2 + "  "
                                                    + string(nv_drivage2). 
                        nv_drivno                   = 2.
                        ASSIGN /*a490166*/
                        brstat.mailtxt_fil.bchyr = nv_batchyr 
                        brstat.mailtxt_fil.bchno = nv_batchno 
                        brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                        SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
                        SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.idDriv2)
                        SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.LicenceNo2). 
              END.  /*drivnam2 <> " " */
        END. /*End Avail Brstat*/
        ELSE  DO:
              CREATE  brstat.mailtxt_fil.
              ASSIGN  brstat.mailtxt_fil.policy     = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
                      brstat.mailtxt_fil.lnumber    = nv_lnumber.
                      brstat.mailtxt_fil.ltext      = wdetail.Driv1 + FILL(" ",50 - LENGTH(wdetail.Driv1)). 
                      brstat.mailtxt_fil.ltext2     = wdetail.BDriv1 + "  " +  TRIM(string(nv_drivage1)).
                      ASSIGN 
                      SUBSTRING(brstat.mailtxt_fil.ltext2,16,30)  = "-" 
                      SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.idDriv1)
                      SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.LicenceNo1).

                      IF wdetail.driv2 <> "" THEN DO:
                            CREATE  brstat.mailtxt_fil.
                                ASSIGN
                                brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                                brstat.mailtxt_fil.ltext    = wdetail.driv2 + FILL(" ",30 - LENGTH(wdetail.driv2)). 
                                brstat.mailtxt_fil.ltext2   = wdetail.BDriv2 + "  " + TRIM(string(nv_drivage2)).
                                ASSIGN 
                                brstat.mailtxt_fil.bchyr = nv_batchyr 
                                brstat.mailtxt_fil.bchno = nv_batchno 
                                brstat.mailtxt_fil.bchcnt  = nv_batcnt
                                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-" 
                                SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.idDriv2)
                                SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.LicenceNo2). .
                      END. /*drivnam2 <> " " */
        END. /*Else DO*/
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
IF wdetail.model = "commuter" THEN wdetail.seat = "12".
IF (wdetail.si = "") OR (wdetail.si = "0.00") OR (wdetail.si = "0" ) THEN DO:
    Find LAST stat.maktab_fil Use-index      maktab04           Where
        stat.maktab_fil.makdes   =    trim(wdetail.brand)             And                  
        /*index(stat.maktab_fil.moddes,wdetail.model) <> 0        And */   /*A60-0263*/
        index(stat.maktab_fil.moddes,nv_moddes) <> 0              AND        /*A60-0263*/
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.engine   >=    Integer(wdetail.engcc)   AND 
        stat.maktab_fil.sclass   =     wdetail.subclass         AND
        stat.maktab_fil.seats    =     INTE(wdetail.seat)    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN  
        wdetail.redbook         =  stat.maktab_fil.modcod
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        nv_engine               =  stat.maktab_fil.engine.
END.
ELSE IF wdetail.covcod = "T" THEN DO:
    Find LAST stat.maktab_fil Use-index      maktab04           Where
        stat.maktab_fil.makdes   =    wdetail.brand               And                  
        /*index(stat.maktab_fil.moddes,wdetail.model) <> 0        And */   /*A60-0263*/
        index(stat.maktab_fil.moddes,nv_moddes) <> 0              AND        /*A60-0263*/
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear)   AND
        stat.maktab_fil.engine   >=    Integer(wdetail.engcc)     AND
        stat.maktab_fil.sclass   =     n_sclass72                 AND
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)      No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook         =  stat.maktab_fil.modcod
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        nv_engine               =  stat.maktab_fil.engine.
END.
ELSE DO:
    Find LAST stat.maktab_fil Use-index      maktab04             Where
        stat.maktab_fil.makdes   =    trim(wdetail.brand)         And                  
        /*index(stat.maktab_fil.moddes,wdetail.model) <> 0        And */   /*A60-0263*/
        index(stat.maktab_fil.moddes,nv_moddes) <> 0              AND        /*A60-0263*/
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear)   AND
        stat.maktab_fil.engine   >=     Integer(wdetail.engcc)     AND
        stat.maktab_fil.sclass   =     wdetail.subclass           AND
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)      No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook         =  stat.maktab_fil.modcod
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        nv_engine               =  stat.maktab_fil.engine.
END.
IF wdetail.model = "commuter" THEN wdetail.seat = "16".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab301 c-Win 
PROCEDURE proc_maktab301 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail.model = "commuter" THEN wdetail.seat = "12".
IF (wdetail.si = "") OR (wdetail.si = "0.00") OR (wdetail.si = "0" ) THEN DO:
    Find LAST stat.maktab_fil Use-index      maktab04           Where
        stat.maktab_fil.makdes   =    wdetail.brand             And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And 
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
      /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass         AND
     /*(stat.maktab_fil.si - (stat.maktab_fil.si * 30 / 100 ) LE deci(wdetail.si)   AND 
        stat.maktab_fil.si + (stat.maktab_fil.si * 30 / 100 ) GE deci(wdetail.si) ) AND*/
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN  wdetail.redbook        =  stat.maktab_fil.modcod
        /*sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes */
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        /*sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.engine  =  stat.maktab_fil.eng*/
        nv_engine               =  stat.maktab_fil.engine.
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
        /*sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        /*sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.engine  =  stat.maktab_fil.eng*/
        nv_engine               =  stat.maktab_fil.engine.
END.
IF wdetail.model = "commuter" THEN wdetail.seat = "16".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchpolicy c-Win 
PROCEDURE proc_matchpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    OUTPUT TO VALUE(fi_output1).
    EXPORT DELIMITER "|" 
        "Match Policy ORICO :" string(TODAY)   .
    EXPORT DELIMITER "|"
        "Type.           "
        "เลขที่กรมธรรม์  "
        "เลขเครื่องหมาย  "
        "ชื่อผู้เอาประกัน"
        "ที่อยู่         "
        "วันเริ่มคุ้มครอง/เวลา " 
        "วันสิ้นสุด      "
        "รหัส            "
        "ยี่ห้อ          "
        "รุ่นรถ          "
        "ทะเบียนรถ       "
        "จังหวัด         "
        "เลขตัวถัง       "
        "ประเภท          "
        "ขนาดเครื่องยนต์ "
        "เลขเครื่องยนต์  "
        "ปีจดทะเบียน     "
        "เบี้ยสุทธิ      "
        "อากร            "
        "ภาษี            "
        "เบี้ยรวมภาษีอากร"
        "การใช้รถ        "
        "วันออกกรมธรรม์  "
        "เลขที่สัญญา     "
        "ID Card         "
        "Producer        "
        "Agent           "
        "Branch          "
        "Docno           "
        "อาชีพ           "
        "Comment         "
        "Match Policy    "
        "Match STK/Docno " SKIP .

    FOR EACH wdetail NO-LOCK.
        EXPORT DELIMITER "|"
            wdetail.insref                   /*No.             */              
            wdetail.policy                   /*เลขที่รับแจ้ง   */             
            wdetail.stk                      /* stk no */                     
            wdetail.insnam                   /*ชื่อผู้เอาประกันภัย     */     
            wdetail.addr1                    /*ที่อยู่ในการจัดส่งเอกสาร    */
            wdetail.comdat 
            wdetail.expdat 
            wdetail.subclass                 /*รหัสรถยนต์ */                  
            wdetail.brand                    /*ยี่ห้อรถ  */                   
            wdetail.model                   /* รุ่นรถ */                      
            wdetail.vehuse                   /*เลขทะเบียน  */                 
            wdetail.re_country               /*จังหวัด     */                 
            wdetail.chasno                   /*เลขตัวถัง      */              
            wdetail.body                     /* ประเภท */                     
            wdetail.engcc                    /*ขนาดเครื่องยนต์*/              
            wdetail.eng                      /*เลขเครื่องยนต์ */              
            wdetail.caryear                  /*ปี   */                        
            wdetail.premt                    /*เบี้ยสุทธิ */                  
            wdetail.volprem                  /* tax  */                       
            wdetail.comper                   /* vat  */                       
            wdetail.comacc                   /*เบี้ยพรบ รวม   */              
            wdetail.txtmemo                  /*การใช้รถ    */                 
            wdetail.daterequest              /*วันที่ออกกรมธรรม์ */           
            wdetail.cedpol                   /*Agreement No.   */             
            wdetail.idno                     /*ID. Card No.            */     
            wdetail.producer                 /*Producer   */                  
            wdetail.agent                    /*Agent      */                  
            wdetail.n_branch                 /*Branch     */                  
            wdetail.docno                   /* doc no */                      
            wdetail.occup                   /*อาชีพ      */                   
            wdetail.comment                  /*comment*/                      
            wdetail.txtmemo1     
            wdetail.txtmemo2    SKIP.
    END.                         
                                 
END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matpol c-Win 
PROCEDURE proc_matpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FOR EACH wdetail.
        DELETE wdetail.
    END.
    INPUT FROM VALUE(fi_filename).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|"
            wdetail.insref                       /*No.             */
            wdetail.policy                       /*เลขที่รับแจ้ง   */
            wdetail.stk                          /* stk no */
            wdetail.insnam                       /*ชื่อผู้เอาประกันภัย     */  
            wdetail.addr1                        /*ที่อยู่ในการจัดส่งเอกสาร    */ 
            wdetail.comdat
            wdetail.expdat
            wdetail.subclass                     /*รหัสรถยนต์ */   
            wdetail.brand                        /*ยี่ห้อรถ  */
            wdetail.model                       /* รุ่นรถ */        
            wdetail.vehuse                       /*เลขทะเบียน  */                 
            wdetail.re_country                   /*จังหวัด     */
            wdetail.chasno                       /*เลขตัวถัง      */   
            wdetail.body                         /* ประเภท */   
            wdetail.engcc                        /*ขนาดเครื่องยนต์*/                             
            wdetail.eng                          /*เลขเครื่องยนต์ */ 
            wdetail.caryear                      /*ปี   */ 
            wdetail.premt                        /*เบี้ยสุทธิ */                           
            wdetail.volprem                      /* tax  */                           
            wdetail.comper                       /* vat  */                           
            wdetail.comacc                       /*เบี้ยพรบ รวม   */ 
            wdetail.txtmemo                      /*การใช้รถ    */
            wdetail.daterequest                  /*วันที่ออกกรมธรรม์ */
            wdetail.cedpol                       /*Agreement No.   */ 
            wdetail.idno                         /*ID. Card No.            */  
            wdetail.producer                     /*Producer   */                                 
            wdetail.agent                        /*Agent      */                                 
            wdetail.n_branch                     /*Branch     */ 
            wdetail.docno                       /* doc no */
            wdetail.occup                       /*อาชีพ      */
            wdetail.comment   .                  /*comment*/  
                                         
        IF index(wdetail.insref,"Type") <> 0  THEN DELETE wdetail. /*a62-0219*/
        ELSE IF wdetail.insref = "" THEN DELETE wdetail.
    END.
    FOR EACH wdetail WHERE wdetail.chasno <> "" NO-LOCK.
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = TRIM(wdetail.policy) NO-LOCK NO-ERROR. 
            IF AVAIL uwm100 THEN DO:
                FIND LAST brstat.tlt USE-INDEX tlt06  WHERE        
                           brstat.tlt.cha_no       = trim(wdetail.chasno)   AND
                           brstat.tlt.comp_pol     = TRIM(wdetail.policy)   AND 
                           brstat.tlt.flag         = "COMP"                 AND
                           brstat.tlt.genusr       = "ORICO"                NO-ERROR NO-WAIT .
                IF AVAIL brstat.tlt THEN DO:
                    IF brstat.tlt.releas = "NO" THEN DO:
                        ASSIGN brstat.tlt.dat_ins_noti =   TODAY
                               brstat.tlt.releas       =   "YES" 
                               wdetail.txtmemo1        =   "Complete".
                    END.
                    ELSE DO:
                        ASSIGN wdetail.txtmemo1 = "ออกงานแล้ว " + STRING(brstat.tlt.dat_ins_noti,"99/99/9999") .

                    END.
                END.
                ELSE DO:
                    ASSIGN wdetail.txtmemo1 = "ไม่พบข้อมูลในถังพัก ORICO " .
                END.
                    
                FIND LAST brstat.tlt USE-INDEX tlt06 WHERE 
                          brstat.tlt.cha_no         = trim(wdetail.stk)     AND   /* stk */
                          brstat.tlt.nor_noti_tlt   = trim(wdetail.policy)   AND   /* comp no. */
                          brstat.tlt.genusr         = trim(wdetail.producer)  NO-WAIT  NO-ERROR .   /* Producer */  
                IF AVAIL brstat.tlt THEN DO:
                    IF brstat.tlt.releas = "YES" THEN DO:
                        ASSIGN wdetail.txtmemo2 = "มีการใช้งานแล้ว " + brstat.tlt.filler2 .
                    END.
                    ELSE DO:
                        ASSIGN  brstat.tlt.releas  = "YES"
                                brstat.tlt.safe2   = IF brstat.tlt.safe2 = "" THEN TRIM(wdetail.docno) ELSE brstat.tlt.safe2 
                                brstat.tlt.filler2 = IF INDEX(brstat.tlt.filler2,"ออกงาน") <> 0 THEN  brstat.tlt.filler2 
                                                     ELSE brstat.tlt.filler2 + " " + "ออกงาน : " + STRING(TODAY,"99/99/9999")
                                wdetail.txtmemo2   = "Complete".
                    END.
                END.
                ELSE DO: 
                     FIND LAST brstat.tlt WHERE 
                          brstat.tlt.nor_noti_tlt   = trim(wdetail.policy)   AND   /* comp no. */
                          brstat.tlt.genusr         = trim(wdetail.producer)  NO-WAIT  NO-ERROR .   /* Producer */
                     IF AVAIL brstat.tlt THEN DO:
                        IF brstat.tlt.releas = "YES" THEN DO:
                          ASSIGN wdetail.txtmemo2 = "มีการใช้งานแล้ว " + brstat.tlt.filler2 .
                        END.
                        ELSE DO:
                            ASSIGN  brstat.tlt.releas  = "YES"
                                    brstat.tlt.cha_no  = trim(wdetail.stk)
                                    brstat.tlt.safe2   = IF brstat.tlt.safe2 = "" THEN TRIM(wdetail.docno) ELSE brstat.tlt.safe2 
                                    brstat.tlt.filler2 = IF INDEX(brstat.tlt.filler2,"ออกงาน") <> 0 THEN  brstat.tlt.filler2 
                                                         ELSE brstat.tlt.filler2 + " " + "ออกงาน : " + STRING(TODAY,"99/99/9999")
                                    wdetail.txtmemo2   = "Complete".
                        END.
                     END.
                     ELSE ASSIGN wdetail.txtmemo2 = "ไม่พบข้อมูลที่ Data Sticker BU3 " .
                END.
            END.
    END.
    RUN proc_matchpolicy . 

    MESSAGE "Match policy complete !!" VIEW-AS ALERT-BOX.
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
    wdetail.model  = n_model.
    IF index(wdetail.brand,"benz") <> 0 THEN wdetail.brand = "MERCEDES-BENZ".
    IF index(wdetail.model,"cab4") <> 0 THEN wdetail.model = "cab".
END.
ELSE DO:
    IF index(wdetail.brand,"benz") <> 0 THEN wdetail.brand = "MERCEDES-BENZ".
    ASSIGN 
    n_index = INDEX(n_model," ") + 1
    n_model = substr(n_model,n_index,LENGTH(n_model))
    n_index = INDEX(n_model," ") - 1.
    IF n_index < 1  THEN wdetail.model  = substr(n_model,1,LENGTH(n_model)) .
    ELSE wdetail.model  = substr(n_model,1,n_index) .
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
DEF VAR n_promt     AS CHAR FORMAT "x(30)" INIT "".
ASSIGN n_promt = "" 
    fi_process = "Create data ICBC  to uwm100 ... " + wdetail.policy .
DISP   fi_process WITH FRAM fr_main.
IF wdetail.poltyp = "v72" THEN n_rencnt = 0.  
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
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
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
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.       /*wdetail.stk  <>  ""*/
    ELSE DO:   /*sticker = ""*/ 
        IF TRIM(wdetail.cedpol) <> ""  THEN DO: /*A61-0234*/
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol  = trim(wdetail.cedpol) AND 
                                                            sicuw.uwm100.poltyp  = trim(wdetail.poltyp) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF ( sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES )
                    AND (sicuw.uwm100.expdat > date(wdetail.comdat)) THEN  
                    ASSIGN  wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| เลขที่สัญญานี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
                IF wdetail.policy = "" THEN DO:
                    RUN proc_temppolicy.
                    wdetail.policy  = nv_tmppol.
                END.
                RUN proc_create100. 
            END.
            ELSE RUN proc_create100.  
    END.
    ELSE RUN proc_create100.  /*A61-0234*/ 
    END.
END.
ELSE DO:    /*  wdetail.policy = ""  */
    IF wdetail.stk  <>  ""  THEN DO:
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy NO-LOCK NO-ERROR NO-WAIT.
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
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
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
IF wdetail.poltyp = "V70"  AND wdetail.Docno <> ""  THEN 
    ASSIGN  nv_docno  = wdetail.Docno
    nv_accdat = TODAY.
ELSE DO:
        IF wdetail.docno  = "" THEN nv_docno  = "".
        IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
IF ( wdetail.poltyp = "v72" )  THEN wdetail.benname = "".  /*A62-0343*/
RUN proc_insnam.   /*A62-0219*/
RUN proc_insnam2.  /*Add by Kridtiya i. A63-0472*/
DO TRANSACTION:
   ASSIGN
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = wdetail.poltyp
      sic_bran.uwm100.insref = wdetail.insref
      sic_bran.uwm100.opnpol = wdetail.promo
      sic_bran.uwm100.cr_1   = TRIM(wdetail.campaign)
      sic_bran.uwm100.anam2  = trim(wdetail.idno)            /* ICNO  Cover Note A51-0071 Amparat */
      sic_bran.uwm100.ntitle = trim(wdetail.tiname)       
      sic_bran.uwm100.name1  = trim(wdetail.insnam)                                                                 /*a60-0489*/
      sic_bran.uwm100.name2  = IF TRIM(wdetail.np_name2) <> "" THEN " และ/หรือ " + TRIM(wdetail.np_name2) ELSE ""   /*a60-0489*/
     /* sic_bran.uwm100.name1  = IF trim(wdetail.np_name2) <> "" THEN trim(wdetail.np_name2) ELSE trim(wdetail.insnam)        
      sic_bran.uwm100.name2  = IF TRIM(wdetail.np_name2) <> "" THEN " และ/หรือ " + trim(wdetail.tiname) + trim(wdetail.insnam) ELSE ""  */    /*และ/หรือ */              
      sic_bran.uwm100.name3  = "" /*wdetail.np_name3*/              
      sic_bran.uwm100.addr1  = wdetail.addr1                 /* trim(wdetail.addr1)   */      
      sic_bran.uwm100.addr2  = wdetail.addr2                 /* trim(wdetail.tambon)  */      
      sic_bran.uwm100.addr3  = wdetail.addr3                 /* trim(wdetail.amper + " " + wdetail.country)   */
      sic_bran.uwm100.addr4  = wdetail.addr4                 /* ""  */                        
      sic_bran.uwm100.postcd = ""                            
      sic_bran.uwm100.undyr  = String(Year(today),"9999")    /* nv_undyr  */
      sic_bran.uwm100.branch = caps(trim(wdetail.n_branch))  /* nv_branch  */                        
      sic_bran.uwm100.dept   = nv_dept                       
      sic_bran.uwm100.usrid  = USERID(LDBNAME(1))            
      /*sic_bran.uwm100.fstdat = TODAY  */                   /*TODAY *//*kridtiya i. a53-0171*/
      sic_bran.uwm100.fstdat = DATE(wdetail.firstdat)        /*kridtiya i. a53-0171 ให้ firstdate=comdate */
      sic_bran.uwm100.comdat = DATE(wdetail.comdat)          
      sic_bran.uwm100.expdat = date(wdetail.expdat)          
      sic_bran.uwm100.accdat = nv_accdat                     
      sic_bran.uwm100.tranty = "N"                           /*Transaction Type (N/R/E/C/T)*/
      sic_bran.uwm100.langug = "T"
      sic_bran.uwm100.acctim = "00:00"
      sic_bran.uwm100.trty11 = "M"      
      sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")     
      sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")
      sic_bran.uwm100.entdat = TODAY
      sic_bran.uwm100.curbil = "BHT"
      sic_bran.uwm100.curate = 1
      sic_bran.uwm100.instot = 1
      sic_bran.uwm100.prog   = "wgwtlori"
      sic_bran.uwm100.cntry  = "TH"       /*Country where risk is situated*/
      sic_bran.uwm100.insddr = YES        /*Print Insd. Name on DrN       */
      sic_bran.uwm100.no_sch = 0          /*No. to print, Schedule        */
      sic_bran.uwm100.no_dr  = 1          /*No. to print, Dr/Cr Note      */
      sic_bran.uwm100.no_ri  = 0          /*No. to print, RI Appln        */
      sic_bran.uwm100.no_cer = 0          /*No. to print, Certificate     */
      sic_bran.uwm100.li_sch = YES        /*Print Later/Imm., Schedule    */
      sic_bran.uwm100.li_dr  = YES        /*Print Later/Imm., Dr/Cr Note  */
      sic_bran.uwm100.li_ri  = YES        /*Print Later/Imm., RI Appln,   */
      sic_bran.uwm100.li_cer = YES        /*Print Later/Imm., Certificate */
      sic_bran.uwm100.apptax = YES        /*Apply risk level tax (Y/N)    */
      sic_bran.uwm100.recip  = "N"        /*Reciprocal (Y/N/C)            */
      sic_bran.uwm100.short  = NO
      sic_bran.uwm100.acno1  = caps(trim(wdetail.producer))   /*  nv_acno1 */
      sic_bran.uwm100.agent  = caps(trim(wdetail.agent))      /*nv_agent   */
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
      sic_bran.uwm100.cr_2    = wdetail.cr_2
      sic_bran.uwm100.bchyr   = nv_batchyr           /*Batch Year */  
      sic_bran.uwm100.bchno   = nv_batchno           /*Batch No.  */  
      sic_bran.uwm100.bchcnt  = nv_batcnt            /*Batch Count*/  
      sic_bran.uwm100.prvpol  = trim(wdetail.prepol)       
      sic_bran.uwm100.cedpol  = trim(wdetail.cedpol) 
      sic_bran.uwm100.occupn  = wdetail.occup
      sic_bran.uwm100.finint  = ""
      sic_bran.uwm100.bs_cd   = wdetail.vatcode   /*add เพิ่ม Vatcode */
      /*sic_bran.uwm100.endern  = date(wdetail.ac_date)*/    
      sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)    /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)     /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.postcd     = trim(wdetail.postcd)       /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.icno       = trim(wdetail.idno)         /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)      /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)    /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)    /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)    /*Add by Kridtiya i. A63-0472*/
      /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*/   /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov)  /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.dealer     = trim(wdetail.financecd).   /*Add by Kridtiya i. A63-0472*/ 

      IF wdetail.prepol <> " " THEN DO:
          IF wdetail.poltyp = "v72"  THEN ASSIGN  sic_bran.uwm100.prvpol  = ""
                                                  sic_bran.uwm100.tranty  = "R".  
          ELSE 
              ASSIGN  sic_bran.uwm100.prvpol  = wdetail.prepol     /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                      sic_bran.uwm100.tranty  = "R".                   /*Transaction Type (N/R/E/C/T)*/
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
      IF (DAY(sic_bran.uwm100.comdat)      =  DAY(sic_bran.uwm100.expdat)    AND
          MONTH(sic_bran.uwm100.comdat)    =  MONTH(sic_bran.uwm100.expdat)  AND
          YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) ) OR
         (DAY(sic_bran.uwm100.comdat)      =  29                             AND
          MONTH(sic_bran.uwm100.comdat)    =  02                             AND
          DAY(sic_bran.uwm100.expdat)      =  01                             AND
          MONTH(sic_bran.uwm100.expdat)    =   03                            AND
          YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
                THEN  nv_polday = 365.
      ELSE  nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
END. /*transaction*//**/
/*IF (wdetail.poltyp = "v70") AND (wdetail.txtmemo <> "")  THEN RUN proc_uwd102.   /*memmo F18 */*//*A57-0125*/
/*IF (wdetail.poltyp = "v70") THEN  RUN proc_uwd102. 
IF (wdetail.poltyp = "v70") THEN  RUN proc_uwd100. *//*A57-0125*/
IF wdetail.txtmemo <> ""  THEN  RUN proc_uwd102.
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
        sic_bran.uwm120.bchyr  = nv_batchyr     /* batch Year */
        sic_bran.uwm120.bchno  = nv_batchno     /* bchno      */
        sic_bran.uwm120.bchcnt = nv_batcnt .    /* bchcnt     */
        ASSIGN sic_bran.uwm120.class  = IF wdetail.poltyp = "v72" THEN wdetail.subclass ELSE wdetail.prempa + wdetail.subclass 
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
/*MESSAGE "111DB CONNECT" SKIP 
"PD: " PDBNAME(1) " LD: " LDBNAME(1) SKIP
"PD: " PDBNAME(2) " LD: " LDBNAME(2) SKIP
"PD: " PDBNAME(3) " LD: " LDBNAME(3) SKIP
"PD: " PDBNAME(4) " LD: " LDBNAME(4) SKIP
"PD: " PDBNAME(5) " LD: " LDBNAME(5) SKIP
"PD: " PDBNAME(6) " LD: " LDBNAME(6) SKIP
"PD: " PDBNAME(7) " LD: " LDBNAME(7) SKIP 
"PD: " PDBNAME(8) " LD: " LDBNAME(8) SKIP VIEW-AS ALERT-BOX. */ 
FIND LAST sicuw.uwm100  Use-index uwm10001    WHERE 
    sicuw.uwm100.policy = wdetail.prepol      No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF sicuw.uwm100.renpol <> " " THEN DO:
        MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
        ASSIGN
            wdetail.prepol  = "Already Renew" /*ทำให้รู้ว่าเป็นงานต่ออายุ*/
            wdetail.comment = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
            wdetail.OK_GEN  = "N"
            wdetail.pass    = "N". 
    END.
    ELSE DO: 
        ASSIGN
            wdetail.prepol = sicuw.uwm100.policy
            n_rencnt       =  sicuw.uwm100.rencnt  +  1
            n_endcnt       =  0
            wdetail.pass   = "Y".
        RUN proc_assignrenew .  /*รับค่า ความคุ้มครองของเก่า */
    END.
END.   /*  avail  buwm100  */
Else do: 
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0
        wdetail.prepol   = ""
        wdetail.comment  = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".
END.    /*not  avail uwm100*/
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
    "special5    " ","
    "specialprem5" ","
    "comment     " "," 
    "WARNING     " 
            SKIP.                                                   
FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"    :   
        PUT STREAM ns1 
            wdetail.redbook     "," 
            /*wdetail.n_branch     "," */
            /*wdetail.n_delercode  "," */
            /*wdetail.typrequest   "," */
            wdetail.policy       ","
        wdetail.cndat         ","
        wdetail.comdat        ","
        wdetail.expdat        ","
        wdetail.covcod        ","
        wdetail.garage        "," 
        wdetail.tiname        ","
        wdetail.insnam        ","
        
        wdetail.addr1          ","  
        wdetail.tambon        ","  
        wdetail.amper         ","  
        wdetail.country       ","  
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
        /*wdetail.re_year       "," */
        wdetail.si            "," 
        wdetail.premt         "," 
        /*wdetail.rstp_t        "," 
        wdetail.rtax_t        "," */
        /*wdetail.prem_r        "," */
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
         
        /*wdetail.tpfire        ","  */ 
        wdetail.compul        ","   
        wdetail.pass          ","     
       /* wdetail.NO_41         "," */  
        /*wdetail.ac2           ","  
        wdetail.NO_42         ","   
        wdetail.ac4           ","   
        wdetail.ac5           ","   
        wdetail.ac6           ","   
        wdetail.ac7           ","   
        wdetail.NO_43         ","   
        wdetail.nstatus       ","   
        wdetail.typrequest    ","   
        wdetail.comrequest    ","   
        wdetail.brrequest     ","    
        wdetail.salename      ","   
        wdetail.comcar        ","   
        wdetail.brcar         ","   
        wdetail.projectno     ","   
        wdetail.caryear       ","   
        wdetail.special1      ","   
        wdetail.specialprem1  ","   
        wdetail.special2      ","   
        wdetail.specialprem2  ","   
        wdetail.special3      ","   
        wdetail.specialprem3  ","   
        wdetail.special4      ","   
        wdetail.specialprem4  ","  
        wdetail.special5      ","  
        wdetail.specialprem5  ","  */
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
FOR EACH  wdetail WHERE  wdetail.PASS = "Y"  :
        pass = pass + 1.
END.
IF pass > 0 THEN DO:
OUTPUT STREAM ns2 TO value(fi_output1).
PUT STREAM NS2
    "Redbook "   ","
    "Branch  "  ","   
    "Delercode"  ","   
    "Vatcode "     "," 
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
    "WARNING     "    SKIP.        
FOR EACH  wdetail   WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
            wdetail.redbook    ","   
            /*wdetail.n_branch     ","   
            wdetail.n_delercode  ","   
            wdetail.typrequest   ","  */ 
            wdetail.policy      ","
            wdetail.cndat         ","
            wdetail.comdat        ","
            wdetail.expdat        ","
            /*wdetail.comcode       ","*/
            /*wdetail.cartyp        ","
            wdetail.active      ","
            wdetail.nSTATUS     "," 
            wdetail.flag        ","*/
            wdetail.covcod        ","
            wdetail.garage       "," 
            wdetail.tiname        ","
            wdetail.insnam        ","
           /* wdetail.name2         ","*/  
            wdetail.addr1          ","  
            wdetail.tambon        ","  
            wdetail.amper         ","  
            wdetail.country       ","  
            /*wdetail.birthdat      ","  
            wdetail.driverno      "," */              
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
            /*wdetail.re_year       "," */
            wdetail.si            "," 
            wdetail.premt         "," 
            /*wdetail.rstp_t        "," 
            wdetail.rtax_t        "," */
            /*wdetail.prem_r        "," */
            wdetail.ncb           "," 
       /* wdetail.ncbprem       "," */
            wdetail.stk           ","
            wdetail.prepol        ","
            wdetail.benname       ","   
            wdetail.comper        ","   
            wdetail.comacc        ","   
            wdetail.deductpd      ","   
            /*wdetail.tp2           "," */  
       /* wdetail.deductda      ","  */ 
             
            wdetail.compul        ","   
            wdetail.pass          ","     
            wdetail.comment       ","
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
"       Producer Code : " "A0M0079"   SKIP
"          Agent Code : " "B300300"      SKIP
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
    nv_idnolist    = trim(wdetail.idno) .

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
        ASSIGN 
            wdetail.comment = wdetail.comment + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 c-Win 
PROCEDURE proc_uwd100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*create  text (F17) for Query claim....*/
/*DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
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
    nv_txt2  = wdetail.accsor
    nv_txt3  = wdetail.accprice
    nv_txt4  = wdetail.inspec
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
DEF VAR n_num1 AS INTE INIT 0.
DEF VAR n_num2 AS INTE INIT 0.
DEF VAR n_num3 AS INTE INIT 1.
DEF VAR i AS INTE INIT 0.
DEF VAR n_text1 AS CHAR FORMAT "x(255)".
ASSIGN nv_fptr = 0
       nv_bptr = 0
       nv_nptr = 0
       nv_line1 = 1.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
    DO WHILE nv_line1 <= 10 : 
        CREATE wuppertxt.
        wuppertxt.line = nv_line1.
        IF nv_line1 = 1 THEN wuppertxt.txt = ""                                 .
        IF nv_line1 = 2 THEN wuppertxt.txt = wdetail.txtmemo                    .
        /*IF nv_line1 = 3 THEN wuppertxt.txt = wdetail.txtmemo1                   .
        IF nv_line1 = 4 THEN wuppertxt.txt = wdetail.txtmemo2                   .
        IF nv_line1 = 5 THEN wuppertxt.txt = wdetail.accsor + wdetail.accprice  .
        IF nv_line1 = 6 THEN wuppertxt.txt = wdetail.receipt_name               .
        IF nv_line1 = 7 THEN wuppertxt.txt = wdetail.inspec                     .*/

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
        FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
            CREATE sic_bran.uwd102.
            ASSIGN
                sic_bran.uwd102.policy        = sic_bran.uwm100.policy        
                sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt 
                sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt        
                sic_bran.uwd102.ltext         = wuppertxt.txt
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm100 c-Win 
PROCEDURE proc_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) >= 365 ) AND
       (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) <= 366 ) THEN DO:
        ASSIGN 
        nv_gapprm  =  IF wdetail.premt = "" THEN nv_gapprm ELSE DECI(wdetail.premt)
        nv_pdprm   =  IF wdetail.premt = "" THEN nv_pdprm  ELSE DECI(wdetail.premt).
    END.
    ELSE DO:  /*เบี้ย ไม่เต็มปี หรือ เกินปี */
        ASSIGN nv_pdprm   =  IF wdetail.premt = "" THEN nv_pdprm  ELSE DECI(wdetail.premt).
    END.
    
    FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
    IF AVAIL  sic_bran.uwm100 THEN DO:
         ASSIGN  
             /*sic_bran.uwm100.prem_t = nv_gapprm*/     /* A57-0426 */
             sic_bran.uwm100.prem_t = nv_pdprm          /* A57-0426 *//*เบี้ย ไม่เต็มปี หรือ เกินปี */
             sic_bran.uwm100.sigr_p = inte(wdetail.si)
             sic_bran.uwm100.gap_p  = nv_gapprm.
    
         IF wdetail.pass <> "Y" THEN 
             ASSIGN
             sic_bran.uwm100.impflg = NO
             sic_bran.uwm100.imperr = wdetail.comment.    
         
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
      IF s_curbil = "BHT" THEN  sic_bran.uwd132.prem_c = sic_bran.uwd132.prem_c.
    END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

