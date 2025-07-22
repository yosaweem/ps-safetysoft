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
/****************************  Definitions  **************************    */
/*Parameters Definitions ---                                              */
/*Local Variable Definitions ---                                          */  
/*******************************/                                      
/*programid   : wgwnsgen.w                                                */ 
/*programname : Load text file Nissan to GW  (�������)                              */ 
/* Copyright  : Safety Insurance Public Company Limited                   */
/*copy write  : wgwargen.w                                                */ 
/*              ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)                        */
/*create by   : Ranu i. A60-0139  date. 10/04/2017                  
                ����� text file Nissan to GW system �ҹ�������             */
/***************************************************************************/
/*Modify By : Ranu I. a60-0272 Date: 23/06/2017 ��������红����Ū�ͧ icno */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 ����������纤�ҡ�äӹǳ���� */
/*Modify by   : Kridtiya i. A65-0035 comment message error premium not on file */
/*---------------------------------------------------------------------------------*/
{wgw\wgwnsren.i}      /*��С�ȵ����*/
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
DEFINE  WORKFILE wcam NO-UNDO
/*1*/      FIELD model     AS CHARACTER FORMAT "X(35)"  INITIAL ""
/*2*/      FIELD producer  AS CHARACTER FORMAT "X(10)"  INITIAL ""
           FIELD agent     AS CHARACTER FORMAT "X(10)"  INITIAL "".
DEFINE VAR n_insref     AS CHARACTER FORMAT "X(10)" .            /*A56-0352*/
DEF    VAR nv_insref    AS CHAR      FORMAT "x(10)" INIT "" .    /*A56-0352*/
DEFINE VAR nv_typ       AS CHAR      FORMAT "X(2)".              /*A56-0352*/
DEFINE VAR n_check      AS CHARACTER .                           /*A56-0352*/
DEFINE  WORKFILE wchano   NO-UNDO
/*1*/      FIELD policy    AS CHARACTER FORMAT "X(15)"  INITIAL ""
/*2*/      FIELD rencnt    AS CHARACTER FORMAT "X(10)"  INITIAL ""
           FIELD endcnt    AS CHARACTER FORMAT "X(10)"  INITIAL ""
           FIELD poltyp    AS CHARACTER FORMAT "x(10)"  INITIAL ""
           FIELD expdat    AS CHARACTER FORMAT "X(10)"  INITIAL ""
           FIELD polsta    AS CHARACTER FORMAT "x(10)"  INITIAL ""
           FIELD chassis   AS CHARACTER FORMAT "X(30)"  INITIAL "".
DEF VAR nv_txt5 AS CHAR FORMAT "x(60)" INIT "".  /*A57-0275*/
DEF VAR re_vehreg   AS CHAR FORMAT "x(15)".
DEF var re_redbook  as char format "x(10)".
DEF var re_brand    as char format "x(15)".
DEF var re_model    as char format "x(30)".
DEF var re_caryear  as char format "x(4)".
DEF var re_engcc    as char format "x(5)".
DEF var re_cargrp   as char format "x(3)".
DEF var re_body     as char format "x(20)".
DEF var re_tons     as char format "x(4)" .
DEF var re_seat     as char format "x(2)" .
DEF var re_vehuse   as char format "x(2)".
DEF var re_chasno   as char format "x(20)".
DEF var re_eng      as char format "x(20)".
DEF VAR re_benname  AS CHAR FORMAT "x(50)".

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
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.redbook /*add new*/ wdetail.poltyp wdetail.n_branch wdetail.policy wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.addr1 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.engcc wdetail.tons wdetail.seat wdetail.body wdetail.stk wdetail.covcod wdetail.vehreg wdetail.eng wdetail.chasno wdetail.caryear wdetail.vehuse wdetail.garage wdetail.si wdetail.fleet wdetail.deductpd wdetail.benname wdetail.n_IMPORT wdetail.n_export wdetail.drivnam wdetail.producer wdetail.agent wdetail.comment WDETAIL.WARNING wdetail.cancel wdetail.renpol wdetail.compul   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_wdetail FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_pack fi_camaign fi_camaign2 ~
fi_branch fi_matmodel fi_brand fi_producer1 fi_Agent1 fi_producer2 ~
fi_agent2 fi_no_mn30 ra_typefile fi_filename bu_file buok fi_prevbat ~
fi_bchyr fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem bu_exit ~
br_wdetail bu_hpbrn bu_hpacno2 bu_hpacno-3 bu_hpacno-5 bu_hpacno-6 ~
fi_process RECT-370 RECT-372 RECT-373 RECT-375 RECT-379 RECT-380 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_pack fi_camaign fi_camaign2 ~
fi_branch fi_matmodel fi_brand fi_producer1 fi_Agent1 fi_bchno fi_producer2 ~
fi_agent2 fi_no_mn30 ra_typefile fi_filename fi_prevbat fi_bchyr fi_output1 ~
fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_proname2 ~
fi_proname1 fi_completecnt fi_premtot fi_agentname1 fi_agentname2 ~
fi_premsuc fi_process 

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
     SIZE 10.5 BY 1.14
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10.67 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_hpacno-3 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpacno-5 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpacno-6 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpacno2 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE VARIABLE fi_Agent1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agentname1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agentname2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(19)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY .95
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camaign AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_camaign2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

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

DEFINE VARIABLE fi_matmodel AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_no_mn30 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .95
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

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY .95
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY .95
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_producer1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_proname2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_typefile AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Load GW", 1,
"Match Policy", 2
     SIZE 33.67 BY 1
     BGCOLOR 10 FGCOLOR 2  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 15
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 4.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-375
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 2.43
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16 BY 1.91
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16 BY 1.91
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
      wdetail.redbook  COLUMN-LABEL "RedBook"      /*add new*/
        wdetail.poltyp   COLUMN-LABEL "Policy Type"
        wdetail.n_branch COLUMN-LABEL "Branch"
        wdetail.policy   COLUMN-LABEL "Policy"
        wdetail.tiname   COLUMN-LABEL "Title Name"   
        wdetail.insnam   COLUMN-LABEL "Insured Name" 
        wdetail.comdat   COLUMN-LABEL "Comm Date"
        wdetail.expdat   COLUMN-LABEL "Expiry Date"
        wdetail.addr1    COLUMN-LABEL "Ins Add1"
        wdetail.prempa   COLUMN-LABEL "Premium Package"
        wdetail.subclass COLUMN-LABEL "Sub Class"
        wdetail.brand    COLUMN-LABEL "Brand"
        wdetail.model    COLUMN-LABEL "Model"
        wdetail.engcc    COLUMN-LABEL "CC"
        wdetail.tons     COLUMN-LABEL "Weight"
        wdetail.seat     COLUMN-LABEL "Seat"
        wdetail.body     COLUMN-LABEL "Body"
        wdetail.stk      COLUMN-LABEL "Sticker"
        wdetail.covcod   COLUMN-LABEL "Cover Type"
        wdetail.vehreg   COLUMN-LABEL "Vehicle Register"
        wdetail.eng      COLUMN-LABEL "Engine NO."
        wdetail.chasno   COLUMN-LABEL "Chassis NO."
        wdetail.caryear  COLUMN-LABEL "Car Year" 
        wdetail.vehuse   COLUMN-LABEL "Vehicle Use" 
        wdetail.garage   COLUMN-LABEL "Garage"
        wdetail.si       COLUMN-LABEL "Sum Insure"
        wdetail.fleet    COLUMN-LABEL "Fleet"
        wdetail.deductpd COLUMN-LABEL "Deduct PD"
        wdetail.benname  COLUMN-LABEL "Benefit Name" 
        wdetail.n_IMPORT COLUMN-LABEL "Import"
        wdetail.n_export COLUMN-LABEL "Export"
        wdetail.drivnam  COLUMN-LABEL "Driver Name"
        wdetail.producer COLUMN-LABEL "Producer"
        wdetail.agent    COLUMN-LABEL "Agent"
        wdetail.comment  FORMAT "x(35)" COLUMN-BGCOLOR  80 COLUMN-LABEL "Comment"
        WDETAIL.WARNING  COLUMN-LABEL "Warning"
        wdetail.cancel   COLUMN-LABEL "Cancel"
        wdetail.renpol   COLUMN-LABEL "Renew Policy"
        wdetail.compul   COLUMN-LABEL "Compulsory"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 131 BY 4.43
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .57.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 2.67 COL 28.17 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 2.67 COL 56.17 COLON-ALIGNED NO-LABEL
     fi_camaign AT ROW 2.67 COL 73.5 COLON-ALIGNED NO-LABEL
     fi_camaign2 AT ROW 2.67 COL 106.17 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.67 COL 28.17 COLON-ALIGNED NO-LABEL
     fi_matmodel AT ROW 3.67 COL 106.17 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 4.71 COL 106.17 COLON-ALIGNED NO-LABEL
     fi_producer1 AT ROW 4.71 COL 25.33 COLON-ALIGNED NO-LABEL
     fi_Agent1 AT ROW 5.71 COL 25.33 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.67 COL 15.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_producer2 AT ROW 6.76 COL 25.33 COLON-ALIGNED NO-LABEL
     fi_agent2 AT ROW 7.76 COL 25.33 COLON-ALIGNED NO-LABEL
     fi_no_mn30 AT ROW 9.95 COL 29.67 COLON-ALIGNED NO-LABEL
     ra_typefile AT ROW 9.95 COL 58.33 NO-LABEL
     fi_filename AT ROW 11.05 COL 25 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 11.1 COL 87.33
     buok AT ROW 12.67 COL 96
     fi_prevbat AT ROW 8.86 COL 25 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 8.86 COL 57.17 COLON-ALIGNED NO-LABEL
     fi_output1 AT ROW 12.1 COL 25 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 13.14 COL 25 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 14.19 COL 25 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 15.24 COL 25 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 15.24 COL 63.17 NO-LABEL
     bu_exit AT ROW 14.62 COL 96.33
     br_wdetail AT ROW 17.71 COL 1.5
     fi_brndes AT ROW 3.67 COL 39.5 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 3.67 COL 36.83
     fi_impcnt AT ROW 22.67 COL 57.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpacno2 AT ROW 6.76 COL 41.33
     bu_hpacno-3 AT ROW 4.71 COL 41.5
     fi_proname2 AT ROW 6.71 COL 44.17 COLON-ALIGNED NO-LABEL
     fi_proname1 AT ROW 4.71 COL 44.17 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.71 COL 57.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.67 COL 94.33 NO-LABEL NO-TAB-STOP 
     fi_agentname1 AT ROW 5.71 COL 44.17 COLON-ALIGNED NO-LABEL
     fi_agentname2 AT ROW 7.76 COL 44.17 COLON-ALIGNED NO-LABEL
     bu_hpacno-5 AT ROW 5.76 COL 41.33
     fi_premsuc AT ROW 23.71 COL 92.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpacno-6 AT ROW 7.76 COL 41.17
     fi_process AT ROW 16.33 COL 25 COLON-ALIGNED NO-LABEL
     "                    Branch  :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 3.67 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TieS 4 01/03/2022":60 VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 16.24 COL 93.5 WIDGET-ID 2
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 11.05 COL 3.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 22.57 COL 57.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 8.91 COL 46
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "       Producer  Code G2:" VIEW-AS TEXT
          SIZE 24.33 BY .95 AT ROW 6.76 COL 2.17
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 15.24 COL 3.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Brand  :" VIEW-AS TEXT
          SIZE 11.33 BY .95 AT ROW 4.71 COL 96.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY .95 AT ROW 23.71 COL 92.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "NO-MN30 ������ͧ��¡�͡������:" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 9.95 COL 2.17
          BGCOLOR 2 FGCOLOR 7 
     "Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 14.19 COL 3.67
          BGCOLOR 8 FGCOLOR 1 
     "Brand / Model  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.67 COL 91.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Load Text File Renew NISSAN [LOCKTON]" VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.29 COL 2
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 22.67 COL 57.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 23.71 COL 112.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 21.33 BY .95 AT ROW 8.86 COL 5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                 Load Date :":35 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 2.67 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 2.67 COL 46.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 15.24 COL 80.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "       Producer  Code :" VIEW-AS TEXT
          SIZE 21.5 BY .95 AT ROW 4.71 COL 4.83
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY .95 AT ROW 22.67 COL 92.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.67 COL 5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Campaign :" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 2.67 COL 64.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 12.1 COL 3.67
          BGCOLOR 8 FGCOLOR 1 
     "Agent Code :" VIEW-AS TEXT
          SIZE 13.17 BY .95 AT ROW 5.76 COL 13.17
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "Agent Code G2:" VIEW-AS TEXT
          SIZE 15.17 BY .95 AT ROW 7.81 COL 10.67
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 15.24 COL 39.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Campaign Load :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 2.67 COL 91.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 13.14 COL 3.67
          BGCOLOR 8 FGCOLOR 1 
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 22.67 COL 112.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.57 COL 1
     RECT-373 AT ROW 17.57 COL 1
     RECT-375 AT ROW 22.52 COL 1
     RECT-379 AT ROW 12.29 COL 93.5
     RECT-380 AT ROW 14.24 COL 93.5
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
         TITLE              = "Load Text file Renew Lockton (wgwnsren.w)"
         HEIGHT             = 24
         WIDTH              = 132.67
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
/* BROWSE-TAB br_wdetail bu_exit fr_main */
ASSIGN 
       br_wdetail:COLUMN-RESIZABLE IN FRAME fr_main       = TRUE.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agentname1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_agentname2 IN FRAME fr_main
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
/* SETTINGS FOR FILL-IN fi_proname1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname2 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY .95 AT ROW 22.57 COL 57.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY .95 AT ROW 22.67 COL 57.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY .95 AT ROW 22.67 COL 92.33 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY .95 AT ROW 23.71 COL 92.5 RIGHT-ALIGNED         */

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
ON END-ERROR OF c-Win /* Load Text file Renew Lockton (wgwnsren.w) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text file Renew Lockton (wgwnsren.w) */
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
          wdetail.redbook:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.poltyp:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_branch:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.policy:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.tiname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.insnam:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.comdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.expdat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.addr1:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.prempa:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.subclass:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.brand:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.model:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.engcc:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
          wdetail.tons:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.seat:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.body:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.stk:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.covcod:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.vehreg:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.eng:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.chasno:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.caryear:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.vehuse:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.garage:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.si:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
          /*wdetail.volprem:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.*/   
          wdetail.fleet:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.     
          wdetail.deductpd:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.benname:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.n_IMPORT:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_export:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.drivnam :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.producer:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.agent:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.comment:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          WDETAIL.WARNING:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.cancel:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. /*new add*/                 
          wdetail.renpol:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.compul:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          
          /*wdetail.entdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.enttim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trandat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trantim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. *//*a490166*/ 
          wdetail.redbook:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.poltyp:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_branch:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.tiname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.insnam:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.expdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.    
          wdetail.addr1:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.prempa:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.subclass:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.brand:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.model:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.engcc:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.tons:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.seat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.body:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.stk:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.covcod:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehreg:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.eng:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.chasno:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.caryear:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehuse:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.garage:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.si:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          /*wdetail.volprem:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. */ 
          wdetail.fleet:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductpd:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.benname:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_IMPORT:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_export:FGCOLOR IN BROWSE BR_WDETAIL = s  NO-ERROR.  
          wdetail.drivnam:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.producer:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.agent:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comment:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          WDETAIL.WARNING:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.cancel:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.     /*new add*/
          wdetail.renpol:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
          wdetail.compul:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
          
          END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    IF ra_typefile = 2 THEN RUN proc_matchpolicy .
    ELSE DO:
        
    ASSIGN
        fi_completecnt:FGCOLOR = 2
        fi_premsuc:FGCOLOR     = 2 
        fi_bchno:FGCOLOR       = 2
        fi_completecnt         = 0
        fi_premsuc             = 0
        fi_bchno               = ""
        fi_premtot             = 0
        fi_impcnt              = 0
        fi_process             = "Load Text file NISSAN ".
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot fi_process WITH FRAME fr_main.
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
            uzm700.acno    = TRIM(fi_producer2) AND
            uzm700.branch  = TRIM(nv_batbrn)    NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:   
            nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102     WHERE 
                uzm701.bchyr   = nv_batchyr         AND
                uzm701.bchno   = trim(fi_producer2) + TRIM(nv_batbrn) + string(nv_batrunno,"9999")  NO-LOCK NO-ERROR.
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
        nv_batchno = CAPS(fi_producer2) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END.
    ELSE DO:  
        nv_batprev = INPUT fi_prevbat.
        FIND LAST uzm701 USE-INDEX uzm70102 
            WHERE uzm701.bchyr   = nv_batchyr        AND
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
    ASSIGN
        fi_loaddat   = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
        fi_producer2  = INPUT fi_producer2   /* fi_agent        = INPUT fi_agent */
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
    RUN proc_assign. 
    FOR EACH wdetail:
        IF WDETAIL.POLTYP = "v70" OR WDETAIL.POLTYP = "v72" THEN DO:
            ASSIGN
                nv_reccnt      =  nv_reccnt   + 1
                nv_netprm_t    =  nv_netprm_t + decimal(wdetail.premt)
                wdetail.pass  = "Y". 
        END.
        ELSE DO :  
            DELETE WDETAIL.
        END.
    END. 
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    /* comment by :A64-0138...
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
    ...end A64-0138..**/
    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                           INPUT            nv_batchyr ,     /* INT   */
                           INPUT            fi_producer2,     /* CHAR  */ 
                           INPUT            nv_batbrn  ,     /* CHAR  */
                           INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                           INPUT            "WGWNSGEN" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem       /* DECI  */
                           ).
    ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.

    RUN proc_chktest1.  

    FOR EACH wdetail  WHERE wdetail .pass = "y"  NO-LOCK:
        ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + decimal(wdetail.premt). 
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
        ASSIGN nv_netprm_t  = nv_netprm_s
        nv_batflg = YES.
    /*MESSAGE "Total net premium is not match to Total net premium !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE 
        nv_batflg = YES.
    FIND LAST uzm701 USE-INDEX uzm70102  
        WHERE uzm701.bchyr  = nv_batchyr  AND
              uzm701.bchno  = nv_batchno  AND
              uzm701.bchcnt = nv_batcnt   NO-ERROR.
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
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    IF nv_batflg = NO  THEN DO:  
        ASSIGN  fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno    :FGCOLOR = 6. 
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
    /*FOR EACH wdetail:
        ASSIGN wdetail.pass = wdetail.pass.
    END.*/
RUN   proc_open.    
DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
RUN proc_report1 .   
RUN PROC_REPORT2 .
RUN proc_screen  . 
FOR EACH wcam.
       DELETE wcam.
END.
RUN proc_createcam.
OPEN QUERY br_cam FOR EACH wcam.
    /*disp  fi_casemodel  with frame  fr_main.*/
END.
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
    DEFINE VARIABLE OKpressed     AS LOGICAL INITIAL TRUE.
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
         IF ra_typefile = 1 THEN
             ASSIGN
             fi_filename  = cvData
             fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
             fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
             fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
         ELSE  
             ASSIGN
                 fi_filename = cvData
                 fi_output1  = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + "_matpol.slk" /*.csv*/
                 fi_output2  = ""
                 fi_output3  = "".  /*txt*/

         DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.

    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno-3 c-Win
ON CHOOSE OF bu_hpacno-3 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno, /*a490166 note modi*/ /*28/11/2006*/
                    output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer1 =  n_acno.
     
     disp  fi_producer2  with frame  fr_main.

     Apply "Entry"  to  fi_producer1.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno-5 c-Win
ON CHOOSE OF bu_hpacno-5 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno, /*a490166 note modi*/ /*28/11/2006*/
                    output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_agent1 =  n_acno.
     
     disp  fi_agent1  with frame  fr_main.

     Apply "Entry"  to  fi_agent1.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno-6 c-Win
ON CHOOSE OF bu_hpacno-6 IN FRAME fr_main
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


&Scoped-define SELF-NAME bu_hpacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno2 c-Win
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


&Scoped-define SELF-NAME bu_hpbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn c-Win
ON CHOOSE OF bu_hpbrn IN FRAME fr_main
DO:
   Run  whp\whpbrn01(Input-output  fi_branch, /*a490166 note modi*/
                     Input-output   fi_brndes).
                                     
   Disp  fi_branch  fi_brndes  with frame  fr_main.                                     
   Apply "Entry"  To  fi_producer2.
   Return no-apply.                            
                                        

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Agent1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Agent1 c-Win
ON LEAVE OF fi_Agent1 IN FRAME fr_main
DO:
    fi_agent1  =  CAPS(Input fi_agent1) .
   
    IF  fi_agent1 <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_agent1  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_agent1.
            RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO:
            ASSIGN
                fi_agentname1 =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_agent1 =  caps(INPUT  fi_agent1) . /*note modi 08/11/05*/
        END.
    END.
    Disp  fi_agent1  fi_agentname1  WITH Frame  fr_main.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent2 c-Win
ON LEAVE OF fi_agent2 IN FRAME fr_main
DO:
    fi_agent2  =  CAPS(Input fi_agent2) .
    
    IF  fi_agent2 <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_agent2  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_agent2.
            RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO:
            ASSIGN
                fi_agentname2 =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_agent2 =  caps(INPUT  fi_agent2) . /*note modi 08/21/05*/
        END.
    END.
    Disp  fi_agent2  fi_agentname2  WITH Frame  fr_main.  
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


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand c-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
    fi_brand  =  Input  fi_brand.
    Disp  fi_brand  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camaign c-Win
ON LEAVE OF fi_camaign IN FRAME fr_main
DO:
    fi_camaign  =  Input  fi_camaign.
    Disp  fi_camaign  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camaign2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camaign2 c-Win
ON LEAVE OF fi_camaign2 IN FRAME fr_main
DO:
    fi_camaign2  =  Input  fi_camaign2.
    Disp  fi_camaign2  with  frame  fr_main.
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


&Scoped-define SELF-NAME fi_matmodel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_matmodel c-Win
ON LEAVE OF fi_matmodel IN FRAME fr_main
DO:
    fi_matmodel  =  Input fi_matmodel.
    Disp  fi_matmodel  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_no_mn30
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_no_mn30 c-Win
ON LEAVE OF fi_no_mn30 IN FRAME fr_main
DO:
  fi_no_mn30 = INPUT fi_no_mn30.
  DISP fi_no_mn30 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output1 c-Win
ON LEAVE OF fi_output1 IN FRAME fr_main
DO:
    fi_output1 = INPUT fi_output1.
    DISP fi_output1 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_producer1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer1 c-Win
