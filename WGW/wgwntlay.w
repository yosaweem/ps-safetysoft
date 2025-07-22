&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases sic_test         PROGRESS      */
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
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */  
/*******************************/                                       
/*programid   : wgwntlay.w                                              */ 
/*programname : load text file AYCAL New Form to GW                              */ 
/* Copyright  : Safety Insurance Public Company Limited                 */
/*copy write  : wgwtlscb.w                                              */ 
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                      */
/*create by   : Ranu I. A61-0573 Date : 10/02/2019            
                โปรแกรมนำเข้า text file AYCAL to GW system               */
/* Modify by  : Ranu I. a63-0129 แก้ไขงานที่คุ้มครองตั้งแต่ 1/04/2020 ให้ใช้ Pack T 
งานต่ออายุหากใช้ Pack A ให้ใช้ pack เดิม อื่นๆใช้ Pack T  */
/*Modify by   : Kridtiya i. A63-0227 Date. 20/05/2020 ปิดการค้นหารหัสเรพบุ๊คกรณีหาไม่พบ*/
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by   : Kridtiya i. A65-0035 comment message error premium not on file */
/*Modify by   : Ranu I. A65-0115 เพิ่มการเก็บข้อมูล Dealer code จากไฟล์   */
/*Modify by   : Kridtiya i. A66-0160 Add color and campaign = Producer    */
/*Modify by   : Ranu I. A67-0162 เพิ่มการเก็บข้อมูลรถไฟฟ้า    */
/*Modify by   : Ranu I. F67-0001 แก้ไขการเช็คข้อมูลผู้ขับขี่งานต่ออายุ  */
/*Modify by  : Ranu I. A67-0204 แก้ไขการเช็ค class พรบ. ใหม่                               */
/*------------------------------------------------------------------------*/
{wgw\wgwntlay.i}      /*ประกาศตัวแปร*/
DEF VAR n_index   AS INTE  INIT 0.
DEF VAR stklen    AS INTE.
DEF VAR aa        AS DECI .
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

DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.

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
DEF NEW  SHARED VAR   nv_dss_per  AS DECIMAL   .           
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
DEF NEW SHARED VAR n_prepol   AS CHAR FORMAT "x(13)".
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
DEF VAR nv_txt1 AS CHAR FORMAT "x(250)" INIT "".
DEF VAR nv_txt2 AS CHAR FORMAT "x(250)" . 
DEF VAR nv_txt3 AS CHAR FORMAT "x(250)" INIT "".
DEF VAR nv_txt4 AS CHAR FORMAT "x(250)" . 
DEF VAR nv_txt5 AS CHAR FORMAT "x(250)" INIT "".
DEF VAR nv_txt6 AS CHAR FORMAT "x(250)" .
DEF VAR nv_txt7 AS CHAR FORMAT "x(250)" INIT "".
DEF VAR nv_txt8 AS CHAR FORMAT "x(250)" .
def var np_txt   as int init 0.  
def var np_retxt as int init 0.
DEF var nv_drivname AS CHAR FORMAT "x(150)" . /*A67-0162 */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_camp

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wcampaign wdetail

/* Definitions for BROWSE br_camp                                       */
&Scoped-define FIELDS-IN-QUERY-br_camp wcampaign.pack wcampaign.nclass wcampaign.garage wcampaign.cover wcampaign.bi wcampaign.pd1 wcampaign.pd2 wcampaign.n41 wcampaign.n42 wcampaign.n43 wcampaign.FI   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_camp   
&Scoped-define SELF-NAME br_camp
&Scoped-define QUERY-STRING-br_camp FOR EACH wcampaign
&Scoped-define OPEN-QUERY-br_camp OPEN QUERY br_camp FOR EACH wcampaign.
&Scoped-define TABLES-IN-QUERY-br_camp wcampaign
&Scoped-define FIRST-TABLE-IN-QUERY-br_camp wcampaign


/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail WDETAIL.WARNING wdetail.redbook /*add new*/ wdetail.poltyp wdetail.policy wdetail.producer wdetail.agent wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.addr1 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.engcc wdetail.seat wdetail.body wdetail.vehreg wdetail.eng wdetail.chasno wdetail.caryear wdetail.garage wdetail.covcod wdetail.si wdetail.fleet wdetail.ncb wdetail.deduct wdetail.benname wdetail.n_IMPORT wdetail.n_export wdetail.comment wdetail.cancel   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_wdetail FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_camp}~
    ~{&OPEN-QUERY-br_wdetail}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_camp buexp fi_loaddat fi_pack fi_campaign ~
fi_branch fi_producer fi_agent fi_prevbat fi_bchno fi_bchyr fi_filename ~
bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit ~
bu_hpbrn bu_hpacno1 bu_hpagent br_wdetail fi_process fi_compa fi_report ~
RECT-372 RECT-373 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_pack fi_campaign fi_branch ~
fi_producer fi_agent fi_prevbat fi_bchno fi_bchyr fi_filename fi_output1 ~
fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname ~
fi_impcnt fi_process fi_completecnt fi_premtot fi_premsuc fi_compa ~
fi_report 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buexp 
     LABEL "EXP" 
     SIZE 5 BY 1
     BGCOLOR 10 FGCOLOR 2 .

DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 14 BY 1.14
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

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44.5 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 20.83 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

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
     SIZE 15 BY .95
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
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 84 BY .95
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44.5 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_report AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.5 BY 13.1
     BGCOLOR 19 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 6.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 2.43
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 2
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 2
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_camp FOR 
      wcampaign SCROLLING.

DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_camp c-Win _FREEFORM
  QUERY br_camp DISPLAY
      wcampaign.pack     column-label "Pack"
   wcampaign.nclass   column-label "Class"
   wcampaign.garage   column-label "Garage"
   wcampaign.cover    column-label "Cover"
   wcampaign.bi       column-label "BI"
   wcampaign.pd1      column-label "PD1"
   wcampaign.pd2      column-label "PD2"
   wcampaign.n41      column-label "41"
   wcampaign.n42      column-label "42"
   wcampaign.n43      column-label "43"
   wcampaign.FI       column-label "Fi"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 34.5 BY 5.67
         BGCOLOR 29 FGCOLOR 2 FONT 1 ROW-HEIGHT-CHARS .76 FIT-LAST-COLUMN.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      WDETAIL.WARNING   FORMAT "x(75)" COLUMN-LABEL "Warning"
      wdetail.redbook  COLUMN-LABEL "RedBook"      /*add new*/
      wdetail.poltyp   COLUMN-LABEL "Policy Type"
      wdetail.policy   COLUMN-LABEL "Policy"
      wdetail.producer COLUMN-LABEL "Producer"
      wdetail.agent    COLUMN-LABEL "Agent"
      wdetail.tiname   COLUMN-LABEL "Title Name"   
      wdetail.insnam   COLUMN-LABEL "Insured Name" 
      wdetail.comdat   COLUMN-LABEL "Comm Date"
      wdetail.expdat   COLUMN-LABEL "Expiry Date"
      wdetail.compul   COLUMN-LABEL "Compulsory"
      wdetail.addr1    COLUMN-LABEL "Ins Add1"
      wdetail.prempa   COLUMN-LABEL "Premium Package"
      wdetail.subclass COLUMN-LABEL "Sub Class"
      wdetail.brand    COLUMN-LABEL "Brand"
      wdetail.model    COLUMN-LABEL "Model"
      wdetail.engcc    COLUMN-LABEL "CC"
      wdetail.seat     COLUMN-LABEL "Seat"
      wdetail.body     COLUMN-LABEL "Body"
      wdetail.vehreg   COLUMN-LABEL "Vehicle Register"
      wdetail.eng      COLUMN-LABEL "Engine NO."
      wdetail.chasno   COLUMN-LABEL "Chassis NO."
      wdetail.caryear  COLUMN-LABEL "Car Year" 
      wdetail.garage   COLUMN-LABEL "Garage"
      wdetail.covcod   COLUMN-LABEL "Cover Type"
      wdetail.si       COLUMN-LABEL "Sum Insure"
      wdetail.fleet    COLUMN-LABEL "Fleet"
      wdetail.ncb      COLUMN-LABEL "NCB"
      wdetail.deduct   COLUMN-LABEL "Deduct"
      wdetail.benname  COLUMN-LABEL "Benefit Name" 
      wdetail.n_IMPORT COLUMN-LABEL "Import"
      wdetail.n_export COLUMN-LABEL "Export"
      wdetail.comment  FORMAT "x(50)" COLUMN-BGCOLOR  80 COLUMN-LABEL "Comment"
      wdetail.cancel   COLUMN-LABEL "Cancel"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 5.62
         BGCOLOR 15 FONT 6.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_camp AT ROW 3.91 COL 97
     buexp AT ROW 7.91 COL 89.17
     fi_loaddat AT ROW 2.76 COL 27 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 2.76 COL 54.17 COLON-ALIGNED NO-LABEL
     fi_campaign AT ROW 2.76 COL 103.5 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.81 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.81 COL 27 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 5.86 COL 27 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 6.91 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.81 COL 14.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_bchyr AT ROW 6.91 COL 59 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.05 COL 26.83 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9.05 COL 89.17
     fi_output1 AT ROW 10.1 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.14 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.14 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 14.24 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 14.24 COL 65 NO-LABEL
     buok AT ROW 10.29 COL 101.17
     bu_exit AT ROW 12.38 COL 101.33
     fi_brndes AT ROW 3.81 COL 38.17 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 3.81 COL 35.83
     bu_hpacno1 AT ROW 4.81 COL 44.33
     bu_hpagent AT ROW 5.86 COL 44.33
     fi_proname AT ROW 4.81 COL 46.5 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 5.86 COL 46.5 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 16.1 COL 2.33
     fi_impcnt AT ROW 22.24 COL 60.67 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 13.19 COL 2.83 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.24 COL 60.67 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.24 COL 98.5 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.29 COL 96.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_compa AT ROW 2.76 COL 71.17 COLON-ALIGNED NO-LABEL
     fi_report AT ROW 7.95 COL 26.83 COLON-ALIGNED NO-LABEL
     " Branch  :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 3.81 COL 17.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Campaign :" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 2.76 COL 94
          BGCOLOR 18 FGCOLOR 7 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 22.38 COL 59.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 2 FONT 6
     " Producer Code :" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 4.81 COL 10.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "     Agent Code :" VIEW-AS TEXT
          SIZE 16.67 BY .95 AT ROW 5.86 COL 11
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "       Format File Load  :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 7.95 COL 4.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 6.95 COL 59.33 RIGHT-ALIGNED
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 23.43 COL 59.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 23.24 COL 117.5
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 2.76 COL 45.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "TieS 4 01/03/2022" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 14.24 COL 99.83 WIDGET-ID 2
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.52
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "    Previous Batch No. :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 6.95 COL 4.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 22.24 COL 96.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Company :" VIEW-AS TEXT
          SIZE 10.33 BY .95 AT ROW 2.76 COL 62.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 10.1 COL 4.5
          BGCOLOR 19 FGCOLOR 1 
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.24 COL 117.5
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 14.57 COL 24.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 14.24 COL 63.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 2 FONT 6
     " Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 11.14 COL 4
          BGCOLOR 19 FGCOLOR 1 
     "    IMPORT TEXT FILE MOTOR 70 [AYCAL]" VIEW-AS TEXT
          SIZE 131.5 BY 1.19 AT ROW 1.24 COL 1.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.81 COL 4
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 14.24 COL 82.83
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 23.24 COL 96.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 12.19 COL 4.5
          BGCOLOR 19 FGCOLOR 1 
     " Load Date :":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 2.76 COL 15.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 9.05 COL 4.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-372 AT ROW 2.52 COL 1.67
     RECT-373 AT ROW 15.81 COL 1.33
     RECT-376 AT ROW 22.1 COL 1.33
     RECT-377 AT ROW 9.81 COL 99.5
     RECT-378 AT ROW 11.91 COL 99.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.52
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
         TITLE              = "Load Text file AYCAL (New Format )"
         HEIGHT             = 23.52
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
/* BROWSE-TAB br_camp 1 fr_main */
/* BROWSE-TAB br_wdetail fi_agtname fr_main */
ASSIGN 
       br_camp:SEPARATOR-FGCOLOR IN FRAME fr_main      = 8.

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
          SIZE 12.83 BY .95 AT ROW 6.95 COL 59.33 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .95 AT ROW 14.24 COL 63.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 23 BY .95 AT ROW 14.57 COL 24.5 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 22.24 COL 96.17 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY .95 AT ROW 22.38 COL 59.17 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 23.24 COL 96.33 RIGHT-ALIGNED       */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY .95 AT ROW 23.43 COL 59.17 RIGHT-ALIGNED         */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_camp
/* Query rebuild information for BROWSE br_camp
     _START_FREEFORM
OPEN QUERY br_camp FOR EACH wcampaign.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_camp */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_wdetail FOR EACH wdetail.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* Load Text file AYCAL (New Format ) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text file AYCAL (New Format ) */
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
          WDETAIL.WARNING   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.redbook   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. /*new add*/
          wdetail.poltyp    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.policy    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.producer  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.agent     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.tiname    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.insnam    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.comdat    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.expdat    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.compul    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.addr1     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.prempa    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
          wdetail.subclass  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.brand     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.model     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.      
          wdetail.engcc     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.seat      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.body      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.vehreg    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.eng       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.chasno    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
          wdetail.caryear   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.garage    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.covcod    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
          wdetail.si        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.fleet     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.ncb       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deduct    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.benname   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_IMPORT  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.n_export  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.comment   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
          wdetail.cancel    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.                  
             



          /*wdetail.entdat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.enttim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trandat:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.trantim:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. *//*a490166*/ 
          WDETAIL.WARNING   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
          wdetail.redbook   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.
          wdetail.poltyp    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.policy    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.producer  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.agent     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.tiname    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.insnam    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comdat    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.    
          wdetail.expdat    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
          wdetail.compul    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.addr1     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.prempa    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.subclass  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.brand     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.model     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.engcc     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.seat      :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.body      :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.vehreg    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.eng       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.chasno    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.caryear   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.garage    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.covcod    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.si        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.fleet     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.ncb       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deduct    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.benname   :FGCOLOR IN BROWSE BR_WDETAIL = s  NO-ERROR.  
          wdetail.n_IMPORT  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_export  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comment   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.cancel    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  /*new add*/
          

  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buexp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buexp c-Win
ON CHOOSE OF buexp IN FRAME fr_main /* EXP */
DO:
    If  substr(fi_report,length(fi_report) - 3,4) <>  ".slk"  THEN 
    fi_report  =  Trim(fi_report) + ".slk"  .
    OUTPUT TO VALUE(fi_report).
    EXPORT DELIMITER "|" 
         " ประเภทกรมธรรม์ "
         " สาขา AY        "
         " Contract no    "
         " รหัสอ้างอิง    "
         " รหัสลูกค้า     "
         " รหัสแคมเปญ     "
         " ชื่อแคมเปญ     "
         " ชื่อผลิตภัณฑ์  "
         " ProspectID     "
         " กรมธรรม์เดิม   "
         " คำนำหน้าชื่อ ผู้เอาประกัน "
         " ชื่อ ผู้เอาประกัน    "     
         " เลขบัตรผู้เอาประกัน  "
         " วันเกิดผู้เอาประกัน  "
         " เบอร์โทรผู้เอาประกัน "
         " ที่อยู่จัดส่ง 1      "
         " ที่อยู่จัดส่ง 2      "
         " ที่อยู่จัดส่ง 3      "
         " ที่อยู่จัดส่ง 4      "
         " คำนำหน้าชื่อ ผู้จ่ายเงิน "
         " ชื่อ ผู้จ่ายเงิน      "
         " เลขประจำตัวผู้เสียภาษี"
         " ที่อยู่ออกใบเสร็จ1    "
         " ที่อยู่ออกใบเสร็จ2    "
         " ที่อยู่ออกใบเสร็จ3    "
         " ที่อยู่ออกใบเสร็จ4    "
         " ผู้รับผลประโยชน์      "
         " ประเภทการจ่าย         "
         " ช่องทางการจ่าย        "
         " ยี่ห้อ                "
         " รุ่น                  "
         " แบบตัวถัง             "
         " ทะเบียน               "
         " จังหวัดทะเบียน        "
         " เลขตัวถัง             "
         " เลขเครื่อง            "
         " ปีรถ                  "
         " ซีซี                  "
         " คลาสรถ                "
         " การซ่อม               "
         " ประเภทการประกัน       "
         " รหัสการประกัน         "
         " วันที่คุ้มครอง        "
         " วันที่หมดอายุ         "
         " ทุนประกัน             "
         " ทุนสูญหาย/ไฟไหม้      "
         " เบี้ยสุทธิก่อนหักส่วนลด "
         " เบี้ยสุทธิหลังหักส่วนลด "
         " สแตมป์   "
         " ภาษี     "
         " เบี้ยรวม "
         " Deduct   "
         " fleet    "
         " ncb      "
         " other    "
         " cctv     "
         " ระบุผู้ขับขี่      "
         " ชื่อผู้ขับขี่1     "
         " เลขบัตรผู้ขับขี่1  "
         " อาชีพผู้ขับขี่1    "
         " เพศผู้ขับขี่1      "
         " วันเกิดผู้ขับขี่1  "
         " ชื่อผู้ขับขี่2     "
         " เลขบัตรผู้ขับขี่2  "
         " อาชีพผู้ขับขี่2    "
         " เพศผู้ขับขี่2      "
         " วันเกิดผู้ขับขี่2  "
         " รายละเอียดอุปกรณ์1 "
         " ราคาอุปกรณ์1       "
         " รายละเอียดอุปกรณ์2 "
         " ราคาอุปกรณ์2       "
         " รายละเอียดอุปกรณ์3 "
         " ราคาอุปกรณ์3       "
         " รายละเอียดอุปกรณ์4 "
         " ราคาอุปกรณ์4       "
         " รายละเอียดอุปกรณ์5 "
         " ราคาอุปกรณ์5       "
         " วันที่ตรวจสภาพ     "
         " ชื่อผู้ตรวจสภาพ    "
         " เบอร์โทรตรวจสภาพ   "
         " สถานที่ตรวจสภาพ    "
         " รายละเอียดการตรวจสภาพ "
         " วันที่ขาย          "
         " วันที่รับชำระเงิน  "
         " รายละเอียดการจัดส่ง" 
         " Agent name         "
         " หมายเหตุ           "
         " เลขตรวจสภาพ        "
         " ผลการตรวจ          "
         " ความเสียหาย1       "
         " ความเสียหาย2       "
         " ความเสียหาย3       "
         " ข้อมูลอื่นๆ        "
         " เบอร์กรมธรรม์      "
         " Producer           "
         " Agent              "
         " สาขา STY           "
         " Remark 2           "
      /* " ประเภทกรมธรรม์"
       " สาขา AY "
       " รหัสอ้างอิง   "
       " รหัสลูกค้า    "
       " รหัสแคมเปญ    "
       " ชื่อแคมเปญ    "
       " รหัสผลิตภัณฑ์ "
       " ชื่อผลิตภัณฑ์ "
       " ชื่อแพคเก็จ   "
       " รหัสแพคเก็จ   "
       " ประเภทผู้เอาประกัน "
       " คำนำหน้าชื่อ ผู้เอาประกัน "
       " ชื่อ ผู้เอาประกัน         "
       " คำนำหน้าชื่อ ผู้เอาประกัน (Eng) "
       " ชื่อ ผู้เอาประกัน (Eng)" 
       " เลขบัตรผู้เอาประกัน "
       " วันเกิดผู้เอาประกัน "
       " อาชีพผู้เอาประกัน" 
       " เบอร์โทรผู้เอาประกัน"
       " อีเมล์ผู้เอาประกัน  "
       " ที่อยู่หน้าตาราง1" 
       " ที่อยู่หน้าตาราง2" 
       " ที่อยู่หน้าตาราง3" 
       " ที่อยู่หน้าตาราง4" 
       " ที่อยู่จัดส่ง 1  " 
       " ที่อยู่จัดส่ง 2  " 
       " ที่อยู่จัดส่ง 3  " 
       " ที่อยู่จัดส่ง 4  " 
       " ประเภทผู้จ่ายเงิน" 
       " คำนำหน้าชื่อ ผู้จ่ายเงิน"
       " ชื่อ ผู้จ่ายเงิน"
       " เลขประจำตัวผู้เสียภาษี"
       " ที่อยู่ออกใบเสร็จ1"
       " ที่อยู่ออกใบเสร็จ2"
       " ที่อยู่ออกใบเสร็จ3"
       " ที่อยู่ออกใบเสร็จ4"
       " สาขา"
       " ผู้รับผลประโยชน์  "
       " รหัสประเภทการจ่าย "
       " ประเภทการจ่าย "
       " รหัสช่องทางการจ่าย"
       " ช่องทางการจ่าย  "
       " ธนาคารที่จ่าย" 
       " วันที่จ่าย   " 
       " สถานะการจ่าย " 
       " ยี่ห้อ  "  
       " รุ่น    "  
       " แบบตัวถัง" 
       " ทะเบียน "
       " จังหวัดทะเบียน "
       " เลขตัวถัง" 
       " เลขเครื่อง " 
       " ปีรถ    "  
       " ที่นั่ง "  
       " ซีซี    "  
       " น้ำหนัก "  
       " คลาสรถ  "  
       " การซ่อม "  
       " สี  "  
       " ประเภทการประกัน "
       " รหัสการประกัน" 
       " วันที่คุ้มครอง  "
       " วันที่หมดอายุ" 
       " ทุนประกัน"
       " เบี้ยสุทธิก่อนหักส่วนลด"
       " เบี้ยสุทธิหลังหักส่วนลด"
       " สแตมป์  "
       " ภาษี    "
       " เบี้ยรวม"
       " Deduct  "
       " fleet   " 
       " ncb     " 
       " other   "   
       " cctv    "
       " ระบุผู้ขับขี่    " 
       " ชื่อผู้ขับขี่1   " 
       " เลขบัตรผู้ขับขี่1" 
       " อาชีพผู้ขับขี่1  " 
       " เพศผู้ขับขี่1    " 
       " วันเกิดผู้ขับขี่1" 
       " ชื่อผู้ขับขี่2   " 
       " เลขบัตรผู้ขับขี่2" 
       " อาชีพผู้ขับขี่2  " 
       " เพศผู้ขับขี่2    " 
       " วันเกิดผู้ขับขี่2" 
       " อุปกรณ์ตกแต่ง1   " 
       " รายละเอียดอุปกรณ์1"
       " ราคาอุปกรณ์1  "
       " อุปกรณ์ตกแต่ง2"
       " รายละเอียดอุปกรณ์2"
       " ราคาอุปกรณ์2  "
       " อุปกรณ์ตกแต่ง3"
       " รายละเอียดอุปกรณ์3"
       " ราคาอุปกรณ์3  "
       " อุปกรณ์ตกแต่ง4"
       " รายละเอียดอุปกรณ์4"
       " ราคาอุปกรณ์4  "
       " อุปกรณ์ตกแต่ง5"
       " รายละเอียดอุปกรณ์5"
       " ราคาอุปกรณ์5  "
       " วันที่ตรวจสภาพ"
       " วันที่อนุมัติผลการตรวจ"
       " ผลการตรวจสภาพ"
       " รายละเอียดการตรวจสภาพ"
       " วันที่ขาย"
       " วันที่รับชำระเงิน"
       " สถานะการจ่าย"
       " เลขที่ใบอนุญาตนายหน้า"
       " ชื่อนายหน้า "
       " รหัสนายหน้า "
       " ภาษา        "
       " การจัดส่งกรมธรรม์   "
       " รายละเอียดการจัดส่ง "
       " ของแถม  "
       " หมายเหตุ" 
       " เลขตรวจสภาพ "
       " ผลการตรวจ "
       " ความเสียหาย1 "
       " ความเสียหาย2 "
       " ความเสียหาย3 "
       " ข้อมูลอื่นๆ "
       " เบอร์กรมธรรม์จาก AY"
       " Prodcucer "
       " Agent " 
       " สาขาคุ้มภัย "
       " หมายเหตุ "  */ .
    OUTPUT CLOSE.
  
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
        fi_process  = "Start Load Text File AYCAL [New Form] " .  
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot fi_process WITH FRAME fr_main.
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
        FIND LAST uzm700 USE-INDEX uzm70002
            WHERE uzm700.bchyr = nv_batchyr        AND
            uzm700.acno        = TRIM(fi_producer) AND
            uzm700.branch      = TRIM(nv_batbrn)   NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO: 
            ASSIGN nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102 
                WHERE uzm701.bchyr   = nv_batchyr        AND
                uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") 
                NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN  
                ASSIGN nv_batcnt = uzm701.bchcnt 
                nv_batrunno = nv_batrunno + 1.
        END.
        ELSE  ASSIGN  nv_batcnt = 1
                  nv_batrunno = 1 .
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
            ASSIGN nv_batcnt  = uzm701.bchcnt + 1 
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
    For each  wdetail :
        DELETE  wdetail.
    End.
    RUN proc_assign. 
   FOR EACH wdetail:
        IF WDETAIL.POLTYP = "v70" OR WDETAIL.POLTYP = "v72" THEN  
            ASSIGN
            nv_reccnt      =  nv_reccnt   + 1
            nv_netprm_t    =  nv_netprm_t + decimal(wdetail.premt)
            wdetail.pass   =  "Y". 
        ELSE DO :  
            DELETE WDETAIL.
        END.
    END.
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    /* comment by : A64-0138...
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
    .. end A64-0138..*/
    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,    /* DATE  */
                           INPUT            nv_batchyr ,    /* INT   */
                           INPUT            fi_producer,    /* CHAR  */ 
                           INPUT            nv_batbrn  ,    /* CHAR  */
                           INPUT            fi_prevbat ,    /* CHAR  */ /*Previous Batch*/
                           INPUT            "WGWNTLAY" ,    /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,    /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,    /* INT   */
                           INPUT            nv_imppol  ,    /* INT   */
                           INPUT            nv_impprem      /* DECI  */
                           ).
    ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.

    RUN proc_chktest1.

    FOR EACH wdetail  WHERE wdetail .pass = "y" :
        ASSIGN  nv_completecnt = nv_completecnt + 1
            nv_netprm_s        = nv_netprm_s    + decimal(wdetail.premt).
    END.
    ASSIGN  nv_rectot = nv_reccnt       
        nv_recsuc = nv_completecnt. 
    IF /*nv_imppol <> nv_rectot OR
    nv_imppol <> nv_recsuc OR*/
        nv_rectot <> nv_recsuc   THEN DO:
        nv_batflg = NO.
        /*MESSAGE "Policy import record is not match to Total record !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE IF /*nv_impprem  <> nv_netprm_t OR
    nv_impprem  <> nv_netprm_s OR*/
        nv_netprm_t <> nv_netprm_s THEN DO:
        ASSIGN nv_netprm_t  = nv_netprm_s
            nv_batflg = YES.
    /*MESSAGE "Total net premium is not match to Total net premium !!!" VIEW-AS ALERT-BOX.*/
    END.
    ELSE  nv_batflg = YES.
    FIND LAST uzm701 USE-INDEX uzm70102  
        WHERE uzm701.bchyr   = nv_batchyr AND
              uzm701.bchno   = nv_batchno AND
              uzm701.bchcnt  = nv_batcnt  NO-ERROR.
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
    
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.   /*add kridtiya i. A55-0184  */
    RELEASE sicsyac.xtm600.
    RELEASE sicsyac.xmm600.
    RELEASE sicsyac.xzm056.
    IF CONNECTED("sic_exp") THEN DISCONNECT sic_exp.
    /*add by A64-0138........*/
    IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".
    IF nv_batflg = NO  THEN DO:  
        ASSIGN
            fi_process  = "Please check Data again...Data have error..!!!  "   /*A55-0184 */ 
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno      :FGCOLOR = 6. 
        DISP fi_completecnt fi_premsuc fi_process WITH FRAME fr_main.
        MESSAGE "Batch Year  : " STRING(nv_batchyr)     SKIP
                "Batch No.   : " nv_batchno             SKIP
                "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
                TRIM(nv_txtmsg)                         SKIP
                "Please check Data again."      
        VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE". 
    END.
    ELSE IF nv_batflg = YES THEN DO: 
        ASSIGN
            fi_process  = "Process Complete...OK..  "   /*A55-0184 */ 
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
        DISP  fi_process WITH FRAME fr_main.
    END.
    FOR EACH wdetail:
        ASSIGN wdetail.pass = wdetail.pass.
    END.
    /*add by A64-0138........*/
    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .
    /*add kridtiya i. A55-0184 ... */
    /*add kridtiya i. A55-0184 ... 
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.   /*add kridtiya i. A55-0184  */
    RELEASE sicsyac.xtm600.
    RELEASE sicsyac.xmm600.
    RELEASE sicsyac.xzm056.
    IF CONNECTED("sic_exp") THEN DISCONNECT sic_exp. 
    comment by A64-0138........*/
    
    
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
            nv_agent   =  fi_agent.             /*note add  08/11/05*/
            
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
  fi_branch = INPUT fi_branch.

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


&Scoped-define SELF-NAME fi_campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaign c-Win
ON LEAVE OF fi_campaign IN FRAME fr_main
DO:
    fi_campaign  =  Input  fi_campaign.
  Disp  fi_campaign  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compa c-Win
ON LEAVE OF fi_compa IN FRAME fr_main
DO:
    fi_compa  =  Input  fi_compa .
    Disp  fi_compa  with  frame  fr_main.
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
                fi_producer =  caps(INPUT  fi_producer) /*note modi 08/11/05*/
                nv_producer = fi_producer .             /*note add  08/11/05*/
                
            END.
  END.

  Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_report c-Win
