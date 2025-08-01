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
/*programid   : wgwlicbc.w                                             */ 
/*programname : Load text file ICBC to GW                          */ 
/* Copyright  : Safety Insurance Public Company Limited                */
/*copy write  : wgwargen.w                                             */ 
/*              ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)                     */
/* create by : Ranu I. A59-0288 Date : 30/09/2016                      */
/*             Load text file ICBC to gw                                */
/* Modify By : Ranu I. A60-0263 date : 13/06/2017   ��������Ѻ�����໭ */
/* Modify by : Ranu I. A62-0082 date : 11/02/2019 ������ͧ Agent */
/* Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
             : Change Host => TMSth */
/* Modify by : Ranu I. A63-0164 ��� pack T ��Чҹ��������� Pack ������������� */
/* Modify by : Kridtiya i. A63-0419 ���� ����� susspect                        */
/*Modify by  : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by  : Ranu I. A64-0138 ����������纤�ҡ�äӹǳ���� */
/*Modify by  : Kridtiya i. A65-0035 comment message error premium not on file */
/*MOdify by  : Kritapoj S. A65-0372 Date 16/01/2023 ������ͧcolor ���㹪�ͧcolor �͡��������*/
/*---------------------------------------------------------------------*/
{wgw\wgwlicbc.i}      /*��С�ȵ����*/
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
DEF SHARED Var   n_User    As CHAR .                   
DEF SHARED Var   n_PassWd  As CHAR .   
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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.poltyp wdetail.policy wdetail.prepol wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.addr1 wdetail.addr2 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.engcc wdetail.tons wdetail.seat wdetail.body wdetail.vehreg wdetail.eng wdetail.chasno wdetail.caryear wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.volprem wdetail.fleet wdetail.deductpd wdetail.benname wdetail.n_IMPORT wdetail.n_export wdetail.drivnam wdetail.producer wdetail.agent wdetail.comment WDETAIL.WARNING wdetail.cancel wdetail.redbook /*add new*/ wdetail.colordes /*Add krittapoj S. A65-0372 Date 16/01/2023*/   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_wdetail FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_companoti fi_branch fi_bchno ~
fi_agent fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 ~
fi_output3 fi_usrcnt fi_usrprem buok bu_exit bu_hpbrn br_wdetail fi_process ~
fi_fileexp bu_EXp fi_pack RECT-370 RECT-373 RECT-376 RECT-379 RECT-380 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_companoti fi_branch fi_bchno ~
fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 ~
fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_process fi_fileexp ~
fi_completecnt fi_premtot fi_agentname fi_premsuc fi_pack 

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

DEFINE BUTTON bu_EXp 
     LABEL "EXP" 
     SIZE 6.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agentname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY .95
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
     SIZE 19 BY .95
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

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 21.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

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

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 6.38
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 2.71
     BGCOLOR 8 .

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
      wdetail.poltyp  COLUMN-LABEL "Policy Type"
        wdetail.policy  COLUMN-LABEL "Policy"
        wdetail.prepol  COLUMN-LABEL "Renew Policy"
        wdetail.tiname  COLUMN-LABEL "Title Name"   
        wdetail.insnam  COLUMN-LABEL "Insured Name" 
        wdetail.comdat  COLUMN-LABEL "Comm Date"
        wdetail.expdat  COLUMN-LABEL "Expiry Date"
        wdetail.compul  COLUMN-LABEL "Compulsory"

        wdetail.addr1   COLUMN-LABEL "Ins Add1"
        wdetail.addr2   COLUMN-LABEL "Ins Add2"
        wdetail.prempa  COLUMN-LABEL "Premium Package"
        wdetail.subclass COLUMN-LABEL "Sub Class"
        wdetail.brand   COLUMN-LABEL "Brand"
        wdetail.model   COLUMN-LABEL "Model"
        wdetail.engcc      COLUMN-LABEL "CC"
        wdetail.tons  COLUMN-LABEL "Weight"
        wdetail.seat    COLUMN-LABEL "Seat"
        wdetail.body    COLUMN-LABEL "Body"
        wdetail.vehreg  COLUMN-LABEL "Vehicle Register"
        wdetail.eng    COLUMN-LABEL "Engine NO."
        wdetail.chasno  COLUMN-LABEL "Chassis NO."
        wdetail.caryear COLUMN-LABEL "Car Year" 
        wdetail.vehuse  COLUMN-LABEL "Vehicle Use" 
        wdetail.garage  COLUMN-LABEL "Garage"
        wdetail.stk     COLUMN-LABEL "Sticker"
        wdetail.covcod  COLUMN-LABEL "Cover Type"
        wdetail.si      COLUMN-LABEL "Sum Insure"
        wdetail.volprem COLUMN-LABEL "Voluntory Prem"
        wdetail.fleet   COLUMN-LABEL "Fleet"
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
        wdetail.colordes COLUMN-LABEL "Color"  /*Add krittapoj S. A65-0372 Date 16/01/2023*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 5.81
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .71.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 2.95 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_companoti AT ROW 2.95 COL 59.83 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 2.91 COL 86.33 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 20.95 COL 13.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agent AT ROW 4.05 COL 27.5 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_prevbat AT ROW 5.14 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 5.14 COL 59.5 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 7.19 COL 27.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 7.19 COL 90.17
     fi_output1 AT ROW 8.19 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 9.19 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 10.24 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 12.38 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 12.43 COL 68 NO-LABEL
     buok AT ROW 7.52 COL 100
     bu_exit AT ROW 9.43 COL 100.17
     fi_brndes AT ROW 2.91 COL 96.5 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 2.91 COL 94.33
     fi_impcnt AT ROW 20.38 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     br_wdetail AT ROW 13.91 COL 2.5
     fi_process AT ROW 11.33 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_fileexp AT ROW 6.19 COL 27.5 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     bu_EXp AT ROW 6 COL 76.5 WIDGET-ID 8
     fi_completecnt AT ROW 21.38 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 20.38 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_agentname AT ROW 4 COL 43.33 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     fi_premsuc AT ROW 21.38 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_pack AT ROW 3.95 COL 94 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     "      Branch :" VIEW-AS TEXT
          SIZE 13.33 BY .95 AT ROW 2.91 COL 74.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "CompanyNotify :" VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 2.95 COL 45.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 2.95 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 12.43 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 12.38 COL 86.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 12.38 COL 43.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Previous Batch No.  :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 5.14 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Format File Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 6.14 COL 6 WIDGET-ID 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 21.38 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY .95 AT ROW 20.38 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY .95 AT ROW 21.38 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 10.29 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "PARAMETER PACK :" VIEW-AS TEXT
          SIZE 20.5 BY .95 AT ROW 3.95 COL 75.33 WIDGET-ID 26
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 22.05
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "     Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 8.19 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 20.38 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 20.95 COL 3.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 21.38 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Load Text File ICBC" VIEW-AS TEXT
          SIZE 128.5 BY .95 AT ROW 1.24 COL 2.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "TieS 4 01/03/2022":60 VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 12.38 COL 99.33 WIDGET-ID 28
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "              Agent code :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 4.05 COL 6 WIDGET-ID 22
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 7.19 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 20.38 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 9.24 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 5.14 COL 48
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-373 AT ROW 13.62 COL 1.5
     RECT-376 AT ROW 20.05 COL 1
     RECT-379 AT ROW 7.19 COL 98.5
     RECT-380 AT ROW 9 COL 98.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 22.05
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
         TITLE              = "Load Text file ICBC"
         HEIGHT             = 21.86
         WIDTH              = 132.83
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
/* BROWSE-TAB br_wdetail fi_impcnt fr_main */
ASSIGN 
       br_wdetail:COLUMN-RESIZABLE IN FRAME fr_main       = TRUE.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agentname IN FRAME fr_main
   NO-ENABLE                                                            */
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
          SIZE 21.5 BY .95 AT ROW 20.38 COL 95.83 RIGHT-ALIGNED         */

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
ON END-ERROR OF c-Win /* Load Text file ICBC */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text file ICBC */
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

          wdetail.poltyp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.prepol:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.tiname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.insnam:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.comdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.expdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.compul:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  

          wdetail.addr1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.addr2:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.prempa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.subclass:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.brand:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.model:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.engcc:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
          wdetail.tons:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.seat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.body:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.vehreg:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.eng:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.chasno:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.caryear:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.vehuse:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.garage:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.stk:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.covcod:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.si:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
          wdetail.volprem:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.fleet:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.     
          wdetail.deductpd:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.benname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.n_IMPORT:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_export:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.producer:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.agent:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.comment:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          WDETAIL.CANCEL:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.redbook:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. /*new add*/ 
          wdetail.colordes:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. /*Add by Krittapoj S. A65-0372 Date 16/01/2023*/


          /*wdetail.entdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.enttim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trandat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trantim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. *//*a490166*/ 
          wdetail.poltyp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.prepol:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.tiname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.insnam:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.expdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.    
          wdetail.compul:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  

          wdetail.prempa:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.subclass:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.brand:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.model:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.engcc:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.tons:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.seat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.body:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehreg:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.eng:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.chasno:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.caryear:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehuse:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.garage:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.stk:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.covcod:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.si:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.volprem:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.fleet:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
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
          wdetail.colordes:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  /*Add by Krittapoj S. A65-0372 16/01/2023*/
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
        fi_process             = "Strat Load text ICBC   ".
    DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
    IF fi_branch = " " THEN DO: 
        MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_branch.
        RETURN NO-APPLY.
    END.
    /* A62-0082 */
    /*IF fi_producer = " " THEN DO:
        MESSAGE "Producer code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_producer.
        RETURN NO-APPLY.
    END.*/
    IF fi_agent = " " THEN DO:
        MESSAGE "Agent code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_Agent.
        RETURN NO-APPLY.
    END.
     /* end A62-0082 */
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
            uzm700.acno    = "A0M0079"           AND
            uzm700.branch  = TRIM(nv_batbrn)     NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:   
            ASSIGN nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102     WHERE 
                uzm701.bchyr   = nv_batchyr         AND
                uzm701.bchno   = "A0M0079" + TRIM(nv_batbrn) + string(nv_batrunno,"9999")  NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN  
                ASSIGN 
                nv_batcnt   = uzm701.bchcnt 
                nv_batrunno = nv_batrunno + 1.
        END.
        ELSE  
            ASSIGN nv_batcnt = 1
                nv_batrunno  = 1.
        ASSIGN nv_batchno = CAPS("A0M0079") + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
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
        /*fi_producer_n = INPUT fi_producer_n  fi_agent        = INPUT fi_agent */
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
                           INPUT            "A0M0079"  ,     /* CHAR  */ 
                           INPUT            nv_batbrn  ,     /* CHAR  */
                           INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                           INPUT            "WGWticbc" ,     /* CHAR  */
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


&Scoped-define SELF-NAME bu_EXp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_EXp c-Win
ON CHOOSE OF bu_EXp IN FRAME fr_main /* EXP */
DO:
    IF fi_fileexp = "" THEN DO:
        MESSAGE "File Output not Null !!" VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_fileexp.
        RETURN NO-APPLY.
    END.
    IF INDEX(fi_fileexp,".") = 0 THEN fi_fileexp = fi_fileexp + ".CSV".
    ELSE fi_fileexp = SUBSTR(fi_fileexp,1,INDEX(fi_fileexp,".")) + ".CSV".
    OUTPUT STREAM ns1 TO value(fi_fileexp).
    PUT STREAM ns1
        "RecordType      " "|"
        "contno          " "|" 
        "id              " "|" 
        "insquotationno  " "|" 
        "prepol          " "|"  
        "policy70        " "|"  
        "policy72        " "|"  
        "Bookingdate     " "|"  
        "notifydate      " "|"  
        "inscmp          " "|"  
        "instyp          " "|"  
        "covtyp          " "|"  
        "inslictyp       " "|"  
        "insyearno       " "|"  
        "covamt          " "|"  
        "covamttheft     " "|"  
        "gropremamt      " "|"  
        "netpremamt      " "|"  
        "whtaxamtins     " "|"  
        "gropremduty     " "|"  
        "effdate         " "|"  
        "expiredate      " "|"  
        "accpolicy       " "|"  
        "acccovamt       " "|"  
        "accnetpremamt   " "|"  
        "accgropremamt   " "|"  
        "accwhtaxamt     " "|"  
        "accgropremduty  " "|"  
        "acceffdate      " "|"  
        "accexpiredate   " "|"  
        "dscfleetamt     " "|"  
        "dscexpr         " "|"  
        "dscdeductdeble  " "|"  
        "Chassino        " "|"  
        "EngineNo        " "|"  
        "Caryear         " "|"  
        "RegisProv       " "|"  
        "LicenceNo       " "|"  
        "CC              " "|"  
        "Brand           " "|"  
        "Model           " "|"  
        "Title           " "|"  
        "Cname           " "|"  
        "CSname          " "|"  
        "birdthday       " "|"  
        "occup           " "|"  
        "upddte          " "|"  
        "updby           " "|"  
        "batchno         " "|"   
        "remark          " "|"   
        "notifyby        " "|"   
        "OverAmount      " "|"   
        "Assured         " "|"   
        "Trandte         " "|"   
        "Claim           " "|"   
        "Drivers1        " "|"   
        "id_Driver1      " "|"   
        "BirthdayDriver1 " "|"
        "LicenceNoDriver1" "|"
        "Drivers2        " "|" 
        "id_Driver2      " "|" 
        "BirthdayDriver2 " "|" 
        "LicenceNoDriver2" "|" 
        "Name_policy     " "|" 
        "Address_policy  " "|" 
        "Name_send       " "|" 
        "Address_send    " "|" 
        "CampaignCode    " "|" 
        "Dealer _Sub     " "|" 
        "covinjperson    " "|" 
        "covinjacc       " "|" 
        "covdamacc       " "|" 
        "covaccperson    " "|" 
        "covmedexpen     " "|" 
        "covbailbond     " "|" 
        "Memo..txt       " "|" 
        "Class70         " "|" 
        "Producer        " "|" 
        "Agent           " "|" 
        "Vat Code        " "|" 
        "Branch          " "|" 
        "Garage          " "|" 
        "campaing        " "|" 
        "Status          " "|"
        "Color           " SKIP.  /*Add by Krittapoj S. A65-0372 Date 16/01/2023*/

    OUTPUT STREAM ns1 CLOSE.                                                       
    
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


&Scoped-define SELF-NAME bu_hpbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn c-Win
ON CHOOSE OF bu_hpbrn IN FRAME fr_main
DO:
    Run  whp\whpbrn01(Input-output  fi_branch,    /*a490166 note modi*/
                      Input-output  fi_brndes).
    Disp  fi_branch  fi_brndes  with frame  fr_main.                                     
    Apply "Entry"  To  bu_file.
    Return no-apply.               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent c-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    IF  Input fi_agent  =  ""  Then do:
        Message "��س��к� Agent code ." View-as alert-box.
        Apply "Entry"  To  fi_agent.
    END.
    Else do:
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_agent 
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_agent.
            RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO:
            ASSIGN
                fi_agentname =  TRIM(sicsyac.xmm600.name)
                fi_agent     =  trim(caps(INPUT fi_agent)). 
        END.
    END.  /*else do:*/
    Disp fi_agent  fi_agentname  With Frame  fr_main.
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
        Message "��س��к� Branch Code ." View-as alert-box.
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


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack c-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
    fi_pack = INPUT fi_pack .
    Disp  fi_pack  WITH Frame  fr_main. 
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
  
  gv_prgid = "Wgwlicbc".
  gv_prog  = "Load Text & Generate ICBCTL".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
      fi_pack       = "PACK RENEW"
      /*fi_pack2      = "Y"
      fi_pack3      = "R"
      fi_pack5      = "B"
      fi_pack_01    = "G"  
      fi_pack_02    = "Z"  
      fi_pack_03    = "R"  
      fi_pack_05    = "B"  */
      /*fi_base1       = 8000
      fi_base2       = 4500
      fi_uom1_v      =   500000
      fi_uom2_v      = 10000000
      fi_uom5_v      =  1000000
      fi_41          =   50000
      fi_42          =   0
      fi_43          =   200000*/
      fi_companoti   = "ICBCTL"
      fi_branch      = "M"
      fi_agent       = ""   /*A62-0082 */
      /*fi_updby       = "0892"*/
      fi_bchyr       = YEAR(TODAY) 
      fi_process     = "Load Text file ICBC....  ".
  DISP fi_process fi_pack   fi_companoti
      /*fi_pack2   fi_pack3   fi_pack5   fi_pack_01 fi_pack_02 fi_pack_03 fi_pack_05 */
      /*fi_rectyp1 fi_rectyp2*/
      /* fi_base1 fi_base2 fi_uom1_v fi_rectyp1 fi_rectyp2 fi_producernew
       fi_uom2_v fi_uom5_v fi_41 fi_42 fi_43  fi_producer2*/
       fi_branch /*fi_producer_r*/ 
        fi_agent fi_bchyr  WITH FRAME fr_main.
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
  DISPLAY fi_loaddat fi_companoti fi_branch fi_bchno fi_agent fi_prevbat 
          fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt 
          fi_usrprem fi_brndes fi_impcnt fi_process fi_fileexp fi_completecnt 
          fi_premtot fi_agentname fi_premsuc fi_pack 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE fi_loaddat fi_companoti fi_branch fi_bchno fi_agent fi_prevbat 
         fi_bchyr fi_filename bu_file fi_output1 fi_output2 fi_output3 
         fi_usrcnt fi_usrprem buok bu_exit bu_hpbrn br_wdetail fi_process 
         fi_fileexp bu_EXp fi_pack RECT-370 RECT-373 RECT-376 RECT-379 RECT-380 
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
        ASSIGN wdetail.comment = wdetail.comment + "| poltyp �� v72 Compulsory ��ͧ�� y" 
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N". 
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
            ASSIGN  wdetail.comment = wdetail.comment + "| �Ţ Sticker ��ͧ�� 11 ���� 13 ��ѡ��ҹ��"
            wdetail.pass    = ""
            wdetail.OK_GEN  = "N".
    END.