ON LEAVE OF fi_producer1 IN FRAME fr_main
DO:
    fi_producer1 = INPUT fi_producer1  .
    IF  fi_producer1 <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_producer1  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_producer1.
            RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO:
            ASSIGN
                fi_proname1 =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer1 =  caps(INPUT  fi_producer1) /*note modi 08/11/05*/
                nv_producer = fi_producer1 .             /*note add  08/11/05*/
        END.
    END.
    Disp  fi_producer1  fi_proname1  WITH Frame  fr_main.   
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer2 c-Win
ON LEAVE OF fi_producer2 IN FRAME fr_main
DO:
    fi_producer2 = INPUT fi_producer2  .
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
                fi_proname2  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer2 =  caps(INPUT  fi_producer2) /*note modi 08/11/05*/
                nv_producer  = fi_producer2 .             /*note add  08/11/05*/
        END.
    END.
    Disp  fi_producer2  fi_proname2  WITH Frame  fr_main.   
    
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
        /*fi_filename = ""*/
        fi_output1  = ""
        fi_output2  = ""
        fi_output3  = "".   
    IF ra_typefile = 2 THEN DO:
        IF fi_filename <> ""  THEN 
            fi_output1 = IF INDEX(fi_filename,".csv") <> 0 THEN
                         SUBSTR(fi_filename,1,INDEX(fi_filename,".csv") - 1 ) + "_matpol.slk" ELSE "".
    END.
    DISP 
        ra_typefile 
        fi_filename
        fi_output1 
        fi_output2 
        fi_output3 
        WITH FRAM fr_main.
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
  
  gv_prgid = "Wgwnsren".
  gv_prog  = "Load Text & Generate NISSAN".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).  /*28/11/2006*/
  ASSIGN
      ra_typefile   = 1
      /*fi_pack       = "Z"*/       /*a64-0138*/
      fi_pack       = "T"           /*a64-0138*/
      fi_camaign    = "C56/00001"
      fi_camaign2   = "CAM_NISSAN"
      fi_matmodel   = "Model_nis"  /*Kridtiya i. A58-0014*/
      fi_brand      = "NISSAN"
      fi_branch     = "W"
      fi_producer1    = "B3W0016"
      fi_producer2    = "B3W0020"
      fi_agent1       = "B3W0016"
      fi_agent2       = "B3W0020"
      /*fi_campaignno2  = "�Թʴ"
      fi_campaignno   = "NMT"*/
      fi_no_mn30      = "142,215,236"
      /*fi_agent      = "B3W0024"*/
      fi_bchyr      = YEAR(TODAY) .

  RUN proc_detail.
  /*FOR EACH wcam.
       DELETE wcam.
  END.*/
  /*RUN proc_createcam.
  OPEN QUERY br_cam FOR EACH wcam.
  disp  fi_casemodel  with frame  fr_main.*/
  DISP ra_typefile  /*fi_campaignno2*/ fi_pack fi_camaign fi_camaign2 fi_brand fi_branch  /*fi_producercash*/
      /*fi_producer fi_model1   fi_proslyphy  fi_model2 */
       fi_matmodel   /*Kridtiya i. A58-0014*/
       fi_no_mn30 fi_producer2  fi_agent2 /*fi_campaignno*/ fi_producer1  fi_agent1 fi_bchyr WITH FRAME fr_main.
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
  DISPLAY fi_loaddat fi_pack fi_camaign fi_camaign2 fi_branch fi_matmodel 
          fi_brand fi_producer1 fi_Agent1 fi_bchno fi_producer2 fi_agent2 
          fi_no_mn30 ra_typefile fi_filename fi_prevbat fi_bchyr fi_output1 
          fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt 
          fi_proname2 fi_proname1 fi_completecnt fi_premtot fi_agentname1 
          fi_agentname2 fi_premsuc fi_process 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE fi_loaddat fi_pack fi_camaign fi_camaign2 fi_branch fi_matmodel 
         fi_brand fi_producer1 fi_Agent1 fi_producer2 fi_agent2 fi_no_mn30 
         ra_typefile fi_filename bu_file buok fi_prevbat fi_bchyr fi_output1 
         fi_output2 fi_output3 fi_usrcnt fi_usrprem bu_exit br_wdetail bu_hpbrn 
         bu_hpacno2 bu_hpacno-3 bu_hpacno-5 bu_hpacno-6 fi_process RECT-370 
         RECT-372 RECT-373 RECT-375 RECT-379 RECT-380 
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
IF     (wdetail.seat = "5") OR (wdetail.seat = "7") THEN wdetail.subclass   = "110"  .
ELSE IF wdetail.seat = "3"  THEN  wdetail.subclass   = "140A"  .
ELSE IF wdetail.seat = "12" THEN  wdetail.subclass   = "120A".
ELSE    wdetail.subclass   = "110".
IF  wdetail.n_branch = " " THEN 
    ASSIGN
    wdetail.comment = wdetail.comment + "| �Ң��繤����ҧ �������ö������������ʴ�������ա����"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".

IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| poltyp �� v72 Compulsory ��ͧ�� y" 
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N". 
    IF wdetail.stk <> "" AND wdetail.stk <> "0" THEN DO:  
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
FIND sicsyac.sym100 USE-INDEX sym10001  WHERE
    sicsyac.sym100.tabcod = "U013"         AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
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
IF (wdetail.subclass     =  "120A") OR (wdetail.subclass =  "120B") THEN n_sclass72 = "210".
ELSE IF wdetail.subclass =  "140A"  THEN  n_sclass72 = "320".
ELSE  n_sclass72 =  "110".

FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  wdetail.prempa + n_sclass72 NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN 
    n_ratmin   = makdes31.si_theft_p   
    n_ratmax   = makdes31.load_p   .    
ELSE ASSIGN 
    n_ratmin   = 0
    n_ratmax   = 0.
ASSIGN n_model = ""
    n_model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ")).

/*Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,n_model) <> 0              And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
        stat.maktab_fil.sclass   =     n_sclass72               AND
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        chkred           =  YES
        wdetail.redbook  =  stat.maktab_fil.modcod
        nv_modcod        =  stat.maktab_fil.modcod                                    
        nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  IF wdetail.body = "HATCHBACK" THEN "HATCHBACK" ELSE  stat.maktab_fil.body
        wdetail.tons     =  stat.maktab_fil.tons.  ranu A600-0139*/
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
         sic_bran.uwm301.tariff     = TRIM(wdetail.tariff)
         sic_bran.uwm301.covcod     = TRIM(nv_covcod)
         sic_bran.uwm301.cha_no     = TRIM(wdetail.chasno)
         sic_bran.uwm301.eng_no     = TRIM(wdetail.eng)
         sic_bran.uwm301.Tons       = INTEGER(wdetail.tons)
         sic_bran.uwm301.engine     = INTEGER(wdetail.engcc)
         sic_bran.uwm301.yrmanu     = INTEGER(wdetail.caryear)
         sic_bran.uwm301.garage     = trim(wdetail.garage)
         sic_bran.uwm301.body       = trim(wdetail.body)
         sic_bran.uwm301.seats      = INTEGER(wdetail.seat)
         sic_bran.uwm301.mv_ben83   = trim(wdetail.benname)
         sic_bran.uwm301.vehreg     = trim(wdetail.vehreg) 
         sic_bran.uwm301.yrmanu     = inte(wdetail.caryear)
         sic_bran.uwm301.vehuse     = trim(wdetail.vehuse)
         sic_bran.uwm301.moddes     = trim(wdetail.brand) + " " + trim(wdetail.model)     
         sic_bran.uwm301.modcod     = trim(wdetail.redbook) 
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
                 /*wdetail.model          =  stat.maktab_fil.moddes*/
                 sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
                 sic_bran.uwm301.moddes =  trim(wdetail.brand) + " " + trim(wdetail.model)   /*stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/
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
                 sic_bran.uwm301.moddes  =  trim(wdetail.brand) + " " + trim(wdetail.model)   /*stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/
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
     ASSIGN  wdetail.premt = string(TRUNCATE(((deci(wdetail.premt)  * 100 ) / 107.43),0)) 
         sic_bran.uwd132.bencod  = "COMP"                 /*Benefit Code*/
         sic_bran.uwd132.benvar  = ""                     /*Benefit Variable*/
         sic_bran.uwd132.rate    = 0                      /*Premium Rate %*/
         sic_bran.uwd132.gap_ae  = NO                     /*GAP A/E Code*/
         sic_bran.uwd132.gap_c   = deci(wdetail.premt)    /*deci(wdetail.premt)*//*GAP, per Benefit per Item*/
         sic_bran.uwd132.dl1_c   = 0                      /*Disc./Load 1,p. Benefit p.Item*/
         sic_bran.uwd132.dl2_c   = 0                      /*Disc./Load 2,p. Benefit p.Item*/
         sic_bran.uwd132.dl3_c   = 0                      /*Disc./Load 3,p. Benefit p.Item*/
         sic_bran.uwd132.pd_aep  = "E"                    /*Premium Due A/E/P Code*/
         sic_bran.uwd132.prem_c  = deci(wdetail.premt)    /*PD, per Benefit per Item*/
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
                        wdetail.premt          = string(sicsyac.xmm106.baseap) 
                       /* sic_bran.uwd132.gap_c  = deci(wdetail.premt)
                        sic_bran.uwd132.prem_c = deci(wdetail.premt)*/
                        nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                        nv_gap                 = deci(wdetail.premt)
                        nv_prem                = deci(wdetail.premt) .
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
                    ASSIGN 
                    /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.*/
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap
                    wdetail.premt          = string(sicsyac.xmm106.baseap)
                    sic_bran.uwd132.gap_c  = deci(wdetail.premt).
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                               RECID(sic_bran.uwd132),
                                               sic_bran.uwm301.tariff).
                    ASSIGN nv_gap  = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem    = nv_prem + sic_bran.uwd132.prem_c
                        nv_gap     = deci(wdetail.premt)
                        nv_prem    = deci(wdetail.premt).
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
                        ASSIGN    
                            sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                        sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap 
                            wdetail.premt          = string(sicsyac.xmm106.baseap) 
                            sic_bran.uwd132.gap_c  = deci(wdetail.premt)
                            sic_bran.uwd132.prem_c = deci(wdetail.premt)
                            nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                            nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                            nv_gap                 = deci(wdetail.premt)
                            nv_prem                = deci(wdetail.premt).
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
                        /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.*/
                        ASSIGN sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap
                        wdetail.premt          = string(sicsyac.xmm106.baseap) 
                        sic_bran.uwd132.gap_c  = deci(wdetail.premt).
                        RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                                   RECID(sic_bran.uwd132),
                                                   sic_bran.uwm301.tariff).
                        nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                        nv_gap        = deci(wdetail.premt).
                        nv_prem       = deci(wdetail.premt).
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
                    ASSIGN  sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                        sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap
                        sic_bran.uwd132.gap_c  = deci(wdetail.premt)
                        sic_bran.uwd132.prem_c = deci(wdetail.premt)
                        nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                        nv_gap                 = deci(wdetail.premt)
                        nv_prem                = deci(wdetail.premt).
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
                    /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.   */
                    ASSIGN 
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap
                        wdetail.premt   = string(sicsyac.xmm106.baseap)
                    sic_bran.uwd132.gap_c  = deci(wdetail.premt).
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100),         
                                         RECID(sic_bran.uwd132),                
                                         sic_bran.uwm301.tariff).
                    ASSIGN
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c
                    nv_gap        = deci(wdetail.premt)
                    nv_prem       = deci(wdetail.premt).
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
  Notes:       
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
        RUN proc_assigninit.
        IMPORT DELIMITER "|" 
             np_no                  /*NO              */ 
             np_cedpol              /*RefNo           */      
             np_senddate            /*ClosingDate     */      
             np_ntitle              /*ClientTitle     */      
             np_insurcename         /*ClientName      */      
             np_insurceno           /*ClientCode      */      
             np_addr1               /*ClientAddress1  */      
             np_addr2               /*ClientAddress2  */      
             np_Brand               /*Brand           */      
             np_model               /*Model           */      
             np_vehreg              /*CarID           */      
             np_caryear             /*RegisterYear    */      
             np_cha_no              /*ChassisNo       */      
             np_engno               /*EngineNo        */      
             np_engCC               /*CC              */      
             np_benname             /*Beneficiary     */      
             np_oldpol              /*OldPolicyNo     */      
             np_stkno               /*CMIStickerNo    */      
             np_pol72               /*CMIPolicyNo     */      
             np_garage              /*Garage          */      
             np_covcod              /*InsureType      */      
             np_drive1              /*Driver1         */ 
             np_bdate1  
             np_id1     
             np_drive2              /*Driver2         */ 
             np_bdate2  
             np_id2     
             np_comdate             /*VMIStartDate    */      
             np_expdate             /*VMIEndDate      */      
             np_comdate72           /*CMIStartDate    */      
             np_expdate72           /*CMIEndDate      */      
             np_si                  /*SumInsured      */      
             np_premt               /*VMITotalPremium */      
             np_premtcomp           /*CMITotalPremium */      
             np_total               /*TotalPremium    */      
             np_deduct              /*FirstOD         */      
             np_deduct2             /*FirstTPPD       */      
             np_tper                /*TPBIPerson      */      
             np_tpbi                /*TPBITime        */      
             np_tppd                /*TPPD            */      
             np_si1                 /*OD              */      
             np_fire                /*FT              */      
             np_41                  /*RY01            */      
             np_42                  /*RY02            */      
             np_43                  /*RY03            */      
             np_feet                /*DiscountGroup   */      
             np_ncb                 /*DiscountHistory */      
             np_other               /*DiscountOther   */      
             np_seats               /*Seat            */      
             np_remark              /*RemarkInsurer1  */      
             np_remark2             /*RemarkInsurer2  */      
             np_remark3             /*RemarkInsurer3  */      
             np_contractno          /*ContractNo      */      
             np_user                /*UserClosing     */      
             np_policy              /*PolicyNo        */      
             np_tempol              /*TempPolicyNo    */      
             np_campaign            /*Campaign        */ 
             np_icno                /*icno*/        /*A60-0272*/
             np_paiddat             /*Paid Date       */      
             np_typepaid            /*DN/CN           */      
             np_paidno              /*Ref # (DN/CN)   */      
             np_remarkpaid          /*Remark_paid     */      
             np_paidtyp             /*Paid  Type      */      
             np_br                  /*BR              */ 
             np_subclass      .

        IF np_cedpol = "" THEN NEXT.                             /* A56-0150 */
        ELSE IF INDEX(np_no,"Report") <> 0 THEN NEXT.
        ELSE IF index(np_no,"NO") <> 0 THEN NEXT.   /*A56-0243*/    
        ELSE IF TRIM(np_no) = "" THEN NEXT. /*a60-0272*/
        ELSE DO:
            /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
            RUN proc_assign2addr (INPUT  trim(np_addr1) + " " + TRIM(np_addr2)
                                 ,INPUT  ""  
                                 ,INPUT  "" 
                                 ,INPUT  ""  
                                 ,OUTPUT np_codeocc   
                                 ,OUTPUT np_codeaddr1 
                                 ,OUTPUT np_codeaddr2 
                                 ,OUTPUT np_codeaddr3).
            IF np_postcd <> "" THEN DO:  
                IF      INDEX(np_addr2,np_postcd) <> 0 THEN np_addr2 = trim(REPLACE(np_addr2,np_postcd,"")).
                ELSE IF INDEX(np_addr1,np_postcd) <> 0 THEN np_addr1 = trim(REPLACE(np_addr1,np_postcd,"")). 
            END.
            RUN proc_matchtypins (INPUT  trim(np_ntitle)                                   
                                 ,INPUT  trim(np_insurcename) + " " + trim(np_insurceno) 
                                 ,OUTPUT np_insnamtyp
                                 ,OUTPUT np_firstName
                                 ,OUTPUT np_lastName).
            /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
            IF deci(np_premt)      > 0  THEN RUN proc_assignwdetail.
            IF DECI(np_premtcomp ) > 0  THEN RUN proc_assign72.
        END.
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
DEF VAR ind1 AS INTE.
DEF VAR ind2 AS INTE.
DEF VAR ind3 AS INTE.
DEF VAR ind4 AS INTE. 
DEF VAR n_char  AS CHAR FORMAT  "x(75)".
DEF VAR n_soy   AS CHAR FORMAT  "x(75)".
DEF VAR n_road  AS CHAR FORMAT  "x(75)".
DEF VAR n_nam11 AS CHAR FORMAT "x(75)".
FOR EACH wdetail WHERE wdetail.policy  NE " "  .
    ASSIGN 
        ind1         = 0 
        ind2         = 0
        ind3         = 0
        ind4         = 0
        n_char       = ""
        n_nam11      = "" .
        /*wdetail.expdat  = string(DAY(DATE(wdetail.comdat)))   + "/" + 
                          string(MONTH(DATE(wdetail.comdat))) + "/" + 
                          string((YEAR(DATE(wdetail.comdat))) + 1 )
        wdetail.poltyp  = IF wdetail.covcod = "T" THEN "V72" ELSE "V70"  .
    IF index(wdetail.insnam,"���/����") <> 0 THEN DO: 
        IF INDEX(wdetail.insnam,"[") <> 0 THEN
            ASSIGN  
            wdetail.insnam  = trim(substr(wdetail.insnam,1,index(wdetail.insnam,"���/����") - 1)) +  " " +
                      trim(substr(wdetail.insnam2,index(wdetail.insnam2,"["))) 
            n_nam11         = IF INDEX(wdetail.insnam," ") <> 0 THEN trim(SUBSTR(wdetail.insnam,1,INDEX(wdetail.insnam," "))) ELSE wdetail.insnam  /* A57-0432 */
            wdetail.insnam2 = trim(substr(wdetail.insnam2,index(wdetail.insnam2,"���/����"),index(wdetail.insnam2,"[") - 1 ))
            wdetail.insnam2 = trim(substr(wdetail.insnam2,1,index(wdetail.insnam2,"[") - 1 ))  
            wdetail.insnam2 = "(" + replace(wdetail.insnam2,"�������","") + ")"  . /* A57-0432 */
        /*wdetail.insnam3 = "���/���� ����ѷ ����ѹ ������(�������) �ӡѴ". */  /* A57-0432 */
        IF INDEX(wdetail.insnam3,n_nam11) <> 0 THEN ASSIGN wdetail.insnam3 = "".   /* A57-0432 */
    END.
    ELSE IF   index(wdetail.insnam,"�������") <> 0 THEN DO: 
        IF INDEX(wdetail.insnam,"[") <> 0 THEN
            ASSIGN  
            wdetail.insnam  = trim(substr(wdetail.insnam,1,index(wdetail.insnam,"�������") - 1)) +  " " +
                      trim(substr(wdetail.insnam2,index(wdetail.insnam2,"["))) 
            n_nam11         = IF INDEX(wdetail.insnam," ") <> 0 THEN trim(SUBSTR(wdetail.insnam,1,INDEX(wdetail.insnam," "))) ELSE wdetail.insnam  /* A57-0432 */
            wdetail.insnam2 = trim(substr(wdetail.insnam2,index(wdetail.insnam2,"�������"),index(wdetail.insnam2,"[") - 1 ))
            wdetail.insnam2 = trim(substr(wdetail.insnam2,1,index(wdetail.insnam2,"[") - 1 ))
            wdetail.insnam2 = "(" + replace(wdetail.insnam2,"�������","") + ")"  . /* A57-0432 */
        IF INDEX(wdetail.insnam3,n_nam11) <> 0 THEN ASSIGN wdetail.insnam3 = "".   /* A57-0432 */
        /*wdetail.insnam3 = "���/���� ����ѷ ����ѹ ������(�������) �ӡѴ". */  /* A57-0432 */
    END.  
    ELSE DO:
        ASSIGN 
            n_nam11         = IF INDEX(wdetail.insnam," ") <> 0 THEN trim(SUBSTR(wdetail.insnam,1,INDEX(wdetail.insnam," "))) ELSE wdetail.insnam  /* A57-0432 */
            wdetail.insnam2 = "" 
            /*wdetail.insnam3 = ""*/  .
        IF INDEX(wdetail.insnam3,n_nam11) <> 0 THEN 
            ASSIGN wdetail.insnam2 = "" 
                   wdetail.insnam3 = "".
        ELSE
            ASSIGN wdetail.insnam2 = "���/���� " + trim(wdetail.insnam3)    /* A57-0432 */
                   wdetail.insnam3 = ""  .   /* A57-0432 */
            /*wdetail.insnam2 = "���/���� ����ѷ ����ѹ ������(�������) �ӡѴ" .*/ /* A57-0432 */
    END.*/
    /*IF index(wdetail.model,"navara") <> 0  THEN DO: 
        IF INDEX(wdetail.model,"D/C") <> 0  THEN
            ASSIGN wdetail.subclass   = "110" 
            wdetail.model = "FRONTIER NAVARA".
        ELSE IF INDEX(wdetail.model,"K/C") <> 0  THEN
            ASSIGN wdetail.subclass   = "320" 
            wdetail.model = "FRONTIER NAVARA".
    END.
    ELSE DO:

        ASSIGN wdetail.model = TRIM(SUBSTRING(wdetail.model,1,INDEX(wdetail.model," "))).
        IF     (wdetail.seat = "5") OR (wdetail.seat = "7") THEN wdetail.subclass   = "110"  .
        ELSE IF wdetail.seat = "3"  THEN  wdetail.subclass   = "320"  .
        ELSE IF wdetail.seat = "12" THEN  wdetail.subclass   = "210".
        ELSE    wdetail.subclass   = "110".
    END.
    IF     (wdetail.seat = "5") OR (wdetail.seat = "7") THEN wdetail.subclass   = "110"  .
    ELSE IF wdetail.seat = "3"  THEN  wdetail.subclass   = "320"  .
    ELSE IF wdetail.seat = "12" THEN  wdetail.subclass   = "210".
    ELSE    wdetail.subclass   = "110".
            */
    IF (wdetail.vehreg = "") OR (INDEX(wdetail.vehreg,"����ᴧ") <> 0 ) THEN 
        wdetail.vehreg = "/" +  SUBSTRING(wdetail.chasno,LENGTH(wdetail.chasno) - 8) . 
    /*ELSE DO:  /*vehreg + provin....*/
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
            brstat.insure.compno = "999" AND 
            brstat.insure.FName  = TRIM(wdetail.re_country) NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN 
            ASSIGN wdetail.re_country = Insure.LName
            wdetail.vehreg = substr(wdetail.vehreg,1,7) + " " + wdetail.re_country .
        ELSE wdetail.vehreg = substr(wdetail.vehreg,1,7).
    END.*/
    FIND FIRST brstat.msgcode USE-INDEX MsgCode01 WHERE
        brstat.msgcode.MsgDesc = TRIM(wdetail.tiname)  NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode  THEN ASSIGN wdetail.tiname   = brstat.msgcode.branch.

    ASSIGN n_char =  trim(wdetail.addr1) 
        n_soy  =  ""    /*A57-0432.*/
        n_road =  "" .  /*A57-0432.*/
    IF r-INDEX(n_char,"��ا") <> 0 THEN 
        ASSIGN 
        wdetail.country = trim(SUBSTR(n_char,r-INDEX(n_char,"��ا")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"��ا") - 1 )) .
    ELSE IF r-INDEX(n_char,"���") <> 0 THEN 
        ASSIGN 
        wdetail.country = trim(SUBSTR(n_char,r-INDEX(n_char,"���")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"���") - 1 )) .
    ELSE IF r-INDEX(n_char,"�ѧ��Ѵ") <> 0 THEN 
        ASSIGN 
        wdetail.country = trim(SUBSTR(n_char,r-INDEX(n_char,"�ѧ��Ѵ")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"�ѧ��Ѵ") - 1 )) .
    ELSE IF r-INDEX(n_char,"�.") <> 0 THEN 
        ASSIGN 
        wdetail.country = trim(SUBSTR(n_char,r-INDEX(n_char,"�.")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"�.") - 1 )) .
    IF r-INDEX(n_char,"�.") <> 0 THEN 
        ASSIGN 
        wdetail.amper   = trim(SUBSTR(n_char,r-INDEX(n_char,"�.")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"�.") - 1 )) .
    ELSE IF r-INDEX(n_char,"�����") <> 0 THEN 
        ASSIGN 
        wdetail.amper   = trim(SUBSTR(n_char,r-INDEX(n_char,"�����")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"�����") - 1 )) .
    ELSE IF r-INDEX(n_char,"ࢵ") <> 0 THEN 
        ASSIGN 
        wdetail.amper   = trim(SUBSTR(n_char,r-INDEX(n_char,"ࢵ")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"ࢵ") - 1 )) .
    IF r-INDEX(n_char,"�.") <> 0 THEN 
        ASSIGN 
        wdetail.tambon  = trim(SUBSTR(n_char,r-INDEX(n_char,"�.")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"�.") - 1 )) .
    ELSE IF r-INDEX(n_char,"�Ӻ�") <> 0 THEN 
        ASSIGN 
        wdetail.tambon  = trim(SUBSTR(n_char,r-INDEX(n_char,"�Ӻ�")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"�Ӻ�") - 1 )) .
    ELSE IF r-INDEX(n_char,"�ǧ") <> 0 THEN 
        ASSIGN 
        wdetail.tambon  = trim(SUBSTR(n_char,r-INDEX(n_char,"�ǧ")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"�ǧ") - 1 )) .
    IF r-INDEX(n_char,"�.") <> 0 THEN 
        ASSIGN 
        n_soy           = trim(SUBSTR(n_char,r-INDEX(n_char,"�.")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"�.") - 1 )) .
    ELSE IF r-INDEX(n_char,"���") <> 0 THEN 
        ASSIGN 
        n_soy           = trim(SUBSTR(n_char,r-INDEX(n_char,"���")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"���") - 1 )) .
    IF r-INDEX(n_char,"�.") <> 0 THEN 
        ASSIGN 
        n_road          = trim(SUBSTR(n_char,r-INDEX(n_char,"�.")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"�.") - 1 )) .
    ELSE IF r-INDEX(n_char,"���") <> 0 THEN 
        ASSIGN 
        n_road          = trim(SUBSTR(n_char,r-INDEX(n_char,"���")))
        n_char          = trim(SUBSTR(n_char,1,r-INDEX(n_char,"���") - 1 )) .
    IF LENGTH(n_char) > 35 THEN DO:
        loop_chk1:
        REPEAT:
            IF LENGTH(n_char) > 35 THEN DO:
                ASSIGN 
                    n_soy  =  trim(trim(SUBSTR(n_char,R-INDEX(n_char," "))) + " " + TRIM(n_soy))
                    n_char =  trim(trim(SUBSTR(n_char,1,R-INDEX(n_char," ")))) .
            END.
            ELSE LEAVE loop_chk1.
        END.
    END.
    IF LENGTH(n_char + " " + n_soy + " " + n_road ) <= 35 THEN DO:
        ASSIGN 
            n_char        = TRIM(n_char + " " + n_soy )
            n_char        = TRIM(n_char + " " + n_road )
            wdetail.addr1 = n_char.
        IF LENGTH(wdetail.tambon + " " + wdetail.amper) <= 35 THEN
            ASSIGN 
            wdetail.tambon  = wdetail.tambon + " " + wdetail.amper
            wdetail.amper   = wdetail.country
            wdetail.country = "".
        ELSE IF LENGTH(wdetail.amper + " " + wdetail.country) <= 35 THEN
            ASSIGN 
            wdetail.amper   = wdetail.amper + " " + wdetail.country
            wdetail.country = "".
    END.
    ELSE IF LENGTH(n_char + " " + n_soy ) <= 35 THEN DO:
        ASSIGN 
            n_char          = TRIM(n_char + " " + n_soy )
            wdetail.addr1   = trim(n_char).
        IF LENGTH(wdetail.addr1 + " " + n_road) <= 35 THEN
            ASSIGN wdetail.addr1   = TRIM(wdetail.addr1 + " " + n_road)
                   n_road          = "".
        IF LENGTH(n_road + " " + wdetail.tambon + " " + wdetail.amper) <= 35 THEN
            ASSIGN 
            wdetail.tambon  = n_road + " " + wdetail.tambon + " " + wdetail.amper
            wdetail.amper   = wdetail.country
            wdetail.country = "".
        ELSE IF LENGTH(n_road + " " + wdetail.tambon) <= 35 THEN
            ASSIGN 
            wdetail.tambon  = n_road + " " + wdetail.tambon
            wdetail.amper   = wdetail.amper + " " + wdetail.country
            wdetail.country = "".
    END.
    ELSE DO:
        ASSIGN wdetail.addr1   = n_char.
        IF LENGTH(n_soy + " " + n_road + " " + wdetail.tambon ) <= 35 THEN
            ASSIGN 
            wdetail.tambon  = n_soy + " " + n_road + " " + wdetail.tambon 
            wdetail.amper   = wdetail.amper + " " + wdetail.country
            wdetail.country = "".
        ELSE ASSIGN 
            wdetail.amper   = wdetail.tambon + " " + wdetail.amper
            wdetail.tambon  = n_soy + " " + n_road
            .
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

