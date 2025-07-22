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
/*programid   : wgwtbgen.w                                              */ 
/*programname : load text file Tisco to GW                              */ 
/* Copyright  : Safety Insurance Public Company Limited                 */
/*copy write  : wgwargen.w                                              */ 
/*              ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)                      */
/*create by   : Kridtiya i. A52-0207  date . 14/06/2010                
                ��Ѻ������������ö����� text file Tisco to GW system */
/*Modify by   : Kridtiya i. A54-0141 ��Ѻ�ӹ�˹�ҹ������礡Ѻ����� settitle date 24/05/2011 */
/*Modify by   : Kridtiya i. A54-0184 ��Ѻ����ʴ�������� */
/*Modify by   : Kridtiya i. A55-0267 ��Ѻ��ä����Ţ����ѭ�� */
/*modify by   : Kridtiya i. A55-0325 ���������ż����һ�Сѹ��� insurce="" not create xmm600   */
/*modify by   : Kridtiya i. A54-0112 ���ª�ͧ����¹ö �ҡ 10 �� 11 ��ѡ          */
/*modify by   : Kridtiya i. A56-0104 ��Ѻ����Ѻ��Ҥ���ö70 /72 �������������*/
/*modify by   : Kridtiya i. A56-0146 ��������Ѻ��Ҫ��ͼ��Ѻ���             */
/*modify by   : Kridtiya i. A56-0323 ����������Ң��繤����ҧ             */
/*modify by   : kridtiya  i. A57-0017 add seat column             */
/*Modify By   : MANOP G.  A59-0178  ����¹�ŧ FORMAT �����Ŵ File   -*/
/*Modify By   : MANOP G.  A59-0503  ����¹�ŧ ���ʨѧ��Ѵ�ҡ�������繵�����   -*/
/*Modify By   : Ranu I. A60-0095 24/02/2017 �������͹䢡���礷���¹���� */
/*Modify By   : Ranu I. A60-0206 05/05/2017 ��������红����� field uwm301.drinam[1] */
/*Modify By   : Ranu I. A60-0225 05/05/2017 �������͹� CCTV ��� �� A0M1046 */
/*Modify by   : Ranu I. A60-0405 22/09/2017  �������͹䢡�����Ţ�ѵû�ЪҪ� 13 ��ѡ */
/*Modify by   : Ranu I. A61-0045 30/01/2018  ��䢡�ô֧����������ͧ�ҹ������� pack O */
/*Modify By   : Ranu I. A61-0313 29/06/2018 ��� Agent code ������� ��� Mazda MPI */
/*Modify By   : Ranu I. A61-0410 28/08/2018 ��� �ҹ��ʴ�ҵ������ MPI ���� MN30 ������ͧ��¡�͡������ */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019 Change Host => TMSth*/
/*Modify By : Ranu I. A62-0386 28/08/2019 ��� Producer �ҹ MPI */
/*Modify by : Ranu I. A63-0122 ��� Pack T �����������ͧ�����໭���  
              ���������������ִ���˹ѡö��������Ŵ */
/*modify by : Sarinya C. A63-0210 ����¹�ŧ�Layout�Text ������ field� ��ͷ��¨ҡ���  */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by : Ranu I. A64-0092 �������͹䢧ҹ Group Ford ��С�����ػ�ó������ */
/*Modify by : Ranu I. A64-0138 28/06/2021 �������͹䢧ҹ����� product promo */
/*Modify by   : Kridtiya i. A65-0356 Date. 07/01/2023 ���ª�ͧ �Ţ����ͧ�Ţ�ѧ ����¹ �� */
/*Modify by   : Kridtiya i. A66-0070 Date. 26/04/2023 ��Ѻ����ʴ�����ػ�ó������*/
/*Modify by   : Kridtiya i. A66-0196 Date. 11/09/2023 ���� �Ң�㺡ӡѺ����  */
/*Modify by   : Ranu I. A67-0087 �������͹�ö俿�� */
/*Modify by   : Ranu I. A67-0144 ��� Format file Load ��䢡���� CC, �ػ�ó������ , promo ,Product */
/*Modiby by  : Ranu I. A67-0185 ��� Class EV �ͧ �ú. /��Ǩ�ͺ�����š���͡����������к��������� �¡�����Ţ��Ƕѧ��к��������� */
{wgw\wgwtfgen.i}      /*��С�ȵ����*/
DEF VAR n_brand   AS CHAR FORMAT "x(50)"  INIT "".
DEF VAR n_model   AS CHAR FORMAT "x(50)"  INIT "".
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
DEFINE VAR nv_txt2 AS CHAR FORMAT "x(150)" . /*A60-0225*/

DEFINE VAR nv_txt3 AS CHAR FORMAT "x(150)" . /*A64-0092*/
DEFINE VAR nv_txt4 AS CHAR FORMAT "x(150)" . /*A64-0092*/
/*create by A60-0095 */
DEFINE TEMP-TABLE tbprotis 
    FIELD producer   AS CHAR FORMAT "x(10)" INIT ""      
    FIELD product    AS CHAR FORMAT "x(10)"  INIT ""      
    FIELD promo      AS CHAR FORMAT "x(10)" INIT ""  
    FIELD cover      AS CHAR FORMAT "x(3)" INIT "". /*A67-0087*/

DEF var nv_drivname AS CHAR FORMAT "x(150)" .

DEFINE var  nr_hp        AS DECI FORMAT ">>>>9.99".         /*A67-0087*/
def    var  nr_maksi     AS DECI FORMAT ">>,>>>,>>9.99-" . /*A67-0087*/ 
def    var  nr_eng_no2   AS CHAR FORMAT "x(50)" INIT "" .  /*A67-0087*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_proinsur

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tbinsurid tbprotis wdetail

/* Definitions for BROWSE br_proinsur                                   */
&Scoped-define FIELDS-IN-QUERY-br_proinsur tbinsurid.insurcode tbinsurid.insuricno   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_proinsur   
&Scoped-define SELF-NAME br_proinsur
&Scoped-define QUERY-STRING-br_proinsur FOR EACH tbinsurid
&Scoped-define OPEN-QUERY-br_proinsur OPEN QUERY {&SELF-NAME} FOR EACH tbinsurid.
&Scoped-define TABLES-IN-QUERY-br_proinsur tbinsurid
&Scoped-define FIRST-TABLE-IN-QUERY-br_proinsur tbinsurid


/* Definitions for BROWSE br_protis                                     */
&Scoped-define FIELDS-IN-QUERY-br_protis tbprotis.producer tbprotis.product tbprotis.promo   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_protis   
&Scoped-define SELF-NAME br_protis
&Scoped-define QUERY-STRING-br_protis FOR EACH tbprotis
&Scoped-define OPEN-QUERY-br_protis OPEN QUERY {&SELF-NAME} FOR EACH tbprotis.
&Scoped-define TABLES-IN-QUERY-br_protis tbprotis
&Scoped-define FIRST-TABLE-IN-QUERY-br_protis tbprotis


/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail WDETAIL.WARNING wdetail.redbook /*add new*/ wdetail.poltyp wdetail.policy wdetail.producer wdetail.agent wdetail.tiname wdetail.insnam wdetail.comdat wdetail.expdat wdetail.compul wdetail.addr1 wdetail.prempa wdetail.subclass wdetail.brand wdetail.model wdetail.engcc wdetail.seat wdetail.body wdetail.vehreg wdetail.eng wdetail.chasno wdetail.caryear wdetail.vehuse wdetail.garage wdetail.stk wdetail.covcod wdetail.si wdetail.fleet wdetail.ncb wdetail.deductpd wdetail.benname wdetail.n_IMPORT wdetail.n_export wdetail.comment wdetail.cancel   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_wdetail FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_proinsur}~
    ~{&OPEN-QUERY-br_protis}~
    ~{&OPEN-QUERY-br_wdetail}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_protis fi_loaddat fi_pack fi_chkpro ~
fi_branch fi_producer fi_agent fi_prevbat fi_bchno fi_bchyr fi_filename ~
bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit ~
bu_hpbrn bu_hpacno1 bu_hpagent br_wdetail fi_process fi_producer2 ~
bu_hpacno2 fi_compa fi_textf17 fi_camp RECT-370 RECT-372 RECT-373 RECT-376 ~
RECT-377 RECT-378 br_proinsur 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_pack fi_chkpro fi_branch ~
fi_producer fi_agent fi_prevbat fi_bchno fi_bchyr fi_filename fi_output1 ~
fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname ~
fi_impcnt fi_process fi_producer2 fi_completecnt fi_premtot fi_proname2 ~
fi_premsuc fi_compa fi_textf17 fi_camp 

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

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 14 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY .95.

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

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
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
     SIZE 20 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_chkpro AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(500)":U 
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
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_proname2 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_textf17 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

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
     SIZE 132 BY 1.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 14
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 5.76
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
DEFINE QUERY br_proinsur FOR 
      tbinsurid SCROLLING.

DEFINE QUERY br_protis FOR 
      tbprotis SCROLLING.

DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_proinsur
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_proinsur c-Win _FREEFORM
  QUERY br_proinsur DISPLAY
      tbinsurid.insurcode LABEL "INSCd" FORMAT "x(10)"  
      tbinsurid.insuricno LABEL "ICNo"  FORMAT "x(15)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 33.67 BY 3.86
         BGCOLOR 29 FGCOLOR 2 FONT 6 ROW-HEIGHT-CHARS .52.

DEFINE BROWSE br_protis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_protis c-Win _FREEFORM
  QUERY br_protis DISPLAY
      tbprotis.producer LABEL "Code" FORMAT "x(12)"  
tbprotis.product  LABEL "Product" FORMAT "x(8)"
tbprotis.promo    LABEL "Promo " FORMAT "x(8)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 38 BY 3.1
         BGCOLOR 29 FGCOLOR 2 FONT 6 ROW-HEIGHT-CHARS .52.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      WDETAIL.WARNING  COLUMN-LABEL "Warning"
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
      wdetail.vehuse   COLUMN-LABEL "Vehicle Use" 
      wdetail.garage   COLUMN-LABEL "Garage"
      wdetail.stk      COLUMN-LABEL "Sticker"
      wdetail.covcod   COLUMN-LABEL "Cover Type"
      wdetail.si       COLUMN-LABEL "Sum Insure"
      wdetail.fleet    COLUMN-LABEL "Fleet"
      wdetail.ncb      COLUMN-LABEL "NCB"
      wdetail.deductpd COLUMN-LABEL "Deduct PD"
      wdetail.benname  COLUMN-LABEL "Benefit Name" 
      wdetail.n_IMPORT COLUMN-LABEL "Import"
      wdetail.n_export COLUMN-LABEL "Export"
      wdetail.comment  FORMAT "x(35)" COLUMN-BGCOLOR  80 COLUMN-LABEL "Comment"
      wdetail.cancel   COLUMN-LABEL "Cancel"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 5.24
         BGCOLOR 15 FONT 6.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_protis AT ROW 3.76 COL 93.5
     fi_loaddat AT ROW 2.76 COL 13.17 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 2.76 COL 40.17 COLON-ALIGNED NO-LABEL
     fi_chkpro AT ROW 2.71 COL 114 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.81 COL 10.67 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.86 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 8 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 9.05 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 23.05 COL 13.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_bchyr AT ROW 9.05 COL 59 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 10.1 COL 26.83 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 10.1 COL 89.5
     fi_output1 AT ROW 11.14 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 12.19 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 13.19 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 15.29 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 15.29 COL 65 NO-LABEL
     buok AT ROW 11.62 COL 96.67
     bu_exit AT ROW 13.71 COL 96.83
     fi_brndes AT ROW 3.81 COL 21.33 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 3.81 COL 19
     bu_hpacno1 AT ROW 4.86 COL 43.67
     bu_hpagent AT ROW 8 COL 43.67
     fi_proname AT ROW 4.86 COL 46 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 8 COL 45.83 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 16.76 COL 2.33
     fi_impcnt AT ROW 22.48 COL 58.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 14.24 COL 2.83 COLON-ALIGNED NO-LABEL
     fi_producer2 AT ROW 5.91 COL 26.83 COLON-ALIGNED NO-LABEL
     bu_hpacno2 AT ROW 5.91 COL 43.67
     fi_completecnt AT ROW 23.48 COL 58.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.48 COL 96.67 NO-LABEL NO-TAB-STOP 
     fi_proname2 AT ROW 5.91 COL 46 COLON-ALIGNED NO-LABEL
     fi_premsuc AT ROW 23.52 COL 94.67 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_compa AT ROW 2.76 COL 56.5 COLON-ALIGNED NO-LABEL
     fi_textf17 AT ROW 6.95 COL 27 COLON-ALIGNED NO-LABEL
     fi_camp AT ROW 3.86 COL 56.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     br_proinsur AT ROW 7.14 COL 98.33 WIDGET-ID 100
     " Branch  :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 3.81 COL 2.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "TieS 4 25/12/2021":60 VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 15.29 COL 95.5 WIDGET-ID 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 2.76 COL 31.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 12.19 COL 4.5
          BGCOLOR 18 FGCOLOR 1 
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 15.29 COL 82.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 23.48 COL 94.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 23.67 COL 58.67 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Product/Promo :" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 2.71 COL 98.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 23.05 COL 3.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 24.1
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " Load Date :":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 2.76 COL 2.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "    Previous Batch No. :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 9.05 COL 4.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "    IMPORT TEXT FILE MOTOR [OEM-FORD-����ᴧ/������� ]" VIEW-AS TEXT
          SIZE 129 BY .95 AT ROW 1.24 COL 3
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 10.1 COL 4.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 23.48 COL 115.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 22.48 COL 94.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 9.05 COL 59.33 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " Producer  Code New Car :" VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 4.86 COL 2.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "              Agent Code  :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 8 COL 4.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "  Producer  Code Renew :" VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 5.91 COL 2.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 22.62 COL 58.67 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 11.14 COL 4.5
          BGCOLOR 18 FGCOLOR 1 
     "campaign :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 3.86 COL 47.5 WIDGET-ID 4
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 15.29 COL 63.5 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 15.29 COL 26.5 RIGHT-ALIGNED
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.48 COL 115.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 13.24 COL 4.5
          BGCOLOR 18 FGCOLOR 1 
     "Company :" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 2.76 COL 48.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Text(F17), Memo (F18)" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 6.95 COL 5
          BGCOLOR 18 FGCOLOR 4 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.48 COL 1
     RECT-373 AT ROW 16.57 COL 1
     RECT-376 AT ROW 22.38 COL 1
     RECT-377 AT ROW 11.14 COL 95
     RECT-378 AT ROW 13.24 COL 95.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 24.1
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
         TITLE              = "Load Text file OEM-FORD - ����ᴧ/�������"
         HEIGHT             = 24.1
         WIDTH              = 133.17
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
/* BROWSE-TAB br_protis 1 fr_main */
/* BROWSE-TAB br_wdetail fi_agtname fr_main */
/* BROWSE-TAB br_proinsur RECT-378 fr_main */
ASSIGN 
       br_proinsur:SEPARATOR-FGCOLOR IN FRAME fr_main      = 20.

ASSIGN 
       br_protis:SEPARATOR-FGCOLOR IN FRAME fr_main      = 20.

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
/* SETTINGS FOR FILL-IN fi_proname2 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.83 BY .95 AT ROW 9.05 COL 59.33 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 23 BY .95 AT ROW 15.29 COL 26.5 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY .95 AT ROW 15.29 COL 63.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 22.48 COL 94.33 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY .95 AT ROW 22.62 COL 58.67 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 23.48 COL 94.5 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY .95 AT ROW 23.67 COL 58.67 RIGHT-ALIGNED         */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_proinsur
/* Query rebuild information for BROWSE br_proinsur
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tbinsurid.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_proinsur */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_protis
/* Query rebuild information for BROWSE br_protis
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tbprotis.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_protis */
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
ON END-ERROR OF c-Win /* Load Text file OEM-FORD - ����ᴧ/������� */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text file OEM-FORD - ����ᴧ/������� */
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
          wdetail.vehuse    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.garage    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.stk       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.    
          wdetail.covcod    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.        
          wdetail.si        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
          wdetail.fleet     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.       
          wdetail.ncb       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
          wdetail.deductpd  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
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
          wdetail.vehuse    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.garage    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.stk       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.covcod    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.si        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.fleet     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.ncb       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.deductpd  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.benname   :FGCOLOR IN BROWSE BR_WDETAIL = s  NO-ERROR.  
          wdetail.n_IMPORT  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.n_export  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.comment   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          wdetail.cancel    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  /*new add*/
          

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
        fi_process  = "Start Load Text File TISCO [�ҹ����ᴧ...] " .  /*A55-0184 */ 
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
    For each  wdetail2 :
        DELETE  wdetail2.
    End.
    /*RUN proc_assign. */   /*A55-0184 ....*/
    RUN proc_assign11.      /*A55-0184 ....*/
    /*
    ASSIGN
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
            ASSIGN
            nv_reccnt      =  nv_reccnt   + 1
            nv_netprm_t    =  nv_netprm_t + decimal(wdetail.premt)
            wdetail.pass   =  "Y". 
        ELSE DO :  
            DELETE WDETAIL.
            DELETE WDETAIL2.
        END.
    END.
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    /*comment by : A64-0138..
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

    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,    /* DATE  */
                           INPUT            nv_batchyr ,    /* INT   */
                           INPUT            fi_producer,    /* CHAR  */ 
                           INPUT            nv_batbrn  ,    /* CHAR  */
                           INPUT            fi_prevbat ,    /* CHAR  */ /*Previous Batch*/
                           INPUT            "WGWTCGEN" ,    /* CHAR  */
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
    IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".
    /* add by : A64-0138 */
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
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    /* add by : A64-0138 */
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
    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_bchno WITH FRAME fr_main.
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .
    /*add kridtiya i. A55-0184 ... */
    /*/* add by : A64-0138 */
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
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    /* add by : A64-0138 */*/
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


&Scoped-define SELF-NAME bu_hpacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno2 c-Win
ON CHOOSE OF bu_hpacno2 IN FRAME fr_main
DO:
    Def   var     n_acno       As  Char.
    Def   var     n_agent      As  Char.    
    Run whp\whpacno1(output  n_acno, /*a490166 note modi*/ /*28/11/2006*/
                     output  n_agent).
    If  n_acno  <>  ""  Then  fi_producer =  n_acno.
    disp  fi_producer2  with frame  fr_main.
    Apply "Entry"  to  fi_producer2.
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


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp c-Win
ON LEAVE OF fi_camp IN FRAME fr_main
DO:
    fi_chkpro  =  Input  fi_chkpro.
  Disp  fi_chkpro  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_chkpro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_chkpro c-Win
ON LEAVE OF fi_chkpro IN FRAME fr_main
DO:
    fi_chkpro  =  Input  fi_chkpro.
  Disp  fi_chkpro  with  frame  fr_main.
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


&Scoped-define SELF-NAME fi_producer2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer2 c-Win
ON LEAVE OF fi_producer2 IN FRAME fr_main
DO:
    fi_producer2 = INPUT fi_producer2.
    IF  fi_producer2 <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001          WHERE
            sicsyac.xmm600.acno  =  Input fi_producer2  NO-LOCK NO-ERROR NO-WAIT.
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


&Scoped-define SELF-NAME fi_textf17
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_textf17 c-Win
ON LEAVE OF fi_textf17 IN FRAME fr_main
DO:
    fi_textf17 = trim(INPUT fi_textf17).
    Disp  fi_textf17     WITH Frame  fr_main.   
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


&Scoped-define BROWSE-NAME br_proinsur
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
  
  gv_prgid = "Wgwtfgen".
  gv_prog  = "Load Text & Generate OEM-FORD [����ᴧ/�������]".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
      fi_pack      = "F"
      fi_branch    = "M"
      fi_chkpro    = "PRO_TIS"    
      /*fi_producer  = "B3M0003" */ /*A64-0092*/
      /*fi_producer2 = "A0M2012" */ /*A64-0092*/
      fi_producer  = "B3M0002"     /*A64-0092*/ 
      fi_producer2 = "B3M0033"     /*A64-0092*/ 
      fi_agent     = "B3M0035"
      fi_bchyr     = YEAR(TODAY)
      fi_compa     = "TISCO"
      fi_textf17   = "TISCO_F7"
      fi_camp      = "PACK_TISCO"
      fi_process   = "Load Text File OEM-FORD [�ҹ����ᴧ...]" .
      RUN proc_protis.  
      RUN proc_insuricno.
  DISP fi_pack    fi_chkpro fi_branch  fi_producer  fi_producer2 fi_agent    fi_bchyr    fi_process  
       fi_compa   fi_textf17 fi_camp   br_protis 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assign c-Win 
PROCEDURE 00-proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by Kridtiya i. A55-0184 ....
DO:
    For each  wdetail2 :
        DELETE  wdetail2.
    END.
    For each  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail2.
        IMPORT DELIMITER "|" 
            wdetail2.Pro_off     /*2   2   �����Ңҷ������һ�Сѹ����Դ�ѭ�� */        
            wdetail2.cmr_code    /*3...3   �������˹�ҷ���õ�Ҵ              */        
            wdetail2.comcode     /*4...3   ���ʺ���ѷ��Сѹ 3��ѡ  */        
            wdetail2.policyno    /*5...25  �Ţ����Ѻ�駻�Сѹ  */     
            wdetail2.caryear     /*6...4   ��ö*/     
            wdetail2.eng         /*7...25  ����ͧ¹��  */
            wdetail2.chasno      /*8...25  �����Ţ��Ƕѧ  */
            wdetail2.engcc       /*9...5   ���˹ѡ         */
            wdetail2.power       /*10..7   ���ѧ����ͧ¹��*/
            wdetail2.colorcode   /*11...2  ��ö  */
            wdetail2.vehreg      /*12...2  ����¹ */     
            wdetail2.garage      /*13...2  ��ë��� */
            wdetail2.fleetper    /*14...2  ��ǹŴ���� */
            wdetail2.ncb         /*15..3   ��ǹŴ����ѵԴ�*/
            wdetail2.orthper     /*16...3  ��ǹŴ���� */
            wdetail2.vehuse      /*17...2  �����ҹ */
            wdetail2.comdat      /*18...2  �ѹ�����������ͧ */
            wdetail2.si          /*19...2   �ع*/
            wdetail2.name_insur  /*20...2   �������˹�ҷ���Сѹ*/
            wdetail2.not_office  /*21...3   �������˹�ҷ���駻�Сѹ*/
            wdetail2.entdat      /*22...3   �ѹ����駻�Сѹ*/
            wdetail2.enttim      /*23...2   �����駻�Сѹ*/
            wdetail2.not_code    /*24...2   �����駧ҹ*/        
            wdetail2.premt       /*25...2   ���»�Сѹ���  ���� �ҡ�*/
            wdetail2.comp_prm    /*26...2   ���¾ú.  ���� �ҡ�*/
            wdetail2.stk         /*27...3   ʵ������*/
            wdetail2.brand       /*28...3   ������*/
            wdetail2.addr1       /*29...2   �����ټ����һ�Сѹ1*/
            wdetail2.addr2       /*30...2   �����ټ����һ�Сѹ2*/
            wdetail2.tiname      /*31...2   �ӹ�˹��*/
            wdetail2.insnam      /*32...2   �����١���*/
            wdetail2.name2       /*33...3   ���ʡ��*/
            wdetail2.benname     /*34...3   ����Ѻ�Ż���ª��*/
            wdetail2.remark      /*35...2   �����˵�*/
            wdetail2.Account_no  /*36...2   �Ţ����ѭ�Ңͧ�����һ�Сѹ*/         
            wdetail2.client_no   /*37...2   ���ʢͧ�����һ�Сѹ*/
            wdetail2.expdat      /*38...2   �ѹ����ش����������ͧ*/
            wdetail2.gap         /*39...3   ������� �ú*/
            wdetail2.re_country  /*40...3   �ѧ��Ѵ��訴����¹*/
            wdetail2.receipt_name  /*41...2   �����͡�����*/
            wdetail2.agent       /*42...2   ����ѷ*/
            wdetail2.prev_insur  /*43...2   ����ѷ��Сѹ������*/
            wdetail2.prepol      /*44...2   �Ţ�����������*/
            wdetail2.deduct      /*45...3   ��ǹŴ��������á*/
            wdetail2.add1_70     /*46 add1 �Ҥ��Ѥ��         */
            wdetail2.add2_70     /*47 add2 �Ҥ��Ѥ��         */
            wdetail2.Sub_Di_70   /*48 Sub Dist. 1149 1178 30  */
            wdetail2.Direc_70    /*49 Direction 1179 1208 30  */
            wdetail2.Provi_70    /*50 Province  1209 1238 30  */
            wdetail2.ZipCo_70    /*51 ZipCode   1239 1243 5   */
            wdetail2.add1_72     /*52 add1 �Ҥ��Ѥ��         */
            wdetail2.add2_72     /*53 add2 �Ҥ��Ѥ��         */
            wdetail2.Sub_Di_72   /*54 Sub Dist. 1149 1178 30  */
            wdetail2.Direc_72    /*55 Direction 1179 1208 30  */
            wdetail2.Provi_72    /*56 Province  1209 1238 30  */
            wdetail2.ZipCo_72    /*57 ZipCode   1239 1243 5   */
            wdetail2.apptype     /*58 application type h = �ѧ����͡�������� p = �͡����������*/
            wdetail2.appcode     /*59 application code [HP, H2, H6, HN, HM, HG] */
            wdetail2.nBLANK      /*60 */
            wdetail2.prempa      /*61 package*/
            wdetail2.tp1         /*62 pd 1   */
            wdetail2.tp2         /*63 pd 2   */
            wdetail2.tp3         /*64 pd 3   */
            wdetail2.covcod      /*65 covcod */
            wdetail2.producer
            wdetail2.agent1   
            wdetail2.nbranch  .
    END.  /* repeat  */
    FOR EACH wdetail2  NO-LOCK.
        IF       index(wdetail2.Pro_off,"����ѷ") > 0  THEN DELETE wdetail2.
        ELSE IF  index(wdetail2.Pro_off,"Pro")    > 0  THEN DELETE wdetail2.
        ELSE IF  index(wdetail2.Pro_off,"Totle")  > 0  THEN DELETE wdetail2.
        ELSE IF  wdetail2.Pro_off =  " "               THEN DELETE wdetail2.
    END.
    FOR EACH wdetail2   NO-LOCK.
        IF  wdetail2.policyno = "notify number" OR wdetail2.policyno =  "" THEN NEXT.
        FIND FIRST wdetail WHERE wdetail.policy  = "D070" + trim(substr(wdetail2.policyno,4)) NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail  THEN DO:
            CREATE wdetail .
            ASSIGN 
                wdetail.policy     = "D070" + trim(substr(wdetail2.policyno,4))
                wdetail.poltyp     = "V70"
              /*wdetail.cmr_code   = trim(wdetail2.cmr_code) */
                wdetail.caryear    = trim(wdetail2.caryear)           
                wdetail.eng        = trim(wdetail2.eng)               
                wdetail.chasno     = trim(wdetail2.chasno)            
                wdetail.engcc      = STRING(DECI(wdetail2.power) * 100 )            
              /*wdetail.power      = wdetail2.power  */           
        /*10    wdetail.colorcode  = wdetail2.colorcode */        
                wdetail.vehreg     = trim(wdetail2.vehreg)            
                wdetail.garage     = trim(wdetail2.garage)            
                wdetail.fleetper   = trim(wdetail2.fleetper)          
                wdetail.ncb        = trim(wdetail2.ncb)               
              /*wdetail.orthper    = wdetail2.orthper*/           
                wdetail.vehuse     = wdetail2.vehuse            
                wdetail.comdat     = wdetail2.comdat            
                wdetail.si         = wdetail2.si                
                wdetail.name_insur = trim(wdetail2.name_insur)        
                wdetail.not_office = trim(wdetail2.not_office)        
                wdetail.entdat1    = trim(wdetail2.entdat)            
                wdetail.enttim1    = trim(wdetail2.enttim)            
              /*wdetail.not_code    = wdetail2.not_code */         
                wdetail.premt      = trim(wdetail2.premt)             
                /*wdetail.comp_prm   = wdetail2.comp_prm  */        
                wdetail.stk        = trim(wdetail2.stk) 
                wdetail.brand      = trim(wdetail2.brand)             
                wdetail.addr1      = trim(wdetail2.addr1)             
                wdetail.addr2      = trim(wdetail2.addr2)             
                wdetail.tiname     = trim(wdetail2.tiname)            
                wdetail.insnam     = trim(wdetail2.insnam)  + " " + trim(wdetail2.name2)            
        /*32    wdetail.name2      = wdetail2.name2  */           
                wdetail.benname    = trim(wdetail2.benname)           
                wdetail.remark     = wdetail2.remark           
                wdetail.Account_no = trim(wdetail2.Account_no)        
              /*wdetail.client_no  = wdetail2.client_no*/         
                wdetail.expdat     = trim(wdetail2.expdat)            
        /*38    wdetail.gap        = wdetail2.gap */              
                wdetail.re_country = trim(wdetail2.re_country)        
                wdetail.receipt_name = trim(wdetail2.receipt_name)      
        /*41    wdetail.agent      = wdetail2.agent */            
        /*42    wdetail.prev_insur = wdetail2.prev_insur */       
                wdetail.prepol     = trim(wdetail2.prepol)            
                wdetail.deduct     = trim(wdetail2.deduct)            
                wdetail.add1_70    = trim(wdetail2.add1_70)           
                wdetail.add2_70    = IF trim(wdetail2.add2_70) = "" THEN           
                    ( trim(wdetail2.Sub_Di_70) + " "  +      
                      trim(wdetail2.Direc_70) + " " +         
                      trim(wdetail2.Provi_70) + " " +         
                      trim(wdetail2.ZipCo_70))  ELSE  trim(wdetail2.add2_70)        
                /*wdetail.add1_72    = wdetail2.add1_72           
                wdetail.add2_72    = IF trim(wdetail2.add2_72) = "" THEN            
                    ( TRIM(wdetail2.Sub_Di_72) + " " +        
                      TRIM(wdetail2.Direc_72) + " " +         
                      TRIM(wdetail2.Provi_72) + " " +         
                      TRIM(wdetail2.ZipCo_72)) ELSE trim(wdetail2.add2_72)*/        
        /*57    wdetail.apptype    = wdetail2.apptype           
          58    wdetail.appcode    = wdetail2.appcode           
          59    wdetail.nBLANK     = wdetail2.nBLANK  */ 
                wdetail.tp1        = wdetail2.tp1               
                wdetail.tp2        = wdetail2.tp2               
                wdetail.tp3        = wdetail2.tp3               
                wdetail.covcod     = wdetail2.covcod 
                wdetail.subclass   = SUBSTR(wdetail2.prempa,2,3)
                wdetail.prempa     = caps(SUBSTR(wdetail2.prempa,1,1))
                /*wdetail2.seat41  = INTE(wdetail.seat) */
                wdetail.n_branch   = trim(caps(wdetail2.nbranch))
                wdetail.tariff     = "x" 
                wdetail.compul     = "n"
                wdetail.comment    = ""
                wdetail.producer   = wdetail2.producer
                wdetail.agent      = wdetail2.agent1   
                wdetail.entdat     = string(TODAY)                /*entry date*/
                wdetail.enttim     = STRING (TIME, "HH:MM:SS")    /*entry time*/
                wdetail.trandat    = STRING (fi_loaddat)          /*tran date*/
                wdetail.trantim    = STRING (TIME, "HH:MM:SS")    /*tran time*/
                wdetail.n_IMPORT   = "IM"
                wdetail.n_EXPORT   = "" .
        END.
        IF  deci(wdetail2.comp_prm) NE 0  THEN  RUN proc_assign_v72.
    END.
    RUN proc_assign2.
    /*RUN proc_atestp.*/