ON LEAVE OF fi_report IN FRAME fr_main
DO:
    fi_report = INPUT fi_report .
    DISP fi_report WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME RECT-372
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL RECT-372 c-Win
ON MOUSE-SELECT-CLICK OF RECT-372 IN FRAME fr_main

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_camp
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
  
  gv_prgid = "Wgwntlay".
  gv_prog  = "Load Text File AYCAL (NEW FORMAT)".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
      fi_pack      = ""
      fi_branch    = "M"
      fi_campaign  = "PACK_AY"   
      /*fi_producer  = "A0M0018"  */ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
      /*fi_agent     = "B3M0039" */  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
      fi_producer  = "B3MLAY0101"    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
      fi_agent     = "B3MLAY0100"    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
      fi_bchyr     = YEAR(TODAY)
      fi_compa     = "AYCAL"
      fi_process   = "Load Text File AYCAL [New Format] " .
      RUN proc_campaign. 
  DISP fi_pack    fi_campaign fi_branch  fi_producer   fi_agent    fi_bchyr    fi_process  
       fi_compa   
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assigndetail c-Win 
PROCEDURE 00-proc_assigndetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0162..
DEF VAR nv_pol AS CHAR FORMAT "x(15)" INIT "".
ASSIGN nv_pol  = trim(substr(n_poltyp,2,2)) + trim(n_contract) .
FIND LAST wdetail WHERE wdetail.policy = trim(nv_pol)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
          wdetail.poltyp      =  trim(n_poltyp)                             
          wdetail.policy      =  trim(nv_pol)
          wdetail.prepol      =  TRIM(n_prepol)
          wdetail.account_no  =  TRIM(n_contract) /*trim(n_account_no)    */
          wdetail.inscode     =  trim(n_inscode )                        
          wdetail.campcode    =  trim(n_campcode)                        
          wdetail.campname    =  TRIM(n_paydate)  
         /* wdetail.procode     =  trim(n_procode ) */                       
          wdetail.proname     =  trim(n_proname )                        
          /*wdetail.packname    =  trim(n_packname)  */                      
          wdetail.packcode    =  trim(n_packcode)                        
          /*wdetail.instype     =  trim(n_instype )  */                      
          wdetail.tiname      =  trim(n_tiname)                        
          wdetail.insnam      =  trim(n_insnam)                        
         /* wdetail.title_eng   =  trim(n_title_eng)                        
          wdetail.insname_eng =  trim(n_insname_eng)  */                      
          wdetail.icno        =  trim(n_icno )                        
          wdetail.bdate       =  trim(n_bdate)                        
         /* wdetail.occup       =  IF trim(n_occup) = "" THEN "อื่นๆ" ELSE TRIM(n_occup) */                       
          wdetail.tel         =  trim(n_tel  )                        
         /* wdetail.mail        =  trim(n_mail )  */                      
          wdetail.addr1       =  trim(n_addrsend1)                       
          wdetail.addr2       =  trim(n_addrsend2)                       
          wdetail.addr3       =  trim(n_addrsend3)                       
          wdetail.addr4       =  trim(n_addrsend4)  
          wdetail.benname     =  trim(n_ben_name)   
          wdetail.brand       =  trim(n_brand)                        
          wdetail.Model       =  trim(n_Model)                        
          wdetail.body        =  trim(n_body )                        
          wdetail.vehreg      =  trim(n_vehreg)                        
          wdetail.re_country  =  trim(n_re_country)                        
          wdetail.chasno      =  trim(n_chasno)                        
          wdetail.eng         =  trim(n_eng)                        
          wdetail.caryear     =  trim(n_caryear)                        
          wdetail.seate       =  0                        
          wdetail.engcc       =  trim(n_engcc)                        
          wdetail.weight      =  ""                       
          wdetail.subclass    =  IF n_poltyp = "V72"  THEN trim(REPLACE(n_class,".","")) ELSE TRIM(n_class)                       
          wdetail.garage      =  trim(n_garage)                        
          wdetail.colorcode   =  trim(n_colorcode)   /*A66-0160*/                  
          wdetail.covcod      =  trim(n_covcod)                        
          wdetail.covtyp      =  trim(n_covtyp)                        
          wdetail.comdat      =  trim(n_comdat)                        
          wdetail.expdat      =  trim(n_expdat)                        
          wdetail.si          =  trim(n_si) 
          wdetail.fi          =  TRIM(n_fi)
          wdetail.prem1       =  trim(n_prem1)                        
          wdetail.gross_prm   =  trim(n_gross_prm)                        
          wdetail.stamp       =  trim(n_stamp)                        
          wdetail.vat         =  trim(n_vat)                        
          wdetail.premtotal   =  trim(n_premtotal)                        
          wdetail.deduct      =  trim(n_deduct)                        
          wdetail.fleetper    =  trim(n_fleetper)                        
          wdetail.ncb         =  DECI(n_ncb)                        
          wdetail.drivper     =  trim(n_drivper)                        
          wdetail.othper      =  IF INT(n_othper) = 0 AND INT(n_cctvper) <> 0 THEN trim(n_cctvper) ELSE trim(n_othper)          
          wdetail.cctvper     =  trim(n_cctvper)                        
          /*wdetail.Surcharper  =  trim(n_Surcharper) */                       
          wdetail.drivnam     =  trim(n_driver) 
          wdetail.drivnam1    =  trim(n_drivnam1)                        
          wdetail.driveno1    =  trim(n_driveno1)                        
          wdetail.occupdri1   =  trim(n_occupdri1)                        
          wdetail.sexdriv1    =  trim(n_sexdriv1)      
          wdetail.bdatedri1   =  trim(n_bdatedri1)                        
          wdetail.drivnam2    =  trim(n_drivnam2)                        
          wdetail.driveno2    =  trim(n_driveno2)                        
          wdetail.occupdri2   =  trim(n_occupdri2)                        
          wdetail.sexdriv2    =  trim(n_sexdriv2)                        
          wdetail.bdatedri2   =  trim(n_bdatedri2)
          wdetail.vehuse      =  "1"
          wdetail.stk         =  ""
          wdetail.compul      =  IF n_poltyp = "V72" THEN "Y" ELSE "N"
          wdetail.branch      =  TRIM(n_hobr)
          wdetail.agent       =  TRIM(n_agent)
          wdetail.producer    =  TRIM(n_producer)
          wdetail.dealer      =  TRIM(n_dealer)  /* A65-0115*/
          wdetail.trandat     =  STRING(fi_loaddat)         /*tran  date*/
          wdetail.trantim     =  STRING(TIME,"HH:MM:SS")    /*tran  time*/
          wdetail.n_IMPORT    =  "IM"
          wdetail.n_EXPORT    =  "" .
    CREATE wtxt.
    ASSIGN      
          wtxt.poltyp         =  trim(n_poltyp)                             
          wtxt.policy         =  TRIM(nv_pol)
          wtxt.inscode        =  trim(n_inscode) 
         /* wtxt.addrsend1      =  trim(n_addrpol1)                         
          wtxt.addrsend2      =  trim(n_addrpol2)                         
          wtxt.addrsend3      =  trim(n_addrpol3)                         
          wtxt.addrsend4      =  trim(n_addrpol4)  */                       
          /*wtxt.paytype        =  trim(n_paytype)  */                       
          wtxt.paytitle       =  trim(n_paytitle)                         
          wtxt.payname        =  trim(n_payname)
          wtxt.payic          =  TRIM(n_payic)
          wtxt.addrpay1       =  trim(n_addrpay1) 
          wtxt.addrpay2       =  trim(n_addrpay2) 
          wtxt.addrpay3       =  trim(n_addrpay3) 
          wtxt.addrpay4       =  trim(n_addrpay4)
         /* wtxt.branch         =  trim(n_branch)*/             
         /* wtxt.pmentcode      =  trim(n_pmentcode) */                        
          wtxt.pmenttyp       =  trim(n_pmenttyp)                         
         /* wtxt.pmentcode1     =  trim(n_pmentcode1) */                        
          wtxt.pmentcode2     =  trim(n_pmentcode2)                         
         /* wtxt.pmentbank      =  trim(n_pmentbank)                         
          wtxt.pmentdate      =  trim(n_pmentdate)                         
          wtxt.pmentsts       =  trim(n_pmentsts)
          wtxt.Surchardetail  =  trim(n_Surchardetail) */
         /* wtxt.acc1           =  trim(n_acc1)  */                    
          wtxt.accdetail1     =  trim(n_accdetail1)                      
          wtxt.accprice1      =  trim(n_accprice1)                      
         /* wtxt.acc2           =  trim(n_acc2)    */
          wtxt.accdetail2     =  trim(n_accdetail2)                      
          wtxt.accprice2      =  trim(n_accprice2)                      
         /* wtxt.acc3           =  trim(n_acc3)    */
          wtxt.accdetail3     =  trim(n_accdetail3)                      
          wtxt.accprice3      =  trim(n_accprice3)                      
         /* wtxt.acc4           =  trim(n_acc4)    */
          wtxt.accdetail4     =  trim(n_accdetail4)                      
          wtxt.accprice4      =  trim(n_accprice4)                      
         /* wtxt.acc5           =  trim(n_acc5)   */ 
          wtxt.accdetail5     =  trim(n_accdetail5)                      
          wtxt.accprice5      =  trim(n_accprice5) 
          wtxt.noti_no        =  IF trim(n_account_no)  <> "" THEN "เลขแจ้งงาน: " + trim(n_account_no) ELSE ""  
          wtxt.inspdate       =  if trim(n_inspdate)    <> "" THEN "วันที่ตรวจสภาพ : " +  trim(n_inspdate) ELSE ""                    
         /* wtxt.inspdate_app   =  if trim(n_inspdate_app) <> "" THEN "วันที่อนุมัติผลการตรวจ : " + trim(n_inspdate_app) ELSE ""                    
          wtxt.inspsts        =  if trim(n_inspsts)     <> "" THEN "ผลการตรวจสภาพ : " + trim(n_inspsts) ELSE "ผลการตรวจสภาพ : - "   */                
          /*wtxt.inspdetail     =  if trim(n_inspdetail)  <> "" THEN "รายละเอียด : " + trim(n_inspdetail) ELSE ""  */                    
          wtxt.not_date       =  if trim(n_not_date)    <> "" THEN "วันที่แจ้งงาน : " + trim(n_not_date) ELSE ""                 
          wtxt.paydate        =  if trim(n_paydate)     <> "" THEN "วันที่รับชำระเงิน : " + trim(n_paydate) ELSE ""                 
          /*wtxt.paysts         =  if trim(n_paysts)      <> "" THEN "สถานะการจ่าย : " + trim(n_paysts)  ELSE ""   */
         /* wtxt.brokname       =  if trim(n_brokname)    <> "" THEN "ชื่อผู้ตรวจสภาพ : " + trim(n_brokname) else ""  
          wtxt.licenBroker    =  if trim(n_licenBroker) <> "" THEN "เบอร์โทรตรวจสภาพ : " + trim(n_licenBroker) ELSE "" 
          wtxt.brokcode       =  if trim(n_brokcode)    <> "" THEN "สถานที่ตรวจสภาพ : " + trim(n_brokcode) else ""   */              
          /*wtxt.lang           =  trim(n_lang)                      
          wtxt.deli           =  IF trim(n_deli) <> "" THEN "การจัดส่งกรมธรรม์ : " + trim(n_deli) ELSE ""  */                   
          wtxt.delidetail     =  IF trim(n_delidetail) <> "" THEN "รายละเอียดการจัดส่ง: " + trim(n_delidetail)  ELSE ""                  
          wtxt.gift           =  if trim(n_gift)    <> "" then "Agent name : " + trim(n_gift) ELSE " "             
          wtxt.remark         =  if trim(n_remark)  <> "" then "หมายเหตุ : " +  trim(n_remark) ELSE "หมายเหตุ : - "                
          wtxt.inspno         =  if trim(n_inspno)  <> "" then "เลขที่ตรวจสภาพ : " + trim(n_inspno) ELSE "เลขที่ตรวจสภาพ : NO "                  
          wtxt.remarkinsp     =  if trim(n_remarkinsp) <> "" then "ผลจากกล่องตรวจสภาพ : " + trim(n_remarkinsp) 
                                 ELSE IF trim(n_inspno) = "" THEN "ผลจากกล่องตรวจสภาพ : ไม่ต้องตรวจสภาพ " ELSE "ผลจากกล่องตรวจสภาพ : - "
          wtxt.damang1        =  if trim(n_damang1) <> "" then "ความเสียหาย1: " + trim(n_damang1)  else ""    
          wtxt.damang2        =  if trim(n_damang2) <> "" then "ความเสียหาย2: " + trim(n_damang2)  else ""    
          wtxt.damang3        =  if trim(n_damang3) <> "" then "ความเสียหาย3: " + trim(n_damang3)  else ""    
          wtxt.dataoth        =  if trim(n_dataoth) <> "" then "ข้อมูลอื่น ๆ: " + trim(n_dataoth)  ELSE "" 
          wtxt.policy2        =  TRIM(n_policy).
END.
..end A67-0162 ...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest2 c-Win 
PROCEDURE 00-proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : F67-0001 .....
ASSIGN fi_process = "Create uwm130.." + wdetail.policy .
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
        sic_bran.uwm130.bchcnt = nv_batcnt         /* bchcnt     */
        np_driver = TRIM(sic_bran.uwm130.policy) +
                STRING(sic_bran.uwm130.rencnt,"99" ) +
                STRING(sic_bran.uwm130.endcnt,"999") +
                STRING(sic_bran.uwm130.riskno,"999") +
                STRING(sic_bran.uwm130.itemno,"999")
        nv_sclass              = wdetail.subclass.
    IF nv_uom6_u  =  "A"  THEN DO:
        IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
            nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
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

    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR 
       INDEX(wdetail.covcod,"2.") <> 0 OR INDEX(wdetail.covcod,"3.") <> 0 THEN 
        ASSIGN
        sic_bran.uwm130.uom6_v   = inte(wdetail.si)
        sic_bran.uwm130.uom7_v   = inte(wdetail.fi)
        sic_bran.uwm130.uom1_v   = deci(wdetail.tp1)  
        sic_bran.uwm130.uom2_v   = deci(wdetail.tp2)  
        sic_bran.uwm130.uom5_v   = deci(wdetail.tp3)  
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN
        sic_bran.uwm130.uom6_v   = INTE(wdetail.si)
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.uom1_v   = deci(wdetail.tp1)  
        sic_bran.uwm130.uom2_v   = deci(wdetail.tp2)  
        sic_bran.uwm130.uom5_v   = deci(wdetail.tp3)  
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN 
        sic_bran.uwm130.uom1_v   = deci(wdetail.tp1)  
        sic_bran.uwm130.uom2_v   = deci(wdetail.tp2)  
        sic_bran.uwm130.uom5_v   = deci(wdetail.tp3)  
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/

    IF INT(wdetail.cctv) <> 0 THEN sic_bran.uwm130.i_text = "0001" . 

    IF wdetail.poltyp = "v72" THEN  n_sclass72 = wdetail.subclass.
    ELSE n_sclass72 = wdetail.prempa + wdetail.subclass .
    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do: 
        IF wdetail.prempa = "z" THEN
            Assign 
            nv_seat41                  =  wdetail.seat
            sic_bran.uwm130.uom1_v     =  deci(wdetail.tp1)   /*stat.clastab_fil.uom1_si   1000000  */  
            sic_bran.uwm130.uom2_v     =  deci(wdetail.tp2)   /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     =  deci(wdetail.tp3)   /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  =  deci(wdetail.tp1)   /*deci(wdetail.tp_bi)   */ 
            nv_uom2_v                  =  deci(wdetail.tp2)   /*deci(wdetail.tp_bi2)  */  
            nv_uom5_v                  =  deci(wdetail.tp3).  /*deci(wdetail.tp_bi3)  */  
        ELSE 
            Assign  
                /*add by A63-0129..*/
                sic_bran.uwm130.uom1_v = if deci(wdetail.tp1) <> 0 then deci(wdetail.tp1)  else stat.clastab_fil.uom1_si   
                sic_bran.uwm130.uom2_v = if deci(wdetail.tp2) <> 0 then deci(wdetail.tp2)  else stat.clastab_fil.uom2_si  
                sic_bran.uwm130.uom5_v = if deci(wdetail.tp3) <> 0 then deci(wdetail.tp3)  else stat.clastab_fil.uom5_si
                nv_uom1_v              = if deci(wdetail.tp1) <> 0 then deci(wdetail.tp1)  else stat.clastab_fil.uom1_si  
                nv_uom2_v              = if deci(wdetail.tp2) <> 0 then deci(wdetail.tp2)  else stat.clastab_fil.uom2_si  
                nv_uom5_v              = if deci(wdetail.tp3) <> 0 then deci(wdetail.tp3)  else stat.clastab_fil.uom5_si  .
                /*.. end A63-0129 ..*/ 
                /* comment by A63-0129..
                sic_bran.uwm130.uom1_v =  stat.clastab_fil.uom1_si   
                sic_bran.uwm130.uom2_v =  stat.clastab_fil.uom2_si  
                sic_bran.uwm130.uom5_v =  stat.clastab_fil.uom5_si
                nv_uom1_v              =  stat.clastab_fil.uom1_si   /*deci(wdetail.tp_bi)   */ 
                nv_uom2_v              =  stat.clastab_fil.uom2_si   /*deci(wdetail.tp_bi2) */  
                nv_uom5_v              =  stat.clastab_fil.uom5_si . /*deci(wdetail.tp_bi3) */ 
                .. end A63-0129 ..*/ 
        ASSIGN 
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
        If  wdetail.garage   =  ""  Then
            Assign nv_41     =  stat.clastab_fil.si_41unp
                   nv_42     =  stat.clastab_fil.si_42
                   nv_43     =  stat.clastab_fil.si_43
                   /*nv_seat41 =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.  A60-0225*/
                   nv_seat41 =  IF wdetail.seat <> 0 THEN wdetail.seat ELSE stat.clastab_fil.dri_41 + clastab_fil.pass_41. /*A60-0225*/
        Else If  wdetail.garage  =  "G"  Then
            Assign nv_41       =  stat.clastab_fil.si_41pai
                   nv_42       =  stat.clastab_fil.si_42
                   nv_43       =  stat.clastab_fil.impsi_43
                   /*nv_seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.  A60-0225*/
                   nv_seat41 =  IF wdetail.seat <> 0 THEN wdetail.seat ELSE stat.clastab_fil.dri_41 + clastab_fil.pass_41. /*A60-0225*/
    END.
    ASSIGN  nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                                nv_riskno,
                                nv_itemno).
END.    /* end Do transaction*/
ASSIGN
    s_recid3  = RECID(sic_bran.uwm130)
    nv_covcod =   wdetail.covcod
    nv_makdes =  wdetail.brand
    nv_moddes =  wdetail.model
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
    sic_bran.uwm301.bchcnt = nv_batcnt                 NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
    DO TRANSACTION:
        CREATE sic_bran.uwm301.
    END.
END.
ASSIGN 
    sic_bran.uwm301.policy   = sic_bran.uwm120.policy                 
    sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
    sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
    sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
    sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
    sic_bran.uwm301.itemno   = s_itemno
    sic_bran.uwm301.tariff   = wdetail.tariff    
    sic_bran.uwm301.covcod   = wdetail.covcod
    /*sic_bran.uwm301.cha_no   = wdetail.chasno        /*A56-0323*/
    sic_bran.uwm301.trareg   = nv_uwm301trareg*/       /*A56-0323*/
    sic_bran.uwm301.cha_no   = trim(nv_uwm301trareg)   /*A56-0323*/
    sic_bran.uwm301.trareg   = trim(nv_uwm301trareg)   /*A56-0323*/
    sic_bran.uwm301.drinam[1] = TRIM(wdetail.tiname) + " " + trim(wdetail.insnam)  
    sic_bran.uwm301.eng_no   = wdetail.eng
    sic_bran.uwm301.Tons     = INTEGER(wdetail.weight)
    sic_bran.uwm301.engine   = INTEGER(wdetail.engcc)
    sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage   = wdetail.garage
    sic_bran.uwm301.body     = wdetail.body
    sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv_ben83 = trim(wdetail.benname)
    sic_bran.uwm301.vehreg   = trim(wdetail.vehreg) 
    sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
    sic_bran.uwm301.vehuse   = trim(wdetail.vehuse)
    sic_bran.uwm301.modcod   = trim(wdetail.redbook) 
    sic_bran.uwm301.moddes   = caps(trim(wdetail.brand)) + " " + caps(trim(wdetail.model))  
    sic_bran.uwm301.vehgrp   = wdetail.cargrp   
    sic_bran.uwm301.sckno    = 0
    sic_bran.uwm301.itmdel   = NO 
    sic_bran.uwm301.prmtxt  = ""  
    sic_bran.uwm301.car_color = wdetail.colorcode /*A66-0160*/
    /* A67-0162 */
    sic_bran.uwm301.watts     = DECI(wdetail.watt)
    sic_bran.uwm301.maksi     = IF index(wdetail.subclass,"E") <> 0 THEN INTE(wdetail.maksi) ELSE 0     
    sic_bran.uwm301.eng_no2   = wdetail.engno2  
    sic_bran.uwm301.battper   = INTE(wdetail.battper)
    /*sic_bran.uwm301.battrate  = INTE(wdetail.battrate*/
    sic_bran.uwm301.battyr    = INTE(wdetail.battyr) 
    sic_bran.uwm301.battsi    = INTE(wdetail.battsi)
    sic_bran.uwm301.battprice = deci(wdetail.battprice)
    sic_bran.uwm301.battno    = wdetail.battno 
    sic_bran.uwm301.chargno   = wdetail.chagreno 
   /* sic_bran.uwm301.chargsi   = deci(wdetail.chargsi)  */
    sic_bran.uwm301.battflg   = IF DECI(wdetail.battprice) <> 0 THEN "Y" ELSE "N"  . 
  /*  sic_bran.uwm301.chargflg  = IF DECI(wdetail.chargprm) <> 0 THEN "Y" ELSE "N")*/
    FIND LAST wtxt WHERE wtxt.policy = wdetail.policy AND wtxt.poltyp = "V70" NO-LOCK NO-ERROR.
        IF AVAIL wtxt THEN DO:
            ASSIGN sic_bran.uwm301.logbok   = IF index(wtxt.inspno,"NO") <> 0 THEN "N" ELSE "Y"   
                   SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = trim(wtxt.acc1) + TRIM(wtxt.accprice1) 
                   SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = trim(wtxt.acc2) + TRIM(wtxt.accprice2) 
                   SUBSTRING(sic_bran.uwm301.prmtxt,121,60) = trim(wtxt.acc3) + TRIM(wtxt.accprice3) 
                   SUBSTRING(sic_bran.uwm301.prmtxt,181,60) = trim(wtxt.acc4) + TRIM(wtxt.accprice4)
                   SUBSTRING(sic_bran.uwm301.prmtxt,241,60) = trim(wtxt.acc5) + TRIM(wtxt.accprice5).
        END.
    IF nr_premtxt <> ""  THEN DO: 
        IF  sic_bran.uwm301.prmtxt = ""  THEN  ASSIGN sic_bran.uwm301.prmtxt = TRIM(nr_premtxt).
        ELSE DO:
            np_txt = 0.
            np_retxt = 0.
            np_txt = LENGTH(sic_bran.uwm301.prmtxt).
            np_retxt = LENGTH(nr_premtxt) .
            ASSIGN SUBSTR(sic_bran.uwm301.prmtxt,np_txt,np_retxt) = TRIM(nr_premtxt) .
        END.
    END.
    wdetail.tariff = sic_bran.uwm301.tariff.
    IF wdetail.compul = "y" THEN DO:
        sic_bran.uwm301.cert = "".
        IF LENGTH(wdetail.stk) = 11 THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
        IF LENGTH(wdetail.stk) = 13  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
        IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".
        FIND FIRST brStat.Detaitem USE-INDEX detaitem11     WHERE
           brStat.Detaitem.serailno = wdetail.stk          AND
           brstat.detaitem.yearReg    = nv_batchyr         AND
           brstat.detaitem.seqno      = STRING(nv_batchno) AND
           brstat.detaitem.seqno2     = STRING(nv_batcnt)  NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.Detaitem THEN DO:     
           CREATE brstat.Detaitem.
           ASSIGN 
               brStat.Detaitem.Policy   = sic_bran.uwm301.Policy
               brStat.Detaitem.RenCnt   = sic_bran.uwm301.RenCnt
               brStat.Detaitem.EndCnt   = sic_bran.uwm301.Endcnt
               brStat.Detaitem.RiskNo   = sic_bran.uwm301.RiskNo
               brStat.Detaitem.ItemNo   = sic_bran.uwm301.ItemNo
               brStat.Detaitem.serailno = wdetail.stk  
               brstat.detaitem.yearReg  = sic_bran.uwm301.bchyr
               brstat.detaitem.seqno    = STRING(sic_bran.uwm301.bchno)     
               brstat.detaitem.seqno2   = STRING(sic_bran.uwm301.bchcnt). 
        END.
    END.
    ASSIGN  sic_bran.uwm301.bchyr  = nv_batchyr     /* batch Year */
            sic_bran.uwm301.bchno  = nv_batchno     /* bchno      */
            sic_bran.uwm301.bchcnt = nv_batcnt .    /* bchcnt     */
    /*IF wdetail.drivnam1 <> ""  THEN RUN proc_mailtxt.*/ /* A67-0162 */
    n_countdriv = 0 .
    IF wdetail.drivnam1 <> ""  THEN RUN proc_driver. /*A67-0162 */
    ELSE DO:
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
                    brstat.mailtxt_fil.bchcnt  = nv_batcnt 
              /* add by : A67-0162 */
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
                    brstat.mailtxt_fil.dconsen   = ws0m009.dconsen   .
              ASSIGN 
                 nv_dlevel        = ws0m009.drivlevel
                 wdetail.drilevel = IF      INTE(wdetail.drilevel) = 0 THEN STRING(nv_dlevel) 
                                    ELSE IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
                 nv_dlevper       = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                                    ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60   .
                 /* end : A67-0162 */
                ASSIGN nv_drivno   = INTEGER(ws0m009.lnumber)
                       n_countdriv = INTEGER(ws0m009.lnumber). /* F67-0001*/
            END.
        END.
    END.
    s_recid4   = RECID(sic_bran.uwm301).
    /*F67-0001 */
    IF wdetail.prepol <> ""  THEN DO:
        IF wdetail.drivnam1 <> "" AND n_countdriv = 0 THEN DO:
            ASSIGN WDETAIL.WARNING = IF WDETAIL.WARNING <> "" THEN WDETAIL.WARNING + " | " + "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" ELSE "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" .
        END.
        ELSE IF wdetail.drivnam1 = "" AND n_countdriv <> 0 THEN DO:
            ASSIGN WDETAIL.WARNING = IF WDETAIL.WARNING <> "" THEN WDETAIL.WARNING + " | " + "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" ELSE "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" .
        END.
        ELSE IF wdetail.drivnam1 <> "" AND n_countdriv <> 0 THEN DO:
            ASSIGN WDETAIL.WARNING = IF WDETAIL.WARNING <> "" THEN WDETAIL.WARNING + " | " + "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" ELSE "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" .
        END.
    END.
  ....end : F67-0001.....*/
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_mailtxt c-Win 
PROCEDURE 00-proc_mailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0162..
IF  int(wdetail.drivnam) <> 0  THEN DO :      /*note add 07/11/2005*/
 DEF VAR nv_drivbir1 AS CHAR FORMAT "9999".
 DEF VAR nv_drivbir2 AS CHAR FORMAT "9999".
 
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
  
  nv_drivage1 =  YEAR(TODAY) - INT(SUBSTR(wdetail.bdatedri1,7,4)) .
  nv_drivage2 =  YEAR(TODAY) - INT(SUBSTR(wdetail.bdatedri2,7,4)).
 
  IF wdetail.bdatedri1 <> " "  AND wdetail.drivnam1 <> " " THEN DO: /*note add & modified*/
     nv_drivbir1       = STRING(INT(SUBSTR(bdatedri1,7,4)) + 543).
     wdetail.bdatedri1 = SUBSTR(bdatedri1,1,6) + nv_drivbir1.
  END.

  IF wdetail.bdatedri2 <>  " " AND wdetail.drivnam2 <> " " THEN DO: /*note add & modified */
     nv_drivbir2      = STRING(INT(SUBSTR(wdetail.bdatedri2,7,4)) + 543).
     wdetail.bdatedri2 = SUBSTR(wdetail.bdatedri2,1,6) + nv_drivbir2.
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
                     brstat.mailtxt_fil.ltext     = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)). 
                     brstat.mailtxt_fil.ltext2    = wdetail.bdatedri1 + "  " 
                                                  + string(nv_drivage1).
                     nv_drivno                    = 1.
                     ASSIGN /*a490166*/
                     brstat.mailtxt_fil.bchyr = nv_batchyr 
                     brstat.mailtxt_fil.bchno = nv_batchno 
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                     SUBSTRING(brstat.mailtxt_fil.ltext,51,6)    = TRIM(wdetail.sexdriv1)
                     SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)  = TRIM(wdetail.occupdri1)
                     SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.driveno1) /*เลขบัตร ปชช. */
                     SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = "".

              IF wdetail.drivnam2 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil. 
                    ASSIGN
                        brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                        brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                        brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)). 
                        brstat.mailtxt_fil.ltext2   = wdetail.bdatedri2 + "  "
                                                    + string(nv_drivage2). 
                        nv_drivno                   = 2.
                        ASSIGN /*a490166*/
                        brstat.mailtxt_fil.bchyr = nv_batchyr 
                        brstat.mailtxt_fil.bchno = nv_batchno 
                        brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                        SUBSTRING(brstat.mailtxt_fil.ltext,51,6)    = TRIM(wdetail.sexdriv2)
                        SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)  = TRIM(wdetail.occupdri2)
                        SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.driveno2) /*เลขบัตร ปชช. */
                        SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = "".  
              END.  /*drivnam2 <> " " */
        END. /*End Avail Brstat*/
        ELSE  DO:
              CREATE  brstat.mailtxt_fil.
              ASSIGN  brstat.mailtxt_fil.policy     = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
                      brstat.mailtxt_fil.lnumber    = nv_lnumber.
                      brstat.mailtxt_fil.ltext      = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)). 
                      brstat.mailtxt_fil.ltext2     = wdetail.bdatedri1 + "  "
                                                    +  TRIM(string(nv_drivage1)).
                       ASSIGN 
                       brstat.mailtxt_fil.bchyr = nv_batchyr 
                       brstat.mailtxt_fil.bchno = nv_batchno 
                       brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                       SUBSTRING(brstat.mailtxt_fil.ltext,51,6)    = TRIM(wdetail.sexdriv1)
                       SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)  = TRIM(wdetail.occupdri1)
                       SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.driveno1) /*เลขบัตร ปชช. */
                       SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = "".


                      IF wdetail.drivnam2 <> "" THEN DO:
                            CREATE  brstat.mailtxt_fil.
                                ASSIGN
                                brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                                brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)). 
                                brstat.mailtxt_fil.ltext2   = wdetail.bdatedri2 + "  "
                                                            + TRIM(string(nv_drivage2)).
                                ASSIGN /*a490166*/
                                brstat.mailtxt_fil.bchyr = nv_batchyr 
                                brstat.mailtxt_fil.bchno = nv_batchno 
                                brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                                SUBSTRING(brstat.mailtxt_fil.ltext,51,6)   = TRIM(wdetail.sexdriv1)
                               SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)  = TRIM(wdetail.occupdri1)
                               SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.driveno1) /*เลขบัตร ปชช. */
                               SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = "".
                      END. /*drivnam2 <> " " */
        END. /*Else DO*/
 END. /*note add for mailtxt 07/11/2005*/
..end A67-0162...*/
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
  DISPLAY fi_loaddat fi_pack fi_campaign fi_branch fi_producer fi_agent 
          fi_prevbat fi_bchno fi_bchyr fi_filename fi_output1 fi_output2 
          fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname 
          fi_impcnt fi_process fi_completecnt fi_premtot fi_premsuc fi_compa 
          fi_report 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE br_camp buexp fi_loaddat fi_pack fi_campaign fi_branch fi_producer 
         fi_agent fi_prevbat fi_bchno fi_bchyr fi_filename bu_file fi_output1 
         fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit bu_hpbrn 
         bu_hpacno1 bu_hpagent br_wdetail fi_process fi_compa fi_report 
         RECT-372 RECT-373 RECT-376 RECT-377 RECT-378 
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
DEF VAR nclass_red AS CHAR FORMAT "x(3)" INIT "".
ASSIGN 
    wdetail.compul = "y"
    wdetail.tariff = "9"
    wdetail.covcod = "T"
    n_sclass72     = wdetail.subclass
    nclass_red     = wdetail.subclass.

RUN proc_chkcomp. 
/* comment by : A67-0204 ....
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
/*Add A56-0104*/
FIND LAST sicsyac.xmm106 WHERE 
    sicsyac.xmm106.tariff  = "9"      AND
    sicsyac.xmm106.bencod  = "comp"   AND
    substr(sicsyac.xmm106.class,1,3) = SUBSTR(wdetail.subclass,1,3)            AND
    sicsyac.xmm106.covcod  = "t"                                               AND 
   (sicsyac.xmm106.baseap  = TRUNCATE(((deci(wdetail.gross_prm) * 100 ) / 107.43 ),0) OR
    sicsyac.xmm106.baseap  = ROUND(((deci(wdetail.gross_prm) * 100 ) / 107.43 ),0))   NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm106 THEN
    ASSIGN wdetail.subclass = sicsyac.xmm106.class .
... end : A67-0204...*/

IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
        wdetail.pass    = "N"
        wdetail.OK_GEN  = "N". 
END.
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
/* comment by : A67-0204...
---------- class --------------
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
...end : A67-0204....    */
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
ASSIGN 
    chkred  = NO
    n_brand = ""
    n_index = 0 
    n_model = ""
    /*n_sclass72 = substr(wdetail.subclass,1,3)*/   .

FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
    makdes31.moddes =  wdetail.prempa + n_sclass72 NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL makdes31  THEN
    ASSIGN n_ratmin = makdes31.si_theft_p   
    n_ratmax        = makdes31.load_p   .    
ELSE ASSIGN n_ratmin = 0
    n_ratmax         = 0.
IF index(wdetail.brand,"benz") <> 0 THEN DO: 
    IF INDEX(wdetail.brand," ") <> 0 THEN  
        ASSIGN wdetail.model = SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1 )
        wdetail.brand = "MERCEDES-BENZ".
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
IF INDEX(wdetail.model,"vigo") <> 0 THEN wdetail.model = "vigo".
ELSE IF INDEX(wdetail.model,"altis") <> 0 THEN wdetail.model = "altis".
ELSE IF INDEX(wdetail.model,"soluna") <> 0 THEN wdetail.model = "vios".
ELSE IF INDEX(wdetail.model," ") <> 0 THEN 
    ASSIGN wdetail.model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ") - 1 ).
END.
IF      substr(nclass_red,1,3) = "110"  THEN nclass_red = "110".
ELSE IF substr(nclass_red,1,3) = "120"  THEN nclass_red = "110".
ELSE IF substr(nclass_red,1,3) = "210"  THEN nclass_red = "120".
ELSE IF substr(nclass_red,1,3) = "220"  THEN nclass_red = "220".
ELSE IF substr(nclass_red,1,3) = "320"  THEN nclass_red = "320".
ELSE IF substr(nclass_red,1,3) = "140"  THEN nclass_red = "320".
ELSE IF substr(nclass_red,1,3) = "240"  THEN nclass_red = "320".
IF deci(wdetail.si) = 0 THEN DO:
    IF (Integer(wdetail.engcc) = 0 )  THEN DO:
        Find First stat.maktab_fil USE-INDEX maktab04         Where
            stat.maktab_fil.makdes   = wdetail.brand            And                  
            index(stat.maktab_fil.moddes,wdetail.model) <> 0    And
            stat.maktab_fil.makyea   = Integer(wdetail.caryear) AND 
            /*stat.maktab_fil.engine   <=    Integer(wdetail.engcc)  AND*/
            stat.maktab_fil.sclass   =  nclass_red        AND
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
            /*stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND*/
            stat.maktab_fil.sclass   =     nclass_red               AND
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
        stat.maktab_fil.makdes   =     wdetail.brand            And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
        /*stat.maktab_fil.engine   =    Integer(wdetail.engcc)    AND*/
        stat.maktab_fil.sclass   =     nclass_red         AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
        stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 )  GE deci(wdetail.si) )  AND   
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
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
IF nv_modcod = ""  THEN DO: 
    ASSIGN chkred = YES 
        n_brand       = ""
        n_index       = 0
        n_model       = "".
    RUN proc_model_brand.
    /*RUN proc_maktab.*/