END.
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class = wdetail.subclass  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ��辺 Class �����к�"
    wdetail.pass    = "N"
    wdetail.OK_GEN  = "N".
/*------------- poltyp ------------*/
IF wdetail.poltyp <> "v72" THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101      WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp   AND
        sicsyac.xmd031.class  = wdetail.subclass NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN  wdetail.pass = "N"
        wdetail.comment      = wdetail.comment + "| ��辺 Class ����繢ͧ Policy Type ���"
        wdetail.OK_GEN       = "N".
END.
/*---------- covcod ----------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod  = "U013"         AND
    sicsyac.sym100.itmcod  = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| ��辺 Cover Type �����к�"
    wdetail.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  wdetail.pass = "N"  
    wdetail.comment      = wdetail.comment + "| ��辺 Tariff or Compulsory or Class or Cover Type ��к�"
    wdetail.OK_GEN       = "N".
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
    n_sclass72 = substr(wdetail.subclass,1,3).
/*RUN proc_model_brand.*/
/*        1.10   = 110
          1.20A  = 210
          1.40A  = 320 */
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
ASSIGN n_model = "" .
    IF INDEX(wdetail.model," ") <> 0 THEN /*a63-0164 */
        n_model    = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ")).
    ELSE n_model = TRIM(wdetail.model) . /*A63-0164 */
    
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
    /*RUN proc_model_brand.*/
    RUN proc_maktab.