END.
end....comment by Kridtiya i. A55-0184 ....*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assign11 c-Win 
PROCEDURE 00-proc_assign11 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0087...
DO:
    DEF BUFFER buwm100 FOR wdetail.
    DEF VAR nv_chkstk  AS LOGICAL INIT NO.
    ASSIGN 
        nv_chkstk  = NO
        fi_process = "Start create wdetail...".
    DISP fi_process WITH FRAM fr_main.
    For each  wdetail2 :
        DELETE  wdetail2.
    END.
    For each  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail2.
        IMPORT DELIMITER "|" 
            wdetail2.Pro_off       /*  1   Processing Office   00  */                                     
            wdetail2.cmr_code      /*  2   CMR  code   KTY */                                             
            wdetail2.comcode       /*  3   Insur.comp  510 */                                             
            wdetail2.policyno      /*  4   notify number   TC702053047 */                                 
            wdetail2.caryear       /*  5   Caryear     2003    */                                         
            wdetail2.eng           /*  6   Engine  QG16T24033  */                                         
            wdetail2.chasno        /*  7   Chassis     CDGARSAN16A64477    */                             
            wdetail2.engcc         /*  8   Weight  1200    */                                             
            wdetail2.power         /*  9   Power   1597    */                                             
            wdetail2.colorcode     /*  10  Color       */                                                 
            wdetail2.vehreg        /*  11  licence no  ɰ 5774 */                                         
            wdetail2.garage        /*  12  garage  1   */                                                 
            wdetail2.fleetper      /*  13  fleet disc.     0   */                                         
            wdetail2.ncb           /*  14  ncb disc.   0   */                                             
            wdetail2.orthper       /*  15  other disc.     0   */                                         
            wdetail2.vehuse        /*  16  vehuse      */                                                 
            wdetail2.comdat        /*  17  comdat      21/05/12    */                                     
            wdetail2.si            /*  18  sum si  0   */                                                 
            wdetail2.name_insur    /*  19  �������˹�ҷ���Сѹ   3250500043445   */                     
            wdetail2.not_office    /*  20  �������˹�ҷ���駻�Сѹ   ORANONG POLSUK TEL.0-2633-5469  */ 
            wdetail2.entdat        /*  21  �ѹ����駻�Сѹ    22/06/12    */                             
            wdetail2.enttim        /*  22  �����駻�Сѹ  10:58:23    */                                 
            wdetail2.not_code      /*  23  �����駧ҹ     */                                             
            wdetail2.premt         /*  24  prem.1  1854.79 */                                             
            wdetail2.comp_prm      /*  25  comp.prm    0   */                                             
            wdetail2.stk           /*  26  sticker         */                                             
            wdetail2.brand         /*  27  brand   NISSAN SUNNY 1.6 A/T    */                             
            wdetail2.addr1         /*  28  address1    9/40 ������ 2 ������º��ͧ 3   */                 
            /*wdetail2.addr2         /*  28  address1    9/40 ������ 2 ������º��ͧ 3   */                 */
            wdetail2.tambon        /*  29  address2    �.�֧����  */                                     
            wdetail2.amper         /*  30  address3    �.�ѭ����   */                                     
            wdetail2.country       /*  31  address4    �.�����ҹ� 12130    */                             
            wdetail2.tiname        /*  32  title name      �ҧ */                                         
            wdetail2.insnam        /*  33  first name  �ԸԹҶ �ͧ�ت  */                                 
            /*wdetail2.lastname    */
            wdetail2.benname       /*  34  beneficiary     �к� 8.3 ��Ҥ�÷���� �ӡѴ (��Ҫ�) */         
            wdetail2.remark        /*  35  remark.     MV20020522_70new1_MV20020522_70new1 */             
            wdetail2.Account_no    /*  36  account no.     0002053047  */                                 
            wdetail2.client_no     /*  37  client No.  9660275 */                                         
            wdetail2.expdat        /*  38  expiry date     21/05/13    */                                 
            wdetail2.gap           /*  39  insurance amt.      1854.79 */                                 
            wdetail2.re_country    /*  40  province    BKK */                                             
            wdetail2.receipt_name  /*  41  receipt name    �ҧ �ԸԹҶ �ͧ�ت  */                         
            wdetail2.agenttis      /*  42  agent code  TISCO   */                                         
            wdetail2.prev_insur    /*  43  ����ѷ��Сѹ������     KRUNGTHAI PANICH INSURANCE CO.,LTD. */ 
            wdetail2.prepol        /*  44  old policy          */       
            wdetail2.deduct       
            wdetail2.addr1_70     
            wdetail2.addr2_70     
            wdetail2.nsub_dist70  
            wdetail2.ndirection70 
            wdetail2.nprovin70    
            wdetail2.zipcode70    
            wdetail2.addr1_72     
            wdetail2.addr2_72     
            wdetail2.nsub_dist72  
            wdetail2.ndirection72 
            wdetail2.nprovin72    
            wdetail2.zipcode72    
            wdetail2.apptyp       
            wdetail2.appcode
            wdetail2.caracc
            wdetail2.prempa       
            wdetail2.seattisco    
            wdetail2.tp1          
            wdetail2.tp2          
            wdetail2.tp3          
            wdetail2.covcod       
            wdetail2.producer     
            wdetail2.agent        
            wdetail2.branch       
            wdetail2.n_type       
            wdetail2.redbook      
            wdetail2.price_ford   
            wdetail2.yrmanu       
            wdetail2.nbrand  
            wdetail2.n_recid      
            wdetail2.n_recbr      
            wdetail2.n_reccomid   
            wdetail2.n_reccombr   
            wdetail2.n_comdat     
            wdetail2.n_expdat     
            wdetail2.n_fi         
            wdetail2.n_clss72     
            wdetail2.veh          
            wdetail2.driveno1
            wdetail2.drivnam1     
            wdetail2.driag1       
            wdetail2.occupdriv1   
            wdetail2.positdriv1 
            wdetail2.driveno2  
            wdetail2.drivnam2     
            wdetail2.driag2       
            wdetail2.occupdriv2   
            wdetail2.positdriv2 
            wdetail2.driveno3     
            wdetail2.drivename3   
            wdetail2.bdatedriv3   
            wdetail2.occupdriv3   
            wdetail2.positdriv3 
            wdetail2.caracc        /*Str A63-0210 */
            wdetail2.recept72     
            wdetail2.acc          
            wdetail2.Rec_name72   
            wdetail2.Rec_add1     
            wdetail2.n_comment    /*end A63-0210 */  
            wdetail2.brithday.
    END.   /* repeat  */        
    FOR EACH wdetail2  NO-LOCK.
        IF      index(wdetail2.Pro_off,"����ѷ") > 0 THEN DELETE wdetail2.
        ELSE IF index(wdetail2.Pro_off,"Pro") >    0 THEN DELETE wdetail2.
        ELSE IF index(wdetail2.Pro_off,"Totle") >  0 THEN DELETE wdetail2.
        ELSE IF wdetail2.policyno = ""               THEN DELETE wdetail2.
        ELSE IF wdetail2.Pro_off = ""                THEN DELETE wdetail2.
    END.
    FOR EACH wdetail2   NO-LOCK.
        IF INDEX(wdetail2.policyno,",") <> 0 THEN
            ASSIGN n_policyno = trim(substr(wdetail2.policyno,1,INDEX(wdetail2.policyno,",") - 1 )).
        ELSE n_policyno = trim(wdetail2.policyno).
        IF INDEX(wdetail2.addr2," ") <> 0 THEN DO:
            wdetail2.country = SUBSTR(wdetail2.addr2,R-INDEX(wdetail2.addr2," ")).
            wdetail2.addr2   = SUBSTR(wdetail2.addr2,1,r-INDEX(wdetail2.addr2," ") - 1 ).
            wdetail2.amper   = substr(wdetail2.addr2,INDEX(wdetail2.addr2," ") ).
            wdetail2.country = SUBSTR(wdetail2.country,1,INDEX(wdetail2.country," ") - 1 ).
        END.
        FIND FIRST wdetail WHERE wdetail.policy = n_policyno NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN 
                wdetail.policy      =   trim(n_policyno) 
                wdetail.deler       =   IF INDEX(wdetail2.policyno,",") <> 0 THEN SUBSTR(wdetail2.policyno,INDEX(wdetail2.policyno,",") + 1 ) ELSE ""
                wdetail.caryear     =   trim(wdetail2.caryear)    
                wdetail.eng         =   trim(wdetail2.eng)        
                wdetail.chasno      =   trim(wdetail2.chasno)  
                wdetail.weight      =   trim(wdetail2.engcc)
                wdetail.engcc       =   trim(wdetail2.power)       
                wdetail.vehreg      =   trim(wdetail2.vehreg)     
                wdetail.garage      =   trim(wdetail2.garage)     
                wdetail.fleetper    =   deci(trim(wdetail2.fleetper))   
                wdetail.ncb         =   deci(trim(wdetail2.ncb))        
                wdetail.orthper     =   trim(wdetail2.orthper)    
                /*wdetail.vehuse      =   trim(wdetail2.vehuse) */   /*A60-0118*/
                wdetail.vehuse      =   ""                           /*A60-0118*/
                wdetail.comdat      =   trim(wdetail2.comdat)    
                wdetail.si          =   trim(wdetail2.si)         
                /*wdetail.name_insur =   trim(wdetail2.name_insur)  */
                wdetail.not_office  =  "���ͼ����:" + trim(wdetail2.not_office) +  " ���ʼ����:" + trim(wdetail2.name_insur)  
                wdetail.entdat      =  "Notify date:" +  trim(wdetail2.entdat) + " " + 
                                       "Notify time:" +  trim(wdetail2.enttim) + " " +
                                       "Notify Number:" + TRIM(wdetail2.policyno) /*A60-0225*/
                wdetail.not_code    =   trim(wdetail2.not_code)   
                wdetail.premt       =   trim(wdetail2.premt)   
                wdetail.comp_prm    =   trim(wdetail2.comp_prm)   
                wdetail.stk         =   trim(wdetail2.stk)        
                wdetail.brand       =   trim(wdetail2.brand)        
                wdetail.addr1       =   trim(wdetail2.addr1)        
                wdetail.tambon      =   trim(wdetail2.tambon)       
                wdetail.amper       =   trim(wdetail2.amper)        
                wdetail.country     =   trim(wdetail2.country)      
                wdetail.tiname      =   trim(wdetail2.tiname)      
                wdetail.insnam      =   trim(wdetail2.insnam)      
                wdetail.benname     =   trim(wdetail2.benname)
                /*wdetail.remark      =   trim(wdetail2.remark)*/       /*A60-0118*/
                wdetail.remark      =   trim(wdetail2.remark) + " " + trim(wdetail2.vehuse)   /*A60-0118*/      
                wdetail.Account_no  =   trim(wdetail2.Account_no)   
                wdetail.client_no   =   trim(wdetail2.client_no)    
                wdetail.expdat      =   trim(wdetail2.expdat)       
                wdetail.gap         =   trim(wdetail2.gap)          
                wdetail.re_country  =   trim(wdetail2.re_country)   
                wdetail.receipt_name = trim(wdetail2.receipt_name) 
                wdetail.prepol      =   trim(wdetail2.prepol)
                wdetail.drivnam1    =   trim(wdetail2.drivnam1) 
                wdetail.driag1      =   trim(wdetail2.driag1)   
                wdetail.drivnam2    =   trim(wdetail2.drivnam2) 
                wdetail.driag2      =   trim(wdetail2.driag2)
                wdetail.deduct      =   trim(wdetail2.deduct)       
                wdetail.branch      =   IF caps(trim(wdetail2.branch)) = "5" THEN "P" ELSE caps(trim(wdetail2.branch))
                wdetail.seat        =   IF (wdetail2.seattisco = "") OR (INTE(wdetail2.seattisco) = 0 ) THEN 0 ELSE INTE(wdetail2.seattisco)     /*  A57-0017 */
                wdetail.prempa      =   IF wdetail2.prempa = "" THEN ""
                                        ELSE IF INDEX(wdetail2.policyno,"TC72") <> 0 THEN "" 
                                        ELSE IF substr(wdetail2.policyno,3,2) = "72" THEN ""
                                        ELSE IF substr(wdetail2.policyno,3,2) = "70" THEN caps(SUBSTR(trim(wdetail2.prempa),1,1)) 
                                        ELSE caps(SUBSTR(trim(wdetail2.prempa),1,1)) 
                wdetail.subclass    =   IF wdetail2.prempa = "" THEN ""
                                        ELSE IF INDEX(wdetail2.policyno,"TC72") <> 0 THEN trim(wdetail2.prempa) 
                                        ELSE IF substr(wdetail2.policyno,3,2) = "72" THEN trim(wdetail2.prempa) 
                                        ELSE IF substr(wdetail2.policyno,3,2) = "70" THEN trim(SUBSTR(wdetail2.prempa,2,4))  /*A64-0035*/
                                        ELSE trim(SUBSTR(wdetail2.prempa,2,4)). /*A64-0035*/                                            
                                        /*ELSE IF substr(wdetail2.policyno,3,2) = "70" THEN trim(SUBSTR(wdetail2.prempa,2,3))*/ /*A64-0035*/
                                        /*ELSE trim(SUBSTR(wdetail2.prempa,2,3)).*/ /*A64-0035*/
             ASSIGN                 
                wdetail.tp1         =   trim(wdetail2.tp1)          
                wdetail.tp2         =   trim(wdetail2.tp2)          
                wdetail.tp3         =   trim(wdetail2.tp3)          
                wdetail.covcod      =   IF INDEX(wdetail2.policyno,"TC72") <> 0 THEN "T" 
                                        ELSE IF substr(wdetail2.policyno,3,2) = "72" THEN "T"
                                        ELSE IF substr(wdetail2.policyno,3,2) = "70" THEN trim(wdetail2.covcod)
                                        ELSE trim(wdetail2.covcod)
                wdetail.poltyp      =   IF INDEX(wdetail2.policyno,"TC72") <> 0 THEN "V72" 
                                        ELSE IF substr(wdetail2.policyno,3,2) = "72" THEN "V72"
                                        ELSE IF substr(wdetail2.policyno,3,2) = "70" THEN "V70"
                                        ELSE "V70"
                wdetail.fi          = TRIM(wdetail2.n_fi)
                wdetail.comment     = ""
                wdetail.agent       = IF wdetail2.agent    = "" THEN caps(fi_agent)    ELSE CAPS(TRIM(wdetail2.agent)) /*A60-0095*/
                /*wdetail.producer    = IF (wdetail2.producer = "") AND (deci(trim(wdetail2.caryear)) = YEAR(TODAY)) THEN caps(fi_producer) 
                                      ELSE IF (wdetail2.producer = "") AND (deci(trim(wdetail2.caryear)) < YEAR(TODAY)) THEN CAPS(fi_producer2)
                                      ELSE CAPS(TRIM(wdetail2.producer))*/ /*A60-0095*/
                wdetail.producer    = IF (wdetail2.producer <> "") THEN CAPS(TRIM(wdetail2.producer)) 
                                      ELSE IF (wdetail2.producer = "") AND (deci(trim(wdetail2.caryear)) = YEAR(TODAY)) THEN caps(fi_producer) 
                                      ELSE CAPS(fi_producer2) /*A60-0095*/
                wdetail.trandat     = STRING(fi_loaddat)         /*tran  date*/
                wdetail.trantim     = STRING(TIME,"HH:MM:SS")    /*tran  time*/
                wdetail.n_IMPORT    = "IM"
                wdetail.n_EXPORT    = "" 
                /*wdetail.acc        = TRIM(wdetail2.acc) /*Str A63-0210 */ *//*A65-0035*/
                wdetail.acc        = TRIM(wdetail2.caracc)          /*A65-0035*/
                wdetail.Rec_name72 = TRIM(wdetail2.Rec_name72)                    
                wdetail.Rec_add1   = TRIM(wdetail2.Rec_add1)   /*End A63-0210 */  
                wdetail.redbook    = TRIM(wdetail2.redbook)   /*A65-0035*/
                wdetail.seat41     = wdetail.seat /*A65-0035*/
                wdetail.colorcode  = trim(wdetail2.colorcode)    /*A65-0356*/  
                wdetail.brithday   =  wdetail2.brithday          /*A65-0356*/
                wdetail.br_insured =  IF trim(wdetail2.n_recbr) = "" THEN trim(wdetail2.n_reccombr) ELSE trim(wdetail2.n_recbr). /*A66-0160*/
                /*--A60-0225--*/
                IF index(wdetail.benname,"�����") <> 0 THEN wdetail.benname = "��Ҥ�÷���� �ӡѴ (��Ҫ�)".
                ELSE IF INDEX(wdetail.benname,"���") <> 0 THEN wdetail.benname = "".
                ELSE DO: 
                    IF      index(wdetail.benname,"�к� 8.3") <> 0 THEN ASSIGN wdetail.benname = trim(REPLACE(wdetail.benname,"�к� 8.3","")). 
                    ELSE IF index(wdetail.benname,"�к�8.3")  <> 0 THEN ASSIGN wdetail.benname = trim(REPLACE(wdetail.benname,"�к�8.3","")).
                    ELSE ASSIGN wdetail.benname = wdetail.benname.
                END.
                /*-- end : A60-0225--*/
             /*-----A61-0045----*/
            /*IF trim(wdetail.prempa) = "O"  THEN DO:*/
                FIND LAST brstat.insure WHERE brstat.insure.insno = TRIM(fi_camp) AND 
                                              brstat.insure.text3 = TRIM(wdetail.prempa) NO-LOCK NO-ERROR NO-WAIT .
                IF AVAIL brstat.insure THEN DO:
                    ASSIGN 
                        wdetail.tp1    = IF deci(wdetail.tp1)   = 0 THEN brstat.insure.lname       ELSE wdetail.tp1  .
                        wdetail.tp2    = IF deci(wdetail.tp2)   = 0 THEN brstat.insure.addr1       ELSE wdetail.tp2  .
                        wdetail.tp3    = IF deci(wdetail.tp3)   = 0 THEN brstat.insure.addr2       ELSE wdetail.tp3  .
                        wdetail.no_41  = IF deci(wdetail.no_41) = 0 THEN deci(brstat.insure.addr3) ELSE wdetail.no_41.
                        wdetail.no_42  = IF deci(wdetail.no_42) = 0 THEN deci(brstat.insure.addr4) ELSE wdetail.no_42.
                        wdetail.no_43  = IF deci(wdetail.no_43) = 0 THEN deci(brstat.insure.telno) ELSE wdetail.no_43. 
                END.
            /*END.*/
            /*-----end : A61-0045----*/
            /* A63-0122 */
            IF wdetail.poltyp = "V70" AND wdetail.prempa <> "U" AND DATE(wdetail.comdat) >= 04/01/2020 THEN DO:
                ASSIGN wdetail.prempa = "T"  .
            END.
           /* end a63-0122 */
        END. 
    END.
    FOR EACH wdetail NO-LOCK.
        IF (wdetail.stk <> "" ) AND (wdetail.poltyp = "V72" ) THEN DO:
            FOR EACH buwm100 WHERE buwm100.stk   =  wdetail.stk AND
                                   buwm100.poltyp = "V72"       NO-LOCK.
                IF  buwm100.policyno <>  wdetail.policyno  THEN DO:
                    MESSAGE "���Ţʵ���������������ǡѹ : " wdetail.policy  wdetail.stk  VIEW-AS ALERT-BOX.
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
...end : A67-0087...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_chktest0 c-Win 
PROCEDURE 00-proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : Ranu I. A65-0035...
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
    ASSIGN  wdetail.comment = wdetail.comment + "| �Ң��繤����ҧ�������ö������к���"   /* A56-0323 */
    wdetail.pass    = "N"     /* A56-0323 */
    wdetail.OK_GEN  = "N".    /* A56-0323 */
/* comment by : A65-0035...
IF INDEX(wdetail.brand," ") <> 0 THEN 
    ASSIGN wdetail.model = SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1 )
    wdetail.brand = SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 ).
 ...end A65-0035...*/
IF wdetail.cancel = "ca"  THEN  
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ���ͼ����һ�Сѹ�繤����ҧ��ٳ������ͼ����һ�Сѹ"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
/*IF wdetail.drivnam = "y" AND wdetail.drivername1 =  " "   THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| �ա���к�����դ��Ѻ������ժ��ͤ��Ѻ"
        wdetail.pass    = "N" 
        wdetail.OK_GEN  = "N".*/
IF wdetail.prempa = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| prem pack �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.subclass = " " THEN  
    ASSIGN  wdetail.comment = wdetail.comment + "| sub class �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".  /*can't block in use*/ 
IF wdetail.brand = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| Brand �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| model �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N".
IF wdetail.engcc    = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| Engine CC �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
/*IF wdetail.seat  = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| seat �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".*/
IF wdetail.caryear = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| year manufacture �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
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
        ASSIGN  nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  if wdetail.body   = "" then stat.maktab_fil.body   else wdetail.body   /*A65-0035*/
                wdetail.cargrp   =  if wdetail.cargrp = "" then stat.maktab_fil.prmpac else wdetail.cargrp /*A65-0035*/
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat       /*A65-0035*/
                /* wdetail.body     =  stat.maktab_fil.body
                wdetail.brand  =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac*/
                wdetail.weight =  IF deci(wdetail.weight) <> 0 THEN wdetail.weight ELSE string(stat.maktab_fil.tons) /*A65-0035*/
                /*wdetail.seat     =  stat.maktab_fil.seats */
                nv_si              = maktab_fil.si   .
    /*IF nv_modcod = "" THEN DO: */ /*A65-0035*/
     IF nv_modcod = "" AND n_rencnt > 0 THEN DO:  /*A65-0035*/
        FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
            stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then DO: 
            ASSIGN  nv_modcod    =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  if wdetail.body   = "" then stat.maktab_fil.body   else wdetail.body   /*A65-0035*/
                wdetail.cargrp   =  if wdetail.cargrp = "" then stat.maktab_fil.prmpac else wdetail.cargrp /*A65-0035*/
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat       /*A65-0035*/
               /* wdetail.body     =  stat.maktab_fil.body
                wdetail.brand  =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac*/
                wdetail.weight =  IF deci(wdetail.weight) <> 0 THEN wdetail.weight ELSE string(stat.maktab_fil.tons) /*A65-0035*/
                /*wdetail.seat     =  stat.maktab_fil.seats */
                nv_si            = maktab_fil.si   .
       END.
       /* A65-0035 */
       ELSE DO:
           ASSIGN wdetail.comment = wdetail.comment + "|��辺 Redbook Code:" +  wdetail.redbook  + " �ͧ Class:" + wdetail.subclass 
                  wdetail.redbook = "" .
       END.
     END.
     /* end : A65-0035 */
END.   /*red book <> ""*/   
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
    
    IF      INDEX(wdetail.model,"vigo")   <> 0 THEN wdetail.model = "vigo".
    ELSE IF INDEX(wdetail.model,"soluna") <> 0 THEN wdetail.model = "vios".
    ELSE IF INDEX(wdetail.model,"altis")  <> 0 THEN wdetail.model = "altis".
    ELSE IF INDEX(wdetail.model," ")      <> 0 THEN 
        ASSIGN wdetail.model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ") - 1 ).

    FIND FIRST stat.makdes31 USE-INDEX makdes31    WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN n_ratmin = makdes31.si_theft_p   
        n_ratmax = makdes31.load_p   .    
    ELSE ASSIGN n_ratmin = 0
        n_ratmax = 0.
    IF (wdetail.covcod = "3") OR (wdetail.covcod = "2") THEN DO:
        IF (Integer(wdetail.engcc) = 0 )  THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04         Where
                stat.maktab_fil.makdes   = wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0    And
                stat.maktab_fil.makyea   = Integer(wdetail.caryear) AND 
                /*stat.maktab_fil.engine   <=    Integer(wdetail.engcc)  AND*/
                stat.maktab_fil.sclass   =  wdetail.subclass        AND
                stat.maktab_fil.seats    =  INTEGER(wdetail.seat)   No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                /*wdetail.brand    =  stat.maktab_fil.makdes  */ /*A65-0035*/
                /*wdetail.model    =  stat.maktab_fil.moddes  */ /*A65-0035*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  IF deci(wdetail.weight) <> 0 THEN wdetail.weight ELSE string(stat.maktab_fil.tons) /*A65-0035*/
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat .
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     wdetail.subclass         AND
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
               /* wdetail.brand    =  stat.maktab_fil.makdes */ /*A65-0035*/ 
               /* wdetail.model    =  stat.maktab_fil.moddes */ /*A65-0035*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  IF deci(wdetail.weight) <> 0 THEN wdetail.weight ELSE string(stat.maktab_fil.tons) /*A65-0035*/
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat .
        END.
    END.   /*end....covcod..2/3 .....*/
    ELSE DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =     wdetail.brand            And                  
            index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
            stat.maktab_fil.engine   =    Integer(wdetail.engcc)    AND
            stat.maktab_fil.sclass   =     wdetail.subclass         AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
            stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                /*wdetail.brand    =  stat.maktab_fil.makdes   */  /*A65-0035*/    
                /*wdetail.model    =  stat.maktab_fil.moddes   */  /*A65-0035*/    
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  IF deci(wdetail.weight) <> 0 THEN wdetail.weight ELSE string(stat.maktab_fil.tons) /*A65-0035*/
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat .
        /*IF wdetail.redbook = "" THEN 
            MESSAGE wdetail.redbook wdetail.brand wdetail.model wdetail.engcc wdetail.subclass wdetail.seat VIEW-AS ALERT-BOX.*/
    END.
    IF nv_modcod = ""  THEN DO: 
        ASSIGN chkred = YES 
            n_brand       = ""
            n_index       = 0
            n_model       = "".
        RUN proc_model_brand.
          /*RUN proc_maktab.*/
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
        ASSIGN  wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
END. /*ncb <> 0*/
/******* drivernam **********/
nv_sclass = wdetail.subclass. 

/*If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
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
 ....end A65-0035...*/    
     
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
/* comment by : A65-0035 09/02/2022....
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
        Else ASSIGN wdetail.pass    = "N"
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
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR (wdetail.covcod = "2.2")  THEN 
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
    IF INDEX(wdetail.remark,"CCTV") <> 0 THEN sic_bran.uwm130.i_text = "0001" . /*A60-0225*/

    IF wdetail.poltyp = "v72" THEN  n_sclass72 = wdetail.subclass.
    ELSE n_sclass72 = wdetail.prempa + wdetail.subclass .
    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do: 
        IF wdetail.prempa = "z"   THEN DO:
            Assign  nv_seat41          = IF wdetail.seat41 = 0 THEN INTEGER(wdetail.seat) ELSE wdetail.seat41 
            sic_bran.uwm130.uom1_v     = deci(wdetail.tp1)   /*stat.clastab_fil.uom1_si   1000000  */  
            sic_bran.uwm130.uom2_v     = deci(wdetail.tp2)   /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     = deci(wdetail.tp3)   /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  = deci(wdetail.tp1)   /*deci(wdetail.tp_bi)   */ 
            nv_uom2_v                  = deci(wdetail.tp2)   /*deci(wdetail.tp_bi2)  */  
            nv_uom5_v                  = deci(wdetail.tp3).  /*deci(wdetail.tp_bi3)  */ 
        END.
        ELSE DO:
            
            ASSIGN
                sic_bran.uwm130.uom1_v =  if deci(wdetail.tp1) = 0 then stat.clastab_fil.uom1_si else deci(wdetail.tp1) 
                sic_bran.uwm130.uom2_v =  if deci(wdetail.tp2) = 0 then stat.clastab_fil.uom2_si else deci(wdetail.tp2)
                sic_bran.uwm130.uom5_v =  if deci(wdetail.tp3) = 0 then stat.clastab_fil.uom5_si else deci(wdetail.tp3)
                nv_uom1_v              =  if deci(wdetail.tp1) = 0 then stat.clastab_fil.uom1_si else deci(wdetail.tp1)  
                nv_uom2_v              =  if deci(wdetail.tp2) = 0 then stat.clastab_fil.uom2_si else deci(wdetail.tp2)  
                nv_uom5_v              =  if deci(wdetail.tp3) = 0 then stat.clastab_fil.uom5_si else deci(wdetail.tp3)  
                wdetail.tp1            =  string(nv_uom1_v) 
                wdetail.tp2            =  string(nv_uom2_v) 
                wdetail.tp3            =  string(nv_uom5_v) .

        END.
            /* ---- end : A61-0045-----*/
        ASSIGN 
            wdetail.deductpd           =  string(sic_bran.uwm130.uom5_v)
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            wdetail.comper             =  string(stat.clastab_fil.uom8_si)                
            wdetail.comacc             =  string(stat.clastab_fil.uom9_si)
            /*nv_uom1_v                =  sic_bran.uwm130.uom1_v 
            nv_uom2_v                  =  sic_bran.uwm130.uom2_v
            nv_uom5_v                  =  sic_bran.uwm130.uom5_v  */    
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".
        If  wdetail.garage   =  ""  Then
            Assign /*nv_41     =  stat.clastab_fil.si_41unp
                   nv_42     =  stat.clastab_fil.si_42
                   nv_43     =  stat.clastab_fil.si_43*/
                   nv_41     =  deci(wdetail.no_41)
                   nv_42     =  deci(wdetail.no_42)
                   nv_43     =  deci(wdetail.no_43)
                   /*nv_seat41 =  stat.clastab_fil.dri_41 + clastab_fil.pass_41. */ /*A60-0225*/
                   nv_seat41 =  IF wdetail.seat <> 0 THEN wdetail.seat ELSE stat.clastab_fil.dri_41 + clastab_fil.pass_41. /*A60-0225*/
                   
        Else If  wdetail.garage  =  "G"  Then
            Assign /*nv_41       =  stat.clastab_fil.si_41pai
                   nv_42       =  stat.clastab_fil.si_42
                   nv_43       =  stat.clastab_fil.impsi_43*/
                   nv_41       =  deci(wdetail.no_41)
                   nv_42       =  deci(wdetail.no_42)
                   nv_43       =  deci(wdetail.no_43)
                   /*nv_seat41   =  stat.clastab_fil.dri_41 + clastab_fil.pass_41.*/ /*A60-0225*/
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
    sic_bran.uwm301.drinam[1] = TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam)  /*A60-0206*/
    sic_bran.uwm301.eng_no   = wdetail.eng
    sic_bran.uwm301.Tons     = INTEGER(wdetail.weight)
    sic_bran.uwm301.engine   = INTEGER(wdetail.engcc)
    sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage   = trim(wdetail.garage)
    sic_bran.uwm301.body     = trim(wdetail.body)
    sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv_ben83 = trim(wdetail.benname)
    sic_bran.uwm301.vehreg   = trim(wdetail.vehreg) 
    sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
    sic_bran.uwm301.vehuse   = trim(wdetail.vehuse)
    sic_bran.uwm301.modcod   = trim(wdetail.redbook) 
    /*sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model */     /*-A60-0118-*/ 
    sic_bran.uwm301.moddes   = caps(trim(wdetail.brand)) + " " + caps(trim(wdetail.model)) /*-A60-0118-*/ 
    sic_bran.uwm301.vehgrp   = wdetail.cargrp   
    sic_bran.uwm301.sckno    = 0
    sic_bran.uwm301.itmdel   = NO 
    wdetail.tariff           = sic_bran.uwm301.tariff.
/* Start A63-0210 */
IF INDEX(wdetail.remark,"FE2+") <> 0 THEN DO: 
    ASSIGN 
        SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  "MT001_PB ������ͧ��û�Сѹ����á�����Ѿ���Թ��ǹ�ؤ��"
        SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  "�����������ö¹�� 20,000 �ҷ" 
        SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  "MT002_FL ������ͧ��û�Сѹ��¤�����ͧ��¹�ӷ�������ع��Сѹ"
        /*SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  "Campaign: C63/00116 (�.2+)" */ /*A64-0092*/
        SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  SUBSTRING(wdetail.acc,1,60) 
        SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  SUBSTRING(wdetail.acc,61,60) 
        SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  SUBSTRING(wdetail.acc,121,60)
        SUBSTRING(sic_bran.uwm301.prmtxt,361,60) =  SUBSTRING(wdetail.acc,181,60)  /*A64-0092*/
        SUBSTRING(sic_bran.uwm301.prmtxt,421,60) =  SUBSTRING(wdetail.acc,241,60). /*A64-0092*/
    
END.
ELSE do:
    /* add by : A64-0092 */
    IF wdetail.acc <> "" THEN DO:
       ASSIGN 
        SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  SUBSTRING(wdetail.acc,1,60)   
        SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  SUBSTRING(wdetail.acc,61,60)  
        SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  SUBSTRING(wdetail.acc,121,60) 
        SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  SUBSTRING(wdetail.acc,181,60) 
        SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  SUBSTRING(wdetail.acc,241,60) .
    END.
    ELSE ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  "������ͧ�ػ�ó쵡�������������Թ 20,000 �ҷ" .
    /* end A64-0092*/
    /* comment by A64-0092..
    IF wdetail.acc <> "" THEN DO:
       ASSIGN 
        SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  "�ػ�ó쵡�������������Թ 20,000 �ҷ"
        SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  SUBSTRING(wdetail.acc,1,60)   
        SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  SUBSTRING(wdetail.acc,61,60)  
        SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  SUBSTRING(wdetail.acc,121,60) 
        SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  SUBSTRING(wdetail.acc,181,60) 
        SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  SUBSTRING(wdetail.acc,241,60) .
    END.
    ELSE IF ((INDEX(wdetail.brand,"Ford") <> 0)   AND (deci(wdetail.caryear) = YEAR(TODAY))) THEN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "�ػ�ó쵡�������������Թ 20,000 �ҷ".
    ELSE IF (deci(wdetail.caryear) = YEAR(TODAY)) THEN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "�ػ�ó쵡�������������Թ 30,000 �ҷ".
    ... end A64-0092...*/
    
END.
/* End A63-0210 */
/*ELSE sic_bran.uwm301.prmtxt = "".  */
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
         ASSIGN  sic_bran.uwm301.bchyr = nv_batchyr   /* batch Year */
             sic_bran.uwm301.bchno     = nv_batchno       /* bchno      */
             sic_bran.uwm301.bchcnt    = nv_batcnt .    /* bchcnt     */

         IF wdetail.drivnam1 <> ""  THEN RUN proc_driver.
         ELSE DO:
             /*IF wdetail.prepol <> "" THEN RUN proc_driver2. /*Kridtiya i. A56-0146*/*/
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
                         brstat.mailtxt_fil.bchcnt  = nv_batcnt .
                     ASSIGN nv_drivno = INTEGER(ws0m009.lnumber).
                 END.
             END.
         END.
         s_recid4         = RECID(sic_bran.uwm301).
         IF wdetail.seat = 16 THEN wdetail.seat = 12.
         /*IF wdetail.redbook = "" THEN DO:
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
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.Tons    =  stat.maktab_fil.tons 
                     sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
                     sic_bran.uwm301.body    =  stat.maktab_fil.body
                     sic_bran.uwm301.engine  =  stat.maktab_fil.eng
                     nv_engine               =  stat.maktab_fil.eng.
         END.*/
         /*IF wdetail.redbook  = ""  THEN RUN proc_maktab2.*/
         /*IF wdetail.redbook  = ""  THEN DO: 
             ASSIGN chkred = YES.
             RUN proc_model_brand.
             RUN proc_maktab2. 
         END.*/
 end : A65-0035..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_driver c-Win 
PROCEDURE 00-proc_driver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A67-0087       
------------------------------------------------------------------------------*/
/*DEF VAR no_policy AS CHAR FORMAT "x(20)" .
DEF VAR no_rencnt AS CHAR FORMAT "99".
DEF VAR no_endcnt AS CHAR FORMAT "999".
DEF VAR no_riskno AS CHAR FORMAT "999".
DEF VAR no_itemno AS CHAR FORMAT "999".
DEF VAR n_year    AS DECI INIT 0.
ASSIGN 
    n_year = (YEAR(TODAY) + 543 )
    no_policy = sic_bran.uwm301.policy 
    no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") 
    no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") 
    no_riskno = "001"
    no_itemno = "001".

/*---*/
IF wdetail.driag1 <> "" THEN
    nv_drivage1 =  n_year - INT(SUBSTR(wdetail.driag1,7,4))  .

IF wdetail.driag2 <> "" THEN
    nv_drivage2 =  n_year - INT(SUBSTR(wdetail.driag2,7,4))  .


FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
    brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
    brstat.mailtxt_fil.bchyr   = nv_batchyr   AND                                               
    brstat.mailtxt_fil.bchno   = nv_batchno   AND
    brstat.mailtxt_fil.bchcnt  = nv_batcnt    NO-LOCK  NO-ERROR  NO-WAIT.
IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.    

FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
    brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno     AND
    brstat.mailtxt_fil.lnumber = nv_lnumber    AND
    brstat.mailtxt_fil.bchyr   = nv_batchyr    AND                                               
    brstat.mailtxt_fil.bchno   = nv_batchno    AND
    brstat.mailtxt_fil.bchcnt  = nv_batcnt     NO-LOCK  NO-ERROR  NO-WAIT.

IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
    CREATE brstat.mailtxt_fil.
    ASSIGN                                           
        brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
        brstat.mailtxt_fil.lnumber   = nv_lnumber
        brstat.mailtxt_fil.ltext     = wdetail.drivnam1 + FILL(" ",50 - LENGTH(wdetail.drivnam1))
        brstat.mailtxt_fil.ltext2    = trim(wdetail.driag1) + "  " 
                                       + trim(string(nv_drivage1))
        nv_drivno                    = 1.
    ASSIGN  
        brstat.mailtxt_fil.bchyr                   = nv_batchyr 
        brstat.mailtxt_fil.bchno                   = nv_batchno 
        brstat.mailtxt_fil.bchcnt                  = nv_batcnt 
        SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
        nv_sexdri    = wdetail.drivnam1. 

    /*RUN proc_driversex.*/
    IF INDEX(nv_sexdri,"���") <> 0  THEN ASSIGN SUBSTRING(brstat.mailtxt_fil.ltext,51,6) =  "MALE".
    ELSE IF INDEX(nv_sexdri,"�ҧ") <> 0  THEN ASSIGN SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = "FEMALE".
    ELSE IF INDEX(nv_sexdri,"�.�") <> 0  THEN ASSIGN SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = "FEMALE".
    ELSE  ASSIGN SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = "MALE".

    IF wdetail.drivnam2 <> "" THEN DO:
        CREATE brstat.mailtxt_fil. 
        ASSIGN
            brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
            brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
            brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",50 - LENGTH(wdetail.drivnam2))
            brstat.mailtxt_fil.ltext2   = trim(wdetail.driag2) + "  "
                                          + trim(string(nv_drivage2))
            nv_drivno                   = 2.
        ASSIGN /*a490166*/
            brstat.mailtxt_fil.bchyr                   = nv_batchyr 
            brstat.mailtxt_fil.bchno                   = nv_batchno 
            brstat.mailtxt_fil.bchcnt                  = nv_batcnt 
            SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
            nv_sexdri    = wdetail.drivnam2 . 
        /*RUN proc_driversex.*/
        IF INDEX(nv_sexdri,"���") <> 0  THEN ASSIGN SUBSTRING(brstat.mailtxt_fil.ltext,51,6) =  "MALE".
        ELSE IF INDEX(nv_sexdri,"�ҧ") <> 0  THEN ASSIGN SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = "FEMALE".
        ELSE IF INDEX(nv_sexdri,"�.�") <> 0  THEN ASSIGN SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = "FEMALE".
        ELSE  ASSIGN SUBSTRING(brstat.mailtxt_fil.ltext,51,6) = "MALE".

    END.   /*drivnam2 <> " " */

END.  /*End Avail Brstat*/
ELSE  DO:
    
    CREATE  brstat.mailtxt_fil.
    ASSIGN  brstat.mailtxt_fil.policy = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
        brstat.mailtxt_fil.lnumber    = nv_lnumber
        brstat.mailtxt_fil.ltext      = wdetail.drivnam1 + FILL(" ",50 - LENGTH(wdetail.drivnam1))
        brstat.mailtxt_fil.ltext2     = wdetail.driag1 + "  "
                                        +  TRIM(string(nv_drivage1)).
    IF wdetail.drivnam2 <> "" THEN DO:
        CREATE  brstat.mailtxt_fil.
        ASSIGN
            brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
            brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
            brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",50 - LENGTH(wdetail.drivnam2))
            brstat.mailtxt_fil.ltext2   = wdetail.driag2 + "  "
                                          + TRIM(string(nv_drivage2)).
        ASSIGN  
            brstat.mailtxt_fil.bchyr                   = nv_batchyr 
            brstat.mailtxt_fil.bchno                   = nv_batchno 
            brstat.mailtxt_fil.bchcnt                  = nv_batcnt 
            SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/
    END.   /*drivnam2 <> " " */
END.  /*Else DO*/
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_mailtxt c-Win 
PROCEDURE 00-proc_mailtxt :
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_uwd100 c-Win 
PROCEDURE 00-proc_uwd100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Comment by : A65-0035...
DEF VAR n_cover AS CHAR FORMAT "X(3)" . /*A64-0092*/
/*create  text (F17) for Query claim....*/
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF VAR nv_bptr      AS RECID.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
/* comment by: A64-0092 ...
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt1  = ""  
    nv_txt2  = ""
    /*nv_txt3  = ""  
    nv_txt4  = ""
    nv_txt5  = "" */ 
    /*nv_txt1  = wdetail.remark .*/ /*A60-0118*/
    nv_txt1  = IF index(wdetail.remark,"ISP") <> 0 THEN SUBSTR(wdetail.remark,1,INDEX(wdetail.remark,"ISP") - 2)
               ELSE TRIM(wdetail.remark) .   /*A60-0118*/
/*---A60-0225----*/
FIND LAST stat.insure USE-INDEX insure01 WHERE 
           stat.insure.compno       = TRIM(fi_textf17)        AND
           TRIM(stat.Insure.insno)  = TRIM(wdetail.producer)  AND 
           TRIM(stat.insure.branch) = "F7" NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL stat.insure THEN DO:
            /*ASSIGN nv_txt2 = Trim(stat.insure.Fname) + " " + trim(stat.insure.Lname) .*/ /*A61-0410 */
            /* Create by : A61-0410 */
            /*IF TRIM(wdetail.producer) <> "B3M0044"  THEN DO:*/
            IF TRIM(wdetail.producer) <> "B3M0044" AND TRIM(wdetail.producer) <> "A0M2012"  THEN DO: 
                ASSIGN nv_txt2 = Trim(stat.insure.Fname) + " " + trim(stat.insure.Lname) .
            END.
            ELSE DO:
                 IF index(wdetail.remark,"MPI") <> 0  OR SUBSTR(wdetail.prepol,7,2) = "MI" THEN DO:
                        ASSIGN nv_txt2 = Trim(stat.insure.Fname) + " " + trim(stat.insure.Lname) .
                 END.
                 ELSE ASSIGN nv_txt2 = "" .
            END.
            /* end A61-0410 */
        END.
        ELSE ASSIGN nv_txt2 = "" .
 /*--- end : A60-0225----*/ 

DO WHILE nv_line1 <= 4:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    /*IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.*/  /*A60-0225*/
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2. /*A60-0225*/
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt1. /*A60-0225*/
    IF nv_line1 = 4  THEN wuppertxt.txt = wdetail.acc.   /*A60-0225*/                                      
    
   /* IF nv_line1 = 2  THEN wuppertxt.txt = IF wdetail.producer = fi_producerf    THEN fi_textf17 ELSE "".*/ /*A60-0225*/
    /*IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.*/
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
END.     /*uwm100*/ 
...end A64-0092..*/

/* create by : A64-0092 */
/*create  text (F17) for Query claim....*/
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    n_cover  = ""
    n_cover  = IF index(wdetail.covcod,".") <> 0 THEN TRIM(SUBSTR(wdetail.covcod,1,1) + "+" ) ELSE TRIM(wdetail.covcod)  .
IF wdetail.acc = ""  THEN DO:
    FIND LAST stat.insure USE-INDEX insure01 WHERE 
               stat.insure.compno  = TRIM(fi_textf17)        AND
               stat.Insure.insno   = TRIM(wdetail.producer)  AND 
               stat.Insure.vatcode = TRIM(n_cover)  AND 
               stat.insure.branch  = "F7" NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN DO:
               ASSIGN nv_txt2 = Trim(stat.insure.Fname) .
            END.
            ELSE ASSIGN nv_txt2 = "" .