END.

    /*
Find First stat.maktab_fil USE-INDEX  maktab04            Where
    stat.maktab_fil.makdes   =     wdetail.brand            And                  
    index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
    stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
    stat.maktab_fil.sclass   =     n_sclass72               AND
   (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
    stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
    stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
If  avail stat.maktab_fil  THEN 
    ASSIGN wdetail.redbook = stat.maktab_fil.modcod.
ELSE RUN proc_maktab.*/
IF wdetail.redbook  = ""  THEN DO: 
    ASSIGN chkred = YES 
        n_brand       = ""
        n_index       = 0
        n_model       = "".
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
    nv_moddes  =  wdetail.model
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
     Assign sic_bran.uwm301.policy  = sic_bran.uwm120.policy                   
         sic_bran.uwm301.rencnt     = sic_bran.uwm120.rencnt
         sic_bran.uwm301.endcnt     = sic_bran.uwm120.endcnt
         sic_bran.uwm301.riskgp     = sic_bran.uwm120.riskgp
         sic_bran.uwm301.riskno     = sic_bran.uwm120.riskno
         sic_bran.uwm301.itemno     = s_itemno
         sic_bran.uwm301.tariff     = wdetail.tariff
         sic_bran.uwm301.covcod     = nv_covcod
         sic_bran.uwm301.cha_no     = wdetail.chasno
         sic_bran.uwm301.eng_no     = wdetail.eng
         sic_bran.uwm301.Tons       = INTEGER(wdetail.weight) 
         sic_bran.uwm301.engine     = INTEGER(wdetail.engcc)
         sic_bran.uwm301.yrmanu     = INTEGER(wdetail.caryear)
         sic_bran.uwm301.garage     = wdetail.garage
         sic_bran.uwm301.body       = wdetail.body
         sic_bran.uwm301.vehgrp     = wdetail.cargrp
         sic_bran.uwm301.seats      = INTEGER(wdetail.seat)
         sic_bran.uwm301.mv_ben83   = wdetail.benname
         /*sic_bran.uwm301.vehreg     = wdetail.vehreg +  wdetail.re_country*//*A55-0268*/
         sic_bran.uwm301.vehreg     = trim(wdetail.vehreg)   /*A55-0325*/ 
         sic_bran.uwm301.yrmanu     = inte(wdetail.caryear)
         sic_bran.uwm301.vehuse     = wdetail.vehuse
         /*sic_bran.uwm301.moddes     = wdetail.brand + " " + wdetail.model */ /*-A60-0118-*/ 
         sic_bran.uwm301.moddes     = caps(trim(wdetail.brand)) + " " + caps(trim(wdetail.model))  /*-A60-0118-*/ 
         sic_bran.uwm301.modcod     = wdetail.redbook 
         sic_bran.uwm301.sckno      = 0              
         sic_bran.uwm301.itmdel     = NO
         sic_bran.uwm301.car_color  = wdetail.colorcode  /* A66-0160 */
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
     /*IF wdetail.redbook <> "" THEN DO:     /*กรณีที่มีการระบุ Code รถมา*/
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
             sic_bran.uwm301.engine =  stat.maktab_fil.eng.
     END.
     ELSE DO:
         Find First stat.maktab_fil USE-INDEX maktab04             Where
             stat.maktab_fil.makdes   =     wdetail.brand            And                  
             index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
             stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
             stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
             stat.maktab_fil.sclass   =     n_sclass72               AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
             stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
         If  avail stat.maktab_fil  Then 
             ASSIGN wdetail.redbook =  stat.maktab_fil.modcod
             sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
             sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
             wdetail.cargrp          =  stat.maktab_fil.prmpac
             sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
             sic_bran.uwm301.body    =  stat.maktab_fil.body.
     END.
     */
     FIND sic_bran.uwd132  USE-INDEX uwd13201    WHERE                                
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
     ASSIGN  /*wdetail.comp_prm = string(TRUNCATE(((deci(wdetail.comp_prm)  * 100 ) / 107.43),0))*/
         sic_bran.uwd132.bencod  = "COMP"                 /*Benefit Code*/
         sic_bran.uwd132.benvar  = ""                     /*Benefit Variable*/
         sic_bran.uwd132.rate    = 0                      /*Premium Rate %*/
         sic_bran.uwd132.gap_ae  = NO                     /*GAP A/E Code*/
         sic_bran.uwd132.gap_c   = deci(wdetail.gross_prm)    /*deci(wdetail.premt)*//*GAP, per Benefit per Item*/
         sic_bran.uwd132.dl1_c   = 0                      /*Disc./Load 1,p. Benefit p.Item*/
         sic_bran.uwd132.dl2_c   = 0                      /*Disc./Load 2,p. Benefit p.Item*/
         sic_bran.uwd132.dl3_c   = 0                      /*Disc./Load 3,p. Benefit p.Item*/
         sic_bran.uwd132.pd_aep  = "E"                    /*Premium Due A/E/P Code*/
         sic_bran.uwd132.prem_c  = deci(wdetail.gross_prm)    /*PD, per Benefit per Item*/
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
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    ASSIGN   /*sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap*/
                        sic_bran.uwd132.gap_c  = deci(wdetail.gross_prm)
                        sic_bran.uwd132.prem_c = deci(wdetail.gross_prm)
                        nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                        nv_gap                 = deci(wdetail.gross_prm)
                        nv_prem                = deci(wdetail.gross_prm) .
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
                    /*sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.*/
                    sic_bran.uwd132.gap_c  = deci(wdetail.gross_prm).
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                               RECID(sic_bran.uwd132),
                                               sic_bran.uwm301.tariff).
                    ASSIGN nv_gap  = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem    = nv_prem + sic_bran.uwd132.prem_c
                        nv_gap     = deci(wdetail.gross_prm)
                        nv_prem    = deci(wdetail.gross_prm).
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
                    ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.weight).
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
                        ASSIGN    /*sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                        sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap*/
                            sic_bran.uwd132.gap_c  = deci(wdetail.gross_prm)
                            sic_bran.uwd132.prem_c = deci(wdetail.gross_prm)
                            nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                            nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                            nv_gap                 = deci(wdetail.gross_prm)
                            nv_prem                = deci(wdetail.gross_prm).
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
                        sic_bran.uwd132.gap_c  = deci(wdetail.gross_prm).
                        RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                                   RECID(sic_bran.uwd132),
                                                   sic_bran.uwm301.tariff).
                        nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                        nv_gap        = deci(wdetail.gross_prm).
                        nv_prem       = deci(wdetail.gross_prm).
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
                ELSE IF SUBSTRING(wdetail.subclass,1,3) = "140" THEN nv_key_a = inte(wdetail.weight).
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
                    ASSIGN   /*sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap*/
                        sic_bran.uwd132.gap_c  = deci(wdetail.gross_prm)
                        sic_bran.uwd132.prem_c = deci(wdetail.gross_prm)
                        nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem                = nv_prem + sic_bran.uwd132.prem_c
                        nv_gap                 = deci(wdetail.gross_prm)
                        nv_prem                = deci(wdetail.gross_prm).
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
                    sic_bran.uwd132.gap_c  = deci(wdetail.gross_prm).
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100),         
                                         RECID(sic_bran.uwd132),                
                                         sic_bran.uwm301.tariff).
                    ASSIGN
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c
                    nv_gap        = deci(wdetail.gross_prm)
                    nv_prem       = deci(wdetail.gross_prm).
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
ASSIGN  
    nv_gap2      = 0
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
ASSIGN fi_process = "Start create wdetail...".
DISP fi_process WITH FRAM fr_main.
For each  wdetail :
    DELETE  wdetail.
END.
RUN proc_cleardata.
INPUT FROM VALUE(fi_FileName).
REPEAT:
IMPORT DELIMITER "|" 
        n_poltyp               /* ประเภทกรมธรรม์  */                 
        n_bray                 /* สาขา AY         */                 
        n_contract             /* Contract no     */                 
        n_account_no           /* รหัสอ้างอิง     */                 
        n_inscode              /* รหัสลูกค้า      */                 
        n_campcode             /* รหัสแคมเปญ      */                 
        n_campname             /* ชื่อแคมเปญ      */                 
        n_proname              /* ชื่อผลิตภัณฑ์   */                 
        n_packcode             /* ProspectID      */                 
        n_prepol               /* กรมธรรม์เดิม    */                 
        n_tiname               /* คำนำหน้าชื่อ ผู้เอาประกัน */       
        n_insnam               /* ชื่อ ผู้เอาประกัน   */             
        n_icno                 /* เลขบัตรผู้เอาประกัน */             
        n_bdate                /* วันเกิดผู้เอาประกัน */             
        n_tel                  /* เบอร์โทรผู้เอาประกัน*/             
        n_addrsend1            /* ที่อยู่จัดส่ง 1     */             
        n_addrsend2            /* ที่อยู่จัดส่ง 2     */             
        n_addrsend3            /* ที่อยู่จัดส่ง 3     */             
        n_addrsend4            /* ที่อยู่จัดส่ง 4     */             
        n_paytitle             /* คำนำหน้าชื่อ ผู้จ่ายเงิน*/         
        n_payname              /* ชื่อ ผู้จ่ายเงิน      */           
        n_payic                /* เลขประจำตัวผู้เสียภาษี*/           
        n_addrpay1             /* ที่อยู่ออกใบเสร็จ1    */           
        n_addrpay2             /* ที่อยู่ออกใบเสร็จ2    */           
        n_addrpay3             /* ที่อยู่ออกใบเสร็จ3    */           
        n_addrpay4             /* ที่อยู่ออกใบเสร็จ4    */           
        n_ben_name             /* ผู้รับผลประโยชน์      */           
        n_pmenttyp             /* ประเภทการจ่าย         */           
        n_pmentcode2           /* ช่องทางการจ่าย        */           
        n_brand                /* ยี่ห้อ    */                       
        n_Model                /* รุ่น      */                       
        n_body                 /* แบบตัวถัง */                       
        n_vehreg               /* ทะเบียน   */                       
        n_re_country           /* จังหวัดทะเบียน */                  
        n_chasno               /* เลขตัวถัง      */                  
        n_eng                  /* เลขเครื่อง     */                  
        n_caryear              /* ปีรถ           */                  
        n_engcc                /* ซีซี           */                  
        n_class                /* คลาสรถ         */                  
        n_garage               /* การซ่อม        */                  
        n_covcod               /* ประเภทการประกัน */                 
        n_covtyp               /* รหัสการประกัน   */                 
        n_comdat               /* วันที่คุ้มครอง  */                 
        n_expdat               /* วันที่หมดอายุ   */                 
        n_si                   /* ทุนประกัน       */ 
        n_fi                   /* ทุนสูญหายไฟไหม้ */
        n_prem1                /* เบี้ยสุทธิก่อนหักส่วนลด */         
        n_gross_prm            /* เบี้ยสุทธิหลังหักส่วนลด */         
        n_stamp                /* สแตมป์   */                        
        n_vat                  /* ภาษี     */                        
        n_premtotal            /* เบี้ยรวม */                        
        n_deduct               /* Deduct   */                        
        n_fleetper             /* fleet    */                        
        n_ncb                  /* ncb      */                        
        n_othper               /* other    */                        
        n_cctvper              /* cctv     */                        
        n_driver               /* ระบุผู้ขับขี่       */             
        n_drivnam1             /* ชื่อผู้ขับขี่1      */             
        n_driveno1             /* เลขบัตรผู้ขับขี่1   */             
        n_occupdri1            /* อาชีพผู้ขับขี่1     */             
        n_sexdriv1             /* เพศผู้ขับขี่1       */             
        n_bdatedri1            /* วันเกิดผู้ขับขี่1   */
        n_drivlicen1           /* A67-0162*/
        n_drivcardexp1         /* A67-0162*/
        n_drivnam2             /* ชื่อผู้ขับขี่2      */             
        n_driveno2             /* เลขบัตรผู้ขับขี่2   */             
        n_occupdri2            /* อาชีพผู้ขับขี่2     */             
        n_sexdriv2             /* เพศผู้ขับขี่2       */             
        n_bdatedri2            /* วันเกิดผู้ขับขี่2   */ 
        n_drivlicen2           /* A67-0162*/   
        n_drivcardexp2         /* A67-0162*/  
        /* A67-0162 */
        n_drivnam3     
        n_driveno3      
        n_occupdri3    
        n_sexdriv3      
        n_bdatedri3     
        n_drivlicen3    
        n_drivcardexp3 
        n_drivnam4     
        n_driveno4      
        n_occupdri4     
        n_sexdriv4      
        n_bdatedri4     
        n_drivlicen4    
        n_drivcardexp4  
        n_drivnam5     
        n_driveno5     
        n_occupdri5    
        n_sexdriv5     
        n_bdatedri5    
        n_drivlicen5   
        n_drivcardexp5 
        /* end : A67-0162 */
        n_accdetail1           /* รายละเอียดอุปกรณ์1  */             
        n_accprice1            /* ราคาอุปกรณ์1        */             
        n_accdetail2           /* รายละเอียดอุปกรณ์2  */             
        n_accprice2            /* ราคาอุปกรณ์2        */             
        n_accdetail3           /* รายละเอียดอุปกรณ์3  */             
        n_accprice3            /* ราคาอุปกรณ์3        */             
        n_accdetail4           /* รายละเอียดอุปกรณ์4  */             
        n_accprice4            /* ราคาอุปกรณ์4        */             
        n_accdetail5           /* รายละเอียดอุปกรณ์5  */             
        n_accprice5            /* ราคาอุปกรณ์5        */             
        n_inspdate             /* วันที่ตรวจสภาพ      */             
        n_brokname             /* ชื่อผู้ตรวจสภาพ     */             
        n_licenBroker          /* เบอร์โทรตรวจสภาพ    */             
        n_brokcode             /* สถานที่ตรวจสภาพ     */             
        n_inspdetail           /* รายละเอียดการตรวจสภาพ */           
        n_not_date             /* วันที่ขาย             */           
        n_paydate              /* วันที่รับชำระเงิน     */           
        n_delidetail           /* รายละเอียดการจัดส่ง   */           
        n_gift                 /* Agent name            */           
        n_remark               /* หมายเหตุ              */           
        n_inspno               /* เลขตรวจสภาพ           */           
        n_remarkinsp           /* ผลการตรวจ             */           
        n_damang1              /* ความเสียหาย1          */           
        n_damang2              /* ความเสียหาย2          */           
        n_damang3              /* ความเสียหาย3          */           
        n_dataoth              /* ข้อมูลอื่นๆ           */           
        n_policy               /* เบอร์กรมธรรม์         */           
        n_producer             /* Producer              */           
        n_agent                /* Agent                 */ 
        n_dealer               /* Dealer code */    /*A65-0115*/
        n_hobr                 /* สาขา STY              */           
        n_remark2            /* Remark 2              */ 
        n_colorcode          /*A66-0160*/
        /* A67-0162*/
        n_watt          
        n_evmotor1      
        n_evmotor2      
        n_evmotor3      
        n_evmotor4      
        n_evmotor5 
        n_carprice 
        n_battflag      
        n_battyr        
        n_battdate      
        n_battprice     
        n_battno        
        n_battsi        
        n_chagreno      
        n_chagrebrand .
        /* A67-0162*/
   IF index(n_poltyp,"ประเภท") <> 0 THEN NEXT.
   ELSE IF n_poltyp  = "" THEN  NEXT.
   ELSE DO:
       RUN proc_assigndetail.
       RUN proc_cleardata.
   END.
END.
RUN proc_assign2.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign-bp c-Win 
PROCEDURE proc_assign-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*ASSIGN fi_process = "Start create wdetail...".
DISP fi_process WITH FRAM fr_main.
For each  wdetail :
    DELETE  wdetail.
END.
RUN proc_cleardata.
INPUT FROM VALUE(fi_FileName).
REPEAT:
IMPORT DELIMITER "|" 
        n_poltyp                /* ประเภทกรมธรรม์      */ 
        n_bray
        n_contract
        n_account_no            /* รหัสอ้างอิง         */  
        n_inscode               /* รหัสลูกค้า          */  
        n_campcode              /* รหัสแคมเปญ          */  
        n_campname              /* ชื่อแคมเปญ          */  
        n_procode               /* รหัสผลิตภัณฑ์       */  
        n_proname               /* ชื่อผลิตภัณฑ์       */  
        n_packname             /* ชื่อแพคเก็จ         */  
        n_packcode              /* รหัสแพคเก็จ         */ 
        n_prepol                /* เบอร์เดิม            */
        n_instype               /* ประเภทผู้เอาประกัน  */  
        n_tiname                /* คำนำหน้าชื่อ ผู้เอาประกัน      */  
        n_insnam                /* ชื่อ ผู้เอาประกัน   */         
        n_title_eng             /* คำนำหน้าชื่อ ผู้เอาประกัน (Eng)*/  
        n_insname_eng           /* ชื่อ ผู้เอาประกัน (Eng)        */  
        n_icno                  /* เลขบัตรผู้เอาประกัน */  
        n_bdate                 /* วันเกิดผู้เอาประกัน */  
        n_occup                 /* อาชีพผู้เอาประกัน   */  
        n_tel                   /* เบอร์โทรผู้เอาประกัน*/  
        n_mail                  /* อีเมล์ผู้เอาประกัน  */  
        n_addrpol1              /* ที่อยู่หน้าตาราง1   */  
        n_addrpol2              /* ที่อยู่หน้าตาราง2   */  
        n_addrpol3              /* ที่อยู่หน้าตาราง3   */  
        n_addrpol4              /* ที่อยู่หน้าตาราง4   */  
        n_addrsend1             /* ที่อยู่จัดส่ง 1     */  
        n_addrsend2             /* ที่อยู่จัดส่ง 2     */  
        n_addrsend3             /* ที่อยู่จัดส่ง 3     */  
        n_addrsend4             /* ที่อยู่จัดส่ง 4     */  
        n_paytype               /* ประเภทผู้จ่ายเงิน   */  
        n_paytitle              /* คำนำหน้าชื่อ ผู้จ่ายเงิน*/  
        n_payname               /* ชื่อ ผู้จ่ายเงิน        */ 
        n_payic                 /* เลขประจำตัวผู้เสียภาษี  */  
        n_addrpay1              /* ที่อยู่ออกใบเสร็จ1 */  
        n_addrpay2              /* ที่อยู่ออกใบเสร็จ2 */  
        n_addrpay3              /* ที่อยู่ออกใบเสร็จ3 */  
        n_addrpay4              /* ที่อยู่ออกใบเสร็จ4 */  
        n_branch                /* สาขา               */  
        n_ben_name              /* ผู้รับผลประโยชน์   */  
        n_pmentcode             /* รหัสประเภทการจ่าย  */  
        n_pmenttyp              /* ประเภทการจ่าย      */  
        n_pmentcode1            /* รหัสช่องทางการจ่าย */  
        n_pmentcode2            /* ช่องทางการจ่าย     */  
        n_pmentbank             /* ธนาคารที่จ่าย      */  
        n_pmentdate             /* วันที่จ่าย         */  
        n_pmentsts              /* สถานะการจ่าย       */  
        n_brand                 /* ยี่ห้อ             */  
        n_Model                 /* รุ่น               */  
        n_body                  /* แบบตัวถัง          */  
        n_vehreg                /* ทะเบียน            */  
        n_re_country            /* จังหวัดทะเบียน     */  
        n_chasno                /* เลขตัวถัง          */  
        n_eng                   /* เลขเครื่อง         */  
        n_caryear               /* ปีรถ               */  
        n_seate                 /* ที่นั่ง            */  
        n_engcc                 /* ซีซี               */  
        n_power                 /* น้ำหนัก            */  
        n_class                 /* คลาสรถ             */  
        n_garage                /* การซ่อม            */  
        n_colorcode             /* สี                 */  
        n_covcod                /* ประเภทการประกัน    */  
        n_covtyp                /* รหัสการประกัน      */  
        n_comdat                /* วันที่คุ้มครอง     */  
        n_expdat                /* วันที่หมดอายุ      */  
        n_si                    /* ทุนประกัน          */  
        n_prem1                 /* เบี้ยสุทธิก่อนหักส่วนลด              */  
        n_gross_prm             /* เบี้ยสุทธิหลังหักส่วนลด              */  
        n_stamp                 /* สแตมป์                               */  
        n_vat                   /* ภาษี                                 */  
        n_premtotal             /* เบี้ยรวม                             */  
        n_deduct                /* Deduct                               */  
        n_fleetper              /* fleet                                */  
        n_ncb                   /* ncb                                  */  
        n_othper                /* other                                */  
        n_cctvper               /* cctv                                 */  
        n_driver                /* ระบุผู้ขับขี่                        */  
        n_drivnam1              /* ชื่อผู้ขับขี่1                       */  
        n_driveno1              /* เลขบัตรผู้ขับขี่1                    */  
        n_occupdri1             /* อาชีพผู้ขับขี่1                      */  
        n_sexdriv1              /* เพศผู้ขับขี่1                        */  
        n_bdatedri1             /* วันเกิดผู้ขับขี่1                    */  
        n_drivnam2              /* ชื่อผู้ขับขี่2                       */  
        n_driveno2              /* เลขบัตรผู้ขับขี่2                    */  
        n_occupdri2             /* อาชีพผู้ขับขี่2                      */  
        n_sexdriv2              /* เพศผู้ขับขี่2                        */  
        n_bdatedri2             /* วันเกิดผู้ขับขี่2                    */  
        n_acc1                  /* อุปกรณ์ตกแต่ง1                       */  
        n_accdetail1            /* รายละเอียดอุปกรณ์1                   */  
        n_accprice1             /* ราคาอุปกรณ์1                         */  
        n_acc2                  /* อุปกรณ์ตกแต่ง2                       */  
        n_accdetail2            /* รายละเอียดอุปกรณ์2                   */  
        n_accprice2             /* ราคาอุปกรณ์2                         */  
        n_acc3                  /* อุปกรณ์ตกแต่ง3                       */  
        n_accdetail3            /* รายละเอียดอุปกรณ์3                   */  
        n_accprice3             /* ราคาอุปกรณ์3                         */  
        n_acc4                  /* อุปกรณ์ตกแต่ง4                       */  
        n_accdetail4            /* รายละเอียดอุปกรณ์4                   */  
        n_accprice4             /* ราคาอุปกรณ์4                         */  
        n_acc5                  /* อุปกรณ์ตกแต่ง5                       */  
        n_accdetail5            /* รายละเอียดอุปกรณ์5                   */  
        n_accprice5             /* ราคาอุปกรณ์5                         */  
        n_inspdate              /* วันที่ตรวจสภาพ                       */  
        n_inspdate_app          /* วันที่อนุมัติผลการตรวจ               */  
        n_inspsts               /* ผลการตรวจสภาพ                        */  
        n_inspdetail            /* รายละเอียดการตรวจสภาพ                */  
        n_not_date              /* วันที่ขาย                            */  
        n_paydate               /* วันที่รับชำระเงิน                    */  
        n_paysts                /* สถานะการจ่าย                         */  
        n_licenBroker           /* เลขที่ใบอนุญาตนายหน้า                */  
        n_brokname              /* ชื่อนายหน้า                          */  
        n_brokcode              /* รหัสนายหน้า                          */  
        n_lang                  /* ภาษา                                 */  
        n_deli                  /* การจัดส่งกรมธรรม์                    */  
        n_delidetail            /* รายละเอียดการจัดส่ง                  */  
        n_gift                  /* ของแถม                               */  
        n_remark                /* หมายเหตุ                             */  
        n_inspno                /* เลขตรวจสภาพ                          */  
        n_remarkinsp            /* ผลการตรวจ                            */  
        n_damang1               /* ความเสียหาย1                         */  
        n_damang2               /* ความเสียหาย2                         */  
        n_damang3               /* ความเสียหาย3                         */  
        n_dataoth               /* ข้อมูลอื่นๆ                          */  
        n_policy                /* Policy  */ 
        n_producer
        n_agent
        n_hobr
        n_remark2 .


   IF index(n_poltyp,"ประเภท") <> 0 THEN NEXT.
   ELSE IF n_poltyp  = "" THEN  NEXT.
   ELSE DO:
       RUN proc_assigndetail.
       RUN proc_cleardata.
   END.