ASSIGN nv_address = trim(np_tambon + " " + np_mail_amper + " " + np_mail_country)  
       np_postcd  = "".

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
    np_postcd       = trim(SUBSTR(np_mail_country,index(np_mail_country," "))) 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign72 c-Win 
PROCEDURE proc_assign72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.policy  = "D72" + trim(np_cedpol)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail  THEN DO:
    CREATE wdetail .
    ASSIGN 
        wdetail.policy     = "D72" + trim(np_cedpol) /*caps(TRIM(np_pol72))*/ 
        wdetail.poltyp     = "V72"
        wdetail.cedpol     = trim(np_cedpol)
        wdetail.tiname     = trim(np_ntitle)     
        wdetail.insnam     = trim(np_insurcename) + " " + trim(np_insurceno)
        wdetail.insnam2    = trim(np_insurcename) + " " + trim(np_insurceno)
        wdetail.addr1      = trim(np_addr1) + " " + trim(np_addr2)
        wdetail.brand      = TRIM(np_brand) 
        wdetail.model      = TRIM(np_model)   
        wdetail.vehreg     = trim(np_vehreg)
        wdetail.caryear    = trim(np_caryear)
        wdetail.chasno     = trim(np_cha_no) 
        wdetail.eng        = trim(np_engno)
        wdetail.engcc      = TRIM(np_engCC) 
        wdetail.benname    = ""
        wdetail.icno       = TRIM(np_icno) /*A60-0272*/
        /*wdetail.delerno    = TRIM(np_showroomno)
        wdetail.delername  = TRIM(np_showroom2)*/
        wdetail.stk        = IF trim(np_stkno) <> "0" AND trim(np_stkno) <> ""  THEN TRIM(np_stkno) ELSE ""
        wdetail.cr_2       = IF DECI(np_total) = DECI(np_premtcomp) THEN "" ELSE  "D70" + trim(np_cedpol)
        wdetail.garage     = trim(np_garage)
        wdetail.covcod     = "T" 
        wdetail.comdat     = trim(np_comdate72)  
        wdetail.expdat     = trim(np_expdate72)  
        wdetail.firstdat   = trim(np_comdate72) 
        /*wdetail.si         = trim(np_si)      
        wdetail.fire       = trim(np_fire) */
        wdetail.premt      = string(deci(np_premtcomp))
        /*wdetail.tp1        = trim(np_tper) */  
        /*wdetail.tp2        = trim(np_tpbi) */  
        /*wdetail.tp3        = trim(np_tppd) */
        /*wdetail.NO_41      = trim(np_41)   */ 
        /*wdetail.NO_42      = trim(np_43)   */ 
        /*wdetail.NO_43      = trim(np_42)   */
       /* wdetail.fleet      = TRIM(np_feet)   */
       /* wdetail.ncb        = np_ncb          */
       /* wdetail.dspc       = np_other        */
        wdetail.seat       = np_seats       
        wdetail.remark     = trim(np_remark) 
        wdetail.vehuse     = "1"
        wdetail.tariff     = "9" 
        wdetail.compul     = "y"
        wdetail.comment    = ""
        wdetail.n_branch   = TRIM(np_br)
        /*wdetail.prempa     = "Z"   /*fi_pack*/  
        wdetail.subclass   = TRIM(np_subclass)
        wdetail.icno       = TRIM(np_icno)*/   /*A56-0243*/
        /*comment by kridtiya i.. A56-0057....
        wdetail.producer   = IF      INDEX(np_campaign,fi_campaignno) = 0 THEN fi_producer3
                             ELSE IF index(np_model,fi_model1) <> 0       THEN fi_producer  
                             ELSE IF index(np_model,fi_model2) <> 0       THEN fi_proslyphy
                             ELSE  fi_producer2             
        wdetail.agent      = IF INDEX(np_campaign,fi_campaignno) = 0 THEN fi_producer3
                             ELSE IF index(np_model,fi_model1) <> 0  THEN fi_producer  
                             /*ELSE IF index(np_model,fi_model2) <> 0  THEN fi_agent*/
                             ELSE  fi_producer2    end..by kridtiya i. A56-0057*/
        wdetail.producer   = IF trim(np_garage) = "G2" THEN TRIM(fi_producer2) ELSE trim(fi_producer1)  
        wdetail.agent      = IF trim(np_garage) = "G2" THEN TRIM(fi_producer2) ELSE trim(fi_producer1)  
        wdetail.entdat     = string(TODAY)                /*entry date*/
        wdetail.enttim     = STRING (TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat    = STRING (fi_loaddat)          /*tran date*/
        wdetail.trantim    = STRING (TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT   = "IM"
        wdetail.n_EXPORT   = ""  
        /*wdetail.br_insured = "00000" */              /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.insnamtyp  = trim(np_insnamtyp)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.firstName  = trim(np_firstName)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.lastName   = trim(np_lastName)     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.postcd     = trim(np_postcd)       /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.codeocc    = trim(np_codeocc)      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.codeaddr1  = trim(np_codeaddr1)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.codeaddr2  = trim(np_codeaddr2)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.codeaddr3  = trim(np_codeaddr3) .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
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
    np_no             = ""
    np_typepol        = ""  
    np_cedpol         = ""     
    np_senddate       = ""                                                            
    np_ntitle         = ""                                                               
    np_insurcename    = ""     
    np_insurceno      = ""   
    np_addr1          = ""                                                     
    np_addr2          = ""                                                     
    np_Brand          = ""   
    np_model          = ""                                                     
    np_vehreg         = ""                                                     
    np_caryear        = ""    
    np_cha_no         = ""                                                     
    np_engno          = ""                                                     
    np_engCC          = ""                                                     
    np_benname        = ""                                                     
    np_oldpol         = ""   
    np_stkno          = ""                                                      
    np_pol72          = ""   
    np_garage         = ""                                                      
    np_covcod         = ""                                                      
    np_drive1         = ""                                                      
    np_drive2         = ""                                                      
    np_comdate        = ""                   
    np_expdate        = ""   
    np_comdate72      = ""                       
    np_expdate72      = ""                       
    np_si             = ""                       
    np_premt          = ""                       
    np_premtcomp      = ""                        
    np_total          = ""   
    np_deduct         = ""      
    np_deduct2        = ""                                       
    np_tper           = ""                                       
    np_tpbi           = ""   
    np_tppd           = ""            
    np_si1            = ""            
    np_fire           = ""            
    np_41             = ""        
    np_42             = ""        
    np_43             = ""        
    np_feet           = ""     
    np_ncb            = ""   
    np_other          = ""           
    np_seats          = "" 
    np_remark         = ""    
    np_remark2        = ""
    np_remark3        = ""
    np_contractno     = ""
    np_user           = ""
    np_policy         = ""
    np_tempol         = ""
    np_campaign       = ""
    np_paiddat        = ""
    np_typepaid       = ""
    np_paidno         = ""
    np_remarkpaid     = ""
    np_paidtyp        = ""
    np_br             = ""
    np_icno           = ""    /*A60-0272*/    
    np_campaign_ov    = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    np_firstName      = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    np_lastName       = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    np_postcd         = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    np_codeocc        = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    np_codeaddr1      = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    np_codeaddr2      = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    np_codeaddr3      = "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignmatpol c-Win 
PROCEDURE proc_assignmatpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   comment by ranu A60-0139    
------------------------------------------------------------------------------*/
/*DEFINE  VAR nv_chkpol  AS CHAR  FORMAT "X(30)" INITIAL "" NO-UNDO.  
DEFINE  VAR nv_lnumber AS INT   NO-UNDO.
DEF VAR n_polced70   AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_polced72   AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_comdate70  AS DATE FORMAT "99/99/9999" INIT ? .
DEF VAR n_comdate72  AS DATE FORMAT "99/99/9999" INIT ? .
DEF VAR n_trndate70  AS DATE FORMAT "99/99/9999" INIT ? .        
DEF VAR n_producer   AS CHAR FORMAT "x(10)" INIT "". */         
FOR EACH wdetail.
   /* ASSIGN 
        n_polced70 = ""
        n_polced72 = ""
        n_comdate70  = ? 
        n_comdate72  = ?
        n_trndate70  = ? 
        n_producer   = "" . */   
    /*IF  wdetail.cedpol = ""   THEN DELETE wdetail.*/

      
    IF wdetail.icno <> "" AND  deci(wdetail.premt) <> 0 THEN DO:
       FIND LAST sicuw.uwm100 USE-INDEX uwm10002   WHERE 
            sicuw.uwm100.cedpol  = trim(wdetail.cedpol)   AND 
            sicuw.uwm100.poltyp  = "V70" NO-LOCK NO-ERROR .
        IF  AVAIL sicuw.uwm100   THEN DO:
                ASSIGN 
                    wdetail.policy   = sicuw.uwm100.policy.
        END.
    END.
    IF wdetail.icno <> "" AND  deci(wdetail.comprem) <> 0 THEN DO:
       FIND LAST sicuw.uwm100 USE-INDEX uwm10002   WHERE 
            sicuw.uwm100.cedpol  = trim(wdetail.cedpol)   AND 
            sicuw.uwm100.poltyp  = "V72" NO-LOCK NO-ERROR .
        IF  AVAIL sicuw.uwm100   THEN DO:
                ASSIGN 
                   wdetail.compol   = sicuw.uwm100.policy.
        END.
    END.
    /*
    IF wdetail.compol <> "" AND wdetail.poltyp = "V72" THEN DO:
        FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
            brstat.tlt.cha_no    = trim(wdetail.chasno)  AND
            brstat.tlt.eng_no    = TRIM(wdetail.eng)     AND  
            brstat.tlt.genusr    = "LOCKTON"             AND 
            brstat.tlt.expousr   = "T"      NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
            IF brstat.tlt.rec_addr5 <> "" THEN ASSIGN wdetail.comment = "������ú.�������� " + brstat.tlt.rec_addr5.
            ELSE DO:
                ASSIGN 
                    brstat.tlt.rec_addr5 = TRIM(wdetail.compol).
                    brstat.tlt.policy    = IF brstat.tlt.policy = "" THEN TRIM(wdetail.policy) ELSE brstat.tlt.policy.
                IF INDEX(brstat.tlt.releas,"YES") <> 0 THEN 
                    ASSIGN wdetail.comment = IF wdetail.comment = "" THEN "�ա���͡������������ " +  brstat.tlt.rec_addr5
                                             ELSE  wdetail.comment  + "/ " + "�ա���͡������������ " +  brstat.tlt.rec_addr5.
                ELSE IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas = "No Confirm\YES" .
                ELSE IF brstat.tlt.releas = "CONFIRM" THEN ASSIGN brstat.tlt.releas = "Confirm\YES" .
                ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN ASSIGN brstat.tlt.releas = "Cancel\YES".
            END.
        END.
    END.*/
    IF wdetail.policy <> "" OR wdetail.compol <> "" THEN DO:
        FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
            brstat.tlt.cha_no    = trim(wdetail.chasno)  AND
            brstat.tlt.eng_no    = TRIM(wdetail.eng)     AND  
            brstat.tlt.genusr    = "LOCKTON"             NO-ERROR NO-WAIT.
         IF AVAIL brstat.tlt THEN DO:
             IF brstat.tlt.policy <> "" THEN ASSIGN wdetail.comment = "��������������������� " + brstat.tlt.policy.
             IF brstat.tlt.rec_addr5 <> "" THEN ASSIGN wdetail.comment = "������ �ú.�������� " + brstat.tlt.rec_addr5.
             IF INDEX(brstat.tlt.releas,"YES") <> 0 THEN 
                    ASSIGN wdetail.comment = IF wdetail.comment = "" THEN "�ա���͡������������ " +  brstat.tlt.policy
                                             ELSE  wdetail.comment  + "/ " + "�ա���͡������������ " +  brstat.tlt.policy.
             ELSE DO:
                    ASSIGN 
                    brstat.tlt.policy    = TRIM(wdetail.policy).
                    brstat.tlt.rec_addr5 = IF brstat.tlt.rec_addr5 = "" THEN TRIM(wdetail.compol) ELSE brstat.tlt.rec_addr5.
                IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas = "NoConfirm/YES" .
                ELSE IF brstat.tlt.releas = "NoConfirm/No" THEN ASSIGN brstat.tlt.releas = "Confirm/YES" .
                ELSE IF brstat.tlt.releas = "Confirm/No" THEN ASSIGN brstat.tlt.releas = "Confirm/YES" .
                ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN DO:
                    IF index(brstat.tlt.releas,"NO") <> 0 THEN ASSIGN brstat.tlt.releas = "NoConfirm/Cancel/YES" .
                    ELSE IF index(brstat.tlt.releas,"CONFIRM") <> 0 THEN ASSIGN brstat.tlt.releas = "Confirm/Cancel/YES" .
                END.
             END.
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignredbook c-Win 
PROCEDURE proc_assignredbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
     IF wdetail.seat = "" THEN DO:
        IF wdetail.engcc = "" THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
            index(stat.maktab_fil.moddes,n_model) <> 0              And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            /*stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND*/
            stat.maktab_fil.sclass   =  trim(wdetail.subclass)         AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * nv_minSI / 100 ) LE deci(wdetail.si)     AND 
             stat.maktab_fil.si + (stat.maktab_fil.si * nv_maxSI / 100 ) GE deci(wdetail.si)  )  No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN
                ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod
                /*wdetail.brand    =  stat.maktab_fil.makdes  
                n_model    =  stat.maktab_fil.moddes*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
                /*wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn*/ /* A59-0400 */
                /*wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc*/ /*A60-0005*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
            ELSE wdetail.redbook  = "".
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
                index(stat.maktab_fil.moddes,n_model) <> 0              And
                stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
                stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
                stat.maktab_fil.sclass   =  trim(wdetail.subclass)         AND
               (stat.maktab_fil.si - (stat.maktab_fil.si * nv_minSI / 100 ) LE deci(wdetail.si)     AND 
                stat.maktab_fil.si + (stat.maktab_fil.si * nv_maxSI / 100 ) GE deci(wdetail.si)  )  No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN
                ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod
                /*wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
                /*wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn*/ /* A59-0400 */
                /*wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc*/ /*A60-0005*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
            ELSE wdetail.redbook  = "".
        END.
    END.
    ELSE DO:
        IF wdetail.engcc = "" THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
            index(stat.maktab_fil.moddes,n_model) <> 0              And
            stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
            /*stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND*/
            stat.maktab_fil.sclass   =  trim(wdetail.subclass)         AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * nv_minSI  / 100 ) LE deci(wdetail.si)     AND 
             stat.maktab_fil.si + (stat.maktab_fil.si * nv_maxSI  / 100 ) GE deci(wdetail.si)  )  AND  
            stat.maktab_fil.seats    >=    DECI(wdetail.seat)       No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN
                ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod
                /*wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
                /*wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn*/ /* A59-0400 */
                /*wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc*/ /*A60-0005*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
            ELSE wdetail.redbook  = "".
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =  trim(wdetail.brand)               And                  
                index(stat.maktab_fil.moddes,n_model) <> 0              And
                stat.maktab_fil.makyea   =  Integer(wdetail.caryear)          AND 
                stat.maktab_fil.engine   =  deci(wdetail.engcc)               AND
                stat.maktab_fil.sclass   =  trim(wdetail.subclass)         AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * nv_minSI / 100 ) LE deci(wdetail.si)     AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * nv_maxSI / 100 ) GE deci(wdetail.si)  )  AND  
                stat.maktab_fil.seats    >=    DECI(wdetail.seat)       No-lock no-error no-wait.
            If  avail stat.maktab_fil  THEN
                ASSIGN 
                wdetail.redbook  =  stat.maktab_fil.modcod
                /*wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.body     =  IF wdetail.body  = "" THEN stat.maktab_fil.body           ELSE wdetail.body
                /*wdetail.Tonn     =  IF wdetail.Tonn  = 0  THEN stat.maktab_fil.tons           ELSE wdetail.Tonn*/ /* A59-0400 */
                /*wdetail.engcc    =  IF wdetail.engcc = "" THEN STRING(stat.maktab_fil.engine) ELSE wdetail.engcc*/ /*A60-0005*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat.
            ELSE wdetail.redbook  = "".
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
DEF VAR number_sic AS INTE INIT 0.
DEF VAR n_cr2 AS CHAR FORMAT "x(20)" INIT "".
DEF VAR n_pol AS CHAR FORMAT "x(20)" INIT "".
DEFINE  VAR nre_premt      AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/

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
    nv_baseprm  = 0
    nv_uom1_v   = 0         re_redbook = ""     n_cr2 = ""    
    nv_uom2_v   = 0         re_brand   = ""     n_pol = ""          
    nv_uom5_v   = 0         re_model   = ""     re_benname = ""           
    nv_basere   = 0         re_caryear = ""      
    n_41        = 0         re_engcc   = ""                   
    n_42        = 0         re_cargrp  = ""                  
    n_43        = 0         re_body    = ""                  
    nv_dedod    = 0         re_tons    = ""        
    nv_ded      = 0         re_seat    = ""      
    nv_dss_per  = 0         re_vehuse  = ""         
    nv_stf_per  = 0         re_chasno  = ""              
    nv_cl_per   = 0         re_eng     = ""      
    nre_premt   = 0         re_vehreg   = ""  .      
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwnsexp (INPUT-OUTPUT  wdetail.prepol,     
                      INPUT-OUTPUT  wdetail.prempa,     
                      INPUT-OUTPUT  wdetail.subclass,   
                      INPUT-OUTPUT  re_redbook,               
                      INPUT-OUTPUT  re_brand  ,            
                      INPUT-OUTPUT  re_model  ,            
                      INPUT-OUTPUT  re_caryear,            
                      INPUT-OUTPUT  re_engcc  ,                          
                      INPUT-OUTPUT  re_cargrp ,               
                      INPUT-OUTPUT  re_body   ,            
                      INPUT-OUTPUT  re_tons   ,                      
                      INPUT-OUTPUT  re_seat   ,                       
                      INPUT-OUTPUT  re_vehuse ,            
                      INPUT-OUTPUT  wdetail.covcod,             
                      INPUT-OUTPUT  wdetail.garage,             
                      INPUT-OUTPUT  re_vehreg,                 
                      INPUT-OUTPUT  re_chasno,            
                      INPUT-OUTPUT  re_eng,           
                      INPUT-OUTPUT  nv_uom1_v,                              
                      INPUT-OUTPUT  nv_uom2_v,                              
                      INPUT-OUTPUT  nv_uom5_v,                              
                      INPUT-OUTPUT  WDETAIL.deductpd,                       
                      INPUT-OUTPUT  WDETAIL.deductpd2,                      
                      INPUT-OUTPUT  nv_baseprm,  /* nv_basere,    */                           
                      INPUT-OUTPUT  wdetail.seat41,                          
                      INPUT-OUTPUT  n_41,                             
                      INPUT-OUTPUT  n_42,                             
                      INPUT-OUTPUT  n_43,                             
                      INPUT-OUTPUT  nv_dedod,                        
                      INPUT-OUTPUT  nv_ded,                          
                      INPUT-OUTPUT  wdetail.fleet,                     
                      INPUT-OUTPUT  wdetail.NCB,                     
                      INPUT-OUTPUT  nv_dss_per,                      
                      INPUT-OUTPUT  nv_stf_per,                      
                      INPUT-OUTPUT  nv_cl_per,                       
                      INPUT-OUTPUT  wdetail.firstdat,      
                      INPUT-OUTPUT  re_benname,
                      INPUT-OUTPUT  nre_premt)  .

        wdetail.premt = STRING(nre_premt).
        n_pol = wdetail.policy.
        n_cr2 = wdetail.cr_2.
    IF wdetail.cr_2 <> "" THEN DO: /* ����������� �ú. */
        FIND LAST wdetail WHERE wdetail.policy = n_cr2  AND wdetail.covcod = "T" NO-LOCK no-error .
            IF AVAIL wdetail THEN DO:
                ASSIGN  wdetail.redbook   = trim(re_redbook)  
                        /*wdetail.brand     = trim(re_brand) */ 
                        /*wdetail.model     = trim(re_model)  */
                        wdetail.caryear   = trim(re_caryear)  
                        wdetail.engcc     = trim(re_engcc)  
                        wdetail.cargrp    = trim(re_cargrp)  
                        wdetail.body      = trim(re_body)   
                        wdetail.tons      = DECI(re_tons)   
                        wdetail.seat      = trim(re_seat)   
                        wdetail.vehuse    = trim(re_vehuse)   
                        wdetail.chasno    = trim(re_chasno) 
                        wdetail.eng       = trim(re_eng) .
            END.
            RELEASE wdetail.
    END.
    FIND LAST wdetail WHERE wdetail.policy = n_pol AND wdetail.covcod <> "T" NO-LOCK NO-ERROR . /* ����������� ��. */
    IF AVAIL wdetail THEN DO:
             IF DECI(wdetail.si) <> DECI(WDETAIL.deductpd) THEN DO:
                MESSAGE "�ع��Сѹ����ҹ �Ѻ��к����ç�ѹ !! " VIEW-AS ALERT-BOX.
                ASSIGN wdetail.redbook   = trim(re_redbook)                                            
                       /*wdetail.brand     = trim(re_brand)*/                                            
                       /*wdetail.model     = trim(re_model)*/                                           
                       wdetail.caryear   = trim(re_caryear)                                            
                       wdetail.engcc     = trim(re_engcc)                                            
                       wdetail.cargrp    = trim(re_cargrp )                                            
                       wdetail.body      = trim(re_body)                                            
                       wdetail.tons      = DECI(re_tons)                                            
                       wdetail.seat      = trim(re_seat)                                            
                       wdetail.vehuse    = trim(re_vehuse)                                            
                       wdetail.chasno    = trim(re_chasno)                                             
                       wdetail.eng       = trim(re_eng)
                       wdetail.WARNING   = IF wdetail.WARNING <> "" THEN wdetail.WARNING + "|�ع��Сѹ����ҹ �Ѻ��к����ç�ѹ !! " 
                                           ELSE "�ع��Сѹ����ҹ �Ѻ��к����ç�ѹ !! " .  
             END.
             ELSE DO:
                ASSIGN wdetail.si        = WDETAIL.deductpd   /*si */    
                       wdetail.fire      = WDETAIL.deductpd2  /*fi */
                       wdetail.redbook   = trim(re_redbook)                                            
                       /*wdetail.brand     = trim(re_brand) */                                           
                       /*wdetail.model     = trim(re_model) */                                           
                       wdetail.caryear   = trim(re_caryear)                                            
                       wdetail.engcc     = trim(re_engcc)                                            
                       wdetail.cargrp    = trim(re_cargrp )                                            
                       wdetail.body      = trim(re_body)                                            
                       wdetail.tons      = DECI(re_tons)                                            
                       wdetail.seat      = trim(re_seat)                                            
                       wdetail.vehuse    = trim(re_vehuse)                                            
                       wdetail.chasno    = trim(re_chasno)                                             
                       wdetail.eng       = trim(re_eng) . 
             END.
    END.
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
FIND FIRST wdetail WHERE wdetail.policy  = "D70" + trim(np_cedpol)   NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail  THEN DO:
    CREATE wdetail .
    ASSIGN 
        wdetail.policy     = "D70" + trim(np_cedpol)
        wdetail.poltyp     = "V70"
        wdetail.prepol     = trim(np_oldpol)
        wdetail.cedpol     = trim(np_cedpol)
        wdetail.tiname     = trim(np_ntitle)     
        wdetail.insnam     = trim(np_insurcename) + " " + trim(np_insurceno)
        wdetail.insnam2    = ""
        wdetail.insnam3    = ""
        wdetail.addr1      = trim(np_addr1) + " " + TRIM(np_addr2)
        wdetail.brand      = TRIM(np_brand)
        wdetail.model      = TRIM(np_model) 
        wdetail.vehreg     = trim(np_vehreg)
        wdetail.caryear    = trim(np_caryear)
        wdetail.chasno     = trim(np_cha_no) 
        wdetail.eng        = trim(np_engno)
        wdetail.engcc      = TRIM(np_engCC) 
        wdetail.benname    = TRIM(np_benname)
        wdetail.delerno    = ""
        wdetail.delername  = ""
        wdetail.stk        = ""
        wdetail.cr_2       = IF DECI(np_total) = DECI(np_premt) THEN "" ELSE  "D72" + trim(np_cedpol)
        wdetail.garage     = IF trim(np_garage) = "G2"  THEN "H" ELSE ""
        wdetail.covcod     = IF      INDEX(np_covcod,"������ 1") > 0 THEN "1"
                             ELSE IF INDEX(np_covcod,"1") > 0        THEN "1"
                             ELSE IF INDEX(np_covcod,"������ 2") > 0 THEN "2"
                             ELSE IF INDEX(np_covcod,"2") > 0        THEN "2"
                             ELSE IF INDEX(np_covcod,"������ 3") > 0 THEN "3"
                             ELSE IF INDEX(np_covcod,"3") > 0 THEN "3"
                             ELSE "1" 
        wdetail.comdat     = trim(np_comdate)
        wdetail.expdat     = TRIM(np_expdate)
        wdetail.firstdat   = trim(np_comdate) 
        wdetail.si         = trim(np_si)      
        wdetail.fire       = trim(np_fire) 
        wdetail.premt      = trim(np_premt)
        wdetail.tp1        = trim(np_tper)   
        wdetail.tp2        = trim(np_tpbi)   
        wdetail.tp3        = trim(np_tppd)
        wdetail.NO_41      = trim(np_41)    
        wdetail.NO_42      = trim(np_43)    
        wdetail.NO_43      = trim(np_42)
        wdetail.fleet      = TRIM(np_feet)
        wdetail.ncb        = np_ncb   
        wdetail.dspc       = np_other
        wdetail.seat       = np_seats
        wdetail.remark     = trim(np_remark) 
        wdetail.remark2    = trim(np_remark2) 
        wdetail.remark3    = trim(np_remark3) 
        wdetail.remarkpaid = trim(np_remarkpaid) 
        /*wdetail.accesstxt    = trim(np_accessory)
        wdetail.receipt_name = TRIM(np_recivename) + "DLR:" +   TRIM(np_showroomno)*/
        wdetail.vehuse     = "1"
        wdetail.tariff     = "x" 
        wdetail.compul     = "n"
        wdetail.comment    = ""
        /*wdetail.prempa     = "Z"   /*fi_pack*/  */ /*A64-0138*/
        wdetail.prempa     = trim(fi_pack)             /*A64-0138*/
        wdetail.subclass   = TRIM(np_subclass)
        /*wdetail.icno       = TRIM(np_icno) */  /*A56-0243*/
        wdetail.icno       = TRIM(np_icno)      /*A60-0272*/
        wdetail.producer   = IF trim(np_garage) = "G2" THEN TRIM(fi_producer2) ELSE trim(fi_producer1)
        wdetail.agent      = IF trim(np_garage) = "G2" THEN TRIM(fi_producer2) ELSE trim(fi_producer1)
        wdetail.entdat     = string(TODAY)                /*entry date*/
        wdetail.enttim     = STRING (TIME, "HH:MM:SS")    /*entry time*/
        wdetail.trandat    = STRING (fi_loaddat)          /*tran date*/
        wdetail.trantim    = STRING (TIME, "HH:MM:SS")    /*tran time*/
        wdetail.n_IMPORT   = "IM"
        wdetail.n_EXPORT   = "" 
        wdetail.n_branch   = TRIM(np_br)
        wdetail.n_campaigns = TRIM(np_campaign)
        wdetail.drivnam    = IF TRIM(np_drive1) <> "" THEN "Y" ELSE "N"
        wdetail.drive1     = trim(np_drive1)
        wdetail.bdate1     = TRIM(np_bdate1)
        wdetail.id1        = TRIM(np_id1)
        wdetail.drive2     = trim(np_drive2)
        wdetail.bdate2     = TRIM(np_bdate2)
        wdetail.id2        = TRIM(np_id2)
        wdetail.contractno = TRIM(np_contractno)
        wdetail.userc      = TRIM(np_user)
        wdetail.deductpd   = trim(np_deduct)
        wdetail.deductpd2  = trim(np_deduct2)
        wdetail.paiddat    = trim(np_paiddat)  
        wdetail.typepaid   = trim(np_typepaid) 
        wdetail.paidno     = trim(np_paidno)   
        wdetail.paidtyp    = TRIM(np_paidtyp)
        /*wdetail.br_insured = "00000"  */             /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.insnamtyp  = trim(np_insnamtyp)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.firstName  = trim(np_firstName)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.lastName   = trim(np_lastName)     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.postcd     = trim(np_postcd)       /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.codeocc    = trim(np_codeocc)      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.codeaddr1  = trim(np_codeaddr1)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.codeaddr2  = trim(np_codeaddr2)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wdetail.codeaddr3  = trim(np_codeaddr3) .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2 c-Win 