END.
ELSE DO:
    IF LENGTH(wdetail.acc) <= 110 THEN ASSIGN  nv_txt2 = TRIM(wdetail.acc) .
    ELSE IF LENGTH(wdetail.acc) >  110 THEN DO:
        ASSIGN  nv_txt2 = SUBSTR(wdetail.acc,1,110)
                nv_txt3 = SUBSTR(wdetail.acc,101,110)
                nv_txt4 = SUBSTR(wdetail.acc,211,110).
    END.
END.
    
DO WHILE nv_line1 <= 4:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    /*IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.*/ 
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2. 
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3. 
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.  
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
END.     /*uwm100*/ 
/* end A64-0092 */
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 01-proc_chktest2 c-Win 
PROCEDURE 01-proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by :A67-0087 ..
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
        Else ASSIGN wdetail.pass    = "N"
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
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR (wdetail.covcod = "2.2")  THEN 
        ASSIGN
        sic_bran.uwm130.uom6_v   = inte(wdetail.si) 
        sic_bran.uwm130.uom7_v   = inte(wdetail.si) 
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "2" OR (wdetail.covcod = "3.2") THEN 
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
    IF INDEX(wdetail.remark,"CCTV") <> 0 THEN sic_bran.uwm130.i_text = "0001" . /*A60-0225*/

    IF wdetail.poltyp = "v72" THEN  n_sclass72 = wdetail.subclass.
    ELSE n_sclass72 = wdetail.prempa + wdetail.subclass .
    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do: 
        IF wdetail.prempa = "z"   THEN DO:
            Assign  
            sic_bran.uwm130.uom1_v     = deci(wdetail.tp1)   /*stat.clastab_fil.uom1_si   1000000  */  
            sic_bran.uwm130.uom2_v     = deci(wdetail.tp2)   /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     = deci(wdetail.tp3)   /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  = deci(wdetail.tp1)   /*deci(wdetail.tp_bi)   */ 
            nv_uom2_v                  = deci(wdetail.tp2)   /*deci(wdetail.tp_bi2)  */  
            nv_uom5_v                  = deci(wdetail.tp3).  /*deci(wdetail.tp_bi3)  */ 
        END.
        ELSE DO:
            ASSIGN
                sic_bran.uwm130.uom1_v =  if deci(wdetail.tp1) = 0 then stat.clastab_fil.uom1_si else deci(wdetail.tp1) 
                sic_bran.uwm130.uom2_v =  if deci(wdetail.tp2) = 0 then stat.clastab_fil.uom2_si else deci(wdetail.tp2)
                sic_bran.uwm130.uom5_v =  if deci(wdetail.tp3) = 0 then stat.clastab_fil.uom5_si else deci(wdetail.tp3)
                nv_uom1_v              =  if deci(wdetail.tp1) = 0 then stat.clastab_fil.uom1_si else deci(wdetail.tp1)  
                nv_uom2_v              =  if deci(wdetail.tp2) = 0 then stat.clastab_fil.uom2_si else deci(wdetail.tp2)  
                nv_uom5_v              =  if deci(wdetail.tp3) = 0 then stat.clastab_fil.uom5_si else deci(wdetail.tp3)  
                wdetail.tp1            =  string(nv_uom1_v) 
                wdetail.tp2            =  string(nv_uom2_v) 
                wdetail.tp3            =  string(nv_uom5_v).
        END.
            /* ---- end : A61-0045-----*/
        ASSIGN 
            wdetail.deductpd           =  string(sic_bran.uwm130.uom5_v)
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            wdetail.comper             =  string(stat.clastab_fil.uom8_si)                
            wdetail.comacc             =  string(stat.clastab_fil.uom9_si)
            /*nv_uom1_v                =  sic_bran.uwm130.uom1_v 
            nv_uom2_v                  =  sic_bran.uwm130.uom2_v
            nv_uom5_v                  =  sic_bran.uwm130.uom5_v  */    
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".

        If  wdetail.garage   =  ""  Then
            Assign nv_41     =  deci(wdetail.no_41)
                   nv_42     =  deci(wdetail.no_42)
                   nv_43     =  deci(wdetail.no_43)
                   nv_seat41 =  IF wdetail.seat41 <> 0 THEN wdetail.seat41 ELSE stat.clastab_fil.dri_41 + clastab_fil.pass_41. /*A60-0225*/
                   
        Else If  wdetail.garage  =  "G"  Then
            Assign nv_41       =  deci(wdetail.no_41)
                   nv_42       =  deci(wdetail.no_42)
                   nv_43       =  deci(wdetail.no_43)
                   nv_seat41 =  IF wdetail.seat41 <> 0 THEN wdetail.seat41 ELSE stat.clastab_fil.dri_41 + clastab_fil.pass_41. /*A60-0225*/
    END.
    /* add by : A65-0035 */
    ELSE DO:
        ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Class " + n_sclass72 + " Cover: " + wdetail.covcod + " Not on Paramter (clastab_fil) ". 
    END.
    /* end : A65-0035 */

    ASSIGN  nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                                nv_riskno,
                                nv_itemno).

END.    /* end Do transaction*/
ASSIGN
    s_recid3  = RECID(sic_bran.uwm130)
    nv_covcod =  wdetail.covcod
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
    sic_bran.uwm301.drinam[1] = TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam)  /*A60-0206*/
    sic_bran.uwm301.eng_no   = wdetail.eng
    sic_bran.uwm301.Tons     = INTEGER(wdetail.weight)
    sic_bran.uwm301.engine   = INTEGER(wdetail.engcc)
    sic_bran.uwm301.watts    = IF index(wdetail.subclass,"E") <> 0 THEN INTEGER(wdetail.engcc) ELSE 0  /*A65-0035*/
    sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage   = trim(wdetail.garage)
    sic_bran.uwm301.body     = trim(wdetail.body)
    sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv41seat = IF INT(wdetail.seat41) <> 0 THEN INT(wdetail.seat41) ELSE IF wdetail.seat <> 0 THEN wdetail.seat ELSE nv_seat41  /*A65-0035*/
    sic_bran.uwm301.mv_ben83 = trim(wdetail.benname)
    sic_bran.uwm301.vehreg   = trim(wdetail.vehreg) 
    sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
    sic_bran.uwm301.vehuse   = trim(wdetail.vehuse)
    sic_bran.uwm301.modcod   = trim(wdetail.redbook) 
    /*sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model */     /*-A60-0118-*/ 
    sic_bran.uwm301.moddes   = caps(trim(wdetail.brand)) + " " + caps(trim(wdetail.model)) /*-A60-0118-*/ 
    sic_bran.uwm301.vehgrp   = wdetail.cargrp   
    sic_bran.uwm301.sckno    = 0
    sic_bran.uwm301.itmdel   = NO
    sic_bran.uwm301.logbok   = IF index(wdetail.remark,"ISP") <> 0 THEN "Y" ELSE "N"
    wdetail.tariff           = sic_bran.uwm301.tariff
    sic_bran.uwm301.car_color = wdetail.colorcode. /*A65-0356*/      
        
/* Start A63-0210 */
    RUN proc_chkacctxt.   /*A65-0035*/ 
    IF sic_bran.uwm301.prmtxt <> "" THEN RUN proc_uwd100.
 /* commment by : A65-0035
IF INDEX(wdetail.remark,"FE2+") <> 0 THEN DO: 
    ASSIGN 
        SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  "MT001_PB ������ͧ��û�Сѹ����á�����Ѿ���Թ��ǹ�ؤ��"
        SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  "�����������ö¹�� 20,000 �ҷ" 
        SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  "MT002_FL ������ͧ��û�Сѹ��¤�����ͧ��¹�ӷ�������ع��Сѹ"
        /*SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  "Campaign: C63/00116 (�.2+)" */ /*A64-0092*/
        SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  SUBSTRING(wdetail.acc,1,60) 
        SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  SUBSTRING(wdetail.acc,61,60) 
        SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  SUBSTRING(wdetail.acc,121,60)
        SUBSTRING(sic_bran.uwm301.prmtxt,361,60) =  SUBSTRING(wdetail.acc,181,60)  /*A64-0092*/
        SUBSTRING(sic_bran.uwm301.prmtxt,421,60) =  SUBSTRING(wdetail.acc,241,60). /*A64-0092*/
END.
ELSE do:
    IF wdetail.acc <> "" THEN DO:
       ASSIGN 
            SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  SUBSTRING(wdetail.acc,1,60)   
            SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  SUBSTRING(wdetail.acc,61,60)  
            SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  SUBSTRING(wdetail.acc,121,60) 
            SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  SUBSTRING(wdetail.acc,181,60) 
            SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  SUBSTRING(wdetail.acc,241,60) .
    END.
    /* add by : A65-0035 */
    ELSE IF wdetail.covcod = "1" THEN DO: 
        IF trim(wdetail.brand) = "NISSAN" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)  =  "������ͧ�ػ�ó쵡�������������Թ 30,000 �ҷ" .
        ELSE IF TRIM(wdetail.brand) = "FORD" OR TRIM(wdetail.brand) = "ORA" OR TRIM(wdetail.brand) = "HAVAL" THEN DO:
            IF (YEAR(TODAY) - INT(wdetail.caryear) + 1 ) < 8 THEN DO:
                ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =   "����������ͧ�á�����Ѿ���Թ��ǹ�ؤ������ö 20,000 �ҷ" 
                       SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =   "������ͧ�ػ�ó쵡�������������Թ 20,000 �ҷ" .
            END.
            ELSE  ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)  =  "������ͧ�ػ�ó쵡�������������Թ 20,000 �ҷ" .
        END.
    END. /* end : A65-0035 */
END.
...end A65-0035..*/
/* End A63-0210 */
 /*ELSE sic_bran.uwm301.prmtxt = "".  */
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
  ASSIGN  sic_bran.uwm301.bchyr  = nv_batchyr   /* batch Year */
          sic_bran.uwm301.bchno  = nv_batchno   /* bchno      */
          sic_bran.uwm301.bchcnt = nv_batcnt .  /* bchcnt     */
  IF wdetail.drivnam1 <> ""  THEN RUN proc_driver.
  ELSE DO:
      /*IF wdetail.prepol <> "" THEN RUN proc_driver2. /*Kridtiya i. A56-0146*/*/
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
                  brstat.mailtxt_fil.bchcnt  = nv_batcnt .
              ASSIGN nv_drivno = INTEGER(ws0m009.lnumber).
          END.
      END.
  END.
  s_recid4         = RECID(sic_bran.uwm301).
  IF wdetail.seat = 16 THEN wdetail.seat = 12.
  IF wdetail.redbook = "" THEN RUN proc_maktab. /*A65-0035*/*/
  
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
  DISPLAY fi_loaddat fi_pack fi_chkpro fi_branch fi_producer fi_agent fi_prevbat 
          fi_bchno fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 
          fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname fi_impcnt 
          fi_process fi_producer2 fi_completecnt fi_premtot fi_proname2 
          fi_premsuc fi_compa fi_textf17 fi_camp 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE br_protis fi_loaddat fi_pack fi_chkpro fi_branch fi_producer fi_agent 
         fi_prevbat fi_bchno fi_bchyr fi_filename bu_file fi_output1 fi_output2 
         fi_output3 fi_usrcnt fi_usrprem buok bu_exit bu_hpbrn bu_hpacno1 
         bu_hpagent br_wdetail fi_process fi_producer2 bu_hpacno2 fi_compa 
         fi_textf17 fi_camp RECT-370 RECT-372 RECT-373 RECT-376 RECT-377 
         RECT-378 br_proinsur 
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
    nclass_red     = wdetail.subclass
    wdetail.stk    = substr(wdetail.stk,1,length(TRIM(wdetail.stk))) .
/*comment BY kridtiya i...A56-0104...
IF (wdetail.prepol = "") AND (wdetail.subclass <> "" )  THEN DO:
    FIND FIRST sicsyac.xzmcom  WHERE 
        REPLACE(sicsyac.xzmcom.comp_cod,".","")  = wdetail.subclass  AND 
        substr(xzmcom.class,1,1) = fi_pack   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xzmcom THEN ASSIGN n_sclass72 =   xzmcom.class .
END.
ELSE DO:
    ASSIGN n_sclass72 = wdetail.prempa + wdetail.subclass .
    FIND FIRST sicsyac.xzmcom  WHERE 
         xzmcom.class  = wdetail.prempa + wdetail.subclass  NO-LOCK.
    IF AVAIL sicsyac.xzmcom THEN 
        ASSIGN wdetail.prempa = ""
             wdetail.subclass = REPLACE(sicsyac.xzmcom.comp_cod,".","").
END.
FIND FIRST sicsyac.xzmcom   USE-INDEX xzmcom01   WHERE
    sicsyac.xzmcom.class    = wdetail.prempa + wdetail.subclass   NO-LOCK NO-ERROR .
IF AVAIL sicsyac.xzmcom THEN
    ASSIGN n_sclass72 = wdetail.subclass
    wdetail.subclass  = replace(sicsyac.xzmcom.comp_cod,".","") 
    wdetail.subclass  = replace(wdetail.subclass," ","").
comment BY kridtiya i...A56-0104...*/
/* comment by : A67-0185...
/*Add A56-0104*/
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
    ELSE  MESSAGE COLOR "��辺 Class"  wdetail.prempa + wdetail.subclass  "��� Veh. Use" wdetail.vehuse  
            "���������ҧ���º��º (sicsyac.xzmcom)" VIEW-AS ALERT-BOX.
     
END.
/*Add A56-0104*/
FIND LAST sicsyac.xmm106 WHERE 
    sicsyac.xmm106.tariff  = "9"      AND
    sicsyac.xmm106.bencod  = "comp"   AND
    substr(sicsyac.xmm106.class,1,3) = SUBSTR(wdetail.subclass,1,3)            AND
    sicsyac.xmm106.covcod  = "t"                                               AND 
   (sicsyac.xmm106.baseap  = TRUNCATE(((deci(wdetail.comp_prm) * 100 ) / 107.43 ),0) OR
    sicsyac.xmm106.baseap  = ROUND(((deci(wdetail.comp_prm) * 100 ) / 107.43 ),0))   NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm106 THEN
    ASSIGN wdetail.subclass = sicsyac.xmm106.class .
...end A67-0185...*/ 

RUN proc_chkcomp. /*A67-0185*/

IF wdetail.poltyp = "v72" THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| poltyp �� v72 Compulsory ��ͧ�� y" 
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
        wdetail.comment      = wdetail.comment + "| ��辺 Class ����繢ͧ Policy Type���"
        wdetail.OK_GEN       = "N".
END.
/*---------- covcod ----------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN  wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| ��辺 Cover Type �����к�"
    wdetail.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = wdetail.subclass AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ��辺 Tariff or Compulsory or Class or Cover Type ��к�"
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
    /*IF INDEX(wdetail.brand," ") <> 0 THEN  
        ASSIGN wdetail.model = SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1 )  A65-0035 */
    ASSIGN wdetail.brand = "MERCEDES-BENZ".
    IF index(wdetail.model,"cls") <> 0 THEN DO:
        IF index(wdetail.model," ") <> 0   THEN
            ASSIGN wdetail.model = SUBSTR(wdetail.model,1,index(wdetail.model," ") - 1) +
                                   SUBSTR(wdetail.model,index(wdetail.model," ") + 1) .
        IF index(wdetail.model," ") <> 0   THEN
            ASSIGN wdetail.model = SUBSTR(wdetail.model,1,R-INDEX(wdetail.model," ") - 1) .
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
    ELSE IF INDEX(wdetail.model," ") <> 0 THEN ASSIGN wdetail.model = SUBSTR(wdetail.model,1,R-INDEX(wdetail.model," ") - 1 ).
END.

IF      substr(nclass_red,1,3) = "110"  THEN nclass_red = "110".
ELSE IF substr(nclass_red,1,3) = "120"  THEN nclass_red = "110".
ELSE IF substr(nclass_red,1,3) = "210"  THEN nclass_red = "120".
ELSE IF substr(nclass_red,1,3) = "220"  THEN nclass_red = "220".
ELSE IF substr(nclass_red,1,3) = "320"  THEN nclass_red = "320".
ELSE IF substr(nclass_red,1,3) = "140"  THEN nclass_red = "320".
ELSE IF substr(nclass_red,1,3) = "240"  THEN nclass_red = "320".
IF wdetail.redbook <> "" THEN DO:
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.modcod   = trim(wdetail.redbook)   AND 
        stat.maktab_fil.sclass   = n_sclass72          No-lock no-error no-wait.
    If  avail stat.maktab_fil  THEN DO:
        ASSIGN chkred        =  YES
            nv_modcod        =  stat.maktab_fil.modcod 
            wdetail.redbook  =  stat.maktab_fil.modcod
            wdetail.body     =  stat.maktab_fil.body  
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.weight   =  string(stat.maktab_fil.tons) 
            wdetail.engcc    =  IF wdetail.bev = "Y" THEN STRING(stat.maktab_fil.engine) ELSE  wdetail.engcc /*A67-0087*/
            wdetail.hp       =  STRING(stat.maktab_fil.watt)    /*A67-0087*/
            wdetail.maksi    =  STRING(stat.maktab_fil.si) . /*A67-0087*/
        IF wdetail.seat = 0 THEN wdetail.seat     =  stat.maktab_fil.seats .
    END.
    /*ELSE ASSIGN wdetail.redbook = "" .*/ /*a65-0035*/
    /*A65-0035*/
    IF nv_modcod = "" THEN DO: 
        FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
                   stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
         If  avail stat.maktab_fil  Then DO: 
            ASSIGN  nv_modcod    =  stat.maktab_fil.modcod 
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                wdetail.brand    =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  string(stat.maktab_fil.tons) 
                wdetail.engcc    =  IF wdetail.bev = "Y" THEN STRING(stat.maktab_fil.engine) ELSE  wdetail.engcc /*A67-0087*/
                wdetail.hp       =  STRING(stat.maktab_fil.watt)    /*A67-0087*/
                wdetail.maksi    =  STRING(stat.maktab_fil.si) . /*A67-0087*/
            IF wdetail.seat = 0 THEN wdetail.seat  =  stat.maktab_fil.seats .
         END.
         ELSE DO:
             FIND FIRST sicsyac.xmm102 USE-INDEX xmm10201 WHERE 
                 xmm102.modcod = TRIM(wdetail.redbook)  NO-LOCK NO-ERROR .
              IF AVAIL sicsyac.xmm102 THEN nv_modcod = xmm102.modcod .
              ELSE DO:
                  ASSIGN wdetail.comment = wdetail.comment + "|��辺 Redbook Code " +  wdetail.redbook  + " �ͧ Class " + n_sclass72
                         wdetail.redbook = "" .
              END.
         END.
    END. 
    /* end : A65-0035 */
END.  /*add A57-0088*/
ELSE DO:
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
                /*wdetail.brand    =  stat.maktab_fil.makdes  *//*A65-0035*/
                /*wdetail.model    =  stat.maktab_fil.moddes  *//*A65-0035*/
                wdetail.weight   =  string(stat.maktab_fil.tons)
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.seat     =  stat.maktab_fil.seats 
                wdetail.engcc    =  IF wdetail.bev = "Y" THEN STRING(stat.maktab_fil.engine) ELSE  wdetail.engcc /*A67-0087*/
                wdetail.hp       =  STRING(stat.maktab_fil.watt)    /*A67-0087*/
                wdetail.maksi    =  STRING(stat.maktab_fil.si) . /*A67-0087*/
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
                /*wdetail.brand    =  stat.maktab_fil.makdes *//*A65-0035*/ 
                /*wdetail.model    =  stat.maktab_fil.moddes *//*A65-0035*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  string(stat.maktab_fil.tons)
                wdetail.seat     =  stat.maktab_fil.seats 
                wdetail.engcc    =  IF wdetail.bev = "Y" THEN STRING(stat.maktab_fil.engine) ELSE  wdetail.engcc /*A67-0087*/
                wdetail.hp       =  STRING(stat.maktab_fil.watt)    /*A67-0087*/
                wdetail.maksi    =  STRING(stat.maktab_fil.si) . /*A67-0087*/
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
            /*wdetail.brand    =  stat.maktab_fil.makdes */ /*A65-0035*/ 
            /*wdetail.model    =  stat.maktab_fil.moddes */ /*A65-0035*/
            wdetail.weight   =  string(stat.maktab_fil.tons)
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  stat.maktab_fil.seats 
            wdetail.engcc    =  IF wdetail.bev = "Y" THEN STRING(stat.maktab_fil.engine) ELSE  wdetail.engcc /*A67-0087*/
            wdetail.hp       =  STRING(stat.maktab_fil.watt)    /*A67-0087*/
            wdetail.maksi    =  STRING(stat.maktab_fil.si) . /*A67-0087*/
    END.
    IF nv_modcod = ""  THEN DO: 
        ASSIGN chkred = YES 
            n_brand       = ""
            n_index       = 0
            n_model       = "".
       /* RUN proc_model_brand.*/
        /*RUN proc_maktab.*/
    END.
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
ELSE RUN proc_maktab.
IF wdetail.redbook  = ""  THEN DO: 
    ASSIGN chkred = YES 
        n_brand       = ""
        n_index       = 0
        n_model       = "".
    RUN proc_model_brand.
    /*RUN proc_maktab.*/ /*A65-0035*/