END.
RUN proc_assign2.*/

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
DEF VAR  b_eng   AS DECI FORMAT  ">>>>9.99-".
DEF VAR  n_date  AS CHAR FORMAT  "x(10)". 
DEF VAR  ind1 AS INTE.
DEF VAR  ind2 AS INTE.
DEF VAR  ind3 AS INTE.
DEF VAR  n_addr AS CHAR FORMAT "X(350)" .
DEF VAR  ind4 AS INTE. 
DEF VAR  n_char AS CHAR FORMAT  "x(75)".
FOR EACH wdetail WHERE wdetail.policy  NE " "  .

    FOR EACH wtxt WHERE wtxt.inscode = wdetail.inscode AND 
                        wtxt.poltyp  <> wdetail.poltyp  NO-LOCK.
        ASSIGN wdetail.cr_2 =  wtxt.policy .
    END.
    ASSIGN 
        n_addr         = ""
        ind1           = 0 
        ind2           = 0
        ind3           = 0
        ind4           = 0
        n_char         = ""
        n_date         = STRING(TODAY,"99/99/9999") 
        b_eng          = round((DECI(wdetail.engcc) / 1000),1)   
        b_eng          = b_eng * 1000 
        wdetail.tariff = IF wdetail.poltyp = "v72" THEN "9" ELSE "x"
        wdetail.vehuse = IF wdetail.vehuse = "" THEN "1" ELSE wdetail.vehuse
        fi_process     = "Check data wdetail...".

    IF  LENGTH(wdetail.engcc) = 2 THEN wdetail.engcc  = string(deci(wdetail.engcc) * 100 ) .
    ELSE wdetail.engcc  = STRING(b_eng).

    IF INDEX(wdetail.subclass,"E") <> 0 AND INTE(wdetail.watt) = 0  THEN ASSIGN wdetail.watt = wdetail.engcc . /* A67-0162*/

    DISP fi_process WITH FRAM fr_main .
    /* A65-0115....
    FIND LAST  stat.insure USE-INDEX insure01  WHERE 
          stat.Insure.compno   = "AYCAL"            AND
          stat.insure.insno    = TRIM(wtxt.branch)    NO-LOCK  NO-ERROR.
      IF AVAIL stat.insure THEN DO: 
          ASSIGN wdetail.branch = trim(stat.insure.branch) .    
      END.
    */
    IF date(wdetail.comdat) < 04/01/2020  THEN DO: /* A63-0129 */
     FIND LAST brstat.insure USE-INDEX insure03 WHERE 
              brstat.insure.compno        = fi_campaign AND /*campaign*/
              brstat.insure.insno         = fi_campaign AND
              trim(brstat.insure.text4)   = trim(wdetail.subclass) AND  /*class */                          
              trim(brstat.insure.text1)   = trim(wdetail.garage)   AND
              TRIM(brstat.insure.text2)   = ""                     AND
              trim(brstat.insure.vatcode) = trim(wdetail.covcod)   NO-ERROR NO-WAIT.   /*cover*/
        IF AVAIL brstat.insure THEN DO:
                ASSIGN wdetail.tp1      = brstat.insure.lname   
                       wdetail.tp2      = brstat.insure.addr1   
                       wdetail.tp3      = brstat.insure.addr2   
                       wdetail.no_41    = brstat.insure.addr3   
                       wdetail.no_42    = brstat.insure.addr4   
                       wdetail.no_43    = brstat.insure.telno   
                       wdetail.subclass = brstat.insure.text4   
                       wdetail.garage   = brstat.insure.text1   
                       wdetail.prempa   = brstat.insure.text3
                       wdetail.seat     = INT(brstat.insure.icaddr3) .
        END.
    END. /* A63-0129 */
    /* add by A63-0129 */
    ELSE DO:
        FIND LAST brstat.insure USE-INDEX insure03 WHERE 
              brstat.insure.compno        = fi_campaign AND /*campaign*/
              brstat.insure.insno         = fi_campaign AND
              trim(brstat.insure.text4)   = trim(wdetail.subclass) AND  /*class */                          
              trim(brstat.insure.text1)   = trim(wdetail.garage)   AND
              TRIM(brstat.insure.text2)   = "T"                    AND
              trim(brstat.insure.vatcode) = trim(wdetail.covcod)   NO-ERROR NO-WAIT.   /*cover*/
        IF AVAIL brstat.insure THEN DO:
                ASSIGN wdetail.tp1      = brstat.insure.lname   
                       wdetail.tp2      = brstat.insure.addr1   
                       wdetail.tp3      = brstat.insure.addr2   
                       wdetail.no_41    = brstat.insure.addr3   
                       wdetail.no_42    = brstat.insure.addr4   
                       wdetail.no_43    = brstat.insure.telno   
                       wdetail.subclass = brstat.insure.text4   
                       wdetail.garage   = brstat.insure.text1   
                       wdetail.prempa   = brstat.insure.text3
                       wdetail.seat     = INT(brstat.insure.icaddr3) .
        END.
    END.
    /* end a63-0129 */
    IF wdetail.covcod = "1" THEN ASSIGN wdetail.fi = wdetail.si .
    IF INT(wdetail.seat) = 0 THEN DO:
        IF      INDEX(wdetail.subclass,"110") <> 0 OR index(wdetail.subclass,"120") <> 0   THEN wdetail.seat = 7 .
        ELSE IF index(wdetail.subclass,"320") <> 0 OR index(wdetail.subclass,"140") <> 0 OR 
            index(wdetail.subclass,"140") <> 0 THEN  wdetail.seat = 3.
        ELSE IF index(wdetail.subclass,"210") <> 0 THEN wdetail.seat = 12.
        ELSE IF index(wdetail.subclass,"220") <> 0 THEN wdetail.seat = 15.
        ELSE IF index(wdetail.subclass,"610") <> 0 THEN wdetail.seat = 2.
        ELSE wdetail.seat = 7 .
    END.
    IF index(wdetail.body,"เก๋ง") <> 0  THEN wdetail.body = "SEDAN" .
    ELSE IF index(wdetail.body,"กระบะ") <> 0  THEN wdetail.body = "PICKUP" . 
    ELSE IF INDEX(wdetail.body,"ตู้") <> 0 THEN wdetail.body = "VAN".
    ELSE IF INDEX(wdetail.body,"โดยสารไม่เกิน 15") <> 0 THEN wdetail.body = "VAN".
    ELSE IF INDEX(wdetail.body,"จักรยานยนต์") <> 0 THEN wdetail.body = "MOTORCYCLE" .

    IF wdetail.poltyp = "v70" THEN DO: 
        ASSIGN wdetail.stk = "".
        FIND LAST wtxt WHERE wtxt.policy = wdetail.policy NO-LOCK NO-ERROR.
        IF AVAIL wtxt THEN DO:
             IF trim(wtxt.accdetail1) <> "" THEN DO: 
                 ASSIGN wtxt.acc1        = trim(wtxt.accdetail1)
                        wtxt.accprice1   = "ราคา " + TRIM(wtxt.accprice1).
             END.
             ELSE  ASSIGN wtxt.acc1 = ""
                          wtxt.accprice1 = "" . 
            
              IF trim(wtxt.accdetail2) <> "" THEN DO: 
                 ASSIGN wtxt.acc2        = trim(wtxt.accdetail2)
                        wtxt.accprice2   = "ราคา " + TRIM(wtxt.accprice2).
             END.
             ELSE ASSIGN wtxt.acc2 = ""
                         wtxt.accprice2 = "". 
            
              IF trim(wtxt.accdetail3) <> "" THEN DO: 
                 ASSIGN wtxt.acc3        =  trim(wtxt.accdetail3)
                        wtxt.accprice3   = "ราคา " + TRIM(wtxt.accprice3).
             END.
             ELSE ASSIGN wtxt.acc3 = ""
                         wtxt.accprice3 = "". 
            
              IF trim(wtxt.accdetail4) <> "" THEN DO: 
                 ASSIGN wtxt.acc4        = trim(wtxt.accdetail4)
                        wtxt.accprice4   = "ราคา " + TRIM(wtxt.accprice4).
             END.
             ELSE ASSIGN wtxt.acc4 = ""
                         wtxt.accprice4 = "". 
            
              IF trim(wtxt.accdetail5) <> "" THEN DO: 
                 ASSIGN wtxt.acc5        =  trim(wtxt.accdetail5)
                        wtxt.accprice5   = "ราคา " + TRIM(wtxt.accprice5).
             END.
             ELSE ASSIGN wtxt.acc5 = ""
                        wtxt.accprice5 = "".
        END.
    END.
   
    FIND FIRST brstat.msgcode WHERE 
        brstat.msgcode.compno = "999" AND
        brstat.msgcode.MsgDesc = wdetail.tiname   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN 
        ASSIGN wdetail.tiname = brstat.msgcode.branch.
    
    IF wdetail.vehreg = "" THEN wdetail.vehreg = "/" +  SUBSTRING(wdetail.chasno,LENGTH(wdetail.chasno) - 8) . 
    ELSE IF LENGTH(trim(wdetail.re_country)) <> 2 THEN DO: 
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE
            brstat.insure.compno = "999" AND 
            brstat.insure.FName  = TRIM(wdetail.re_country) NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN DO:
            ASSIGN wdetail.re_country = brstat.Insure.LName
            wdetail.vehreg = trim(substr(wdetail.vehreg,1,8) + " " + trim(wdetail.re_country)) .  
            
        END.
        ELSE DO:
           IF wdetail.re_country <> "" THEN
              wdetail.vehreg = TRIM(wdetail.vehreg) + " " + trim(wdetail.re_country) .
           ELSE wdetail.vehreg = trim(substr(wdetail.vehreg,1,8)).                                    /*a54-0112*/
        END.
    END.
    ELSE ASSIGN wdetail.vehreg = trim(wdetail.vehreg) + " " + trim(wdetail.re_country). /*--A60-0095--*/
    
    IF wdetail.addr1 = "" THEN DO:
       ASSIGN wdetail.addr1 = wdetail.addr2
              wdetail.addr2 = wdetail.addr3
              wdetail.addr3 = wdetail.addr4
              wdetail.addr4 = "" .
    END.
    ELSE IF wdetail.addr2 = "" THEN DO:
        ASSIGN wdetail.addr2 = wdetail.addr3
               wdetail.addr3 = wdetail.addr4
               wdetail.addr4 = "" .
    END.
    ELSE IF wdetail.addr3 = "" THEN DO:
        ASSIGN wdetail.addr3 = wdetail.addr4
               wdetail.addr4 = "" .
    END.
    /*RUN proc_findredbook.*/ /*A65-0115*/
   /*add by : A65-0115*/
    /* comment by : A67-0162...
   IF INDEX(wdetail.model,"_") <> 0 THEN ASSIGN wdetail.model = trim(REPLACE(wdetail.model,"_"," ")).
   IF wdetail.redbook = ""  THEN DO:
       ASSIGN fi_process = "check Redbook " + wdetail.policy + " " + wdetail.chasno + ".....".
       DISP fi_process WITH FRAM fr_main.
       nv_si = 0.
       nv_si = INT(wdetail.si).
       RUN wgw/wgwredbk1(input  wdetail.brand , 
                         input  wdetail.model ,  
                         input  nv_si         ,  
                         INPUT  wdetail.tariff,  
                         input  wdetail.subclass,   
                         input  wdetail.caryear, 
                         input  wdetail.engcc  ,
                         input  wdetail.weight , 
                         INPUT-OUTPUT wdetail.redbook) .
    END.
    /* end A65-0115 */
    ...end A67-0162...*/
    /*Add by Kridtiya i. A63-0472*/
    RUN proc_assign2addr (INPUT  trim(wdetail.addr1)                     
                         ,INPUT  trim(wdetail.addr2)                     
                         ,INPUT  TRIM(wdetail.addr3) + " " + trim(wdetail.addr4)
                         ,INPUT  wdetail.occup                            
                         ,OUTPUT wdetail.codeocc                                            
                         ,OUTPUT wdetail.codeaddr1                                          
                         ,OUTPUT wdetail.codeaddr2                                          
                         ,OUTPUT wdetail.codeaddr3).  
    wdetail.br_insured = "00000".
    IF nv_postcd <> "" THEN DO:
        wdetail.postcd = nv_postcd.
        IF      INDEX(wdetail.addr4,nv_postcd) <> 0 THEN wdetail.addr4 = trim(REPLACE(wdetail.addr4,nv_postcd,"")).
        ELSE IF INDEX(wdetail.addr3,nv_postcd) <> 0 THEN wdetail.addr3 = trim(REPLACE(wdetail.addr3,nv_postcd,"")).
        ELSE IF INDEX(wdetail.addr2,nv_postcd) <> 0 THEN wdetail.addr2 = trim(REPLACE(wdetail.addr2,nv_postcd,"")).
        ELSE IF INDEX(wdetail.addr1,nv_postcd) <> 0 THEN wdetail.addr1 = trim(REPLACE(wdetail.addr1,nv_postcd,"")).
    END.
    RUN proc_matchtypins (INPUT  trim(wdetail.tiname)
                         ,INPUT  TRIM(wdetail.insnam)
                         ,OUTPUT wdetail.insnamtyp
                         ,OUTPUT wdetail.firstName
                         ,OUTPUT wdetail.lastName).
    /*Add by Kridtiya i. A63-0472*/
    /* add by : A67-0162 */
    IF wdetail.redbook = ""  THEN DO:
      ASSIGN fi_process = "check Redbook " + wdetail.policy + " " + wdetail.chasno + ".....".
      DISP fi_process WITH FRAM fr_main.
      nv_si = 0.
      nv_si = INT(wdetail.si).
      IF index(wdetail.subclass,"E") = 0 THEN DO: 
        RUN wgw/wgwredbk1(input  wdetail.brand ,  
                           input  wdetail.model ,  
                           input  nv_si         ,  
                           INPUT  wdetail.tariff,  
                           input  wdetail.subclass,   
                           input  wdetail.caryear, 
                           input  wdetail.engcc  ,
                           input  wdetail.weight , 
                           INPUT-OUTPUT wdetail.redbook) .
      END.
      ELSE DO:
          RUN wgw/wgwredbev(input wdetail.brand ,      
                            input wdetail.model ,  
                            input nv_si ,  
                            INPUT wdetail.tariff,  
                            input wdetail.subclass,   
                            input wdetail.caryear, 
                            input wdetail.watt,
                            input 0, 
                            INPUT-OUTPUT wdetail.maksi,
                            INPUT-OUTPUT wdetail.redbook) .
      END.
    END.
  /* Check Date and Cover Day */
   nv_chkerror = "" .
   RUN wgw/wgwchkdate(input wdetail.comdat,
                      input wdetail.expdat,
                      input wdetail.poltyp,
                      OUTPUT nv_chkerror ) .
   IF nv_chkerror <> ""  THEN 
       ASSIGN wdetail.comment = wdetail.comment + "|" + nv_chkerror 
              wdetail.pass    = "N"
              wdetail.OK_GEN  = "N".
  /* end :A67-0162 */

   
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2-bp c-Win 
PROCEDURE proc_assign2-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR  b_eng   AS DECI FORMAT  ">>>>9.99-".
DEF VAR  n_date  AS CHAR FORMAT  "x(10)". 
DEF VAR  ind1 AS INTE.
DEF VAR  ind2 AS INTE.
DEF VAR  ind3 AS INTE.
DEF VAR  n_addr AS CHAR FORMAT "X(350)" .
DEF VAR  ind4 AS INTE. 
DEF VAR  n_char AS CHAR FORMAT  "x(75)".
FOR EACH wdetail WHERE wdetail.policy  NE " "  .

    FOR EACH wtxt WHERE wtxt.inscode = wdetail.inscode AND 
                        wtxt.poltyp  <> wdetail.poltyp  NO-LOCK.
        ASSIGN wdetail.cr_2 =  wtxt.policy .
    END.
    ASSIGN 
        n_addr         = ""
        ind1           = 0 
        ind2           = 0
        ind3           = 0
        ind4           = 0
        n_char         = ""
        n_date         = STRING(TODAY,"99/99/9999") 
        b_eng          = round((DECI(wdetail.engcc) / 1000),1)   
        b_eng          = b_eng * 1000 
        wdetail.tariff = IF wdetail.poltyp = "v72" THEN "9" ELSE "x"
        wdetail.vehuse = IF wdetail.vehuse = "" THEN "1" ELSE wdetail.vehuse
        fi_process     = "Check data wdetail...".

    IF  LENGTH(wdetail.engcc) = 2 THEN wdetail.engcc  = string(deci(wdetail.engcc) * 100 ) .
    ELSE wdetail.engcc  = STRING(b_eng).
    DISP fi_process WITH FRAM fr_main .

    FIND LAST  stat.insure USE-INDEX insure01  WHERE 
          stat.Insure.compno   = "AYCAL"            AND
          stat.insure.insno    = TRIM(wtxt.branch)    NO-LOCK  NO-ERROR.
      IF AVAIL stat.insure THEN DO: 
          ASSIGN wdetail.branch = trim(stat.insure.branch) .    
      END.

     
     FIND LAST brstat.insure USE-INDEX insure03 WHERE 
              brstat.insure.compno        = fi_campaign AND /*campaign*/
              brstat.insure.insno         = fi_campaign AND
              trim(brstat.insure.text4)   = trim(wdetail.subclass) AND  /*class */                          
              trim(brstat.insure.text1)   = trim(wdetail.garage)   AND                          
              trim(brstat.insure.vatcode) = trim(wdetail.covcod)   NO-ERROR NO-WAIT.   /*cover*/
        IF AVAIL brstat.insure THEN DO:
                ASSIGN wdetail.tp1      = brstat.insure.lname   
                       wdetail.tp2      = brstat.insure.addr1   
                       wdetail.tp3      = brstat.insure.addr2   
                       wdetail.no_41    = brstat.insure.addr3   
                       wdetail.no_42    = brstat.insure.addr4   
                       wdetail.no_43    = brstat.insure.telno   
                       wdetail.subclass = brstat.insure.text4   
                       wdetail.garage   = brstat.insure.text1   
                       wdetail.prempa   = brstat.insure.text3
                       wdetail.seat     = INT(brstat.insure.icaddr3) .
        END.

    IF wdetail.covcod = "1" THEN ASSIGN wdetail.fi = wdetail.si .
    IF INT(wdetail.seat) = 0 THEN DO:
        IF      (substr(wdetail.subclass,1,3) = "110") OR (substr(wdetail.subclass,1,3) = "120" )  THEN wdetail.seat = 7 .
        ELSE IF (substr(wdetail.subclass,1,3) = "320") OR (substr(wdetail.subclass,1,3)  = "140") OR 
            (substr(wdetail.subclass,1,3) = "140") THEN  wdetail.seat = 3.
        ELSE IF (substr(wdetail.subclass,1,3) = "210" ) OR ( substr(wdetail.subclass,1,3)  = "220" ) THEN wdetail.seat = 12.
        ELSE IF (SUBSTR(wdetail.subclass,1,3) = "610" ) THEN wdetail.seat = 2.
        ELSE wdetail.seat = 7 .
    END.
    IF index(wdetail.body,"เก๋ง") <> 0  THEN wdetail.body = "SEDAN" .
    ELSE IF index(wdetail.body,"กระบะ") <> 0  THEN wdetail.body = "PICKUP" . 
    ELSE IF INDEX(wdetail.body,"ตู้") <> 0 THEN wdetail.body = "VAN".
    ELSE IF INDEX(wdetail.body,"จักรยานยนต์") <> 0 THEN wdetail.body = "MOTORCYCLE" .

    IF wdetail.poltyp = "v70" THEN DO: 
        ASSIGN wdetail.stk = "".

        FIND LAST wtxt WHERE wtxt.policy = wdetail.policy NO-LOCK NO-ERROR.
        IF AVAIL wtxt THEN DO:
             IF wtxt.acc1 <> "" THEN DO: 
                 ASSIGN wtxt.acc1        = trim(wtxt.acc1) + " " + trim(wtxt.accdetail1)
                        wtxt.accprice1   = "ราคา " + TRIM(wtxt.accprice1).
             END.
             ELSE  ASSIGN wtxt.acc1 = ""
                          wtxt.accprice1 = "" . 
            
              IF wtxt.acc2 <> "" THEN DO: 
                 ASSIGN wtxt.acc2        = trim(wtxt.acc2) + " " + trim(wtxt.accdetail2)
                        wtxt.accprice2   = "ราคา " + TRIM(wtxt.accprice2).
             END.
             ELSE ASSIGN wtxt.acc2 = ""
                         wtxt.accprice2 = "". 
            
              IF wtxt.acc3 <> "" THEN DO: 
                 ASSIGN wtxt.acc3        = trim(wtxt.acc3) + " " + trim(wtxt.accdetail3)
                        wtxt.accprice3   = "ราคา " + TRIM(wtxt.accprice3).
             END.
             ELSE ASSIGN wtxt.acc3 = ""
                         wtxt.accprice3 = "". 
            
              IF wtxt.acc4 <> "" THEN DO: 
                 ASSIGN wtxt.acc4        = trim(wtxt.acc4) + " " + trim(wtxt.accdetail4)
                        wtxt.accprice4   = "ราคา " + TRIM(wtxt.accprice4).
             END.
             ELSE ASSIGN wtxt.acc4 = ""
                         wtxt.accprice4 = "". 
            
              IF wtxt.acc5 <> "" THEN DO: 
                 ASSIGN wtxt.acc5        = trim(wtxt.acc5) + " " + trim(wtxt.accdetail5)
                        wtxt.accprice5   = "ราคา " + TRIM(wtxt.accprice5).
             END.
             ELSE ASSIGN wtxt.acc5 = ""
                        wtxt.accprice5 = "".
        END.
    END.
   
    FIND FIRST brstat.msgcode WHERE 
        brstat.msgcode.compno = "999" AND
        brstat.msgcode.MsgDesc = wdetail.tiname   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN 
        ASSIGN wdetail.tiname = brstat.msgcode.branch.
    
    IF wdetail.vehreg = "" THEN wdetail.vehreg = "/" +  SUBSTRING(wdetail.chasno,LENGTH(wdetail.chasno) - 8) . 
    ELSE IF LENGTH(trim(wdetail.re_country)) <> 2 THEN DO: 
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE
            brstat.insure.compno = "999" AND 
            brstat.insure.FName  = TRIM(wdetail.re_country) NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN DO:
            ASSIGN wdetail.re_country = brstat.Insure.LName
            wdetail.vehreg = trim(substr(wdetail.vehreg,1,8) + " " + trim(wdetail.re_country)) .  
            
        END.
        ELSE DO:
           IF wdetail.re_country <> "" THEN
              wdetail.vehreg = TRIM(wdetail.vehreg) + " " + trim(wdetail.re_country) .
           ELSE wdetail.vehreg = trim(substr(wdetail.vehreg,1,8)).                                    /*a54-0112*/
        END.
    END.
    ELSE ASSIGN wdetail.vehreg = trim(wdetail.vehreg) + " " + trim(wdetail.re_country). /*--A60-0095--*/
    
    IF wdetail.addr1 = "" THEN DO:
       ASSIGN wdetail.addr1 = wdetail.addr2
              wdetail.addr2 = wdetail.addr3
              wdetail.addr3 = wdetail.addr4
              wdetail.addr4 = "" .
    END.
    ELSE IF wdetail.addr2 = "" THEN DO:
        ASSIGN wdetail.addr2 = wdetail.addr3
               wdetail.addr3 = wdetail.addr4
               wdetail.addr4 = "" .
    END.
    ELSE IF wdetail.addr3 = "" THEN DO:
        ASSIGN wdetail.addr3 = wdetail.addr4
               wdetail.addr4 = "" .
    END.
   
END. */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigndetail c-Win 
PROCEDURE proc_assigndetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A67-0162      
------------------------------------------------------------------------------*/
DEF VAR nv_pol AS CHAR FORMAT "x(15)" INIT "".
ASSIGN nv_pol  = trim(substr(n_poltyp,2,2)) + trim(n_contract) .
FIND LAST wdetail WHERE wdetail.policy = trim(nv_pol)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
          wdetail.poltyp      =  trim(n_poltyp)                             
          wdetail.policy      =  trim(nv_pol)
          wdetail.prepol      =  TRIM(n_prepol)
          wdetail.account_no  =  TRIM(n_contract) /*trim(n_account_no)    */
          wdetail.inscode     =  trim(n_inscode )                        
          wdetail.campcode    =  trim(n_campcode)                        
          wdetail.campname    =  TRIM(n_paydate)  
          wdetail.proname     =  trim(n_proname )
          wdetail.packcode    =  trim(n_packcode) 
          wdetail.tiname      =  trim(n_tiname)                        
          wdetail.insnam      =  trim(n_insnam)
          wdetail.icno        =  trim(n_icno )                        
          wdetail.bdate       =  trim(n_bdate)  
          wdetail.tel         =  trim(n_tel  ) 
          wdetail.addr1       =  trim(n_addrsend1)                       
          wdetail.addr2       =  trim(n_addrsend2)                       
          wdetail.addr3       =  trim(n_addrsend3)                       
          wdetail.addr4       =  trim(n_addrsend4)  
          wdetail.benname     =  trim(n_ben_name)   
          wdetail.brand       =  trim(n_brand)                        
          wdetail.Model       =  trim(n_Model)                        
          wdetail.body        =  trim(n_body )                        
          wdetail.vehreg      =  trim(n_vehreg)                        
          wdetail.re_country  =  trim(n_re_country)                        
          wdetail.chasno      =  trim(n_chasno)                        
          wdetail.eng         =  trim(n_eng)                        
          wdetail.caryear     =  trim(n_caryear)                        
          wdetail.seate       =  0                        
          wdetail.engcc       =  trim(n_engcc)                        
          wdetail.weight      =  ""                       
          wdetail.subclass    =  IF n_poltyp = "V72"  THEN trim(REPLACE(n_class,".","")) ELSE TRIM(n_class)                       
          wdetail.garage      =  trim(n_garage)                        
          wdetail.colorcode   =  trim(n_colorcode)   /*A66-0160*/                  
          wdetail.covcod      =  trim(n_covcod)                        
          wdetail.covtyp      =  trim(n_covtyp)                        
          wdetail.comdat      =  trim(n_comdat)                        
          wdetail.expdat      =  trim(n_expdat)                        
          wdetail.si          =  trim(n_si) 
          wdetail.fi          =  TRIM(n_fi)
          wdetail.prem1       =  trim(n_prem1)                        
          wdetail.gross_prm   =  trim(n_gross_prm)                        
          wdetail.stamp       =  trim(n_stamp)                        
          wdetail.vat         =  trim(n_vat)                        
          wdetail.premtotal   =  trim(n_premtotal)                        
          wdetail.deduct      =  trim(n_deduct)                        
          wdetail.fleetper    =  trim(n_fleetper)                        
          wdetail.ncb         =  DECI(n_ncb)                        
          wdetail.drivper     =  trim(n_drivper)                        
          wdetail.othper      =  IF INT(n_othper) = 0 AND INT(n_cctvper) <> 0 THEN trim(n_cctvper) ELSE trim(n_othper)          
          wdetail.cctvper     =  trim(n_cctvper) 
          wdetail.drivnam     =  trim(n_driver) 
          wdetail.drivnam1    =  trim(n_drivnam1)                        
          wdetail.driveno1    =  trim(n_driveno1)                        
          wdetail.occupdri1   =  trim(n_occupdri1)                        
          wdetail.sexdriv1    =  trim(n_sexdriv1)      
          wdetail.bdatedri1   =  trim(n_bdatedri1)                        
          wdetail.drivnam2    =  trim(n_drivnam2)                        
          wdetail.driveno2    =  trim(n_driveno2)                        
          wdetail.occupdri2   =  trim(n_occupdri2)                        
          wdetail.sexdriv2    =  trim(n_sexdriv2)                        
          wdetail.bdatedri2   =  trim(n_bdatedri2)
          /* A67-0162 */
          wdetail.licenno1    =  trim(n_drivlicen1)   /* เลขใบขับขี่      */ 
          wdetail.licenex1    =  trim(n_drivcardexp1) /* วันที่บัตรหมดอายุ*/ 
          wdetail.licenno2    =  trim(n_drivlicen2)   /* เลขใบขับขี่      */ 
          wdetail.licenex2    =  trim(n_drivcardexp2) /* วันที่บัตรหมดอายุ*/ 
          wdetail.drivename3  =  trim(n_drivnam3)   /* ชื่อผู้ขับขี่1   */                        
          wdetail.driveno3    =  trim(n_driveno3)     /* เลขบัตรผู้ขับขี่1*/                        
          wdetail.occupdriv3  =  trim(n_occupdri3)   /* อาชีพผู้ขับขี่1  */                        
          wdetail.sexdriv3    =  trim(n_sexdriv3)     /* เพศผู้ขับขี่1    */                        
          wdetail.bdatedriv3  =  trim(n_bdatedri3)   /* วันเกิดผู้ขับขี่1*/
          wdetail.licenno3    =  trim(n_drivlicen3)   /* เลขใบขับขี่      */ /* A67-0162  */
          wdetail.licenex3    =  trim(n_drivcardexp3) /* วันที่บัตรหมดอายุ*/ /* A67-0162  */
          wdetail.drivename4  =  trim(n_drivnam4)   /* ชื่อผู้ขับขี่2   */                        
          wdetail.driveno4    =  trim(n_driveno4)     /* เลขบัตรผู้ขับขี่2*/                        
          wdetail.occupdriv4  =  trim(n_occupdri4)   /* อาชีพผู้ขับขี่2  */                        
          wdetail.sexdriv4    =  trim(n_sexdriv4)     /* เพศผู้ขับขี่2    */                        
          wdetail.bdatedriv4  =  trim(n_bdatedri4)   /* วันเกิดผู้ขับขี่2*/
          wdetail.licenno4    =  trim(n_drivlicen4)   /* เลขใบขับขี่      */ /* A67-0162  */
          wdetail.licenex4    =  trim(n_drivcardexp4) /* วันที่บัตรหมดอายุ*/ /* A67-0162  */
          wdetail.drivename5  =  trim(n_drivnam5)   /* ชื่อผู้ขับขี่2   */                        
          wdetail.driveno5    =  trim(n_driveno5)     /* เลขบัตรผู้ขับขี่2*/                        
          wdetail.occupdriv5  =  trim(n_occupdri5)   /* อาชีพผู้ขับขี่2  */                        
          wdetail.sexdriv5    =  trim(n_sexdriv5)     /* เพศผู้ขับขี่2    */                        
          wdetail.bdatedriv5  =  trim(n_bdatedri5)   /* วันเกิดผู้ขับขี่2*/
          wdetail.licenno5    =  trim(n_drivlicen5)   /* เลขใบขับขี่      */ /* A67-0162  */
          wdetail.licenex5    =  trim(n_drivcardexp5) /* วันที่บัตรหมดอายุ*/ 
          wdetail.watt        =  TRIM(n_watt)                
          wdetail.engno2      =  trim(n_evmotor1)            
          wdetail.evmotor2    =  trim(n_evmotor2)            
          wdetail.evmotor3    =  trim(n_evmotor3)    
          wdetail.evmotor4    =  trim(n_evmotor4)    
          wdetail.evmotor5    =  trim(n_evmotor5)    
          wdetail.maksi       =  trim(n_carprice)    
          wdetail.battflag    =  trim(n_battflag)    
          wdetail.battyr      =  IF index(n_class,"E") <> 0 AND INTE(n_battyr) = 0 THEN INTE(n_caryear) ELSE INTE(n_battyr)    
          wdetail.battdate    =  trim(n_battdate)    
          wdetail.battprice   =  trim(n_battprice)   
          wdetail.battno      =  trim(n_battno)   
          wdetail.battsi      =  trim(n_battsi)   
          wdetail.chagreno    =  trim(n_chagreno)   
          wdetail.chagrebrand =  trim(n_chagrebrand) 
          /* end: A67-0162 */
          wdetail.vehuse      =  "1"
          wdetail.stk         =  ""
          wdetail.compul      =  IF n_poltyp = "V72" THEN "Y" ELSE "N"
          wdetail.branch      =  TRIM(n_hobr)
          wdetail.agent       =  TRIM(n_agent)
          wdetail.producer    =  TRIM(n_producer)
          wdetail.dealer      =  TRIM(n_dealer)  /* A65-0115*/
          wdetail.trandat     =  STRING(fi_loaddat)         /*tran  date*/
          wdetail.trantim     =  STRING(TIME,"HH:MM:SS")    /*tran  time*/
          wdetail.n_IMPORT    =  "IM"
          wdetail.n_EXPORT    =  "" .
    CREATE wtxt.
    ASSIGN      
          wtxt.poltyp         =  trim(n_poltyp)                             
          wtxt.policy         =  TRIM(nv_pol)
          wtxt.inscode        =  trim(n_inscode) 
          wtxt.paytitle       =  trim(n_paytitle)                         
          wtxt.payname        =  trim(n_payname)
          wtxt.payic          =  TRIM(n_payic)
          wtxt.addrpay1       =  trim(n_addrpay1) 
          wtxt.addrpay2       =  trim(n_addrpay2) 
          wtxt.addrpay3       =  trim(n_addrpay3) 
          wtxt.addrpay4       =  trim(n_addrpay4)
          wtxt.pmenttyp       =  trim(n_pmenttyp) 
          wtxt.pmentcode2     =  trim(n_pmentcode2) 
          wtxt.accdetail1     =  trim(n_accdetail1)                      
          wtxt.accprice1      =  trim(n_accprice1)  
          wtxt.accdetail2     =  trim(n_accdetail2)                      
          wtxt.accprice2      =  trim(n_accprice2)
          wtxt.accdetail3     =  trim(n_accdetail3)                      
          wtxt.accprice3      =  trim(n_accprice3)
          wtxt.accdetail4     =  trim(n_accdetail4)                      
          wtxt.accprice4      =  trim(n_accprice4) 
          wtxt.accdetail5     =  trim(n_accdetail5)                      
          wtxt.accprice5      =  trim(n_accprice5) 
          wtxt.noti_no        =  IF trim(n_account_no)  <> "" THEN "เลขแจ้งงาน: " + trim(n_account_no) ELSE ""  
          wtxt.inspdate       =  if trim(n_inspdate)    <> "" THEN "วันที่ตรวจสภาพ : " +  trim(n_inspdate) ELSE ""                    
          wtxt.not_date       =  if trim(n_not_date)    <> "" THEN "วันที่แจ้งงาน : " + trim(n_not_date) ELSE ""                 
          wtxt.paydate        =  if trim(n_paydate)     <> "" THEN "วันที่รับชำระเงิน : " + trim(n_paydate) ELSE ""                 
          wtxt.delidetail     =  IF trim(n_delidetail) <> "" THEN "รายละเอียดการจัดส่ง: " + trim(n_delidetail)  ELSE ""                  
          wtxt.gift           =  if trim(n_gift)    <> "" then "Agent name : " + trim(n_gift) ELSE " "             
          wtxt.remark         =  if trim(n_remark)  <> "" then "หมายเหตุ : " +  trim(n_remark) ELSE "หมายเหตุ : - "                
          wtxt.inspno         =  if trim(n_inspno)  <> "" then "เลขที่ตรวจสภาพ : " + trim(n_inspno) ELSE "เลขที่ตรวจสภาพ : NO "                  
          wtxt.remarkinsp     =  if trim(n_remarkinsp) <> "" then "ผลจากกล่องตรวจสภาพ : " + trim(n_remarkinsp) 
                                 ELSE IF trim(n_inspno) = "" THEN "ผลจากกล่องตรวจสภาพ : ไม่ต้องตรวจสภาพ " ELSE "ผลจากกล่องตรวจสภาพ : - "
          wtxt.damang1        =  if trim(n_damang1) <> "" then "ความเสียหาย1: " + trim(n_damang1)  else ""    
          wtxt.damang2        =  if trim(n_damang2) <> "" then "ความเสียหาย2: " + trim(n_damang2)  else ""    
          wtxt.damang3        =  if trim(n_damang3) <> "" then "ความเสียหาย3: " + trim(n_damang3)  else ""    
          wtxt.dataoth        =  if trim(n_dataoth) <> "" then "ข้อมูลอื่น ๆ: " + trim(n_dataoth)  ELSE "" 
          wtxt.policy2        =  TRIM(n_policy).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigndetail-bp c-Win 