PROCEDURE proc_base2 :
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF wdetail.poltyp = "v70" THEN DO:
    IF nv_baseprm = 0  THEN DO: 
        RUN wgs\wgsfbas.
    END.
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
        nv_drivvar = "" .
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN  wdetail.pass = "N"
                wdetail.comment  = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN  nv_drivvar = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.
    /*-------nv_baseprm----------*/
    IF NO_basemsg <> " " THEN  wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail.pass = "N"
        wdetail.comment      = wdetail.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN nv_basevar = ""  
        nv_prem1 = nv_baseprm
        nv_basecod  = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    /*-------nv_add perils----------*/
    IF wdetail.prepol <> "" THEN  
        ASSIGN  nv_41 = n_41  /*�������*/
                nv_42 = n_42
                nv_43 = n_43
                nv_seat41 =  inte(wdetail.seat) .
    ELSE Assign nv_41       =  deci(wdetail.NO_41)                             
                nv_42       =  deci(wdetail.NO_42)                             
                nv_43       =  deci(wdetail.NO_43)                             
                nv_seat41   =  deci(wdetail.seat) .
    /* comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                          nv_class,
                          nv_key_b,
                          nv_comdat). 
    ...end A64-0138...*/
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

    nv_42var       = " ".     /* -------fi_42---------*/
    ASSIGN  nv_42cod   = "42".
        nv_42var1  = "     Medical Expense = ".
        nv_42var2  = STRING(nv_42).
        SUBSTRING(nv_42var,1,30)   = nv_42var1.
        SUBSTRING(nv_42var,31,30)  = nv_42var2.

    nv_43var    = " ".     /*---------fi_43--------*/
    ASSIGN  nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    /* comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,       /*pass*/ /*a490166 note modi*/
                          nv_class,
                          nv_key_b,
                          nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/  
    ...end A64-0138...*/
    /*------nv_usecod------------*/
    ASSIGN nv_usevar =  ""
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30)  = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  TRIM(wdetail.subclass). 
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
        nv_totsi = 0
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
        nv_bipvar2     =  TRIM(wdetail.tp1)    /*STRING(uwm130.uom1_v)*/
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    Assign nv_biavar = ""
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     =  trim(wdetail.tp2)     /* STRING(uwm130.uom2_v)*/
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*-------------nv_pdacod--------------------*/
    ASSIGN nv_pdavar = ""
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     =  TRIM(wdetail.tp3)        /*STRING(uwm130.uom5_v)*/
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    /*--------------- deduct ----------------*/
    ASSIGN dod0 = 0
           dod1 = 0
           dod2 = 0
           dpd0 = 0
           dod0 = int(nv_dedod)
           dpd0 = int(nv_ded).

    IF dod0 > 3000 THEN DO:
            dod1 = 3000.
            dod2 = dod0 - dod1.
    END.
    ELSE do: 
        dod1 = dod0.
        dod2 = INT(wdetail.deduct2).
    END.
    /* end A60-0005 */
    ASSIGN nv_dedod1var = ""
           nv_odcod     = "DC01"
           nv_prem      =  dod1 .        
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
        ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
        /*NEXT.*/
    END.
    IF dod1 <> 0  THEN
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
     /* comment by : A64-0138...
    Run  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */
                             nv_tariff,
                             nv_class,
                             nv_key_b,
                             nv_comdat,
                             nv_cons,
                      OUTPUT nv_prem). 
     ...end : A64-0138... */
    IF dod2 <> 0  THEN
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
        nv_ded   = dpd0
        dod0     = dpd0    /*A60-0005*/
        /*dod0 = 0*/    .
     /* comment by : A64-0138...
    Run  Wgs\Wgsmx025(INPUT  dod0,  
                             nv_tariff,
                             nv_class,
                             nv_key_b,
                             nv_comdat,
                             nv_cons,
                      OUTPUT nv_prem).
    nv_ded2prm    = nv_prem.
    ....end : A64-0138...*/
    IF dod0 <> 0 THEN
        ASSIGN
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(dod0)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
            nv_dedpd_prm  = nv_prem.
    /*---------- fleet -------------------*/
    nv_flet_per = 0.
    ASSIGN nv_flet_per = DECI(wdetail.fleet) .
    IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
        Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
        ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
    END.
    IF nv_flet_per = 0 Then do:
        ASSIGN nv_flet     = 0
            nv_fletvar  = " ".
    END.
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
    ...end : A64-0138...*/
    IF nv_flet_per <> 0 THEN
        ASSIGN
            nv_fletvar                  = " "
            nv_fletvar1                 = "     Fleet % = "
            nv_fletvar2                 =  STRING(nv_flet_per)
            SUBSTRING(nv_fletvar,1,30)  = nv_fletvar1
            SUBSTRING(nv_fletvar,31,30) = nv_fletvar2.
    IF nv_flet   = 0  THEN  nv_fletvar  = " ".
    /*---------------- NCB -------------------*/
    /*IF wdetail.covcod = "3" THEN WDETAIL.NCB = "30".*/
    ASSIGN 
        NV_NCBPER  = DECI(wdetail.ncb)
        nv_ncb     = DECI(wdetail.ncb)
        nv_ncbvar = " ".
    If nv_ncbper  <> 0 Then do:
        Find first sicsyac.xmm104 Use-index xmm10401 Where
            sicsyac.xmm104.tariff = nv_tariff        AND
            sicsyac.xmm104.class  = nv_class         AND 
            sicsyac.xmm104.covcod = nv_covcod        AND 
            sicsyac.xmm104.ncbper = NV_NCBPER        No-lock no-error no-wait.
        IF not avail  sicsyac.xmm104  Then do:
            Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
            ASSIGN  wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
        END.
        ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                    nv_ncbyrs = xmm104.ncbyrs.
    END.
    Else DO: 
        Assign
            nv_ncbyrs  =   0
            nv_ncbper  =   0
            nv_ncb     =   0.
    END.
     /* comment by : A64-0138...
    RUN WGS\WGSORPRM.P (INPUT nv_tariff,  /*pass*/
                              nv_class,
                              nv_covcod,
                              nv_key_b,
                              nv_comdat,
                              nv_totsi,
                              uwm130.uom1_v,
                              uwm130.uom2_v,
                              uwm130.uom5_v).
    ....end : A64-0138...*/
    nv_ncbvar   = " ".
    IF  nv_ncb <> 0  THEN
        ASSIGN 
        nv_ncbvar1   = "     NCB % = "
        nv_ncbvar2   =  STRING(nv_ncbper)
        SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
        SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
    /*-------------- load claim ---------------------*/
    /*nv_cl_per  = 0.*/
    nv_clmvar  = " ".
    nv_cl_per  = DECI(nv_cl_per). 
    IF nv_cl_per  <> 0  THEN
        Assign 
        nv_clmvar1   = " Load Claim % = "
        nv_clmvar2   =  STRING(nv_cl_per)
        SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
     /* comment by : A64-0138...
    RUN WGS\WGSORPRM.P (INPUT nv_tariff,  
                        nv_class,
                        nv_covcod,
                        nv_key_b,
                        nv_comdat,
                        nv_totsi,
                        uwm130.uom1_v,
                        uwm130.uom2_v,
                        uwm130.uom5_v).
    .. end : A64-0138...*/
    /*------------------ dsspc ---------------*/
    nv_dss_per = deci(nv_dss_per).
    IF  nv_dss_per   <> 0  THEN
        Assign
        nv_dsspcvar1   = "     Discount Special % = "
        nv_dsspcvar2   =  STRING(nv_dss_per)
        SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
        SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
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
    ...end : A64-0138...*/
    /*------------------ stf ---------------*/
          nv_stfvar   = " ".
          nv_stf_per  = 0.
          nv_stf_per  = DECI(nv_stf_per). /*A60-0150*/
      IF  nv_stf_per   <> 0  THEN
           Assign
                 nv_stfvar1   = "     Discount Staff"          
                 nv_stfvar2   =  STRING(nv_stf_per)           
                 SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1    
                 SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.   
        /*--------------------------*/ 
       /* comment by : A64-0138... 
      RUN WGS\WGSORPRM.P (INPUT  nv_tariff,   /*pass*/
                                       nv_class,
                                       nv_covcod,
                                       nv_key_b,
                                       nv_comdat,
                                       nv_totsi,
                                       nv_uom1_v ,       
                                       nv_uom2_v ,       
                                       nv_uom5_v ).
     ..end : A64-0138...*/

    ASSIGN fi_process = "out base" + wdetail.policy.
    DISP fi_process WITH FRAM fr_main.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2_01 c-Win 