END.*/
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
         sic_bran.uwm301.mv41seat   = IF wdetail.seat41 <> 0 THEN INT(wdetail.seat41) ELSE wdetail.seat  /*A65-0035*/
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
         sic_bran.uwm301.bchyr      = nv_batchyr             /* batch Year */      
         sic_bran.uwm301.bchno      = nv_batchno             /* bchno   */      
         sic_bran.uwm301.bchcnt     = nv_batcnt              /* bchcnt  */  
         sic_bran.uwm301.car_color  = wdetail.colorcode      /* A65-0356*/  
         sic_bran.uwm301.battyr     = INTE(wdetail.battyr)   /*A67-0087*/
         sic_bran.uwm301.battper    = INTE(wdetail.battper)  /*A67-0087*/
         sic_bran.uwm301.watts      = deci(wdetail.hp)       /*A67-0087*/
         sic_bran.uwm301.maksi      = INTE(wdetail.maksi)    /*A67-0087*/     
         sic_bran.uwm301.eng_no2    = trim(wdetail.engno2) . /*A67-0087*/
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
     /*IF wdetail.redbook <> "" THEN DO:     /*�óշ���ա���к� Code ö��*/
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
             MESSAGE "�����ѧ��ҹ Insured (UWD132)" wdetail.policy
                 "�������ö Generage ��������".
             NEXT.
         END.
         CREATE sic_bran.uwd132.
     END.
     ASSIGN  wdetail.comp_prm = string(TRUNCATE(((deci(wdetail.comp_prm)  * 100 ) / 107.43),0))
         sic_bran.uwd132.bencod  = "COMP"                 /*Benefit Code*/
         sic_bran.uwd132.benvar  = ""                     /*Benefit Variable*/
         sic_bran.uwd132.rate    = 0                      /*Premium Rate %*/
         sic_bran.uwd132.gap_ae  = NO                     /*GAP A/E Code*/
         sic_bran.uwd132.gap_c   = deci(wdetail.comp_prm)    /*deci(wdetail.premt)*//*GAP, per Benefit per Item*/
         sic_bran.uwd132.dl1_c   = 0                      /*Disc./Load 1,p. Benefit p.Item*/
         sic_bran.uwd132.dl2_c   = 0                      /*Disc./Load 2,p. Benefit p.Item*/
         sic_bran.uwd132.dl3_c   = 0                      /*Disc./Load 3,p. Benefit p.Item*/
         sic_bran.uwd132.pd_aep  = "E"                    /*Premium Due A/E/P Code*/
         sic_bran.uwd132.prem_c  = deci(wdetail.comp_prm)    /*PD, per Benefit per Item*/
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
                    sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm).
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                               RECID(sic_bran.uwd132),
                                               sic_bran.uwm301.tariff).
                    ASSIGN nv_gap  = nv_gap  + sic_bran.uwd132.gap_c
                        nv_prem    = nv_prem + sic_bran.uwd132.prem_c
                        nv_gap     = deci(wdetail.comp_prm)
                        nv_prem    = deci(wdetail.comp_prm).
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
                    sic_bran.uwd132.gap_c  = deci(wdetail.comp_prm).
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100),         
                                         RECID(sic_bran.uwd132),                
                                         sic_bran.uwm301.tariff).
                    ASSIGN
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c
                    nv_gap        = deci(wdetail.comp_prm)
                    nv_prem       = deci(wdetail.comp_prm).
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
            
            DELETE stat.pmuwd132 .  /* end A65-0035*/
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
DEF BUFFER buwm100 FOR wdetail.
DEF VAR nv_chkstk  AS LOGICAL INIT NO.
DO:
    ASSIGN nv_chkstk  = NO .
    FOR EACH wdetail2   NO-LOCK.
        IF INDEX(wdetail2.policyno,",") <> 0 THEN
            ASSIGN n_policyno = trim(substr(wdetail2.policyno,1,INDEX(wdetail2.policyno,",") - 1 )).
        ELSE n_policyno = trim(wdetail2.policyno).
        IF INDEX(wdetail2.addr2," ") <> 0 THEN DO:
            wdetail2.country = SUBSTR(wdetail2.addr2,R-INDEX(wdetail2.addr2," ")).
            wdetail2.addr2   = SUBSTR(wdetail2.addr2,1,r-INDEX(wdetail2.addr2," ") - 1 ).
            wdetail2.amper   = substr(wdetail2.addr2,INDEX(wdetail2.addr2," ") ).
            wdetail2.country = SUBSTR(wdetail2.country,1,INDEX(wdetail2.country," ") - 1 ).
        END.
        FIND FIRST wdetail WHERE wdetail.policy = n_policyno NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN 
                wdetail.policy      =   trim(n_policyno) 
                wdetail.deler       =   IF INDEX(wdetail2.policyno,",") <> 0 THEN SUBSTR(wdetail2.policyno,INDEX(wdetail2.policyno,",") + 1 ) ELSE ""
                wdetail.caryear     =   trim(wdetail2.caryear)    
                wdetail.eng         =   trim(wdetail2.eng)        
                wdetail.chasno      =   trim(wdetail2.chasno)  
                wdetail.weight      =   trim(wdetail2.engcc)
                wdetail.engcc       =   trim(wdetail2.power)       
                wdetail.vehreg      =   trim(wdetail2.vehreg)     
                wdetail.garage      =   trim(wdetail2.garage)     
                wdetail.fleetper    =   deci(trim(wdetail2.fleetper))   
                wdetail.ncb         =   deci(trim(wdetail2.ncb))        
                wdetail.orthper     =   trim(wdetail2.orthper)    
                wdetail.vehuse      =   ""                           /*A60-0118*/
                wdetail.comdat      =   trim(wdetail2.comdat)    
                wdetail.si          =   trim(wdetail2.si)         
                wdetail.not_office  =  "���ͼ����:" + trim(wdetail2.not_office) +  " ���ʼ����:" + trim(wdetail2.name_insur)  
                wdetail.entdat      =  "Notify date:" +  trim(wdetail2.entdat) + " " + 
                                       "Notify time:" +  trim(wdetail2.enttim) + " " +
                                       "Notify Number:" + TRIM(wdetail2.policyno) /*A60-0225*/
                wdetail.not_code    =   trim(wdetail2.not_code)   
                wdetail.premt       =   trim(wdetail2.premt)   
                wdetail.comp_prm    =   trim(wdetail2.comp_prm)   
                wdetail.stk         =   trim(wdetail2.stk)        
                wdetail.brand       =   trim(wdetail2.brand)        
                wdetail.addr1       =   trim(wdetail2.addr1)        
                wdetail.tambon      =   trim(wdetail2.tambon)       
                wdetail.amper       =   trim(wdetail2.amper)        
                wdetail.country     =   trim(wdetail2.country)      
                wdetail.tiname      =   trim(wdetail2.tiname)      
                wdetail.insnam      =   trim(wdetail2.insnam)      
                wdetail.benname     =   trim(wdetail2.benname)
                /*wdetail.remark      =   trim(wdetail2.remark)*/       /*A60-0118*/
                wdetail.remark      =   trim(wdetail2.remark) + " " + trim(wdetail2.vehuse)   /*A60-0118*/      
                wdetail.Account_no  =   trim(wdetail2.Account_no)   
                wdetail.client_no   =   trim(wdetail2.client_no)    
                wdetail.expdat      =   trim(wdetail2.expdat)       
                wdetail.gap         =   trim(wdetail2.gap)          
                wdetail.re_country  =   trim(wdetail2.re_country)   
                wdetail.receipt_name = trim(wdetail2.receipt_name) 
                wdetail.prepol      =   trim(wdetail2.prepol)
                /*wdetail.drivnam1    =   trim(wdetail2.drivnam1) 
                wdetail.driag1      =   trim(wdetail2.driag1)   
                wdetail.drivnam2    =   trim(wdetail2.drivnam2) 
                wdetail.driag2      =   trim(wdetail2.driag2)*/
                wdetail.deduct      =   trim(wdetail2.deduct)       
                wdetail.branch      =   IF caps(trim(wdetail2.branch)) = "5" THEN "P" ELSE caps(trim(wdetail2.branch))
                wdetail.seat        =   IF (wdetail2.seattisco = "") OR (INTE(wdetail2.seattisco) = 0 ) THEN 0 ELSE INTE(wdetail2.seattisco)     /*  A57-0017 */
                wdetail.prempa      =   IF wdetail2.prempa = "" THEN ""
                                        ELSE IF INDEX(wdetail2.policyno,"TC72") <> 0 THEN "" 
                                        ELSE IF substr(wdetail2.policyno,3,2) = "72" THEN ""
                                        ELSE IF substr(wdetail2.policyno,3,2) = "70" THEN caps(SUBSTR(trim(wdetail2.prempa),1,1)) 
                                        ELSE caps(SUBSTR(trim(wdetail2.prempa),1,1)) 
                wdetail.subclass    =   IF wdetail2.prempa = "" THEN ""
                                        ELSE IF INDEX(wdetail2.policyno,"TC72") <> 0 THEN trim(wdetail2.prempa) 
                                        ELSE IF substr(wdetail2.policyno,3,2) = "72" THEN trim(wdetail2.prempa) 
                                        ELSE IF substr(wdetail2.policyno,3,2) = "70" THEN trim(SUBSTR(wdetail2.prempa,2,4))  /*A64-0035*/
                                        ELSE trim(SUBSTR(wdetail2.prempa,2,4)). 
             ASSIGN                 
                wdetail.tp1         =   trim(wdetail2.tp1)          
                wdetail.tp2         =   trim(wdetail2.tp2)          
                wdetail.tp3         =   trim(wdetail2.tp3)          
                wdetail.covcod      =   IF INDEX(wdetail2.policyno,"TC72") <> 0 THEN "T" 
                                        ELSE IF substr(wdetail2.policyno,3,2) = "72" THEN "T"
                                        ELSE IF substr(wdetail2.policyno,3,2) = "70" THEN trim(wdetail2.covcod)
                                        ELSE trim(wdetail2.covcod)
                wdetail.poltyp      =   IF INDEX(wdetail2.policyno,"TC72") <> 0 THEN "V72" 
                                        ELSE IF substr(wdetail2.policyno,3,2) = "72" THEN "V72"
                                        ELSE IF substr(wdetail2.policyno,3,2) = "70" THEN "V70"
                                        ELSE "V70"
                wdetail.fi          = TRIM(wdetail2.n_fi)
                wdetail.comment     = ""
                wdetail.agent       = IF wdetail2.agent    = "" THEN caps(fi_agent)    ELSE CAPS(TRIM(wdetail2.agent)) /*A60-0095*/
                wdetail.producer    = IF (wdetail2.producer <> "") THEN CAPS(TRIM(wdetail2.producer)) 
                                      ELSE IF (wdetail2.producer = "") AND (deci(trim(wdetail2.caryear)) = YEAR(TODAY)) THEN caps(fi_producer) 
                                      ELSE CAPS(fi_producer2) /*A60-0095*/
                wdetail.trandat     = STRING(fi_loaddat)         /*tran  date*/
                wdetail.trantim     = STRING(TIME,"HH:MM:SS")    /*tran  time*/
                wdetail.n_IMPORT    = "IM"
                wdetail.n_EXPORT    = "" 
                wdetail.acc        = TRIM(wdetail2.caracc)          /*A65-0035*/
                wdetail.Rec_name72 = TRIM(wdetail2.Rec_name72)                    
                wdetail.Rec_add1   = TRIM(wdetail2.Rec_add1)   /*End A63-0210 */  
                wdetail.redbook    = TRIM(wdetail2.redbook)   /*A65-0035*/
                wdetail.seat41     = wdetail.seat /*A65-0035*/
                wdetail.colorcode  = trim(wdetail2.colorcode)    /*A65-0356*/  
                wdetail.brithday   =  wdetail2.brithday          /*A65-0356*/
                /* add by : A67-0087 */
                wdetail.drivnam1    =   trim(wdetail2.drivnam1)  
                wdetail.driag1      =   trim(wdetail2.driag1)
                wdetail.drivocc1    =   TRIM(wdetail2.occupdriv1)
                wdetail.drivicno1   =   trim(wdetail2.positdriv1)
                wdetail.drivnam2    =   trim(wdetail2.drivnam2)  
                wdetail.driag2      =   trim(wdetail2.driag2) 
                wdetail.drivocc2    =   TRIM(wdetail2.occupdriv2)
                wdetail.drivicno2   =   trim(wdetail2.positdriv2)
                wdetail.drivnam3    =   trim(wdetail2.drivename3)
                wdetail.drivag3     =   trim(wdetail2.bdatedriv3)
                wdetail.drivocc3    =   trim(wdetail2.occupdriv3)
                wdetail.drivicno3   =   trim(wdetail2.positdriv3)
                wdetail.Schanel     =   trim(wdetail2.Schanel)       
                wdetail.bev         =   trim(wdetail2.bev)           
                wdetail.drivnam4    =   trim(wdetail2.drivename4)      
                wdetail.drivag4     =   trim(wdetail2.bdatedriv4)    
                wdetail.drivocc4    =   trim(wdetail2.occupdriv4)
                wdetail.drivicno4   =   trim(wdetail2.positdriv4)
                wdetail.drivnam5    =   trim(wdetail2.drivename5)   
                wdetail.drivag5     =   trim(wdetail2.bdatedriv5)   
                wdetail.drivocc5    =   trim(wdetail2.occupdriv5)
                wdetail.drivicno5   =   trim(wdetail2.positdriv5)
                wdetail.campagin    =   trim(wdetail2.campagin)      
                wdetail.inspic      =   trim(wdetail2.inspic)      
                wdetail.engcount    =   trim(wdetail2.engcount)      
                wdetail.engno2      =   trim(wdetail2.engno2)     
                wdetail.engno3      =   trim(wdetail2.engno3)       
                wdetail.engno4      =   trim(wdetail2.engno4)        
                wdetail.engno5      =   trim(wdetail2.engno5)        
                wdetail.classcomp   =   trim(wdetail2.classcomp)       
                wdetail.carbrand    =   trim(wdetail2.carbrand)
                wdetail.hp          =   IF TRIM(wdetail2.bev) = "Y" THEN TRIM(wdetail2.power) ELSE "0"
                wdetail.maksi       =   trim(wdetail2.price_ford)
                wdetail.battyr      =   IF trim(wdetail2.bev) = "Y" THEN trim(wdetail.caryear) ELSE ""
                wdetail.br_insured =  IF trim(wdetail2.n_recbr) = "" THEN trim(wdetail2.n_reccombr) ELSE trim(wdetail2.n_recbr). /*A66-0160*/
                /*--A60-0225--*/
                IF index(wdetail.benname,"�����") <> 0 THEN wdetail.benname = "��Ҥ�÷���� �ӡѴ (��Ҫ�)".
                ELSE IF INDEX(wdetail.benname,"���") <> 0 THEN wdetail.benname = "".
                ELSE DO: 
                    IF      index(wdetail.benname,"�к� 8.3") <> 0 THEN ASSIGN wdetail.benname = trim(REPLACE(wdetail.benname,"�к� 8.3","")). 
                    ELSE IF index(wdetail.benname,"�к�8.3")  <> 0 THEN ASSIGN wdetail.benname = trim(REPLACE(wdetail.benname,"�к�8.3","")).
                    ELSE ASSIGN wdetail.benname = wdetail.benname.
                END.
                /*-- end : A60-0225--*/
               /*  A67-0114...
                IF TRIM(wdetail.bev) = "N" OR TRIM(wdetail.bev) = " " THEN DO: /*A67-0087 */ 
                    FIND LAST brstat.insure WHERE brstat.insure.insno = TRIM(fi_camp) AND 
                                                  brstat.insure.text3 = TRIM(wdetail.prempa) NO-LOCK NO-ERROR NO-WAIT .
                    IF AVAIL brstat.insure THEN DO:
                        ASSIGN 
                            wdetail.tp1    = IF deci(wdetail.tp1)   = 0 THEN brstat.insure.lname       ELSE wdetail.tp1  .
                            wdetail.tp2    = IF deci(wdetail.tp2)   = 0 THEN brstat.insure.addr1       ELSE wdetail.tp2  .
                            wdetail.tp3    = IF deci(wdetail.tp3)   = 0 THEN brstat.insure.addr2       ELSE wdetail.tp3  .
                            wdetail.no_41  = IF deci(wdetail.no_41) = 0 THEN deci(brstat.insure.addr3) ELSE wdetail.no_41.
                            wdetail.no_42  = IF deci(wdetail.no_42) = 0 THEN deci(brstat.insure.addr4) ELSE wdetail.no_42.
                            wdetail.no_43  = IF deci(wdetail.no_43) = 0 THEN deci(brstat.insure.telno) ELSE wdetail.no_43. 
                    END.
                END.
                /* add : A67-0087 */
                ELSE DO:*/ /*A67-0114*/
                /* Add by : A67-0114 */
                FIND LAST brstat.insure WHERE brstat.insure.insno = TRIM(fi_camp) AND
                                              index(wdetail.brand,brstat.insure.text1) <> 0 AND 
                                              brstat.insure.text3 = TRIM(wdetail.prempa) NO-LOCK NO-ERROR NO-WAIT .
                IF AVAIL brstat.insure THEN DO:
                    ASSIGN 
                        wdetail.tp1    = IF deci(wdetail.tp1)   = 0 THEN brstat.insure.lname       ELSE wdetail.tp1  .
                        wdetail.tp2    = IF deci(wdetail.tp2)   = 0 THEN brstat.insure.addr1       ELSE wdetail.tp2  .
                        wdetail.tp3    = IF deci(wdetail.tp3)   = 0 THEN brstat.insure.addr2       ELSE wdetail.tp3  .
                        wdetail.no_41  = IF deci(wdetail.no_41) = 0 THEN deci(brstat.insure.addr3) ELSE wdetail.no_41.
                        wdetail.no_42  = IF deci(wdetail.no_42) = 0 THEN deci(brstat.insure.addr4) ELSE wdetail.no_42.
                        wdetail.no_43  = IF deci(wdetail.no_43) = 0 THEN deci(brstat.insure.telno) ELSE wdetail.no_43. 
                END.
                ELSE DO:
                    FIND LAST brstat.insure WHERE brstat.insure.insno = TRIM(fi_camp) AND 
                                                  brstat.insure.text3 = TRIM(wdetail.prempa) NO-LOCK NO-ERROR NO-WAIT .
                    IF AVAIL brstat.insure THEN DO:
                        ASSIGN 
                            wdetail.tp1    = IF deci(wdetail.tp1)   = 0 THEN brstat.insure.lname       ELSE wdetail.tp1  .
                            wdetail.tp2    = IF deci(wdetail.tp2)   = 0 THEN brstat.insure.addr1       ELSE wdetail.tp2  .
                            wdetail.tp3    = IF deci(wdetail.tp3)   = 0 THEN brstat.insure.addr2       ELSE wdetail.tp3  .
                            wdetail.no_41  = IF deci(wdetail.no_41) = 0 THEN deci(brstat.insure.addr3) ELSE wdetail.no_41.
                            wdetail.no_42  = IF deci(wdetail.no_42) = 0 THEN deci(brstat.insure.addr4) ELSE wdetail.no_42.
                            wdetail.no_43  = IF deci(wdetail.no_43) = 0 THEN deci(brstat.insure.telno) ELSE wdetail.no_43. 
                    END.
                END.
                /* end : A67-0114 */
                /*END.  A67-0114*/
                /*end : A67-0087 */
            /* A63-0122 */
            IF wdetail.poltyp = "V70" AND wdetail.prempa <> "U" AND DATE(wdetail.comdat) >= 04/01/2020 THEN DO:
                ASSIGN wdetail.prempa = "T"  .
            END.
            /* end a63-0122 */
        END. /* end if not */
    END.
    FOR EACH wdetail NO-LOCK.
        IF (wdetail.stk <> "" ) AND (wdetail.poltyp = "V72" ) THEN DO:
            FOR EACH buwm100 WHERE buwm100.stk   =  wdetail.stk AND
                                   buwm100.poltyp = "V72"       NO-LOCK.
                IF  buwm100.policyno <>  wdetail.policyno  THEN DO:
                    MESSAGE "���Ţʵ���������������ǡѹ : " wdetail.policy  wdetail.stk  VIEW-AS ALERT-BOX.
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
DO:
    ASSIGN fi_process = "Start create wdetail...".
    DISP fi_process WITH FRAM fr_main.
    For each  wdetail2 :
        DELETE  wdetail2.
    END.
    For each  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail2.
        IMPORT DELIMITER "|" 
            wdetail2.Pro_off       /*  1   Processing Office   00  */                                     
            wdetail2.cmr_code      /*  2   CMR  code   KTY */                                             
            wdetail2.comcode       /*  3   Insur.comp  510 */                                             
            wdetail2.policyno      /*  4   notify number   TC702053047 */                                 
            wdetail2.caryear       /*  5   Caryear     2003    */                                         
            wdetail2.eng           /*  6   Engine  QG16T24033  */                                         
            wdetail2.chasno        /*  7   Chassis     CDGARSAN16A64477    */                             
            wdetail2.engcc         /*  8   Weight  1200    */                                             
            wdetail2.power         /*  9   Power   1597    */                                             
            wdetail2.colorcode     /*  10  Color       */                                                 
            wdetail2.vehreg        /*  11  licence no  ɰ 5774 */                                         
            wdetail2.garage        /*  12  garage  1   */                                                 
            wdetail2.fleetper      /*  13  fleet disc.     0   */                                         
            wdetail2.ncb           /*  14  ncb disc.   0   */                                             
            wdetail2.orthper       /*  15  other disc.     0   */                                         
            wdetail2.vehuse        /*  16  vehuse      */                                                 
            wdetail2.comdat        /*  17  comdat      21/05/12    */                                     
            wdetail2.si            /*  18  sum si  0   */                                                 
            wdetail2.name_insur    /*  19  �������˹�ҷ���Сѹ   3250500043445   */                     
            wdetail2.not_office    /*  20  �������˹�ҷ���駻�Сѹ   ORANONG POLSUK TEL.0-2633-5469  */ 
            wdetail2.entdat        /*  21  �ѹ����駻�Сѹ    22/06/12    */                             
            wdetail2.enttim        /*  22  �����駻�Сѹ  10:58:23    */                                 
            wdetail2.not_code      /*  23  �����駧ҹ     */                                             
            wdetail2.premt         /*  24  prem.1  1854.79 */                                             
            wdetail2.comp_prm      /*  25  comp.prm    0   */                                             
            wdetail2.stk           /*  26  sticker         */                                             
            wdetail2.brand         /*  27  brand   NISSAN SUNNY 1.6 A/T    */                             
            wdetail2.addr1         /*  28  address1    9/40 ������ 2 ������º��ͧ 3   */                 
            /*wdetail2.addr2         /*  28  address1    9/40 ������ 2 ������º��ͧ 3   */                 */
            wdetail2.tambon        /*  29  address2    �.�֧����  */                                     
            wdetail2.amper         /*  30  address3    �.�ѭ����   */                                     
            wdetail2.country       /*  31  address4    �.�����ҹ� 12130    */                             
            wdetail2.tiname        /*  32  title name      �ҧ */                                         
            wdetail2.insnam        /*  33  first name  �ԸԹҶ �ͧ�ت  */                                 
            /*wdetail2.lastname    */
            wdetail2.benname       /*  34  beneficiary     �к� 8.3 ��Ҥ�÷���� �ӡѴ (��Ҫ�) */         
            wdetail2.remark        /*  35  remark.     MV20020522_70new1_MV20020522_70new1 */             
            wdetail2.Account_no    /*  36  account no.     0002053047  */                                 
            wdetail2.client_no     /*  37  client No.  9660275 */                                         
            wdetail2.expdat        /*  38  expiry date     21/05/13    */                                 
            wdetail2.gap           /*  39  insurance amt.      1854.79 */                                 
            wdetail2.re_country    /*  40  province    BKK */                                             
            wdetail2.receipt_name  /*  41  receipt name    �ҧ �ԸԹҶ �ͧ�ت  */                         
            wdetail2.agenttis      /*  42  agent code  TISCO   */                                         
            wdetail2.prev_insur    /*  43  ����ѷ��Сѹ������     KRUNGTHAI PANICH INSURANCE CO.,LTD. */ 
            wdetail2.prepol        /*  44  old policy          */       
            wdetail2.deduct       
            wdetail2.addr1_70     
            wdetail2.addr2_70     
            wdetail2.nsub_dist70  
            wdetail2.ndirection70 
            wdetail2.nprovin70    
            wdetail2.zipcode70    
            wdetail2.addr1_72     
            wdetail2.addr2_72     
            wdetail2.nsub_dist72  
            wdetail2.ndirection72 
            wdetail2.nprovin72    
            wdetail2.zipcode72    
            wdetail2.apptyp       
            wdetail2.appcode
            wdetail2.caracc
            wdetail2.prempa       
            wdetail2.seattisco    
            wdetail2.tp1          
            wdetail2.tp2          
            wdetail2.tp3          
            wdetail2.covcod       
            wdetail2.producer     
            wdetail2.agent        
            wdetail2.branch       
            wdetail2.n_type       
            wdetail2.redbook      
            wdetail2.price_ford   
            wdetail2.yrmanu       
            wdetail2.nbrand  
            wdetail2.n_recid      
            wdetail2.n_recbr      
            wdetail2.n_reccomid   
            wdetail2.n_reccombr   
            wdetail2.n_comdat     
            wdetail2.n_expdat     
            wdetail2.n_fi         
            wdetail2.n_clss72     
            wdetail2.veh          
            wdetail2.driveno1
            wdetail2.drivnam1     
            wdetail2.driag1       
            wdetail2.occupdriv1   
            wdetail2.positdriv1 
            wdetail2.driveno2  
            wdetail2.drivnam2     
            wdetail2.driag2       
            wdetail2.occupdriv2   
            wdetail2.positdriv2 
            wdetail2.driveno3     
            wdetail2.drivename3   
            wdetail2.bdatedriv3   
            wdetail2.occupdriv3   
            wdetail2.positdriv3 
            wdetail2.caracc        /*Str A63-0210 */
            wdetail2.recept72     
            wdetail2.acc          
            wdetail2.Rec_name72   
            wdetail2.Rec_add1     
            wdetail2.n_comment    /*end A63-0210 */  
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
    END.   /* repeat  */        
    FOR EACH wdetail2  NO-LOCK.
        IF      index(wdetail2.Pro_off,"����ѷ") > 0 THEN DELETE wdetail2.
        ELSE IF index(wdetail2.Pro_off,"Pro") >    0 THEN DELETE wdetail2.
        ELSE IF index(wdetail2.Pro_off,"Totle") >  0 THEN DELETE wdetail2.
        ELSE IF wdetail2.policyno = ""               THEN DELETE wdetail2.
        ELSE IF wdetail2.Pro_off = ""                THEN DELETE wdetail2.
    END.
    RUN proc_assign.
   
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
DEF VAR  b_eng   AS DECI FORMAT  ">>>>9.99-".
DEF VAR  n_date  AS CHAR FORMAT  "x(10)". 
DEF VAR  ind1 AS INTE.
DEF VAR  ind2 AS INTE.
DEF VAR  ind3 AS INTE.
DEF VAR  ind4 AS INTE. 
DEF VAR  n_char AS CHAR FORMAT  "x(75)".
FOR EACH wdetail WHERE wdetail.policy  NE " "  .
    ASSIGN 
        ind1           = 0 
        ind2           = 0
        ind3           = 0
        ind4           = 0
        /*wdetail.seat   = 0*/ /*A57-0017*/
        n_char         = ""
        n_date         = STRING(TODAY,"99/99/9999") 
        b_eng          = round((DECI(wdetail.engcc) / 1000),1)   
        b_eng          = b_eng * 1000 
        wdetail.tariff = IF wdetail.poltyp = "v72" THEN "9" ELSE "X"
        wdetail.vehuse = IF wdetail.vehuse = "" THEN "1" ELSE wdetail.vehuse
        fi_process     = "Check data wdetail...".

    /*IF  LENGTH(wdetail.engcc) = 2 THEN wdetail.engcc  = string(deci(wdetail.engcc) * 100 ) .*/ /*A67-0114*/
    IF DECI(wdetail.engcc) <= 99 THEN wdetail.engcc = string(deci(wdetail.engcc) * 100 ) . /*A67-0114*/
    ELSE IF DECI(wdetail.engcc) < 1000 AND wdetail.bev = "Y"  THEN wdetail.engcc = trim(wdetail.engcc) . /*A67-0114*/
    ELSE IF DECI(wdetail.engcc) > 1000 THEN wdetail.engcc = trim(wdetail.engcc) . /*A67-0114*/
    ELSE wdetail.engcc  = STRING(b_eng).
    IF wdetail.bev = "Y" THEN ASSIGN wdetail.hp = wdetail.engcc . /*A67-0114*/

    DISP fi_process WITH FRAM fr_main .
    IF wdetail.seat = 0 THEN DO:
        IF      (substr(wdetail.subclass,1,3) = "110") OR (substr(wdetail.subclass,1,3) = "120" )  THEN wdetail.seat = 7 .
        ELSE IF (substr(wdetail.subclass,1,3) = "320") OR (substr(wdetail.subclass,1,3)  = "140") OR 
            (substr(wdetail.subclass,1,3) = "140") THEN  wdetail.seat = 3.
        ELSE IF (substr(wdetail.subclass,1,3) = "210" ) OR ( substr(wdetail.subclass,1,3)  = "220" ) THEN wdetail.seat = 12.
        ELSE wdetail.seat = 7 .
        ASSIGN wdetail.seat41 = wdetail.seat . /*A65-0035*/
    END.
    IF wdetail.poltyp = "v70" THEN wdetail.stk = "".
   /*A54-0141 */
    FIND FIRST brstat.msgcode WHERE 
        brstat.msgcode.compno = "999" AND
        brstat.msgcode.MsgDesc = wdetail.tiname   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.msgcode THEN 
        ASSIGN wdetail.tiname = brstat.msgcode.branch.
    /*A54-0141 */
    IF wdetail.tiname = "�س"   THEN DO:
        ASSIGN wdetail.tiname = "�س".
        IF wdetail.receipt_name <> "" THEN DO: 
            IF INDEX(wdetail.receipt_name,trim(wdetail.insnam)) = 0 THEN
                wdetail.receipt_name = "���/���� " + wdetail.receipt_name.
            ELSE wdetail.receipt_name = "".
        END.
    END.
    ELSE DO:
        IF wdetail.receipt_name <> "" THEN DO: 
            IF INDEX(wdetail.receipt_name,trim(wdetail.insnam)) = 0 THEN
                wdetail.receipt_name = "���/���� " + wdetail.receipt_name.
            ELSE wdetail.receipt_name = "".
        END.
        ELSE wdetail.receipt_name = "".
    END.
    IF wdetail.covcod = "3" THEN wdetail.ncb = 30.
    IF wdetail.garage = "0" THEN  wdetail.garage   = "G".
    ELSE wdetail.garage   = " ".
    /*RUN proc_cutchar.*/
    IF wdetail.vehreg = "" THEN wdetail.vehreg = "/" +  SUBSTRING(wdetail.chasno,LENGTH(wdetail.chasno) - 8) . 
    ELSE IF LENGTH(trim(wdetail.re_country)) <> 2 THEN DO:  /*--A60-0095--*/
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
            brstat.insure.compno = "999" AND 
            brstat.insure.FName  = TRIM(wdetail.re_country) NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN DO:
            ASSIGN wdetail.re_country = brstat.Insure.LName
            wdetail.vehreg = trim(substr(wdetail.vehreg,1,8) + " " + trim(wdetail.re_country)) .   /*a54-0112*/
                                           
        END.
        ELSE DO:
            /*--A60-0095--*/
            RUN proc_province.
            IF wdetail.re_country <> "" THEN
                wdetail.vehreg = TRIM(wdetail.vehreg) + " " + trim(wdetail.re_country) .
            /*--A60-0095--*/
            ELSE wdetail.vehreg = trim(substr(wdetail.vehreg,1,8)).                                    /*a54-0112*/
        END.
    END.
    ELSE ASSIGN wdetail.vehreg = trim(wdetail.vehreg) + " " + trim(wdetail.re_country). /*--A60-0095--*/
    
    IF INDEX(wdetail.addr1,fi_compa) <> 0 THEN DO:
        FIND FIRST stat.company WHERE company.compno = fi_compa NO-LOCK NO-ERROR.
        IF AVAIL stat.company  THEN
            wdetail.addr1 = company.addr1 + " " + company.addr2.
        ELSE wdetail.addr1 = "".
        IF INDEX(wdetail.addr1,"��ا෾") <> 0 THEN  /*����ҷ��˹�� �ǧ���� ࢵ�ҧ�ѡ ��ا෾� 10500  */    
            ASSIGN wdetail.country = SUBSTR(wdetail.addr1,INDEX(wdetail.addr1,"��ا෾"))
            wdetail.addr1          = SUBSTR(wdetail.addr1,1,INDEX(wdetail.addr1,"��ا෾") - 1)   .
        IF INDEX(wdetail.addr1,"ࢵ") <> 0 THEN
            ASSIGN wdetail.amper   = SUBSTR(wdetail.addr1,INDEX(wdetail.addr1,"ࢵ"))
            wdetail.addr1          = SUBSTR(wdetail.addr1,1,INDEX(wdetail.addr1,"ࢵ") - 1)   .
        IF INDEX(wdetail.addr1,"�ǧ") <> 0 THEN
            ASSIGN wdetail.tambon   = SUBSTR(wdetail.addr1,INDEX(wdetail.addr1,"�ǧ"))
            wdetail.addr1          = SUBSTR(wdetail.addr1,1,INDEX(wdetail.addr1,"�ǧ") - 1)   .
    END.
    ELSE IF LENGTH(wdetail.addr1) > 45 THEN DO:  /*moo soy road*/
        /*road */
        IF INDEX(wdetail.addr1,"���") <> 0  THEN DO:
            ASSIGN wdetail.road = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"���")))
                wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"���") - 1 )).
            IF LENGTH(wdetail.addr1) > 45  THEN DO:
                IF INDEX(wdetail.addr1,"���") <> 0  THEN
                    ASSIGN 
                    wdetail.soy    = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"���")))
                    wdetail.addr1  = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"���") - 1 ))
                    wdetail.tambon = trim(wdetail.soy)     + " " + trim(wdetail.road )  
                    wdetail.amper  = trim(wdetail.tambon)  + " " + trim(wdetail.amper) .
                ELSE IF INDEX(wdetail.addr1,"�.") <> 0  THEN
                    ASSIGN 
                    wdetail.soy     = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"�.")))
                    wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"�.") - 1) )
                    wdetail.tambon  = trim(wdetail.soy)    + " " + trim(wdetail.road ) 
                    wdetail.amper   = trim(wdetail.tambon) + " " + trim(wdetail.amper).
            END.   /*end  soy...*/
            ELSE ASSIGN 
                wdetail.tambon  = trim(wdetail.road)  + " " + trim(wdetail.tambon) .
                /*wdetail.amper   = wdetail.amper + " " + wdetail.country */ . /* A64-0138 */
        END.      /*end  road..*/
        ELSE IF INDEX(wdetail.addr1,"�.") <> 0  THEN DO:
            ASSIGN wdetail.road = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"�.")))
                wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"�.") - 1 )).
            IF LENGTH(wdetail.addr1) > 45  THEN DO:
                IF INDEX(wdetail.addr1,"���") <> 0  THEN
                    ASSIGN 
                    wdetail.soy     = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"���")))
                    wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"���") - 1 ))
                    wdetail.tambon  = trim(wdetail.soy)     + " " + trim(wdetail.road ) 
                    wdetail.amper   = trim(wdetail.tambon)  + " " + trim(wdetail.amper).
                ELSE IF INDEX(wdetail.addr1,"�.") <> 0  THEN
                    ASSIGN 
                    wdetail.soy     = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"�.")))
                    wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"�.") - 1 )) 
                    wdetail.tambon  = trim(wdetail.soy)      + " " + trim(wdetail.road ) 
                    wdetail.amper   = trim(wdetail.tambon)   + " " + trim(wdetail.amper).
            END.  /*end  soy...*/
            ELSE ASSIGN wdetail.tambon  = trim(wdetail.road)  + " " + trim(wdetail.tambon) . /*A64-0138 date.28/06/2021 */
        END.      /*end  road..*/
        ELSE IF INDEX(wdetail.addr1,"�.") <> 0  THEN DO:
            ASSIGN 
            wdetail.soy     = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"�.")))
            wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"�.") - 1 )) 
            wdetail.tambon  = trim(wdetail.soy) + " " + trim(wdetail.tambon)  .
            /*wdetail.amper   = wdetail.amper  + " " + wdetail.country */  /*A64-0138*/
            /*wdetail.country = "" .                                   */  /*A64-0138*/
        END.
        ELSE IF INDEX(wdetail.addr1,"���") <> 0 THEN DO:
            ASSIGN 
            wdetail.soy     = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1,"���")))
            wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1,"���") - 1 ))
            wdetail.tambon  = trim(wdetail.soy) + " " + trim(wdetail.tambon) .
            /*wdetail.amper   = wdetail.amper  + " " + wdetail.country */  /*A64-0138*/
            /*wdetail.country = "" .                                   */  /*A64-0138*/
        END.
        ELSE IF R-INDEX(wdetail.addr1,"����") <> 0  THEN DO:
            ASSIGN  wdetail.moo     = trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"����")))
                    wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"����") - 1 ))
                    wdetail.tambon  = trim(wdetail.moo)   + " " + trim(wdetail.tambon)  .
                    /*wdetail.amper   = wdetail.amper  + " " + wdetail.country */  /*A64-0138*/
                    /*wdetail.country = "" .                                   */  /*A64-0138*/
        END.
        ELSE IF R-INDEX(wdetail.addr1,"���.") <> 0  THEN DO:
            ASSIGN  
                wdetail.moo     = Trim(SUBSTR(wdetail.addr1,R-INDEX(wdetail.addr1,"���.")))
                wdetail.addr1   = trim(SUBSTR(wdetail.addr1,1,R-INDEX(wdetail.addr1,"���.") - 1 )).
            IF LENGTH(wdetail.moo + " " + wdetail.tambon) <= 45 THEN
                ASSIGN 
                wdetail.tambon  = trim(wdetail.moo)   + " " + trim(wdetail.tambon)  .
               /*wdetail.amper   = wdetail.amper  + " " + wdetail.country */  /*A64-0138*/
               /*wdetail.country = "" .                                   */  /*A64-0138*/
            ELSE IF LENGTH(wdetail.moo) > 45 THEN DO:
                IF R-INDEX(wdetail.moo,"���") <> 0  THEN  
                    ASSIGN 
                    wdetail.amper  = trim(SUBSTR(wdetail.moo,R-INDEX(wdetail.moo,"���"))) 
                                     + " " + trim(wdetail.tambon) 
                                     + " " + trim(wdetail.amper) 
                    wdetail.tambon = trim(SUBSTR(wdetail.moo,1,R-INDEX(wdetail.moo,"���") - 1 )).
            END.
        END.
        /* comment by : A63-0138...
        IF LENGTH(wdetail.amper) > 35 THEN DO:
            IF r-INDEX(wdetail.amper,"�.") <> 0 THEN
                ASSIGN 
                wdetail.country = SUBSTR(wdetail.amper,r-INDEX(wdetail.amper,"�.")) + " " + wdetail.country
                wdetail.amper   = SUBSTR(wdetail.amper,1,r-INDEX(wdetail.amper,"�.") - 1).
            ELSE IF r-INDEX(wdetail.amper,"�����") <> 0 THEN
                ASSIGN 
                wdetail.country = SUBSTR(wdetail.amper,r-INDEX(wdetail.amper,"�����")) + " " + wdetail.country
                wdetail.amper   = SUBSTR(wdetail.amper,1,r-INDEX(wdetail.amper,"�����") - 1).
            ELSE IF r-INDEX(wdetail.amper,"ࢵ") <> 0 THEN
                ASSIGN 
                wdetail.country = SUBSTR(wdetail.amper,r-INDEX(wdetail.amper,"ࢵ")) + " " + wdetail.country
                wdetail.amper   = SUBSTR(wdetail.amper,1,r-INDEX(wdetail.amper,"ࢵ") - 1).
            IF LENGTH(wdetail.amper) > 35 THEN ASSIGN wdetail.amper = REPLACE(wdetail.amper," ","") .
        END.
        ...end A14-0138..*/
        /* add by : A63-0138 */
        IF LENGTH(wdetail.amper) > 45 THEN DO:
            wdetail.amper = trim(wdetail.amper) + " " + trim(wdetail.country) .

            IF r-INDEX(wdetail.amper,"�.") <> 0 THEN
                ASSIGN 
                wdetail.country = trim(SUBSTR(wdetail.amper,r-INDEX(wdetail.amper,"�.")))
                wdetail.amper   = trim(SUBSTR(wdetail.amper,1,r-INDEX(wdetail.amper,"�.") - 1)).
            ELSE IF r-INDEX(wdetail.amper,"�ѧ��Ѵ") <> 0 THEN 
                ASSIGN 
                wdetail.country = trim(SUBSTR(wdetail.amper,r-INDEX(wdetail.amper,"�ѧ��Ѵ")))
                wdetail.amper   = trim(SUBSTR(wdetail.amper,1,r-INDEX(wdetail.amper,"�ѧ��Ѵ") - 1)).
            ELSE IF r-INDEX(wdetail.amper,"ࢵ") <> 0 THEN
                ASSIGN 
                wdetail.country = trim(SUBSTR(wdetail.amper,r-INDEX(wdetail.amper," ")))
                wdetail.amper   = trim(SUBSTR(wdetail.amper,1,INDEX(wdetail.amper," ") - 1)).
            IF LENGTH(wdetail.amper) > 45 THEN ASSIGN wdetail.amper = trim(REPLACE(wdetail.amper," ","")) .
            
        END.
        /*...end A14-0138..*/
    END.
    
    /*IF (INDEX(wdetail.brand,"Ford") <> 0) AND (deci(wdetail.caryear) = YEAR(TODAY)) THEN DO:*/ /*A60-0405*/
    IF (INT(wdetail.caryear) = YEAR(TODAY)) THEN DO:      /*A60-0405*/
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno = "TISCO" AND
            index(wdetail.deler,stat.insure.lname) <> 0 NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL stat.insure THEN 
            ASSIGN wdetail.deler = stat.Insure.insno  .
        /* A65-0035*/
        ELSE DO:
            FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno = "GWM" AND
            index(wdetail.deler,stat.insure.lname) <> 0 NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN 
                ASSIGN wdetail.deler = stat.Insure.insno  .
            ELSE wdetail.deler = "" .
        END.
        /* end : A65-0035 */
    END.
    ELSE wdetail.deler = "" .
    /*Add by Kridtiya i. A63-0472*/ 
    RUN proc_assign2addr (INPUT  trim(wdetail.tambon)    
                         ,INPUT  trim(wdetail.amper)    
                         ,INPUT  trim(wdetail.country)   
                         ,INPUT  ""     /*wdetail.occup  */ 
                         ,OUTPUT wdetail.codeocc  
                         ,OUTPUT wdetail.codeaddr1
                         ,OUTPUT wdetail.codeaddr2
                         ,OUTPUT wdetail.codeaddr3).
    IF nv_postcd <> "" THEN DO:
        ASSIGN wdetail.postcd = nv_postcd.
        IF      INDEX(wdetail.country,nv_postcd) <> 0 THEN wdetail.country = trim(REPLACE(wdetail.country,nv_postcd,"")).
        ELSE IF INDEX(wdetail.amper,nv_postcd)   <> 0 THEN wdetail.amper   = trim(REPLACE(wdetail.amper,nv_postcd,"")).
        ELSE IF INDEX(wdetail.tambon,nv_postcd)  <> 0 THEN wdetail.tambon  = trim(REPLACE(wdetail.tambon,nv_postcd,"")). 
    END.
    RUN proc_matchtypins (INPUT  trim(wdetail.tiname)  
                         ,INPUT  trim(wdetail.insnam)  
                         ,OUTPUT wdetail.insnamtyp
                         ,OUTPUT wdetail.firstName
                         ,OUTPUT wdetail.lastName).
    /*Add by Kridtiya i. A63-0472*/ 
   /*Add by : A65-0035  */  
   IF INDEX(wdetail.brand," ") <> 0 THEN DO:
       ASSIGN 
       wdetail.model = trim(SUBSTR(wdetail.brand,INDEX(wdetail.brand," ") + 1 ))
       wdetail.brand = TRIM(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) .
   END.
   IF wdetail.redbook = ""  THEN DO:
       ASSIGN fi_process = "check Redbook " + wdetail.policy + " " + wdetail.chasno + ".....".
       DISP fi_process WITH FRAM fr_main.
       nv_si = 0.
       nv_si = INT(wdetail.si).
       /*RUN wgw/wgwredbook(input  wdetail.brand , *//*A65-0035*/
       IF wdetail.bev = "N" THEN DO: /*A67-0087*/
        RUN wgw/wgwredbk1(input  wdetail.brand ,  /*A65-0035*/
                          input  wdetail.model ,  
                          input  nv_si         ,  
                          INPUT  wdetail.tariff,  
                          input  wdetail.subclass,   
                          input  wdetail.caryear, 
                          input  wdetail.engcc  ,
                          input  wdetail.weight , 
                          INPUT-OUTPUT wdetail.redbook) .
       /* add : A67-0087*/
       END.
       ELSE DO:
           RUN wgw/wgwredbev(input wdetail.brand ,      
                             input wdetail.model ,  
                             input nv_si ,  
                             INPUT wdetail.tariff,  
                             input wdetail.subclass,   
                             input wdetail.caryear, 
                             input wdetail.hp,
                             input 0, 
                             INPUT-OUTPUT wdetail.maksi,
                             INPUT-OUTPUT wdetail.redbook) .
       END.
       /* end :A67-0087 */
   END. 
  
    /* comment by : A67-0087
    IF  INDEX(wdetail.brand,"HAVAL")  <> 0 OR INDEX(wdetail.brand,"ORA") <> 0 THEN    /*A66-0070*/
        ASSIGN 
        wdetail.tp1    = "1000000" 
        wdetail.tp2    = "10000000" 
        wdetail.tp3    = "5000000" 
        wdetail.no_41  = 500000
        wdetail.no_42  = 500000
        wdetail.no_43  = 500000  .*/
    IF wdetail.br_insured <> "" THEN DO:  /*A66-0160*/
        wdetail.br_insured = trim(REPLACE(wdetail.br_insured,"�Ңҷ��","")).  /*A66-0160*/
        IF index(wdetail.br_insured,"�ӹѡ�ҹ�˭�") <> 0 THEN wdetail.br_insured = "00000".  /*A66-0160*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew c-Win 
PROCEDURE proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.*/ /*Add kridtiya i. A54-0062 */
DEF VAR number_sic AS INTE INIT 0.
DEF VAR nv_branchold AS CHAR INIT "" .  /*A63-00472*/
DEFINE VAR nre_premt      AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/
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
                  INPUT-OUTPUT nv_branchold ,     /*wdetail.branch,   /*n_branch  */ */ /*A63-00472*/
                  INPUT-OUTPUT wdetail.deler,    /* A67-0114*/
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
                  INPUT-OUTPUT n_tp1 ,           /* A61-0045*/
                  INPUT-OUTPUT n_tp2 ,           /* A61-0045*/
                  INPUT-OUTPUT n_tp3 ,           /* A61-0045*/
                  INPUT-OUTPUT nv_basere,        /*nv_basere */  
                  INPUT-OUTPUT wdetail.seat,     /* DECI     n_seat     */  
                  INPUT-OUTPUT wdetail.seat41,   /* INTE     */    
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
                  INPUT-OUTPUT n_firstdat,       
                  INPUT-OUTPUT nv_driver,
                  INPUT-OUTPUT nr_premtxt,         /* f6 access renew */
                  INPUT-OUTPUT nre_premt,
                  input-output nr_hp     ,    /*A67-0087*/
                  input-output nr_maksi  ,    /*A67-0087*/
                  input-output wdetail.engno2, /*A67-0087*/
                  INPUT-OUTPUT wdetail.battyr ).   /*A67-0087*/
                  .   /*A64-0138*/
    ASSIGN wdetail.premt  = string(nre_premt)
           wdetail.weight = IF int(wdetail.weight) = 0 THEN string(nv_tons) ELSE wdetail.weight. /*A65-0035*/
    /*ASSIGN wdetail.weight = string(nv_tons). */ /* A63-0122 */
    IF (trim(wdetail.branch)) = "5" THEN ASSIGN wdetail.branch = "P" . 
    ELSE ASSIGN  wdetail.branch = (trim(wdetail.branch)).  /*-A59-0178-*/ 
    /* create by A61-0045*/
     /*a63-0210*/
    IF INDEX(wdetail.remark,"FE2+") <> 0 THEN DO:
        ASSIGN wdetail.prempa = "U"  .
    END.
    /*a63-0210*/
    ELSE IF trim(wdetail.prempa) = "O" THEN DO:
        IF wdetail.tp1 = ""    THEN wdetail.tp1   = n_tp1.
        IF wdetail.tp2 = ""    THEN wdetail.tp2   = n_tp2.
        IF wdetail.tp3 = ""    THEN wdetail.tp3   = n_tp3.
        IF wdetail.no_41 = 0   THEN wdetail.no_41 = n_41.
        IF wdetail.no_42 = 0   THEN wdetail.no_42 = n_42.
        IF wdetail.no_43 = 0   THEN wdetail.no_43 = n_43.
    END.
    ELSE DO:
        ASSIGN wdetail.tp1   = n_tp1 
               wdetail.tp2   = n_tp2 
               wdetail.tp3   = n_tp3 
               wdetail.no_41 = n_41  
               wdetail.no_42 = n_42  
               wdetail.no_43 = n_43.  
    END.
   /*-- end :A61-0045--*/
    /* add A63-0122 */
    IF DATE(wdetail.comdat) >= 04/01/2020  AND 
       trim(wdetail.prempa) <> "A" AND trim(wdetail.prempa) <> "U" THEN DO:
        ASSIGN wdetail.prempa = "T" . 
    END.
    /* A63-0122 */
    /* A67-0087 */
    IF LENGTH(wdetail.subclass) = 4 THEN do:
        ASSIGN wdetail.subclass = "E" + SUBSTR(wdetail.subclass,1,2) .
    END.
    IF nr_hp <> 0 THEN ASSIGN wdetail.hp = STRING(nr_hp).
    IF nr_maksi <> 0 THEN ASSIGN wdetail.maksi = STRING(nr_maksi) .
    /* end : A67-0087 */

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew72 c-Win 
PROCEDURE proc_assignrenew72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR number_sic   AS INTE INIT 0.
DEF VAR n_emtry      AS CHAR INIT "" .
DEF VAR n_emtrydeci  AS DECI INIT 0 .
DEF VAR nv_branchold AS CHAR INIT "". /*A63-00472*/

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
                  INPUT-OUTPUT nv_branchold ,     /*wdetail.branch,   /*n_branch  */ */ /*A63-00472*/
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
                  INPUT-OUTPUT n_emtry,          /*n_covcod  */  
                  INPUT-OUTPUT n_emtry,          /*n_garage  */    
                  INPUT-OUTPUT n_emtry,          /*n_tp1     */  
                  INPUT-OUTPUT n_emtry,          /*n_tp2     */  
                  INPUT-OUTPUT n_emtry,          /*n_tp3     */  
                  INPUT-OUTPUT n_emtrydeci,      /*nv_basere */  
                  INPUT-OUTPUT wdetail.seat,     /* DECI     n_seat     */  
                  INPUT-OUTPUT wdetail.seat41,   /* INTE                */    
                  INPUT-OUTPUT n_emtrydeci,      /* INTE     n_41       */  
                  INPUT-OUTPUT n_emtrydeci,      /* DECI     n_42       */  
                  INPUT-OUTPUT n_emtrydeci,      /* DECI     n_43       */  
                  INPUT-OUTPUT n_emtrydeci,      /* DECI     n_dod      */  
                  INPUT-OUTPUT n_emtrydeci,      /* DECI     n_dod2     */
                  INPUT-OUTPUT n_emtrydeci,      /* DECI     n_pd       */  
                  INPUT-OUTPUT n_emtrydeci,      /* DECI    _feet       */  
                  INPUT-OUTPUT n_emtrydeci,      /* DECI     nv_dss_per */  
                  INPUT-OUTPUT n_emtrydeci,      /* DECI     n_ncb      */  
                  INPUT-OUTPUT n_emtrydeci,      /* DECI     n_lcd      */  
                  INPUT-OUTPUT n_firstdat ).     /* DECI     n_firstdat */
    /*ASSIGN wdetail.weight = string(nv_tons).*/ /*A65-0035*/
    ASSIGN wdetail.weight = IF int(wdetail.weight) = 0 THEN string(nv_tons) ELSE wdetail.weight. /*A65-0035*/
    IF (trim(wdetail.branch)) = "5" THEN ASSIGN wdetail.branch = "P" . 
    ELSE ASSIGN  wdetail.branch = (trim(wdetail.branch)).     /*-A59-0178-*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_v72 c-Win 
PROCEDURE proc_assign_v72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
  ------------------------------------------------------------------------------*/
  /*
  /*crate  policy line 72*/
  FIND FIRST wdetail WHERE wdetail.policy = "D072" + trim(substr(wdetail2.policyno,4))  NO-ERROR NO-WAIT.
  IF NOT AVAIL wdetail THEN DO:
      CREATE wdetail.
      ASSIGN 
          wdetail.policy     = "D072" + trim(substr(wdetail2.policyno,4))
          wdetail.poltyp     = "V72"
          /* wdetail.cmr_code   = wdetail2.cmr_code */
          wdetail.caryear    = trim(wdetail2.caryear)           
          wdetail.eng        = trim(wdetail2.eng)               
          wdetail.chasno     = trim(wdetail2.chasno)            
          wdetail.engcc      = STRING(DECI(wdetail2.power) * 100 )      
        /*wdetail.power      = wdetail2.power  */           
    /*10  wdetail.colorcode  = wdetail2.colorcode */        
          wdetail.vehreg     = trim(wdetail2.vehreg)            
          wdetail.garage     = trim(wdetail2.garage)            
          wdetail.fleetper   = trim(wdetail2.fleetper)          
          wdetail.ncb        = trim(wdetail2.ncb)               
        /*wdetail.orthper    = wdetail2.orthper*/           
          wdetail.vehuse     = trim(wdetail2.vehuse)            
          wdetail.comdat     = trim(wdetail2.comdat)            
          wdetail.si         = trim(wdetail2.si)                
          wdetail.name_insur = trim(wdetail2.name_insur)        
          wdetail.not_office = trim(wdetail2.not_office)        
          wdetail.entdat1    = trim(wdetail2.entdat)            
          wdetail.enttim1    = trim(wdetail2.enttim)            
        /*wdetail.not_code    = wdetail2.not_code */         
          wdetail.premt      = trim(wdetail2.comp_prm)             
          /*wdetail.comp_prm   = wdetail2.comp_prm  */        
          wdetail.stk        = trim(wdetail2.stk) 
          wdetail.brand      = trim(wdetail2.brand)             
          wdetail.addr1      = trim(wdetail2.addr1)             
          wdetail.addr2      = trim(wdetail2.addr2)             
          wdetail.tiname     = trim(wdetail2.tiname)            
          wdetail.insnam     = trim(wdetail2.insnam)  + " " + trim(wdetail2.name2)            
    /*32  wdetail.name2      = wdetail2.name2  */           
          wdetail.benname    = trim(wdetail2.benname)           
        /*wdetail.remark     = wdetail2.remark   */         
          wdetail.Account_no = trim(wdetail2.Account_no)        
        /*wdetail.client_no  = wdetail2.client_no*/         
          wdetail.expdat     = trim(wdetail2.expdat)            
    /*38  wdetail.gap        = wdetail2.gap */              
          wdetail.re_country = trim(wdetail2.re_country)        
          wdetail.receipt_name = trim(wdetail2.receipt_name)      
    /*41  wdetail.agent      = wdetail2.agent */            
    /*42  wdetail.prev_insur = wdetail2.prev_insur */       
          wdetail.prepol     = trim(wdetail2.prepol)            
          wdetail.deduct     = trim(wdetail2.deduct)            
        /*wdetail.add1_70    = wdetail2.add1_70           
          wdetail.add2_70    = IF trim(wdetail2.add2_70) = "" THEN           
              ( trim(wdetail2.Sub_Di_70) + " "  +      
                trim(wdetail2.Direc_70) + " " +         
                trim(wdetail2.Provi_70) + " " +         
                trim(wdetail2.ZipCo_70))  ELSE  trim(wdetail2.add2_70) */       
          wdetail.add1_70    = trim(wdetail2.add1_72)           
          wdetail.add2_70    = IF trim(wdetail2.add2_72) = "" THEN            
              ( TRIM(wdetail2.Sub_Di_72) + " " +        
                TRIM(wdetail2.Direc_72) + " " +         
                TRIM(wdetail2.Provi_72) + " " +         
                TRIM(wdetail2.ZipCo_72)) ELSE trim(wdetail2.add2_72)      
    /*57  wdetail.apptype    = wdetail2.apptype           
      58  wdetail.appcode    = wdetail2.appcode           
      59  wdetail.nBLANK     = wdetail2.nBLANK  */ 
          wdetail.tp1        = trim(wdetail2.tp1)               
          wdetail.tp2        = trim(wdetail2.tp2)               
          wdetail.tp3        = trim(wdetail2.tp3)               
          wdetail.covcod     = trim(wdetail2.covcod) 
          wdetail.subclass   = SUBSTR(trim(wdetail2.prempa),2,3)
          wdetail.prempa     = SUBSTR(trim(wdetail2.prempa),1,1)
        /*wdetail2.seat41  = INTE(wdetail.seat) */
          wdetail.n_branch   = trim(caps(wdetail2.nbranch))
          wdetail.tariff     =  "9" 
          wdetail.compul     = "y"
          wdetail.comment    = ""
          wdetail.producer   = wdetail2.producer
          wdetail.agent      = wdetail2.agent1   
          wdetail.entdat     = string(TODAY)                /*entry date*/
          wdetail.enttim     = STRING (TIME, "HH:MM:SS")    /*entry time*/
          wdetail.trandat    = STRING (fi_loaddat)          /*tran date*/
          wdetail.trantim    = STRING (TIME, "HH:MM:SS")    /*tran time*/
          wdetail.n_IMPORT   = "IM"
          wdetail.n_EXPORT   = "" .
  END.*/
  

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
          /*IF wdetail.policy = "TC701000266028" THEN nv_baseprm =  2451.00.*/
    ASSIGN chk = NO
        NO_basemsg = " " .
    /*If wdetail.drivnam1  = ""  Then */ /*A61-0313*/
    /* comment by : A67-0087...
    If nv_drivno  = 0  Then /*A61-0313*/
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
        IF (wdetail.prepol = "") THEN RUN proc_usdcod.
        ELSE RUN proc_usdcodrenew.
        ASSIGN  nv_drivvar = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
        /*RUN proc_usdcod. */
    END.
    ...end A67-0087...*/
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
    IF wdetail.prepol <> "" THEN  
        /*ASSIGN nv_41 = n_41*/ /*A61-0045*/      /*�������*/          
        /*nv_42 = n_42       */ /*A61-0045*/                    
        /*nv_43 = n_43       */ /*A61-0045*/ 
        ASSIGN nv_41 = wdetail.no_41     /*A61-0045*/      /*�������*/          
               nv_42 = wdetail.no_42     /*A61-0045*/                    
               nv_43 = wdetail.no_43     /*A61-0045*/ 
               nv_seat41 = inte(wdetail.seat41).  
    /* comment by : Ranu I. A65-0035...
    ELSE IF wdetail.prempa = "Z" THEN
        ASSIGN 
        nv_41 = 50000         /*deci(wdetail.no_41)*/ 
        nv_42 = 50000         /*deci(wdetail.no_42)*/
        nv_43 = 200000        /*deci(wdetail.no_43)*/  
        nv_seat41 = inte(wdetail.seat) .   
    ELSE IF wdetail.prempa = "T" THEN
        ASSIGN 
        nv_41 = 100000                  /*deci(wdetail.no_41)*/ 
        nv_42 = 100000                  /*deci(wdetail.no_42)*/
        nv_43 = 200000                  /*deci(wdetail.no_43)*/
        nv_seat41 =   wdetail.seat .    /*integer(wdetail.seat41)*/
    ... end A65-0035...*/    
    IF wdetail.model = "commuter" THEN 
        ASSIGN wdetail.seat = 16
        nv_seats  =  16
        nv_seat41 =  16 .
    /*comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                    nv_class,
                    nv_key_b,
                    nv_comdat). 
    comment by : A64-0138...*/
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
    /*comment by : A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/  
     comment by : A64-0138...*/
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
      /*comment by : A64-0138...
      Run  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */
                        nv_tariff,
                        nv_class,
                        nv_key_b,
                        nv_comdat,
                        nv_cons,
                        OUTPUT nv_prem). 
       comment by : A64-0138...*/
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
      /*comment by : A64-0138... 
      Run  Wgs\Wgsmx025(INPUT  dod0, /*a490166 note modi*/
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).
      comment by : A64-0138...*/
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
      comment by : A64-0138...*/
      ASSIGN
          nv_fletvar                  = " "
          nv_fletvar1                 = "     Fleet % = "
          nv_fletvar2                 =  STRING(nv_flet_per)
          SUBSTRING(nv_fletvar,1,30)  = nv_fletvar1
          SUBSTRING(nv_fletvar,31,30) = nv_fletvar2.
      IF nv_flet   = 0  THEN
          nv_fletvar  = " ".
      /*---------------- NCB -------------------*/
      IF (wdetail.prepol = "") AND (wdetail.covcod = "3") THEN
            ASSIGN WDETAIL.NCB = 20. 
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
      /*comment by : A64-0138...
      RUN WGS\WGSORPRM.P (INPUT nv_tariff, /*pass*/
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                nv_totsi,
                                uwm130.uom1_v,
                                uwm130.uom2_v,
                                uwm130.uom5_v).
      comment by : A64-0138...*/
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
             comment by : A64-0138...*/
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
     /*comment by : A64-0138...
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v ,       
                         nv_uom2_v ,       
                         nv_uom5_v ). 
     comment by : A64-0138...*/

     IF wdetail.prepol = "" THEN DO :

      nv_dss_per   = 0.
      IF nv_gapprm > n_prem THEN  
          nv_dss_per = round(TRUNCATE(((nv_gapprm - n_prem ) * 100 ) / nv_gapprm ,3 ),2) . 
     END.
     IF  nv_dss_per   <> 0  THEN
         Assign
         nv_dsspcvar1   = "     Discount Special % = "
         nv_dsspcvar2   =  STRING(nv_dss_per)
         SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
         SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
     /*--------------------------*/
     /*comment by : A64-0138...
     RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         nv_uom1_v ,       
                         nv_uom2_v ,       
                         nv_uom5_v ). 
     comment by : A64-0138...*/
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
/*comment by : A64-0138...
DEF VAR chk     AS LOGICAL.
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
    /*nv_drivvar1 = wdetail.drivername1.
    nv_drivvar2 = wdetail.drivername2.
    IF wdetail.drivername1 <> ""   THEN  wdetail.drivnam  = "y".
    ELSE wdetail.drivnam  = "N".
    IF wdetail.drivername2 <> ""   THEN  nv_drivno = 2. 
    ELSE IF wdetail.drivername1 <> "" AND wdetail.drivername2 = "" THEN  nv_drivno = 1.  
    ELSE IF wdetail.drivername1 = "" AND wdetail.drivername2 = "" THEN  nv_drivno = 0.  */
    /*
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
    */
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
    IF wdetail.prepol <> "" THEN   /*�������*/
        ASSIGN  /*nv_41 = n_41*/       /*A61-0045*/
                /*nv_42 = n_42*/       /*A61-0045*/
                /*nv_43 = n_43*/       /*A61-0045*/
                nv_41 = wdetail.no_41  /*A61-0045*/
                nv_42 = wdetail.no_42  /*A61-0045*/
                nv_43 = wdetail.no_43  /*A61-0045*/
                nv_seat41 =  inte(wdetail.seat) .
    ELSE IF wdetail.prempa = "Z" THEN
        ASSIGN 
        nv_41 = 50000                   /*deci(wdetail.no_41)*/ 
        nv_42 = 50000                   /*deci(wdetail.no_42)*/
        nv_43 = 200000                  /*deci(wdetail.no_43)*/
        nv_seat41 =   wdetail.seat .    /*integer(wdetail.seat41)*/ 
    ELSE IF wdetail.prempa = "T" THEN
        ASSIGN 
        nv_41 = 100000                  /*deci(wdetail.no_41)*/ 
        nv_42 = 100000                  /*deci(wdetail.no_42)*/
        nv_43 = 200000                  /*deci(wdetail.no_43)*/
        nv_seat41 =   wdetail.seat .    /*integer(wdetail.seat41)*/
     
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
         nv_pdavar2     = string(deci(WDETAIL.deductpd))         /*A52-0172*/
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
 