PROCEDURE proc_assigndetail-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_pol AS CHAR FORMAT "x(15)" INIT "".
ASSIGN nv_pol  = trim(substr(n_poltyp,2,2)) + trim(n_contract) .
FIND LAST wdetail WHERE wdetail.policy = trim(nv_pol)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
          wdetail.poltyp      =  trim(n_poltyp)                             
          wdetail.policy      =  trim(nv_pol)
          wdetail.prepol      =  TRIM(n_prepol)
          wdetail.account_no  =  TRIM(n_contract) /*trim(n_account_no)    */
          wdetail.inscode     =  trim(n_inscode )                        
          wdetail.campcode    =  trim(n_campcode)                        
          wdetail.campname    =  trim(n_paysts) + TRIM(n_paydate)  
          wdetail.procode     =  trim(n_procode )                        
          wdetail.proname     =  trim(n_proname )                        
          wdetail.packname    =  trim(n_packname)                        
          wdetail.packcode    =  trim(n_packcode)                        
          wdetail.instype     =  trim(n_instype )                        
          wdetail.tiname      =  trim(n_tiname)                        
          wdetail.insnam      =  trim(n_insnam)                        
          wdetail.title_eng   =  trim(n_title_eng)                        
          wdetail.insname_eng =  trim(n_insname_eng)                        
          wdetail.icno        =  trim(n_icno )                        
          wdetail.bdate       =  trim(n_bdate)                        
          wdetail.occup       =  IF trim(n_occup) = "" THEN "อื่นๆ" ELSE TRIM(n_occup)                        
          wdetail.tel         =  trim(n_tel  )                        
          wdetail.mail        =  trim(n_mail )                        
          wdetail.addr1       =  trim(n_addrsend1)                       
          wdetail.addr2       =  trim(n_addrsend2)                       
          wdetail.addr3       =  trim(n_addrsend3)                       
          wdetail.addr4       =  trim(n_addrsend4)  
          wdetail.benname     =  trim(n_ben_name)   
          wdetail.brand       =  trim(n_brand)                        
          wdetail.Model       =  trim(n_Model)                        
          wdetail.body        =  trim(n_body )                        
          wdetail.vehreg      =  trim(n_vehreg)                        
          wdetail.re_country  =  trim(n_re_country)                        
          wdetail.chasno      =  trim(n_chasno)                        
          wdetail.eng         =  trim(n_eng)                        
          wdetail.caryear     =  trim(n_caryear)                        
          wdetail.seate       =  INT(n_seate)                        
          wdetail.engcc       =  trim(n_engcc)                        
          wdetail.weight      =  trim(n_power)                        
          wdetail.subclass    =  IF n_poltyp = "V72"  THEN trim(REPLACE(n_class,".","")) ELSE TRIM(n_class)                       
          wdetail.garage      =  trim(n_garage)                        
          wdetail.colorcode   =  trim(n_colorcode)                        
          wdetail.covcod      =  trim(n_covcod)                        
          wdetail.covtyp      =  trim(n_covtyp)                        
          wdetail.comdat      =  trim(n_comdat)                        
          wdetail.expdat      =  trim(n_expdat)                        
          wdetail.si          =  trim(n_si) 
          wdetail.fi          =  IF TRIM(n_covcod) = "1" THEN TRIM(n_si) ELSE "" 
          wdetail.prem1       =  trim(n_prem1)                        
          wdetail.gross_prm   =  trim(n_gross_prm)                        
          wdetail.stamp       =  trim(n_stamp)                        
          wdetail.vat         =  trim(n_vat)                        
          wdetail.premtotal   =  trim(n_premtotal)                        
          wdetail.deduct      =  trim(n_deduct)                        
          wdetail.fleetper    =  trim(n_fleetper)                        
          wdetail.ncb         =  DECI(n_ncb)                        
          wdetail.drivper     =  trim(n_drivper)                        
          wdetail.othper      =  IF INT(n_othper) = 0 AND INT(n_cctvper) <> 0 THEN trim(n_cctvper) ELSE trim(n_othper)          
          wdetail.cctvper     =  trim(n_cctvper)                        
          wdetail.Surcharper  =  trim(n_Surcharper)                        
          wdetail.drivnam     =  trim(n_driver) 
          wdetail.drivnam1    =  trim(n_drivnam1)                        
          wdetail.driveno1    =  trim(n_driveno1)                        
          wdetail.occupdri1   =  trim(n_occupdri1)                        
          wdetail.sexdriv1    =  trim(n_sexdriv1)      
          wdetail.bdatedri1   =  trim(n_bdatedri1)                        
          wdetail.drivnam2    =  trim(n_drivnam2)                        
          wdetail.driveno2    =  trim(n_driveno2)                        
          wdetail.occupdri2   =  trim(n_occupdri2)                        
          wdetail.sexdriv2    =  trim(n_sexdriv2)                        
          wdetail.bdatedri2   =  trim(n_bdatedri2)
          wdetail.vehuse      =  "1"
          wdetail.stk         =  ""
          wdetail.compul      =  IF n_poltyp = "V72" THEN "Y" ELSE "N"
          wdetail.branch      =  TRIM(n_hobr)
          wdetail.agent       =  TRIM(n_agent)
          wdetail.producer    =  TRIM(n_producer)
          wdetail.trandat     =  STRING(fi_loaddat)         /*tran  date*/
          wdetail.trantim     =  STRING(TIME,"HH:MM:SS")    /*tran  time*/
          wdetail.n_IMPORT    =  "IM"
          wdetail.n_EXPORT    =  "" .
    CREATE wtxt.
    ASSIGN      
          wtxt.poltyp         =  trim(n_poltyp)                             
          wtxt.policy         =  TRIM(nv_pol)
          wtxt.inscode        =  trim(n_inscode) 
          wtxt.addrsend1      =  trim(n_addrpol1)                         
          wtxt.addrsend2      =  trim(n_addrpol2)                         
          wtxt.addrsend3      =  trim(n_addrpol3)                         
          wtxt.addrsend4      =  trim(n_addrpol4)                         
          wtxt.paytype        =  trim(n_paytype)                         
          wtxt.paytitle       =  trim(n_paytitle)                         
          wtxt.payname        =  trim(n_payname)
          wtxt.payic          =  TRIM(n_payic)
          wtxt.addrpay1       =  trim(n_addrpay1) 
          wtxt.addrpay2       =  trim(n_addrpay2) 
          wtxt.addrpay3       =  trim(n_addrpay3) 
          wtxt.addrpay4       =  trim(n_addrpay4)
          wtxt.branch         =  trim(n_branch)             
          wtxt.pmentcode      =  trim(n_pmentcode)                         
          wtxt.pmenttyp       =  trim(n_pmenttyp)                         
          wtxt.pmentcode1     =  trim(n_pmentcode1)                         
          wtxt.pmentcode2     =  trim(n_pmentcode2)                         
          wtxt.pmentbank      =  trim(n_pmentbank)                         
          wtxt.pmentdate      =  trim(n_pmentdate)                         
          wtxt.pmentsts       =  trim(n_pmentsts)
          wtxt.Surchardetail  =  trim(n_Surchardetail) 
          wtxt.acc1           =  trim(n_acc1)                      
          wtxt.accdetail1     =  trim(n_accdetail1)                      
          wtxt.accprice1      =  trim(n_accprice1)                      
          wtxt.acc2           =  trim(n_acc2)    
          wtxt.accdetail2     =  trim(n_accdetail2)                      
          wtxt.accprice2      =  trim(n_accprice2)                      
          wtxt.acc3           =  trim(n_acc3)    
          wtxt.accdetail3     =  trim(n_accdetail3)                      
          wtxt.accprice3      =  trim(n_accprice3)                      
          wtxt.acc4           =  trim(n_acc4)    
          wtxt.accdetail4     =  trim(n_accdetail4)                      
          wtxt.accprice4      =  trim(n_accprice4)                      
          wtxt.acc5           =  trim(n_acc5)    
          wtxt.accdetail5     =  trim(n_accdetail5)                      
          wtxt.accprice5      =  trim(n_accprice5) 
          wtxt.noti_no        =  IF trim(n_account_no)  <> "" THEN "เลขแจ้งงาน: " + trim(n_account_no) ELSE ""  
          wtxt.inspdate       =  if trim(n_inspdate)    <> "" THEN "วันที่ตรวจสภาพ : " +  trim(n_inspdate) ELSE ""                    
          wtxt.inspdate_app   =  if trim(n_inspdate_app) <> "" THEN "วันที่อนุมัติผลการตรวจ : " + trim(n_inspdate_app) ELSE ""                    
          wtxt.inspsts        =  if trim(n_inspsts)     <> "" THEN "ผลการตรวจสภาพ : " + trim(n_inspsts) ELSE "ผลการตรวจสภาพ : - "                   
          wtxt.inspdetail     =  if trim(n_inspdetail)  <> "" THEN "รายละเอียด : " + trim(n_inspdetail) ELSE ""                      
          wtxt.not_date       =  if trim(n_not_date)    <> "" THEN "วันที่แจ้งงาน : " + trim(n_not_date) ELSE ""                 
          wtxt.paydate        =  if trim(n_paydate)     <> "" THEN "วันที่รับชำระเงิน : " + trim(n_paydate) ELSE ""                 
          wtxt.paysts         =  if trim(n_paysts)      <> "" THEN "สถานะการจ่าย : " + trim(n_paysts)  ELSE ""                
          wtxt.licenBroker    =  if trim(n_licenBroker) <> "" THEN "เลขที่ใบอนุญาต : " + trim(n_licenBroker) ELSE ""               
          wtxt.brokname       =  if trim(n_brokname)    <> "" THEN "ชื่อนายหน้า : " + trim(n_brokname) else ""                 
          wtxt.brokcode       =  if trim(n_brokcode)    <> "" THEN "รหัสนายหน้า : " + trim(n_brokcode) else ""                 
          wtxt.lang           =  trim(n_lang)                      
          wtxt.deli           =  IF trim(n_deli) <> "" THEN "การจัดส่งกรมธรรม์ : " + trim(n_deli) ELSE ""                     
          wtxt.delidetail     =  IF trim(n_delidetail) <> "" THEN "รายละเอียดการจัดส่ง: " + trim(n_delidetail)  ELSE ""                  
          wtxt.gift           =  if trim(n_gift)    <> "" then "ของแถม : " + trim(n_gift) ELSE "ของแถม : - "             
          wtxt.remark         =  if trim(n_remark)  <> "" then "หมายเหตุ : " +  trim(n_remark) ELSE "หมายเหตุ : - "                
          wtxt.inspno         =  if trim(n_inspno)  <> "" then "เลขที่ตรวจสภาพ : " + trim(n_inspno) ELSE "เลขที่ตรวจสภาพ : NO "                  
          wtxt.remarkinsp     =  if trim(n_remarkinsp) <> "" then "ผลจากกล่องตรวจสภาพ : " + trim(n_remarkinsp) 
                                 ELSE IF trim(n_inspno) = "" THEN "ผลจากกล่องตรวจสภาพ : ไม่ต้องตรวจสภาพ " ELSE "ผลจากกล่องตรวจสภาพ : - "
          wtxt.damang1        =  if trim(n_damang1) <> "" then "ความเสียหาย1: " + trim(n_damang1)  else ""    
          wtxt.damang2        =  if trim(n_damang2) <> "" then "ความเสียหาย2: " + trim(n_damang2)  else ""    
          wtxt.damang3        =  if trim(n_damang3) <> "" then "ความเสียหาย3: " + trim(n_damang3)  else ""    
          wtxt.dataoth        =  if trim(n_dataoth) <> "" then "ข้อมูลอื่น ๆ: " + trim(n_dataoth)  ELSE "" 
          wtxt.policy2        =  TRIM(n_policy).
END.
*/
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
/*IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.*/ /*Add kridtiya i. A54-0062 */
DEF VAR n_prem  AS DECI INIT 0.
DEF VAR n_si    AS DECI INIT 0.
DEF VAR n_fi    AS DECI INIT 0.
DEF VAR n_oddbr AS CHAR INIT "".
def var nr_hp    as deci  init 0 .
def var nr_maksi as deci  init 0 .
DEF VAR number_sic AS INTE INIT 0.
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
    ASSIGN  n_prem  = 0     n_si    = 0     n_fi    = 0.
    RUN wgw\wgwexpay  (INPUT-OUTPUT wdetail.prepol,   /*n_prepol  */ 
                       INPUT-OUTPUT n_oddbr,    /* wdetail.branch,   /*n_branch  */ *//*A63-00472*/
                       INPUT-OUTPUT wdetail.prempa,   /*n_prempa  */  
                       INPUT-OUTPUT wdetail.subclass, /*n_subclass*/  
                       INPUT-OUTPUT wdetail.redbook,  /*n_redbook */  
                       INPUT-OUTPUT wdetail.brand,    /*n_brand   */  
                       INPUT-OUTPUT wdetail.model,    /*n_model   */  
                       INPUT-OUTPUT wdetail.caryear,  /*n_caryear */
                       INPUT-OUTPUT wdetail.cargrp,   /*n_cargrp  */  
                       INPUT-OUTPUT wdetail.engcc,    
                       INPUT-OUTPUT nv_tons,          
                       INPUT-OUTPUT wdetail.body,     
                       INPUT-OUTPUT wdetail.vehuse,   /*n_vehuse  */  
                       INPUT-OUTPUT wdetail.covcod,   /*n_covcod  */  
                       INPUT-OUTPUT wdetail.garage,   /*n_garage  */    
                       INPUT-OUTPUT wdetail.tp1,      /*n_tp1     */  
                       INPUT-OUTPUT wdetail.tp2,      /*n_tp2     */  
                       INPUT-OUTPUT wdetail.tp3,      /*n_tp3     */  
                       INPUT-OUTPUT nv_basere,        /*nv_basere */  
                       INPUT-OUTPUT wdetail.seat,     /* DECI     n_seat     */  
                       INPUT-OUTPUT nv_seat41,        /* INTE     */    
                       INPUT-OUTPUT n_41,             /* INTE     n_41       */  
                       INPUT-OUTPUT n_42,             /* DECI     n_42       */  
                       INPUT-OUTPUT n_43,             /* DECI     n_43       */  
                       INPUT-OUTPUT dod1,             /* DECI     n_dod      */  
                       INPUT-OUTPUT dod2,             /* DECI     n_dod2     */
                       INPUT-OUTPUT dod0,             /* DECI     n_pd       */  
                       INPUT-OUTPUT wdetail.fleetper, /*n DECI    _feet     */  
                       INPUT-OUTPUT nv_dss_per,       /* DECI     nv_dss_per */  
                       INPUT-OUTPUT WDETAIL.NCB,      /* DECI     n_ncb      */  
                       INPUT-OUTPUT nv_cl_per,        /* DECI     n_lcd      */ 
                       INPUT-OUTPUT n_prem ,
                       INPUT-OUTPUT n_si,
                       INPUT-OUTPUT n_fi,
                       INPUT-OUTPUT n_firstdat,       
                       INPUT-OUTPUT nv_driver,
                       INPUT-OUTPUT nr_premtxt,       /* f6 access renew */
                       input-output nr_hp     ,       /*A67-0162*/
                       input-output nr_maksi  ,       /*A67-0162*/
                       input-output wdetail.engno2,   /*A67-0162*/
                       INPUT-OUTPUT wdetail.battyr ). /*A67-0162*/   

    IF deci(wdetail.gross_prm) <> DECI(n_prem) THEN DO: 
        ASSIGN WDETAIL.WARNING = IF WDETAIL.WARNING <> "" THEN WDETAIL.WARNING + " | " + "เบี้ยในไฟล์และใบเตือนไม่ตรงกัน" ELSE "เบี้ยในไฟล์และใบเตือนไม่ตรงกัน".
    END.
    IF deci(wdetail.si) <> DECI(n_si) THEN DO:
        ASSIGN WDETAIL.WARNING = IF WDETAIL.WARNING <> "" THEN WDETAIL.WARNING + " | " + "ทุนประกันภัยในไฟล์และใบเตือนไม่ตรงกัน" ELSE "ทุนประกันภัยในไฟล์และใบเตือนไม่ตรงกัน".
    END.
    ASSIGN wdetail.weight    = string(nv_tons)
           wdetail.seat      = nv_seat41 
           wdetail.gross_prm = STRING(n_prem)
           wdetail.si        = string(n_si)
           wdetail.fi        = string(n_fi) 
           wdetail.watt   =  if deci(wdetail.watt)  = 0 AND nr_hp <> 0 THEN STRING(nr_hp) ELSE wdetail.watt          /*A67-0162 */
           wdetail.maksi  =  if DECI(wdetail.maksi) = 0 AND nr_maksi <> 0 THEN STRING(nr_maksi) ELSE wdetail.maksi. /*A67-0162 */

    /*IF wdetail.branch = "37" THEN ASSIGN wdetail.branch = "J" . *//* comment: A65-0035 */
   IF DATE(wdetail.comdat) >= 04/01/2020 AND wdetail.prempa <> "U"  THEN ASSIGN wdetail.prempa = "T". /*a63-0129 */

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
    IF wdetail.model  = "commuter" THEN nv_baseprm = 13000.
    IF (wdetail.prepol = "") OR (nv_basere = 0 )   THEN  RUN wgs\wgsfbas.
    ELSE  nv_baseprm = nv_basere .
    ASSIGN chk = NO
        NO_basemsg = " " .
    /* comment by : A67-0162 ..
    If wdetail.drivnam1  = ""  Then 
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
        /*IF wdetail.prepol = "" THEN RUN proc_usdcod.
        ELSE RUN proc_usdcodrenew .*/
        ASSIGN  nv_drivvar = ""
            nv_drivvar = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
        /*RUN proc_usdcod. */
    END.
    ..end A67-0162...*/
    /*-------nv_baseprm----------*/
    IF NO_basemsg <> " " THEN 
        wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ".  

    ASSIGN  nv_basevar  = ""
        nv_prem1   = nv_baseprm
        nv_basecod = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    IF wdetail.prepol <> "" THEN  
        ASSIGN nv_41 = n_41  /*ต่ออายุ*/          
        nv_42 = n_42                       
        nv_43 = n_43                      
        nv_seat41 = inte(wdetail.seat).  
    ELSE 
        ASSIGN 
        nv_41 = deci(wdetail.no_41)
        nv_42 = deci(wdetail.no_42)
        nv_43 = deci(wdetail.no_43) 
        nv_seat41 = inte(wdetail.seat) . 
    
    IF wdetail.model = "commuter" THEN 
        ASSIGN wdetail.seat = 16
              nv_seats  =  16
              nv_seat41 =  16 .
    /* comment by:A64-0138..
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                    nv_class,
                    nv_key_b,
                    nv_comdat). 
    ...end:A64-0138..*/
    Assign  nv_411var = ""      nv_412var2  = "" 
        nv_412var   = ""
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
    ASSIGN nv_42var = ""
        nv_42cod   = "42".
        nv_42var1  = "     Medical Expense = ".
        nv_42var2  = STRING(nv_42).
        SUBSTRING(nv_42var,1,30)   = nv_42var1.
        SUBSTRING(nv_42var,31,30)  = nv_42var2.
    nv_43var    = " ".     /*---------fi_43--------*/
    ASSIGN nv_43var = ""
        nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    /* comment by:A64-0138..
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/ 
   ... end :A64-0138.. */
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
     Assign nv_sivar = "" 
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
     ASSIGN nv_bipvar = ""
         nv_bipcod      = "BI1"
         nv_bipvar1     = "     BI per Person = "
         nv_bipvar2     =  wdetail.tp1    /*STRING(uwm130.uom1_v)*/
         SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
         SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
     /*-------------nv_biacod--------------------*/
     Assign nv_biavar = ""
         nv_biacod      = "BI2"
         nv_biavar1     = "     BI per Accident = "
         nv_biavar2     =  wdetail.tp2     /* STRING(uwm130.uom2_v)*/
         SUBSTRING(nv_biavar,1,30)  = nv_biavar1
         SUBSTRING(nv_biavar,31,30) = nv_biavar2.
     /*-------------nv_pdacod--------------------*/
     ASSIGN nv_pdavar = ""
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
     IF INT(wdetail.deduct) <> 0  THEN DO:
        ASSIGN dod0 = 0
               dod0 = INT(wdetail.deduct) .

        IF TRIM(wdetail.subclass) <> "610" THEN DO: /*a63-0129 */
            IF dod0 > 3000 THEN DO:
               dod1 = 3000.
               dod2 = dod0 - dod1.
            END.
        /* add by A63-0129 */
        END.
        ELSE DO:
             IF dod0 > 1000 THEN DO:
               dod1 = 1000.
               dod2 = dod0 - dod1.
             END.
        END.
        /* end A63-0129 */
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
        ASSIGN nv_dedod1var2  = ""
            nv_ded1prm        = nv_prem
            nv_dedod1_prm     = nv_prem
            nv_dedod1var      = ""
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
           
     END.
      /***** pd *******/
       Assign
          nv_dedpdvar  = " "
          nv_cons  = "PD"
          nv_ded   = dpd0.
       /* comment : A64-0138...
        Run  Wgs\Wgsmx025(INPUT  dod0, /*a490166 note modi*/
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).
           nv_ded2prm    = nv_prem.
        ...end A64-0138..*/
       IF dpd0 <> 0 THEN 
            ASSIGN nv_dedpdvar = ""
              nv_dedpd_cod   = "DPD"
              nv_dedpdvar1   = "     Deduct PD = "
              nv_dedpdvar2   =  STRING(dod0)
              SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
              SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
            /*  nv_dedpd_prm  = nv_prem.*/
 
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
      ... end : A64-0138...*/
      IF nv_flet_per <> 0 THEN
      ASSIGN
          nv_fletvar                  = " "
          nv_fletvar1                 = "     Fleet % = "
          nv_fletvar2                 =  STRING(nv_flet_per)
          SUBSTRING(nv_fletvar,1,30)  = nv_fletvar1
          SUBSTRING(nv_fletvar,31,30) = nv_fletvar2.
      IF nv_flet_per   = 0  THEN nv_fletvar  = " ".

      /*---------------- NCB -------------------*/
     /* IF (wdetail.prepol = "") AND (wdetail.covcod = "3") THEN
            ASSIGN WDETAIL.NCB = 20.  comment: A64-0138 ..*/
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
      /* comment by : A64-0138...
      RUN WGS\WGSORPRM.P (INPUT nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).
     ..end : A64-0138...*/
     nv_ncbvar   = " ".
     IF  nv_ncb <> 0  THEN
         ASSIGN 
         nv_ncbvar1   = "     NCB % = "
         nv_ncbvar2   =  STRING(nv_ncbper)
         SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
         SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
     /*-------------- load claim ---------------------*/
    /* /*nv_cl_per  = deci(wdetail.loadclm).*/
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
              SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.*/

    /*------------------ dsspc ---------------*/
     nv_dss_per  = 0.
     nv_dss_per  = deci(wdetail.othper).
     IF  nv_dss_per   <> 0  THEN
         ASSIGN nv_dsspcvar = ""
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
     ...end : A64-0138... */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base22 c-Win 
PROCEDURE proc_base22 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "v70" THEN DO:
    IF wdetail.prepol <> "" THEN  aa = nv_basere .
    ELSE IF wdetail.subclass = "110" THEN aa = 7600.
    ELSE IF wdetail.subclass = "320" THEN aa = 13000.
    ELSE IF wdetail.subclass = "210" THEN aa = 12000.
    ELSE DO: 
        RUN wgs\wgsfbas.
        ASSIGN aa = nv_baseprm.
    END.
    IF wdetail.covcod = "3" THEN  aa = 2468.
    IF wdetail.model = "commuter"  THEN aa = 13000. 
    ASSIGN chk = NO
        NO_basemsg = " "
        nv_baseprm = aa.
    /*-----nv_drivcod---------------------*/
    nv_drivvar1 = wdetail.drivnam1.
    nv_drivvar2 = wdetail.drivnam2.
    IF INT(wdetail.drivnam) <> 0  THEN  wdetail.drivnam  = "y".
    ELSE wdetail.drivnam  = "N".
    IF wdetail.drivnam2 <> ""   THEN  nv_drivno = 2. 
    ELSE IF wdetail.drivnam1 <> "" AND wdetail.drivnam2 = "" THEN  nv_drivno = 1.  
    ELSE IF wdetail.drivnam1  = "" AND wdetail.drivnam2 = "" THEN  nv_drivno = 0.  
   
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
        ASSIGN  nv_drivvar     = nv_drivcod
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
    IF wdetail.prepol <> "" THEN  ASSIGN  nv_41 = n_41  /*ต่ออายุ*/
                                          nv_42 = n_42
                                          nv_43 = n_43
                                          nv_seat41 =  inte(wdetail.seat) .
    ELSE IF wdetail.prempa = "Z" THEN
        ASSIGN 
        nv_41 = deci(wdetail.no_41) 
        nv_42 = deci(wdetail.no_42)
        nv_43 = deci(wdetail.no_43)
        nv_seat41 =   INT(wdetail.seat) .    /*integer(wdetail.seat41)*/ 
     
    IF wdetail.model = "commuter" THEN 
        ASSIGN wdetail.seat = 16
        nv_seats  =  16
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
         nv_pdavar2     = string(deci(WDETAIL.deduct))         /*A52-0172*/
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
     Assign  nv_dedod2var   = " "
         nv_cons  = "AD"
         nv_ded   = dod2.
     Run  Wgs\Wgsmx025(INPUT  nv_ded,  
                              nv_tariff,
                              nv_class,
                              nv_key_b,
                              nv_comdat,
                              nv_cons,
                       OUTPUT nv_prem).      
     ASSIGN  
         nv_aded1prm     = nv_prem
         nv_dedod2_cod   = "DOD2"
         nv_dedod2var1   = "     Add Ded.OD = "
         nv_dedod2var2   =  STRING(dod2)
         SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
         SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
         nv_dedod2_prm   = nv_prem.
     /***** pd *******/
     ASSIGN  nv_dedpdvar  = " "
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
     ASSIGN
         nv_dedpd_cod   = "DPD"
         nv_dedpdvar1   = "     Deduct PD = "
         nv_dedpdvar2   =  STRING(nv_ded)
         SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
         SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
         nv_dedpd_prm  = nv_prem.
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
     IF wdetail.covcod = "3" THEN WDETAIL.NCB = 30.
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
     ASSIGN 
     nv_dsspcvar   = " "
     nv_dss_per   = 0
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
     IF nv_gapprm > n_prem  THEN  nv_dss_per = TRUNCATE(((nv_gapprm - n_prem ) * 100 ) / nv_gapprm ,3 ) . 
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
 
END.*/
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
         /*nv_seat41  = 0 */         
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
         nv_yrmanu  = int(wdetail.caryear)                         
         nv_totsi   = sic_bran.uwm130.uom6_v       
         nv_totfi   = sic_bran.uwm130.uom7_v
         nv_vehgrp  = wdetail.cargrp                                                     
         /*nv_access  = IF sic_bran.uwm301.prmtxt <> "" THEN "A" ELSE ""   */                                          
       /*nv_supe    = NO*/                                              
         nv_tpbi1si = deci(wdetail.tp1)            
         nv_tpbi2si = deci(wdetail.tp2)            
         nv_tppdsi  = deci(wdetail.tp3)            
         nv_411si   = nv_41       
         nv_412si   = nv_41       
         nv_413si   = 0                       
         nv_414si   = 0                       
         nv_42si    = nv_42                
         nv_43si    = nv_43  
         nv_41prmt  = 0     /*A65-0115*/
         nv_42prmt  = 0     /*A65-0115*/
         nv_43prmt  = 0     /*A65-0115*/
         nv_seat41  = nv_seat41   
         nv_dedod   = dod1       
         nv_addod   = dod2                               
         nv_dedpd   = dod0                                    
         nv_ncbp    = deci(wdetail.ncb)                                     
         nv_fletp   = deci(wdetail.fleetper)                                  
         nv_dspcp   = deci(wdetail.othper)                                     
         nv_dstfp   = 0                                                     
         nv_clmp    = 0                                                     
         nv_netprem = DECI(wdetail.gross_prm) /* เบี้ยสุทธิ */                                                
         nv_gapprm  = 0     
         nv_pdprem  = 0         /*a65-0115*/
         nv_flagprm = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
         nv_effdat  = sic_bran.uwm100.comdat                             
         nv_ratatt  = 0                    
         nv_siatt   = 0                                                   
         nv_netatt  = 0 
         nv_fltatt  = 0 
         nv_ncbatt  = 0 
         nv_dscatt  = 0 
         nv_status  = "" 
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

    IF nv_cstflg = "W" THEN ASSIGN sic_bran.uwm301.watt = nv_engine .

    IF wdetail.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            /*RUN wgw/wgwredbook(input  wdetail.brand , */ /*A67-0162*/ 
            RUN wgw/wgwredbk1(input  wdetail.brand ,  /*A67-0162*/ 
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail.tariff,  
                               input  wdetail.subclass,   
                               input  wdetail.caryear, 
                               input  nv_engine  ,
                               input  0 , 
                               INPUT-OUTPUT wdetail.redbook) .
        END.
        ELSE DO:
            /*RUN wgw/wgwredbook(input  wdetail.brand , */ /*A67-0162*/ 
            RUN wgw/wgwredbk1(input  wdetail.brand ,  /*A67-0162*/ 
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail.tariff,  
                               input  wdetail.subclass,   
                               input  wdetail.caryear, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT wdetail.redbook) .
        END.
        IF wdetail.redbook <> ""  THEN DO:
            FIND FIRST stat.maktab_fil USE-INDEX maktab01   WHERE
                stat.maktab_fil.sclass  =  wdetail.subclass   AND
                stat.maktab_fil.modcod  =  wdetail.redbook    No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN  
                sic_bran.uwm301.modcod = stat.maktab_fil.modcod  
                wdetail.cargrp         = stat.maktab_fil.prmpac 
                sic_bran.uwm301.vehgrp = stat.maktab_fil.prmpac 
                nv_vehgrp              = stat.maktab_fil.prmpac .

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
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.    */ 

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
                       INPUT-OUTPUT nv_pdprem,   /* nv_pdprem   */
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

    /*IF nv_gapprm <> DECI(wdetail.gross_prm) THEN DO:*/
    IF nv_status = "no" THEN DO:
        /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.gross_prm + 
        nv_message  VIEW-AS ALERT-BOX. 
        ASSIGN
                wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
                wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.gross_prm.
                 wdetail.pass     = "Y"     
                wdetail.OK_GEN  = "N".
        */     /*comment by Kridtiya i. A65-0035*/ 
        /*  by Kridtiya i. A65-0035*/
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN
            wdetail.comment = wdetail.comment + "|" + nv_message
            wdetail.WARNING = wdetail.WARNING + "|" + nv_message . 
        /*  by Kridtiya i. A65-0035*/
    END.
    /* by Kridtiya i. A65-0035  */
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate(input DATE(wdetail.comdat),
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt_ev c-Win 
PROCEDURE proc_calpremt_ev :
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
IF wdetail.poltyp = "V70" THEN DO:
        ASSIGN fi_process = "Create data to base..." + wdetail.policy .
        DISP fi_process WITH FRAM fr_main.
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
            nv_tpbi1si = deci(wdetail.tp1)              
            nv_tpbi2si = deci(wdetail.tp2)              
            nv_tppdsi  = deci(wdetail.tp3)              
            nv_411si   = nv_41      
            nv_412si   = nv_41      
            nv_413si   = 0                          
            nv_414si   = 0                        
            nv_42si    = nv_42              
            nv_43si    = nv_43  
            nv_41prmt  = 0      /* ระบุเบี้ย รย.*/  
            nv_412prmt = 0       /* ระบุเบี้ย รย.*/ 
            nv_413prmt = 0       /* ระบุเบี้ย รย.*/ 
            nv_414prmt = 0       /* ระบุเบี้ย รย.*/ 
            nv_42prmt  = 0      /* ระบุเบี้ย รย.*/  
            nv_43prmt  = 0      /* ระบุเบี้ย รย.*/  
            nv_seat41  = wdetail.seat   
            nv_dedod   = DOD1       
            nv_addod   = DOD2                                
            nv_dedpd   = dod0                                      
            nv_ncbp    = if deci(wdetail.ncb) > 50 THEN 0 ELSE DECI(wdetail.ncb)                                    
            nv_fletp   = if deci(wdetail.fleetper) > 10 THEN 0 ELSE deci(wdetail.fleetper)                                
            nv_dspcp   = if deci(wdetail.othper) > 35 THEN 0 ELSE  deci(wdetail.othper)                                    
            nv_dstfp   = 0                                                     
            nv_clmp    = nv_cl_per
            nv_mainprm  = 0  
            nv_dodamt   = 0  /*A67-0029*/ /* ระบุเบี้ย DOD */   
            nv_dadamt   = 0  /*A67-0029*/ /* ระบุเบี้ย DOD1 */  
            nv_dpdamt   = 0  /*A67-0029*/ /* ระบุเบี้ย DPD */   
            nv_ncbamt   = if deci(wdetail.ncb) > 50 THEN DECI(wdetail.ncb) ELSE 0           /* ระบุเบี้ย  NCB PREMIUM */           
            nv_fletamt  = if deci(wdetail.fleetper) > 10 THEN deci(wdetail.fleetper) ELSE 0  /* ระบุเบี้ย  FLEET PREMIUM */          
            nv_dspcamt  = if deci(wdetail.othper) > 35 THEN  deci(wdetail.othper) ELSE 0    /* ระบุเบี้ย  DSPC PREMIUM */           
            nv_dstfamt  = 0  /* ระบุเบี้ย  DSTF PREMIUM */           
            nv_clmamt   = 0  /* ระบุเบี้ย  LOAD CLAIM PREMIUM */    
            /* end : A65-0079*/
            nv_baseprm  = 0
            nv_baseprm3 = 0
            nv_netprem  = DECI(wdetail.gross_prm) 
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
            nv_level      = INTE(wdetail.drilevel)   
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
            nv_battyr     = 0 /*INTE(wdetail.battyr)                                  */
            nv_battper    = 0 /*DECI(wdetail.battper)                                 */
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
                           nv_engine = IF SUBSTR(nv_class,5,1) = "E" OR SUBSTR(nv_class,2,1) = "E" THEN DECI(wdetail.watt) ELSE INT(wdetail.engcc).
                END.
                ELSE IF clastab_fil.unit = "S" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = INT(wdetail.seat).
                END.
                ELSE IF clastab_fil.unit = "T" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = DECI(sic_bran.uwm301.Tons).
                END.
                ELSE IF clastab_fil.unit = "H" THEN DO:
                    ASSIGN nv_cstflg = clastab_fil.unit     nv_engine = DECI(wdetail.engcc). 
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
                sic_bran.uwm301.watt   =  stat.maktab_fil.watt
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
            nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat) + 1.
        END.
    RUN proc_disp .
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
                     INPUT "wgwtfgen"  ,
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_campaign c-Win 
PROCEDURE proc_campaign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wcampaign :
    DELETE wcampaign.
END.
FOR EACH brstat.insure USE-INDEX insure03 WHERE brstat.insure.compno = TRIM(fi_campaign) AND 
                                                brstat.insure.insno  = TRIM(fi_campaign) NO-LOCK.
    FIND LAST wcampaign WHERE wcampaign.pack   = trim(brstat.insure.text3) AND  /*pack */
                              wcampaign.nclass = trim(brstat.insure.text4) AND  /*class */
                              wcampaign.garage = trim(brstat.insure.text1) AND  /*garage*/
                              wcampaign.cover  = trim(brstat.insure.vatcode) NO-ERROR NO-WAIT.   /*cover*/
    IF NOT AVAIL wcampaign  THEN DO:
        CREATE wcampaign.
        ASSIGN wcampaign.tariff = brstat.insure.branch  
               wcampaign.bi     = brstat.insure.lname   
               wcampaign.pd1    = brstat.insure.addr1   
               wcampaign.pd2    = brstat.insure.addr2   
               wcampaign.n41    = brstat.insure.addr3   
               wcampaign.n42    = brstat.insure.addr4   
               wcampaign.n43    = brstat.insure.telno   
               wcampaign.nclass = brstat.insure.text4   
               wcampaign.garage = brstat.insure.text1  
               wcampaign.pack   = brstat.insure.text3 
               wcampaign.cover  = brstat.insure.vatcode.
    END.