PROCEDURE proc_base2_01 :
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
    /*IF wdetail.prepol <> "" THEN  aa = nv_basere.*/
    /*ELSE IF  THEN
    ELSE DO:
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.*/
    ASSIGN nv_dss_per = 0     /*A54-0389*/
        aa = 0.
    /*comment by kridtiya i. A56-0018...  IF      index(wdetail.model,"Tiida") <> 0    THEN RUN proc_base_tiida.
    ELSE IF index(wdetail.model,"X-TRAIL") <> 0  THEN RUN proc_base_X-TRAIL. 
    ELSE IF index(wdetail.model,"TEANA")   <> 0  THEN RUN proc_base_TEANA.
    ELSE IF index(wdetail.model,"URVAN")   <> 0  THEN RUN proc_base_URVAN.
    ELSE IF index(wdetail.model,"Navara")  <> 0  THEN RUN proc_base_Navara. 
    ELSE DO: 
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.  comment by kridtiya i. A56-0018.*/
    /*by kridtiya i. A56-0037.*/
    FIND FIRST brstat.insure USE-INDEX insure01         WHERE 
        brstat.insure.compno = fi_camaign2              AND 
        brstat.insure.Text1  = fi_brand                 AND
        index(wdetail.model,brstat.insure.Text2) <> 0   AND
        brstat.insure.Text3  = (wdetail.prempa +  wdetail.subclass)  AND
        deci(brstat.insure.Text4)  =  deci(wdetail.si)    NO-LOCK  NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure  THEN  
        ASSIGN aa   =    deci(insure.Text5)
        WDETAIL.NCB =    STRING(insure.Deci1)
        nv_dss_per  =    insure.Deci2  .
    ELSE DO:
        /* ranu 
        IF      index(wdetail.model,"Tiida")   <> 0  THEN RUN proc_base_tiida.
        ELSE IF index(wdetail.model,"X-TRAIL") <> 0  THEN RUN proc_base_X-TRAIL. 
        ELSE IF index(wdetail.model,"TEANA")   <> 0  THEN RUN proc_base_TEANA.
        ELSE IF index(wdetail.model,"URVAN")   <> 0  THEN RUN proc_base_URVAN.
        ELSE IF index(wdetail.model,"Navara")  <> 0  THEN RUN proc_base_Navara. */
        /*ELSE DO:*/          /*A58-0014*/
        IF aa = 0  THEN DO:   /*A58-0014*/
            RUN wgs\wgsfbas.
            ASSIGN aa = nv_baseprm.
        END.
    END.    /*by kridtiya i. A56-0037.*/
    ASSIGN chk = NO
        NO_basemsg = " "
        nv_baseprm = aa.
    /*-----nv_drivcod---------------------*/
    /*nv_drivvar1 = wdetail.drive1.
    nv_drivvar2 = wdetail.drive2.
    IF wdetail.drive1 <> ""   THEN  wdetail.drivnam  = "y".
    ELSE wdetail.drivnam  = "N".
    IF wdetail.drive2 <> ""   THEN  nv_drivno = 2. 
    ELSE IF wdetail.drive1 <> "" AND wdetail.drive2 = "" THEN  nv_drivno = 1.  
    ELSE IF wdetail.drive1 = "" AND wdetail.drive2 = "" THEN  nv_drivno = 0.  
    If wdetail.drivnam  = "N"  Then 
        Assign nv_drivvar         = " "
        nv_drivcod                = "A000"
        nv_drivvar1               =  "     Unname Driver"
        nv_drivvar2               = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN  wdetail.pass  = "N"
                wdetail.comment   = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN  nv_drivvar = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
        /*RUN proc_usdcod. */
    END.*/
    /*-------nv_baseprm----------*/
    IF NO_basemsg <> " " THEN  wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN  nv_prem1 = nv_baseprm
        nv_basecod   = "BASE"
        nv_basevar1  = "     Base Premium = "
        nv_basevar2  = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    IF wdetail.prepol <> "" THEN  
        ASSIGN  nv_41 = n_41  /*�������*/
                nv_42 = n_42
                nv_43 = n_43
                nv_seat41 =  inte(wdetail.seat) .
    ELSE Assign nv_41       =  deci(wdetail.NO_41)                             
                nv_42       =  deci(wdetail.NO_42)                             
                nv_43       =  deci(wdetail.NO_43)                             
                nv_seat41   =  deci(wdetail.seat) .
   
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                          nv_class,
                          nv_key_b,
                          nv_comdat). 
    Assign  nv_41cod1   = "411"
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
    nv_42var       = " ".     /* -------fi_42---------*/
    ASSIGN  nv_42cod   = "42".
    nv_42var1  = "     Medical Expense = ".
    nv_42var2  = STRING(nv_42).
    SUBSTRING(nv_42var,1,30)   = nv_42var1.
    SUBSTRING(nv_42var,31,30)  = nv_42var2.
    nv_43var    = " ".     /*---------fi_43--------*/
    ASSIGN  nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    RUN WGS\WGSOPER(INPUT nv_tariff,       /*pass*/ /*a490166 note modi*/
                          nv_class,
                          nv_key_b,
                          nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/  
    /*------nv_usecod------------*/
    ASSIGN  nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30)  = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  wdetail.subclass. 
    RUN wgs\wgsoeng.   
    /*-----nv_yrcod----------------------------*/  
    ASSIGN nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
        nv_yrvar1  = "     Vehicle Year = "
        nv_yrvar2  =  wdetail.caryear
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
        Substr(nv_yrvar,1,30)    = nv_yrvar1
        Substr(nv_yrvar,31,30)   = nv_yrvar2.  
     /*-----nv_sicod----------------------------*/  
    Assign  nv_totsi     = 0
             nv_sicod     = "SI"
             nv_sivar1    = "     Own Damage = "
             nv_sivar2    =   wdetail.si 
             SUBSTRING(nv_sivar,1,30)  = nv_sivar1
             SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
             nv_totsi     =  DECI(wdetail.si).
         /*----------nv_grpcod--------------------*/
    ASSIGN   nv_grpcod      = "GRP" + wdetail.cargrp
             nv_grpvar1     = "     Vehicle Group = "
             nv_grpvar2     = wdetail.cargrp
             Substr(nv_grpvar,1,30)  = nv_grpvar1
             Substr(nv_grpvar,31,30) = nv_grpvar2.
     /*-------------nv_bipcod--------------------*/
     ASSIGN  nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     = STRING(deci(wdetail.tp1))             
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1              
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.             
     /*-------------nv_biacod--------------------*/
     Assign nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     = STRING(deci(wdetail.tp2))
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN nv_pdacod      = "PD"
         nv_pdavar1     = "     PD per Accident = "
         /*nv_pdavar2     = STRING(uwm130.uom5_v)   a52-0172*/
         nv_pdavar2     = string(deci(wdetail.tp3))         /*A52-0172*/
         SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
         SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
     /*--------------- deduct ----------------*/
   
     DEF VAR dod0 AS INTEGER.                                        
     DEF VAR dod1 AS INTEGER.                                        
     DEF VAR dod2 AS INTEGER.                                        
     DEF VAR dpd0 AS INTEGER. 
     /*def  var  nv_chk  as  logic.*/
      /*dod0 = inte(wdetail.deductda).  a52-0172*/
    ASSIGN dod0 =  nv_dedod 
     dod1 = 0
     dpd0 =  nv_ded  .    
     IF  dod0 > 3000 THEN  
         ASSIGN  dod1 = 3000 
         dod2 = dod0 - dod1  .
     ELSE dod2 = dod0.
     ASSIGN  nv_odcod = "DC01"
         nv_prem      =   dod2
         nv_sivar2    = "" .  
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
         ASSIGN  wdetail.pass    = "N"
             wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
     END.
     ASSIGN  nv_ded1prm    = nv_prem
         nv_dedod1_prm     = nv_prem
         nv_dedod1_cod     = "DOD"
         nv_dedod1var1     = "     Deduct OD = "
         nv_dedod1var2     = STRING(dod2)
         SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
         SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
     /*add od*/
     Assign  nv_dedod2var   = " "
         nv_cons  = "AD"
         nv_ded   = dod1.
     Run  Wgs\Wgsmx025(INPUT  nv_ded,  
                              nv_tariff,
                              nv_class,
                              nv_key_b,
                              nv_comdat,
                              nv_cons,
                       OUTPUT nv_prem).      
     ASSIGN  nv_aded1prm     = nv_prem
         nv_dedod2_cod   = "DOD2"
         nv_dedod2var1   = "     Add Ded.OD = "
         nv_dedod2var2   =  STRING(dod1)
         SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
         SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
         nv_dedod2_prm   = nv_prem.
     /***** pd *******/
     ASSIGN  nv_dedpdvar  = " "
         nv_ded = dpd0
         /*dpd0     = inte(wdetail.deductpd) pin tt  pd3*/
         nv_cons  = "PD".
        /* nv_ded   = dpd0.*/
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
     /*---------- fleet -------------------*/
     nv_flet_per = INTE(wdetail.fleet)   .
     IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
         Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
         ASSIGN  wdetail.pass    = "N"
             wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
     End.  
     IF nv_flet_per = 0 Then do:
         ASSIGN nv_flet  = 0
             nv_fletvar  = " ".
     End.
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                deci(wdetail.tp1),
                                deci(wdetail.tp2),
                                deci(wdetail.tp3)).
         ASSIGN  nv_fletvar     = " "
         nv_fletvar1    = "     Fleet % = "
         nv_fletvar2    =  STRING(nv_flet_per)
         SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
         SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
     IF nv_flet   = 0  THEN nv_fletvar  = " ".
     /*---------------- NCB -------------------*/
     IF wdetail.covcod = "3" THEN WDETAIL.NCB = "30".
     ELSE IF  wdetail.covcod = "2" THEN WDETAIL.NCB = "20".
     ASSIGN NV_NCBPER = 0
     NV_NCBPER  = INTE(WDETAIL.NCB)
     nv_ncb     = INTE(WDETAIL.NCB)
     nv_ncbvar = " ".
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401  Where
             sicsyac.xmm104.tariff = nv_tariff            AND
             sicsyac.xmm104.class  = nv_class             AND 
             sicsyac.xmm104.covcod = nv_covcod            AND 
             sicsyac.xmm104.ncbper   = INTE(wdetail.ncb)  No-lock no-error no-wait.
         IF not avail  sicsyac.xmm104  Then do:
             Message " This NCB Step not on NCB Rates file xmm104. " 
                 nv_tariff          
                 nv_class           
                 nv_covcod          
                 wdetail.ncb  View-as alert-box.
             ASSIGN wdetail.pass    = "N"
                 wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
         END.
         ASSIGN nv_ncbper = xmm104.ncbper   
             nv_ncbyrs = xmm104.ncbyrs.
     END.
     Else do:  
         ASSIGN  nv_ncbyrs  =   0
             nv_ncbper  =   0
             nv_ncb     =   0.
     END.
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                deci(wdetail.tp1),
                                deci(wdetail.tp2),
                                deci(wdetail.tp3)).
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     /*------------------ dsspc ---------------*/
     ASSIGN nv_dsspcvar   = " ".
     /*nv_dss_per   = 0
     n_prem = deci(wdetail.premt)
     n_prem = TRUNCATE(((n_prem * 100 ) / 107.43),0).
     IF wdetail.covcod = "2" THEN nv_dss_per = 2.*/
     /*nv_dss_per = ((nv_gapprm - n_prem ) * 100 ) / nv_gapprm . */
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         deci(wdetail.tp1),       
                         deci(wdetail.tp2),       
                         deci(wdetail.tp3)). 
     /*IF nv_gapprm <> n_prem THEN  nv_dss_per = TRUNCATE(((nv_gapprm - n_prem ) * 100 ) / nv_gapprm ,3 ) . 
        IF  nv_dss_per   <> 0  THEN
             Assign
             nv_dsspcvar1   = "     Discount Special % = "
             nv_dsspcvar2   =  STRING(nv_dss_per)
             SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
             SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.*/
     IF  nv_dss_per   <> 0  THEN
         ASSIGN  nv_dsspcvar1   = "     Discount Special % = "
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
                         deci(wdetail.tp1),       
                         deci(wdetail.tp2),       
                         deci(wdetail.tp3)). 
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
         ASSIGN nv_stfvar1   = "     Discount staff % = "
         nv_stfvar2   =  STRING(nv_stf_per)                 
         SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1          
         SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.         
     /*--------------------------*/                         
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/         
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                deci(wdetail.tp1),       
                                deci(wdetail.tp2),       
                                deci(wdetail.tp3)). 
     /*-------------- load claim ---------------------*/
     /*nv_cl_per  = deci(wdetail.loadclm).*/
     nv_clmvar  = " ".
     IF nv_cl_per  <> 0  THEN
               Assign nv_clmvar1   = " Load Claim % = "
                      nv_clmvar2   =  STRING(nv_cl_per)
                      SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
                      SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.

     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                deci(wdetail.tp1),
                                deci(wdetail.tp2),
                                deci(wdetail.tp3)).
 
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
         nv_class   = trim(wdetail.prempa) + trim(wdetail.subclass)                                         
         nv_vehuse  = wdetail.vehuse                                    
       /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
         nv_engcst  = 1900*/ /* ��ͧ����ҵ�� nv_cstflg         
         nv_drivno  = 0   */                                     
         nv_driage1 = nv_drivage1                                 
         nv_driage2 = nv_drivage2                                    
         nv_yrmanu  = int(wdetail.caryear)                         
         nv_totsi   = sic_bran.uwm130.uom6_v       
         nv_totfi   = sic_bran.uwm130.uom7_v
         nv_vehgrp  = wdetail.cargrp                                                     
         /*nv_access  = IF wdetail.accdata <> "" THEN "A" ELSE ""    */                                         
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
         nv_seat41  = wdetail.seat41 
         nv_dedod   = dod0     
         nv_addod   = dod1                               
         nv_dedpd   = dod2                                   
         nv_ncbp    = deci(wdetail.ncb)                                    
         nv_fletp   = deci(wdetail.fleet)                                 
         nv_dspcp   = deci(nv_dss_per)                                      
         nv_dstfp   = deci(nv_stf_per)                                                    
         nv_clmp    = deci(nv_cl_per) 
         nv_netprem = TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) + 
                      (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )
         /*nv_netprem  = DECI(wdetail.premt)*/ /* �����ط�� */                                                
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
     IF wdetail.prepol <> "" THEN nv_netprem  = DECI(wdetail.premt). /*�Ҩҡ���͹*/
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
            FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                WHERE stat.maktab_fil.sclass = wdetail.subclass  AND
                stat.maktab_fil.modcod       = wdetail.redbook   No-lock no-error no-wait.
            If  avail  stat.maktab_fil  Then 
                ASSIGN
                sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
                wdetail.cargrp         =  stat.maktab_fil.prmpac
                sic_bran.uwm301.vehgrp =  stat.maktab_fil.prmpac
                nv_vehgrp              =  stat.maktab_fil.prmpac.
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
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX. */    
 
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
                       INPUT-OUTPUT nv_baseprm,   /* nv_baseprm  */
                       INPUT-OUTPUT nv_baseprm3,  /* nv_baseprm3 */
                       INPUT-OUTPUT nv_pdprem,    /* nv_pdprem   */
                       INPUT-OUTPUT nv_netprem,   /* nv_netprem  */
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

    /*IF nv_gapprm <> DECI(wdetail.premt) THEN DO:*/
    IF nv_status = "no"  THEN DO:
        /*MESSAGE "���¨ҡ�к� " + string(nv_gapprm,">>,>>>,>>9.99") + " �����ҡѺ�������� " + wdetail.premt + 
          nv_message   VIEW-AS ALERT-BOX. 
        ASSIGN
                wdetail.comment = wdetail.comment + "| " + "���¨ҡ�к� �����ҡѺ�������� "
                wdetail.WARNING = "���¨ҡ�к� " + string(nv_gapprm,">>,>>>,>>9.99") + " �����ҡѺ�������� " + wdetail.premt.
                 wdetail.pass     = "Y"   
                wdetail.OK_GEN  = "N".*/   
         /*comment by Kridtiya i. A65-0035*/
        /*  by Kridtiya i. A65-0035*/
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN
            wdetail.comment = wdetail.comment + "|" + nv_message
            wdetail.WARNING = wdetail.WARNING + "|" + nv_message .
        /*  by Kridtiya i. A65-0035*/ 
    END.
    /*  by Kridtiya i. A65-0035*/ 
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate (input DATE(wdetail.comdat) ,
                        input date(wdetail.expdat) ,
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
DEF VAR nv_cha_ca AS CHAR FORMAT "x(10)"  INIT "" .  /*A57-0275*/
FOR EACH wchano.
    DELETE wchano.
END.
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
    /*/*Add A57-0275 check chassis on system */
    IF wdetail.chasno <> "" THEN DO:
        ASSIGN nv_cha_ca = "" .
        FOR EACH sicuw.uwm301 USE-INDEX uwm30103  NO-LOCK 
            WHERE sicuw.uwm301.trareg = TRIM(nv_uwm301trareg) .
            FIND LAST sicuw.uwm100  USE-INDEX uwm10001          WHERE
                sicuw.uwm100.policy     =  sicuw.uwm301.policy  AND
                sicuw.uwm100.poltyp     =  wdetail.poltyp       NO-LOCK NO-ERROR NO-WAIT. 
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.polsta = "ca" THEN ASSIGN nv_cha_ca = "ca".
                /*IF sicuw.uwm100.polsta   <> "CA" THEN 
                ASSIGN wdetail.pass = "N"
                wdetail.comment     = wdetail.comment + "| ���Ţ��Ƕѧ��� ��к� (CA) !!!"
                wdetail.warning     = "Program Running Policy No. �����Ǥ���".*/
                IF nv_cha_ca = "" THEN DO:
                    IF sicuw.uwm100.expdat > DATE(wdetail.comdat)   THEN  
                        ASSIGN wdetail.pass = "N"
                        wdetail.comment     = wdetail.comment + "| ���Ţ��Ƕѧ��� ��к� " + sicuw.uwm100.policy  + " !!!"
                        wdetail.warning     = "Program Running Policy No. �����Ǥ���".
                END.
            END.
        END.
    END. 
    /*Add A57-0275 check chassis on system */*/
    FOR EACH sicuw.uwm301 USE-INDEX uwm30103  NO-LOCK 
        WHERE sicuw.uwm301.trareg = TRIM(nv_uwm301trareg) .
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001          WHERE
            sicuw.uwm100.policy     =  sicuw.uwm301.policy  AND
            sicuw.uwm100.poltyp     =  "V70"                NO-LOCK NO-ERROR NO-WAIT. 
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.polsta <> "ca" THEN DO:
                FIND LAST wchano WHERE 
                    wchano.policy  = sicuw.uwm100.policy AND
                    wchano.poltyp  = sicuw.uwm100.poltyp NO-ERROR NO-WAIT.
                IF NOT AVAIL wchano THEN DO:
                    CREATE wchano.
                    ASSIGN  
                        wchano.policy  = sicuw.uwm301.policy
                        wchano.rencnt  = string(sicuw.uwm301.rencnt)
                        wchano.endcnt  = string(sicuw.uwm301.endcnt) 
                        wchano.poltyp  = "V70"
                        wchano.polsta  = sicuw.uwm100.polsta
                        wchano.expdat  = STRING(sicuw.uwm100.expdat)
                        wchano.chassis = sicuw.uwm301.trareg.
                END.
            END.
        /*IF sicuw.uwm100.polsta = "ca" THEN ASSIGN nv_cha_ca = "ca".*/
        /*DISP sicuw.uwm100.policy  sicuw.uwm100.polsta .*/
        END.
    END.
    FOR EACH wchano WHERE YEAR(DATE(wchano.expdat)) > YEAR(DATE(wdetail.comdat)) NO-LOCK .
        /*DISP wchano.policy
         wchano.rencnt
         wchano.endcnt
         wchano.polsta .*/
        FIND LAST sicuw.uwm301 WHERE   sicuw.uwm301.policy = wchano.policy NO-LOCK NO-ERROR .
        IF AVAIL sicuw.uwm301 THEN DO:
            IF TRIM(wchano.chassis) = sicuw.uwm301.trareg THEN 
                ASSIGN wdetail.pass = "N"
                wdetail.comment     = wdetail.comment + "| ���Ţ��Ƕѧ��� ��к� " + sicuw.uwm301.policy  + " !!!"
                wdetail.warning     = "Program Running Policy No. �����Ǥ���".
        END.
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
DO:
    nv_chkerror = "".
   RUN wgw\wgwchkagpd  (INPUT wdetail.agent,            
                        INPUT wdetail.producer,   
                        INPUT-OUTPUT nv_chkerror).
   IF nv_chkerror <> "" THEN DO:
       MESSAGE "Error Code Producer/Agent :" nv_chkerror  SKIP
       wdetail.producer SKIP
       wdetail.agent  VIEW-AS ALERT-BOX. 
       ASSIGN wdetail.comment = wdetail.comment + nv_chkerror 
              wdetail.pass    = "N" 
              wdetail.OK_GEN  = "N".
   END.


IF wdetail.delerno <> "" THEN DO:
    FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(wdetail.delerno) NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Dealer " + wdetail.delerno + "(xmm600)" 
           wdetail.pass    = "N" 
           wdetail.OK_GEN  = "N".
    ELSE DO:
        IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
        ASSIGN wdetail.comment = wdetail.comment + "| Code Dealer " + wdetail.delerno + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
               wdetail.pass    = "N" 
               wdetail.OK_GEN  = "N".
    END.
END.
/*
IF wdetail.fincode <> "" THEN DO:
    FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(wdetail.fincode) NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Finance " + wdetail.fincode + "(xmm600)" 
           wdetail.pass    = "N" 
           wdetail.OK_GEN  = "N".
    ELSE DO:
     IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
      ASSIGN wdetail.comment = wdetail.comment + "| Code Finance " + wdetail.fincode + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
             wdetail.pass    = "N" 
             wdetail.OK_GEN  = "N".
    END.
END.
IF wdetail.payercod <> "" THEN DO:
    FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(wdetail.payercod) NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Payer " + wdetail.payercod + "(xmm600)" 
           wdetail.pass    = "N" 
           wdetail.OK_GEN  = "N".
END.
IF wdetail.vatcode <> "" THEN DO:
    FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(wdetail.vatcode) NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Vat " + wdetail.vatcode + "(xmm600)" 
           wdetail.pass    = "N" 
           wdetail.OK_GEN  = "N".
    ELSE DO:
        IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
        ASSIGN wdetail.comment = wdetail.comment + "| Code VAT " + wdetail.vatcode + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
   END.
END.*/
RELEASE sicsyac.xmm600.

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
IF wdetail.vehreg = " " AND wdetail.prepol  = " " THEN DO: 
    ASSIGN wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N". 
END.
ELSE DO:
    Def  var  nv_vehreg  as char  init  " ".
    Def  var  s_polno    like sicuw.uwm100.policy   init " ".
    Find LAST sicuw.uwm301 Use-index uwm30102      Where  
        sicuw.uwm301.vehreg = wdetail.vehreg       No-lock no-error no-wait.
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
        If avail sicuw.uwm100 Then 
            s_polno     =   sicuw.uwm100.policy.
    END.    /*avil 301 */
END.        /*note end else*/   /*end note vehreg*/
IF wdetail.cancel = "ca"  THEN  
    ASSIGN wdetail.pass = "N"  
    wdetail.comment     = wdetail.comment + "| cancel"
    wdetail.OK_GEN      = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ���ͼ����һ�Сѹ�繤����ҧ��ٳ������ͼ����һ�Сѹ"
    wdetail.pass            = "N"     
    wdetail.OK_GEN          = "N".
/*IF wdetail.drivnam = "y" AND wdetail.drivername1 =  " "   THEN 
        ASSIGN
        wdetail.comment = wdetail.comment + "| �ա���к�����դ��Ѻ������ժ��ͤ��Ѻ"
        wdetail.pass    = "N" 
        wdetail.OK_GEN  = "N".*/
/*IF wdetail.prempa = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| prem pack �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass            = "N"     
    wdetail.OK_GEN          = "N".*/
IF wdetail.subclass = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| sub class �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass           = "N"  
    wdetail.OK_GEN         = "N".
IF  wdetail.n_branch = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| �Ң��繤����ҧ �������ö������������ʴ�������ա����"
    wdetail.pass            = "N"        
    wdetail.OK_GEN          = "N".
/*can't block in use*/ 
IF wdetail.brand = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Brand �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass           = "N"        
    wdetail.OK_GEN         = "N".
IF wdetail.model = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| model �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass            = "N"   
    wdetail.OK_GEN          = "N".
IF wdetail.engcc    = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| Engine CC �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass            = "N"     
    wdetail.OK_GEN          = "N".
IF wdetail.seat  = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| seat �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass            = "N"    
    wdetail.OK_GEN          = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| year manufacture �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass            = "N"  
    wdetail.OK_GEN          = "N".
ASSIGN  
    n_model   = ""
    nv_modcod = ""
    nv_maxsi  = 0
    nv_minsi  = 0
    nv_si     = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred    = NO  . 
/*add kridtiya i. A58-00014*/
FIND LAST stat.Insure   USE-INDEX Insure01 WHERE 
    stat.insure.compno   = trim(fi_matmodel)     AND   /* model = model_nis */
    stat.Insure.FName    = trim(wdetail.model)   NO-LOCK NO-ERROR NO-WAIT.  /*showroom */
IF  AVAIL stat.insure  THEN  ASSIGN  n_model = trim(stat.Insure.LName) .
ELSE ASSIGN n_model = "".
IF n_model = "" THEN DO:
    IF INDEX(wdetail.model,"FRONTIER") <> 0  THEN 
        ASSIGN n_model = trim(SUBSTRING(wdetail.model,INDEX(wdetail.model,"FRONTIER") + 9))
        n_model        = trim(SUBSTRING(n_model,1,INDEX(n_model," "))).
    ELSE IF  INDEX(wdetail.model,"TIIDA") <> 0  THEN 
        ASSIGN n_model = "TIIDA" 
        wdetail.body   = IF INDEX(wdetail.model,"H/B") <> 0 THEN  "HATCHBACK" ELSE "".
    ELSE n_model   = trim(SUBSTRING(wdetail.model,1,INDEX(wdetail.model," "))).
END.
/*add kridtiya i. A58-00014*/
/*RUN proc_model_brand.*/
IF wdetail.prepol = "" THEN DO:
    IF wdetail.redbook <> "" THEN DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE 
            stat.maktab_fil.sclass = wdetail.subclass   AND 
            stat.maktab_fil.modcod = wdetail.redbook    No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then do:
            ASSIGN wdetail.redbook  =  stat.maktab_fil.modcod     
                wdetail.engcc    =  STRING(stat.maktab_fil.engine)
                wdetail.subclass =  stat.maktab_fil.sclass   
                wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                /*wdetail.brand    =  stat.maktab_fil.makdes*/
                /*wdetail.model    =  stat.maktab_fil.moddes*/
                wdetail.body     =  IF wdetail.body = "HATCHBACK" THEN "HATCHBACK" ELSE  stat.maktab_fil.body
                wdetail.tons     =  stat.maktab_fil.tons
                nv_modcod        =  stat.maktab_fil.modcod   
                nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
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
            END.  /***--- End Check Rate SI ---***/
        END.
        ELSE nv_modcod = " ".
    END.  /*red book <> ""*/  
    IF nv_modcod = "" THEN DO:
        FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
            makdes31.moddes =  wdetail.prempa + wdetail.subclass  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL makdes31  THEN
            ASSIGN n_ratmin = makdes31.si_theft_p   
            n_ratmax = makdes31.load_p . 
        ELSE ASSIGN n_ratmin = 0
            n_ratmax = 0.
        IF wdetail.covcod = "1" OR wdetail.covcod = "2" THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04             Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,n_model) <> 0              And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     wdetail.subclass         AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)   AND
                 stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )
                 /* AND stat.maktab_fil.seats    =     INTEGER(wdetail.seat)*/
                    No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN 
                chkred           =  YES
                wdetail.redbook  =  stat.maktab_fil.modcod     
                wdetail.engcc    =  STRING(stat.maktab_fil.engine)
                /*wdetail.subclass =  stat.maktab_fil.sclass */  
                wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                /*wdetail.brand    =  stat.maktab_fil.makdes  */
                /*wdetail.model    =  stat.maktab_fil.moddes  */
                wdetail.body     =  IF wdetail.body = "HATCHBACK" THEN "HATCHBACK" ELSE  stat.maktab_fil.body
                wdetail.tons     =  stat.maktab_fil.tons
                nv_modcod        =  stat.maktab_fil.modcod   
                nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes .
            /*add kridtiya i. A58-00014*/
            IF nv_modcod = "" THEN DO: 
                Find First stat.maktab_fil USE-INDEX maktab04           Where
                    stat.maktab_fil.makdes   =     wdetail.brand            And                  
                    index(stat.maktab_fil.moddes,n_model) <> 0              And
                    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                    stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                    stat.maktab_fil.sclass   =     wdetail.subclass         AND
                    stat.maktab_fil.maksi   >=     deci(wdetail.si)         AND 
                    stat.maktab_fil.si      <=     deci(wdetail.si)         No-lock no-error no-wait.
                If  avail stat.maktab_fil  Then 
                    ASSIGN chkred           =  YES
                    wdetail.redbook  =  stat.maktab_fil.modcod     
                    wdetail.engcc    =  STRING(stat.maktab_fil.engine)
                    /*wdetail.subclass =  stat.maktab_fil.sclass */  
                    wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
                    wdetail.cargrp   =  stat.maktab_fil.prmpac
                    /*wdetail.brand    =  stat.maktab_fil.makdes */
                    /*wdetail.model    =  stat.maktab_fil.moddes */
                    wdetail.body     =  IF wdetail.body = "HATCHBACK" THEN "HATCHBACK" ELSE  stat.maktab_fil.body
                        wdetail.tons     =  stat.maktab_fil.tons
                        nv_modcod        =  stat.maktab_fil.modcod   
                        nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes .
            END.  /*add kridtiya i. A58-00014*/
        END.
        ELSE IF wdetail.covcod = "3" THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,n_model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     wdetail.subclass         /*AND
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)*/    No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN 
                chkred           =  YES
                wdetail.redbook  =  stat.maktab_fil.modcod     
                wdetail.engcc    =  STRING(stat.maktab_fil.engine)
                /*wdetail.subclass =  stat.maktab_fil.sclass  */ 
                wdetail.caryear  =  STRING(stat.maktab_fil.makyea)
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                /*wdetail.brand    =  stat.maktab_fil.makdes */
                /*wdetail.model    =  stat.maktab_fil.moddes */
                wdetail.body     =  IF wdetail.body = "HATCHBACK" THEN "HATCHBACK" ELSE  stat.maktab_fil.body
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
IF wdetail.redbook = "" THEN RUN proc_assignredbook.
ASSIGN                  
    NO_CLASS  = wdetail.prempa + wdetail.subclass 
    nv_poltyp = wdetail.poltyp.