END.
comment by : A64-0138...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt c-Win 
PROCEDURE proc_calpremt :
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
         nv_41prmt  = 0
         nv_42prmt  = 0
         nv_43prmt  = 0
         nv_seat41  = 0          
         nv_dedod   = 0
         nv_addod   = 0
         nv_dedpd   = 0        
         nv_ncbp    = 0
         nv_fletp   = 0
         nv_dspcp   = 0
         nv_dstfp   = 0
         nv_clmp    = 0
         nv_baseprm  = 0
         nv_baseprm3 = 0
         nv_pdprem   = 0
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
         nv_status  = "" 
         nv_fcctv   = NO
         nv_uom1_c  = "" 
         nv_uom2_c  = "" 
         nv_uom5_c  = "" 
         nv_uom6_c  = "" 
         nv_uom7_c  = ""
         nv_message = "" .

    ASSIGN               
         nv_covcod  = wdetail.covcod                                              
         nv_class   = wdetail.prempa + trim(wdetail.subclass)                                         
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
         nv_411si   = nv_41       
         nv_412si   = nv_41       
         nv_413si   = 0                       
         nv_414si   = 0                       
         nv_42si    = nv_42                
         nv_43si    = nv_43                
         nv_seat41  = wdetail.seat41 /*A65-0035*/ 
         nv_dedod   = DOD1       
         nv_addod   = DOD2                                
         nv_dedpd   = DPD0                                     
         nv_ncbp    = deci(wdetail.ncb)                                     
         nv_fletp   = deci(wdetail.fleet)                                  
         nv_dspcp   = nv_dss_per                                      
         nv_dstfp   = 0                                                     
         nv_clmp    = nv_cl_per  
         nv_netprem = IF wdetail.prepol <> "" THEN deci(wdetail.premt) 
                      ELSE TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) + (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )
         /*nv_netprem  =  DECI(wdetail.premt) *//* �����ط�� */                                               
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
                    nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(wdetail.hp) ELSE INT(wdetail.engcc).     
            END.                                                                                                    
            ELSE IF clastab_fil.unit = "S" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = INT(wdetail.seat).
            END.
            ELSE IF clastab_fil.unit = "T" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    /*nv_engine = deci(wdetail.weight)*/      /*A65-0035*/
                    nv_engine = DECI(sic_bran.uwm301.Tons)  . /*A65-0035*/
            END.
            nv_engcst = nv_engine .
        END.

    IF nv_cstflg = "W" THEN ASSIGN sic_bran.uwm301.watt = nv_engine . /* add  */

    IF wdetail.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            /*RUN wgw/wgwredbook(input  wdetail.brand ,*/ /*A65-0035*/  
            RUN wgw/wgwredbk1(input  wdetail.brand ,  /*A65-0035*/
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
           /*RUN wgw/wgwredbook(input  wdetail.brand ,*/ /*A65-0035*/  
            RUN wgw/wgwredbk1(input  wdetail.brand ,  /*A65-0035*/ 
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  wdetail.caryear, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT wdetail.redbook) .
        END.

        IF wdetail.redbook <> ""  THEN ASSIGN sic_bran.uwm301.modcod = wdetail.redbook .
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
                sic_bran.uwm301.body   =  IF sic_bran.uwm301.body = "" THEN stat.maktab_fil.body ELSE sic_bran.uwm301.body    /*A65-0035*/
                sic_bran.uwm301.tons   =  IF sic_bran.uwm301.tons = 0 THEN stat.maktab_fil.tons ELSE sic_bran.uwm301.tons   /*A65-0035*/
                wdetail.body           =  IF wdetail.body = "" THEN stat.maktab_fil.body ELSE wdetail.body .  /*A65-0035*/
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
    IF nv_polday < 365 THEN DO:
        nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat).

        /* ����������������� ����ͧ��  loop ��� 
        nv_netprem = TRUNCATE((nv_netprem / nv_polday ) * 365 ,0) +
                     (IF ((nv_netprem / nv_polday ) * 365 ) - Truncate((nv_netprem / nv_polday ) * 365,0) > 0 Then 1 
                      Else 0). */
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

    /*IF nv_gapprm <> DECI(wdetail.premt) THEN DO:  */
    IF nv_status = "no" THEN DO:  
        /* A65-0035..... 
        MESSAGE "���¨ҡ�к� " + string(nv_gapprm,">>,>>>,>>9.99") + " �����ҡѺ�������� " + wdetail.premt + 
            nv_message VIEW-AS ALERT-BOX.
          ASSIGN
               wdetail.comment = wdetail.comment + "| " + "���¨ҡ�к� �����ҡѺ�������� "
               wdetail.WARNING = "���¨ҡ�к� " + string(nv_gapprm,">>,>>>,>>9.99") + " �����ҡѺ�������� " + wdetail.netprem .
               wdetail.pass     = "Y"  
               wdetail.OK_GEN  = "N".
        ...end A65-0035..*/ 
        /* add by : A65-0035 */   
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN wdetail.pass = "N" .
        ASSIGN
               wdetail.comment = wdetail.comment + "|" + nv_message
               wdetail.WARNING = wdetail.WARNING + "|" + nv_message . 
        /* end : A65-0035*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt_EV c-Win 
PROCEDURE proc_calpremt_EV :
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
            nv_engcst  = 1900*/ /* ��ͧ����ҵ�� nv_cstflg         
            nv_drivno  = 0   */                                     
            nv_driage1 = nv_drivage1                                 
            nv_driage2 = nv_drivage2                                    
            nv_yrmanu  = INT(wdetail.caryear)          
            nv_totsi   = IF sic_bran.uwm130.uom6_v = 0 THEN sic_bran.uwm130.uom7_v ELSE sic_bran.uwm130.uom6_v /*A66-0202*/
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
            nv_41prmt  = 0      /* �к����� ��.*/  
            nv_412prmt = 0       /* �к����� ��.*/ 
            nv_413prmt = 0       /* �к����� ��.*/ 
            nv_414prmt = 0       /* �к����� ��.*/ 
            nv_42prmt  = 0      /* �к����� ��.*/  
            nv_43prmt  = 0      /* �к����� ��.*/  
            nv_seat41  = wdetail.seat41   
            nv_dedod   = DOD1       
            nv_addod   = DOD2                                
            nv_dedpd   = DPD0                                     
            nv_ncbp    = deci(wdetail.ncb)                                     
            nv_fletp   = deci(wdetail.fleet)                                  
            nv_dspcp   = nv_dss_per                                      
            nv_dstfp   = 0                                                     
            nv_clmp    = nv_cl_per
            nv_mainprm  = 0  
            nv_dodamt   = 0  /*A67-0029*/ /* �к����� DOD */   
            nv_dadamt   = 0  /*A67-0029*/ /* �к����� DOD1 */  
            nv_dpdamt   = 0  /*A67-0029*/ /* �к����� DPD */   
            nv_ncbamt   = 0  /* �к�����  NCB PREMIUM */           
            nv_fletamt  = 0  /* �к�����  FLEET PREMIUM */          
            nv_dspcamt  = 0  /* �к�����  DSPC PREMIUM */           
            nv_dstfamt  = 0  /* �к�����  DSTF PREMIUM */           
            nv_clmamt   = 0  /* �к�����  LOAD CLAIM PREMIUM */    
            /* end : A65-0079*/
            nv_baseprm  = 0
            nv_baseprm3 = 0
            nv_netprem  =  IF wdetail.prepol <> "" THEN deci(wdetail.premt) 
                           ELSE TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) + (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )
            nv_pdprem   = nv_netprem /* �����ط�� ��������� */
            nv_gapprem  = nv_netprem
            nv_gapprm   = 0                                                     
            nv_flagprm  = "N"                 /* N = �����ط��, G = ������� */                                    
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
                           nv_engine = IF SUBSTR(nv_class,5,1) = "E" OR SUBSTR(nv_class,2,1) = "E" THEN DECI(wdetail.hp) ELSE INT(wdetail.engcc).
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
                sic_bran.uwm301.engine =  IF sic_bran.uwm301.engine = 0 THEN stat.maktab_fil.engine ELSE sic_bran.uwm301.engine
                wdetail.body           =  IF wdetail.body = "" THEN stat.maktab_fil.body ELSE wdetail.body   /*A65-0035*/
                sic_bran.uwm301.maksi  =  IF deci(wdetail.maksi) = 0 THEN stat.maktab_fil.si ELSE DECI(wdetail.maksi) .
        END.
        ELSE DO:
            ASSIGN
                wdetail.comment = wdetail.comment + "| " + "Redbook is Null !! "
                wdetail.WARNING = "Redbook �繤����ҧ�������ö������������� " 
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
              nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  �ѹ */
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
                     INPUT 35,    /*cv_ldssper  = Limit DSPC % �óջ���ᴧ 110  �� 45%  �͡����� 30% 35%*/                                                                                  
                     INPUT 0 ,    /*cv_lclmper  = Limit Claim % �ó���� Load Claim �� New 0% or 50% , Renew 0% or 20 - 50%  0%*/                                                              
                     INPUT 0 ,    /*cv_ldstfper = Limit DSTF % 0%*/                                                                                                                            
                     INPUT NO,   /*nv_reflag   = �ó�����ͧ��� Re-Calculate ��� Yes*/                                                                                                        
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkacctxt c-Win 
PROCEDURE proc_chkacctxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF INDEX(wdetail.remark,"FE2+") <> 0 THEN DO: 
        IF (YEAR(TODAY) - INT(wdetail.caryear) + 1 ) <= 7 AND wdetail.garage = "G" THEN DO: /* A67-0087*/
            IF wdetail.acc = ""  THEN DO:
                 ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "MT001_PB ������ͧ��û�Сѹ����á�����Ѿ���Թ��ǹ�ؤ��"      
                        SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = "�����������ö¹�� 20,000 �ҷ"                              
                        SUBSTRING(sic_bran.uwm301.prmtxt,121,60) = "MT002_FL ������ͧ��û�Сѹ��¤�����ͧ��¹�ӷ�������ع��Сѹ"
                        SUBSTRING(sic_bran.uwm301.prmtxt,181,60) = "������ͧ�ػ�ó�����������������Թ 5% �ͧ�ع��Сѹ���" .
            END.
            ELSE DO:
                ASSIGN 
                    SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  "MT001_PB ������ͧ��û�Сѹ����á�����Ѿ���Թ��ǹ�ؤ��"
                    SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  "�����������ö¹�� 20,000 �ҷ" 
                    SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  "MT002_FL ������ͧ��û�Сѹ��¤�����ͧ��¹�ӷ�������ع��Сѹ"
                    SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  SUBSTRING(wdetail.acc,1,60) 
                    SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  SUBSTRING(wdetail.acc,61,60) 
                    SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  SUBSTRING(wdetail.acc,121,60)
                    SUBSTRING(sic_bran.uwm301.prmtxt,361,60) =  SUBSTRING(wdetail.acc,181,60)  /*A64-0092*/
                    SUBSTRING(sic_bran.uwm301.prmtxt,421,60) =  SUBSTRING(wdetail.acc,241,60). /*A64-0092*/
            END.
            RUN proc_uwd105.
        END.
        /*  add by : A67-0087*/
        ELSE DO:
            IF wdetail.acc = "" AND wdetail.garage = "G" THEN DO:
                 ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "������ͧ�ػ�ó�����������������Թ 5% �ͧ�ع��Сѹ���" . 
            END.
            ELSE DO:
                ASSIGN 
                    SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = SUBSTRING(wdetail.acc,1,60)   
                    SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = SUBSTRING(wdetail.acc,61,60)  
                    SUBSTRING(sic_bran.uwm301.prmtxt,121,60) = SUBSTRING(wdetail.acc,121,60) 
                    SUBSTRING(sic_bran.uwm301.prmtxt,181,60) = SUBSTRING(wdetail.acc,181,60) 
                    SUBSTRING(sic_bran.uwm301.prmtxt,241,60) = SUBSTRING(wdetail.acc,241,60) 
                    SUBSTRING(sic_bran.uwm301.prmtxt,301,60) = SUBSTRING(wdetail.acc,301,60) 
                    SUBSTRING(sic_bran.uwm301.prmtxt,361,60) = SUBSTRING(wdetail.acc,261,60)  .
            END.
        END.
        /* end : A67-0087*/
    END.
    ELSE DO:
        /*IF  INDEX(wdetail.brand,"HAVAL")  <> 0 OR INDEX(wdetail.brand,"ORA") <> 0 THEN DO:   /*A66-0070*/*/ /* A67-0087*/
         IF INDEX(wdetail.brand,"HAVAL")  <> 0 OR INDEX(wdetail.brand,"ORA") <> 0 OR INDEX(wdetail.brand,"TANK") <> 0 THEN DO:   /* A67-0087*/
            IF (YEAR(TODAY) - INT(wdetail.caryear) + 1 ) <= 5 AND wdetail.garage = "G" THEN DO: /* A67-0087*/
                IF wdetail.acc = "" THEN 
                    ASSIGN  SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "����������ͧ�á�����Ѿ���Թ��ǹ�ؤ������ö 20,000 �ҷ"  
                            SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = "������ͧ�ػ�ó�����������������Թ 50,000 �ҷ���㹷ع". 
                ELSE DO:  /*���ػ�ó�*/
                    ASSIGN 
                        SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "����������ͧ�á�����Ѿ���Թ��ǹ�ؤ������ö 20,000 �ҷ"  /*A65-0035*/
                        SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = SUBSTRING(wdetail.acc,1,60)       /*A63-00472*/ 
                        SUBSTRING(sic_bran.uwm301.prmtxt,121,60) = SUBSTRING(wdetail.acc,61,60)      /*A63-00472*/ 
                        SUBSTRING(sic_bran.uwm301.prmtxt,181,60) = SUBSTRING(wdetail.acc,121,60)     /*A63-00472*/ 
                        SUBSTRING(sic_bran.uwm301.prmtxt,241,60) = SUBSTRING(wdetail.acc,181,60)     /*A63-00472*/ 
                        SUBSTRING(sic_bran.uwm301.prmtxt,301,60) = SUBSTRING(wdetail.acc,241,60)     /*A63-00472*/ 
                        SUBSTRING(sic_bran.uwm301.prmtxt,361,60) = SUBSTRING(wdetail.acc,301,60).    /*A63-00472*/ 
                END.
                RUN proc_uwd105 .
            /* Add by : A67-0087 */
            END.
            ELSE DO:
                IF wdetail.acc = "" THEN ASSIGN  SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "������ͧ�ػ�ó�����������������Թ 50,000 �ҷ���㹷ع". 
                ELSE DO:  /*���ػ�ó�*/
                    ASSIGN 
                        SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = SUBSTRING(wdetail.acc,1,60)      
                        SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = SUBSTRING(wdetail.acc,61,60)     
                        SUBSTRING(sic_bran.uwm301.prmtxt,121,60) = SUBSTRING(wdetail.acc,121,60)    
                        SUBSTRING(sic_bran.uwm301.prmtxt,181,60) = SUBSTRING(wdetail.acc,181,60)    
                        SUBSTRING(sic_bran.uwm301.prmtxt,241,60) = SUBSTRING(wdetail.acc,241,60)    
                        SUBSTRING(sic_bran.uwm301.prmtxt,301,60) = SUBSTRING(wdetail.acc,301,60)    
                        SUBSTRING(sic_bran.uwm301.prmtxt,421,60) = SUBSTRING(wdetail.acc,241,60).
                END.
            END.
        END.   /*A66-0070*/
        ELSE IF wdetail.acc <> "" THEN DO:
          IF wdetail.covcod = "1" AND TRIM(wdetail.brand) = "FORD" /*OR TRIM(wdetail.brand) = "ORA" OR TRIM(wdetail.brand) = "HAVAL"*/ /* A67-0087*/ THEN DO:
             IF (YEAR(TODAY) - INT(wdetail.caryear) + 1 ) < 8 AND wdetail.garage = "G" THEN DO:
                 ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = "����������ͧ�á�����Ѿ���Թ��ǹ�ؤ������ö 20,000 �ҷ" 
                        SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  SUBSTRING(wdetail.acc,1,60)    
                        SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  SUBSTRING(wdetail.acc,61,60)  
                        SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  SUBSTRING(wdetail.acc,121,60) 
                        SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  SUBSTRING(wdetail.acc,181,60) 
                        SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  SUBSTRING(wdetail.acc,241,60).
                 RUN proc_uwd105.
             END.                                                
             /*ELSE  ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60) =  "������ͧ�ػ�ó쵡�������������Թ 20,000 �ҷ" .*/
             ELSE DO:
              ASSIGN 
                SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  SUBSTRING(wdetail.acc,1,60)   
                SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  SUBSTRING(wdetail.acc,61,60)  
                SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  SUBSTRING(wdetail.acc,121,60) 
                SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  SUBSTRING(wdetail.acc,181,60) 
                SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  SUBSTRING(wdetail.acc,241,60) .
             END.
          END.                                              
          ELSE DO:                                          
            ASSIGN 
                 SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  SUBSTRING(wdetail.acc,1,60)   
                 SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  SUBSTRING(wdetail.acc,61,60)  
                 SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  SUBSTRING(wdetail.acc,121,60) 
                 SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  SUBSTRING(wdetail.acc,181,60) 
                 SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  SUBSTRING(wdetail.acc,241,60) .
          END.
        END.
        ELSE DO: 
            IF wdetail.covcod = "1" THEN DO: 
                IF trim(wdetail.brand) = "NISSAN" THEN ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)  =  "������ͧ�ػ�ó쵡�������������Թ 30,000 �ҷ" .
                ELSE IF TRIM(wdetail.brand) = "FORD" /*OR TRIM(wdetail.brand) = "ORA" OR TRIM(wdetail.brand) = "HAVAL"*/ /*A67-0087*/ THEN DO:
                    IF (YEAR(TODAY) - INT(wdetail.caryear) + 1 ) < 8 THEN DO:
                        ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =   "����������ͧ�á�����Ѿ���Թ��ǹ�ؤ������ö 20,000 �ҷ" 
                               SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =   "������ͧ�ػ�ó쵡�������������Թ 20,000 �ҷ" .
                        RUN proc_uwd105.
                    END.
                    ELSE  ASSIGN SUBSTRING(sic_bran.uwm301.prmtxt,1,60)  =  "������ͧ�ػ�ó쵡�������������Թ 20,000 �ҷ" .
                END.
            END.
        END. /* end : A65-0035 */
    END.
/* End A63-0210 */
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
/* Add by : A64-0138 date.28/06/2021 */
 nv_chkerror = "".
    RUN wgw\wgwchkagpd(INPUT wdetail.agent ,           
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
   
 
 IF wdetail.deler <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.deler) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Dealer " + wdetail.deler + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code Dealer " + wdetail.deler + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
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
 END
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
 END..*/
 RELEASE sicsyac.xmm600.
  /* end : A64-0138 */ 
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
              ELSE ASSIGN wdetail.comment = wdetail.comment + "| ��辺 Class " + wdetail.prempa + wdetail.subclass + "��� Veh. Use" + wdetail.vehuse + 
                      "���������ҧ���º��º (sicsyac.xzmcom)" .
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
        ELSE ASSIGN wdetail.comment = wdetail.comment + "| ��辺 Class " + wdetail.prempa + wdetail.subclass + "��� Veh. Use" + wdetail.vehuse + 
                      "���������ҧ���º��º (sicsyac.xzmcom)" .
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
                     ASSIGN wdetail.comment = wdetail.comment + "| ��辺������ Class " + wdetail.prempa + wdetail.subclass + 
                            " Match �Ѻ Class �ú. " + n_classcomp72 + " ��� sicsyac.xzmcom " .
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
  Notes: add by A67-0185      
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
   ASSIGN wdetail.comment = wdetail.comment + "| �ѹ��������ͧ �����ѹ���������� �繤����ҧ " 
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
                    ASSIGN wdetail.comment = wdetail.comment + "| �Ţ��Ƕѧ����ա���������к�����" + uwm100.policy      
                           WDETAIL.OK_GEN  = "N"
                           wdetail.pass    = "N". 
                 END.
                 /* add by : A64-0355 */
                 ELSE IF DATE(sicuw.uwm100.expdat) > date(nv_comdat)  AND 
                         YEAR(sicuw.uwm100.expdat) <> YEAR(nv_expdat) AND 
                         MONTH(sicuw.uwm100.expdat) - MONTH(TODAY) > 3 AND
                         sicuw.uwm100.polsta    = "IF" THEN DO:
                     ASSIGN wdetail.comment = wdetail.comment + "| �Ţ��Ƕѧ����ա���������к�����" + uwm100.policy      
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
    IF (wdetail.subclass = "801") OR (wdetail.subclass = "401")  THEN DO:
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
                        ASSIGN wdetail.comment = wdetail.comment + "| �Ţ����¹����ա���������к�����" + uwm100.policy      
                               WDETAIL.OK_GEN  = "N"
                               wdetail.pass    = "N". 
                     END.
                     /* add by : A64-0355 */
                     ELSE IF DATE(sicuw.uwm100.expdat) > date(nv_comdat)  AND 
                             YEAR(sicuw.uwm100.expdat) <> YEAR(nv_expdat) AND 
                             MONTH(sicuw.uwm100.expdat) - MONTH(TODAY) > 3 AND
                             sicuw.uwm100.polsta    = "IF" THEN DO:
                         ASSIGN wdetail.comment = wdetail.comment + "| �Ţ����¹����ա���������к�����" + uwm100.policy      
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
  Notes: add Ranu I. A65-0035      
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
    ASSIGN  wdetail.comment = wdetail.comment + "| �Ң��繤����ҧ�������ö������к���"   /* A56-0323 */
    wdetail.pass    = "N"     /* A56-0323 */
    wdetail.OK_GEN  = "N".    /* A56-0323 */

IF wdetail.cancel = "ca"  THEN  
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| ���ͼ����һ�Сѹ�繤����ҧ��ٳ������ͼ����һ�Сѹ"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
/*IF wdetail.drivnam = "y" AND wdetail.drivername1 =  " "   THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| �ա���к�����դ��Ѻ������ժ��ͤ��Ѻ"
        wdetail.pass    = "N" 
        wdetail.OK_GEN  = "N".*/
IF wdetail.prempa = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| prem pack �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.subclass = " " THEN  
    ASSIGN  wdetail.comment = wdetail.comment + "| sub class �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".  /*can't block in use*/ 
IF wdetail.brand = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| Brand �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| model �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N".
IF wdetail.engcc    = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| Engine CC �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".

IF wdetail.caryear = " " THEN 
    ASSIGN  wdetail.comment = wdetail.comment + "| year manufacture �繤����ҧ �ռŵ�͡�ä��Ң������ Table Maktab_fil"
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
        ASSIGN  nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  if wdetail.body   = "" then stat.maktab_fil.body   else wdetail.body   /*A65-0035*/
                wdetail.cargrp   =  if wdetail.cargrp = "" then stat.maktab_fil.prmpac else wdetail.cargrp /*A65-0035*/
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat       /*A65-0035*/
                /* wdetail.body     =  stat.maktab_fil.body
                wdetail.brand  =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac*/
                wdetail.weight =  IF deci(wdetail.weight) <> 0 THEN wdetail.weight ELSE string(stat.maktab_fil.tons) /*A65-0035*/
                /*wdetail.seat     =  stat.maktab_fil.seats */
                nv_si            = maktab_fil.si 
                wdetail.hp       = STRING(stat.maktab_fil.watt)    /*A67-0087*/
                wdetail.maksi    = IF deci(wdetail.maksi) = 0 THEN STRING(stat.maktab_fil.si) ELSE wdetail.maksi . /*A67-0087*/      .
    /*IF nv_modcod = "" THEN DO: */ /*A65-0035*/
     IF nv_modcod = "" AND n_rencnt > 0 THEN DO:  /*A65-0035*/
        FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
            stat.maktab_fil.modcod = wdetail.redbook   No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then DO: 
            ASSIGN  nv_modcod    =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  if wdetail.body   = "" then stat.maktab_fil.body   else wdetail.body   /*A65-0035*/
                wdetail.cargrp   =  if wdetail.cargrp = "" then stat.maktab_fil.prmpac else wdetail.cargrp /*A65-0035*/
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat       /*A65-0035*/
               /* wdetail.body     =  stat.maktab_fil.body
                wdetail.brand  =  stat.maktab_fil.makdes  
                wdetail.model    =  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac*/
                wdetail.weight =  IF deci(wdetail.weight) <> 0 THEN wdetail.weight ELSE string(stat.maktab_fil.tons) /*A65-0035*/
                /*wdetail.seat     =  stat.maktab_fil.seats */
                nv_si            = maktab_fil.si   
                wdetail.hp       = STRING(stat.maktab_fil.watt)    /*A67-0087*/                                                    
                wdetail.maksi    = IF deci(wdetail.maksi) = 0 THEN STRING(stat.maktab_fil.si) ELSE wdetail.maksi . /*A67-0087*/ 
       END.
       /* A65-0035 */
       ELSE DO:
           ASSIGN wdetail.comment = wdetail.comment + "|��辺 Redbook Code:" +  wdetail.redbook  + " �ͧ Class:" + wdetail.subclass 
                  wdetail.redbook = "" .
       END.
     END.
     /* end : A65-0035 */
