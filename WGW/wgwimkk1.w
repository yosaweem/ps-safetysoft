&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
File: 
Description: 
Input Parameters:<none>
Output Parameters:<none>
Author: 
Created: ------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
/*++++++++++++++++++++++++++++++++++++++++++++++
program id   : wgwimkk1.w   [Import text file from  KK  to create  new policy Add in table tlt( brstat)]  
Program name : Import Text File KK
Create  by   : Kridtiya i.  [A54-0351]  date. 14/11/2011
copy program : wgwimkk1.w  
Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW (not connect: dbstat)
/*modify by  : Kridtiya i. A55-0029  ��������駢���������к�����������к� */
/*modify by  : Kridtiya i. A55-0240  ���� ����Ѻ��������˵بҡ��� �纤�� 50 ����ѡ�� ��Ѻ����� ������� 200 ����ѡ��*/
/*Modify By  : Ranu I. A60-0232 ��������红����ŷ������������ */
/*Modify by  : Ranu I. A61-0335 ��������红����Ū�ͧ KK App ��� Match file ¡��ԡ����������к� */
/*Modify by  : Kridtiya i. A63-00472 ���� Dealer code */
/*Modify by : Ranu I. A65-0288 20/10/2022 ��������红�������ö ��Т����š�õ�Ǩ��Ҿ */
/*Modify by : Ranu I. A67-0076 �������͹䢡���红�����ö俿�� */
/*Modify by : Ranu I. A67-0198 �������͹��礢����ŧҹ���� ����ᴧ */
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.  
DEFINE VAR nv_reccnt      AS INT  INIT  0.                                       
DEFINE VAR nv_completecnt AS INT  INIT  0.  
DEFINE VAR nv_error       AS INT  INIT  0.       /*add kridtiya i. A55-0029 */
/*--------------------------����Ѻ�����š�������  -------------------------*/
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD Notify_dat     AS CHAR FORMAT "X(10)"  INIT ""  /*  1  �ѹ����Ѻ��   */                        
    FIELD recive_dat     AS CHAR FORMAT "X(10)"  INIT ""  /*  2  �ѹ����Ѻ�Թ������»�Сѹ */            
    FIELD comp_code      AS CHAR FORMAT "X(50)"  INIT ""  /*  3  ��ª��ͺ���ѷ��Сѹ���  */                
    FIELD cedpol         AS CHAR FORMAT "X(20)"  INIT ""  /*  4  �Ţ����ѭ����ҫ��� */                    
    FIELD prepol         AS CHAR FORMAT "X(16)"  INIT ""  /*  5  �Ţ�������������  */                    
    FIELD cmbr_no        AS CHAR FORMAT "X(6)"   INIT ""  /*  6  �����Ң�    */                            
    FIELD cmbr_code      AS CHAR FORMAT "X(35)"  INIT ""  /*  7  �Ң� KK */                                
    FIELD notifyno       AS CHAR FORMAT "X(20)"  INIT ""  /*  8  �Ţ�Ѻ��� */                            
    FIELD campaigno      AS CHAR FORMAT "X(30)"  INIT ""  /*  9  Campaign    */                            
    FIELD campaigsub     AS CHAR FORMAT "X(30)"  INIT ""  /*  10 Sub Campaign    */                        
    FIELD typper         AS CHAR FORMAT "X(20)"  INIT ""  /*  11 �ؤ��/�ԵԺؤ�� */                        
    FIELD n_TITLE        AS CHAR FORMAT "X(20)"  INIT ""  /*  12 �ӹ�˹�Ҫ���    */                        
    FIELD n_name1        AS CHAR FORMAT "X(40)"  INIT ""  /*  13 ���ͼ����һ�Сѹ    */                    
    FIELD n_name2        AS CHAR FORMAT "X(40)"  INIT ""  /*  14 ���ʡ�ż����һ�Сѹ */                    
    FIELD ADD_no         AS CHAR FORMAT "X(10)"  INIT ""  /*  15 ��ҹ�Ţ���  */                            
    FIELD ADD_mu         AS CHAR FORMAT "X(3)"   INIT ""  /*  16 ����    */                                
    FIELD ADD_muban      AS CHAR FORMAT "X(30)"  INIT ""  /*  17 �����ҹ    */                            
    FIELD ADD_build      AS CHAR FORMAT "X(30)"  INIT ""  /*  18 �Ҥ��   */                                
    FIELD ADD_soy        AS CHAR FORMAT "X(30)"  INIT ""  /*  19 ��� */                                    
    FIELD ADD_road       AS CHAR FORMAT "X(30)"  INIT ""  /*  20 ��� */                                    
    FIELD ADD_thambon    AS CHAR FORMAT "X(30)"  INIT ""  /*  21 �Ӻ�/�ǧ   */                            
    FIELD ADD_amper      AS CHAR FORMAT "X(30)"  INIT ""  /*  22 �����/ࢵ   */                            
    FIELD ADD_country    AS CHAR FORMAT "X(30)"  INIT ""  /*  23 �ѧ��Ѵ */                                
    FIELD ADD_post       AS CHAR FORMAT "X(30)"  INIT ""  /*  24 ������ɳ���    */                        
    FIELD cover          AS CHAR FORMAT "X(20)"  INIT ""  /*  25 ����������������ͧ  */                    
    FIELD garage         AS CHAR FORMAT "X(20)"  INIT ""  /*  26 ��������ë���   */                        
    FIELD comdat         AS CHAR FORMAT "X(10)"  INIT ""  /*  27 �ѹ�����������ͧ    */                    
    FIELD expdat         AS CHAR FORMAT "X(10)"  INIT ""  /*  28 �ѹ����ش������ͧ  */                    
    FIELD subclass       AS CHAR FORMAT "X(20)"  INIT ""  /*  29 ����ö  */                                
    FIELD n_43           AS CHAR FORMAT "X(40)"  INIT ""  /*  30 ��������Сѹ���ö¹��   */                
    FIELD brand          AS CHAR FORMAT "X(20)"  INIT ""  /*  31 ����������ö    */                        
    FIELD model          AS CHAR FORMAT "X(50)"  INIT ""  /*  32 ���ö  */                                
    FIELD nSTATUS        AS CHAR FORMAT "X(10)"  INIT ""  /*  33 New/Used    */                            
    FIELD licence        AS CHAR FORMAT "X(45)"  INIT ""  /*  34 �Ţ����¹  */                            
    FIELD chassis        AS CHAR FORMAT "X(30)"  INIT ""  /*  35 �Ţ��Ƕѧ   */                            
    FIELD engine         AS CHAR FORMAT "X(30)"  INIT ""  /*  36 �Ţ����ͧ¹��  */                        
    FIELD cyear          AS CHAR FORMAT "X(10)"  INIT ""  /*  37 ��ö¹��    */                            
    FIELD power          AS CHAR FORMAT "X(10)"  INIT ""  /*  38 �ի�    */                                
    FIELD weight         AS CHAR FORMAT "X(10)"  INIT ""  /*  39 ���˹ѡ/�ѹ */                            
    FIELD ins_amt1       AS CHAR FORMAT "X(20)"  INIT ""  /*  40 �ع��Сѹ�� 1   */                        
    FIELD prem1          AS CHAR FORMAT "X(20)"  INIT ""  /*  41 ����������������ҡû� 1    */            
    FIELD ins_amt2       AS CHAR FORMAT "X(20)"  INIT ""  /*  42 �ع��Сѹ�� 2   */                        
    FIELD prem2          AS CHAR FORMAT "X(20)"  INIT ""  /*  43 ����������������ҡû� 2    */            
    FIELD time_notify    AS CHAR FORMAT "X(10)"  INIT ""  /*  44 �����Ѻ���    */                        
    FIELD NAME_mkt       AS CHAR FORMAT "X(50)"  INIT ""  /*  45 �������˹�ҷ�� MKT */                    
    FIELD bennam         AS CHAR FORMAT "X(200)"  INIT ""  /*  46 �����˵�    */    /* A55-0240 */                         
    FIELD drivno1        AS CHAR FORMAT "X(60)"  INIT ""  /*  47 ���Ѻ����� 1 �����ѹ�Դ  */            
    FIELD drivno2        AS CHAR FORMAT "X(60)"  INIT ""  /*  48 ���Ѻ����� 2 �����ѹ�Դ  */            
    FIELD reci_title     AS CHAR FORMAT "X(20)"  INIT ""  /*  49 �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)  */    
    FIELD reci_name1     AS CHAR FORMAT "X(40)"  INIT ""  /*  50 ���� (�����/㺡ӡѺ����)  */            
    FIELD reci_name2     AS CHAR FORMAT "X(40)"  INIT ""  /*  51 ���ʡ�� (�����/㺡ӡѺ����)   */        
    FIELD reci_addno     AS CHAR FORMAT "X(10)"  INIT ""  /*  52 ��ҹ�Ţ��� (�����/㺡ӡѺ����)    */    
    FIELD reci_addmu     AS CHAR FORMAT "X(5)"   INIT ""  /*  53 �����ҹ (�����/㺡ӡѺ����)  */        
    FIELD reci_addbuild  AS CHAR FORMAT "X(35)"  INIT ""  /*  54 �Ҥ�� (�����/㺡ӡѺ����) */            
    FIELD reci_addsoy    AS CHAR FORMAT "X(35)"  INIT ""  /*  55 ��� (�����/㺡ӡѺ����)   */            
    FIELD reci_addroad   AS CHAR FORMAT "X(35)"  INIT ""  /*  56 ��� (�����/㺡ӡѺ����)   */            
    FIELD reci_addtambon AS CHAR FORMAT "X(35)"  INIT ""  /*  57 �Ӻ�/�ǧ (�����/㺡ӡѺ����) */        
    FIELD reci_addamper  AS CHAR FORMAT "X(35)"  INIT ""  /*  58 �����/ࢵ (�����/㺡ӡѺ����) */        
    FIELD reci_addcounty AS CHAR FORMAT "X(35)"  INIT ""  /*  59 �ѧ��Ѵ (�����/㺡ӡѺ����)   */        
    FIELD reci_addpost   AS CHAR FORMAT "X(10)"  INIT ""  /*  60 ������ɳ��� (�����/㺡ӡѺ����)  */    
    FIELD ncb            AS CHAR FORMAT "X(10)"  INIT ""  /*  61 ��ǹŴ����ѵԴ�  */                          
    FIELD fleet          AS CHAR FORMAT "X(10)"  INIT "" /*  62  ��ǹŴ�ҹ Fleet */
    /* create by : A60-0232*/
    FIELD fi             AS CHAR FORMAT "x(15)"  INIT "" 
    field tel            as char format "x(15)" init ""  /*����Դ���                 */ 
    field icno           as char format "x(15)" init ""  /*�Ţ���ѵû�ЪҪ�           */ 
    field bdate          as char format "x(15)" init ""  /*�ѹ��͹���Դ              */ 
    field occup          as char format "x(45)" init ""  /*�Ҫվ                       */ 
    field cstatus        as char format "x(20)" init ""  /*ʶҹ�Ҿ                     */ 
    field taxno          as char format "x(15)" init ""  /*�Ţ��Шӵ�Ǽ�����������ҡ�  */ 
    field tname1         as char format "x(20)" init ""  /*�ӹ�˹�Ҫ��� 1              */ 
    field name1          as char format "x(50)" init ""  /*���͡������ 1               */ 
    field lname1         as char format "x(50)" init ""  /*���ʡ�š������ 1            */ 
    field icno1          as char format "x(15)" init ""  /*�Ţ���ѵû�ЪҪ�������� 1  */ 
    field tname2         as char format "x(20)" init ""  /*�ӹ�˹�Ҫ��� 2              */ 
    field name2          as char format "x(50)" init ""  /*���͡������ 2               */ 
    field lname2         as char format "x(50)" init ""  /*���ʡ�š������ 2            */ 
    field icno2          as char format "x(15)" init ""  /*�Ţ���ѵû�ЪҪ�������� 2  */ 
    field tname3         as char format "x(20)" init ""  /*�ӹ�˹�Ҫ��� 3              */ 
    field name3          as char format "x(50)" init ""  /*���͡������ 3               */ 
    field lname3         as char format "x(50)" init ""  /*���ʡ�š������ 3            */ 
    field icno3          as char format "x(15)" init ""  /*�Ţ���ѵû�ЪҪ�������� 3  */ 
    /*end A60-0232 */
    /* a61-0335 */
    field postsend      as char format "X(100)" init ""
    field sendname      as char format "X(100)" init ""
    field benname       as char format "X(100)" init ""
    FIELD remark         AS CHAR FORMAT "x(250)" INIT ""  /* �˵ؼš��¡��ԡ */  /*A61-0335*/
    FIELD remark1        AS CHAR FORMAT "x(250)" INIT ""  /* �����˵� */  /*A61-0335*/
    FIELD wht            AS CHAR FORMAT "x(30)"  INIT ""  /* kk app */  /*A61-0335*/
    FIELD kkapp          AS CHAR FORMAT "x(30)"  INIT ""  /* kk app */  /*A61-0335*/
    /* a61-0335 */
    FIELD dealer         AS CHAR FORMAT "x(30)"  INIT ""  /* kk app */  /*A61-0335*/
/*---Begin by Chaiyong W. A64-0135 03/04/2021*/
    field sdate           as char init ""       
    field uniqsource      as char init ""       
    field quo             as char init ""       
    field offerf          as char init ""       
    field kkst            as char init ""       
    field trndat          as char init ""       
    field appdat          as char init ""       
    field insapp          as char init ""       
    field insquo          as char init ""       
    field poltyp          as char init ""       
    field mapp            as char init ""       
    field rid             as char init ""       
    field product         as char init ""       
    field pack            as char init ""       
    field packnme         as char init ""       
    field buagent         as char init ""       
    field payidtyp        as char init ""       
    field paytyp          as char init ""           
    field projnme         as char init ""       
    field reci_address    as char init ""       
    field floor           as char init ""       
    field room            as char init ""       
    field reci_addcty     as char init ""       
    field cifno           as char init ""              
    field instyp          as char init ""         
    field age             as char init ""       
    field gender          as char init ""       
    field nat             as char init ""           
    field tel1            as char init ""       
    field tel2            as char init ""       
    field tel3            as char init ""       
    field email           as char init ""          
    field insbus          as char init ""       
    field TAddress        as char init ""       
    field TAddressNo      as char init ""       
    field TMoo            as char init ""       
    field TVillageBuilding as char init ""       
    field TFloor          as char init ""       
    field TRoomNumber     as char init ""       
    field TSoi            as char init ""       
    field TStreet         as char init ""       
    field TSubDistrict    as char init ""       
    field TDistrict       as char init ""       
    field TProvince       as char init ""       
    field TCountry        as char init ""       
    field TZipCode        as char init ""       
    field caddress        as char init ""       
    field ADD_floor       as char init ""       
    field ADD_room        as char init ""           
    field ADD_cty         as char init ""            
    field ADD_tel         as char init ""       
    field bentyp          as char init ""       
    field period          as char init ""      
    field ostp            as char init ""       
    field otax            as char init ""            
    field whtprem         as char init ""       
    field premamt         as char init ""       
    field foprem          as char init ""       
    field fostp           as char init ""       
    field fotax           as char init ""       
    field fprem1          as char init ""       
    field fwhtprem        as char init ""       
    field fpremamt        as char init ""       
    field noprem          as char init ""       
    field nostp           as char init ""       
    field notax           as char init ""       
    field nprem1          as char init ""       
    field nwhtprem        as char init ""       
    field npremamt        as char init ""             
    field LProductCode    as char init ""       
    field LProductName    as char init ""       
    field LApproveDate    as char init ""       
    field LBookDate       as char init ""       
    field LCreditLine     as char init ""       
    field LStatus         as char init ""       
    field LInstallmentAMT as char init ""       
    field LInstallment    as char init ""       
    field LRate           as char init ""       
    field LFirstDueDate   as char init ""      
    field covtyp          as char init ""       
    field subcov          as char init ""       
    field vehuse          as char init ""       
    field prolice         as char init ""       
    field dcar            as char init ""       
    field mile            as char init ""       
    field drilic1         as char init ""     
    field drilic2         as char init ""  
    field hcf             as char init ""       
    field stp             as char init ""
    FIELD brancho         AS CHAR INIT ""
    FIELD dealero         AS CHAR INIT "" 
    /* A65-0288*/
    FIELD colors          AS CHAR INIT "" 
    FIELD inpection       AS CHAR INIT ""  /* Y = �礢�����㹡��ͧ��Ǩ��Ҿ  N = ����礢�����㹡��ͧ��Ǩ��Ҿ*/
    FIELD ispsts          AS CHAR INIT ""  /* ���ͧ��Ǩ��Ҿ Y= �Դ����ͧ N = �ѧ���Դ����ͧ*/
    FIELD ispno           AS CHAR INIT ""  /* �Ţ����Ǩ��Ҿ */
    FIELD ispdetail       AS CHAR INIT ""  /* �ŵ�Ǩ��Ҿ */
    FIELD ispdam          AS CHAR INIT ""  /* ��¡�ä���������� */
    FIELD ispacc          AS CHAR INIT ""  /* �ػ�ó������ */
    /* end : A65-0288*/
    /* Add by : A67-0076 */
    field hp              as char init ""    
    field drititle1       as char init ""    
    field drigender1      as char init ""    
    field drioccup1       as char init ""    
    field driToccup1      as char init ""    
    field driTicono1      as char init ""    
    field driICNo1        as char init ""    
    field driLevel1       as char init ""    
    field drititle2       as char init ""    
    field drigender2      as char init ""    
    field drioccup2       as char init ""    
    field driToccup2      as char init ""    
    field driTicono2      as char init ""    
    field driICNo2        as char init ""    
    field driLevel2       as char init ""    
    field drilic3         as char init ""    
    field drititle3       as char init ""    
    field driname3        as char init ""    
    field drivno3         as char init ""    
    field drigender3      as char init ""    
    field drioccup3       as char init ""    
    field driToccup3      as char init ""    
    field driTicono3      as char init ""    
    field driICNo3        as char init ""    
    field driLevel3       as char init ""    
    field drilic4         as char init ""    
    field drititle4       as char init ""    
    field driname4        as char init ""    
    field drivno4         as char init ""    
    field drigender4      as char init ""    
    field drioccup4       as char init ""    
    field driToccup4      as char init ""    
    field driTicono4      as char init ""    
    field driICNo4        as char init ""    
    field driLevel4       as char init ""    
    field drilic5         as char init ""    
    field drititle5       as char init ""    
    field driname5        as char init ""    
    field drivno5         as char init ""    
    field drigender5      as char init ""    
    field drioccup5       as char init ""    
    field driToccup5      as char init ""    
    field driTicono5      as char init ""    
    field driICNo5        as char init ""    
    field driLevel5       as char init ""    
    field dateregis       as char init ""    
    field pay_option      as char init ""    
    field battno          as char init ""    
    field battyr          as char init ""    
    field maksi           as char init ""    
    field chargno         as char init ""  
    FIELD veh_key         AS CHAR INIT "".
    /* end : A67-0076 */
DEFINE SHARED VAR n_user   AS CHAR.
DEFINE SHARED VAR n_passwd AS CHAR.
DEF VAR nv_ccom  AS INT  INIT 0.
DEF VAR nv_chol  AS INT  INIT 0.
DEF TEMP-TABLE trecid 
    FIELD nrecid AS RECID INIT ?.
DEF VAR nv_recid AS RECID INIT ?.
/*End by Chaiyong W. A64-0135 03/04/2021*/
/*---Begin chaiyong W. A65-0XXX 21/12/2022*/
DEF VAR nv_message   AS CHAR FORMAT "X(35)" .
DEF VAR nv_branHO    AS CHAR FORMAT "x(50)" .
DEF VAR nv_subtyp    AS CHAR FORMAT "x(100)" .
DEF VAR nv_Chkbrcode AS CHAR INIT "". 
DEF VAR nv_Chkbrname AS CHAR INIT "". 
DEF VAR nv_ChkHOBR   AS CHAR INIT "". 
DEF VAR nv_stinsp    AS CHAR INIT "".
/*End by Chaiyogn w. A65-0XXX 21/12/2022--*/
{wgw\wgwimkk1.i}  /* Add by : A65-0288 */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_imptxt

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt tlt.comp_noti_tlt tlt.nor_noti_tlt ~
tlt.ins_name tlt.old_eng tlt.nor_effdat tlt.expodat tlt.lince1 ~
tlt.nor_usr_ins tlt.comp_usr_ins tlt.trndat 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt tlt.lince1 
&Scoped-define ENABLED-TABLES-IN-QUERY-br_imptxt tlt
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-br_imptxt tlt
&Scoped-define QUERY-STRING-br_imptxt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY br_imptxt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_imptxt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_compano fi_producer fi_agent ~
ra_filetyp fi_filename bu_file bu_ok bu_exit br_imptxt bu_hpacno1 ~
bu_hpacno-2 RECT-1 RECT-78 RECT-79 RECT-80 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_compano fi_producer fi_agent ~
ra_filetyp fi_filename fi_proname fi_impcnt fi_completecnt fi_dir_cnt ~
fi_dri_complet fi_agename fi_error fi_dri_fi_error fi_kkcom fi_kkhold ~
fi_kkprob 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fn-month C-Win 
FUNCTION fn-month RETURNS CHARACTER
  (ip_month AS INTEGER)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpacno-2 
     IMAGE-UP FILE "WIMAGE/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "WIMAGE/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_agename AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 54.5 BY 1.05
     BGCOLOR 18 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_compano AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dir_cnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dri_complet AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dri_fi_error AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1.05
     BGCOLOR 4 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_error AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1.05
     BGCOLOR 4 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_kkcom AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_kkhold AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_kkprob AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 54.5 BY 1.05
     BGCOLOR 18 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_filetyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Policy File 2021", 5,
"���¡��ԡ��������", 4,
"File Un-Problem 2021", 6,
"���Դ������������ҧ�Ѻ", 7
     SIZE 108 BY 1.05
     BGCOLOR 29 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 23.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-78
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 129 BY 12.91
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-79
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.91
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-80
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.91
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_imptxt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _STRUCTURED
  QUERY br_imptxt NO-LOCK DISPLAY
      tlt.comp_noti_tlt COLUMN-LABEL "�Ţ����Ѻ��� KK." FORMAT "x(25)":U
            WIDTH 14.5
      tlt.nor_noti_tlt COLUMN-LABEL "�Ţ����ѭ��" FORMAT "x(25)":U
            WIDTH 13.33
      tlt.ins_name FORMAT "x(50)":U WIDTH 23
      tlt.old_eng COLUMN-LABEL "�ѹ����Ѻ��/�ѹ����ЧѺ���" FORMAT "x(30)":U
            WIDTH 25
      tlt.nor_effdat COLUMN-LABEL "�ѹ��������ͧ" FORMAT "99/99/9999":U
            WIDTH 9.67
      tlt.expodat COLUMN-LABEL "�ѹ����������" FORMAT "99/99/99":U
      tlt.lince1 COLUMN-LABEL "����¹ö" FORMAT "x(30)":U WIDTH 9.33
      tlt.nor_usr_ins COLUMN-LABEL "���ͼ���Ѻ��Ϣͧ�.��Сѹ���MRK" FORMAT "x(50)":U
            WIDTH 22.67
      tlt.comp_usr_ins FORMAT "x(50)":U
      tlt.trndat COLUMN-LABEL "�ѹ����������" FORMAT "99/99/9999":U
  ENABLE
      tlt.lince1
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.5 BY 9.71
         BGCOLOR 15  ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 1.48 COL 28 COLON-ALIGNED NO-LABEL
     fi_compano AT ROW 1.48 COL 61.83 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 2.67 COL 28 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.86 COL 28 COLON-ALIGNED NO-LABEL
     ra_filetyp AT ROW 5.14 COL 6 NO-LABEL
     fi_filename AT ROW 6.52 COL 33.67 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 6.52 COL 99.67
     bu_ok AT ROW 6.62 COL 117.5
     bu_exit AT ROW 8.52 COL 117.83
     br_imptxt AT ROW 14.33 COL 2
     fi_proname AT ROW 2.67 COL 47.33 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 11.62 COL 33.5 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 11.62 COL 66 COLON-ALIGNED NO-LABEL
     fi_dir_cnt AT ROW 12.76 COL 33.5 COLON-ALIGNED NO-LABEL
     fi_dri_complet AT ROW 12.76 COL 66 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 2.67 COL 45.17
     fi_agename AT ROW 3.86 COL 47.33 COLON-ALIGNED NO-LABEL
     bu_hpacno-2 AT ROW 3.86 COL 45.17
     fi_error AT ROW 11.62 COL 93.83 COLON-ALIGNED NO-LABEL
     fi_dri_fi_error AT ROW 12.76 COL 93.83 COLON-ALIGNED NO-LABEL
     fi_kkcom AT ROW 7.67 COL 33.5 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_kkhold AT ROW 8.86 COL 33.5 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_kkprob AT ROW 10.14 COL 33.5 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     "�ѹ��� Load  ������  :":25 VIEW-AS TEXT
          SIZE 18 BY 1.05 AT ROW 1.48 COL 11.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "COMPANY NAME :" VIEW-AS TEXT
          SIZE 18 BY 1.05 AT ROW 1.48 COL 45.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "������к���  :":60 VIEW-AS TEXT
          SIZE 14 BY 1.05 AT ROW 12.76 COL 53.5
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "ERROR :":60 VIEW-AS TEXT
          SIZE 10 BY 1.05 AT ROW 11.62 COL 85.5
          BGCOLOR 20 FGCOLOR 4 FONT 6
     "DATA RENEW" VIEW-AS TEXT
          SIZE 18.67 BY 1.05 AT ROW 1.38 COL 111.17 WIDGET-ID 2
          BGCOLOR 19 FGCOLOR 12 FONT 23
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 11.62 COL 78.17
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "         ��� KK New Complete :" VIEW-AS TEXT
          SIZE 29 BY 1.05 AT ROW 7.67 COL 5.83 WIDGET-ID 8
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "������к���  :":60 VIEW-AS TEXT
          SIZE 14 BY 1.05 AT ROW 11.62 COL 53.5
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "           ��سһ�͹����������� :" VIEW-AS TEXT
          SIZE 29 BY 1.05 AT ROW 6.52 COL 5.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 11.62 COL 104.33
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "���� Agent      :" VIEW-AS TEXT
          SIZE 18 BY 1.05 AT ROW 3.86 COL 11.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "���� Producer  :" VIEW-AS TEXT
          SIZE 18 BY 1.05 AT ROW 2.67 COL 11.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ERROR :":60 VIEW-AS TEXT
          SIZE 10 BY 1.05 AT ROW 12.76 COL 85.5
          BGCOLOR 20 FGCOLOR 4 FONT 6
     "               ��� KK New Hold :" VIEW-AS TEXT
          SIZE 29 BY 1.05 AT ROW 8.86 COL 5.83 WIDGET-ID 10
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 12.76 COL 78.17
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 12.76 COL 104.33
          BGCOLOR 20 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 131.67 BY 23.52
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " �������駻�Сѹ����ҷ�����  :":50 VIEW-AS TEXT
          SIZE 29 BY 1.05 AT ROW 11.62 COL 5.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 11.62 COL 45.83
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "          ��� KK New Problem :" VIEW-AS TEXT
          SIZE 29 BY 1.05 AT ROW 10.14 COL 5.83 WIDGET-ID 14
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "        �����ż��Ѻ������ҷ����� :":50 VIEW-AS TEXT
          SIZE 29 BY 1.05 AT ROW 12.76 COL 5.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 12.76 COL 45.83
          BGCOLOR 20 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1.1 COL 1
     RECT-78 AT ROW 1.24 COL 2
     RECT-79 AT ROW 6.14 COL 116.17
     RECT-80 AT ROW 8.05 COL 116.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 131.67 BY 23.52
         BGCOLOR 3 .


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
         TITLE              = "Import text file KK (�ҹ�������)"
         HEIGHT             = 24.24
         WIDTH              = 131.5
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("WIMAGE/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/iconhead.ico"
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
/* BROWSE-TAB br_imptxt bu_exit fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agename IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dir_cnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dri_complet IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dri_fi_error IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_error IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_kkcom IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_kkhold IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_kkprob IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_imptxt
/* Query rebuild information for BROWSE br_imptxt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "brstat.tlt.comp_noti_tlt|yes"
     _FldNameList[1]   > brstat.tlt.comp_noti_tlt
"tlt.comp_noti_tlt" "�Ţ����Ѻ��� KK." ? "character" ? ? ? ? ? ? no ? no no "14.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "�Ţ����ѭ��" ? "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.ins_name
"tlt.ins_name" ? ? "character" ? ? ? ? ? ? no ? no no "23" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.old_eng
"tlt.old_eng" "�ѹ����Ѻ��/�ѹ����ЧѺ���" "x(30)" "character" ? ? ? ? ? ? no ? no no "25" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.nor_effdat
"tlt.nor_effdat" "�ѹ��������ͧ" ? "date" ? ? ? ? ? ? no ? no no "9.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.expodat
"tlt.expodat" "�ѹ����������" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.lince1
"tlt.lince1" "����¹ö" "x(30)" "character" ? ? ? ? ? ? yes ? no no "9.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.nor_usr_ins
"tlt.nor_usr_ins" "���ͼ���Ѻ��Ϣͧ�.��Сѹ���MRK" ? "character" ? ? ? ? ? ? no ? no no "22.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   = brstat.tlt.comp_usr_ins
     _FldNameList[10]   > brstat.tlt.trndat
"tlt.trndat" "�ѹ����������" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import text file KK (�ҹ�������) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import text file KK (�ҹ�������) */
DO:
  /* This event will close the window and terminate the procedure.  */
  IF CONNECTED ("sic_exp") THEN DISCONNECT sic_exp.  /*---add by Chaiyong W. A64-0135 10/09/2021*/
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  IF CONNECTED ("sic_exp") THEN DISCONNECT sic_exp.  /*---add by Chaiyong W. A64-0135 10/09/2021*/
  Apply "Close" To  This-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
/*      FILTERS    "Text Documents" "*.txt"    */
        
         FILTERS    /* "Text Documents"   "*.txt",
                            "Data Files (*.*)"     "*.*"*/
                    "Text Documents" "*.csv"

                   
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
          /*---Begin by Chaiyong W. A64-0135 08/06/2021*/
          IF  fi_filename <>  cvData AND  (ra_filetyp  = 5 OR  ra_filetyp  = 6 OR ra_filetyp = 7  OR ra_filetyp = 4 ) THEN DO:
              fi_filename  =  cvData .
               Disp  fi_filename with frame  fr_main.
               APPLY "value-changed" TO ra_filetyp.
          END.
          
          /*End by Chaiyong W. A64-0135 08/06/2021-----*/

         fi_filename  = cvData.
         DISP fi_filename WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno-2 C-Win
ON CHOOSE OF bu_hpacno-2 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,
                                      output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 C-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,
                                      output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN nv_daily  =  ""
        nv_reccnt    =  0 .
    FOR EACH  wdetail:
        DELETE  wdetail.
    END.
    /*--Begin by Chaiyong W. A64-0135 03/04/2021*/
    ASSIGN
        fi_filename = TRIM(INPUT fi_filename)
        fi_producer = trim(input fi_producer)      
        fi_agent    = trim(input fi_agent   )      
        fi_compano  = trim(input fi_compano )
        fi_kkhold   = trim(input fi_kkhold  )
        fi_kkcom    = trim(input fi_kkcom   )
        fi_kkprob   = TRIM(INPUT fi_kkprob)
        nv_ccom     = 0
        nv_chol     = 0
        fi_impcnt   = 0
        .      
    
    DISP fi_impcnt with frame  fr_main.
    IF fi_filename = "" THEN DO:
        MESSAGE "Import File Name is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "entry" TO fi_filename .
        RETURN NO-APPLY.
    END.
    IF ra_filetyp = 5 /*OR ra_filetyp = 6*/ THEN DO:
        IF fi_kkcom = ""  THEN DO:
            MESSAGE "Output File KK Complete is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
            APPLY "entry" TO fi_kkcom .
            RETURN NO-APPLY.

        END.
        IF fi_kkhold = ""  THEN DO:
            MESSAGE "Output File KK Hold is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
            APPLY "entry" TO fi_kkhold .
            RETURN NO-APPLY.

        END.
        IF fi_kkprob = ""  THEN DO:
            MESSAGE "Output File KK Problem is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
            APPLY "entry" TO fi_kkprob .
            RETURN NO-APPLY.

        END.

    END.
    FOR EACH trecid:
        DELETE trecid.
    END.
    /*End by Chaiyong W. A64-0135 03/04/2021----*/

    /* comment by : Ranu I. A65-0288...
    IF      ra_filetyp = 1 THEN Run Import_notification1.
    ELSE IF ra_filetyp = 2 THEN Run Import_notification2.
    ELSE IF ra_filetyp = 3 THEN Run Import_notification3.
    end A65-0288...*/
    IF ra_filetyp = 4 THEN RUN IMPORT_noticancel . /*a61-0335*/
   /*---Begin by Chaiyong W. A64-0135 10/09/2021*/
    ELSE IF ra_filetyp = 5 THEN DO:
        IF NOT CONNECTED ("sic_exp") THEN RUN wgw\wgwqcexp.
        RUN import_notinew.  
    END.
    ELSE IF ra_filetyp = 6 THEN RUN import_notiprob. 
    ELSE IF ra_filetyp = 7 THEN RUN IMPORT_chkpol. /* A65-0288*/
    APPLY "Entry" TO fi_loaddat.
    RETURN NO-APPLY.
   
    /*End by Chaiyong W. A64-0135 10/09/2021-----*/


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent =  INPUT  fi_agent .
    If Input  fi_agent  =  ""  Then do:
        Apply "Choose"  to  bu_hpacno1.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
        xmm600.acno  =  Input fi_agent  
        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" 
            View-as alert-box.
        Apply "Entry" To  fi_agent.
        Return no-apply.
    END.
    ASSIGN 
        fi_agename =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
        fi_agent =  INPUT  fi_agent .
    Disp  fi_agent  fi_agename  WITH Frame  fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compano
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compano C-Win
ON LEAVE OF fi_compano IN FRAME fr_main
DO:
    fi_compano =  INPUT  fi_compano.
    Disp  fi_compano  WITH Frame  fr_main.                
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
    /*---Begin by Chaiyong W. A64-0135 08/06/2021*/
  IF  fi_filename <>  Input  fi_filename  AND  (ra_filetyp  = 5 OR  ra_filetyp  = 6) THEN DO:
      fi_filename  =  Input  fi_filename .
       Disp  fi_filename with frame  fr_main.
       APPLY "value-changed" TO ra_filetyp.
  END.
  
  /*End by Chaiyong W. A64-0135 08/06/2021-----*/

  
    
    fi_filename  =  Input  fi_filename .
  Disp  fi_filename with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_kkcom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_kkcom C-Win
ON LEAVE OF fi_kkcom IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename .
  Disp  fi_filename with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_kkhold
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_kkhold C-Win
ON LEAVE OF fi_kkhold IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename .
  Disp  fi_filename with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_kkprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_kkprob C-Win
ON LEAVE OF fi_kkprob IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename .
  Disp  fi_filename with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp fi_loaddat  with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer  =  Input  fi_producer.
    If Input  fi_producer  =  ""  Then do:
        Apply "Choose"  to  bu_hpacno1.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
        xmm600.acno  =  Input fi_producer  
        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" 
            View-as alert-box.
        Apply "Entry" To  fi_producer.
        Return no-apply.
    END.
    fi_proname =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name).
    fi_producer =  INPUT  fi_producer.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_filetyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_filetyp C-Win
ON VALUE-CHANGED OF ra_filetyp IN FRAME fr_main
DO:
  ra_filetyp = INPUT ra_filetyp.
  DISP ra_filetyp WITH FRAM fr_main.
  /*---Begin by Chaiyong W. A64-0135 08/06/2021*/
  /*IF  ra_filetyp  = 5 OR ra_filetyp  = 6 THEN DO:*/ /*A65-0288*/
    IF  ra_filetyp  = 5 THEN DO:  /*A65-0288*/
      IF fi_filename <> "" AND INDEX(fi_filename,".") <> 0 THEN DO:
          fi_kkcom      = substr(fi_filename,1,r-INDEX(fi_filename,".") - 1) + "kkcomplete" + substr(fi_filename,r-INDEX(fi_filename,".")).
          fi_kkhold     = substr(fi_filename,1,r-INDEX(fi_filename,".") - 1) + "kkhold"     + substr(fi_filename,r-INDEX(fi_filename,".")).
          fi_kkprob     = substr(fi_filename,1,r-INDEX(fi_filename,".") - 1) + "kkproblem"  + substr(fi_filename,r-INDEX(fi_filename,".")).
      END.
      ELSE IF fi_filename <> "" THEN DO:
          ASSIGN                   
              fi_kkcom   = fi_filename + "kkcomplete.csv"     
              fi_kkhold  = fi_filename + "kkhold.csv"
              fi_kkprob   = fi_filename + "kkproblem.csv".    
      END.
      ELSE DO:
          ASSIGN
              fi_kkcom   = ""
              fi_kkhold  = ""
              fi_kkprob   = "" .
      END.
      ASSIGN
          fi_producer = ""
          fi_proname  = "".
     
      DISP fi_kkcom fi_kkhold 
            fi_producer
            fi_proname 
          fi_kkprob
          
          WITH FRAM fr_main.

      ENABLE fi_kkcom fi_kkhold fi_kkprob WITH FRAM fr_main.
      DISABLE fi_producer bu_hpacno1 WITH FRAM fr_main.
  END.
  ELSE IF ra_filetyp  = 6 THEN DO:  /*A65-0288*/
      IF fi_filename <> "" AND INDEX(fi_filename,".") <> 0 THEN DO:
          fi_kkcom      = substr(fi_filename,1,r-INDEX(fi_filename,".") - 1) + "_complete" + substr(fi_filename,r-INDEX(fi_filename,".")).
          fi_kkhold     = substr(fi_filename,1,r-INDEX(fi_filename,".") - 1) + "_all"     + substr(fi_filename,r-INDEX(fi_filename,".")).
          fi_kkprob     = "".
      END.
      ELSE IF fi_filename <> "" THEN DO:
          ASSIGN                   
              fi_kkcom   = fi_filename + "_complete.csv"     
              fi_kkhold  = fi_filename + "_all.csv"
              fi_kkprob  = "".    
      END.
      ELSE DO:
          ASSIGN
              fi_kkcom   = ""
              fi_kkhold  = ""
              fi_kkprob   = "" .
      END.
      ASSIGN
          fi_producer = ""
          fi_proname  = "".
     
      DISP fi_kkcom fi_kkhold 
           fi_producer
           fi_proname 
           fi_kkprob
          WITH FRAM fr_main.

      DISP fi_kkcom fi_kkhold fi_kkprob  WITH FRAM fr_main.  
      ENABLE fi_kkcom fi_kkhold  WITH FRAM fr_main.
      DISABLE fi_kkprob fi_producer bu_hpacno1 WITH FRAM fr_main.
  END.
  ELSE IF  ra_filetyp  = 7 THEN DO:
      IF fi_filename <> "" AND INDEX(fi_filename,".") <> 0 THEN DO:
          fi_kkcom      = substr(fi_filename,1,r-INDEX(fi_filename,".") - 1) + "_Complete" + substr(fi_filename,r-INDEX(fi_filename,".")).
          fi_kkhold     = substr(fi_filename,1,r-INDEX(fi_filename,".") - 1) + "_All"     + substr(fi_filename,r-INDEX(fi_filename,".")).
          fi_kkprob     = substr(fi_filename,1,r-INDEX(fi_filename,".") - 1) + "_SLA"  + substr(fi_filename,r-INDEX(fi_filename,".")).
      END.
      ELSE IF fi_filename <> "" THEN DO:
          ASSIGN                   
              fi_kkcom   = fi_filename + "_Complete.csv"     
              fi_kkhold  = fi_filename + "_All.csv"
              fi_kkprob  = fi_filename + "_SLA.csv".    
      END.
      ELSE DO:
          ASSIGN
              fi_kkcom   = ""
              fi_kkhold  = ""
              fi_kkprob   = "" .
      END.
      ASSIGN
          fi_producer = ""
          fi_proname  = "".
     
      DISP fi_kkcom fi_kkhold 
           fi_producer
           fi_proname 
           fi_kkprob
          WITH FRAM fr_main.

      ENABLE fi_kkcom fi_kkhold fi_kkprob WITH FRAM fr_main.
      DISABLE fi_producer bu_hpacno1 WITH FRAM fr_main.
  END.
  ELSE IF ra_filetyp = 4 THEN DO:
      IF fi_filename <> "" AND INDEX(fi_filename,".") <> 0 THEN DO:
         ASSIGN 
          fi_kkcom      = substr(fi_filename,1,r-INDEX(fi_filename,".") - 1) + "_All" + substr(fi_filename,r-INDEX(fi_filename,"."))
          fi_kkhold     = "" 
          fi_kkprob     = "" .
      END.
      ELSE IF fi_filename <> "" THEN DO:
          ASSIGN                   
              fi_kkcom   = fi_filename + "_All.csv"     
              fi_kkhold  = ""
              fi_kkprob  = "".    
      END.
      ELSE DO:
          ASSIGN
              fi_kkcom   = ""
              fi_kkhold  = ""
              fi_kkprob   = "" .
      END.
      ASSIGN
          fi_producer = ""
          fi_proname  = "".
     
      DISP fi_kkcom fi_kkhold 
           fi_producer
           fi_proname 
           fi_kkprob
          WITH FRAM fr_main.

      DISP fi_kkcom fi_kkhold fi_kkprob  WITH FRAM fr_main.
      DISABLE fi_kkhold  fi_kkprob WITH FRAM fr_main.
      ENABLE fi_kkcom  fi_producer bu_hpacno1 WITH FRAM fr_main.


  END.
  /* end A65-0288 */
  ELSE DO:
      ASSIGN
          fi_kkcom   = ""
          fi_kkhold  = "" 
          fi_kkprob  = "".
      DISP fi_kkcom fi_kkhold fi_kkprob  WITH FRAM fr_main.
      DISABLE fi_kkcom fi_kkhold  fi_kkprob WITH FRAM fr_main.
      ENABLE fi_producer bu_hpacno1 WITH FRAM fr_main.
  END.
  /*End by Chaiyong W. A64-0135 08/06/2021-----*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_imptxt
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
/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.
/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
    ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    RUN enable_UI.
    /********************  T I T L E   F O R  C - W I N  ****************/
    DEF  VAR  gv_prgid   AS   CHAR.
    DEF  VAR  gv_prog    AS   CHAR.
    gv_prgid = "wgwimkk1".
    gv_prog  = "Import Text File to open policy (��Ҥ�����õԹҤԹ) ".
    RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
    /*********************************************************************/ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    /*RECT-4:MOVE-TO-TOP().
    RECT-75:MOVE-TO-TOP().  */
    Hide Frame  fr_gen  .
    ASSIGN  
        fi_loaddat  = today
       /* fi_producer = "A0M1005" comment by A64-0135 */
        fi_compano  = "KK"  /*
        fi_agent    = "B3M0006"  comment by A64-0135 */
        fi_agent    = "B3MLKK0100" /*---add by A64-0135*/
        /*ra_filetyp  = 1*/ /* A65-0288*/
        /*ra_txttyp   = 1*/     .

    ra_filetyp  = 5. /*--add by Chaiyong W. A64-0135 08/06/2021*/
    
  
    DISP  fi_loaddat  fi_producer fi_agent fi_compano ra_filetyp  with  frame  fr_main.
    APPLY "value-changed" TO ra_filetyp. /*--add by Chaiyong W. A64-0135 08/06/2021*/
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-Create_tlt C-Win 
PROCEDURE 00-Create_tlt :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0288...
LOOP_wdetail:
FOR EACH wdetail :
    IF wdetail.ADD_no      <> "" THEN wdetail.ADD_no      = "�Ţ��� " + trim(wdetail.ADD_no)   + " " .            
    IF wdetail.ADD_mu      <> "" THEN wdetail.ADD_no      = wdetail.ADD_no + "���� "     + trim(wdetail.ADD_mu)    + " " .
    IF wdetail.ADD_muban   <> "" THEN wdetail.ADD_no      = wdetail.ADD_no + "�����ҹ " + trim(wdetail.ADD_muban) + " " .
    IF wdetail.ADD_build   <> "" THEN wdetail.ADD_build   = "�Ҥ�� "    + trim(wdetail.ADD_build) + " " .    
    IF wdetail.ADD_soy     <> "" THEN wdetail.ADD_build   = wdetail.ADD_build + "��� "      + trim(wdetail.ADD_soy)   + " " .
    IF wdetail.ADD_road    <> "" THEN wdetail.ADD_build   = wdetail.ADD_build + "��� "      + trim(wdetail.ADD_road)  + " " .
    /*IF wdetail.ADD_thambon <> "" THEN wdetail.ADD_thambon = "�Ӻ� "    + trim(wdetail.ADD_thambon). 
    IF wdetail.ADD_amper   <> "" THEN wdetail.ADD_amper   = "����� "   + trim(wdetail.ADD_amper).            
    IF wdetail.ADD_country <> "" THEN wdetail.ADD_country = "�ѧ��Ѵ " + trim(wdetail.ADD_country).
    IF wdetail.ADD_post    <> "" THEN wdetail.ADD_post    = "���� "    + trim(wdetail.ADD_post).  */ 
    IF wdetail.ADD_thambon <> "" THEN wdetail.ADD_thambon = trim(wdetail.ADD_thambon). 
    IF wdetail.ADD_amper   <> "" THEN wdetail.ADD_amper   = trim(wdetail.ADD_amper).            
    IF wdetail.ADD_country <> "" THEN wdetail.ADD_country = trim(wdetail.ADD_country).
    IF wdetail.ADD_post    <> "" THEN wdetail.ADD_post    = trim(wdetail.ADD_post). 
    /* ------------------------check policy  Duplicate--------------------------------------*/
    /* create by a61-0335*/
    IF wdetail.notifyno <> "" THEN DO:
        FIND  tlt    WHERE 
            tlt.comp_noti_tlt  = wdetail.notifyno    AND
            tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
    END.
    ELSE DO:
        FIND  tlt    WHERE 
            tlt.expotim        = wdetail.kkapp     AND
            tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
    END.
    /* end A61-0335 */
    /* comment by A61-0335........
    FIND  tlt    WHERE 
            tlt.comp_noti_tlt  = wdetail.notifyno    AND
            tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
    .. end A61-0335..*/
    IF NOT AVAIL tlt THEN DO:    
        CREATE tlt.
        nv_completecnt  =  nv_completecnt + 1.
        ASSIGN
            tlt.entdat         = TODAY
            tlt.enttim         = STRING(TIME,"HH:MM:SS")
            /*nv_enttim          = STRING(TIME,"HH:MM:SS")*/
            tlt.trntime        = STRING(TIME,"HH:MM:SS")
            tlt.trndat         = fi_loaddat
            tlt.datesent       = date(wdetail.Notify_dat)           /*1  �ѹ����Ѻ��   */                        
            tlt.dat_ins_not    = date(wdetail.recive_dat)           /*2  �ѹ����Ѻ�Թ������»�Сѹ */            
            tlt.nor_usr_ins    = trim(wdetail.comp_code)            /*3  ��ª��ͺ���ѷ��Сѹ���  */                
            tlt.nor_noti_tlt   = trim(wdetail.cedpol)               /*4  �Ţ����ѭ����ҫ��� */                    
            tlt.nor_noti_ins   = trim(wdetail.prepol)               /*5  �Ţ�������������  */                    
            tlt.nor_usr_tlt    = trim(wdetail.cmbr_no)              /*6  �����Ң�    */                            
            tlt.comp_usr_tlt   = trim(wdetail.cmbr_code)            /*7  �Ң� KK */                                
            tlt.comp_noti_tlt  = trim(wdetail.notifyno)             /*8  �Ţ�Ѻ��� */                            
            tlt.dri_no1        = trim(wdetail.campaigno)            /*9  Campaign    */                            
            tlt.dri_no2        = trim(wdetail.campaigsub)           /*10 Sub Campaign    */                        
            tlt.safe2          = trim(wdetail.typper)               /*11 �ؤ��/�ԵԺؤ�� */                        
            tlt.ins_name       = trim(wdetail.n_TITLE) + " " +      /*12 �ӹ�˹�Ҫ���    */                        
                                 trim(wdetail.n_name1) + " " +      /*13 ���ͼ����һ�Сѹ    */                  
                                 trim(wdetail.n_name2)              /*14 ���ʡ�ż����һ�Сѹ */           
            tlt.ins_addr1      = trim(wdetail.ADD_no)      +        /*15 ��ҹ�Ţ���  */                          
                                 trim(wdetail.ADD_build)            /*16 ���� + �����ҹ + �Ҥ�� + ��� + ���    */       
            tlt.ins_addr2      = trim(wdetail.ADD_thambon)          /*21 �Ӻ�/�ǧ*/                     
            tlt.ins_addr3      = trim(wdetail.ADD_amper)            /*22 �����/ࢵ*/                     
            tlt.ins_addr4      = trim(wdetail.ADD_country)          /*23 �ѧ��Ѵ*/                               
            tlt.ins_addr5      = trim(wdetail.ADD_post)             /*24 ������ɳ���*/                       
            tlt.safe3          = IF index(wdetail.cover,"1") <> 0 THEN "1"    /*  25 ����������������ͧ  */                    
                                 ELSE IF index(wdetail.cover,"2") <> 0 THEN "2" 
                                 ELSE "3"
            tlt.stat           = IF index(wdetail.garage,"���������") <> 0 THEN " " ELSE "G"  /*  26 ��������ë���   */                        
            tlt.nor_effdat     = date(wdetail.comdat)               /*  27 �ѹ�����������ͧ    */                    
            tlt.expodat        = date(wdetail.expdat)               /*  28 �ѹ����ش������ͧ  */                    
            tlt.subins         = trim(wdetail.subclass)             /*  29 ����ö  */                                
            tlt.filler2        = trim(wdetail.n_43)                 /*  30 ��������Сѹ���ö¹��   */                
            tlt.brand          = trim(wdetail.brand)                /*  31 ����������ö    */                        
            tlt.model          = trim(wdetail.model)                /*  32 ���ö  */                                
            tlt.filler1        = trim(wdetail.nSTATUS)              /*  33 New/Used    */                            
            tlt.lince1         = trim(wdetail.licence)              /*  34 �Ţ����¹  */                            
            tlt.cha_no         = trim(wdetail.chassis)              /*  35 �Ţ��Ƕѧ   */                            
            tlt.eng_no         = trim(wdetail.engine)               /*  36 �Ţ����ͧ¹��  */                        
            tlt.lince2         = trim(wdetail.cyear)                /*  37 ��ö¹��    */                            
            tlt.cc_weight      = deci(wdetail.power)                /*  38 �ի�    */                            
            tlt.colorcod       = trim(wdetail.weight)               /*  39 ���˹ѡ/�ѹ */                        
            tlt.comp_coamt     = deci(wdetail.ins_amt1)             /*  40 �ع��Сѹ�� 1   */                    
            tlt.comp_grprm     = deci(wdetail.prem1)                /*  41 ����������������ҡû� 1    */        
            tlt.nor_coamt      = deci(wdetail.ins_amt2)             /*  42 �ع��Сѹ�� 2   */                    
            tlt.nor_grprm      = deci(wdetail.prem2)                /*  43 ����������������ҡû� 2    */        
            tlt.gentim         = trim(wdetail.time_notify)          /*  44 �����Ѻ���    */                    
            tlt.comp_usr_ins   = trim(wdetail.NAME_mkt)             /*  45 �������˹�ҷ�� MKT */                
            tlt.safe1          = trim(wdetail.bennam)               /*  46 �����˵�    */                        
            tlt.dri_name1      = trim(wdetail.drivno1)              /*  47 ���Ѻ����� 1 �����ѹ�Դ        */ 
            tlt.dri_name2      = trim(wdetail.drivno2)              /*  48 ���Ѻ����� 2 �����ѹ�Դ        */ 
            tlt.rec_name       = trim(wdetail.reci_title) + " " +   /*  49 �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)*/ 
                                 trim(wdetail.reci_name1) + " " +   /*  50 ���� (�����/㺡ӡѺ����)        */ 
                                 trim(wdetail.reci_name2)           /*  51 ���ʡ�� (�����/㺡ӡѺ����)     */ 
            tlt.rec_addr1      = trim(wdetail.reci_addno) +         /*  52 ��ҹ�Ţ��� (�����/㺡ӡѺ����)  */
                                 trim(wdetail.reci_addmu) +         /*  53 �����ҹ (�����/㺡ӡѺ����)    */ 
                                 trim(wdetail.reci_addbuild)  +     /*  54 �Ҥ�� (�����/㺡ӡѺ����)       */ 
                                 trim(wdetail.reci_addsoy) +        /*  55 ��� (�����/㺡ӡѺ����)  */
                                 trim(wdetail.reci_addroad)         /*  56 ��� (�����/㺡ӡѺ����)   */            
            tlt.rec_addr2      = trim(wdetail.reci_addtambon)       /*  57 �Ӻ�/�ǧ (�����/㺡ӡѺ����) */        
            tlt.rec_addr3      = trim(wdetail.reci_addamper)        /*  58 �����/ࢵ (�����/㺡ӡѺ����) */        
            tlt.rec_addr4      = trim(wdetail.reci_addcounty)       /*  59 �ѧ��Ѵ (�����/㺡ӡѺ����)   */        
            tlt.rec_addr5      = trim(wdetail.reci_addpost)         /*  60 ������ɳ��� (�����/㺡ӡѺ����)*/    
            tlt.seqno          = deci(wdetail.ncb)                  /*  61 ��ǹŴ����ѵԴ� */                          
            tlt.lotno          = trim(wdetail.fleet)                /*  62  ��ǹŴ�ҹ Fleet */ 
            /* A60-0232 */
            tlt.endcnt         = INT(wdetail.fi)
            tlt.expousr        = "TEL:" + TRIM(wdetail.tel) + " " +             /*����Դ���                 */  
                                 "ICNO:" + TRIM(wdetail.icno)                   /*�Ţ���ѵû�ЪҪ�           */  
            tlt.usrsent        = "Occup:" + TRIM(wdetail.occup) + " " +         /*�Ҫվ                       */ 
                                 "Status:" + TRIM(wdetail.cstatus) + " " +      /*ʶҹ�Ҿ                     */ 
                                 "Tax:" + TRIM(wdetail.taxno)                   /*�Ţ��Шӵ�Ǽ�����������ҡ�  */
            tlt.gendat         = DATE(wdetail.bdate)                            /*�ѹ��͹���Դ              */
            tlt.lince3         = "T1:"  + trim(wdetail.tname1) + " " +       /*�ӹ�˹�Ҫ��� 1              */
                                 "N1:"  + trim(wdetail.name1)  + " " +       /*���͡������ 1               */
                                 "L1:"  + trim(wdetail.lname1) + " " +       /*���ʡ�š������ 1            */
                                 "IC1:" + trim(wdetail.icno1)  + " " +       /*�Ţ���ѵû�ЪҪ�������� 1  */
                                 "T2:"  + trim(wdetail.tname2) + " " +       /*�ӹ�˹�Ҫ��� 1              */
                                 "N2:"  + trim(wdetail.name2) + " " +       /*���͡������ 1               */
                                 "L2:"  + trim(wdetail.lname2) + " " +       /*���ʡ�š������ 1            */
                                 "IC2:" + trim(wdetail.icno2) + " " +       /*�Ţ���ѵû�ЪҪ�������� 1  */
                                 "T3:"  + trim(wdetail.tname3) + " " +       /*�ӹ�˹�Ҫ��� 1              */
                                 "N3:"  + trim(wdetail.name3) + " " +       /*���͡������ 1               */
                                 "L3:"  + trim(wdetail.lname3) + " " +       /*���ʡ�š������ 1            */
                                 "IC3:" + trim(wdetail.icno3)              /*�Ţ���ѵû�ЪҪ�������� 1  */
            tlt.comp_noti_ins  = "SE:" + TRIM(wdetail.postsend) + " " +  /* ʶҹ���Ѵ�� */         /* A61-0335 */
                                 "SN:" + TRIM(wdetail.sendname) + " " +  /* ���ͼ���Ѻ */            /* A61-0335 */
                                 "BE:" +   TRIM(wdetail.benname)               /* ���ͼ���Ѻ�Ż���ª�� */    /* A61-0335 */
            tlt.expotim        = trim(wdetail.KKapp)              /* KK App */                 /* A61-0335 */
            tlt.old_cha        = "" /* remark 2 */ /*A61-0335*/
            /* End : A60-0232  */
            tlt.OLD_eng        = "COVER"
            tlt.flag           = "R"                      
            tlt.comp_sub       = trim(fi_producer) 
            tlt.recac          = trim(fi_agent)  
            tlt.genusr         = trim(fi_compano)
            tlt.endno          = USERID(LDBNAME(1))                 /*User Load Data */
            tlt.imp            = "IM"                               /*Import Data    */
            tlt.usrid          = TRIM(wdetail.dealer)  . /*A63-00472*/
          IF tlt.releas = "" AND tlt.policy = "" THEN tlt.releas         = "NO" .
           
    END.            
    ELSE DO:
        nv_completecnt  =  nv_completecnt + 1.
        RUN Create_tltup.
    END.
END.   /* FOR EACH wdetail NO-LOCK: */

Run Open_tlt.
....end A65-0288....*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-Create_tlt3 C-Win 
PROCEDURE 00-Create_tlt3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0288....
LOOP_wdetail:
FOR EACH wdetail :
    ASSIGN  nv_error   = nv_error + 1 .    /*add kridtiya i. A55-0029 */
    IF wdetail.notifyno <> ""  THEN DO:
        FIND FIRST tlt    WHERE 
            tlt.comp_noti_tlt         = wdetail.notifyno   AND
            tlt.genusr                = "kk"               AND
            index(tlt.OLD_eng,"HOLD") <> 0                 NO-ERROR NO-WAIT .
        IF AVAIL tlt THEN DO:  
            nv_completecnt  =  nv_completecnt + 1.
            ASSIGN  
                tlt.trndat    = fi_loaddat
                tlt.OLD_eng   = "CANCEL_HOLD" +  SUBSTR(tlt.OLD_eng,(INDEX(tlt.OLD_eng,"Hold") + 4 )).  
         /*   /*---Begin by Chaiyong W. A64-0135 03/04/2021*/
            ASSIGN
                tlt.note24          = trim(wdetail.remark)
                tlt.hclfg          = "N".
            /*End by Chaiyong W. A64-0135 03/04/2021-----*/*/
        END.
        ELSE DO:
            MESSAGE "��辺 �Ţ�Ѻ��駹���ЧѺ���: " wdetail.notifyno " ��к� TLT HOLD !!! " VIEW-AS ALERT-BOX.
        END.
    END.
   /* create by A61-0335*/
    ELSE DO:
         FIND FIRST tlt    WHERE 
            tlt.expotim               = wdetail.kkapp     AND
            tlt.genusr                = "kk"               AND
            index(tlt.OLD_eng,"HOLD") <> 0                 NO-ERROR NO-WAIT .
        IF AVAIL tlt THEN DO:  
            nv_completecnt  =  nv_completecnt + 1.
            ASSIGN  
                tlt.trndat    = fi_loaddat
                tlt.OLD_eng   = "CANCEL_HOLD" +  SUBSTR(tlt.OLD_eng,(INDEX(tlt.OLD_eng,"Hold") + 4 )).  
       /*     /*---Begin by Chaiyong W. A64-0135 03/04/2021*/
            ASSIGN
                tlt.note24          = trim(wdetail.remark)
                tlt.hclfg          = "N".
            /*End by Chaiyong W. A64-0135 03/04/2021-----*/*/
        END.
        ELSE DO:
            MESSAGE "��辺 �Ţ�Ѻ��駹���ЧѺ���: " wdetail.notifyno " ��к� TLT HOLD !!! " VIEW-AS ALERT-BOX.
        END.
    END.
    /* end  A61-0335 */
END.   /* FOR EACH wdetail NO-LOCK: */
Run Open_tlt.
..END A65-0288...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-create_tlt4 C-Win 
PROCEDURE 00-create_tlt4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A61-0335*/      
/*------------------------------------------------------------------------------*/
/* comment by : A65-0288...
LOOP_wdetail:
FOR EACH wdetail :
    ASSIGN  nv_error   = nv_error + 1 .  
    IF wdetail.notifyno <> ""  THEN DO:
        FIND FIRST tlt    WHERE 
            tlt.comp_noti_tlt    = wdetail.notifyno     AND
            tlt.genusr           = "kk"                 NO-ERROR NO-WAIT .
        IF AVAIL tlt THEN DO:  
            nv_completecnt  =  nv_completecnt + 1.
             IF tlt.releas = "NO" THEN DO:
                ASSIGN  
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "NO/CA"
                    tlt.OLD_eng  = "CANCEL_POL " + wdetail.Notify_dat + " ���˵�: " + TRIM(wdetail.remark) 
                    tlt.OLD_cha  = tlt.OLD_cha  + "  �����¡��ԡ:" + TRIM(wdetail.NAME_mkt) + " " + trim(wdetail.remark1) .
             END.
             ELSE IF tlt.releas = "YES" THEN DO:
                ASSIGN  
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "YES/CA"
                    tlt.OLD_eng  = "CANCEL_POL " + wdetail.Notify_dat + " ���˵�: " + TRIM(wdetail.remark) 
                    tlt.OLD_cha  = tlt.OLD_cha  + "  �����¡��ԡ:" + TRIM(wdetail.NAME_mkt) + " " + trim(wdetail.remark1) .
             END.
             ELSE MESSAGE "¡��ԡ�Ţ�Ѻ��駹����к����� : " +  wdetail.notifyno + " !!! " VIEW-AS ALERT-BOX.
        END.
        ELSE DO:
            MESSAGE "��辺 �Ţ�Ѻ��駹����к� : " +  wdetail.notifyno + " !!! " VIEW-AS ALERT-BOX.
        END.
    END.
    ELSE DO:
        FIND FIRST tlt    WHERE 
            tlt.expotim    = wdetail.kkapp     AND
            tlt.genusr     = "kk"                 NO-ERROR NO-WAIT .
        IF AVAIL tlt THEN DO:  
            nv_completecnt  =  nv_completecnt + 1.
             IF tlt.releas = "NO" THEN DO:
                ASSIGN  
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "NO/CA"
                    tlt.OLD_eng  = "CANCEL_POL " + wdetail.Notify_dat + " ���˵�: " + TRIM(wdetail.remark) 
                    tlt.OLD_cha  = tlt.OLD_cha  + "  �����¡��ԡ:" + TRIM(wdetail.NAME_mkt) + " " + trim(wdetail.remark1) .
             END.
             ELSE IF tlt.releas = "YES" THEN DO:
                ASSIGN  
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "YES/CA"
                    tlt.OLD_eng  = "CANCEL_POL " + wdetail.Notify_dat + " ���˵�: " + TRIM(wdetail.remark) 
                    tlt.OLD_cha  = tlt.OLD_cha  + "  �����¡��ԡ:" + TRIM(wdetail.NAME_mkt) + " " + trim(wdetail.remark1) .
             END.
             ELSE MESSAGE "¡��ԡ�Ţ�Ѻ��駹����к����� : " +  wdetail.notifyno + " !!! " VIEW-AS ALERT-BOX.
        END.
        ELSE DO:
            MESSAGE "��辺 �Ţ�Ѻ��駹����к� : " +  wdetail.notifyno + " !!! " VIEW-AS ALERT-BOX.
        END.

    END.
END.   /* FOR EACH wdetail NO-LOCK: */
Run Open_tlt.
..end : A65-0288..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-IMPORT_noticancel C-Win 
PROCEDURE 00-IMPORT_noticancel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A61-0335      
------------------------------------------------------------------------------*/
/* comment by : Ranu I. A65-0288...
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.Notify_dat    /* �ѹ�����¡��ԡ��������  */  
        wdetail.comp_code     /* ���ͺ���ѷ��Сѹ          */  
        wdetail.notifyno      /* �Ţ�Ѻ��                */  
        wdetail.cedpol        /* �Ţ����ѭ��               */  
        wdetail.bennam        /* ����-ʡ�� �١���          */  
        wdetail.licenc        /* ����¹ö¹��             */  
        wdetail.cover        /* ����������������ͧ        */  
        wdetail.comdat        /* �ѹ������ͧ               */  
        wdetail.expdat        /* �ѹ����ش������ͧ        */  
        wdetail.NAME_mkt      /* �������˹�ҷ�� MKT       */  
        wdetail.remark        /* �˵ؼš��¡��ԡ           */  
        wdetail.remark1       /* �����˵�                  */  
        wdetail.kkapp .       /* KKApplicationNo.          */  
END.  
                          /* repeat  */
ASSIGN  nv_error   = 0     
    nv_completecnt = 0 .  

FOR EACH wdetail .
    IF      INDEX(wdetail.Notify_dat ,"�ѹ���") <> 0   THEN DELETE wdetail.
    ELSE IF       wdetail.Notify_dat   =  " "          THEN DO: 
        ASSIGN nv_error = nv_error + 1 .
        DELETE wdetail.
    END.
    ELSE IF wdetail.notifyno  = "" AND wdetail.kkapp = ""  THEN DO:
        ASSIGN nv_error = nv_error + 1 .
        Message "�Ţ�Ѻ���繤����ҧ " View-as alert-box. 
        DELETE wdetail.    /*add kridtiya i. A55-0029  */
    END.
    ELSE ASSIGN nv_error = nv_error + 1 .
END.
Run  Create_tlt4.  

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.
END.
ASSIGN 
    nv_error = nv_error - 1
    fi_completecnt  =  nv_completecnt 
    fi_error        =  nv_error - nv_completecnt   /*add kridtiya i. A55-0029 */
    nv_completecnt  =  0
    fi_impcnt       =  nv_reccnt .
Disp fi_completecnt   fi_impcnt  fi_error  with frame  fr_main.

Run Open_tlt.

Message "Load  Data Complete "  View-as alert-box.  
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-Import_notification1 C-Win 
PROCEDURE 00-Import_notification1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0288...
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.Notify_dat      /*1 �ѹ����Ѻ��                       */  
        wdetail.recive_dat      /*2 �ѹ����Ѻ�Թ������»�Сѹ         */  
        wdetail.comp_code       /*3 ��ª��ͺ���ѷ��Сѹ���              */  
        wdetail.cedpol          /*4 �Ţ����ѭ����ҫ���                 */  
        wdetail.prepol          /*5 �Ţ�������������                  */  
        wdetail.cmbr_no         /*6 �����Ң�                            */  
        wdetail.cmbr_code       /*7 �Ң� KK                             */  
        wdetail.notifyno        /*8 �Ţ�Ѻ��                          */  
        wdetail.campaigno       /*9 Campaign                            */  
        wdetail.campaigsub      /*10 Sub Campaign                       */  
        wdetail.typper          /*11 �������ؤ��                        */  
        wdetail.n_TITLE         /*12 �ӹ�˹�Ҫ���                       */  
        wdetail.n_name1         /*13 ���ͼ����һ�Сѹ���                */  
        wdetail.n_name2         /*14 ���ʡ�ż����һ�Сѹ���             */  
        wdetail.ADD_no          /*15 ��ҹ�Ţ���                         */  
        wdetail.ADD_mu          /*16 ����                               */  
        wdetail.ADD_muban       /*17 �����ҹ                           */  
        wdetail.ADD_build       /*18 �Ҥ��                              */  
        wdetail.ADD_soy         /*19 ���                                */  
        wdetail.ADD_road        /*20 ���                                */  
        wdetail.ADD_thambon     /*21 �Ӻ�/�ǧ                          */  
        wdetail.ADD_amper       /*22 �����/ࢵ                          */  
        wdetail.ADD_country     /*23 �ѧ��Ѵ                            */  
        wdetail.ADD_post        /*24 ������ɳ���                       */  
        wdetail.cover           /*25 ����������������ͧ                 */  
        wdetail.garage          /*26 ��������ë���                      */  
        wdetail.comdat          /*27 �ѹ�����������ͧ                   */  
        wdetail.expdat          /*28 �ѹ����ش������ͧ                 */  
        wdetail.subclass        /*29 ����ö                             */  
        wdetail.n_43            /*30 ��������Сѹ���ö¹��              */  
        wdetail.brand           /*31 ����������ö                       */  
        wdetail.model           /*32 ���ö                             */  
        wdetail.nSTATUS         /*33 New/Used                           */  
        wdetail.licence         /*34 �Ţ����¹                         */  
        wdetail.chassis         /*35 �Ţ��Ƕѧ                          */  
        wdetail.engine          /*36 �Ţ����ͧ¹��                     */  
        wdetail.cyear           /*37 ��ö¹��                           */  
        wdetail.power           /*38 �ի�                               */  
        wdetail.weight          /*39 ���˹ѡ(�ѹ)                       */  
        wdetail.ins_amt1        /*40 �ع��Сѹ�� 1                      */  
        wdetail.prem1           /*41 ���������������ҡû� 1            */  
        wdetail.ins_amt2        /*42 �ع��Сѹ����������µ�͵��ö��2(OD)*/  
        wdetail.fi              /*43 �ع��Сѹö¹���٭���/����� ��2   */   /*A60-0232 */
        wdetail.prem2           /*44 ���������������ҡû� 2            */  
        wdetail.time_notify      /*45 �����Ѻ��                        */  
        wdetail.NAME_mkt         /*46 �������˹�ҷ�� MKT                */  
        wdetail.bennam           /*47 �����˵�                           */  
        wdetail.drivno1          /*48 ���Ѻ����� 1 ����ѹ�Դ          */  
        wdetail.drivno2          /*49 ���Ѻ����� 2 ����ѹ�Դ          */  
        wdetail.reci_title       /*50 �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����) */  
        wdetail.reci_name1       /*51 ���� (�����/㺡ӡѺ����)         */  
        /*wdetail.reci_name2 A60-0232*/     
        wdetail.reci_addno           /*52 ��ҹ�Ţ���(�����/㺡ӡѺ����) */
        wdetail.reci_addmu       /*53 �����ҹ (�����/㺡ӡѺ����)     */    
        wdetail.reci_addbuild    /*54 �Ҥ�� (�����/㺡ӡѺ����)        */    
        wdetail.reci_addsoy      /*55 ��� (�����/㺡ӡѺ����)          */    
        wdetail.reci_addroad     /*56 ��� (�����/㺡ӡѺ����)          */    
        wdetail.reci_addtambon   /*57 �Ӻ�/�ǧ (�����/㺡ӡѺ����)    */    
        wdetail.reci_addamper    /*58 �����/ࢵ (�����/㺡ӡѺ����)    */    
        wdetail.reci_addcounty   /*59 �ѧ��Ѵ (�����/㺡ӡѺ����)      */    
        wdetail.reci_addpost     /*60 ������ɳ��� (�����/㺡ӡѺ����) */    
        wdetail.ncb              /*61 ��ǹŴ����ѵԴ�                    */    
        wdetail.fleet            /*62 ��ǹŴ�ҹ Fleet                    */ 
        /* A60-0232*/   
        wdetail.tel             /*63 ����Դ���                        */  
        wdetail.icno            /*64 �Ţ���ѵû�ЪҪ�                  */  
        wdetail.bdate           /*65 �ѹ��͹���Դ                     */  
        wdetail.occup           /*66 �Ҫվ                              */  
        wdetail.cstatus         /*67 ʶҹ�Ҿ                            */  
        wdetail.taxno           /*68 �Ţ��Шӵ�Ǽ�����������ҡ�         */  
        wdetail.tname1          /*69 �ӹ�˹�Ҫ��� 1                     */  
        wdetail.name1           /*70 ���͡������ 1                      */  
        wdetail.lname1          /*71 ���ʡ�š������ 1                   */  
        wdetail.icno1           /*72 �Ţ���ѵû�ЪҪ�������� 1         */  
        wdetail.tname2          /*73 �ӹ�˹�Ҫ��� 2                     */  
        wdetail.name2           /*74 ���͡������ 2                      */  
        wdetail.lname2          /*75 ���ʡ�š������ 2                   */  
        wdetail.icno2           /*76 �Ţ���ѵû�ЪҪ�������� 2         */  
        wdetail.tname3          /*77 �ӹ�˹�Ҫ��� 3                     */  
        wdetail.name3           /*78 ���͡������ 3                      */  
        wdetail.lname3          /*79 ���ʡ�š������ 3                   */  
        wdetail.icno3          /*80 �Ţ���ѵû�ЪҪ�������� 3         */  
        /* end A60-0232*/
        wdetail.postsend    /* a61-0335 */
        wdetail.sendname    /* A61-0335 */
        wdetail.benname     /* A61-0335 */
        wdetail.kkapp      /* A61-0335 */   
        wdetail.wht        /* A63-00472 kridtiya i.*/
        wdetail.dealer.    /* A63-00472 kridtiya i.*/
       
END.  
                          /* repeat  */
ASSIGN  nv_error   = 0     /*add kridtiya i. A55-0029 */
    nv_completecnt = 0 .  

FOR EACH wdetail .
    IF      INDEX(wdetail.Notify_dat ,"�ѹ���") <> 0   THEN DELETE wdetail.
    ELSE IF       wdetail.Notify_dat   =  " "          THEN DO: 
        ASSIGN nv_error = nv_error + 1 .
        DELETE wdetail.
    END.
    ELSE IF wdetail.chassis  = "" THEN DO:
        ASSIGN nv_error = nv_error + 1 .
        Message "���Ţ��Ƕѧ�繤����ҧ : " wdetail.notifyno  View-as alert-box. 
        DELETE wdetail.    /*add kridtiya i. A55-0029  */
    END.
    ELSE ASSIGN nv_error = nv_error + 1 .
END.
Run  Create_tlt.  

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.
END.
ASSIGN 
    nv_error = nv_error - 1
    fi_completecnt  =  nv_completecnt 
    fi_error        =  nv_error - nv_completecnt   /*add kridtiya i. A55-0029 */
    nv_completecnt  =  0
    fi_impcnt       =  nv_reccnt .
Disp fi_completecnt   fi_impcnt  fi_error  with frame  fr_main.

Run Open_tlt.

Message "Load  Data Complete "  View-as alert-box.  
...end A65-0288...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-Import_notification2 C-Win 
PROCEDURE 00-Import_notification2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0288...
DEF VAR   nv_ncb  as  char  init  "" format "X(5)".
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.notifyno      /* 1  �Ţ�Ѻ���             REKK-54-006553        */ 
        wdetail.comp_code     /* 2  ��ª��ͺ���ѷ��Сѹ���  ���.��Сѹ�������     */ 
        wdetail.Notify_dat    /* 3  �ѹ����Ѻ��           8/11/2011 10:30       */ 
        wdetail.cedpol        /* 4  �Ţ����ѭ����ҫ���     004552000791          */ 
        wdetail.n_TITLE       /* 5  �ӹ�˹�Ҫ���            ���                   */        
        wdetail.n_name1       /* 6  ���ͼ����һ�Сѹ        �����õ�             */    
        wdetail.n_name2       /* 7  ���ʡ�ż����һ�Сѹ     �ح�Դ               */ 
        wdetail.comdat        /* 8  �ѹ�����������ͧ        8/11/2011             */ 
        wdetail.expdat        /* 9  �ѹ����ش������ͧ      8/11/2012             */ 
        wdetail.licence       /* 10 �Ţ����¹              �� 9644-��ا෾��ҹ�� */ 
        wdetail.NAME_mkt      /* 11 �������˹�ҷ�� MKT     ����Ծ�ó� ���蹨Ե�  */ 
        wdetail.kkapp         /* kkapp A61-0335*/
        wdetail.remark        /*---add A64-0135 03/04/2021*/
        
        .
    wdetail.remark = TRIM(wdetail.remark) .       /*---add A64-0135 16/04/2021*/
END.                          /* repeat  */
FOR EACH wdetail .
    IF      INDEX(wdetail.notifyno,"�Ţ�Ѻ") <> 0   THEN DELETE wdetail.
    ELSE IF       wdetail.notifyno  =  " "          THEN DELETE wdetail.
END.
ASSIGN  nv_error   = 0     /*add kridtiya i. A55-0029 */
    nv_completecnt = 0 . 
Run  Create_tlt2 . 

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.
END.
ASSIGN 
    fi_completecnt  =  nv_completecnt 
    fi_error        =  nv_error - nv_completecnt   /*add kridtiya i. A55-0029 */
    nv_completecnt  =  0
    fi_impcnt       =  nv_reccnt .
Disp fi_completecnt   fi_impcnt fi_error  with frame  fr_main.

Run Open_tlt.

Message "Load  Data Complete"  View-as alert-box.  
...end A65-0288...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-Import_notification3 C-Win 
PROCEDURE 00-Import_notification3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0288...
FOR EACH  wdetail :
    DELETE  wdetail.
END.

INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.notifyno      /* 1  �Ţ�Ѻ���             REKK-54-006553        */ 
        wdetail.comp_code     /* 2  ��ª��ͺ���ѷ��Сѹ���  ���.��Сѹ�������     */ 
        wdetail.Notify_dat    /* 3  �ѹ����Ѻ��           8/11/2011 10:30       */ 
        wdetail.cedpol        /* 4  �Ţ����ѭ����ҫ���     004552000791          */ 
        wdetail.n_TITLE       /* 5  �ӹ�˹�Ҫ���            ���                   */        
        wdetail.n_name1       /* 6  ���ͼ����һ�Сѹ        �����õ�             */    
        wdetail.n_name2       /* 7  ���ʡ�ż����һ�Сѹ     �ح�Դ               */ 
        wdetail.comdat        /* 8  �ѹ�����������ͧ        8/11/2011             */ 
        wdetail.expdat        /* 9  �ѹ����ش������ͧ      8/11/2012             */ 
        wdetail.licence       /* 10 �Ţ����¹              �� 9644-��ا෾��ҹ�� */ 
        wdetail.NAME_mkt     /* 11 �������˹�ҷ�� MKT     ����Ծ�ó� ���蹨Ե�  */ 
        wdetail.kkapp        /* kkapp A61-0335*/
        wdetail.remark        /*---add A64-0135 03/04/2021*/
        .
    wdetail.remark = TRIM(wdetail.remark) .       /*---add A64-0135 16/04/2021*/
END.                          /* repeat  */
FOR EACH wdetail .
    IF      INDEX(wdetail.notifyno,"�Ţ�Ѻ") <> 0   THEN DELETE wdetail.
    ELSE IF       wdetail.notifyno  =  " "          THEN DELETE wdetail.
END.
ASSIGN  nv_error   = 0     /*add kridtiya i. A55-0029 */
    nv_completecnt = 0 .  
Run  Create_tlt3.  
If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.
END.
ASSIGN 
    fi_completecnt  =  nv_completecnt 
    fi_error        =  nv_error - nv_completecnt   /*add kridtiya i. A55-0029 */
    nv_completecnt  =  0
    fi_impcnt       =  nv_reccnt .
Disp fi_completecnt  fi_impcnt fi_error with frame  fr_main.
Run Open_tlt.

Message "Load  Data Complete"  View-as alert-box.  
...end A65-0288...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_fcom C-Win 
PROCEDURE 00-pd_fcom :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0076 ...
DEF VAR nv_comchr AS CHAR INIT "".
DEF VAR nv_expchr AS CHAR INIT "".
DEF VAR nv_birchr AS CHAR INIT "".
DEF VAR nv_senchr AS CHAR INIT "".
DEF VAR nv_trnchr AS CHAR INIT "".
DEF VAR nv_saddr  AS CHAR INIT "".
DEF VAR nv_comcod AS CHAR INIT "".
DEF VAR nv_first AS CHAR INIT "".
def var n_text     as char format "x(255)" init "".
def var nv_icno3   as char format "x(15)" init "".
def var nv_lname3  as char format "x(45)" init "".
def var nv_cname3  as char format "x(45)" init "".
def var nv_tname3  as char format "x(20)" init "".
def var nv_icno2   as char format "x(15)" init "".
def var nv_lname2  as char format "x(45)" init "".
def var nv_cname2  as char format "x(45)" init "".
def var nv_tname2  as char format "x(20)" init "".
def var nv_icno1   as char format "x(15)" init "".
def var nv_lname1  as char format "x(45)" init "".
def var nv_cname1  as char format "x(45)" init "".
def var nv_tname1  as char format "x(20)" init "".
DEF VAR nv_Brancho  AS CHAR INIT "".
DEF VAR nv_dealero  AS CHAR INIT "". 
DEF VAR nv_campno   AS CHAR INIT "". 
DEF VAR nv_Seat     AS CHAR INIT "".
/* add by : A65-0288 */
def var  nv_ispno             as char no-undo init "".
def var  nv_ispappoit         as char no-undo init "".
def var  nv_ispupdate         as char no-undo init "".
def var  nv_isplocal          as char no-undo init "".
def var  nv_ispclose          as char no-undo init "".
def var  nv_ispresult         as char no-undo init "".
def var  nv_ispdam            as char no-undo init "".
def var  nv_ispacc            as char no-undo init "".
/* end : A65-0288 */
IF tlt.usrsent = "Y" AND tlt.lotno <> "Y" THEN NEXT.
ELSE DO:
    FIND trecid WHERE trecid.nrecid = RECID(tlt) NO-LOCK NO-ERROR.
    IF NOT AVAIL trecid THEN DO:
        CREATE trecid.
        trecid.nrecid = RECID(tlt).
    END.

    IF  tlt.ln_fst <> ?  THEN nv_first =  string(tlt.ln_fst).
    IF tlt.note30 <> "" THEN DO:
        ASSIGN
            nv_Brancho  = trim(substr(tlt.note30,1,100))
            nv_dealero  = trim(substr(tlt.note30,101,100)  ) 
            nv_campno   = trim(substr(tlt.note30,201,100)  )   NO-ERROR.
    END.
    
    RUN wuw\wuwppics3(INPUT TODAY,INPUT "COMP_CODE",OUTPUT nv_comcod).
    IF nv_comcod = "" THEN nv_comcod= "TMSTH".
    
    nv_ccom  = nv_ccom  + 1.
    IF tlt.note26  <> "" THEN nv_trnchr = tlt.note26 .
    ELSE IF tlt.ndate1  <> ? THEN  nv_trnchr = string(tlt.ndate1    ,"99/99/9999") .
    
    if tlt.nor_effdat <> ? then nv_comchr    = string(tlt.nor_effdat,"99/99/9999").   
    if tlt.expodat    <> ? then nv_expchr    = string(tlt.expodat   ,"99/99/9999").   
    IF tlt.gendat  <> ? THEN  nv_birchr   = STRING(tlt.gendat,"99/99/9999").
    IF tlt.datesent  <> ? THEN nv_senchr = STRING(tlt.datesent ,"99/99/9999").
    
    IF tlt.hrg_adddr <> "" THEN nv_saddr = tlt.hrg_adddr.
    ELSE DO:
        IF tlt.hrg_no   <> "" AND INDEX(tlt.hrg_no,"�Ţ���") = 0 THEN nv_saddr = "�Ţ��� " + tlt.hrg_no                              .
        IF tlt.hrg_moo  <> ""  THEN nv_saddr = nv_saddr + " ���� "  + tlt.hrg_moo                  .
        IF tlt.hrg_vill <> ""  THEN nv_saddr =  nv_saddr + " �Ҥ�� "    + tlt.hrg_vill             .
        IF tlt.hrg_floor <> "" THEN nv_saddr =  nv_saddr + " ��� "    + tlt.hrg_floor             .
        IF tlt.hrg_room  <> "" THEN nv_saddr =  nv_saddr + " ��ͧ "    + tlt.hrg_room              .
        IF tlt.hrg_soi   <> "" THEN nv_saddr   = nv_saddr + " ��� "    + tlt.hrg_soi               .
        IF tlt.hrg_street    <> "" THEN nv_saddr   = nv_saddr + " ��� "      + tlt.hrg_street      .
        IF tlt.hrg_district <> "" THEN do:  
            IF INDEX(tlt.hrg_prov,"��ا෾") <> 0  THEN nv_saddr  = nv_saddr + " �ǧ " + trim(tlt.hrg_district).
            ELSE nv_saddr  = nv_saddr + " �Ӻ� " + trim(tlt.hrg_district).
        end.
        IF tlt.hrg_subdistrict   <> "" THEN do:  
            IF INDEX(tlt.hrg_prov,"��ا෾") <> 0  THEN nv_saddr   = nv_saddr + " ࢵ " + trim(tlt.hrg_subdistrict).
            ELSE nv_saddr   = nv_saddr + " ����� " + trim(tlt.hrg_subdistrict).
        end.
        nv_saddr = trim(trim(nv_saddr + " " + tlt.hrg_prov) + " " + tlt.hrg_postcd ).
    END.
     
    /* comment by : A65-0288 ...
    ASSIGN
    n_text       = "" 
    n_text       = tlt.lince3.
    
    IF INDEX(n_text,"IC3:") <> 0 THEN
    ASSIGN
    nv_icno3     = SUBSTR(n_text,R-INDEX(n_text,"IC3:") + 4)         
    n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_icno3) + 4))
    nv_lname3    = SUBSTR(n_text,R-INDEX(n_text,"L3:") + 3)          
    n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_lname3) + 3))
    nv_cname3    = SUBSTR(n_text,R-INDEX(n_text,"N3:") + 3)          
    n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_cname3) + 3))
    nv_tname3    = SUBSTR(n_text,R-INDEX(n_text,"T3:") + 3)          
    n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_tname3) + 3)) NO-ERROR.
    IF INDEX(n_text,"IC2:") <> 0 THEN
    ASSIGN
    nv_icno2     = SUBSTR(n_text,R-INDEX(n_text,"IC2:") + 4)         
    n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_icno2) + 4))
    nv_lname2    = SUBSTR(n_text,R-INDEX(n_text,"L2:") + 3)          
    n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_lname2) + 3))
    nv_cname2    = SUBSTR(n_text,R-INDEX(n_text,"N2:") + 3)          
    n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_cname2) + 3))
    nv_tname2    = SUBSTR(n_text,R-INDEX(n_text,"T2:") + 3)         
    n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_tname2) + 3)) NO-ERROR.
    IF INDEX(n_text,"IC1:") <> 0 THEN
    ASSIGN
    nv_icno1     = SUBSTR(n_text,R-INDEX(n_text,"IC1:") + 4)         
    n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_icno1) + 4))
    nv_lname1    = SUBSTR(n_text,R-INDEX(n_text,"L1:") + 3)          
    n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_lname1) + 3))
    nv_cname1    = SUBSTR(n_text,R-INDEX(n_text,"N1:") + 3)          
    n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_cname1) + 3))
    nv_tname1    = SUBSTR(n_text,R-INDEX(n_text,"T1:") + 3)  NO-ERROR.
    ASSIGN
        nv_icno3   = trim(nv_icno3 ) 
        nv_lname3  = trim(nv_lname3) 
        nv_cname3  = trim(nv_cname3) 
        nv_tname3  = trim(nv_tname3) 
        nv_icno2   = trim(nv_icno2 ) 
        nv_lname2  = trim(nv_lname2) 
        nv_cname2  = trim(nv_cname2) 
        nv_tname2  = trim(nv_tname2) 
        nv_icno1   = trim(nv_icno1 ) 
        nv_lname1  = trim(nv_lname1) 
        nv_cname1  = trim(nv_cname1) 
        nv_tname1  = trim(nv_tname1) .
     ....end A65-0288...*/
    
    nv_Seat = "".
    IF tlt.noteveh1 = "21" THEN nv_Seat = "15".
    ELSE if tlt.noteveh1 = "22" THEN nv_Seat = "20".
    ELSE if tlt.noteveh1 = "23" THEN nv_Seat = "40".
    ELSE if tlt.noteveh1 = "24" THEN nv_Seat = "41".
    /* add by : A65-0288 */
    IF tlt.lotno = "Y" THEN DO:
        ASSIGN 
        nv_ispno     = trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  
        nv_ispclose  = trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Close Date:") + 12))
        nv_ispresult = IF index(tlt.mobile,"��¡�ä����������") <> 0 THEN trim(substr(tlt.mobile,1,index(tlt.mobile,"��¡�ä����������") - 2)) ELSE tlt.mobile
        nv_ispdam    = IF index(tlt.mobile,"��¡�ä����������") <> 0 THEN trim(substr(tlt.mobile,R-INDEX(tlt.mobile,"��¡�ä����������") + 17)) ELSE ""
        nv_ispacc    = brstat.tlt.fax  
        nv_ispappoit = ""    
        nv_ispupdate = ""    
        nv_isplocal  = ""  NO-ERROR.
    END.
    ELSE DO:
        ASSIGN 
        nv_ispno     = IF tlt.acno1 <> "" THEN trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  ELSE ""
        nv_ispupdate = IF tlt.acno1 <> "" THEN trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Edit Date:") + 10 )) ELSE "" 
        nv_ispupdate = IF index(nv_ispupdate," ") <> 0 THEN TRIM(SUBSTR(nv_ispupdate,1,R-INDEX(nv_ispupdate," "))) ELSE nv_ispupdate
        nv_ispappoit = tlt.mobile  
        nv_isplocal  = tlt.fax 
        nv_ispclose  = ""
        nv_ispresult = ""
        nv_ispdam    = ""
        nv_ispacc    = ""       NO-ERROR.
    END.
     /*....end A65-0288...*/
    
    OUTPUT TO VALUE(fi_kkcom) APPEND.
    EXPORT DELIMITER "|"
        nv_ccom
        nv_senchr
        IF tlt.dat_ins_not = ? THEN "" ELSE string(tlt.dat_ins_not,"99/99/9999") FORMAT "x(10)"         
        nv_comcod 
        tlt.nor_noti_tlt
        tlt.note5    /**/
        tlt.note25   /*tlt.nor_noti_ins */
        tlt.nor_usr_tlt  
        tlt.comp_usr_tl  
        nv_brancho
        tlt.comp_noti_tlt
        tlt.note4 
        ""
        ""
        tlt.ins_typ        
        tlt.ins_title  
        IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,1,r-INDEX(trim(tlt.ins_name)," ") - 1 )  ELSE tlt.ins_name
        IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,r-INDEX(trim(tlt.ins_name)," ") + 1 )  ELSE "" 
        tlt.ins_addr1              
        tlt.ins_addr2              
        tlt.ins_addr3              
        tlt.ins_addr4              
        tlt.ins_addr5              
        tlt.covcod
        tlt.stat
        nv_comchr  
        nv_expchr  
        tlt.subins 
        tlt.filler2
        tlt.brand       
        tlt.model       
        tlt.filler1     
        tlt.lince1   
        tlt.proveh   
        tlt.cha_no      
        tlt.eng_no      
        tlt.lince2      
        string(tlt.cc_weight ) 
        TRIM  (tlt.colorcod  ) 
        nv_Seat
        string(tlt.comp_coamt) 
        string(tlt.comp_grprm) 
        tlt.prem_amt /*tlt.note12*/
        string(tlt.gentim)
        tlt.buagent
        tlt.safe1 
        tlt.dri_name1  
        tlt.dri_no1
        tlt.dri_lic1
        tlt.dri_name2  
        tlt.dri_no2
        tlt.dri_lic2
        tlt.rec_title  
        IF INDEX(tlt.rec_name," ") <> 0 then substr(tlt.rec_name,1,r-INDEX(trim(tlt.rec_name)," ") - 1 ) else tlt.rec_name 
        IF INDEX(tlt.rec_name," ") <> 0 then substr(tlt.rec_name,r-INDEX(trim(tlt.rec_name)," ") + 1 ) else ""
        tlt.rec_addr1
        tlt.rec_addr2
        tlt.rec_addr3
        tlt.rec_addr4
        tlt.rec_addr5
        ""
        ""
        tlt.tel
        tlt.ins_icno
        IF tlt.gendat <> ? THEN  STRING(tlt.gendat,"99/99/9999") ELSE "" 
        tlt.ins_occ
        tlt.maritalsts
        tlt.sex           
        tlt.nationality   
        tlt.email
        tlt.rec_icno
        nv_tname1    
        nv_cname1    
        nv_lname1    
        nv_icno1     
        nv_tname2    
        nv_cname2    
        nv_lname2    
        nv_icno2     
        nv_tname3    
        nv_cname3    
        nv_lname3    
        nv_icno3     
        nv_saddr  
        tlt.hrg_cont  
        tlt.ben83 
        tlt.expotim                               
        tlt.OLD_eng                               
        trim(trim(tlt.OLD_cha) + " " +  tlt.note24) 
        tlt.usrid  
        nv_dealero
        nv_campno                                  
        ""                                   
        tlt.comp_sub                         
        tlt.recac              
        tlt.note2                            
        tlt.note3                            
        tlt.rider                            
        tlt.Releas                            
        nv_first  
        tlt.policy
        tlt.note28
        /* add by : A65-0288  07/10/2022  */
        tlt.lince3                                                                      
        tlt.usrsent                                                                                                                            
        tlt.lotno                                                              
        nv_ispno                                                                    
        if tlt.lotno = "Y" then nv_ispclose  else ""                                 
        if tlt.lotno = "Y" then nv_ispresult else nv_ispappoit                      
        if tlt.lotno = "Y" then nv_ispdam    else nv_ispupdate                 
        if tlt.lotno = "Y" then nv_ispacc    else nv_isplocal                  
        /* end : A65-0288  07/10/2022  */
        SKIP.
     
    OUTPUT CLOSE.
END.
...end : A67-0076...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_fcom_bk C-Win 
PROCEDURE 00-pd_fcom_bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0288...
DEF VAR nv_comchr AS CHAR INIT "".
DEF VAR nv_expchr AS CHAR INIT "".
DEF VAR nv_birchr AS CHAR INIT "".
DEF VAR nv_senchr AS CHAR INIT "".
DEF VAR nv_trnchr AS CHAR INIT "".
nv_ccom  = nv_ccom  + 1.
IF tlt.note26  <> "" THEN nv_trnchr = tlt.note26 .
ELSE IF tlt.ndate1  <> ? THEN  nv_trnchr = string(tlt.ndate1    ,"99/99/9999") .

if tlt.nor_effdat <> ? then nv_comchr    = string(tlt.nor_effdat,"99/99/9999").   
if tlt.expodat    <> ? then nv_expchr    = string(tlt.expodat   ,"99/99/9999").   
IF tlt.gendat  <> ? THEN  nv_birchr   = STRING(tlt.gendat,"99/99/9999").
IF tlt.datesent  <> ? THEN nv_senchr = STRING(tlt.datesent ,"99/99/9999").
OUTPUT TO VALUE(fi_kkcom) APPEND.
EXPORT DELIMITER "|"
nv_ccom
tlt.note1        
tlt.note2        
tlt.nor_usr_ins  
tlt.expotim      
tlt.note3        
tlt.note4        
tlt.note5        
nv_trnchr      
tlt.note6        
nv_comchr 
nv_expchr 
tlt.note7        
tlt.note8        
tlt.note9        
tlt.note10       
tlt.rider        
tlt.nor_noti_ins 
tlt.product      
tlt.pack         
tlt.packnme      
tlt.nor_usr_tlt  
tlt.comp_usr_tlt 
tlt.buagent      
tlt.rec_note1    
tlt.rec_icno     
tlt.rec_typ      
tlt.rec_title    
tlt.rec_name     
tlt.projnme      
tlt.rec_addr     
tlt.rec_addr1  
tlt.rec_addr2    
tlt.rec_addr3    
tlt.rec_addr4    
tlt.rec_cou      
tlt.rec_addr5    
tlt.cifno        
tlt.safe2        
tlt.ins_icno     
tlt.ins_typ      
tlt.ins_title    
tlt.ins_name     
nv_birchr
tlt.note11       
tlt.sex          
tlt.nationality  
tlt.maritalsts   
tlt.tel          
tlt.tel2         
tlt.tel3         
tlt.email        
tlt.ins_occ      
tlt.ins_bus      
tlt.ins_addr     
tlt.ins_addr1    
tlt.ins_addr2      
tlt.ins_addr3      
tlt.ins_addr4      
tlt.ins_cou        
tlt.ins_addr5      
tlt.hrg_adddr      
tlt.hrg_no         
tlt.hrg_moo        
tlt.hrg_vill       
tlt.hrg_floor      
tlt.hrg_room       
tlt.hrg_soi        
tlt.hrg_street     
tlt.hrg_district   
tlt.hrg_subdistrict
tlt.hrg_prov       
tlt.hrg_cou        
tlt.hrg_postcd     
tlt.hrg_cont       
tlt.hrg_tel        
tlt.bentyp         
tlt.ben83          
tlt.period         
tlt.comp_coamt     
tlt.comp_grprm     
tlt.rstp           
tlt.rtax           
tlt.prem_amt       
tlt.tax_coporate   
tlt.prem_amttcop   
tlt.note12        
tlt.note13        
tlt.note14        
tlt.note15        
tlt.note16        
tlt.note17        
tlt.note18        
tlt.note19        
tlt.note20        
tlt.note21        
tlt.note22        
tlt.note23        
tlt.safe1         
tlt.nor_noti_tlt  
tlt.ln_product    
tlt.ln_pronme     
tlt.ln_app        
tlt.ln_book       
tlt.ln_credit     
tlt.ln_st         
tlt.ln_amt        
tlt.ln_ins        
tlt.ln_rate       
tlt.ln_fst        
tlt.usrid         
tlt.comp_noti_tlt 
nv_senchr
tlt.safe3      
tlt.covcod     
tlt.subins     
tlt.vehuse     
tlt.brand      
tlt.model      
tlt.filler1    
tlt.lince1     
tlt.proveh     
tlt.cha_no     
tlt.eng_no     
tlt.lince2     
tlt.cc_weight  
tlt.colorcod   
tlt.noteveh1   
tlt.mileage    
tlt.stat       
tlt.filler2    
tlt.dri_lic1   
tlt.dri_name1  
tlt.dri_no1    
tlt.dri_lic2   
tlt.dri_name2  
tlt.dri_no2 
tlt.hclfg  
tlt.note24  
tlt.note25    SKIP.
OUTPUT CLOSE.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_hexp1 C-Win 
PROCEDURE 00-pd_hexp1 PRIVATE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0076 .....
OUTPUT TO VALUE(fi_kkcom). 
EXPORT DELIMITER "|" 
    "�ӴѺ���"                           
    "�ѹ����Ѻ��"                      
    "�ѹ����Ѻ�Թ������»�Сѹ"        
    "��ª��ͺ���ѷ��Сѹ���"             
    "�Ţ����ѭ����ҫ���"   
    "New/Renew"
    "�Ţ�������������"                 
    "�����Ң�"                           
    "�Ң� KK"   
    "�Ң� TMSTH"  
    "�Ţ�Ѻ���"
    "KK Offer Flag"
    "Campaign"                           
    "Sub Campaign"                       
    "�ؤ��/�ԵԺؤ��"                    
    "�ӹ�˹�Ҫ���"                       
    "���ͼ����һ�Сѹ"                   
    "���ʡ�ż����һ�Сѹ"                
    "��ҹ�Ţ���"                         
    "�Ӻ�/�ǧ"                          
    "�����/ࢵ"                          
    "�ѧ��Ѵ"                            
    "������ɳ���"                      
    "����������������ͧ"                
    "��������ë���"                     
    "�ѹ�����������ͧ"                  
    "�ѹ����ش������ͧ"                
    "����ö"                            
    "��������Сѹ���ö¹��"             
    "����������ö"                      
    "���ö"                            
    "New/Used"                          
    "�Ţ����¹"   
    "�ѧ��Ѵ������¹"
    "�Ţ��Ƕѧ"                         
    "�Ţ����ͧ¹��"                    
    "��ö¹��"                          
    "�ի�"                              
    "���˹ѡ/�ѹ"    
    "�����"
    "�ع��Сѹ�� 1 "   
    "�����ط��"
    "����������������ҡû� 1"          
   /* "�ع��Сѹ�� 2" 
    "�ع��Сѹö¹���٭���/����� ��2(F&T)" /*A60-0232*/
    "����������������ҡû� 2"     */     
    "�����Ѻ���"                      
    "�������˹�ҷ�� MKT"               
    "�����˵�"                          
    "���Ѻ����� 1     "
    "�ѹ�Դ���Ѻ��� 1 "
    "�Ţ���㺢Ѻ��� 1   "
    "���Ѻ����� 2     "
    "�ѹ�Դ���Ѻ��� 2 "
    "�Ţ���㺢Ѻ��� 2   "         
    "�ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)" 
    "���� (�����/㺡ӡѺ����)"         
    "���ʡ�� (�����/㺡ӡѺ����)"      
    "��ҹ�Ţ��� (�����/㺡ӡѺ����)"   
    "�Ӻ�/�ǧ (�����/㺡ӡѺ����)"    
    "�����/ࢵ (�����/㺡ӡѺ����)"    
    "�ѧ��Ѵ (�����/㺡ӡѺ����)"      
    "������ɳ��� (�����/㺡ӡѺ����)" 
    "��ǹŴ����ѵԴ�"                    
    "��ǹŴ�ҹ Fleet" 
    "����Դ��� "                 /*A60-0232*/
    "�Ţ���ѵû�ЪҪ�"            /*A60-0232*/
    "�ѹ��͹���Դ   "            /*A60-0232*/
    "�Ҫվ            "            /*A60-0232*/
    "ʶҹ�Ҿ          "            /*A60-0232*/
    "��              "
    "�ѭ�ҵ�          "
    "�������          "
    "�Ţ��Шӵ�Ǽ�����������ҡ�"   /*A60-0232*/
    "�ӹ�˹�Ҫ��� 1  "             /*A60-0232*/
    "���͡������ 1   "             /*A60-0232*/
    "���ʡ�š������ 1"             /*A60-0232*/
    "�Ţ���ѵû�ЪҪ�������� 1"   /*A60-0232*/
    "�ӹ�˹�Ҫ��� 2   "            /*A60-0232*/
    "���͡������ 2    "            /*A60-0232*/
    "���ʡ�š������ 2 "            /*A60-0232*/
    "�Ţ���ѵû�ЪҪ�������� 2"   /*A60-0232*/
    "�ӹ�˹�Ҫ��� 3   "            /*A60-0232*/
    "���͡������ 3    "            /*A60-0232*/
    "���ʡ�š������ 3 "            /*A60-0232*/
    "�Ţ���ѵû�ЪҪ�������� 3"   /*A60-0232*/
    "�Ѵ���͡��÷���Ң� "   /*A61-0335*/  
    "���ͼ���Ѻ�͡���    "   /*A61-0335*/  
    "����Ѻ�Ż���ª��    "   /*A61-0335*/  
    "KK ApplicationNo    "   /*A61-0335*/  
    "Remak1"                       
    "Remak2" 
    "Dealer KK"        /* A63-00472*/
    "Dealer TMSTH"
    "Campaign no TMSTH"
    "Campaign OV      "
    "Producer code"
    "Agent Code   "
    "ReferenceNo     "     
    "KK Quotation No."     
    "Rider  No.      "   
    "Release"       /* A56-0309 */  
    "Loan First Date"
    "Policy Premium"
    "Note Un Problem"
    /*add by : A65-0288 */
    "Color"
    "Inspection"                                                
    "Inspection status"                                         
    "Inspection No"                                             
    "Inspection Closed Date"                                         
    "Inspection Detail"                     
    "inspection Damage"            
    "inspection Accessory " 
    /* end : A65-0288 */
   SKIP .
OUTPUT CLOSE.
IF ra_filetyp = 5 THEN DO:
    OUTPUT TO VALUE(fi_kkhold). 
    EXPORT DELIMITER "|" 
        "�ӴѺ���"                           
        "�ѹ����Ѻ��"                      
        "�ѹ����Ѻ�Թ������»�Сѹ"        
        "��ª��ͺ���ѷ��Сѹ���"             
        "�Ţ����ѭ����ҫ���"   
        "New/Renew"
        "�Ţ�������������"                 
        "�����Ң�"                           
        "�Ң� KK"     
        "�Ң� TMSTH"  
        "�Ţ�Ѻ���" 
        "KK Offer Flag"
        "Campaign"                           
        "Sub Campaign"                       
        "�ؤ��/�ԵԺؤ��"                    
        "�ӹ�˹�Ҫ���"                       
        "���ͼ����һ�Сѹ"                   
        "���ʡ�ż����һ�Сѹ"                
        "��ҹ�Ţ���"                         
        "�Ӻ�/�ǧ"                          
        "�����/ࢵ"                          
        "�ѧ��Ѵ"                            
        "������ɳ���"                      
        "����������������ͧ"                
        "��������ë���"                     
        "�ѹ�����������ͧ"                  
        "�ѹ����ش������ͧ"                
        "����ö"                            
        "��������Сѹ���ö¹��"             
        "����������ö"                      
        "���ö"                            
        "New/Used"                          
        "�Ţ����¹"   
        "�ѧ��Ѵ������¹"
        "�Ţ��Ƕѧ"                         
        "�Ţ����ͧ¹��"                    
        "��ö¹��"                          
        "�ի�"                              
        "���˹ѡ/�ѹ"  
        "�����"
        "�ع��Сѹ�� 1 "   
        "�����ط��"
        "����������������ҡû� 1"          
     /*   "�ع��Сѹ�� 2" 
        "�ع��Сѹö¹���٭���/����� ��2(F&T)" /*A60-0232*/
        "����������������ҡû� 2"  */        
        "�����Ѻ���"                      
        "�������˹�ҷ�� MKT"               
        "�����˵�"                          
        "���Ѻ����� 1     "
        "�ѹ�Դ���Ѻ��� 1 "
        "�Ţ���㺢Ѻ��� 1   "
        "���Ѻ����� 2     "
        "�ѹ�Դ���Ѻ��� 2 "
        "�Ţ���㺢Ѻ��� 2   "        
        "�ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)" 
        "���� (�����/㺡ӡѺ����)"         
        "���ʡ�� (�����/㺡ӡѺ����)"      
        "��ҹ�Ţ��� (�����/㺡ӡѺ����)"   
        "�Ӻ�/�ǧ (�����/㺡ӡѺ����)"    
        "�����/ࢵ (�����/㺡ӡѺ����)"    
        "�ѧ��Ѵ (�����/㺡ӡѺ����)"      
        "������ɳ��� (�����/㺡ӡѺ����)" 
        "��ǹŴ����ѵԴ�"                    
        "��ǹŴ�ҹ Fleet" 
        "����Դ��� "                 /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�"            /*A60-0232*/
        "�ѹ��͹���Դ   "            /*A60-0232*/
        "�Ҫվ            "            /*A60-0232*/
        "ʶҹ�Ҿ          "            /*A60-0232*/
        "��              "
        "�ѭ�ҵ�          "
        "�������          "
        "�Ţ��Шӵ�Ǽ�����������ҡ�"   /*A60-0232*/
        "�ӹ�˹�Ҫ��� 1  "             /*A60-0232*/
        "���͡������ 1   "             /*A60-0232*/
        "���ʡ�š������ 1"             /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�������� 1"   /*A60-0232*/
        "�ӹ�˹�Ҫ��� 2   "            /*A60-0232*/
        "���͡������ 2    "            /*A60-0232*/
        "���ʡ�š������ 2 "            /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�������� 2"   /*A60-0232*/
        "�ӹ�˹�Ҫ��� 3   "            /*A60-0232*/
        "���͡������ 3    "            /*A60-0232*/
        "���ʡ�š������ 3 "            /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�������� 3"   /*A60-0232*/
        "�Ѵ���͡��÷���Ң� "   /*A61-0335*/  
        "���ͼ���Ѻ�͡���    "   /*A61-0335*/  
        "����Ѻ�Ż���ª��    "   /*A61-0335*/  
        "KK ApplicationNo    "   /*A61-0335*/  
        "Remak1"                       
        "Remak2" 
        "Dealer"        /* A63-00472*/
        "Dealer TMSTH"  
        "Campaign no TMSTH"
        "Campaign OV      "
        "Producer code"
        "Agent Code   "
        "ReferenceNo     "     
        "KK Quotation No."     
        "Rider  No.      "    
        "Release"       /* A56-0309 */   
        "Loan First Date"
        "Policy Premium"
        "Note Un Problem"
        /*add by : A65-0288 */
        "Color"
        "Inspection"                                                
        "Inspection status"                                         
        "Inspection No"                                             
        "Inspection Closed Date"                                         
        "Inspection Detail / Inspection Update"                     
        "inspection Damage/ Inspection Appiontment Date"            
        "inspection Accessory / Inspection Appiontment Location" 
        /* end : A65-0288 */
       SKIP .
    OUTPUT CLOSE.
END.
ELSE IF ra_filetyp = 6 THEN DO:
    OUTPUT TO VALUE(fi_kkhold). 
    EXPORT DELIMITER "|"
   " NO.                "
   " Insurer Name       "
   " Product Name       "
   " Package            "
   " New/Renew          "
   " KK Offer Flag      "
   " KK Application No. "
   " KK Quotation No.   "
   " Rider No.          "
   " Source Uniq ID     "
   " Loan Contract No.  "
   " Notified No.       "
   " Notified Date      "
   " Payer Name         "
   " Insured Name       "
   " Insured Phone No 1 "
   " Insured Phone No 2 "
   " Insured Phone No 3 "
   " Agent Code         "
   " Branch             "
   " BU/RC              "
   " Net Premium        "
   " Stamp              "
   " Vat                "
   " Gross Premium      "
   " Problem Date       "
   " Problem ID         "
   " Problem Description"
   " Problem Flag       "
   " Policy Problem Flag"
   " Response Problem Date"
   " Response Problem Description"
   " Remark"
   " STATUS " 
   " Policy "
   " Claim flag "
   " Problem flag "
   SKIP .
   OUTPUT CLOSE.

END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt2 C-Win 
PROCEDURE create_tlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0288...
LOOP_wdetail:
FOR EACH wdetail :
    ASSIGN  nv_error   = nv_error + 1.     /*add kridtiya i. A55-0029 */
    IF wdetail.notifyno <> ""  THEN DO:
        FIND FIRST tlt    WHERE 
            tlt.comp_noti_tlt  = wdetail.notifyno   AND
            tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
        IF AVAIL tlt THEN DO:  
            IF index(tlt.OLD_eng,"HOLD") = 0          THEN DO:
                nv_completecnt  =  nv_completecnt + 1.
                ASSIGN  tlt.trndat     = fi_loaddat
                        tlt.OLD_eng    = "HOLD" +  SUBSTR(fi_FileName,(R-INDEX(fi_FileName,"\") + 1 )).
             /*   /*---Begin by Chaiyong W. A64-0135 03/04/2021*/
                ASSIGN
                    tlt.note24          = trim(wdetail.remark)
                     tlt.hclfg          = "Y".
                /*End by Chaiyong W. A64-0135 03/04/2021-----*/*/
            END.
            ELSE MESSAGE "�� �Ţ�Ѻ���: " wdetail.notifyno "�ЧѺ������º�������� " tlt.OLD_eng VIEW-AS ALERT-BOX.
        END.
        ELSE DO:
            MESSAGE "��辺 �Ţ�Ѻ��駹��: " wdetail.notifyno " ��к� TLT " VIEW-AS ALERT-BOX.
        END.
    END.
    /* create by A61-0335*/
    ELSE DO:
         FIND FIRST tlt    WHERE 
            tlt.expotim    = wdetail.kkapp     AND
            tlt.genusr     = "kk"                 NO-ERROR NO-WAIT .
        IF AVAIL tlt THEN DO:  
            IF index(tlt.OLD_eng,"HOLD") = 0          THEN DO:
                nv_completecnt  =  nv_completecnt + 1.
                ASSIGN  tlt.trndat     = fi_loaddat
                        tlt.OLD_eng    = "HOLD" +  SUBSTR(fi_FileName,(R-INDEX(fi_FileName,"\") + 1 )).
           /*     /*---Begin by Chaiyong W. A64-0135 03/04/2021*/
                ASSIGN
                    tlt.note24          = trim(wdetail.remark)
                     tlt.hclfg          = "Y".
                /*End by Chaiyong W. A64-0135 03/04/2021-----*/*/
            END.
            ELSE MESSAGE "�� �Ţ�Ѻ���: " wdetail.notifyno "�ЧѺ������º�������� " tlt.OLD_eng VIEW-AS ALERT-BOX.
        END.
        ELSE DO:
            MESSAGE "��辺 �Ţ�Ѻ��駹��: " wdetail.notifyno " ��к� TLT " VIEW-AS ALERT-BOX.
        END.
    END.
    /* end  A61-0335 */
END.   
Run Open_tlt.
...end A65-0288...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt4 C-Win 
PROCEDURE create_tlt4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A65-0288     
------------------------------------------------------------------------------*/
RUN proc_head.
LOOP_wcancel:
FOR EACH wcancel :
    ASSIGN  nv_reccnt   = nv_reccnt + 1 . 
    IF wcancel.Notified <> "" AND wcancel.kkapp <> ""  THEN DO:
        FIND FIRST tlt    WHERE 
            tlt.comp_noti_tlt    = wcancel.Notified AND 
            tlt.expotim          = wcancel.kkapp    AND 
            tlt.genusr           = "kk"             NO-ERROR NO-WAIT .
        IF AVAIL tlt THEN DO:  
            nv_completecnt  =  nv_completecnt + 1.
             IF tlt.releas = "NO" THEN DO:
                ASSIGN  
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "NO/CA"
                    tlt.OLD_eng  = "CANCEL_POL " + wcancel.Cdate + " ���˵�: " + trim(wcancel.CreasonDesc) + " " + TRIM(wcancel.remark)  
                    wcancel.polno = tlt.policy
                    wcancel.releas = tlt.releas
                    wcancel.sts = "Complete".
             END.
             ELSE IF tlt.releas = "YES" THEN DO:
                ASSIGN  
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "YES/CA"
                    tlt.OLD_eng  = "CANCEL_POL " + wcancel.Cdate + " ���˵�: " + trim(wcancel.CreasonDesc) + " " + TRIM(wcancel.remark) 
                    wcancel.polno = tlt.policy
                    wcancel.releas = tlt.releas
                    wcancel.sts = "Complete".
             END.
             ELSE DO: 
                 ASSIGN wcancel.sts = "¡��ԡ�Ţ�Ѻ��� ��� KKApp. �����к����� : " +  wcancel.Notified + "/" + wcancel.kkapp 
                        wcancel.polno = tlt.policy
                        wcancel.releas = tlt.releas .
             END.
        END.
        ELSE DO:
            nv_error = nv_error + 1 .
            ASSIGN wcancel.sts = "��辺 �Ţ�Ѻ��� ���KKApp. �����к� : " +  wcancel.Notified + " / " + wcancel.kkapp .
        END.
    END.
    ELSE IF wcancel.Notified <> "" THEN DO:
        FIND FIRST tlt    WHERE 
            tlt.comp_noti_tlt    = wcancel.Notified AND 
            tlt.genusr           = "kk"             NO-ERROR NO-WAIT .
        IF AVAIL tlt THEN DO:  
            nv_completecnt  =  nv_completecnt + 1.
             IF tlt.releas  = "NO" THEN DO:
                ASSIGN  
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "NO/CA"
                    tlt.OLD_eng  = "CANCEL_POL " + wcancel.Cdate + " ���˵�: " + trim(wcancel.CreasonDesc) + " " + TRIM(wcancel.remark) 
                    wcancel.polno = tlt.policy
                    wcancel.releas = tlt.releas
                    wcancel.sts = "Complete".
             END.
             ELSE IF tlt.releas = "YES" THEN DO:
                ASSIGN  
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "YES/CA"
                    tlt.OLD_eng  = "CANCEL_POL " + wcancel.Cdate + " ���˵�: " + trim(wcancel.CreasonDesc) + " " + TRIM(wcancel.remark) 
                    wcancel.polno = tlt.policy
                    wcancel.releas = tlt.releas
                    wcancel.sts = "Complete".
             END.
             ELSE DO: 
                 ASSIGN  wcancel.sts =  "¡��ԡ�Ţ�Ѻ��駹����к����� : " +  wcancel.Notified 
                         wcancel.polno = tlt.policy
                         wcancel.releas = tlt.releas .
             END.
        END.
        ELSE DO:
            nv_error = nv_error + 1 .
            ASSIGN wcancel.sts =  "��辺 �Ţ�Ѻ��駹����к� : " +  wcancel.Notified .
        END.

    END.
    ELSE IF wcancel.kkapp <> "" THEN DO:
        FIND FIRST tlt    WHERE 
            tlt.expotim    = wcancel.kkapp     AND
            tlt.genusr     = "kk"                 NO-ERROR NO-WAIT .
        IF AVAIL tlt THEN DO:  
            nv_completecnt  =  nv_completecnt + 1.
             IF tlt.releas = "NO" THEN DO:
                ASSIGN  
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "NO/CA"
                    tlt.OLD_eng  = "CANCEL_POL " + wcancel.Cdate + " ���˵�: " + trim(wcancel.CreasonDesc) + " " + TRIM(wcancel.remark)
                    wcancel.polno = tlt.policy
                    wcancel.releas = tlt.releas
                    wcancel.sts = "Complete".
                    
             END.
             ELSE IF tlt.releas = "YES" THEN DO:
                ASSIGN  
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "YES/CA"
                    tlt.OLD_eng  = "CANCEL_POL " + wcancel.Cdate + " ���˵�: " + trim(wcancel.CreasonDesc) + " " + TRIM(wcancel.remark) 
                    wcancel.polno = tlt.policy
                    wcancel.releas = tlt.releas
                    wcancel.sts = "Complete".
                   
             END.
             ELSE DO: 
                 ASSIGN wcancel.sts =  "¡��ԡ�Ţ KKApp. �����к����� : " +  wcancel.kkapp 
                        wcancel.polno = tlt.policy
                        wcancel.releas = tlt.releas .
             END.
        END.
        ELSE DO:
            nv_error = nv_error + 1 .
            ASSIGN wcancel.sts = "��辺 �Ţ KKApp. �����к� : " +  wcancel.kkapp .
        END.
    END.
    ELSE DO:
        FIND FIRST tlt    WHERE 
            tlt.cha_no       = trim(wcancel.chassis)     AND
            tlt.nor_noti_tlt = TRIM(wcancel.LoanContract) AND
            tlt.genusr       = "kk"                 NO-ERROR NO-WAIT .
        IF AVAIL tlt THEN DO:  
            nv_completecnt  =  nv_completecnt + 1.
             IF tlt.releas = "NO" THEN DO:
                ASSIGN  
                   /* 17/11/2022
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "NO/CA"                                                                                              
                   tlt.OLD_eng  = "CANCEL_POL " + wcancel.Cdate + " ���˵�: " + trim(wcancel.CreasonDesc) + " " + TRIM(wcancel.remark) */
                    wcancel.polno  = tlt.policy
                    wcancel.releas = tlt.releas
                    wcancel.sts = "���Ţ��Ƕѧ ����Ţ����ѭ�ҹ����к�".
             END.
             ELSE IF tlt.releas = "YES" THEN DO:
                ASSIGN  
                    /* 17/11/2022
                    tlt.trndat   = fi_loaddat
                    tlt.releas   = "YES/CA"
                    tlt.OLD_eng  = "CANCEL_POL " + wcancel.Cdate + " ���˵�: " + trim(wcancel.CreasonDesc) + " " + TRIM(wcancel.remark) */
                    wcancel.polno = tlt.policy
                    wcancel.releas = tlt.releas
                    wcancel.sts  = "���Ţ��Ƕѧ ����Ţ����ѭ�ҹ����к� ".
             END.
             ELSE DO: 
                 ASSIGN wcancel.sts   = "¡��ԡ�Ţ��Ƕѧ ����Ţ����ѭ�ҹ����к����� : " +  wcancel.chassis + "/" + wcancel.LoanContract 
                        wcancel.polno = tlt.policy
                        wcancel.releas = tlt.releas .
             END.
        END.
        ELSE DO:
            nv_error = nv_error + 1 .
            ASSIGN wcancel.sts = "��辺 �Ţ��Ƕѧ ����Ţ����ѭ�ҹ����к����� : " +  wcancel.chassis + "/" + wcancel.LoanContract.
        END.
    END.
    RUN pd_fca.
END.   /* FOR EACH wcancel NO-LOCK: */
Run Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltnew C-Win 
PROCEDURE create_tltnew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN pd_hexp1.
RUN pd_hexp2.
LOOP_wdetail:                                 
FOR EACH wdetail  :   
     
   
    IF wdetail.reci_addno <> ""  THEN DO:
        IF INDEX(wdetail.reci_addno,"�Ţ�") <> 0 THEN wdetail.reci_addno = wdetail.reci_addno.
        ELSE wdetail.reci_addno = "�Ţ��� " + wdetail.reci_addno.
    END.
    IF wdetail.reci_addmu      <> "" THEN DO:
        IF INDEX(wdetail.reci_addmu,"����") <> 0 THEN wdetail.reci_addno      = wdetail.reci_addno + " "  + wdetail.reci_addmu.
        ELSE wdetail.reci_addno      = wdetail.reci_addno + " ���� "  + wdetail.reci_addmu.
        wdetail.reci_addmu      = "".
    END.
    IF wdetail.reci_addbuild   <> "" THEN DO:
        IF INDEX(wdetail.reci_addbuild,"�Ҥ��") <> 0 THEN wdetail.reci_addno + " "    + wdetail.reci_addbuild.
        ELSE wdetail.reci_addno      =  wdetail.reci_addno + " �Ҥ�� "    + wdetail.reci_addbuild.
        wdetail.reci_addbuild   =  "".
    END.
    IF wdetail.floor       <> "" THEN DO:
        IF INDEX(wdetail.floor,"���") <> 0 THEN wdetail.reci_addno      =  wdetail.reci_addno + " "    + wdetail.floor.
        ELSE wdetail.reci_addno      =  wdetail.reci_addno + " ��� "    + wdetail.floor.
        wdetail.floor       =  "".
    END.
    IF wdetail.room        <> "" THEN DO:
        IF INDEX(wdetail.room,"��ͧ") <> 0 THEN wdetail.reci_addno      =  wdetail.reci_addno + " "    + wdetail.room .
        ELSE wdetail.reci_addno      =  wdetail.reci_addno + " ��ͧ "    + wdetail.room .
        wdetail.room        =  "".
    END.
    IF wdetail.reci_addsoy     <> "" THEN DO:
        IF INDEX(wdetail.reci_addsoy,"���") <> 0 THEN wdetail.reci_addno   = wdetail.reci_addno + " "      + wdetail.reci_addsoy    .
        ELSE wdetail.reci_addno   = wdetail.reci_addno + " ��� "      + wdetail.reci_addsoy    .   
        wdetail.reci_addsoy  = "".  
    END.
    IF wdetail.reci_addroad    <> "" THEN DO:
        IF INDEX(wdetail.reci_addroad,"���") <> 0 THEN wdetail.reci_addno   = wdetail.reci_addno + " "      + wdetail.reci_addroad   .
        ELSE wdetail.reci_addno   = wdetail.reci_addno + " ��� "      + wdetail.reci_addroad   .
        wdetail.reci_addroad  = "".  
    END.
        
        
        /*
    IF wdetail.reci_addtambon <> "" THEN do:  
        wdetail.reci_addtambon = trim(wdetail.reci_addtambon).
        IF INDEX(wdetail.ADD_country,"��ا෾") <> 0 OR  INDEX(wdetail.ADD_country,"���") <> 0 THEN wdetail.reci_addtambon  = "�ǧ " + trim(wdetail.reci_addtambon).
        ELSE wdetail.reci_addtambon  = "�Ӻ� " + trim(wdetail.reci_addtambon).
    end.
    IF wdetail.reci_addamper   <> "" THEN do:  
        wdetail.reci_addamper   = trim(wdetail.reci_addamper).   
        IF INDEX(wdetail.ADD_country,"��ا෾") <> 0 OR  INDEX(wdetail.ADD_country,"���") <> 0 THEN wdetail.reci_addamper   = "ࢵ " + trim(wdetail.reci_addamper).
        ELSE wdetail.reci_addamper   = "����� " + trim(wdetail.reci_addamper).
    end.
    IF wdetail.ADD_country <> "" THEN DO:
        IF INDEX(wdetail.ADD_country,"��ا෾") <> 0 OR  INDEX(wdetail.ADD_country,"���") <> 0 THEN DO:

        END.
        ELSE wdetail.ADD_country = "�ѧ��Ѵ " +  wdetail.ADD_country.
    END.*/

    IF wdetail.TAddressNo <> ""  THEN DO:
        IF INDEX(wdetail.TAddressNo,"�Ţ�") <> 0 THEN wdetail.TAddressNo = wdetail.TAddressNo.
        ELSE wdetail.TAddressNo = "�Ţ��� " + wdetail.TAddressNo.
    END.
    IF wdetail.TMoo      <> "" THEN DO:
        IF INDEX(wdetail.TMoo,"����") <> 0 THEN wdetail.TAddressNo      = wdetail.TAddressNo + " "  + wdetail.TMoo.
        ELSE wdetail.TAddressNo      = wdetail.TAddressNo + " ���� "  + wdetail.TMoo.
        wdetail.TMoo      = "".
    END.
    IF wdetail.TVillageBuilding   <> "" THEN DO:
        IF INDEX(wdetail.TVillageBuilding,"�Ҥ��") <> 0 THEN wdetail.TAddressNo + " "    + wdetail.TVillageBuilding.
        ELSE wdetail.TAddressNo      =  wdetail.TAddressNo + " �Ҥ�� "    + wdetail.TVillageBuilding.
        wdetail.TVillageBuilding   =  "".
    END.
    IF wdetail.TFloor       <> "" THEN DO:
        IF INDEX(wdetail.TFloor,"���") <> 0 THEN wdetail.TAddressNo      =  wdetail.TAddressNo + " "    + wdetail.TFloor.
        ELSE wdetail.TAddressNo      =  wdetail.TAddressNo + " ��� "    + wdetail.TFloor.
        wdetail.TFloor       =  "".
    END.
    IF wdetail.TRoomNumber        <> "" THEN DO:
        IF INDEX(wdetail.TRoomNumber,"��ͧ") <> 0 THEN wdetail.TAddressNo      =  wdetail.TAddressNo + " "    + wdetail.TRoomNumber .
        ELSE wdetail.TAddressNo      =  wdetail.TAddressNo + " ��ͧ "    + wdetail.TRoomNumber .
        wdetail.TRoomNumber        =  "".
    END.
    IF wdetail.TSoi     <> "" THEN DO:
        IF INDEX(wdetail.TSoi,"���") <> 0 THEN wdetail.TAddressNo   = wdetail.TAddressNo + " "      + wdetail.TSoi    .
        ELSE wdetail.TAddressNo   = wdetail.TAddressNo + " ��� "      + wdetail.TSoi    .   
        wdetail.TSoi  = "".  
    END.
    IF wdetail.TStreet    <> "" THEN DO:
        IF INDEX(wdetail.TStreet,"���") <> 0 THEN wdetail.TAddressNo   = wdetail.TAddressNo + " "      + wdetail.TStreet   .
        ELSE wdetail.TAddressNo   = wdetail.TAddressNo + " ��� "      + wdetail.TStreet   .
        wdetail.TStreet  = "".  
    END.

 /*
    IF wdetail.TSubDistrict <> "" THEN do:  
        wdetail.TSubDistrict = trim(wdetail.TSubDistrict).
        IF INDEX(wdetail.TProvince,"��ا෾") <> 0 OR  INDEX(wdetail.ADD_country,"���") <> 0 THEN wdetail.TSubDistrict  = "�ǧ " + trim(wdetail.TSubDistrict).
        ELSE wdetail.TSubDistrict  = "�Ӻ� " + trim(wdetail.TSubDistrict).
    end.
    IF wdetail.TDistrict   <> "" THEN do:  
        wdetail.TDistrict   = trim(wdetail.TDistrict).   
        IF INDEX(wdetail.TProvince,"��ا෾") <> 0 OR  INDEX(wdetail.ADD_country,"���") <> 0  THEN wdetail.TDistrict   = "ࢵ " + trim(wdetail.TDistrict).
        ELSE wdetail.TDistrict   = "����� " + trim(wdetail.TDistrict).
    end.

    IF wdetail.TProvince <> "" THEN DO:
        IF INDEX(wdetail.TProvince,"��ا෾") <> 0 OR  INDEX(wdetail.TProvince,"���") <> 0 THEN DO:
    
        END.
        ELSE wdetail.TProvince = "�ѧ��Ѵ " +  wdetail.TProvince.
    END. 

    */
    /* Ranu I. A67-0195 */
    IF trim(wdetail.kkst) = "��Сѹ���á��ǧ�Թ���� (New)" AND index(wdetail.product,"�Ҥ�ѧ�Ѻ (�.�.�.)") <> 0 THEN DO:
       FIND  LAST tlt    WHERE 
                tlt.note3   = trim(wdetail.quo)  AND  /*5   KK Quotation No   */
                tlt.genusr  = "kk"               NO-ERROR NO-WAIT .
            IF NOT AVAIL tlt THEN DO:              
                nv_completecnt  =  nv_completecnt + 1.
                CREATE tlt.
                RUN create_tltnew2(INPUT "Create").
            END.
            ELSE DO:
               ASSIGN
                  tlt.comp_noti_tlt  = trim(wdetail.notifyno)
                  tlt.expotim        = trim(wdetail.kkapp) .

               nv_completecnt  =  nv_completecnt + 1.
               IF tlt.releas <> "No" OR tlt.policy <> "" THEN DO:
                   IF tlt.note1 = "" AND tlt.note2 = "" THEN DO:
                       IF tlt.comp_noti_tlt  = "" AND wdetail.notifyno <> "" THEN   tlt.comp_noti_tlt  = wdetail.notifyno.
                       IF tlt.expotim = "" AND wdetail.kkapp  <> "" THEN tlt.expotim        = wdetail.kkapp .
                   END.
               END.
               ELSE DO:
                   RUN create_tltnew2(INPUT "Update").
               END.
            END.
    END.
    /* end A67-0195 */
    ELSE DO:
        wdetail.notifyno  = trim(wdetail.notifyno   ).
        wdetail.kkapp     = trim(wdetail.kkapp      ).
        IF wdetail.notifyno  <> "" AND wdetail.kkapp  <> "" THEN DO:
            FIND  LAST tlt    WHERE 
                tlt.comp_noti_tlt  = wdetail.notifyno   AND
                tlt.genusr         = "kk"               NO-LOCK NO-ERROR NO-WAIT .
            IF NOT AVAIL tlt THEN DO:  
                FIND  LAST  tlt    WHERE 
                    tlt.expotim        = wdetail.kkapp      AND
                    tlt.genusr         = "kk"               NO-LOCK NO-ERROR NO-WAIT .
                IF NOT AVAIL tlt THEN DO:  
                    nv_completecnt  =  nv_completecnt + 1.
                    CREATE tlt.
                    
                    ASSIGN
                         tlt.comp_noti_tlt  = wdetail.notifyno
                         tlt.expotim        = wdetail.kkapp .
                    RUN create_tltnew2(INPUT "Create").
                END.
                ELSE DO:
                    FIND  LAST tlt     WHERE 
                        tlt.expotim        = wdetail.kkapp   AND
                        tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
                        IF AVAIL tlt THEN DO:
                            nv_completecnt  =  nv_completecnt + 1.
                            IF tlt.releas <> "No" OR tlt.policy <> "" THEN DO:
                                IF tlt.note1 = "" AND tlt.note2 = "" THEN DO:
                                    IF tlt.comp_noti_tlt  = "" AND wdetail.notifyno <> "" THEN   tlt.comp_noti_tlt  = wdetail.notifyno.
                                    IF tlt.expotim = "" AND wdetail.kkapp  <> "" THEN tlt.expotim        = wdetail.kkapp .
                                END.
                            END.
                            ELSE DO:
                                
                                RUN create_tltnew2(INPUT "Update").
                            END.
                        END.
        
                END.
            END.
            ELSE DO:
                FIND  LAST tlt     WHERE 
                tlt.comp_noti_tlt  = wdetail.notifyno   AND
                tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
                IF AVAIL tlt THEN DO:
                    nv_completecnt  =  nv_completecnt + 1.
                    IF tlt.releas <> "No" OR tlt.policy <> "" THEN DO:
                        IF tlt.note1 = "" AND tlt.note2 = "" THEN DO:
                            IF tlt.comp_noti_tlt  = "" AND wdetail.notifyno <> "" THEN   tlt.comp_noti_tlt  = wdetail.notifyno.
                            IF tlt.expotim = "" AND wdetail.kkapp   <>   "" THEN tlt.expotim        = wdetail.kkapp .
                        END.
                        RUN pd_report.
                    END.
                    ELSE DO:
                        
                        RUN create_tltnew2(INPUT "Update").
                    END.
                END.
            END.
        END.
        ELSE IF wdetail.notifyno  <> "" THEN DO:
            FIND  LAST tlt    WHERE 
                tlt.comp_noti_tlt  = wdetail.notifyno    AND
                tlt.genusr         = "kk"               NO-LOCK NO-ERROR NO-WAIT .
            IF NOT AVAIL tlt THEN DO:  
                nv_completecnt  =  nv_completecnt + 1.
                CREATE tlt.
                ASSIGN
                     tlt.comp_noti_tlt  = wdetail.notifyno
                     tlt.expotim        = wdetail.kkapp .
                RUN create_tltnew2(INPUT "Create").
            END.
            ELSE DO:
                FIND  LAST tlt    WHERE 
                tlt.comp_noti_tlt  = wdetail.notifyno    AND
                tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
                IF AVAIL tlt THEN DO:
                    nv_completecnt  =  nv_completecnt + 1.
                    IF tlt.releas <> "No" OR tlt.policy <> "" THEN DO:
                        IF tlt.note1 = "" AND tlt.note2 = ""  THEN DO:
                            IF tlt.comp_noti_tlt  = "" AND wdetail.notifyno <> "" THEN   tlt.comp_noti_tlt  = wdetail.notifyno.
                            IF tlt.expotim = "" AND wdetail.kkapp   <>  "" THEN tlt.expotim        = wdetail.kkapp .
                        END.
                        RUN pd_report.
                    END.
                    ELSE DO:
                        RUN create_tltnew2(INPUT "Update").
                    END.
                END.
            END.
        END.
        ELSE DO:
            FIND  LAST  tlt    WHERE 
                tlt.expotim        = wdetail.kkapp      AND
                tlt.genusr         = "kk"               NO-LOCK NO-ERROR NO-WAIT .
            IF NOT AVAIL tlt THEN DO:    
                nv_completecnt  =  nv_completecnt + 1.
                CREATE tlt.
                
                ASSIGN
                     tlt.comp_noti_tlt  = wdetail.notifyno
                     tlt.expotim        = wdetail.kkapp .
                
                RUN create_tltnew2(INPUT "Create").
            END.
            ELSE DO:
               FIND  LAST tlt    WHERE 
                    tlt.expotim        = wdetail.kkapp      AND
                    tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
                IF AVAIL tlt THEN DO:
                    nv_completecnt  =  nv_completecnt + 1.
                    IF tlt.releas <> "No" OR tlt.policy <> "" THEN DO:
                        IF tlt.note1 = "" AND tlt.note2 = "" THEN DO:
                            IF tlt.comp_noti_tlt  = "" AND wdetail.notifyno <> "" THEN   tlt.comp_noti_tlt  = wdetail.notifyno.
                            IF tlt.expotim = "" AND wdetail.kkapp  <>  "" THEN tlt.expotim        = wdetail.kkapp .
                        END.
        
        
                        RUN pd_report.
                    END.
                    ELSE DO:
                        RUN create_tltnew2(INPUT "Update").
                    END.
                END.
            END.
        END.
    END. /*A67-0195*/
    RELEASE tlt NO-ERROR.
   
/*     IF tlt.hclf = "Y" THEN RUN pd_fprob. */
    /*ELSE RUN pd_fcom.*/

END.
RELEASE tlt NO-ERROR.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltnew2 C-Win 
PROCEDURE create_tltnew2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_update AS CHAR INIT "".
DEF VAR nv_recdat AS DATE INIT ?.
DEF VAR nv_deci AS DECI INIT 0.
ASSIGN
        tlt.entdat          = TODAY
        tlt.enttim          = STRING(TIME,"HH:MM:SS")
        tlt.trntime         = STRING(TIME,"HH:MM:SS")
        tlt.trndat          = fi_loaddat
        tlt.note1           = wdetail.sdate                        /*1*/
        tlt.note2           = wdetail.uniqsource                   /*2   Uniq ID Source System*/     
        tlt.nor_usr_ins     = wdetail.comp_code                    /*3   ��ª��ͺ���ѷ��Сѹ���  */             
        tlt.expotim         = wdetail.KKapp                        /*4   KK App                  */
        tlt.note3           = wdetail.quo                          /*5   KK Quotation No   */
        tlt.note4           = wdetail.offerf                       /*6   KK Offer Flag     */
        tlt.note5           = wdetail.kkst                .        /*7   New/Renew         */
        tlt.ndate1          = DATE(wdetail.trndat)   NO-ERROR.     /*8   Transaction Date  */
ASSIGN  tlt.note26          = wdetail.trndat
        tlt.note6           = wdetail.appdat              .        /*9   Application Date  */
        tlt.nor_effdat      = date(wdetail.comdat)     no-error.   /*10  �ѹ�����������ͧ    */      
        tlt.expodat         = date(wdetail.expdat)     no-error.   /*11  �ѹ����ش������ͧ  */      
ASSIGN  tlt.note7           = wdetail.insapp                       /*12  Insurer Application No.         */
        tlt.note8           = wdetail.insquo .                      /*13  Insurer Quotation No.           */
IF wdetail.poltyp <> "" THEN tlt.note9  = wdetail.poltyp.   /*14  Policy Type                     */
ASSIGN  tlt.note10          = wdetail.mapp                         /*15  Main App No                     */
        tlt.rider           = wdetail.rid                          /*16  Rider No                        */
        tlt.nor_noti_ins    = wdetail.prepol.                       /*17   �Ţ�������������  */
IF wdetail.product  <> ""  THEN   tlt.product   = wdetail.product    .                  /*18  Product Name               */
        tlt.pack            = wdetail.pack   .              /*19  Package Code               */
IF wdetail.packnme <> ""  THEN tlt.covcod = wdetail.packnme     .                 /*20  Package Name               */
ASSIGN
        tlt.nor_usr_tlt     = wdetail.cmbr_no                      /*21  Branch                     */                           
        tlt.comp_usr_tlt    = wdetail.cmbr_code                    /*22  BU/RC                      */       
        tlt.buagent         = wdetail.buagent                      /*23  Agent                      */
        tlt.rec_note1       = wdetail.payidtyp                     /*24  Payer ID Card Type           */
        tlt.rec_icno        = wdetail.taxno                        /*25  Payer ID Card No             */
        tlt.rec_typ         = wdetail.paytyp                       /*26  Payer Type                   */
        tlt.rec_title       = wdetail.reci_title                   /*27  �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)*/ 
        tlt.rec_name        = wdetail.reci_name1                   /*28  ���� (�����/㺡ӡѺ����)        */ 
        tlt.projnme         = wdetail.projnme                      /*29  Project Name*/
        tlt.rec_addr        = wdetail.reci_address                 /*30  Address_Receipt*/ 
        tlt.rec_addr1       = wdetail.reci_addno                   /*31  ��ҹ�Ţ��� (�����/㺡ӡѺ����)  */
                            + wdetail.reci_addmu                   /*32  �����ҹ (�����/㺡ӡѺ����)    */ 
                            + wdetail.reci_addbuild                /*33  �Ҥ�� (�����/㺡ӡѺ����)       */ 
                            + wdetail.floor                        /*34  Floor_Receipt         */
                            + wdetail.room                         /*35  RoomNumber_Receipt    */
                            + wdetail.reci_addsoy                  /*36  ��� (�����/㺡ӡѺ����)  */
                            + wdetail.reci_addroad                 /*37  ��� (�����/㺡ӡѺ����)   */            
        tlt.rec_addr2       = wdetail.reci_addtambon               /*38  �Ӻ�/�ǧ (�����/㺡ӡѺ����) */        
        tlt.rec_addr3       = wdetail.reci_addamper                /*39  �����/ࢵ (�����/㺡ӡѺ����) */        
        tlt.rec_addr4       = wdetail.reci_addcounty               /*40  �ѧ��Ѵ (�����/㺡ӡѺ����)   */  
        tlt.rec_cou         = wdetail.reci_addcty                  /*41  �����*/
        tlt.rec_addr5       = wdetail.reci_addpost                 /*42  ������ɳ��� (�����/㺡ӡѺ����)*/    
        tlt.cifno           = wdetail.cifno                        /*43  Cif No*/
        tlt.safe2           = wdetail.typper                       /*44  �ؤ��/�ԵԺؤ�� */                     
        tlt.ins_icno        = wdetail.icno                         /*45  */
        tlt.ins_typ         = wdetail.instyp                       /*46  */
        tlt.ins_title       = wdetail.n_TITLE                      /*47  �ӹ�˹�Ҫ���    */         
        tlt.ins_name        = wdetail.n_name1               .      /*48  ���ͼ����һ�Сѹ    */                  
        tlt.gendat       = date(wdetail.bdate    )  NO-ERROR  .      /*49  Insured Birthdate      */  
ASSIGN  tlt.note11          = wdetail.age                         /*50  Insured Age            */  
        tlt.sex             = wdetail.gender                      /*51  Insured Gender         */  
        tlt.nationality     = wdetail.nat                         /*52  Insured Nationality    */  
        tlt.maritalsts      = wdetail.cstatus                     /*53  Insured MaritalStatus  */  
        tlt.tel             = wdetail.tel1                        /*54  Insured Telephone 1    */  
        tlt.tel2            = wdetail.tel2                        /*55  Insured Telephone 2    */  
        tlt.tel3            = wdetail.tel3                        /*56  Insured Telephone 3    */  
        tlt.email           = wdetail.email                       /*57  Insured Email          */  
        tlt.ins_occ         = wdetail.occup                       /*58  Insured Occupation     */  
        tlt.ins_bus         = wdetail.insbus                      /*59  Insured BusinessType   */  
        tlt.ins_addr        = wdetail.TAddress                    /*60  Tax_Address            */     
        tlt.ins_addr1       = wdetail.TAddressNo                  /*61  Tax_AddressNo           */       
                            + wdetail.TMoo                        /*62  Tax_Moo                 */       
                            + wdetail.TVillageBuilding            /*63  Tax_VillageBuilding     */       
                            + wdetail.TFloor                      /*64  Tax_Floor               */       
                            + wdetail.TRoomNumber                 /*65  Tax_RoomNumber          */       
                            + wdetail.TSoi                        /*66  Tax_Soi                 */       
                            + wdetail.TStreet                     /*67  Tax_Street              */       
        tlt.ins_addr2       = wdetail.TSubDistrict                /*68  �Ӻ�/�ǧ*/                     
        tlt.ins_addr3       = wdetail.TDistrict                   /*69  �����/ࢵ*/                     
        tlt.ins_addr4       = wdetail.TProvince                   /*70  �ѧ��Ѵ*/  
        tlt.ins_cou         = wdetail.TCountry                    /*71  Country*/
        tlt.ins_addr5       = wdetail.TZipCode                    /*72  ������ɳ���*/ 
        tlt.hrg_adddr       = wdetail.caddress                    /*73  Contact_Address                   */    
        tlt.hrg_no          = wdetail.ADD_no                      /*74  Contact_AddressNo                 */    
        tlt.hrg_moo         = wdetail.ADD_mu                      /*75  Contact_Moo                       */    
        tlt.hrg_vill        = wdetail.ADD_muban                   /*76  Contact_VillageBuilding           */    
        tlt.hrg_floor       = wdetail.ADD_floor                   /*77  Contact_Floor                     */    
        tlt.hrg_room        = wdetail.ADD_room                    /*78  Contact_RoomNumber                */    
        tlt.hrg_soi         = wdetail.ADD_soy                     /*79  Contact_Soi                       */    
        tlt.hrg_street      = wdetail.ADD_road                    /*80  Contact_Street                    */    
        tlt.hrg_district    = wdetail.ADD_thambon                 /*81  Contact_SubDistrict               */    
        tlt.hrg_subdistrict = wdetail.ADD_amper                   /*82  Contact_District                  */    
        tlt.hrg_prov        = wdetail.ADD_country                 /*83  Contact_Province                  */    
        tlt.hrg_cou         = wdetail.ADD_cty                     /*84  Contact_Country                   */    
        tlt.hrg_postcd      = wdetail.ADD_post                    /*85  Contact_ZipCode                   */    
        tlt.hrg_cont        = wdetail.sendname                    /*86  Contact Person                    */    
        tlt.hrg_tel         = wdetail.ADD_tel                     /*87  Contact Telephone                 */    
        tlt.bentyp          = wdetail.bentyp                      /*88  BeneficiaryType                   */    
        tlt.ben83           = wdetail.benname                     /*89  BeneficiaryName                   */    
        tlt.period          = wdetail.period       .              /*90  Payment Period                    */    
        tlt.comp_coamt      = deci(wdetail.ins_amt1) no-error.    /*91  �ع��Сѹ�� 1   */     
        tlt.comp_grprm      = deci(wdetail.prem1)    no-error.    /*92  Net Premium (Yearly)    */  
        tlt.rstp            = deci(wdetail.ostp    ) no-error.    /*93  Stamp Premium (Yearly)  */  
        tlt.rtax            = deci(wdetail.otax    ) no-error.    /*94  Vat Premium (Yearly)    */  
        tlt.prem_amt        = deci(wdetail.prem2   ) no-error.    /*95  Gross Premium (Yearly)  */  
        tlt.tax_coporate    = deci(wdetail.whtprem ) no-error.    /*96  WHT Premium (Yearly)    */  
        tlt.prem_amttcop    = deci(wdetail.premamt ) no-error.    /*97  Premium Amount (Yearly) */  
ASSIGN  tlt.note12          = wdetail.foprem                      /*98  Net Premium (First Installment)      */    
        tlt.note13          = wdetail.fostp                       /*99  Stamp Premium (First Installment)    */    
        tlt.note14          = wdetail.fotax                       /*100 Vat Premium (First Installment)      */    
        tlt.note15          = wdetail.fprem1                      /*101 Gross Premium (First Installment)    */    
        tlt.note16          = wdetail.fwhtprem                    /*102 WHT Premium (First Installment)      */    
        tlt.note17          = wdetail.fpremamt                    /*103 Premium Amount (First Installment)   */    
        tlt.note18          = wdetail.noprem                      /*104 Net Premium (Next Installment)       */    
        tlt.note19          = wdetail.nostp                       /*105 Stamp Premium (Next Installment)     */    
        tlt.note20          = wdetail.notax                       /*106 Vat Premium (Next Installment)       */    
        tlt.note21          = wdetail.nprem1                      /*107 Gross Premium (Next Installment)     */    
        tlt.note22          = wdetail.nwhtprem                    /*108 WHT Premium (Next Installment)       */    
        tlt.note23          = wdetail.npremamt                    /*109 Premium Amount (Next Installment)    */    
        tlt.safe1           = wdetail.bennam                     /*110 Remark                               */                          
        tlt.nor_noti_tlt    = wdetail.cedpol                     /*111 �Ţ����ѭ����ҫ��� */                 
        tlt.ln_product      = wdetail.LProductCode                /*112 LoanProductCode      */   
        tlt.ln_pronme       = wdetail.LProductName                /*113 LoanProductName      */   
        tlt.ln_app          = wdetail.LApproveDate                /*114 LoanApproveDate      */   
        tlt.ln_book         = wdetail.LBookDate                   /*115 LoanBookDate         */   
        tlt.ln_credit       = wdetail.LCreditLine                 /*116 LoanCreditLine       */   
        tlt.ln_st           = wdetail.LStatus                     /*117 LoanStatus           */   
        tlt.ln_amt          = wdetail.LInstallmentAMT             /*118 LoanInstallmentAMT   */   
        tlt.ln_ins          = wdetail.LInstallment                /*119 LoanInstallment      */   
        tlt.ln_rate         = wdetail.LRate                       /*120 LoanRate             */   
        tlt.ln_fst          = wdetail.LFirstDueDate               /*121 LoanFirstDueDate     */   
        tlt.usrid           = wdetail.dealer                      /*122 Dealer*/
        tlt.comp_noti_tlt   = wdetail.notifyno   .                /*123 �Ţ�Ѻ��� */      
IF INDEX(wdetail.Notify_dat," ") <> 0 THEN DO:
        tlt.datesent        = date(trim(SUBSTR(wdetail.Notify_dat,1,INDEX(wdetail.Notify_dat," ")))) NO-ERROR.  /*124 �ѹ����Ѻ��   */  
        tlt.gentim          = trim(SUBSTR(wdetail.Notify_dat,INDEX(wdetail.Notify_dat," "))) NO-ERROR.
END.
ELSE ASSIGN tlt.datesent    = date(wdetail.Notify_dat)
        tlt.gentim          = "" NO-ERROR.
ASSIGN  tlt.safe3           = wdetail.covtyp                      /*125 ��������Ѿ���Թ*/
        tlt.note27          = wdetail.subcov    .                  /*126 ���������·�Ѿ���Թ */     
IF wdetail.subclass <> "" THEN tlt.subins          = wdetail.subclass .                   /*127 ����ö*/
IF wdetail.vehuse   <> "" THEN tlt.vehuse          = wdetail.vehuse   .                   /*128 ������ö*/
ASSIGN  tlt.brand           = wdetail.brand                       /*129 ����������ö    */                        
        tlt.model           = wdetail.model                       /*130 ���ö  */                                
        tlt.filler1         = wdetail.nSTATUS                     /*131 New/Used    */                            
       /* tlt.lince1          = wdetail.licence */ /*A67-0198*/    /*132 �Ţ����¹  */ 
       /* tlt.proveh          = wdetail.prolice */ /*A67-0198*/    /*133 �ѧ��Ѵ����͡�Ţ����¹*/
        tlt.lince1          = IF    trim(wdetail.prolice) <> "N/A" THEN  wdetail.licence 
                              ELSE IF LENGTH(wdetail.chassis)  > 9 THEN "/" + substr(trim(wdetail.chassis),LENGTH(trim(wdetail.chassis)) - 9 ) 
                              ELSE "/" + trim(wdetail.chassis) /*A67-0198*/    /*132 �Ţ����¹  */ 
        tlt.proveh          = IF    trim(wdetail.prolice) <> "N/A" THEN wdetail.prolice ELSE ""   /*A67-0198*/    /*133 �ѧ��Ѵ����͡�Ţ����¹*/
        tlt.cha_no          = wdetail.chassis                     /*134 �Ţ��Ƕѧ   */                            
        tlt.eng_no          = wdetail.engine                      /*135 �Ţ����ͧ¹��  */                        
        tlt.lince2          = wdetail.cyear       .               /*136 ��ö¹��    */  
nv_deci = 0.
nv_deci = deci(wdetail.power)     NO-ERROR. 
IF nv_deci <> 0 THEN tlt.cc_weight = nv_deci.  /*137 �ի�    */  
nv_deci = 0.
nv_deci = deci(wdetail.weight)     NO-ERROR. 
IF nv_deci <> 0 THEN tlt.colorcod        = wdetail.weight  .                    /*138 ���˹ѡ/�ѹ */    
IF wdetail.dcar     <> "" THEN tlt.noteveh1        = wdetail.dcar    .   
        tlt.mileage         = DECI(wdetail.mile)      NO-ERROR.         /*140 �Ţ���� (��.)*/  
ASSIGN  tlt.stat            = wdetail.garage                       /*141 ��������ë���   */                        
        tlt.filler2         = wdetail.n_43                         /*142 ��������Сѹ���ö¹��   */      
        tlt.dri_lic1        = wdetail.drilic1                     /*143   �Ţ㺢Ѻ��� 1         */               
        tlt.dri_name1       = wdetail.name1                       /*144   ���Ѻ����� 1        */               
        tlt.dri_no1         = wdetail.drivno1                     /*145   �ѹ�Դ���Ѻ����� 1 */               
        tlt.dri_lic2        = wdetail.drilic2                     /*146   �Ţ㺢Ѻ��� 2         */               
        tlt.dri_name2       = wdetail.name2                       /*147   ���Ѻ����� 2        */               
        tlt.dri_no2         = wdetail.drivno2                     /*148   �ѹ�Դ���Ѻ����� 2 */                
        tlt.flag            = "N"       /*---only R----*/               /*check prepol if found = "R" else = "N" */
        tlt.comp_sub        = fi_producer 
        tlt.recac           = fi_agent   
        tlt.genusr          = fi_compano 
        tlt.endno           = USERID(LDBNAME(1))                 /*User Load Data */
        tlt.imp             = "IM"                               /*Import Data    */
        tlt.releas          = "NO"  
    /*  add : A65-0288 */
        tlt.lince3          = trim(wdetail.colors) .
    IF nv_update = "Create"  THEN tlt.usrsent = IF index(tlt.covcod,"�Ҥ�ѧ�Ѻ") <> 0  THEN "N" ELSE trim(wdetail.inpection) .
    /*  end : A65-0288*/ 
    RUN create_tltnew2-1 . /* A67-0076 */
    
    IF wdetail.remark <> "" THEN DO:  
        IF tlt.note24  <> "" THEN DO:
            tlt.note24          = tlt.note24 + "," + wdetail.remark.
        END.
        ELSE tlt.note24          =  wdetail.remark.
    END.
    IF wdetail.stp = "" THEN DO:

        IF tlt.note29 = "Y" THEN DO:
        END.
        ELSE tlt.note29 = "N". /*Not Problem*/
    END.
    ELSE DO:
        IF wdetail.stp <> tlt.note29 THEN DO:
            IF wdetail.stp = "N" THEN tlt.note29 = "N".
            ELSE tlt.note29 = "Y".
        END.
    END.

    RUN create_tltnew4.
    nv_recdat = DATE(wdetail.recive_dat) NO-ERROR.
    IF nv_recdat <> ? THEN DO:
        tlt.dat_ins_not = nv_recdat.
    END.
    ELSE IF wdetail.hcf = "N" AND tlt.dat_ins_not = ? THEN do:
        IF tlt.ln_fst  <> "" THEN tlt.dat_ins_not = date(tlt.ln_fst) NO-ERROR.
        IF  tlt.dat_ins_not = ? THEN tlt.dat_ins_not = TODAY.
    END.
    IF tlt.hclfg  = wdetail.hcf  AND  tlt.hclfg = "N" THEN DO: 
    END.
    ELSE DO:
        tlt.hclfg           = wdetail.hcf .
        IF tlt.hclfg   = "" THEN  tlt.hclfg  = "Y".
        IF tlt.OLD_eng = "" AND   tlt.hclfg  = "Y"      THEN tlt.OLD_eng = "HOLD" +  SUBSTR(fi_FileName,(R-INDEX(fi_FileName,"\") + 1 )).
        ELSE IF tlt.OLD_eng = "" AND  tlt.hclfg  = "N"  THEN tlt.OLD_eng = "COVER".
        ELSE DO:
            IF tlt.hclfg  = "Y" THEN tlt.OLD_eng  = "HOLD" +  SUBSTR(fi_FileName,(R-INDEX(fi_FileName,"\") + 1 )).
            ELSE IF index(tlt.OLD_eng,"CANCEL_HOLD") = 0 THEN tlt.OLD_eng   = "CANCEL_HOLD" +  SUBSTR(tlt.OLD_eng,(INDEX(tlt.OLD_eng,"Hold") + 4 )). 
        END.
    END.
    RUN create_tltnew3.
    RUN proc_chkinsp. /* A65-0288*/
    RUN pd_report.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltnew2-1 C-Win 
PROCEDURE create_tltnew2-1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    tlt.hp            = DECI(wdetail.hp)                
    tlt.dri_title1    = wdetail.drititle1         
    tlt.dri_gender1   = wdetail.drigender1        
    tlt.dir_occ1      = "OCCUP:" + wdetail.drioccup1 + " " +     
                        "TOCC:"  + wdetail.driToccup1        
    tlt.dri_ic1       = "TIC:"   + wdetail.driTicono1 + " " +        
                        "ICNO:"  + wdetail.driICNo1          
    tlt.dri_title2    = wdetail.drititle2         
    tlt.dri_gender2   = wdetail.drigender2        
    tlt.dri_occ2      = "OCCUP:" + wdetail.drioccup2  + " " +       
                        "TOCC:"  + wdetail.driToccup2        
    tlt.dri_ic2       = "TIC:"   + wdetail.driTicono2 + " " +       
                        "ICNO:"  + wdetail.driICNo2          
    tlt.dri_lic3      = wdetail.drilic3           
    tlt.dri_title3    = wdetail.drititle3         
    tlt.dri_name3     = wdetail.driname3          
    tlt.dri_no3       = wdetail.drivno3           
    tlt.dri_gender3   = wdetail.drigender3        
    tlt.dir_occ3      = "OCCUP:" + wdetail.drioccup3  + " " +       
                        "TOCC:"  + wdetail.driToccup3        
    tlt.dri_ic3       = "TIC:"   + wdetail.driTicono3 + " " +       
                        "ICNO:"  + wdetail.driICNo3          
    tlt.dri_lic4      = wdetail.drilic4           
    tlt.dri_title4    = wdetail.drititle4         
    tlt.dri_name4     = wdetail.driname4          
    tlt.dri_no4       = wdetail.drivno4           
    tlt.dri_gender4   = wdetail.drigender4        
    tlt.dri_occ4      = "OCCUP:" +  wdetail.drioccup4   + " " +      
                        "TOCC:"  +  wdetail.driToccup4        
    tlt.dri_ic4       = "TIC:"   +  wdetail.driTicono4  + " " +      
                        "ICNO:"  +  wdetail.driICNo4          
    tlt.dri_lic5      = wdetail.drilic5           
    tlt.dri_title5    = wdetail.drititle5         
    tlt.dri_name5     = wdetail.driname5          
    tlt.dri_no5       = wdetail.drivno5           
    tlt.dri_gender5   = wdetail.drigender5        
    tlt.dri_occ5      = "OCCUP:" +  wdetail.drioccup5 + " " +         
                        "TOCC:"  +  wdetail.driToccup5        
    tlt.dri_ic5       = "TIC:"   +  wdetail.driTicono5 + " " +       
                        "ICNO:"  +  wdetail.driICNo5          
    tlt.paydate1      = IF wdetail.dateregis  <> "" THEN DATE(wdetail.dateregis) ELSE ?        
    tlt.paytype       = wdetail.pay_option        
    tlt.battno        = wdetail.battno            
    tlt.battyr        = wdetail.battyr           
    tlt.maksi         = deci(wdetail.maksi)             
    tlt.chargno       = wdetail.chargno           
    tlt.noteveh2      = wdetail.veh_key  .
    
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltnew3 C-Win 
PROCEDURE create_tltnew3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_trareg AS CHAR INIT "".
DEF VAR nv_poltyp AS CHAR INIT "".
DEF VAR nv_acnoa  AS CHAR INIT "".
DEF VAR nv_f  AS CHAR INIT "".
DEF VAR nv_f2 AS CHAR INIT "".
DEF VAR nv_tltbra   AS CHAR INIT "".
DEF VAR nv_tltdea   AS CHAR INIT "".

DEF VAR nv_tltbra2  AS CHAR INIT "".
DEF VAR nv_tltdea2  AS CHAR INIT "".
IF trim(substr(tlt.note30,1,200)) = "" AND trim(tlt.note25) = "" THEN nv_f2 = "Y".
IF trim(wdetail.brancho)   <> "" THEN tlt.note30 = trim(wdetail.brancho)    + FILL(" ",100 - LENGTH(wdetail.brancho))          + SUBSTR(tlt.note30,101) .
IF TRIM(wdetail.dealero)   <> "" THEN tlt.note30 = SUBSTR(tlt.note30,1,100) + FILL(" ",100 - LENGTH(SUBSTR(tlt.note30,1,100))) + trim(wdetail.dealero)  + FILL(" ",100 - LENGTH(wdetail.dealero)) + SUBSTR(tlt.note30,201,100).
IF TRIM(wdetail.campaigno) <> "" THEN tlt.note30 = SUBSTR(tlt.note30,1,200) + FILL(" ",200 - LENGTH(SUBSTR(tlt.note30,1,200))) + trim(wdetail.campaigno).

IF TRIM(wdetail.prepol)  <> "" THEN DO: 
   IF  tlt.note25 <> wdetail.prepol THEN DO:
       ASSIGN
           nv_tltbra = trim(SUBSTR(tlt.note30,1,100))
           nv_tltdea = trim(SUBSTR(tlt.note30,101,100))
           nv_tltbra2 = nv_tltbra 
           nv_tltdea2 = nv_tltdea. 

       nv_f = "".
       IF  CONNECTED ("sic_exp") THEN DO:
           RUN wgw\wgwqpex2(INPUT wdetail.prepol,
                            INPUT-OUTPUT nv_tltbra ,
                            INPUT-OUTPUT nv_tltdea ,
                            INPUT-OUTPUT nv_f).
           
       END.
       IF   nv_f = "" THEN DO:
            FIND LAST sicuw.uwm100 WHERE uwm100.policy = wdetail.prepol NO-LOCK NO-ERROR.
             IF AVAIL sicuw.uwm100 THEN DO:
                  nv_f = "Y".
                 IF nv_tltbra = "" THEN DO:
                     nv_tltbra = uwm100.branch.
                     IF uwm100.branch = "ML" THEN nv_tltbra = "�ӹѡ�ҹ�˭�".
                     ELSE RUN wgw\wgwqbrkk(INPUT-OUTPUT nv_tltbra).
                 END.
                 IF nv_tltdea  = "" THEN DO:
                     nv_tltdea  = uwm100.finint.
                 END.
           END.             
       END.
       IF nv_f = "Y" THEN DO:
           tlt.note25 = wdetail.prepol.

           IF nv_tltbra2 = "" and nv_tltbra  <> "" THEN tlt.note30 = trim(nv_tltbra) + FILL(" ",100 - LENGTH(nv_tltbra)) + SUBSTR(tlt.note30,101) .
           IF nv_tltdea2 = "" and nv_tltdea  <> "" THEN tlt.note30 = SUBSTR(tlt.note30,1,100) + FILL(" ",100 - LENGTH(SUBSTR(tlt.note30,1,100))) + nv_tltdea   + FILL(" ",100 - LENGTH(nv_tltdea )) + SUBSTR(tlt.note30,201,100) .
       END.
   END.
END.
IF trim(tlt.note25) = "" AND nv_f = "" AND nv_f2 = "Y" THEN DO:
    IF INDEX(wdetail.packnme,"�.�.�.") <> 0 OR INDEX(wdetail.packnme,"�Ҥ�") <> 0 OR INDEX(wdetail.packnme,"�ú.") <> 0  THEN nv_poltyp  = "V72".
    ELSE nv_poltyp = "V70".
    nv_trareg = tlt.cha_no.
    RUN wuw\WUWCHASS(INPUT-OUTPUT nv_trareg).
    ASSIGN
       nv_tltbra = trim(SUBSTR(tlt.note30,1,100))
       nv_tltdea = trim(SUBSTR(tlt.note30,101,100))
       nv_tltbra2 = nv_tltbra 
       nv_tltdea2 = nv_tltdea. 


    IF CONNECTED ("sic_exp") THEN DO:
    
        RUN wgw\wgwqpexp(input wdetail.kkst            ,
                         input nv_poltyp               ,
                         input tlt.nor_effdat          ,
                         INPUT tlt.cha_no              ,
                         input nv_trareg               ,
                         input wdetail.prepol          ,
                         input-output nv_tltbra  ,
                         input-output nv_tltdea  ,
                         input-output nv_f             ,
                         input-output tlt.note25).
        IF nv_f <> "" THEN tlt.flag   = "R".
    END.
    
    IF NOT CONNECTED ("sic_exp") OR nv_f = "" THEN DO:
        IF index(wdetail.kkst,"RENEW") <> 0 THEN DO:
            IF nv_trareg <> "" THEN DO:
                FIND LAST sicuw.uwm301 WHERE uwm301.trareg     = nv_trareg  NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm301 THEN DO:
                    loop_veh:
                    FOR EACH sicuw.uwm301 WHERE uwm301.trareg     = nv_trareg    /*AND
                                          SUBSTR(uwm301.policy,3,2) = nv_poltyp */      NO-LOCK BY uwm301.policy DESC
                                                                                         BY uwm301.policy:
                        FIND LAST sicuw.uwm100 WHERE uwm100.policy = uwm301.policy AND
                                               uwm100.rencnt = uwm301.rencnt AND
                                               uwm100.endcnt = uwm301.endcnt NO-LOCK NO-ERROR.
                        IF AVAIL uwm100 THEN DO:
                            IF  uwm100.renpol = "" AND uwm100.polsta = "IF" AND uwm100.poltyp = nv_poltyp THEN DO:
                                IF year(tlt.nor_effdat) = YEAR(uwm100.expdat) OR year(tlt.nor_effdat) = (YEAR(uwm100.expdat) + 1)  THEN DO:
                                    ASSIGN
                                    tlt.flag   = "R"
                                    tlt.note25 = uwm100.policy
                                    nv_f   = "Y".
                                    IF nv_tltbra  = "" THEN DO:
                                        nv_tltbra  = uwm100.branch.
                                        IF uwm100.branch = "ML" THEN  nv_tltbra = "�ӹѡ�ҹ�˭�".
                                        ELSE RUN wgw\wgwqbrkk(INPUT-OUTPUT nv_tltbra).
                                    END.
                                    IF nv_tltdea = "" THEN DO:
                                        nv_tltdea = uwm100.finint.
                                    END.
                                    LEAVE loop_veh.
                                END.
                
                            END.
                        END.
                    END.
                END.
              
                IF nv_f = "" THEN DO:
                    FIND LAST sicuw.uwm301 WHERE uwm301.cha_no    = nv_trareg  NO-LOCK NO-ERROR.
                    IF AVAIL sicuw.uwm301 THEN DO:
                        loop_veh2:
                        FOR EACH sicuw.uwm301 WHERE uwm301.cha_no       = nv_trareg   /* AND
                                              SUBSTR(uwm301.policy,3,2) = nv_poltyp */       NO-LOCK BY uwm301.policy DESC
                                                                                             BY uwm301.policy:
                            FIND LAST sicuw.uwm100 WHERE uwm100.policy = uwm301.policy AND
                                                   uwm100.rencnt = uwm301.rencnt AND
                                                   uwm100.endcnt = uwm301.endcnt NO-LOCK NO-ERROR.
                            IF AVAIL uwm100 THEN DO:
                                IF  uwm100.renpol = "" AND uwm100.polsta = "IF" AND uwm100.poltyp = nv_poltyp THEN DO:
                                    IF year(tlt.nor_effdat) = YEAR(uwm100.expdat) OR year(tlt.nor_effdat) = (YEAR(uwm100.expdat) + 1)  THEN DO:
                                        ASSIGN
                                        tlt.flag   = "R"
                                        tlt.note25 = uwm100.policy
                                        nv_f   = "Y".
                                        IF nv_tltbra = "" THEN DO:
                                            nv_tltbra = uwm100.branch.
                                            IF uwm100.branch = "ML" THEN nv_tltbra = "�ӹѡ�ҹ�˭�".
                                            ELSE RUN wgw\wgwqbrkk(INPUT-OUTPUT nv_tltbra).
                                        END.
                                        IF nv_tltdea = "" THEN DO:
                                            nv_tltdea = uwm100.finint.
                                        END.
                                        LEAVE loop_veh2.
                                    END.
                    
                                END.
                            END.
                        END.
        
                    END.
                END.
                IF nv_f = "" THEN DO:
                    FIND LAST  sicuw.uwm301 WHERE uwm301.cha_no       = tlt.cha_no  NO-LOCK NO-ERROR.
                    IF AVAIL sicuw.uwm301 THEN DO:
                        loop_veh3:
                        FOR EACH sicuw.uwm301 WHERE uwm301.cha_no       = tlt.cha_no  /* AND
                                              SUBSTR(uwm301.policy,3,2) = nv_poltyp   */    NO-LOCK BY uwm301.policy DESC
                                                                                             BY uwm301.policy:
                            FIND LAST sicuw.uwm100 WHERE uwm100.policy = uwm301.policy AND
                                                   uwm100.rencnt = uwm301.rencnt AND
                                                   uwm100.endcnt = uwm301.endcnt NO-LOCK NO-ERROR.
                            IF AVAIL uwm100 THEN DO:
                                IF  uwm100.renpol = "" AND uwm100.polsta = "IF" AND uwm100.poltyp = nv_poltyp THEN DO:
                                    IF year(tlt.nor_effdat) = YEAR(uwm100.expdat) OR year(tlt.nor_effdat) = (YEAR(uwm100.expdat) + 1)  THEN DO:
                                        ASSIGN
                                        tlt.flag   = "R"
                                        tlt.note25 = uwm100.policy
                                        nv_f   = "Y".
                                        IF nv_tltbra = "" THEN DO:
                                            nv_tltbra = uwm100.branch.
                                            IF uwm100.branch = "ML" THEN nv_tltbra = "�ӹѡ�ҹ�˭�".
                                            ELSE RUN wgw\wgwqbrkk(INPUT-OUTPUT nv_tltbra).
                                        END.
                                        IF nv_tltdea = "" THEN DO:
                                            nv_tltdea = uwm100.finint.
                                        END.
                                        LEAVE loop_veh3.
                                    END.
                    
                                END.
                            END.
                        END.
                    END.
                END.
            END.
        END.  
       /* IF wdetail.prepol <> "" AND nv_f = "" THEN DO:
            ASSIGN
                tlt.flag   = "R"
                tlt.note25 = wdetail.prepol .
             FIND LAST sicuw.uwm100 WHERE uwm100.policy = tlt.note25 NO-LOCK NO-ERROR.
             IF AVAIL sicuw.uwm100 THEN DO:
                 IF nv_tltbra = "" THEN DO:
                     nv_tltbra = uwm100.branch.
                     IF uwm100.branch = "ML" THEN nv_tltbra = "�ӹѡ�ҹ�˭�".
                     ELSE RUN wgw\wgwqbrkk(INPUT-OUTPUT nv_tltbra).
                 END.
                 IF nv_tltdea = "" THEN DO:
                     nv_tltdea = uwm100.finint.
                 END.
             END.
        END.*/
    END.
    IF nv_tltbra2 = "" and nv_tltbra  <> "" THEN tlt.note30 = trim(nv_tltbra) + FILL(" ",100 - LENGTH(nv_tltbra)) + SUBSTR(tlt.note30,101) .
    IF nv_tltdea2 = "" and nv_tltdea  <> "" THEN tlt.note30 = SUBSTR(tlt.note30,1,100)  + FILL(" ",100 - LENGTH(SUBSTR(tlt.note30,1,100) )) + nv_tltdea   + FILL(" ",100 - LENGTH(nv_tltdea )) + SUBSTR(tlt.note30,201).
END.
IF tlt.note25 = "" THEN tlt.note25 = wdetail.prepol.

IF INDEX(tlt.note5,"Renew") <> 0 THEN DO:
        nv_acnoa = "B3MLKK0101".
END.
ELSE IF tlt.note5 <> "" AND tlt.note5 <> "Single" THEN DO:
    IF tlt.subins = "230" AND INDEX(tlt.vehuse,"�����") <> 0 AND
        INDEX(tlt.vehuse,"�Ѻ��ҧ�Ҹ��") <> 0  THEN DO:
        nv_acnoa = "B3MLKK0103".
    END.        
    ELSE IF tlt.subins = "610"  AND INDEX(tlt.vehuse,"�ѡ��ҹ¹��") <> 0 AND
        INDEX(tlt.vehuse,"�ؤ��") <> 0 THEN DO:
        nv_acnoa = "B3MLKK0104".
    END.
    ELSE IF INDEX(tlt.filler1,"New") <> 0 THEN DO:
        nv_acnoa = "B3MLKK0102".
    END.
    ELSE IF INDEX(tlt.filler1,"Used") <> 0 THEN DO:
        nv_acnoa = "B3MLKK0105".
    END.
END.
ELSE IF tlt.note5 = "Single" THEN DO:
    IF INDEX(tlt.filler1,"New") <> 0 THEN DO:
        nv_acnoa = "B3MLKK0102".
    END.
    ELSE IF INDEX(tlt.filler1,"Used") <> 0 THEN DO:
        nv_acnoa = "B3MLKK0105".
    END.
END.
IF nv_acnoa <> "" THEN DO:
    ASSIGN
        tlt.comp_sub        = nv_acnoa
        tlt.recac           = "B3MLKK0100" .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltnew4 C-Win 
PROCEDURE create_tltnew4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_deci AS DECI INIT 0.
nv_deci = DECI(tlt.colorcod) NO-ERROR.

IF tlt.noteveh1 <> "" AND (nv_deci = 0 OR tlt.cc_weight  = 0) THEN DO:
    IF tlt.cc_weight = 0 THEN DO:
        IF tlt.noteveh1 = "11" THEN tlt.cc_weight = 1000.
        ELSE IF tlt.noteveh1 = "12" THEN tlt.cc_weight = 2000.
        ELSE IF tlt.noteveh1 = "13" THEN tlt.cc_weight = 2001.
        ELSE IF tlt.noteveh1 = "61" THEN tlt.cc_weight = 75.
        ELSE IF tlt.noteveh1 = "62" THEN tlt.cc_weight = 125.
        ELSE IF tlt.noteveh1 = "63" THEN tlt.cc_weight = 150.
        ELSE IF tlt.noteveh1 = "64" THEN tlt.cc_weight = 151.
    END.
    IF nv_deci = 0 THEN DO:
        IF tlt.noteveh1 = "31" THEN       tlt.colorcod  = "3000".
        ELSE IF tlt.noteveh1 = "32" THEN  tlt.colorcod  = "6000".
        ELSE IF tlt.noteveh1 = "33" THEN  tlt.colorcod  = "12000".
        ELSE IF tlt.noteveh1 = "34" THEN  tlt.colorcod  = "12000".
        ELSE IF tlt.noteveh1 = "35" THEN  tlt.colorcod  = "12001".
        ELSE IF tlt.noteveh1 = "41" THEN  tlt.colorcod  = "8000".
        ELSE IF tlt.noteveh1 = "42" THEN  tlt.colorcod  = "8001".
        ELSE IF tlt.noteveh1 = "51" THEN  tlt.colorcod  = "30000".
        ELSE IF tlt.noteveh1 = "52" THEN  tlt.colorcod  = "30001".

    END.

END.    
IF   
trim(tlt.ins_addr1) = "" and       
trim(tlt.ins_addr2) = "" and 
trim(tlt.ins_addr3) = "" and 
trim(tlt.ins_addr4) = "" AND trim(tlt.ins_addr)   <> "" THEN tlt.ins_addr1 = trim(tlt.ins_addr).


IF LENGTH(tlt.ins_addr1 ) > 50 AND INDEX(tlt.ins_addr1," ") <> 0 THEN DO:
    RUN create_tltnew5(INPUT-OUTPUT tlt.ins_addr1,
                       INPUT-OUTPUT tlt.ins_addr2).
END.
IF LENGTH(tlt.ins_addr2 ) > 50 AND INDEX(tlt.ins_addr2," ") <> 0 THEN DO:
    RUN create_tltnew5(INPUT-OUTPUT tlt.ins_addr2,
                       INPUT-OUTPUT tlt.ins_addr3).
END.
IF LENGTH(tlt.ins_addr3 ) > 50 AND INDEX(tlt.ins_addr3," ") <> 0 THEN DO:
    RUN create_tltnew5(INPUT-OUTPUT tlt.ins_addr3,
                       INPUT-OUTPUT tlt.ins_addr4).
END.
IF   
trim(tlt.rec_addr1) = "" and       
trim(tlt.rec_addr2) = "" and 
trim(tlt.rec_addr3) = "" and 
trim(tlt.rec_addr4) = "" AND trim(tlt.rec_addr)   <> "" THEN tlt.rec_addr1 = trim(tlt.rec_addr).


IF LENGTH(tlt.rec_addr1 ) > 50 AND INDEX(tlt.rec_addr1," ") <> 0 THEN DO:
    RUN create_tltnew5(INPUT-OUTPUT tlt.rec_addr1,
                       INPUT-OUTPUT tlt.rec_addr2).
END.
IF LENGTH(tlt.rec_addr2 ) > 50 AND INDEX(tlt.rec_addr2," ") <> 0 THEN DO:
    RUN create_tltnew5(INPUT-OUTPUT tlt.rec_addr2,
                       INPUT-OUTPUT tlt.rec_addr3).
END.
IF LENGTH(tlt.rec_addr3 ) > 50 AND INDEX(tlt.rec_addr3," ") <> 0 THEN DO:
    RUN create_tltnew5(INPUT-OUTPUT tlt.rec_addr3,
                       INPUT-OUTPUT tlt.rec_addr4).
END.





END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltnew5 C-Win 
PROCEDURE create_tltnew5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
def input-output parameter nv_addr1  as char init "".
def input-output parameter nv_addr2  as char init "".
DEF VAR nv_text1 AS CHAR INIT "".
DEF VAR nv_text2 AS CHAR INIT "".
DEF VAR nv_text3 AS CHAR INIT "".
DEF VAR nv_int   AS INT  INIT 0.
DEF VAR nv_int2  AS INT  INIT 0.
DEF VAR nv_txtst AS CHAR INIT "".
nv_int = NUM-ENTRIES(nv_addr1," ") NO-ERROR.
IF nv_int <> 0 THEN DO:
    loop_int:
    REPEAT:
        nv_int2 = nv_int2 + 1.
        nv_text3 = "".
        nv_text3 = ENTRY(nv_int2,nv_addr1," ") NO-ERROR.
        IF LENGTH(nv_text1 + " " + nv_text3) > 50 THEN nv_txtst = "Y".
        IF nv_txtst = "" THEN nv_text1 = nv_text1 + " " + nv_text3.
        ELSE nv_text2 = nv_text2  + " " + nv_text3.
        IF nv_int = nv_int2 THEN LEAVE loop_int. 
    END.
    ASSIGN
        nv_addr1 = nv_text1
        nv_addr2 = nv_text2 + " " + nv_addr2.

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltprob C-Win 
PROCEDURE create_tltprob :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A65-0288      
------------------------------------------------------------------------------*/
RUN pd_hexp1.
LOOP_wdetail:                                 
FOR EACH wdetail  :   
    IF wdetail.notifyno <> "" THEN DO:
        FIND FIRST tlt    WHERE 
            tlt.comp_noti_tlt  = wdetail.notifyno   AND
            tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
        
        IF NOT AVAIL tlt THEN DO:    
            ASSIGN nv_error = nv_error + 1 
                   wdetail.remark = "��辺�Ţ Notify No: " + wdetail.notifyno  + "��к��ѧ�ѡ" .
        END.
        ELSE DO:
             RUN create_tltprob2.
        END.
    END.
    ELSE DO:
        FIND FIRST tlt    WHERE 
            tlt.expotim        = wdetail.kkapp      AND
            tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
        IF NOT AVAIL tlt THEN DO:    
            ASSIGN nv_error       = nv_error + 1 
                   wdetail.remark = "��辺�Ţ KKAPP: "+ wdetail.kkapp + "��к��ѧ�ѡ " . 
        END.
        ELSE DO:
            RUN create_tltprob2.
        END.
    END.
    RUN  pd_fall.
END.
RELEASE tlt NO-ERROR.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltprob-yong C-Win 
PROCEDURE create_tltprob-yong :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN pd_hexp1.
RUN pd_hexp2.
LOOP_wdetail:                                 
FOR EACH wdetail  :   

    IF wdetail.kkapp <> "" THEN DO:
        FIND FIRST tlt    WHERE 
            tlt.expotim        = wdetail.kkapp      AND
            tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
        
        IF NOT AVAIL tlt THEN DO:    
            ASSIGN nv_error = nv_error + 1 .
            Message "��辺�Ţ KKAPP: " wdetail.kkapp SKIP "Notify No: " wdetail.notifyno  View-as alert-box. 
            DELETE wdetail.    
            NEXT LOOP_wdetail.
        END.
        ELSE DO:
            IF tlt.note29 = "N" THEN DO:
                ASSIGN nv_error = nv_error + 1 .
                Message  "��辺�Ţ KKAPP: " wdetail.kkapp SKIP "Notify No: " wdetail.notifyno " ���Դ Status Problem" View-as alert-box. 
                DELETE wdetail.    
                NEXT LOOP_wdetail.
            END.
            RUN create_tltprob2.
        END.
    END.
    ELSE DO:
        FIND FIRST tlt    WHERE 
            tlt.comp_noti_tlt  = wdetail.notifyno     AND
            tlt.genusr         = "kk"               NO-ERROR NO-WAIT .
        
        IF NOT AVAIL tlt THEN DO:    
            ASSIGN nv_error = nv_error + 1 .
            Message "��辺�Ţ KKAPP: " wdetail.kkapp SKIP "Notify No: " wdetail.notifyno  View-as alert-box. 
            DELETE wdetail.    
            NEXT LOOP_wdetail.
        END.
        ELSE DO:
            IF tlt.note29 = "N" THEN DO:
                ASSIGN nv_error = nv_error + 1 .
                Message  "��辺�Ţ KKAPP: " wdetail.kkapp SKIP "Notify No: " wdetail.notifyno " ���Դ Status Problem" View-as alert-box. 
                DELETE wdetail.    
                NEXT LOOP_wdetail.
            END.
            RUN create_tltprob2.
        END.

    END.


END.
RELEASE tlt NO-ERROR.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltprob2 C-Win 
PROCEDURE create_tltprob2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_completecnt  =  nv_completecnt + 1.

IF tlt.note29 = "N" THEN DO: 
    ASSIGN wdetail.remark = "Notify No: " + wdetail.notifyno + " Status Problem = N ���� / Release = " + tlt.releas
           wdetail.hcf    = tlt.hclfg
           wdetail.stp    = tlt.note29
           wdetail.prepol = tlt.policy .
    IF tlt.usrsent = "Y" AND tlt.lotno = "N"  THEN ASSIGN wdetail.remark = wdetail.remark + "/�͵�Ǩ��Ҿ" .
END.
ELSE DO:
    ASSIGN
        tlt.nor_noti_tlt    = wdetail.cedpol                     /*111 �Ţ����ѭ����ҫ��� */        
        tlt.comp_noti_tlt   = wdetail.notifyno   .                /*123 �Ţ�Ѻ��� */      
    IF INDEX(wdetail.Notify_dat," ") <> 0 THEN DO:
         tlt.datesent        = date(trim(SUBSTR(wdetail.Notify_dat,1,INDEX(wdetail.Notify_dat," ")))) NO-ERROR.  /*124 �ѹ����Ѻ��   */  
         tlt.gentim          = trim(SUBSTR(wdetail.Notify_dat,INDEX(wdetail.Notify_dat," "))) NO-ERROR.
    END.
    ELSE
        ASSIGN
            tlt.datesent      = date(wdetail.Notify_dat)
            tlt.gentim        = "" NO-ERROR.
            tlt.trndat        = TODAY .
    /* Response Problem Date + Response Problem Description*/    
    IF tlt.note28 = "" THEN ASSIGN  tlt.note28 = trim(trim(wdetail.drivno2) + " " + trim(wdetail.garage)).
    ELSE ASSIGN  tlt.note28 = tlt.note28 + "," + trim(trim(wdetail.drivno2) + " " + trim(wdetail.garage)).   
    
    /* Problem Description  + remark */
    IF tlt.note24 =  "" THEN  ASSIGN tlt.note24 = trim(trim(wdetail.drivno1) + " " + trim(wdetail.remark1))  . 
    ELSE ASSIGN  tlt.note24 = tlt.note24 + "," + trim(trim(wdetail.drivno1) + " " + trim(wdetail.remark1))  .
    
    IF index(wdetail.drilic2,"Unflag Problem") <> 0  THEN DO: 
        IF tlt.usrsent = "Y" AND tlt.lotno = "Y" THEN DO: 
            ASSIGN tlt.note29 = "N"
                   wdetail.remark = "Complete/Release = " + tlt.releas 
                   wdetail.hcf    = tlt.hclfg
                   wdetail.stp    = tlt.note29
                   wdetail.prepol = tlt.policy .
                
        END.
        ELSE IF tlt.usrsent = "Y" AND tlt.lotno = "N"  THEN DO:
            ASSIGN wdetail.remark = "�͵�Ǩ��Ҿ / Release = " + tlt.releas
                   wdetail.hcf    = tlt.hclfg
                   wdetail.stp    = tlt.note29
                   wdetail.prepol = tlt.policy .
        END.
        ELSE DO:
            ASSIGN tlt.note29 = "N"
                   wdetail.remark = "Complete/Release = " + tlt.releas
                   wdetail.hcf    = tlt.hclfg
                   wdetail.stp    = tlt.note29
                   wdetail.prepol = tlt.policy .
        END. 
    END.
    IF tlt.hclfg  = "Y" THEN DO:
        IF tlt.OLD_eng = "" THEN tlt.old_eng = "CANCEL_HOLD" + SUBSTR(fi_FileName,(R-INDEX(fi_FileName,"\") + 1 )).
        ELSE IF index(tlt.OLD_eng,"CANCEL_HOLD") = 0 THEN tlt.OLD_eng   = "CANCEL_HOLD" +  SUBSTR(tlt.OLD_eng,(INDEX(tlt.OLD_eng,"Hold") + 4 )).
    
    END.
    IF tlt.dat_ins_not = ? THEN do:
        IF tlt.ln_fst  <> "" THEN tlt.dat_ins_not = date(tlt.ln_fst) NO-ERROR.
        IF tlt.dat_ins_not = ? THEN tlt.dat_ins_not = TODAY.
    END.
    
    /*
    IF wdetail.stp = "" THEN DO:
        IF tlt.note29 = "Y" THEN DO:
        END.
        ELSE tlt.note29 = "N".
    END.
    ELSE DO:
        IF wdetail.stp <> tlt.note29 THEN DO:
            IF wdetail.stp = "N" THEN tlt.note29 = "N".
            ELSE tlt.note29 = "Y".
        END.
    END.
    
    IF tlt.dat_ins_not = ? THEN do:
        IF tlt.ln_fst  <> "" THEN tlt.dat_ins_not = date(tlt.ln_fst) NO-ERROR.
        IF tlt.dat_ins_not = ? THEN tlt.dat_ins_not = TODAY.
    END.
    
    IF wdetail.hcf <> "" THEN DO:
        IF tlt.hclfg  = wdetail.hcf  AND  tlt.hclfg = "N" THEN DO: 
        END.
        ELSE DO:
            tlt.hclfg           = wdetail.hcf .
            IF tlt.hclfg = "" THEN  tlt.hclfg  = "Y".
            IF tlt.OLD_eng = "" AND  tlt.hclfg  = "Y" THEN tlt.OLD_eng         = "HOLD" +  SUBSTR(fi_FileName,(R-INDEX(fi_FileName,"\") + 1 )).
            ELSE IF tlt.OLD_eng = "" AND  tlt.hclfg  = "N"  THEN  tlt.OLD_eng         = "COVER".
            ELSE DO:
                IF tlt.hclfg  = "Y" THEN tlt.OLD_eng  = "HOLD" +  SUBSTR(fi_FileName,(R-INDEX(fi_FileName,"\") + 1 )).
                ELSE IF index(tlt.OLD_eng,"CANCEL_HOLD") = 0 THEN tlt.OLD_eng   = "CANCEL_HOLD" +  SUBSTR(tlt.OLD_eng,(INDEX(tlt.OLD_eng,"Hold") + 4 )). 
            END.
        END.
    END.
    IF tlt.note29 = "Y" AND  tlt.note24  <> "" OR (tlt.expotim = "" AND tlt.hclf = "N" ) THEN RUN pd_fprob.
    ELSE IF  tlt.hclf = "Y" THEN RUN pd_fhfg.
    ELSE RUN pd_fcom.*/
END.
IF (tlt.note29 = "N" AND tlt.hclf = "N" AND index(wdetail.remark,"�͵�Ǩ��Ҿ") = 0 ) THEN RUN pd_fcom.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltprob2-yong C-Win 
PROCEDURE create_tltprob2-yong :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*nv_completecnt  =  nv_completecnt + 1.
ASSIGN
    tlt.nor_noti_tlt    = wdetail.cedpol                     /*111 �Ţ����ѭ����ҫ��� */        
    tlt.comp_noti_tlt   = wdetail.notifyno   .                /*123 �Ţ�Ѻ��� */      
IF INDEX(wdetail.Notify_dat," ") <> 0 THEN DO:
     tlt.datesent        = date(trim(SUBSTR(wdetail.Notify_dat,1,INDEX(wdetail.Notify_dat," ")))) NO-ERROR.  /*124 �ѹ����Ѻ��   */  
     tlt.gentim          = trim(SUBSTR(wdetail.Notify_dat,INDEX(wdetail.Notify_dat," "))) NO-ERROR.
END.
ELSE
    ASSIGN
        tlt.datesent        = date(wdetail.Notify_dat)
        tlt.gentim          = "" NO-ERROR.

/*ASSIGN 
   tlt.rec_name        = wdetail.reci_name1                   /*28  ���� (�����/㺡ӡѺ����)        */ 
    tlt.ins_name        = wdetail.n_name1                     /*48  ���ͼ����һ�Сѹ    */                  
    tlt.tel             = wdetail.tel1                        /*54  Insured Telephone 1    */  
    tlt.tel2            = wdetail.tel2                        /*55  Insured Telephone 2    */  
    tlt.tel3            = wdetail.tel3                        /*56  Insured Telephone 3    */  
    tlt.buagent         = wdetail.buagent                      /*23  Agent                      */
    tlt.nor_usr_tlt     = wdetail.cmbr_no                      /*21  Branch                     */                           
    tlt.comp_usr_tlt    = wdetail.cmbr_code    .              /*22  BU/RC                      */       
    tlt.comp_grprm      = deci(wdetail.prem1   )    no-error. 
    tlt.rstp            = deci(wdetail.ostp    )    no-error. 
    tlt.rtax            = deci(wdetail.otax    )    no-error. 
    tlt.prem_amt        = deci(wdetail.prem2   )    no-error.              */
    tlt.trndat               = TODAY .
    /*IF tlt.prem_amttcop  <> 0 THEN tlt.prem_amttcop    = deci(wdetail.prem2 )    no-error.*/
    /*--
    if tlt.note12        <> "" then tlt.note12   = wdetail.prem1  .
    if tlt.note13        <> "" then tlt.note13   = wdetail.ostp   .        
    if tlt.note14        <> "" then tlt.note14   = wdetail.otax   .
    if tlt.note15        <> "" then tlt.note15   = wdetail.prem2  .
    if tlt.note17        <> "" then tlt.note17   = wdetail.prem2  .*/
IF tlt.note28 = "" THEN DO:

    IF tlt.note28 <> "" AND wdetail.drilic1 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.drilic1.
    ELSE IF wdetail.drilic1 <> "" THEN tlt.note28 = wdetail.drilic1.

    IF tlt.note28 <> "" AND wdetail.name1 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.name1.
    ELSE IF wdetail.name1 <> "" THEN tlt.note28 = wdetail.name1.

    IF tlt.note28 <> "" AND wdetail.drivno1 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.drivno1  .
    ELSE IF wdetail.drivno1 <> "" THEN tlt.note28 = wdetail.drivno1  .

    IF tlt.note28 <> "" AND wdetail.drilic2 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.drilic2  .
    ELSE IF wdetail.drilic2 <> "" THEN tlt.note28 = wdetail.drilic2  .
    
    IF tlt.note28 <> "" AND wdetail.name2 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.name2  .
    ELSE IF wdetail.name2 <> "" THEN tlt.note28 = wdetail.name2  .

    IF tlt.note28 <> "" AND wdetail.drivno2 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.drivno2  .
    ELSE IF wdetail.drivno2 <> "" THEN tlt.note28 = wdetail.drivno2  .
    
    IF tlt.note28 <> "" AND wdetail.garage <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.garage  .
    ELSE IF wdetail.garage <> "" THEN tlt.note28 = wdetail.garage  .                 
    
    IF tlt.note28 <> "" AND wdetail.remark1 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.remark1  .
    ELSE IF wdetail.remark1 <> "" THEN tlt.note28 = wdetail.remark1  .

END.
ELSE DO:


    IF tlt.note28 <> "" AND wdetail.drilic1 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.drilic1.
    ELSE IF wdetail.drilic1 <> "" THEN tlt.note28 = wdetail.drilic1.

    IF tlt.note28 <> "" AND wdetail.name1 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.name1.
    ELSE IF wdetail.name1 <> "" THEN tlt.note28 = wdetail.name1.

    IF tlt.note28 <> "" AND wdetail.drivno1 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.drivno1  .
    ELSE IF wdetail.drivno1 <> "" THEN tlt.note28 = wdetail.drivno1  .

    IF tlt.note28 <> "" AND wdetail.drilic2 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.drilic2  .
    ELSE IF wdetail.drilic2 <> "" THEN tlt.note28 = wdetail.drilic2  .
    
    IF tlt.note28 <> "" AND wdetail.name2 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.name2  .
    ELSE IF wdetail.name2 <> "" THEN tlt.note28 = wdetail.name2  .

    IF tlt.note28 <> "" AND wdetail.drivno2 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.drivno2  .
    ELSE IF wdetail.drivno2 <> "" THEN tlt.note28 = wdetail.drivno2  .
    
    IF tlt.note28 <> "" AND wdetail.garage <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.garage  .
    ELSE IF wdetail.garage <> "" THEN tlt.note28 = wdetail.garage  .                 
    
    IF tlt.note28 <> "" AND wdetail.remark1 <> "" THEN tlt.note28 = tlt.note28 + "," + wdetail.remark1  .
    ELSE IF wdetail.remark1 <> "" THEN tlt.note28 = wdetail.remark1  .
    /* tlt.note28 = tlt.note28 + "," + wdetail.drilic1  + "," +
             wdetail.name1    + "," +
             wdetail.drivno1  + "," +
             wdetail.drilic2  + "," +
             wdetail.name2    + "," +
             wdetail.drivno2  + "," +
             wdetail.garage   + "," +
             wdetail.remark1.*/

END.

IF tlt.note24 <> "" AND wdetail.drivno1 <> "" THEN tlt.note24 = tlt.note24 + "," + wdetail.drivno1  .
ELSE IF wdetail.drivno1 <> "" THEN tlt.note24 = wdetail.drivno1  .

IF tlt.note24 <> "" AND wdetail.drilic2 <> "" THEN tlt.note24 = tlt.note24 + "," + wdetail.drilic2  .
ELSE IF wdetail.drilic2 <> "" THEN tlt.note24 = wdetail.drilic2  .

IF tlt.note24 <> "" AND wdetail.name2 <> "" THEN tlt.note24 = tlt.note24 + "," + wdetail.name2  .
ELSE IF wdetail.name2 <> "" THEN tlt.note24 = wdetail.name2  .

IF tlt.note24 <> "" AND wdetail.drivno2 <> "" THEN tlt.note24 = tlt.note24 + "," + wdetail.drivno2  .
ELSE IF wdetail.drivno2 <> "" THEN tlt.note24 = wdetail.drivno2  .

IF tlt.note24 <> "" AND wdetail.garage <> "" THEN tlt.note24 = tlt.note24 + "," + wdetail.garage  .
ELSE IF wdetail.garage <> "" THEN tlt.note24 = wdetail.garage  .                 

IF tlt.note24 <> "" AND wdetail.remark1 <> "" THEN tlt.note24 = tlt.note24 + "," + wdetail.remark1  .
ELSE IF wdetail.remark1 <> "" THEN tlt.note24 = wdetail.remark1  .

IF tlt.note24 <> "" AND wdetail.remark <> "" THEN tlt.note24 = tlt.note24 + "," + wdetail.remark  .
ELSE IF wdetail.remark <> "" THEN tlt.note24 = wdetail.remark  .

/*
IF tlt.note24 = "" THEN tlt.note24          = wdetail.remark.
ELSE DO:
    IF wdetail.remark <> "" THEN DO:
        tlt.note24          = tlt.note24 + "," + wdetail.remark.
    END.

END. */

IF wdetail.stp = "" THEN DO:
    IF tlt.note29 = "Y" THEN DO:
    END.
    ELSE tlt.note29 = "N".
END.
ELSE DO:
    IF wdetail.stp <> tlt.note29 THEN DO:
        IF wdetail.stp = "N" THEN tlt.note29 = "N".
        ELSE tlt.note29 = "Y".
    END.
END.
IF tlt.dat_ins_not = ? THEN do:
    IF tlt.ln_fst  <> "" THEN tlt.dat_ins_not = date(tlt.ln_fst) NO-ERROR.
    IF  tlt.dat_ins_not = ? THEN tlt.dat_ins_not = TODAY.
END.

IF wdetail.hcf <> "" THEN DO:
    IF tlt.hclfg  = wdetail.hcf  AND  tlt.hclfg = "N" THEN DO: 
    END.
    ELSE DO:
        tlt.hclfg           = wdetail.hcf .
        IF tlt.hclfg = "" THEN  tlt.hclfg  = "Y".
        IF tlt.OLD_eng = "" AND  tlt.hclfg  = "Y" THEN tlt.OLD_eng         = "HOLD" +  SUBSTR(fi_FileName,(R-INDEX(fi_FileName,"\") + 1 )).
        ELSE IF tlt.OLD_eng = "" AND  tlt.hclfg  = "N"  THEN  tlt.OLD_eng         = "COVER".
        ELSE DO:
            IF tlt.hclfg  = "Y" THEN tlt.OLD_eng  = "HOLD" +  SUBSTR(fi_FileName,(R-INDEX(fi_FileName,"\") + 1 )).
            ELSE IF index(tlt.OLD_eng,"CANCEL_HOLD") = 0 THEN tlt.OLD_eng   = "CANCEL_HOLD" +  SUBSTR(tlt.OLD_eng,(INDEX(tlt.OLD_eng,"Hold") + 4 )). 
        END.
    END.
END.
IF tlt.note29 = "Y" AND  tlt.note24  <> "" OR (tlt.expotim = "" AND tlt.hclf = "N" ) THEN RUN pd_fprob.
ELSE IF  tlt.hclf = "Y" THEN RUN pd_fhfg.
ELSE RUN pd_fcom.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltup C-Win 
PROCEDURE create_tltup :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
            tlt.entdat         = TODAY
            tlt.enttim         = STRING(TIME,"HH:MM:SS")
            /*nv_enttim          = STRING(TIME,"HH:MM:SS")*/
            tlt.trntime        = STRING(TIME,"HH:MM:SS")
            tlt.trndat         = fi_loaddat
            tlt.datesent       = date(wdetail.Notify_dat)           /*1  �ѹ����Ѻ��   */                        
            tlt.dat_ins_not    = date(wdetail.recive_dat)           /*2  �ѹ����Ѻ�Թ������»�Сѹ */            
            tlt.nor_usr_ins    = trim(wdetail.comp_code)            /*3  ��ª��ͺ���ѷ��Сѹ���  */                
            tlt.nor_noti_tlt   = trim(wdetail.cedpol)               /*4  �Ţ����ѭ����ҫ��� */                    
            tlt.nor_noti_ins   = trim(wdetail.prepol)               /*5  �Ţ�������������  */                    
            tlt.nor_usr_tlt    = trim(wdetail.cmbr_no)              /*6  �����Ң�    */                            
            tlt.comp_usr_tlt   = trim(wdetail.cmbr_code)            /*7  �Ң� KK */                                
            tlt.comp_noti_tlt  = trim(wdetail.notifyno)             /*8  �Ţ�Ѻ��� */                            
            tlt.dri_no1        = trim(wdetail.campaigno)            /*9  Campaign    */                            
            tlt.dri_no2        = trim(wdetail.campaigsub)           /*10 Sub Campaign    */                        
            tlt.safe2          = trim(wdetail.typper)               /*11 �ؤ��/�ԵԺؤ�� */                        
            tlt.ins_name       = trim(wdetail.n_TITLE) + " " +      /*12 �ӹ�˹�Ҫ���    */                        
                                 trim(wdetail.n_name1) + " " +      /*13 ���ͼ����һ�Сѹ    */                  
                                 trim(wdetail.n_name2)              /*14 ���ʡ�ż����һ�Сѹ */           
            tlt.ins_addr1      = trim(wdetail.ADD_no) + " " +        /*15 ��ҹ�Ţ���  */                          
                                 trim(wdetail.ADD_build)            /*16 ���� + �����ҹ + �Ҥ�� + ��� + ���    */       
            tlt.ins_addr2      = trim(wdetail.ADD_thambon)          /*21 �Ӻ�/�ǧ*/                     
            tlt.ins_addr3      = trim(wdetail.ADD_amper)            /*22 �����/ࢵ*/                     
            tlt.ins_addr4      = trim(wdetail.ADD_country)          /*23 �ѧ��Ѵ*/                               
            tlt.ins_addr5      = trim(wdetail.ADD_post)             /*24 ������ɳ���*/                       
            tlt.safe3          = IF index(wdetail.cover,"1") <> 0 THEN "1"    /*  25 ����������������ͧ  */                    
                                 ELSE IF index(wdetail.cover,"2") <> 0 THEN "2" 
                                 ELSE "3"
            tlt.stat           = IF index(wdetail.garage,"���������") <> 0 THEN " " ELSE "G"  /*  26 ��������ë���   */                        
            tlt.nor_effdat     = date(wdetail.comdat)               /*  27 �ѹ�����������ͧ    */                    
            tlt.expodat        = date(wdetail.expdat)               /*  28 �ѹ����ش������ͧ  */                    
            tlt.subins         = trim(wdetail.subclass)             /*  29 ����ö  */                                
            tlt.filler2        = trim(wdetail.n_43)                 /*  30 ��������Сѹ���ö¹��   */                
            tlt.brand          = trim(wdetail.brand)                /*  31 ����������ö    */                        
            tlt.model          = trim(wdetail.model)                /*  32 ���ö  */                                
            tlt.filler1        = trim(wdetail.nSTATUS)              /*  33 New/Used    */                            
            tlt.lince1         = trim(wdetail.licence)              /*  34 �Ţ����¹  */                            
            tlt.cha_no         = trim(wdetail.chassis)              /*  35 �Ţ��Ƕѧ   */                            
            tlt.eng_no         = trim(wdetail.engine)               /*  36 �Ţ����ͧ¹��  */                        
            tlt.lince2         = trim(wdetail.cyear)                /*  37 ��ö¹��    */                            
            tlt.cc_weight      = deci(wdetail.power)                /*  38 �ի�    */                            
            tlt.colorcod       = trim(wdetail.weight)               /*  39 ���˹ѡ/�ѹ */                        
            tlt.comp_coamt     = deci(wdetail.ins_amt1)             /*  40 �ع��Сѹ�� 1   */                    
            tlt.comp_grprm     = deci(wdetail.prem1)                /*  41 ����������������ҡû� 1    */        
            tlt.nor_coamt      = deci(wdetail.ins_amt2)             /*  42 �ع��Сѹ�� 2   */                    
            tlt.nor_grprm      = deci(wdetail.prem2)                /*  43 ����������������ҡû� 2    */        
            tlt.gentim         = trim(wdetail.time_notify)          /*  44 �����Ѻ���    */                    
            tlt.comp_usr_ins   = trim(wdetail.NAME_mkt)             /*  45 �������˹�ҷ�� MKT */                
            tlt.safe1          = trim(wdetail.bennam)               /*  46 �����˵�    */                        
            tlt.dri_name1      = trim(wdetail.drivno1)              /*  47 ���Ѻ����� 1 �����ѹ�Դ        */ 
            tlt.dri_name2      = trim(wdetail.drivno2)              /*  48 ���Ѻ����� 2 �����ѹ�Դ        */ 
            tlt.rec_name       = trim(wdetail.reci_title) + " " +   /*  49 �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)*/ 
                                 trim(wdetail.reci_name1) + " " +   /*  50 ���� (�����/㺡ӡѺ����)        */ 
                                 trim(wdetail.reci_name2)           /*  51 ���ʡ�� (�����/㺡ӡѺ����)     */ 
            tlt.rec_addr1      = trim(wdetail.reci_addno) +         /*  52 ��ҹ�Ţ��� (�����/㺡ӡѺ����)  */
                                 trim(wdetail.reci_addmu) +         /*  53 �����ҹ (�����/㺡ӡѺ����)    */ 
                                 trim(wdetail.reci_addbuild)  +     /*  54 �Ҥ�� (�����/㺡ӡѺ����)       */ 
                                 trim(wdetail.reci_addsoy) +        /*  55 ��� (�����/㺡ӡѺ����)  */
                                 trim(wdetail.reci_addroad)         /*  56 ��� (�����/㺡ӡѺ����)   */            
            tlt.rec_addr2      = trim(wdetail.reci_addtambon)       /*  57 �Ӻ�/�ǧ (�����/㺡ӡѺ����) */        
            tlt.rec_addr3      = trim(wdetail.reci_addamper)        /*  58 �����/ࢵ (�����/㺡ӡѺ����) */        
            tlt.rec_addr4      = trim(wdetail.reci_addcounty)       /*  59 �ѧ��Ѵ (�����/㺡ӡѺ����)   */        
            tlt.rec_addr5      = trim(wdetail.reci_addpost)         /*  60 ������ɳ��� (�����/㺡ӡѺ����)*/    
            tlt.seqno          = deci(wdetail.ncb)                  /*  61 ��ǹŴ����ѵԴ� */                          
            tlt.lotno          = trim(wdetail.fleet)                      /*  62  ��ǹŴ�ҹ Fleet */ 
            /* A60-0232 */
            tlt.endcnt         = INT(wdetail.fi)
            tlt.expousr        = "TEL:" + TRIM(wdetail.tel) + " " +             /*����Դ���                 */  
                                 "ICNO:" + TRIM(wdetail.icno)                   /*�Ţ���ѵû�ЪҪ�           */  
            tlt.usrsent        = "Occup:" + TRIM(wdetail.occup) + " " +         /*�Ҫվ                       */ 
                                 "Status:" + TRIM(wdetail.cstatus) + " " +      /*ʶҹ�Ҿ                     */ 
                                 "Tax:" + TRIM(wdetail.taxno)                   /*�Ţ��Шӵ�Ǽ�����������ҡ�  */
            tlt.gendat         = DATE(wdetail.bdate)                            /*�ѹ��͹���Դ              */
            tlt.lince3         = "T1:"  + trim(wdetail.tname1) + " " +       /*�ӹ�˹�Ҫ��� 1              */
                                 "N1:"  + trim(wdetail.name1)  + " " +       /*���͡������ 1               */
                                 "L1:"  + trim(wdetail.lname1) + " " +       /*���ʡ�š������ 1            */
                                 "IC1:" + trim(wdetail.icno1)  + " " +       /*�Ţ���ѵû�ЪҪ�������� 1  */
                                 "T2:"  + trim(wdetail.tname2) + " " +       /*�ӹ�˹�Ҫ��� 1              */
                                 "N2:"  + trim(wdetail.name2) + " " +       /*���͡������ 1               */
                                 "L2:"  + trim(wdetail.lname2) + " " +       /*���ʡ�š������ 1            */
                                 "IC2:" + trim(wdetail.icno2) + " " +       /*�Ţ���ѵû�ЪҪ�������� 1  */
                                 "T3:"  + trim(wdetail.tname3) + " " +       /*�ӹ�˹�Ҫ��� 1              */
                                 "N3:"  + trim(wdetail.name3) + " " +       /*���͡������ 1               */
                                 "L3:"  + trim(wdetail.lname3) + " " +       /*���ʡ�š������ 1            */
                                 "IC3:" + trim(wdetail.icno3)              /*�Ţ���ѵû�ЪҪ�������� 1  */
            /* End : A60-0323  */
            tlt.comp_noti_ins  = "SE:" + TRIM(wdetail.postsend) + " " +   /* ʶҹ���Ѵ�� */        /* A61-0335 */
                                "SN:" +  TRIM(wdetail.sendname)  + " " +  /* ���ͼ���Ѻ */            /* A61-0335 */
                                "BE:" +  TRIM(wdetail.benname)            /* ���ͼ���Ѻ�Ż���ª�� */  /* A61-0335 */
            tlt.expotim        = trim(wdetail.KKapp)                      /* KK App */                 /* A61-0335 */
            tlt.old_cha        = ""                         /* Remark 2 */ /*A61-0335*/
            tlt.OLD_eng        = "COVER"
            tlt.flag           = "R"                      
            tlt.comp_sub       = trim(fi_producer) 
            tlt.recac          = trim(fi_agent)  
            tlt.genusr         = trim(fi_compano)
            tlt.endno          = USERID(LDBNAME(1))                 /*User Load Data */
            tlt.imp            = "IM"                               /*Import Data    */
            tlt.releas         = "NO"  .

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
  DISPLAY fi_loaddat fi_compano fi_producer fi_agent ra_filetyp fi_filename 
          fi_proname fi_impcnt fi_completecnt fi_dir_cnt fi_dri_complet 
          fi_agename fi_error fi_dri_fi_error fi_kkcom fi_kkhold fi_kkprob 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loaddat fi_compano fi_producer fi_agent ra_filetyp fi_filename 
         bu_file bu_ok bu_exit br_imptxt bu_hpacno1 bu_hpacno-2 RECT-1 RECT-78 
         RECT-79 RECT-80 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_chkpol C-Win 
PROCEDURE import_chkpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_dataerr AS CHAR INIT "".
DEF VAR nv_nochar  AS CHAR INIT "".
                 /* repeat  */
ASSIGN  nv_error   = 0     /*add kridtiya i. A55-0029 */
        nv_completecnt = 0 .  
INPUT FROM VALUE(fi_FileName).
loop_load:
REPEAT:
    CREATE wpol.
    IMPORT DELIMITER "|"
        wpol.Num                  
        wpol.DueDate              
        wpol.AgingIssue           
        wpol.BRCode               
        wpol.BRName               
        wpol.BU                   
        wpol.Insurer              
        wpol.PD_SubGroup          
        wpol.PD_Code              
        wpol.Pack_Code            
        wpol.Pack_Name            
        wpol.AppDate              
        wpol.EffDate              
        wpol.ExpDate              
        wpol.KKApp                
        wpol.KKQuo                
        wpol.SourceID             
        wpol.InsAppNo             
        wpol.LoanNo               
        wpol.notifyno             
        wpol.NotifiedDate         
        wpol.PayTName             
        wpol.PayName              
        wpol.InsTName             
        wpol.InsName              
        wpol.SumInsure            
        wpol.NetPremium           
        wpol.Stamp                
        wpol.VAT                  
        wpol.GrossPremium         
        wpol.PaymentPeriod        
        wpol.PolicyStatus         
        wpol.Chassis            
        wpol.KKOfferFlag          
        wpol.LicenseNo            
        wpol.LicenseProv   .

    IF  index(wpol.duedate,"Date") <> 0  THEN DELETE wpol.
    ELSE IF wpol.chassis  = "" THEN DELETE wpol.  
END.
INPUT CLOSE.

RUN  proc_head.
Run  proc_chkpol.  

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.
END.
ASSIGN 
    fi_completecnt  =  nv_completecnt 
    fi_error        =  nv_error
   
    fi_impcnt       =  nv_completecnt  +  nv_error
     nv_completecnt  =  0.
Disp fi_completecnt   fi_impcnt  fi_error  with frame  fr_main.

Run Open_tlt.

Message "Load  Data Complete "  View-as ALERT-BOX INFORMATION.  
              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_noticancel C-Win 
PROCEDURE import_noticancel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A65-0288     
------------------------------------------------------------------------------*/
FOR EACH  wcancel :
    DELETE  wcancel.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wcancel.
    IMPORT DELIMITER "|" 
        wcancel.num                     /*No.                    */       
        wcancel.Cdate                   /*Cancel Date            */       
        wcancel.ProductSub              /*Product Sub Group      */       
        wcancel.ProductCode             /*Product Code           */       
        wcancel.PackageCode             /*Package Code           */       
        wcancel.PackageName             /*Package Name           */       
        wcancel.Insurer                 /*Insurer                */       
        wcancel.KKApp                   /*KK Application No.     */       
        wcancel.KKQuo                   /*KK Quotation No.       */       
        wcancel.RiderNo                 /*Rider No.              */       
        wcancel.InsurerApp              /*Insurer Application No.*/       
        wcancel.LoanContract            /*Loan Contract No.      */       
        wcancel.Notified                /*Notified No.           */       
        wcancel.Policy                  /*Policy No.             */       
        wcancel.PolType                 /*Policy Type            */       
        wcancel.AppDate                 /*Application Date       */       
        wcancel.PolAppDate              /*Policy Approve Date    */       
        wcancel.EffDate                 /*Effective Date         */       
        wcancel.ExpDate                 /*Expired Date           */       
        wcancel.Rencnt                  /*New/Renew              */       
        wcancel.polstatus               /*Policy Status          */       
        wcancel.YR                      /*Year                   */       
        wcancel.SI                      /*Sum Insure             */       
        wcancel.NetPrem                 /*Net Premium            */       
        wcancel.Stamp                   /*Stamp                  */       
        wcancel.VAT                     /*VAT                    */       
        wcancel.Grossprm                /*Gross Premium          */       
        wcancel.Wht                     /*Wht                    */       
        wcancel.PremAmt                 /*Premium Amount         */       
        wcancel.DiscountAmt             /*Discount Amount        */       
        wcancel.ActualPrm               /*Actual Premium         */       
        wcancel.PayInsAmt               /*Pay to Insurer Amount  */       
        wcancel.PrmReceiveTyp           /*Premium Receive Type   */       
        wcancel.Creason                 /*Cancel Reason          */       
        wcancel.CreasonDesc             /*Cancel Reason Description*/     
        wcancel.Remark                  /*Remark             */           
        wcancel.BRCode                  /*Branch Code        */           
        wcancel.BRName                  /*Branch Name        */           
        wcancel.BU                      /*BU                 */           
        wcancel.KKFlag                  /*KK Offer Flag      */           
        wcancel.InsCardType             /*Insured Card Type  */           
        wcancel.InsCardNo               /*Insured Card No.   */           
        wcancel.InsType                 /*Insured Type       */           
        wcancel.InsTitleName            /*Insured TitleName  */           
        wcancel.InsName                 /*Insured Name       */           
        wcancel.LicenseNo               /*Car License No.    */           
        wcancel.LicenseIssue            /*Car License Issue  */           
        wcancel.Chassis                 /*Car Chassis No.    */           
        wcancel.AgentTName              /*Agent TitleName    */           
        wcancel.AgentName .             /*Agent Name         */           
END.                                                                      
/* repeat  */
ASSIGN  nv_error   = 0     
    nv_completecnt = 0 .  

FOR EACH wcancel .
    IF      INDEX(wcancel.Cdate ,"Date") <> 0   THEN DELETE wcancel.
    ELSE IF       wcancel.Cdate   =  " "          THEN DO: 
        ASSIGN nv_error = nv_error + 1 .
        DELETE wcancel.
    END.
    /*ELSE IF wcancel.Notified  = "" AND wcancel.kkapp = ""  THEN DO:
        ASSIGN nv_error = nv_error + 1 .
        Message "�Ţ�Ѻ���繤����ҧ " View-as alert-box. 
        DELETE wcancel.    /*add kridtiya i. A55-0029  */
    END.
    ELSE ASSIGN nv_error = nv_error + 1 .*/
END.
Run  Create_tlt4.  

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.
END.
ASSIGN 
    /*nv_error = nv_error - 1*/
    fi_completecnt  =  nv_completecnt 
    fi_error        =  nv_error - nv_completecnt   /*add kridtiya i. A55-0029 */
    nv_completecnt  =  0
    fi_impcnt       =  nv_reccnt .
Disp fi_completecnt   fi_impcnt  fi_error  with frame  fr_main.

Run Open_tlt.

Message "Load  Data Complete "  View-as alert-box.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_notinew C-Win 
PROCEDURE import_notinew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_dataerr AS CHAR INIT "".
DEF VAR nv_nochar  AS CHAR INIT "".
                 /* repeat  */
ASSIGN  nv_error   = 0     /*add kridtiya i. A55-0029 */
    nv_completecnt = 0 .  
INPUT FROM VALUE(fi_FileName).
loop_load:
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        nv_nochar                 /*1 No.                                                    */   
        wdetail.sdate             /*2 Source System                                          */   
        wdetail.uniqsource        /*3 Uniq ID Source System                                  */   
        wdetail.comp_code         /*4 Insurer Name                                           */   
        wdetail.kkapp             /*5 KK Application No.                                     */   
        wdetail.quo               /*6 KK Quotation No.                                       */   
        wdetail.offerf            /*7 KK Offer Flag                                          */   
        wdetail.kkst              /*8 New/Renew                                              */   
        wdetail.trndat            /*9 Transaction Date                                       */   
        wdetail.appdat            /*10    Application Date                                   */   
        wdetail.comdat            /*11    Effective Date                                     */   
        wdetail.expdat            /*12    Expired Date                                       */   
        wdetail.insapp            /*13    Insurer Application No.                            */   
        wdetail.insquo            /*14    Insurer Quotation No.                              */   
        wdetail.poltyp            /*15    Policy Type                                        */   
        wdetail.mapp              /*16    Main App No.                                       */   
        wdetail.rid               /*17    Rider No.                                          */   
        wdetail.prepol            /*18    Previous Policy No.                                */   
        wdetail.product           /*19    Product Name                                       */   
        wdetail.pack              /*20    Package Code                                       */   
        wdetail.packnme           /*21    Package Name                                       */   
        wdetail.cmbr_no           /*22    Branch                                             */   
        wdetail.cmbr_code         /*23    BU/RC                                              */   
        wdetail.buagent           /*24    Agent                                              */   
        wdetail.payidtyp          /*25    Payer ID Card Type                                 */   
        wdetail.taxno             /*26    Payer ID Card No.                                  */   
        wdetail.paytyp            /*27    Payer Type                                         */   
        wdetail.reci_title        /*28    Payer TitleName                                    */   
        wdetail.reci_name1        /*29    Payer Name                                         */   
        wdetail.projnme           /*30    Project Name                                       */   
        wdetail.reci_address      /*31    Address_Receipt                                    */   
        wdetail.reci_addno        /*32    AddressNo_Receipt                                  */   
        wdetail.reci_addmu        /*33    Moo_Receipt                                        */   
        wdetail.reci_addbuild     /*34    VillageBuilding_Receipt                            */   
        wdetail.floor             /*35    Floor_Receipt                                      */   
        wdetail.room              /*36    RoomNumber_Receipt                                 */   
        wdetail.reci_addsoy       /*37    Soi_Receipt                                        */   
        wdetail.reci_addroad      /*38    Street_Receipt                                     */   
        wdetail.reci_addtambon    /*39    SubDistrict_Receipt                                */   
        wdetail.reci_addamper     /*40    District_Receipt                                   */   
        wdetail.reci_addcounty    /*41    Province_Receipt                                   */   
        wdetail.reci_addcty       /*42    Country_Receipt                                    */   
        wdetail.reci_addpost      /*43    ZipCode_Receipt                                    */   
        wdetail.cifno             /*44    CIF No.                                            */   
        wdetail.typper            /*45    Insured ID Card Type                               */   
        wdetail.icno              /*46    Insured ID Card No.                                */   
        wdetail.instyp            /*47    Insured Type                                       */   
        wdetail.n_TITLE           /*48    Insured TitleName                                  */   
        wdetail.n_name1           /*49    Insured Name                                       */   
        wdetail.bdate             /*50    Insured Birthdate                                  */   
        wdetail.age               /*51    Insured Age                                        */   
        wdetail.gender            /*52    Insured Gender                                     */   
        wdetail.nat               /*53    Insured Nationality                                */   
        wdetail.cstatus           /*54    Insured Marital Status                             */   
        wdetail.tel1              /*55    Insured Telephone 1                                */   
        wdetail.tel2              /*56    Insured Telephone 2                                */   
        wdetail.tel3              /*57    Insured Telephone 3                                */   
        wdetail.email             /*58    Insured Email                                      */   
        wdetail.occup             /*59    Insured Occupation                                 */   
        wdetail.insbus            /*60    Insured BusinessType                               */   
        wdetail.TAddress          /*61    Tax_Address                                        */   
        wdetail.TAddressNo        /*62    Tax_Address No.                                    */   
        wdetail.TMoo              /*63    Tax_Moo                                            */   
        wdetail.TVillageBuilding  /*64    Tax_VillageBuilding                                */   
        wdetail.TFloor            /*65    Tax_Floor                                          */   
        wdetail.TRoomNumber       /*66    Tax_RoomNumber                                     */   
        wdetail.TSoi              /*67    Tax_Soi                                            */   
        wdetail.TStreet           /*68    Tax_Street                                         */   
        wdetail.TSubDistrict      /*69    Tax_SubDistrict                                    */   
        wdetail.TDistrict         /*70    Tax_District                                       */   
        wdetail.TProvince         /*71    Tax_Province                                       */   
        wdetail.TCountry          /*72    Tax_Country                                        */   
        wdetail.TZipCode          /*73    Tax_ZipCode                                        */   
        wdetail.caddress          /*74    Contact_Address                                    */   
        wdetail.ADD_no            /*75    Contact_Address No.                                */   
        wdetail.ADD_mu            /*76    Contact_Moo                                        */   
        wdetail.ADD_muban         /*77    Contact_VillageBuilding                            */   
        wdetail.ADD_floor         /*78    Contact_Floor                                      */   
        wdetail.ADD_room          /*79    Contact_RoomNumber                                 */   
        wdetail.ADD_soy           /*80    Contact_Soi                                        */   
        wdetail.ADD_road          /*81    Contact_Street                                     */   
        wdetail.ADD_thambon       /*82    Contact_SubDistrict                                */   
        wdetail.ADD_amper         /*83    Contact_District                                   */   
        wdetail.ADD_country       /*84    Contact_Province                                   */   
        wdetail.ADD_cty           /*85    Contact_Country                                    */   
        wdetail.ADD_post          /*86    Contact_ZipCode                                    */   
        wdetail.sendname          /*87    Contact Person                                     */   
        wdetail.ADD_tel           /*88    Contact Telephone                                  */   
        wdetail.bentyp            /*89    BeneficiaryType                                    */   
        wdetail.benname           /*90    BeneficiaryName                                    */   
        wdetail.period            /*91    Payment Period                                     */   
        wdetail.ins_amt1          /*92    Sum Insure                                         */   
        wdetail.prem1             /*93    Net Premium (Yearly)                               */   
        wdetail.ostp              /*94    Stamp Premium (Yearly)                             */   
        wdetail.otax              /*95    Vat Premium (Yearly)                               */   
        wdetail.prem2             /*96    Gross Premium (Yearly)                             */   
        wdetail.whtprem           /*97    WHT Premium (Yearly)                               */   
        wdetail.premamt           /*98    Premium Amount (Yearly)                            */   
        wdetail.foprem            /*99    Net Premium (First Installment)                    */   
        wdetail.fostp             /*100   Stamp Premium (First Installment)                  */   
        wdetail.fotax             /*101   Vat Premium (First Installment)                    */   
        wdetail.fprem1            /*102   Gross Premium (First Installment)                  */   
        wdetail.fwhtprem          /*103   WHT Premium (First Installment)                    */   
        wdetail.fpremamt          /*104   Premium Amount (First Installment)                 */   
        wdetail.noprem            /*105   Net Premium (Next Installment)                     */   
        wdetail.nostp             /*106   Stamp Premium (Next Installment)                   */   
        wdetail.notax             /*107   Vat Premium (Next Installment)                     */   
        wdetail.nprem1            /*108   Gross Premium (Next Installment)                   */   
        wdetail.nwhtprem          /*109   WHT Premium (Next Installment)                     */   
        wdetail.npremamt          /*110   Premium Amount (Next Installment)                  */   
        wdetail.bennam            /*111   Remark                                             */   
        wdetail.cedpol            /*112   Loan Contract                                      */   
        wdetail.LProductCode      /*113   LoanProductCode                                    */   
        wdetail.LProductName      /*114   LoanProductName                                    */   
        wdetail.LApproveDate      /*115   LoanApproveDate                                    */   
        wdetail.LBookDate         /*116   LoanBookDate                                       */   
        wdetail.LCreditLine       /*117   LoanCreditLine                                     */   
        wdetail.LStatus           /*118   LoanStatus                                         */   
        wdetail.LInstallmentAMT   /*119   LoanInstallmentAMT                                 */   
        wdetail.LInstallment      /*120   LoanInstallment                                    */   
        wdetail.LRate             /*121   LoanRate                                           */   
        wdetail.LFirstDueDate     /*122   LoanFirstDueDate                                   */   
        wdetail.dealer            /*123   Dealer                                             */   
        wdetail.notifyno          /*124   �Ţ����Ѻ��                                      */   
        wdetail.Notify_dat        /*125   �ѹ��������͡�Ţ����Ѻ��/�ú                     */   
        wdetail.covtyp            /*126   ��������Ѿ���Թ                                    */   
        wdetail.subcov            /*127   ���������·�Ѿ���Թ                                */   
        wdetail.subclass          /*128   ����ö                                             */   
        wdetail.vehuse            /*129   ������ö                                           */   
        wdetail.brand             /*130   ������ö                                           */   
        wdetail.model             /*131   ���ö                                             */   
        wdetail.nSTATUS           /*132   New/Used                                           */   
        wdetail.licence           /*133   �Ţ����¹ö                                       */   
        wdetail.prolice           /*134   �ѧ��Ѵ����͡�Ţ����¹                            */   
        wdetail.chassis           /*135   �Ţ����Ƕѧö                                     */   
        wdetail.engine            /*136   �Ţ�������ͧ¹��                                  */   
        wdetail.cyear             /*137   �շ���Եö¹��                                    */   
        wdetail.power             /*138   ��Ҵ�ի�ö                                         */   
        wdetail.weight            /*139   ���˹ѡ/�ѹ                                        */   
        wdetail.dcar              /*140   ��Ҵ�ի�ö/���˹ѡ/�ѹ                             */
        wdetail.hp              /*A67-0076*/
        wdetail.mile              /*141   �Ţ���� (��.)                                      */   
        wdetail.garage            /*142   ��������ë������ا                                 */   
        wdetail.n_43              /*143   ������ ��.                                         */   
        wdetail.drilic1           /*144   �Ţ㺢Ѻ��� 1                                      */
        wdetail.drititle1 
        wdetail.name1             /*145   ���Ѻ����� 1                                     */   
        wdetail.drivno1           /*146   �ѹ�Դ���Ѻ����� 1                              */ 
        wdetail.drigender1
        wdetail.drioccup1
        wdetail.driToccup1
        wdetail.driTicono1
        wdetail.driICNo1
        wdetail.drilic2           /*147   �Ţ㺢Ѻ��� 2                                      */ 
        wdetail.drititle2
        wdetail.name2             /*148   ���Ѻ����� 2                                     */   
        wdetail.drivno2           /*149   �ѹ�Դ���Ѻ����� 2                              */ 
        wdetail.drigender2
        wdetail.drioccup2
        wdetail.driToccup2
        wdetail.driTicono2
        wdetail.driICNo2
        wdetail.drilic3
        wdetail.drititle3
        wdetail.driname3
        wdetail.drivno3 
        wdetail.drigender3
        wdetail.drioccup3
        wdetail.driToccup3
        wdetail.driTicono3
        wdetail.driICNo3
        wdetail.drilic4
        wdetail.drititle4
        wdetail.driname4
        wdetail.drivno4 
        wdetail.drigender4
        wdetail.drioccup4
        wdetail.driToccup4
        wdetail.driTicono4
        wdetail.driICNo4
        wdetail.drilic5
        wdetail.drititle5
        wdetail.driname5
        wdetail.drivno5 
        wdetail.drigender5
        wdetail.drioccup5
        wdetail.driToccup5
        wdetail.driTicono5
        wdetail.driICNo5
        wdetail.hcf               /*150   Hold Claim Flag                                    */
        wdetail.dateregis
        wdetail.colors            /* ��ö : A65-0288*/ 
        wdetail.pay_option
        wdetail.battno
        wdetail.battyr
        wdetail.maksi
        wdetail.chargno
        wdetail.veh_key
        wdetail.remark            /* �����˵� */                
        wdetail.recive_dat        /* �ѹ����� KK     */       
        wdetail.stp               /* ʶҹЧҹ�Դ�ѭ��  */       
        wdetail.brancho           /* �Ң�              */       
        wdetail.dealero           /* Dealer            */       
        wdetail.campaigno         /* ��໭            */       
        wdetail.inpection          /* ��Ǩ��Ҿ :A65-0288 */    
        .
    nv_dataerr = "".
    RUN IMPORT_notinewtrim.
    RUN IMPORT_notinewchk(OUTPUT nv_dataerr).
    IF nv_dataerr =  "Head" THEN DO:
        DELETE wdetail.
        NEXT loop_load.
    END.
    ELSE IF nv_dataerr <> "" THEN DO:
        MESSAGE nv_dataerr VIEW-AS ALERT-BOX INFORMATION.
        nv_error  = nv_error  + 1.
        DELETE wdetail.
        NEXT loop_load.
    END.
END.
INPUT CLOSE.
FOR EACH wdetail :
    IF  wdetail.Notify_dat   =  " "   OR wdetail.sdate = "Source System"       THEN DO: 
        /*ASSIGN nv_error = nv_error + 1 .*/
        DELETE wdetail.
        NEXT.
    END.
    ELSE IF wdetail.chassis  = "" THEN DO:
        ASSIGN nv_error = nv_error + 1 .
        Message "���Ţ��Ƕѧ�繤����ҧ : " wdetail.notifyno  View-as alert-box. 
        DELETE wdetail.    /*add kridtiya i. A55-0029  */
    END.
    /*ELSE ASSIGN nv_error = nv_error + 1 . */
END.

Run  Create_tltnew.  

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.
END.
ASSIGN 
    /*nv_error = nv_error - 1*/
    fi_completecnt  =  nv_completecnt 
    fi_error        =  nv_error
   
    fi_impcnt       =  nv_completecnt  +  nv_error
     nv_completecnt  =  0.
Disp fi_completecnt   fi_impcnt  fi_error  with frame  fr_main.

Run Open_tlt.

Message "Load  Data Complete "  View-as ALERT-BOX INFORMATION.  
              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE IMPORT_notinewchk C-Win 
PROCEDURE IMPORT_notinewchk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF OUTPUT PARAMETER nv_errorfile AS CHAR INIT "".
DEF VAR nv_deci1 AS DECI INIT 0.
DEF VAR nv_deci2 AS DECI INIT 0.
nv_deci1 = deci(wdetail.power   ) no-error.
nv_deci2 = deci(wdetail.weight  ) no-error.
IF wdetail.sdate = "Source System"   THEN DO:
    nv_errorfile = "HEAD".

END.
/*A67-0076 */
ELSE IF index(wdetail.subclass,"E") <> 0 AND INTE(wdetail.hp) = 0 THEN DO: 
    nv_errorfile = wdetail.subclass + " : ��س��к��ç��� ( Power ) ".
END.
/*end : A67-0076 */
ELSE IF nv_deci1 = 0 AND nv_deci1 = nv_deci2 THEN DO: 
    IF (wdetail.dcar >= "11" AND wdetail.dcar <= "13") OR 
       (wdetail.dcar >= "31" AND wdetail.dcar <= "52") THEN DO:
    END.
    ELSE nv_errorfile = "Not found Ton or CC  Notify No : " + wdetail.notifyno.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE IMPORT_notinewtrim C-Win 
PROCEDURE IMPORT_notinewtrim :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN                                                        
    wdetail.sdate           = trim(  wdetail.sdate            ) 
    wdetail.uniqsource      = trim(  wdetail.uniqsource       )  /*2 Uniq ID Source System*/ /*wdetail.recive_dat    /*2 �ѹ����Ѻ�Թ������»�Сѹ         */  */
    wdetail.comp_code       = trim(  wdetail.comp_code        )  /*3 ��ª��ͺ���ѷ��Сѹ���              */  
    wdetail.kkapp           = trim(  wdetail.kkapp            )  /*4 KK APP */ 
    wdetail.quo             = trim(  wdetail.quo              )  /*5 Quotation */
    wdetail.offerf          = trim(  wdetail.offerf           )  /*6 KK Offer Flag */
    wdetail.kkst            = trim(  wdetail.kkst             )  /*7 New/Renew*/
    wdetail.trndat          = trim(  wdetail.trndat           )  /*8 Transaction Date*/
    wdetail.appdat          = trim(  wdetail.appdat           )  /*9 Application Date*/
    wdetail.comdat          = trim(  wdetail.comdat           )  /*10 �ѹ�����������ͧ                   */  
    wdetail.expdat          = trim(  wdetail.expdat           )  /*11 �ѹ����ش������ͧ                 */  
    wdetail.insapp          = trim(  wdetail.insapp           )  /*12 Insurer Application No.*/
    wdetail.insquo          = trim(  wdetail.insquo           )  /*13 Insurer Quotation No.*/
    wdetail.poltyp          = trim(  wdetail.poltyp           )  /*14 Policy Type*/
    wdetail.mapp            = trim(  wdetail.mapp             )  /*15Main App No*/
    wdetail.rid             = trim(  wdetail.rid              )  /*16 Rider No.*/
    wdetail.prepol          = trim(  wdetail.prepol           )  /*17 Previous Policy No*/
    wdetail.product         = trim(  wdetail.product          )  /*18 Product Name*/
    wdetail.pack            = trim(  wdetail.pack             )  /*19 Package*/
    wdetail.packnme         = trim(  wdetail.packnme          )  /*20 Package Name*/
    wdetail.cmbr_no         = trim(  wdetail.cmbr_no          )  /*21 �����Ң�                            */
    wdetail.cmbr_code       = trim(  wdetail.cmbr_code        )  /*22 BU/RC                               */ /*wdetail.cmbr_code       /*7 �Ң� KK                             */  */ 
    wdetail.buagent         = trim(  wdetail.buagent          )  /*23 Agent                              */  /*wdetail.cmbr_code       /*7 �Ң� KK                             */  */ 
    wdetail.payidtyp        = trim(  wdetail.payidtyp         )  /*24 Payer ID Card Type*/
    wdetail.taxno           = trim(  wdetail.taxno            )  /*25 �Ţ��Шӵ�Ǽ�����������ҡ�         */  
    wdetail.paytyp          = trim(  wdetail.paytyp           )  /*26 Payer Type*/
    wdetail.reci_title      = trim(  wdetail.reci_title       )  /*27 �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����) */  
    wdetail.reci_name1      = trim(  wdetail.reci_name1       )  /*28 ���� (�����/㺡ӡѺ����)         */  
    wdetail.projnme         = trim(  wdetail.projnme          )  /*29 Project Name*/
    wdetail.reci_address    = trim(  wdetail.reci_address     )  /*30  Address*/
    wdetail.reci_addno      = trim(  wdetail.reci_addno       )  /*31 ��ҹ�Ţ���(�����/㺡ӡѺ����) */
    wdetail.reci_addmu      = trim(  wdetail.reci_addmu       )  /*32 �����ҹ (�����/㺡ӡѺ����)     */    
    wdetail.reci_addbuild   = trim(  wdetail.reci_addbuild    )  /*33 �Ҥ�� (�����/㺡ӡѺ����)        */    
    wdetail.floor           = trim(  wdetail.floor            )  /*34*/
    wdetail.room            = trim(  wdetail.room             )  /*35*/                                          
    wdetail.reci_addsoy     = trim(  wdetail.reci_addsoy      )  /*36 ��� (�����/㺡ӡѺ����)          */    
    wdetail.reci_addroad    = trim(  wdetail.reci_addroad     )  /*27 ��� (�����/㺡ӡѺ����)          */    
    wdetail.reci_addtambon  = trim(  wdetail.reci_addtambon   )  /*38 �Ӻ�/�ǧ (�����/㺡ӡѺ����)    */    
    wdetail.reci_addamper   = trim(  wdetail.reci_addamper    )  /*39 �����/ࢵ (�����/㺡ӡѺ����)    */ 
    wdetail.reci_addcounty  = trim(  wdetail.reci_addcounty   )  /*40 �ѧ��Ѵ (�����/㺡ӡѺ����)      */    
    wdetail.reci_addcty     = trim(  wdetail.reci_addcty      )  /*41  Country_Receipt*/         
    wdetail.reci_addpost    = trim(  wdetail.reci_addpost     )  /*42 ������ɳ��� (�����/㺡ӡѺ����) */ 
    wdetail.cifno           = trim(  wdetail.cifno            )  /*43 CIF No.*/
    wdetail.typper          = trim(  wdetail.typper           )  /*44 �������ؤ��                        */  
    wdetail.icno            = trim(  wdetail.icno             )  /*45 �Ţ���ѵû�ЪҪ�                  */  
    wdetail.instyp          = trim(  wdetail.instyp           )  /*46 Insure Type*/
    wdetail.n_TITLE         = trim(  wdetail.n_TITLE          )  /*47 �ӹ�˹�Ҫ���                       */  
    wdetail.n_name1         = trim(  wdetail.n_name1          )  /*48 ���ͼ����һ�Сѹ���                */  
    wdetail.bdate           = trim(  wdetail.bdate            )  /*49 �ѹ��͹���Դ                     */  
    wdetail.age             = trim(  wdetail.age              )  /*50 Insured Age*/     
    wdetail.gender          = trim(  wdetail.gender           )  /*51 Gender*/   
    wdetail.nat             = trim(  wdetail.nat              )  /*52 Nationality*/  
    wdetail.cstatus         = trim(  wdetail.cstatus          )  /*53 Insured MaritalStatus              */  
    wdetail.tel1            = trim(  wdetail.tel1             )  /*54 ����Դ���                        */  
    wdetail.tel2            = trim(  wdetail.tel2             )  /*55 ����Դ���                        */  
    wdetail.tel3            = trim(  wdetail.tel3             )  /*56 ����Դ���                        */  
    wdetail.email           = trim(  wdetail.email            )  /*57 Email                              */
    wdetail.occup           = trim(  wdetail.occup            )  /*58 �Ҫվ                              */
    wdetail.insbus          = trim(  wdetail.insbus           )  /*59 Insured Business Type              */
    wdetail.TAddress        = trim(  wdetail.TAddress         )  /*60 address �������¹��ҹ*/ 
    wdetail.TAddressNo      = trim(  wdetail.TAddressNo       )  /*61 address �������¹��ҹ*/ 
    wdetail.TMoo            = trim(  wdetail.TMoo             )  /*62 address �������¹��ҹ*/ 
    wdetail.TVillageBuilding= trim(  wdetail.TVillageBuilding )  /*63 address �������¹��ҹ*/ 
    wdetail.TFloor          = trim(  wdetail.TFloor           )  /*64 address �������¹��ҹ*/ 
    wdetail.TRoomNumber     = trim(  wdetail.TRoomNumber      )  /*65 address �������¹��ҹ*/ 
    wdetail.TSoi            = trim(  wdetail.TSoi             )  /*66 address �������¹��ҹ*/ 
    wdetail.TStreet         = trim(  wdetail.TStreet          )  /*67 address �������¹��ҹ*/ 
    wdetail.TSubDistrict    = trim(  wdetail.TSubDistrict     )  /*68 address �������¹��ҹ*/ 
    wdetail.TDistrict       = trim(  wdetail.TDistrict        )  /*69 address �������¹��ҹ*/ 
    wdetail.TProvince       = trim(  wdetail.TProvince        )  /*70 address �������¹��ҹ*/ 
    wdetail.TCountry        = trim(  wdetail.TCountry         )  /*71 address �������¹��ҹ*/ 
    wdetail.TZipCode        = trim(  wdetail.TZipCode         )  /*72 address �������¹��ҹ*/ 
    wdetail.caddress        = trim(  wdetail.caddress         )  /*73 Contact Address*/
    wdetail.ADD_no          = trim(  wdetail.ADD_no           )  /*74 ��ҹ�Ţ���                         */  
    wdetail.ADD_mu          = trim(  wdetail.ADD_mu           )  /*75 ����                               */  
    wdetail.ADD_muban       = trim(  wdetail.ADD_muban        )  /*76 �����ҹ                           */ 
    wdetail.ADD_floor       = trim(  wdetail.ADD_floor        )  /*77*/
    wdetail.ADD_room        = trim(  wdetail.ADD_room         )  /*78*/
    wdetail.ADD_soy         = trim(  wdetail.ADD_soy          )  /*79 ���                                */  
    wdetail.ADD_road        = trim(  wdetail.ADD_road         )  /*80 ���                                */  
    wdetail.ADD_thambon     = trim(  wdetail.ADD_thambon      )  /*81 �Ӻ�/�ǧ                          */  
    wdetail.ADD_amper       = trim(  wdetail.ADD_amper        )  /*82 �����/ࢵ                          */  
    wdetail.ADD_country     = trim(  wdetail.ADD_country      )  /*83 �ѧ��Ѵ                            */  
    wdetail.ADD_cty         = trim(  wdetail.ADD_cty          )  /*84 country */
    wdetail.ADD_post        = trim(  wdetail.ADD_post         )  /*85 ������ɳ���                       */
    wdetail.sendname        = trim(  wdetail.sendname         )  /*86*/
    wdetail.ADD_tel         = trim(  wdetail.ADD_tel          )  /*87*/
    wdetail.bentyp          = trim(  wdetail.bentyp           )  /*88*/
    wdetail.benname         = trim(  wdetail.benname          )  /* 89 ����Ѻ�Ż���ª��*/
    wdetail.period          = trim(  wdetail.period           )  /*90*/ 
    wdetail.ins_amt1        = trim(  wdetail.ins_amt1         )  /*91 �ع��Сѹ�� 1                      */  
    wdetail.prem1           = trim(  wdetail.prem1            )  /*92*/
    wdetail.ostp            = trim(  wdetail.ostp             )  /*93stamp*/
    wdetail.otax            = trim(  wdetail.otax             )  /*94*/ 
    wdetail.prem2           = trim(  wdetail.prem2            )  /*95 ���������������ҡû� 1            */  
    wdetail.whtprem         = trim(  wdetail.whtprem          )  /*96 WHT Premium (Yearly)*/
    wdetail.premamt         = trim(  wdetail.premamt          )  /*97 ���������������ҡû� 1            */    
    wdetail.foprem          = trim(  wdetail.foprem           )  /*98*/
    wdetail.fostp           = trim(  wdetail.fostp            )  /*99 stamp*/
    wdetail.fotax           = trim(  wdetail.fotax            )  /*100*/ 
    wdetail.fprem1          = trim(  wdetail.fprem1           )  /*101 ���������������ҡû� 1            */  
    wdetail.fwhtprem        = trim(  wdetail.fwhtprem         )  /*102 WHT Premium (Yearly)*/
    wdetail.fpremamt        = trim(  wdetail.fpremamt         )  /*103 ���������������ҡû� 1            */  
    wdetail.noprem          = trim(  wdetail.noprem           )  /*104*/
    wdetail.nostp           = trim(  wdetail.nostp            )  /*105 stamp*/
    wdetail.notax           = trim(  wdetail.notax            )  /*106*/ 
    wdetail.nprem1          = trim(  wdetail.nprem1           )  /*107 ���������������ҡû� 1            */  
    wdetail.nwhtprem        = trim(  wdetail.nwhtprem         )  /*108 WHT Premium (Yearly)*/
    wdetail.npremamt        = trim(  wdetail.npremamt         )  /*109 ���������������ҡû� 1            */  
    wdetail.bennam          = trim(  wdetail.bennam           )  /*110 �����˵�                           */  
    wdetail.cedpol          = trim(  wdetail.cedpol           )  /*111 Loan Contract               */   
    wdetail.LProductCode    = trim(  wdetail.LProductCode     )  /*112  �Ţ��Ե�ѳ���Թ���� (PDM)                            */
    wdetail.LProductName    = trim(  wdetail.LProductName     )  /*113  ���ͼ�Ե�ѳ���Թ���� (PDM)                           */
    wdetail.LApproveDate    = trim(  wdetail.LApproveDate     )  /*114  �ѹ���͹��ѵ��Թ����                                 */
    wdetail.LBookDate       = trim(  wdetail.LBookDate        )  /*115  �ѹ��� Book Loan                                      */
    wdetail.LCreditLine     = trim(  wdetail.LCreditLine      )  /*116  ǧ�Թ�Թ����                                        */
    wdetail.LStatus         = trim(  wdetail.LStatus          )  /*117  ʶҹТͧ�Թ���� ** ʶҹТͧ�Թ����                  */
    wdetail.LInstallmentAMT = trim(  wdetail.LInstallmentAMT  )  /*118  ��ҧǴ�Թ����                                        */
    wdetail.LInstallment    = trim(  wdetail.LInstallment     )  /*119  �ӹǹ�Ǵ                                              */
    wdetail.LRate           = trim(  wdetail.LRate            )  /*120  �ѵ�Ҵ͡����                                         */
    wdetail.LFirstDueDate   = trim(  wdetail.LFirstDueDate    )  /*121  �ѹ���ú��˹����ЧǴ�á                              */
    wdetail.dealer          = trim(  wdetail.dealer           )  /*122  Dealer A63-00472 kridtiya i.*/
    wdetail.notifyno        = trim(  wdetail.notifyno         )  /*123 �Ţ�Ѻ��                          */  
    wdetail.Notify_dat      = trim(  wdetail.Notify_dat       )  /*1 �ѹ����Ѻ��                       */ 
    wdetail.covtyp          = trim(  wdetail.covtyp           )  /*125 ��������Ѿ���Թ                 */
    wdetail.subcov          = trim(  wdetail.subcov           )  /*126 ���������·�Ѿ���Թ             */
    wdetail.subclass        = trim(  wdetail.subclass         )  /*127 ����ö                             */  
    wdetail.vehuse          = trim(  wdetail.vehuse           )  /*128 vehuse*/ 
    wdetail.brand           = trim(  wdetail.brand            )  /*129 ����������ö                       */  
    wdetail.model           = trim(  wdetail.model            )  /*130 ���ö                             */  
    wdetail.nSTATUS         = trim(  wdetail.nSTATUS          )  /*131 New/Used                           */  
    wdetail.licence         = trim(  wdetail.licence          )  /*132 �Ţ����¹                         */  
    wdetail.prolice         = trim(  wdetail.prolice          )  /*133*/
    wdetail.chassis         = trim(  wdetail.chassis          )  /*134 �Ţ��Ƕѧ                          */  
    wdetail.engine          = trim(  wdetail.engine           )  /*135 �Ţ����ͧ¹��                     */  
    wdetail.cyear           = trim(  wdetail.cyear            )  /*136 ��ö¹��                           */  
    wdetail.power           = trim(  wdetail.power            )  /*137 �ի�                               */  
    wdetail.weight          = trim(  wdetail.weight           )  /*138 ���˹ѡ(�ѹ)                       */  
    wdetail.dcar            = trim(  wdetail.dcar             )  /*139 ��Ҵ�ի�ö/���˹ѡ/�ѹ*/
    wdetail.mile            = trim(  wdetail.mile             )  /*140  �Ţ����*/
    wdetail.garage          = trim(  wdetail.garage           )  /*141 ��������ë���                      */  
    wdetail.n_43            = trim(  wdetail.n_43             )  /*142 ��������Сѹ���ö¹��              */ 
    wdetail.drilic1         = trim(  wdetail.drilic1          )  /*143*/
    wdetail.name1           = trim(  wdetail.name1            )  /*144 ���͡������ 1                      */  
    wdetail.drivno1         = trim(  wdetail.drivno1          )  /*145 ���Ѻ����� 1 ����ѹ�Դ          */  
    wdetail.drilic2         = trim(  wdetail.drilic2          )  /*146*/
    wdetail.name2           = trim(  wdetail.name2            )  /*147 ���͡������ 1                      */  
    wdetail.drivno2         = trim(  wdetail.drivno2          )  /*148 ���Ѻ����� 2 ����ѹ�Դ          */  
    wdetail.hcf             = trim(  wdetail.hcf              )  /*149                                    */
    wdetail.recive_dat      = TRIM(  wdetail.recive_dat       )
    wdetail.remark          = trim(  wdetail.remark           )  /*150 Remark                             */                      
    wdetail.stp             = TRIM(  wdetail.stp              )  
    wdetail.brancho         = trim(  wdetail.brancho          )
    wdetail.dealero         = trim(  wdetail.dealero          )
    wdetail.campaigno       = TRIM(  wdetail.campaigno        )
    wdetail.colors          = TRIM(wdetail.colors)     /* ��ö  a65-0288*/
    wdetail.inpection       = IF TRIM(wdetail.inpection) = "" THEN "N" ELSE TRIM(wdetail.inpection)  /* ��Ǩ��Ҿ A65-0288 */
    /*  add by :  A67-0076 */
    wdetail.hp             = trim(wdetail.hp        )        
    wdetail.drititle1      = trim(wdetail.drititle1 )        
    wdetail.drigender1     = trim(wdetail.drigender1)        
    wdetail.drioccup1      = trim(wdetail.drioccup1 )        
    wdetail.driToccup1     = trim(wdetail.driToccup1)        
    wdetail.driTicono1     = trim(wdetail.driTicono1)        
    wdetail.driICNo1       = trim(wdetail.driICNo1  )        
    wdetail.drititle2      = trim(wdetail.drititle2 )        
    wdetail.drigender2     = trim(wdetail.drigender2)        
    wdetail.drioccup2      = trim(wdetail.drioccup2 )        
    wdetail.driToccup2     = trim(wdetail.driToccup2)        
    wdetail.driTicono2     = trim(wdetail.driTicono2)        
    wdetail.driICNo2       = trim(wdetail.driICNo2  )        
    wdetail.drilic3        = trim(wdetail.drilic3   )        
    wdetail.drititle3      = trim(wdetail.drititle3 )        
    wdetail.driname3       = trim(wdetail.driname3  )        
    wdetail.drivno3        = trim(wdetail.drivno3   )        
    wdetail.drigender3     = trim(wdetail.drigender3)        
    wdetail.drioccup3      = trim(wdetail.drioccup3 )        
    wdetail.driToccup3     = trim(wdetail.driToccup3)        
    wdetail.driTicono3     = trim(wdetail.driTicono3)        
    wdetail.driICNo3       = trim(wdetail.driICNo3  )        
    wdetail.drilic4        = trim(wdetail.drilic4   )        
    wdetail.drititle4      = trim(wdetail.drititle4 )        
    wdetail.driname4       = trim(wdetail.driname4  )        
    wdetail.drivno4        = trim(wdetail.drivno4   )        
    wdetail.drigender4     = trim(wdetail.drigender4)        
    wdetail.drioccup4      = trim(wdetail.drioccup4 )        
    wdetail.driToccup4     = trim(wdetail.driToccup4)        
    wdetail.driTicono4     = trim(wdetail.driTicono4)        
    wdetail.driICNo4       = trim(wdetail.driICNo4  )        
    wdetail.drilic5        = trim(wdetail.drilic5   )        
    wdetail.drititle5      = trim(wdetail.drititle5 )        
    wdetail.driname5       = trim(wdetail.driname5  )        
    wdetail.drivno5        = trim(wdetail.drivno5   )        
    wdetail.drigender5     = trim(wdetail.drigender5)        
    wdetail.drioccup5      = trim(wdetail.drioccup5 )        
    wdetail.driToccup5     = trim(wdetail.driToccup5)        
    wdetail.driTicono5     = trim(wdetail.driTicono5)        
    wdetail.driICNo5       = trim(wdetail.driICNo5  )        
    wdetail.dateregis      = trim(wdetail.dateregis )        
    wdetail.pay_option     = trim(wdetail.pay_option)        
    wdetail.battno         = trim(wdetail.battno    )        
    wdetail.battyr         = trim(wdetail.battyr    )        
    wdetail.maksi          = trim(wdetail.maksi     )        
    wdetail.chargno        = trim(wdetail.chargno   )        
    wdetail.veh_key        = trim(wdetail.veh_key   )        
    /* end : a67-0076*/
    .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_notiprob C-Win 
PROCEDURE import_notiprob :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_dataerr AS CHAR INIT "".
DEF VAR nv_nochar  AS CHAR INIT "".
                 /* repeat  */
ASSIGN  nv_error   = 0     /*add kridtiya i. A55-0029 */
    nv_completecnt = 0 .  
INPUT FROM VALUE(fi_FileName).
loop_load:
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.quo                /*1 No.                                                    */   
        wdetail.comp_code         /*4 Insurer Name                                           */   
        wdetail.product           /*19    Product Name                                       */   
        wdetail.packnme           /*21    Package Name                                       */   
        wdetail.kkst              /*8 New/Renew                                              */   
        wdetail.offerf            /*7 KK Offer Flag                                          */   
        wdetail.kkapp             /*5 KK Application No.                                     */   
        wdetail.quo               /*6 KK Quotation No.                                       */   
        wdetail.rid               /*17    Rider No.                                          */   
        wdetail.uniqsource        /*3 Uniq ID Source System                                  */   
        wdetail.cedpol            /*112   Loan Contract                                      */   
        wdetail.notifyno          /*124   �Ţ����Ѻ��                                      */   
        wdetail.Notify_dat        /*125   �ѹ��������͡�Ţ����Ѻ��/�ú                     */   
        wdetail.reci_name1        /*29    Payer Name                                         */   
        wdetail.n_name1           /*49    Insured Name                                       */   
        wdetail.tel1              /*55    Insured Telephone 1                                */   
        wdetail.tel2              /*56    Insured Telephone 2                                */   
        wdetail.tel3              /*57    Insured Telephone 3                                */   
        wdetail.buagent           /*24    Agent                                              */   
        wdetail.cmbr_no           /*22    Branch                                             */   
        wdetail.cmbr_code         /*23    BU/RC                                              */   
        wdetail.prem1             /*93    Net Premium (Yearly)                               */   
        wdetail.ostp              /*94    Stamp Premium (Yearly)                             */   
        wdetail.otax              /*95    Vat Premium (Yearly)                               */   
        wdetail.prem2             /*96    Gross Premium (Yearly)                             */   
        wdetail.drilic1        /*�ʴ��ѹ����駧ҹ�Դ�ѭ��                          */   
        wdetail.name1          /*�ʴ��ӴѺ�ҹ�Դ�ѭ�� (�к� KKINS Generate)         */   
        wdetail.drivno1        /*�ʴ���������´�ѭ��                                */   
        wdetail.drilic2        /*�ʴ� Flag �ҹ�Դ�ѭ�� Level Problem                */   
        wdetail.name2          /*�ʴ� Flag �ҹ�Դ�ѭ�� Level Application            */   
        wdetail.drivno2        /*�ʴ��ѹ����駡�Ѻ�ҹ�Դ�ѭ��                      */   
        wdetail.garage         /*�ʴ���������´��������еͺ��Ѻ�ҹ�Դ�ѭ��        */   
        wdetail.remark1  .       /*�����˵�                                           */   
        /*wdetail.hcf     A65-0288 */
        /*wdetail.remark  A65-0288 */
        /*wdetail.stp.    A65-0288 */

    ASSIGN
        wdetail.quo              = trim(wdetail.quo          )
        wdetail.comp_code        = trim(wdetail.comp_code    )
        wdetail.product          = trim(wdetail.product      )
        wdetail.packnme          = trim(wdetail.packnme      )
        wdetail.kkst             = trim(wdetail.kkst         )
        wdetail.offerf           = trim(wdetail.offerf       )
        wdetail.kkapp            = trim(wdetail.kkapp        )
        wdetail.quo              = trim(wdetail.quo          )
        wdetail.rid              = trim(wdetail.rid          )
        wdetail.uniqsource       = trim(wdetail.uniqsource   )
        wdetail.cedpol           = trim(wdetail.cedpol       )
        wdetail.notifyno         = trim(wdetail.notifyno     )
        wdetail.Notify_dat       = trim(wdetail.Notify_dat   )
        wdetail.reci_name1       = trim(wdetail.reci_name1   )
        wdetail.n_name1          = trim(wdetail.n_name1      )
        wdetail.tel1             = trim(wdetail.tel1         )
        wdetail.tel2             = trim(wdetail.tel2         )
        wdetail.tel3             = trim(wdetail.tel3         )
        wdetail.buagent          = trim(wdetail.buagent      )
        wdetail.cmbr_no          = trim(wdetail.cmbr_no      )
        wdetail.cmbr_code        = trim(wdetail.cmbr_code    )
        wdetail.prem1            = trim(wdetail.prem1        )
        wdetail.ostp             = trim(wdetail.ostp         )
        wdetail.otax             = trim(wdetail.otax         )
        wdetail.prem2            = trim(wdetail.prem2        )
        wdetail.drilic1          = trim(wdetail.drilic1      )
        wdetail.name1            = trim(wdetail.name1        )
        wdetail.drivno1          = trim(wdetail.drivno1      )
        wdetail.drilic2          = trim(wdetail.drilic2      )
        wdetail.name2            = trim(wdetail.name2        )
        wdetail.drivno2          = trim(wdetail.drivno2      )
        wdetail.garage           = trim(wdetail.garage       )
        wdetail.remark1          = trim(wdetail.remark1      ) .
        /*comment by : A65-0288..
        wdetail.hcf              = trim(wdetail.hcf          )
        wdetail.remark           = trim(wdetail.remark       )
        wdetail.stp              = trim(wdetail.stp          )
        .
        ..end A65-0288..*/


    nv_dataerr = "".
    IF
    wdetail.quo       =  trim("NO.         ") or
    wdetail.comp_code =  trim("Insurer Name") or
    wdetail.product   =  trim("Product Name") or
    wdetail.packnme   =  trim("Package     ")  THEN DO:
        DELETE wdetail.
        NEXT loop_load.
    END.
    ELSE IF nv_dataerr <> "" THEN DO:
        MESSAGE nv_dataerr VIEW-AS ALERT-BOX INFORMATION.
        nv_error  = nv_error  + 1.
        DELETE wdetail.
        NEXT loop_load.
    END.

END.
INPUT CLOSE.
FOR EACH wdetail WHERE 
    wdetail.comp_code     = "" and
    wdetail.product       = "" and
    wdetail.packnme       = "" and
    wdetail.kkst          = "" and
    wdetail.offerf        = "" and
    wdetail.kkapp         = "" and
    wdetail.quo           = "" and
    wdetail.rid           = "" and
    wdetail.uniqsource    = "" and
    wdetail.cedpol        = "" and
    wdetail.notifyno      = "" :

    DELETE wdetail.
END.
Run  Create_tltprob.  

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.
END.
ASSIGN 
    /*nv_error = nv_error - 1*/
    fi_completecnt  =  nv_completecnt 
    fi_error        =  nv_error
    
    fi_impcnt       =  nv_completecnt + nv_error 
    nv_completecnt  =  0.
Disp fi_completecnt   fi_impcnt  fi_error  with frame  fr_main.

Run Open_tlt.

/*----
Open Query br_imptxt  For each brstat.tlt  Use-index tlt01  where
               tlt.trndat     =  fi_loaddat   and
               (tlt.comp_sub   BEGINS "B3MLKK010" OR
                tlt.recac      =  fi_agent        ) AND
               tlt.genusr     =  "kk"  .--*/
Message "Load  Data Complete "  View-as ALERT-BOX INFORMATION.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Open_tlt C-Win 
PROCEDURE Open_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*---Begin by Chaiyong W. A64-0135 18/07/2021*/
DEF VAR nv_crecid AS CHAR INIT "".
/*DEF VAR nv_int    AS INT INIT 0.*/
/*End by Chaiyong W. A64-0135 18/07/2021-----*/
/*--
Open Query br_imptxt  For each brstat.tlt  Use-index tlt01  where
           tlt.trndat     =  fi_loaddat   and
           tlt.comp_sub   =  fi_producer  and
           tlt.genusr     =  "kk"  .
comment by Chaiyong W. A64-0135 18/07/2021*/

/*---Begin by Chaiyong W. A64-0135 18/07/2021*/
IF ra_filetyp <> 5 AND ra_filetyp <> 6 THEN DO:
    Open Query br_imptxt  For each brstat.tlt  Use-index tlt01  where
               tlt.trndat     =  fi_loaddat   and
               tlt.comp_sub   =  fi_producer  and
               tlt.genusr     =  "kk"  .
END.
ELSE DO:

    FOR EACH trecid :
        IF nv_crecid = "" THEN nv_crecid = string(trecid.nrecid).
        ELSE nv_crecid =  nv_crecid  + "," + string(trecid.nrecid).
             /*MESSAGE trecid.nrecid.*/
       /*nv_int = nv_int + 1.*/
    END.
    /*MESSAGE nv_int.*/
    
     Open Query br_imptxt  For each brstat.tlt  Use-index tlt01  where
               tlt.trndat     =  fi_loaddat   AND
               LOOKUP(string(RECID(tlt)),nv_crecid) <> 0 AND
               tlt.genusr     =  "kk"   NO-LOCK. 


           /*
     Open Query br_imptxt  For each brstat.tlt  Use-index tlt01  where
               tlt.trndat     =  fi_loaddat   and
               (tlt.comp_sub   BEGINS "B3MLKK010" OR
                tlt.recac      =  fi_agent        ) AND
               tlt.genusr     =  "kk" NO-LOCK .
         */
          
    /*
    Open Query br_imptxt  For each brstat.tlt  Use-index tlt01  where
               tlt.trndat     =  fi_loaddat   and
               (tlt.comp_sub   BEGINS "B3MLKK010" OR
                tlt.recac      =  fi_agent        ) AND
               tlt.genusr     =  "kk" NO-LOCK . /*,EACH trecid WHERE trecid.nrecid = RECID(tlt) NO-LOCK */*/

END.

/*End by Chaiyong W. A64-0135 18/07/2021-----*/



         

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_fall C-Win 
PROCEDURE pd_fall :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A65-0288      
------------------------------------------------------------------------------*/
DO:
    IF ra_filetyp = 6 THEN DO:
        OUTPUT TO VALUE(fi_kkhold) APPEND.
            EXPORT DELIMITER "|"
             wdetail.quo                  
             wdetail.comp_code          
             wdetail.product            
             wdetail.packnme            
             wdetail.kkst               
             wdetail.offerf             
             wdetail.kkapp              
             wdetail.quo                
             wdetail.rid                
             wdetail.uniqsource         
             wdetail.cedpol             
             wdetail.notifyno           
             wdetail.Notify_dat         
             wdetail.reci_name1         
             wdetail.n_name1            
             wdetail.tel1               
             wdetail.tel2               
             wdetail.tel3               
             wdetail.buagent            
             wdetail.cmbr_no            
             wdetail.cmbr_code          
             wdetail.prem1              
             wdetail.ostp               
             wdetail.otax               
             wdetail.prem2              
             wdetail.drilic1            
             wdetail.name1              
             wdetail.drivno1            
             wdetail.drilic2            
             wdetail.name2              
             wdetail.drivno2            
             wdetail.garage             
             wdetail.remark1  
             wdetail.remark
             wdetail.prepol
             wdetail.hcf 
             wdetail.stp  SKIP.
        OUTPUT CLOSE.

    END.
    IF ra_filetyp = 7 THEN DO:
        OUTPUT TO VALUE(fi_kkhold) APPEND.
            EXPORT DELIMITER "|"
             wpol.Num                   
             wpol.DueDate               
             wpol.AgingIssue            
             wpol.BRCode                
             wpol.BRName                
             wpol.BU                    
             wpol.Insurer               
             wpol.PD_SubGroup           
             wpol.PD_Code               
             wpol.Pack_Code             
             wpol.Pack_Name             
             wpol.AppDate               
             wpol.EffDate               
             wpol.ExpDate               
             wpol.KKApp                 
             wpol.KKQuo                 
             wpol.SourceID              
             wpol.InsAppNo              
             wpol.LoanNo                
             wpol.notifyno              
             wpol.NotifiedDate          
             wpol.PayTName              
             wpol.PayName               
             wpol.InsTName              
             wpol.InsName               
             wpol.SumInsure             
             wpol.NetPremium            
             wpol.Stamp                 
             wpol.VAT                   
             wpol.GrossPremium          
             wpol.PaymentPeriod         
             wpol.PolicyStatus          
             wpol.Chassis               
             wpol.KKOfferFlag           
             wpol.LicenseNo             
             wpol.LicenseProv 
             wpol.policy        
             wpol.Remark
             wpol.InspRemark
             wpol.Hproblem      
             wpol.Hclaim        
             wpol.PolStatus     
             wpol.premiumpol   
            SKIP.
        OUTPUT CLOSE.
    END.
    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_fca C-Win 
PROCEDURE pd_fca :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A65-0288      
------------------------------------------------------------------------------*/
DO:
    OUTPUT TO VALUE(fi_kkcom) APPEND.
        EXPORT DELIMITER "|"
         wcancel.num            
         wcancel.Cdate          
         wcancel.ProductSub     
         wcancel.ProductCode    
         wcancel.PackageCode    
         wcancel.PackageName    
         wcancel.Insurer        
         wcancel.KKApp          
         wcancel.KKQuo          
         wcancel.RiderNo        
         wcancel.InsurerApp     
         wcancel.LoanContract   
         wcancel.Notified       
         wcancel.Policy         
         wcancel.PolType        
         wcancel.AppDate        
         wcancel.PolAppDate     
         wcancel.EffDate        
         wcancel.ExpDate        
         wcancel.Rencnt         
         wcancel.polstatus      
         wcancel.YR             
         wcancel.SI             
         wcancel.NetPrem        
         wcancel.Stamp          
         wcancel.VAT            
         wcancel.Grossprm       
         wcancel.Wht            
         wcancel.PremAmt        
         wcancel.DiscountAmt    
         wcancel.ActualPrm      
         wcancel.PayInsAmt      
         wcancel.PrmReceiveTyp  
         wcancel.Creason        
         wcancel.CreasonDesc    
         wcancel.Remark         
         wcancel.BRCode         
         wcancel.BRName         
         wcancel.BU             
         wcancel.KKFlag         
         wcancel.InsCardType    
         wcancel.InsCardNo      
         wcancel.InsType        
         wcancel.InsTitleName   
         wcancel.InsName        
         wcancel.LicenseNo      
         wcancel.LicenseIssue   
         wcancel.Chassis        
         wcancel.AgentTName     
         wcancel.AgentName  
         wcancel.sts 
         wcancel.polno
         wcancel.releas   SKIP.
    OUTPUT CLOSE.
    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_fcom C-Win 
PROCEDURE pd_fcom :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_comchr AS CHAR INIT "".
DEF VAR nv_expchr AS CHAR INIT "".
DEF VAR nv_birchr AS CHAR INIT "".
DEF VAR nv_senchr AS CHAR INIT "".
DEF VAR nv_trnchr AS CHAR INIT "".
DEF VAR nv_saddr  AS CHAR INIT "".
DEF VAR nv_comcod AS CHAR INIT "".
DEF VAR nv_first AS CHAR INIT "".
def var n_text     as char format "x(255)" init "".
def var nv_icno3   as char format "x(15)" init "".
def var nv_lname3  as char format "x(45)" init "".
def var nv_cname3  as char format "x(45)" init "".
def var nv_tname3  as char format "x(20)" init "".
def var nv_icno2   as char format "x(15)" init "".
def var nv_lname2  as char format "x(45)" init "".
def var nv_cname2  as char format "x(45)" init "".
def var nv_tname2  as char format "x(20)" init "".
def var nv_icno1   as char format "x(15)" init "".
def var nv_lname1  as char format "x(45)" init "".
def var nv_cname1  as char format "x(45)" init "".
def var nv_tname1  as char format "x(20)" init "".
DEF VAR nv_Brancho  AS CHAR INIT "".
DEF VAR nv_dealero  AS CHAR INIT "". 
DEF VAR nv_campno   AS CHAR INIT "". 
DEF VAR nv_Seat     AS CHAR INIT "".
/* add by : A65-0288 */
def var  nv_ispno             as char no-undo init "".
def var  nv_ispappoit         as char no-undo init "".
def var  nv_ispupdate         as char no-undo init "".
def var  nv_isplocal          as char no-undo init "".
def var  nv_ispclose          as char no-undo init "".
def var  nv_ispresult         as char no-undo init "".
def var  nv_ispdam            as char no-undo init "".
def var  nv_ispacc            as char no-undo init "".
/* end : A65-0288 */
IF tlt.usrsent = "Y" AND tlt.lotno <> "Y" THEN NEXT.
ELSE DO:
    FIND trecid WHERE trecid.nrecid = RECID(tlt) NO-LOCK NO-ERROR.
    IF NOT AVAIL trecid THEN DO:
        CREATE trecid.
        trecid.nrecid = RECID(tlt).
    END.

    IF  tlt.ln_fst <> ?  THEN nv_first =  string(tlt.ln_fst).
    IF tlt.note30 <> "" THEN DO:
        ASSIGN
            nv_Brancho  = trim(substr(tlt.note30,1,100))
            nv_dealero  = trim(substr(tlt.note30,101,100)  ) 
            nv_campno   = trim(substr(tlt.note30,201,100)  )   NO-ERROR.
    END.
    
    RUN wuw\wuwppics3(INPUT TODAY,INPUT "COMP_CODE",OUTPUT nv_comcod).
    IF nv_comcod = "" THEN nv_comcod= "TMSTH".
    
    nv_ccom  = nv_ccom  + 1.
    IF tlt.note26  <> "" THEN nv_trnchr = tlt.note26 .
    ELSE IF tlt.ndate1  <> ? THEN  nv_trnchr = string(tlt.ndate1    ,"99/99/9999") .
    
    if tlt.nor_effdat <> ? then nv_comchr    = string(tlt.nor_effdat,"99/99/9999").   
    if tlt.expodat    <> ? then nv_expchr    = string(tlt.expodat   ,"99/99/9999").   
    IF tlt.gendat  <> ? THEN  nv_birchr   = STRING(tlt.gendat,"99/99/9999").
    IF tlt.datesent  <> ? THEN nv_senchr = STRING(tlt.datesent ,"99/99/9999").
    
    IF tlt.hrg_adddr <> "" THEN nv_saddr = tlt.hrg_adddr.
    ELSE DO:
        IF tlt.hrg_no   <> "" AND INDEX(tlt.hrg_no,"�Ţ���") = 0 THEN nv_saddr = "�Ţ��� " + tlt.hrg_no                              .
        IF tlt.hrg_moo  <> ""  THEN nv_saddr = nv_saddr + " ���� "  + tlt.hrg_moo                  .
        IF tlt.hrg_vill <> ""  THEN nv_saddr =  nv_saddr + " �Ҥ�� "    + tlt.hrg_vill             .
        IF tlt.hrg_floor <> "" THEN nv_saddr =  nv_saddr + " ��� "    + tlt.hrg_floor             .
        IF tlt.hrg_room  <> "" THEN nv_saddr =  nv_saddr + " ��ͧ "    + tlt.hrg_room              .
        IF tlt.hrg_soi   <> "" THEN nv_saddr   = nv_saddr + " ��� "    + tlt.hrg_soi               .
        IF tlt.hrg_street    <> "" THEN nv_saddr   = nv_saddr + " ��� "      + tlt.hrg_street      .
        IF tlt.hrg_district <> "" THEN do:  
            IF INDEX(tlt.hrg_prov,"��ا෾") <> 0  THEN nv_saddr  = nv_saddr + " �ǧ " + trim(tlt.hrg_district).
            ELSE nv_saddr  = nv_saddr + " �Ӻ� " + trim(tlt.hrg_district).
        end.
        IF tlt.hrg_subdistrict   <> "" THEN do:  
            IF INDEX(tlt.hrg_prov,"��ا෾") <> 0  THEN nv_saddr   = nv_saddr + " ࢵ " + trim(tlt.hrg_subdistrict).
            ELSE nv_saddr   = nv_saddr + " ����� " + trim(tlt.hrg_subdistrict).
        end.
        nv_saddr = trim(trim(nv_saddr + " " + tlt.hrg_prov) + " " + tlt.hrg_postcd ).
    END.
    /* add by : A67-0076 */
    ASSIGN nv_drioccup1  = ""   nv_drioccup2  = ""      nv_drioccup3  = ""   nv_drioccup4  = ""   nv_drioccup5  = ""     
        nv_driToccup1    = ""   nv_driToccup2 = ""      nv_driToccup3 = ""   nv_driToccup4 = ""   nv_driToccup5 = ""     
        nv_driTicono1    = ""   nv_driTicono2 = ""      nv_driTicono3 = ""   nv_driTicono4 = ""   nv_driTicono5 = ""     
        nv_driICNo1      = ""   nv_driICNo2   = ""      nv_driICNo3   = ""   nv_driICNo4   = ""   nv_driICNo5   = "" 
        nv_drioccup1    =   trim(SUBSTR(tlt.dir_occ1,1,INDEX(tlt.dir_occ1,"TOCC:") - 2))
        nv_driToccup1   =   trim(substr(tlt.dir_occ1,R-INDEX(tlt.dir_occ1,"TOCC:")))   
        nv_driTicono1   =   trim(SUBSTR(tlt.dri_ic1,1,INDEX(tlt.dri_ic1,"ICNO:") - 2))       
        nv_driICNo1     =   trim(substr(tlt.dri_ic1,R-INDEX(tlt.dri_ic1,"ICNO:"))) 
        nv_drioccup1    =   trim(replace(nv_drioccup1,"OCCUP:","")) 
        nv_driToccup1   =   trim(replace(nv_driToccup1,"TOCC:","")) 
        nv_driTicono1   =   trim(replace(nv_driTicono1,"TIC:",""))  
        nv_driICNo1     =   trim(replace(nv_driICNo1,"ICNO:",""))
        nv_drioccup2    =   trim(SUBSTR(tlt.dri_occ2,1,INDEX(tlt.dri_occ2,"TOCC:") - 2))     
        nv_driToccup2   =   trim(substr(tlt.dri_occ2,R-INDEX(tlt.dri_occ2,"TOCC:")))         
        nv_driTicono2   =   trim(SUBSTR(tlt.dri_ic2,1,INDEX(tlt.dri_ic2,"ICNO:") - 2))       
        nv_driICNo2     =   trim(substr(tlt.dri_ic2,R-INDEX(tlt.dri_ic2,"ICNO:"))) 
        nv_drioccup2    =   trim(replace(nv_drioccup2,"OCCUP:","")) 
        nv_driToccup2   =   trim(replace(nv_driToccup2,"TOCC:","")) 
        nv_driTicono2   =   trim(replace(nv_driTicono2,"TIC:",""))  
        nv_driICNo2     =   trim(replace(nv_driICNo2,"ICNO:",""))
        nv_drioccup3    =   trim(SUBSTR(tlt.dir_occ3,1,INDEX(tlt.dir_occ3,"TOCC:") - 2))    
        nv_driToccup3   =   trim(substr(tlt.dir_occ3,R-INDEX(tlt.dir_occ3,"TOCC:")))        
        nv_driTicono3   =   trim(SUBSTR(tlt.dri_ic3,1,INDEX(tlt.dri_ic3,"ICNO:") - 2))      
        nv_driICNo3     =   trim(substr(tlt.dri_ic3,R-INDEX(tlt.dri_ic3,"ICNO:"))) 
        nv_drioccup3    =   trim(replace(nv_drioccup3,"OCCUP:","")) 
        nv_driToccup3   =   trim(replace(nv_driToccup3,"TOCC:","")) 
        nv_driTicono3   =   trim(replace(nv_driTicono3,"TIC:",""))  
        nv_driICNo3     =   trim(replace(nv_driICNo3,"ICNO:",""))
        nv_drioccup4    =   trim(SUBSTR(tlt.dri_occ4,1,INDEX(tlt.dri_occ4,"TOCC:") - 2))   
        nv_driToccup4   =   trim(substr(tlt.dri_occ4,R-INDEX(tlt.dri_occ4,"TOCC:")))       
        nv_driTicono4   =   trim(SUBSTR(tlt.dri_ic4,1,INDEX(tlt.dri_ic4,"ICNO:") - 2))     
        nv_driICNo4     =   trim(substr(tlt.dri_ic4,R-INDEX(tlt.dri_ic4,"ICNO:")))
        nv_drioccup4    =   trim(replace(nv_drioccup4,"OCCUP:","")) 
        nv_driToccup4   =   trim(replace(nv_driToccup4,"TOCC:","")) 
        nv_driTicono4   =   trim(replace(nv_driTicono4,"TIC:",""))  
        nv_driICNo4     =   trim(replace(nv_driICNo4,"ICNO:",""))
        nv_drioccup5    =   trim(SUBSTR(tlt.dri_occ5,1,INDEX(tlt.dri_occ5,"TOCC:") - 2))    
        nv_driToccup5   =   trim(substr(tlt.dri_occ5,R-INDEX(tlt.dri_occ5,"TOCC:")))        
        nv_driTicono5   =   trim(SUBSTR(tlt.dri_ic5,1,INDEX(tlt.dri_ic5,"ICNO:") - 2))      
        nv_driICNo5     =   trim(substr(tlt.dri_ic5,R-INDEX(tlt.dri_ic5,"ICNO:")))  
        nv_drioccup5    =   trim(replace(nv_drioccup5,"OCCUP:","")) 
        nv_driToccup5   =   trim(replace(nv_driToccup5,"TOCC:","")) 
        nv_driTicono5   =   trim(replace(nv_driTicono5,"TIC:",""))  
        nv_driICNo5     =   trim(replace(nv_driICNo5,"ICNO:","")).
    /* end : A67-0076 */
    nv_Seat = "".
    IF tlt.noteveh1 = "21" THEN nv_Seat = "15".
    ELSE if tlt.noteveh1 = "22" THEN nv_Seat = "20".
    ELSE if tlt.noteveh1 = "23" THEN nv_Seat = "40".
    ELSE if tlt.noteveh1 = "24" THEN nv_Seat = "41".
    /* add by : A65-0288 */
    IF tlt.lotno = "Y" THEN DO:
        ASSIGN 
        nv_ispno     = trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  
        nv_ispclose  = trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Close Date:") + 12))
        nv_ispresult = IF index(tlt.mobile,"��¡�ä����������") <> 0 THEN trim(substr(tlt.mobile,1,index(tlt.mobile,"��¡�ä����������") - 2)) ELSE tlt.mobile
        nv_ispdam    = IF index(tlt.mobile,"��¡�ä����������") <> 0 THEN trim(substr(tlt.mobile,R-INDEX(tlt.mobile,"��¡�ä����������") + 17)) ELSE ""
        nv_ispacc    = brstat.tlt.fax  
        nv_ispappoit = ""    
        nv_ispupdate = ""    
        nv_isplocal  = ""  NO-ERROR.
    END.
    ELSE DO:
        ASSIGN 
        nv_ispno     = IF tlt.acno1 <> "" THEN trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  ELSE ""
        nv_ispupdate = IF tlt.acno1 <> "" THEN trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Edit Date:") + 10 )) ELSE "" 
        nv_ispupdate = IF index(nv_ispupdate," ") <> 0 THEN TRIM(SUBSTR(nv_ispupdate,1,R-INDEX(nv_ispupdate," "))) ELSE nv_ispupdate
        nv_ispappoit = tlt.mobile  
        nv_isplocal  = tlt.fax 
        nv_ispclose  = ""
        nv_ispresult = ""
        nv_ispdam    = ""
        nv_ispacc    = ""       NO-ERROR.
    END.
     /*....end A65-0288...*/
    
    OUTPUT TO VALUE(fi_kkcom) APPEND.
    EXPORT DELIMITER "|"
        nv_ccom
        nv_senchr
        IF tlt.dat_ins_not = ? THEN "" ELSE string(tlt.dat_ins_not,"99/99/9999") FORMAT "x(10)"         
        nv_comcod 
        tlt.nor_noti_tlt
        tlt.note5    /**/
        tlt.note25   /*tlt.nor_noti_ins */
        tlt.nor_usr_tlt  
        tlt.comp_usr_tl  
        nv_brancho
        tlt.comp_noti_tlt
        tlt.note4 
        ""
        ""
        tlt.ins_typ        
        tlt.ins_title  
        IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,1,r-INDEX(trim(tlt.ins_name)," ") - 1 )  ELSE tlt.ins_name
        IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,r-INDEX(trim(tlt.ins_name)," ") + 1 )  ELSE "" 
        tlt.ins_addr1              
        tlt.ins_addr2              
        tlt.ins_addr3              
        tlt.ins_addr4              
        tlt.ins_addr5              
        tlt.covcod
        tlt.stat
        nv_comchr  
        nv_expchr  
        tlt.subins 
        tlt.filler2
        tlt.brand       
        tlt.model       
        tlt.filler1     
        tlt.lince1   
        tlt.proveh   
        tlt.cha_no      
        tlt.eng_no      
        tlt.lince2      
        string(tlt.cc_weight )
        STRING(tlt.hp)  /*A67-0076*/
        TRIM(tlt.colorcod  ) 
        nv_Seat
        string(tlt.comp_coamt) 
        string(tlt.comp_grprm) 
        tlt.prem_amt /*tlt.note12*/
        string(tlt.gentim)
        tlt.buagent
        tlt.safe1 
        tlt.dri_title1  /*�ӹ�˹�Ҫ��� 1*/          /*A67-0076*/
        tlt.dri_name1   /*���Ѻ����� 1     */
        tlt.dri_no1     /*�ѹ�Դ���Ѻ��� 1 */
        tlt.dri_lic1    /*�Ţ���㺢Ѻ��� 1   */
        tlt.dri_gender1 /*�� 1           */         /*A67-0076*/
        nv_drioccup1    /*�Ҫվ 1         */         /*A67-0076*/
        nv_driICNo1     /*ID NO/Passport 1*/         /*A67-0076*/
        ""              /*�дѺ���Ѻ��� 1*/
        tlt.dri_title2  /*�ӹ�˹�Ҫ��� 2*/          /*A67-0076*/
        tlt.dri_name2   /*���Ѻ����� 2     */
        tlt.dri_no2     /*�ѹ�Դ���Ѻ��� 2 */
        tlt.dri_lic2    /*�Ţ���㺢Ѻ��� 2   */
        tlt.dri_gender2 /*�� 2           */    
        nv_drioccup2    /*�Ҫվ 2         */     
        nv_driICNo2     /*ID NO/Passport 2*/ 
        ""              /*�дѺ���Ѻ��� 2*/
        tlt.dri_title3  /*�ӹ�˹�Ҫ��� 3*/       
        tlt.dri_name3   /*���Ѻ����� 3     */  
        tlt.dri_no3     /*�ѹ�Դ���Ѻ��� 3 */  
        tlt.dri_lic3    /*�Ţ���㺢Ѻ��� 3   */  
        tlt.dri_gender3 /*�� 3           */     
        nv_drioccup3    /*�Ҫվ 3         */     
        nv_driICNo3     /*ID NO/Passport 3*/ 
        ""              /*�дѺ���Ѻ��� 3*/
        tlt.dri_title4  /*�ӹ�˹�Ҫ��� 4*/       
        tlt.dri_name4   /*���Ѻ����� 4     */  
        tlt.dri_no4     /*�ѹ�Դ���Ѻ��� 4 */  
        tlt.dri_lic4    /*�Ţ���㺢Ѻ��� 4   */  
        tlt.dri_gender4 /*�� 4           */     
        nv_drioccup4    /*�Ҫվ 4         */     
        nv_driICNo4     /*ID NO/Passport 4*/
        ""              /*�дѺ���Ѻ��� 4*/
        tlt.dri_title5  /*�ӹ�˹�Ҫ��� 5*/       
        tlt.dri_name5   /*���Ѻ����� 5     */  
        tlt.dri_no5     /*�ѹ�Դ���Ѻ��� 5 */  
        tlt.dri_lic5    /*�Ţ���㺢Ѻ��� 5   */  
        tlt.dri_gender5 /*�� 5           */     
        nv_drioccup5    /*�Ҫվ 5         */     
        nv_driICNo5     /*ID NO/Passport 5*/
        ""              /*�дѺ���Ѻ���5*/
        tlt.rec_title  
        IF INDEX(tlt.rec_name," ") <> 0 then substr(tlt.rec_name,1,r-INDEX(trim(tlt.rec_name)," ") - 1 ) else tlt.rec_name 
        IF INDEX(tlt.rec_name," ") <> 0 then substr(tlt.rec_name,r-INDEX(trim(tlt.rec_name)," ") + 1 ) else ""
        tlt.rec_addr1
        tlt.rec_addr2
        tlt.rec_addr3
        tlt.rec_addr4
        tlt.rec_addr5
        ""
        ""
        tlt.tel
        tlt.ins_icno
        IF tlt.gendat <> ? THEN  STRING(tlt.gendat,"99/99/9999") ELSE "" 
        tlt.ins_occ
        tlt.maritalsts
        tlt.sex           
        tlt.nationality   
        tlt.email
        tlt.rec_icno
        nv_tname1    
        nv_cname1    
        nv_lname1    
        nv_icno1     
        nv_tname2    
        nv_cname2    
        nv_lname2    
        nv_icno2     
        nv_tname3    
        nv_cname3    
        nv_lname3    
        nv_icno3     
        nv_saddr  
        tlt.hrg_cont  
        tlt.ben83 
        tlt.expotim                               
        tlt.OLD_eng                               
        trim(trim(tlt.OLD_cha) + " " +  tlt.note24) 
        tlt.usrid  
        nv_dealero
        nv_campno                                  
        ""                                   
        tlt.comp_sub                         
        tlt.recac              
        tlt.note2                            
        tlt.note3                            
        tlt.rider                            
        tlt.Releas                            
        nv_first  
        tlt.policy
        tlt.note28
        /* add by : A65-0288  07/10/2022  */
        tlt.lince3                                                                      
        tlt.usrsent                                                                                                                            
        tlt.lotno                                                              
        nv_ispno                                                                    
        if tlt.lotno = "Y" then nv_ispclose  else ""                                 
        if tlt.lotno = "Y" then nv_ispresult else nv_ispappoit                      
        if tlt.lotno = "Y" then nv_ispdam    else nv_ispupdate                 
        if tlt.lotno = "Y" then nv_ispacc    else nv_isplocal                  
        /* end : A65-0288  07/10/2022  */
        tlt.paydate1
        tlt.paytype
        tlt.battno 
        tlt.battyr 
        tlt.maksi  
        tlt.chargno
        tlt.noteveh2
        SKIP.
     
    OUTPUT CLOSE.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_fhfg C-Win 
PROCEDURE pd_fhfg :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_comchr AS CHAR INIT "".
DEF VAR nv_expchr AS CHAR INIT "".
DEF VAR nv_birchr AS CHAR INIT "".
DEF VAR nv_senchr AS CHAR INIT "".
DEF VAR nv_trnchr AS CHAR INIT "".
DEF VAR nv_saddr  AS CHAR INIT "".
DEF VAR nv_comcod AS CHAR INIT "".
DEF VAR nv_first AS CHAR INIT "".
def var n_text     as char format "x(255)" init "".
def var nv_icno3   as char format "x(15)" init "".
def var nv_lname3  as char format "x(45)" init "".
def var nv_cname3  as char format "x(45)" init "".
def var nv_tname3  as char format "x(20)" init "".
def var nv_icno2   as char format "x(15)" init "".
def var nv_lname2  as char format "x(45)" init "".
def var nv_cname2  as char format "x(45)" init "".
def var nv_tname2  as char format "x(20)" init "".
def var nv_icno1   as char format "x(15)" init "".
def var nv_lname1  as char format "x(45)" init "".
def var nv_cname1  as char format "x(45)" init "".
def var nv_tname1  as char format "x(20)" init "".
DEF VAR nv_Brancho  AS CHAR INIT "".
DEF VAR nv_dealero  AS CHAR INIT "".
DEF VAR nv_campno   AS CHAR INIT "".
DEF VAR nv_Seat  AS CHAR INIT "".
/* add by : A65-0288 */
def var  nv_ispno             as char no-undo init "".
def var  nv_ispappoit         as char no-undo init "".
def var  nv_ispupdate         as char no-undo init "".
def var  nv_isplocal          as char no-undo init "".
def var  nv_ispclose          as char no-undo init "".
def var  nv_ispresult         as char no-undo init "".
def var  nv_ispdam            as char no-undo init "".
def var  nv_ispacc            as char no-undo init "".
/* end : A65-0288 */

FIND trecid WHERE trecid.nrecid = RECID(tlt) NO-LOCK NO-ERROR.
IF NOT AVAIL trecid THEN DO:
    CREATE trecid.
    trecid.nrecid = RECID(tlt).
END.
IF  tlt.ln_fst <> ?  THEN nv_first =  string(tlt.ln_fst).

RUN wuw\wuwppics3(INPUT TODAY,INPUT "COMP_CODE",OUTPUT nv_comcod).
IF nv_comcod = "" THEN nv_comcod= "TMSTH".

nv_chol = nv_chol + 1.
IF tlt.note26  <> "" THEN nv_trnchr = tlt.note26 .
ELSE IF tlt.ndate1  <> ? THEN  nv_trnchr = string(tlt.ndate1    ,"99/99/9999") .
IF tlt.note30 <> "" THEN DO:
    ASSIGN
        nv_Brancho  = trim(substr(tlt.note30,1,100))
        nv_dealero  = trim(substr(tlt.note30,101,100)  ) 
        nv_campno   = trim(substr(tlt.note30,201,100)  )   NO-ERROR.

END.
if tlt.nor_effdat <> ? then nv_comchr    = string(tlt.nor_effdat,"99/99/9999").   
if tlt.expodat    <> ? then nv_expchr    = string(tlt.expodat   ,"99/99/9999").   
IF tlt.gendat  <> ? THEN  nv_birchr   = STRING(tlt.gendat,"99/99/9999").
IF tlt.datesent  <> ? THEN nv_senchr = STRING(tlt.datesent ,"99/99/9999").

IF tlt.hrg_adddr <> "" THEN nv_saddr = tlt.hrg_adddr.
ELSE DO:
    IF tlt.hrg_no   <> ""  THEN nv_saddr = "�Ţ��� " + tlt.hrg_no                              .
    IF tlt.hrg_moo  <> ""  THEN nv_saddr = nv_saddr + " ���� "  + tlt.hrg_moo                  .
    IF tlt.hrg_vill <> ""  THEN nv_saddr =  nv_saddr + " �Ҥ�� "    + tlt.hrg_vill             .
    IF tlt.hrg_floor <> "" THEN nv_saddr =  nv_saddr + " ��� "    + tlt.hrg_floor             .
    IF tlt.hrg_room  <> "" THEN nv_saddr =  nv_saddr + " ��ͧ "    + tlt.hrg_room              .
    IF tlt.hrg_soi   <> "" THEN nv_saddr   = nv_saddr + " ��� "    + tlt.hrg_soi               .
    IF tlt.hrg_street    <> "" THEN nv_saddr   = nv_saddr + " ��� "      + tlt.hrg_street      .
    IF tlt.hrg_district <> "" THEN do:  
        
        IF INDEX(wdetail.ADD_country,"��ا෾") <> 0  THEN nv_saddr  = nv_saddr + " �ǧ " + trim(tlt.hrg_district).
        ELSE nv_saddr  = nv_saddr + " �Ӻ� " + trim(tlt.hrg_district).
    end.
    IF tlt.hrg_subdistrict   <> "" THEN do:  
        IF INDEX(wdetail.ADD_country,"��ا෾") <> 0  THEN nv_saddr   = nv_saddr + " ࢵ " + trim(tlt.hrg_subdistrict).
        ELSE nv_saddr   = nv_saddr + " ����� " + trim(tlt.hrg_subdistrict).
    end.
    nv_saddr = trim(trim(nv_saddr + " " + tlt.hrg_prov) + " " + tlt.hrg_postcd ).
END.
/* comment by : A65-0288....
ASSIGN
n_text       = "" 
n_text       = tlt.lince3.

IF INDEX(n_text,"IC3:") <> 0 THEN
ASSIGN
nv_icno3     = SUBSTR(n_text,R-INDEX(n_text,"IC3:") + 4)         
n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_icno3) + 4))
nv_lname3    = SUBSTR(n_text,R-INDEX(n_text,"L3:") + 3)          
n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_lname3) + 3))
nv_cname3    = SUBSTR(n_text,R-INDEX(n_text,"N3:") + 3)          
n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_cname3) + 3))
nv_tname3    = SUBSTR(n_text,R-INDEX(n_text,"T3:") + 3)          
n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_tname3) + 3)) NO-ERROR.
IF INDEX(n_text,"IC2:") <> 0 THEN
ASSIGN
nv_icno2     = SUBSTR(n_text,R-INDEX(n_text,"IC2:") + 4)         
n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_icno2) + 4))
nv_lname2    = SUBSTR(n_text,R-INDEX(n_text,"L2:") + 3)          
n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_lname2) + 3))
nv_cname2    = SUBSTR(n_text,R-INDEX(n_text,"N2:") + 3)          
n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_cname2) + 3))
nv_tname2    = SUBSTR(n_text,R-INDEX(n_text,"T2:") + 3)         
n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_tname2) + 3)) NO-ERROR.
IF INDEX(n_text,"IC1:") <> 0 THEN
ASSIGN
nv_icno1     = SUBSTR(n_text,R-INDEX(n_text,"IC1:") + 4)         
n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_icno1) + 4))
nv_lname1    = SUBSTR(n_text,R-INDEX(n_text,"L1:") + 3)          
n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_lname1) + 3))
nv_cname1    = SUBSTR(n_text,R-INDEX(n_text,"N1:") + 3)          
n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_cname1) + 3))
nv_tname1    = SUBSTR(n_text,R-INDEX(n_text,"T1:") + 3)  NO-ERROR.
ASSIGN
    nv_icno3   = trim(nv_icno3 ) 
    nv_lname3  = trim(nv_lname3) 
    nv_cname3  = trim(nv_cname3) 
    nv_tname3  = trim(nv_tname3) 
    nv_icno2   = trim(nv_icno2 ) 
    nv_lname2  = trim(nv_lname2) 
    nv_cname2  = trim(nv_cname2) 
    nv_tname2  = trim(nv_tname2) 
    nv_icno1   = trim(nv_icno1 ) 
    nv_lname1  = trim(nv_lname1) 
    nv_cname1  = trim(nv_cname1) 
    nv_tname1  = trim(nv_tname1) .
...end A65-0288...*/
/* add by : A67-0076 */
    ASSIGN nv_drioccup1  = ""   nv_drioccup2  = ""      nv_drioccup3  = ""   nv_drioccup4  = ""   nv_drioccup5  = ""     
        nv_driToccup1    = ""   nv_driToccup2 = ""      nv_driToccup3 = ""   nv_driToccup4 = ""   nv_driToccup5 = ""     
        nv_driTicono1    = ""   nv_driTicono2 = ""      nv_driTicono3 = ""   nv_driTicono4 = ""   nv_driTicono5 = ""     
        nv_driICNo1      = ""   nv_driICNo2   = ""      nv_driICNo3   = ""   nv_driICNo4   = ""   nv_driICNo5   = "" 
        nv_drioccup1    =   trim(SUBSTR(tlt.dir_occ1,1,INDEX(tlt.dir_occ1,"TOCC:") - 2))
        nv_driToccup1   =   trim(substr(tlt.dir_occ1,R-INDEX(tlt.dir_occ1,"TOCC:")))   
        nv_driTicono1   =   trim(SUBSTR(tlt.dri_ic1,1,INDEX(tlt.dri_ic1,"ICNO:") - 2))       
        nv_driICNo1     =   trim(substr(tlt.dri_ic1,R-INDEX(tlt.dri_ic1,"ICNO:"))) 
        nv_drioccup1    =   trim(replace(nv_drioccup1,"OCCUP:","")) 
        nv_driToccup1   =   trim(replace(nv_driToccup1,"TOCC:","")) 
        nv_driTicono1   =   trim(replace(nv_driTicono1,"TIC:",""))  
        nv_driICNo1     =   trim(replace(nv_driICNo1,"ICNO:",""))
        nv_drioccup2    =   trim(SUBSTR(tlt.dri_occ2,1,INDEX(tlt.dri_occ2,"TOCC:") - 2))     
        nv_driToccup2   =   trim(substr(tlt.dri_occ2,R-INDEX(tlt.dri_occ2,"TOCC:")))         
        nv_driTicono2   =   trim(SUBSTR(tlt.dri_ic2,1,INDEX(tlt.dri_ic2,"ICNO:") - 2))       
        nv_driICNo2     =   trim(substr(tlt.dri_ic2,R-INDEX(tlt.dri_ic2,"ICNO:"))) 
        nv_drioccup2    =   trim(replace(nv_drioccup2,"OCCUP:","")) 
        nv_driToccup2   =   trim(replace(nv_driToccup2,"TOCC:","")) 
        nv_driTicono2   =   trim(replace(nv_driTicono2,"TIC:",""))  
        nv_driICNo2     =   trim(replace(nv_driICNo2,"ICNO:",""))
        nv_drioccup3    =   trim(SUBSTR(tlt.dir_occ3,1,INDEX(tlt.dir_occ3,"TOCC:") - 2))    
        nv_driToccup3   =   trim(substr(tlt.dir_occ3,R-INDEX(tlt.dir_occ3,"TOCC:")))        
        nv_driTicono3   =   trim(SUBSTR(tlt.dri_ic3,1,INDEX(tlt.dri_ic3,"ICNO:") - 2))      
        nv_driICNo3     =   trim(substr(tlt.dri_ic3,R-INDEX(tlt.dri_ic3,"ICNO:"))) 
        nv_drioccup3    =   trim(replace(nv_drioccup3,"OCCUP:","")) 
        nv_driToccup3   =   trim(replace(nv_driToccup3,"TOCC:","")) 
        nv_driTicono3   =   trim(replace(nv_driTicono3,"TIC:",""))  
        nv_driICNo3     =   trim(replace(nv_driICNo3,"ICNO:",""))
        nv_drioccup4    =   trim(SUBSTR(tlt.dri_occ4,1,INDEX(tlt.dri_occ4,"TOCC:") - 2))   
        nv_driToccup4   =   trim(substr(tlt.dri_occ4,R-INDEX(tlt.dri_occ4,"TOCC:")))       
        nv_driTicono4   =   trim(SUBSTR(tlt.dri_ic4,1,INDEX(tlt.dri_ic4,"ICNO:") - 2))     
        nv_driICNo4     =   trim(substr(tlt.dri_ic4,R-INDEX(tlt.dri_ic4,"ICNO:")))
        nv_drioccup4    =   trim(replace(nv_drioccup4,"OCCUP:","")) 
        nv_driToccup4   =   trim(replace(nv_driToccup4,"TOCC:","")) 
        nv_driTicono4   =   trim(replace(nv_driTicono4,"TIC:",""))  
        nv_driICNo4     =   trim(replace(nv_driICNo4,"ICNO:",""))
        nv_drioccup5    =   trim(SUBSTR(tlt.dri_occ5,1,INDEX(tlt.dri_occ5,"TOCC:") - 2))    
        nv_driToccup5   =   trim(substr(tlt.dri_occ5,R-INDEX(tlt.dri_occ5,"TOCC:")))        
        nv_driTicono5   =   trim(SUBSTR(tlt.dri_ic5,1,INDEX(tlt.dri_ic5,"ICNO:") - 2))      
        nv_driICNo5     =   trim(substr(tlt.dri_ic5,R-INDEX(tlt.dri_ic5,"ICNO:")))  
        nv_drioccup5    =   trim(replace(nv_drioccup5,"OCCUP:","")) 
        nv_driToccup5   =   trim(replace(nv_driToccup5,"TOCC:","")) 
        nv_driTicono5   =   trim(replace(nv_driTicono5,"TIC:",""))  
        nv_driICNo5     =   trim(replace(nv_driICNo5,"ICNO:","")).

nv_Seat = "".
IF tlt.noteveh1 = "21" THEN nv_Seat = "15".
ELSE if tlt.noteveh1 = "22" THEN nv_Seat = "20".
ELSE if tlt.noteveh1 = "23" THEN nv_Seat = "40".
ELSE if tlt.noteveh1 = "24" THEN nv_Seat = "41".
/*add by : A65-0288...*/
IF tlt.lotno = "Y" THEN DO:
    ASSIGN 
    nv_ispno     = trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  
    nv_ispclose  = trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Close Date:") + 12))
    nv_ispresult = IF index(tlt.mobile,"��¡�ä����������") <> 0 THEN trim(substr(tlt.mobile,1,index(tlt.mobile,"��¡�ä����������") - 2)) ELSE tlt.mobile
    nv_ispdam    = IF index(tlt.mobile,"��¡�ä����������") <> 0 THEN trim(substr(tlt.mobile,R-INDEX(tlt.mobile,"��¡�ä����������") + 17)) ELSE ""
    nv_ispacc    = brstat.tlt.fax  
    nv_ispappoit = ""    
    nv_ispupdate = ""    
    nv_isplocal  = ""  NO-ERROR.
END.
ELSE DO:
    ASSIGN 
    nv_ispno     = IF tlt.acno1 <> "" THEN trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  ELSE ""
    nv_ispupdate = IF tlt.acno1 <> "" THEN trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Edit Date:") + 10 )) ELSE "" 
    nv_ispupdate = IF index(nv_ispupdate," ") <> 0 THEN TRIM(SUBSTR(nv_ispupdate,1,R-INDEX(nv_ispupdate," "))) ELSE nv_ispupdate
    nv_ispappoit = tlt.mobile  
    nv_isplocal  = tlt.fax 
    nv_ispclose  = ""
    nv_ispresult = ""
    nv_ispdam    = ""
    nv_ispacc    = ""       NO-ERROR.
END.
/*...end A65-0288...*/
OUTPUT TO VALUE(fi_kkhold) APPEND.
    EXPORT DELIMITER "|"
    nv_chol
    nv_senchr
    IF tlt.dat_ins_not = ? THEN "" ELSE string(tlt.dat_ins_not,"99/99/9999") FORMAT "x(10)"         
    nv_comcod 
    tlt.nor_noti_tlt
    tlt.note5    /**/
    tlt.note25   /*tlt.nor_noti_ins */
    tlt.nor_usr_tlt  
    tlt.comp_usr_tl  
    nv_brancho
    tlt.comp_noti_tlt
    tlt.note4
    ""
    ""
    tlt.ins_typ       
    tlt.ins_title  
    IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,1,r-INDEX(trim(tlt.ins_name)," ") - 1 )  ELSE tlt.ins_name
    IF INDEX(tlt.ins_name," ") <> 0 THEN substr(tlt.ins_name,r-INDEX(trim(tlt.ins_name)," ") + 1 )  ELSE "" 
    tlt.ins_addr1              
    tlt.ins_addr2              
    tlt.ins_addr3              
    tlt.ins_addr4              
    tlt.ins_addr5              
    tlt.covcod
    tlt.stat
    nv_comchr  
    nv_expchr  
    tlt.subins 
    tlt.filler2
    tlt.brand       
    tlt.model       
    tlt.filler1     
    tlt.lince1   
    tlt.proveh   
    tlt.cha_no      
    tlt.eng_no      
    tlt.lince2      
    string(tlt.cc_weight ) 
    STRING(tlt.hp) /*A67-0076*/
    TRIM  (tlt.colorcod  ) 
    nv_Seat
    string(tlt.comp_coamt) 
    string(tlt.comp_grprm) 
    tlt.prem_amt /* tlt.note12*/
    string(tlt.gentim)
    tlt.buagent
    tlt.safe1 
    /* A67-0076*/
    tlt.dri_title1  /*�ӹ�˹�Ҫ��� 1*/ /*A67-0076*/
    tlt.dri_name1   /*���Ѻ����� 1     */
    tlt.dri_no1     /*�ѹ�Դ���Ѻ��� 1 */
    tlt.dri_lic1    /*�Ţ���㺢Ѻ��� 1   */
    tlt.dri_gender1 /*�� 1           */ /*A67-0076*/
    nv_drioccup1    /*�Ҫվ 1         */ /*A67-0076*/
    nv_driICNo1     /*ID NO/Passport 1*/ /*A67-0076*/
    ""              /*�дѺ���Ѻ��� 1*/
    tlt.dri_title2  /*�ӹ�˹�Ҫ��� 2*/ /*A67-0076*/
    tlt.dri_name2   /*���Ѻ����� 2     */
    tlt.dri_no2     /*�ѹ�Դ���Ѻ��� 2 */
    tlt.dri_lic2    /*�Ţ���㺢Ѻ��� 2   */
    tlt.dri_gender2 /*�� 2           */    
    nv_drioccup2    /*�Ҫվ 2         */     
    nv_driICNo2     /*ID NO/Passport 2*/ 
    ""              /*�дѺ���Ѻ��� 2*/
    tlt.dri_title3  /*�ӹ�˹�Ҫ��� 3*/       
    tlt.dri_name3   /*���Ѻ����� 3     */  
    tlt.dri_no3     /*�ѹ�Դ���Ѻ��� 3 */  
    tlt.dri_lic3    /*�Ţ���㺢Ѻ��� 3   */  
    tlt.dri_gender3 /*�� 3           */     
    nv_drioccup3    /*�Ҫվ 3         */     
    nv_driICNo3     /*ID NO/Passport 3*/ 
    ""              /*�дѺ���Ѻ��� 3*/
    tlt.dri_title4  /*�ӹ�˹�Ҫ��� 4*/       
    tlt.dri_name4   /*���Ѻ����� 4     */  
    tlt.dri_no4     /*�ѹ�Դ���Ѻ��� 4 */  
    tlt.dri_lic4    /*�Ţ���㺢Ѻ��� 4   */  
    tlt.dri_gender4 /*�� 4           */     
    nv_drioccup4    /*�Ҫվ 4         */     
    nv_driICNo4     /*ID NO/Passport 4*/
    ""              /*�дѺ���Ѻ��� 4*/
    tlt.dri_title5  /*�ӹ�˹�Ҫ��� 5*/       
    tlt.dri_name5   /*���Ѻ����� 5     */  
    tlt.dri_no5     /*�ѹ�Դ���Ѻ��� 5 */  
    tlt.dri_lic5    /*�Ţ���㺢Ѻ��� 5   */  
    tlt.dri_gender5 /*�� 5           */     
    nv_drioccup5    /*�Ҫվ 5         */     
    nv_driICNo5     /*ID NO/Passport 5*/
    ""              /*�дѺ���Ѻ���5*/
    /* end : A67-0076*/
    tlt.rec_title 
    IF INDEX(tlt.rec_name," ") <> 0 then substr(tlt.rec_name,1,r-INDEX(trim(tlt.rec_name)," ") - 1 ) else tlt.rec_name 
    IF INDEX(tlt.rec_name," ") <> 0 then substr(tlt.rec_name,r-INDEX(trim(tlt.rec_name)," ") + 1 ) else ""
    tlt.rec_addr1
    tlt.rec_addr2
    tlt.rec_addr3
    tlt.rec_addr4
    tlt.rec_addr5
    ""
    ""
    tlt.tel
    tlt.ins_icno
    IF tlt.gendat <> ? THEN  STRING(tlt.gendat,"99/99/9999") ELSE "" 
    tlt.ins_occ
    tlt.maritalsts
    tlt.sex           
    tlt.nationality   
    tlt.email
    tlt.rec_icno
    nv_tname1      
    nv_cname1      
    nv_lname1      
    nv_icno1       
    nv_tname2      
    nv_cname2      
    nv_lname2      
    nv_icno2       
    nv_tname3      
    nv_cname3      
    nv_lname3      
    nv_icno3       
    nv_saddr  
    tlt.hrg_cont  
    tlt.ben83 
    tlt.expotim
    tlt.OLD_eng
    trim(trim(tlt.OLD_cha) + " " +  tlt.note24)        
    tlt.usrid 
    nv_dealero 
    nv_campno
    ""
    tlt.comp_sub 
    tlt.recac
    tlt.note2  
    tlt.note3  
    tlt.rider  
    tlt.Releas
    nv_first
    tlt.policy
    tlt.note28
    /* add by : A65-0288  11/10/2022  */
    tlt.lince3                                                                      
    tlt.usrsent                                                                                                                            
    tlt.lotno                                                              
    nv_ispno                                                                    
    if tlt.lotno = "Y" then nv_ispclose  else ""                                 
    if tlt.lotno = "Y" then nv_ispresult else nv_ispappoit                      
    if tlt.lotno = "Y" then nv_ispdam    else nv_ispupdate                 
    if tlt.lotno = "Y" then nv_ispacc    else nv_isplocal                  
    /* end : A65-0288  11/10/2022  */
   /* A67-0076 */
    tlt.paydate1
    tlt.paytype
    tlt.battno 
    tlt.battyr 
    tlt.maksi  
    tlt.chargno
    tlt.noteveh2 
    /* end : A67-0076 */
    SKIP.
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_fprob C-Win 
PROCEDURE pd_fprob :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_month AS CHAR INIT "".
DEF VAR nv_trchr AS CHAR INIT "".
DEF VAR  nv_inscom AS CHAR INIT "".
RUN wuw\wuwppics3(INPUT TODAY,INPUT "COMP_NO",OUTPUT nv_inscom).
IF nv_inscom = "" THEN nv_inscom = "2780".
FIND trecid WHERE trecid.nrecid = RECID(tlt) NO-LOCK NO-ERROR.
IF NOT AVAIL trecid THEN DO:
    CREATE trecid.
    trecid.nrecid = RECID(tlt).
END.


IF tlt.trndat <> ? THEN DO:
    nv_month = STRING((MONTH(tlt.trndat) + 12),"999").
    FIND FIRST sicsyac.xmd179 USE-INDEX xmd17901 WHERE xmd179.docno = "008" AND
              xmd179.poltyp EQ "" AND xmd179.headno = nv_month NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmd179 THEN nv_month = CAPS(trim(SUBSTR(sicsyac.xmd179.head,1,3))) .
    ELSE nv_month = " ".
        
     nv_trchr  = STRING(DAY(tlt.trndat),"99")  + "-" + nv_month + "-" + STRING(YEAR(tlt.trndat),"9999").
                 

END.

OUTPUT TO VALUE(fi_kkprob) APPEND.
EXPORT DELIMITER "|"
        tlt.expotim
        tlt.note3    
     IF  nv_inscom = "" THEN   tlt.nor_usr_ins ELSE  nv_inscom
        nv_trchr 
        tlt.note24  
        ""
        SKIP.
OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_fSLA C-Win 
PROCEDURE pd_fSLA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A65-0288       
------------------------------------------------------------------------------*/
DEF VAR n_month AS INTE  .
DEF VAR nv_month AS CHAR INIT "".
DEF VAR nv_trchr AS CHAR INIT "".
DEF VAR nv_inscom AS CHAR INIT "".

DO:
    RUN wuw\wuwppics3(INPUT TODAY,INPUT "COMP_NO",OUTPUT nv_inscom).
    IF nv_inscom = "" THEN nv_inscom = "2780".
    ASSIGN 
    n_month   = MONTH(TODAY)
    nv_month  = TRIM(fn-month(n_month))
    nv_trchr  = STRING(DAY(TODAY),"99")  + "-" + nv_month + "-" + STRING(YEAR(TODAY),"9999").
    
    
    
    OUTPUT TO VALUE(fi_kkprob) APPEND.
    EXPORT DELIMITER "|"
        wpol.KKApp
        wpol.KKQuo     
        nv_inscom
        nv_trchr 
        IF wpol.inspremark <> "" THEN wpol.inspremark ELSE wpol.Remark   
        IF wpol.inspremark <> "" THEN wpol.Remark     ELSE "Hold claim Flag : " + wpol.Hclaim + "/" + "Status Problem : " + wpol.Hproblem + "/" + wpol.polstatus 
            
        SKIP.
    OUTPUT CLOSE.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_hexp1 C-Win 
PROCEDURE pd_hexp1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE(fi_kkcom). 
EXPORT DELIMITER "|" 
    "�ӴѺ���"                           
    "�ѹ����Ѻ��"                      
    "�ѹ����Ѻ�Թ������»�Сѹ"        
    "��ª��ͺ���ѷ��Сѹ���"             
    "�Ţ����ѭ����ҫ���"   
    "New/Renew"
    "�Ţ�������������"                 
    "�����Ң�"                           
    "�Ң� KK"   
    "�Ң� TMSTH"  
    "�Ţ�Ѻ���"
    "KK Offer Flag"
    "Campaign"                           
    "Sub Campaign"                       
    "�ؤ��/�ԵԺؤ��"                    
    "�ӹ�˹�Ҫ���"                       
    "���ͼ����һ�Сѹ"                   
    "���ʡ�ż����һ�Сѹ"                
    "��ҹ�Ţ���"                         
    "�Ӻ�/�ǧ"                          
    "�����/ࢵ"                          
    "�ѧ��Ѵ"                            
    "������ɳ���"                      
    "����������������ͧ"                
    "��������ë���"                     
    "�ѹ�����������ͧ"                  
    "�ѹ����ش������ͧ"                
    "����ö"                            
    "��������Сѹ���ö¹��"             
    "����������ö"                      
    "���ö"                            
    "New/Used"                          
    "�Ţ����¹"   
    "�ѧ��Ѵ������¹"
    "�Ţ��Ƕѧ"                         
    "�Ţ����ͧ¹��"                    
    "��ö¹��"                          
    "�ի�" 
    "�ç���" /* A67-0076*/
    "���˹ѡ/�ѹ"    
    "�����"
    "�ع��Сѹ�� 1 "   
    "�����ط��"
    "����������������ҡû� 1"          
    "�����Ѻ���"                      
    "�������˹�ҷ�� MKT"               
    "�����˵�"                          
    "�ӹ�˹�Ҫ��� 1" /*A67-0076*/
    "���Ѻ����� 1     "
    "�ѹ�Դ���Ѻ��� 1 "
    "�Ţ���㺢Ѻ��� 1   "
    "�� 1           " /*A67-0076*/
    "�Ҫվ 1         " /*A67-0076*/
    "ID NO/Passport 1" /*A67-0076*/
    "�дѺ���Ѻ��� 1"
    "�ӹ�˹�Ҫ��� 2" /*A67-0076*/
    "���Ѻ����� 2     "
    "�ѹ�Դ���Ѻ��� 2 "
    "�Ţ���㺢Ѻ��� 2   "
    /*A67-0076*/
    "�� 2           "    
    "�Ҫվ 2         "     
    "ID NO/Passport 2" 
    "�дѺ���Ѻ��� 2"
    "�ӹ�˹�Ҫ��� 3"       
    "���Ѻ����� 3     "  
    "�ѹ�Դ���Ѻ��� 3 "  
    "�Ţ���㺢Ѻ��� 3   "  
    "�� 3           "     
    "�Ҫվ 3         "     
    "ID NO/Passport 3" 
    "�дѺ���Ѻ��� 3"
    "�ӹ�˹�Ҫ��� 4"       
    "���Ѻ����� 4     "  
    "�ѹ�Դ���Ѻ��� 4 "  
    "�Ţ���㺢Ѻ��� 4   "  
    "�� 4           "     
    "�Ҫվ 4         "     
    "ID NO/Passport 4"
    "�дѺ���Ѻ��� 4"
    "�ӹ�˹�Ҫ��� 5"       
    "���Ѻ����� 5     "  
    "�ѹ�Դ���Ѻ��� 5 "  
    "�Ţ���㺢Ѻ��� 5   "  
    "�� 5           "     
    "�Ҫվ 5         "     
    "ID NO/Passport 5"
    "�дѺ���Ѻ���5"
    /* end : A67-0076*/      
    "�ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)" 
    "���� (�����/㺡ӡѺ����)"         
    "���ʡ�� (�����/㺡ӡѺ����)"      
    "��ҹ�Ţ��� (�����/㺡ӡѺ����)"   
    "�Ӻ�/�ǧ (�����/㺡ӡѺ����)"    
    "�����/ࢵ (�����/㺡ӡѺ����)"    
    "�ѧ��Ѵ (�����/㺡ӡѺ����)"      
    "������ɳ��� (�����/㺡ӡѺ����)" 
    "��ǹŴ����ѵԴ�"                    
    "��ǹŴ�ҹ Fleet" 
    "����Դ��� "                 /*A60-0232*/
    "�Ţ���ѵû�ЪҪ�"            /*A60-0232*/
    "�ѹ��͹���Դ   "            /*A60-0232*/
    "�Ҫվ            "            /*A60-0232*/
    "ʶҹ�Ҿ          "            /*A60-0232*/
    "��              "
    "�ѭ�ҵ�          "
    "�������          "
    "�Ţ��Шӵ�Ǽ�����������ҡ�"   /*A60-0232*/
    "�ӹ�˹�Ҫ��� 1  "             /*A60-0232*/
    "���͡������ 1   "             /*A60-0232*/
    "���ʡ�š������ 1"             /*A60-0232*/
    "�Ţ���ѵû�ЪҪ�������� 1"   /*A60-0232*/
    "�ӹ�˹�Ҫ��� 2   "            /*A60-0232*/
    "���͡������ 2    "            /*A60-0232*/
    "���ʡ�š������ 2 "            /*A60-0232*/
    "�Ţ���ѵû�ЪҪ�������� 2"   /*A60-0232*/
    "�ӹ�˹�Ҫ��� 3   "            /*A60-0232*/
    "���͡������ 3    "            /*A60-0232*/
    "���ʡ�š������ 3 "            /*A60-0232*/
    "�Ţ���ѵû�ЪҪ�������� 3"   /*A60-0232*/
    "�Ѵ���͡��÷���Ң� "   /*A61-0335*/  
    "���ͼ���Ѻ�͡���    "   /*A61-0335*/  
    "����Ѻ�Ż���ª��    "   /*A61-0335*/  
    "KK ApplicationNo    "   /*A61-0335*/  
    "Remak1"                       
    "Remak2" 
    "Dealer KK"        /* A63-00472*/
    "Dealer TMSTH"
    "Campaign no TMSTH"
    "Campaign OV      "
    "Producer code"
    "Agent Code   "
    "ReferenceNo     "     
    "KK Quotation No."     
    "Rider  No.      "   
    "Release"       /* A56-0309 */  
    "Loan First Date"
    "Policy Premium"
    "Note Un Problem"
    /*add by : A65-0288 */
    "Color"
    "Inspection"                                                
    "Inspection status"                                         
    "Inspection No"                                             
    "Inspection Closed Date"                                         
    "Inspection Detail"                     
    "inspection Damage"            
    "inspection Accessory " 
    /* end : A65-0288 */
    /* add : A67-0076 */
    "�ѹ��訴����¹�����á "
    "Payment option          "
    "Battery Serial Number   "
    "Battery Year            "
    "Market value price      "
    "Wall Charge Serial Number"
    "Vehicle_Key"
    /* end: A67-0076 */
   SKIP .
OUTPUT CLOSE.
IF ra_filetyp = 5 THEN DO:
    OUTPUT TO VALUE(fi_kkhold). 
    EXPORT DELIMITER "|" 
        "�ӴѺ���"                           
        "�ѹ����Ѻ��"                      
        "�ѹ����Ѻ�Թ������»�Сѹ"        
        "��ª��ͺ���ѷ��Сѹ���"             
        "�Ţ����ѭ����ҫ���"   
        "New/Renew"
        "�Ţ�������������"                 
        "�����Ң�"                           
        "�Ң� KK"     
        "�Ң� TMSTH"  
        "�Ţ�Ѻ���" 
        "KK Offer Flag"
        "Campaign"                           
        "Sub Campaign"                       
        "�ؤ��/�ԵԺؤ��"                    
        "�ӹ�˹�Ҫ���"                       
        "���ͼ����һ�Сѹ"                   
        "���ʡ�ż����һ�Сѹ"                
        "��ҹ�Ţ���"                         
        "�Ӻ�/�ǧ"                          
        "�����/ࢵ"                          
        "�ѧ��Ѵ"                            
        "������ɳ���"                      
        "����������������ͧ"                
        "��������ë���"                     
        "�ѹ�����������ͧ"                  
        "�ѹ����ش������ͧ"                
        "����ö"                            
        "��������Сѹ���ö¹��"             
        "����������ö"                      
        "���ö"                            
        "New/Used"                          
        "�Ţ����¹"   
        "�ѧ��Ѵ������¹"
        "�Ţ��Ƕѧ"                         
        "�Ţ����ͧ¹��"                    
        "��ö¹��"                          
        "�ի�" 
        "�ç���" /* A67-0076*/
        "���˹ѡ/�ѹ"  
        "�����"
        "�ع��Сѹ�� 1 "   
        "�����ط��"
        "����������������ҡû� 1"       
        "�����Ѻ���"                      
        "�������˹�ҷ�� MKT"               
        "�����˵�" 
        "�ӹ�˹�Ҫ��� 1" /*A67-0076*/
        "���Ѻ����� 1     "
        "�ѹ�Դ���Ѻ��� 1 "
        "�Ţ���㺢Ѻ��� 1   "
        "�� 1           " /*A67-0076*/
        "�Ҫվ 1         " /*A67-0076*/
        "ID NO/Passport 1" /*A67-0076*/
        "�дѺ���Ѻ��� 1"
        "�ӹ�˹�Ҫ��� 2" /*A67-0076*/
        "���Ѻ����� 2     "
        "�ѹ�Դ���Ѻ��� 2 "
        "�Ţ���㺢Ѻ��� 2   "
         /*A67-0076*/
        "�� 2           "    
        "�Ҫվ 2         "     
        "ID NO/Passport 2" 
        "�дѺ���Ѻ��� 2"
        "�ӹ�˹�Ҫ��� 3"       
        "���Ѻ����� 3     "  
        "�ѹ�Դ���Ѻ��� 3 "  
        "�Ţ���㺢Ѻ��� 3   "  
        "�� 3           "     
        "�Ҫվ 3         "     
        "ID NO/Passport 3"
        "�дѺ���Ѻ��� 3"
        "�ӹ�˹�Ҫ��� 4"       
        "���Ѻ����� 4     "  
        "�ѹ�Դ���Ѻ��� 4 "  
        "�Ţ���㺢Ѻ��� 4   "  
        "�� 4           "     
        "�Ҫվ 4         "     
        "ID NO/Passport 4"
        "�дѺ���Ѻ��� 4"
        "�ӹ�˹�Ҫ��� 5"       
        "���Ѻ����� 5     "  
        "�ѹ�Դ���Ѻ��� 5 "  
        "�Ţ���㺢Ѻ��� 5   "  
        "�� 5           "     
        "�Ҫվ 5         "     
        "ID NO/Passport 5"
        "�дѺ���Ѻ��� 5"
        /*A67-0076*/ 
        "�ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)" 
        "���� (�����/㺡ӡѺ����)"         
        "���ʡ�� (�����/㺡ӡѺ����)"      
        "��ҹ�Ţ��� (�����/㺡ӡѺ����)"   
        "�Ӻ�/�ǧ (�����/㺡ӡѺ����)"    
        "�����/ࢵ (�����/㺡ӡѺ����)"    
        "�ѧ��Ѵ (�����/㺡ӡѺ����)"      
        "������ɳ��� (�����/㺡ӡѺ����)" 
        "��ǹŴ����ѵԴ�"                    
        "��ǹŴ�ҹ Fleet" 
        "����Դ��� "                 /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�"            /*A60-0232*/
        "�ѹ��͹���Դ   "            /*A60-0232*/
        "�Ҫվ            "            /*A60-0232*/
        "ʶҹ�Ҿ          "            /*A60-0232*/
        "��              "
        "�ѭ�ҵ�          "
        "�������          "
        "�Ţ��Шӵ�Ǽ�����������ҡ�"   /*A60-0232*/
        "�ӹ�˹�Ҫ��� 1  "             /*A60-0232*/
        "���͡������ 1   "             /*A60-0232*/
        "���ʡ�š������ 1"             /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�������� 1"   /*A60-0232*/
        "�ӹ�˹�Ҫ��� 2   "            /*A60-0232*/
        "���͡������ 2    "            /*A60-0232*/
        "���ʡ�š������ 2 "            /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�������� 2"   /*A60-0232*/
        "�ӹ�˹�Ҫ��� 3   "            /*A60-0232*/
        "���͡������ 3    "            /*A60-0232*/
        "���ʡ�š������ 3 "            /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�������� 3"   /*A60-0232*/
        "�Ѵ���͡��÷���Ң� "   /*A61-0335*/  
        "���ͼ���Ѻ�͡���    "   /*A61-0335*/  
        "����Ѻ�Ż���ª��    "   /*A61-0335*/  
        "KK ApplicationNo    "   /*A61-0335*/  
        "Remak1"                       
        "Remak2" 
        "Dealer"        /* A63-00472*/
        "Dealer TMSTH"  
        "Campaign no TMSTH"
        "Campaign OV      "
        "Producer code"
        "Agent Code   "
        "ReferenceNo     "     
        "KK Quotation No."     
        "Rider  No.      "    
        "Release"       /* A56-0309 */   
        "Loan First Date"
        "Policy Premium"
        "Note Un Problem"
        /*add by : A65-0288 */
        "Color"
        "Inspection"                                                
        "Inspection status"                                         
        "Inspection No"                                             
        "Inspection Closed Date"                                         
        "Inspection Detail / Inspection Update"                     
        "inspection Damage/ Inspection Appiontment Date"            
        "inspection Accessory / Inspection Appiontment Location" 
        /* end : A65-0288 */
        /* add : A67-0076 */
        "�ѹ��訴����¹�����á "
        "Payment option          "
        "Battery Serial Number   "
        "Battery Year            "
        "Market value price      "
        "Wall Charge Serial Number"
        "Vehicle_Key"
        /* end: A67-0076 */
       SKIP .
    OUTPUT CLOSE.
END.
ELSE IF ra_filetyp = 6 THEN DO:
    OUTPUT TO VALUE(fi_kkhold). 
    EXPORT DELIMITER "|"
   " NO.                "
   " Insurer Name       "
   " Product Name       "
   " Package            "
   " New/Renew          "
   " KK Offer Flag      "
   " KK Application No. "
   " KK Quotation No.   "
   " Rider No.          "
   " Source Uniq ID     "
   " Loan Contract No.  "
   " Notified No.       "
   " Notified Date      "
   " Payer Name         "
   " Insured Name       "
   " Insured Phone No 1 "
   " Insured Phone No 2 "
   " Insured Phone No 3 "
   " Agent Code         "
   " Branch             "
   " BU/RC              "
   " Net Premium        "
   " Stamp              "
   " Vat                "
   " Gross Premium      "
   " Problem Date       "
   " Problem ID         "
   " Problem Description"
   " Problem Flag       "
   " Policy Problem Flag"
   " Response Problem Date"
   " Response Problem Description"
   " Remark"
   " STATUS " 
   " Policy "
   " Claim flag "
   " Problem flag "
   SKIP .
   OUTPUT CLOSE.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_hexp2 C-Win 
PROCEDURE pd_hexp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF  fi_kkprob   <> "" THEN DO:
END.
ELSE DO:
    IF INDEX(fi_filename,".") <> 0 THEN DO:
    END.
    ELSE fi_kkprob     = fi_filename + ".csv".
END.

 OUTPUT TO VALUE(fi_kkprob ). 
 EXPORT DELIMITER "|"
    "KK_APP_NO"
    "QUOTATION_NO"
    "INSURANCE_COMPANY_CODE"
    "TRANSACTION_DATE"
    "PROBLEM_DESCRIPTION"
    "REMARK" SKIP.
 OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_report C-Win 
PROCEDURE pd_report :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF  (tlt.note29 = "Y") THEN RUN pd_fprob.
ELSE IF (tlt.usrsent = "Y" AND brstat.tlt.lotno = "N") THEN RUN pd_fprob.
ELSE IF tlt.hclf = "Y" THEN RUN pd_fhfg.
ELSE RUN pd_fcom.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pol_cutchar C-Win 
PROCEDURE pol_cutchar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
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
    wdetail.prepol = nv_c .*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkinsp C-Win 
PROCEDURE proc_chkinsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_yearprv AS INT INIT 0.                                /*
 MESSAGE "A0" nv_yearprv SKIP wdetail.trndat VIEW-AS ALERT-BOX.*/
ASSIGN  /*Move to Definition*/
    nv_message    = ""
    nv_branHO     = ""
    nv_subtyp     = ""
    nv_Chkbrcode  = ""
    nv_Chkbrname  = ""
    nv_ChkHOBR    = "".
IF tlt.usrsent = "Y" AND tlt.lotno <> "Y" AND index(tlt.covcod,"�Ҥ�ѧ�Ѻ") = 0  THEN DO:
    RUN proc_chkinsp2. /*----move source*/
    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\uw\" + nv_tmp .
   /*-------------------------------*/
    /*---------- Server test local ----------
    nv_server = "".     nv_tmp    = "D:\Lotus\Notes\Data\ranu\" + nv_tmp .
    --------------------------------------*/

    /*----Begin by Chaiyong W. A65-0288 06/01/2023*/
    IF wdetail.trndat <> "" THEN DO:
        IF INDEX(wdetail.trndat,STRING(YEAR(TODAY) - 1,"9999")) <> 0 THEN nv_yearprv = YEAR(TODAY)  - 1.
        /*MESSAGE nv_yearprv SKIP wdetail.trndat VIEW-AS ALERT-BOX.*/
    END.     /*
    MESSAGE "AA" nv_yearprv SKIP wdetail.trndat VIEW-AS ALERT-BOX.
    RETURN.*/
    IF nv_yearprv = 0 THEN nv_yearprv = YEAR(TODAY).
    nv_stinsp  = "YEAR NOW".
    loop_Crisp:
    REPEAT:
        RELEASE  OBJECT chNotesView     NO-ERROR. 
        RELEASE  OBJECT chNavView       NO-ERROR. 
        RELEASE  OBJECT chViewEntry     NO-ERROR. 
        RELEASE  OBJECT chitem          NO-ERROR.
        RELEASE  OBJECT chDocument      NO-ERROR.          
        RELEASE  OBJECT chNotesDataBase NO-ERROR.     
        RELEASE  OBJECT chNotesSession  NO-ERROR.


        IF nv_stinsp  = "YEAR NOW" THEN DO:
            nv_tmp      = "Inspect" + SUBSTR(STRING(YEAR(TODAY),"9999"),3,2) + ".nsf" .
            nv_tmp      = "safety\uw\" + nv_tmp .
            IF  nv_yearprv = YEAR(TODAY) THEN nv_stinsp  = "Not Found Create YEAR NOW".
        END.
        ELSE IF nv_stinsp  = "YEAR PRV"  THEN DO:
             nv_tmp      = "Inspect" + SUBSTR(STRING(nv_yearprv,"9999"),3,2) + ".nsf" .
            nv_tmp      = "safety\uw\" + nv_tmp .
            nv_stinsp   = "Not Found Create YEAR NOW2".
        END.
        ELSE IF nv_stinsp  = "Not Found Create YEAR NOW2" THEN DO:
            nv_tmp      = "Inspect" + SUBSTR(STRING(YEAR(TODAY),"9999"),3,2) + ".nsf" .
            nv_tmp      = "safety\uw\" + nv_tmp .
            nv_stinsp   = "Not Found Create YEAR NOW".
        END.

    /*End by Chaiyong W. A65-0288 06/01/2023------*/
        CREATE "Notes.NotesSession"  chNotesSession.
        chNotesDatabase  = chNotesSession:GetDatabase(nv_server,nv_tmp).
        IF  chNotesDatabase:IsOpen() = NO  THEN  DO:
         MESSAGE "Can not open database" SKIP  
                 "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
            /*---Begin chaiyong W. A65-0XXX 21/12/2022*/
            LEAVE loop_Crisp.
            /*End by Chaiyogn w. A65-0XXX 21/12/2022--*/
        END.
        ELSE DO:
          chNotesView    = chNotesDatabase:GetView("chassis_no").
          chNavView      = chNotesView:CreateViewNavFromCategory(TRIM(wdetail.chassis)).
          chViewEntry    = chNavView:GetLastDocument.
         IF chViewEntry <> 0 THEN DO: 
             chDocument = chViewEntry:Document.
             IF VALID-HANDLE(chDocument) = YES THEN DO:
                RUN Proc_Getdatainsp.
                IF nv_docno <> ""  THEN DO:
                    IF nv_survey <> "" THEN DO: /* �Դ����ͧ���� */
                        IF nv_detail = "�Դ�ѭ��" THEN DO:
                            ASSIGN brstat.tlt.lotno  = "Y" 
                                   brstat.tlt.acno1  = nv_docno + " Close Date: " + nv_date   /*�Ţ����Ǩ��Ҿ  + �ѹ���Դ����ͧ*/  
                                   brstat.tlt.mobile = nv_detail + " : " + nv_damage + " " + nv_damdetail /* ����������� */ /*��¡�ä���������� */
                                   brstat.tlt.fax    = nv_device + " " + nv_acctotal .        /*��������´�ػ�ó������ */  
                        END.
                        ELSE IF nv_detail = "�դ����������"  THEN DO:
                            ASSIGN brstat.tlt.lotno  = "Y"
                                   brstat.tlt.acno1  = nv_docno + " Close Date: " + nv_date   /*�Ţ����Ǩ��Ҿ  + �ѹ���Դ����ͧ*/                      
                                   brstat.tlt.mobile = nv_detail + " : " + nv_damlist /*+ nv_totaldam 17/11/2022*/  + " " + nv_damdetail /* ����������� + ��¡�ä���������� */
                                   brstat.tlt.fax    = nv_device + " " + nv_acctotal .       /*��������´�ػ�ó������ */     
                        END.                         
                        ELSE DO:                     
                            ASSIGN brstat.tlt.lotno  = "Y" 
                                   brstat.tlt.acno1  = nv_docno +  " Close Date: " + nv_date   /*�Ţ����Ǩ��Ҿ  + �ѹ���Դ����ͧ*/  
                                   brstat.tlt.mobile = nv_detail + " " + nv_damdetail /* ����������� */ /*��¡�ä���������� */
                                   brstat.tlt.fax    = nv_device + " " + nv_acctotal  .     /*��������´�ػ�ó������ */  
                        END.
                    END.
                    ELSE DO: /* �ѧ���Դ����ͧ */
                      ASSIGN brstat.tlt.lotno  =  "N" 
                             brstat.tlt.acno1  =  nv_docno + " Edit Date: " + nv_remark2    /*�Ţ����Ǩ��Ҿ  + �ѹ��� update ���ͧ*/      
                             brstat.tlt.mobile =  nv_remark3     /* �ѹ���Ѵ���� */            
                             brstat.tlt.fax    =  nv_remark4    /*ʶҹ���Ѵ���� */ 
                             brstat.tlt.note24 =  IF tlt.note24 <> "" THEN tlt.note24  + "," + nv_message + " �Ţ���ͧ : " + nv_docno
                                                  ELSE nv_message + " �Ţ���ͧ : " + nv_docno.
                    END.
                END. /* end docno <> "" */
                ELSE DO:
                    ASSIGN brstat.tlt.lotno   = "N"
                           brstat.tlt.acno1   = " Edit Date: " + nv_remark2    /*�Ţ����Ǩ��Ҿ  + �ѹ��� update ���ͧ*/      
                           brstat.tlt.mobile  =  nv_remark3                    /* �ѹ���Ѵ���� */            
                           brstat.tlt.fax     =  nv_remark4                    /*ʶҹ���Ѵ���� */
                           brstat.tlt.note24  =  IF tlt.note24 <> "" THEN tlt.note24  + "," + nv_message ELSE nv_message.
                END.
                RELEASE  OBJECT chitem          NO-ERROR.
                RELEASE  OBJECT chDocument      NO-ERROR.          
                RELEASE  OBJECT chNotesDataBase NO-ERROR.     
                RELEASE  OBJECT chNotesSession  NO-ERROR.
                
             END.  /* end chDocument = yes */
             ELSE IF VALID-HANDLE(chDocument) = NO  THEN DO:
                  /*---Begin chaiyong W. A65-0XXX 21/12/2022*/
                  IF nv_stinsp  = "Not Found Create YEAR NOW" THEN DO:
                  END.
                  ELSE IF nv_stinsp  = "Not Found Create YEAR NOW2" THEN DO:
                      NEXT loop_Crisp.
                  END. 
                  ELSE DO:
                      nv_stinsp  = "YEAR PRV".
                      NEXT loop_Crisp.
                  END.                
                  /*End by Chaiyogn w. A65-0XXX 21/12/2022--*/
                   chDocument = chNotesDatabase:CreateDocument.
                   chDocument:AppendItemValue( "Form", "Inspection").
                   chDocument:AppendItemValue( "createdBy", chNotesSession:UserName).
                   chDocument:AppendItemValue( "createdOn", nv_today + " " + nv_time).
                   chDocument:AppendItemValue("SendOn", nv_today + " " + nv_time).  /*---add by Chaiyong W. A65-0XXXX 21/12/2022*/
                   chDocument:AppendItemValue("ChkHOBR",nv_ChkHOBR).                /*---add by Chaiyong W. A65-0XXXX 21/12/2022*/
                   chDocument:AppendItemValue( "App", 0 ).
                   chDocument:AppendItemValue( "Chk", 0 ).
                   chDocument:AppendItemValue( "dateS", wdetail.comdat ).
                   chDocument:AppendItemValue( "dateE", wdetail.expdat ).
                   chDocument:AppendItemValue( "ReqType_sub", nv_subtyp /*"��Ǩ��Ҿ����"*/ ).
                   chDocument:AppendItemValue( "BranchReq", nv_branHO).
                   chDocument:AppendItemValue( "Tname", nv_nameT).
                   chDocument:AppendItemValue( "Fname", nv_fname ).    
                   chDocument:AppendItemValue( "Lname", nv_lname).
                   chDocument:AppendItemValue( "Phone1", wdetail.tel1).
                   chDocument:AppendItemValue( "Phone2", wdetail.tel2 ).
                   chDocument:AppendItemValue( "dateMeet", "").    
                   chDocument:AppendItemValue( "placeMeet", "").
                   chDocument:AppendItemValue( "PolicyNo", wdetail.notifyno). 
                   chDocument:AppendItemValue( "agentCode",trim(fi_agent)).  
                   chDocument:AppendItemValue( "Agentname",TRIM(nv_agentname)).
                   chDocument:AppendItemValue( "model", nv_brand).
                   chDocument:AppendItemValue( "modelCode", nv_model).
                   chDocument:AppendItemValue( "carCC", trim(wdetail.chassis)).
                   chDocument:AppendItemValue( "Year", trim(wdetail.cyear)).           
                   chDocument:AppendItemValue( "LicenseType", trim(nv_licentyp)).
                   chDocument:AppendItemValue( "PatternLi1", trim(nv_Pattern1)).
                   chDocument:AppendItemValue( "PatternLi4", trim(nv_Pattern4)).
                   chDocument:AppendItemValue( "LicenseNo_1", trim(nv_licen)).
                   chDocument:AppendItemValue( "LicenseNo_2", trim(wdetail.prolice)).
                   chDocument:AppendItemValue( "commentMK", wdetail.remark ).
                   chDocument:AppendItemValue( "Premium", wdetail.prem1 ).
                   chDocument:AppendItemValue( "StList",0 ).                                  
                   chDocument:AppendItemValue( "stHide",0 ).                                  
                   chDocument:AppendItemValue( "SendTo", "" ).                                 
                   chDocument:AppendItemValue( "SendCC", "" ).
                   chDocument:AppendItemValue( "App",0 )       .                           
                   chDocument:AppendItemValue( "Chk",0 )       .                           
                   chDocument:AppendItemValue( "StList",0 )    .                               
                   chDocument:AppendItemValue( "stHide",0 )    .                               
                   chDocument:AppendItemValue( "SendTo","" )   .                              
                   chDocument:AppendItemValue( "SendCC","" )   .                              
                   chDocument:AppendItemValue( "SendClose","" ).
                   chDocument:AppendItemValue( "SurveyClose","").                    
                   chDocument:AppendItemValue( "docno","").
                   chDocument:SAVE(TRUE,TRUE).
                 RELEASE  OBJECT chitem          NO-ERROR.
                 RELEASE  OBJECT chDocument      NO-ERROR.          
                 RELEASE  OBJECT chNotesDataBase NO-ERROR.     
                 RELEASE  OBJECT chNotesSession  NO-ERROR.
                ASSIGN brstat.tlt.lotno  = "N"
                       brstat.tlt.acno1  = ""     /*�Ţ����Ǩ��Ҿ  + �ѹ���Դ����ͧ*/        
                       brstat.tlt.mobile = ""     /* ����������� + ��¡�ä���������� */        
                       brstat.tlt.fax    = ""     /*��������´�ػ�ó������ */  
                       brstat.tlt.note24 = IF tlt.note24 <> "" THEN tlt.note24  + "," + nv_message ELSE nv_message. 
             END. /* end chDocument = NO  */
             /*---Begin chaiyong W. A65-0XXX 21/12/2022*/
             LEAVE loop_Crisp.
             /*End by Chaiyogn w. A65-0XXX 21/12/2022--*/


         END.
         ELSE DO: /* entry view = 0 */
              /*---Begin chaiyong W. A65-0XXX 21/12/2022*/
               IF nv_stinsp  = "Not Found Create YEAR NOW" THEN DO:
               END.
               ELSE IF nv_stinsp  = "Not Found Create YEAR NOW2" THEN DO:
                   NEXT loop_Crisp.
               END. 
               ELSE DO:
                   nv_stinsp  = "YEAR PRV".
                   NEXT loop_Crisp.
               END.                
               /*End by Chaiyogn w. A65-0XXX 21/12/2022--*/
                chDocument = chNotesDatabase:CreateDocument.
                chDocument:AppendItemValue( "Form", "Inspection").
                chDocument:AppendItemValue( "createdBy", chNotesSession:UserName).
                chDocument:AppendItemValue( "createdOn", nv_today + " " + nv_time).
                chDocument:AppendItemValue("SendOn", nv_today + " " + nv_time).  /*---add by Chaiyong W. A65-0XXXX 21/12/2022*/
                chDocument:AppendItemValue("ChkHOBR",nv_ChkHOBR).                /*---add by Chaiyong W. A65-0XXXX 21/12/2022*/
                chDocument:AppendItemValue( "App", 0 ).
                chDocument:AppendItemValue( "Chk", 0 ).
                chDocument:AppendItemValue( "dateS", wdetail.comdat ).
                chDocument:AppendItemValue( "dateE", wdetail.expdat ).
                chDocument:AppendItemValue( "ReqType_sub", nv_subtyp /*"��Ǩ��Ҿ����"*/ ).
                chDocument:AppendItemValue( "BranchReq", nv_branHO).
                chDocument:AppendItemValue( "Tname", nv_nameT).
                chDocument:AppendItemValue( "Fname", nv_fname).    
                chDocument:AppendItemValue( "Lname", nv_lname).
                chDocument:AppendItemValue( "Phone1", wdetail.tel1).
                chDocument:AppendItemValue( "Phone2", wdetail.tel2 ).
                chDocument:AppendItemValue( "dateMeet", "").    
                chDocument:AppendItemValue( "placeMeet", "").
                chDocument:AppendItemValue( "PolicyNo", wdetail.notifyno). 
                chDocument:AppendItemValue( "agentCode",trim(fi_agent)).  
                chDocument:AppendItemValue( "Agentname",TRIM(nv_agentname)).
                chDocument:AppendItemValue( "model", nv_brand).
                chDocument:AppendItemValue( "modelCode", nv_model).
                chDocument:AppendItemValue( "carCC", trim(wdetail.chassis)).
                chDocument:AppendItemValue( "Year", trim(wdetail.cyear)).           
                chDocument:AppendItemValue( "LicenseType", trim(nv_licentyp)).
                chDocument:AppendItemValue( "PatternLi1", trim(nv_Pattern1)).
                chDocument:AppendItemValue( "PatternLi4", trim(nv_Pattern4)).
                chDocument:AppendItemValue( "LicenseNo_1", trim(nv_licen)).
                chDocument:AppendItemValue( "LicenseNo_2", trim(wdetail.prolice)).
                chDocument:AppendItemValue( "commentMK", wdetail.remark /*"�ع��Сѹ " + wdetail.ins_amt1*/ ).
                chDocument:AppendItemValue( "Premium", wdetail.prem1 ).
                chDocument:AppendItemValue( "StList",0 ).                                  
                chDocument:AppendItemValue( "stHide",0 ).
                chDocument:AppendItemValue( "SendTo", "" ).                                 
                chDocument:AppendItemValue( "SendCC", "" ).
                chDocument:AppendItemValue( "App",0 )       .                           
                chDocument:AppendItemValue( "Chk",0 )       .                           
                chDocument:AppendItemValue( "StList",0 )    .                               
                chDocument:AppendItemValue( "stHide",0 )    .                               
                chDocument:AppendItemValue( "SendTo","" )   .                              
                chDocument:AppendItemValue( "SendCC","" )   .                              
                chDocument:AppendItemValue( "SendClose","" ).
                chDocument:AppendItemValue( "SurveyClose","").                    
                chDocument:AppendItemValue( "docno","").
                chDocument:SAVE(TRUE,TRUE).
              RELEASE  OBJECT chitem          NO-ERROR.
              RELEASE  OBJECT chDocument      NO-ERROR.          
              RELEASE  OBJECT chNotesDataBase NO-ERROR.     
              RELEASE  OBJECT chNotesSession  NO-ERROR.
             ASSIGN brstat.tlt.lotno  = "N"
                    brstat.tlt.acno1  = ""     /*�Ţ����Ǩ��Ҿ  + �ѹ���Դ����ͧ*/        
                    brstat.tlt.mobile = ""     /* ����������� + ��¡�ä���������� */        
                    brstat.tlt.fax    = ""     /*��������´�ػ�ó������ */
                    brstat.tlt.note24 = IF tlt.note24 <> "" THEN tlt.note24  + "," + nv_message ELSE nv_message.
            /*---Begin chaiyong W. A65-0XXX 21/12/2022*/
            LEAVE loop_Crisp.
            /*End by Chaiyogn w. A65-0XXX 21/12/2022--*/
          END.
        END. 
    /*----Begin by Chaiyong W. A65-0288 06/01/2023*/
    END.
    /*End by Chaiyong W. A65-0288 06/01/2023------*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkinsp2 C-Win 
PROCEDURE proc_chkinsp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF index(tlt.note5,"Renew") <> 0  THEN ASSIGN nv_message = "�͵�Ǩ��Ҿ"    nv_subtyp = "��Ǩ��Ҿ����" .
ELSE ASSIGN nv_message = "���ٻ��Ǩ��Ҿö�ҡ KKP"   nv_subtyp = "�١���/���᷹/���˹���繼�����ٻ��Ǩ��Ҿ" .
ASSIGN  nv_nameT    = ""   nv_agentname = ""  nv_brand    = ""   nv_model   = ""   nv_licentyp = ""   nv_licen     = ""  
        nv_pattern1 = ""   nv_pattern4  = ""  nv_today    = ""   nv_time    = ""   nv_docno    = ""   nv_survey    = ""  
        nv_detail   = ""   nv_remark1   = ""  nv_remark2  = ""   nv_damlist = ""   nv_damage   = ""   nv_totaldam  = ""  
        nv_attfile  = ""   nv_device    = ""  nv_acc1     = ""   nv_acc2    = ""   nv_acc3     = ""   nv_acc4      = ""   
        nv_acc5     = ""   nv_acc6      = ""  nv_acc7     = ""   nv_acc8    = ""   nv_acc9     = ""   nv_acc10     = ""   
        nv_acc11    = ""   nv_acc12     = ""  nv_acctotal = ""   nv_surdata = ""   nv_date     = ""   nv_damdetail = ""
        nv_price1   = ""   nv_price2    = ""  nv_price3   = ""   nv_price4  = ""   nv_remark3  = ""   nv_remark4   = "" 
        nv_price5   = ""   nv_price6    = ""  nv_price7   = ""   nv_price8  = ""   nv_fname   = ""    nv_lname = ""               
        nv_price9   = ""   nv_price10   = ""  nv_price11  = ""   nv_price12 = ""    nv_branHo  = ""
       /* nv_branHo   = IF   trim(wdetail.brancho) = "�ӹѡ�ҹ�˭�" THEN "Bank&Finance" ELSE IF trim(wdetail.brancho) = "" THEN "Bank&Finance"
                      ELSE TRIM(wdetail.brancho) comment by Chaiyong W. A65-0XXX 21/12/2022*/
        nv_tmp      = "Inspect" + SUBSTR(STRING(YEAR(TODAY),"9999"),3,2) + ".nsf" 
        nv_today    = STRING(DAY(TODAY),"99") + "/" + STRING(MONTH(TODAY),"99") + "/" + STRING(YEAR(TODAY),"9999")
        nv_time     = STRING(TIME,"HH:MM:SS") .


/*---Begin chaiyong W. A65-0XXX 21/12/2022*/
ASSIGN
    nv_Chkbrcode = ""
    nv_Chkbrname = ""
    nv_ChkHOBR   = "".

IF trim(wdetail.brancho) = "�ӹѡ�ҹ�˭�" OR trim(wdetail.brancho) = "" THEN  DO:
    ASSIGN
        nv_branHo  = "Bank&Finance"
        nv_ChkHOBR = "HO".
END.
ELSE DO:
    RUN wgw\wgwkkfbri(INPUT wdetail.brancho,
                      OUTPUT nv_Chkbrcode ,
                      OUTPUT nv_Chkbrname ,
                      OUTPUT nv_ChkHOBR ).
    IF nv_Chkbrname <> "" THEN  nv_branHo =  nv_Chkbrname.

    /*--
    FIND FIRST stat.insure USE-INDEX insure03 WHERE                                        
        stat.insure.compno = "kk"                              AND                         
        index(trim(wdetail.brancho),trim(stat.insure.fname)) <> 0 NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL stat.insure THEN DO: 
        nv_Chkbrcode   = CAPS(stat.insure.branch) . 
        RUN wuw\wuwqbanc (INPUT nv_Chkbrcode ,OUTPUT nv_Chkbrname, OUTPUT nv_ChkHOBR). 
        /*----Special---*/
    END.
    ELSE nv_branHo  = TRIM(wdetail.brancho) .*/
END.                                         
/*End by Chaiyogn w. A65-0XXX 21/12/2022--*/

IF INDEX(wdetail.n_TITLE,"�س")               <> 0 THEN ASSIGN wdetail.n_TITLE = REPLACE(wdetail.n_TITLE,"�س","")    nv_nameT = "�ؤ��".
ELSE IF INDEX(wdetail.n_TITLE,"���")          <> 0 THEN ASSIGN wdetail.n_TITLE = REPLACE(wdetail.n_TITLE,"���","")    nv_nameT = "�ؤ��".
ELSE IF INDEX(wdetail.n_TITLE,"�ҧ���")       <> 0 THEN ASSIGN wdetail.n_TITLE = REPLACE(wdetail.n_TITLE,"�ҧ���","") nv_nameT = "�ؤ��".
ELSE IF INDEX(wdetail.n_TITLE,"�ҧ")          <> 0 THEN ASSIGN wdetail.n_TITLE = REPLACE(wdetail.n_TITLE,"�ҧ","")    nv_nameT = "�ؤ��".
ELSE IF INDEX(wdetail.n_TITLE,"�.�.")         <> 0 THEN ASSIGN wdetail.n_TITLE = REPLACE(wdetail.n_TITLE,"�.�.","")   nv_nameT = "�ؤ��".
ELSE IF INDEX(wdetail.n_TITLE,"��ҧ�����ǹ") <> 0 THEN ASSIGN nv_nameT = "��ҧ�����ǹ�ӡѴ / ��ҧ�����ǹ".
ELSE IF INDEX(wdetail.n_TITLE,"˨�")          <> 0 THEN ASSIGN nv_nameT = "��ҧ�����ǹ�ӡѴ / ��ҧ�����ǹ".
ELSE IF INDEX(wdetail.n_TITLE,"����ѷ")       <> 0 THEN ASSIGN nv_nameT = "����ѷ".
ELSE IF INDEX(wdetail.n_TITLE,"���")          <> 0 THEN ASSIGN nv_nameT = "����ѷ".
ELSE IF INDEX(wdetail.n_TITLE,"��ŹԸ�")      <> 0 THEN ASSIGN nv_nameT = "��ŹԸ�".
ELSE IF INDEX(wdetail.n_TITLE,"�ç���")       <> 0 THEN ASSIGN nv_nameT = "�ç���".
ELSE IF INDEX(wdetail.n_TITLE,"�ç���¹")     <> 0 THEN ASSIGN nv_nameT = "�ç���¹".
ELSE IF INDEX(wdetail.n_TITLE,"�.�.")         <> 0 THEN ASSIGN nv_nameT = "�ç���¹".
ELSE IF INDEX(wdetail.n_TITLE,"�ç��Һ��")    <> 0 THEN ASSIGN nv_nameT = "�ç��Һ��".
ELSE IF INDEX(wdetail.n_TITLE,"�ԵԺؤ���Ҥ�êش") <> 0 THEN ASSIGN nv_nameT = "�ԵԺؤ���Ҥ�êش".
ELSE ASSIGN nv_nameT = "����".
IF nv_nameT = "�ؤ��" THEN ASSIGN nv_fname = TRIM(SUBSTR(wdetail.n_name1,1,INDEX(wdetail.n_name1," ")))  nv_lname = trim(SUBSTR(wdetail.n_name1,R-INDEX(wdetail.n_name1," "))).
ELSE ASSIGN nv_fname = trim(wdetail.n_name1)  nv_lname = "" .

ASSIGN nv_brand = trim(wdetail.brand) nv_model = TRIM(wdetail.model).
IF trim(wdetail.licence) <> "" AND trim(wdetail.prolice) <> "" THEN DO:
    ASSIGN nv_licentyp = "ö��/��к�/��÷ء".
    RUN proc_province.
END.
ELSE DO: 
    ASSIGN nv_licentyp = "ö����ѧ����շ���¹"     nv_pattern4 = "/ZZZZZZZZZ" 
           wdetail.licence = "/" + SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8,LENGTH(wdetail.chassis)) 
           wdetail.prolice = "".
END.
IF trim(fi_agent) <> "" THEN DO:
 FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE xmm600.acno  =  trim(fi_agent) NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        FIND sicsyac.xtm600 USE-INDEX xtm60001  WHERE xtm600.acno  =  trim(fi_agent) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xtm600 THEN ASSIGN nv_agentname = TRIM(sicsyac.xtm600.ntitle) + "  "  + TRIM(sicsyac.xtm600.name) .
        ELSE ASSIGN nv_agentname = "".
    END.
    ELSE ASSIGN nv_agentname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
END.
IF trim(wdetail.licence) <> "" THEN DO:
   ASSIGN nv_licen = REPLACE(wdetail.licence," ","").
   IF INDEX("0123456789",SUBSTR(wdetail.licence,1,1)) <> 0 THEN DO:
       IF      LENGTH(nv_licen) = 4 THEN ASSIGN nv_Pattern1 = "yxx-y-xx"     nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,1).  
       ELSE IF LENGTH(nv_licen) = 5 THEN ASSIGN nv_Pattern1 = "yxx-yy-xx"    nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,2).  
       ELSE IF LENGTH(nv_licen) = 6 THEN DO:
           IF      INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN ASSIGN nv_Pattern1 = "yy-yyyy-xx"  nv_licen  = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN ASSIGN nv_Pattern1 = "yx-yyyy-xx"  nv_licen  = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE  ASSIGN nv_Pattern1 = "yxx-yyy-xx"   nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,3).
       END.
       ELSE ASSIGN nv_Pattern1 = "yxx-yyyy-xx"   nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,4). 
    END.
    ELSE DO:
        IF      LENGTH(nv_licen) = 3 THEN  ASSIGN nv_Pattern1 = "xx-y-xx"   nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,1) .
        ELSE IF LENGTH(nv_licen) = 4 THEN  ASSIGN nv_Pattern1 = "xx-yy-xx"  nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,2) .
        ELSE IF LENGTH(nv_licen) = 6 THEN DO:
          IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN ASSIGN nv_Pattern1 = "xx-yyyy-xx"  nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
          ELSE ASSIGN nv_Pattern1 = "xxx-yyy-xx"  nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,3). 
        END.
        ELSE IF LENGTH(nv_licen) = 5 THEN DO:
            IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN ASSIGN nv_Pattern1 = "x-yyyy-xx"  nv_licen = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,4).
            ELSE ASSIGN nv_Pattern1 = "xx-yyy-xx"   nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,3).
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpol C-Win 
PROCEDURE proc_chkpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_comdat AS DATE .
DEF VAR nv_expdat AS DATE .
DEF VAR nv_date   AS CHAR .
DEF VAR nv_poltyp AS CHAR .

LOOP_wpol:
FOR EACH wpol :
    IF trim(wpol.notifyno) = "" AND trim(wpol.KKapp) = ""  THEN DO:
        /*MESSAGE "�Ţ�Ѻ�� ��� KK App �繤����ҧ �������ö�Ң�������к��� ." VIEW-AS ALERT-BOX.*/
        DELETE wpol.
    END.
    ELSE DO:
        ASSIGN nv_comdat  = ?       nv_expdat  = ?
               nv_date    = ""      nv_poltyp  = ""
               nv_date    = TRIM(REPLACE(wpol.EffDate,"-","/"))
               nv_comdat  = DATE(nv_date)
               nv_date    = TRIM(REPLACE(wpol.ExpDate,"-","/")) 
               nv_expdat  = DATE(nv_date) 
               nv_poltyp  = IF index(wpol.Pack_Name,"�Ҥ�ѧ�Ѻ") <> 0 THEN "V72" ELSE "V70" .
        
        IF wpol.notifyno <> "" THEN DO:
            FIND LAST tlt    WHERE 
                tlt.comp_noti_tlt    = trim(wpol.notifyno) AND 
                tlt.cha_no           = TRIM(wpol.chass) AND 
                tlt.covcod           = trim(wpol.Pack_Name) AND 
                tlt.genusr           = "kk"          NO-ERROR NO-WAIT .
            IF AVAIL tlt THEN DO:  
                nv_completecnt  =  nv_completecnt + 1.
        
                FIND LAST sicuw.uwm100  USE-INDEX uwm10002  WHERE
                          sicuw.uwm100.poltyp  = nv_poltyp     AND
                          sicuw.uwm100.cedpol  = trim(wpol.notifyno)  NO-LOCK NO-ERROR NO-WAIT.  
                IF AVAIL sicuw.uwm100 THEN DO:
                    ASSIGN wpol.premiumpol = sicuw.uwm100.policy .
                    IF sicuw.uwm100.comdat = nv_comdat AND 
                       sicuw.uwm100.expdat = nv_expdat THEN DO:
                    END.
                    ELSE ASSIGN wpol.premiumpol = wpol.premiumpol + " �ѹ��������ͧ�������ç�Ѻ��������" .
                END.  
                IF tlt.releas = "NO" THEN DO:
                    ASSIGN wpol.polstatus = "�ѧ����͡�ҹ" 
                           wpol.policy    = tlt.policy
                           wpol.Remark    = tlt.note24
                           wpol.Hproblem  = tlt.note29
                           wpol.Hclaim    = tlt.hclfg .
                    IF tlt.usrsent = "Y" THEN DO:
                        IF brstat.tlt.lotno = "Y" THEN DO: 
                            ASSIGN wpol.inspremark =  brstat.tlt.mobile .
                            IF brstat.tlt.fax <> ""  THEN wpol.inspremark = wpol.inspremark + " �ػ�ó������ : " + brstat.tlt.fax .
                        END.
                        ELSE IF brstat.tlt.lotno = "N" THEN  DO:
                            ASSIGN wpol.inspremark = "�͵�Ǩ��Ҿ �Ţ�����ͧ :" + trim(substr(tlt.acno1,1,INDEX(tlt.acno1," "))) .
                        END.
                    END.
                    ELSE ASSIGN wpol.inspremark = "" .
        
                END.
                ELSE IF tlt.releas = "YES" THEN DO:
                   ASSIGN wpol.polstatus =  "�͡�ҹ����" 
                          wpol.policy    = tlt.policy
                          wpol.Remark    = tlt.note24
                          wpol.Hproblem  = tlt.note29
                          wpol.Hclaim    = tlt.hclfg .
                   IF tlt.usrsent = "Y" THEN DO:
                      IF brstat.tlt.lotno = "Y" THEN DO: 
                         ASSIGN wpol.inspremark =  brstat.tlt.mobile .
                         IF brstat.tlt.fax <> ""  THEN wpol.inspremark = wpol.inspremark + " �ػ�ó������ : " + brstat.tlt.fax .
                      END.
                      ELSE IF brstat.tlt.lotno = "N" THEN  DO:
                          ASSIGN wpol.inspremark = "�͵�Ǩ��Ҿ �Ţ�����ͧ :" + trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  .
                      END.
                   END.
                   ELSE ASSIGN wpol.inspremark = "" .
                END.
            END.
            ELSE DO:
                ASSIGN nv_error       = nv_error + 1 
                       wpol.polstatus = "��辺 �Ţ�Ѻ�駡Ѻ�Ţ��Ƕѧ��� ��к��ѧ�ѡ KK".
            END.
        END.
        ELSE DO:
            FIND LAST tlt    WHERE 
                tlt.expotim    = trim(wpol.kkapp)     AND 
                tlt.cha_no     = TRIM(wpol.chass)     AND
                tlt.covcod     = trim(wpol.Pack_Name) AND 
                tlt.genusr     = "kk"           NO-ERROR NO-WAIT .
            IF AVAIL tlt THEN DO:  
                nv_completecnt  =  nv_completecnt + 1.
                 FIND LAST sicuw.uwm100  USE-INDEX uwm10002  WHERE
                           sicuw.uwm100.poltyp  = nv_poltyp     AND
                           sicuw.uwm100.cedpol  = trim(wpol.kkapp)  NO-LOCK NO-ERROR NO-WAIT.  
                 IF AVAIL sicuw.uwm100 THEN DO:
                     ASSIGN wpol.premiumpol = sicuw.uwm100.policy .
                     IF sicuw.uwm100.comdat = nv_comdat AND 
                        sicuw.uwm100.expdat = nv_expdat THEN DO:
                     END.
                     ELSE ASSIGN wpol.premiumpol = wpol.premiumpol + " �ѹ��������ͧ�������ç�Ѻ��������" .
                 END.  
                 IF tlt.releas = "NO" THEN DO:
                    ASSIGN wpol.polstatus = "�ѧ����͡�ҹ" 
                           wpol.policy    = tlt.policy
                           wpol.Remark    = tlt.note24
                           wpol.Hproblem  = tlt.note29
                           wpol.Hclaim    = tlt.hclfg .
                    IF tlt.usrsent = "Y" THEN DO:
                        IF brstat.tlt.lotno = "Y" THEN DO: 
                            ASSIGN wpol.inspremark =  brstat.tlt.mobile .
                            IF brstat.tlt.fax <> ""  THEN wpol.inspremark = wpol.inspremark + " �ػ�ó������ : " + brstat.tlt.fax .
                        END.
                        ELSE IF brstat.tlt.lotno = "N" THEN  DO:
                            ASSIGN wpol.inspremark = "�͵�Ǩ��Ҿ �Ţ�����ͧ :" + trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  .
                        END.
                        ELSE ASSIGN wpol.inspremark = "" .
                    END.
                 END.
                 ELSE IF tlt.releas = "YES" THEN DO:
                     ASSIGN wpol.polstatus =  "�͡�ҹ����" 
                            wpol.policy    = tlt.policy
                            wpol.Remark    = tlt.note24
                            wpol.Hproblem  = tlt.note29
                            wpol.Hclaim    = tlt.hclfg .
                     IF tlt.usrsent = "Y" THEN DO:
                        IF brstat.tlt.lotno = "Y" THEN DO: 
                            ASSIGN wpol.inspremark =  brstat.tlt.mobile .
                            IF brstat.tlt.fax <> ""  THEN wpol.inspremark = wpol.inspremark + " �ػ�ó������ : " + brstat.tlt.fax .
                        END.
                        ELSE IF brstat.tlt.lotno = "N" THEN  DO:
                            ASSIGN wpol.inspremark = "�͵�Ǩ��Ҿ �Ţ�����ͧ :" + trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  .
                        END.
                     END.
                     ELSE ASSIGN wpol.inspremark = "" .
                 END.
            END.
            ELSE DO:
                ASSIGN nv_error       = nv_error + 1 
                       wpol.polstatus = "��辺 �Ţ KKApp.�Ѻ�Ţ��Ƕѧ��� ��к��ѧ�ѡ KK".
            END.
        END.
        IF ((wpol.Hproblem = "Y" ) OR (wpol.Hclaim = "Y" ) OR (INDEX(wpol.inspremark,"�͵�Ǩ��Ҿ") <> 0 ) AND wpol.polstatus = "�ѧ����͡�ҹ") THEN RUN pd_fSLA.
        ELSE IF wpol.polstatus = "�ѧ����͡�ҹ" AND wpol.Hproblem = "N" AND  wpol.Hclaim = "N" THEN RUN pd_fcom.
        RUN pd_fAll.
    END.

END.   /* FOR EACH wpol NO-LOCK: */
RELEASE tlt NO-ERROR.
Run Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Getdatainsp C-Win 
PROCEDURE Proc_Getdatainsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A65-0288    
------------------------------------------------------------------------------*/
DEF VAR n_list      AS INT init 0.
DEF VAR n_count     AS INT init 0.
DEF VAR n_agent     AS CHAR FORMAT "x(10)" INIT "".
DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".
def var nv_chk      as char init ""    .
def var nv_commt    as char init ""    .
def var nv_appdate   as char init "" .
def var nv_apploc    as char init "" .
DEF VAR nv_chkname   AS CHAR INIT "" .
def var nv_chkdate   as char init "" .
def var nv_Dappoint  as CHAR init "" .
def var nv_Lappoint  as char init "" .
def var nv_comment  as char init "" .

DO:
      chitem       = chDocument:Getfirstitem("ConsiderDate").      /*�ѹ���Դ����ͧ*/
      IF chitem <> 0 THEN nv_date = chitem:TEXT. 
      ELSE nv_date = "".

      chitem       = chDocument:Getfirstitem("docno").      /*�Ţ��Ǩ��Ҿ*/
      IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
      ELSE nv_docno = "".
      
      chitem       = chDocument:Getfirstitem("SurveyClose").    /* �൵�ʻԴ����ͧ */
      IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
      ELSE nv_survey = "".

      IF nv_survey = "" THEN DO:
          chitem       = chDocument:Getfirstitem("sendby1").  /*��������´��õ�Ǩ*/
          IF chitem <> 0 THEN  nv_remark1 = chitem:TEXT. 
          ELSE nv_remark1 = "".

          IF nv_remark1 <> "" THEN DO:
              
               ASSIGN  n_count = 1 .
               loop_comment:
               REPEAT:
                   IF n_count <= 7 THEN DO:
                       ASSIGN  nv_chk     = "sendby"  + STRING(n_count)  /*�������˹�ҷ�� update */
                               nv_commt   = "sendOn"  + STRING(n_count)    /*�ѹ���������� update */
                               nv_appdate = "DateAppointment"   + STRING(n_count) /*+ "_C"*/     /*�ѹ���Ѵ���� */
                               nv_apploc  = "AppointmentLocate" + STRING(n_count) /*+ "_C"*/  .  /*ʶҹ���Ѵ���� */
                               /*nv_commt  = "commentIns" + STRING(n_count)   comment appointment */
          
                       chitem       = chDocument:Getfirstitem(nv_chk). 
                       IF chitem <> 0 THEN  nv_chkname  = chitem:TEXT. 
                       ELSE nv_chkname = "".  
          
                       chitem       = chDocument:Getfirstitem(nv_commt).
                       IF chitem <> 0 THEN  nv_chkdate = chitem:TEXT. 
                       ELSE nv_chkdate = "".

                       chitem       = chDocument:Getfirstitem(nv_appdate). 
                       IF chitem <> 0 THEN  nv_Dappoint  = chitem:TEXT. 
                       ELSE nv_Dappoint = ?.  
          
                       chitem       = chDocument:Getfirstitem(nv_apploc).
                       IF chitem <> 0 THEN  nv_Lappoint = chitem:TEXT. 
                       ELSE nv_Lappoint = "".

          
                       IF nv_chkname <> "" THEN DO: 
                           ASSIGN nv_remark2 = nv_chkdate   /* �ѹ����Ѿഷ*/
                                  nv_remark3 = nv_Dappoint  /* �ѹ���Ѵ����*/
                                  nv_remark4 = nv_Lappoint. /* ʶҹ���Ѵ����*/
                       END.
          
                       n_count = n_count + 1.
                   END.
                   ELSE LEAVE loop_comment.
               END.
          END.
          ELSE DO:
           chitem       = chDocument:Getfirstitem("Chkby1").  /*����չѴ���� */
            IF chitem <> 0 THEN  nv_remark1 = chitem:TEXT. 
            ELSE nv_remark1 = "".
            IF nv_remark1 <> "" THEN DO:
                 ASSIGN  n_count = 1 .
                 loop_comment:
                 REPEAT:
                     IF n_count <= 7 THEN DO:
                         ASSIGN  nv_chk     = "Chkby"  + STRING(n_count)  /*�������˹�ҷ�� update */
                                 nv_appdate = "ChkOn"  + STRING(n_count)    /*�ѹ���������� update */
                                 nv_apploc  = "ChksubjTo"  + STRING(n_count) /*+ "_C"*/    /*ʶҹ���Ѵ���� */
                                 nv_commt   = "commentIns" + STRING(n_count)  
            
                         chitem       = chDocument:Getfirstitem(nv_chk). 
                         IF chitem <> 0 THEN  nv_chkname  = chitem:TEXT. 
                         ELSE nv_chkname = "".  
            
                         /*chitem       = chDocument:Getfirstitem(nv_commt).
                         IF chitem <> 0 THEN  nv_chkdate = chitem:TEXT. 
                         ELSE nv_chkdate = "".*/
            
                         chitem       = chDocument:Getfirstitem(nv_appdate). 
                         IF chitem <> 0 THEN  nv_Dappoint  = chitem:TEXT. 
                         ELSE nv_Dappoint = ?.  
            
                         chitem       = chDocument:Getfirstitem(nv_apploc).
                         IF chitem <> 0 THEN  nv_Lappoint = chitem:TEXT. 
                         ELSE nv_Lappoint = "".

                         chitem       = chDocument:Getfirstitem(nv_commt).
                         IF chitem <> 0 THEN  nv_comment = chitem:TEXT. 
                         ELSE nv_comment = "".
            
                         IF nv_chkname <> "" THEN DO: 
                             ASSIGN nv_remark2 = nv_Dappoint   /* �ѹ����Ѿഷ*/
                                    nv_remark3 = ""            /* �ѹ���Ѵ����*/
                                    nv_remark4 = "����չѴ���� :" + nv_Lappoint + " " + nv_comment.  /* ��Ǣ�� + �������� */
                         END.
                         n_count = n_count + 1.
                     END.
                     ELSE LEAVE loop_comment.
                 END. /* end repeat */
            END. /* end remark */
          END. /* end else */
      END.

      chitem       = chDocument:Getfirstitem("SurveyResult").  /*�š�õ�Ǩ*/
      IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
      ELSE nv_detail = "".

      IF nv_detail = "�Դ�ѭ��" THEN DO:
          chitem       = chDocument:Getfirstitem("DamageC").    /*�����š�õԴ�ѭ�� */
          IF chitem <> 0 THEN nv_damage    = chitem:TEXT.
          ELSE nv_damage = "".
      END.
      IF nv_detail = "�դ����������"  THEN DO:
          chitem       = chDocument:Getfirstitem("DamageList").  /* ��¡�ä���������� */
          IF chitem <> 0 THEN nv_damlist  = chitem:TEXT.
          ELSE nv_damlist = "".
          chitem       = chDocument:Getfirstitem("TotalExpensive").  /* �ҤҤ���������� */
          IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
          ELSE nv_totaldam = "".

          IF nv_damlist <> "" THEN DO: 
              ASSIGN    n_list     = INT(nv_damlist) 
                        nv_damlist = "�ӹǹ " + nv_damlist + " ��¡�� " .
          END.
         /* IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "�������������� " + nv_totaldam + " �ҷ " . 17/11/2022*/
          
          IF n_list > 0  THEN DO:
            ASSIGN  n_count = 1 .
            loop_damage:
            REPEAT:
                IF n_count <= n_list THEN DO:
                    ASSIGN  n_dam    = "List"   + STRING(n_count) 
                            n_repair = "Repair" + STRING(n_count) .

                    chitem       = chDocument:Getfirstitem(n_dam).
                    IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                    ELSE nv_damag = "". 
                    /* �Ҥ�
                    chitem       = chDocument:Getfirstitem(n_repair).
                    IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                    ELSE nv_repair = "".*/

                    IF nv_damag <> "" THEN  
                        ASSIGN nv_damdetail = nv_damdetail + STRING(n_count) + "." + nv_damag /*+ " " + nv_repair */ + " , " .
                        
                    n_count = n_count + 1.
                END.
                ELSE LEAVE loop_damage.
            END.
          END.
          IF nv_damdetail <> "" THEN nv_damdetail = " ��¡�ä���������� " + nv_damdetail .
      END.
      /*-- ��������� � ---*/
      chitem       = chDocument:Getfirstitem("SurveyData").
      IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
      ELSE nv_surdata = "".
      IF trim(nv_surdata) <> "" THEN  nv_surdata = "���������� :"  +  nv_surdata .
      /*
      chitem       = chDocument:Getfirstitem("agentCode").      /*agentCode*/
      IF chitem <> 0 THEN n_agent = chitem:TEXT. 
      ELSE n_agent = "".
      
      IF TRIM(n_agent) <> "" THEN ASSIGN nv_surdata = nv_surdata + " �鴵��᷹: " + n_agent.*/

      /*-- �ػ�ó������ --*/  
      chitem       = chDocument:Getfirstitem("device1").
      IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
      ELSE nv_device = "".
      IF nv_device <> "" THEN DO:
          chitem       = chDocument:Getfirstitem("PricesTotal").  /* �Ҥ�����ػ�ó������ */
          IF chitem <> 0 THEN  nv_acctotal = chitem:TEXT. 
          ELSE nv_acctotal = "".
          chitem       = chDocument:Getfirstitem("DType1").
          IF chitem <> 0 THEN  nv_acc1 = chitem:TEXT. 
          ELSE nv_acc1 = "".
          chitem       = chDocument:Getfirstitem("DType2").
          IF chitem <> 0 THEN  nv_acc2 = chitem:TEXT. 
          ELSE nv_acc2 = "".
          chitem       = chDocument:Getfirstitem("DType3").
          IF chitem <> 0 THEN  nv_acc3 = chitem:TEXT. 
          ELSE nv_acc3 = "".
          chitem       = chDocument:Getfirstitem("DType4").
          IF chitem <> 0 THEN  nv_acc4 = chitem:TEXT. 
          ELSE nv_acc4 = "".
          chitem       = chDocument:Getfirstitem("DType5").
          IF chitem <> 0 THEN  nv_acc5 = chitem:TEXT. 
          ELSE nv_acc5 = "".
          chitem       = chDocument:Getfirstitem("DType6").
          IF chitem <> 0 THEN  nv_acc6 = chitem:TEXT. 
          ELSE nv_acc6 = "".
          chitem       = chDocument:Getfirstitem("DType7").
          IF chitem <> 0 THEN  nv_acc7 = chitem:TEXT. 
          ELSE nv_acc7 = "".
          chitem       = chDocument:Getfirstitem("DType8").
          IF chitem <> 0 THEN  nv_acc8 = chitem:TEXT. 
          ELSE nv_acc8 = "".
          chitem       = chDocument:Getfirstitem("DType9").
          IF chitem <> 0 THEN  nv_acc9 = chitem:TEXT. 
          ELSE nv_acc9 = "".
          chitem       = chDocument:Getfirstitem("DType10").
          IF chitem <> 0 THEN  nv_acc10 = chitem:TEXT. 
          ELSE nv_acc10 = "".
          chitem       = chDocument:Getfirstitem("DType11").
          IF chitem <> 0 THEN  nv_acc11 = chitem:TEXT. 
          ELSE nv_acc11 = "".
          chitem       = chDocument:Getfirstitem("DType12").
          IF chitem <> 0 THEN  nv_acc12 = chitem:TEXT. 
          ELSE nv_acc12 = "".
          /*
          chitem       = chDocument:Getfirstitem("pricesD_1").
          IF chitem <> 0 THEN  nv_price1 = chitem:TEXT. 
          ELSE nv_price1 = "".
          chitem       = chDocument:Getfirstitem("pricesD_2").
          IF chitem <> 0 THEN  nv_price2 = chitem:TEXT. 
          ELSE nv_price2 = "".
          chitem       = chDocument:Getfirstitem("pricesD_3").
          IF chitem <> 0 THEN  nv_price3 = chitem:TEXT. 
          ELSE nv_price3 = "".
          chitem       = chDocument:Getfirstitem("pricesD_4").
          IF chitem <> 0 THEN  nv_price4 = chitem:TEXT. 
          ELSE nv_price4 = "".
          chitem       = chDocument:Getfirstitem("pricesD_5").
          IF chitem <> 0 THEN  nv_price5 = chitem:TEXT. 
          ELSE nv_price5 = "".
          chitem       = chDocument:Getfirstitem("pricesD_6").
          IF chitem <> 0 THEN  nv_price6 = chitem:TEXT. 
          ELSE nv_price6 = "".
          chitem       = chDocument:Getfirstitem("pricesD_7").
          IF chitem <> 0 THEN  nv_price7 = chitem:TEXT. 
          ELSE nv_price7 = "".
          chitem       = chDocument:Getfirstitem("pricesD_8").
          IF chitem <> 0 THEN  nv_price8 = chitem:TEXT. 
          ELSE nv_price8 = "".
          chitem       = chDocument:Getfirstitem("pricesD_9").
          IF chitem <> 0 THEN  nv_price9 = chitem:TEXT. 
          ELSE nv_price9 = "".
          chitem       = chDocument:Getfirstitem("pricesD_10").
          IF chitem <> 0 THEN  nv_price10 = chitem:TEXT. 
          ELSE nv_price10 = "".
          chitem       = chDocument:Getfirstitem("pricesD_11").
          IF chitem <> 0 THEN  nv_price11 = chitem:TEXT. 
          ELSE nv_price11 = "".
          chitem       = chDocument:Getfirstitem("pricesD_12").
          IF chitem <> 0 THEN  nv_price12 = chitem:TEXT. 
          ELSE nv_price12 = "".*/
          
          nv_device = "" .
          IF TRIM(nv_acc1)  <> "" THEN nv_device = nv_device + TRIM(nv_acc1) /*+ " " + TRIM(nv_price1)*/.
          IF TRIM(nv_acc2)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc2)  /* + " " + TRIM(nv_price2) */ .
          IF TRIM(nv_acc3)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc3)  /* + " " + TRIM(nv_price3) */ .
          IF TRIM(nv_acc4)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc4)  /* + " " + TRIM(nv_price4) */ .
          IF TRIM(nv_acc5)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc5)  /* + " " + TRIM(nv_price5) */ .
          IF TRIM(nv_acc6)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc6)  /* + " " + TRIM(nv_price6) */ .
          IF TRIM(nv_acc7)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc7)  /* + " " + TRIM(nv_price7) */ .
          IF TRIM(nv_acc8)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc8)  /* + " " + TRIM(nv_price8) */ .
          IF TRIM(nv_acc9)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc9)  /* + " " + TRIM(nv_price9) */ .
          IF TRIM(nv_acc10) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc10) /* + " " + TRIM(nv_price10)*/ .  
          IF TRIM(nv_acc11) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc11) /* + " " + TRIM(nv_price11)*/ .  
          IF TRIM(nv_acc12) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc12) /* + " " + TRIM(nv_price12)*/ . 
          nv_acctotal = " �Ҥ�����ػ�ó������ " + nv_acctotal + " �ҷ " . 
      END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_head C-Win 
PROCEDURE proc_head :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A65-0288      
------------------------------------------------------------------------------*/
IF ra_filetyp = 7  THEN DO:
    OUTPUT TO VALUE(fi_kkcom). 
    EXPORT DELIMITER "|" 
        "�ӴѺ���"                           
        "�ѹ����Ѻ��"                      
        "�ѹ����Ѻ�Թ������»�Сѹ"        
        "��ª��ͺ���ѷ��Сѹ���"             
        "�Ţ����ѭ����ҫ���"   
        "New/Renew"
        "�Ţ�������������"                 
        "�����Ң�"                           
        "�Ң� KK"   
        "�Ң� TMSTH"  
        "�Ţ�Ѻ���"
        "KK Offer Flag"
        "Campaign"                           
        "Sub Campaign"                       
        "�ؤ��/�ԵԺؤ��"                    
        "�ӹ�˹�Ҫ���"                       
        "���ͼ����һ�Сѹ"                   
        "���ʡ�ż����һ�Сѹ"                
        "��ҹ�Ţ���"                         
        "�Ӻ�/�ǧ"                          
        "�����/ࢵ"                          
        "�ѧ��Ѵ"                            
        "������ɳ���"                      
        "����������������ͧ"                
        "��������ë���"                     
        "�ѹ�����������ͧ"                  
        "�ѹ����ش������ͧ"                
        "����ö"                            
        "��������Сѹ���ö¹��"             
        "����������ö"                      
        "���ö"                            
        "New/Used"                          
        "�Ţ����¹"   
        "�ѧ��Ѵ������¹"
        "�Ţ��Ƕѧ"                         
        "�Ţ����ͧ¹��"                    
        "��ö¹��"                          
        "�ի�"  
        "�ç��� " /*A67-0076*/
        "���˹ѡ/�ѹ"    
        "�����"
        "�ع��Сѹ�� 1 "   
        "�����ط��"
        "����������������ҡû� 1"  
        "�����Ѻ���"                      
        "�������˹�ҷ�� MKT"               
        "�����˵�"                          
        "�ӹ�˹�Ҫ��� 1" /*A67-0076*/
        "���Ѻ����� 1     "
        "�ѹ�Դ���Ѻ��� 1 "
        "�Ţ���㺢Ѻ��� 1   "
        "�� 1           " /*A67-0076*/
        "�Ҫվ 1         " /*A67-0076*/
        "ID NO/Passport 1" /*A67-0076*/
        "�дѺ���Ѻ��� 1" /*A67-0076*/
        "�ӹ�˹�Ҫ��� 2" /*A67-0076*/
        "���Ѻ����� 2     "
        "�ѹ�Դ���Ѻ��� 2 "
        "�Ţ���㺢Ѻ��� 2   "
        /*A67-0076*/
        "�� 2           "    
        "�Ҫվ 2         "     
        "ID NO/Passport 2" 
        "�дѺ���Ѻ��� 2" /*A67-0076*/
        "�ӹ�˹�Ҫ��� 3"       
        "���Ѻ����� 3     "  
        "�ѹ�Դ���Ѻ��� 3 "  
        "�Ţ���㺢Ѻ��� 3   "  
        "�� 3           "     
        "�Ҫվ 3         "     
        "ID NO/Passport 3" 
        "�дѺ���Ѻ��� 3" /*A67-0076*/
        "�ӹ�˹�Ҫ��� 4"       
        "���Ѻ����� 4     "  
        "�ѹ�Դ���Ѻ��� 4 "  
        "�Ţ���㺢Ѻ��� 4   "  
        "�� 4           "     
        "�Ҫվ 4         "     
        "ID NO/Passport 4"
        "�дѺ���Ѻ��� 4" /*A67-0076*/
        "�ӹ�˹�Ҫ��� 5"       
        "���Ѻ����� 5     "  
        "�ѹ�Դ���Ѻ��� 5 "  
        "�Ţ���㺢Ѻ��� 5   "  
        "�� 5           "     
        "�Ҫվ 5         "     
        "ID NO/Passport 5"
        "�дѺ���Ѻ��� 5" /*A67-0076*/
        /* end : A67-0076*/       
        "�ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)" 
        "���� (�����/㺡ӡѺ����)"         
        "���ʡ�� (�����/㺡ӡѺ����)"      
        "��ҹ�Ţ��� (�����/㺡ӡѺ����)"   
        "�Ӻ�/�ǧ (�����/㺡ӡѺ����)"    
        "�����/ࢵ (�����/㺡ӡѺ����)"    
        "�ѧ��Ѵ (�����/㺡ӡѺ����)"      
        "������ɳ��� (�����/㺡ӡѺ����)" 
        "��ǹŴ����ѵԴ�"                    
        "��ǹŴ�ҹ Fleet" 
        "����Դ��� "                 /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�"            /*A60-0232*/
        "�ѹ��͹���Դ   "            /*A60-0232*/
        "�Ҫվ            "            /*A60-0232*/
        "ʶҹ�Ҿ          "            /*A60-0232*/
        "��              "
        "�ѭ�ҵ�          "
        "�������          "
        "�Ţ��Шӵ�Ǽ�����������ҡ�"   /*A60-0232*/
        "�ӹ�˹�Ҫ��� 1  "             /*A60-0232*/
        "���͡������ 1   "             /*A60-0232*/
        "���ʡ�š������ 1"             /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�������� 1"   /*A60-0232*/
        "�ӹ�˹�Ҫ��� 2   "            /*A60-0232*/
        "���͡������ 2    "            /*A60-0232*/
        "���ʡ�š������ 2 "            /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�������� 2"   /*A60-0232*/
        "�ӹ�˹�Ҫ��� 3   "            /*A60-0232*/
        "���͡������ 3    "            /*A60-0232*/
        "���ʡ�š������ 3 "            /*A60-0232*/
        "�Ţ���ѵû�ЪҪ�������� 3"   /*A60-0232*/
        "�Ѵ���͡��÷���Ң� "   /*A61-0335*/  
        "���ͼ���Ѻ�͡���    "   /*A61-0335*/  
        "����Ѻ�Ż���ª��    "   /*A61-0335*/  
        "KK ApplicationNo    "   /*A61-0335*/  
        "Remak1"                       
        "Remak2" 
        "Dealer KK"        /* A63-00472*/
        "Dealer TMSTH"
        "Campaign no TMSTH"
        "Campaign OV      "
        "Producer code"
        "Agent Code   "
        "ReferenceNo     "     
        "KK Quotation No."     
        "Rider  No.      "   
        "Release"       /* A56-0309 */  
        "Loan First Date"
        "Policy Premium"
        "Note Un Problem"
        /*add by : A65-0288 */
        "Color"
        "Inspection"                                                
        "Inspection status"                                         
        "Inspection No"                                             
        "Inspection Closed Date"                                         
        "Inspection Detail"                     
        "inspection Damage"            
        "inspection Accessory " 
        /* end : A65-0288 */
         /* add : A67-0076 */
        "�ѹ��訴����¹�����á "
        "Payment option          "
        "Battery Serial Number   "
        "Battery Year            "
        "Market value price      "
        "Wall Charge Serial Number"
        "Vehicle_Key"
        /* end: A67-0076 */
       SKIP .
    OUTPUT CLOSE.
    
    OUTPUT TO VALUE(fi_kkhold). 
    EXPORT DELIMITER "|" 
        "No.      "
        "Due Date "
        "Aging Issue Policy (�ѹ)"
        "Branch Code"
        "Branch Name"
        "BU         "
        "Insurer    "
        "Product Sub Group"
        "Product Code     "
        "Package Code     "
        "Package Name     "
        "Application Date "
        "Effective Date   "
        "Expired Date     "
        "KK Application No."
        "KK Quotation No.  "
        "Source Uniq ID    "
        "Insurer Application No."
        "Loan Contract No."
        "Notified No.     "
        "Notified Date    "
        "Payer Title Name "
        "Payer Name       "
        "Insured Title Name"
        "Insured Name  "
        "Sum Insure    "
        "Net Premium   "
        "Stamp         "
        "VAT           "
        "Gross Premium "
        "Payment Period"
        "Policy Status "
        "Chassis No.   "
        "KK Offer Flag "
        "Car License No.  "
        "Car License Issue"
        "Policy No. "
        "Remark          "
        "Inspection Remark"
        "Hold problem    "
        "Hold claim flax "
        "Policy status "
        "Premium Policy no."
       SKIP .
    OUTPUT CLOSE.
    
    
    OUTPUT TO VALUE(fi_kkprob ). 
     EXPORT DELIMITER "|"
        "KK_APP_NO"
        "QUOTATION_NO"
        "INSURANCE_COMPANY_CODE"
        "TRANSACTION_DATE"
        "STATUS_DESCRIPTION"
        "REMARK" SKIP.
     OUTPUT CLOSE.
END.
ELSE IF ra_filetyp =4 THEN   DO:
    OUTPUT TO VALUE(fi_kkcom ). 
     EXPORT DELIMITER "|"
        "No.   "     
        "Cancel Date "  
        "Product Sub Group "
        "Product Code"     
        "Package Code"     
        "Package Name"     
        "Insurer     "     
        "KK Application No."
        "KK Quotation No.  "
        "Rider No.         "
        "Insurer Application No.  "
        "Loan Contract No." 
        "Notified No. "  
        "Policy No.   "  
        "Policy Type  "  
        "Application Date " 
        "Policy Approve Date "
        "Effective Date"  
        "Expired Date"  
        "New/Renew "  
        "Policy Status "  
        "Year  "  
        "Sum Insure"  
        "Net Premium "  
        "Stamp "  
        "VAT   "  
        "Gross Premium "  
        "Wht   "  
        "Premium Amount"  
        "Discount Amount "  
        "Actual Premium  "  
        "Pay to Insurer Amount "
        "Premium Receive Type  "
        "Cancel Reason    "
        "Cancel Reason Description"
        "Remark"  
        "Branch Code "  
        "Branch Name "  
        "BU    "  
        "KK Offer Flag" 
        "Insured Card Type " 
        "Insured Card No.  " 
        "Insured Type      " 
        "Insured TitleName " 
        "Insured Name      " 
        "Car License No.   " 
        "Car License Issue " 
        "Car Chassis No.   " 
        "Agent TitleName   " 
        "Agent Name        " 
        "Remark "
        "Policy no" 
        "Release "           SKIP.
     OUTPUT CLOSE.

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_province C-Win 
PROCEDURE proc_province :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A65-0288      
------------------------------------------------------------------------------*/
DO:
    IF INDEX(wdetail.prolice,".") <> 0 THEN REPLACE(wdetail.prolice,".","").
    
    IF wdetail.prolice = "���"  THEN wdetail.prolice = "��".
    ELSE IF index(wdetail.prolice,"��ا෾") <> 0  THEN wdetail.prolice = "��". 
    ELSE DO:
       FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
            brstat.insure.compno = "999" AND 
            brstat.insure.FName  = TRIM(wdetail.prolice) NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN  ASSIGN wdetail.prolice = brstat.Insure.LName.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fn-month C-Win 
FUNCTION fn-month RETURNS CHARACTER
  (ip_month AS INTEGER) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR n_month AS CHAR NO-UNDO INIT "JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC".
    IF ip_month LT 1 OR ip_month GT 12 THEN
        RETURN "".

   RETURN ENTRY(ip_month,n_month).

/*RETURN "". */ /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