IF nv_poltyp = "v72" THEN NO_CLASS  =  wdetail.subclass.
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
     sicsyac.sym100.tabcod = "u014"           AND 
     sicsyac.sym100.itmcod =  wdetail.vehuse  No-lock no-error no-wait.
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
     NV_NCBPER = INTE(WDETAIL.NCB) .
     If nv_ncbper  <> 0 Then do:
         Find first sicsyac.xmm104 Use-index xmm10401 Where
             sicsyac.xmm104.tariff = wdetail.tariff                      AND
             sicsyac.xmm104.class  = wdetail.prempa + wdetail.subclass   AND
             sicsyac.xmm104.covcod = wdetail.covcod                      AND
             sicsyac.xmm104.ncbper = INTE(wdetail.ncb)                   No-lock no-error no-wait.
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
FOR EACH wdetail BREAK BY wdetail.policy :
    IF  wdetail.policy = ""  THEN NEXT.
    ASSIGN 
        n_rencnt = 0
        n_endcnt = 0
        nv_baseprm = 0
        fi_process = "Check data to create " +  wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
    RUN proc_cr_2.

    RUN proc_susspect. /*Add by Kridtiya i. A63-0472*/
    RUN proc_chkcode . /*A64-0138*/
    IF wdetail.prepol <> "" THEN RUN proc_renew.
    IF wdetail.poltyp = "V70" THEN DO:
        RUN proc_chktest0. 
        RUN proc_policy . 
        RUN proc_chktest2.   
        RUN proc_chktest3.  
        RUN proc_chktest4.  
    END.
    IF wdetail.poltyp = "V72" THEN DO:
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
    /*RUN proc_policy . 
    RUN proc_chktest2.   
    RUN proc_chktest3.  
    RUN proc_chktest4.*/  
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
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
           sic_bran.uwm130.policy = sic_bran.uwm100.policy  AND
           sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt  AND
           sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt  AND
           sic_bran.uwm130.riskgp = s_riskgp                AND            /*0*/
           sic_bran.uwm130.riskno = s_riskno                AND            /*1*/
           sic_bran.uwm130.itemno = s_itemno                AND            /*1*/
           sic_bran.uwm130.bchyr  = nv_batchyr              AND 
           sic_bran.uwm130.bchno  = nv_batchno              AND 
           sic_bran.uwm130.bchcnt = nv_batcnt               NO-WAIT NO-ERROR.
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
                wdetail.comment = wdetail.comment + "| Class��� ����Ѻ�ػ�ó����������". 
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
            sic_bran.uwm130.uom1_v   = deci(wdetail.tp1)   /*A60-0150*/
            sic_bran.uwm130.uom2_v   = deci(wdetail.tp2)   /*A60-0150*/
            sic_bran.uwm130.uom5_v   = deci(wdetail.tp3)   /*A60-0150*/
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
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do: 
        /*IF wdetail.prepol = "" THEN
            Assign  
                sic_bran.uwm130.uom1_v     =  stat.clastab_fil.uom1_si   
                sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si  
                sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si
                nv_uom1_v                  =  stat.clastab_fil.uom1_si        /*deci(wdetail.tp_bi)   */ 
                nv_uom2_v                  =  stat.clastab_fil.uom2_si        /*deci(wdetail.tp_bi2) */  
                nv_uom5_v                  =  stat.clastab_fil.uom5_si  . */    /*deci(wdetail.tp_bi3) */  
        
           Assign 
            sic_bran.uwm130.uom1_v     =  deci(wdetail.tp1)               /*stat.clastab_fil.uom1_si   1000000  */  
            sic_bran.uwm130.uom2_v     =  deci(wdetail.tp2)               /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     =  deci(wdetail.tp3)                /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  =  deci(wdetail.tp1)   
            nv_uom2_v                  =  deci(wdetail.tp2)   
            nv_uom5_v                  =  deci(wdetail.tp3)
            wdetail.deductpd           =  wdetail.tp3 
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
        Else If  wdetail.garage  =  "H"  Then
            Assign nv_41       =  deci(wdetail.NO_41)
                   nv_42       =  deci(wdetail.NO_42)
                   nv_43       =  deci(wdetail.NO_43)
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
             sic_bran.uwm301.cha_no    = trim(wdetail.chasno)
             sic_bran.uwm301.trareg    = nv_uwm301trareg
             sic_bran.uwm301.eng_no    = wdetail.eng
             sic_bran.uwm301.Tons      = INTEGER(wdetail.tons)
             sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
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
             sic_bran.uwm301.itmdel    = NO.
             wdetail.tariff            = sic_bran.uwm301.tariff.
             IF wdetail.drivnam  = "Y" THEN RUN proc_mailtxt.
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
             
         s_recid4         = RECID(sic_bran.uwm301).
         IF wdetail.seat = "16" THEN wdetail.seat = "12".
         IF wdetail.redbook <> ""  /*AND chkred = YES*/  THEN DO:
             FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                 WHERE stat.maktab_fil.sclass = wdetail.subclass  AND
                 stat.maktab_fil.modcod       = wdetail.redbook   No-lock no-error no-wait.
             If  avail  stat.maktab_fil  Then 
                 ASSIGN
                     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  wdetail.brand + " " + wdetail.model  /*stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes */
                     sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
                     wdetail.cargrp          =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  IF wdetail.body = "HATCHBACK" THEN "HATCHBACK" ELSE stat.maktab_fil.body
                     sic_bran.uwm301.engine  =  stat.maktab_fil.engine
                     nv_engine               =  stat.maktab_fil.engine.
         END.
         ELSE DO:
             Find First stat.maktab_fil Use-index      maktab04          Where
                 stat.maktab_fil.makdes   =     nv_makdes                And                  
                 index(stat.maktab_fil.moddes,nv_moddes) <> 0            And
                 stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
                 stat.maktab_fil.engine  =     Integer(wdetail.engcc)    AND
                 stat.maktab_fil.sclass   =     wdetail.subclass         AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE deci(wdetail.si)   AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE deci(wdetail.si) ) /*AND
                  stat.maktab_fil.seats    =     INTEGER(wdetail.seat) */      
                 No-lock no-error no-wait.
             If  avail stat.maktab_fil  Then 
                 Assign
                     wdetail.redbook         =  stat.maktab_fil.modcod
                     sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                     sic_bran.uwm301.moddes  =  wdetail.brand + " " + wdetail.model  /*stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/
                     wdetail.cargrp          =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.Tons    =  stat.maktab_fil.tons
                     sic_bran.uwm301.body    =  IF wdetail.body = "HATCHBACK" THEN "HATCHBACK" ELSE stat.maktab_fil.body
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
    nv_class  = IF wdetail.poltyp = "v72" THEN trim(wdetail.subclass) ELSE trim(wdetail.prempa) +  trim(wdetail.subclass)
    nv_comdat = sic_bran.uwm100.comdat
    /*nv_engine = DECI(wdetail.engcc)*/
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
    MESSAGE "�������ç�Ѻ���·��ӹǳ��" + wdetail.premt + " <> " + STRING(nv_gapprm) VIEW-AS ALERT-BOX.
    ASSIGN 
        wdetail.WARNING  = "�������ç�Ѻ���������ӹǳ��"
        wdetail.comment  = wdetail.comment + "| gen ����к������������ç�Ѻ���������ӹǳ�� "
        wdetail.pass    = "N".
END. */ 

/* Add by : A64-0138 */

RUN proc_calpremt.       
RUN proc_adduwd132prem. 

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN  
         sic_bran.uwm100.prem_t = nv_pdprm          
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
        sic_bran.uwm301.mv41seat = wdetail.seat41.
        sic_bran.uwm301.tons     = IF sic_bran.uwm301.tons = 0 THEN 0 
                                   ELSE IF sic_bran.uwm301.tons < 100 THEN (sic_bran.uwm301.tons * 1000) 
                                   ELSE sic_bran.uwm301.tons.

IF (SUBSTR(wdetail.subclass,1,1) = "3" OR SUBSTR(wdetail.subclass,1,1) = "4" OR
   SUBSTR(wdetail.subclass,1,1)  = "5" OR TRIM(wdetail.subclass) = "803"     OR
   TRIM(wdetail.subclass)  = "804"     OR TRIM(wdetail.subclass) = "805" )   and
   (wdetail.prempa = "T" OR  wdetail.prempa = "A" ) AND sic_bran.uwm301.tons < 100  THEN DO:

   MESSAGE  wdetail.subclass + "�кع��˹ѡö���١��ͧ " VIEW-AS ALERT-BOX.
   ASSIGN 
       wdetail.comment = wdetail.comment + "|Class " + wdetail.subclass + " ���˹ѡö���١��ͧ " 
       wdetail.pass    = "N".
END.  
/* end A64-0138 */

/* comment by A64-0138..
RUN proc_uwm100.
RUN proc_uwm120.
RUN proc_uwm301.
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
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1  no-error no-wait.
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
                       nv_com1p = 18
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
                       nv_com1p = 18
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
          ASSIGN
                 nv_com2p = sicsyac.xmm018.commsp
                 nv_com2p = 12.
      ELSE DO:
           Find  sicsyac.xmm031  Use-index xmm03101  Where  
                 sicsyac.xmm031.poltyp    = "v72"
           No-lock no-error no-wait.
                   nv_com2p = sicsyac.xmm031.comm1.
                   nv_com2p = 12.
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
     If sic_bran.uwm120.com1p <> 0  Then 
         nv_com1p  = sic_bran.uwm120.com1p.
         nv_com1p  = 18.      /*A57-0432  motor commission 0 */
         nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.            
         /*fi_com1ae        =  YES.*/
  End.
  /*----------- comp comission ------------*/
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then 
           nv_com2p  = sic_bran.uwm120.com2p.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createcam c-Win 
PROCEDURE proc_createcam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wcam.
    DELETE wcam.
END.
CREATE wcam.
ASSIGN wcam.model    = "SYLPHY"
       wcam.producer = "B3W0019" 
       wcam.agent    = "B3W0019".
CREATE wcam.
ASSIGN wcam.model    = "NAVARA"
       wcam.producer = "B3W0019" 
       wcam.agent    = "B3W0019".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cr_2 c-Win 
PROCEDURE proc_cr_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
----------------------------------------------------------------------------*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_detail c-Win 
PROCEDURE proc_detail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF  fi_producer1 <> " " THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
        sicsyac.xmm600.acno  =  fi_producer1  
        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
       ASSIGN fi_proname1 = "Not Found data XMM600 " .
    END.
    ELSE DO:
        ASSIGN fi_proname1 =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name).
    END.
END.
IF  fi_producer2 <> " " THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
        sicsyac.xmm600.acno  =  fi_producer2  
        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
       ASSIGN fi_proname2 = "Not Found data XMM600 " .
    END.
    ELSE DO:
        ASSIGN fi_proname2 =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name).
    END.
END.
IF  fi_agent1 <> " " THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
        sicsyac.xmm600.acno  =  fi_agent1  
        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
       ASSIGN fi_agentname1 = "Not Found data XMM600 " .
    END.
    ELSE DO:
        ASSIGN fi_agentname1 =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name).
    END.
END.
IF  fi_agent2 <> " " THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
        sicsyac.xmm600.acno  =  fi_agent2  
        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
       ASSIGN fi_agentname2 = "Not Found data XMM600 " .
    END.
    ELSE DO:
        ASSIGN fi_agentname2 =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name).
    END.
END.
Disp  fi_proname1 fi_proname2 fi_agentname1 fi_agentname2   WITH Frame  fr_main. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exportfilematp c-Win 
PROCEDURE proc_exportfilematp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  nv_output AS CHAR FORMAT "x(60)".
DEF VAR  n_count   AS DECI INIT 0.
IF INDEX(fi_output1,".slk") = 0  THEN 
    fi_output1 = fi_output1 + ".slk".
ELSE 
    nv_output = substr(fi_output1,1,INDEX(fi_output1,".slk") - 1 ) + "_pol.slk".
OUTPUT TO VALUE(fi_output1).   /*out put file full policy */
EXPORT DELIMITER "|"
    "�ӴѺ               "                                        
    "�Ţ�Ѻ��          "                                        
    "���������������   "                                        
    "����ú. ����      "                                        
    "��������������   "                                        
    "�ѹ����駻�Сѹ��� "                                        
    "�ӹ�˹��            "                                        
    "���� � ʡ��         "                                        
    "�����١���          "                                        
    "�����1��             "                                        
    "�����2��             "                                        
    "������              "                                        
    "���ö              "                                        
    "����¹ö           "                                        
    "��ö                "                                        
    "�Ţ��Ƕѧ           "                                        
    "�Ţ����ͧ          "                                        
    "CC                  "                                        
    "����Ѻ�Ż���ª��     "                                        
    "Sticker No           "                                        
    "������������ö     "                                        
    "����������������ͧ  "                                        
    "���ͼ��Ѻ��� 1     "                                        
    "�ѹ�Դ���Ѻ���1   "                                        
    "�Ţ���㺢Ѻ��� 1    "                                        
    "���ͼ��Ѻ��� 1     "                                        
    "�ѹ�Դ���Ѻ���1   "                                        
    "�Ţ���㺢Ѻ��� 1    "                                        
    "�ѹ�����������ͧ    "                                        
    "�ѹ�������          "                                        
    "�ѹ�����������ͧ    "                                        
    "�ѹ�������          "                                        
    "�ع��Сѹ           "                                        
    "���»�Сѹ����Ҥ��Ѥ��"                                    
    "���»�Сѹ����Ҥ�ѧ�Ѻ "                                    
    "���»�Сѹ������ �ú   "                                    
    "FirstOD                 "                                    
    "FirstTPPD               "                                    
    "�����Ѻ�Դ��ͺؤ����¹͡ (�Ҵ���������ª��Ե ��ͤ�)     "  
    "�����Ѻ�Դ��ͺؤ����¹͡ (�Ҵ���������ª��Ե ��ͤ���)  "  
    "�����Ѻ�Դ��ͺؤ����¹͡ (��Ѿ���Թ ��ͤ���)             "  
    "����������µ��ö¹������һ�Сѹ���(����������µ�͵��ö)  "  
    "����������µ��ö¹������һ�Сѹ���(����٭�����������)   "  
    "���¤���������ͧ(��û�Сѹ�غѵ��˵���ǹ�ؤ�� ����)       "  
    "���¤���������ͧ(��û�Сѹ����ѡ�Ҿ�Һ�� ����)            "  
    "���¤���������ͧ(��û�Сѹ��Ǽ��Ѻ��褴��ҭ�)            "  
    "��ǹŴ�����     "                                            
    "��ǹŴ����ѵԴ� "                                            
    "��ǹŴ��� �    "                                            
    "�ӹǹ�����    "                                            
    "�����˵�        "                                            
    "�����˵�        "                                            
    "�����˵�        "                                            
    "ContractNo      "                                            
    "UserClosing     "                                            
    "TempPolicyNo    "                                            
    "Campaign        " 
    "ICNO            " .    /*a60-0272*/                                     
   