END.   /*red book <> ""*/  
/* comment by : A65-0035...
n_model = "" .
IF nv_modcod = " " THEN DO:
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
    
    IF      INDEX(wdetail.model,"vigo")   <> 0 THEN wdetail.model = "vigo".
    ELSE IF INDEX(wdetail.model,"soluna") <> 0 THEN wdetail.model = "vios".
    ELSE IF INDEX(wdetail.model,"altis")  <> 0 THEN wdetail.model = "altis".
    ELSE IF INDEX(wdetail.model," ")      <> 0 THEN 
        ASSIGN wdetail.model = SUBSTR(wdetail.model,1,INDEX(wdetail.model," ") - 1 ).

    FIND FIRST stat.makdes31 USE-INDEX makdes31    WHERE 
        makdes31.moddes =  wdetail.prempa + wdetail.subclass NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN n_ratmin = makdes31.si_theft_p   
        n_ratmax = makdes31.load_p   .    
    ELSE ASSIGN n_ratmin = 0
        n_ratmax = 0.
    IF (wdetail.covcod = "3") OR (wdetail.covcod = "2") THEN DO:
        IF (Integer(wdetail.engcc) = 0 )  THEN DO:
            Find First stat.maktab_fil USE-INDEX maktab04         Where
                stat.maktab_fil.makdes   = wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0    And
                stat.maktab_fil.makyea   = Integer(wdetail.caryear) AND 
                /*stat.maktab_fil.engine   <=    Integer(wdetail.engcc)  AND*/
                stat.maktab_fil.sclass   =  wdetail.subclass        AND
                stat.maktab_fil.seats    =  INTEGER(wdetail.seat)   No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                /*wdetail.brand    =  stat.maktab_fil.makdes  */ /*A65-0035*/
                /*wdetail.model    =  stat.maktab_fil.moddes  */ /*A65-0035*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  IF deci(wdetail.weight) <> 0 THEN wdetail.weight ELSE string(stat.maktab_fil.tons) /*A65-0035*/
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat .
        END.
        ELSE DO:
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =     wdetail.brand            And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
                stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
                stat.maktab_fil.engine   =     Integer(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     wdetail.subclass         AND
                stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
                ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
               /* wdetail.brand    =  stat.maktab_fil.makdes */ /*A65-0035*/ 
               /* wdetail.model    =  stat.maktab_fil.moddes */ /*A65-0035*/
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  IF deci(wdetail.weight) <> 0 THEN wdetail.weight ELSE string(stat.maktab_fil.tons) /*A65-0035*/
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat .
        END.
    END.   /*end....covcod..2/3 .....*/
    ELSE DO:
        Find First stat.maktab_fil USE-INDEX maktab04    Where
            stat.maktab_fil.makdes   =     wdetail.brand            And                  
            index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
            stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
            stat.maktab_fil.engine   =    Integer(wdetail.engcc)    AND
            stat.maktab_fil.sclass   =     wdetail.subclass         AND
            (stat.maktab_fil.si - (stat.maktab_fil.si * n_ratmin / 100 ) LE deci(wdetail.si)    OR
             stat.maktab_fil.si + (stat.maktab_fil.si * n_ratmax / 100 ) GE deci(wdetail.si) )  AND  
            stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN chkred    =  YES
                nv_modcod        =  stat.maktab_fil.modcod 
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.body     =  stat.maktab_fil.body  
                /*wdetail.brand    =  stat.maktab_fil.makdes   */  /*A65-0035*/    
                /*wdetail.model    =  stat.maktab_fil.moddes   */  /*A65-0035*/    
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.weight   =  IF deci(wdetail.weight) <> 0 THEN wdetail.weight ELSE string(stat.maktab_fil.tons) /*A65-0035*/
                wdetail.seat     =  IF wdetail.seat = 0 THEN stat.maktab_fil.seats ELSE wdetail.seat .
        /*IF wdetail.redbook = "" THEN 
            MESSAGE wdetail.redbook wdetail.brand wdetail.model wdetail.engcc wdetail.subclass wdetail.seat VIEW-AS ALERT-BOX.*/
    END.
    IF nv_modcod = ""  THEN DO: 
        ASSIGN chkred = YES 
            n_brand       = ""
            n_index       = 0
            n_model       = "".
        RUN proc_model_brand.
          /*RUN proc_maktab.*/
    END.
END.   */   /*nv_modcod = blank*/ 
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
        ASSIGN  wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
END. /*ncb <> 0*/
/******* drivernam **********/
nv_sclass = wdetail.subclass. 
/* A67-0087 */
IF (wdetail.subclass = "E11" ) AND trim(wdetail.drivnam1) = " " THEN DO:
    ASSIGN wdetail.comment = wdetail.comment + "| " + "����ö俿�� " + wdetail.subclass + " ��س��кؼ��Ѣ��� " 
           WDETAIL.OK_GEN  = "N"     
           wdetail.pass    = "N".
END.

IF wdetail.drivnam1 <> "" AND (wdetail.drivicno1 = "" OR wdetail.driag1 = "" ) THEN DO:
ASSIGN wdetail.comment = wdetail.comment + "| " + " ö俿�� ���� E11 �Ţ���ѵû�ЪҪ� �����Ţ����͹حҵ�Ѻ��� �����ѹ�Դ ���Ѻ��� 1 ��ͧ�кآ�����" 
      WDETAIL.OK_GEN  = "N"     
      wdetail.pass    = "N".
END.
IF wdetail.drivnam2 <> "" AND (wdetail.drivicno2 = ""  OR  wdetail.driag2 = "" ) THEN DO:
ASSIGN wdetail.comment = wdetail.comment + "| " + " ö俿�� ���� E11 �Ţ���ѵû�ЪҪ� �����Ţ����͹حҵ�Ѻ��������ѹ�Դ ���Ѻ��� 2 ��ͧ�кآ�����" 
      WDETAIL.OK_GEN  = "N"     
      wdetail.pass    = "N".
END.
IF wdetail.drivnam3 <> "" AND (wdetail.drivicno3 = ""  OR wdetail.drivag3 = "") THEN DO:
ASSIGN wdetail.comment = wdetail.comment + "| " + " ö俿�� ���� E11 �Ţ���ѵû�ЪҪ� �����Ţ����͹حҵ�Ѻ��� �����ѹ�Դ���Ѻ��� 3 ��ͧ�кآ�����" 
      WDETAIL.OK_GEN  = "N"     
      wdetail.pass    = "N".
END.
IF wdetail.drivnam4 <> "" AND (wdetail.drivicno4 = ""  OR  wdetail.drivag4 = "" ) THEN DO:
ASSIGN wdetail.comment = wdetail.comment + "| " + " ö俿�� ���� E11 �Ţ���ѵû�ЪҪ� �����Ţ����͹حҵ�Ѻ��� �����ѹ�Դ���Ѻ��� 4 ��ͧ�кآ�����" 
      WDETAIL.OK_GEN  = "N"     
      wdetail.pass    = "N".
END.
IF wdetail.drivnam5 <> "" AND (wdetail.drivicno5 = ""  OR  wdetail.drivag5 = ""  ) THEN DO:
ASSIGN wdetail.comment = wdetail.comment + "| " + " ö俿�� ���� E11 �Ţ���ѵû�ЪҪ� �����Ţ����͹حҵ�Ѻ��� �����ѹ�Դ���Ѻ��� 5 ��ͧ�кآ�����" 
      WDETAIL.OK_GEN  = "N"     
      wdetail.pass    = "N".
END.

/* end : A67-0087  */     
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
    ASSIGN
        nv_dscom   = 0
        n_rencnt   = 0
        n_endcnt   = 0 
        nv_tons    = 0 
        nv_basere  = 0
        n_41       = 0  
        n_42       = 0  
        n_43       = 0  
        dod1       = 0  
        dod2       = 0  
        dod0       = 0  
        nv_dss_per = 0 
        nv_cl_per  = 0        
        n_firstdat = ?
        nv_insref  = ""   /*Add kridtiya i. A56-0104 ....*/
        nr_premtxt = ""   /*A57-0017*/
        nv_driver  = ""   /*A57-0017*/
        np_driver  = ""   /*A57-0017*/
        nv_drivno  = 0   /*A61-0313*/
        nr_hp    = 0    /*A67-0087 */
        nr_maksi = 0 .  /*A67-0087 */
    RUN proc_susspect.    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    /* A67-0076 */
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
    /* end A67-0076 */
    RUN proc_chkpolpremium. /*A67-0185*/
    IF wdetail.poltyp = "v72"  THEN DO:
      IF wdetail.prepol <> ""  THEN RUN proc_renew. 
        RUN proc_72.
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
    ELSE DO:
        IF wdetail.prepol <> ""  THEN RUN proc_renew. 
        RUN proc_chktest0.
    END.
    RUN proc_policy . 
    RUN proc_colorcode  . /*A65-0356*/ 
    RUN proc_chktest2.      
    RUN proc_chktest3.    
    /*RUN proc_chktest4. */  /* A55-0184 ....*/
    /*A63-00472.........................
    /*Add A55-0184 ...*/
    IF nv_dss_per = 0  THEN RUN proc_chktest4.
    ELSE DO:
        IF  33 >= nv_dss_per   THEN
            ASSIGN 
            nv_dscom = 33 - nv_dss_per.
        IF nv_dscom >= 18 THEN RUN proc_chktest4.
        ELSE RUN proc_chktest41.
    END.   /*Add A55-0184 ......*/
    ......................A63-00472*/
    RUN proc_chktest4.   /*A63-00472*/
END.       /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2 c-Win 
PROCEDURE proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A67-0087       
------------------------------------------------------------------------------*/
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
        Else ASSIGN wdetail.pass    = "N"
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
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR (wdetail.covcod = "2.2")  THEN 
        ASSIGN
        sic_bran.uwm130.uom6_v   = inte(wdetail.si) 
        sic_bran.uwm130.uom7_v   = inte(wdetail.si) 
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "2" OR (wdetail.covcod = "3.2") THEN 
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
    IF INDEX(wdetail.remark,"CCTV") <> 0 THEN sic_bran.uwm130.i_text = "0001" . /*A60-0225*/

    IF wdetail.poltyp = "v72" THEN  n_sclass72 = wdetail.subclass.
    ELSE n_sclass72 = wdetail.prempa + wdetail.subclass .
    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = n_sclass72       And
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do: 
        IF wdetail.prempa = "z"   THEN DO:
            Assign  
            sic_bran.uwm130.uom1_v     = deci(wdetail.tp1)   /*stat.clastab_fil.uom1_si   1000000  */  
            sic_bran.uwm130.uom2_v     = deci(wdetail.tp2)   /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     = deci(wdetail.tp3)   /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  = deci(wdetail.tp1)   /*deci(wdetail.tp_bi)   */ 
            nv_uom2_v                  = deci(wdetail.tp2)   /*deci(wdetail.tp_bi2)  */  
            nv_uom5_v                  = deci(wdetail.tp3).  /*deci(wdetail.tp_bi3)  */ 
        END.
        ELSE DO:
            ASSIGN
                sic_bran.uwm130.uom1_v =  if deci(wdetail.tp1) = 0 then stat.clastab_fil.uom1_si else deci(wdetail.tp1) 
                sic_bran.uwm130.uom2_v =  if deci(wdetail.tp2) = 0 then stat.clastab_fil.uom2_si else deci(wdetail.tp2)
                sic_bran.uwm130.uom5_v =  if deci(wdetail.tp3) = 0 then stat.clastab_fil.uom5_si else deci(wdetail.tp3)
                nv_uom1_v              =  if deci(wdetail.tp1) = 0 then stat.clastab_fil.uom1_si else deci(wdetail.tp1)  
                nv_uom2_v              =  if deci(wdetail.tp2) = 0 then stat.clastab_fil.uom2_si else deci(wdetail.tp2)  
                nv_uom5_v              =  if deci(wdetail.tp3) = 0 then stat.clastab_fil.uom5_si else deci(wdetail.tp3)  
                wdetail.tp1            =  string(nv_uom1_v) 
                wdetail.tp2            =  string(nv_uom2_v) 
                wdetail.tp3            =  string(nv_uom5_v).
        END.
            /* ---- end : A61-0045-----*/
        ASSIGN 
            wdetail.deductpd           =  string(sic_bran.uwm130.uom5_v)
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            wdetail.comper             =  string(stat.clastab_fil.uom8_si)                
            wdetail.comacc             =  string(stat.clastab_fil.uom9_si)
            /*nv_uom1_v                =  sic_bran.uwm130.uom1_v 
            nv_uom2_v                  =  sic_bran.uwm130.uom2_v
            nv_uom5_v                  =  sic_bran.uwm130.uom5_v  */    
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".

        If  wdetail.garage   =  ""  Then
            Assign nv_41     =  deci(wdetail.no_41)
                   nv_42     =  deci(wdetail.no_42)
                   nv_43     =  deci(wdetail.no_43)
                   nv_seat41 =  IF wdetail.seat41 <> 0 THEN wdetail.seat41 ELSE stat.clastab_fil.dri_41 + clastab_fil.pass_41. /*A60-0225*/
                   
        Else If  wdetail.garage  =  "G"  Then
            Assign nv_41       =  deci(wdetail.no_41)
                   nv_42       =  deci(wdetail.no_42)
                   nv_43       =  deci(wdetail.no_43)
                   nv_seat41 =  IF wdetail.seat41 <> 0 THEN wdetail.seat41 ELSE stat.clastab_fil.dri_41 + clastab_fil.pass_41. /*A60-0225*/
    END.
    /* add by : A65-0035 */
    ELSE DO:
        ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Class " + n_sclass72 + " Cover: " + wdetail.covcod + " Not on Paramter (clastab_fil) ". 
    END.
    /* end : A65-0035 */

    ASSIGN  nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                                nv_riskno,
                                nv_itemno).

END.    /* end Do transaction*/
ASSIGN
    s_recid3  = RECID(sic_bran.uwm130)
    nv_covcod =  wdetail.covcod
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
    sic_bran.uwm301.drinam[1] = TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam)  /*A60-0206*/
    sic_bran.uwm301.eng_no   = wdetail.eng
    sic_bran.uwm301.Tons     = INTEGER(wdetail.weight)
    /*sic_bran.uwm301.engine   = INTEGER(wdetail.engcc)*/                                   /*A67-0087*/
    sic_bran.uwm301.engine   = IF wdetail.bev = "Y" THEN 0 ELSE INTEGER(wdetail.engcc)      /*A67-0087*/
    /*sic_bran.uwm301.watts    = IF index(wdetail.subclass,"E") <> 0 THEN INTEGER(wdetail.engcc) ELSE 0  /*A65-0035*/*/ /*A67-0087*/
    sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
    sic_bran.uwm301.garage   = trim(wdetail.garage)
    sic_bran.uwm301.body     = trim(wdetail.body)
    sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
    sic_bran.uwm301.mv41seat = IF INT(wdetail.seat41) <> 0 THEN INT(wdetail.seat41) ELSE IF wdetail.seat <> 0 THEN wdetail.seat ELSE nv_seat41  /*A65-0035*/
    sic_bran.uwm301.mv_ben83 = trim(wdetail.benname)
    sic_bran.uwm301.vehreg   = trim(wdetail.vehreg) 
    sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
    sic_bran.uwm301.vehuse   = trim(wdetail.vehuse)
    sic_bran.uwm301.modcod   = trim(wdetail.redbook) 
    /*sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model */     /*-A60-0118-*/ 
    sic_bran.uwm301.moddes   = caps(trim(wdetail.brand)) + " " + caps(trim(wdetail.model)) /*-A60-0118-*/ 
    sic_bran.uwm301.vehgrp   = wdetail.cargrp   
    sic_bran.uwm301.sckno    = 0
    sic_bran.uwm301.itmdel   = NO
    sic_bran.uwm301.logbok   = IF index(wdetail.remark,"ISP") <> 0 THEN "Y" ELSE "N"
    wdetail.tariff           = sic_bran.uwm301.tariff
    sic_bran.uwm301.car_color = wdetail.colorcode /*A65-0356*/   
    /* A67-0087 */
    sic_bran.uwm301.watts     = DECI(wdetail.hp)
    sic_bran.uwm301.maksi     = IF index(wdetail.subclass,"E") <> 0 THEN INTE(wdetail.maksi) ELSE 0     
    sic_bran.uwm301.eng_no2   = wdetail.engno2  
    sic_bran.uwm301.battper   = INTE(wdetail.battper)
    /*sic_bran.uwm301.battrate  = INTE(wdetail.battrate*/
    sic_bran.uwm301.battyr    = INTE(wdetail.battyr)  .
    /*sic_bran.uwm301.battsi    = INTE(wdetail.battsi)
    sic_bran.uwm301.battprice = deci(wdetail.battprice)
    sic_bran.uwm301.battno    = wdetail.battno 
    sic_bran.uwm301.chargno   = wdetail.chargno 
    sic_bran.uwm301.chargsi   = deci(wdetail.chargsi)  
    sic_bran.uwm301.battflg   = IF DECI(wdetail.battprm) <> 0 THEN "Y" ELSE "N"  
    sic_bran.uwm301.chargflg  = IF DECI(wdetail.chargprm) <> 0 THEN "Y" ELSE "N")
    end : A67-0087 */
        
/* Start A63-0210 */
    RUN proc_chkacctxt.   /*A65-0035*/ 
    IF sic_bran.uwm301.prmtxt <> "" THEN RUN proc_uwd100.
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
  ASSIGN  sic_bran.uwm301.bchyr  = nv_batchyr   /* batch Year */
          sic_bran.uwm301.bchno  = nv_batchno   /* bchno      */
          sic_bran.uwm301.bchcnt = nv_batcnt .  /* bchcnt     */

  IF wdetail.drivnam1 <> ""  THEN RUN proc_driver. /*A67-0114*/
  /*IF wdetail.prepol = ""  THEN RUN proc_driver.*/ /*A67-0114*/
  ELSE DO:
      /*IF wdetail.prepol <> "" THEN RUN proc_driver2. /*Kridtiya i. A56-0146*/*/
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
                   /* add by : A67-0087 */
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
                 /* end : A67-0087 */
              ASSIGN nv_drivno = INTEGER(ws0m009.lnumber).
          END.
      END.
  END.
  s_recid4         = RECID(sic_bran.uwm301).
  IF wdetail.seat = 16 THEN wdetail.seat = 12.
  IF wdetail.redbook = "" THEN RUN proc_maktab. /*A65-0035*/
  
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
    nv_tons   = deci(wdetail.weight)
    nv_covcod = wdetail.covcod
    nv_vehuse = wdetail.vehuse
    nv_COMPER = deci(wdetail.comper) 
    nv_comacc = deci(wdetail.comacc) 
    nv_seats  = INTE(wdetail.seat)
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
IF index(wdetail.subclass,"E") <> 0  THEN RUN proc_calpremt_EV.
ELSE RUN proc_calpremt.      /* A64-0138*/     
RUN proc_adduwd132prem. /* A64-0138*/  

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN 
     /*sic_bran.uwm100.prem_t = nv_gapprm*/ /*A64-0035*/
     sic_bran.uwm100.prem_t = nv_pdprm      /*A64-0035*/ 
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
        /*sic_bran.uwm301.ncbper   = nv_ncbper /* A64-0138*/ 
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs*/ /* A64-0138*/ 
        /*sic_bran.uwm301.mv41seat = nv_seat41  */ /*A65-0035*/  
        sic_bran.uwm301.tons     = IF sic_bran.uwm301.tons = 0 THEN 0 ELSE IF sic_bran.uwm301.tons < 100 THEN (sic_bran.uwm301.tons * 1000)
                                   ELSE sic_bran.uwm301.tons.

/* Add by A63-0122 */
    IF index(wdetail.subclass,"320") <> 0 AND 
       sic_bran.uwm301.tons < 100  THEN DO:
       MESSAGE wdetail.subclass + "  �кع��˹ѡö���١��ͧ " VIEW-AS ALERT-BOX. 
       ASSIGN 
           wdetail.comment  = wdetail.comment + "|" + wdetail.subclass + " �кع��˹ѡö���١��ͧ "
           wdetail.pass    = "N".
    END.
/* end A63-0122 */
    /*
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).*/

/* comment by : A65-0035...
/* A61-0313 */
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
END. /* end A61-313*/
...end A65-0035...*/
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
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*�¡�ҹ��� Code Producer*/  
             substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
             SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
             sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
  IF AVAIL   sicsyac.xmm018 THEN DO:
       /* create by : A60-0225*/
            IF (wdetail.producer = "A0M1046") THEN DO: 
                IF (index(nv_model,"MAZDA3") <> 0 OR index(nv_model,"CX3") <> 0 OR index(nv_model,"CX-3") <> 0 ) THEN
                    Assign  nv_com1p = 12.50  
                            nv_com2p = 0.
                ELSE 
                    Assign  nv_com1p = 18 
                            nv_com2p = 0.
            END.
            /* end : A60-0225*/
            ELSE
                Assign  nv_com1p = sicsyac.xmm018.commsp  
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
                /* create by : A60-0225*/
            IF (wdetail.producer = "A0M1046") THEN DO: 
                IF (index(nv_model,"MAZDA3") <> 0 OR index(nv_model,"CX3") <> 0 OR index(nv_model,"CX-3") <> 0 ) THEN
                        Assign nv_com1p = 12.50  
                               nv_com2p = 0.
                    ELSE 
                        Assign  nv_com1p = 18 
                                nv_com2p = 0.
            END.
            /* end : A60-0225*/
            ELSE 
                 Assign     nv_com1p = sicsyac.xmm031.comm1
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
     /*If sic_bran.uwm120.com1p <> 0  THEN  nv_com1p  = sic_bran.uwm120.com1p.*/ /*A60-0225*/
      If sic_bran.uwm120.com1p <> 0  THEN DO: 
          /*A60-0225*/
          IF (wdetail.producer = "A0M1046") THEN DO: 
              IF (index(nv_model,"MAZDA3") <> 0 OR index(nv_model,"CX3") <> 0 OR index(nv_model,"CX-3") <> 0 ) THEN nv_com1p = 12.50 . 
              ELSE nv_com1p = 18.
          END.
          /* end : A60-0225*/
          ELSE nv_com1p  = sic_bran.uwm120.com1p.
      END.
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
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*�¡�ҹ��� Code Producer*/  
             substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
             SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
             sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
  IF AVAIL   sicsyac.xmm018 THEN DO:
       /* create by : A60-0225*/
      IF (wdetail.producer = "A0M1046") THEN DO:
          IF (index(nv_model,"MAZDA3") <> 0 OR index(nv_model,"CX3") <> 0 OR index(nv_model,"CX-3") <> 0 ) THEN
              Assign nv_com1p = 12.50  
                     nv_com2p = 0.
          ELSE 
              Assign nv_com1p = 18 
                     nv_com2p = 0.
      END.
      /* end : A60-0225*/
      ELSE 
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
              /* create by : A60-0225*/
              IF (wdetail.producer = "A0M1046") THEN DO:
                 IF (index(nv_model,"MAZDA3") <> 0 OR index(nv_model,"CX3") <> 0 OR index(nv_model,"CX-3") <> 0 ) THEN
                  Assign nv_com1p = 12.50  
                         nv_com2p = 0.
                 ELSE 
                     Assign nv_com1p = 18 
                            nv_com2p = 0.
              END.
              /* end : A60-0225*/
              ELSE 
                   Assign     nv_com1p = sicsyac.xmm031.comm1
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
      /*ASSIGN nv_com1p = 0.00.  /*�ҹ kk �����  com1A = 0.00 */*/
      /*--A60-0225--*/ 
     IF (wdetail.producer = "A0M1046") THEN DO: 
         IF (index(nv_model,"MAZDA3") <> 0 OR index(nv_model,"CX3") <> 0 OR index(nv_model,"CX-3") <> 0 ) THEN nv_com1p = 12.50 .
         ELSE nv_com1p = 18.
     END.
     /* end : A60-0225 */
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
         IF      R-INDEX(TRIM(nv_name),"�ҧ���") <> 0 THEN ASSIGN nv_ntitle = "�ҧ���" .
         ELSE IF R-INDEX(TRIM(nv_name),"�.�.")   <> 0 THEN ASSIGN nv_ntitle = "�.�." .  
         ELSE IF R-INDEX(TRIM(nv_name),"�ҧ")    <> 0 THEN ASSIGN nv_ntitle = "�ҧ" .    
         ELSE IF R-INDEX(TRIM(nv_name),"���")    <> 0 THEN ASSIGN nv_ntitle = "���" .
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
    IF      nv_ntitle = "�ҧ���" THEN  ASSIGN  nv_dgender = "FEMALE" .
    else IF nv_ntitle = "�.�."   THEN  ASSIGN  nv_dgender = "FEMALE" .
    else IF nv_ntitle = "�ҧ"    THEN  ASSIGN  nv_dgender = "FEMALE" .
    else IF nv_ntitle = "���"    THEN  ASSIGN  nv_dgender = "MALE" .
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

    ind = INDEX(nv_c," ").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN
    wdetail.policy = nv_c .

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

   ASSIGN wdetail.driag1   = STRING(DATE(wdetail.driag1),"99/99/9999")
          wdetail.driag2   = STRING(DATE(wdetail.driag2),"99/99/9999")
          wdetail.drivag3  = STRING(DATE(wdetail.drivag3),"99/99/9999") 
          wdetail.drivag4  = STRING(DATE(wdetail.drivag4),"99/99/9999") 
          wdetail.drivag5  = STRING(DATE(wdetail.drivag5),"99/99/9999") 
          nv_drivage1      = IF TRIM(wdetail.driag1) <> "?" THEN  INT(SUBSTR(wdetail.driag1,7,4)) ELSE 0
          nv_drivage2      = IF TRIM(wdetail.driag2) <> "?" THEN  INT(SUBSTR(wdetail.driag2,7,4)) ELSE 0
          nv_drivage3      = IF TRIM(wdetail.drivag3) <> "?" THEN  INT(SUBSTR(wdetail.drivag3,7,4)) ELSE 0
          nv_drivage4      = IF TRIM(wdetail.drivag4) <> "?" THEN  INT(SUBSTR(wdetail.drivag4,7,4)) ELSE 0
          nv_drivage5      = IF TRIM(wdetail.drivag5) <> "?" THEN  INT(SUBSTR(wdetail.drivag5,7,4)) ELSE 0 .

    IF wdetail.driag1 <> " "  AND wdetail.drivnam1 <> " " THEN DO: 
        ASSIGN nv_drivname = "" 
               nv_drivname = TRIM(wdetail.drivnam1) .
        RUN proc_clearmailtxt .
        if nv_drivage1 < year(today) then do:
            nv_drivage1 =  YEAR(TODAY) - nv_drivage1  .
            ASSIGN nv_dribirth    = STRING(DATE(wdetail.driag1),"99/99/9999") /* �.�. */
                   nv_drivbir1    = STRING(INT(SUBSTR(wdetail.driag1,7,4))  + 543 )
                   wdetail.driag1 = SUBSTR(wdetail.driag1,1,6) + nv_drivbir1
                   wdetail.driag1 = STRING(DATE(wdetail.driag1),"99/99/9999") . /* �.�. */
        END.
        ELSE DO:
            nv_drivage1 =  YEAR(TODAY) - (nv_drivage1 - 543).
            ASSIGN nv_drivbir1    = STRING(INT(SUBSTR(wdetail.driag1,7,4)))
                   nv_dribirth    = SUBSTR(wdetail.driag1,1,6) + STRING((INTE(nv_drivbir1) - 543),"9999")  /* �.�. */
                   wdetail.driag1 = SUBSTR(wdetail.driag1,1,6) + nv_drivbir1   
                   wdetail.driag1 = STRING(DATE(wdetail.driag1),"99/99/9999")  . /* �.�. */
        END.

        ASSIGN  n_count        = 1
               /* nv_ntitle   = IF index(wdetail.drivnam1," ") <> 0 THEN TRIM(substr(wdetail.drivnam1,1,index(wdetail.drivnam1," "))) ELSE ""  
                nv_name     = IF index(wdetail.drivnam1," ") <> 0 THEN TRIM(substr(wdetail.drivnam1,index(wdetail.drivnam1," "),INDEX(wdetail.drivnam1," ")) ELSE wdetail.drivnam1  
                nv_lname    = IF index(wdetail.drivnam1," ") <> 0 THEN TRIM(substr(wdetail.drivnam1,R-INDEX(wdetail.drivnam1," "))) ELSE "" */
                nv_drinam   = trim(wdetail.drivnam1) /*nv_ntitle + " " + nv_name  + " " + nv_lname*/
                nv_dicno    = IF index(wdetail.drivicno1,"/") <> 0 THEN trim(SUBSTR(wdetail.drivicno1,R-INDEX(wdetail.drivicno1,"/") + 1)) ELSE "" 
                /*nv_dgender  = "" /*trim(wdrive.dgender1) */*/ /*A67-0114*/
                nv_dbirth   = trim(wdetail.driag1)
                nv_dage     = nv_drivage1
                nv_doccup   = trim(wdetail.drivocc1) 
                nv_ddriveno = IF index(wdetail.drivicno1,"/") <> 0 THEN trim(SUBSTR(wdetail.drivicno1,1,INDEX(wdetail.drivicno1,"/") - 1)) ELSE trim(wdetail.drivicno1)
                nv_drivexp  = ""  /*trim(wdrive.drivexp1)  */
                nv_dconsent = "" /*TRIM(wdrive.dconsen1) */ 
                nv_dlevel   = IF INTE(wdetail.drivlevel1) = 0 THEN 1 ELSE INTE(wdetail.drivlevel1)  
                wdetail.drilevel = STRING(nv_dlevel)   
                nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                              ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
        RUN proc_mailtxt.
    END.

    IF wdetail.driag2 <> " "  AND wdetail.drivnam2 <> " " THEN DO: 
        ASSIGN nv_drivname = "" 
               nv_drivname = TRIM(wdetail.drivnam2) .
        RUN proc_clearmailtxt .
        if nv_drivage2 < year(today) then do:
            nv_drivage2 =  YEAR(TODAY) - nv_drivage2  .
            ASSIGN nv_dribirth    = STRING(DATE(wdetail.driag2),"99/99/9999") /* �.�. */
                   nv_drivbir2    = STRING(INT(SUBSTR(wdetail.driag2,7,4))  + 543 )
                   wdetail.driag2 = SUBSTR(wdetail.driag2,1,6) + nv_drivbir2
                   wdetail.driag2 = STRING(DATE(wdetail.driag2),"99/99/9999") . /* �.�. */
        END.
        ELSE DO:
            nv_drivage2 =  YEAR(TODAY) - (nv_drivage2 - 543).
            ASSIGN nv_drivbir2    = STRING(INT(SUBSTR(wdetail.driag2,7,4)))
                   nv_dribirth    = SUBSTR(wdetail.driag2,1,6) + STRING((INTE(nv_drivbir2) - 543),"9999")  /* �.�. */
                   wdetail.driag2 = SUBSTR(wdetail.driag2,1,6) + nv_drivbir2   
                   wdetail.driag2 = STRING(DATE(wdetail.driag2),"99/99/9999")  . /* �.�. */
        END.
        ASSIGN  n_count        = 2
                /*nv_ntitle   = trim(wdrive.ntitle2)     */
                /*nv_name     = trim(wdetail.drivnam2 )  */
                /*nv_lname    = trim(wdrive.lname2)      */
                nv_drinam   = trim(wdetail.drivnam2) /*nv_ntitle + " " + nv_name  + " " + nv_lname*/
                nv_dicno    = IF index(wdetail.drivicno2,"/") <> 0 THEN trim(SUBSTR(wdetail.drivicno2,R-INDEX(wdetail.drivicno2,"/") + 1)) ELSE ""    
                /*nv_dgender  = "" /*trim(wdrive.dgender2) */*/ /*A67-0114*/
                nv_dbirth   = trim(wdetail.driag2)
                nv_dage     = nv_drivage2
                nv_doccup   = trim(wdetail.drivocc2) 
                nv_ddriveno = IF index(wdetail.drivicno2,"/") <> 0 THEN trim(SUBSTR(wdetail.drivicno2,1,INDEX(wdetail.drivicno2,"/") - 1)) ELSE trim(wdetail.drivicno2)
                nv_drivexp  = ""  /*trim(wdrive.drivexp1)  */
                nv_dconsent = "" /*TRIM(wdrive.dconsen1) */ 
                nv_dlevel   = IF INTE(wdetail.drivlevel2) = 0 THEN 1 ELSE INTE(wdetail.drivlevel2)  
                wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
                nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                              ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
        RUN proc_mailtxt.
    END.

    IF wdetail.drivag3 <> " "  AND wdetail.drivnam3 <> " " THEN DO:
        ASSIGN nv_drivname = "" 
               nv_drivname = TRIM(wdetail.drivnam3) .
        RUN proc_clearmailtxt .
        if nv_drivage3 < year(today) then do:
            nv_drivage3 =  YEAR(TODAY) - nv_drivage3  .
            ASSIGN nv_dribirth    = STRING(DATE(wdetail.drivag3),"99/99/9999") /* �.�. */
                   nv_drivbir3    = STRING(INT(SUBSTR(wdetail.drivag3,7,4))  + 543 )
                   wdetail.drivag3 = SUBSTR(wdetail.drivag3,1,6) + nv_drivbir3
                   wdetail.drivag3 = STRING(DATE(wdetail.drivag3),"99/99/9999") . /* �.�. */
        END.
        ELSE DO:
            nv_drivage3 =  YEAR(TODAY) - (nv_drivage3 - 543).
            ASSIGN nv_drivbir3    = STRING(INT(SUBSTR(wdetail.drivag3,7,4)))
                   nv_dribirth    = SUBSTR(wdetail.drivag3,1,6) + STRING((INTE(nv_drivbir3) - 543),"9999")  /* �.�. */
                   wdetail.drivag3 = SUBSTR(wdetail.drivag3,1,6) + nv_drivbir3   
                   wdetail.drivag3 = STRING(DATE(wdetail.drivag3),"99/99/9999")  . /* �.�. */
        END.
        ASSIGN  n_count        = 3
                /*nv_ntitle   = trim(wdrive.ntitle3)  
                nv_name     = trim(wdetail.drivnam3 )  
                nv_lname    = trim(wdrive.lname3) */
                nv_drinam   = trim(wdetail.drivnam3) /*nv_ntitle + " " + nv_name  + " " + nv_lname*/
                nv_dicno    = IF index(wdetail.drivicno3,"/") <> 0 THEN trim(SUBSTR(wdetail.drivicno3,R-INDEX(wdetail.drivicno3,"/") + 1)) ELSE "" 
                /*nv_dgender  = "" /*trim(wdrive.dgender3) */*/ /*A67-0114*/
                nv_dbirth   = trim(wdetail.drivag3)
                nv_dage     = nv_drivage3
                nv_doccup   = trim(wdetail.drivocc3) 
                nv_ddriveno = IF index(wdetail.drivicno3,"/") <> 0 THEN trim(SUBSTR(wdetail.drivicno3,1,INDEX(wdetail.drivicno3,"/") - 1)) ELSE trim(wdetail.drivicno3)
                nv_drivexp  = ""  /*trim(wdrive.drivexp3)  */
                nv_dconsent = "" /*TRIM(wdrive.dconsen3) */ 
                nv_dlevel   = IF INTE(wdetail.drivlevel3) = 0 THEN 1 ELSE INTE(wdetail.drivlevel3)  
                wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
                nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                              ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
        RUN proc_mailtxt.
    END.

    IF wdetail.drivag4 <> " "  AND wdetail.drivnam4 <> " " THEN DO: 
        ASSIGN nv_drivname = "" 
               nv_drivname = TRIM(wdetail.drivnam4) .
        RUN proc_clearmailtxt .
        if nv_drivage4 < year(today) then do:
            nv_drivage4 =  YEAR(TODAY) - nv_drivage4  .
            ASSIGN nv_dribirth    = STRING(DATE(wdetail.drivag4),"99/99/9999") /* �.�. */
                   nv_drivbir4    = STRING(INT(SUBSTR(wdetail.drivag4,7,4))  + 543 )
                   wdetail.drivag4 = SUBSTR(wdetail.drivag4,1,6) + nv_drivbir4
                   wdetail.drivag4 = STRING(DATE(wdetail.drivag4),"99/99/9999") . /* �.�. */
        END.
        ELSE DO:
            nv_drivage4 =  YEAR(TODAY) - (nv_drivage4 - 543).
            ASSIGN nv_drivbir4    = STRING(INT(SUBSTR(wdetail.drivag4,7,4)))
                   nv_dribirth    = SUBSTR(wdetail.drivag4,1,6) + STRING((INTE(nv_drivbir4) - 543),"9999")  /* �.�. */
                   wdetail.drivag4 = SUBSTR(wdetail.drivag4,1,6) + nv_drivbir4   
                   wdetail.drivag4 = STRING(DATE(wdetail.drivag4),"99/99/9999")  . /* �.�. */
        END.
        ASSIGN  n_count        = 4
                /*nv_ntitle   = trim(wdrive.ntitle4)  
                nv_name     = trim(wdetail.drivnam4 )  
                nv_lname    = trim(wdrive.lname4)*/
                nv_drinam   = trim(wdetail.drivnam4) /*nv_ntitle + " " + nv_name  + " " + nv_lname*/
                nv_dicno    = IF index(wdetail.drivicno4,"/") <> 0 THEN TRIM(SUBSTR(wdetail.drivicno4,R-INDEX(wdetail.drivicno4,"/") + 1)) ELSE ""    
                /*nv_dgender  = "" /*trim(wdrive.dgender4) */*/ /*A67-0114*/
                nv_dbirth   = trim(wdetail.drivag4)
                nv_dage     = nv_drivage4
                nv_doccup   = trim(wdetail.drivocc4) 
                nv_ddriveno = IF index(wdetail.drivicno4,"/") <> 0 THEN trim(SUBSTR(wdetail.drivicno4,1,INDEX(wdetail.drivicno4,"/") - 1)) ELSE trim(wdetail.drivicno4)
                nv_drivexp  = ""  /*trim(wdrive.drivexp4)  */
                nv_dconsent = "" /*TRIM(wdrive.dconsen4) */ 
                nv_dlevel   = IF INTE(wdetail.drivlevel4) = 0 THEN 1 ELSE INTE(wdetail.drivlevel4)  
                wdetail.drilevel = IF INTE(nv_dlevel) < INTE(wdetail.drilevel) THEN string(nv_dlevel) ELSE wdetail.drilevel 
                nv_dlevper  = IF      inte(nv_dlevel) = 1 THEN 100 ELSE IF inte(nv_dlevel) = 2 THEN 90 
                              ELSE IF inte(nv_dlevel) = 3 THEN 80  ELSE IF inte(nv_dlevel) = 4 THEN 70 ELSE 60      .
        RUN proc_mailtxt.
    END.

    IF wdetail.drivag5 <> " "  AND wdetail.drivnam5 <> " " THEN DO:
        ASSIGN nv_drivname = "" 
               nv_drivname = TRIM(wdetail.drivnam5) .

        RUN proc_clearmailtxt .
        if nv_drivage5 < year(today) then do:
            nv_drivage5 =  YEAR(TODAY) - nv_drivage5  .
            ASSIGN nv_dribirth    = STRING(DATE(wdetail.drivag5),"99/99/9999") /* �.�. */
                   nv_drivbir5    = STRING(INT(SUBSTR(wdetail.drivag5,7,4))  + 543 )
                   wdetail.drivag5 = SUBSTR(wdetail.drivag5,1,6) + nv_drivbir5
                   wdetail.drivag5 = STRING(DATE(wdetail.drivag5),"99/99/9999") . /* �.�. */
        END.
        ELSE DO:
            nv_drivage5 =  YEAR(TODAY) - (nv_drivage5 - 543).
            ASSIGN nv_drivbir5    = STRING(INT(SUBSTR(wdetail.drivag5,7,4)))
                   nv_dribirth    = SUBSTR(wdetail.drivag5,1,6) + STRING((INTE(nv_drivbir5) - 543),"9999")  /* �.�. */
                   wdetail.drivag5 = SUBSTR(wdetail.drivag5,1,6) + nv_drivbir5   
                   wdetail.drivag5 = STRING(DATE(wdetail.drivag5),"99/99/9999")  . /* �.�. */
        END.
        ASSIGN  n_count        = 5
                /*nv_ntitle   = trim(wdrive.ntitle5)  
                nv_name     = trim(wdetail.drivnam5 )  
                nv_lname    = trim(wdrive.lname5)*/
                nv_drinam   = trim(wdetail.drivnam5) /*nv_ntitle + " " + nv_name  + " " + nv_lname*/
                nv_dicno    = IF index(wdetail.drivicno5,"/") <> 0 THEN trim(SUBSTR(wdetail.drivicno5,R-INDEX(wdetail.drivicno5,"/") + 1)) ELSE ""    
                /*nv_dgender  = "" /*trim(wdrive.dgender5) */ */ /*A67-0114*/
                nv_dbirth   = trim(wdetail.drivag5)
                nv_dage     = nv_drivage5
                nv_doccup   = trim(wdetail.drivocc5) 
                nv_ddriveno = IF index(wdetail.drivicno5,"/") <> 0 THEN trim(SUBSTR(wdetail.drivicno5,1,INDEX(wdetail.drivicno5,"/") - 1)) ELSE trim(wdetail.drivicno5)
                nv_drivexp  = ""  /*trim(wdrive.drivexp5)  */
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
        IF (wdetail.prepol = "") THEN RUN proc_usdcod.
        ELSE RUN proc_usdcodrenew.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_driver2 c-Win 