END.
RELEASE brstat.insure.
OPEN QUERY br_camp FOR EACH wcampaign .

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

  nv_chkerror = "".
    RUN wgw\wgwchkagpd  (INPUT wdetail.agent            
                         ,INPUT wdetail.producer   
                         ,INPUT-OUTPUT nv_chkerror).
    IF nv_chkerror <> "" THEN DO:
        MESSAGE "Error Code Producer/Agent :" nv_chkerror  SKIP
        wdetail.producer SKIP
        wdetail.agent  VIEW-AS ALERT-BOX. 
        ASSIGN wdetail.comment = wdetail.comment + nv_chkerror 
               wdetail.pass    = "N" 
               wdetail.OK_GEN  = "N".
    END.
    
 
 IF wdetail.financecd <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(wdetail.financecd) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found code Finance " + wdetail.financecd + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code Finance " + wdetail.financecd + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
                wdetail.pass    = "N" 
                wdetail.OK_GEN  = "N".
     END.
 END.
 /* A65-0115 */
 IF wdetail.dealer <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(wdetail.dealer) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Dealer " + wdetail.dealer + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
      IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
       ASSIGN wdetail.comment = wdetail.comment + "| Code Dealer " + wdetail.dealer + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
              wdetail.pass    = "N" 
              wdetail.OK_GEN  = "N".
     END.
 END.
 /* end A65-0115 */
 /*
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
DEF VAR n_bev    AS CHAR INIT "" .
ASSIGN  n_bev       = "" 
        n_bev       = IF INDEX(wdetail.subclass,"E") <> 0 THEN  "Y" ELSE "N"
        n_comp72    = ""
        nv_chkerror = "" .

/*MESSAGE wdetail.policy 
        " bev      " wdetail.bev       skip
        " prempa   " wdetail.prempa    skip
        " subclass " wdetail.subclass  skip
        " garage   " wdetail.garage    skip
        " vehuse   " wdetail.vehuse    skip
        "n_comp_1  " n_comp_1          skip
       
    VIEW-AS ALERT-BOX.*/

IF wdetail.prempa = "" THEN ASSIGN wdetail.prempa = "T" . 
RUN wgw/wgwcomp(INPUT  wdetail.premtotal,     
                INPUT  wdetail.vehuse  , 
                INPUT  wdetail.prempa  , 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 c-Win 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_process = "Start Check Data empty...".
DISP fi_process WITH FRAM fr_main.
IF wdetail.vehreg = " " AND wdetail.prepol  = " " THEN DO: 
    ASSIGN wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N". 
END.
ELSE DO:
    Def  var  nv_vehreg    as char  init  " ".
    Def  var  s_polno      like sicuw.uwm100.policy   init " ".
    Find LAST sicuw.uwm301 Use-index uwm30102  Where  
        sicuw.uwm301.vehreg = wdetail.vehreg   No-lock no-error no-wait.
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
    END.     /*avil 301*/
END.         /*note end else*/   /*end note vehreg*/
IF wdetail.branch = ""  THEN    /* A56-0323 */
    ASSIGN  wdetail.comment = wdetail.comment + "| สาขาเป็นค่าว่างไม่สามารถนำเข้าระบบได้"   /* A56-0323 */
    wdetail.pass    = "N"     /* A56-0323 */
    wdetail.OK_GEN  = "N".    /* A56-0323 */

IF wdetail.cancel = "ca"  THEN  
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
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
    ASSIGN  wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".  /*can't block in use*/ 
IF wdetail.brand = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N".
IF wdetail.engcc    = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
/*IF wdetail.seat  = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| seat เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".*/
IF wdetail.caryear = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
ASSIGN  
    nv_maxsi  = 0
    nv_minsi  = 0
    nv_si     = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred    = NO  
    nv_modcod = " ".
IF wdetail.redbook <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
        stat.maktab_fil.sclass = wdetail.subclass  AND 
        stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then  
        ASSIGN  nv_modcod       =  stat.maktab_fil.modcod 
                wdetail.redbook =  stat.maktab_fil.modcod
                wdetail.body    =  stat.maktab_fil.body  
                /*wdetail.brand =  stat.maktab_fil.makdes  
                wdetail.model   =  stat.maktab_fil.moddes*/
                wdetail.cargrp  =  stat.maktab_fil.prmpac
                wdetail.weight  =  string(stat.maktab_fil.tons)
                /*wdetail.seat  =  stat.maktab_fil.seats  */
                nv_si           = maktab_fil.si   .
    /*comment by Kridtiya i. A63-0227 Date.20/05/2020
    IF nv_modcod = "" THEN DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
            stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then  
            ASSIGN  nv_modcod    =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                /*wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  string(stat.maktab_fil.tons)
                /*wdetail.seat     =  stat.maktab_fil.seats */
                nv_si            = maktab_fil.si   .
    END.
    comment by Kridtiya i. A63-0227 Date.20/05/2020 */
END.          /*red book <> ""*/   
IF nv_modcod = " " THEN DO:
    /*RUN proc_model_brand.*/
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
    END.   /***--- End Check Rate SI ---***/
    n_model = "".
    n_brand = "".
    n_brand = trim(wdetail.brand) .
    IF INDEX(wdetail.model,"vigo")          <> 0 THEN n_model = "vigo".
    ELSE IF INDEX(wdetail.model,"soluna")   <> 0 THEN n_model = "vios".
    ELSE IF INDEX(wdetail.model,"altis")    <> 0 THEN n_model = "altis".
    ELSE IF INDEX(wdetail.model," ")        <> 0 THEN 
        ASSIGN n_model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ") - 1 ).
    ELSE ASSIGN n_model = wdetail.model .
   
    FIND FIRST stat.makdes31 USE-INDEX makdes31    WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN n_ratmin = makdes31.si_theft_p   
               n_ratmax = makdes31.load_p   .    
    ELSE ASSIGN n_ratmin = 0    n_ratmax = 0.

    IF (wdetail.covcod = "3") OR (wdetail.covcod = "2") THEN DO:
        IF (Integer(wdetail.engcc) = 0 )  THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04         Where
                stat.maktab_fil.makdes   = n_brand            And                  
                index(stat.maktab_fil.moddes,n_model) <> 0    And
                stat.maktab_fil.makyea   = Integer(wdetail.caryear) AND 
                /*stat.maktab_fil.engine   <=    Integer(wdetail.engcc)  AND*/
                stat.maktab_fil.sclass   =  wdetail.subclass        AND
                stat.maktab_fil.seats    =  INTEGER(wdetail.seat)   No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                wdetail.brand    =  stat.maktab_fil.makdes  
                /*wdetail.model    =  stat.maktab_fil.moddes*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  string(stat.maktab_fil.tons)
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat .
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     n_brand            And                  
                index(stat.maktab_fil.moddes,n_model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     wdetail.subclass         AND
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                wdetail.brand    =  stat.maktab_fil.makdes  
                /*wdetail.model    =  stat.maktab_fil.moddes*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  string(stat.maktab_fil.tons)
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat .
        END.
    END.   /*end....covcod..2/3 .....*/
    ELSE DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =     n_brand            And                  
            index(stat.maktab_fil.moddes,n_model) <> 0        And
            stat.maktab_fil.makyea   =    Integer(wdetail.caryear) AND 
            stat.maktab_fil.engine   =    Integer(wdetail.engcc)    AND
            stat.maktab_fil.sclass   =    wdetail.subclass         AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
            stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then DO:
            ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                wdetail.brand    =  stat.maktab_fil.makdes  
                /*wdetail.model    =  stat.maktab_fil.moddes*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  string(stat.maktab_fil.tons)
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat .
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =     n_brand            And                  
            index(stat.maktab_fil.moddes,n_model) <> 0        And
            stat.maktab_fil.makyea   =    Integer(wdetail.caryear) AND 
           /* stat.maktab_fil.engine   =    Integer(wdetail.engcc)    AND*/
            stat.maktab_fil.sclass   =    wdetail.subclass         AND
            /*(stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  */
            stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
                If  avail stat.maktab_fil  Then DO:
                    ASSIGN chkred    =  YES
                        nv_modcod        =  stat.maktab_fil.modcod 
                        wdetail.redbook  =  stat.maktab_fil.modcod
                        wdetail.body     =  stat.maktab_fil.body  
                        wdetail.brand    =  stat.maktab_fil.makdes  
                        /*wdetail.model    =  stat.maktab_fil.moddes*/
                        wdetail.cargrp   =  stat.maktab_fil.prmpac
                        wdetail.weight   =  string(stat.maktab_fil.tons)
                        wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat .
                END.
        END.
    END.
    IF nv_modcod = ""  THEN DO: 
        ASSIGN chkred = YES 
            n_brand       = ""
            n_index       = 0 .
            n_model       = "".
        RUN proc_model_brand.
        RUN proc_maktab.
    END.

END.      /*nv_modcod = blank*/ 
/*end note add &  modi*/
ASSIGN                  
    NO_CLASS  = wdetail.prempa + wdetail.subclass 
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
    ASSIGN wdetail.comment = wdetail.comment + "| Not on Motor Cover Type Codes table sym100 u013"
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
NV_NCBPER = INTE(WDETAIL.NCB) .
If nv_ncbper  <> 0 Then do:
    Find first sicsyac.xmm104 Use-index xmm10401 Where
        sicsyac.xmm104.tariff = wdetail.tariff                      AND
        sicsyac.xmm104.class  = wdetail.prempa + wdetail.subclass   AND
        sicsyac.xmm104.covcod = wdetail.covcod                      AND
        sicsyac.xmm104.ncbper = INTE(wdetail.ncb)                   No-lock no-error no-wait.
    IF not avail  sicsyac.xmm104  Then 
        ASSIGN  wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
END. /*ncb <> 0*/
/******* drivernam **********/
nv_sclass = wdetail.subclass. 

/* Ranu i. F67-0001 */
IF (wdetail.subclass = "E11" ) AND trim(wdetail.drivnam1) = " " THEN DO:
    ASSIGN wdetail.comment = wdetail.comment + "| " + "รหัสรถไฟฟ้า " + wdetail.subclass + " กรุณาระบุผู้ขัขขี่ " 
           WDETAIL.OK_GEN  = "N"     
           wdetail.pass    = "N".
END.

IF wdetail.drivnam1 <> "" AND (wdetail.driveno1 = "" OR wdetail.licenno1 = "" ) THEN DO:
ASSIGN wdetail.comment = wdetail.comment + "| " + "เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ หรือวันเกิด ผู้ขับขี่ 1 ต้องระบุข้อมูล" 
      WDETAIL.OK_GEN  = "N"     
      wdetail.pass    = "N".
END.
IF wdetail.drivnam2 <> "" AND (wdetail.driveno2 = ""  OR  wdetail.licenno2 = "" ) THEN DO:
ASSIGN wdetail.comment = wdetail.comment + "| " + "เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่หรือวันเกิด ผู้ขับขี่ 2 ต้องระบุข้อมูล" 
      WDETAIL.OK_GEN  = "N"     
      wdetail.pass    = "N".
END.
IF wdetail.drivename3 <> "" AND (wdetail.driveno3 = ""  OR wdetail.licenno3 = "") THEN DO:
ASSIGN wdetail.comment = wdetail.comment + "| " + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ หรือวันเกิดผู้ขับขี่ 3 ต้องระบุข้อมูล" 
      WDETAIL.OK_GEN  = "N"     
      wdetail.pass    = "N".
END.
IF wdetail.drivename4 <> "" AND (wdetail.driveno4 = ""  OR  wdetail.licenno4 = "" ) THEN DO:
ASSIGN wdetail.comment = wdetail.comment + "| " + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ หรือวันเกิดผู้ขับขี่ 4 ต้องระบุข้อมูล" 
      WDETAIL.OK_GEN  = "N"     
      wdetail.pass    = "N".
END.
IF wdetail.drivename5 <> "" AND (wdetail.driveno5 = ""  OR  wdetail.licenno5 = ""  ) THEN DO:
ASSIGN wdetail.comment = wdetail.comment + "| " + " เลขที่บัตรประชาชน หรือเลขที่ใบอนุญาตขับขี่ หรือวันเกิดผู้ขับขี่ 5 ต้องระบุข้อมูล" 
      WDETAIL.OK_GEN  = "N"     
      wdetail.pass    = "N".
END.

/* end : A67-0114  */     
   

     
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
FOR EACH wdetail :
    IF  wdetail.policy = ""  THEN NEXT.
    ASSIGN n_rencnt   = 0
    n_endcnt   = 0 
    nv_tons    = 0 
    nv_basere  = 0
    nv_seat41  = 0
    n_41       = 0  
    n_42       = 0  
    n_43       = 0  
    dod1       = 0  
    dod2       = 0  
    dod0       = 0  
    nv_dss_per = 0 
    nv_cl_per  = 0        
    n_firstdat = ?
    nv_insref  = ""   
    nr_premtxt = ""   
    nv_driver  = ""   
    np_driver  = ""
    nv_drivno  = 0.
    /*Add by Kridtiya i. A63-0472*/ 
    RUN proc_susspect. /*Add by Kridtiya i. A63-0472*/
    IF      wdetail.producer = "A0M0018"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer  = "B3MLAY0101" wdetail.financecd   = "FAYCAL" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "A0M0018"    AND wdetail.prepol =  "" THEN ASSIGN wdetail.producer  = "B3MLAY0101" wdetail.financecd   = "FAYCAL" wdetail.campaign_ov = "TRANSF".        
    ELSE IF wdetail.producer = "A0M0019"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer  = "B3MLAY0102" wdetail.financecd   = "FAYCAL" wdetail.campaign_ov = "RENEW".         
    ELSE IF wdetail.producer = "A0M0019"    AND wdetail.prepol =  "" THEN ASSIGN wdetail.producer  = "B3MLAY0102" wdetail.financecd   = "FAYCAL" wdetail.campaign_ov = "REDPLATE".      
    ELSE IF wdetail.producer = "A0M0028"                             THEN ASSIGN wdetail.producer  = "B3MLAY0103" wdetail.financecd   = "FAYCAL" wdetail.campaign_ov = "ISUZURED".                      
    ELSE IF wdetail.producer = "A0M0061"                             THEN ASSIGN wdetail.producer  = "B3MLAY0104" wdetail.financecd   = "FAYCAL" wdetail.campaign_ov = "REDPLATE".                      
    ELSE IF wdetail.producer = "A0M0073"    AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer  = "B3MLAY0105" wdetail.financecd   = "FAYCAL" wdetail.campaign_ov = "BBRENEW".               
    ELSE IF wdetail.producer = "A0M0073"    AND wdetail.prepol =  "" THEN ASSIGN wdetail.producer  = "B3MLAY0105" wdetail.financecd   = "FAYCAL" wdetail.campaign_ov = "BBREDPLATE".   
    ELSE IF wdetail.producer = "A0M1011"                             THEN ASSIGN wdetail.producer  = "B3MLAY0106" wdetail.financecd   = "FAYCAL" wdetail.campaign_ov = "USED".
    ELSE IF wdetail.producer = "B3MLAY0101" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "B3MLAY0101" AND wdetail.prepol =  "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "TRANSF".       
    ELSE IF wdetail.producer = "B3MLAY0102" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "RENEW".                
    ELSE IF wdetail.producer = "B3MLAY0102" AND wdetail.prepol =  "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "REDPLATE".     
    ELSE IF wdetail.producer = "B3MLAY0103"                          THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "ISUZURED".                     
    ELSE IF wdetail.producer = "B3MLAY0104"                          THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "REDPLATE".                     
    ELSE IF wdetail.producer = "B3MLAY0105" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "BBRENEW".              
    ELSE IF wdetail.producer = "B3MLAY0105" AND wdetail.prepol =  "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "BBREDPLATE".   
    ELSE IF wdetail.producer = "B3MLAY0106"                          THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "USED".
    IF wdetail.agent = "B3M0039" THEN wdetail.agent = "B3MLAY0100".
    /* add by : A67-0162 */
    IF wdetail.battyr <> 0 THEN DO:
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
    /* end : A67-0162 */
    RUN proc_chkcode .   /*A64-0138 */
    RUN proc_colorcode.  /*A66-0160*/  
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
        IF wdetail.prepol <> ""  THEN RUN proc_renew. 
        /*Add by Kridtiya i. A63-0472*/ 
        IF      wdetail.producer = "B3MLAY0101" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "RENEW".
        ELSE IF wdetail.producer = "B3MLAY0101" AND wdetail.prepol =  "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "TRANSF".   
        ELSE IF wdetail.producer = "B3MLAY0102" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "RENEW".            
        ELSE IF wdetail.producer = "B3MLAY0102" AND wdetail.prepol =  "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "REDPLATE".         
        ELSE IF wdetail.producer = "B3MLAY0103"                          THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "ISUZURED".                 
        ELSE IF wdetail.producer = "B3MLAY0104"                          THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "REDPLATE".                 
        ELSE IF wdetail.producer = "B3MLAY0105" AND wdetail.prepol <> "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "BBRENEW".          
        ELSE IF wdetail.producer = "B3MLAY0105" AND wdetail.prepol =  "" THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "BBREDPLATE".   
        ELSE IF wdetail.producer = "B3MLAY0106"                          THEN ASSIGN wdetail.financecd = "FAYCAL"     wdetail.campaign_ov = "USED".
        /*Add by Kridtiya i. A63-0472*/
        RUN proc_chktest0.
    END.
    RUN proc_policy . 
    RUN proc_chktest2.      
    RUN proc_chktest3. 
    RUN proc_chktest4. /*A64-0138*/
    /* comment by : A64-0138...
    IF nv_dss_per = 0  THEN RUN proc_chktest4.
    ELSE DO:
        IF  33 >= nv_dss_per   THEN
            ASSIGN 
            nv_dscom = 0
            nv_dscom = 33 - nv_dss_per.
        IF nv_dscom >= 18 THEN RUN proc_chktest4.
        ELSE RUN proc_chktest41.
    END.  
    .. end A64-0138*/
END.      
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
DEF VAR n_countdriv AS INTE INIT 0. /* F67-0001 */
ASSIGN fi_process = "Create uwm130.." + wdetail.policy .
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
        sic_bran.uwm130.bchcnt = nv_batcnt         /* bchcnt     */
        np_driver = TRIM(sic_bran.uwm130.policy) +
                STRING(sic_bran.uwm130.rencnt,"99" ) +
                STRING(sic_bran.uwm130.endcnt,"999") +
                STRING(sic_bran.uwm130.riskno,"999") +
                STRING(sic_bran.uwm130.itemno,"999")
        nv_sclass              = wdetail.subclass.
    IF nv_uom6_u  =  "A"  THEN DO:
        IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
            nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
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

    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR 
       INDEX(wdetail.covcod,"2.") <> 0 OR INDEX(wdetail.covcod,"3.") <> 0 THEN 
        ASSIGN
        sic_bran.uwm130.uom6_v   = inte(wdetail.si)
        sic_bran.uwm130.uom7_v   = inte(wdetail.fi)
        sic_bran.uwm130.uom1_v   = deci(wdetail.tp1)  
        sic_bran.uwm130.uom2_v   = deci(wdetail.tp2)  
        sic_bran.uwm130.uom5_v   = deci(wdetail.tp3)  
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN
        sic_bran.uwm130.uom6_v   = INTE(wdetail.si)
        /*sic_bran.uwm130.uom7_v   = 0*/ /*F67-0001*/
        sic_bran.uwm130.uom7_v   = INTE(wdetail.fi) /*F67-0001*/
        sic_bran.uwm130.uom1_v   = deci(wdetail.tp1)  
        sic_bran.uwm130.uom2_v   = deci(wdetail.tp2)  
        sic_bran.uwm130.uom5_v   = deci(wdetail.tp3)  
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN 
        sic_bran.uwm130.uom1_v   = deci(wdetail.tp1)  
        sic_bran.uwm130.uom2_v   = deci(wdetail.tp2)  
        sic_bran.uwm130.uom5_v   = deci(wdetail.tp3)  
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/

    IF INT(wdetail.cctv) <> 0 THEN sic_bran.uwm130.i_text = "0001" . 

    IF wdetail.poltyp = "v72" THEN  n_sclass72 = wdetail.subclass.
    ELSE n_sclass72 = wdetail.prempa + wdetail.subclass .
    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do: 
        IF wdetail.prempa = "z" THEN
            Assign 
            nv_seat41                  =  wdetail.seat
            sic_bran.uwm130.uom1_v     =  deci(wdetail.tp1)   
            sic_bran.uwm130.uom2_v     =  deci(wdetail.tp2)   
            sic_bran.uwm130.uom5_v     =  deci(wdetail.tp3)   
            nv_uom1_v                  =  deci(wdetail.tp1)   
            nv_uom2_v                  =  deci(wdetail.tp2)   
            nv_uom5_v                  =  deci(wdetail.tp3).  
        ELSE 
            Assign  
                /*add by A63-0129..*/
                sic_bran.uwm130.uom1_v = if deci(wdetail.tp1) <> 0 then deci(wdetail.tp1)  else stat.clastab_fil.uom1_si   
                sic_bran.uwm130.uom2_v = if deci(wdetail.tp2) <> 0 then deci(wdetail.tp2)  else stat.clastab_fil.uom2_si  
                sic_bran.uwm130.uom5_v = if deci(wdetail.tp3) <> 0 then deci(wdetail.tp3)  else stat.clastab_fil.uom5_si
                nv_uom1_v              = if deci(wdetail.tp1) <> 0 then deci(wdetail.tp1)  else stat.clastab_fil.uom1_si  
                nv_uom2_v              = if deci(wdetail.tp2) <> 0 then deci(wdetail.tp2)  else stat.clastab_fil.uom2_si  
                nv_uom5_v              = if deci(wdetail.tp3) <> 0 then deci(wdetail.tp3)  else stat.clastab_fil.uom5_si  .
                /*.. end A63-0129 ..*/ 
        ASSIGN 
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
        If  wdetail.garage   =  ""  Then
            Assign nv_41     =  stat.clastab_fil.si_41unp
                   nv_42     =  stat.clastab_fil.si_42
                   nv_43     =  stat.clastab_fil.si_43
                   /*nv_seat41 =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.  A60-0225*/
                   nv_seat41 =  IF wdetail.seat <> 0 THEN wdetail.seat ELSE stat.clastab_fil.dri_41 + clastab_fil.pass_41. /*A60-0225*/
        Else If  wdetail.garage  =  "G"  Then
            Assign nv_41       =  stat.clastab_fil.si_41pai
                   nv_42       =  stat.clastab_fil.si_42
                   nv_43       =  stat.clastab_fil.impsi_43
                   /*nv_seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.  A60-0225*/
                   nv_seat41 =  IF wdetail.seat <> 0 THEN wdetail.seat ELSE stat.clastab_fil.dri_41 + clastab_fil.pass_41. /*A60-0225*/
    END.
    ASSIGN  nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                                nv_riskno,
                                nv_itemno).
END.    /* end Do transaction*/
ASSIGN
    s_recid3  = RECID(sic_bran.uwm130)
    nv_covcod =   wdetail.covcod
    nv_makdes =  wdetail.brand
    nv_moddes =  wdetail.model
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
    sic_bran.uwm301.bchcnt = nv_batcnt                 NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
    DO TRANSACTION:
        CREATE sic_bran.uwm301.
    END.
END.
ASSIGN 
    sic_bran.uwm301.policy   = sic_bran.uwm120.policy                 
    sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
    sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
    sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
    sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
    sic_bran.uwm301.itemno   = s_itemno
    sic_bran.uwm301.tariff   = wdetail.tariff    
    sic_bran.uwm301.covcod   = wdetail.covcod
    sic_bran.uwm301.cha_no   = trim(nv_uwm301trareg)   /*A56-0323*/
    sic_bran.uwm301.trareg   = trim(nv_uwm301trareg)   /*A56-0323*/
    sic_bran.uwm301.drinam[1] = TRIM(wdetail.tiname) + " " + trim(wdetail.insnam)  
    sic_bran.uwm301.eng_no   = wdetail.eng
    sic_bran.uwm301.Tons     = INTEGER(wdetail.weight)
    sic_bran.uwm301.engine   = INTEGER(wdetail.engcc)
    sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage   = wdetail.garage
    sic_bran.uwm301.body     = wdetail.body
    sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv_ben83 = trim(wdetail.benname)
    sic_bran.uwm301.vehreg   = trim(wdetail.vehreg) 
    sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
    sic_bran.uwm301.vehuse   = trim(wdetail.vehuse)
    sic_bran.uwm301.modcod   = trim(wdetail.redbook) 
    sic_bran.uwm301.moddes   = caps(trim(wdetail.brand)) + " " + caps(trim(wdetail.model))  
    sic_bran.uwm301.vehgrp   = wdetail.cargrp   
    sic_bran.uwm301.sckno    = 0
    sic_bran.uwm301.itmdel   = NO 
    sic_bran.uwm301.prmtxt  = ""  
    sic_bran.uwm301.car_color = wdetail.colorcode /*A66-0160*/
    /* A67-0162 */
    sic_bran.uwm301.watts     = DECI(wdetail.watt)
    sic_bran.uwm301.maksi     = IF index(wdetail.subclass,"E") <> 0 THEN INTE(wdetail.maksi) ELSE 0     
    sic_bran.uwm301.eng_no2   = wdetail.engno2  
    sic_bran.uwm301.battper   = INTE(wdetail.battper)
    /*sic_bran.uwm301.battrate  = INTE(wdetail.battrate*/
    sic_bran.uwm301.battyr    = INTE(wdetail.battyr) 
    sic_bran.uwm301.battsi    = INTE(wdetail.battsi)
    sic_bran.uwm301.battprice = deci(wdetail.battprice)
    sic_bran.uwm301.battno    = wdetail.battno 
    sic_bran.uwm301.chargno   = wdetail.chagreno 
   /* sic_bran.uwm301.chargsi   = deci(wdetail.chargsi)  */
    sic_bran.uwm301.battflg   = IF DECI(wdetail.battprice) <> 0 THEN "Y" ELSE "N"  . 
  /*  sic_bran.uwm301.chargflg  = IF DECI(wdetail.chargprm) <> 0 THEN "Y" ELSE "N")*/
    FIND LAST wtxt WHERE wtxt.policy = wdetail.policy AND wtxt.poltyp = "V70" NO-LOCK NO-ERROR.
        IF AVAIL wtxt THEN DO:
            ASSIGN sic_bran.uwm301.logbok   = IF index(wtxt.inspno,"NO") <> 0 THEN "N" ELSE "Y"   
                   SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = trim(wtxt.acc1) + TRIM(wtxt.accprice1) 
                   SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = trim(wtxt.acc2) + TRIM(wtxt.accprice2) 
                   SUBSTRING(sic_bran.uwm301.prmtxt,121,60) = trim(wtxt.acc3) + TRIM(wtxt.accprice3) 
                   SUBSTRING(sic_bran.uwm301.prmtxt,181,60) = trim(wtxt.acc4) + TRIM(wtxt.accprice4)
                   SUBSTRING(sic_bran.uwm301.prmtxt,241,60) = trim(wtxt.acc5) + TRIM(wtxt.accprice5).
        END.
    IF nr_premtxt <> ""  THEN DO: 
        IF  sic_bran.uwm301.prmtxt = ""  THEN  ASSIGN sic_bran.uwm301.prmtxt = TRIM(nr_premtxt).
        ELSE DO:
            np_txt = 0.
            np_retxt = 0.
            np_txt = LENGTH(sic_bran.uwm301.prmtxt).
            np_retxt = LENGTH(nr_premtxt) .
            ASSIGN SUBSTR(sic_bran.uwm301.prmtxt,np_txt,np_retxt) = TRIM(nr_premtxt) .
        END.
    END.
    wdetail.tariff = sic_bran.uwm301.tariff.
    IF wdetail.compul = "y" THEN DO:
        sic_bran.uwm301.cert = "".
        IF LENGTH(wdetail.stk) = 11 THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
        IF LENGTH(wdetail.stk) = 13  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
        IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".
        FIND FIRST brStat.Detaitem USE-INDEX detaitem11     WHERE
           brStat.Detaitem.serailno = wdetail.stk          AND
           brstat.detaitem.yearReg    = nv_batchyr         AND
           brstat.detaitem.seqno      = STRING(nv_batchno) AND
           brstat.detaitem.seqno2     = STRING(nv_batcnt)  NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.Detaitem THEN DO:     
           CREATE brstat.Detaitem.
           ASSIGN 
               brStat.Detaitem.Policy   = sic_bran.uwm301.Policy
               brStat.Detaitem.RenCnt   = sic_bran.uwm301.RenCnt
               brStat.Detaitem.EndCnt   = sic_bran.uwm301.Endcnt
               brStat.Detaitem.RiskNo   = sic_bran.uwm301.RiskNo
               brStat.Detaitem.ItemNo   = sic_bran.uwm301.ItemNo
               brStat.Detaitem.serailno = wdetail.stk  
               brstat.detaitem.yearReg  = sic_bran.uwm301.bchyr
               brstat.detaitem.seqno    = STRING(sic_bran.uwm301.bchno)     
               brstat.detaitem.seqno2   = STRING(sic_bran.uwm301.bchcnt). 
        END.
    END.
    ASSIGN  sic_bran.uwm301.bchyr  = nv_batchyr     /* batch Year */
            sic_bran.uwm301.bchno  = nv_batchno     /* bchno      */
            sic_bran.uwm301.bchcnt = nv_batcnt .    /* bchcnt     */
    /*IF wdetail.drivnam1 <> ""  THEN RUN proc_mailtxt.*/ /* A67-0162 */
    n_countdriv = 0 .
    IF wdetail.drivnam1 <> ""  THEN RUN proc_driver. /*A67-0162 */
    ELSE DO:
        IF nv_driver = ""   THEN ASSIGN nv_drivno = 0.
        ELSE DO:
            FOR EACH ws0m009 WHERE ws0m009.policy  = nv_driver NO-LOCK .
                /* F67-0001 */
                IF trim(ws0m009.gender) = "" THEN DO:
                 IF      ws0m009.titlenam = "นางสาว" THEN  ASSIGN  nv_dgender = "FEMALE" .
                 else IF ws0m009.titlenam = "น.ส."   THEN  ASSIGN  nv_dgender = "FEMALE" .
                 else IF ws0m009.titlenam = "นาง"    THEN  ASSIGN  nv_dgender = "FEMALE" .
                 else IF ws0m009.titlenam = "นาย"    THEN  ASSIGN  nv_dgender = "MALE" .
                 ELSE ASSIGN  nv_dgender = "MALE" .
                END.
                /* end : F67-0001 */

                CREATE brstat.mailtxt_fil.
                ASSIGN
                    brstat.mailtxt_fil.policy  = np_driver    
                    brstat.mailtxt_fil.lnumber = INTEGER(ws0m009.lnumber)
                    brstat.mailtxt_fil.ltext   = ws0m009.ltext  
                    brstat.mailtxt_fil.ltext2  = ws0m009.ltext2   
                    brstat.mailtxt_fil.bchyr   = nv_batchyr 
                    brstat.mailtxt_fil.bchno   = nv_batchno 
                    brstat.mailtxt_fil.bchcnt  = nv_batcnt 
              /* add by : A67-0162 */
                    brstat.mailtxt_fil.drivbirth = ws0m009.drivbirth 
                    brstat.mailtxt_fil.drivage   = ws0m009.drivage    
                    brstat.mailtxt_fil.occupcod  = ws0m009.occupcod   
                    brstat.mailtxt_fil.occupdes  = ws0m009.occupdes   
                    brstat.mailtxt_fil.cardflg   = ws0m009.cardflg    
                    brstat.mailtxt_fil.drividno  = ws0m009.drividno   
                    brstat.mailtxt_fil.licenno   = ws0m009.licenno   
                    brstat.mailtxt_fil.drivnam   = ws0m009.drivnam   
                    brstat.mailtxt_fil.gender    = IF ws0m009.gender = "" THEN nv_dgender ELSE ws0m009.gender  
                    brstat.mailtxt_fil.drivlevel = ws0m009.drivlevel 
                    brstat.mailtxt_fil.levelper  = ws0m009.levelper  
                    brstat.mailtxt_fil.titlenam  = ws0m009.titlenam  
                    brstat.mailtxt_fil.licenexp  = ws0m009.licenexp  
                    brstat.mailtxt_fil.firstnam  = ws0m009.firstnam  
                    brstat.mailtxt_fil.lastnam   = ws0m009.lastnam 
                    brstat.mailtxt_fil.dconsen   = ws0m009.dconsen   .
              ASSIGN 
                 nv_dlevel        = ws0m009.drivlevel
                 wdetail.drilevel = IF      INTE(wdetail.drilevel) = 0 THEN STRING(nv_dlevel) 
                                    ELSE IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
                 nv_dlevper       = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                                    ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60   .
                 /* end : A67-0162 */
                ASSIGN nv_drivno   = INTEGER(ws0m009.lnumber)
                       n_countdriv = INTEGER(ws0m009.lnumber). /* F67-0001*/
            END.
        END.
    END.
    s_recid4   = RECID(sic_bran.uwm301).
    /*F67-0001 */
    IF wdetail.prepol <> ""  THEN DO:
        IF wdetail.drivnam1 <> "" AND n_countdriv = 0 THEN DO:
            ASSIGN WDETAIL.WARNING = IF WDETAIL.WARNING <> "" THEN WDETAIL.WARNING + " | " + "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" ELSE "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" .
        END.
        ELSE IF wdetail.drivnam1 = "" AND n_countdriv <> 0 THEN DO:
            ASSIGN WDETAIL.WARNING = IF WDETAIL.WARNING <> "" THEN WDETAIL.WARNING + " | " + "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" ELSE "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" .
        END.
        ELSE IF wdetail.drivnam1 <> "" AND n_countdriv <> 0 THEN DO:
            ASSIGN WDETAIL.WARNING = IF WDETAIL.WARNING <> "" THEN WDETAIL.WARNING + " | " + "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" ELSE "ตรวจสอบผู้ขับขี่ในไฟล์และใบเตือน" .
        END.
    END.
    /* end : F67-0001*/
  
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
ASSIGN dod1 = 0   dod2 = 0     dpd0 = 0    /*add A64-0138*/  
    nv_tariff = sic_bran.uwm301.tariff
    nv_class  = IF wdetail.poltyp = "v72" THEN wdetail.subclass ELSE wdetail.prempa +  wdetail.subclass
    nv_comdat = sic_bran.uwm100.comdat
    nv_engine = DECI(wdetail.engcc)
    nv_tons   = deci(wdetail.weight)
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse
    nv_COMPER = deci(wdetail.comper) 
    nv_comacc = deci(wdetail.comacc) 
    nv_seats  = INTE(wdetail.seat)
    /*nv_dss_per = 0  */   
    nv_dsspcvar1  = ""
    nv_dsspcvar2  = ""
    nv_dsspcvar   = ""
    nv_42cod      = ""
    nv_43cod      = ""
    nv_41cod1     = ""
    nv_41cod2     = ""
    nv_basecod    = ""
    nv_usecod     = "" 
    nv_engcod     = "" 
    nv_drivcod    = ""
    nv_yrcod      = "" 
    nv_sicod      = "" 
    nv_grpcod     = "" 
    nv_bipcod     = "" 
    nv_biacod     = "" 
    nv_pdacod     = "" 
    nv_ncbyrs     =   0    
    nv_ncbper     =   0 
    nv_usecod3    = ""
    nv_usevar3    = ""
    nv_usevar4    = ""
    nv_usevar5    = ""
    nv_basecod3   = ""
    nv_baseprm3   = 0
    nv_basevar3   = ""
    nv_basevar4   = ""
    nv_basevar5   = ""
    nv_sicod3     = ""
    nv_sivar3     = ""
    nv_sivar4     = ""
    nv_sivar5    = ""
    /*nv_ncb      =   0*/
    nv_totsi      =  0 . 
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
            ASSIGN nv_vehuse = "0".     /*A52-0172 ให้ค่า0 เนื่องจากต้องการส่งค่าให้ key.b = 0 */
            RUN wgs\wgscomp.       
        END.
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
        sic_bran.uwm130.uom9_v  =  0 .
    RUN proc_base2.
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.1") OR (wdetail.covcod = "3.2") THEN DO:
    
        ASSIGN  nv_usevar3 = ""
                nv_usecod3  = IF      (wdetail.covcod = "2.1") THEN "U" + TRIM(nv_vehuse) + "21" 
                              ELSE IF (wdetail.covcod = "2.2") THEN "U" + TRIM(nv_vehuse) + "22" 
                              ELSE IF (wdetail.covcod = "3.1") THEN "U" + TRIM(nv_vehuse) + "31"
                              ELSE "U" + TRIM(nv_vehuse) + "32" 
                nv_usevar4 = "     Vehicle Use = "
                nv_usevar5 =  wdetail.vehuse
                Substring(nv_usevar3,1,30)   = nv_usevar4
                Substring(nv_usevar3,31,30)  = nv_usevar5.
        /*-------------------base 3----------------------*/
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
            IF AVAIL xmm106 THEN DO:
                nv_baseprm3 = xmm106.min_ap.
            END.
            ELSE DO:
                 nv_baseprm3 = 0.
                 NO_basemsg = "Base Premium3 is Not in Range " .
            END.
        IF NO_basemsg <> " " THEN  wdetail.WARNING = no_basemsg.
        ASSIGN nv_basevar3 = ""
             nv_basevar4 = "     Base Premium3 = "
             nv_basevar5 = STRING(nv_baseprm3)
             SUBSTRING(nv_basevar3,1,30)   = nv_basevar4
             SUBSTRING(nv_basevar3,31,30)  = nv_basevar5. 
        /*---------------- SI 2+3+ ----------------------------*/
         ASSIGN nv_sivar3 = ""
            nv_sicod3    = IF      (wdetail.covcod = "2.1") THEN "SI21" 
                           ELSE IF (wdetail.covcod = "2.2") THEN "SI22" 
                           ELSE IF (wdetail.covcod = "3.1") THEN "SI31"  ELSE "SI32"     
            nv_sivar4    = "     Own Damage = "                                        
            nv_sivar5    =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  string(deci(wdetail.si)) ELSE  string(deci(wdetail.si)) 
            wdetail.si   =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  wdetail.si ELSE  wdetail.si
            SUBSTRING(nv_sivar3,1,30)  = nv_sivar4
            SUBSTRING(nv_sivar3,31,30) = nv_sivar5 .
            nv_totsi     = IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  deci(wdetail.si) ELSE  deci(wdetail.si).
    END.   