ASSIGN nv_numberno = 0.  /*-A57-0432 */
FOR EACH wdetail WHERE wdetail.icno <> ""  NO-LOCK.
    ASSIGN n_count  = n_count + 1
        nv_numberno = nv_numberno  + 1.
    EXPORT DELIMITER "|" 
        nv_numberno            /*-A57-0432 */
        wdetail.cedpol           /*RefNo           */ 
        wdetail.policy           /*PolicyNo        */
        wdetail.compol           /*CMIPolicyNo     */ 
        wdetail.prepol           /*OldPolicyNo     */    
        wdetail.accdat           /*ClosingDate     */ 
        wdetail.tiname           /*ClientTitle     */ 
        wdetail.insnam           /*ClientName      */                                             
        wdetail.delerno          /*ClientCode      */                  
        wdetail.addr1            /*ClientAddress1  */                                
        wdetail.addr2            /*ClientAddress2  */                               
        wdetail.brand            /*Brand           */                               
        wdetail.model            /*Model           */                               
        wdetail.vehreg           /*CarID           */                               
        wdetail.caryear          /*RegisterYear    */                               
        wdetail.chasno           /*ChassisNo       */                               
        wdetail.eng              /*EngineNo        */                               
        wdetail.engcc            /*CC              */ 
        wdetail.benname          /*Beneficiary     */ 
        wdetail.stk              /*CMIStickerNo    */                               
        wdetail.garage           /*Garage          */                               
        wdetail.covcod           /*InsureType      */                               
        wdetail.drive1           /*Driver1         */
        wdetail.bdate1 
        wdetail.id1    
        wdetail.drive2           /*Driver2         */ 
        wdetail.bdate2 
        wdetail.id2    
        wdetail.comdat           /*VMIStartDate    */                   
        wdetail.expdat           /*VMIEndDate      */                   
        wdetail.comdat72         /*CMIStartDate    */                 
        wdetail.expdat72         /*CMIEndDate      */                  
        wdetail.si               /*SumInsured      */                        
        wdetail.premt            /*VMITotalPremium */                  
        wdetail.comprem          /*CMITotalPremium */                  
        Wdetail.prmtotal          /*TotalPremium    */                  
        wdetail.deductpd         /*FirstOD         */ 
        wdetail.deductpd2        /*FirstTPPD       */                                 
        wdetail.tp1              /*TPBIPerson      */                                
        wdetail.tp2              /*TPBITime        */                                
        wdetail.tp3              /*TPPD            */ 
        wdetail.si2              /*OD              */ 
        wdetail.fire             /*FT              */ 
        wdetail.NO_41            /*RY01            */ 
        wdetail.NO_42            /*RY02            */ 
        wdetail.NO_43            /*RY03            */ 
        wdetail.dspc             /*DiscountGroup   */ 
        wdetail.fleet            /*DiscountHistory */ 
        wdetail.ncb              /*DiscountOther   */ 
        wdetail.seat             /*Seat            */ 
        wdetail.remark           /*RemarkInsurer1  */ 
        wdetail.remark2          /*RemarkInsurer2  */ 
        wdetail.remark3          /*RemarkInsurer3  */ 
        wdetail.contractno       /*ContractNo      */ 
        wdetail.userc            /*UserClosing     */ 
        wdetail.tempol          /*TempPolicyNo    */ 
        wdetail.n_campaigns      /*Campaign        */ 
        wdetail.icno             /*icno */ /*a60-0272*/
       /* Wdetail.paiddat          /*Paid Date       */ 
        Wdetail.typepaid         /*DN/CN           */ 
        Wdetail.paidno           /*Ref # (DN/CN)   */ 
        Wdetail.remarkpaid       /*Remark_paid     */ 
        Wdetail.paidtyp          /*Paid  Type      */ 
        Wdetail.n_branch         /*BR              */ 
        Wdetail.subclass         /*class           */ 
        wdetail.comment*/  .
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exportfilematp2 c-Win 
PROCEDURE proc_exportfilematp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR  nv_output AS CHAR FORMAT "x(60)".
DEF VAR n_count AS DECI INIT 0.

IF INDEX(fi_output1,".slk") = 0  THEN 
    nv_output = fi_output1 + "1.slk".
ELSE 
    nv_output = substr(fi_output1,1,INDEX(fi_output1,".slk") - 1 ) + "_1.slk".

OUTPUT TO VALUE(nv_output).   /*out put file full policy */
EXPORT DELIMITER "|"   
    "�ӴѺ���"
    "�Ţ�Ѻ��, �Ţ����ѭ��"    
    "����ѷ��Сѹ���"
    "�ѹ����駻�Сѹ���"
    "�ӹ�"
    "���ͼ����һ�Сѹ���"                                                                                       
    "�����١���"                                                          
    "�����������һ�Сѹ���"                                                                        
    "������/��� "                                                                                   
    "����¹ö   "                                                                                   
    "�ը�����¹ "                                                                                   
    "�Ţ��Ƕѧ   "                                                                                   
    "�Ţ����ͧ¹��"                                                                                 
    "��Ҵ����ͧ¹��"                                                                                
    "����Ѻ�Ż���ª��"                                                                            
    "������"
    "������"  
    "����ͧ���� �ú "                                                                                 
    "�������� �ú    "                                                                                 
    "20  �ٹ�����ö "                                                                                     
    "����������������ͧ"                                                                            
    "�ѹ��������������ͧ"                                                                            
    "�ع��Сѹ���"                                        
    "���»�Сѹ����Ҥ��Ѥ��"                                                         
    "���»�Сѹ������ �ú"                                                           
    "�������������ǹ�á"                                                               
    "�����Ѻ�Դ��ͺؤ����¹͡ (�Ҵ���������ª��Ե ��ͤ�)"                          
    "�����Ѻ�Դ��ͺؤ����¹͡ (�Ҵ���������ª��Ե ��ͤ���)"                        
    "�����Ѻ�Դ��ͺؤ����¹͡ (��Ѿ���Թ ��ͤ���)"                                        
    "����������µ��ö¹������һ�Сѹ���(����������µ�͵��ö)"                       
    "����������µ��ö¹������һ�Сѹ���(����٭�����������)"                            
    "���¤���������ͧ(��û�Сѹ�غѵ��˵���ǹ�ؤ�� ����)"                               
    "���¤���������ͧ(��û�Сѹ����ѡ�Ҿ�Һ�� ����)"          
    "���¤���������ͧ(��û�Сѹ��Ǽ��Ѻ��褴��ҭ�)"                                                   
    "��ǹŴ�����"                                                                                    
    "��ǹŴ����ѵԴ�"                                                                               
    "��ǹŴ��� �"                                          
    "�ӹǹ�����"                                             
    "�����˵�"                                               
    "�͡�����㹹��"                                           
    "�������������"
    "�͡�����㹹��"                                          
    "�������������"
    "campaign"
    "�ػ�ó������"
    "class" 
    "ID_Card_NO"     
    "�Ţ��������"     
    "�ѹ����͡ ��������"       .   
ASSIGN nv_numberno = 0.  /*-A57-0432 */
FOR EACH wdetail   NO-LOCK 
    BREAK BY DECI(wdetail.n_branch) .       
    IF wdetail.cedpol = "" THEN NEXT.
    EXPORT DELIMITER "|" 
        wdetail.n_branch       /* 1  �ӴѺ���                */   
        wdetail.cedpol         /* 2  �Ţ�Ѻ��, �Ţ����ѭ�� */      
        wdetail.delername      /* 3  ����ѷ��Сѹ���         */
        wdetail.entdat         /* 4  �ѹ����駻�Сѹ���     */ 
        wdetail.tiname         /* 5  �ӹ�                    */
        wdetail.insnam         /* 6  ���ͼ����һ�Сѹ���     */                                                                                       
        wdetail.insnam2        /* 7  �����١���              */                                                            
        wdetail.addr1          /* 8  �����������һ�Сѹ���  */                                                                          
        wdetail.model          /* 9  ������/��� */                                                                                     
        wdetail.vehreg         /*10  ����¹ö   */                                                                                     
        wdetail.caryear        /*11  �ը�����¹ */                                                                                     
        wdetail.chasno         /*12  �Ţ��Ƕѧ   */                                                                                     
        wdetail.eng            /*13  �Ţ����ͧ¹��  */                                                                                 
        wdetail.engCC          /*14  ��Ҵ����ͧ¹�� */                                                                                 
        wdetail.benname        /*15  ����Ѻ�Ż���ª��    */                                                                             
        wdetail.docno          /*16  ������     */   
        wdetail.delerno        /*17  ������     */   
        wdetail.stk            /*18  ����ͧ���� �ú */                                                                                 
        wdetail.prepol         /*19  �������� �ú    */                                                                                 
        wdetail.garage         /*20  �ٹ�����ö */                                                                                     
        wdetail.covcod         /*21  ����������������ͧ  */                                                                             
        wdetail.comdat         /*22  �ѹ��������������ͧ */                                                                             
        wdetail.comacc         /*23  �ع��Сѹ���    */                                            
        wdetail.premt          /*24  ���»�Сѹ����Ҥ��Ѥ��    */                                                         
        wdetail.comper         /*25  ���»�Сѹ������ �ú   */                                                             
        wdetail.deductpd       /*26  �������������ǹ�á  */                                                                 
        wdetail.tp1            /*27  �����Ѻ�Դ��ͺؤ����¹͡ (�Ҵ���������ª��Ե ��ͤ�)   */                           
        wdetail.tp2            /*28  �����Ѻ�Դ��ͺؤ����¹͡ (�Ҵ���������ª��Ե ��ͤ���)    */                        
        wdetail.tp3            /*29  �����Ѻ�Դ��ͺؤ����¹͡ (��Ѿ���Թ ��ͤ���)   */                                          
        wdetail.si             /*30  ����������µ��ö¹������һ�Сѹ���(����������µ�͵��ö)    */                        
        wdetail.fire           /*31  ����������µ��ö¹������һ�Сѹ���(����٭�����������) */                            
        wdetail.NO_41          /*32  ���¤���������ͧ(��û�Сѹ�غѵ��˵���ǹ�ؤ�� ����) */                                
        wdetail.NO_42          /*33  ���¤���������ͧ(��û�Сѹ����ѡ�Ҿ�Һ�� ����)  */            
        wdetail.NO_43          /*34  ���¤���������ͧ(��û�Сѹ��Ǽ��Ѻ��褴��ҭ�)  */                                                   
        wdetail.fleet          /*35  ��ǹŴ����� */                                                                                      
        wdetail.ncb            /*36  ��ǹŴ����ѵԴ� */                                                                                  
        wdetail.volprem        /*37  ��ǹŴ��� �  */                                              
        wdetail.seat           /*38  �ӹǹ����� */                                               
        wdetail.comment        /*39  �����˵�  */                                                  
        wdetail.receipt_name   /*40  �͡�����㹹�� */                                            
        wdetail.tambon         /*41  �������������*/  
        wdetail.amper          /*42  �͡�����㹹�� */                                            
        wdetail.country        /*43  �������������*/  
        wdetail.renpol         /*44  campaign  */
        wdetail.accesstxt      /*45  �ػ�ó������ */
        wdetail.subclass       /*46  class        */   
        wdetail.icno           /*A56-0243*/
        wdetail.policy         
        wdetail.trandat   .       
END.*/
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
DEFINE VAR nv_transfer  AS LOGICAL   .
ASSIGN  
    n_insref      = ""  
    n_check       = ""
    nv_insref     = "" 
    nv_transfer   = YES. 
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME     = TRIM(wdetail.insnam)   AND 
    /*sicsyac.xmm600.homebr   = TRIM(wdetail.n_branch) NO-ERROR NO-WAIT. *//* A56-0047 */
    sicsyac.xmm600.homebr   = TRIM(wdetail.n_branch) AND                   /* A56-0047 */
    sicsyac.xmm600.clicod   = "IN"                   NO-ERROR NO-WAIT.     /* A56-0047 */  
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
        RUN proc_insno .
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
            sicsyac.xmm600.addr1    = trim(wdetail.addr1)                                          /*Address line 1*/
            sicsyac.xmm600.addr2    = trim(wdetail.tambon)                                         /*Address line 2*/
            sicsyac.xmm600.addr3    = trim(wdetail.amper) + " " + trim(wdetail.country)            /*Address line 3*/
            sicsyac.xmm600.addr4    = ""                                                           
            sicsyac.xmm600.homebr   = TRIM(wdetail.n_branch)      /*Home branch*/
            sicsyac.xmm600.opened   = TODAY                     
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4) 
            sicsyac.xmm600.dtyp20   = ""
            sicsyac.xmm600.dval20   = ""   .     
       
    END.
END.
IF nv_transfer = YES THEN DO:     
    ASSIGN  sicsyac.xmm600.acno = trim(nv_insref)                 /*Account no*/
        sicsyac.xmm600.gpstcs   = TRIM(nv_insref)                 /*Group A/C for statistics*/
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
        sicsyac.xmm600.addr1    = trim(wdetail.addr1)                                           /*Address line 1*/
        sicsyac.xmm600.addr2    = trim(wdetail.tambon)                                          /*Address line 2*/
        sicsyac.xmm600.addr3    = trim(wdetail.amper) + " " + trim(wdetail.country)             /*Address line 3*/
        sicsyac.xmm600.addr4    = ""                                                            /*Address line 4*/
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
        sicsyac.xmm600.usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4)               /*Userid*/
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
        sicsyac.xmm600.anlyc5   = ""                      /*Analysis Code 5*/
        sicsyac.xmm600.dtyp20   = ""
        sicsyac.xmm600.dval20   = "".
        
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
            sicsyac.xtm600.addr1   = trim(wdetail.addr1)                                         /*address line 1*/
            sicsyac.xtm600.addr2   = trim(wdetail.tambon)                                        /*address line 2*/
            sicsyac.xtm600.addr3   = trim(wdetail.amper) + " " + trim(wdetail.country)           /*address line 3*/
            sicsyac.xtm600.addr4   = ""                                                          /*address line 4*/
            sicsyac.xtm600.name2   = ""                      /*Name of Insured Line 2*/ 
            sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)    /*Title*/
            sicsyac.xtm600.name3   = ""                      /*Name of Insured Line 3*/
            sicsyac.xtm600.fname   = "" .                    /*First Name*/
    END.
END.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
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
    sicsyac.xmm600.acno_typ  = trim(wdetail.insnamtyp)  /*�������١��� CO = �ԵԺؤ��  PR = �ؤ��*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    sicsyac.xmm600.icno      = trim(wdetail.icno)       
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/ .  
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN
    ASSIGN 
    sicsyac.xtm600.postcd    = trim(wdetail.postcd)         
    sicsyac.xtm600.firstname = trim(wdetail.firstName)      
    sicsyac.xtm600.lastname  = trim(wdetail.lastName)   .   
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
DEF VAR nv_lastno  AS INT INIT 0.                              
DEF VAR nv_seqno   AS INT INIT 0.                              
ASSIGN  nv_insref = "" .
FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
    sicsyac.xzm056.seqtyp   =  nv_typ        AND
    sicsyac.xzm056.branch   =  TRIM(wdetail.n_branch)    NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN sicsyac.xzm056.seqtyp =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.n_branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref = TRIM(wdetail.n_branch)  + String(1,"999999")
            nv_lastno = 1.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(TRIM(wdetail.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail.n_branch) + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:   
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
                ELSE nv_insref =       TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.n_branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(TRIM(wdetail.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                    nv_insref  = "7" + TRIM(wdetail.n_branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.n_branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                     nv_insref = "7" + TRIM(wdetail.n_branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref =       TRIM(wdetail.n_branch) + "C" + STRING(sicsyac.xzm056.lastno,"99999").
            END.
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  TRIM(wdetail.n_branch)
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(TRIM(wdetail.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
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
                ELSE nv_insref =       TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.   
        END.
    END.
    ELSE DO:
        IF LENGTH(TRIM(wdetail.n_branch)) = 2 THEN
            nv_insref = TRIM(wdetail.n_branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                     nv_insref = "7" + TRIM(wdetail.n_branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.n_branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                     nv_insref = "7" + TRIM(wdetail.n_branch) + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref =       TRIM(wdetail.n_branch) + "C" + STRING(sicsyac.xzm056.lastno,"99999").
            END.
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
                sicsyac.xzm056.branch    =  TRIM(wdetail.n_branch)
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
                sicsyac.xzm056.branch    =  TRIM(wdetail.n_branch)
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
  nv_drivage1 = 0 .
  nv_drivage2 = 0 .
  nv_drivage1 =  YEAR(TODAY) - INT(SUBSTR(wdetail.bdate1,7,4)) + 543.
  nv_drivage2 =  YEAR(TODAY) - INT(SUBSTR(wdetail.bdate2,7,4)) + 543.

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
                     brstat.mailtxt_fil.ltext     = wdetail.drive1 + FILL(" ",50 - LENGTH(wdetail.drive1)). 
                     brstat.mailtxt_fil.ltext2    = wdetail.bdate1 + "  " 
                                                  + string(nv_drivage1).
                     nv_drivno                    = 1.

                     ASSIGN /*a490166*/
                     brstat.mailtxt_fil.bchyr = nv_batchyr 
                     brstat.mailtxt_fil.bchno = nv_batchno 
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                     SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
                     SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = "-"
                     SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.id1). 

              IF wdetail.drive2 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil. 
                    ASSIGN
                        brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                        brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                        brstat.mailtxt_fil.ltext    = wdetail.drive2 + FILL(" ",50 - LENGTH(wdetail.drive2)). 
                        brstat.mailtxt_fil.ltext2   = wdetail.bdate2 + "  "
                                                    + string(nv_drivage2). 
                        nv_drivno                   = 2.
                        ASSIGN /*a490166*/
                        brstat.mailtxt_fil.bchyr = nv_batchyr 
                        brstat.mailtxt_fil.bchno = nv_batchno 
                        brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                        SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
                        SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = "-"
                        SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.id2). 
              END.  /*drivnam2 <> " " */
        END. /*End Avail Brstat*/
        ELSE  DO:
              CREATE  brstat.mailtxt_fil.
              ASSIGN  brstat.mailtxt_fil.policy     = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
                      brstat.mailtxt_fil.lnumber    = nv_lnumber.
                      brstat.mailtxt_fil.ltext      = wdetail.drive1 + FILL(" ",50 - LENGTH(wdetail.drive1)). 
                      brstat.mailtxt_fil.ltext2     = wdetail.bdate1 + "  "
                                                    +  TRIM(string(nv_drivage1)).
                        ASSIGN /*a490166*/
                        brstat.mailtxt_fil.bchyr = nv_batchyr 
                        brstat.mailtxt_fil.bchno = nv_batchno 
                        brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                        SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
                        SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = "-"
                        SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.id1). 

                      IF wdetail.drive2 <> "" THEN DO:
                            CREATE  brstat.mailtxt_fil.
                                ASSIGN
                                brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                                brstat.mailtxt_fil.ltext    = wdetail.drive2 + FILL(" ",50 - LENGTH(wdetail.drive2)). 
                                brstat.mailtxt_fil.ltext2   = wdetail.bdate2 + "  "
                                                            + TRIM(string(nv_drivage1)).
                                ASSIGN /*a490166*/
                                brstat.mailtxt_fil.bchyr = nv_batchyr 
                                brstat.mailtxt_fil.bchno = nv_batchno 
                                brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                                SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"  
                                SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = "-"
                                SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = TRIM(wdetail.id2). 
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
IF (wdetail.si = "") OR (wdetail.si = "0.00") OR (wdetail.si = "0" ) THEN DO:
    Find LAST stat.maktab_fil Use-index      maktab04           Where
        stat.maktab_fil.makdes   =    wdetail.brand             And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And 
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
        index(stat.maktab_fil.moddes,wdetail.model) <> 0          And
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
        index(stat.maktab_fil.moddes,wdetail.model) <> 0          And
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
For each  wdetail :                             
    DELETE  wdetail.                            
END.
INPUT FROM VALUE (fi_filename) .                                   
REPEAT: 
    CREATE wdetail.                /*create wdetail....fi_filename2 file pov..... */
    IMPORT DELIMITER "|" 
        wdetail.icno             /*NO              */ 
       /* wdetail.poltyp  */         /*Type            */ 
        wdetail.cedpol           /*RefNo           */ 
        wdetail.accdat           /*ClosingDate     */ 
        wdetail.tiname           /*ClientTitle     */ 
        wdetail.insnam           /*ClientName      */                                             
        wdetail.delerno          /*ClientCode      */                  
        wdetail.addr1            /*ClientAddress1  */                                
        wdetail.addr2            /*ClientAddress2  */                               
        wdetail.brand            /*Brand           */                               
        wdetail.model            /*Model           */                               
        wdetail.vehreg           /*CarID           */                               
        wdetail.caryear          /*RegisterYear    */                               
        wdetail.chasno           /*ChassisNo       */                               
        wdetail.eng              /*EngineNo        */                               
        wdetail.engcc            /*CC              */ 
        wdetail.benname          /*Beneficiary     */ 
        wdetail.prepol           /*OldPolicyNo     */                               
        wdetail.stk              /*CMIStickerNo    */                               
        wdetail.compol           /*CMIPolicyNo     */                               
        wdetail.garage           /*Garage          */                               
        wdetail.covcod           /*InsureType      */                               
        wdetail.drive1          /*Driver1         */ 
        wdetail.bdate1  
        wdetail.id1     
        wdetail.drive2          /*Driver2         */  
        wdetail.bdate2  
        wdetail.id2     
        wdetail.comdat           /*VMIStartDate    */                   
        wdetail.expdat           /*VMIEndDate      */                   
        wdetail.comdat72         /*CMIStartDate    */                 
        wdetail.expdat72         /*CMIEndDate      */                  
        wdetail.si               /*SumInsured      */                        
        wdetail.premt            /*VMITotalPremium */                  
        wdetail.comprem          /*CMITotalPremium */                  
        Wdetail.prmtotal          /*TotalPremium    */                  
        wdetail.deductpd         /*FirstOD         */ 
        wdetail.deductpd2        /*FirstTPPD       */                                 
        wdetail.tp1              /*TPBIPerson      */                                
        wdetail.tp2              /*TPBITime        */                                
        wdetail.tp3              /*TPPD            */ 
        wdetail.si2              /*OD              */ 
        wdetail.fire             /*FT              */ 
        wdetail.NO_41            /*RY01            */ 
        wdetail.NO_42            /*RY02            */ 
        wdetail.NO_43            /*RY03            */ 
        wdetail.dspc             /*DiscountGroup   */ 
        wdetail.fleet            /*DiscountHistory */ 
        wdetail.ncb              /*DiscountOther   */ 
        wdetail.seat             /*Seat            */ 
        wdetail.remark           /*RemarkInsurer1  */ 
        wdetail.remark2          /*RemarkInsurer2  */ 
        wdetail.remark3          /*RemarkInsurer3  */ 
        wdetail.contractno       /*ContractNo      */ 
        wdetail.userc            /*UserClosing     */ 
        wdetail.policy           /*PolicyNo        */ 
        wdetail.tempol          /*TempPolicyNo    */ 
        wdetail.n_campaigns      /*Campaign        */ 
        wdetail.icno             /*icno           */ /*a60-0272*/
        Wdetail.paiddat          /*Paid Date       */ 
        Wdetail.typepaid         /*DN/CN           */ 
        Wdetail.paidno           /*Ref # (DN/CN)   */ 
        Wdetail.remarkpaid       /*Remark_paid     */ 
        Wdetail.paidtyp          /*Paid  Type      */ 
        Wdetail.n_branch         /*BR              */ 
        Wdetail.subclass  .       /*class           */ 
    IF        INDEX(wdetail.icno,"�ӴѺ")   <> 0  THEN DELETE wdetail.
    ELSE IF   INDEX(wdetail.icno,"No")      <> 0  THEN DELETE wdetail. 
    ELSE IF   trim(wdetail.icno) = " " THEN DELETE wdetail.