PROCEDURE proc_driver2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR no_policy AS CHAR FORMAT "x(20)" .
DEF VAR no_rencnt AS CHAR FORMAT "99".
DEF VAR no_endcnt AS CHAR FORMAT "999".
DEF VAR no_riskno AS CHAR FORMAT "999".
DEF VAR no_itemno AS CHAR FORMAT "999".
DEF VAR n_year    AS DECI INIT 0.
ASSIGN 
    n_year    = (YEAR(TODAY) + 543 )
    no_policy = sic_bran.uwm301.policy 
    no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") 
    no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") 
    no_riskno = "001"
    no_itemno = "001"
    nv_drivno = 0
    nv_lnumber = 1 
    nv_sexdri  = "" .
FIND FIRST stat.mailtxt_fil   USE-INDEX mailtxt01 WHERE 
    stat.mailtxt_fil.policy  = trim(wdetail.prepol) + "00" + "000" +  "001" + "001"  AND 
    stat.mailtxt_fil.lnumber = 1  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE stat.mailtxt_fil THEN DO:
    FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
        brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
        brstat.mailtxt_fil.bchyr   = nv_batchyr   AND                                               
        brstat.mailtxt_fil.bchno   = nv_batchno   AND
        brstat.mailtxt_fil.bchcnt  = nv_batcnt    NO-LOCK  NO-ERROR  NO-WAIT.
    IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.  
    FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
        brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno     AND
        brstat.mailtxt_fil.lnumber = nv_lnumber    AND
        brstat.mailtxt_fil.bchyr   = nv_batchyr    AND                                               
        brstat.mailtxt_fil.bchno   = nv_batchno    AND
        brstat.mailtxt_fil.bchcnt  = nv_batcnt     NO-LOCK  NO-ERROR  NO-WAIT.
    IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
        CREATE brstat.mailtxt_fil.
        ASSIGN                                           
            brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
            brstat.mailtxt_fil.lnumber   = stat.mailtxt_fil.lnumber
            nv_lnumber                   = 1
            brstat.mailtxt_fil.ltext     = stat.mailtxt_fil.ltext
            wdetail.drivnam1             = SUBSTRING(stat.mailtxt_fil.ltext,1,50)
            brstat.mailtxt_fil.ltext2    = stat.mailtxt_fil.ltext2 
            wdetail.driag1               = SUBSTRING(stat.mailtxt_fil.ltext2,13,2)
            nv_drivno                    = 1
            brstat.mailtxt_fil.bchyr     = nv_batchyr 
            brstat.mailtxt_fil.bchno     = nv_batchno 
            brstat.mailtxt_fil.bchcnt    = nv_batcnt 
            SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
            nv_sexdri                    = SUBSTRING(stat.mailtxt_fil.ltext,1,50). 
        IF wdetail.driag1 <> "" THEN  nv_drivage1 =  n_year - INT(SUBSTR(wdetail.driag1,7,4))  .
    END.
    FIND NEXT stat.mailtxt_fil USE-INDEX mailtxt01 WHERE 
        stat.mailtxt_fil.policy   = trim(wdetail.prepol) + "00" + "000" +  "001" + "001"    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.mailtxt_fil THEN DO: 
        CREATE brstat.mailtxt_fil. 
        ASSIGN
            brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
            brstat.mailtxt_fil.lnumber  = stat.mailtxt_fil.lnumber
            brstat.mailtxt_fil.ltext    = stat.mailtxt_fil.ltext
            wdetail.drivnam2            = SUBSTRING(stat.mailtxt_fil.ltext,1,50)
            brstat.mailtxt_fil.ltext2   = stat.mailtxt_fil.ltext2
            wdetail.driag2              = SUBSTRING(stat.mailtxt_fil.ltext2,13,2)
            nv_drivage2                 = deci(SUBSTRING(stat.mailtxt_fil.ltext2,13,2))
            nv_drivno                   = 2 
            brstat.mailtxt_fil.bchyr    = nv_batchyr 
            brstat.mailtxt_fil.bchno    = nv_batchno 
            brstat.mailtxt_fil.bchcnt   = nv_batcnt 
            SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   
            nv_sexdri    = wdetail.drivnam2 . 
        IF wdetail.driag2 <> "" THEN nv_drivage2 =  n_year - INT(SUBSTR(wdetail.driag2,7,4))  .
    END.   /*drivnam2 <> " " */ 
END.                            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initcal c-Win 
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
         nv_41prmt  = 0      /* �к����� ��.*/  
         nv_412prmt = 0       /* �к����� ��.*/ 
         nv_413prmt = 0       /* �к����� ��.*/ 
         nv_414prmt = 0       /* �к����� ��.*/ 
         nv_42prmt  = 0      /* �к����� ��.*/  
         nv_43prmt  = 0      /* �к����� ��.*/ 
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
         nv_dodamt   = 0  /*A67-0029*/ /* �к����� DOD */   
         nv_dadamt   = 0  /*A67-0029*/ /* �к����� DOD1 */  
         nv_dpdamt   = 0  /*A67-0029*/ /* �к����� DPD */   
         nv_ncbamt   = 0  /* �к�����  NCB PREMIUM */           
         nv_fletamt  = 0  /* �к�����  FLEET PREMIUM */          
         nv_dspcamt  = 0  /* �к�����  DSPC PREMIUM */           
         nv_dstfamt  = 0  /* �к�����  DSTF PREMIUM */           
         nv_clmamt   = 0  /* �к�����  LOAD CLAIM PREMIUM */ 
         nv_baseprm  = 0
         nv_baseprm3 = 0
         nv_pdprem   = 0
         nv_netprem = 0     /*�����ط�� */
         nv_gapprm  = 0     /*������� */
         nv_gapprem  = 0  
         nv_flagprm = "N"   /* N = �����ط��, G = ������� */
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
         /* end A67-0029*/

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
/*    A63-00472   */
IF n_icno <> "" THEN DO:
    IF n_icno = "0105535086729"  THEN DO:
        FIND LAST tbinsurid WHERE 
            tbinsurid.insurbr   = trim(wdetail.postcd) AND 
            tbinsurid.insuricno = n_icno NO-LOCK NO-ERROR.
        IF AVAIL tbinsurid THEN ASSIGN nv_insref = tbinsurid.insurcode .
    END.
    ELSE DO:
        FOR EACH tbinsurid WHERE tbinsurid.insuricno = n_icno NO-LOCK.
            ASSIGN nv_insref = tbinsurid.insurcode .
        END.
    END.
END.
/*    A63-00472   */
IF nv_insref = "" THEN DO:
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
              ELSE nv_typ = "0s".  /*0s= �ؤ�Ÿ����� Cs = �ԵԺؤ�� */
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
          sicsyac.xmm600.addr2    = TRIM(wdetail.tambon)      /*Address line 2*/
          sicsyac.xmm600.addr3    = TRIM(wdetail.amper)       /*Address line 3*/
          sicsyac.xmm600.addr4    = TRIM(wdetail.country)     
          sicsyac.xmm600.homebr   = TRIM(wdetail.branch)      /*Home branch*/
          sicsyac.xmm600.opened   = TODAY                     
          sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
          sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
          sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
          sicsyac.xmm600.usrid    = nv_usrid  
          sicsyac.xmm600.birthdate = IF wdetail.brithday = "" THEN ?  ELSE 
                     date(substr(TRIM(wdetail.brithday),7,2) + substr(TRIM(wdetail.brithday),5,2) + STRING(deci(substr(TRIM(wdetail.brithday),1,4)))) 
          sicsyac.xmm600.dtyp20   = IF wdetail.brithday = "" THEN "" ELSE "DOB"
          sicsyac.xmm600.dval20   = IF wdetail.brithday = "" THEN "" ELSE substr(TRIM(wdetail.brithday),7,2) + 
                                      substr(TRIM(wdetail.brithday),5,2) +
                                      STRING(deci(substr(TRIM(wdetail.brithday),1,4)) ).
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
          sicsyac.xmm600.addr1    = TRIM(wdetail.addr1)       /*Address line 1*/
          sicsyac.xmm600.addr2    = TRIM(wdetail.tambon)      /*Address line 2*/
          sicsyac.xmm600.addr3    = TRIM(wdetail.amper)       /*Address line 3*/
          sicsyac.xmm600.addr4    = TRIM(wdetail.country)     /*Address line 4*/
          sicsyac.xmm600.postcd   = TRIM(wdetail.postcd)      /*Postal Code*/
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
          sicsyac.xmm600.dval20   = ""
          sicsyac.xmm600.birthdate = IF wdetail.brithday = "" THEN ?  ELSE 
                     date(substr(TRIM(wdetail.brithday),7,2) + substr(TRIM(wdetail.brithday),5,2) + STRING(deci(substr(TRIM(wdetail.brithday),1,4)))) 
          sicsyac.xmm600.dtyp20   = IF wdetail.brithday = "" THEN "" ELSE "DOB"
          sicsyac.xmm600.dval20   = IF wdetail.brithday = "" THEN "" ELSE substr(TRIM(wdetail.brithday),7,2) + 
                                      substr(TRIM(wdetail.brithday),5,2) +
                                      STRING(deci(substr(TRIM(wdetail.brithday),1,4)) + 543 ).
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
          sicsyac.xmm600.dval20 =  wdetail.brithday*/           /*string(wdetail.brithday).*/
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
              sicsyac.xtm600.addr2   = TRIM(wdetail.tambon)     /*address line 2*/
              sicsyac.xtm600.addr3   = TRIM(wdetail.amper)     /*address line 3*/
              sicsyac.xtm600.addr4   = TRIM(wdetail.country)     /*address line 4*/
              sicsyac.xtm600.name2   = ""                      /*Name of Insured Line 2*/
              sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)    /*Title*/
              sicsyac.xtm600.name3   = ""                      /*Name of Insured Line 3*/
              sicsyac.xtm600.fname   = "" .                    /*First Name*/
      END.
  END.
END. /* nv_insref = ""  A63-00472   */
/* add by : A64-0092*/
ELSE DO:
    FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
        sicsyac.xmm600.acno     =  nv_insref    NO-ERROR NO-WAIT.  
    IF AVAIL sicsyac.xmm600 THEN
        ASSIGN
         nv_insref         =  sicsyac.xmm600.acno
         wdetail.tiname    =  sicsyac.xmm600.ntitle  
         wdetail.firstName =  sicsyac.xmm600.firstname   
         wdetail.lastName  =  sicsyac.xmm600.lastName   
         wdetail.addr1     =  sicsyac.xmm600.addr1      
         wdetail.tambon    =  sicsyac.xmm600.addr2      
         wdetail.amper     =  sicsyac.xmm600.addr3      
         wdetail.country   =  sicsyac.xmm600.addr4      
         wdetail.postcd    =  sicsyac.xmm600.postcd      
         n_icno            =  sicsyac.xmm600.icno       
         wdetail.codeocc   =  sicsyac.xmm600.codeocc     
         wdetail.codeaddr1 =  sicsyac.xmm600.codeaddr1   
         wdetail.codeaddr2 =  sicsyac.xmm600.codeaddr2   
         wdetail.codeaddr3 =  sicsyac.xmm600.codeaddr3      .  
END.
/* end : A64-0092 */
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
    sicsyac.xmm600.acno     =  nv_insref    NO-ERROR NO-WAIT.  
IF AVAIL sicsyac.xmm600 THEN
    ASSIGN
    sicsyac.xmm600.acno_typ  = TRIM(wdetail.insnamtyp)   /*�������١��� CO = �ԵԺؤ��  PR = �ؤ��*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    sicsyac.xmm600.icno      = trim(n_icno)       
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)     .  
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref   NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN
    ASSIGN 
    sicsyac.xtm600.postcd    = trim(wdetail.postcd)           
    sicsyac.xtm600.firstname = trim(wdetail.firstName)        
    sicsyac.xtm600.lastname  = trim(wdetail.lastName)     .   
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
            nv_insref  =    wdetail.branch   + String(1,"999999")
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
                ELSE nv_insref = wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insuricno c-Win 
PROCEDURE proc_insuricno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH tbinsurid. DELETE tbinsurid. END.

CREATE tbinsurid. 
ASSIGN tbinsurid.insurcode = "MC44637"   tbinsurid.insuricno = "0105542083438".
CREATE tbinsurid.
ASSIGN tbinsurid.insurcode = "MC44731"   tbinsurid.insuricno = "0105546099428".
CREATE tbinsurid.
ASSIGN tbinsurid.insurcode = "MC44722"   tbinsurid.insuricno = "0205552019634".
CREATE tbinsurid.
ASSIGN tbinsurid.insurcode = "JC01044"   tbinsurid.insuricno = "0105538141330".
/* A65-0035 */
CREATE tbinsurid.
ASSIGN tbinsurid.insurcode = "MC46363"   tbinsurid.insuricno = "0105535086729"  tbinsurid.insurbr = "10310".
CREATE tbinsurid.
ASSIGN tbinsurid.insurcode = "MC46614"   tbinsurid.insuricno = "0105535086729"  tbinsurid.insurbr = "21140".
/* end : A65-0035 */
RELEASE   tbinsurid.
OPEN QUERY br_proinsur FOR EACH tbinsurid.
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
                 brstat.mailtxt_fil.ltext2    = nv_dbirth + "  " + string(nv_dage)  /* �.�. */
                 SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)   =  IF nv_doccup  = "" THEN "-" ELSE nv_doccup 
                 SUBSTRING(brstat.mailtxt_fil.ltext2,101,50)  =  nv_dicno
                 SUBSTRING(brstat.mailtxt_fil.ltext2,151,50)  =  nv_ddriveno 
                 SUBSTRING(brstat.mailtxt_fil.ltext2,201,4)   =  "" 
                 brstat.mailtxt_fil.drivnam    = nv_drinam
                 brstat.mailtxt_fil.titlenam   = nv_ntitle
                 brstat.mailtxt_fil.firstnam   = nv_name  
                 brstat.mailtxt_fil.lastnam    = nv_lname 
                 brstat.mailtxt_fil.drivbirth  = IF trim(nv_dribirth) <> "" THEN date(nv_dribirth) ELSE ? /* �.� */
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
             brstat.mailtxt_fil.ltext2    = nv_dbirth + "  " + string(nv_dage)  /* �.�. */
             SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)   =  IF nv_doccup  = "" THEN "-" ELSE nv_doccup 
             SUBSTRING(brstat.mailtxt_fil.ltext2,101,50)  =  nv_dicno
             SUBSTRING(brstat.mailtxt_fil.ltext2,151,50)  =  nv_ddriveno 
             SUBSTRING(brstat.mailtxt_fil.ltext2,201,4)   =  ""
             brstat.mailtxt_fil.drivnam    = nv_drinam
             brstat.mailtxt_fil.titlenam   = nv_ntitle
             brstat.mailtxt_fil.firstnam   = nv_name  
             brstat.mailtxt_fil.lastnam    = nv_lname 
             brstat.mailtxt_fil.drivbirth  = IF trim(nv_dribirth) <> "" THEN date(nv_dribirth) ELSE ? /* �.�. */
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
    Find LAST stat.maktab_fil Use-index      maktab04           Where
        stat.maktab_fil.makdes   =    wdetail.brand             And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc) AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass         AND
        /*(stat.maktab_fil.si - (stat.maktab_fil.si * 30 / 100 ) LE deci(wdetail.si)   AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * 30 / 100 ) GE deci(wdetail.si) ) AND*/
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook         =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*//*A65-0035*/
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        /*sic_bran.uwm301.engine  =  stat.maktab_fil.engine
        nv_engine               =  stat.maktab_fil.engine*/
        sic_bran.uwm301.engine  =  IF sic_bran.uwm301.engine <> 0  THEN sic_bran.uwm301.engine ELSE stat.maktab_fil.engine /*A65-0035*/
        nv_engine               =  IF sic_bran.uwm301.engine <> 0  THEN sic_bran.uwm301.engine ELSE stat.maktab_fil.engine /*A65-0035*/
        sic_bran.uwm301.tons    =  IF sic_bran.uwm301.tons <> 0 THEN  sic_bran.uwm301.tons  ELSE stat.maktab_fil.tons. /*A65-0035*/
END.
ELSE DO:
    Find LAST stat.maktab_fil Use-index      maktab04           Where
        stat.maktab_fil.makdes   =    wdetail.brand             And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
        stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND
        /*stat.maktab_fil.engine   =     Integer(wdetail.engcc) AND*/
        stat.maktab_fil.sclass   =     wdetail.subclass         AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * 30 / 100 ) LE deci(wdetail.si)   AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * 30 / 100 ) GE deci(wdetail.si) ) AND
        stat.maktab_fil.seats    =     INTEGER(wdetail.seat)       
        No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        Assign
        wdetail.redbook         =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        /*sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes*/ /*A65-0035*/
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.engine  =  IF sic_bran.uwm301.engine <> 0  THEN sic_bran.uwm301.engine ELSE stat.maktab_fil.engine /*A65-0035*/
        nv_engine               =  stat.maktab_fil.engine 
        sic_bran.uwm301.tons    =  IF sic_bran.uwm301.tons <> 0 THEN  sic_bran.uwm301.tons  ELSE stat.maktab_fil.tons. /*A65-0035*/
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
/* comment by : A65-0035 ��������¡��ҹ....
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
....end A65-0035...*/
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
        n_brand  = wdetail.brand
        n_model  = wdetail.model .
        /* A65-0035....
        wdetail.brand = substr(n_brand,1,INDEX(n_brand," ") - 1)
        n_index       = INDEX(n_brand," ") + 1
        n_model       = substr(n_brand,n_index).
        ..end a65-0035..*/
    IF INDEX(n_model," ") <> 0 THEN 
        n_model = substr(n_model,1,INDEX(n_model," ") - 1).
    wdetail.model  = n_model.
    IF index(wdetail.brand,"benz") <> 0 THEN DO: 
        ASSIGN wdetail.brand = "MERCEDES-BENZ".
        /*IF wdetail.model = "cls" THEN wdetail.model = "CLS250".*/
    END.
    IF index(wdetail.model,"cab4") <> 0 THEN wdetail.model = "cab".
END.
ELSE DO:
    IF index(wdetail.brand,"benz") <> 0 THEN wdetail.brand = "MERCEDES-BENZ".
    ASSIGN 
        n_index = INDEX(n_model," ") + 1
        n_model = substr(n_model,n_index,LENGTH(n_model))
        n_index = INDEX(n_model," ") - 1.
    /*IF n_index < 1  THEN wdetail.model  = substr(n_model,1,LENGTH(n_model)) .
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
DEF VAR nv_yr  AS INT INIT 0.  /*A64-0271*/

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
    IF chk_sticker  <>  chr_sticker  THEN ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Sticker Number �� Generate ����� ���ͧ�ҡ Module Error".
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002    WHERE
      sicuw.uwm100.cedpol =  wdetail.Account_no AND
      sicuw.uwm100.poltyp =  wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF (sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES ) AND (sicuw.uwm100.expdat > date(wdetail.comdat))     THEN  
        ASSIGN wdetail.pass    = "N"
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
  END.       /*wdetail.stk  <>  ""*/
  ELSE DO:  /*sticker = ""*/ 
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
      sicuw.uwm100.cedpol = wdetail.Account_no AND
      sicuw.uwm100.poltyp = wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL sicuw.uwm100 THEN DO:
      IF (sicuw.uwm100.name1  <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES ) AND (sicuw.uwm100.expdat > date(wdetail.comdat))  THEN 
        ASSIGN  wdetail.pass = "N"
        wdetail.comment      = wdetail.comment + "| �����Ţ������������١������� "
        wdetail.warning      = "Program Running Policy No. �����Ǥ���".
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
    IF chk_sticker  <>  chr_sticker  THEN ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Sticker Number �� Generate ����� ���ͧ�ҡ Module Error".
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
      sicuw.uwm100.cedpol = wdetail.Account_no AND
      sicuw.uwm100.poltyp = wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF ( sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES ) AND (sicuw.uwm100.expdat > date(wdetail.comdat)) THEN 
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| �����Ţ������������١������� "
        wdetail.warning = "Program Running Policy No. �����Ǥ���".
    END.
    nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
    ELSE wdetail.stk = wdetail.stk.
    FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
      stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
    IF AVAIL stat.detaitem THEN ASSIGN  wdetail.pass    = "N"
      wdetail.comment = wdetail.comment + "| �����Ţ Sticker ��������١�������"
      wdetail.warning = "Program Running Policy No. �����Ǥ���".
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
IF (wdetail.poltyp = "V70") AND (wdetail.Docno <> "")  THEN ASSIGN nv_docno  = wdetail.Docno
    nv_accdat = TODAY.
ELSE DO:
        IF wdetail.docno  = "" THEN nv_docno  = "".
        IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
IF wdetail.poltyp = "v72" THEN wdetail.benname = "".
/*IF index(wdetail.benname,"�����") <> 0 THEN wdetail.benname = "��Ҥ�÷���� �ӡѴ (��Ҫ�)".
ELSE  wdetail.benname = "". A60-0225 */
IF DECI(substr(wdetail.comdat,7,4)) > (YEAR(TODAY) + 2)  THEN wdetail.comdat = substr(wdetail.comdat,1,6) + STRING(DECI(substr(wdetail.comdat,7,4)) - 543).
IF DECI(substr(wdetail.expdat,7,4)) > (YEAR(TODAY) + 3)  THEN wdetail.expdat = substr(wdetail.expdat,1,6) + STRING(DECI(substr(wdetail.expdat,7,4)) - 543).
ASSIGN n_icno  = ""
  n_icno  =  IF index(wdetail.not_office," ���ʼ����:") <> 0 THEN trim(SUBSTR(wdetail.not_office,index(wdetail.not_office," ���ʼ����:") + 13 )) 
             ELSE ""
  n_icno = REPLACE(n_icno,"'","").
/* create by A60-0405 */
IF LENGTH(n_icno) < 13 THEN DO:
    ASSIGN  wdetail.pass    = "Y"
        wdetail.warning = "�Ţ�ѵû�ЪҪ����ú 13 ��ѡ ".
END.
/* end A60-0405 */
RUN proc_insnam.   /* by Kridtiya i...A56-0323... */
RUN proc_insnam2 . /*Add by Kridtiya i. A63-0472*/
RUN proc_chkcode . /*A64-0138*/