END.
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
IF index(wdetail.subclass,"E") <> 0  THEN RUN proc_calpremt_ev. /*A67-0162*/
ELSE RUN proc_calpremt .      /*A64-0138*/
RUN proc_adduwd132prem . /*A64-0138*/

RUN proc_uwm100.
FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
     ASSIGN
     sic_bran.uwm120.gap_r  = nv_gapprm
     sic_bran.uwm120.prem_r = nv_pdprm
     sic_bran.uwm120.sigr   = inte(wdetail.si).

FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN 
    ASSIGN   
       /* comment by : A64-0138...
        sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs
        ... end A64-0138...*/
        sic_bran.uwm301.mv41seat = wdetail.seat 
    /* add by A63-0129 .*/
        sic_bran.uwm301.tons     = IF sic_bran.uwm301.tons = 0 THEN 0 ELSE IF sic_bran.uwm301.tons < 100 THEN (sic_bran.uwm301.tons * 1000 ) 
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
/* comment by : A64-0138...
IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR
   (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" ) THEN      
    RUN WGS\WGSTP132(INPUT S_RECID3,   
                     INPUT S_RECID4). 
ELSE 
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).

/*-- คำนวณเบี้ยส่วนลดผู้ขับขี่ ---*/
nv_pdprm0 = 0.
IF nv_drivno <> 0  THEN DO:
     RUN wgw\wgwORPR0 (INPUT  nv_tariff,
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         uwm130.uom1_v,
                         uwm130.uom2_v,
                         uwm130.uom5_v,
                  OUTPUT nv_pdprm0).
     ASSIGN uwm301.actprm = nv_pdprm0. 
END.
.. end A64-0138...*/

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
DEF VAR nv_model        AS CHAR FORMAT "x(50)" INIT "". /*A60-0225*/

FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1
  no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
      Return.
  End.
  Else  do:
      Assign 
            nv_model   =  ""
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt
            nv_model   =  trim(wdetail.brand) + trim(wdetail.model)    /*A60-0225*/
            nv_model   =  REPLACE(nv_model," ","").                    /*A60-0225*/

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
  IF AVAIL   sicsyac.xmm018 THEN DO:
      /* a61-0228*/
      IF index(wdetail.packcode,"MOPH") <> 0 THEN DO:
          ASSIGN nv_com1p = INT(SUBSTR(wdetail.packcode,5,2))   nv_com2p = 0.
      END.
      /* end A61-0228*/
      ELSE Assign  nv_com1p = sicsyac.xmm018.commsp  
                   nv_com2p = 0.
  END.
  ELSE DO:
          Find sicsyac.xmm031  Use-index xmm03101  Where  
               sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
          No-lock no-error no-wait.
          IF not  avail sicsyac.xmm031 Then 
            Assign     nv_com1p = 0
                       nv_com2p = 0.
          Else DO:
              /* a61-0228*/
              IF index(wdetail.packcode,"MOPH") <> 0 THEN DO:
                 ASSIGN nv_com1p = INT(SUBSTR(wdetail.packcode,5,2))   nv_com2p = 0.
              END.
              /* end A61-0228*/
              ELSE 
                  Assign  nv_com1p = sicsyac.xmm031.comm1
                          nv_com2p = 0 .
          END.         
           
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
  IF sic_bran.uwm120.com1ae   = Yes  Then do:     
     nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.           
        
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest41 c-Win 
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
DEF VAR nv_model        AS CHAR FORMAT "x(50)" INIT "". /*A60-0225*/

FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1
  no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
      Return.
  End.
  Else  do:
      Assign 
            nv_model   =  ""                                           /*A60-0225*/
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt
            nv_model   =  trim(wdetail.brand) + trim(wdetail.model)    /*A60-0225*/
            nv_model   =  REPLACE(nv_model," ","").                    /*A60-0225*/

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
  IF AVAIL   sicsyac.xmm018 THEN DO:
            Assign     nv_com1p = sicsyac.xmm018.commsp  
                       nv_com2p = 0.
  END.
  ELSE DO:
          Find sicsyac.xmm031  Use-index xmm03101  Where  
               sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
          No-lock no-error no-wait.
          IF not  avail sicsyac.xmm031 Then 
            Assign     nv_com1p = 0
                       nv_com2p = 0.
          Else  DO:
             Assign   nv_com1p = sicsyac.xmm031.comm1
                      nv_com2p = 0 .
          END.
           
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
     ELSE ASSIGN nv_com1p = nv_dscom  .
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cleardata c-Win 
PROCEDURE proc_cleardata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN                    
        n_poltyp           = ""            /* add by :  A67-0162 */
        n_account_no       = ""            n_drivlicen1     = ""
        n_inscode          = ""            n_drivcardexp1   = ""
        n_campcode         = ""            n_drivlicen2     = ""
        n_campname         = ""            n_drivcardexp2   = ""
        n_procode          = ""            n_drivnam3       = ""
        n_proname          = ""            n_driveno3       = ""
        n_packname         = ""            n_occupdri3      = ""
        n_packcode         = ""            n_sexdriv3       = ""
        n_prepol           = ""            n_bdatedri3      = ""
        n_instype          = ""            n_drivlicen3     = ""
        n_tiname           = ""            n_drivcardexp3   = ""
        n_insnam           = ""            n_drivnam4       = ""
        n_title_eng        = ""            n_driveno4       = ""
        n_insname_eng      = ""            n_occupdri4      = ""
        n_icno             = ""            n_sexdriv4       = ""
        n_bdate            = ""            n_bdatedri4      = ""
        n_occup            = ""            n_drivlicen4     = ""
        n_tel              = ""            n_drivcardexp4   = ""
        n_mail             = ""            n_drivnam5       = ""
        n_addrpol1         = ""            n_driveno5       = ""
        n_addrpol2         = ""            n_occupdri5      = ""
        n_addrpol3         = ""            n_sexdriv5       = ""
        n_addrpol4         = ""            n_bdatedri5      = ""
        n_addrsend1        = ""            n_drivlicen5     = ""
        n_addrsend2        = ""            n_drivcardexp5   = ""
        n_addrsend3        = ""            n_watt           = ""
        n_addrsend4        = ""            n_evmotor1       = ""
        n_paytype          = ""            n_evmotor2       = ""
        n_paytitle         = ""            n_evmotor3       = ""
        n_payname          = ""            n_evmotor4       = ""
        n_payic            = ""            n_evmotor5       = ""
        n_addrpay1         = ""            n_carprice       = ""
        n_addrpay2         = ""            n_battflag       = ""
        n_addrpay3         = ""            n_battyr         = ""
        n_addrpay4         = ""            n_battdate       = ""
        n_branch           = ""            n_battprice      = ""
        n_ben_name         = ""            n_battno         = ""
        n_pmentcode        = ""            n_battsi         = ""
        n_pmenttyp         = ""            n_chagreno       = ""
        n_pmentcode1       = ""            n_chagrebrand    = ""
        n_pmentcode2       = ""         /* end A67-0162 */
        n_pmentbank        = "" 
        n_pmentdate        = "" 
        n_pmentsts         = "" 
        n_brand            = "" 
        n_Model            = "" 
        n_body             = "" 
        n_vehreg           = "" 
        n_re_country       = "" 
        n_chasno           = "" 
        n_eng              = "" 
        n_caryear          = "" 
        n_seate            = "" 
        n_engcc            = "" 
        n_power            = "" 
        n_class            = "" 
        n_garage           = "" 
        n_colorcode        = "" 
        n_covcod           = "" 
        n_covtyp           = "" 
        n_comdat           = "" 
        n_expdat           = "" 
        n_si               = "" 
        n_prem1            = "" 
        n_gross_prm        = "" 
        n_stamp            = "" 
        n_vat              = "" 
        n_premtotal        = "" 
        n_deduct           = "" 
        n_fleetper         = "" 
        n_ncb              = "" 
        n_drivper          = "" 
        n_othper           = "" 
        n_cctvper          = "" 
        n_Surcharper       = "" 
        n_Surchardetail    = "" 
        n_driver           = "" 
        n_drivnam1         = "" 
        n_driveno1         = "" 
        n_occupdri1        = "" 
        n_sexdriv1         = "" 
        n_bdatedri1        = "" 
        n_drivnam2         = "" 
        n_driveno2         = "" 
        n_occupdri2        = "" 
        n_sexdriv2         = "" 
        n_bdatedri2        = "" 
        n_acc1             = "" 
        n_accdetail1       = "" 
        n_accprice1        = "" 
        n_acc2             = "" 
        n_accdetail2       = "" 
        n_accprice2        = "" 
        n_acc3             = "" 
        n_accdetail3       = "" 
        n_accprice3        = "" 
        n_acc4             = "" 
        n_accdetail4       = "" 
        n_accprice4        = "" 
        n_acc5             = "" 
        n_accdetail5       = "" 
        n_accprice5        = "" 
        n_inspdate         = "" 
        n_inspdate_app     = "" 
        n_inspsts          = "" 
        n_inspdetail       = "" 
        n_not_date         = "" 
        n_paydate          = "" 
        n_paysts           = "" 
        n_licenBroker      = "" 
        n_brokname         = "" 
        n_brokcode         = "" 
        n_lang             = "" 
        n_deli             = "" 
        n_delidetail       = "" 
        n_gift             = "" 
        n_remark           = "" 
        n_inspno           = "" 
        n_remarkinsp       = ""  
        n_damang1          = ""
        n_damang2          = ""
        n_damang3          = ""
        n_dataoth          = ""
        n_hobr             = "" 
        n_bray             = ""
        n_contract         = ""
        n_producer         = ""
        n_agent            = ""
        n_remark2          = ""
        n_fi               = "" .



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_clearmailtxt c-Win 
PROCEDURE proc_clearmailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR n_length AS INTE INIT 0 .

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
       nv_dconsent   = "" 
       nv_dlevper   = 0 .

IF nv_drivname <> "" THEN DO:
    ASSIGN n_length  = 0
        nv_lname     = IF index(nv_drivname," ") <> 0 THEN trim(SUBSTR(nv_drivname,R-INDEX(nv_drivname," "))) ELSE ""
        n_length     = LENGTH(nv_lname)
        nv_drivname  = IF index(nv_drivname," ") <> 0 THEN trim(SUBSTR(nv_drivname,1,LENGTH(nv_drivname) - n_length)) ELSE nv_drivname
        nv_name      = IF index(nv_drivname," ") <> 0 THEN trim(SUBSTR(nv_drivname,R-INDEX(nv_drivname," "))) ELSE nv_drivname
        n_length     = LENGTH(nv_name)
        nv_drivname  = IF index(nv_drivname," ") <> 0 THEN trim(SUBSTR(nv_drivname,1,LENGTH(nv_drivname) - n_length)) ELSE "" 
        nv_ntitle    = TRIM(nv_drivname).
    IF nv_ntitle = ""  THEN DO:
      IF TRIM(nv_name) <> " " THEN DO: 
         IF      R-INDEX(TRIM(nv_name),"นางสาว") <> 0 THEN ASSIGN nv_ntitle = "นางสาว" .
         ELSE IF R-INDEX(TRIM(nv_name),"น.ส.")   <> 0 THEN ASSIGN nv_ntitle = "น.ส." .  
         ELSE IF R-INDEX(TRIM(nv_name),"นาง")    <> 0 THEN ASSIGN nv_ntitle = "นาง" .    
         ELSE IF R-INDEX(TRIM(nv_name),"นาย")    <> 0 THEN ASSIGN nv_ntitle = "นาย" .
         ELSE DO:
            FIND FIRST sicsyac.sym100 use-index sym10002 where
                       sicsyac.sym100.tabcod = "U080"  AND
                       index(nv_name,sicsyac.sym100.itmdes) <> 0 NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sym100 THEN DO: 
                    ASSIGN nv_ntitle      = trim(sym100.itmdes)
                         n_length       = LENGTH(nv_ntitle) + 1
                         nv_name    = trim(SUBSTR(nv_name,n_length,LENGTH(nv_name))) .
                END. 
                ELSE DO:
                    FIND FIRST sym100 use-index sym10002 where
                               sym100.tabcod = "U081"    AND
                               index(nv_ntitle,sym100.itmdes) <> 0 NO-LOCK NO-ERROR NO-WAIT.
                       IF AVAIL sym100 THEN DO: 
                          ASSIGN nv_ntitle      = trim(sym100.itmdes)
                                 n_length       = LENGTH(nv_ntitle) + 1
                                 nv_name        = trim(SUBSTR(nv_name,n_length,LENGTH(nv_name)))  .
                       END. 
                END.
         END.
      END.
      IF nv_ntitle <> "" THEN ASSIGN nv_name = trim(REPLACE(nv_name,nv_ntitle,"")) .
    END.

    IF      nv_ntitle = "นางสาว" THEN  ASSIGN  nv_dgender = "FEMALE" .
    else IF nv_ntitle = "น.ส."   THEN  ASSIGN  nv_dgender = "FEMALE" .
    else IF nv_ntitle = "นาง"    THEN  ASSIGN  nv_dgender = "FEMALE" .
    else IF nv_ntitle = "นาย"    THEN  ASSIGN  nv_dgender = "MALE" .
    ELSE ASSIGN  nv_dgender = "MALE" .

END.

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
/*A66-0160*/  
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
/*A66-0160*/  
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
       sic_bran.uwm100.bchcnt = nv_batcnt  .  


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
/*DEF VAR nv_i AS INT.
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

    ind = INDEX(nv_c," ").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN
    wdetail.policy = nv_c .*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_disp c-Win 
PROCEDURE proc_disp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
    " nv_level         " nv_level       skip
    " nv_levper        " nv_levper      skip
    " nv_tariff        " nv_tariff      skip
    " nv_adjpaprm      " nv_adjpaprm    skip
    " nv_flgpol        " nv_flgpol      skip
    " nv_flgclm        " nv_flgclm      skip
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.    
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_driver c-Win 
PROCEDURE proc_driver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_count   = 0.
 IF  wdetail.drivnam1 <> "" THEN DO :      
      ASSIGN no_policy    = ""            nv_drivage1  = 0        nv_drivbir1  = ""    
             no_rencnt    = ""            nv_drivage2  = 0        nv_drivbir2  = ""    
             no_endcnt    = ""            nv_drivage3  = 0        nv_drivbir3  = ""    
             no_riskno    = ""            nv_drivage4  = 0        nv_drivbir4  = ""    
             no_itemno    = ""            nv_drivage5  = 0        nv_drivbir5  = "" 
             nv_dribirth  = ""            nv_dlevel    = 0        nv_dlevper   = 0
             nv_dconsent  = ""            nv_drivname = ""
             no_policy = sic_bran.uwm301.policy 
             no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") 
             no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") 
             no_riskno = "001"
             no_itemno = "001"
             n_count   = 0.

   ASSIGN wdetail.bdatedri1   = STRING(DATE(wdetail.bdatedri1),"99/99/9999")
          wdetail.bdatedri2   = STRING(DATE(wdetail.bdatedri2),"99/99/9999")
          wdetail.bdatedriv3  = STRING(DATE(wdetail.bdatedriv3),"99/99/9999") 
          wdetail.bdatedriv4  = STRING(DATE(wdetail.bdatedriv4),"99/99/9999") 
          wdetail.bdatedriv5  = STRING(DATE(wdetail.bdatedriv5),"99/99/9999") 
          nv_drivage1      = IF TRIM(wdetail.bdatedri1) <> "?" THEN  INT(SUBSTR(wdetail.bdatedri1,7,4)) ELSE 0
          nv_drivage2      = IF TRIM(wdetail.bdatedri2) <> "?" THEN  INT(SUBSTR(wdetail.bdatedri2,7,4)) ELSE 0
          nv_drivage3      = IF TRIM(wdetail.bdatedriv3) <> "?" THEN  INT(SUBSTR(wdetail.bdatedriv3,7,4)) ELSE 0
          nv_drivage4      = IF TRIM(wdetail.bdatedriv4) <> "?" THEN  INT(SUBSTR(wdetail.bdatedriv4,7,4)) ELSE 0
          nv_drivage5      = IF TRIM(wdetail.bdatedriv5) <> "?" THEN  INT(SUBSTR(wdetail.bdatedriv5,7,4)) ELSE 0 .

    IF wdetail.bdatedri1 <> " "  AND wdetail.drivnam1 <> " " THEN DO: 
        ASSIGN nv_drivname = "" 
               nv_drivname = TRIM(wdetail.drivnam1) .
        RUN proc_clearmailtxt .
        if nv_drivage1 < year(today) then do:
            nv_drivage1 =  YEAR(TODAY) - nv_drivage1  .
            ASSIGN nv_dribirth    = STRING(DATE(wdetail.bdatedri1),"99/99/9999") /* ค.ศ. */
                   nv_drivbir1    = STRING(INT(SUBSTR(wdetail.bdatedri1,7,4))  + 543 )
                   wdetail.bdatedri1 = SUBSTR(wdetail.bdatedri1,1,6) + nv_drivbir1
                   wdetail.bdatedri1 = STRING(DATE(wdetail.bdatedri1),"99/99/9999") . /* พ.ศ. */
        END.
        ELSE DO:
            nv_drivage1 =  YEAR(TODAY) - (nv_drivage1 - 543).
            ASSIGN nv_drivbir1    = STRING(INT(SUBSTR(wdetail.bdatedri1,7,4)))
                   nv_dribirth    = SUBSTR(wdetail.bdatedri1,1,6) + STRING((INTE(nv_drivbir1) - 543),"9999")  /* ค.ศ. */
                   wdetail.bdatedri1 = SUBSTR(wdetail.bdatedri1,1,6) + nv_drivbir1   
                   wdetail.bdatedri1 = STRING(DATE(wdetail.bdatedri1),"99/99/9999")  . /* พ.ศ. */
        END.

        ASSIGN  n_count        = 1
                nv_drinam   = trim(wdetail.drivnam1) 
                nv_dicno    = TRIM(wdetail.driveno1) 
                nv_dgender  = trim(wdetail.sexdriv1)
                nv_dbirth   = trim(wdetail.bdatedri1)
                nv_dage     = nv_drivage1
                nv_doccup   = trim(wdetail.occupdri1) 
                nv_ddriveno = trim(wdetail.licenno1)
                nv_drivexp  = trim(wdetail.licenex1) 
                nv_dconsent = "" /*TRIM(wdrive.dconsen1) */ 
                nv_dlevel   = IF INTE(wdetail.drivlevel1) = 0 THEN 1 ELSE INTE(wdetail.drivlevel1)  
                wdetail.drilevel = STRING(nv_dlevel)   
                nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                              ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
        RUN proc_mailtxt.
    END.

    IF wdetail.bdatedri2 <> " "  AND wdetail.drivnam2 <> " " THEN DO: 
        ASSIGN nv_drivname = "" 
               nv_drivname = TRIM(wdetail.drivnam2) .
        RUN proc_clearmailtxt .
        if nv_drivage2 < year(today) then do:
            nv_drivage2 =  YEAR(TODAY) - nv_drivage2  .
            ASSIGN nv_dribirth    = STRING(DATE(wdetail.bdatedri2),"99/99/9999") /* ค.ศ. */
                   nv_drivbir2    = STRING(INT(SUBSTR(wdetail.bdatedri2,7,4))  + 543 )
                   wdetail.bdatedri2 = SUBSTR(wdetail.bdatedri2,1,6) + nv_drivbir2
                   wdetail.bdatedri2 = STRING(DATE(wdetail.bdatedri2),"99/99/9999") . /* พ.ศ. */
        END.
        ELSE DO:
            nv_drivage2 =  YEAR(TODAY) - (nv_drivage2 - 543).
            ASSIGN nv_drivbir2    = STRING(INT(SUBSTR(wdetail.bdatedri2,7,4)))
                   nv_dribirth    = SUBSTR(wdetail.bdatedri2,1,6) + STRING((INTE(nv_drivbir2) - 543),"9999")  /* ค.ศ. */
                   wdetail.bdatedri2 = SUBSTR(wdetail.bdatedri2,1,6) + nv_drivbir2   
                   wdetail.bdatedri2 = STRING(DATE(wdetail.bdatedri2),"99/99/9999")  . /* พ.ศ. */
        END.
        ASSIGN  n_count        = 2
                nv_drinam   = trim(wdetail.drivnam2) /*nv_ntitle + " " + nv_name  + " " + nv_lname*/
                nv_dicno    = TRIM(wdetail.driveno2)   
                nv_dgender  = trim(wdetail.sexdriv2) 
                nv_dbirth   = trim(wdetail.bdatedri2)
                nv_dage     = nv_drivage2
                nv_doccup   = trim(wdetail.occupdri2) 
                nv_ddriveno = trim(wdetail.licenno2)
                nv_drivexp  = trim(wdetail.licenex2)
                nv_dconsent = "" /*TRIM(wdrive.dconsen1) */ 
                nv_dlevel   = IF INTE(wdetail.drivlevel2) = 0 THEN 1 ELSE INTE(wdetail.drivlevel2)  
                wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
                nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                              ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
        RUN proc_mailtxt.
    END.

    IF wdetail.bdatedriv3 <> " "  AND wdetail.drivename3 <> " " THEN DO:
        ASSIGN nv_drivname = "" 
               nv_drivname = TRIM(wdetail.drivename3) .
        RUN proc_clearmailtxt .
        if nv_drivage3 < year(today) then do:
            nv_drivage3 =  YEAR(TODAY) - nv_drivage3  .
            ASSIGN nv_dribirth    = STRING(DATE(wdetail.bdatedriv3),"99/99/9999") /* ค.ศ. */
                   nv_drivbir3    = STRING(INT(SUBSTR(wdetail.bdatedriv3,7,4))  + 543 )
                   wdetail.bdatedriv3 = SUBSTR(wdetail.bdatedriv3,1,6) + nv_drivbir3
                   wdetail.bdatedriv3 = STRING(DATE(wdetail.bdatedriv3),"99/99/9999") . /* พ.ศ. */
        END.
        ELSE DO:
            nv_drivage3 =  YEAR(TODAY) - (nv_drivage3 - 543).
            ASSIGN nv_drivbir3    = STRING(INT(SUBSTR(wdetail.bdatedriv3,7,4)))
                   nv_dribirth    = SUBSTR(wdetail.bdatedriv3,1,6) + STRING((INTE(nv_drivbir3) - 543),"9999")  /* ค.ศ. */
                   wdetail.bdatedriv3 = SUBSTR(wdetail.bdatedriv3,1,6) + nv_drivbir3   
                   wdetail.bdatedriv3 = STRING(DATE(wdetail.bdatedriv3),"99/99/9999")  . /* พ.ศ. */
        END.
        ASSIGN  n_count        = 3
                nv_drinam   = trim(wdetail.drivename3) /*nv_ntitle + " " + nv_name  + " " + nv_lname*/
                nv_dicno    = TRIM(wdetail.driveno3)
                nv_dgender  = trim(wdetail.sexdriv3)
                nv_dbirth   = trim(wdetail.bdatedriv3)
                nv_dage     = nv_drivage3
                nv_doccup   = trim(wdetail.occupdriv3) 
                nv_ddriveno = trim(wdetail.licenno3)
                nv_drivexp  = trim(wdetail.licenex3)
                nv_dconsent = "" /*TRIM(wdrive.dconsen3) */ 
                nv_dlevel   = IF INTE(wdetail.drivlevel3) = 0 THEN 1 ELSE INTE(wdetail.drivlevel3)  
                wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
                nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                              ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
        RUN proc_mailtxt.
    END.

    IF wdetail.bdatedriv4 <> " "  AND wdetail.drivename4 <> " " THEN DO: 
        ASSIGN nv_drivname = "" 
               nv_drivname = TRIM(wdetail.drivename4) .
        RUN proc_clearmailtxt .
        if nv_drivage4 < year(today) then do:
            nv_drivage4 =  YEAR(TODAY) - nv_drivage4  .
            ASSIGN nv_dribirth    = STRING(DATE(wdetail.bdatedriv4),"99/99/9999") /* ค.ศ. */
                   nv_drivbir4    = STRING(INT(SUBSTR(wdetail.bdatedriv4,7,4))  + 543 )
                   wdetail.bdatedriv4 = SUBSTR(wdetail.bdatedriv4,1,6) + nv_drivbir4
                   wdetail.bdatedriv4 = STRING(DATE(wdetail.bdatedriv4),"99/99/9999") . /* พ.ศ. */
        END.
        ELSE DO:
            nv_drivage4 =  YEAR(TODAY) - (nv_drivage4 - 543).
            ASSIGN nv_drivbir4    = STRING(INT(SUBSTR(wdetail.bdatedriv4,7,4)))
                   nv_dribirth    = SUBSTR(wdetail.bdatedriv4,1,6) + STRING((INTE(nv_drivbir4) - 543),"9999")  /* ค.ศ. */
                   wdetail.bdatedriv4 = SUBSTR(wdetail.bdatedriv4,1,6) + nv_drivbir4   
                   wdetail.bdatedriv4 = STRING(DATE(wdetail.bdatedriv4),"99/99/9999")  . /* พ.ศ. */
        END.
        ASSIGN  n_count        = 4
                nv_drinam   = trim(wdetail.drivename4) /*nv_ntitle + " " + nv_name  + " " + nv_lname*/
                nv_dicno    = TRIM(wdetail.driveno4)   
                nv_dgender  = trim(wdetail.sexdriv4) 
                nv_dbirth   = trim(wdetail.bdatedriv4)
                nv_dage     = nv_drivage4
                nv_doccup   = trim(wdetail.occupdriv4) 
                nv_ddriveno = trim(wdetail.licenno4)
                nv_drivexp  = trim(wdetail.licenex4) 
                nv_dconsent = "" /*TRIM(wdrive.dconsen4) */ 
                nv_dlevel   = IF INTE(wdetail.drivlevel4) = 0 THEN 1 ELSE INTE(wdetail.drivlevel4)  
                wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
                nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                              ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
        RUN proc_mailtxt.
    END.

    IF wdetail.bdatedriv5 <> " "  AND wdetail.drivename5 <> " " THEN DO:
        ASSIGN nv_drivname = "" 
               nv_drivname = TRIM(wdetail.drivename5) .

        RUN proc_clearmailtxt .
        if nv_drivage5 < year(today) then do:
            nv_drivage5 =  YEAR(TODAY) - nv_drivage5  .
            ASSIGN nv_dribirth    = STRING(DATE(wdetail.bdatedriv5),"99/99/9999") /* ค.ศ. */
                   nv_drivbir5    = STRING(INT(SUBSTR(wdetail.bdatedriv5,7,4))  + 543 )
                   wdetail.bdatedriv5 = SUBSTR(wdetail.bdatedriv5,1,6) + nv_drivbir5
                   wdetail.bdatedriv5 = STRING(DATE(wdetail.bdatedriv5),"99/99/9999") . /* พ.ศ. */
        END.
        ELSE DO:
            nv_drivage5 =  YEAR(TODAY) - (nv_drivage5 - 543).
            ASSIGN nv_drivbir5    = STRING(INT(SUBSTR(wdetail.bdatedriv5,7,4)))
                   nv_dribirth    = SUBSTR(wdetail.bdatedriv5,1,6) + STRING((INTE(nv_drivbir5) - 543),"9999")  /* ค.ศ. */
                   wdetail.bdatedriv5 = SUBSTR(wdetail.bdatedriv5,1,6) + nv_drivbir5   
                   wdetail.bdatedriv5 = STRING(DATE(wdetail.bdatedriv5),"99/99/9999")  . /* พ.ศ. */
        END.
        ASSIGN  n_count        = 5
                nv_drinam   = trim(wdetail.drivename5) 
                nv_dicno    = TRIM(wdetail.driveno5)
                nv_dgender  = trim(wdetail.sexdriv5) 
                nv_dbirth   = trim(wdetail.bdatedriv5)
                nv_dage     = nv_drivage5
                nv_doccup   = trim(wdetail.occupdriv5) 
                nv_ddriveno = trim(wdetail.licenno5)
                nv_drivexp  = trim(wdetail.licenex5) 
                nv_dconsent = "" /*TRIM(wdrive.dconsen5) */ 
                nv_dlevel   = IF INTE(wdetail.drivlevel5) = 0 THEN 1 ELSE INTE(wdetail.drivlevel5) 
                wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
                nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                              ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
        RUN proc_mailtxt.
    END.
  END. /*note add for mailtxt 07/11/2005*/
  /*-----nv_drivcod---------------------*/
  ASSIGN nv_drivcod = ""
         nv_drivvar = ""
         nv_drivvar1 = "".
         nv_drivvar2 = "".
  IF wdetail.drivnam1 = "" THEN ASSIGN  nv_drivno = 0.
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
        /*IF (wdetail.prepol = "") THEN RUN proc_usdcod.
        ELSE RUN proc_usdcodrenew.*/
        IF wdetail.drivnam1 <> "" THEN RUN proc_usdcod.
        ELSE RUN proc_usdcodrenew. /* Ranu i. F67-0001*/
    END.
    ELSE DO:
        ASSIGN nv_drivcod = "AL0" + TRIM(wdetail.drilevel).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_findredbook c-Win 