END.
RUN proc_assignmatpol.  
RUN proc_exportfilematp.  
RUN proc_exportfilematp2. 

/*RUN proc_assign.  
RUN proc_exportfile. 
RUN proc_exportfile2. *//* Add  kridtiya i. A56-0114  */
MESSAGE "Export data complete " VIEW-AS ALERT-BOX.   /* Add  kridtiya i. A56-0114  */
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
    IF wdetail.poltyp = "V72" THEN DO:
      FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT. 
      IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN  
                ASSIGN wdetail.pass = "N"
                wdetail.comment     = wdetail.comment + "| �Ţ������������١������� "
                wdetail.warning     = "Program Running Policy No. �����Ǥ���".
      END.
    END.
    ELSE DO:
      FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
          /*sicuw.uwm100.cedpol   =  wdetail.cedpol    NO-LOCK NO-ERROR NO-WAIT.*/ /*A56-0352*/
          sicuw.uwm100.cedpol   =  wdetail.cedpol  AND                             /*A56-0352*/
          sicuw.uwm100.poltyp   =  "V70"   NO-LOCK NO-ERROR NO-WAIT.               /*A56-0352*/
      IF AVAIL sicuw.uwm100 THEN DO:
          IF sicuw.uwm100.expdat > DATE(wdetail.comdat)   THEN DO: 
            ASSIGN wdetail.pass = "N"
            wdetail.comment     = wdetail.comment + "| �Ţ����ѭ�ҹ����١������� 1 "
            wdetail.warning     = "Program Running Policy No. �����Ǥ���".
          END.
      END.
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
  END.         /*wdetail.stk  <>  ""*/
  ELSE DO:   /*sticker = ""*/ 
      /*FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy = wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| �����Ţ������������١������� "
                wdetail.warning = "Program Running Policy No. �����Ǥ���".*/
    IF wdetail.poltyp = "V72" THEN DO:
      FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
        sicuw.uwm100.policy =  wdetail.policy NO-LOCK NO-ERROR NO-WAIT. 
      IF AVAIL sicuw.uwm100 THEN DO:
        IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN  
          ASSIGN wdetail.pass = "N"
            wdetail.comment     = wdetail.comment + "| �Ţ������������١������� "
            wdetail.warning     = "Program Running Policy No. �����Ǥ���".
        ELSE RUN proc_create100.
      END.
      ELSE RUN proc_create100.
    END.
    ELSE DO:
      FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
          /*sicuw.uwm100.policy =  wdetail.policy NO-ERROR NO-WAIT.*/
          /*sicuw.uwm100.cedpol   =  wdetail.cedpol    NO-LOCK NO-ERROR NO-WAIT.*/ /*A56-0352*/
          sicuw.uwm100.cedpol   =  wdetail.cedpol  AND                             /*A56-0352*/
          sicuw.uwm100.poltyp   =  "V70"   NO-LOCK NO-ERROR NO-WAIT.               /*A56-0352*/
      IF AVAIL sicuw.uwm100 THEN DO:
         /*IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN */
         IF sicuw.uwm100.expdat > DATE(wdetail.comdat)   THEN 
           ASSIGN wdetail.pass = "N"
           wdetail.comment     = wdetail.comment + "| �Ţ����ѭ�ҹ����١������� 2 "
           wdetail.warning     = "Program Running Policy No. �����Ǥ���".
         IF wdetail.policy = "" THEN DO:
           RUN proc_temppolicy.
           wdetail.policy  = nv_tmppol.
         END.
         RUN proc_create100. 
      END.
      ELSE RUN proc_create100.  
    END.
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
      /*FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
      sicuw.uwm100.policy =  wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| �����Ţ������������١������� "
                wdetail.warning = "Program Running Policy No. �����Ǥ���".
        END.*/
    IF wdetail.poltyp = "V72" THEN DO:
      FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
        sicuw.uwm100.policy =  wdetail.policy NO-LOCK NO-ERROR NO-WAIT. 
      IF AVAIL sicuw.uwm100 THEN DO:
        IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN  
            ASSIGN wdetail.pass = "N"
            wdetail.comment     = wdetail.comment + "| �Ţ������������١������� "
            wdetail.warning     = "Program Running Policy No. �����Ǥ���".
      END.
    END.
    ELSE DO:
      FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
          /*sicuw.uwm100.cedpol   =  wdetail.cedpol    NO-LOCK NO-ERROR NO-WAIT.*/ /*A56-0352*/
          sicuw.uwm100.cedpol   =  wdetail.cedpol  AND                             /*A56-0352*/
          sicuw.uwm100.poltyp   =  "V70"   NO-LOCK NO-ERROR NO-WAIT.               /*A56-0352*/
      IF AVAIL sicuw.uwm100 THEN DO:
        IF sicuw.uwm100.expdat > DATE(wdetail.comdat)   THEN  
            ASSIGN wdetail.pass = "N"
            wdetail.comment     = wdetail.comment + "| �Ţ����ѭ�ҹ����١������� 3 "
            wdetail.warning     = "Program Running Policy No. �����Ǥ���".
      END.
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
  ASSIGN nv_docno  = wdetail.Docno
  nv_accdat = TODAY.
ELSE DO:
  IF wdetail.docno  = "" THEN nv_docno  = "".
  IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
IF wdetail.poltyp = "v72" THEN ASSIGN wdetail.insnam2  = ""
                                      wdetail.insnam3  = "" .
ASSIGN nv_insref = "".   /*A56-0352*/
RUN proc_insnam.         /*A56-0352*/
RUN proc_insnam2 . /*Add by Kridtiya i. A63-0472*/
DO TRANSACTION: 
  ASSIGN sic_bran.uwm100.renno  = ""
  sic_bran.uwm100.endno  = ""
  sic_bran.uwm100.poltyp = trim(wdetail.poltyp)
  sic_bran.uwm100.insref = trim(nv_insref)
  sic_bran.uwm100.opnpol = ""
  /*sic_bran.uwm100.anam2  = ""                      /* ICNO  Cover Note A51-0071 Amparat */*//*A56-0243*/    
  sic_bran.uwm100.anam2  = trim(wdetail.icno)              /*A56-0243*/           
  sic_bran.uwm100.ntitle = trim(wdetail.tiname)      
  sic_bran.uwm100.name1  = trim(wdetail.insnam)      
  sic_bran.uwm100.name2  = trim(wdetail.insnam2)                              /*wdetail.receipt_name        ���/���� */              
  sic_bran.uwm100.name3  = TRIM(wdetail.insnam3)                       
  sic_bran.uwm100.addr1  = trim(wdetail.addr1)         
  sic_bran.uwm100.addr2  = trim(wdetail.tambon)        
  sic_bran.uwm100.addr3  = trim(wdetail.amper)   
  sic_bran.uwm100.addr4  = trim(wdetail.country)                         
  sic_bran.uwm100.postcd = ""                          
  sic_bran.uwm100.undyr  = String(Year(today),"9999")        /*   nv_undyr  */
  sic_bran.uwm100.branch = trim(wdetail.n_branch)            /* nv_branch  */                        
  sic_bran.uwm100.dept   = nv_dept                     
  sic_bran.uwm100.usrid  = USERID(LDBNAME(1))          
  /*sic_bran.uwm100.fstdat = TODAY  */                 /*TODAY *//*kridtiya i. a53-0171*/
  sic_bran.uwm100.fstdat = DATE(wdetail.comdat)        /*DATE(wdetail.firstdat) *//*kridtiya i. a53-0171 ��� firstdate=comdate */
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
  sic_bran.uwm100.prog   = "wgwnsgen"
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
  sic_bran.uwm100.acno1  = trim(wdetail.producer)   /*  nv_acno1 */
  sic_bran.uwm100.agent  = trim(wdetail.agent)      /*nv_agent   */
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
  sic_bran.uwm100.cr_2    = wdetail.cr_2
  sic_bran.uwm100.bchyr   = nv_batchyr            /*Batch Year */  
  sic_bran.uwm100.bchno   = nv_batchno            /*Batch No.  */  
  sic_bran.uwm100.bchcnt  = nv_batcnt             /*Batch Count*/  
  sic_bran.uwm100.prvpol  = trim(wdetail.prepol)       
  sic_bran.uwm100.cedpol  = trim(wdetail.cedpol)  
  sic_bran.uwm100.finint  = wdetail.delerno      /*code deler */
  sic_bran.uwm100.bs_cd   = ""                  /*wdetail.vatcode*/    
  /* sic_bran.uwm100.opnpol  = CAPS(wdetail.ins_pay) */ 
  /*sic_bran.uwm100.endern  = date(wdetail.ac_date)*/ 
  sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)  /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)   /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.postcd     = trim(wdetail.postcd)     /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.icno       = trim(wdetail.icno)       /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)    /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)   /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)   /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)   /*Add by Kridtiya i. A63-0472*/
  /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*/  /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov). /*Add by Kridtiya i. A63-0472*/
  IF wdetail.prepol <> " " THEN DO:
    IF wdetail.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = ""
        sic_bran.uwm100.tranty  = "R".  
    ELSE ASSIGN  sic_bran.uwm100.prvpol  = wdetail.prepol     /*����繧ҹ Renew  ��ͧ����繤����ҧ*/
        sic_bran.uwm100.tranty  = "R".                   /*Transaction Type (N/R/E/C/T)*/
  END.
  IF wdetail.pass = "Y" THEN sic_bran.uwm100.impflg  = YES.
  ELSE sic_bran.uwm100.impflg  = NO.
  IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
  IF wdetail.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
  ELSE  sic_bran.uwm100.polsta = "IF".
  IF fi_loaddat <> ? THEN sic_bran.uwm100.trndat = fi_loaddat.
  ELSE sic_bran.uwm100.trndat = TODAY.
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
       MONTH(sic_bran.uwm100.expdat)    =  03                             AND
       YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
      THEN  nv_polday = 365.
  ELSE  nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  �ѹ */
END.   /*transaction*//**/
IF wdetail.poltyp = "v70" THEN DO:
    /*  IF (wdetail.accesstxt   <> " " ) OR (wdetail.receipt_name <> " " ) THEN RUN proc_uwd100. */  /*memmo F17 */
    RUN proc_uwd102.   /*memmo F18 */
END.
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
  sic_bran.uwm120.bchyr  = nv_batchyr       /* batch Year */
  sic_bran.uwm120.bchno  = nv_batchno       /* bchno    */
  sic_bran.uwm120.bchcnt = nv_batcnt .      /* bchcnt     */
  ASSIGN  sic_bran.uwm120.class  = IF wdetail.poltyp = "v72" THEN wdetail.subclass 
                                   ELSE wdetail.prempa + wdetail.subclass  
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
    sicuw.uwm100.policy = wdetail.prepol No-lock No-error no-wait.
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
        wdetail.comment = wdetail.comment + "| �繡������������بҡ����ѷ���  ".
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
    "WARNING     " SKIP.                                                   
FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"    : 
    PUT STREAM ns1 
        wdetail.redbook    "," 
        wdetail.n_branch   ","
        wdetail.policy     ","
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
   "Redbook  "     ","
   "policyno "    ","   
   "Branch   "     ","   
   "cndat    "     "," 
   "comdat   "      ","  
   "expdat   "      ","  
   "covcod   "      ","  
   "garage   "      ","  
   "tiname   "      ","  
   "insnam   "      ","  
   "addr     "      ","  
   "tambon   "      ","  
   "amper    "      ","  
   "country  "      ","  
   "brand    "      ","  
   "cargrp   "      ","  
   "chasno   "      ","  
   "eng      "      ","  
   "model    "      ","  
   "caryear  "      ","  
   "body     "      ","  
   "vehuse   "      ","  
   "seat     "      ","  
   "engcc    "      ","  
   "vehreg   "      ","  
   "si       "      ","  
   "premt    "      ","  
   "ncb      "      ","  
   "stk      "      ","  
   "prepol   "      ","  
   "benname  "      ","  
   "comper   "      ","  
   "comacc   "      ","  
   "deductpd "      ","  
   "compul   "      ","  
   "pass     "      ","  
   "comment  "      ","  
   "WARNING  "       SKIP.        
FOR EACH  wdetail   WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
            wdetail.redbook  format "X(10)"      ","   
            wdetail.policy   format "X(20)"      ","
            wdetail.n_branch format "X(2)"      ","
            wdetail.cndat    format "X(15)"      ","
            wdetail.comdat   format "X(15)"      ","
            wdetail.expdat   format "X(15)"      ","
            wdetail.covcod   format "X(3)"      ","
            wdetail.garage   format "X(1)"      "," 
            wdetail.tiname   format "X(20)"      ","
            wdetail.insnam   format "X(60)"      ","
            wdetail.addr1    format "X(40)"      ","  
            wdetail.tambon   format "X(40)"      ","  
            wdetail.amper    format "X(40)"      ","  
            wdetail.country  format "X(40)"      ","  
            wdetail.brand    format "X(25)"      ","               
            wdetail.cargrp   format "X(4)"      ","               
            wdetail.chasno   format "X(20)"      ","               
            wdetail.eng      format "X(20)"      ","               
            wdetail.model    format "X(30)"      "," 
            wdetail.caryear  format "X(4)"      "," 
            wdetail.body     format "X(10)"      "," 
            wdetail.vehuse   format "X(1)"      "," 
            wdetail.seat     format "X(2)"      "," 
            wdetail.engcc    format "X(4)"      "," 
            wdetail.vehreg   format "X(12)"      "," 
            wdetail.si       format "X(15)"      "," 
            wdetail.premt    format "X(15)"      "," 
            wdetail.ncb      format "X(5)"      "," 
            wdetail.stk      format "X(13)"      ","
            wdetail.prepol   format "X(12)"      ","
            wdetail.benname  format "X(45)"      ","   
            wdetail.comper   format "X(10)"      ","   
            wdetail.comacc   format "X(10)"      ","   
            wdetail.deductpd format "X(10)"      ","   
            wdetail.compul   format "X(2)"      ","   
            wdetail.pass     format "X(2)"      ","     
            wdetail.comment  format "X(50)"      ","
            wdetail.WARNING FORMAT "x(50)"  SKIP.  
 
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
"       Producer Code : " fi_producer2   SKIP
/*"          Agent Code : " fi_agent      SKIP*/
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
      /*CONNECT expiry -H 10.35.176.37 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.  */
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
------------------------------------------------------------------------------*/
/*create  text (F17) for Query claim....*/
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF VAR nv_bptr      AS RECID.
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
/*A57-0275*/
/*IF r-INDEX(wdetail.receipt_name,"DLR:") <> 0 THEN 
    ASSIGN  
    nv_txt5 = ""
    nv_txt5 = trim(substr(wdetail.receipt_name,r-INDEX(wdetail.receipt_name,"DLR:") + 4 ))
    wdetail.receipt_name = substr(wdetail.receipt_name,1,r-INDEX(wdetail.receipt_name,"DLR:") - 1 ).
IF fi_no_mn30 <> "" THEN DO:
    IF    INDEX(trim(fi_no_mn30),nv_txt5) = 0  THEN ASSIGN nv_txt5 = "".
    ELSE ASSIGN nv_txt5 = "NO-MN30 ������ͧ��¡�͡������".
END.
ELSE ASSIGN nv_txt5 = "".*/
/*A57-0275*/
     
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt1  = ""  
    nv_txt2  = "Paid Date :" + trim(wdetail.paiddat) 
    nv_txt3  = "Paid No :" + trim(wdetail.typepaid) + " " + TRIM(wdetail.paidno)
    nv_txt4  = "Paid Type :" + trim(wdetail.paidtyp)                  
    nv_txt5  = "" .
   /* nv_txt3  = IF wdetail.accesstxt = "" THEN "" ELSE "�����˵� �ػ�ó������ : " +  wdetail.accesstxt 
    nv_txt4  = IF wdetail.receipt_name = "" THEN "" ELSE "�͡�����㹹�� : " + wdetail.receipt_name*/
    /*nv_txt5  in proc_assign 2 */
     . 

DO WHILE nv_line1 <= 10:
    CREATE wuppertxt3.
    wuppertxt3.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt3.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt3.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt3.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt3.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt3.txt = nv_txt5.
    /*IF nv_line1 = 5  THEN wuppertxt3.txt = nv_txt5.  */
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
    FOR EACH wuppertxt3 NO-LOCK BREAK BY wuppertxt3.line:
        CREATE sic_bran.uwd100.
        ASSIGN
            sic_bran.uwd100.bptr    = nv_bptr
            sic_bran.uwd100.fptr    = 0
            sic_bran.uwd100.policy  = wdetail.policy
            sic_bran.uwd100.rencnt  = n_rencnt
            sic_bran.uwd100.endcnt  = n_endcnt
            sic_bran.uwd100.ltext   = wuppertxt3.txt.
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
/*/*a57-0432*/ n_campaigns */
/* ranu
 FIND FIRST brstat.insure USE-INDEX insure01      WHERE 
    index(brstat.insure.compno,"nissan_C") <> 0         AND 
    deci(brstat.Insure.LName)   = deci(wdetail.tp1)     AND 
    deci(brstat.Insure.Addr1)   = deci(wdetail.tp2)     AND 
    deci(brstat.Insure.Addr2)   = deci(wdetail.tp3)     AND 
    brstat.insure.Text3         = wdetail.prempa + wdetail.subclass      NO-LOCK  NO-WAIT NO-ERROR.
IF AVAIL brstat.insure  THEN DO:
    ASSIGN n_campaigns = IF index(brstat.insure.compno,"nissan_C") <> 0 THEN SUBSTR(brstat.insure.compno,8)  
                         ELSE brstat.insure.compno.
END.
ELSE n_campaigns = trim(fi_camaign).  */
/*a57-0432*/

    DO WHILE nv_line1 <= 10:
        CREATE wuppertxt3.
        wuppertxt3.line = nv_line1.
        IF nv_line1 = 1  THEN wuppertxt3.txt = "".
        IF nv_line1 = 2  THEN wuppertxt3.txt = "Remark 1 :" + TRIM(wdetail.remark) .     
        IF nv_line1 = 3  THEN wuppertxt3.txt = "Remark 2 :" + TRIM(wdetail.remark2).       
        IF nv_line1 = 4  THEN wuppertxt3.txt = "Remark 3 :" + TRIM(wdetail.remark3).       
        IF nv_line1 = 5  THEN wuppertxt3.txt = "Contract No :" + TRIM(wdetail.contractno).    
        IF nv_line1 = 6  THEN wuppertxt3.txt = "User Closing :" + TRIM(wdetail.userc).   
        IF nv_line1 = 7  THEN wuppertxt3.txt = "Campaing : " + TRIM(wdetail.n_campaigns) .  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm100 c-Win 
PROCEDURE proc_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by :A64-0138...
IF wdetail.premt <> "" THEN DO:  /*�ó� ��ͧ��� ��������� ������ */
    IF (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) >= 365 ) AND
       (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) <= 366 ) THEN
        ASSIGN 
            nv_gapprm  = TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) +
                        (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 
                        THEN 1 ELSE 0 )
            nv_pdprm   = nv_gapprm .
        /*nv_gapprm  =  IF wdetail.prem_nap = "" THEN nv_gapprm ELSE DECI(wdetail.prem_nap)
        nv_pdprm   =  IF wdetail.prem_nap = "" THEN nv_pdprm  ELSE DECI(wdetail.prem_nap).*/
        ELSE  /*���� �������� ���� �Թ�� */
            ASSIGN nv_pdprm  = TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ).
END.

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN  
         sic_bran.uwm100.prem_t = nv_pdprm          /* A57-0426 *//*���� �������� ���� �Թ�� */
         sic_bran.uwm100.sigr_p = inte(wdetail.si)
         sic_bran.uwm100.gap_p  = nv_gapprm.

     IF wdetail.pass <> "Y" THEN 
         ASSIGN
         sic_bran.uwm100.impflg = NO
         sic_bran.uwm100.imperr = wdetail.comment.    
     
END.
... end A64-0138...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm120 c-Win 
PROCEDURE proc_uwm120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0138..
FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
     ASSIGN
        sic_bran.uwm120.gap_r  = nv_gapprm
        sic_bran.uwm120.prem_r = nv_pdprm
        sic_bran.uwm120.sigr   = inte(wdetail.si).
...end A64-0138..*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm301 c-Win 
PROCEDURE proc_uwm301 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by : A64-0138...
FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN 
    ASSIGN   
        sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs
        sic_bran.uwm301.mv41seat = wdetail.seat41.
 /* 
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).*/

IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR
   (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" ) THEN      
    RUN WGS\WGSTP132(INPUT S_RECID3,   
                     INPUT S_RECID4). 
ELSE 
    RUN WGS\WGSTN132(INPUT S_RECID3,  
                 INPUT S_RECID4).
... end : A64-0138..*/
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