DO TRANSACTION:
  ASSIGN sic_bran.uwm100.renno  = ""
  sic_bran.uwm100.endno  = ""
  sic_bran.uwm100.poltyp = wdetail.poltyp
  sic_bran.uwm100.insref = trim(nv_insref)
  sic_bran.uwm100.opnpol = ""
  sic_bran.uwm100.anam2  = trim(n_icno)                /* ICNO  Cover Note A51-0071 Amparat */
  sic_bran.uwm100.ntitle = trim(wdetail.tiname)          
  sic_bran.uwm100.name1  = TRIM(wdetail.insnam)         
  sic_bran.uwm100.name2  = trim(wdetail.receipt_name)  /*���/���� */              
  sic_bran.uwm100.name3  = ""                 
  sic_bran.uwm100.addr1  = trim(wdetail.addr1)             
  sic_bran.uwm100.addr2  = trim(wdetail.tambon)  
  sic_bran.uwm100.addr3  = TRIM(wdetail.amper)   
  sic_bran.uwm100.addr4  = trim(wdetail.country) 
  sic_bran.uwm100.postcd = "" 
  sic_bran.uwm100.undyr  = String(Year(today),"9999") /*   nv_undyr  */
  sic_bran.uwm100.branch = caps(trim(wdetail.branch))       /*wdetail.n_branch */ /* nv_branch  */                        
  sic_bran.uwm100.dept   = nv_dept                    
  sic_bran.uwm100.usrid  = USERID(LDBNAME(1))         
  /*sic_bran.uwm100.fstdat = TODAY  */                /*TODAY *//*kridtiya i. a53-0171*/
  sic_bran.uwm100.fstdat = DATE(wdetail.comdat)       /*kridtiya i. a53-0171 ��� firstdate=comdate */
  sic_bran.uwm100.comdat = DATE(wdetail.comdat)       
  sic_bran.uwm100.expdat = date(wdetail.expdat)       
  sic_bran.uwm100.accdat = nv_accdat                  
  sic_bran.uwm100.tranty = "N"                        /*Transaction Type (N/R/E/C/T)*/
  sic_bran.uwm100.langug = "T"
  sic_bran.uwm100.acctim = "00:00"
  sic_bran.uwm100.trty11 = "M"      
  sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")     
  sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")
  sic_bran.uwm100.entdat = TODAY
  sic_bran.uwm100.curbil = "BHT"
  sic_bran.uwm100.curate = 1
  sic_bran.uwm100.instot = 1
  sic_bran.uwm100.prog   = "wgwtcgen"
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
  sic_bran.uwm100.finint = wdetail.deler           /*code deler */
  sic_bran.uwm100.dealer = wdetail.financecd              /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)    /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)     /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.postcd     = trim(wdetail.postcd)       /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.icno       = trim(n_icno)               /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)      /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)    /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)    /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)    /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.campaign   = trim(wdetail.producer)     /*trim(wdetail.campaign_ov).*/  /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.br_insured = trim(wdetail.br_insured) .
        
  ASSIGN  /*nv_yr = (YEAR(TODAY) - DECI(wdetail.caryear)) .*/ /*A67-0087*/
  /* add by : A67-0087 */ 
         nv_yr = (YEAR(TODAY) - DECI(wdetail.caryear) + 1 ) .
  IF wdetail.producer = "B3DM000007" AND trim(wdetail.prepol) = "" /*A67-0114*/ THEN DO:
      /*IF trim(wdetail.prepol) = ""  THEN DO:  A67-0114 */ 
         ASSIGN sic_bran.uwm100.cr_1    = "PB20K"      /*product*/  
                sic_bran.uwm100.opnpol  = "TRANSFER" .     /*promo */
    /* A67-0114..
      END.
      ELSE DO:
        ASSIGN sic_bran.uwm100.cr_1    = ""      /*product*/  
               sic_bran.uwm100.opnpol  = "" .     /*promo */
      END.
      ...end A67-0114..*/
  END.
  ELSE DO:
      IF wdetail.producer = "B3M0033" THEN DO:
         FIND LAST tbprotis  WHERE tbprotis.producer = trim(wdetail.producer) AND tbprotis.cover = TRIM(wdetail.covcod)  NO-LOCK NO-ERROR NO-WAIT.
           IF AVAIL tbprotis THEN DO:
               IF nv_yr <= 7 THEN DO:
                 IF wdetail.brand = "Ford" AND wdetail.garage = "G" AND wdetail.covcod = "1"  THEN DO:
                      ASSIGN sic_bran.uwm100.cr_1 = TRIM(tbprotis.product)     /*product*/  
                       sic_bran.uwm100.opnpol  = TRIM(tbprotis.promo) .     /*promo */
                 END.
                 ELSE IF wdetail.garage = "G" AND index(wdetail.remark,"FE2+") <> 0 AND wdetail.covcod = "2.2" THEN DO: 
                     ASSIGN sic_bran.uwm100.cr_1 = TRIM(tbprotis.product)     /*product*/  
                         sic_bran.uwm100.opnpol  = TRIM(tbprotis.promo) .     /*promo */ 
                 END.
                 ELSE DO:
                     ASSIGN sic_bran.uwm100.cr_1   = ""      /*product*/  
                            sic_bran.uwm100.opnpol = "" .     /*promo */ 
                 END. 
               END.
               ELSE DO:
                   ASSIGN sic_bran.uwm100.cr_1   = ""      /*product*/  
                          sic_bran.uwm100.opnpol = "" .     /*promo */ 
               END.
            END.
            ELSE DO:
               ASSIGN sic_bran.uwm100.cr_1   = ""      /*product*/  
                      sic_bran.uwm100.opnpol = "" .     /*promo */ 
            END.
      END.
      ELSE DO:
          FIND LAST tbprotis  WHERE tbprotis.producer = trim(wdetail.producer) NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL tbprotis THEN DO:
              /*IF wdetail.covcod = "1" AND wdetail.garage = "G"  AND nv_yr <= 7 THEN DO:  *//*A65-0035*/ 
              /*A65-0035*/
              IF wdetail.covcod = "1" AND wdetail.garage = "G"  THEN DO:   
                  IF wdetail.brand <> "Ford" AND nv_yr <= 5 THEN DO: 
                    ASSIGN sic_bran.uwm100.cr_1 = TRIM(tbprotis.product)     /*product*/  
                        sic_bran.uwm100.opnpol  = TRIM(tbprotis.promo) .     /*promo */
                  END.
                  /* end : A65-0035*/
                  IF wdetail.brand = "Ford" AND nv_yr <= 7 THEN DO:
                       ASSIGN sic_bran.uwm100.cr_1 = TRIM(tbprotis.product)     /*product*/  
                        sic_bran.uwm100.opnpol  = TRIM(tbprotis.promo) .     /*promo */
                  END.
              END.
              ELSE IF wdetail.covcod = "2.2" AND wdetail.garage = "G" AND index(wdetail.remark,"FE2+") <> 0 THEN DO: 
                  ASSIGN sic_bran.uwm100.cr_1 = TRIM(tbprotis.product)     /*product*/  
                      sic_bran.uwm100.opnpol  = TRIM(tbprotis.promo) .     /*promo */ 
              END.
              ELSE DO:
                  ASSIGN sic_bran.uwm100.cr_1   = ""      /*product*/  
                         sic_bran.uwm100.opnpol = "" .     /*promo */ 
              END. /* End A61-0313*/
          END.
          ELSE DO:
              ASSIGN sic_bran.uwm100.cr_1   = ""
                  sic_bran.uwm100.opnpol = "" .
          END.
      END.
  /* end : A60-0095 */
  END. /* A67-0087 */
  IF wdetail.prepol <> " " THEN DO:
      IF wdetail.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = ""
          sic_bran.uwm100.tranty  = "R".  
      ELSE 
          ASSIGN  sic_bran.uwm100.prvpol  = wdetail.prepol /*����繧ҹ Renew  ��ͧ����繤����ҧ*/
              sic_bran.uwm100.tranty  = "R".               /*Transaction Type (N/R/E/C/T)*/
  END.
  IF wdetail.pass = "Y" THEN sic_bran.uwm100.impflg  = YES.
  ELSE sic_bran.uwm100.impflg  = NO.
  IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
  IF wdetail.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
  ELSE  sic_bran.uwm100.polsta = "IF".
  IF fi_loaddat <> ? THEN  sic_bran.uwm100.trndat = fi_loaddat.
  ELSE  sic_bran.uwm100.trndat = TODAY.
  sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
  nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                    (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.  
END.   /*transaction*//**/
/*RUN proc_uwd100.*//*A65-0035*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policy-01 c-Win 
PROCEDURE proc_policy-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0138 date.28/06/2021...
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
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
    IF chk_sticker  <>  chr_sticker  THEN ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Sticker Number �� Generate ����� ���ͧ�ҡ Module Error".
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002    WHERE
      sicuw.uwm100.cedpol =  wdetail.Account_no AND
      sicuw.uwm100.poltyp =  wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF (sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES ) AND (sicuw.uwm100.expdat > date(wdetail.comdat))     THEN  
        ASSIGN wdetail.pass    = "N"
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
  END.       /*wdetail.stk  <>  ""*/
  ELSE DO:  /*sticker = ""*/ 
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
      sicuw.uwm100.cedpol = wdetail.Account_no AND
      sicuw.uwm100.poltyp = wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL sicuw.uwm100 THEN DO:
      IF (sicuw.uwm100.name1  <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES ) AND (sicuw.uwm100.expdat > date(wdetail.comdat))  THEN 
        ASSIGN  wdetail.pass = "N"
        wdetail.comment      = wdetail.comment + "| �����Ţ������������١������� "
        wdetail.warning      = "Program Running Policy No. �����Ǥ���".
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
    IF chk_sticker  <>  chr_sticker  THEN ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Sticker Number �� Generate ����� ���ͧ�ҡ Module Error".
    FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
      sicuw.uwm100.cedpol = wdetail.Account_no AND
      sicuw.uwm100.poltyp = wdetail.poltyp     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
      IF ( sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES ) AND (sicuw.uwm100.expdat > date(wdetail.comdat)) THEN 
        ASSIGN  wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| 04�����Ţ������������١������� "
        wdetail.warning = "Program Running Policy No. �����Ǥ���".
    END.
    nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
    ELSE wdetail.stk = wdetail.stk.
    FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
      stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
    IF AVAIL stat.detaitem THEN ASSIGN  wdetail.pass    = "N"
      wdetail.comment = wdetail.comment + "| �����Ţ Sticker ��������١�������"
      wdetail.warning = "Program Running Policy No. �����Ǥ���".
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
IF (wdetail.poltyp = "V70") AND (wdetail.Docno <> "")  THEN ASSIGN nv_docno  = wdetail.Docno
    nv_accdat = TODAY.
ELSE DO:
        IF wdetail.docno  = "" THEN nv_docno  = "".
        IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
IF wdetail.poltyp = "v72" THEN wdetail.benname = "".
/*IF index(wdetail.benname,"�����") <> 0 THEN wdetail.benname = "��Ҥ�÷���� �ӡѴ (��Ҫ�)".
ELSE  wdetail.benname = "". A60-0225 */
IF DECI(substr(wdetail.comdat,7,4)) > (YEAR(TODAY) + 2)  THEN wdetail.comdat = substr(wdetail.comdat,1,6) + STRING(DECI(substr(wdetail.comdat,7,4)) - 543).
IF DECI(substr(wdetail.expdat,7,4)) > (YEAR(TODAY) + 3)  THEN wdetail.expdat = substr(wdetail.expdat,1,6) + STRING(DECI(substr(wdetail.expdat,7,4)) - 543).
ASSIGN n_icno  = ""
  n_icno  =  IF index(wdetail.not_office," ���ʼ����:") <> 0 THEN trim(SUBSTR(wdetail.not_office,index(wdetail.not_office," ���ʼ����:") + 13 )) 
             ELSE ""
  n_icno = REPLACE(n_icno,"'","").
/* comment by Kridtiya i...A56-0323...                  
IF n_ICNO <> "" THEN DO:
  IF LENGTH(TRIM(n_ICNO)) = 13 THEN DO:
        DO WHILE nv_seq <= 12:
            nv_sum = nv_sum + INTEGER(SUBSTR(TRIM(n_ICNO),nv_seq,1)) * (14 - nv_seq).
            nv_seq = nv_seq + 1.
        END.
        nv_checkdigit = 11 - nv_sum MODULO 11.
        IF nv_checkdigit >= 10 THEN nv_checkdigit = nv_checkdigit - 10.
        IF STRING(nv_checkdigit) <> SUBSTR(TRIM(n_ICNO),13,1) THEN  
            ASSIGN  n_icno  = "".
    END. 
    ELSE ASSIGN  n_icno  = "". 
    IF      trim(wdetail.branch) = ""  THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0325 ....*/
    ELSE IF trim(wdetail.branch) = "A" THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0325 ....*/
    ELSE IF trim(wdetail.branch) = "B" THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0325 ....*/
    ELSE RUN proc_insnam. 
END.
ELSE DO:
    IF      trim(wdetail.branch) = ""  THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0325 ....*/
    ELSE IF trim(wdetail.branch) = "A" THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0325 ....*/
    ELSE IF trim(wdetail.branch) = "B" THEN  ASSIGN nv_insref = "".   /*Add kridtiya i. A55-0325 ....*/
    ELSE RUN proc_insnam. 
END.   ...end...comment by Kridtiya i...A56-0323... */
/* create by A60-0405 */
IF LENGTH(n_icno) < 13 THEN DO:
    ASSIGN  wdetail.pass    = "Y"
        wdetail.warning = "�Ţ�ѵû�ЪҪ����ú 13 ��ѡ ".
END.
/* end A60-0405 */
RUN proc_insnam.     /* by Kridtiya i...A56-0323... */
RUN proc_insnam2 . /*Add by Kridtiya i. A63-0472*/
DO TRANSACTION:
  ASSIGN sic_bran.uwm100.renno  = ""
  sic_bran.uwm100.endno  = ""
  sic_bran.uwm100.poltyp = wdetail.poltyp
  sic_bran.uwm100.insref = trim(nv_insref)
  sic_bran.uwm100.opnpol = ""
  sic_bran.uwm100.anam2  = trim(n_icno)                /* ICNO  Cover Note A51-0071 Amparat */
  sic_bran.uwm100.ntitle = trim(wdetail.tiname)          
  sic_bran.uwm100.name1  = TRIM(wdetail.insnam)         
  sic_bran.uwm100.name2  = trim(wdetail.receipt_name)  /*���/���� */              
  sic_bran.uwm100.name3  = ""                 
  sic_bran.uwm100.addr1  = trim(wdetail.addr1)             
  sic_bran.uwm100.addr2  = trim(wdetail.tambon)  
  sic_bran.uwm100.addr3  = TRIM(wdetail.amper)   
  sic_bran.uwm100.addr4  = trim(wdetail.country) 
  sic_bran.uwm100.postcd = "" 
  sic_bran.uwm100.undyr  = String(Year(today),"9999") /*   nv_undyr  */
  sic_bran.uwm100.branch = caps(trim(wdetail.branch))       /*wdetail.n_branch */ /* nv_branch  */                        
  sic_bran.uwm100.dept   = nv_dept                    
  sic_bran.uwm100.usrid  = USERID(LDBNAME(1))         
  /*sic_bran.uwm100.fstdat = TODAY  */                /*TODAY *//*kridtiya i. a53-0171*/
  sic_bran.uwm100.fstdat = DATE(wdetail.comdat)       /*kridtiya i. a53-0171 ��� firstdate=comdate */
  sic_bran.uwm100.comdat = DATE(wdetail.comdat)       
  sic_bran.uwm100.expdat = date(wdetail.expdat)       
  sic_bran.uwm100.accdat = nv_accdat                  
  sic_bran.uwm100.tranty = "N"                        /*Transaction Type (N/R/E/C/T)*/
  sic_bran.uwm100.langug = "T"
  sic_bran.uwm100.acctim = "00:00"
  sic_bran.uwm100.trty11 = "M"      
  sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")     
  sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")
  sic_bran.uwm100.entdat = TODAY
  sic_bran.uwm100.curbil = "BHT"
  sic_bran.uwm100.curate = 1
  sic_bran.uwm100.instot = 1
  sic_bran.uwm100.prog   = "wgwtcgen"
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
  sic_bran.uwm100.finint = wdetail.deler           /*code deler */
  sic_bran.uwm100.dealer = wdetail.financecd              /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)    /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)     /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.postcd     = trim(wdetail.postcd)       /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.icno       = trim(n_icno)               /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)      /*Add by Kridtiya i. A63-0472*/ 
  sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)    /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)    /*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)    /*Add by Kridtiya i. A63-0472*/
  /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*//*Add by Kridtiya i. A63-0472*/
  sic_bran.uwm100.campaign   = trim(wdetail.producer).    /*trim(wdetail.campaign_ov).*/  /*Add by Kridtiya i. A63-0472*/ 
        /*sic_bran.uwm100.cr_1   = IF ((INDEX(wdetail.brand,"Ford") <> 0)   AND 
                                    (deci(wdetail.caryear) = YEAR(TODAY)) AND
                                    (INDEX(wdetail.remark,"FD ENSURE") <> 0)) THEN fi_product ELSE ""
        sic_bran.uwm100.opnpol = IF ((INDEX(wdetail.brand,"Ford") <> 0)   AND 
                                    (deci(wdetail.caryear) = YEAR(TODAY)) AND
                                    (INDEX(wdetail.remark,"FD ENSURE") <> 0)) THEN fi_prom ELSE ""*/
        /*sic_bran.uwm100.bs_cd   = wdetail.typrequest */ /*add ���� Vatcode */
        /* sic_bran.uwm100.opnpol  = CAPS(wdetail.ins_pay) */ 
        /*sic_bran.uwm100.endern  = date(wdetail.ac_date)*/ 
        /* comment by A60-0095............ 
        sic_bran.uwm100.cr_1   = IF fi_chkpro = "" THEN ""
                                 ELSE IF trim(wdetail.producer) = TRIM(fi_chkpro)  THEN fi_product
                                 ELSE IF trim(wdetail.producer) = TRIM(fi_chkpro2) THEN fi_product2
                                 ELSE ""
        sic_bran.uwm100.opnpol = IF fi_chkpro = "" THEN ""
                                 ELSE IF trim(wdetail.producer) = TRIM(fi_chkpro)  THEN fi_prom
                                 ELSE IF trim(wdetail.producer) = TRIM(fi_chkpro2) THEN fi_prom2
                                 ELSE "" .  /*add kridtiya i. A53-0171 �����ѹ����Ѻ�Թ*/
       .............end : A60-0095.............*/
  /* Create by : A60-0095 �� product �Ѻ Promotion */
  FIND LAST tbprotis  WHERE tbprotis.producer = trim(wdetail.producer) NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL tbprotis THEN DO:
    /* IF wdetail.producer <> "B3M0044"  THEN DO: /*A61-0313*/ */ /*A62-0386*/
      /*IF wdetail.producer <> "A0M2012"  THEN DO:  /*A62-0386*/*/ /*A64-0092 */
      IF wdetail.producer <> "A0M2012" OR wdetail.producer <> "B3MLTIS104"  THEN DO:   /*A64-0092 */
          ASSIGN sic_bran.uwm100.cr_1   = TRIM(tbprotis.product)     /*product*/  
              sic_bran.uwm100.opnpol = TRIM(tbprotis.promo) .     /*promo */ 
      END.
      /* create A61-0313*/
      ELSE DO: 
          /*IF index(wdetail.remark,"MPI") <> 0  OR SUBSTR(wdetail.prepol,7,2) = "MI" THEN DO:*/ /*A63-0210 Sarinya C 03/09/2020*/
          IF index(wdetail.remark,"MPI") <> 0  /*OR SUBSTR(wdetail.prepol,7,2) = "MI"*/ THEN DO:
              ASSIGN sic_bran.uwm100.cr_1   = TRIM(tbprotis.product)     /*product*/  
                  sic_bran.uwm100.opnpol     = TRIM(tbprotis.promo) .     /*promo */ 
          END.
          ELSE ASSIGN sic_bran.uwm100.cr_1   = ""      /*product*/  
              sic_bran.uwm100.opnpol = "" .     /*promo */ 
      END. /* End A61-0313*/
  END.
  ELSE DO:
      ASSIGN sic_bran.uwm100.cr_1   = ""
          sic_bran.uwm100.opnpol = "" .
  END.
  /* end : A60-0095 */
  IF wdetail.prepol <> " " THEN DO:
      IF wdetail.poltyp = "v72"  THEN ASSIGN sic_bran.uwm100.prvpol  = ""
          sic_bran.uwm100.tranty  = "R".  
      ELSE 
          ASSIGN  sic_bran.uwm100.prvpol  = wdetail.prepol /*����繧ҹ Renew  ��ͧ����繤����ҧ*/
              sic_bran.uwm100.tranty  = "R".               /*Transaction Type (N/R/E/C/T)*/
  END.
  IF wdetail.pass = "Y" THEN sic_bran.uwm100.impflg  = YES.
  ELSE sic_bran.uwm100.impflg  = NO.
  IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
  IF wdetail.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
  ELSE  sic_bran.uwm100.polsta = "IF".
  IF fi_loaddat <> ? THEN  sic_bran.uwm100.trndat = fi_loaddat.
  ELSE  sic_bran.uwm100.trndat = TODAY.
  sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
  nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                    (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat.  
END.   /*transaction*//**/
RUN proc_uwd100.
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
..end A64-0138...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_protis c-Win 
PROCEDURE proc_protis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH brstat.insure USE-INDEX insure03 WHERE brstat.insure.compno  = trim(fi_chkpro) AND  /*PRO_TIS*/
                                                brstat.insure.insno   = trim(fi_chkpro) NO-LOCK.
            
                CREATE tbprotis .
                ASSIGN tbprotis.producer = brstat.insure.icaddr2
                       tbprotis.product  = TRIM(brstat.insure.text1)     /*product*/  
                       tbprotis.promo    = TRIM(brstat.insure.text2)     /*promo */  
                       tbprotis.cover    = trim(insure.vatcode) . /*A67-0087  cover*/
           
END.
OPEN QUERY br_protis FOR EACH tbprotis.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_province c-Win 
PROCEDURE proc_province :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A60-0095       
------------------------------------------------------------------------------*/
/*1*/        IF wdetail.re_country = "ANG THONG"          THEN wdetail.re_country = "ͷ".
/*2*/   ELSE IF wdetail.re_country = "AYUTTHAYA"          THEN wdetail.re_country = "��".
/*3*/   ELSE IF wdetail.re_country = "BKK"                THEN wdetail.re_country = "��". 
/*3*/   ELSE IF wdetail.re_country = "BANGKOK"            THEN wdetail.re_country = "��".
/*4*/   ELSE IF wdetail.re_country = "BURIRAM"            THEN wdetail.re_country = "��".
/*5*/   ELSE IF wdetail.re_country = "CHAI NAT"           THEN wdetail.re_country = "��".
/*6*/   ELSE IF wdetail.re_country = "CHANTHABURI"        THEN wdetail.re_country = "��".
/*7*/   ELSE IF wdetail.re_country = "CHIANG MAI"         THEN wdetail.re_country = "��".
/*8*/   ELSE IF wdetail.re_country = "CHONBURI"           THEN wdetail.re_country = "��".
/*9*/   ELSE IF wdetail.re_country = "KALASIN"            THEN wdetail.re_country = "��".
/*10*/  ELSE IF wdetail.re_country = "KANCHANABURI"       THEN wdetail.re_country = "��".
/*11*/  ELSE IF wdetail.re_country = "KHON KAEN"          THEN wdetail.re_country = "��".
/*12*/  ELSE IF wdetail.re_country = "KRABI"              THEN wdetail.re_country = "��".
/*13*/  ELSE IF wdetail.re_country = "LOPBURI"            THEN wdetail.re_country = "ź".
/*14*/  ELSE IF wdetail.re_country = "NAKHON NAYOK"       THEN wdetail.re_country = "��".
/*15*/  ELSE IF wdetail.re_country = "NAKHON PATHOM"      THEN wdetail.re_country = "��".
/*16*/  ELSE IF wdetail.re_country = "NAKHON RATCHASIMA"  THEN wdetail.re_country = "��".
/*17*/  ELSE IF wdetail.re_country = "NAKHON SITHAMMARAT" THEN wdetail.re_country = "��".
/*18*/  ELSE IF wdetail.re_country = "NONTHABURI"         THEN wdetail.re_country = "��".
/*19*/  ELSE IF wdetail.re_country = "PHETCHABURI"        THEN wdetail.re_country = "��".
/*20*/  ELSE IF wdetail.re_country = "PHUKET"             THEN wdetail.re_country = "��".
/*21*/  ELSE IF wdetail.re_country = "PHITSANULOK"        THEN wdetail.re_country = "��".
/*22*/  ELSE IF wdetail.re_country = "PRACHINBURI"        THEN wdetail.re_country = "��".
/*23*/  ELSE IF wdetail.re_country = "RATCHABURI"         THEN wdetail.re_country = "ú".
/*24*/  ELSE IF wdetail.re_country = "RAYONG"             THEN wdetail.re_country = "��".
/*25*/  ELSE IF wdetail.re_country = "ROI ET"             THEN wdetail.re_country = "��".
/*26*/  ELSE IF wdetail.re_country = "SARABURI"           THEN wdetail.re_country = "ʺ".
/*27*/  ELSE IF wdetail.re_country = "SRISAKET"           THEN wdetail.re_country = "ȡ".
/*28*/  ELSE IF wdetail.re_country = "SONGKHLA"           THEN wdetail.re_country = "ʢ".
/*29*/  ELSE IF wdetail.re_country = "SA KAEO"            THEN wdetail.re_country = "ʡ".
/*30*/  ELSE IF wdetail.re_country = "SUPHANBURI"         THEN wdetail.re_country = "ʾ".
/*/*31*/  ELSE IF wdetail.re_country = "SURAT THANI"        THEN wdetail.re_country = "ʯ". A63-0210*/
/*31*/  ELSE IF wdetail.re_country = "SURAT THANI"        THEN wdetail.re_country = "ʮ".
/*32*/  ELSE IF wdetail.re_country = "TRANG"              THEN wdetail.re_country = "��".
/*33*/  ELSE IF wdetail.re_country = "UBON RATCHATHANI"   THEN wdetail.re_country = "ͺ".
/*34*/  ELSE IF wdetail.re_country = "UDON THANI"         THEN wdetail.re_country = "ʹ".
/*35*/  ELSE IF wdetail.re_country = "AMNAT CHAROEN"      THEN wdetail.re_country = "ͨ".
/*36*/  ELSE IF wdetail.re_country = "CHAIYAPHUM"         THEN wdetail.re_country = "��".
/*37*/  ELSE IF wdetail.re_country = "CHIANG RAI"         THEN wdetail.re_country = "��".
/*38*/  ELSE IF wdetail.re_country = "CHUMPHON"           THEN wdetail.re_country = "��".
/*39*/  ELSE IF wdetail.re_country = "KAMPHAENG PHET"     THEN wdetail.re_country = "��".
/*40*/  ELSE IF wdetail.re_country = "LAMPANG"            THEN wdetail.re_country = "Ż".
/*41*/  ELSE IF wdetail.re_country = "LAMPHUN"            THEN wdetail.re_country = "ž".
/*42*/  ELSE IF wdetail.re_country = "NAKHON SAWAN"       THEN wdetail.re_country = "��".
/*43*/  ELSE IF wdetail.re_country = "NONG KHAI"          THEN wdetail.re_country = "��".
/*44*/  ELSE IF wdetail.re_country = "PATHUM THANI"       THEN wdetail.re_country = "��".
/*45*/  ELSE IF wdetail.re_country = "PATTANI"            THEN wdetail.re_country = "��".
/*46*/  ELSE IF wdetail.re_country = "PHATTHALUNG"        THEN wdetail.re_country = "��".
/*47*/  ELSE IF wdetail.re_country = "PHETCHABUN"         THEN wdetail.re_country = "��".
/*48*/  ELSE IF wdetail.re_country = "SAKON NAKHON"       THEN wdetail.re_country = "ʹ".
/*49*/  ELSE IF wdetail.re_country = "SING BURI"          THEN wdetail.re_country = "��".
/*50*/  ELSE IF wdetail.re_country = "SURIN"              THEN wdetail.re_country = "��".
/*51*/  ELSE IF wdetail.re_country = "YASOTHON"           THEN wdetail.re_country = "��".
/*52*/  ELSE IF wdetail.re_country = "YALA"               THEN wdetail.re_country = "��".
/*53*/  ELSE IF wdetail.re_country = "BAYTONG"            THEN wdetail.re_country = "��".
/*54*/  ELSE IF wdetail.re_country = "CHACHOENGSAO"       THEN wdetail.re_country = "��".
/*55*/  ELSE IF wdetail.re_country = "LOEI"               THEN wdetail.re_country = "��".
/*56*/  ELSE IF wdetail.re_country = "MAE HONG SON"       THEN wdetail.re_country = "��".
/*57*/  ELSE IF wdetail.re_country = "MAHA SARAKHAM"      THEN wdetail.re_country = "��".
/*58*/  ELSE IF wdetail.re_country = "MUKDAHAN"           THEN wdetail.re_country = "��".
/*59*/  ELSE IF wdetail.re_country = "NAN"                THEN wdetail.re_country = "��".
/*60*/  ELSE IF wdetail.re_country = "NARATHIWAT"         THEN wdetail.re_country = "��".
/*61*/  ELSE IF wdetail.re_country = "NONG BUA LAMPHU"    THEN wdetail.re_country = "��".
/*62*/  ELSE IF wdetail.re_country = "PHAYAO"             THEN wdetail.re_country = "��".  
/*63*/  ELSE IF wdetail.re_country = "PHANG NGA"          THEN wdetail.re_country = "��".
/*64*/  ELSE IF wdetail.re_country = "PHRAE"              THEN wdetail.re_country = "��".
/*65*/  ELSE IF wdetail.re_country = "PHICHIT"            THEN wdetail.re_country = "��".
/*66*/  ELSE IF wdetail.re_country = "PRACHUAP KHIRIKHAN" THEN wdetail.re_country = "��".
/*67*/  ELSE IF wdetail.re_country = "RANONG"             THEN wdetail.re_country = "ù".
/*68*/  ELSE IF wdetail.re_country = "SAMUT PRAKAN"       THEN wdetail.re_country = "ʻ".
/*69*/  ELSE IF wdetail.re_country = "SAMUT SAKHON"       THEN wdetail.re_country = "ʤ". 
/*70*/  ELSE IF wdetail.re_country = "SAMUT SONGKHRAM"    THEN wdetail.re_country = "��".
/*71*/  ELSE IF wdetail.re_country = "SATUN"              THEN wdetail.re_country = "ʵ".
/*72*/  ELSE IF wdetail.re_country = "SUKHOTHAI"          THEN wdetail.re_country = "ʷ".
/*73*/  ELSE IF wdetail.re_country = "TAK"                THEN wdetail.re_country = "��".
/*74*/  ELSE IF wdetail.re_country = "TRAT"               THEN wdetail.re_country = "��".
/*75*/  ELSE IF wdetail.re_country = "UTHAI THANI"        THEN wdetail.re_country = "͹".
/*76*/  ELSE IF wdetail.re_country = "UTTARADIT"          THEN wdetail.re_country = "͵".
/*77*/  ELSE IF wdetail.re_country = "NAKHON PHANOM"      THEN wdetail.re_country = "��". 
/*78*/  ELSE IF wdetail.re_country = "BUENG KAN"          THEN wdetail.re_country = "��". 
        ELSE wdetail.re_country = " ". 

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
/*RUN proc_renew_veh.*/

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
/*ASSIGN 
    wdetail.agent    = fi_agent  
    wdetail.producer = fi_producer .*/
/*wdetail.vehreg    = wdetail.vehreg + " " + wdetail.re_country. */
FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail.prepol   No-lock No-error no-wait.
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
        ASSIGN  wdetail.prepol = sicuw.uwm100.policy
            n_rencnt  =  sicuw.uwm100.rencnt  +  1
            n_endcnt  =  0
            wdetail.pass  = "Y".
        IF wdetail.poltyp = "v72" THEN RUN proc_assignrenew72.
        ELSE RUN proc_assignrenew.      /*�Ѻ��� ����������ͧ�ͧ��� */
    END.
END.   /*  avail  uwm100  */
Else do:  
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0
        wdetail.prepol   = ""
        wdetail.comment = wdetail.comment + "| �繡������������بҡ����ѷ���  ".
    /*IF (wdetail.prempa = "" ) OR (wdetail.subclass = "" )   THEN DO:
        FIND FIRST brstat.tlt USE-INDEX tlt06   WHERE
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
            IF tlt.expotim  = "" THEN MESSAGE "��辺ᾤࡨ�ͧ�Ţ��Ƕѧ���:" wdetail.chasno VIEW-AS ALERT-BOX .
        END.
    END.*/
END.   /*not  avail uwm100*/
IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".

/*END.  /* sicuw.uwm301 */
ELSE DO:
    ASSIGN wdetail.comment = wdetail.comment + "| ��辺�Ţ��Ƕѧ㹡�õ������ " 
           wdetail.OK_GEN  = "N"
           wdetail.pass     = "N".

END.*/
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
/*1*/   IF wdetail.re_country = "65"    THEN wdetail.re_country = "��".
/*2*/   IF wdetail.re_country = "01"    THEN wdetail.re_country = "��".
/*3*/   IF wdetail.re_country = "25"    THEN wdetail.re_country = "��".
/*4*/   IF wdetail.re_country = "40"    THEN wdetail.re_country = "��".
/*5*/   IF wdetail.re_country = "68"    THEN wdetail.re_country = "��".
/*6*/   IF wdetail.re_country = "15"    THEN wdetail.re_country = "��".
/*7*/   IF wdetail.re_country = "37"    THEN wdetail.re_country = "��".
/*8*/   IF wdetail.re_country = "11"    THEN wdetail.re_country = "��".
/*9*/   IF wdetail.re_country = "05"    THEN wdetail.re_country = "��".
/*10*/  IF wdetail.re_country = "44"    THEN wdetail.re_country = "��".
/*11*/  IF wdetail.re_country = "46"    THEN wdetail.re_country = "��".
/*12*/  IF wdetail.re_country = "64"    THEN wdetail.re_country = "��".
/*13*/  IF wdetail.re_country = "73"    THEN wdetail.re_country = "��".
/*14*/  IF wdetail.re_country = "75"    THEN wdetail.re_country = "��".
/*15*/  IF wdetail.re_country = "14"    THEN wdetail.re_country = "��".
/*16*/  IF wdetail.re_country = "49"    THEN wdetail.re_country = "��".
/*17*/  IF wdetail.re_country = "62"    THEN wdetail.re_country = "��".
/*18*/  IF wdetail.re_country = "50"    THEN wdetail.re_country = "��".
/*19*/  IF wdetail.re_country = "08"    THEN wdetail.re_country = "��".
/*20*/  IF wdetail.re_country = "30"    THEN wdetail.re_country = "��".
/*21*/  IF wdetail.re_country = "42"    THEN wdetail.re_country = "��".
/*22*/  IF wdetail.re_country = "38"    THEN wdetail.re_country = "��".
/*23*/  IF wdetail.re_country = "53"    THEN wdetail.re_country = "��".
/*24*/  IF wdetail.re_country = "02"    THEN wdetail.re_country = "��".
/*25*/  IF wdetail.re_country = "19"    THEN wdetail.re_country = "��".
/*26*/  IF wdetail.re_country = "72"    THEN wdetail.re_country = "��".
/*27*/  IF wdetail.re_country = "47"    THEN wdetail.re_country = "��".
/*28*/  IF wdetail.re_country = "06"    THEN wdetail.re_country = "��".
/*29*/  IF wdetail.re_country = "26"    THEN wdetail.re_country = "��".
/*30*/  IF wdetail.re_country = "13"    THEN wdetail.re_country = "��".
/*31*/  IF wdetail.re_country = "21"    THEN wdetail.re_country = "��".
/*32*/  IF wdetail.re_country = "55"    THEN wdetail.re_country = "��".
/*33*/  IF wdetail.re_country = "74"    THEN wdetail.re_country = "��".
/*34*/  IF wdetail.re_country = "63"    THEN wdetail.re_country = "��".
/*35*/  IF wdetail.re_country = "12"    THEN wdetail.re_country = "��".
/*36*/  IF wdetail.re_country = "60"    THEN wdetail.re_country = "��".
/*37*/  IF wdetail.re_country = "54"    THEN wdetail.re_country = "��".
/*38*/  IF wdetail.re_country = "24"    THEN wdetail.re_country = "��".
/*39*/  IF wdetail.re_country = "70"    THEN wdetail.re_country = "��".
/*40*/  IF wdetail.re_country = "71"    THEN wdetail.re_country = "��".
/*41*/  IF wdetail.re_country = "66"    THEN wdetail.re_country = "��".
/*42*/  IF wdetail.re_country = "32"    THEN wdetail.re_country = "��".
/*43*/  IF wdetail.re_country = "23"    THEN wdetail.re_country = "��".
/*44*/  IF wdetail.re_country = "76"    THEN wdetail.re_country = "��".
/*45*/  IF wdetail.re_country = "20"    THEN wdetail.re_country = "��".
/*46*/  IF wdetail.re_country = "35"    THEN wdetail.re_country = "��".
/*47*/  IF wdetail.re_country = "67"    THEN wdetail.re_country = "ù".
/*48*/  IF wdetail.re_country = "16"    THEN wdetail.re_country = "��".
/*49*/  IF wdetail.re_country = "10"    THEN wdetail.re_country = "ú".
/*50*/  IF wdetail.re_country = "58"    THEN wdetail.re_country = "ź".
/*51*/  IF wdetail.re_country = "61"    THEN wdetail.re_country = "Ż".
/*52*/  IF wdetail.re_country = "41"    THEN wdetail.re_country = "ž".
/*53*/  IF wdetail.re_country = "43"    THEN wdetail.re_country = "��".
/*54*/  IF wdetail.re_country = "18"    THEN wdetail.re_country = "ȡ".
/*55*/  IF wdetail.re_country = "29"    THEN wdetail.re_country = "ʹ".
/*56*/  IF wdetail.re_country = "09"    THEN wdetail.re_country = "ʢ".
/*57*/  IF wdetail.re_country = "57"    THEN wdetail.re_country = "ʡ".
/*58*/  IF wdetail.re_country = "52"    THEN wdetail.re_country = "ʺ".
/*59*/  IF wdetail.re_country = "51"    THEN wdetail.re_country = "��".
/*60*/  IF wdetail.re_country = "48"    THEN wdetail.re_country = "ʷ".
/*61*/  IF wdetail.re_country = "22"    THEN wdetail.re_country = "ʾ".
/*62*/  IF (wdetail.re_country = "33") OR (wdetail.re_country = "84") THEN wdetail.re_country = "ʮ".
/*63*/  IF wdetail.re_country = "34"    THEN wdetail.re_country = "��".
/*64*/  IF wdetail.re_country = "36"    THEN wdetail.re_country = "��".
/*65*/  IF wdetail.re_country = "39"    THEN wdetail.re_country = "��".
/*66*/  IF wdetail.re_country = "56"    THEN wdetail.re_country = "ͷ".
/*67*/  IF wdetail.re_country = "69"    THEN wdetail.re_country = "ͨ".
/*68*/  IF wdetail.re_country = "28"    THEN wdetail.re_country = "ʹ".
/*69*/  IF wdetail.re_country = "59"    THEN wdetail.re_country = "͵".
/*70*/  IF wdetail.re_country = "45"    THEN wdetail.re_country = "ͷ".
/*71*/  IF wdetail.re_country = "04"    THEN wdetail.re_country = "ͺ".
/*72*/  IF wdetail.re_country = "17"    THEN wdetail.re_country = "��".
/*73*/  IF wdetail.re_country = "27"    THEN wdetail.re_country = "ʵ".
/*74*/  IF wdetail.re_country = "03"    THEN wdetail.re_country = "ʻ".
/*75*/  IF wdetail.re_country = "31"    THEN wdetail.re_country = "��".
/*76*/  IF wdetail.re_country = "07"    THEN wdetail.re_country = "ʤ".
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
    "comp_prm   "  ","  /*A67-0185*/  
    "subclass   "  ","  /*A67-0185*/  
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
        wdetail.deduct        ","   
        /*wdetail.tpfire        ","  */ 
        wdetail.compul        ","
        wdetail.comp_prm      ","  /*A67-0185*/  
        wdetail.subclass      ","  /*A67-0185*/  
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
    "comp_prm   "     ","  /*A67-0185*/
    "subclass   "     ","  /*A67-0185*/
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
            wdetail.deduct        ","   
            wdetail.compul        "," 
            wdetail.comp_prm      ","  /*A67-0185*/
            wdetail.subclass      ","  /*A67-0185*/
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
      
      CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.  /*pd*/
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. *//*Comment A62-0105*/
      /*-CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.-*/
    /* CONNECT expiry -H devserver -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/
      
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
    nv_idnolist    = IF index(wdetail.not_office," ���ʼ����:") <> 0 THEN trim(SUBSTR(wdetail.not_office,index(wdetail.not_office," ���ʼ����:") + 13 )) 
                     ELSE "".
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
  Notes: Add by : A65-0035       
------------------------------------------------------------------------------*/
/* comment by : A65-0035...
DEF VAR n_cover AS CHAR FORMAT "X(3)" . /*A64-0092*/
/*create  text (F17) for Query claim....*/
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF VAR nv_bptr      AS RECID.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
/* create by : A64-0092 */
/*create  text (F17) for Query claim....*/
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    n_cover  = ""
    n_cover  = IF index(wdetail.covcod,".") <> 0 THEN TRIM(SUBSTR(wdetail.covcod,1,1) + "+" ) ELSE TRIM(wdetail.covcod)  .

IF wdetail.acc = ""  THEN DO:
    FIND LAST stat.insure USE-INDEX insure01 WHERE 
               stat.insure.compno  = TRIM(fi_textf17)        AND
               stat.Insure.insno   = TRIM(wdetail.producer)  AND 
               stat.Insure.vatcode = TRIM(n_cover)  AND 
               stat.insure.branch  = "F7" NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN DO:
               ASSIGN nv_txt2 = Trim(stat.insure.Fname) .
            END.
            ELSE ASSIGN nv_txt2 = "" .
END.
ELSE DO:
    IF LENGTH(wdetail.acc) <= 110 THEN ASSIGN  nv_txt2 = TRIM(wdetail.acc) .
    ELSE IF LENGTH(wdetail.acc) >  110 THEN DO:
        ASSIGN  nv_txt2 = SUBSTR(wdetail.acc,1,110)
                nv_txt3 = SUBSTR(wdetail.acc,101,110)
                nv_txt4 = SUBSTR(wdetail.acc,211,110).
    END.
END.
    
DO WHILE nv_line1 <= 4:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    /*IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.*/ 
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2. 
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3. 
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.  
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
END.     /*uwm100*/ 
/* end A64-0092 */
..end A65-0035....*/
/*--- create by : A65-0035....*/
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
    DEF VAR nv_bptr      AS RECID.
    DEF VAR nv_fptr      AS RECID.
    FOR EACH wuppertxt.
        DELETE wuppertxt.
    END.
    ASSIGN 
        nv_bptr  = 0
        nv_line1 = 1 .
       
    DO WHILE nv_line1 <= 10:
        CREATE wuppertxt.
        wuppertxt.line = nv_line1.
        IF nv_line1 = 2  THEN wuppertxt.txt  = SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   .
        IF nv_line1 = 3  THEN wuppertxt.txt  = SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  .
        IF nv_line1 = 4  THEN wuppertxt.txt  = SUBSTRING(sic_bran.uwm301.prmtxt,121,60) .
        IF nv_line1 = 5  THEN wuppertxt.txt  = SUBSTRING(sic_bran.uwm301.prmtxt,181,60) .
        IF nv_line1 = 6  THEN wuppertxt.txt  = SUBSTRING(sic_bran.uwm301.prmtxt,241,60) .
        IF nv_line1 = 7  THEN wuppertxt.txt  = SUBSTRING(sic_bran.uwm301.prmtxt,301,60) .
        IF nv_line1 = 8  THEN wuppertxt.txt  = SUBSTRING(sic_bran.uwm301.prmtxt,361,60) .
        IF nv_line1 = 9  THEN wuppertxt.txt  = SUBSTRING(sic_bran.uwm301.prmtxt,421,60) .
        nv_line1 = nv_line1 + 1.
    END.

    FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
         sic_bran.uwm100.policy  = wdetail.policyno  AND
         sic_bran.uwm100.rencnt  = n_rencnt      AND
         sic_bran.uwm100.endcnt  = n_endcnt      AND
         sic_bran.uwm100.bchyr   = nv_batchyr    AND
         sic_bran.uwm100.bchno   = nv_batchno    AND
         sic_bran.uwm100.bchcnt  = nv_batcnt     NO-ERROR NO-WAIT.
    IF AVAILABLE uwm100 THEN DO:
        FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
            IF wuppertxt.txt <> "" THEN DO:  /*-- A58-0419 --*/
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
            END.  /*-- A58-0419 --*/
        END.
        RELEASE sic_bran.uwd100.
        sic_bran.uwm100.bptr01 = nv_bptr.
    END. /*uwm100*/
    RELEASE sic_bran.uwd100.
 /*...end A65-0035...*/
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
       nv_line1 = 1
       nv_txt2  = "" . /*A60-0225*/
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
/*---A60-0225----*/
FIND LAST  stat.insure USE-INDEX insure01 WHERE 
           stat.insure.compno       = TRIM(fi_textf17)        AND
           TRIM(stat.Insure.insno)  = TRIM(wdetail.producer)  AND 
           TRIM(stat.insure.branch) = "F8" NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL stat.insure THEN DO:
           /* ASSIGN nv_txt2 = Trim(stat.insure.Fname) + " " + trim(stat.insure.Lname) . */ /*A61-0410*/
            /* Create by : A61-0410 */
            /*IF TRIM(wdetail.producer) <> "B3M0044" THEN DO:*/
            IF TRIM(wdetail.producer) <> "B3M0044" AND TRIM(wdetail.producer) <> "A0M2012"  THEN DO: 
                ASSIGN nv_txt2 = Trim(stat.insure.Fname) + " " + trim(stat.insure.Lname) .
            END.
            ELSE DO:
                 IF index(wdetail.remark,"MPI") <> 0  OR SUBSTR(wdetail.prepol,7,2) = "MI" THEN DO:
                        ASSIGN nv_txt2 = Trim(stat.insure.Fname) + " " + trim(stat.insure.Lname) .
                 END.
                 ELSE ASSIGN nv_txt2 = "" .
            END.
            /* end A61-0410 */
        END.
        ELSE ASSIGN nv_txt2 = "" .
/*--- end : A60-0225----*/ 
/*DO WHILE nv_line1 <= 10:*/  /*A67-0087*/
DO WHILE nv_line1 <= 12:      /*A67-0087*/
    CREATE wuppertxt3.
    wuppertxt3.line = nv_line1.
   /* IF nv_line1 = 1  THEN wuppertxt3.txt = wdetail.not_office . */ /*A60-0225*/
   /* IF nv_line1 = 2  THEN wuppertxt3.txt = wdetail.entdat .     */ /*A60-0225*/
   /* IF nv_line1 = 3  THEN wuppertxt3.txt = "Notify time:" + wdetail.enttim   .*/
    IF nv_line1 = 2  THEN wuppertxt3.txt = wdetail.not_office .  /*A60-0225*/   
    IF nv_line1 = 3  THEN wuppertxt3.txt = SUBSTR(wdetail.entdat,1,INDEX(wdetail.entdat,"Number") - 9) .  /*A60-0225*/   
    IF nv_line1 = 4  THEN wuppertxt3.txt = SUBSTR(wdetail.entdat,R-INDEX(wdetail.entdat,"Notify")).        /*A60-0225*/
    IF nv_line1 = 5  THEN wuppertxt3.txt = nv_txt2.   /*A60-0225*/
    /*IF nv_line1 = 6  THEN wuppertxt3.txt = wdetail.remark  .*/  /*A60-0118*/
    /*--A60-0118--*/
    IF nv_line1 = 6  THEN wuppertxt3.txt = IF index(wdetail.remark,"ISP") <> 0 THEN SUBSTR(wdetail.remark,1,INDEX(wdetail.remark,"ISP") - 1)
                                           ELSE TRIM(wdetail.remark) .
    IF nv_line1 = 7  THEN wuppertxt3.txt = IF index(wdetail.remark,"ISP") <> 0 THEN SUBSTR(wdetail.remark,INDEX(wdetail.remark,"ISP"),LENGTH(wdetail.remark))
                                           ELSE "".
    /* comment by : A67-0087 ..
    IF nv_line1 = 8  THEN wuppertxt3.txt = wdetail.acc.   /*A60-0225*/
    IF nv_line1 = 9  THEN wuppertxt3.txt = "��ö :" + wdetail.colorcode.  /*A65-0356*/ 
    end : A67-0087 */
    /* add by : A67-0087 ..*/
    IF nv_line1 = 8  THEN wuppertxt3.txt = "��ö :" + wdetail.colorcode. 
    IF nv_line1 = 9  THEN wuppertxt3.txt = "�����Ţ����ͧ¹�� 3 :" + wdetail.engno3 . 
    IF nv_line1 = 10  THEN wuppertxt3.txt = "�����Ţ����ͧ¹�� 4 :" + wdetail.engno4 . 
    IF nv_line1 = 11  THEN wuppertxt3.txt = "�����Ţ����ͧ¹�� 5 :" + wdetail.engno5 . 
    /* end : A67-0087 */
    /*--end A60-0118--*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd105 c-Win 
PROCEDURE proc_uwd105 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A65-0035      
------------------------------------------------------------------------------*/
DO:
    DEF BUFFER wf_uwd105 FOR sic_bran.uwd105.
    DEF VAR nv_bptr      AS RECID.
    DEF VAR nv_fptr      AS RECID.

    FOR EACH wuppertxt.
        DELETE wuppertxt.
    END.

    ASSIGN 
        nv_bptr  = 0
        nv_line1 = 1 .
    /* comment 20/04/2022..
    CREATE wuppertxt.
    ASSIGN 
        wuppertxt.line = 1
        wuppertxt.txt  = "MT001_PB".

    CREATE wuppertxt.
    ASSIGN 
        wuppertxt.line = 2
        wuppertxt.txt  = "MT002_FL".
    ....*/
    IF index(wdetail.remark,"FE2+") <> 0 THEN DO: 
        CREATE wuppertxt.
        ASSIGN 
            wuppertxt.line = 1
            wuppertxt.txt  = "MT001_PB".
        
        CREATE wuppertxt.
        ASSIGN 
            wuppertxt.line = 2
            wuppertxt.txt  = "MT002_FL".
    END.
    ELSE DO:
        CREATE wuppertxt.
        ASSIGN 
            wuppertxt.line = 1
            wuppertxt.txt  = "MT001_PB".
    END.
  
    FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
         sic_bran.uwm100.policy  = wdetail.policyno  AND
         sic_bran.uwm100.rencnt  = n_rencnt      AND
         sic_bran.uwm100.endcnt  = n_endcnt      AND
         sic_bran.uwm100.bchyr   = nv_batchyr    AND
         sic_bran.uwm100.bchno   = nv_batchno    AND
         sic_bran.uwm100.bchcnt  = nv_batcnt     NO-ERROR NO-WAIT.
    IF AVAILABLE uwm100 THEN DO:
        FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
            IF wuppertxt.txt <> "" THEN DO:  
                CREATE sic_bran.uwd105.
                ASSIGN
                    sic_bran.uwd105.bptr    = nv_bptr
                    sic_bran.uwd105.fptr    = 0 
                    sic_bran.uwd105.policy  = wdetail.policyno
                    sic_bran.uwd105.rencnt  = n_rencnt
                    sic_bran.uwd105.endcnt  = n_endcnt
                    sic_bran.uwd105.clause  = wuppertxt.txt.
                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd105 WHERE RECID(wf_uwd105) = nv_bptr.
                    wf_uwd105.fptr = RECID(uwd105).
                END.
                IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr03 = RECID(uwd105).
                nv_bptr = RECID(uwd105).
            END.  /*-- A58-0419 --*/
        END.
        RELEASE sic_bran.uwd105.
        sic_bran.uwm100.bptr03 = nv_bptr.
    END. /*uwm100*/
    RELEASE sic_bran.uwd105.
    
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