PROCEDURE proc_findredbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_rsimin  AS INTE FORMAT ">>>,>>>,>>>,>>9".
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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initcal c-Win 
PROCEDURE proc_initcal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  add by A67-0162     
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
         /* A67-0029*/
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
    /*putchr    = "" */
    /* putchr1  = ""*/
    nv_typ      = ""
    nv_usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4) 
    nv_transfer = YES.
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
        sicsyac.xmm600.icno     = TRIM(n_icno)              /*IC No.*//*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.addr1)       /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.addr2)      /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.addr3)       /*Address line 3*/
        sicsyac.xmm600.addr4    = TRIM(wdetail.addr4)     
        sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
        sicsyac.xmm600.opened   = TODAY                     
        sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid .                
        /*sicsyac.xmm600.dtyp20   = "DOB"                   
        sicsyac.xmm600.dval20   = trim(wdetail.brithday)*/  /*-- Add chutikarn A50-0072 --*/
    /*RETURN.*//*A56-0323*/
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
        sicsyac.xmm600.icno     = TRIM(n_icno)              /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = tRIM(wdetail.addr1)    /*Address line 1*/
        sicsyac.xmm600.addr2    = tRIM(wdetail.addr2)    /*Address line 2*/
        sicsyac.xmm600.addr3    = tRIM(wdetail.addr3)    /*Address line 3*/
        sicsyac.xmm600.addr4    = tRIM(wdetail.addr4)    /*Address line 4*/
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
        sicsyac.xmm600.phone    = TRIM(wdetail.tel)         /*Phone no.*/
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
        sicsyac.xmm600.dtyp20   = "DOB"
        sicsyac.xmm600.dval20   = wdetail.bdate   .

    FIND LAST wtxt WHERE wtxt.policy = wdetail.policy AND wtxt.poltyp = wdetail.poltyp NO-LOCK NO-ERROR. 
        IF AVAIL wtxt THEN DO:
            IF trim(wtxt.payname) <> TRIM(wdetail.insnam) THEN 
                ASSIGN  SUBSTRING(sicsyac.xmm600.nphone,1,60)  =  trim(wtxt.paytitle) + " " + trim(wtxt.payname)  /*ชื่อ 1*/
                        SUBSTRING(sicsyac.xmm600.nphone,61,60) =  ""                                  /*ชื่อ 2*/
                        sicsyac.xmm600.naddr1                  =  trim(wtxt.addrpay1)                       /*ที่อยู่ */
                        sicsyac.xmm600.naddr2                  =  trim(wtxt.addrpay2)                       /*ที่อยู่ */
                        sicsyac.xmm600.naddr3                  =  trim(wtxt.addrpay3)                       /*ที่อยู่ */
                        sicsyac.xmm600.naddr4                  =  trim(wtxt.addrpay4)                       /*ที่อยู่ */
                        sicsyac.xmm600.dtyp20                  =  ""                                  /*Vat head*/
                        SUBSTRING(sicsyac.xmm600.anlyc1,1,14)  =  trim(wtxt.payic)                          /*ic no*/
                        SUBSTRING(sicsyac.xmm600.anlyc1,20,5)  =  "00000" .                           /*branch */
        END.
    
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
            sicsyac.xtm600.addr1   = TRIM(wdetail.addr1) /*address line 1*/
            sicsyac.xtm600.addr2   = TRIM(wdetail.addr2)  /*address line 2*/
            sicsyac.xtm600.addr3   = TRIM(wdetail.addr3) /*address line 3*/
            sicsyac.xtm600.addr4   = TRIM(wdetail.addr4)   /*address line 4*/
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
    sicsyac.xmm600.acno_typ  = TRIM(wdetail.insnamtyp)   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    sicsyac.xmm600.icno      = trim(wdetail.icno)       
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/  .  
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
ASSIGN nv_insref = "" .

FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
    sicsyac.xzm056.seqtyp   =  nv_typ          AND
    sicsyac.xzm056.branch   =  wdetail.branch  NO-LOCK NO-ERROR .
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
            end....comment by Kridtiya i. A56-0323....*/
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
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       wdetail.branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").*/
            /*kridtiya i. A56-0323*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (wdetail.branch = "A") OR (wdetail.branch = "B") THEN DO:
                    nv_insref  = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref = "0" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
            END.
            ELSE DO:
                IF (wdetail.branch = "A") OR (wdetail.branch = "B") THEN DO:
                     nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref=        wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
            END.   /*kridtiya i. A56-0323*/
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
            /* IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.branch + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       wdetail.branch + "C" + String(sicsyac.xzm056.lastno,"99999").*/
            /*add by Kridtiya i. A56-0323....*/
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
                ELSE nv_insref=        wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
            END.  /*add by Kridtiya i. A56-0323....*/
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
                 brstat.mailtxt_fil.occupcod   = "-" 
                 brstat.mailtxt_fil.drividno   = nv_dicno
                 brstat.mailtxt_fil.licenno    = nv_ddriveno
                 brstat.mailtxt_fil.gender     = nv_dgender
                 brstat.mailtxt_fil.drivlevel  = nv_dlevel
                 brstat.mailtxt_fil.levelper   = deci(nv_dlevper)
                 brstat.mailtxt_fil.licenexp   = IF trim(nv_drivexp) <> "" THEN DATE(nv_drivexp) ELSE ?
                 brstat.mailtxt_fil.dconsen    = IF nv_dconsent = "N" OR nv_dconsent = " " THEN NO ELSE YES 
                 brstat.mailtxt_fil.occupdes   = IF nv_doccup  = "" THEN "-" ELSE nv_doccup
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
             brstat.mailtxt_fil.occupcod   = "-"  
             brstat.mailtxt_fil.drividno   = nv_dicno
             brstat.mailtxt_fil.licenno    = nv_ddriveno
             brstat.mailtxt_fil.gender     = nv_dgender
             brstat.mailtxt_fil.drivlevel  = nv_dlevel
             brstat.mailtxt_fil.levelper   = deci(nv_dlevper)
             brstat.mailtxt_fil.licenexp   = IF trim(nv_drivexp) <> "" THEN DATE(nv_drivexp) ELSE ?
             brstat.mailtxt_fil.dconsen    = IF nv_dconsent = "N" OR nv_dconsent = " " THEN NO ELSE YES 
             brstat.mailtxt_fil.occupdes   = IF nv_doccup  = "" THEN "-" ELSE nv_doccup
             brstat.mailtxt_fil.cardflg    = "" .
    END.
    RELEASE brstat.mailtxt_fil .
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
    Find LAST stat.maktab_fil Use-index  maktab04 Where
        stat.maktab_fil.makdes                =   n_brand      And                  
        index(stat.maktab_fil.moddes,n_model) <>  0            And
        stat.maktab_fil.makyea                =   Integer(wdetail.caryear) AND
        stat.maktab_fil.sclass                =     wdetail.subclass        AND
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook         =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.engine  =  stat.maktab_fil.engine
        nv_engine               =  stat.maktab_fil.engine.
END.
ELSE DO:
    Find LAST stat.maktab_fil Use-index      maktab04           Where
        stat.maktab_fil.makdes                =    n_brand      And                  
        index(stat.maktab_fil.moddes,n_model) <>   0            And
        stat.maktab_fil.makyea                =    Integer(wdetail.caryear) AND
        stat.maktab_fil.sclass                =    wdetail.subclass         AND
       /* (stat.maktab_fil.si - (stat.maktab_fil.si * 30 / 100 ) LE deci(wdetail.si)   AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * 30 / 100 ) GE deci(wdetail.si) ) AND*/
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook         =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.engine  =  stat.maktab_fil.engine
        nv_engine               =  stat.maktab_fil.engine.
END.
IF wdetail.model = "commuter" THEN wdetail.seat = 16.

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
IF wdetail.model = "commuter" THEN wdetail.seat = 12.
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
IF wdetail.model = "commuter" THEN wdetail.seat = 16.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_model_brand c-Win 
PROCEDURE proc_model_brand :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF chkred = NO THEN DO:
    ASSIGN   /*wdetail.model   = wdetail.brand */
        n_brand       = wdetail.brand
        wdetail.brand = substr(n_brand,1,INDEX(n_brand," ") - 1)
        n_index       = INDEX(n_brand," ") + 1
        n_model       = substr(n_brand,n_index).
    IF INDEX(n_model," ") <> 0 THEN 
        n_model = substr(n_model,1,INDEX(n_model," ") - 1).
    wdetail.model  = n_model.
    IF index(wdetail.brand,"benz") <> 0 THEN DO: 
        ASSIGN wdetail.brand = "MERCEDES-BENZ".
        IF wdetail.model = "cls" THEN wdetail.model = "CLS250".
    END.
    /*IF index(wdetail.model,"cab4") <> 0 THEN wdetail.model = "cab".*/
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
DEF VAR nv_chkdate  AS CHAR FORMAT "x(15)".
DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER  INIT  0. 
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
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002    WHERE
            sicuw.uwm100.cedpol =  wdetail.Account_no AND
            sicuw.uwm100.poltyp =  wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF (sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? /*OR  sicuw.uwm100.releas = YES*/ ) AND
               (sicuw.uwm100.expdat > date(wdetail.comdat))     THEN DO: 
                    ASSIGN wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                    wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            END.
            
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
    END.      /*wdetail.stk  <>  ""*/
    ELSE DO:  /*sticker = ""*/ 
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol = wdetail.Account_no AND
            sicuw.uwm100.poltyp = wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT. 
        IF AVAIL sicuw.uwm100 THEN DO:
            IF (sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? ) AND
               (sicuw.uwm100.expdat > date(wdetail.comdat))     THEN DO:
                ASSIGN  wdetail.pass = "N"
                wdetail.comment      = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning      = "Program Running Policy No. ให้ชั่วคราว".
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
ELSE DO:  /*wdetail.policy = ""*/
    IF wdetail.stk  <>  ""  THEN DO:
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol = wdetail.Account_no AND
            sicuw.uwm100.poltyp = wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF ( sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES )
                AND (sicuw.uwm100.expdat > date(wdetail.comdat)) THEN 
                ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| 04หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
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
IF AVAIL  sicsyac.xmm031 THEN nv_dept = sicsyac.xmm031.dept.
IF (wdetail.poltyp = "V70") AND (wdetail.Docno <> "")  THEN 
    ASSIGN nv_docno  = wdetail.Docno
    nv_accdat = TODAY.
ELSE DO:
        IF wdetail.docno  = "" THEN nv_docno  = "".
        IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
IF wdetail.poltyp = "v72" THEN wdetail.benname = "".
IF DECI(substr(wdetail.comdat,7,4)) > (YEAR(TODAY) + 2)  THEN
    wdetail.comdat = substr(wdetail.comdat,1,6) + STRING(DECI(substr(wdetail.comdat,7,4)) - 543).
IF DECI(substr(wdetail.expdat,7,4)) > (YEAR(TODAY) + 3)  THEN
    wdetail.expdat = substr(wdetail.expdat,1,6) + STRING(DECI(substr(wdetail.expdat,7,4)) - 543).
ASSIGN 
    n_icno  = ""
    n_icno  = wdetail.icno
    n_icno  = REPLACE(n_icno,"'","").
/* create by A60-0405 */
IF LENGTH(n_icno) < 13 THEN DO:
    ASSIGN  wdetail.pass    = "Y"
            wdetail.warning = "เลขบัตรประชาชนไม่ครบ 13 หลัก ".
END.
/* end A60-0405 */
RUN proc_insnam.     /* by Kridtiya i...A56-0323... */
RUN proc_insnam2 .  /*Add by Kridtiya i. A63-0472*/
DO TRANSACTION:
    ASSIGN
        sic_bran.uwm100.renno  = ""
        sic_bran.uwm100.endno  = ""
        sic_bran.uwm100.poltyp = wdetail.poltyp
        sic_bran.uwm100.insref = trim(nv_insref)
        sic_bran.uwm100.opnpol = ""
        sic_bran.uwm100.anam2  = trim(n_icno)                
        sic_bran.uwm100.ntitle = trim(wdetail.tiname)        
        sic_bran.uwm100.name1  = TRIM(wdetail.insnam)        
        sic_bran.uwm100.name2  = "" /*trim(wdetail.receipt_name) */ 
        sic_bran.uwm100.name3  = ""                 
        sic_bran.uwm100.addr1  = trim(wdetail.addr1)         
        sic_bran.uwm100.addr2  = trim(wdetail.addr2)  
        sic_bran.uwm100.addr3  = TRIM(wdetail.addr3)   
        sic_bran.uwm100.addr4  = trim(wdetail.addr4) 
        sic_bran.uwm100.postcd = "" 
        sic_bran.uwm100.undyr  = String(Year(today),"9999") 
        sic_bran.uwm100.branch = caps(trim(wdetail.branch))           
        sic_bran.uwm100.dept   = nv_dept                    
        sic_bran.uwm100.usrid  = USERID(LDBNAME(1))         
        sic_bran.uwm100.fstdat = DATE(wdetail.comdat)       
        sic_bran.uwm100.comdat = DATE(wdetail.comdat)       
        sic_bran.uwm100.expdat = date(wdetail.expdat)       
        sic_bran.uwm100.accdat = nv_accdat   
        /*sic_bran.uwm100.tranty = "N"*/    /*A61-0573 */
        sic_bran.uwm100.tranty = IF trim(wdetail.prepol) <> "" THEN "R" ELSE "N"     /*A61-0573 */                   
        sic_bran.uwm100.langug = "T"
        sic_bran.uwm100.acctim = "00:00"
        sic_bran.uwm100.trty11 = "M"      
        sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")     
        sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")
        sic_bran.uwm100.entdat = TODAY
        sic_bran.uwm100.curbil = "BHT"
        sic_bran.uwm100.curate = 1
        sic_bran.uwm100.instot = 1
        sic_bran.uwm100.prog   = "wgwntlay"
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
        sic_bran.uwm100.acno1  = trim(wdetail.producer)  /*  nv_acno1 */
        sic_bran.uwm100.agent  = trim(wdetail.agent)    /*nv_agent   */
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
        sic_bran.uwm100.dir_ri = YES
        sic_bran.uwm100.drn_p  = NO
        sic_bran.uwm100.sch_p  = NO
        sic_bran.uwm100.cr_2   = trim(wdetail.cr_2)
        sic_bran.uwm100.bchyr  = nv_batchyr               /*Batch Year */  
        sic_bran.uwm100.bchno  = nv_batchno               /*Batch No.  */  
        sic_bran.uwm100.bchcnt = nv_batcnt                /*Batch Count*/  
        sic_bran.uwm100.prvpol = trim(wdetail.prepol)     /*A52-0172*/
        sic_bran.uwm100.cedpol = trim(wdetail.Account_no)  
        /*sic_bran.uwm100.finint = "" /*wdetail.deler*/   */ /*A65-0115*/
        sic_bran.uwm100.finint = trim(wdetail.dealer)        /*A65-0115*/
        sic_bran.uwm100.cr_1   = ""    /* Product */
        sic_bran.uwm100.opnpol = ""   /* promo */
        sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)   /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)    /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.postcd     = trim(wdetail.postcd)      /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.icno       = trim(wdetail.icno)        /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)     /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)   /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)   /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)   /*Add by Kridtiya i. A63-0472*/
        /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*//*Add by Kridtiya i. A63-0472*/
        /*sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov)*/  /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.campaign   = trim(wdetail.producer)      /*A66-0160 */
        sic_bran.uwm100.dealer     = trim(wdetail.financecd).    /*Add by Kridtiya i. A63-0472*/ 

    nv_chkdate = "" .     
    FIND LAST wtxt WHERE wtxt.policy = wdetail.policy AND wtxt.poltyp = wdetail.poltyp NO-ERROR .
        IF AVAIL wtxt THEN DO:
           ASSIGN nv_chkdate   = IF INDEX(wtxt.paydate,"วันที่รับชำระเงิน : ") <> 0 THEN TRIM(SUBSTR(wtxt.paydate,20,LENGTH(wtxt.paydate))) 
                                 ELSE TRIM(wtxt.paydate)  /* Product */
                  nv_chkdate   = SUBSTR(nv_chkdate,1,6) + SUBSTR(nv_chkdate,9,2)
                  sic_bran.uwm100.cr_1 =  nv_chkdate .
           ASSIGN nv_chkdate   = ""   
                  nv_chkdate   = IF INDEX(wtxt.not_date,"วันที่แจ้งงาน : ") <> 0 THEN trim(SUBSTR(wtxt.not_date,16,LENGTH(wtxt.not_date))) 
                                 ELSE TRIM(wtxt.not_date) /* promo */
                  nv_chkdate   = SUBSTR(nv_chkdate,1,6) + SUBSTR(nv_chkdate,9,2)
                  sic_bran.uwm100.opnpol = IF trim(wdetail.producer) = "A0M0062" THEN "12+ " + nv_chkdate ELSE nv_chkdate.
        END.
       
    IF wdetail.pass = "Y" THEN
         sic_bran.uwm100.impflg  = YES.
    ELSE sic_bran.uwm100.impflg  = NO.
    IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN 
        sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
    IF wdetail.cancel = "ca" THEN
        sic_bran.uwm100.polsta = "CA" .
    ELSE  
        sic_bran.uwm100.polsta = "IF".
    IF fi_loaddat <> ? THEN  sic_bran.uwm100.trndat = fi_loaddat.
    ELSE  sic_bran.uwm100.trndat = TODAY.
    sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
    nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                      (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                      (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                  ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.                    
END.   /*transaction*//**/
IF wdetail.poltyp = "V70" THEN DO:
    RUN proc_uwd102.
END.
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
        sic_bran.uwm120.class  = IF wdetail.poltyp = "v72" THEN wdetail.subclass ELSE wdetail.prempa + wdetail.subclass 
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
          sicuw.uwm100.policy = wdetail.prepol   No-lock No-error no-wait.
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
        ASSIGN  wdetail.prepol = sicuw.uwm100.policy
            n_rencnt  =  sicuw.uwm100.rencnt  +  1
            n_endcnt  =  0
            wdetail.pass  = "Y".
        RUN proc_assignrenew.      /*รับค่า ความคุ้มครองของเก่า */
    END.
END.   /*  avail  uwm100  */
Else do:  
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0
        wdetail.prepol   = ""
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
    "redbook   "  ","
    "policy    "  ","  
    "cndat     "  ","  
    "comdat    "  ","  
    "expdat    "  ","  
    "covcod    "  ","  
    "garage    "  ","  
    "tiname    "  ","  
    "insnam    "  ","  
    "addr1     "  ","  
    "addr2     "  ","  
    "addr3     "  ","  
    "addr4     "  ","  
    "brand     "  ","  
    "cargrp    "  ","  
    "chasno    "  ","  
    "eng       "  ","  
    "model     "  ","  
    "caryear   "  ","  
    "body      "  ","  
    "vehuse    "  ","  
    "seat      "  ","  
    "engcc     "  ","  
    "vehreg    "  ","  
    "re_country"  ","  
    "si        "  ","  
    "prem1     "  ","  
    "gross_prm "  ","  
    "stamp     "  ","  
    "vat       "  ","  
    "premtotal "  ","  
    "deduct    "  ","  
    "fleetper  "  ","  
    "ncb       "  ","  
    "drivper   "  ","  
    "othper    "  ","  
    "cctvper   "  ","  
    "Surcharper"  ","  
    "drivnam   "  ","  
    "stk       "  ","  
    "prepol    "  ","  
    "benname   "  ","  
    "comper    "  ","  
    "comacc    "  ","  
    "deduct    "  ","   
    "compul    "  ","   
    "pass      "  ","   
    "comment   "  ","   
    "WARNING    "  SKIP.                                                   
FOR EACH  wdetail  WHERE wdetail.PASS <> "Y"    :   
        PUT STREAM ns1 
        wdetail.redbook     "," 
        wdetail.policy      "," 
        wdetail.cndat       "," 
        wdetail.comdat      "," 
        wdetail.expdat      "," 
        wdetail.covcod      "," 
        wdetail.garage      "," 
        wdetail.tiname      "," 
        wdetail.insnam      "," 
        wdetail.addr1       ","  
        wdetail.addr2       ","  
        wdetail.addr3       ","  
        wdetail.addr4       ","  
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
        wdetail.prem1       "," 
        wdetail.gross_prm   "," 
        wdetail.stamp       ","
        wdetail.vat         ","
        wdetail.premtotal   ","
        wdetail.deduct      ","
        wdetail.fleetper    ","
        wdetail.ncb         ","
        wdetail.drivper     ","
        wdetail.othper      ","
        wdetail.cctvper     ","
        wdetail.Surcharper  ","
        wdetail.drivnam     ","
        wdetail.stk         "," 
        wdetail.prepol      "," 
        wdetail.benname     ","   
        wdetail.comper      ","   
        wdetail.comacc      ","   
        wdetail.deduct      ","   
        wdetail.compul      ","   
        wdetail.pass        ","     
        wdetail.comment     "," 
        wdetail.WARNING  SKIP.  
    
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
    "redbook    "    ","             
    "policy     "    ","        
    "cndat      "    ","        
    "comdat     "    ","        
    "expdat     "    ","        
    "covcod     "    ","        
    "garage     "    ","
    "tiname     "    ","        
    "insnam     "    ","         
    "bdate      "    ","        
    "icno       "    ","        
    "addr1      "    ","        
    "addr2      "    ","        
    "addr3      "    ","        
    "addr4      "    ","        
    "brand      "    ","        
    "cargrp     "    ","        
    "chasno     "    ","        
    "eng        "    ","        
    "model      "    ","        
    "caryear    "    ","        
    "body       "    ","        
    "vehuse     "    ","        
    "seat       "    ","        
    "engcc      "    ","        
    "vehreg     "    ","        
    "re_country "    ","        
    "si         "    ","        
    "premt      "    ","        
    "stamp      "    ","        
    "vat        "    ","        
    "premtotal  "    ","        
    "deduct     "    ","        
    "fleetper   "    ","        
    "ncb        "    ","        
    "drivper    "    ","        
    "othper     "    ","        
    "cctvper    "    ","        
    "Surcharper "    ","        
    "stk        "    ","        
    "prepol     "    ","        
    "benname    "    ","        
    "comper     "    ","
    "comacc     "    "," 
    "compul     "    "," 
    "pass       "    "," 
    "comment    "    "," 
    "WARNING    "    SKIP.        
FOR EACH  wdetail   WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
            wdetail.redbook    ","   
            wdetail.policy     ","
            wdetail.cndat      ","
            wdetail.comdat     ","
            wdetail.expdat     ","
            wdetail.covcod     ","
            wdetail.garage     "," 
            wdetail.tiname     ","
            wdetail.insnam     ","
            wdetail.bdate      ","  
            wdetail.icno       ","    
            wdetail.addr1      ","  
            wdetail.addr2      ","  
            wdetail.addr3      ","  
            wdetail.addr4      ","  
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
            wdetail.stamp      ","
            wdetail.vat        ","
            wdetail.premtotal  ","
            wdetail.deduct     ","
            wdetail.fleetper   ","
            wdetail.ncb        ","
            wdetail.drivper    ","
            wdetail.othper     ","
            wdetail.cctvper    ","
            wdetail.Surcharper ","
            wdetail.stk        ","
            wdetail.prepol     ","
            wdetail.benname    ","   
            wdetail.comper     ","   
            wdetail.comacc     ","
            wdetail.compul     ","   
            wdetail.pass       ","     
            wdetail.comment    ","
            wdetail.WARNING    SKIP.  

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
FORM
    gv_id  LABEL " User Id " colon 35 SKIP
    nv_pwd LABEL " Password" colon 35 BLANK
    WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY width 80
    TITLE   " Connect DB Expiry System"  . 
/*HIDE ALL NO-PAUSE.*/ /*note block*/
STATUS INPUT OFF.
/*
{s0/s0sf1.i}
*/
gv_prgid = "GWNEXP01".

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

  IF LASTKEY = KEYCODE("f1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/
      CONNECT expiry -H TMSTH -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.    /* new real server */ 
      /*CONNECT expiry -H devserver -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. */ /*Test*/
      
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
            wdetail.comment = "รถผู้เอาประกัน ติด suspect ทะเบียน " + nn_vehreglist + " กรุณาติดต่อฝ่ายรับประกัน" 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_usdcodrenew c-Win 
PROCEDURE proc_usdcodrenew :
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
/*DEF VAR nv_bptr  AS RECID.
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
    nv_txt6  = ""  
    nv_txt7  = "" 
    nv_txt8  = "" .

FIND LAST wtxt WHERE wtxt.policy = wdetail.policy AND wtxt.poltyp = wdetail.poltyp NO-LOCK NO-ERROR.
IF AVAIL wtxt THEN DO:
        ASSIGN nv_txt1  = wtxt.noti_no 
               nv_txt2  = "รหัสลูกค้า : " + wdetail.inscode
               nv_txt3  = "ประเภทการจ่ายเงิน : " + wtxt.pmenttyp + " ช่องทางการจ่าย : " + wtxt.pmentcode2
               nv_txt4  = wtxt.inspdate  +  " "  + wtxt.inspdate_app   
               nv_txt5  = wtxt.inspsts
               nv_txt6  = wtxt.inspdetail     
               nv_txt7  = wtxt.licenBroker + " " + wtxt.brokname + " " + wtxt.brokcode   
               nv_txt8  = "" .
    END.

DO WHILE nv_line1 <= 10:      /*A60-0225*/
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
    IF nv_line1 = 6  THEN wuppertxt.txt = nv_txt6.
    IF nv_line1 = 7  THEN wuppertxt.txt = nv_txt7.
    IF nv_line1 = 8  THEN wuppertxt.txt = nv_txt8.
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
IF AVAILABLE sic_bran.uwm100 THEN DO:
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
END. */    /*uwm100*/ 
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
ASSIGN nv_fptr = 0
       nv_bptr = 0
       nv_nptr = 0
       nv_line1 = 1.
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
FIND LAST wtxt WHERE wtxt.policy = wdetail.policy AND wtxt.poltyp = wdetail.poltyp NO-ERROR .
IF AVAIL wtxt THEN DO:
    IF trim(wtxt.damang1) = "" AND trim(wtxt.damang2) = "" AND trim(wtxt.damang3) = "" THEN DO:
        ASSIGN wtxt.damang1 = trim(wtxt.dataoth) 
               wtxt.dataoth = "" .
    END.
    ELSE IF trim(wtxt.damang1) <> "" AND trim(wtxt.damang2) = "" AND trim(wtxt.damang3) = "" THEN DO: 
        ASSIGN wtxt.damang1 = trim(wtxt.damang1) 
               wtxt.damang2 = trim(wtxt.dataoth)
               wtxt.dataoth = "" .
    END.
    ELSE IF trim(wtxt.damang1) <> "" AND trim(wtxt.damang2) <> "" AND trim(wtxt.damang3) = "" THEN DO: 
        ASSIGN wtxt.damang1 = trim(wtxt.damang1) 
               wtxt.damang2 = trim(wtxt.damang2)
               wtxt.damang3 = trim(wtxt.dataoth)
               wtxt.dataoth = "" .
    END.
    
    /*DO WHILE nv_line1 <= 20:*/ /*A67-0162*/
    DO WHILE nv_line1 <= 25: /*A67-0162*/
        CREATE wuppertxt3.
        wuppertxt3.line = nv_line1.
        IF nv_line1 = 1   THEN wuppertxt3.txt = "" .
        /*IF nv_line1 = 2   THEN wuppertxt3.txt = "รหัสแคมเปญ : " + wdetail.campcode.  */
        IF nv_line1 = 2   THEN wuppertxt3.txt = trim(wtxt.noti_no).
        IF nv_line1 = 3   THEN wuppertxt3.txt = "รหัสแคมเปญ AY : " + wdetail.procode + "  " + wdetail.proname .
        IF nv_line1 = 4   THEN wuppertxt3.txt = "รหัสลูกค้า : " + wdetail.inscode.
        IF nv_line1 = 5   THEN wuppertxt3.txt = "ผู้รับผลประโยชน์ : " + trim(wdetail.benname) .
        IF nv_line1 = 6   THEN wuppertxt3.txt = "ประเภทการจ่ายเงิน : " + wtxt.pmenttyp + " ช่องทางการจ่าย : " + wtxt.pmentcode2.     
        IF nv_line1 = 7   THEN wuppertxt3.txt = wtxt.inspdate  +  " "  + wtxt.inspdate_app .                                         
        IF nv_line1 = 8   THEN wuppertxt3.txt = wtxt.inspsts.                                                                        
        IF nv_line1 = 9   THEN wuppertxt3.txt = wtxt.inspdetail   .                                                                  
        IF nv_line1 = 10  THEN wuppertxt3.txt = wtxt.licenBroker + " " + wtxt.brokname + " " + wtxt.brokcode   .                     
        IF nv_line1 = 11  THEN wuppertxt3.txt = trim(wtxt.not_date) + " " + trim(wtxt.paydate) + " " + trim(wtxt.paysts) .           
        IF nv_line1 = 12  THEN wuppertxt3.txt = trim(wtxt.deli)  + " " + trim(wtxt.delidetail).                                      
        IF nv_line1 = 13  THEN wuppertxt3.txt = trim(wtxt.gift) + " " + trim(wtxt.remark) .                                          
        IF nv_line1 = 14  THEN wuppertxt3.txt = trim(wtxt.inspno) .                                                                  
        IF nv_line1 = 15  THEN wuppertxt3.txt = trim(wtxt.remarkinsp) .                                                              
        IF nv_line1 = 16  THEN wuppertxt3.txt = trim(wtxt.damang1) .                                                                 
        IF nv_line1 = 17  THEN wuppertxt3.txt = trim(wtxt.damang2) .                                                                 
        IF nv_line1 = 18  THEN wuppertxt3.txt = trim(wtxt.damang3) .                                                                 
        IF nv_line1 = 19  THEN wuppertxt3.txt = trim(wtxt.dataoth) .
        IF nv_line1 = 20  THEN wuppertxt3.txt = "เลขเครื่อง 3 : " + trim(wdetail.evmotor3) . /*A67-0162*/
        IF nv_line1 = 21  THEN wuppertxt3.txt = "เลขเครื่อง 4 : " + trim(wdetail.evmotor4) . /*A67-0162*/
        IF nv_line1 = 22  THEN wuppertxt3.txt = "เลขเครื่อง 5 : " + trim(wdetail.evmotor5) . /*A67-0162*/
        
       nv_line1 = nv_line1 + 1.               
    END.
END.

/*IF nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? THEN DO:
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
ELSE DO:*/
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
/*END.*/
sic_bran.uwm100.bptr02 = nv_bptr.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_uwm100 c-Win 
PROCEDURE Proc_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by A63-0129...
IF wdetail.gross_prm  <> "" THEN DO:  /*กรณี ต้องการ ให้ได้เบี้ย ตามไฟล์ */
    IF (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) >= 365 ) AND
       (( DATE(wdetail.expdat)  - DATE(wdetail.comdat) ) <= 366 ) THEN
        ASSIGN 
            nv_gapprm  = deci(wdetail.gross_prm)
            nv_pdprm   = nv_gapprm .
   ELSE  /*เบี้ย ไม่เต็มปี หรือ เกินปี */
        ASSIGN nv_pdprm  = deci(wdetail.gross_prm) .
END.
*/
FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN  
         sic_bran.uwm100.prem_t = nv_pdprm          /* A57-0426 *//*เบี้ย ไม่เต็มปี หรือ เกินปี */
         sic_bran.uwm100.sigr_p = inte(wdetail.si)
         sic_bran.uwm100.gap_p  = nv_gapprm.

     IF wdetail.pass <> "Y" THEN 
         ASSIGN
         sic_bran.uwm100.impflg = NO
         sic_bran.uwm100.imperr = wdetail.comment.    
     
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