END.
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ��辺 Veh.Usage ��к� "
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
         sic_bran.uwm301.cha_no     = wdetail.chasno
         sic_bran.uwm301.eng_no     = wdetail.eng
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
         sic_bran.uwm301.moddes     = wdetail.brand + " " + wdetail.model     
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
         IF wdetail.redbook <> "" THEN DO:     /*�óշ���ա���к� Code ö��*/
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
             MESSAGE "�����ѧ��ҹ Insured (UWD132)" wdetail.policy
                 "�������ö Generage ��������".
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
            ELSE  MESSAGE "��辺 Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
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
                ELSE   MESSAGE "��辺 Tariff �����к� ��س���� Tariff ����" 
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
            MESSAGE "��辺 Class " wdetail.subclass " � Tariff  " wdetail.tariff  skip
                "��س���� Class ���� Tariff �����ա����" VIEW-AS ALERT-BOX.
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
    For each  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|" 
            ns_rectype          /*RecordType      */         
            ns_contno           /*contno          */   
            ns_id               /*id              */   
            ns_insqno           /*insquotationno  */   
            ns_prepol           /*prepol          */   
            ns_policy           /*policy70        */  
            ns_policy72         /*policy72        */  
            ns_bkdate           /*Bookingdate     */   
            ns_notidate         /*notifydate      */   
            ns_inscmp           /*inscmp          */   
            ns_instyp           /*instyp          */          
            ns_covtyp           /*covtyp          */   
            ns_inslictyp        /*inslictyp       */     
            ns_insyearno        /*insyearno       */   
            ns_covamt           /*covamt          */   
            ns_covamtthf        /*covamttheft     */   
            ns_netamt           /*gropremamt      */   
            ns_groamt           /*netpremamt      */   
            ns_taxamtins        /*whtaxamtins     */   
            ns_gropduty         /*gropremduty     */   
            ns_effdate          /*effdate         */   
            ns_expdate          /*expiredate      */   
            ns_accpolicy        /*accpolicy       */   
            ns_acccovamt        /*acccovamt       */   
            ns_accnpmamt        /*accnetpremamt   */   
            ns_accgpmamt        /*accgropremamt   */   
            ns_acctaxamt        /*accwhtaxamt     */   
            ns_accgpduty        /*accgropremduty  */   
            ns_acceffdat        /*acceffdate      */   
            ns_accexpdat        /*accexpiredate   */   
            ns_dscfamt          /*dscfleetamt     */   
            ns_dscexpr          /*dscexpr         */   
            ns_dscdeduc         /*dscdeductdeble  */   
            ns_chassno          /*Chassino        */   
            ns_enginno          /*EngineNo        */   
            ns_caryear          /*Caryear         */   
            ns_regisprov        /*RegisProv       */   
            ns_licenno          /*LicenceNo       */   
            ns_cc               /*CC              */   
            ns_brand            /*Brand           */   
            ns_model            /*Model           */   
            ns_titlen           /*Title           */   
            ns_cname            /*Cname           */   
            ns_csname           /*CSname          */   
            ns_birthday         /*birdthday       */   
            ns_occuration       /*occup           */   
            ns_upddte           /*upddte          */   
            ns_updby            /*updby           */   
            ns_batchno          /*batchno         */   
            ns_remark           /*remark          */   
            ns_notfyby          /*notifyby        */   
            ns_overamt          /*OverAmount      */   
            ns_assured          /*Assured         */   
            ns_trandte          /*Trandte         */   
            ns_claim            /*Claim           */   
            ns_drivers1         /*Drivers1        */   
            ns_id_driv1         /*id_Driver1      */   
            ns_bdaydr1          /*BirthdayDriver1 */   
            ns_licnodr1         /*LicenceNoDriver1*/   
            ns_drivers2         /*Drivers2        */   
            ns_id_driv2         /*id_Driver2      */   
            ns_bdaydr2          /*BirthdayDriver2 */   
            ns_licnodr2         /*LicenceNoDriver2*/   
            ns_namepol          /*Name_policy     */   
            ns_addpol           /*Address_policy  */   
            ns_namsend          /*Name_send       */   
            ns_addsend          /*Address_send    */   
            ns_cpcode           /*CampaignCode    */   
            ns_dealsub          /*Dealer _Sub     */   
            ns_covpes           /*covinjperson    */   
            ns_covacc           /*covinjacc       */   
            ns_covdacc          /*covdamacc       */   
            ns_covaccp          /*covaccperson    */   
            ns_covmdp           /*covmedexpen     */               
            ns_covbllb          /*covbailbond     */  
            ns_memmo            /*Memo..txt       */  
            ns_class70          /*Class70         */  
            ns_producer         /*Producer        */  
            ns_agent            /*Agent           */  
            ns_vatcode          /*Vat Code        */  
            ns_bran             /*Branch          */  
            ns_garage           /*Garage          */  
            ns_campaign         /*campaing        */ /*A60-0263*/
            ns_status           /*Status          */  
            ns_colordes.        /*Color           */ /*Add by Krittapoj S. A65-0372 16/01/2023*/

        IF index(ns_rectype,"Record") = 0  THEN DO:
            IF ns_rectype <> ""  THEN DO:
                IF trim(ns_titlen) = "" THEN DO:
                    FIND FIRST brstat.msgcode USE-INDEX MsgCode01 WHERE
                        index(ns_namepol,brstat.msgcode.MsgDesc) <> 0  NO-LOCK NO-WAIT NO-ERROR.
                    IF AVAIL brstat.msgcode  THEN 
                        ASSIGN ns_titlen = brstat.msgcode.branch.
                    ELSE ns_titlen = "�س".
                END.
                ELSE DO:
                    FIND FIRST brstat.msgcode USE-INDEX MsgCode01  WHERE
                        brstat.msgcode.MsgDesc = trim(ns_titlen)   NO-LOCK NO-WAIT NO-ERROR.
                    IF AVAIL brstat.msgcode  THEN 
                        ASSIGN ns_titlen = brstat.msgcode.branch.
                END.
                ASSIGN fi_process  = "Create data ICBC  to workfile ... ".
                DISP fi_process WITH FRAM fr_main.
                /*IF trim(ns_assured) <> "" THEN DO:
                    FIND FIRST stat.company USE-INDEX Company01 WHERE  /*use-index fname */
                        stat.company.CompNo = trim(ns_assured)   /*AND 
                        stat.insure.FName  = TRIM(wdetail.re_country)*/ NO-LOCK NO-WAIT NO-ERROR.
                    IF AVAIL   stat.company  THEN 
                        ASSIGN ns_assured  = trim(stat.company.NAME) .
                    ELSE ASSIGN ns_assured  = "".
                END.*/
                IF trim(ns_effdate)   <> "" THEN RUN proc_assignwdetail .     /*A56-0071*/
                IF TRIM(ns_acceffdat) <> "" THEN RUN proc_assignwdetail72 .   /*A56-0071*/
                RUN proc_assign_init. /*A60-0232 */
            END.
        END.
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

    RUN proc_cutchar .    /*��Ѻ�ٻẺ class ������ 1.1 = 110 */
    /*1.1    = 110 , 1.10   = 110     ,1.20A  = 210     , 1.40A  = 320 */ 
   /* IF wdetail.producer = fi_producer_c THEN DO:
        IF      wdetail.covcod = "1"  THEN wdetail.prempa = fi_pack.
        ELSE IF wdetail.covcod = "2"  THEN wdetail.prempa = fi_pack2.
        ELSE IF wdetail.covcod = "3"  THEN wdetail.prempa = fi_pack3.
        ELSE wdetail.prempa = fi_pack5.
    END.
    ELSE DO:
        IF      wdetail.covcod = "1"  THEN wdetail.prempa = fi_pack_01.
        ELSE IF wdetail.covcod = "2"  THEN wdetail.prempa = fi_pack_02.
        ELSE IF wdetail.covcod = "3"  THEN wdetail.prempa = fi_pack_03.
        ELSE wdetail.prempa = fi_pack_05.
    END.*/
    IF wdetail.poltyp = "v72" THEN DO:
        IF substr(wdetail.subclass,1,3)  = "110"   THEN  wdetail.seat = "7" .
        ELSE IF substr(wdetail.subclass,1,3)  = "120"  THEN DO: 
            ASSIGN  wdetail.seat = "12".
            /*IF wdetail.poltyp = "v70" THEN wdetail.subclass  = "210".*/
        END.
        ELSE IF substr(wdetail.subclass,1,3)  = "140"   THEN DO: 
            IF wdetail.producer = "A0M0080"  AND wdetail.brand = "ISUZU" THEN ASSIGN  wdetail.seat = "5".
            ELSE ASSIGN  wdetail.seat = "3".
            /*IF wdetail.poltyp = "V70" THEN wdetail.subclass  = "320".*/
        END.
        ELSE wdetail.seat = "7".
    END.
    ELSE DO:
        IF substr(wdetail.subclass,1,3)  = "110"   THEN  wdetail.seat = "7" .
        ELSE IF substr(wdetail.subclass,1,3)  = "220"  THEN ASSIGN  wdetail.seat = "15".
        ELSE IF substr(wdetail.subclass,1,3)  = "610"  THEN ASSIGN  wdetail.seat = "2".
        ELSE IF substr(wdetail.subclass,1,3)  = "210"  THEN DO: 
            IF wdetail.producer = "A0M0080"  AND wdetail.brand = "ISUZU" THEN ASSIGN  wdetail.seat = "5".
            ELSE ASSIGN  wdetail.seat = "12".
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
        ELSE wdetail.vehreg = TRIM(wdetail.vehreg).
    END.
    
    /*FIND FIRST brstat.msgcode WHERE    /*title name....*/
        brstat.msgcode.compno = "999" AND
        brstat.msgcode.MsgDesc = wdetail.tiname   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN 
        ASSIGN wdetail.tiname = brstat.msgcode.'.
    /*IF wdetail.tiname = "�س" THEN 
        ASSIGN
        wdetail.addr1   = "503/27 �Ҥ���.���.���.��������"
        wdetail.tambon  = "��� 16 ��������ظ�� �ǧ�������"
        wdetail.amper   = "ࢵ�Ҫ��� ��ا෾� 10400" 
        wdetail.country = "".
    ELSE DO: */*/
    /*ASSIGN n_char =  wdetail.addr1.
    IF INDEX(n_char,"�.") <> 0 THEN 
        ASSIGN  
        ind1   = INDEX(n_char,"�.")
        ind2   = INDEX(n_char,"�.")
        ind3   = INDEX(n_char,"�.") .
    ELSE IF INDEX(n_char,"�Ӻ�") <> 0 THEN 
        ASSIGN  
        ind1   = INDEX(n_char,"�Ӻ�")
        ind2   = INDEX(n_char,"�����")
        ind3   = INDEX(n_char,"�ѧ��Ѵ") .
    ELSE IF  INDEX(n_char,"�ǧ") <> 0 THEN DO:
        ASSIGN 
            ind1   = INDEX(n_char,"�ǧ")
            ind2   = INDEX(n_char,"ࢵ").
        IF INDEX(n_char,"��ا") <> 0 THEN ind3   = INDEX(n_char,"��ا").
        ELSE  ind3   = INDEX(n_char,"���").
    END.
    IF ind1 > 0 THEN DO:
        ASSIGN 
            wdetail.addr4 = substr(n_char,ind3)
            n_char        = substr(n_char,1,ind3 - 1 )
            wdetail.addr3 = substr(n_char,ind2) 
            n_char        = substr(n_char,1,( ind2 - 1)) 
            wdetail.addr2 = substr(n_char,ind1) 
            wdetail.addr1 = substr(n_char,1,( ind1 - 1)) . */

       /* IF LENGTH(wdetail.addr1) > 35 THEN DO:  
            IF INDEX(wdetail.addr1,"���") <> 0 THEN
                ASSIGN ind4     =  INDEX(wdetail.addr1,"���") 
                wdetail.addr2   =  substr(wdetail.addr1,ind4)  + " " + wdetail.addr2
                wdetail.addr1   =  substr(n_char,1,( ind4 - 1)) .
            IF LENGTH(wdetail.addr1) > 35 THEN DO:
                ASSIGN wdetail.addr2  =  substr(wdetail.addr1,36)  + wdetail.addr2
                    wdetail.addr1 = substr(wdetail.addr1,1,35)
                    wdetail.addr2  =  substr(wdetail.addr1,R-INDEX(wdetail.addr1," ") + 1) +  wdetail.addr2
                    wdetail.addr1 = substr(wdetail.addr1,1,R-INDEX(wdetail.addr1," "))  .
            END.
        END.*/

        IF index(wdetail.addr1,wdetail.postcd) <> 0  THEN wdetail.addr1 = trim(REPLACE(wdetail.addr1,wdetail.postcd,"")).  /*Add by Kridtiya i. A63-0472*/
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
        END.
        

    /*END.*/
   /* IF trim(wdetail.prepol) <> "" THEN DO:
        IF (SUBSTR(wdetail.prepol,1,1) > "0") AND (SUBSTR(wdetail.prepol,1,1) <= "9")  THEN
            wdetail.n_branch = SUBSTR(wdetail.prepol,1,2)  .  /* brach 2��ѡ  */
        ELSE wdetail.n_branch = SUBSTR(wdetail.prepol,2,1) .  /* brach 1 ��ѡ */
    END.
    ELSE DO:
        wdetail.n_branch = "M".
    END.*/

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
ELSE IF index(np_mail_country,"���")      <> 0 THEN np_mail_country = "��ا෾��ҹ��".

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew c-Win 
PROCEDURE proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR number_sic   AS INTE INIT 0.
DEF VAR nv_bens      AS CHAR INIT "".
DEF VAR nnr_producer AS CHAR FORMAT "x(10)" INIT "" . 
DEF VAR nnr_agent    AS CHAR FORMAT "x(10)" INIT "" . 
DEF VAR nnr_branch   AS CHAR FORMAT "x(2)"  INIT "" . 
DEF VAR nnr_vehreg   AS CHAR FORMAT "x(12)" INIT "" .
DEF VAR nre_premt    AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/

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
ASSIGN 
    nre_premt   = 0 
    nv_uom1_v   = 0
    nv_uom2_v   = 0                         
    nv_uom5_v   = 0                         
    nv_basere   = 0
    n_41        = 0                            
    n_42        = 0                           
    n_43        = 0                           
    nv_dedod    = 0                 
    nv_ded      = 0 
    nv_dss_per  = 0                  
    nv_stf_per  = 0                       
    nv_cl_per   = 0  
    nnr_branch    = ""                    
    nnr_producer  = ""                    
    nnr_agent     = ""                    
    nnr_branch    = wdetail.n_branch      
    nnr_producer  = wdetail.producer      
    nnr_agent     = wdetail.agent
    nnr_vehreg    = wdetail.vehuse.       
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwicbex (INPUT-OUTPUT  wdetail.prepol,                       
                      INPUT-OUTPUT  wdetail.n_branch,              
                      INPUT-OUTPUT  wdetail.producer,                
                      INPUT-OUTPUT  wdetail.agent,                  
                      INPUT-OUTPUT  wdetail.insref,             
                      INPUT-OUTPUT  np_tiname,  /*wdetail.tiname,  */           
                      INPUT-OUTPUT  np_insnam,  /*wdetail.insnam,  */          
                      INPUT-OUTPUT  np_name2 ,  /*wdetail.np_name2,*/            
                      INPUT-OUTPUT  np_name3 ,  /*wdetail.np_name3,*/       
                      INPUT-OUTPUT  np_addr1 ,  /*wdetail.addr1,   */         
                      INPUT-OUTPUT  np_addr2 ,  /*wdetail.addr2,   */                 
                      INPUT-OUTPUT  np_addr3 ,  /*wdetail.addr3,   */         
                      INPUT-OUTPUT  np_addr4 ,  /*wdetail.addr4,   */         
                      INPUT-OUTPUT  wdetail.firstdat,
                      INPUT-OUTPUT  wdetail.prempa,           
                      INPUT-OUTPUT  wdetail.subclass,         
                      INPUT-OUTPUT  wdetail.redbook,                   
                      INPUT-OUTPUT  wdetail.brand,                                     
                      INPUT-OUTPUT  wdetail.caryear,                                    
                      INPUT-OUTPUT  wdetail.cargrp, 
                      INPUT-OUTPUT  wdetail.body,                  
                      INPUT-OUTPUT  wdetail.engcc,                                
                      INPUT-OUTPUT  wdetail.tons,                                 
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
                      INPUT-OUTPUT  wdetail.si,               
                      INPUT-OUTPUT  nv_basere,                     
                      INPUT-OUTPUT  n_41,                          
                      INPUT-OUTPUT  n_42,                          
                      INPUT-OUTPUT  n_43,                          
                      INPUT-OUTPUT  wdetail.seat41,                     
                      INPUT-OUTPUT  nv_dedod,                    
                      INPUT-OUTPUT  nv_addod,                   
                      INPUT-OUTPUT  nv_dedpd,                   
                      INPUT-OUTPUT  wdetail.fleet,         
                      INPUT-OUTPUT  wdetail.NCB,              
                      INPUT-OUTPUT  nv_dss_per,             
                      INPUT-OUTPUT  nv_stf_per,            
                      INPUT-OUTPUT  nv_cl_per,            
                      INPUT-OUTPUT  nv_bens,
                      INPUT-OUTPUT  nre_premt). 
    ASSIGN 
        wdetail.premt =  string(nre_premt) 
        wdetail.tp1   =  string(nv_uom1_v) 
        wdetail.tp2   =  string(nv_uom2_v) 
        wdetail.tp3   =  string(nv_uom5_v) 
        wdetail.no_41 =  string(n_41)  
        wdetail.no_42 =  string(n_42)  
        wdetail.no_43 =  string(n_43)  
        wdetail.n_branch =  nnr_branch    
        wdetail.producer =  nnr_producer  
        wdetail.agent    =  nnr_agent
        wdetail.vehuse   =  IF nnr_vehreg <> "" THEN nnr_vehreg ELSE wdetail.vehuse
        wdetail.fire     =  wdetail.si 
        wdetail.model    =  "". 
     /* add by : A63-0164 */
    IF DATE(wdetail.comdat) >= 04/01/2020 THEN DO: 
        FIND FIRST brstat.insure USE-INDEX insure01 WHERE 
           trim(brstat.Insure.compno)  = TRIM(fi_pack)  AND 
           trim(brstat.insure.vatcode) = TRIM(wdetail.prempa)   NO-ERROR.
        IF AVAIL brstat.insure THEN ASSIGN wdetail.prempa =  trim(brstat.insure.Text3) .
    END.
   /* end A63-0164 */
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
FIND FIRST wdetail WHERE wdetail.policy  = "I70" + trim(ns_contno)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail  THEN DO:
    CREATE wdetail .
    ASSIGN 
        wdetail.policy     = "I70" + trim(ns_contno)
        wdetail.prepol     = IF LENGTH(trim(ns_prepol)) = 12 THEN trim(ns_prepol) ELSE ""
        wdetail.cr_2       = IF TRIM(ns_acceffdat) <> "" THEN "I72" + trim(ns_contno) ELSE ""
        wdetail.cedpol     = trim(ns_contno)
        wdetail.notify_no  = TRIM(ns_insqno)  
        wdetail.tiname     = trim(ns_titlen)          
        wdetail.insnam     = trim(ns_cname)  + " " + TRIM(ns_csname)
        /*wdetail.np_name2   = IF INDEX(ns_namepol,ns_cname) <> 0 THEN "" ELSE "���/���� " + TRIM(ns_namepol)*/ /*A60-0263*/
        wdetail.idno       = trim(ns_id)
        wdetail.occup      = TRIM(ns_occuration)
        wdetail.brand      = trim(ns_brand)   
        wdetail.model      = TRIM(ns_model)
        wdetail.engcc      = TRIM(ns_cc) 
        wdetail.tons       = inte(ns_cc) / 1000
        wdetail.caryear    = trim(ns_caryear)
        wdetail.eng        = trim(ns_enginno)               
        wdetail.chasno     = trim(ns_chassno)            
        wdetail.vehreg     = trim(ns_licenno)            
        wdetail.re_country = trim(ns_regisprov)
        wdetail.occup      = TRIM(ns_occuration)
        wdetail.subclass   = TRIM(ns_class70)
        wdetail.prempa     = SUBSTR(wdetail.subclass,1,1)
        wdetail.subclass   = SUBSTR(wdetail.subclass,2,3)
        wdetail.covcod     = IF trim(ns_covtyp) = "1" OR trim(ns_covtyp) = "01" THEN "1"
                             ELSE IF trim(ns_covtyp) = "2" OR trim(ns_covtyp) = "02"  THEN "2"
                             ELSE IF trim(ns_covtyp) = "3" OR trim(ns_covtyp) = "03"  THEN "3"
                             ELSE IF trim(ns_covtyp) = "9" OR trim(ns_covtyp) = "09"  THEN "5"
                             ELSE IF trim(ns_covtyp) = "10"  THEN "2.2"
                             ELSE IF trim(ns_covtyp) = "11"  THEN "3.2"
                             ELSE ""
        wdetail.poltyp     = "V70"
        wdetail.si         = trim(ns_covamt )      
        wdetail.fire       = trim(ns_covamtthf)  
        wdetail.premt      = trim(ns_netamt)
        wdetail.comdat     = substr(trim(ns_effdate),7,2) + "/" +
                             substr(trim(ns_effdate),5,2) + "/" +
                             substr(trim(ns_effdate),1,4) + "/"
        wdetail.firstdat   = substr(trim(ns_effdate),7,2) + "/" +
                             substr(trim(ns_effdate),5,2) + "/" +
                             substr(trim(ns_effdate),1,4) + "/"
        wdetail.expdat     = substr(trim(ns_expdate),7,2) + "/" +  
                             substr(trim(ns_expdate),5,2) + "/" +  
                             substr(trim(ns_expdate),1,4) + "/"    
        wdetail.namerequest = trim(ns_notfyby)         
        wdetail.daterequest = TRIM(ns_notidate)
        wdetail.notfyby     = TRIM(ns_updby) 
        wdetail.nocheck     = trim(ns_upddte) 
        wdetail.garage      = TRIM(ns_garage)  
        wdetail.vehuse      = "1"
        wdetail.stk         = ""
        wdetail.addr1       = trim(ns_addsend) 
        /* a60-0263*/       
        wdetail.fleet       = trim(ns_dscfamt)          /*dscfleetamt     */ 
        wdetail.ncb         = trim(ns_dscexpr)          /*dscexpr         */ 
        wdetail.deductpd    = trim(ns_dscdeduc)         /*dscdeductdeble  */ 
        wdetail.tp1         = trim(ns_covaccp)      /*covbailbond     */  
        wdetail.tp2         = trim(ns_covpes)       /*covaccperson    */   
        wdetail.tp3         = trim(ns_covbllb)      /*covinjperson    */     
        wdetail.no_41       = trim(ns_covacc)       /*covinjacc       */   
        wdetail.no_42       = trim(ns_covdacc)      /*covdamacc       */              
        wdetail.no_43       = trim(ns_covmdp)       /*covmedexpen     */  
        /* end A60-0263 */
        wdetail.benname    = IF INDEX(ns_assured,"�����") <> 0 THEN "" ELSE IF INDEX(ns_assured,"ICBC") <> 0 THEN "����ѷ��ʫ���ͫպի� (��) �ӡѴ" 
                             ELSE  trim(ns_assured)
        wdetail.txtmemo    = trim(ns_memmo)
        wdetail.txtmemo2   = TRIM(ns_remark)
        wdetail.tariff     = "X" 
        wdetail.compul     = "N"
        wdetail.comment    = ""
        wdetail.producer   = TRIM(ns_producer)    
       /* wdetail.agent      = trim(ns_agent)       */ /*A62-0082*/
        wdetail.agent      = IF trim(ns_agent) <> "" THEN TRIM(ns_agent) ELSE TRIM(fi_agent)           /*A62-0082*/  
        /*wdetail.vatcode    = TRIM(ns_vatcode)*/ /*A60-0263*/
        wdetail.n_branch   = TRIM(ns_bran)
        wdetail.drivnam    = IF trim(ns_drivers1) <> "" THEN "Y" ELSE "N"
        wdetail.Driv1      = trim(ns_drivers1) 
        wdetail.idDriv1    = trim(ns_id_driv1) 
        wdetail.BDriv1     = trim(ns_bdaydr1 ) 
        wdetail.LicenceNo1 = trim(ns_licnodr1) 
        wdetail.Driv2      = trim(ns_drivers2) 
        wdetail.idDriv2    = trim(ns_id_driv2) 
        wdetail.BDriv2     = trim(ns_bdaydr2 ) 
        wdetail.LicenceNo2 = trim(ns_licnodr2)
        wdetail.entdat     = string(TODAY)                /*entry date*/
        wdetail.enttim     = STRING(TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat    = STRING(fi_loaddat)          /*tran date*/
        wdetail.trantim    = STRING(TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT   = "IM"
        wdetail.n_EXPORT   = "" 
        wdetail.campaign   = TRIM(ns_campaign)      /*a60-0263*/
        wdetail.colordes   = TRIM(ns_colordes).     /*Add by Krittapoj S. A65-0372 16/01/2023 */

        IF index(wdetail.namerequest,"���") <> 0 THEN DO:
            ASSIGN wdetail.promo   = "ICBC " + IF index(wdetail.namerequest," ") <> 0 THEN SUBSTR(trim(wdetail.namerequest),4,index(wdetail.namerequest," ")) 
                                               ELSE SUBSTR(trim(wdetail.namerequest),4,LENGTH(wdetail.namerequest)).
        END.
        ELSE IF index(wdetail.namerequest,"�ҧ") <> 0 THEN DO:
            ASSIGN wdetail.promo   = "ICBC " + IF index(wdetail.namerequest," ") <> 0 THEN SUBSTR(trim(wdetail.namerequest),4,index(wdetail.namerequest," ")) 
                                               ELSE SUBSTR(trim(wdetail.namerequest),4,LENGTH(wdetail.namerequest)). 
        END.
        ELSE IF index(wdetail.namerequest,"�.�.") <> 0 THEN DO:
            ASSIGN wdetail.promo   = "ICBC " + IF index(wdetail.namerequest," ") <> 0 THEN SUBSTR(trim(wdetail.namerequest),5,index(wdetail.namerequest," ")) 
                                               ELSE SUBSTR(trim(wdetail.namerequest),5,LENGTH(wdetail.namerequest)).
        END.
        ELSE IF index(wdetail.namerequest,"�ҧ���") <> 0 THEN DO:
            ASSIGN wdetail.promo   = "ICBC " + IF index(wdetail.namerequest," ") <> 0 THEN SUBSTR(trim(wdetail.namerequest),7,index(wdetail.namerequest," ")) 
                                               ELSE SUBSTR(trim(wdetail.namerequest),7,LENGTH(wdetail.namerequest)).
        END.
        ELSE IF index(wdetail.namerequest,"�س") <> 0 THEN DO:
            ASSIGN wdetail.promo   = "ICBC " + IF index(wdetail.namerequest," ") <> 0 THEN SUBSTR(trim(wdetail.namerequest),4,index(wdetail.namerequest," ")) 
                                               ELSE SUBSTR(trim(wdetail.namerequest),4,LENGTH(wdetail.namerequest)).
        END.
        ELSE ASSIGN wdetail.promo = "ICBC " + trim(wdetail.namerequest).

        IF DATE(wdetail.comdat) >= 04/01/2020  THEN ASSIGN wdetail.prempa = "T" . /*A63-0164*/
        /*Add by krittapoj S. A65-0372 16/01/2023*/
        /* IF wdetail.colorcode <> "" THEN DO:                        
                RUN wgw\wgwfcolor.p (INPUT        TRIM(ns_colordes) ,    
                                    INPUT-OUTPUT wdetail.colorcode ).    
         END.     */     
         IF wdetail.colordes = "" THEN wdetail.colordes = "������".
        /*End by Krittapoj S. A65-0372 16/01/2023*/
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        RUN proc_matchtypins (INPUT  trim(ns_titlen)                            
                             ,INPUT  trim(ns_cname)  + " " + TRIM(ns_csname)    
                             ,OUTPUT wdetail.insnamtyp
                             ,OUTPUT wdetail.firstName
                             ,OUTPUT wdetail.lastName).
        RUN proc_assign2addr (INPUT  trim(ns_addsend)   
                             ,INPUT  ""
                             ,INPUT  ""
                             ,INPUT  trim(ns_occuration) 
                             ,OUTPUT nv_codeocc  
                             ,OUTPUT nv_codeaddr1
                             ,OUTPUT nv_codeaddr2
                             ,OUTPUT nv_codeaddr3).
        ASSIGN 
            wdetail.br_insured = "00000"
            wdetail.postcd    = nv_postcd 
            wdetail.codeocc   = nv_codeocc  
            wdetail.codeaddr1 = nv_codeaddr1
            wdetail.codeaddr2 = nv_codeaddr2
            wdetail.codeaddr3 = nv_codeaddr3.
        IF nv_postcd <> ""  THEN  wdetail.addr1 = REPLACE(trim(ns_addsend),nv_postcd,"").
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
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
FIND FIRST wdetail WHERE wdetail.policy  = "I72" + trim(ns_contno)   NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail  THEN DO:
    CREATE wdetail .
    ASSIGN 
        wdetail.policy     = "I72" + trim(ns_contno)
        wdetail.prepol     = ""
        wdetail.cr_2       = IF trim(ns_effdate) <> "" THEN "I70" + trim(ns_contno) ELSE ""
        wdetail.cedpol     = trim(ns_contno)
        wdetail.tiname     = trim(ns_titlen)          
        wdetail.insnam     = trim(ns_cname)  + " " + TRIM(ns_csname)
        /*wdetail.np_name2   = IF INDEX(ns_namepol,ns_cname) <> 0 THEN "" ELSE "���/���� " + TRIM(ns_namepol)*/ /*A60-0263*/
        wdetail.idno       = trim(ns_id)
        wdetail.occup      = TRIM(ns_occuration)
        wdetail.brand      = trim(ns_brand)   
        wdetail.model      = TRIM(ns_model)
        wdetail.engcc      = TRIM(ns_cc)   
        wdetail.caryear    = trim(ns_caryear)
        wdetail.eng        = trim(ns_enginno)               
        wdetail.chasno     = trim(ns_chassno)            
        wdetail.vehreg     = trim(ns_licenno)            
        wdetail.re_country = trim(ns_regisprov)
        wdetail.occup      = TRIM(ns_occuration)
        wdetail.subclass   = trim(REPLACE(ns_inslictyp,".",""))
        wdetail.covcod     = "T" 
        wdetail.poltyp     = "V72"
        wdetail.si         = trim(ns_covamt )      
        wdetail.fire       = trim(ns_covamtthf)  
        wdetail.premt      = trim(ns_netamt)
        wdetail.comdat     = substr(trim(ns_acceffdat),7,2) + "/" +     
                             substr(trim(ns_acceffdat),5,2) + "/" +    
                             substr(trim(ns_acceffdat),1,4) + "/"
        wdetail.firstdat   = substr(trim(ns_acceffdat),7,2) + "/" +
                             substr(trim(ns_acceffdat),5,2) + "/" +
                             substr(trim(ns_acceffdat),1,4) + "/"
        wdetail.expdat     = substr(trim(ns_accexpdat),7,2) + "/" +  
                             substr(trim(ns_accexpdat),5,2) + "/" +  
                             substr(trim(ns_accexpdat),1,4) + "/"    
        /*wdetail.namerequest  = trim(wdetail2.namerequest) 
        wdetail.daterequest  = trim(wdetail2.daterequest) 
        wdetail.nocheck      = trim(wdetail2.nocheck) */
        wdetail.garage     = ""  
        wdetail.vehuse     = "1"
        wdetail.stk        = trim(ns_accpolicy)
        wdetail.addr1      = trim(ns_addsend) 
        /*wdetail.benname    = "����ѷ ��ʫ���Թ����� �ӡѴ"  */ 
        wdetail.benname    = IF INDEX(ns_assured,"�����") <> 0 THEN "" ELSE IF INDEX(ns_assured,"ICBC") <> 0 THEN "����ѷ��ʫ���ͫպի� (��) �ӡѴ" 
                             ELSE trim(ns_assured)
        /*wdetail.txtmemo2   = TRIM(ns_notfyby)*/ 
        wdetail.tariff     = "9" 
        wdetail.compul     = "y"
        wdetail.comment    = ""
        /*wdetail.producer   = IF trim(ns_notfyby) = trim(fi_updby) THEN fi_producernew ELSE fi_producer    *//*A57-0125*/ 
         wdetail.producer   = TRIM(ns_producer)   
       /* wdetail.agent      = trim(ns_agent)       */ /*A62-0082*/
        wdetail.agent      = IF trim(ns_agent) <> "" THEN TRIM(ns_agent) ELSE TRIM(fi_agent)   /*A62-0082*/ 
        /*wdetail.vatcode    = TRIM(ns_vatcode)*/ /*A60-0263*/
        wdetail.n_branch   = TRIM(ns_bran)
        wdetail.notfyby    = trim(ns_notfyby)
        wdetail.entdat     = string(TODAY)                /*entry date*/
        wdetail.enttim     = STRING (TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat    = STRING (fi_loaddat)          /*tran date*/
        wdetail.trantim    = STRING (TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT   = "IM"
        wdetail.n_EXPORT   = "" 
        wdetail.occup     = trim(ns_occuration)
        wdetail.campaign  = TRIM(ns_campaign)            /*a60-0263*/
        wdetail.colordes  = TRIM(ns_colordes).           /*Add by Kirttapoj S. A65-0372 16/01/2023*/

        IF index(wdetail.namerequest,"���") <> 0 THEN DO:
            ASSIGN wdetail.promo   = "ICBC " + IF index(wdetail.namerequest," ") <> 0 THEN SUBSTR(trim(wdetail.namerequest),4,index(wdetail.namerequest," ")) 
                                               ELSE SUBSTR(trim(wdetail.namerequest),4,LENGTH(wdetail.namerequest)).
        END.
        ELSE IF index(wdetail.namerequest,"�ҧ") <> 0 THEN DO:
            ASSIGN wdetail.promo   = "ICBC " + IF index(wdetail.namerequest," ") <> 0 THEN SUBSTR(trim(wdetail.namerequest),4,index(wdetail.namerequest," ")) 
                                               ELSE SUBSTR(trim(wdetail.namerequest),4,LENGTH(wdetail.namerequest)). 
        END.
        ELSE IF index(wdetail.namerequest,"�.�.") <> 0 THEN DO:
            ASSIGN wdetail.promo   = "ICBC " + IF index(wdetail.namerequest," ") <> 0 THEN SUBSTR(trim(wdetail.namerequest),5,index(wdetail.namerequest," ")) 
                                               ELSE SUBSTR(trim(wdetail.namerequest),5,LENGTH(wdetail.namerequest)).
        END.
        ELSE IF index(wdetail.namerequest,"�ҧ���") <> 0 THEN DO:
            ASSIGN wdetail.promo   = "ICBC " + IF index(wdetail.namerequest," ") <> 0 THEN SUBSTR(trim(wdetail.namerequest),7,index(wdetail.namerequest," ")) 
                                               ELSE SUBSTR(trim(wdetail.namerequest),7,LENGTH(wdetail.namerequest)).
        END.
        ELSE IF index(wdetail.namerequest,"�س") <> 0 THEN DO:
            ASSIGN wdetail.promo   = "ICBC " + IF index(wdetail.namerequest," ") <> 0 THEN SUBSTR(trim(wdetail.namerequest),4,index(wdetail.namerequest," ")) 
                                               ELSE SUBSTR(trim(wdetail.namerequest),4,LENGTH(wdetail.namerequest)).
        END.
        ELSE ASSIGN wdetail.promo = "ICBC " + trim(wdetail.namerequest).
         /*Add by krittapoj S. A65-0372 16/01/2023*/    
         /*IF wdetail.colorcode <> "" THEN DO:                        
                RUN wgw\wgwfcolor.p (INPUT        TRIM(ns_colordes) ,    
                                    INPUT-OUTPUT wdetail.colorcode ).    
         END.    */    
        IF wdetail.colordes = "" THEN wdetail.colordes = "������".
        /*End by Krittapoj S. A65-0372  16/01/2023*/
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        RUN proc_matchtypins (INPUT  trim(ns_titlen)                            
                             ,INPUT  trim(ns_cname)  + " " + TRIM(ns_csname)    
                             ,OUTPUT wdetail.insnamtyp
                             ,OUTPUT wdetail.firstName
                             ,OUTPUT wdetail.lastName).
        RUN proc_assign2addr (INPUT  trim(ns_addsend)   
                             ,INPUT  ""
                             ,INPUT  ""
                             ,INPUT  trim(ns_occuration) 
                             ,OUTPUT nv_codeocc  
                             ,OUTPUT nv_codeaddr1
                             ,OUTPUT nv_codeaddr2
                             ,OUTPUT nv_codeaddr3).
        ASSIGN 
            wdetail.br_insured = "00000"
            wdetail.postcd    = nv_postcd 
            wdetail.codeocc   = nv_codeocc  
            wdetail.codeaddr1 = nv_codeaddr1
            wdetail.codeaddr2 = nv_codeaddr2
            wdetail.codeaddr3 = nv_codeaddr3.
        IF nv_postcd <> "" THEN wdetail.addr1 = replace(trim(ns_addsend),nv_postcd,""). 
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
END.
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
    ns_rectype      = ""    /*  1  RecordType    */      
    ns_contno       = ""    /*  2  contno        */      
    ns_id           = ""    /*  3  id            */      
    ns_insqno       = ""    /*  4  insquotationno*/      
    ns_bkdate       = ""    /*  5  Bookingdate   */      
    ns_notidate     = ""    /*  6  notifydate    */      
    ns_inscmp       = ""    /*  7  inscmp        */      
    ns_instyp       = ""    /*  8  instyp covcod @ premium*/ /**/              
    ns_covtyp       = ""    /*  9  covtyp        */      
    ns_inslictyp    = ""    /*  10 inslictyp class math..seat.*//**/      
    ns_insyearno    = ""    /*  11 insyearno     */ 
    ns_prepol       = "" 
    ns_policy       = ""    /*  12 policy        */
    ns_policy72     = "" 
    ns_covamt       = ""    /*  13 covamt        */      
    ns_covamtthf    = ""    /*  14 covamttheft   */      
    ns_netamt       = ""    /*  15 netpremamt    */      
    ns_groamt       = ""    /*  16 gropremamt    */      
    ns_taxamtins    = ""    /*  17 whtaxamtins   */      
    ns_gropduty     = ""    /*  18 gropremduty   */      
    ns_effdate      = ""    /*  19 effdate       */      
    ns_expdate      = ""    /*  20 expiredate    */      
    ns_policy72     = ""    
    ns_accpolicy    = ""    /*  21 accpolicy     */      
    ns_acccovamt    = ""    /*  22 acccovamt     */      
    ns_accnpmamt    = ""    /*  23 accnetpremamt */  
    ns_accgpmamt    = ""    /*  24 accgropremamt */      
    ns_acctaxamt    = ""    /*  25  accwhtaxamt  */      
    ns_accgpduty    = ""    /*  26  accgropremduty*/      
    ns_acceffdat    = ""    /*  27  acceffdate    */      
    ns_accexpdat    = ""    /*  28  accexpiredate */      
    ns_dscfamt      = ""    /*  29  dscfleetamt   */      
    ns_dscexpr      = ""    /*  30  dscexpr       */   
    ns_dscdeduc     = ""    /*  31  dscdeductdeble*/      
    ns_chassno      = ""    /*  32  Chassino      */      
    ns_enginno      = ""    /*  33  EngineNo      */  
    ns_caryear      = ""    /*  34  Caryear       */      
    ns_regisprov    = ""    /*  35  RegisProv     */
    ns_licenno      = ""    /*  38  LicenceNo     */          
    ns_cc           = ""    /*  41  Model       */          
    ns_brand        = ""    /*  42  Title       */          
    ns_model        = ""    /*  43  Cname       */          
    ns_titlen       = ""    /*  44  CSname      */ 
    ns_cname        = ""    /*  45  �ѹ�Դ�ͧ�����һ�Сѹ */          
    ns_csname       = ""   /*  46  �Ҫվ       */          
    ns_birthday     = ""   /*  45  upddte      */          
    ns_occuration   = ""   /*  46  updby       */          
    ns_upddte       = ""   /*  47  batchno     */          
    ns_updby        = ""   /*  48  remark      */          
    ns_batchno      = ""   /*  49  notifyby    */       
    ns_remark       = ""   /*  51  OverAmount      */   
    ns_notfyby      = ""   /*  52  Assured         */   
    ns_overamt      = ""   /*  53  Trandte         */   
    ns_assured      = ""   /*  54  Claim           */   
    ns_trandte      = ""   /*  55  Drivers1        */   
    ns_claim        = ""   /*  56  id_Driver1      */   
    ns_drivers1     = ""   /*  57  BirthdayDriver1 */  
    ns_id_driv1     = ""   /*  58  LicenceNoDriver1*/  
    ns_bdaydr1      = ""   /*  59  Drivers2        */  
    ns_licnodr1     = ""   /*  60  id_Driver2      */  
    ns_drivers2     = ""   /*  61  BirthdayDriver2 */  
    ns_id_driv2     = ""   /*  62  LicenceNoDriver2*/  
    ns_bdaydr2      = ""   /*  63  Name_policy     */  
    ns_licnodr2     = ""   /*  64  Address_policy  */  
    ns_namepol      = ""   /*  65  Name_send       */  
    ns_addpol       = ""   /*  66  Address_send    */  
    ns_namsend      = ""   /*  67  CampaignCode    */  
    ns_addsend      = ""   /*  68  Dealer _Sub     */  
    ns_cpcode       = ""   /*  69  covinjperson    */  
    ns_dealsub      = ""   /*  70  covinjacc       */  
    ns_covpes       = ""   /*  71  covdamacc       */  
    ns_covacc       = ""   /*  72  covaccperson    */  
    ns_covdacc      = ""   /*  73  covmedexpen     */  
    ns_covaccp      = ""                 
    ns_covmdp       = ""                  
    ns_covbllb      = "" 
    ns_memmo        = ""  
    ns_class70      = ""
    ns_producer     = ""
    ns_agent        = ""
    ns_vatcode      = ""
    ns_bran         = ""
    ns_garage       = ""
    ns_status       = "" 
    ns_campaign     = ""      /*a60-0263*/
    ns_campaignov   = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    nv_postcd       = ""
    nv_codeocc      = ""
    nv_codeaddr1    = ""
    nv_codeaddr2    = ""
    nv_codeaddr3    = ""
    ns_colordes     = "".    /*Add by Krittpoj S. A65-0372 Date 16/01/2023*/

    
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
    ASSIGN fi_process = "check data ICBC  to base premium ... ".
    DISP   fi_process WITH FRAM fr_main.
    IF wdetail.prepol <> "" THEN  aa = nv_basere.
    /*ELSE IF wdetail.covcod = "1" AND fi_base1 <> 0 THEN aa = fi_base1.
    ELSE IF wdetail.covcod = "2" AND fi_base2 <> 0 THEN aa = fi_base2.*/
    ELSE DO:
        IF nv_baseprm = 0 THEN RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ASSIGN chk = NO
        NO_basemsg = " "
        nv_baseprm = aa
        nv_drivvar1 = ""
        nv_drivvar2 = ""
        nv_drivvar1 = wdetail.Driv1.
        nv_drivvar2 = wdetail.Driv2.
        IF wdetail.drivnam = "N" THEN  nv_drivno = 0.
        ELSE DO:
            /*IF wdetail.Driv1 <> ""   THEN  wdetail.drivnam  = "y".
            ELSE wdetail.drivnam  = "N".*/
            IF wdetail.Driv2 <> ""   THEN  nv_drivno = 2. 
            ELSE IF wdetail.Driv1 <> "" AND wdetail.Driv2 = "" THEN  nv_drivno = 1.  
            ELSE IF wdetail.Driv1  = "" AND wdetail.Driv2 = "" THEN  nv_drivno = 0.   
        END.
        If wdetail.drivnam  = "N"  Then DO:
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
                ASSIGN wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
            END.
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
    IF wdetail.prepol <> "" THEN  ASSIGN  nv_41 = n_41  /*�������*/
                                          nv_42 = n_42
                                          nv_43 = n_43
                                          nv_seat41 =  wdetail.seat41 .
    ELSE IF wdetail.prempa = "Z" THEN
        ASSIGN 
       /* comment by : A60-0263
        nv_41 = 50000     /*deci(wdetail.no_41)*/ 
        nv_42 = 0         /*deci(wdetail.no_42)*/
        nv_43 = 200000    /*deci(wdetail.no_43)*/
        ..end A60-0263....*/
        nv_41 =deci(wdetail.no_41)  /*A60-0263*/
        nv_42 =deci(wdetail.no_42)  /*A60-0263*/
        nv_43 =deci(wdetail.no_43)  /*A60-0263*/
        /*nv_seat41 =  7*/   .     /*integer(wdetail.seat41)*/ 
    IF wdetail.model = "commuter" THEN 
        ASSIGN wdetail.seat = "16"
        nv_seats  =  16
        nv_seat41 =  16.
    /* comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                          nv_class,
                          nv_key_b,
                          nv_comdat).*/ 
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
    ASSIGN nv_42cod   = "42".
        nv_42var1  = "     Medical Expense = ".
        nv_42var2  = STRING(nv_42).
        SUBSTRING(nv_42var,1,30)   = nv_42var1.
        SUBSTRING(nv_42var,31,30)  = nv_42var2.
    nv_43var    = " ".     /*---------fi_43--------*/
    ASSIGN 
        nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    /* comment by : A64-0138..
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
   IF deci(wdetail.si) = 0 THEN wdetail.si = wdetail.fire .
   Assign  nv_sivar = ""
       nv_totsi     = 0
       nv_sicod     = "SI"
       nv_sivar1    = "     Own Damage = "
       nv_sivar2    =  wdetail.si 
       SUBSTRING(nv_sivar,1,30)  = nv_sivar1
       SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
       nv_totsi     =  DECI(wdetail.si).
   /*----------nv_grpcod--------------------*/
   ASSIGN nv_grpvar   = ""
       nv_grpcod      = "GRP" + wdetail.cargrp
       nv_grpvar1     = "     Vehicle Group = "
       nv_grpvar2     = wdetail.cargrp
       Substr(nv_grpvar,1,30)  = nv_grpvar1
       Substr(nv_grpvar,31,30) = nv_grpvar2.
   /*-------------nv_bipcod--------------------*/
     ASSIGN nv_bipvar = ""
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(wdetail.tp1)
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign nv_biavar = ""
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(wdetail.tp2)
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN nv_pdavar = ""
         nv_pdacod    = "PD"
         nv_pdavar1   = "     PD per Accident = "
         /*nv_pdavar2 = STRING(uwm130.uom5_v)   a52-0172*/
         /*nv_pdavar2 = string(deci(WDETAIL.deductpd)) */  /*A52-0172*/ /*A60-0263*/
         nv_pdavar2   = STRING(wdetail.tp3)   /*a60-0263*/
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
     /* caculate deduct OD  */ 
     /* comment by : A64-0138..
     DEF VAR dod0 AS INTEGER.                                        
     DEF VAR dod1 AS INTEGER.                                        
     DEF VAR dod2 AS INTEGER.                                        
     DEF VAR dpd0 AS INTEGER. 
     ..end A64-0138...*/
     /*def  var  nv_chk  as  logic.*/
      /*dod0 = inte(wdetail.deductda).  a52-0172*/
     ASSIGN 
     /*dod0 =  nv_dedod */
     dod0 = deci(WDETAIL.deductpd)
     dod1 = 0
     dpd0 =  nv_ded  .

     IF  dod0 > 3000 THEN  
      ASSIGN
        dod1 = 3000 
        dod2 = dod0 - dod1  .
     ELSE dod1 = dod0. /*dod2 = dod0.*/ /* A64-0138 */

     IF dod1 <> 0 THEN DO:
        ASSIGN
            nv_odcod    = "DC01"
            /*nv_prem     =   dod2*/ /*A64-0138*/
            nv_prem     =   dod1   /*A64-0138*/
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
        
        ASSIGN nv_dedod1var  = ""
            nv_ded1prm        = nv_prem
            nv_dedod1_prm     = nv_prem
            nv_dedod1_cod     = "DOD"
            nv_dedod1var1     = "     Deduct OD = "
            nv_dedod1var2     = STRING(dod1) /*STRING(dod2) */ /*A64-0138*/
            SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
            SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
        /*add od*/
        Assign  nv_dedod2var   = " "
            nv_cons  = "AD".
            /*nv_ded   = dod1.*/ /*A64-0138*/
        /* comment by:A64-0138...
        Run  Wgs\Wgsmx025(INPUT  nv_ded,  
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).*/
        IF dod2 <> 0 THEN
        ASSIGN  
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   = STRING(dod2) /*STRING(dod1) *//*A64-0138*/
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2 .
            /*nv_dedod2_prm   = nv_prem.*/ /*A64-0138*/
     END.
     /***** pd *******/
     IF dpd0 <> 0 THEN DO:
        ASSIGN  nv_dedpdvar  = " "
            nv_ded = dpd0
            nv_cons  = "PD".
      /* comment by : A64-0138....
        Run  Wgs\Wgsmx025(INPUT  nv_ded, 
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).
        nv_ded2prm    = nv_prem.
        ...end A64-0138...*/
        ASSIGN
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(nv_ded)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
            /*nv_dedpd_prm  = nv_prem.*/ /*A64-0138*/
     END.
     /*---------- fleet -------------------*/
     nv_flet_per = INTE(wdetail.fleet)   .
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
     /* comment by : A64-0138....
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).
      ...end : A64-0138...*/
     ELSE 
         ASSIGN
         nv_fletvar     = " "
         nv_fletvar1    = "     Fleet % = "
         nv_fletvar2    =  STRING(nv_flet_per)
         SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
         SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     /*IF (wdetail.prepol = "") OR (WDETAIL.NCB = "") THEN DO:
         IF wdetail.covcod = "3" THEN WDETAIL.NCB = "30".
         ELSE IF  wdetail.covcod = "2" THEN WDETAIL.NCB = "20".
     END.*/
     
     ASSIGN 
         NV_NCBPER = 0
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
             Message " This NCB Step not on NCB Rates file xmm104. " 
                 nv_tariff          
                 nv_class           
                 nv_covcod          
                 wdetail.ncb  View-as alert-box.
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
     /* comment by : A64-0138....
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
     ASSIGN 
     nv_dsspcvar   = " ".
     /*nv_dss_per   = 0
     n_prem = deci(wdetail.premt)
     n_prem = TRUNCATE(((n_prem * 100 ) / 107.43),0).
     IF wdetail.covcod = "2" THEN nv_dss_per = 2.*/
     /*nv_dss_per = ((nv_gapprm - n_prem ) * 100 ) / nv_gapprm . */
     /* comment by : A64-0138....
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v ,       
                         nv_uom2_v ,       
                         nv_uom5_v ). */
     /*IF nv_gapprm <> n_prem THEN  nv_dss_per = TRUNCATE(((nv_gapprm - n_prem ) * 100 ) / nv_gapprm ,3 ) . 
          
        IF  nv_dss_per   <> 0  THEN
             Assign
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.*/
        

     IF  nv_dss_per   <> 0  THEN
         Assign
         nv_dsspcvar2   = ""
         nv_dsspcvar1   = "     Discount Special % = "
         nv_dsspcvar2   =  STRING(nv_dss_per)
         SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
         SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
     /*--------------------------*/
     /* comment by : A64-0138....
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v ,       
                         nv_uom2_v ,       
                         nv_uom5_v ). */
     /*IF  nv_dss_per   <> 0  THEN
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
                         nv_uom5_v ). */
     IF  nv_stf_per   <> 0  THEN
         ASSIGN nv_stfvar = ""
         nv_stfvar1   = "     Discount staff % = "
         nv_stfvar2   =  STRING(nv_stf_per)                 
         SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1          
         SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.         
     /*--------------------------*/   
     /* comment by : A64-0138....
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/         
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                nv_uom1_v,       
                                nv_uom2_v,       
                                nv_uom5_v). */
     /*-------------- load claim ---------------------*/
     /*nv_cl_per  = deci(wdetail.loadclm).*/
     nv_clmvar  = " ".
     IF nv_cl_per  <> 0  THEN
      Assign 
             nv_clmvar1   = " Load Claim % = "
             nv_clmvar2   =  STRING(nv_cl_per)
             SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
             SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
     /* comment by : A64-0138....
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                              nv_class,
                              nv_covcod,
                              nv_key_b,
                              nv_comdat,
                              nv_totsi,
                              uwm130.uom1_v,
                              uwm130.uom2_v,
                              uwm130.uom5_v).*/

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2plus c-Win 
PROCEDURE proc_base2plus :
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
ASSIGN fi_process = "check data ICBC  to base premium ... ".
    DISP   fi_process WITH FRAM fr_main.
    IF wdetail.prepol <> "" THEN  aa = nv_basere.
    ELSE DO:
        IF nv_baseprm = 0 THEN RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    ASSIGN chk = NO
        NO_basemsg = " "
        nv_baseprm = aa
        nv_drivvar1 = ""
        nv_drivvar2 = ""
        nv_drivvar1 = wdetail.Driv1.
        nv_drivvar2 = wdetail.Driv2.
        IF wdetail.drivnam = "N" THEN  nv_drivno = 0.
        ELSE DO:
            IF wdetail.Driv2 <> ""   THEN  nv_drivno = 2. 
            ELSE IF wdetail.Driv1 <> "" AND wdetail.Driv2 = "" THEN  nv_drivno = 1.  
            ELSE IF wdetail.Driv1  = "" AND wdetail.Driv2 = "" THEN  nv_drivno = 0.   
        END.
        If wdetail.drivnam  = "N"  Then DO:
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
                ASSIGN wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
            END.
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
    IF wdetail.prepol <> "" THEN  ASSIGN  nv_41 = n_41  /*�������*/
                                          nv_42 = n_42
                                          nv_43 = n_43
                                          nv_seat41 =  wdetail.seat41 .
    ELSE IF wdetail.prempa = "Z" THEN
        ASSIGN 
        nv_41 =deci(wdetail.no_41)  /*A60-0263*/
        nv_42 =deci(wdetail.no_42)  /*A60-0263*/
        nv_43 =deci(wdetail.no_43)  /*A60-0263*/
        /*nv_seat41 =  7*/   .     /*integer(wdetail.seat41)*/ 
    IF wdetail.model = "commuter" THEN 
        ASSIGN wdetail.seat = "16"
        nv_seats  =  16
        nv_seat41 =  16.
    /* comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                          nv_class,
                          nv_key_b,
                          nv_comdat).*/ 
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
    ASSIGN nv_42cod   = "42".
        nv_42var1  = "     Medical Expense = ".
        nv_42var2  = STRING(nv_42).
        SUBSTRING(nv_42var,1,30)   = nv_42var1.
        SUBSTRING(nv_42var,31,30)  = nv_42var2.
    nv_43var    = " ".     /*---------fi_43--------*/
    ASSIGN 
        nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
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
   IF deci(wdetail.si) = 0 THEN wdetail.si = wdetail.fire .
   Assign  nv_sivar = ""
       nv_totsi     = 0
       nv_sicod     = "SI"
       nv_sivar1    = "     Own Damage = "
       nv_sivar2    =  wdetail.si 
       SUBSTRING(nv_sivar,1,30)  = nv_sivar1
       SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
       nv_totsi     =  DECI(wdetail.si).
   /*----------nv_grpcod--------------------*/
   ASSIGN nv_grpvar   = ""
       nv_grpcod      = "GRP" + wdetail.cargrp
       nv_grpvar1     = "     Vehicle Group = "
       nv_grpvar2     = wdetail.cargrp
       Substr(nv_grpvar,1,30)  = nv_grpvar1
       Substr(nv_grpvar,31,30) = nv_grpvar2.
    /*-------------nv_bipcod--------------------*/
     ASSIGN nv_bipvar = ""
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(wdetail.tp1)
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign nv_biavar = ""
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(wdetail.tp2)
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*Add kridtiya i.  2+ 3 */
    IF      (wdetail.covcod = "2.1")   THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "21" .
    ELSE IF (wdetail.covcod = "2.2")   THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "22" .
    ELSE IF (wdetail.covcod = "3.1")  THEN  nv_usecod3 = "U" + TRIM(nv_vehuse) + "31" .
    ELSE nv_usecod3 = "U" + TRIM(nv_vehuse) + "32" .
    ASSIGN nv_usevar3 = ""   
        nv_usevar4 = "     Vehicle Use = "
        nv_usevar5 =  wdetail.vehuse
        Substring(nv_usevar3,1,30)   = nv_usevar4
        Substring(nv_usevar3,31,30)  = nv_usevar5.
     ASSIGN  nv_basecod3 = IF      (wdetail.covcod = "2.1") THEN "BA21"
                           ELSE IF (wdetail.covcod = "2.2") THEN "BA22" 
                           ELSE IF (wdetail.covcod = "3.1") THEN "BA31"ELSE "BA32".
     FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
         sicsyac.xmm106.tariff = nv_tariff   AND
         sicsyac.xmm106.bencod = nv_basecod3 AND
         sicsyac.xmm106.covcod = nv_covcod   AND
         sicsyac.xmm106.class  = nv_class    AND
         sicsyac.xmm106.key_b  GE nv_key_b   AND
         sicsyac.xmm106.effdat LE nv_comdat  NO-LOCK NO-ERROR NO-WAIT.
     IF AVAIL xmm106 THEN  nv_baseprm3 = xmm106.min_ap.
     ELSE  nv_baseprm3 = 0.
     ASSIGN nv_basevar3 = ""
         nv_basevar4 = "     Base Premium3 = "
         nv_basevar5 = STRING(nv_baseprm3)
         SUBSTRING(nv_basevar3,1,30)   = nv_basevar4
         SUBSTRING(nv_basevar3,31,30)  = nv_basevar5.  
     ASSIGN nv_sivar3 = ""
        nv_sicod3    = IF      (wdetail.covcod = "2.1") THEN "SI21" 
                       ELSE IF (wdetail.covcod = "2.2") THEN "SI22" 
                       ELSE IF (wdetail.covcod = "3.1") THEN "SI31"  ELSE "SI32"     
        nv_sivar4    = "     Own Damage = "                                        
        nv_sivar5    =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  string(deci(wdetail.si)) ELSE string(deci(wdetail.si)) 
        wdetail.si   =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  wdetail.si ELSE  wdetail.si
        SUBSTRING(nv_sivar3,1,30)  = nv_sivar4
        SUBSTRING(nv_sivar3,31,30) = nv_sivar5 .
        nv_totsi     = IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  deci(wdetail.si) ELSE  deci(wdetail.si).
     /*-------------nv_pdacod--------------------*/
     ASSIGN nv_pdavar = ""
         nv_pdacod    = "PD"
         nv_pdavar1   = "     PD per Accident = "
         nv_pdavar2   = STRING(wdetail.tp3)  
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    
    /*--------------- deduct ----------------*/
     ASSIGN 
     /*dod0 =  nv_dedod */
     dod0 = deci(WDETAIL.deductpd)
     dod1 = 0
     dpd0 =  nv_ded  .
     IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1")  THEN ASSIGN dod1    = 2000 .   /*A57-0126*/
     ELSE DO:
         IF  dod0 > 3000 THEN  
             ASSIGN
             dod1 = 3000 
             dod2 = dod0 - dod1  .
         ELSE dod1 = dod0. /*dod2 = dod0.*/ /* A64-0138 */
    END.
    IF dod1 <> 0 THEN DO:
        ASSIGN
            nv_odcod    = "DC01"
            /*nv_prem     =   dod2*/ /*A64-0138*/
            nv_prem     =   dod1   /*A64-0138*/
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
        
        ASSIGN nv_dedod1var  = ""
            nv_ded1prm        = nv_prem
            nv_dedod1_prm     = nv_prem
            nv_dedod1_cod     = "DOD"
            nv_dedod1var1     = "     Deduct OD = "
            nv_dedod1var2     = STRING(dod1) /*STRING(dod2) */ /*A64-0138*/
            SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
            SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
        /*add od*/
Assign  nv_dedod2var   = " "
            nv_cons  = "AD".
            
        IF dod2 <> 0 THEN
        ASSIGN  
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   = STRING(dod2) /*STRING(dod1) *//*A64-0138*/
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2 .
            /*nv_dedod2_prm   = nv_prem.*/ /*A64-0138*/
     END.
     /***** pd *******/
    /***** pd *******/
    IF dpd0 <> 0 THEN DO:
        ASSIGN  nv_dedpdvar  = " "
            nv_ded = dpd0
            nv_cons  = "PD".
      
        ASSIGN
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(nv_ded)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
            /*nv_dedpd_prm  = nv_prem.*/ /*A64-0138*/
     END.
    /*---------- fleet -------------------*/
     nv_flet_per = INTE(wdetail.fleet)   .
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
    
     ELSE 
         ASSIGN
         nv_fletvar     = " "
         nv_fletvar1    = "     Fleet % = "
         nv_fletvar2    =  STRING(nv_flet_per)
         SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
         SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN nv_fletvar  = " ".

    /*---------------- NCB -------------------*/
    ASSIGN 
         NV_NCBPER = 0
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
             Message " This NCB Step not on NCB Rates file xmm104. " 
                 nv_tariff          
                 nv_class           
                 nv_covcod          
                 wdetail.ncb  View-as alert-box.
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
    nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
      /*------------------ dsspc ---------------*/
     ASSIGN 
     nv_dsspcvar   = " ".
     IF  nv_dss_per   <> 0  THEN
         Assign
         nv_dsspcvar2   = ""
         nv_dsspcvar1   = "     Discount Special % = "
         nv_dsspcvar2   =  STRING(nv_dss_per)
         SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
         SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
     IF  nv_stf_per   <> 0  THEN
         ASSIGN nv_stfvar = ""
         nv_stfvar1   = "     Discount staff % = "
         nv_stfvar2   =  STRING(nv_stf_per)                 
         SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1          
         SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.  
     nv_clmvar  = " ".
     IF nv_cl_per  <> 0  THEN
      Assign 
             nv_clmvar1   = " Load Claim % = "
             nv_clmvar2   =  STRING(nv_cl_per)
             SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
             SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.

 

    ASSIGN fi_process = "out base" + wdetail.policy.
    DISP fi_process WITH FRAM fr_main.
END.
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
         /*nv_seat41  = 0  */        
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
         nv_uom7_c  = ""
         nv_pdprem  = 0 .

    ASSIGN               
         nv_covcod  = wdetail.covcod                                              
         nv_class   = trim(wdetail.prempa) + TRIM(wdetail.subclass) 
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
         nv_tpbi1si = deci(wdetail.tp1) /* nv_uom1_v */
         nv_tpbi2si = deci(wdetail.tp2) /* nv_uom2_v */
         nv_tppdsi  = deci(wdetail.tp3) /* nv_uom5_v */
         nv_411si   = nv_41             
         nv_412si   = nv_41             
         nv_413si   = 0                 
         nv_414si   = 0                 
         nv_42si    = nv_42                
         nv_43si    = nv_43                
         /*nv_seat41  = wdetail.seat41*/ 
         nv_dedod   = dod1 
         nv_addod   = dod2                           
         nv_dedpd   = dpd0                               
         nv_ncbp    = deci(wdetail.ncb)                                     
         nv_fletp   = deci(wdetail.fleet)                                  
         nv_dspcp   = nv_dss_per                                      
         nv_dstfp   = nv_stf_per                                                    
         nv_clmp    = nv_cl_per 
         /*nv_netprem  = TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) + 
                        (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )*/
         nv_netprem  = DECI(wdetail.premt) /* �����ط�� */                                                
         nv_gapprm  = 0                                                       
         nv_flagprm = "N"                 /* N = �����ط��, G = ������� */                                    
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

        IF wdetail.redbook <> ""  THEN do:
            FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                WHERE stat.maktab_fil.sclass = wdetail.subclass  AND
                      stat.maktab_fil.modcod = wdetail.redbook         No-lock no-error no-wait.
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
                wdetail.pass     = "N"     
                wdetail.OK_GEN   = "N".

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
    " wdetail.covcod :  "  nv_covcod     skip  
    " wdetail.class  :  "  nv_class      skip  
    " wdetail.vehuse :  "  nv_vehuse     skip  
    " nv_cstflg      :  "  nv_cstflg     skip  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/
    " nv_engine      :  "  nv_engcst     skip  /* ��ͧ����ҵ�� nv_cstflg  */
   
      "nv_engcst   : "      nv_engcst    skip
      "nv_drivno   : "      nv_drivno    skip
      "nv_driage1  : "      nv_driage1   skip
      "nv_driage2  : "      nv_driage2   skip
      "nv_pdprm0   : "      nv_pdprm0    skip
      "nv_yrmanu   : "      nv_yrmanu    skip
      "nv_totsi    : "      nv_totsi     skip
      "nv_vehgrp   : "      nv_vehgrp    skip
      "nv_access   : "      nv_access    skip
      "nv_supe     : "      nv_supe      skip                
      "nv_tpbi1si  : "      nv_tpbi1si   skip
      "nv_tpbi2si  : "      nv_tpbi2si   skip
      "nv_tppdsi   : "      nv_tppdsi    skip            
      "nv_411si    : "      nv_411si     skip
      "nv_412si    : "      nv_412si     skip
      "nv_413si    : "      nv_413si     skip
      "nv_414si    : "      nv_414si     skip
      "nv_42si     : "      nv_42si      skip
      "nv_43si     : "      nv_43si      skip
      "nv_41prmt   : "      nv_41prmt    skip
      "nv_42prmt   : "      nv_42prmt    skip
      "nv_43prmt   : "      nv_43prmt    skip
      "nv_seat41   : "      nv_seat41    skip
      "nv_dedod    : "      nv_dedod     skip
      "nv_addod    : "      nv_addod     skip
      "nv_dedpd    : "      nv_dedpd     skip           
      "nv_ncbp     : "      nv_ncbp      skip
      "nv_fletp    : "      nv_fletp     skip
      "nv_dspcp    : "      nv_dspcp     skip
      "nv_dstfp    : "      nv_dstfp     skip
      "nv_clmp     : "      nv_clmp      skip            
      "nv_baseprm  : "      nv_baseprm   skip
      "nv_baseprm3 : "      nv_baseprm3  skip
      "nv_pdprem   : "      nv_pdprem    skip
      "nv_netprem  : "      nv_netprem   skip
      "nv_gapprm   : "      nv_gapprm    skip
      "nv_flagprm  : "      nv_flagprm   skip         
      "nv_effdat   : "      nv_effdat    skip
      "nv_ratatt   : "      nv_ratatt    skip
      "nv_siatt    : "      nv_siatt     skip
      "nv_netatt   : "      nv_netatt    skip
      "nv_fltatt   : "      nv_fltatt    skip
      "nv_ncbatt   : "      nv_ncbatt    skip
      "nv_dscatt   : "      nv_dscatt    skip
      "nv_fcctv    : "      nv_fcctv     skip
      "nv_uom1_c   : "      nv_uom1_c    skip
      "nv_uom2_c   : "      nv_uom2_c    skip
      "nv_uom5_c   : "      nv_uom5_c    skip
      "nv_uom6_c   : "      nv_uom6_c    skip
      "nv_uom7_c   : "      nv_uom7_c       VIEW-AS ALERT-BOX.     */
 
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
                       OUTPUT nv_status, 
                       OUTPUT nv_message ). 
    /* IF nv_gapprm <> DECI(wdetail.premt) THEN DO:*/
    IF nv_status = "no"  THEN DO:
        /*MESSAGE "���¨ҡ�к� " + string(nv_gapprm,">>,>>>,>>9.99") + " �����ҡѺ�������� " + wdetail.premt +          nv_message    VIEW-AS ALERT-BOX. 
        ASSIGN
        wdetail.comment = wdetail.comment + "| " + "���¨ҡ�к� �����ҡѺ�������� "
        wdetail.WARNING = "���¨ҡ�к� " + string(nv_gapprm,">>,>>>,>>9.99") + " �����ҡѺ�������� " + wdetail.premt
        /* wdetail.pass    = "Y"      /*comment by Kridtiya i. A65-0035*/
        wdetail.OK_GEN  = "N"*/  .*/ /*comment by Kridtiya i. A65-0035*/
        /*  by Kridtiya i. A65-0035*/
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN
            wdetail.comment = wdetail.comment + "|" + nv_message
            wdetail.WARNING = wdetail.WARNING + "|" + nv_message .
        /*  by Kridtiya i. A65-0035*/
    END.
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate (input DATE(wdetail.comdat),
                        input date(wdetail.expdat),
                        input wdetail.poltyp,
                        OUTPUT nv_chkerror) .
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
IF wdetail.vehreg = " " AND wdetail.prepol  = " " THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N". 
ELSE DO:
        Def  var  nv_vehreg  as char  init  " ".
        Def  var  s_polno       like sicuw.uwm100.policy   init " ".
        Find LAST sicuw.uwm301 Use-index uwm30102   Where  
            sicuw.uwm301.vehreg = wdetail.vehreg    No-lock no-error no-wait.
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
            If avail sicuw.uwm100 Then  s_polno     =   sicuw.uwm100.policy.
        END.     /*avil 301 */
END.         /*note end else*/   /*end note vehreg*/
IF wdetail.cancel = "ca"  THEN  
    ASSIGN  wdetail.pass = "N"  
    wdetail.comment      = wdetail.comment + "| cancel"
    wdetail.OK_GEN       = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| ���ͼ����һ�Сѹ�繤����ҧ��ٳ������ͼ����һ�Сѹ"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.drivnam = "y" AND wdetail.Driv1  =  " "   THEN 
        ASSIGN
        wdetail.comment = wdetail.comment + "| �ա���к�����դ��Ѻ������ժ��ͤ��Ѻ"
        wdetail.pass    = "N" 
        wdetail.OK_GEN  = "N".
IF wdetail.prempa = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| prem pack �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.subclass = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| sub class �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
/*can't block in use*/ 
IF wdetail.brand = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| Brand �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
/*IF wdetail.model = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| model �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N".*/
IF wdetail.engcc    = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| Engine CC �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.seat  = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| seat �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| year manufacture �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
ASSIGN 
    n_model   = ""   /*A60*0263*/
    nv_modcod = ""
    nv_maxsi  = 0
    nv_minsi  = 0
    nv_si     = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred    = NO  . 
/*RUN proc_model_brand.*/
IF wdetail.prepol = "" THEN DO:
    IF wdetail.redbook <> "" THEN DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE 
            stat.maktab_fil.sclass = wdetail.subclass   AND 
            stat.maktab_fil.modcod = wdetail.redbook    No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then do:
            ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod     
                wdetail.engcc    =  STRING(stat.maktab_fil.engine)
                wdetail.subclass =  stat.maktab_fil.sclass   
                wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.brand    =  stat.maktab_fil.makdes
                /*wdetail.model    =  stat.maktab_fil.moddes*/
                wdetail.body     =  stat.maktab_fil.body
                wdetail.tons     =  stat.maktab_fil.tons
                nv_modcod        =  stat.maktab_fil.modcod   
                nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                nv_si            = maktab_fil.si.
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
            END.  /***--- End Check Rate SI ---***/
        END.
        ELSE nv_modcod = " ".
    END.  /*red book <> ""*/  
    IF nv_modcod = "" THEN DO:
        IF INDEX(wdetail.model,"vigo") <> 0 THEN n_model = "vigo". /*wdetail.model = "vigo".*/ /*A63-0164*/
        ELSE IF INDEX(wdetail.model,"altis") <> 0 THEN n_model = "altis". /*wdetail.model = "altis".*/ /*A63-0164*/
        ELSE IF INDEX(wdetail.model," ") <> 0 THEN
            /*wdetail.model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," "))*/ /*A60-0263*/
            n_model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ")). /*A60-0263*/
        ELSE n_model = TRIM(wdetail.model) . /*A63-0164 */
        
        FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
            makdes31.moddes =  wdetail.prempa + wdetail.subclass  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL makdes31  THEN
            ASSIGN n_ratmin = makdes31.si_theft_p   
                   n_ratmax = makdes31.load_p . 
        ELSE ASSIGN n_ratmin = 0
                    n_ratmax = 0.
       
        IF wdetail.covcod = "1" OR wdetail.covcod = "2" THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                /*index(stat.maktab_fil.moddes,wdetail.model) <> 0        And*/  /*A60-0263*/
                index(stat.maktab_fil.moddes,n_model) <> 0              AND      /*A60-0263*/
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     wdetail.subclass         AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
                 stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN 
                chkred           =  YES
                wdetail.redbook  =  stat.maktab_fil.modcod     
                wdetail.engcc    =  STRING(stat.maktab_fil.engine)
                wdetail.subclass =  stat.maktab_fil.sclass   
                wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.brand    =  stat.maktab_fil.makdes
                /*wdetail.model    =  stat.maktab_fil.moddes*/ /*A60-0263*/
                wdetail.body     =  stat.maktab_fil.body
                wdetail.tons     =  stat.maktab_fil.tons
                nv_modcod        =  stat.maktab_fil.modcod   
                nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes .
            /* A60-0263*/
            ELSE DO:
                Find First stat.maktab_fil USE-INDEX maktab04    Where
                    stat.maktab_fil.makdes   =     wdetail.brand            And                  
                    /*index(stat.maktab_fil.moddes,wdetail.model) <> 0        And*/   /*A60-0263*/
                    index(stat.maktab_fil.moddes,n_model) <> 0              AND       /*A60-0263*/
                    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                    stat.maktab_fil.engine   >=     Integer(wdetail.engcc)  AND
                    stat.maktab_fil.sclass   =     wdetail.subclass         No-lock no-error no-wait.
                If  avail stat.maktab_fil  Then 
                    ASSIGN 
                    chkred           =  YES
                    wdetail.redbook  =  stat.maktab_fil.modcod     
                    wdetail.engcc    =  STRING(stat.maktab_fil.engine)
                    wdetail.subclass =  stat.maktab_fil.sclass   
                    wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
                    wdetail.cargrp   =  stat.maktab_fil.prmpac
                    wdetail.brand    =  stat.maktab_fil.makdes
                    /*wdetail.model    =  stat.maktab_fil.moddes*/ /*A60-0263*/
                    wdetail.body     =  stat.maktab_fil.body
                    wdetail.tons     =  stat.maktab_fil.tons
                    nv_modcod        =  stat.maktab_fil.modcod   
                    nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes .
                
            END.
            /* end : A60-0263 */
        END.
        ELSE IF wdetail.covcod = "3" THEN DO:

            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     trim(wdetail.brand)            And                  
                /*index(stat.maktab_fil.moddes,wdetail.model) <> 0        And*/   /*A60-0263*/
                index(stat.maktab_fil.moddes,n_model) <> 0              AND       /*A60-0263*/
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   >=     Integer(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     wdetail.subclass         AND
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN 
                chkred           =  YES
                wdetail.redbook  =  stat.maktab_fil.modcod     
                wdetail.engcc    =  STRING(stat.maktab_fil.engine)
                wdetail.subclass =  stat.maktab_fil.sclass   
                wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.brand    =  stat.maktab_fil.makdes
                /*wdetail.model    =  stat.maktab_fil.moddes*/ /*A60-0263*/
                wdetail.body     =  stat.maktab_fil.body
                wdetail.tons     =  stat.maktab_fil.tons
                nv_modcod        =  stat.maktab_fil.modcod   
                nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes .
        END.
        IF nv_modcod = ""  THEN DO: 
            ASSIGN chkred = YES.
            /*RUN proc_model_brand.*/
            RUN proc_maktab.
        END.
    END.
END. /* wdetail.prepol = ""*/
ASSIGN                  
    NO_CLASS  = wdetail.prempa + wdetail.subclass 
    nv_poltyp = wdetail.poltyp.
IF nv_poltyp  = "v72" THEN NO_CLASS  =  wdetail.subclass.
If no_class  <>  " " Then do:
    FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
        sicsyac.xmd031.poltyp =   nv_poltyp AND
        sicsyac.xmd031.class  =   no_class  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmd031 THEN 
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
/*Add by krittapoj S. A65-0372 16/01/2023*/
/*Find sicsyac.sym100 Use-index sym10001       Where
     sicsyac.sym100.tabcod = "u118"          AND 
     sicsyac.sym100.itmdes=  wdetail.colordes No-lock no-error no-wait.
IF not avail sicsyac.sym100 Then 
    ASSIGN
    wdetail.comment = wdetail.comment + "| Not on Vehicle Usage Color table sym100 u118"
    wdetail.pass    = "N" 
    wdetail.OK_GEN  = "N".
Find sicsyac.sym100 Use-index sym10001       Where
     sicsyac.sym100.tabcod = "u119"          AND 
     sicsyac.sym100.itmdes =  wdetail.colordes No-lock no-error no-wait.
IF not avail sicsyac.sym100 Then 
    ASSIGN
    wdetail.comment = wdetail.comment + "| Not on Vehicle Usage Color table sym100 u119"
    wdetail.pass    = "N" 
    wdetail.OK_GEN  = "N".*/
/*End by krittapoj S. A65-0372 16/01/2023*/

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
     NV_NCBPER = INTE(WDETAIL.NCB) .
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
     END. /*ncb <> 0*/
     /******* drivernam **********/
     nv_sclass = wdetail.subclass. 
     If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
         ASSIGN
             wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
             wdetail.pass    = "N"    
             wdetail.OK_GEN  = "N".
     
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
    ASSIGN fi_process = "Check data ICBC  ".
    DISP fi_process WITH FRAM fr_main.
    IF  wdetail.policy = ""  THEN NEXT.
    ASSIGN 
        nv_dss_per = 0
        n_rencnt = 0
        n_endcnt = 0.
    /*RUN proc_cr_2.*/
    RUN proc_susspect.  /*Add by Kridtiya i. A63-0419 */
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    IF      wdetail.producer = "A0M0080"                             THEN ASSIGN wdetail.producer = "B3MLICB101" wdetail.financecd = "FICBC" wdetail.campaign_ov = "REDPLATE".
    ELSE IF wdetail.producer = "A0M0079"                             THEN ASSIGN wdetail.producer = "B3MLICB102" wdetail.financecd = "FICBC" wdetail.campaign_ov = "USED".
    ELSE IF wdetail.producer = "A0M0097"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer = "B3MLICB103" wdetail.financecd = "FICBC" wdetail.campaign_ov = "RENEW".   
    ELSE IF wdetail.producer = "A0M0097"                             THEN ASSIGN wdetail.producer = "B3MLICB103" wdetail.financecd = "FICBC" wdetail.campaign_ov = "TRANSF".    
    ELSE IF wdetail.producer = "A0M0079"                             THEN ASSIGN wdetail.producer = "B3MLICB104" wdetail.financecd = "FICBC" wdetail.campaign_ov = "USED".
    ELSE IF wdetail.producer = "A0M0097"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer = "B3MLICB105" wdetail.financecd = "FICBC" wdetail.campaign_ov = "RENEW". 
    ELSE IF wdetail.producer = "A0M0097"                             THEN ASSIGN wdetail.producer = "B3MLICB105" wdetail.financecd = "FICBC" wdetail.campaign_ov = "TRANSF".    
    ELSE IF wdetail.producer = "B3MLICB101"                          THEN ASSIGN  wdetail.financecd = "FICBC" wdetail.campaign_ov = "REDPLATE".
    ELSE IF wdetail.producer = "B3MLICB102"                          THEN ASSIGN  wdetail.financecd = "FICBC" wdetail.campaign_ov = "USED".
    ELSE IF wdetail.producer = "B3MLICB103" AND wdetail.prepol <> "" THEN ASSIGN  wdetail.financecd = "FICBC" wdetail.campaign_ov = "RENEW".   
    ELSE IF wdetail.producer = "B3MLICB103"                          THEN ASSIGN  wdetail.financecd = "FICBC" wdetail.campaign_ov = "TRANSF".   
    ELSE IF wdetail.producer = "B3MLICB104"                          THEN ASSIGN  wdetail.financecd = "FICBC" wdetail.campaign_ov = "USED".
    ELSE IF wdetail.producer = "B3MLICB105" AND wdetail.prepol <> "" THEN ASSIGN  wdetail.financecd = "FICBC" wdetail.campaign_ov = "RENEW". 
    ELSE IF wdetail.producer = "B3MLICB105"                          THEN ASSIGN  wdetail.financecd = "FICBC" wdetail.campaign_ov = "TRANSF".   
    IF wdetail.agent = "B3W0100" THEN wdetail.agent = "B3MLICB100".

    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
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
        IF wdetail.prepol <> "" THEN RUN proc_renew.
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        IF      wdetail.producer = "B3MLICB101"                          THEN ASSIGN wdetail.financecd = "FICBC" wdetail.campaign_ov = "REDPLATE".
        ELSE IF wdetail.producer = "B3MLICB102"                          THEN ASSIGN wdetail.financecd = "FICBC" wdetail.campaign_ov = "USED".
        ELSE IF wdetail.producer = "B3MLICB103" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FICBC" wdetail.campaign_ov = "RENEW".   
        ELSE IF wdetail.producer = "B3MLICB103"                          THEN ASSIGN wdetail.financecd = "FICBC" wdetail.campaign_ov = "TRANSF".        
        ELSE IF wdetail.producer = "B3MLICB104"                          THEN ASSIGN wdetail.financecd = "FICBC" wdetail.campaign_ov = "USED".
        ELSE IF wdetail.producer = "B3MLICB105" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FICBC" wdetail.campaign_ov = "RENEW". 
        ELSE IF wdetail.producer = "B3MLICB105"                          THEN ASSIGN wdetail.financecd = "FICBC" wdetail.campaign_ov = "TRANSF".        
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        RUN proc_chktest0.
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
ASSIGN fi_process = "Create data ICBC  to uwm130,uwm120,uwm301 ... ".
DISP   fi_process WITH FRAM fr_main.
RUN proc_chktest2_camp.
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
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno
        sic_bran.uwm130.bchyr  = nv_batchyr    /* batch Year */
        sic_bran.uwm130.bchno  = nv_batchno    /* bchno      */
        sic_bran.uwm130.bchcnt = nv_batcnt     /* bchcnt     */
        nv_sclass = wdetail.subclass.
    IF nv_uom6_u  =  "A"  THEN DO:
        IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
            nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
            Then  nv_uom6_u  =  "A".         
        Else 
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| Class��� ����Ѻ�ػ�ó����������". 
    END.     
    IF  CAPS(nv_uom6_u) = "A"  Then
        Assign  nv_uom6_u          = "A"
        nv_othcod                  = "OTH"
        nv_othvar1                 = "     Accessory  = "
        nv_othvar2                 =  STRING(nv_uom6_u)
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2
        sic_bran.uwm130.uom6_u     = nv_uom6_u.  /*A60-0150*/
    ELSE                           
        ASSIGN  nv_uom6_u              = ""
            nv_othcod                  = ""
            nv_othvar1                 = ""
            nv_othvar2                 = ""
            SUBSTRING(nv_othvar,1,30)  = nv_othvar1
            SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    IF (wdetail.covcod = "1")   OR (wdetail.covcod = "5")   OR 
       (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR
       (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN 
        ASSIGN
            sic_bran.uwm130.uom1_v   = deci(wdetail.tp1)  /*A60-0263*/
            sic_bran.uwm130.uom2_v   = deci(wdetail.tp2)  /*A60-0263*/
            sic_bran.uwm130.uom5_v   = deci(wdetail.tp3)  /*A60-0263*/
            sic_bran.uwm130.uom6_v   = inte(wdetail.si)
            sic_bran.uwm130.uom7_v   = inte(wdetail.fire)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
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
        ASSIGN 
            /*sic_bran.uwm130.uom1_v   =   deci(nv_uom1_v)  
            sic_bran.uwm130.uom2_v   =   deci(nv_uom2_v)  
            sic_bran.uwm130.uom5_v   =   deci(nv_uom5_v)  */
            sic_bran.uwm130.uom1_v   = deci(wdetail.tp1)  /*A60-0263*/  
            sic_bran.uwm130.uom2_v   = deci(wdetail.tp2)  /*A60-0263*/  
            sic_bran.uwm130.uom5_v   = deci(wdetail.tp3)  /*A60-0263*/  
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
        IF TRIM(wdetail.prempa) = "Z" OR TRIM(wdetail.prempa) = "T" THEN
            Assign 
            sic_bran.uwm130.uom1_v     =  deci(wdetail.tp1)     /*stat.clastab_fil.uom1_si  1000000  */  
            sic_bran.uwm130.uom2_v     =  deci(wdetail.tp2)     /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     =  deci(wdetail.tp3)     /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  =  deci(wdetail.tp1)     /*deci(wdetail2.tp_bi)   */ 
            nv_uom2_v                  =  deci(wdetail.tp2)     /*deci(wdetail2.tp_bi2) */  
            nv_uom5_v                  =  deci(wdetail.tp3).     /*deci(wdetail2.tp_bi3) */ 
        ELSE
            Assign 
                /*A63-0164*/
            nv_uom1_v                  =  stat.clastab_fil.uom1_si   
            nv_uom2_v                  =  stat.clastab_fil.uom2_si    
            nv_uom5_v                  =  stat.clastab_fil.uom5_si 
            /* Add By A63-0164 */
            sic_bran.uwm130.uom1_v     =  if stat.clastab_fil.uom1_si = 0 then  deci(wdetail.tp1) else stat.clastab_fil.uom1_si
            sic_bran.uwm130.uom2_v     =  if stat.clastab_fil.uom2_si = 0 then  deci(wdetail.tp2) else stat.clastab_fil.uom2_si
            sic_bran.uwm130.uom5_v     =  if stat.clastab_fil.uom5_si = 0 then  deci(wdetail.tp3) else stat.clastab_fil.uom5_si
            /* end A63-0164 */
            .
        ASSIGN 
            /*wdetail.deductpd           =  string(sic_bran.uwm130.uom5_v)*/
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
        IF (wdetail.prepol <> "") OR (TRIM(wdetail.prempa) = "Z") OR TRIM(wdetail.prempa) = "T" THEN
            ASSIGN nv_41          = deci(wdetail.no_41) 
                   nv_42          = deci(wdetail.no_42) 
                   nv_43          = deci(wdetail.no_43) 
                   nv_seat41      = IF wdetail.seat41 = 0 THEN deci(wdetail.seat) ELSE wdetail.seat41
                   /*wdetail.seat41 = IF nv_seat41 = 0 THEN deci(wdetail.seat) ELSE nv_seat41 */  .
        ELSE IF  wdetail.garage =  ""  Then
            ASSIGN 
            nv_41      = stat.clastab_fil.si_41unp
            nv_42      = stat.clastab_fil.si_42
            nv_43      = stat.clastab_fil.si_43
            nv_seat41  = stat.clastab_fil.dri_41 + clastab_fil.pass_41
            wdetail.seat41 = stat.clastab_fil.dri_41 + clastab_fil.pass_41.   
        Else If  wdetail.garage  =  "G"  Then
            Assign nv_41          =  stat.clastab_fil.si_41pai
                   nv_42          =  stat.clastab_fil.si_42
                   nv_43          =  stat.clastab_fil.impsi_43
                   nv_seat41      =  stat.clastab_fil.dri_41 + clastab_fil.pass_41
                   wdetail.seat41 =  stat.clastab_fil.dri_41 + clastab_fil.pass_41 .  
       
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
             sic_bran.uwm301.bchcnt = nv_batcnt                 NO-WAIT NO-ERROR.
         IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
             DO TRANSACTION:
                 CREATE sic_bran.uwm301.
             END. 
         END.
         ASSIGN 
             sic_bran.uwm301.policy    = sic_bran.uwm120.policy                 
             sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
             sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
             sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
             sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
             sic_bran.uwm301.itemno    = s_itemno
             sic_bran.uwm301.tariff    = wdetail.tariff    
             sic_bran.uwm301.covcod    = nv_covcod
             sic_bran.uwm301.modcod    = wdetail.redbook
             sic_bran.uwm301.cha_no    = trim(wdetail.chasno)
             sic_bran.uwm301.trareg    = nv_uwm301trareg
             sic_bran.uwm301.eng_no    = wdetail.eng
             sic_bran.uwm301.Tons      = INTEGER(wdetail.tons)
             sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
             sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
             sic_bran.uwm301.vehgrp    = wdetail.cargrp         
             sic_bran.uwm301.garage    = wdetail.garage
             sic_bran.uwm301.body      = wdetail.body
             sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
             sic_bran.uwm301.mv41seat  = nv_seat41
             sic_bran.uwm301.mv_ben83  = wdetail.benname
             sic_bran.uwm301.vehreg    = wdetail.vehreg  
             sic_bran.uwm301.vehuse    = wdetail.vehuse
             sic_bran.uwm301.moddes    = trim(wdetail.brand + " " + wdetail.model)
             sic_bran.uwm301.sckno     = 0
             sic_bran.uwm301.itmdel    = NO
             sic_bran.uwm301.bchyr     = nv_batchyr   /* batch Year */
             sic_bran.uwm301.bchno     = nv_batchno   /* bchno      */
             sic_bran.uwm301.bchcnt    = nv_batcnt .  /* bchcnt     */
             wdetail.tariff            = sic_bran.uwm301.tariff.
         IF wdetail.compul = "y" THEN DO:
             sic_bran.uwm301.cert = "".
             IF LENGTH(wdetail.stk) = 11 THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
             IF LENGTH(wdetail.stk) = 13  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
             IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".
             FIND FIRST brStat.Detaitem USE-INDEX detaitem11   WHERE
                 brStat.Detaitem.serailno = wdetail.stk        AND 
                 brstat.detaitem.yearReg  = nv_batchyr         AND
                 brstat.detaitem.seqno    = STRING(nv_batchno) AND
                 brstat.detaitem.seqno2   = STRING(nv_batcnt)  NO-ERROR NO-WAIT.
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
         END.  /*wdetail.compul = "y"*/
         ASSIGN s_recid4         = RECID(sic_bran.uwm301)
                sic_bran.uwm301.bchyr = nv_batchyr       /* batch Year */
                sic_bran.uwm301.bchno     = nv_batchno       /* bchno      */
                sic_bran.uwm301.bchcnt    = nv_batcnt.      /* bchcnt     */
         IF wdetail.driv1 <> "" AND  wdetail.drivnam = "Y" THEN RUN proc_mailtxt.  
         IF wdetail.seat    = "16" THEN wdetail.seat = "12".
         IF wdetail.redbook = ""     THEN DO:
             /* FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass      AND
                 stat.maktab_fil.modcod = wdetail.redbook
                 No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN
                     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                     sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
                     wdetail.cargrp          =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.engine  =  stat.maktab_fil.eng
                     nv_engine               =  stat.maktab_fil.eng.
             END.
             ELSE DO:*/
             Find First stat.maktab_fil Use-index      maktab04          Where
                 stat.maktab_fil.makdes   =     nv_makdes                And                  
                 index(stat.maktab_fil.moddes,nv_moddes) <> 0            And
                 stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
                 stat.maktab_fil.engine  =     Integer(wdetail.engcc)    AND
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
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.engine  =  stat.maktab_fil.engine
                     nv_engine               =  stat.maktab_fil.engine.
         END.
         /*IF wdetail.redbook  = ""  THEN RUN proc_maktab2.*/
         IF wdetail.redbook  = ""  THEN DO: 
             ASSIGN chkred = YES.
             /*RUN proc_model_brand.*/
             RUN proc_maktab.
            /* RUN proc_maktab2.*/
         END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2_camp c-Win 
PROCEDURE proc_chktest2_camp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF (wdetail.subclass = "110") AND (deci(wdetail.engcc) <= 2000 )  THEN DO:
    IF ((DECI(wdetail.si) = 0 ) OR (wdetail.si = "" )) AND (DECI(wdetail.fire) <> 0 )   THEN DO:
        FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
            brstat.insure.compno     = "CAMPAIGN_ICBC"      AND 
            brstat.insure.ICAddr2    = wdetail.producer     AND
            brstat.insure.Text3      = wdetail.prempa + wdetail.subclass AND  
            brstat.insure.vatcode    = wdetail.covcod       AND 
            deci(brstat.insure.Text4) = DECI(wdetail.fire)    AND
            deci(brstat.insure.icno) = 2000 NO-LOCK  NO-ERROR NO-WAIT.
        IF  AVAIL brstat.insure THEN  
            ASSIGN nv_uom1_v = deci(brstat.Insure.LName)         
            nv_uom2_v        = deci(brstat.Insure.Addr1)        
            nv_uom5_v        = deci(brstat.Insure.Addr2)        
            nv_41            = deci(brstat.Insure.Addr3)           
            nv_42            = deci(brstat.Insure.Addr4)           
            nv_43            = deci(brstat.Insure.TelNo)    
            nv_baseprm       = deci(brstat.insure.Text5)                
            WDETAIL.NCB      = string(brstat.insure.Deci1)                         
            nv_dss_per       = deci(brstat.insure.Deci2)  
            nv_seat41        = deci(brstat.insure.ICAddr1).
        ELSE nv_baseprm      = 0.
    END.
    ELSE DO:
        FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
            brstat.insure.compno      = "CAMPAIGN_ICBC"      AND 
            brstat.insure.ICAddr2     = wdetail.producer     AND
            brstat.insure.Text3       = wdetail.prempa + wdetail.subclass AND  
            brstat.insure.vatcode     = wdetail.covcod       AND 
            deci(brstat.insure.Text4) = DECI(wdetail.fire)     AND
            deci(brstat.insure.icno)  = 2000 NO-LOCK  NO-ERROR NO-WAIT.
        IF  AVAIL brstat.insure THEN  
            ASSIGN 
            nv_uom1_v   = deci(brstat.Insure.LName)         
            nv_uom2_v   = deci(brstat.Insure.Addr1)        
            nv_uom5_v   = deci(brstat.Insure.Addr2)        
            nv_41       = deci(brstat.Insure.Addr3)           
            nv_42       = deci(brstat.Insure.Addr4)           
            nv_43       = deci(brstat.Insure.TelNo)    
            nv_baseprm  = deci(brstat.insure.Text5)                
            WDETAIL.NCB = string(brstat.insure.Deci1)                         
            nv_dss_per  = deci(brstat.insure.Deci2)  
            nv_seat41   = deci(brstat.insure.ICAddr1).
        ELSE nv_baseprm = 0.
             
    END.
END.
ELSE IF  (wdetail.subclass = "110") AND (deci(wdetail.engcc) > 2000 )  THEN DO:  
    IF (DECI(wdetail.si) = 0 ) OR (wdetail.si = "" ) THEN DO:
        FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
            brstat.insure.compno     = "CAMPAIGN_ICBC"      AND 
            brstat.insure.ICAddr2    = wdetail.producer     AND
            brstat.insure.Text3      = wdetail.prempa + wdetail.subclass AND  
            brstat.insure.vatcode    = wdetail.covcod       AND 
            deci(brstat.insure.Text4) = DECI(wdetail.fire)    AND
            deci(brstat.insure.icno) = 2001 NO-LOCK  NO-ERROR NO-WAIT.
        IF  AVAIL brstat.insure THEN  
            ASSIGN 
            nv_uom1_v   = deci(brstat.Insure.LName)         
            nv_uom2_v   = deci(brstat.Insure.Addr1)        
            nv_uom5_v   = deci(brstat.Insure.Addr2)        
            nv_41       = deci(brstat.Insure.Addr3)           
            nv_42       = deci(brstat.Insure.Addr4)           
            nv_43       = deci(brstat.Insure.TelNo)    
            nv_baseprm  = deci(brstat.insure.Text5)                
            WDETAIL.NCB = string(brstat.insure.Deci1)                         
            nv_dss_per  = deci(brstat.insure.Deci2)  
            nv_seat41   = deci(brstat.insure.ICAddr1).
        ELSE nv_baseprm = 0.
             
     END.
     ELSE DO:
        FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
            brstat.insure.compno      = "CAMPAIGN_ICBC"      AND 
            brstat.insure.ICAddr2     = wdetail.producer     AND
            brstat.insure.Text3       = wdetail.prempa + wdetail.subclass AND  
            brstat.insure.vatcode     = wdetail.covcod       AND 
            deci(brstat.insure.Text4) = DECI(wdetail.fire)     AND
            deci(brstat.insure.icno)  = 2000 NO-LOCK  NO-ERROR NO-WAIT.
        IF  AVAIL brstat.insure THEN  
            ASSIGN 
            nv_uom1_v   = deci(brstat.Insure.LName)         
            nv_uom2_v   = deci(brstat.Insure.Addr1)        
            nv_uom5_v   = deci(brstat.Insure.Addr2)        
            nv_41       = deci(brstat.Insure.Addr3)           
            nv_42       = deci(brstat.Insure.Addr4)           
            nv_43       = deci(brstat.Insure.TelNo)    
            nv_baseprm  = deci(brstat.insure.Text5)                
            WDETAIL.NCB = string(brstat.insure.Deci1)                         
            nv_dss_per  = deci(brstat.insure.Deci2)  
            nv_seat41   = deci(brstat.insure.ICAddr1).
        ELSE nv_baseprm = 0.
             
    END.
     
END.
ELSE DO:
    FIND FIRST brstat.insure USE-INDEX Insure03  WHERE 
        brstat.insure.compno     = "CAMPAIGN_ICBC"      AND 
        brstat.insure.ICAddr2    = wdetail.producer     AND
        brstat.insure.Text3      = wdetail.prempa + wdetail.subclass AND  
        brstat.insure.vatcode    = wdetail.covcod       AND 
        deci(brstat.insure.icno) >= deci(wdetail.engcc) NO-LOCK  NO-ERROR NO-WAIT.
    IF  AVAIL brstat.insure THEN  
        ASSIGN 
        nv_uom1_v = deci(brstat.Insure.LName)         
        nv_uom2_v = deci(brstat.Insure.Addr1)        
        nv_uom5_v = deci(brstat.Insure.Addr2)        
        nv_41       = deci(brstat.Insure.Addr3)           
        nv_42       = deci(brstat.Insure.Addr4)           
        nv_43       = deci(brstat.Insure.TelNo)    
        nv_baseprm  = deci(brstat.insure.Text5)                
        WDETAIL.NCB = string(brstat.insure.Deci1)                         
        nv_dss_per  = deci(brstat.insure.Deci2)  
        nv_seat41   = deci(brstat.insure.ICAddr1).
    ELSE nv_baseprm = 0.
        
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
ASSIGN  
    nv_tariff = sic_bran.uwm301.tariff
    nv_class  = IF wdetail.poltyp = "v72" THEN wdetail.subclass ELSE wdetail.prempa +  wdetail.subclass
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = INTEGER(wdetail.engcc)
    /*nv_tons   = deci(wdetail.tons)*/
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
        Else assign nv_compprm     = 0
            nv_compcod     = " "
            nv_compvar1    = " "
            nv_compvar2    = " "
            nv_compvar     = " ".
        
        If  nv_compprm  =  0  THEN DO:
            ASSIGN nv_vehuse = "0".     /*A52-0172 �����0 ���ͧ�ҡ��ͧ����觤����� key.b = 0 */
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

IF  (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR 
    (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" )  THEN RUN proc_base2plus.   /*A58-0271*/
ELSE RUN proc_base2.
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
    MESSAGE "�������ç�Ѻ���·��ӹǳ��" + wdetail.premt + " <> " + STRING(nv_gapprm) VIEW-AS ALERT-BOX.
    ASSIGN 
        wdetail.WARNING  = "�������ç�Ѻ���������ӹǳ��"
        wdetail.comment  = wdetail.comment + "| gen ����к������������ç�Ѻ���������ӹǳ�� "
        wdetail.pass    = "N".
END. */ 

RUN proc_calpremt.       /*A64-0138*/
RUN proc_adduwd132prem.  /*A64-0138*/

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
        wdetail.seat41=  inte(wdetail.seat)
       /* sic_bran.uwm301.ncbper   = nv_ncbper      */ /*A64-0138*/
       /* sic_bran.uwm301.ncbyrs   = nv_ncbyrs      */ /*A64-0138*/
       /* sic_bran.uwm301.mv41seat = wdetail.seat41 */ /*A64-0138*/
    /* Add by A63-0164 */
        sic_bran.uwm301.tons     = IF sic_bran.uwm301.tons = 0 THEN 0 ELSE IF sic_bran.uwm301.tons < 100 THEN sic_bran.uwm301.tons * 1000 
                                   ELSE sic_bran.uwm301.tons .

    IF sic_bran.uwm301.tons < 100  AND ( SUBSTR(sic_bran.uwm120.CLASS,2,1) = "3"   OR  
         SUBSTR(sic_bran.uwm120.CLASS,2,1) = "4"   OR  SUBSTR(sic_bran.uwm120.CLASS,2,1) = "5"  OR  
         SUBSTR(sic_bran.uwm120.CLASS,2,3) = "803" OR SUBSTR(sic_bran.uwm120.CLASS,2,3) = "804" OR  
         SUBSTR(sic_bran.uwm120.CLASS,2,3) = "805" ) THEN DO:

         MESSAGE wdetail.policy + " " + sic_bran.uwm120.CLASS + " �кع��˹ѡö���١��ͧ " VIEW-AS ALERT-BOX.

           ASSIGN
                wdetail.comment = wdetail.comment + "| " + sic_bran.uwm120.CLASS + " �кع��˹ѡö���١��ͧ "
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".
   END.
   /* end A63-0164 */
/* comment by : A64-0138...  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create100 c-Win 
PROCEDURE proc_create100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Create  sic_bran.uwm100.   /*Create ��� gateway*/    
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam c-Win 
PROCEDURE proc_insnam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  n_insref     = ""  
nv_usrid     = "" 
nv_transfer  = NO 
n_check      = "" 
nv_insref    = "" 
nv_typ       = "" 
nv_usrid     = SUBSTRING(USERID(LDBNAME(1)),3,4)  
nv_transfer  = YES .  
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
        IF  R-INDEX(TRIM(wdetail.tiname),"��.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"�ӡѴ")           <> 0  OR  
            R-INDEX(TRIM(wdetail.tiname),"(��Ҫ�)")         <> 0  OR R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR INDEX(TRIM(wdetail.tiname),"����ѷ")            <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"�.")                <> 0  OR INDEX(TRIM(wdetail.tiname),"���.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"˨�.")              <> 0  OR INDEX(TRIM(wdetail.tiname),"�ʹ.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"����ѷ")            <> 0  OR INDEX(TRIM(wdetail.tiname),"��ŹԸ�")           <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"��ҧ")              <> 0  OR INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ")      <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ�ӡѴ") <> 0  OR INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ�ӡ")   <> 0  OR  
            INDEX(TRIM(wdetail.tiname),"���/����")          <> 0  THEN nv_typ = "Cs".
        ELSE nv_typ = "0s".   /*0s= �ؤ�Ÿ����� Cs = �ԵԺؤ��*/
      END.
      ELSE DO:                  /* ---- Check ���� name ---- */
        IF  R-INDEX(TRIM(wdetail.tiname),"��.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"�ӡѴ")           <> 0  OR  
            R-INDEX(TRIM(wdetail.tiname),"(��Ҫ�)")         <> 0  OR R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
            R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR INDEX(TRIM(wdetail.tiname),"����ѷ")            <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"�.")                <> 0  OR INDEX(TRIM(wdetail.tiname),"���.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"˨�.")              <> 0  OR INDEX(TRIM(wdetail.tiname),"�ʹ.")              <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"����ѷ")            <> 0  OR INDEX(TRIM(wdetail.tiname),"��ŹԸ�")           <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"��ҧ")              <> 0  OR INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ")      <> 0  OR 
            INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ�ӡѴ") <> 0  OR INDEX(TRIM(wdetail.tiname),"��ҧ�����ǹ�ӡ")   <> 0  OR  
            INDEX(TRIM(wdetail.tiname),"���/����")          <> 0  THEN nv_typ = "Cs".
        ELSE nv_typ = "0s".  /*0s= �ؤ�Ÿ����� Cs = �ԵԺؤ�� */
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
        ASSIGN wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| �����١����繤����ҧ�������ö������к�����" 
        WDETAIL.OK_GEN  = "N"
        nv_transfer = NO.
      END.
    END.
    n_insref = nv_insref.
  END.
  ELSE DO:  /* �óվ� */
    IF sicsyac.xmm600.acno <> "" THEN    
      ASSIGN nv_insref               = trim(sicsyac.xmm600.acno) 
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
      sicsyac.xmm600.nphone   = ""
      sicsyac.xmm600.naddr1   = ""
      sicsyac.xmm600.naddr2   = ""
      sicsyac.xmm600.naddr3   = ""
      sicsyac.xmm600.naddr4   = ""
      sicsyac.xmm600.anlyc1   = ""  .
  END.
END.
ELSE DO:
  FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno   = TRIM(wdetail.insref)  NO-ERROR NO-WAIT.  
  IF AVAILABLE sicsyac.xmm600 THEN 
    ASSIGN nv_insref               = trim(sicsyac.xmm600.acno) 
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
    sicsyac.xmm600.nphone   = ""
    sicsyac.xmm600.naddr1   = ""
    sicsyac.xmm600.naddr2   = ""
    sicsyac.xmm600.naddr3   = ""
    sicsyac.xmm600.naddr4   = ""
    sicsyac.xmm600.anlyc1   = "" .

END.
IF nv_transfer = YES THEN DO:
  IF nv_insref  <> "" THEN 
    ASSIGN wdetail.insref   = nv_insref
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
    sicsyac.xmm600.nphone   = "" .                      /*New phone no.*/    
  ASSIGN
    sicsyac.xmm600.nachg    = YES                      /*Change N&A on Renewal/Endt*/
    sicsyac.xmm600.regdate  = ?                        /*Agents registration Date*/
    sicsyac.xmm600.alevel   = 0                        /*Agency Level*/
    sicsyac.xmm600.taxno    = ""                       /*Agent tax no.*/
    sicsyac.xmm600.anlyc1   = ""                       /*Analysis Code 1*/
    sicsyac.xmm600.taxdate  = ?                        /*Agent tax date*/
    sicsyac.xmm600.anlyc5   =  ""                      /*Analysis Code 5*/
    sicsyac.xmm600.dtyp20   = ""     
    sicsyac.xmm600.dval20   = "" 
    sicsyac.xmm600.nphone   = ""
    sicsyac.xmm600.naddr1   = ""
    sicsyac.xmm600.naddr2   = ""
    sicsyac.xmm600.naddr3   = ""
    sicsyac.xmm600.naddr4   = ""
    sicsyac.xmm600.anlyc1   = "".

END.
IF sicsyac.xmm600.acno <> ""  THEN DO:
  ASSIGN nv_insref = sicsyac.xmm600.acno.
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
      ASSIGN sicsyac.xtm600.acno    = nv_insref               /*Account no.*/
      sicsyac.xtm600.name    = TRIM(wdetail.insnam)    /*Name of Insured Line 1*/
      sicsyac.xtm600.abname  = TRIM(wdetail.insnam)    /*Abbreviated Name*/
      sicsyac.xtm600.addr1   = TRIM(wdetail.addr1)     /*address line 1*/
      sicsyac.xtm600.addr2   = TRIM(wdetail.addr2)     /*address line 2*/
      sicsyac.xtm600.addr3   = TRIM(wdetail.addr3)     /*address line 3*/
      sicsyac.xtm600.addr4   = TRIM(wdetail.addr4)     /*address line 4*/
      sicsyac.xtm600.name2   = ""                      /*Name of Insured Line 2*/
      sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)    /*Title*/
      sicsyac.xtm600.name3   = ""                      /*Name of Insured Line 3*/
      sicsyac.xtm600.fname     = ""  .                    /*First Name*/
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
    sicsyac.xmm600.acno_typ  = trim(wdetail.insnamtyp)   /*�������١��� CO = �ԵԺؤ��  PR = �ؤ��*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    sicsyac.xmm600.icno      = trim(wdetail.idno)       
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/       .  
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
        "�����١��� �֧�����Ţ�ش�������� / ¡��ԡ��÷ӧҹ���Ǥ���"      SKIP
        "���ǵԴ��ͼ���� Code"  VIEW-AS ALERT-BOX. */
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
  
  nv_drivage1 =  YEAR(TODAY) - INT(SUBSTR(wdetail.BDriv1,1,4)).
  nv_drivage2 =  YEAR(TODAY) - INT(SUBSTR(wdetail.BDriv2,1,4)).

  IF wdetail.BDriv1 <> " "  AND wdetail.Driv1 <> " " THEN DO: /*note add & modified*/
     nv_drivbir1      = STRING(INT(SUBSTR(wdetail.BDriv1,1,4)) + 543).
     wdetail.BDriv1   = SUBSTR(wdetail.BDriv1,7,2) + "/" + SUBSTR(wdetail.BDriv1,5,2) + "/"  + nv_drivbir1.
  END.

  IF wdetail.BDriv2 <>  " " AND wdetail.Driv2 <> " " THEN DO: /*note add & modified */
     nv_drivbir2      = STRING(INT(SUBSTR(wdetail.BDriv2,1,4)) + 543).
     wdetail.BDriv2   = SUBSTR(wdetail.BDriv2,7,2) + "/" + SUBSTR(wdetail.BDriv2,5,2) + "/" + nv_drivbir2.
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
        stat.maktab_fil.makdes   =    wdetail.brand             And                  
        /*index(stat.maktab_fil.moddes,wdetail.model) <> 0        And */   /*A60-0263*/
        index(stat.maktab_fil.moddes,n_model) <> 0              AND        /*A60-0263*/
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND 
        stat.maktab_fil.sclass   =     wdetail.subclass         AND
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
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
        index(stat.maktab_fil.moddes,n_model) <> 0              AND        /*A60-0263*/
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear)   AND
        stat.maktab_fil.engine   =     Integer(wdetail.engcc)     AND
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
        stat.maktab_fil.makdes   =    wdetail.brand               And                  
        /*index(stat.maktab_fil.moddes,wdetail.model) <> 0        And */   /*A60-0263*/
        index(stat.maktab_fil.moddes,n_model) <> 0              AND        /*A60-0263*/
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear)   AND
        stat.maktab_fil.engine   =     Integer(wdetail.engcc)     AND
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
            wdetail.comment = wdetail.comment + "| Sticker Number �� Generate ����� ���ͧ�ҡ Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| �����Ţ������������١������� "
                wdetail.warning = "Program Running Policy No. �����Ǥ���".
        END.
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk  NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| �����Ţ Sticker ��������١�������"
            wdetail.warning = "Program Running Policy No. �����Ǥ���".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.       /*wdetail.stk  <>  ""*/
    ELSE DO:   /*sticker = ""*/ 
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol  = trim(wdetail.cedpol) AND 
                                                        sicuw.uwm100.poltyp  = trim(wdetail.poltyp) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ( sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES )
                AND (sicuw.uwm100.expdat > date(wdetail.comdat)) THEN  
                ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| �Ţ����ѭ�ҹ����١������� "
                wdetail.warning = "Program Running Policy No. �����Ǥ���".
            IF wdetail.policy = "" THEN DO:
                RUN proc_temppolicy.
                wdetail.policy  = nv_tmppol.
            END.
            RUN proc_create100. 
        END.
        ELSE RUN proc_create100.  
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
            wdetail.comment = wdetail.comment + "| Sticker Number �� Generate ����� ���ͧ�ҡ Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| �����Ţ������������١������� "
                wdetail.warning = "Program Running Policy No. �����Ǥ���".
        END.
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| �����Ţ Sticker ��������١�������"
            wdetail.warning = "Program Running Policy No. �����Ǥ���".
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
/*IF  wdetail.poltyp = "v72"   THEN DO: 
    FIND FIRST stat.insure USE-INDEX Insure06 WHERE   /*use-index fname */
        stat.insure.LName  = TRIM(wdetail.txtmemo2)          AND
        stat.insure.compno = trim(fi_companoti)     NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL  stat.insure THEN 
        ASSIGN n_promt =  stat.insure.FName .
    ELSE n_promt = "".
    ASSIGN wdetail.txtmemo2 = "". 
END.
ELSE IF substr(wdetail.txtmemo2,1,1) = ":"   THEN  ASSIGN n_promt = "".
ELSE DO:
    ASSIGN n_promt = IF INDEX(wdetail.txtmemo2,":") <> 0 THEN  trim(substr(wdetail.txtmemo2,1,INDEX(wdetail.txtmemo2,":") - 1)) ELSE "".
    FIND FIRST stat.insure USE-INDEX Insure06 WHERE   /*use-index fname */
        stat.insure.LName  = n_promt          AND
        stat.insure.compno = trim(fi_companoti)     NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL  stat.insure THEN 
        ASSIGN n_promt =  stat.insure.FName .
    ELSE n_promt = "".
END.*/
IF ( wdetail.poltyp = "v72" ) OR (wdetail.covcod = "3") THEN wdetail.benname = "".
IF TRIM(wdetail.insref) = "" THEN RUN proc_insnam.
RUN proc_insnam2 . /*Add by Kridtiya i. A63-0472*/
RUN proc_chkcode. /*A64-0138*/
DO TRANSACTION:
   ASSIGN
      sic_bran.uwm100.renno  = ""
      sic_bran.uwm100.endno  = ""
      sic_bran.uwm100.poltyp = wdetail.poltyp
      sic_bran.uwm100.insref = wdetail.insref
      sic_bran.uwm100.opnpol = wdetail.promo
      sic_bran.uwm100.anam2  = trim(wdetail.idno)            /* ICNO  Cover Note A51-0071 Amparat */
      sic_bran.uwm100.ntitle = trim(wdetail.tiname)        
      sic_bran.uwm100.name1  = trim(wdetail.insnam)        
      sic_bran.uwm100.name2  = trim(wdetail.np_name2)              /*wdetail.receipt_name*/        /*���/���� */              
      sic_bran.uwm100.name3  = wdetail.np_name3              
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
      sic_bran.uwm100.fstdat = DATE(wdetail.firstdat)        /*kridtiya i. a53-0171 ��� firstdate=comdate */
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
      sic_bran.uwm100.prog   = "wgwticbc"
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
     /*sic_bran.uwm100.finint  = wdetail.n_delercode*/  /*code deler */
      sic_bran.uwm100.bs_cd   = wdetail.vatcode   /*add ���� Vatcode */
     /* sic_bran.uwm100.opnpol  = CAPS(wdetail.ins_pay) */ 
     /*sic_bran.uwm100.endern  = date(wdetail.ac_date)*/  
      sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)      /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)       /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.postcd     = trim(wdetail.postcd)         /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.icno       = trim(wdetail.idno)           /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)        /*Add by Kridtiya i. A63-0472*/ 
      sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)      /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)      /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)      /*Add by Kridtiya i. A63-0472*/
      /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)  */   /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov)    /*Add by Kridtiya i. A63-0472*/
      sic_bran.uwm100.dealer     = trim(wdetail.financecd).     /*Add by Kridtiya i. A63-0472*/ 
         
      IF wdetail.prepol <> " " THEN DO:
          IF wdetail.poltyp = "v72"  THEN ASSIGN  sic_bran.uwm100.prvpol  = ""
                                                  sic_bran.uwm100.tranty  = "R".  
          ELSE 
              ASSIGN  sic_bran.uwm100.prvpol  = wdetail.prepol     /*����繧ҹ Renew  ��ͧ����繤����ҧ*/
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
      /*nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                    ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat. */ 
      IF (DAY(sic_bran.uwm100.comdat)      =  DAY(sic_bran.uwm100.expdat)    AND
          MONTH(sic_bran.uwm100.comdat)    =  MONTH(sic_bran.uwm100.expdat)  AND
          YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) ) OR
         (DAY(sic_bran.uwm100.comdat)      =  29                             AND
          MONTH(sic_bran.uwm100.comdat)    =  02                             AND
          DAY(sic_bran.uwm100.expdat)      =  01                             AND
          MONTH(sic_bran.uwm100.expdat)    =   03                            AND
          YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
                THEN  nv_polday = 365.
      ELSE  nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  �ѹ */
END. /*transaction*//**/
/*IF (wdetail.poltyp = "v70") AND (wdetail.txtmemo <> "")  THEN RUN proc_uwd102.   /*memmo F18 */*//*A57-0125*/
IF (wdetail.poltyp = "v70") THEN  RUN proc_uwd102. /*A57-0125*/
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
        MESSAGE "�����ó��ա�õ����������" VIEW-AS ALERT-BOX .
        ASSIGN
            wdetail.prepol  = "Already Renew" /*������������繧ҹ�������*/
            wdetail.comment = wdetail.comment + "| �����ó��ա�õ����������" 
            wdetail.OK_GEN  = "N"
            wdetail.pass    = "N". 
    END.
    ELSE DO: 
        ASSIGN
            wdetail.prepol = sicuw.uwm100.policy
            n_rencnt       =  sicuw.uwm100.rencnt  +  1
            n_endcnt       =  0
            wdetail.pass   = "Y".
        RUN proc_assignrenew .  /*�Ѻ��� ����������ͧ�ͧ��� */
    END.
END.   /*  avail  buwm100  */
Else do: 
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0
        wdetail.prepol   = ""
        wdetail.comment  = wdetail.comment + "| �繡������������بҡ����ѷ���  ".
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
    "WARNING     " ","
    "Color       "            /*Add by Krittapoj S. A65-0372 16/01/2023*/
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
        wdetail.WARNING       "," 
        wdetail.colordes     /*Add by Krittapoj S. A65-0372 16/01/2023*/
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
    "WARNING     "    ","
    "Color       "        /*Add by Krittapoj S. A65-0372 16/01/2023*/
    SKIP.        
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
            wdetail.WARNING       ","
            wdetail.colordes         /*Add by Krittapoj S. A65-0372 16/01/2023*/
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
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*//*Comment A62-0105*/
      /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/
       /*CONNECT expiry -H 10.35.176.37 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/
      
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
        ASSIGN wdetail.comment = "ö�����һ�Сѹ �Դ suspect ����¹ " + nn_vehreglist + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
END.
IF (nv_msgstatus = "") AND (nn_namelist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
        sicuw.uzsusp.fname = nn_namelist           AND 
        sicuw.uzsusp.lname = nn_namelist2          NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN wdetail.comment = "���ͼ����һ�Сѹ �Դ suspect �س" + nn_namelist + " " + nn_namelist2 + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
    ELSE DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = Trim(nn_namelist  + " " + nn_namelist2)        
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN wdetail.comment = "���ͼ����һ�Сѹ �Դ suspect �س" + nn_namelist + " " + nn_namelist2 + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".
        END.
    END.
END.

IF (nv_msgstatus = "") AND (nv_chanolist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp05   WHERE 
        uzsusp.cha_no =  nv_chanolist         NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN wdetail.comment = "ö�����һ�Сѹ �Դ suspect �Ţ��Ƕѧ " + nv_chanolist + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
            wdetail.pass    = "N"     
            wdetail.OK_GEN  = "N".
    END.
END.
IF (nv_msgstatus = "") AND (nv_idnolist <> "") THEN DO:

    FIND LAST sicuw.uzsusp USE-INDEX uzsusp08    WHERE 
        sicuw.uzsusp.notes = nv_idnolist   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN wdetail.comment = "ID�����һ�Сѹ �Դ suspect ID: " + nv_idnolist2 + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
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
            ASSIGN wdetail.comment  = "ID�����һ�Сѹ �Դ suspect ID: " + nv_idnolist2 + " ��سҵԴ��ͽ����Ѻ��Сѹ" 
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
/*MESSAGE wdetail.txtmemo  VIEW-AS ALERT-BOX.*/
/*IF (wdetail.txtmemo <> "") OR (wdetail.txtmemo2 <> "")  THEN DO:*/
/*IF  (wdetail.namerequest <> "") OR (wdetail.daterequest <> "") OR (wdetail.nocheck <> "") THEN DO:*/
   /* DO WHILE nv_line1 <= 6 :*/ /*a60-0263*/
    DO WHILE nv_line1 <= 10 :  /*a60-0263*/
        CREATE wuppertxt3.
        wuppertxt3.line = nv_line1.
        /*IF nv_line1 = 1  THEN wuppertxt3.txt = ""  .
        IF nv_line1 = 2  THEN wuppertxt3.txt = wdetail.txtmemo    .
        IF INDEX(wdetail.txtmemo2,":") <> R-INDEX(wdetail.txtmemo2,":") THEN DO:  
            IF nv_line1 = 3  THEN 
                wuppertxt3.txt =  IF INDEX(wdetail.txtmemo2,":") <> 0 THEN  
                                     trim(substr(wdetail.txtmemo2,INDEX(wdetail.txtmemo2,":") + 1)) 
                                     ELSE "".
        END.*/
        /*IF nv_line1 = 3  THEN wuppertxt3.txt = "����駧ҹ    :" + wdetail.namerequest .
        IF nv_line1 = 4  THEN wuppertxt3.txt = "�ѹ����駧ҹ :" + wdetail.daterequest .
        IF nv_line1 = 5  THEN wuppertxt3.txt = "�Ţ��Ǩ��Ҿ   :" + wdetail.nocheck     .*/
        IF nv_line1 = 1 THEN wuppertxt3.txt = "Company name : "  + fi_companoti .
        IF nv_line1 = 2 THEN wuppertxt3.txt = "�ѹ����駧ҹ : "    + SUBSTR(wdetail.daterequest,7,2) + "/"
                                                                    + SUBSTR(wdetail.daterequest,5,2) + "/"
                                                                    + SUBSTR(wdetail.daterequest,1,4) + 
                                              "  ���ͼ���駧ҹ : " + wdetail.namerequest . 
        IF nv_line1 = 3 THEN wuppertxt3.txt = "�Ţ����Ѻ�� : "    + wdetail.notify_no .
        IF nv_line1 = 4 THEN wuppertxt3.txt = "�ѹ����׹�ѹ : "     + substr(wdetail.nocheck,7,2) + "/"
                                                                    + substr(wdetail.nocheck,5,2) + "/" 
                                                                    + substr(wdetail.nocheck,1,4) +  
                                            "  ���ͼ���׹�ѹ : "    + wdetail.notfyby  .              
        IF nv_line1 = 5 THEN wuppertxt3.txt = "�Ţ��Ǩ��Ҿ : "      + wdetail.txtmemo  . 
        IF nv_line1 = 6 THEN wuppertxt3.txt = "�����˵� : "         + wdetail.txtmemo2 .
        IF nv_line1 = 7 THEN wuppertxt3.txt = "��໭ : "           + wdetail.campaign .  /*A60-0263*/

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
/*END. /*(wdetail.namerequest = "") AND (wdetail.daterequest = "") AND (wdetail.nocheck = "")*/*/
/*END.*/
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
                  n_dcover = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  �ѹ */
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

